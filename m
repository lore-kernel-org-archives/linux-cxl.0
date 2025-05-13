Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72120EB
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173500; cv=none; b=NvPSJHgXZxZFC/2Rwt71XVbEGqaHJESlg36tAeVMN1ZJVLVv6NdDQt2gapPEIoCoH4zRWeSbcsythtaC/gAL963+NTba0/ccwIQ5JPawBFLeKG/2mzBv/XvjYbyY4gfohl5EMJepJIiFWbu0x6TGcoU59jkP0D4oiAOmWsQrGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173500; c=relaxed/simple;
	bh=Ogo/zNm/k/ASfh6WvXbt74qx+lwxDczLcuN0VruVCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjmpioQOpzvd5K86nlsEZpbGC7DAmFVDf7/ONUFto30CiJYBVRBP9TAYDbMBCrpQNQthPWehM+aaV8B+V4xlBb4nCZ0Us3vFhKEEzCpxJiPeLdp3wn8vxRNhls1WtttnrncQAw8wosdPb9QL267hHSSjG89bj4DknChVqK9JkpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBv6fqiV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBv6fqiV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747173499; x=1778709499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ogo/zNm/k/ASfh6WvXbt74qx+lwxDczLcuN0VruVCNU=;
  b=FBv6fqiVYARjSbnfWAVyPORirC0VmYv8Z94Vy0CqzM7uduavRyOW/KM4
   Lb05wLCoKaRecSXx/6bNV9c2HqBDm3GoBKDPKDsX/z2iOgiqaEW7GPZBn
   ftLtT6PDmoL94KUMyqA0Qdd388Uw8H+t3Qje99lXq05X6J6SwiBnzdigE
   XDl+vYQ4VqEqQRFENqeZxZG+1Min1BPRADGM9qsCjcTBd89wx66/kLWa7
   auqZHp7AA45pQBd5u9BDiORcWBrqiLQ0S9frwPwzlsd484IeccxrcSuPD
   McCTTzBmZ1ZvyGN2B680W2+AtEf4fmtForwUhx/5Gd6tTz5Jg7B1uiSr+
   g==;
X-CSE-ConnectionGUID: Jeligd/PSiu/BB/LyvLniw==
X-CSE-MsgGUID: IBNt5Y5YSJy/ooBeEhjqfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="51692275"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="51692275"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 14:58:17 -0700
X-CSE-ConnectionGUID: PJspnfheSPeE78v8y1ZVDw==
X-CSE-MsgGUID: c5I5grTVRgWVuATDmketUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137716842"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.167])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 14:58:15 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl: Sync up the driver-api/cxl documentation
Date: Tue, 13 May 2025 14:58:09 -0700
Message-ID: <20250513215813.1419645-1-alison.schofield@intel.com>
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
complaint on the ascii art by escaping it.
2) Add cxl_acpi_evaluate_qtg_dsm to access-coordinates.rst.

core/features.c is new. Add a "DOC: cxl features" comment to the
source and identifiers to memory_devices.rst.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---

Change in v2:
- rebased on cxl/next with Gregory's Boot to Bash


 .../cxl/linux/access-coordinates.rst           |  3 +++
 .../driver-api/cxl/theory-of-operation.rst     | 18 ++++++++++++++++++
 drivers/cxl/acpi.c                             |  6 +++---
 drivers/cxl/core/features.c                    |  9 +++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
index 71024fa0f561..7f949cc4ece5 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -90,3 +90,6 @@ under the same ACPI0017 device to form a new xarray.
 Finally, the cxl_region_update_bandwidth() is called and the aggregated
 bandwidth from all the members of the last xarray is updated for the
 access coordinates residing in the cxl region (cxlr) context.
+
+.. kernel-doc:: drivers/cxl/acpi.c
+   :identifiers: cxl_acpi_evaluate_qtg_dsm
diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
index 32739e253453..1b854b11f575 100644
--- a/Documentation/driver-api/cxl/theory-of-operation.rst
+++ b/Documentation/driver-api/cxl/theory-of-operation.rst
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

