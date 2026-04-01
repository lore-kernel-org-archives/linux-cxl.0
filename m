Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AC4779AA;
	Wed,  1 Apr 2026 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054498; cv=fail; b=oWqzBfQrx/8/13FNyCvfOSBbaJLKr0EJo3PSugWXCnLAFrrcDw91PQmufoKYkykYrYsuFdvprgc5U9ZdvhUiTQpCFPlhDxu7YZglZm7X3atWsx9wfy3Wy0oFtfVFgyQ3AoowbWmNAoMRbxD/npj9IuYCLpYZqAtQ5sg8EXU58Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054498; c=relaxed/simple;
	bh=y0LAzn6wmWEIPHqx8OHW05IXPw1vuAPcBEfCrxlLrOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TN7kqKzeIUW+ocO8pxvF7dunboSxEFIxG/XCVyxhtgMOv2kkq6/0Lgn75CTM13npAnCWw4JHLnnKjM/1s1fB0iibsfb67Uj4RwArVHAKIdZkca6yiiJMqK/9hb+P2OGfdiPD3Rcr9Rnxr3pm9aRMoR151zqfgDLnDV7dD0RVINk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRH/Fklg; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRH/Fklg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ6Sp0/LgKsvI7JCU78iTDkpLKNkpvq5xJby/l3Fl9joUyLIpX29nL7DhxluNTIu/zFh8fPduMerkSWWZYBjmVuFzw33FAwR7MRE37wOPHokMpeY88h0Q9XY5vZXJcGtM3GBHA9GsKZgHPHDU99n/66zra11Co+byXEpeVxdHPeVe/8egc+Xvo0PtJHheeR3oem2YQW+2L6HXUY3fw3LpOPnTQ+FSD9P+uRmJaI5Vka7YLzCEGlnwsem9hhyl3k+UBQsWcuWTH6bpJ8kRn7UYCLpZS1kVMcBzLxxnmPk44nKhUiJGykF53cCfIxEZy+So+qlHjwEyUfDd3pPH1kiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaDxrt6cd4fGPeUAxMAqZoGE4LyafNrpCYF347VFJlA=;
 b=QcW/HkqVzo04u8SUQuaLnYJNCaL3DvqZ+raWUFhQtmPkfzDn/EP/bX/yKjRD34RsNNv8e9jZHKfNKAq+soh+ZGMXh1Ofl4Xfx4A3d4NKrNpWiDFhdJi0CQ9SDgP/wKFB5e8fzylpp9AwCB61rz7NBBsXn47iPNCnc9ZQqb3pifAGEnIcQu42gWMtFbtA4LsxsRdpUz10ecQ9qZWKI8xKstNgMX7945C2iOtoO2Wezk4N8iZFeFoqh6yPNx9sK0WATeTnGcQWThyAkwRTlIExx3FT5xcFNTDBc/XNg7b+jDKTtwP4gczwLAeVuxfgRvTVXFjjCeJmyBWPrEwkU2Kynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaDxrt6cd4fGPeUAxMAqZoGE4LyafNrpCYF347VFJlA=;
 b=gRH/Fklgp14SiaiAIcH57XhKlWzi1lzgghvfMArlnia2kz35qyYa05TvkmpLSje3DxanJmo1hfGqD9jS2wl9S9+i/SW+w5ZfnyRTEv1ZygQxpFUG++Ysepfgj7QFTuuZufZuesTkIZ87e6p0sDoXH7V3LPGhqrf1kbCBnwSkAs7OFj9riVsweP9IAz+Log6e0aFGUt9VhNNsCXjDBcqxU/8qoqrdOguyru1UVf3R16ehgpP9oBfBiQamWv7wwH7bILxMT7HoJk8ML4VX77F2Twp+1yk5UG2lg1URM78bfcUi4xvcM0expFY9hckEw5lXlELx/TNXn1dhL6zmY8OLqg==
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:41:21 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::c0) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:00 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:53 -0700
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
Subject: [PATCH v2 11/20] vfio/cxl: Introduce HDM decoder register emulation framework
Date: Wed, 1 Apr 2026 20:09:08 +0530
Message-ID: <20260401143917.108413-12-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ed4a35-dddb-4a06-79e9-08de8ffcbe1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SFsjgg3sGCwiB6jk0cYRRqfjW+IcyMXQsXJC8ZJBRVxrgOLLaRu84vDesIFvVIsNah9G7TqoFd6hPXiEPIvoy+ZJ1dV4UvJRuXrGNhLuKXsH/Qu2+kwlVEhkLfpQsZu/x8VpV3MCcGHtch0GRMJQOdBTFm4BSX8pL+LmjqYzt/32pZf7Eyn5PQHHknSmX3p+65COmm7bY3av5cd2JJPwPz3BvLigkluj65yyfSGrM5/k6mXyBTtS3z1k+DPZhAJL/59u++rDjhGvEpU2rdDO/q8JIZ7XY9+y82vpjPV+YKlAwh8ZjIMDVLRkW1TpoLHI1hkmXvRn6R+J//KkGU7qyYEJX5YSOsW3YivNWO7+eCYPgJzobNBlkp2HEWFABBXCHBhy2P/KiE5x14oZpSqJsfZ9EL5h7Oyc7nylQtD6KG4IDXDgfR2RWwN1aizpQ8OKoq1XTLRyjcc+vIL3+ok4HitPy8flnrKYemgvzgtqudUkWV7ILfjIhldLxqj+Zi4Px24KstcwTIaMuJUt39iymE1DrDvIi9FaXEtKdVRYXraIaINZL6/6BxJV+ead2wZ3fwMqSzCSUEsljh/XWrqzqEhQAd0B/5IvYCcMbuwTLVqx7dQ0+nw9s0aBqSYn0klqeHBOlPWrxNuxfuG+EDm7U6GD7+8YlSfxpkBYSTObef2Qtr9ZGpPh7HGjAtCIQQlDHX3MFtKwRgyHbnlPEjXx5cXjmm9Tgcvi5eSi1amFAdoEaOYUloAPe986HI5hKTdUZhHlmYu24HP70zYIMPvcWIrUmlGb3lGtiD+glkZanMF5IvykoXFeGq0+60nLMZlY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8A19Ad2QYiDp+s8Ea2iXTKA/z522kDI+mB+Bk3T9y02d7Fb+9Ycbyaor+QJTC20MJzL2V/x+KvCzG1OM20Y9asb6n+bVAlHRQ47WUhrQZDJf2dDcurLIhnwCToKhT1BLktTqHZESFOylzwo20Kw5XbOW9jXGhuHOrcLDs5P/GDlwiJzH1b6IG+759lqngPm9j9kX9YOkvpB4RFFy1JXl7k7nUmSYkQudIrJTEDgoMD3AW1UQU8ynNHu+fqPelfw3TMMOq2dYi6oeLD8hnykhkt8AXYYh+tZXL7A02pBeEXO2CqHrRBbEJeullobDMvpZV1OicygSxLRX4UZ2uAHOzZin6gFPnNoArPSix5HJZkmKsKM07O6S3QXspOtvD/vgwoFcVJXHLNTDkbDYlhybEWkrcsJzxGePiA8cC04j8wOB/EZvksKHVMxrqig/uJc6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:21.5221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ed4a35-dddb-4a06-79e9-08de8ffcbe1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

From: Manish Honap <mhonap@nvidia.com>

Add HDM decoder register emulation for CXL devices assigned to a guest.

New file vfio_cxl_emu.c allocates comp_reg_virt[] covering the full
component register block (CXL_COMPONENT_REG_BLOCK_SIZE), snapshots it
from MMIO after probe, and registers a VFIO device region
(VFIO_REGION_SUBTYPE_CXL_COMP_REGS) with read/write ops but no mmap,
so every access hits the emulated buffer and write dispatchers.

vfio_cxl_setup_virt_regs() is called from the tail of
vfio_cxl_setup_regs(); vfio_cxl_clean_virt_regs() runs on cleanup.

HDM decoder register defines come from include/uapi/cxl/cxl_regs.h.
Bits with no hardware equivalent stay in vfio_cxl_priv.h.

hdm_decoder_n_ctrl_write() allows the guest to clear the LOCK bit.
A firmware-committed decoder arrives with LOCK=1; the guest driver
must clear it before reprogramming BASE and SIZE with the VM's GPA.
Such a write clears the bit in the shadow while preserving all other
fields.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/Makefile            |   2 +-
 drivers/vfio/pci/cxl/vfio_cxl_core.c |   5 +
 drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 433 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  47 +++
 include/uapi/cxl/cxl_regs.h          |   5 +
 5 files changed, 491 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_emu.c

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index ecb0eacbc089..bef916495eae 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
-vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o
+vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o cxl/vfio_cxl_emu.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index b1c7603590b5..0b9e4419cd47 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -149,8 +149,11 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev,
 	cxl->comp_reg_offset = bar_offset;
 	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
+	ret = vfio_cxl_setup_virt_regs(vdev, cxl, base);
 	iounmap(base);
 	release_mem_region(map->resource, map->max_size);
+	if (ret)
+		return ret;
 
 	return 0;
 
@@ -253,6 +256,8 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 
 	if (!cxl)
 		return;
+
+	vfio_cxl_clean_virt_regs(cxl);
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
new file mode 100644
index 000000000000..6fb02253e631
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include <linux/bitops.h>
+#include <linux/vfio_pci_core.h>
+
+#include "../vfio_pci_priv.h"
+#include "vfio_cxl_priv.h"
+
+/*
+ * comp_reg_virt[] shadow layout:
+ *   Covers the full CXL.mem register area (starting at CXL_CM_OFFSET
+ *   within the component register block).  Index 0 is the CXL Capability
+ *   Array Header; the HDM decoder block starts at index
+ *   hdm_reg_offset / sizeof(__le32).
+ *
+ * Register layout within the HDM block (CXL spec 4.0 8.2.4.20 CXL HDM Decoder
+ * Capability Structure):
+ *   0x00: HDM Decoder Capability
+ *   0x04: HDM Decoder Global Control
+ *   0x08: (reserved)
+ *   0x0c: (reserved)
+ *   For each decoder N (N=0..hdm_count-1), at base 0x10 + N*0x20:
+ *     +0x00: BASE_LO
+ *     +0x04: BASE_HI
+ *     +0x08: SIZE_LO
+ *     +0x0c: SIZE_HI
+ *     +0x10: CTRL
+ *     +0x14: TARGET_LIST_LO
+ *     +0x18: TARGET_LIST_HI
+ *     +0x1c: (reserved)
+ */
+
+static inline __le32 *hdm_reg_ptr(struct vfio_pci_cxl_state *cxl, u32 hdm_off)
+{
+	/*
+	 * hdm_off is a byte offset within the HDM decoder block.
+	 * comp_reg_virt covers the CXL.mem register area starting at
+	 * CXL_CM_OFFSET within the component register block.
+	 * hdm_reg_offset is CXL.mem-relative, so adding hdm_reg_offset
+	 * gives the correct index into comp_reg_virt[].
+	 */
+	return &cxl->comp_reg_virt[(cxl->hdm_reg_offset + hdm_off) /
+				   sizeof(__le32)];
+}
+
+static ssize_t virt_hdm_rev_reg_write(struct vfio_pci_core_device *vdev,
+				      const __le32 *val32, u64 offset, u64 size)
+{
+	/* Discard writes on reserved registers. */
+	return size;
+}
+
+static ssize_t hdm_decoder_n_lo_write(struct vfio_pci_core_device *vdev,
+				      const __le32 *val32, u64 offset, u64 size)
+{
+	u32 new_val = le32_to_cpu(*val32);
+
+	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
+		return -EINVAL;
+
+	/* Bits [27:0] are reserved. */
+	new_val &= ~CXL_HDM_DECODER_BASE_LO_RESERVED_MASK;
+
+	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
+
+	return size;
+}
+
+static ssize_t hdm_decoder_global_ctrl_write(struct vfio_pci_core_device *vdev,
+					     const __le32 *val32, u64 size)
+{
+	u32 hdm_gcap;
+	u32 new_val = le32_to_cpu(*val32);
+
+	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
+		return -EINVAL;
+
+	/* Bit [31:2] are reserved. */
+	new_val &= ~CXL_HDM_DECODER_GLOBAL_CTRL_RESERVED_MASK;
+
+	/* Poison On Decode Error Enable (bit 0) is RO=0 if not supported. */
+	hdm_gcap = le32_to_cpu(*hdm_reg_ptr(vdev->cxl,
+					    CXL_HDM_DECODER_CAP_OFFSET));
+	if (!(hdm_gcap & CXL_HDM_DECODER_POISON_ON_DECODE_ERR))
+		new_val &= ~CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT;
+
+	*hdm_reg_ptr(vdev->cxl, CXL_HDM_DECODER_CTRL_OFFSET) =
+		cpu_to_le32(new_val);
+
+	return size;
+}
+
+/**
+ * hdm_decoder_n_ctrl_write - Write handler for HDM decoder CTRL register.
+ * @vdev:   VFIO PCI core device
+ * @val32:  New register value supplied by userspace (little-endian)
+ * @offset: Byte offset within the HDM block for this decoder's CTRL register
+ * @size:   Access size in bytes; must equal CXL_REG_SIZE_DWORD
+ *
+ * The COMMIT bit (bit 9) is the key: setting it requests the hardware to
+ * lock the decoder.  The emulated COMMITTED bit (bit 10) mirrors COMMIT
+ * immediately to allow QEMU's notify_change to detect the transition and
+ * map/unmap the DPA MemoryRegion in the guest address space.
+ *
+ * Note: the actual hardware HDM decoder programming (writing the real
+ * BASE/SIZE with host physical addresses) happens in the QEMU notify_change
+ * callback BEFORE this write reaches the hardware.  This ordering is
+ * correct because vfio_region_write() calls notify_change() first.
+ *
+ * Return: @size on success, %-EINVAL if @size is not %CXL_REG_SIZE_DWORD.
+ */
+static ssize_t hdm_decoder_n_ctrl_write(struct vfio_pci_core_device *vdev,
+					const __le32 *val32, u64 offset, u64 size)
+{
+	u32 hdm_gcap;
+	u32 ro_mask = CXL_HDM_DECODER_CTRL_RO_BITS_MASK;
+	u32 rev_mask = CXL_HDM_DECODER_CTRL_RESERVED_MASK;
+	u32 new_val = le32_to_cpu(*val32);
+	u32 cur_val;
+
+	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
+		return -EINVAL;
+
+	cur_val = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, offset));
+	if (cur_val & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (new_val & CXL_HDM_DECODER0_CTRL_LOCK)
+			return size;
+
+		/* LOCK_0 only: preserve all other bits, clear LOCK */
+		*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(
+			cur_val & ~CXL_HDM_DECODER0_CTRL_LOCK);
+		return size;
+	}
+
+	hdm_gcap = le32_to_cpu(*hdm_reg_ptr(vdev->cxl,
+					    CXL_HDM_DECODER_CAP_OFFSET));
+	ro_mask |= CXL_HDM_DECODER_CTRL_DEVICE_BITS_RO;
+	rev_mask |= CXL_HDM_DECODER_CTRL_DEVICE_RESERVED;
+
+	if (!(hdm_gcap & CXL_HDM_DECODER_UIO_CAPABLE))
+		rev_mask |= CXL_HDM_DECODER_CTRL_UIO_RESERVED;
+
+	new_val &= ~rev_mask;
+	cur_val &= ro_mask;
+	new_val = (new_val & ~ro_mask) | cur_val;
+
+	/*
+	 * Mirror COMMIT to COMMITTED immediately in the emulated state.
+	 */
+	if (new_val & CXL_HDM_DECODER0_CTRL_COMMIT)
+		new_val |= CXL_HDM_DECODER0_CTRL_COMMITTED;
+	else
+		new_val &= ~CXL_HDM_DECODER0_CTRL_COMMITTED;
+
+	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
+
+	return size;
+}
+
+/*
+ * Dispatch table for COMP_REGS region writes. Indexed by byte offset within
+ * the HDM decoder block. Returns the appropriate write handler.
+ *
+ * Layout:
+ *   0x00	  HDM Decoder Capability  (RO)
+ *   0x04	  HDM Global Control	  (RW with reserved masking)
+ *   0x08-0x0f	  (reserved)		  (ignored)
+ *   Per decoder N, base = 0x10 + N*0x20:
+ *     base+0x00  BASE_LO  (RW, [27:0] reserved)
+ *     base+0x04  BASE_HI  (RW)
+ *     base+0x08  SIZE_LO  (RW, [27:0] reserved)
+ *     base+0x0c  SIZE_HI  (RW)
+ *     base+0x10  CTRL	   (RW, complex rules)
+ *     base+0x14  TARGET_LIST_LO  (ignored for Type-2)
+ *     base+0x18  TARGET_LIST_HI  (ignored for Type-2)
+ *     base+0x1c  (reserved)	 (ignored)
+ */
+static ssize_t comp_regs_dispatch_write(struct vfio_pci_core_device *vdev,
+					u32 off, const __le32 *val32, u32 size)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 dec_base, dec_off;
+
+	/* HDM Decoder Capability (0x00): RO */
+	if (off == CXL_HDM_DECODER_CAP_OFFSET)
+		return size;
+
+	/* HDM Global Control (0x04) */
+	if (off == CXL_HDM_DECODER_CTRL_OFFSET)
+		return hdm_decoder_global_ctrl_write(vdev, val32, size);
+
+	/*
+	 * Offsets 0x08-0x0f are reserved per CXL 4.0 Table 8-115.
+	 * Per-decoder registers start at 0x10, stride 0x20
+	 */
+	if (off < CXL_HDM_DECODER_FIRST_BLOCK_OFFSET)
+		return size; /* reserved gap */
+
+	dec_base = CXL_HDM_DECODER_FIRST_BLOCK_OFFSET;
+	/*
+	 * Reject accesses beyond the last implemented HDM decoder.
+	 * Without this check an out-of-bounds offset would silently
+	 * corrupt comp_reg_virt[] memory past the end of the allocation.
+	 */
+	if ((off - dec_base) / CXL_HDM_DECODER_BLOCK_STRIDE >= cxl->hdm_count)
+		return size;
+
+	dec_off = (off - dec_base) % CXL_HDM_DECODER_BLOCK_STRIDE;
+
+	switch (dec_off) {
+	case CXL_HDM_DECODER_N_BASE_LOW_OFFSET:	 /* BASE_LO */
+	case CXL_HDM_DECODER_N_SIZE_LOW_OFFSET:	 /* SIZE_LO */
+		return hdm_decoder_n_lo_write(vdev, val32, off, size);
+	case CXL_HDM_DECODER_N_BASE_HIGH_OFFSET: /* BASE_HI */
+	case CXL_HDM_DECODER_N_SIZE_HIGH_OFFSET: /* SIZE_HI */
+	{
+		/* Full 32-bit write, no reserved bits; frozen when COMMIT_LOCK set */
+		u32 ctrl_off = off - dec_off + CXL_HDM_DECODER_N_CTRL_OFFSET;
+		u32 ctrl = le32_to_cpu(*hdm_reg_ptr(cxl, ctrl_off));
+
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			return size;
+		*hdm_reg_ptr(cxl, off) = *val32;
+		return size;
+	}
+	case CXL_HDM_DECODER_N_CTRL_OFFSET:	  /* CTRL */
+		return hdm_decoder_n_ctrl_write(vdev, val32, off, size);
+	case CXL_HDM_DECODER_N_TARGET_LIST_LOW_OFFSET:
+	case CXL_HDM_DECODER_N_TARGET_LIST_HIGH_OFFSET:
+	case CXL_HDM_DECODER_N_REV_OFFSET:
+		return virt_hdm_rev_reg_write(vdev, val32, off, size);
+	default:
+		return size;
+	}
+}
+
+/*
+ * vfio_cxl_comp_regs_rw - regops rw handler for
+ * VFIO_REGION_SUBTYPE_CXL_COMP_REGS.
+ *
+ * Reads return the emulated HDM state (comp_reg_virt[]).
+ * Writes go through comp_regs_dispatch_write() for bit-field enforcement.
+ * Only 4-byte aligned 4-byte accesses are supported (hardware requirement).
+ */
+static ssize_t vfio_cxl_comp_regs_rw(struct vfio_pci_core_device *vdev,
+				     char __user *buf, size_t count,
+				     loff_t *ppos, bool iswrite)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	size_t done = 0;
+
+	if (!count)
+		return 0;
+
+	/* Clamp to total region size: cap array prefix + HDM block */
+	if (pos >= cxl->hdm_reg_offset + cxl->hdm_reg_size)
+		return -EINVAL;
+	count = min(count,
+		    (size_t)(cxl->hdm_reg_offset + cxl->hdm_reg_size - pos));
+
+	while (done < count) {
+		u32 sz	 = count - done;
+		u32 off	 = pos + done;
+		__le32 v;
+
+		/* Enforce exactly 4-byte, 4-byte-aligned accesses */
+		if (sz != CXL_REG_SIZE_DWORD || (off & 0x3))
+			return done ? (ssize_t)done : -EINVAL;
+
+		if (iswrite) {
+			if (off < cxl->hdm_reg_offset) {
+				/* Cap array area is read-only; discard writes */
+				done += sizeof(v);
+				continue;
+			}
+			if (copy_from_user(&v, buf + done, sizeof(v)))
+				return done ? (ssize_t)done : -EFAULT;
+			comp_regs_dispatch_write(vdev,
+						 off - cxl->hdm_reg_offset,
+						 &v, sizeof(v));
+		} else {
+			/* Read from extended buffer _ covers cap array and HDM */
+			v = cxl->comp_reg_virt[off / sizeof(__le32)];
+			if (copy_to_user(buf + done, &v, sizeof(v)))
+				return done ? (ssize_t)done : -EFAULT;
+		}
+		done += sizeof(v);
+	}
+
+	*ppos += done;
+	return done;
+}
+
+static void vfio_cxl_comp_regs_release(struct vfio_pci_core_device *vdev,
+				       struct vfio_pci_region *region)
+{
+	/* comp_reg_virt is freed in vfio_cxl_clean_virt_regs() */
+}
+
+static const struct vfio_pci_regops vfio_cxl_comp_regs_ops = {
+	.rw	 = vfio_cxl_comp_regs_rw,
+	.release = vfio_cxl_comp_regs_release,
+};
+
+/*
+ * vfio_cxl_setup_virt_regs - Allocate emulated HDM register state.
+ *
+ * Allocates comp_reg_virt as a compact __le32 array covering only
+ * hdm_reg_size bytes of HDM decoder registers. The initial values
+ * are read from hardware via the BAR ioremap established by the caller.
+ *
+ * DVSEC state is accessed via vdev->vconfig (see the following patch).
+ */
+int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev,
+			     struct vfio_pci_cxl_state *cxl,
+			     void __iomem *cap_base)
+{
+	size_t total_size, nregs, i;
+
+	if (WARN_ON(!cxl->hdm_reg_size))
+		return -EINVAL;
+
+	total_size = cxl->hdm_reg_offset + cxl->hdm_reg_size;
+
+	if (pci_resource_len(vdev->pdev, cxl->comp_reg_bar) <
+	    cxl->comp_reg_offset + CXL_CM_OFFSET + total_size)
+		return -ENODEV;
+
+	nregs = total_size / sizeof(__le32);
+	cxl->comp_reg_virt = kcalloc(nregs, sizeof(__le32), GFP_KERNEL);
+	if (!cxl->comp_reg_virt)
+		return -ENOMEM;
+
+	/*
+	 * Snapshot the CXL.mem register area from the caller's mapping.
+	 * cap_base maps the component register block from comp_reg_offset.
+	 * The CXL.mem registers start at CXL_CM_OFFSET (= 0x1000) within that
+	 * block; reading from cap_base + CXL_CM_OFFSET ensures comp_reg_virt[0]
+	 * holds the CXL Capability Array Header required by guest drivers.
+	 */
+	for (i = 0; i < nregs; i++)
+		cxl->comp_reg_virt[i] =
+			cpu_to_le32(readl(cap_base + CXL_CM_OFFSET +
+					  i * sizeof(__le32)));
+
+	/*
+	 * Establish persistent mapping; kept alive until
+	 * vfio_cxl_clean_virt_regs().
+	 */
+	cxl->hdm_iobase = ioremap(pci_resource_start(vdev->pdev,
+						     cxl->comp_reg_bar) +
+				  cxl->comp_reg_offset + CXL_CM_OFFSET +
+				  cxl->hdm_reg_offset,
+				  cxl->hdm_reg_size);
+	if (!cxl->hdm_iobase) {
+		kfree(cxl->comp_reg_virt);
+		cxl->comp_reg_virt = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Called with memory_lock write side held (from vfio_cxl_reactivate_region).
+ * Uses the pre-established hdm_iobase, no ioremap() under the lock,
+ * which would deadlock on PREEMPT_RT where ioremap() can sleep.
+ */
+void vfio_cxl_reinit_comp_regs(struct vfio_pci_cxl_state *cxl)
+{
+	size_t i, nregs;
+	u32 n;
+
+	if (!cxl || !cxl->comp_reg_virt || !cxl->hdm_iobase)
+		return;
+
+	nregs = cxl->hdm_reg_size / sizeof(__le32);
+
+	for (i = 0; i < nregs; i++)
+		*hdm_reg_ptr(cxl, i * sizeof(__le32)) =
+			cpu_to_le32(readl(cxl->hdm_iobase +
+					  i * sizeof(__le32)));
+
+	/*
+	 * For firmware-committed decoders, clear COMMIT_LOCK (bit 8) and zero
+	 * BASE in comp_reg_virt[] so QEMU can write the correct guest GPA via
+	 * setup_locked_hdm() before guest DPA access begins.
+	 *
+	 * Check the COMMITTED bit (bit 10) directly from the freshly-snapshotted
+	 * ctrl register rather than relying on cxl->precommitted.  At probe time
+	 * this function is called before cxl->precommitted is set (it is set
+	 * after vfio_cxl_read_committed_decoder_size() succeeds), so using
+	 * cxl->precommitted here would silently skip the LOCK clearing and leave
+	 * the hardware HPA in comp_reg_virt[].
+	 */
+	for (n = 0; n < cxl->hdm_count; n++) {
+		u32 ctrl_off = CXL_HDM_DECODER_FIRST_BLOCK_OFFSET +
+			n * CXL_HDM_DECODER_BLOCK_STRIDE +
+			CXL_HDM_DECODER_N_CTRL_OFFSET;
+		u32 base_lo_off = CXL_HDM_DECODER_FIRST_BLOCK_OFFSET +
+			n * CXL_HDM_DECODER_BLOCK_STRIDE +
+			CXL_HDM_DECODER_N_BASE_LOW_OFFSET;
+		u32 base_hi_off = CXL_HDM_DECODER_FIRST_BLOCK_OFFSET +
+			n * CXL_HDM_DECODER_BLOCK_STRIDE +
+			CXL_HDM_DECODER_N_BASE_HIGH_OFFSET;
+		u32 ctrl = le32_to_cpu(*hdm_reg_ptr(cxl, ctrl_off));
+
+		if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+			continue;
+
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+			*hdm_reg_ptr(cxl, ctrl_off) =
+				cpu_to_le32(ctrl &
+					    ~CXL_HDM_DECODER0_CTRL_LOCK);
+			*hdm_reg_ptr(cxl, base_lo_off) = 0;
+			*hdm_reg_ptr(cxl, base_hi_off) = 0;
+		}
+	}
+}
+
+void vfio_cxl_clean_virt_regs(struct vfio_pci_cxl_state *cxl)
+{
+	if (cxl->hdm_iobase) {
+		iounmap(cxl->hdm_iobase);
+		cxl->hdm_iobase = NULL;
+	}
+	kfree(cxl->comp_reg_virt);
+	cxl->comp_reg_virt = NULL;
+}
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 54b1f6d885aa..463a55062144 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -21,12 +21,53 @@ struct vfio_pci_cxl_state {
 	size_t                       hdm_reg_size;
 	resource_size_t              comp_reg_offset;
 	size_t                       comp_reg_size;
+	__le32                      *comp_reg_virt;
+	void __iomem                *hdm_iobase;
 	u16                          dvsec_len;
 	u8                           hdm_count;
 	u8                           comp_reg_bar;
 	bool                         cache_capable;
 };
 
+/* Register access sizes */
+#define CXL_REG_SIZE_WORD  2
+#define CXL_REG_SIZE_DWORD 4
+
+/* HDM Decoder - register offsets (CXL 4.0 Table 8-115) */
+#define CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET        0x4
+#define CXL_HDM_DECODER_FIRST_BLOCK_OFFSET        0x10
+#define CXL_HDM_DECODER_BLOCK_STRIDE              0x20
+#define CXL_HDM_DECODER_N_BASE_LOW_OFFSET         0x0
+#define CXL_HDM_DECODER_N_BASE_HIGH_OFFSET        0x4
+#define CXL_HDM_DECODER_N_SIZE_LOW_OFFSET         0x8
+#define CXL_HDM_DECODER_N_SIZE_HIGH_OFFSET        0xc
+#define CXL_HDM_DECODER_N_CTRL_OFFSET             0x10
+#define CXL_HDM_DECODER_N_TARGET_LIST_LOW_OFFSET  0x14
+#define CXL_HDM_DECODER_N_TARGET_LIST_HIGH_OFFSET 0x18
+#define CXL_HDM_DECODER_N_REV_OFFSET              0x1c
+
+/*
+ * HDM Decoder N Control emulation masks.
+ *
+ * Single-bit hardware definitions are in <uapi/cxl/cxl_regs.h> as
+ * CXL_HDM_DECODER0_CTRL_* (bits 0-14) and CXL_HDM_DECODER_*_CAP.
+ * The masks below express emulation policy for a CXL.mem device.
+ */
+#define CXL_HDM_DECODER_CTRL_RO_BITS_MASK    (BIT(10) | BIT(11))
+#define CXL_HDM_DECODER_CTRL_RESERVED_MASK   (BIT(15) | GENMASK(31, 28))
+#define CXL_HDM_DECODER_CTRL_DEVICE_BITS_RO  BIT(12)
+#define CXL_HDM_DECODER_CTRL_DEVICE_RESERVED (GENMASK(19, 16) | GENMASK(23, 20))
+#define CXL_HDM_DECODER_CTRL_UIO_RESERVED    (BIT(14) | GENMASK(27, 24))
+/*
+ * bit 13 (BI) is RsvdP for devices without CXL.cache (Cache_Capable=0).
+ * HDM-D (CXL.mem only) decoders must not have BI set by the guest.
+ */
+#define CXL_HDM_DECODER_CTRL_BI_RESERVED          BIT(13)
+#define CXL_HDM_DECODER_BASE_LO_RESERVED_MASK     GENMASK(27, 0)
+
+#define CXL_HDM_DECODER_GLOBAL_CTRL_RESERVED_MASK GENMASK(31, 2)
+#define CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT BIT(0)
+
 /*
  * CXL DVSEC for CXL Devices - register offsets within the DVSEC
  * (CXL 4.0 8.1.3).
@@ -37,4 +78,10 @@ struct vfio_pci_cxl_state {
 /* CXL DVSEC Capability register bit 0: device supports CXL.cache (HDM-DB) */
 #define CXL_DVSEC_CACHE_CAPABLE	    BIT(0)
 
+int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev,
+			     struct vfio_pci_cxl_state *cxl,
+			     void __iomem *cap_base);
+void vfio_cxl_clean_virt_regs(struct vfio_pci_cxl_state *cxl);
+void vfio_cxl_reinit_comp_regs(struct vfio_pci_cxl_state *cxl);
+
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
index 1a48a3805f52..b6fcae91d216 100644
--- a/include/uapi/cxl/cxl_regs.h
+++ b/include/uapi/cxl/cxl_regs.h
@@ -33,8 +33,13 @@
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK __GENMASK(7, 4)
 #define   CXL_HDM_DECODER_INTERLEAVE_11_8 _BITUL(8)
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 _BITUL(9)
+#define   CXL_HDM_DECODER_POISON_ON_DECODE_ERR _BITUL(10)
 #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY _BITUL(11)
 #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY _BITUL(12)
+#define   CXL_HDM_DECODER_UIO_CAPABLE _BITUL(13)
+#define   CXL_HDM_DECODER_UIO_COUNT_MASK __GENMASK(19, 16)
+#define   CXL_HDM_DECODER_MEMDATA_NXM _BITUL(20)
+#define   CXL_HDM_DECODER_COHERENCY_MODELS_MASK    __GENMASK(22, 21)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE _BITUL(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
-- 
2.25.1

