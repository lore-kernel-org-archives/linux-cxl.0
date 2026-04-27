Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734331E84F;
	Mon, 27 Apr 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313630; cv=fail; b=EgxQMLepJ0R9+bn6JAoCsl4CxZvBLOylHZyVeGXs6aChJT3yfS/l9H+Co1pVg3cD6XkXV7RimIQCRtNUSCMCBrYUeLjkX34+gWc/aF7rZe9mTYr4AtOojW8bm1pLDvGXZCzM0nEbHXf4xXTmR4buPPJKz2kNmKUmPRu9mSlrEvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313630; c=relaxed/simple;
	bh=IdBptXn90TfbiXGYR2A0yNkry6iVO6Kg/kWcZZ4OB8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nq0D+ksH22MX3OBg2h90PpIahSuVm4f0HEiLWx6PxttujOKuoFooXgHgQmiUWyEIgTLz1DdT7+v8Y2WKTNKO+youX9pMF6GHyfRbcPqICpjbULBpOWzO20QcF97fXlTl2IAwG49Vaihu2wy+l1Mc8yh5WpnV06ZHsV/j+CzNDgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rqg0/zc3; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rqg0/zc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxpf7LJ1gm3uqdgT0QRPyGR8zwYnDIlB7DtsV2/ICZUg+1ll/fw9chKTe8qHnWiuQbvsz6Rq450Y3cU5iQvUlE5Q711rihQ/yGYzgIgTOunKnf8oyuTylaXC2kTgqtMMRZPBdTBxHMboMNDZEb+QnrO+aSPoJp07moRlRslUMXJBt0VJXiHtCVhkFSwplq2GYrxGvlqTF0BypeJ1lElXz0nergXR0G+T3asGWkI7XlghU+j4zSuJT1mR/ZEogu0w3jNH/DHh0PjJX/ql+NBcyQ1G2Yx8jUUJmAZFpkgI7APqExuXNRZzopgLTxJoqoYc6ooh6qpftDHuZrb95Q+kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S2ZbruBVvrKyLOdEJcOOwMS59sa6G5PVoQI+zE1yKc=;
 b=EccMf31uBgvtMjU+FHpqpvDBW6ftRhV/loLTU0RCsjiQHq2HujGXFIv1TNuqPpUlbuqZt/CIpuzSptm5o4hjLJnmGSS+JmNByvWt8hoZfqNSfBmxn1/6tLF4rt+r3KArdIXOZSYj5pBdcRtgykZmkqrvs05bci0XN8FUL6FedWOhMxrZVNxaj44yoF8PVN3wMGHvtJ1KJk0O4e9WISPMX9pmFT+6bVDpnlUj76BvUjQwY45Yavfm9ij8Ws7ukQqUlLTgtoxKpvbEzw/Y+sVHQlaNL+SBQOhGVHzd0brOLR0kR7XBPjyhQavX+KjDD+4z3pMERnkbKrXNMRSXvy3bAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S2ZbruBVvrKyLOdEJcOOwMS59sa6G5PVoQI+zE1yKc=;
 b=rqg0/zc3eJVicS3PFEVoYRHU2GDJPvIYCQhW2iKx0PMIlZerDpS7EaOxjGcDF1+6/y9OJNBd1dqUFJ1BgD5j+dWY37VskCVTNu/0k+noR/5IHh9CNBkv/JYoYH31gJzjccISN23yNR82HEClYrh7g3nkdlXR5A0jkOEoDUWFFwgnH6p+Bb1poKQiW0WleObqBzK32gPqQYcoCd+5Lqh6TksEPAZqFiejj2ed+TmOtB7HowFmxh/qMKlF6eR+vp1bru/Oiyoa/z1g9ew2k0MgQtJ2OtejnM8eSEZyYokiPTiLLdWauTeBsIhHvBViVf+7JHfMIdOGa0IEWTsKfp/f1g==
Received: from MN2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:208:23b::12)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 18:13:42 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::db) by MN2PR11CA0007.outlook.office365.com
 (2603:10b6:208:23b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:13:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:13:18 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:13:10 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
	<fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
	<marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	"Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
Date: Mon, 27 Apr 2026 23:42:26 +0530
Message-ID: <20260427181235.3003865-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d92f96d-b87b-42b7-c037-08dea488b5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PO9HMGXNRPzeKmpMW4lay998skO1hCp/hS6TjlQ067JjndmSdYGLSdPAuyngZoPZfzn8QJhZCu5bDLlVpx31eq78nEcnAt4SlkGJbKyOu4fu9fu6af0K0i2HFkkxXNQ19MJHdS69/9ivODUPC1enFwvHHh9Pz+Yd/YM6fJce0tJNxT5FCaKe+Lqy9xGTxZs4t/D+FGQXiX1YcEY3qFQ1a02THXxd+mci8oGoZZhTOPYrf5N7VUe/PW0F6O43Nz2EfrvpEoIbzHjUOQ0i9utxw5t5Esdu0Hn0POauPN5ImWZeZXVHEqGhILdY+thQqh8cLkvJ88T+LG0aK07sn0RuU1p0BnqB1E22s0CcRth4hh3sTWAYC9Auvks626aWQhZC62mkPNir0skqql2h07ZDxXnopA/qpJF220iUcq/TXSetnPwjYxX7FlRHMYo87bIV94R5mc5cPdRXEBc5NqCSeXc4xAjh5RKLxakNtnXm92lEByS3gMfbRWgjAVwOaiN3RbpaWM4OveoMMZ44zP0doTp7QSsRfIXOJ0OB5yL7INH7DDyQaH3lAw4Om+dUOjQuabqKRsEyQCM7+9WQzrFEmPigQtUejiYhJkGuT7JYg7OeW+TKVy7gysi+uzJDBLwyuwzAq8bWliJUaPkXvf35AVpjWID0EGt63TdmrUqHiS43uHUpg2vZANdNDNkY98YhF8eG57uOQcusCYL1XOxEjm2n2Rz3wTP5A3dd0BRLvnOWhQUSrb2Gr5KJYAzRzDwMO/uLIM1QpDz+JlikReY8u//pxZAVxrc31AUEZZBHPhKVmid2bmFKX8Knax8xb/IN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(921020)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gGyGDS3SU+1gp6lAqF8lhBQh+K0jhSrpDMoy7wvw8i7e7rsxxVDd4Ry0UAoB3FKliPJV2fmNE/B377f46Lh171/GG/g2r5jYpZ3OsBADdiHphn4Z5JEiK6JBQ6UPypsXp+zONx5y6SWSNb0UNasUWTrI3ADsBhKlaL1fin4piUdAnT9weQCEqIiTU6k+z1pz2XXBgu53SQCyfRucFlePn3yPa9269oeUMdpKdnoi1d4CVoM7PJWzSz3T2oA8t4NcrLLBf5X2lOHMS3iPcyblC+PeTXJOfvFo5+/FUjwfKmk5m4yx7lT6DX4SgHg7yikApAtdDDvuIhh6qPrRMnO/lMPs1jgYbqeDL7kjnTtnb0nhu1ie3ouWsZx04OvhNL9rl2rkl+qc+oLrQZGnXAQg8TdkN6ZY8nxLe4qj6spwwC6MyhzngCt0I2u18t0vS/29
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:13:40.1989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d92f96d-b87b-42b7-c037-08dea488b5b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

From: Manish Honap <mhonap@nvidia.com>

This series adds QEMU-side support for passing CXL Type-2 devices
(GPUs and accelerators with host-managed device memory) to VMs via
vfio-pci.

It pairs with the kernel series "vfio/pci: CXL Type-2 passthrough"[1]
posted to the vfio mailing list. Patches 3-7 need that kernel series
present to do anything useful. I am new to QEMU development, so please
forgive and point me in the right direction for correct infrastructure
decisions.

Background
----------

CXL Type-2 devices expose device memory (CXL.mem) through HDM decoders.
The kernel vfio-pci driver shadows the HDM Decoder Capability registers
so userspace can observe and control decoder commits without touching
the hardware register page directly.

Without this series, the guest never sees the device memory range and
the HDM decoder goes unconfigured. The device shows up but its memory
is unreachable.

Design decisions
----------------

CXL.mem is exposed to the guest as a dedicated GPA window declared in ACPI
(CEDT/CFMWS) rather than a PCI BAR. The HDM decoder BASE must match the
CFMWS base and remain stable; BAR assignment is not stable. A separate
VIRT_HIGH_CXL_MMIO window in the ARM virt memory map carries this GPA range,
independent of the existing PCIe MMIO slots.

The Component Register BAR contains two distinct ranges. Accelerator
register windows are passed through as direct hardware mmaps via
VFIO_REGION_INFO_CAP_SPARSE_MMAP. The HDM Decoder Capability block is
excluded from that sparse list by the kernel and must be intercepted by
QEMU to track decoder state. A single priority-1 COMP_REGS overlay
placed at hdm_regs_offset inside the BAR container wins over any
hardware-backed alias at the same offset, with no per-window aliasing
required.

The guest has no mechanism to remap host physical mappings. QEMU programs
decoder 0 with the CFMWS base through the kernel's COMP_REGS shadow at
machine_done time, after all devices are realized and before the guest starts.
The notifier is registered only for devices the kernel reports as
firmware-committed (VFIO_CXL_CAP_FIRMWARE_COMMITTED).

The CXL.mem MemoryRegion is a mmap-backed RAM-device region backed by a
VM_IO|VM_PFNMAP VMA. The VFIO MemoryListener would attempt an IOMMU
DMA mapping for it when it is added to system_memory, which always
fails: pin_user_pages() refuses VM_IO pages. No IOMMU mapping is needed
for these regions - CPU access goes via KVM Stage-2 page faults and
device DMA to RAM uses separate per-RAM-section IOMMU entries. The
listener is extended to skip the mapping attempt for VFIO-owned
RAM-device regions.

pxb-cxl bridges had no _DSM method. Without _DSM function 5 the OS
defaults to treating PCI configuration as reassignable.
On machines with firmware-committed HDM decoders that reassignment breaks
the CXL.mem mapping, so the _DSM is added with preserve_config=true for ARM and
false for x86.

Known issues:
- The bios-tables test will fail due to the _DSM addition.
  A fix will be provided in a follow-up round.
- VFIO_CXL_CAP_CACHE_CAPABLE will require additional handling.
- Devices with multiple firmware-committed HDM decoders are not fully
  supported.
- Non-firmware-committed devices are not supported.
- linux-headers sync is manual and temporary; once the kernel series is
  merged, this patch will be replaced with script generated update.

[1] https://lore.kernel.org/linux-cxl/20260401143917.108413-1-mhonap@nvidia.com

Manish Honap (9):
  hw/arm/virt: Add CXL FMWS PA window for device memory
  cxl: Add preserve_config to pxb-cxl OSC method
  linux-headers: Update vfio.h for CXL Type-2 device passthrough
  hw/vfio/region: Add vfio_region_setup_with_ops() for custom region ops
  hw/vfio/pci: Add CXL Type-2 device detection and region setup
  hw/vfio/pci: Wire CXL component-register BAR with COMP_REGS overlay
  hw/vfio+cxl: Program HDM decoder 0 at machine_done for
    firmware-committed devices
  hw/arm/smmu-common: Allow pxb-cxl as SMMUv3 primary bus
  vfio/listener: Skip DMA mapping for VFIO-owned RAM-device regions

 hw/acpi/cxl-stub.c         |   2 +-
 hw/acpi/cxl.c              |   4 +-
 hw/arm/smmu-common.c       |  17 +-
 hw/arm/virt-acpi-build.c   |   5 +
 hw/arm/virt.c              |   7 +
 hw/cxl/cxl-host-stubs.c    |   2 +
 hw/cxl/cxl-host.c          |   8 +
 hw/i386/acpi-build.c       |   2 +-
 hw/pci-host/gpex-acpi.c    |  43 +++-
 hw/vfio/listener.c         |  14 ++
 hw/vfio/pci.c              | 411 +++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h              |  15 ++
 hw/vfio/region.c           |  15 +-
 hw/vfio/trace-events       |   6 +
 hw/vfio/vfio-region.h      |   3 +
 include/hw/acpi/cxl.h      |   2 +-
 include/hw/arm/virt.h      |   2 +
 include/hw/cxl/cxl_host.h  |  10 +
 include/hw/pci-host/gpex.h |   2 +
 linux-headers/linux/vfio.h |  18 ++
 20 files changed, 570 insertions(+), 18 deletions(-)

--
2.25.1

