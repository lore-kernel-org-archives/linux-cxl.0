Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404C2E8E08;
	Tue, 18 Nov 2025 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495018; cv=none; b=IAlJbqzGtHPH22rFWkHKhS2FO5bNeODBUDeObpdvljuG/hpFxtewwD1C6R0K/oDjNBINtsokq5Pe+ARZyju7sBTq3iZdzrsoacQvtOJep8fXXptwlnxbXGrJpNFo//EnKqMVpxYGUn57BtUNzLVNIaaBaFNt5mjk82AQ19gvEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495018; c=relaxed/simple;
	bh=BZKAUD2jI/0P2DXfhI1kWtAYI6dS9xMGH214FHWrl4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6Tx3WUtHuuwBNiLuiIKcWvqyCEI9A67lmSrqZgHWdeosFzgMRVzj//3Kd0VgUTH0OFOPNeAOj/aD/phcLzgF06fOmYcxeKYgc46vQtYpH4/2XiZvHr8POi9X8ik9miHsdLFzOsyjk0fcUCjucczye/a/PhmbR4n5Wppw7lZtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/xvceZz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/xvceZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763495016; x=1795031016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZKAUD2jI/0P2DXfhI1kWtAYI6dS9xMGH214FHWrl4k=;
  b=Y/xvceZzhqfSzlpU/4tXSk2VDhskf6P1MmHGkzmxgE0dAc+14bXntv+j
   g/0nLObI/r3Kp89YJM/vY92v/hFdYWVu8aNJvssNMsmysP8GBgdBQhVuF
   PfE/LFbiM9IcDnHHZDVRCDwsAUCq0uhKDWbY2YoXiqGFRT4THOhs2qPHr
   u4QWfv5pC/XmUfe7D4P1FjVYEWzh0Nq0uvGCHAzow9qqg2jl31ulce6N+
   TTQ8PCUqeQD7ab74ttAtCTZVq1mouimsgNyurZaf898irx6ZV+cEiSDzY
   VPA5ELNxWClb15c7ODswi7UdkKBEyiJhCXgLvdaq4/DmqUczNftqZOeqf
   Q==;
X-CSE-ConnectionGUID: HWVmaeuISIaL1YpK3cWLhg==
X-CSE-MsgGUID: 0u2kfoluTJi+xDhFTYbL9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76138688"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76138688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:43:36 -0800
X-CSE-ConnectionGUID: QZQLcLFfTka0h/lTc4v4iA==
X-CSE-MsgGUID: PzsnsNtiSN+KoU+hJkPyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="228188890"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:43:32 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/4 v6] cxl/core: Change match_*_by_range() signatures
Date: Tue, 18 Nov 2025 20:43:03 +0100
Message-ID: <20251118194321.1773484-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
References: <20251118194321.1773484-1-fabio.m.de.francesco@linux.intel.com>
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
specific Root Decoders and Region matching with Switch and Endpoint
Decoders.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 62 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2cf5b29cefd2..315481444eb0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1808,27 +1808,29 @@ static int cmp_interleave_pos(const void *a, const void *b)
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
@@ -1838,8 +1840,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
-				match_switch_decoder_by_range);
+	dev = device_find_child(&parent->dev, cxled,
+				match_cxlsd_to_cxled_by_range);
 	if (!dev) {
 		dev_err(port->uport_dev,
 			"failed to find decoder mapping %#llx-%#llx\n",
@@ -1925,7 +1927,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
 		if (rc)
 			return rc;
 
@@ -3457,24 +3459,30 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
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
@@ -3486,9 +3494,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_root_decoder(&cxl_root->port, cxled);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
@@ -3500,11 +3507,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
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
@@ -3663,12 +3671,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
 
@@ -3677,7 +3686,6 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3693,7 +3701,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, cxled);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.51.1

