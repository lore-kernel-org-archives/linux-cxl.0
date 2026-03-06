Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0147DD4D
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815680; cv=fail; b=YMIKlTDxhnWI5cnJJPSfH8hYVoQqC00FZFLr+91mVwycIiwfXwm0Iu/OW/o/jC5O1O5SwdnxjiODhtkmwpB/7oeIESFuLGZ2w77uFJfelFOADyHHjgkkMfu9FzLHUolNjRvBe7utxXjrCclUPGnoEqM3L+dcrPdA82qXhPZOhjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815680; c=relaxed/simple;
	bh=+dk7ckA6KabI85DPO/yREbXJ0D0Nn5ETSuLhXHqnfnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTJscdwXY7CX1jRrQ+nnwbqdJbFE/10KtnOwcV3v7LlHC0BPC/f8QjYmst2/w2yZ/Ryn0gwBPRpJMXmZZ2TA107z46rUvtJH3QjGX/fGvV+7jfI28oG+w1lLBPeGzOrcH3pUgf9YMAqCZho4F4MdBM8w5ZFodFe6XXN78ezfiSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8sz9xV0; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8sz9xV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpmxassrK/t/G+6YZz9Wi7GMsZ8DYTHR1rI80NXoACKYMwCj3hJXQMXacUuA70WvxEML4eDVrZhWuJQIKtS4wIVfqUfPK44i9stoZoiJjsp/UaX6pJMHMPSpu+kQdxRHFf46eCj/5DodNSY4/B7NrBctRgwdFzQ/UzLL97ibjkDo/F1OVagfQ1sMydmGlReqFyiTebw79PDbbGzqUf2nOD57lEHLwDkyvJI4lorZe4acmou7uxTRqx3F51eCX9Sc98NrcW1SKK8EF+UEh5AomBO+uEeQ1qZbZPrCJKQ5d/mFBEq2Kv1/KNi+tq+mxEqcgoHfJlmftbsGEpzfW7ZGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqKE9wAP2ie6VsDtKmt1u50Qly4RKrjR9jbeD4SrzkU=;
 b=Ml5u0cXFPzab+ApM9UTBuqQSqz8qt0RSP6JMT6DmmD8DTtjwZrhiu7PqxBwkVJVmQDqTfzLi4x0R0BlAMWYCmEHr6mBTHcLm9bW9VspLs4dSd2fPhoWFzNlY6AZqZRTKW4yNxsyoKevn5jWZXzO0Q9zugLZ/8yJuwaovy28q39HZD4qX7pMUdCyCGjcvyk/wS2eibsSOXHvuoXMMtzbGG4A0IMe80OlH50u04hOkUTg3+0gXuPFuPXXuJfvOkMZG8aIkBNKpKCwM+aUqwj20O7AoY06R5WHhq0BEplhLb+7g4Zjp6fgICOlDR1ttYbhQB5VHDGMUINWbXZ+CKiTGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqKE9wAP2ie6VsDtKmt1u50Qly4RKrjR9jbeD4SrzkU=;
 b=W8sz9xV0buiJtB2eVdq0isL9L6tfoyt3O76ukuh/VMnVitvY1NB4xzuMrY2ytsS59Rn9LOxNaJK5rO929cjn2/j1Y5tED8Ai+KA4CmFLijt+/ONNRK5j/q0zMF18oV5eMWTI+C3DdB/u3ZRmPZua+sGTBbL7RohS0D8UlcYykQE=
Received: from SN7PR04CA0236.namprd04.prod.outlook.com (2603:10b6:806:127::31)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 16:47:53 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::43) by SN7PR04CA0236.outlook.office365.com
 (2603:10b6:806:127::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 16:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:47:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 10:47:52 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 10:47:52 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 6 Mar 2026 10:47:51 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 3/4] cxl: Move pci generic code
Date: Fri, 6 Mar 2026 16:47:40 +0000
Message-ID: <20260306164741.3796372-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
References: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: c858ce0c-0647-4532-b39c-08de7ba01c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014;
X-Microsoft-Antispam-Message-Info:
	ndFPhti4hFK++tFyU8yvbOuTbdTewgB5SkzpNUtbNWnP9eGEsuq2U1g9c5aEdD90YanfLFBbG90MDxhBqJuOHIcF4R5UDdJM2e/cBloAEe+5kfUVGkknIFj29ukDcIJNFmkHUU+q97eDfbPfPKABe2YWLd1dJZr4zgEea68uJlIybIUl6w4WNMjZh2L720sF5iIbLfBkbHXDTm63Pfbc3IvpjHPsbXg33gaYwqdb0KIHu+v/tkIYRe26lQ8YaZngEe9UbydjkYy/a4pi9HN2x5FHA3YOCFLvIEacFdQ+i8iMSW+08/tgcX26B6szI2oE4NAlm91CtN5oJB3LvKCIXVAMgZoLD+J9wCOJVO5oCv0GS1IesmHgHG9zGdQ5SePGyX8ZMomRKyvm+SwEAKlYzW7i+dXMeEwzxvBXRNXO+vRzaLgGtBmuWiTOctqXhogq4m7zyCPE/z7KwXLV37ulDfIxbjKnY3It1msJF3NH0lz3dHm8eJtu3LJP9IsxZ/oFLaiPgcfnX43ezsyrH2GhiN4DE9s/ws4JHYRfTOkIBRaBfE+aMfhe0SVehNc2kuhTHgj1xD84ZEu65EnEXnz2WvFip19WRupL0j/EjVctd3FmZOFr8Zy/zhn0Gtbx9NTPEAYkh7d6ZuaC+paM2PJdGw1mSMGhWj4If5cI0gINH5/3qRzzTo9hbEHs8UtOD5LFV45FCErfEqCt/0pLmkV9Nal8LUKGEx4RES6vdSsIN41CLkxYGV38LOH1EAA9M6Aych8Hm9UNNwyHWDyjaI3VKQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KRpa1CH+TTEH3xwg3WnfmVle7h18iv9gBuj+FnQF9Z9YoW2zCOscvaH/jQkoCZ0Rop4yEP0r97OG6d0LO26AIPyQU38i+RiKzWvDGY6bYQAa68Y3xOPBHlACh9LlF0p+ajM+SJLX7aqSAsdGSWeC+kcWDS8qkuetdq+4X6T9rIPfUitT65tAjGd8DdDLK9AyByFuSc/Hlr0w7K7gz2SWSMgKBSEWELBLMUk9VNmIiOkfgTF4Z92U+eg3wUCBhpOdhymUQhPfLojgO76m9PQHRrMx0BzG0YHVOunzoNOITLTrKDTi+GB4Ff8e9/tLk24YNykbmdrjtg66y/AXEYOyiIf9Wn05iqp1aCR3stJFmZRdY79vzg/SLZ7e80WNVArI5Ui1H0Ro3Z3ukYDlSK58Us80HdAiomPT50IYu2cvsy8BJKxVAIN4Fj1AufV7IpZB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:47:53.0516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c858ce0c-0647-4532-b39c-08de7ba01c30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

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

