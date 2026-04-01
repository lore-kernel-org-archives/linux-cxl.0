Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA43F87E6;
	Wed,  1 Apr 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054401; cv=fail; b=rIMhLS8G19zj78eLzVILnuWlyLOFR0DtOx1yinEqHk6v8ECo1rXreCq9NA3IdUD1UnliQcd2ovpj717iA5mJL90JL5QJ7J4xijqClq9h0OQESQsEaup6EeXPkf5CpcCg3CZOsxXC3b6MGxbbuS4oZC9m4j/7dmHnq8DhkZAMVA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054401; c=relaxed/simple;
	bh=HPGZXM0Vt2OlBfeJ8r0woahYLQ7puV4ilCM8nqZrmYA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELkk8WUcLW+CLcx94RM/mK5iuY7+odbmscLPxRUc1ju63H5IxR0RkoJBxKti79mmg+qY4i1lTldym19UhsdhayI5vc7QllaG05nEEZrGK13qLS75PN9W24CHAiS13cH+xDrLQME3dGs7KQ2Clx3p9XJQGwMp+MK8c65aDFA7niU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=br7hT6CV; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="br7hT6CV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGDvuiK9rKZhm7qqz6xf1qA+/mDN4TYMreoO4o3QMW0j06IVPH/W6i0l1c5gNmD0MV5K8LtIBwtjpYk34bI0KT7QUrK9gvUwmImF85PxEHukGnqecYkOm8pykfJJ9lErYEhQbic14oZ5F8eQvGX8ASXS5rwH4PRTTLPxFS1cQzshEZG0pLDEjyarqLcWUNBBviSnQI1narbOI66dxmkHww7/cj4ZRJQxLlxegTZdufNHsbjDx0fv/FuxWr96WOi/Y49QhWWQMSFUB6f7zrODfvbi5Gcx0tmUiZXpuk7QvhZCZbacf+50ERL0CFlM2cmetRMd1TtX5IMw+VKbx57wvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeEo5FRlftbxewezpZVAJOlG3Q9rri5gxLOSiVzPTKI=;
 b=ZGg0wlKbKtzQcN6rIhiPnxrHjm0U/3t4BYDoKBqtpF28/TtO6POMHN4hdSa1RTX3Qp3IV9CoH5U+wA3QKXu1Q+A5Iwu4S3KAqq99VrTY6Axb0kWqMezz/XRiUeid3aedNothGQLgzmyI0Xik7OXfSnuIknk8QUVYBRFg777KmdZ006G2tVhFNJIzCaCfv75qCi3dADrwfjDOJa5Wrvuf8gmMr+akt2VmyNrbo9cftIgaUletLxo/CUlZJpxCe3qm2YuKb+LuFsSc9UpCfmH9+oPUAuMBq649JcWEHpIBJk7ENBRbu2gMsozSDwgZUAWrDfwLz1GBORmQoJrb6xzvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeEo5FRlftbxewezpZVAJOlG3Q9rri5gxLOSiVzPTKI=;
 b=br7hT6CVxYQdFl2Iwp+RPGQ6mP36HhGJ4jhhrHUkLpDmmOcO6U2XtdLOsfrFH38cTjrxY9TCXFNFut73o4iZir3V6JFQUBaRYdqFRYeVirGFUaCNotPGA9GvGiHzru9qaVCXmBi86kaGOe2HVk8AkZKoHQHoXPEi/nJ1aFDxhz02mIzO1YyW0/bW2j6iIn9EoZAfeD0E9TxoXLSjqWqRFM6/JCekZqleXQXmaZ25sWs3TO1j7UGky3MstSZscBtM8sACuwKAehjT2nNH93pZUiqZssgqMG6fsmp9fOXK9tjxSDH4hkUqLNF926FPhOYzD4wDrWFaHB1kowxQ6caLtg==
Received: from BY5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:1d0::22)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:39:55 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2d) by BY5PR04CA0012.outlook.office365.com
 (2603:10b6:a03:1d0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 14:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:39:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:39:40 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:39:32 -0700
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
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/20] vfio/pci: Add CXL Type-2 device passthrough support
Date: Wed, 1 Apr 2026 20:08:57 +0530
Message-ID: <20260401143917.108413-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1be4ab-1a26-4741-63c7-08de8ffc8a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|3122999024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XFbCmhyjZuwe+073WjT1xBfanFf4V4j44nzha4rqQeHJU4P7l4Y5sX9um36kp3r9ciXrF4bifdVLY2YGZmMwYBlmCgtmhcHpNb7Y2OrpZozMdpQu0IANLFThBjFnWxV1GohwIfj+7bgV+vbsMLhyewQlipY7Cud5l3zOvhhT8CyvQSsPO2tiXB6zIb8oaGvLZzIGZyraCo/NKKaLIjAExKQzR4ugZRKtsSSJOwLnNKmO/0dqXhODZhGVtPFMrVmuSf4N68u0V+4kj6nzLBJMwraFNVzcqLAwLh1Hi5508Ojbnmf4StPrYkc2ySegCy5JqYB1Vn9Ixev2IzCw7yTcKOl8A8JUn/1VM4up0hEep/ioUBu7YB6Kkw2ImITOfXjNZxOQZsknUavkhcpvo+bpzmiekmBdbi+QW9rT1RZJ1nZqQfABlVIJfytLB9pWcMkA8mzTXXs3SMnsF6/FDtZisA1FZ7paUbzeGIhn/kyIS9TfedzDtW/FhCT96tI/J98xrhn3odChcczEfGWdL8FsJzmbKGmRpwwan6RepM/eZHq6qSut8yO8t/7QUeZ7+1uPAs5xwPDH2A4FZ7Wc/DQRD7b81nHv7LA+3mcEB9jxDhF80EWjfnfRJVqsv2Jq4SvyJ8pAIe6VbhiiyR++EeFT+fcyOMbkfZh6Xw5Pv0QrSEzHNEjIzHMFXmNcfcl9KKo/p2KPNqYjBxnwScmFzM5s85ADYLRqRLIZgA42kv7eaum58Mrt4xV4PgeUivukwoCVzFn08ZQyJ7Z1HaYqrE911ft5bNOz4g5TfRF/Mx743A8UOZbVDIioZX1uAPageWX6AFwGl9oIEnXvNqYg2bU9EA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(3122999024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MMdGoeQI7IDUtBDWLAO6Z9a8AOl0kH13aDd33GnkkAOv1xnGMz0ymq5ieOkbSeeLALJ0XbFLClG1YLp/++qmnLpy0jncBulIg4SWjRnzIzRwjrFg+24CHOkuMY6PshD0NUAdX5jbiN4UZT8XG1h2JkEjwsk8pv3IUiHmOeK5JqoxyMNmj7Mku3pgV+3qIF0RZmopkuO/iStfkUsC08CISkmrXFuIq1huFM/dvUj2KPo7W3akrhLC/G7se6lsO0qk9svX1RXhjEymJZcpvDYedG/qUoSzapOZBbX8FS1t0jKcSPPjwUlxFffWu+jAHxeaep4dVgXBj4zmmAt7V0R6n/TWYhbnsjPNHKy3+uWeF2Ny/5yI0wZ2fFfeN6UKYHYYLVN5rPkc5Qu6u2MbONEXtF9txbn0GzmyII7/vwWMSid5x3ELxJcZJWho+3/8IFDC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:39:54.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1be4ab-1a26-4741-63c7-08de8ffc8a52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812

From: Manish Honap <mhonap@nvidia.com>

CXL Type-2 accelerators (e.g. CXL.mem-capable GPUs) cannot be passed
through to virtual machines with stock vfio-pci because the driver has
no concept of HDM decoder management, DPA region exposure, or component
register emulation.  This series wires all of that into vfio-pci-core
behind a new CONFIG_VFIO_CXL_CORE optional module, without requiring a
variant driver.

When a CXL Device DVSEC (Vendor ID 0x1E98, ID 0x0000) is detected at
device open time, the driver:

  - Probes the HDM Decoder Capability block in the component registers
    and allocates a DPA region through the CXL subsystem.  On devices
    where firmware has already committed a decoder, the kernel skips
    allocation and re-uses the committed range.

  - Builds a kernel-owned shadow of the HDM register block.  The VMM
    reads and writes this shadow through a dedicated COMP_REGS VFIO
    region rather than touching the hardware directly.  The kernel
    enforces CXL 3.1 bit-field rules: reserved bits, read-only bits,
    the COMMIT/COMMITTED latch, and the LOCK→0 reprogram path for
    firmware-committed decoders.

  - Exposes the DPA range as a second VFIO region (VFIO_REGION_SUBTYPE_CXL)
    backed by the kernel-assigned HPA.  PTEs are inserted lazily on first
    page fault and torn down atomically under memory_lock during FLR.

  - Intercepts writes to the CXL DVSEC configuration-space registers
    (Control, Status, Control2, Status2, Lock, Range Base) and replays
    them through a per-device vconfig shadow, enforcing RWL/RW1CS/RWO
    access semantics and the CONFIG_LOCK one-shot latch.

  - Returns a VFIO_DEVICE_INFO_CAP_CXL capability (id=6) carrying the
    HDM register BAR index and offset, commit flags, and the indices of
    the DPA and COMP_REGS regions.  HDM decoder count and the HDM block
    offset within COMP_REGS are derivable by the VMM from the CXL
    Capability Array in the COMP_REGS region itself, so they are not
    duplicated in the capability struct.

  - Builds a sparse-mmap capability for the component register BAR so
    VMMs can map GPU/accelerator register windows while the kernel
    protects the CXL component register block.  Three physical layouts
    are handled: component block at the BAR end, at the start, and in
    the middle.

  - Provides a module parameter (disable_cxl=1) and a per-device flag
    (vdev->disable_cxl) for suppressing the feature without recompiling.

  - Includes selftests covering device detection, capability parsing,
    region enumeration, HDM register emulation, DPA mmap with page-fault
    insertion, FLR invalidation, and DVSEC register emulation.

The series is applied on top of the cxl/next branch using the base
specified at the end of this cover letter plus Alejandro's v23 Type-2
device support patches [1].

Series structure
================

  Patches 1-5 extend the CXL subsystem with the APIs vfio-pci needs.

  Patches 6-8 add the vfio-pci-core plumbing (UAPI, device state,
  Kconfig/build).

  Patches 9-15 implement the core device lifecycle: detection, HDM
  emulation, media readiness, region management, DPA region, and DVSEC
  emulation.

  Patches 16-18 wire everything together at open/close time and
  populate the VFIO ioctl paths.

  Patches 19-20 add documentation and selftests.

Changes since v1
================

UAPI struct minimization (patch 6)

  v1 carried hdm_count, hdm_regs_size, hdm_decoder_offset, dpa_size,
  and a pad byte in vfio_device_info_cap_cxl. All four fields are
  derivable from data the VMM already has: hdm_count and the HDM block
  offset come from the CXL Capability Array in the COMP_REGS region,
  hdm_regs_size is implicit in the COMP_REGS region size, and dpa_size
  is the DPA region size.  v2 drops them and replaces pad with
  reserved[3].  The VFIO_CXL_CAP_PRECOMMITTED flag is gone; the single
  VFIO_CXL_CAP_FIRMWARE_COMMITTED flag covers both the committed and
  precommitted cases.  VFIO_CXL_CAP_CACHE_CAPABLE is added to expose
  the HDM-DB (CXL.cache) capability bit.

Component BAR access: sparse mmap instead of blanket rejection (patch 17)

  v1 returned size=0 for the component BAR and rejected all mmap and
  r/w access to it. That broke GPU passthrough scenarios where the
  device puts accelerator register windows in the same BAR as the CXL
  component registers. v2 replaces the blanket rejection with a
  sparse-mmap capability that advertises only the GPU register windows,
  carving out the component register block.  vfio_cxl_mmap_overlaps_comp_regs()
  rejects only the sub-range covering [comp_reg_offset, comp_reg_offset
  + comp_reg_size); everything else in the BAR remains mappable.

CXL register defines moved to uapi/cxl/cxl_regs.h (patch 3)

  v1 placed the component register defines in a private header
  (include/cxl/cxl_regs.h). v2 moves them to include/uapi/cxl/cxl_regs.h
  so VMMs can include them directly without duplicating definitions.

HDM API simplification (patch 1)

  v1 exported cxl_get_hdm_reg_info() which returned a raw struct with
  offset and size fields. v2 replaces it with cxl_get_hdm_info() which
  uses the cached count already populated by cxl_probe_component_regs()
  and returns a single struct with all HDM metadata, removing the need
  for callers to re-read the hardware.

cxl_await_range_active() split (patch 4)

  cxl_await_media_ready() requires a CXLMDEV mailbox register, which
  Type-2 accelerators may not have.  v2 splits out cxl_await_range_active()
  so the HDM range-active poll can be used independently of the media
  ready path.

LOCK→0 transition in HDM ctrl write emulation (patch 11)

  v1 did not handle the case where a guest tries to clear the LOCK bit
  to reprogram a firmware-committed decoder. v2 allows this transition
  and re-programs the hardware accordingly.

Component register buffer allocation (patch 11)

  v1 allocated only the HDM register sub-range in the COMP_REGS buffer.
  v2 allocates the full CXL_COMPONENT_REG_BLOCK_SIZE so future patches
  can expose other capability blocks (e.g. RAS, CXL.cache) without a
  structural change.

Register region setup split (patch 16)

  v1 tied region registration to the detection/init path.  v2 splits it
  into explicit vfio_cxl_register_cxl_region() and
  vfio_cxl_register_comp_regs_region() functions called from
  vfio_pci_open_device(), which is the correct point since vconfig and
  pci_config_map are valid there.

VLA fix merged into selftest (patch 20)

  v1 had a separate patch 20 fixing a VLA initialisation in
  vfio_pci_irq_set().  v2 folds that fix into the selftest patch to
  keep the standalone CXL change count at 19 functional patches.

Reviewer feedback addressed
===========================

Dave Jiang:
  - Replace open-coded bit shifts with FIELD_GET() / FIELD_PREP()
    throughout the HDM emulation code.
  - Rename flag from VFIO_CXL_CAP_COMMITTED / VFIO_CXL_CAP_PRECOMMITTED
    to VFIO_CXL_CAP_FIRMWARE_COMMITTED; the old names were ambiguous.
  - Use memremap(MEMREMAP_WB) for the DPA kernel mapping instead of
    ioremap_cache(), which selects the wrong memory-type descriptor on
    ARM64.
  - Use __free() / DEFINE_FREE() scope helpers for CXL resource cleanup
    in the region management path, replacing the open-coded error
    unwind.
  - Remove the unused abs_off parameter from the HDM accessor.
  - Rename cxl_dvsec_control_write() to better reflect its role.

Jonathan Cameron:
  - Move CXL register defines to uapi/cxl/cxl_regs.h so VMMs can
    consume them without a kernel header dependency.
  - Use local variables with __free() rather than struct members for
    intermediate ERR_PTR returns in the region management code; avoids
    ambiguity about ownership on error paths.
  - The assumption that a pre-committed decoder always exists at probe
    time is too restrictive for hotplug scenarios; v2 makes the
    precommitted path a fast-track that falls back to dynamic allocation
    when no committed decoder is found.

Alex Williamson:
  - The blanket size=0 / mmap-reject approach for the component BAR
    prevents VMMs from accessing GPU register windows in the same BAR.
    v2 implements the sparse-mmap capability described above.

Limitations and future work
===========================

  Switched topologies with more than one caching agent are not yet
  supported; that is planned for a follow-on series.

  RAS/ECC handling and CXL core reset integration (cxl_reset support
  from Srirangan [2]) will be added in subsequent patches.

Dependencies
============

[1] CXL Type-2 device basic support (Alejandro Lucero-Palau, v23):
    https://lore.kernel.org/linux-cxl/20260201155438.2664640-1-alejandro.lucero-palau@amd.com/

[2] CXL reset support for Type-2 devices (Srirangan Madhavan):
    https://lore.kernel.org/linux-cxl/20260306092322.148765-1-smadhavan@nvidia.com/

Cc: Alex Williamson <alex@shazbot.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Cc: linux-cxl@vger.kernel.org
Cc: kvm@vger.kernel.org

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>

base-commit: 3f7938b1aec7f06d5b23adca83e4542fcf027001
--

Manish Honap (20):
  cxl: Add cxl_get_hdm_info() for HDM decoder metadata
  cxl: Declare cxl_find_regblock and cxl_probe_component_regs in public
    header
  cxl: Move component/HDM register defines to uapi/cxl/cxl_regs.h
  cxl: Split cxl_await_range_active() from media-ready wait
  cxl: Record BIR and BAR offset in cxl_register_map
  vfio: UAPI for CXL-capable PCI device assignment
  vfio/pci: Add CXL state to vfio_pci_core_device
  vfio/pci: Add CONFIG_VFIO_CXL_CORE and stub CXL hooks
  vfio/cxl: Detect CXL DVSEC and probe HDM block
  vfio/pci: Export config access helpers
  vfio/cxl: Introduce HDM decoder register emulation framework
  vfio/cxl: Wait for HDM ranges and create memdev
  vfio/cxl: CXL region management support
  vfio/cxl: DPA VFIO region with demand fault mmap and reset zap
  vfio/cxl: Virtualize CXL DVSEC config writes
  vfio/cxl: Register regions with VFIO layer
  vfio/pci: Advertise CXL cap and sparse component BAR to userspace
  vfio/cxl: Provide opt-out for CXL feature
  docs: vfio-pci: Document CXL Type-2 device passthrough
  selftests/vfio: Add CXL Type-2 VFIO assignment test

 Documentation/driver-api/index.rst            |    1 +
 Documentation/driver-api/vfio-pci-cxl.rst     |  382 +++
 drivers/cxl/core/pci.c                        |   64 +-
 drivers/cxl/core/regs.c                       |   30 +
 drivers/cxl/cxl.h                             |   46 -
 drivers/vfio/pci/Kconfig                      |    2 +
 drivers/vfio/pci/Makefile                     |    1 +
 drivers/vfio/pci/cxl/Kconfig                  |    9 +
 drivers/vfio/pci/cxl/vfio_cxl_config.c        |  306 ++
 drivers/vfio/pci/cxl/vfio_cxl_core.c          |  880 ++++++
 drivers/vfio/pci/cxl/vfio_cxl_emu.c           |  509 ++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h          |  133 +
 drivers/vfio/pci/vfio_pci.c                   |   32 +
 drivers/vfio/pci/vfio_pci_config.c            |   58 +-
 drivers/vfio/pci/vfio_pci_core.c              |   46 +-
 drivers/vfio/pci/vfio_pci_priv.h              |   66 +
 drivers/vfio/pci/vfio_pci_rdwr.c              |   16 +-
 include/cxl/cxl.h                             |   51 +
 include/linux/vfio_pci_core.h                 |   10 +
 include/uapi/cxl/cxl_regs.h                   |  160 +
 include/uapi/linux/vfio.h                     |   86 +
 tools/testing/selftests/vfio/Makefile         |    1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |    3 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 2631 +++++++++++++++++
 24 files changed, 5459 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_config.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_emu.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h
 create mode 100644 include/uapi/cxl/cxl_regs.h
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

--
2.25.1

