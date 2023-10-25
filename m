Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06022D631
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LweWniiY"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B83C136
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264159; x=1729800159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20k6YZpL/4ffq5JLSIm2KQZx3A3S16vpLTCe7vXHfK8=;
  b=LweWniiY9/pPo5lvl23KHQI9blRxP/NRsDA1Rh4Jl8cDVp0R5POjv+VN
   NbiYo7hRa9f+h0JNldiGZxkycRmRmbaTfipnNAxxP5DVm+OZ7pWNEs+yA
   A82qgpTSAdNHLtCP2Fk3UllL4WhZ98wymgORjeEOzeQlWg51KTzFpAzZd
   b44egTbA5GY48vrwFr0wGuznhQnzcf0sqGP8YSI46p84E95tpd3SehT/2
   5KAX1g7AXK7KPiayGk/Uk4NHXctrLRjwT3/hCOaV8AiNz0hlpVgjfNibT
   soSElH4p8/v8hAqmRjMFydCWWCf1ATLP+Hkj2+6weAX1jdn1NjhS9tcuu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="473624497"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="473624497"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902664758"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902664758"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.181.198])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:59:16 -0700
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
	Jim Harris <jim.harris@samsung.com>
Subject: [PATCH v4 3/3] cxl/region: Use cxl_calc_interleave_pos() for auto-discovery
Date: Wed, 25 Oct 2023 13:01:34 -0700
Message-Id: <3946cc55ddc19678733eddc9de2c317749f43f3b.1698263080.git.alison.schofield@intel.com>
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

For auto-discovered regions the driver must assign each target to
a valid position in the region interleave set based on the decoder
topology.

The current implementation fails to parse valid decode topologies,
as it does not consider the child offset into a parent port. The sort
put all targets of one port ahead of another port when an interleave
was expected, causing the region assembly to fail.

Replace the existing relative sort with cxl_calc_interleave_pos() that
finds the exact position in a region interleave for an endpoint based
on a walk up the ancestral tree from endpoint to root decoder.

cxl_calc_interleave_pos() was introduced in a prior patch, so the work
here is to use it in cxl_region_sort_targets().

Remove the obsoleted helper functions from the prior sort.

Testing passes on pre-production hardware with BIOS defined regions
that natively trigger this autodiscovery path of the region driver.
Testing passes a CXL unit test using the dev_dbg() calculation test
(see cxl_region_attach()) across an expanded set of region configs:
1, 1, 1+1, 1+1+1, 2, 2+2, 2+2+2, 2+2+2+2, 4, 4+4, where each number
represents the count of endpoints per host bridge.

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jim Harris <jim.harris@samsung.com>
---
 drivers/cxl/core/region.c | 127 +++++---------------------------------
 1 file changed, 15 insertions(+), 112 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 481aab3234bf..ce421b242715 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1480,6 +1480,14 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
 	return 0;
 }
 
+static int cmp_interleave_pos(const void *a, const void *b)
+{
+	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
+	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
+
+	return cxled_a->pos - cxled_b->pos;
+}
+
 static struct cxl_port *next_port(struct cxl_port *port)
 {
 	if (!port->parent_dport)
@@ -1603,131 +1611,26 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	return pos;
 }
 
-static void find_positions(const struct cxl_switch_decoder *cxlsd,
-			   const struct cxl_port *iter_a,
-			   const struct cxl_port *iter_b, int *a_pos,
-			   int *b_pos)
-{
-	int i;
-
-	for (i = 0, *a_pos = -1, *b_pos = -1; i < cxlsd->nr_targets; i++) {
-		if (cxlsd->target[i] == iter_a->parent_dport)
-			*a_pos = i;
-		else if (cxlsd->target[i] == iter_b->parent_dport)
-			*b_pos = i;
-		if (*a_pos >= 0 && *b_pos >= 0)
-			break;
-	}
-}
-
-static int cmp_decode_pos(const void *a, const void *b)
-{
-	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
-	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
-	struct cxl_memdev *cxlmd_a = cxled_to_memdev(cxled_a);
-	struct cxl_memdev *cxlmd_b = cxled_to_memdev(cxled_b);
-	struct cxl_port *port_a = cxled_to_port(cxled_a);
-	struct cxl_port *port_b = cxled_to_port(cxled_b);
-	struct cxl_port *iter_a, *iter_b, *port = NULL;
-	struct cxl_switch_decoder *cxlsd;
-	struct device *dev;
-	int a_pos, b_pos;
-	unsigned int seq;
-
-	/* Exit early if any prior sorting failed */
-	if (cxled_a->pos < 0 || cxled_b->pos < 0)
-		return 0;
-
-	/*
-	 * Walk up the hierarchy to find a shared port, find the decoder that
-	 * maps the range, compare the relative position of those dport
-	 * mappings.
-	 */
-	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
-		struct cxl_port *next_a, *next_b;
-
-		next_a = next_port(iter_a);
-		if (!next_a)
-			break;
-
-		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
-			next_b = next_port(iter_b);
-			if (next_a != next_b)
-				continue;
-			port = next_a;
-			break;
-		}
-
-		if (port)
-			break;
-	}
-
-	if (!port) {
-		dev_err(cxlmd_a->dev.parent,
-			"failed to find shared port with %s\n",
-			dev_name(cxlmd_b->dev.parent));
-		goto err;
-	}
-
-	dev = device_find_child(&port->dev, &cxled_a->cxld.hpa_range,
-				match_switch_decoder_by_range);
-	if (!dev) {
-		struct range *range = &cxled_a->cxld.hpa_range;
-
-		dev_err(port->uport_dev,
-			"failed to find decoder that maps %#llx-%#llx\n",
-			range->start, range->end);
-		goto err;
-	}
-
-	cxlsd = to_cxl_switch_decoder(dev);
-	do {
-		seq = read_seqbegin(&cxlsd->target_lock);
-		find_positions(cxlsd, iter_a, iter_b, &a_pos, &b_pos);
-	} while (read_seqretry(&cxlsd->target_lock, seq));
-
-	put_device(dev);
-
-	if (a_pos < 0 || b_pos < 0) {
-		dev_err(port->uport_dev,
-			"failed to find shared decoder for %s and %s\n",
-			dev_name(cxlmd_a->dev.parent),
-			dev_name(cxlmd_b->dev.parent));
-		goto err;
-	}
-
-	dev_dbg(port->uport_dev, "%s comes %s %s\n",
-		dev_name(cxlmd_a->dev.parent),
-		a_pos - b_pos < 0 ? "before" : "after",
-		dev_name(cxlmd_b->dev.parent));
-
-	return a_pos - b_pos;
-err:
-	cxled_a->pos = -1;
-	return 0;
-}
-
 static int cxl_region_sort_targets(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int i, rc = 0;
 
-	sort(p->targets, p->nr_targets, sizeof(p->targets[0]), cmp_decode_pos,
-	     NULL);
-
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
+		cxled->pos = cxl_calc_interleave_pos(cxled);
 		/*
-		 * Record that sorting failed, but still continue to restore
-		 * cxled->pos with its ->targets[] position so that follow-on
-		 * code paths can reliably do p->targets[cxled->pos] to
-		 * self-reference their entry.
+		 * Record that sorting failed, but still continue to calc
+		 * cxled->pos so that follow-on code paths can reliably
+		 * do p->targets[cxled->pos] to self-reference their entry.
 		 */
 		if (cxled->pos < 0)
 			rc = -ENXIO;
-		cxled->pos = i;
 	}
+	/* Keep the cxlr target list in interleave position order */
+	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
+	     cmp_interleave_pos, NULL);
 
 	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
 	return rc;
-- 
2.37.3

