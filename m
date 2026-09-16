Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB94EC645
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584342; cv=fail; b=dIiJNx7jrTT025J/CYfWJqAB66vVnMAPQUNJSNKEEC7XHB9RlgBvTrte6KpcTFAl36BJNZEVmjDmfoY0cjJ3dejyEMcSjUAS9wVr1avn2TXH80MOaDxkpwY0MZAZDdXuK/7AS4+XjMqhAA0p4h2jXPK1m2XUypmj57Pl+SL8FTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584342; c=relaxed/simple;
	bh=IoDhgFrRwVqLFfH0U+BNS6e9+OyMFHyxmnh/WjrIEXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVd6Wva7bams662yRKcyVUe0LV1xGq3Dsq8197qI8AVBgSAKpKwYuZmAbqZ4xXX4WUc7IcqT2SULDRd9p7qf7Kl1xo1HKr9aYxsVFTCQzNVhVLvTxPhGCIzgbfGkaxqyrBwjCPEE/YZbPXaARYZ06VN8fYUeAAXlH1g+1Jb3YEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sGcoi6/T; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sGcoi6/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZBI/glWqAZ+Hwhq8wNDSmdtXar7pi+w5RPDiYMYX2878r3qStj77cDfH2CjCQThSSi0zslMpHeFez+0BJAONXuYzA21CXeBX3duwm7163qsQ2Cne16DZw/XHw5IYZ5de+tn5oCLwsswjPwmxZoRFEFdpT5+B/Uk5YVrEmiN2mGhHpaFY5pdkXLFcyOLae9vjwWE76r/iRDZ46dnvg4ah9dqHkQjwhTlNRBdYk9RL581KCf7hONPIy2J65Nk8NHMQabUcYnwa7moz7/TIxfYwHbBStWL7Q2203v4hyOwkrs7wbKBHpzxO7hkjSdOcOj7GIJPvZoG3hbv1bWNZUlZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry9lAiW4f8vsybG1loV/ntQraEUHcK3UGNVkrGpILeQ=;
 b=HSwYd8dBXcGuFcWpvr8uHRGH4UJISkl/S85aeVn7AKh+kfmS+62K5TQCadD3mgpqsmfKNoYJJ0pCL32a9sYygN26DaJbd30lVUtJJ9HVf5IZ0AVjMeDGML71W5HqdSurL7MQG84iDVd+sj1p8SYKtf/Tp6V52bdqvKV4qCHqleolluKQd7ztGP7czlQzXHj6H9sPPIuFN+qblrQG0tf87FTp8VVmT1eFNZCVn3oZHQ5AiK0HV1BxiCyG2VHJs38PodNVtFW4X2cLW49lwAfBjaaxvRzxhByG9bGy6WaawbIgZmHHeh6Yj7jPT2xYyKikGWRFtrJbZH6fmWauTtgWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry9lAiW4f8vsybG1loV/ntQraEUHcK3UGNVkrGpILeQ=;
 b=sGcoi6/TPXyF7J3DOBT69eaW/gURrX1kVBiLLofhYwjVOWr1ecT31w3lZarQg+3q1Hce/Ukicc8mgpb/jvuy3mlgKPgk+g73UXVKVikTAD8N+gLPwDcIQQ/GKNySCnS7yaE+RzsTRv5seMt6PXozcaj9Tw4UUCg/P6e5H25YO/ao/Affc29OymbyAsWF7YV6VQx9rvQvwKGcCVqpnmLT+33o/XmXeS594SAtwxCp4G9m+ZY+6h8k1Z4YVQDycpzUOZ/WwNjGjkw7WaE1zx+5l+v0vbmbGNh+PTuG11a89Uhou6Q3Af+29XI7xpxyNP7fyUW5flmX/Z+U/JjK33JAZw==
Received: from CH0P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::8)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:45:16 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::66) by CH0P223CA0022.outlook.office365.com
 (2603:10b6:610:116::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:44:54 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:44:47 -0700
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
Subject: [PATCH v2 03/10] hw/vfio/pci: Detect a CXL Type-2 device and read its geometry
Date: Thu, 17 Sep 2026 00:14:05 +0530
Message-ID: <20260916184412.3825713-4-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|SAWPR12MB999140:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0b218d-40d8-43b5-e7a5-08df1422a60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|7416014|23010399003|6133799003|18002099003|22082099003|921020|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dleiqeYH9aALuF/fXCoF+Jj5cKgl/BLPsgs7v4jOtTLCecaZ/f/dfpVxMXkIxTbnn370a1c9SYydjnaoHulDWl934HjDBFMwNOCwz+5Zyg47UmJUl3/pTINkRGpaerpeamCH+cruLrpOXnv3O6u117lCt069136sT9lZHpe0WNwWnaH5e4Zs/dCURvIGTRmu02+I97l8Q9wQRs/5Z4+vTKMHNbKOIiL2j93AgHcetPHAi8ilbHreEAClXksLkfFprl+SarG6bZRFqipSyhgOSdFRawXa6vdDK6J1FK5mc1iexNRRZhxP8mMLDhVjyGIaSGHDjExco4SU6RKu9FSxZhV6DRqJ0KIxbA/Gk2DB8It0Or/hXSLORH+kK7fdcSgeJ38cdj3UzMV30f4pA6gCUzp/5IqqrQqlLbZpwTIdloNUF4IgXMbPngyMcSyPXK+BIAJtNtXlUzo89ihOQzAWBbPRb9Bovc4eR96b5yUYMn1v23AZilN9HQmrn4aYGUKfbk9QqA77LbaBAg1hms2HWgxPcFOPLptVw8VXjymxi9gHEIsbuW9mNMUinbexLMBGzwtu70sp4mu1cB8E4KC9YplSx8ULvFHWAqHMH5SxNAv6PfXaPXIBLztLaNSMAplWgpxjATCgBle11SKbaJHGqCma1VMAoTKif7xCiwn56TrD7yOEum3v7lwwyrXlopMdQrhbhWYA4eMern0FQMNoYho5qg5nOmBXLNQjiVwcoasGvqOgru/yS9nxAoibQZa2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	154fN4nSHy5Rqpm6i3Is7VKW5SKaDz6KstaQhlxqQRveqeor+l7NONbGWoDG32KKm9gAZFRNPqdJul2avtY75LBtCjiStscytG3wpAWF2QxhGrutSfjDhNPF4GceBXYjbq6+D5r3jItMsVzX/RcE2rWqrpSENH7HUvEoYAm5C12noiz/3h7QUMhmTMROa6ORZLpbaKYPK1WzG3GH5nHDbEDTaLL3lhOnbH7iIr6qgo3ZhjLqmHspNZbjtaEjCL/atxhK3eaUrvUXXA+ksNTCpSqC58Wm844tWQZv05G0Irp6wOdRNoGTnzJRui7TPZqEuBlAT8D5l+3CYeFMVQwgYCeIPjTna3P7Z8LsNI8P65upaHEE7HHd2xUYFGu0suX/U1/NaWJBewVh/nQDsDCinRiX6zPRYIhsMYToaM6I129gFmpaCbAC46CD3IiDpaxd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:15.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0b218d-40d8-43b5-e7a5-08df1422a60a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140

From: Manish Honap <mhonap@nvidia.com>

The kernel marks a passthroughed CXL Type-2 device with a device flag and
exposes two regions:
- HDM memory (host physical)
- the trapped HDM decoder register block.

Read the flag, locate both regions by type, and take the component BAR
and block offset from the geometry capability. Realize only records this;
later patches build the guest mapping on top.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h | 15 +++++++++++
 2 files changed, 87 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f069..2f84af5cf8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3570,6 +3570,64 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
+ * and the trapped HDM decoder block (which BAR carries it and at what offset).
+ * A non-CXL device leaves cxl.enabled false and takes no CXL paths.
+ */
+static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    VFIOCXL *cxl = &vdev->cxl;
+    struct vfio_region_info *mem_info = NULL, *comp_info = NULL;
+    struct vfio_region_info_cap_cxl_comp_regs *cap;
+    struct vfio_info_cap_header *hdr;
+
+    if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_CXL)) {
+        return true;
+    }
+
+    if (vfio_device_get_region_info_type(vbasedev,
+                                         VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+                                         CXL_VENDOR_ID,
+                                         VFIO_REGION_SUBTYPE_CXL_MEM,
+                                         &mem_info)) {
+        error_setg(errp, "vfio-cxl: %s: CXL memory region not found",
+                   vbasedev->name);
+        return false;
+    }
+
+    if (vfio_device_get_region_info_type(vbasedev,
+                                         VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
+                                         CXL_VENDOR_ID,
+                                         VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
+                                         &comp_info)) {
+        error_setg(errp,
+                   "vfio-cxl: %s: CXL component-register region not found",
+                   vbasedev->name);
+        return false;
+    }
+
+    hdr = vfio_get_region_info_cap(comp_info,
+                                   VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
+    if (!hdr) {
+        error_setg(errp,
+                   "vfio-cxl: %s: component-register geometry not reported",
+                   vbasedev->name);
+        return false;
+    }
+    cap = container_of(hdr, struct vfio_region_info_cap_cxl_comp_regs, header);
+
+    cxl->mem_region_index = mem_info->index;
+    cxl->comp_regs_region_index = comp_info->index;
+    cxl->dpa_size = mem_info->size;
+    cxl->comp_bar = cap->bar;
+    cxl->hdm_offset = cap->offset;
+    cxl->enabled = true;
+
+    return true;
+}
+
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
@@ -3700,6 +3758,20 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (!vfio_cxl_setup(vdev, errp)) {
+        /*
+         * vfio_migration_realize() above installed a migration blocker in auto
+         * mode (generic vfio-pci exposes no migration ops). out_deregister does
+         * not remove it, so a rejected CXL setup would leave VM migration
+         * blocked until QEMU restarts. Drop it here, under the same
+         * failover-pair condition used to install it.
+         */
+        if (!pdev->failover_pair_id) {
+            vfio_migration_exit(vbasedev);
+        }
+        goto out_deregister;
+    }
+
     vfio_pci_register_err_notifier(vdev);
     vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c9ab949870..7fdd695704 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -122,10 +122,25 @@ typedef struct VFIOMSIXInfo {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)
 
+/*
+ * State for a CXL Type-2 device. The kernel owns the host physical placement
+ * of the device memory; QEMU only maps it at the guest physical address the
+ * guest commits into its endpoint HDM decoder.
+ */
+typedef struct VFIOCXL {
+    bool enabled;
+    uint32_t mem_region_index;       /* HPA-backed HDM memory VFIO region */
+    uint32_t comp_regs_region_index; /* trapped HDM decoder register block */
+    uint32_t comp_bar;               /* component BAR carrying that block */
+    uint64_t hdm_offset;             /* block offset within the component BAR */
+    uint64_t dpa_size;               /* size of the HDM memory region */
+} VFIOCXL;
+
 struct VFIOPCIDevice {
     PCIDevice parent_obj;
 
     VFIODevice vbasedev;
+    VFIOCXL cxl;
     VFIOINTx intx;
     unsigned int config_size;
     uint8_t *emulated_config_bits; /* QEMU emulated bits, little-endian */
-- 
2.25.1

