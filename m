Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE81C860B
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055765; cv=none; b=B5M2EoiVGPpL5lf22XBNpiG0pzSEkxWKGwoKLUU2Lx5EYADbl8r+fO7UrjQqX8z+RA4RMz/cP3als5hIdsjWHrIlXnmh7izOHIrpgmd6t+v2sb4ZIwX5thFQCLUECQ8jjQ0mrI7mQtU/8ULl4Murz5zhpsf/0uFkzy/WtLg1iaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055765; c=relaxed/simple;
	bh=xUYcoRBGjMYt89GIvRhmBo5XvTU34wCb0/Xu2zHxAcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8zvyvofQWjY61rp2O1Wr4JR2tGdVEGSKkdribCyFEE6oB7Oqa2QXUta8qdIfrvXwzkhuMLarmf/nn9JivYU1ud6bTbsa2FUNHdABQ/olaQJrON5RFPQwIV2uAApCnRZLAxLjayNytwgmPPQkfBJbobe/GhmD2AIbTLq1phWOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esCts5OV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esCts5OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755055764; x=1786591764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xUYcoRBGjMYt89GIvRhmBo5XvTU34wCb0/Xu2zHxAcg=;
  b=esCts5OVUpcv67H/BjzdW4r0XHnVmpNkLUjuWOh6w6uas2GrCe4XO5AV
   KhgUVNJjoR+VBLas9gjoiPZMFWoHOdaDCJ0eAS7amfipMcu/TdPpNOg5C
   50Ptt4GYOBpEAWs69hIzGJfEX7cCaSIg+wn5+JMJacQHtRPFB7V2aF//l
   vmbdRfF3TQN6TLEm9WIkoJzouOwMK0UU9cssdvqUi14hwR5IJJ2QKpczN
   HQwBKgCPF8Q8EpWjBzwWMh1kEzRAei8Skq1iTxUknvalEAe5jZDX2/kQQ
   mhosY3Yg2Y6ZNH/59+PuFiKYatDQ8mmgt9i1Rsxc/Qvd7n0z/bbYsP/ax
   Q==;
X-CSE-ConnectionGUID: 6nRPMu24Q5C0aQihCox+1w==
X-CSE-MsgGUID: vudsAgeSQWuMtCQRlMMZtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="79913687"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="79913687"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:29:23 -0700
X-CSE-ConnectionGUID: 5efcE6QERAekP1JJ9nCP3Q==
X-CSE-MsgGUID: yqVgR6NpRJOEv0aZ9PdrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="167150361"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.85])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:29:22 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/acpi: Limit XOR map application based on host bridge ways
Date: Tue, 12 Aug 2025 20:29:16 -0700
Message-ID: <20250813032918.2899852-1-alison.schofield@intel.com>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

Changes in v2:
- Use CXL_DECODER_MAX_INTERLEAVE in hbiw_to_nr_maps[] definition (Dan)
- Rebase onto latest cxl/next


 drivers/cxl/acpi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f1625212b08b..26c494704437 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -16,19 +16,31 @@ struct cxl_cxims_data {
 	u64 xormaps[] __counted_by(nr_maps);
 };
 
+/*
+ * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
+ * the same host bridge granularity share. The number of maps to apply at address
+ * translation is based on the Host Bridge interleave ways of the CXL Window.
+ * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
+ */
+#define HBIW_TO_NR_MAPS_SIZE (CXL_DECODER_MAX_INTERLEAVE + 1)
+
+static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
+	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
+};
+
 static const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
 static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 {
+	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
 	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
-	int hbiw = cxlrd->cxlsd.nr_targets;
 	u64 val;
 	int pos;
 
 	/* No xormaps for host bridge interleave ways of 1 or 3 */
-	if (hbiw == 1 || hbiw == 3)
+	if (!nr_maps_to_apply)
 		return addr;
 
 	/*
@@ -50,7 +62,7 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 	 * bits results in val==0, if odd the XOR result is val==1.
 	 */
 
-	for (int i = 0; i < cximsd->nr_maps; i++) {
+	for (int i = 0; i < nr_maps_to_apply; i++) {
 		if (!cximsd->xormaps[i])
 			continue;
 		pos = __ffs(cximsd->xormaps[i]);

base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1
-- 
2.37.3

