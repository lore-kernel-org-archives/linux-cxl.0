Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8220323
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647851; cv=none; b=n4DPxTCPf/Un46TMPm+oIDB81pZQ9Yh1lc9izhIFVmSXRuuIGmVcwdh9oj9jSahSKGmtTyZ4Q0X/p1eHEGoQBERxQ0o95zRY6OLBrXF9vslFdHUBqlzgy6gQCLugGxWi1wAOjh/m46ekok5ShIWuX/9DltYi5CgS1a4O4si0sqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647851; c=relaxed/simple;
	bh=8+1Oxg2KD3Wc6rz5kN6jZmUPo8IGhAIV8pkcpyE4JhM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tevb8shG468siUYekbtOWU/oMoVJ176r/SO6nuA3mQ7XI4BLT4fmNqO2XcuZCtcDluu+jI9IgGE2zEYCtbN0v0GxoTyzlouYJuCqrsnO5nzpEeV4df9JJ4TRZitlEA10uIGlaJCAUHV3IIaVontyMR3lZiv7kZEJ5uZVtaQKUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncbiu9w8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncbiu9w8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647849; x=1761183849;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+1Oxg2KD3Wc6rz5kN6jZmUPo8IGhAIV8pkcpyE4JhM=;
  b=ncbiu9w88SNqV6VBhGatP1BrdrcI5vIwVwEvjwSnN2pbS7Q0sbXWvNO7
   NxhROOFvTTL3tG+LZ4q5fUfJiTHuBS6pDPEZN+It5ZFUNPsFQs0o89+fy
   CrU9i0pGHSDZS+wLVa/Sdpb+RRfSSOeYstLcw+IIPzM2zALLmiacOVSdK
   bCncEfIzjFYx88uFFPcDKGbok96igdAUQjLLrePZQ9cgeZjnEqWl/qTWF
   lEv1+5ATqMK8/+Y03XTbdpVOnLh+l/aMwb4raSzdQeSt/3a3hMdOKVTso
   JTEKJFN546VLttfUcBOxxkXYY26/N+oiWu3C1P6y4/D2ojbTuSiUOduYF
   A==;
X-CSE-ConnectionGUID: IA7DMlk4QLusni/iktDdNA==
X-CSE-MsgGUID: mQLnjKeGQFaPy/VaPS8G4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46675968"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46675968"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:44:09 -0700
X-CSE-ConnectionGUID: AudK1LvdTQucC9r4+nZ97g==
X-CSE-MsgGUID: KeRn4tcrTO6ckgcvoN6Zvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110844108"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:44:08 -0700
Subject: [PATCH v2 6/6] cxl/test: Improve init-order fidelity relative to
 real-world systems
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 22 Oct 2024 18:44:06 -0700
Message-ID: <172964784521.81806.15791069994065969243.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
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
 

