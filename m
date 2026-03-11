Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D90355F43;
	Wed, 11 Mar 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261361; cv=fail; b=Xi6X+W/wqHYxoyxmcsesxUOtADFA60uXt9DsZfSOBLdXS6EdF82HHspvFUJKUbX70VI1YSiNoXTWoL6QQDfhbnePO96ISkqg+r4DyKjEPl7XNEk9Xt/DLsjcsy5nDeHXCK5uqqN8LibWiMiTS97bSkPn1x4EdkgHAOWMLxWeWd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261361; c=relaxed/simple;
	bh=HxSbwzsS+X/miJJ8u/3G3pPmjGgO/gbY1dWJHDlczPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZLHIT/IWYR8ZG83vgNYmEFLcCCQjWzvYv5iyQmZw/GNqoBo9ljhNKCpnXLCk2LD4w3O15rjdLTeOwwy6JXvrEiUl4NcFW1fIFzQKQ1avb9F2Wm/7Z+IUZKtobjUoN13Lvu9tUf2hJKChIjy2m+Lf4LwXy35Ajmuv3Z/RMNg6Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GEKcEjfo; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GEKcEjfo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXzz7JIJQWLBXkMjXDg7ORDByKpTqSjxoE907+9jHYkRDj+ZjJ9GMz7jrCBMvDL+9O/QGwSJoSjj1II2XOStyaaVYFCiweBCE7K/NqXFfSIua6vxWPLAwtCdDoHQDO0b6DBqs/r0rlfuTPhP0EWr7SWQ4wUnlogCTBl7KTnfS/7BWvuyNgs+NT4Y5wxgCk1tStNnVMOgxSCM/urF6MY26cIT2ED/qql/ESH50Q2PuoNLfJxgdVXsOeMJNuyxkwoGXbD/jzKhBTmuO/R8XNetSNoPO1tXqBV9BcpipfKxBLb1dMVCGlaaxWUnUrSi/EjF9rgDRR8SqnWGnQXQI+CkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbdeXCY44RBIWU4kVOTrNmxhnBxBnF0SwtZoIX401i0=;
 b=HlWJTD1i9KmuH+wZH/hZ1OyXmvJDppxzgdkiU+O3AD86krfHR2niLBXKseAH/gvo9RJ0zC4LcuJaulm6DEd+ZsRkxdbHlTaUmM+B+lvaVRIUXHIIe56ZNpXhLmJuywTY/uKAgqzmSqP8DYp9tM+3mNqcpHWSVGeUhn32lQfQ9foYNrkA5F5elSunD8NQUH7Wh//hxbpXLhI6OanOJlTCP0m26feio8QnnMpCPDm8iZ8iO7IOVlK6rv7JBwl5YRM68Q5dYpCDB7OELj6v5e0c3ceXtzjjplsWSafsrxPgpqqY+PET1IbgAVGD5Q+J6LItZTcTAXxVp6wbVbC69F4hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbdeXCY44RBIWU4kVOTrNmxhnBxBnF0SwtZoIX401i0=;
 b=GEKcEjfoNEkXinTVTKAOU5KdoE1U33enxvFctonU1KDsR5oRa90/kh+xjKj0gHYA/UmYgcqzbXsuAOIVuuVo0eGtMrKMMIwKnoH+3MtpiToK5ckGU20GQZZR94RoZ23HLul5UiaLkvx2J80LNTWASebd+0lYXB8nnsSjTvRI8coKfpMxPQ9fOGhx0XKNa5+yWIpHIT4r2H6G0mzJKbdsHJVx50FgRcVMd0Pz38afAwYakc583OHe309mfCFB4y1DBB4gNBxoq02o0BNDFnRqOdwagBNS528w71exRYUoq12SugR0IHz1oTSGHGjMsYEC3OefgwQP+vbueB+tfb0DsA==
Received: from DS7PR05CA0041.namprd05.prod.outlook.com (2603:10b6:8:2f::8) by
 SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:35:53 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::34) by DS7PR05CA0041.outlook.office365.com
 (2603:10b6:8:2f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 20:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:35:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:34 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:27 -0700
From: <mhonap@nvidia.com>
To: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>
CC: <cjia@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
	<kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH 05/20] cxl: Expose BAR index and offset from register map
Date: Thu, 12 Mar 2026 02:04:25 +0530
Message-ID: <20260311203440.752648-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: d86f396a-5f94-41b7-b20e-08de7fadca6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	S2nFb+M/pIqcdTLqu6O5qQPrE8vxHZvu8G5QQydGiVH+GdFbZezlU5vkVksAt41i3q2Tj2zP0LmueU0/FpzdYl1L2FKKZCs4lOT4yU9f3FgMPRGbYqoVI5IyfOGl70bUxDwVWFmjx/8vhcc+V8v9JUR+WrNbnYDivA++jRrDE2xwSoQfbMBSVPaa2Z+hmSqwr0Y71tDzd5zfRulXG8D2xcBAFchdo/tGG2aBd+MWWK55QLUmNWU5OzQ1AHlzko86CoVuorSH21axNgqhR4u+MhDONs02FQVWUxOy1ytbbyucU/KJwtVE6mIYwTLcQ2hLZmqFX6dbhhe5sfechcsQcMjEgR+kS9YR0mM2n4MQeUTpLz5vqTfmfOMBfgjkJzg0bFZN0N6dgmH9ZiWgVO/FuxOtKH1EloHSdSWm0fQ1rLI7jdhpha1FQiPWEpg+sTN0WdnqjoV7qOwWPHbpel8Z+xtyqn5Bp4l00VpVJY4sgXRlQci08Jt5lm6zQ9ROzPiEu31C9CPNaRszDnrj5LwCRLAmjQ9cfvj6KBwX3pVeR/vu2lcpQ1xlBulbsgXGDUeqkvPjoyVbJsroeKHFjhAFVtmUoxTJz8Rs0vvIqS+ISHcVzcbmYshhKbhXU42GjjNFoLuhkdmi2lBGmWbO4DaMPnVXJK4zJddLIEY1T85YM44K7I/xBp7bB2NbQKIHYJ41Zuzc/iejoj9tyLZjYzq8VmZXgS3v1MdF3Us2AedzZLf8uvgVws/ieRaVzp5KxwTtIDv4PFEYAJEVsUr+xLvXTM8KuxO1AS5IDoVkgP6GNUsyFGUCcFNvSl8GkxeJLqgc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	waqJCIESFoBgLxR8x1ZhrcqWoKBFxHgFhFrVYJLBT/eTMEDH3Aca7T7TMYB8qLjICEXztEs01ewiRowL8z0PFVs0UE8DkV8vvxHkPsk1VuPr7xj2IxNTCFlu8Hv34anLS1E6XOzLLX9+xjpVIY6xLvLBi/hYSMTJC082KUx/xk6g4FgOvSwQ2wkp+UG1oaqKUpOgDKhqkIAe8LizDtAcqxTUZ3AkVb9rMNp4ZFVZHz7flGB7oJRx0Kt73I/MSPuzU/1zS+KEdEolPgtZQdYCWU6ypA9YYdETUqmtXEr/1EzhISW2hoSCRXjh/g7chs+5w+7QieYa69ofNXo4a0ltogPdb69Y8GD3vu8AcADiqcciHKKEYca/DW9V358mhvusqftf074fifQjwk1JokPC2u/4GoAkdV0+k/kkInp0xxOIgLLW3FOlDIUCaU/mYqlp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:35:53.3925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86f396a-5f94-41b7-b20e-08de7fadca6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033

From: Manish Honap <mhonap@nvidia.com>

The Register Locator DVSEC (CXL 2.0 8.1.9) describes register blocks by
BAR index (BIR) and offset within the BAR. CXL core currently only
stores the resolved HPA (resource + offset) in struct cxl_register_map,
so callers that need to use pci_iomap() or report the BAR to userspace
must reverse-engineer the BAR from the HPA.

Add bar_index and bar_offset to struct cxl_register_map and fill them
in cxl_decode_regblock() when the regblock is BAR-backed (BIR 0-5).
Add cxl_regblock_get_bar_info() so callers (e.g. vfio-cxl) can get BAR
index and offset directly and use pci_iomap() instead of ioremap(HPA).

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/regs.c | 29 +++++++++++++++++++++++++++++
 include/cxl/cxl.h       | 11 +++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..720eb6eb5a45 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -287,9 +287,37 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	map->reg_type = reg_type;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
+	map->bar_index = (bar >= 0 && bar < PCI_STD_NUM_BARS) ? (u8)bar : 0xFF;
+	map->bar_offset = offset;
 	return true;
 }
 
+/**
+ * cxl_regblock_get_bar_info() - Get BAR index and offset for a BAR-backed regblock
+ * @map: Register map from cxl_find_regblock() or cxl_find_regblock_instance()
+ * @bar_index: Output BAR index (0-5). Optional, may be NULL.
+ * @bar_offset: Output offset within the BAR. Optional, may be NULL.
+ *
+ * When the register block was found via the Register Locator DVSEC and
+ * lives in a PCI BAR (BIR 0-5), this returns the BAR index and the offset
+ * within that BAR. Callers can use pci_iomap(pdev, bar_index, size) and
+ * base + bar_offset instead of ioremap(map->resource).
+ *
+ * Return: 0 if the regblock is BAR-backed (bar_index <= 5), -EINVAL otherwise.
+ */
+int cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
+			      resource_size_t *bar_offset)
+{
+	if (!map || map->bar_index > PCI_STD_NUM_BARS - 1)
+		return -EINVAL;
+	if (bar_index)
+		*bar_index = map->bar_index;
+	if (bar_offset)
+		*bar_offset = map->bar_offset;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_regblock_get_bar_info, "CXL");
+
 /*
  * __cxl_find_regblock_instance() - Locate a register block or count instances by type / index
  * Use CXL_INSTANCES_COUNT for @index if counting instances.
@@ -308,6 +336,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
+		.bar_index = 0xFF,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 684603799fb1..08e327a929ba 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -134,9 +134,16 @@ struct cxl_pmu_reg_map {
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
  * @reg_type: see enum cxl_regloc_type
+ * @bar_index: PCI BAR index (0-5) when regblock is BAR-backed; 0xFF otherwise
+ * @bar_offset: offset within the BAR; only valid when bar_index <= 5
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
+ *
+ * When the register block is described by the Register Locator DVSEC with
+ * a BAR Indicator (BIR 0-5), bar_index and bar_offset are set so callers can
+ * use pci_iomap(pdev, bar_index, size) and base + bar_offset instead of
+ * ioremap(resource).
  */
 struct cxl_register_map {
 	struct device *host;
@@ -144,6 +151,8 @@ struct cxl_register_map {
 	resource_size_t resource;
 	resource_size_t max_size;
 	u8 reg_type;
+	u8 bar_index;
+	resource_size_t bar_offset;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
@@ -319,6 +328,8 @@ int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
 			 resource_size_t *offset, resource_size_t *size);
 struct pci_dev;
 enum cxl_regloc_type;
+int cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
+			      resource_size_t *bar_offset);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-- 
2.25.1

