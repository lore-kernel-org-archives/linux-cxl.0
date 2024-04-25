Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE715665A
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087542; cv=none; b=QXdjWxEM1i6kN83qCouipTRCP5R21pDVU9QLhU4nCKV//b3FYkxwlSztiuJJXgUHTurTKzu3Sd3VQlHGXYZ39rLeXc8Hh8bRiCaVJOzewhpwDMBhV42ToEyPqZEbuvu25b/uGmCOfcArKGsL0lI/tjAVDMSEfGh7kiv3siJZiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087542; c=relaxed/simple;
	bh=ABXHD79SAY7dW0Fx6Y7aYlXFP4JckPvRUUEtzb8P5uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svKwKjHO3Yf1ni+6FzzWUutBJq6C/fOXRc5WRGtjkY7uHxDi0Mufn3w/5J6rsFZ5X/XaCFmypsqj8/BGQyb4FXJcEr+g9hpqTcu+9wcGmWpcoF5w4pFhzNTmeie8x/OsR9L+UW/7gwcd6zFcxI4C7I+z5QRwplvXAS+0cvMnmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN0V4a6A; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN0V4a6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714087541; x=1745623541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABXHD79SAY7dW0Fx6Y7aYlXFP4JckPvRUUEtzb8P5uc=;
  b=aN0V4a6A4yUaja2On6l1e81eBCWstOPy7C/+r3Dzwe6QUe82oubGQFxh
   S/HD/yz499HmTfJKBhnnQqxWW9XB8n0yy4FoklOK0roiq8FNqNZq/rybJ
   e++ibZPjVeOCyf/JV0+2dxIiAPRHTDDkWR8a10Xjdb3eafuhUBmKx/8wN
   AohudGmHe0wBAGin/1A6nwHr+NSvCDmyNpd4pI0u3nk67H8yFi5Z7Z12g
   f/Qlfn88oWfzZn9fguFZl8dfXrs3lpcEl4KW2zG1uVmwAaShGANxFwATA
   AjsgpBby2OgaHRrXDvY+5AzVEA3E3UGlYFGce4GyI64vEdCk34Cb37ihR
   A==;
X-CSE-ConnectionGUID: tKqnwQnkSWuHI3FmxucAYA==
X-CSE-MsgGUID: 20qmEs+pS2KUfRRmkVCr2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="21230607"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="21230607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:25:39 -0700
X-CSE-ConnectionGUID: 933qlowwQLeYIbW+h0dHRA==
X-CSE-MsgGUID: CsVJiJycSC69MkNsnCUI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25249837"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 16:25:38 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/3] cxl/region: Move cxl_dpa_to_region() work to the region driver
Date: Thu, 25 Apr 2024 16:25:33 -0700
Message-Id: <ea69d6e9a868815ad1626d8e2f732cc6beebbf9c.1714085857.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714085857.git.alison.schofield@intel.com>
References: <cover.1714085857.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This helper belongs in the region driver as it is only useful
with CONFIG_CXL_REGION. Add a stub in core.h for when the region
driver is not built.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/core.h   |  7 +++++++
 drivers/cxl/core/memdev.c | 44 ---------------------------------------
 drivers/cxl/core/region.c | 44 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc5a95665aa0..87008505f8a9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -27,7 +27,14 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+
 #else
+static inline
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+{
+	return NULL;
+}
 static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
 {
 	return 0;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d4e259f3a7e9..0277726afd04 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -251,50 +251,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
 
-struct cxl_dpa_to_region_context {
-	struct cxl_region *cxlr;
-	u64 dpa;
-};
-
-static int __cxl_dpa_to_region(struct device *dev, void *arg)
-{
-	struct cxl_dpa_to_region_context *ctx = arg;
-	struct cxl_endpoint_decoder *cxled;
-	u64 dpa = ctx->dpa;
-
-	if (!is_endpoint_decoder(dev))
-		return 0;
-
-	cxled = to_cxl_endpoint_decoder(dev);
-	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
-		return 0;
-
-	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
-		return 0;
-
-	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
-		dev_name(&cxled->cxld.region->dev));
-
-	ctx->cxlr = cxled->cxld.region;
-
-	return 1;
-}
-
-static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
-{
-	struct cxl_dpa_to_region_context ctx;
-	struct cxl_port *port;
-
-	ctx = (struct cxl_dpa_to_region_context) {
-		.dpa = dpa,
-	};
-	port = cxlmd->endpoint;
-	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
-		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
-
-	return ctx.cxlr;
-}
-
 static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..4b227659e3f8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2679,6 +2679,50 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	return rc;
 }
 
+struct cxl_dpa_to_region_context {
+	struct cxl_region *cxlr;
+	u64 dpa;
+};
+
+static int __cxl_dpa_to_region(struct device *dev, void *arg)
+{
+	struct cxl_dpa_to_region_context *ctx = arg;
+	struct cxl_endpoint_decoder *cxled;
+	u64 dpa = ctx->dpa;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return 0;
+
+	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+		return 0;
+
+	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
+		dev_name(&cxled->cxld.region->dev));
+
+	ctx->cxlr = cxled->cxld.region;
+
+	return 1;
+}
+
+struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_dpa_to_region_context ctx;
+	struct cxl_port *port;
+
+	ctx = (struct cxl_dpa_to_region_context) {
+		.dpa = dpa,
+	};
+	port = cxlmd->endpoint;
+	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
+		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
+
+	return ctx.cxlr;
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
-- 
2.37.3

