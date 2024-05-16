Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D4282EF
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847154; cv=fail; b=UMfye4da4uR3HmGRueKzkftDWouN1dlBEP1c1qux0k136t+iswL5F3PsOF4ZmavMV7xuOr8aJLEDG6H0OEYO/Y66syMzfQfoNj8ko4uqiD8eVksJwhQp3+XRsl7b6RPONA83nvUakbwyurrpzrCximbkOA9CVg6cIxPul3N8RJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847154; c=relaxed/simple;
	bh=M3xBaVfzBrErpywI7/7Ux+dirFtEhqPtP2+rV5qvyhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuoW/KBox/tgerYoTYRi7CQWK2ZXOkaldgZJQoWaYn9pm0ekLskR5HQDuqUptJiMuFwR1gl083qt6Xp4Z9oJE7tT0gANad9xfbUz8Uxt89WRkMBOcelC8lz6Zs6AWcsMEXfup/BwNRruOZky60EU4oGM4GmNEnDeg3TYBx8ZyBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z8NhVlm6; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z8NhVlm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW0z6tHuhaL/Qn0L6WEVff/Y+6wNrO7VisdN8/DYpq+agNpknoo+Dltz4AKXWd6KHqoEotLuCMCh7X+l6vrBHGKxMgEKDoK1G/tGKBeHp9Nv9hId7TXWdRyevcNTkXPNDLwvxpg5GxDyQCIjtMVjy/LA0tNSHXVmmwFQkXjNuypxmxnb2gk/ERW3+QFcMcR2dfQZnkHV87gpFVm3+xs7lnGPmQqdTQIJnFk8RPUS7VMFFh53j94xiIUyxtRYcvC1c9Mh3kNRwUFIt97X+IQZrK79m4hH5wBNsCjtLeG903t9YOv7dmGDSTqo6kepTB2FeJKZGeElVWLMSyrc/jJpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT/RB9ryVF08gkJdJMAJGdHUIHo69u7LqVqsVPODEbA=;
 b=UnNohxa/aq7b501jFS6YwFvqTlwHG4m/1z2AI4bQ/x9+PtHyJ8sssshR1EdncVrNQ6tlWLpBcEvYbuVzdEMonotOMv8YQh8rnSwMkKFaQqEXEPTkPZDn0J2L110EGMoXdl0lcQsrueMmXxdLdshFayIyOfzrZcm2IA9eaXRPwrzw7yVGEFRqJcFHMDpbwjc/iSmzcNlvwttqGw0/bNJdcumSAdW7rWTqmYmDbMxJpBOAU/jWGeMvSqSIPzvIV0pOE5QnVTOwrpLa/yPTFF+hYL3b88sZFsNnKtNJm2ycjIB0KDuCAiY9UO3PWrl4TFCwLN6iALvUWCFfXwYyKgfopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT/RB9ryVF08gkJdJMAJGdHUIHo69u7LqVqsVPODEbA=;
 b=Z8NhVlm6QAwxtCTTU19IIF+ZyxqzbyoqI/B1DnxRcNrSyRMQX31QHh4STPbKsTU05xKyXvul5Obl+4042BuQxnYBcPiv92njLvHWEgvzZIT1Y7UWyhaMYHEl0Y5AO8dccjbbmJd/NBK0kcxiV38oyBBup2plWC/Bl+P8Z5ITEg8=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 08:12:28 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::a1) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 08:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:22 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:21 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 06/13] cxl: support type2 memdev creation
Date: Thu, 16 May 2024 09:11:55 +0100
Message-ID: <20240516081202.27023-7-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e4be0e-cd53-40ec-4374-08dc757fed16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUKzBOUubHPiE5DHrQLKBbpG21favUAhN8J1NGEaBcFTRAprYUUi27lak4mE?=
 =?us-ascii?Q?SGtrsY2PrDVBnfQReTE8e5hb5FhZ72Cid/tl15EO91HvUGWq/UzJ4xh2L3vP?=
 =?us-ascii?Q?574M6545+Zgr2JUGXfLWzIFhQr/4sAr6rLNxyywiCYFFLrUpd1weZegB27EV?=
 =?us-ascii?Q?n0QWlnguP3hwI8io2ER1NQgBVFQ6m0uOnJsaUsWMrR8UJcOhxUF7aiYM7Zwd?=
 =?us-ascii?Q?XVM5QGg8ThqY2Zj3HrD7/bH/v8X6PdEJq0RtH6nJHPaYmL+yliWbIrcBtq5w?=
 =?us-ascii?Q?l2f8RHSeEItBPokkFSeAIQs/aEUlgtnX/VE8z3icti9emS3ZLERENbV+nvlq?=
 =?us-ascii?Q?3kkO/tRaI/Mt7yYX+u261SQQz59xIG7HT7NTjzgqO3vSMICgVT5IYvkOBKCm?=
 =?us-ascii?Q?4552BOlvi3vS+yoEx86pvK1wOvprTJB/2uds2mTW9i8YGt98ZGVhb0MWC7In?=
 =?us-ascii?Q?owAY5heTN8mtQ7HnZ3w6cxmBeRlOsuIqQId7aKdY9dyfDUTppVO+4fI4D1Mk?=
 =?us-ascii?Q?C1o9hjRiyiC7I9yqQ3rWzHchv+9ZhIwFO+KAT7tel3KQwIi2cXq20s7WrHHt?=
 =?us-ascii?Q?4+Vs5fu0NOzA2MhS4qUneHpj27XOl/iwAATRFBbsgllbe/x9nGqKsH4sEMO0?=
 =?us-ascii?Q?oB1QYuabApeNDjS1Sd8A0GMWZSDKD28qGsDEzcLISP35ZnnfU74dfmnjpFmT?=
 =?us-ascii?Q?6bV8Q77Ks5LI7sumwYuVJWiKLVV46faMPpnTuXOLjsZubcFCxZIBMWjo8+GS?=
 =?us-ascii?Q?8hRQTZTF/TzkCBJwZV1s8V1iFvc4PXVdiDB6F/COsHDd0Nr+EQMNSisQe8pb?=
 =?us-ascii?Q?MS8sdqM5mYLY/JEMv/D04fZWLdwkNrBVlibGjFNVAhHiuRRPmKn7xkHWWwRy?=
 =?us-ascii?Q?NF0LAIomq3bFL5+PQ+C3MoQG2FO3QHBiHpkvePoR7hIwh7M5MbwC+QdwsohN?=
 =?us-ascii?Q?DvIWxoUPNva1hGi174wTIvuAT4bHPMGqxoMRrphuJJ1g36+H2lDN0b5DJD3Q?=
 =?us-ascii?Q?0VxpmGJYPIPyZMijmmCR3QfhZbb1PwFzOQRSDRQdtulEGuOmhYORXZFQmxHE?=
 =?us-ascii?Q?sO1jdP+8Z7T9rJ0xuoXZ8rUHGzQ/6lm5fmFYwzQlbUf3HnX14v5vtAyI22vx?=
 =?us-ascii?Q?3HjUeX0O5522ldfLOmL1HpHjByFIHza32ov2pRKO/r+H93Y2z2hmSl3txVe1?=
 =?us-ascii?Q?pz1hzADrMGYZZcY7FGryH+CHe+8eVsh7p4Hs77IALQxOsaghFGSw7lV/4PMb?=
 =?us-ascii?Q?FvQ753KlSgq4O8HO3v1WCIGApXWsfi10KZsxfDtQhM3A2VHYFECeaXXZjaB9?=
 =?us-ascii?Q?SZMCR4p/iOzzikwFnK7NINMqafcpF7uK+/O1klOUpqMwUPue7R4USvz6vl7H?=
 =?us-ascii?Q?Ha+8QlkcG0QNaOw79jlK2fUnf7FC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:27.8098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e4be0e-cd53-40ec-4374-08dc757fed16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

From: Alejandro Lucero <alucerop@amd.com>

Adding memdev creation to the cxl type2 test driver.

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected. This patch checks for the
right device type in those functions using cxl_memdev_state.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/cdat.c             |  3 +++
 drivers/cxl/core/memdev.c           |  9 +++++++++
 drivers/cxl/mem.c                   | 17 +++++++++++------
 tools/testing/cxl/type2/pci_type2.c |  6 ++++++
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 97ff1dfd63d6..292efd7e68ad 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 	};
 	struct cxl_dpa_perf *perf;
 
+	if (!mds)
+		return;
+
 	switch (cxlr->mode) {
 	case CXL_DECODER_RAM:
 		perf = &mds->ram_perf;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b61d57d0d4f4..27063cd4ea73 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -511,6 +511,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_ram_qos_class.attr)
 		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
@@ -530,6 +533,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_pmem_qos_class.attr)
 		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
@@ -550,6 +556,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_security_sanitize.attr &&
 	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
 		return 0;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a168343d2d4d..da63ce486e1a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -221,6 +223,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index b12f13e676fb..f157139b712f 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -5,6 +5,7 @@
 #include <linux/cxlmem.h>
 
 struct cxl_dev_state *cxlds;
+struct cxl_memdev *cxlmd;
 
 #define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
 
@@ -66,6 +67,11 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 	else
 		dev_warn(&pci_dev->dev, "Media not active (%d)\n", rc);
 
+	pci_info(pci_dev, "cxl adding memdev...");
+	cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxlds);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+
 	return 0;
 }
 
-- 
2.17.1

