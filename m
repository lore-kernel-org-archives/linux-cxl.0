Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB81C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jan 2022 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiACULg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jan 2022 15:11:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:35284 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbiACULe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641240694; x=1672776694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+bwgu36dEz5dCKX+coXfMMxj8XYHQrsU2sib4nNa93A=;
  b=YS5hd0IxU9y0J+XWqo0R/JBMB1UYEQ/FpDO7dIOh/OwjslC6HJx9EwwQ
   U3OZrKPJFZdr0UHrISS0tLreKmfcOFc9gtDLmTI8P3QMWhlc1w0AZdmFh
   HAqHOm1z834Zyq28ArKxhKiaPS7y7oSNFqAzmRAy54A3cd9+5PRK6i9gr
   Ai2Mi8CyibeZj8d5q/OD3Wk7Vk7CO/DB8ClJw7VlI1406RGomAWCaYeVF
   xiI+AG/YVP34ICKOWIu8L/fvt141JDiuJHF6Pxl+LbajaMdc0asP4nsRX
   bPDHWPYWK7KAbKX9fAiMHCP/N+80dG9MwynRbbPc4aZRdWiF/SKDUlscI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222105781"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222105781"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="525709412"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 7/7] cxl: add command set-partition-info
Date:   Mon,  3 Jan 2022 12:16:18 -0800
Message-Id: <fd590fbbc2f1abaeca1fd368d26c4e90c3a89d69.1641233076.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641233076.git.alison.schofield@intel.com>
References: <cover.1641233076.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The command 'cxl set-partition-info' operates on a CXL memdev,
or a set of memdevs, allowing the user to change the partition
layout of the device.

Synopsis:
Usage: cxl set-partition-info <mem0> [<mem1>..<memN>] [<options>]

    -v, --verbose         turn on debug
    -s, --volatile_size <n>
                          next volatile partition size in bytes

The MAN page explains how to find partitioning capabilities and
restrictions.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/cxl/cxl-set-partition-info.txt | 27 ++++++
 Documentation/cxl/partition-description.txt  | 15 ++++
 Documentation/cxl/partition-options.txt      | 19 +++++
 Documentation/cxl/Makefile.am                |  3 +-
 cxl/builtin.h                                |  1 +
 cxl/cxl.c                                    |  1 +
 cxl/memdev.c                                 | 89 ++++++++++++++++++++
 7 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/cxl/cxl-set-partition-info.txt
 create mode 100644 Documentation/cxl/partition-description.txt
 create mode 100644 Documentation/cxl/partition-options.txt

diff --git a/Documentation/cxl/cxl-set-partition-info.txt b/Documentation/cxl/cxl-set-partition-info.txt
new file mode 100644
index 0000000..32418b6
--- /dev/null
+++ b/Documentation/cxl/cxl-set-partition-info.txt
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-set-partition-info(1)
+=========================
+
+NAME
+----
+cxl-set-partition-info - set the partitioning between volatile and persistent capacity on a CXL memdev
+
+SYNOPSIS
+--------
+[verse]
+'cxl set-partition-info <mem> [ [<mem1>..<memN>] [<options>]'
+
+include::partition-description.txt[]
+Partition the device on the next device reset using the volatile capacity
+requested. Using this command to change the size of the persistent capacity
+shall result in the loss of stored data.
+
+OPTIONS
+-------
+include::partition-options.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-list[1],
+CXL-2.0 8.2.9.5.2
diff --git a/Documentation/cxl/partition-description.txt b/Documentation/cxl/partition-description.txt
new file mode 100644
index 0000000..b3efac8
--- /dev/null
+++ b/Documentation/cxl/partition-description.txt
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+DESCRIPTION
+-----------
+Partition the device into volatile and persistent capacity. The change
+in partitioning will become the “next” configuration, to become active
+on the next device reset.
+
+Use "cxl list -m <memdev> -P" to examine the partition capacities
+supported on a device. Paritionable capacity must exist on the
+device. A partition_alignment of zero means no partitionable
+capacity is available.
+
+Using this command to change the size of the persistent capacity shall
+result in the loss of data stored.
diff --git a/Documentation/cxl/partition-options.txt b/Documentation/cxl/partition-options.txt
new file mode 100644
index 0000000..84e49c9
--- /dev/null
+++ b/Documentation/cxl/partition-options.txt
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+<memory device(s)>::
+include::memdev-option.txt[]
+
+-s::
+--size=::
+	Size in bytes of the volatile partition requested.
+
+	Size must align to the devices partition_alignment.
+	Use 'cxl list -m <memdev> -P' to find partition_alignment.
+
+	Size must be less than or equal to the devices partitionable bytes.
+	(total_capacity - volatile_only_capacity - persistent_only_capacity)
+	Use 'cxl list -m <memdev> -P' to find *_capacity values.
+
+-v::
+	Turn on verbose debug messages in the library (if libcxl was built with
+	logging and debug enabled).
diff --git a/Documentation/cxl/Makefile.am b/Documentation/cxl/Makefile.am
index efabaa3..c5faf04 100644
--- a/Documentation/cxl/Makefile.am
+++ b/Documentation/cxl/Makefile.am
@@ -22,7 +22,8 @@ man1_MANS = \
 	cxl-list.1 \
 	cxl-read-labels.1 \
 	cxl-write-labels.1 \
-	cxl-zero-labels.1
+	cxl-zero-labels.1 \
+	cxl-set-partition-info.1
 
 EXTRA_DIST = $(man1_MANS)
 
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 78eca6e..7f11f28 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -10,4 +10,5 @@ int cmd_read_labels(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_zero_labels(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_init_labels(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_check_labels(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_set_partition_info(int argc, const char **argv, struct cxl_ctx *ctx);
 #endif /* _CXL_BUILTIN_H_ */
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 4b1661d..3153cf0 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -64,6 +64,7 @@ static struct cmd_struct commands[] = {
 	{ "zero-labels", .c_fn = cmd_zero_labels },
 	{ "read-labels", .c_fn = cmd_read_labels },
 	{ "write-labels", .c_fn = cmd_write_labels },
+	{ "set-partition-info", .c_fn = cmd_set_partition_info },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 5ee38e5..fa63317 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -6,6 +6,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include <util/log.h>
+#include <util/size.h>
 #include <util/filter.h>
 #include <cxl/libcxl.h>
 #include <util/parse-options.h>
@@ -23,6 +24,7 @@ static struct parameters {
 	unsigned len;
 	unsigned offset;
 	bool verbose;
+	unsigned long long volatile_size;
 } param;
 
 #define fail(fmt, ...) \
@@ -47,6 +49,10 @@ OPT_UINTEGER('s', "size", &param.len, "number of label bytes to operate"), \
 OPT_UINTEGER('O', "offset", &param.offset, \
 	"offset into the label area to start operation")
 
+#define SET_PARTITION_OPTIONS() \
+OPT_U64('s', "volatile_size",  &param.volatile_size, \
+	"next volatile partition size in bytes")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
 	LABEL_OPTIONS(),
@@ -67,6 +73,12 @@ static const struct option zero_options[] = {
 	OPT_END(),
 };
 
+static const struct option set_partition_options[] = {
+	BASE_OPTIONS(),
+	SET_PARTITION_OPTIONS(),
+	OPT_END(),
+};
+
 static int action_zero(struct cxl_memdev *memdev, struct action_context *actx)
 {
 	size_t size;
@@ -174,6 +186,73 @@ out:
 	return rc;
 }
 
+static int validate_partition(struct cxl_memdev *memdev,
+		unsigned long long volatile_request)
+{
+	unsigned long long total_cap, volatile_only, persistent_only;
+	unsigned long long partitionable_bytes, partition_align_bytes;
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cmd = cxl_cmd_new_identify(memdev);
+	if (!cmd)
+		return -ENXIO;
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0)
+		goto err;
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0)
+		goto err;
+
+	partition_align_bytes = cxl_cmd_identify_get_partition_align(cmd);
+	if (partition_align_bytes == 0) {
+		fprintf(stderr, "%s: no partitionable capacity\n", devname);
+		rc = -EINVAL;
+		goto err;
+	}
+
+	total_cap = cxl_cmd_identify_get_total_capacity(cmd);
+	volatile_only = cxl_cmd_identify_get_volatile_only_capacity(cmd);
+	persistent_only = cxl_cmd_identify_get_persistent_only_capacity(cmd);
+
+	partitionable_bytes = total_cap - volatile_only - persistent_only;
+
+	if (volatile_request > partitionable_bytes) {
+		fprintf(stderr, "%s: volatile size %lld exceeds partitionable capacity %lld\n",
+			devname, volatile_request, partitionable_bytes);
+		rc = -EINVAL;
+		goto err;
+	}
+	if (!IS_ALIGNED(volatile_request, partition_align_bytes)) {
+		fprintf(stderr, "%s: volatile size %lld is not partition aligned %lld\n",
+			devname, volatile_request, partition_align_bytes);
+		rc = -EINVAL;
+	}
+err:
+	cxl_cmd_unref(cmd);
+	return rc;
+}
+
+static int action_set_partition(struct cxl_memdev *memdev,
+		struct action_context *actx)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	unsigned long long volatile_request;
+	int rc;
+
+	volatile_request = param.volatile_size;
+
+	rc = validate_partition(memdev, volatile_request);
+	if (rc)
+		return rc;
+
+	rc = cxl_memdev_set_partition_info(memdev, volatile_request, 0);
+	if (rc)
+		fprintf(stderr, "%s error: %s\n", devname, strerror(-rc));
+	return rc;
+}
+
 static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 		int (*action)(struct cxl_memdev *memdev, struct action_context *actx),
 		const struct option *options, const char *usage)
@@ -322,3 +401,13 @@ int cmd_zero_labels(int argc, const char **argv, struct cxl_ctx *ctx)
 			count > 1 ? "s" : "");
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_set_partition_info(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(argc, argv, ctx, action_set_partition,
+			set_partition_options,
+			"cxl set-partition-info <mem0> [<mem1>..<memN>] [<options>]");
+	fprintf(stderr, "set_partition %d mem%s\n", count >= 0 ? count : 0,
+			count > 1 ? "s" : "");
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.31.1

