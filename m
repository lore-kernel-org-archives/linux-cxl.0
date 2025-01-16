Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C322BAC1
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049418; cv=fail; b=ZFOu4JwhWkKgN7T6GZuFxUGWkKTFXyDRjLtB3m0dct3L346c1G+xMQQ1u7jUmDU13G8R8P6JT2Ks6mhKBKyeyHpcKuNGfrfq+Jgw7nHCjdAIaMCtg44Xe0JXd96ED/Ul1H9CzyiTMV+205MHupaSaO7yEXCvuf7f1C3BDRyfqKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049418; c=relaxed/simple;
	bh=L39G23QdNsZrSn4FAakc1WwWDn5trKmUMgqKt+WwMi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaNBD0NqcM7n+R+z6Mh/o9/xykA2q/kpz969KZc0a1oDkTLXQNmjxEkAAyUBUkdVg29eZiqNJ+xmiA3AdzBFLpK0/1+cZuyb2W6OHovKza+4OtF0zCS8Tl/GJxm9I1P3ivMhioMtYXiXjIcWHphSbxBNfLWJiUUeOqILvf/FbUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rjZjqbHg; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rjZjqbHg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa+LOuafNG1Rpav0H1VCxwi+AXlQYRzeBzVrvR4CCdudrcTie+vQlZbXwhTAw/DQTbZsRAmO1Se6tLNC1ComuhIq+MbxLZWR2dBl0vY0pY8TwvxPYbEGCNjH3cUZWQCwciArB3qKKQRpXuh1JPzbggvBqlorgeZJAqtbZ8pDYpOKN6DpONvnGag+Ugw7vlj2gcolkp5zTWkJteAET203PHlNVpEVmTkaNC2aiQhgeRcIOAMksa62M7b+RFYysmD8E34CUsM4cdbxWveP2dvUHNiAAeKntHYLZF6wZWokEkOpxvsuxD5Bd8WDNNtGUgoGmvZmh5AIE2RlOC8ZFPpRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywFJp//eIGMl9pJ14Ejl6c1NL1m/qgp6gZ+lIbwIm+8=;
 b=q304VK/qs9SEPk9lKHrfTTY/62dhjPteJ0j5a0sG6hQSrMaKK067ANSlk+zreBS4D2bLzeetxV6dpH4zaiwOZC0E/bdZi8cX3r4qIvBc246zWQbDj093g3FZitMCowvmbgEy3aRumaPYMXHo9VubkZqfTRVXtH1NnCYL8X/QPluMMfDsr/CnCEQqFA7MNq7w1ER7/xskc9ulfk62wx8eFyYPqNMm728ozL2JEI5wEJcZkFCpJ+adTAc+cUEFY2eTFNLCYGTxIOqTFBBR+mD6378uccb9fxb0JkJWAyDLW4am117jF/dZ5XzLz710VoNiRVOzHQ8SGNXgvdXBhEJvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywFJp//eIGMl9pJ14Ejl6c1NL1m/qgp6gZ+lIbwIm+8=;
 b=rjZjqbHgBPo9Ch0xozD35W6l9fj378gg8h6M5Wc59E1YNd+1xeMyx12sVg8Y6vyFTiLMnYJoacPVR7ky7tngtm3S1n/w7EanFEavNEjvkiPElWwgngnKcxYCDBKa9FQkfrsOeYaF+rb/RHHGVN3/e/3rukuEEJ3l7w/1P2MPH3M=
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 17:43:33 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::bd) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Thu,
 16 Jan 2025 17:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 17:43:32 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 11:43:31 -0600
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: [PATCH v2 4/4] Add SOFT RESERVE resource notification chain
Date: Thu, 16 Jan 2025 11:42:08 -0600
Message-ID: <fd3681b9860aea3367432935c4f4975e84e9d9b0.1737046620.git.nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737046620.git.nathan.fontenot@amd.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b6f673-5cfe-4466-4de4-08dd36554b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2iPu5JHYH2ksmVM359l7fEzsBvp+DPVGdkoar3vGSnf0Be+lDnxgQ8UOaUab?=
 =?us-ascii?Q?iyzhH3V3Egb+hDP2C3rJa8AjVuQ/9XsoYlrVKMAbdi28+nv24pIpfy6TKmtY?=
 =?us-ascii?Q?3BaMGut/EazueQJky3Fftd2h/iILZ4uxtoolGp5Ek+rLE+mxiKeR1XK908zS?=
 =?us-ascii?Q?4CLRInQlC4u8eRCgyKUgWWNhB2D8aGlTGTPQtbIugJpF0d/tSU6CDvqeax+1?=
 =?us-ascii?Q?EdOxpZQqb71LtTd60jnJQp8fyuGyMca8U+jpSAftgFRiiYEuoTTDQxyINc0l?=
 =?us-ascii?Q?om3aCNdgHnGf5ucOusvnVuzbHq0sstrEcl70FmFr3aWzQXDmsNn1nQDboJ1S?=
 =?us-ascii?Q?2yaldObtMl7uwhFeYWuBbr3jmy3n3orA1pasuHWglbeu88T7mdZTVD9bmrYz?=
 =?us-ascii?Q?+7+6Hc8zJP7hphW+65jBQYUNsRC5Xo5RhC8gvNnOpX5X+34LtBe1gRG4MNLQ?=
 =?us-ascii?Q?pbYDpqoW78QHA7eORH3TFgcu+x83q2ez5/eEJY0Cpfi4WDS7WniX2ixBQMcs?=
 =?us-ascii?Q?wtDaq06fVXWz2RejQQZYjyVCNi/PlK1tl4t0F4mHbS7B4zXJxipl2jsgMXEr?=
 =?us-ascii?Q?w5QRIjPrkGS6ahodAM0mkfxIR5AjAgg2JBgPBVBJCh51ZpbaPH7ty/kiMKSx?=
 =?us-ascii?Q?0l6wT69ttm8Rof4H77yqA+mBb1pJxLkNalKJoVDcObpePdfntXiUb2hcB+yc?=
 =?us-ascii?Q?D7lhNhlhmZpvKOtpir2pac9N7qbp4m54dPers+y33XLQU+z2T1dxCrABdmGY?=
 =?us-ascii?Q?/gT+3H1NB5LPNxUksZUYseiFecNdl5mLjl1C32Sz/9WSFcwNv3y4v2AxsH40?=
 =?us-ascii?Q?U7XfrTzjcR3hD9/Nl/COnynNNgfnPz2HGJT2526Ci9A6hlzPJg/EHlSY09FH?=
 =?us-ascii?Q?2zV3KHcaVABkAQs3MX2BFT/+2Ur6BUBo2HTcZ0mkf2qTvkzA3hcRwog9jrAr?=
 =?us-ascii?Q?R7/dbcUxi72FAbyEdMo+MB6DsF37EtUWbjeoiXMnUXLUPNlZ6nfujOvBvXxp?=
 =?us-ascii?Q?Tjaq0T/aMXqU7fNTkPggOlD112kX91BDjQBYc4oZFaAgV/hB59D68jMXjpTN?=
 =?us-ascii?Q?FvaS3xEE/9gzmwGleQUqE+dagRk/+IauiMLakuQSzFWWoEM4mhtSgFsOrEzf?=
 =?us-ascii?Q?4zVA4j121Zo4ie80WAKivCKSihQFQxmHEIQJHMeHw8Tli8Tka+ZT2cZ29Xen?=
 =?us-ascii?Q?irvftb0U1Bh1TWj5FK96sC+iMKdKFQ+aM1aiGGkk2QE8gP2NLGV1Sd5BoMyi?=
 =?us-ascii?Q?oBqdmuN4UJtYvR7X263vsLSRK1S4N8JjDlO6ANOknnCRLXf+xzqIlElrco3Q?=
 =?us-ascii?Q?PCbbRV/6VJwOOR2h5U4VjJZYlB4F2xHyWMclq/VZCvTwK/VFb94lWbMNgyUk?=
 =?us-ascii?Q?NLP5gJNkzxnIt6YTVRZmE1/Njk3DzLP4sf6lBLalgez4L3QLKKBFG5DwbiJ2?=
 =?us-ascii?Q?4VPKOm1NUrSCGyN86EuPSPlRH3IUeBrujn+dBZcfAFGr1dbZOWg0ZWNkJNj8?=
 =?us-ascii?Q?P5hFVU8np/6YamI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:43:32.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b6f673-5cfe-4466-4de4-08dd36554b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509

Add a notification chain for SOFT RESERVE resources that are added
to the iomem resource tree when the SOFT_RESERVE_MANAGED config
option is specified.

Update the dax driver to register a notification handler for SOFT
RESERVE resources so that any late added SOFT RESERVES can be
consumed by the driver.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 drivers/dax/hmem/hmem.c | 24 +++++++++++++++++++++++-
 include/linux/ioport.h  | 11 +++++++++++
 kernel/resource.c       | 21 +++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 088f4060d4d5..0e6b7558ca3d 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -126,14 +126,36 @@ static int hmem_register_device(const struct resource *res)
 	return rc;
 }
 
+static int dax_hmem_cb(struct notifier_block *nb, unsigned long action,
+		       void *arg)
+{
+	return hmem_register_device((struct resource *)arg);
+}
+
+static struct notifier_block dax_hmem_nb = {
+	.notifier_call = dax_hmem_cb,
+};
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	int rc;
+
 	dax_hmem_pdev = pdev;
-	return walk_hmem_resources(hmem_register_device);
+	rc = walk_hmem_resources(hmem_register_device);
+
+	register_srmem_notifier(&dax_hmem_nb);
+	return rc;
+}
+
+static void dax_hmem_platform_remove(struct platform_device *pdev)
+{
+	dax_hmem_pdev = NULL;
+	unregister_srmem_notifier(&dax_hmem_nb);
 }
 
 static struct platform_driver dax_hmem_platform_driver = {
 	.probe = dax_hmem_platform_probe,
+	.remove = dax_hmem_platform_remove,
 	.driver = {
 		.name = "hmem_platform",
 	},
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 2c95cf0be45e..c173cdd5ab87 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -13,6 +13,7 @@
 #include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/minmax.h>
+#include <linux/notifier.h>
 #include <linux/types.h>
 /*
  * Resources are tree-like, allowing
@@ -254,8 +255,18 @@ resource_size_t resource_alignment(struct resource *res);
 void merge_srmem_resources(void);
 extern void release_srmem_region_adjustable(resource_size_t start,
 					    resource_size_t size);
+int register_srmem_notifier(struct notifier_block *nb);
+int unregister_srmem_notifier(struct notifier_block *nb);
 #else
 static inline void merge_srmem_resources(void) { }
+static int register_srmem_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+static int unregister_srmem_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
 #endif
 
 static inline resource_size_t resource_size(const struct resource *res)
diff --git a/kernel/resource.c b/kernel/resource.c
index 9db420078a3f..3e117e3ba2a5 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1471,6 +1471,26 @@ static void release_region_adjustable(struct resource *parent,
 }
 
 #ifdef CONFIG_SOFT_RESERVED_MANAGED
+
+static RAW_NOTIFIER_HEAD(srmem_chain);
+
+int register_srmem_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&srmem_chain, nb);
+}
+EXPORT_SYMBOL(register_srmem_notifier);
+
+int unregister_srmem_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_unregister(&srmem_chain, nb);
+}
+EXPORT_SYMBOL(unregister_srmem_notifier);
+
+static int srmem_notify(void *v)
+{
+	return raw_notifier_call_chain(&srmem_chain, 0, v);
+}
+
 /**
  * merge_srmem_resources - merge srmem resources into the iomem resource tree
  *
@@ -1497,6 +1517,7 @@ void merge_srmem_resources(void)
 			__insert_resource(&srmem_resource, res);
 
 		write_unlock(&resource_lock);
+		srmem_notify(res);
 	}
 }
 EXPORT_SYMBOL_GPL(merge_srmem_resources);
-- 
2.43.0

