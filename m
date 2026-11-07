Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011712;
	b=EXQo4jzmTyOCHO8OoZeASxCjv6mYSGqk1OioGW7g179XyYXwhLPOO35UdtDZhJwSNrqA
	 vvArMpQKGoyFu1pwzW9aoib9BE+j7u7z5PeVtRZB+7EBnput0nreQcgwPkQTXkU8os8cw
	 bpKTjSmIhnjVYC7a/HLGEfwc69V7YlOJJjv2gG2d3hLC9e5rKyi2uE9K6UZt7Z/QlKUaA
	 PTfevih3aLwgKiPwrkrEaXlhGCwyWrv/LBoEnIip1fZcb2+QKstwKoE1HPFspTYZuarjO
	 L+EJ8T12ObLh0XQGi02+a8lSrlePM3WSc7Uz6SDsX4253RBX6poot1jcaK0ymIr2Snw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011712;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h0qaofX8KQSFlMrpIoDD+AW4MiaweDZFIV+CytEbw10=;
	b=kduBrhxIXj7DyS8+bP3cqxWwwmrkjhF/COdpZ5lkH1hffFqTcPQO751KkSTDH3Fv2q4l
	 g5WE2rrTsscIENWI0SSYYPq7zHdL97L2oFGUbC9K6gSopvMBP5epkgWE3CFRM/Y82ubui
	 dIs6/3kE0S/wpnM/E0U/YszIAm4MgFULxp7VUzle+EhWsdZ90bpo8wHZ5veGd1BTIZuAd
	 RiBZcjKU816AARzvjQtOYkkK3xgt8OAYZNkoOHufg4JnNK3DaovHTEMGCQCy9b0GHgd+n
	 77aWAzaeB+xnqo+wZvubL6qhYa9Y/EB6B4Z187qDa+6XWcGnyVInX51fIpDH86tDMTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jeLUBadi;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED2606A32F
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 00:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EED2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jeLUBadi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794011709; x=1825547709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCylL5plVevNkKq7BaOzLDlOnqapX/E4e9yTyd0dCTU=;
  b=jeLUBadijzHtK8Jz3A3L97EXOLjlPi+5l9zHeVVTn6ky/yG9g7jXLVQm
   CWzLxZbnu4hoy+pXcnItRhxlbbDzvv8CqUXNvi/H0++3RBwDUBCTVo1jg
   r7ar8w6GtZV/Y7JdWQRLJbWJk2z4b9DaJ1O6iIGvbFhtFG/DxAzx7ZR6x
   uMLBOWdcNH2YoslFowsv3RXeU36myqVLv0wbvjJAMJXogHEkR7oZgcypC
   lPhBT5nZOkt2qG3L4jVvauEe13XgUaQ5YjYrA6Px3CUafuGpz+wSDWAch
   fd9x5m0a1lTtq3fyL8rZ+pTg3gdFXItMarEIO8h/C9BUIfE4Dsb37LsjV
   w==;
X-CSE-ConnectionGUID: 8adniZZUSEGixTWX3AZbow==
X-CSE-MsgGUID: 0ZdEHa/1S6WQlmi5oHF+yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2710318"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2710318"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:09 -0800
X-CSE-ConnectionGUID: iorQ/d97Tn2iWSa11sSouQ==
X-CSE-MsgGUID: 4Z+b4p+KQp6sMciIJyNSEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9176233"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:35:08 -0800
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
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/test: Add a 2-way 16K root decoder for passthrough testing
Date: Fri,  6 Nov 2026 16:35:01 -0800
Message-ID: <13bdd65ad28c8e7f834fa01f7df1b0134416ab3f.1794010889.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794010889.git.alison.schofield@intel.com>
References: <cover.1794010889.git.alison.schofield@intel.com>
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

