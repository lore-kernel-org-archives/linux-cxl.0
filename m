Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0218C36
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161075; cv=none; b=GAPPPS5oF7PhXjBYhtBqU9DEffgUxxKVUYhjAfNi0fJDCc+lu1N/1F9agoHOLZMmI7IELynScN9W5XGA9U3Af6SAU6lIIP8g+jeUmQroiVYDB0AiLOz+FUznUTGMmSeFTl97Tn24HQf8O4PICqvdv1aFPWldu3CpLtfOsP25kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161075; c=relaxed/simple;
	bh=NFJXm3iyWKqaVL5Z0YwMz6K4H642wrrgkNSmXR8EjiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXefqLvZuB09GwKn1/lTlpBaalDEerbwBycikgSvKeGp3fwcrMuQFY66OICQqsnh/sgEIW6UydGmJjZdAldqEBHDnGw0qoW+UBQsRcRtXeL/KtQg8hCxKoqkoehSCw1ZDXlkzTAzXx0/y2UgHv+le39LSPtbVBtVfBdH2Rzy/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4qYyrFS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4qYyrFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161074; x=1745697074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFJXm3iyWKqaVL5Z0YwMz6K4H642wrrgkNSmXR8EjiA=;
  b=H4qYyrFSOGeKCKDKRhLtWr7L874HIq40N8JIJkVMQ2BKz0sSJM918Iss
   5j1hJ8V5AOm53k0Dmk5uBJ3dAA892lB86eru0lTi2cW8g3ZbQrc3OBoFr
   JRs31REPKAGx1Vewop1d5GmB0KFMICwWh8+7NF9BdIh5pyl/bydoy5vD6
   1zQFiwAo8ORYoeZR6PE3OeWslrOzGheqXvhxjadRDM9ATOrcXN+ycf1Rw
   VBBRfqKwSNYvS447hkN7G5NtBvNWYsNcYuSN6Ykp7uiugN3ZDXHDWeBW7
   lZQqzaNscSfpFQseIm35Fg2HPoPp1Jr8W41PmYgAEkSUQt9cXRaWQSieW
   g==;
X-CSE-ConnectionGUID: 4b8L5MSyTCGegMTUeovOJQ==
X-CSE-MsgGUID: /krSmvTcS2qMofi4QTDJRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10067046"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10067046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:12 -0700
X-CSE-ConnectionGUID: EKV5DOcFRv2eVI6+ui13/Q==
X-CSE-MsgGUID: P8EEfea+TNaFs4b4DGcBaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56432098"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.224.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:12 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl: Remove defunct code calculating host bridge target positions
Date: Fri, 26 Apr 2024 12:51:07 -0700
Message-Id: <30d1bb5362c68a4d045dbd0f4a3c9593e21058f5.1714159486.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714159486.git.alison.schofield@intel.com>
References: <cover.1714159486.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL Spec 3.1 Table 9-22 requires that the BIOS populate the CFMWS
target list in interleave target order. This means that the calculations
the CXL driver added to determine positions when XOR math is in use,
along with the entire XOR vs Modulo call back setup is not needed.

A prior patch added a common method to verify positions.

Remove the now unused code related to the cxl_calc_hb_fn.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c      | 63 ++---------------------------------------
 drivers/cxl/core/port.c | 18 ------------
 drivers/cxl/cxl.h       |  6 ----
 3 files changed, 3 insertions(+), 84 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 519e933b5a4b..67ab3cd52ead 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -22,58 +22,6 @@ static const guid_t acpi_cxl_qtg_id_guid =
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
-
 static u64 restore_xor_pos(u64 hpa, u64 map)
 {
 	int restore_value, restore_pos = 0;
@@ -364,7 +312,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	cxl_addr_trans_fn addr_trans;
-	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
 	struct resource *res;
@@ -404,16 +351,12 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (rc)
 		goto err_insert;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
-		cxl_calc_hb = cxl_hb_modulo;
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
 		addr_trans = NULL;
-
-	} else {
-		cxl_calc_hb = cxl_hb_xor;
+	else
 		addr_trans = cxl_xor_trans;
-	}
 
-	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb, addr_trans);
+	cxlrd = cxl_root_decoder_alloc(root_port, ways, addr_trans);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index cd4f004f5372..93a3a3982a57 100644
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
  * @addr_trans: address translation helper function
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
@@ -1817,7 +1801,6 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb,
 						cxl_addr_trans_fn addr_trans)
 {
 	struct cxl_root_decoder *cxlrd;
@@ -1840,7 +1823,6 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
-	cxlrd->calc_hb = calc_hb;
 	cxlrd->addr_trans = addr_trans;
 	mutex_init(&cxlrd->range_lock);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f0c3bd377259..adc9f785f938 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -430,15 +430,12 @@ struct cxl_switch_decoder {
 };
 
 struct cxl_root_decoder;
-typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
-					    int pos);
 typedef u64 (*cxl_addr_trans_fn)(struct cxl_root_decoder *cxlrd, u64 hpa, int ways);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
- * @calc_hb: which host bridge covers the n'th position by granularity
  * @addr_trans: dpa->hpa address translation helper
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
@@ -448,7 +445,6 @@ typedef u64 (*cxl_addr_trans_fn)(struct cxl_root_decoder *cxlrd, u64 hpa, int wa
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
-	cxl_calc_hb_fn calc_hb;
 	cxl_addr_trans_fn addr_trans;
 	void *platform_data;
 	struct mutex range_lock;
@@ -776,9 +772,7 @@ bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb,
 						cxl_addr_trans_fn addr_trans);
-struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
-- 
2.37.3

