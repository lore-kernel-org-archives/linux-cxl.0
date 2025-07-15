Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C42E2EEB;
	Tue, 15 Jul 2025 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606805; cv=fail; b=sqIdcvaExd3hnci0ylatZrQHndao3WJNssih4Af07IfX+3ZN/4PW2A85iChD2DJnfPKvP6RzAqbN/IssXmhrCYJ6g2lAxTmrdISJCd5eH2Z8Ryph2UH8QDQhHjRf91uf+6G+Vsx2/OYczyM0B8N8/KBpV+kas+wprNSpj8JTXqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606805; c=relaxed/simple;
	bh=q7/Quzog/z1S7GdBmQNKcSjWKXQfNqcSDOvx121aSAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcnhLM5m17mjStbKRnTr9t61hYzsVaNL4rQfWjbt7VuxDWJGCzxH9nLu0BV0xbVlh+GRkPMlrw705QbjDpe/V9cUMvb4gf0KM+kRwiZfCyuz6qWM9tUh2MFzpkJSzUqb6037cfRwR6g2q4Bq2DYhTZsoo3TQVVyG7i0AVDEz4/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e07XADwC; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e07XADwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aASpwme+rv1TknGFVyc3n08Z6rBdYpPrdbi3+rVnKz9x8b/9gpNcX/ePrG9S504uDK1MdyMlQI5NPI/VL3d5oLrD0HIAzSNFnGoL9d12vwaBW/bUwitKOekamOLfPjTyXWe6lbo490tg1FvtjLXroEcJm/ZyE4FeXFDxwTX4Aguuscg4ntdR7/BYbCftRWs34fkgNaDQzGOqUyiCaLplhHEjTaCs1rG7NALTZRvoUA2ECCiA9JL/0gnrPbF6VR9cLa6yG6i3nARSdScQlv7c/5BsdPkubxFJCMq2qhzojf3y+fdPxkdv2FBdYyQ228ibPS/iU6/+6awFY0X18AwV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAfWeQxiBLO4H/xWl3X7UtxdCFjhWh2Bgk5OZ+6FXJg=;
 b=Oji+aoqLSKU8g02J2fyJbM/83QF7wx5qjedyPfjGcAoKvCJ7UnNgKrpHhuMYG5FvPqCNyrlfo648pYZb2hpJFK0NYPaKSOYHY4+ok8QsNCTQFxcJeRPj4iiJzhP83xx2ZlopzU0DqvPV4f8PyDBOB7BeRSZJjn/wGDqS+uqdTLDrmRg8cV8sJikrG/briSkpDfDE6NuOqPWZWdOykacAlqteFMcY5akyfupVXA5pc6nddGfnvHDpNXj8aRT/3a5UzgPvGMY8/SoDnuxllqTnx+TJNEGbpUPouP2iQru4DnhuWloqmwGRoYWCk4QjHxufG4GhkidJehzbELk32tsJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAfWeQxiBLO4H/xWl3X7UtxdCFjhWh2Bgk5OZ+6FXJg=;
 b=e07XADwCKheuWgx2atWbppRUX5DwElZj7qsM3uiytdN8ncBXw6eRqRDZd7pNTiJnSJQHm3YHdQ5rMEJmZ4nhKUfoUBWQrGx0fQdMDB6QK99gnz6jHKcJYJugDVNeSNGBQO+db/etHoh4hwtftYD/dFcG6wV4Ggf+TGS23a1PFqI=
Received: from BL1PR13CA0062.namprd13.prod.outlook.com (2603:10b6:208:2b8::7)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 15 Jul
 2025 19:13:22 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ab) by BL1PR13CA0062.outlook.office365.com
 (2603:10b6:208:2b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:18 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 19/20] cxl/region: Add function to find a region's duplicate
Date: Tue, 15 Jul 2025 21:11:42 +0200
Message-ID: <20250715191143.1023512-20-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0e6622-11f4-47d2-3d61-08ddc3d3aa50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vAPVXm4bS25SAQTwshG+/H5CrsxB61vHXxvgr+5lBRGwxTgenDxqsc+UNHUZ?=
 =?us-ascii?Q?P5JiKWbgW/iDiItKAwhUs+gANbkDsmM+LYUHFTRLwtPUIQAQnz07QueVkqmR?=
 =?us-ascii?Q?9YsihuxA5DE0WEiVnZ4o8B5S6Wj+L8zW+dnVKiCbt9OcW1zavYzF6a4G6oCG?=
 =?us-ascii?Q?mmJJ2bWl9GhUqk+hjrG1v+rmFpMD2l4wGA9yJvEVwzYF84Ygd7S88iykNLUx?=
 =?us-ascii?Q?iz2epQfHm2dVPc9asPVtNHicg3VFAo7x9fIQ1/1cHjtS53gJQAvdAf/iwiUj?=
 =?us-ascii?Q?WQlVJIc0sUQgUZQp4YQ1cpNLExfWr+J/pZwGrpVraYdjwaq8ZGt/a1PfNhYu?=
 =?us-ascii?Q?pPserh89Z5MtBEXuy7jLHmx4yi3pmVppXsIZAb0kfPJOE4hUBo4e8QkfHV7k?=
 =?us-ascii?Q?GODuqLGHJzfT1G9B03cvfTY61rWUb4FBs9LD3bmAmV9VSFDETSw/KCKN0C3s?=
 =?us-ascii?Q?BrtzXps+6H9m3eEMan7RfrydRbj4z+LLCAyfYdciuduXXpVF1hKx5g+ZdOFo?=
 =?us-ascii?Q?v1Hcd8mPZR+GY+NJNAqIm9GpwM0cHDVGFRcVokgVFWwq7kUcvypiWWfE3TcK?=
 =?us-ascii?Q?jyKAacXag+cDeyiyM/PV34Yc1eImkNTWtuAg4ObO8SzDnklwjYP9aqy3DJ6W?=
 =?us-ascii?Q?zdyju1eNzVb9U/QwnIgFcR/DkuUMtFDpKPeVmWMU6KezeZuaByVTvi8Sqdc9?=
 =?us-ascii?Q?FvmStjO2htx0G5tqtaY9ndCQ6w0ohET/bxd4u5kGqS685mo3EagGIQOPGH7U?=
 =?us-ascii?Q?PA210anE9PuvniT/0oZHhNcykMSNgrBdbkSLL7aKELGQ+/voA88KZaqzfCF8?=
 =?us-ascii?Q?TLkHrHkmnFgKOiViX/D0eHGf0WfvCe63dtr5vAulduwLPiP/OErW2PE4RjlZ?=
 =?us-ascii?Q?CSMmE5wTDgQYwxFNjKOhWHm3cmiMaHxgCcayeLur4X/GtiYGA42XJ4fUd3JP?=
 =?us-ascii?Q?27bdDyoYVWH1uSi+1Hx3oF5ZfMUxc4+bmoQWd/EMAil5fSR8NOWfEUzMlACf?=
 =?us-ascii?Q?M0hxQo6O5uz1TGHN0giaTvfF3RRcbJT1/NKU/XkR6ssGgD+20rJQsMVozxyV?=
 =?us-ascii?Q?cdsK2CojulfeemZ7NMEQiNJ2e68imAOpoT9KFuOTWQPhFiytcalK8qU8e+64?=
 =?us-ascii?Q?T+kgUYW3QwrdTSHPWzSpDcyTXbVtfIefPcMBPTLf9LA8YPlcg+LGEWJHQPxu?=
 =?us-ascii?Q?nByGJQ+PCKz9Z/s7IJbbPi/32x7uhovoitXATEAT8phg+OG/vNGy9VFE8PG7?=
 =?us-ascii?Q?HW/X+rh/HAbQA14a40eqa1h01GAgyBMlfuOs/WzlP1uRkyUdPncT0wpmXptI?=
 =?us-ascii?Q?r/f2dcwAtT+Sw+dpBzMCoAPGmHhHCYgc8Y4mh5ffOeUmhSkTwGOH2VyRJIlO?=
 =?us-ascii?Q?HxOb3DylXENx2zThdcZ6LTapKPCN1sPWWGN/9E+yU+ZLyX2XNFrNNTu6pSF8?=
 =?us-ascii?Q?03r0XZvOJ3wRdQtxhR3o5zamyGiAnR3Qhg3Ezq9KN1TO5Lnt/Xw6CPERl+dx?=
 =?us-ascii?Q?3UcyLR8S8A8ZCIdOP/hkS8iNsqHhRltbPgwS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:21.8917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e6622-11f4-47d2-3d61-08ddc3d3aa50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

Before registering a region, there is a check if a region with the
same parameters already exists. Rename the existing function
cxl_find_region_by_range() to cxl_region_find_duplicate() and modify
the argument list to only pass the @cxlr argument, which also
simplifies the function's interface.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8faef2b2ee05..5c30c417de1a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3312,9 +3312,10 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return 0;
 }
 
-static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+static struct cxl_region *cxl_region_find_duplicate(struct cxl_region *cxlr)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct range *hpa = &cxlr->hpa_range;
 	struct device *region_dev;
 
 	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
@@ -3486,7 +3487,7 @@ static struct cxl_region *construct_region(struct cxl_region *__cxlr)
 		dev_name(&cxlr->dev), __func__, p->res, p->interleave_ways,
 		p->interleave_granularity);
 
-	/* Pair with cxl_find_region_by_range() in cxl_endpoint_get_region(). */
+	/* Pair with cxl_region_find_duplicate() in cxl_endpoint_get_region(). */
 	get_device(&cxlr->dev);
 
 	return no_free_ptr(cxlr);
@@ -3502,12 +3503,13 @@ cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 		return new;
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that if multiple threads race to construct_region()
+	 * for the hpa range one does the construction and the others
+	 * add to that.
 	 */
 	guard(mutex)(&new->cxlrd->range_lock);
 
-	cxlr = cxl_find_region_by_range(new->cxlrd, &new->hpa_range);
+	cxlr = cxl_region_find_duplicate(new);
 	if (!cxlr)
 		return construct_region(new);
 
-- 
2.39.5

