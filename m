Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776F337105;
	Sat, 10 Jan 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045652; cv=fail; b=Q6Q45926yASHpYElJ25TaETBzGgG3C79sQeioxNKa5ExD5xLGdlngfpIUwo7U+xy3WhuzgBBlXT61UTNBV8m1tnK/nljpmb9J5jQlRXs2Krh89cQEuqG9kmHrRJ3EY0GQN0K8CEl9y8kSRzGfdd8+Pa+L/JE6yvopjQCrM5xrMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045652; c=relaxed/simple;
	bh=ZseYEppR6UVY1gARXD4K8WwjgPRHq5lJC6YDoB/J7eg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbPRuOiWaYdoSHR9qiVMuvf4DSA5bCFz+oKCUcfWMj+j9R8UqKbwvZ0Babkeg0sydPWs73p5OGQVXONSCvJLdw9OquEOPnLh/x3e7xH0WZ3TyN8+z3vRrThgu44rVCymGNQ+ydnhQiUaLNifAf15XjijBBgWDHve+DU8aIMJOII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fbrNMSCg; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fbrNMSCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlfDif3DL39+eFeipScba0GV/flVMuJ3cxF0rirWBPi+cwdVmHr00UKicQxubdx2n9GoWdHkcBu4drCaO2xCX5j5rb4kMPcS/A1ssOyUP66THSsIfW9tdpgH16/WMoPm7EOyDch60E2vfdd2CPjB9JFnZYDCvEeZ9fVTa+7VfvlVVyg2/j2TWBw3lLUqeEK2ZnQfuUxgYJX7dxpHovu9o9zO14450t0maLsMxaiU49/PifUBsz5dlFFltiHwnZcvJ2pJOm4MJQYiH8EElgV71o2nDB+sZzGrmYFHLu+c4AQOfxvDsB2OhET/O/W0eyNFsX8DtlxCTBnVN/y6Z5XWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4iE2Pgf7hea2F0OJpcqQYDfnbOzL68vRHssCea0lZs=;
 b=p92HDOWZ7zHC5Wwev4O4687jlKi/V2vGcfvJ1RIdKRKCsX12YmL93r3wRuWeyDB4GEPkZ2/JIALNFEL6i41d51JKsU69UV53jtD0mIF7tyENJBtESiE/mz5tn02+HGxDVAoyd9Wedkj5of5PFFEPTf6KYz3TP0oy+HRgRM6cHa+1b18TVhr5JRKQlliYpzQ4euPPVIoOfSlMqlfxt0H2lZVk9xhJz0SMEaFJyVGit+ALEu9O4BST7+wgNNNCh/62qGb1P6JkoFb6eyxf/Dmf6V7CzcXH91VyIJ5acCFnQLlO3pbpfHzKF1EysZiEPqQUBmkj2hb45dwriYp+LU5m5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4iE2Pgf7hea2F0OJpcqQYDfnbOzL68vRHssCea0lZs=;
 b=fbrNMSCgr+cNcxA8+HCfDbOub6cLpoyBkwm0+5x6q6NkluelDIo/4lna22HtMg/AedMBvIbd5ZWlAG2ESeLM1hI31IR66q/+iY2DqRCEa6rqWf0kKiUXxtT00CaX+Cvo4lsnRpDO8LKn7v8whmt+Qo7efnnujgBqk6pagXtHqXw=
Received: from SA0PR11CA0172.namprd11.prod.outlook.com (2603:10b6:806:1bb::27)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Sat, 10 Jan
 2026 11:47:26 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::b) by SA0PR11CA0172.outlook.office365.com
 (2603:10b6:806:1bb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat,
 10 Jan 2026 11:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:25 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:21 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 01/13] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Sat, 10 Jan 2026 12:46:46 +0100
Message-ID: <20260110114705.681676-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 97859950-b839-4586-be2d-08de503e0668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GsBrUa6S1XVd5KS44G3keSA4v4iJ0ITyE99WcKFTcThJdtp+Uy+6rt459kRg?=
 =?us-ascii?Q?mGWBaC+bS3Ep524qox3tkKvFYTB5njjXlG13UHBYeucppqm7r6rQDeDhiJ7/?=
 =?us-ascii?Q?7qji99b5B5pyoBeYLR1JYIe4S1adVUxUL3T68eYFCmpQ8/+W6RYcsk61uZ0F?=
 =?us-ascii?Q?6IICttAVIh6Caip2lgXUaGHtvCnr5FtpUL7FS6ehhDRk82XTRXVjphtYGAhG?=
 =?us-ascii?Q?y3AXU0Wvfzw7RZSU0Kg/srLAMQgppdTbRdUeoPPNKQ+lyxUBWrwqLIjwoCxl?=
 =?us-ascii?Q?S4i4GngK6MNY/VRdG5QDrAUUETB3gV4Ri1N7CpqbVolGNqsfJmRt6v/Dwii8?=
 =?us-ascii?Q?CA2KuyyaVx+YcaV2aNwZ+dTA/CsctCgaEggYRJ6hbQEeCrOS7zP1g55QBsT+?=
 =?us-ascii?Q?5vckA36cRpVicR3Zg0YssASFR7H9fbxmZXG52xGm7I+3Tig1kNNHhOLmypNO?=
 =?us-ascii?Q?tWygYJmpvUmpPQPcURYGXoLhl2P1A2ikotCgFGlJS+/JF/5S3ve4smNzbCX1?=
 =?us-ascii?Q?N6Khm+e3soQj70qtrmiYAqBmJHD3uWb1c1x/GliFvgnMuhAYeaSaH0naxGHN?=
 =?us-ascii?Q?jzeulED9b9WBVhqU9rCxkCIemoQvVn7nBf9h9EWE7+HtGj82OOe/+i24MQ/R?=
 =?us-ascii?Q?Wf8B6b/5vfraq7XoV/4FmH/U5ss6mKxdLRIXuCmxmHpNx8mY+KISn2ebNFnX?=
 =?us-ascii?Q?bGWec3LBF4FZQeYFL5GsQ3DnkmLCaXzc86ePBWtFVs+vZycB1romaL6YJZ7W?=
 =?us-ascii?Q?OdpDOEDRjvFcoH44Xl6KpGwlgyE6Tha9y4qfUgFPwitYhmLe4XYou7CIt7D7?=
 =?us-ascii?Q?ZvR4L7VB45HmZb5+EtKRYbBDcJhbfFFtRMlx5pVal+I61GI7LQcJwTGJ32/G?=
 =?us-ascii?Q?vWIPlRVxVymcem473+y4PXlQFkphtkAgnLj4GFPxvnc+HTMQCFicqVsdSgDs?=
 =?us-ascii?Q?vx99KVQPqA5UomCEUIZzBR1fy12SwpC/xvUVpGqJISYi/ZK3mDT3ft9pA2Bh?=
 =?us-ascii?Q?xfQo2kg+8RlImwfHSt+X4jLsltN6Tnu1OX+fSv/reQmdxURRXAHCeQ3gJhUQ?=
 =?us-ascii?Q?H6PooZNhMtLjrdRy96QOU5JspZWry/QvDMOdN2WF/M6Em9BZcCWSBYme6VEF?=
 =?us-ascii?Q?5UV1VZmNctfqh+eGMVMbM4PxI+Gw4cyfFQg2Px4rAQ+9zNrbwCHMWIEeAerp?=
 =?us-ascii?Q?Kx8CMp6hc7z6v78tBP0dgHxQp5m4MS/7/c31b12HSfe9sX14rvRJV68MiEOR?=
 =?us-ascii?Q?0n6Cu7Nr5Y9+7avIrXs0essauOGxP/UOqtNZWK5ne6faTXfOr2vzu3inn4VD?=
 =?us-ascii?Q?n3y/rAiogBjIlqgrKMAZZBzB6y5vuvW4ldj0bJZ8QNctFP2bBlVaQYbtWQLX?=
 =?us-ascii?Q?NfAwG5o7mrgeyNUnS2JRAuTYAxY0U+UG2Zt8EEK9jtZqDXVf0Z6k+S+bObhU?=
 =?us-ascii?Q?+nFS+X9f4n4/5lBEmESfWI2hbN1+Ypnr2M7y2jE+msCmuiP/IBuTlFjzEFkU?=
 =?us-ascii?Q?I61jGiyqhb4SGmHft0pSKDO23rnp8SjZUiR1/rb5IYd8+XQzECrgGrwJmISg?=
 =?us-ascii?Q?0mQAkM/h8YLG3vqvK/8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:25.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97859950-b839-4586-be2d-08de503e0668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

@hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..51f1a5545324 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3474,9 +3474,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3489,14 +3489,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
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
 
@@ -3562,7 +3562,7 @@ static int __construct_region(struct cxl_region *cxlr,
 			      struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3583,7 +3583,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3666,11 +3666,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3680,7 +3681,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3691,12 +3692,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

