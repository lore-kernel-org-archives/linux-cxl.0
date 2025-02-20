Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869E2E630
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081659; cv=fail; b=eISO9JuzTKYmxqXIAtevecqm9t4Ww8qUrSmMEhx2ki8jm58E/nmFUSd7O2cZt8uZICKwykZB0ZqWNR1kZZA4K9oiJP6zY4RKAGM8rhJScMhQaMrUh1/xpRsbzA+tzkqByNQRLr1A4DSvKMRzRtf5dlDLoQaJ5HoYRLUfuBgpVio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081659; c=relaxed/simple;
	bh=tXYCGHfB6Z3Y4HHdoIRYSYNS0q73AFwT1rptBa2WE0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGzGSNV2se4GxZxQx11c0NAxJzf4lsHTT0xzkSUK+qSGZBDJjgczFjspHSqsL+DSeHH4+s5hoJ1G9eRfPq04E8eUJbAR0W842484cuX22FJN8KaJhJOIcyoyJ+QBC9MzZwJaXUQSQG7vui85TgOSrESIT8qM1rmLrpmW0p6Go7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f/UEAEci; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f/UEAEci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMs+uy6lFyQhLry+HO6t63hwqCT8Pi7ARWJ57YFXWFd4r5s9m200tN6kPsTVyHVtJOluhZ7kx+vHwFJ3i3OkGJc9mkLqmbVYAKxNPNddlwuBB5Pg4SiCfCeuXQ/s7wmFn/JUcOL4MHSsBIoDZ6TfVdqIvJDWTuQXRcKhJ7dm0hiRgjqJXbFZqDB1EYSFukV1PXiIyPj5xf0vA2pB+e7Agl2Qk+OMAHhDWNItYa9uw4fG3lWSbA7vaMtKVu5i+oDpe+gG5LmlpgYHIac1w+wn4BHdduGViyfDQGR/HoNw6dvJ+lL8Bhk0SKcuN1R4G20FwvvJ16ir/o9QsG5/vsOE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuX5p2EVaZJC2GrEIGvccgxunBzx54/xXf3cb6M9TVQ=;
 b=OD8szFDl0Uw6LjYjg28c1ZYb9wtLm1COgJ9tWq96IKL3JZ6lYE86hpPHxgVcl7W2v3krNRFIV4w1Tc1zntlQf82WzgR2w0JmqVkrisyFRQ7L0gdvo85omgrH3OMDf1hkAialKwJOBjF1kwy6d8a3KnnZwhPZqqJXZiTlcURSZtXf3aOO+SNFWxXZWfEeA0MHUHaMFzLNRfl8a1KTzh3UpeVzTDBvZnktX1wm5P9oFMlTM/dH9uZhpP89xUWE37j6h1a/9CZ4PQXqysv/bCs3kfQMupFckMUKfbGbWTuiwrk2kZchuB/LuaESaesxgQDrwF7QOyP1ESl0GUHogxMRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuX5p2EVaZJC2GrEIGvccgxunBzx54/xXf3cb6M9TVQ=;
 b=f/UEAEciVV23rLVTmPzYceNvTMJSNdPOTagQbv2nSq6Gqe553lPuVh1s5DWlTdsOQ7+QUgLQRKavlEPoFoELKWCPMapyzB1gQBnWoD5DJTs+57ZVyUOgaWq5PnrYFkaC+jw+dxnGRbvwp4hjeMwnjxRt3x9rKHk1mXdH2Mhq5c4=
Received: from MW4PR03CA0194.namprd03.prod.outlook.com (2603:10b6:303:b8::19)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 20:00:53 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::43) by MW4PR03CA0194.outlook.office365.com
 (2603:10b6:303:b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 20:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 20:00:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 14:00:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 14:00:52 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Feb 2025 14:00:51 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC type cxl initialization 2/2] sfc: add cxl support
Date: Thu, 20 Feb 2025 20:00:41 +0000
Message-ID: <20250220200041.3891165-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2546a352-50f6-4cd0-2363-08dd51e947ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tCpk3YjzUQz8I6sI66s9IHBcv+36EwEdO13mgbUFLwhYlfHpoY1J370MT1pt?=
 =?us-ascii?Q?J6RdBWZMSswheuvRsBUPUHsD0UCi4LhKfLTwvoGMcaA4PIrAYqUz3BRF9Gfo?=
 =?us-ascii?Q?6st/GaOJjXoE7DHXfDpBI4kFks/aROfk7tURTe+AH5CXJgwRLhr9S9eHH9jj?=
 =?us-ascii?Q?gMhUCxjbQpqNdbYROQFmVJ5V9KIr7MR5NHWe7O9mfuMxy6jSnYgym2nOwfez?=
 =?us-ascii?Q?QSFJ/tlziJP0/z6Ekz0oDtaRRNbRmOEFaeZJ1Q1XmR8t4BYzgsUd/zSWgkyk?=
 =?us-ascii?Q?vO0PjXxcsto/6LlXxL1ai+R89/eaxaDgWKm7xw2knm7/3/TkO3zn7fQ+QAm6?=
 =?us-ascii?Q?YjQCaEgdr343BlxJNOnLLZpmXaA0pvRHvNfoRGSPbp22jTPBAEQtsaOiUQI1?=
 =?us-ascii?Q?74m2ihAuFsDA1+9pbNPOYEMwoi8Uyt7dFvpaM1wtI7JfGcLvnSGwx58pvC6W?=
 =?us-ascii?Q?uvxx5RYOPQlLKNJd9TSUj6OnH3cQkpBKqWQROXSQKVZXahMz2gWWu2tMdHi0?=
 =?us-ascii?Q?hp0aps7redZ3EdKTXHajphOsJ1WmOjnuvPaYpIZI1v5O1Uwdvnu9BhAwoig+?=
 =?us-ascii?Q?aFzXWipWvjKQOWEVo9N1NeghZktOOfU+9Pi8GD0NEu0DTeCqUh1gX9yd3FXm?=
 =?us-ascii?Q?fTzg/nB+33SzGHGsZAsLzwvph7FwmNNAOdtDMfPUrIGwYdsA5gp1csd4PxlJ?=
 =?us-ascii?Q?Bz6k1gVl6VmAWmypDbDCnmW7y3Yun2HtpU89rHpAxXE00Gr/JWJLormpBtyN?=
 =?us-ascii?Q?MEbeGkZUvqR4I7spSR4lYnPWPV4H/MqC64xupEdIWPChaGSUGxDEPlroVe+/?=
 =?us-ascii?Q?iI5y0S6KgKFxlDIARAFhxBTTcrORlQgL8rmrjnTr1yvFrIySiNcnlLUoz/mA?=
 =?us-ascii?Q?Pq/9vjfNohFZ/kHCbhalLYerQV/GVUfXGmxBf2DaYrndePbDjn1/CRB/pK2v?=
 =?us-ascii?Q?nSGc8NAQoTNTsYofiJoxmg5FILhNWSJDCY13/PIQ26d4Bs2qazIMT/7D1pLG?=
 =?us-ascii?Q?hb/x1uC40Sq3+XZEoUd9oiR/DSYraJL0mYwkzhlXjx1vIXMm6QSKVcI40qvW?=
 =?us-ascii?Q?7kvrNE8RH6YBNg0iAjLi3D8/bqoYrNVK0q7gPpfkQrrHxrt+nKgCGOHBvc+6?=
 =?us-ascii?Q?4N0wYgiezTAkahXvYn8AnwcPpfFjwfPcXrBYnC5j29w8NapsZEBz3jdqqGZc?=
 =?us-ascii?Q?5QlBq2K5fVjsbtGfW3qWpChRI5pVGAGaRU3e/KFewSe/T0ONo4ULXgCwMpbH?=
 =?us-ascii?Q?IlQJJE7wkKtLHatv0Qip8beW0B14AFJB47xT2ykjmdAdUwAa2pcXlJfWP4SD?=
 =?us-ascii?Q?mb3MYWiRfK7s4Ak174Rgssn2IhKZtSzIsF/WzBEzc9VDkIgx64iqayK2v7+y?=
 =?us-ascii?Q?Ry1I+pcjxSFv1ZPIBzdZ3wPagobdNLb2m9x55XAuXc7wXA4Z3WmELq1egTPi?=
 =?us-ascii?Q?atBRF1oQalVG8hnCsB0XivxwQNKh+Xg1DKkanKm4pHMcmSPfH0n6HWtQAs9O?=
 =?us-ascii?Q?S6FauwNVUvRnWFY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:00:53.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2546a352-50f6-4cd0-2363-08dd51e947ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  6 +++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 53 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 ++++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 3eb55dcfa8a6..459db14e5ef9 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -65,6 +65,12 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
+	depends on CXL_BUS >= SFC
+	default SFC
+
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
 source "drivers/net/ethernet/sfc/siena/Kconfig"
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..e909cafd5908 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
 
+sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
 obj-$(CONFIG_SFC)	+= sfc.o
 
 obj-$(CONFIG_SFC_FALCON) += falcon/
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 650136dfc642..f60f9153f018 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -1004,12 +1005,15 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1214,6 +1218,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..d34aedbcaddf
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include <cxl/pci.h>
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+
+int efx_cxl_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	u16 dvsec;
+
+	probe_data->cxl_pio_initialised = false;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		return 0;
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	cxl = cxl_dev_state_create(&pci_dev->dev, pci_dev->dev.id,
+					  dvsec, struct efx_cxl, cxlds);
+
+	if (!cxl)
+		return -ENOMEM;
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+	if (probe_data->cxl)
+		kfree(probe_data->cxl);
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..67be714b57d1
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+#ifdef CONFIG_SFC_CXL
+
+#include <cxl/cxl.h>
+
+struct cxl_root_decoder;
+struct cxl_port;
+struct cxl_endpoint_decoder;
+struct cxl_region;
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_port *endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *efx_region;
+	void __iomem *ctpio_cxl;
+};
+
+int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
+#else
+inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f70a7b7d6345..a2626bcd6a41 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1201,14 +1201,24 @@ struct efx_nic {
 	atomic_t n_rx_noskb_drops;
 };
 
+#ifdef CONFIG_SFC_CXL
+struct efx_cxl;
+#endif
+
 /**
  * struct efx_probe_data - State after hardware probe
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
+ * @cxl: details of related cxl objects
+ * @cxl_pio_initialised: cxl initialization outcome.
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
+#ifdef CONFIG_SFC_CXL
+	struct efx_cxl *cxl;
+	bool cxl_pio_initialised;
+#endif
 };
 
 static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
-- 
2.34.1

