Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6E3E3D9D;
	Mon, 27 Apr 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313674; cv=fail; b=ZtCFhSxHPj1Tz+7zMVPxkS+rrJGwFaBEJWrjwtwQKBcrOTcFMbkYH9FL3ATJiCQOVKkkAHnNvo98JNSVO4suC/7Sqd3+sHRJU792Mu4CZgtHRnqBGRLI4ph3Ark4qItigfCUA1+t+HbFA/Zbvl6/KDabgeN35qrTJS2906DS0go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313674; c=relaxed/simple;
	bh=ILEI3gyYFoTH/z3G0FmNCA8WEE+h13v965Oxy/xHV+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liYibs3cyujagrtqgg26NtYpSsSWF64Bsa5mVkjrdYowa2BhnIwFb3NdaXGqvLlDyMRz5SGZybN0XSb2EJta9sPp/ZqT6Xjv+7EZiVFsrSxPHFO2osiSc7WGwvbHpFTRUGAp8ykLbLcBtc6uCPsRFSzAZzQ7MSKe5vnPzZ6NLnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=luF8HMr2; arc=fail smtp.client-ip=40.107.208.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="luF8HMr2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMgfi/JX0CKRWhz/P5n+JKfWxZQRE/PdGcEO2zd5yxSk/MoY7u+jB4jzgJAPrbfoQT8xz0oFzrNT/CVb0pRGvATrR4wMiM20LnLvugIWRLJpqv0id+B9yUdnZChUQpUbX7ysAtcfBl50Hv+NsjLhXEYag2LGaoDNa7M71je1ZfB3cgInxiyMHo8CwbJ/KWdrShbL1GbSO+c9+48y6Rroxtr2n7LwBFCg380UtUhL+l1SR7JkIGmrqH4lEAUWnaFw14K48HMy0ec9j6wOpZLqaejRmFftZX+Q+uWkfh9qH8f4JzgL9YbVzGpC3T80V3rC0OuVmAmLm2Tyja7UqLpkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuG8Ge0ykEIBDtFWCFC9wN1HAPiMU07Z5XLejSBkzZc=;
 b=mDh3caji+USfc6Mm6COUr5auMO/kS1Qf3gh+piXcTAlK5Phhk4u4unZUbapBDvmpCDTkPaOtWesqMKS3A1Bt7wBSvnNZfH4QSJEQ7bWSLLwNn2hRSEm7lgrcPH+KGEgMUb3/HSUqsGUNJPPKO0OtvBBR/WtNCs3r+5Nwd191D1YEWzLqavxDGWbOY/RdpWfzlY9cuFrOpbe74MhD5rZy1F2XSwBv4r4a1JAQR1VEH8b+B7b3+U5Zmav7zS9p8qACzCdI1cXojgz4vzO8a3ZEaXTNUDtDYGE6uXqzojhdQT4SHVW6H994r74aiBV1X+Nv1k0eRmtm/boDv37kSUqBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuG8Ge0ykEIBDtFWCFC9wN1HAPiMU07Z5XLejSBkzZc=;
 b=luF8HMr2GgZtmjCmO3VAcU69gr8Bw5NfFjvQsyCimKcYl8RQ54ukegQ3rmkfms1gMWdsy9bcq3Tbl+3lrQCZC0wYLGl0k9+BeEf/t8vc/+K/NEY+YR8xb8ktduB7bJwVHS6RaQ1EOhc0tZZZGQWcQrJhSBDgkIVq9qTOwBEYd/NRnyXbNlGRUxfuFAK1eG5h/J6ZelNHshS2h1vyyANe2FwVP3YIeOjurSds0oUgR6iGLUyrLXIqPWNl+WzkcZUSVbeyJ7Ol9mSsFx/fChBM5TIoGXJmaLQYtRMylyv8E/3NOIMCXHIBlGZTAiK2C1k2yRlrX9IXfs2W+hUXgGjfMw==
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:14:20 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23b::4) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 18:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 18:14:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 11:14:00 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 11:13:52 -0700
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
Subject: [RFC 5/9] hw/vfio/pci: Add CXL Type-2 device detection and region setup
Date: Mon, 27 Apr 2026 23:42:31 +0530
Message-ID: <20260427181235.3003865-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3022b281-ce9c-4e75-44be-08dea488cd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	A7u+6mZXZapd1DPWCyM5S0OUkSizfa8I1Lg9Y2BTVEELiBFQRNdLYw+VM/xpD7UXk0+XjL8cP0nRSYJCDC8aAJ/v4o0LSjoee9pJdyZ5J1bW6b8EDZ0HVSZ8LHgPXh+IN2ziLkHZTTb0KHQ4aghXRobCkIRHyNKr3SF8OFv0A4XddZaIt5yotyEMHI2bXV5thh5bcPBvFD5v4VDy8enXX034vqpfH5AULFYf/IgsKsxo4WKuczQGu6NwfEHz09U3B7FoGok2TFh+WNB6nd/5INDUHZVBj3uYD8MigVnJNit63yqAEDEmD+V5pIRH6Ng/Lq6TtQLNvUF8gBBu6PJXh8cp2QoIe8pUiR4eWl1qFZuKVFrPsiP0r42QjoZvfpyP61CTyrII/ZF6wZ+EgM+3L/W5XacwF2ehtbPtTyd3tkYWorYo6dHSqXJELWUFnevoxu/ZiLGLpFYcSKHn8q2WqFpYTPCRW6G/iJr2/qt0hYADJaZF7ZLBBDj9bYBHEyz6IvaqFx5Sc5p11Eour46hFquVe9eg0vbLGScFHwrvU+jl30jyYhK6v2StTk8We9Es7rF9iMHvxOO3KDEIE1RvkToxpkCsmiMOJHdb/YxSsboKu6yxQbRscRklZZO9JH6l4lJQExUfFFIYnfMXk8Pj1YbmUdzqf6KZR09FrejE8Z3WRhpYNxqhRlqI7KSCtzYACCfq7xLVMqpAK1nT/RYByMR6NeNBJOiMFJ204E3wtuLmKngFto9M1Bsa/vEYPa6HsZvKmS39FYigABJ4V3yvhMS0ZDuyaxT4Q6jpyHYwd+bYPktTPVyD8dMvB3wh5c5E
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6WuA0owz+mcNaLZQdFn3wUWrQ0d9eNcUr7dMmY4z1TMR7XVSsqgM3s/Bq7kL5ggx24FM5DYItLIvUkCDe6FvdlEe5qr7CgJN/cF1Su5vy0gM0aUaOdUBZPzfmL0/BY4MXXPIeCq+GvQbzm8I9oCaS/Rn4kZRFwtUb1c0xup6oHBOdxvkNcxOX6+sl7000n1jsjLtA4RXFi59jZ404LxNOxFgW1ov2bhE4tQz96HPi6AoUCMQq3S1VZO0bSojxOUBHazV3PRUt5Vk9+ymM7GJLM2UpnKTmTL2yXn3plSljRIiQu+NZEv4gZWA8RXRD6FUiRmExZaqMbaGBJI/dAHbX4TRsOHxWmmSQuOYQC+PsdiyT0HC2+TJbvHe/y55BU7l3Bds3WT6ik4mEHBNok3yv8WcydyQJwKN51fLOQb7B4ghsUatYIiJ5nfqxTv6KI/W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:14:20.1749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3022b281-ce9c-4e75-44be-08dea488cd84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

From: Manish Honap <mhonap@nvidia.com>

When VFIO_DEVICE_FLAGS_CXL is set, the kernel has identified a CXL
Type-2 device and populated the capability chain with a
vfio_device_info_cap_cxl entry. Read that entry to locate the DPA
and CXL Component Register shadow regions, then call vfio_region_setup()
for each.

DPA covers the device's host-managed memory and is faulted in lazily
by the VMM. The CXL Component Register shadow gives the VMM access to
the HDM Decoder Capability block so it can intercept decoder commits
without touching the hardware register page directly.

vfio_cxl_derive_hdm_info() walks the CXL Capability Array inside the
Component Register shadow to find the HDM Decoder capability (ID 0x5)
and extracts hdm_decoder_offset and hdm_count. All reads use
le32_to_cpu() since the capability array is little-endian per the CXL
spec.  Dword 0 is the array header; capability entries start at dword 1,
which is why the loop begins at i = 1.

CXL register constants are defined here using names that mirror
<linux/cxl.h> to make cross-referencing straightforward.

Add the VFIOCXL struct embedded in VFIOPCIDevice.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c        | 214 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h        |  14 +++
 hw/vfio/trace-events |   4 +
 3 files changed, 232 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b2a07f6bb4..49ac661eb3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -24,6 +24,7 @@
 
 #include "hw/core/hw-error.h"
 #include "hw/core/iommu.h"
+#include "hw/cxl/cxl_component.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
@@ -2957,6 +2958,38 @@ static VFIODeviceOps vfio_pci_ops = {
     .vfio_load_config = vfio_pci_load_config,
 };
 
+/*
+ * CXL Component Register Space constants (CXL 4.0 8.2.3).
+ */
+
+/* CXL Capability Array Header (dword 0 of COMP_REGS) */
+#define CXL_CM_CAP_HDR_ARRAY_ID         0x0001U /* expected ID value */
+#define CXL_CM_CAP_HDR_NUM_CAPS_SHIFT   24      /* bits [31:24] = num entries */
+#define CXL_CM_CAP_HDR_NUM_CAPS_MASK    0xffU
+#define CXL_CM_CAP_ENTRY_ID_MASK        0xffffU /* bits [15:0] = cap ID */
+#define CXL_CM_CAP_ENTRY_PTR_SHIFT      20      /* bits [31:20] = byte offset */
+#define CXL_CM_CAP_ENTRY_PTR_MASK       0xfffU
+#define CXL_CM_CAP_ID_HDM               0x0005U /* HDM Decoder cap ID */
+
+/* HDM Decoder Capability (HDMC) register at hdm_decoder_offset+0x00 */
+#define CXL_HDMC_DECODER_COUNT_MASK     0xfU    /* bits [3:0]; 0→1, N→N*2 */
+
+/*
+ * Per-decoder register offsets from hdm_decoder_offset (CXL 4.0 Table 8-119).
+ * Decoder records begin at +0x10 and are 0x20 bytes each.
+ */
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)  (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i)      (0x20 * (i) + 0x20)
+
+/* HDM Decoder n Control register bits (CXL 4.0 Table 8-123) */
+#define CXL_HDM_CTRL_COMMIT_LOCK        (1U << 8)  /* decoder locked */
+#define CXL_HDM_CTRL_COMMIT             (1U << 9)  /* software trigger */
+#define CXL_HDM_CTRL_COMMITTED          (1U << 10) /* hardware status */
+
+/* HDM Decoder BASE_LO: bits [31:28] hold address bits [31:28] */
+#define CXL_HDM_BASE_LO_ADDR_MASK       0xF0000000U
+
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3102,6 +3135,25 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
+
+    /*
+     * The DPA region is not in bars[] and must be cleaned up here.
+     * Remove it from the system address space before releasing.
+     */
+    if (vdev->cxl.dpa_in_system_mem) {
+        memory_region_del_subregion(get_system_memory(), vdev->cxl.region.mem);
+        vdev->cxl.dpa_in_system_mem = false;
+        trace_vfio_cxl_put_device(vdev->vbasedev.name);
+    }
+    if (vdev->cxl.region.mem) {
+        vfio_region_exit(&vdev->cxl.region);
+        vfio_region_finalize(&vdev->cxl.region);
+    }
+    if (vdev->cxl.comp_regs_region.mem) {
+        vfio_region_exit(&vdev->cxl.comp_regs_region);
+        vfio_region_finalize(&vdev->cxl.comp_regs_region);
+    }
+
     vfio_cpr_pci_unregister_device(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
@@ -3254,6 +3306,164 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
     }
 }
 
+/*
+ * vfio_cxl_derive_hdm_info - read hdm_decoder_offset and hdm_count from the
+ * COMP_REGS region by traversing the CXL Capability Array.
+ *
+ * Dword 0: CXL Capability Array Header
+ *   bits[31:24] = num_caps,
+ *   bits[15:0]  = 1.
+ * Dwords 1..N:
+ *   bits[15:0]  = cap ID;
+ *   bits[31:20] = byte offset from region start.
+ * HDM Decoder cap ID = 0x5; its offset is hdm_decoder_offset.
+ * HDMC register at hdm_decoder_offset+0:
+ *   bits[3:0] encode count (0→1, N→N*2).
+ */
+static bool vfio_cxl_derive_hdm_info(VFIODevice *vbasedev, VFIOCXL *cxl,
+                                     Error **errp)
+{
+    off_t base = cxl->comp_regs_region.fd_offset;
+    uint32_t hdr, num_caps, i;
+
+    if (pread(vbasedev->fd, &hdr, sizeof(hdr), base) != sizeof(hdr)) {
+        error_setg(errp, "vfio-cxl: failed to read CXL Capability Header");
+        return false;
+    }
+    hdr = le32_to_cpu(hdr);
+
+    if ((hdr & CXL_CM_CAP_ENTRY_ID_MASK) != CXL_CM_CAP_HDR_ARRAY_ID) {
+        error_setg(errp, "vfio-cxl: unexpected CXL Capability Array ID 0x%x",
+                   hdr & CXL_CM_CAP_ENTRY_ID_MASK);
+        return false;
+    }
+
+    num_caps = (hdr >> CXL_CM_CAP_HDR_NUM_CAPS_SHIFT) &
+        CXL_CM_CAP_HDR_NUM_CAPS_MASK;
+
+    /*
+     * Dword 0 is the CXL Capability Array Header;
+     * capability entries start at dword 1.
+     */
+    for (i = 1; i <= num_caps; i++) {
+        uint32_t entry, cap_id;
+
+        if (pread(vbasedev->fd, &entry, sizeof(entry),
+                  base + i * sizeof(entry)) != sizeof(entry)) {
+            error_setg(errp, "vfio-cxl: failed to read cap entry %u", i);
+            return false;
+        }
+        entry = le32_to_cpu(entry);
+
+        cap_id = entry & CXL_CM_CAP_ENTRY_ID_MASK;
+        if (cap_id == CXL_CM_CAP_ID_HDM) {
+            uint32_t hdmc, field;
+
+            cxl->hdm_decoder_offset = (entry >> CXL_CM_CAP_ENTRY_PTR_SHIFT) &
+                                       CXL_CM_CAP_ENTRY_PTR_MASK;
+
+            if (pread(vbasedev->fd, &hdmc, sizeof(hdmc),
+                      base + cxl->hdm_decoder_offset) != sizeof(hdmc)) {
+                error_setg(errp, "vfio-cxl: failed to read HDMC register");
+                return false;
+            }
+            hdmc = le32_to_cpu(hdmc);
+            field = hdmc & CXL_HDMC_DECODER_COUNT_MASK;
+            cxl->hdm_count = field ? (uint8_t)(field * 2) : 1;
+            return true;
+        }
+    }
+
+    error_setg(errp, "vfio-cxl: HDM Decoder capability not found in COMP_REGS");
+    return false;
+}
+
+static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    VFIOCXL *cxl = &vdev->cxl;
+    g_autofree struct vfio_device_info *info = NULL;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_cxl *cap;
+    g_autofree struct vfio_region_info *region_info = NULL;
+    g_autofree struct vfio_region_info *comp_info = NULL;
+    int ret;
+
+    if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_CXL)) {
+        return true;
+    }
+
+    info = vfio_get_device_info(vbasedev->fd);
+    if (!info) {
+        error_setg(errp, "vfio-cxl: failed to get device info");
+        return false;
+    }
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_CXL);
+    if (!hdr) {
+        error_setg(errp, "vfio-cxl: CXL capability not found in device info");
+        return false;
+    }
+    cap = (void *)hdr;
+
+    if (cap->dpa_region_index == (uint32_t)-1 ||
+        cap->comp_regs_region_index == (uint32_t)-1) {
+        error_setg(errp, "vfio-cxl: kernel did not provide region indices "
+                   "(dpa=%u comp=%u)",
+                   cap->dpa_region_index, cap->comp_regs_region_index);
+        return false;
+    }
+
+    cxl->hdm_regs_bar_index = cap->hdm_regs_bar_index;
+    cxl->hdm_regs_offset    = cap->hdm_regs_offset;
+
+    /* DPA region */
+    ret = vfio_device_get_region_info(vbasedev, cap->dpa_region_index,
+                                      &region_info);
+    if (ret || !region_info) {
+        error_setg(errp, "vfio-cxl: failed to get DPA region info");
+        return false;
+    }
+    ret = vfio_region_setup(OBJECT(vdev), vbasedev, &cxl->region,
+                            region_info->index, "cxl-dpa", errp);
+    if (ret) {
+        error_setg(errp, "vfio-cxl: failed to set up DPA region");
+        return false;
+    }
+    cxl->dpa_size = region_info->size;
+
+    if (vfio_region_mmap(&cxl->region)) {
+        error_setg(errp, "vfio-cxl: failed to mmap DPA region for %s",
+                   vbasedev->name);
+        return false;
+    }
+
+    /* COMP_REGS region (HDM decoder shadow) */
+    ret = vfio_device_get_region_info(vbasedev, cap->comp_regs_region_index,
+                                      &comp_info);
+    if (ret || !comp_info) {
+        error_setg(errp, "vfio-cxl: failed to get COMP_REGS region info");
+        return false;
+    }
+    ret = vfio_region_setup(OBJECT(vdev), vbasedev, &cxl->comp_regs_region,
+                            comp_info->index, "cxl-comp-regs", errp);
+    if (ret) {
+        error_setg(errp, "vfio-cxl: failed to set up COMP_REGS region");
+        return false;
+    }
+    cxl->hdm_regs_size = comp_info->size;
+
+    if (!vfio_cxl_derive_hdm_info(vbasedev, cxl, errp)) {
+        return false;
+    }
+
+    trace_vfio_cxl_setup_params(vbasedev->name, cxl->hdm_regs_bar_index,
+                                 cxl->hdm_regs_offset, cxl->hdm_regs_size,
+                                 cxl->dpa_size);
+    return true;
+}
+
+
 static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
@@ -3508,6 +3718,10 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    if (!vfio_cxl_setup(vdev, errp)) {
+        goto error;
+    }
+
     if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..f3906f0c53 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -122,6 +122,19 @@ typedef struct VFIOMSIXInfo {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)
 
+typedef struct VFIOCXL {
+    uint8_t  hdm_regs_bar_index;
+    uint64_t hdm_regs_offset;
+    uint64_t hdm_regs_size;
+    uint64_t hdm_decoder_offset;
+    uint8_t  hdm_count;
+    uint64_t dpa_size;
+    hwaddr   fmws_base;         /* GPA base programmed into HDM decoder 0 */
+    bool     dpa_in_system_mem;
+    VFIORegion region;
+    VFIORegion comp_regs_region;
+} VFIOCXL;
+
 struct VFIOPCIDevice {
     PCIDevice parent_obj;
 
@@ -191,6 +204,7 @@ struct VFIOPCIDevice {
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
+    VFIOCXL    cxl;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 846e3625c5..3678481a8e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -197,3 +197,7 @@ vfio_device_get_region_info_type(const char *name, int index, uint32_t type, uin
 vfio_device_reset_handler(void) ""
 vfio_device_attach(const char *name, int group_id) " (%s) group %d"
 vfio_device_detach(const char *name, int group_id) " (%s) group %d"
+
+# pci.c CXL Type-2 passthrough
+vfio_cxl_setup_params(const char *name, uint8_t bar, uint64_t hdm_off, uint64_t hdm_sz, uint64_t dpa_sz) " (%s) hdm_bar=%u hdm_regs_offset=0x%"PRIx64" hdm_regs_size=0x%"PRIx64" dpa_size=0x%"PRIx64
+vfio_cxl_put_device(const char *name) " (%s) removing DPA region from system memory"
-- 
2.25.1

