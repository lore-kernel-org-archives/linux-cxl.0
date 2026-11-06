Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003765;
	b=zTUMSAF7B4JaLHMC9qm1Ts/v+MM5JeyE9ns/pu4SL+P4eGVpGY0PbASjIFsvJChjf5De
	 NMwnt6ImkOU+YcBrfYWV/YQrjZDY8C+V3E8RC9CrSAivJpdIw3U22GGISNHgbpYDD4mqg
	 FNFxXYVKlEMoqRkVcsyKNH5G6xyQyqLCV8SBwvpi3a32SJXxtLaqLWTjfB4PPMCZZxjDS
	 OXZA8a3eLRmtZIbuvbY5LlIXuAh/jIW2vUDtGA33648LJP1l8UHFEz1bN2hJ7IBgqk8TZ
	 E16wT5OU11XX/hjVHZHETkBbKNhR+JfnxWiw1M40hLl8O18GzV/0oT+OExUsmImzp1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003765;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KTW2jMMFVT+3SfdjeATjW0ff20zAcZVB8yPjv1/9eZk=;
	b=fDef5iHCqQvsVFhrGRKibENQfbqs9CrzKBayWd6OFEeb4z//ZxS3r44kd5D7IXrB6CJg
	 tReeAoIpMxfJPzj/njXjBeyH4N4eN5H6CjOsegfXrQ8WnZxxA4kQ0KOthHao/A5LLj4rN
	 Ao9Ni81cQj5DxDknCJFR6I+dl6sHDn1t9cf6UyBVvOvHL/Tn0gicThzsVeHvvjcPFzwX2
	 ySYvM1rILm74CogrgIKB3ANMkLtzFc2BpybzE4qpMj60/mJ622REmJ/RW5GMAGzjiLSjJ
	 G7Sz8ymKITK/+gGpEThfsFb3/eMUEvh7E+3e5jegHY3HW92LQ9zxz0Nf4did8jXajFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZOmhXbc;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D320606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 22:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D320606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZOmhXbc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794003763; x=1825539763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JGS3cYhpBYCrtZHN8xUiu64ldW0BtV06e6rvPlVAww8=;
  b=cZOmhXbcctdK94S+nIdmeBQCR1MgSrrw8PqQMFdglKMk/9IrPYXgr4JB
   9AaMKyEX8aGcIzlLIKrWDjE+dzWS037r4tTsvgy9bFLIaBpQb2n2qut1s
   vQQ0eS/MQUUp4i+HDLMcPH3m9WP2lZ53QZi/DWRHfkL4iks48RcINLWR/
   mkLZixxHuolkhW0QcoKyRIlE6nvRlQbzT9onSlE4ZLO1aB9RuSuVGqj3s
   /LSrqt6xUy2x/cMbDQqg3zJ/ssxIfGlQVc26O3+f5+p8ISam2i2R82IT4
   m2WHoKb+BMtPdbFj8w5ePTkksT9U8qVDV+n6t/DwVI6rfMyshYcS71qt7
   A==;
X-CSE-ConnectionGUID: bPfVxD2JTlyVQ/l0CGRJkw==
X-CSE-MsgGUID: sjj328apSaGe6h4awpf8KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2814699"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2814699"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 14:22:43 -0800
X-CSE-ConnectionGUID: WIvTyNgJQUus5vu7pgQoNg==
X-CSE-MsgGUID: oC+qtjjMRmOLPHsNiLucag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9151326"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 14:22:42 -0800
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
Subject: [PATCH] cxl/test: Free the decoder registry when cxl_test_init() fails
Date: Fri,  6 Nov 2026 14:22:37 -0800
Message-ID: <20261106222240.958402-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
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

Decoder registry entries persist across mock device removal to support
topology replay. Sashiko review found that if cxl_test_init() fails after
decoders are enumerated, the entries leak because cxl_test_exit() is never
called.

Free the registry entries and destroy the xarray during error unwind.

Fixes: f3b1d2260703 ("tools/testing/cxl: Enable replay of user regions as auto regions")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3eb1051b1ee8..e3bed17ae253 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -2436,6 +2436,17 @@ static int cxl_topo_init(void)
 	return cxl_type3_topo_init();
 }
 
+static void free_decoder_registry(void)
+{
+	unsigned long index;
+	void *entry;
+
+	xa_for_each(&decoder_registry, index, entry) {
+		xa_erase(&decoder_registry, index);
+		kfree(entry);
+	}
+}
+
 static __init int cxl_test_init(void)
 {
 	struct range mappable;
@@ -2525,20 +2536,11 @@ static __init int cxl_test_init(void)
 	gen_pool_destroy(cxl_mock_pool);
 err_gen_pool_create:
 	unregister_cxl_mock_ops(&cxl_mock_ops);
+	free_decoder_registry();
+	xa_destroy(&decoder_registry);
 	return rc;
 }
 
-static void free_decoder_registry(void)
-{
-	unsigned long index;
-	void *entry;
-
-	xa_for_each(&decoder_registry, index, entry) {
-		xa_erase(&decoder_registry, index);
-		kfree(entry);
-	}
-}
-
 static __exit void cxl_test_exit(void)
 {
 	hmem_test_exit();

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

