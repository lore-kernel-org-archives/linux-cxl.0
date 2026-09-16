Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6684D0CDD
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584354; cv=fail; b=Q0AsItwqAheM9x1GfcGQx6M9BGydeVhuaK+P0Hlj2j1vOmPJHPQ061acv4mXCZZXl6bNqbU8AgDJEhqEjb9LK0PomK2y54GrNQO8mTFxVxU80bl55jfeL0OuT52T+K94/XH8GAf9uDukcVww5GPwLrIoedXYbEIl4shy9fu+InE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584354; c=relaxed/simple;
	bh=8LUKisiZulxnEvwLTL+U0eJDK50Q5T89VpUW8PT6tqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s68erJuEWGPaQ/asQxVeXubfEfgYeFahV0P3fUgZgB8y8+t9MjLAPW5jK/hPNcWyHCUDb3I28Bgz/xKtn/fQ+TrqIkKXzor8G7sUP2qh6TW8HUCK8iC9PMlayMVG/CoSM3gztYXiArDs6jEbHVA6u+dMeTcyK6wfm5/Bq7TxVgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dWc5J2sJ; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWc5J2sJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEPHFZXVSiNpRYiMUXpYNLGlNSAqoZSe365hAWt8+1K9E2Qr1sorZOHx5sX9ceDEZib+8w7j9cjMiRRzfZDVbLznFpCvGbgEaktUwg4+YjiNdiKyl9tvWRqtXI4Vi9p/OdniZjfgQz/4YCj6kO62iJptGQLt3PxlJ8M6qXlbaPEA1R3lfbcGA9QYS0Df54vu102ukBfTPE/SJ60pXRpiwNvYe4/g6KCs1+0o/9gViMNjW9kVjj+Pr7PNFv6yIByyxV4l1Kz2zA1H50GqYRxEZcBPgFkszMU34+AUAAjTH1u3lFXYOlgnq9iVjaUYcZuEZyG/EbXfJamagmf88DaImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaSuo09232KfURc1tSY31xoCF8lWN92T+ctO36pjukM=;
 b=WikzQHVA/OQYS512sUbAHBobKPdOiSrB442GKFxhhvxgtn2Lv5cmy7we5u/FFJewazyCQNI6OBoMaalOkAuE4LvAwq7k9m7mnC3IYgUHfqwpYwwXcYDTnezItQ6ADmGFiou/jal+RbaGr0Eiqx/ceHAqklBw8d0UbW7MQCWpAEmN6SBo88ETOaC+vm0Z2fhzT4rS+zCfvRQSBHrZJgyl2CzikRvTCgqUkiMs7Y1ZtGtZX/OCHObVT3zRt3QayQM7ndWR51VkZHEOjmux+xdh6Ku3nadH2DGPFJFZkJjcm1kGRyuT1ej9FxRZ2i8sU6cQwU9IRW3+ecDeLddzwpgvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaSuo09232KfURc1tSY31xoCF8lWN92T+ctO36pjukM=;
 b=dWc5J2sJFamQB1zwww0qtanpsRLei4Lf2Y8O9Umm0BtkzUk72KJddXPfnJIHKSiKYGN733lHTGHS1M101pN7jn/ZaocMr1W8prvto26PHyWl47bON8T2EOxEymwNarfuRX4JFCD0IxSUlkbqH19zU1vwhjkm61hUmCtcxIBmsKl/ahcn3IXbzsmerll+KspXmVA7j6OCamkSQ6LK6CroK+OoAyXKZRa3cCDwEAFHseOYJ18txD2XpU/QA6xTbdASiYQCY50+dwzg8T7QSQbbkIj8CmS0CU97vGLVgwOx1VpXpdvUaKR2vjaZK9ABMsyuEHeUDFQeLilr1D3SdM1NEQ==
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:45:27 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ae) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 18:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:01 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:44:54 -0700
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
Subject: [PATCH v2 04/10] hw/vfio/pci: Enforce the passthrough topology for a CXL device
Date: Thu, 17 Sep 2026 00:14:06 +0530
Message-ID: <20260916184412.3825713-5-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: bac5a289-d116-49e4-cb87-08df1422ad41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|7416014|1800799024|921020|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	olPFq9rVwo/r/Br+ScVbZ32R8qXMIsusCkZ8CVKvnZ0/7ez2H9xtNh3Bks1rC9MYcLQgj5hDoZuVOTbjLifkpxq4YCt+cDcfY5EKnRBg5VGba+OQ4zgVPyXBdAmPY9H1YGDPReh3s8l2Y+5kCrhv5dWoBLkMQjsysXdp2FCbnjg9q+wY0EsmzvD4N3zqQ4YaEQt1iTDyxaspiDpMBpq0ReAztfJasoyAyZV4rkyd+VigI1AQjoRi2oI/MSyUv8JY+TO/+ulXfeZYuClC6lTA6C1nx6ER289I0lH7CnEu9jCSdb7GyduCfnFtijupbKlUN/H9hDqutzW7zBzI2BYelc/Utj22ZdF8+taUZnilMibH6fVO+5q0GjWnDh7HhsN4vjlaBg7h18zzAdOvI0vp3WSCMz5caGOJF+6eSJJLkKa3+P3x/NsvBFVPbtCzbI9IS/SFC5EdkXwwCqW8AyG5FYpQW6hSXLH+aujeu+0y/c7Nw9jArsTHS86+wvGQn/mOHFLVAEG/XshBaJPVuztVy7oPkYCW0TCpQaebUl7rUr88y8aPumFNwInhZLNQnpt1tKwj+8U1jBU63Ump9UEzyE4D0pXbp39l+xEeB7frVCe0Eu9Mc8P8OKy9qqbhzV3ImjVtfzrMGQ8QCJRfoDX+T30u+IFZ+HCyYr7zovnV05S6KUsmsMmqXUbuH9Ztp8sxidlwTq28/O4yuuftGpQB3vYIn2P9iBNonTD7gZGyoWu/Bo7DsGfp8vsYmMZwCEUl
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(7416014)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6ZBu17bWNpAz01A80ZJETiuDgN4VgripajayBLBXNsXaxoaxySefIZXWnKd87yRQskMs2C40RFDLJM5pQw5e5rdXy6PgrbZ3eh9PUdxB5tLj1SewqNJlGcC/k0tg41ew3aro/tSFZUH/Hzu41ezPTiS0uTW4TBW2RWSzc3LKfr4zxRzQkDTy0PRzAINL+69zLre3xlyfkmNvwK77d5MR6NBgGGgZec6zqyMdOl1TtVVn5Vb+gr+XxhuTp1mBFpCN6aLq4lGuf/OIswsOGqkcV4PH8W2jS8Jsfbz3bYKZzcji/cGMFj6Y+H7LkUvGG37/tVLvyG1k13/Nu+p6dig9Oe4vpW+ofY4FD7iDsSTzXIn0HxZKcfb7JBW/SGpl8vSTJzK4jG55iJraXdQmzVcLra77U1DfWyNEy5BABW+5Go+7cNPS3ZaSjJpUW4xOIXCE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:27.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac5a289-d116-49e4-cb87-08df1422ad41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

From: Manish Honap <mhonap@nvidia.com>

Only the guest's endpoint HDM decoder is programmed by the guest; the
decoders above it are covered only while the pxb-cxl host bridge stays in
passthrough mode. Reject a switch in the path, or a host bridge taken out
of passthrough, at realize before any mapping exists.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/pci.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2f84af5cf8..10b13f200d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/cxl/cxl.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -3570,6 +3571,73 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+/*
+ * Walk the endpoint's ancestor bridges up to its pxb-cxl host bridge. A CXL
+ * switch in the path is rejected: the guest would then have to program switch
+ * decoders, which the passthrough model does not yet cover. This is the single
+ * place the supported-topology assumption lives, so switch support later
+ * relaxes it here.
+ */
+static PXBCXLDev *vfio_cxl_find_pxb(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIBus *bus = pci_get_bus(&vdev->parent_obj);
+
+    if (!object_dynamic_cast(OBJECT(bus), TYPE_CXL_BUS)) {
+        error_setg(errp,
+                   "vfio-cxl: %s: endpoint is not on a CXL root port (cxl-rp)",
+                   vdev->vbasedev.name);
+        return NULL;
+    }
+
+    for (; bus; ) {
+        PCIDevice *bridge = bus->parent_dev;
+
+        if (!bridge) {
+            break;
+        }
+        if (object_dynamic_cast(OBJECT(bridge), TYPE_CXL_USP) ||
+            object_dynamic_cast(OBJECT(bridge), TYPE_CXL_DSP)) {
+            error_setg(errp,
+                       "vfio-cxl: %s: switch-attached topology not supported",
+                       vdev->vbasedev.name);
+            return NULL;
+        }
+        if (object_dynamic_cast(OBJECT(bridge), TYPE_PXB_CXL_DEV)) {
+            return PXB_CXL_DEV(bridge);
+        }
+        if (pci_bus_is_root(bus)) {
+            break;
+        }
+        bus = pci_get_bus(bridge);
+    }
+
+    error_setg(errp, "vfio-cxl: %s: not attached below a pxb-cxl host bridge",
+               vdev->vbasedev.name);
+    return NULL;
+}
+
+/*
+ * Only guest's endpoint decoder is programmed, so the host bridge must stay in
+ * HDM passthrough mode. Reject anything else at realize, before a mapping is
+ * built. cxl_get_hb_passthrough() reflects reset state and is not
+ * settled yet here, so gate on the static hdm_for_passthrough property.
+ */
+static bool vfio_cxl_check_topology(VFIOPCIDevice *vdev, Error **errp)
+{
+    PXBCXLDev *pxb = vfio_cxl_find_pxb(vdev, errp);
+
+    if (!pxb) {
+        return false;
+    }
+    if (pxb->hdm_for_passthrough) {
+        error_setg(errp,
+                   "vfio-cxl: %s: the pxb-cxl must be in HDM passthrough mode "
+                   "(do not set hdm_for_passthrough)", vdev->vbasedev.name);
+        return false;
+    }
+    return true;
+}
+
 /*
  * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
  * and the trapped HDM decoder block (which BAR carries it and at what offset).
@@ -3623,6 +3691,11 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
     cxl->dpa_size = mem_info->size;
     cxl->comp_bar = cap->bar;
     cxl->hdm_offset = cap->offset;
+
+    if (!vfio_cxl_check_topology(vdev, errp)) {
+        return false;
+    }
+
     cxl->enabled = true;
 
     return true;
-- 
2.25.1

