Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82CEE4996
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Aug 2023 01:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjHVBnQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Aug 2023 21:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVBnP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 21 Aug 2023 21:43:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC01110
        for <linux-cxl@vger.kernel.org>; Mon, 21 Aug 2023 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692668594; x=1724204594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+8fQ3zeQF1hEsBBHOWt42u3UgfLNXjlcwY79CeZlO8=;
  b=GUE3f2ogriJTf+22YHfmsq/mj8pwp8l72KgT64jetnp11oM+20bL0+Tn
   3vXdnJj92tAOFAs1c3QoQRFFlDJXmL5d7VSe30iPEVMyENZNBoLpKuY1q
   ERJNenAWBkb3Jg3AIlgdvpqMTW9W6cGs5VDK7MQuzbdkpDjJrxVwFJVUy
   MuLNRSYHOwLmqc0GYcPyMQeK+GPv+2AO6sfT2HfjOUra5I6tdQpBcC22p
   dE/CY1wcxs/ZcevXVPw8sfOdBQnSlCEvOxuY3/3iNLSUXKU5gl9I4HK+b
   JsiLEwAf7X8AhjwOQs7rNAq8UDyWQy91PgKtSbQvbbo7tK1P6+TzCXicL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376486375"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="376486375"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 18:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="806113314"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="806113314"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.106.94])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 18:43:06 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/region: Match auto-discovered region decoders by HPA range
Date:   Mon, 21 Aug 2023 18:43:03 -0700
Message-Id: <20230822014303.110509-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Currently, when the region driver attaches a region to a port, it
selects the ports next available decoder to program.

With the addition of auto-discovered regions, a port decoder has
already been programmed so grabbing the next available decoder can
be a mismatch when there is more than one region using the port.

The failure appears like this with CXL DEBUG enabled:

[] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
[] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference

When CXL DEBUG is not enabled, there is no failure message. The region
just never materializes. Users can suspect this issue if they know their
firmware has programmed decoders so that more than one region is using
a port. Note that the problem may appear intermittently, ie not on
every reboot.

Add a matching method for auto-discovered regions that finds a decoder
based on an HPA range. The decoder range must exactly match the region
resource parameter.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Use cxlr->params for HPA match rather than requiring cxled (Dan)
- dev_warn() if decoder already assigned to a region (Dan)
- Add failure footprint to commit log (Dan)
- Add Fixes Tag (Dan)
- v1: https://lore.kernel.org/linux-cxl/20230804213004.1669658-1-alison.schofield@intel.com/

 drivers/cxl/core/region.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..b08aec9f0af8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -717,13 +717,40 @@ static int match_free_decoder(struct device *dev, void *data)
 	return 0;
 }
 
+static int match_auto_decoder(struct device *dev, void *data)
+{
+	struct cxl_region_params *p = data;
+	struct cxl_decoder *cxld;
+	struct range *r;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	r = &cxld->hpa_range;
+
+	if (p->res && p->res->start == r->start && p->res->end == r->end) {
+		if (cxld->region) {
+			dev_WARN(dev, "decoder already attached to %s\n",
+				 dev_name(&cxld->region->dev));
+			return 0;
+		}
+		return 1;
+	}
+	return 0;
+}
+
 static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
 						   struct cxl_region *cxlr)
 {
 	struct device *dev;
 	int id = 0;
 
-	dev = device_find_child(&port->dev, &id, match_free_decoder);
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+		dev = device_find_child(&port->dev, &cxlr->params,
+					match_auto_decoder);
+	else
+		dev = device_find_child(&port->dev, &id, match_free_decoder);
 	if (!dev)
 		return NULL;
 	/*

base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.37.3

