Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100952C1580;
	Tue, 15 Jul 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606785; cv=fail; b=UiC/w7N29opoqa/Gq9TqZ5SpkeznMUdvoIGYaOWIlAhLB+EAFVDn0NWuiqHXr3601cxlmc6ZUTcblfN4Vt1IM9DgjNTPGZ9E7l6LI4poGCrMhzbAMq2mV342BGoxMZNuRuQ591k2QZ9k0TJoFxJoKD+GSCtrEPmFrEOqxXDYlJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606785; c=relaxed/simple;
	bh=lUKcDOwFmSTbd6685WiIwqAkpp41IB62Nb2Sycfl32c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz6x2dtWGzkz/rryBM6WofzlSA8xF5ddNpWi50HZC7cDSaKKgQH25PhNhAyvr2CwX8PFybRipvLVpcurfO/pV/rewQWbAXnrPc9tr9ucE6BGTvdDO+5UCGv1ebl+o47jhSAs6oAlmoPiNCZJcLUevfTnpFDK+c9W0Zw05g+H0tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Woeljeh6; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Woeljeh6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erk7XIfQeQS2lNl8qviMzJJ9f0koIeYX/8mhs8yzNZ/AK84E6MJ6Dt4CEJDF3tvkvxbR4k/bbd+BBHl2BuA/nVNvc0AEx/fsRaIQrzNGfAtjkgpe5eTPL+mXa4QkA70jRyHiDMtV8tGOYwGAlIFpQ+pNlvlexazBLNZ7CDu0zGZnn89Na5VzfN9kmB9xn9bo68qiz0sdwtvERje/daYRlawOYhvmvbRsubKeVpXtERs4cm2UCT2QPVxaoRGgd7BKcARb3LHcBVovuzH3Zce9ndq/2yE3ooMOe/VREILIDwO0CHnkHInxhbB5rET0klPm4GkNvOldP6Jk8D8+G34cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0QitDETod/rta9q+e+tEsMX+fS7pTjqcBOphQQNxj0=;
 b=QwxxZwPuKI39v6mmVRzc1OFD6sLe8Vj5Kd+qNWnzkBbAckAXwhTrK7pnV/6EJA/02PBMVu282hd3VNkYxG5Pk9GI3AU18F9b8p684/vNepzuEyUSqPz16A7Z31S0yCsadaRkTmxSV6BpFUBpxq0TkYY9EJGv83xoEzWSnzzzlPWUJe9L3yFaCZHaQfn6JZpOh09LZ7BfeAiGku6YCeMBsjHS/Tn+LnHqO7PFq8kfTq+usrxenpNgEtjuNjcaqw0ToCjN8jJOGYcyE5vv8h5sXtP5KW1x7pDAoJxNINDJ60kSnnJIf257v5WCam/VgXtahGGGeztjpoyGuX3djboQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0QitDETod/rta9q+e+tEsMX+fS7pTjqcBOphQQNxj0=;
 b=Woeljeh68vg43HNOi9o/gekkzytQ2md33OBqAo/Sc6AHwBhw//9EzJcvygJqWFSshCSmP3UqE3mHW9kGnMy+z8JHJSxY22/G6Xh6L/gBpT4CkLc/OyxwsX3TK3IkHlIFXG284SXvt4QtOcFK+0HpWKNr/2VkinY0C81r18ZG4jQ=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 19:13:00 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::b0) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:57 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 13/20] cxl/region: Move devm_cxl_add_region() out of create_region()
Date: Tue, 15 Jul 2025 21:11:36 +0200
Message-ID: <20250715191143.1023512-14-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 63eb09b1-6d4c-485b-565f-08ddc3d39d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrUyb7IgHVvr34lP6UnYJ9Cdh04WAfEDZF+UMSzTecxrHq8UFCP2wje0IknP?=
 =?us-ascii?Q?9HorBAO7nU1iy4merVFYBcSaCtn6e5sN+R0pxmh/HCBeiMM+iUe0L5/OycOd?=
 =?us-ascii?Q?JkGUV5nNMaooTlYrDH3gajN7ed7XmSDfqxsFBwMMCsVZGTg7fxb5hYXQtrCS?=
 =?us-ascii?Q?Xce0v3cO+Bz1d3QQEYaCDrG7bjk6t5rb5jnnqI2LTFUgWHyQGx1BnhXy0NoG?=
 =?us-ascii?Q?lZiULHKoPm+1k4ST1FIDccaen+nVzQbbLNTlcTUFP3NWflA6ttfkiQA+eL+C?=
 =?us-ascii?Q?fFFQvowJ84Uh2ZOSSB+o8CLfrAZA3Z+G+G5+VgnHRIB31LdpjgsxlsENQ0/4?=
 =?us-ascii?Q?6/YTkXCJfRHSA8regxf88ri7fk+Ic4gcdAMC+6lWSbeXDlSw5Y6C7dlksW1C?=
 =?us-ascii?Q?zSCd+hiY4IRGxUFNfiUZag6TJ54znqGoI6RVvz+UA/Nt/Jg5D1FCCeyr5t3V?=
 =?us-ascii?Q?iTpUDvHtywtLfac3MbAUZ1v0El8cWELRJ29gGfZjDqUsdrWgOwNPg4WjJdhv?=
 =?us-ascii?Q?/C2wRVgGZLv6Dj1CtbnASG2iRpOvD8/DfCKfLjAZNiz+nnFmMwR3XFeBzVu4?=
 =?us-ascii?Q?OZmpPyuhn++O2cV8E1ets13fWqb5wuxjrpZjHQmhgm82yGHpb8LuThX32Lsg?=
 =?us-ascii?Q?GV1w+x7NbDp6oYq3mRfIaTHpESmh/bWTL2SLxFvPTVg2k/9i5m5+pctIt+ZY?=
 =?us-ascii?Q?Yy/gtLdAJuBZIc3hMN2FPgOJWw1j5a+dEby4hV7vMo5vG+8kyku0/dvaojv1?=
 =?us-ascii?Q?2dUggzWj6W4eyCNuuFKfbqvGNFeGtBFVVygw04+ISoweCPVsjlt47/RcK126?=
 =?us-ascii?Q?k98QE1fcLU2Y7QvR48U82q9mg+1vgTVfrfg6h5WuSkUUN6fSAlA6ikxrA88b?=
 =?us-ascii?Q?v07kRf7J5U1tqZluo3P4duU8b10k58uNr3Q4x7UZ/NndDrdlqYuwesEC4LJE?=
 =?us-ascii?Q?Ykba8AO4pcgR6guuLzZTp0mnsr1JpIxmFXFvEiA/3RkrLkgyNVvP0dd1TWzg?=
 =?us-ascii?Q?wg+5HtFmNd12hrgqRrBFyLGC+9eIxPF2xtDUzUO91sNgm1jXkD3JrszzaftG?=
 =?us-ascii?Q?ZZ0IKDUvRX4ve7JKbQ3UfkMYdNcN9Vj5Pf7nYFISf66QhpZjOBTvJvtLTWiq?=
 =?us-ascii?Q?eBUz/7wzqvh44fgHIwALIpOjF671EjMjP45TYsGUEF9yxLdf1idwxea/y70F?=
 =?us-ascii?Q?1SSd/AcvWDPP0XCLEpk5RrFdvLR21EwUWr8doF0bYR0EVA00JI6vW0ZZiuVh?=
 =?us-ascii?Q?Qs0a0tDBb25sMBV2BRpzQJiBTBRz6DkZKdwvlesprd7dQe8BJkrsEfhOXasG?=
 =?us-ascii?Q?+urFKnvGnOcSmZeLdWBvrrdO1/CgHddPqI2NJKLLC2Lh+aiVg+5g3vnaue67?=
 =?us-ascii?Q?2jm/7xuGx8emd3uzMk47PrBebm7XJ08vFpmT8aVWpcP4Mmem9uHpx9dL+wHX?=
 =?us-ascii?Q?2Ow9XLWy4NT5WMYyGZJntQLB63TGIvpruMVSn0I6wR7o0dRJUbtmTtu4rTJ1?=
 =?us-ascii?Q?962Yz65ZzBDWtJhh4hxkTBS/hvILXQAIWzXY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:00.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eb09b1-6d4c-485b-565f-08ddc3d39d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

To further separate creation and registration of a region, move
devm_cxl_add_region() out of create_region(). Also, adjust error
messages to still cover all errors in case create_region() fails.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f88b7f86f0f5..e06cc92ad3e2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3367,8 +3367,13 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	}
 
 	cxlr = cxl_region_alloc(cxlrd);
-	if (IS_ERR(cxlr))
+	if (IS_ERR(cxlr)) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s failed to allocate region: %ld\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__, PTR_ERR(cxlr));
 		return cxlr;
+	}
 
 	cxlr->mode = mode;
 	cxlr->type = CXL_DECODER_HOSTONLYMEM;
@@ -3378,7 +3383,7 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
 
-	return devm_cxl_add_region(cxlr, -1);
+	return cxlr;
 }
 
 /* Establish an empty region covering the given HPA range */
@@ -3394,9 +3399,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_region *cxlr __free(early_region_unregister) =
 		create_region(cxlrd, cxled);
 
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	cxlr = devm_cxl_add_region(cxlr, -1);
 	if (IS_ERR(cxlr)) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+			"%s:%s: %s failed to add region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
-- 
2.39.5

