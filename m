Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71703320A0C;
	Mon,  3 Nov 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195794; cv=fail; b=feps7GUO0PL9jJp8L3TbNxwEg8NotEYx1bq7A3yD3FSAX2f78zq1M6pRALryaeFcTyCv5DNtaUWwn2DKRj3gqzIxu0lYmbZmz6oO9IXJAg3NiiOWRbHSHbXQpFe7JHfGCw0crV+2ouhNlsFJsr45xiD5ylPnNCaPwJ1bCQZv1pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195794; c=relaxed/simple;
	bh=QOpgFIHYnbRh0weHpuEQY6melJgmb9rhCrW3TeCgd3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDeujZE0zxemYUqvJWtyhats0OFymip9oKHCapn9+iBQPn1+F2dWM0Z08f4MIu1xhU+R7MMsWZumzi21X/yAZ0gtvZAdKCWJGyaU1SvxfSvEUWX8rz8lfLHJtJipvuJVSzPnb4mTu4yFj7C8+jb4T4P9AsiHGzQSHM6l7UHq0EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n+VP46+Y; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n+VP46+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4Y49hDjslq769BLXXEEweFkm/FryiFTuNRmuTzhhswkiBJNlYjMu3KrzBI0KDLyrtCvi6iue46M58LIjBFDmSFdaelKc7q+tlOnAZyoCtnI7ncIWrxizlXSGvetg5M8Pz79GA6Blgq1XzOifN0M1aH3MaV7bKWTGZIIty3iPibqB0ZcJd9vI5Wdde2lmF0iRRV2oB+/ZTcraVulRjnYoCXvzZmueHqyPaf6Us5dlLTnmtSdPOOQoUopzAkLeo9du5NIm5pKXeBMtYumXIPcKW+JzZ7SIl52x2YVi1qeO63Cs78TnQo/8jjRVGmx/qaPmw/bWM1t7zjZ709eS+D/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mw5wsx5CzRwgDzjExjxxNumv/WyaVoKJp4KERjza+8=;
 b=knYKqMothmhMqQ0PWRNWH+NDX/BCiMft8/AJ/fZTH8QwVPLaWal3fCc7ZpB6GDu/wqMKBxuV3UnuG7cbkhXwbfTnR0NiZNd4Bi9PUvG8CnCFrFrKjQESoBCWCYVxs5E1LG9RFjjkKRZtOS1CqUBFic5629WahltOGGTt/1x3pgHHWRz3IBcx3HoUp0ylJHSY4vK1DlPbEiNBAnNNa8JEkzPhb6wU806vjIcIxsbu2VAyXa532gL+F/o8z/rT4d96Ao+HKzJ+SOvTeqt+Xh7MqIVt2QgbVaZMnR3O2Knn+ZSrSNZB1+P+X6zv8b2YQqh+6k9iFwUbk1zbvxZnsp85bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mw5wsx5CzRwgDzjExjxxNumv/WyaVoKJp4KERjza+8=;
 b=n+VP46+Ydb7wn9MFS4lYAeGyHPJCg5hHv28Zrh681VzjZKtgeBEyNsPCVJHktue+GcpwmizLfxsoqprZILPiuiAV591LK5WIImaNKurbCze5D+L55ElWtQqn7FOJK62YHLADwtegeSGKTdpMFRocKC3pzVNwCHTI8wSYphGyxWc=
Received: from BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:49:47 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::3a) by BLAPR03CA0126.outlook.office365.com
 (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:46 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:41 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 12/14] cxl: Simplify cxl_rd_ops allocation and handling
Date: Mon, 3 Nov 2025 19:47:53 +0100
Message-ID: <20251103184804.509762-13-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 215e9b9f-781b-4061-3c40-08de1b09c2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4cQX45c8C+XQqZcYDuTQX7rKzKXkB1aKM+kKdTU/98NKMJuhZgLu/UUoltiQ?=
 =?us-ascii?Q?xe5Eb/F+2FVS0zoxc5wNgbUArCDtTrIwz5XUBnOanxUJYWaNPg/mgBahhKcQ?=
 =?us-ascii?Q?/nvazuLEdrpiopvrdjVQviRCw7pOMBvRCDPdkhm+/uy4ivkx7z6+SbXGMAEU?=
 =?us-ascii?Q?mS35Lhr3S7lDbLNJFW2ybGArvN3ulRmcHzshxsqLuT/ZP2RR5f6uxJJAB59s?=
 =?us-ascii?Q?wUD9wMu5j641TrhOMKugBSJbLBtKuujegBSkBuclbH+ZgT3wH2JBQXqK1Vm0?=
 =?us-ascii?Q?1Up+e/ObuNrWJu50S25Ejb0KG0Cu79TKSHCGPDWtq53Fq9AhfqVmvcbSEWNk?=
 =?us-ascii?Q?PJpE5hAf2AKFPmEXle8OQcsYOMYjq70Xx4Ql1Hj9H8gWj4Cdtn7RjzxUAd0k?=
 =?us-ascii?Q?OZJIsLG1S+x4BQgCTO/UVDwLcQ8Pqet7ftnlMPRZp+Mlf6GJ0WjKyDj/imP9?=
 =?us-ascii?Q?/Nu+g2Ajg3W9ZOazVZ/zxrkCuPhlZX//rYEqDjrJGYXg1tK9gpgUTMgcWZTo?=
 =?us-ascii?Q?fLrYMTypAvWKbij/19ULpgQZuIndsfzwelY3YlYJ6e+i8l/HP34tny9wyA1P?=
 =?us-ascii?Q?k1VTsx309yShsai8K9oFivcoZQizmNByqrAzeEEhr2W9yEMgGRErmS+66lDH?=
 =?us-ascii?Q?/sxyfbZ2EwIYOT1s+jgAp6Gh98X6XZW2jDuL4nt4ls4C+tAXiVDI/0DXrsID?=
 =?us-ascii?Q?55I82gnQGt+qmY7wkwa/kFRU4ZM/qsDR8FT/jnoT39XCgmS0HQKmkluK5oNb?=
 =?us-ascii?Q?i76MgsHbFdB/4r/md8bVL+l6n2cTYlz1t371trS/+JHvN6KWOF4cvaQNzeDe?=
 =?us-ascii?Q?vW0HiHsWwRq7yjh5q+7FJf9le4nnK1+M0x00eSNb5fCqKCw8fhkD4ELCOeNk?=
 =?us-ascii?Q?LwEp4E4vMBkpJCpzfxwiNYyQ2x1YhyBFbotX0ykG2GpE0PvDHYWGEHqIty1t?=
 =?us-ascii?Q?3mzmW2F/5Y3tTim7HvhP6a7IqYGCidOxnn9C8/Q7+XzNBPBmau7CH1fgFqiZ?=
 =?us-ascii?Q?d8+73rO511+uNqikbnb/aSEovGuBdyzO+j933YejsgtkDWFrTj0s6dGjQ4pS?=
 =?us-ascii?Q?VZT3s7Rhf7QBfB+XFst8Z2v8eQUqVmRkvXUNrWNqooqP8TJzQo1Po5ImY/8d?=
 =?us-ascii?Q?66QOo1eetmeojl7FwkS4NcLllSiyc6djusrq3gc38G3hVSLTqegPDFZ00I2k?=
 =?us-ascii?Q?Ba6rJxb19YfUeKN3057dZaJtM6R3KFWzypfu+y14Tm2RHb9iUIcQpUmoqmsq?=
 =?us-ascii?Q?FoSOfTnmpwYdb0RwyoftIXGD+wxKa83KUI5K17gdhzZB6H2aUGjKWJVx7VNy?=
 =?us-ascii?Q?b90TWtV2nIUe3r0aOdKvkBG1LmLgiv3YXnQkWTM3Iuep8IPUG1tvCV5d+F7N?=
 =?us-ascii?Q?vq0Lz8ahtFogDTfnBl4021it3y9p28W2zJ9zHZkDQH7xp3yHBlOjreQzktkn?=
 =?us-ascii?Q?+g84YXNDIXbiHOrNtLiO3DmwQkzFjUU7whMRzoP6bTzCIjxoMmHJocM7lfO6?=
 =?us-ascii?Q?mwAKP1L7fxqHk7oxQsdbE5k9lFI4JA86Soo1QUVOQ2/7Tzk3TleXIf+aj8Jb?=
 =?us-ascii?Q?nSXhNwO+n+LftQUecFI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:46.8001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215e9b9f-781b-4061-3c40-08de1b09c2b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

A root decoder's callback handlers are collected in struct cxl_rd_ops.
The structure is dynamically allocated, though it contains only a few
pointers in it. This also requires to check two pointes to check for
the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statical in struct cxl_root_decoder.

Implementation is equivalent to how struct cxl_root_ops handles the
callbacks.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        |  8 ++------
 drivers/cxl/core/region.c | 20 +++++---------------
 drivers/cxl/cxl.h         |  2 +-
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f9bbc77f3ec2..778ee29430ea 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -471,12 +471,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
-		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
-		if (!cxlrd->ops)
-			return -ENOMEM;
-
-		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
-		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
+		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
+		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
 	rc = cxl_decoder_add(cxld);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 379a67cc8e31..dec003084521 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2932,16 +2932,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
-static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
-}
-
-static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
-}
-
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
@@ -2996,8 +2986,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (has_hpa_to_spa(cxlrd))
-		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
+	if (cxlrd->ops.hpa_to_spa)
+		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
@@ -3006,7 +2996,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;
@@ -3041,8 +3031,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
 	 * CXL HPA is assumed to equal SPA.
 	 */
-	if (has_spa_to_hpa(cxlrd)) {
-		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
+	if (cxlrd->ops.spa_to_hpa) {
+		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
 		hpa_offset = hpa - p->res->start;
 	} else {
 		hpa_offset = offset;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0af46d1b0abc..75fd45ddca38 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -451,7 +451,7 @@ struct cxl_root_decoder {
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-	struct cxl_rd_ops *ops;
+	struct cxl_rd_ops ops;
 	struct cxl_switch_decoder cxlsd;
 };
 
-- 
2.47.3

