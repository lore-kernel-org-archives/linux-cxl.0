Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903144D688;
	Wed,  1 Apr 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054465; cv=fail; b=SHQK9cInDVCeb6cmgMtWfWc9xoQ2kGqC5BlJ7DzOtbP4IGbBXrMpvvMSGoz6nQXjf/J4UearHbH6xY6XexYC9vdDBWbZgfnLgA/asjWm/ERB7P7liKkTQ3GeGYhSfJ1SHcL5Rl1MVwcL6iYErVCoGMKBpCXNrm8H0wifOrjU7hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054465; c=relaxed/simple;
	bh=VKqaFgeBlaCo+WLtGCn4oOY5U6/kEFg0I/Kt+eJbkw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuUcUJBNgueEIo1oExGhuhe4mh1X+ycvJzIopiviZ6XS0ls5pBv7SYhI/Accd/PorYPxkVyjCNUJm6rluhftL2LIhPIJJ4x3hkk8F4M6N7WAr1bhyhJwDHUtClRgfjFnwePtDXbmumZWzgqWzN2knrz8HuHydD3TgwTX3F0uato=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bh1zyiYj; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bh1zyiYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxgYkcq25PJRLcqGw72ZSgD/krLk9dHqZ4ZYYPucA5QwVCOLwHfzbGukSarNXkvce3Se+OCAoOzEw0fJ9w0NsHmomoIqBv9d6EiEh9Zf80kwuyjxXlbqPbfBxrbjJT/qxl8DVu0eeoYJZo2kogGPotQW4o8FFT5sIMrMYuRvkQHaQRECGb04PMll0nRUpY+r6+k9OFh2jwWlZ0S6KxHLxCQLqIFgCncaJDAIs6HE7xePgyhrB6Yr420z58N5equIIjKtZ/nJmBGIynC+5hJnaqmesW1pERBXUQwYVsMdac8E/MuxVD+hMwOOvmrMwatLukVFeEWDamb5SFbMAFJZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcYfEXpIjYFMLSekJl2aYBilh6iV/wb11aY6IOFmOkE=;
 b=XnN3X9KKYJfKiHJQr/XvvNb38Q4oQjycv5LnjN2JN8iarS2JdBNlNX+np3/cVF8DM1i0HkMG1UhvDcReGobDkmZrC+ybOdZ4H2mdnAHx83NRbofqSOt7gKV8oS+qGGO+ar8mgUbloJkm1gw1fdwaqtaxjVGFaqvQ5Vd167J2dEoArJJBObGkinYOwTU4QTPsYC/lHpReRC2PFKtq26rctaBYdPWSha+TclK3taC2UKYEJdV+LMpQg3TfxDF6RntD8b9UyRuzJ8Mn/Ueh4dUcMQToGWVOt8gYVFI+/EXGTunWzznH6mB0fc/dxAgZ3m9Wzy3uIx6fP8KPr/X9eFY8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcYfEXpIjYFMLSekJl2aYBilh6iV/wb11aY6IOFmOkE=;
 b=Bh1zyiYjPYbMwhohbqAy7g4LGFi3Z+38bnqaLrTGa7qhfasmdH+PBhbSOKGbwIhByH3r+VsMFigUKg1hGaiy3zjVE3QhZcQYwiYwUl9J2g9JQ+/dkx1TTc+jM/4ZdgX7TWKfmp8UUYvgRhRe/2apq+uUHzh6vQACD6HlA3E/hU/tbXjlYZEOvFtWjBH02g58GksT1QxtZ0YwKWeGLzk9qAPusFwqdhc9eYIeInniW9MgkELgQylx232EHymWK3vmjh8DYVHjtpu/tCSgNlRFnPmK1xuZ5fel8/m/wMewzynPke+FwSfyOTweW3hkDIrjtGvZd7y+tIvq8nrU564GsA==
Received: from SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Wed, 1 Apr
 2026 14:40:55 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c5) by SJ0PR05CA0146.outlook.office365.com
 (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Wed,
 1 Apr 2026 14:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:31 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:24 -0700
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
Subject: [PATCH v2 07/20] vfio/pci: Add CXL state to vfio_pci_core_device
Date: Wed, 1 Apr 2026 20:09:04 +0530
Message-ID: <20260401143917.108413-8-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 141c3495-2b6d-4c46-db5a-08de8ffcae5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dKv3G7VUKKp0kAMX2+P0RmwFKDfomqvPdImGiqQph6vANNDEeU1oQtxRGRgn31XH8fGaF0qsu2vncg8SkQJNydX3YfNGYRqOmFWss6+YoiqxtnFtrAk7CR/q37/Odt8BoN3ZVHwYFHIv2tn7UFEwJ//w4ViJK5GjnxYDEquk7OTjFWBVBk6YiwnsQ0AjQWJ0VzMQLJhrUwtCGyoDuDNnYlx3TrfVdxtHEilYyb4koXZKje1iR8Gum11lom+Ph+T7bVaATn2D/Wb8doLM042BMiP6aCEZnjR6GK6UUh+VDyEsiq+bH85PbVZSRA/gwXI20v2UshshJR2dow1ITWWrijV8OE8nvDU5kQp8E95jz94o/VZ2QZ/h6JC1b3UyBTBoeEDymHd8BOyT+WSyIJPdF71NtXGdojjxL/vQzzl3V3o+iEoCSbug0rFkEelJT4gWVt4axLfSCsIJ/qakVJEE2Sjxq59hWqTQw6rYNKRiHVvc6VHuTN/eiKTnVhFw89P/mrVib4x+RKHyafVF4Y+L+XTWrRxnza7qXWQgoxoxy4V8NtcEIr7K+sECmgs+q6/KRc2Ynhp3Z6cvCP/9K1sFCS24H6UAFXYxcUwdoK/9m8lRd0JGX7Er8YoRzPxmRiK7vLdHzK6AfB9/3XW/xJEbqhIQWBTp+X0fj4m0MdrdabrVf1kLsTwYzzXAseyl83aJIMCEOOiyiSZJTW7xxdLmNG3AJtp2wk9zQmBoltIocdI3EtTnBHp0Xiyv34bLpHO8nWvOe5dnFBUa8QOslULgaAtn5Xe/XmrSVKxRy/H5MY4wYETPdGP0C1sgOw+10wBO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KWuCyW8EzgnzeNtCR/tWy0j0xDqujKkzECcPCRU2QnMpgWfsMQF08j1p17yoyk03AC/XkBj0GM81X3xVV9i5ZsP7PgpRunvx+gndJqsF7hbb9d0NE43LUV3KM7x/XBzjlb2HWwXKz+9H8wdSBHqli4q8n69twU1v5J5wc3fQx2OeO1D67qqiy6NhvR/ipBdklcPAEilR9cIhNof6FN8na2swjae5CJAupRdUOD5OMDhNbpzTFu18pHbUd4fEElGd62dFGTTlWphWd4SzoMHteB5qkcAqo97xK3H0dOgP2HIhjaiftFzC4QDW29pJOHHPJUtRn2cE3FWEblIsg+P2zm6qxlgwRxHsB8/dzNVuncn9NimnHyrxJRwUGBOCYmvCbBAH2gztcTPBkHNhwn/CM9wvF3wsf3MQplIcj49H70khs55j/hI4ELF/3tFhTo6r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:55.1694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141c3495-2b6d-4c46-db5a-08de8ffcae5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425

From: Manish Honap <mhonap@nvidia.com>

Add CXL-specific state to vfio_pci_core_device structure to support
CXL Type-2 device passthrough.

The new vfio_pci_cxl_state structure embeds CXL core objects:
- struct cxl_dev_state: CXL device state (from CXL core)
- struct cxl_memdev: CXL memory device
- struct cxl_region: CXL region object
- Root and endpoint decoders

Key design point: The CXL state pointer is NULL for non-CXL devices,
allowing vfio-pci-core to handle both CXL and standard PCI devices
with minimal overhead.

This will follow the approach where vfio-pci-core itself gains CXL
awareness, rather than requiring a separate variant driver.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_priv.h | 28 ++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h        |  3 +++
 2 files changed, 31 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
new file mode 100644
index 000000000000..4cecc25db410
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common infrastructure for CXL Type-2 device variant drivers
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef __LINUX_VFIO_CXL_PRIV_H
+#define __LINUX_VFIO_CXL_PRIV_H
+
+#include <cxl/cxl.h>
+#include <linux/types.h>
+
+/* CXL device state embedded in vfio_pci_core_device */
+struct vfio_pci_cxl_state {
+	struct cxl_dev_state         cxlds;
+	struct cxl_memdev           *cxlmd;
+	struct cxl_root_decoder     *cxlrd;
+	struct cxl_endpoint_decoder *cxled;
+	resource_size_t              hdm_reg_offset;
+	size_t                       hdm_reg_size;
+	resource_size_t              comp_reg_offset;
+	size_t                       comp_reg_size;
+	u8                           hdm_count;
+	u8                           comp_reg_bar;
+};
+
+#endif /* __LINUX_VFIO_CXL_PRIV_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1ac86896875c..cd8ed98a82a3 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -30,6 +30,8 @@ struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_phys_vec;
 struct dma_buf_attachment;
+struct vfio_pci_cxl_state;
+
 
 struct vfio_pci_eventfd {
 	struct eventfd_ctx	*ctx;
@@ -138,6 +140,7 @@ struct vfio_pci_core_device {
 	struct mutex		ioeventfds_lock;
 	struct list_head	ioeventfds_list;
 	struct vfio_pci_vf_token	*vf_token;
+	struct vfio_pci_cxl_state *cxl;
 	struct list_head		sriov_pfs_item;
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
-- 
2.25.1

