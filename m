Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E9F503
	for <linux-cxl@vger.kernel.org>; Thu, 28 Mar 2024 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600601; cv=none; b=uRpdZagE7mwZ/XRfenjR/mou4C3ZdJUAhf/RC/sh41db4FkMUgXnq4iUdSZcS6rho8Sm6laSaRuQtrQyLpu1IRfX6lmp7KFDBgg4a9zy4jkwCXZgS4oBclTD0qeMfDzTnD2CLrzQA6LrjVm3BBidXDCV23Lgyb0AUj9SonH+ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600601; c=relaxed/simple;
	bh=5Z9qMg7HPwzH13V0DyqcKTryT/HdYzWqQq2+vObbxw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXdqYAl2fKT0bn3M4CrLDtujXT4Q0YWH0l6ekagM2c2/KMYbp060hD7zD/J5sQLZFdYltvnxO2UlZB9zZEzK/EyYsdx6ZU1vmrBkBK2KtzZNPD9cOwexicznr2rzPp1Dws6+AMcF8G8sp+FYRuJYZ8gfrDPicslw7XwCxTPmFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSigrAx3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSigrAx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711600599; x=1743136599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Z9qMg7HPwzH13V0DyqcKTryT/HdYzWqQq2+vObbxw0=;
  b=kSigrAx3LTR8Iq11wTbat7yHsyJecHHIX/CULUNnlQDGAu5eCNMUS0Vd
   I3jZ3fEWdwX3BJifcWSROuBAA6jLYyb61oPZ1YyWLKHyRUoj3unff/XIr
   Uaa+gzwaqjRxFPdpLqOySFcosKdl0/hRbyCC+gYgA1VD6y24sI2NOLMII
   pnMtDXFgipKku6UXCy8d/9MknVV8uZg1u8Sz+R4VCDrLPw/xOwIBmWSRp
   xdfmEGVkAQzcJcpFU811TcnyrGBo3rO1JLdBuBVTAa05dGd7Ag7CU9FNZ
   ltEp81Ivue8MNgbJ0+ky7LKIglaInQRKXzK2yEGOsDeHDWP3CV00r3ZwQ
   w==;
X-CSE-ConnectionGUID: r17E0GbnSXeGExABLqrQjw==
X-CSE-MsgGUID: OSKMcnb3RUGKSx4y+rvfrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10542210"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10542210"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21184472"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.82.250])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:36 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/4] cxl/region: Move cxl_dpa_to_region() work to the region driver
Date: Wed, 27 Mar 2024 21:36:30 -0700
Message-Id: <e62889d00f883b804e46a1840454b0c06323fedf.1711598777.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This helper belongs in the region driver as it is only useful
with CONFIG_CXL_REGION. Add stubs in core.h for when the region
driver is not built.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  7 +++++++
 drivers/cxl/core/memdev.c | 44 ---------------------------------------
 drivers/cxl/core/region.c | 44 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc5a95665aa0..6ceba8037101 100644
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
+struct cxl_region cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
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

