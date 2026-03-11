Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BE355F43;
	Wed, 11 Mar 2026 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261385; cv=fail; b=h3sVTcef1qHtFxx0+79UQILPyJMJDYA15w8X6xgVIKbbH5C3Ci9k7BeimryBtHNoWwTGWsyMnh20VjPR5izzS06CZuZTy29H5Zlxilr8/3CUX5X7Aen0sT/nca1k+YpjNWFtfzFi+vS85kJOgHZaNJBP7OQeqPKFTJXBnGc4/IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261385; c=relaxed/simple;
	bh=L/1hLxehiOmD5kg10I4WYspKbrBzK3/WkWKm7YXMLrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klvTrn2ZYMH4kHlcD7m899JVPd4bBJfEAdviFyJXAMgLRac5Tj01vu1zhtpwJP+Sp8oVAUgTypXK1W9YR2towp9GcpXr6fUjBqsLvCPidDsckrx8j0HrSvs7v7MFWrtC8FxzMCiINSnUaegRjEk/Av8nuieVT/57NIEzOvSrc84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4eIuhx8; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4eIuhx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OV+d4T2ohNJjJ5iZ0Q7SR9yXxkLaR239PdJ+XwbqoG6QDC/X8hvidXRsicBD1iHV0E5iZhybM2pmXkDN3TkDb0FO5JDg5I8rJMF/Xix7XFn9CKPH1dWBVeiPYQ1lEPREVY05K8YgHkgF4L2dajGNkfeS/Y9Qazrx38aVRymPEBw8m8/ExvNeGlenJeKCemVXXeACfXJMXOIJcLJtFYPaB2xAd1rlFwUX1cQF0RjviqGK+m61c3wSfiiYnmhsXoFqwXw/wzbcx72Nc8kMcr56LI+00a8WAEKml/CJIuOnTM5vWh0V1tbHAmM7ii2XjDQgKqVAnfZISR8n8QMu/7IKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOGLVrR/t/2x6MxDg6EgsYuPheuqVj0oFy1iZQjpB/g=;
 b=VMpwJOjQt4VnNqc0vzrvHQFPubhPb76+gYzRSgQHGHMW5FQbKKLMFbnmR54Ak9jDkLk2XG31XdHUIyCq+81xBST3QYvEFTKdoxBsaYdxWVuI4BGRFd8vYAqUGAbDRupE1ix9jPxxASznXAF1n7TnIhiTRK4rpKEsdrMbLRE+VB2LJ+r2wp4X4kqcrLb7V9890cBIQNe0Xj4FZfrG3GCmCt6NZmUgrww5cHD3tTQ5PdYGL6rdBfWB8jqjy45EEMGWjVU0k9fqKc6olqKq5JNCqa2rck/4PlvAXv1ZoUCbbBjN6v6jMumbAJLINnJafHswKy3l3F3ZAlGctT2fCC/GYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOGLVrR/t/2x6MxDg6EgsYuPheuqVj0oFy1iZQjpB/g=;
 b=A4eIuhx804J3cRaJI/RlG/D2Rg3Shwv7J7pDxUny07l4vQwB3K8ucr+Jegjy+lk8IMuB8rjStKWBZQAGKruT7atwQj1ZJZFpZxXeSdmASTDxGtNCwi1NWke7xZpzrucBYhDi3Yxew9DN63S/7f3fatWFvkIYwQCYVFqHb5SXWaTap5yK+EbrJmK8wil6YsgZrrU1vZh9dg+VRpDuYQ8dvdwlaNBZR/UUB3auVpqK9bgmf2vDdOKWDFXa18M7wpCSwxJGbUvChSr6t3XShgvZl74NXwv6SO0LJGVUmYwwV9S76ad58+Ipabjy81nhvISBf+vJtfEM3Ftx15TNy8Sbhw==
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:36:15 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 20:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:36:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:57 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:35:50 -0700
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
Subject: [PATCH 08/20] vfio/pci: Add vfio-cxl Kconfig and build infrastructure
Date: Thu, 12 Mar 2026 02:04:28 +0530
Message-ID: <20260311203440.752648-9-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f442780-f628-4adb-98c6-08de7fadd770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SaTkl30cKR/QBVjt4ZZnnLf9GYbsgqueejCy9oBDNjghyevxVPPcoFky9r4ia9RmE4JxbSSezFIoNtqQRG/hVQ+XdGOXksBhK8HsJn7kpksJjeKuSkxplUKHxsPsAi7OIewRfD9AWXisWi+hc+ghctM/ire6qoYmjUIAaNphfcv8GFHKBuPAeSlTl/Oasw1ejxvr1PueLbFvDdmxkm+w9KEevDNs25QLoAWUnkP29X1ODDkvNadUs1W6s6pIhUb4rs4NcXNxWtmg7tQZONOzVkwv4BYWMu1uVOwdZXgSKWNvO1+4b0XvScqXT+tpXXZ76qu1XyjpZX5TFg32T0xxC2h3Djhlm1FruogL1C3++a+H4SwnaEBB7ExJp9ud2xKi8bo4esyd5dHGYN+3FJHy+P47ndJAM7UvQNGKzuUMsey3n9CrOI20L5hcR7VF31VCkMKhelZrboXZzDk4PgzYMo3vV0oiNb+QX2usoVTlU6brmSgelKME0A/0589GPYwT8Vy94ponFj+++iwfIJaWL6Q2+V5EGgl1Wm0l8G+sVeVIev3L+lcIJ9+YB66eFDUriACxk2b6WdsalgOlMdhFDsrGZX6zfKxtYPlk7GTUN2NN33DTWl2+L2DgZZX0i6C8ityN9aPg+p3hTm2x0lLE+CnY2pMfwn4km4KyQpWevs67FThRgMu5g0GPCWRznSR8iZ5TfgFqVnMi/ilrYwMDrC4sHH84mFP5IZmwvGVVhRO/pj6dROyd0ZYnmDDIMtavBT19bnyuuJpu5GTbrmKJ0iunoubu8aeLie3tKX0bra4g5W3w7+85za2Hg/Jf1HMw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BQZrukkaxcaFFO4pn+Zm+SBnEKIIUJ3XgM0Pt+cNTZxv4J/wihHZa4gGfj7Cf7ngbcVbLN/wHDPU22/GVy50dxXegHhAMZeCJ5ORkKHovlzFDBDsjC11zX6mjqF+AQRQFu/j9tHRB5gngveEJiFdj0DMYlJ4BtX9RCD+kBJv4a2/KkptXdxhzFtxeXWxj8eHjAMBYwrRomDR5mcvxPw7p4PUWXYQBtJi6VLVYI4kXHGivBpSw8Y6hBJ8VI4qHCW6ghtj+IH7VpelB8KbUxCFfKCCH77dK2V+OUSt/4FFP4gAIsMmLHc8Qyqy4a1LK8avIsyEqd4GwITJeVYcp8CptwzegplBOPcUwPpjok9/alu+LmzVy3F84KH+bgvOxCjW/ovXDlY7RLyl1Ou98Du0fE5ehqBdxMYAizXglP+EAufppagbbjo7YHLckAvkBvS7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:36:15.2266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f442780-f628-4adb-98c6-08de7fadd770
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262

From: Manish Honap <mhonap@nvidia.com>

Introduce the Kconfig option CONFIG_VFIO_CXL_CORE and the necessary
build rules to compile CXL Type-2 passthrough support into the
vfio-pci-core module.  The new option depends on VFIO_PCI_CORE,
CXL_BUS and CXL_MEM.

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
 drivers/vfio/pci/cxl/Kconfig         |  7 ++++++
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 35 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  4 ++++
 drivers/vfio/pci/vfio_pci_priv.h     | 14 +++++++++++
 6 files changed, 63 insertions(+)
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
index 000000000000..41d60dc0de2d
--- /dev/null
+++ b/drivers/vfio/pci/cxl/Kconfig
@@ -0,0 +1,7 @@
+config VFIO_CXL_CORE
+	bool "VFIO CXL core"
+	depends on VFIO_PCI_CORE && CXL_BUS && CXL_MEM
+	help
+	  Core library for VFIO CXL Type-2 device support (enlightened path).
+	  When enabled, vfio-pci-core can detect and manage CXL Type-2 devices
+	  without a separate variant driver.
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
new file mode 100644
index 000000000000..7698d94e16be
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO CXL Core - Common infrastructure for CXL Type-2 device variant drivers
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ *
+ * This module provides common functionality for VFIO variant drivers that
+ * support CXL Type-2 devices (cache-coherent accelerators with attached memory).
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
+MODULE_IMPORT_NS("CXL");
+
+/**
+ * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
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

