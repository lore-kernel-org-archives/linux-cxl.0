Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182CC4321E
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 21:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLEVUE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiLEVUD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 16:20:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6B24BE1
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 13:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670275203; x=1701811203;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U2IGnxONNJwE5IkODF3iPYi/SJxQm43s8GwpOig5f44=;
  b=c30SH8rCtw5SZKSZyYcD4Y2d1FTV9Mn+xzeDRSQCQarn73DJwJH/E1pP
   OHgiI9hjalxD735AGiok/QJR/GMV0m50TtA5e7tYEWXlZGh9wPmFXWoMf
   1KyeztwEStnt58bGVJnJJTzYdGOQeurlZKU2gYupieVAg9CaAFOtEBUjT
   TmkBWnfKkTQ4MQGJGVb8yIJQOALHynSKrIKVP+5SGfypu+S2IRJUYEQmj
   0Eh08mtk87xUjppjwU2Bk+CPHEJ62zQQNW6OX07tLHdBcgy5jBpp527CH
   xbVVlF8ft3jxLS89070WFP4n+dF1bos6SbwwipvdXNz72fq8c4/mXCA5U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318326881"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318326881"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:20:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="623656705"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="623656705"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:20:02 -0800
Subject: [PATCH v4] cxl: update names for interleave ways conversion macros
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com
Date:   Mon, 05 Dec 2022 14:20:01 -0700
Message-ID: <167027516228.3124679.11265039496968588580.stgit@djiang5-desk3.ch.intel.com>
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
v4:
- Rebased against latest cxl/next.

v3:
- Change eniw to eiw for better overall code consistency (Jonathan, Dan)
- Pick up Jonathan review tag.

v2:
- change iw to ways for better clarificiation (Alison)

 drivers/cxl/acpi.c        |    6 +++---
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |    6 +++---
 drivers/cxl/cxl.h         |   14 +++++++-------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index eb33d2b08b8a..b4d47d8cb129 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -34,7 +34,7 @@ static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
 	}
 	/* IW: 3,6,12 add a modulo calculation to 'n' */
 	if (!is_power_of_2(iw)) {
-		if (ways_to_cxl(iw, &eiw))
+		if (ways_to_eiw(iw, &eiw))
 			return -1;
 		hpa &= GENMASK_ULL(51, eiw + ig);
 		n |= do_div(hpa, 3) << i;
@@ -161,7 +161,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc) {
 		dev_err(dev, "CFMWS Interleave Ways (%d) invalid\n",
 			cfmws->interleave_ways);
@@ -221,7 +221,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		return 0;
 	}
 
-	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
 	if (rc)
 		return rc;
 	rc = eig_to_granularity(cfmws->granularity, &ig);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 40b2ea99d92f..dcc16d7cb8f3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -494,7 +494,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
+	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
 		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
 		return;
 	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
@@ -741,8 +741,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
index 60d0b64279ae..a708da3e29ea 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -324,7 +324,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	rc = ways_to_cxl(val, &iw);
+	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
 
@@ -1036,7 +1036,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	rc = ways_to_cxl(parent_iw, &peiw);
+	rc = ways_to_eiw(parent_iw, &peiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
 			dev_name(parent_port->uport),
@@ -1045,7 +1045,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	iw = cxl_rr->nr_targets;
-	rc = ways_to_cxl(iw, &eiw);
+	rc = ways_to_eiw(iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
 			dev_name(port->uport), dev_name(&port->dev), iw);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7d0c81172a58..1b1cf459ac77 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -83,14 +83,14 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
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
@@ -108,12 +108,12 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
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
@@ -121,7 +121,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 	ways /= 3;
 	if (!is_power_of_2(ways))
 		return -EINVAL;
-	*iw = ilog2(ways) + 8;
+	*eiw = ilog2(ways) + 8;
 	return 0;
 }
 


