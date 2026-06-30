Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E0346E4E
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829045; cv=fail; b=axJoV5SYDwZkNEpBlwmk5nu2NUg/u4LhAJWUYKQQULuWdav3XDPKJwEurreK1+FdU9CQAeMl/aGb2k6Z0esI1xR/ELCXSg5eGnPb4HpGArUHlvZb949MrH2YGTeqfKJ7SmyQYSOsbQlGJCbnf+rtdAOR9rQHfzy2Kga384VFiL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829045; c=relaxed/simple;
	bh=sKVkF4rm1ZVn17dChYwF5DzvD6nJqTydHE7+F5NbA7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUH3YdDngXi5B+JLY7EzIa1nQgZZEuOVBeb9JHo8TO5CnidjgP7tiV//K1ZaRoTNm/Wh+JrtY4fMYL1UjC1trOV1IzQFHW0lKirPg8d8ydRHmM6RcZ7cwqkeECO6Vomr3y/QxZQRAaqxwfGPVtoRTz0aT/5qXB0dx4Zy8P/Y0bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7GI5NZP; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7GI5NZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3K30ymadEqagTXHCuT7XQe/nsR+vkdXKgGFfBc3fQz7ZiS1Ue/D3G189Cc/K658sAcvcHoJ23NU+Xob4v63R6/OV3fYnQyIFNdzwCcHqSgVUUDDSANSg6yDa13q7wuAgd4B2xO4A68lKU8Jga0/Fp+BZ6ECXBfp8HD+XsWhUM3Rso8PPOTrYG8EBHochSXdJysbNdEk9kYYymD+LfEeP4TVRo28OexNFE+EtFquror3V4+qdsp0MP6LsF5Bcy5UigMMS9jtL5ot4sfeNtrf0jem6dUcHx+3Dl/HcuhSXcYP7DtFEcI8YgDxjHq0YZQIr6c2Q+LARluw8ereKDtTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhkRnhD57X1y1tFourbpUY26U85MpcyA69POJEKLJkA=;
 b=xxrOf6YdkMWUacHDYDRyHYMZrBeUVWDjqJeacn6BgS344Sa2/e0nrIk5vZ5rmrRTcEgPRCGtltel+h/F31IcbPEpXyxJbx7N96Jv8T3jPokYDn2/eGmZdz+WnXTUxqJ+LZox0XwcfDQ+3q8smoqch80tXP9+k1yLf7zmdjIeSzIe6tt99MJGG3gXSQKXDC3jKYVfoY4H9ikxHVhEP1YAIW5FOhM50SGTxl0gIFIVej0O3rg3SpRHm8nD2WOLW9QuRAKH1RhnseMKU5TrTg6M8VrhfHNdY9mgrtFa1bXffXQXokV/emroLC2XTPpdI2EltucmHgZ+/wUiOCPtHeKu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhkRnhD57X1y1tFourbpUY26U85MpcyA69POJEKLJkA=;
 b=B7GI5NZPleB8mO6e8/NK2XOdKzyG9dDDV6iMQJFVy6BXjTdi6PyFkit/x9OmfF4l7yhIONnHuIRBY0cD2yRwZaKk5zcZzQvIpYnpKcD+zsClSqyUWE0Yn95XqQ6zzw/06wGGiQsvTjuDqHcGW9f2TpUU0TS8xYjYuXM5SY8C+EY=
Received: from MN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:52d::6)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 14:17:20 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::9a) by MN0PR04CA0004.outlook.office365.com
 (2603:10b6:208:52d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 14:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 14:17:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:17:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:17:12 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 09:17:11 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>,
	<kuba@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, Edward Cree
	<ecree.xilinx@gmail.com>
Subject: [PATCH v31 2/5] sfc: Map cxl regs
Date: Tue, 30 Jun 2026 16:13:43 +0100
Message-ID: <20260630151346.31201-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
References: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d801b9-9fd1-451a-e38c-08ded6b24bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	k6dw13SsXvV1dkhi4YGDtFKhm03mpXGo08KObXlnKXN5Re3dEa9opaeYRZwT8jiatuIQal8HLcJgnE45GXx+LRPsE6gwPzqJP6fFSJJ/IW2EpJD4a6H0Q8gLd3OGK8drjHC9EwW+luAIFm4TjHtImHO7gkVM6emkirnWKKITUeu3Ov3Vkge+sGiL41ct4kg3U8ZFnwnBe2tm2hzRb4ySnsKAgo8+GZiDi2ezCjFRfRP90ivTp4JWt3HtpUl/fVtlX5HEGHxc7HhzCUwNeCi+Ny5CXydhHWt35NgFVlA7PCyixiceiQO/JoLDV6miakepD2tLwiaQVCJcIaMuup/xh1Rom407MkL64K0wDubESReWpFKvvS58cj5HYzN3xFGqZOvwTInKqPIPBbAYtJMPiRO+2WF6161OVG7tRA90k96xa0IzmXOgSWOrVDtW0uox6kV0tmtFAsDesp6L0ftl8akbr3w6LRi4JLrPZ40w1ZWX5HI99K7yUPwRsFokFFl/g/i2CV82bzR/ybCIi2AzKs8tzYYw7gznsjhdrBUo5AECFN4eequ60EOr69JMaid2NUPz6UU1Ieej5KBCUjy7DhkSFvNl4QXMDWiwMtI8pZ4gwafEtqdhALKhrPKL64R0dLT8wMVfO0yJBHPOU71eaSFD0r8gKIA45MtaowZSKwH6AoMOGM9rMGZLAZ8tc69qNPy9x8kopPtQ03xQANR12g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6x6+/CQoaaBJwN7t5CpdM6kl3UsIROWgGeCh3rdoEtEeNlgVWXcUSqs9R/hDnyif4mEHDQccEL80v6BJMJPX9aYDeeypf4vrwhrVvFwCzV0k5H8Dn90rhN72H4gHE+kZ5tolw4ITErCEZDl59xhS7s2Y9lLXQApxRzVCUv1Vkvx31bSwNWVdpRiin7357mkS6gfgOD1fNPX+pSyCwuKfAy+ZUL404Msf3v8QFF4UG6TntnITmH/pIKEELrlt7JNcyj+LiKoexXigv2K8swZw84AkzjxWqvIkVmTYh4umN5dZJ2OlsFbZpGrkvAxiPFQ7n76UifmcLMf4L0CGXk0OBtcxKewbm9LggTwBMnYEk6SvaZJR9tjHDrd+iVM9m8QpE5FHHePkSuZFoOMycbS+T8NgPjR6NnUswhn4dVhcirNZ1AC2qtBVbkrrR7cLwRcV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:17:20.0254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d801b9-9fd1-451a-e38c-08ded6b24bfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

From: Alejandro Lucero <alucerop@amd.com>

Use cxl core functions for discovering and mapping CXL device registers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index be252af972ab..704b0ebae937 100644
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
 
 	/* Is the device configured with and using CXL? */
 	if (!pcie_is_cxl(pci_dev))
@@ -42,6 +45,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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
-- 
2.34.1

