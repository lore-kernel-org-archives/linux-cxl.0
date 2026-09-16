Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E54D0CDD
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584331; cv=fail; b=GU6ZXF33gwjO6nIBU1g92GCNki/aPN2PpGrAufMvDezdUYn56/CFRphH3JyqXH0FUpprI9h4W8l9CupKurh7gF2myFML8HCX040vjvysrZReutLYLkpBqTEYHAE9j/GETZDWYsTVpIvOe26YVHN1dQ9PkXTStGl2xKDU1267o4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584331; c=relaxed/simple;
	bh=oveF4fmzJEd+Gg/Ez6Og7MTntlsUjBP906CQh3VWVEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=My1tMrW74A4ccIR5fK+Rgs7xkC1+Q1KqG2w/95tv8XN+z7uRFKV2XRaK2VOERB8AKUmW0aOQwZRH6Ks9vc8kf394oM1Q8vPyexOoz+8YbJ4Lfpl0B4hofRbofBt3iVtFKLb0SobIP5tvQEoNaLMIjCPdhJDUVDzsZFYMfB+//gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOdR+jp5; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOdR+jp5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L99o+/vk0EQk3JAuaAfUYfdAfuCZ++dxVcBul+FoBj9NMU9Y6n0ZTAqnXqn3PlXGNcpP/DT0bh89BJKJmWwGwjOw4qQSY6Or1LzQgwyNtm/i5EakLLml/wZErLXdXLaM5wXT073Eqyv5nLHXgRsTPuFapeqQleIAO26N1MTagvj6kNd/RhF6wLX6242ZmAfDRvehgJZ5Gem5MK1BS+kaAsoq1S4MQ3IdARtxAkteQgPoCCWy2uDSjkKDkh14THtjN1VyHMDaeQCJiy8JODcnao43zqCJHVsgZMeSALINf8bcSl4fvDZvs/7N3SXOVHCIiu0TofL1Pw0e7Nb/E7YUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BXpBtAJnXGa/TcBpPFAjoxgsdT3fv5Qh0pT915IDNU=;
 b=mBIacEf2m5CK56/pfaUcTZG21gTn8N+xe7cjWK2hXCFGCSelQZA3P9L2PCHhcWQoGV0M/aH4bjnWaubJE0burLM05QrIuJi9w1nDogoyrQnKcDhX9/Om3yG4evCL12ZrO3kPhIra+IUfX72O9BrmQ8UHc9lNTz0yeHOQ1N06ide8M4GEUdsLT5hsIEsbCTzEIYmSzvJbIgwiI6eo/ApcJGb434q7H+d0uufZoNIOCNyGNEcYeFompv7zIyINlflEK7CapK00ISUzNn0IWSKbUdfU9BvYzvzyxvPKpUnoe6TIF1BbK0HzSvSEwRYNNvDGl5HueBH5kNw5FqcjHq3d/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BXpBtAJnXGa/TcBpPFAjoxgsdT3fv5Qh0pT915IDNU=;
 b=OOdR+jp5gzphKIXC8vHyOafKeq/0nz75SJ5cSmajHlvVPd96T58fuXTk2QlW7l0X76gJrIwDtwKNlBhp7JCUSb8sdku2ZyqRqIrK2deaLU3DcSVN2svnrQKuum2LpuYynmL33lIIQxvFpyvVQdolJ1gjyC3Rm75pkf24XlaOLaE28Ma/2a+FqUImqF41THG1YR0SZJE3fDG5nmanBtnjhSRfavbN5aAmcYcj50Cb75IBWdeiIaftQJPC3euDzJQNew2dhp2MbNm7CPM0bYWI0NUzjHVXgdXNl2o5AuyggutwKxgpjuePt5/D+ZqFGUG7X1jqLahIiwPmR6JZKA0bcw==
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 18:45:03 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::17) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 18:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:44:33 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:44:27 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: [PATCH v2 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
Date: Thu, 17 Sep 2026 00:14:02 +0530
Message-ID: <20260916184412.3825713-1-mhonap@nvidia.com>
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
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dca214f-6418-4c4d-54a7-08df14229e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|82310400026|1800799024|921020|56012099006|5023799004|10067099003|11063799006|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	+JL36iTfDh60OfFPDA3nU4qCFkYVKhmole5zNvAEGy46jqhifYroJsUC4tv0N7yiRnJQ+eu4NPOhFgYrUxpDquTfJkRr9709KihmChl/JFqwvzcz36UFmAXdHjzOUwhTmw8scHKjaiTAk1LqQTtE0hrxqSQTDxJuGJ5EBhz4t0iJKwFa08nRbwgN12zazIo7FB2BkhumKIW5pEMCxu2lM8cY2Fa9Z2gmhTXK1ii9n8o29p2dQ6L7m/x48uyi98MR5cyMcDW7SG+4bqY5SolyA/qsTH3GicYwmoHoKUiZs+z+UUZxV3ErK6u5wxG3BCWd7k26TqtUH7azf90Lh32ko1td4hCWCk2kzBORM5SC34igUQPYu1Xqi0FQYqyOph9TnPAr0rndESGVHaamALZPGS+m4Vhhxb1TeMDMfpVyPZiIzPH4qQ+tk6OuOdkI3kBVOFse2nJeI3w61DZ3oNRI0zqFvPvq7gr6F3Qr2GFEpb9I38KknL7XKKkPpWGTlZO7moyUXdhZc8yvfzWcZxEM00in2pxYqxqV4AbKXBMlaZVvpAJHZGoQG+VAPDP8c69ESrzyHZWZFZlVH5jBpT1pL9a9XdIfcqidw6Eihh7IAMbEZ6oEZzSV3lOke5oExR0H1zyOq/MeccHnif+LtAc9WgpPBlr1vCbwyj+iYMQmiVPS84juXfoPNq/97ESlUr2Zf3TBpikOZpYhN5vAnlLTY0h/+waOax1XP406DUZiDujEseZVPoScbTtlDIyFoIOk
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(82310400026)(1800799024)(921020)(56012099006)(5023799004)(10067099003)(11063799006)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xuv1CpdmLDNdypGoMllpV1hLV7jqO/Wjiw4e8iljIAbSaM0JWS6xs3a5folIGhSXyL8vlEwMBIbDoyiXK1w2/EJYHzN6o7uROEb22P4Tr9QtzxGuN5tRzfnzKgPklEbk2K+I5aCIL+HyqJjDc7Rd7j/CoWO6VoSWCfrg2V3qo7E2RGK4miEyzliZ74SZQQ94VcojdpbRAQu12uAc8Wa5WWBnkVRaCnkkYz1WUFy40/5dGALeahs4zecAePW4ZTtfjQL/qHRASOiicGJXC5pNqeTo8OGwjtIpX3PnOlp3udGLluYVCJcwK8jhKmEW5deALuniJppdx2zoes0uQK5ndLDjV2h/e9uA8rP54f9ICirbik86oTIP0XK7BwUSQQDRw5D4WtUAbA72Q1hhnTIGi4Qskd9byVj/M2xvs+BnWxxgfi5BJ3lG9sBgCl6QCWXt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:02.6223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dca214f-6418-4c4d-54a7-08df14229e54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

From: Manish Honap <mhonap@nvidia.com>

This series adds QEMU support for passing a CXL Type-2 device (an
accelerator with host-managed device memory, e.g. a GPU) to a guest via
vfio-pci. The guest drives its own virtual endpoint HDM decoder and QEMU
maps the device memory at the guest physical address the guest commits,
while the host owns the host physical placement.

v1 [1] was reviewed by Junjie Cao and Cedric Le Goater. v2 addresses
Junjie's comments; see "Changes since v1" below.

Base: qemu master, commit 28e7aad522.


Kernel dependency
-----------------

Pairs with the kernel "vfio/cxl: CXL Type-2 device passthrough" series [2].
The kernel exposes the device memory as an HPA-backed VFIO region, traps
the HDM decoder block and runs its lock-on-commit FSM, handles the CXL
DVSEC (including a guest-triggered reset), and reports two things through
VFIO:
  - A device flag (VFIO_DEVICE_FLAGS_CXL), and
  - The component-register geometry (VFIO_REGION_INFO_CAP_CXL_COMP_REGS).
That series in turn builds on the cxl_reset series [3].

Status of the kernel side: v5 is on-list [2]; rebased onto cxl_reset [3]
and addressed the v4 review comments. This QEMU series depends on the VFIO
uAPI above (patch 1 imports it) and on the kernel servicing fd read/write
on the HDM memory region, which QEMU uses as the fallback when the region
is not mmap'd. Both are part of the same vfio-cxl series and are stable
across those revisions.


Sample supported topology
-------------------------

Guest disk, network, and system-RAM lines are omitted:

  -machine virt,accel=kvm,gic-version=3,hmat=on,cxl=on,ras=on, \
           highmem-mmio-size=4T
  -object iommufd,id=iommufd0
  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1
  -device cxl-rp,port=1,bus=cxl.1,id=rport0.1,chassis=4, \
          pref64-reserve=2G,mem-reserve=1G
  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=256G
  -device arm-smmuv3,primary-bus=cxl.1,id=smmuv3.0,accel=on,ats=on, \
          ril=on,ssidsize=8,oas=48
  -device vfio-pci-nohotplug,host=<BDF>,bus=rport0.1,id=dev0, \
          iommufd=iommufd0
  -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2
  ... (one acpi-generic-initiator per guest NUMA node the HDM memory backs)


Address model
-------------

The kernel fixes device memory to a host physical range before the guest
sees the device, and hardware presents a firmware-committed, locked
endpoint HDM decoder whose registers hold that host physical base.

QEMU never exposes the host physical base. It virtualizes the decoder base
registers in the trapped component-register read and returns the base of
the device's CFMWS window, a guest physical address, so the guest only
ever sees a GPA. QEMU maps the RAM-device region (backed by the fixed HPA)
at that CFMWS base. The kernel never learns the GPA and the guest never
learns the HPA.

Because the decoder is already committed at boot, no guest commit write
triggers the mapping. QEMU maps once the guest enables memory decoding
(the Command register Memory-Space bit) and re-checks on any decoder
control write, so the region enters the guest address space and the IOAS
while the device is live.

When the guest clears Memory-Space, QEMU withdraws the mapping, matching
the kernel's revoke of the backing PTEs on the same write, so a guest
access during the disabled interval cannot fault a zapped mapping and stop
the VM; the enable path re-installs it.

The pxb-cxl _DSM is here because an OS may treat PCI configuration as
reassignable, and a BAR move would break the CXL.mem mapping. It applies
only to the host bridge that carries the passed-through CXL device.


Reset
-----

There is no QEMU reset patch. A guest CXL reset is a DVSEC write that
lands in vfio config space and is handled by the host kernel, which runs
the CXL reset sequence and stamps the outcome into DVSEC STATUS2. The
kernel re-commits this firmware-fixed decoder across the reset, and the
guest reaches its memory through the mapping QEMU already installed.


Changes since v1
----------------

All from Junjie Cao's v1 review:

  - The _DSM is emitted only when the machine asks OSPM to preserve the
    firmware PCI configuration (preserve_config). x86 q35 passes false, so
    its DSDT is unchanged and the bios-tables golden files stay valid.
  - The endpoint count counts every present function, not one per slot, so
    two functions cold-plugged at one slot no longer bind and map the same
    window at the same base.
  - The unrealize path (vfio_exitfn) drops the CXL mapping, so an ACPI
    eject no longer leaves the vfio fd held through the region's owner
    reference.
  - The decoder-count read uses the shared cxl_decoder_count_dec() helper
    with a floor of 1, instead of a local switch that stopped at 4 decoders.
  - On commit, a guest decoder base that differs from the CFMWS base is
    refused and logged rather than mapped at the window base regardless.
  - The hotplug validation branch moved into the patch that registers the
    machine-init-done notifier, so no intermediate commit can exit(1) on a
    bad device_add.


AI assistance
-------------

Parts of this series were drafted with the help of an AI coding assistant:
the code was AI-prototyped, then reviewed, edited, and rewritten by me,
and the documentation was drafted the same way. The assistant was also
used to research the existing vfio and CXL APIs. I built the series and
functionally tested it against real CXL Type-2 hardware. I take
responsibility for the whole of every patch and certify it under the
DCO via Signed-off-by. The patches carry AI-used-for: trailers,
"code (prototype)" or "docs", per QEMU's code-provenance policy.

This series adds new passthrough code, which is outside the mechanical,
small-bug-fix, docs, and tests categories the policy covers without prior
maintainer agreement. I am flagging that here rather than assuming it is
in scope.


Validation
----------

- Every patch passes scripts/checkpatch.pl --codespell --strict (patch 1
  carries the expected imported-from-Linux header warning).
- The series applies cleanly on the stated base.
- Built and functionally tested against a CXL Type-2 device: guest boot,
  decoder commit and mapping, and guest-triggered CXL reset.


Pending items
-------------

- Multi-decoder, interleaved, and switched topologies are future work.
- Trapped CXL RAS registers are planned as a new VFIO region subtype that
  the existing region-by-subtype detection already handles.
- The bios-tables test refresh is not needed now that the _DSM is gated on
  preserve_config.


References
----------

[1] [PATCH 0/10] QEMU: CXL Type-2 device passthrough via vfio-pci
    https://lore.kernel.org/qemu-devel/20260813130623.2499506-1-mhonap@nvidia.com/
[2] [PATCH v5 00/27] vfio/pci: Add CXL Type-2 device passthrough support
    https://lore.kernel.org/linux-cxl/20260916183540.3813685-1-mhonap@nvidia.com/
[3] [PATCH v12 00/12] PCI/CXL: Add CXL reset support for Type 2 devices:
    https://lore.kernel.org/linux-cxl/20260910070808.1444264-1-smadhavan@nvidia.com/


Manish Honap (10):
  linux-headers: Update vfio.h for CXL Type-2 passthrough
  hw/vfio/region: Add vfio_region_setup_with_ops()
  hw/vfio/pci: Detect a CXL Type-2 device and read its geometry
  hw/vfio/pci: Enforce the passthrough topology for a CXL device
  hw/vfio/pci: Back the CXL memory with a RAM-device region
  hw/vfio/pci: Bind a CXL device to its fixed memory window
  hw/vfio/pci: Map the CXL memory on the guest decoder commit
  docs/cxl: Document CXL Type-2 device passthrough
  hw/arm/smmu-common: Allow pxb-cxl as an SMMUv3 primary bus
  hw/pci-host: Emit a _DSM on pxb-cxl to preserve firmware PCI config

 docs/system/devices/cxl.rst               |  45 ++
 hw/acpi/Kconfig                           |   1 +
 hw/acpi/cxl-stub.c                        |   2 +-
 hw/acpi/cxl.c                             |  12 +-
 hw/acpi/pci.c                             |  40 ++
 hw/arm/smmu-common.c                      |  19 +-
 hw/cxl/cxl-host-stubs.c                   |   5 +
 hw/i386/acpi-build.c                      |   2 +-
 hw/pci-bridge/pci_expander_bridge_stubs.c |   6 +
 hw/pci-host/gpex-acpi.c                   |  42 +-
 hw/vfio/pci.c                             | 745 ++++++++++++++++++++++
 hw/vfio/pci.h                             |  27 +
 hw/vfio/region.c                          |  27 +-
 hw/vfio/vfio-region.h                     |   3 +
 include/hw/acpi/cxl.h                     |   2 +-
 include/hw/acpi/pci.h                     |   1 +
 linux-headers/linux/vfio.h                |  24 +
 17 files changed, 947 insertions(+), 56 deletions(-)

-- 
2.25.1

