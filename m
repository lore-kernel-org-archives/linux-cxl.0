Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942889;
	b=hJO61ha0SNpE75NAWEH1TvSiXXH6NYSCd+80PSv8GtHwvj7IOyDThWWCI80F3Bhy4Oa7
	 h0LakrqwVyqfYGvZSYG32xBc4G6phSch9dkgoGj/MoJMYDDYTpFy02rMhqi/2KPGzhmfc
	 GyC34t3oneo/+tQ1S5+M6MAWLl+XaEDc35xMyTQHSyvzUtsEofkzMt20658JYxaf6+z8H
	 tNUou7nYi5Pbc/1f0HeVT8fYG/FQXuDOTjtDWgd4KNU9kNOPBUX7INZCZNaYU11hGW92j
	 TS1eyhM1oBjWyw82eYhJ/Ia7MfDbWgB99K4tz7RFLcx/lkKAU3Is8fHmzCxE9bd01JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942889;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M/kfXAAsdgrMdhHE2iQzSGjasRFpLWMrL4Ev1niUplg=;
	b=VO68xHJXHvn5QKO5eJM1U9PV2I321zsqXPhNu9Tc3aLLM5dNaxidIZdJ/wAeoZosyIVU
	 WPIRv5QMraVkFWA57lfiW/JWJeLB3G/KW6vf28jOWdOkhPL+0XKBsGqZeg1hjbeHeytUX
	 Z5gOeZNQoo/OSjKnyY6ZAWHEqv60XgfNtY5BsLNFLgSpoe6fLcsGZehYaEQFOlgvsFi61
	 3GrWmP3JmC6Gw9mj16/y8d7DhOQTrt0IoY8UDEwFY2G/adOxSWeAdh68suZpY7ZdzgK0Y
	 H6yP9oUEOnnv1lzRxjBJQVGjMU+wYEs8aRnE1EZYVkAx+MVkTc3BLWvQe2IL64rnHeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=guObBjxt;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922A606A334
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 19:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3922A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=guObBjxt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942889; x=1826478889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3s4RbXtiICcufOQ44DgEAYYd/EHRrguUAyRsT+17wsI=;
  b=guObBjxt4R787rbXsNyxBRnUKE2Adqxs//XCJOSzVs4gFpHtoFdF6Ufz
   h+zjz5wczjG+Qfv09SD6+B5MHJxIJY09yaKddyIoSNTgSr0vyapO7ElX/
   X1T0l/XFHjVjtnDA5ZrtvJPCJ7k0wSj5f5EG7X4edklc9wvZkdJAilEuS
   0BzSuxHAVlYflknGfbDE7X2d/QIGtBPXLeEavjzmulIYQUWbmCgYr8ZOo
   QfkinibxBQeMFhW8LAHDiPkNkTbDe8c9C2j2j3sRqT5Lndye/M7TB8US0
   OdfV0ISsYbcdTn9g4TmviGb4Ux1OBiwk20MVQLlHQF4W+33Vepei9J4M5
   A==;
X-CSE-ConnectionGUID: a/8AamsrTh6s/lME8dIAWw==
X-CSE-MsgGUID: IOJjqSkpQvCeKdF+yUjD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3612815"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3612815"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:49 -0800
X-CSE-ConnectionGUID: rPTayqGyRVmMz7vjI5s6VA==
X-CSE-MsgGUID: cOHiMZPqQVC0Aqs2D+WVsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9764372"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:14:49 -0800
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
Subject: [PATCH v2 3/3] cxl/test: Program a don't-care granularity into the passthrough host bridge
Date: Tue, 17 Nov 2026 11:14:42 -0800
Message-ID: <da2ae965fbd09d3a5861a352976f30133503eca5.1794942093.git.alison.schofield@intel.com>
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

The auto region mock gives the passthrough host bridge decoder the same
4K granularity as the switch decoder below it. Hardware ignores
granularity at 1-way, so matching values leave propagation of a firmware
don't-care value untested.

Set the host bridge decoder's granularity to 256 bytes. Auto region
assembly then fails unless target setup carries the effective interleave
state through the passthrough decoder.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 76154c4bc15d..cd4a99fface6 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1374,13 +1374,17 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 		iter->commit_end = 0;
 		/*
 		 * Switch targets 2 endpoints, while host bridge targets
-		 * one root port
+		 * one root port. Like some platform firmware, program the
+		 * passthrough host bridge with a granularity that differs
+		 * from the region's, since hardware ignores it at 1-way.
 		 */
-		if (i == 0)
+		if (i == 0) {
 			cxld->interleave_ways = 2;
-		else
+			cxld->interleave_granularity = 4096;
+		} else {
 			cxld->interleave_ways = 1;
-		cxld->interleave_granularity = 4096;
+			cxld->interleave_granularity = 256;
+		}
 		cxld->hpa_range = (struct range) {
 			.start = base,
 			.end = base + mock_auto_region_size - 1,
-- 
2.37.3

