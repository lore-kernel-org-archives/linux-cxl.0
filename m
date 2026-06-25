Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87332D0EE;
	Thu, 25 Jun 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406595; cv=fail; b=NO+WIl/Uzlq8X97++M0dq1uZsInk7h3sjtHv/aSiQ8I1GY5R9HqMYvag1GBLexkXPYBegiONwO0DzEIGoRLKrmm7mN9g7x53E8S32agNInpfHjDYNQdBwupP/KaX/F9hNolOOliFIer2yBxu2ymZAs2YROxLCLr0yO7Pw4FEuW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406595; c=relaxed/simple;
	bh=SoYczXUAM+m1fEBgLLqS50NYrVy38KYC1W2HyjNTzLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj4X4+cf5iuIPtBkc7o6ym6YPh4+BTlSdLs94nhwPdegHOFL0GPMTgQi+AB/HfaChvt3ovbYj9ghexmF4PK3W0VjOWbZ/xs+jFylFNrW9I3RfFlXhfCOIzwxzDksH+Ksmgvdg+15So2hmu+pXfGLcFhlrgzzg8XIb/SMhrRQo08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUjs3+c+; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUjs3+c+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mecgiP6lpB1YXtUFGuZGL4FLHC88dgvgIhSN10LegbogHdNEnokl5AQfgSrvIPryynXiZzWFa8Oj/X7nq8DdW5uRNc4Rvcu/t8nVR4fvlSU+/gH8yAt9HNTy2/N/uNtn6+vU7tqzUVYU5/J7qklETjwc7Ctm7VaFgobBcrTx9EoEqAzYUn5sVjSlTmrkvNV1WQMT5XwbvuPt4yGKjoGCcwwDNj1CJyc1EVvkHzsCLx84PpPVoI0egMs3eaHSvwMjWmnuqI0Zs73q57MDKxwDJkTwpDkGK5vQt1X0dauuYJ1znxsnAw7eMn0bVwCMYyu8ut9QcJGM0OMcxJXpJPoa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKhj/AoJ+fwoqix869Y1tGkMj4C4yBP0WCcncQmy29M=;
 b=MwtD7eLP2K92vawNNUDJ/S+wwfjMCStjjt1M7lVMySVsS4ncgXV2Hm/SU/gKPTFB65se72JaKe18PvzmTxPLqqOIT2kh4gU0EAyc9y3qe9bkVaXZU51qRyX7X/uBhZT02myeTswuDBQknG0mY0yx/k7gTFK9QOlHq6pFYxRGUIFHIV6GtX+QT0zzBkl1Wo7WU9KY6Oc6H92cbzDkbtdolB82N1htoJA5laAZlf2udQ0geD//mALZZo46f28ONtE8r9C6EzLxMEx5eeFLLLXPTGJ5nvDPs67hJuoSxkUfvNs9y8Ck4W4xiT5i4b3zIV3Ktnyx2NMxKk5cAVBmAtmpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKhj/AoJ+fwoqix869Y1tGkMj4C4yBP0WCcncQmy29M=;
 b=dUjs3+c+SBDQ8rLGlPRYuEYM8eWFJ2w1CjtyUpUO9b9m3IxgKyuqeSMOF0Yhjzth/JwcoaAlaScwlviDNR2I0DglfGLLLccPa2Yls9pDakG88fTO0PuCS3AEUSWD/OGHebkSAa+JP1RETXy6zILA40qqychpBbL4pMPaqb35rFznJ29anRLhhU6dvseqzGXqvh7vXSTnmUNSh/e3ye41gxtM9hWBjiuBmzKkFpg9LOIVAPJdAsAmvn63A3iEUg35BBsbgTLqjL0fL5zHR1xSg+JrFFfyUVACinPk/n3ijD8Lz+u0zEPF+dav+mcfwdfFvQk+xqrkvbJdDKWbU6uUGA==
Received: from MN0P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::18)
 by DS4PR12MB999099.namprd12.prod.outlook.com (2603:10b6:8:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 16:56:25 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::17) by MN0P221CA0013.outlook.office365.com
 (2603:10b6:208:52a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 16:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:56:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:56:02 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:55 -0700
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
Subject: [PATCH v3 10/11] docs: vfio-pci: Document CXL Type-2 device passthrough
Date: Thu, 25 Jun 2026 22:24:06 +0530
Message-ID: <20260625165407.1769572-11-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS4PR12MB999099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7d11c4-fdf8-4410-c46d-08ded2dab167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|921020|56012099006|3023799007|5023799004|11063799006|6133799003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r4KPtqxe7Iz7NbZX8pX722sdW+IuPLjQl8NjzhuvY3d2Awob/Bvkl/2KMDeiF3TjilwuVL9TcMUUR83OPO5GOV+liDaoWS+oxvzAzMQacbGBmbPe2VaHSMAEwxZhLD7WhdaG/Qxi4g0LvVmeN/sL7qY2jgGV/8imtPKF+cYiNztfGkIgiWNGfKCmcRXYeOelPavEBU3s2HmVHpaafPswHowM1EuEM0tmr9/WIgJ9hzwpXqkON8X1GOPqSZ57KCznk0VHOh4ECX69WQIb7gmCvwJB+FGNAjzPAxRyK/AuEou+4H0IiHx4SP08ETl+ss1//Syg17zbgzCJdDUV5GVV7sKUzOvVJD/rexeTbkd0JYt5urtmxOuoDKSsr4zJ5r5XMAeFmmTTXJsNHOZ0KmH93Z7AWigDW6NYCiJPfya73O5NUIrpce250H5w7/1IBgbO3pi1LIvLvCg/OanMjA3rFfdhfil6vttFy9u8rutSZ1e3Me5ANmIGtrMpqdrucSjPm8TWWR/TQh11A0X4C4rGc8Vpl/eXbXLdBtj2O00ArPP5eEqU13ZeyBMJXhwRs55tmg+ADR8vLJMey//ZmSecqVAKCn6hZvuJOWu+9nlsSEPBQEKSO0CohngZazPz2hLhJ7m8isDDLjZeL4FDqtfCE91AuGXxuJewBfYrMHdeG4AdX6t2hAxBUX80XA0+p6Xo8SqLC3/yjsd3rjqZZyAIc/cspGzZqewLGi7kKDA03Yve9yzZyfIbljlVWpjtt/Dj
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(921020)(56012099006)(3023799007)(5023799004)(11063799006)(6133799003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ihBgdp5J4oqyE0hxznf62AHop/6TGsbYOkB1RE+EKGImQ7cjEj+LCKJcF8nTV4aL/XfFmOG6qMBrm7apGWpdxbBeKmahEkIGPjRM3T5PBOsWyIvPKYMcoueSExcBaqvi994yPnqqvu4yNOQFj/dxAj/Gu/42HgT1P3IBsCNfSXpvVH8aOWddq9KMP1B5Ip8aBFUEI1/DEEOI8n1YqtFfMuTYur1qr3A9oUQa1vZM/zDTpFpXM8IZezepfYsT360NapGSUHb3aUPr0s2NwTCplrTCwLf4WdQJfUxrzF2I/jNszhyafB2ISsLFs1YAqFIHtfZLGxDnPwyBY93YUhWah7krgJexmwxDZ0u6zhQeulLjP/VuTiZQbfqblxdtnrMkscDCFexSabCKrLC2Y57p0J+yx+Vrsfk29SQb5HuM6HrDtAx3BMDlL3UxWLtEopMq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:56:25.2392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7d11c4-fdf8-4410-c46d-08ded2dab167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999099

From: Manish Honap <mhonap@nvidia.com>

Capture the ownership model, bind sequence, region layout, and the
DVSEC + HDM + CM cap-array virtualization contract for vfio-pci
Type-2 device passthrough in Documentation/driver-api/vfio-pci-cxl.rst.

cxl-core owns the CXL register virtualization through
devm_cxl_passthrough_create() and the cxl_passthrough_*_rw()
helpers; vfio-pci is a transport that forwards guest reads and
writes through them.  The HDM HPA range is mapped by vfio for the
mmappable HDM region.  Topology constraints and host-bridge decoder
limitations are listed under Known limitations.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst | 282 ++++++++++++++++++++++
 2 files changed, 283 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index eaf7161ff957..52f0c06a376a 100644
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
index 000000000000..1527b7dd85d0
--- /dev/null
+++ b/Documentation/driver-api/vfio-pci-cxl.rst
@@ -0,0 +1,282 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===========================================
+VFIO-PCI: CXL Type-2 device passthrough
+===========================================
+
+:Author: Manish Honap <mhonap@nvidia.com>
+
+Overview
+========
+
+vfio-pci-core, when built with ``CONFIG_VFIO_PCI_CXL=y``, passes a
+CXL Type-2 accelerator (CXL r4.0, HDM-D / HDM-DB) through to a KVM
+guest.  The host firmware commits the endpoint's HDM decoder before
+vfio-pci binds; the guest sees a CXL Type-2 device whose CXL.mem
+range is already programmed and locked.  The guest may inspect the
+HDM Decoder Capability block and DVSEC Device capability via spec-
+defined paths, and access the device's CXL.mem range as
+mmap'd memory.
+
+Scope
+=====
+
+The supported scope is intentionally narrow:
+
+* One CXL endpoint per host bridge.
+* The endpoint exposes exactly one HDM decoder (decoder 0).
+* No interleave.
+* Host firmware has committed the endpoint HDM decoder before
+  vfio-pci probes.  Devices whose HDM decoder is *uncommitted* fail
+  vfio-pci bind cleanly.
+* The host bridge is in single-RP-passthrough mode (the CXL host
+  bridge's own HDM decoder is not used; CFMWS-to-RP decode flows
+  implicitly).  This assumption is currently *not enforced* by
+  vfio-pci-core; it is a known limitation, see the Known
+  limitations section.
+
+Multi-decoder, interleave, FLR / reset state-machine integration,
+and host-bridge HDM decoder programming are explicitly out of scope.
+Adding any of them is additive on top of the contract described
+below.
+
+Driver model
+============
+
+There is no dedicated ``vfio-cxl`` PCI driver.  vfio-pci is the only
+driver that binds to the host PCI device.  When built with
+``CONFIG_VFIO_PCI_CXL=y``, vfio-pci-core calls into the cxl subsystem
+to do four things at bind time:
+
+1. ``devm_cxl_dev_state_create()`` — allocate per-device CXL state
+   embedded in ``struct vfio_pci_cxl_state``.
+2. ``cxl_pci_setup_regs()`` + ``cxl_get_hdm_info()`` — probe the
+   Register Locator DVSEC and harvest the HDM block's BAR-relative
+   offset and size.
+3. ``cxl_await_range_active()`` — wait for the firmware-committed
+   range to become live.
+4. ``devm_cxl_passthrough_create()`` — snapshot the CXL Device DVSEC
+   body, the HDM Decoder block, and the CXL.cache/mem cap-array
+   prefix into shadows owned by cxl-core.  All subsequent
+   register-virtualization happens inside ``drivers/cxl/core/passthrough.c``.
+5. ``devm_cxl_probe_mem()`` — register a ``cxl_memdev``, enumerate
+   the endpoint port, and auto-attach the firmware-committed
+   region.  cxl_mem binds to the memdev as it would for any other
+   Type-2 accelerator.
+
+Ownership split
+===============
+
+Each device-visible surface is owned by exactly one subsystem:
+
+============================================  ==============================================
+Surface                                       Owner
+============================================  ==============================================
+PCI config (non-DVSEC, non-CXL)               vfio-pci-core ``vconfig`` (existing perm-bits)
+CXL Device DVSEC body                         cxl-core ``cxl_passthrough_dvsec_rw()``
+HDM Decoder Capability block                  cxl-core ``cxl_passthrough_hdm_rw()``
+CM cap-array (read-only snapshot)             cxl-core ``cxl_passthrough_cm_rw()``
+``cxl_memdev`` / endpoint port / autoregion   cxl-core ``devm_cxl_probe_mem()``
+HDM HPA range mapping                         vfio-pci ``request_mem_region`` + ``memremap``
+Sparse mmap layout for the component BAR      vfio-pci
+============================================  ==============================================
+
+The vfio side holds no shadow buffer of its own.  ``vfio_pci_cxl_state``
+caches small scalars (DVSEC offset/size, HDM offset/size, component
+BAR layout) for dispatch decisions; the actual virtualization
+semantics live in cxl-core.
+
+Bind sequence
+=============
+
+``vfio_pci_cxl_acquire()`` is called from
+``vfio_pci_core_register_device()`` at PCI bind time.  The sequence::
+
+  0. devm_cxl_dev_state_create(parent, CXL_DEVTYPE_DEVMEM, dsn,
+                               dvsec_off, vfio_pci_cxl_state, cxlds,
+                               /*mbox=*/false)
+
+  1. pcie_is_cxl() and pci_find_dvsec_capability(CXL_DEVICE)
+     -> -ENODEV if either is absent
+     -> -ENODEV if the DVSEC's MEM_CAPABLE bit is clear
+
+  2. pci_enable_device_mem()
+
+     2a. cxl_pci_setup_regs(CXL_REGLOC_RBI_COMPONENT)
+     2b. cxl_get_hdm_info() — REJECT hdm_count != 1 with -EOPNOTSUPP
+     2c. cxl_regblock_get_bar_info()
+     2d. cxl_await_range_active()
+     2e. devm_cxl_passthrough_create(&pdev->dev, &cxlds)
+
+  3. pci_disable_device()
+     Clears PCI_COMMAND_MASTER but NOT PCI_COMMAND_MEMORY (see
+     do_pci_disable_device() in drivers/pci/pci.c).  Subsequent
+     MMIO from step 4 still succeeds.
+
+  4. devm_cxl_probe_mem(&cxlds, &hpa_range)
+     Registers the memdev, enumerates the endpoint port, attaches
+     the firmware-committed autoregion.
+
+  5. request_mem_region(hpa_base, hpa_size) + memremap_wb()
+
+  6. vdev->cxl = cxl  (state published; HDM and COMP_REGS regions
+     are registered later when the VFIO fd is opened)
+
+Fail-closed semantics
+---------------------
+
+Three errnos are mapped to "not a CXL device; caller falls back to
+plain vfio-pci": ``pcie_is_cxl()`` false, DVSEC absent, ``MEM_CAPABLE``
+clear.  All three return ``-ENODEV`` from
+``vfio_pci_cxl_acquire()``; the caller treats them as a silent
+fall-through.
+
+Any other negative errno from the bind sequence aborts the vfio-pci
+bind entirely.  The guest never sees a half-initialised CXL device.
+Once ``devm_cxl_probe_mem()`` has succeeded the published memdev
+holds a pointer into the embedded ``cxl_dev_state``; a failure in
+``vfio_cxl_map_hdm()`` after that point cannot ``devm_kfree(cxl)``
+and leaves the state allocated for the lifetime of the PCI device
+(devres unwinds it at pdev removal).
+
+VFIO regions exposed
+====================
+
+When the VFIO fd is first opened, ``vfio_pci_cxl_open()`` registers
+two additional regions on top of the standard vfio-pci BARs / config
+region:
+
+HDM region (``VFIO_REGION_SUBTYPE_CXL``)
+  Mappable view of the device's firmware-committed HPA range.
+
+  * ``mmap``: fault handler does
+    ``vmf_insert_pfn(vma, addr, PHYS_PFN(hpa_base + off))``.  The
+    guest gets the same backing physical memory the host sees.
+  * ``pread`` / ``pwrite``: served from the ``memremap_wb()`` kva
+    captured at bind time.
+
+COMP_REGS region (``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``)
+  Shadow of the CXL component register sub-range.  ``pread`` /
+  ``pwrite`` only; ``mmap`` is intentionally not supported (the VMM
+  uses this region instead of mmapping the BAR).  Dword-aligned
+  access only; sub-dword accesses return ``-EINVAL``.
+
+  Dispatch by offset:
+
+  ============================================  =================================
+  Offset range                                  cxl-core helper
+  ============================================  =================================
+  ``< CXL_CM_OFFSET``                           zero-fill (reserved)
+  ``CXL_CM_OFFSET .. hdm_reg_offset``           ``cxl_passthrough_cm_rw()``
+  ``hdm_reg_offset .. +hdm_reg_size``           ``cxl_passthrough_hdm_rw()``
+  ``>= hdm_reg_offset + hdm_reg_size``          zero-fill (reserved)
+  ============================================  =================================
+
+DVSEC virtualization contract
+=============================
+
+The CXL Device DVSEC body is reached through the standard PCI
+config-space path.  ``vfio_pci_config_rw_single()`` clips chunks at
+the DVSEC body boundary via ``vfio_pci_cxl_config_boundary()`` and
+forwards body bytes to ``vfio_pci_cxl_config_rw()``, which in turn
+calls ``cxl_passthrough_dvsec_rw()``.
+
+Per-field write semantics (CXL r4.0 §8.1.3):
+
+============================================  ==============================================
+Field (offset from DVSEC cap base)            Spec attribute / behaviour
+============================================  ==============================================
+CAPABILITY        (0x0a)                      HwInit — writes dropped
+CONTROL           (0x0c)                      RWL — gated on DVSEC CONFIG_LOCK
+STATUS            (0x0e)                      RW1C
+CONTROL2          (0x10)                      RWL — gated on DVSEC CONFIG_LOCK
+STATUS2           (0x12)                      RW1C
+LOCK              (0x14)                      RWO — first 1-write latches CONFIG_LOCK
+Range1 SIZE_HI/LO BASE_HI/LO  (0x18..0x27)    HwInit — writes dropped
+Range2 SIZE_HI/LO BASE_HI/LO  (0x28..0x37)    RsvdZ — writes dropped
+============================================  ==============================================
+
+HDM virtualization contract
+===========================
+
+Per CXL r4.0 §8.2.4.20, on the single firmware-committed decoder:
+
+============================================  ==============================================
+Field (offset from HDM block base)            Spec attribute / behaviour
+============================================  ==============================================
+HDM Decoder Capability Header (0x00)          HwInit — writes dropped
+HDM Decoder Global Control    (0x04)          RW — shadow
+Decoder 0 BASE_LO / BASE_HI                   RWL — gated on COMMITTED or LOCK_ON_COMMIT
+Decoder 0 SIZE_LO / SIZE_HI                   RWL — same gate
+Decoder 0 CTRL                                Implements COMMIT → COMMITTED handshake; once
+                                              COMMITTED, only COMMIT toggles are honoured
+============================================  ==============================================
+
+CM cap-array
+============
+
+The CM cap-array (CXL r4.0 §8.2.4) prefix is snapshotted from the
+device's component register MMIO at bind time and served read-only
+through ``cxl_passthrough_cm_rw()``.  Guest writes to the cap-array
+are silently dropped.
+
+UAPI: CAP_CXL
+=============
+
+``VFIO_DEVICE_GET_INFO`` returns ``VFIO_DEVICE_FLAGS_CXL`` and a
+``VFIO_DEVICE_INFO_CAP_CXL`` capability::
+
+    struct vfio_device_info_cap_cxl {
+        struct vfio_info_cap_header header;
+        __u32 flags;
+        #define VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED (1 << 0)
+        __u32 hdm_region_idx;
+        __u32 comp_reg_region_idx;
+        __u32 comp_reg_bar;
+        __u32 __resv;
+        __u64 comp_reg_offset;
+        __u64 comp_reg_size;
+    };
+
+``VFIO_DEVICE_GET_REGION_INFO`` on the component BAR returns a
+``VFIO_REGION_INFO_CAP_SPARSE_MMAP`` that excludes
+``[comp_reg_offset, comp_reg_offset + comp_reg_size)`` from the
+mmappable areas.
+
+Known limitations
+=================
+
+* Host bridge HDM decoder programming is not driven by this driver.
+  The driver silently assumes single-RP-passthrough topology (the
+  CXL host bridge's own HDM decoder is not used).  Two remediations
+  are possible: either refuse to bind when the topology is not
+  single-RP-passthrough, or extend the kernel ABI so a host-bridge
+  HDM decoder programmer can attest the lock before vfio bind.  Both
+  leave the existing contract intact or add a single boolean to
+  CAP_CXL.
+
+* Function-level reset (FLR) does not re-snapshot the shadows.
+  Guests that issue FLR will see stale HDM and DVSEC state after
+  the reset.
+
+* Multi-decoder devices return ``-EOPNOTSUPP`` at bind.
+
+* Hotplug while the device is held by vfio is not supported.
+
+* Raw BAR read/write into the CXL component register sub-range is
+  unsupported.  VMMs must use the COMP_REGS region.
+
+Selftest
+========
+
+``tools/testing/selftests/vfio/vfio_cxl_type2_test`` exercises the
+five surfaces:
+
+* ``device_is_cxl`` — GET_INFO returns FLAGS_CXL + CAP_CXL.
+* ``hdm_region_mmap_rw`` — mmap + read/write pattern.
+* ``component_bar_sparse_mmap`` — SPARSE_MMAP cap excludes the CXL
+  block.
+* ``comp_regs_cm_cap_array_read`` — CM cap-array header is served
+  from the cxl-core snapshot.
+* ``dvsec_lock_byte_read`` -- DVSEC config-rw clipping shim is wired.
-- 
2.25.1

