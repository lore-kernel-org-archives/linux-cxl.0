Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AEC23CB;
	Tue,  8 Jul 2025 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951834; cv=pass; b=lHjEg69u4olH6IYzeEWtvxQ2GB444dZlwJX8cqkQBEQdF/AqTBLnWRrUpLLqKqpmMGwFCnrew8P28XDp1db3rxHCeMPvrvzG1JwRcCYDIQOp9rm54uYNgevxsTOqdbS0WjWx5xoX3S4yu/FdzebdSuY/ZrxCvdUULjx1ZozsjY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951834; c=relaxed/simple;
	bh=yqQBLnCWIwzmelNjOqBsAdm2CxKpCnetfezc6JNWm2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUa9Ixei0Akwhi/PmE+AF7pVdGEWVbGiELO6gyHQ8UAn2DbGTzEm2+ZpuPQQ1oY0uw305vudHaZJYMmpgv3iiJLZ1Zh5f6EfLKTHn7zdztfUf2IHNKabJwSRGMoJOtBfdWYlXhFan53Jyc4C/n6pYpKcUfEvhzk/wOOonyX+/vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CvEaQ9t2; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CvEaQ9t2"
ARC-Seal: i=1; a=rsa-sha256; t=1751951801; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K/gKclbw5EaUYrNOWJglHQN4v+q5KlFxhp3bWXx728qXSvCSYJEJMksoAxd2aOBQnHL7aoWUTUcro0UdaVHdArfIxPOZ6PnCFlRMvkn2T1zJHTuhBQMbzr3FMQeRjMl/QTTJNb0972pyE/MFPluGiAcgPd2p0SQ8gB4oOq5rZBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751951801; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Pmojcacwl6r3Ued+iszIAObwj+kmlNOSKi/S7iYpwc=; 
	b=mJYAQHhCb/W2AevEdd0pgiqgGdvEH74M0wOGrxOXkX6AojriXPJipKEdgb1pT1eNOw0NapNWTcxounhbpY5/PK0YRy7YfTG6HAi0X3I2dsvEz/EoRnkFtljOUO/CLfnsbn7QJBuFbP41EKbcVcrv0f5Ny8kxVauPyGB1Ff92J6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751951801;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=0Pmojcacwl6r3Ued+iszIAObwj+kmlNOSKi/S7iYpwc=;
	b=CvEaQ9t27uOQ2Qp0hnBrm4sphlA+go/AxvHFPHvwnysmb0xwYaKsbL2QwoY4qP6R
	aCeRMQGXPzS9kgwHM5uTIw1yG/9GhgwZ+nL8Vk3Td2XmGJxweHgShjXciBkXtIJWZ6N
	gPoQM6EcJY5rPrcPcDQaNX87MauVJGKrZu/VY7PA=
Received: by mx.zohomail.com with SMTPS id 1751951799043184.00928419554668;
	Mon, 7 Jul 2025 22:16:39 -0700 (PDT)
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
Subject: [PATCH v3 3/3] cxl/core: Using resource_contains_addr() to check address availability
Date: Tue,  8 Jul 2025 13:15:36 +0800
Message-Id: <20250708051536.92119-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708051536.92119-1-ming.li@zohomail.com>
References: <20250708051536.92119-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a6db064b8cd5835b60263f700000b1d374ed54791f2176c5f9dc75bc932213985b9a52f0b2cc2a:zu0801122756545e54832287663b65581b0000b1653817906c84f1d37255a88cce93717998c7dbab2d9b6354:rf0801122d5fce4a1cbbd4e26e642d5b4700007fad9d880d9f9ffc492842a97256ec9761e19cd7861a1b8d4197e4070c127d:ZohoMail
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

