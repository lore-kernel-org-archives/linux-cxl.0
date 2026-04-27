Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346E3E92B4;
	Mon, 27 Apr 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313685; cv=fail; b=bkl2C277/E28Bdy9rOTqjuIg0jWnHAJmTDoOThYFcRPONI/TYKHfAgE7h46z3MaNI0BqjEF7ZGhiN3bxfp/P7REa3FKtD5bC8J7VrQnFX4anEbU11j69ZxWpat4zLpKLu//gBPZW6pb/PoTtlTNUsYTkvL2KhViPeO7PXxYrCGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313685; c=relaxed/simple;
	bh=m5CcclB4IS00r4b54dRgQIidbCEuxymK9JYTFXAVkg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOrkUuoJEeMyUzCoVAloYzl3XLEoNCsOLH/lQAQpwpWrDcPDevKRDGFEiqVEpQWoaX943hPOzwdhiWLYZGYu3GG5dRsd5T8rpLZOPJ5YTnB7sBfDcOs8syXmLvR9dEAKA0XYChid8+rGy7c7k/0F5xd/kw5t1w2wTDQXhJ1c7EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MHEPFfhr; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MHEPFfhr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEfbj+3ZrFvUh13Fxrt7+HfB6KaxXXmGHfOq41ebjOZ6EYODO+jXl+YFsr0AYIXrGo5MZyCXagVL3jzxRw+3ezZ8GXDNEtKEAnJuR2dK6g9zaVE3i9hUjSVBWl0ruJwp3uGaK3U7FhaHTgQOnlzDbUQDrpXyU/6wjpE++rKLjNPLkDkA+hM4Dg4RBwj0QULI0w02LSyTFNBVjU3IgL7LBY/J7V3BZnKNvLfCcRnOUa2ZodWAqdtLH/bSk25WPUSEjqWeC76XdJyApvzUm3ACC/G7NBzhp0M7qiqJj5WKYcMlfq1HwpHU1ApqXp6YITEo3UUYlitum62XvTIocYBY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOuH+YDKH63faEyUvLuBLbWGq7H5vFgqnGnRk0DNyI0=;
 b=qQ01S1Z9a7GbA3wyOoV0mtPcc1DRD0JevB/u/tkemWRYYqrgN0Ho+/XWRUpL5oKfGzlBjv6m1+tJHrN/86DYFEYr1XSaDAEjPeGWIJON24g0RkmbhzT3JR2pKIWugb9sDc5slo5LQpyRHWnj+RvadBn4WLp+f1U+AoDZK5b6ehwIYEPkPgc3MdsfeQiXgiVt6U2854T0M0y596eznhJBdmu4Je5Eq5sOIuLqBNs6qQuX3P1xOGmWiEemlk/M6+Lw3t/Jur59Nb701epWUKyJwtm8h1IWErBU7ZB2OtNPyECEB/D2umBOzblqNlGPfn5jQVV+jd6Xar0+5crXoKbRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOuH+YDKH63faEyUvLuBLbWGq7H5vFgqnGnRk0DNyI0=;
 b=MHEPFfhrp5Ee5yUQzrbZVfK3G96BbIHYC1mRvWdIgJlXaJR2B/2hz/smxSQEaGY1S8wR+fdW6L+oyBWEommbzAdVtgnkTXU7wjcSg93qW6VsJ10zJ4uhDgmtaZQfbqv6OvnFH5pm77cSjykiCQFTqFkiNpWNRUy8KHeo7nA5gnrUzniS4ReXgCX8Rwz6RAAfwpjm0uz4gpmtVeghg5cOMNtNQbwIXrY5p1GbsSZlupDVG+DJ9DYAS9Xdgsoab+k7lyRtHPdsbKnUGKUYPtmzn0e6SRQUioTZkLjZA+GwH/ZiGUiwTtPecdImXoIvyQwJ0alcL3xNer+mhy4kUL8qOg==
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:14:32 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::60) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:14:08 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:14:00 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>, <ankita@nvidia.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
	<fan.ni@samsung.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
	<marcel.apfelbaum@gmail.com>, <clg@redhat.com>, <cohuck@redhat.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	"Manish Honap" <mhonap@nvidia.com>
Subject: [RFC 6/9] hw/vfio/pci: Wire CXL component-register BAR with COMP_REGS overlay
Date: Mon, 27 Apr 2026 23:42:32 +0530
Message-ID: <20260427181235.3003865-7-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de79a8d-4308-4b1c-ef7a-08dea488d466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|11006099003|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	1di1M7nQ6MNvqMOXuqqBBjoBg/o5lAz3K1kxDGIzBmYA+0ZgcbHLy/PORddAFgdgzDAddaOq12Gp9QCsL4KNeFHc/fxqHc3I21xg27qrmqr11s3hw0jCiMz54zd5Ae6EkdvHYQAwUfzCvQZA+JPkTn4Sr+8VjMM8OvUeW1Wb2y1gFpnHuBAr+OdCSggnyvmUSsRuKe0edx6PFOfegcafzsAEu5YELsX0NwHJyZ99AEjDUpOnucgWjVYDIgizrdygo9S6gviDsHEkigavgM9RlLdb1yKPqyu5Ybr7truOdPV6+h4KxvnGHgtZvsnnnX3JP4G15Hs7OAQTBAoCsHYvR8D6tpmNEDLmTzv0wq4qFOd67emz1HtABnUeCLJWUNly5+hgRt3gYezlQWUZHXmXw6fejAqxfYmx3K6UbY/Zj9gnPQncp5jJ/opjKsrA6TSDvtxW1hfzeglnqC0tjBJT7vlE9r6U0k5Ek/KZ8jcTIkF44jUsSfRp0Xv/1X+qPIKJzoezuQdHxqjtHPR9ObLWEx/cYNvmVy63eZ6LavLW/fjnYpuwYhm2a836A3bOSP4zcVXk4db3CkgimG277iYSow+FPXNfxRUtSftOaLFLSVcCfWZSenNsnElJDbAovguW7RaWui1rHbaN2mrQ2rfCWdAvRGKKcFzWyzTNPrC8yamo5u6ljuWW4an4D9qS9WTscJodPiUpEs3+lN8XORPChcXKbIeDUhz9Mh2esfTESqDffXR2kqM+4tvU1ns6sS2Z7pUQNoDQw1SPY7vdQieJdZQN/KX8d5lcs99bock1TWECCBZIA4Wm4RwA1Ew8A/Nq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(11006099003)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YZmkcU75pTgI/mENTm4hdqpAlX/TalBuX3u9XpWnf3ChY3yfjuML8ZDcTgoEbUZUx1k71arh5cY81zGvmy0vI9QgyK/KR7JRbyw1c7fvVNS7t0eG0htgz/f2K24MGQ0CZ0P4o5E3/2LMk4P1GGBuDwrCVlnzrNSXV6nQurESdTNcEppZ0hzynvonV1Px/ZFsvurp6Wiq+81E01zBdvEMZ5ngak28w6xHO7XtMRe3ynMygfspKwgZWN+TiAHoZRPWFFRr27IZ59oAu8fR/oH13+NQz8JpbeuB4pqG92WLIFBKKnEt5kp92BT5Smzg3yr8Peyr06Oi3VK5np1VDw7eXecLYpfrcC//Q0PaRy2dc7Txz8F9XvFJ5hrPoVS1umgDdL9s2lNOv8pYKTUEOV49P01/ktp9ovfLhKDgzMrAkC7k2jTSJ7jfEKsiEME+yyjG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:31.8418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de79a8d-4308-4b1c-ef7a-08dea488d466
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

From: Manish Honap <mhonap@nvidia.com>

The CXL Component Register BAR contains two types of ranges that need
different handling:

  - Accelerator register windows: passed through as direct hardware
    mmaps for performance. The kernel reports the real BAR size and
    lists mmappable windows via VFIO_REGION_INFO_CAP_SPARSE_MMAP,
    excluding the HDM Decoder Capability block. vfio_region_mmap()
    creates hardware-backed sub-regions for each sparse area.

  - HDM Decoder Capability block: guest accesses must go through
    emulated ops so QEMU can observe and program decoder state. The
    kernel blocks direct mmap of this range.

vfio_bar_register(): after the normal mmap path, overlay the COMP_REGS
emulation region at hdm_regs_offset with priority 1. In QEMU's
MemoryRegion model, overlapping subregions are resolved by priority;
the default is 0. Priority 1 ensures guest accesses to the HDM range
always dispatch through the emulated COMP_REGS ops regardless of any
hardware-backed sub-region at a neighbouring offset.

vfio_pci_bars_exit(): remove the COMP_REGS overlay before the normal
BAR teardown path.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c        | 26 ++++++++++++++++++++++++++
 hw/vfio/trace-events |  1 +
 2 files changed, 27 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 49ac661eb3..0270de61d2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1960,6 +1960,10 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
+    bool cxl_comp_regs_bar = (vdev->vbasedev.flags & VFIO_DEVICE_FLAGS_CXL) &&
+                              nr == vdev->cxl.hdm_regs_bar_index &&
+                              vdev->cxl.comp_regs_region.mem;
+
     bar->mr = g_new0(MemoryRegion, 1);
     name = g_strdup_printf("%s base BAR %d", vdev->vbasedev.name, nr);
     memory_region_init_io(bar->mr, OBJECT(vdev), NULL, NULL, name, bar->size);
@@ -1974,6 +1978,21 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
         }
     }
 
+    if (cxl_comp_regs_bar) {
+        /*
+         * Overlay the COMP_REGS emulation at hdm_regs_offset with priority 1.
+         * The kernel excludes the HDM Decoder Capability block from the
+         * sparse-mmap list, so vfio_region_mmap() creates hardware-backed
+         * sub-regions only for accelerator register windows. The emulated
+         * COMP_REGS region sits above those at priority 1, ensuring guest
+         * accesses to the HDM range always dispatch through the emulated ops.
+         */
+        memory_region_add_subregion_overlap(bar->mr, vdev->cxl.hdm_regs_offset,
+                                            vdev->cxl.comp_regs_region.mem, 1);
+        trace_vfio_cxl_bar_subregion(vdev->vbasedev.name, nr,
+                                     vdev->cxl.hdm_regs_offset);
+    }
+
     pci_register_bar(pdev, nr, bar->type, bar->mr);
 }
 
@@ -1993,9 +2012,16 @@ void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
         VFIOBAR *bar = &vdev->bars[i];
+        bool use_comp_regs = (vdev->vbasedev.flags & VFIO_DEVICE_FLAGS_CXL) &&
+                             i == vdev->cxl.hdm_regs_bar_index &&
+                             vdev->cxl.comp_regs_region.mem;
 
         vfio_bar_quirk_exit(vdev, i);
         vfio_region_exit(&bar->region);
+        if (use_comp_regs && bar->mr) {
+            memory_region_del_subregion(bar->mr,
+                                        vdev->cxl.comp_regs_region.mem);
+        }
         if (bar->region.size) {
             memory_region_del_subregion(bar->mr, bar->region.mem);
         }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 3678481a8e..3bced3cebb 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -201,3 +201,4 @@ vfio_device_detach(const char *name, int group_id) " (%s) group %d"
 # pci.c CXL Type-2 passthrough
 vfio_cxl_setup_params(const char *name, uint8_t bar, uint64_t hdm_off, uint64_t hdm_sz, uint64_t dpa_sz) " (%s) hdm_bar=%u hdm_regs_offset=0x%"PRIx64" hdm_regs_size=0x%"PRIx64" dpa_size=0x%"PRIx64
 vfio_cxl_put_device(const char *name) " (%s) removing DPA region from system memory"
+vfio_cxl_bar_subregion(const char *name, int nr, uint64_t off) " (%s) BAR%d comp_regs overlay at BAR offset 0x%"PRIx64
-- 
2.25.1

