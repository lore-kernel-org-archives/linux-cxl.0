Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9525CC63
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608377; cv=none; b=pBLm/t7nX1Uhmpsd8m1vn6WR9OzXfDuEbxHwBxszo9g5tAeZa4k6nXLHypQUb17qI5PDefv7WJyMLgJ2Oq/c381huskLHsqPZeeDz4mgkNwgBHVm9nMdCsfVp0vAg5/WXCDdPEP9Eb4TH+iDpCMoTioDvYcA+U0O6/wyRnMGiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608377; c=relaxed/simple;
	bh=tX9Qw+jvwnNFm8WgSx05jKoda/vtEhLx+e/AZtx7LVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyM1lH3pvktLnhPo3Z2Bk/unYbFcpLFQQOhh58eIt5sq0BWSnHrB6PPvtMlrJzO8Ns86LZuNr+Fzo0ECpHF+gvIocuuRf9kfbtQng1tFH0jgA0eE8WQ1WwVQjm4aK4dCSGZ4GQBHCMw5zejX3Ovsgsd2PmlGA8Z+fNHcSX1Ns8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcmXoVjk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcmXoVjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740608376; x=1772144376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tX9Qw+jvwnNFm8WgSx05jKoda/vtEhLx+e/AZtx7LVc=;
  b=fcmXoVjkjLHjhUbx/L5ddm/hWH+PTqdkPD7GmkRP2iEJpSCuTlYvP89j
   QJIoJ+0WchgGfhoLl5iSGMIV6RTpr+I28slDnIg9KSJI0aYfuDUglTZNf
   68oi63ODvW3Cyl7tLj81dsXda2h5/V7QsWRvtIQA7Wm13gaf3Si103rQy
   dyCMALTiLAZzTayzEOtMmj+jrUakfwpQCms8N0+Is1XvKXtgiV9zpjMPX
   MY5CwEoBtgo67oGUGq7zBjCuB44fBwy7CGWeDyiffCsXcqthfr7haQyYZ
   S1v8fVccNlAdzHuT0wWtHrs5ZeNjVEX7lxz5wZbl8bFoAKY4G8KPRH4dU
   A==;
X-CSE-ConnectionGUID: GbP0AjzsQh648/PDlY2Ipw==
X-CSE-MsgGUID: wva+vAXDTiq3Bbr8e9bWIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="29080105"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="29080105"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:19:35 -0800
X-CSE-ConnectionGUID: 9l1b8GefSeCsdA8EctVfpA==
X-CSE-MsgGUID: bbR202YJQguWT7UyPfrD3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117338255"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.13])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:19:34 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] cxl/test: Define a CFMWS capable of a 3 way HB interleave
Date: Wed, 26 Feb 2025 14:19:27 -0800
Message-ID: <20250226221931.2352061-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL unit test cxl-xor-region.sh is skipping a 1+1+1 region
interleave test case because the window is not defined.

Additionally, upcoming expansion of 3 way HB interleave test cases
(like 2+2+2) require the same window.

Replace an unused CFMWS with a 3-way capable CFMWS in the set of
CFMWS's loaded when interleave_arithmetic=1.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
---

v2: Adjust target list length (Ira)

 tools/testing/cxl/test/cxl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 083a66a52731..1c3336095923 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -155,7 +155,7 @@ static struct {
 	} cfmws7;
 	struct {
 		struct acpi_cedt_cfmws cfmws;
-		u32 target[4];
+		u32 target[3];
 	} cfmws8;
 	struct {
 		struct acpi_cedt_cxims cxims;
@@ -331,14 +331,14 @@ static struct {
 				.length = sizeof(mock_cedt.cfmws8),
 			},
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
-			.interleave_ways = 2,
-			.granularity = 0,
+			.interleave_ways = 8,
+			.granularity = 1,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M * 16UL,
+			.window_size = SZ_512M * 6UL,
 		},
-		.target = { 0, 1, 0, 1, },
+		.target = { 0, 1, 2, },
 	},
 	.cxims0 = {
 		.cxims = {

base-commit: 2bb67004903cfd35710750654669a77e7223fcd1
-- 
2.37.3

