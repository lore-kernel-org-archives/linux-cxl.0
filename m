Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD02E49B2;
	Tue, 15 Jul 2025 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606803; cv=fail; b=k1yF1yLwISrCqXNa8b8GgSZT2ksM3+25Vdt1f/YU7zSIjYlgPZNp5+Jj+98BUAbCt85oKw1n63UuI2xc8YKzRzHBqRE4EC3epKXOBaaPe/mI0xZsrb7V3QCu4Iwm+C+6h/QpWYICxWLUm05OrhVL3BwQMmIcnV7k6++dBz4BNTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606803; c=relaxed/simple;
	bh=YqYRD6cMmeU8zWvgKtTZTaMTlw/d3KZydlJoUkAY5wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS7gmi/A0j6JGgxnpOz8zQKAqG02/BuviEgCBdBAESX7eDoVdJ/aLpl9hPnJzW6x5ZZjRCxhuOHs1A84/+isWFkxqPPSDIbpKomxxHctCLQskyWSoB87ICIcR8y6x7FGzeX3WN/MGOLbWzJ0yfMhyZVlHS/3/hHqviI5R0gqfLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TShaogew; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TShaogew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgCTrIwKVHbeE83T6HTH8tOEueqMyH4mGBwAPzLrZkNhnbb3Kc11s9Zm64hTSZkUvJp212oOcKMxqAY55KyZK6GlCOBsBMKOOwI/faMh9wq2BUGIsMh+J2Kmavdg0LNpHL9MLwRfpGWUFRTLQp3cUysz5GQBxLMaVzu6Gu8/sgc05LqxAr3uNJA4b/Nn3e3NWqc/sPtvYnMQP5zm/YMq9qF97OlRyfFoBMZbJtU2nxjPI8q7tgYWh9pocJI86mp6uiLBhpJnFUV/znddEOMO388p/E5St1nBhpHEpNsYHo+acLJ059NdORMzWj1ZcVfTamArqvPShtsACNv4wsp98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAbupYQwRFPKUHjGa7BBisamIazRMX4m8XgRJrCoRFg=;
 b=vBnSeyPQPsCfPo/dRvNjULgo6F8pjq0NQ4VjBUaYR0o0LTnxtqCAAo9YW14kpyMHmB7R67Ihnen9JCSrdrpB+kSc1/IhD7QJ9ML2tv/NQ/Vwsu9apomFekt4fubR+O4xZ48qQh1ARdbb+LERIaXavzJjgcCK0TifH/lGIwwhIP9OXiZHe3BAbgTWQxY6HmVNNHaAYyVF5kQ4ubdbJ2A9G+zPw7NJy0cyxw9zsryS0wvk8aOEqz84H4la2/BPHsC5XlA0Kec+2juqUKrreSdRBbfNnDBmToUvyxvfRea0XTXSsklFO/XoI9hUdSz169cbXPAz5AQgfulpxNGB0LaIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAbupYQwRFPKUHjGa7BBisamIazRMX4m8XgRJrCoRFg=;
 b=TShaogewQpMbxPeOJh4DyYl3edBjL7sFtmpMWMBD5nZBn59U9czy3FRtC9Fdp2BxySg0lNx8/Y97g22M2Zu0nUA1Yk89ltluTAl9Sy7oLtrH/LnyqHNBV30M3rTJnrOks4Q5kRyQFHQYRzkLlXiMXk5wiZkfeuxsBsJUjzGzOLs=
Received: from BL1PR13CA0103.namprd13.prod.outlook.com (2603:10b6:208:2b9::18)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 19:13:18 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::43) by BL1PR13CA0103.outlook.office365.com
 (2603:10b6:208:2b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:15 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 18/20] cxl/region: Determine root decoder in create_region()
Date: Tue, 15 Jul 2025 21:11:41 +0200
Message-ID: <20250715191143.1023512-19-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f16205-a1d8-4367-16e1-08ddc3d3a83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OzU9dkPm/lCL4pWghJja+nL/1GRnHzgSHvDfYoCpcyYWge20gD6O0CO8PgmQ?=
 =?us-ascii?Q?DWy/F/H7jEpFwmyK9qGEbRVh3hM5tQ5eNVgO0WIn9OmMFipJYVRffXe9f5Il?=
 =?us-ascii?Q?SX4NZa9p9HtoPP24wFI3yuC6/SDJGeb9w7exzqAt7HJLOm2pgM+HzqwaWffA?=
 =?us-ascii?Q?sWgt8zxN5qK6BAAS8S9KI5HHnapIzXFbvCXG66ODKrYyMd2eXcSb7R1QlxGU?=
 =?us-ascii?Q?1J1Ihi0HH8bVctqgT+vTUb9X2O/VnLqf5mvM0CX0HuZVq1hnUyxo/j/5NgRm?=
 =?us-ascii?Q?/KZF1kJ2uH1DK5/GFAB86cnj6iqnAj/VltQ01l8ptHYVn7VUgqiMpC9BxJbX?=
 =?us-ascii?Q?b+PDSMYdJthMa3a0Ko0VhxGqsmoQXz095pe6xcfY7P2hFpM0/H+mspeLLBBZ?=
 =?us-ascii?Q?1/ikLwbgj4ld6v+6YnHg4XXbjzdnr/eVPl6ytbSKrQsDQeeaYQfcATIinz7T?=
 =?us-ascii?Q?Q3/U1IhbuFbj4S3D1apeoycclo12mNO2Dm+0PM+Hj8GyfmZuNarab9adkDzJ?=
 =?us-ascii?Q?2EiUbzOTFIMaS5qc4FF0Gsl93zaKfUyC0Eny/hX3PmGSMFhAnTBY17VTHFii?=
 =?us-ascii?Q?CEMLPPUymj00L5KSH87jAIFAx9NH1SWrBrGUA2qsAOqbRczd6L6NqppVA1VQ?=
 =?us-ascii?Q?ql+a5sI0kAsc4Fq7+GVC2fy3PzjwPgwtuCb70Tb5zjQx8P6R9IwyW0HKCRp2?=
 =?us-ascii?Q?8aJ+5v8rnIdNcNaNgMdbcjwttRj0PAcE41T0HSGq4Vjdw8yUIVzvvaeeXFbA?=
 =?us-ascii?Q?0haGJDCY9nneEnrdMBkLuL0sM4t15SC8VBEyuhVTI0orbJHyAFPYM7qWKgaj?=
 =?us-ascii?Q?B1KGNdyYh+0ci1PZ/D46PCHgvkQuafLiqRdbGiGUQQOC9cgsFa9CnmPL4OkI?=
 =?us-ascii?Q?FWL2eqdZOv0P0Bre6cBua5HDEs/dbvb0qoV1eX+PFo1BTeXojoggpdVTAm00?=
 =?us-ascii?Q?2yEosC/i4XHgOi9E3dRQHYN40tBFkjP0oPaz9QDA4Yq0dClJ5V59DE0ZTOEQ?=
 =?us-ascii?Q?o02wsp68qQtQEB/EYrKkauslh0KtwnD4Phz4v1Q2tedGF5zFe78FUVmopHjn?=
 =?us-ascii?Q?TcqJm9rcTCAf9Q7JzieXP50uDIWmSPed6hbc/Vly9ygVxBQZm3kyEmLul46t?=
 =?us-ascii?Q?JlifeWJndRR6wVnYPCT9Ep88G3PG/T9cXA5cfKxOAs4laSD/4Vs7c1pcNMIY?=
 =?us-ascii?Q?6Rwe1vl/6pl2HJ7fgFlu2Jw3xSolaha0gHco/xB6LQgcYsSY1q9l26/Wam9U?=
 =?us-ascii?Q?Rq38mnCk7Y9FgL/MR4lmntT1hVFEsoEC5ePwOCiVufJ58vmXg5MxJ2gQ7F2+?=
 =?us-ascii?Q?+zO1bCnA9h1Iy2r244xDGXg9PgmBlhEOuH/HpHEvMXPQcRN50zwlbPsGqtXf?=
 =?us-ascii?Q?/cIBPnEAHOFm0zkJyHNLi38Mpwaa1DGfgz+7n79MGhuE7V3nU1Z+bdLH0B40?=
 =?us-ascii?Q?GmoiZO6xE6Ht85Q3VsN5YWTckqML68IA6HmoFDnDEyGcR6OBGLI7U3XRWnjz?=
 =?us-ascii?Q?gwlFS+N4HpSGHhqEl2KqSrKT0WJhj7PWr+an?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:18.3999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f16205-a1d8-4367-16e1-08ddc3d3a83b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

Each endpoint decoder is a root decoder assigned to. It is determined
using the endpoint decoders HPA range. Move function
cxl_find_root_decoder() that determines the root decoder to
create_region(). Remove the @cxlrd argument of create_region(), it is
no longer needed.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a81278fbb0ab..8faef2b2ee05 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3364,8 +3364,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 /* Establish a region for the endpoint decoder */
-static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
-					struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *create_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3375,6 +3374,17 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_region *cxlr;
 	struct cxl_region_params *p;
 
+	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
+		cxl_find_root_decoder(cxled);
+
+	if (!cxlrd) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			hpa->start, hpa->end);
+		return ERR_PTR(-ENXIO);
+	}
+
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
 	case CXL_PARTMODE_PMEM:
@@ -3485,22 +3495,9 @@ static struct cxl_region *construct_region(struct cxl_region *__cxlr)
 static struct cxl_region *
 cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region *cxlr, *new;
 
-	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
-
-	if (!cxlrd) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			hpa->start, hpa->end);
-		return ERR_PTR(-ENXIO);
-	}
-
-	new = create_region(cxlrd, cxled);
+	new = create_region(cxled);
 	if (IS_ERR(new))
 		return new;
 
-- 
2.39.5

