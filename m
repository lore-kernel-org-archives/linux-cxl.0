Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8B38E8AC
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764849; cv=none; b=aeFBXdaIf41aOiojpAk/lXq2stSMB4QhyIErdFAfSKohYIkMT7ofBH2YplpB8qVvz1xWCPt0KvRb0dt8vmNyS29FL/ohzPmPqvIVIrp5Kgo8PA9Wiirqy3iaa7/F1+HYQT8Vje3HT6yfMvCIQdP0ZmxD/5rqJYpET5ZUhUcQuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764849; c=relaxed/simple;
	bh=fyJt9UjDdWAEeKBoU3T1/SIkUSFy90pNHnO8fF5VLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7GKzn0MtZVhfR4PRbupGXDJq56gWgakd3v7MKbDVCpNZyVotZ6yfwe1h+YqaFZkaj3KSmqozYUJ4turPPEQYyIjGrIMFK/BHtZDHTRMXa0iUho2w0W5hRxb0Euda2RF+0IigJUuMk6Nn3Zycqf8H/2XI6Yna7mivlvFWu4VdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6390C1F000E9;
	Mon, 29 Jun 2026 20:27:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v6 4/6] cxl/test: Add hierarchy enumeration support for type2 device
Date: Mon, 29 Jun 2026 13:27:18 -0700
Message-ID: <20260629202720.3658117-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629202720.3658117-1-dave.jiang@intel.com>
References: <20260629202720.3658117-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enumeration of type2 device hierarchy in cxl-test. The type2 device
is setup to be directly attached to a root port instead of rp -> switch
-> device that type3 hierarchy is setup..

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 240 ++++++++++++++++++++++++++++-------
 1 file changed, 193 insertions(+), 47 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8abe066080bc..1eac06ad4660 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -28,6 +28,7 @@ static bool type2_test;
 #define NR_CXL_SWITCH_PORTS 2
 #define NR_CXL_PORT_DECODERS 8
 #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
+#define NR_CXL_TYPE2_ACCEL 1
 
 #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
 static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
@@ -1747,19 +1748,93 @@ static void cxl_single_topo_exit(void)
 	}
 }
 
+static void cxl_type3_mem_exit(void)
+{
+	struct platform_device *pdev;
+	int i;
+
+	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--) {
+		pdev = cxl_rcd[i];
+		if (!pdev)
+			continue;
+		platform_device_unregister(cxl_rcd[i]);
+	}
+
+	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--) {
+		pdev = cxl_mem_single[i];
+		if (!pdev)
+			continue;
+		platform_device_unregister(cxl_mem_single[i]);
+	}
+
+	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--) {
+		pdev = cxl_mem[i];
+		if (!pdev)
+			continue;
+		platform_device_unregister(pdev);
+	}
+}
+
+static void cxl_type2_mem_exit(void)
+{
+	for (int i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_mem[i];
+
+		if (!pdev)
+			continue;
+		platform_device_unregister(pdev);
+	}
+}
+
 static void cxl_mem_exit(void)
 {
-	int i;
-
-	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_rcd[i]);
-	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem_single[i]);
-	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem[i]);
+	if (type2_test) {
+		cxl_type2_mem_exit();
+		return;
+	}
+
+	cxl_type3_mem_exit();
+}
+
+static int cxl_type2_mem_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < NR_CXL_TYPE2_ACCEL; i++) {
+		struct platform_device *dport = cxl_root_port[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_type2_accel", i);
+		if (!pdev) {
+			rc = -ENOMEM;
+			goto err_mem;
+		}
+		pdev->dev.parent = &dport->dev;
+		set_dev_node(&pdev->dev, i % 2);
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			rc = -ENOMEM;
+			platform_device_put(pdev);
+			goto err_mem;
+		}
+		cxl_mem[i] = pdev;
+	}
+
+	return 0;
+
+err_mem:
+	for (i = NR_CXL_TYPE2_ACCEL - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_mem[i];
+
+		if (!pdev)
+			continue;
+		platform_device_unregister(pdev);
+	}
+	return rc;
 }
 
-static int cxl_mem_init(void)
+static int cxl_type3_mem_init(void)
 {
 	int i, rc;
 
@@ -1768,8 +1843,10 @@ static int cxl_mem_init(void)
 		struct platform_device *pdev;
 
 		pdev = platform_device_alloc("cxl_mem", i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_mem;
+		}
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
@@ -1783,8 +1860,10 @@ static int cxl_mem_init(void)
 		struct platform_device *pdev;
 
 		pdev = platform_device_alloc("cxl_mem", NR_MEM_MULTI + i);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_single;
+		}
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
@@ -1799,8 +1878,10 @@ static int cxl_mem_init(void)
 		struct platform_device *pdev;
 
 		pdev = platform_device_alloc("cxl_rcd", idx);
-		if (!pdev)
+		if (!pdev) {
+			rc = -ENOMEM;
 			goto err_rcd;
+		}
 		pdev->dev.parent = &rch->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
@@ -1823,6 +1904,13 @@ static int cxl_mem_init(void)
 	return rc;
 }
 
+static int cxl_mem_init(void)
+{
+	if (type2_test)
+		return cxl_type2_mem_init();
+	return cxl_type3_mem_init();
+}
+
 static ssize_t
 decoder_reset_preserve_registry_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -2062,6 +2150,92 @@ static int cxl_switches_populate(void)
 	return 0;
 }
 
+static void cxl_type2_topo_exit(void)
+{
+	cxl_rootports_remove();
+	host_bridges_remove();
+}
+
+static int cxl_type2_topo_init(void)
+{
+	int rc;
+
+	rc = host_bridges_populate();
+	if (rc)
+		return rc;
+
+	rc = cxl_rootports_populate();
+	if (rc) {
+		host_bridges_remove();
+		return rc;
+	}
+
+	return 0;
+}
+
+static void cxl_type3_topo_exit(void)
+{
+	cxl_rch_topo_exit();
+	cxl_single_topo_exit();
+	cxl_switches_remove();
+	cxl_rootports_remove();
+	host_bridges_remove();
+}
+
+static int cxl_type3_topo_init(void)
+{
+	int rc;
+
+	rc = host_bridges_populate();
+	if (rc)
+		return rc;
+
+	rc = cxl_rootports_populate();
+	if (rc)
+		goto err_host_bridges;
+
+	rc = cxl_switches_populate();
+	if (rc)
+		goto err_root_ports;
+
+	rc = cxl_single_topo_init();
+	if (rc)
+		goto err_switches;
+
+	rc = cxl_rch_topo_init();
+	if (rc)
+		goto err_single;
+
+	return 0;
+
+err_single:
+	cxl_single_topo_exit();
+err_switches:
+	cxl_switches_remove();
+err_root_ports:
+	cxl_rootports_remove();
+err_host_bridges:
+	host_bridges_remove();
+	return rc;
+}
+
+static void cxl_topo_exit(void)
+{
+	if (type2_test) {
+		cxl_type2_topo_exit();
+		return;
+	}
+
+	cxl_type3_topo_exit();
+}
+
+static int cxl_topo_init(void)
+{
+	if (type2_test)
+		return cxl_type2_topo_init();
+	return cxl_type3_topo_init();
+}
+
 static __init int cxl_test_init(void)
 {
 	struct range mappable;
@@ -2111,29 +2285,13 @@ static __init int cxl_test_init(void)
 	if (rc)
 		goto err_populate;
 
-	rc = host_bridges_populate();
+	rc = cxl_topo_init();
 	if (rc)
 		goto err_populate;
 
-	rc = cxl_rootports_populate();
-	if (rc)
-		goto err_host_bridges;
-
-	rc = cxl_switches_populate();
-	if (rc)
-		goto err_root_ports;
-
-	rc = cxl_single_topo_init();
-	if (rc)
-		goto err_switches;
-
-	rc = cxl_rch_topo_init();
-	if (rc)
-		goto err_single;
-
 	cxl_acpi = platform_device_alloc("cxl_acpi", 0);
 	if (!cxl_acpi)
-		goto err_rch;
+		goto err_topo;
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
@@ -2141,7 +2299,7 @@ static __init int cxl_test_init(void)
 
 	rc = cxl_mock_platform_device_add(cxl_acpi, NULL);
 	if (rc)
-		goto err_rch;
+		goto err_topo;
 
 	rc = cxl_mem_init();
 	if (rc)
@@ -2156,17 +2314,9 @@ static __init int cxl_test_init(void)
 err_mem:
 	cxl_mem_exit();
 err_root:
-	platform_device_unregister(cxl_acpi);
-err_rch:
-	cxl_rch_topo_exit();
-err_single:
-	cxl_single_topo_exit();
-err_switches:
-	cxl_switches_remove();
-err_root_ports:
-	cxl_rootports_remove();
-err_host_bridges:
-	host_bridges_remove();
+	platform_device_put(cxl_acpi);
+err_topo:
+	cxl_topo_exit();
 err_populate:
 	depopulate_all_mock_resources();
 err_gen_pool_add:
@@ -2192,11 +2342,7 @@ static __exit void cxl_test_exit(void)
 	hmem_test_exit();
 	cxl_mem_exit();
 	platform_device_unregister(cxl_acpi);
-	cxl_rch_topo_exit();
-	cxl_single_topo_exit();
-	cxl_switches_remove();
-	cxl_rootports_remove();
-	host_bridges_remove();
+	cxl_topo_exit();
 	depopulate_all_mock_resources();
 	gen_pool_destroy(cxl_mock_pool);
 	unregister_cxl_mock_ops(&cxl_mock_ops);
-- 
2.54.0

