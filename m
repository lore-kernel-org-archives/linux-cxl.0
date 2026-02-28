Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE32DECB2
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299567; cv=fail; b=IkmjMlInsReo0eueSb1KRgk7c2s1VaUBm9YRagV3DFMRVUTcxXU2xFSayPEeUhK5algHyOxonjOwwxWZdA8N+iyagPzGcwYMqSfn7j4BTnlXYmyEW6Wx1IlG7yagkf1BniVjGwRe3uSQlUhvC2rtUSnT+ab2TL/xPMKLaP4inE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299567; c=relaxed/simple;
	bh=+dk7ckA6KabI85DPO/yREbXJ0D0Nn5ETSuLhXHqnfnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dutulwxjfL8EeIhRWDCRmbtNDapZ8/BIpdYuc7cEy6Hm3WGzllXTCumZmGr9HGm373Sa+X3KutN/u3yRMC15fvd7xrtEF/kbO/tzGovY6g5kEVZ7irUm/P1x1YSrdET61mQg4cC89vMZoUMqMCnZ6Qoug8yozpOf1s34ku1pEeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s2wPcYtR; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s2wPcYtR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB5l5r+CF5v5aC27r45E+Njt0UzKEIVLwrLYWN1iNNiNOxAXqhEa9z/xx8v50MIldr55P8M7SkOO+Z2JtqTp2aL2PuIZdps+aOwIQwFfh6rggj0NCbx3BIeRrO93siKD7+TUDpG9GN/GVgt6AFyNvYRVxPPK/6sH5dY6N6/tfEDmw3bY0Cr7DXNU5CSTh6UqC2a4frj2pSoBWYCurlXwoZr+JhN2T7BVqUwZm2+LCsZJTRjzE40msf/wTZBj01/+RmfC2rCHYpFbnB4f7nMvstRz/BJqyIUBkXUeD5G8p2fUBs7O9QO0UA3vasyxMOnphcLPp4pK7l6mPj4kiYAvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqKE9wAP2ie6VsDtKmt1u50Qly4RKrjR9jbeD4SrzkU=;
 b=HxiF2/FudOEqlS5mOtf49BdT37My59IMrd289x4PHM6+tBY6y69Nm28/Yq3PO3OmiAnO/vy1RHM7sQrgrS+VPy2JEXYpDdkXIq5QPGAvimBBGHnf1PuRUV1bNuAU/ErNLJhYfOdyd3K5U83J8rOAG0bC0jQ/YsIVpNF+XwNWJ5/g+2+B8M3B8daUPvLe43qLuDEmGRHRwMEJbWN12Qrz6JGbLDXKu1cbdSNIn6sjK5eTVsNsBbmntAr/6KutnOqjv4cWuoHkohO7y+LoPccGq527s4zog/+B9IfiYnr/wdS3pvKX3tK85L/TxNyY6gEuGyydUiTGRIuZ2320BEXIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqKE9wAP2ie6VsDtKmt1u50Qly4RKrjR9jbeD4SrzkU=;
 b=s2wPcYtRO3cOpINxSM0NPr7SxRVLVM7TsiNucL4kMxxcEnzwIA81fpFCbExm6V2NJOWMVVmemtbhi6M9A8M9F3SIZu0XqkvBLU3LJsnTn1+wMAX8tgDxREadJi42A7ZsWGkQuxSYw3acwRprB6yqQrihhFv1AyazneNIj88GNdE=
Received: from MN2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:208:239::14)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.15; Sat, 28 Feb 2026 17:26:00 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::2a) by MN2PR08CA0009.outlook.office365.com
 (2603:10b6:208:239::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Sat,
 28 Feb 2026 17:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:26:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 28 Feb
 2026 11:26:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 28 Feb
 2026 11:25:59 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:25:59 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Subject: [PATCH v3 3/4] cxl: Move pci generic code
Date: Sat, 28 Feb 2026 17:25:48 +0000
Message-ID: <20260228172549.1121832-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
References: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4b0913-d2cf-47df-9748-08de76ee7126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	K/y0E6KenKo7xgLPOUVh4cmVMsQvW/RGBkQ+ncyFQy4t6pLE27ERs3qGCZ/2r6WgXX3yKLfXFvL3YNSBcY6SEl+pFVeLd4rIfJc4+hITRH43pb7N5Oqh0Dn8mNLpWSAAQOTwd4RJ/5ezSn83LlVp9NdJMsJ3Z2qA2TnH1X2o0wstl96i8k02Bf+4N8fvPa0U41fTSTAEdBK1DmR5YYH1YzA5CTuafEqLSBolSaXQ9wDpbRWuKr7CX5ynqMCEOiIPKQWKZ14FV1QZrO1aHsmhzxHKrJsEB9BpTYSpLknD2sMP+sx3pWF6DS8Bnk3axauli0yultnpndubjifx/L3youIJLy48+26fkLU17Y6Ng8GW5TwJRagHO490uCoNhvMSP3SX3Ry01JGQAG+lsdudajOjwR6xJhAtvlR9l8zUG3sOPbi88p9HeWTpCfuf0tOB/+6oj6OdvHVyJyWqWuMh52rRMGa+7BBKGNf+vV/kY/YingubW5cxt/sRMqtMBsvB5a7zO8EaUSi48/lQ+CnyvBIv4OftQ0y+o3iDgYOjmE3s42mqo9HYW79bqNGSzLfpnwUPmsyLqIqtSD3v1JC0jEPZfEicswP/Br7gC0fPJ+y3Z0mqhiWy1/XDCrAtaKNEIp9mzZprdDP4DRLdCZ1SQu+EzO89Ttz0goqXwmjOhXEyClzBzm3zdIfKZwsSo1ODZ+qvCCcNHDaOBdPW4173cFjLZJZ77ld+XQW159wuGXqB9XbiLMPOFWNNEcuixH9vSVu8W5vNAr1wPUyxAt1bOrAyBWG7KxBHncYRazYiCFMfASgT9bQxUVk6LfzHDrN6jCR4taLU4A6OnlOc28UseQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hOWHNREJ/NJU5PczGrX4oTwp3uNQIwteQ7cV7VeVvjqaoXZMlnKVa6eQbBP/HTiX1BjvAv48Gd6XTzpquMLkFbxY9Jzy9OYnFoPWUwXIXyMpa0o9vsGOQprw4VOu22AnHcprhZrXEvmAGeQ5XRz9Cp9Usv3bpF8iuIDd99nuQ0wGMZPfhHovkEWobRh844Dk6PP9X2+DecdeNJXdk0hfH6AsVJ8eUvfmH9ML7AXwb0g0cI+LzW4ggKMII9dMZ28q6A5wNCVAeeousbWlNyL/fCHxEDqy4GB0dsi/o3Z/nO6N1ShItOq0c8wCdiFcmQi62f013qkuH2Nxwu1i2cD0a43KSXlcCjb1uMob6iuGmo4stC5AVKpYrdVW1zYp7sALtA9t3HnZBrUWHUZxoeSP6eRG5+As9B2D685+FoSpwNBhWYRyC8ZDyZy3Dmf8J8Cz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:26:00.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4b0913-d2cf-47df-9748-08de76ee7126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
initialization.

In preparation for type2 support, move helper functions from cxl/pci.c to
cxl/core/pci.c in order to be exported and used by type2 drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/pci.c  | 62 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 -
 drivers/cxl/cxl.h       |  2 --
 drivers/cxl/cxlpci.h    | 13 ++++++++
 drivers/cxl/pci.c       | 70 -----------------------------------------
 6 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 007b8aff0238..19494a8615d3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -206,4 +206,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f96ce884a213..c32cc62c501d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -696,6 +696,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index a010b3214342..93710cf4f0a6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d350b69f1c8..031846eab02c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0cf64218aa16..b826eb53cf7b 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCiEP with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
@@ -101,4 +112,6 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a42f273ff72b..adc7c4bcb03a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -465,76 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static void free_event_buf(void *buf)
 {
 	kvfree(buf);
-- 
2.34.1

