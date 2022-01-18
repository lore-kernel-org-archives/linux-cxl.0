Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABFC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Jan 2022 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiARUUd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:20:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:58421 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349141AbiARUUc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 18 Jan 2022 15:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642537232; x=1674073232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PAJilnz5lTX52V9oiTom4kJZWUazgIG3WYPPl2V8m0M=;
  b=nXPmmPXKbkzO64jwhYhpO4LXw3ryRSLCPjfUQbRA7Hf0C220SSsCKqhl
   qM9AadiS+CfsvrMH825wpkc5FwYdnRgz/dRmNdqFB2IPkhXH+n39USDYc
   zUdzalTMyvR0nQ47eT03rPeGw8Fm2ZZ/TRYPO11w8mtcYpIh4O3OoGpS4
   eyIXHY8CRm+/Le9fhEuKtMJFxqQmgBK6rbw0d3ga4wDp5pXv2ek81Rj4f
   zYQDX5WWpNpVdorceSOeLTgmDO4dBIpardK3ujspQ49c02XgIuhUGr/xj
   wdAy4Qwa6gJmzbXJH7yvNTgD9o5ajylK4c4OJJWj+0se1g91s1n7Lcm8V
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308250313"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="308250313"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:20:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="671953871"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 12:20:31 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v3 5/6] libcxl: add interfaces for SET_PARTITION_INFO mailbox command
Date:   Tue, 18 Jan 2022 12:25:14 -0800
Message-Id: <e98fa18538c42c40b120d5c22da655d199d0329d.1642535478.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642535478.git.alison.schofield@intel.com>
References: <cover.1642535478.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Users may want the ability to change the partition layout of a CXL
memory device.

Add interfaces to libcxl to allocate and send a SET_PARTITION_INFO
mailbox as defined in the CXL 2.0 specification.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  5 +++++
 cxl/lib/private.h  |  8 ++++++++
 cxl/libcxl.h       |  5 +++++
 4 files changed, 68 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 5b1fc32..5a5b189 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1230,6 +1230,21 @@ cxl_cmd_partition_info_get_next_persistent_bytes(struct cxl_cmd *cmd)
 	cmd_partition_get_capacity_field(cmd, next_persistent_cap);
 }
 
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_partition_info(struct cxl_memdev *memdev,
+		unsigned long long volatile_capacity, int flags)
+{
+	struct cxl_cmd_set_partition_info *set_partition;
+	struct cxl_cmd *cmd;
+
+	cmd = cxl_cmd_new_generic(memdev,
+			CXL_MEM_COMMAND_ID_SET_PARTITION_INFO);
+
+	set_partition = (struct cxl_cmd_set_partition_info *)cmd->send_cmd->in.payload;
+	set_partition->volatile_capacity = cpu_to_le64(volatile_capacity);
+	set_partition->flags = flags;
+	return cmd;
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
@@ -1428,3 +1443,38 @@ CXL_EXPORT int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf,
 {
 	return lsa_op(memdev, LSA_OP_GET, buf, length, offset);
 }
+
+CXL_EXPORT int cxl_memdev_set_partition_info(struct cxl_memdev *memdev,
+	       unsigned long long volatile_capacity, int flags)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	struct cxl_cmd *cmd;
+	int rc;
+
+	dbg(ctx, "%s: enter cap: %llx, flags %d\n", __func__,
+		volatile_capacity, flags);
+
+	cmd = cxl_cmd_new_set_partition_info(memdev,
+			volatile_capacity / CXL_CAPACITY_MULTIPLIER, flags);
+	if (!cmd)
+		return -ENXIO;
+
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0) {
+		err(ctx, "cmd submission failed: %s\n", strerror(-rc));
+		goto err;
+	}
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0) {
+		err(ctx, "%s: mbox status: %d\n", __func__, rc);
+		rc = -ENXIO;
+	}
+err:
+	cxl_cmd_unref(cmd);
+	return rc;
+}
+
+CXL_EXPORT int cxl_cmd_partition_info_flag_immediate(void)
+{
+	return CXL_CMD_SET_PARTITION_INFO_FLAG_IMMEDIATE;
+}
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index b7e969f..0ce931d 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -78,6 +78,11 @@ global:
 	cxl_cmd_partition_info_get_active_persistent_bytes;
 	cxl_cmd_partition_info_get_next_volatile_bytes;
 	cxl_cmd_partition_info_get_next_persistent_bytes;
+	cxl_cmd_new_set_partition_info;
+	cxl_memdev_set_partition_info;
+	cxl_cmd_partition_info_flag_none;
+	cxl_cmd_partition_info_flag_immediate;
+
 local:
         *;
 };
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index dd9234f..4da8ea7 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -114,6 +114,14 @@ struct cxl_cmd_get_partition_info {
 
 #define CXL_CAPACITY_MULTIPLIER		SZ_256M
 
+struct cxl_cmd_set_partition_info {
+	le64 volatile_capacity;
+	u8 flags;
+} __attribute__((packed));
+
+/* CXL 2.0 8.2.9.5.2 Set Partition Info */
+#define CXL_CMD_SET_PARTITION_INFO_FLAG_IMMEDIATE			BIT(0)
+
 /* CXL 2.0 8.2.9.5.3 Byte 0 Health Status */
 #define CXL_CMD_HEALTH_INFO_STATUS_MAINTENANCE_NEEDED_MASK		BIT(0)
 #define CXL_CMD_HEALTH_INFO_STATUS_PERFORMANCE_DEGRADED_MASK		BIT(1)
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 46f99fb..9b0a599 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -50,6 +50,8 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 		size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 		size_t offset);
+int cxl_memdev_set_partition_info(struct cxl_memdev *memdev,
+		unsigned long long volatile_capacity, int flags);
 
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev = cxl_memdev_get_first(ctx); \
@@ -117,6 +119,9 @@ unsigned long long cxl_cmd_partition_info_get_active_volatile_bytes(struct cxl_c
 unsigned long long cxl_cmd_partition_info_get_active_persistent_bytes(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_partition_info_get_next_volatile_bytes(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_partition_info_get_next_persistent_bytes(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_set_partition_info(struct cxl_memdev *memdev,
+		unsigned long long volatile_capacity, int flags);
+int cxl_cmd_partition_info_flag_immediate(void);
 
 #ifdef __cplusplus
 } /* extern "C" */
-- 
2.31.1

