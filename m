Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60615AD9C
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835027; cv=none; b=Sh/nN4/k6omXBFmved/HxQIRWOEREaBhk25l1aNr3Z1bxY0K5jLso/W1mYyYGihtxtAJ3kJaZGS5985cg1rCkLK8bdeQHD2Kc77QQIdUUGzvJDJ/HKSsp4tGOndBUobc0HS9jeiT+C3Eiw2WIs++V4Rc9jSiCoUQYbjsmj7/OVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835027; c=relaxed/simple;
	bh=KK5Gj3jhOLfFJrDZozwHot44Z64Z9TXr0NckbSv0uDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7lnhRbVCUldLKI1JhGHiStKfHqy3FwLWLfxnEiqSVT3xA1IibPqwOH5yaI1SKIqfJ/l5MwJiDktutlH/n2UoP6l+GRa1DWxDz6QGtvpkgQApHLcdznhr7glcSwK0y1gFEEEtgJLmaReFWyEMj/kx2bQlu77imdOEovD4xALxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwucQj++; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwucQj++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724835026; x=1756371026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KK5Gj3jhOLfFJrDZozwHot44Z64Z9TXr0NckbSv0uDM=;
  b=TwucQj++Wv9ZCKRWnN9XPHTitwTRITNptZFsq5Ht0OOdZAuO6QFDXHns
   qreOJA4d3B8k/e6vEgFfUAfV87oUAiIA/Pc9Xn4+OWG38Ot6NKjSah6oM
   tVp3gibe72VKSeZrZ720NvnKn48hFi2jWzSynpLRBDw9HKDG76RYEgQEk
   23YSPDROYwUn6ZIJWkF8mAkgiLmaXFRTq8OX0YWQZbuKYm+/2ldeGW7V6
   vcGRQVRfkk7FTNHLiyvh6NZAu2wDTNrAQNHk4ZfkiMCMbYKN9oBjeeaAe
   p6YqhzWjfluS4z85uS7fCCniJrEuLJJqFMGbNoxfN+67m3hxjdzKAMddu
   g==;
X-CSE-ConnectionGUID: GCHkl5pMRae1taQhOdFXOQ==
X-CSE-MsgGUID: FhdBga9fRPepjiutSk4iKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22874638"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22874638"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:25 -0700
X-CSE-ConnectionGUID: xZXJ1FP4QuGGbobyLFFUUw==
X-CSE-MsgGUID: D8sGPEsISEO0KKB45167eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62999089"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:18 -0700
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
Subject: [v4 4/4] cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()
Date: Wed, 28 Aug 2024 16:42:31 +0800
Message-Id: <20240828084231.1378789-5-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828084231.1378789-1-yanfei.xu@intel.com>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cda22feadbd3..a3f0e907d08c 100644
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

