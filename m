Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE16C7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjFDXdM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFDXdL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:33:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF1AB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921588; x=1717457588;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z4KyIUgCE8xVdWjLwPrKwpAaINUoR+ODWqy0rfSge4E=;
  b=GFjNpkJa+RTsoe8p0j/RUpVs7ZxZboRiR2wla30wKPS4EvXZRbLFVFhg
   no/aPhFYhdae/CtoTG3jahAN+ZbsQ9UVOnPKIFBXd3px7ra/+3SOyS/1/
   xWvjwFE6C7h5RBqprmCAU6ocO/+w6iRUbXZ+oQtIYp+TYwx42Uxk67IQr
   I+/9hpXTT1GfVGOExXiIo5/ybUuB1PwXZvPb7ZPPGlgY0O6u/5IAklHFT
   k+lt3iZxXoCagxfN9c+vLetsKtVmrKZX2D+OCuzCJ4w2REIEkYD1HDYb/
   5hbBAuxEHHdJEcamYLSyceivu0XzMKRKdYZe6lbptoJdljpLL3wNOrMfS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353734230"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353734230"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658874826"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658874826"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:07 -0700
Subject: [PATCH 16/19] cxl/hdm: Define a driver interface for DPA allocation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:33:07 -0700
Message-ID: <168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Given the HPA
capacity constraint, define an API, cxl_request_dpa(), that has the
flexibility to map the minimum amount of memory the driver needs to
operate vs the total possible that can be mapped given HPA availability.

Factor out the core of cxl_dpa_alloc(), that does free space scanning,
into a cxl_dpa_freespace() helper, and use that to balance the capacity
available to map vs the @min and @max arguments to cxl_request_dpa().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |  140 +++++++++++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h      |    6 ++
 drivers/cxl/cxlmem.h   |    4 +
 3 files changed, 131 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 91ab3033c781..514d30131d92 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -464,30 +464,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	return rc;
 }
 
-int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
+					 resource_size_t *start_out,
+					 resource_size_t *skip_out)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	resource_size_t free_ram_start, free_pmem_start;
-	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
-	int rc;
 
-	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.region) {
-		dev_dbg(dev, "decoder attached to %s\n",
-			dev_name(&cxled->cxld.region->dev));
-		rc = -EBUSY;
-		goto out;
-	}
-
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
-	}
+	lockdep_assert_held(&cxl_dpa_rwsem);
 
 	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
 		last = p;
@@ -525,11 +512,42 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 			skip_end = start - 1;
 		skip = skip_end - skip_start + 1;
 	} else {
-		dev_dbg(dev, "mode not set\n");
-		rc = -EINVAL;
+		dev_dbg(cxled_dev(cxled), "mode not set\n");
+		avail = 0;
+	}
+
+	if (!avail)
+		return 0;
+	if (start_out)
+		*start_out = start;
+	if (skip_out)
+		*skip_out = skip;
+	return avail;
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct device *dev = &cxled->cxld.dev;
+	resource_size_t start, avail, skip;
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.region) {
+		dev_dbg(dev, "decoder attached to %s\n",
+			dev_name(&cxled->cxld.region->dev));
+		rc = -EBUSY;
+		goto out;
+	}
+
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "decoder enabled\n");
+		rc = -EBUSY;
 		goto out;
 	}
 
+	avail = cxl_dpa_freespace(cxled, &start, &skip);
+
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
 			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
@@ -548,6 +566,90 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_free_decoder(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	if (cxled->cxld.id != port->hdm_end + 1)
+		return 0;
+	return 1;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @endpoint: an endpoint port with available decoders
+ * @mode: DPA operation mode (ram vs pmem)
+ * @min: the minimum amount of capacity the call needs
+ * @max: extra capacity to allocate after min is satisfied
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. So, the expectation is that @min is a driver known
+ * value for how much capacity is needed, and @max is based the limit of
+ * how much HPA space is available for a new region.
+ *
+ * Returns a pinned cxl_decoder with at least @min bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     enum cxl_decoder_mode mode,
+					     resource_size_t min,
+					     resource_size_t max)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+	resource_size_t alloc;
+	int rc;
+
+	if (!IS_ALIGNED(min | max, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	if (!cxled_dev)
+		cxled = ERR_PTR(-ENXIO);
+	else
+		cxled = to_cxl_endpoint_decoder(cxled_dev);
+	up_read(&cxl_dpa_rwsem);
+
+	if (IS_ERR(cxled))
+		return cxled;
+
+	rc = cxl_dpa_set_mode(cxled, mode);
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
+	up_read(&cxl_dpa_rwsem);
+
+	if (max)
+		alloc = min(max, alloc);
+	if (alloc < min) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		goto err;
+
+	return cxled;
+err:
+	put_device(cxled_dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 258c90727dd2..55808697773f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -680,6 +680,12 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
+
+static inline struct device *cxled_dev(struct cxl_endpoint_decoder *cxled)
+{
+	return &cxled->cxld.dev;
+}
+
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e3bcd6d12a1c..8ec5c305d186 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -89,6 +89,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
+					     enum cxl_decoder_mode mode,
+					     resource_size_t min,
+					     resource_size_t max);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)

