Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5526E15D
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034322; cv=fail; b=Qg4L8OGjhCc3ko5MzwuTj2o5fnxOwOW4ymqr8qHl2WGv5ZbFycXj1eLv58BftgoWan5uW2xxN6afiRb77L1gwyxPFsHrG6E8rb2x5LKTYYTn9O4ogwaITqnF/hNUSfWgfvjtcWYky2gt9+Aj9i2VzOX/8WredPudAUBUd722Eno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034322; c=relaxed/simple;
	bh=5KeyoPKnCVPmQlL+W6PaK/gudFUl7FPpiAS9nH3PQY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPSeZB2MgfXUCLMFvIESI9K2qwP8pRagXtgx3S5H+RHNgjGmmddjwxShHAqea5AX4j+uyHWPnVuoRq6T9+UqhzcEc9sUx4ZeeWhh6BRHN7avtZaJ8jtFi8dzK5mO+fKbCw5VCEy7p9tWD7gg7YS51NNAcx5Tv0Ec3KXXSTJi8I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=baQOF236; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="baQOF236"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3O1JJJinALnm2V2umsSPNIC4QMxOet3DrNx3712VX7BkW9CZaesoAxMoUL2hLQ+8E0tGnTVmjrDW4A3cLSNwlRqzzBSts/V3ATA1SiG7xpefDpgsnBb/RuaI+XOlyXkWN2nPVBAGmp7KQadakyypIvci+0MfAhj7GrkfTLE2KFdmEDGfE6zcuxIRI7mxTgVHcMF0cDK2YP0UdICw/4b/Pu/PEOMMYc1zOmcsiG4ylI6dtRnRlEIqhDoMe8jIafSLZZY1jFT6I+3mJ3rnDe1hFvpcdwZ0hhW/8O2GizZtiOHMkHqMobrcSHBgVhAO9JQF00yB1+omKhzDiv9+G0+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1byFsNcHm/0yShxXz1RwY8KoOPFKJ3IZCejhGB5TEE4=;
 b=rTGQqRyu9UYf0PZJTDIlRymzO5UTVFKOnKMdLQ3IPREPNMITwQv6AiLqy6bxnE4vyYC+xk6qcKrjZQtH+/2cL6LOCkoANG9Cd1Doz7ZGH0rkyVzlkl6LGgZyg7qrnbqkqWBrGfXWfjFtjypwCon4GcOdWesiqeFPL3eaPG7VaanE74y90y+5cqyunP3L7BUgari18NxtmszSUX3J3YoiDDhs0Seo1FBQoZ9wcxvh5oQWzVpNfngGIS0UisYuSBpAJ4qGOrlzbckI/12hheniZk9hUnQR9KJYW71S1QX1bZRaQSI9Dnbd3UMUD1nVC1b0Gm7s2FPVA0f4v9XFb2HX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1byFsNcHm/0yShxXz1RwY8KoOPFKJ3IZCejhGB5TEE4=;
 b=baQOF236eAvwiaOFdNlK42vcM1yybM2+CzqAP32bYDbh5xLfliPELeIYuCWWt9IQ7Y6yOm203TvhhI6w3UC1JkRbMI7R19Ao7d3edDAQGahO4Nq7XXjnK/5NfVjjZbT8YB1kCuqcMuoOfCcBtOfW6zFIz/gIBfvBhexk1z3JGX8=
Received: from CH2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:610:60::39)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 21:31:56 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::d1) by CH2PR14CA0029.outlook.office365.com
 (2603:10b6:610:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.23 via Frontend Transport; Tue,
 12 Aug 2025 21:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:31:55 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:31:55 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 10/18] cxl/cache: Add cxl_cache driver
Date: Tue, 12 Aug 2025 16:29:13 -0500
Message-ID: <20250812212921.9548-11-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 9200ca03-2e40-45db-c78b-08ddd9e7a953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gNqu84UiyTdBKyg8qsUTCkS0XoXNK1vbjYXmhukg6wmB8HDeIKLpHbM4hL19?=
 =?us-ascii?Q?CvgztkXS1SE3SGsQmqi2QRE0+Jgq5ZxMmdeYDqD3dwsoF3JAr1KKfjK4oVi7?=
 =?us-ascii?Q?QNze02O6WOeV8zLsHM54RG/EQtJDtoWOeZC9zZwGI+1XrTOZ9K0w53jgaVql?=
 =?us-ascii?Q?yyPqW3bHWvNThBMQ9jk7ESuxzT4x5Wn8NfxSs2/GoUxMjpDb3XW8G1t7nFrc?=
 =?us-ascii?Q?x3inM2B14NCinGIpm56iFQlZIonfGFFW+/erpBcLbvCR53YNGT5Jx9nXph8V?=
 =?us-ascii?Q?RwU/gwADhH8itllfcQIkBuQDAB3a7O3satD09K9GbrVIF00i8WjN68lTgMkf?=
 =?us-ascii?Q?swQQ5FbJYt3ZygvYq0pbar3tRJfaGDyy+/ulwvnmGtjpJw13YJw9O6X/h1wQ?=
 =?us-ascii?Q?Z5yTskAmR0Z8KNXNcrqT/p+lKrzMq0PWvAjoUo+ObVlx0mF+SQhhanU7QnLD?=
 =?us-ascii?Q?CBSm3/OSKX9/ou/Mun3OS7RFuow04RvCD+8DFZdZu8c25AQaHT+Tj/PNamhu?=
 =?us-ascii?Q?wku+pCzJ0h3HXcvSRysCCrTkophcR5cYUeapTnB+Jv/pVAFc4ofz79whLQO1?=
 =?us-ascii?Q?xbjQd/JOsMzqFbXPac1OWPt75Pihw1E4qhjHUQgsLx+KJsip7Vudv4u7SSs6?=
 =?us-ascii?Q?JsY7PD7/C6eQt110plkbFp1f5QuHpUumavB0ZWuje5UhGBA5IjdM/r/GtRKM?=
 =?us-ascii?Q?zGP2XP5jDTk4QKk5e3MXNiGFRybE7hv7/6ykfsrXbWpq4VEzCKwMJbRFq4TC?=
 =?us-ascii?Q?5uSLwTMroAA19rWzeiH+jIaLhkrM2xLyKQA7Hgn+489WYZEyL86nM+SLMzFt?=
 =?us-ascii?Q?mtyzfF/FBq+rjLiyAt+F50ZEwz+7mo3itU+IM21CkIk142p7K8KOlkjl/cBd?=
 =?us-ascii?Q?kdo6eofuPvg2EFw1UkNH2wYyxhYe23UXYDP63gosQoRWMV/ExcpSbtFZCW/s?=
 =?us-ascii?Q?LYIBKbNONyD4mHTUv5o5o7YGMRp8D+BnPAKknyK0H705mZYbYXRxwt4pEIEL?=
 =?us-ascii?Q?Alx8hqpKXQ1PNQaaD5qSN7G0exD78FbjTThrRLeEYOri9tjgbiJMLFr1uTgA?=
 =?us-ascii?Q?Csv+1mI4x7q2fI05FyPyYoI49ZTvxLqk/ka33F0tLsKG7iwVAqlYrQTj0CVT?=
 =?us-ascii?Q?RmQYZe8L+pRjp/Dy5obEzoMY4VkINwppOsKH5Bm/1joglmGM09EfIl1nofvD?=
 =?us-ascii?Q?bKnEeTiTK3rggqXiE5kTywPShihhaaYS8PIK7aNLdLUDzpP/iaOIHJuRslZa?=
 =?us-ascii?Q?Jpqs/lfXv00UaCDjO8+3tP/2nuvUNk7X19c7NCCKIoCaD1YzUu9mXl8SymCo?=
 =?us-ascii?Q?vb/efhKqFsm+euL8+PfUtJuYeXSTzHTSNrwWWUPlcZNFUHpFLKEx9cv1x994?=
 =?us-ascii?Q?v7iHuk39IhfOXvX6EiMvNFjiX0IkQAEe7ZFvzQJYyUU5q0VWJ+xrmIBmY2zx?=
 =?us-ascii?Q?CnIJhTOc/kXJbz197eTlnUkSDRZC4onPxL50/q8RL8ySjTaXxbLmSuPGeAPg?=
 =?us-ascii?Q?FTKYiGpHpq19A/8xgrnIPFCwOagglDrm6fGP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:31:55.7187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9200ca03-2e40-45db-c78b-08ddd9e7a953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Add the cxl_cache driver which will manage struct cxl_cachdev devices.
This driver will provide common management functions for some of a cache
capable endpoint. This driver will also be responsible for validating
the system's CXL.cache configuration.

The driver expects the device's cache capabilities to be prefetched by
the endpoint-specific driver. The required capabilities can be gotten by
calling cxl_accel_get_cache_info().

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/Kconfig    |  14 +++++
 drivers/cxl/Makefile   |   2 +
 drivers/cxl/cache.c    | 116 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlcache.h |   3 ++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/cxl/cache.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..6b07212b554a 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,18 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_CACHE
+	tristate "CXL: Cache Management Support"
+	depends on CXL_BUS
+	help
+	  Enables a driver that manages the CXL.cache capabilities of a CXL.cache
+	  capable CXL device. This driver validates and provides support for
+	  programming the CXL cache device topology. This driver is required for
+	  using multiple CXL.cache devices (Type 1 or Type 2) below a given
+	  CXL 3.0+ capable PCIe Root Port. This driver only provides CXL cache
+	  management and reporting capabilities, a vendor-specific device driver
+	  is expected to enable the full capabilities of the device.
+
+	  If unsure, say 'm'.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..1017206d6780 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -13,9 +13,11 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_CACHE) += cxl_cache.o
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+cxl_cache-y := cache.o
diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
new file mode 100644
index 000000000000..6e5161ae3107
--- /dev/null
+++ b/drivers/cxl/cache.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
+#include "cxlcache.h"
+#include "private.h"
+
+/**
+ * DOC: cxl cache
+ *
+ * The cxl_cache driver is responsible for validating the CXL.cache system
+ * configuration and managing portions of the CXL cache of CXL.cache enabled
+ * devices in the system. This driver does not discover devices, a
+ * device-specific driver is required for discovery and portions of set up.
+ */
+
+/**
+ * devm_cxl_add_cachedev - Add a CXL cache device
+ * @host: devres alloc/release context and parent for the cachedev
+ * @cxlds: CXL device state to associate with the cachedev
+ * @ops: optional operations to run in cxl_cache::{probe,remove}() context
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_cache driver. This may fail if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached)
+ * or the CXL.cache system configuration is invalid.
+ */
+struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
+					   struct cxl_dev_state *cxlds,
+					   const struct cxl_dev_ops *ops)
+{
+	struct cxl_cachedev *cxlcd;
+	int rc;
+
+	cxlcd = cxl_cachedev_alloc(cxlds, ops);
+	if (IS_ERR(cxlcd))
+		return cxlcd;
+
+	rc = dev_set_name(&cxlcd->dev, "cache%d", cxlcd->id);
+	if (rc) {
+		put_device(&cxlcd->dev);
+		return ERR_PTR(rc);
+	}
+
+	cxlcd = devm_cxl_cachedev_add_or_reset(host, cxlcd);
+	if (IS_ERR(cxlcd))
+		return cxlcd;
+
+	guard(device)(&cxlcd->dev);
+	if (ops && !cxlcd->dev.driver) {
+		if (IS_ERR(cxlcd->endpoint))
+			return ERR_CAST(cxlcd->endpoint);
+		return ERR_PTR(-ENXIO);
+	}
+
+	return cxlcd;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
+
+static int cxl_cache_probe(struct device *dev)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	int rc;
+
+	rc = devm_cxl_enumerate_ports(&cxlcd->dev);
+	if (rc)
+		return rc;
+
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_dev_find_port(&cxlcd->dev, &dport);
+	if (!parent_port) {
+		dev_err(dev, "CXL port topology not found\n");
+		return -ENXIO;
+	}
+
+	if (dport->rch)
+		endpoint_parent = parent_port->uport_dev;
+	else
+		endpoint_parent = &parent_port->dev;
+
+	scoped_guard(device, endpoint_parent) {
+		if (!endpoint_parent->driver) {
+			dev_err(dev, "CXL port topology %s not enabled\n",
+				dev_name(endpoint_parent));
+			return -ENXIO;
+		}
+
+		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlcd->dev, dport);
+		if (rc)
+			return rc;
+	}
+
+	if (cxlcd->ops) {
+		rc = cxlcd->ops->probe(&cxlcd->dev);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static struct cxl_driver cxl_cache_driver = {
+	.name = "cxl_cache",
+	.probe = cxl_cache_probe,
+	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+	},
+	.id = CXL_DEVICE_ACCELERATOR,
+};
+
+module_cxl_driver(cxl_cache_driver);
+
+MODULE_DESCRIPTION("CXL: Cache Management");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("CXL");
+MODULE_ALIAS_CXL(CXL_DEVICE_ACCELERATOR);
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 3880312cd49d..a707e402b000 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -22,4 +22,7 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
 bool is_cxl_cachedev(const struct device *dev);
 
 int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds);
+struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
+					   struct cxl_dev_state *cxlds,
+					   const struct cxl_dev_ops *ops);
 #endif
-- 
2.34.1

