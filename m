Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AD151990
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297025; cv=none; b=YSlSl+j+IBm2QYXT1f/PsTn8HRGD7vU/oqsO2cu4b1FXmSgocldhLfylTHWqslt1NxCjsz5++EseAeqUmZvsWkjF1wYqJ04laNfiaFBhihfkTqTBA4byiwCWqLwZ5Sr+UzaeMT5IVuZF48qxdYK+WDZSoVGrNyEqZbHtn/wYbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297025; c=relaxed/simple;
	bh=8zIqhS+ziKzhYx3zOKy4DPge0BZMmo+oGM6KleL1R+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kfx2oeWVBSZl4mC0XKM/SpwfkFyqZONUtt+Kfq9NyIfgv9DOdgvyri4Xu2TiJolSi8gk+OpzUAN4BLOn12XSWrSyUsBXXc/Uo+ug/F7l6KdEyD7pCw+DCh0CmNVeltO8N3kSHZMMckQNws8ZILpgAPG8Szss8itLq+px3uexBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGwAGz7s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGwAGz7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741297023; x=1772833023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8zIqhS+ziKzhYx3zOKy4DPge0BZMmo+oGM6KleL1R+Y=;
  b=VGwAGz7slJfVhbmTa3dxBQ4HugaVoITBs2PdjAenkZ+3+gp/DJalPx7o
   C2+WGndtsXlR1KF1de6olH+NeIjVBzZZ/RRFdTftCc6an7VXxux4rNmDT
   xoaH7CElh05Z4M/FD7OyCmt+mnuwqb/ZpkaV9CLSvZzpNoJD+sutFtkcp
   G/LH4WKypSzt+dQ3OB9npfTqjeIM1aDhwxtjtdISOAXJKMxwggOFqT0Pw
   RDGwTkQGMD2DWtTBK7VrDAR4C4CjiFVc1FjXuAmaMh4t8cWFvgG4OzZUw
   JH0Zh5GWh6nL+GlCNJHWKfakF4zW1/zmG5Hd8ZBIi/WvOISBB/Tr1IKZr
   w==;
X-CSE-ConnectionGUID: nzkO3TfbS2W9rA9Lef19Lg==
X-CSE-MsgGUID: YlQgtRAQR4uuGVYtdndoLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42246978"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42246978"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:37:02 -0800
X-CSE-ConnectionGUID: xYjsT/rDQRugTZqOL0ZPwQ==
X-CSE-MsgGUID: 5l5rH5I0QBO842gpiu2VZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119146750"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.63])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:37:02 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2] cxl/region: Quiet some dev_warn()s in extended linear cache setup
Date: Thu,  6 Mar 2025 13:36:51 -0800
Message-ID: <20250306213700.2606304-1-alison.schofield@intel.com>
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

Remove the check and enusing dev_warn() when region resource size is
NULL. The endpoint decoders hpa_range used to create the resource is
checked in init_hdm_decoder(), so it cannot be NULL here.

For good measure, add the rc value to the dev_warn(). It will either
be the -ENOENT returned by HMAT if the mem target is not found, or
the -ENXIO from the region driver calculation.

Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

v2: Remove the resource size check entirely (Ming)


 drivers/cxl/core/region.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8537b6a9ca18..b3260d433ec7 100644
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
@@ -3305,14 +3302,14 @@ static int __construct_region(struct cxl_region *cxlr,
 				    dev_name(&cxlr->dev));
 
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

base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
-- 
2.37.3

