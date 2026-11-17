Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942889;
	b=Zy64kDpEipXSIzjHbWphuc6u5p3CC1JEVk0T8FdujmLy7IbMb9FwlV4AbfGrWvlJb4p+
	 9FKtDIu0KtOazZYo78GZ+zLex9HfOEj4rd8bb0blzIcH/FvqR3boKhOSerXxAY306va1T
	 zC10N1rZkX38KHqeG74eUG1VNjAEMi9EeUJMSGzxk6kgzhw/Z+jHlIDI5F53NSSaMsGhC
	 e+a+MZagMdBRx0MXwz1BxAGWOHsoUkXcRb1bOqvf3BJ+HvUos7x7mKIrZqzK75SkG3Abh
	 CyXVCf/toEDmtvjPtLB6s9fEvd61W+5rDAMjbRAInpyewdXo2Mf72jzymMUtmhBXcrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vROyAI9jxBhgG41iL+Jy2mcdqSQHaPoUUESI48+MXWw=;
	b=ypFJCCTUq1ncZAw9rmaE1abpnnG3rfoxZg64VkW1eyN7Y5aoRtapTTwWlbasIuEhWoX3
	 x9NG//RHzP+Ub2sTUQvrarVt8qbgHkje+djB38yBkV5dtGRTBJlFm19ijK8Q9VjXoc5Yt
	 AcpRqQrKvtMLODedEApS6l1BnITSskR2oFWExwzKyYQYfifszjJlxs6UXk5LptJSwsncJ
	 lwyz20GH87G3yBM4UCvPupgg9/nobfuMaOTk/Qav03CrZyys2HVKHFEyVaRLDytePUmNZ
	 vJTbws2ifuIYW+u1pyo8GLFQfHpmky5DoAdRDI32J6HIfMaOpW20GVK51B1U/8x3dDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VwOBSpTr;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FB606A32F
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 19:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65FB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VwOBSpTr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942889; x=1826478889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WAYp5x74YGB/pR3SDcg1IM+U1TgST9mk4IemUadRB7g=;
  b=VwOBSpTr56z4FqiXw8tzOK3u20Ic/BE3D62vUVB8z0Xko1X5XKFeRu0R
   3epzmcw7oMGCNVrqgSghPSWFH4fScsk/cdlToy8mBiKcQL41HRgun517U
   sk1wJWqBBmxECP0Jz6tgJP7YI1N+RnWJIfKg784VH0j5eLlyttL411tXn
   h+SH1hYGFJFYdcYIdolX7lEyac6dpmMeyzZ8W58BPEbbPDzLCIRik5/7w
   dZKjMoQPf3xvbv2d14sLKFJoxZaS6HX7UFPr4TqnJ/jgMgOVR0EwQGRBI
   4m8lZdoW5IPdfzBUKnGIY59XupgPVfcaFz4DFQkr7mCyJoL6OPGzhTocC
   g==;
X-CSE-ConnectionGUID: mdf9BxijQheqaNk+3EZa5g==
X-CSE-MsgGUID: 2PxVfX49QgSK96nLL0NClA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3612805"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3612805"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:48 -0800
X-CSE-ConnectionGUID: AJkrl828Q7mwOQkB1wzYuw==
X-CSE-MsgGUID: ItpVqxlsQ/azL3rbiZBBsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9764366"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 2/3] cxl/test: Add a 2-way 16K root decoder for passthrough testing
Date: Tue, 17 Nov 2026 11:14:41 -0800
Message-ID: <4b3bde20c5bc8fc3ed8348e8b0eec085336304f5.1794942093.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794942093.git.alison.schofield@intel.com>
References: <cover.1794942093.git.alison.schofield@intel.com>
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

Add a 2-way root decoder at the maximum hardware granularity of 16K.
Selecting one endpoint under each host bridge makes the intermediate
decoders passthrough, allowing a unit test to check that they carry the
16K interleave without exceeding the hardware granularity limit.

Place the window in the XOR topology set to leave the default modulo
topology unchanged.

Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 49 +++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3eb1051b1ee8..76154c4bc15d 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -191,10 +191,18 @@ static struct {
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
@@ -325,7 +333,7 @@ static struct {
 		},
 		.target = { 3 },
 	},
-	/* .cfmws6,7,8 use ACPI_CEDT_CFMWS_ARITHMETIC_XOR */
+	/* .cfmws6,7,8,9 use ACPI_CEDT_CFMWS_ARITHMETIC_XOR */
 	.cfmws6 = {
 		.cfmws = {
 			.header = {
@@ -374,6 +382,27 @@ static struct {
 		},
 		.target = { 0, 1, 2, },
 	},
+	/*
+	 * A 2-way root at 16K, the maximum granularity encodable in
+	 * hardware. Passthrough decoders below it must carry the 16K
+	 * interleave through rather than multiply it.
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
@@ -385,6 +414,18 @@ static struct {
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
@@ -411,6 +452,7 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[6] = &mock_cedt.cfmws6.cfmws,
 	[7] = &mock_cedt.cfmws7.cfmws,
 	[8] = &mock_cedt.cfmws8.cfmws,
+	[9] = &mock_cedt.cfmws9.cfmws,
 };
 
 static int cfmws_start;
@@ -418,10 +460,11 @@ static int cfmws_end;
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

