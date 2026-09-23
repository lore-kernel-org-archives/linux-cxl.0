Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B02D6E64
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184838; cv=fail; b=aqKk2ECHgAtL5U+ccnOO4sRVRxu/Tg3ulYafJx56dqID7bxGI2NNPhK8zmSLNq/E83RYxMMiCtKqgqgWxFPjSGJxdB+k2Y3r0w1fQW3Kh95oguWctXilHVZin8uDVdbvwL7sR87ca5xKOi+6eZpurcvmcQtYUx3JbI14HQB9bDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184838; c=relaxed/simple;
	bh=+WD1Ds8JYE+AoRnmtyI2xhnK+7gkC0DXfxyez+cSNgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxeBI7e6qZpuALvrTqofi3ONN2suu6Bsbk5BkE0rEjSkLxHuxr361YtM8uApDjmpbV/Oax42+O4qqAWlWLfdzBRyvo/oyJLpeZoW8HQo5+28mMexqFmr57Owtbjd+1HJrBq2STPJuaMHMr4G1fbll1EdaBDRnHV1fB8zK6VypI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cQp5sH+X; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cQp5sH+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK/5Efy8VbYkzPj9vUTMaAL8QOogcyk29xXHzeXWqrTYnherbGP4I93h7gWB0F5IReit4uZJ8EzMn2n1uNdAHD2jSXiyegxbbDYHN4n+/RnTzPpDYZ7C774pqtlcjvK/bZoQXD0pvRI/xsnnxWtVSqAHiHXBaDmiBQza10myWNd1GtqHHjftXvEDXEoiDdRkT1LYHV0kN/yjgJdNmnf8BtZQbEWynZ4MgHaj+O1HRSC4lfrCdwpiw+lV7lwDkMFlqslNnotpgJ4Lp9+HJHBFd16XyxXTZpnho4pctwoKPqSiMf3WJ6vTh9Uwhw1eOYCeQigYcAbOu40GJs3EN1FI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8eFLg3o2OCNPCiWKqHmzQ/SSNvCnY5S3K7wZoRBmVI=;
 b=IDmt5vq3X8WzBsAGdh4Uhzd35j0uiN/XdZd3eL8wLWNcAwwp2sooPK3awBxzTq5wUxQaisY1GFIFpsX0QqFHE0uLDWS1wHAgOBjq/JUX1wffXl4xTy+SwYYHpHcu7JxkObSXYk0lQB89g6qkmFh/et0FhaznNysE+4W5wNAUVnpS7O/ygCUg8fBZZdry4+EwdGi8zsO2O4Z57i5VJ52ev5LTfqNxQlQisEprGMaUebhD23OoH3X+38pROseNIGxW0M7kOfiQmWmIZSqFLfkufbQnLtBJPI4oDInhlY/vU21sgQIYIKT3BY/E/1yrF1+FJLqmxm/+pZ6qyIjsup9cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8eFLg3o2OCNPCiWKqHmzQ/SSNvCnY5S3K7wZoRBmVI=;
 b=cQp5sH+X0aO0+J8GdPPDDjDCZHUAErb1Dvbe6J11ImImWM3TKDONzLFLHUSNiw/HrUJml0+K5JU/KjUQ/OveCvbfWOsm/gL0VtUTKCbC/sa7LV4pFQcxqKu8eCKLtu85XS4GAe4azIedumQYL8kh5JiNGqSfNLYA8IyGOfQ4pAA=
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:33:51 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::68) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:51 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:49 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 02/15] cxl/cache: Add cxl_cache driver
Date: Wed, 23 Sep 2026 12:33:29 -0500
Message-ID: <20260923173342.5584-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|SAWPR12MB999165:EE_
X-MS-Office365-Filtering-Correlation-Id: e6289202-4459-4c3c-1a33-08df1998d541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|5023799004|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uo0kMtoJVpM0UcJS1cvhU1wynY71wwO9jiRAUAtMd7ytkEFJdHlP+v5NP8NG1WjNsYk27CrKTZn7P3/cEyOpTfSwYr/yDTgIlve3NkP37eMV+4KjoMN6DS+ZTylnv6HaCj881P5I4iXNLdAH6vXq7C9TUUzpQpd16dYBhH/kfTiPelvmGVOd26ZjILdCCHWwNh9pOnJZzTDJ7iedjFpySKZyrxr/6rUyH2XWLoT7ovNEH81IPBKicqoGY4tqk4I3q6jITcjLRL5oniOzRId2+fExCG4UV9nOJt6QERh5sybLRq15aoROrJcvNmY8gB9IbZNCRIGmp5/QmSu1K2hru5xZE7G1gn0Nw0MjhF6KUMKemjspk7E2DP8dc9q8xjC9qNlPQcehGEv8GJ0XOU6bSQjwXlWtjdSWQRm32GAat8q/1EcuJ1/IBWpp4EPLNyeJ7/v+tbQ437QmeGDKUIvhIi+8uS2w+I1CEu/6k9Gsuq74S58Y6ioP5jv8gHm+YmYs4gWY8gjxQGQIR8s8tmkSpkrALmUFFCI1fkb6TT+6Z6SZT1fKFnhmS5ZgK8vJ2ehZPjh6WGV7zuGfPyq8TRub2Li5s3ONvP2CL9Yp7IGU7KhCUi+ruGaAKYGormrrbkEqkfift+fZ193cwudmXTx8bwxzTnrJRxyNnXMMph/FSnts3Vr0ePZO9amRY3y0LNxvN/lNUn3WwScYPaFe+JYaNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(5023799004)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1xx+6meayyE85Ue9Sfem8flkjFxBUgw0kFdKe+vnUL5DIivafjXK0vMSGdxrB3pFItj5lVOdUSYcxSMNDTS7RR1b7k/yv6TTg5ihbArkCh0/sSOoIItJVOW4d98PKS05TlJizPdpueKHC8UHER7HI0QFBWmScEUYrmXjKPZspRzLjhD1ObiZcDB0cjMs6quXxlrcR1JugKE/H3Q3W/ZHszQblsptv1GRKl6UcPeqY6IgUvjYuB1MjbLYFAvw3gpThurvWlz/NwLzos6OPAplFKVOB7RahU8tKsqe7h5526KOs8hqdJTQ3uOn+47/qhN807DifhcQIG9aJptt9QSJ5BazBx2QKMZAEgoPscckAmO+ChPyMWp++r0quTaVegP8HZcngjeONtOe23u/GuoTMont+NqdizwlzeDVMX0yAqEltN7iaMhx8xdtjTg+q2B1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:51.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6289202-4459-4c3c-1a33-08df1998d541
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165

Add the cxl_cache driver. This driver will provide management functions
for common portions of CXL.cache capable endpoints, manage struct
cxl_cachedev devices, and validate the system's CXL.cache
configuration.

Add a function for getting the CXL.cache information from the CXL
device DVSEC and store it in the new struct cxl_cache_state member of
cxl_dev_state for use by endpoint drivers.

Add another set of functions to enable/disable CXL.cache on a device.
The cxl_cache driver disables CXL.cache on a device during probe until
the device's configuration can be validated. Validation of the
configuration will come in later commits, so the driver just disables
CXL.cache for now.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/Kconfig           | 14 +++++++
 drivers/cxl/Makefile          |  6 ++-
 drivers/cxl/cache.c           | 61 +++++++++++++++++++++++++++
 drivers/cxl/core/cachedev.c   |  2 +-
 drivers/cxl/core/pci.c        | 78 ++++++++++++++++++++++++++++++++---
 drivers/cxl/cxlcache.h        |  3 ++
 include/cxl/cxl.h             | 27 +++++++++++-
 include/uapi/linux/pci_regs.h |  4 ++
 8 files changed, 186 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cxl/cache.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..9c3d3cb6e391 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -243,4 +243,18 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+config CXL_CACHE
+	tristate "CXL: Cache Management Support"
+	depends on CXL_BUS
+	help
+	  Enables a driver that manages the CXL.cache capabilities of a CXL.cache
+	  capable device. This driver validates and provides support for
+	  programming the CXL cache device topology. This driver is required for
+	  using multiple CXL.cache devices (Type 1 or 2) below a given CXL 3.0+
+	  capable PCIe Root Port. This driver only provides CXL cache management and
+	  reporting capabilities, a vendor-specific device driver is expected to
+	  use the device's CXL cache and enable any other capabilities.
+
+	  If unsure, say 'm'.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..6539fe19c08b 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -4,18 +4,20 @@
 # - 'core' first for fundamental init
 # - 'port' before platform root drivers like 'acpi' so that CXL-root ports
 #   are immediately enabled
-# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
-#   immediately enabled
+# - 'mem', 'pmem', and 'cache' before endpoint drivers so that memdevs and
+#   cachedevs are immediately enabled
 # - 'pci' last, also mirrors the hardware enumeration hierarchy
 obj-y += core/
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_CACHE) += cxl_cache.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
+cxl_cache-y := cache.o
 cxl_pci-y := pci.o
diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
new file mode 100644
index 000000000000..1815ae3a37d5
--- /dev/null
+++ b/drivers/cxl/cache.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Advanced Micro Devices, Inc. */
+
+#include <cxl/cxl.h>
+
+#include "cxlcache.h"
+
+/**
+ * DOC: cxl cache
+ *
+ * The cxl_cache driver is responsible for validating the CXL.cache system
+ * configuration and providing a common management interface for the CXL cache
+ * of CXL.cache enabled devices. This driver does not discover devices; a
+ * device-specific driver is required for discovery and portions of set up.
+ */
+
+/**
+ * devm_cxl_add_cachedev - Add a CXL cache device
+ * @cxlds: CXL device state to associate with the cachedev
+ */
+struct cxl_cachedev *devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
+{
+	return __devm_cxl_add_cachedev(cxlds, NULL);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
+
+static int cxl_cache_probe(struct device *dev)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	int rc;
+
+	/* Disable CXL.cache until we can validate the device configuration */
+	cxl_clear_cache_enable(cxlds);
+
+	rc = cxl_accel_read_cache_info(cxlds);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static struct cxl_driver cxl_cache_driver = {
+	.name = "cxl_cache",
+	.probe = cxl_cache_probe,
+	.drv = {
+		/*
+		 * Needed to guarantee probe and set up order for
+		 * endpoint drivers.
+		 */
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
diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index 3a7a60165f62..25a24c3bd817 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -116,4 +116,4 @@ struct cxl_cachedev *__devm_cxl_add_cachedev(struct cxl_dev_state *cxlds,
 
 	return cxl_cachedev_autoremove(no_free_ptr(cxlcd));
 }
-EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_cachedev, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_cachedev, "cxl_cache");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..796c4582d2f3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -8,6 +8,7 @@
 #include <linux/pci-doe.h>
 #include <cxl/pci.h>
 #include <linux/aer.h>
+#include <cxlcache.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -180,7 +181,8 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
-static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
+static int cxl_set_protocol_enable(struct cxl_dev_state *cxlds, u16 val,
+				   u16 enable_bit)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
@@ -191,9 +193,9 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
+	if ((ctrl & enable_bit) == val)
 		return 1;
-	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
+	ctrl &= ~enable_bit;
 	ctrl |= val;
 
 	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
@@ -205,14 +207,15 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 
 static void clear_mem_enable(void *cxlds)
 {
-	cxl_set_mem_enable(cxlds, 0);
+	cxl_set_protocol_enable(cxlds, 0, PCI_DVSEC_CXL_MEM_ENABLE);
 }
 
 static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	rc = cxl_set_mem_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE);
+	rc = cxl_set_protocol_enable(cxlds, PCI_DVSEC_CXL_MEM_ENABLE,
+				     PCI_DVSEC_CXL_MEM_ENABLE);
 	if (rc < 0)
 		return rc;
 	if (rc > 0)
@@ -220,6 +223,31 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
 }
 
+static void __clear_cache_enable(void *cxlds)
+{
+	cxl_set_protocol_enable(cxlds, 0, PCI_DVSEC_CXL_CACHE_ENABLE);
+}
+
+void cxl_clear_cache_enable(struct cxl_dev_state *cxlds)
+{
+	__clear_cache_enable(cxlds);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_clear_cache_enable, "cxl_cache");
+
+int devm_cxl_enable_cache(struct device *host, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_set_protocol_enable(cxlds, PCI_DVSEC_CXL_CACHE_ENABLE,
+				     PCI_DVSEC_CXL_CACHE_ENABLE);
+	if (rc < 0)
+		return rc;
+	if (rc > 0)
+		return 0;
+	return devm_add_action_or_reset(host, __clear_cache_enable, cxlds);
+}
+EXPORT_SYMBOL_FOR_MODULES(devm_cxl_enable_cache, "cxl_cache");
+
 /* require dvsec ranges to be covered by a locked platform window */
 static int dvsec_range_allowed(struct device *dev, const void *arg)
 {
@@ -927,3 +955,43 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+
+int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
+{
+	struct cxl_cache_state *cstate = &cxlds->cstate;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int dvsec = cxlds->cxl_dvsec;
+	u16 cap, cap2;
+	u32 unit;
+	int rc;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!FIELD_GET(PCI_DVSEC_CXL_CACHE_CAPABLE, cap))
+		return -ENXIO;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP2, &cap2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	switch (FIELD_GET(PCI_DVSEC_CXL_CACHE_UNIT, cap2)) {
+	case 1:
+		unit = SZ_64K;
+		break;
+	case 2:
+		unit = SZ_1M;
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	cstate->size = FIELD_GET(PCI_DVSEC_CXL_CACHE_SIZE, cap2) * unit;
+	cstate->unit = unit;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_read_cache_info, "CXL");
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 6ca887e078a1..be6dac93b91e 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -34,4 +34,7 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
 
 struct cxl_cachedev *__devm_cxl_add_cachedev(struct cxl_dev_state *cxlds,
 					     void *attach);
+int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds);
+void cxl_clear_cache_enable(struct cxl_dev_state *cxlds);
+int devm_cxl_enable_cache(struct device *host, struct cxl_dev_state *cxlds);
 #endif
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f0077ffa0d91..29c0687e4ac2 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -149,6 +149,22 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+/**
+ * struct cxl_cache_state - CXL cache device state for use by external drivers
+ * @size: Size of device's cache
+ * @unit: Unit of device's cache in bytes
+ */
+struct cxl_cache_state {
+	/* Public for endpoint drivers */
+
+	/* 
+	 * Populated by cxl_cache driver, will be overwritten on 
+	 * cxl_cache::probe()
+	 */
+	u64 size;
+	u64 unit;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -159,6 +175,7 @@ struct cxl_dpa_partition {
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @cxlcd: The device representing the CXL.cache capabilities of @dev
+ * @cstate: CXL.cache information for @dev
  * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
@@ -177,6 +194,7 @@ struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
 	struct cxl_cachedev *cxlcd;
+ 	struct cxl_cache_state cstate;
 
 	/* private for Type2 drivers */
 	struct cxl_register_map reg_map;
@@ -228,6 +246,13 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
-
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+
+#if IS_ENABLED(CONFIG_CXL_CACHE)
+struct cxl_cachedev *devm_cxl_add_cachedev(struct cxl_dev_state *cxlds);
+#else
+static inline struct cxl_cachedev *
+devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
+{ return ERR_PTR(-ENXIO); }
+#endif /* CONFIG_CXL_CACHE */
 #endif /* __CXL_CXL_H__ */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..5383b54ede96 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1353,7 +1353,11 @@
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CAP2				0x16
+#define   PCI_DVSEC_CXL_CACHE_UNIT			__GENMASK(3, 0)
+#define   PCI_DVSEC_CXL_CACHE_SIZE			__GENMASK(15, 8)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.53.0

