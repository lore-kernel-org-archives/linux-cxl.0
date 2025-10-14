Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781DA2D94AF
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427077; cv=none; b=hx4Fx/v+yQ/iNgA9ASa2ehNuMklTdslOauLVpNdWwb4vkiu44Gl+9ZvukpJTsrhs4Fmm6Z29Rx4kz6j3AegAphuNh8LNzMTI1u9V7YV9vf84Lm9hX6SatcqHE8eYflZQIOk1k7pFOlDLJyk197Sx5wo5rabPDMtYprOqPGZQzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427077; c=relaxed/simple;
	bh=hPl0e4BiEWwxXjS2RkwtuwOtxColiecQakAbjWQHhpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wk4RUQXdQwVSjp/l2e2uSLCRhtEKFsZ1lAXVscztqpWkb4eCJcKGTJ98+X4E5b+8a38YGocP6oyx43zNxpEUqG0HvLuhoOw2DRFLf9y5BPHEHcRNyvP8vj5uqj6U7IQ+eaoSazqiCnAUUoZkkmpjH5YuSOyBQGIOokcNt6axmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/qgPKlK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/qgPKlK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760427073; x=1791963073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hPl0e4BiEWwxXjS2RkwtuwOtxColiecQakAbjWQHhpQ=;
  b=a/qgPKlKdd/OJV2KNTezUOkDNgv30hr1Ac5/LoyVPYYUZ8c50SmHuLlM
   hqeeNAW3ax5648lqaslPCWzr6xpfvLoKnNtnQP3GO8P9462opBTxarPXJ
   X2TwLvOVHzE3N6BqKlDQFZhEPPuTIcVwDLzsriNA9+y0XkKiHvV7bT/Th
   +/76u2Lz7MxAzngiXB6suHgxr2e6qre/0LxtQV469x/z52y2mCKlsH7nE
   HBLpi53PRdHE2iclwgZSTWu+fozkZGi1Wtz7REhMDkWpicjJs255ihLEg
   Rcd2uvEJ2IcU9GWoh13/3luvw35dZ7vouMogjnSO2y48czpHseSY1hXSx
   w==;
X-CSE-ConnectionGUID: DzdgM5xYRo2NIAYQoPJOSQ==
X-CSE-MsgGUID: 6YxBdL4yR86aD+M5aEgUvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62474459"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62474459"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:31:10 -0700
X-CSE-ConnectionGUID: 71OdAGSiQvqjoHHPmPrJHA==
X-CSE-MsgGUID: Ac5X6bwwQYGWBgxlImCN1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="180964996"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.105])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:31:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Use %pa printk format to emit resource_size_t
Date: Tue, 14 Oct 2025 00:31:04 -0700
Message-ID: <20251014073106.730952-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reports a stack-out-of-bounds access in validate_region_offset()
while running the cxl-poison.sh unit test because the printk format
specifier, %pr format, is not a match for the resource_size_t type of
the variables. %pr expects struct resource pointers and attempts to
dereference the structure fields, reading beyond the bounds of the
stack variables.

Since these messages emit  an 'A exceeds B' type of message, keep
the resource_size_t's and use the %pa specifier to be architecture
safe.

BUG: KASAN: stack-out-of-bounds in resource_string.isra.0+0xe9a/0x1690
[] Read of size 8 at addr ffff88800a7afb40 by task bash/1397
...
[] The buggy address belongs to stack of task bash/1397
[]  and is located at offset 56 in frame:
[]  validate_region_offset+0x0/0x1c0 [cxl_core]

Fixes: c3dd67681c70 ("cxl/region: Add inject and clear poison by region offset")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e14c1d305b22..4e567f7e06bc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3666,14 +3666,14 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
 
 	if (offset < p->cache_size) {
 		dev_err(&cxlr->dev,
-			"Offset %#llx is within extended linear cache %pr\n",
+			"Offset %#llx is within extended linear cache %pa\n",
 			offset, &p->cache_size);
 		return -EINVAL;
 	}
 
 	region_size = resource_size(p->res);
 	if (offset >= region_size) {
-		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pr\n",
+		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pa\n",
 			offset, &region_size);
 		return -EINVAL;
 	}

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.37.3

