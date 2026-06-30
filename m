Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5622F767
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829052; cv=fail; b=BXFnlTekEsjul22cuhKbTHcRr0i2rYsHcHBhFqC3jz2UqZ8aucHL3IiWJgaZy+afj9ez2ZulpliC+fOMoif0v0ICRoZiFB9u7cCAviv4D/1NnTst0R5sz0vKSQJiYY/NXhjxnyYS8j6yHxH7jDvgP1lyMnipzn6t4DbyFYgW7rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829052; c=relaxed/simple;
	bh=4RwPwZSadwi4m4dmA0ef0va1ITZAlWSYVjpYI0QttrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbku73uhUneY3KBI+c6PJD++N+efWipU6ZhKBrJcK/Vbsr0N8u41tsWZ+eUYJaY8HNdm52TgayMYsXJ0UfW0OSJNgypd54TMAftvQTFRFcdQaakdHjpWCtZPRLL5P4GtVSVm1U7JcSCeQWbFUdG90kA0yGVAJvcPk1DCndvGctQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJaQj/4i; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJaQj/4i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgV47m7DP5zFGnYbYob3LyTmVIQTmmWfRLw/HHF/NrZ/QdLMkMRk6/UAwhhxyVeJfyFVTX+eem5/3U6/m8XXrjIi7zgGoYmp8QWrsMJQEbsgVB/yvnT8JxYYfqk/FEiXBmfL8srkWhGS93/Blch0EZn7VWmcTNSF3MpNq43LRFiUk1TyfRGJ4yvRy2hwU232VB722K9tNJ4Scr9R+wQX2AiVya/Q1Im90Yew1qKjeBAH5PVDYeArUEQJ+fnXbCHaQf+RxizKRsa7fXdTZAswfNbJ7l8CLWDGfuzfNivTA3EMJAyee14EVZHFVK1S6vV84y2Anjny5/gmjPyyKcv1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNnttUfrezW/ZR9NVnaDb0uqJ36y5IvYJjEvfzvmT1s=;
 b=eNjzyo9UxtbWYUmFK+98oLT9d9rn0tOKqHA80mLpS/FCE0MPDnIvn8xXEyiyLQazFCeLlxP9f+DhIWte6Qg+CsocKpndE3VREEjBpVoFO/4oSKK+HF4kOy/njANO4ThJwgQ8SNK0Nxsf+O4NzMwD0/AMTxJC0BAPLSijzmBwdLLkfPmxjrY4AA44HU4GuaG0RQ6WohMYlA0u/DPjs2cPxovumpe+/U01oeyl/dYsI6ZyO/MUa44I0QtQGTaO0BkAva3+UoXd5f8S0E8YOzMDcwZm6x0nu271/6956XsjSQguVJn6WwRDfH1g//rCiFGVB+G8kNZ7vB3EyTJisw9+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNnttUfrezW/ZR9NVnaDb0uqJ36y5IvYJjEvfzvmT1s=;
 b=uJaQj/4i8dd4fqSt7EB+z8moZ7apE2aEGrJxcpLjsGCUmiVRryoxSItFJgate+WsAtjZT31xPN4cWvDRTXWcGh6lBy8FUX96WOs5O62zx2DDkfM0dX3L6qND8PUzVe7kN90MolglHohzBMl5R+Q3qHShbmp9rBmT3ebOjPJnhHs=
Received: from MN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:208:52d::21)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:17:28 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::2) by MN0PR04CA0022.outlook.office365.com
 (2603:10b6:208:52d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 14:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 14:17:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:17:15 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 09:17:14 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>,
	<kuba@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH v31 5/5] sfc: support pio mapping based on cxl
Date: Tue, 30 Jun 2026 16:13:46 +0100
Message-ID: <20260630151346.31201-6-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6deccd-a2e3-4348-6360-08ded6b250a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UuHS+RpiiX2neHeiMaE5TzQgie5csJs9hJaLliEHl3pJAn3x8CWRWjxBXVMJZlpFpHIBjhT714FD0XQt9fGQTDBN1ppftUqtnMJQ4M4AjAZi5oj7w9Esh9Ab54yyFY5F1WD5TJ+gEpb71mCqiRLBkAIQc7NbzIRkcYhCzXRAuU1/RFO6zIyFwpCuO/JZoc062FflDIAtkZ0NLupMYyeMmCNFFRFiHVAeLuwe2tyk/V6dsvnmGxKUq8wUqUw+YOhBaeXfsX0MgOSLOLy+tJYnb5koBgBhVkZN7GFblIxhmDuyqDNQldmdvcucY8fICW8AlMyhVXq2kyRoeazCeiHSybkXWLmb5RM6AC/aZoIuJaoaJuDSfFct4fD9xzk5Y5zo4klO0i5ANHprpITIWasjvfK532WU/b6HVFe8fk4jFaLQekZ9dQZfwZCH1PYsOe5+ze0LS9crGN+2Mn9M/Ef4vaQH/xacH4FAjmkzMlvA7yUOA0he4wfS7SM8JASN4/GCfPc6xMFb82pOSuvCkRuAXEog8WB99GqGutBNUHSVnEMXZxQc//oOdDcUkuniKJuz13X2nPyLuCExdowXJMNduMENLifHTT6ndyLr7R7srWNwB0lNcBtUUGwo31gmZr09SthXDYK0zTvEJ2rBPIrNafzKXidxbqFMr37g3/Bk07W9UE/1XoTqg+ZlHLDvgf/75MHVADVVVoesLlMmmQEuKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qP5i8JgADPsyZV/uraGuuH+/qbJd9P5ZBV/I4s3KCqCZ9g/AB2BxpGRzmj/JXmdlTvPIMpMzavGa6fK6MI+O0ZYtIPTq16HqOZSFMlET0wAEVZodW3FGUBmki96zA2zTH18riFvkjLJORhYKbLU53ySdFo6o24zENFUWx3Az+4ao0KJZtZ8VhpsjMWXpFEIpmkLYfXE9lSAZCXtSQtkgD1PdjICSEPo/THPoUzAS2rprUc2G0s7b2D3L1POlIzXi+kloEcsiAavp33DY29Vr49xj4fivgpwy+z8EtTq/YWcC1MGT11PJa/vXBl/z3bHZBBoibSUSiZ30JlIrqUEpj7qj9ZiOEemtMRha3JzgUPaCswDWl+oOUtbkKXqJMCaR07Q/g0xzbBnejDuFnXyrJVAGtrknzswsqGwrGA+KyBoH5chCnVOjp1iTTOpyftpX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:17:27.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6deccd-a2e3-4348-6360-08ded6b250a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

From: Alejandro Lucero <alucerop@amd.com>

A PIO buffer is a region of device memory to which the driver can write a
packet for TX, with the device handling the transmit doorbell without
requiring a DMA for getting the packet data, which helps reducing latency
in certain exchanges. With CXL mem protocol this latency can be lowered
further.

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 41 ++++++++++++++++++++++-----
 drivers/net/ethernet/sfc/efx_cxl.c    |  1 +
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7e04f115bbaa..73bc064929f6 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/udp_tunnel.h>
+#include "efx_cxl.h"
 
 /* Hardware control for EF10 architecture including 'Huntington'. */
 
@@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
 
 static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 {
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	size_t outlen;
 	int rc;
@@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 			  efx->num_mac_stats);
 	}
 
+	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
+		nic_data->datapath_caps3 = 0;
+	else
+		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
+						      GET_CAPABILITIES_V7_OUT_FLAGS3);
+
 	return 0;
 }
 
@@ -1140,6 +1147,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1273,23 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size)
+		goto skip_pio;
+
+	/* Set up the WC mapping */
+
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if ((nic_data->datapath_caps3 &
+	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+	    probe_data->cxl_pio_initialised) {
+		/* Using PIO through CXL mapping */
+		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl;
+		nic_data->pio_write_vi_base = pio_write_vi_base;
+	} else
+#endif
+	{
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1304,14 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 			nic_data->wc_membase +
 			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
 			 uc_mem_map_size);
-
-		rc = efx_ef10_link_piobufs(efx);
-		if (rc)
-			efx_ef10_free_piobufs(efx);
 	}
 
+	rc = efx_ef10_link_piobufs(efx);
+	if (rc)
+		efx_ef10_free_piobufs(efx);
+
+skip_pio:
+
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3e7c950f83e9..348d7404cd7a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -88,6 +88,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENOMEM;
 	}
 
+	probe_data->cxl_pio_initialised = true;
 	probe_data->cxl = cxl;
 
 	return 0;
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 563e6a6e85f1..3964b2c56609 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1206,12 +1206,14 @@ struct efx_cxl;
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
+ * @cxl_pio_initialised: cxl initialization outcome.
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
 #ifdef CONFIG_SFC_CXL
 	struct efx_cxl *cxl;
+	bool cxl_pio_initialised;
 #endif
 };
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index ec3b2df43b68..7480f9995dfb 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -152,6 +152,8 @@ enum {
  *	%MC_CMD_GET_CAPABILITIES response)
  * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
  * %MC_CMD_GET_CAPABILITIES response)
+ * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
+ * %MC_CMD_GET_CAPABILITIES response)
  * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
  * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
@@ -187,6 +189,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.34.1

