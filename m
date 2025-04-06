Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC21A5B9C
	for <linux-cxl@vger.kernel.org>; Sun,  6 Apr 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743938858; cv=none; b=On0RfH/NP9thIoQ78smYcyfD0pMTzBT8hMkZXQcanwNjI0MEPrc8OC/89+etjpSP04PH6cyP+adnpbjyPbyBKS/pYi3XvFr8wborfx83x/NVptzwDlpcU+SpmwIiahuq5rfklsasv6Y8qh2bEKJpP7wdtBzZheAoADZd8x3Eupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743938858; c=relaxed/simple;
	bh=NLz/R+Ri3KLobR0D0P8C7mYBFAl8obxLMWUqWAWzB7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jzFItHNkcDtVWh7ahsNH7aRza5izwby2jBY4ELo7ffBT6nuEm9CefKDHfudIF+0kPAK3lrQtazPwPF0HnBH7pPy6mGFqA+taPj3DhN6+7XVSzUhILXVnRygCu1gxfFDRias4S6im57I7ypE1u3nZJ8xryEnpIHUZUGlaYxR69Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPptt1zt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPptt1zt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743938857; x=1775474857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NLz/R+Ri3KLobR0D0P8C7mYBFAl8obxLMWUqWAWzB7E=;
  b=iPptt1ztFFeac0eoVLrEzyrlArNzHmTVEOaaXODtD84UPeJnAHrtjZCJ
   Wrf1x4xY+Xpyz3IJKEhG5MZBW5TUCXbLLiqsmDIvjk2hGXFtpEwO/eDBq
   qpIDn4G9/N6dmls0Q5t01vvmOF05bdVUbyl7rU6tpIm1tBOWP9ApHIep4
   imQkTRM4sjJ76vHTPvBGOZtfpdrq9TViv0j0c0Q8Daw+p9cKtGxIRQX7n
   6hbTwuPRzeekzykQbyv6EPNlyyc9Ep/9bdcIxi0NFsoV1204Mu7USMwDP
   D32sxi9ztksFC8xbqRSBRgqcV+S4ZbdQ9fLvmfK+qIv+gACJrA50kKo8j
   A==;
X-CSE-ConnectionGUID: hlJuQS3AQWavZFaT0D3pxA==
X-CSE-MsgGUID: mXecmQygRb+McxbD+I2MAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45465571"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45465571"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 04:27:36 -0700
X-CSE-ConnectionGUID: kCvWjB88SgCScE1bOIxrYA==
X-CSE-MsgGUID: SOmoSIIdTyqriJWN01WhhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="128196061"
Received: from unknown (HELO ixc04.bj.intel.com) ([10.238.153.130])
  by fmviesa010.fm.intel.com with ESMTP; 06 Apr 2025 04:27:34 -0700
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com
Cc: pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control when RR decodes outside platform ranges
Date: Sun,  6 Apr 2025 19:27:52 +0800
Message-Id: <20250406112752.1261855-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some scenarios, the probe of endpoint ports would fail because of range
register (RR) decodes outside platform defined CXL ranges.

  [kernel debug message]
  cxl_hdm_decode_init:447: cxl_pci 0000:10:00.0: DVSEC Range0 denied by
  platform
  cxl_pci 0000:10:00.0: Range register decodes outside platform defined CXL
  ranges.
  cxl_bus_probe:2073: cxl_port endpoint3: probe: -6
  call_driver_probe:590: cxl_port endpoint3: probe with driver cxl_port
  rejects match -6

This defect could be found with Qemu CXL branch for a long while with a
specified probability, even with the latest branch cxl-2025-03-20.

The root cause of this defect comes from that, bit CXL_DVSEC_MEM_ENABLE of
DVSEC control has been set but in cxl_hdm_decode_init
CXL_HDM_DECODER_ENABLE has NOT been set and also endpoint's dvsec_range is
not covered by root decoder's hpa_range.

When encountering similar problems of the firmware, the patch could be
effective for solving.
Instead of Return error when RR decodes outside platform cxl ranges,
driver disable Mem_Enable bit of DVSEC control then take it as the way of
no setting info->mem_enabled.

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
---
 drivers/cxl/core/hdm.c |  2 +-
 drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++----------
 drivers/cxl/cxlmem.h   |  2 ++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 50e6a45b30ba..b776fb848f42 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -80,7 +80,7 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 	u32 hdm_cap;
 
 	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
-	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
+	cxlhdm->decoder_count_cap = cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 013b869b66cb..5452bb285140 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -403,7 +403,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	struct device *dev = cxlds->dev;
 	struct cxl_port *root;
-	int i, rc, allowed;
+	int i, rc, allowed = 0;
 	u32 global_ctrl = 0;
 
 	if (hdm)
@@ -426,15 +426,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENODEV;
 	}
 
-	if (!info->mem_enabled) {
-		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-		if (rc)
-			return rc;
-
-		return devm_cxl_enable_mem(&port->dev, cxlds);
-	}
-
-	for (i = 0, allowed = 0; i < info->ranges; i++) {
+	for (i = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
 		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
@@ -448,6 +440,29 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		allowed++;
 	}
 
+	if (info->mem_enabled && !allowed) {
+		dev_warn(dev, "RR decodes outside ranges, have a try by disabling Mem_Enable bit.\n");
+
+		/*
+		 * Instead of Return error when RR decodes outside platform ranges, reenable
+		 * Mem_Enable bit of DVSEC control for a try.
+		 */
+		rc = cxl_set_mem_enable(cxlds, 0);
+		if (rc)
+			return rc;
+
+		info->mem_enabled = 0;
+		cxlhdm->decoder_count = cxlhdm->decoder_count_cap;
+	}
+
+	if (!info->mem_enabled) {
+		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+		if (rc)
+			return rc;
+
+		return devm_cxl_enable_mem(&port->dev, cxlds);
+	}
+
 	if (!allowed) {
 		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
 		return -ENXIO;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..60b538f8b677 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -855,6 +855,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
  * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
  * @regs: mapped registers, see devm_cxl_setup_hdm()
  * @decoder_count: number of decoders for this port
+ * @decoder_count_cap: number of decoders from HDM Decoder Capability
  * @target_count: for switch decoders, max downstream port targets
  * @interleave_mask: interleave granularity capability, see check_interleave_cap()
  * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
@@ -863,6 +864,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
+	unsigned int decoder_count_cap;
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
-- 
2.39.3

