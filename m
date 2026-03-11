Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06D345CAF;
	Wed, 11 Mar 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261327; cv=fail; b=B9l0wVZ0G7tr6ifg+fC4xySxBtfF8CxhFEArUmId/Cgv9JWOcN8RGSEzfIRV1u13oeGx10OsWHceAsxIg3AEy0dnqBpAbgbBvPqK29lles3CO18lCf+7XbMd8/8MepuAU/1UksjeMXegjjXCBxF5RJDGRJMW9kzgdDMHYRBqXuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261327; c=relaxed/simple;
	bh=CCoptU9NBkVwvzcMhPg6iCcmJLCPRE4D7CQ0CaSYnNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OARvWAAHwdxqBOuWHa8BGuT6C45lYICY3flzxO7Q2I3aszWlOOS/Oz2Elpq8dYFdwdWdxt/2OAqqOlPLizYYQAZI0HVV5GvR/kF5Cu3IxybQDygP2Xgeqt5qCDXE9MmQEOzo0Wjsd2uTgW98WsjVi37ZEsvWJFYktKfoaJvq6ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rz41WQxe; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rz41WQxe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3tqXLnTLen+HvkjVb3gmBWVoSlF3RdA9HlEGj6vEKYlMov2mKv0b0xswnfonSR/qFEMj4BIKOrXImk1f8snOrCHlH7sg2y7LhyONjQccxW8Fqe93VN/1AZYztGQPXsrTXcaRX7TboI+c8Zxgu/dDR3bs+sxgYGENm7CuLCK9blbnTwy/EuGuhlnvLbJb9bjys6NmVoSWrnMtDIbMkOPMfrQV2CiLs0BOwZZUSu25gjroVXdGb2rDenO63dhziwoSfwbCcZ9Wny8pERMmv8F25zKDiWnR9GBIAylFxSjl0NFMfNrc0i7aEkVCjbGmQcX+J/+CwWm/bdjahar/gU1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bi1PXfW/ybVm6/aNbvMAZsNkI3VzFhLhG6PSK8i488=;
 b=qEQyfoJiX7VX0YHJhsqwo48hzdCrGLAAKSqxb4m/3WS1w+pvCxPW7vw281TnfBDxXYgdz8el0SWeado3J+MzlvYvvhusTChzJq+HxdUGDtM3owHf9LcxZp5l63OeZgKbfnwuu21tZrtHOqmotiyoWqtR87h7E1EXZxe6n532ZSdCWnlZHqnbMHvQAxSqkOB3+zSP1KrXw/pjP0OvLYXedewviifHq2rbppFP9IGypqL3wGUpQymrnlPa7UjFhkrFnJTSC3aV2iCxPwxXYDtwLIfFxBFyOU1AhZ/xxrNKEVQ+zyy2QU/TtfWZC9Kt6hrYlqhH740mfroeY1Qs4jPxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bi1PXfW/ybVm6/aNbvMAZsNkI3VzFhLhG6PSK8i488=;
 b=Rz41WQxeVoSVMGYXetGTcW2B44+qsGrjmgM6xLWmKr36RsuqlKrUHqR1bOzHAE3V1R59g5+yWoOqo9KeQL6JGvcQ2l3seZKq6IRpVVKiIGxcb+AmOo4AlQ8NEFPM1VFLxIQveHJGbgeUP8blFTl16zLnEylSqohRnc0tMvtO4EcgNJr9kFvdHUco6b2VzOhegXNdgugwS+M9eVOW2nrFu8gWbBR7DQtDKl1Xpg4lH7BELvIpIHbDhwInW64gErLnZZKHX6xy2t3ukQwq5MXpEaGCNKUGgl76rPsMdg0sikpeGjX03odT7ydjY/NKFb8zunvvC+cpG7OscflE2feOKA==
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:35:12 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::39) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.15 via Frontend Transport; Wed,
 11 Mar 2026 20:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:35:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:34:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:34:57 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:34:49 -0700
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
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>,
	"Alex Williamson" <alex.williamson@redhat.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/20] vfio/pci: Add CXL Type-2 device passthrough support
Date: Thu, 12 Mar 2026 02:04:20 +0530
Message-ID: <20260311203440.752648-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: f7819d6c-403b-442d-ad05-08de7fadb1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|56012099003|18002099003|3122999024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	omiXBUJJltGBpNHPa8Tkc5ynoQo8+7HjJCy2oKOPB/waxOXb2gOSx52aLXbTrhg3qk+NfRUZBvrJyZ9zTmhxEza+oE9ut9zy675K7MvxN1xltKuqDPgf7Zw/UL17jPo7Ej9pNIdUz+w0EGxbTuRLzGshkMAzhhMJlAN0dEYJHQ8bDqy2d/nLJw/VbXq+nzDU/rSPZFcHADES8CvkUt3VgsbvyVMFmo8/U8P96NGgB2fUYTkYtAlvIzmudYDXk54VOTwycDpqt4CEimtV4OKEqDxPnT+GGFeGOUiEFeqHTt0qEmBUe4DD2vgurW1lWDz8nepYhltVXs+X9Ks1W/WtrA0dfbksEv0dYgKKffPxb1FEzeSkvz7kaa/6ZXwwgEu4vIXSgS1xscO/t9oV7Cb5R0vYfst3snvmJSaR3FxEnLx7iox6DGO9qP+vfHFz9B5MSuHaTmS702WYDdGM2KWWq+gj70UxQfYCUiQR5eRMN9LphmgR8Fj2rocIR4y4yST7agNDJ99/RwU2s3hWYFgrL0P+jlKwrkdR+5yanZQEPMw0100wHEaCLZn6R0k6Jg21gVMRGGuclihBN9Moeoax+o+X5MfqNkXmHH8vbCKW37EVdnZs47MSJ8PtlEI+R2DBrnEo9fo2UwXX+ipm2YZ81+Z0iQP7xW3Fte/VeT2zxenouMgqHIuJEmqUBhgd3ypBVy/eb2IkxH0EEk2Mgz+a7joflJWW4EUOopeajN562S53mbxZT5mi1wpAUYUTXy3LEacOCak2agyLrpbEjEA67PCPZP6P94PYdc9KWcStq/LulUFMcbliQhdIeIsXlWM4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(3122999024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ew01DH/h4DgO3gqZOSIrDPbOnFXLyWUJrzjsuzTAeyy6yRLl5fY9cVQI4098+C2w+DiCQDyBfJruIZyClR1IGWrZIBAL2M/Y+twtJTPUqO7Jn6MAYX7MWKalq83UPp07QTNHsZOERZg33xDsJjT9/3HVUj2SQojLuBIUoe89EYFRdkbHi9VSt+X+PodxDx2mOGAxfcpAFhL0Q7S1Nt+GdNTWYNychU4bJphOupW5sBM3g7OFHB2sZ2fDwoxkB7IJBZrbGf+VePr3+cscJRW6pMhbRfhKy/wyD+zEydOZ1/seeaJQ/UGqB1jvQlsg1XRkbl0pRK4omStkaWPatZCtBosVMnxGzm6PtATVCUE5+rEWyQ6rh1jHaCMkgirDM9bFSVNOYJHIzEGosGsUFvzMpBYQ4lBhBYTTmUCDQEKgOo5kuih6oRfxg+Gg6yg1sT8G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:35:12.0398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7819d6c-403b-442d-ad05-08de7fadb1c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

From: Manish Honap <mhonap@nvidia.com>

This series adds support for passthrough of CXL Type-2 devices to virtual
machines through VFIO; The goal is to expose CXL functionality through
the generic vfio-pci core, without any need for a variant driver.

Current design is based on CXL core APIs provided by Alejandro's CXL
type-2 device support patch series which is currently in upstream
review. (see drivers/net/ethernet/sfc/efx_cxl.c) [1].

This patchset should be applied on the cxl next branch using the base
specified at the end of this cover letter + Alejandro's v23 mentioned in
[1].

This patch series introduces CONFIG_VFIO_CXL_CORE, a new optional module
source compiled into vfio-pci-core, that hooks into the vfio-pci
open/close and reset paths to provide:

  * Automatic CXL Type-2 detection at device open time via the CXL Device
    DVSEC capability (Vendor ID 0x1E98, ID 0x0000) and HDM Decoder
    Capability block.

  * Kernel-owned HDM decoder management.  The VMM never programs HDM
    decoders directly; instead it reads and writes an emulated shadow copy
    of the HDM register block through a dedicated COMP_REGS VFIO region.
    All bit-field rules (reserved bits, read-only bits, the
    COMMIT/COMMITTED latch) are enforced by the kernel.

  * A DPA VFIO region backed by the kernel-assigned Host Physical Address
    (HPA).  The VMM maps this region with mmap(); PTEs are inserted lazily
    on first fault.  During FLR/reset all PTEs are invalidated atomically
    under memory_lock and re-inserted after the reset path re-enables the
    decoder.

  * CXL DVSEC configuration-space emulation.  Writes to the CXL Control,
    Status, Control2, Status2, Lock, and Range Base registers in the
    device's PCI extended configuration space are intercepted and replayed
    through a per-device shadow (vconfig), enforcing CXL 3.1 register
    semantics including the RWL/RW1CS/RWO access types and the CONFIG_LOCK
    one-shot latch.

  * A new VFIO_DEVICE_INFO_CAP_CXL capability (id=6) returned in the
    VFIO_DEVICE_GET_INFO capability chain, carrying all the information a
    VMM (e.g. QEMU) needs: HDM decoder count, BAR index and offset of the
    component registers, total DPA size, and indices of the two new VFIO
    regions.

  * Two new VFIO region subtypes under the PCI_VENDOR_ID_CXL vendor
    namespace: VFIO_REGION_SUBTYPE_CXL (DPA memory) and
    VFIO_REGION_SUBTYPE_CXL_COMP_REGS (emulated HDM registers).

  * A module parameter (disable_cxl=1) and a per-device flag
    (vdev->disable_cxl) so that the feature can be suppressed for
    individual devices or globally without recompiling.

  * Comprehensive selftests in tools/testing/selftests/vfio/ covering
    device detection, capability parsing, region enumeration, HDM register
    emulation, DPA mmap with page-fault insertion, FLR invalidation, and
    DVSEC register emulation.

This new design is moved away from variant driver approach and all the
CXL functionality is now made part of vfio-pci driver.

The reasons for this change are:

  * Generic CXL Type-2 support features (DVSEC, HDM, regions, reset)
    are common to all CXL adapters and don't belong in variant drivers.
    When something is vendor-specific (e.g. live migration, proprietary
    features), a variant is appropriate; generic CXL behavior should
    not require a vendor-specific driver. Generic CXL support belongs
    in the core, not behind a variant.

  * With this new approach, the user always binds to vfio-pci. No need to
    choose or document a CXL-specific or vendor-specific driver for
    standard CXL Type-2 passthrough.

  * For any CXL Type-2 device, enlightened vfio-pci works with any device
    that presents CXL Device DVSEC and the expected component layout.

  * CXL detection, state, register emulation, region creation, and reset
    live in a CXL-aware layer invoked from the core (optionally built
    via CONFIG_VFIO_CXL_CORE). The core stays a single entry point;
    CXL is an optional extension, not a separate driver stack.

  * Pushing CXL into the pci-core avoids per-device CXL detection and
    feature toggling inside vendor-specific drivers.

Series structure
================

  * Patches 1-5 extend the CXL subsystem to export the interfaces and
    defines that vfio-pci-core needs.

  * Patches 6-8 lay the vfio-pci-core plumbing.

  * Patches 9-12 implement the core device lifecycle and DPA region.

  * Patches 13-15 implement configuration-space and register emulation.

  * Patches 16-18 wire everything together.

  * Patches 19-20 add documentation and testing.

Limitations and future work
===========================

  * This series does not yet support switched topologies with more than one
    caching agent; that is planned for a future series.

  * RAS / ECC / CCA / Reset Support
    This design will integrate RAS and ECC handling in generic vfio-pci by
    leveraging CXL core and RAS capabilities in next patch updates.

  * cxl_reset support [2]
    Integrate changes from Srirangan to have VFIO-CXL reset support.

Dependencies
============

[1] Type2 device basic support https://lore.kernel.org/linux-cxl/20260201155438.2664640-1-alejandro.lucero-palau@amd.com/
[2] CXL Reset support for Type 2 devices https://lore.kernel.org/linux-cxl/20260306092322.148765-1-smadhavan@nvidia.com/

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Cc: linux-cxl@vger.kernel.org
Cc: kvm@vger.kernel.org

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>

--

Manish Honap (20):
  cxl: Introduce cxl_get_hdm_reg_info()
  cxl: Expose cxl subsystem specific functions for vfio
  cxl: Move CXL spec defines to public header
  cxl: Media ready check refactoring
  cxl: Expose BAR index and offset from register map
  vfio/cxl: Add UAPI for CXL Type-2 device passthrough
  vfio/pci: Add CXL state to vfio_pci_core_device
  vfio/pci: Add vfio-cxl Kconfig and build infrastructure
  vfio/cxl: Implement CXL device detection and HDM register probing
  vfio/cxl: CXL region management
  vfio/cxl: Expose DPA memory region to userspace with fault+zap mmap
  vfio/pci: Export config access helpers
  vfio/cxl: Introduce HDM decoder register emulation framework
  vfio/cxl: Check media readiness and create CXL memdev
  vfio/cxl: Introduce CXL DVSEC configuration space emulation
  vfio/pci: Expose CXL device and region info via VFIO ioctl
  vfio/cxl: Provide opt-out for CXL feature
  docs: vfio-pci: Document CXL Type-2 device passthrough
  selftests/vfio: Add CXL Type-2 passthrough tests
  selftests/vfio: Fix VLA initialisation in vfio_pci_irq_set()

 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst     | 216 +++++
 drivers/cxl/core/pci.c                        |  80 +-
 drivers/cxl/core/regs.c                       |  29 +
 drivers/cxl/cxl.h                             |  34 -
 drivers/vfio/pci/Kconfig                      |   2 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/cxl/Kconfig                  |   7 +
 drivers/vfio/pci/cxl/vfio_cxl_config.c        | 304 +++++++
 drivers/vfio/pci/cxl/vfio_cxl_core.c          | 713 +++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_emu.c           | 414 +++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h          | 123 +++
 drivers/vfio/pci/vfio_pci.c                   |  32 +
 drivers/vfio/pci/vfio_pci_config.c            |  58 +-
 drivers/vfio/pci/vfio_pci_core.c              |  31 +
 drivers/vfio/pci/vfio_pci_priv.h              |  72 ++
 drivers/vfio/pci/vfio_pci_rdwr.c              |   8 +
 include/cxl/cxl.h                             |  52 ++
 include/linux/vfio_pci_core.h                 |  10 +
 include/uapi/linux/vfio.h                     |  52 ++
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |   4 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 816 ++++++++++++++++++
 23 files changed, 3013 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_config.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_emu.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

base-commit: 3f7938b1aec7f06d5b23adca83e4542fcf027001
--
2.25.1

