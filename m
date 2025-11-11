Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674B326949
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897455; cv=fail; b=u8Q9jkIKXb7K/XFf+PKSJlsu2/eDRKyopg5OWRTf2bL32W2qhNDSQKk+w98j67kRHRxji/RA95DyS/UENMHKJenEuxXLZPOKwntCgt1uTFOSK+6BTcQ5NkXzRAC7pfYXUjvNcEtAauO53hiD+XAgUREsmUJfVCa6G8RaklC9oRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897455; c=relaxed/simple;
	bh=JATTLtR+XovAPEgdKoUtnyNJA/ZLZ1hzHyVOeBUeA0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaI2czlRgct5o8fQ2XkJP9uaMVHQS9Z4qpp90NQZgqmFPn5Q/DDUwURZTPkHtbc/hTjW5BbhFb2xrJyG8bUfx+qXhGiotMQ3Gm4tdWQ49Sndwm3MBIX2Zo1HokEHu4r08fQy5ZT4Ir2F9NbcEq+Iz02OWU74yACwVBBxt+7/ZpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEjDIQNC; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEjDIQNC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxQ+FON2nN6gBdTjaksbo8luFLGFKeJtO0850j553vqT4mMi+2iLunWICZuYoRfaiH33peh73Hh1F7QvxwqqCM1u0yxn24RLEp4VxcPo4N5n3SQoGvCQN3rjUsndhEsYiTnXsEgWtybu/sc0WRRFMcsdr9TTK1p0lXgd9qnhHBThTPXsZfLmNR7wsjCWUbe5xXDeY9CzSXo7h9BpYFb9FFtO/UsI8Q3XHSiphCHvYO46LBvRrTbjnPfipP/jcs+AbQlWW3dC5PLhrsZUED4CUOLrtVf3TQmf7dgNgCVehVu58CrTM+XsNRaCyLPSuXh07DIVAzefxmpow4nv534hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3zloyIa6XyTI3AF0LCx3K1HoS+54QlsGMmRE7gorBI=;
 b=sfZyw1AOSu6YGPJ0NPOUz/ZK/OzLiOoEjT9hFGF6cfdxutibyOAowc6PvIDvj1iVWK0Uaoa9oMLMxs2DgodqCU3hIsob+jQqkel2sUjyzLB/GHmM0W8poljE4qpxhIwreqaVlfncyiaD2bDdw0MJL6pJseP5CFSGVd2/C15Sg3UeoMTFpsoC47/eCeh+D9vERCBiTanloVnOC+8qBplZ1cpH3cDcQHBOmRFsHj+7kOY5NhuRgJG/sEA0AFHFBjOSsiA3KvKnND/L+aTxUKUENFSczch/bCHrgl8d+uXvW6iZR9WAkIyY5nLP6UgH7eLD35ptpStBHIy9oNO3LFomDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3zloyIa6XyTI3AF0LCx3K1HoS+54QlsGMmRE7gorBI=;
 b=DEjDIQNCh3r9aSjsE+LcckT6YUUXB8ErPk8B9BH1QeTm/AEKUbjfXlNhGAhdRcEHxUom9FOBdZsNeBc0Y1pgBCpCC6LJSTZedPKkvimivmf7AsqMySPeQ7RcfOlqwAR9DocjBSOEMfnbHPWEDEEmXIVp1t0Ahze+Eez/wgBhvMw=
Received: from SJ0PR13CA0163.namprd13.prod.outlook.com (2603:10b6:a03:2c7::18)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:44:04 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::da) by SJ0PR13CA0163.outlook.office365.com
 (2603:10b6:a03:2c7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:44:03 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:44:00 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 16/17] cxl/core: Add cache device attributes
Date: Tue, 11 Nov 2025 15:40:31 -0600
Message-ID: <20251111214032.8188-17-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2fa7d6-c6b6-4734-665e-08de216b6ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cS9EpUqozP1wdfhdRCPz4P7vJQnpjKdPBVTXkx2Dh1Cd3cERbI25t7i7ujDS?=
 =?us-ascii?Q?LuwJuHED69uT1wYYNnk8rtgLDQsfu7MA3b71r6nLe326R5JSVFn+jlxow1aJ?=
 =?us-ascii?Q?16wvmW4wlf6ks4k1O9D/0C4v1rYm8c/NMqLKheE4nKliHlJcWl6M0e+91Y3Q?=
 =?us-ascii?Q?HrQ6x1fA6HQgrcaA5dYVyGlK5jdcYurKn7aequ4hqt7oxdIwIeWkXg4xWizw?=
 =?us-ascii?Q?UXAGlN9H3zwn3yElPYEShnOZJMvspkGuhVsf/Jc0MNTr1wSIWy0vox0DtV4N?=
 =?us-ascii?Q?kAM6iI7/P3wHYeKW55PmHOlyH9Uq+C4zbTcLspgB2Lrg1mkEVeUwBvPtYR86?=
 =?us-ascii?Q?rsN0CMhjiFVi3tR4bgcGXcpTQH/ZxUhNJCOnJbMrPG5BUwjpTHG9BZMCH+aW?=
 =?us-ascii?Q?ZFzfqwfUl3Hdx81JEPZFpmN69AfOm6GodqFDOAl9abZ96traDekEsgHIZXfK?=
 =?us-ascii?Q?Xn/91GZAjR6mETvdxhSs652Ev4XtNMoit+HfJcl7ocBft+FwaDvKPjpKNguv?=
 =?us-ascii?Q?AuVOetSnNBqvSU0etxulyBherRNcz3Jqu/lbLlmavjGtZezwqlvA3Fg+Ekuz?=
 =?us-ascii?Q?1hAADnMDrXfTiOEo2TaVw44RvfZ55J1I7DnDtk3yVW/VSWkT+L/kDZY6eO6P?=
 =?us-ascii?Q?vkzTW0dDtw4ax/2E9nuEIidZSPC51OvXRddCz2/JDezR6NCTKiR6eA4Mefu9?=
 =?us-ascii?Q?xBDLy5/fbRmnG1o6usXI4QyAFvgpgnNNjyVfh/1cRdZdnoXJ/H5dXfP82CW9?=
 =?us-ascii?Q?WKU/DWlPA4wvwqAqVrUj5nSbZUmBRF/gezvJJleu/HeeuTeQFoDbW5EMSTtu?=
 =?us-ascii?Q?CA+krWmEJBwZDUcrt5TRh4g3tSW3xcrZUkjJKhkUFAgmJmmRw7MDrOsmZkeF?=
 =?us-ascii?Q?AbVQboRS4iD0Fx+WuHCC5qK/d1WMEXJnvNblSEkGlz2KRTIOd+nSaXp/5Hs9?=
 =?us-ascii?Q?8rgLgFXGs7cRjPspBsLSHUeJ28LtJXBVozVIsUhLo1uNlKMMD/MUAlcLuebV?=
 =?us-ascii?Q?6+OIx+MXjNes2lMB8+jQPRQFYHrBnYSNnlxFVE2wxvZn9jmf61kC9t4ETsbO?=
 =?us-ascii?Q?vnvzeo/7N/Hj1D5U/KbLvCnjy3GEStHWiIw3rgK9rq+on4DJ41wIUVrWC0a/?=
 =?us-ascii?Q?fO0RIO6Ga7AcbJ92CgvtoUhEow0BZc8FjZCDf6vV1D7Rh5fZAwgQNWj+6CtB?=
 =?us-ascii?Q?GWKxrawuTvncLurkpxBLweqg0ULb67SPZtMw4FQfeVslVY2Z6mKimnpyeicS?=
 =?us-ascii?Q?k0E2OOmH6vkQRSg/GUPe7bS5Ob6tIMtyEX0KXDYpkABdvYF/aS4nztr85Cb9?=
 =?us-ascii?Q?L7ASxIuvKETzBCCwbjUaUTe+WdQIbZmkAvKvvPY83S0+HBP6PgkIZfH9Jcc9?=
 =?us-ascii?Q?g/t6FYtpeb0IVsK1j9JY7rx2fBgA+3x7FlbFTLzp4MNnnt2tqLKM+d8EvwCk?=
 =?us-ascii?Q?CYV2Msw6o2WXFl1ROTODUUv/MT1mSDJxuM+7Eq9tGFuX+R3xP7uDg64YcIXe?=
 =?us-ascii?Q?7Lx1KnQIa0DjinDp1mUlhJo1sh1+0YxZp+bpqlyVdz6iK5iJ13fm8/MmElFi?=
 =?us-ascii?Q?Ltkc+OG0tTczCp77wCI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:44:03.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2fa7d6-c6b6-4734-665e-08de216b6ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948

Add sysfs attributes for getting the numa node, CXL cache unit, and
CXL cache size for a cachedev.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/cachedev.c | 85 +++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index 0b7430450b4e..d8bf18ec0579 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2025 Advanced Micro Devices, Inc. */
+#include <linux/string_helpers.h>
 #include <linux/device.h>
 #include <linux/pci.h>
 #include "cxlpci.h"
@@ -32,10 +33,94 @@ static char *cxl_cachedev_devnode(const struct device *dev, umode_t *mode,
 	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
 }
 
+static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
+static struct attribute *cxl_cachedev_attributes[] = {
+	&dev_attr_numa_node.attr,
+	NULL
+};
+
+static umode_t cxl_cachedev_visible(struct kobject *kobj, struct attribute *a,
+				    int n)
+{
+	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
+		return 0;
+	return a->mode;
+}
+
+static struct attribute_group cxl_cachedev_attribute_group = {
+	.attrs = cxl_cachedev_attributes,
+	.is_visible = cxl_cachedev_visible,
+};
+
+static ssize_t cache_size_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct cxl_cache_state cstate = cxlds->cstate;
+
+	return sysfs_emit(buf, "%llu\n", cstate.size);
+}
+static DEVICE_ATTR_RO(cache_size);
+
+static ssize_t cache_unit_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct cxl_cache_state cstate = cxlds->cstate;
+	char unit_buf[32];
+	int rc;
+
+	rc = string_get_size(cstate.size, 1, STRING_UNITS_2, unit_buf,
+			     sizeof(unit_buf) - 1);
+	if (rc <= 0)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%s\n", unit_buf);
+}
+static DEVICE_ATTR_RO(cache_unit);
+
+static struct attribute *cxl_cachedev_cache_attributes[] = {
+	&dev_attr_cache_size.attr,
+	&dev_attr_cache_unit.attr,
+	NULL
+};
+
+static umode_t cxl_cachedev_cache_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+
+	if (!cxlds || cxlds->cstate.size == 0)
+		return 0;
+	return a->mode;
+}
+
+static struct attribute_group cxl_cachedev_cache_attribute_group = {
+	.attrs = cxl_cachedev_cache_attributes,
+	.is_visible = cxl_cachedev_cache_visible,
+};
+
+static const struct attribute_group *cxl_cachedev_attribute_groups[] = {
+	&cxl_cachedev_attribute_group,
+	&cxl_cachedev_cache_attribute_group,
+	NULL
+};
+
 static const struct device_type cxl_cachedev_type = {
 	.name = "cxl_cachedev",
 	.release = cxl_cachedev_release,
 	.devnode = cxl_cachedev_devnode,
+	.groups = cxl_cachedev_attribute_groups,
 };
 
 bool is_cxl_cachedev(const struct device *dev)
-- 
2.51.1

