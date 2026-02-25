Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0273ACF19
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021687; cv=fail; b=hOvdxRScYFQkGB3EfTKhFdmgyOF4MokbRiGWdD+VvC1fwf4qGlZzKxcjt3iZUJejeomSTGZk9l1M8EdTqmRdPnDRbkUYK+rxJU0dG87FgBcmKhnYVDvOHkpYP5lnMHqugMWjr+Y07H391w0CSnpJ2T+nUtbckXseLtMvaFTlx9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021687; c=relaxed/simple;
	bh=9PXUjUbuiRaDyLkCfXTetaoKBfarZSwbXYK9aaOeL04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaJ9uBB94kTz7k6iPsYrSTDzZqn1Rrsp9G3OzGvkb0f5K/hLvmdFurUqeT1O3mF4wGbSpi7hrgd5DOcQ58ZO4V+Gf0HHpf7gH9qe0KghlkFmM0tKMJfz+3IL87RVpGwNKjgSUIL/kM70L75n+ebzlbRo2U+4lN82d9V0WrKrZVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lU0ecAJ5; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lU0ecAJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abf9W0J2FrRkvMtC/euCaOr06XicciLHkfGpH6L46rKOA1ob1PHXeBIu7WI8NA1klWQS8EmW93EBC9My4AXGXz1KP100ewL+zs5pMHqs+XKVUOYWYynrqeJm5DgHjXcvSwDn9TLl3dK0LZ5tyMf9/RjHVjy168uzDaUGoQfur8AYP2NIzXDXtXCqOU758x0qDxKYg38+YOqQT+jVAx9FFCMBOi9wv6Qk4R5DJOmgkY2lE8cChLyKtt6kp7AoMGAe9htan2FAkp3b3UnFAcVOfhvma8ArLlJ7Lf26WthfElFCn0oSV8myWJjQ7Lr510EtuyyLLx/HbdIPgf/Q6fpokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0Nn0aPBovuECTQY5QKtGkNpjlZWa2eDdaxQ1jV1Oug=;
 b=Kx910QxXXcJJX4kyLZgyY7HvsuUgbxiOtHZEzzg8Lb4IU3Lo7DTIOq89KuI/srwdLGRXWSIXO27MFKNZFSUkIrfUio4vWaXlGQM+nZDtVDOPUV/T3lva71l4ff+RbqG6oO+4sTGrDPGWjTdH0tkIyQDFzG4575h/flhy1W5HyLZ+zRV3s6niNSDGs+x8zBMmVRx/viTwks5KvQnonBKSJa0Sf9QM8xJOXflXg3wzVsjFHAlQKWfatxqb5CYeo1AgNcpktVXFRABJmC1Y1Fel8+CZBgT7mQxKtl0J1h6PdFu1NVzNxs25yEUFfQ8xFZCOLPQNiT3Ta7Ot2bp/dMp5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0Nn0aPBovuECTQY5QKtGkNpjlZWa2eDdaxQ1jV1Oug=;
 b=lU0ecAJ5kcUa4ZlPqqxMALek3n3wi3crVNXS99gjvpYpHyo/SW4Xji+yTJnU/K3OnXHi9JkI2IliJ7gUD7Eo/7rO4lr8hVbid4+d3byFXePXQtnBezmXH86uCImZ3Wc2nWHoHHTQf3zyCUda7n6hdOkPQP0OXc6/vu6r8r6S4o4=
Received: from CH2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:610:53::29)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 12:14:42 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::ea) by CH2PR17CA0019.outlook.office365.com
 (2603:10b6:610:53::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:14:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:14:41 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:14:41 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:14:40 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 3/3] cxl: Move pci generic code
Date: Wed, 25 Feb 2026 12:14:30 +0000
Message-ID: <20260225121430.3839189-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: a07b82f3-1efc-4e06-c9b1-08de7467747d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	Ma4BEe/+U/gW+YmQrVkrDJldm0Yt9Z961zTeyVxujM9p3eDTcKk+ct+XvYRfPR+VPFIxreaFzuCn/T1hb9o4CvX58CDn8xf4HFMbIJDxOj+kQSKL/qUTdp9nSNI8pA8S5T/NDPKgR+tcKoPe+lFS5YHqCheRIJVYKALhjze3fbTHfvZmy8H6N/63GhE9ltyXsbSPXYqvsjrmL09Qy3fliqrOA/Xu6rTuCxKK3o8VEW56XaAKJKhQkE7JV1KJkJlL27jEbSYgsjZBUNOfuqHO6jENMj0cHiqjRZ+jvTA/8qz5N+mWvJln4fPEkZCyQiC/kSfTtw+U7sypiqBCbeMyVaFbNGImlvztYyqw+cx5GqaqxJt5IjDE+Oc475XI2m+c1Y68tVKGoMXwI+3lLJNSLmycu8sfesSgsIXFSEGEhJ3/LqSsSIJu1QZnyGFD18nsHENqjvRxPdf2YUMfgB/0UNXXYzljDc/c2jaTjecX33Zv3EoAz2GI1u6gdndQJKRvNhDWXJ6qsaHF4LTqNRJtVREwYsNS1OYeYF3qiXG8ypD6EcYV9zFW+a8kIfKOqpeyUONFh+RRg+5JHVulugwTAhHZOQfjeXBlESkAPgA7ZTSd5uKWLjsvFXRKB7Tu0pEWvHWNTySG7uOi9V53obk422yL4pXadwmRSIhjeRywBG2bZsK8EA405mJJd6cy9RSjkPjjjo97PQutt9NhUkHUZHz2TajUBk+JgeZ7QxUJ6TdWpLqDWjCTkppaBLPwg5K+2Hwi0BZMjSnrG/YSpBVrDp1thcmRA25v2Y0MPrWwoeVm/Rk3qecbomIMELVo3N9RR40r3Ik9Sew+jq0FqxxcRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B6HFfYFx/1BsQQIfb2Le+h8ISEeLCEa1N2vgTZC2TCRHkzPe6drKmFF+L/f47p2a2wtMxdLikrZJ3f0oehkzXa2DVxnLkoVZRocTKIeA4QkKajryqSuF3Exs9XrHIlzGdeY2g0FMZQIzOsRIClLu8EiLpdL2Pspm3q1aagz0rSsmiKkwcH7cXKF0Uq8b0gqTMMOBsOmvEFbQE2YWyT3t8eKXVTGQ5QjNEPjqdEDQSLiUDHHUgoNgGZECS9OWb+jKD+n6HgBTnjMC8p5oV55YIrKMUiLrIoa92nUMZktsLg74W7jrD0ZiTuOIYp3HN9Wh7gK1K8bXb81KG4De5fAIKQPH3p4Lc6GinuBNETzr4YYu60HCAaJAaqMOENTPl0FtH7zSJk9bgtFG0/wBys4GGiDdBU0wJqDywSqgCs9qj+rY4tjbp+2l+DkNBCwmpTAZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:14:41.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07b82f3-1efc-4e06-c9b1-08de7467747d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
initialization.

In preparation for type2 support, move helper functions from cxl/pci.c to
cxl/core/pci.c in order to be exported and used by type2 drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

