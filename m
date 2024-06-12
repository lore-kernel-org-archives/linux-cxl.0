Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0C43144
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225964; cv=fail; b=RBODy9RILeNr2uhe9iwMmn9htIOWgzKWd6lAlicrXG4iHky7yGlkyVEuINP0/lwhluSIOnrLK/5vSRHXf3kmt9iXA5NDsWbS6Y+pfpUPSSjer2O5NCwWBsQLYiCi4CKGO43XCOsLQQAELttcfQlBuuvoXE7Ulc20HwTqgy51+xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225964; c=relaxed/simple;
	bh=NDnyjGt03f47VvpVKNbGLAx/RLZwtikaMiiczUtZk8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rifaY3bJD/vAXowZ5a62nzzK4YBuwVO1wH1jsZ0jBXkCYn9U7xcMhqp+SS1LW6eYwMgZlXv8EE+G4H4YVHi7BxPRR4VwU1oJKH163xAH0G6C10s+Tov4No6p7a67dqnnS7TAx3y/CxIS4crEdRB6T8Qt4bzZakef7KmsOBRwI20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uSUlZmvu; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uSUlZmvu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOYFog/LvFTP3box+fM3aD5W6HbWKs10m80NSMx0GEBk8Ru8MSRWtC9dXW1W8KXPmde4L2OszM7kj5SW4MvkNdhDFDYfeiXgFHh4Ll1tT0T9RTRdjcXZm13W0BkR+m5Yvp+xaUZImzYJ3X2U10VSo69ur8pVnrVFTb3v85l3tzqPl94qiLGnAm628BmtPZU3qfVySaepbgHVtm2dIVgPHih0bOprJ1cpKeJ8beW2V35P2vpy1l1+i0/gs/GnKDGfKyYtbxAtQ5gpTS6/KobMbn6ecVfOAjWZwPjvrMwf1vdJJx0qdCUViUaTGyObE9C8j0isNp/0qr7QPusIBJ2EYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7F6bh39n1y5gRC1xUDtptUBV9pzQY1XU1wTMkLMkjQ=;
 b=G1mtnPEnhRy2lOWag2aUZYYfSqR7Z7q7sBwXaoo2YiKm3HV26XYE3pHyO82X8dL0M0g+xrz8xnx5ptWJNvDh+SUy0Au4jQPOXRmOZ69Ll/OeVmClHAUS/7JuzPPNhFY2zb/o3vR9N22kgGg10Nsa6MYAWVZuvxwYoZmpuc3uHawUQClCyzUjmYgM9K3DCPENQlSF918xu/xOCixiM2aoUUEJuhQzc5lZoKQpiQ4F4vAZBTkwpVaSo6iOXrsyIPEemi46sfkt9LXgBnTiQSd2MlBavKjmYhIYmD+3xqf+mSdRAZLNp9BdTKGxtqtlJfxlT8BG6hfSY4Ck2WXQ4HptLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7F6bh39n1y5gRC1xUDtptUBV9pzQY1XU1wTMkLMkjQ=;
 b=uSUlZmvuCEUQsQjB894Pue6GyZHyMtU568QmhvBuPfcmtb3twce3Y9X+vVPqGk8L1AOAlvqRFGlzzTVzvdMlSnbnraVg/PYTuMyd5S93huN4gYfgmPioyCStsyP8bF46UkgWIIFrlZ0zrXQpoA3N11IyEvYtHaKCqmKjoZXt6kw=
Received: from BYAPR08CA0067.namprd08.prod.outlook.com (2603:10b6:a03:117::44)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 20:59:20 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::4f) by BYAPR08CA0067.outlook.office365.com
 (2603:10b6:a03:117::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 20:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 20:59:19 +0000
Received: from wookie.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 15:59:18 -0500
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>
Subject: [PATCH] cxl/region: Remove soft reserve resource at region construction
Date: Wed, 12 Jun 2024 15:59:05 -0500
Message-ID: <20240612205905.1209448-1-nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b84b381-891b-4e90-e525-08dc8b2287b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEhLlhfmCRm6w8qAoikwpbEy/j6o9I4OJJWTto8lNZwPZZEswFaFlo89xXQr?=
 =?us-ascii?Q?LU1pNcNG4naL8ogZ1HvmtWnMlhW4zGRNhi2duIcVJvfuPQsZtmY5B0iNnwWy?=
 =?us-ascii?Q?Z026uKS4xyUches5x7FMw2COtcDIEkD8GjOqp3Gc/UnM09IT2Wt62dekx0xf?=
 =?us-ascii?Q?nE22Kud0x/oVAMqBYJc98BPnUwl01d+ZfnBwVKMWmZWf2M1P29fptsHx+bWG?=
 =?us-ascii?Q?ZKqeH2+gOfSbQtOVNo2wn1GvE/yeZrzzTeNOeRksT/gNWR24yHYB/XuQzRWH?=
 =?us-ascii?Q?3s7TdWpd2R1+ZH2ECu2VErFiPBDHvttP3QG44d69KgbejG4CAGQOK8Le/oxi?=
 =?us-ascii?Q?tGr8hhGTPQPIEz/CslZ/Vp/i9PF+6kw/2byNyzMKrfYFpcKQC8QJePof9AWI?=
 =?us-ascii?Q?pAtN35HWydtTTYrJOWnyFPk/EvUzEC0fuSeXFA/huyztt/GVPz7/Fg4d5aQl?=
 =?us-ascii?Q?6Vepa6xGnFZizgtPP7kBd1uxjnwd6Jk2/OlwYcNLCHBLUn8IQaBLb32Kdan4?=
 =?us-ascii?Q?osbsWN3VT3GQKKgiOjFgzz2RJQHopIFUouzP4LDxQAcwFF7bxVbOx1epoRsI?=
 =?us-ascii?Q?2yseaFstxl+kWLoDm+V3f3Nq9l13kHLCWdBW1c1jbLoDsUfcqNbAKahsC96M?=
 =?us-ascii?Q?74uVZjbC8RCctc1r/8eA33aBwhSbMxufJ1OPSjD3am/u9HnAgUDhhGUz7VxQ?=
 =?us-ascii?Q?IRU2b3F1LUuuvb0IxzhOR8CimXqqr7OdWQbm5Hd+JhFP8CL8G8ANMnqkqHT5?=
 =?us-ascii?Q?4RKA+0V6qQ1qga7Z0zniiv00uKgcgd+C/MRSDknHxLvIVEZE0EqXl3SvCmFr?=
 =?us-ascii?Q?UAhUOn0Qkf28xqJkP7Qg5quWI1n8+bIO+p3g9L3ITwtgF5roodj1WMlM0jyL?=
 =?us-ascii?Q?r39hWNgX1tP2X07QWzCIq+UxTBIMzPboOJoCkc/yPhB+59+9bRzXcLTR32NS?=
 =?us-ascii?Q?9W/8kg2gkN+Lx3+GlV/gnYiJ/gVPe4FPH4dy4ylsUbMcyy8DHswPRQS0oSZp?=
 =?us-ascii?Q?VsCgyLFtTS+bpCa0VRQY5gAUNif/lsthNXvqfNKfZK5d1f3GMQzPMLTD5wFE?=
 =?us-ascii?Q?4rB7aRe1RLGuy00o2WfaxJ+2UecgQoJl6E3XL/L8Oy+ISNp84Ey6mKHXOzdP?=
 =?us-ascii?Q?CJBgEkhqkJEDq9GI/xjYjqPWv/ufOJr9lhGwy91+HGjzpTsTgdKHFLELdsdz?=
 =?us-ascii?Q?wz9IDgzKwC2P4T0xBUhjbp0d5kC60gdPKsaWWwiz1+mFFh1uG6o16MR4ojKD?=
 =?us-ascii?Q?G0zwhBvy4j0F7S3tkRU2hl3Y67QfVP2p8pKvEtHhosUesQKkXgen1HA+gytB?=
 =?us-ascii?Q?EumGZyp49W3k8BD927lYYUcPuHzptAVb5U98YP8xwWmhqD+9+HlXyQpV99fO?=
 =?us-ascii?Q?xDq9m3FzL9XjUYU28i8uW3JF/m/i0iKujoBh8U/Buk97RLBs8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 20:59:19.8152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b84b381-891b-4e90-e525-08dc8b2287b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403

Systems with a BIOS that creates soft reserve iomem resources
for memory ranges covered by CXL devices, the soft reserve resource
needs to be removed when hotplugging a CXL device. Without doing
so a new soft reserve for the memory range cannot be created
during hotplug add.

The previous approach from Alison [1] was to fix up the soft
reserve resource at region release so it longer covers the
memory range for the region being removed.

Instead of waiting for region removal, remove the soft reserve
resource when constructing a region. This is done by walking the
children of the region's parent's resources, finding a soft
reserve resource (if it exists) containing the memory range
for the region and removing the soft reserve prior to inserting
the resource for the region being constructed.

[1] https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 drivers/cxl/core/region.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 00a9f0eef8dd..90e5c84230a5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3096,6 +3096,34 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int cxl_insert_resource(struct device *dev, struct resource *parent,
+			       struct resource *res)
+{
+	struct resource *soft;
+	int rc;
+
+	/*
+	 * Find and attempt to remove the SOFT_RESERVED resource
+	 * (if it exists) that includes the range of the new
+	 * resource we're inserting.
+	 */
+	for (soft = parent->child; soft; soft = soft->sibling) {
+		if (soft->desc != IORES_DESC_SOFT_RESERVED)
+			continue;
+
+		if (soft->start <= res->start && soft->end >= res->end) {
+			rc = remove_resource(soft);
+			if (rc)
+				dev_warn(dev,
+					 "Couldn't remove %s resource %llx - %llx\n",
+					 soft->name, soft->start, soft->end);
+			break;
+		}
+	}
+
+	return insert_resource(parent, res);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3142,7 +3170,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
-	rc = insert_resource(cxlrd->res, res);
+	rc = cxl_insert_resource(cxlmd->dev.parent, cxlrd->res, res);
 	if (rc) {
 		/*
 		 * Platform-firmware may not have split resources like "System
-- 
2.34.1

