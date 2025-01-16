Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A91428E7
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049402; cv=fail; b=hkCfToJRh6ApTHeqvQaSV7//xLtqu4QwM84re8qDAXneE8o7PNYYg/OcByv5pK9/Dy21fQQGKpWzhv8JQozKxHf0F+1M8EvX6YLV4VlHPYI0fCpLJ8MSKNi8MaiZTpctnYr2xalkXBdsvrhTOK0E22B2ut8F7wV50hro7/8IPx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049402; c=relaxed/simple;
	bh=t9dGPYPusGHvxpJn5hVRd1l1DuuWTWdaPKs7Pn6ASC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkFGjyz96zxlalUOZIydn0q5a8D+ZUHd+LMSzIGHoUTjhq1bXL8FEwYEttRgm2CW7WE8Li54NwkuZovqjtMkfhpWCv70B2kdoDp3ilJmH7Elidec4eHai0E6ly+3rJmzJV85kGbVD9lmu1i9RjDFNRrbzoDT4t+iQGrTmeRoIEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bi4Ji7v1; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bi4Ji7v1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4CCnWCQiSqL5uec+63QhPpKzh6tlMJID5bPVnuwW1V9JasOMeEhpuKSrm/RGEs19lM6NyjJu84FqJGWuvGAS4ytCVGW7p7AmihjImHV9Q8I2Rwy6qrXGMBC/HZXjDY7VpPyLnVpM3b8fHQVrnLSrJ/Q/mpNgcHlq9GSSDYVgJeabHdCq8TAPNdDSrtP4NtISQ9jNiQycHRDyzVieD8qioW/bdI5ZXEbTumCIU8A6VU3SXFNmpC2y6KxgfTUldXSN5iPld6fn1Fse5ANfNfu6V0gG2dUp691qhvVi8NWdiUCVw9Kq72lWMCstQmtLj9L2g716t56XEsxHQ1/eHQFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6wi+AkmrdVXhwbF9U8L/CrH+T4javGvPOhk9ojLIQ0=;
 b=CWd0Ox7hlSHys1zyoovjO5KOLxQoPZhSAChIia/b0lIn7W6twshDhCrxeRQ8ygk2xpdwJVS2jUc6W/wQKkATr+obMGvb4qe7oPcZmmiCuJ1gzud2ICBvLmUSfHcc673luczONIx4ntc+ikwsdYaIw88eMmh4Emrdp8BU8dU6vLK0kH5kM6LIe3BOSg6mKy9TJYSVrXmxEvFJLZ1nrHyG6Q5dHM/jEyOWkVW8+wcWWbIdla3fPaOn5EvJaYMy6b2pPv3wvIebN+1QcJMzOJxwDV1a+v+VDdXoX8ZDaEoNM2sNFsZ0NXB3sVIiggygUbAPu/FIsJnJfjPRDS9l7S6GzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6wi+AkmrdVXhwbF9U8L/CrH+T4javGvPOhk9ojLIQ0=;
 b=bi4Ji7v192stp9plebhMoGQkgLzzGe8V+Rrzw4Xjvcl0TI53dycJG+Il8of2iORhGNtP9M5/H3aUDgrq5zKN99fija2Xf+Ae5YVvU/DP6AUdfSVRZI5pY+YKJpK3F22xIX2ufYcYXuxUEdtXYOcc2kGC3H7VP76CS88vtahC9l0=
Received: from BL0PR02CA0130.namprd02.prod.outlook.com (2603:10b6:208:35::35)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Thu, 16 Jan
 2025 17:43:16 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::68) by BL0PR02CA0130.outlook.office365.com
 (2603:10b6:208:35::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 17:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 17:43:15 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 11:43:13 -0600
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: [PATCH v2 3/4] dax: Update hmem resource/device registration
Date: Thu, 16 Jan 2025 11:42:07 -0600
Message-ID: <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 890cf9a1-f885-41e3-11d3-08dd36554172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwZUr1ajQAxfKgZEAfD2dE9/ZN08IuZyghe7qEBv8XVZrjUVoDQOY6SjDM3j?=
 =?us-ascii?Q?nGQuqoQHukJCaKRJA5g63RwoIS8ZUP/W8by09/5Vdhq+Cf8SmuYfmjOuEWcg?=
 =?us-ascii?Q?tEgBkAT3lfHZlX1gWd5zvUZ14Mz3B+DhdLL8qqmix4L++FJOONklSXTCAlC3?=
 =?us-ascii?Q?ZKUOvJnwZO5fk3FRPdy5J36JjXo7Acrzbs6mPw3CK69GTl7ydHP/O50R72RU?=
 =?us-ascii?Q?+8vOqysW/5HBu5VlRAUx187zhg5PLZAAle9U3mxp+f2KX9iYc30dq5vqpXO2?=
 =?us-ascii?Q?1vUmjc9vwdgR51ZoZpJ+JYe8OgeX0pQ35ul1iRspNsLQHDgXJ6naSawhVjEO?=
 =?us-ascii?Q?ezCPtud49KQbn+lt3A0uZy3huOMd1K9h1k+STlJmToPECkAbcEn6QmcfkJOB?=
 =?us-ascii?Q?oM9D8gcnOOrds3vqDVTYZpuVUcDUDSTnvyB8MDTWwXBbO/TCpV6v6g2YvSse?=
 =?us-ascii?Q?yExGhk4ZpiGajoT+XBgkWquRUiXqGH+Ts0sW9ahVm3a7a1UhfJLhDDJQt9e2?=
 =?us-ascii?Q?EOZwVnyYPqELV/zdEQ4k1WM3G2G0pvt/l0eaYqhOOW5Flg/9mofrrj98mUs9?=
 =?us-ascii?Q?VYOljSDYII/xg0nHUBc6A09/gQWCFhDqRCdnszIeIIocam4TJloTpPlju+Lk?=
 =?us-ascii?Q?sZRps7tAk/GFARERAwVoFem1X+h4wG+6fJgw6y1kTdRGVyFK36ruqXPtjuKF?=
 =?us-ascii?Q?8LwKdOwxE1d5Qgtvpw1oMt5b1INtRWfuy66oS5JYzXWScjiqFUNt4vvGKQnP?=
 =?us-ascii?Q?+An6OOCDmSaIpZ4Bf2Ru/6QpVwltipOwhRu79jMuZV8//mkGffA5ml0eYmEK?=
 =?us-ascii?Q?yJou6uboP2skii12cU2HcEUCSgxg9MFbz9T4UKLrXP+JBJDZ5dH0Ye55vMeK?=
 =?us-ascii?Q?7c2J2zkdHiV3E/sOeS9AD9G6biA/Okme3hhJ057dvwSnBpPRkku3sPnFfNNc?=
 =?us-ascii?Q?qCJ9kPhgt8KNeplVrvlQ7tPVA3zrDq65ThnKy1vb41aOSS2LfO2fBIf0qu8Z?=
 =?us-ascii?Q?Js6jaOVPRxeITbNAY7cKSbmjqzpMokxtEA5EdUxgA6pG0dBBEZnEOEstZqkQ?=
 =?us-ascii?Q?GIrDp9Mnqnrxbsb8oo7Fdn9s+SMU3ixHMF8eJLIgBbD+eoP/+znuBCU9F6iY?=
 =?us-ascii?Q?kwal/AXzNbO6V/iHZzQKX7lpL9dVkeTGpyYI+SLvmFxeVgAkuuKFTTiw3IYi?=
 =?us-ascii?Q?l8z8Fenx8GKi5ZpDiqIxWvV5kwMpgzserjRqBzltjlDOmKkHcwdpQTwShWrQ?=
 =?us-ascii?Q?GclVQVBk7FdY8rnrvJOYe9sHWbWjaNzSy2f23O52OJevd5esOf/cc6S25Ea5?=
 =?us-ascii?Q?BwUyMULBsRTthy4Ni0vtnlv5GwDnkx5/wVeXRJKaV0dBL3FnWOLk4DXrZxQg?=
 =?us-ascii?Q?7tDikHL9KDKuUs5TerMypxij4GKGQF6FkxpaFiF8vIDAVMsgMDDV6fsoQ8RJ?=
 =?us-ascii?Q?ggzN52KlvBJeqdlEVrkw5Bn56HWipCZJj8qJjzA11sk3inj9vqx6ADAycabV?=
 =?us-ascii?Q?4b6Le2OmBMFhMNY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:43:15.3811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890cf9a1-f885-41e3-11d3-08dd36554172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

In order to handle registering hmem devices for SOFT RESERVE reources
that are added late in boot update the hmem_register_resource(),
hmem_register_device(), and walk_hmem_resources() interfaces.

Remove the target_nid arg to hmem_register_resource(). The target nid
value is calculated from the resource start address and not used until
registering a device for the resource. Move the target nid calculation
to hmem_register_device().

To allow for registering hmem devices outside of the hmem dax driver
probe routine save the dax hmem platform driver during probe. The
hmem_register_device() interface can then drop the host and target
nid parameters.

There should be no functional changes.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 drivers/acpi/numa/hmat.c  |  7 ++-----
 drivers/dax/hmem/device.c | 14 ++++++--------
 drivers/dax/hmem/hmem.c   | 12 ++++++++----
 include/linux/dax.h       |  9 ++++-----
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 1a902a02390f..23d4b3ad6d88 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -857,11 +857,8 @@ static void hmat_register_target_devices(struct memory_target *target)
 	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
 		return;
 
-	for (res = target->memregions.child; res; res = res->sibling) {
-		int target_nid = pxm_to_node(target->memory_pxm);
-
-		hmem_register_resource(target_nid, res);
-	}
+	for (res = target->memregions.child; res; res = res->sibling)
+		hmem_register_resource(res);
 }
 
 static void hmat_register_target(struct memory_target *target)
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index f9e1a76a04a9..ae25e08a636f 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -17,14 +17,14 @@ static struct resource hmem_active = {
 	.flags = IORESOURCE_MEM,
 };
 
-int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
+int walk_hmem_resources(walk_hmem_fn fn)
 {
 	struct resource *res;
 	int rc = 0;
 
 	mutex_lock(&hmem_resource_lock);
 	for (res = hmem_active.child; res; res = res->sibling) {
-		rc = fn(host, (int) res->desc, res);
+		rc = fn(res);
 		if (rc)
 			break;
 	}
@@ -33,7 +33,7 @@ int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
 }
 EXPORT_SYMBOL_GPL(walk_hmem_resources);
 
-static void __hmem_register_resource(int target_nid, struct resource *res)
+static void __hmem_register_resource(struct resource *res)
 {
 	struct platform_device *pdev;
 	struct resource *new;
@@ -46,8 +46,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
 		return;
 	}
 
-	new->desc = target_nid;
-
 	if (platform_initialized)
 		return;
 
@@ -64,19 +62,19 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
 		platform_initialized = true;
 }
 
-void hmem_register_resource(int target_nid, struct resource *res)
+void hmem_register_resource(struct resource *res)
 {
 	if (nohmem)
 		return;
 
 	mutex_lock(&hmem_resource_lock);
-	__hmem_register_resource(target_nid, res);
+	__hmem_register_resource(res);
 	mutex_unlock(&hmem_resource_lock);
 }
 
 static __init int hmem_register_one(struct resource *res, void *data)
 {
-	hmem_register_resource(phys_to_target_node(res->start), res);
+	hmem_register_resource(res);
 
 	return 0;
 }
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f18491..088f4060d4d5 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -9,6 +9,8 @@
 static bool region_idle;
 module_param_named(region_idle, region_idle, bool, 0644);
 
+static struct platform_device *dax_hmem_pdev;
+
 static int dax_hmem_probe(struct platform_device *pdev)
 {
 	unsigned long flags = IORESOURCE_DAX_KMEM;
@@ -59,13 +61,13 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
-static int hmem_register_device(struct device *host, int target_nid,
-				const struct resource *res)
+static int hmem_register_device(const struct resource *res)
 {
+	struct device *host = &dax_hmem_pdev->dev;
 	struct platform_device *pdev;
 	struct memregion_info info;
+	int target_nid, rc;
 	long id;
-	int rc;
 
 	if (IS_ENABLED(CONFIG_CXL_REGION) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
@@ -94,6 +96,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 		return -ENOMEM;
 	}
 
+	target_nid = phys_to_target_node(res->start);
 	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
 	info = (struct memregion_info) {
 		.target_node = target_nid,
@@ -125,7 +128,8 @@ static int hmem_register_device(struct device *host, int target_nid,
 
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
-	return walk_hmem_resources(&pdev->dev, hmem_register_device);
+	dax_hmem_pdev = pdev;
+	return walk_hmem_resources(hmem_register_device);
 }
 
 static struct platform_driver dax_hmem_platform_driver = {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e3327af4c..beaa4bcb515c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -276,14 +276,13 @@ static inline int dax_mem2blk_err(int err)
 }
 
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
-void hmem_register_resource(int target_nid, struct resource *r);
+void hmem_register_resource(struct resource *r);
 #else
-static inline void hmem_register_resource(int target_nid, struct resource *r)
+static inline void hmem_register_resource(struct resource *r)
 {
 }
 #endif
 
-typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
-			    const struct resource *res);
-int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
+typedef int (*walk_hmem_fn)(const struct resource *res);
+int walk_hmem_resources(walk_hmem_fn fn);
 #endif
-- 
2.43.0

