Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF53332EBB
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754869; cv=fail; b=m1/Ss50LOj3Z2fy6Kbn2do1YUUz+qVaEXj+16X3pHv2GsEETUIDj5x0Xw3PL4aVjWLliWZSmlFOo07m8f0gtNNi46NWGP/GL3C1Ex0p3RdOrNWT0bhWCTbHPg45czmzkZd8OKCjFNDZsJUx6QsMCtIukym1TlbCNcZ/yLkhfU04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754869; c=relaxed/simple;
	bh=14+Xf/Y8de6rL8CTlr6xQPcGbwv81SPorzo1pTXuuGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E754d8LMCOFCxtDiuX1Egx6UjIvh/Qfi04q4JT4CLYIcjEKAlqqLtiLsfSURS3tCHImKdMvWkKwMSfBmOpTPo70sb7MBIgFiyzqkIihVirOdRRIS9+Dgs+9T4F/CK6FH3fUBA6BX3WS6Etbwv/MTAU8fh9hnEQzk7KgAN1khbX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fl7PswXn; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fl7PswXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQDee4yeDH+ysT9LD8FNH6M7naKQM4Q9atPT50v3YVBx/UB8Jqh1cQzfZKMMSMys/ZqR2w6OBLo8xMWi55h7jlWHJpEn7uuZC1lfsXnbI3emQ9NCCAv07YrzkRG3HD523vMz02PL4uQROInzSf2w6RbonkBtAgILEA2LzP4y+7Gkz1y3YGV36RYdLrZ9jd8wuJR/Kik1bLGVnZCx4AJ34rg9DLt64TyN7vblg/RI1JW9atEEl7uCJRyHABJbl49cZQnenxLDX4W0mxbzb3zTofmHJLiNFYPDZOPNkHXQQZax32gYbcjv5/mRYORJ123CwaHSSrkmCJ7pg0oDjbPlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwj7PkBZ4S1BvI/EH7sZyihgyBceEXIsPydF6dayqGA=;
 b=w1eG2B9lIZzTTTFvT9hBstO6R/Y4Q1XCoIa1dTXCyXuuqxoGRhOlcu4MkH5HLy46RhwEDRiLnSiHUdMxTaTCo91NzPNqU0b4EY9l00nU+x63db0+5FCfeD8MWQIr07q5J2FceApIDeCRCh1zA8BkNy2xMkC67epdbSDoni2Napn7GUGPMY3S+/Rhua1Qt9aoEmCc4WJCdZJvxF/LTPkU4Hvgs5LEBWxFcuDUCGsfel3hnJr83WNWq9JzYeAfWEI9vbqm8md/mSsNuG04+ZGXWOt9JqwVWVn/yoSNvkRDdkLp9SsYmr09xLiNT0xzgeo/0F7fxbxOL27Fbi8BBscs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwj7PkBZ4S1BvI/EH7sZyihgyBceEXIsPydF6dayqGA=;
 b=fl7PswXnGaYZlXB69txXsaxL/hMcru0ZPPFsujHnTzABKw3KRyPkVu/vpyW6m5tPH010F6yO9a/xg7yVooA5qWAcfW1Ia4oBX8lwa6OfXRzWPgtjbk8cKkSirrxvJ95gOS2rSIroXw1QNSMVuyFhURx3bJxFYMI9gi+yzqBxM3Q=
Received: from CH0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:610:77::19)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 17:41:04 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::4a) by CH0PR04CA0044.outlook.office365.com
 (2603:10b6:610:77::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 17:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 17:41:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 12:41:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 12:41:03 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Mon, 29 Jun 2026 12:41:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH v30 1/2] cxl: Support Type2 cxl regs mapping
Date: Mon, 29 Jun 2026 19:37:26 +0100
Message-ID: <20260629183727.51502-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
References: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b418d13-175a-488e-6fd1-08ded60597e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GpTd9fxqWzQOf/xtHei2pjXCGZyJBVuZo4IuNMLur35YtLoqkX6gDhgaVU+efW1Un+hO9GE5qCZP6nsg5+7QDlcEr/EQV7q35kB0Ttibsf+Twgw/Lna+snS5j9/ckRa4ASCw1pqnvSr/HbT/oKJQQS1cajcc/1XW+/t1AOwMKl80LURTXmAqJa7wQQn3tlTTAP0ZPbR+HtfShpMMinGDpBFh88F6ZH+4B6fz3sNaCIcCl65JN5/2EKZ7TiWgFzZ3BpZMMtSKhGwtX4zbC9lipTm1uncLP4s9Gd3i1LQjpfDE/Gbcs0JRxQto4KUd8bl1AIVkSeyVBuMgNdUIqUEtXke4soXtvqTAP1d9BlOlM/9kmkURdaJDC++o4q66LrmGIRTTza0+1wmYXyjSLVG/G2SczgBUoIg0SIw9GycpBMO8ivuQ6T3+bseqWOZwZ8gd+INnU3HPQfHaBttSQe7Sk15iWdzEIHaYjkhrA9ZNjo3jje95xJyb4msVBkrvYv/mxo44oFOrZCDYMMaR1Khpga6D7IgRs6O2Qclq+G9v7CQPokPhhYlOMM8fcJa+T29ZcdLa+OJdv8jwmdL1pFzwBbMqmiEp/xFxa+GCQ9GFYyJRuzHHZZPgRXZvOqnkGCar6v0duh0VQx1v8QzJwcRSgT69I5LT/Iut7bD5PPMM0UNk1cDBo9q07U4jblh+qbYNGeuHwz1TSo98FyZ91nJx5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gU2M0PtVERoijA0SsTILoZZsVCNXBTdeGefp+pRVAd/R2i3zw25UWQ7cc101pH+pBPn5p0tDJ1N3m+QOfZ6RoLr3rnohDqk3ca6aIqUp0JJ7PKNKpSE2qnh4l0xmOJuc5gAjNNI4w6KfOWXTU3dtwMvnnSGArwxaxjCawqd8NCrEE6PXSWstXoUiYGeUIOroW4B9mdPvRIcJQhS/wBsbjPScrH4z3yVEJw7eyXz9KrQE6te6DU455++Wvd+M9k44EL3mxv+Wj8Hk9NX6IqztcUNcMjFxodVHHKD8edWZQCLPw5tgcjVYnQjEmU+xC2lGg0F2kdqFj7WNgbymMCymrMxEB1xdrf2GMwF26b56nqESkmAvbuAOlFSS3islAzHpq8bf2MPZ91mfHZJGPDgXw5Y7Ovq2rUOgNWeAbJWPsUjd9TVOQ04k9esos+k/Ki+k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 17:41:04.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b418d13-175a-488e-6fd1-08ded60597e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device registers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/cxl/core/pci.c  |  1 +
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxlpci.h    | 12 ------------
 drivers/cxl/pci.c       |  1 +
 include/cxl/pci.h       | 22 ++++++++++++++++++++++
 6 files changed, 26 insertions(+), 12 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..2bcd683aa286 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..cb633e19151b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/node.h>
 #include <cxl/einj.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..20c2d9fbcfe7 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7b..110ec9c44f09 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16
 
-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
@@ -112,6 +102,4 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
-int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..bb892dbfdd6d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <cxl/pci.h>
 #include <cxl/mailbox.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..3e0000015871
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+struct cxl_register_map;
+struct pci_dev;
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
+#endif
-- 
2.34.1

