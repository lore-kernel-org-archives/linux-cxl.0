Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617D60EC4
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547596; cv=none; b=EJGFVnI7eFZxBAGj28HkePsRSe8L+Eg6ePmRfovlVwXxUVAkaQJPhuF3FQWKVAFSJwNrTF7TlmJPig7xW3Vl4gCptgGHcKmwGcqQ7o9szXdcXStnYt8cOenjVeykKp9L+jvukAwuoQPH5NcL4QkmE3wJjh9VWCTrMDBeoW/QTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547596; c=relaxed/simple;
	bh=kMjqxcvsJPTaZkKSSakL6w6VOlcnSVu80kSsAT0yGoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwFOD5DIB2aR6wiE26bazfeA13wobz/4ss5uaTKDxljXE5Yx9Qt6DHBeLcISTBSkge8jhTXHSm5ZR0nhPOCTVojNbXKMcrXK8sz/SzRFZABrlgKURbCQy3kuFUj//y9240KeWdXLFDOmA9V1PqOITjHVd6iaYwAWVz56uNblvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7894Puk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7894Puk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547595; x=1755083595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMjqxcvsJPTaZkKSSakL6w6VOlcnSVu80kSsAT0yGoY=;
  b=a7894PukFtkZdiG5e0UWKFalvrZlVdWpgWgYwJ8VQ/Gk/aXNcRn3Tt2m
   BWSJXLXewqXU5+sZW37kyxbNYI6ija4rHZlIf7HMH/yGgXh4PqucBE/Zv
   VNDG6EhtfFoXZaZsBI2vrQToGxGC2Et6+GuwjTVWw4ywBkYnDc7M0WZGk
   xz/uexeby9yKKgO8OAuuxWprXVFQsU5j/OL3FfcZ6lWSVfST7wl+kd5he
   ZuSvAY7oXXfB0kRDIcBWBcnoPvCxHJ+oztxvTlUZ5qknghvADssq/Rm2L
   gMKtx38VZbKTYZAadO7GMHEsDUn8GLEVDyPjRBotek+XqjDwHhCASLmy0
   w==;
X-CSE-ConnectionGUID: WwygHzvMTu6DrGanDCCD5A==
X-CSE-MsgGUID: jtYZoDPBSJSzTrmn1bIIxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21262357"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21262357"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:14 -0700
X-CSE-ConnectionGUID: ymDDzEDESySXB8R4SqK64w==
X-CSE-MsgGUID: Hz0H4BaqSEeu+LJy+xQm5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58568812"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:13 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v3 4/4] cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()
Date: Tue, 13 Aug 2024 19:05:32 +0800
Message-Id: <20240813110532.870869-5-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813110532.870869-1-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cases can be divided into two categories which are DVSEC range enabled and
not enabled when HDM decoders exist but is not enabled. To avoid checking
info->mem_enabled, which indicates the enablement of DVSEC range, every
time, we can check !info->mem_enabled once in advance. This simplification
can make the code clearer.

No functional change intended.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 519989ada48e..be00266c8907 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -426,7 +426,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENODEV;
 	}
 
-	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
+	if (!info->mem_enabled) {
+		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+		if (rc)
+			return rc;
+
+		return devm_cxl_enable_mem(&port->dev, cxlds);
+	}
+
+	for (i = 0, allowed = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
 		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
@@ -440,7 +448,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		allowed++;
 	}
 
-	if (!allowed && info->mem_enabled) {
+	if (!allowed) {
 		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
 		return -ENXIO;
 	}
@@ -454,14 +462,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
 	 * Decoder Capability Enable.
 	 */
-	if (info->mem_enabled)
-		return 0;
-
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-	if (rc)
-		return rc;
-
-	return devm_cxl_enable_mem(&port->dev, cxlds);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 
-- 
2.39.2

