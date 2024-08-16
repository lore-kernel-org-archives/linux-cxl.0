Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E71BC09F;
	Fri, 16 Aug 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817300; cv=none; b=ELFWPNROre3EFusLsLsVGyou/k84e4eUh8HHSMnZav2nlggbZIJBI286TOPWPqp8L2BEwYy/Xmz/W8H4OL3Aa7t82b0kYecPN9CT/M+JpE2PPBOMJZ3YfMew1+TIzWPcIO5uRx9dYo00Aa7Eg0EQa10Nj9lqiKISa4y9W4mDH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817300; c=relaxed/simple;
	bh=RjlLUaj7o1Ekf7+NkDPCFuIDq4h3i49rOee7IMQvwS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcN7hTrAUjMrM+AQ8eu5wuWjRo8q56c/Mbw+FSFwYwS+EdZVGMtNVZi/dgcRmOOxGz36KkzxAk6r0PtLharGW5KBLTP2CzcP95tUOuCMMsrfn/gV5AbHSpQ16wZvhsDef8FhrDTBzkeGzTy+hL7W1iAArcUa4egWizxMiJqhru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XL3lh2aF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XL3lh2aF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817300; x=1755353300;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RjlLUaj7o1Ekf7+NkDPCFuIDq4h3i49rOee7IMQvwS4=;
  b=XL3lh2aFz5cJP22FgStlvcotguShfjVC31JxQMrUPbEO4Bh/Owqhk9J8
   mkios40tpjnyx4V52E7r1vG9Ew8qlrQzLz3A78iQ8S3IccD1z2QigL/tq
   z+/OzYNeahuyzBpuEIhJefXWaZLWJhb5tF7Ex3KexD+KSv6o8EkXuA1cC
   G8KPnDFfs5VfFZcrkSPppE49ofK2Ms6GtWRnWFF5zAF1od1T0CHwxsWhW
   D9x6dDrI32Nfc7q+6WoB6gEsBdsDVexiuTLbjZofgPNTx2+BoOZRwjjl+
   7Ibamdc0Iwx+TyHAZq+eDhAEWkqHCl66HaQviyaWFn6jJniSEKy/CqKVj
   g==;
X-CSE-ConnectionGUID: b2N+KiTdRxC4K/okFRBviQ==
X-CSE-MsgGUID: j+6pHEDFSRqKxewPDThGQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260877"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260877"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:14 -0700
X-CSE-ConnectionGUID: 9mQLGiCBQWuZHgjuotTugQ==
X-CSE-MsgGUID: GQ1Rc6l7SXuBLYYVNI1Plw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847763"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:13 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:06 -0500
Subject: [PATCH RESEND v2 01/18] cxl/hdm: Debug, use decoder name function
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-1-b4044aadf2bd@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=875;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=RjlLUaj7o1Ekf7+NkDPCFuIDq4h3i49rOee7IMQvwS4=;
 b=li2Ej/7R8NQoJSN9yvuCULPks0LlOkKOQpVFmfrqSfQRGWM9lkN9pYoLik/0f2oC0gOQsf5hV
 N15OklMeak+C8RzIa+bLzn6B4pa43i8B0dMkADdEEPO8JNCrt30afSB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The decoder enum has a name conversion function defined now.

Use that instead of open coding.

Suggested-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: new patch, split out]
---
 drivers/cxl/core/hdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b01a77b67511..a254f79dd4e8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -550,8 +550,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
-			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
-			&avail);
+			cxl_decoder_mode_name(cxled->mode), &avail);
 		rc = -ENOSPC;
 		goto out;
 	}

-- 
2.45.2

