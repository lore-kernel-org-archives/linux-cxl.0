Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD430F94B
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430284; cv=none; b=iif/Z4n6WZeLS/DNSAmZjA9yDCUG6zM2TssGNPmNhJ46gZNVeH5QbzQmlwly0xaWpyQc4TKT9qbDKxlnxEPOFqsLiWFFM8VHkba5jNZnT9UxlN9y4KLNVue4VIuZv7+q/bM5a+aTdDLOzNmIiUoAIKzCwNJM2PQBN6igUcZJnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430284; c=relaxed/simple;
	bh=09dUHAM6xmtF0HO0cGILLevshiEpI9l2M0bCkowES0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMEnEVRElV7lHJCjd/MnQMFevB7PowP4oKw64uEY1e8H8wa0d/loHVFWlBhbSGuDy4CzenT/zaHEV8vxxFNpXLiBJdNTxef4LCg2mja3GHYbcCrshkObSdYr+VSTyxRHOs2wBOmQEM7EOXjG2Gbw8WURFj/ju1qLLijbipttbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdoziW2r; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdoziW2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760430283; x=1791966283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09dUHAM6xmtF0HO0cGILLevshiEpI9l2M0bCkowES0U=;
  b=hdoziW2rxHwGvusDe7b5m6m3RAP0cyXweUGZDB26FW2+2bPjGYq/0Fft
   ZXFeAwH8StWOzb364ZqHT3IR3WZTHPTgQbWdv2gLKvKAnBspC85q2e5lS
   iQGa4dn9DOMVu7SiGqwES3dAIzYOppVQkTAMsZBZTcWFMdZOuBmrEc7Xt
   77j118uc1ifilC18dSee77Yf+h6RpCksCCPjIEWNCMmnQh6ZNSe1yISXW
   87h6Bje6p3ckh6752wxj3k3AcVMvCMZwXs1EOqAFjDOt+LRSHPsS5hb0J
   mJsFHNc5l0BZCaoPAqGtNQxXE1G8oIXoIWRHu6j39pKdiBLBCWpzO6+Rg
   A==;
X-CSE-ConnectionGUID: N/n+9GUSQF2CkAoUSSzTKQ==
X-CSE-MsgGUID: mnrzoQ7iSTmmgMEoa8ue0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62619317"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62619317"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:24:42 -0700
X-CSE-ConnectionGUID: 3D6D2JWPQwK1xaOrLFeZ7w==
X-CSE-MsgGUID: h6+XuLR4S4yv9n0bOdmabw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="218966100"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:24:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 2/3] cxl/acpi: Make the XOR calculations available for testing
Date: Tue, 14 Oct 2025 01:24:31 -0700
Message-ID: <bbea529ae0d0eda929fcc2ad245ec614ca7bf087.1760429439.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1760429439.git.alison.schofield@intel.com>
References: <cover.1760429439.git.alison.schofield@intel.com>
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
- Export the new function for use by test module cxl_translate only,
- Enhance the parameter validation since this new function will be
  called from a test module with no guarantee of valid parameters,
- Move the define of struct cxl_cxims_data to cxl.h so the test module
  can build xormaps.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c | 41 ++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h  | 13 +++++++++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d7a5539d07d4..770014f3115c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,25 +11,36 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
-struct cxl_cxims_data {
-	int nr_maps;
-	u64 xormaps[] __counted_by(nr_maps);
-};
-
 static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
+#define HBIW_TO_NR_MAPS_SIZE (CXL_DECODER_MAX_INTERLEAVE + 1)
+static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
+	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
+};
+
+static const int valid_hbiw[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
+
+u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
 {
-	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
-	int hbiw = cxlrd->cxlsd.nr_targets;
+	int nr_maps_to_apply = -1;
 	u64 val;
 	int pos;
 
-	/* No xormaps for host bridge interleave ways of 1 or 3 */
-	if (hbiw == 1 || hbiw == 3)
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
@@ -60,6 +71,14 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 
 	return addr;
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_do_xormap_calc, "cxl_translate");
+
+static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+
+	return cxl_do_xormap_calc(cximsd, addr, cxlrd->cxlsd.nr_targets);
+}
 
 struct cxl_cxims_context {
 	struct device *dev;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 10bee9aaa943..e8931b626fc6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -743,6 +743,19 @@ int cxl_validate_translation_params(u8 eiw, u16 eig, int pos);
 u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
 u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig);
 int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig);
+struct cxl_cxims_data {
+	int nr_maps;
+	u64 xormaps[] __counted_by(nr_maps);
+};
+
+#if IS_ENABLED(CONFIG_CXL_ACPI)
+u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw);
+#else
+static inline u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
+{
+	return ULLONG_MAX;
+}
+#endif
 
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
-- 
2.37.3

