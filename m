Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88B40DFC2
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456786; cv=none; b=JkqWFOT7zlZJoDDSf8D1/Lw7JUPQ5UC97Tfy7+I0lSOfu1wxxt6pjW+aTMzYVO9gwyyFy44sVxN11Ldj4nQzEk0rBMSvo05RiBCUkXGpmW1TB5wdWJKXJcBk89Axrw56oYd89enA2kFTv4+OnJuzmGaA8FoKYB5Awgxqj9D4URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456786; c=relaxed/simple;
	bh=MQp5nf+ePcIBAjEPt/Io89pAPVa3PV/PqTD4d1XT+XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qn2+f1uPfYAmXbTKLDanKHOCL2EB4VkOtBlxCD4TGDvzAhM2bXxPk3KaR36rVbmSKLB0yd/41s6oG9cDWYpcXxgal5UYWRRCfv7T8YjAsU/CzJ53f96l+OVF2RgxNk5cBH1IFnpPy327Wr9URuWfAEMrbkLae8Ex8jJIUvINRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iU/g7OOp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iU/g7OOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776456785; x=1807992785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQp5nf+ePcIBAjEPt/Io89pAPVa3PV/PqTD4d1XT+XA=;
  b=iU/g7OOpa7O7DnV6gkx6l9VaX/umSdiBIIdFN6t28qm47J92b0rPW9qt
   Xj8eo5FfFzP9/n04EJRSL6wpX50ZSB5G8iwwel35+WipJ3TeDD2cYmOUP
   T56e+D9JmVVbfdWFHgA4GQ1+lOokP3Yc0wUwQyG0JEr0agQ7X/WeDtxyB
   rleeu/9FngdKNOIddToioK+OkYrrHb43lOQpzX74wLb3BCVVUGC/Tc5EA
   lKk2dsEkoRRw8OUmXuJPI4qP/xNxz9fE/JXXCmRUnWqbewNaE+ZybvQdG
   x7OmjnZRFjWn06QliOGPkFECKxAodVVqydEzCvUtWEnp2mlWbOSQhMFhL
   Q==;
X-CSE-ConnectionGUID: GJ1KSHePThqtv5rHsOGCCg==
X-CSE-MsgGUID: Rqnyh7bGTSapaH2lNafa1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81355714"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="81355714"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:13:04 -0700
X-CSE-ConnectionGUID: tY9zxzGMQlSsmvMdU7W9zw==
X-CSE-MsgGUID: yXAoghfISNCNSlc4/uY3Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="231001582"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.71])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:13:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] Documentation: Update the CXL Maturity Map
Date: Fri, 17 Apr 2026 13:12:46 -0700
Message-ID: <20260417201300.3438995-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a few updates to scores of existing items.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Update after walkthru w DaveJ 


 Documentation/driver-api/cxl/maturity-map.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 282c1102dd81..1ba528c82755 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -52,12 +52,12 @@ in place, but there are several corner cases that are pending closure.
 * [2] CXL Window Enumeration
 
   * [2] :ref:`Extended-linear memory-side cache <extended-linear>`
-  * [0] Low Memory-hole
+  * [X] Low Memory-hole
   * [X] Hetero-interleave
 
 * [2] Switch Enumeration
 
-  * [0] CXL register enumeration link-up dependency
+  * [2] CXL register enumeration link-up dependency
 
 * [2] HDM Decoder Configuration
 
@@ -78,7 +78,7 @@ in place, but there are several corner cases that are pending closure.
 * [2] Hotplug
   (see CXL Window Enumeration)
 
-  * [0] Handle Soft Reserved conflicts
+  * [2] Handle Soft Reserved conflicts
 
 * [0] :ref:`RCH link status <rch-link-status>`
 * [0] Fabrics / G-FAM (chapter 7)
@@ -95,15 +95,15 @@ mainly caused by the enumeration corner cases above.
 * [2] Component events (FFM)
 * [1] Endpoint protocol errors (OS)
 * [1] Endpoint protocol errors (FFM)
-* [0] Switch protocol errors (OS)
+* [1] Switch protocol errors (OS)
 * [1] Switch protocol errors (FFM)
 * [2] DPA->HPA Address translation
 
-    * [1] XOR Interleave translation
+    * [2] XOR Interleave translation
       (see CXL Window Enumeration)
 
 * [1] Memory Failure coordination
-* [0] Scrub control
+* [1] Scrub control
 * [2] ACPI error injection EINJ
 
   * [0] EINJ v2
@@ -112,8 +112,8 @@ mainly caused by the enumeration corner cases above.
 * [2] Native error injection
 * [3] RCH error handling
 * [1] VH error handling
-* [0] PPR
-* [0] Sparing
+* [1] PPR
+* [1] Sparing
 * [0] Device built in test
 
 

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.37.3

