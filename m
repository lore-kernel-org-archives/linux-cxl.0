Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1F28DC4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898963; cv=none; b=OkU01YEwQWAHH1WkFNvkuA8PoYJEZuOfepvIqDNgAfsbFQl9ZjDJNgSNqakws2y4LfI0gmLrQcVxwqDY7bkHLm27D4ilT423k38wAMRkivZ4lwCnevb5AXbQngIPK3tShKd8/kCCNlyBPlUU3drRnkb/DM/20Uy4E2rjRMevHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898963; c=relaxed/simple;
	bh=uMoxdv7aYh976+rSeiABIvz1ca0WrL4OBqsrJCMz2bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8Xv3kYBtv2VqbKBy9bXQohq8Zv0yjB+x8hYpZBPOq2UqYw1Pbc7MOedUiqEVMgDw3lKnQrM81+mpqZ1SpISeUcdnSt0lOtuu2l3jSPj4ppAnpDsmnV3fjD6TX9z0X8mn9/ynM/Cmve4IiUxuqD+hEVlAViVSq0RALnFUQwdP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F6C19425;
	Wed, 22 Apr 2026 23:02:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 3/7] cxl/test: Refactor platform device enumerations
Date: Wed, 22 Apr 2026 16:02:33 -0700
Message-ID: <20260422230237.2599333-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422230237.2599333-1-dave.jiang@intel.com>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
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
 tools/testing/cxl/test/cxl.c | 327 +++++++++++++++++++++++------------
 1 file changed, 217 insertions(+), 110 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 903223013e41..5fd73f0634c6 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1833,10 +1833,207 @@ static struct attribute *cxl_acpi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cxl_acpi);
 
+static void host_bridges_remove(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_host_bridge[i];
+
+		if (!pdev)
+			break;
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
+		if (!pdev)
+			goto err_bridge;
+
+		mock_companion(adev, &pdev->dev);
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_bridge;
+		}
+
+		cxl_host_bridge[i] = pdev;
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
+			break;
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
+		if (!pdev)
+			goto err_port;
+
+		pdev->dev.parent = &bridge->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_port;
+		}
+		cxl_root_port[i] = pdev;
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
+	for (int i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_switch_dport[i];
+
+		if (!pdev)
+			break;
+
+		platform_device_unregister(cxl_switch_dport[i]);
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
+		if (!pdev)
+			goto err_uport;
+
+		pdev->dev.parent = &root_port->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_uport;
+		}
+		cxl_switch_uport[i] = pdev;
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
+	for (int i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_switch_uport[i];
+
+		if (!pdev)
+			break;
+
+		platform_device_unregister(cxl_switch_uport[i]);
+	}
+}
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
+		if (!pdev)
+			goto err_dport;
+		pdev->dev.parent = &uport->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_dport;
+		}
+		cxl_switch_dport[i] = pdev;
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
+	cxl_usps_remove();
+	cxl_dsps_remove();
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
 
 	cxl_acpi_test();
 	cxl_core_test();
@@ -1872,86 +2069,21 @@ static __init int cxl_test_init(void)
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
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_bridge;
-		}
-
-		cxl_host_bridge[i] = pdev;
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
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_port;
-		}
-		cxl_root_port[i] = pdev;
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
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_uport;
-		}
-		cxl_switch_uport[i] = pdev;
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
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
-			goto err_dport;
-		}
-		cxl_switch_dport[i] = pdev;
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
@@ -1981,24 +2113,12 @@ static __init int cxl_test_init(void)
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
@@ -2021,26 +2141,13 @@ static void free_decoder_registry(void)
 
 static __exit void cxl_test_exit(void)
 {
-	int i;
-
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
2.53.0

