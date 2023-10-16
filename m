Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC611883B
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEFaWHTe"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986BBDC
	for <linux-cxl@vger.kernel.org>; Sun, 15 Oct 2023 23:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697436153; x=1728972153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PuZ9Ug4SS04faw88g7L9mYISaIN9qbUDV4VbyaSujqs=;
  b=YEFaWHTehfBtSIi00FI1OMjgmUvqcSTNyNotX/RXtkOn5UYXMCBMVc6J
   iABBSbRpmDV3L92piGdNCyRaT1a4r1ebYRUyyRX4lhQnqNpMUAWA35Wfn
   ah6gFX1VpgdR4nFtOjaSl+G3Lien/MY+zGJdkbGsVxjqJgdfSl1EesjQF
   xE+mRXqvNhOeI/S5ixHHgEibmhfwsKlYJZrXa5PL5G69R3r4MUaEt+Q+I
   1G2A9UDBLzhwD5+vCpjXly1KJDFjDN9eWnHWCTpXJ9Y4UboaBpepoyK5k
   FN9Rw/TvpjrFyeUDh8DsKmdfbVu3yhBUHuvfYPJlROOn85r497S2y7CSi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365714350"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365714350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899361969"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899361969"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.62.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:00:34 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/3] cxl/region: Prepare the decoder match range helper for reuse
Date: Sun, 15 Oct 2023 23:02:26 -0700
Message-Id: <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1697433770.git.alison.schofield@intel.com>
References: <cover.1697433770.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alison Schofield <alison.schofield@intel.com>

match_decoder_by_range() and decoder_match_range() both determine
if an HPA range matches a decoder. The first does it for root
decoders and the second one operates on switch decoders.

Tidy these up with clear naming and make the switch helper more
like the root decoder helper in style and functionality. Make it
take the actual range, rather than an endpoint decoder from which
it extracts the range.

Aside from aesthetics and maintainability, this is in preparation
for reuse.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d63b8798c29..64206fc4d99b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1487,16 +1487,19 @@ static struct cxl_port *next_port(struct cxl_port *port)
 	return port->parent_dport->port;
 }
 
-static int decoder_match_range(struct device *dev, void *data)
+static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
-	struct cxl_endpoint_decoder *cxled = data;
+	struct range *r1, *r2 = data;
 	struct cxl_switch_decoder *cxlsd;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxlsd = to_cxl_switch_decoder(dev);
-	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
+	r1 = &cxlsd->cxld.hpa_range;
+	return range_contains(r1, r2);
+}
+
 }
 
 static void find_positions(const struct cxl_switch_decoder *cxlsd,
@@ -1565,7 +1568,8 @@ static int cmp_decode_pos(const void *a, const void *b)
 		goto err;
 	}
 
-	dev = device_find_child(&port->dev, cxled_a, decoder_match_range);
+	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
+				match_switch_decoder_by_range);
 	if (!dev) {
 		struct range *range = &cxled_a->cxld.hpa_range;
 
@@ -2696,7 +2700,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, void *data)
+static int match_root_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
 	struct cxl_root_decoder *cxlrd;
@@ -2827,7 +2831,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	int rc;
 
 	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
-				      match_decoder_by_range);
+				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-- 
2.37.3

