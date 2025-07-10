Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259628726A;
	Thu, 10 Jul 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130743; cv=pass; b=f5aEULc15QxS4XIbJSl5XYcb2j2PeLPgp/jdc392y6N2PVTvXaDRayBQElcoqV0naKI9ZSrZaKmJT1475RCHj7Wx4XPjOADXJt9liOkxZeEkG7hwhhMFV3ZOzDLGBE78oJ4ES+dTd9Ms+FwBaIAji6m3sIe7gyL1K9PaXlyI6HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130743; c=relaxed/simple;
	bh=BcwNWiG4TCpjQxFwIpv8ZvHCLdqAphP7U23UHuJs3t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zjd7VVAJU/hTZG+wXLUV0o6p+VdAzbMsipsW5OWDLLYRG+yxHkGP9EiG/1TE7JHJbhJCRuULIuKn2BAGeVaNfaq/uAdQoIZEs6fg0IEJ4dJNYOp+pHQYsTCQF51x5yMn3cicx+0EqLqEjUA8/8BMO0C8qg5rkp7PxZwXFlOuspE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eVju5WpD; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eVju5WpD"
ARC-Seal: i=1; a=rsa-sha256; t=1752130716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TTTJx7eYmpM9ZEO2hcVyj+tAW6kerk94JDGdWE+vjGCSNslq3AZJli82MUcuoJ0Ft2fJeY0h7+hWPY0lSuEbHDY47fgJQSNmdSpyO6Oo5aSiMMV9IQbeWZE9L3lZ4Pqu/C/ffmAr17kLZMwaED9lldYwJSoXw+B9IsDX5tJ54jQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752130716; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ckOVWQDcbW0/bI6DKdV/avMRcGSwau58/dhBJujU/Hk=; 
	b=VzWrUEShrPxqsv87Pj3kjZzY5HVwn/TL1eFM+7PgVmyyQEUelZpPQ+9D9dP5X0L06XIBj6TuTsCsPaODJLjbrcJ+qUvEOl64ba1Us9rylG7M1h1U0sChVF5teRTseEvwKpsSrssPyGmlRA965uV0O69kEAhwqdaaWH0dGikZkgE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752130716;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=ckOVWQDcbW0/bI6DKdV/avMRcGSwau58/dhBJujU/Hk=;
	b=eVju5WpDqzyT4Eef4S0fZbIyVyV9oytdCixd8gZwcUtQ1P7Pz/EsJkaCEURW2ucj
	+lVKGpCcbSQ7BUFbyZMjFcKav7twjrGjjHtOb3zjtRseWgT28kjkgQTEH7E2G76wXWD
	af2Q/nY2hbzZ6/8LCuJC5VvSN326VreQS9wqaZ+U=
Received: by mx.zohomail.com with SMTPS id 1752130714051765.1783342572533;
	Wed, 9 Jul 2025 23:58:34 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v4 3/3] cxl/core: Using cxl_resource_contains_addr() to check address availability
Date: Thu, 10 Jul 2025 14:56:47 +0800
Message-Id: <20250710065647.98094-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710065647.98094-1-ming.li@zohomail.com>
References: <20250710065647.98094-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b3eab6ab5fa6ee21dd2c3b8a0000777e95a87c650e9b747ba21e8b4257b093e23f7355e4fe5a32:zu080112274aa08f16a5989c1a38677978000039817680e332ffd6a977c0bf84d28cdf75295b4ed397934d1f:rf0801122d24eeb8b291a42bfa440b2a820000a88c504b100d025fa74644a4acfcfc7cd8cd04f1efc185b277949a16b81ec5:ZohoMail
X-ZohoMailClient: External

Helper function cxl_resource_contains_addr() can be used to check if a
resource range contains an input address. Use it to replace all code
that checks whether a resource range contains a DPA/HPA/SPA.

Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/edac.c   | 4 ++--
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 90151cc7fe52..d0d552e57a4d 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1523,7 +1523,7 @@ static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
 	struct cxl_memdev *cxlmd = ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+	if (!cxl_resource_contains_addr(&cxlds->dpa_res, dpa))
 		return -EINVAL;
 
 	ctx->dpa = dpa;
@@ -1892,7 +1892,7 @@ static int cxl_ppr_set_dpa(struct device *dev, void *drv_data, u64 dpa)
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+	if (!cxl_resource_contains_addr(&cxlds->dpa_res, dpa))
 		return -EINVAL;
 
 	cxl_ppr_ctx->dpa = dpa;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..769bd9be8b94 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -267,7 +267,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 		dev_dbg(cxlds->dev, "device has no dpa resource\n");
 		return -EINVAL;
 	}
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
+	if (!cxl_resource_contains_addr(&cxlds->dpa_res, dpa)) {
 		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
 			dpa, &cxlds->dpa_res);
 		return -EINVAL;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..91ff3a495fbd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2847,7 +2847,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return 0;
 
-	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+	if (!cxl_resource_contains_addr(cxled->dpa_res, dpa))
 		return 0;
 
 	/*
@@ -2959,7 +2959,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (cxlrd->hpa_to_spa)
 		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
 
-	if (hpa < p->res->start || hpa > p->res->end) {
+	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
 			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
 		return ULLONG_MAX;
@@ -3499,7 +3499,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 	xa_for_each(&endpoint->regions, index, iter) {
 		struct cxl_region_params *p = &iter->region->params;
 
-		if (p->res->start <= spa && spa <= p->res->end) {
+		if (cxl_resource_contains_addr(p->res, spa)) {
 			if (!p->cache_size)
 				return ~0ULL;
 
-- 
2.34.1

