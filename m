Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CB477E57;
	Wed,  1 Apr 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054538; cv=fail; b=qRKAwIFJPo2Q0KjfeXKD7QUgEEjNNxMkmm4QQPQO3MSDLXxqpTh3tji0IItV00bNFAN/YB/IIlS765AI7sOVySUtFzW5RqKwqCx0YoVIzyjR7SzUTcVHJrN7lM67DbOsRphmUiMCkmrYEqlgx9IGFjB9bTqQFK2f3n6J4O401Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054538; c=relaxed/simple;
	bh=Q8L38PngQ/l5jlQqLw0Qz6hxnRAFOagekruDrGlHjaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/5fSazTOiz034ONDqZX6HVTw1Xm1QsqHrREAs2gf+OgH+QPm40JPXM2ZKYwfyqxROj1aHVBs4b9TrBZ2D5NLtD/t9EHDrshbwx1pt5GlycdBy1BuddEICSvX/RZlrAhSxhB3n1NXZNT7XpcFYKYkwuECyVaLUa7qQN4eLUBQWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q6Wj6AIO; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q6Wj6AIO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRS1GNLl8eMsLeJzJbFC74AzeW7ufe4n8IAqJubKdeJ4Nd1RIhdugMVoobibRnRQMBFVy01solc73JVj3X97p9qHmzsyWmaQdBeZSPz8bFdl4sIsF5v9LdVq+MK00YOOYbPiH1R+ZPz3BVuePfbQTDesqEUkLDY4xVnmLDPvEOrBvBF/ID56edUaeB5f/TTcszfxWhiYbFCXMQr9+NExDQpQi792H4OxwP9v8/XL58TWf+Z5FaTfhNV3MEgII7d958zUpN7WY5GuaRNYarqDRp5ALDUBRax/tVaCsb4Ksh2NBhjfi2sFpMirdeIyjarGIEZP0Li1Jta8udK8Y0uaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRo3g7TSxllD68CKogqDR9t9boDiDW4RxoBnuNW9ZjM=;
 b=JUiQpzA5k1ofwmmiCu1GeYUDP5BpMCC3DmwdFQ58knATeRUrxQ+rEOsGuvpV60DCIpsBl+IZplJId4B4sj3lAEnqyuslqtDzxlDudvTczt3gSVbVfCuMvq4zj8vUhVy2Vi71rBF62cqxiN3Kk85rC4fmzj4OSng5FICNZdIaHtSX6tKJ/eYHGOlM6Oo2ufkh1+Q7IEmml9G5W0ik0hldn+HYqmS7ruSxEIPwHs28zxpfzK5YHLcVRR3itHL5Jumy/tfMX2a9cpfXiva7Ps24RVFVxER9c3lE2R52oM6Qi2nEBeO/O8lSmyPOIg5hUa0VCQ50EPz+YcFbU0wayDoyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRo3g7TSxllD68CKogqDR9t9boDiDW4RxoBnuNW9ZjM=;
 b=q6Wj6AIOTHMyWdXFpUEk1LkjcVTDmTLhuZsr5V+Rw5YTKeC6YeqCjLkLzO4m8aTtf9aviWdydPW43di2wxllOP3Cxne+Xo2gkuls2vMHVAMc0JoLlUkcFCar8gLECAH0pE9oWtT+OqQrLHNo1MLmUECLw4m/bunGNZ2QIHKUdWBHi1btFMWZ6TEJcp0MlUqLpmHmZ/8ndA/Rvqemdrld0bxnLU5yOTEqQTPQNJRKDpsN9z/emC2XfZkmzfatXM+f6Qpbgw9mRHjY9cdCElWr7LSHB+3Q9GpzRf+89Q19MyigNqJvxdeYXiZV8iSBa6qPYWP8Fi5YgahPRAy5TeQmcg==
Received: from BN9PR03CA0244.namprd03.prod.outlook.com (2603:10b6:408:ff::9)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Wed, 1 Apr
 2026 14:42:08 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::1a) by BN9PR03CA0244.outlook.office365.com
 (2603:10b6:408:ff::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:42:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:44 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:36 -0700
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
Subject: [PATCH v2 17/20] vfio/pci: Advertise CXL cap and sparse component BAR to userspace
Date: Wed, 1 Apr 2026 20:09:14 +0530
Message-ID: <20260401143917.108413-18-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a526783-c39f-4a3b-7cdd-08de8ffcd9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dSbq/qmbreBdsh/X/osRac92Q4e0oAz6WLqv6aDiEaCpaO9wHccvJ80S9Yv5YE6KsnC/1S6CKPoKgoWkhqqU9BZ91XwjcEFJ++Y5O7hrZgcmEqoPPrxPq9bKkU1bCS/XT2/4TQhGABsMfcZ63ydYF1BnJSlZLyg7pKhcdsORQEAKRq4o8QXrtBjT8ZWgHG2OckF4wCRb+RnBkJtMW2aHBMdX2hOlr3KFOmTdW3dVR/X/EqQ2zKWT5RDCl31jQi2cvfjek0g3DUJvoJT43QTgec7sKcN3RGckFvrQk/88hf56grBgkHV80g/B2RpZjXSdUkzNQ88mRu7RhK76J5Nuo9q7sKe1oCAdU+gLlwUSkxM9+XxzAy9LH6P+6ed2YkU83gsFSmvsJ7Ma2ipV7q4iqXWaW8Au1iuOIP0UN+Nq5Fky7Y1LdnxbYBkSnMYxiSIUDrRLq4dfbYHxoXTu/VPtEANio/7StrsEABfcjGLnZ6Dmp4wPYst1CIkYBe31ruqfJAaB8l3v0b7L7hCs5wbuqbdzeR2ie3KQNsNtqsL8h+FX8833S/VRJFRFLgOzvw5Hh3NTFv06NqaFLTdUnbqKjFHSLLk6coejV1Zy0NUm+slZG5obzn/knBZz9rIESVi8i3UTprxofBrc/nFEJ7AyezNwaffkTAYuWMkz59pvawP2xWKkv0bHC07Z8tzPj8v+uG5er7S6BWnB1nlbd6UNENd8F70pUlfVvnwyVJ9SHqpQYUgOUaXRz5pWMhwq1cYOKR4EOgnyAOtNSc8sE2YamNx11RP8uXBKsNFMoEn6O1dgOeb7LqMHGm2vTtqaawDP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HqQx3YCHbZVLCr22rV7ElC7F7baeXHwpIqfuyDPtjeV0gACERuCip8Wzyjuwyi9DJP8kN+PZ9Cv/M5Us7B62j1Yynsa9HqV0Aqh6flN+eGqAW/Ad4F/xwgpu/fRlurZiJqdkD86Kx9ZcifN6CQyYhKo7s7MSFsZnGZqjZs6zLjjdVtiUE0AwwnxDCZ3TMhfLHrWrM8NsS0PVBwK3z+CDp1KUdOZrTFlf3N1IpAp80XHqXVAv35exD9/iwc4V69ahrDzwmLy+d2NH9Vdh+/5sGwI23nb6qEdWlogtooUHdzA6I7a+45JnSFKIN7YhZhs1Mv0Wod10zerjXma/mlcr7xzTx2UzJaFVzc9Myx/6x1hc8qmTPk7rL/i7MyWL5UGnG1fApYGQ41AlZqjNcfcZty81SOFUrGfux5dng6yrA5ySIDVxuLhk76tBt0gGuYvu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:42:07.7752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a526783-c39f-4a3b-7cdd-08de8ffcd9ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

From: Manish Honap <mhonap@nvidia.com>

Expose CXL device capability through the VFIO device info ioctl and give
userspace access to the GPU/accelerator register windows in the component
BAR while protecting the CXL component register block.

vfio_cxl_get_info() fills VFIO_DEVICE_INFO_CAP_CXL with the HDM register
BAR index and byte offset, commit flags, and VFIO region indices for the
DPA and COMP_REGS regions. HDM decoder count and the HDM block offset
within COMP_REGS are not populated; both are derivable from the CXL
Capability Array in the COMP_REGS region itself.

vfio_cxl_get_region_info() handles VFIO_DEVICE_GET_REGION_INFO for the
component register BAR. It builds a sparse-mmap capability that advertises
only the GPU/accelerator register windows, carving out the CXL component
register block. Three physical layouts are handled:

  Topology A  comp block at BAR end:    one area [0, comp_reg_offset)
  Topology B  comp block at BAR start:  one area [comp_end, bar_len)
  Topology C  comp block in the middle: two areas, one on each side

vfio_cxl_mmap_overlaps_comp_regs() checks whether an mmap request overlaps
[comp_reg_offset, comp_reg_offset + comp_reg_size). vfio_pci_core_mmap()
calls it to reject access to the component register block while allowing
mmap of the GPU register windows in the sparse capability. This replaces
the earlier blanket rejection of any mmap on the component BAR index.

Hook both helpers into vfio_pci_ioctl_get_info() and
vfio_pci_ioctl_get_region_info() in vfio_pci_core.c.

The component BAR cannot be claimed exclusively since the CXL subsystem
holds persistent sub-range iomem claims during HDM decoder setup.
pci_request_selected_regions() returns EBUSY; pass bars=0 to skip the
request and map directly via pci_iomap(). Physical ownership is assured
by driver binding.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 155 +++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  31 +++++-
 drivers/vfio/pci/vfio_pci_priv.h     |  24 +++++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  16 ++-
 4 files changed, 221 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index b38a04301660..46430cbfa962 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -21,6 +21,161 @@
 #include "../vfio_pci_priv.h"
 #include "vfio_cxl_priv.h"
 
+u8 vfio_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev)
+{
+	return vdev->cxl->comp_reg_bar;
+}
+
+int vfio_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			     struct vfio_region_info *info,
+			     struct vfio_info_cap *caps)
+{
+	unsigned long minsz = offsetofend(struct vfio_region_info, offset);
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	resource_size_t bar_len, comp_end;
+	u32 nr_areas, cap_size;
+	int ret;
+
+	if (!cxl)
+		return -ENOTTY;
+
+	if (!info)
+		return -ENOTTY;
+
+	if (info->argsz < minsz)
+		return -EINVAL;
+
+	if (info->index != cxl->comp_reg_bar)
+		return -ENOTTY;
+
+	/*
+	 * The device state is not fully initialised;
+	 * fall through to the default BAR handler.
+	 */
+	if (!cxl->comp_reg_size)
+		return -ENOTTY;
+
+	bar_len  = pci_resource_len(vdev->pdev, info->index);
+	comp_end = cxl->comp_reg_offset + cxl->comp_reg_size;
+
+	/*
+	 * Advertise the GPU/accelerator register windows as mmappable by
+	 * carving the CXL component register block out of the BAR.  The
+	 * number of sparse areas depends on where the block sits:
+	 *
+	 *  [A] comp block at BAR end  [gpu_regs | comp_regs]:
+	 *    comp_reg_offset > 0  &&  comp_end == bar_len
+	 *    = 1 area: [0, comp_reg_offset)
+	 *
+	 *  [B] comp block at BAR start [comp_regs | gpu_regs]:
+	 *    comp_reg_offset == 0 &&  comp_end < bar_len
+	 *    = 1 area: [comp_end, bar_len)
+	 *
+	 *  [C] comp block in middle    [gpu_regs | comp_regs | gpu_regs]:
+	 *    comp_reg_offset > 0  &&  comp_end < bar_len
+	 *    = 2 areas: [0, comp_reg_offset) and [comp_end, bar_len)
+	 */
+	if (cxl->comp_reg_offset > 0 && comp_end < bar_len)
+		nr_areas = 2;
+	else
+		nr_areas = 1;
+
+	cap_size = struct_size(sparse, areas, nr_areas);
+	sparse = kzalloc(cap_size, GFP_KERNEL);
+	if (!sparse)
+		return -ENOMEM;
+
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas = nr_areas;
+
+	if (nr_areas == 2) {
+		/* [C]: window before and after comp block */
+		sparse->areas[0].offset = 0;
+		sparse->areas[0].size   = cxl->comp_reg_offset;
+		sparse->areas[1].offset = comp_end;
+		sparse->areas[1].size   = bar_len - comp_end;
+	} else if (cxl->comp_reg_offset == 0) {
+		/* [B]: comp block at BAR start, window follows */
+		sparse->areas[0].offset = comp_end;
+		sparse->areas[0].size   = bar_len - comp_end;
+	} else {
+		/* [A]: comp block at BAR end, window precedes */
+		sparse->areas[0].offset = 0;
+		sparse->areas[0].size   = cxl->comp_reg_offset;
+	}
+
+	ret = vfio_info_add_capability(caps, &sparse->header, cap_size);
+	kfree(sparse);
+	if (ret)
+		return ret;
+
+	info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
+	info->size   = bar_len;
+	info->flags  = VFIO_REGION_INFO_FLAG_READ |
+		       VFIO_REGION_INFO_FLAG_WRITE |
+		       VFIO_REGION_INFO_FLAG_MMAP;
+
+	return 0;
+}
+
+bool vfio_cxl_mmap_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+				       u64 req_start, u64 req_len)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (!cxl->comp_reg_size)
+		return false;
+
+	return req_start < cxl->comp_reg_offset + cxl->comp_reg_size &&
+	       req_start + req_len > cxl->comp_reg_offset;
+}
+
+int vfio_cxl_get_info(struct vfio_pci_core_device *vdev,
+		      struct vfio_info_cap *caps)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	struct vfio_device_info_cap_cxl cxl_cap = {0};
+
+	if (!cxl)
+		return 0;
+
+	/*
+	 * Device is not fully initialised?
+	 */
+	if (WARN_ON(cxl->dpa_region_idx < 0 || cxl->comp_reg_region_idx < 0))
+		return -ENODEV;
+
+	/* Fill in from CXL device structure */
+	cxl_cap.header.id = VFIO_DEVICE_INFO_CAP_CXL;
+	cxl_cap.header.version = 1;
+	/*
+	 * COMP_REGS region starts at comp_reg_offset + CXL_CM_OFFSET within
+	 * the BAR.  This is the byte offset of the CXL.mem register area (where
+	 * the CXL Capability Array Header lives) within the component register
+	 * block. Userspace derives hdm_decoder_offset and hdm_count from the
+	 * COMP_REGS region itself (CXL Capability Array traversal + HDMC read).
+	 */
+	cxl_cap.hdm_regs_offset = cxl->comp_reg_offset + CXL_CM_OFFSET;
+	cxl_cap.hdm_regs_bar_index = cxl->comp_reg_bar;
+
+	if (cxl->precommitted)
+		cxl_cap.flags |= VFIO_CXL_CAP_FIRMWARE_COMMITTED;
+	if (cxl->cache_capable)
+		cxl_cap.flags |= VFIO_CXL_CAP_CACHE_CAPABLE;
+
+	/*
+	 * Populate absolute VFIO region indices so userspace can query them
+	 * directly with VFIO_DEVICE_GET_REGION_INFO.
+	 */
+	cxl_cap.dpa_region_index = VFIO_PCI_NUM_REGIONS + cxl->dpa_region_idx;
+	cxl_cap.comp_regs_region_index =
+		VFIO_PCI_NUM_REGIONS + cxl->comp_reg_region_idx;
+
+	return vfio_info_add_capability(caps, &cxl_cap.header, sizeof(cxl_cap));
+}
+
 /*
  * Scope-based cleanup wrappers for the CXL resource APIs
  */
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 48e0274c19aa..570775cc8711 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -591,7 +591,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
-	int i, bar;
+	int i, bar, bars;
 
 	/* For needs_reset */
 	lockdep_assert_held(&vdev->vdev.dev_set->lock);
@@ -650,8 +650,10 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		bar = i + PCI_STD_RESOURCES;
 		if (!vdev->barmap[bar])
 			continue;
+		bars = (vdev->cxl && i == vfio_cxl_get_component_reg_bar(vdev)) ?
+			0 : (1 << bar);
 		pci_iounmap(pdev, vdev->barmap[bar]);
-		pci_release_selected_regions(pdev, 1 << bar);
+		pci_release_selected_regions(pdev, bars);
 		vdev->barmap[bar] = NULL;
 	}
 
@@ -989,6 +991,13 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	if (vdev->reset_works)
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
+	if (vdev->cxl) {
+		ret = vfio_cxl_get_info(vdev, &caps);
+		if (ret)
+			return ret;
+		info.flags |= VFIO_DEVICE_FLAGS_CXL;
+	}
+
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 	info.num_irqs = VFIO_PCI_NUM_IRQS;
 
@@ -1034,6 +1043,12 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 	struct pci_dev *pdev = vdev->pdev;
 	int i, ret;
 
+	if (vdev->cxl) {
+		ret = vfio_cxl_get_region_info(vdev, info, caps);
+		if (ret != -ENOTTY)
+			return ret;
+	}
+
 	switch (info->index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
@@ -1768,6 +1783,18 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
+	/*
+	 * CXL devices: mmap is permitted for the GPU/accelerator register
+	 * windows listed in the sparse-mmap capability.  Block any request
+	 * that overlaps the CXL component register block
+	 * [comp_reg_offset, comp_reg_offset + comp_reg_size); those registers
+	 * must be accessed exclusively through the COMP_REGS device region so
+	 * that the emulation layer (notify_change) intercepts every write.
+	 */
+	if (vdev->cxl && index == vfio_cxl_get_component_reg_bar(vdev) &&
+	    vfio_cxl_mmap_overlaps_comp_regs(vdev, req_start, req_len))
+		return -EINVAL;
+
 	/*
 	 * Even though we don't make use of the barmap for the mmap,
 	 * we need to request the region and the barmap tracks that.
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index ae0091d5096c..2d4aadd1b35a 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -151,6 +151,14 @@ void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev);
 int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev);
 void vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev);
 int  vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev);
+int vfio_cxl_get_info(struct vfio_pci_core_device *vdev,
+		      struct vfio_info_cap *caps);
+int vfio_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			     struct vfio_region_info *info,
+			     struct vfio_info_cap *caps);
+u8 vfio_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev);
+bool vfio_cxl_mmap_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+				      u64 req_start, u64 req_len);
 
 #else
 
@@ -172,6 +180,22 @@ vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev) { }
 static inline int
 vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
 { return 0; }
+static inline int
+vfio_cxl_get_info(struct vfio_pci_core_device *vdev,
+		  struct vfio_info_cap *caps)
+{ return -ENOTTY; }
+static inline int
+vfio_cxl_get_region_info(struct vfio_pci_core_device *vdev,
+			 struct vfio_region_info *info,
+			 struct vfio_info_cap *caps)
+{ return -ENOTTY; }
+static inline u8
+vfio_cxl_get_component_reg_bar(struct vfio_pci_core_device *vdev)
+{ return U8_MAX; }
+static inline bool
+vfio_cxl_mmap_overlaps_comp_regs(struct vfio_pci_core_device *vdev,
+				 u64 req_start, u64 req_len)
+{ return false; }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index b38627b35c35..e95bdbdbcdb2 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -201,19 +201,29 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	int ret;
+	int ret, bars;
 	void __iomem *io;
 
 	if (vdev->barmap[bar])
 		return 0;
 
-	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
+	/*
+	 * The CXL component register BAR cannot be claimed exclusively: the
+	 * CXL subsystem holds persistent sub-range iomem claims during HDM
+	 * decoder setup. pci_request_selected_regions() for the full BAR
+	 * fails with EBUSY. Pass bars=0 to make the request a no-op and map
+	 * directly via pci_iomap().
+	 */
+	bars = (vdev->cxl && bar == vfio_cxl_get_component_reg_bar(vdev)) ?
+		0 : (1 << bar);
+
+	ret = pci_request_selected_regions(pdev, bars, "vfio");
 	if (ret)
 		return ret;
 
 	io = pci_iomap(pdev, bar, 0);
 	if (!io) {
-		pci_release_selected_regions(pdev, 1 << bar);
+		pci_release_selected_regions(pdev, bars);
 		return -ENOMEM;
 	}
 
-- 
2.25.1

