Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64464358375;
	Wed, 11 Mar 2026 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261430; cv=fail; b=vC7PexnryOpdQS4ZNWzK+J452Hj1t7AQLHs9YiJMuMHEw17YwA9Rrr24ofEVndiqbP0w1aY/mRH3YhpO95u8qXtwu4YtgAwuIZPEeRUN8VARCYooEvQQEArNDdRI/GNqN2bqyT+C83417BHyaz9DB4Uu2WHlJjEwu7I1JjBJAqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261430; c=relaxed/simple;
	bh=d6awq4FrYp29jE0aBOg4ejwXLt+ZOfEZww5CnFbaJiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imBHVwwA8EyGD5/YqhO7TExpuktHFh8kVJXhDNCuJdZHBgjYRe5dKGDFM9bViIOyjB6RUt41A3D0LxWgbdU3m1lm6/GTZGir9kaREVdgfMVqKksasLKe/o8FveeSzJLCoZ0MIvTZ3eVvplOliEHyDAXyPEsY2Ron/jmcOpqyVgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NbbQvm42; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NbbQvm42"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz2BYg2mx3Po8/9JDsB8IcZJULSY4hIuKuiwRR502UU1hEiv9eEOpLmMq/3Uo0h2UAVVUmdk/ucxKwZDqkOYqA0tqLRXb1vxZkIwAg3LtICNEVo6u+3APnni192LKaQbIEswZf9IQblBVapYR6hmQOuSJzegKDOG//A8DAYGJOf4bIUZTpEJdllkQ1IS9oSc1m6L7kVIenlkevhp5gt9K4RbEqzi/JUGbhH3yL8uIxWv5f7SG3bA0WvwEKIfyvF2EoTbdz0QSGV0i+q8Sb2QrTcZ06q6QGPMqWZkBZIeejmcsiNbA2y2szMZ9hTzQXnZGpZ+6d1q61qvgLdwQr3Kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akcAMhoMZxxw2lGC9whZFZUZwOUaIteB0kR2pbyFqII=;
 b=H97SiPc9bWjxbUtnrb8/Q//RYqonCfhrtBydCqIWDKgqHxYYBe6Q8pQfXl/o2PO5xnF4yrRHT8pbpf/DMFwRIvFKx0GAGJhuSRV3NriBHM8aY7n18ENIblOThdPJ4WXweizEhgk0hkFCHQOWA4aRFnaPhZ6q4vtDt1cUeSiHwkk8EJHJsSRuJRtRHNoHBew/xcBy45XT4lUvPaySOog8G0ut+9iz6xSCPeyfbPn93ofFD9dZWYoYgHyCnqw1/2SZuswcbKQsgTruKEpTSjeGhjdoyyq/idDlAK+fq7h+A8ID2zSC4aURX1vV5y/wlNd6PsHa00WWKGiDKJ8o+Hye1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akcAMhoMZxxw2lGC9whZFZUZwOUaIteB0kR2pbyFqII=;
 b=NbbQvm42q82Rwet4bfs+bpDFfeMdxXyLq2dgBOjgrzMKpeetW6FDJvldEa7Cm0R6IGWBEavJf51tpbufBh+dWcZt/q8zEA1wAR7CEV2l99JXasLmMEgBYZnTCJfS8CSIubGoUaU1lCuQik95tyVO2A7vukIhGpEdhW3EUx8ECnVgLVo8ofsAN/KbqY5QkZcoldmiju1eQG+LR0H7b/Edrz2axVmLcXbcXXIx43MPokb/YUGZDt/iKErjsE3ftYdfXO2kvsL8TqvWefmncsR1kD5kW0/HyAq/kqU+R2xaJhRUshEIbSLT4brrGGXQPCx3FPL8Ic3BngcaUEnAS63Nyg==
Received: from CH0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:610:cc::14)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 20:36:54 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::32) by CH0PR03CA0069.outlook.office365.com
 (2603:10b6:610:cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 20:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:36:35 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:36:28 -0700
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
Subject: [PATCH 13/20] vfio/cxl: Introduce HDM decoder register emulation framework
Date: Thu, 12 Mar 2026 02:04:33 +0530
Message-ID: <20260311203440.752648-14-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2681cbf5-b8fc-4782-565a-08de7fadeecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KIQEIEixh2x4Gp0yKyfxnB0l0+2QTQVMF9lKJ2fzQu0AlUVx8iIKLYhykzweLqO/PkSsilN3WpJ4lXuLYj3Nri9xT1WzXwbYdcCb7o4UVZq6/9CmEt0i2BfLfaABQD56WhhQM34xOEBsSzDgYtA6UEYIF7j9mLokc9b+qzdCemzgvoQ0GkZyzA+lOpIDzYM7BVAnigkTKfVTXRflEzJ1LOh8AQWQ0TKGZajvIApSjtlXbVwvWMsW1U6rDnQxT45CyzutPeXoWcF/CGZ0raVYz8GG8OpSboC9+XIeqH2lLF6myNVrkkxbVOd/FpW5NXY3cGJrZdXeuODNyNC4xjPkiPs2/pWykFtmCHFF81rEt1GDAQqJcc2Yn4LnlLpzcOSNuS16T+lQaetgqihEkhKEMPAVXubajte+RuJ6lTuOvRnvBpFTBbojshFS8e1i0nDTVVUJroCZlrhq309NEOcpb8eY6UYNKrsNksJ9N6ICpfo6OHkebeSvXVuxQeCWWGiw/M6gmkGIRDUa+2vD/e7qadMXo0MQjjgim7n0FFDbtLyEP3R8mLCkoIAo69LGgW67QDbyf7dYam9gKBYX2Zp0ZRwKJKPRqx+9j8Y2cMBDjsb4bG83fVb8QM8fvyJucQ44XK30IdWcecImNTMJluPy/fbH0vR0zj0N2jS30DPtwXPG5x9gR7ebIO/CYR/z7xc6SbOYZIgZfqFkFdDxk1r64J+3hwoqGu4WnjSuuEpqUWDEIUy+ua4MtFo2Lwt4y3mzJ0DRA64h421VKdctatRsogX9VAb+vJoj3lEYK+TD7wbonOXxp8pgDJP5GX+Raq1L
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8IDjYs3rtYomQ8Z+D5ELZYPHBbeSXKEIZG5BUXcW096QhI0n4nMVLXGM34iRuSwtE8YngN7xvH6H0IZmc0uq2bu8VwEIHR5mRPK79V1D103kEmYRZWHXE+KMU7D4EwIsFSe5qssw5NFTHad0l9YD6Rll8R1W2C6CYU3R8PHjjI+Pgq1CdBiJ0H8SUrobKJnyMMJSUYnxpkJHoIJcM/xabg5xv8TV5avM0OVmSdhiuJHc7/4uX+dF4V4SwzMXK3+kYj+b0lqnwTE1ZHsT7xWMdaqMdr4tucw2fBJ4PzrRAK0SEvqi6F2wnXJmCGaJ1DxQ8LM8Nzf5V8k8R1QNued9nOeJPnR8paSxyJBn2ws69TvwpXxNP/O8xAZeYF+6eeK72zupXTqUaAnaRId6271O8cnrU7Cr/X5lGlbERsVVvkktsWEgzhH+9VBhCTyrin1I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:54.4149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2681cbf5-b8fc-4782-565a-08de7fadeecc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747

From: Manish Honap <mhonap@nvidia.com>

Introduce an emulation framework to handle CXL MMIO register emulation
for CXL devices passed through to a VM.

A single compact __le32 array (comp_reg_virt) covers only the HDM
decoder register block (hdm_reg_size bytes, typically 256-512 bytes).

A new VFIO device region VFIO_REGION_SUBTYPE_CXL_COMP_REGS exposes
this array to userspace (QEMU) as a read-write region:
  - Reads return the emulated state (comp_reg_virt[])
  - Writes go through the HDM register write handlers and are
    forwarded to hardware where appropriate

QEMU attaches a notify_change callback to this region. When the
COMMIT bit is written in a decoder CTRL register the callback
reads the BASE_LO/HI from the same region fd (emulated state) and
maps the DPA MemoryRegion at the correct GPA in system_memory.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/Makefile            |   2 +-
 drivers/vfio/pci/cxl/vfio_cxl_core.c |  36 ++-
 drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 366 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  41 +++
 drivers/vfio/pci/vfio_pci_priv.h     |   7 +
 5 files changed, 450 insertions(+), 2 deletions(-)
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
index 03846bd11c8a..d2401871489d 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -45,6 +45,7 @@ static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
 	cxl = vdev->cxl;
 	cxl->dvsec = dvsec;
 	cxl->dpa_region_idx = -1;
+	cxl->comp_reg_region_idx = -1;
 
 	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
 			     &cap_word);
@@ -124,6 +125,10 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
 	cxl->comp_reg_offset = bar_offset;
 	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
+	ret = vfio_cxl_setup_virt_regs(vdev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -281,12 +286,14 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
 
 	ret = vfio_cxl_create_region_helper(vdev, SZ_256M);
 	if (ret)
-		goto failed;
+		goto regs_failed;
 
 	cxl->precommitted = true;
 
 	return;
 
+regs_failed:
+	vfio_cxl_clean_virt_regs(vdev);
 failed:
 	devm_kfree(&pdev->dev, vdev->cxl);
 	vdev->cxl = NULL;
@@ -299,6 +306,7 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
 	if (!cxl || !cxl->region)
 		return;
 
+	vfio_cxl_clean_virt_regs(vdev);
 	vfio_cxl_destroy_cxl_region(vdev);
 }
 
@@ -409,6 +417,32 @@ void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev)
 
 	if (!cxl)
 		return;
+
+	/*
+	 * Re-initialise the emulated HDM comp_reg_virt[] from hardware.
+	 * After FLR the decoder registers read as zero; mirror that in
+	 * the emulated state so QEMU sees a clean slate.
+	 */
+	vfio_cxl_reinit_comp_regs(vdev);
+
+	/*
+	 * Only re-enable the DPA mmap if the hardware has actually
+	 * re-committed decoder 0 after FLR.  Read the COMMITTED bit from the
+	 * freshly-re-snapshotted comp_reg_virt[] so we check the post-FLR
+	 * hardware state, not stale pre-reset state.
+	 *
+	 * If COMMITTED is 0 (slow firmware re-commit path), leave
+	 * region_active=false.  Guest faults will return VM_FAULT_SIGBUS
+	 * until the decoder is re-committed and the region is re-enabled.
+	 */
+	if (cxl->precommitted && cxl->comp_reg_virt) {
+		u32 ctrl = le32_to_cpu(cxl->comp_reg_virt[
+				       CXL_HDM_DECODER0_CTRL_OFFSET(0) /
+				       CXL_REG_SIZE_DWORD]);
+
+		if (ctrl & CXL_HDM_DECODER_CTRL_COMMITTED_BIT)
+			WRITE_ONCE(cxl->region_active, true);
+	}
 }
 
 static ssize_t vfio_cxl_region_rw(struct vfio_pci_core_device *core_dev,
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
new file mode 100644
index 000000000000..d5603c80fe51
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
@@ -0,0 +1,366 @@
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
+ * comp_reg_virt[] layout:
+ *   Index 0..N correspond to 32-bit registers at byte offset 0..hdm_reg_size-4
+ *   within the HDM decoder capability block.
+ *
+ * Register layout within the HDM block (CXL spec 8.2.5.19):
+ *   0x00: HDM Decoder Capability
+ *   0x04: HDM Decoder Global Control
+ *   0x08: HDM Decoder Global Status
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
+static inline __le32 *hdm_reg_ptr(struct vfio_pci_cxl_state *cxl, u32 off)
+{
+	/*
+	 * off is byte offset within the HDM block; comp_reg_virt is indexed
+	 * as an array of __le32.
+	 */
+	return &cxl->comp_reg_virt[off / sizeof(__le32)];
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
+	/* Bit [27:0] are reserved. */
+	new_val &= ~CXL_HDM_DECODER_BASE_LO_RESERVED_MASK;
+
+	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
+
+	return size;
+}
+
+static ssize_t hdm_decoder_global_ctrl_write(struct vfio_pci_core_device *vdev,
+					     const __le32 *val32, u64 offset, u64 size)
+{
+	u32 hdm_decoder_global_cap;
+	u32 new_val = le32_to_cpu(*val32);
+
+	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
+		return -EINVAL;
+
+	/* Bit [31:2] are reserved. */
+	new_val &= ~CXL_HDM_DECODER_GLOBAL_CTRL_RESERVED_MASK;
+
+	/* Poison On Decode Error Enable bit is 0 and RO if not support. */
+	hdm_decoder_global_cap = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, 0));
+	if (!(hdm_decoder_global_cap & CXL_HDM_CAP_POISON_ON_DECODE_ERR_BIT))
+		new_val &= ~CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT;
+
+	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
+
+	return size;
+}
+
+/*
+ * hdm_decoder_n_ctrl_write - Write handler for HDM decoder CTRL register.
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
+ */
+static ssize_t hdm_decoder_n_ctrl_write(struct vfio_pci_core_device *vdev,
+					const __le32 *val32, u64 offset, u64 size)
+{
+	u32 hdm_decoder_global_cap;
+	u32 ro_mask = CXL_HDM_DECODER_CTRL_RO_BITS_MASK;
+	u32 rev_mask = CXL_HDM_DECODER_CTRL_RESERVED_MASK;
+	u32 new_val = le32_to_cpu(*val32);
+	u32 cur_val;
+
+	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
+		return -EINVAL;
+
+	cur_val = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, offset));
+	if (cur_val & CXL_HDM_DECODER_CTRL_COMMIT_LOCK_BIT)
+		return size;
+
+	hdm_decoder_global_cap = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, 0));
+	ro_mask |= CXL_HDM_DECODER_CTRL_DEVICE_BITS_RO;
+	rev_mask |= CXL_HDM_DECODER_CTRL_DEVICE_RESERVED;
+	if (!(hdm_decoder_global_cap & CXL_HDM_CAP_UIO_SUPPORTED_BIT))
+		rev_mask |= CXL_HDM_DECODER_CTRL_UIO_RESERVED;
+
+	new_val &= ~rev_mask;
+	cur_val &= ro_mask;
+	new_val = (new_val & ~ro_mask) | cur_val;
+
+	/*
+	 * Mirror COMMIT → COMMITTED immediately in the emulated state.
+	 * QEMU's notify_change (called before this write reaches hardware)
+	 * reads COMMITTED from the region fd to detect commit transitions.
+	 */
+	if (new_val & CXL_HDM_DECODER_CTRL_COMMIT_BIT)
+		new_val |= CXL_HDM_DECODER_CTRL_COMMITTED_BIT;
+	else
+		new_val &= ~CXL_HDM_DECODER_CTRL_COMMITTED_BIT;
+
+	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
+
+	return size;
+}
+
+/*
+ * Dispatch table for COMP_REGS region writes.	Indexed by byte offset within
+ * the HDM decoder block.  Returns the appropriate write handler.
+ *
+ * Layout:
+ *   0x00	  HDM Decoder Capability  (RO)
+ *   0x04	  HDM Global Control	  (RW with reserved masking)
+ *   0x08	  HDM Global Status	  (RO)
+ *   0x0c	  (reserved)		  (ignored)
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
+	if (off == 0x00)
+		return size;
+
+	/* HDM Global Control (0x04) */
+	if (off == CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET)
+		return hdm_decoder_global_ctrl_write(vdev, val32, off, size);
+
+	/* HDM Global Status (0x08): RO */
+	if (off == 0x08)
+		return size;
+
+	/* Per-decoder registers start at 0x10, stride 0x20 */
+	if (off < CXL_HDM_DECODER_FIRST_BLOCK_OFFSET)
+		return size; /* reserved gap */
+
+	dec_base = CXL_HDM_DECODER_FIRST_BLOCK_OFFSET;
+	dec_off	 = (off - dec_base) % CXL_HDM_DECODER_BLOCK_STRIDE;
+
+	switch (dec_off) {
+	case CXL_HDM_DECODER_N_BASE_LOW_OFFSET:	 /* BASE_LO */
+	case CXL_HDM_DECODER_N_SIZE_LOW_OFFSET:	 /* SIZE_LO */
+		return hdm_decoder_n_lo_write(vdev, val32, off, size);
+	case CXL_HDM_DECODER_N_BASE_HIGH_OFFSET: /* BASE_HI */
+	case CXL_HDM_DECODER_N_SIZE_HIGH_OFFSET: /* SIZE_HI */
+		/* Full 32-bit write, no reserved bits */
+		*hdm_reg_ptr(cxl, off) = *val32;
+		return size;
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
+ * vfio_cxl_comp_regs_rw - regops rw handler for VFIO_REGION_SUBTYPE_CXL_COMP_REGS.
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
+	/* Clamp to region size */
+	if (pos >= cxl->hdm_reg_size)
+		return -EINVAL;
+	count = min(count, (size_t)(cxl->hdm_reg_size - pos));
+
+	while (done < count) {
+		u32 sz	 = min_t(u32, CXL_REG_SIZE_DWORD, count - done);
+		u32 off	 = pos + done;
+		__le32 v;
+
+		/* Enforce 4-byte alignment */
+		if (sz < CXL_REG_SIZE_DWORD || (off & 0x3))
+			return done ? (ssize_t)done : -EINVAL;
+
+		if (iswrite) {
+			if (copy_from_user(&v, buf + done, sizeof(v)))
+				return done ? (ssize_t)done : -EFAULT;
+			comp_regs_dispatch_write(vdev, off, &v, sizeof(v));
+		} else {
+			v = *hdm_reg_ptr(cxl, off);
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
+	/* comp_reg_virt is freed in vfio_cxl_clean_virt_regs(), not here. */
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
+int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	size_t nregs;
+
+	if (WARN_ON(!cxl->hdm_reg_size))
+		return -EINVAL;
+
+	if (pci_resource_len(vdev->pdev, cxl->comp_reg_bar) <
+	    cxl->comp_reg_offset + cxl->hdm_reg_offset + cxl->hdm_reg_size)
+		return -ENODEV;
+
+	nregs = cxl->hdm_reg_size / sizeof(__le32);
+	cxl->comp_reg_virt = kcalloc(nregs, sizeof(__le32), GFP_KERNEL);
+	if (!cxl->comp_reg_virt)
+		return -ENOMEM;
+
+	/* Establish persistent mapping; kept alive until vfio_cxl_clean_virt_regs(). */
+	cxl->hdm_iobase = ioremap(pci_resource_start(vdev->pdev, cxl->comp_reg_bar) +
+				  cxl->comp_reg_offset + cxl->hdm_reg_offset,
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
+void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	size_t i, nregs;
+
+	if (!cxl || !cxl->comp_reg_virt || !cxl->hdm_iobase)
+		return;
+
+	nregs = cxl->hdm_reg_size / sizeof(__le32);
+
+	for (i = 0; i < nregs; i++)
+		cxl->comp_reg_virt[i] =
+			cpu_to_le32(readl(cxl->hdm_iobase + i * sizeof(__le32)));
+}
+
+void vfio_cxl_clean_virt_regs(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (cxl->hdm_iobase) {
+		iounmap(cxl->hdm_iobase);
+		cxl->hdm_iobase = NULL;
+	}
+	kfree(cxl->comp_reg_virt);
+	cxl->comp_reg_virt = NULL;
+}
+
+/*
+ * vfio_cxl_register_comp_regs_region - Register the COMP_REGS device region.
+ *
+ * Exposes the emulated HDM decoder register state as a VFIO device region
+ * with type VFIO_REGION_SUBTYPE_CXL_COMP_REGS.	 QEMU attaches a
+ * notify_change callback to this region to intercept HDM COMMIT writes
+ * and map the DPA MemoryRegion at the appropriate GPA.
+ *
+ * The region is read+write only (no mmap) to ensure all accesses pass
+ * through comp_regs_dispatch_write() for proper bit-field enforcement.
+ */
+int vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u32 flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE;
+	int ret;
+
+	if (!cxl || !cxl->comp_reg_virt)
+		return -ENODEV;
+
+	ret = vfio_pci_core_register_dev_region(vdev,
+						PCI_VENDOR_ID_CXL |
+						VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+						&vfio_cxl_comp_regs_ops,
+						cxl->hdm_reg_size, flags, cxl);
+	if (!ret)
+		cxl->comp_reg_region_idx = vdev->num_regions - 1;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_cxl_register_comp_regs_region);
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index b870926bfb19..4f2637874e9d 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -25,14 +25,51 @@ struct vfio_pci_cxl_state {
 	size_t                       hdm_reg_size;
 	resource_size_t              comp_reg_offset;
 	size_t                       comp_reg_size;
+	__le32                      *comp_reg_virt;
+	void __iomem                *hdm_iobase;
 	u32                          hdm_count;
 	int                          dpa_region_idx;
+	int                          comp_reg_region_idx;
 	u16                          dvsec;
 	u8                           comp_reg_bar;
 	bool                         precommitted;
 	bool                         region_active;
 };
 
+/* Register access sizes */
+#define CXL_REG_SIZE_WORD  2
+#define CXL_REG_SIZE_DWORD 4
+
+/* HDM Decoder - register offsets (CXL 2.0 8.2.5.19) */
+#define CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET	  0x4
+#define CXL_HDM_DECODER_FIRST_BLOCK_OFFSET	  0x10
+#define CXL_HDM_DECODER_BLOCK_STRIDE		  0x20
+#define CXL_HDM_DECODER_N_BASE_LOW_OFFSET	  0x0
+#define CXL_HDM_DECODER_N_BASE_HIGH_OFFSET	  0x4
+#define CXL_HDM_DECODER_N_SIZE_LOW_OFFSET	  0x8
+#define CXL_HDM_DECODER_N_SIZE_HIGH_OFFSET	  0xc
+#define CXL_HDM_DECODER_N_CTRL_OFFSET		  0x10
+#define CXL_HDM_DECODER_N_TARGET_LIST_LOW_OFFSET  0x14
+#define CXL_HDM_DECODER_N_TARGET_LIST_HIGH_OFFSET 0x18
+#define CXL_HDM_DECODER_N_REV_OFFSET		  0x1c
+
+/* HDM Decoder Global Capability / Control - bit definitions */
+#define CXL_HDM_CAP_POISON_ON_DECODE_ERR_BIT BIT(10)
+#define CXL_HDM_CAP_UIO_SUPPORTED_BIT	     BIT(13)
+
+/* HDM Decoder N Control */
+#define CXL_HDM_DECODER_CTRL_COMMIT_LOCK_BIT	  BIT(8)
+#define CXL_HDM_DECODER_CTRL_COMMIT_BIT		  BIT(9)
+#define CXL_HDM_DECODER_CTRL_COMMITTED_BIT	  BIT(10)
+#define CXL_HDM_DECODER_CTRL_RO_BITS_MASK	  (BIT(10) | BIT(11))
+#define CXL_HDM_DECODER_CTRL_RESERVED_MASK	  (BIT(15) | GENMASK(31, 28))
+#define CXL_HDM_DECODER_CTRL_DEVICE_BITS_RO	  BIT(12)
+#define CXL_HDM_DECODER_CTRL_DEVICE_RESERVED	  (GENMASK(19, 16) | GENMASK(23, 20))
+#define CXL_HDM_DECODER_CTRL_UIO_RESERVED	  (BIT(14) | GENMASK(27, 24))
+#define CXL_HDM_DECODER_BASE_LO_RESERVED_MASK	  GENMASK(27, 0)
+#define CXL_HDM_DECODER_GLOBAL_CTRL_RESERVED_MASK GENMASK(31, 2)
+#define CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT BIT(0)
+
 /*
  * CXL DVSEC for CXL Devices - register offsets within the DVSEC
  * (CXL 2.0+ 8.1.3).
@@ -41,4 +78,8 @@ struct vfio_pci_cxl_state {
 #define CXL_DVSEC_CAPABILITY_OFFSET 0xa
 #define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
 
+int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev);
+void vfio_cxl_clean_virt_regs(struct vfio_pci_core_device *vdev);
+void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
+
 #endif /* __LINUX_VFIO_CXL_PRIV_H */
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 8f440f9eaa0c..f8db9a05c033 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -152,6 +152,8 @@ int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev);
 void vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev);
 void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
 void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
+int  vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev);
+void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
 
 #else
 
@@ -173,6 +175,11 @@ static inline void
 vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev) { }
 static inline void
 vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev) { }
+static inline int
+vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
+{ return 0; }
+static inline void
+vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev) { }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
-- 
2.25.1

