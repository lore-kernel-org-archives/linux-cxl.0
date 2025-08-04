Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E523BD13
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297570; cv=none; b=UatOVJNZkgU3Ym3rNcj6cuJwZw9PUsI3iPjfeUxi1+saHn5l6KhlSqTPcQE2ekHb/+6LUJGr7fORr3FK15qvlPTnXlZn/xrh3fSsCulwR4ukiPpzsMPRDrK2abQ1E7F7ZsLY1meiepguRAb5PFTKGCz1oLnJoTn++EEHunGgJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297570; c=relaxed/simple;
	bh=KwLOybSUfKz7V+q7BZsb/o22buu00wV0Rabk8eMVMxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8ME0KJl9REk7q3Z1emIcUNWns+lfQSvtl8k6rxqWKVzlcv66Jsjp9OCKYDeDRCnCYa8kuXhBASwPj1md2TwG2e+AEiq9OYg5uvaRFBUU14cBf4NN5XEgxyz4FFDigkWCWFStLjchxRDWUf9kRUO+uKU6GbDRSOda8PVPx25GDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxcY49zN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxcY49zN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754297570; x=1785833570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwLOybSUfKz7V+q7BZsb/o22buu00wV0Rabk8eMVMxQ=;
  b=XxcY49zNFQtpoSNio93a14RjUCNlJpnHFdxLrDQDH9SxJPVTf+4NlfUX
   1lYaos5NnY6Vf53Cr2zSFTFTNjw0VYGtxi551g35iXa3S7An/dO7h991u
   xWIYXg4nICSj7Mu1z3WPRU2+Kav+bgL571baJWU8EFvBgdVCbQSsx+MH1
   1LyXL7phzBh2zBeE0U2HX5U7isyzjkmK0b4WCFwu8TxqaaI2g2fH74eR0
   BlPCIY6BaKNCLeFi7SE3NIjifcPkxgp6VSMhP7T94WmPgw5+8xwAHs7/X
   2Swt+X5etblbGRbdvvmVe1ZiVos2mCUy1jO2R0+8YJ63jT6AY1vF2FG94
   w==;
X-CSE-ConnectionGUID: UszB/b7QRZGut9OyhjBsrQ==
X-CSE-MsgGUID: ljHkIE9kQcih8JmTmztV2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56442168"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56442168"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:52:49 -0700
X-CSE-ConnectionGUID: zaew2TKvTy2lg1fr00JCSA==
X-CSE-MsgGUID: L+1H2NEjRvSLrNMK5L0J6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164104241"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:52:48 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/acpi: Make the XOR calculations available for testing
Date: Mon,  4 Aug 2025 01:52:40 -0700
Message-ID: <e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1754291501.git.alison.schofield@intel.com>
References: <cover.1754291501.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

In preparation for adding a test module that can exercise the address
translation functions performed on XOR configured regions, the XOR
function needs to be refactored and the ability to create a CXIMS
provided.

Refactor the XOR function by extracting the core calculation into a
standalone function. Enhance the parameter validation since this new
function will be called from the test module where the parameters
may not be guaranteed valid.

To allow the test module to create a CXIMS without exposing the full
cxl_cxims_data structure, add new functions that can create and free
a CXIMS.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c   | 51 ++++++++++++++++++++++++++++++++++++++------
 include/linux/acpi.h |  7 ++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 547ed116a16f..86ca0466a95b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -22,6 +22,7 @@ struct cxl_cxims_data {
  * translation is based on the Host Bridge interleave ways of the CXL Window.
  * CXL Spec Secion 9.18.1.4 and Table 9-22.
  */
+static const int valid_hbiw[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
 static const int hbiw_to_nr_maps[] = {
 	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
 };
@@ -30,16 +31,47 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
+struct cxl_cxims_data *cxl_create_cxims_data(int nr_maps, u64 *xormaps)
 {
-	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
-	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	struct cxl_cxims_data *cximsd;
+
+	if (nr_maps <= 0 || !xormaps)
+		return NULL;
+
+	cximsd = kzalloc(struct_size(cximsd, xormaps, nr_maps), GFP_KERNEL);
+	if (!cximsd)
+		return NULL;
+
+	memcpy(cximsd->xormaps, xormaps, nr_maps * sizeof(*cximsd->xormaps));
+	cximsd->nr_maps = nr_maps;
+
+	return cximsd;
+}
+
+void cxl_free_cxims_data(struct cxl_cxims_data *cximsd)
+{
+	kfree(cximsd);
+}
+
+u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
+{
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
@@ -71,6 +103,13 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
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
index f102c0fe3431..854578c6009f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1616,4 +1616,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_CXL_ACPI)
+struct cxl_cxims_data;
+void cxl_free_cxims_data(struct cxl_cxims_data *cximsd);
+struct cxl_cxims_data *cxl_create_cxims_data(int nr_maps, u64 *xormaps);
+u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw);
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.37.3

