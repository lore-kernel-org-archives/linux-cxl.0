Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43E1FC3
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477938; cv=none; b=G8rVQm25Zas0Kg6yFvkMRedu4pvkyLw4C+2U2lUZ2e539dRA8TCleBPRCkFic/dRK1Dl15iG+CfDuNHqFrbo3g0eeWIG/ERjwjkjqKdK2CwW5dRWJCONe84NC8g9cj6yYbhiY3SxhIWWWyBjeEAVBX7btCLH3d6/ZAxG5U8fTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477938; c=relaxed/simple;
	bh=0fEqVHIVkxDq5Z98KOCRE2wu3H4/KqYrIXzb/atQCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3J2bdy9nwW2Ysjr6VJnAZM9dvLyuSD19cbGYzf4oydsmLELznjOWeNSgsv0ydD4gGXjTrP+5AW50/jWmsZMRVD8taDwfG62IHEnTLk2xeVuJeuWrVqKJBAiexR5IVN0J+4jodxvnb+ularHgGKFTaxS+0S6Uw2D/PWlN+D4rJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KH8+RpS1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KH8+RpS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760477937; x=1792013937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0fEqVHIVkxDq5Z98KOCRE2wu3H4/KqYrIXzb/atQCw4=;
  b=KH8+RpS16TlSh+k+hXGkgUxXTGC3SAdPqOkiaJmhsTTUafWzntl5nZJn
   LDIUuwTybO+h1kvSO90QxhgMzQwqxSHHMrls9m06UPrEcTDTW794e0Io9
   5wF223McfQhZmFYkIleMAxDKapc9hbmdrS4nYaKbqL5PkBlwRmObeio03
   swrSWkE5YzU1qoo5iY9e2r51o3LEdQxJRK6VOiGbUw/D7+zpoTQS+I+R/
   h7U+Icv+HnJ/rgExpmmK29UVVj/LJajfLfwnNQr7TNt9eNE8JiEvaNZrA
   OTiUPdGPnq5sVjIrE3H8euNuJXvw8gFm7788Vpctk/dr4nXuHbI+CX33x
   A==;
X-CSE-ConnectionGUID: 8l8iCMx6SiG43jNbEN2qag==
X-CSE-MsgGUID: qtsBOxKtQAexqfxRLHCYZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62689133"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62689133"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:38:56 -0700
X-CSE-ConnectionGUID: bRs6HDMCTN60Jr3xla8IHA==
X-CSE-MsgGUID: pcdtB4C1SX+EZmmzBg10WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="182775301"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.188])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:38:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/trace: Subtract to find an hpa_alias0 in cxl_poison events
Date: Tue, 14 Oct 2025 14:38:49 -0700
Message-ID: <20251014213852.748018-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traces of cxl_poison events include an hpa_alias0 field if the poison
address is in a region configured with an ELC, Extended Linear Cache.

Since the ELC always comes first in the region, the calculation needs
to subtract the ELC size from the calculated HPA address.

Fixes: 8c520c5f1e76 ("cxl: Add extended linear cache address alias emission for cxl events")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a53ec4798b12..a972e4ef1936 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -1068,7 +1068,7 @@ TRACE_EVENT(cxl_poison,
 			__entry->hpa = cxl_dpa_to_hpa(cxlr, cxlmd,
 						      __entry->dpa);
 			if (__entry->hpa != ULLONG_MAX && cxlr->params.cache_size)
-				__entry->hpa_alias0 = __entry->hpa +
+				__entry->hpa_alias0 = __entry->hpa -
 						      cxlr->params.cache_size;
 			else
 				__entry->hpa_alias0 = ULLONG_MAX;

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.37.3

