Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51F2836A6
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771077; cv=none; b=Ps//oOdYGirrsifUIDKYZ7ywRaGaakikJ+hSKC026PoxSgysWnLJIguuWtn7GEf/yisFeCG01CEA8hCJj00O66tRFYMJR0UHQpMS3a2UQznEnZ6i93QL/z7BsRiBP+Tpo9eLJIHfwtzsMJ+6b+mVKmxnZbozqsqme0diUZUljL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771077; c=relaxed/simple;
	bh=kppvEbHe92keDfFXb33Fmt815RKTMv0RhscYtUowkrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCvGvL/EYmS3caADNRB+rQu9rVjyJ1tPTwvamAwb6c+UZ/1UVXpz3k7sN6GoR2Wpgqqae+FW3Gi52a4kFrp5WD+ND9tAIkjt0MZYWWLLKB884Z+YgBCWqgxt+N7DMWfM2Stpl0d2pjQSP2j408Jclv/ve+JVLYEKdRqv+zNd7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE121F00A3A;
	Mon, 29 Jun 2026 22:11:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v7 5/7] cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
Date: Mon, 29 Jun 2026 15:11:02 -0700
Message-ID: <20260629221104.3891733-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629221104.3891733-1-dave.jiang@intel.com>
References: <20260629221104.3891733-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set rc = -ENOMEM at every platform_device_alloc() failure site in
cxl_rch_topo_init(), cxl_single_topo_init() and cxl_test_init() so the
failure is propagated and the module load aborts cleanly.

The cxl_acpi allocation site originates in the commit below, while the
host-bridge/root-port/uport/dport allocation sites fixed here were added
later in the single-host and RCH topology configs.

Fixes: 67dcdd4d3b83 ("tools/testing/cxl: Introduce a mocked-up CXL port hierarchy")
Fixes: e41c8452b9b2 ("tools/testing/cxl: Add a single-port host-bridge regression config")
Fixes: c9435dbee119 ("tools/testing/cxl: Add an RCH topology")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 801d42ac1bad..7aafdc03230d 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1587,8 +1587,10 @@ static __init int cxl_rch_topo_init(void)
 		struct platform_device *pdev;
 
 		pdev = platform_device_alloc("cxl_host_bridge", idx);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_bridge;
+		}
 
 		mock_companion(adev, &pdev->dev);
 		rc = cxl_mock_platform_device_add(pdev, &cxl_rch[i]);
@@ -1642,8 +1644,10 @@ static __init int cxl_single_topo_init(void)
 
 		pdev = platform_device_alloc("cxl_host_bridge",
 					     NR_CXL_HOST_BRIDGES + i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_bridge;
+		}
 
 		mock_companion(adev, &pdev->dev);
 		rc = cxl_mock_platform_device_add(pdev, &cxl_hb_single[i]);
@@ -1664,8 +1668,10 @@ static __init int cxl_single_topo_init(void)
 
 		pdev = platform_device_alloc("cxl_root_port",
 					     NR_MULTI_ROOT + i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_port;
+		}
 		pdev->dev.parent = &bridge->dev;
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_root_single[i]);
@@ -1679,8 +1685,10 @@ static __init int cxl_single_topo_init(void)
 
 		pdev = platform_device_alloc("cxl_switch_uport",
 					     NR_MULTI_ROOT + i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_uport;
+		}
 		pdev->dev.parent = &root_port->dev;
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_swu_single[i]);
@@ -1695,8 +1703,10 @@ static __init int cxl_single_topo_init(void)
 
 		pdev = platform_device_alloc("cxl_switch_dport",
 					     i + NR_MEM_MULTI);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_dport;
+		}
 		pdev->dev.parent = &uport->dev;
 
 		rc = cxl_mock_platform_device_add(pdev, &cxl_swd_single[i]);
@@ -2290,8 +2300,10 @@ static __init int cxl_test_init(void)
 		goto err_populate;
 
 	cxl_acpi = platform_device_alloc("cxl_acpi", 0);
-	if (!cxl_acpi)
+	if (!cxl_acpi) {
+		rc = -ENOMEM;
 		goto err_topo;
+	}
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
-- 
2.54.0

