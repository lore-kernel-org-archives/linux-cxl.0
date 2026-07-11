Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2A2BFC60
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800336; cv=none; b=GESIoT8tvpRnfS2tnO6JA/4hMAl/392eKGLyrxJIV3q4PhBReUEsT1ZmfgiYEczLs2JndQWTZSf5VSLcmWhzChPal1PNAMoU9HPFRiszrO5pevBamJ81DhkEQSDoMMffcXs8ruSRBkT7PAb2liZid0mJyWrZRfQET0MnjHy6OJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800336; c=relaxed/simple;
	bh=gS+HAOQ1Iul40m1zPaSXgCXAQoZym5jm2roaPbSCb/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDmc7c5xrsdG7nh43hAudUpla7Nz14kSLGFerWgQZabPs16kApbbE4EDi1C2963DQ6OAsYuuoC6scsG7ZiiVgi4DegEm5+lPvzaC+Q36LZaSxbvNg2HPTT8JUcL5Ix5Fs9FsTlXCbAR5q7j/1SMEHaNiDXVzZRlUX/fSubZ7NK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7NRQD9r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7NRQD9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783800334; x=1815336334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gS+HAOQ1Iul40m1zPaSXgCXAQoZym5jm2roaPbSCb/k=;
  b=X7NRQD9r6BIUenuJRVntCPeliYXBsKKe+itaMH7ZSZDNvIeZvOga13T5
   FF0iv/Paej1gwSWIPbyXzHuXy8/qcB5MaT/UrFO8mApo5B7Pqu/pqAAbM
   JNukxTv4hncINyNHG1tA4f9k8Mp9Sjr44J6dFD+jDVrx5NTTdtx4GfCYg
   SeWzwtdxhMnEMXLLaHNo8G0skGrOoahpPQZ9HF7ibDckXPdfnLz5s04qs
   i0e+qR5Mjn9zXgXzPEuAn5tgmHDibJZ9/BrQJBb+cyGkLvTnVhB3bsKIu
   ntTUpp8yr63jMALCA9HaGzSxX6eWSyOSWK638pYoV0J4ID1gZqWQbSAow
   Q==;
X-CSE-ConnectionGUID: xOqXEC0jSLeh9LCLRjLpxw==
X-CSE-MsgGUID: jbUW0WdQQlqAv7diT4auEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88379108"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88379108"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 13:05:34 -0700
X-CSE-ConnectionGUID: ixJKh5EhT2y6gOl5EbEDhg==
X-CSE-MsgGUID: I8eIXgEPTJWl6OJM9BJEsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254048293"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 13:05:32 -0700
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
Subject: [PATCH v2 2/2] cxl/test: Add a 2-way 16K root decoder for passthrough testing
Date: Sat, 11 Jul 2026 13:05:23 -0700
Message-ID: <82b172d4698fdd4b57626f517bd74d946c9080a1.1783795720.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1783795720.git.alison.schofield@intel.com>
References: <cover.1783795720.git.alison.schofield@intel.com>
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
index ef92dd35e030..5b87a3f5673f 100644
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

