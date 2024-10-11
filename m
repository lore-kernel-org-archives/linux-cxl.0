Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4F2F26
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624879; cv=none; b=rdYm8BVxzQ5X6EPs3xLSk4FSluF/mmRKizWX9U6WRHwodh9Hgt1tIwlRB3aZjECGH7IOcMUgRSehr09ZCxuSCPfAbWcyhPHot8Eq7ULjx4YOM12YL0L2LRJkdt/XbyFEkYHKCAtH7+A6D+RYiTyptIRM0/2uSU2sUNBx/K8Knds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624879; c=relaxed/simple;
	bh=8+1Oxg2KD3Wc6rz5kN6jZmUPo8IGhAIV8pkcpyE4JhM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqkBNc3HGcXsNXZg+g/Q3/siEseM6eLkE8TKe4N1UN2fXoHGCHkGBuUTsdic4h7hZr3NiHIVfbxnkRTCB8NsLdJOFgKFhkRJbJvtM6QWV00mWi1FfIo8ZZpupYKjvxae1OSzOPbjyhEDVi2MNjfipzblyMjk9eO9meNKUJ3K+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKXJoD3V; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKXJoD3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728624878; x=1760160878;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+1Oxg2KD3Wc6rz5kN6jZmUPo8IGhAIV8pkcpyE4JhM=;
  b=iKXJoD3VYO8p+7Uhn6EEXsVwSaJ0tv1hszkupU1UYWc7fAOs23ITim7y
   39Hu2MnoRSInAqExh1g4IyjX9Awl9INPHH9iof2NeHmz6fm7IyTOf295o
   +NJzE0wR++UeHkhcNXHPU3vovVdq32P9Ad84yR+98lXMWcg+suFubmOAy
   iw3Z10rqK5UZKL6bQw+GBcNNa//mg4xR8oZe27e8rSFrIUO/ba1lBfOM1
   ZU0aQSIDOYFhDI1M562bbKQWV/yWJV7Lm2zHLXe9se844R5UdmWaywt0e
   Uut8WP0zNs3NoKzp/qupDpphdVoL+7EQKYWZ5+RpOFasgZgCVJipzxbXQ
   A==;
X-CSE-ConnectionGUID: rEjsM0YdTeKoGkATdw196A==
X-CSE-MsgGUID: g38dApfETDKI8atNiEqH7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28145550"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="28145550"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:37 -0700
X-CSE-ConnectionGUID: l8LqQW78SdCQhamZTN7F+A==
X-CSE-MsgGUID: uK8SRVV0Rs+t7V6zKqDdQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77018399"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.110])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:37 -0700
Subject: [PATCH 5/5] cxl/test: Improve init-order fidelity relative to
 real-world systems
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Date: Thu, 10 Oct 2024 22:34:35 -0700
Message-ID: <172862487394.2150669.13859971851815282473.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The investigation of an initialization failure [1] highlighted that
cxl_test does not reflect the init-order of real world systems. The
expected order is root/bus first then async probing of the memory
devices.

Fix up cxl_test to reflect that order. While it did not reproduce the
initial bug report (since that is dependent on built-in vs modular
builds), it did reveal a separate latent bug in the subsystem's decoder
shutdown flow. Fix for that sent separately.

Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |  186 +++++++++++++++++++++++-------------------
 tools/testing/cxl/test/mem.c |    1 
 2 files changed, 104 insertions(+), 83 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index c5bbd89b3192..050725afa45d 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1058,7 +1058,7 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 #define SZ_64G (SZ_32G * 2)
 #endif
 
-static __init int cxl_rch_init(void)
+static __init int cxl_rch_topo_init(void)
 {
 	int rc, i;
 
@@ -1086,30 +1086,8 @@ static __init int cxl_rch_init(void)
 			goto err_bridge;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
-		int idx = NR_MEM_MULTI + NR_MEM_SINGLE + i;
-		struct platform_device *rch = cxl_rch[i];
-		struct platform_device *pdev;
-
-		pdev = platform_device_alloc("cxl_rcd", idx);
-		if (!pdev)
-			goto err_mem;
-		pdev->dev.parent = &rch->dev;
-		set_dev_node(&pdev->dev, i % 2);
-
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_mem;
-		}
-		cxl_rcd[i] = pdev;
-	}
-
 	return 0;
 
-err_mem:
-	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_rcd[i]);
 err_bridge:
 	for (i = ARRAY_SIZE(cxl_rch) - 1; i >= 0; i--) {
 		struct platform_device *pdev = cxl_rch[i];
@@ -1123,12 +1101,10 @@ static __init int cxl_rch_init(void)
 	return rc;
 }
 
-static void cxl_rch_exit(void)
+static void cxl_rch_topo_exit(void)
 {
 	int i;
 
-	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_rcd[i]);
 	for (i = ARRAY_SIZE(cxl_rch) - 1; i >= 0; i--) {
 		struct platform_device *pdev = cxl_rch[i];
 
@@ -1139,7 +1115,7 @@ static void cxl_rch_exit(void)
 	}
 }
 
-static __init int cxl_single_init(void)
+static __init int cxl_single_topo_init(void)
 {
 	int i, rc;
 
@@ -1224,29 +1200,8 @@ static __init int cxl_single_init(void)
 		cxl_swd_single[i] = pdev;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
-		struct platform_device *dport = cxl_swd_single[i];
-		struct platform_device *pdev;
-
-		pdev = platform_device_alloc("cxl_mem", NR_MEM_MULTI + i);
-		if (!pdev)
-			goto err_mem;
-		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
-
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_mem;
-		}
-		cxl_mem_single[i] = pdev;
-	}
-
 	return 0;
 
-err_mem:
-	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem_single[i]);
 err_dport:
 	for (i = ARRAY_SIZE(cxl_swd_single) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_swd_single[i]);
@@ -1269,12 +1224,10 @@ static __init int cxl_single_init(void)
 	return rc;
 }
 
-static void cxl_single_exit(void)
+static void cxl_single_topo_exit(void)
 {
 	int i;
 
-	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem_single[i]);
 	for (i = ARRAY_SIZE(cxl_swd_single) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_swd_single[i]);
 	for (i = ARRAY_SIZE(cxl_swu_single) - 1; i >= 0; i--)
@@ -1291,6 +1244,91 @@ static void cxl_single_exit(void)
 	}
 }
 
+static void cxl_mem_exit(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_rcd[i]);
+	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem_single[i]);
+	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem[i]);
+}
+
+static int cxl_mem_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
+		struct platform_device *dport = cxl_switch_dport[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_mem", i);
+		if (!pdev)
+			goto err_mem;
+		pdev->dev.parent = &dport->dev;
+		set_dev_node(&pdev->dev, i % 2);
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_mem;
+		}
+		cxl_mem[i] = pdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
+		struct platform_device *dport = cxl_swd_single[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_mem", NR_MEM_MULTI + i);
+		if (!pdev)
+			goto err_single;
+		pdev->dev.parent = &dport->dev;
+		set_dev_node(&pdev->dev, i % 2);
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_single;
+		}
+		cxl_mem_single[i] = pdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
+		int idx = NR_MEM_MULTI + NR_MEM_SINGLE + i;
+		struct platform_device *rch = cxl_rch[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_rcd", idx);
+		if (!pdev)
+			goto err_rcd;
+		pdev->dev.parent = &rch->dev;
+		set_dev_node(&pdev->dev, i % 2);
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_rcd;
+		}
+		cxl_rcd[i] = pdev;
+	}
+
+	return 0;
+
+err_rcd:
+	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_rcd[i]);
+err_single:
+	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem_single[i]);
+err_mem:
+	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem[i]);
+	return rc;
+}
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
@@ -1403,29 +1441,11 @@ static __init int cxl_test_init(void)
 		cxl_switch_dport[i] = pdev;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
-		struct platform_device *dport = cxl_switch_dport[i];
-		struct platform_device *pdev;
-
-		pdev = platform_device_alloc("cxl_mem", i);
-		if (!pdev)
-			goto err_mem;
-		pdev->dev.parent = &dport->dev;
-		set_dev_node(&pdev->dev, i % 2);
-
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_mem;
-		}
-		cxl_mem[i] = pdev;
-	}
-
-	rc = cxl_single_init();
+	rc = cxl_single_topo_init();
 	if (rc)
-		goto err_mem;
+		goto err_dport;
 
-	rc = cxl_rch_init();
+	rc = cxl_rch_topo_init();
 	if (rc)
 		goto err_single;
 
@@ -1438,19 +1458,20 @@ static __init int cxl_test_init(void)
 
 	rc = platform_device_add(cxl_acpi);
 	if (rc)
-		goto err_add;
+		goto err_root;
+
+	rc = cxl_mem_init();
+	if (rc)
+		goto err_root;
 
 	return 0;
 
-err_add:
+err_root:
 	platform_device_put(cxl_acpi);
 err_rch:
-	cxl_rch_exit();
+	cxl_rch_topo_exit();
 err_single:
-	cxl_single_exit();
-err_mem:
-	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem[i]);
+	cxl_single_topo_exit();
 err_dport:
 	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_switch_dport[i]);
@@ -1482,11 +1503,10 @@ static __exit void cxl_test_exit(void)
 {
 	int i;
 
+	cxl_mem_exit();
 	platform_device_unregister(cxl_acpi);
-	cxl_rch_exit();
-	cxl_single_exit();
-	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem[i]);
+	cxl_rch_topo_exit();
+	cxl_single_topo_exit();
 	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_switch_dport[i]);
 	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index ad5c4c18c5c6..71916e0e1546 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1673,6 +1673,7 @@ static struct platform_driver cxl_mock_mem_driver = {
 		.name = KBUILD_MODNAME,
 		.dev_groups = cxl_mock_mem_groups,
 		.groups = cxl_mock_mem_core_groups,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 

