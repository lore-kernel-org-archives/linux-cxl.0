Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44183EB111;
	Thu, 25 Jun 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406584; cv=fail; b=kzIFobFByEZ9uRnzpQG5E4sSiFW0zT5d4VaRcukuSkFnkGqaabJIigonpCB8gdxNzyOW7Ku58YtQ/aAMbJkGhzFRhYfYHrTaVtYtjHq4baHN+mKMLwjZMwAcFnL3ZPKN3YQRQBa76jkMNkCDSWX0zZ2xx6s8NNBIvMRxkOkMuog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406584; c=relaxed/simple;
	bh=Q5oFOIPHivONMDLlMD2tkrgjEdufix14QxT60AOajVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xlxqa5dHXRgu92JhpP31KMVEOdxBQ7yP3zJLwis8wMXXh12jDZYn3nKp1As2wd0gFmPH9YBFlJJaKDHqaIlzG7r/0+wDN8NlibOMBhGnak7xKKnMTcL+WiOPwsUF4uj2qML4enT2TM2WH0A4ZePZ7RyMNeDuNFfI6duLspt3a2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nnji48OX; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nnji48OX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXXL7M7t+hjsg3HavOKXAhJiK9KRVPhrlrU6W6jGu+sxic1BWLx5brJXczgRQJuY+E5iPeSVdlNkGdBhrjIPkXm+TYapG+5OhEF3O/in/LDW/4WlsdSJVkiiXfS+5I8x9bKr8stLhtUuGiBgWkACiMRW1diN6N53n10cSF85X63i7nLbwWxmH1G/0wRafyrKJHgSVYM2/wW8PJrLfH61NQ87wDa9AnWbuOmEadaeSkJQkXztYF85nT4eBuonHzl6UerzE1kCu2TtmwAJ5D7bywt5tuFjPWxqVXUWcpaLBss5ahkNtWzp06okUoKzvs+bYWD2nHM6RpfhmyDqop4soQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5aMB0BtsqfyoHJuC4gmPWyFS65tqFS5odPe7ofqu2U=;
 b=k+rd8ayAU6R654SaVaEbpfPUbGKp57XY+9c3TDc1BWIjfvD2HZl4VElbazXeK2CzPOeWZGDFkiBP+G2zazKC+1xCe26d6bNuV940LIkRrSIpDTMOyFH5RM4lWJ3eHBLQOgABp0S5B61PoeIuuYIeho24og0N8vHKQlWnSWosx5FVCNUaHUKaVplwYyxNd1IMNZP8Kv+7DnZUJ0CG9WVARXx6QTsfGt54W04MrMk5DtEauzPZx8ft2NY4qQt7/OZreicQWYLW0lDCyPlCnWu8YolaEuBqzsk7zP4cSSI4E/4tgwoBsyUY0AW3xYL6EW3uPTTVwYBCpKFOFFvtSrnNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5aMB0BtsqfyoHJuC4gmPWyFS65tqFS5odPe7ofqu2U=;
 b=Nnji48OXlNWJNluorBFuP7hbwo8GOe+uekSHwYsaw0WgOvri5ao8GzPEOh4jsFR7FDRY1DtXLkNgcr/ZJLb8iiVkBDsEaq1ceVeC4WSCucsFfLEoshTIKuaUAeDjxFWNeZRmmojUw8Sm3aimNaxUrjeDooSeZXBvqGwyppGxTCD9ptZ8gNxMzFkHcKkmyrTkc/118204TYIY5Sc6/2oBGMNVVac4qUKNdv61aEFOh2QkMM3gMJSbMsoFw6m5del1kbN413H664o4w+8Ok5XF6kiFmQltdTtO4qWr7hu3aFG1cxAmOSkMXRBrvRnznhwtOrQcqTUCjkYE8Zcx3XOvFQ==
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 16:56:11 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::38) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 16:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:55:54 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Jun 2026 09:55:47 -0700
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
Subject: [PATCH v3 09/11] selftests/vfio: Add CXL Type-2 device passthrough smoke test
Date: Thu, 25 Jun 2026 22:24:05 +0530
Message-ID: <20260625165407.1769572-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b833231-bb7b-48ba-d0e0-08ded2daa8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|23010399003|82310400026|376014|22082099003|18002099003|6133799003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	R58yYMbwk4s8AZ9hrYReNaSzySn9RfcXEqhAaMWzgxjGzJrevCjkOzddLvw40I2slGLoOnfeYbgbN3g2PM2DLfVYc0ULU1hRD+wuu/f34QNxo+JnCrtpJuw4/vE6dprVk1NivxPrh1Vfb8Rg3NOT4uzTTSORhxQB/b5S9+I1lwVh5lyfdxHMCfghD3OkF/hPJUGzbl7TR6a45L8T2Uyf/TkaA5tihxUay+1EtBUC2IBnOW+S3VXp0Opu/bLkjtCuafOu1jVf98dfUyYpMo/exbxiPe4G+w8+/YW1H2FUvfLg4Ndj01KMeUfrLnLaI8bZ3VgvL+nuTTjrrEsO1lsrUmGl3tstsAeikkNGroST3+eRRXFKrIsNpeeGtoZyNEj4TdTzbHEYwxqUqHfLxrogmxOVMGsF20qz95g8LuRXhKz5NKgfU+8p2pNVmO5mb0zsJaNyIr0XKT5md7Xf6aQn9LAlH/GUuYOeCv3ag2TEXlZhzkWjbkwA/Is1oPFmThTIS4IBJsop4A9JCUoKs2S9gnwf3gdtSP6NGh7xDp4QNILgUDnAlZYoO1JrB+ik9HwUagt3Og9TZ00P1WH6KuK0TvIwWgMrv0i1hekwVZsFsO1ulYAEKAj+fduA1bBmZtkr7bt1zAJfHQYhJJ7NZ8qg0xDxBUmnQu4iOsFZ1L3BrLmygAGxyipYTZQXRv61E/jn2V3zUkWjBFfK+xenKC0/aEXTihJIZZlpLv19zHHABlSbXq45QfEn/pqwvjF/a78+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zooM3LVZwoSrzlUWPVTefwd4joyOHLSeBcfb8QjROTvAbplvMGq7ci6+m8tF0mF0JV5q35D4Ax7nm40UBo5wseS+HRLGcC9Jv8aQAW5ng9YDiq2NeELX1WqKS48dlEaEeNwDJgVZ4WBQ1+Jqg3zVaTQnX8biwE4yyYm70bz3I3weLNKC3c/lYJ66VblQbmeKswhN5FiNyzlA/laxbXRhycU0d0bF6dVdQaJorLdJCU0QWmIEzsRwH25yICqTq/TfjSbjDHl9maBfCyEeKXE09whWNP3XOdoXt24R0H7bSCjVV5Po8uPGOMv1Zpqamh+qE0XbYGkImNvdS29al88vO2eBJyyUxssiKaSRJaX5+F0EIh+osREfx+dzPT+6qqcze/6K9/zTec9xAt6aXCgMGVQQL0WShib8Il/arNj7fQpZPNXC1xdFYEnXC5oMAKvA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:56:11.0395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b833231-bb7b-48ba-d0e0-08ded2daa8db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029

From: Manish Honap <mhonap@nvidia.com>

Exercise the user-visible contract added by CONFIG_VFIO_PCI_CXL:

  device_is_cxl                 GET_INFO returns VFIO_DEVICE_FLAGS_CXL
                                and a populated VFIO_DEVICE_INFO_CAP_CXL.

  hdm_region_mmap_rw            mmap() one page of the HDM region,
                                write a pattern, read it back.  Proves
                                the mmap fault handler's vmf_insert_pfn
                                path and the firmware-committed HPA
                                mapping.

  component_bar_sparse_mmap     GET_REGION_INFO on the component BAR
                                advertises a SPARSE_MMAP cap, and every
                                advertised mmappable area lies outside
                                [comp_reg_offset, +comp_reg_size).

  comp_regs_cm_cap_array_read   pread() of the COMP_REGS region at
                                CXL_CM_OFFSET returns a valid CM
                                cap-array header (CAP_ID == 1,
                                ARRAY_SIZE > 0).  Proves the
                                cxl_passthrough_cm_rw() dispatch is
                                wired.

  dvsec_lock_byte_read          pread() of the DVSEC CONFIG_LOCK byte
                                through the config-rw clipping shim
                                succeeds.  Proves the
                                cxl_passthrough_dvsec_rw() path is
                                wired.

COMMIT/COMMITTED state-machine and DVSEC LOCK latch behaviour are
out of scope for this smoke test.  No debugfs dependency.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  11 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 350 ++++++++++++++++++
 3 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..25f2a9420ef6 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_cxl_type2_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fc75e04ef010..d2150129d854 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -281,7 +281,16 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device)
 		struct vfio_pci_bar *bar = device->bars + i;
 
 		vfio_pci_region_get(device, i, &bar->info);
-		if (bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP)
+		/*
+		 * Skip auto-mmap when the BAR advertises region-info caps
+		 * (e.g. VFIO_REGION_INFO_CAP_SPARSE_MMAP).  Such BARs are
+		 * only partially mmappable; the kernel rejects full-BAR
+		 * mmaps and the caller must walk the sparse-area cap and
+		 * mmap each advertised area separately.  Tests that need
+		 * access to such a BAR handle the per-area mmap themselves.
+		 */
+		if ((bar->info.flags & VFIO_REGION_INFO_FLAG_MMAP) &&
+		    !(bar->info.flags & VFIO_REGION_INFO_FLAG_CAPS))
 			vfio_pci_bar_map(device, i);
 	}
 
diff --git a/tools/testing/selftests/vfio/vfio_cxl_type2_test.c b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
new file mode 100644
index 000000000000..bc98a29f90ad
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vfio_cxl_type2_test - smoke + dispatch tests for CXL Type-2 device
+ * passthrough through vfio-pci.
+ *
+ * Exercises the user-visible surface gated by CONFIG_VFIO_PCI_CXL:
+ *  - GET_INFO returns VFIO_DEVICE_FLAGS_CXL + a populated CAP_CXL.
+ *  - The HDM-backed VFIO region can be mmap'd and read/written.
+ *  - The component BAR exposes a SPARSE_MMAP cap that excludes the
+ *    CXL component register sub-range.
+ *  - The COMP_REGS region serves CM cap-array dwords from cxl-core's
+ *    snapshot (proves the cxl_passthrough_cm_rw() path is wired).
+ *  - DVSEC body reads through the config-rw clipping shim return the
+ *    cxl-core shadow (proves cxl_passthrough_dvsec_rw() is wired).
+ *
+ * Usage:
+ *   ./vfio_cxl_type2_test <BDF>
+ * or export VFIO_SELFTESTS_BDF=<BDF> before running.  The device must
+ * be bound to vfio-pci and the kernel must have CONFIG_VFIO_PCI_CXL=y.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.
+ */
+
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <cxl/cxl_regs.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1e98
+#define PCI_DVSEC_ID_CXL_DEVICE		0x0000
+
+/*
+ * vfio-pci's region offset packing (kernel-internal in
+ * include/linux/vfio_pci_core.h, not exposed via UAPI as of writing).
+ * Provide local definitions so the selftest builds against the bare
+ * UAPI vfio.h.  The guards let a future kernel hoist these to UAPI
+ * without breaking this test.
+ */
+#ifndef VFIO_PCI_OFFSET_SHIFT
+#define VFIO_PCI_OFFSET_SHIFT		40
+#endif
+#ifndef VFIO_PCI_INDEX_TO_OFFSET
+#define VFIO_PCI_INDEX_TO_OFFSET(index)	((uint64_t)(index) << VFIO_PCI_OFFSET_SHIFT)
+#endif
+
+static const char *device_bdf;
+
+/* Find a struct vfio_device_info capability by id in a GET_INFO buffer. */
+static const struct vfio_info_cap_header *
+find_device_cap(const void *buf, size_t bufsz, uint16_t id)
+{
+	const struct vfio_device_info *info = buf;
+	const struct vfio_info_cap_header *cap;
+	size_t off = info->cap_offset;
+
+	while (off && off < bufsz) {
+		cap = (const void *)((const char *)buf + off);
+		if (cap->id == id)
+			return cap;
+		off = cap->next;
+	}
+	return NULL;
+}
+
+/* Walk PCI extended capability list for the CXL Device DVSEC. */
+static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev)
+{
+	uint16_t pos = PCI_CFG_SPACE_SIZE;
+	int iter = 0;
+
+	while (pos && iter++ < 64) {
+		uint32_t hdr = vfio_pci_config_readl(dev, pos);
+		uint16_t cap_id = hdr & 0xffff;
+		uint16_t next   = (hdr >> 20) & 0xffc;
+		uint32_t hdr1, hdr2;
+
+		if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
+			hdr1 = vfio_pci_config_readl(dev, pos + 4);
+			hdr2 = vfio_pci_config_readl(dev, pos + 8);
+			if ((hdr1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
+			    (hdr2 & 0xffff) == PCI_DVSEC_ID_CXL_DEVICE)
+				return pos;
+		}
+		pos = next;
+	}
+	return 0;
+}
+
+FIXTURE(cxl_type2) {
+	struct iommu *iommu;
+	struct vfio_pci_device *dev;
+
+	struct vfio_device_info_cap_cxl cxl_cap;
+	uint16_t dvsec_base;
+
+	uint64_t hdm_region_size;
+	uint64_t comp_regs_size;
+};
+
+FIXTURE_SETUP(cxl_type2)
+{
+	uint8_t infobuf[512] = {};
+	struct vfio_device_info *info = (void *)infobuf;
+	const struct vfio_device_info_cap_cxl *cap;
+	struct vfio_region_info ri = { .argsz = sizeof(ri) };
+
+	self->iommu = iommu_init(default_iommu_mode);
+	self->dev   = vfio_pci_device_init(device_bdf, self->iommu);
+
+	info->argsz = sizeof(infobuf);
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
+
+	if (!(info->flags & VFIO_DEVICE_FLAGS_CXL))
+		SKIP(return, "not a CXL Type-2 device");
+
+	cap = (const void *)find_device_cap(infobuf, sizeof(infobuf),
+					    VFIO_DEVICE_INFO_CAP_CXL);
+	ASSERT_NE(NULL, cap);
+	memcpy(&self->cxl_cap, cap, sizeof(*cap));
+
+	ri.index = self->cxl_cap.hdm_region_idx;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &ri));
+	self->hdm_region_size = ri.size;
+
+	ri.argsz = sizeof(ri);
+	ri.index = self->cxl_cap.comp_reg_region_idx;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &ri));
+	self->comp_regs_size = ri.size;
+
+	self->dvsec_base = find_cxl_dvsec(self->dev);
+}
+
+FIXTURE_TEARDOWN(cxl_type2)
+{
+	vfio_pci_device_cleanup(self->dev);
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(cxl_type2, device_is_cxl)
+{
+	const struct vfio_device_info_cap_cxl *c = &self->cxl_cap;
+
+	ASSERT_EQ(VFIO_DEVICE_INFO_CAP_CXL, c->header.id);
+	ASSERT_EQ(1, c->header.version);
+	ASSERT_NE(c->hdm_region_idx, c->comp_reg_region_idx);
+	ASSERT_GE(c->hdm_region_idx,    VFIO_PCI_NUM_REGIONS);
+	ASSERT_GE(c->comp_reg_region_idx, VFIO_PCI_NUM_REGIONS);
+	ASSERT_LT(c->comp_reg_bar, PCI_STD_NUM_BARS);
+	ASSERT_GT(c->comp_reg_size, 0ULL);
+	ASSERT_EQ(c->comp_reg_size, self->comp_regs_size);
+}
+
+TEST_F(cxl_type2, hdm_region_mmap_rw)
+{
+	uint64_t off = (uint64_t)VFIO_PCI_INDEX_TO_OFFSET(
+		self->cxl_cap.hdm_region_idx);
+	uint32_t pattern = 0xdeadbeefU;
+	uint32_t readback = 0;
+	void *map;
+
+	if (self->hdm_region_size < SZ_4K)
+		SKIP(return, "HDM region < 4K");
+
+	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   self->dev->fd, off);
+	ASSERT_NE(MAP_FAILED, map);
+
+	*(volatile uint32_t *)map = pattern;
+	readback = *(volatile uint32_t *)map;
+	ASSERT_EQ(pattern, readback);
+
+	ASSERT_EQ(0, munmap(map, SZ_4K));
+}
+
+TEST_F(cxl_type2, component_bar_sparse_mmap)
+{
+	const uint8_t bar = self->cxl_cap.comp_reg_bar;
+	uint8_t buf[512] = {};
+	struct vfio_region_info *ri = (void *)buf;
+	const struct vfio_region_info_cap_sparse_mmap *sp;
+	const struct vfio_info_cap_header *hdr;
+	size_t off;
+	uint32_t i;
+
+	ri->argsz = sizeof(buf);
+	ri->index = bar;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
+
+	ASSERT_TRUE(ri->flags & VFIO_REGION_INFO_FLAG_CAPS);
+	off = ri->cap_offset;
+	hdr = NULL;
+	while (off && off < sizeof(buf)) {
+		hdr = (const void *)(buf + off);
+		if (hdr->id == VFIO_REGION_INFO_CAP_SPARSE_MMAP)
+			break;
+		off = hdr->next;
+		hdr = NULL;
+	}
+	ASSERT_NE(NULL, hdr);
+	sp = (const void *)hdr;
+	ASSERT_GE(sp->nr_areas, 1U);
+	for (i = 0; i < sp->nr_areas; i++) {
+		uint64_t a_start = sp->areas[i].offset;
+		uint64_t a_end   = a_start + sp->areas[i].size;
+
+		ASSERT_TRUE(a_end <= self->cxl_cap.comp_reg_offset ||
+			    a_start >= self->cxl_cap.comp_reg_offset +
+				       self->cxl_cap.comp_reg_size);
+	}
+}
+
+TEST_F(cxl_type2, comp_regs_cm_cap_array_read)
+{
+	uint64_t off = (uint64_t)VFIO_PCI_INDEX_TO_OFFSET(
+		self->cxl_cap.comp_reg_region_idx) + CXL_CM_OFFSET;
+	uint32_t hdr = 0;
+	uint16_t cap_id;
+	uint8_t  array_size;
+
+	ASSERT_EQ((ssize_t)sizeof(hdr),
+		  pread(self->dev->fd, &hdr, sizeof(hdr), off));
+
+	cap_id     = hdr & CXL_CM_CAP_HDR_ID_MASK;
+	array_size = (hdr & CXL_CM_CAP_HDR_ARRAY_SIZE_MASK) >> 24;
+	ASSERT_EQ(cap_id, CM_CAP_HDR_CAP_ID);
+	ASSERT_GT(array_size, 0);
+}
+
+TEST_F(cxl_type2, dvsec_lock_byte_read)
+{
+	uint8_t v;
+
+	if (!self->dvsec_base)
+		SKIP(return, "CXL Device DVSEC not found");
+
+	v = vfio_pci_config_readb(self->dev,
+				  self->dvsec_base + 0x14);	/* CONFIG_LOCK */
+	/* Snapshot value is host-firmware-dependent; just assert read
+	 * succeeds (no SIGBUS, no -EIO).
+	 */
+	(void)v;
+}
+
+/*
+ * Exercise the per-decoder COMMIT/COMMITTED state machine in
+ * cxl_passthrough_hdm_rw() (cxl-core).  Steps:
+ *
+ *   - Walk the CM cap-array via COMP_REGS reads to locate the HDM block.
+ *   - Read decoder 0 CTRL; for a firmware-committed Type-2 device both
+ *     COMMIT (bit 9) and COMMITTED (bit 10) are expected to be set.
+ *   - Release COMMIT by writing CTRL with bit 9 cleared.
+ *     Expected FSM transition: COMMITTED -> 0, LOCK_ON_COMMIT (bit 8) -> 0.
+ *   - Re-set COMMIT.  Expected: COMMITTED -> 1 (auto-set by the handler).
+ *   - Restore the original CTRL value so subsequent test runs see the
+ *     firmware-committed state.
+ *
+ * The CTRL writes touch the cxl-core shadow only — they do not reach
+ * the device — so the operation is safe to run repeatedly.
+ */
+TEST_F(cxl_type2, hdm_decoder_commit_fsm)
+{
+	uint64_t comp_off = (uint64_t)VFIO_PCI_INDEX_TO_OFFSET(
+		self->cxl_cap.comp_reg_region_idx);
+	uint32_t cm_hdr = 0, entry = 0;
+	uint64_t hdm_reg_offset = 0;
+	uint64_t ctrl_off;
+	uint32_t ctrl_orig, ctrl_test;
+	uint32_t array_size;
+	uint32_t i;
+
+	/* Discover HDM block offset via CM cap-array walk. */
+	ASSERT_EQ((ssize_t)sizeof(cm_hdr),
+		  pread(self->dev->fd, &cm_hdr, sizeof(cm_hdr),
+			comp_off + CXL_CM_OFFSET));
+	ASSERT_EQ(CM_CAP_HDR_CAP_ID, cm_hdr & CXL_CM_CAP_HDR_ID_MASK);
+	array_size = (cm_hdr & CXL_CM_CAP_HDR_ARRAY_SIZE_MASK) >> 24;
+	ASSERT_GT(array_size, 0);
+
+	for (i = 1; i <= array_size; i++) {
+		ASSERT_EQ((ssize_t)sizeof(entry),
+			  pread(self->dev->fd, &entry, sizeof(entry),
+				comp_off + CXL_CM_OFFSET + i * 4));
+		if ((entry & CXL_CM_CAP_HDR_ID_MASK) == CXL_CM_CAP_CAP_ID_HDM) {
+			hdm_reg_offset = CXL_CM_OFFSET +
+					 ((entry & CXL_CM_CAP_PTR_MASK) >> 20);
+			break;
+		}
+	}
+	ASSERT_NE(0, hdm_reg_offset);
+
+	/* Read decoder 0 CTRL. */
+	ctrl_off = comp_off + hdm_reg_offset +
+		   CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	ASSERT_EQ((ssize_t)sizeof(ctrl_orig),
+		  pread(self->dev->fd, &ctrl_orig, sizeof(ctrl_orig),
+			ctrl_off));
+
+	/* Firmware-committed Type-2 device: COMMIT + COMMITTED both set. */
+	ASSERT_TRUE(ctrl_orig & BIT(9));	/* COMMIT */
+	ASSERT_TRUE(ctrl_orig & BIT(10));	/* COMMITTED */
+
+	/* Release COMMIT; FSM clears COMMITTED and LOCK_ON_COMMIT. */
+	ctrl_test = ctrl_orig & ~BIT(9);
+	ASSERT_EQ((ssize_t)sizeof(ctrl_test),
+		  pwrite(self->dev->fd, &ctrl_test, sizeof(ctrl_test),
+			 ctrl_off));
+	ASSERT_EQ((ssize_t)sizeof(ctrl_test),
+		  pread(self->dev->fd, &ctrl_test, sizeof(ctrl_test),
+			ctrl_off));
+	ASSERT_FALSE(ctrl_test & BIT(9));	/* COMMIT cleared */
+	ASSERT_FALSE(ctrl_test & BIT(10));	/* COMMITTED auto-cleared */
+	ASSERT_FALSE(ctrl_test & BIT(8));	/* LOCK_ON_COMMIT auto-cleared */
+
+	/* Re-set COMMIT; FSM auto-sets COMMITTED. */
+	ctrl_test = BIT(9);
+	ASSERT_EQ((ssize_t)sizeof(ctrl_test),
+		  pwrite(self->dev->fd, &ctrl_test, sizeof(ctrl_test),
+			 ctrl_off));
+	ASSERT_EQ((ssize_t)sizeof(ctrl_test),
+		  pread(self->dev->fd, &ctrl_test, sizeof(ctrl_test),
+			ctrl_off));
+	ASSERT_TRUE(ctrl_test & BIT(9));	/* COMMIT */
+	ASSERT_TRUE(ctrl_test & BIT(10));	/* COMMITTED auto-set */
+
+	/* Restore the original CTRL value. */
+	ASSERT_EQ((ssize_t)sizeof(ctrl_orig),
+		  pwrite(self->dev->fd, &ctrl_orig, sizeof(ctrl_orig),
+			 ctrl_off));
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.25.1

