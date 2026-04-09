Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F259366563
	for <linux-cxl@vger.kernel.org>; Thu,  9 Apr 2026 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701302; cv=none; b=LQaxZxnD7yM9ZCvtGuL9J5O6eVFfutoFEGrcB1GvnMJlnHce2zFglwzcNd8ClL2pFy4NQSaycz07whPWoeccmWx+zSF1Hcu4Szir90WJnJM4eFHkGON+WVYF5G2jmMMw4ISgSvlbIL6SYI//vDnB0pWFrOQ6MNUr0LQLWaSEkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701302; c=relaxed/simple;
	bh=r3zYs9jDmE5wwzwFSJ8XK+QZj3Iw6+7s+2G03qWboqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZSmpSJNbiJ17E5Hdxrq0TdEf3xPqUtuK8mriZlxZwrqOeIxngnaTrQu1vXNqt2nlTOHWfxifm0BR02L/ez+2hyzPeEqBUuS5RU1000n0gCL1H74uZiRU26hoPD/lMUcmZX6lpVjab2RFMmTDhyp0+G2pj76ms4HY4uKY/FQTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtEMjlKl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtEMjlKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775701302; x=1807237302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r3zYs9jDmE5wwzwFSJ8XK+QZj3Iw6+7s+2G03qWboqM=;
  b=jtEMjlKlC14l4WeJ6arYPjtaJm9jdqH5V+LNd7+m9k2hoPd8sYOe6OhV
   3FX1QpMrAie+m9bTXvsDI6OUaGjkof1cEgS3cGHST2DLSjbc6Gr1tDz34
   8X0wMZZAVC9VSyS9PEVwzObmtzD+eta7xRsaX3MMddmDwdQx15Xemnvqp
   SZ37SZdTsZ6Ic+d3LxsD01Tx3YFHX9xoVzrK3k3P2j13IXOcF58IG56uP
   six77/PXmaorF9nYpdCKczSIolg0zuOD08SR0aHsN55DJ3iyI85oGVptG
   9HB+wFxGENVKyFGUGw3I5hyfYbDF1eazR4O3zeZsH1mhlTvL0WYN/lPes
   A==;
X-CSE-ConnectionGUID: M07ZFrIVS4WVOR5Z1gfExg==
X-CSE-MsgGUID: izwLeXzBT5GIg5r1Kf7U1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88147859"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88147859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 19:21:41 -0700
X-CSE-ConnectionGUID: 0HJM3tR1ScubAxiqDmeIkw==
X-CSE-MsgGUID: Qz4YPsGRR6+lecDuUbp4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="227774135"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.237])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 19:21:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] Documentation: Update the CXL Maturity Map
Date: Wed,  8 Apr 2026 19:21:34 -0700
Message-ID: <20260409022137.3063980-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update scores of existing items.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Please help make this document meaningful:
- are there items listed that need an update
- are there items omitted that need to be added
Thanks!


 Documentation/driver-api/cxl/maturity-map.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 282c1102dd81..a55de0239e58 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -52,7 +52,7 @@ in place, but there are several corner cases that are pending closure.
 * [2] CXL Window Enumeration
 
   * [2] :ref:`Extended-linear memory-side cache <extended-linear>`
-  * [0] Low Memory-hole
+  * [X] Low Memory-hole
   * [X] Hetero-interleave
 
 * [2] Switch Enumeration
@@ -78,7 +78,7 @@ in place, but there are several corner cases that are pending closure.
 * [2] Hotplug
   (see CXL Window Enumeration)
 
-  * [0] Handle Soft Reserved conflicts
+  * [2] Handle Soft Reserved conflicts
 
 * [0] :ref:`RCH link status <rch-link-status>`
 * [0] Fabrics / G-FAM (chapter 7)
@@ -99,7 +99,7 @@ mainly caused by the enumeration corner cases above.
 * [1] Switch protocol errors (FFM)
 * [2] DPA->HPA Address translation
 
-    * [1] XOR Interleave translation
+    * [2] XOR Interleave translation
       (see CXL Window Enumeration)
 
 * [1] Memory Failure coordination
-- 
2.37.3

