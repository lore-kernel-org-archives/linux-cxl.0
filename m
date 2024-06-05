Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60B60B96
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553974; cv=none; b=Ildd0KQqjHCC5fiIC0+KrrGpa0bgI98a8rA6/rOObFMKrhs33YFPwEFMG1Kr8/Y3X4vN3LLT4i7jd/A6I+FV1kqdknkTXYfh+eS/fRhxmWxS4TRsbmW1IGfZZaj2XkLlChhGdOLogU0FpSuUpiNFH73LLGwQQrd85PfOqIisz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553974; c=relaxed/simple;
	bh=bONh61V2sN8XnD6K3N0e5vPgHOmrHTl7EKP5hfEJW/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=smhnXSrBiPb/7d6O8VsTpWxncDanIIoBWBCaoeo73LrvjcSuQ8DMvUa4zrwYYPesD3eZjsu9AzypRlvtPXTb/84w5HfUg3mFpcFSViqfWP4kAU61J9vcVXlfvXrWm41/AT+EEERkZy3EAWHUrdF1yPcSaJKGlsgN+jLuC92Zg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2tDVVcE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2tDVVcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717553973; x=1749089973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bONh61V2sN8XnD6K3N0e5vPgHOmrHTl7EKP5hfEJW/c=;
  b=a2tDVVcEypu8zhIgDC5oA+NJj4Mn/W2heRaYK4SdVSYyOnm0kYAysCMs
   NOuCROJHw5cYJWbrxbRWOwH5Ll7RYP5y8DvnG46df7dUteniPR0djID2H
   s62sebk140zX5nh6OFA5cdnmLgI2Q42mPb7Q7kTxcGTvEXf0UCv1t8rzI
   jqEKOZhI8YPFY+LVoGgIO78sM5+7hnkub9g3RSzpTq7sqRwePGXFfaXg8
   sFsP2h5eYsHz9B8I2+4ZEMQzZbtE/v+xcyIriGRpseY7xHGvNEcjE3Lvt
   e6X0RAfcxV6ke24XJrKn5J5sdaE2Glsj03VqJjLPJ4Awh/sQpdP/FYZaO
   A==;
X-CSE-ConnectionGUID: R4gm1Xi/RxiPJ0sENgEe6g==
X-CSE-MsgGUID: t9Zc5/DPR3+FSYolBMI3Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13977770"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13977770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:19:33 -0700
X-CSE-ConnectionGUID: P27w7vHzQFe13fQXFl7Alw==
X-CSE-MsgGUID: JdmePViqSYWlTyMo76VKIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37432741"
Received: from gjayashe-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.148.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:19:31 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] cxl/region: Fix null pointer dereference in region lookup
Date: Tue,  4 Jun 2024 19:19:28 -0700
Message-Id: <20240605021928.223287-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

cxl_dpa_to_region() looks up a region based on a memdev and DPA.
It wrongly assumes an endpoint found mapping the DPA is also of
a fully assembled region. When not true it leads to a null pointer
dereference looking up the region name.

BUG: kernel NULL pointer dereference, address: 0000000000000050
RIP: 0010:__cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
Call Trace:
 <TASK>
 ? show_regs+0x5f/0x70
 ? __die+0x1f/0x70
 ? page_fault_oops+0x14b/0x430
 ? __cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
 ? search_exception_tables+0x5b/0x60
 ? fixup_exception+0x22/0x300
 ? kernelmode_fixup_or_oops.constprop.0+0x5a/0x70
 ? __bad_area_nosemaphore+0x166/0x230
 ? up_read+0x43/0x90
 ? bad_area_nosemaphore+0x11/0x20
 ? do_user_addr_fault+0x2cb/0x6b0
 ? find_held_lock+0x31/0x90
 ? exc_page_fault+0x6e/0x220
 ? asm_exc_page_fault+0x27/0x30
 ? __cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
 ? __cxl_dpa_to_region+0x35/0xc0 [cxl_core]
 ? __pfx___cxl_dpa_to_region+0x10/0x10 [cxl_core]
 device_for_each_child+0x4a/0x70
 cxl_dpa_to_region+0x61/0x70 [cxl_core]
 cxl_inject_poison+0xde/0x1e0 [cxl_core]
 cxl_debugfs_poison_inject+0x9/0x10 [cxl_mem]

This appears during testing of region lookup after a failure to
assemble a BIOS defined region or if the lookup raced with the
assembly of the BIOS defined region.

Failure to clean up BIOS defined regions that fail assembly is an
issue in itself and a fix to that problem will alleviate some of
the impact. It will not alleviate the race condition so let's harden
this path.

The behavior change is that the kernel oops due to a null pointer
dereference is replaced with a dev_dbg() message noting that an
endpoint was mapped.

Additional comments are added so that future users of this function
can more clearly understand what it provides.

Fixes: 0a105ab28a4d ("cxl/memdev: Warn of poison inject or clear to a mapped region")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Changes in v2:
- emit endpoint dev_dbg() message only, rm cxlr-ness (Dan)
- rm redundant null cxled check (Dan)
- add stack trace to commit log (Dan)
- s/Avoid/Fix in commit msg (Dan)
- add Reviewed-by Tag (Jonathan)

 drivers/cxl/core/region.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..d9819650c529 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2700,9 +2700,13 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
 		return 0;
 
-	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
-		dev_name(&cxled->cxld.region->dev));
-
+	/*
+	 * Stop the region search (return 1) when an endpoint mapping is
+	 * found. The region may not be fully constructed so offering
+	 * the cxlr in the context structure is not guaranteed.
+	 */
+	dev_dbg(dev, "dpa:0x%llx mapped in endpoint:%s\n", dpa,
+		dev_name(dev));
 	ctx->cxlr = cxled->cxld.region;
 
 	return 1;

base-commit: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1
-- 
2.37.3

