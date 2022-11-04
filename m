Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB0C43219
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 00:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKDAa5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKDAaz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 20:30:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2111C29
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667521850; x=1699057850;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9UM3gVRBBhgP830ex0rf/GPR+FCSXm58qK2XNyQwxc8=;
  b=N3A/cbL+ciQaP4yXK8si8WspPK9ewZ+gdj0OzTW9//cYUPfTxBneyaA1
   y7tXc+n/A6ZJxLWQH3FUpDy3TICV/+qLMfKuEzG1V2Bu1wl9gwfRkqSnO
   f5PHJaDYpEjIM+wYCA75+pNRivAuAqY2QCWXlA9f41XjrIBOyQPcSFB7D
   xv1UTgzM1oL1IpEbtqBUTYFpt31ixIRpgAP9PdB2vJIR+BcjR2K1Ek1D7
   yO0hO0eKK/ULXceOp/hAOf/YSgLUmBb6TMSbWKg002w3CebRcZ1nduE9/
   B41S4Ra6TJv2hcemBT9thXtJFPX8ODMsvFBUVlBVNU/rHsdy+SlNo3eOK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293165296"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="293165296"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:30:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964151743"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="964151743"
Received: from arunvasu-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.53.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:30:48 -0700
Subject: [PATCH 5/7] tools/testing/cxl: Add a single-port host-bridge
 regression config
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Bobo WL <lmw.bobo@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com
Date:   Thu, 03 Nov 2022 17:30:48 -0700
Message-ID: <166752184838.947915.2167957540894293891.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan reports that region creation fails when a single-port
host-bridge connects to a multi-port switch. Mock up that configuration
so a fix can be tested and regression tested going forward.

Reported-by: Bobo WL <lmw.bobo@gmail.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: http://lore.kernel.org/r/20221010172057.00001559@huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |  297 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 278 insertions(+), 19 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 133e4c73d370..7edce12fd2ce 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -12,30 +12,62 @@
 #include "mock.h"
 
 #define NR_CXL_HOST_BRIDGES 2
+#define NR_CXL_SINGLE_HOST 1
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_SWITCH_PORTS 2
 #define NR_CXL_PORT_DECODERS 8
 
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
-static struct platform_device
-	*cxl_root_port[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS];
-static struct platform_device
-	*cxl_switch_uport[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS];
-static struct platform_device
-	*cxl_switch_dport[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS *
-			  NR_CXL_SWITCH_PORTS];
-struct platform_device
-	*cxl_mem[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS * NR_CXL_SWITCH_PORTS];
+#define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
+static struct platform_device *cxl_root_port[NR_MULTI_ROOT];
+static struct platform_device *cxl_switch_uport[NR_MULTI_ROOT];
+#define NR_MEM_MULTI \
+	(NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS * NR_CXL_SWITCH_PORTS)
+static struct platform_device *cxl_switch_dport[NR_MEM_MULTI];
+
+static struct platform_device *cxl_hb_single[NR_CXL_SINGLE_HOST];
+static struct platform_device *cxl_root_single[NR_CXL_SINGLE_HOST];
+static struct platform_device *cxl_swu_single[NR_CXL_SINGLE_HOST];
+#define NR_MEM_SINGLE (NR_CXL_SINGLE_HOST * NR_CXL_SWITCH_PORTS)
+static struct platform_device *cxl_swd_single[NR_MEM_SINGLE];
+
+struct platform_device *cxl_mem[NR_MEM_MULTI];
+struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
+
+
+static inline bool is_multi_bridge(struct device *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++)
+		if (&cxl_host_bridge[i]->dev == dev)
+			return true;
+	return false;
+}
+
+static inline bool is_single_bridge(struct device *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_hb_single); i++)
+		if (&cxl_hb_single[i]->dev == dev)
+			return true;
+	return false;
+}
 
 static struct acpi_device acpi0017_mock;
-static struct acpi_device host_bridge[NR_CXL_HOST_BRIDGES] = {
+static struct acpi_device host_bridge[NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST] = {
 	[0] = {
 		.handle = &host_bridge[0],
 	},
 	[1] = {
 		.handle = &host_bridge[1],
 	},
+	[2] = {
+		.handle = &host_bridge[2],
+	},
+
 };
 
 static bool is_mock_dev(struct device *dev)
@@ -45,6 +77,9 @@ static bool is_mock_dev(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++)
 		if (dev == &cxl_mem[i]->dev)
 			return true;
+	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++)
+		if (dev == &cxl_mem_single[i]->dev)
+			return true;
 	if (dev == &cxl_acpi->dev)
 		return true;
 	return false;
@@ -66,7 +101,7 @@ static bool is_mock_adev(struct acpi_device *adev)
 
 static struct {
 	struct acpi_table_cedt cedt;
-	struct acpi_cedt_chbs chbs[NR_CXL_HOST_BRIDGES];
+	struct acpi_cedt_chbs chbs[NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST];
 	struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[1];
@@ -83,6 +118,10 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[2];
 	} cfmws3;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[1];
+	} cfmws4;
 } __packed mock_cedt = {
 	.cedt = {
 		.header = {
@@ -107,6 +146,14 @@ static struct {
 		.uid = 1,
 		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
 	},
+	.chbs[2] = {
+		.header = {
+			.type = ACPI_CEDT_TYPE_CHBS,
+			.length = sizeof(mock_cedt.chbs[0]),
+		},
+		.uid = 2,
+		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
+	},
 	.cfmws0 = {
 		.cfmws = {
 			.header = {
@@ -167,13 +214,29 @@ static struct {
 		},
 		.target = { 0, 1, },
 	},
+	.cfmws4 = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws4),
+			},
+			.interleave_ways = 0,
+			.granularity = 4,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
+			.qtg_id = 4,
+			.window_size = SZ_256M * 4UL,
+		},
+		.target = { 2 },
+	},
 };
 
-struct acpi_cedt_cfmws *mock_cfmws[4] = {
+struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[0] = &mock_cedt.cfmws0.cfmws,
 	[1] = &mock_cedt.cfmws1.cfmws,
 	[2] = &mock_cedt.cfmws2.cfmws,
 	[3] = &mock_cedt.cfmws3.cfmws,
+	[4] = &mock_cedt.cfmws4.cfmws,
 };
 
 struct cxl_mock_res {
@@ -304,6 +367,9 @@ static bool is_mock_bridge(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++)
 		if (dev == &cxl_host_bridge[i]->dev)
 			return true;
+	for (i = 0; i < ARRAY_SIZE(cxl_hb_single); i++)
+		if (dev == &cxl_hb_single[i]->dev)
+			return true;
 	return false;
 }
 
@@ -326,6 +392,18 @@ static bool is_mock_port(struct device *dev)
 		if (dev == &cxl_switch_dport[i]->dev)
 			return true;
 
+	for (i = 0; i < ARRAY_SIZE(cxl_root_single); i++)
+		if (dev == &cxl_root_single[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_swu_single); i++)
+		if (dev == &cxl_swu_single[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_swd_single); i++)
+		if (dev == &cxl_swd_single[i]->dev)
+			return true;
+
 	if (is_cxl_memdev(dev))
 		return is_mock_dev(dev->parent);
 
@@ -561,11 +639,31 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	int i, array_size;
 
 	if (port->depth == 1) {
-		array_size = ARRAY_SIZE(cxl_root_port);
-		array = cxl_root_port;
+		if (is_multi_bridge(port->uport)) {
+			array_size = ARRAY_SIZE(cxl_root_port);
+			array = cxl_root_port;
+		} else if (is_single_bridge(port->uport)) {
+			array_size = ARRAY_SIZE(cxl_root_single);
+			array = cxl_root_single;
+		} else {
+			dev_dbg(&port->dev, "%s: unknown bridge type\n",
+				dev_name(port->uport));
+			return -ENXIO;
+		}
 	} else if (port->depth == 2) {
-		array_size = ARRAY_SIZE(cxl_switch_dport);
-		array = cxl_switch_dport;
+		struct cxl_port *parent = to_cxl_port(port->dev.parent);
+
+		if (is_multi_bridge(parent->uport)) {
+			array_size = ARRAY_SIZE(cxl_switch_dport);
+			array = cxl_switch_dport;
+		} else if (is_single_bridge(parent->uport)) {
+			array_size = ARRAY_SIZE(cxl_swd_single);
+			array = cxl_swd_single;
+		} else {
+			dev_dbg(&port->dev, "%s: unknown bridge type\n",
+				dev_name(port->uport));
+			return -ENXIO;
+		}
 	} else {
 		dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
 			      port->depth);
@@ -576,8 +674,12 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 		struct platform_device *pdev = array[i];
 		struct cxl_dport *dport;
 
-		if (pdev->dev.parent != port->uport)
+		if (pdev->dev.parent != port->uport) {
+			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
+				dev_name(port->uport),
+				dev_name(pdev->dev.parent));
 			continue;
+		}
 
 		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
 					   CXL_RESOURCE_NONE);
@@ -627,6 +729,157 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 #define SZ_512G (SZ_64G * 8)
 #endif
 
+static __init int cxl_single_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_hb_single); i++) {
+		struct acpi_device *adev =
+			&host_bridge[NR_CXL_HOST_BRIDGES + i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_host_bridge",
+					     NR_CXL_HOST_BRIDGES + i);
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
+		cxl_hb_single[i] = pdev;
+		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
+				       "physical_node");
+		if (rc)
+			goto err_bridge;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_root_single); i++) {
+		struct platform_device *bridge =
+			cxl_hb_single[i % ARRAY_SIZE(cxl_hb_single)];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_root_port",
+					     NR_MULTI_ROOT + i);
+		if (!pdev)
+			goto err_port;
+		pdev->dev.parent = &bridge->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_port;
+		}
+		cxl_root_single[i] = pdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_swu_single); i++) {
+		struct platform_device *root_port = cxl_root_single[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_uport",
+					     NR_MULTI_ROOT + i);
+		if (!pdev)
+			goto err_uport;
+		pdev->dev.parent = &root_port->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_uport;
+		}
+		cxl_swu_single[i] = pdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_swd_single); i++) {
+		struct platform_device *uport =
+			cxl_swu_single[i % ARRAY_SIZE(cxl_swu_single)];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_dport",
+					     i + NR_MEM_MULTI);
+		if (!pdev)
+			goto err_dport;
+		pdev->dev.parent = &uport->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_dport;
+		}
+		cxl_swd_single[i] = pdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
+		struct platform_device *dport = cxl_swd_single[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_mem", NR_MEM_MULTI + i);
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
+		cxl_mem_single[i] = pdev;
+	}
+
+	return 0;
+
+err_mem:
+	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem_single[i]);
+err_dport:
+	for (i = ARRAY_SIZE(cxl_swd_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_swd_single[i]);
+err_uport:
+	for (i = ARRAY_SIZE(cxl_swu_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_swu_single[i]);
+err_port:
+	for (i = ARRAY_SIZE(cxl_root_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_root_single[i]);
+err_bridge:
+	for (i = ARRAY_SIZE(cxl_hb_single) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_hb_single[i];
+
+		if (!pdev)
+			continue;
+		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
+		platform_device_unregister(cxl_hb_single[i]);
+	}
+
+	return rc;
+}
+
+static void cxl_single_exit(void)
+{
+	int i;
+
+	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_mem_single[i]);
+	for (i = ARRAY_SIZE(cxl_swd_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_swd_single[i]);
+	for (i = ARRAY_SIZE(cxl_swu_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_swu_single[i]);
+	for (i = ARRAY_SIZE(cxl_root_single) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_root_single[i]);
+	for (i = ARRAY_SIZE(cxl_hb_single) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_hb_single[i];
+
+		if (!pdev)
+			continue;
+		sysfs_remove_link(&pdev->dev.kobj, "physical_node");
+		platform_device_unregister(cxl_hb_single[i]);
+	}
+}
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
@@ -724,7 +977,6 @@ static __init int cxl_test_init(void)
 		cxl_switch_dport[i] = pdev;
 	}
 
-	BUILD_BUG_ON(ARRAY_SIZE(cxl_mem) != ARRAY_SIZE(cxl_switch_dport));
 	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
 		struct platform_device *dport = cxl_switch_dport[i];
 		struct platform_device *pdev;
@@ -743,9 +995,13 @@ static __init int cxl_test_init(void)
 		cxl_mem[i] = pdev;
 	}
 
+	rc = cxl_single_init();
+	if (rc)
+		goto err_mem;
+
 	cxl_acpi = platform_device_alloc("cxl_acpi", 0);
 	if (!cxl_acpi)
-		goto err_mem;
+		goto err_single;
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
@@ -758,6 +1014,8 @@ static __init int cxl_test_init(void)
 
 err_add:
 	platform_device_put(cxl_acpi);
+err_single:
+	cxl_single_exit();
 err_mem:
 	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_mem[i]);
@@ -793,6 +1051,7 @@ static __exit void cxl_test_exit(void)
 	int i;
 
 	platform_device_unregister(cxl_acpi);
+	cxl_single_exit();
 	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_mem[i]);
 	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)

