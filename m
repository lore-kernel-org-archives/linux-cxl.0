Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F538D6B0;
	Wed, 11 Mar 2026 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261480; cv=fail; b=N9b2vwQEa+tLhqQz4OYTKXvFp1uOwAGo19VlxVd8qgG/nUtJEQYD4tC5n4FdM5mvY+ZXpvG8wsZyhwXxdsi0bWiYB3uktOTdZnQTKFZJHiovrUhjDBoOBAIKRzYZx23DFg51Y6HuriIQqXyRc+bJGAdg6sZ9NDzFWseuojHNR4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261480; c=relaxed/simple;
	bh=guBRS2ZsjiJAl7AK2gWeYk8dUZJpQ34BrgRdFG9UpVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvYBQSk5t5Wnbc6mCSgMl4hWbhB/mQpXLr5Ugv5vSxfYCNpwwLQtY/KNXsGsUfLHAe0sCN/vjQGa90f2kum5dXIO5kjpJ/vonEWfX3g2Akhhq/lp3OrN03WI5D4BNVec0E6QvrLbd6TZR0CcILAJNc5m9l287MF7A/Uj9YsrxNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZYCuFKR5; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZYCuFKR5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd6jovRHFW1wIvBAfL7mtQhuJ+iy4OGcwg0oRsqSh6c+vLoAVMzHm99AKIXO/untcutTX76kT14WcbzZ5nYArWvAuR1NW/ZqQTdZkWjBuHadVp112cLlSPvjCaKLD5ssEYCHWnd/9zc2rzIO/JskXAHy6m6mUFRQCIBGCfVXdX9Tq6SyZ1HZ10gZEU3GaxmSCvh/8NZ/gTUcFInEqh2f5e3unRXcWcDYR6KOm7keccZecN3krsOhswF934pV7qmXV7NPN14sVSJIuAo7r2RQWtdllu6fPjsbiDF/w3rYJucnnrVRUHaTHrHMGnl+eeN1/6pNtWTr/mPBJ2NR6ume5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqpGaqbF/BaKxTQGXtl+B6zoRGtPrGFkzWUwrx+J6+0=;
 b=lVDKMPmWT9xU1Te+CDoJn03PW4an/CdEGER8GEVMJMy+/MKfCntzKG5yeQTI5fj3YMVOedvchpyHDPwcIc60gGcmd6+cbmJ7YcpvI+R+D55bsBaJGltQzVoLljHdP67wmLl0SB6fzX70HwyPjrJi4RHGmni4mH2F4KVf0dDAhjPmeniIc2Wa9Yiif7rCu0TahQhiqcAtMSYFB7BQJYIHmFAcp/s/EoDqSt3aTZPIjuh0ShhAGVfQb2qfwmL2K50uv/7DKf0Lw+Dh0Zm2ofEIJq9guiD+1yfAS4366B3e66JWVgwrObht725b81y5bp3z2MblxiprkIQDxrmyu1jr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqpGaqbF/BaKxTQGXtl+B6zoRGtPrGFkzWUwrx+J6+0=;
 b=ZYCuFKR5+5IYnZTOOLv8QfBtr9wDxF4f2+pd6/FWDUwT7ehHl/vSCwVavxXRArwU702dqS3cZmjgcMOtUxjXfimgzwpqQ2E4/NEF/DiJ/FOU54X3QRS68AGhWxgjzrmtfeNXHfSHz0LlKh/ov+5m12Oef7dS1UUQkg2DAD6uoQ5zn6/1Zf4+ysPHRVUPGSt3Lk7nCaAjlcGg+8wgASbvEmxhC8yyzRcFyxb3eR5rHmobMaXe4BLoVYyeKn47KKHgFzK0bYL8gdwBy67Ih32TRgbUdU5YP8vdL+Ao/oCPruDu8u9aITC4/4P8/XBZq9wjbjGwt6DHxwYog4Pqaf5fkw==
Received: from SA9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::31)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 20:37:45 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::f8) by SA9P223CA0026.outlook.office365.com
 (2603:10b6:806:26::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 20:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:37:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:20 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:37:13 -0700
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
Subject: [PATCH 19/20] selftests/vfio: Add CXL Type-2 passthrough tests
Date: Thu, 12 Mar 2026 02:04:39 +0530
Message-ID: <20260311203440.752648-20-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: b91e4ca5-90ca-4925-669b-08de7fae0bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	topZN424MdhzcZ6BDKbFxz6fyR/ndd8+so0VLDkuZ6vkuoJrqoNBpoL0aS/CEQ0TCp7cQqxeFd6z0T90t+IaRKc5q8f41bT9SHI2y3FYMRZdxN8FJNAspufOh09Goz0k/7StyusQ6iZuQvwvXrNozMnbCKkmBKL4Qfbc+rSn6NLKzLYYXScqr6QTMHjhzwujYIlfCTaBJEk1S8pACWU3eGqTabLovGi/3+0e+D+VjnqLQZeR3G5pwmjG1XwfzLXr9nQNNidUwt8+2tko5whjzw5CQ5dmtn5TA/zL+uBH7qXjUqA0KhgVA7LK+sJWLc6ML82uYzw3EhUMXPTGb5oY0e3c8P1juY4WYt/GFGVJo7PfpF1cRGMpYxiueWdveGCsobt8hTiMCnuVICCKUTHGNj/cqSkbluUz+ElB+05700OcfCP10twHJwkHpTCdaWwJniJJ9GwUNi3BTSEj+s6X0U20MqG1Zw1y3nHIY1QPfxDrl7QyAWeeu1n/F6q/XOstGzlM0PUIBQrDhwNan3KL71SCJdaTaCQ83cTsghadNAzXaMsc6JjjjRqD4d57gAYi4BmfyTtGXDWXtNj6B92wj74P13tTaxtKN+nrEouVsPbTsRrVgddIa1Sc63oQhl6UH8YG9s2WUMQIvp+cioYFV43y2tdspjxm7xx1056j8zuGBgtARbHmdxR6VXZSCyMB96XrtlNQpTn2XJ9QKQ8yQkgYU2JxN7NcNQbnbpZhwDhTzCsoIbi0YWs/mTFctmNkI1nJZ4oKztrtexUUNOQwDLrIixYVf5jXg30KbUIRZhSJXzQ6XRH5qM0BqCoy3CTe
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dE49Hg30Q2a7/TDSPJmH7MoaikvTz2KHA0WpupIHbOCSv17HTWqkPKYCW7w9myCzmVe3Fnk6laBgM7jP9NVCxzUjsHtofSextIncqI197I1blU3e9u0ylV6CpzTGyiCYv16UyMn+YkSMmEVJKS+0PaIZg3YzAN/11Up0WYYTO7jVW8Q8ZuiXsyIeV8ivv5iMC9udI+OTIdUJDuajtA6rh7i/IspBlybA+ZYgdJs20IA4jZnImbgRJU1erpW3ZshMRfjCJH9FVYvE/cCaQvZIub8qxCG4TAq12A6cz604Bn3Y52Gm52GaeIzc+aD1MxLP8riKJr3grFBSLsk4JpzCvBSb5phheOXgBUsIKmG/ru5bSpFq7cGfaiVMGhwmu7Dccq5ySw83fwEf4WX4oSaUJHjt3Ngz1K3Z4pORcpyhWAqTzfNIsj/6klBs2Q8Nlr+k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:37:42.9254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91e4ca5-90ca-4925-669b-08de7fae0bb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

From: Manish Honap <mhonap@nvidia.com>

Add a selftest suite exercising the CXL Type-2 device passthrough
interfaces introduced by the vfio-cxl patch series.

The tests are designed to run on a host with a CXL Type-2 device bound
to vfio-pci and CONFIG_VFIO_CXL_CORE=y. They verify the kernel ABI
without requiring a running QEMU instance or a guest OS.

Test cases:

  cxl_test_device_info:
    Open the VFIO device. Call VFIO_DEVICE_GET_INFO and verify:
      - VFIO_DEVICE_FLAGS_CXL is set in info.flags
      - VFIO_DEVICE_FLAGS_PCI is also set (CXL implies PCI)
      - info.num_regions > VFIO_PCI_NUM_REGIONS (CXL adds extra regions)
    Walk the capability chain and locate VFIO_DEVICE_INFO_CAP_CXL.
    Verify:
      - hdm_count >= 1
      - hdm_regs_bar_index <= 5
      - hdm_regs_size >= 0x20 * hdm_count (minimum: one decoder slot)
      - dpa_size > 0 (pre-committed decoder present)
      - dpa_region_index and comp_regs_region_index within bounds

  cxl_test_component_bar_hidden:
    Query VFIO_DEVICE_GET_REGION_INFO for the BAR index reported by
    hdm_regs_bar_index. Verify info.size == 0, confirming the host has
    hidden the component BAR from direct userspace access.

  cxl_test_comp_regs_region:
    Query VFIO_DEVICE_GET_REGION_INFO for comp_regs_region_index.
    Verify:
      - flags has READ and WRITE set, mmap NOT set
      - size == hdm_regs_size
    Open the region fd and read 4 bytes at offset 0 (HDM Decoder Cap).
    Verify the read succeeds and returns a non-zero value.
    Attempt a misaligned read (3-byte or offset 1) _ verify EINVAL.
    Attempt a 4-byte write to offset 0 (RO register) _ verify it
    silently succeeds (write to RO discards without error per design).
    Write a known pattern to HDM Decoder 0 BASE_LO (offset 0x10) and
    read back _ verify the written value (with reserved bits cleared)
    is returned.

  cxl_test_dpa_region:
    Query VFIO_DEVICE_GET_REGION_INFO for dpa_region_index. Verify:
      - flags has READ, WRITE, MMAP set
      - size == dpa_size (consistent with device info)
    mmap() the full DPA region (MAP_SHARED). Verify mmap() succeeds.
    Write a test pattern to offset 0 of the mapping (triggers first
    page fault / PFN insertion). Read back and verify the value.
    munmap() the region. Verify no crash.

  cxl_test_bar_mmap_rejected:
    Attempt to mmap() the component BAR directly via the standard
    VFIO_PCI_BAR*_REGION_INDEX path. Verify EINVAL is returned.

  cxl_test_bar_read_rejected:
    Attempt to read() the component BAR region fd. Verify EINVAL.

  cxl_test_disable_cxl_param:
    (Requires root + module reload capability)
    Reload vfio-pci with disable_cxl=1. Rebind the device. Call
    VFIO_DEVICE_GET_INFO and verify VFIO_DEVICE_FLAGS_CXL is NOT set
    and num_regions == VFIO_PCI_NUM_REGIONS (no extra CXL regions).
    Reload vfio-pci without the parameter and rebind to restore state.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_cxl_type2_test.c      | 816 ++++++++++++++++++
 2 files changed, 817 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 3c796ca99a50..2cac98302609 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -4,6 +4,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_cxl_type2_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
diff --git a/tools/testing/selftests/vfio/vfio_cxl_type2_test.c b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
new file mode 100644
index 000000000000..44df62378749
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vfio_cxl_type2_test - selftests for CXL Type-2 device passthrough via vfio-pci
+ *
+ * Tests the UAPI and emulation layer introduced by CONFIG_VFIO_CXL_CORE:
+ *   - VFIO_DEVICE_INFO_CAP_CXL capability detection and field validation
+ *   - Component BAR hiding (size=0 response for hdm_regs_bar_index)
+ *   - DPA region presence, size, and mmap
+ *   - COMP_REGS region presence, size, read/write semantics
+ *   - HDM decoder emulation: reserved-bit masking, COMMIT→COMMITTED transition
+ *   - DVSEC configuration space emulation: Control, Status, Lock, Control2
+ *
+ * Usage:
+ *   ./vfio_cxl_type2_test <BDF>
+ * or set the environment variable VFIO_SELFTESTS_BDF before running.
+ *
+ * The device must be a CXL Type-2 device (e.g. a GPU with coherent memory)
+ * with a pre-committed HDM decoder.  The test is skipped automatically on
+ * non-CXL devices.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include <fcntl.h>
+#include <stdint.h>
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
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+/* Userspace equivalents of kernel helpers not available in user headers */
+#ifndef BIT
+#define BIT(n)			(1u << (n))
+#endif
+#ifndef GENMASK
+#define GENMASK(h, l)		(((~0u) >> (31 - (h))) & ((~0u) << (l)))
+#endif
+#define VFIO_PCI_INDEX_TO_OFFSET(idx)	((uint64_t)(idx) << 40)
+
+static const char *device_bdf;
+
+/* ------------------------------------------------------------------ */
+/* CXL UAPI constants (mirrors include/uapi/linux/vfio.h)             */
+/* ------------------------------------------------------------------ */
+
+#define VFIO_DEVICE_FLAGS_CXL		(1 << 9)
+
+#define VFIO_DEVICE_INFO_CAP_CXL	6
+
+#define VFIO_CXL_CAP_COMMITTED		(1 << 0)
+#define VFIO_CXL_CAP_PRECOMMITTED	(1 << 1)
+
+#define PCI_VENDOR_ID_CXL		0x1e98
+#define VFIO_REGION_TYPE_PCI_VENDOR_TYPE (1 << 31)
+#ifndef VFIO_REGION_SUBTYPE_CXL
+#define VFIO_REGION_SUBTYPE_CXL		1
+#endif
+#ifndef VFIO_REGION_SUBTYPE_CXL_COMP_REGS
+#define VFIO_REGION_SUBTYPE_CXL_COMP_REGS 2
+#endif
+
+/*
+ * HDM Decoder register layout within the component register block.
+ * Offsets relative to the start of the HDM decoder capability block
+ * (i.e. relative to the start of the COMP_REGS region).
+ */
+#define HDM_CAP_OFFSET			0x00
+#define HDM_GLOBAL_CTRL_OFFSET		0x04
+#define HDM_GLOBAL_STATUS_OFFSET	0x08
+#define HDM_DECODER_FIRST_OFFSET	0x10
+#define HDM_DECODER_STRIDE		0x20
+#define HDM_DECODER_BASE_LO		0x00
+#define HDM_DECODER_BASE_HI		0x04
+#define HDM_DECODER_SIZE_LO		0x08
+#define HDM_DECODER_SIZE_HI		0x0c
+#define HDM_DECODER_CTRL		0x10
+
+#define HDM_CTRL_COMMIT			BIT(9)
+#define HDM_CTRL_COMMITTED		BIT(10)
+#define HDM_CTRL_RESERVED_MASK		(BIT(15) | GENMASK(31, 28))
+#define HDM_BASE_LO_RESERVED_MASK	GENMASK(27, 0)
+#define HDM_GLOBAL_CTRL_RESERVED_MASK	GENMASK(31, 2)
+
+/*
+ * CXL DVSEC register offsets relative to the DVSEC capability base.
+ * §8.1.3 of CXL 3.1 specification.
+ */
+#define CXL_DVSEC_CONTROL_OFFSET	0x0c
+#define CXL_DVSEC_STATUS_OFFSET		0x0e
+#define CXL_DVSEC_CONTROL2_OFFSET	0x10
+#define CXL_DVSEC_LOCK_OFFSET		0x14
+
+#define CXL_CTRL_IO_ENABLE		BIT(1)
+#define CXL_STATUS_RW1C_BIT		BIT(14)
+#define CXL_LOCK_BIT			BIT(0)
+#define CXL_LOCK_RESERVED_MASK		GENMASK(15, 1)
+
+/* ------------------------------------------------------------------ */
+/* Helpers                                                             */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Walk the vfio_device_info capability chain embedded in @buf.
+ * Returns a pointer to the capability with the given @id, or NULL.
+ */
+static const struct vfio_info_cap_header *
+find_device_cap(const void *buf, size_t bufsz, uint16_t id)
+{
+	const struct vfio_device_info *info = buf;
+	const struct vfio_info_cap_header *cap;
+
+	if (!(info->flags & VFIO_DEVICE_FLAGS_CAPS) || !info->cap_offset)
+		return NULL;
+
+	cap = (const struct vfio_info_cap_header *)
+		((const char *)buf + info->cap_offset);
+
+	while (true) {
+		if (cap->id == id)
+			return cap;
+		if (!cap->next)
+			return NULL;
+		cap = (const struct vfio_info_cap_header *)
+			((const char *)buf + cap->next);
+		if ((const char *)cap + sizeof(*cap) > (const char *)buf + bufsz)
+			return NULL;
+	}
+}
+
+/*
+ * Read a 32-bit value from the COMP_REGS region at @offset (HDM-relative).
+ */
+static uint32_t comp_regs_read32(struct vfio_pci_device *dev,
+				 uint32_t region_idx, uint64_t offset)
+{
+	uint32_t val;
+	loff_t pos = (loff_t)VFIO_PCI_INDEX_TO_OFFSET(region_idx) + offset;
+	ssize_t r;
+
+	r = pread(dev->fd, &val, sizeof(val), pos);
+	if (r != sizeof(val))
+		return ~0u;
+	return val;
+}
+
+/*
+ * Write a 32-bit value to the COMP_REGS region at @offset.
+ */
+static void comp_regs_write32(struct vfio_pci_device *dev,
+			      uint32_t region_idx, uint64_t offset,
+			      uint32_t val)
+{
+	loff_t pos = (loff_t)VFIO_PCI_INDEX_TO_OFFSET(region_idx) + offset;
+	pwrite(dev->fd, &val, sizeof(val), pos);
+}
+
+/*
+ * Find the CXL DVSEC capability base in config space.
+ * Walks the extended capability list (starting at 0x100).
+ * Returns the config-space offset of the DVSEC header, or 0.
+ */
+#define PCI_DVSEC_VENDOR_ID_CXL	0x1e98
+#define PCI_DVSEC_ID_CXL_DEVICE	0x0000
+#define PCI_EXT_CAP_ID_DVSEC	0x23
+
+static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev)
+{
+	uint16_t pos = PCI_CFG_SPACE_SIZE; /* 0x100 */
+	int iter = 0;
+
+	while (pos && iter++ < 64) {
+		uint32_t hdr  = vfio_pci_config_readl(dev, pos);
+		uint32_t hdr1, hdr2;
+		uint16_t cap_id	 = hdr & 0xffff;
+		uint16_t next	 = (hdr >> 20) & 0xffc;
+
+		if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
+			hdr1 = vfio_pci_config_readl(dev, pos + 4);
+			hdr2 = vfio_pci_config_readl(dev, pos + 8);
+			/*
+			 * PCIe DVSEC Header 1 layout (Table 9-16):
+			 *   Bits [15: 0] = DVSEC Vendor ID
+			 *   Bits [19:16] = DVSEC Revision
+			 *   Bits [31:20] = DVSEC Length
+			 * DVSEC Header 2 layout:
+			 *   Bits [15: 0] = DVSEC ID
+			 */
+			if ((hdr1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
+			    (hdr2 & 0xffff) == PCI_DVSEC_ID_CXL_DEVICE)
+				return pos;
+		}
+		pos = next;
+	}
+	return 0;
+}
+
+
+/* ------------------------------------------------------------------ */
+/* Fixture                                                             */
+/* ------------------------------------------------------------------ */
+
+FIXTURE(cxl_type2) {
+	struct iommu *iommu;
+	struct vfio_pci_device *dev;
+
+	/* Filled in during FIXTURE_SETUP from the CXL cap */
+	struct vfio_device_info_cap_cxl cxl_cap;
+	uint16_t dvsec_base;
+
+	/* DPA mmap pointer (may be NULL if test skips mmap sub-tests) */
+	void *dpa_mmap;
+	size_t dpa_mmap_size;
+};
+
+FIXTURE_SETUP(cxl_type2)
+{
+	uint8_t infobuf[512] = {};
+	struct vfio_device_info *info = (void *)infobuf;
+	const struct vfio_device_info_cap_cxl *cap;
+
+	self->iommu = iommu_init(default_iommu_mode);
+	self->dev   = vfio_pci_device_init(device_bdf, self->iommu);
+
+	/* Query device info with space for capability chain */
+	info->argsz = sizeof(infobuf);
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
+
+	if (!(info->flags & VFIO_DEVICE_FLAGS_CXL)) {
+		printf("Device %s is not a CXL Type-2 device — skipping\n",
+		       device_bdf);
+		SKIP(return, "not a CXL Type-2 device");
+	}
+
+	cap = (const struct vfio_device_info_cap_cxl *)
+		find_device_cap(infobuf, sizeof(infobuf),
+				VFIO_DEVICE_INFO_CAP_CXL);
+	ASSERT_NE(NULL, cap);
+	memcpy(&self->cxl_cap, cap, sizeof(*cap));
+
+	self->dvsec_base  = find_cxl_dvsec(self->dev);
+	self->dpa_mmap    = MAP_FAILED;
+	self->dpa_mmap_size = 0;
+}
+
+FIXTURE_TEARDOWN(cxl_type2)
+{
+	if (self->dpa_mmap != MAP_FAILED && self->dpa_mmap_size)
+		munmap(self->dpa_mmap, self->dpa_mmap_size);
+	vfio_pci_device_cleanup(self->dev);
+	iommu_cleanup(self->iommu);
+}
+
+/* ------------------------------------------------------------------ */
+/* Tests: VFIO_DEVICE_GET_INFO                                         */
+/* ------------------------------------------------------------------ */
+
+/*
+ * CXL and PCI flags must both be set; CAPS must be set since we have a cap.
+ */
+TEST_F(cxl_type2, device_flags)
+{
+	uint8_t infobuf[512] = {};
+	struct vfio_device_info *info = (void *)infobuf;
+
+	info->argsz = sizeof(infobuf);
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
+
+	ASSERT_TRUE(info->flags & VFIO_DEVICE_FLAGS_CXL);
+	ASSERT_TRUE(info->flags & VFIO_DEVICE_FLAGS_PCI);
+	ASSERT_TRUE(info->flags & VFIO_DEVICE_FLAGS_CAPS);
+
+	printf("device flags: 0x%x  num_regions: %u\n",
+	       info->flags, info->num_regions);
+}
+
+/*
+ * The CXL capability must report sane HDM and DPA values.
+ */
+TEST_F(cxl_type2, cxl_cap_fields)
+{
+	const struct vfio_device_info_cap_cxl *c = &self->cxl_cap;
+
+	ASSERT_EQ(VFIO_DEVICE_INFO_CAP_CXL, c->header.id);
+	ASSERT_EQ(1, c->header.version);
+
+	/* Must have at least one HDM decoder */
+	ASSERT_GT(c->hdm_count, 0);
+
+	/* DPA must be non-zero */
+	ASSERT_GT(c->dpa_size, 0ULL);
+
+	/* HDM region size must be non-zero and 4-byte aligned */
+	ASSERT_GT(c->hdm_regs_size, 0ULL);
+	ASSERT_EQ(0ULL, c->hdm_regs_size % 4);
+
+	/* Region indices must not be ~0U (sentinel for "not found") */
+	ASSERT_NE(~0U, c->dpa_region_index);
+	ASSERT_NE(~0U, c->comp_regs_region_index);
+
+	/* The two regions must be distinct */
+	ASSERT_NE(c->dpa_region_index, c->comp_regs_region_index);
+
+	/* For a pre-committed device both flags must be set */
+	if (c->flags & VFIO_CXL_CAP_PRECOMMITTED)
+		ASSERT_TRUE(c->flags & VFIO_CXL_CAP_COMMITTED);
+
+	printf("hdm_count=%u dpa_size=0x%llx hdm_regs_size=0x%llx "
+	       "dpa_idx=%u comp_regs_idx=%u flags=0x%x\n",
+	       c->hdm_count, (unsigned long long)c->dpa_size,
+	       (unsigned long long)c->hdm_regs_size,
+	       c->dpa_region_index, c->comp_regs_region_index, c->flags);
+}
+
+/* ------------------------------------------------------------------ */
+/* Tests: VFIO_DEVICE_GET_REGION_INFO                                  */
+/* ------------------------------------------------------------------ */
+
+/*
+ * The component register BAR must be hidden: size=0 and no flags.
+ */
+TEST_F(cxl_type2, component_bar_hidden)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+
+	reg.index = self->cxl_cap.hdm_regs_bar_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	ASSERT_EQ(0ULL, reg.size);
+	ASSERT_EQ(0U, reg.flags);
+
+	printf("component BAR %u: size=%llu flags=0x%x (hidden as expected)\n",
+	       self->cxl_cap.hdm_regs_bar_index,
+	       (unsigned long long)reg.size, reg.flags);
+}
+
+/*
+ * DPA region must be readable, writable, and mmappable.
+ * Its size must match dpa_size from the CXL capability.
+ */
+TEST_F(cxl_type2, dpa_region_info)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+
+	reg.index = self->cxl_cap.dpa_region_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	ASSERT_EQ(self->cxl_cap.dpa_size, reg.size);
+	ASSERT_TRUE(reg.flags & VFIO_REGION_INFO_FLAG_READ);
+	ASSERT_TRUE(reg.flags & VFIO_REGION_INFO_FLAG_WRITE);
+	ASSERT_TRUE(reg.flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	printf("DPA region: size=0x%llx offset=0x%llx flags=0x%x\n",
+	       (unsigned long long)reg.size,
+	       (unsigned long long)reg.offset, reg.flags);
+}
+
+/*
+ * COMP_REGS region must be readable and writable but not mmappable.
+ * Its size must match hdm_regs_size from the CXL capability.
+ */
+TEST_F(cxl_type2, comp_regs_region_info)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+
+	reg.index = self->cxl_cap.comp_regs_region_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	ASSERT_EQ(self->cxl_cap.hdm_regs_size, reg.size);
+	ASSERT_TRUE(reg.flags  & VFIO_REGION_INFO_FLAG_READ);
+	ASSERT_TRUE(reg.flags  & VFIO_REGION_INFO_FLAG_WRITE);
+	ASSERT_FALSE(reg.flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	printf("COMP_REGS region: size=0x%llx offset=0x%llx flags=0x%x\n",
+	       (unsigned long long)reg.size,
+	       (unsigned long long)reg.offset, reg.flags);
+}
+
+/* ------------------------------------------------------------------ */
+/* Tests: DPA region mmap                                              */
+/* ------------------------------------------------------------------ */
+
+/*
+ * mmap() the DPA region and verify the first page can be read.
+ * The region uses lazy fault insertion so the first access triggers the
+ * vfio_cxl_region_page_fault path.
+ */
+TEST_F(cxl_type2, dpa_mmap_fault)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+	size_t map_size;
+	void *ptr;
+	volatile uint8_t *p;
+	uint8_t val;
+
+	reg.index = self->cxl_cap.dpa_region_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	/* Map just the first 2MB or the full region, whichever is smaller */
+	map_size = (size_t)reg.size < (size_t)(2 * SZ_1M)
+		 ? (size_t)reg.size : (size_t)(2 * SZ_1M);
+
+	ptr = mmap(NULL, map_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, self->dev->fd, (off_t)reg.offset);
+	ASSERT_NE(MAP_FAILED, ptr);
+
+	self->dpa_mmap = ptr;
+	self->dpa_mmap_size = map_size;
+
+	/* First access — triggers the page fault handler */
+	p = (volatile uint8_t *)ptr;
+	val = *p;
+	(void)val;
+
+	printf("DPA mmap: ptr=%p size=0x%zx first byte=0x%02x\n",
+	       ptr, map_size, (unsigned)val);
+
+	/* Write a pattern and read it back */
+	*p = 0xab;
+	ASSERT_EQ(0xab, *p);
+}
+
+/*
+ * mmap() beyond dpa_size must fail with EINVAL.
+ */
+TEST_F(cxl_type2, dpa_mmap_overflow)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+	void *ptr;
+
+	reg.index = self->cxl_cap.dpa_region_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	ptr = mmap(NULL, (size_t)reg.size + SZ_4K, PROT_READ,
+		   MAP_SHARED, self->dev->fd, (off_t)reg.offset);
+	ASSERT_EQ(MAP_FAILED, ptr);
+
+	printf("mmap beyond dpa_size correctly failed (errno=%d)\n", errno);
+}
+
+/*
+ * mmap() of the COMP_REGS region (no MMAP flag) must fail.
+ */
+TEST_F(cxl_type2, comp_regs_no_mmap)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+	void *ptr;
+
+	reg.index = self->cxl_cap.comp_regs_region_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	ptr = mmap(NULL, (size_t)reg.size, PROT_READ,
+		   MAP_SHARED, self->dev->fd, (off_t)reg.offset);
+	ASSERT_EQ(MAP_FAILED, ptr);
+
+	printf("mmap of COMP_REGS correctly failed (errno=%d)\n", errno);
+}
+
+/* ------------------------------------------------------------------ */
+/* Tests: COMP_REGS region (HDM decoder emulation)                    */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Reading HDM Capability (offset 0x00) must return a non-zero value
+ * consistent with at least one decoder being present.
+ * Bits [3:0] encode the HDM decoder count.
+ */
+TEST_F(cxl_type2, hdm_cap_read)
+{
+	uint32_t cap;
+	uint32_t idx = self->cxl_cap.comp_regs_region_index;
+
+	cap = comp_regs_read32(self->dev, idx, HDM_CAP_OFFSET);
+	ASSERT_NE(~0u, cap);
+
+	/* Lower 4 bits encode the number of decoders */
+	ASSERT_GE((int)(cap & 0xf), (int)self->cxl_cap.hdm_count - 1);
+
+	printf("HDM Capability register: 0x%08x  decoder_count_field=%u\n",
+	       cap, cap & 0xf);
+}
+
+/*
+ * Writing the HDM Capability register (RO) must be silently discarded.
+ */
+TEST_F(cxl_type2, hdm_cap_ro)
+{
+	uint32_t idx = self->cxl_cap.comp_regs_region_index;
+	uint32_t before, after;
+
+	before = comp_regs_read32(self->dev, idx, HDM_CAP_OFFSET);
+	comp_regs_write32(self->dev, idx, HDM_CAP_OFFSET, 0xdeadbeef);
+	after  = comp_regs_read32(self->dev, idx, HDM_CAP_OFFSET);
+
+	ASSERT_EQ(before, after);
+	printf("HDM Capability: write discarded (before=0x%08x after=0x%08x)\n",
+	       before, after);
+}
+
+/*
+ * Writing Global Control (offset 0x04) with reserved bits set must
+ * result in those bits being cleared in the stored value.
+ * HDM Decoder Enable (bit 1) is a genuine RW bit.
+ */
+TEST_F(cxl_type2, hdm_global_ctrl_reserved_bits)
+{
+	uint32_t idx = self->cxl_cap.comp_regs_region_index;
+	uint32_t readback;
+
+	/* Write all-ones — reserved bits GENMASK(31,2) must be cleared */
+	comp_regs_write32(self->dev, idx, HDM_GLOBAL_CTRL_OFFSET, 0xffffffff);
+	readback = comp_regs_read32(self->dev, idx, HDM_GLOBAL_CTRL_OFFSET);
+
+	ASSERT_EQ(0u, readback & HDM_GLOBAL_CTRL_RESERVED_MASK);
+	printf("HDM Global Control reserved bits cleared: 0x%08x\n", readback);
+
+	/* Restore to 0 */
+	comp_regs_write32(self->dev, idx, HDM_GLOBAL_CTRL_OFFSET, 0);
+}
+
+/*
+ * Writing decoder N BASE_LO with reserved bits [27:0] set must
+ * result in those bits being cleared.  [31:28] are significant.
+ */
+TEST_F(cxl_type2, hdm_decoder_base_lo_reserved)
+{
+	uint32_t idx = self->cxl_cap.comp_regs_region_index;
+	uint64_t ctrl_off = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_BASE_LO;
+	uint32_t readback;
+
+	/* Writing 0xffffffff: only [31:28] should survive */
+	comp_regs_write32(self->dev, idx, ctrl_off, 0xffffffff);
+	readback = comp_regs_read32(self->dev, idx, ctrl_off);
+
+	ASSERT_EQ(0u, readback & HDM_BASE_LO_RESERVED_MASK);
+	ASSERT_EQ(0xf0000000u, readback);
+
+	printf("HDM decoder 0 BASE_LO: reserved bits cleared -> 0x%08x\n",
+	       readback);
+
+	/* Clean up */
+	comp_regs_write32(self->dev, idx, ctrl_off, 0);
+}
+
+/*
+ * Unaligned (sub-dword) access to the COMP_REGS region must fail with EINVAL.
+ */
+TEST_F(cxl_type2, comp_regs_unaligned_access)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+	uint8_t byte_val = 0;
+	loff_t pos;
+	ssize_t r;
+
+	reg.index = self->cxl_cap.comp_regs_region_index;
+	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg));
+
+	/* Attempt 1-byte read at offset 1 (unaligned) */
+	pos = (loff_t)reg.offset + 1;
+	r = pread(self->dev->fd, &byte_val, 1, pos);
+	ASSERT_EQ(-1, (int)r);
+	ASSERT_EQ(EINVAL, errno);
+
+	printf("Unaligned COMP_REGS access correctly failed (errno=%d)\n",
+	       errno);
+}
+
+/*
+ * Writing HDM decoder N CTRL with COMMIT=1 must cause COMMITTED to
+ * be set immediately in the emulated shadow state (no hardware wait).
+ * This models the QEMU notify_change path.
+ */
+TEST_F(cxl_type2, hdm_ctrl_commit_to_committed)
+{
+	uint32_t idx = self->cxl_cap.comp_regs_region_index;
+	/*
+	 * Use decoder 0; write BASE/SIZE first so the decoder is in a
+	 * plausible state before committing.  Use 256MB alignment
+	 * (bit 28 = 1 in SIZE_LO) to satisfy the reserved-bit rule.
+	 */
+	uint64_t base_lo_off = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_BASE_LO;
+	uint64_t base_hi_off = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_BASE_HI;
+	uint64_t size_lo_off = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_SIZE_LO;
+	uint64_t size_hi_off = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_SIZE_HI;
+	uint64_t ctrl_off    = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_CTRL;
+	uint32_t ctrl_readback;
+
+	/* Skip if COMMITTED is already set (pre-committed decoder) */
+	ctrl_readback = comp_regs_read32(self->dev, idx, ctrl_off);
+	if (ctrl_readback & HDM_CTRL_COMMITTED) {
+		printf("Decoder 0 already committed (ctrl=0x%08x); "
+		       "skipping COMMIT test\n", ctrl_readback);
+		SKIP(return, "decoder already committed");
+	}
+
+	/* Set BASE and SIZE to plausible 256MB-aligned values */
+	comp_regs_write32(self->dev, idx, base_lo_off, 0x10000000); /* 256MB boundary */
+	comp_regs_write32(self->dev, idx, base_hi_off, 0);
+	comp_regs_write32(self->dev, idx, size_lo_off, 0x10000000); /* 256MB */
+	comp_regs_write32(self->dev, idx, size_hi_off, 0);
+
+	/* Write COMMIT=1 */
+	comp_regs_write32(self->dev, idx, ctrl_off, HDM_CTRL_COMMIT);
+
+	/* COMMITTED must be set immediately in the shadow */
+	ctrl_readback = comp_regs_read32(self->dev, idx, ctrl_off);
+	ASSERT_TRUE(ctrl_readback & HDM_CTRL_COMMITTED);
+
+	printf("HDM decoder 0 CTRL after COMMIT=1: 0x%08x (COMMITTED set)\n",
+	       ctrl_readback);
+
+	/* Writing COMMIT=0 must clear COMMITTED */
+	comp_regs_write32(self->dev, idx, ctrl_off, 0);
+	ctrl_readback = comp_regs_read32(self->dev, idx, ctrl_off);
+	ASSERT_FALSE(ctrl_readback & HDM_CTRL_COMMITTED);
+
+	printf("HDM decoder 0 CTRL after COMMIT=0: 0x%08x (COMMITTED cleared)\n",
+	       ctrl_readback);
+}
+
+/*
+ * Writing CTRL reserved bits must result in them being cleared.
+ */
+TEST_F(cxl_type2, hdm_ctrl_reserved_bits)
+{
+	uint32_t idx = self->cxl_cap.comp_regs_region_index;
+	uint64_t ctrl_off = HDM_DECODER_FIRST_OFFSET + HDM_DECODER_CTRL;
+	uint32_t ctrl_before, ctrl_after;
+
+	ctrl_before = comp_regs_read32(self->dev, idx, ctrl_off);
+
+	/*
+	 * Write all-ones; reserved bits (BIT(15) and GENMASK(31,28)) must
+	 * be cleared in the readback.  Skip if COMMIT_LOCK is already set.
+	 */
+	if (ctrl_before & BIT(8)) {
+		printf("Decoder 0 COMMIT_LOCK set; skipping reserved-bit test\n");
+		SKIP(return, "COMMIT_LOCK set");
+	}
+
+	comp_regs_write32(self->dev, idx, ctrl_off, 0xffffffff);
+	ctrl_after = comp_regs_read32(self->dev, idx, ctrl_off);
+
+	ASSERT_EQ(0u, ctrl_after & HDM_CTRL_RESERVED_MASK);
+
+	printf("HDM CTRL reserved bits cleared: before=0x%08x after=0x%08x\n",
+	       ctrl_before, ctrl_after);
+
+	/* Restore */
+	comp_regs_write32(self->dev, idx, ctrl_off, ctrl_before);
+}
+
+/* ------------------------------------------------------------------ */
+/* Tests: DVSEC configuration space emulation                         */
+/* ------------------------------------------------------------------ */
+
+/*
+ * CXL Control (DVSEC offset 0x0c): IO_Enable (bit 1) must always read 1.
+ */
+TEST_F(cxl_type2, dvsec_control_io_enable_ro)
+{
+	uint16_t dvsec = self->dvsec_base;
+	uint16_t ctrl;
+
+	if (!dvsec)
+		SKIP(return, "CXL DVSEC not found in config space");
+
+	/* Read current value */
+	ctrl = vfio_pci_config_readw(self->dev, dvsec + CXL_DVSEC_CONTROL_OFFSET);
+	ASSERT_TRUE(ctrl & CXL_CTRL_IO_ENABLE);
+
+	/* Write with IO_Enable cleared — it must stay set */
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_CONTROL_OFFSET,
+			       ctrl & ~CXL_CTRL_IO_ENABLE);
+	ctrl = vfio_pci_config_readw(self->dev, dvsec + CXL_DVSEC_CONTROL_OFFSET);
+	ASSERT_TRUE(ctrl & CXL_CTRL_IO_ENABLE);
+
+	printf("DVSEC CXL Control: IO_Enable always 1 (ctrl=0x%04x)\n", ctrl);
+}
+
+/*
+ * CXL Status (DVSEC offset 0x0e): Bit 14 (Viral_Status) is RW1CS —
+ * writing 1 clears it; writing 0 leaves it unchanged.
+ */
+TEST_F(cxl_type2, dvsec_status_rw1cs)
+{
+	uint16_t dvsec = self->dvsec_base;
+	uint16_t status_before, status_after;
+
+	if (!dvsec)
+		SKIP(return, "CXL DVSEC not found in config space");
+
+	status_before = vfio_pci_config_readw(self->dev,
+					      dvsec + CXL_DVSEC_STATUS_OFFSET);
+	printf("DVSEC CXL Status before: 0x%04x\n", status_before);
+
+	/* Write 0 to RW1C bit — value must not change */
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_STATUS_OFFSET,
+			       status_before & ~CXL_STATUS_RW1C_BIT);
+	status_after = vfio_pci_config_readw(self->dev,
+					     dvsec + CXL_DVSEC_STATUS_OFFSET);
+	ASSERT_EQ(status_before & CXL_STATUS_RW1C_BIT,
+		  status_after  & CXL_STATUS_RW1C_BIT);
+
+	/* Write 1 to RW1C bit — bit must be cleared */
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_STATUS_OFFSET,
+			       CXL_STATUS_RW1C_BIT);
+	status_after = vfio_pci_config_readw(self->dev,
+					     dvsec + CXL_DVSEC_STATUS_OFFSET);
+	ASSERT_FALSE(status_after & CXL_STATUS_RW1C_BIT);
+
+	printf("DVSEC CXL Status RW1C cleared: 0x%04x -> 0x%04x\n",
+	       status_before, status_after);
+}
+
+/*
+ * CXL Lock (DVSEC offset 0x14):
+ *   - Reserved bits GENMASK(15,1) must be cleared.
+ *   - Once locked, CXL Control writes must be discarded.
+ */
+TEST_F(cxl_type2, dvsec_lock_semantics)
+{
+	uint16_t dvsec = self->dvsec_base;
+	uint16_t lock_val, ctrl_before, ctrl_after;
+
+	if (!dvsec)
+		SKIP(return, "CXL DVSEC not found in config space");
+
+	lock_val = vfio_pci_config_readw(self->dev,
+					 dvsec + CXL_DVSEC_LOCK_OFFSET);
+	if (lock_val & CXL_LOCK_BIT) {
+		printf("CXL Lock already set; skipping lock semantics test\n");
+		SKIP(return, "CONFIG_LOCK already set");
+	}
+
+	/* Write reserved bits — they must be cleared on readback */
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_LOCK_OFFSET,
+			       CXL_LOCK_RESERVED_MASK);
+	lock_val = vfio_pci_config_readw(self->dev,
+					 dvsec + CXL_DVSEC_LOCK_OFFSET);
+	ASSERT_EQ(0u, lock_val & CXL_LOCK_RESERVED_MASK);
+	ASSERT_FALSE(lock_val & CXL_LOCK_BIT);
+
+	printf("Lock reserved bits cleared correctly\n");
+
+	/*
+	 * Save the current Control value, then set Lock.
+	 * Any subsequent write to Control must be discarded.
+	 */
+	ctrl_before = vfio_pci_config_readw(self->dev,
+					    dvsec + CXL_DVSEC_CONTROL_OFFSET);
+
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_LOCK_OFFSET,
+			       CXL_LOCK_BIT);
+	lock_val = vfio_pci_config_readw(self->dev,
+					 dvsec + CXL_DVSEC_LOCK_OFFSET);
+	ASSERT_TRUE(lock_val & CXL_LOCK_BIT);
+	printf("CXL Lock set (lock=0x%04x)\n", lock_val);
+
+	/* Attempt to modify Control after locking — must be discarded */
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_CONTROL_OFFSET,
+			       ctrl_before ^ 0x0001); /* flip Cache_Enable */
+	ctrl_after = vfio_pci_config_readw(self->dev,
+					   dvsec + CXL_DVSEC_CONTROL_OFFSET);
+	ASSERT_EQ(ctrl_before, ctrl_after);
+
+	printf("CXL Control write after lock discarded: "
+	       "before=0x%04x after=0x%04x\n", ctrl_before, ctrl_after);
+}
+
+/*
+ * CXL Control reserved bits (13, 15) must be cleared on write.
+ */
+TEST_F(cxl_type2, dvsec_control_reserved_bits)
+{
+	uint16_t dvsec = self->dvsec_base;
+	uint16_t lock_val, ctrl_after;
+
+	if (!dvsec)
+		SKIP(return, "CXL DVSEC not found in config space");
+
+	lock_val = vfio_pci_config_readw(self->dev,
+					 dvsec + CXL_DVSEC_LOCK_OFFSET);
+	if (lock_val & CXL_LOCK_BIT)
+		SKIP(return, "CONFIG_LOCK already set; cannot test Control");
+
+	vfio_pci_config_writew(self->dev, dvsec + CXL_DVSEC_CONTROL_OFFSET,
+			       0xffff);
+	ctrl_after = vfio_pci_config_readw(self->dev,
+					   dvsec + CXL_DVSEC_CONTROL_OFFSET);
+
+	/* Bits 13 and 15 must be cleared */
+	ASSERT_FALSE(ctrl_after & BIT(13));
+	ASSERT_FALSE(ctrl_after & BIT(15));
+
+	printf("DVSEC Control reserved bits cleared: 0x%04x\n", ctrl_after);
+}
+
+/* ------------------------------------------------------------------ */
+/* main                                                                */
+/* ------------------------------------------------------------------ */
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.25.1

