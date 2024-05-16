Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55D4501A
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847144; cv=fail; b=npoZaXA5xHdi1mLzFscDHsGhzEhw/12W03aKnzyBwnzCaD7QUSElofttp0jTAVuaWzV3zD2FohZeRDMFwEeuUW/2JDQnkGDqw1aeLDIpjG88WDcz/hlr8y7dzPy3xHsjiOK+cxeYqCEr4mz1bBzwWfIU9XyRGn0IrDf34ZGC4vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847144; c=relaxed/simple;
	bh=L5rwcxq52DZ3HDIhUpczRoEvzlwd1NSz/hjMxDj3k/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSxakXtYh0E4vS6jOLw4JBvRsKl/mxzzl9tFhgPQaOmnmZJ29QvJbEcqdthflDyRoJo0nAEJseDyt/Zjgre62Ft11m3l0/CVxk+ZevwwS/JgPFi7fxxlhD2gwG8SO6heq+aCA0x9HrRd0LulTIEwuWrcSIEOnhmqYiwJy9Jcr7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wlljCLm1; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wlljCLm1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0uXkOojw49ySKWO9VhAr1oIHgnylg81vHXpndYYtM8mUg7wbjAOfXdZehPswM133ObtLg2JYS1OJlAHdB0H4DqZhps8QQ/4IjH48Rr2RxePgNdys5lfn1fUeTWiQKRLS1RMKo1+edPJAa29mxXYhxhdCZx5uhNJcHws7yZNbxM1ix9ijj/edN5ajhxVZVPPhNP5n8WnXnSYzynDHr3J9IFwbLI+BmjGC3/+y8TZmKq3OibwIf8Y9hgUdFhnZPYCVGNNnp31VX9S8r/8pFewkUCDAm7G0LlEhihVWzn94fS5BkQSo2YxlKFZlUbnjS8xssGFkdunf3IfHeCSmQf7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI3sEr7+yzoRDOIhf+MrXn9VbK74X4PZKXx3JCtBwJ8=;
 b=KKDxXSqmFuVv8yLr5hKqOr2wMFoZ2A8dCPLLljQ+tw24fpfFqkIwqKNapHFrZsynAEkyWVytTZGwMdd9eZeNn8r2dKIaGLdTygFP6po6+CNFqsjn9bsL8HONz6pn/e54hCGJrDEQlsF6sZo2zE2qkKdWWh9FBIVM4zj2vNd2WvRwZN02ddu13TkwIV9rwAVIPl6zuaJebfSt9mmhQYE7mTbQM+ZYSYnjsQOh1fie9pr7iD2WXlkNPQQX7SVT0Nq85g8ub6mDihI9ImHFBe0/53NcccCbIHR5rjhwJdSOcP+z80QSpjo8tslehW6EYm3+u83jGHRiwO1p5x0IIr+8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI3sEr7+yzoRDOIhf+MrXn9VbK74X4PZKXx3JCtBwJ8=;
 b=wlljCLm1ngRdgUoGqS/Z5UYYs84jhUYMU2ZjBrwXMlJTkimrp2mz5Jlx0h9+0+yVsB09as5HycxTY6ph6Z8I4jTfpE2dU8DLutR6BZbCcrHUWeIuX8aIjCg1Y0RTVjKYIFZXrPUrP1kSe2LAWj4dWDNiK1/4ORgs5xrBScA0jB8=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by SJ0PR12MB5675.namprd12.prod.outlook.com (2603:10b6:a03:42d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:12:20 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::57) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 08:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:19 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:18 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 03/13] cxl: export core function for type2 devices
Date: Thu, 16 May 2024 09:11:52 +0100
Message-ID: <20240516081202.27023-4-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ0PR12MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf35c2a-2ab9-46dd-120a-08dc757fe848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nWLAn1ZpnveOIHZqBqdlG/lqB6sxgJmA7JxjDcq72k+p2tEjK2Gl+y8XxSMS?=
 =?us-ascii?Q?BdCbo6OFRQLDOIT3wLPf0YcI4LrnlleSywziKgBg7D4qc2G7tFrhdYalJMU3?=
 =?us-ascii?Q?cDPnQO/2YdpWYEsWGcgkJy6V4WCjr1V4wGgTSOjAtpomEHWEkpL+JZ5zbQi4?=
 =?us-ascii?Q?YtDhiHKASvMiz8xn94re3SSUP2vQ5NyeWY9q3T3hflHFYrs3LEeHWQj4ulUa?=
 =?us-ascii?Q?OAzBAoSIkB7v0hpl5BNifbLMwljFMC5/chwipQF3l8xGhBoIJ1AoGT+XxgJG?=
 =?us-ascii?Q?9p0hJjFp5EY4TfW+6HG3q7e07ovnsb7TD3fkp71e/0Kzn7D19S7i2ZDN7Hb0?=
 =?us-ascii?Q?RAnnM1IlLtRxwk3MHpjxG95G11YmozxKooiJeebaJbdT6kgUEVh7FNcIxmgB?=
 =?us-ascii?Q?sAedf0EEvIwhz4KJSIvjYHXhcJK9WS+WlFRyZjd7H9rK+QKO1I8DJ3wi73n4?=
 =?us-ascii?Q?/FY9JweZ219pCNARVMDxiYtsj6sCy9pcFLZ1uCSfEWSos+K+tB9t1Gcuosi5?=
 =?us-ascii?Q?2FcIgGsta4IxJ24/Jf/genF3baDaKKXs69qE1pNiq46nOZ2mzzMzaXJiViRG?=
 =?us-ascii?Q?RpQwdv7haDyQeyCOgg99OhYNoMRx5xkmK/IRdKgwHImqhyGmKq1a8XVVbmbI?=
 =?us-ascii?Q?CV6IW5WzuTb5nkOXP/f2qXXw+JgBzcZpaZbylCDZ6OEPMXKhoICc3SctAdcN?=
 =?us-ascii?Q?Ijtd+fzwn7bZKUD8PrUPMLUBKnsiKuPza1CXN3hR2e0agNU+ni5bYNH/lBMl?=
 =?us-ascii?Q?8STiFbSx0DUEJ2K/6Yk+SUnmYFlVPc1TXbmhRbDeHQGoyxH6S2/nzm6g21j5?=
 =?us-ascii?Q?FD9pav9UfBCqlGsGXip0DhqmJ9QY+RBsAZA5w/RBtjiFSeu4+PRtQx9e0emY?=
 =?us-ascii?Q?tF+M+qah1PemiW1+dwXPBfVFQ+uq3EqpjuX2ZwPBivG0La4Lf9fS6Ewe+2U7?=
 =?us-ascii?Q?4oVKBrH5OHcBYFTgb5Gz9W1nzRrbeBNy6qOausbm8XO6ZUygtw21VycxpfXn?=
 =?us-ascii?Q?NKDjXU7we4K6eL3+M+PJBtTzJZTwfLMuw8+5OR64x0DcGG1duPtaKATOhvph?=
 =?us-ascii?Q?QE8zudOMRvIOoU4Jc+fVw6tPbNATtkLD6fXtF+XBD0PlpTDkB4AzgrUOwOK3?=
 =?us-ascii?Q?ZOydFNw35zNagZiDl4upwZcfu2lihdzgXVbsMf9E6l4ayeDYd2nA97r7ysA+?=
 =?us-ascii?Q?mvGucZ/Uh1N3KQbCzQP3eq65sJjC1l0btxSde2jo+RXbEOc9x8iwTIeOb0sp?=
 =?us-ascii?Q?A3b1VXhcbZzDYVrbn6o1rlZunmF5uz0a8CgGXTd2hclY2eNWs0vlw43CWyta?=
 =?us-ascii?Q?9vLbUssrFpu6LRGizoNFigAlsMeuVJb9D9n5ZHGWsXGQX5h7F32yJftFDKfr?=
 =?us-ascii?Q?648dmZLDZdKykBS6Sba0r4MB8dV7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:19.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf35c2a-2ab9-46dd-120a-08dc757fe848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5675

From: Alejandro Lucero <alucerop@amd.com>

CXL initialization by type2 devices requires to use current CXL kernel
infrastructure only available to such core code. Type2 devices are by
definition owned by specific vendor drivers which need to use part of
that infrastructure for initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/pci.c                   |  3 ++-
 include/linux/cxlpci.h              |  2 ++
 tools/testing/cxl/type2/pci_type2.c | 31 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ccde33ac9c1c..497276302017 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -500,7 +500,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 	return 0;
 }
 
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			      struct cxl_register_map *map)
 {
 	int rc;
@@ -520,6 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 	return cxl_setup_regs(map);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
diff --git a/include/linux/cxlpci.h b/include/linux/cxlpci.h
index 93992a1c8eec..28fa4861a4f9 100644
--- a/include/linux/cxlpci.h
+++ b/include/linux/cxlpci.h
@@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index 863ce7dc28ef..b12f13e676fb 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -12,7 +12,9 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 			   const struct pci_device_id *entry)
 
 {
+	struct cxl_register_map map;
 	u16 dvsec;
+	int rc;
 
 	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
 
@@ -35,6 +37,35 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
 	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
 
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_MEMDEV, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map);
+	if (rc)
+		dev_warn(&pci_dev->dev, "No component registers (%d)\n", rc);
+
+	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pci_dev->dev, "Failed to map RAS capability.\n");
+
+	pci_info(pci_dev, "requesting resource...");
+	rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
+	if (rc)
+		return rc;
+
+	rc = cxl_await_media_ready(cxlds);
+	if (rc == 0)
+		cxlds->media_ready = true;
+	else
+		dev_warn(&pci_dev->dev, "Media not active (%d)\n", rc);
+
 	return 0;
 }
 
-- 
2.17.1

