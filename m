Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651A43E49C;
	Wed,  1 Apr 2026 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054449; cv=fail; b=oBfbyxJPKhW7nKuKoHJCtYC+67TAMRDY+OyouIYXK+b5I6H+zPhk/aPWzNV6KzEGdzv60YKzixXRPI2OCNYG0l92jEpSF/mul5LWUQU25vxdXKTCMCUL8P/1OMgAtf5OdpKyjHhvrZjEbjbGBCwsvEC80DtClbkEfHpdwa6UCew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054449; c=relaxed/simple;
	bh=oG2lVXc/ClWnCjW8dqwpOxhd8OQDyg9ukOFHsktgHeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoIvrjHxxC4sxTCyGVkK0p0sQWEWOu8xYvJmi5a2m4quuYKzLuxtXzLGj27tZEracFKfJuHIomb5VteCrcRF93NVrT1cl88kMHM8V58KFaVBas6vdKtKNvbFnKj/MUIX9furciUGOYSFeE4k3irsRvUrwL1qctA32fyWhpzi/3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HGmVmyYF; arc=fail smtp.client-ip=52.101.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HGmVmyYF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKPln78/umSlP0F8IM2XeVmz5W3SGDMm9kr8OghxHndoO3ayDKzfKnQ70nAVLp7YEjMuvC/sIyDAxJ8N3HxGFunkGdB1YcZRLuGDvHRAk8eteRSIUP/61b8QOaYnhv3nbw8bn15+G24ZZt8PQxENl7XECEHlL3PWwAKZ+ONxV8T4tAYUc7HQQnOtYIB0I+GEqsyVqq/i5Y7EKYoH1yd4h43xe4ZbUBa9kDaprF8huX9qLV7FGEpqY9NCgycPlqO/3sWIrv9b3yBN/vr2fx/vKtQ6PkhHoV8RCIIW9zFiw24h+jJabxYjA5jotPu/DgQ1ZMeZ6aRfQNkLCERvdSQRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp1qho77JqVUGahNWVpqszcz11EQnYca0A6DadrkGq4=;
 b=Bj26mwN3b8jSjPhmX2JElkRqAhtjVBiX2RsvZaul++1YIG2MM8ZQ6UZ/rcqxpopxBeW5jcSAVmkoQmTYmXqwlfTWrKyjqaGFf8hM8GrgDj83Pz7JM/cWupMerYui7QT1j0m+ZLvwPHca7l1MAvffen4hUuEWQTsLMeZDPX5z9aTiyNhPugBb25Chn1n/QF+4GEaiBDC8n9JJKEPT3Zo3c0hGHcTBBxf3Z9tbz6vdsWLvPwVzPXTpSvc0D0zPvGDh/vzSvfhY3n44CBBwrak/IKnpKIjbGtgC7jSiXK5OdYuWLlCYl3a+jkcha4kqf48JxGZljBY+seg0qWG7f00glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp1qho77JqVUGahNWVpqszcz11EQnYca0A6DadrkGq4=;
 b=HGmVmyYF7uQvSt08JG3uJ2yg9d1OBKI3h/1P53+Of8W+N+tAQFspX/stGHgdwCNiDxWtbHpbKL8lv4q3YyO37VXT0/RwXttpv5q/S6+1nK1BytyM2xs59Sxp+qdYJqmD5sspKEYS4W++t+aN763S6JQckTIZOa5+0NaG62q1UqGCiOLf07hmCBS567kbgM3WVX6F1mczchJ6nnCt3Mi5XfrlyzGfNJX8jS29ufCUj4S5TCY022duqjysSlt/GLUe90lrvuJLP5AEUM/WUPKknl8f56a/cyO9DXWC9gTqzkmL58UsEotYB6KNJXP2lPZly9nYZItIZtdSdebE9QjcLw==
Received: from BL1PR13CA0385.namprd13.prod.outlook.com (2603:10b6:208:2c0::30)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 14:40:42 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::d8) by BL1PR13CA0385.outlook.office365.com
 (2603:10b6:208:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:16 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:09 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 05/20] cxl: Record BIR and BAR offset in cxl_register_map
Date: Wed, 1 Apr 2026 20:09:02 +0530
Message-ID: <20260401143917.108413-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e69089-b754-49d9-072b-08de8ffca6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	baXme/g2fRzEpuv1T7/iRWKSybjw5w9zpfdqE4SXRTjmLyPYPHNaaMVbuPXeQuJBGgk6F6WYdWYHZltIlsSHiDDnjnFzjPhQ2blqQIzjAkb1KXIWEeFGacLQzNYKNISB/58xZPtPAAS2668YkDrddTvu4vlkEAWuxSlssdK9qKa3LozXKrLViYHL378DBykPObbyymD4Cpbwk/WjkBYEOmdoIo53TobWA+t08eNOL+qE9F6kYI9hIi38kh+U5QLPYo4pImlg/6GvmRJxqEbUzpJJ1K2ZHY0HSD3Ch9F16Sg8l11eIS/4aeIRFJqNDpNzJsi97Jgm7AWFuankJmo5Nc8/dfTSNq9nnee3zWfcEptzQ/9FOiVUEJp3lxhmD7PzM/bwViqw+WFnG+qQ4/lj8TX0MrR82bw2FlTeOVDqVhB6gBI55prR5XMxhtDGrvDNAt9jlISQBZ3d+WtB+uLVRqJ6+Pqo0lLXjGjtyD4IZW5HwdSdSPQ+BX0XFD1QPFpS27avTxsbpmKEckkXufKs20yjK+1w+7XswqBLVr4YYFGEoh+v9sygiDdw0BYj/Q/Ldr8x+FNee0c6rzwoRUyIuvvdlz4u77VEupSCkV6XtLhIXBamZ5iY1YX+dAeDRtvew9D0leVCQmvAchcrneyLMcgtoVIOmfsEI/NHT/BDJUIDI/8N3vCgFMr8IVCv1vFQF7saysiXGxk008PzAwwZIJOk8Io7LKojN2EYhbI9xNI0EPjbtU10FxUGWUvfyPBl4ieCdiiwL8LJuK5eJlhZEAt6HpwX3IdxRFRiy4abDwkhop5PHR/Py98xt65OoOrr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M0SRV6N3XTk/sU3td5sRyWIqZi3GGhfyhU+XrG074imCUhyaSfT1CKzU2a4ZbsjJKcHdGnd6Amk3MJ5Z7zmKwxIeayopkylH8R4/APaNAk+XfET8T7yVG2o2TyWbZgcuguMLIjQDt1u3xOzEGIug33mQltdAfG3MiXiHdJ4x3bxkaNkdy9p7T6a0lhjdtfCds3QPLd9/4K77dGXtlTYCZ0DbqEjNx/GJEgEfi218SmzcpD0jYv2Aa/bxtgMB75r8MD/AMY+B/dehZ56kyVnUe2FBSyxSgVXIxGpE6VEpmoRXscU3PyGj5RRGL9gclf8L5s+GPq1tvjFWfJXhdDYS4CrDZpy6bq3Uf3acXaw19YsXSOaAJhl9/6w9mT5vBaKBFuNyqeN5HY/a9HcW1MRUYhIrZXNiZBOnNjNsSGAOPr41eLiYlEXwiPzFOvow4UAz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:42.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e69089-b754-49d9-072b-08de8ffca6a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

From: Manish Honap <mhonap@nvidia.com>

The Register Locator DVSEC (CXL 4.0 8.1.9) describes register blocks
by BAR index (BIR) and offset within the BAR. CXL core currently only
stores the resolved HPA (resource + offset) in struct cxl_register_map,
so callers that need to use pci_iomap() or report the BAR to userspace
must reverse-engineer the BAR from the HPA.

Add bar_index and bar_offset to struct cxl_register_map and fill them
in cxl_decode_regblock() when the regblock is BAR-backed (BIR 0-5).
Add cxl_regblock_get_bar_info() so callers (e.g. vfio-cxl) can get BAR
index and offset directly and use pci_iomap() instead of ioremap(HPA).

Add cxl_regblock_get_bar_info() to return those fields; -EINVAL if
the map is not BAR-backed.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/regs.c | 29 +++++++++++++++++++++++++++++
 include/cxl/cxl.h       | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e828df0629d0..43661e51230a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -288,9 +288,37 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	map->reg_type = reg_type;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
+	map->bar_index = bar;
+	map->bar_offset = offset;
 	return true;
 }
 
+/**
+ * cxl_regblock_get_bar_info() - Get BAR index and offset for a BAR-backed
+ * regblock
+ * @map: Register map from cxl_find_regblock() or cxl_find_regblock_instance()
+ * @bar_index: Output BAR index (0-5). Optional, may be NULL.
+ * @bar_offset: Output offset within the BAR. Optional, may be NULL.
+ *
+ * When the register block was found via the Register Locator DVSEC and
+ * lives in a PCI BAR (BIR 0-5), this returns the BAR index and the offset
+ * within that BAR.
+ *
+ * Return: 0 if the regblock is BAR-backed (bar_index <= 5), -EINVAL otherwise.
+ */
+int cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
+			      resource_size_t *bar_offset)
+{
+	if (!map || map->bar_index == 0xff)
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
@@ -309,6 +337,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
+		.bar_index = 0xFF,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 45d911735883..52eb40352edc 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -106,9 +106,16 @@ struct cxl_pmu_reg_map {
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
@@ -116,6 +123,8 @@ struct cxl_register_map {
 	resource_size_t resource;
 	resource_size_t max_size;
 	u8 reg_type;
+	u8 bar_index;
+	resource_size_t bar_offset;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
@@ -300,6 +309,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 int cxl_await_range_active(struct cxl_dev_state *cxlds);
+int cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
+			      resource_size_t *bar_offset);
 
 #else
 
@@ -317,6 +328,10 @@ cxl_probe_component_regs(struct device *dev, void __iomem *base,
 { }
 static inline int cxl_await_range_active(struct cxl_dev_state *cxlds)
 { return -EOPNOTSUPP; }
+static inline int
+cxl_regblock_get_bar_info(const struct cxl_register_map *map, u8 *bar_index,
+			  resource_size_t *bar_offset)
+{ return -EINVAL; }
 
 #endif /* CONFIG_CXL_BUS */
 
-- 
2.25.1

