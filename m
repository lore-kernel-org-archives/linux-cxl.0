Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA22D8DB9;
	Mon,  6 Oct 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766339; cv=none; b=pPU57TlYS5RRRc2CN//7FrACiT/Z2nuzoJiBQu5KQJkKDOTxZ6lUWgjqj6zr1VON7ta2a+WKtnmrbyx1sDvkEnir1MCiqoZroAsXlHHRA65owW8PFjNpJRUFFJg0ztfAqGTO/DtU39qqA3U4ZeAlorGPvzV6bZmHmtai25vYvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766339; c=relaxed/simple;
	bh=tICIjNuKpUmKFK93meEYeXqkDKxdYHSUFm3JlHZZWuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbdlY0RRaGLsBKJbBmqNS+F0azNB1884nnMbjt3Q++OuYsKZ2oHKkhwcAIKGibnMooeGG51QN0PdqKvn9sizpHub9gzoiZsIMhP5yTzV/3z/Vx/hEolOsxvsc6G6nml51mW52HnUrl8hjxDo6EuRi2ldHZu5vTCdq+DkrS6TWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG3cTR1V; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG3cTR1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759766337; x=1791302337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tICIjNuKpUmKFK93meEYeXqkDKxdYHSUFm3JlHZZWuA=;
  b=MG3cTR1Vd9UDT6v/PQ8vCLK05AyUsRf/dAFrWIuxlk2clsExYBPNjWTq
   +e/SOiY9f0wsmKjM98Gg7qlI6mp41ngytnrb8cYjgGr/7gGwaVtEpnLV6
   xRTWpFVUnWCRgw1+vi2Xbky4cLxTUT06DNd2yXApsb3w8uvaJEEWrI7VB
   hfszO/EArrGNYVWJXmyw0dSPepcs0cuznsRhztXYe/I8jBu4Hfq3+Hokc
   8/aoVfMJtmcdOUlNM86lpwZIOOF63e9MSVFLDZmTOj4MXmagrdPtsJLUn
   8jxiI94SREUAi3Yp5oGiW9GJyY/FXXDDHxgiIiYaJyaS0v0MhuIpiNn/q
   A==;
X-CSE-ConnectionGUID: t2NhwkHtSFetpd4BeMHcEg==
X-CSE-MsgGUID: Cs2LJbkiSKaWzJQc/1uYgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61150562"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61150562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:54 -0700
X-CSE-ConnectionGUID: Bl2oNqNPQgmC5nzGI+gq6Q==
X-CSE-MsgGUID: TZbgicnSSvm7lvsVGzj25g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="185189577"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.245.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:49 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/4 v5] cxl/core: Change match_*_by_range() signatures
Date: Mon,  6 Oct 2025 17:58:04 +0200
Message-ID: <20251006155836.791418-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace struct range parameter with struct cxl_endpoint_decoder of
which range is a member in the match_*_by_range() functions and rename
them according to their semantics.

This is in preparation for expanding these helpers to perform arch
specific Root Decoders and Region matchings with
cxl_endpoint_decoder(s).

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 62 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e14c1d305b22..43a854036202 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1766,27 +1766,29 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static int match_switch_decoder_by_range(struct device *dev,
-					 const void *data)
+static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
 {
+	const struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
-	const struct range *r1, *r2 = data;
-
+	const struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxlsd = to_cxl_switch_decoder(dev);
 	r1 = &cxlsd->cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
 
 	if (is_root_decoder(dev))
 		return range_contains(r1, r2);
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
-static int find_pos_and_ways(struct cxl_port *port, struct range *range,
-			     int *pos, int *ways)
+static int find_pos_and_ways(struct cxl_port *port,
+			     struct cxl_endpoint_decoder *cxled, int *pos,
+			     int *ways)
 {
+	struct range *range = &cxled->cxld.hpa_range;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
 	struct device *dev;
@@ -1796,8 +1798,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
-				match_switch_decoder_by_range);
+	dev = device_find_child(&parent->dev, cxled,
+				match_cxlsd_to_cxled_by_range);
 	if (!dev) {
 		dev_err(port->uport_dev,
 			"failed to find decoder mapping %#llx-%#llx\n",
@@ -1883,7 +1885,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
 		if (rc)
 			return rc;
 
@@ -3342,24 +3344,30 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, const void *data)
+static int match_cxlrd_to_cxled_by_range(struct device *dev, const void *data)
 {
-	const struct range *r1, *r2 = data;
-	struct cxl_decoder *cxld;
+	const struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_root_decoder *cxlrd;
+	const struct range *r1, *r2;
 
-	if (!is_switch_decoder(dev))
+	if (!is_root_decoder(dev))
 		return 0;
 
-	cxld = to_cxl_decoder(dev);
-	r1 = &cxld->hpa_range;
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+
 	return range_contains(r1, r2);
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_root_decoder(struct cxl_port *port,
+			   struct cxl_endpoint_decoder *cxled)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
-						    match_decoder_by_range);
+	struct device *cxld_dev;
+
+	cxld_dev = device_find_child(&port->dev, cxled,
+				     match_cxlrd_to_cxled_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
 }
@@ -3371,9 +3379,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_root_decoder(&cxl_root->port, cxled);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
@@ -3385,11 +3392,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	return to_cxl_root_decoder(&root->dev);
 }
 
-static int match_region_by_range(struct device *dev, const void *data)
+static int match_region_to_cxled_by_range(struct device *dev, const void *data)
 {
+	const struct cxl_endpoint_decoder *cxled = data;
+	const struct range *r = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	const struct range *r = data;
 
 	if (!is_cxl_region(dev))
 		return 0;
@@ -3547,12 +3555,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 }
 
 static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
+			 struct cxl_endpoint_decoder *cxled)
 {
 	struct device *region_dev;
 
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				       match_region_by_range);
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
+				       match_region_to_cxled_by_range);
 	if (!region_dev)
 		return NULL;
 
@@ -3561,7 +3570,6 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3577,7 +3585,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, cxled);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.50.1

