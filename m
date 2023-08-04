Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1861C001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 21:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHDVbG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjHDVai (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 17:30:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C957CE67
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691184610; x=1722720610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O0jzP9sUE1UUtpmq34IrqTN88pfd7bjn6AYVC9caQLE=;
  b=PoZBTlFaIlKyFpngFpjPccTWtxGaFG6EyG0xIaNvRUJyOgdS2MnBLyAc
   wx07fvmVVxiweWEqbxXDl0+dot+tsWThx3mNohMWHPETj+94JHdGARANe
   BgKdI6irEyxhPonVrAT6z6zrFKPN2v+GaVC72Wo6EC0XZPG/9dNfxaNAm
   5KeUvuoqr17lL9YxkHHiHK1jwqFT5qjXug4q9HN6yB3c4jKrac4cqazEP
   g8lj+gYaLBcrM/9cREF3fkUdqzWm/08QnZVgvz4EK53Sr6tSJtTeF9HwG
   jRsyXAAz0L0wkrdW8ONze9fcbKX7RHfn67+yBwGSTZoF7Pg3trSbUKAJN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="434095299"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="434095299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 14:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873542537"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.168.219])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 14:30:12 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Match auto-discovered region decoders by HPA range
Date:   Fri,  4 Aug 2023 14:30:04 -0700
Message-Id: <20230804213004.1669658-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Today, when the region driver attaches a region to a port, it
selects the ports next available decoder to program.

With the addition of auto-discovered regions, a port decoder has
already been programmed, so grabbing the next available decoder
can be a mismatch when there is more than one region using the
port. Match on the port HPA range for auto-discovered regions.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 
 drivers/cxl/core/region.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..8bfec7a96975 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -717,13 +717,37 @@ static int match_free_decoder(struct device *dev, void *data)
 	return 0;
 }
 
+static int match_auto_decoder(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+
+	if (!range_contains(&cxld->hpa_range, &cxled->cxld.hpa_range))
+		return 0;
+
+	if (!cxld->region)
+		return 1;
+
+	return 0;
+}
+
 static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
-						   struct cxl_region *cxlr)
+						   struct cxl_region *cxlr,
+						   struct cxl_endpoint_decoder *cxled)
 {
 	struct device *dev;
 	int id = 0;
 
-	dev = device_find_child(&port->dev, &id, match_free_decoder);
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+		dev = device_find_child(&port->dev, cxled, match_auto_decoder);
+	else
+		dev = device_find_child(&port->dev, &id, match_free_decoder);
+
 	if (!dev)
 		return NULL;
 	/*
@@ -839,7 +863,8 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	if (port == cxled_to_port(cxled))
 		cxld = &cxled->cxld;
 	else
-		cxld = cxl_region_find_decoder(port, cxlr);
+		cxld = cxl_region_find_decoder(port, cxlr, cxled);
+
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));

base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.37.3

