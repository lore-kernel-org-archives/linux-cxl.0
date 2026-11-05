Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851076;
	b=XZq99hIiZ4B2bfJTM0YVBJMFHZeoVGmdRss+lNG9qw1KKitcv7etWzAjJLChw9lpIf+7
	 hCalDohOokDoovotHtdHzEy4/HeDW1j+Ui41+Xa3jpLpZlEJfJwzuSoVAI5gqTIygB6UJ
	 m3qO9nqLYnkDaoocAzyxkjnoUKzhDAMt6BfdPfn+pUoTS4ONk8Uq3xi/YlLwHQsc2zNWM
	 QaZrvH9HQicNU761widv4uYUyeOrQWQFRT/5HrOx/A/QlfKZHEx4oSNGj3v7we+0q3l3J
	 ZJDHZUiPyC1H8SK1whXWx7a9k8UTKiHzBermZd3WrrYf9NAs3onv8mmsLvE+bi/EltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851076;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Ituk/+Ar081RCQfmI6hMZ/FOrTHgYG6L75cTXLh9vM=;
	b=4Jlc39GuZQSb3+EJ39ZVvm1f6q326Y/BZ4ugT4bZ0x0gBDH8oV7hg9dlAabZo/3KJ6sl
	 JtkTOsawif7RMu/Ktelpm/amlPbDtNZuj4LzxChAdnD7GVvgNj7Z05bYZKHC13CLZ3/hH
	 zUXypsnR5SSYp0cZILT1UE8LAudrS/ETOmxSIfPzqH3gbJuxeZZGARRXXc474d26CF6GF
	 Rbxgfb4W3MDxYRxoluOEzkUwkE3Kcwf3NLS2PnmN2Ut7MHSb3q0Jhd3mTE5zUGvAihDgT
	 KAb5Rq4gHHeM+4oxZ2zJCaJ+5Y19XgUfL1+GxGLCtgU89WWsPqHrpsv4cL7QJGbTHMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KpPRtvgp;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA9606A32E
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4CA9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KpPRtvgp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793851075; x=1825387075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ri+PuFg19hSG0w6tDahlxtWiT5t/PZ5HT3YSfeIHJCk=;
  b=KpPRtvgpRz6fLJhbRX7rhrmxLsAsO9lRc3vCahgk/J8wpmhrM1xDVKZ+
   9KOVKMMosqVat2txJ7wT2eJlynaMCkc2dzZHQ8xxO/CfEf2qZXC6tFkiu
   MU0NqvC1aHhDHQaqPMBf8OGI1VIG5iDd/0+SyZNl4rwQUkdmeWuR23fCj
   IH2I5VHhr6Sh2HQ+Dlo2iS5R7abbNeNGsgOTYy7u5rg1Ap6OOME/kYFLT
   nt0nfbkyVTV28xap6a/55JeJ82UGkfuCMuV/Mamux0ZufFXEEJHVFe0WN
   pOMBikAxxY+6JP5vW53uOG8m0HhMnncfz8WftQ3S7gegTCQG7ELjqXYmG
   w==;
X-CSE-ConnectionGUID: Y8R8YtzqRUiHUNLLmvF5Ug==
X-CSE-MsgGUID: CgYyqvYFTO2H+QGXGEiJsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2643983"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2643983"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:54 -0800
X-CSE-ConnectionGUID: nzH84aG2SCCUBOQ3ZuatAQ==
X-CSE-MsgGUID: PzewdYUbQ1eWjY/CKUJ5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6741090"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:53 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 3/3] tools/testing/cxl: Add CFMWS windows for region selection tests
Date: Wed,  4 Nov 2026 19:57:48 -0800
Message-ID: <89e8d2cfde4f1054f37a4f48f2b206a7f05108f7.1793850480.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793850480.git.alison.schofield@intel.com>
References: <cover.1793850480.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region selection needs topologies where multiple root decoders can
satisfy a request and where a decoder supports both RAM and PMEM. The
mock topology provides neither.

Add two x1 windows, one PMEM only and one supporting both RAM and PMEM,
while preserving the existing modulo decoder identities.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 71 ++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index d0793961b0ee..7fae489d00e9 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -185,12 +185,20 @@ static struct {
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
@@ -325,22 +333,20 @@ static struct {
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
@@ -348,16 +354,17 @@ static struct {
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
@@ -365,6 +372,38 @@ static struct {
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
@@ -407,18 +446,20 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
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

