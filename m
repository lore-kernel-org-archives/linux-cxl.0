Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834535C18F;
	Fri, 14 Nov 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156398; cv=fail; b=OlX2UtX+XK8a3xv064WtHY3MPVJo86l5TFHysfJu2EBsU8frkJ/3fTDuM5PVd7P+2b+I0mFX9KrkrOWizDWW1YIMUTDXfz7evUapm3TtPXk25UX9cd5K0l9W+e+8QD1nwEP0JDKWZDyMilYwkG4222nIyGz6Qt8nfMUklqZNFz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156398; c=relaxed/simple;
	bh=JLS8R12RZ5/HQZ4HENy0nQbnkZZ+1UT5vPEOczjcX5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBMK6Ioe1F1ljmsauc5nO0HVR10+PeqHIBRgKa99zr4GQ8SvPglgT02DgIgkPZYzEsshwoElN3KAzSZ9kcIKTkrTpnNRWiXfaPoEOKjz8pahO1n77/nkgiCp3FwCaAOqAgdxUp+NolPeEEHlHR/PKXt7VfPsmSjFqLC+dpTEV9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QPN2d3l3; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QPN2d3l3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpG3qIT+9IzrIWdCjq7EoV6fIDZqjJagJy8lADLZBn9aaTIaztPLG/ONIdNtP/tAbq4zMUlNi1ls7Mx/TCCwinq2Z0ja5kVqrh89/DbDSHmE2xQAgiw3wuWCVQtAV9bVSQFLvwIH3elEmgadk5p7xKmZ6phBcV0mfpxtMubtpdPXAPccuVQLD6h+bsbVOPy/3HCYWQwBHCV7z45KrNyAtZljho4N+PPH8uSOlPOX/JV9S5C/fya4KvcZBFxawvPRcf6nM5xpfnuqN5dgzNSsxyr0oGv29Engxw1+4C9gqGdhdfCCp0fhpj/yXUKKuYAFDxyKvIDc+TEiQv87YdifJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgol9ma4L0ejYAP2rul9IaSjIxNyP2viFpL+ErVHRpc=;
 b=TFvktY/gOakU0ky3nlY2mTuljawcw7AbAGDE3XtynnFC0zEpJzMyJhXWEsO3p+vC8/NEBbOvQ30r6YWfcNAY0JOlKZ6VFg+4Poc15YkhltGGzG6BFdEVQmzG1jdM4p625uxtl2YQcsksdjnoyHfN39pOSxnsZTf7X0j1/Ht/TXVkMIRm4cJd9BCvMtnckXyuphuNO/++SiAgGAtmSWeSbu5zVNlXYAe27qWKbEfGfZF9fm8HurzkSjR91jnfDgURAeXBpKAYzUvtwbz/KkTJTRvJewOYZTNY+vwMUCbvLE8POCqHitMOsCvbJfwGq5iVPpbv6Ej+pYCWkkOnJJ0XHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgol9ma4L0ejYAP2rul9IaSjIxNyP2viFpL+ErVHRpc=;
 b=QPN2d3l33uHfCgpJ1LQpnd8gcpwWMJjlXcLJGbgZNe68T7woz7O0shTrmoIDWUECUD/xQcQLRqBiUBELXr+anF2k68T3uYSgAn3P1Gz8G213b4JpHqZr9IJvIGG11kpmKw3zTfdSmlKgOYMwJw/t8Jr2mdDkt8yHLNna5wBouIw=
Received: from CH3P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::35)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 21:39:49 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::a6) by CH3P220CA0007.outlook.office365.com
 (2603:10b6:610:1e8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:39:49 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:39:46 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 01/11] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Fri, 14 Nov 2025 22:39:14 +0100
Message-ID: <20251114213931.30754-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: b48c858f-e9e5-4064-3b3a-08de23c65673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?exUKulab6YDTCeEfF3spgvndnzFpOODyirQIC7Wqq0hUr4DWZc0ELobdZwi8?=
 =?us-ascii?Q?xyttIoFSkYlPegaZeVylVvM21pzZTbu6gqSZwLHkfWQalJvIZdyNT1f7oK+1?=
 =?us-ascii?Q?pvdsa344u8OuNanzgSVuvXv+iVt9uJxBMBGJ3pdw2ga9xJhRcTbPIllDZzO/?=
 =?us-ascii?Q?YzhPARuWoJ/C2s08vLdZkrf3PaJHt1+MyQ6lNv+hBiXAB67Lq3HwxzgY7chT?=
 =?us-ascii?Q?TkY8fHrn49PzaBYeZWMWr+V5nl94/543O7+zUkBVaNwARYtIWhvxuhu01e8G?=
 =?us-ascii?Q?yS9j0VKDbw1txt+5riWz19QEHqZwmTO4Ggs1BeftuL1FNEo2PEAkIziRs80I?=
 =?us-ascii?Q?pD1DrVws4/+a9+JjdEcjFmTZ7Pfsz9QQYlJrOcp7w9QQdOHefHzDRBIrDPe0?=
 =?us-ascii?Q?riB1gvAjGewR+hntaZV2N9NsZEnuB2QQU0I0cLyIDhwKM7WaREDiE417Bkmt?=
 =?us-ascii?Q?A+VP68UJ8L2hSsVClv/ph8fnZtG4sdycoUhvqY9ypSb0qPmj8LaMgNxxvHod?=
 =?us-ascii?Q?SvRPc5YlEKdFXApUKDJ5fl6X/TVvqnFPmNdPDs+zpU/pwnHGblzPEZF9c+1v?=
 =?us-ascii?Q?hc91PiAjCOlJURV7SWiOiE+hUNGJAsMYubfVPVQKjmkR4wq4s/EmZin7i62W?=
 =?us-ascii?Q?eQlEVZpOEZwJza07t7TLgBg9P5giv38Xi9qqNB6ntAWfpRW9SAN9T2HqR4bl?=
 =?us-ascii?Q?6GfBE6Vla9KNAZPrhSOHxywKJf79SqF6/g+numlG+Ms38TbQPxSAKcxg6nr6?=
 =?us-ascii?Q?WXmg89NLqkO3KXyqRzYNid3lVmFhVXxcavTFoFbBVqsnNczxPkONTklCBdzU?=
 =?us-ascii?Q?cWFkLM1Qz7YnUb87A1iNHrGPZLM5ZWw/wicJ2fkqlxlW4hqMYIsRDgWiDQWM?=
 =?us-ascii?Q?/MUBgbdJkopXtTw7SA+NiTwTULqiQZ95R75YC3+4z92IKK9QG8x6hEm+cJTV?=
 =?us-ascii?Q?69gfPAX6iTCK2jeilO4mhqxUaS68BkI+8praZ+IFSA+n0HrFUR62gvuyuBaf?=
 =?us-ascii?Q?M1nGWk/NM/3l0KysxJl8uUmnu8BnqnXd1l1h4EQoqhCtX87ni0tyXegBkf0h?=
 =?us-ascii?Q?n3K70CQYsM79CeGawzwc+jsglF4QzeNlP7KILlqSUXEAqfTapfJ1g5h6BN9K?=
 =?us-ascii?Q?FmAwMuUQBAJXjQ1cP2cgSfkG56Tg1sLqv2D/6yJppcAjhbRngwfmb3pkYN2S?=
 =?us-ascii?Q?OfModqr4Jj7Ybc4qaH2QnPRRwN2fDqln7RaZquRjQ6dDnjcl1gz7SQDCvbFQ?=
 =?us-ascii?Q?UjI6W1isW2bWAFyhZqDnExLqlEIBaVa1vE9cdtN9skU9mgZW/miTKZRz6T9u?=
 =?us-ascii?Q?eU57aNxBHL/OQq3tFaZQRISw8vHzB53kjrDplZmyY0F/59cKDYp3GbcxhNFR?=
 =?us-ascii?Q?9pg9h5PDmp89hUDQ85pC7z32ct4F+i2XqlmA8KiNU32m3+nx56N79pbHYXro?=
 =?us-ascii?Q?oMCDetLeLkgTP5VB42dKSBqxN0XsV5gAzRQyplLtt+v18Mzs3HON1DLXpEjj?=
 =?us-ascii?Q?jj/u7XXT22/VOimAJctTRLhek0ioRZEGKijszfue+WUuHoD/xSiAIJ9YWoIH?=
 =?us-ascii?Q?hUGa4gSyuTkZJxzYxp8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:39:49.3545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48c858f-e9e5-4064-3b3a-08de23c65673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

@hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8cdb6a935289..e108819593e9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3345,9 +3345,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3360,14 +3360,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range *hpa_range = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+			hpa_range->start, hpa_range->end);
 		return NULL;
 	}
 
@@ -3433,7 +3433,7 @@ static int __construct_region(struct cxl_region *cxlr,
 			      struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3454,7 +3454,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3533,11 +3533,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 }
 
 static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
+			 struct range *hpa_range)
 {
 	struct device *region_dev;
 
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa_range,
 				       match_region_by_range);
 	if (!region_dev)
 		return NULL;
@@ -3547,7 +3548,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3558,12 +3559,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that, if multiple threads race to construct_region()
+	 * for the HPA range, one does the construction and the others
+	 * add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, hpa_range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.47.3

