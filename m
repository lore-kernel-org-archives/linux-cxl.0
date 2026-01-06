Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9535503F;
	Tue,  6 Jan 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720260; cv=fail; b=ESDic5ZHdP64W/em9nATUXqKp0y7m/RfV2bBx2sRmlCudSKGiPRTYymEOJeW9oTcUd70Xw1Rgw3fjbBQm7Ymjw/BBA1fYxQrcAzVn8QvpFV7nvTJRLHa88vCQCx/yXzf/gyqpTfSmw/y9CC0Fjq8tq2f1Fejus/nbJ1v9C4lSE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720260; c=relaxed/simple;
	bh=UiE+boxSiB9QIVNgPGDY73Fg3VZHp93yTMIrjVTZzUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SdWr/lyXoLEYcQ9HbCsJ40PUYVrPB1zK1mw9yu8FIg8Uzax062wVpbsuq6hczCP1BySpHfbNJL4sZ9JvYPBUCybcaN3MzVwHi4GTvWmdgrV9F8Zq36n16dOBCZXgq8mlPq02M6pynr997RdvdIZYYYiVPaFMD9U0YPZePVc0oc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hqqw0nIA; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hqqw0nIA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHgJCZOcbNpKbSOe2ZisNJVF5lRPNsNz+r9VCDnhP0VTxfn/YZ+xmCr2GiNtjI9jQdNzySpb545ApYDn3BmVHFW4bwRplI1SVCUFqxIgcf1bJEM+NCCqTj7JpbyWcuqPjsykhy5SYEpWCDs02uFEO/e35rGkL1yg9jkzS7Z0xfcEU2ea/sourouzbgfiFo3Ki2ZnjP0BZPaQrPgsTeggwwYAEcf5lkKZ9Z0AqEuv2d8tI194/iMiOBrZRS+pv9YIVlKi4HkENBlq02BrJ6bAqgzrr0z3p4Ie+RzuAPQhMuqllbIUEiojp226oIH97OIEnnwbCzXMQO16ZA8dGJz4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFNqAnvkJZkjMwvvVZvZKykAyik86F+Qk/9c/TLAq4M=;
 b=X5zhc3dg6WNIbLokvAn9TosRBXMay+D2fRwTbjKXCJOhELCFX3jgva879cJrPUvJRC0AVokW3C9INvztY0sQa32aBE3U+vc4gEBcU42GtNw8QNu29DFej2GK5An+g+/Kw8tU7ToB62LrSmMnDUI6lZxD8hQ7I4nvEOXKMmv1s1ZMfs+Zp9FikNI9828IZpb1aJr2yZlj1DupSbJpMZnBlfQ+pVhc3gBVrjV0FoaKwaPvPtZ0/1/SwzK2W4UDe6cDKaBZpuxSXEar+KYub+mnDXgpLi0Ywz5+ST9qhS3Hz80i2BYTEGHWK2tGtA4tcwREXx51vEf4BxvP67pUAl3Ygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFNqAnvkJZkjMwvvVZvZKykAyik86F+Qk/9c/TLAq4M=;
 b=Hqqw0nIACVsJAxly5w4/yJfevqSmD8WWW+UUfunW98eDoFyUPNSlisi4Ejh+rQi4iTJmqxr4NUZ7iOY3/Mc/q2aAYCkUvu4/dZanWqkyvY3lS1cYMZUtV7+GgoWzxOA+pMyajxrd9RdeQ7r2usItLsM2rcIFOWqZLGzZMYj95pA=
Received: from SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 17:24:15 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::4c) by SJ0PR13CA0013.outlook.office365.com
 (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 17:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 17:24:14 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 11:24:11 -0600
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cxl: Check for invalid addresses returned from translation functions on errors
Date: Tue, 6 Jan 2026 18:23:58 +0100
Message-ID: <20260106172358.350724-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: a13140f5-9b9e-4b20-5d3b-08de4d4869e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3C8AhXjxQhGZfWhoaOv/7hF6eiXfVL2vQdeqpt3pVUKnQA/lYh7JtdIt4Yi?=
 =?us-ascii?Q?hKYFOpVk29FmWe87kWnxaeNlXk0G3S7L+qO+YitCaPqdFuL1UPF3TGhnb4wI?=
 =?us-ascii?Q?pF42Kv18Qoph3tkFbbFJyOOTolTUDgDi7V42anLI1eySWMxVxnOcCbL9OsFq?=
 =?us-ascii?Q?/K42x7/XUIP1+bZM1QBdV04EBZ2BgxgOiilZqfaMz3SBS0YnJ91HiLkPsaH9?=
 =?us-ascii?Q?QbChLlyxixl8dlS8hsYJEzSmJCIB1b4AdhgCV4UC/0eVhSReBB9GN77YpsTW?=
 =?us-ascii?Q?1civrObXf6Imu2Nq3kZJhvz93aIfKiFow/r6AxK8iEkZzB/mUVfov/UnqUfg?=
 =?us-ascii?Q?VMiBSUAZdmTx9k6bvZQu6iA6oWADdtnWP+iDRfdtEhA1qffhQ++bfX4/MBto?=
 =?us-ascii?Q?SSISb/vKsceaBWWSmeJiKh7Ki+nOV+3pd7Nl2NP8kRSEratPW0HhGepxOmyN?=
 =?us-ascii?Q?70VOKUM4KtZGhiz3WW7iEaD2aI3kNpZrl/OUTas2fqiP11chVC+Rnl6AStOD?=
 =?us-ascii?Q?Ogz6e/cHfrZQAqSwdjzqrFmGx9CdlDp+fa0MujqOF9DIwakYwq5X6vsSc/rI?=
 =?us-ascii?Q?PMfN0NPeHG90HuqqykMPIOARdSrfGEzaw9Rz2w7wNSqbiA+Z7oUtAINrAvhw?=
 =?us-ascii?Q?XVsdVjSjm+i3cZk1qsdrvzWyJObmeNjeGVQAxYYPWVNN0FzPHOmy6RP5uY+A?=
 =?us-ascii?Q?nva2agLKLeDxkApBLcoYzNeCaJVO9IaaLI4EqQJl0lFNdef+eK4K5YlEob75?=
 =?us-ascii?Q?pkKrCeFUyEp4ireW+Df4KYegpNEG2PkrHCL6+YoKv5Y4bOAoCCZV/xn1cfk0?=
 =?us-ascii?Q?s+bHnXH8HIZI7BeL/zo6lEK95dMdgDnQsdiqj9amYOLFTqeu8+iaYiBS8pUw?=
 =?us-ascii?Q?02rUXGjoaYHRZ1EKTzfh1M/+dbsO0DXVfAePBTrOx47KxGqWXgvI5ZJPjvtg?=
 =?us-ascii?Q?3EJa6o8CPYyMa4xEW3WTkUlbP61gofpBcvszXO1cvWb5USWAT8S1mel/H6m1?=
 =?us-ascii?Q?5HwdncZEkp+hjzWBgRGZAEj4WjU/msnTd5CJY1sb2MPB/O+TFOXUHGdwufw0?=
 =?us-ascii?Q?P2TWhk7d5secaUPEmjtksTbUZg4RJqurNIFBPDz216LwJPiHZO3qLFfvzNjx?=
 =?us-ascii?Q?reXIJpqxewiYMpSjzmgjJoTpCsS1ypXfszEGxZFTVJ2nZKpD5cE4g0hRZo1w?=
 =?us-ascii?Q?JFOMTw3wZ4HAUQb7e1YZ/X3h42HNdATggYNKaG+iz/kqXrV6s0PU78iOjj/R?=
 =?us-ascii?Q?TIcqqzQh6ApjhhStkKrLjmUD0awnDxb9UdXwIxVGe7KmVm2xv/nqEyhMkjrL?=
 =?us-ascii?Q?gyhVpIopOjyoGV5Fk5MrZ15LteGcv/m4o/xOy0a5AfWNuVS9tuTQ72627er9?=
 =?us-ascii?Q?kly8TJNBvmR2zoUrmZgBvL29FeySDAsujyM3kYnGEIjqteOtrXpvBv/6m9Pa?=
 =?us-ascii?Q?TcLgHOABERXOwfAMz6RQp7Tf+/bzT7Qhaiw7Es/CkD6Fpv9/ZhAbHr3oD7W7?=
 =?us-ascii?Q?uCg/XeELxyCiwRr1ki6tmwTf9SY0NNAM0hJ71biCdyXOD4Npz5Nk8MWHNyNg?=
 =?us-ascii?Q?WC1FFuKBKSTqz84Yhdw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:24:14.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13140f5-9b9e-4b20-5d3b-08de4d4869e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626

Translation functions may return an invalid address in case of errors.
If the address is not checked the further use of the invalid value
will cause an address corruption.

Consistently check for a valid address returned by translation
functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
or ULLONG_MAX is used to indicate an address error.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
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
 tools/testing/cxl/test/cxl_translate.c |  5 ++--
 3 files changed, 30 insertions(+), 11 deletions(-)

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
index 2200ae21795c..c2af918b853e 100644
--- a/tools/testing/cxl/test/cxl_translate.c
+++ b/tools/testing/cxl/test/cxl_translate.c
@@ -69,7 +69,7 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
 	/* Calculate base HPA offset from DPA and position */
 	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
 
-	if (math == XOR_MATH) {
+	if (hpa_offset != ULLONG_MAX && math == XOR_MATH) {
 		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
 		if (cximsd->nr_maps)
 			return cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
@@ -262,7 +262,8 @@ static int test_random_params(void)
 		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
 		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
 
-		if (reverse_dpa != dpa || reverse_pos != pos) {
+		if (hpa == ULLONG_MAX || reverse_dpa != dpa ||
+		    reverse_pos != pos) {
 			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
 			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
 			       eig);

base-commit: 88c72bab77aaf389beccf762e112828253ca0564
-- 
2.47.3

