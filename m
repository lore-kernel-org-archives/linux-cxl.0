Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322B18B488;
	Mon,  4 Nov 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709727; cv=none; b=rCK239DkM/X+EGtoFZ/AS01UbLWuqccQ7O8wtAkCF9RKQpoFo3fD5EHhJ/hQryaLhNSdngoYRtI+XYcjagJT3GFCklBAU1VI268hYWoNHCOk4aBeWVNQwM2aWdBlzBUeEjkFlXJyEGBXJ0zi30io3Yljyj9C0bZgTpRtpaNiroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709727; c=relaxed/simple;
	bh=K0lLcc+gTXKpzbsb+wAENwJEybmYSjGzk4ZhgMXNSs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZCJYQtZ9wi76h/TN2iwWVqTe3OZXvh3qoVH+2UarBx3nKPvZAXmmIrcce7sfm/yGugxMWURDFvg1Vvx15yJmwzABHb6dice1vLp+Noop1dT8ljCKe1CAdih6qFGZT2chjyB91pOTeZQOR1qHS0uUx3mkN4BRTp2vZUjIa1rL+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYTPrh/G; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYTPrh/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709726; x=1762245726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K0lLcc+gTXKpzbsb+wAENwJEybmYSjGzk4ZhgMXNSs0=;
  b=jYTPrh/G4jdnIMPiKyhAlJKBEdNmAXdiZW4srB+/tjzDKdnqg1SKyYlk
   4NHcmplJA7iAVXObkSOqIwYvf65G6nDHzzV6N7q9kWHKnMkd1m4ColN8s
   2pdP8or7Fi7x67FviRLPyRGVKpfeEZYgQZvBe3hzxpAowliUSfnOUxWk8
   xB50pQSGXA+OPxq7pFKerDPh9iyuTGPsr+GuXTNCtSUG5+r8Wi5IqcHQT
   FXgo4XnL5vqi5xPJQm2pPeLNKy4ag4UMv5Yh4WCMDvJw0zCH1X3+9zAT8
   /n7CHPEGl1xAs1Rh05pomG24fi6laSI4v86mPNnPGYvp3aFZ4BigAEY13
   Q==;
X-CSE-ConnectionGUID: 4qPOz8wxRjWdoXXPftuXNg==
X-CSE-MsgGUID: dn8dbuXyTc6OwcCXg8Q2Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41502512"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41502512"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:42:05 -0800
X-CSE-ConnectionGUID: pOrpLiIIRS+sOK5ZeAz8TA==
X-CSE-MsgGUID: luACYbaUQBC0Fa7f8n7Rbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88167352"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:42:01 -0800
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
Subject: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Date: Mon,  4 Nov 2024 16:41:10 +0800
Message-Id: <20241104084110.583710-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
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
ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM.  This makes the kernel
code consistent with the spec too.

The patch also renames the corresponding cxl_decoder flags
CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVMEM/HOSTONLYMEM.

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
index 82b78e331d8e..aca8cbb7540d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -115,10 +115,10 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
 
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
-		flags |= CXL_DECODER_F_TYPE2;
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
-		flags |= CXL_DECODER_F_TYPE3;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
+		flags |= CXL_DECODER_F_DEVMEM;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
+		flags |= CXL_DECODER_F_HOSTONLYMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
 		flags |= CXL_DECODER_F_RAM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a5e6f3d23cfb..8524714968fd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -125,8 +125,8 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
-CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
-CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
+CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
+CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLYMEM);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
 
 static ssize_t target_type_show(struct device *dev,
@@ -326,14 +326,14 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 
 static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_PMEM;
 
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
 
 static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_RAM;
 
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0fc96f8bf15c..b9083ce1cf74 100644
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
+#define CXL_DECODER_F_DEVMEM      BIT(2)
+#define CXL_DECODER_F_HOSTONLYMEM BIT(3)
+#define CXL_DECODER_F_LOCK        BIT(4)
+#define CXL_DECODER_F_ENABLE      BIT(5)
+#define CXL_DECODER_F_MASK        GENMASK(5, 0)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 199afc2cd122..e195909928df 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
 
 /* Values for Restrictions field above */
 
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
-#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
-#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
-#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
+#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM        (1)
+#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM   (1<<1)
+#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
+#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
+#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
 
 /* 2: CXL XOR Interleave Math Structure */
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 90d5afd52dd0..9d919fc99f6b 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -209,7 +209,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -224,7 +224,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -239,7 +239,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -254,7 +254,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -269,7 +269,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -284,7 +284,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M,
@@ -301,7 +301,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -317,7 +317,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 1,
 			.granularity = 0,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -333,7 +333,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 2,
 			.granularity = 0,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 16UL,
-- 
2.39.2

