Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D92355F43;
	Wed, 11 Mar 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261369; cv=fail; b=j0q8nreLroHRQOC7KqilTsFyW6Bw53yEXMsgmN6t2aCdCnXIwESmHL9WPOgtobdiG3jWKQIsblInBWyAtQYsJ2xMFkOJfMgJi4xFqG6fF3jphSgpR+eqdlPlniRAM51yRLwETBz0UCpD9+4n9cxOw5qxgodyUqySrilPCGTPX5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261369; c=relaxed/simple;
	bh=ctBDLWfOWm2RcIL8GaTlfROzgFHPnzaKMVs6bmLZlME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAyKWNPbrKTENdUEo+6JHBgtOnGW87pF2faM0krZlu+FIPJWkFwJBA0dOz2xFSy0xVyQfqHmn4L+J9QOnvGbnxbb/re20UcYoNeYtrIcv7DxCCrVED8ltjRv5WrsVG52XZCgK6iniQ5+skNrq3WXy6OEfLY9Ys1Ujtdpy2k9v4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ET2fUr/k; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ET2fUr/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dotYrIyDhgaWhwlsFLv1VV5XOxYVJ7yErl8vml18VuyXAGlL2pbRUu6fLEzcC161IRH8DQDcC4zAOiPvqrUnnZ98Vemn33EqGjfLRaQezjJDbHs8XpivsmTATEPTelx8qNuIQ7uAwaPwfQ8FZBC4RSqiNAg39wdgShs0rVei2Bf1zBX7RGmdIW/9Arfy8fjYiNjXnMTaLGjXgDhzUZGDi4Y67bZ+WaWkK7D+eUb/dNqTaoUv9a29E9dgboaEihMoQx0swZtvxLDM3s4iNrrFpqybahrHlnCZahQwYfYgil1ofWIxkGvFAv4mRaTR3nZw8zBipnrVLnYV2I1LspstEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydQysJ2Zj+jEf6kK9NnkteLIFMK2ZfeAWy7xZP4bOYg=;
 b=K9eavVSY7J45ny8N+7RY1+jGCFDlkPYrTRDlq6ey/8l8fKIHClCIGqe0Cv6GjuL+2BCXaii7qRxapj8Byu+AaXuZ896x/9dMP3wHRxrZW27swPoT8VTPIZF0b3h3S3gAsm0NUYbhBpL6ATBqKvC0sGAJQyru1zGNpypk0V7uCumZ4IjfNtEubqhim6iVDtMbpnDgR0WDp4cuZajFE3YJnYVMsMMJqDdA8KQTTW3ESbT/ilWUCVWN/WlNPJAAXJPFLMYuN35lJWMLJkVTWvIQZSBIu+TSAAMzh9uVqFqm2ePXXfaFEnZSzIENp++J5vD819+hG++pBYtIQxBzUc7Mvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydQysJ2Zj+jEf6kK9NnkteLIFMK2ZfeAWy7xZP4bOYg=;
 b=ET2fUr/kywv/QSFjNJwrwjVKS9t+OX1BeJJfzhUDI0xoyOcOaPc/PdcWhBTVnoeVTtmfjC/dlHqvLHm0hNgTmKobpSaQ91XNP/Er4aqQ3ZSO4SYs8DrvR+Uny9g0xqwp/JaG7ZUOLzxP9KzGI5unP/m5pxS64Fp4NJ8EZyxu3I/cPQGPVnn2gVviEB7I20sidp+nG2+ulXFQw9FLShhPG+rO4Tt8PUnVolET0EYOUSY9IwhyooYi50ZBHqBQCjuWEI7Ds8rDIqKwlk9LoSOitM14vRQxX9sSVbxaoy+nuK+r8f+i/80O+hrIeN373gyshBsJ8XZUVklafb17jCFgSg==
Received: from SA9PR13CA0118.namprd13.prod.outlook.com (2603:10b6:806:24::33)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:36:03 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::55) by SA9PR13CA0118.outlook.office365.com
 (2603:10b6:806:24::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Wed,
 11 Mar 2026 20:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:42 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:35 -0700
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
Subject: [PATCH 06/20] vfio/cxl: Add UAPI for CXL Type-2 device passthrough
Date: Thu, 12 Mar 2026 02:04:26 +0530
Message-ID: <20260311203440.752648-7-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: dbad2e26-93ad-4868-e88a-08de7fadd04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cDgW3Ym7c6uuNOQL8Ul/wsrWWGJmT3EcPeIfaUYSCqkNKmgCWwTiJyDR+XLnBoA1Y5A1flUurqq74y/sUTG/AymOp0Z8bTh8ksbAM1LaaCW6X/c1KLtJtoCW6QWoSOd46BwnIUMMpRKuDcGtHzf0VmUClBhtqwYe7PpPT5jqh7jRFdVc8eX9H3ECABzOo7YYcKBaAQ2p8Wa6l6LSeGBGyRKJkkSPEbKvAsSiIT97humICfnGX5A5bugUvpMpd3IAVvDiS6Bd1T8KyT5ORdg3+kzzldvRA+ZfpUIn1ltW5knGrAwS7vu7NYTAtCB4gIQwwwrT6hiN98l+RCWkcu/5LNSjAv3eeYgjJznKFGnbGhfO7t3pVGO+Z3VfrW0v59JLRljZehGuNZ573++dpWf4lNFILncLQT6TURwA7XRb6H6RWQm/myVbWT/9IgQ8pevWGTa7KINPHo/P2Hov/tMDHBJGEqdmrX1o4zmIQknx6Nv5TEYzGdU8orCBzFKozzpA1lEkBOwZHltX9eNSvjaHTClQihmWqyXNoy3Yq12h2gKQgBLkD5PvM6zRnRKBhgGMzO8W3+n14XZ+xWV1xWP7lkHPOv9wtMJQQTyGijxCvUdAyCF6gCI82+9/tU5nb9db+vHunrV3lZmm96kykK4V1cX9q2LBotVIlFn3JwrsXEBb2+VlSJI7L4noMqDWK9/ZhzR8nnQJSc4D62oDMF429VgP7kYnqA8SIs2ZsKUseMuIF7kXGYk28YRJEppR6dnlr5Q0DyEB7QPF5N+MgUdkNkazpTo65wb+LtBlKKSzTCzZLONv33l9jJj4fD2ZJAR8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H7XC88JtCFj6GQoFtpjm9BQfQrE8UCHPwPybe26QrrrU6W++EbpfyByVc6EpjVhfRVrHnZGdbf0jsXa53NNGwe5XbJKv+aoHeg36nxNYdyxUVJHOTtPfWd1y4t+qbcdEgLb5ufJ3wIaBQN1vOEct3C6bpB/6FB0gpQlztLjNOTftmMAup+aJGgHLZxG8/xTz+RXYsiH+lssdhXOIceSzjN+txit+uH3fuR7YRFH/echzaE1K2868sRMD1nALxy4oaYruKkxH5aA15Num1duMQkVc91JlvI0EmGMzn/HHq6NvzJ11Ftie7PWeiLmUJ8YDGTZk1E3LoHiJBWKEd4jb154hDqcV522HOzyio6ng3ADlSbWjaJsmxbQdmLmxQtFLwFLKmXM+NTvurc4quhAZMmnHvn1Grvj0IgogRpbfTz0uQEjKFVNS6jXLQ5ka0/3B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:03.2415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbad2e26-93ad-4868-e88a-08de7fadd04b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

From: Manish Honap <mhonap@nvidia.com>

CXL capabilities include:
- hdm_count: Number of HDM decoders available
- capacity: Total device memory (DPA)
- flags: COMMITTED, PRECOMMITTED

This UAPI enables VMMs like QEMU to passthrough CXL Type-2 devices
(GPUs, accelerators) with coherent memory to VMs.

Also added user-kernel API definitions for CXL Type-2 device passthrough.
Document how VFIO_DEVICE_FLAGS_CXL relates to VFIO_DEVICE_FLAGS_PCI
and VFIO_DEVICE_FLAGS_CAPS, and add field and flag descriptions
for the CXL capability.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 include/uapi/linux/vfio.h | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ac2329f24141..7ec0f96cc2d9 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,13 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+/*
+ * CXL Type-2 device (memory coherent; e.g. GPU, accelerator). When set,
+ * VFIO_DEVICE_FLAGS_PCI is also set (same device is a PCI device). The
+ * capability chain (VFIO_DEVICE_FLAGS_CAPS) contains VFIO_DEVICE_INFO_CAP_CXL
+ * describing HDM decoders, DPA size, and CXL-specific options.
+ */
+#define VFIO_DEVICE_FLAGS_CXL   (1 << 9)        /* Device supports CXL */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -257,6 +264,39 @@ struct vfio_device_info_cap_pci_atomic_comp {
 	__u32 reserved;
 };
 
+/*
+ * VFIO_DEVICE_INFO_CAP_CXL - CXL Type-2 device capability
+ *
+ * Present in the device info capability chain when VFIO_DEVICE_FLAGS_CXL
+ * is set. Describes Host Managed Device Memory (HDM) layout and CXL
+ * memory options so that userspace (e.g. QEMU) can expose the CXL region
+ * and component registers correctly to the guest.
+ */
+#define VFIO_DEVICE_INFO_CAP_CXL		6
+struct vfio_device_info_cap_cxl {
+	struct vfio_info_cap_header header;
+	__u8  hdm_count; /* Number of HDM decoders */
+	__u8  hdm_regs_bar_index; /* PCI BAR containing HDM registers */
+	__u16 pad;
+	__u32 flags;
+/* Decoder was committed by host firmware/BIOS */
+#define VFIO_CXL_CAP_COMMITTED		(1 << 0)
+/*
+ * Memory was pre-committed (firmware-programmed); VMM need not allocate
+ * from CXL pool
+ */
+#define VFIO_CXL_CAP_PRECOMMITTED	(1 << 1)
+	__u64 hdm_regs_size; /* Size in bytes of HDM register block */
+	__u64 hdm_regs_offset; /* Byte offset within the BAR to the HDM decoder block */
+	__u64 dpa_size; /* Device Physical Address (DPA) size in bytes */
+	/*
+	 * Region indices for the two CXL VFIO device regions.
+	 * Avoids forcing userspace to scan all regions by type/subtype.
+	 */
+	__u32  dpa_region_index;       /* VFIO_REGION_SUBTYPE_CXL */
+	__u32  comp_regs_region_index; /* VFIO_REGION_SUBTYPE_CXL_COMP_REGS */
+};
+
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
  *				       struct vfio_region_info)
@@ -370,6 +410,18 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+/* 1e98 vendor PCI sub-types (CXL Consortium) */
+/*
+ * CXL memory region. Use with region type
+ * (PCI_VENDOR_ID_CXL | VFIO_REGION_TYPE_PCI_VENDOR_TYPE).
+ * DPA memory region (fault+zap mmap)
+ */
+#define VFIO_REGION_SUBTYPE_CXL                 (1)
+/*
+ * HDM decoder register emulation region (read/write only, no mmap).
+ */
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS       (2)
+
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
-- 
2.25.1

