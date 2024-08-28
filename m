Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8E15ECDF
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835017; cv=none; b=LghWrKTHYOYQV/+c4G8y0LQL+X+zE6Kwn/YZx/RZhxQbNACaBv35JOPT3UkGVCx0CUMEydB191ddUgnOeb4OBdSABgSTNjJTr5NnfIU3aDGFPmH00r5mHKgqcnPFESZSzUz1myreLoAYZdhm91N4OQwCgHGz6B79bfaBfyTsNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835017; c=relaxed/simple;
	bh=FyWxiWn0CsNsynvJoAaJPwfJyM4demAlzCWNG/a+21Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cfa5L4Qv2R2kDKzXmDg27N1TNQLgYcCG5/Jbz06dTjZAgT3Bn2Yjaa1TFSTtOT/wbGBIhyNAZcZ6A2x8/ikmKjdLCJ0Ry2hzxAnjum18kwT/lH1KS7StngH0FnygsRBWcr7WIkWKJ4+vmegB+o5JvS/XUYuHglZI9bt/akrWHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nd96Fyie; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nd96Fyie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724835016; x=1756371016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FyWxiWn0CsNsynvJoAaJPwfJyM4demAlzCWNG/a+21Q=;
  b=nd96FyieWY+mUN4N/XmgVLCb50IfF7kmyR2Mi8PdSv8DyBRpyj+EwFLw
   pawcf/QD/VjwJxcWwvxTH9zhgQnqgPpx1HjveWgHesY6ZEIleM+CQum8i
   xiYJCPLMvpr3/LhIjxeyT4AttmJi0hJ162ujaAJWGI3g5rnWKWvCF3wZO
   +73yy3cOfC+K3xDVrskG2XY4eyVJaBrz6DLj9mPIL4E96Hwnm0vaYzYET
   ZGjkYQtCqvo8LmzJkntcVvoIhXd2xcPBux//85uxds7b6SVTiouc/d+JC
   gNsjpWhxUMO+OAgCCarWYkUKiicP8JZpganHCerKA2BFhPOGDvA9/79pj
   A==;
X-CSE-ConnectionGUID: ZExlWzX7QuOlu3o1YGOhwg==
X-CSE-MsgGUID: QUrenFLSQBO4d1/UjxhWUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22874621"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22874621"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:16 -0700
X-CSE-ConnectionGUID: yG5npigPTD+1TbrN8mWjVA==
X-CSE-MsgGUID: UW4cIURLSGibgHYQ3oGf7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62998986"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:08 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v4 1/4] cxl/pci: Fix to record only non-zero ranges
Date: Wed, 28 Aug 2024 16:42:28 +0800
Message-Id: <20240828084231.1378789-2-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828084231.1378789-1-yanfei.xu@intel.com>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function cxl_dvsec_rr_decode() retrieves and records DVSEC ranges
into info->dvsec_range[], regardless of whether it is non-zero range,
and the variable info->ranges indicates the number of non-zero ranges.
However, in cxl_hdm_decode_init(), the validation for
info->dvsec_range[] occurs in a for loop that iterates based on
info->ranges. It may result in zero range to be validated but non-zero
range not be validated, in turn, the number of allowed ranges is to be
0. Address it by only record non-zero ranges.

This fix is not urgent as it requires a configuration that zeroes out
the first dvsec range while populating the second. This has not been
observed, but it is theoretically possible. If this gets picked up for
-stable, no harm done, but there is no urgency to backport.

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..73b6498d5e5c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
 		if (!size) {
-			info->dvsec_range[i] = (struct range) {
-				.start = 0,
-				.end = CXL_RESOURCE_NONE,
-			};
 			continue;
 		}
 
@@ -411,12 +407,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[i] = (struct range) {
+		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
 			.end = base + size - 1
 		};
-
-		ranges++;
 	}
 
 	info->ranges = ranges;
-- 
2.39.2

