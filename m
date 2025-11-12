Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191F2D63EF;
	Wed, 12 Nov 2025 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979549; cv=fail; b=PXN0Whr4nG8L3reRJdDjLilNv2qJTzPdtn6qE3oIbkA+ZZZiZS4z5goO+K8TahX64FNOefGgQli9JeWcVFJpf919U9JG92BGNbLdxbO5mdLuo+6iN5Hz8xBeQx62Vqb6jKKu3TCpFPOzGc0adTsSlFFML+UYYze8hrhOUVuBle0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979549; c=relaxed/simple;
	bh=5x5QQ1/ciFvMKrIgLn5cJ0OMPJgS6nO7mj7pWIEZkDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7smUk+CtN50dIlsPJ5jWR9WfBp5oJ2ADPOvenaoj2BzhwkaPsmxTyMc/XLCqAolBXweuxZbUgNXt2acAn7YewOoJexFpRT/vq+CjLGi2/jSU9wE0J9nG0XGjHiFkGU5BnXB+qxPPYlk9uM6wozLO7lCj+0y86vabFnrWR1TMlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sw6snucL; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sw6snucL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYc5DgvEX28tE9npyPJ/vB0dM3HRHYRgZX74dLPEM36TLvg2nPJsoka2gBy2uE46SAe4ThzT/iDvxjZGsVHcCAOxhx9WtIyAa7AwWS+EJ4vRxiKG5M0KsOs+Kev2TDoUZybhZutOGBAEn2dwMs3KB33ijMoNev86K33kRdpghhowKS4/SZx4bLRy51jSj9ke4T01u55cn5CZ/nLlhZkU3wUhR6izjHMXANo2BmfYjKdlMPWuNZGN8QpGlauZPRhi82cnZQpQpeSoH/2rC7gWYPUIP7h+xHaQbVVWTf6PxmWQ0BANRllEDTBcc6yzduq5fsMOeunqzJlFO6c16Kx6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih0xTG0G8fMr52MI2dvjhGv5hpMQLttXQhXawPCSGHI=;
 b=ox3r7b302grc3JG7WrqbZSl4aeWLFf7kMZKEa2oTNq+SJDMf+qMeUniZRY5eGSzoZjTYU8UnJ+aPe6tPeGGLonNqOjU2CdfjwKNFYm4Dyzs31PDDsKDewe8WxLuYVGMO2dlkuHmVHPYakbC3+5Q/4ZGqLCPxKxwt8/fuk/45j8fhxuzQMu0wkvKjO3bWVEV4+h3HKTttoCHfj53MHrZQ4MlpPh6AYH7vlYNNoJNfSDBMUcVmkXhuudvo8hPDFl8+nok0CjkE8vTsc1HQGt/dy5ko8mFv8Mr1qi5gSV06IRG6bl8dDnV8mzPjxzDSfXlagftL9MhK+MkGA80v7doLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih0xTG0G8fMr52MI2dvjhGv5hpMQLttXQhXawPCSGHI=;
 b=Sw6snucLh+vwkL5fKgq4D8wwbmadmFwDEr1QUAdgTzpvxmJDZ9+go8Ugrtpkc+B30ltYkFige183/gQmqKvEjOQk2p/Q0fNyhL+2jcc0matn7BIeUMLkguLb1iFpM/LIp8+TH5YdGmL3ACEupL9zKYj8onNnoG/1uBBUZf0NCRA=
Received: from CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::17)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 20:32:17 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::cc) by CH5P221CA0017.outlook.office365.com
 (2603:10b6:610:1f2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:17 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:14 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 06/11] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Wed, 12 Nov 2025 21:31:33 +0100
Message-ID: <20251112203143.1269944-7-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5dad29-174a-456b-320c-08de222a9272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6RVyEDUZz+gSr1OljvuDtwJ7kFxk1I6DYXKKfa6iMihQRq9Gc/+3+38ix/r1?=
 =?us-ascii?Q?35nq8qwf44KojrCLHZCD1neL/BT9KvxMXam9IQCKDnudxSHje0c/HKdNi2kO?=
 =?us-ascii?Q?jPuQXa+/XOpJLZE2lUwMj2/1xNAjlG1keUI14tvqUvqzuHAZFlHsePp1AN2c?=
 =?us-ascii?Q?ML2H167ZeHLemY3PA9zEd8Ig5uyryCBF0qteQ/XhzzSYEwd7FYvXRoawhvPy?=
 =?us-ascii?Q?8aLy2hREOfo8k63C7ZOLnYetEK1AZNUbAQojcEZZSfDYuHvhQD2fnG0MaTQ4?=
 =?us-ascii?Q?GylLnG5IpeJyy4v1hegy40ZpEsHCeCMk+ZIp1JGEdbMChz/kiQFD/V5HheBh?=
 =?us-ascii?Q?pCK6X9Zb3r6cBL6RI3Q0mhTyJqOO/l09souSZKO5pCe4sGwP4Ivc5XTR3fQH?=
 =?us-ascii?Q?37iLi2ZdzIc5Pfu623St3XiQJcWZakodTyu4kgI7S9png1Qgpb1FDTgjtukr?=
 =?us-ascii?Q?DANMZCkyHH6oXwVHH0g/EaXDhPTDIFddcw+gaUT9QHJdNQVKLdmyt4OCbkup?=
 =?us-ascii?Q?tsro2o8uk/Lw1mBXROzdpZG1/GjgOSChdsoahUbFnNMxqfYz45w1LzR3qN5g?=
 =?us-ascii?Q?jnQeE5N5WSN172dA5QXh3OWSs8h9cCxpgUFzitDqwXHuzQonMfbV0AB9K3bd?=
 =?us-ascii?Q?1ahck1I9xjdHA/KzCzApk2dnGMcVywCrWA6WKGczE5QQvboZ8GP/9TKvK1y7?=
 =?us-ascii?Q?3c7t5czAax0dlW8PpMacA2/bJ0mi+byWCa7OADrWy4+CSV0zhHzVlCiuI/sP?=
 =?us-ascii?Q?6frLLJk02b+vVJNll6EGUGYHRqfNQESTDXx63rTUvDJu/8VtRrMIqZZbTT4p?=
 =?us-ascii?Q?uHHEb0osmSJoT4Pvi6ZIkiuRIwiEXg9krd393/UK88UZhDb0srFhdV6pbIyY?=
 =?us-ascii?Q?mFESumnAhnwih1w82y2jYQ9SU6E+usWkij7AwyKP0wqUnBwcSa6wB2B8wPH3?=
 =?us-ascii?Q?PYkBhepW1+Vd7XmJstq0BbwR/Ut4cdrIyEVognqZANXYy05bbrzYCWWNHtVU?=
 =?us-ascii?Q?OLvkwMh8BjSID2rYbTLgJ6iPzfZKMFSvJujgE7CndtAM9/Qh7OiW0QSqr1Q9?=
 =?us-ascii?Q?rORWDj+Ss5gSQFwRA7i1FZ7dXOjJNqYDC8lzUBPcgjqBeQY2bdnz43YZynru?=
 =?us-ascii?Q?5SCcho8h+/6jI6eUVEApXGTGh0bpwF5AXSHxWrgLfjtcsu0rcwTcsv6POnqd?=
 =?us-ascii?Q?dlywNavoegnHOzvEuYQzqbmIWTZNnszgniq++1yADua8dH9fy5y9MWpgUPBP?=
 =?us-ascii?Q?U58zbGpT9MLKKjcFs7RaPVfjD71Wk3Bbh9Pb1Mkrp62Y2qs3gza1FAFXhdPo?=
 =?us-ascii?Q?PTpzBF4vgIxeHz6TdpjV4Aklg9sTqcyUeP3KlWU/iqwCdZs8EcTxQRFodOdb?=
 =?us-ascii?Q?nSL6ZSb8itn/y/zGP1NpIvTlHjsEOjMkwGW/K3mmIwxgfM3nzD5dbQUkfQZ5?=
 =?us-ascii?Q?DJBoOBJNV6pC2WA/Fn8v58gLLYv3O4HEXSjD1ac6Eeov7mkV749GaoFzHKRG?=
 =?us-ascii?Q?2zbr7Gqqk1Dm/wRcA02/+MsoIW08/DcUVjFG4DACQYmyJLv4rjjMPtElbd8K?=
 =?us-ascii?Q?I3oWf0iggYDjYmF/djk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:17.3292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5dad29-174a-456b-320c-08de222a9272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

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
index 07adc2075103..0fb11017f16d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1858,6 +1858,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1870,11 +1871,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
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
 
@@ -1912,7 +1913,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1922,7 +1924,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1935,7 +1937,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2119,7 +2121,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

