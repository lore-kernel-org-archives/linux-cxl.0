Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7611F76C7
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536359; cv=none; b=Lqdl8hqSlMQ1znoHXjh55B7tFaAQXBu3j/rUW8k2x/pk8NW8ycpMN0WRErmniEsEYUK3Qbn9oM/8fEZZaHdJJ5rbncOHa8cqDl421/XPejPNFkC0yVhn4RouQRZvLjDiB84HNu2Tb6eXDx4HO5UydoZ0kyRxW+y+eLN/NvDJZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536359; c=relaxed/simple;
	bh=nVetSTq65LpgKFmFl2kYCrEjxN13S8JJLdSvNph7Dh8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rarcZjqe7aTDSzpNe9ivDRPxweaeeYKjDO1jOSBdkdJoe/Q8H7OhFH7hvBCSfjygzgT4fmDc9d0NiJ01dLjsuVN+dvc8kUdKUPwifgcf2bxTZUhNtkcDnuaYp55K3BTo3++YQg1nBI+AhMXn9fp9y5B91vYLsPjmqK7zswYNnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACZFjc+t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACZFjc+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737536358; x=1769072358;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nVetSTq65LpgKFmFl2kYCrEjxN13S8JJLdSvNph7Dh8=;
  b=ACZFjc+t+pHJ0HkvevpY0kSZDCQ0Ir2n6L3fk6DSNybKx+G4yRmfU6uz
   DsgpP8zbU/DNVo7K6T+90j4Cz6N/ZwliAi30p3lw5ff/n+QnWsCo59Fk0
   /3VFfP2J/Ai3vuw9Pivx2B9Sc3/qHNYM0NbXa/1gFbNSbbiZIuNbD/f6J
   8ArL6PIifW+8LvPaXZaxHIf7VyJ3oOK5ChO3ZKFlU1yT9iPzz9GzCPtaE
   rwgjNx2m8LPGZdRfJScXdoQoIiVRQ/jGakFSnJHVweVvs4c1GKAw3ThCY
   JetN07Tijd92Ep3EyTPUAQzfmunxw6SDQxvzZsOTG9PAxb1HWwk2pVr2T
   A==;
X-CSE-ConnectionGUID: apZ+/qL+Ssm4DoNr0opk1g==
X-CSE-MsgGUID: xWIg9xm/T8KtFkTzEG5yMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55395958"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="55395958"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:59:17 -0800
X-CSE-ConnectionGUID: QWGoQPu5T7uPtlubgAs2NQ==
X-CSE-MsgGUID: TuZ8yYAvTWObnEzAC+Hh0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130378048"
Received: from ldmartin-desk2.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.77])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:59:16 -0800
Subject: [PATCH v2 1/5] cxl: Remove the CXL_DECODER_MIXED mistake
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, Jonathan.Cameron@huawei.com
Date: Wed, 22 Jan 2025 00:59:16 -0800
Message-ID: <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c    |    6 +++---
 drivers/cxl/core/region.c |   12 ------------
 drivers/cxl/cxl.h         |    4 +---
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28edd5822486..2848d6991d45 100644
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
index d77899650798..e4885acac853 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2725,18 +2725,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
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
index f6015f24ad38..4d0550367042 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -379,7 +379,6 @@ enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
-	CXL_DECODER_MIXED,
 	CXL_DECODER_DEAD,
 };
 
@@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
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

