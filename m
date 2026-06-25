Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A43E9C08;
	Thu, 25 Jun 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406582; cv=fail; b=b8iAUUGn3O2TYY64eP23SZfE1DlPcYVFf//upvQgKXG4TuHsk0fnqU5dWm1XqnpYVF05XkBOVXqpSX/ty1IhtvvV8XQBu3YBWgM7piXu01AcQxsOuAbFEXWsWMwJACJ0AZhylG+20VP+N6ijHPaGPL79qFHSW8NgOtS/ojUOJJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406582; c=relaxed/simple;
	bh=cRBdc6nHSpEcjlIpHdm6aY0Me+gjEwM4bc1LuNdKSQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6vRALtfs3vM7kHeK4yF8GX4YSloXQJUTjG8zuMYjkeiFtfgivp83S33bQXjAe5bLuajgZgrYWPnfhfjTZS2EPrmUp5UQnjFWbLzoPaq/UYHUUCepdUwNEIJ08QJVA9rMukF5N/JE87jPEcjarFtkWH+4MVNj1VegJlIsvqQ0qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RvgdCXYZ; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RvgdCXYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkHimzzOzLX+bweleWYWNg06EMKHcaj2yP1ij2dVA05wzmsSYc+OPe/Q671M4abamb1LR1ZHjLoWJGN/qqE6wHE+2mh1wv72B3gHBLBkPRxNmosaI2SUH1+Ikqk3s5JIOfK/m6h+63H877iNvBmO6i5VBthuJInjP7fOCBnuPrlZpibIr7XfEmGgPc/eB3uCCuNCXtq+w/K5osW5lTPWf5dG7JL39cbVDYfkvwYB0aqkv3SSAwgBDEIh5IQO/j408a6o+NskxqZMRJ9B10BopdKudlM0b+xsdPEyRitkDlHtdFY6K//QyNdFIOPz1zS6iGi3/QCs8Sp5EIPBPPoo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/qtPNkvGbEIPlJjF0ntngv4PJuhg/kQLB48jLb7H5k=;
 b=O/e2A5Ygan7jy0jcrxcQKjoyaGbnh0jIQItGrFa5JAtiJghEphuXIbxuw7RJM63ETEreRAXAoQofVgg/EWjV1RxGH9wsVzKx03jo2MkWwFzo/wEiLxZ8GON1xuyhtDBrV1r/XhI+k8dck5vtxU9yT3uUoDz4H0DqF7/QdDq0wF20v+7f5wlqWhPLF9uJTcATTlsfmoz1cH5kmJ7KhL/550Xw76h63dtzA1+ceMmnb0k94sJxxKpL0To74ZjL9QRVOa5uIioWHIRA6RnPcATG12V5mCoHguo75h5n9j0oJ1muUTMCjoFjykhvZrHa7B3A4UjGMJmiYSBzzJMTqApKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/qtPNkvGbEIPlJjF0ntngv4PJuhg/kQLB48jLb7H5k=;
 b=RvgdCXYZRnSGrXoe50zA2++6pEpoPw7UdNecdwZHaxcaETv0Arf4rgChp7TIssR7BZSCS2FTYyC3LDIgn6C9t4nRhlBkwQRRNZXM3zhB6losAl8IXngrs3VmtDbjW0zsNJj82MqBUC4TPfRGFgDKH/keismUxkw4kle5ywYpzjq7o4W1wCDT+/a3z1HZSYf4HhEbZzZZpTqK9gRmlhYFDW6HWsmywIjlgpB5S+msEbCOupjtaDP6k9BiQYIqbcCtaOI64PPIKZQ15EU+7FjxlsLo9yif30gZ4yGpzkGESi0ALVS8WfQHZeAc69HYfLcUNN4d+NBtm+qV3vAw21GSxA==
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 16:56:03 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a2) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 16:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:56:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:46 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:38 -0700
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
Subject: [PATCH v3 08/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping shim
Date: Thu, 25 Jun 2026 22:24:04 +0530
Message-ID: <20260625165407.1769572-9-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c49121d-baa5-42ea-8fe7-08ded2daa3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|921020|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BEwJeGhnGXFyvXjcx7Q5CfU/9RXCwv+VGFCnA6AW7c6dL0dxBuVNQXrpBtL7rjrlzJWBVlHovZrtAxxy5rSQOp5Ea/8wUkXS7lnyNBC0oh4zDLK4tqNeXB0Xr9iPdg37v3U2NYvtd8HYVJGlZgYuqOHwQggNz2Dy9FPvCJMTtLBTGwvGzJGhDDDac+O1wl7btJiS/oUFzCJFoKC1mqfn9AukSVoKOnchK2Bl3yMi0zhRC2qRhwJ0CuzPJ0mOa4BzfB/vdhv2dtVy7zrKxc4je4WYigRt9haOzDLgVgeqdIUWZtozdkgjn7XapDBwks34sOe6Q9b7tG1yp7icaAxxmOHirDt20DdrHlx/TjE6FtZ7YkpRGCYAnybl98175YXWEQ0oAFpSVICqJvx79IsXz1/S4qP/vH05s97Z1HjjiHU/NVo4XzyZpwGorLfXY3qddENSn/FMjrHZCYchy0RdPvPudOa9f8pr17ToiEFqU84bb9NSRf1bO/Ax94VWj5ktHVgnIquUe4Kd5cVjnSBSVP57a7/XRyC0H6FDXvZQWQK5+agfTTz4xdPFM13Q1LLrRBWooRCKW8etZthuC6XU1X3AynEmev7d9uSr2mN3RO+MRHKNhAT+m6DzIsXY2ifdzlgOpCwTj5cjyOwUqCI/YnbmmCAH5Dvu08Sme6qpGlpZM6q63CVR+pLajTs6LukWm82SVJoobYu0pxIK8f4EXhxxD+8qqenU+/ppZeHaiCN2JG8npPFxpqpugjJv2Uf2
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(921020)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8adEristwcyhl00yGZ1J/gRLqs+LPbVFif7EYGJB5KE8cvZ8gMffxXmyPQ9kMCbheEux+EpBBfRVmAvlFCOM4Xkhx2jK3mDBcVrZnD2piycSzkdMWpQF5PvfPiNY7ia0MlZDbDx97WAPAyrzlEPKiiyUpJCZ1cjpXkokhK34oD2M/YwuDCtEYHJgLAyiasZxd2n9S0IlYL0Lo4AECed54ceLhjgZ90fEI3piAiJixIEdsTxicgXhxkMdn+zXLKApRqjUWIygTjWf1UX591kiYaVbvtOC5dBorFF09S5X1NjGNsvkQN4d50/J0gJriKAr8mpc09s5my4uFW0uB+Ml4tYqMPiplPlBAGWnJPenN7nZw5eBY+MvFQwZZwqr5W9S75V5NT24PWgBwlBg0pDxc25a9USc2gJQ5YmcK2/AsNe6NxGN3CS/jM/rxSDkkhJJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:56:02.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c49121d-baa5-42ea-8fe7-08ded2daa3e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

From: Manish Honap <mhonap@nvidia.com>

Complete the vfio-pci-core integration of CXL Type-2 device
passthrough by exposing two VFIO regions to userspace, wiring DVSEC
config-space accesses through cxl-core's register-virtualization
helpers, and reserving the CXL component register block from BAR
mmap and BAR resource claim.

HDM region (VFIO_REGION_SUBTYPE_CXL):
  - mmappable view of the device's firmware-committed HPA range
  - mmap fault handler calls vmf_insert_pfn() from the physical HPA
    so the guest gets the same backing memory the host sees
  - pread/pwrite go through the memremap_wb() kva captured at
    bind time by vfio_cxl_map_hdm()

COMP_REGS region (VFIO_REGION_SUBTYPE_CXL_COMP_REGS):
  - pread/pwrite only, dword-aligned (-EINVAL on misalignment)
  - thin transport: each dword dispatches by offset to
    cxl_passthrough_cm_rw() (CM cap-array snapshot) or
    cxl_passthrough_hdm_rw() (HDM Decoder block).  No shadow buffer
    on the vfio side; all per-field semantics live in cxl-core.

DVSEC config-space access:
  - vfio_pci_cxl_config_boundary() clips a chunk at the CXL Device
    DVSEC body edge in vfio_pci_config_rw_single() so the generic
    perm-bits path handles the DVSEC header bytes and the CXL hook
    handles the body bytes.  The clipping shim is used instead of
    re-pointing the ecap_perms[] readfn/writefn (which would mutate
    a module-init static and race across multiple CXL devices).
  - vfio_pci_cxl_config_rw() forwards clipped accesses to
    cxl_passthrough_dvsec_rw(); cxl-core enforces the per-field
    write semantics (LOCK/RWO, CONTROL/RWL, STATUS/RW1C,
    RANGE1/HwInit, RANGE2/RsvdZ).

GET_INFO / GET_REGION_INFO:
  - VFIO_DEVICE_INFO_CAP_CXL advertises the two region indices, the
    component BAR layout, and HOST_FIRMWARE_COMMITTED.
  - GET_REGION_INFO on the component BAR returns a sparse-mmap cap
    that excludes [comp_reg_offset, comp_reg_offset+comp_reg_size).

BAR resource handling:
  - cxl-core holds request_mem_region() on the CXL component
    register sub-range from devm_cxl_probe_mem(), so vfio_pci-core's
    pci_request_selected_regions() on the full BAR would collide.
    map_bars() skips the request for the component BAR (still iomaps
    it; vfio holds the BAR via driver binding); disable() mirrors
    the asymmetric skip.
  - mmap of the component BAR refuses any range overlapping the CXL
    sub-range via vfio_pci_cxl_mmap_overlaps_comp_regs().

vfio_pci_cxl_open() now registers both VFIO regions; close()
unregisters them.  Raw BAR rw redirect into the CXL sub-range is
intentionally not implemented: VMMs use the COMP_REGS region
directly.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 521 ++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_config.c   |  31 ++
 drivers/vfio/pci/vfio_pci_core.c     |  44 ++-
 drivers/vfio/pci/vfio_pci_priv.h     |  72 ++++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  17 +
 5 files changed, 679 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 42cd00bbe869..8a00b776d7c7 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -123,12 +123,24 @@ static int vfio_cxl_probe_regs(struct vfio_pci_cxl_state *cxl)
 	if (rc)
 		return rc;
 
+	/*
+	 * The CXL Component Register block is a fixed 64 KiB area (CXL r4.0
+	 * §8.2.3).  cxl_pci_setup_regs() records the remaining BAR length
+	 * after the regblock offset in reg_map.max_size, which is an upper
+	 * bound, not the spec-defined size.  Bail if the BAR does not have
+	 * room for a full component register block at the recorded offset,
+	 * and publish the spec size so the UAPI, sparse-mmap exclusion, and
+	 * COMP_REGS region all agree on the same window.
+	 */
+	if (cxlds->reg_map.max_size < CXL_COMPONENT_REG_BLOCK_SIZE)
+		return -ENXIO;
+
 	cxl->info.hdm_count               = hdm_count;
 	cxl->info.hdm_reg_offset          = hdm_off;
 	cxl->info.hdm_reg_size            = hdm_size;
 	cxl->info.comp_reg_bir            = bir;
 	cxl->info.comp_reg_offset         = bar_off;
-	cxl->info.comp_reg_size           = cxlds->reg_map.max_size;
+	cxl->info.comp_reg_size           = CXL_COMPONENT_REG_BLOCK_SIZE;
 	cxl->info.host_firmware_committed = true;
 
 	/*
@@ -354,16 +366,515 @@ void vfio_pci_cxl_release(struct vfio_pci_core_device *vdev)
 	vdev->cxl = NULL;
 }
 
+static int vfio_pci_cxl_register_hdm(struct vfio_pci_core_device *vdev);
+static int vfio_pci_cxl_register_comp_regs(struct vfio_pci_core_device *vdev);
+
 int vfio_pci_cxl_open(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	int rc;
+
+	if (!cxl)
+		return 0;	/* plain vfio-pci device */
+
+	rc = vfio_pci_cxl_register_comp_regs(vdev);
+	if (rc) {
+		pci_warn(vdev->pdev,
+			 "vfio-cxl: COMP_REGS region register failed (%d)\n",
+			 rc);
+		return rc;
+	}
+
+	rc = vfio_pci_cxl_register_hdm(vdev);
+	if (rc) {
+		pci_warn(vdev->pdev,
+			 "vfio-cxl: HDM region register failed (%d)\n", rc);
+		/*
+		 * COMP_REGS already registered above.  vfio core does not
+		 * call close_device() when open_device() returns an error,
+		 * so roll back the COMP_REGS dynamic region here to avoid
+		 * a leaked half-registered open state.
+		 */
+		vfio_pci_cxl_close(vdev);
+		return rc;
+	}
+	return 0;
+}
+
+void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	unsigned int i;
+
+	if (!cxl)
+		return;
+
+	for (i = vdev->num_regions; i > 0; i--) {
+		struct vfio_pci_region *r = &vdev->region[i - 1];
+
+		if (r->data != cxl)
+			break;
+		if (r->ops->release)
+			r->ops->release(vdev, r);
+		vdev->num_regions--;
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* HDM region: mmappable view of the device's HPA range               */
+/* ------------------------------------------------------------------ */
+
+static vm_fault_t hdm_region_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vfio_pci_cxl_state *cxl = vma->vm_private_data;
+	unsigned long off = (vmf->address - vma->vm_start) +
+			    (vma->vm_pgoff << PAGE_SHIFT);
+	phys_addr_t pa;
+
+	if (!cxl || !cxl->info.hpa_size)
+		return VM_FAULT_SIGBUS;
+	if (off >= cxl->info.hpa_size)
+		return VM_FAULT_SIGBUS;
+
+	pa = cxl->info.hpa_base + off;
+	return vmf_insert_pfn(vma, vmf->address, PHYS_PFN(pa));
+}
+
+static const struct vm_operations_struct hdm_region_vm_ops = {
+	.fault = hdm_region_fault,
+};
+
+static int hdm_region_mmap(struct vfio_pci_core_device *vdev,
+			   struct vfio_pci_region *region,
+			   struct vm_area_struct *vma)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	pgoff_t pgoff;
+	u64 req_start, req_len;
+
+	if (!cxl || !cxl->info.hpa_size)
+		return -ENODEV;
+
 	/*
-	 * Region registration (HDM, COMP_REGS) is added by the next
-	 * patch in this series.  This hook exists so vfio-pci-core's
-	 * fd-open path has a stable call site.
+	 * vfio_pci_core_mmap() forwards the VMA with vm_pgoff still
+	 * carrying the VFIO region index in the high bits.  Mask it off
+	 * so req_start is the in-region offset; also overwrite vm_pgoff
+	 * with the normalised value so the fault handler computes the
+	 * physical address from a clean offset.
 	 */
+	pgoff = vma->vm_pgoff &
+		((1ULL << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	req_start = (u64)pgoff << PAGE_SHIFT;
+	req_len   = vma->vm_end - vma->vm_start;
+	if (req_start > cxl->info.hpa_size ||
+	    req_len > cxl->info.hpa_size - req_start)
+		return -EINVAL;
+
+	vma->vm_pgoff = pgoff;
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_ops = &hdm_region_vm_ops;
+	vma->vm_private_data = cxl;
 	return 0;
 }
 
-void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev)
+static ssize_t hdm_region_rw(struct vfio_pci_core_device *vdev,
+			     char __user *buf, size_t count,
+			     loff_t *ppos, bool iswrite)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	void *kva;
+
+	if (!cxl || !cxl->hdm_kva)
+		return -EINVAL;
+	if (pos < 0 || (u64)pos > cxl->info.hpa_size ||
+	    count > cxl->info.hpa_size - (u64)pos)
+		return -EINVAL;
+
+	kva = (u8 *)cxl->hdm_kva + pos;
+	if (iswrite) {
+		if (copy_from_user(kva, buf, count))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(buf, kva, count))
+			return -EFAULT;
+	}
+
+	*ppos += count;
+	return count;
+}
+
+static void hdm_region_release(struct vfio_pci_core_device *vdev,
+			       struct vfio_pci_region *region)
+{
+}
+
+static const struct vfio_pci_regops vfio_pci_cxl_hdm_ops = {
+	.rw	 = hdm_region_rw,
+	.mmap	 = hdm_region_mmap,
+	.release = hdm_region_release,
+};
+
+static int vfio_pci_cxl_register_hdm(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 region_type = VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_CXL;
+	u32 region_flags = VFIO_REGION_INFO_FLAG_READ |
+			   VFIO_REGION_INFO_FLAG_WRITE |
+			   VFIO_REGION_INFO_FLAG_MMAP;
+	int rc;
+
+	rc = vfio_pci_core_register_dev_region(vdev, region_type,
+					       VFIO_REGION_SUBTYPE_CXL,
+					       &vfio_pci_cxl_hdm_ops,
+					       cxl->info.hpa_size,
+					       region_flags, cxl);
+	if (rc)
+		return rc;
+
+	cxl->hdm_region_idx = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* COMP_REGS region: thin transport to cxl-core register helpers       */
+/* ------------------------------------------------------------------ */
+
+/*
+ * COMP_REGS exposes the CXL component register sub-range of the
+ * device's component BAR as a pread/pwrite-only VFIO region.  Access
+ * is dword-only (4-byte aligned); sub-dword access returns -EINVAL.
+ * The dispatch maps each dword to one of cxl-core's three rw helpers:
+ *
+ *   pos < CXL_CM_OFFSET                          → zero-fill / drop
+ *   CXL_CM_OFFSET <= pos < hdm_reg_offset         → cxl_passthrough_cm_rw
+ *   hdm_reg_offset <= pos < hdm_reg_offset+size   → cxl_passthrough_hdm_rw
+ *   pos >= hdm_reg_offset + hdm_reg_size          → zero-fill / drop
+ *
+ * vfio holds no shadow buffer of its own; the per-field write
+ * semantics live entirely in cxl-core.
+ */
+static ssize_t comp_regs_rw(struct vfio_pci_core_device *vdev,
+			    char __user *buf, size_t count,
+			    loff_t *ppos, bool iswrite)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	resource_size_t cm_off, hdm_start, hdm_end;
+	size_t done = 0;
+
+	if (!cxl || !cxl->cxlpt)
+		return -EINVAL;
+	if (pos < 0 || (u64)pos > cxl->info.comp_reg_size ||
+	    count > cxl->info.comp_reg_size - (u64)pos)
+		return -EINVAL;
+	if (!IS_ALIGNED(pos, 4) || !IS_ALIGNED(count, 4))
+		return -EINVAL;
+
+	cm_off    = CXL_CM_OFFSET;
+	hdm_start = cxl->info.hdm_reg_offset;
+	hdm_end   = hdm_start + cxl->info.hdm_reg_size;
+
+	while (done < count) {
+		__le32 le = 0;
+		u32 v32 = 0;
+		int rc;
+
+		if (iswrite) {
+			if (copy_from_user(&le, buf + done, 4))
+				return done ?: -EFAULT;
+			v32 = le32_to_cpu(le);
+		}
+
+		if (pos >= cm_off && pos < hdm_start) {
+			rc = cxl_passthrough_cm_rw(cxl->cxlpt,
+						   (u32)(pos - cm_off),
+						   &v32, iswrite);
+			if (rc)
+				return done ?: rc;
+		} else if (pos >= hdm_start && pos < hdm_end) {
+			rc = cxl_passthrough_hdm_rw(cxl->cxlpt,
+						    (u32)(pos - hdm_start),
+						    &v32, iswrite);
+			if (rc)
+				return done ?: rc;
+		} else if (!iswrite) {
+			v32 = 0;	/* outside modelled ranges: read 0 */
+		}
+		/* writes outside modelled ranges are silently dropped */
+
+		if (!iswrite) {
+			le = cpu_to_le32(v32);
+			if (copy_to_user(buf + done, &le, 4))
+				return done ?: -EFAULT;
+		}
+
+		pos  += 4;
+		done += 4;
+	}
+
+	*ppos += done;
+	return done;
+}
+
+static void comp_regs_release(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_region *region)
+{
+}
+
+static const struct vfio_pci_regops vfio_pci_cxl_comp_regs_ops = {
+	.rw	 = comp_regs_rw,
+	.release = comp_regs_release,
+};
+
+static int vfio_pci_cxl_register_comp_regs(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 region_type = VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_CXL;
+	u32 region_flags = VFIO_REGION_INFO_FLAG_READ |
+			   VFIO_REGION_INFO_FLAG_WRITE;
+	int rc;
+
+	rc = vfio_pci_core_register_dev_region(vdev, region_type,
+					       VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+					       &vfio_pci_cxl_comp_regs_ops,
+					       cxl->info.comp_reg_size,
+					       region_flags, cxl);
+	if (rc)
+		return rc;
+
+	cxl->comp_reg_region_idx = VFIO_PCI_NUM_REGIONS + vdev->num_regions - 1;
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* DVSEC config-space clipping shim                                    */
+/* ------------------------------------------------------------------ */
+
+/*
+ * vfio_pci_cxl_config_boundary - clip a config-rw chunk at the DVSEC body edge
+ *
+ * Returns the maximum byte count the caller may pass through the
+ * generic chunker without straddling the CXL Device DVSEC body
+ * boundary, or SIZE_MAX when no clip is required.  Used by
+ * vfio_pci_config_rw_single() so the DVSEC header bytes stay on the
+ * generic perm-bits path and the body bytes reach the CXL hook.
+ */
+size_t vfio_pci_cxl_config_boundary(struct vfio_pci_core_device *vdev,
+				    loff_t pos)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 body_start, body_end;
+
+	if (!cxl)
+		return SIZE_MAX;
+
+	body_start = cxl->info.dvsec_offset + PCI_DVSEC_CXL_CAP;
+	body_end   = cxl->info.dvsec_offset + cxl->info.dvsec_size;
+
+	if (pos < body_start)
+		return body_start - pos;
+	if (pos < body_end)
+		return body_end - pos;
+	return SIZE_MAX;
+}
+
+/*
+ * vfio_pci_cxl_config_rw - forward CXL DVSEC config accesses to cxl-core
+ *
+ * Returns the number of bytes processed on success, -ENOENT if the
+ * access lies entirely outside the CXL Device DVSEC body (caller
+ * takes the standard perm-bits path), or another negative errno on
+ * hard failure.  vfio_pci_config_rw_single() applies
+ * vfio_pci_cxl_config_boundary() before width selection, so any
+ * access that reaches here was already clipped to lie entirely inside
+ * the DVSEC body.
+ */
+ssize_t vfio_pci_cxl_config_rw(struct vfio_pci_core_device *vdev,
+			       loff_t pos, size_t count, __le32 *val,
+			       bool iswrite)
 {
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 dvsec_off, body_start, body_end, off;
+	u32 host_val;
+	int rc;
+
+	if (!cxl || !cxl->cxlpt)
+		return -ENOENT;
+
+	dvsec_off  = cxl->info.dvsec_offset;
+	body_start = dvsec_off + PCI_DVSEC_CXL_CAP;
+	body_end   = dvsec_off + cxl->info.dvsec_size;
+
+	if (pos + count <= body_start || pos >= body_end)
+		return -ENOENT;
+	if (WARN_ON_ONCE(pos < body_start || pos + count > body_end))
+		return -EINVAL;	/* caller failed to clip at body boundary */
+
+	off = (u32)(pos - dvsec_off);
+	host_val = iswrite ? le32_to_cpu(*val) : 0;
+
+	rc = cxl_passthrough_dvsec_rw(cxl->cxlpt, off, &host_val, count,
+				      iswrite);
+	if (rc)
+		return rc;
+
+	if (!iswrite)
+		*val = cpu_to_le32(host_val);
+	return count;
+}
+
+/* ------------------------------------------------------------------ */
+/* GET_INFO / GET_REGION_INFO / mmap helpers                           */
+/* ------------------------------------------------------------------ */
+
+u8 vfio_pci_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	return cxl ? cxl->info.comp_reg_bir : U8_MAX;
+}
+
+bool vfio_pci_cxl_get_comp_reg_range(struct vfio_pci_core_device *vdev,
+				     size_t *start, size_t *end)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl || !cxl->info.comp_reg_size)
+		return false;
+
+	*start = cxl->info.comp_reg_offset;
+	*end   = cxl->info.comp_reg_offset + cxl->info.comp_reg_size;
+	return true;
+}
+
+bool vfio_pci_cxl_mmap_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+					  u64 req_start, u64 req_len)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl || !cxl->info.comp_reg_size)
+		return false;
+
+	return req_start < cxl->info.comp_reg_offset + cxl->info.comp_reg_size &&
+	       req_start + req_len > cxl->info.comp_reg_offset;
+}
+
+/*
+ * vfio_pci_cxl_bar_overlaps_comp_regs - check whether a BAR-relative access
+ * overlaps the CXL component register sub-range.
+ *
+ * Returns true when @bar is the component BAR and the [@start, @start + @len)
+ * window overlaps [comp_reg_offset, comp_reg_offset + comp_reg_size).  Used
+ * by the raw BAR read/write and ioeventfd paths to reject accesses that
+ * would bypass the COMP_REGS region and reach the physical component
+ * registers directly, sidestepping cxl-core's shadow and per-field write
+ * semantics.
+ */
+bool vfio_pci_cxl_bar_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+					 int bar, u64 start, u64 len)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl || !cxl->info.comp_reg_size || !len)
+		return false;
+	if (bar != cxl->info.comp_reg_bir)
+		return false;
+
+	return start < cxl->info.comp_reg_offset + cxl->info.comp_reg_size &&
+	       start + len > cxl->info.comp_reg_offset;
+}
+
+int vfio_pci_cxl_get_info(struct vfio_pci_core_device *vdev,
+			  struct vfio_info_cap *caps)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct vfio_device_info_cap_cxl cap = { };
+
+	if (!cxl)
+		return 0;
+
+	cap.header.id      = VFIO_DEVICE_INFO_CAP_CXL;
+	cap.header.version = 1;
+	if (cxl->info.host_firmware_committed)
+		cap.flags |= VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED;
+	cap.hdm_region_idx      = cxl->hdm_region_idx;
+	cap.comp_reg_region_idx = cxl->comp_reg_region_idx;
+	cap.comp_reg_bar        = cxl->info.comp_reg_bir;
+	cap.comp_reg_offset     = cxl->info.comp_reg_offset;
+	cap.comp_reg_size       = cxl->info.comp_reg_size;
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
+/*
+ * Build a VFIO_REGION_INFO_CAP_SPARSE_MMAP that excludes the CXL
+ * component register block from the mmappable areas of the
+ * component BAR.  Returns -ENOTTY when the request is not for the
+ * component BAR or the component BAR is not mmappable; the caller
+ * (vfio_pci_ioctl_get_region_info) then continues with the standard
+ * BAR path.
+ */
+int vfio_pci_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+				 struct vfio_region_info *info,
+				 struct vfio_info_cap *caps)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	u64 bar_len, comp_start, comp_end;
+	u64 before_end, after_start;
+	struct vfio_region_sparse_mmap_area areas[2];
+	u32 nr_areas = 0, cap_size;
+	int ret;
+
+	if (!cxl)
+		return -ENOTTY;
+	if (info->index != cxl->info.comp_reg_bir)
+		return -ENOTTY;
+	if (!cxl->info.comp_reg_size)
+		return -ENOTTY;
+	if (!vdev->bar_mmap_supported[info->index])
+		return -ENOTTY;
+
+	bar_len    = pci_resource_len(vdev->pdev, info->index);
+	comp_start = cxl->info.comp_reg_offset;
+	comp_end   = comp_start + cxl->info.comp_reg_size;
+
+	before_end  = round_down(comp_start, PAGE_SIZE);
+	after_start = round_up(comp_end, PAGE_SIZE);
+
+	if (before_end > 0) {
+		areas[nr_areas].offset = 0;
+		areas[nr_areas].size   = before_end;
+		nr_areas++;
+	}
+	if (after_start < bar_len) {
+		areas[nr_areas].offset = after_start;
+		areas[nr_areas].size   = bar_len - after_start;
+		nr_areas++;
+	}
+
+	info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
+	info->size   = bar_len;
+	info->flags  = VFIO_REGION_INFO_FLAG_READ |
+		       VFIO_REGION_INFO_FLAG_WRITE;
+	if (!nr_areas)
+		return 0;
+
+	info->flags |= VFIO_REGION_INFO_FLAG_MMAP;
+
+	cap_size = struct_size(sparse, areas, nr_areas);
+	sparse = kzalloc(cap_size, GFP_KERNEL);
+	if (!sparse)
+		return -ENOMEM;
+
+	sparse->header.id      = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas       = nr_areas;
+	memcpy(sparse->areas, areas, nr_areas * sizeof(areas[0]));
+
+	ret = vfio_info_add_capability(caps, &sparse->header, cap_size);
+	kfree(sparse);
+	return ret;
 }
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..b9f30a33515a 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1898,8 +1898,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 	/*
 	 * Chop accesses into aligned chunks containing no more than a
 	 * single capability.  Caller increments to the next chunk.
+	 *
+	 * For CXL Type-2 devices also clip at the CXL Device DVSEC body
+	 * boundary so the generic perm-bits path handles the DVSEC
+	 * header bytes and the CXL hook handles the body bytes; without
+	 * this clip a 32-bit access at dvsec + 0x08 would span the
+	 * generic Header2 word and the CXL CAPABILITY word.
 	 */
 	count = min(count, vfio_pci_cap_remaining_dword(vdev, *ppos));
+	count = min(count, vfio_pci_cxl_config_boundary(vdev, *ppos));
 	if (count >= 4 && !(*ppos % 4))
 		count = 4;
 	else if (count >= 2 && !(*ppos % 2))
@@ -1909,6 +1916,30 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 
 	ret = count;
 
+	/*
+	 * Give the CXL Type-2 hook first claim on this access: if the
+	 * range lies inside the CXL Device DVSEC body, forward it to
+	 * cxl-core's register-virtualization helpers instead of the
+	 * standard perm-bits path.  -ENOENT means "not for me; use the
+	 * default path"; any other negative value is a hard error.
+	 */
+	if (vdev->cxl) {
+		__le32 le_val = 0;
+		ssize_t cxl_ret;
+
+		if (iswrite && copy_from_user(&le_val, buf, count))
+			return -EFAULT;
+		cxl_ret = vfio_pci_cxl_config_rw(vdev, *ppos, count, &le_val,
+						 iswrite);
+		if (cxl_ret >= 0) {
+			if (!iswrite && copy_to_user(buf, &le_val, count))
+				return -EFAULT;
+			return cxl_ret;
+		}
+		if (cxl_ret != -ENOENT)
+			return cxl_ret;
+	}
+
 	cap_id = vdev->pci_config_map[*ppos];
 
 	if (cap_id == PCI_CAP_ID_INVALID) {
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 05ab4ae59157..2d2dae278d1e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -501,6 +501,23 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
 		if (!pci_resource_len(pdev, i))
 			continue;
 
+		/*
+		 * cxl-core already holds request_mem_region() on the CXL
+		 * component register sub-range of this BAR.  Skip the
+		 * full-BAR request so we do not collide with that
+		 * sub-region; vfio still owns the BAR via the driver
+		 * binding and the iomap below succeeds without a region
+		 * claim.
+		 */
+		if (vdev->cxl && bar == vfio_pci_cxl_get_component_reg_bar(vdev)) {
+			vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
+			if (!vdev->barmap[bar]) {
+				pci_dbg(pdev, "Failed to iomap region %d\n", bar);
+				vdev->barmap[bar] = IOMEM_ERR_PTR(-ENOMEM);
+			}
+			continue;
+		}
+
 		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
 			pci_dbg(pdev, "Failed to reserve region %d\n", bar);
 			vdev->barmap[bar] = IOMEM_ERR_PTR(-EBUSY);
@@ -701,7 +718,10 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
 			continue;
 		pci_iounmap(pdev, vdev->barmap[bar]);
-		pci_release_selected_regions(pdev, 1 << bar);
+		/* Mirror the asymmetric setup-time skip in map_bars(). */
+		if (!(vdev->cxl &&
+		      i == vfio_pci_cxl_get_component_reg_bar(vdev)))
+			pci_release_selected_regions(pdev, 1 << bar);
 		vdev->barmap[bar] = NULL;
 	}
 
@@ -1051,6 +1071,16 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 	info.num_irqs = VFIO_PCI_NUM_IRQS;
 
+	if (vdev->cxl) {
+		ret = vfio_pci_cxl_get_info(vdev, &caps);
+		if (ret) {
+			pci_warn(vdev->pdev,
+				 "Failed to add CXL info capability\n");
+			return ret;
+		}
+		info.flags |= VFIO_DEVICE_FLAGS_CXL;
+	}
+
 	ret = vfio_pci_info_zdev_add_caps(vdev, &caps);
 	if (ret && ret != -ENODEV) {
 		pci_warn(vdev->pdev,
@@ -1093,6 +1123,12 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 	struct pci_dev *pdev = vdev->pdev;
 	int i, ret;
 
+	if (vdev->cxl) {
+		ret = vfio_pci_cxl_get_region_info(vdev, info, caps);
+		if (ret != -ENOTTY)
+			return ret;
+	}
+
 	switch (info->index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
@@ -1811,6 +1847,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
+	/* Block mmap of the CXL component register block. */
+	if (vdev->cxl &&
+	    index == vfio_pci_cxl_get_component_reg_bar(vdev) &&
+	    vfio_pci_cxl_mmap_overlaps_comp_regs(vdev, req_start, req_len))
+		return -EINVAL;
+
 	/*
 	 * Even though we don't make use of the barmap for the mmap,
 	 * we need to request the region and the barmap tracks that.
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 94bf7c6a8548..88b89da6dd5a 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -114,6 +114,23 @@ int  vfio_pci_cxl_acquire(struct vfio_pci_core_device *vdev);
 void vfio_pci_cxl_release(struct vfio_pci_core_device *vdev);
 int  vfio_pci_cxl_open(struct vfio_pci_core_device *vdev);
 void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev);
+size_t vfio_pci_cxl_config_boundary(struct vfio_pci_core_device *vdev,
+				    loff_t pos);
+ssize_t vfio_pci_cxl_config_rw(struct vfio_pci_core_device *vdev,
+			       loff_t pos, size_t count, __le32 *val,
+			       bool iswrite);
+int vfio_pci_cxl_get_info(struct vfio_pci_core_device *vdev,
+			  struct vfio_info_cap *caps);
+int vfio_pci_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+				 struct vfio_region_info *info,
+				 struct vfio_info_cap *caps);
+u8   vfio_pci_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev);
+bool vfio_pci_cxl_get_comp_reg_range(struct vfio_pci_core_device *vdev,
+				     size_t *start, size_t *end);
+bool vfio_pci_cxl_mmap_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+					  u64 req_start, u64 req_len);
+bool vfio_pci_cxl_bar_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+					 int bar, u64 start, u64 len);
 #else
 static inline int vfio_pci_cxl_acquire(struct vfio_pci_core_device *vdev)
 {
@@ -128,6 +145,61 @@ static inline int vfio_pci_cxl_open(struct vfio_pci_core_device *vdev)
 }
 
 static inline void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev) { }
+
+static inline size_t
+vfio_pci_cxl_config_boundary(struct vfio_pci_core_device *vdev, loff_t pos)
+{
+	return SIZE_MAX;
+}
+
+static inline ssize_t
+vfio_pci_cxl_config_rw(struct vfio_pci_core_device *vdev, loff_t pos,
+		       size_t count, __le32 *val, bool iswrite)
+{
+	return -ENOENT;
+}
+
+static inline int
+vfio_pci_cxl_get_info(struct vfio_pci_core_device *vdev,
+		      struct vfio_info_cap *caps)
+{
+	return 0;
+}
+
+static inline int
+vfio_pci_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			     struct vfio_region_info *info,
+			     struct vfio_info_cap *caps)
+{
+	return -ENOTTY;
+}
+
+static inline u8
+vfio_pci_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev)
+{
+	return U8_MAX;
+}
+
+static inline bool
+vfio_pci_cxl_get_comp_reg_range(struct vfio_pci_core_device *vdev,
+				size_t *start, size_t *end)
+{
+	return false;
+}
+
+static inline bool
+vfio_pci_cxl_mmap_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+				     u64 req_start, u64 req_len)
+{
+	return false;
+}
+
+static inline bool
+vfio_pci_cxl_bar_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+				    int bar, u64 start, u64 len)
+{
+	return false;
+}
 #endif
 
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 3bfbb879a005..a856f29a3c94 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -236,6 +236,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 
 	count = min(count, (size_t)(end - pos));
 
+	/*
+	 * Reject raw BAR access that would land inside the CXL component
+	 * register sub-range.  cxl-core owns the per-field shadow and
+	 * spec-defined write semantics; userspace must use the dedicated
+	 * COMP_REGS VFIO region for that range.
+	 */
+	if (vfio_pci_cxl_bar_overlaps_comp_regs(vdev, bar, pos, count))
+		return -EINVAL;
+
 	if (bar == PCI_ROM_RESOURCE) {
 		/*
 		 * The ROM can fill less space than the BAR, so we start the
@@ -437,6 +446,14 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
+	/*
+	 * Disallow ioeventfds arming against the CXL component register
+	 * sub-range; that area is fronted by cxl-core's shadow and must
+	 * not be reached through the raw BAR map.
+	 */
+	if (vfio_pci_cxl_bar_overlaps_comp_regs(vdev, bar, pos, count))
+		return -EINVAL;
+
 	if (count == 8)
 		return -EINVAL;
 
-- 
2.25.1

