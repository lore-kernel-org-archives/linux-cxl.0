Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10E18BB84;
	Tue, 15 Oct 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975501; cv=none; b=XNu2h6rFaHH/JJTq5JTCzHaR2BPFezxAOI0DgQ3aA68rXmdmBqMfhW5lTtOn3NBaSmEtwp++2foYUhTiLtTOj6Q2ihOSP7+SDjHZZmgPxfZPObnAi5lqmUYHh4evsCu0HWEg5HOzq9huUVnwYV5efz0CTTRL/xzJyCkrwFS9mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975501; c=relaxed/simple;
	bh=qS+Toc7PoXNztvG/RjDoMwseOURx1foo6t3tLhCVIwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhkgjD0WSuzdC7moY4XVLf8cdOsDb3ldAspERORLo+tV79tua6KRq1G1qmFjptXsmysjuPrRKIB+B+3xgpdWQZ78x4pzjoBAeyJd0v4LNsJRpT96NXKnjK5nJgjhAdGzmJjNoBMXvp6OuPORnZ8fSj15X0Qru2ucBtjhkK49J/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEMDn77Q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEMDn77Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975501; x=1760511501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qS+Toc7PoXNztvG/RjDoMwseOURx1foo6t3tLhCVIwc=;
  b=DEMDn77Q9TLHrlxK2B51qveI+3uCOVFs97fdkwMwvdegr+/tc2Ixh1m7
   kLoaJpOjftxIJP/loKb5rJgC6rwsU3oWA7iw4ZnNTxg4Zk3BkD7wk0YzI
   tkRYPcbnp6ZaOSh4DGCVafgMe2LV6WGUv72+vTN+qqoUPCnUldEHtVHoB
   Qhw/r0NubcOFwJBd+7rurm8+HXQnQUX+mBod7n6VEGWM7gPGY/3N6GARv
   ABOWGwvyp8BdRhLHnH0g5U14xNe7GicdvJ6B1YyH/tWyGF8S1NTSMr9H+
   nPqu+XCzIfkRMeu58YUw8B6xNKOPUZAR+fCisIqN8zPo0zl7hBuSwSrRi
   w==;
X-CSE-ConnectionGUID: xTGs+c9MSyShSQ4ARa+3ow==
X-CSE-MsgGUID: r3krmHe2TseOjmubiRoJjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28447813"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28447813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:20 -0700
X-CSE-ConnectionGUID: tRe05deZRmuyQuXMemuphQ==
X-CSE-MsgGUID: M+zrl6rURpGmI9kqJpisHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81776909"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:16 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH 1/5] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Date: Tue, 15 Oct 2024 14:57:09 +0800
Message-Id: <20241015065713.308671-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241015065713.308671-1-ying.huang@intel.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the description of the "Window Restrictions" field of
"CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
formerly known as "CXL Type 2 Memory" and renamed to "Device
Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
and renamed to "Host-only Coherent".  Because type 3 memory can only
be host-only coherent before, while it can be host-only coherent or
device coherent with "Back-Invalidate" now.

To avoid confusion about type 2/3 memory and device/host-only coherent
in Linux kernel, the patch renames corresponding bit definition from
ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
ACPI_CEDT_CFMWS_RESTRICT_DEVCOH/HOSTONLYCOH.  This makes the kernel
code consistent with the spec too.

The patch also renames the corresponding cxl_decoder flags
CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVCOH/HOSTONLYCOH.

No functionality change is expected.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/acpi.c           |  8 ++++----
 drivers/cxl/core/port.c      |  8 ++++----
 drivers/cxl/cxl.h            | 14 +++++++-------
 include/acpi/actbl1.h        | 10 +++++-----
 tools/testing/cxl/test/cxl.c | 18 +++++++++---------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8e..3115f246273b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -115,10 +115,10 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
 
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
-		flags |= CXL_DECODER_F_TYPE2;
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
-		flags |= CXL_DECODER_F_TYPE3;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVCOH)
+		flags |= CXL_DECODER_F_DEVCOH;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH)
+		flags |= CXL_DECODER_F_HOSTONLYCOH;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
 		flags |= CXL_DECODER_F_RAM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a5e6f3d23cfb..35b6ad4ea0f9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -125,8 +125,8 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
-CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
-CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
+CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVCOH);
+CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLYCOH);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
 
 static ssize_t target_type_show(struct device *dev,
@@ -326,14 +326,14 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 
 static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+	unsigned long flags = CXL_DECODER_F_HOSTONLYCOH | CXL_DECODER_F_PMEM;
 
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
 
 static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+	unsigned long flags = CXL_DECODER_F_HOSTONLYCOH | CXL_DECODER_F_RAM;
 
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0fc96f8bf15c..a34e4256aa5f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,13 +315,13 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
  * Additionally indicate whether decoder settings were autodetected,
  * user customized.
  */
-#define CXL_DECODER_F_RAM   BIT(0)
-#define CXL_DECODER_F_PMEM  BIT(1)
-#define CXL_DECODER_F_TYPE2 BIT(2)
-#define CXL_DECODER_F_TYPE3 BIT(3)
-#define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+#define CXL_DECODER_F_RAM         BIT(0)
+#define CXL_DECODER_F_PMEM        BIT(1)
+#define CXL_DECODER_F_DEVCOH      BIT(2)
+#define CXL_DECODER_F_HOSTONLYCOH BIT(3)
+#define CXL_DECODER_F_LOCK        BIT(4)
+#define CXL_DECODER_F_ENABLE      BIT(5)
+#define CXL_DECODER_F_MASK        GENMASK(5, 0)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 199afc2cd122..2b2111035669 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
 
 /* Values for Restrictions field above */
 
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
-#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
-#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
-#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
+#define ACPI_CEDT_CFMWS_RESTRICT_DEVCOH        (1)
+#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH   (1<<1)
+#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
+#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
+#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
 
 /* 2: CXL XOR Interleave Math Structure */
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 90d5afd52dd0..3982d292d286 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -209,7 +209,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -224,7 +224,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -239,7 +239,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -254,7 +254,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -269,7 +269,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -284,7 +284,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M,
@@ -301,7 +301,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -317,7 +317,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 1,
 			.granularity = 0,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -333,7 +333,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 2,
 			.granularity = 0,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYCOH |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 16UL,
-- 
2.39.2

