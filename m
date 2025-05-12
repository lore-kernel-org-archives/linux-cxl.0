Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151A268C40
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094303; cv=none; b=bNFcpw1/u5QSVR4ghBHy35gOIOckJtwhvhRZgzzdj5KbYjAgd4W337VJyy8s1D3knr+fg1wrgbGjsnZ6sQ0XUImHSt/rVcIYnvxivFo6YOun7oMU3fwqmqldz9/hUFTlVnrcZC6cJMIG3V+TZbljqOQ0Sn8Wp3pmLjK4o3OYFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094303; c=relaxed/simple;
	bh=cQKZYiLmJcYpJJWH7FnHfP3AHTg9ip6cX6aWTEm/e44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbDF71cChcOCw/iLGTjXbO/YI+vdhHFukyZjBWTvGkMiBf+5xvGzYRPD4f7fhAYB/4A3VvhFQKqsndnCmBuG7eEF2cluEX51Pi993bfNTrXLlJ57K4r+no+2ZKp+VVveWW7F3jaNYqBuN6lIIUEwTV1ZUsWb2oa+e7Q+wAoPyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ls7EWVkQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ls7EWVkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747094302; x=1778630302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cQKZYiLmJcYpJJWH7FnHfP3AHTg9ip6cX6aWTEm/e44=;
  b=Ls7EWVkQtRD+1Y4JM+L15BFrL6nGEBIwiu2nFPTcm+FS9N+tTsq/2Dts
   kOze3HYyrnJEi7Ohs9XHe4Z0XmKniW8Ov23V3arrltfXRtjDmjMy9NTwG
   hOg/jbgmlwoDOFqtPjaokXybZ93DtRuGPv8Ry805xx5RG9PxrwrvZ2Fo6
   Pst7kMtBNdNltyq4ylUFt9jrUVyPgrgUF0mO/kaScYmp38L0Y9YfevkzC
   VHvi4lh3TzV9D96RLn9SiLVgiyn8TM9CkD2+25Gri69oz1WmhHGYsPC1z
   IiUIhSV6MZD3Qn0BA+M1xlGOsyAJYbsLftDgISObRVA+BPH5ym16HjqBL
   A==;
X-CSE-ConnectionGUID: gzUpfzP0TfeC5784I7fnkQ==
X-CSE-MsgGUID: c8GgVvxfS3iT/JMqeuOWhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66464284"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66464284"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:58:21 -0700
X-CSE-ConnectionGUID: AldOQwxHRISlxrdPYQAZQA==
X-CSE-MsgGUID: AoiHB/z/QDWiJjO3y67mVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="137931258"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.31])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:58:20 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Sync up the driver-api/cxl documentation
Date: Mon, 12 May 2025 16:58:15 -0700
Message-ID: <20250512235818.1396979-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

pmem.c regs.c mbox.c identifiers were missing. Add them to
memory-devices.rst following their respective DOC comment includes.

Two acpi.c identifiers were available, but not used in kernel-doc's:
1) Add add_cxl_resources to memory-devices.rst and fix up the Sphinx
complaint on the ascii art (escape and indent the pipes).
2) Add cxl_acpi_evaluate_qtg_dsm to access-coordinates.rst.

core/features.c is newish. Add a "DOC: cxl features" comment to the
source and the doc and identifiers to memory_devices.rst.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

DaveJ: the "DOC: cxl features" addition was simply a copy from the
Kconfig file. Please take a look and I can update.


 .../driver-api/cxl/access-coordinates.rst      |  3 +++
 .../driver-api/cxl/memory-devices.rst          | 18 ++++++++++++++++++
 drivers/cxl/acpi.c                             |  6 +++---
 drivers/cxl/core/features.c                    |  9 +++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/access-coordinates.rst
index b07950ea30c9..5f2ad093fabe 100644
--- a/Documentation/driver-api/cxl/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/access-coordinates.rst
@@ -89,3 +89,6 @@ ACPI0017 device to form a new xarray.
 Finally, the cxl_region_update_bandwidth() is called and the aggregated
 bandwidth from all the members of the last xarray is updated for the
 access coordinates residing in the cxl region (cxlr) context.
+
+.. kernel-doc:: drivers/cxl/acpi.c
+   :identifiers: cxl_acpi_evaluate_qtg_dsm
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index d732c42526df..f378a5d7ba40 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -347,6 +347,9 @@ CXL Core
 .. kernel-doc:: drivers/cxl/cxl.h
    :internal:
 
+.. kernel-doc:: drivers/cxl/acpi.c
+   :identifiers: add_cxl_resources
+
 .. kernel-doc:: drivers/cxl/core/hdm.c
    :doc: cxl core hdm
 
@@ -371,12 +374,27 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/pmem.c
    :doc: cxl pmem
 
+.. kernel-doc:: drivers/cxl/core/pmem.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/regs.c
    :doc: cxl registers
 
+.. kernel-doc:: drivers/cxl/core/regs.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/mbox.c
    :doc: cxl mbox
 
+.. kernel-doc:: drivers/cxl/core/mbox.c
+   :identifiers:
+
+.. kernel-doc:: drivers/cxl/core/features.c
+   :doc: cxl features
+
+.. kernel-doc:: drivers/cxl/core/features.c
+   :identifiers:
+
 CXL Regions
 -----------
 .. kernel-doc:: drivers/cxl/core/region.c
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 587ad5289f7e..a1a99ec3f12c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -749,10 +749,10 @@ static void remove_cxl_resources(void *data)
  * expanding its boundaries to ensure that any conflicting resources become
  * children. If a window is expanded it may then conflict with a another window
  * entry and require the window to be truncated or trimmed. Consider this
- * situation:
+ * situation::
  *
- * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
- * |--------------- "System RAM" -------------|
+ *	|-- "CXL Window 0" --||----- "CXL Window 1" -----|
+ *	|--------------- "System RAM" -------------|
  *
  * ...where platform firmware has established as System RAM resource across 2
  * windows, but has left some portion of window 1 for dynamic CXL region
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index bdc2c492bdff..5461cf07e65c 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -9,6 +9,15 @@
 #include "core.h"
 #include "cxlmem.h"
 
+/**
+ * DOC: cxl features
+ *
+ * A CXL device that includes a mailbox supports commands that allows
+ * listing, getting, and setting of optionally defined features such
+ * as memory sparing or post package sparing. Vendors may define custom
+ * features for the device.
+ */
+
 /* All the features below are exclusive to the kernel */
 static const uuid_t cxl_exclusive_feats[] = {
 	CXL_FEAT_PATROL_SCRUB_UUID,
-- 
2.37.3

