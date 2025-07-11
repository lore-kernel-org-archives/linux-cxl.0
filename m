Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E698472;
	Fri, 11 Jul 2025 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204318; cv=pass; b=Uek3qryoOxXFXu4Qh9OJ4vPObz28ZQBscrMtr+UEbHUjXcmK8szfYVp2FrL242Uvq54BEthHxJkrbcydA0QiTybupOI3PxMIvL6s+OYsVYCUNYGoWck84PDkPGjDJkWxCjr1/zD3k1qmdmGFjwRw86uHUPlz7C6vKtldrElVINQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204318; c=relaxed/simple;
	bh=hPdyobvwyLBaF4atMNDrLur5eZqNFFdnHhYwYAdlyFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udbT9xYp3uuwmcLcznbXN8bv2K70FloEvFP1cpFb3xN6uee9Tgu5x9Nhp1UQzi//VZJcBNihusn7X84e1MVDqXkKcjv/7Jvz700lxEdI1TCLlRqibOsIUmuCV4YiWIs6opNjvnpKGqtRQJSrpcsdWln3cNkWtBW7JAF9gN5cNgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=DSsEfRUH; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="DSsEfRUH"
ARC-Seal: i=1; a=rsa-sha256; t=1752204288; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hYbKNTAOUxsyFCGz8/Ob+RRFR/GkmB+HH9oBX+EIWldBUdfsjUL3U4RqG8X6EpHZqak5jyWCybZJD9soPg7IJ+K8dQqLLwhrStnZ9ercZU5A7VEwlabiAtV66dtNoMEKZTsKYYefOfoyvpvQIM5cSWoG871GgfiUPhCdskfwvgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752204288; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gi3LYrc1vcSogdA2lbiuXDmZmZes03z4ws13HmDuuEg=; 
	b=NeU480YsjM+O2AZOeu7u/KHQWu8wPwDnlu5iEfi0xcy6zOhKCDaHWFoORFOAf3ncKD6wB1xXrG1XNCFS0rIYcRtdAzuW8pjhrVbikZDjUmN+sN/wSgF6dUdryChtqs822z2eeNaSxkAGykqbqI3fqbSITBL+poNY8/8YEYi4IUg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752204288;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Gi3LYrc1vcSogdA2lbiuXDmZmZes03z4ws13HmDuuEg=;
	b=DSsEfRUHZbFXGGqBoiml6yleAhnPhJTjMO6eGDfz++3ent68bCUnK/LCK583Q65w
	gA4VchVtH7P5j5eDfMm2D5MabARC1d4AooXaBDma4WxVrvX1nS3NjUEe3qX67v4Ewmq
	XpElnIMH1h/2ky830PyjqBVnnhxxk8AkZenI2KPM=
Received: by mx.zohomail.com with SMTPS id 1752204286100544.9616229614193;
	Thu, 10 Jul 2025 20:24:46 -0700 (PDT)
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
Subject: [PATCH v6 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Date: Fri, 11 Jul 2025 11:23:56 +0800
Message-Id: <20250711032357.127355-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711032357.127355-1-ming.li@zohomail.com>
References: <20250711032357.127355-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112276e19b4fecd7fbedaf7c025210000f7acb665bc40cecb593781771c3619e9238656c56f4e4d769e:zu080112271ac7f47b191707d7eb89d08100004f731af18c4ec8eb92c950ceb8d92747bba30a80d723f93034:rf0801122dd64606021eb32289625f82540000ae884fbbf4bdad1321d43f5c1a17f6dbd6fa4aa51c10c036bf16ce2d5fa934:ZohoMail
X-ZohoMailClient: External

Per Table 8-143. "Get Partition Info Output Payload" in CXL r3.2 section
8.2.10.9.2.1 "Get Partition Info(Opcode 4100h)", DPA 0 is a valid
address of a CXL device. However, cxl_do_ppr() considers it as an
invalid address, so that user will get an -EINVAL when user calls the
sysfs interface of the edac driver to trigger a Post Package Repair(PPR)
operation for DPA 0 on a CXL device. The correct implementation should
be checking if the input DPA is in the DPA range of the CXL device.

Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 623aaa4439c4..991fa3e70522 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
 static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
 {
 	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+	if (val != EDAC_DO_MEM_REPAIR ||
+	    !cxl_resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa))
 		return -EINVAL;
 
 	return cxl_mem_perform_ppr(cxl_ppr_ctx);
-- 
2.34.1

