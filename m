Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80D2309B9
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295842; cv=none; b=FyfICKYycEZRqqSnvB19BaSQXaed32S4XufXovqPKA3s7MF+3zcCvbHNhY/8E7klqqOGuDNlyMNwWldTzfiLWi/MVBgqzoCpihhhN5rIQUxG3VqUxQtzzjNbCE1iW+YkFcPp1CloNEV1A1Sc5+PtUNJ+dKoYkxfgx7kuVfhP0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295842; c=relaxed/simple;
	bh=cgG0P5BOvzaVr0lO0bMtlngSgwQnoxS6Lbksi/AxlfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUd3sQ1Vcg+L0eEtt2KEK/EN8bfUhFNcjJpX4wkKj1o49IcJSgEW39SyReCisZCBhz/F9Y01SLXkxQzuEPEEpbd5PwXXtfY5FXK5aEgkn4fTXsFbV2llIxNh2NN93LkeN4h3e/NYIgbtFayS4EKdJ06fsprxx9rCPIBX/Ax21u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODpNaHyK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODpNaHyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754295841; x=1785831841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cgG0P5BOvzaVr0lO0bMtlngSgwQnoxS6Lbksi/AxlfI=;
  b=ODpNaHyKQNyPZ6W17YiSua/3EELE2YBiI7j8b1+S/ua8xJe762dm84bs
   ErPvso+YSZXc3FEA/ETI/sEaTELoyUvs+aucBNn46Um8FolMgoMr5K24F
   xV2d+tjEbzmvcsCtjbxV6+5kmkGawekDVTtrAaZFG6ZK5SsLT/V62r6tS
   7AEn4rPniRJnB9a/UAD3Bm71LRP+I+6sKx6szeO5vt6FY1doI2IUtGcCx
   CcRNNjPzKxvDtwV6thckS2r78L2YhjqJaF5coiSg/Uj2OUXg0HbFTOS7B
   WKKEvc13rR3UOwuRh742Jl1uxbQAOmUEe2Lg8/NG0JKcPVY77LDzMfwkA
   w==;
X-CSE-ConnectionGUID: DFGbLzFPSOSYhGJLpfvriQ==
X-CSE-MsgGUID: /7OyI4+QRJqN1sHj9kAQIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="67243883"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67243883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:24:00 -0700
X-CSE-ConnectionGUID: CvPnfBGfTeCcCfIQIcsYGA==
X-CSE-MsgGUID: 4KTzf7cvQYCexS9FSMh+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="195031045"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:24:00 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/acpi: Limit XOR map application based on host bridge ways
Date: Mon,  4 Aug 2025 01:23:55 -0700
Message-ID: <20250804082357.2590809-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL specification defines one set of XOR maps per Host Bridge
Interleave Granularity (HBIG), but the number of maps to apply
depends on the Host Bridge Interleave Ways (HBIW) for each region.

Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
XOR maps regardless of the region's host bridge interleave ways.
This causes incorrect address translations when multiple CXL regions
with the same HBIG but different HBIW's coexist.

Example scenario with 3 XOR maps defined for 256-byte granularity:
- 4-way interleave region:  should apply 2 maps (was applying 3)
- 8-way interleave region:  should apply 3 maps (correct)
- 12-way interleave region: should apply 2 maps (was applying 3)

Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
a lookup table to determine the correct number of XOR maps based
on host bridge interleave ways.

Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 712624cba2b6..5154effb0cb2 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -16,6 +16,16 @@ struct cxl_cxims_data {
 	u64 xormaps[] __counted_by(nr_maps);
 };
 
+/*
+ * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
+ * the same host bridge granularity share. The number of maps to apply at address
+ * translation is based on the Host Bridge interleave ways of the CXL Window.
+ * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
+ */
+static const int hbiw_to_nr_maps[] = {
+	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
+};
+
 static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
@@ -23,13 +33,13 @@ static const guid_t acpi_cxl_qtg_id_guid =
 
 static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 {
+	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
-	int hbiw = cxlrd->cxlsd.nr_targets;
 	u64 val;
 	int pos;
 
 	/* No xormaps for host bridge interleave ways of 1 or 3 */
-	if (hbiw == 1 || hbiw == 3)
+	if (!nr_maps_to_apply)
 		return hpa;
 
 	/*
@@ -47,7 +57,7 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
 	 * bits results in val==0, if odd the XOR result is val==1.
 	 */
 
-	for (int i = 0; i < cximsd->nr_maps; i++) {
+	for (int i = 0; i < nr_maps_to_apply; i++) {
 		if (!cximsd->xormaps[i])
 			continue;
 		pos = __ffs(cximsd->xormaps[i]);

base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
-- 
2.37.3

