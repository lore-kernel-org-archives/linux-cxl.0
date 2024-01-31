Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787446AC0
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666854; cv=none; b=NjILN8P3ElhO6ezNQ6PykDXiQEKfmpFQ9pnLGm/Tk9K4+Mk615/UY0vTEeMrVf5nl0uwDBgutKyYrpBBu/6sSSiu+zqmQSC2pNcwTl1dPdVz/S3pIXo+SXaVUYuZD4CK0tJuVpZUBgkka/SiZq+SjXpUMYhNh6DN77uYgD4PBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666854; c=relaxed/simple;
	bh=dPwWttDeBg99hP6/7h007PtNjhnDWUtzih+Bdp1ZH4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taNzBKsDaoUhiQ6J243gdq/js8/SUMxM78HZ5jt9UoS7PbRIOGdxBwCyXb6wJSYgGxLKXGi+VPMswSJPSmPAAvRz9Vwf7cnWKLLBgeflDlQftQNTWg0x9Qxw0AmD0OcE1mN6WY4yhftBFQvPzXknAlIi0J4PVX80frd+bPwTnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxmip6Hw; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxmip6Hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706666852; x=1738202852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dPwWttDeBg99hP6/7h007PtNjhnDWUtzih+Bdp1ZH4A=;
  b=mxmip6HwN/Ab0vc8kPmnT+AJqZST1dX9IbckjAe9JC3KbCYInEOkK8ha
   V3xqqLb60raJL3Pg9Iawg40u1r6X2SNNA3FHBKl+gpe3rYIOKbj9pkPLv
   xSOcrBNY/qe3olqxhptCtTOpdGiWAyM1oJe1zp6+uUezdtPxQujSUTSVX
   ZDdnO56UVBAOrh5DF73EMushkNxZYBLNF8UZDoS1m0ZW2ilRoiJUIR0HF
   9RZGIIdGdns4ofuMFcvXhTa+xw+2j/qmfJlITxTg0aVnblmy1OGGJCQdS
   griM7j60e+eL4139Fli2up4/qgwUPPWaTkF6tTAohh4NUyGC67w83nSRx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403079232"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403079232"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788402375"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788402375"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.40.203])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:07:29 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: [PATCH v2] cxl/region: Allow out of order assembly of autodiscovered regions
Date: Tue, 30 Jan 2024 18:07:26 -0800
Message-Id: <20240131020726.1790160-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Autodiscovered regions can fail to assemble if they are not discovered
in HPA decode order. The user will see failure messages like:

[] cxl region0: endpoint5: HPA order violation region1
[] cxl region0: endpoint5: failed to allocate region reference

The check that is causing the failure helps the CXL driver enforce
a CXL spec mandate that decoders be committed in HPA order. The
check is needless for autodiscovered regions since their decoders
are already programmed. Trying to enforce order in the assembly of
these regions is useless because they are assembled once all their
member endpoints arrive, and there is no guarantee on the order in
which endpoints are discovered during probe.

Keep the existing check, but for autodiscovered regions, allow the
out of order assembly after a sanity check that the lesser numbered
decoder has the lesser HPA starting address.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes since v1: 
- Get decoder via available struct cxled_endpoint_decoder. (Wonjae)
- Check F_AUTO in alloc_region_ref()
- Fold assignments into the declarations in auto_order_ok()
- Drop Tested-by tag due to changes
Link to v1: https://lore.kernel.org/linux-cxl/20240126045446.1750854-1-alison.schofield@intel.com/


 drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..28e8af1e54a2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -753,8 +753,32 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
 	return to_cxl_decoder(dev);
 }
 
-static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
-					       struct cxl_region *cxlr)
+static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
+			  struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region_ref *rr = cxl_rr_load(port, cxlr_iter);
+	struct cxl_decoder *cxld_iter = rr->decoder;
+	struct cxl_decoder *cxld = &cxled->cxld;
+
+	/*
+	 * Allow the out of order assembly of auto-discovered regions.
+	 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
+	 * in HPA order. Confirm that the decoder with the lesser HPA
+	 * starting address has the lesser id.
+	 */
+	dev_dbg(&cxld->dev, "check for HPA violation %s:%d < %s:%d\n",
+		dev_name(&cxld->dev), cxld->id,
+		dev_name(&cxld_iter->dev), cxld_iter->id);
+
+	if (cxld_iter->id > cxld->id)
+		return true;
+
+	return false;
+}
+
+static struct cxl_region_ref *
+alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
+		 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -764,16 +788,17 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 	xa_for_each(&port->regions, index, iter) {
 		struct cxl_region_params *ip = &iter->region->params;
 
-		if (!ip->res)
+		if (!ip->res || ip->res->start < p->res->start)
 			continue;
 
-		if (ip->res->start > p->res->start) {
-			dev_dbg(&cxlr->dev,
-				"%s: HPA order violation %s:%pr vs %pr\n",
-				dev_name(&port->dev),
-				dev_name(&iter->region->dev), ip->res, p->res);
-			return ERR_PTR(-EBUSY);
-		}
+		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
+		    auto_order_ok(port, iter->region, cxled))
+			continue;
+
+		dev_dbg(&cxlr->dev, "%s: HPA order violation %s:%pr vs %pr\n",
+			dev_name(&port->dev),
+			dev_name(&iter->region->dev), ip->res, p->res);
+		return ERR_PTR(-EBUSY);
 	}
 
 	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
@@ -953,7 +978,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr);
+		cxl_rr = alloc_region_ref(port, cxlr, cxled);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.37.3

