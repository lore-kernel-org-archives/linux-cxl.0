Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6738FA6;
	Fri, 11 Jul 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203537; cv=pass; b=gHSfiYRxdVxJiK3Fufb6NVwcRZQnRVhiyuOuELjIAj11MNaMGkNeWk9JHWBhKBKBsWPuVNaBsqciOMBYn1l7VR+4mxAmzmQj27rXKGa2ZiDJ4EfvPxu79BogM0zAzaVKosMOHtjHt6ZPsEuPdYCbsatKbx32bFM8BzBV3/VEkFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203537; c=relaxed/simple;
	bh=31pTOJLQLLOmM0kNLmYxRxIziNDgSTDkkEGFdzrDSqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxWtNvVLy/cgMHsg3Lh9e/Zu9MZa2nuHwBcvmIKCvUpZJ40MIS8/G2snV4gd5zlNYgepUsnFxILWMNfrU9BgKq1Rsq8xUXzoMiV12Ei0BAF56HHroWCLA6QhJIlwd8M9+p/l3KKxhaRrANG1JQXAf9S6Nf1DOfGYV0HS3i5k/po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZGQ6EF4i; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZGQ6EF4i"
ARC-Seal: i=1; a=rsa-sha256; t=1752203513; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kOuRbbJc1JKw+zK/736XO7Y4Vj/MUOyF1ZtjU2XluRCidWfiKVLNrbLldBldhzkJdYa9LlAAX9LZFeMo/ZfeA65YjiCdpB5fVovx5HEa2JTByB6q/GghGvGLFerI0UCL+bJ86y8kojveL0BkjvW1T/x4ycROpD3rhxTSnmHE+k0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752203513; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p9Wu2W086XENViu8Ob6/rPvkHD6HmlkgETjz3STunhU=; 
	b=OgMunKFw2ZUtO59lKL6GdXrsbT1I/hDf+9hSH9LdGvKmHoN2glZiUcft7LKZIL6jmvyZIGgE8wdHcdVrqxOSbBvwjY4sRE39aZr4x6Yui5zeQi2wwqq0+xHb7edraM4PIT95w/WiJawyTMnCYmVWYTN5fXNc+nyU7O0ep/OifLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752203513;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=p9Wu2W086XENViu8Ob6/rPvkHD6HmlkgETjz3STunhU=;
	b=ZGQ6EF4ieSBrfPzK6ZZUKtEcrWg9vdp+neSeuNJHYtffW1Y948XhB3ZpofT/9ONZ
	dWtphT+dDr15NOs5FlLbQmrtZyjSWC8f5pqT09f9ovXinCSY2z53WvPwcd0iehJsARh
	LjXSTr/IJeUoDLthAOGmDkdWjlzKoQD120eKeLIc=
Received: by mx.zohomail.com with SMTPS id 1752203510956229.7171969824907;
	Thu, 10 Jul 2025 20:11:50 -0700 (PDT)
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
Subject: [PATCH v5 3/3] cxl/core: Using cxl_resource_contains_addr() to check address availability
Date: Fri, 11 Jul 2025 11:11:01 +0800
Message-Id: <20250711031101.126990-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711031101.126990-1-ming.li@zohomail.com>
References: <20250711031101.126990-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a62d66d49f70cb93d1af8a770000baa0171fa723d30ad33cb8837b7498919583bd23cb2a62c950:zu08011227123ac02a2325b284fa94e297000077a815c7d6f6c18edb2c9b68026a0f5340c9bdadf63c40fccf:rf0801122d5f0935d0f2e5ffdd8ab5a62b0000a4ab05fbe538aed8f1dc9425be0c7f6e23a1806183add57c9d5f4e9bf6c473:ZohoMail
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
index 991fa3e70522..714d79fb8fa0 100644
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

