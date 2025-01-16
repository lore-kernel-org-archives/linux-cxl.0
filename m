Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B724A7C6
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049383; cv=fail; b=mboeg1ieJDFB/+zRlEzFt2G+bOTmVVJqYpKWuy0YbNHZg4SbpsS01dPZ0vf5WY8NZGKxj6bDKkGVvDmtroCgBiGEwli0JAR2SyFS/K06gweDGv9tymNvgmZclKAt+sASaC0UEaERYroDdhap7uCO9hHIhmyRCbhC6ow9i2V8UZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049383; c=relaxed/simple;
	bh=HPfZjn42Ryd3Jgpyjng5xFQSYmgm6l8QPIiegIxUHaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psxv3Cn9B39J3UJRbTAbehZ15gHk8QuOtpqbhOLMcLVkRDmtv0xw4v3O2VlhuDj1HV0FZlu2pHJnAar535UoKaqMMDSJ84HKjLSdC/7lgUV5KCOhiDCATKE0IAhG9ZKFYkNcI7XrVemJC1ur0uZvMYiqpBHOYm+b/CMBPZIS1WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TyzNYf7x; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TyzNYf7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5PjuMmfOXWpTU4z8bUycDEqu+PQUDbnc3SUCcImCihc3LQ6HsNqnQcKM6Au87w73asuHeHf35Ll/SlBAiSGS9C161mL3TmKM2qoWJjPxE3+7saO+w/LcB2jpu5jUKjpR6ofOIjH8cCnlwyQ2WG0wU4byCijPYJxpvfYUwvTafVlDnfXcDp7QUTbsodrX2h26epfCllqjEoPhRxHNM8rQHlAoAxqaNGGNG2gTbcAGA3WXEfBPtBAUmhrk2xE7kXtYsIJjwq3jdHws741ANAxAKhvmjmYSI+mGfvc53xUcGXTTEZkmCsin+r/QwK7f4oihxcbSlm8gjWM1rTLa3JpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBU4OM2e/K9qgr8+Hy0dp7OoswFL4Z2DWJlCcpmN5AM=;
 b=AyyKRPj8hdNf3EUVvcI2vbScleeM/qAnP5EB+vLGF4FeeOrxgrrYCEXfl+1PpAOVh8Hh+1Yq5kV3qQ7w8dYdfs82A6NbhRNDnKjD7rh/tk3QV3FWb+KxdPCLKYIyPwZy92rPpvQp+DFaSsUcBhO/DnulKHbqapOb7aSIvORihVpRPmhLP28SplXbGiVOHohDTcEOp++OpHBrwZv1Xrxo5Am4xaXBq8VJD4EOhCGfXKXc3PJENs4VtFcQZMjyA7q9AH1V/6rhSuaqUyPKblQ+epVoKGM4NnFjDCahEecDHBm3wvkGjIaJkZSPPU16ihZPHnUHVJUa8LF5yt3uvLu/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBU4OM2e/K9qgr8+Hy0dp7OoswFL4Z2DWJlCcpmN5AM=;
 b=TyzNYf7x0lYnlAeo5UFOZtwfFFrmBROpXjdAVz34SWllE/s+vzqjb7/JNCdV/0XKXxuO1Uv6Qb1h4kGHREXppYMJUNNIKCSkW3VMj3IU60q6c5/KUcYduSmgtfLpDD3Nu7SfJtDBJ4YK036VE+6hQ7lDVCCqllO74llGB63Go+I=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 17:42:57 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::b) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 17:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 17:42:57 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 11:42:56 -0600
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: [PATCH v2 2/4] cxl: Update Soft Reserve resources upon region creation
Date: Thu, 16 Jan 2025 11:42:06 -0600
Message-ID: <46f9193747024c336b998da64585f2dc2b58a5d1.1737046620.git.nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737046620.git.nathan.fontenot@amd.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a19366e-56dd-4793-a079-08dd365536d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4L+T2/yRWpx+c5CjHLqt7Wy40u2FVDXVrZ1uNTjzjO1oirU2eMsTiYHHuHGv?=
 =?us-ascii?Q?5PNElyZv7axmsr+WkgtVgVb7b4x7xSPjs4b9FhnMgmFt77g8K/eGDkHiRT5j?=
 =?us-ascii?Q?95FW4w43mgD0t7K5qdbYrpSqMYjX9CYOpMx82Gd7vxASkYxx+wSovAlRtfd7?=
 =?us-ascii?Q?1hK5ZRrT+kEsNwN4X0BjJ4z4g2JYZIt84Xjl+y2cfBdKSOrSrNNCn3vkLuIG?=
 =?us-ascii?Q?knewaTHi/CdHLNBKoBwubLfQXek7xHCKYvX2I1TVLBhOQrf/5dwfNzEKPtVb?=
 =?us-ascii?Q?0vKQ6d51L2DQGkTqRdnlEBP+Ao+KEQb8c1BVM7IjBqxC/zVDGcrgkUxx0Eow?=
 =?us-ascii?Q?ApOCn/5lXo/eD1QDFtHV6UTIv5ZijVquZRvJqa0lhPcPBdtZhYAHXA+UTvmC?=
 =?us-ascii?Q?1nzsIiCchjvEW4leQq4ADKnvdIFHoP4cYzhQu5dMvjI/fG1fnVoLaw9t8MyY?=
 =?us-ascii?Q?BLJPUBWaDeJ4YibJ91pVgUb2WkTiB08LoaoO9gRQdW4SWdJD5ED3y0gjNXFj?=
 =?us-ascii?Q?Xi2YHp2UoVs3r6hsDuUYau2rClRVdRv5DnH5rYnpQHMk0zia3KV/MJsFAQmN?=
 =?us-ascii?Q?oPtxFvnZdAIeysOqnJFTpCZ0GN50khidnrVzQdb82Zn+BQ8qC/GRb03kfBt7?=
 =?us-ascii?Q?xhRsDd7gEG6NxdOMeYt70xh/4A8iymyuMcX+4e1rlQyY5Re1BgJTg+xCRgTQ?=
 =?us-ascii?Q?fG6zBU0ifwMfdNXF/lf7LPJswDGbVJ2pE/m6kDoe3dMHHNjxRTQeX7jRK0Mc?=
 =?us-ascii?Q?35IQcNvDh770NwLQoUDzp2rAo7jZkp/6UVsOyENLmBfMgu5MSMSXfEPWrlpI?=
 =?us-ascii?Q?ZTFwfZw+Md0jW9/gtB4DWe7A/ZBBUt27KNQxB1ntZnKX73vUhsX8k3sZKKHB?=
 =?us-ascii?Q?nepiVT7pj+CbwjdwsmCs74A8RKYRxHqAulSHaIxafvfCi+n8tRvZYOdR0aZQ?=
 =?us-ascii?Q?JunQTkEgnksA+mpU2L7hIwcEC1DT7kT6dJrw5IycWmWnPCf7s7d5msBuUVV5?=
 =?us-ascii?Q?vVu7y0jJ2pw3g8HltFIeBdW5WCcWRpDmGQYUHK1DgEj6bsNhUrBesgNqHntU?=
 =?us-ascii?Q?mphyEJN7QdVniA2tGpCdCupUltYqL8ZSkSaJx+1Rf0kQczZihUbQNhz3HYTQ?=
 =?us-ascii?Q?jBTGNr0Y7RAGmSUuPt9m4oPoX30STTP3UZBsOzitsV/ZNwDkwjYx0nGuUOiy?=
 =?us-ascii?Q?sF/PgX8rw5ZV3P48haes8C66LPMUWiFJunBNXnVoNtOem4CnfGtiZKjav63b?=
 =?us-ascii?Q?PrVaSmHHrdGJz1VzihwjS6zu7AkI22cMuTkwDpfA+mn1LbceY0TMrvvgsOAt?=
 =?us-ascii?Q?wq4oomkZdw35zYufn6FcyGC3O23HM2XCYelnCrCkD72qFDtD0JgGzEMaoUP5?=
 =?us-ascii?Q?xHBKeMPfutq4KvjcdxKm08YBPDp/wldRSWYCAz393zT2E5SwZ+q6rIme0voZ?=
 =?us-ascii?Q?1pAVAmrca8jeNiNX6dS0K7/MEWLYeEZa0GtYnWrkHrY/sJpP0uzAtJx507zq?=
 =?us-ascii?Q?2pdwWZMt/8eijv8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:42:57.6140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a19366e-56dd-4793-a079-08dd365536d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

Update handling of SOFT RESERVE iomem resources that intersect with
CXL region resources to remove intersections from the SOFT RESERVE
resources. The current approach of leaving SOFT RESERVE resources as
is can cause failures during hotplug replace of CXL devices bercause
the resource is not avaialable for reuse after teardown of the CXL device.

The approach is to use the CONFIG_SOFT_RESERVED_MANAGED config option
to have SOFT RESERVE resources set aside during boot. After the CXL
drivers complete their probe and CXL regions are created any CXL
region intersections with SOFT RESERVE resources are removed from the
SOFT RESERVE resource. The remaining SOFT RESERVE resources, if any,
are then added to the iomem resource tree.

To accomplish this the cxl acpi driver creates a worker thread at the
end of cxl_acpi_probe(). This worker thread first waits for the CXL PCI
CXL mem drivers have loaded. The cxl core/suspend.c code is updated to
add a pci_loaded variable, in addition to the mem_active variable, that
is updated when the pci driver loads. A new cxl_wait_for_pci_mem() routine
uses a waitqueue for both these driver to be loaded. The need to add
this additional waitqueue is ensure the CXL PCI and CXL mem drivers
have loaded before we wait for their probe, without it the cxl acpi probe
worker thread calls wait_for_device_probe() before these drivers
are loaded.

After the CXL PCI and CXL mem drivers load the cxl acpi worker thread
uses wait_for_device_probe() to ensure device probe routines have
completed.

After probe completes, find all cxl regions that have been created and
remove any intersections with SOFT RESERVE resources and add remaining
SOFT RESERRVES to the iomem resource tree.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 drivers/cxl/Kconfig        |  1 +
 drivers/cxl/acpi.c         | 26 ++++++++++++++++++++++++
 drivers/cxl/core/Makefile  |  2 +-
 drivers/cxl/core/region.c  | 25 ++++++++++++++++++++++-
 drivers/cxl/core/suspend.c | 41 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h          |  3 +++
 drivers/cxl/cxlmem.h       |  9 ---------
 drivers/cxl/cxlpci.h       |  2 ++
 drivers/cxl/pci.c          |  1 +
 9 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 99b5c25be079..5d9dce2fb282 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -60,6 +60,7 @@ config CXL_ACPI
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT
+	select SOFT_RESERVED_MANAGED
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.  See
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8e..a95004230f85 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,8 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/node.h>
+#include <linux/pm.h>
+#include <linux/workqueue.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
@@ -813,6 +815,27 @@ static int pair_cxl_resource(struct device *dev, void *data)
 	return 0;
 }
 
+static void cxl_srmem_work_fn(struct work_struct *work)
+{
+	/* Wait for CXL PCI and mem drivers to load */
+	cxl_wait_for_pci_mem();
+
+	/*
+	 * Once the CXL PCI and mem drivers have loaded wait
+	 * for the driver probe routines to complete.
+	 */
+	wait_for_device_probe();
+
+	cxl_region_srmem_update();
+}
+
+DECLARE_WORK(cxl_sr_work, cxl_srmem_work_fn);
+
+static void cxl_srmem_update(void)
+{
+	schedule_work(&cxl_sr_work);
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -887,6 +910,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	cxl_bus_rescan();
+
+	/* Update SOFT RESERVED resources that intersect with CXL regions */
+	cxl_srmem_update();
 	return 0;
 }
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..01587ba1dcdb 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_SUSPEND) += suspend.o
+obj-y += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..3f4a7cc4539b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
+#include <linux/ioport.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -2294,7 +2295,7 @@ const struct device_type cxl_region_type = {
 
 bool is_cxl_region(struct device *dev)
 {
-	return dev->type == &cxl_region_type;
+	return dev && dev->type == &cxl_region_type;
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_region, CXL);
 
@@ -3377,6 +3378,28 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
 
+int cxl_region_srmem_update(void)
+{
+	struct device *dev = NULL;
+	struct cxl_region *cxlr;
+	struct resource *res;
+
+	do {
+		dev = bus_find_next_device(&cxl_bus_type, dev);
+		if (is_cxl_region(dev)) {
+			cxlr = to_cxl_region(dev);
+			res = cxlr->params.res;
+			release_srmem_region_adjustable(res->start,
+							resource_size(res));
+			put_device(dev);
+		}
+	} while (dev);
+
+	merge_srmem_resources();
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_srmem_update, CXL);
+
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
index a5984d96ea1d..589f7fc931ee 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/suspend.c
@@ -2,18 +2,27 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/atomic.h>
 #include <linux/export.h>
+#include <linux/wait.h>
 #include "cxlmem.h"
+#include "cxlpci.h"
 
 static atomic_t mem_active;
 
+static DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
+
+static atomic_t pci_loaded;
+
+#ifdef CONFIG_CXL_SUSPEND
 bool cxl_mem_active(void)
 {
 	return atomic_read(&mem_active) != 0;
 }
+#endif
 
 void cxl_mem_active_inc(void)
 {
 	atomic_inc(&mem_active);
+	wake_up(&cxl_wait_queue);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, CXL);
 
@@ -22,3 +31,35 @@ void cxl_mem_active_dec(void)
 	atomic_dec(&mem_active);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, CXL);
+
+void mark_cxl_pci_loaded(void)
+{
+	atomic_inc(&pci_loaded);
+	wake_up(&cxl_wait_queue);
+}
+EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, CXL);
+
+static bool cxl_pci_loaded(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_PCI))
+		return atomic_read(&pci_loaded) != 0;
+
+	return true;
+}
+
+static bool cxl_mem_probed(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_MEM))
+		return atomic_read(&mem_active) != 0;
+
+	return true;
+}
+
+void cxl_wait_for_pci_mem(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_PCI) || IS_ENABLED(CONFIG_CXL_MEM))
+		wait_event_timeout(cxl_wait_queue,
+				   cxl_pci_loaded() && cxl_mem_probed(),
+				   30 * HZ);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_wait_for_pci_mem, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..65e425e72970 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -861,6 +861,7 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
+int cxl_region_srmem_update(void);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -898,6 +899,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+void cxl_wait_for_pci_mem(void);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..df6bf7778321 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -838,17 +838,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
-#ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
-#else
-static inline void cxl_mem_active_inc(void)
-{
-}
-static inline void cxl_mem_active_dec(void)
-{
-}
-#endif
 
 int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..42d9423ba4c0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -129,4 +129,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+void mark_cxl_pci_loaded(void);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4be35dc22202..d90505e3605c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1054,6 +1054,7 @@ static int __init cxl_pci_driver_init(void)
 	if (rc)
 		pci_unregister_driver(&cxl_pci_driver);
 
+	mark_cxl_pci_loaded();
 	return rc;
 }
 
-- 
2.43.0

