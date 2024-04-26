Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1378C70
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103191; cv=none; b=O7Yu55mUylD5QOLpG3rbTP09GMWfHiYEVmLJOSsjKfS6ewS152BSkk1SCnCVWR+hP4RHPPHQ9Mb8JR7zojftKDYquHZPBvE74eeo7KSs0KjfMKqlDhNNOWuf8C+MHbpbv53gBuTnDCgLZAoKxC+lqrHW35wp+jdxA68rAiCXANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103191; c=relaxed/simple;
	bh=ABXHD79SAY7dW0Fx6Y7aYlXFP4JckPvRUUEtzb8P5uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUZKrGYCZ8zJ7IUpFIemAvIoZu1+uFECihdgPO2qt57zp6HQFXej+vUpYi9Cq+3rjxgkm0FGqr1URDrm+V4s4Ui02O2GfZzwna9iBBhvTyYW7a0wsLJuLyKSRoZQvSrxoh+TwLfX0CQ7y6AHiUoVDofJWbaWdEET6cEVgDEQ//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lExk8EtP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lExk8EtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714103190; x=1745639190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABXHD79SAY7dW0Fx6Y7aYlXFP4JckPvRUUEtzb8P5uc=;
  b=lExk8EtPTRjlnHDpYuyfNQrJ8tlfIHm+6L519lEqFACMdmda5jTDZ78m
   Sq+9xpANdjcpT9v8fcZalPIczvFWXDOqet5xdELWv18YttWds+TNdPVhT
   1YUCtnI/Ik4hLdjC91/wr7EgglhMFRjj4cXh51S6D/fsgHAwv3zK0wO2L
   ooEKwNsZ9AL8K33xnusA4cO0/Ju2XxyAJdPSImMqMq5fd1ACSzMSyJe8F
   f5xmxx92i8qE+RShSGyMBJAJ/NX7HL+FOQjRIIWuT2CaT0NSd2ygsP/hk
   1+/uyrCxNtT4+/RgmECWVp2zpUSe3Ehsg7xJUfHkfwM/uBr4CDblIwn2g
   Q==;
X-CSE-ConnectionGUID: jSmab6ZfSKudYXNWn8tdfQ==
X-CSE-MsgGUID: p7DDyKh5QNyxX/ZNmoa8jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20381461"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="20381461"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:46:28 -0700
X-CSE-ConnectionGUID: S7lNsRdCRZ+ZQ4KxcyB7JQ==
X-CSE-MsgGUID: 6bJSfRU8SoSmqbpAImmf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="29738215"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 20:46:27 -0700
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
Subject: [PATCH v4 1/3] cxl/region: Move cxl_dpa_to_region() work to the region driver
Date: Thu, 25 Apr 2024 20:46:23 -0700
Message-Id: <ea69d6e9a868815ad1626d8e2f732cc6beebbf9c.1714102202.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714102202.git.alison.schofield@intel.com>
References: <cover.1714102202.git.alison.schofield@intel.com>
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

