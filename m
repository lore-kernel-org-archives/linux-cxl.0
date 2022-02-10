Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47622C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Feb 2022 02:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiBJCGE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiBJCFR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 21:05:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEAF25DF3
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 18:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644458475; x=1675994475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6llTrHh/ojmCw4TL9zhIeN/sHiK2+9zbAVpKY+VN2c=;
  b=jKEFjIUZcr+QC14KD1cTlVJi8RS97myaeqgm8z5981hC7EhwUlNmF2L0
   VUbBEsknQNRm7YE/Pj0Oz4Ls3cEF7zlUADhb74fpKJ5lAFxWcQqj5lDdO
   B9XOZUjGX/XnqkrsWSJPTd4uI8pRlzIN7jEuXassSYgXi1jkmwZGfqDyA
   pqGPXsvM5VeH93vHWkc6Pkp9mkylx9SLcW9wcOUhvmPvYOPzdnZXB0YJS
   X5EgO2RH/J2YPXsGByVeWCg0YxoZoeYEfbUcLV9hTz3XK2YQMmo+k7qkF
   kW2HMnUFatbIUGRbT6r6+kNLkHanUZNxNlzQXtG7jGqoHI2YIoJc5tHgF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232952540"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="232952540"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:01:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="585799513"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 18:01:13 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v5 2/6] libcxl: add accessors for capacity fields of the IDENTIFY command
Date:   Wed,  9 Feb 2022 18:05:10 -0800
Message-Id: <58dec40b15a68f134466f61421751994735e55c1.1644455619.git.alison.schofield@intel.com>
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
in the CXL IDENTIFY mailbox command when changing the partitioning
between volatile and persistent capacity.

Add accessors to the libcxl API to retrieve the total, volatile only,
and persistent only capacities from the IDENTIFY command.

The fields are specified in multiples of 256MB per the CXL 2.0 spec.
Use the capacity multiplier to convert the raw data into bytes for user
consumption.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/lib/libcxl.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  3 +++
 cxl/libcxl.h       |  3 +++
 3 files changed, 50 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 4557a71..9413384 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2277,6 +2277,17 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
 }
 
+static struct cxl_cmd_identify *
+cmd_to_identify(struct cxl_cmd *cmd)
+{
+	if (cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_IDENTIFY))
+		return NULL;
+
+	if (!cmd)
+		return NULL;
+	return cmd->output_payload;
+}
+
 CXL_EXPORT int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev,
 		int fw_len)
 {
@@ -2321,6 +2332,39 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
 	return le32_to_cpu(id->lsa_size);
 }
 
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_total_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *c;
+
+	c = cmd_to_identify(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->total_capacity);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_volatile_only_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *c;
+
+	c = cmd_to_identify(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->volatile_capacity);
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *c;
+
+	c = cmd_to_identify(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->persistent_capacity);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
 		int opcode)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 509e62d..5ac6e9b 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -160,4 +160,7 @@ global:
 	cxl_cmd_partition_get_active_persistent_size;
 	cxl_cmd_partition_get_next_volatile_size;
 	cxl_cmd_partition_get_next_persistent_size;
+	cxl_cmd_identify_get_total_size;
+	cxl_cmd_identify_get_volatile_only_size;
+	cxl_cmd_identify_get_persistent_only_size;
 } LIBCXL_1;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 2c0a8d1..6e18e84 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -201,6 +201,9 @@ int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd);
 int cxl_cmd_get_out_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
 int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
+unsigned long long cxl_cmd_identify_get_total_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_volatile_only_size(struct cxl_cmd *cmd);
+unsigned long long cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd);
 unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
 unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
-- 
2.31.1

