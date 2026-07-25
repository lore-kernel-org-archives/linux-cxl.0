Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82378635D
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941743; cv=none; b=VDyjhm3OYHnBJ8bx+/J/DP4KD5hNoR10Ze1Im3laH2Di8bT9uGRKwjwfqsEQdcvBz4ZBMPVfU8JC/NsqbP7P0FppmnZyYmj6XNc4ylwevoCSjo67ueiyff5TKD5kXyO0dAMOQsip9GQoVkCp0Cr9yFyIJGq9FG9SIMP6BtAXpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941743; c=relaxed/simple;
	bh=gS+HAOQ1Iul40m1zPaSXgCXAQoZym5jm2roaPbSCb/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTqfauJNOA1bE1/MYPXCrlyLNOtP5dZbI/7qjJ4ysGi4/CJWF5vKidRaTumIp14UQq4iKqY3hgCEou95WKYb6Wxi5EcR1f52K5+BVKIdmcVMv3L/uJ7o6hNZypO1ifE7sHECDCSKOJ2mSAxqFB+3rAKIjVcLGkkFSOKrnKc0dG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+xCpi4m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+xCpi4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784941743; x=1816477743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gS+HAOQ1Iul40m1zPaSXgCXAQoZym5jm2roaPbSCb/k=;
  b=R+xCpi4mYL/SejmNwp2sNkXMsICZf/G3DBfaKRG3l8QfngLBk9gK6wlc
   VInuWxMObtrYu7+dNIuBH0CAyvsEm+wnJFEWq39JZeNts5PQFWYz9vNSJ
   0WOUIpIya8urVI8ozt0B+A9k3Rpp7f5x7PP7tnXCwh27czGZ3CSVNOMJA
   zPYJaAOj4QHepyaizvzVeRD9HSFGdJFVYrQ8OhuAezTWDaacCr+5Vvyeg
   mSoxnymQ3Jh/lBmjOGOrGhesaRvPDeqAaqabb5AdU8czqodKwq5xkaVHg
   pjiXsXy5z5rnCwKvWE4k/yJcygrl7q5Rq+gmME/fVIYNfAwi500jB+l9w
   w==;
X-CSE-ConnectionGUID: Z0TRBoSyTl2XU3W6pQxmAg==
X-CSE-MsgGUID: gezbVtzSSwGF3S84F30hlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85622206"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85622206"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:09:02 -0700
X-CSE-ConnectionGUID: MCG6OoE6QKSUquxMbQz2Uw==
X-CSE-MsgGUID: cTKRjNsUQ4W6YLwWdwh4lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="259506729"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:09:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/test: Add a 2-way 16K root decoder for passthrough testing
Date: Fri, 24 Jul 2026 18:08:55 -0700
Message-ID: <e89552a2c51b63657da50c9286d48ab858016721.1784940306.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784940306.git.alison.schofield@intel.com>
References: <cover.1784940306.git.alison.schofield@intel.com>
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

