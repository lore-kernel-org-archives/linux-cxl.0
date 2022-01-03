Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297FC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jan 2022 20:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiACULe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:35292 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbiACULe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641240694; x=1672776694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4ist+wRtz5MUDFftoH8bUzPjP4x2s9lbL9nKwk7uk8=;
  b=m8CcMS3C5iAAOKGUQJQ2J951lXp8U1+6P1wy+QeJuTK8MuJyaOBPYj6i
   jYD+MduCdg5PQjVotHxKgtG7j5es3LS0OEQBDuYu8CAG5cVTuI7NsDD27
   tP08l8p7ycjiDoD2pBDUNg74joMRQWLvXe+EV/uAs0yW7FJvpknCsXPAT
   C1aRepF6/a1E6WMb+BAq6srqKn6SThAAsd+9KZYI4gb3GxlGkIWjM8qPz
   PlRxH/Dj1vsFuS4dQ88r1xgo+4QR+9/x+nG8eBJmFIgecUdwWe9J5I5Al
   LiQT3EyiKFSSArN/RRj5gRn5Z8HYk45TLQM93OsvN52ZMY3vVXkDVdL/U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222105775"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222105775"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="525709392"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 2/7] libcxl: add accessors for capacity fields of the IDENTIFY command
Date:   Mon,  3 Jan 2022 12:16:13 -0800
Message-Id: <577012d59f5b6b9754d2ce1147585ce5f91a3108.1641233076.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641233076.git.alison.schofield@intel.com>
References: <cover.1641233076.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Add accessors to retrieve total capacity, volatile only capacity,
and persistent only capacity from the IDENTIFY mailbox command.
These values are useful when partitioning the device.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/libcxl.h       |  3 +++
 cxl/lib/libcxl.c   | 29 +++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 7cf9061..d333b6d 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -68,6 +68,9 @@ int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd);
 int cxl_cmd_get_out_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
 int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
+unsigned long long cxl_cmd_identify_get_total_capacity(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_volatile_only_capacity(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_persistent_only_capacity(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
 unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index f3d4022..715d8e4 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1102,6 +1102,35 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
 	return le32_to_cpu(id->lsa_size);
 }
 
+#define cmd_identify_get_capacity_field(cmd, field)			\
+do {										\
+	struct cxl_cmd_identify *c =					\
+		(struct cxl_cmd_identify *)cmd->send_cmd->out.payload;\
+	int rc = cxl_cmd_validate_status(cmd,					\
+			CXL_MEM_COMMAND_ID_IDENTIFY);			\
+	if (rc)									\
+		return ULLONG_MAX;							\
+	return le64_to_cpu(c->field) * CXL_CAPACITY_MULTIPLIER;			\
+} while (0)
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_total_capacity(struct cxl_cmd *cmd)
+{
+	cmd_identify_get_capacity_field(cmd, total_capacity);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_volatile_only_capacity(struct cxl_cmd *cmd)
+{
+	cmd_identify_get_capacity_field(cmd, volatile_capacity);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_persistent_only_capacity(struct cxl_cmd *cmd)
+{
+	cmd_identify_get_capacity_field(cmd, persistent_capacity);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
 		int opcode)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 09d6d94..bed6427 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -31,6 +31,9 @@ global:
 	cxl_cmd_get_out_size;
 	cxl_cmd_new_identify;
 	cxl_cmd_identify_get_fw_rev;
+	cxl_cmd_identify_get_total_capacity;
+	cxl_cmd_identify_get_volatile_only_capacity;
+	cxl_cmd_identify_get_persistent_only_capacity;
 	cxl_cmd_identify_get_partition_align;
 	cxl_cmd_identify_get_label_size;
 	cxl_cmd_new_get_health_info;
-- 
2.31.1

