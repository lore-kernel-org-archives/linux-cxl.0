Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6F3921E6;
	Thu, 25 Jun 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406548; cv=fail; b=IL1TRy62dtxfCaaIyqB6EclvabaiDxqrfxSaCjUYUDX3fFy6BSzUbFBxefg+E64dMoBk6rF2IKJ5GVLnubKrPlJfcfk12dyN/QmQlet3JQN+0iFILnPetA+2NOZGHBWjfucog1v/WmW4Te0pqOQnNPGlPuXgn/KPGDhpIYjcF9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406548; c=relaxed/simple;
	bh=KHbqbBATJAmxY/2eXbSuRKZpm7Inrqw19ZcQJYpnaQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR0ZfwJLfgH0+6BaCd9KRywUVTAahUv5xGKFZ5Wb+/xKPr5Bpe4KGAMuo1LBhtRU8OvuN1yfmb+beJYmBHj8kHTuESW7306wZesJRAG938F/pAsxgAuJT90IV6a9v7dWuygtvr2bf1gIAZRtI6M2gQWpUQHP4fRkcAaxR4KuuHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QnTxV4A6; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QnTxV4A6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWtpwGbPmws74O1L4j8pNUjSoqNoMNrXNrJ4KppCmizWIxgUFxAF6nfbOlzgTgLhPM5YqD9OO/7AccGDzs79uAg1TmaA7k77ZPp4w4G9sLw21ghc5/lX860RIZspwV2JNIJjD3rkQR8BOBDCrKMPJT5q1QqOA/AVmZtNp0jgr2QHp7GazcVcGPkXQLS1RZq8EYSTpygejGtFpxdSESSLvAhT0pbg/Hi4f8fk73qLkuxPXyattT7DiwussudFiUM20H/ILtWfZYkPjPBY0+cwOfFVsLyjYaRQPofMiv1ZfmOyzIkGWrbbzefPQzdZ+9LEeB5avIUfn0PZnvNmeqZe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq5beqRl0EIcyEce14QrJyiPevdiJ07EgBMQW0kMF9w=;
 b=iiT0UAai8AYL+P3JHGyGrL8VZWje7CCNTnH4U+rNEOpeMqR8dRoeD2gZjhf3qKyPX9KH4QSXrGsYcurcl9kNuNGWC97pofyno/CFu84aGQR+PMEUMsl6fWS/50upFPU8QN/oOWKM/DDAIA6tqDiEqYKv8k56IIPYGhDjiwwM52nwH9ZEns8QSBxkQWSSEFtIAcWxEhn2FxxeuIoJYY/qqfmPXXH9HXgffYW2HfTl+OZx6rsO5aj8gsWjaGyaJCCmrF8oBGdNXwNxsUwN3DXOk6X1biP/hHeMIaNn07Ge1UJXLLgn4j9KQzwTE3vmZefmzHsksSErOAllQ346NwI2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq5beqRl0EIcyEce14QrJyiPevdiJ07EgBMQW0kMF9w=;
 b=QnTxV4A6X9aX5sweEyCVc7Ik3bXLmqabLNhKOpgUBFSVmGY2OUAWlEUtFJ0DF8iKMp8MPgye00gbl0356/HbaocVLXw1x6Q1iU6QUT7UnhbkoharROKz+nKd9FcMn4d4LFHy2FWUcTsvMUJHvhg+5mRwUh+vMqNoIfc896KqLJpLTdQ114gavcF/76j7Sg+FZxvS2Gd672+GM5Ap5gOHE+j7T0eKoAZ71JmDewJZ/YH2g5waQugnWz4nAI3hhoYz8VecIp/Pae5xrrF6C1L7d6P589tcWpED+E6pEqS5rXkjLVEkhFt9DghfY0ALx4jNrD2Y1Sslh3UjPu0qIkXiSg==
Received: from BN0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:408:e5::25)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 16:55:36 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::3f) by BN0PR02CA0050.outlook.office365.com
 (2603:10b6:408:e5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 16:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:08 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:00 -0700
From: <mhonap@nvidia.com>
To: <djbw@kernel.org>, <alex@shazbot.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <ankita@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
	<ira.weiny@intel.com>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 03/11] cxl: Record BIR and BAR offset in cxl_register_map
Date: Thu, 25 Jun 2026 22:23:59 +0530
Message-ID: <20260625165407.1769572-4-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: dceca2bb-aefd-4bd7-32be-08ded2da93ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|36860700016|376014|1800799024|11063799006|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	Vt2BVw/tvDMVR6rzDtIBpDyaqV1hfiIuV2wlsnqQYUbjsa2lul4ZvnsvGJY1ey3p1+nd0LLFPxSdheALkB8m77iWuRjwY1aktY8KN72+p4z9uCTF96gXREKbY3Tpe60nHgCp2T4QOVbpHVpfWSQovkEcrdxaBXpu3xW2c93kDO+7ipntczEDhU60yz1aUniNqaF5WnTvyQ2M8incccI1DNhuZ/j9mSYuk3qqPu+h9YK/i7fIOrHsitAg7+h7lDCKFJfNu5EB6zKRLWzj9DfQhqsUTqtVWqJYrugt3DUW/KOQilrP6XHYOM/VwTrqQQwuHcQSM139dZWeF4JCC0QOH3CYPq6P3ZsxlZf4PFIM3FAUuyH3Q/+lgGzWZY47DCXQQCzTAIYWW9i5DryuXhEkS2cxorlQMXxbQwIDyn9Ln+NoYFlvoUOEYdMindpGgJ3DxBsWN5l2oo0MbFIlLqoSrWLPdI5In0cVqNGDmWe38H6LwIP1VD+MY0/IHB496J1A2ThJ3I1kZWK+B2WhyyGJc7mnKHNBIUhyx7+6zdp2wcc/EtgIYpNAbyFQlq9bTfrP1bYQocjnk3FsBKrWObzZuxWdPTUYoV9Ro8RMvdC0d5PNdwNvwqMJiDf53urElC1m4el81Sh6GnBuUuX8gg00mRQ3t+hShmbpPIvUujQGV1Q/ffjqTb4N+DnQK3Xd5kLtNuU0D2bBIFsDv1dfSEEauR2imT3HUVAzNM1YdNU2M1c4jVpJt6ckNWOgeZf3J5KB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ibNsOpx4Om6+Zeg32LqEcDTBjt6HHiS5KFcbrGYnKH/iqo8GREYb2/koi5bBKGA7UOvjeyRo5ow6o9u5JlTtNoObOFlNEpDVLoiQvVFgEdC07HuVSd+FSv/cYlKoajmzCf1EGSpig0MpY74gnvOV+xat8wM4j5gQoQBuTm4jbwrvhZX/1RHjYqwnaRD+HsH/7erRmsZRE00x0PDMDyUZ92you3oo+33EJWxTkv23KtRzNdn+jsIbLOpVf1wR1SOJPPXOqlPAR9ZTIYYyyakdfupDWjfKIhawbGr1j6GcP0nDhk+7LnEIrQd6yLLS8qdh2+nYWLX5rgIv313RAEdOc5MkL1AS7dL1ui4SujQt7yyxHem/CY+bJ7/B5A3aJ29PsK4BQ2Oqwu5ONv4o9J6lgaHbp/dxbHrU+3LSezfSgXESQBRNPylRxvTB7hXAGVJr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:35.5433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dceca2bb-aefd-4bd7-32be-08ded2da93ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

From: Manish Honap <mhonap@nvidia.com>

The Register Locator DVSEC (CXL r4.0 8.1.9) describes register blocks
by BAR index (BIR) and offset within the BAR.  CXL core currently
only stores the resolved HPA (resource + offset) in struct
cxl_register_map, so callers that need pci_iomap() or want to report
the BAR to userspace must reverse-engineer the BAR from the HPA.

Add bar_index and bar_offset to struct cxl_register_map and fill
them in cxl_decode_regblock() when the regblock is BAR-backed
(BIR 0-5).  Add cxl_regblock_get_bar_info() so cxl drivers
(vfio-cxl, in-kernel accelerator drivers) can read the values
without touching the struct internals.  Export under the CXL
namespace.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c  |  2 ++
 drivers/cxl/core/regs.c | 34 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h       | 12 ++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c44595447bd8..9b9b17db9ee4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -764,6 +764,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
+		.bar_index = 0xff,
+		.bar_offset = 0,
 	};
 
 	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e828df0629d0..6af5739aa776 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -285,12 +285,46 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 		return false;
 	}
 
+	if (bar >= 0 && bar <= 5) {
+		map->bar_index = (u8)bar;
+		map->bar_offset = offset;
+	} else {
+		map->bar_index = 0xff;
+		map->bar_offset = 0;
+	}
+
 	map->reg_type = reg_type;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
 	return true;
 }
 
+/**
+ * cxl_regblock_get_bar_info - read BAR index and offset for a regblock
+ * @map: regblock map produced by cxl_find_regblock()
+ * @bar_index: out, PCI BAR index (0-5)
+ * @bar_offset: out, byte offset of the regblock within the BAR
+ *
+ * Exported for cxl drivers (vfio-cxl, in-kernel accelerator drivers)
+ * that need to map the regblock via pci_iomap() or report the BAR to
+ * userspace.
+ *
+ * Return: 0 on success, -EINVAL if the regblock is not BAR-backed or
+ * if any out pointer is NULL.
+ */
+int cxl_regblock_get_bar_info(const struct cxl_register_map *map,
+			      u8 *bar_index, resource_size_t *bar_offset)
+{
+	if (!map || !bar_index || !bar_offset)
+		return -EINVAL;
+	if (map->bar_index > 5)
+		return -EINVAL;
+	*bar_index = map->bar_index;
+	*bar_offset = map->bar_offset;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_regblock_get_bar_info, "CXL");
+
 /*
  * __cxl_find_regblock_instance() - Locate a register block or count instances by type / index
  * Use CXL_INSTANCES_COUNT for @index if counting instances.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3dcc034360af..3bcb71d80c91 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -100,9 +100,16 @@ struct cxl_pmu_reg_map {
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
  * @reg_type: see enum cxl_regloc_type
+ * @bar_index: PCI BAR index (0-5) when regblock is BAR-backed; 0xff otherwise
+ * @bar_offset: offset within the BAR; only valid when bar_index <= 5
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
+ *
+ * When the register block is described by the Register Locator DVSEC with
+ * a BAR Indicator (BIR 0-5), bar_index and bar_offset are set so callers
+ * can use pci_iomap(pdev, bar_index, size) and base + bar_offset instead
+ * of ioremap(resource).
  */
 struct cxl_register_map {
 	struct device *host;
@@ -110,6 +117,8 @@ struct cxl_register_map {
 	resource_size_t resource;
 	resource_size_t max_size;
 	u8 reg_type;
+	u8 bar_index;
+	resource_size_t bar_offset;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
@@ -234,4 +243,7 @@ int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
 		     resource_size_t *offset, resource_size_t *size);
 
 int cxl_await_range_active(struct cxl_dev_state *cxlds);
+
+int cxl_regblock_get_bar_info(const struct cxl_register_map *map,
+			      u8 *bar_index, resource_size_t *bar_offset);
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

