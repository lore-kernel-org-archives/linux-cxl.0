Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B416F8E5
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919683; cv=none; b=JjTyIxo/FLkAyizBTSPjuUI+ka4CrPUIifF+q5ivsxKorPLNa/bZJa+F34e+66xJMKEqjkjI251M9DvqJysTkP7YjFp9DuNZZpURSlm7VXSWDWGABXq0WDOP9HSpR9reEYOWZjRN6blK+6WbOwXH3MSgjCmI4euhjHhHqFBnY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919683; c=relaxed/simple;
	bh=DntL0xmzynbTxzNZkKU+Z5tz08BUCIrHtVXDy2S1Rho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ej+5LA/+snLnw8SQKqJqy2XT/rMZrCNIbzbDy6fn4E9wgebifnY2W6OhIc81h+hDB9Gc990su9o2B0AE2SjXmMdTno5ba4Pkn6mQlDCn6IFjPQVcMpuunnlr4lzlADSvTMRISopO8RUKCyCxJlxRNEEW6YKaa6+241BUR2WMRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784D4C4CEE2;
	Tue, 18 Feb 2025 23:01:22 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH v4 3/3] cxl/test: Add test for cxl features device
Date: Tue, 18 Feb 2025 15:59:56 -0700
Message-ID: <20250218230116.2689627-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218230116.2689627-1-dave.jiang@intel.com>
References: <20250218230116.2689627-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a unit test to verify the features ioctl commands. Test support added
for locating a features device, retrieve and verify the supported features
commands, retrieve specific feature command data, retrieve test feature
data, and write and verify test feature data.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Adjust for kernel changes of input/out data structures
- Setup test script to error out if not -ENODEV
- Remove kernel 6.15 check
---
 test/cxl-features.sh |  31 ++++
 test/fwctl.c         | 383 +++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |  45 +++++
 3 files changed, 459 insertions(+)
 create mode 100755 test/cxl-features.sh
 create mode 100644 test/fwctl.c

diff --git a/test/cxl-features.sh b/test/cxl-features.sh
new file mode 100755
index 000000000000..8e44a5bcc3e5
--- /dev/null
+++ b/test/cxl-features.sh
@@ -0,0 +1,31 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Intel Corporation. All rights reserved.
+
+rc=77
+# 237 is -ENODEV
+ERR_NODEV=237
+
+. $(dirname $0)/common
+FWCTL="$TEST_PATH"/fwctl
+
+trap 'err $LINENO' ERR
+
+modprobe cxl_test
+
+test -x "$FWCTL" || do_skip "no fwctl"
+# disable trap
+trap - $(compgen -A signal)
+"$FWCTL"
+rc=$?
+
+echo "error: $rc"
+if [ "$rc" -eq "$ERR_NODEV" ]; then
+	do_skip "no fwctl char dev"
+elif [ "$rc" -ne 0 ]; then
+	echo "fail: $LINENO" && exit 1
+fi
+
+trap 'err $LINENO' ERR
+
+_cxl_cleanup
diff --git a/test/fwctl.c b/test/fwctl.c
new file mode 100644
index 000000000000..ca39e30f6dca
--- /dev/null
+++ b/test/fwctl.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024-2025 Intel Corporation. All rights reserved.
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <endian.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <syslog.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <cxl/libcxl.h>
+#include <cxl/features.h>
+#include <fwctl/fwctl.h>
+#include <fwctl/cxl.h>
+#include <linux/uuid.h>
+#include <uuid/uuid.h>
+#include <util/bitmap.h>
+
+static const char provider[] = "cxl_test";
+
+UUID_DEFINE(test_uuid,
+	    0xff, 0xff, 0xff, 0xff,
+	    0xff, 0xff,
+	    0xff, 0xff,
+	    0xff, 0xff,
+	    0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+);
+
+#define CXL_MBOX_OPCODE_GET_SUPPORTED_FEATURES	0x0500
+#define CXL_MBOX_OPCODE_GET_FEATURE		0x0501
+#define CXL_MBOX_OPCODE_SET_FEATURE		0x0502
+
+#define GET_FEAT_SIZE	4
+#define SET_FEAT_SIZE	4
+#define EFFECTS_MASK	(BIT(0) | BIT(9))
+
+#define MAX_TEST_FEATURES	1
+#define DEFAULT_TEST_DATA	0xdeadbeef
+#define DEFAULT_TEST_DATA2	0xabcdabcd
+
+struct test_feature {
+	uuid_t uuid;
+	size_t get_size;
+	size_t set_size;
+};
+
+static int send_command(int fd, struct fwctl_rpc *rpc, struct fwctl_rpc_cxl_out *out)
+{
+	if (ioctl(fd, FWCTL_RPC, rpc) == -1) {
+		fprintf(stderr, "RPC ioctl error: %s\n", strerror(errno));
+		return -errno;
+	}
+
+	if (out->retval) {
+		fprintf(stderr, "operation returned failure: %d\n", out->retval);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int cxl_fwctl_rpc_get_test_feature(int fd, struct test_feature *feat_ctx,
+					  const uint32_t expected_data)
+{
+	struct cxl_mbox_get_feat_in *feat_in;
+	struct fwctl_rpc_cxl_out *out;
+	struct fwctl_rpc rpc = {0};
+	struct fwctl_rpc_cxl *in;
+	size_t out_size, in_size;
+	uint32_t val;
+	void *data;
+	int rc;
+
+	in_size = sizeof(*in) + sizeof(*feat_in);
+	rc = posix_memalign((void **)&in, 16, in_size);
+	if (rc)
+		return -ENOMEM;
+	memset(in, 0, in_size);
+	feat_in = &in->get_feat_in;
+
+	uuid_copy(feat_in->uuid, feat_ctx->uuid);
+	feat_in->count = feat_ctx->get_size;
+
+	out_size = sizeof(*out) + feat_ctx->get_size;
+	rc = posix_memalign((void **)&out, 16, out_size);
+	if (rc)
+		goto free_in;
+	memset(out, 0, out_size);
+
+	in->opcode = CXL_MBOX_OPCODE_GET_FEATURE;
+	in->op_size = sizeof(*feat_in);
+
+	rpc.size = sizeof(rpc);
+	rpc.scope = FWCTL_RPC_CONFIGURATION;
+	rpc.in_len = in_size;
+	rpc.out_len = out_size;
+	rpc.in = (uint64_t)(uint64_t *)in;
+	rpc.out = (uint64_t)(uint64_t *)out;
+
+	rc = send_command(fd, &rpc, out);
+	if (rc)
+		goto free_all;
+
+	data = out->payload;
+	val = le32toh(*(__le32 *)data);
+	if (memcmp(&val, &expected_data, sizeof(val)) != 0) {
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+free_all:
+	free(out);
+free_in:
+	free(in);
+	return rc;
+}
+
+static int cxl_fwctl_rpc_set_test_feature(int fd, struct test_feature *feat_ctx)
+{
+	struct cxl_mbox_set_feat_in *feat_in;
+	struct fwctl_rpc_cxl_out *out;
+	struct fwctl_rpc_cxl *in;
+	struct fwctl_rpc rpc = {0};
+	size_t in_size, out_size;
+	uint32_t val;
+	void *data;
+	int rc;
+
+	in_size = sizeof(*in) + sizeof(*feat_in) + sizeof(val);
+	rc = posix_memalign((void **)&in, 16, in_size);
+	if (rc)
+		return -ENOMEM;
+	memset(in, 0, in_size);
+	feat_in = &in->set_feat_in;
+
+	out_size = sizeof(*out) + sizeof(val);
+	rc = posix_memalign((void **)&out, 16, out_size);
+	if (rc)
+		goto free_in;
+
+	uuid_copy(feat_in->uuid, feat_ctx->uuid);
+	data = feat_in->feat_data;
+	val = DEFAULT_TEST_DATA2;
+	*(uint32_t *)data = htole32(val);
+	feat_in->flags = CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER;
+
+	in->opcode = CXL_MBOX_OPCODE_SET_FEATURE;
+	in->op_size = sizeof(*feat_in) + sizeof(val);
+
+	rpc.size = sizeof(rpc);
+	rpc.scope = FWCTL_RPC_DEBUG_WRITE_FULL;
+	rpc.in_len = in_size;
+	rpc.out_len = out_size;
+	rpc.in = (uint64_t)(uint64_t *)in;
+	rpc.out = (uint64_t)(uint64_t *)out;
+
+	rc = send_command(fd, &rpc, out);
+	if (rc)
+		goto free_all;
+
+	rc = cxl_fwctl_rpc_get_test_feature(fd, feat_ctx, DEFAULT_TEST_DATA2);
+	if (rc) {
+		fprintf(stderr, "Failed ioctl to get feature verify: %d\n", rc);
+		goto free_all;
+	}
+
+free_all:
+	free(out);
+free_in:
+	free(in);
+	return rc;
+}
+
+static int cxl_fwctl_rpc_get_supported_features(int fd, struct test_feature *feat_ctx)
+{
+	struct cxl_mbox_get_sup_feats_out *feat_out;
+	struct cxl_mbox_get_sup_feats_in *feat_in;
+	struct fwctl_rpc_cxl_out *out;
+	struct fwctl_rpc_cxl *in;
+	struct cxl_feat_entry *entry;
+	struct fwctl_rpc rpc = {0};
+	size_t out_size, in_size;
+	int feats, rc;
+
+	in_size = sizeof(*in) + sizeof(*feat_in);
+	rc = posix_memalign((void **)&in, 16, in_size);
+	if (rc)
+		return rc;
+	memset(in, 0, in_size);
+	/* First query, to get number of features w/o per feature data */
+	in->opcode = CXL_MBOX_OPCODE_GET_SUPPORTED_FEATURES;
+	in->op_size = sizeof(*feat_in);
+
+	out_size = sizeof(*out) + sizeof(*feat_out);
+	rc = posix_memalign((void **)&out, 16, out_size);
+	if (rc)
+		goto free_in;
+
+	/* No need to fill in feat_in first go as we are passing in all 0's */
+
+	rpc.size = sizeof(rpc);
+	rpc.scope = FWCTL_RPC_CONFIGURATION;
+	rpc.in_len = in_size;
+	rpc.out_len = out_size;
+	rpc.in = (uint64_t)(uint64_t *)in;
+	rpc.out = (uint64_t)(uint64_t *)out;
+
+	rc = send_command(fd, &rpc, out);
+	if (rc)
+		goto free_all;
+
+	feat_out = &out->get_sup_feats_out;
+	feats = le16toh(feat_out->supported_feats);
+	if (feats != MAX_TEST_FEATURES) {
+		fprintf(stderr, "Test device has greater than %d test features.\n",
+			MAX_TEST_FEATURES);
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+	free(in);
+	free(out);
+
+	/* Going second round to retrieve each feature details */
+	in_size += feats * sizeof(*entry);
+	rc = posix_memalign((void **)&in, 16, in_size);
+	if (rc)
+		return rc;
+	memset(in, 0, in_size);
+	in->opcode = CXL_MBOX_OPCODE_GET_SUPPORTED_FEATURES;
+	in->op_size = sizeof(*feat_in);
+
+	out_size += feats * sizeof(*entry);
+	rpc.out_len = out_size;
+	rc = posix_memalign((void **)&out, 16, out_size);
+	if (rc)
+		goto free_in;
+	memset(out, 0, out_size);
+
+	feat_in = &in->get_sup_feats_in;
+
+	rpc.out = (uint64_t)(uint64_t *)out;
+	rpc.out_len = out_size;
+	rpc.in = (uint64_t)(uint64_t *)in;
+	rpc.in_len = in_size;
+	feat_in->count = htole32(feats * sizeof(*entry));
+
+	rc = send_command(fd, &rpc, out);
+	if (rc)
+		goto free_all;
+
+	feat_out = &out->get_sup_feats_out;
+	feats = le16toh(feat_out->supported_feats);
+	if (feats != MAX_TEST_FEATURES) {
+		fprintf(stderr, "Test device has greater than %u test features.\n",
+			MAX_TEST_FEATURES);
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+	if (le16toh(feat_out->num_entries) != MAX_TEST_FEATURES) {
+		fprintf(stderr, "Test device did not return expected entries. %u\n",
+			le16toh(feat_out->num_entries));
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+	entry = &feat_out->ents[0];
+	if (uuid_compare(test_uuid, entry->uuid) != 0) {
+		fprintf(stderr, "Test device did not export expected test feature.\n");
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+	if (le16toh(entry->get_feat_size) != GET_FEAT_SIZE ||
+	    le16toh(entry->set_feat_size) != SET_FEAT_SIZE) {
+		fprintf(stderr, "Test device feature in/out size incorrect.\n");
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+	if (le16toh(entry->effects) != EFFECTS_MASK) {
+		fprintf(stderr, "Test device set effects incorrect\n");
+		rc = -ENXIO;
+		goto free_all;
+	}
+
+	uuid_copy(feat_ctx->uuid, entry->uuid);
+	feat_ctx->get_size = le16toh(entry->get_feat_size);
+	feat_ctx->set_size = le16toh(entry->set_feat_size);
+
+free_all:
+	free(out);
+free_in:
+	free(in);
+	return rc;
+}
+
+static int test_fwctl_features(struct cxl_memdev *memdev)
+{
+	struct test_feature feat_ctx;
+	unsigned int major, minor;
+	int fd, rc;
+	char path[256];
+
+	major = cxl_memdev_get_fwctl_major(memdev);
+	minor = cxl_memdev_get_fwctl_minor(memdev);
+
+	if (!major && !minor)
+		return -ENODEV;
+
+	sprintf(path, "/dev/char/%d:%d", major, minor);
+
+	fd = open(path, O_RDONLY, 0644);
+	if (!fd) {
+		fprintf(stderr, "Failed to open: %d\n", -errno);
+		return -errno;
+	}
+
+	rc = cxl_fwctl_rpc_get_supported_features(fd, &feat_ctx);
+	if (rc) {
+		fprintf(stderr, "Failed ioctl to get supported features: %d\n", rc);
+		goto out;
+	}
+
+	rc = cxl_fwctl_rpc_get_test_feature(fd, &feat_ctx, DEFAULT_TEST_DATA);
+	if (rc) {
+		fprintf(stderr, "Failed ioctl to get feature: %d\n", rc);
+		goto out;
+	}
+
+	rc = cxl_fwctl_rpc_set_test_feature(fd, &feat_ctx);
+	if (rc) {
+		fprintf(stderr, "Failed ioctl to set feature: %d\n", rc);
+		goto out;
+	}
+
+out:
+	close(fd);
+	return rc;
+}
+
+static int test_fwctl(struct cxl_ctx *ctx, struct cxl_bus *bus)
+{
+	struct cxl_memdev *memdev;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		if (cxl_memdev_get_bus(memdev) != bus)
+			continue;
+		return test_fwctl_features(memdev);
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct cxl_ctx *ctx;
+	struct cxl_bus *bus;
+	int rc;
+
+	rc = cxl_new(&ctx);
+	if (rc < 0)
+		return rc;
+
+	cxl_set_log_priority(ctx, LOG_DEBUG);
+
+	bus = cxl_bus_get_by_provider(ctx, provider);
+	if (!bus) {
+		fprintf(stderr, "%s: unable to find bus (%s)\n",
+			argv[0], provider);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = test_fwctl(ctx, bus);
+
+out:
+	cxl_unref(ctx);
+	return rc;
+}
diff --git a/test/meson.build b/test/meson.build
index d871e28e17ce..476f4ba6c97c 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -17,6 +17,13 @@ ndctl_deps = libndctl_deps + [
   versiondep,
 ]
 
+libcxl_deps = [
+  cxl_dep,
+  ndctl_dep,
+  uuid,
+  kmod,
+]
+
 libndctl = executable('libndctl', testcore + [ 'libndctl.c'],
   dependencies : libndctl_deps,
   include_directories : root_inc,
@@ -130,6 +137,33 @@ revoke_devmem = executable('revoke_devmem', testcore + [
   include_directories : root_inc,
 )
 
+fs = import('fs')
+
+feature_hdrs = [
+  '/usr/include/cxl/features.h',
+  '/usr/include/fwctl/cxl.h',
+  '/usr/include/fwctl/fwctl.h',
+]
+
+feat_hdrs_exist = true
+foreach file : feature_hdrs
+  if not fs.exists(file)
+    feat_hdrs_exist = false
+    break
+  endif
+endforeach
+
+if feat_hdrs_exist
+    fwctl = executable('fwctl', [
+        'fwctl.c',
+    ],
+    include_directories : root_inc,
+    dependencies : libcxl_deps,
+    )
+else
+    fwctl = []
+endif
+
 mmap = executable('mmap', 'mmap.c',)
 
 create = find_program('create.sh')
@@ -162,6 +196,10 @@ cxl_destroy_region = find_program('cxl-destroy-region.sh')
 cxl_qos_class = find_program('cxl-qos-class.sh')
 cxl_poison = find_program('cxl-poison.sh')
 
+if feat_hdrs_exist
+  cxl_features = find_program('cxl-features.sh')
+endif
+
 tests = [
   [ 'libndctl',               libndctl,		  'ndctl' ],
   [ 'dsm-fail',               dsm_fail,	      	  'ndctl' ],
@@ -196,6 +234,12 @@ tests = [
   [ 'cxl-poison.sh',          cxl_poison,         'cxl'   ],
 ]
 
+if feat_hdrs_exist
+  tests += [
+    [ 'cxl-features.sh',        cxl_features,       'cxl'   ],
+  ]
+endif
+
 if get_option('destructive').enabled()
   sub_section = find_program('sub-section.sh')
   dax_ext4 = find_program('dax-ext4.sh')
@@ -249,6 +293,7 @@ foreach t : tests
       daxdev_errors,
       dax_dev,
       mmap,
+      fwctl,
     ],
     suite: t[2],
     timeout : 600,
-- 
2.48.1

