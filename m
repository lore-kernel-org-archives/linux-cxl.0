Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE95223DCD;
	Wed,  2 Jul 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440914; cv=pass; b=Qfo9qSruqjitwux9SjLqMnRGO7WAgD6uCvpC1qoyJbC4VcfFcc0aAnch74v/I72cAbKr3nukyWHWM39925fbmS3WpSFFsEJsyAOTWZOzVpir9X5a8vcmc8QDvV9OYRdcrGJCEzfvFwOwke4VzznlwQTVzzbH5c1RlBGfnI5ihk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440914; c=relaxed/simple;
	bh=yqQBLnCWIwzmelNjOqBsAdm2CxKpCnetfezc6JNWm2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMvsuH2V6b9XGsAlvg80wbl9iLM7c6S+Qt6V/PmOBMn58ObL/hTgKjZwl9EGn/d+MA1IBAeU/zvLZQougvOdvcvgyX8X412yb1vRnyKx4ybzhfctc4a5v1MPgCp/FP7BjqKUGmE9pJje5+23IA6vOGHGw3gE5K22pYlojsxMixw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MixBbam2; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MixBbam2"
ARC-Seal: i=1; a=rsa-sha256; t=1751440868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LeMGg4wK3KwmHi/w8yFL1MOqR/e7jRRm+5xfN8vOLkfaOBPUaS0eCrQ/njPlaO8A2M+aKdGIAoGKjOAc39wMihV4eaGLn1E9wUS7SA5XKWzLHszuU7h2qU7RNhymfZoVE6sXpBEQl0oliFFi1RutHdN8VCSGSGItvSkPeTI9yow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751440868; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Pmojcacwl6r3Ued+iszIAObwj+kmlNOSKi/S7iYpwc=; 
	b=GFUf0z4Xo/p1obyGBe5x04WCHlOv8zZTgOhd/bW2DXdD99QNNOVkDW0qrjexYCs1PzwLCf1ST7oAg2HhZp23McivxU/xmVwI/OBnh1fm5yPZT5yedlhCSHpa13CEwbP3QmJIABjYzWoGYGlR1jd2PoyBMnvY3E4wkj+0gyDACBc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751440868;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=0Pmojcacwl6r3Ued+iszIAObwj+kmlNOSKi/S7iYpwc=;
	b=MixBbam2con3kJzVgyspLM6OfIRRT9NmMZBzDLySWR0+HJjpX0ek/yILoyjCVlf7
	iGdKdmJqvKWagYOLU1rFZ8m9RfQntzji326mGdemmZn4xpZZ7LvuprIPuorMKToqX+J
	bhLzAozoyjw/BPXCkuweZxCIhNxsaj804yn+Zp7A=
Received: by mx.zohomail.com with SMTPS id 1751440866770473.6101901530126;
	Wed, 2 Jul 2025 00:21:06 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 3/3] cxl/core: Using resource_contains_addr() to check address availability
Date: Wed,  2 Jul 2025 15:20:08 +0800
Message-Id: <20250702072008.468371-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702072008.468371-1-ming.li@zohomail.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112271b71f97e36ef67dfbb8370c10000368428d90d561e1d914b655c596f1e241841b3db92a1ba9a83:zu08011227467ff9a043bdf37b25ef5ce9000097679fe9e5150e8b929bcfb1d670cddb2ba10612247452418b:rf0801122d235dee91d5c5aa06f75b4abe0000491dc140a12ed4c98263857ab0e6ad0f9521a202ab43144e77ebccf802068d:ZohoMail
X-ZohoMailClient: External

Helper function resource_contains_addr() can be used to check if a
resource range contains an input address. Use it to replace all
code that checks whether a resource range contains the input
DPA/HPA/SPA.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/edac.c   | 4 ++--
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 1cf65b1538b9..a3c19ec8033f 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1523,7 +1523,7 @@ static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
 	struct cxl_memdev *cxlmd = ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+	if (!resource_contains_addr(&cxlds->dpa_res, dpa))
 		return -EINVAL;
 
 	ctx->dpa = dpa;
@@ -1892,7 +1892,7 @@ static int cxl_ppr_set_dpa(struct device *dev, void *drv_data, u64 dpa)
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+	if (!resource_contains_addr(&cxlds->dpa_res, dpa))
 		return -EINVAL;
 
 	cxl_ppr_ctx->dpa = dpa;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..4a5dc1d93af1 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -267,7 +267,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 		dev_dbg(cxlds->dev, "device has no dpa resource\n");
 		return -EINVAL;
 	}
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
+	if (!resource_contains_addr(&cxlds->dpa_res, dpa)) {
 		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
 			dpa, &cxlds->dpa_res);
 		return -EINVAL;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..79d8211f8ed0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2847,7 +2847,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return 0;
 
-	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+	if (!resource_contains_addr(cxled->dpa_res, dpa))
 		return 0;
 
 	/*
@@ -2959,7 +2959,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (cxlrd->hpa_to_spa)
 		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
 
-	if (hpa < p->res->start || hpa > p->res->end) {
+	if (!resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
 			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
 		return ULLONG_MAX;
@@ -3499,7 +3499,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 	xa_for_each(&endpoint->regions, index, iter) {
 		struct cxl_region_params *p = &iter->region->params;
 
-		if (p->res->start <= spa && spa <= p->res->end) {
+		if (resource_contains_addr(p->res, spa)) {
 			if (!p->cache_size)
 				return ~0ULL;
 
-- 
2.34.1

