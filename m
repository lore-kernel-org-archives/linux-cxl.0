Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9F3C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 07:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKAHlI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Nov 2022 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKAHlG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Nov 2022 03:41:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9CA165AC
        for <linux-cxl@vger.kernel.org>; Tue,  1 Nov 2022 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667288465; x=1698824465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6kSDR8zizdo9fZj+8CplAs7Zf79ChbKd1lpettJItNs=;
  b=HP1ByJjnbxUbaZqdIUN0BhIVfzh4Wmsqfzll1aqkt2CebvB5stZqZYpE
   jH6TMEjRfi9gCnpMz2klOLo3orHayT6a096oewd/nuC5KnvjAvAlt/w6a
   USLweGpgrhXy6UV2LZeoHUMVyLicm0B9AIE4QftHoDqXVaf8rQ0kaEHjN
   F4iioQo6pRbqQLITHHtMh9IVbYl/YhvZ7xL/QcMBfwvUUanYIRx66s9LB
   MwOREaWXSbulin7MPBI83Hwb+errRbtTN+vnXdxXmGMXSguqPa88uK+W7
   NhRWZ6AN0xHsJVIJyk3fzRnwG1FiXAIJSH80fyrraThTFRZA3cQU8Ryfy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310181190"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="310181190"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:41:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="636328441"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="636328441"
Received: from dbombien-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.86.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:41:05 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2] cxl/region: refactor decoder allocation for region refs
Date:   Tue,  1 Nov 2022 01:41:00 -0600
Message-Id: <20221101074100.1732003-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4369; h=from:subject; bh=6kSDR8zizdo9fZj+8CplAs7Zf79ChbKd1lpettJItNs=; b=owGbwMvMwCXGf25diOft7jLG02pJDMkJZzu2nBVs5+5K1nN9b/m271NvRd0X9h0/Mzt3zfF3qtR/ d3xVRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACYyfwsjQzt/cUVwxVc5tfa511V5Ji ipbtik81ZMznOhRDnnkw8fVRgZfu+Z/Ey7YnLF66hLFwq0O12urTG9Pr1m55u/l29U+p224QYA
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
 drivers/cxl/core/region.c | 67 ++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 26 deletions(-)

Changes since v1[1]:
- Limit the new decoder alloc helper to only the decoder allocation for
  new cxl_region_ref objects, not retrieval for existing refs (Dan).

[1]: https://lore.kernel.org/linux-cxl/89acba4011d03582a1f81feb376915b826020cee.camel@intel.com


diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 401148016978..986855e93e71 100644
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
@@ -728,6 +737,33 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	return 0;
 }
 
+static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				struct cxl_endpoint_decoder *cxled,
+				struct cxl_region_ref *cxl_rr)
+{
+	struct cxl_decoder *cxld;
+
+	if (port == cxled_to_port(cxled))
+		cxld = &cxled->cxld;
+	else
+		cxld = cxl_region_find_decoder(port, cxlr);
+	if (!cxld) {
+		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+			dev_name(&port->dev));
+		return -EBUSY;
+	}
+
+	if (cxld->region) {
+		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
+			dev_name(&port->dev), dev_name(&cxld->dev),
+			dev_name(&cxld->region->dev));
+		return -EBUSY;
+	}
+
+	cxl_rr->decoder = cxld;
+	return 0;
+}
+
 /**
  * cxl_port_attach_region() - track a region's interest in a port by endpoint
  * @port: port to add a new region reference 'struct cxl_region_ref'
@@ -794,12 +830,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			cxl_rr->nr_targets++;
 			nr_targets_inc = true;
 		}
-
-		/*
-		 * The decoder for @cxlr was allocated when the region was first
-		 * attached to @port.
-		 */
-		cxld = cxl_rr->decoder;
 	} else {
 		cxl_rr = alloc_region_ref(port, cxlr);
 		if (IS_ERR(cxl_rr)) {
@@ -810,26 +840,11 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		if (port == cxled_to_port(cxled))
-			cxld = &cxled->cxld;
-		else
-			cxld = cxl_region_find_decoder(port, cxlr);
-		if (!cxld) {
-			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-				dev_name(&port->dev));
+		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		if (rc)
 			goto out_erase;
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
 	}
+	cxld = cxl_rr->decoder;
 
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
-- 
2.37.3

