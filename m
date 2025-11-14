Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721A26F293;
	Fri, 14 Nov 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080891; cv=fail; b=iuKoUqoKbjVqdTHMkTh1cRtWntZ1Iq3dHla4xgZJdy2SpuM5xEfzc70b+O4OXxCX9TtGSnEaWxS+yrhSedb+EWZ4rRUmrydfRfaXMnKbix6aRS86gDtbmK/quqVvvtpzNyapl72um7q9oAAh0mmXsmBFxIrQ0tBojWYkjho6ba0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080891; c=relaxed/simple;
	bh=D2nn/7d43b6StB+50Mrc5CzHNcdxGpoqaludcZ4hH/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyXptDrLQio24BGnuYhjLJnceiWEgIi44Q0Se8mWrTblHTyVezNRAuxd3ZB4Ikc5h2dPOht7sWbcow/tYgsD/4zcQwHCw/SoWy3Dva4tSIKbxddgtH4GJX1i6ysle+/6XD/VVHXMxkTnsJgCfo2mBflExTlEaIaKYeH6t1bKVtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rZc70tdy; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rZc70tdy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwSj4vUcRKD0h9xRYia3GVZawplUrO1VpcI47FkZCB5XEuVBVsLatUxpl42lD58jR7hS67qO2nOOF9EeJ2LbG4u0iUlTgWcbRpn+eatqt5EG9GhLJ1K7AaZsCcoWAOVei6NONs6SZ1IrLppejlkin0gX3DFsXxl7OmWdpXoLOjEGoqexcs7n226FyXRvRIF3rA/F3mo7qSMMtkJ0DJEbulWPgrxFUO9vaCNaet+2Il+0v2VcqbnHOHx9qXOuReoCB8ugRDi0Jq0t2dTXQR4Zokjf/yjOTn9ZY14dY4YFwGrqBKsot/fuY4DLv1Yh1g/EMLIuPBhy2+Ug8yDq7Yi3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXMZtfPyDB48KKByRPJ/uPczC4YfeaiH/bOpk5DLcQw=;
 b=jz58ETC6AF89VHPffmJuwc4JxTNhA/e9vUrmmBLKcoPeeOYvgKMi4oDuNJaROXIUgpJMXx9d1FE2eOAI2WGmHFoeOyxGkBsSDb/8zqFOpn8bcDR3weZzwA9saCi6nr8qKifWYu9gmWQ7k/j94nS6cCvdimsVTGMsSUHVGaZwOHJn2mSZM0Iq2yH7prXATOXFZ1S6yZZGbkrwB/zQ9x2FA1BS5fNjGRJrkykRxtZkL1m/R1vBWOEsEsrpZuH5HVii6HZA/sxdO/6mvEezPODNS5y1gjmOzFTiK6ZYAQPGVzuYJkpbZAXkPSgfzXtix+JVXctFVattJZY8ZQEFwQjjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXMZtfPyDB48KKByRPJ/uPczC4YfeaiH/bOpk5DLcQw=;
 b=rZc70tdyd9RfN5P2u1P2oPBhKhnUhJJovrdQ09oFyWPiYFuIrCbRIcLlYgPzWftbFYndxUOI9kVROUqlp/48VrkCMzHKs6vMXX0ykA70VLKJR0Wd4RN4fkCbZCNMgLUIoN8n6a1PH21GCG3Ih/Z8UhsYC6DFIVG/s/Np1QRwAx4=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 00:41:25 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::5c) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:24 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:15 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 06/11] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Fri, 14 Nov 2025 01:40:11 +0100
Message-ID: <20251114004021.1310661-7-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 73876381-6c5c-46fe-ef24-08de23168a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PDkdqMpYap6sqem61jx173oIi2wDsLY/TiXcumKwoF1fSoq0k78s5VvQBxwY?=
 =?us-ascii?Q?2qjUu4R/RgiDwK7Zllul6Q1S8OydEEpD1nfDHldO9t32F0Am6YI5cIDC3iSD?=
 =?us-ascii?Q?bdjpQ1K2iJBhnuo0ulP3aC5UpmHxC4flJhovgbcezKCghNcQW7MuYqXbq4cM?=
 =?us-ascii?Q?dbl1YBRlKAKi/uq3KVBg4qsrusxlgdrq1jn/9V35toQIMKWD8XxauzHi18gs?=
 =?us-ascii?Q?vc9MakMrfYXGLTWq2E5sWQiD0nkRbPl+Mobq9L1vinb7O97z+WBsokNx9imP?=
 =?us-ascii?Q?lLARacOwvVJiadoi0wUUZNqbiMSUOa9aud33Z6PZPUgR7YLTn1mqG8egkIRb?=
 =?us-ascii?Q?3k2q0JPTd3qq1PqoUbNHqFw8E8qiWYK4CKfpVyzGWXY7ax+tPLB1qQiWz0+t?=
 =?us-ascii?Q?mPSa/R9yUf6mZ6EySuGBSSpUlZ3u8m9lhpk/TFiOAtHQPhqAJ6M/63tsSZsg?=
 =?us-ascii?Q?GoIRNV4d0nk088UIpQuQv2utEWI3jOmggUAS+TlvOzCPE4NUkbmNwm5Qb5qp?=
 =?us-ascii?Q?n0PQ19ucNYsgbX+2rSWsgmZ2vgh6cl5vfagJTjyaIqv592D71WqyocXXLzGa?=
 =?us-ascii?Q?zlsNAHx/3mIL8PPZ+8wnkfGdk3jXDph9r8agyfnkDupkjv+n1L7XeOu0LQkk?=
 =?us-ascii?Q?/CgaUXpyYtzWHEEnXj0JTbKjFUqUPgQSRfupMuIYegSve36chgqguvaZJqNn?=
 =?us-ascii?Q?rem9U2kBlI79evjPfmQl1mhgOjhXlWoPlFg5aupqD4J6Uqrs7t0rNVKFwlTG?=
 =?us-ascii?Q?Dg2pot1ID32RZNOrFkJXhZ7tKM2qJEl8E9iNEpuHIRXF0fCFQhRyRH31uFeY?=
 =?us-ascii?Q?/90k+linBGMt4k4OJ3Ctp3ujF58OMsOu7cqFkyZ4RHOHZJ5HUUk4YcZD6ypg?=
 =?us-ascii?Q?CvT8sR8+n4KH2N3qq3U38eukGTQmaRKLmZ7cJ/m4OaDefz0mNcUP9D7Mt1uj?=
 =?us-ascii?Q?LFR4ld2wD4nhOjA33BBb2f8T8eWFwjPaxc12lb/w2tLWEcT8pvBbXZPFRNNp?=
 =?us-ascii?Q?g6+kX+DpOxdzJhrs+vF+SNqGI2TLs5oOD9bw5Wkw/TuNcRhIQThKrYEEoQJK?=
 =?us-ascii?Q?A5GIRsUt8nPKrndatS/V2K3EvqqAGbvwYuIxTIoFzUsyrV/8aZlMS5dFUfkY?=
 =?us-ascii?Q?WlRtXamY2YGcEtK/JQuvTAa+im1eSo+wUSKhvR2tnlB8CmK78NjmQtrRI4mS?=
 =?us-ascii?Q?9rqQiZGBZy3tuVUYOExlq7Kn49xnoRPS82e1JW/149W/uL1bKc8kOzgcz41f?=
 =?us-ascii?Q?ZzBLqn687YUC43ehEFvb4i7tBVxLrU683PMX3nA58c/leMW2zGfIx+v1WyJM?=
 =?us-ascii?Q?jLUNj1bbkyyobk+ZRKKDQa2UvQlsm9DYdk2PJ/g6r+pKl0NDLrMZZDsPeVNe?=
 =?us-ascii?Q?Y71tYRTdFz21nsK6O6j1O2ZwEn3TiE0/R/Ovbu0kijq+ueYGSj3oShPgR6IC?=
 =?us-ascii?Q?veqVBzBXudH/ZJJctSfY15s4+qLmsy2a+/w/HgW5ilaPBBwWKAywdxNwY9lZ?=
 =?us-ascii?Q?fckED1jEaQDi8WG07HXHMvwMpLnRxQITynBZ374sxoFZcYWhc5N6JRBiPUZ3?=
 =?us-ascii?Q?nA1z7D5nWwMHKDOuvPo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:24.4925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73876381-6c5c-46fe-ef24-08de23168a17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3

cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
determine its interleaving position. This requires the endpoint
decoders to be an SPA, which is not the case for systems that need
address translation.

Add a separate @hpa_range argument to function
cxl_calc_interleave_pos() to specify the address range. Now it is
possible to pass the SPA translated address range of an endpoint
decoder to function cxl_calc_interleave_pos().

Refactor only, no functional changes.

Patch is a prerequisite to implement address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 52924006a10f..01d23a42a6de 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1832,6 +1832,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1844,11 +1845,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *hpa_range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1886,7 +1887,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1896,7 +1898,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1909,7 +1911,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2093,7 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

