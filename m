Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BF361965
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584396; cv=fail; b=avLAOWYqtPYs9yV75XLhomNcYZbqICVQRPA+si8lRWZnu4TnS+ej76xyHRet612xlDckFuC7mUQtPkNgX0jegvIxnL8MHPVG3nJlP7lvDd7qgs+YH+A3KMvqLSXiD1N/AhrQBRDJJJN+wUPo8k+Jo2F58Nv87w+DyJYO0t0s+7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584396; c=relaxed/simple;
	bh=DCs7X4nYyqNJZQhB793AlVtjRdrLEGnDO1e9o+bd1mI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO3SrN5oeOcWOekIUAqmHo/wSViNu6cO28ton/hdmYDYvgoEFt5UfYD3fyU3bSKW8uH9k2U8DfWz1rYEgr1pov6Kvz/UorkwJge5AxqeJabIhRAbA53HI5ZOe5iqCHY+blExLbvEM1NFtmvKDTP2FnA+1ImLDlAULDqTO7pXdy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MdWaPM3T; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MdWaPM3T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncobX36LZTazd3A5B5QRYNWJDSsyZAt9oJH0UyHpAbmvsp5GaRmrA4mv6KQj7egy8H9YNaBJurWqLxUWHaArdPSoJK8DAWziDwNoLaF9yMyEesxH425GeFz1IXJWlodPVRPKmhV/tl88Z1XT3Z9rK1mtsGtGvdimJCrmBnNbNrcvAJ22e6/Di0II2BlErAI0ReSOki20Ci7YOikxkWDt91T9YaBThIMDJA4Au205Zh8qTdMDYI8rcEKRZKIJyAm1FaEYVLSdG21R5+zvZrv6NUwYeJcpsaDCFgExnXb3pDljQEc9xx1xY2aKZ18iUmn7Ot8c/mFCnCnhQdXUeGNVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NM4uB9CPUYQfd/drhJPnICzXOIJdW1A7hhuAw3Z3lE=;
 b=zFbU90hvlGCBuOTh5NBEoBXuqw7Z9otOP0UWkyyFsyoQLJasg3TnV/hs7lTMPIBS6UzqkUJTSTNv1m7hYVNwxdp48tb+bdGtQrFjzEhY7adLfLetcmKXv+kCtGUEql7ES069/1ArQI/FHZhe7nt+GFtw3PEn/4QXG6kCTWnBfNd5YveIE1Zktfau66qSvY3QstTBrwWJgs7dJ1+Tph6u0tcKgoIWvcYfP3qzNWGMkDGX/8T1YncqTteVn7/kAgE2FdHXoZO1BIynd6+K/I88uEeVEhS5VfjXhdOPA+YzQqPi9xYE/DiZKx2qdTyN3VWrkpGGtpS44a5ssB1AbdfOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NM4uB9CPUYQfd/drhJPnICzXOIJdW1A7hhuAw3Z3lE=;
 b=MdWaPM3TXoniVvjOfoPnV2n/2nWZtS9yxqqVJ3NRHujBDp5qEXpCuMBaCKtfPb4PD3P6wYLcyVUpM2pUoU0OiYoU1Gn4ixnkuzuqEDJmlf61B/di4RXgZuxR/hi4WtWKQm4XyVLpK3NBm67wvGzPYO+5anW97NRNphPlrvIxgDjcVyOtj5PwbRDr7rskSwm0hmXHeVq95/cWNSGNT+NmuMW5/tVOzt8pBxch7Qd+wPyGyOQX4OrkmCRGZhWgaUoHYhnlwa/rwyrSGg4ejE1PDp7Twwss7h+OdRNkg1cFb0tGWWh5TthrSTlLRO5cLexrBdL26TERnGRQ3KqdCWmlXg==
Received: from DS3P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::12) by
 CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Wed, 16 Sep 2026 18:46:05 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:45e:cafe::8) by DS3P221CA0013.outlook.office365.com
 (2603:10b6:8:45e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:46:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:45:36 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:45:29 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>, Shameer Kolothum <skolothumtho@nvidia.com>
Subject: [PATCH v2 09/10] hw/arm/smmu-common: Allow pxb-cxl as an SMMUv3 primary bus
Date: Thu, 17 Sep 2026 00:14:11 +0530
Message-ID: <20260916184412.3825713-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc2d35b-9c4a-4d5e-d4fb-08df1422c357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|921020|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FFwyFi7aAYmoxyLGIKOUjkqERo5Msnw4zhtSNKFhsaLnwi8NuIJypeEByUZjU4IClTLtuPK4T4an73AfUjbt94AzzJTkgCsZxe5eC/5i5DIwahwJvTJnCn4iiTcY5uKqIuTkVO2fI6VnOkdcPFsGkxThVoF+ny400Ieu0TubjMQczCUFejb6MABfMv8/NqL6Lu6c2c2En7v8c1x/K/YPEida/+8nUy3sUsyDDLMRHp4GNMCugrLtureUMHDStfJ/rq6Gmkd0Gn+VevSqEov17ZfUPWfsSjaVSHu/oSL2aUezwED9DZsLym9ny5bF5FRlccDmLPNKySFM00qA1Yhyi56w11nt74vB3NvgjTUDZ+DUXpryOepk7s2uxfFRq2Oj+Eyl7BzYoTDqtGfKsAkJjnjDFmqEWKlTMgDqTWJh6O9IOaODTnXdccD00k0KlbCwkqTmJsfa9MHVwELMX/ZbX/NmavACACMzRR0wiRoS+/p2aWsY+Gmox5k/qocbJ/ljUogEhmG74zOpSiVPVp+fKt1tWV3bR09Vh7v+xWyaQsb8zgLfN130qaPZ88RnMdgkQWcbcAbxIKDzcApfoE8EGHMZUb2PqAKTGOrlBY2MQdYMNdW/BSGs1nkinm4NpF+pshoAnBjzgvKCjLmvKKOMFd/pv/S5bfQGLzC9p5Wd5sFcUxJQraxQ2wRSeUyThSBoi7Y2IkHOCXsSOVO+quer+JK9jNcZ4ow68jSgT8ZLSOJnpTS7RA7Ma9FDzY1WPy7o
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SOpz5YnqK5Xi1P5ic7IUwCk+UUhP8oqhQC2iBkMVjsg8Tidj1i6USoG4m+fYzv/kRkzdHs9Y5rUSxytAuxZp1M+YC7F6P5/XdAJTw6Kprl+RXKEwrEm4iBCsh54drcoaxiwrekHq72phH4xG4YRgfLHrCMkpshQOUvwWp08fisSyRxBVN89k1Ej3MEfLVpQyEwwKfJ+tDenD+LZPRZTKR6n2nSKK4wFRb+svPzKmC4g6Nop3xse13sfXilL+BBOgXLnrqXXkqAUtJFHCychSRHkGEW11w5dHUGYBtEj6edUDmAF+is8d8kywhHsm/oIfqB55RlIoxcyhoGP198zqb3lKk+EQcPC34Oqjm/Lo3GG6nCFnIiSmcv8TZGeFXXwPaxVkijGtj7MbV1jH/eH29QwHtXKoM36QVK8EN0/m5Bby1fpxup9uG91ndZxSUktL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:46:04.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc2d35b-9c4a-4d5e-d4fb-08df1422c357
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

From: Manish Honap <mhonap@nvidia.com>

The SMMUv3 primary-bus check only accepted pxb-pcie as a valid extra
root complex, so a CXL device behind a pxb-cxl could not reach the
IOMMU: attaching an arm-smmuv3 to a pxb-cxl bus failed at realize with
"SMMU should be attached to a default PCIe root complex (pcie.0) or a
pxb-pcie based root complex".

A pxb-cxl uses the same PCIe-compatible bus as a pxb-pcie, so accept it
too. A CXL Type-2 device passed through with vfio-pci sits behind a
pxb-cxl and needs SMMU translation for its DMA and ATS just like a
pxb-pcie device.

AI-used-for: code (prototype)
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/arm/smmu-common.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8e40ba603d..42fb098ab2 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -963,19 +963,20 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         s->iommu_ops = &smmu_ops;
     }
     /*
-     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
-     * root complexes to be associated with SMMU.
+     * We only allow the default PCIe root complex (pcie.0) or pxb-pcie /
+     * pxb-cxl based extra root complexes to be associated with SMMU.
      */
     if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
         object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
         /*
-         * This condition matches either the default pcie.0, pxb-pcie, or
-         * pxb-cxl. For both pxb-pcie and pxb-cxl, parent_dev will be set.
-         * Currently, we don't allow pxb-cxl as it requires further
-         * verification. Therefore, make sure this is indeed pxb-pcie.
+         * pcie.0 has no parent_dev; pxb-pcie and pxb-cxl do. Accept both bus
+         * types explicitly so other root complexes are still rejected. A
+         * pxb-cxl uses the same PCIe-compatible bus, so a CXL device behind it
+         * needs the SMMU just like a pxb-pcie one.
          */
         if (pci_bus->parent_dev) {
-            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
+            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS) &&
+                !object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_CXL_BUS)) {
                 goto out_err;
             }
         }
@@ -990,8 +991,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
 out_err:
-    error_setg(errp, "SMMU should be attached to a default PCIe root complex"
-               "(pcie.0) or a pxb-pcie based root complex");
+    error_setg(errp, "SMMU should be attached to a default PCIe root complex "
+               "(pcie.0), a pxb-pcie, or a pxb-cxl based root complex");
 }
 
 /*
-- 
2.25.1

