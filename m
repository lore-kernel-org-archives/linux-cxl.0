Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E7477E4C;
	Wed,  1 Apr 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054454; cv=fail; b=ngHeeVPaEh6ELLQ8fk51xKq+5SPPr5C7B0u2CYcbfxqHqhYIQMI6TOPd/8oJ8wshIf7Z61fJQrJz0XmGY8aldVCxQFKfY2nJHzuGF9/7GH5BipFeUdSgw/RY+T6lCy3p+D2eltoKo0a23dY00wIlNcshTeEgUMkoJOWZQVwEEdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054454; c=relaxed/simple;
	bh=W3rZoJ2lO33AOu+TLx+oZZ0eHeMZHeal4GGgxmfKgzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXkI5w8Fzq63tAd3nJ3kpAjMD2pTXbTUP7//WOE0dQ1DE2vVz2niYIX6RT1HHS9eS4xbkgPOvE/3qDmpe8kaTwlTrBNUb1vvq998D1k3qtFV6XhlC4poRMnb0LLjdqAOAnrPiFAuaIs1BNTAEcoxdB+jMHe7In1cuU/I9cQ6Sbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RYU0H1q7; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RYU0H1q7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur4Yv1eqeKQ89p80uoBMFlAx296SnIJ1odlTr5++daJUWShuu0bIZzf0z5ixGX6anD/QsVq9DtZ7//t0Wehzuo4UbQ71stDHqRznJM3bK8d5iuVONkKA9Vhe1Ctr0WpfzdvNfZh3ZR8X0Vt2G6rL1SnU9SZG57pCG/bqSNt0KXEFEyYtKOZMCO3Pp/pLZIwXX4QRXD2Iq+fzCNbLb+hSmU3crEddB9tp/dvPrM+p9a9Jie+FoZPgOpgrmMj4mrkhAVYVY3ipju5/XOh7hjQ+T3Aq+J25aKuaKfwGybsj4GOzNlEvlD3DFUkfxypmCJyBuMQ5sKIe4I/J6Si8tTSDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX30mfDVP2wg77ld2bMhtIHAbS8WBvFoMXWUF+gz8yc=;
 b=fuOP0buI93DqVTb1IBvpKlvav+P8Xw6P+PUZZRcHRKUoZYRg2e6hxKtsO/Hov/zuPh+njFpGofnlaKnkexX+lA66ru3FOhlbw4W/uJZ4pVhHLAxr7szio7iGO0hUX65YfXXoaxcDHtaWuMlXTM979uqaq5eBxb+h9MdtJ55L65OoJ8Yd/gwjN1j5vZUTqhpHfeP+Pvch+yw80O9N0MqzOHjz0dbkulQr3Y+C3Qmb4wKMYuniySEzOiYCwMekhYqlWxVGVUvCbsFVrOsVioWMO6YcXeFolFJs3p/NP/E2C0dOugNdLasCS5Tq9o6vtogOUfBTRgPicLsxI+RD5te1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX30mfDVP2wg77ld2bMhtIHAbS8WBvFoMXWUF+gz8yc=;
 b=RYU0H1q7nIhkDAw27r+8ias7ObOKZsGMyA+dAKfu+sZc497md4XdCzyYM+L1hEZHq/05SpHYokaXUhBB1eGORJFBgd+O8BlJYO56V+YjWbVAk9EC99jrVT/2S70UVV8SGkHpntPr35YgIWRd3VsNQK5W0O4y/9xnqBkPLbvBMjA6r+lVvPIUAiy503OUiwViDSlZu5yIAEGWFut8HPsHL4/FuhiHRVO9WP3kZZHQaEDFXPodaKncWz/L2kuP22wcitnO869F3a0QmgI2/ZgR6ShOhyExcLw1rEoWqeaDQ2PrUIXlc0ta5M51IjIpQqsh/3iQYjGL7CCW5ethECGNzg==
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 14:40:47 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::2) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:24 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:16 -0700
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
Subject: [PATCH v2 06/20] vfio: UAPI for CXL-capable PCI device assignment
Date: Wed, 1 Apr 2026 20:09:03 +0530
Message-ID: <20260401143917.108413-7-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0384da76-964b-466f-0cb0-08de8ffca94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/VV+N+rqYVZ/NRs0JWnLZmOWesaZiiktx0v7kRSttWVw8QB3qk82x3NHEt4DRN2c/aWW5KAkgEDf7H8cMaVEA4RkDf0qBq1tSUM95a+/zpfePuWHqUPp+5qfE7JMSMxc1uXmeG5qs4Te/UvEIgnf8UzeUTyqZoh8DF+MuN8ad7pE++UwAMIiUx4ANeA9dfhNG5gB9OKFUGeecKC2cgJXbBPompbdVqdpRxQe/3lLUv3mGR/uHFTdqSTq/Bh6b/EiM3t2Vei8m/v5SYOLS2m8GMVwU6qXvK+FnyeSplFH2TU4nlx5We1APAGPDDGQPUJkNGD3QZg6q7FhAKduGcboXfdfVsDa2CBwXz9klSEWJ3Aglb5zuHrTCDl0LIyywRFuP7Ae+tubB3R41JtxLHE/KkHUG9rri/kzrD55ci/+lgif6tyjkD2QF81Bq5nwTDWcjKCaeiXsTIdJidor4sau3ZRHZ7C/bweD/d5JcdGOSXXG8Mnr+AOd2GBv1TFBXws6S2c7prjfUBKQUneJsF7OxjglnsQKqosHp7Q/0NL+Sck4Y6b5ddpxD97J4BQuUkyd7gQUihZFLDQDmGyRLaLTKPXrO+KAw9cc0cQOBXxq1wJs23Lq48y8POt8X8iD7cqAxGqC+vNu5TbNXoPIYiXK6oOZAUP2g5MzeFn39DpnaE3B+4x9ZAhfqHvo1j5e54ORKjgg86FNVJUeBy4Z7bygoL2ewf0wEXwu/Gy9z4GV02lIAtXx5ujoZu3b4e2pFRE80Uh1HI0acWIeVmJHk5mr1jrQtGKlzPrEkihXgp8C2mqopFs1g/nvYVJM8H2NLE4q
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZpOkaJoySpgvbNutHpVEORaoh/iZ0xJDYMdTQcZGartwzTLQWgahmsYmCyhVNK1k76OspZ6g2BJ1M/8S//8hTAQKWXLilns4oP1306JZzSGpKIYLWPZ+X0vhBJWjVxUmX8zFJmRYhQ/5P0vGg+YJq20LB3EOlZICHoxcH6jFa/EFiqIpb5WFiV70eugCQYo+XM2ktllHCWGJ6t0cHszbE8tiM+8hDOnFn2+EfmzQtlu2we9zRk9XX1Yrl3GeGQjvDAwkDMTMkgihJBPLJ27JAHl9jdIjgzoyGYChqRxnOgVVPGmaHaE14y0p49kftqwtBmVCfd7j5lssIQc8wpH29ZipDUmf8lRC8uyj/5Z7edjgJ012rXG+xsi2NoxB+KALuC8GR8wtDak8rSCmyf1vk77J6s/TE+3M7Ex0fV6/XdW4frvW2RWudDdXqZIm9Q88
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:46.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0384da76-964b-466f-0cb0-08de8ffca94c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

From: Manish Honap <mhonap@nvidia.com>

Vendor GPUs and accelerators can expose CXL.mem (HDM-D or HDM-DB)
without using PCI class code 0x0502. VMMs need a stable way to learn
DPA sizing, firmware commit state, and where the extra VFIO regions live.

Add VFIO_DEVICE_FLAGS_CXL (bit 9) and VFIO_DEVICE_INFO_CAP_CXL (cap ID 6).
The capability struct carries:

  hdm_regs_bar_index       PCI BAR containing the component register block
  hdm_regs_offset          byte offset within that BAR to the CXL.mem area
                           (comp_reg_offset + CXL_CM_OFFSET)
  dpa_region_index         VFIO region index for the DPA window
  comp_regs_region_index   VFIO region index for the emulated COMP_REGS

HDM decoder count and the HDM block offset within COMP_REGS are
intentionally absent; both are derivable from the CXL Capability Array at
COMP_REGS offset 0. Locate cap ID 0x5 (HDM) and read bits[31:20] of its
entry for the byte offset. Then read bits[3:0] of the HDM Decoder Capability
register for the count: count = (field == 0) ? 1 : field * 2.

Two flags accompany the capability:

  VFIO_CXL_CAP_FIRMWARE_COMMITTED
    A decoder covering @dpa_size bytes was programmed and committed by
    platform firmware before device open. The VMM can use the DPA region
    immediately without re-committing.

  VFIO_CXL_CAP_CACHE_CAPABLE
    The device is HDM-DB (CXL.mem + CXL.cache). HDM-DB requires a
    Write-Back Invalidation sequence before FLR to flush dirty cache
    lines; HDM-D (CXL.mem only) does not. QEMU uses this flag to
    schedule WBI and to report Back-Invalidation capability accurately
    in the virtual CXL topology. Mirrors the Cache_Capable bit from
    the CXL DVSEC Capability register.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 include/uapi/linux/vfio.h | 86 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ac2329f24141..fc07fc50b2e5 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,16 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+/*
+ * Vendor-specific CXL device with CXL.mem capability (HDM-D or HDM-DB
+ * decoder, PCI class code != PCI_CLASS_MEMORY_CXL).  Covers CXL Type-2
+ * accelerators and non-class-code Type-3 variants.  When set,
+ * VFIO_DEVICE_FLAGS_PCI is also set (same device is a PCI device). The
+ * capability chain (VFIO_DEVICE_FLAGS_CAPS) contains VFIO_DEVICE_INFO_CAP_CXL
+ * describing HDM decoders, region indices, decoder layout, and CXL-specific
+ * options.
+ */
+#define VFIO_DEVICE_FLAGS_CXL   (1 << 9)        /* Device supports CXL */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -257,6 +267,70 @@ struct vfio_device_info_cap_pci_atomic_comp {
 	__u32 reserved;
 };
 
+/*
+ * VFIO_DEVICE_INFO_CAP_CXL - CXL Type-2 device capability
+ *
+ * Present in the device info capability chain when VFIO_DEVICE_FLAGS_CXL
+ * is set. Describes Host Managed Device Memory (HDM) layout and CXL
+ * memory options so that userspace (e.g. QEMU) can expose the CXL region
+ * and component registers correctly to the guest.
+ *
+ * The HDM decoder count and HDM decoder block offset within the COMP_REGS
+ * region are derivable from the COMP_REGS region itself.
+ *
+ * To find the HDM decoder block offset (hdm_decoder_offset), traverse the CXL
+ * Capability Array starting at COMP_REGS region offset 0:
+ *   - Dword 0 bits[31:24] (CXL_CM_CAP_HDR_ARRAY_SIZE_MASK): number of
+ *     capability entries.
+ *   - Each subsequent dword at offset (cap * 4): bits[15:0] = cap ID
+ *     (CXL_CM_CAP_HDR_ID_MASK), bits[31:20] = byte offset from COMP_REGS
+ *     start to that capability's register block (CXL_CM_CAP_PTR_MASK).
+ *   - Locate the entry with cap ID == CXL_CM_CAP_CAP_ID_HDM (0x5); the
+ *     extracted bits[31:20] value is directly the byte offset
+ *     hdm_decoder_offset (no further scaling required).
+ *
+ * To find the HDM decoder count, pread the HDM Decoder Capability register
+ * at hdm_decoder_offset + CXL_HDM_DECODER_CAP_OFFSET within the
+ * COMP_REGS region; bits[3:0] (CXL_HDM_DECODER_COUNT_MASK) encode the count
+ * using the formula: count = (field == 0) ? 1 : field * 2.
+ */
+#define VFIO_DEVICE_INFO_CAP_CXL		6
+struct vfio_device_info_cap_cxl {
+	struct vfio_info_cap_header header;
+	__u8  hdm_regs_bar_index; /* PCI BAR containing HDM registers */
+	__u8  reserved[3];
+	__u32 flags;
+/* Decoder was committed by host firmware/BIOS */
+#define VFIO_CXL_CAP_FIRMWARE_COMMITTED		(1 << 0)
+/*
+ * Device implements an HDM-DB decoder (CXL.cache + CXL.mem).  Reflects
+ * the Cache_Capable bit (bit 0) in the CXL DVSEC Capability register.
+ *
+ * When clear: HDM-D decoder (CXL.mem only, no CXL.cache).  FLR does not
+ * require a Write-Back Invalidation (WBI) sequence; the device holds no
+ * coherent copies of host memory.
+ *
+ * When set: HDM-DB decoder (CXL 3.0+).  The kernel driver does not
+ * perform Write-Back Invalidation (WBI) automatically.  The VMM must
+ * issue a WBI sequence before asserting FLR to flush dirty device cache
+ * lines and prevent coherency violations, and should advertise
+ * Back-Invalidation support in the virtual CXL topology.
+ */
+#define	VFIO_CXL_CAP_CACHE_CAPABLE		(1 << 1)
+	/*
+	 * Byte offset within the BAR to the CXL.mem register area start
+	 * (= comp_reg_offset + CXL_CM_OFFSET).	 This is where the CXL
+	 * Capability Array Header lives.
+	 */
+	__u64 hdm_regs_offset;
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
@@ -370,6 +444,18 @@ struct vfio_region_info_cap_type {
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

