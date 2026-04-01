Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58737472785;
	Wed,  1 Apr 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054557; cv=fail; b=fl2/4dD/dOICXIDkU+5nNgT9darT5QAGq5OTTgVgsdGPJ11eiy/k7eLomd92vuB/jxLINs/TfgsJOfLN9AP4sPHbcpsUXGEEhTk6aV2G3KknGJHKCnKCJAGXaXYdHjM/yr0xBKcCiplWrhJiPiRR1OZwA6kJBTL87aiMjEDYMvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054557; c=relaxed/simple;
	bh=uJtgQVJj3Cc78GJXwVAJXEIliRoMsoXqNyUEWm5VIwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP9Bi8naheOAU78Ei5IFFS8IXvyelJHa71nJSauQHThx/1J3/C0p5PUjo791HCgm7WAxbiRC+4eBK7VWhmq16qsQ5PyJfydSYmD5nHaD4nbCZdc8M5l8AiwVWwLn1STnbwgXMucvLNKNMyPQjhJEly2be3yMvotIU18HX+6GCf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sDB9MVLg; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sDB9MVLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0+uUKd6JbOs50VWJWsgMUCK7SCDrMhmeJLjBaZVQXgksOccXVugpqzyOc1NYwDJ2LFv77A8vurECV3rVBSHIFccnGuSlZFp20pfSmGJl5Jpqy6LY0qK3JmkWZo+gyiFM54EdcDIso0XHQF5yzTNCqB07gZ7TpGIBtEp6z1bRgi+eokCWP5+B/X/EgUoA8PwMWH6av4sGRV3+UCOeh+u5L7c5fGV8iay+gqrJdbau+l/kKgWREZN22qZSClsKIym//cM5SV+28YHBNYMSwsx6wzs9TUUG2lDDNDzLAzwbcfrGAhtHTHsn2NVNGXMDATsCtmzEc0Lw+xG8lHUAc/WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCZsi08z0F3p6R+7rSsyV4muAmrPPdPCPHq9S/ZJcMo=;
 b=UjU9/tqA55GGFzDVNhmiH1tuJAE3CSJO+7xlG+ubWafzokYEbuxzNeh7OaQsMZA6sqR81CRNKbpA3AH4m4udoz3mof32EmKgb/3GtDKKx4aZhFoJDjeZsPAtXGFBalJGYIeut3kUUhlNBlutc/NcfMap0RGKdhtO/2yc5/PF2admhR7Htv14YTZ+yCS6b6ei5HtnOldqKOfNq3XdbIMtOwzUqWUyEdGJTW+AZkLCGaQBnxrKBwnQ/lh19GEvn7InBA3wjrdZZqMVUZkG+tLWDNRj2rdF52HUV90Q75VQedfxV6Zbyi84ofYW5SvHf63pqFPVJYS1l5p9cpZan16YDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCZsi08z0F3p6R+7rSsyV4muAmrPPdPCPHq9S/ZJcMo=;
 b=sDB9MVLgVEj9RCgoRUgJMSJRyfYjlsHK0GW++IOmwebWcK/cns80ty5BL3JbWPNvigbvVmKol2mqwSBr95UGxzxt2/e7O5HxOmWgVbXey+eVyGJWub+2j9chxguar9w3SynZvxFWoHq/wouv7ocKCd14SeuF2DzglIU9xQQOk1O1vfaSwtaltCsxFXCvPE4E+9G2pvDKxbHmiJJhCljdT+PAFGhHCViHNUTx8snrxbuUG5B6guAhsPSbh2JEvkMONXQrTT6x8gttYk//NBzcIyz3DFBkHeQz2SWIZbAtXcI04j6g7N3XvVDyoqRraKv4g3Gh3CBRA3cFnJqFKQO2/A==
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:42:22 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::19) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:42:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:59 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:51 -0700
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
Subject: [PATCH v2 19/20] docs: vfio-pci: Document CXL Type-2 device passthrough
Date: Wed, 1 Apr 2026 20:09:16 +0530
Message-ID: <20260401143917.108413-20-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8dd821-a9ad-4668-7aec-08de8ffce21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4IW30JanQsu+9dyVSYchqm01qkYMHUb1Tj2DUNZ8Jeb3vwUGzRWoU6eL1rCSO/+0Tc//ejl0fqB0oB2S+uqXGMv9WnGZfO+K6S35dEKb4NNpUsE359mbswtINqM5g+WQiIVWzulCx8FeTiD3iDCrN3dVw9g7RFPfi0NHSLIHCTJddfwSUnXkRHvVLRJG/e74mFFn4SVhyBKe+qj+LSvwx4HyuiUimz/TZyKevWXjzCAmsxxiLUMK18Zt/aeLMFBFNFfHYuvh2DzXXgy+LWtxU1rcWGQR6bWEz3+MdNcsuScWF8ktr6yLun8YTwlV2cKR5MB9KUvelsdtBakRFbsXboe2hjh4j1vvrjG42tZjAgOImqQEJ913gn8dE2KQ/blCk+gyVdV12IACmP/NdpaFmC6llr41yPzQpT/SnM8/ofvqABFsyMjcB/ui5cC2TP7q58ilzckb34bJaPXj6wh9fpQfkJgO+Sys6mDscKtnQhwZIiSKEjPG5FIW2AVdnpYFMOlyhGPsPFyAz+xITV0GgZQC2H1+3b67jQhsOPG9mgndv8P+hFZ8nQxNwxbK782qHEihNuwq7BZwI+alNb+yntt67T8+qaCoaSBsjsHP3VRdrC1o4BZkC6ADhvwr7D4h4GL2f2MEWriAtAAt7HqZDNdFkXpoaR3E0WGTTFSB+R8ZnTOM2y1MTiehFjcITH0EvP2I8EIC2mCMEz1eHJ5FYcOiz+f9njtSWJXY5ZA9Mu1O5LC7MkXK7YOgaBVdndKncIxEQERcmW804Gg/uAkSvC9SSe/4ROsEzxU6ACEwpTo2WVqr8ASASvqUnfW6I2Jn
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wYk/A6RPYXCMUbFZUY8Ktuo+AgYdEwcWt1y830daRmU39TczkjVblOMifL1QVZp7qNT48wMaSTtDU4H9hDC5UV6br+Wyo45AXlbYzRhHVZBFble/S2wWsDGt7yWk4kbNhtm7kNbaFTAgziCM/430Vyxp8YSrQmUJqfFKz5AxIyHLRWDxmqckGtxtYf22fuSy8Lu49QWnjJUmu/erC9m1NbpBqFrDI7zuAb7r86vMBWlUanX9Dg3ArvgFYJZ4019vcht+jCXdl7LEKNXs+SWoyBWf9YCJ72n4RfNaZMQWxKqyFX0NgT3PMf5wQWI6JpUQ+GcoX9udIVb5E+0XnFwZK3kc9MQIwYRTeGmEztz43MKm4miClOTeXoTWWppbqLAVVsKV0SAZIjXeNMSBRPjBh8EiBO7SGNAYOs5KVpPt1HYmPy5EDLL+JP3dj1S3S+6w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:42:21.9209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8dd821-a9ad-4668-7aec-08de8ffce21a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

From: Manish Honap <mhonap@nvidia.com>

Add Documentation/driver-api/vfio-pci-cxl.rst describing the architecture,
VFIO interfaces, and operational constraints for CXL Type-2 (cache-coherent
accelerator) passthrough via vfio-pci-core, and link it from the driver-api
index.

The document covers:
- VFIO_DEVICE_FLAGS_CXL and VFIO_DEVICE_INFO_CAP_CXL: what the capability
  struct contains and what the FIRMWARE_COMMITTED and CACHE_CAPABLE flags mean
- How to derive hdm_decoder_offset and hdm_count from the COMP_REGS region
  by traversing the CXL Capability Array to find cap ID 0x5 and reading the
  HDM Decoder Capability register
- Topology-aware sparse mmap on the component BAR (topologies A, B, C
  covering comp block at end, start, or middle of the BAR)
- Two extra VFIO device regions: COMP_REGS for the emulated HDM register
  state and the DPA memory window
- DVSEC config write virtualization: what the guest sees vs. hardware
- FLR coordination: DPA PTEs zapped before reset, restored after

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst | 382 ++++++++++++++++++++++
 2 files changed, 383 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 1833e6a0687e..7ec661846f6b 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -47,6 +47,7 @@ of interest to most developers working on device drivers.
    vfio-mediated-device
    vfio
    vfio-pci-device-specific-driver-acceptance
+   vfio-pci-cxl
 
 Bus-level documentation
 =======================
diff --git a/Documentation/driver-api/vfio-pci-cxl.rst b/Documentation/driver-api/vfio-pci-cxl.rst
new file mode 100644
index 000000000000..1256e4d33fc6
--- /dev/null
+++ b/Documentation/driver-api/vfio-pci-cxl.rst
@@ -0,0 +1,382 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+VFIO PCI CXL Type-2 device passthrough
+=======================================
+
+Overview
+--------
+
+Type-2 CXL devices are PCIe accelerators (GPUs, compute ASICs, and similar)
+with coherent device memory on CXL.mem. DPA is mapped into host physical
+address space through HDM decoders that the kernel's CXL subsystem owns. A
+guest cannot program that hardware directly.
+
+This ``vfio-pci`` mode hands a VMM:
+
+- A read/write VFIO device region (COMP_REGS) that emulates the HDM decoder
+  register block with CXL register rules enforced in kernel code.
+- A mmapable VFIO device region (DPA) backed by the kernel-chosen host physical
+  range for device memory.
+- DVSEC config-space emulation so the guest cannot change host-owned CXL.io /
+  CXL.mem enable bits.
+
+Build with ``CONFIG_VFIO_CXL_CORE=y``. At runtime you can turn it off with::
+
+    modprobe vfio-pci disable_cxl=1
+
+or, in a variant driver, set ``vdev->disable_cxl = true`` before registration.
+
+
+Device detection
+----------------
+
+At ``vfio_pci_core_register_device()`` the driver checks for a Type-2 style
+setup. All of the following must hold:
+
+1. CXL Device DVSEC present (PCIe DVSEC Vendor ID ``0x1E98``, DVSEC ID
+   ``0x0000``).
+2. ``Mem_Capable`` (bit 2) set in the CXL Capability register inside that DVSEC.
+3. PCI class code is **not** ``0x050210`` (CXL Type-3 memory expander).
+4. An HDM Decoder capability block reachable through the Register Locator DVSEC.
+5. At least one HDM decoder committed by firmware with non-zero size.
+
+The CXL spec labels "Type-2" as devices with both ``Mem_Capable`` and
+``Cache_Capable``. This driver also takes ``Mem_Capable``-only devices
+(``Cache_Capable=0``), which behave like Type-3 style accelerators without the
+usual class code. ``VFIO_CXL_CAP_CACHE_CAPABLE`` exposes the cache bit to
+userspace so a VMM can treat FLR differently when needed.
+
+When detection succeeds, ``VFIO_DEVICE_FLAGS_CXL`` is ORed into
+``vfio_device_info.flags`` together with ``VFIO_DEVICE_FLAGS_PCI``.
+
+.. note::
+
+   **Firmware must commit an HDM decoder before open.** The driver only
+   discovers DPA range and size from a decoder that firmware already committed.
+   Devices without that, or hot-plugged setups that never get it, are out of
+   scope for now.
+
+   Follow-up options under discussion include CXL range registers in the
+   Device DVSEC (often enough on single-decoder parts), CDAT over DOE, mailbox
+   Get Partition Info, or a future DVSEC field from the consortium for
+   base/size/NUMA without extra side channels. There is also talk of a sysfs
+   path, modeled on resizable BAR, where an orchestrator fixes the DPA window
+   before vfio-pci binds so the driver still sees a committed range.
+
+
+UAPI: VFIO_DEVICE_INFO_CAP_CXL
+------------------------------
+
+When ``VFIO_DEVICE_FLAGS_CXL`` is set, the device info capability chain
+includes a ``vfio_device_info_cap_cxl`` structure (cap ID 6, version 1)::
+
+    struct vfio_device_info_cap_cxl {
+        struct vfio_info_cap_header header; /* id=6, version=1 */
+        __u8   hdm_regs_bar_index;  /* BAR index containing component regs */
+        __u8   reserved[3];
+        __u32  flags;               /* VFIO_CXL_CAP_* flags */
+        __u64  hdm_regs_offset;     /* byte offset within the BAR to the
+                                     * CXL.mem register area start.  This
+                                     * equals comp_reg_offset + CXL_CM_OFFSET
+                                     * where CXL_CM_OFFSET = 0x1000. */
+        __u32  dpa_region_index;    /* VFIO region index for DPA memory */
+        __u32  comp_regs_region_index; /* VFIO region index for COMP_REGS */
+    };
+    /*
+     * hdm_count and hdm_decoder_offset are intentionally absent from this
+     * struct. Both are derivable from the COMP_REGS region. See the
+     * "Deriving HDM info from COMP_REGS" section below.
+     */
+
+    #define VFIO_CXL_CAP_FIRMWARE_COMMITTED  (1 << 0)
+    #define VFIO_CXL_CAP_CACHE_CAPABLE       (1 << 1)
+
+``VFIO_CXL_CAP_FIRMWARE_COMMITTED``
+    At least one HDM decoder was pre-committed by firmware. The DPA region
+    is live at device open; the VMM can map it without waiting for a guest
+    COMMIT cycle.
+
+``VFIO_CXL_CAP_CACHE_CAPABLE``
+    The device has an HDM-DB decoder (CXL.mem + CXL.cache). This mirrors the
+    ``Cache_Capable`` bit from the CXL DVSEC Capability register. The kernel
+    does not run Write-Back Invalidation (WBI) before FLR; with this flag set
+    that stays the VMM's job.
+
+DPA region size comes from ``VFIO_DEVICE_GET_REGION_INFO`` on
+``dpa_region_index``, not from this struct.
+
+
+VFIO regions
+------------
+
+A CXL device adds two device regions on top of the usual BARs. Their indices
+are in ``dpa_region_index`` and ``comp_regs_region_index``.
+
+DPA region (``VFIO_REGION_SUBTYPE_CXL``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Flags: ``READ | WRITE | MMAP``.
+
+The backing store is the host physical range the kernel assigned for DPA. The
+kernel maps it with ``memremap(MEMREMAP_WB)`` because CXL device memory on a
+coherent link sits in the CPU cache hierarchy. That mapping is normal cached
+memory, so ``copy_to/from_user`` works without extra barriers.
+
+Page faults are lazy: PFNs are installed per page on first touch via
+``vmf_insert_pfn``. ``mmap()`` does not populate the whole region up front.
+
+Region read/write through the fd uses the same ``MEMREMAP_WB`` mapping with
+``copy_to/from_user``. ``ioread``/``iowrite`` MMIO helpers are not used on
+this path.
+
+During FLR, ``unmap_mapping_range()`` drops user PTEs and ``region_active``
+clears before the reset runs. Ongoing faults or region I/O then error instead
+of touching a dead mapping. IOMMU ATC invalidation from the zap has to finish
+before the device resets; doing it the other way around can leave an SMMU
+waiting on a device that no longer responds.
+
+After reset, the region comes back once ``COMMITTED`` shows up again in fresh
+HDM hardware state. The VMM can fault pages in again without a new ``mmap()``.
+
+COMP_REGS region (``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Flags: ``READ | WRITE`` (no mmap).
+
+Emulated registers for the CXL.mem slice of the component register block: the
+CXL Capability Array header at offset 0, then the HDM Decoder capability
+starting at ``hdm_decoder_offset`` (the byte offset derived by traversing the
+CXL Capability Array — see "Deriving HDM info from COMP_REGS" below).
+Region size from ``VFIO_DEVICE_GET_REGION_INFO`` covers the full capability
+array prefix plus all HDM decoder blocks.
+
+Only 32-bit, 32-bit-aligned accesses are allowed. 8- and 16-bit attempts get
+``-EINVAL``.
+
+Offsets below ``hdm_decoder_offset`` return the snapshot from device open.
+Writes there are dropped (with a WARN); the capability array stays read-only.
+
+From ``hdm_decoder_offset`` upward the kernel keeps a shadow
+(``comp_reg_virt[]``) and applies field rules:
+
+- At open, hardware HDM state is snapshotted. For firmware-committed decoders
+  the LOCK bit is cleared and BASE_HI/BASE_LO are zeroed in the shadow so the
+  VMM can program guest GPA; the host HPA is not carried in the shadow after
+  that.
+- ``COMMIT`` (bit 9 of CTRL): writing 1 sets ``COMMITTED`` (bit 10) in the
+  shadow immediately. Real hardware stays committed; the shadow tracks what
+  the guest should see.
+- When LOCK is set, writes to BASE_HI and SIZE_HI are ignored so
+  firmware-committed values survive.
+
+Region type identifiers::
+
+    /* type = PCI_VENDOR_ID_CXL | VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
+    #define VFIO_REGION_SUBTYPE_CXL           1  /* DPA memory region */
+    #define VFIO_REGION_SUBTYPE_CXL_COMP_REGS 2  /* HDM register shadow */
+
+
+BAR access
+----------
+
+``VFIO_DEVICE_GET_REGION_INFO`` for ``hdm_regs_bar_index`` reports the full
+BAR size with ``READ | WRITE | MMAP`` flags and a
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` capability listing the GPU or
+accelerator register windows — the mmappable parts of the BAR that do **not**
+contain CXL component registers.
+
+The number of sparse areas depends on where the CXL component register block
+``[comp_reg_offset, comp_reg_offset + comp_reg_size)`` sits within the BAR:
+
+* **Topology A** - component block at BAR end:
+  ``[gpu_regs | comp_regs]`` → 1 area: ``[0, comp_reg_offset)``
+
+* **Topology B** - component block at BAR start:
+  ``[comp_regs | gpu_regs]`` → 1 area: ``[comp_reg_size, bar_len)``
+
+* **Topology C** - component block in middle:
+  ``[gpu_regs | comp_regs | gpu_regs]`` → 2 areas:
+  ``[0, comp_reg_offset)`` and ``[comp_reg_offset + comp_reg_size, bar_len)``
+
+VMMs **must** iterate all ``nr_areas`` entries; do not assume a single area or
+that the first area starts at offset zero.
+
+The GPU/accelerator register windows listed in the sparse capability **are**
+physically mmappable: ``mmap()`` on the VFIO device fd at the corresponding
+BAR offset succeeds and yields a host-physical-backed mapping suitable for
+KVM stage-2 installation.
+
+The CXL component register block itself **is not** mmappable.  Any ``mmap()``
+request whose range overlaps ``[comp_reg_offset, comp_reg_offset +
+comp_reg_size)`` returns ``-EINVAL``; those registers must be accessed through
+the ``COMP_REGS`` device region.
+
+
+DVSEC configuration space emulation
+-----------------------------------
+
+With ``CONFIG_VFIO_CXL_CORE=y``, vfio-pci installs a handler for
+``PCI_EXT_CAP_ID_DVSEC`` (``0x23``) in the config access table. Non-CXL
+devices fall through as before.
+
+On CXL devices, writes to these DVSEC registers are caught and reflected in
+``vdev->vconfig`` (shadow config space):
+
++--------------------+--------+--------------------------------------------------+
+| Register           | Offset | Emulation                                        |
++====================+========+==================================================+
+| CXL Control        | +0x0c  | RWL; IO_Enable held at 1; locked when Lock       |
+|                    |        | bit 0 is set.                                    |
++--------------------+--------+--------------------------------------------------+
+| CXL Status         | +0x0e  | Bit 14 (Viral_Status) is RW1CS.                  |
++--------------------+--------+--------------------------------------------------+
+| CXL Control2       | +0x10  | Bits 1 and 2 forwarded to hardware.              |
++--------------------+--------+--------------------------------------------------+
+| CXL Status2        | +0x12  | Bit 3 forwarded when Capability3 bit 3 is set.   |
++--------------------+--------+--------------------------------------------------+
+| CXL Lock           | +0x14  | RWO; once set, Control becomes read-only until   |
+|                    |        | conventional reset.                              |
++--------------------+--------+--------------------------------------------------+
+| Range Base Hi/Lo   | varies | Stored in vconfig; Base Low [27:0] reserved bits |
+|                    |        | cleared on write.                                |
++--------------------+--------+--------------------------------------------------+
+
+Reads return the shadow. Read-only registers (Capability, Size High/Low) are
+filled from hardware at open.
+
+
+FLR and reset
+-------------
+
+FLR goes through ``vfio_pci_ioctl_reset()``. The CXL-specific part is:
+
+1. ``vfio_cxl_zap_region_locked()`` runs under the write side of
+   ``memory_lock``. It clears ``region_active`` and calls
+   ``unmap_mapping_range()`` on the DPA inode mapping so user PTEs go away.
+   Concurrent faults or fd I/O hit the inactive flag and error. IOMMU ATC must
+   drain before reset (see the DPA region notes above).
+
+2. After FLR, ``vfio_cxl_reactivate_region()`` reads HDM hardware again into
+   ``comp_reg_virt[]``. If ``COMMITTED`` is set (common when firmware left the
+   decoder committed), ``region_active`` turns back on and the VMM can refault
+   without remapping.
+
+
+Known limitations
+-----------------
+
+**Pre-committed HDM decoder required**
+    See `Device detection`_ and the note there.
+
+**CXL hot-plug not supported**
+    Slots need to be present and programmed by firmware at boot.
+
+**CXL.cache Write-Back Invalidation not implemented**
+    For HDM-DB devices (``VFIO_CXL_CAP_CACHE_CAPABLE``), the kernel does not
+    run WBI before FLR. The VMM must do it and expose Back-Invalidation in the
+    guest topology where required.
+
+
+VMM integration notes
+---------------------
+
+For a ``VFIO_CXL_CAP_FIRMWARE_COMMITTED`` device (what works today)::
+
+    /* 1. Get device info and locate the CXL cap */
+    vfio_device_get_info(fd, &dinfo);
+    assert(dinfo.flags & VFIO_DEVICE_FLAGS_CXL);
+    cxl = find_cap(&dinfo, VFIO_DEVICE_INFO_CAP_CXL);
+
+    /* 2. Get DPA and COMP_REGS region sizes */
+    get_region_info(fd, cxl->dpa_region_index, &dpa_ri);
+    get_region_info(fd, cxl->comp_regs_region_index, &comp_ri);
+
+    /* 3. Map DPA region at a guest physical address */
+    gpa_base = allocate_guest_phys(dpa_ri.size);
+    mmap(gpa_base, dpa_ri.size, PROT_READ|PROT_WRITE,
+         MAP_SHARED|MAP_FIXED, vfio_fd,
+         (off_t)cxl->dpa_region_index << VFIO_PCI_OFFSET_SHIFT);
+
+    /* 4. Derive hdm_decoder_offset from COMP_REGS (see section below) */
+    uint64_t hdm_decoder_offset = derive_hdm_offset(vfio_fd, comp_ri);
+
+    /* 5. Write guest GPA into HDM Decoder 0 BASE via COMP_REGS pwrite */
+    u32 base_hi = gpa_base >> 32;
+    comp_off = (off_t)cxl->comp_regs_region_index << VFIO_PCI_OFFSET_SHIFT;
+    pwrite(vfio_fd, &base_hi, 4,
+           comp_off + hdm_decoder_offset + CXL_HDM_DECODER0_BASE_HIGH_OFFSET);
+
+    /* 6. Build guest CXL topology using gpa_base and dpa_ri.size */
+    build_cfmws(gpa_base, dpa_ri.size);
+
+    /* 7. If CACHE_CAPABLE: issue WBI before any guest FLR */
+
+Extra detail:
+
+- DPA size is ``dpa_ri.size`` from region info.
+- ``CXL_HDM_DECODER0_BASE_HIGH_OFFSET`` lives in ``include/uapi/cxl/cxl_regs.h``.
+- On the BAR, ``mmaps[0].size`` from the sparse-mmap cap on
+  ``hdm_regs_bar_index`` splits GPU MMIO (BAR fd) from the CXL block (COMP_REGS
+  region).
+- If ``VFIO_CXL_CAP_CACHE_CAPABLE`` is set, the guest CXL topology should
+  advertise Back-Invalidation and the VMM should run WBI before FLR.
+
+
+Deriving HDM info from COMP_REGS
+---------------------------------
+
+``hdm_decoder_offset`` and ``hdm_count`` are not in ``vfio_device_info_cap_cxl``
+because both are directly readable from the ``COMP_REGS`` region.
+
+**Finding hdm_decoder_offset:**
+
+Read dwords from the COMP_REGS region starting at offset 0 (the CXL Capability
+Array).  ``comp_off`` is the VFIO file offset for the COMP_REGS region:
+``(off_t)cxl->comp_regs_region_index << VFIO_PCI_OFFSET_SHIFT``::
+
+    /* Dword 0: CXL Capability Array Header */
+    pread(fd, &hdr, 4, comp_off + 0);
+    /* bits[15:0] must be 1 (CM_CAP_HDR_CAP_ID) */
+    /* bits[31:24] = number of capability entries */
+    num_caps = (hdr >> 24) & 0xff;  /* CXL_CM_CAP_HDR_ARRAY_SIZE_MASK */
+
+    /* Walk entries at dword 1..num_caps */
+    for (i = 1; i <= num_caps; i++) {
+        pread(fd, &entry, 4, comp_off + i * 4);
+        cap_id = entry & 0xffff;           /* CXL_CM_CAP_HDR_ID_MASK */
+        if (cap_id == 0x5) {               /* CXL_CM_CAP_CAP_ID_HDM */
+            hdm_decoder_offset = (entry >> 20) & 0xfff; /* CXL_CM_CAP_PTR_MASK */
+            break;
+        }
+    }
+
+**Finding hdm_count:**
+
+Read the HDM Decoder Capability register (HDMC) at ``hdm_decoder_offset + 0``::
+
+    pread(fd, &hdmc, 4, comp_off + hdm_decoder_offset);
+    field = hdmc & 0xf;  /* CXL_HDM_DECODER_COUNT_MASK bits[3:0] */
+    hdm_count = field ? field * 2 : 1;  /* 0→1, N→N*2 decoders */
+
+All constants are in ``include/uapi/cxl/cxl_regs.h``.
+
+
+Kernel configuration
+--------------------
+
+``CONFIG_VFIO_CXL_CORE`` (bool)
+    CXL Type-2 passthrough in ``vfio-pci-core``. Needs ``CONFIG_VFIO_PCI_CORE``,
+    ``CONFIG_CXL_BUS``, and ``CONFIG_CXL_MEM``.
+
+References
+----------
+
+* CXL Specification 4.0, 8.1.3 - PCIe DVSEC for CXL Devices
+* CXL Specification 4.0, 8.2.4.20 - CXL HDM Decoder Capability Structure
+* ``include/uapi/linux/vfio.h`` - ``VFIO_DEVICE_INFO_CAP_CXL``,
+  ``VFIO_REGION_SUBTYPE_CXL``, ``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
+* ``include/uapi/cxl/cxl_regs.h`` - ``CXL_CM_OFFSET``,
+  ``CXL_CM_CAP_HDR_ARRAY_SIZE_MASK``, ``CXL_CM_CAP_HDR_ID_MASK``,
+  ``CXL_CM_CAP_PTR_MASK``, ``CXL_HDM_DECODER_COUNT_MASK``,
+  ``CXL_HDM_DECODER0_BASE_HIGH_OFFSET``
-- 
2.25.1

