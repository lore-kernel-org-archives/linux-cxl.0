Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D21FBC8C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137813; cv=none; b=k0HAWDfNlRUfTH5j4TPoVvHYjZ2V6iJ3B3T6Scc4nXMiH1MY1P0AFCs/A/ixxLKtd0YBGkSX0I7u8Igx2/SK2zFoasPdVt4N6UfPFKwiYVDaNZTq0FpiosXpCugWERzySs3Wx1F95HhnkSiAD3zMDgKpgNNB/lRUG36immvfgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137813; c=relaxed/simple;
	bh=f07YDacaHxyJBLnQmQarp7FV1To7cURJ+8bceTtA3io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ap+D0rkt9KVQVBNL645SVjRWYW2WIJ6t5ulGow4gHFZrpRfkBNCnEYR5W0+por0PTsWRP/IoBfGKbb1sYqeyRZGZKD/sAbp5ke7AzTcfEeKzsrAMgTvlxOrVpZKX84uMVNiKRFFRs5P2X4AZPKLA8vt+5PkvfQRnQDs8DJe9axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEjFMP6K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEjFMP6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781137812; x=1812673812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f07YDacaHxyJBLnQmQarp7FV1To7cURJ+8bceTtA3io=;
  b=jEjFMP6KAkzxVtdXGz1O9xGOaSJOsV8OF7jLPui8ur20y8hvqC1s6g5j
   FssNnARwGsDJ//iuj9EB7hXt4AXPvjsnmQ3JSAyBL3Cg8CC2G7kKUCnHQ
   MrNQL6kTjTgp/7jBtYbr73kwdqYr9kaWQSWJYSJJ7ImQXl0zmIus1GdWB
   9RRA/vQ4s4XOKHqL1GRNQeEgm4geisuYHCDwIfpXhDYeATEVVAoYJCGP4
   Ny1M6nWC5VUoam/c+fRdrpdEBGRpCqcDoQQ+40sw0HNPZcydyU+Qqtmln
   BOyFnF1G4K5rP4ZaUmonb980WUxDyM4ZK2VV0xPmZWCqmODFr/yHbvVkG
   g==;
X-CSE-ConnectionGUID: dEWMfBV6RHC1Ywdir/xdhw==
X-CSE-MsgGUID: qQSJLhIHScyKGJU7Fooi5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81794433"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81794433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:30:11 -0700
X-CSE-ConnectionGUID: kHFAi6Z/S8WdCWoY4fID1Q==
X-CSE-MsgGUID: bHUdGeIHTdiBvpxwDis+jw==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:30:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/test: Add a 2-way 16K root decoder for passthrough testing
Date: Wed, 10 Jun 2026 17:29:31 -0700
Message-ID: <066ecc93b99d132d44423861b0868e7819103fd9.1781136281.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1781136281.git.alison.schofield@intel.com>
References: <cover.1781136281.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl-test topologies do not provide a configuration where pass-
through decoders compute a granularity above the 16K max encodable
in hardware. The widest power-of-2 root decoder currently available
is 2-way at 4K granularity, so a passthrough decoder below it
computes at most 16K.

Add a CFMWS entry for a 2-way root decoder at 16K granularity. This
topology supports a region configuration spanning the two multi-port
host bridges and placing one endpoint under each bridge. The
intermediate switch decoders are then passthrough decoders with a
computed granularity of 32K.

This allows a CXL unit test to be added for this case.

Place the new window in the XOR topology set so the default modulo
topology used by most cxl-test coverage is unchanged.

Assisted-by: Claude:Opus-4-8
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 48 ++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 296516eecfd6..ec16cd9cdbe2 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -188,10 +188,18 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[3];
 	} cfmws8;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[2];
+	} cfmws9;
 	struct {
 		struct acpi_cedt_cxims cxims;
 		u64 xormap_list[2];
 	} cxims0;
+	struct {
+		struct acpi_cedt_cxims cxims;
+		u64 xormap_list[1];
+	} cxims1;
 } __packed mock_cedt = {
 	.cedt = {
 		.header = {
@@ -371,6 +379,28 @@ static struct {
 		},
 		.target = { 0, 1, 2, },
 	},
+	/*
+	 * A 2-way root at 16K granularity. A passthrough decoder below this
+	 * root computes a 32K granularity (16K * 2), which exceeds the maximum
+	 * encodable in hardware. It exercises the passthrough granularity path
+	 * in cxl_port_setup_targets().
+	 */
+	.cfmws9 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws9),
+			},
+			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
+			.interleave_ways = 1,
+			.granularity = 6,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = FAKE_QTG_ID,
+			.window_size = SZ_256M * 8UL,
+		},
+		.target = { 0, 1, },
+	},
 	.cxims0 = {
 		.cxims = {
 			.header = {
@@ -382,6 +412,18 @@ static struct {
 		},
 		.xormap_list = { 0x404100, 0x808200, },
 	},
+	/* CXIMS for the 16K (hbig = 6) 2-way root, cfmws9 */
+	.cxims1 = {
+		.cxims = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CXIMS,
+				.length = sizeof(mock_cedt.cxims1),
+			},
+			.hbig = 6,
+			.nr_xormaps = 1,
+		},
+		.xormap_list = { 0x0, },
+	},
 };
 
 struct acpi_cedt_cfmws *mock_cfmws[] = {
@@ -395,6 +437,7 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[6] = &mock_cedt.cfmws6.cfmws,
 	[7] = &mock_cedt.cfmws7.cfmws,
 	[8] = &mock_cedt.cfmws8.cfmws,
+	[9] = &mock_cedt.cfmws9.cfmws,
 };
 
 static int cfmws_start;
@@ -402,10 +445,11 @@ static int cfmws_end;
 #define CFMWS_MOD_ARRAY_START 0
 #define CFMWS_MOD_ARRAY_END   5
 #define CFMWS_XOR_ARRAY_START 6
-#define CFMWS_XOR_ARRAY_END   8
+#define CFMWS_XOR_ARRAY_END   9
 
-struct acpi_cedt_cxims *mock_cxims[1] = {
+struct acpi_cedt_cxims *mock_cxims[2] = {
 	[0] = &mock_cedt.cxims0.cxims,
+	[1] = &mock_cedt.cxims1.cxims,
 };
 
 struct cxl_mock_res {
-- 
2.37.3

