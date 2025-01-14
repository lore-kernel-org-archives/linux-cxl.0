Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DC20C479;
	Tue, 14 Jan 2025 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886892; cv=none; b=kEyr1XpmoF8T6nvOj+nEi7x+cJ4o4cCyfuO+tP/pWxMTRSL8VcnvHcIHj/5480PdM/c8vGz2xAs6iog02mw/1X1FekqRoRW1JMntkQry4OI5WpqHbdDXRByEGFqlbpbo359p6UG2pW9VUCEh1wtBDov03YgrBcUUbtIoQidO2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886892; c=relaxed/simple;
	bh=aCrISHIL2GN3gkdhdf+hSyNqCqRx4Ax4D3iKtqhp8gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1S+pxqupv1B8UYxEyRvb06x/Rs6fgikzvi+R8FgVDJP9kCFdkwThk6IqTLZVHRBkGy52XlfiBluaJ4ucVdzoy3l+uKdUSK2n+tfhCowbdWhRCDrpvQhJ6n8XwbcKC7cVRpOKu64YP+OTtnfd8wHEIpE0EfbY4AWpjnlBpyP/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkyjbVPf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkyjbVPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886891; x=1768422891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aCrISHIL2GN3gkdhdf+hSyNqCqRx4Ax4D3iKtqhp8gY=;
  b=XkyjbVPfC+qaH3jDObHveV4iGdC3JK3dGGouTs4YRxCnDm8PCau8nBdY
   u2pxTwh0sOk9LpnEYrdl8EXUtWZMh14dbGDlfhw5ksgKhxf/sHxnE9pRg
   pOE36teRvUoQmo13qy8jZJsnbGRi+nkIKPBinIjoKaI6HIG+HYi1/l3Fb
   LH0KgRu5BdfxIARm89bOVfeohwKHhedBwC2drletlh9I4cSV7/193cS9G
   1RHQdDLJXTbRPOkibT3RoX3KzosZ9KNHfb8T7Cc96PHXRKruI97+5NyHM
   4yjRM3gH39l2mx9YaGJshYD+nWc+YLLU+Wi74Iiq6cqJFZCbTG+WWSBpX
   A==;
X-CSE-ConnectionGUID: tH3QsyloQRC1ABxpc5bzow==
X-CSE-MsgGUID: lw16NpeMSzKK4d1iX+tyFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47693517"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="47693517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:51 -0800
X-CSE-ConnectionGUID: SLgmfPnrTS+XPE/JAfH9EQ==
X-CSE-MsgGUID: jrkPqu5hSzW+pX1x5DIjcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135751342"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:45 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/4 v2] cxl/core: Change match_*_by_range() calling convention
Date: Tue, 14 Jan 2025 21:32:53 +0100
Message-ID: <20250114203432.31861-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace struct range parameter with struct cxl_endpoint_decoder of
which range is a member in the match_*_by_range() functions.

This is in preparation for expanding these helpers to perform arch
specific region matching that requires a cxl_endpoint_decoder.

No functional changes.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b98b1ccffd1ca..9d2c31f5caf26 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1735,23 +1735,27 @@ static struct cxl_port *next_port(struct cxl_port *port)
 
 static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
-	struct range *r1, *r2 = data;
+	struct range *r1, *r2;
 
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
+static int find_pos_and_ways(struct cxl_port *port,
+			     struct cxl_endpoint_decoder *cxled,
 			     int *pos, int *ways)
 {
+	struct range *range = &cxled->cxld.hpa_range;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
 	struct device *dev;
@@ -1761,7 +1765,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
+	dev = device_find_child(&parent->dev, cxled,
 				match_switch_decoder_by_range);
 	if (!dev) {
 		dev_err(port->uport_dev,
@@ -1841,7 +1845,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
 		if (rc)
 			return rc;
 
@@ -3189,22 +3193,26 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 
 static int match_root_decoder_by_range(struct device *dev, void *data)
 {
-	struct range *r1, *r2 = data;
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_root_decoder *cxlrd;
+	struct range *r1, *r2;
 
 	if (!is_root_decoder(dev))
 		return 0;
 
 	cxlrd = to_cxl_root_decoder(dev);
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+
 	return range_contains(r1, r2);
 }
 
 static int match_region_by_range(struct device *dev, void *data)
 {
+	struct cxl_endpoint_decoder *cxled = data;
+	struct range *r = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct range *r = data;
 	int rc = 0;
 
 	if (!is_cxl_region(dev))
@@ -3308,7 +3316,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev, *region_dev;
 	struct cxl_root_decoder *cxlrd;
@@ -3317,7 +3324,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&root->dev, cxled,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
@@ -3334,7 +3341,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
 				       match_region_by_range);
 	if (!region_dev) {
 		cxlr = construct_region(cxlrd, cxled);
-- 
2.47.1

