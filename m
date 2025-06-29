Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA041E47B7;
	Sun, 29 Jun 2025 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185326; cv=pass; b=cLT+0fjM+BbQtzXXh/+54y+NsVD/T39+SrsAlGUfpXZEUzwTd3JWnuh29iL3J23xls2YW8P7SHsgMU9ipdSsQTf1jCpvmhfVSPgJDMMT+yUsDeUt1Pe+SPGqShYAKX/8OxMKFmNEDtix7m82oK5XBoxdyVlHUjnjgxyX4ocbdRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185326; c=relaxed/simple;
	bh=+RM+r3ays+K16RV/hadA4OkB30NF1QxjnfGKLIdd8og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PNr1LQ19JuvnnnHThjwST+uaUC1Z5Xz5e2y6g3lOKdyAVrcMLVzI2AOtdWKizxCMor8UyeT5kh0JLuvOgzw5T+itALuy2FrvhbJUDxQ2uIhqjzfQj5a433TAFgwgRhe5zjQKenwaBFqNhCVZH0IkhVuQJAx1uF/qdyXdKEJTGEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ObZ+6Pg2; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ObZ+6Pg2"
ARC-Seal: i=1; a=rsa-sha256; t=1751185305; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D4mphBy9zkDFx9KhpX7o9osPcCq/MXmJMrfcfmU61yHuFegBhv1DAZQkVacMDFHX+TS51ghJu2Q1h+2vNj7UjMmNHSSURuhAt5M/HfwaxZ3Mlt6UuG3xVXDuHrhsA5XQw/WyQnDzOOLOrYGvXypkXmTwW0YuxAIiAI+V8ve5j/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751185305; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j9HhW+KKeBFIAXptGOgjq9833pJH9mLDVqO2MWM7fI8=; 
	b=Xa1VuigMEqBhf53wU+nO7a4aYakNVQdly/nle9CPNKLBc5ntpwf8JXBD9hzgO6g9R0IRYjTSNT2t59T20L4mx5ROMvozpR1klTREEQPpsRLPgdks/LjLXKJwjdfiSsNHh0PrKCR445+MJZxKx9oV1MubXoxe7ZwKTcjOwm8zgEk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751185304;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=j9HhW+KKeBFIAXptGOgjq9833pJH9mLDVqO2MWM7fI8=;
	b=ObZ+6Pg20T6xpB12cf/yIMshQEKo0Fr0Du/GN8nX9Vp5iAkJytnUMs+HfYSR6RTV
	qs0J4IWc/j6CL9ccmhIZsxj/lXDqKqktXrA/qrzx9fXS0IEn4PDKvtvIaK7cYRH3reU
	AvXTxjgWlP+c+twwBVhIiJuGjbx4r/fv+HY2e5I4=
Received: by mx.zohomail.com with SMTPS id 1751185302512722.333465929968;
	Sun, 29 Jun 2025 01:21:42 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
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
Subject: [PATCH 2/2] cxl/core: Add a helper function to check dpa availability
Date: Sun, 29 Jun 2025 16:20:42 +0800
Message-Id: <20250629082042.256123-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629082042.256123-1-ming.li@zohomail.com>
References: <20250629082042.256123-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122743e41694e6889180c5513bec00008b1cb390e7967cd46cda0770971d899b33aeee273c290e3b85:zu0801122772fef8b0f278b9d83d795e6a000067bd10dc682d51b6180b66505c8a0b6ff0d685bfe8d0929b88:rf0801122dc06b9a69fe1a7127764a16170000f72a1e2710b35db733d265f378a6b2847c075557903a993cc3021081b01cd3:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, many pieces of code that need to check dpa
availability in case using wrong dpa. Add a helper function called
is_valid_dpa() for dpa availability checking.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/edac.c   | 7 +++----
 drivers/cxl/core/hdm.c    | 5 +++++
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..38d619df4772 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -136,4 +136,5 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+bool is_valid_dpa(struct resource *res, u64 dpa);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 11eaa2eea642..469be1ecb703 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1523,7 +1523,7 @@ static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
 	struct cxl_memdev *cxlmd = ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+	if (!is_valid_dpa(&cxlds->dpa_res, dpa))
 		return -EINVAL;
 
 	ctx->dpa = dpa;
@@ -1892,7 +1892,7 @@ static int cxl_ppr_set_dpa(struct device *dev, void *drv_data, u64 dpa)
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
+	if (!is_valid_dpa(&cxlds->dpa_res, dpa))
 		return -EINVAL;
 
 	cxl_ppr_ctx->dpa = dpa;
@@ -1926,8 +1926,7 @@ static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (cxl_ppr_ctx->dpa < cxlds->dpa_res.start ||
-	    cxl_ppr_ctx->dpa > cxlds->dpa_res.end ||
+	if (!is_valid_dpa(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
 	    val != EDAC_DO_MEM_REPAIR)
 		return -EINVAL;
 
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..3dc9215ea94d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -547,6 +547,11 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 	return base;
 }
 
+bool is_valid_dpa(struct resource *res, u64 dpa)
+{
+	return (dpa >= res->start && dpa <= res->end);
+}
+
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..46ea0536221c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -267,7 +267,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 		dev_dbg(cxlds->dev, "device has no dpa resource\n");
 		return -EINVAL;
 	}
-	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
+	if (!is_valid_dpa(&cxlds->dpa_res, dpa)) {
 		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
 			dpa, &cxlds->dpa_res);
 		return -EINVAL;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..994ca02b2b48 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2847,7 +2847,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return 0;
 
-	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+	if (!is_valid_dpa(cxled->dpa_res, dpa))
 		return 0;
 
 	/*
-- 
2.34.1

