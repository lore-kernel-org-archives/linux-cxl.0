Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BE30D414;
	Thu, 25 Jun 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406526; cv=fail; b=hujFZMwfzitgHaJbS8QzDCUsVMNexrRbJSibTYbAth/LeCNCWY+aV7kMF1y0CQxHfbLg8OEvseX9GevGVL1H4vA6K2JigUV1KkztcljyELF1jlM39gkmQ7WhRDo6s+se0AXyCjVgdRrH0i0vvHbkV31s7+IX4sNmBQXxjQAg7nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406526; c=relaxed/simple;
	bh=wxFWbQtSW68/x10AIp2yoFRK+KdxYuTjkkj1CDc9x0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Og4+KYtOxLOk+ijUj1lQHEaONJxZYFLpAJcRf5OZz3OaQEg26yXWEt/xm4eiYMlWmw4iObkk4eEACd2OCoM37ygdcuZtaIRpW0uY9cwWeWxUySnzwr8qCSZZBbIjdrssVc3cUuENilTNjwV5CYPZOD4ZyGzljoQgO4cE84tGLnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OVmp+EIE; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OVmp+EIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIDDodWUWz7OmGPNDRAHE3n5VcVLnVq2oRGbWwLQsIgGFf4ulN4hIR5CyamCgVcivnYp8/DVq8bbr3l3zt3nAClpoKYuY3w/Hd62aaA29ItIbCMQCzbvlSXeIRkB4x+8cx5ehHXQ5UQxp5ZVdwOVSjt8DO0vxASQofIBiartL6nIsdgAmIwtzuoVBnQzTCTVeqt9yg+p8NV+9T+URedZ9GfwwoFAFIqSfePpL3xXrG3C+WFRoLoLi2sVFHMHqjUgGyQf+HNS84oV9T/YBJAHL1WsicPwpKtaU5ksxGwgFBhzlt67aQYIYzGxVlSj6ZXe1WvXcJFlp55DXbKJe8Odtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOA2vTtpn+2td4ugiRxrq+VQt5ksTYtUzw6gpnRXosk=;
 b=p2Ga75Tc7wQtmD1TA9N6ao1BuF2u+U/DSplsnWl0cYyaoGEA8bvU6yQIppkBfYse5xSdtD9m2ZfNisz84xBsLkjKwrkIrO8XYsBtQE6RewKW9s+ehUyCsDSad5TBiVkZXaQ6BpO242VTfc0hLkgVUu0LfUCTstGoSGVBHnMnSie2nmMbHWkT1P6krA7iuSRS4xaLe1/yOI8HqKHGcxwnKedcyykU9TBBJRjdnNR/VC1IJrYLUIfe/Qopd4AdcjOZcHbOzCcTgH3FbUojMBK5rmYQb1x9ye2lY07EDH4CtYAL1HPYXEY/C+kM1XOKbKtvjvUR3rinVH4dMRxrguIdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOA2vTtpn+2td4ugiRxrq+VQt5ksTYtUzw6gpnRXosk=;
 b=OVmp+EIENS+pGYQ8TRX0ePPNmC2H5SfYaOCoe1KYLnSGrmcuQlMKIV+GVs+vPfg8sIMOxQH0G+BmAgTGG3ZfPARv1dLGYePdw8BRHYNwPujvHZSjHODJmefZoowSD//20GF/P4mE9NS8TS/FPUKhSobQyIDUs29KF5TKzIKH+by31so1KQh6bYPyQgSebXNiijFEpCGopMS4atFHpY9WKo8gHSPhWIaCanOVRYJrgQb0jOyNcAXZxmfVvmPtJDMZ17PHOWQFUxsyHCKegOOeqjf4weseonMV8amOB5KgYkVjThPsRrWjqLW56kH3kM/ZgoAWm2EGz/+KidvWm6MghQ==
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Thu, 25 Jun
 2026 16:55:11 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::7c) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 16:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:55:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:54:44 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:54:36 -0700
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
Subject: [PATCH v3 00/11] vfio/pci: Add CXL Type-2 device passthrough support
Date: Thu, 25 Jun 2026 22:23:56 +0530
Message-ID: <20260625165407.1769572-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9d75ae-69ea-42c0-7ac6-08ded2da8532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|3122999024|13003099007|18002099003|921020|6133799003|5023799004|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8iKURhBExa8ayHiMwOSqvCJkxqoU5Z/q2TnNCD1ZzU2mAqHZY1RyRQifKqwJohBGJ+eqTAqInaXMHunSoG2GEVbrKfZwn6e7uD1Lqn8+Apdnw1g/zEYCN5gKKJelbicg1sNasNcbMbmD9L2SMNEqxxnf7PGKs3eBQq3BhPtbRmBh5Lq75uz0vLXwsfpwyXIIryIXVh7Kl9WcLua3BQS/9DX3QFEIRfMDHk84ZUCiYIMu9y/Bjw5q/I/FnNTeG02JC4kjwHaMW5C/t5KC4E7SjIDWhRbkysbp2JokXXN5NQwiUUGDDGUu+GkgjqKHO+qAPjGc9xB8sfW2mppz4SLJP6vOwZ6eBYKj7MmFBl5w4wE2FIqcIw+f39qKq+Ftx/+HWnN5VOlN48o2jDBeL6HvhIdmnsbXzTaMluVmnSmCn5u1dt4HfP6xr6Wz0FJBY2qsP1BLh4I/L1d3uVg378wg/z9DJyAclokiuvcCX0UuQubvIrDALg4p16aWIM91N0SkL+5D4QuVaFPgQHgLQge9tYDbXhgV8hboPQJZGnqrUX29eINvTmAoSJsnxQUNcOgMHRm8lS+IPaBbcpfk0AOlfOA2C77BM9TyPCmrpMOza6tXxNmrmcYTmO/oWCm8LhZKJC0vsLi/rGEhDZ5GHaHpy+wAnHQvwR1HWHuyTI/UfUU6UOI0AQQ3vlRlp4jMkXosAc7d1wagniTJgzbcfjBx5El1Qrvs3JOKo4b1GOW8pRMIjxG5dmYkTXHkuLXZBFZu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(3122999024)(13003099007)(18002099003)(921020)(6133799003)(5023799004)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7c8KzzLTy6COIkqGgABVpSn+E5RY2HulCelVGZl/8kzWKS+pqEq1SbTpCAEkQPTIx2Va1V01+PuFJNyhC2iD/2jejlKqLuVGvZRCh8dYsX37+hBa+Kyqu25GqiEFo8/KpGJVbbIADb1Uet6NUmzg8+7Pjk2xOv2D7aA20ExiLvxg9DM2/2UCq5dYxKzPn0g8eBV4wk+d6GIY9PMjJlxh01vUgfjbFoRvdQ36PpuPqm0Ks73dYBY/FzKl8ASwf87MCtDA/3ft13ZpHtBezUBZ5TEse+iStP888zKd7RWY0ndfS/rp6dIKWLMhVbEtj8dUTWM8q2wq34mH8oIlUMBVDdOfOdUC0APtf4nhumZDn//4pdtzSyhTemBsd6QM4xctzuFNcM31W+O9BE0nNLTnsyPgR4zirEH+MtcoKESmUemgJEtj5ThXlCNB3ng+k4cB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:55:11.0729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9d75ae-69ea-42c0-7ac6-08ded2da8532
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

From: Manish Honap <mhonap@nvidia.com>

CXL Type-2 accelerators (CXL.mem-capable GPUs and similar) cannot be
passed through to virtual machines with stock vfio-pci because the
driver has no concept of HDM decoder management, HDM region exposure,
or component register virtualization.  This series adds those three
pieces, sufficient for a guest to use the device's firmware-committed
coherent memory under UVM / ATS.

v3 is a rewrite of the v2 framework form, responding to Dan's request
in the v2 review for "less emulation, narrower interfaces, and a
closer mapping to the spec language."
In this release, cxl-core exposes four EXPORT_SYMBOL_GPL helpers behind
an opaque handle.  vfio-pci becomes a thin transport on top of those.
Please see "Changes since v2" and "Reviewer feedback addressed" below for
the per-area summary.

Motivation
==========

A CXL Type-2 device exposes its HDM-mapped device memory through HDM
decoders that BIOS programs and commits at boot.  To pass such a
device to a guest, vfio-pci has to do three things at once:

  1. Surface the firmware-committed HDM-mapped HPA range as a guest-
     mmappable region.

  2. Surface a CXL-spec-compliant view of the CXL Device DVSEC body,
     the HDM Decoder Capability block, and the CXL.cache/mem cap-array
     prefix, so the guest's CXL driver enumerates the same topology
     the host saw.

  3. Keep the host's committed decoder configuration intact (the
     physical decoder is never reprogrammed) while letting the guest
     observe and manage a shadow that follows the per-field write
     semantics in the spec.

The series builds on Alejandro Lucero-Palau's v28 work
applied on for-7.3/cxl-type2-enabling [1] (sfc is the in-tree consumer
today). vfio-pci becomes the second consumer.

Architecture
============

cxl-core owns the CXL semantics.  A new file
drivers/cxl/core/passthrough.c (gated by hidden Kconfig
CXL_VFIO_PASSTHROUGH) provides four exported symbols:

    struct cxl_passthrough *
    devm_cxl_passthrough_create(struct device *dev,
                                struct cxl_dev_state *cxlds);

    int cxl_passthrough_dvsec_rw(p, off, val, sz, write);
    int cxl_passthrough_hdm_rw  (p, off, val,      write);
    int cxl_passthrough_cm_rw   (p, off, val,      write);

cxl_passthrough is an opaque handle; vfio-pci sees no cxl-internal
struct pointers.  The shadows are snapshotted at create time: the
DVSEC body from PCI config space dword by dword, the CM cap-array and
HDM block from the cxl-core MMIO mapping at cxlds->reg_map.base.
Per-field write semantics follow below:
CXL r4.0 8.1.3 DVSEC:
- LOCK is RWO,
- CONTROL/CONTROL2 are RWL gated on CONFIG_LOCK,
- STATUS/STATUS2 are RW1C,
- RANGE1 is HwInit, RANGE2 is RsvdZ
CXL r4.0 8.2.4.20 HDM:
- GLOBAL_CTRL RW,
- decoder CTRL implements COMMIT/COMMITTED,
- decoder BASE/SIZE RWL gated on COMMITTED or LOCK_ON_COMMIT,
- cap header HwInit).

vfio-pci becomes a thin transport.  The new module
drivers/vfio/pci/cxl/ exposes two VFIO regions.

  VFIO_REGION_SUBTYPE_CXL (HDM region): mmappable view of the
  HDM-mapped HPA. The mmap fault handler calls vmf_insert_pfn() from
  the physical HPA. pread/pwrite go through the memremap_wb() kva
  captured at bind time.

  VFIO_REGION_SUBTYPE_CXL_COMP_REGS (component register shadow):
  pread/pwrite only, dword-aligned (-EINVAL on misalignment).
  Each dword dispatches by offset to cxl_passthrough_cm_rw() or
  cxl_passthrough_hdm_rw(). No shadow state on the vfio side; cxl-core
  enforces the spec.

CXL DVSEC config-space accesses use a clipping shim in
vfio_pci_config_rw_single(). A config-space chunk that crosses the
DVSEC body boundary is split: header bytes go through the generic
perm-bits path, body bytes go through cxl_passthrough_dvsec_rw().
The shim replaces v2's approach of repointing ecap_perms[]

Sparse-mmap is exposed on the component BAR so userspace can mmap the
non-component portions directly; only the CXL component register
sub-range goes through pread/pwrite emulation. The CXL sub-range is
also skipped from vfio_pci-core's request_selected_regions() set
because cxl-core's devm_cxl_probe_mem() already holds a
request_mem_region() on it; the asymmetric skip is matched by an
asymmetric release on disable().

Scope and out-of-scope
======================

In scope (rejected at create time with -EOPNOTSUPP otherwise):

  - Firmware-committed devices (HOST_FIRMWARE_COMMITTED set).
  - Single HDM decoder (hdm_count == 1).
  - No interleave (IW == 0).

Out of scope, deferred for follow-on work:

  - Multi-decoder devices and interleave.
  - Guest-driven (non-firmware-committed) HDM commit.
  - Hotplug, FLR, and sibling-function reset of CXL Type-2 devices.

Changes since v2
================

This is a rewrite, not an incremental update.  The structure of the
series changed (20 patches in v2 to 11 in v3) because v3 collapses
v2 patches 9-15 (detection, HDM emulation, media readiness, region
management, HDM region, DVSEC emulation) into one cxl-core helper
file and one vfio-pci consumer.

Framework replaced by narrow opaque-handle helpers (patches 6, 8)

  v2 carried a generic register-emulation framework split across four
  state-machine files in cxl-core.
  v3 collapses it into one file: drivers/cxl/core/passthrough.c
  exposing the four EXPORT_SYMBOL_GPL helpers above behind a struct
  cxl_passthrough opaque handle.

Shadow ownership moved into cxl-core (patches 6, 8)

  vfio-pci no longer keeps any per-field state. It forwards
  (offset, value) into cxl-core, and cxl-core enforces the spec
  (RWO, RWL, RW1C, HwInit, RsvdZ) with explicit CXL r4.0 section
  references in the switch arms.

DVSEC config-space clipping shim (patch 8)

  v2 repointed ecap_perms[] to redirect CXL DVSEC reads and writes.
  v3 keeps ecap_perms[] untouched and clips per-config-access chunks
  at the DVSEC body boundary in vfio_pci_config_rw_single(); header bytes
  go through the generic perm-bits path, body bytes go through
  cxl_passthrough_dvsec_rw(). The shim is local to the per-device
  path.

CONFIG_VFIO_PCI_CXL gates the new module (patch 7)

  v2 had a CONFIG_VFIO_CXL_CORE Kconfig stub; v3 renames it to
  CONFIG_VFIO_PCI_CXL to match the vfio-pci naming convention.
  The hidden CXL_VFIO_PASSTHROUGH selects the cxl-core helper file
  on demand. With both disabled, the cxl-core size is unchanged.

UAPI rewritten with named fields (patch 5)

  vfio_device_info_cap_cxl in v3 carries:
    flags + HOST_FIRMWARE_COMMITTED bit
    hdm_region_idx
    comp_reg_region_idx
    comp_reg_bar
    comp_reg_offset
    comp_reg_size
  The DPA terminology is renamed to HDM region throughout.
  CACHE_CAPABLE (HDM-DB indicator) is dropped;
  it was informational only in v2 with no caller, and re-adding it
  for an active CXL.cache plumbing series later.

Selftests trimmed (patch 9)

  v2 carried selftests for device detection, capability parsing,
  region enumeration, HDM register emulation, HDM mmap with
  page-fault insertion, FLR invalidation, and DVSEC register
  emulation. v3 keeps a smoke-test set of six focused tests:

    device_is_cxl                  GET_INFO advertises FLAGS_CXL
                                   and a populated CAP_CXL.
    hdm_region_mmap_rw             mmap one page, write+read back.
    component_bar_sparse_mmap      SPARSE_MMAP cap excludes the
                                   CXL component register sub-range.
    comp_regs_cm_cap_array_read    pread of the CM cap-array
                                   header at CXL_CM_OFFSET succeeds
                                   (CAP_ID == 1).
    dvsec_lock_byte_read           pread of the DVSEC CONFIG_LOCK
                                   byte through the clipping shim
                                   succeeds.
    hdm_decoder_commit_fsm         COMMIT / COMMITTED state machine
                                   and LOCK_ON_COMMIT behaviour.

  FLR invalidation, page-fault insertion under load, and full
  DVSEC field-by-field write coverage are deferred to a follow-on
  selftest series. The current six are the minimal set that
  exercises the kernel-side contract end-to-end.

cxl-core prep patches split (patches 1-4)

  v3 keeps the cxl-side enablers from v2 patches 1-4 but each as
  a standalone change so the cxl maintainer can review the helper
  API independently of the vfio consumer:

    [1/11] cxl_get_hdm_info()
    [2/11] cxl_await_range_active() split from media-ready wait
    [3/11] cxl_register_map records BIR + BAR offset
    [4/11] component/HDM register defines moved to uapi/cxl/cxl_regs.h

Reviewer feedback addressed
===========================

Dan
---

- VFIO exposes HDM/host-visible region, not raw DPA; docs/UAPI say HDM
  region, DPA only inside cxl-core where appropriate.
- One vfio-pci device = one HDM region / one decoder, no interleave;
  hdm_count != 1 → -EOPNOTSUPP.
- Global HDM on DVSEC Range Base treated as legacy; RANGE1/RANGE2
  read-only snapshot, guest writes dropped.
- No guest/kernel lock games; DVSEC LOCK and HDM LOCK_ON_COMMIT RWO,
  fixed at create from firmware snapshot.
- Opaque cxl_passthrough handle only; vfio gets HPA via memdev probe +
  layout via cxl_get_hdm_info(), rw via helpers.
- No multi-region accelerator case in v3; single region enforced,
  multi-region deferred.
- cxl_await_range_active stays in cxl-core probe; not exported, vfio does
  not call it.
- No guest LOCK→0 reprogram; guest cannot clear LOCK to remap host HPA;
  kernel uncommit tied to COMMIT, not LOCK alone.

Jason / Gregory / Dan
---------------------

- memremap(WB) + request_mem_region on HPA; conflicting direct-map/EFI use
  fails probe with -EBUSY.

Jonathan
--------

- uapi/cxl/cxl_regs.h for register defines so VMMs need no private
  kernel headers.
- __free() locals on cxl-core/passthrough error paths instead of
  struct-owned temporaries.
- No "precommitted at probe" assumption; acquire checks COMMITTED in
  HDM shadow and refuses if missing.

Dave
----

- memremap(MEMREMAP_WB) for HDM host mapping (not ioremap_cache).
- Renamed cap flag to VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED for clarity.
- __free() / DEFINE_FREE() cleanup in new passthrough.c create path.

Patch series
============

 [1/11] cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
 [2/11] cxl: Split cxl_await_range_active() from media-ready wait
 [3/11] cxl: Record BIR and BAR offset in cxl_register_map
 [4/11] cxl: Move component/HDM register defines to
        uapi/cxl/cxl_regs.h
 [5/11] vfio: UAPI for CXL Type-2 device passthrough
 [6/11] cxl: Add register-virtualization helpers for vfio Type-2
        passthrough
 [7/11] vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2
        acquisition
 [8/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping
        shim
 [9/11] selftests/vfio: Add CXL Type-2 device passthrough smoke test
[10/11] docs: vfio-pci: Document CXL Type-2 device passthrough
[11/11] vfio/pci: Provide opt-out for CXL Type-2 extensions

Dependencies
============

[1] [PATCH v28 0/5] Type2 device basic support
https://lore.kernel.org/linux-cxl/20260618181806.118745-1-alejandro.lucero-palau@amd.com/

[2] Previous version of this patch series
[PATCH v2 00/20] vfio/pci: Add CXL Type-2 device passthrough support
https://lore.kernel.org/linux-cxl/20260401143917.108413-1-mhonap@nvidia.com/

[3] Companion QEMU series
[RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
https://lore.kernel.org/linux-cxl/20260427181235.3003865-1-mhonap@nvidia.com/

Manish Honap (11):
  cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
  cxl: Split cxl_await_range_active() from media-ready wait
  cxl: Record BIR and BAR offset in cxl_register_map
  cxl: Move component/HDM register defines to uapi/cxl/cxl_regs.h
  vfio: UAPI for CXL Type-2 device passthrough
  cxl: Add register-virtualization helpers for vfio Type-2 passthrough
  vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2
    acquisition
  vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping shim
  selftests/vfio: Add CXL Type-2 device passthrough smoke test
  docs: vfio-pci: Document CXL Type-2 device passthrough
  vfio/pci: Provide opt-out for CXL Type-2 extensions

 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst     | 282 ++++++
 drivers/cxl/Kconfig                           |   7 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/passthrough.c                | 590 ++++++++++++
 drivers/cxl/core/pci.c                        |  70 +-
 drivers/cxl/core/regs.c                       |  35 +
 drivers/cxl/cxl.h                             |  52 +-
 drivers/vfio/pci/Kconfig                      |   2 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/cxl/Kconfig                  |  34 +
 drivers/vfio/pci/cxl/Makefile                 |   2 +
 drivers/vfio/pci/cxl/vfio_cxl_core.c          | 889 ++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h          |  71 ++
 drivers/vfio/pci/vfio_pci.c                   |   9 +
 drivers/vfio/pci/vfio_pci_config.c            |  31 +
 drivers/vfio/pci/vfio_pci_core.c              |  68 +-
 drivers/vfio/pci/vfio_pci_priv.h              |  93 ++
 drivers/vfio/pci/vfio_pci_rdwr.c              |  17 +
 include/cxl/cxl.h                             |  18 +
 include/cxl/passthrough.h                     | 121 +++
 include/linux/vfio_pci_core.h                 |   8 +
 include/uapi/cxl/cxl_regs.h                   |  63 ++
 include/uapi/linux/vfio.h                     |  46 +
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  11 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 350 +++++++
 27 files changed, 2821 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
 create mode 100644 drivers/cxl/core/passthrough.c
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h
 create mode 100644 include/cxl/passthrough.h
 create mode 100644 include/uapi/cxl/cxl_regs.h
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658
-- 
2.25.1

