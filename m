Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2193ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 19:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiJXTSC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJXTRd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 15:17:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA28F252
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666634078; x=1698170078;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=getlwgOG92dW31zE4LmLAm4UUzTf10LxWxpzmSApBNQ=;
  b=SG70Tp+5jdbsBcSU37vQynKNTzSMlDHkpmIYNZO1NRM3PZaDeunz63WN
   M6igHRVUeQqfORAv3iHmwWv6f8Mm9x+DLLnupMTtLk4iIZKi4Yi1Ot2U/
   JAoPZxjSpJCPWnQCvUJqVIMpWEXrsfo965COE0aBaSU4MQpuPmjIrciVw
   /J/Nog06o+xjEoUbxYn+Ku4eEGFG8ZCX2FLZhUSKaGlVBJIxkxAnKowpc
   P14ST6D3C34o16UqygONM+qBKS0qUgPSY9J19dO/us3ShBUO6xu4wu0uB
   mosQr3aHa/ehhtMNUJdHzc9XWINmqigqshnxCRUt2rP9AUAmpwiJ11KO7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308564294"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="308564294"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:55:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876500765"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="876500765"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:55:36 -0700
Subject: [PATCH v2] cxl: update names for interleave ways conversion macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 24 Oct 2022 09:55:36 -0700
Message-ID: <166663051174.483964.6410865074738850111.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Change names for interleave ways macros to clearly indicate which
variable is encoded and which is the actual ways value.

ways == interleave ways
eiw == encoded interleave ways

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- Change eniw to eiw. (Jonathan, Dan)

 drivers/cxl/acpi.c        |    4 ++--
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |    6 +++---
 drivers/cxl/cxl.h         |   14 +++++++-------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 9434f8333287..53bfe5706abc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -48,7 +48,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc) {
 		dev_err(dev, "CFMWS Interleave Ways (%d) invalid\n",
 			cfmws->interleave_ways);
@@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		return 0;
 	}
 
-	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
 		return rc;
 	rc = eig_to_granularity(cfmws->granularity, &ig);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a04ce9e6e186..513aa132990d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -489,7 +489,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
+	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
 	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
@@ -736,8 +736,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		}
 		cxld->target_type = CXL_DECODER_EXPANDER;
 	}
-	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			 &cxld->interleave_ways);
+	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			  &cxld->interleave_ways);
 	if (rc) {
 		dev_warn(&port->dev,
 			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index df294a6fd2c9..5d9c2dc7ce31 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -323,7 +323,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	rc = ways_to_cxl(val, &iw);
+	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
 
@@ -1010,7 +1010,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	rc = ways_to_cxl(parent_iw, &peiw);
+	rc = ways_to_eiw(parent_iw, &peiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
 			dev_name(parent_port->uport),
@@ -1019,7 +1019,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	iw = cxl_rr->nr_targets;
-	rc = ways_to_cxl(iw, &eiw);
+	rc = ways_to_eiw(iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
 			dev_name(port->uport), dev_name(&port->dev), iw);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dacb1d769dae..e2a1a7523a2b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -78,14 +78,14 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
 }
 
 /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
-static inline int cxl_to_ways(u8 eniw, unsigned int *val)
+static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
 {
-	switch (eniw) {
+	switch (eiw) {
 	case 0 ... 4:
-		*val = 1 << eniw;
+		*ways = 1 << eiw;
 		break;
 	case 8 ... 10:
-		*val = 3 << (eniw - 8);
+		*ways = 3 << (eiw - 8);
 		break;
 	default:
 		return -EINVAL;
@@ -102,12 +102,12 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
 	return 0;
 }
 
-static inline int ways_to_cxl(unsigned int ways, u8 *iw)
+static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 {
 	if (ways > 16)
 		return -EINVAL;
 	if (is_power_of_2(ways)) {
-		*iw = ilog2(ways);
+		*eiw = ilog2(ways);
 		return 0;
 	}
 	if (ways % 3)
@@ -115,7 +115,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 	ways /= 3;
 	if (!is_power_of_2(ways))
 		return -EINVAL;
-	*iw = ilog2(ways) + 8;
+	*eiw = ilog2(ways) + 8;
 	return 0;
 }
 


