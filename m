Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90274D5988
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584384; cv=fail; b=jdca4B+OeclO5R7pgdCOdTkjQ0RbP3TcTomrtrpvIozEyry+oZ1edQvtj6zdPh9oidbKcn+WeC8zU9ThdIEcPm3BrcY0E/VuftORnBcu3EvBDdsD5XbeD+B/8pCL5Ng5bUNwTUl/XyMOX+mtmUo7e8iNh/IHRz4WjNcADbzqWQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584384; c=relaxed/simple;
	bh=/9FRwydsXzFkhvCtStPP4inkkdkknTT0qQWWuR2qrL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp34TtnQElLF0YcqfhxqYIwTSRFMdUiOf1a1GItltkfibC529BQNn+6BVcmYJDQwpk6p9b3gvy2v/fLv/yLAAhtzIauyNxawcpC96LGHT6esXVy42ZNveudXUjerp0WFHfHlw1vvZps5vHLp96dp0EaNC4mRFSjJELC5xlqYbhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LYTJPRVk; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LYTJPRVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSiZtoM1P84oZqk+7T3m3Bs/zBTM88Xf8R4victRbQbv4MX/AGmywpxTCvaFqEIKmv4ve9DSQMxHCNB1gVeFjfdEdRn5I2oSfjfvG/M785n40DChpPVke+96B8TsW11PaRmjpII45o249qa82wLZqsadmo0Idq4bnJqblghiLkYlYbGBEG8TIZssyQ5A+xa2n74oewY7Fbs77K+OmNFYQDP1CSMPyZ+zCgaSCvPo4J0MA51+UbLw5OK+F2Mlr/uPKr/iJKD/lWbQYhH1ZAG1VLgQ0Xm5wnpgr6TvVLTylNkcPrZLz74f1EH2bZOENrODppaVqlxX9CqhcWC6UWmanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRutuAjgSomzN2nukF0TJ8K+yYdmH6li967Dg8+8AXs=;
 b=JeS91Lh/Gs8KbcHywegogh58PginfxrGGpMNXl66NIWALaBpaXP92JMq8obCwIesK5jS4cZ1Lf8MZQKCRJRMz+qpUOdPf5ZtBYoRnTWoQ1Ko9mrUxYTSM07hu49tt8hDO732xyCJ8K7MCySS173mwbhwLmpPYi5nJI7M/aA+zZLpZPgnMCtN0gGPhWO4bxOfR2ZrnTl6tkXZqRV6rGoSNcgVmXpueCa4wpDlWw8DBNSeyxWdJ2dtXAgYIBGntQSTI7WrmBnJEzlqteCU2iNyBJJvJsq7G1aBkIFxbLBXFUR54RWI8N8XiiZTjRlmOizgeMstf1faIuJD0ZnaqNyVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRutuAjgSomzN2nukF0TJ8K+yYdmH6li967Dg8+8AXs=;
 b=LYTJPRVkGeoJ23WronGhusLhJ0iGRCtyZfCV+l9HqyV9PHgf41EnRFXUUu6AikapoR8JVsWYJG0hgJgqwbttx5drZN2l6rLJmUdvS5+wwDT9JeB/yLrpjF61l0oQeAwdsv4/27SsrKJhCBcrZmDNPHxq1SWA8rCnt5108dBVIa8dKYnU36HtKFAEDKKYjuM0QXwagxqrQll84195ceHkE6w48L+7ZFBVGFn92hD0+DnA1CtltjW4yOFJlyDUwTSIl+/LKGQCg6Gy5bj86ORv/CD/mmCdFfgvznT807y9YaPk2qfhBMjg6uVsRJuOxpuqEJTWbV0Ue/znwwsaTGwBGg==
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:45:49 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::26) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:23 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:45:15 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the guest decoder commit
Date: Thu, 17 Sep 2026 00:14:09 +0530
Message-ID: <20260916184412.3825713-8-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916184412.3825713-1-mhonap@nvidia.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 660d8f6b-b17d-4c9e-6962-08df1422b9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|1800799024|376014|82310400026|921020|11063799006|56012099006|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KdIb6iQrwSTC4JMcK0x3A4lFBsoX7U2VO8qwQW1X2VxJ4oo2euSNZdfnRmIe4fLy3P8RFoyQ1D+doOMsZ2sHZqRdIg2QY2g+q1Uu/Mamb403P8nr2unXacx884k4hMMOy2GjtXQ2QCyM+aU4a4C2TshY0/pDxz7TboeL009LwkhsNj/EpNTl10G7hqfdr/NAeellG9OMgf+tfSdA40oZ2sP22IzO4HG2Z/b8+WjTAF3jJcPfLIn5kCw85WJ8ghtBVPdnS9Ri/JSXVwkYebtnyO9moTKGz0TDMcLfoVY5UQhz9UNm6H04eYaQmLkrUVJsmwR5LLAjmqR7BEfB5wmrPZXh5oSEQj7PSJ8CaMOUERE5YugaXKE7NeNpr2POvsPu+Qg5DKTOmNJEK5w90zG4KlL+0ji/cW5QD5RXqTVhhy/+J8rKo3bus/vgAXYrumQBciF/zUGDS6cGXiGxui/+aDNwOz8/ocbLD+SfUZAjc5eHuYYFjW744Ja5PyZayKHYjJp+Ii6M3Zx9unS26LrpsFNsuinXHi76ThInZNAzjPYmleTUCQtgeNCJvW+kRXjECez2Y6TZqpruR2vnEheoanWOgbHUC5F5PJf11X3umzPdMSaZHWoIgInmimc6hVGJWlIA6ONgfKIib4tucMIf6Kd+4D0VIhkOKCBUJwZjOKK3q5Jg/IBOcbi+GCQ33ugExqxam1qWOOKV7RXNEjw0BHrRUx3XMcJwaeOfcsgG4xR9EegteE7aM3lWgsJnnHfI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(1800799024)(376014)(82310400026)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6GM7hLK7I0Rvpu4SDo8/1OSCsvzE2noVbesqChi8V/T/Vb8+1ANiisxmXMmemh/FWjs8SO1D0H28g/Z/Ujhtw3k/ZUweJEQOzoEvonOxKyOuLtfVSwvLUU74v+l6IZCHVnFqkh9HJzhxvQ1ALd29BkzSEsuRwmaOi4zJtTf1omvVWyZIXbl4IKrvacHN6Qpkaa+YWvYt6ZCsZ98sRCyg6Jiq1G58QM3Z1WI7XmWPlxTd9USLHv2O8+S+XpvMmqv1+VMvGRC41PtVG63EBPf4EQ7/HSbMl+1zBCuBuT2YuBLJ5VEyBqUFa0Owj91zxvQR90tN+K3GLcfzrWuE7oUCK67Wd2tJ7M1Qp2o1d/tNBVdYOw3aAWhTdfWMcOTBfdcQdTTC9soK2arBbzHMysHF9b51CdDen1AEr5zuaZ6yU29cZayhCcQdfqkZqn1tpDAv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:48.7884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660d8f6b-b17d-4c9e-6962-08df1422b9d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

From: Manish Honap <mhonap@nvidia.com>

Overlay the trapped HDM decoder block over the component BAR and forward
its accesses to the kernel. QEMU maps the HDM memory at the base of the
device's CFMWS window and presents that same base back to the guest
through the trapped decoder read

Overlap the CFMWS window MemoryRegion the CXL host bridge maps at that
base, at a higher priority, so precedence is defined by priority rather
than subregion insertion order.

QEMU always maps at the CFMWS base, so a decoder the guest commits at any
other base would leave the guest's view and the mapping diverged. Track
the base the guest writes to the trapped block and refuse to map a commit
at a different base; a firmware-committed decoder the guest never
reprograms keeps the window base.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-host-stubs.c |   5 +
 hw/vfio/pci.c           | 386 +++++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.h           |   8 +
 3 files changed, 393 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index 9b515913ea..1067c944e2 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -23,3 +23,8 @@ GSList *cxl_fmws_get_all_sorted(void)
 {
     g_assert_not_reached();
 }
+
+int cxl_decoder_count_dec(int enc_cnt)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 670e0d1da4..fb3c39d4c6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1453,6 +1453,39 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     return val;
 }
 
+static void vfio_cxl_decoder_changed(VFIOPCIDevice *vdev);
+static void vfio_cxl_unmap_mem(VFIOPCIDevice *vdev);
+
+/*
+ * Return true if this config write sets a Function Level Reset bit the kernel
+ * acts on: the PCIe Device Control FLR bit or the Advanced Features FLR bit.
+ * FLR bits are write-1-to-trigger and self-clearing, so inspect the written
+ * value rather than the post-write config.
+ */
+static bool vfio_cxl_flr_write(VFIOPCIDevice *vdev, uint32_t addr,
+                               uint32_t val, int len)
+{
+    PCIDevice *pdev = &vdev->parent_obj;
+    uint32_t off;
+
+    if (pdev->exp.exp_cap) {
+        /* PCI_EXP_DEVCTL_BCR_FLR (bit 15) is the high byte of Device Ctrl. */
+        off = pdev->exp.exp_cap + PCI_EXP_DEVCTL + 1;
+        if (off >= addr && off < addr + len &&
+            ((val >> (8 * (off - addr))) & (PCI_EXP_DEVCTL_BCR_FLR >> 8))) {
+            return true;
+        }
+    }
+    if (vdev->cxl.af_offset) {
+        off = vdev->cxl.af_offset + PCI_AF_CTRL;
+        if (off >= addr && off < addr + len &&
+            ((val >> (8 * (off - addr))) & PCI_AF_CTRL_FLR)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
@@ -1522,9 +1555,74 @@ void vfio_pci_write_config(PCIDevice *pdev,
                 vfio_sub_page_bar_update_mapping(pdev, bar);
             }
         }
+
+        /*
+         * A firmware-committed CXL decoder is already committed at boot, so no
+         * guest control write triggers the HDM mapping. Map it once the guest
+         * enables memory decoding, so the region enters the guest address space
+         * and the IOAS while the device is live. On a clear of memory decoding,
+         * withdraw the overlay: the kernel revokes the HDM PTEs on the same
+         * write, so a retained memslot would fault a guest access during the
+         * disabled interval onto a zapped VMA and stop the VM; the enable path
+         * re-maps it.
+         */
+        if (vdev->cxl.enabled &&
+            range_covers_byte(addr, len, PCI_COMMAND)) {
+            if (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY) {
+                vfio_cxl_decoder_changed(vdev);
+            } else {
+                vfio_cxl_unmap_mem(vdev);
+            }
+        }
     } else {
         /* Write everything to QEMU to keep emulated bits correct */
         pci_default_write_config(pdev, addr, val, len);
+
+        /*
+         * A guest CXL reset is a write to the CXL Device DVSEC ctrl2 register,
+         * forwarded to the kernel above, which re-commits this firmware-fixed
+         * decoder. If the guest decommitted the decoder before the reset, which
+         * unmapped the HDM memory, that re-commit is not otherwise visible to
+         * QEMU, so rescan the decoder here to restore the mapping. Gated on
+         * memory decoding still being enabled, like the enable path above.
+         */
+        if (vdev->cxl.enabled && vdev->cxl.dvsec_offset &&
+            ranges_overlap(addr, len,
+                           vdev->cxl.dvsec_offset +
+                               offsetof(CXLDVSECDevice, ctrl2),
+                           sizeof_field(CXLDVSECDevice, ctrl2)) &&
+            (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY)) {
+            vfio_cxl_decoder_changed(vdev);
+        }
+
+        /*
+         * A NoSoftRst- device the guest cycles D3hot->D0 has its physical
+         * decoder restored by the kernel on resume, which re-commits this
+         * firmware-fixed decoder just like a reset. That re-commit is not
+         * otherwise visible to QEMU, so on the transition back to D0 rescan
+         * the decoder to restore a mapping the guest dropped before it
+         * suspended. Gated on memory decoding, like the paths above.
+         */
+        if (vdev->cxl.enabled && pdev->pm_cap &&
+            range_covers_byte(addr, len, pdev->pm_cap + PCI_PM_CTRL) &&
+            (pci_get_word(pdev->config + pdev->pm_cap + PCI_PM_CTRL) &
+             PCI_PM_CTRL_STATE_MASK) == 0 &&
+            (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY)) {
+            vfio_cxl_decoder_changed(vdev);
+        }
+
+        /*
+         * A Function Level Reset the guest triggers through the PCIe Device
+         * Control or Advanced Features FLR bit is forwarded to the kernel,
+         * which re-commits this firmware-fixed decoder just like a CXL reset.
+         * That re-commit is not otherwise visible to QEMU, so rescan the
+         * decoder to restore a mapping the guest dropped before the FLR. Gated
+         * on memory decoding, like the paths above.
+         */
+        if (vdev->cxl.enabled && vfio_cxl_flr_write(vdev, addr, val, len) &&
+            (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY)) {
+            vfio_cxl_decoder_changed(vdev);
+        }
     }
 }
 
@@ -3811,6 +3909,239 @@ static void vfio_cxl_bind_fmws(Notifier *n, void *data)
     }
 }
 
+/*
+ * HDM decoder registers, relative to the trapped decoder block. The block holds
+ * the HDM Decoder Capability register followed by one register set per decoder,
+ * each VFIO_CXL_HDM_DECODER_STRIDE apart, indexed by decoder.
+ */
+#define VFIO_CXL_HDM_CAP                  0x00
+#define VFIO_CXL_HDM_DECODER_STRIDE       0x20
+#define VFIO_CXL_HDM_DECODER_BASE_LOW(n) \
+    (0x10 + (n) * VFIO_CXL_HDM_DECODER_STRIDE)
+#define VFIO_CXL_HDM_DECODER_BASE_HIGH(n) \
+    (0x14 + (n) * VFIO_CXL_HDM_DECODER_STRIDE)
+#define VFIO_CXL_HDM_DECODER_CTRL(n) \
+    (0x20 + (n) * VFIO_CXL_HDM_DECODER_STRIDE)
+#define VFIO_CXL_HDM_CTRL_COMMITTED       (1 << 10)
+#define VFIO_CXL_HDM_BASE_LOW_MASK        0xf0000000U
+
+static void vfio_cxl_unmap_mem(VFIOPCIDevice *vdev)
+{
+    VFIOCXL *cxl = &vdev->cxl;
+
+    if (!cxl->dpa_mapped) {
+        return;
+    }
+    memory_region_del_subregion(get_system_memory(), cxl->mem_region.mem);
+    cxl->dpa_mapped = false;
+    cxl->mapped_base = 0;
+}
+
+/*
+ * The HDM Decoder Capability register encodes the decoder count in its low
+ * nibble (CXL r3.1 8.2.4.20.1, encodings 0h..Ch for 1..32). Decode it with the
+ * shared cxl_decoder_count_dec() helper so the commit handler walks every
+ * decoder rather than assuming decoder 0. An unreadable register or a reserved
+ * encoding (which the helper decodes to 0) is treated as a single decoder.
+ */
+static unsigned vfio_cxl_decoder_count(VFIOPCIDevice *vdev)
+{
+    off_t off = vdev->cxl.comp_regs_region.fd_offset;
+    uint32_t cap = 0;
+    int count;
+
+    if (pread(vdev->vbasedev.fd, &cap, 4, off + VFIO_CXL_HDM_CAP) != 4) {
+        return 1;
+    }
+    count = cxl_decoder_count_dec(le32_to_cpu(cap) & 0xf);
+    return count > 0 ? count : 1;
+}
+
+/*
+ * The guest committed or tore down an endpoint decoder. Walk each decoder in
+ * the trapped HDM block and (un)map the HDM memory at the CFMWS window base,
+ * not the base the guest programmed (see vfio_cxl_comp_regs_read). This
+ * generation commits one non-interleaved decoder, so the walk stops at the
+ * first committed decoder.
+ */
+static void vfio_cxl_decoder_changed(VFIOPCIDevice *vdev)
+{
+    VFIOCXL *cxl = &vdev->cxl;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    off_t off = cxl->comp_regs_region.fd_offset;
+    unsigned n, count = vfio_cxl_decoder_count(vdev);
+
+    for (n = 0; n < count; n++) {
+        uint32_t ctrl = 0;
+
+        if (pread(vbasedev->fd, &ctrl, 4,
+                  off + VFIO_CXL_HDM_DECODER_CTRL(n)) != 4) {
+            return;
+        }
+        if (!(le32_to_cpu(ctrl) & VFIO_CXL_HDM_CTRL_COMMITTED)) {
+            continue;
+        }
+
+        /*
+         * QEMU always maps at the device's CFMWS base and presents that base
+         * back to the guest, so a decoder the guest committed at any other base
+         * would leave the guest's view and the actual mapping diverged. Reject
+         * it rather than silently relocate. A firmware-committed decoder the
+         * guest never reprogrammed (guest_base_written == false) keeps the
+         * CFMWS base.
+         */
+        if (cxl->guest_base_written) {
+            hwaddr guest_base = ((hwaddr)cxl->guest_base_hi << 32) |
+                                cxl->guest_base_lo;
+
+            if (guest_base != cxl->fmws_base) {
+                warn_report("vfio-cxl: %s: guest committed decoder %u at 0x%"
+                            HWADDR_PRIx ", not the CFMWS base 0x%" HWADDR_PRIx
+                            "; not mapping", vbasedev->name, n, guest_base,
+                            cxl->fmws_base);
+                vfio_cxl_unmap_mem(vdev);
+                return;
+            }
+        }
+
+        if (cxl->dpa_mapped && cxl->mapped_base == cxl->fmws_base) {
+            return;
+        }
+        /*
+         * Overlap the CFMWS window MemoryRegion the CXL host bridge already
+         * maps at this base, at a higher priority, so precedence is defined by
+         * priority rather than subregion insertion order.
+         */
+        memory_region_transaction_begin();
+        vfio_cxl_unmap_mem(vdev);
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                            cxl->fmws_base,
+                                            cxl->mem_region.mem, 1);
+        memory_region_transaction_commit();
+        cxl->mapped_base = cxl->fmws_base;
+        cxl->dpa_mapped = true;
+        return;
+    }
+
+    /* No committed decoder in the block: tear down any existing mapping. */
+    vfio_cxl_unmap_mem(vdev);
+}
+
+static uint64_t vfio_cxl_comp_regs_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    VFIOPCIDevice *vdev =
+        container_of(region, VFIOPCIDevice, cxl.comp_regs_region);
+    VFIOCXL *cxl = &vdev->cxl;
+    uint32_t val = 0xffffffff;
+
+    if (pread(vbasedev->fd, &val, size, region->fd_offset + addr) != size) {
+        error_report("vfio-cxl: %s: HDM decoder read at 0x%" HWADDR_PRIx
+                     " failed", vbasedev->name, addr);
+    }
+    val = le32_to_cpu(val);
+
+    /*
+     * The kernel shadow holds the host physical base for a firmware-committed
+     * decoder. Never expose that to the guest: present the guest physical base
+     * QEMU maps the HDM memory at (the device's CFMWS window). Any decoder's
+     * base registers are virtualized; ctrl, size and the capability header pass
+     * through. The base registers repeat every VFIO_CXL_HDM_DECODER_STRIDE.
+     */
+    if (addr >= VFIO_CXL_HDM_DECODER_BASE_LOW(0) &&
+        (addr - VFIO_CXL_HDM_DECODER_BASE_LOW(0)) %
+                VFIO_CXL_HDM_DECODER_STRIDE == 0) {
+        val = (val & ~VFIO_CXL_HDM_BASE_LOW_MASK) |
+              ((uint32_t)cxl->fmws_base & VFIO_CXL_HDM_BASE_LOW_MASK);
+    } else if (addr >= VFIO_CXL_HDM_DECODER_BASE_HIGH(0) &&
+               (addr - VFIO_CXL_HDM_DECODER_BASE_HIGH(0)) %
+                       VFIO_CXL_HDM_DECODER_STRIDE == 0) {
+        val = (uint32_t)(cxl->fmws_base >> 32);
+    }
+
+    return val;
+}
+
+static void vfio_cxl_comp_regs_write(void *opaque, hwaddr addr, uint64_t data,
+                                     unsigned size)
+{
+    VFIORegion *region = opaque;
+    VFIODevice *vbasedev = region->vbasedev;
+    VFIOPCIDevice *vdev =
+        container_of(region, VFIOPCIDevice, cxl.comp_regs_region);
+    uint32_t val = cpu_to_le32((uint32_t)data);
+
+    if (pwrite(vbasedev->fd, &val, size, region->fd_offset + addr) != size) {
+        error_report("vfio-cxl: %s: HDM decoder write at 0x%" HWADDR_PRIx
+                     " failed", vbasedev->name, addr);
+        return;
+    }
+
+    /*
+     * Record the base the guest programs into a decoder so the commit handler
+     * can reject a base other than the device's CFMWS window. The base low
+     * register carries HPA bits [31:28]; the high register carries [63:32].
+     */
+    if (addr >= VFIO_CXL_HDM_DECODER_BASE_LOW(0) &&
+        (addr - VFIO_CXL_HDM_DECODER_BASE_LOW(0)) %
+                VFIO_CXL_HDM_DECODER_STRIDE == 0) {
+        vdev->cxl.guest_base_lo = (uint32_t)data & VFIO_CXL_HDM_BASE_LOW_MASK;
+        vdev->cxl.guest_base_written = true;
+    } else if (addr >= VFIO_CXL_HDM_DECODER_BASE_HIGH(0) &&
+               (addr - VFIO_CXL_HDM_DECODER_BASE_HIGH(0)) %
+                       VFIO_CXL_HDM_DECODER_STRIDE == 0) {
+        vdev->cxl.guest_base_hi = (uint32_t)data;
+        vdev->cxl.guest_base_written = true;
+    }
+
+    /*
+     * The kernel runs the lock-on-commit FSM in the write above, so the
+     * committed state is settled by now; a control write on any decoder can
+     * change the mapping.
+     */
+    if (addr >= VFIO_CXL_HDM_DECODER_CTRL(0) &&
+        (addr - VFIO_CXL_HDM_DECODER_CTRL(0)) %
+        VFIO_CXL_HDM_DECODER_STRIDE == 0) {
+        vfio_cxl_decoder_changed(vdev);
+    }
+}
+
+static const MemoryRegionOps vfio_cxl_comp_regs_ops = {
+    .read = vfio_cxl_comp_regs_read,
+    .write = vfio_cxl_comp_regs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = { .min_access_size = 4, .max_access_size = 4 },
+    .impl = { .min_access_size = 4, .max_access_size = 4 },
+};
+
+/*
+ * Locate the CXL Device DVSEC (CXL r3.1 8.1.3) in config space. The guest
+ * triggers a CXL reset by writing its ctrl2 register; QEMU rescans the decoder
+ * after that write so the HDM mapping is restored (see vfio_pci_write_config).
+ * Returns the DVSEC config offset, or 0 if the device does not expose it.
+ */
+static uint16_t vfio_cxl_find_device_dvsec(PCIDevice *pdev)
+{
+    uint16_t offset;
+
+    for (offset = PCI_CONFIG_SPACE_SIZE; offset;
+         offset = PCI_EXT_CAP_NEXT(pci_get_long(pdev->config + offset))) {
+        uint32_t hdr = pci_get_long(pdev->config + offset);
+
+        if (PCI_EXT_CAP_ID(hdr) == PCI_EXT_CAP_ID_DVSEC &&
+            (pci_get_long(pdev->config + offset + PCI_DVSEC_HEADER1) & 0xffff)
+                == CXL_VENDOR_ID &&
+            pci_get_word(pdev->config + offset + PCI_DVSEC_HEADER2)
+                == PCIE_CXL_DEVICE_DVSEC) {
+            return offset;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
  * and the trapped HDM decoder block (which BAR carries it and at what offset).
@@ -3864,6 +4195,8 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
     cxl->dpa_size = mem_info->size;
     cxl->comp_bar = cap->bar;
     cxl->hdm_offset = cap->offset;
+    cxl->dvsec_offset = vfio_cxl_find_device_dvsec(&vdev->parent_obj);
+    cxl->af_offset = pci_find_capability(&vdev->parent_obj, PCI_CAP_ID_AF);
 
     if (!vfio_cxl_check_topology(vdev, errp)) {
         return false;
@@ -3887,6 +4220,26 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
                     "performance may be slow", vbasedev->name);
     }
 
+    /*
+     * Trap the HDM decoder block: overlay it, priority 1, over the directly
+     * mapped component BAR, so guest decoder accesses reach the kernel FSM and
+     * the commit becomes visible to QEMU.
+     */
+    if (!vdev->bars[cxl->comp_bar].mr) {
+        error_setg(errp, "vfio-cxl: %s: component BAR %u is not present",
+                   vbasedev->name, cxl->comp_bar);
+        goto err;
+    }
+    if (vfio_region_setup_with_ops(OBJECT(vdev), vbasedev,
+                                   &cxl->comp_regs_region,
+                                   cxl->comp_regs_region_index, "cxl-comp-regs",
+                                   &vfio_cxl_comp_regs_ops, errp)) {
+        goto err;
+    }
+    memory_region_add_subregion_overlap(vdev->bars[cxl->comp_bar].mr,
+                                        cxl->hdm_offset,
+                                        cxl->comp_regs_region.mem, 1);
+
     if (DEVICE(vdev)->hotplugged) {
         /*
          * The machine is already up, so the CFMWS windows are placed and the
@@ -3894,9 +4247,7 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
          * device_add fails cleanly instead of aborting the running VM.
          */
         if (!vfio_cxl_do_bind_fmws(vdev, errp)) {
-            vfio_region_exit(&cxl->mem_region);
-            vfio_region_finalize(&cxl->mem_region);
-            return false;
+            goto err;
         }
     } else {
         cxl->machine_done.notify = vfio_cxl_bind_fmws;
@@ -3906,6 +4257,10 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
     cxl->enabled = true;
 
     return true;
+
+err:
+    vfio_cxl_teardown(vdev);
+    return false;
 }
 
 static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
@@ -3916,15 +4271,26 @@ static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (cxl->machine_done.notify) {
-        qemu_remove_machine_init_done_notifier(&cxl->machine_done);
-        cxl->machine_done.notify = NULL;
+    if (cxl->comp_regs_region.mem) {
+        if (vdev->bars[cxl->comp_bar].mr) {
+            memory_region_del_subregion(vdev->bars[cxl->comp_bar].mr,
+                                        cxl->comp_regs_region.mem);
+        }
+        vfio_region_exit(&cxl->comp_regs_region);
+        vfio_region_finalize(&cxl->comp_regs_region);
     }
 
+    vfio_cxl_unmap_mem(vdev);
+
     if (cxl->mem_region.mem) {
         vfio_region_exit(&cxl->mem_region);
         vfio_region_finalize(&cxl->mem_region);
     }
+
+    if (cxl->machine_done.notify) {
+        qemu_remove_machine_init_done_notifier(&cxl->machine_done);
+        cxl->machine_done.notify = NULL;
+    }
 }
 
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
@@ -4127,6 +4493,14 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_pci_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
     vfio_pci_bars_exit(vdev);
+    /*
+     * The committed HDM overlay is a subregion of system memory owned by this
+     * device, so it holds a reference that would keep the object alive past
+     * unrealize and block instance_finalize (where vfio_cxl_teardown otherwise
+     * runs). Drop it here; the call is idempotent for a device that never
+     * mapped or is not CXL.
+     */
+    vfio_cxl_unmap_mem(vdev);
     vfio_migration_exit(vbasedev);
     if (!vbasedev->mdev) {
         pci_device_unset_iommu_device(pdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 22fe8d7ff7..5bfa976112 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -133,11 +133,19 @@ typedef struct VFIOCXL {
     uint32_t comp_regs_region_index; /* trapped HDM decoder register block */
     uint32_t comp_bar;               /* component BAR carrying that block */
     uint64_t hdm_offset;             /* block offset within the component BAR */
+    uint16_t dvsec_offset;           /* CXL Device DVSEC offset, 0 if none */
+    uint16_t af_offset;              /* PCI Advanced Features cap, 0 if none */
     uint64_t dpa_size;               /* size of the HDM memory region */
     VFIORegion mem_region;           /* HDM memory, mapped at committed GPA */
     Notifier machine_done;           /* CFMWS validated at machine_done */
     hwaddr fmws_base;                /* base of the memory window */
     uint64_t fmws_size;              /* size of the memory window */
+    VFIORegion comp_regs_region;     /* trapped HDM decoder block */
+    hwaddr mapped_base;              /* GPA the HDM memory is mapped at */
+    bool dpa_mapped;                 /* HDM memory currently in system memory */
+    uint32_t guest_base_lo;          /* decoder base low the guest wrote */
+    uint32_t guest_base_hi;          /* decoder base high the guest wrote */
+    bool guest_base_written;         /* the guest wrote a decoder base */
 } VFIOCXL;
 
 struct VFIOPCIDevice {
-- 
2.25.1

