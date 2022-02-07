Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E81C47088
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 01:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiBHBFH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiBGXGQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Feb 2022 18:06:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34BC061355
        for <linux-cxl@vger.kernel.org>; Mon,  7 Feb 2022 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275175; x=1675811175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AT+VHGNddjvlGjH8cs3QAwopGuBl6WtzDH74xT4MqOo=;
  b=NkEQlZEytEpbxtdj2o6Ob4nG2GLBQLXeF92zhLZ/diLGMfNWRmSaiPy/
   aP8SCTTyMBDSoQz2FN33YBCfiJMTDbwQBqwKdpcuBRO2mg7oU9lDYBPS/
   1e1BHTU0Y8D4qeS1zaJXlMot+2u2Z1iXJQLyF76S54Cp79MfdBTPHToqX
   DEtEt0zmslk++dVSJe5TOs/LE9qiQNrLRfqpy385WUkmhobNfOJR+LBk7
   ZaLeRsVfaYfmMH+zS6FEDAwwrW9JejofTCK6x6FWGzo7vZzOg85LFLG8X
   VrK80DkTKz+re1Q2exOYlfCBP1Szvzh/RKh8hJvzwJnFNX3rEekJwKM3j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248775568"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248775568"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:06:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="632639200"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:06:14 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v4 2/6] libcxl: add accessors for capacity fields of the IDENTIFY command
Date:   Mon,  7 Feb 2022 15:10:16 -0800
Message-Id: <034755a71999a66da79356ec7efbabeaa4eacd88.1644271559.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644271559.git.alison.schofield@intel.com>
References: <cover.1644271559.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Users need access to a few additional fields reported by the IDENTIFY
mailbox command: total, volatile_only, and persistent_only capacities.
These values are useful when defining partition layouts.

Add accessors to the libcxl API to retrieve these values from the
IDENTIFY command.

The fields are specified in multiples of 256MB per the CXL 2.0 spec.
Use the capacity multiplier to convert the raw data into bytes for user
consumption.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c   | 36 ++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  3 +++
 cxl/libcxl.h       |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 33cf06b..e9d7762 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2322,6 +2322,42 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
 	return le32_to_cpu(id->lsa_size);
 }
 
+static struct cxl_cmd_identify *
+cmd_to_identify(struct cxl_cmd *cmd)
+{
+	if (cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_IDENTIFY))
+		return NULL;
+
+	return cmd->output_payload;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_total_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *c;
+
+	c = cmd_to_identify(cmd);
+	return c ? capacity_to_bytes(c->total_capacity) : ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_volatile_only_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *c;
+
+	c = cmd_to_identify(cmd);
+	return c ? capacity_to_bytes(c->volatile_capacity) : ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long
+cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *c;
+
+	c = cmd_to_identify(cmd);
+	return c ? capacity_to_bytes(c->persistent_capacity) : ULLONG_MAX;
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

