Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B6CC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Feb 2022 02:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiBJCFx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiBJCFR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 21:05:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECB25DDF
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 18:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644458474; x=1675994474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29cuZLvmKBnAIeASl5MGw94rvlTi7I21Qwdugl5wVpw=;
  b=MpDUqL10q4cCKjHWFkEaUHs75U/b+FpCGIrvuDlZnw2BsCJ2MleZxNLY
   7ZdPR5NSnvfsbsz0kyq55e/+QUyYSJaogIxVvTFXBgJANMwwR0vbHJUP6
   LGXjWEdDcfiCMLSHrwL0RdPc2/QZxhRdyDYoQK+PS77ZXO+nvgH2rzpkk
   8jomKHsUhlhhSHRkZpNBvY5gvVMEdu7IFP3dmY0Suh6V4v2ms/gXwthCX
   4q/O43u64nPlgytOrjlyGqUk8tOIEZI8TsuAt/B/JDGnu37n2VoUnAt4u
   b2riud1b13CX+R2zNT0kaU1l2SHTBx2V5ilUr+APd86vbBHRXhMNjQkJb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232952533"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="232952533"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:01:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="585799481"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:01:12 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v5 1/6] libcxl: add GET_PARTITION_INFO mailbox command and accessors
Date:   Wed,  9 Feb 2022 18:05:09 -0800
Message-Id: <6cd7fffe1a95c9a1bc2239cb342067df564401a5.1644455619.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644455619.git.alison.schofield@intel.com>
References: <cover.1644455619.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The CXL PMEM provisioning model depends upon the values reported
in the CXL GET_PARTITION_INFO mailbox command when changing the
partitioning between volatile and persistent capacity.

Add libcxl APIs to create a new GET_PARTITION_INFO mailbox command,
the command output data structure (privately), and accessor APIs to
return the fields in the partition info output.

Per the CXL 2.0 specification, devices report partition capacities
as multiples of 256MB. Define and use a capacity multiplier to
convert the raw data into bytes for user consumption. Use byte
format as the norm for all capacity values produced or consumed
using CXL Mailbox commands.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/lib/libcxl.txt |  1 +
 cxl/lib/libcxl.c                 | 66 ++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  5 +++
 cxl/lib/private.h                | 10 +++++
 cxl/libcxl.h                     |  5 +++
 util/size.h                      |  1 +
 6 files changed, 88 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 4392b47..a6986ab 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -131,6 +131,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			  size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			   size_t offset);
+struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
 
 ----
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e0b443f..4557a71 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1985,6 +1985,11 @@ static int cxl_cmd_validate_status(struct cxl_cmd *cmd, u32 id)
 	return 0;
 }
 
+static uint64_t cxl_capacity_to_bytes(leint64_t size)
+{
+	return le64_to_cpu(size) * CXL_CAPACITY_MULTIPLIER;
+}
+
 /* Helpers for health_info fields (no endian conversion) */
 #define cmd_get_field_u8(cmd, n, N, field)				\
 do {									\
@@ -2371,6 +2376,67 @@ CXL_EXPORT ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd,
 	return length;
 }
 
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev,
+				   CXL_MEM_COMMAND_ID_GET_PARTITION_INFO);
+}
+
+static struct cxl_cmd_get_partition *
+cmd_to_get_partition(struct cxl_cmd *cmd)
+{
+	if (cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_GET_PARTITION_INFO))
+		return NULL;
+
+	if (!cmd)
+		return NULL;
+	return cmd->output_payload;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_active_volatile_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->active_volatile);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_active_persistent_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->active_persistent);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->next_volatile);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_get_partition *c;
+
+	c = cmd_to_get_partition(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->next_persistent);
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index e56a2bf..509e62d 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -155,4 +155,9 @@ global:
 	cxl_dport_get_port;
 	cxl_port_get_dport_by_memdev;
 	cxl_dport_maps_memdev;
+	cxl_cmd_new_get_partition;
+	cxl_cmd_partition_get_active_volatile_size;
+	cxl_cmd_partition_get_active_persistent_size;
+	cxl_cmd_partition_get_next_volatile_size;
+	cxl_cmd_partition_get_next_persistent_size;
 } LIBCXL_1;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index f483c30..7f3a562 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -7,6 +7,7 @@
 #include <cxl/cxl_mem.h>
 #include <ccan/endian/endian.h>
 #include <ccan/short_types/short_types.h>
+#include <util/size.h>
 
 #define CXL_EXPORT __attribute__ ((visibility("default")))
 
@@ -185,6 +186,15 @@ struct cxl_cmd_get_health_info {
 	le32 pmem_errors;
 } __attribute__((packed));
 
+struct cxl_cmd_get_partition {
+	le64 active_volatile;
+	le64 active_persistent;
+	le64 next_volatile;
+	le64 next_persistent;
+} __attribute__((packed));
+
+#define CXL_CAPACITY_MULTIPLIER		SZ_256M
+
 /* CXL 2.0 8.2.9.5.3 Byte 0 Health Status */
 #define CXL_CMD_HEALTH_INFO_STATUS_MAINTENANCE_NEEDED_MASK		BIT(0)
 #define CXL_CMD_HEALTH_INFO_STATUS_PERFORMANCE_DEGRADED_MASK		BIT(1)
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 3b2293b..2c0a8d1 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -242,6 +242,11 @@ ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd, void *buf,
 		unsigned int length);
 struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev,
 		void *buf, unsigned int offset, unsigned int length);
+struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
+unsigned long long cxl_cmd_partition_get_active_volatile_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_partition_get_active_persistent_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/util/size.h b/util/size.h
index a0f3593..e72467f 100644
--- a/util/size.h
+++ b/util/size.h
@@ -15,6 +15,7 @@
 #define SZ_4M     0x00400000
 #define SZ_16M    0x01000000
 #define SZ_64M    0x04000000
+#define SZ_256M	  0x10000000
 #define SZ_1G     0x40000000
 #define SZ_1T 0x10000000000ULL
 
-- 
2.31.1

