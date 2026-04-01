Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F20477991;
	Wed,  1 Apr 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054514; cv=fail; b=RPPolVUoGL/m++iO2F4T4KRGwoFRoYCSkubwozR0WCDDqtYauiC1XqJyMnyPWOkLFlrxrTDeINeO483Cz9o86trIoMtcO3iPHxxGv0n3UbOAKZL8hXxs6y1aiV9AB4he37mRSMiorCNSPz4aS7JZTmPUJuMPWYVBItKqwo8RBao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054514; c=relaxed/simple;
	bh=aVU8CdYnp9eKjsQtzfH1L7trCI9kB9PR7DMX1n4OcQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUkkVFiJ7mtlt9V8p5TD3zs5hJF0sJmRn+fBMzmBCHv+dmoDZdM9Xn14WLK+pzenB/XKgLcJVZMrAy0rB3fSboQ8R8Yj3Y+m/ypWiGy+rnkiG+3HIxcLb/hZckWIviZUvtR7fAFvVE26rhel9eDnBHJaSIfGDjfF4xHW6h3ogII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNLMdL06; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNLMdL06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIY6ZAJy5BrmQVnH4CWSpUmZ/bygNhk9R69DMgEE7RIDChdYmhYFeZd59UD5Qngj30KuHzkj4HKQfYRgVQN9uES3Bh9GNA8nhQw7wfJUQQ9aVJs17VZ94WGleNM4K8bcOHpqLBe86As66aV3UIXV3fgeT4OCNZjJ/NaCgDFOw1z8INGjOF50AxsNehFip6mO//7MC/IWlV/JbQ5l+liARJo6BFA8mCZxL0NjZlDvjCa2N294vc3FjpApVASOZWTi6nOBheDXdsGlhEToJPA6qnPbaLCKXjZ0GFh7oQAD3wuHjTbn+91qQ9nfJuaL7R4Qnt7G8qC18XVtLAhnxaZNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQhvKt+IvBINGq5ByeFR7CgVwADZ59Ngp7qTEaCK5EA=;
 b=FwNdewb9Y0T+877ozx5JE6JX3U9VlFtGroDacQsgJG6+kYN6Uo7hy9DIQY/28tzHA+7iu7nC+e7PXlXl9afoOqCIffDG2+raFWCz9HPEz9l+B1AQM/85c90ncl1uCDs7sYR4snngv3iUgsPZm5VmNddErn6NyV/qwu7jnbltQJ5kf0zEfqA2sEs4xvMwp3Fa9DSeoSNmOiz9hl6NM2q7UpV6yFtKyajk+kLA3GOG0xYRWXKyS/vL6HwF17/pAxsGjLG3sfShEN+O3Y//wS3KB2Txmx2ryNZ5ApHpboStJJRM6VjPA5x6AkWdy4gDJip3dnrB7W+/ews7nXqKK/kAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQhvKt+IvBINGq5ByeFR7CgVwADZ59Ngp7qTEaCK5EA=;
 b=GNLMdL06pIBMmgCXP11+TZmw3QTSafhtjcLM0StR1S6NDMc7lTY8XTQadeIWHmzekDnXGbo/0ORlqyA0vfB2w4HtlUQw6PsifjoEKOf40DU+XPSzPnDv3ukvgDrNk1o3Fly1VFZeY7+mlimwmNu1G6Y9vC+HdE9AxwIxUjBGq2Bk7qfws5aK9sVpC+H7A8me53oz1NdN5zo64PD95hFOgHssb3+MZvLMJZru+/0EoYYFhXYgg3y+uWnWVq+Wb7Rzv8qCYuMlwdbv1jGaVxmstBYTPGwGGBQztOWmFQh8TYw9ZYUeTzmaP2VlV0ZHCky1c3CkiH+zDNFL37o+XbMyLA==
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 14:41:12 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::2e) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 14:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:38 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:31 -0700
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
Subject: [PATCH v2 08/20] vfio/pci: Add CONFIG_VFIO_CXL_CORE and stub CXL hooks
Date: Wed, 1 Apr 2026 20:09:05 +0530
Message-ID: <20260401143917.108413-9-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 008f60bb-96f6-473e-0417-08de8ffcb235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CQjuVf9pc6eghZm2eJJ6q+jdNHdwbQ2W74HYyr4AiCaFsyhG/sE3swJB9CBqYpRWvLV9V6uv/i8lJoBDyeFs5lUnckHGqyfApo2XcesbqWuC7NHYlkt15zc3Gak9FygZXxzDsBxtP+cCZGAwpGznsG3ZFt42jtj+l8x6SFgywcQfO12DGVwgf6Ez/bYjuxqcpHGECCv6iXc1WlJzpjEkVfw6e1SCpTKqRJLXLgxzTL+nsvEYV2fJ6WYIVVt0AIkHI7YthYy+T3xpsl5Fv48L3gzBMKRMMlJlBvpcKM1l/i8vq3CvXtY0Q6IZrEo6D29UjfworRLvwleEr1mI2npNYDTLQ4ZFBQAcOowv7IsgEDyjOjlGPOZgkNcimz5H6coQ3pQQhdFujCkbZ+4P1LsmcgEv1QU6jkVO1jGfl1zlGuwx9BLLRXI7zgGnkNc9Ni0KXunPuZQJf4UvXDlzqu9KA5U3mPHjUFgVjNiymUeb77HJjIVMcoEdoO8VeRZb+4Zxlw7LPcEbmlDYb1unnjt2PMHCZc6w9TnjvQRSmTUz9oQSd3KReWgyMB3luzBQvuBnDNlqDUZiIyGP7aWzfUahJyLrzjAGO/PIpEtl9lOwp9ENbTl5jLCWGy8USJAu/J8yF2mmZrDcbhbIXRA7BZAimaNdcldNvuaWObsnhkTCcWupSNzLEnwyR2VTLs4m52nZLhfSQJmRMxqGsPQceFitkuff8uw8Sqjv8IsOhcZ2C0ATtRQAoaxZrFm2EygV8kywX5Izr/hlP/vmc387p1hn5Imrs3mb9nCdnygTEvq6NdrEfQ00uKCk1hOGZnkXh/ib
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TNs6FrUbhzoQr5HeUIMxr9fkRLs+6Eh/GV2WCP4NJ4rRRLjvwhODHSXhorK4yO0uqmFi9I8ewFQltm0C5C2EWSyJ2iJy214cwLE54NPCDif0To8G0qPLNSlGX4xwDo27sDdiuvrQOz6jrHHsOewlNAhR4m6DJFs0jFUn7AQYGua7Vatj2jpP4v2k/+W3AwYxmSzyf139HvjgZgr2+3lAvRo4ij4zfkQnwqfwQA8GvRIhH/+0ouxlMGntXRzrZgX6t2koexCyLcKQnYp2v7C8p35K+iObW1s2GMRLpOC63Znxe9VxEMLG6xh7J3JHg7PitH3I97SK5zPkMVYW1fhVDTTadLGz+vf2NhH/AfwquHQEepVEWnQedFOCxN4ca0s1+QT96LoGxaJhcMDbeDcVgHTb+OviStodT95I2tYieS3C7kjhnO/SAFO4CW81zRIn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:01.6239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f60bb-96f6-473e-0417-08de8ffcb235
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

From: Manish Honap <mhonap@nvidia.com>

Introduce the Kconfig option CONFIG_VFIO_CXL_CORE and the necessary
build rules to compile CXL.mem passthrough infrastructure for
vendor-specific CXL devices into the vfio-pci-core module.  The new
option depends on VFIO_PCI_CORE, CXL_BUS and CXL_MEM.

Wire up the detection and cleanup entry-point stubs in
vfio_pci_core_register_device() and vfio_pci_core_unregister_device()
so that subsequent patches can fill in the CXL-specific logic without
touching the vfio-pci-core flow again.

The vfio_cxl_core.c file added here is an empty skeleton; the actual
CXL detection and initialisation code is introduced in the following
patch to keep this build-system patch reviewable on its own.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/Kconfig             |  2 ++
 drivers/vfio/pci/Makefile            |  1 +
 drivers/vfio/pci/cxl/Kconfig         |  9 ++++++
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  4 +++
 drivers/vfio/pci/vfio_pci_priv.h     | 14 ++++++++++
 6 files changed, 71 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 1e82b44bda1a..b981a7c164ca 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -68,6 +68,8 @@ source "drivers/vfio/pci/virtio/Kconfig"
 
 source "drivers/vfio/pci/nvgrace-gpu/Kconfig"
 
+source "drivers/vfio/pci/cxl/Kconfig"
+
 source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index e0a0757dd1d2..ecb0eacbc089 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
+vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
diff --git a/drivers/vfio/pci/cxl/Kconfig b/drivers/vfio/pci/cxl/Kconfig
new file mode 100644
index 000000000000..fad53300fecf
--- /dev/null
+++ b/drivers/vfio/pci/cxl/Kconfig
@@ -0,0 +1,9 @@
+config VFIO_CXL_CORE
+	bool "VFIO CXL core"
+	depends on VFIO_PCI_CORE && CXL_BUS && CXL_MEM
+	help
+	    Extends vfio-pci-core with CXL.mem passthrough for vendor-specific
+	    CXL devices (CXL_DEVTYPE_DEVMEM) that implement HDM-D or HDM-DB
+	    decoders without the standard CXL memory expander class code
+	    (PCI_CLASS_MEMORY_CXL).  Covers CXL Type-2 accelerators and
+	    non-class-code Type-3 variants (e.g. compressed memory devices).
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
new file mode 100644
index 000000000000..d12afec82ecd
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO CXL Core - CXL.mem passthrough for vendor-specific CXL devices
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * This module extends vfio-pci-core to pass through CXL.mem regions for
+ * vendor-specific CXL devices (CXL_DEVTYPE_DEVMEM) that implement HDM-D or
+ * HDM-DB decoders but do not report the standard CXL memory expander class
+ * code (PCI_CLASS_MEMORY_CXL, 0x0502).  This covers both CXL Type-2
+ * accelerators (with CXL.cache) and non-class-code Type-3 variants (e.g.
+ * compressed memory devices) which cannot be paravirtualized by the host
+ * CXL subsystem and require direct DPA region access from the guest.
+ */
+
+#include <linux/vfio_pci_core.h>
+#include <linux/pci.h>
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
+
+#include "../vfio_pci_priv.h"
+#include "vfio_cxl_priv.h"
+
+/**
+ * vfio_pci_cxl_detect_and_init - Detect and initialize a vendor-specific
+ *                                CXL.mem device
+ * @vdev: VFIO PCI device
+ *
+ * Called from vfio_pci_core_register_device(). Detects CXL DVSEC capability
+ * and initializes CXL features. On failure vdev->cxl remains NULL and the
+ * device operates as a standard PCI device.
+ */
+void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
+{
+}
+
+void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
+{
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3a11e6f450f7..b7364178e23d 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2181,6 +2181,8 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_vf;
 
+	vfio_pci_cxl_detect_and_init(vdev);
+
 	vfio_pci_probe_power_state(vdev);
 
 	/*
@@ -2224,6 +2226,8 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
+	vfio_pci_cxl_cleanup(vdev);
+
 	if (!disable_idle_d3)
 		pm_runtime_get_noresume(&vdev->pdev->dev);
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 27ac280f00b9..d7df5538dcde 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -133,4 +133,18 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_VFIO_CXL_CORE)
+
+void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev);
+void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev);
+
+#else
+
+static inline void
+vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev) { }
+static inline void
+vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev) { }
+
+#endif /* CONFIG_VFIO_CXL_CORE */
+
 #endif
-- 
2.25.1

