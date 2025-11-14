Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74D35CB6A;
	Fri, 14 Nov 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156404; cv=fail; b=RhLfyony90XBGssjiDGD0cdyJu/NIv4QFoFuPQ3GdfAB/J4ppzRrghiGlNF16QGYhBRBCasZFMqUjDbB8aF46x3KM7a4mOeFQrtu8nUnS1ZJcQFGkhGXccnZqwirimfzYexYTDJpB4OuYEXWelMl6Vn7iRKBBmYitsOl+W0yg2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156404; c=relaxed/simple;
	bh=/m4K2MszO4PSIp4MRyq1YJ6RQplFH23mK8hnk27UTb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7gd8tsqUjfLNC41zeipZ/hdROsPWJaKmVQSezM5eVi46vwzbf6rFEshAhsLLfltJwwCldSSBioKgISlWtOncdgBGtO+b9icYx35ovnvbAFgwJ5F91BcfpiGR4lgv2XhMqnBwFDG3L/jxHMKV4HkTzldnYkd470HYJVWyUyhleA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fo7rfqMC; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fo7rfqMC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYgSZaKR24bU7arNnRo4YW8Rv+O0WvX79W9DK0q6vATXrRAVqvnaebeevJ6ZklEa3SDl+EaCUy1On+sJoQSSiuVJQXZywvvKe7iLjhovB0EtMr4w/ubKB/ZH780fSRtdZ+qGgS4uSongx9/YVfzCjcIpDPBBt87W5++YpP7qRKhWYrT2RmM1lsH80Kib/giMa5W/Yp6rgZYO/TOHXNEHvE32OAgRAS1R6yS0E7jHNfnsu5bWCNUZk1Ctg+z9TnTIVkYIdj6mL3AqdUefYC/xVntsAdvgQ79HlGscSZpg2n/hpCml5SASgCvFYxWoIESuNBKRyrpmIjuDYqe8g7ti5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSbQ34c5JJeZVTwwFMFBOxctCj0izz6Nby7BAoJn3Lg=;
 b=NnoECqhkUURPnwcmGOovzJcQk7K3XOR8fgHVELtdBcgdz2lrB6WKdTWBXV0RNBIbz6ELLiVNUSLkTFm437aIaGA15n/TzPr6pJKiTwpDDJBNREWRMOnTd6Xjb2C0lKeLd69xxCyeS26wpbMYyZAd5HmWfhTZ8LjeusUKhNzK8KRko3/HBGyoU7A7ob7FCljHHADZZGI3a0exZB3SAfT/sAhWWJ3QEbmHoeYqBy/S/nK/+qKywhh2N+2xLgUqzuJeu5ixrhcq7ZWYsFkfjo3ffI6EphjgnOMJBRmR5VefG7hm+xv5fcWFgriaCa7/92cjgH75filBrykXfLCVAyPcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSbQ34c5JJeZVTwwFMFBOxctCj0izz6Nby7BAoJn3Lg=;
 b=Fo7rfqMCcfNxmd+ztRHqwrAnWOYjq0i7FZbhpgJcmGA1jzzXmd54JFaBQMwxN8EkU+ZZj5mP2pWjLvkvRsYhGCciVTWr0UlaqENf4DOP4kxx116Q7LToOwzFV5ASacnNHgOth+8BC3PVGApjcIxA7to1aaMWEy4wIpjPKlA5d4Y=
Received: from CH2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:610:4f::14)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:39:57 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::7d) by CH2PR18CA0004.outlook.office365.com
 (2603:10b6:610:4f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Fri,
 14 Nov 2025 21:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:39:56 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:39:53 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 03/11] cxl/region: Store HPA range in struct cxl_region
Date: Fri, 14 Nov 2025 22:39:16 +0100
Message-ID: <20251114213931.30754-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 50487877-3a18-4753-5c3e-08de23c65af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xk94FdOrouBIEEQp9HhB/NmpJqflI4QCn/2/Z3FM7ug3hD6AB8bBvde9irq1?=
 =?us-ascii?Q?JkQ5WJuCtKGM9PO8z3DBODjCn2wRqjaCeb1YFHyEOcv4TiVk/FcHip70PMxs?=
 =?us-ascii?Q?RQC+9hitdR+fF6190DU+Ns//IryxY/HlNj1HQ0zZxosbuA8ObQw5u7BXHOTm?=
 =?us-ascii?Q?rEhGsfHWSViS0Yt1yK8Vg6P+8DqXGDptbvMzjKu04JihnKyISyJqPSKjN3Wl?=
 =?us-ascii?Q?MYV3QspbxYqlLspxpFwzjryBuQktepUtjwKUK7she9SRfqe/MMQh9czmvfzm?=
 =?us-ascii?Q?YjPPAZCITddhdZMmgXc/+uhSqXCxSJXP+1SgNKLlFBhX9hhQkYDGR77Yc2fW?=
 =?us-ascii?Q?0JnhriutzvwKoXSSEhmykWNN5SIcEl/GY5RdSgytejshlZ2lKwGcNgva+Wff?=
 =?us-ascii?Q?j9yxDDpZ15MajjwCsnL6iK60cAHAYRzcqouJ2eaAK7Prbp7UsUiHUfP4Y7z7?=
 =?us-ascii?Q?ANBtplL2n6/uFlfT6Uc7AifaIizE+Zk9BAAKER3U17EJ+ZBa9BKtPl88Wqq3?=
 =?us-ascii?Q?Xn7VYnUi4elVgh8g7pFcBVT3Wwj+FHpRXq4CPD45pGwkrghY765DOS3fNlhO?=
 =?us-ascii?Q?F/B9F3bAFQoGclwijBsYMy7iainUAzfwLwvZAFjLZy1JEin1etLX6GS4O3M7?=
 =?us-ascii?Q?u9HnyqE8xC8yu+kAnkV1gJeuEDc2QdKA040lvTo/eqM1/4Z3Bv8FOuY9piUV?=
 =?us-ascii?Q?HUW0hNDZHv1Pw/L1jR7vKNkOr/3sXtVDj4E/X/+i8RdNmrh9z0hlZNrmxLVG?=
 =?us-ascii?Q?xhW9T2iewK+TNatiZfUPIt3HNFFCIp0vUiqmWTh6gShbBWCFWhl1P/Ubz7CE?=
 =?us-ascii?Q?KziuxaOv+Xtf/jEPGct/hULxSVV4Usu+GVGVK7H+k7mwVYAamx+b7955BwWr?=
 =?us-ascii?Q?5rTE8CoWHUqHGNBLS407MjMjOzXSr53/3CEbVABOjM5T4fFdX2z1MgQang1E?=
 =?us-ascii?Q?3P68K/rZDprJKv6h5cDz9HdXrL67yfFbaz3AWsLzTf/c/BpDL9twzUgB6AVC?=
 =?us-ascii?Q?+jalFZCqtcNaSbKZxLfKcLuQQvZ8mRZ6L4+Yi8NiQ9MmJQjXhZU8hlT74FHO?=
 =?us-ascii?Q?il5cnRbSGikB3aBtM/iL9O7QMF6iYD+JcOHuLWfLdHaBw2NhSkGobgsGq138?=
 =?us-ascii?Q?ZFTvoJj3LpmAgVdmis+hElrE2928lPnnDj7Jm/gM2+F7mXIH//w10yB295r3?=
 =?us-ascii?Q?EV5vC8SKJmSJZkXADucWtgojSqpxO/hfqtRWqAtiEQsxo6iVEPHDDfX8xQp1?=
 =?us-ascii?Q?Ru4ljRMr/FKho0lN/CTnspP6rpF2Ji5OldMrPGMiUiWwRXqRCML3T2yl/5qV?=
 =?us-ascii?Q?gxRzqrE7iBbWLQmAx24EKnmcV/KdQ+VEuIyIJ+kmnvZaIKN9ADpx7baX4Pjo?=
 =?us-ascii?Q?MqJ6GHJsFTVuM+uyiC+ftP1Vitae83NtR5otHGJ/XaF6fHfXJs/MRNOzY7K+?=
 =?us-ascii?Q?27P0gjLiF5bVFgsArwJ4t5ZImSgbdeZqnz+tGTrQA2UBv4PrJDgH8uoI9VeJ?=
 =?us-ascii?Q?JR4DkBaGIwoOWgIPmkeJ2nhEPD3yuu8wEr6ho4GsP9Aa7NkS03SLe0OWV+b6?=
 =?us-ascii?Q?T9gQzH3BYswz/iHGtMs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:39:56.9300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50487877-3a18-4753-5c3e-08de23c65af7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

Each region has a known host physical address (HPA) range it is
assigned to. Endpoint decoders assigned to a region share the same HPA
range. The region's address range is the system's physical address
(SPA) range.

Endpoint decoders in systems that need address translation use HPAs
which are not SPAs. To make the SPA range accessible to the endpoint
decoders, store and track the region's SPA range in struct cxl_region.
Introduce the @hpa_range member to the struct. Now, the SPA range of
an endpoint decoder can be determined based on its assigned region.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 drivers/cxl/cxl.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d3bd8d074033..13b4e27248cf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -670,6 +670,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -706,6 +708,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -2407,6 +2411,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3450,6 +3456,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e61e274cdab2..4633004fb770 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -522,6 +522,7 @@ enum cxl_partition_mode {
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -536,6 +537,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

