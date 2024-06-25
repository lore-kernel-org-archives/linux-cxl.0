Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4C10A35
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276965; cv=none; b=HroG8Jwb4EBnH0Ix2aKhpBMa5gLGyoFCOFX5BdMZ5DpA6wDg4wHpt+e60bAWLspGf0cCXr6e8p+MvSlD45AOXl3LHuH+LFP/i+Fjc2ykE5TaCT3CvO40lcgLQIF7aE9puAfopMDNW2FEr3t5tBn37QqY0I69RoQcJUFKM2PnkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276965; c=relaxed/simple;
	bh=WZZgkz9Fy7jeEQidp/GRbXIUqiwPmmTZuTdGleGJ+G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Idlk3nuwBv2aD1KkqzZZgrvwPez/wYuo4sTESflzzfPB/iuuDtvrefEisrLJmmyDOXIpT6wSFdbRGmCEod2tEAhvUkaAUuUUR+nwlexCYpNMQYeJBXQANmrEoVG3yeazxchYv3GwjyaBu2l25l2pDtlnm6WrbC1vc5q5uDWSDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeLV9bs1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeLV9bs1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719276964; x=1750812964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZZgkz9Fy7jeEQidp/GRbXIUqiwPmmTZuTdGleGJ+G8=;
  b=AeLV9bs1+AZ0Auwa5+T7bRzTNbgwCM8fz2ekd4DSN5JvjzEhjOlXMXx6
   6L5rAtj0Ka/xcx4AW3exGhXCIHrb5OU9UQYF5ncBSwGYFsn4l5OFsP4U0
   xnbbZgFodQZdQb81vsJ0ZsS5GI13ZGLTx75oe9VlqlwW071a7PBNif6nM
   gXnYW4KLAepTsrc+O9hoT0U0Z3uSCua+Tu0ALVFeJtNc7p4zFAD7liYLy
   WiG84O2NI/VhZM06QKc5CMyps6wDQOBUxoKoyhIqWIbDL/SyZSlR6SQgi
   EDzMJ8JVMYvT7kDu1Mm+6/JzhsxIFGHRJH8IZ9sbxHfhVaT039zVxv4xB
   Q==;
X-CSE-ConnectionGUID: OwolcjnwRA206WdfkyTn+g==
X-CSE-MsgGUID: yQL8i6QFRoKpS/nIP3ruuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16028482"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16028482"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:56:03 -0700
X-CSE-ConnectionGUID: BoaB+3YZS+STl15dbYuoiQ==
X-CSE-MsgGUID: ix3DK0opSdKcMz9HczCjag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="66697343"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.37])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:56:02 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 4/4] cxl: Remove defunct code calculating host bridge target positions
Date: Mon, 24 Jun 2024 17:55:55 -0700
Message-Id: <5c8afc1e7a7523c14bfb906627f4d27aeed25de5.1719275633.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719275633.git.alison.schofield@intel.com>
References: <cover.1719275633.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL Spec 3.1 Table 9-22 requires that the BIOS populate the CFMWS
target list in interleave target order. This means the calculations
the CXL driver added to determine positions when XOR math is in use,
along with the entire XOR vs Modulo call back setup is not needed.

A prior patch added a common method to verify positions.

Remove the now unused code related to the cxl_calc_hb_fn.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      | 62 ++---------------------------------------
 drivers/cxl/core/port.c | 18 ------------
 drivers/cxl/cxl.h       |  6 ----
 3 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 010741da0176..18c7cb78504e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -22,57 +22,6 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-/*
- * Find a targets entry (n) in the host bridge interleave list.
- * CXL Specification 3.0 Table 9-22
- */
-static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
-			  int ig)
-{
-	int i = 0, n = 0;
-	u8 eiw;
-
-	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
-	if (iw != 3) {
-		for (i = 0; i < cximsd->nr_maps; i++)
-			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
-	}
-	/* IW: 3,6,12 add a modulo calculation to 'n' */
-	if (!is_power_of_2(iw)) {
-		if (ways_to_eiw(iw, &eiw))
-			return -1;
-		hpa &= GENMASK_ULL(51, eiw + ig);
-		n |= do_div(hpa, 3) << i;
-	}
-	return n;
-}
-
-static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
-{
-	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
-	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
-	struct cxl_decoder *cxld = &cxlsd->cxld;
-	int ig = cxld->interleave_granularity;
-	int iw = cxld->interleave_ways;
-	int n = 0;
-	u64 hpa;
-
-	if (dev_WARN_ONCE(&cxld->dev,
-			  cxld->interleave_ways != cxlsd->nr_targets,
-			  "misconfigured root decoder\n"))
-		return NULL;
-
-	hpa = cxlrd->res->start + pos * ig;
-
-	/* Entry (n) is 0 for no interleave (iw == 1) */
-	if (iw != 1)
-		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
-
-	if (n < 0)
-		return NULL;
-
-	return cxlrd->cxlsd.target[n];
-}
 
 static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
 {
@@ -398,7 +347,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_port *root_port = ctx->root_port;
 	struct cxl_cxims_context cxims_ctx;
 	struct device *dev = ctx->dev;
-	cxl_calc_hb_fn cxl_calc_hb;
 	cxl_translate_fn translate;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
@@ -427,17 +375,13 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (rc)
 		return rc;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
-		cxl_calc_hb = cxl_hb_modulo;
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
 		translate = NULL;
-
-	} else {
-		cxl_calc_hb = cxl_hb_xor;
+	else
 		translate = cxl_xor_translate;
-	}
 
 	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
-		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb, translate);
+		cxl_root_decoder_alloc(root_port, ways, translate);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e5d5f7783857..9e19f2072ba0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1733,21 +1733,6 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	return 0;
 }
 
-struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
-{
-	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
-	struct cxl_decoder *cxld = &cxlsd->cxld;
-	int iw;
-
-	iw = cxld->interleave_ways;
-	if (dev_WARN_ONCE(&cxld->dev, iw != cxlsd->nr_targets,
-			  "misconfigured root decoder\n"))
-		return NULL;
-
-	return cxlrd->cxlsd.target[pos % iw];
-}
-EXPORT_SYMBOL_NS_GPL(cxl_hb_modulo, CXL);
-
 static struct lock_class_key cxl_decoder_key;
 
 /**
@@ -1807,7 +1792,6 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * cxl_root_decoder_alloc - Allocate a root level decoder
  * @port: owning CXL root of this decoder
  * @nr_targets: static number of downstream targets
- * @calc_hb: which host bridge covers the n'th position by granularity
  * @translate: decoder specific address translation function
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
@@ -1817,7 +1801,6 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb,
 						cxl_translate_fn translate)
 {
 	struct cxl_root_decoder *cxlrd;
@@ -1840,7 +1823,6 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
-	cxlrd->calc_hb = calc_hb;
 	cxlrd->translate = translate;
 	mutex_init(&cxlrd->range_lock);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3678235fc9ce..75959f6147de 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -432,15 +432,12 @@ struct cxl_switch_decoder {
 };
 
 struct cxl_root_decoder;
-typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
-					    int pos);
 typedef u64 (*cxl_translate_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
- * @calc_hb: which host bridge covers the n'th position by granularity
  * @translate: decoder specific address translation function
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
@@ -450,7 +447,6 @@ typedef u64 (*cxl_translate_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	cxl_calc_hb_fn calc_hb;
 	cxl_translate_fn translate;
 	void *platform_data;
 	struct mutex range_lock;
@@ -776,9 +772,7 @@ bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb,
 						cxl_translate_fn translate);
-struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
-- 
2.37.3

