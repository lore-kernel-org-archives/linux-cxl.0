Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724D18024;
	Tue,  8 Jul 2025 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951819; cv=pass; b=ely/yAnlQi1cFC2xhnOG4sIs2QCn6AkMTGa4jXkD1Pm13RUwmMcjr8kB4t1vWeHeoPQITytSshuoBRvQnRkEjlaBMpnG1m/V9EISOxdajVoj7ZZlif0YrhL4hiul9UboNgJbKF+5D6ybTziISkr0eKQtXfPZUar31sk1GpB+I6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951819; c=relaxed/simple;
	bh=2ZDuUNShW95ip2f8OVmtVr11lDCch/9BcgH4WefD5XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SL5ijmpZsBjpKlIJzKZyIxfIwTAMGavHBvaKxGIavtw8etXkQZvoFUPJj4JzeIsUba6ygsWPfR67KU4R3wKTWWoKtOeXDdaPZY7ttuOWMbPaJGA5N7UP1hMRkYUV3ggq0bXE2dGG8Bxb+6GjUgAFRGXX8BoJQrWwP0sr5GDnsqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=dQQ5cPLn; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="dQQ5cPLn"
ARC-Seal: i=1; a=rsa-sha256; t=1751951787; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RvOBVS+ErrIQmqldb6S22S7BK1sDPtbb7aHoFcsbeDqWAJ3MOSa+SMdvjDSJ60mzl6AdUo2IkUZA5eKi/wJpDrSn9Daut+LNDf68HR+jbNv1mWg6hSOhBb08EyNpwDn1Y7DGpJrQ114p3t58nxhgFIMfb8lW0cfUf1cUM8DOqZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751951787; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gGSpLzSd92rRESKOsK2LDU70JTySnKIzYyf8+LC4oQs=; 
	b=hguXxtvJqP/Hms67kGV8VgKx3U3saPrCGPBM0VeZFKdZ3qP/kRDzY0IzOjDtrIJue8iBxUDCTVb508PyAY2+Nb8hMG84XKeV0nB2EoYSqw7J5cQ2X4U/RcDtH8uGz3hADkHQElSmXDhrbD6L7kv38RiId3l57lkcf0Klvi/Z2I8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751951787;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=gGSpLzSd92rRESKOsK2LDU70JTySnKIzYyf8+LC4oQs=;
	b=dQQ5cPLnc8z96Y92an1j+xB3LikjMfXexgx+7oXwdwwcZ9PwlqfhU9Z17cHTU2xF
	yok9NuNf+6tA5fFTxDLp8dedgIsl22ib8Ya7cR3h4hG/voK1fkFEsXyDALLSh3uqGM9
	tFv7uACDKR+gJY6Myxq5Dz7E9zEx/Nvy2kBli1Yw=
Received: by mx.zohomail.com with SMTPS id 1751951785615142.2979915281103;
	Mon, 7 Jul 2025 22:16:25 -0700 (PDT)
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
Subject: [PATCH v3 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Date: Tue,  8 Jul 2025 13:15:35 +0800
Message-Id: <20250708051536.92119-3-ming.li@zohomail.com>
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
Feedback-ID: rr08011227796a996157c9ee9b930be8bf0000fe19a3fcf7a8e254979770caba7678b0e87c6daf2e8a4a179f:zu08011227422916f8c3623d2dd111aa1800008cc4e4604a2dfce80d8b16898719ff9639a007b4b462eeb1bb:rf0801122da5c25905f8dca23101a7b5da0000cc540126a326f38887e353cc2e3e7c73dad3d07cb53515761cd5f21640eeea:ZohoMail
X-ZohoMailClient: External

DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
of a CXL device. So the correct implementation should be checking if the
DPA is in the DPA range of the CXL device rather than checking if the
DPA is equal to 0.

Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 623aaa4439c4..1cf65b1538b9 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
 static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
 {
 	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
+	    val != EDAC_DO_MEM_REPAIR)
 		return -EINVAL;
 
 	return cxl_mem_perform_ppr(cxl_ppr_ctx);
-- 
2.34.1

