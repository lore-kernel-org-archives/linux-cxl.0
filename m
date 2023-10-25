Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D31328B4
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/KF6ie+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AF812A
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264149; x=1729800149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qF+NcbypEjhRR4/i6wuDTLB5fVJIkgYKMoJr4J6AHy0=;
  b=R/KF6ie+xvwKKc7b6ANh926WoonDbzgIfi9NKuK5SW1khjIz+o8A5Nqx
   vSwUheZpH6JNKo2lat5bnLzdVnOG52ZhDKGv63Bt1ZnjRZOjQ2ws5f4ax
   rP/CkjaMkGQAznoTAiUekMq8/ocOPcq9foXD+1+zbR59EaIWiB5qfIFX3
   4sIpxRNJcaVy8cfMReRvsCsfUxaIJjom5Sw84HvtoQiq3tOTyw/H5JnI1
   LD1y3iR4abOl78e2eQJemjrTAHsGqdQpINK13OG+30gJ+DOYqeNo/49QO
   8pgNB6DDKH0vq2eYQGBSgHkHhPIB0fhpVlJHPqaMoySXLeNMjByYu7bnS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="473624398"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="473624398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902664745"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902664745"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.181.198])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:59:13 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jim Harris <jim.harris@samsung.com>
Subject: [PATCH v4 1/3] cxl/region: Prepare the decoder match range helper for reuse
Date: Wed, 25 Oct 2023 13:01:32 -0700
Message-Id: <011b1f498e1758bb8df17c5951be00bd8d489e3b.1698263080.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1698263080.git.alison.schofield@intel.com>
References: <cover.1698263080.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

match_decoder_by_range() and decoder_match_range() both determine
if an HPA range matches a decoder. The first does it for root
decoders and the second one operates on switch decoders.

Tidy these up with clear naming and make the switch helper more
like the root decoder helper in style and functionality. Make it
take the actual range, rather than an endpoint decoder from which
it extracts the range. Require an exact match on switch decoders,
because unlike a root decoder that maps an entire region, Linux
only supports 1:1 mapping of switch to endpoint decoders.

Aside from aesthetics and maintainability, this is in preparation
for reuse.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jim Harris <jim.harris@samsung.com>
---
 drivers/cxl/core/region.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d63b8798c29..eea8e89a6860 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1487,16 +1487,18 @@ static struct cxl_port *next_port(struct cxl_port *port)
 	return port->parent_dport->port;
 }
 
-static int decoder_match_range(struct device *dev, void *data)
+static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
-	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
+	struct range *r1, *r2 = data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxlsd = to_cxl_switch_decoder(dev);
-	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
+	r1 = &cxlsd->cxld.hpa_range;
+
+	return (r1->start == r2->start && r1->end == r2->end);
 }
 
 static void find_positions(const struct cxl_switch_decoder *cxlsd,
@@ -1565,7 +1567,8 @@ static int cmp_decode_pos(const void *a, const void *b)
 		goto err;
 	}
 
-	dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
+	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
+				match_switch_decoder_by_range);
 	if (!dev) {
 		struct range *range = &cxled_a->cxld.hpa_range;
 
@@ -2696,7 +2699,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, void *data)
+static int match_root_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
 	struct cxl_root_decoder *cxlrd;
@@ -2827,7 +2830,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	int rc;
 
 	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
-				      match_decoder_by_range);
+				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-- 
2.37.3

