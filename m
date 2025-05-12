Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9244C63
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086151; cv=none; b=Nzt6yfjoMzRXHYPpbh3eJ0T8SfrBdKEv+FZS4p1tBCBbEORrIeiE3TetWrr5CbPSLRQhU9I3T/e5dO4E9WC8DzTFInFhYwQ2UXWd+MShhi1cVe1A2lzy8Fzr6/m6m+zxyow1ijC7IBFbiQUr7jfWmS9eK9NpcdMjssemUuMiKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086151; c=relaxed/simple;
	bh=4yG2FZT5ZV6AmRbQVsx/gpunNbQ6znoZarRTgLI5RFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YV6wD6xYRGBUhuwmvlvfTPn1E8HFNeYmjHDkBuuue2CFy4E4qXlJ1Q2QtQKWwI/1TJU+gy/OZWrlb7FbVdINtoDZZwip/URU85UY/KA+xU2AWMU82eO0CLZWNRWIxpCzNzFTCO4Wk6jIeDCMJmHn2D5nbNTcWtQAFYQmHuErX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlAH1l6J; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlAH1l6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747086150; x=1778622150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4yG2FZT5ZV6AmRbQVsx/gpunNbQ6znoZarRTgLI5RFE=;
  b=NlAH1l6JxFBEVFw/pVLZoB9cMBeY2pXRU6iZpEUn7iSRDfVHdzXgJXU4
   DHlGlDmmOJoLmwd/1vEWlc1VUxwMILsCf7kuChKFG6CBURiugbLWWV6nl
   QGIadQoFSSjLboOThIYGMX5AqkoISIwFYZokVSneY2SYhmy22isosxE6s
   FoDY1bGaLtzJG38Htb7ncjgHUF28cqwWefMgmLCSglUxVl9csxTXOWaEj
   BqJ3Zdcf90dOTR2gp+j6yWR22bvy+wDPCyyHKa6RUh0CuSzeWv/VA9gOd
   O6Dw7WPXA9QEdVhOCUGtJsveP0Kn2Xg/oq/DuD/2+XdtxwRjXzPMLIAox
   Q==;
X-CSE-ConnectionGUID: UgT+oS9WSVqsZyUEFP6d9g==
X-CSE-MsgGUID: boh2Ch9kTeONcmtUJLo44g==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="71415837"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="71415837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 14:42:30 -0700
X-CSE-ConnectionGUID: ygqBaqxCSTeye8AcUZjq2A==
X-CSE-MsgGUID: wNyxKR2lR/WFjOIgYLeNeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="168586671"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 14:42:28 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] Documentation: Update the CXL Maturity Map
Date: Mon, 12 May 2025 14:42:22 -0700
Message-ID: <20250512214225.1389484-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes for extended-linear cache, hetero-interleave, and HPA->DPA
address translation.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
Change in v2:
- Make ELC a '2' (DaveJ)

 Documentation/driver-api/cxl/maturity-map.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index a2288f9df658..1330f3f52129 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -51,9 +51,9 @@ in place, but there are several corner cases that are pending closure.
 
 * [2] CXL Window Enumeration
 
-  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
+  * [2] :ref:`Extended-linear memory-side cache <extended-linear>`
   * [0] Low Memory-hole
-  * [0] Hetero-interleave
+  * [X] Hetero-interleave
 
 * [2] Switch Enumeration
 
@@ -173,7 +173,7 @@ Accelerator
 User Flow Support
 -----------------
 
-* [0] HPA->DPA Address translation (need xormaps export solution)
+* [0] Inject & clear poison by HPA
 
 Details
 =======
-- 
2.37.3

