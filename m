Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457C27F171
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217275; cv=none; b=K85Tay9lkNjRjDQDquHUDe9JUAyMfHeuaO4mZOExeddmVD+36W7mdXZJ5jEawmx+89G6EMtpHw/VanPQTYGJoZPH8klZoe8oDzbgYQJnp3yNWDYgxJCPIHM45aLaFGIM9ZbDZkVBBGMudVzOefchLeOKGRoJxgNmZdhjMXkJwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217275; c=relaxed/simple;
	bh=TF4PQU68iRdUi7w6I0XztGoKSNz//vF7EHnNGR8ho4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRd4aFk5QHRriDqxZiuM5WJN4v+BAmXJNsDo5e7Mz72YCTDHwFQQatENwHHHtJnglF4nm1i35NHIWV7plx0pmirtFOHDnuRr6c+5kgI6QzB0AWfiMEVn1xPUFKjh8l/TizRtuvT3io4g9XPogx5ZNAgwiCavgEFniyL2ZyPqfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyHFfSNG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyHFfSNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753217273; x=1784753273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TF4PQU68iRdUi7w6I0XztGoKSNz//vF7EHnNGR8ho4Q=;
  b=JyHFfSNGpVbQaJHDvW86SqgFSKayjmsX8jKtCeiDlI1+ed9aIk0em54Y
   24B3vbOCF9UK2l+p5wJag1JM0a5Fcsn90B2W6OAeb0XPuSCuzdkf1apK3
   bBGs8vduCOA4/pWE1nxfC2ywxvIk/Tt/kQXx2BER8mynDt07EvUQ/qxLc
   RsoQE43dHGGNYXoYlv/yxMjZopDrqfEWZ/ltqjbS7iz0GafY/fWdNnuXe
   nGhdkd+j1JN8yhoVFUYgE2zt/OfBH9jAkatrYtPLp2S/d3Et4dA2+eKUG
   Re0iQUKRGXB67Axi58ifzaklf8oyqTHx3D8O0e4Cn/lpxb0V5jsFCslHH
   Q==;
X-CSE-ConnectionGUID: HleWIvDcTNy2/I2P7jEhqQ==
X-CSE-MsgGUID: FzgZYmbWSASJUclu3TSS5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58100179"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58100179"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:52 -0700
X-CSE-ConnectionGUID: WvzcARUgSa2xcNNipbYGRw==
X-CSE-MsgGUID: sgwI70YoS3+6VpHfOwHPuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159001620"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:52 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 1/5] cxl: Move hpa_to_spa callback to a new root decoder ops structure
Date: Tue, 22 Jul 2025 13:47:40 -0700
Message-ID: <7b54fde7b3a534375225d855da699e7d898643cd.1753214969.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1753214969.git.alison.schofield@intel.com>
References: <cover.1753214969.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

The root decoder's HPA to SPA translation logic was implemented using
a single function pointer. In preparation for additional per-decoder
callbacks, convert this into a struct cxl_rd_ops and move the
hpa_to_spa pointer into it.

To avoid maintaining a static ops instance populated with mostly NULL
pointers, allocate the ops structure dynamically only when a platform
requires overrides (e.g. XOR interleave decoding).

The setup can be extended as additional callbacks are added.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v4: this patch is new to v4

 drivers/cxl/acpi.c        | 10 +++++++---
 drivers/cxl/core/port.c   |  2 ++
 drivers/cxl/core/region.c | 11 ++++++++---
 drivers/cxl/cxl.h         | 12 +++++++++---
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 712624cba2b6..b8d69460a368 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -20,7 +20,6 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-
 static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 {
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
@@ -472,8 +471,13 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxlrd->qos_class = cfmws->qtg_id;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
-		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
+		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
+		if (!cxlrd->ops)
+			return -ENOMEM;
+
+		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;
+	}
 
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 29197376b18e..439473947423 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -450,6 +450,7 @@ static void cxl_root_decoder_release(struct device *dev)
 	if (atomic_read(&cxlrd->region_id) >= 0)
 		memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
+	kfree(cxlrd->ops);
 	kfree(cxlrd);
 }
 
@@ -1833,6 +1834,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 
 	atomic_set(&cxlrd->region_id, rc);
 	cxlrd->qos_class = CXL_QOS_CLASS_INVALID;
+
 	return cxlrd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, "CXL");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e9bf42d91689..3a097ecda1ea 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2918,6 +2918,11 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
+static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
+{
+	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
+}
+
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
@@ -2972,8 +2977,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (cxlrd->hpa_to_spa)
-		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+	if (has_hpa_to_spa(cxlrd))
+		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
 
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
@@ -2982,7 +2987,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
 		return ULLONG_MAX;
 
 	return hpa;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b7111e3568d0..bb82777128a2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -418,27 +418,33 @@ struct cxl_switch_decoder {
 };
 
 struct cxl_root_decoder;
-typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
+/**
+ * struct cxl_rd_ops - CXL root decoder callback operations
+ * @hpa_to_spa: Convert host physical address to system physical address
+ */
+struct cxl_rd_ops {
+	u64 (*hpa_to_spa)(struct cxl_root_decoder *cxlrd, u64 hpa);
+};
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @cache_size: extended linear cache size if exists, otherwise zero.
  * @region_id: region id for next region provisioning event
- * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
+ * @ops: CXL root decoder operations
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
 	struct resource *res;
 	resource_size_t cache_size;
 	atomic_t region_id;
-	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
+	struct cxl_rd_ops *ops;
 	struct cxl_switch_decoder cxlsd;
 };
 
-- 
2.37.3

