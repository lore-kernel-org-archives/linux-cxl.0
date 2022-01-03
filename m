Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE4C43217
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jan 2022 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiACULg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jan 2022 15:11:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:35284 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbiACULe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641240694; x=1672776694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExZXAVTyWRNmIDDrWFSUQMsvxT+hLCcqMNH1z0HRo30=;
  b=OLlnmGoGDvCEzw1Ucq944xXNmG0SzeP26lc/TWJIPJI633YJHzU/zRBA
   Phq1ElX9FJWHNoFSad0rqTCq8xgATHzoT54ncr9lH35RCWLICNYrygF0Y
   4lo0R0UOKgUqGKd4wkaBY1YQ6Sln3TY4l6kQ1IKHjBW9vkDj36xjlL4FL
   sqSMvrVlp7+FVR6VMGBVN177WklyOg5agAWLCidbZhfm0zkkT0I/CYcDh
   4aq+Z3f3ZHiZ3su0hk7wV3gurvw/8G40ZEE6AfQqWP2n4FvEBrdK4CZeN
   I/43McF0YLo/qlxCA5tWRAU5PJEv3QXO1/6ZdBzr49t84kRkD2DbvTq7M
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222105779"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222105779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="525709404"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 5/7] libcxl: add interfaces for SET_PARTITION_INFO mailbox command
Date:   Mon,  3 Jan 2022 12:16:16 -0800
Message-Id: <fa45e95e5d28981b4ec41db65aab82c103bff0c3.1641233076.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641233076.git.alison.schofield@intel.com>
References: <cover.1641233076.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Add APIs to allocate and send a SET_PARTITION_INFO mailbox command.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/private.h  |  9 +++++++++
 cxl/libcxl.h       |  4 ++++
 cxl/lib/libcxl.c   | 45 +++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  3 +++
 4 files changed, 61 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index dd9234f..841aa80 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -114,6 +114,15 @@ struct cxl_cmd_get_partition_info {
 
 #define CXL_CAPACITY_MULTIPLIER		SZ_256M
 
+struct cxl_cmd_set_partition_info {
+	le64 volatile_capacity;
+	u8 flags;
+} __attribute__((packed));
+
+/* CXL 2.0 8.2.9.5.2 Set Partition Info */
+#define CXL_CMD_SET_PARTITION_INFO_NO_FLAG				(0)
+#define CXL_CMD_SET_PARTITION_INFO_IMMEDIATE_FLAG			(1)
+
 /* CXL 2.0 8.2.9.5.3 Byte 0 Health Status */
 #define CXL_CMD_HEALTH_INFO_STATUS_MAINTENANCE_NEEDED_MASK		BIT(0)
 #define CXL_CMD_HEALTH_INFO_STATUS_PERFORMANCE_DEGRADED_MASK		BIT(1)
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index d333b6d..67d6ffc 100644
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
@@ -117,6 +119,8 @@ unsigned long long cxl_cmd_get_partition_info_get_active_volatile_cap(struct cxl
 unsigned long long cxl_cmd_get_partition_info_get_active_persistent_cap(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_get_partition_info_get_next_volatile_cap(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_get_partition_info_get_next_persistent_cap(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_set_partition_info(struct cxl_memdev *memdev,
+		unsigned long long volatile_capacity, int flags);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 85a6c0e..877a783 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1227,6 +1227,21 @@ cxl_cmd_get_partition_info_get_next_persistent_cap(struct cxl_cmd *cmd)
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
@@ -1425,3 +1440,33 @@ CXL_EXPORT int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf,
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
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index bed6427..5d02c45 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -78,6 +78,9 @@ global:
 	cxl_cmd_get_partition_info_get_active_persistent_cap;
 	cxl_cmd_get_partition_info_get_next_volatile_cap;
 	cxl_cmd_get_partition_info_get_next_persistent_cap;
+	cxl_cmd_new_set_partition_info;
+	cxl_memdev_set_partition_info;
+
 local:
         *;
 };
-- 
2.31.1

