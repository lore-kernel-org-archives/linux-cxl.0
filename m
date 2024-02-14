Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0711701
	for <linux-cxl@vger.kernel.org>; Wed, 14 Feb 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894823; cv=none; b=GeB/ZMFlkHmrbHM24vt0aDQOXNRgqdA/4QpMKmNTbHEg1WsNCc464pyHd5ygLKKPETjHBeKnFL4GBbtlJtr2pqq+8THdzjoWxr/83HYyGGeO0j3bx1rKF6CNy1TnURYbiz59i/LHQS0ec47vta1uvYd5zEyNzKDZauCWj0o0vc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894823; c=relaxed/simple;
	bh=ZAKO34AN8eReMancRB/YsupJCwFLdiUnHS90THUFqcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzFoLvb4Z02nPMfnPpRRh5mx+wtVqB28GUxLWQ/94te6BHBrKoVBF34butIO2X5/6TKl5PV03mUGO5G7CYF7voWML55Yn051hRlog5blWKGnF75JWkf7RbivrZn6w2QYXqdzH/cy+TSMDcA351TZ88wNsZEbHb4LkbmXGr0N4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf82nxsL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf82nxsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707894821; x=1739430821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZAKO34AN8eReMancRB/YsupJCwFLdiUnHS90THUFqcI=;
  b=Jf82nxsLWisk8d5J+WlmN94aNsrU9jzUeJ7Svl68i7xuK+uscDamWQ48
   4y9QFMt+SSL5p38DtOe7SXF8cd0eT0H47tVFORf/xH796UwhPnh03TH3H
   hwuLRyBD1DOmDrERhXohmv98y/JyOslBUkWlzLwVAzOu7F++zp8xO8dHn
   o7C1lgj+gEa6s8k9WyEebId/HG57ogQQd3eeDg1qrgWUD0/P7XnWnwOkK
   80IEf3yW+ENKqeWMaN13GqOgZ727NJLbvokgyoq7tUmRb/GDZYx3UFvGr
   I6ZZ/xI6Fg7lUHyCdDEAN5wDDBGVwFWfZVH6eiPxQClgXeqRlLO8ap3cY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27374445"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="27374445"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7758534"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.66.223])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:13:40 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl/acpi: Fix XOR 3-6-12 way host bridge look-up calculation
Date: Tue, 13 Feb 2024 23:13:35 -0800
Message-Id: <0eebc96f0e36ebc74b0dc0f4112b70cced6907a7.1707891715.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707891715.git.alison.schofield@intel.com>
References: <cover.1707891715.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The XOR host bridge look-up function is broken in its application
of the modulo calculation for interleaves that are multiples of 3.

The failure appears like this:
[] cxl_core:cxl_region_attach_position:1433: cxl region4: mem0:decoder8.1 invalid target position for decoder3.2

Replace the broken modulo calc with the same modulo calc as used
for Modulo Math. This is per CXL spec definition but was overlooked
in the original over-complicated implementation.

With the simple modulo calculation, the jump to a helper function
becomes needless and the work is now presented in a straight line.

Display the interleave_arithmetic in the dev_dbg() of successfully
setup root decoders to make debug lookup easier.

Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/acpi.c | 51 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dcf2b39e1048..86c735f733ea 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -22,31 +22,6 @@ static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
-/*
- * Find a targets entry (n) in the host bridge interleave list.
- * CXL Specification 3.0 Table 9-22
- */
-static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
-			  int ig)
-{
-	int i = 0, n = 0;
-	u8 eiw;
-
-	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
-	if (iw != 3) {
-		for (i = 0; i < cximsd->nr_maps; i++)
-			n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
-	}
-	/* IW: 3,6,12 add a modulo calculation to 'n' */
-	if (!is_power_of_2(iw)) {
-		if (ways_to_eiw(iw, &eiw))
-			return -1;
-		hpa &= GENMASK_ULL(51, eiw + ig);
-		n |= do_div(hpa, 3) << i;
-	}
-	return n;
-}
-
 static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 {
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
@@ -62,11 +37,28 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 			  "misconfigured root decoder\n"))
 		return NULL;
 
+	/*
+	 * Find a targets entry in the host bridge interleave
+	 * list as defined in CXL Specification 3.0 Table 9-22
+	 *
+	 * iw: 1 is no interleave, so entry is 0
+	 * iw: 3 uses a modulo calc only
+	 * iw: 2,4,6,8,12,16 use xormaps
+	 * iw: 6,12 apply a modulo calc after xormaps
+	 */
+
+	if (iw == 1)
+		return cxlrd->cxlsd.target[0];
+
+	if (iw == 3)
+		return cxlrd->cxlsd.target[pos % iw];
+
 	hpa = cxlrd->res->start + pos * ig;
+	for (int i = 0; i < cximsd->nr_maps; i++)
+		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
 
-	/* Entry (n) is 0 for no interleave (iw == 1) */
-	if (iw != 1)
-		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
+	if (iw == 6 || iw == 12)
+		n |= pos % iw;
 
 	if (n < 0)
 		return NULL;
@@ -424,8 +416,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		dev_err(dev, "Failed to add decode range: %pr", res);
 		return rc;
 	}
-	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
+	dev_dbg(dev, "add: %s math: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
+		cfmws->interleave_arithmetic ? "xor" : "modulo",
 		phys_to_target_node(cxld->hpa_range.start),
 		cxld->hpa_range.start, cxld->hpa_range.end);
 
-- 
2.37.3

