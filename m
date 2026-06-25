Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEC23E25B;
	Thu, 25 Jun 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406579; cv=fail; b=BL7kmH1tmgTNfldBnQ7neYx4dfINqXoY5AmAjbvAMZTUAgo6r/M6nAPH6L6FU4eW/d75URykbdrxysiGvnejxkhuYREwPOWnA76OhLenkeOspRjo4M8zJL86ORMO4NCYXCgp0SlDotmFJe/EqQGwhnEaMPvLOw0Kz06pL9URI7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406579; c=relaxed/simple;
	bh=f2HQV00xZsQzV+jXEeJliQflRDhbMU+0RQa2gA6Evms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0AWw7Y1UL5dcAB3lxclPL5E65T7MtpWbcjcF8dKyLSddyvYBq1EeCfaWsbIZtmOLokAov0pG/BzCa9URcrLOgv+glkO/snoFYOL31NiE9NYpbddVhkbMWfwHWq5R2uE0yVCw+M0b/NoTDrQHwfmvQEfUvL6e2qHclCiJwV4Pco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OYEqdqXK; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYEqdqXK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwQRreibsU9Z1ZakLouNesXwT0gcSDkBzDaq1UAg6H2I2HONqBhrWzjv/9b4l/U0u3FFpEMGPBNAlP0znl/IWmBkyigXZ1RkjeUKS3ALocoR6dssrdIWuFp7qtXlEMEBTpwZjsvkE5k8CiKKbU+wRfzOw+cmPJ0t8iHoqmU186fDmBNvQjAu0ladPwGmDdbzLg34VKN0gEnYZocU7zaFFxPhkZfbRxigbl5UvbR/t8/wr/uLV3XyUkmpBVdUMjra0SX85sYL5EizX9VruqC5Up6wyhEon8F0kF8OC1jo25T3Ah0/yfbgmmC8DW8O/+eYAze77EWAMWLNCzawWfiODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL3a0nV2t9jW6ysHG9i8M+8JbCQzLp6hokRBoSX1Cww=;
 b=ygdvJDZu+eWS7A3/qCPOpJL/umcxco5dKrMvIhTajRUADPIXrsGr1ngTxW+wYV2dowWzY4iR8Jrn4UpiPdWihfo7yI7mLN2mwKOmO3Ed5DRgCh26CZd9rt/52h+w1e9697TOGiHMpCQASWHWX8F69W65Pf18H42Zv0Y5bISt3Xi9zeeR3SjcOhuZXn+codnRdpumWV65WxhMuHtykausGt+8+G5z3RwX6GzWEGaDeZ6GCfawh7pnyTdgFphQ2z1URawh/4oyZ79H3PR98TxxivWb+gLagorVbBM2q5vfyJrUTvBFt/upWkK6rx1/SkPHe1NbVyL+lDcSW6rI0rih+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL3a0nV2t9jW6ysHG9i8M+8JbCQzLp6hokRBoSX1Cww=;
 b=OYEqdqXK6ItnQ1gtt1pgM5bR194CkBk5mrI4IC7DhgG5DwEDnRNMCGFNoI4gRsO22JkqlNQVtyju7gYDxF0I2zQy4dAEEt6gkP8SsHtZqqit0W/iD6gciVs6ctU6IJM3sdvylCD8koYVdCeWRph1tz2mO1odYcwzmSTKVOMu9NhkZMPkGfcVssYaW3g/S2edQtRwReSOoxKPPHYYhfXCsKBlPtqEnrjXgmzYZUykdzw2TXIwR/l5PBp9VdBQ1gAmZwwm/azDCRHB4DZyJDzJTHkvaNeGlzBjz/+fNDqeStYugzC7/RcmFOCxd+LR9ehb9q7c1YYOYyYAhZQZuIP+wQ==
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 16:56:03 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::39) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Thu,
 25 Jun 2026 16:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:56:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:38 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:31 -0700
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
Subject: [PATCH v3 07/11] vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2 acquisition
Date: Thu, 25 Jun 2026 22:24:03 +0530
Message-ID: <20260625165407.1769572-8-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b74286-b238-407c-adc6-08ded2daa38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|3023799007|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	By7w4pZheRbw+sRtXE19GnSoCPp4k+51LKHqPsMLEE/ks6l/k98qSw4V2B753qpz7J58NH5rj952SqMhIxhrkCZD1MNae5tar7O+rJU+DPxbYi+eFOeE4z5FesFfARZB3qv/TDJ8Xlri9tcji/Gr80rNKSwGfQhwbRynuL0VGYYauelTyPIwxkCAYyDLJ1TiTAqhl/apzAJasfe2RA8oItP9DvZ8iQOBjPMgzLZ/yDGyU5FwRQ2pzq1WxQQXWcqzZ/36eXdKW/JvGFhf7toy9gGhyjnRy82DzL5Z/JXCiY+ybaWytQxziGhydov0RLXGqkFWpG+pIlWUVeY4Dinqu1npPDoTQ7+IHMKU/hzzZwc43o0JHYrjqYCylYvyZQ0mknX9Xn7a51fv7KKKHDKQdOhKAm9fTfEPX/6I4esznVN/6xMTXaeglSBDmVGMivIoyJ1A9UDwbJS3McvsRdj58k7WMQELnJJaabCbYPr018qqfGwCkDVmLThe0iykT1xWsZXcvKA8LqjrOJaWqNnkCLob7tcQdKXWAXlLfb09biESNrbtErWQw0PlpMjnUpX91CDSfgaf3a+IP0voalJHmyQqDHz2ROGI7Mxj2h/h3fntbqnJj9xZuPJB6xzw3kyf1qturJeulRsBMkcG/k0R5NLbO8guS4W5i9FmcjLIO6NvcIKqNXYW2XqsbBeJR9v6f6PlDVmFS0eo+FAh0yEzUMreTd0WxnXwRa1khWfT1iBN9NI/zKl9TKYUIAv8lx86
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(3023799007)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GYfOIrofltibgwtyVeuIAfe3vwCckB0lWHgWBMFKGSa22LkHjdQsS5pnnkG21IRJs40kdPBNFf07XLHHfGxIJhz1X7iEUR8c85Qn+uTQybynlxalqD6CgQYxQ/YP+8ycC9JNTyclaPv2pUdH+FPpmQVtdoOjm1WCyr8VLswBGLGuSz05jCztD1mahfqFUBfMk3KzE7VrrHZAU4echFDpbSwyNpLQSsW75xZE3rFxBLUwlIO67WvWB6k56vSwEli5pYKiQKcwFxBCBd9oVMbwW+m8Dd0NPjmXlDAqsTQhv0QgNxjkVFz+QFnbb2rwaMc1lJJe9Sh+dtWH3YKg/S2gC6hrv6P5wAE+NhzHdTLV43fTMf+0z9ihUBX0LZp+fH0/SjBMk0oObQvEsqf+F1rNbBgGlt5Y0McVUIxV2ppA9j5vufrdK4uqKl4lRUa8uKkF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:56:01.9991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b74286-b238-407c-adc6-08ded2daa38c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

From: Manish Honap <mhonap@nvidia.com>

Wire vfio-pci-core to acquire CXL Type-2 device state at PCI bind
and release it at PCI unbind, mirroring the existing vfio_pci_zdev_*
integration model.  Four lifecycle hooks are introduced —
vfio_pci_cxl_acquire / _release / _open / _close — with !-config
stubs that return -ENODEV / 0 / 0 / no-op respectively so vfio-pci
behaviour is unchanged when CONFIG_VFIO_PCI_CXL=n.

vfio_pci_cxl_acquire() implements the bind sequence:

  - pcie_is_cxl() and CXL Device DVSEC discovery (-ENODEV if absent
    or if MEM_CAPABLE clear — caller falls back to plain vfio-pci)
  - devm_cxl_dev_state_create() with struct vfio_pci_cxl_state
    embedding cxl_dev_state at offset 0 (required by the 7-arg
    macro's static_assert in include/cxl/cxl.h)
  - pci_enable_device_mem(), cxl_pci_setup_regs(), cxl_get_hdm_info()
    (rejecting hdm_count != 1), cxl_regblock_get_bar_info(),
    cxl_await_range_active()
  - devm_cxl_passthrough_create() to snapshot the DVSEC body, HDM
    block, and CM cap-array shadows owned by cxl-core
  - pci_disable_device() — clears PCI_COMMAND_MASTER but NOT
    PCI_COMMAND_MEMORY, so cxl-core MMIO accesses from the next step
    still succeed
  - devm_cxl_probe_mem() to register the cxl_memdev, enumerate the
    endpoint port, and attach the firmware-committed autoregion
  - request_mem_region() + memremap_wb() of the autoregion's HPA so
    the HDM VFIO region can serve guest accesses through it

The sequence is fail-closed for confirmed-CXL devices: -ENODEV maps
to plain vfio-pci fall-through; any other negative errno aborts the
vfio-pci bind so the guest never sees a half-initialised CXL device.

vfio_pci_cxl_open() / _close() are present as stable call sites for
the region-registration hooks that follow.

Selects CXL_VFIO_PASSTHROUGH so cxl-core's per-device
register-virtualization helpers (drivers/cxl/core/passthrough.c) are
built.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/Kconfig             |   2 +
 drivers/vfio/pci/Makefile            |   1 +
 drivers/vfio/pci/cxl/Kconfig         |  34 +++
 drivers/vfio/pci/cxl/Makefile        |   2 +
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 369 +++++++++++++++++++++++++++
 drivers/vfio/pci/cxl/vfio_cxl_priv.h |  71 ++++++
 drivers/vfio/pci/vfio_pci_core.c     |  24 ++
 drivers/vfio/pci/vfio_pci_priv.h     |  21 ++
 include/linux/vfio_pci_core.h        |   7 +
 9 files changed, 531 insertions(+)
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..4cd6acd36053 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -58,6 +58,8 @@ config VFIO_PCI_ZDEV_KVM
 config VFIO_PCI_DMABUF
 	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
 
+source "drivers/vfio/pci/cxl/Kconfig"
+
 source "drivers/vfio/pci/mlx5/Kconfig"
 
 source "drivers/vfio/pci/ism/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..ac26e7494f0a 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -3,6 +3,7 @@
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
+include $(srctree)/$(src)/cxl/Makefile
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/cxl/Kconfig b/drivers/vfio/pci/cxl/Kconfig
new file mode 100644
index 000000000000..5d88999e1256
--- /dev/null
+++ b/drivers/vfio/pci/cxl/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VFIO_PCI_CXL
+	bool "VFIO support for CXL Type-2 device passthrough"
+	depends on VFIO_PCI_CORE
+	depends on CXL_BUS
+	depends on CXL_REGION
+	depends on CXL_MEM
+	# CXL providers are tristate; refuse a builtin vfio-pci-core
+	# against modular cxl-core (would fail to link the per-device
+	# helpers in drivers/cxl/core/passthrough.c).
+	depends on CXL_BUS=y    || VFIO_PCI_CORE=m
+	depends on CXL_REGION=y || VFIO_PCI_CORE=m
+	depends on CXL_MEM=y    || VFIO_PCI_CORE=m
+	select CXL_VFIO_PASSTHROUGH
+	help
+	  Support CXL Type-2 (HDM-D, HDM-DB) accelerator device passthrough
+	  to a KVM guest.  When this option is enabled, vfio-pci-core
+	  probes the CXL Register Locator DVSEC at PCI bind time, acquires
+	  a cxl_memdev and autoregion via devm_cxl_probe_mem(), and
+	  exposes two additional VFIO regions to userspace: a mappable
+	  HDM memory region for the device's HPA range, and a COMP_REGS
+	  shadow region forwarding HDM Decoder Capability accesses
+	  through the cxl-core register-virtualization helpers added by
+	  drivers/cxl/core/passthrough.c.
+
+	  Devices that do not advertise a CXL Device DVSEC fall back to
+	  plain vfio-pci behaviour.  Confirmed-CXL devices whose host
+	  firmware did not commit an HDM decoder, or whose cxl-core probe
+	  otherwise fails, do not bind to vfio-pci at all so the guest is
+	  never offered a half-initialised CXL device.
+
+	  Scope: firmware-committed, single-decoder, no-interleave.
+
+	  Say Y to support CXL Type-2 device passthrough.
diff --git a/drivers/vfio/pci/cxl/Makefile b/drivers/vfio/pci/cxl/Makefile
new file mode 100644
index 000000000000..35e952fe1858
--- /dev/null
+++ b/drivers/vfio/pci/cxl/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vfio-pci-core-$(CONFIG_VFIO_PCI_CXL) += cxl/vfio_cxl_core.o
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
new file mode 100644
index 000000000000..42cd00bbe869
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved.
+ *
+ * vfio-pci CXL Type-2 device passthrough — core entry points.
+ *
+ * Four lifecycle hooks are inserted into vfio-pci-core: acquire and
+ * release run at PCI bind / unbind, open and close run on VFIO fd
+ * open / close.  This mirrors the existing vfio_pci_zdev_* integration
+ * model.
+ *
+ * vfio_pci_cxl_acquire() runs at PCI bind time.  It performs the CXL
+ * register-locator probe and HDM decoder discovery under a brief
+ * pci_enable_device_mem() / pci_disable_device() bracket, then asks
+ * cxl-core to register a cxl_memdev and auto-attach the
+ * firmware-committed region via devm_cxl_probe_mem().  pci_disable_device()
+ * clears PCI_COMMAND_MASTER but NOT PCI_COMMAND_MEMORY (see
+ * do_pci_disable_device() in drivers/pci/pci.c), so the cxl-core
+ * MMIO accesses performed by devm_cxl_probe_mem() after the disable
+ * still succeed even with vfio-pci's PCI enable refcount returned to
+ * zero.  The refcount is re-taken cleanly by vfio_pci_core_enable()
+ * at first VFIO fd open.
+ *
+ * Acquisition is fail-closed for confirmed-CXL devices.  Devices that
+ * do not advertise a CXL Device DVSEC, and CXL devices whose
+ * MEM_CAPABLE bit is clear, return -ENODEV so the caller falls back
+ * to plain vfio-pci behaviour.  Any other negative errno from
+ * acquire() is a confirmed-CXL probe failure (locator missing, HDM
+ * not single-decoder, range-active timeout, passthrough shadow
+ * snapshot failure, devm_cxl_probe_mem() refusal, HDM HPA range busy)
+ * and aborts the vfio-pci bind so the guest never sees a CXL device
+ * with half-initialised cxl-core state.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+#include <linux/range.h>
+#include <linux/vfio_pci_core.h>
+
+#include <uapi/cxl/cxl_regs.h>
+#include <uapi/linux/pci_regs.h>
+#include <uapi/linux/vfio.h>
+
+#include <cxl/cxl.h>
+#include <cxl/passthrough.h>
+#include <cxl/pci.h>
+
+#include "../vfio_pci_priv.h"
+#include "vfio_cxl_priv.h"
+
+MODULE_IMPORT_NS("CXL");
+
+#define VFIO_PCI_CXL_HDM_RES_NAME	"vfio-cxl-hdm"
+
+/* ------------------------------------------------------------------ */
+/* Bind-time setup helpers                                             */
+/* ------------------------------------------------------------------ */
+
+static struct vfio_pci_cxl_state *
+vfio_cxl_create_device_state(struct pci_dev *pdev, u16 dvsec)
+{
+	struct vfio_pci_cxl_state *cxl;
+	u32 hdr1;
+	u16 cap;
+	int rc;
+
+	cxl = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
+					pci_get_dsn(pdev), dvsec,
+					struct vfio_pci_cxl_state,
+					cxlds, false);
+	if (!cxl)
+		return ERR_PTR(-ENOMEM);
+
+	cxl->pdev = pdev;
+
+	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr1);
+	if (rc) {
+		devm_kfree(&pdev->dev, cxl);
+		return ERR_PTR(-EIO);
+	}
+	cxl->info.dvsec_offset = dvsec;
+	cxl->info.dvsec_size   = PCI_DVSEC_HEADER1_LEN(hdr1);
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc) {
+		devm_kfree(&pdev->dev, cxl);
+		return ERR_PTR(-EIO);
+	}
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
+		devm_kfree(&pdev->dev, cxl);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxl;
+}
+
+static int vfio_cxl_probe_regs(struct vfio_pci_cxl_state *cxl)
+{
+	struct cxl_dev_state *cxlds = &cxl->cxlds;
+	resource_size_t hdm_off, hdm_size, bar_off;
+	u8 hdm_count, bir;
+	int rc;
+
+	if (WARN_ON_ONCE(!pci_is_enabled(cxl->pdev)))
+		return -EINVAL;
+
+	rc = cxl_pci_setup_regs(cxl->pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map);
+	if (rc)
+		return rc;
+
+	rc = cxl_get_hdm_info(cxlds, &hdm_count, &hdm_off, &hdm_size);
+	if (rc)
+		return rc;
+	if (hdm_count != 1) {
+		pci_err(cxl->pdev,
+			"vfio-cxl: hdm_count=%u, only 1 supported\n",
+			hdm_count);
+		return -EOPNOTSUPP;
+	}
+
+	rc = cxl_regblock_get_bar_info(&cxlds->reg_map, &bir, &bar_off);
+	if (rc)
+		return rc;
+
+	cxl->info.hdm_count               = hdm_count;
+	cxl->info.hdm_reg_offset          = hdm_off;
+	cxl->info.hdm_reg_size            = hdm_size;
+	cxl->info.comp_reg_bir            = bir;
+	cxl->info.comp_reg_offset         = bar_off;
+	cxl->info.comp_reg_size           = cxlds->reg_map.max_size;
+	cxl->info.host_firmware_committed = true;
+
+	/*
+	 * Range-active polls a config-space bit in the CXL DVSEC, not
+	 * MMIO, so it is safe inside or outside the memory-decode
+	 * bracket.  Keep it here so cxlds->media_ready is set before the
+	 * caller drops the PCI enable refcount.
+	 */
+	rc = cxl_await_range_active(cxlds);
+	if (rc)
+		return rc;
+	cxlds->media_ready = true;
+	return 0;
+}
+
+static int vfio_cxl_create_memdev(struct vfio_pci_cxl_state *cxl)
+{
+	struct range hpa_range;
+	struct cxl_memdev *cxlmd;
+
+	/*
+	 * devm_cxl_probe_mem() runs synchronously: it registers a
+	 * cxl_memdev which triggers cxl_mem_probe(), endpoint port
+	 * creation, and autoregion attach.  Endpoint port probe reads
+	 * HDM decoder MMIO via devm_cxl_setup_hdm(); the device must
+	 * therefore still be memory-decoded.  pci_disable_device() only
+	 * clears PCI_COMMAND_MASTER (not _MEMORY), so the paired enable
+	 * / disable done by the caller leaves the decode bit asserted
+	 * and these reads succeed even with the vfio refcount at zero.
+	 */
+	cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &hpa_range);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+
+	cxl->cxlmd          = cxlmd;
+	cxl->info.hpa_base  = hpa_range.start;
+	cxl->info.hpa_size  = range_len(&hpa_range);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* HDM HPA mapping                                                     */
+/* ------------------------------------------------------------------ */
+
+static int vfio_cxl_map_hdm(struct vfio_pci_cxl_state *cxl)
+{
+	phys_addr_t base = cxl->info.hpa_base;
+	u64 size = cxl->info.hpa_size;
+
+	if (!size)
+		return -EINVAL;
+
+	cxl->hdm_res = request_mem_region(base, size,
+					  VFIO_PCI_CXL_HDM_RES_NAME);
+	if (!cxl->hdm_res) {
+		pci_err(cxl->pdev,
+			"vfio-cxl: HDM HPA %pa-%llx busy; check firmware mappings\n",
+			&base, size);
+		return -EBUSY;
+	}
+
+	cxl->hdm_kva = memremap(base, size, MEMREMAP_WB);
+	if (!cxl->hdm_kva) {
+		release_mem_region(base, size);
+		cxl->hdm_res = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void vfio_cxl_unmap_hdm(struct vfio_pci_cxl_state *cxl)
+{
+	if (cxl->hdm_kva) {
+		memunmap(cxl->hdm_kva);
+		cxl->hdm_kva = NULL;
+	}
+	if (cxl->hdm_res) {
+		release_mem_region(cxl->info.hpa_base, cxl->info.hpa_size);
+		cxl->hdm_res = NULL;
+	}
+}
+
+/* ------------------------------------------------------------------ */
+/* Lifecycle hooks                                                     */
+/* ------------------------------------------------------------------ */
+
+int vfio_pci_cxl_acquire(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_pci_cxl_state *cxl;
+	u16 dvsec;
+	int rc;
+
+	if (!pcie_is_cxl(pdev))
+		return -ENODEV;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENODEV;
+
+	cxl = vfio_cxl_create_device_state(pdev, dvsec);
+	if (IS_ERR(cxl)) {
+		rc = PTR_ERR(cxl);
+		if (rc == -ENODEV)
+			return -ENODEV;	/* MEM_CAPABLE clear: treat as non-CXL. */
+		pci_warn(pdev, "vfio-cxl: state alloc failed (%d)\n", rc);
+		return rc;
+	}
+
+	rc = pci_enable_device_mem(pdev);
+	if (rc) {
+		pci_warn(pdev, "vfio-cxl: pci_enable_device_mem failed (%d)\n",
+			 rc);
+		goto err_free;
+	}
+
+	rc = vfio_cxl_probe_regs(cxl);
+	if (rc) {
+		pci_disable_device(pdev);
+		pci_warn(pdev, "vfio-cxl: register probe failed (%d)\n", rc);
+		goto err_free;
+	}
+
+	/*
+	 * Allocate the cxl-core passthrough handle (DVSEC/HDM/CM
+	 * shadows) BEFORE devm_cxl_probe_mem() so that a -ENOMEM or
+	 * snapshot -EIO here is recoverable: devm_kfree() the
+	 * containing state and let devres unwind cxlds.  After
+	 * devm_cxl_probe_mem() publishes the memdev, no devm_kfree() is
+	 * possible because cxlmd->cxlds points into the state.
+	 */
+	cxl->cxlpt = devm_cxl_passthrough_create(&pdev->dev, &cxl->cxlds);
+	if (IS_ERR(cxl->cxlpt)) {
+		rc = PTR_ERR(cxl->cxlpt);
+		cxl->cxlpt = NULL;
+		pci_disable_device(pdev);
+		pci_warn(pdev,
+			 "vfio-cxl: passthrough shadow snapshot failed (%d)\n",
+			 rc);
+		goto err_free;
+	}
+
+	/*
+	 * Drop the PCI enable refcount before publishing the cxl_memdev:
+	 * vfio_pci_core_enable() will take a fresh refcount at first VFIO
+	 * fd open.  PCI_COMMAND_MEMORY stays asserted (see file header).
+	 */
+	pci_disable_device(pdev);
+
+	/*
+	 * Populate the DPA partition tree on cxlds before
+	 * devm_cxl_probe_mem() runs.  The endpoint port probe will try to
+	 * reserve the firmware-committed HDM decoder range as a DPA
+	 * resource child of cxlds->dpa_res; without an explicit
+	 * cxl_set_capacity() call dpa_res is zero-sized and the
+	 * reservation fails with -EBUSY (see __cxl_dpa_reserve() in
+	 * drivers/cxl/core/hdm.c).  Read the decoder's SIZE from the
+	 * snapshot we just took and size dpa_res to cover it.
+	 */
+	{
+		u32 size_lo = 0, size_hi = 0;
+		u64 dpa_size;
+
+		cxl_passthrough_hdm_rw(cxl->cxlpt,
+				       CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0),
+				       &size_lo, false);
+		cxl_passthrough_hdm_rw(cxl->cxlpt,
+				       CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0),
+				       &size_hi, false);
+		dpa_size = ((u64)size_hi << 32) | size_lo;
+
+		rc = cxl_set_capacity(&cxl->cxlds, dpa_size);
+		if (rc) {
+			pci_warn(pdev,
+				 "vfio-cxl: cxl_set_capacity(0x%llx) failed (%d)\n",
+				 dpa_size, rc);
+			goto err_free;
+		}
+	}
+
+	rc = vfio_cxl_create_memdev(cxl);
+	if (rc) {
+		pci_warn(pdev,
+			 "vfio-cxl: memdev/region creation failed (%d)\n", rc);
+		goto err_free;
+	}
+
+	/*
+	 * Once devm_cxl_probe_mem() has published a cxl_memdev that
+	 * holds a pointer into cxl->cxlds, the state must NOT be
+	 * devm_kfree'd.  A failure from vfio_cxl_map_hdm() is reported
+	 * to userspace; the state stays allocated for the lifetime of
+	 * the PCI device, and devres unwinds it when the pdev is
+	 * removed.
+	 */
+	rc = vfio_cxl_map_hdm(cxl);
+	if (rc) {
+		pci_warn(pdev, "vfio-cxl: HDM HPA mapping failed (%d)\n", rc);
+		return rc;
+	}
+
+	vdev->cxl = cxl;
+	pci_info(pdev,
+		 "vfio-cxl: acquired (hpa=%pa/0x%llx hdm@0x%llx/0x%llx BAR%u@0x%llx/0x%llx)\n",
+		 &cxl->info.hpa_base, cxl->info.hpa_size,
+		 cxl->info.hdm_reg_offset, cxl->info.hdm_reg_size,
+		 cxl->info.comp_reg_bir,
+		 cxl->info.comp_reg_offset, cxl->info.comp_reg_size);
+	return 0;
+
+err_free:
+	devm_kfree(&pdev->dev, cxl);
+	return rc;
+}
+
+void vfio_pci_cxl_release(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_cxl_state *cxl = vdev->cxl;
+
+	if (cxl)
+		vfio_cxl_unmap_hdm(cxl);
+	vdev->cxl = NULL;
+}
+
+int vfio_pci_cxl_open(struct vfio_pci_core_device *vdev)
+{
+	/*
+	 * Region registration (HDM, COMP_REGS) is added by the next
+	 * patch in this series.  This hook exists so vfio-pci-core's
+	 * fd-open path has a stable call site.
+	 */
+	return 0;
+}
+
+void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev)
+{
+}
diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
new file mode 100644
index 000000000000..4ce8f88f8d3d
--- /dev/null
+++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
+#ifndef __VFIO_PCI_CXL_PRIV_H__
+#define __VFIO_PCI_CXL_PRIV_H__
+
+#include <linux/pci.h>
+#include <linux/vfio_pci_core.h>
+
+#include <cxl/cxl.h>
+#include <cxl/passthrough.h>
+
+/**
+ * struct vfio_pci_cxl_state - per-device CXL Type-2 passthrough state
+ *
+ * Anchored to a vfio-pci-core device via @vdev->cxl.  Allocated by
+ * devm_cxl_dev_state_create() so its lifetime is bound to the PCI
+ * device; the cxl_memdev acquired via devm_cxl_probe_mem() and the
+ * cxl_passthrough handle returned by devm_cxl_passthrough_create()
+ * are similarly devres-anchored.
+ *
+ * @cxlds:	CXL device state.  MUST be the first member (enforced by
+ *		devm_cxl_dev_state_create()'s static_assert).
+ * @pdev:	backpointer to the PCI device.
+ * @cxlmd:	cxl_memdev acquired at PCI bind via devm_cxl_probe_mem().
+ * @cxlpt:	register-virtualization handle owned by cxl-core; vfio
+ *		forwards DVSEC config-space, COMP_REGS region, and HDM
+ *		block accesses through this opaque pointer.  See
+ *		Documentation/driver-api/vfio-pci-cxl.rst.
+ * @info:	snapshot of cxl-side metadata describing the device's CXL
+ *		layout.  Filled in during vfio_pci_cxl_acquire() and used
+ *		by the VMM-facing helpers (CAP_CXL builder, region info,
+ *		COMP_REGS dispatch boundary).
+ * @hdm_region_idx, @comp_reg_region_idx: VFIO region indices.
+ *		Assigned by vfio_pci_cxl_open() when the regions are
+ *		registered; zero on a device whose fd has never been
+ *		opened.
+ * @hdm_res:	request_mem_region cookie for the HPA range.
+ * @hdm_kva:	memremap(MEMREMAP_WB) mapping of the HPA range.  Used
+ *		for the HDM region's pread/pwrite path.  The mmap fault
+ *		handler does vmf_insert_pfn from the physical HPA so the
+ *		guest gets the same backing memory the host sees.
+ */
+struct vfio_pci_cxl_state {
+	/* MUST be first member - see devm_cxl_dev_state_create() macro. */
+	struct cxl_dev_state		cxlds;
+
+	struct pci_dev		       *pdev;
+	struct cxl_memdev	       *cxlmd;
+	struct cxl_passthrough	       *cxlpt;
+
+	struct {
+		u16		dvsec_offset;
+		u16		dvsec_size;
+		phys_addr_t	hpa_base;
+		u64		hpa_size;
+		u8		comp_reg_bir;
+		u64		comp_reg_offset;
+		u64		comp_reg_size;
+		u8		hdm_count;
+		u64		hdm_reg_offset;
+		u64		hdm_reg_size;
+		bool		host_firmware_committed;
+	} info;
+
+	u32				hdm_region_idx;
+	u32				comp_reg_region_idx;
+	struct resource		       *hdm_res;
+	void			       *hdm_kva;
+};
+
+#endif /* __VFIO_PCI_CXL_PRIV_H__ */
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 050e7542952e..05ab4ae59157 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -602,10 +602,25 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	/*
+	 * Register CXL VFIO regions before mapping BARs.  CXL region
+	 * registration only list-appends to vdev->region[]; it has no
+	 * dependency on vdev->barmap[] being populated.  Running it
+	 * first means a failure here unwinds through out_free_config
+	 * without leaking BAR ioremaps or selected-region requests
+	 * (those are released by vfio_pci_core_disable(), which is not
+	 * called for a failed open).
+	 */
+	ret = vfio_pci_cxl_open(vdev);
+	if (ret)
+		goto out_free_config;
+
 	vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
+out_free_config:
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -699,6 +714,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vdev->needs_reset = true;
 
+	vfio_pci_cxl_close(vdev);
 	vfio_pci_zdev_close_device(vdev);
 
 	/*
@@ -2222,6 +2238,10 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_vf;
 
+	ret = vfio_pci_cxl_acquire(vdev);
+	if (ret && ret != -ENODEV)
+		goto out_vga;
+
 	vfio_pci_probe_power_state(vdev);
 
 	/*
@@ -2250,6 +2270,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
+	vfio_pci_cxl_release(vdev);
+out_vga:
+	vfio_pci_vga_uninit(vdev);
 out_vf:
 	vfio_pci_vf_uninit(vdev);
 	return ret;
@@ -2264,6 +2287,7 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
+	vfio_pci_cxl_release(vdev);
 
 	if (!disable_idle_d3)
 		pm_runtime_get_noresume(&vdev->pdev->dev);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..94bf7c6a8548 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -109,6 +109,27 @@ static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {}
 #endif
 
+#ifdef CONFIG_VFIO_PCI_CXL
+int  vfio_pci_cxl_acquire(struct vfio_pci_core_device *vdev);
+void vfio_pci_cxl_release(struct vfio_pci_core_device *vdev);
+int  vfio_pci_cxl_open(struct vfio_pci_core_device *vdev);
+void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev);
+#else
+static inline int vfio_pci_cxl_acquire(struct vfio_pci_core_device *vdev)
+{
+	return -ENODEV;
+}
+
+static inline void vfio_pci_cxl_release(struct vfio_pci_core_device *vdev) { }
+
+static inline int vfio_pci_cxl_open(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+
+static inline void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev) { }
+#endif
+
 static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 {
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 89165b769e5c..541c1911e090 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -142,6 +142,13 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	/*
+	 * Opaque pointer to struct vfio_pci_cxl_state (defined in
+	 * drivers/vfio/pci/cxl/vfio_cxl_priv.h).  Set by
+	 * vfio_pci_cxl_acquire() at PCI bind; NULL on non-CXL devices
+	 * and when CONFIG_VFIO_PCI_CXL=n.
+	 */
+	void			*cxl;
 };
 
 enum vfio_pci_io_width {
-- 
2.25.1

