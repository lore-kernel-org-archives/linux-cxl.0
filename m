Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588030FC01;
	Wed,  7 Jan 2026 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787574; cv=fail; b=FgpJB10itVYVGbqBE0SszrDzclYfOm6yOcu7t/o/qVeUdIOxFlDgThQocGKWu6nfX3K00R7LN5FM2aSFMWRBbhyBhc0cJoQCb/zov9pN1MUvx2dxQhCNKenxqCANbX97FjBX7hkNHUp0aI5c1fiMJ1ACKbYJhzq0izP87PQcYys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787574; c=relaxed/simple;
	bh=DiuQsdwJOeGASXwD+uGTEMPgu4ez63kpSCRP7z3ILfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yas2BBmwoKuf146bUc0febwvUryZ9WAtwkjvky5mIv/fy6Nuuk115xvUxnRthsEI32ryctjtsRPYGndt0tTu30g+V7Ss9fjZ4Bn3jSqSo9bUstjgnXz+1mNrxROUZYB2AYujeObdQ7ms9UU5tLRP2QRNMlmMt4/LrusOegTY9Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vNNjp4Zq; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vNNjp4Zq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beh4nwXsZ6P9bJ7lfOqwou3PvTrBG/C640jvUfraKA4t6XAvJIc+8Y5AkEbygLNNq+QiTsjVjYlME6Q7FVAWPJUrRV3572xQBtpcN4x23aCwVcGdcPF6fKWo9XxAgS/GJsOg087OiLGxYyHWj1RmL0W4cOz5NyfS+Mws+qq5orCvPt/CeM6gp8o8pTkb+MW8fE5Biv+I2BY7XPjIqGtm2+B4+NJTyygd1T2L7s5wJXmAm2qxYHqLn/DGW83EpvgDVnKDNWFflXdqxOJ4iIcG/XQilgm5/5oQxRZjVG+oyCZbn64tODjNdEh1F3PAg6po+HXTzAn0hWcHM4aQLwxdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyP/4C9b8aApe+oE/Wxq0GN19mvjwvmtJgD96p+QdWM=;
 b=n0gbwyKKX9rUwhEar4sQ0xDl0JS2GBfgqOpypnQCWCNh/qxRR7Tl50gveM1AeFDCfEzAR5wevlHH5ggvfxmuuKlw+3JuG8owgqUanOroHgCXwV9didz0LKsPw6i0P7a4L/2dmcMpr9q5kuT2YoxOL1uBnQO6zOq2rRt3f5FktQ61z6icodeE5+Qx03QKWpH7H73V3SWgrnqTer1XOf3qDlHqYmfYPTLGFtmhfC0r5U1T1N49smPeGNCKDU8VjthvFXH6KpWvypjnjInKNOKqqQhljT8RPviD3swhScswGt3EZmFFHVhAKaHk8AMz9o2B1l3mxizq4dSjN8y1qFeIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyP/4C9b8aApe+oE/Wxq0GN19mvjwvmtJgD96p+QdWM=;
 b=vNNjp4ZqMY2bq3ISbgjdspRc8O/PBmRw4i3NAtZpNJE3bygCEgQFvAqvdjl0enhjxiRsbk4ckhUMWrSMzXtwRXGzHPkwjcB4dD0ofWJCytocFdSwrko/4ylLEC2SE/+LakzE3wJxsOfCKFWdP3BQ+NFgeNWesFmxLq3yJ7Y5sG8=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:06:07 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::94) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Wed, 7
 Jan 2026 12:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 12:06:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 06:06:06 -0600
Received: from rric.localdomain (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 04:06:04 -0800
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cxl: Check for invalid addresses returned from translation functions on errors
Date: Wed, 7 Jan 2026 13:05:43 +0100
Message-ID: <20260107120544.410993-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 69400509-cca1-4e49-9941-08de4de5232c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESdeeQtPYObSMKuv2+6fAe7YXO6CD8Dm39c/V0kgAhvUKUHvAHQzwtkXZnZh?=
 =?us-ascii?Q?brH849RpIGJAT2DWz4yWBSKjCIj97UNKqozJ848MndnScU8V7P27rhoF0XS3?=
 =?us-ascii?Q?fi7byStcmFfOSZ+xHWYMQjnZfWohMS1q3MHcOOAqpTJ4dhNfcS8yFtgv8qHB?=
 =?us-ascii?Q?tPYXmCKl8FV3AsOv+2sxhOesKWV74DjoH9/G7WZjSP6Tk/JEQV35hn6OpaWv?=
 =?us-ascii?Q?b9pWgqzutCdV2Mb8gA5mvqeqeKOssWueVBBnpUpf9zZFhKTLfcPIXexI3/Qv?=
 =?us-ascii?Q?6GQQvAVLw8O7H1BIiCMbcvHKANO+v56bjiQvobTz4+AvKDpR5uJhe0wChM95?=
 =?us-ascii?Q?VSJSXnzPpDo2pIA5NQJ5EHDf1YR8jnGMe221VmwH27vVaILUIDq/plWhFqEC?=
 =?us-ascii?Q?2JIqBvZZsuhVEtvlYO5hzvCdK2AJDRSZurj3Bx6RkBTfVouXrVLMV4SqWHkF?=
 =?us-ascii?Q?CpfgwWnHT0a2x0TPKWnWFcXpXCxWNzXm6TjTN/m+DjS5pmtytnrvx9bzmVRt?=
 =?us-ascii?Q?Oh0nyEhLCK0gfR5bZmVAMb11C6mr+5yeESHCpM2vksu4C2CDsxMXuMk4E8Ce?=
 =?us-ascii?Q?vmHM+FHJTQw42alrvn7/yl7Rom95PYGJslk87b0kypCc+ki7TVpGxHPsV1qs?=
 =?us-ascii?Q?TWctLnedBAkWtLmU2k4VmZb/lKWrxLbK+7TI1nzDnqrqUFPjrOna6qujtpbL?=
 =?us-ascii?Q?C2DL5XKxjOFt2BmEphK+6lfDronzHfdvNT0XofXjjhA4I/Mf5A18Wn2/ACHJ?=
 =?us-ascii?Q?vI7yFWAetMCihjv8zV/WvY5gZlcmpvbhmSK54rurisxvenXi4s3NQg5sGwR3?=
 =?us-ascii?Q?9T/uPTUEeIKg+MPUxDJyaMvI3ZCcrsWnAcPQmqz4+IRpadHm3xd/5rdktMJz?=
 =?us-ascii?Q?0NxK09A0Hu3LsPKJZFEdcwIb1LjTOtcX8nf4dGsVpejjRYyuqdOcwS24Ldew?=
 =?us-ascii?Q?BIteDUd2WX4yD3/0yLNZxFwtj2oXoyLeZNIXnLykSumX0XfB9nex+oF2idmp?=
 =?us-ascii?Q?mLeIU4p78roDyLVEXvRDszFDxXKyEcuWz1zPQFLBLBm7qLcJXwRb/+w5/Hwi?=
 =?us-ascii?Q?I40HvaqxUWVn7yZ8bwhT3Th9R8C5oL60tcFuENJnqMGKRgj0RWnvHxbdk9U/?=
 =?us-ascii?Q?AikrRWQb9fZboB83ne/yEDN+mYIL73UcfCXVdzBEnaxipmzu3pphtQhOmVKI?=
 =?us-ascii?Q?x3TjNBq3Sh2vRPFvNaKhIJHx+Gvh3gaG0iRUQNmIT6NIj0Z35w4/XVaSVTat?=
 =?us-ascii?Q?rx1KVS8wzrPK+Qg7/pF0f8+iT4FZUvdvhq41CglovUR6xRuhbaTPOjSh+xSv?=
 =?us-ascii?Q?LYvB/nf9wbwsLy7kBJLWMHUmeia+7qHT2oCxVwUbVmOY3TJt1FVPra5Mv8rK?=
 =?us-ascii?Q?XcIf70T3dtY4NewgkMN4f+niSIhuo0qgWYWuhMzsLA0wIMJCbYsBgwVMRiJf?=
 =?us-ascii?Q?P/m1amlSQRjtIbOdey2mzIeHUl4cyiS1LG2i2kKUYXGVTGEsu9E116Dw3h6z?=
 =?us-ascii?Q?ddftdvz7gYQH0kkuf27wJeFMCxVGeEe+CGS3LUXxBUloZZ76GyKlJrEdAKgt?=
 =?us-ascii?Q?rIt3SOsUQK5czkc0cRo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:06:06.5295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69400509-cca1-4e49-9941-08de4de5232c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

Translation functions may return an invalid address in case of errors.
If the address is not checked the further use of the invalid value
will cause an address corruption.

Consistently check for a valid address returned by translation
functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
or ULLONG_MAX is used to indicate an address error.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v3:
 * updated sob-chain,
 * changed error handling flow in test/cxl_translate.c (Alison),

v2:
 * separated from this patch series (Alison):
   [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
 * improved error handling logic and early return on error in
   region_offset_to_dpa_result() (Dave),
 * use RESOURCE_SIZE_MAX to indicate an invalid address for
   resource_size_t types (Alison, kernel test robot),
 * improved patch description (Alison),
 * added line wrap for code >80 chars.
---

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/hdm.c                 |  2 +-
 drivers/cxl/core/region.c              | 34 ++++++++++++++++++++------
 tools/testing/cxl/test/cxl_translate.c | 30 ++++++++++++++---------
 3 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1c5d2022c87a..031672e92b0b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
-	resource_size_t base = -1;
+	resource_size_t base = RESOURCE_SIZE_MAX;
 
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	if (cxled->dpa_res)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fc36a5413d3f..5bd1213737fa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3118,7 +3118,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
-	u64 dpa_offset, hpa_offset, hpa;
+	u64 base, dpa_offset, hpa_offset, hpa;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3136,8 +3136,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
 
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+	base = cxl_dpa_resource_start(cxled);
+	if (base == RESOURCE_SIZE_MAX)
+		return ULLONG_MAX;
+
+	dpa_offset = dpa - base;
 	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
+	if (hpa_offset == ULLONG_MAX)
+		return ULLONG_MAX;
 
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start + p->cache_size;
@@ -3146,6 +3152,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (cxlrd->ops.hpa_to_spa)
 		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
+	if (hpa == ULLONG_MAX)
+		return ULLONG_MAX;
+
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
 			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
@@ -3170,7 +3179,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_endpoint_decoder *cxled;
-	u64 hpa, hpa_offset, dpa_offset;
+	u64 hpa_offset = offset;
+	u64 dpa, dpa_offset;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3187,10 +3197,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	 * CXL HPA is assumed to equal SPA.
 	 */
 	if (cxlrd->ops.spa_to_hpa) {
-		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
-		hpa_offset = hpa - p->res->start;
-	} else {
-		hpa_offset = offset;
+		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
+		if (hpa_offset == ULLONG_MAX) {
+			dev_dbg(&cxlr->dev, "HPA not found for %pr offset %#llx\n",
+				p->res, offset);
+			return -ENXIO;
+		}
+		hpa_offset -= p->res->start;
 	}
 
 	pos = cxl_calculate_position(hpa_offset, eiw, eig);
@@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 		cxled = p->targets[i];
 		if (cxled->pos != pos)
 			continue;
+
+		dpa = cxl_dpa_resource_start(cxled);
+		if (dpa != RESOURCE_SIZE_MAX)
+			dpa += dpa_offset;
+
 		result->cxlmd = cxled_to_memdev(cxled);
-		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
+		result->dpa = dpa;
 
 		return 0;
 	}
diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
index 2200ae21795c..2d9b75b30dbc 100644
--- a/tools/testing/cxl/test/cxl_translate.c
+++ b/tools/testing/cxl/test/cxl_translate.c
@@ -68,6 +68,8 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
 
 	/* Calculate base HPA offset from DPA and position */
 	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
+	if (hpa_offset == ULLONG_MAX)
+		return ULLONG_MAX;
 
 	if (math == XOR_MATH) {
 		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
@@ -258,19 +260,23 @@ static int test_random_params(void)
 		pos = get_random_u32() % ways;
 		dpa = get_random_u64() >> 12;
 
+		reverse_dpa = ULLONG_MAX;
+		reverse_pos = -1;
+
 		hpa = cxl_calculate_hpa_offset(dpa, pos, eiw, eig);
-		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
-		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
-
-		if (reverse_dpa != dpa || reverse_pos != pos) {
-			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
-			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
-			       eig);
-
-			if (failures++ > 10) {
-				pr_err("test random too many failures, stop\n");
-				break;
-			}
+		if (hpa != ULLONG_MAX) {
+			reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
+			reverse_pos = cxl_calculate_position(hpa, eiw, eig);
+			if (reverse_dpa == dpa && reverse_pos == pos)
+				continue;
+		}
+
+		pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
+			i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);
+
+		if (failures++ > 10) {
+			pr_err("test random too many failures, stop\n");
+			break;
 		}
 	}
 	pr_info("..... test random: PASS %d FAIL %d\n", i - failures, failures);

base-commit: 88c72bab77aaf389beccf762e112828253ca0564
-- 
2.47.3

