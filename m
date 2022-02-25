Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BBC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 22:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiBYWMB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiBYWMB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 17:12:01 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D38F52E17
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 14:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645827088; x=1677363088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U82cGucb9/siya9ChD+9mF/M4v+RJz6ePQa90D/b25w=;
  b=ZNKPNQIO+Aev0Skknt7HOL4CSaW5g2zpopxEF2dnrFGDo+Yx9PDoe61E
   gzfT7Zscip1IbL9fTz5eu0yc5MeRIAQ1NzT5c0oo69QCQc78oWzkSCQyC
   yHumJS84niSAAEoj7dWcTlynvthi1j9sbHXOCMEqYODyUGxo6AdGdMFPd
   Je0he4B72wVccU24iC38Gqg719zyl2LP2QlbCZZ/RxfbZM1EqWHxouwnr
   sfK84VNkKW8IJJa22ZpOO5t0y9KWcH+krc4uM2V2I/qQBxjXMK1ABexk+
   HkshLIpF3N5l+/wH12f8qD8v+Zk1DTpdqiNblhTV+ooigqeguT0lgxVRj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="313308387"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="313308387"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:11:26 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="492106099"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 14:11:26 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/mbox: Use __le32 in get,set_lsa mailbox structures
Date:   Fri, 25 Feb 2022 14:14:56 -0800
Message-Id: <20220225221456.1025635-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL specification defines these as little endian.

Fixes: 60b8f17215de ("cxl/pmem: Translate NVDIMM label commands to CXL label commands")
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
Changes in v2:
- Add cpu_to_le32() at usage sites. (Dan)

 drivers/cxl/cxlmem.h | 8 ++++----
 drivers/cxl/pmem.c   | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d5c9a273d07d..30cd2de3372a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -254,13 +254,13 @@ struct cxl_mbox_identify {
 } __packed;
 
 struct cxl_mbox_get_lsa {
-	u32 offset;
-	u32 length;
+	__le32 offset;
+	__le32 length;
 } __packed;
 
 struct cxl_mbox_set_lsa {
-	u32 offset;
-	u32 reserved;
+	__le32 offset;
+	__le32 reserved;
 	u8 data[];
 } __packed;
 
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 564d125d25ef..d88b77b78aeb 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -108,8 +108,8 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
 		return -EINVAL;
 
 	get_lsa = (struct cxl_mbox_get_lsa) {
-		.offset = cmd->in_offset,
-		.length = cmd->in_length,
+		.offset = cpu_to_le32(cmd->in_offset),
+		.length = cpu_to_le32(cmd->in_length),
 	};
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
@@ -139,7 +139,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 		return -ENOMEM;
 
 	*set_lsa = (struct cxl_mbox_set_lsa) {
-		.offset = cmd->in_offset,
+		.offset = cpu_to_le32(cmd->in_offset),
 	};
 	memcpy(set_lsa->data, cmd->in_buf, cmd->in_length);
 

base-commit: 9b688fc651b9d2b633e8d959454670aba1c39162
-- 
2.31.1

