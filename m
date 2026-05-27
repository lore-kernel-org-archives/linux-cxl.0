Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E775809
	for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840802; cv=none; b=DsHtqwlcbT/DMht7A9nHM6fWkfKSTenaKb2cIeMKEPEc6u9I8HyKx/BsMLB6b8pl7EtkZbcfTHFNmPl1AokBwWHHjcPZwtGiM63oGY1ILukEZxpxagKDyED8ImE0MvwkfXG34uUcn3eaaArxfP4OXSjupaKJOK851cgw4UGkotA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840802; c=relaxed/simple;
	bh=VcGIvlb2Adx+fX2LRdOuWvBCAKMRVG8xLl2m4ldfMxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=La/XpD8NUCj0CMU5fBnbjzS5Qb7CcC1814mSZs7PQprI1DSRz25kiUYTRI5l1e+Wi/Dflwa4osr+rgvXpKV/7nkF69XK+ijtxqLZgZz/hPC5+p1CAys3QOwZ4cPxhIWy33HMv7se5vErsHq4L/q5Ae8bJNqwqGluuQAjhfZ8plE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODLcArcm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODLcArcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779840796; x=1811376796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VcGIvlb2Adx+fX2LRdOuWvBCAKMRVG8xLl2m4ldfMxE=;
  b=ODLcArcmh4unL9WZ7gex3CT2XlTbu8KX+I9Xfw81bGAPMkV38aHf3SeP
   q+GUgILyE75iFvGr2BRAafCTtZiFh9pWTKZc+LGTshfeLo6FcaNX5HlIF
   FMaf7gMkm8XR2JtKqGb0GocTXaY8M6DFH6sr2YJsdy35fW4GMqfDVVnHW
   w5bu3JMuENqwwkDmGC6vL6kZbVMNcy7qFgWKxtU/5/tYDr//Btm0n7ZTv
   XxvK3JBkeIjJegDnk37l4hxmOen8/q+UrKO2N/r38lqCul7342Xxzv6Yb
   hBe2v2N/08nfHC+vVeBrWZuyGs3OvbwEVJ3VrlN/U0q3GE+nyMe/1IkRE
   A==;
X-CSE-ConnectionGUID: U6T92scnQE6ItV21V/RvWw==
X-CSE-MsgGUID: H119jDqTSDWEorHS6Ta6BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80637486"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80637486"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:13:12 -0700
X-CSE-ConnectionGUID: kLQpvq4CQuebeiW7xZzFHg==
X-CSE-MsgGUID: 4WLCTXdyQmOZRx7X5MhCBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="237898939"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.111])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 17:13:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add CXL reviewer
Date: Tue, 26 May 2026 17:13:03 -0700
Message-ID: <20260527001305.533170-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Li Ming as CXL subsystem reviewer.

Thanks to Li Ming for all the CXL bugs they've found and fixed,
and looking forward to many more prevented!


Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..992e1fa57b72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6428,6 +6428,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
 M:	Dan Williams <djbw@kernel.org>
+R:	Li Ming <ming.li@zohomail.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl
-- 
2.37.3

