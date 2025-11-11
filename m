Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D40281508
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897303; cv=fail; b=bZxANF0wiQ9T1Y+ejZTJAP0dmEXurIIekeFp3ejguq0BB3D2htDZFEoP1MtnIJ9gEV8pZFzqKUnYsoQNAedf3tvXe6Uyf5S0aKIdn9s6UaXamFKbl5jqrrs+iIa49qpObZq+iWHC4domkk8qTHo9BBunYD+AZKpKe0URLh2ZxwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897303; c=relaxed/simple;
	bh=sHpXL9pzCu8NeSJ6MEM+g6ho1wCyWVn7yBxNMFJaVk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry9lro/eXfFG88yMmF3QUSlR51Ah1xb7sMkkOpSmB7MFKhUs0didWuYEQJNBTimZHi9wOu9rOnaNKiGG/2mv7A3aGp58pWHXIEPpzBqOZ/v9mrtbm/xCc1Lwlqh3zNV9+VqPTIf8kEFbko9JwozdsieUpaM2qn8nmb+ajmL3wwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MiBnt57l; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MiBnt57l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr9DXxFLvRGVIfo/4eXsi3fGEoDSP69Tfi4Tcgqe7tpWEO84JipbohGj6AzhZmNUEo9g8io4W6evACH4bGjJL6oBuHTeBRJNHIPsvXfTGVRcN/Rt0Z35CW4k4WCH+ijhuUWhjOyPIXEj5/BSkJTQvFs2qJZoYBadb3aLGb29xW5mUXeb6D0SUS6+jTyxDjjMr1mEKBkb6rAgTIF4vunCwPUkGENy8ObYFvCfC+PCkIYiEYgV6HlbtmF9qrPZO7O1wD0MdYeu+6cHcM0Wq9VOwHcfZs1hFM7nRK/MzFSTQeDxW7Vfuvd7pqLzM7ORyeBGPEbElJrPsW8sDP4pAx7RAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcAy7yPNPXFRoiWQ8XImcU4e97oypaxzIk3vVvDqaxQ=;
 b=r7bW7S0Zc97rnXfD3GYcCO4R8v7WsULZlpviQ9sxdCVn4Q06rlGz2GA34Yioi0lwaZA6wboyQhK+49k7ZTI+2yg/y3EM8BDAKkUgwxp0dltVNsCjb7kdOwsNcIPhmyfq/y4EBYrV0t6Nifwc9zEnnGVFxqanhBA8TVvLvTC4UBp6uYvb22ltEk2y79MA8QBdrl6Sq3gAEtXzVz4JSvSG9gp5kS3y9qbv192Rn7hkkuBjCRcUZXitm7sTKXIM8wQDnfOhjG2dLVRoEbh35JastxDAo2tQiLKBrFFUY4V4rCJyXFYGYmOBZjMxA9sjUkIBpNOxwI4D9Se7iQyqDQq+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcAy7yPNPXFRoiWQ8XImcU4e97oypaxzIk3vVvDqaxQ=;
 b=MiBnt57lomOgmi7xMXAESM0UK98S3dlKn/OhcKI2SeB/zHbxLuwatTDbNcMOvnrZaTziUIMkd1gZZieBLmzfwrADmsZ80YwvrZhQUjRisn3eawpWNyWyCW+dTN08PMnjI4rQ8pVhYZ5ce9JdoNYcy/k7f2p5yl56XxWWb8rnmQ4=
Received: from BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:41:36 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::1e) by BLAPR03CA0004.outlook.office365.com
 (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:41:36 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:41:36 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 04/17] cxl/core: Add CXL.cache device struct
Date: Tue, 11 Nov 2025 15:40:19 -0600
Message-ID: <20251111214032.8188-5-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3deba67e-fafb-45a0-d39f-08de216b1710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HPqM7Pf/435ZMRXBwI/+MswxEyil5K/4jSD1m5wNV50AGTHhMqOzbA17DK81?=
 =?us-ascii?Q?LYccxDHDI0qQvwaANpLs7Qs7he8ruoCdzyYdYdyjioF+anELmPhFoNmZBqoT?=
 =?us-ascii?Q?sql4lQh/ZUIcBm2KHV8L4CsNDUw1BopTnhIAatMQn4Fx06SK5hkL8X4BM1yV?=
 =?us-ascii?Q?1gy3pGAm04ucF5+Y6nxatRyp71sjST0Z1UuspYauOHMW05M5lP+W4t2akO+K?=
 =?us-ascii?Q?atuYBHUNr7eRc0VKv5U0vmGEhouurJGzpp4Yoa24upGscxOA2UuVCq/RZ0AK?=
 =?us-ascii?Q?d64PUIe/qA/4QEw7SVONzsWxjOeKBgVm0bykwJ+NNh2ZyDh3w2lHRZ9xC+Ax?=
 =?us-ascii?Q?VgJm0TYCtUvQsfeYVK65SLfLGjEMxSxlbLeVHchXMhLM/6Jg9XECAWozM0J3?=
 =?us-ascii?Q?1t7DPwBDGMrG44ZG9WDIUZYoLA884j4vkQU2BPW2bXSq7G2wi0FyUH1h3IjG?=
 =?us-ascii?Q?9wHknlSLK/Pw7WWIYRPuLvwim5eINIyBU00Cwthee+58XsasiQf/smRLx3Ot?=
 =?us-ascii?Q?ljNJ4Ywgnmj5C4eWWwpH/ruQxntDL5z63YF20RWUfUTxgrdR6X2E5aub9BxJ?=
 =?us-ascii?Q?2kR80agBv566gZhPhUv0Fh12/lLNjVv0qttF+R4GFr+WJm6ttGx/LuRMfGRH?=
 =?us-ascii?Q?7c/ZYrdoMSy9lob1VK9dn2uqWdx77cIMFnr/YDops7tEBKlypjTaDb1q1GLe?=
 =?us-ascii?Q?Jy8vIeRHHDcHcVGTsTxCC9PPR3uf/3VKhOWxsJtCGjk3yVn7uNbwg70RofJz?=
 =?us-ascii?Q?0+vn0ERef5QRMK0sgkHzRztjrHAfIKZeSrpbur81bSZaKhJMNz6yQZj8gip3?=
 =?us-ascii?Q?AJ967SEFm+JESnIVX33NywqOXw7RJC/9IcfXUi+Z/mkBftQNty+IUG89asT0?=
 =?us-ascii?Q?RxRS+DMnWPa9iZKbZ6VAsz4GV7WtTKErHDd8lMCc7qfBpn4u3Wr1ohbF1X+V?=
 =?us-ascii?Q?5dhgM6JfTF9IKlUWQYg8N+/5WfrvFnnj+MXKDBD4DmS9NJHoqzGPeLE7cWKV?=
 =?us-ascii?Q?VMRQ1giIQpSU6OdZ1lyuL/2REBTbpUqfkczQXjA2k07doJNdjOCuF0qLjnFp?=
 =?us-ascii?Q?D3EXMhGwjSOtldBogk+uJOX70mfq12EXhnvVJWQogkrOfKiutXNq5kMrjBt7?=
 =?us-ascii?Q?NBWBY5TlGAgL6zngUX2NdRLsXaM1pB5BnvHLAtEsw8QKvXVxld/0lKm9B1sd?=
 =?us-ascii?Q?5Y/PHyqWg2VmufAPYj6sx0JkFuDmS8cDIiF+uRtKIfWXwOC438ZpSD+HVxSf?=
 =?us-ascii?Q?xyN4kgsCHzBnoaBGbUCNNuTTJCDZGnBpx4/AEd1AediMN6O1bOkq5MDzBPJZ?=
 =?us-ascii?Q?H7i9FesfpgBmaDN+XxwEZ2ePya7L5Up3DpNM7OrZGSKOA07MJEVyhj8a6D8o?=
 =?us-ascii?Q?IkFO19ezLYGe+4AK2VTKWwGTgNJojf4neV3C8R1uy2ahlBfhmdxLF+//bVyW?=
 =?us-ascii?Q?vBJWQNv4WS6Db/pQJJjniHycmJzyB3/Z+a94C8b40c0nxjIegWDqqldXwxFQ?=
 =?us-ascii?Q?LZXyDu9XC+JR61bPxfQ+h1HAIVuIbCcNUFuKrvVy2fAQVfqFA9wlZ7PBHqmS?=
 =?us-ascii?Q?wAPnqGV54PW1K3xafbs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:41:36.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deba67e-fafb-45a0-d39f-08de216b1710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

Add a new CXL.cache device (struct cxl_cachedev) that is the cache
analogue to struct cxl_memdev. This device will be created by
endpoint vendor-specific drivers to enable and manage the cache
capabilities of the endpoint.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/Makefile   |  1 +
 drivers/cxl/core/cachedev.c | 95 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c     |  3 ++
 drivers/cxl/cxl.h           |  3 ++
 drivers/cxl/cxlcache.h      | 25 ++++++++++
 drivers/cxl/private.h       |  4 ++
 6 files changed, 131 insertions(+)
 create mode 100644 drivers/cxl/core/cachedev.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..94db05d1f351 100644
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
index 000000000000..5693a63baa9b
--- /dev/null
+++ b/drivers/cxl/core/cachedev.c
@@ -0,0 +1,95 @@
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
+	device_del(&cxlcd->dev);
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
+struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds)
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
+	rc = device_add(&cxlcd->dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = devm_add_action_or_reset(host, cxl_cachedev_unregister, cxlcd);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return cxlcd;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_cachedev_add_or_reset, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8128fd2b5b31..603cf862e311 100644
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
@@ -77,6 +78,8 @@ static int cxl_device_id(const struct device *dev)
 		return CXL_DEVICE_REGION;
 	if (dev->type == &cxl_pmu_type)
 		return CXL_DEVICE_PMU;
+	if (is_cxl_cachedev(dev))
+		return CXL_DEVICE_ACCELERATOR;
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 259d806fb3e3..4cf8ca3a2494 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -779,6 +779,7 @@ struct cxl_cache_state {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @cxlcd: The device representing the CXL.cache capabilities of @dev
  * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
@@ -796,6 +797,7 @@ struct cxl_cache_state {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_cachedev *cxlcd;
 	struct cxl_register_map reg_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
@@ -982,6 +984,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_ACCELERATOR		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 8f8597755947..24ec8dddefe7 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -3,5 +3,30 @@
 #define __CXL_CACHE_H__
 #include "cxl.h"
 
+/**
+ * struct cxl_cachedev - CXL bus object representing a cache-capable CXL device
+ * @dev: driver core device object
+ * @cxlds: device state backing this device
+ * @endpoint: connection to the CXL port topology for this device
+ * @ops: caller specific probe routine
+ * @id: id number of this cachedev instance
+ * @depth: endpoint port depth in hierarchy
+ */
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
+
 int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds);
 #endif
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index ff517452e735..25e6bce2457f 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -12,4 +12,8 @@
 #define __CXL_PRIVATE_H__
 int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 			  struct cxl_dport *parent_dport);
+
+struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds);
+struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
+						    struct cxl_cachedev *cxlcd);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.51.1

