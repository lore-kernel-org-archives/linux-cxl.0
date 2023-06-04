Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE55C7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjFDXdQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjFDXdP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:33:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F24AC
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921593; x=1717457593;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/Z2kNotKpe63IrWWO43NZGARCzIktYElFf8UTs7Wv0=;
  b=BWVoehURYpSq/X3a/WffLW3939oiIx62nv9l2eo5bdFlAz+hCOul/oAU
   rhHeT9rYcfbe6V2pYFIcKYd1vAAn/PYVYCyZ/06FAvO/QCNr5Qq8Ws4ZV
   dpxxpfsgXSSgwjWgZJOIBxIISOLx8TqfahifudzfQp3yd91YYlBTT/Jfe
   HuHM2taG4mGu02/HNYGgbrShtJ5dzMChbuh4omVePTcJKiVSb6D+cGUAd
   ZEgmbLaz7DesgnQUOrtCW2FYOxxS4dTSiMkgcb6Gl7PY103LGgH7QGX7o
   VOKBBF+1owTiI8Wm8vrvzehVpYWDzA9DgaxHpwICNgDQfq0s+Cx4mX6QI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353734237"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353734237"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658874829"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658874829"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:13 -0700
Subject: [PATCH 17/19] cxl/region: Define a driver interface for HPA free
 space enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:33:12 -0700
Message-ID: <168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL region creation involves allocating capacity from device DPA
(device-physical-address space) and assigning it to decode a given HPA
(host-physical-address space). Before determininig how much DPA to
allocate the amount of available HPA must be determined. Also, not all
HPA is created equal, some specifically targets RAM, some target PMEM,
some is prepared for the device-memory flows like HDM-D and HDM-DB, and
some is host-only (HDM-H).

Wrap all of those concerns into an API that retrieves a root decoder
(platform CXL window) that fits the specified constraints and the
capacity available for a new region.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |  143 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    5 ++
 drivers/cxl/cxlmem.h      |    5 ++
 3 files changed, 153 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 75c5de627868..a41756249f8d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -575,6 +575,149 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
+struct cxlrd_max_context {
+	struct device * const *host_bridges;
+	int interleave_ways;
+	unsigned long flags;
+	resource_size_t max_hpa;
+	struct cxl_root_decoder *cxlrd;
+};
+
+static int find_max_hpa(struct device *dev, void *data)
+{
+	struct cxlrd_max_context *ctx = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
+	struct resource *res, *prev;
+	struct cxl_decoder *cxld;
+	resource_size_t max;
+	unsigned int seq;
+	int found;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxld = &cxlrd->cxlsd.cxld;
+	if ((cxld->flags & ctx->flags) != ctx->flags)
+		return 0;
+
+	if (cxld->interleave_ways != ctx->interleave_ways)
+		return 0;
+
+	cxlsd = &cxlrd->cxlsd;
+	do {
+		found = 0;
+		seq = read_seqbegin(&cxlsd->target_lock);
+		for (int i = 0; i < ctx->interleave_ways; i++)
+			for (int j = 0; j < ctx->interleave_ways; j++)
+				if (ctx->host_bridges[i] ==
+				    cxlsd->target[j]->dport) {
+					found++;
+					break;
+				}
+	} while (read_seqretry(&cxlsd->target_lock, seq));
+
+	if (found != ctx->interleave_ways)
+		return 0;
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_region_rwsem to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_region_rwsem);
+	max = 0;
+	res = cxlrd->res->child;
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free = 0;
+
+		if (!prev && res->start > cxlrd->res->start) {
+			free = res->start - cxlrd->res->start;
+			max = max(free, max);
+		}
+		if (prev && res->start > prev->end + 1) {
+			free = res->start - prev->end + 1;
+			max = max(free, max);
+		}
+		if (next && res->end + 1 < next->start) {
+			free = next->start - res->end + 1;
+			max = max(free, max);
+		}
+		if (!next && res->end + 1 < cxlrd->res->end + 1) {
+			free = cxlrd->res->end + 1 - res->end + 1;
+			max = max(free, max);
+		}
+	}
+
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(cxlrd_dev(ctx->cxlrd));
+		get_device(cxlrd_dev(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+		dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_hpa_freespace - find a root decoder with free capacity per constraints
+ * @endpoint: an endpoint that is mapped by the returned decoder
+ * @host_bridges: array of host-bridges that the decoder must interleave
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
+ * @max: output parameter of bytes available in the returned decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
+ * is a point in time snapshot. If by the time the caller goes to use this root
+ * decoder's capacity the capacity is reduced then caller needs to loop and
+ * retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
+ * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
+ * does not race.
+ */
+struct cxl_root_decoder *cxl_hpa_freespace(struct cxl_port *endpoint,
+					   struct device *const *host_bridges,
+					   int interleave_ways,
+					   unsigned long flags,
+					   resource_size_t *max)
+{
+	struct cxlrd_max_context ctx = {
+		.host_bridges = host_bridges,
+		.interleave_ways = interleave_ways,
+		.flags = flags,
+	};
+	struct cxl_port *root;
+
+	if (!is_cxl_endpoint(endpoint))
+		return ERR_PTR(-EINVAL);
+
+	root = find_cxl_root(endpoint);
+	if (!root)
+		return ERR_PTR(-ENXIO);
+
+	down_read(&cxl_region_rwsem);
+	device_for_each_child(&root->dev, &ctx, find_max_hpa);
+	up_read(&cxl_region_rwsem);
+	put_device(&root->dev);
+
+	if (!ctx.cxlrd)
+		return ERR_PTR(-ENOMEM);
+
+	*max = ctx.max_hpa;
+	return ctx.cxlrd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hpa_freespace, CXL);
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 55808697773f..8400af85d99f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -686,6 +686,11 @@ static inline struct device *cxled_dev(struct cxl_endpoint_decoder *cxled)
 	return &cxled->cxld.dev;
 }
 
+static inline struct device *cxlrd_dev(struct cxl_root_decoder *cxlrd)
+{
+	return &cxlrd->cxlsd.cxld.dev;
+}
+
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8ec5c305d186..69f07186502d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -93,6 +93,11 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
 					     enum cxl_decoder_mode mode,
 					     resource_size_t min,
 					     resource_size_t max);
+struct cxl_root_decoder *cxl_hpa_freespace(struct cxl_port *endpoint,
+					   struct device *const *host_bridges,
+					   int interleave_ways,
+					   unsigned long flags,
+					   resource_size_t *max);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)

