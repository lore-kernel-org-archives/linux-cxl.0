Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFED6C38A2D
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 23:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJXX0h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJXX0P (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 19:26:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F7263D04
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666648047; x=1698184047;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67dlV+LfwcMloizLFkT0M62g3DxbDtkP2tX1qpbHjOI=;
  b=TnaEyTs7FZenW4WsEyA+zvDeM0ddbyZ4DOHnhKZshF57MDyDvyI8r9/R
   e+Uol2ycOceyx5kWZcKoqesxEb0iwuXD1+164/+FrRrhv9byD6qTFNcmz
   0QmmiPuFwXicec45M4n5CZfeBzxt/ynIA8fVWAD14tUBTRBoM+N5ypVy5
   m5OhMxQSxTcfeIFpwDEk7rA9OB14ghxdMeXqBFb2PoPgkr0PEaKtp6+gu
   uiObj6UBuvYdVmymHJe4vQ8loyRprgXC3m1IxSGitHDgjhgBz+uWmOe7T
   N26HZKyTaA49es0p3IhN6/t6CF4OB07UOAXqySIfIW17ljrD7AVBDRG74
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290832881"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="290832881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:46:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="756715542"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="756715542"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:46:48 -0700
Subject: [PATCH v3] cxl: update names for interleave ways conversion macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 24 Oct 2022 14:46:47 -0700
Message-ID: <166664789614.510865.6244814351892899742.stgit@djiang5-desk3.ch.intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v3:
- Change eniw to eiw for better overall code consistency (Jonathan, Dan)
- Pick up Jonathan review tag.

v2:
- change iw to ways for better clarificiation (Alison)

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
 


