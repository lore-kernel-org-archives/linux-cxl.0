Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D202BC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 23:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiHAXAg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiHAXAb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 19:00:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254FBB1E6
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659394824; x=1690930824;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UGvYsa3tL8Y4tb7T7+USNbEYH27wdsvNYb2lqLxepvo=;
  b=kMrPi4a0jYRYERy0KgfXlV4C5uKAxJY/cc/Tt+/Zqf8ziJGFr4wihGRn
   VZAeBtt8p/jgh8yfbhpypIEe/L3PVvj/C1tMtGWEN1vzk8eR37l7hY8gA
   UOdTkqPv2jvCief7uf3PFocBaFL0UWNEhRghpx0mTPCxy2Rt/F9A/ZvEG
   mKUNxQSnqqzeejCPwXqriu/lEMJ3IXODHxTNRT6SxY1uz7VF8CzZeN30a
   gWRE1xd78EyujimiJh0NLWekVaCd5Jh5lUAVVwejG3ksb1Luockco9XX5
   yegphUzR7GWnmlgbauoAgeMCc5VrY6LQFdjgOWULuMNvspB89Ra3DYyxl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290043094"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="290043094"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 16:00:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="691633434"
Received: from jshi3-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.244.218])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 16:00:22 -0700
Subject: [PATCH] cxl/region: Fix region reference target accounting
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Mon, 01 Aug 2022 16:00:21 -0700
Message-ID: <165939482134.252363.1915691883146696327.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan reports:

    The error handling in cxl_port_attach_region() looks like it might
    have a similar bug.  The cxl_rr->nr_targets++; might want a --.

    That function is more complicated.

Indeed cxl_rr->nr_targets leaks when cxl_rr_ep_add() fails, but that
flow is not clear. Fix the bug and the clarity by separating the 'new'
region-reference case from the 'extend' region-reference case. This also
moves the host-physical-address (HPA) validation, that the HPA of a new
region being accounted to the port is greater than the HPA of all other
regions associated with the port, to alloc_region_ref().

Introduce @nr_targets_inc to track when the error exit path needs to
clean up cxl_rr->nr_targets.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   71 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index aff4f736b63c..cf5d5811fe4c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -709,12 +709,26 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
 static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 					       struct cxl_region *cxlr)
 {
-	struct cxl_region_ref *cxl_rr;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_region_ref *cxl_rr, *iter;
+	unsigned long index;
 	int rc;
 
+	xa_for_each(&port->regions, index, iter) {
+		struct cxl_region_params *ip = &iter->region->params;
+
+		if (ip->res->start > p->res->start) {
+			dev_dbg(&cxlr->dev,
+				"%s: HPA order violation %s:%pr vs %pr\n",
+				dev_name(&port->dev),
+				dev_name(&iter->region->dev), ip->res, p->res);
+			return ERR_PTR(-EBUSY);
+		}
+	}
+
 	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
 	if (!cxl_rr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	cxl_rr->port = port;
 	cxl_rr->region = cxlr;
 	cxl_rr->nr_targets = 1;
@@ -726,7 +740,7 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 			"%s: failed to track region reference: %d\n",
 			dev_name(&port->dev), rc);
 		kfree(cxl_rr);
-		return NULL;
+		return ERR_PTR(rc);
 	}
 
 	return cxl_rr;
@@ -801,33 +815,25 @@ static int cxl_port_attach_region(struct cxl_port *port,
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
-	struct cxl_region_ref *cxl_rr = NULL, *iter;
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_decoder *cxld = NULL;
+	struct cxl_region_ref *cxl_rr;
+	bool nr_targets_inc = false;
+	struct cxl_decoder *cxld;
 	unsigned long index;
 	int rc = -EBUSY;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
-	xa_for_each(&port->regions, index, iter) {
-		struct cxl_region_params *ip = &iter->region->params;
-
-		if (iter->region == cxlr)
-			cxl_rr = iter;
-		if (ip->res->start > p->res->start) {
-			dev_dbg(&cxlr->dev,
-				"%s: HPA order violation %s:%pr vs %pr\n",
-				dev_name(&port->dev),
-				dev_name(&iter->region->dev), ip->res, p->res);
-			return -EBUSY;
-		}
-	}
-
+	cxl_rr = cxl_rr_load(port, cxlr);
 	if (cxl_rr) {
 		struct cxl_ep *ep_iter;
 		int found = 0;
 
-		cxld = cxl_rr->decoder;
+		/*
+		 * Walk the existing endpoints that have been attached to
+		 * @cxlr at @port and see if they share the same 'next' port
+		 * in the downstream direction. I.e. endpoints that share common
+		 * upstream switch.
+		 */
 		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
 			if (ep_iter == ep)
 				continue;
@@ -838,22 +844,29 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 
 		/*
-		 * If this is a new target or if this port is direct connected
-		 * to this endpoint then add to the target count.
+		 * New target port, or @port is an endpoint port that always
+		 * accounts its own local decode as a target.
 		 */
-		if (!found || !ep->next)
+		if (!found || !ep->next) {
 			cxl_rr->nr_targets++;
+			nr_targets_inc = true;
+		}
+
+		/*
+		 * The decoder for @cxlr was allocated when the region was first
+		 * attached to @port.
+		 */
+		cxld = cxl_rr->decoder;
 	} else {
 		cxl_rr = alloc_region_ref(port, cxlr);
-		if (!cxl_rr) {
+		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
 				dev_name(&port->dev));
-			return -ENOMEM;
+			return PTR_ERR(cxl_rr);
 		}
-	}
+		nr_targets_inc = true;
 
-	if (!cxld) {
 		if (port == cxled_to_port(cxled))
 			cxld = &cxled->cxld;
 		else
@@ -896,6 +909,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
 
 	return 0;
 out_erase:
+	if (nr_targets_inc)
+		cxl_rr->nr_targets--;
 	if (cxl_rr->nr_eps == 0)
 		free_region_ref(cxl_rr);
 	return rc;

