Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32925125A8
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tuit4fgH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B787D9
	for <linux-cxl@vger.kernel.org>; Sun, 15 Oct 2023 23:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697436158; x=1728972158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bBxhINDdtuc15PugRZ7gVGYr5oQmXkY9bCjaa9ikzQE=;
  b=Tuit4fgHmB+NrQMRJ7G0dxz2at/Zmt+E1FIERdvqMTdQayv6uNFjDqXR
   VPTlU+M7wSLm7qISJvezM5q2I/Y9YBvWqCm0Vq5yfy/UPLbieeUfSK1vt
   7hQ+QBK12okTOQvdo9gjc3LxqIaTnUdoJTsr6KgfzVbF5NqSlZ0kRBxDT
   /LokNKbRmXULqoAHHKIbX7u96lE+3h6WICP/5bU5Vnzocnc8r3y8MIcF1
   mJPx1ji05z3IFLypb0y1rQP6rECROLXNGFchWytYN3FhBVykt+zSPt0G8
   5OwpKEeK7ArDfgHV/huvTaVMeVSkLsKdB2v7xkoSP+paYW2C9G7JJJVB+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365714363"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365714363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899362073"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899362073"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.62.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:00:39 -0700
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
Subject: [PATCH v2 3/3] cxl/region: Use calc_interleave_pos() with autodiscovered regions
Date: Sun, 15 Oct 2023 23:02:28 -0700
Message-Id: <533d9fe49c10d7cb878ea9157232aaa5bb657ae0.1697433770.git.alison.schofield@intel.com>
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

For auto-discovered regions, the driver must assign each target to
the correct position in the region interleave set.

cxl_region_sort_targets() uses the kernel sort() function to put the
targets in relative order. Once the relative ordering is complete,
positions are assigned based on each targets index in that sorted list.

The sort() compare function does not consider the child offset into a
parent port. The sort put all targets of one port ahead of another
port when an interleave was expected, causing the region assembly to
fail.

Replace the relative sort, with calc_interleave_pos() on each target
in the region target list. That will find the exact position for each
target based on a walk up the ancestral tree from endpoint to root
decoder.

calc_interleave_pos() was introduced in a prior patch, so the work
here is to use in cxl_region_sort_targets().

Cleanup the obsolete helper functions from the prior sort().

Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 127 +++++---------------------------------
 1 file changed, 15 insertions(+), 112 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b451d215c3c5..fc261c82ea4e 100644
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
@@ -1589,131 +1597,26 @@ static int calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
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
 
+		cxled->pos = calc_interleave_pos(cxled, p->interleave_ways);
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

