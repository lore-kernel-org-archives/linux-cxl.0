Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38B1BBBF9;
	Fri, 16 Aug 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817305; cv=none; b=G+vUky/NjIWU2nGsdLuogMMVG7PnMgOi1r27K4glecaWZIlOKD4xldZAHmDcFeNWbZghTHwrTSLLPyY1u6MkmE8ephzuyhwWpiY069RDnMYFJ44hJ2dmNWYq94nO9i13n3PUtEGw9Ly+wcfFQPt3W6VPre2nFfh4olgGdxBzVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817305; c=relaxed/simple;
	bh=pD8p/9S+sncOcesMU35Uc8/b65hfJ8KX+axALCm4SG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shEZHsG+NcNjHcAerXlKP5gptatewaCYVKkrb/euEEuRAgH8Fy1G13cT1J8qv0d5n9bl1BZPYja1OzvErFi3AMZjNIa4opJ0hS5Bd/Wtj7TVFnGkCc7Y5LukpENKhJrKHuNPVydiu7li8tPb+sV5znQN1TvSN5yBdASe5piBmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlpxbLXR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlpxbLXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817304; x=1755353304;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pD8p/9S+sncOcesMU35Uc8/b65hfJ8KX+axALCm4SG8=;
  b=VlpxbLXRLbXB03PQ46bjmym8WuzYNozUzMNOSTSzEYQhcpuhACCMZfxo
   B20Z9o3r+mR87q85cHqbbPXQkL7Zqy4Ljjh5qEI7yoJ8R23jKcSqjfQSX
   v3QQtBu5PSNnrsza1/IJObIZyQWG8BbT7gEDtTdqEQQz7vl5JbE7QC/Bk
   VPvlUlctcg1JNIK+OHg2oSIccC9pU0K+ypgzZIYqBXKTXawfauYeQwEQG
   lNOsfva7laFveJmARHyCm+PxY/5HWdjl/tN5BpkpK6tFouTlDMNEJA2s+
   UqUUwZz0Zb/U7VVI3XBtW3YD/1fEeup9eYN51xq+BTvBYOrie+kZK7aF+
   A==;
X-CSE-ConnectionGUID: EDLQjDNCQwWarOu8DLUe2g==
X-CSE-MsgGUID: xj2SPHIMRmKyin0/77JvQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260923"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:20 -0700
X-CSE-ConnectionGUID: dJONcCdDSQqRefI95j0KjA==
X-CSE-MsgGUID: jKYN4ndARgSxiXN6/OGC8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847797"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:19 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:09 -0500
Subject: [PATCH RESEND v2 04/18] cxl/region: Add Dynamic Capacity decoder
 and region modes
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-4-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=3161;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=pD8p/9S+sncOcesMU35Uc8/b65hfJ8KX+axALCm4SG8=;
 b=k99UO8CBm4r7xXRvJf1vUGE+t6KECYfpwweoONbxWxW8u6QydRXM57VyxlwGV5OyzUcpOQFG/
 Pmo+f5ocMtPA7qvhbNgWI8GahoqvOZh5QoZhLgTZNIqCTK/WFKZ/Aur
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Both regions and decoders will need a new mode to reflect the new type
of partition they are targeting on a device.  Regions reflect a dynamic
capacity type which may point to different Dynamic Capacity (DC)
Regions.  Decoder mode reflects a specific DC Region.

Define the new modes to use in subsequent patches and the helper
functions associated with them.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: split out from: Add dynamic capacity cxl region support.]
---
 drivers/cxl/core/region.c |  4 ++++
 drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 75041903b72c..69af1354bc5b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1772,6 +1772,8 @@ static bool cxl_modes_compatible(enum cxl_region_mode rmode,
 		return true;
 	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
 		return true;
+	if (rmode == CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
+		return true;
 
 	return false;
 }
@@ -2912,6 +2914,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
 		return CXL_REGION_PMEM;
 	case CXL_DECODER_DEAD:
 		return CXL_REGION_DEAD;
+	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
+		return CXL_REGION_DC;
 	case CXL_DECODER_MIXED:
 	default:
 		return CXL_REGION_MIXED;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ed282dcd5cf5..d41f3f14fbe3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -356,6 +356,14 @@ enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
+	CXL_DECODER_DC0,
+	CXL_DECODER_DC1,
+	CXL_DECODER_DC2,
+	CXL_DECODER_DC3,
+	CXL_DECODER_DC4,
+	CXL_DECODER_DC5,
+	CXL_DECODER_DC6,
+	CXL_DECODER_DC7,
 	CXL_DECODER_MIXED,
 	CXL_DECODER_DEAD,
 };
@@ -366,6 +374,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_NONE] = "none",
 		[CXL_DECODER_RAM] = "ram",
 		[CXL_DECODER_PMEM] = "pmem",
+		[CXL_DECODER_DC0] = "dc0",
+		[CXL_DECODER_DC1] = "dc1",
+		[CXL_DECODER_DC2] = "dc2",
+		[CXL_DECODER_DC3] = "dc3",
+		[CXL_DECODER_DC4] = "dc4",
+		[CXL_DECODER_DC5] = "dc5",
+		[CXL_DECODER_DC6] = "dc6",
+		[CXL_DECODER_DC7] = "dc7",
 		[CXL_DECODER_MIXED] = "mixed",
 	};
 
@@ -374,10 +390,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 	return "mixed";
 }
 
+static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
+{
+	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
+}
+
 enum cxl_region_mode {
 	CXL_REGION_NONE,
 	CXL_REGION_RAM,
 	CXL_REGION_PMEM,
+	CXL_REGION_DC,
 	CXL_REGION_MIXED,
 	CXL_REGION_DEAD,
 };
@@ -388,6 +410,7 @@ static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
 		[CXL_REGION_NONE] = "none",
 		[CXL_REGION_RAM] = "ram",
 		[CXL_REGION_PMEM] = "pmem",
+		[CXL_REGION_DC] = "dc",
 		[CXL_REGION_MIXED] = "mixed",
 	};
 

-- 
2.45.2

