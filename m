Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794FFC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Feb 2022 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiBVTxG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiBVTxE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Feb 2022 14:53:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B628C558F
        for <linux-cxl@vger.kernel.org>; Tue, 22 Feb 2022 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559558; x=1677095558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTwS3zyfONq/hobAVvA2o56Qgrn6SYc0iF1csV4Jw7c=;
  b=YrtLP3kTDDok/HRSb9i72QYUwt5fLk37ZHZ4tXdGJfnHYuUHaQhcID36
   np/VYXJUFgFnTBYnia7cb/hIkBqFyLxx8qVOVOk6CDRH2+27sMGrCvW8S
   lHpmJaYfa99sFel99/O/P7AgxHHZXZ8soOlh48zGvJOzuW93GBVrpRKxo
   lGIXmCLGtcgT8lXOUHrnLkxR3ILOCdxDnkeYOCXHLHavQkgF7L8w15+UI
   xJu68Yy3lHZ3v6uGmQTxh8S3/0/7vKA0gxDTx1cZhqEzP3NSbregO4VmA
   Fe2twozC5qfB1mw53p6MpjQwLQSS93uLlfmpA4+Rfiurzj/NZqJtKnAVp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250624966"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250624966"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:52:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="683637818"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:52:37 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v6 5/6] libcxl: add interfaces for SET_PARTITION_INFO mailbox command
Date:   Tue, 22 Feb 2022 11:56:07 -0800
Message-Id: <978c1cf78f3dd22f6070e51a241bc63cac9297de.1645558189.git.alison.schofield@intel.com>
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

The CXL PMEM provisioning model depends upon the CXL mailbox command
SET_PARTITION_INFO to change a device's partitioning between volatile
and persistent capacity.

Add interfaces to libcxl to allocate and send a SET_PARTITION_INFO
mailbox command as defined in the CXL 2.0 specification.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/lib/libcxl.txt | 11 +++++++++++
 cxl/lib/libcxl.c                 | 28 ++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  2 ++
 cxl/lib/private.h                |  8 ++++++++
 cxl/libcxl.h                     | 10 ++++++++++
 5 files changed, 59 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index a6986abafce3..7b223cbcac3f 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -132,6 +132,8 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			   size_t offset);
 struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
+					  unsigned long long volatile_size);
 
 ----
 
@@ -148,6 +150,8 @@ this sub-class of interfaces, there are:
    a CXL standard opcode. See the potential command ids in
    /usr/include/linux/cxl_mem.h.
 
+ * 'cxl_cmd_<name>_set_<field>' interfaces that set specific fields in a cxl_cmd
+
  * 'cxl_cmd_submit' which submits the command via ioctl()
 
  * 'cxl_cmd_<name>_get_<field>' interfaces that get specific fields out of the
@@ -167,6 +171,13 @@ cxl_memdev{read,write,zero}_label() are helpers for marshaling multiple
 label access commands over an arbitrary extent of the device's label
 area.
 
+cxl_cmd_partition_set_mode() supports selecting NEXTBOOT or IMMEDIATE
+mode. When CXL_SETPART_IMMEDIATE mode is set, it is the caller’s
+responsibility to avoid immediate changes to partitioning when the
+device is in use. When CXL_SETPART_NEXTBOOT mode is set, the change
+in partitioning shall become the “next” configuration, to become
+active on the next device reset.
+
 BUSES
 -----
 The CXL Memory space is CPU and Device coherent. The address ranges that
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index c05c13c501ab..daa2bbc5a299 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2478,6 +2478,34 @@ cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd)
 	return cxl_capacity_to_bytes(c->next_persistent);
 }
 
+CXL_EXPORT int cxl_cmd_partition_set_mode(struct cxl_cmd *cmd,
+		enum cxl_setpartition_mode mode)
+{
+	struct cxl_cmd_set_partition *setpart = cmd->input_payload;
+
+	if (mode == CXL_SETPART_IMMEDIATE)
+		setpart->flags = CXL_CMD_SET_PARTITION_FLAG_IMMEDIATE;
+	else
+		setpart->flags = !CXL_CMD_SET_PARTITION_FLAG_IMMEDIATE;
+
+	return 0;
+}
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
+		unsigned long long volatile_size)
+{
+	struct cxl_cmd_set_partition *setpart;
+	struct cxl_cmd *cmd;
+
+	cmd = cxl_cmd_new_generic(memdev,
+			CXL_MEM_COMMAND_ID_SET_PARTITION_INFO);
+
+	setpart = cmd->input_payload;
+	setpart->volatile_size = cpu_to_le64(volatile_size)
+					/ CXL_CAPACITY_MULTIPLIER;
+	return cmd;
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 5ac6e9bbe981..aab1112a91d8 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -163,4 +163,6 @@ global:
 	cxl_cmd_identify_get_total_size;
 	cxl_cmd_identify_get_volatile_only_size;
 	cxl_cmd_identify_get_persistent_only_size;
+	cxl_cmd_new_set_partition;
+	cxl_cmd_partition_set_mode;
 } LIBCXL_1;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 7f3a562a7c8e..c6d88f7140f2 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -195,6 +195,14 @@ struct cxl_cmd_get_partition {
 
 #define CXL_CAPACITY_MULTIPLIER		SZ_256M
 
+struct cxl_cmd_set_partition {
+	le64 volatile_size;
+	u8 flags;
+} __attribute__((packed));
+
+/* CXL 2.0 8.2.9.5.2 Set Partition Info */
+#define CXL_CMD_SET_PARTITION_FLAG_IMMEDIATE				BIT(0)
+
 /* CXL 2.0 8.2.9.5.3 Byte 0 Health Status */
 #define CXL_CMD_HEALTH_INFO_STATUS_MAINTENANCE_NEEDED_MASK		BIT(0)
 #define CXL_CMD_HEALTH_INFO_STATUS_PERFORMANCE_DEGRADED_MASK		BIT(1)
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 6e18e843d3ea..0063d31ab398 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -250,6 +250,16 @@ unsigned long long cxl_cmd_partition_get_active_volatile_size(struct cxl_cmd *cm
 unsigned long long cxl_cmd_partition_get_active_persistent_size(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
+		unsigned long long volatile_size);
+
+enum cxl_setpartition_mode {
+	CXL_SETPART_NEXTBOOT,
+	CXL_SETPART_IMMEDIATE,
+};
+
+int cxl_cmd_partition_set_mode(struct cxl_cmd *cmd,
+		enum cxl_setpartition_mode mode);
 
 #ifdef __cplusplus
 } /* extern "C" */
-- 
2.31.1

