Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E263770B
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965138; cv=fail; b=N6rnzQXjFxrxf4gedTlMpbCxR2Hy7Us0kYSMpdDtcZj01nM5agz9VEZmx8pfTh8OXDeO+meQfrqpAjohcnwcIYAsoT70rw7dCVxwM/EMJAXfCUaAlMb+VfGCMLJoe6I1q/+lvVh4OjIm6fvmrFz9GYhB6KsD1fK1dAmNbrbI6yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965138; c=relaxed/simple;
	bh=NX/MjxCOMvSlaQTAjO6HNIV4VHUx+TqPtZBDy+D234k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwV3HwOdbRyfDpLH91TFn+I+5YOZAaisfQxbpr1km340/bJ0OTj2cyJNq+DoVPpONPAKWSqlq4xNkCedSK7NitEvF6PSo1GB61HW8KOIDHc/YcCvEnFF4H2+gzs+j1uU49OpEUfNsK1rGdDM2fZ2pBTCagazrrJMNv/cG2vV8VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YVkeUwkB; arc=fail smtp.client-ip=52.101.57.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YVkeUwkB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd4t6N9/qxRCOqJvQwpoo+mHJYz+7pbG31BpSDyTg18nnb2MK/AKaeeRQN68GRS3r4nPP55aa7p+eonD2YvfDfqIU8QOuOUh9N8iYQSnawPwxCvRGfDmsy5MxU4ova0ASrsMe4syTK7WXCb3GnrMRm3Q+sD5+uR1Va3VOEI34vGrdbLAEwZZ42szr+4nB1moBXnWSYrDbcfG6TXygqsZ9WKM+PCtACSjPTNTkdCSO9GftJ3thsvm/IEdSGjwfmyQ6Jt+TXl4d5j8kQax4cLM+Cgi4QS3OAXNrEm5kwQiAuGQ5VrmmWqIiT4mMXxVZNsB0JGJedo82qo+A0o4HrV8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SZf7gjpg6XUwJ+vh+I+f4JomIj+5xjLvlbOLTZoDTs=;
 b=gU1rfoWFDvAsh7BqJXsFs5dFHOXVIWCBmWy7x5DEqDbYie14YaSf2TpYTT9ZnYroHwP8jb8nGFF0QicFiYLjzjwYzKMDztlnJ6WXQERpBQftizw++d7B00TIVngzsj9p/PniGoQCO2Momh9x3iw/4kWnyNzQ+FWmrS1yU/+MaCKOeoJmV0gbZyWL23vevMrGWZVZq/+KH7jCAOsFt+rfw70ocLBOm+lKnKcwv7Ml3U6pXt8BDSq0L4UPAHH3vNuSwvbRW4b3OFJhIzI2ngneSboXNrsuBlnu1uCq3NIZbKeq38RlqFnUHebVF+hd1aVOC5x+Zqlec61dhILjAbZSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZf7gjpg6XUwJ+vh+I+f4JomIj+5xjLvlbOLTZoDTs=;
 b=YVkeUwkBWFfClNnZNnI4oCV0mO1f9ewsB7rppTXveeX/PoF6nWA66gxezLfAYdMvgZuI8hwbfQuszGMuPGSQidYJmCPD1A7jJjNc/Rs2FVkvNSqQ9t6fQlvIDmzMhPFET8yJdi9FOujwYu5NnHUeiI4O76WxfoNIqbzYRyIxP6s=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 17:25:30 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::11) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Thu,
 23 Apr 2026 17:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:25:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 12:25:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 12:25:28 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 12:25:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v26 2/8]  cxl/sfc: Map cxl regs
Date: Thu, 23 Apr 2026 19:05:22 +0100
Message-ID: <20260423180528.17166-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: a59ac206-2e88-4fb5-55e1-08dea15d50b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+qlMKwNcEvXX2iHG+daZhm9SIXzykJnXxCEZ0IhQ95xFoJjpW5wZlN+/6Mmk+CZYCqtS2ojrNJVpTUnQd2Vp2PBtfCimKZDuQ76gC+Bfyr3vceTRPxludSJtlSkrLubknPkDLqgboh+NCv3zCq6krUzVq/80qrhHGakCc6nVW+oTpBEGO7xrag+8nFc6R3aMYK3kkRYqVGBl+G83i2Ae40VKcs7h0dMzeh27DmWUDCHylmpEYZlLbJQ/3/BCLyNsvVF3mQCuk2obiLdgQxdhe9upyozZLwe5UP9J/aCrQG7lXWc7fgwV83mre/eMUY6bp4ludOedFkvm911k3oIofAItDvr/BrTl4TjMuHsz5x1sdS370Xa9pfCTOK2WKgBrmYFtipgU5DTRInuQbVZsV+mdwlbYGyh+CJKd3fJX6aUwQ1890FpLjA2SCR8VJCarundh85uZrOB1BZchIWqQmJ8kBBk9fOxhsJaEK4xKLGEcSKWpsOqGKbOS6YjPL6Fb4XcGBT575EWtE2bVzyRXfacCIKTc2ZV5666myvEuAzuc4TMosTFscltXA7h8Ri8CXZdYKtETGnDAUJm6g1wztL0uu24F9xf1h25DdFB9bGlwt1cO8M4wugoe44K/29NkCbfsHLGKiFU2H+Z2087MXNDZpGxDR71XrX6GH1kL9F/v7fN+8ru81cYHQHgrYoyzqe8xnetT9qAy4p1PwAfVDQqphLicfORU6kZREr9m/Zj782Oskc13qtShQoNE4MyqDak9q3eOD3hyZbEKgq9X0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4+58hzS8QCW9X82gTBoCsSlDjwHo9UQ/RGBoQk4Kf+9xm1aOVCYiq5NRHX+31a1cN8yXB/noUuB6iFS28FQIb8ET9y2AiCD7e41XSkiEtIfgBi7PdCItBaKOpR6pZv3Z+R5ixntKL47WKYA2ZScPGBc598fB3CC1Bmjx+euBuoVwomRIF6BHeTg474nZ6aIdgY4+IupXqgqr5S7u8wJgL4/7OvIktjFZwSs4nfTQHY5Qz1UsDh2HNLPNniE61eZtCYsczDu0wCXmL4N0FWUll7dfDjIErD9Xy0cHQdn5p7719EwpcL8kFC9pAJ/9284HUsq31ToRPuO9o6GijCVX8gjETVMVLUo4G4NhEV6osUoWfIhQkrvDi3aKDyAVUxYzx5ZJiHkKcUV+SLu0LpWisHs+HZpma3sYisjSH4GTte+A3xuTsW8nxG3jvSpjjTUZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:25:29.0506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59ac206-2e88-4fb5-55e1-08dea15d50b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

From: Alejandro Lucero <alucerop@amd.com>

Export cxl core functions for a Type2 driver being able to discover and
map the device registers.

Use it in sfc driver cxl initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c             |  1 +
 drivers/cxl/core/port.c            |  1 +
 drivers/cxl/core/regs.c            |  1 +
 drivers/cxl/cxlpci.h               | 12 ------------
 drivers/cxl/pci.c                  |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
 include/cxl/pci.h                  | 22 ++++++++++++++++++++++
 7 files changed, 52 insertions(+), 12 deletions(-)
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
index c5aacd7054f1..dbe30e7c383b 100644
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
index bace662dc988..1f10231c8d43 100644
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
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index b7e8d85a43d3..f88c2b3fbb2c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -7,6 +7,8 @@
 
 #include <linux/pci.h>
 
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
 
@@ -18,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -44,6 +47,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxl->cxlds.reg_map);
+	if (rc) {
+		pci_err(pci_dev, "No component registers\n");
+		return rc;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pci_dev, "Expected HDM component register not found\n");
+		return -ENODEV;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
+		pci_err(pci_dev, "Expected RAS component register not found\n");
+		return -ENODEV;
+	}
+
+	/* Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
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

