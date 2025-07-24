Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E862DEA80;
	Thu, 24 Jul 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367111; cv=none; b=Q9Hvk9cg1nu/f94Nsp5hwJrMZSuWBWPO0uRe7NzZpHi4Ep/wA0BeOne+EpkbOLMD+KSJr4O/S76BApabkNgInODWGJ0LiFzm2gCg1cKcGIQcsMdWcSLgPawxlfDMgQcY9J4LYlNvirFDw6LoNQFMmQJ+fMMSJPo7nRKzxHaAyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367111; c=relaxed/simple;
	bh=15ZHWHaWRSiwY6M4f3gJGxIPd+lGYskyqPDvKluQqrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJSBwR4jtKzHaMxnoRzq4qdJaFpGroIQr8eVKNwXkXPXHqB/7Pzbx1W79sLkW4aQfVLHw7ynH5WOrmOtyhGhQHVpyB1lHELU/+Kq9EImrSHVsMsZhk3ypeGxbTn0mJwaFV2XaSOlaLl2BibN4NJl1bo25OAplIE6LQmALcbARj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB8gkU2F; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB8gkU2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753367109; x=1784903109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15ZHWHaWRSiwY6M4f3gJGxIPd+lGYskyqPDvKluQqrs=;
  b=lB8gkU2FHwcDLvT1tGbRtNHfw8kIvY1xEb8XiUNZmklzNWxDdLcbvx+u
   z16EK8g67XrcPRQnsDNz5Iah7DAugWERPaPo1zzdFkceJ8CInIkq0sBw3
   XshrbyazErvyMkfqZNHP870SFkrf3gM2aYbofC3wIoaeKKVbKOc0vKj2/
   pIZl2odRiMjsQ8FCtChRibIMDZDiS2OnVDN1dvnmN+/HSMFe5VvHuc3OP
   LKoj1/+a4eWx2WfU6HqMDbhIOekVqLIvcgNrvszcD9DHqoqWMHK56LWgZ
   /j1yUH/tg2bMtwteCOOdGdCsocMl4In0QvNsdbggcFlxGMyovd6wSpDLT
   w==;
X-CSE-ConnectionGUID: YyYr5DQvS7GDcv01rjfumw==
X-CSE-MsgGUID: iwkuu8v7QUuo5Ovowo6OMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66250230"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66250230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:09 -0700
X-CSE-ConnectionGUID: gElxmOdPQjK7VQylqlsuWg==
X-CSE-MsgGUID: t3neb0kcTNaxww2WsG9ELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160245690"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:04 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/4 v4] cxl/core: Change match_*_by_range() signatures
Date: Thu, 24 Jul 2025 16:20:31 +0200
Message-ID: <20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
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
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 60 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..f607e7f97184 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1759,27 +1759,29 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static int match_switch_decoder_by_range(struct device *dev,
-					 const void *data)
+static int match_switch_and_ep_decoders(struct device *dev, const void *data)
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
@@ -1789,8 +1791,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
-				match_switch_decoder_by_range);
+	dev = device_find_child(&parent->dev, cxled,
+				match_switch_and_ep_decoders);
 	if (!dev) {
 		dev_err(port->uport_dev,
 			"failed to find decoder mapping %#llx-%#llx\n",
@@ -1876,7 +1878,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
 		if (rc)
 			return rc;
 
@@ -3215,24 +3217,28 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, const void *data)
+static int match_root_and_ep_decoders(struct device *dev, const void *data)
 {
-	const struct range *r1, *r2 = data;
-	struct cxl_decoder *cxld;
+	const struct cxl_endpoint_decoder *cxled = data;
+	const struct range *r1, *r2;
+	struct cxl_root_decoder *cxlrd;
 
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
+	struct device *cxld_dev = device_find_child(&port->dev, cxled,
+						    match_root_and_ep_decoders);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
 }
@@ -3244,9 +3250,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_root_decoder(&cxl_root->port, cxled);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
@@ -3258,11 +3263,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	return to_cxl_root_decoder(&root->dev);
 }
 
-static int match_region_by_range(struct device *dev, const void *data)
+static int match_region_and_ep_decoder(struct device *dev, const void *data)
 {
+	const struct cxl_endpoint_decoder *cxled = data;
+	const struct range *r = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	const struct range *r = data;
 
 	if (!is_cxl_region(dev))
 		return 0;
@@ -3425,12 +3431,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
+				       match_region_and_ep_decoder);
 	if (!region_dev)
 		return NULL;
 
@@ -3439,7 +3446,6 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3455,7 +3461,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

