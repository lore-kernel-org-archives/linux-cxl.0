Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A63D88EC
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226665; cv=none; b=cNFUeWnImOYJiNnqZ3EESTxhNNyJjwjqhd/coZwrT6lr3q7mo8GaUywekQLicGsdnI2q7lgt8J0yDDMa71B3R4lvZQGZN5WLOndLRbL0bDaH2PtUtc7MJ8Juq5j9r+F1vhN6uMqAvKC3xl5wplN7gcJpAo/HcvrADXXVgvuWev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226665; c=relaxed/simple;
	bh=7LERdoDrQkm/o20YaZjyaWdYzw0JYpJcbXHufz7abe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+1nxkuYnUHxT8gQnl3Znxn3C789pfMN4r1r2TxD66aBWnUhB1U2tcz5UwPKY96d+GyivDzlE0UTD4q5KTv0lgd1+4x26bH6178VlCr8os4V+1/EOYjkNZts0v6YfoMCJ1slv69ICUgLa7WkLCpslSHMm6O7VHeqFI4QTMFTUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76181F000E9;
	Tue, 19 May 2026 21:37:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v2 3/6] cxl/test: Refactor platform device enumerations
Date: Tue, 19 May 2026 14:37:30 -0700
Message-ID: <20260519213734.69737-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519213734.69737-1-dave.jiang@intel.com>
References: <20260519213734.69737-1-dave.jiang@intel.com>
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
v2:
- Swap cxl_usps_remove() and cxl_dsps_remove(). (Alison)
---
 tools/testing/cxl/test/cxl.c | 328 +++++++++++++++++++++++------------
 1 file changed, 218 insertions(+), 110 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 4893933d6789..e2b5ec8e6982 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1906,10 +1906,208 @@ bool __init have_multiple_modparms(void)
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
@@ -1949,86 +2147,21 @@ static __init int cxl_test_init(void)
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
@@ -2064,24 +2197,12 @@ static __init int cxl_test_init(void)
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
@@ -2104,27 +2225,14 @@ static void free_decoder_registry(void)
 
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

