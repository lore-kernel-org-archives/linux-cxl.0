Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1531F9AC
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643395; cv=none; b=ETCP6MCHZHLAdNkXm75vx8t/EOXN4j7ckjmu5TL8CCKIY1aOsyQfn8Y1feehs8nDvD+o5e20cNWXwqLLJcOlAN6qo1vgd9aQv5H4Ftg1Nl7F3juhT8fXKRyx275LmuuNNiJOhaX1xuCyGBCaipNJ36gUSodM0YH52aLFySCoFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643395; c=relaxed/simple;
	bh=gvApHvJnosvEA/WywkIT+7jr8+B0gTxGgFGoZ33jF/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcytRKY/5y7DrnD8pACH5IfzGOV4TIoRHApWu7JhZ7yhEN+58YxRXPLXChOXOlP2xaY3Wlc9Dcc7QCjxMeI0Wt63HGSmoix/6n8Y1p8uJUBBpJM8G8wffqihEW/8Lz3chzBss8c8RSrWw8lHjS+KZXKIlpW6S3SU4CmADXvFpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9CHMEzC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9CHMEzC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790643394; x=1822179394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvApHvJnosvEA/WywkIT+7jr8+B0gTxGgFGoZ33jF/Y=;
  b=K9CHMEzCdxbVXIYg0jjGDk2czgCCIW3QwWBsGHedgDDTBonysmtCO43c
   TO5FahxplIqMXExF205EnXn7oO1u9aTK3mEcjoS0i7m+84W7h99mzN13c
   WjLru645AnIM6cIt7ci7OI1y8CEsK1lLlOrIvo+4VuVN0oXKq4VNSrtFQ
   2W0vtjXDpJ+EDRd47d1cYdzqgoB+bjU/++LdFns0Fhkpgh/XCBiuSsWms
   CIYjwFVac/yJ3pVAlDOrc82bSxhwgxk5Q7lhjAMziR7HgG5e0reDduThX
   8tsdbM64UhxiDMbH72xLsKXT4kReOPrIt0g1eea6b6B73xH4jfcKcejpI
   Q==;
X-CSE-ConnectionGUID: IvfhUB52RWW0yFhBbz8D7w==
X-CSE-MsgGUID: mVrkNnsoQKK8oAcKbv7NfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101923940"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101923940"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:32 -0700
X-CSE-ConnectionGUID: 7TcXrxBGQ7Ks8UvgqQV4Cw==
X-CSE-MsgGUID: b0SKRZeZQFiDwHHW8UeJ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273012218"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:31 -0700
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
Subject: [PATCH 3/3] tools/testing/cxl: Add CFMWS windows for region selection tests
Date: Mon, 28 Sep 2026 17:56:18 -0700
Message-ID: <86859bf360612deb991dc61862f2e4aa6fe54a6a.1790641236.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1790641236.git.alison.schofield@intel.com>
References: <cover.1790641236.git.alison.schofield@intel.com>
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
index 9d844932f0c6..3e76d9bb2d5f 100644
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

