Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AA72625
	for <linux-cxl@vger.kernel.org>; Sun, 13 Jul 2025 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374286; cv=none; b=p4qsswSYASucCcvn9HJZgHew8g7zc8oOoNs/OXteECCH3x5kSxFW9/+UHCAWzC89hLD2ZqqM5kazOCvHgabVYElj87ccIJ6MMF3oIop5oDofTv68TwGN5MqpCLYHMvxIU/bVgiU/U1cdZhOCgHNvMtiaAy9h2ZVUClka/tu8Xcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374286; c=relaxed/simple;
	bh=TVxGkNzCVLoxrNzx/DEe8tt0xkp7CYSwROhV1IMjWoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8119a/4fq2DZUM89vo0bYFjrc502nq3BDNKTQdnUIGvfWiccNBj0qQeeZ0HhCy7dz5b/QY0FLL5z/fmRb2MF37D0ceg0qJSRLodgyRwoCycYrmvBgzBATZ4BzgYXRyBadEAFSik0VOKwK4N9s5gia6xQky9WgtSVamPqWcvZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHQdW0tO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHQdW0tO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752374284; x=1783910284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVxGkNzCVLoxrNzx/DEe8tt0xkp7CYSwROhV1IMjWoE=;
  b=lHQdW0tOwbIMxxDTk5Hr8vwdAO/dqXlE6s6Z/zE5ATA8lhNsBdF0/3Cf
   9jCpKUt7feECYCPK7NKq0XwfihVvNpPj4avtGyV74cv933xMor8tL1sP8
   6DsxmsrOo96Oxo1T1ccfgx6PrAe4+gTq3mtdSsx5tNrxPF2TRJ6F+PxdV
   lqi4DmdLvwUwazKtuLv5/osroIGaYpyrZdD8lrrckK78dTRunXj01BQTv
   gKnRQbean4PpFiWbZql5ZGNYFplTnQgMZrISqR8oNBHze1Iee07VQTGT3
   gqqy8Vqd56pXfKDe+TbJHLY8ruop9bsHPb1pgEQuB1H+gxc61IGObgyXI
   w==;
X-CSE-ConnectionGUID: /l5kz1NBT+iExg7pD7zmgQ==
X-CSE-MsgGUID: 0PmmDHo/T1et99wBwsOvpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65967439"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65967439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:03 -0700
X-CSE-ConnectionGUID: B2e2TMWRT5KryTsKQxVhIQ==
X-CSE-MsgGUID: 31MU+8IXSfOLpPGZh5JbcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="157206909"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.247])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 19:38:02 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/4] cxl: Define a SPA->CXL HPA root decoder callback for XOR Math
Date: Sat, 12 Jul 2025 19:37:54 -0700
Message-ID: <4f96dac1c131b45010881a3fca0f818dab25060d.1752365427.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1752365427.git.alison.schofield@intel.com>
References: <cover.1752365427.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When DPA->SPA translation was introduced, it included a helper that
applied the XOR maps to do the CXL HPA -> SPA translation for XOR
region interleaves. In preparation for adding SPA->DPA address
translation, introduce the reverse callback.

The root decoder callback is defined generically and not all usages
may be self inverting like this XOR function. Add another root decoder
callback that is the spa_to_hpa function.

Update the existing cxl_xor_hpa_to_spa() with a name that reflects
what it does without directionality: cxl_apply_xor_maps(), a generic
parameter: addr replaces hpa, and code comments stating that the
function supports the translation in either direction.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

No changes in v3

 drivers/cxl/acpi.c | 30 ++++++++++++++++++------------
 drivers/cxl/cxl.h  |  3 +++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a1a99ec3f12c..fd12b9a96246 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -21,7 +21,7 @@ static const guid_t acpi_cxl_qtg_id_guid =
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
 
-static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 {
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
 	int hbiw = cxlrd->cxlsd.nr_targets;
@@ -30,19 +30,23 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 
 	/* No xormaps for host bridge interleave ways of 1 or 3 */
 	if (hbiw == 1 || hbiw == 3)
-		return hpa;
+		return addr;
 
 	/*
-	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
-	 * the position bit to its value before the xormap was applied at
-	 * HPA->DPA translation.
+	 * In regions using XOR interleave arithmetic the CXL HPA may not
+	 * be the same as the SPA. This helper performs the SPA->CXL HPA
+	 * or the CXL HPA->SPA translation. Since XOR is self-inverting,
+	 * so is this function.
+	 *
+	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) applying the
+	 * xormaps will toggle a position bit.
 	 *
 	 * pos is the lowest set bit in an XORMAP
-	 * val is the XORALLBITS(HPA & XORMAP)
+	 * val is the XORALLBITS(addr & XORMAP)
 	 *
 	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
 	 * as an operation that outputs a single bit by XORing all the
-	 * bits in the input (hpa & xormap). Implement XORALLBITS using
+	 * bits in the input (addr & xormap). Implement XORALLBITS using
 	 * hweight64(). If the hamming weight is even the XOR of those
 	 * bits results in val==0, if odd the XOR result is val==1.
 	 */
@@ -51,11 +55,11 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 		if (!cximsd->xormaps[i])
 			continue;
 		pos = __ffs(cximsd->xormaps[i]);
-		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
-		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
+		val = (hweight64(addr & cximsd->xormaps[i]) & 1);
+		addr = (addr & ~(1ULL << pos)) | (val << pos);
 	}
 
-	return hpa;
+	return addr;
 }
 
 struct cxl_cxims_context {
@@ -413,8 +417,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxlrd->qos_class = cfmws->qtg_id;
 
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
-		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
+		cxlrd->hpa_to_spa = cxl_apply_xor_maps;
+		cxlrd->spa_to_hpa = cxl_apply_xor_maps;
+	}
 
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 50799a681231..75e60a313be5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -419,12 +419,14 @@ struct cxl_switch_decoder {
 
 struct cxl_root_decoder;
 typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
+typedef u64 (*cxl_spa_to_hpa_fn)(struct cxl_root_decoder *cxlrd, u64 spa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
+ * @spa_to_hpa: translate Platform system-physical-address to CXL host-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -434,6 +436,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_hpa_to_spa_fn hpa_to_spa;
+	cxl_spa_to_hpa_fn spa_to_hpa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-- 
2.37.3

