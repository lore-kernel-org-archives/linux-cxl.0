Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A6230BE1;
	Thu, 10 Jul 2025 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130733; cv=pass; b=fDKWxnVxrf3WIVWfN7DAslO9KZlltaLy/AKCVpvZUIBa9Y6gVNvCms0g24sR1gh91+5c5+SoO+6ZkEqU/T/HS9k2h1+TBByq3/JKB87hwYrWkILoD/tsDYpjxxEwTFiJu0FGfpPwR5OumUmZ4rej0b0IOzV61sjgNa8E5De2Zko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130733; c=relaxed/simple;
	bh=4XMXysEmEuVGM+mUyPzHOOIoo/2Q3NS+t8WdzC/Fj0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KF4ClLr9aFXS6p38jbu/csXAOik61/sMowfyRowzhprH1G4tYXDvdNJRmNQ16L8QDEMJrd+f0cGLC8x07OGt1LLT6UT/vHRcitLLpepFkjGAqfzrc6Aga3cttL3W1qGUnMWwPyWv3OpPVCHwwveBMgTMczrL7uK+jG27x9J2Yq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZYQIpjlB; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZYQIpjlB"
ARC-Seal: i=1; a=rsa-sha256; t=1752130706; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FTHSwF+VcSpyUFw4j9CONtIG0JbTpFWYg9jVoGyM1yqx1cvF6Di9sdhxYcRomg6g/fuyJndJnzQ+6y0XTYK5kD/wjf4hihEDrPtqh1VTD5xOjLGQGxA8vNLiMfzZbwg59ylRm8GZDwA7LCnUrE7TMadBndd/BVk+udcULd6cQoA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752130706; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KPlyZ/Hsh71e/mLVELA5lQX3qhvKokj1xWNXCL/wX1Y=; 
	b=FyHed2QKIz4L3mw6QZjUHCgYDqqOtgafVE01gL0Vd5i8vAaaQzyBPqpiGlPoeKFWYV1FpVLztxGO68dPv7nyVHODzHR13Et5McU82d21AaeDbZAl8Td9ThvSkq2sBFH0de83r7F+POgD7uBVo8VgKvQ0B5CBn3xj6I2adWDkgw4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752130706;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=KPlyZ/Hsh71e/mLVELA5lQX3qhvKokj1xWNXCL/wX1Y=;
	b=ZYQIpjlBVlRhveAgqoGArzID/TNzGD+Y5mIfBlM056rkZH7s7DK8UpO2J5qe1Mb5
	He24VGPYEHzxLZBEA5OvMrNKrnn72Wykbx6/eTCip0hWyD5mCM8/IpfLx8wY3P0zkpV
	71YGkQrof169lAkQafeZ6glQRhJgUp8DDpUJm/Ss=
Received: by mx.zohomail.com with SMTPS id 1752130704133315.203139531022;
	Wed, 9 Jul 2025 23:58:24 -0700 (PDT)
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
Subject: [PATCH v4 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Date: Thu, 10 Jul 2025 14:56:46 +0800
Message-Id: <20250710065647.98094-3-ming.li@zohomail.com>
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
Feedback-ID: rr08011227c03f971dc3abfab7622a121d00009cc378dcd480c5d0418a5c82d9b38f77e20dfe96cbfc733c2b:zu08011227281d5e23887b44d5b80b695500001dfabd5b4d553b1fae532af0e589ed48a811236b8cf46198a8:rf0801122d27ad8ba4f213ba85727ed733000001f738e71875145b2d91f04ae7f88bd881a517f336ac546ae9655170e4ae25:ZohoMail
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
index 623aaa4439c4..90151cc7fe52 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
 static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
 {
 	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
+	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
+	if (!cxl_resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
+	    val != EDAC_DO_MEM_REPAIR)
 		return -EINVAL;
 
 	return cxl_mem_perform_ppr(cxl_ppr_ctx);
-- 
2.34.1

