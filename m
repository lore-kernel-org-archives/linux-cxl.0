Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96390C77B78
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjDRRjf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjDRRjZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:39:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A85595
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839562; x=1713375562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YX4H0KOiWItVU5iVYiE7vDaRIu290XpINISzddro93Y=;
  b=ld1eiqJpWLLT+yez8Pv2dV//Ci0GhQkABE/XfTK9M5wky9LyVnpIYIzv
   cbUcKQyb2QLHfyfGGmK/Q959A606ZcVtfCGOjFFaRkR6C8qS8O6fRu7jz
   qletVwK1JVWEwAhSjbNxnyGdLYQtbh5m/VcTeOjMmzPlUTiDLYbQY9QY0
   QWUk/mfOEvRAmY2V/ydP3dplgEwfLxBCE8MpvJdDyoOBtZwNSZZ7efn24
   hLWyG6c0wJsOIU8dWEHI3GuIRG5I5h15RM6nX7bicKBTd26No/4JUsoxW
   KPtYAHx3G+HAFXpqiX9340WGUJV1MOoN20bFvteC3nkj0Va1PbuwpLTsY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410470745"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410470745"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865505448"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="865505448"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:20 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 7/9] cxl/region: Provide region info to the cxl_poison trace event
Date:   Tue, 18 Apr 2023 10:39:07 -0700
Message-Id: <438b01ccaa70592539e8eda4eb2b1d617ba03160.1681838292.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

User space may need to know which region, if any, maps the poison
address(es) logged in a cxl_poison trace event. Since the mapping
of DPAs (device physical addresses) to a region can change, the
kernel must provide this information at the time the poison list
is read. The event informs user space that at event <timestamp>
this <region> mapped to this <DPA>, which is poisoned.

The cxl_poison trace event is already wired up to log the region
name and uuid if it receives param 'struct cxl_region'.

In order to provide that cxl_region, add another method for gathering
poison - by committed endpoint decoder mappings. This method is only
available with CONFIG_CXL_REGION and is only used if a region actually
maps the memdev where poison is being read. After the region driver
reads the poison list for all the mapped resources, poison is read for
any remaining unmapped resources.

The default method remains: read the poison by memdev resource.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h   |   5 ++
 drivers/cxl/core/memdev.c |  13 +++-
 drivers/cxl/core/region.c | 124 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e888e293943e..deb5f87d6d0a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
 int cxl_region_init(void);
 void cxl_region_exit(void);
+int cxl_get_poison_by_endpoint(struct cxl_port *port);
 #else
+static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
+{
+	return 0;
+}
 static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 71f5ec6ba6c1..8db7f220f182 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -136,13 +136,24 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 {
+	struct cxl_port *port;
 	int rc;
 
+	port = dev_get_drvdata(&cxlmd->dev);
+	if (!port || !is_cxl_endpoint(port))
+		return -EINVAL;
+
 	rc = down_read_interruptible(&cxl_dpa_rwsem);
 	if (rc)
 		return rc;
 
-	rc = cxl_get_poison_by_memdev(cxlmd);
+	if (port->commit_end == -1) {
+		/* No regions mapped to this memdev */
+		rc = cxl_get_poison_by_memdev(cxlmd);
+	} else {
+		/* Regions mapped, collect poison by endpoint */
+		rc =  cxl_get_poison_by_endpoint(port);
+	}
 	up_read(&cxl_dpa_rwsem);
 
 	return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..5f1c8ce9d956 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2213,6 +2213,130 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
 
+struct cxl_poison_context {
+	struct cxl_port *port;
+	enum cxl_decoder_mode mode;
+	u64 offset;
+};
+
+static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
+				   struct cxl_poison_context *ctx)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 offset, length;
+	int rc = 0;
+
+	/*
+	 * Collect poison for the remaining unmapped resources
+	 * after poison is collected by committed endpoints.
+	 *
+	 * Knowing that PMEM must always follow RAM, get poison
+	 * for unmapped resources based on the last decoder's mode:
+	 *	ram: scan remains of ram range, then any pmem range
+	 *	pmem: scan remains of pmem range
+	 */
+
+	if (ctx->mode == CXL_DECODER_RAM) {
+		offset = ctx->offset;
+		length = resource_size(&cxlds->ram_res) - offset;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc == -EFAULT)
+			rc = 0;
+		if (rc)
+			return rc;
+	}
+	if (ctx->mode == CXL_DECODER_PMEM) {
+		offset = ctx->offset;
+		length = resource_size(&cxlds->dpa_res) - offset;
+		if (!length)
+			return 0;
+	} else if (resource_size(&cxlds->pmem_res)) {
+		offset = cxlds->pmem_res.start;
+		length = resource_size(&cxlds->pmem_res);
+	} else {
+		return 0;
+	}
+
+	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+}
+
+static int  poison_by_decoder(struct device *dev, void *arg)
+{
+	struct cxl_poison_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	u64 offset, length;
+	int rc = 0;
+
+	if (!is_endpoint_decoder(dev))
+		return rc;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return rc;
+
+	/*
+	 * Regions are only created with single mode decoders: pmem or ram.
+	 * Linux does not support mixed mode decoders. This means that
+	 * reading poison per endpoint decoder adheres to the requirement
+	 * that poison reads of pmem and ram must be separated.
+	 * CXL 3.0 Spec 8.2.9.8.4.1
+	 */
+	if (cxled->mode == CXL_DECODER_MIXED) {
+		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
+		return rc;
+	}
+
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->skip) {
+		offset = cxled->dpa_res->start - cxled->skip;
+		length = cxled->skip;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+			rc = 0;
+		if (rc)
+			return rc;
+	}
+
+	offset = cxled->dpa_res->start;
+	length = cxled->dpa_res->end - offset + 1;
+	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
+		rc = 0;
+	if (rc)
+		return rc;
+
+	/* Iterate until commit_end is reached */
+	if (cxled->cxld.id == ctx->port->commit_end) {
+		ctx->offset = cxled->dpa_res->end + 1;
+		ctx->mode = cxled->mode;
+		rc = 1;
+	}
+
+	return rc;
+}
+
+int cxl_get_poison_by_endpoint(struct cxl_port *port)
+{
+	struct cxl_poison_context ctx;
+	int rc = 0;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	ctx = (struct cxl_poison_context) {
+		.port = port
+	};
+
+	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
+	if (rc == 1)
+		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport), &ctx);
+
+	up_read(&cxl_region_rwsem);
+	return rc;
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
-- 
2.37.3

