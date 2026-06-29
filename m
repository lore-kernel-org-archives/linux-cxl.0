Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7B17BA6
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771075; cv=none; b=HWtvwir4nROKtfriC82td4LDBjMJ0UD6lwbhF1oS4wlfiCM+FReOUmB+0gOOPVZudfQRQjAb53AGvz5v0Cghq5rZ/TWfvH97KUHFjI9ivVXzQqPAqwZpLPgmz3P5HNKXI9yEXubdZgF1uRS5e1FwbjGQzozNUZ1wfBgUfJ6ha3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771075; c=relaxed/simple;
	bh=ue0vTF+lqiU8CrUIFX7RcOlbNIqiYpKZiGGBe+mqI2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlsTvTzBJ9EvxmhREjXEzGuoMHhpzi3NprVYFlRr9qmAxqa+0e6thVL/AGnxa4atTPYxj1gMXcByKRdaIWh9A79sY9uW/N5XMI24DG1pE/r14KK+avYRghR92LpyecvdKl+yNijTjEHc5v7MHzGZEPDPMO3ccLqDBLq2XnKgYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37E91F00A3A;
	Mon, 29 Jun 2026 22:11:13 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v7 3/7] cxl/test: Refactor platform device enumerations
Date: Mon, 29 Jun 2026 15:11:00 -0700
Message-ID: <20260629221104.3891733-4-dave.jiang@intel.com>
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

Split all the host bridges, rootports, upstream and downstream ports
enumerations to separate helper functions. This should make adding
type2 hierarchy easier later on.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 312 ++++++++++++++++++++++++-----------
 1 file changed, 214 insertions(+), 98 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 32964420e470..8abe066080bc 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1868,10 +1868,204 @@ static bool __init have_multiple_modparms(void)
 	return count > 1;
 }
 
+static void host_bridges_remove(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_host_bridge[i];
+
+		if (!pdev)
+			continue;
+
+		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
+		platform_device_unregister(cxl_host_bridge[i]);
+	}
+}
+
+static int host_bridges_populate(void)
+{
+	int rc = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
+		struct acpi_device *adev = &host_bridge[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_host_bridge", i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err_bridge;
+		}
+
+		mock_companion(adev, &pdev->dev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_host_bridge[i]);
+		if (rc)
+			goto err_bridge;
+
+		mock_pci_bus[i].bridge = &pdev->dev;
+		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
+				       "physical_node");
+		if (rc)
+			goto err_bridge;
+	}
+
+	return 0;
+
+err_bridge:
+	host_bridges_remove();
+	return rc;
+}
+
+static void cxl_rootports_remove(void)
+{
+	for (int i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_root_port[i];
+
+		if (!pdev)
+			continue;
+
+		platform_device_unregister(pdev);
+	}
+}
+
+static int cxl_rootports_populate(void)
+{
+	int rc = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(cxl_root_port); i++) {
+		struct platform_device *bridge =
+			cxl_host_bridge[i % ARRAY_SIZE(cxl_host_bridge)];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_root_port", i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err_port;
+		}
+
+		pdev->dev.parent = &bridge->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_root_port[i]);
+		if (rc)
+			goto err_port;
+	}
+
+	return 0;
+
+err_port:
+	cxl_rootports_remove();
+	return rc;
+}
+
+static void cxl_usps_remove(void)
+{
+	for (int i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_switch_uport[i];
+
+		if (!pdev)
+			continue;
+
+		platform_device_unregister(cxl_switch_uport[i]);
+	}
+}
+
+static int cxl_usps_populate(void)
+{
+	int rc = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(cxl_switch_uport); i++) {
+		struct platform_device *root_port = cxl_root_port[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_uport", i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err_uport;
+		}
+
+		pdev->dev.parent = &root_port->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_uport[i]);
+		if (rc)
+			goto err_uport;
+	}
+
+	return 0;
+
+err_uport:
+	cxl_usps_remove();
+	return rc;
+}
+
+static void cxl_dsps_remove(void)
+{
+	for (int i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_switch_dport[i];
+
+		if (!pdev)
+			continue;
+
+		platform_device_unregister(cxl_switch_dport[i]);
+	}
+}
+
+
+static int cxl_dsps_populate(void)
+{
+	int rc = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
+		struct platform_device *uport =
+			cxl_switch_uport[i % ARRAY_SIZE(cxl_switch_uport)];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_dport", i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err_dport;
+		}
+		pdev->dev.parent = &uport->dev;
+
+		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_dport[i]);
+		if (rc)
+			goto err_dport;
+	}
+
+	return 0;
+
+err_dport:
+	cxl_dsps_remove();
+	return rc;
+}
+
+static void cxl_switches_remove(void)
+{
+	cxl_dsps_remove();
+	cxl_usps_remove();
+}
+
+static int cxl_switches_populate(void)
+{
+	int rc;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
+	rc = cxl_usps_populate();
+	if (rc)
+		return rc;
+
+	rc = cxl_dsps_populate();
+	if (rc) {
+		cxl_usps_remove();
+		return rc;
+	}
+
+	return 0;
+}
+
 static __init int cxl_test_init(void)
 {
-	int rc, i;
 	struct range mappable;
+	int rc;
 
 	/* Enforce a single module param active at a time */
 	if (have_multiple_modparms())
@@ -1917,74 +2111,21 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_populate;
 
-	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
-		struct acpi_device *adev = &host_bridge[i];
-		struct platform_device *pdev;
+	rc = host_bridges_populate();
+	if (rc)
+		goto err_populate;
 
-		pdev = platform_device_alloc("cxl_host_bridge", i);
-		if (!pdev)
-			goto err_bridge;
+	rc = cxl_rootports_populate();
+	if (rc)
+		goto err_host_bridges;
 
-		mock_companion(adev, &pdev->dev);
-		rc = cxl_mock_platform_device_add(pdev, &cxl_host_bridge[i]);
-		if (rc)
-			goto err_bridge;
-
-		mock_pci_bus[i].bridge = &pdev->dev;
-		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
-				       "physical_node");
-		if (rc)
-			goto err_bridge;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(cxl_root_port); i++) {
-		struct platform_device *bridge =
-			cxl_host_bridge[i % ARRAY_SIZE(cxl_host_bridge)];
-		struct platform_device *pdev;
-
-		pdev = platform_device_alloc("cxl_root_port", i);
-		if (!pdev)
-			goto err_port;
-		pdev->dev.parent = &bridge->dev;
-
-		rc = cxl_mock_platform_device_add(pdev, &cxl_root_port[i]);
-		if (rc)
-			goto err_port;
-	}
-
-	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
-	for (i = 0; i < ARRAY_SIZE(cxl_switch_uport); i++) {
-		struct platform_device *root_port = cxl_root_port[i];
-		struct platform_device *pdev;
-
-		pdev = platform_device_alloc("cxl_switch_uport", i);
-		if (!pdev)
-			goto err_uport;
-		pdev->dev.parent = &root_port->dev;
-
-		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_uport[i]);
-		if (rc)
-			goto err_uport;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
-		struct platform_device *uport =
-			cxl_switch_uport[i % ARRAY_SIZE(cxl_switch_uport)];
-		struct platform_device *pdev;
-
-		pdev = platform_device_alloc("cxl_switch_dport", i);
-		if (!pdev)
-			goto err_dport;
-		pdev->dev.parent = &uport->dev;
-
-		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_dport[i]);
-		if (rc)
-			goto err_dport;
-	}
+	rc = cxl_switches_populate();
+	if (rc)
+		goto err_root_ports;
 
 	rc = cxl_single_topo_init();
 	if (rc)
-		goto err_dport;
+		goto err_switches;
 
 	rc = cxl_rch_topo_init();
 	if (rc)
@@ -2020,24 +2161,12 @@ static __init int cxl_test_init(void)
 	cxl_rch_topo_exit();
 err_single:
 	cxl_single_topo_exit();
-err_dport:
-	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_switch_dport[i]);
-err_uport:
-	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_switch_uport[i]);
-err_port:
-	for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_root_port[i]);
-err_bridge:
-	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
-		struct platform_device *pdev = cxl_host_bridge[i];
-
-		if (!pdev)
-			continue;
-		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
-		platform_device_unregister(cxl_host_bridge[i]);
-	}
+err_switches:
+	cxl_switches_remove();
+err_root_ports:
+	cxl_rootports_remove();
+err_host_bridges:
+	host_bridges_remove();
 err_populate:
 	depopulate_all_mock_resources();
 err_gen_pool_add:
@@ -2060,27 +2189,14 @@ static void free_decoder_registry(void)
 
 static __exit void cxl_test_exit(void)
 {
-	int i;
-
 	hmem_test_exit();
 	cxl_mem_exit();
 	platform_device_unregister(cxl_acpi);
 	cxl_rch_topo_exit();
 	cxl_single_topo_exit();
-	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_switch_dport[i]);
-	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_switch_uport[i]);
-	for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_root_port[i]);
-	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
-		struct platform_device *pdev = cxl_host_bridge[i];
-
-		if (!pdev)
-			continue;
-		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
-		platform_device_unregister(cxl_host_bridge[i]);
-	}
+	cxl_switches_remove();
+	cxl_rootports_remove();
+	host_bridges_remove();
 	depopulate_all_mock_resources();
 	gen_pool_destroy(cxl_mock_pool);
 	unregister_cxl_mock_ops(&cxl_mock_ops);
-- 
2.54.0

