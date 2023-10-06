Return-Path: <linux-cxl+bounces-2-linux-cxl=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CEDE92FD0
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:43:25 +0000 (UTC)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 3AD8DB209B0
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0210F9;
	Fri,  6 Oct 2023 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXt7/uQ2"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC71629
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:43:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E7D9
	for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696552998; x=1728088998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOMl//pn00QRd6r2+WaDM04A5QY3DAgXUHt/UHxoAaw=;
  b=VXt7/uQ2fhfgXtrDsUHVuCFsgeEebc6Dsnu97FkoT9d29umdZ/X4BwVw
   YHyGtP09wrPC7NruMcpFF27K9xvHJ3FqqVPZxLilUbmw2zA20a4B35Ty3
   avbWb1PEwpO7aM0YpBPf6u2sfu3n8b/kyCr/yEThExqC5bBy7Q5VeBd4M
   EFgRvEEfeT/Envvb9dLzJD8ZoQSiWdE8m5gVfJ1EXSMW7Z3BHGC6yObiW
   AaW1DsLprlEk/nqEzD89EAiaEPhSVdnouQLZtEzx9fXf9H0se+y5Hnzdy
   Q725jF0P+laL8OSB5jZa1H6V7Ddc2eYNx4ag6cSvYo2YaueflyJGFQDbe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363010979"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363010979"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="925781558"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="925781558"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.219.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:43:16 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: [PATCH 1/3] cxl/region: Prepare the decoder match range helper for reuse
Date: Thu,  5 Oct 2023 17:43:11 -0700
Message-Id: <79f1fb5c1756289d1ee02bd6581548aba0718b98.1696550786.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1696550786.git.alison.schofield@intel.com>
References: <cover.1696550786.git.alison.schofield@intel.com>
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
it extracts the range.

Aside from aethetics and maintainability, this is in preparation
for reuse.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
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


