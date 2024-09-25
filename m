Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869F148FF5;
	Wed, 25 Sep 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232434; cv=none; b=O2hVggE7U/QyCEvJXfwRxNpz2RpoGlmxu1raBUfGdcEXfvrkKOYsIWprapt1KR+srvbhEfi/SXQawPkxiJs0S7Y4kJLUHcE0NWGotC1ai156owYTYz30bA1obuGYB9IdIAzY3hcmIEWEDH+IS2A/BC9ib6W2q214KOuw3tnT4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232434; c=relaxed/simple;
	bh=KaE7JObUOq0Hcir5tFk/BG6islLlrFQy8Kf+EuSeDvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vw5obGzsu832Jhm2fzafqiGxqXzp7b+iwVlSoH49yZVYXGzXqfx0QEQfCSQM6tFOo6/hhMz+pac31OOCYCCtlCfIRMiipnvaTjCUXK0HkGqPPNrvxrFjWZTCOoxHJsphN/32ogZuSF7J7E/3ILkwRk2X5eXc7bZgq5EocpEG6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qv8/0POU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qv8/0POU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727232432; x=1758768432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KaE7JObUOq0Hcir5tFk/BG6islLlrFQy8Kf+EuSeDvI=;
  b=Qv8/0POU7ce61vC3gni/NTpbxhuLmtJrk1kO7VzuNB8tc1npxd27GVo6
   F8HF7YVVtsbFeFl63Pnz4gE3Ntvh56ORW9VXxyY/lYbYjp+6OLfZh44+Q
   hKor7TOPKWFw9wVECs1vg+q511HFIyIrENSdpehj032Q5O2w0/752D6fT
   UyQFw/h//YatvGQqUCxhyRezyYw+jNOdNTuvtWIntMQ3JRI/YT4wMZn+M
   /VWZF2VZqC60+vypq59r6t0VQadWpuRQyLoV8ZN5QsnmJzldpJ6qlMVO2
   L7JZBkdPXb2qnw3A4mansB4n1YHuWhbIBG4pr34/NC/UgBiX8l6QK031O
   w==;
X-CSE-ConnectionGUID: 7b5VOZPkRP6FxzMdSW2AEA==
X-CSE-MsgGUID: u3JKQ+VpSkWmQdoVFfPf6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26132026"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26132026"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:12 -0700
X-CSE-ConnectionGUID: SSEpI4rNQSmayvsP5CKZtg==
X-CSE-MsgGUID: 1Jpq3+vxR+q0bv6wWzRlqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102388969"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:09 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 1/5] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Date: Wed, 25 Sep 2024 10:46:43 +0800
Message-Id: <20240925024647.46735-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240925024647.46735-1-ying.huang@intel.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
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

To avoid confusing about type 3 memory and host-only coherent in Linux
kernel, we rename corresponding bit definition from
ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
ACPI_CEDT_CFMWS_RESTRICT_DEVCOH/HOSTONLYCOH.  This makes the kernel
code consistent with the spec too.

Also rename the corresponding cxl_decoder flags
CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVCOH/HOSTONLYCOH.

No functionality change is expected, because we just rename the flags
constant definition.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
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
index 1d5007e3795a..67a8dc4d7868 100644
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
index 9afb407d438f..28c8783d3c14 100644
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
index 841ef9f22795..2b38455e0f13 100644
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

