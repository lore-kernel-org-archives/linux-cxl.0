Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED235DA79;
	Wed, 11 Mar 2026 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261377; cv=fail; b=LC3vXo6Sevz+/avSd4+WUqwUkozKgc6FYOzrXKZQjJ6pxD5QwDbeWvCXFQIWnk5XHJ7dRGM/JfdqszzUc3JAmbKWbn81L+l4frQpIJXs1rznoj1pzrjp56go4Oe9MDmWDV0DTq+BY7JuNJpgVr6x33Ae5G+SD5d0PDWi2SwTr7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261377; c=relaxed/simple;
	bh=5UCi5vtHgPBGAyrMhMcHPC2C7g1O+sN9XFRK64tNCyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpRxzAKaEM5z81aBgZWgzADQJHrGXuFypXxrnzNnn+0ZS0vpl2esFCUdjq2AJWsR51NISN6tnu0lhxqpIAYi6BSnVg08d0FEjNjRfOrNocAwBTVpfVOa22XGrbZ6DkI6plCz7XGcvds8VOgGCSBykrwEz7DpMm7PYGxEW0xZOYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQtW3Crn; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQtW3Crn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8qESA5J2eTEFOwHoRdF2hUURHpiEeICbvVoxAGYfYkIKDXuZBv0f7bVThA//2lnrKPbDI1hRjYWEfeechQLVd7UEJc8NleM0MA0FKV91Gm3LKQrnU5bpk17VML3jkiWe7GoMb5xwxTNS+IJXQ2CNidSXVj7w/JTzA3wiCzHDkdB8LRGUDg6FbBCFsS/V7r1R2vRUGwmRv6gDqC4n7dQbUbnrB+MYA/gxKa/fBKO2Y65D+SIVWmugxBC+E1ffvfUHVsZsj7YNj4pgh6ZRqjGWtQHyxBSDtnwZNZuxwRnosnMrevnrTo4BXYBIaTqJ+ntiAR4ZC0bspeYL0+/1Y/MTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKQeIbw+oZ1unfS+DimFSNMeVNcHqzhkZRuUmTi/HfM=;
 b=auD0XjyONGofECoVAQnh8jfYxlIE0mE6/GzYkRbmFHS3+b2oSKA9FBCs1tPC8MLQLOm4L6LezCTSwrblQ3impahdHZwHr9HnjhLf9A5wYdXrMScddcl3hKNPf6u2n25+20Swu0ijxioPzOIB2Ri2gpH9gzB2ugiQiLFgbEalDOIq/HYf6DC7gGEdoRXROfJteZp/3TDiHdh7BmuHPLxlJH2SybTi6UBKM98f7V+zOajbxQlWuRwOrF3RiHe/K281KSt4/s7cdJHij9eZOyhNjOmdsbqXSLBly7h67xOZ7Bpur8icLdQUewtVqi0Z6tW9OFwc8q85Nm7VU5+8phazzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKQeIbw+oZ1unfS+DimFSNMeVNcHqzhkZRuUmTi/HfM=;
 b=FQtW3Crn3GjUsc7zYHXwY4GOQqXs61ZEC0KQsIkGN1Zg9F8flkdJowdrIlAQ8yK1udtdtbUonSu6xGuMExgW5b2dLYMJRQMzvwQHE64uKKvBtm7ALqYFJA+0KlGvrZVoHnV3JH575eo9eUlYBWFM89KjcgbS/cQwJNy/Ert2RQOj0d/FKltz52YYnne0tI8RxDxcgTkbbuSley36hSZ/rPzoeZeQl+lIy78HHrnj7OOLsDUfCuk7dBDnORhA5xW+ZNIrRxb0+JoHbe8H+MXT8oZTIiaPHpRrLyJQUzSUq5/VNzOEA5M/zp8i2TMq/nJYqBNRz0ExEDYsU+wcgrovVw==
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by SA5PPF590085732.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:36:08 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::91) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 20:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:49 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:42 -0700
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
Subject: [PATCH 07/20] vfio/pci: Add CXL state to vfio_pci_core_device
Date: Thu, 12 Mar 2026 02:04:27 +0530
Message-ID: <20260311203440.752648-8-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f2a5cd-2268-419e-28e2-08de7fadd31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xg6wkPVu6kYaz6Bt2TGhCZtW4U+lPaXQMBn29WwJ6/OtNnrOSgC2rSbkjVDrIYrIHE48v6JRulv1dwAG89aX61Bwaim8WLwMY7m0bPooIT6Z8LkcOhdv6V/9Zjzq1vu4Pe7S4FOeBpcfFY2rO2I8SDaYSfZb782pEXfpEhgoz/GS7owlxTSJQxEs6Zcx/YMGBip/SwyYkRk23hRicatO+2IVutP5joQqwj1rTPHYnZuOTkdYf8+2zAPuEjG4AlU97PJfuQSPoTeEiGLgPIM2KQ1oAkeJuLwpiPVnD8mqIjTXLXh9dGroVqrlABhZuSBdUVlSHzNAq9uuy1uo4v3R+BcH4CgmQC3He/yEJLoj8vnAejprjZuqQ5AeVP6dzjJRRwNdefkLIIUnkTiHEbj7h9OQt2MJwmrUFR0kbyXp5LvFnrEGfW4mQ34yaQ9fAVuagznpIg6QbCs2fAYQ2pHj+/wuggaMEbs0Z2Qc/i2L0Fe35XxBKs/50EncxbPhNu7KwLyM5OkYGj34FtdWa87fKD8ZdC9FcL7MpVUg4kwd9OhoKRIR8akivHfdL08j1l0z7r/KHIqXFro3feM2ScuLYeoaPBTD+yiDI92QK3Aqvah3jw/sJ56K1NSS6FmQ8/05hrpJLyKfK6Uzn7qSNrODcy+fWwOUI8DpHzfw6d/tCEUKnaK2Zhb55H5p16eAiTvRJiVsm0WiQcigwbiUXZDjW0cAiy4amxK/6deonMqlMDNQbTdNU4h/OFxmjA0AxnIsLDkeKL2kwj959YnG3o+8dAQphEg5oaFMJfawPTLSNKx0kWV9SbGcembJzzMH2fHu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oo7Wi4FlQYQeJAsSCRHqs9liv2uD4GEolmttz1H/L2Vwd5BKKLco4ZgrgBq+O2KMqUj3FZPt2YHyFy2X4F7SR1BxyxmxHXPSfHz7X0cUuCynbHi7A3axjoiy2cYJ22O11CFRjzpF0qnAzZUzCvlUJMcs0vf7K73/tUrKDH+p1EaA+0Kg0GqjhC+tQ7VHe0Bo5smiGlsQFRKTWcoumVYEBrZ8gOh/0OZAh28fedgu/iDuLhLzz3ZobzbIdWgOzBuXD0qUEeTdAQwOXXwK7Vn5Q7uLJqc/lDDDsQfhDi3g0WwOKuwVuUuovSq+Onq+vq1n3MnZ/e1LqtJq2A0FjevjTt+/a1RbRK+9uRxomXltczx7O7m75RPxteTsQFmuTeSUfEnAkHvqo6SL9A7Db95PvswZAM2E2q/t4Micyz8uIA/JTx5g79zvUXblz9v21DBV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:07.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f2a5cd-2268-419e-28e2-08de7fadd31f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732

From: Manish Honap <mhonap@nvidia.com>

Add CXL-specific state to vfio_pci_core_device structure to support
CXL Type-2 device passthrough.

The new vfio_pci_cxl_state structure embeds CXL core objects:
- struct cxl_dev_state: CXL device state (from CXL core)
- struct cxl_memdev: CXL memory device
- struct cxl_region: CXL region object
- Root and endpoint decoders

Key design point: The CXL state pointer is NULL for non-CXL devices,
allowing vfio-pci-core to handle both CXL and standard PCI devices
with minimal overhead.

This will follow the approach where vfio-pci-core itself gains CXL
awareness, rather than requiring a separate variant driver.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_priv.h | 29 ++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h        |  3 +++
 2 files changed, 32 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
new file mode 100644
index 000000000000..818a83a3809d
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common infrastructure for CXL Type-2 device variant drivers
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef __LINUX_VFIO_CXL_PRIV_H
+#define __LINUX_VFIO_CXL_PRIV_H
+
+#include <cxl/cxl.h>
+#include <linux/types.h>
+
+/* CXL device state embedded in vfio_pci_core_device */
+struct vfio_pci_cxl_state {
+	struct cxl_dev_state         cxlds;
+	struct cxl_memdev           *cxlmd;
+	struct cxl_root_decoder     *cxlrd;
+	struct cxl_endpoint_decoder *cxled;
+	resource_size_t              hdm_reg_offset;
+	size_t                       hdm_reg_size;
+	resource_size_t              comp_reg_offset;
+	size_t                       comp_reg_size;
+	u32                          hdm_count;
+	u16                          dvsec;
+	u8                           comp_reg_bar;
+};
+
+#endif /* __LINUX_VFIO_CXL_PRIV_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1ac86896875c..cd8ed98a82a3 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -30,6 +30,8 @@ struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_phys_vec;
 struct dma_buf_attachment;
+struct vfio_pci_cxl_state;
+
 
 struct vfio_pci_eventfd {
 	struct eventfd_ctx	*ctx;
@@ -138,6 +140,7 @@ struct vfio_pci_core_device {
 	struct mutex		ioeventfds_lock;
 	struct list_head	ioeventfds_list;
 	struct vfio_pci_vf_token	*vf_token;
+	struct vfio_pci_cxl_state *cxl;
 	struct list_head		sriov_pfs_item;
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
-- 
2.25.1

