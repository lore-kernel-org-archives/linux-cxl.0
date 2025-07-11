Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF477155393;
	Fri, 11 Jul 2025 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203521; cv=pass; b=oNmP0PlJcq2hqIWynxiTHc5yA9qHRTXfKQnqErCQnXp76YQ9SoPcNxqlwz0Ch+7Wh6f/uk3wLQIF9nXbqNe5cnVQPvVsQbjUBaxMG2mm7Xl+/9thweEMDl0CM599gZ0lgEB9oYMWfOaBbAYEpUznRZK0KajCVRxVDLHMnjl7fQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203521; c=relaxed/simple;
	bh=hPdyobvwyLBaF4atMNDrLur5eZqNFFdnHhYwYAdlyFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g33a0zz0Qbn5Od21ezDhaKr82ysMYHKuv7jmtUdyWLUTsSzc92cQwjPMCdHDZCa9TYQekLPdtxyK5Bh7UJabAYP4JOqRHnHm9PQOJhurUnqRfcrT3IZtb/uej/ic2Speue3wbFGJXxsO0i8y+IzvVoQnjOAsuWD0tm3oMpvtMos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=M6Syettg; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="M6Syettg"
ARC-Seal: i=1; a=rsa-sha256; t=1752203503; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NV0Am9sb+Z3c9R3b7wAyjP7kVD9CIDrs5EzWAkSLgj/eHzq/Ztk6jWnC5UCnfwH0TOehwmdTvaRMG4YBjjILNDUpeQcQ9xa80ipjWCHcjP2kpHbp62HIl328TQ50bWY3f6JfWwa8p72OrGUVQj893I4+sJ4WYhI/W1GBJcqtimY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752203503; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gi3LYrc1vcSogdA2lbiuXDmZmZes03z4ws13HmDuuEg=; 
	b=QWHJMXbFKZQQ7UFzOFS7pIDf8DzN1VAT0jN7Tv+m3dVkB8fGDWkjHuneEsXaSOFIfRA3RJBVT2RusesksmA8CzQUcM6Cys5IwRiiS/9bovS0874FEROj924LaAN2qOYQO53BeIgO09DQyW6eJgdmvXgZCsnx56HEsrjMYKYmdqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752203503;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Gi3LYrc1vcSogdA2lbiuXDmZmZes03z4ws13HmDuuEg=;
	b=M6SyettgAJ6p5PqQL6OC3qNcbrB2UHZl8a+TL2t0A0b8O49M9YXNT/BbGTnTIVAt
	gbmbFVaqnl4M9AsFrKHJF/RIwvc1EkMVtWUAfsB3Cumaa63PSAX4A1IH5sNt6ugLwav
	fHvP26zlVMx/aQqMri//OHSD7p3ojmDsY3F9ph4Y=
Received: by mx.zohomail.com with SMTPS id 1752203501942287.89873825472705;
	Thu, 10 Jul 2025 20:11:41 -0700 (PDT)
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
Subject: [PATCH v5 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Date: Fri, 11 Jul 2025 11:11:00 +0800
Message-Id: <20250711031101.126990-3-ming.li@zohomail.com>
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
Feedback-ID: rr080112273de6a288ce429918b69dc73a0000760a69ef95c09ed4b548cedad459d9915361338b31fcf1e7b1:zu08011227f8203482e8bb4f855bafc7e900002435d1e897763e0846429cb9eb5c8fdcee19dcf4d3100c8556:rf0801122d0a0869ee84cca01e316964fb00004fb8bba42228e33e6df6805a29cfad23cfa1bf58c4d5662962825d453d45ac:ZohoMail
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

