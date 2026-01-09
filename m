Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70631204583
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988193; cv=none; b=sgNKNcp2rjMvNq/cHaefmoh1QuSVvK6ondn9CPb30WIlBAxWk1ggJNLocJf973eT1+mP5Ql6oR+4SNfUQxHCKAn/zimpF2JCoKtDzwkqmEzBOpDAo0OCRYDnXJLd+Knbrfve8YCMMI88uNFfK7qq+/wTfssCNgczDLAAXU9amTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988193; c=relaxed/simple;
	bh=uwP2nj5H37beGNxV8IGuoZbA00RjPmdeHsnTQ38hYSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+lqNBXjoq3hG0HAXx6zVG0GmCZ1rL6hc2Bc5DVDJCbpcohAM6VXQ8EA8iS8yDnnf5OPEjsMtNzNNHBAtTTofue9ws3NiEHz+8WH+vDI52m21xr47PK5NYZ9OuwOHLrrkr4ycBpn/MJjPPGQAphxbB44IL2cqv68BpSKFwhEQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTMQEIlc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTMQEIlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767988192; x=1799524192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uwP2nj5H37beGNxV8IGuoZbA00RjPmdeHsnTQ38hYSE=;
  b=WTMQEIlccIAbxz64axANRogKjmwLrlXH2rubYo0LqB/0kESVhW5Qi6e+
   rbhDC2fMejOuEqSbINWG2f3hgyit+nqt8fFlwkZ3rVr/ap3WbV7xti2Fj
   uw3guWCqBWXLgG/SLetSNucoCvWhtstc/FTBvfJDBX/y7qUx10TiG4vYC
   WfnY4H97vtUixVXLnqAkvAxGm3FqPB4QQGGh2GJnpZjv2hdt2JxxSpei0
   rs4l7q4r9aaA/2nrk0oFKffB5GLNKzSVlTO/Pyst1oxmF2dh1DkKStyhv
   kLANHbieLzhv+BMB66Oyg5eRBi5hTmaEdGXAV5zRm8IWvS+bM1DQk+4M4
   g==;
X-CSE-ConnectionGUID: /1gr+4U6RZWAvEQQF0EdVg==
X-CSE-MsgGUID: Rm+C1AZ+Sj6FIj3nMRDJ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69419977"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69419977"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:49:51 -0800
X-CSE-ConnectionGUID: r1bc06m1TKWvErZMB23zSw==
X-CSE-MsgGUID: l7jVR8OvSnizkdAOhlHb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203167140"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.121])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:49:50 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/acpi: Restore HBIW check before dereferencing platform_data
Date: Fri,  9 Jan 2026 11:49:44 -0800
Message-ID: <20260109194946.431083-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4fe516d2ad1a ("cxl/acpi: Make the XOR calculations available
for testing") split xormap handling code to create a reusable helper
function but inadvertently dropped the check of HBIW values before
dereferencing cxlrd->platform_data. When HBIW is 1 or 3, no xormaps
are needed and platform_data may be NULL, leading to a potential NULL
pointer dereference.

Affects platform configs using XOR Arithmetic with HBIWs of 1 or 3,
when performing DPA->HPA address translation for CXL events. Those
events would be any of poison ops, general media, or dram.

Restore the early return check for HBIW values of 1 and 3 before
dereferencing platform_data.

Fixes: 4fe516d2ad1a ("cxl/acpi: Make the XOR calculations available for testing")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This bug was introduced in 6.19-rc1 and found while rebasing this
work: cxl/region: Translate DPA->HPA in unaligned MOD3 regions.
Adding coverage for this to cxl-test suite is on my todo list.

 drivers/cxl/acpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 77ac940e3013..49bba2b9a3c4 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -75,9 +75,16 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_do_xormap_calc, "cxl_translate");
 
 static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
 {
-	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int hbiw = cxlrd->cxlsd.nr_targets;
+	struct cxl_cxims_data *cximsd;
 
-	return cxl_do_xormap_calc(cximsd, addr, cxlrd->cxlsd.nr_targets);
+	/* No xormaps for host bridge interleave ways of 1 or 3 */
+	if (hbiw == 1 || hbiw == 3)
+		return addr;
+
+	cximsd = cxlrd->platform_data;
+
+	return cxl_do_xormap_calc(cximsd, addr, hbiw);
 }
 
 struct cxl_cxims_context {

base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.37.3

