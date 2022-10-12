Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975DC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 17:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJLRYX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJLRYV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 13:24:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E6B5FD0
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665595460; x=1697131460;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wkCLjjnvYywFt+sdfytmS4nXLrmH4lXhgsTkmyR4MRM=;
  b=F5m1tPMhPhyIgaAxU/7z0KBEpaTg5cX4HVokC0w8COEctvThddE2XKB0
   0mk6DQnJRcEpZKkVRBqks7DBbaXUEmv71iEbNhTQQWvlQZ77VatVbHLK0
   1MOtFZDpZKhZsDF5XqBFvoxf4xlSXMnGcDuCyPljOmfCSJ4kCtf3G/XHc
   clQFzaWoCpTknDnKs2CVBVINXku9BQA4bQvV7SmnffBuYylOQuRapmLW6
   UBQb64vn44pS7/nsu7pD7gwj+pFqosjqVx09WK4+2y7Qu1P4zekfSrMOy
   49lCUjUAWsc3jhwp/tYHKQK9etFU8p2eeJkRW6gcH7kS6BGxmFS2J3y48
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="292183973"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="292183973"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:24:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="604634165"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="604634165"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:24:06 -0700
Subject: [PATCH v2] cxl: update names for interleave ways conversion macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Wed, 12 Oct 2022 10:24:06 -0700
Message-ID: <166559542232.2130239.9179572026142352550.stgit@djiang5-desk3.ch.intel.com>
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
eniw == encoded interleave ways

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- change iw to ways for better clarificiation (Alison)

 drivers/cxl/acpi.c        |    4 ++--
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |    6 +++---
 drivers/cxl/cxl.h         |   12 ++++++------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 5664411c3198..1291d7814b38 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -48,7 +48,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	rc = eniw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc) {
 		dev_err(dev, "CFMWS Interleave Ways (%d) invalid\n",
 			cfmws->interleave_ways);
@@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		return 0;
 	}
 
-	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	rc = eniw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
 		return rc;
 	rc = enig_to_granularity(cfmws->granularity, &ig);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 626cb7d66194..a37a94ede96d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -489,7 +489,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
+	if (WARN_ONCE(ways_to_eniw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
 	if (WARN_ONCE(granularity_to_enig(cxld->interleave_granularity, &eig),
@@ -736,8 +736,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		}
 		cxld->target_type = CXL_DECODER_EXPANDER;
 	}
-	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			 &cxld->interleave_ways);
+	rc = eniw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			  &cxld->interleave_ways);
 	if (rc) {
 		dev_warn(&port->dev,
 			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 34590f961740..474326dcde34 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -323,7 +323,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	rc = ways_to_cxl(val, &iw);
+	rc = ways_to_eniw(val, &iw);
 	if (rc)
 		return rc;
 
@@ -1010,7 +1010,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	rc = ways_to_cxl(parent_iw, &peiw);
+	rc = ways_to_eniw(parent_iw, &peiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
 			dev_name(parent_port->uport),
@@ -1019,7 +1019,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	iw = cxl_rr->nr_targets;
-	rc = ways_to_cxl(iw, &eiw);
+	rc = ways_to_eniw(iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
 			dev_name(port->uport), dev_name(&port->dev), iw);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ef6cc63c06ef..ad9239a851e2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -78,14 +78,14 @@ static inline int enig_to_granularity(u16 enig, unsigned int *granularity)
 }
 
 /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
-static inline int cxl_to_ways(u8 eniw, unsigned int *val)
+static inline int eniw_to_ways(u8 eniw, unsigned int *ways)
 {
 	switch (eniw) {
 	case 0 ... 4:
-		*val = 1 << eniw;
+		*ways = 1 << eniw;
 		break;
 	case 8 ... 10:
-		*val = 3 << (eniw - 8);
+		*ways = 3 << (eniw - 8);
 		break;
 	default:
 		return -EINVAL;
@@ -102,12 +102,12 @@ static inline int granularity_to_enig(int granularity, u16 *enig)
 	return 0;
 }
 
-static inline int ways_to_cxl(unsigned int ways, u8 *iw)
+static inline int ways_to_eniw(unsigned int ways, u8 *eniw)
 {
 	if (ways > 16)
 		return -EINVAL;
 	if (is_power_of_2(ways)) {
-		*iw = ilog2(ways);
+		*eniw = ilog2(ways);
 		return 0;
 	}
 	if (ways % 3)
@@ -115,7 +115,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 	ways /= 3;
 	if (!is_power_of_2(ways))
 		return -EINVAL;
-	*iw = ilog2(ways) + 8;
+	*eniw = ilog2(ways) + 8;
 	return 0;
 }
 


