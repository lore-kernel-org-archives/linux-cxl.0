Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47442D47E3;
	Sat, 10 Jan 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045675; cv=fail; b=BjH0ChVQTMqq/EEoYrV2pXhBIN1KqnceA3BzMSUsMiGl/Ms79d/aiDxnXXkL/5HLxA63UlzXMCC7ALTVmshK70kDA1p1n3PwO18t6Ay6X/Cr1AmdONDdA4Ts/Xl31S/cXZmZu/hLZ40PetOxDtwLpwlClI4EQV0KA9H97Qa5xtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045675; c=relaxed/simple;
	bh=F+yHuJEHaN1K+MEf0RoMFO95d2eqG4CBRv+iFBlFZtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7x+PPIzeUBBu1n0zit9dYAqiXY+vgjT7mZm+CFPwqmPL6Knmewq7pJ/XIdZ5arJjXMcMXIHmFqJagSCYZmq2LbYb/BubpcM/QmuXGK9ol25Jzg86Z4QcGckh2DWZTo9h2za3dav05ND8He8gO9gIdS1DaVfOlpMeRcQk5VShhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xyIt6++T; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xyIt6++T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ6E1dOXrSIt+evG2x/v7E/7pMcU7SbrRwYn7eS5rzA5f7Q9ptpanvv09QlE/yxBF0noKrnaDMiG4gvbWXlbMkB/A7CG3RiDTJg2PPrL5Fa19K6LLMGpHHkdheRMIw68oJqou2IHizEd8cE/epcbpt5Hvq+IrDtIp7eFI0HEVXgvAB/++qC95oCLEKI7BBPcfVxcPVvmCuLhiAt0S1mhqtO7L2/dLl/yvvJPiqLi9nMkyqdjFbQy3pjZ06yaMyS1P9Jlb1C3X5OuFLPRGOLA/sLFoN7mhnVH10xM9cgyEqVa+jaeaiRCSnEMADymsZlcVxdngw0TvKNuMvaYzwFRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIOVclJD3g+3GddSL5nljBErXw0iCTxDwqo7/ijcojE=;
 b=liGdhLOt1NXGWLxJxZA3pUej+B+l25Kx1iQfhRRr618d713cr5wi8blEnHxD3lU4yntHup7DE8scI3uFNeZc5wfWv5aPyPpmVzycMHObtLI5jLF8gcgBIVic4vWXkSP1qsmvfmnMY7UnAu3K3fs9k4Rb/FCVSaFNBZySClXELXtii6MTzOIdXBkL+DJiYWAaCjvhVsj9egVgnyZ3fHZy5JCigFbaZL97AC4iKywkES68eQ6NZgOaeeKQDgp5qcvkp96HN3W6XR0DdFX2AZlJ4fQP2aYi4K20jFrG8rS6l4/baQ+GW4IPfSzTelB8kuhFG/pU6gsk1T1uVWkDvu9E7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIOVclJD3g+3GddSL5nljBErXw0iCTxDwqo7/ijcojE=;
 b=xyIt6++T0w0bukfsYqn+RpwQIN26lNk7vSy9Xly/5wb5owUo5wQFGrx0F5okDPHcnZcIAsMRndvU4O0qj8S2xE0632z0gOObF+OrOrmzLwXBDC9CnfP1XwDhsV9Miodhxpr4+AfVo+tqZHtL4cNIC46VhdU90L0qszO9CTo3Log=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Sat, 10 Jan
 2026 11:47:50 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::94) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Sat,
 10 Jan 2026 11:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:49 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:45 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 06/13] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Sat, 10 Jan 2026 12:46:51 +0100
Message-ID: <20260110114705.681676-7-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 560d960e-627f-457f-4652-08de503e14a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NCSZTkiYUrDu0InDZ8UTVGiNKhYYmCwEgcZT7sG7sznTzAHhx3bvdQnXYeM?=
 =?us-ascii?Q?xLP4qcDQmzzQ2cNy2KiaW55PuKKJtuuBOqrvcgzndAsw8EP6eQVR5tzGVIW9?=
 =?us-ascii?Q?tUhKcjHifRp/lu8BV73uM2crja522ZMHeAvYA9+/3MCs4vH6L8I1OfyYJ7MW?=
 =?us-ascii?Q?j6zykBEFZTDqS2dzajFG0s/oC8Bt+0rbGTUC8zPlTplOvw64ZdrNV/Oi1lMd?=
 =?us-ascii?Q?hCfhvbF1KXBlYGsLUETg9U8LPtRTjEhB90raM3j++srjVR3Ocp+k1fYoZZyX?=
 =?us-ascii?Q?BFGj6tmqZ8NGYD0RN7XRgeyIRNc0uM6oSAQTXuVPQ/23NnRgAWi7urDOLh2E?=
 =?us-ascii?Q?nPxGj+AAm/JrZPvmNhGyjev6ykoE3p/Vr0SiAH30Y2oKyEDCc9nvnlsvh0OR?=
 =?us-ascii?Q?VTBCWtOcjRHjSpyEQJB7ZJQeuDhzZ8dzXW8HBOgN4DPBglnpePUiUcjffxX3?=
 =?us-ascii?Q?8MM+dAgGkkxVHtSP9twzc6LtlD5oAQLxF7PZz5Q0UUb8ckaIj93HS9kRxhmj?=
 =?us-ascii?Q?0GJIya9EbYheRUBk307lmL9qhqYNH1Dr2CZ8qUkYaYyFC9/oc3rA0/t+QDWM?=
 =?us-ascii?Q?nu4fqzpu9LZPo631Odx2eRuY798gkrMe3QrJS23jK588Qru0jLdkYhcyT/Nt?=
 =?us-ascii?Q?dlMm3QXkD5d51MJlWNmIde32JlRgsgQq9zbzNIi0h+lJWxfg+6vPTR5zP4fQ?=
 =?us-ascii?Q?hBS1PqvQE5TQifZhMT+eIgNhFdN6Z+iehpDMt2qE3J5ZsgVdfEjFiHP3iNMu?=
 =?us-ascii?Q?WoNlAxrUFLgq8I4Hk7NCFm5rk7S83y30jn1rfWudapK2bih9KHHGuaklsLZ2?=
 =?us-ascii?Q?z3gT26dWP3eBxDvKsYUskPkG4hgo3pLJ45m7PCM75TjSoA3TvxEMvLfIsejB?=
 =?us-ascii?Q?7E6PO+LgUHagK+sXyL6JqcLz0/qGCXtLcmMI7VyrL9sSr4j13jsXOLfN+yfT?=
 =?us-ascii?Q?4P98nWJpYL2ydltUyAgwHb5rtYYbvXhK0sevgev6bCg2EVwjaVNe3+dRFN+g?=
 =?us-ascii?Q?+nmak7diuGf0lSel511bMBNOfqtikhOddqT/K4Svtgm42kDL66jcuuaJlQ7B?=
 =?us-ascii?Q?slTcDfB3abMaIcaMSushxnZYPYsditwQMacpcDkbZUAmHzL4FUZKpzcckmqk?=
 =?us-ascii?Q?ctuKJdpFTzHpFe6NhdJ3ePmxRZHGhBDyNfz/0dSP+2QjwOM7qxacO0yNpyhJ?=
 =?us-ascii?Q?iT7hJmljvzCGRNdypzuQi42H9D4BDb/NtUUuYXAREpWAZHBxKkIb5zDs6txS?=
 =?us-ascii?Q?ENNNbHHvEnNbhmQCBG1IqMNDdHc/5gmo6VMpF3lLxaRIxMCzQUIECrPTYKTq?=
 =?us-ascii?Q?SCGeJtQsoeUocGMOFd+4ncgMCNlTlCjVF3KRuYwjvkj/WiUMlA4v4Xyba9uu?=
 =?us-ascii?Q?AfoZnW7xAUDt+jSHkr/V9kxVLfCltH0747sEeKz/6bUVj+diIrpCEVlwZrwV?=
 =?us-ascii?Q?UfKgmPYisiUcLU2rph+B/bGKhwZ9baBrOIpREF1+mqa/jdmMN9ea96et2lPU?=
 =?us-ascii?Q?485ogtLRFOGaBaqIhUGn5RyrhSHN8EILr7ewc+IJcicliPrOVTa5qE9QkC3z?=
 =?us-ascii?Q?SVWMTvyKUBhz0HuXbxE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:49.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560d960e-627f-457f-4652-08de503e14a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5ae77e9feb4d..60d2d1dae2aa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1878,6 +1878,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1890,11 +1891,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
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
 
@@ -1932,7 +1933,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1942,7 +1944,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1955,7 +1957,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2139,7 +2141,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

