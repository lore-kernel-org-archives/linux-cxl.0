Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130D35F17A;
	Wed, 11 Mar 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261470; cv=fail; b=bOJKuxV9oNJyamUINjHl5Mir23BjwjNbk0Obk2ydcdrF4jztXTUdKCHp0SpkYLe2A8kA6e6Bm+HmPcQzYxjAB1y1EZ7p5C0EyF0zAbGOIrY7u0/qTkfMp+QCJaLSocUcmjNWWJvQNs92FqkoiI7ygFprxNuTGKektxFW0mGCJJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261470; c=relaxed/simple;
	bh=jAOgi7NXzXg+K7q7UlANCejfSoXtckeNHyrHwwRpAzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZA7PeIo3fWxZnZA8NEzV2XG59xHKRg84kAm108T6yIp9q+PSGYViivEyFOvY4jKKtLAQhF5h6FZSJ9OnMx1QBmxr7roaVdwRsT2k1QHq25AKI+FW9Ap78Wn+2yn3TTCi6RN87mQ0HHXWgmjXbNIcdO3X8s2bs+F8+7md2+FpfqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QIQPwvV6; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QIQPwvV6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/P2JOmnu7IxuM9ytjvAtUwMqDoGKDYFgedb3iqbX546CcnxLtXutEfSw3hAG8gKSj0L9Xrsg5jDl5mP9NkGMVJpBTFeFQCQyCeHAg4JTDU7s8YAu+NeUjatCpHwytnW8bzVJMDoRIELmQNIpPfJXfD0JVhv8wQRA7Gn0bHCk0BtoRseK8OreHwHyW24HXknoFdyqQtNbycAH++xlZhj6uQfH2mtWtQXNE9qdtECBJK0E3UXGXreNxNZdsJLK1iu83bdSl40cPwab8zsH+nWGNH/Cop++WOjPGpnMP1oZS33EjUABj23LpDKQId4PzuhTRnNKNPZFvrBYwvAqMcX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdwMp85kIhAH4ATymjHOGXtZ7ezqg8fQvFQHCWZetGQ=;
 b=u8dd0AREPTkgYLhrvWsrMU/KCopf71DOM6eMUhWxEoPRS5vwj8+RuhXB9I5uILuzKdpkv/QEm994dqbGMAPgpLhHREwVHUh8Pz7U299PDC2TZYLL1fS0eNt6o/2m6Hxr0iEbUhzSWAb/Jv6xRKxeFV2JcBnj19nv77EvK6o6EN9dd+ZM/bIxiTS8aj8bGCm7eGJeQlK9j6qDn9JrxlFyPyB0wdAd9UObVIcaGMX+VplcoG4o75ScJ8f+DNGo3ttZqeSpunwvKE5/iKBZ8BLOSYX9I8NKNBPFrjwyPMw3RTq45C0QhQ2l6G+wZi2y3lmBxAoSHzcJWfY/BvkvRkSelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdwMp85kIhAH4ATymjHOGXtZ7ezqg8fQvFQHCWZetGQ=;
 b=QIQPwvV6hsFbkNWFu3o7m8xIsHygVmU81/ZtVBfxeZyS2689mfqJGW1vF8bDtto11t8kBoUWnZPXsGpKLCe1WVOUHkYTmDjm/RbpkMBeCkBwfVmtGurPZL+SCLN8yJJ+7XolO9AIzL63T1+Gs1qGRs0jCJVdowFhx7rlDzXsP7OWiUGtAyVd553x7SdDeQd0bS94gS4eYtaxVwJHh51YNkwRNe+bj3F6HoisYdWrJOvg8JEVuQ9x2nRyvi3CtJnPH3WxjddfrZSaDEcvqe5D+5M+JJiYnSl2pQSbI+ErhXprd8RhiHWMgkr/cDtHFX2NsmTnHLzdcm71eXHNPopFKg==
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 20:37:36 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::db) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 20:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:37:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:12 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:37:05 -0700
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
Subject: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device passthrough
Date: Thu, 12 Mar 2026 02:04:38 +0530
Message-ID: <20260311203440.752648-19-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd12706-ae02-4271-22d9-08de7fae079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Yn35CoIrF3paHwnYOgcNS2oiJucu0Bt/S5Yu2uapqFsyajVmzN8V0dSVYjHELBILfmOHW3wW0i75iKNu3A0lH6FvHvZLNrs3+JWc5c1kBywa30b1iMDL557p+L7MJ2YgMkTKu+JusKm+wK67CdfZ5ftTG24DXc70K6DlYAs/TdsDVozRjTJDuh2BV0G3RhJ+bbLHBcF3igzcuHrV9wAafsSKbzRa+k6xIgU3r0TRSbtH7aFY58EGNs6xgYlHW1CLv0k3HMtGMNQgdl7N5oInvk0B01IHCzVkBQMzhSrLl8qeD2EVIXnrGLnM00iVj21IcugZ/81pVGhf+9cIiFEWtK1HvkEmMDclMSA+2VavM/ufhzGtZgSnQtKoaKTFXFJmO4iZ5hPcYldDJq0Ogxh65/EqM3So9PUvc+GJhfxImiQbQ8gkdwoU5NUII5mcp5xq1ZabXWBA/wgIcLnY7IlTOK66HCZruzrFPGro0CXFAKE06rDAR9Rt6GKs53k1uGjJvSimIbRXoWtF7ZO20SnYDlu0TLDwxq5M5ZhQDcRRjMvvLIf9ngt0vD+fwfXfKoBSXWqFXAsC+SU7h3Nl2XVd94DlbAqyb1zMKzDby8u6GR5zmDtSdfGnTRpAJZQ+63nGUCGHVyf40OwRo7uU6JDSbf8lg9lOCtdm5KATh1sj3TcwFB2t6Rpgskpvu+hCGlNc0eCbCJPyAZmNoDdzo8G71qnxXdj92qaHP3CiTrLtyGt4GWaDDYij3H3fFS0W+fCpUHDhO2AkyNmpv+/AYvDF6epqbD2GIzyGDyCsPfWXsBqHhp0upGqvcAQjnCukQIdZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tbc64jHe+pasdO/zOi7grkqNzKV3dXHSyy/tmFyQoH79FcvzT/8M+oWkQm2AzdiGSazSoPiHscwWV8wqHnD4kclGQx+Ym3SiUsAQpWTuXQ1ID0PI6v5OeHH3XwbXux/y88llMjtXKIemLf7E7viIXDqGF9UfkdwwhE72ZutuOLI5/AP5PAoqAvUCk3PnD3wcaU6W2OQuw+G0+kxLuqNU735T7t9CFz1PYiWqxi0YqlHANg7LlamAmnnaSuvILR3gKpYb3EefxTvXLoFAixOe64ddx9dfjR/CSH7yp+BJ2waHVBX3Z1vp02SpmhmpPjyLjFL41842Mo/sIJR9ASlvxPLuY+Knnu42GSqL3aMi+Uo8W9eK+KYY4uzhlbHHGO9GVP25QaHozCqhTDINjcIznQU8/xSmnzQhR1Z+fLjatDgYCpjCX5Wyff4T9uxHGqwK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:37:36.0357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd12706-ae02-4271-22d9-08de7fae079e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575

From: Manish Honap <mhonap@nvidia.com>

Add a driver-api document describing the architecture, interfaces, and
operational constraints of CXL Type-2 device passthrough via vfio-pci-core.

CXL Type-2 devices (cache-coherent accelerators such as GPUs with attached
device memory) present unique passthrough requirements not covered by the
existing vfio-pci documentation:

- The host kernel retains ownership of the HDM decoder hardware through
  the CXL subsystem, so the guest cannot program decoders directly.
- Two additional VFIO device regions expose the emulated HDM register
  state (COMP_REGS) and the DPA memory window (DPA region) to userspace.
- DVSEC configuration space writes are intercepted and virtualized so
  that the guest cannot alter host-owned CXL.io / CXL.mem enable bits.
- Device reset (FLR) is coordinated through vfio_pci_ioctl_reset(): all
  DPA PTEs are zapped before the reset and restored afterward.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst | 216 ++++++++++++++++++++++
 2 files changed, 217 insertions(+)
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
index 000000000000..f2cbe2fdb036
--- /dev/null
+++ b/Documentation/driver-api/vfio-pci-cxl.rst
@@ -0,0 +1,216 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================================
+VFIO PCI CXL Type-2 Device Passthrough
+====================================================
+
+Overview
+--------
+
+CXL (Compute Express Link) Type-2 devices are cache-coherent PCIe accelerators
+and GPUs that attach their own volatile memory (Device Physical Address space,
+or DPA) to the host memory fabric via the CXL protocol.  Examples include
+GPU/accelerator cards that expose coherent device memory to the host.
+
+When such a device is passthroughed to a virtual machine using ``vfio-pci``,
+the kernel CXL subsystem must remain in control of the Host-managed Device
+Memory (HDM) decoders that map the device's DPA into the host physical address
+(HPA) space.  A VMM such as QEMU cannot program HDM decoders directly; instead
+it uses a set of VFIO-specific regions and UAPI extensions described here.
+
+This support is compiled in when ``CONFIG_VFIO_CXL_CORE=y``.  It can be
+disabled at module load time for all devices bound to ``vfio-pci`` with::
+
+    modprobe vfio-pci disable_cxl=1
+
+Variant drivers can disable CXL extensions for individual devices by setting
+``vdev->disable_cxl = true`` in their probe function before registration.
+
+Device Detection
+----------------
+
+CXL Type-2 detection happens automatically when ``vfio-pci`` registers a
+device that has:
+
+1. A CXL Device DVSEC capability (PCIe DVSEC Vendor ID 0x1E98, ID 0x0000).
+2. Bit 2 (Mem_Capable) set in the CXL Capability register within that DVSEC.
+3. A PCI class code that is **not** ``0x050210`` (CXL Type-3 memory device).
+4. An HDM Decoder block discoverable via the Register Locator DVSEC.
+5. A pre-committed HDM decoder (BIOS/firmware programmed) with non-zero size.
+
+On successful detection ``VFIO_DEVICE_FLAGS_CXL`` is set in
+``vfio_device_info.flags`` alongside ``VFIO_DEVICE_FLAGS_PCI``.
+
+UAPI Extensions
+---------------
+
+VFIO_DEVICE_GET_INFO Capability: VFIO_DEVICE_INFO_CAP_CXL
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When ``VFIO_DEVICE_FLAGS_CXL`` is set the device info capability chain
+contains a ``vfio_device_info_cap_cxl`` structure (cap ID 6)::
+
+    struct vfio_device_info_cap_cxl {
+        struct vfio_info_cap_header header; /* id=6, version=1 */
+        __u8  hdm_count;          /* number of HDM decoders */
+        __u8  hdm_regs_bar_index; /* PCI BAR containing component registers */
+        __u16 pad;
+        __u32 flags;              /* VFIO_CXL_CAP_* flags */
+        __u64 hdm_regs_size;      /* size in bytes of the HDM decoder block */
+        __u64 hdm_regs_offset;    /* byte offset within the BAR to HDM block */
+        __u64 dpa_size;           /* total DPA size in bytes */
+        __u32 dpa_region_index;   /* index of the DPA device region */
+        __u32 comp_regs_region_index; /* index of the COMP_REGS device region */
+    };
+
+Flags:
+
+``VFIO_CXL_CAP_COMMITTED`` (bit 0)
+    The HDM decoder was committed by the kernel CXL subsystem.
+
+``VFIO_CXL_CAP_PRECOMMITTED`` (bit 1)
+    The HDM decoder was pre-committed by host firmware/BIOS.  The VMM does
+    not need to allocate CXL HPA space; the mapping is already live.
+
+VFIO Regions
+~~~~~~~~~~~~~
+
+A CXL Type-2 device exposes two additional device regions beyond the standard
+PCI BAR regions.  Their indices are reported in ``dpa_region_index`` and
+``comp_regs_region_index`` in the capability structure.
+
+**DPA Region** (subtype ``VFIO_REGION_SUBTYPE_CXL``)
+    Flags: ``VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE |
+    VFIO_REGION_INFO_FLAG_MMAP``
+
+    Represents the device's DPA memory mapped at the kernel-assigned HPA.
+    The VMM should map this region with mmap() to expose device memory to the
+    guest.  Page faults are handled lazily; the kernel inserts PFNs on first
+    access rather than at mmap() time.  During FLR/reset all PTEs are
+    invalidated and the region becomes inaccessible until the reset completes.
+
+    Read and write access via the region file descriptor is also supported and
+    routes through a kernel-managed virtual address established with
+    ``ioremap_cache()``.
+
+**COMP_REGS Region** (subtype ``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``)
+    Flags: ``VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE``
+    (no mmap).
+
+    An emulated, read/write-only region exposing the HDM decoder registers.
+    The kernel shadows the hardware HDM register state and enforces all
+    bit-field rules (reserved bits, read-only bits, commit semantics) on every
+    write.  Only 32-bit aligned, 32-bit wide accesses are permitted, matching
+    the hardware requirement.
+
+    The VMM uses this region to read and write HDM decoder BASE, SIZE, and
+    CTRL registers.  Setting the COMMIT bit (bit 9) in a CTRL register causes
+    the kernel to immediately set the COMMITTED bit (bit 10) in the emulated
+    shadow state, allowing the VMM to detect the transition via a
+    ``notify_change`` callback.
+
+    The component register BAR itself (``hdm_regs_bar_index``) is hidden:
+    ``VFIO_DEVICE_GET_REGION_INFO`` for that BAR index returns ``size = 0``.
+    All HDM access must go through the COMP_REGS region.
+
+Region Type Identifiers::
+
+    /* type = PCI_VENDOR_ID_CXL | VFIO_REGION_TYPE_PCI_VENDOR_TYPE (0x80001e98) */
+    #define VFIO_REGION_SUBTYPE_CXL           1   /* DPA memory region */
+    #define VFIO_REGION_SUBTYPE_CXL_COMP_REGS 2   /* HDM register region */
+
+DVSEC Configuration Space Emulation
+-------------------------------------
+
+When ``CONFIG_VFIO_CXL_CORE=y`` the kernel installs a CXL-aware write handler
+for the ``PCI_EXT_CAP_ID_DVSEC`` (0x23) extended capability entry in the vfio-pci
+configuration space permission table.  This handler runs for every device
+opened under ``vfio-pci``; for non-CXL devices it falls through to the
+hardware write path unchanged.
+
+For CXL devices, writes to the following DVSEC registers are intercepted and
+emulated in ``vdev->vconfig`` (the per-device shadow configuration space):
+
++--------------------+--------+-------------------------------------------+
+| Register           | Offset | Emulation                                 |
++====================+========+===========================================+
+| CXL Control        | 0x0c   | RWL semantics; IO_Enable forced to 1;     |
+|                    |        | locked after Lock register bit 0 is set.  |
++--------------------+--------+-------------------------------------------+
+| CXL Status         | 0x0e   | Bit 14 (Viral_Status) is RW1CS.           |
++--------------------+--------+-------------------------------------------+
+| CXL Control2       | 0x10   | Bits 0, 3 forwarded to hardware; bits     |
+|                    |        | 1 and 2 trigger subsystem actions.        |
++--------------------+--------+-------------------------------------------+
+| CXL Status2        | 0x12   | Bit 3 (RW1CS) forwarded to hardware when  |
+|                    |        | Capability3 bit 3 is set.                 |
++--------------------+--------+-------------------------------------------+
+| CXL Lock           | 0x14   | RWO; once set, Control becomes read-only  |
+|                    |        | until conventional reset.                 |
++--------------------+--------+-------------------------------------------+
+| Range Base High/Lo | varies | Stored in vconfig; Base Low [27:0]        |
+|                    |        | reserved bits cleared.                    |
++--------------------+--------+-------------------------------------------+
+
+Reads of these registers return the emulated vconfig values.  Read-only
+registers (Capability, Size registers, range Size High/Low) are also served
+from vconfig, which was seeded from hardware at device open time.
+
+FLR and Reset Behaviour
+-----------------------
+
+During Function Level Reset (FLR):
+
+1. ``vfio_cxl_zap_region_locked()`` is called under the write side of
+   ``memory_lock``.  It sets ``region_active = false`` and calls
+   ``unmap_mapping_range()`` to invalidate all DPA region PTEs.
+
+2. Any concurrent page fault or ``read()``/``write()`` on the DPA region
+   sees ``region_active = false`` and returns ``VM_FAULT_SIGBUS`` or ``-EIO``
+   respectively.
+
+3. After reset completes, ``vfio_cxl_reactivate_region()`` re-reads the HDM
+   decoder state from hardware into ``comp_reg_virt[]`` (it will typically
+   be all-zeros after FLR) and sets ``region_active = true`` only if the
+   COMMITTED bit is set in the freshly re-snapshotted hardware state for
+   pre-committed decoders.  The VMM may re-fault into the DPA region without
+   issuing a new ``mmap()`` call.  Each newly faulted page is scrubbed via
+   ``memset_io()`` before the PFN is inserted.
+
+VMM Integration Notes
+---------------------
+
+A VMM integrating CXL Type-2 passthrough should:
+
+1. Issue ``VFIO_DEVICE_GET_INFO`` and check ``VFIO_DEVICE_FLAGS_CXL``.
+2. Walk the capability chain to find ``VFIO_DEVICE_INFO_CAP_CXL`` (id = 6).
+3. Record ``dpa_region_index``, ``comp_regs_region_index``, ``dpa_size``,
+   ``hdm_count``, ``hdm_regs_offset``, and ``hdm_regs_size``.
+4. Map the DPA region (``dpa_region_index``) with mmap() to a guest physical
+   address.  The region supports ``PROT_READ | PROT_WRITE``.
+5. Open the COMP_REGS region (``comp_regs_region_index``) and attach a
+   ``notify_change`` callback to detect COMMIT transitions.  When bit 10
+   (COMMITTED) transitions from 0 to 1 in a CTRL register read, the VMM
+   should expose the corresponding DPA range to the guest and map the
+   relevant slice of the DPA mmap.
+6. For pre-committed devices (``VFIO_CXL_CAP_PRECOMMITTED`` set) the entire
+   DPA is already mapped and the VMM need not wait for a guest COMMIT.
+7. Program the guest CXL DVSEC registers (via VFIO config space write) to
+   reflect the guest's view.  The kernel emulates all register semantics
+   including the CONFIG_LOCK one-shot latch.
+
+Kernel Configuration
+--------------------
+
+``CONFIG_VFIO_CXL_CORE`` (bool)
+    Enable CXL Type-2 passthrough support in ``vfio-pci-core``.
+    Depends on ``CONFIG_VFIO_PCI_CORE``, ``CONFIG_CXL_BUS``, and
+    ``CONFIG_CXL_MEM``.
+
+References
+----------
+
+* CXL Specification 3.1, §8.1.3 — DVSEC for CXL Devices
+* CXL Specification 3.1, §8.2.4.20 — CXL HDM Decoder Capability Structure
+* ``include/uapi/linux/vfio.h`` — ``VFIO_DEVICE_INFO_CAP_CXL``,
+  ``VFIO_REGION_SUBTYPE_CXL``, ``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
-- 
2.25.1

