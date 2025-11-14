Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BC2F7456;
	Fri, 14 Nov 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107164; cv=fail; b=Nv4fScvcAc8GRp81K8lgpb7WKz68E9jYzCGnpEd8Q6kBn6l5NETReKzVsy7piKUm2PSALA2/Ci+HtyzA/ZBit6tUg30NNthdF4lPhNyQPlbP8UNjk3CgxkxrdDdHyd+eQuRa/KgaqkqGjgk0oRPuf9de/nYomrm0TLecizNFBiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107164; c=relaxed/simple;
	bh=9jkOMIC5tcU/+RJ5phcQSBNg9F9lhE1q4X+PxjWRVSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oD0buj61PVA/koV02JCgHTMtb7YF/vYG3qOLJXQ5Z4VaNOSMRz4k+7jXcfp0IKyjEUoJGDIXYM3B5zswLERq2J39ydEHJzULMFClA9kKtfKJ4EUNf+GGFU/yWsVgZgqMzzXgzHsIgNAOEo8ZFY3iCH3huJiBWHRFcyBlvupJ168=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n9z0ZqOo; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n9z0ZqOo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b99DY/OFt5dS8KhHzrIwsUGvQ5emkBlDC58NItcBAW6985mnNT20Q+lsr52FyofYdh6wz2CZeKqlVb2VQ/zMOI1OpvhxOOAPU5EsfbxSZUr2L4WMZWMQpeiYCWuxDNxbvZwGH/+VNIR/mwqplJ4nGT/W6XjBGEuqksWv2Fc/9UGh9OUgeINVa2itEpwTN0b72hJSKIG4AHGXoo//PN8eLI4WRpLutXvn85H2m06TZY4PH04JqX8Ma5eaNCihtDzCfXjAL2/xqwWy/MeLpBGmgNzKs0B5Roe9n1Zfqhnvic6MTMOcObHL8wSZOtDEPawUuOwQh+Ix/FmA2rlH2YKm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnT94NWXXv7D3BznwodwKzNz8sS5Wa79yqnXZQpXqGc=;
 b=oo4LBvQaPM+cfsAyzRbul0adXi0cWCpFDzPXyZ7jnWLMAfnC78pm7jsHpYwsgrE9ykArY8c0ZT9LgABIXdFcn2wNrZl8eij1RntPL2z4A3XQRoHV/C1j2ddmb4skn4y8jAgz+TtPUPIUwQezmNjMiO9mnVwm1N8dpffrW2CLDV0nk70a5dKW7iPoBE/AOZCJasc38vAfgDNUuYL0illE5+FZazv2T+BGDvCmnDwIYxkzHF6xT+S4vmmRzK6HanuypaqTi/q71Yqwrpz2WP/9JRAz9SEmTsuCmuJUUu7q0IakyNnOh90tSAlCuP2zYTSa4VEAplYGF8X/tD5jnsTjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnT94NWXXv7D3BznwodwKzNz8sS5Wa79yqnXZQpXqGc=;
 b=n9z0ZqOoOAtJPIpZL/hyZ+LBr/EA7780qZwNMVql3mj1eaPKoAFbJoJ4SBL8Lffxwbc7sX/+h1BmqzKarbjWmUs1XbL6iedf0qdG3ylOych8zh0cyTqN+g6L0fEGiT0to2Ca+pHNd03GjwH8Alm0Rd1q2fvr77gbez1aUuPUvNo=
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:59:15 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::a8) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 07:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 07:59:14 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 23:59:11 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 1/3] cxl: Simplify cxl_rd_ops allocation and handling
Date: Fri, 14 Nov 2025 08:58:41 +0100
Message-ID: <20251114075844.1315805-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114075844.1315805-1-rrichter@amd.com>
References: <20251114075844.1315805-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: ad51448a-0b21-437f-c07a-08de2353b467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tTHxX6xWWKyoU8GkhzOnQFSCAcBjee8Nsu2eKu3uK3cUc5XbTsX3Y/tfclQq?=
 =?us-ascii?Q?jdVe/01k+A0P654jdtg6Aklz4+dG3iz60mzAf7HZd8VdmUlSpKK7cE9TnOOb?=
 =?us-ascii?Q?awogPbg6NKgtKmwn7k5BHW+eN6clRQtTWNynbkLpYjp2y9z6CUZrjegd2Ksn?=
 =?us-ascii?Q?9w7t081lon0GV7m3fGGOYVfymL3qeEzlKzcdhyvaFCzGSNAzilQ7JfD4PvnT?=
 =?us-ascii?Q?D8rrvA+n8n/HaMdJO/+f6M0YDQU4e+iph6ClVEVTkCT5LacCHZ1alcr84C45?=
 =?us-ascii?Q?bxpGx3I0HyiIzDotg+vQpPf+ldoyrTF4cFh+NE6KjQ9X9aeVwL41uhjbrr4n?=
 =?us-ascii?Q?eBx5SGwwFZ0SAPL/j9Dm3jH/K9VndYfaq4ir2Mg91p+xQT7hevVnpX7LiqlP?=
 =?us-ascii?Q?jRxty0Bv1ukvyBn8+/bcovMM+SmwJ/ftHj2shVZw/plLWs/c6Cxk2u/NApcs?=
 =?us-ascii?Q?gO2IHEJEYBX8wYrYHLiz5j5KO9nTafET0dsIx1nI1yPrLxFcAVgiaEDj18Zx?=
 =?us-ascii?Q?A3g/rqp4skeJmLtoW3YW68irbnjplgC88c1dgtltA36fC3dLYw9Y5lkiH6o+?=
 =?us-ascii?Q?QuvNDMY4wy2+UBG9L5hxFcb3M+rF5x0IKK6xZ468LCgq2uAhQHpX17Ngray6?=
 =?us-ascii?Q?1atSpqQSiA1/sjSH6R47YH5V7lQV5ltye8OxTdENMgjvnBujUTyXLH9YXvtk?=
 =?us-ascii?Q?BVbOcBvA3dkdAtFh2EP3nGCFrI+xNPN65pi7PwwoHN+Augl6ZjhHS0OZw6WO?=
 =?us-ascii?Q?UesA7a3GqKYsYEtPQib6W/P08eDN5+cATk0xFV3SwIV44fr0XjHSfSK3/3NN?=
 =?us-ascii?Q?85r74K2SKN26WPE2ayVHK8Yu6Aqy7NgrSxxoZEC8i7ZBeFlCAoAhtQShKbYX?=
 =?us-ascii?Q?QLlS25FMgVRiVgyvxVIVcYMr7zEMyMyowGP2j8jO9PTmd/S1QqKBUjWbWgvK?=
 =?us-ascii?Q?b+qPcrHxJpFhkTDCdsJkasyN8+dRNG/+6RfNt9f3zEfLrZrJzKCoKHDzPB3U?=
 =?us-ascii?Q?OywS3I+mkLZ95tQCOk1oKqMmG9HsegruHppGzIF31/dx+qLIn0+tejvyezMQ?=
 =?us-ascii?Q?zdVHc5QJy2OiPorWNRxFpYe5BLQkDP3s05iU7XYrO0VYBJiWVVuun+y63NMT?=
 =?us-ascii?Q?TMPuWXcB3qJL8U9s/1hI/UFLsYXbWnnCVfPZxKlISUJyU/zSNfmZ+O+X0izo?=
 =?us-ascii?Q?MSc+87WgEX0jVL4/c4xibcuG32iJ5L2MKz9BrtP9JHnR6s+TAer+VavFs/nj?=
 =?us-ascii?Q?spHjXnfP6OXzky4WndjYeOjBAW33NTySwVrBIYWsQU5OD8pegc1XAhNLrQKo?=
 =?us-ascii?Q?AfYJ+Ux+o+JrQESx1aAzKCeb0P67XyVq4ZNxmzJaALtsF+IOmLqLLV0WZSKj?=
 =?us-ascii?Q?UvSmd5pqnW2cyysuKmGahLUL8Idtny7bGKO5rri7N8Z2XG26t+f4XJp/9KCC?=
 =?us-ascii?Q?sB93Cs4jYgfGeF9PhmSZuIfUr1HE5hS6kxRzABi+WqCFLbgwNGpoAvIvSnBN?=
 =?us-ascii?Q?71OM9sh+sXABy25wrWNFS3fx4XL8ZF8duQKXrcwiFDcAtApizsFjE1k9K3Ha?=
 =?us-ascii?Q?gZNq88jfkoOz9ITN1/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:59:14.7789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad51448a-0b21-437f-c07a-08de2353b467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

A root decoder's callback handlers are collected in struct cxl_rd_ops.
The structure is dynamically allocated, though it contains only a few
pointers in it. This also requires to check two pointes to check for
the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statically in struct cxl_root_decoder.

Implementation is equivalent to how struct cxl_root_ops handles the
callbacks.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        |  8 ++------
 drivers/cxl/core/port.c   |  1 -
 drivers/cxl/core/region.c | 20 +++++---------------
 drivers/cxl/cxl.h         |  2 +-
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index bd2e282ca93a..cef3e07244fd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -475,12 +475,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8128fd2b5b31..fef3aa0c6680 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -459,7 +459,6 @@ static void cxl_root_decoder_release(struct device *dev)
 	if (atomic_read(&cxlrd->region_id) >= 0)
 		memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
-	kfree(cxlrd->ops);
 	kfree(cxlrd);
 }
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..095af0f4760f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2924,16 +2924,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
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
@@ -2988,8 +2978,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (has_hpa_to_spa(cxlrd))
-		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
+	if (cxlrd->ops.hpa_to_spa)
+		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
@@ -2998,7 +2988,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;
@@ -3033,8 +3023,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
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
index 231ddccf8977..6524b242e8c4 100644
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

