Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DF82D93
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194080; cv=none; b=DPZB9jiHgnZY2n5Yt4gZg8C/YWXoXVDVlguz1TFsFs9mGj5IYUJTLJ/xeSs+3tkPTCFi39H1E87x1KxKm5IIQJibrlMGuD+woqCN1zMzDk+0VCxQ0ADvpAk7/OYJJnHZb5nsm2cMqcVIrShKueKMVWY9gWZZm+v0sSvxWRMG7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194080; c=relaxed/simple;
	bh=4PNzCZnTcw4cicrLbNi2KIUdcRIC3DZCHRKY08omsxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttIWfmcCWaJUUKu6ThYuGlSw81J8elF1wDJozYVpn0TRVtFA7QdyRFPanm5ZHw4CBQ8N1wMgz7311RpNgPvku9TNuJAeGsG8zMU0YqMgR8eEwuM+CgBuQjA7KUg1Soxi67OOatsd9OPKOCr8pEElq7KOLYv6/PcMK6YSqERtqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcYsWaO0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcYsWaO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194078; x=1746730078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4PNzCZnTcw4cicrLbNi2KIUdcRIC3DZCHRKY08omsxE=;
  b=KcYsWaO05jB+A9Y6ABWsTZKYotyAlL2esTxCklhdDtpBJGyWZGN/f8NH
   y/YHJ1Y9zuvfCfPWfm2bpBd51fAEkB45NNZhglR/CD6Qx/CnFYwZ0BkoY
   6UJXlGpQFy0XcYsK8bZrLdfA4iXxWvImX3/+ji35n7wWUvJuGeMQ4y2xE
   vlYEoJnoMQeUrBnPl5zRJcToj4kYnDW39G3wZNLDi32rcx6PKybvIS401
   Wg7D7dnNToAY6Kb77wJqYPJHmhf1cMZ+BMQ7mROXDzyiwUm7FEEDPhrqX
   ik5li7X0QzfrKRQlj8W+krP096RFcSsVqS9qpBJwri0TbfJz6ZeRK1/iZ
   w==;
X-CSE-ConnectionGUID: YkzTRJ/CRLSa8Jmu4fxXXQ==
X-CSE-MsgGUID: WnPhkhdcRzCwMl2c1jYJVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21675611"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21675611"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:57 -0700
X-CSE-ConnectionGUID: yP91DdIhSwORqqNDTkbH0Q==
X-CSE-MsgGUID: +2uvSsYHTI6H9sMMscAk+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33531060"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.242.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:57 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during address translation
Date: Wed,  8 May 2024 11:47:51 -0700
Message-Id: <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1715192606.git.alison.schofield@intel.com>
References: <cover.1715192606.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When a CXL region is created in a CXL Window (CFMWS) that uses XOR
interleave arithmetic XOR maps are applied during the HPA->DPA
translation. The XOR function changes the interleave selector
bit (aka position bit) in the HPA thereby varying which host bridge
services an HPA. The purpose is to minimize hot spots thereby
improving performance.

When a device reports a DPA in events such as poison, general_media,
and dram, the driver translates that DPA back to an HPA. Presently,
the CXL driver translation only considers the modulo position and
will report the wrong HPA for XOR configured CFMWS's.

Add a helper function that restores the XOR'd bits during DPA->HPA
address translation. Plumb a root decoder callback to the new helper
when XOR interleave arithmetic is in use. For MODULO arithmetic, just
let the callback be NULL - as in no extra work required.

Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/port.c   |  5 +++-
 drivers/cxl/core/region.c |  5 ++++
 drivers/cxl/cxl.h         |  6 ++++-
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..20488e7b09ac 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 	return cxlrd->cxlsd.target[n];
 }
 
+static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int hbiw = cxlrd->cxlsd.nr_targets;
+	u64 val;
+	int pos;
+
+	/* No xormaps for host bridge interleave ways of 1 or 3 */
+	if (hbiw == 1 || hbiw == 3)
+		return hpa;
+
+	/*
+	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
+	 * the position bit to its value before the xormap was applied at
+	 * HPA->DPA translation.
+	 *
+	 * pos is the lowest set bit in an XORMAP
+	 * val is the XORALLBITS(HPA & XORMAP)
+	 *
+	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
+	 * as an operation that outputs a single bit by XORing all the
+	 * bits in the input (hpa & xormap). Implement XORALLBITS using
+	 * hweight64(). If the hamming weight is even the XOR of those
+	 * bits results in 0, if odd the XOR result is 1.
+	 */
+
+	for (int i = 0; i < cximsd->nr_maps; i++) {
+		if (!cximsd->xormaps[i])
+			continue;
+		pos = __ffs(cximsd->xormaps[i]);
+		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
+		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
+	}
+
+	return hpa;
+}
+
 struct cxl_cxims_context {
 	struct device *dev;
 	struct cxl_root_decoder *cxlrd;
@@ -362,6 +399,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	struct cxl_cxims_context cxims_ctx;
 	struct device *dev = ctx->dev;
 	cxl_calc_hb_fn cxl_calc_hb;
+	cxl_translate_fn translate;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
 	int rc;
@@ -389,13 +427,17 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	if (rc)
 		return rc;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
 		cxl_calc_hb = cxl_hb_modulo;
-	else
+		translate = NULL;
+
+	} else {
 		cxl_calc_hb = cxl_hb_xor;
+		translate = cxl_xor_translate;
+	}
 
 	struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
-		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
+		cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb, translate);
 	if (IS_ERR(cxlrd))
 		return PTR_ERR(cxlrd);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 762783bb091a..32346c171892 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1808,6 +1808,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  * @port: owning CXL root of this decoder
  * @nr_targets: static number of downstream targets
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @translate: decoder specific address translation function
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add(). A
  * 'CXL root' decoder is one that decodes from a top-level / static platform
@@ -1816,7 +1817,8 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
  */
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb)
+						cxl_calc_hb_fn calc_hb,
+						cxl_translate_fn translate)
 {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_switch_decoder *cxlsd;
@@ -1839,6 +1841,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	cxlrd->calc_hb = calc_hb;
+	cxlrd->translate = translate;
 	mutex_init(&cxlrd->range_lock);
 
 	cxld = &cxlsd->cxld;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 245edf748906..2fe93c5a8072 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2752,6 +2752,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 			  struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	int pos = cxled->pos;
@@ -2791,6 +2792,10 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start;
 
+	/* Root decoder translation overrides typical modulo decode */
+	if (cxlrd->translate)
+		hpa = cxlrd->translate(cxlrd, hpa);
+
 	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
 		return ULLONG_MAX;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 80f58b96dc1c..e11155002213 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -434,12 +434,14 @@ struct cxl_switch_decoder {
 struct cxl_root_decoder;
 typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
 					    int pos);
+typedef u64 (*cxl_translate_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @translate: decoder specific address translation function
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -449,6 +451,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
+	cxl_translate_fn translate;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
@@ -773,7 +776,8 @@ bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
-						cxl_calc_hb_fn calc_hb);
+						cxl_calc_hb_fn calc_hb,
+						cxl_translate_fn translate);
 struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
-- 
2.37.3

