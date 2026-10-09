Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D439934C
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583940; cv=none; b=M7v+JjeG/ICrpuOmYhlbRXXHPZCygPf7ZMgMy4yGLz58GnEv1Vtvo3pU+2/bEw8fhNDRJOk5LsT4vgV4aHDJemBysQHrlzx3s+0f89EmLJ3lG77QBLo2/e4SVcVr/h9+I92iS4lRmoGOyc9WEVyJsxJ4sI2n6ofTaBykj2wC9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583940; c=relaxed/simple;
	bh=0o5GpxkDtmB5+43aGv2sqAUuiES82pe5JEodxNiZ11A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDn2NHsFDVm7sjM0hUwVElR/7UulUVt9rXsd1Ae9tUEh6L/U78pcrI5hfbTcwDrQBgQJnQBvJnQgKrL/YAbGmxzODmM6dsOc9Swr4X3XYGzODAlSQeqiWeWcBOTsFHy+rwEUlhz19AUg58gTQnqpu70FDoHALTzHjiuy4GRCDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByvDylmg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByvDylmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583937; x=1823119937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0o5GpxkDtmB5+43aGv2sqAUuiES82pe5JEodxNiZ11A=;
  b=ByvDylmgLhiOXYBocEEjY/irx60PH/wQZvTIgzZWAn4WVfwOZUuuwV2j
   p0YJMfwFPwn5VD5FGSGIVUP/sez4MH71Fle+abqHI73n2oa36h1eV8STn
   nV6ff1Uto/lVU4LicQFJGfHNF2tfPOX5k+mE+8Dzg4qYF+Wu9naW5awkl
   Ki792hIyeHDszy/EocOjJPZsfEs2cj0qTaDFye14lGN1W4fMkRgZvH0rn
   8AupNVmHd4Mb483bxqBP/99F+ygFz2YBMFxbgr6aySXThAApwXJUDLz3B
   I+bRPot8eFKRrj6ZD7otEP5ISZR9oFZO57ymukWdofDUjekuURnOxRQ8l
   w==;
X-CSE-ConnectionGUID: 4Qkq2ZDSRDaeyGY8C3LUpw==
X-CSE-MsgGUID: UPwb3ZUqRfueYm/X4hgZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="294840"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="294840"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:34 -0700
X-CSE-ConnectionGUID: mvbgfczRT4WY7eU/jE7i9A==
X-CSE-MsgGUID: hQaMGPDvRZSyTRQgPrpQpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="505714"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 3/3] tools/testing/cxl: Add CFMWS windows for region selection tests
Date: Fri,  9 Oct 2026 15:11:23 -0700
Message-ID: <74ce1a0d09b6bab2f93d905a49dca681ac3b4648.1791582353.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791582353.git.alison.schofield@intel.com>
References: <cover.1791582353.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region selection needs topologies where multiple root decoders can
satisfy a request and where a decoder supports both RAM and PMEM. The
mock topology provides neither.

Add two x1 windows, one PMEM only and one supporting both RAM and PMEM,
while preserving the existing modulo decoder identities.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 71 ++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 46a87633e962..93bb520612f1 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -184,12 +184,20 @@ static struct {
 	} cfmws6;
 	struct {
 		struct acpi_cedt_cfmws cfmws;
-		u32 target[2];
+		u32 target[1];
 	} cfmws7;
 	struct {
 		struct acpi_cedt_cfmws cfmws;
-		u32 target[3];
+		u32 target[1];
 	} cfmws8;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[2];
+	} cfmws9;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[3];
+	} cfmws10;
 	struct {
 		struct acpi_cedt_cxims cxims;
 		u64 xormap_list[2];
@@ -324,22 +332,20 @@ static struct {
 		},
 		.target = { 3 },
 	},
-	/* .cfmws6,7,8 use ACPI_CEDT_CFMWS_ARITHMETIC_XOR */
 	.cfmws6 = {
 		.cfmws = {
 			.header = {
 				.type = ACPI_CEDT_TYPE_CFMWS,
 				.length = sizeof(mock_cedt.cfmws6),
 			},
-			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 0,
 			.granularity = 4,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M * 8UL,
+			.window_size = SZ_256M * 4UL,
 		},
-		.target = { 0, },
+		.target = { 2 },
 	},
 	.cfmws7 = {
 		.cfmws = {
@@ -347,16 +353,17 @@ static struct {
 				.type = ACPI_CEDT_TYPE_CFMWS,
 				.length = sizeof(mock_cedt.cfmws7),
 			},
-			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
-			.interleave_ways = 1,
-			.granularity = 0,
+			.interleave_ways = 0,
+			.granularity = 4,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M * 8UL,
+			.window_size = SZ_256M * 4UL,
 		},
-		.target = { 0, 1, },
+		.target = { 1 },
 	},
+	/* .cfmws8,9,10 use ACPI_CEDT_CFMWS_ARITHMETIC_XOR */
 	.cfmws8 = {
 		.cfmws = {
 			.header = {
@@ -364,6 +371,38 @@ static struct {
 				.length = sizeof(mock_cedt.cfmws8),
 			},
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
+			.interleave_ways = 0,
+			.granularity = 4,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = FAKE_QTG_ID,
+			.window_size = SZ_256M * 8UL,
+		},
+		.target = { 0, },
+	},
+	.cfmws9 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws9),
+			},
+			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
+			.interleave_ways = 1,
+			.granularity = 0,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = FAKE_QTG_ID,
+			.window_size = SZ_256M * 8UL,
+		},
+		.target = { 0, 1, },
+	},
+	.cfmws10 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws10),
+			},
+			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 8,
 			.granularity = 1,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
@@ -406,18 +445,20 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[3] = &mock_cedt.cfmws3.cfmws,
 	[4] = &mock_cedt.cfmws4.cfmws,
 	[5] = &mock_cedt.cfmws5.cfmws,
-	/* Modulo Math above, XOR Math below */
 	[6] = &mock_cedt.cfmws6.cfmws,
 	[7] = &mock_cedt.cfmws7.cfmws,
+	/* Modulo Math above, XOR Math below */
 	[8] = &mock_cedt.cfmws8.cfmws,
+	[9] = &mock_cedt.cfmws9.cfmws,
+	[10] = &mock_cedt.cfmws10.cfmws,
 };
 
 static int cfmws_start;
 static int cfmws_end;
 #define CFMWS_MOD_ARRAY_START 0
-#define CFMWS_MOD_ARRAY_END   5
-#define CFMWS_XOR_ARRAY_START 6
-#define CFMWS_XOR_ARRAY_END   8
+#define CFMWS_MOD_ARRAY_END   7
+#define CFMWS_XOR_ARRAY_START 8
+#define CFMWS_XOR_ARRAY_END   10
 
 struct acpi_cedt_cxims *mock_cxims[1] = {
 	[0] = &mock_cedt.cxims0.cxims,
-- 
2.37.3

