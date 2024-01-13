Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9FE574
	for <linux-cxl@vger.kernel.org>; Sat, 13 Jan 2024 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2gm28Ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705122274; x=1736658274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0z+WEP3a7M8V5YMLrvGXRW4viJZ/EJvMEksVD8r6O6s=;
  b=b2gm28AgHEtYCHRi5ITUyKsmioTpUrFMgImGV5hmG52IAycf2sMt+I+v
   lqVfSuXVoF/C4/r4770xFeubeWISvn/Wm4ZMHx/DoS7W74QB1kw01Czba
   Udhfx/EvdNC7MugbsBMwl5Sc6mz4N5sm+EghTY6gcTdAez7iQVXRYTJOV
   ZUhdFZ+f4W5othtZU1C5Fzv17UGYTB8zLuZy/plJevf2/b1oZgo2GVf8h
   LjE2D7PI6hu5wF2hiZ6FTGM+zNBsQVhpe1d/lsF2Nkc3cCO7DtU5FNF+X
   knT0HUl2sruizWQ64Iv9fh6oovjJ5nM3vi7H7Y7a+L+AkIx3uCDxHDUWr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="430522211"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="430522211"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 21:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="926600880"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="926600880"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.105.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 21:04:26 -0800
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
Subject: [RFC PATCH] cxl/region: Allow out of order assembly of autodiscovered regions
Date: Fri, 12 Jan 2024 21:04:21 -0800
Message-Id: <20240113050421.1622533-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Wonjae Lee,

Here is the RFC Patch I mentioned in this thread:
https://lore.kernel.org/linux-cxl/20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5/

This passes the cxl-test suite, so hoping no regression, but it needs
to be tested with the required config: 2 memdevs connected to the same
port, each memdev belongs to a different auto-region. Repeated attempts
should hit the test case and emit this debug message upon success:
	dev_dbg(&cxlr_a->dev, "allow out of order region ref alloc\n");

Failure will be the HPA order violation message.

All reviewers & testers welcomed.

Begin commit log:
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
out of order assembly after a sanity check that the lowered numbered
decoder has the lower HPA starting address.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..8770ebcae05d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -753,6 +753,37 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
 	return to_cxl_decoder(dev);
 }
 
+bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_a,
+		   struct cxl_region *cxlr_b)
+{
+	struct cxl_region_ref *cxl_rr;
+	struct cxl_decoder *cxld_a, *cxld_b;
+
+	/*
+	 * Allow the out of order assembly of auto-discovered regions as
+	 * long as correct decoder programming order can be verified.
+	 *
+	 * Per CXL Spec 3.1 8.2.4.20.12 Committing Decoder Programming,
+	 * software must commit decoders in HPA order. Therefore it is
+	 * sufficient to sanity check that the lowered number decoder
+	 * has the lower HPA starting address.
+	 */
+	if (!test_bit(CXL_REGION_F_AUTO, &cxlr_a->flags))
+		return false;
+
+	cxld_a = cxl_region_find_decoder(port, cxlr_a);
+	cxl_rr = cxl_rr_load(port, cxlr_b);
+	cxld_b = cxl_rr->decoder;
+
+	if (cxld_b->id > cxld_a->id) {
+		dev_dbg(&cxlr_a->dev,
+			"allow out of order region ref alloc\n");
+		return true;
+	}
+
+	return false;
+}
+
 static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 					       struct cxl_region *cxlr)
 {
@@ -767,7 +798,8 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 		if (!ip->res)
 			continue;
 
-		if (ip->res->start > p->res->start) {
+		if (ip->res->start > p->res->start &&
+		    (!auto_order_ok(port, cxlr, iter->region))) {
 			dev_dbg(&cxlr->dev,
 				"%s: HPA order violation %s:%pr vs %pr\n",
 				dev_name(&port->dev),

base-commit: 3601311593eb44d34f142b993cb6f38f9a7863b3
-- 
2.37.3

