Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959812A1D8
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984602; cv=none; b=Fg931YuoqwgfWIQlBjRriSQh3yMU4fr4tqx5se+/v4IWM01lOfCYXY7dt6jvc+zQX/mT03qWuqIC83hYcqcwN9XvFtRAIxyyfwidMyNrPwDxXjRrflpc9m6B2IP5Cv8elmJpATW7bihSqE4ROFtt0tyUCxEQ9Wg6qyBUYzwM3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984602; c=relaxed/simple;
	bh=WeQ/PAuFslpoRnhBHshC64hqV7ii5WvF1SC+rHERIR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sONZBQW0t9Ioj8wbiID3Jw2J1yV7gYUqfCCc4irgZMDoskFj5GxEAY7CblelxlI9oeK76ACOGCcsVCIWWNVgxSJNwNbegoPLTu3z1zqEqG4jRX80fjKD5ApRZgppd+Z46t0sI1jBXHe+Y74RTl8FBdM5/t2rlaX0ngtjDm/oDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWbEaQQk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWbEaQQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719984601; x=1751520601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeQ/PAuFslpoRnhBHshC64hqV7ii5WvF1SC+rHERIR4=;
  b=VWbEaQQkMVmhb/WhVtnxCYkaJpt6ie9qTiEYZOOrfDsLbhEnLIiUP3O6
   aeJM8g/EqRmcRKobg4ziOTUMSOlwnCx0xGupWTMvwiosSNXwLJvgJEuKh
   NpwhanzZH19a9/HFX3hyM5VGv7LJ0jrSLtnSOYNAaBT+ZMwRZ+2i5CHGW
   d8cfvsDdRNxYoRs4MZPh5VEx4bwAim33mOBoBpWtHMTXNylDVak1Vawyw
   lgLiW4H5WcpJqNjmuQfGKRAuQReoKlS3tACj+v/UDGX6WtCDjtr0oaFi4
   eucWsEp0eNreXRmx9CRF7ahDZEMTUoJvr78NzqI8dmRUeMV3HvUH+UTaV
   Q==;
X-CSE-ConnectionGUID: GDu/PvhbTOW5AqrQBO9n7Q==
X-CSE-MsgGUID: K1z9hW6SSKCrpXCzV7mOVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28326357"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28326357"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:30:00 -0700
X-CSE-ConnectionGUID: CRgwi0zpTDC2aeRVaY4KwQ==
X-CSE-MsgGUID: 9WT3zVveTC6MAXRdP3Ve7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46004099"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.8.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:59 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 4/4] cxl: Remove defunct code calculating host bridge target positions
Date: Tue,  2 Jul 2024 22:29:52 -0700
Message-Id: <2e2c32a2d0f1007e920b58712d15edad2e48d857.1719980933.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719980933.git.alison.schofield@intel.com>
References: <cover.1719980933.git.alison.schofield@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/acpi.c      | 60 ++---------------------------------------
 drivers/cxl/core/port.c | 20 +-------------
 drivers/cxl/cxl.h       |  8 +-----
 3 files changed, 4 insertions(+), 84 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 6b6ae9c81368..921cee3bb980 100644
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
 
 static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 {
@@ -398,7 +347,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_port *root_port = ctx->root_port;
 	struct cxl_cxims_context cxims_ctx;
 	struct device *dev = ctx->dev;
-	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
 	int rc;
@@ -426,13 +374,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (rc)
 		return rc;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
-		cxl_calc_hb = cxl_hb_modulo;
-	else
-		cxl_calc_hb = cxl_hb_xor;
-
 	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
-		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
+		cxl_root_decoder_alloc(root_port, ways);
+
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 887ed6e358fb..bc9e18d02598 100644
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
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
  * 'CXL root' decoder is one that decodes from a top-level / static platform
@@ -1815,8 +1799,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * topology.
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb)
+						unsigned int nr_targets)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
@@ -1838,7 +1821,6 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
-	cxlrd->calc_hb = calc_hb;
 	mutex_init(&cxlrd->range_lock);
 
 	cxld = &cxlsd->cxld;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dfc4f27d195c..e27a0cd4f107 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -432,15 +432,12 @@ struct cxl_switch_decoder {
 };
 
 struct cxl_root_decoder;
-typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
-					    int pos);
 typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
- * @calc_hb: which host bridge covers the n'th position by granularity
  * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
@@ -450,7 +447,6 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	cxl_calc_hb_fn calc_hb;
 	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
@@ -775,9 +771,7 @@ bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb);
-struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
+						unsigned int nr_targets);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
-- 
2.37.3

