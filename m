Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0C326938
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897318; cv=fail; b=jqhKEBemhhJ7mhuJRDO4sPXaqzAZvqsDBP2oCLyj6cJC3pD3Ad1xJtP1y0cnl+iTK8VY9yEqvo+8JQ3LkV1HByFKldkVFADT4k+YnZANGvKnBLJfvykHPybgIohUv4mUaMUEWdskFflD3JliKce2Y2Wl1vDPEZMZMIbKA15kcd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897318; c=relaxed/simple;
	bh=iW5L37kFz0a9pjY4/s3YSYyQdKNZgkUIvR/sFfuEOAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtWaAb+QkkwlpZtgY8YQ3zxtFX5t72rIo9wf72X9okTehzltduEFUQRDvA0iulSTHdYKNLqXBlfvQ5ij0ijJZC0RQyqZtqJS/GgLhfME1PXCPF+123zReE2EoYVPTh8/p3ucEWSwIDx5p9zbraP5vsyjehEpliBCkfezqsRBwsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0hAmK/PH; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0hAmK/PH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buxnXE/iHw/s4EvqPaVAJLxSPuXvzatAE9m0MCyFLkZ5MVHiC3H8NsFx28mIT+ndNqdX7Ziz45DxQ/bsbgDBI3rvuq9W+O2EWSYLLpj1YbnKudhbwfxtzFYAHYczpACgUcHg9UtERFqufZrgc/u8PZZwgf9ReO5Q88HuJQFfr6IYPdJtFRSBmG311xfi/j7qzGE2G+x9irIoOAe7SzENiKhJ9cfL/93Zzsxcq4vMC3R75+W47uxG9Rg/1Kb+yrx+xfzy/h0V5RJdvGlkBV2XVsraoCU+NaUS0DU1j3NWduxgt6BLjXa3S5shjiW0PEBEQaXHZBFzd2S0bbt0cMhbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLFByak3urRz9Gtg7n2NXy84oiveuTFPO0GW9Yz+PFo=;
 b=zIjxsR4enkCSWSWVJwVNIKH5owbR+Aj0CV8+VtRqUaf0LnPHR5pxqT5lY6C2D0OnyQj5JpVTPUa5tGtMv3KioyN+3IcT9IXMZUJlET19KW0vHLQ14IH8nzz01e/q6/9Cpu0x8ZcuRfREzcKi/aqS3SNVBazIXkGaWMpY7Mjz6T4fdeyShaJZCXP4B8JyKKuGb41UMfJFd0WrZupvqCxAifDb9tRf56JllGRHr++3eKb8VMSk3cQ0MghQGz/SZLgwIPEc9lBQsK6Fbj95PB++oV+JipeUvk01fXrNOyhyPL2py9od7pHupaMwfz9LUdbG/GslRsb22qBVGOKOgIe6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLFByak3urRz9Gtg7n2NXy84oiveuTFPO0GW9Yz+PFo=;
 b=0hAmK/PHyed7X/trDfjAXpgsQuM0y+uoJv1dbUleV8C5Pg3KB+G45Ye6gDa/Js4fEWQWVw4xCTVUAK7ZIjue6ohCrj6CmZWbd8QkWVf8JLT970L6pVO1WmfjfcRRPFPm0umMx4ksKmeAFeP1ULJH72AlenkoDPe+VwPC6seS5sQ=
Received: from BL0PR02CA0031.namprd02.prod.outlook.com (2603:10b6:207:3c::44)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:41:52 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::4d) by BL0PR02CA0031.outlook.office365.com
 (2603:10b6:207:3c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:41:52 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:41:51 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 05/17] cxl/cache: Add cxl_cache driver
Date: Tue, 11 Nov 2025 15:40:20 -0600
Message-ID: <20251111214032.8188-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4318c8-95e5-46d7-5d02-08de216b2092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKQjcjTNahzDvQdCb7ziO3cd3VF8t3G4j0F8b9HIK9jph2r435IacMnq9d8I?=
 =?us-ascii?Q?zOJqm3m+eb+t8imXZIuLGr0GXMrvAQhcoUl2GigE49qtDqNNAEz/kB9VlviS?=
 =?us-ascii?Q?RGZ9Ee04BRkZox8ynLwR9EALVWQunH5kCgVrwFAZFhzOL+UDyuK0tgVLih4s?=
 =?us-ascii?Q?16fMZ2yVHD0oPnRtaQzU9ORYGQcoA/c64LGdLQrgEeb9rfzN7KnFGQD4n6mE?=
 =?us-ascii?Q?7CsGkOZlTz3xVS9OPEEiYcd898jVuwFFEnaDvTJphI2EMoQxwBI9mtYzJ7rB?=
 =?us-ascii?Q?g9yHArnxYYVnuZijgUV7oq8D6L4uc5szTjh2pxUD9upEcggFHb7RXCdBdFeR?=
 =?us-ascii?Q?0kVFd8Z+xEuMnDzgVxrv0y979+vIPTAYWM7CsxnsQ9/bRq3e5no6QhjGsQyj?=
 =?us-ascii?Q?6RDdOagO4KJs5vCaPjTvmnKWdXgG7PB5QD20BQOJ/eR54myGwa1Gr588cmuW?=
 =?us-ascii?Q?t0LBCuBgyzvUDbBskh4M+xZoBUYW18+zkdCLDdvj26CacF5Y0skUENG0INl8?=
 =?us-ascii?Q?JnQzJl7cHhOyl8b8iYJvv0Gf7lz2J5nUU7at+7Ou1F6c0Qk01WIKEY9V2tzt?=
 =?us-ascii?Q?0BgLxsvtkHognvCMM/RbHJducfICehELZWCqQ2v2jgVaWe/du1IhkAl9fbPA?=
 =?us-ascii?Q?3w3sa8cJNBvn5ZaBfqX9/mMZFUjb7nLrxfZoz4E4/Pwt1LJ9bc2inEm42swa?=
 =?us-ascii?Q?tq6IVycoXijbFcj1394Eqi77gW6k3Gjc7DEyr1zHltZh2pjX+itlw5xYeAQx?=
 =?us-ascii?Q?tilFw7jFuGLYDMLUI8Tz01h0c1u51qwdl5Ibc8dVrESwpNQvMF22Ab+k5Wqc?=
 =?us-ascii?Q?3twivPEsrCHYFXWAwKVei8L+6UdDOrHP8X4DcGx9FqB2ySCHzbhnNlhPzI6i?=
 =?us-ascii?Q?JDrxoCWukyYuRE5kNRwHsTuCKJ6KkVH9gsrXlmgkxkhfsINwU1adqXzzznzv?=
 =?us-ascii?Q?mlnn7uKPlvk78qEcvfmR5yC74y6Bh+fU1yemOZ0SeM4cCqeN7HlRAWJWlKJK?=
 =?us-ascii?Q?DBA0c0qRayi6uEEzXd3YWJWtSzCMXKncm8mJy+/7slIXyQQcPVsTQ58Z1ECU?=
 =?us-ascii?Q?2yJb5snOWHgRNhw1CHr8MIL0f7Av7LmCxm/Y0AtozBjSG+UTrbvguUiV1iex?=
 =?us-ascii?Q?ZidAQlb+Mq4zBKGuDiZRe5orXfkwKul5tajXQuY3OWxuTx0PTfIBaMoKU/J8?=
 =?us-ascii?Q?KMEEQu55vsI+3/LOUwijvowK38S0ubsvelEywhsDqkrdvtY/0QmMNwx3Zw6x?=
 =?us-ascii?Q?B+TKtlK1z/9ncywMiCrfW4koXfPV3YJ4G/O4u4OCK+B650UdWSBbfFVsH3De?=
 =?us-ascii?Q?NvIoO7e+y0q2X767DjNlU/aRtb3lhYJFK0uSowo1QBtQ0izk2T3sW2wewCkz?=
 =?us-ascii?Q?dVyd1deEHbwrkvJXNXHXwbX8Tl3/2uPf0EkTsdhS+snNo4xpOcuODt0hawg9?=
 =?us-ascii?Q?ET/YBF7jJJFGTe6LkPR+jAyq9jSeSmcXgx15oJoIAGs+IAA6JVxIrezw0Bni?=
 =?us-ascii?Q?wHUqicWv6PEwj8Bjd6K536cljmajOlAjLaD6wTffDpBHYvL2fP8DhbjXizfi?=
 =?us-ascii?Q?ElPAu+cPI5iMf6UKlsA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:41:52.4397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4318c8-95e5-46d7-5d02-08de216b2092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

Add the cxl_cache driver which will manage struct cxl_cachdev devices.
This driver will provide common management functions for some of a cache
capable endpoint. This driver will also be responsible for validating
the system's CXL.cache configuration.

The driver expects the device's cache capabilities to be prefetched by
the endpoint-specific driver. The required capabilities can be gotten by
calling cxl_accel_get_cache_info().

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/Kconfig    | 14 ++++++++
 drivers/cxl/Makefile   |  2 ++
 drivers/cxl/cache.c    | 80 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlcache.h |  2 ++
 4 files changed, 98 insertions(+)
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
index 000000000000..6f410fae9437
--- /dev/null
+++ b/drivers/cxl/cache.c
@@ -0,0 +1,80 @@
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
+ *
+ * The cache state of @cxlds needs to be populated before calling this function,
+ * use cxl_accel_read_cache_info() to do so.
+ */
+struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
+					   struct cxl_dev_state *cxlds)
+{
+	struct cxl_cachedev *cxlcd;
+	int rc;
+
+	cxlcd = cxl_cachedev_alloc(cxlds);
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
+	if (!cxlcd->dev.driver)
+		return ERR_PTR(-ENXIO);
+
+	return cxlcd;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
+
+static int cxl_cache_probe(struct device *dev)
+{
+	return 0;
+}
+
+static struct cxl_driver cxl_cache_driver = {
+	.name = "cxl_cache",
+	.probe = cxl_cache_probe,
+	.drv = {
+		/*
+		 * Needed to guarantee probe and set up order for Type 1/2
+		 * vendor drivers.
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
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 24ec8dddefe7..6409e25dd1b4 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -29,4 +29,6 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
 bool is_cxl_cachedev(const struct device *dev);
 
 int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds);
+struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
+					   struct cxl_dev_state *cxlds);
 #endif
-- 
2.51.1

