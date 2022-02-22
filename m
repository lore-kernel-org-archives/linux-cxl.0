Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E2C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Feb 2022 19:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiBVTxI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiBVTxE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Feb 2022 14:53:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402FC5595
        for <linux-cxl@vger.kernel.org>; Tue, 22 Feb 2022 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559558; x=1677095558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ee1UdJrfOmyH51HvJJPxJDtcPSYBf631vBoDQWhI4xA=;
  b=PAp51jnoP2plgSl1BQ58FT2l7gjuOzUXeOx0tvF0GfPr+DEF1Pl+Qikf
   ZVC8Uxlg7DZobVqkoNMWWuSjXvN+KsadsZzQHsCcmL9xAbvW2DnyLJZLS
   abwLMFKTRbrTTCH4tfJ3ExxI8qsG6u5CD+bhjmKU7g3w7cAAoE01ET9TC
   D+JW+0tQvUh9t4lQqCG+mqqnYecNV+x3bO8JzWkngrB21sAsd0WTXSuiQ
   ghlMxhfcghB7akI7ik8Ht8nC9CEI/Z+KN1DLcCpdCsvDAVBVjs84M4j+f
   BA+sKQsRBoVztnXMphfhx+caEwL2lBGjNyEmQ0qossHibr7nRFNKzJT1A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250624967"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250624967"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:52:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="683637821"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:52:38 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v6 6/6] cxl: add command 'cxl set-partition'
Date:   Tue, 22 Feb 2022 11:56:08 -0800
Message-Id: <e7accc7ba93def81b48304cf5fb483345757410d.1645558189.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645558189.git.alison.schofield@intel.com>
References: <cover.1645558189.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices may support both volatile and persistent memory capacity.
The amount of device capacity set aside for each type is typically
established at the factory, but some devices also allow for dynamic
re-partitioning. Add a command for this purpose.

 usage: cxl set-partition <mem0> [<mem1>..<memN>] [<options>]

    -v, --verbose         turn on debug
    -S, --serial          use serial numbers to id memdevs
    -t, --type <type>     'pmem' or 'volatile' (Default: 'pmem')
    -s, --size <size>     size in bytes (Default: all available capacity)
    -a, --align           auto-align --size per device's requirement

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-set-partition.txt |  68 ++++++++
 Documentation/cxl/meson.build           |   1 +
 cxl/builtin.h                           |   1 +
 cxl/cxl.c                               |   1 +
 cxl/memdev.c                            | 206 ++++++++++++++++++++++++
 5 files changed, 277 insertions(+)
 create mode 100644 Documentation/cxl/cxl-set-partition.txt

diff --git a/Documentation/cxl/cxl-set-partition.txt b/Documentation/cxl/cxl-set-partition.txt
new file mode 100644
index 000000000000..1e548af77da2
--- /dev/null
+++ b/Documentation/cxl/cxl-set-partition.txt
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-set-partition(1)
+====================
+
+NAME
+----
+cxl-set-partition - set the partitioning between volatile and persistent capacity on a CXL memdev
+
+SYNOPSIS
+--------
+[verse]
+'cxl set-partition <mem0> [ [<mem1>..<memN>] [<options>]'
+
+DESCRIPTION
+-----------
+CXL devices may support both volatile and persistent memory capacity.
+The amount of device capacity set aside for each type is typically
+established at the factory, but some devices also allow for dynamic
+re-partitioning.
+
+Use this command to partition a device into volatile and persistent
+capacity. The change in partitioning becomes the “next” configuration,
+to become active on the next device reset.
+
+Use "cxl list -m <memdev> -I" to examine the partitioning capabilities
+of a device. A partition_alignment_size value of zero means there is
+no available capacity and therefore the partitions cannot be changed.
+
+Using this command to change the size of the persistent capacity shall
+result in the loss of data stored.
+
+OPTIONS
+-------
+<memory device(s)>::
+include::memdev-option.txt[]
+
+-t::
+--type=::
+	Type of partition, 'pmem' or 'volatile', to modify.
+	Default: 'pmem'
+
+-s::
+--size=::
+	Size of the <type> partition in bytes. Size must align to the
+	devices alignment requirement. Use 'cxl list -m <memdev> -I'
+	to find 'partition_alignment_size', or, use the --align option.
+	Default: All available capacity is assigned to <type>.
+
+-a::
+--align::
+	Select this option to allow the automatic alignment of --size
+	to meet device alignment requirements. When using this option,
+	specify the minimum --size of the --type partition needed. When
+	this option is omitted, the command fails if --size is not
+	properly aligned. Use 'cxl list -m <memdev> -I' to examine the
+	partition_alignment_size.
+
+-v::
+        Turn on verbose debug messages in the library (if libcxl was built with
+        logging and debug enabled).
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-list[1],
+CXL-2.0 8.2.9.5.2
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index 96f4666a828d..e927644a3826 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -34,6 +34,7 @@ cxl_manpages = [
   'cxl-disable-memdev.txt',
   'cxl-enable-port.txt',
   'cxl-disable-port.txt',
+  'cxl-set-partition.txt',
 ]
 
 foreach man : cxl_manpages
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 3123d5e0d4ed..7bbad98f67ac 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -14,4 +14,5 @@ int cmd_disable_memdev(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_memdev(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_port(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_port(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_set_partition(int argc, const char **argv, struct cxl_ctx *ctx);
 #endif /* _CXL_BUILTIN_H_ */
diff --git a/cxl/cxl.c b/cxl/cxl.c
index c20c5693fd2b..ab4bbeccaa76 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -68,6 +68,7 @@ static struct cmd_struct commands[] = {
 	{ "enable-memdev", .c_fn = cmd_enable_memdev },
 	{ "disable-port", .c_fn = cmd_disable_port },
 	{ "enable-port", .c_fn = cmd_enable_port },
+	{ "set-partition", .c_fn = cmd_set_partition },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 90b33e1b4195..91d914db5af6 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -6,11 +6,14 @@
 #include <unistd.h>
 #include <limits.h>
 #include <util/log.h>
+#include <util/json.h>
+#include <util/size.h>
 #include <cxl/libcxl.h>
 #include <util/parse-options.h>
 #include <ccan/minmax/minmax.h>
 #include <ccan/array_size/array_size.h>
 
+#include "json.h"
 #include "filter.h"
 
 struct action_context {
@@ -26,10 +29,18 @@ static struct parameters {
 	bool verbose;
 	bool serial;
 	bool force;
+	bool align;
+	const char *type;
+	const char *size;
 } param;
 
 static struct log_ctx ml;
 
+enum cxl_setpart_type {
+	CXL_SETPART_PMEM,
+	CXL_SETPART_VOLATILE,
+};
+
 #define BASE_OPTIONS() \
 OPT_BOOLEAN('v',"verbose", &param.verbose, "turn on debug"), \
 OPT_BOOLEAN('S', "serial", &param.serial, "use serial numbers to id memdevs")
@@ -51,6 +62,14 @@ OPT_UINTEGER('O', "offset", &param.offset, \
 OPT_BOOLEAN('f', "force", &param.force,                                \
 	    "DANGEROUS: override active memdev safety checks")
 
+#define SET_PARTITION_OPTIONS() \
+OPT_STRING('t', "type",  &param.type, "type",			\
+	"'pmem' or 'volatile' (Default: 'pmem')"),		\
+OPT_STRING('s', "size",  &param.size, "size",			\
+	"size in bytes (Default: all available capacity)"),	\
+OPT_BOOLEAN('a', "align",  &param.align,			\
+	"auto-align --size per device's requirement")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
 	LABEL_OPTIONS(),
@@ -82,6 +101,12 @@ static const struct option enable_options[] = {
 	OPT_END(),
 };
 
+static const struct option set_partition_options[] = {
+	BASE_OPTIONS(),
+	SET_PARTITION_OPTIONS(),
+	OPT_END(),
+};
+
 static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
 {
 	if (!cxl_memdev_is_enabled(memdev))
@@ -209,6 +234,176 @@ out:
 	return rc;
 }
 
+static unsigned long long
+partition_align(const char *devname, enum cxl_setpart_type type,
+		unsigned long long volatile_size, unsigned long long alignment,
+		unsigned long long available)
+{
+	if (IS_ALIGNED(volatile_size, alignment))
+		return volatile_size;
+
+	if (!param.align) {
+		log_err(&ml, "%s: size %lld is not partition aligned %lld\n",
+			devname, volatile_size, alignment);
+		return ULLONG_MAX;
+	}
+
+	/* Align based on partition type to fulfill users size request */
+	if (type == CXL_SETPART_PMEM)
+		volatile_size = ALIGN_DOWN(volatile_size, alignment);
+	else
+		volatile_size = ALIGN(volatile_size, alignment);
+
+	/* Fail if the align pushes size over the available limit. */
+	if (volatile_size > available) {
+		log_err(&ml, "%s: aligned partition size %lld exceeds available size %lld\n",
+			devname, volatile_size, available);
+		volatile_size = ULLONG_MAX;
+	}
+
+	return volatile_size;
+}
+
+static unsigned long long
+param_size_to_volatile_size(const char *devname, enum cxl_setpart_type type,
+		unsigned long long size, unsigned long long available)
+{
+	/* User omits size option. Apply all available capacity to type. */
+	if (size == ULLONG_MAX) {
+		if (type == CXL_SETPART_PMEM)
+			return 0;
+		return available;
+	}
+
+	/* User includes a size option. Apply it to type */
+	if (size > available) {
+		log_err(&ml, "%s: %lld exceeds available capacity %lld\n",
+			devname, size, available);
+			return ULLONG_MAX;
+	}
+	if (type == CXL_SETPART_PMEM)
+		return available - size;
+	return size;
+}
+
+/*
+ * Return the volatile_size to use in the CXL set paritition
+ * command, or ULLONG_MAX if unable to validate the partition
+ * request.
+ */
+static unsigned long long
+validate_partition(struct cxl_memdev *memdev, enum cxl_setpart_type type,
+		unsigned long long size)
+{
+	unsigned long long total_cap, volatile_only, persistent_only;
+	const char *devname = cxl_memdev_get_devname(memdev);
+	unsigned long long volatile_size = ULLONG_MAX;
+	unsigned long long available, alignment;
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cmd = cxl_cmd_new_identify(memdev);
+	if (!cmd)
+		return ULLONG_MAX;
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0)
+		goto out;
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0)
+		goto out;
+
+	alignment = cxl_cmd_identify_get_partition_align(cmd);
+	if (alignment == 0) {
+		log_err(&ml, "%s: no available capacity\n", devname);
+		goto out;
+	}
+
+	/* Calculate the actual available capacity */
+	total_cap = cxl_cmd_identify_get_total_size(cmd);
+	volatile_only = cxl_cmd_identify_get_volatile_only_size(cmd);
+	persistent_only = cxl_cmd_identify_get_persistent_only_size(cmd);
+	available = total_cap - volatile_only - persistent_only;
+
+	/* Translate the users size request into an aligned volatile_size */
+	volatile_size = param_size_to_volatile_size(devname, type, size,
+				available);
+	if (volatile_size == ULLONG_MAX)
+		goto out;
+
+	volatile_size = partition_align(devname, type, volatile_size, alignment,
+				available);
+
+out:
+	cxl_cmd_unref(cmd);
+	return volatile_size;
+}
+
+static int action_setpartition(struct cxl_memdev *memdev,
+		struct action_context *actx)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	enum cxl_setpart_type type = CXL_SETPART_PMEM;
+	unsigned long long size = ULLONG_MAX;
+	struct json_object *jmemdev;
+	struct cxl_cmd *cmd;
+	int rc;
+
+	if (param.type) {
+		if (strcmp(param.type, "pmem") == 0)
+			/* default */;
+		else if (strcmp(param.type, "volatile") == 0)
+			type = CXL_SETPART_VOLATILE;
+		else {
+			log_err(&ml, "invalid type '%s'\n", param.type);
+			return -EINVAL;
+		}
+	}
+
+	if (param.size) {
+		size = parse_size64(param.size);
+		if (size == ULLONG_MAX) {
+			log_err(&ml, "%s: failed to parse size option '%s'\n",
+			devname, param.size);
+			return -EINVAL;
+		}
+	}
+
+	size = validate_partition(memdev, type, size);
+	if (size == ULLONG_MAX)
+		return -EINVAL;
+
+	cmd = cxl_cmd_new_set_partition(memdev, size);
+	if (!cmd) {
+		rc = -ENXIO;
+		goto out_err;
+	}
+
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0) {
+		log_err(&ml, "cmd submission failed: %s\n", strerror(-rc));
+		goto out_cmd;
+	}
+
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0) {
+		log_err(&ml, "%s: mbox status: %d\n", __func__, rc);
+		rc = -ENXIO;
+	}
+
+out_cmd:
+	cxl_cmd_unref(cmd);
+out_err:
+	if (rc)
+		log_err(&ml, "%s error: %s\n", devname, strerror(-rc));
+
+	jmemdev = util_cxl_memdev_to_json(memdev, UTIL_JSON_PARTITION);
+	if (jmemdev)
+		printf("%s\n", json_object_to_json_string_ext(jmemdev,
+		       JSON_C_TO_STRING_PRETTY));
+
+	return rc;
+}
+
 static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 			 int (*action)(struct cxl_memdev *memdev,
 				       struct action_context *actx),
@@ -398,3 +593,14 @@ int cmd_enable_memdev(int argc, const char **argv, struct cxl_ctx *ctx)
 		 count > 1 ? "s" : "");
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_set_partition(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(argc, argv, ctx, action_setpartition,
+			set_partition_options,
+			"cxl set-partition <mem0> [<mem1>..<memN>] [<options>]");
+	log_info(&ml, "set_partition %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.31.1

