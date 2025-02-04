Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861372010F5
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643049; cv=none; b=ooFDL05CrNGvilCb1jBw6unK8PVSvhlNk1TGz3O7w+Ewp+puaGv3zlVt67mgMzzyXI6An2IJlnLdLvhjcAOAuJaTako5SGbRw5cSMCCUrpWstqcKcHJ0Rsv7kEuLm2JRTGgSAZd+WD+ehW6iufniL1ei91M78dJTcOYUNbfWaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643049; c=relaxed/simple;
	bh=LV3D6U5cH9dpnLt6qUwMiu7B6V1D2IwjtO9MSghMUyQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bu+ul+d7FdtQFn+pPiISQFR9mrdGJorv0c/8VsOdM0jgz3as88RafLw5pTayqgUiqmpyfUdhggAAfA/Y31EoPP3vclB0iCjRDfUZcMaKS5eCiHFXjiBFewWfPqffybUTOEwNBjtYPNtkXsKkYOc/c3gRzMvOnB6jmeKW9byU2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lr3Bxlvh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lr3Bxlvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738643048; x=1770179048;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LV3D6U5cH9dpnLt6qUwMiu7B6V1D2IwjtO9MSghMUyQ=;
  b=Lr3BxlvhCsMQf1G8BIO1VfgcHJboeR7UeUK3meKUVKtYxnolKKOb7Pzi
   W0Z56LSJjpR0XZU9vCTa1fReH+Ilabo0ju7GKrS1A5BxwRvKJhDo0qCRX
   avrntdOvJgGtZ1qKa6f4ibkGpspz31f83j5Uzpv2AoX5UiunpOaQLbnpI
   Xmk/1RdonoLngDJCD9t0D4kiOSIYMQlKSmlNxtE1mJtjQeOs09kC8mb86
   12pVjKpF9imuaB+4IbzN6Eystturu5rQcuOwBBDFH3r47FH7f1ghv937j
   DysAXwyMWDcspPdDlhpAeaFRVn93vz3ZVVZqlpXY8ipAmcZ/JieS0KPLM
   A==;
X-CSE-ConnectionGUID: pUPT86fzTnC7TfPOFY94Xw==
X-CSE-MsgGUID: eq7sc5drRymZ+iHSjvemTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39058638"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="39058638"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:08 -0800
X-CSE-ConnectionGUID: e5AFZ1ONQQyioa2Bb+4R9Q==
X-CSE-MsgGUID: Z6Qw2ChmTb6YGJ563IM7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114520381"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.230])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:07 -0800
Subject: [PATCH v3 1/6] cxl: Remove the CXL_DECODER_MIXED mistake
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alejandro Lucero <alucerop@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 dave.jiang@intel.com, Jonathan.Cameron@huawei.com
Date: Mon, 03 Feb 2025 20:24:06 -0800
Message-ID: <173864304660.668823.17000888505587850279.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

CXL_DECODER_MIXED is a safety mechanism introduced for the case where
platform firmware has programmed an endpoint decoder that straddles a
DPA partition boundary. While the kernel is careful to only allocate DPA
capacity within a single partition there is no guarantee that platform
firmware, or anything that touched the device before the current kernel,
gets that right.

However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
designation because of the way it tracks partition boundaries. A
request_resource() that spans ->ram_res and ->pmem_res fails with the
following signature:

    __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation

CXL_DECODER_MIXED is dead defensive programming after the driver has
already given up on the device. It has never offered any protection in
practice, just delete it.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |   12 ------------
 drivers/cxl/cxl.h         |    4 +---
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 50e6a45b30ba..b7f6a2d69f78 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -332,9 +332,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	else if (resource_contains(&cxlds->ram_res, res))
 		cxled->mode = CXL_DECODER_RAM;
 	else {
-		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
-			 port->id, cxled->cxld.id, cxled->dpa_res);
-		cxled->mode = CXL_DECODER_MIXED;
+		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
+			 port->id, cxled->cxld.id, res);
+		cxled->mode = CXL_DECODER_NONE;
 	}
 
 	port->hdm_end++;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8d11a988fd9..34aa3d45fafa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2738,18 +2738,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return rc;
 
-	/*
-	 * Regions are only created with single mode decoders: pmem or ram.
-	 * Linux does not support mixed mode decoders. This means that
-	 * reading poison per endpoint decoder adheres to the requirement
-	 * that poison reads of pmem and ram must be separated.
-	 * CXL 3.0 Spec 8.2.9.8.4.1
-	 */
-	if (cxled->mode == CXL_DECODER_MIXED) {
-		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
-		return rc;
-	}
-
 	cxlmd = cxled_to_memdev(cxled);
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bbbaa0d0a670..9fd1524ed150 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -380,7 +380,6 @@ enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
-	CXL_DECODER_MIXED,
 	CXL_DECODER_DEAD,
 };
 
@@ -390,10 +389,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_NONE] = "none",
 		[CXL_DECODER_RAM] = "ram",
 		[CXL_DECODER_PMEM] = "pmem",
-		[CXL_DECODER_MIXED] = "mixed",
 	};
 
-	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
+	if (mode >= CXL_DECODER_NONE && mode < CXL_DECODER_DEAD)
 		return names[mode];
 	return "mixed";
 }

