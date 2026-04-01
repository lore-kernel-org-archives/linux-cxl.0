Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26457477E34;
	Wed,  1 Apr 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054530; cv=fail; b=ML8L79ESP+mF4mubduJQUgWVkTPHjQrfUO999qqYhngqKst/Hel/LdFmnvYQDTpQLlK90jtbMAWJxGt30pziTrpEPqejlR8JBQMs7/cEcljDTs5OzNRteX6aAQclJkh2lWQ7ykR0fdxC4wH7f7ryR/iBVtEOPDNFxX42X7TxHLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054530; c=relaxed/simple;
	bh=vlHyOqj2oALziFiemj5f4qtRYPTJrWCxZBMbjXUyXU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQgxMpjPiqCQLvK4dxNPEBd7jtyXm8JawfZI1df6jhCN/Fm9JUBc4TsLMVS1PI8bbiV+oq2HUIQ+8TW8sqExtdpDhQ11BSvsRsgawDu46l2Hg19BPeEnqzwam29NUN//AGskwpGkobaGYPXyz82y0P3tXt6Jgv/KlkX2E2usFdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vd+DEjDy; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vd+DEjDy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcEKDYdsWc3qLoYnh6HRIzEv3LqQJcYrrB5TltIWeEfJkTN4CJNazeTw239uBuYKayDhMV6RdUU5k1LXTkFjpAnwT8AHODdfd2sarlHsO//pKqBZlVGb2d+SeUVoNlc28bPonFtru4+J14EWX+h+N3SD9OjYNKYJaKnu3iqfV3qxEqFYs7ZrxxHqeaCGmdySd4eAOgg8u1XmRoGmmtdjUjzjckraZzOsr6CfjK2g4Pto0h+VFLZSs1s91fDFAcx9UBvD5xHKiz+DFMQDc/gijB4R33+zn+uMA/A0188PQYYrcTeYIyEACwqA/6LwFpg1lfxtHmjAyimyJrAvprcdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqSpA2tf/j9DTpFbcIXKWLvhaVJ6eyht6RldoNX1ejs=;
 b=Ud17n3QBlvRNLvP4J4McNjIsNV0UMoOE8G9H5+any/SzFUMETlEBPBVUcyR48CbNXUx+afseNVQvi0f6vWyCunpJZPzH8s3tWRwOro4OeTb7hI/z60Ev+yspugZWZUo3DhfyS6PnQd2yUjMHcYDuWGpGh/vb9OhwRa2Rzv8szW7jOiSal7O9Il/CJBduqW1+l/AlxTofcHt0Fa2UR28LXa7jAFM0Q8gFZoMub+mkfU71Og/LZsgHeC9NLALQN/O8dTvAcaq9xMASkcoRkpzqZv3afvXQV7r45hs6aRO4HGfX7uu2yQwimWV3yrUiXaswDPUuVsMTfsx957j7mIPWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqSpA2tf/j9DTpFbcIXKWLvhaVJ6eyht6RldoNX1ejs=;
 b=Vd+DEjDyicQcA41+Yo/0jwonWCIuBcBZlNGtJsvR7Nn3BXjjI6DnGao+ej2UjqXryxbPdPR8mhgW4fnp5THSby9rXcW9K3VLSze2to6SiDbTZLc7v3eoDH4eo3f9r26BTw4kOSYQ1tn2SLDtSxbFDNnyO9L9nRrpy9IjtaL+mNw/MYlLQVnO/eN2zhQrSF6VjsoMb5xdjIbOLhaAawEMdBFyJeGqt/9I1xRPuRNw1iTIud+sZRIkRfVxJt25GEdEP9Aq9SbZnG7GT0UJsEEn0t4kTh0DrkryIEYNutJY3lTEYnnbDeHDwXJR1q0gDmGTR8Qp80RwWF5Mb9S1Y1e/RA==
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 14:41:54 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::61) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 14:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:41:30 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:41:22 -0700
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
Subject: [PATCH v2 15/20] vfio/cxl: Virtualize CXL DVSEC config writes
Date: Wed, 1 Apr 2026 20:09:12 +0530
Message-ID: <20260401143917.108413-16-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5e03a1-e50d-4489-25e9-08de8ffcd161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|13003099007|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hEn+3IPfyEgUqbyA2pWBioKAv3c40NStkDLzgIhtj0I8S4p5Ye6tfd2R52ECaPthzliam2siPGrA6e3eCQ3jqn6+YxcqW8+vbyddZmNkYimLHlbPEk0uzan55x7zqNf5IMMo5TEQ2s8KtqpzTs0Q62PvKeSREmoeSX6YMdn2RKYgYzX08kLMD6REAAWSQBqO2gGMrFJRxzr/sR9xvvuuoy/8vRRGtz6jS1AcDR67b4txWHIe7ppN3pMAoyxGBnkCKT/0Nm4VWJKjmU8VwMxsxQs0SzGWiv/rmhZ0mbgJXr3+vWTRmcLYkvdPEOfZ+H1nf+kKym2APIcC5Yon1/hHLcZpsb92j/dyR9tEopp576BeQacO4S8uJac0h9lCq/cdc3Ec3BZKk1zxxcGbf1Tv8f913y91sBgZ3mq1qRlGgpUurq37blpEskzY8pDCTKIMbx6Hv1NfY09NEiNfCJSGKCo6b29vpCcA0+alBPtPfO//dkT+ov7vlls5Y295fwjrlczGwySOcWHJ150XhMWGioT5aZBIL8nYVv6DwONfRShROCr2rtCNO+jeu0FIrNuFzvGPbMaU8criq6oWe7g63hhzTjoc8f3Y8cnAz4/jJp55Ya6JTgAuMO3xxp5kjuT8P20CjsJyHPkZ75pwRj4v+lIpvc6sMMO4TuwJTnlNVukt4cGaQIOk5jxR5WPP9bcQw/eUMYKWsAnDdwj+8CwtvkVdzUCd8UzlX+J8YvclP6izarmFz6ZCAEe+YjtQ+zeAdsbSS/jpk4nSwPQsvCMAXgdjVoxnUeQHxygUY7SxuZ4bawVesdyhqmgz5WfpdCcY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(13003099007)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FORePgYakvJhCJ8TH5029Rhruv3b8wDQlxrCAySeax5gADoLjwMyTAbi3i1nkJcW4PSngT2jBAKq/1L081twvKBeyq4vWWo6O5UMsDzzcMB3F/XKvymv1SBBV4EXBlpfC7Y2Ib8yiKelS466kh+JmF1Q5JCf836YKU4wONvF/df7/ap2dVvPpMDdmleoay9EKHHAzXzF6mHL+1OhefPs544Zw2J22DOrEf+fNR4ubrKt7Etob4KBwL2Tt2mtgJNxjUBhi8j/FGgb7kXAcpkn/KYM9GMc2ORJ6693YfQVv28HZnX/bbsW6IMoFUo9lQQQYdN43u7iCy30U3fa6N7g1fzFyvIEdjrZyGwrEHSM39zdTciuPsDP6ZZoIF70MjqKUYG0bSdB7hTdgPVFvkIQpcfuuu1OKxW6ZzfI6EJmSZGRr2y4HkAa9kT+ZnzRiAan
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:53.8633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5e03a1-e50d-4489-25e9-08de8ffcd161
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

From: Manish Honap <mhonap@nvidia.com>

CXL devices have CXL DVSEC registers in the configuration space.
Many of them affect the behaviors of the devices, e.g. enabling
CXL.io/CXL.mem/CXL.cache. However, these configurations are owned by
the host and a virtualization policy should be applied when handling
the access from the guest.

Introduce the emulation of CXL configuration space to handle the access
of the virtual CXL configuration space from the guest.

vfio-pci-core already allocates vdev->vconfig as the authoritative
virtual config space shadow. Directly use vdev->vconfig:
  - DVSEC reads return data from vdev->vconfig (already populated by
    vfio_config_init() via vfio_ecap_init())
  - DVSEC writes go through new CXL-aware write handlers that update
    vdev->vconfig in place
  - The writable DVSEC registers are marked virtual in vdev->pci_config_map

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/Makefile              |   2 +-
 drivers/vfio/pci/cxl/vfio_cxl_config.c | 306 +++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_core.c   |   4 +-
 drivers/vfio/pci/cxl/vfio_cxl_priv.h   |  43 +++-
 drivers/vfio/pci/vfio_pci_config.c     |  46 +++-
 drivers/vfio/pci/vfio_pci_priv.h       |   3 +
 include/linux/vfio_pci_core.h          |   8 +-
 include/uapi/cxl/cxl_regs.h            |  98 ++++++++
 8 files changed, 498 insertions(+), 12 deletions(-)
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_config.c

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index bef916495eae..7c86b7845e8f 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
-vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o cxl/vfio_cxl_emu.o
+vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o cxl/vfio_cxl_emu.o cxl/vfio_cxl_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_config.c b/drivers/vfio/pci/cxl/vfio_cxl_config.c
new file mode 100644
index 000000000000..dee521118dd4
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_config.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CXL DVSEC configuration space emulation for vfio-pci.
+ *
+ * Integrates into the existing vfio-pci-core ecap_perms[] framework using
+ * vdev->vconfig as the sole shadow buffer for DVSEC registers.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include <linux/pci.h>
+#include <linux/vfio_pci_core.h>
+
+#include "../vfio_pci_priv.h"
+#include "vfio_cxl_priv.h"
+
+static inline u16 _cxlds_get_dvsec(struct vfio_pci_cxl_state *cxl)
+{
+	return (u16)cxl->cxlds.cxl_dvsec;
+}
+
+/* Helpers to access vdev->vconfig at a DVSEC-relative offset */
+static inline u16 dvsec_virt_read16(struct vfio_pci_core_device *vdev,
+				    u16 off)
+{
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+
+	return le16_to_cpu(*(u16 *)(vdev->vconfig + dvsec + off));
+}
+
+static inline void dvsec_virt_write16(struct vfio_pci_core_device *vdev,
+				      u16 off, u16 val)
+{
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+
+	*(u16 *)(vdev->vconfig + dvsec + off) = cpu_to_le16(val);
+}
+
+static inline u32 dvsec_virt_read32(struct vfio_pci_core_device *vdev,
+				    u16 off)
+{
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+
+	return le32_to_cpu(*(u32 *)(vdev->vconfig + dvsec + off));
+}
+
+static inline void dvsec_virt_write32(struct vfio_pci_core_device *vdev,
+				      u16 off, u32 val)
+{
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+
+	*(u32 *)(vdev->vconfig + dvsec + off) = cpu_to_le32(val);
+}
+
+/* Individual DVSEC register write handlers */
+
+static void cxl_dvsec_control_write(struct vfio_pci_core_device *vdev,
+				    u16 new_val)
+{
+	u16 lock = dvsec_virt_read16(vdev, CXL_DVSEC_LOCK_OFFSET);
+	u16 cap3 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY3_OFFSET);
+	u16 rev_mask = CXL_CTRL_RESERVED_MASK;
+
+	if (lock & CXL_DVSEC_LOCK_CONFIG_LOCK)
+		return; /* register is locked after first write */
+
+	if (!(cap3 & CXL_DVSEC_CAP3_P2P_MEM_CAPABLE))
+		rev_mask |= CXL_CTRL_P2P_REV_MASK;
+
+	new_val &= ~rev_mask;
+	new_val |= CXL_DVSEC_CTRL_IO_ENABLE; /* IO_Enable always returns 1 */
+
+	dvsec_virt_write16(vdev, CXL_DVSEC_CONTROL_OFFSET, new_val);
+}
+
+static void cxl_dvsec_status_write(struct vfio_pci_core_device *vdev,
+				   u16 new_val)
+{
+	u16 cur_val = dvsec_virt_read16(vdev, CXL_DVSEC_STATUS_OFFSET);
+
+	/*
+	 * VIRAL_STATUS (bit 14) is the only writable bit; all others are
+	 * reserved and always zero.
+	 */
+	new_val = cur_val & ~(new_val & CXL_DVSEC_STATUS_VIRAL_STATUS);
+	dvsec_virt_write16(vdev, CXL_DVSEC_STATUS_OFFSET, new_val);
+}
+
+static void cxl_dvsec_control2_write(struct vfio_pci_core_device *vdev,
+				     u16 new_val)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+	u16 abs_off = dvsec + CXL_DVSEC_CONTROL2_OFFSET;
+	u16 cap2 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY2_OFFSET);
+	u16 cap3 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY3_OFFSET);
+	u16 rev_mask = CXL_CTRL2_RESERVED_MASK;
+
+	if (!(cap3 & CXL_DVSEC_CAP3_VOLATILE_HDM_CONFIGURABILITY))
+		rev_mask |= CXL_CTRL2_VOLATILE_HDM_REV_MASK;
+	if (!(cap2 & CXL_DVSEC_CAP2_MOD_COMPLETION_CAPABLE))
+		rev_mask |= CXL_CTRL2_MODIFIED_COMP_REV_MASK;
+
+	new_val &= ~rev_mask;
+
+	/* Cache WBI: forward to hardware. */
+	if (new_val & CXL_DVSEC_CTRL2_INITIATE_CACHE_WBI)
+		pci_write_config_word(pdev, abs_off,
+				      CXL_DVSEC_CTRL2_INITIATE_CACHE_WBI);
+
+	/*
+	 * CXL Reset: not yet supported - do not forward to HW.
+	 * TODO: invoke CXL protocol reset via cxl subsystem
+	 */
+	if (new_val & CXL_DVSEC_CTRL2_INITIATE_CXL_RESET)
+		pci_warn(pdev, "vfio-cxl: CXL reset requested but not yet supported\n");
+
+	dvsec_virt_write16(vdev, CXL_DVSEC_CONTROL2_OFFSET,
+			   new_val & ~CXL_CTRL2_HW_BITS_MASK);
+}
+
+static void cxl_dvsec_status2_write(struct vfio_pci_core_device *vdev,
+				    u16 new_val)
+{
+	u16 cap3 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY3_OFFSET);
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+	u16 abs_off = dvsec + CXL_DVSEC_STATUS2_OFFSET;
+
+	/* RW1CS: write 1 to clear, but only if the capability is supported */
+	if ((cap3 & CXL_DVSEC_CAP3_VOLATILE_HDM_CONFIGURABILITY) &&
+	    (new_val & CXL_DVSEC_STATUS2_VOLATILE_HDM_PRES_ERROR))
+		pci_write_config_word(vdev->pdev, abs_off,
+				      CXL_DVSEC_STATUS2_VOLATILE_HDM_PRES_ERROR);
+	/* STATUS2 is not mirrored in vconfig - reads go to hardware */
+}
+
+static void cxl_dvsec_lock_write(struct vfio_pci_core_device *vdev,
+				 u16 new_val)
+{
+	u16 cur_val = dvsec_virt_read16(vdev, CXL_DVSEC_LOCK_OFFSET);
+
+	/* Once the LOCK bit is set it can only be cleared by conventional reset */
+	if (cur_val & CXL_DVSEC_LOCK_CONFIG_LOCK)
+		return;
+
+	new_val &= ~CXL_LOCK_RESERVED_MASK;
+	dvsec_virt_write16(vdev, CXL_DVSEC_LOCK_OFFSET, new_val);
+}
+
+static void cxl_range_base_lo_write(struct vfio_pci_core_device *vdev,
+				    u16 dvsec_off, u32 new_val)
+{
+	new_val &= ~CXL_BASE_LO_RESERVED_MASK;
+	dvsec_virt_write32(vdev, dvsec_off, new_val);
+}
+
+/**
+ * vfio_cxl_dvsec_readfn - Per-device DVSEC read handler for CXL capable devices.
+ * @vdev:   VFIO PCI core device
+ * @pos:    Absolute byte position in PCI config space
+ * @count:  Number of bytes to read
+ * @perm:   Permission bits for this capability (passed through to fallback)
+ * @offset: Byte offset within the capability structure (passed through)
+ * @val:    Output buffer for the read value (little-endian)
+ *
+ * Called via vfio_pci_dvsec_dispatch_read() for CXL devices.  Returns shadow
+ * vconfig values for virtualized DVSEC registers (CONTROL, STATUS, CONTROL2,
+ * LOCK) so that userspace reads reflect emulated state rather than raw
+ * hardware.  All other DVSEC bytes pass through to vfio_raw_config_read().
+ *
+ * Return: @count on success, or negative error code from the fallback read.
+ */
+static int vfio_cxl_dvsec_readfn(struct vfio_pci_core_device *vdev,
+				 int pos, int count,
+				 struct perm_bits *perm,
+				 int offset, __le32 *val)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+	u16 dvsec_off;
+
+	if (!cxl || (u16)pos < dvsec ||
+	    (u16)pos >= dvsec + cxl->dvsec_len)
+		return vfio_raw_config_read(vdev, pos, count, perm, offset, val);
+
+	dvsec_off = (u16)pos - dvsec;
+
+	switch (dvsec_off) {
+	case CXL_DVSEC_CONTROL_OFFSET:
+	case CXL_DVSEC_STATUS_OFFSET:
+	case CXL_DVSEC_CONTROL2_OFFSET:
+	case CXL_DVSEC_LOCK_OFFSET:
+		/* Return shadow vconfig value for virtualized registers */
+		memcpy(val, vdev->vconfig + pos, count);
+		return count;
+	default:
+		return vfio_raw_config_read(vdev, pos, count,
+					    perm, offset, val);
+	}
+}
+
+/**
+ * vfio_cxl_dvsec_writefn - ecap_perms write handler for PCI_EXT_CAP_ID_DVSEC.
+ *
+ * Installed once into ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn by
+ * vfio_pci_init_perm_bits() when CONFIG_VFIO_CXL_CORE=y.  Applies to every
+ * device opened under vfio-pci; the vdev->cxl NULL check distinguishes CXL
+ * devices from non-CXL devices that happen to expose a DVSEC capability.
+ *
+ * @vdev:   VFIO PCI core device
+ * @pos:    Absolute byte position in PCI config space
+ * @count:  Number of bytes to write
+ * @perm:   Permission bits for this capability (passed through to fallback)
+ * @offset: Byte offset within the capability structure (passed through)
+ * @val:    Value to write (little-endian)
+ *
+ * Return: @count on success; non-CXL devices continue to
+ *         vfio_raw_config_write() which also returns @count or negative error.
+ */
+static int vfio_cxl_dvsec_writefn(struct vfio_pci_core_device *vdev,
+				  int pos, int count,
+				  struct perm_bits *perm,
+				  int offset, __le32 val)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+	u16 dvsec = _cxlds_get_dvsec(vdev->cxl);
+	u16 abs_off = (u16)pos;
+	u16 dvsec_off;
+	u16 wval16;
+	u32 wval32;
+
+	if (!cxl || (u16)pos < dvsec ||
+	    (u16)pos >= dvsec + cxl->dvsec_len)
+		return vfio_raw_config_write(vdev, pos, count, perm,
+					     offset, val);
+
+	pci_dbg(vdev->pdev,
+		"vfio_cxl: DVSEC write: abs=0x%04x dvsec_off=0x%04x count=%d raw_val=0x%08x\n",
+		abs_off, abs_off - dvsec, count, le32_to_cpu(val));
+
+	dvsec_off = abs_off - dvsec;
+
+	/* Route to the appropriate per-register handler */
+	switch (dvsec_off) {
+	case CXL_DVSEC_CONTROL_OFFSET:
+		wval16 = (u16)le32_to_cpu(val);
+		cxl_dvsec_control_write(vdev, wval16);
+		break;
+	case CXL_DVSEC_STATUS_OFFSET:
+		wval16 = (u16)le32_to_cpu(val);
+		cxl_dvsec_status_write(vdev, wval16);
+		break;
+	case CXL_DVSEC_CONTROL2_OFFSET:
+		wval16 = (u16)le32_to_cpu(val);
+		cxl_dvsec_control2_write(vdev, wval16);
+		break;
+	case CXL_DVSEC_STATUS2_OFFSET:
+		wval16 = (u16)le32_to_cpu(val);
+		cxl_dvsec_status2_write(vdev, wval16);
+		break;
+	case CXL_DVSEC_LOCK_OFFSET:
+		wval16 = (u16)le32_to_cpu(val);
+		cxl_dvsec_lock_write(vdev, wval16);
+		break;
+	case CXL_DVSEC_RANGE1_BASE_HIGH_OFFSET:
+	case CXL_DVSEC_RANGE2_BASE_HIGH_OFFSET:
+		wval32 = le32_to_cpu(val);
+		dvsec_virt_write32(vdev, dvsec_off, wval32);
+		break;
+	case CXL_DVSEC_RANGE1_BASE_LOW_OFFSET:
+	case CXL_DVSEC_RANGE2_BASE_LOW_OFFSET:
+		wval32 = le32_to_cpu(val);
+		cxl_range_base_lo_write(vdev, dvsec_off, wval32);
+		break;
+	default:
+		/* RO registers: header, capability, range sizes - discard */
+		break;
+	}
+
+	return count;
+}
+
+/**
+ * vfio_cxl_setup_dvsec_perms - Install per-device CXL DVSEC read/write hooks.
+ * @vdev: VFIO PCI core device
+ *
+ * Called once per device open after vfio_config_init() has seeded vdev->vconfig
+ * from hardware.  Installs vfio_cxl_dvsec_readfn and vfio_cxl_dvsec_writefn
+ * as per-device DVSEC handlers so that the global ecap_perms[DVSEC] dispatcher
+ * routes reads and writes through CXL-aware emulation.
+ *
+ * Forces CXL.io IO_ENABLE in the CONTROL vconfig shadow at init time so the
+ * initial guest read returns the correct value before the first write.
+ */
+void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev)
+{
+	u16 ctrl = dvsec_virt_read16(vdev, CXL_DVSEC_CONTROL_OFFSET);
+
+	vdev->dvsec_readfn  = vfio_cxl_dvsec_readfn;
+	vdev->dvsec_writefn = vfio_cxl_dvsec_writefn;
+
+	/* Force IO_ENABLE; cxl_dvsec_control_write() maintains this invariant. */
+	ctrl |= CXL_DVSEC_CTRL_IO_ENABLE;
+	dvsec_virt_write16(vdev, CXL_DVSEC_CONTROL_OFFSET, ctrl);
+}
+EXPORT_SYMBOL_GPL(vfio_cxl_setup_dvsec_perms);
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 19d3dc205f99..a3ff90b7a22c 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -68,13 +68,13 @@ vfio_cxl_create_device_state(struct pci_dev *pdev, u16 dvsec)
 	 * CACHE_CAPABLE is forwarded to the VMM so it knows whether a WBI
 	 * sequence is needed before FLR.
 	 */
-	if (!FIELD_GET(CXL_DVSEC_MEM_CAPABLE, cap_word) ||
+	if (!FIELD_GET(CXL_DVSEC_CAP_MEM_CAPABLE, cap_word) ||
 	    (pdev->class >> 8) == PCI_CLASS_MEMORY_CXL) {
 		devm_kfree(&pdev->dev, cxl);
 		return ERR_PTR(-ENODEV);
 	}
 
-	cxl->cache_capable = FIELD_GET(CXL_DVSEC_CACHE_CAPABLE, cap_word);
+	cxl->cache_capable = FIELD_GET(CXL_DVSEC_CAP_CACHE_CAPABLE, cap_word);
 
 	return cxl;
 }
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
index 3458768445af..b86ee691d050 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -76,14 +76,43 @@ struct vfio_pci_cxl_state {
 #define CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT BIT(0)
 
 /*
- * CXL DVSEC for CXL Devices - register offsets within the DVSEC
- * (CXL 4.0 8.1.3).
- * Offsets are relative to the DVSEC capability base (cxl->dvsec).
+ * DVSEC register offsets and per-bit hardware definitions are in
+ * <uapi/cxl/cxl_regs.h> as CXL_DVSEC_*.  The masks below encode
+ * emulation policy: which bits to ignore, which to preserve separately
+ * from their raw hardware state.
  */
-#define CXL_DVSEC_CAPABILITY_OFFSET 0xa
-#define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
-/* CXL DVSEC Capability register bit 0: device supports CXL.cache (HDM-DB) */
-#define CXL_DVSEC_CACHE_CAPABLE	    BIT(0)
+/* DVSEC Control (0x0C): bits 13 (RsvdP) and 15 (RsvdP) are always discarded */
+#define CXL_CTRL_RESERVED_MASK           (BIT(13) | BIT(15))
+/* bit 12 (P2P_Mem_Enable) treated as reserved if Cap3.P2P_Mem_Capable=0 */
+#define CXL_CTRL_P2P_REV_MASK            CXL_DVSEC_CTRL_P2P_MEM_ENABLE
+
+/* DVSEC Status (0x0E): bits 13:0 and 15 are RsvdZ */
+#define CXL_STATUS_RESERVED_MASK         (GENMASK(13, 0) | BIT(15))
+
+/*
+ * DVSEC Control2 (0x10) emulation masks.
+ *
+ * CXL_CTRL2_HW_BITS_MASK: bits 1 (Initiate_Cache_WBI) and 2
+ * (Initiate_CXL_Reset) always read 0 from hardware _ they are write-only
+ * action triggers per CXL 4.0 _8.1.3.8 Table 8-8.  Forward these to the
+ * device to trigger the hardware action; clear them from vconfig shadow so
+ * that subsequent guest reads return 0 as hardware requires.
+ *
+ * NOTE: bit 0 (Disable_Caching) and bit 3 (CXL_Reset_Mem_Clr_Enable) are
+ * ordinary RW fields _ they must be preserved in vconfig, not forwarded.
+ */
+#define CXL_CTRL2_RESERVED_MASK          GENMASK(15, 6)
+#define CXL_CTRL2_HW_BITS_MASK           (BIT(1) | BIT(2))
+/* bit 4 is RsvdP if Cap3.Volatile_HDM_Configurability=0 */
+#define CXL_CTRL2_VOLATILE_HDM_REV_MASK  CXL_DVSEC_CTRL2_DESIRED_VOLATILE_HDM
+/* bit 5 is RsvdP if Cap2.Mod_Completion_Capable=0 */
+#define CXL_CTRL2_MODIFIED_COMP_REV_MASK CXL_DVSEC_CTRL2_MOD_COMPLETION_ENABLE
+
+/* DVSEC Lock (0x14): bits 15:1 are RsvdP */
+#define CXL_LOCK_RESERVED_MASK           GENMASK(15, 1)
+
+/* DVSEC Range Base Low: bits 27:0 are reserved per Tables 8-15/8-19 */
+#define CXL_BASE_LO_RESERVED_MASK        CXL_DVSEC_RANGE_BASE_LOW_RSVD_MASK
 
 int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev,
 			     struct vfio_pci_cxl_state *cxl,
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 79aaf270adb2..5708837a6c99 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1085,6 +1085,49 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
 	return 0;
 }
 
+/*
+ * vfio_pci_dvsec_dispatch_read - per-device DVSEC read dispatcher.
+ *
+ * Installed as ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn at module init.
+ * Calls vdev->dvsec_readfn when a shadow-read handler has been registered
+ * (e.g. by vfio_cxl_setup_dvsec_perms() for CXL Type-2 devices), otherwise
+ * continue to vfio_raw_config_read for hardware pass-through.
+ *
+ * This indirection allows per-device DVSEC reads from vconfig shadow
+ * without touching the global ecap_perms[] table.
+ */
+static int vfio_pci_dvsec_dispatch_read(struct vfio_pci_core_device *vdev,
+					int pos, int count,
+					struct perm_bits *perm,
+					int offset, __le32 *val)
+{
+	if (vdev->dvsec_readfn)
+		return vdev->dvsec_readfn(vdev, pos, count, perm, offset, val);
+	return vfio_raw_config_read(vdev, pos, count, perm, offset, val);
+}
+
+/*
+ * vfio_pci_dvsec_dispatch_write - per-device DVSEC write dispatcher.
+ *
+ * Installed as ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn at module init.
+ * Calls vdev->dvsec_writefn when a handler has been registered for this
+ * device (e.g. by vfio_cxl_setup_dvsec_perms() for CXL Type-2 devices),
+ * otherwise proceed to vfio_raw_config_write so that non-CXL devices
+ * with a DVSEC capability continue to pass writes to hardware.
+ *
+ * This indirection allows per-device DVSEC handlers to be registered
+ * without touching the global ecap_perms[] table.
+ */
+static int vfio_pci_dvsec_dispatch_write(struct vfio_pci_core_device *vdev,
+					 int pos, int count,
+					 struct perm_bits *perm,
+					 int offset, __le32 val)
+{
+	if (vdev->dvsec_writefn)
+		return vdev->dvsec_writefn(vdev, pos, count, perm, offset, val);
+	return vfio_raw_config_write(vdev, pos, count, perm, offset, val);
+}
+
 /*
  * Initialize the shared permission tables
  */
@@ -1121,7 +1164,8 @@ int __init vfio_pci_init_perm_bits(void)
 	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
 	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
 	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
-	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
+	ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn  = vfio_pci_dvsec_dispatch_read;
+	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_pci_dvsec_dispatch_write;
 
 	if (ret)
 		vfio_pci_uninit_perm_bits();
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 726063b6ff70..96f8361ce6f3 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -147,6 +147,7 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev);
 void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
 void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
+void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev);
 
 #else
 
@@ -158,6 +159,8 @@ static inline void
 vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev) { }
 static inline void
 vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev) { }
+static inline void
+vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev) { }
 
 #endif /* CONFIG_VFIO_CXL_CORE */
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index cd8ed98a82a3..aa159d0c8da7 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -31,7 +31,7 @@ struct p2pdma_provider;
 struct dma_buf_phys_vec;
 struct dma_buf_attachment;
 struct vfio_pci_cxl_state;
-
+struct perm_bits;
 
 struct vfio_pci_eventfd {
 	struct eventfd_ctx	*ctx;
@@ -141,6 +141,12 @@ struct vfio_pci_core_device {
 	struct list_head	ioeventfds_list;
 	struct vfio_pci_vf_token	*vf_token;
 	struct vfio_pci_cxl_state *cxl;
+	int (*dvsec_readfn)(struct vfio_pci_core_device *vdev, int pos,
+			    int count, struct perm_bits *perm,
+			    int offset, __le32 *val);
+	int (*dvsec_writefn)(struct vfio_pci_core_device *vdev, int pos,
+			     int count, struct perm_bits *perm,
+			     int offset, __le32 val);
 	struct list_head		sriov_pfs_item;
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
index b6fcae91d216..e9746e75e09a 100644
--- a/include/uapi/cxl/cxl_regs.h
+++ b/include/uapi/cxl/cxl_regs.h
@@ -59,4 +59,102 @@
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
+/*
+ * CXL r4.0 8.1.3: DVSEC for CXL Devices
+ *
+ * Register offsets are relative to the DVSEC capability base address,
+ * as discovered via PCI_EXT_CAP_ID_DVSEC with DVSEC ID 0x0.
+ * All registers in this section are 16-bit wide.
+ */
+
+/* DVSEC register offsets */
+#define CXL_DVSEC_CAPABILITY_OFFSET       0x0a
+#define CXL_DVSEC_CONTROL_OFFSET          0x0c
+#define CXL_DVSEC_STATUS_OFFSET           0x0e
+#define CXL_DVSEC_CONTROL2_OFFSET         0x10
+#define CXL_DVSEC_STATUS2_OFFSET          0x12
+#define CXL_DVSEC_LOCK_OFFSET             0x14
+#define CXL_DVSEC_CAPABILITY2_OFFSET      0x16
+#define CXL_DVSEC_RANGE1_SIZE_HIGH_OFFSET 0x18
+#define CXL_DVSEC_RANGE1_SIZE_LOW_OFFSET  0x1c
+#define CXL_DVSEC_RANGE1_BASE_HIGH_OFFSET 0x20
+#define CXL_DVSEC_RANGE1_BASE_LOW_OFFSET  0x24
+#define CXL_DVSEC_RANGE2_SIZE_HIGH_OFFSET 0x28
+#define CXL_DVSEC_RANGE2_SIZE_LOW_OFFSET  0x2c
+#define CXL_DVSEC_RANGE2_BASE_HIGH_OFFSET 0x30
+#define CXL_DVSEC_RANGE2_BASE_LOW_OFFSET  0x34
+#define CXL_DVSEC_CAPABILITY3_OFFSET      0x38
+
+/* DVSEC Range Base Low registers: bits [27:0] are reserved */
+#define CXL_DVSEC_RANGE_BASE_LOW_RSVD_MASK __GENMASK(27, 0)
+
+/* CXL r4.0 8.1.3.1 Table 8-5 DVSEC CXL Capability (offset 0x0A) */
+#define CXL_DVSEC_CAP_CACHE_CAPABLE             _BITUL(0)
+#define CXL_DVSEC_CAP_IO_CAPABLE                _BITUL(1)
+#define CXL_DVSEC_CAP_MEM_CAPABLE               _BITUL(2)
+#define CXL_DVSEC_CAP_MEM_HW_INIT_MODE          _BITUL(3)
+#define CXL_DVSEC_CAP_HDM_COUNT_MASK            __GENMASK(5, 4)
+#define CXL_DVSEC_CAP_CACHE_WBI_CAPABLE         _BITUL(6)
+#define CXL_DVSEC_CAP_CXL_RESET_CAPABLE         _BITUL(7)
+#define CXL_DVSEC_CAP_CXL_RESET_TIMEOUT_MASK    __GENMASK(10, 8)
+#define CXL_DVSEC_CAP_CXL_RESET_MEM_CLR_CAPABLE _BITUL(11)
+#define CXL_DVSEC_CAP_TSP_CAPABLE               _BITUL(12)
+#define CXL_DVSEC_CAP_MLD_CAPABLE               _BITUL(13)
+#define CXL_DVSEC_CAP_VIRAL_CAPABLE             _BITUL(14)
+#define CXL_DVSEC_CAP_PM_INIT_REPORTING_CAPABLE _BITUL(15)
+
+/* CXL r4.0 8.1.3.2 Table 8-6 DVSEC CXL Control (offset 0x0C) */
+#define CXL_DVSEC_CTRL_CACHE_ENABLE              _BITUL(0)
+#define CXL_DVSEC_CTRL_IO_ENABLE                 _BITUL(1)
+#define CXL_DVSEC_CTRL_MEM_ENABLE                _BITUL(2)
+#define CXL_DVSEC_CTRL_CACHE_SF_COVERAGE_MASK    __GENMASK(7, 3)
+#define CXL_DVSEC_CTRL_CACHE_SF_GRANULARITY_MASK __GENMASK(10, 8)
+#define CXL_DVSEC_CTRL_CACHE_CLEAN_EVICTION      _BITUL(11)
+#define CXL_DVSEC_CTRL_P2P_MEM_ENABLE            _BITUL(12)
+/* bit 13: RsvdP */
+#define CXL_DVSEC_CTRL_VIRAL_ENABLE              _BITUL(14)
+/* bit 15: RsvdP */
+
+/* CXL r4.0 8.1.3.3 Table 8-7 DVSEC CXL Status (offset 0x0E) */
+/* bits 13:0 = RsvdZ */
+#define CXL_DVSEC_STATUS_VIRAL_STATUS _BITUL(14)
+/* bit 15 = RsvdZ */
+
+/* CXL r4.0 8.1.3.4 Table 8-8 DVSEC CXL Control2 (offset 0x10) */
+#define CXL_DVSEC_CTRL2_DISABLE_CACHING          _BITUL(0)
+#define CXL_DVSEC_CTRL2_INITIATE_CACHE_WBI       _BITUL(1)
+#define CXL_DVSEC_CTRL2_INITIATE_CXL_RESET       _BITUL(2)
+#define CXL_DVSEC_CTRL2_CXL_RESET_MEM_CLR_ENABLE _BITUL(3)
+#define CXL_DVSEC_CTRL2_DESIRED_VOLATILE_HDM     _BITUL(4)
+#define CXL_DVSEC_CTRL2_MOD_COMPLETION_ENABLE    _BITUL(5)
+/* bits 15:6 = RsvdP */
+
+/* CXL r4.0 8.1.3.5 Table 8-9 DVSEC CXL Status2 (offset 0x12) */
+#define CXL_DVSEC_STATUS2_CACHE_INVALID           _BITUL(0)
+#define CXL_DVSEC_STATUS2_CXL_RESET_COMPLETE      _BITUL(1)
+#define CXL_DVSEC_STATUS2_CXL_RESET_ERROR         _BITUL(2)
+/* RW1CS; RsvdZ if Cap3.Volatile_HDM_Configurability=0 */
+#define CXL_DVSEC_STATUS2_VOLATILE_HDM_PRES_ERROR _BITUL(3)
+/* bits 14:4 = RsvdZ */
+#define CXL_DVSEC_STATUS2_PM_INIT_COMPLETION      _BITUL(15)
+
+/* CXL r4.0 _8.1.3.6 Table 8-10 _ DVSEC CXL Lock (offset 0x14) */
+#define CXL_DVSEC_LOCK_CONFIG_LOCK _BITUL(0)
+/* bits 15:1 = RsvdP */
+
+/* CXL r4.0 8.1.3.7 Table 8-11 DVSEC CXL Capability2 (offset 0x16) */
+#define CXL_DVSEC_CAP2_CACHE_SIZE_UNIT_MASK     __GENMASK(3, 0)
+#define CXL_DVSEC_CAP2_FALLBACK_CAPABILITY_MASK __GENMASK(5, 4)
+#define CXL_DVSEC_CAP2_MOD_COMPLETION_CAPABLE   _BITUL(6)
+#define CXL_DVSEC_CAP2_NO_CLEAN_WRITEBACK       _BITUL(7)
+#define CXL_DVSEC_CAP2_CACHE_SIZE_MASK          __GENMASK(15, 8)
+
+/* CXL r4.0 8.1.3.14 Table 8-20 DVSEC CXL Capability3 (offset 0x38) */
+#define CXL_DVSEC_CAP3_DEFAULT_VOLATILE_HDM_COLD_RESET _BITUL(0)
+#define CXL_DVSEC_CAP3_DEFAULT_VOLATILE_HDM_WARM_RESET _BITUL(1)
+#define CXL_DVSEC_CAP3_DEFAULT_VOLATILE_HDM_HOT_RESET  _BITUL(2)
+#define CXL_DVSEC_CAP3_VOLATILE_HDM_CONFIGURABILITY    _BITUL(3)
+#define CXL_DVSEC_CAP3_P2P_MEM_CAPABLE                 _BITUL(4)
+/* bits 15:5 = RsvdP */
+
 #endif /* _UAPI_CXL_REGS_H_ */
-- 
2.25.1

