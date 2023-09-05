Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A0CA100D
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 21:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbjIEVKs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 17:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbjIEVKm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 17:10:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9088CFC
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693948231; x=1725484231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KlOTKuE1Fuqe2/qrrp9cKBGW2LpPY2fqumraZKQNGcw=;
  b=i8+q2qtEIn4a4NoYRD85JYIVx5UIRFTwyxsBDEh1q1gC4Jek0YAgR7SM
   avLAclplP8Ax3p4O9lWBIS/PqoTSeCy54EuSBJz3BozAlzh6lNr8lC+gQ
   oQw6d+QHwDmghRCdyhiYPjbjBSr9U8UcnZ+YHmQn3PzLzXVF6yU4OgJY1
   N96psCD9plQYps1vAFy3o2MALabh1aevn5+Q1CoyIa5JqvJxE9ZqKAL6a
   KafBRpQdof+GqXseKrEIkYIzF3DUacB26dcsrLlF0rgQiVzoFiZkUOq+a
   +J3wB8Ael1zg+zoBTijb67PlTRBm6eYJOr0CPHB62UzJkHjYfqlC00A5f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407901511"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="407901511"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072121067"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="1072121067"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.50.9])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:10:10 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v3] cxl/region: Match auto-discovered region decoders by HPA range
Date:   Tue,  5 Sep 2023 14:10:07 -0700
Message-Id: <20230905211007.256385-1-alison.schofield@intel.com>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---

Changes in v3:
- Update match_auto_decoder() to simply return 1 if found, 0 if not found.
  Conflict resolution is already done in cxl_rr_alloc_decoder()
  (Jonathan, Dan)
- Add Reviewed-by tags (DaveJ, Davidlohr)
- v2: https://lore.kernel.org/linux-cxl/20230822014303.110509-1-alison.schofield@intel.com/

Changes in v2:
- Use cxlr->params for HPA match rather than requiring cxled (Dan)
- dev_warn() if decoder already assigned to a region (Dan)
- Add failure footprint to commit log (Dan)
- Add Fixes Tag (Dan)
- v1: https://lore.kernel.org/linux-cxl/20230804213004.1669658-1-alison.schofield@intel.com/


 drivers/cxl/core/region.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..b4c6a749406f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -717,13 +717,35 @@ static int match_free_decoder(struct device *dev, void *data)
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
+	if (p->res && p->res->start == r->start && p->res->end == r->end)
+		return 1;
+
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

