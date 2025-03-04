Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDD79F5
	for <linux-cxl@vger.kernel.org>; Tue,  4 Mar 2025 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741062807; cv=none; b=f2usB+3/vlbBe7Blw9FyGrUVYML8eZpf4DJ0Ty+2RswmrOmQv28Vs7Fha+zc2YFNrG62U/4boXxqNHYdaXdiHdPECnAU0l/EB1YqBEHQdQhNq31Gx1TL3PsIR06LH4LEdbiIFVxO8siL5yeh0P6t0azwqgar8In8D0tMMC6sWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741062807; c=relaxed/simple;
	bh=TvXv9fhX6/0IuaAOw1+LyZux0HZUvTwLIQs7SaHscFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjJQN0AR+9DXF5TexQTlqStp6aHsLR8lvNNMGa+LL78X93cjSJqIf07VDpwgn5TySxdtJEPfBdRmTZlkt6/UmN1LfWH0tAkOLio3DqyxVLh97jxNK63YRCD/GoW1eM/6XielM7LveZi4jgis66DeN4rsRN4MnxUHV4r8BOl5TGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isxz9U8v; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isxz9U8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741062805; x=1772598805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TvXv9fhX6/0IuaAOw1+LyZux0HZUvTwLIQs7SaHscFo=;
  b=isxz9U8vqF05qlD69H+9JdnATPFKAiMBsqa/ssJX8gNeTg5p3JNizowH
   i8w7lxOkuMu4xwMamEKzDSq/m153vHdZBawW4JZwdbiu2+Ft/ln+bSR55
   jbhLWowvlxuuTkcCPjy6BlvT6ZUwjQGSc5KzdcJx0Tf21DZJDTH3dzxw6
   AD0NhoZB5pHFPuoev8Se+BC2U70SHgUVh/2d/7o/1YbWy5Au0mOyUuVo5
   samqfGlb1lk2MqBYaLPB63Pegie1TVRJ3YR5BeT1w2w2OuzOgKFomXPOI
   4cbPCOL4ujKpSz/EIMBoiBoK+NcwF08tjf/y56UWGuSJzGc6JDa5+YDc7
   A==;
X-CSE-ConnectionGUID: /Au6k1v5Td6EqDez6WMB2A==
X-CSE-MsgGUID: +OewWPIAQta8K2l74/d+gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44771478"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="44771478"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 20:33:24 -0800
X-CSE-ConnectionGUID: ezdMhkxORj63ATKWArxFFw==
X-CSE-MsgGUID: bBeMPdkwQzGRKu2+s1nBiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118774197"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 20:33:24 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Quiet some dev_warn()s in extended linear cache setup
Date: Mon,  3 Mar 2025 20:33:12 -0800
Message-ID: <20250304043315.2502110-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Extended Linear Cache (ELC) setup code emits a dev_warn(), "Extended
linear cache calculation failed." for issues found while setting up
the ELC.

For platforms without CONFIG_ACPI_HMAT, every auto region setup will
emit the warning because the default !ACPI_HMAT return value is
EOPNOTSUPP. Suppress it by skipping the warn for EOPNOTSUPP. Change
the EOPNOTSUPP in the actual ELC failure path to ENXIO.

In a much less likely path, the dev_warn() is emitted if the size of
the region resource is NULL. Move that size check out of the ELC setup
code since NULL resource size is unrelated to the ELC setup and should
cause an immediate failure to construct the auto region.

For good measure, add the rc value to the dev_warn(). It will either
be the -ENOENT returned by HMAT if the mem target is not found, or
the -ENXIO from the region driver calculation.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8537b6a9ca18..2d2d2f221902 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3235,13 +3235,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
 	int nid = phys_to_target_node(res->start);
-	resource_size_t size, cache_size, start;
+	resource_size_t size = resource_size(res);
+	resource_size_t cache_size, start;
 	int rc;
 
-	size = resource_size(res);
-	if (!size)
-		return -EINVAL;
-
 	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
 	if (rc)
 		return rc;
@@ -3253,7 +3250,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 		dev_warn(&cxlr->dev,
 			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
 			 &cache_size, &size);
-		return -EOPNOTSUPP;
+		return -ENXIO;
 	}
 
 	/*
@@ -3304,15 +3301,18 @@ static int __construct_region(struct cxl_region *cxlr,
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
 
+	if (!resource_size(res))
+		return -EINVAL;
+
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
-	if (rc) {
+	if (rc && rc != -EOPNOTSUPP) {
 		/*
 		 * Failing to support extended linear cache region resize does not
 		 * prevent the region from functioning. Only causes cxl list showing
 		 * incorrect region size.
 		 */
 		dev_warn(cxlmd->dev.parent,
-			 "Extended linear cache calculation failed.\n");
+			 "Extended linear cache calculation failed rc:%d\n", rc);
 	}
 
 	rc = insert_resource(cxlrd->res, res);

base-commit: 26600bf10173beda5358d194ec425a1cfafa2fe2
-- 
2.37.3

