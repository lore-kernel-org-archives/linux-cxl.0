Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342F822B8D9
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034237; cv=fail; b=nQ0kEgNnaBCmNCg0/mtj2cHa2kvuwUm/l+GCkHbkB1zPLvx0ZerK9zQqITbqW9Q8qpuowoPd/Yfc4EU0MP6xO4Qb1vMv2Vs4lf6y+sCy+VfndI/1RiIVC7nFZHbn8PmpIrIsG7D6QEbYSGkbhtajLg+duM6LSqcsBSugwcr1Apc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034237; c=relaxed/simple;
	bh=yOwXc2RJo/JOZSSYlwf3MHgr2B/OjL3wdO9WgM77Xy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao8HyYULI0R4cmS65RuPMYgqPni0UczvZJ0riVroB7m2rq32pf0oUYfAyNeTU+diX+HE2bNe/R5wCDDSJlyaAkHCj7KpphY7xaauF0jwR+BE+r9K0nsBbV67Y/9Fy0/BRTA1Jh8cPS4ELODkjoYl/gC4RASUM5h1tLjN8FmjtVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PY4WUhei; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PY4WUhei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3UEXN3LjvNG0cvAkOWmhCGsdfHnk3znCDa5kYQJZ4QTRoHIJ88YgmjnKxgsJQDMHJphGCq5I6DABYHZkS3eSkgL/liPa2ioUvjGYDXdby+Q2yf6ZGTEIq+Xe8ZeI13EBK1HfvvcslkfKpxcvYhYZIV1wkELgXFTUBXq1YPDpfjV9dH9Fx2yreo8cx3NuHPu3mzouRcIgbb2FC/2aBWkwWp0TqwjwVLe2xHbbaYNu+tn6KHbouiHUCUKlmABjXT1Q1Fun8xScToC/m2Sh0kFikmCUzUHgE4ihZXJvIPiWpBLj6ZkIH6RIzFIeD3V7fcNp0M6NuKX9MnlbQ60h+Tl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjmE9YEqvMdLiAfW+NOkYnrr+3464rwVD/u6RIz25UI=;
 b=rd8CgK5uNZiN4ar1TGGnnITzi96bk1IXivOWKJ5N8ygiCAC497o4CkYQsF11pNvIodYreOChyAoIbfTXbK111p9kDQCDeIyk1KImG5xB8I7cSFfEfd8D356DoZrctHu1Rt5QOZGPrgOO2UGnbODgLeQvYKtb+5esH2c1O8WfEUhenqYN/nOGbE3gVS66p/8oExDBAppkx7jZhe6Zf6wfA65MBT5ndh3RmaJHaYCESixwehpPQxSRXoc0nrnQoAy2u225WdoHTAH49QgbppOFlCfJAE6g//shypD4QgqPPmtOo0nKQlIayA1u0hWi/au3yVayy1NSRSpBlgirNFzCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjmE9YEqvMdLiAfW+NOkYnrr+3464rwVD/u6RIz25UI=;
 b=PY4WUheiuLVLzrcIskJWSiKcRbFRTnWZ0zhNrTCFgivnyvFOhtW6tOPFBmWbzP91SepdpWSxfZqVpE/fyLZsSredDVpSDRHHFuLFHfjvdvhyJCgiSEk1ohW9857Ks5OzkEMw0wUI8JZeAnEIZY7XxXDQfqV5CmIH+RbgKTEJTIY=
Received: from CH2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:610:51::29)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 21:30:28 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::a7) by CH2PR15CA0019.outlook.office365.com
 (2603:10b6:610:51::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Tue,
 12 Aug 2025 21:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:30:27 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:30:27 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 03/18] cxl/core: Add CXL.cache device struct
Date: Tue, 12 Aug 2025 16:29:06 -0500
Message-ID: <20250812212921.9548-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: d86f54fa-0a63-4847-273b-08ddd9e77501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kYQNpcPcdWZUiGMeGKoqDTQQQ3F7vXR0ibElLyhKFAknBAjvBe+8Ddo6xHn3?=
 =?us-ascii?Q?2jk/C8ahTWMtPcQ2cjSjCKnQOfth2/RUIWadx3jbCL10C5X/vMoQ+zKbxG7G?=
 =?us-ascii?Q?XjadRcieES48PVWBY5r+8czu0u1iNh4apBGRtXpiDRYeNlmiGnDEQ0tHKazj?=
 =?us-ascii?Q?r4yd78l705xOjZghf8OFzse4xjJjRbB1moYmcDKzvK54B/z3RaEWEWoJEtXg?=
 =?us-ascii?Q?1eo898LCPe1QuDRoNO4wQ82+PJi40MyHTBQyaQunAoYNoiVHu3Mp6jk38DTo?=
 =?us-ascii?Q?FFxSj2rbw35ePV5cY4XifQsO/b1dl0l6jcRNjgbpTFTVWHn4qq7RMRSKHY/3?=
 =?us-ascii?Q?85j/7ZQ77iF6vLPqcgjaG7Vmfw+Q1F9mYQmQPY/gQ6IkinPQn8x7V30ct5qB?=
 =?us-ascii?Q?jREXXKejibV0sIdKFQylJuaxh6mQWT7VLDzef6ehKMCws/8XPIK3ZPVu4y1j?=
 =?us-ascii?Q?XePiKd8oOu5qnF9/gXDA8RubdKfH36hY2xJs+tSxtmvSFTUE2M318MsV8lhZ?=
 =?us-ascii?Q?ubjMvzmXVS13goP4lvyGylHl2sPFBxf3DAx34oLuHrzg2T80K1CiNk0gyLez?=
 =?us-ascii?Q?3xIal1HDvuSZVEOquqMIidLObdnV/uv2ylktvtnaYIa9ek/m3VxUQi75E8sw?=
 =?us-ascii?Q?qw+LRWDFy/nUZJpIxJYxSnO8q8a8T2xnmzS2bU/iqNV9nTyNuIziKAmnNF9I?=
 =?us-ascii?Q?khpr6VIweUE+QOIqhx5vJcB/Yv4wtJcGMjjhTX8CwOtwprSh0mOErfrc+zP+?=
 =?us-ascii?Q?HKLm+sKcRFGVIokz1hUOP5J7nTdKyg+TcXolhimT5j8vkSYO+MPxXH6Ei+OG?=
 =?us-ascii?Q?qoAAtGLMxSYsjSDPsBtFIUeEjDIu75CVDNifCq59ELzo0qkOACHiic118r7D?=
 =?us-ascii?Q?f+DcBpPFdYyv96xmotT9904XLdys9Ts/TNKSTXhVidAh1ajIFSWMkFWeeRGj?=
 =?us-ascii?Q?g9MgCcbspKVzdD96uHGFGHd7j3OBJXnhUirknCB+p9wVATKayI6KfiigmeVy?=
 =?us-ascii?Q?4TXoGi0Gm+UqSTeay0rOgZ2EBy6Sh371PTPalVkRadL+RXa7brPI/P4RROn6?=
 =?us-ascii?Q?LJEFYgAy39l5CiGsBDMG+768o9WEaS8AgSd2WNtgR6b311BqcJrQzgRuv0y5?=
 =?us-ascii?Q?JSLWXDdd2KCKH4a9FRZuwueMrKDCi4UgAl85jntFdi8uombFKocQDebUsKkY?=
 =?us-ascii?Q?N9MNEORK45vFC3xaJKQ5LBbbhV+UlgXKSujG2SBcvuTgsEaGL6+1iXnQp9V9?=
 =?us-ascii?Q?5QOhZ5vNNH2Ny1N5ujk2Q2E6jmm8D/7dP1c5S3i2MQAK+3Dxz/kKT/AGkFDI?=
 =?us-ascii?Q?wPWknDj3rqQVi4GW0BDrbYoHlXOb880iZvaKla3bfilv60V90E+ePU2/Jidf?=
 =?us-ascii?Q?W4vEvMeNhcD47esXrQSLvb/I7eD6QSQDEB3AiCzJxK/266uQhVMqd1gnvr52?=
 =?us-ascii?Q?Was+K95nor1Nnd0+uyl5VKP8XSG1oPamzsSUfLpUu9bswmQe6nRZgm20ULx7?=
 =?us-ascii?Q?ggZJx7b/hAdbC7qw7/WMyW0n6q4/k5aBwNnH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:30:27.9343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86f54fa-0a63-4847-273b-08ddd9e77501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

Add a new CXL.cache device (struct cxl_cachedev) that is the cache
analogue to struct cxl_memdev. This device will be created by
endpoint vendor-specific drivers to enable and manage the cache
capabilities of the endpoint.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/Makefile   |  1 +
 drivers/cxl/core/cachedev.c | 91 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c     |  3 ++
 drivers/cxl/cxl.h           |  3 ++
 drivers/cxl/cxlcache.h      | 23 ++++++++++
 drivers/cxl/private.h       |  4 ++
 6 files changed, 125 insertions(+)
 create mode 100644 drivers/cxl/core/cachedev.c
 create mode 100644 drivers/cxl/cxlcache.h

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79e2ef81fde8..227b903d6a47 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -9,6 +9,7 @@ cxl_core-y := port.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
+cxl_core-y += cachedev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
new file mode 100644
index 000000000000..aaf4a1b94178
--- /dev/null
+++ b/drivers/cxl/core/cachedev.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
+#include <linux/device.h>
+#include <linux/pci.h>
+
+#include "../cxlcache.h"
+#include "private.h"
+
+static DEFINE_IDA(cxl_cachedev_ida);
+
+static void cxl_cachedev_release(struct device *dev)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+
+	ida_free(&cxl_cachedev_ida, cxlcd->id);
+	kfree(cxlcd);
+}
+
+static void cxl_cachedev_unregister(void *dev)
+{
+	struct cxl_cachedev *cxlcd = dev;
+
+	cxlcd->cxlds = NULL;
+	put_device(&cxlcd->dev);
+}
+
+static char *cxl_cachedev_devnode(const struct device *dev, umode_t *mode,
+				  kuid_t *uid, kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static const struct device_type cxl_cachedev_type = {
+	.name = "cxl_cachedev",
+	.release = cxl_cachedev_release,
+	.devnode = cxl_cachedev_devnode,
+};
+
+bool is_cxl_cachedev(const struct device *dev)
+{
+	return dev->type == &cxl_cachedev_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_cachedev, "CXL");
+
+static struct lock_class_key cxl_cachedev_key;
+
+struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds,
+					const struct cxl_dev_ops *ops)
+{
+	struct device *dev;
+	int rc;
+
+	struct cxl_cachedev *cxlcd __free(kfree) =
+		kzalloc(sizeof(*cxlcd), GFP_KERNEL);
+	if (!cxlcd)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc(&cxl_cachedev_ida, GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	cxlcd->id = rc;
+	cxlcd->depth = -1;
+	cxlcd->cxlds = cxlds;
+	cxlds->cxlcd = cxlcd;
+	cxlcd->endpoint = ERR_PTR(-ENXIO);
+	cxlcd->ops = ops;
+
+	dev = &cxlcd->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_cachedev_key);
+	dev->parent = cxlds->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_cachedev_type;
+	device_set_pm_not_required(dev);
+
+	return_ptr(cxlcd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cachedev_alloc, "CXL");
+
+struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
+						    struct cxl_cachedev *cxlcd)
+{
+	int rc;
+
+	rc = devm_add_action_or_reset(host, cxl_cachedev_unregister, cxlcd);
+	if (rc)
+		return ERR_PTR(rc);
+	return cxlcd;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_cachedev_add_or_reset, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index cc025bf0376e..0730a60cb722 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxlcache.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -78,6 +79,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_REGION;
 	if (dev->type == &cxl_pmu_type)
 		return CXL_DEVICE_PMU;
+	if (is_cxl_cachedev(dev))
+		return CXL_DEVICE_ACCELERATOR;
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 751e5860423a..9ff67a58ceac 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -762,6 +762,7 @@ struct cxl_dev_ops {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @cxlcd: The device representing the CXL.cache capabilities of @dev
  * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
@@ -778,6 +779,7 @@ struct cxl_dev_ops {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_cachedev *cxlcd;
 	struct cxl_register_map reg_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
@@ -968,6 +970,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_ACCELERATOR		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
new file mode 100644
index 000000000000..3ccbeba9fcd6
--- /dev/null
+++ b/drivers/cxl/cxlcache.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __CXL_CACHE_H__
+#define __CXL_CACHE_H__
+#include <linux/pci.h>
+
+#include "cxl.h"
+
+struct cxl_cachedev {
+	struct device dev;
+	struct cxl_dev_state *cxlds;
+	struct cxl_port *endpoint;
+	const struct cxl_dev_ops *ops;
+	int id;
+	int depth;
+};
+
+static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
+{
+	return container_of(dev, struct cxl_cachedev, dev);
+}
+
+bool is_cxl_cachedev(const struct device *dev);
+#endif
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index 8413db891343..49c588b95c19 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -12,6 +12,10 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 				    const struct cxl_dev_ops *ops);
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd);
+struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds,
+					const struct cxl_dev_ops *ops);
+struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
+						    struct cxl_cachedev *cxlcd);
 int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 			  struct cxl_dport *parent_dport);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1

