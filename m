Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC9256C89
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452116; cv=none; b=dq+mgdLftF3e9uZo3tdmWO95uvAe8OvHVE6CRfLZc1BprF1Ly2hg+1/uHPQ8W2cf84dCxVfA/0ecfQJCN6AFUNuV2FyA3y+T3qlfcI+vJkk4DmgMqO7bXYZBPdLTr0el0SYvRcgvTgPUxFaLQjU54EtXkLf+Zcn/inUBcqoq2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452116; c=relaxed/simple;
	bh=TFmTtxCqdWzDekfryFt6ARhWs7i9axkCHlJOI/dm6Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKU2u8G5RVldeFcLhSKF0Clinp1Idq9ahXjsrIcFMi0sQhvY2x5sCdCB7pztqKhUcMHNZstyYzGrix+UWHTwI8JdfR7y1D8rFO1huxrN2kZGnnKj1vEp8MIEee3rDME5pJjBGCittU/+Crxt4f4mx1nmynEEG1/SwQodCPL8HQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWLZl2f3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWLZl2f3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756452115; x=1787988115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFmTtxCqdWzDekfryFt6ARhWs7i9axkCHlJOI/dm6Oc=;
  b=ZWLZl2f3LT3ywE383v5vgKd5yRkwGU/hxYytu/2VlEmWT+4TkP+O1ZSL
   kYUNgVQsA2CBD3x35nJnc77h4WmDnM5PdRFhWkdo7RN+YmKYs70JLvNkZ
   UcbzyVF8PFcNkFIgEhnbrSgwA/RNh+cuiDx3jDqq0AXaPSEli46WgIxZF
   h9pSjLrp2ILHHoHyVosTvv3GJ5KxZdu5hnb0Cx+H8jRM4v2yIYsSM8nyB
   f7Fql6/FRKuJSvChg4b+naBy4sdKMAVEKnTWk7l6IzI7MtDc9jUSJDb7W
   /Ny5KMvrXSavaBPBkDu5mQNnYq2AlkUNBM0KIQpHiiK1WlQKXZMzvIMQr
   Q==;
X-CSE-ConnectionGUID: vZXAUWUISPO1MDxcldeLxA==
X-CSE-MsgGUID: 5u6K/FxjQ6GXWcdGyqacsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58585008"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58585008"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:55 -0700
X-CSE-ConnectionGUID: 66xeTAIUR7K+OtB1LV0q9A==
X-CSE-MsgGUID: Ifp/g40ITLCeKfKfxOi4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175613124"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/3] cxl/acpi: Make the XOR calculations available for testing
Date: Fri, 29 Aug 2025 00:21:26 -0700
Message-ID: <1474b223f2b50da36f36f07820a8708fcbb8441a.1756446925.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1756446925.git.alison.schofield@intel.com>
References: <cover.1756446925.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding a test module that can exercise the address
translation functions performed by the CXL Driver, refactor the XOR
implementation like this:

- Extract the core calculation into a standalone helper function,
- Mark the new helper function as __mock_export to make it available
  to test modules while keeping it otherwise static,
- Enhance the parameter validation since this new function will be
  called from a test module with no guarantee of valid rameters.
- Move the define of struct cxl_cxims_data to include/linux/acpi.h
  so the test module can build and pass xormap data.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/cxl/acpi.c   | 35 ++++++++++++++++++++++++-----------
 include/linux/acpi.h |  7 +++++++
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 26c494704437..f924058dbd4c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,11 +11,6 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
-struct cxl_cxims_data {
-	int nr_maps;
-	u64 xormaps[] __counted_by(nr_maps);
-};
-
 /*
  * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
  * the same host bridge granularity share. The number of maps to apply at address
@@ -28,20 +23,31 @@ static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
 	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
 };
 
+static const int valid_hbiw[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
+
 static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
+__mock_export u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
 {
-	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
-	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int nr_maps_to_apply = -1;
 	u64 val;
 	int pos;
 
-	/* No xormaps for host bridge interleave ways of 1 or 3 */
-	if (!nr_maps_to_apply)
-		return addr;
+	/*
+	 * Strictly validate hbiw since this function is used for testing and
+	 * that nullifies any expectation of trusted parameters from the CXL
+	 * Region Driver.
+	 */
+	for (int i = 0; i < ARRAY_SIZE(valid_hbiw); i++) {
+		if (valid_hbiw[i] == hbiw) {
+			nr_maps_to_apply = hbiw_to_nr_maps[hbiw];
+			break;
+		}
+	}
+	if (nr_maps_to_apply == -1 || nr_maps_to_apply > cximsd->nr_maps)
+		return ULLONG_MAX;
 
 	/*
 	 * In regions using XOR interleave arithmetic the CXL HPA may not
@@ -73,6 +79,13 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 	return addr;
 }
 
+static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+
+	return cxl_do_xormap_calc(cximsd, addr, cxlrd->cxlsd.nr_targets);
+}
+
 struct cxl_cxims_context {
 	struct device *dev;
 	struct cxl_root_decoder *cxlrd;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1c5bb1e887cd..78e639a529c2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1616,4 +1616,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_CXL_ACPI)
+struct cxl_cxims_data {
+	int nr_maps;
+	u64 xormaps[] __counted_by(nr_maps);
+};
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.37.3

