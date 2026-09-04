Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F030E82B
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492105; cv=none; b=Y7GjiCLPqE7oyYM2lCo6+r8kUKmttBF+DrQt2v24BfWuvfbtwk7qvt4qftXjCvGyq29WCJRqXbdrSwa8rRMPm2JxnjPiPsJCq75gTVp260HAlDp8qNfWEs3h9zqgFd08ak9kjvx/HfcKOiAqn7hJIM3XoX72yEuXdNSfKRGvQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492105; c=relaxed/simple;
	bh=Vmjbg4FlvrvSXFwMpMhpO4TebXHPWEv+Rpxs1aDWhdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlcRUu3gfEOFLWcA4s33J+WEyjFbCpbN1NzrfktjVJGm8r4oVWdena7yHzyzWNmrhF9gczYTZvBqji35S8peQYSQOhE9+sQ+DZWjxf6XINUpRayBiiE2RGUnZ6w9Xp0k3OpEa4sU5DFfBH5ov2AQ/PabCCLkcTKz6/0gypw9WeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdmfL2TK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdmfL2TK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788492103; x=1820028103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vmjbg4FlvrvSXFwMpMhpO4TebXHPWEv+Rpxs1aDWhdU=;
  b=ZdmfL2TKeaKPs3CBucBnOM7Wj7n9NgOE4qhyb7eedrOfL/GakYfwzbQf
   bG5TtN9BSjxx6P0B5mlnV4bMjAT5AI6Mg/Err2JNbr1uToRw9VnBx3Ko3
   eUbZN4JPeelXARoTBl73AOJqxs2/mM5Swt9OG862B2uhL7MVhRcMuz4y/
   trov8dobJ8r2OV2SLeZTJCa2hqdRUyBHlbyOZfePPEefCTU6aHm3itikk
   dmvuu6bb/sJ3LjVX4W0gRTNOaWzbwwIIgze59NT+MqcCtXebkj/cYIXDL
   +K28fehEw3U/Rp0BpIg1WmYLBL6KGRy9fCwRdM9efRaVHmtzvEotX7o7d
   w==;
X-CSE-ConnectionGUID: Y3D/OUVoT8+Q5bIrr8kUPw==
X-CSE-MsgGUID: wiuWij0nSHqxM/RFbmJmow==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100149505"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100149505"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:21:42 -0700
X-CSE-ConnectionGUID: B49SRvdOQUG8GvMtWnyEgw==
X-CSE-MsgGUID: ZjvlFshMQSK326OK6O4zng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268606608"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:21:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4 2/2] cxl/test: Add a 2-way 16K root decoder for passthrough testing
Date: Thu,  3 Sep 2026 20:21:33 -0700
Message-ID: <8a0b5f58445ecf5f5dcef33fa593fdb916628750.1788487020.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788487020.git.alison.schofield@intel.com>
References: <cover.1788487020.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl-test topologies do not provide a configuration where passthrough
decoders compute a granularity above the 16K max encodable in hardware. The
widest power-of-2 root decoder currently available is 2-way at 4K
granularity, so a passthrough decoder below it computes 8K and the
granularity accumulated at the endpoints tops out at 16K.

Add a CFMWS entry for a 2-way root decoder at 16K granularity. This
topology supports a region configuration spanning the two multi-port host
bridges and placing one endpoint under each bridge. The intermediate switch
decoders are then passthrough decoders with a computed granularity of 32K.

This allows a CXL unit test to be added for this case.

Place the new window in the XOR topology set so the default modulo topology
used by most cxl-test coverage is unchanged.

Assisted-by: Claude:Opus-4-8
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 48 ++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 62bd92b3be45..08ecb9b74372 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -190,10 +190,18 @@ static struct {
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
@@ -373,6 +381,28 @@ static struct {
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
@@ -384,6 +414,18 @@ static struct {
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
 
 static struct acpi_cedt_cfmws type2_cfmws0 = {
@@ -410,6 +452,7 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[6] = &mock_cedt.cfmws6.cfmws,
 	[7] = &mock_cedt.cfmws7.cfmws,
 	[8] = &mock_cedt.cfmws8.cfmws,
+	[9] = &mock_cedt.cfmws9.cfmws,
 };
 
 static int cfmws_start;
@@ -417,10 +460,11 @@ static int cfmws_end;
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

