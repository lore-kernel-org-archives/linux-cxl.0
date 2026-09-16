Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2594D5998
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584368; cv=fail; b=WfXN2KjlnSj97O1/8OobZBALUzsgepjwvJ3VkaauFB4v5MUfchzTLfIPz0yDyItsaXd5RcLjx9pxGa7sTFRlbGzjjEbLZFHDumUg8ASxvcyWVpUdPJS54U/h1oJDQ2mtpavSkFyOzZqtY1OPzooeRMHBeJCboFdq2d4DoeZTn8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584368; c=relaxed/simple;
	bh=Ce4tPErwovo+UzvzXvxCvgnDRhFmWgn/urz7ZuwTuhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcMfx0689r5YcgKxj3uGviit3ooLnJutbsy+j5M+BxBOS5Yp8/5BqiDFCUdRds3wS4q/HM//F+RZiEzDGuZxZeLKwXN8A5Juxwfe9ZbBuLJEz9itth9PiE3XLV0OyPsq/7FRO7sOIjXoEjaAnSL2mjK5gNwZHYPQRpbYuzZs/cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jG2FVHZ8; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jG2FVHZ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFoE5rbrGeb0K4B6BVWPSBwxPN42WI89eaE/X2QnT+WmIL5ZTua3gSGaHM8mB4bG09jGhNL0ze1RZylcIOkAtTYiM8RCigfaksFBf5SKZAPQOb0/b41H9snS5WIBKvjP0LMUaADp/PvJScOvJM2ceKih6zk8oDlBmnxR7b4HLYjUEcvv0z1R49mpS4aoROpUqlV5GdymZiOXICcHPCAVU+UuJpghCzG8Y5Kc4uLNci4nIsefVk68sX7dEzTUjvuYv2G0lzPGIKmmZfhshacLOkHXdlKyggaiIntQzZmNyuALTkCk9qEEP+8Kej64B9e0LMF/qj9hwjg79Vv35MzKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Ytff3I87tMAQBB1h9bJsCipx0IG6OvspiOISzTm98=;
 b=QXhkuGE9I//Ov6bWZfhvTh7yAzbwWu0NeGNZDL+zzyb2WN1WOTFNv1Avgl3D0vJYPz1A6bPt88KEZTF57A8LT5qV5UM60JfX5Vq1K0vc6AmefKKzfGz61514d7CWex8MgjFm3Asr3Wqofg205iZXt/DN9B8SJrNqaEZnJfrSwmP+ElUmkqDeO6wiTJCKM2dNes2ZWvIkULdFQleieXcw0AGpGxqRzJ+8kPk6bN0WVVOxWnGzL9b2E17Y7PzI64KM5pynywM3NtYbmfsR4jhQ6TtMskmlUnZYI7u1fntIVLOrzn9RX57DGhIh+LtJWi6wlxfZuPZK+MgAcZEqLGftVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/Ytff3I87tMAQBB1h9bJsCipx0IG6OvspiOISzTm98=;
 b=jG2FVHZ8XkC/S03YFbdX9kmTZPO7wZr7Vs64cLki6kZjr5nafLFt5dyuFtBYsoepeHpvE7OchrCiWTD+HvvxN2xmGe6L9Ye/JrfLOwmvoBhP7/qsKFP+muJL3u7H77Rdcmik+kN+Lf/pnjOcZV6+jOvLziKj8dARz++uGaUXHGOF2hfX00bBFuCcH+pRde5W5UX0MxWupK0bXyG4vaWNT/hLAd+l3n4khqO8SHqN1OA87ettsD950oY9iOk9dvqr4KFUO9qs66vYJ6DsnN4/AQZ0No2XFDnlzsOpOF05c2FgoN/1zczFVZOOpMCsyFJdK5pya0XIwTkZfA5E+cmVEg==
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 16 Sep
 2026 18:45:38 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::8a) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 18:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:08 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:45:01 -0700
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
Subject: [PATCH v2 05/10] hw/vfio/pci: Back the CXL memory with a RAM-device region
Date: Thu, 17 Sep 2026 00:14:07 +0530
Message-ID: <20260916184412.3825713-6-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 050f17fd-208c-45b2-e2c1-08df1422b2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|7416014|921020|10067099003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	aVnS7wdOD7pNWP6nG2wAJG0Inn/tlUWpHJEMma5BnVFjAePhtsVRZxj8k8VobdWghsE6fOE3KGETS9PMVKRlMtW8O3T7d8q5Z00e/Gj8VQbcRkY/BgFC32UYfcFVNspMoSporHzc+kpjvjh4V/4ubFrdPme9ZXt+glnSIHyyns54xVn7gufSLGhEaZmZfEUTmdXik8bXiFHwRYcObm6Y5+A4jJIRWZnWx5hdklShUzOpzJ3w6MOo84s5XJtEC28fbtHtrNO2XoWGI1O9J+4Y78LqmbmshpLK4RCWoSnpKd0vfeHrcL4t2roo1MonDJvn5buIP+aIyQfjnO9p+mXqc4SUtKZndUg5QqjcG9i9Fa1YoBBrnVBbb2Y2AP1QSV4hHtaskwOTuEJFHm6PORtsISB5xz2/WyaxolAkVS6lvgJR4ETvTmDG2o3j9VvXYxHOb93QY2Fkw1OGAMM7nDoelJVp7IVM4YzLFOV3J5A/KZ3y5hBWcpKzMENyvbu4bolSCdTmZi02FOWnlJkrTD2WeQ2dgs8jMmKIoZXEnBchR3/cETU4EwoJHgmJAJrtZ7XCjBWmwQawjync6x9hfSG0i2rqVfWu4Y6sMnxX4D71yumCl6/vQ6mIlIxMOC+szntIGjiON/E8iHlXL/7HJcRm5Ida1+6IB8aiOPkIRGRoKNL8xdypS9x6DFBcVOfFsP+5lUwaWN8uA43YOlZXRq8xlfOJHaAtxZSqpggdXKmowfP+TrWfs+c9OmxmhTmqBDqS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(7416014)(921020)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KKVKOpNF3HqBQWwIdpyS6DBkybJ2E4kQnXjKhsmSttPBF/MSEDuX+GHoNdcAmzx+6DQ6U5PdMx2ooKkUsDNW9+nFfJ0ap6+4VREB7nsWP5kFNXIVMW068os8BsT8W2bPLugLf6ITi0qfNsW3/vWB10Hix1zg5vpJVgE2xvVuy/Fa53dlTDYKgtAFU9aC/fLHTGzhsU8/BaE2NkS0v57DDqDVcLNlihzFldsStLVMyUswSqRnR1GgKvDPn8g9SS/5s0AoQxy/CpEAlO2wVTtkkEGBDBEqfa0Olxf+5wJHNH8YFgDRtQGXazwVMmeO5yKTsn1EasI8+xLo81XmCpWIOChlKHpTnd54KfJ09uODdPKsEQRBRMd/C1kmnXfSxPsJxqh3NL/Sp1+SUaFGiC81RHsZV3aqS/KBBZ70Pr/kmmQ3aVKC1Er0pyV8OOi6CPos
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:36.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050f17fd-208c-45b2-e2c1-08df1422b2a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

From: Manish Honap <mhonap@nvidia.com>

mmap the kernel's HDM memory region so its host physical pages back a
RAM-device MemoryRegion. It stays out of the guest address space until
the guest commits its decoder and QEMU learns the GPA to place it at.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c | 34 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 10b13f200d..4716266595 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3221,8 +3221,11 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+static void vfio_cxl_teardown(VFIOPCIDevice *vdev);
+
 void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_cxl_teardown(vdev);
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
     vfio_cpr_pci_unregister_device(vdev);
@@ -3696,11 +3699,42 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
+    /*
+     * The HDM memory is host physical. Set up the region, which installs the
+     * fd read/write path, and mmap it for direct guest access; it is added to
+     * the guest address space only once the guest commits its endpoint decoder.
+     */
+    if (vfio_region_setup(OBJECT(vdev), vbasedev, &cxl->mem_region,
+                          cxl->mem_region_index, "cxl-mem", errp)) {
+        return false;
+    }
+    if (vfio_region_mmap(&cxl->mem_region)) {
+        /*
+         * Without mmap the region falls back to the kernel's fd read/write
+         * path, which works but traps every access. Warn rather than fail.
+         */
+        warn_report("vfio-cxl: %s: failed to mmap the HDM memory region; "
+                    "performance may be slow", vbasedev->name);
+    }
+
     cxl->enabled = true;
 
     return true;
 }
 
+static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
+{
+    VFIOCXL *cxl = &vdev->cxl;
+
+    if (!cxl->enabled) {
+        return;
+    }
+    if (cxl->mem_region.mem) {
+        vfio_region_exit(&cxl->mem_region);
+        vfio_region_finalize(&cxl->mem_region);
+    }
+}
+
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7fdd695704..06d15e807d 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -134,6 +134,7 @@ typedef struct VFIOCXL {
     uint32_t comp_bar;               /* component BAR carrying that block */
     uint64_t hdm_offset;             /* block offset within the component BAR */
     uint64_t dpa_size;               /* size of the HDM memory region */
+    VFIORegion mem_region;           /* HDM memory, mapped at committed GPA */
 } VFIOCXL;
 
 struct VFIOPCIDevice {
-- 
2.25.1

