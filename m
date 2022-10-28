Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC026C38A02
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 19:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ1TeG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJ1TeC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 15:34:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E742413C1
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666985641; x=1698521641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=quItP1YTeb6TsLEiBkKR2uxEEEOjKT7XpjylK3Td9qc=;
  b=cro3bdT24GCgiwfrZKafA4de5N5c1ymUFy816vfUiVnhGjkHddTqitIy
   OPbcOYV/tvE+5XnSKudS+Urcmm31iD+B/DMB7MccZFBjn+geN3dX7jDX2
   jrh0Nm/eWKk/gMPHlqQK49k/Dk7+SvQQUYNAkmT/4SE0qCuhFr+CZKj/H
   Hft+hAQuZI6IVutSbkX7QbZzA+yCnCxRjuDiIKLh8o6vMYEKwgxvcFg9K
   wkjstITDCMMpLIJGC2olE5HGTUpomhqaeCv/w6qxowtZnaZLZS6jBPvPO
   KEVNOjqVT0H370JlNYdvL7LPS7+mxhb3fEgUCD+lbQ51Ae3HYxUV1chCl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="372784889"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="372784889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 12:34:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962138241"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962138241"
Received: from sbaral-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.104.77])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 12:34:00 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl/region: refactor decoder allocation for region refs
Date:   Fri, 28 Oct 2022 13:33:51 -0600
Message-Id: <20221028193351.408950-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6531; h=from:subject; bh=quItP1YTeb6TsLEiBkKR2uxEEEOjKT7XpjylK3Td9qc=; b=owGbwMvMwCXGf25diOft7jLG02pJDMkxet0f+5+Kenqo5UU8L2347isis1lsieBWBY6ET0UL7Kao dtp0lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCIl7Qx/ZZbtn/REgkuh4u5C9RUCW3 L9r8UaGXb3KvFu/pnuzBXYzfCL+XvwfJ1QBvncFst9bU9WVWywdH7gcvFJquJ+x7dKL2V5AQ==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When an intermediate port's decoders have been exhausted by existing
regions, and creating a new region with the port in question in it's
hierarchical path is attempted, cxl_port_attach_region() fails to find a
port decoder (as would be expected), and drops into the failure / cleanup
path.

However, during cleanup of the region reference, a sanity check attempts
to dereference the decoder, which in the above case didn't exist. This
causes a NULL pointer dereference BUG.

To fix this, refactor the decoder allocation and de-allocation into
helper routines, and in this 'free' routine, check that the decoder,
@cxld, is valid before attempting any operations on it.

Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/cxl/core/region.c | 164 +++++++++++++++++++++++---------------
 1 file changed, 99 insertions(+), 65 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 401148016978..78176f7ccff3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -686,18 +686,27 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 	return cxl_rr;
 }
 
-static void free_region_ref(struct cxl_region_ref *cxl_rr)
+static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
 {
-	struct cxl_port *port = cxl_rr->port;
 	struct cxl_region *cxlr = cxl_rr->region;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 
+	if (!cxld)
+		return;
+
 	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
 	if (cxld->region == cxlr) {
 		cxld->region = NULL;
 		put_device(&cxlr->dev);
 	}
+}
 
+static void free_region_ref(struct cxl_region_ref *cxl_rr)
+{
+	struct cxl_port *port = cxl_rr->port;
+	struct cxl_region *cxlr = cxl_rr->region;
+
+	cxl_rr_free_decoder(cxl_rr);
 	xa_erase(&port->regions, (unsigned long)cxlr);
 	xa_destroy(&cxl_rr->endpoints);
 	kfree(cxl_rr);
@@ -728,6 +737,83 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	return 0;
 }
 
+static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				struct cxl_endpoint_decoder *cxled,
+				bool *nr_targets_inc)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_ref *cxl_rr;
+	struct cxl_decoder *cxld;
+	unsigned long index;
+
+	cxl_rr = cxl_rr_load(port, cxlr);
+	if (cxl_rr) {
+		struct cxl_ep *ep_iter;
+		int found = 0;
+
+		/*
+		 * Walk the existing endpoints that have been attached to
+		 * @cxlr at @port and see if they share the same 'next' port
+		 * in the downstream direction. I.e. endpoints that share common
+		 * upstream switch.
+		 */
+		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
+			if (ep_iter == ep)
+				continue;
+			if (ep_iter->next == ep->next) {
+				found++;
+				break;
+			}
+		}
+
+		/*
+		 * New target port, or @port is an endpoint port that always
+		 * accounts its own local decode as a target.
+		 */
+		if (!found || !ep->next) {
+			cxl_rr->nr_targets++;
+			*nr_targets_inc = true;
+		}
+
+		/*
+		 * The decoder for @cxlr was allocated when the region was first
+		 * attached to @port.
+		 */
+		cxld = cxl_rr->decoder;
+	} else {
+		cxl_rr = alloc_region_ref(port, cxlr);
+		if (IS_ERR(cxl_rr)) {
+			dev_dbg(&cxlr->dev,
+				"%s: failed to allocate region reference\n",
+				dev_name(&port->dev));
+			return PTR_ERR(cxl_rr);
+		}
+		*nr_targets_inc = true;
+
+		if (port == cxled_to_port(cxled))
+			cxld = &cxled->cxld;
+		else
+			cxld = cxl_region_find_decoder(port, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			return -ENXIO;
+		}
+
+		if (cxld->region) {
+			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
+				dev_name(&port->dev), dev_name(&cxld->dev),
+				dev_name(&cxld->region->dev));
+			return -EBUSY;
+		}
+
+		cxl_rr->decoder = cxld;
+	}
+
+	return 0;
+}
+
 /**
  * cxl_port_attach_region() - track a region's interest in a port by endpoint
  * @port: port to add a new region reference 'struct cxl_region_ref'
@@ -761,75 +847,23 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	struct cxl_region_ref *cxl_rr;
 	bool nr_targets_inc = false;
 	struct cxl_decoder *cxld;
-	unsigned long index;
 	int rc = -EBUSY;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
+	rc = cxl_rr_alloc_decoder(port, cxlr, cxled, &nr_targets_inc);
+	if (rc)
+		goto out_erase;
+
 	cxl_rr = cxl_rr_load(port, cxlr);
-	if (cxl_rr) {
-		struct cxl_ep *ep_iter;
-		int found = 0;
-
-		/*
-		 * Walk the existing endpoints that have been attached to
-		 * @cxlr at @port and see if they share the same 'next' port
-		 * in the downstream direction. I.e. endpoints that share common
-		 * upstream switch.
-		 */
-		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
-			if (ep_iter == ep)
-				continue;
-			if (ep_iter->next == ep->next) {
-				found++;
-				break;
-			}
-		}
-
-		/*
-		 * New target port, or @port is an endpoint port that always
-		 * accounts its own local decode as a target.
-		 */
-		if (!found || !ep->next) {
-			cxl_rr->nr_targets++;
-			nr_targets_inc = true;
-		}
-
-		/*
-		 * The decoder for @cxlr was allocated when the region was first
-		 * attached to @port.
-		 */
-		cxld = cxl_rr->decoder;
-	} else {
-		cxl_rr = alloc_region_ref(port, cxlr);
-		if (IS_ERR(cxl_rr)) {
-			dev_dbg(&cxlr->dev,
-				"%s: failed to allocate region reference\n",
-				dev_name(&port->dev));
-			return PTR_ERR(cxl_rr);
-		}
-		nr_targets_inc = true;
-
-		if (port == cxled_to_port(cxled))
-			cxld = &cxled->cxld;
-		else
-			cxld = cxl_region_find_decoder(port, cxlr);
-		if (!cxld) {
-			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-				dev_name(&port->dev));
-			goto out_erase;
-		}
-
-		if (cxld->region) {
-			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
-				dev_name(&port->dev), dev_name(&cxld->dev),
-				dev_name(&cxld->region->dev));
-			rc = -EBUSY;
-			goto out_erase;
-		}
-
-		cxl_rr->decoder = cxld;
+	if (!cxl_rr) {
+		dev_dbg(&cxlr->dev,
+			"%s: expected to find a region reference but failed\n",
+			dev_name(&port->dev));
+		rc = -ENXIO;
+		goto out_erase;
 	}
+	cxld = cxl_rr->decoder;
 
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
-- 
2.37.3

