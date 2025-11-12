Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A22D5C6C;
	Wed, 12 Nov 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979527; cv=fail; b=j946phHTByCLInz4B5kgJyLrSSQkHKz7ydwSJaYyN0nj150jw9Z1PCdB+txBvWmNyfHCjAoOdvnK7kpkZY1ant0n122rAnynVx+16fP50H08yEK6//6udOKXSshzwKnxn/FgzfE7bMcjof8htanPYnmkFH6U/6jhtHfvxdlAKvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979527; c=relaxed/simple;
	bh=3so82yCR6jPH+MBkSKU4bK8LvucvOhLYQvRyPEwIWMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYheosnWqPtm5YLBaCxzvNq7tgrvoSkENjpTJd6ENOeGM2TTVyOqbw3bcNF5DBNY6Z1to+szAiVAAgtD83ZJ9HADBYsdoKki7Bs/vY1mwGoZz+5ypfRtqdgNi9J5RnegYlkqhsIED79cNXfNNvOIB/+Djbfd4IIB+i1zEax4dsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ovrl0pew; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ovrl0pew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3w8juUqIEF1UM1HY7WV+AWECzbMzZEgU1eEbcAdMA171dmMpl7yGZlAEN/HKZsfNAzBz5+43/1P6q7yZ51GOVGT+mDvPhhn1L4szmvmZzpMZ1I5HXlqVtKZtU6zeQtYC5DE++iKdrl0r+jFgOiqmlWiqgo4tgfijCQax9sLD2DqqjhWY6sIJoA+tKTduPNBPPrE+c0Nm2y/aR/glXkU5wq+OWXe28VIORwpjyCfKlsjPgIuoVsYVWOb6CY6m+WP3FETcMk1tRWUt5lAk7IBDQ/H0WBpNKiwy6qvqCGpec9vviuOVPlUIsibyi5gIUJIn9hqfmcMAHOYgnco36p8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10TXpjgfFCBqsJj2Gsqe4kIXTyd+uNbkhAAx2p6Mp00=;
 b=DsSnm9iz4VcGCFoAtASya46eiXPR1WfCG7GEb6Cl8Aqyb+8USIexsWE3ZZVMm+x7TLk6P4yHfch9uW3DSk3SvQTvpX+ggyg/v5l0inF1GL7uAObWwz5tx5AV4iZe1PXJxvdjvKOKAspKOcIQPuhRWLjNMFXdgCCz/t04o2oSzQtoymyTm8+LLHCHzVa9cKsac+7mK58d32jWyfvkI/78JPt+H908Te0RJmIMnvCVxu9/kA9MI2ZYyPrpiIJ7wOHVzx1F742tuKfa5ssMIDjc9bcAogY0nXpriOnCZ5dt/M0rMSrEaXaOZXlPRuoFNGu64CPXOnC5ODqF2vOYy+8/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10TXpjgfFCBqsJj2Gsqe4kIXTyd+uNbkhAAx2p6Mp00=;
 b=Ovrl0pewTyHR549wmGIBmzllujkVKSwQBHH4UVOlMr/l+RZKHKx/8BwYJCRBJk8fk0JkqP79Q9auODkIQFG5rynnp8iRvmFDg47VJHk6KqyaAr3oNIv3NY6pJ4tReADnpOP+6rGThm3r2S5YKWdMJkkYDRFDxMep4axGfw2psv4=
Received: from CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::21)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 20:32:00 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::f0) by CH0P221CA0039.outlook.office365.com
 (2603:10b6:610:11d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:00 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:31:57 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 01/11] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Wed, 12 Nov 2025 21:31:28 +0100
Message-ID: <20251112203143.1269944-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0d327c-6d63-4fcb-6dfc-08de222a8847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEFq111YGPUFKFyDi03x+md7MNjYmDpxasNgodLI4bJ8XX++0HZcb37MnTz4?=
 =?us-ascii?Q?RXolOvalkKvPTNIUsFitFwUPfkJUJ+9A4HudKb0GVOuY7xrz/U2zYD8K36dP?=
 =?us-ascii?Q?4kIlLbC0DEVzJ0kI5nFQxhPFb3TnBWXZ56Zq+XK2J9PsTckMNhmmboYTMI4H?=
 =?us-ascii?Q?w8DVisZTF2osR6rMrq2r0TJP5MrojloLTxrcbn+JZ5QhOTj1CQsxWlS88uEP?=
 =?us-ascii?Q?VLov717I081T9HsJsB799Ij2Ldkisoe+tqMEITlHMwhnWaFIZ3B8o19T6UDA?=
 =?us-ascii?Q?qvCn8Me4Hb8WC5aXT998vhV4HMmy/MoSfxMjhJQSZilYfmJoKwKxffY6mVMa?=
 =?us-ascii?Q?SWbgSAYe5fx7g8BUnXIveTUv/burA0o9OlqEjsRINnWmLWIkW5oL9nsvW/hT?=
 =?us-ascii?Q?pmEsgiNCB6vEMXc7HlM7ijejjWCVOgeGLO4EEGsroRYVKWxkPbjAg7fKIYQy?=
 =?us-ascii?Q?jM9SgxdXBf/4E9xYrHRaLrblK+BLQqr6v6UPtuVDH7gJ+jKeDeE1RZYB9iWv?=
 =?us-ascii?Q?SayuPhD+hueOGKf9RIBVTfMRMB4uH/7fFTjG/rXyYe5ejb/QLU0TBT9p45Rn?=
 =?us-ascii?Q?SElbyfipiMVDoH2PbP6Ma6Dglusc4gvO7qLYg3eY/Uw7d7W8D1rb7w3xM+5v?=
 =?us-ascii?Q?gZKsStsUuEsZU2PUXtsE0GSPFEMlYBl3MX0QDqPoAsgRcJS1OzhOBwi5kRvQ?=
 =?us-ascii?Q?Rhv5IRmR/SVwXZNpdS6ROnPnpW69o4uJJwljfDTeQPlgNWgEv8d2TspKXBpJ?=
 =?us-ascii?Q?eK9yZasSzCQumHh+oQtz255ZLoAdOL4N1M0u/2j4u3HYjReA+L725cmwxuDs?=
 =?us-ascii?Q?PHaMoSctdN8a+YqHJnn8DYo6YVjKC+mPcAHUKhlyFMCtuUEgihLKkcQ6sgTa?=
 =?us-ascii?Q?e3nN1nLmFVrDQv4bumFhKWF/MpYizxE0gLp+GPJTu5fQszHPFQ9NwOhDlVjf?=
 =?us-ascii?Q?qB0Mf+fJUuVOkbethYztaMgKPsJeaZVxcRhewBdYUhG17Pnq3y92m4MdsjX5?=
 =?us-ascii?Q?NrZvAOW+rch5W5JXaP4JEfFMHQFf8piVMjEdMjIO3Nq4y19L/eCacW+Q8yqi?=
 =?us-ascii?Q?AbMXKCJMg5itmNDLlnq9vBsXwEL3d5PRwF+KDVWDlp7MH43ktG6JQywnw7Di?=
 =?us-ascii?Q?gK3QA1V/bhifOh95mxNnjSHzIRvdDaYNLRomPW2bDPK/Vz0lLDmvm7v5/Kkd?=
 =?us-ascii?Q?ZwZGqzmuIZHMmOC8n982fhTz00HDf6UYHr0IyBbvqwF+6xFY5toMtUwMk5cg?=
 =?us-ascii?Q?JCfT9M4/Y/B7peDWrM3T6xkUit+bltg5/vyIRshyhvfbjiPwvQT5G8zN9uc8?=
 =?us-ascii?Q?xZ5Z972ORPRZS4FuyYG2pr88NncH1+Rw110I1O6jEYAOHKtVQO1weXa6g8t+?=
 =?us-ascii?Q?uvm+6qZBzZF8Ye/gOL3cMQGlGBRgxYtmbhSEclQIBZnc5baodUow1klvK4UC?=
 =?us-ascii?Q?wLBlUXFQZhqFcMXzF7P7kTwFf8NCqFxXzJK6ByIceWBjc7qy5PjB5LehDHQo?=
 =?us-ascii?Q?CvqxYrHYfuF+CTNKxvXam9b95FAArmg62B4hC419JtyiJGrk0EUP3FS2Ybzf?=
 =?us-ascii?Q?YDla9JTxP1tU1jxvOO8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:00.3004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0d327c-6d63-4fcb-6dfc-08de222a8847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4

@hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a2c2fe6fc131..500aacf66d36 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3463,9 +3463,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3478,14 +3478,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
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
 
@@ -3551,7 +3551,7 @@ static int __construct_region(struct cxl_region *cxlr,
 			      struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3572,7 +3572,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3655,11 +3655,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3669,7 +3670,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3680,12 +3681,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

