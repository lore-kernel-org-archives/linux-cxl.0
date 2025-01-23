Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F65234
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591960; cv=none; b=HBaVBtMPbYP8MFvRNx0ckGgL1lD736qlt4y2iTKdygKbMtx7YBtiRM+0yutbt3cTsyuQxp9Gx9B0YMuC5eIVibIvZUymLyC0QSFep98Iv2XHWk2CeC2stslPZPLHwBKcr0RMLQD9yoqOg6k/mOJGiuTSPQylXmuTe+V0JWErwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591960; c=relaxed/simple;
	bh=PzYk8HoJ+fScmH+SW0V/L8gtQxHUuCeFVMMKTX4/UqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ij8aR+7FeNQEzUxharrKDzNbMXiBHuPM9QTJbpbV0IKlkWaBx4SCJ7jpnOwc0I26HLr3/Dmu4mGy1XbiUtimjLs3+osPDoap8e1mzB3n8G/f+vAjOHTlIjYJJkX3CqfymWYuEVYbyW8ZF6Km6QeTIM6d8Bj5rvvQyNGLjYaw+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53012C4CED2;
	Thu, 23 Jan 2025 00:26:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH resend 5/5] cxl/test: Add test for cxl features device
Date: Wed, 22 Jan 2025 17:24:54 -0700
Message-ID: <20250123002530.2762440-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123002530.2762440-1-dave.jiang@intel.com>
References: <20250123002530.2762440-1-dave.jiang@intel.com>
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
 test/cxl-features.sh |  19 +++
 test/fwctl.c         | 362 +++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |  17 ++
 3 files changed, 398 insertions(+)
 create mode 100755 test/cxl-features.sh
 create mode 100644 test/fwctl.c

diff --git a/test/cxl-features.sh b/test/cxl-features.sh
new file mode 100755
index 000000000000..e0351028e8fb
--- /dev/null
+++ b/test/cxl-features.sh
@@ -0,0 +1,19 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Intel Corporation. All rights reserved.
+
+rc=77
+
+. $(dirname $0)/common
+FWCTL="$TEST_PATH"/fwctl
+
+trap 'err $LINENO' ERR
+
+#check_min_kver "6.15" || do_skip "may lack CXL features support"
+
+modprobe cxl_test
+
+test -x "$FWCTL" || do_skip "no fwctl"
+"$FWCTL"
+
+_cxl_cleanup
diff --git a/test/fwctl.c b/test/fwctl.c
new file mode 100644
index 000000000000..897c9351750a
--- /dev/null
+++ b/test/fwctl.c
@@ -0,0 +1,362 @@
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
+#define GET_FEAT_SIZE	4
+#define SET_FEAT_SIZE	4
+#define EFFECTS_MASK	(BIT(0) | BIT(9))
+
+#define CMD_TEST_MASK (BIT(CXL_FEATURE_ID_GET_SUPPORTED_FEATURES) | \
+		       BIT(CXL_FEATURE_ID_GET_FEATURE) | \
+		       BIT(CXL_FEATURE_ID_SET_FEATURE))
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
+	struct cxl_mbox_get_feat_in feat_in __attribute__((aligned(16))) = {0};
+	struct fwctl_rpc_cxl in __attribute__((aligned(16))) = {0};
+	struct fwctl_rpc_cxl_out *out;
+	struct fwctl_rpc rpc = {0};
+	size_t out_size;
+	uint32_t val;
+	void *data;
+	int rc;
+
+	uuid_copy(feat_in.uuid, feat_ctx->uuid);
+	feat_in.count = feat_ctx->get_size;
+
+	out_size = sizeof(*out) + feat_in.count;
+	out = aligned_alloc(16, out_size);
+	if (!out)
+		return -ENOMEM;
+
+	memset(out, 0, out_size);
+	data = out->payload;
+
+	in.command_id = CXL_FEATURE_ID_GET_FEATURE;
+	in.op_size = sizeof(feat_in);
+	in.in_payload = (uint64_t)(uint64_t *)&feat_in;
+
+	rpc.size = sizeof(rpc);
+	rpc.scope = FWCTL_RPC_CONFIGURATION;
+	rpc.in_len = sizeof(in);
+	rpc.out_len = out_size;
+	rpc.in = (uint64_t)(uint64_t *)&in;
+	rpc.out = (uint64_t)(uint64_t *)out;
+
+	rc = send_command(fd, &rpc, out);
+	if (rc)
+		goto out;
+
+	val = le32toh(*(__le32 *)data);
+	if (memcmp(&val, &expected_data, sizeof(val)) != 0) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+out:
+	free(out);
+	return rc;
+}
+
+static int cxl_fwctl_rpc_set_test_feature(int fd, struct test_feature *feat_ctx)
+{
+	struct cxl_mbox_set_feat_in *feat_in;
+	struct fwctl_rpc_cxl in __attribute__((aligned(16))) = {0};
+	struct fwctl_rpc_cxl_out out __attribute__((aligned(16))) = {0};
+	struct fwctl_rpc rpc = {0};
+	size_t in_size;
+	uint32_t val;
+	void *data;
+	int rc;
+
+	in_size = sizeof(*feat_in) + sizeof(val);
+	feat_in = aligned_alloc(16, in_size);
+	if (!feat_in)
+		return -ENOMEM;
+
+	memset(feat_in, 0, in_size);
+	uuid_copy(feat_in->hdr.uuid, feat_ctx->uuid);
+	data = feat_in->data;
+	val = DEFAULT_TEST_DATA2;
+	*(uint32_t *)data = htole32(val);
+	feat_in->hdr.flags = CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER;
+
+	in.command_id = CXL_FEATURE_ID_SET_FEATURE;
+	in.op_size = in_size;
+	in.in_payload = (uint64_t)(uint64_t *)feat_in;
+
+	rpc.size = sizeof(rpc);
+	rpc.scope = FWCTL_RPC_DEBUG_WRITE_FULL;
+	rpc.in_len = in_size;
+	rpc.out_len = sizeof(out);
+	rpc.in = (uint64_t)(uint64_t *)&in;
+	rpc.out = (uint64_t)(uint64_t *)&out;
+
+	rc = send_command(fd, &rpc, &out);
+	if (rc)
+		goto out;
+
+	rc = cxl_fwctl_rpc_get_test_feature(fd, feat_ctx, DEFAULT_TEST_DATA2);
+	if (rc) {
+		fprintf(stderr, "Failed ioctl to get feature verify: %d\n", rc);
+		goto out;
+	}
+
+out:
+	free(feat_in);
+	return rc;
+}
+
+static int cxl_fwctl_rpc_get_supported_features(int fd, struct test_feature *feat_ctx)
+{
+	struct cxl_mbox_get_sup_feats_in feat_in __attribute__((aligned(16))) = {0};
+	struct fwctl_rpc_cxl_out out __attribute__((aligned(16))) = {0};
+	struct fwctl_rpc_cxl in __attribute__((aligned(16))) = {0};
+	struct cxl_mbox_get_sup_feats_out *feat_out;
+	struct fwctl_rpc_cxl_out *out2;
+	struct cxl_feat_entry *entry;
+	struct fwctl_rpc rpc = {0};
+	size_t out_size;
+	int feats, rc;
+
+	/* First query, to get number of features w/o per feature data */
+	in.command_id = CXL_FEATURE_ID_GET_SUPPORTED_FEATURES;
+	in.op_size = sizeof(feat_in);
+	in.in_payload = (uint64_t)(uint64_t *)&feat_in;
+
+	rpc.size = sizeof(rpc);
+	rpc.scope = FWCTL_RPC_CONFIGURATION;
+	rpc.in_len = sizeof(in);
+	rpc.out_len = sizeof(out) + sizeof(*feat_out);
+	rpc.in = (uint64_t)(uint64_t *)&in;
+	rpc.out = (uint64_t)(uint64_t *)&out;
+
+	rc = send_command(fd, &rpc, &out);
+	if (rc)
+		return rc;
+
+	feat_out = (struct cxl_mbox_get_sup_feats_out *)&out.payload[0];
+	feats = le16toh(feat_out->supported_feats);
+	if (feats != MAX_TEST_FEATURES) {
+		fprintf(stderr, "Test device has greater than %d test features.\n",
+			MAX_TEST_FEATURES);
+		return -ENXIO;
+	}
+
+	/* Going second round to retrieve each feature details */
+	out_size = sizeof(*out2) + sizeof(*feat_out) + feats * sizeof(*entry);
+	rpc.out_len = out_size;
+	out2 = aligned_alloc(16, out_size);
+	if (!out2)
+		return -ENOMEM;
+
+	memset(out2, 0, out_size);
+	rpc.out = (uint64_t)(uint64_t *)out2;
+	feat_in.count = htole32(feats * sizeof(*entry));
+
+	rc = send_command(fd, &rpc, out2);
+	if (rc)
+		goto out;
+
+	feat_out = (struct cxl_mbox_get_sup_feats_out *)&out2->payload[0];
+	feats = le16toh(feat_out->supported_feats);
+	if (feats != MAX_TEST_FEATURES) {
+		fprintf(stderr, "Test device has greater than %u test features.\n",
+			MAX_TEST_FEATURES);
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (le16toh(feat_out->num_entries) != MAX_TEST_FEATURES) {
+		fprintf(stderr, "Test device did not return expected entries. %u\n",
+			le16toh(feat_out->num_entries));
+		rc = -ENXIO;
+		goto out;
+	}
+
+	entry = &feat_out->ents[0];
+	if (uuid_compare(test_uuid, entry->uuid) != 0) {
+		fprintf(stderr, "Test device did not export expected test feature.\n");
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (le16toh(entry->get_feat_size) != GET_FEAT_SIZE ||
+	    le16toh(entry->set_feat_size) != SET_FEAT_SIZE) {
+		fprintf(stderr, "Test device feature in/out size incorrect.\n");
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (le16toh(entry->effects) != EFFECTS_MASK) {
+		fprintf(stderr, "Test device set effects incorrect\n");
+		rc = -ENXIO;
+		goto out;
+	}
+
+	uuid_copy(feat_ctx->uuid, entry->uuid);
+	feat_ctx->get_size = le16toh(entry->get_feat_size);
+	feat_ctx->set_size = le16toh(entry->set_feat_size);
+
+out:
+	free(out2);
+	return rc;
+}
+
+static int cxl_fwctl_retrieve_info(int fd)
+{
+	struct fwctl_info info = {0};
+	struct fwctl_info_cxl cxl_info __attribute__((aligned(16))) = {0};
+
+	info.size = sizeof(info);
+	info.out_device_type = FWCTL_DEVICE_TYPE_CXL;
+	info.device_data_len = sizeof(cxl_info);
+	info.out_device_data = (uint64_t)(uint64_t *)&cxl_info;
+
+	if (ioctl(fd, FWCTL_INFO, &info) == -1) {
+		fprintf(stderr, "INFO ioctl error: %s\n", strerror(errno));
+		return -errno;
+	}
+
+	if (cxl_info.cmd_mask != CMD_TEST_MASK)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int test_fwctl_feat(struct cxl_features *feat)
+{
+	struct test_feature feat_ctx;
+	int major, minor, fd, rc;
+	char path[256];
+
+	major = cxl_features_get_major(feat);
+	minor = cxl_features_get_minor(feat);
+	sprintf(path, "/dev/char/%d:%d", major, minor);
+
+	fd = open(path, O_RDONLY, 0644);
+	if (!fd) {
+		fprintf(stderr, "Failed to open: %d\n", -errno);
+		return -errno;
+	}
+
+	rc = cxl_fwctl_retrieve_info(fd);
+	if (rc) {
+		fprintf(stderr, "Failed ioctl to retrieve drv info: %d\n", rc);
+		goto out;
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
+	struct cxl_features *feat;
+
+	cxl_features_foreach(ctx, feat) {
+		if (cxl_features_get_bus(feat) != bus)
+			continue;
+		return test_fwctl_feat(feat);
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
+		rc = -ENODEV;
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
index d871e28e17ce..5704bc4659b5 100644
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
@@ -130,6 +137,13 @@ revoke_devmem = executable('revoke_devmem', testcore + [
   include_directories : root_inc,
 )
 
+fwctl = executable('fwctl', testcore + [
+    'fwctl.c',
+  ],
+  dependencies : libcxl_deps,
+  include_directories : root_inc,
+)
+
 mmap = executable('mmap', 'mmap.c',)
 
 create = find_program('create.sh')
@@ -161,6 +175,7 @@ cxl_sanitize = find_program('cxl-sanitize.sh')
 cxl_destroy_region = find_program('cxl-destroy-region.sh')
 cxl_qos_class = find_program('cxl-qos-class.sh')
 cxl_poison = find_program('cxl-poison.sh')
+cxl_features = find_program('cxl-features.sh')
 
 tests = [
   [ 'libndctl',               libndctl,		  'ndctl' ],
@@ -194,6 +209,7 @@ tests = [
   [ 'cxl-destroy-region.sh',  cxl_destroy_region, 'cxl'   ],
   [ 'cxl-qos-class.sh',       cxl_qos_class,      'cxl'   ],
   [ 'cxl-poison.sh',          cxl_poison,         'cxl'   ],
+  [ 'cxl-features.sh',        cxl_features,       'cxl'   ],
 ]
 
 if get_option('destructive').enabled()
@@ -249,6 +265,7 @@ foreach t : tests
       daxdev_errors,
       dax_dev,
       mmap,
+      fwctl,
     ],
     suite: t[2],
     timeout : 600,
-- 
2.47.1

