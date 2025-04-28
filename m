Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010220F062;
	Mon, 28 Apr 2025 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876650; cv=fail; b=AVOvrSD+vnbSdXgD326idLtqESZ/SHA3Vl63Arf0XXgmC4HloGLRNzO0KKvqehwFG3jeVvryssuL5JkfWmse3EIMmSRjISZYUkrxsbaQgs8pk2mLRaen2O1S94//aIor6T9zLXIijs12clf3PFQdBaLDuM/77mypju9aPzuA67E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876650; c=relaxed/simple;
	bh=r87Omrazaokp5HoWoejoZi7GHpt3FSalP9MkTtyEkYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5VOYFF2edBCrIRXo5mUq5+Vb52ibab+7RPv5bTG7zrt0VLvTMn3WaHE/eBt9esSNh+QWgndxrXzivfDv2f/+nBSu8n6Yg982jfavpSln7TtcbU4z/Yve/bWc4wJz4s8ShqG4/Ozn6RM3aW8Dog71d3OUTjpLabHafNR9fOoyOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ozGV/KpV; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ozGV/KpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDeCHdosLx2kW35TyHeFVZ95UIZPjRKyRvdr++C+sD+aAp6COSpbPYyZCZaYvf6MWeDVH1zwe8HfqM/TMl+MT2Y9iFNzPPrnjbwgbsc/y3N/XPUOnZ+7sYI6jTzWVlozvsizMdChjyt4KoAILZ0HBYpiyILabcPyauAJU2vnRrMc0ycJ8pCf2kPuc/EzRMfUWfK9+NyUBwWgQS+clegLdfKPnWIg4KpKP/qMuwZOqMQE1bPB4k+7mWGRmHb/L1pNdKVcSkjf7R5aauGHcnilOlq3qUZRcD9GGUU7oYigt/o9I1TlkoleamAlfSYBAg+eSLt5EIQQs57fzBufZHvALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTRYtTti9ZqFdSUDiiwfASrOVPMi6HqyiG0aQ19+IhM=;
 b=mjUXgt54+P00aLPjDbjnq4IUU5hs/fddp91+eti9q5qUSdnH+QdyRKEqrkWw/wpb6KbLERAOUrFTcH0QK1r5cb23lc2fOG7UZStsV20JZriuMmYAehzb5UpILscJ8kTpG9VBdX+UTR7icMZFi158QalrInp2+OZ7qu1SfAm5BLPSCTCX42/ptHhrYi7pWFwN0/wyenooYsyqezq6hmaJNVIp+7puYYccv+758mWPR4fLMgVEFnCd5eKI+r1vp1V13Vtnvq8FToIDMolpGUYjIvCKAtmkAzqo6Ltd1BAviCVlKg1V+57bBPBj+Jh7D2GAvVkD+JAP6kyJrzg99OpAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTRYtTti9ZqFdSUDiiwfASrOVPMi6HqyiG0aQ19+IhM=;
 b=ozGV/KpVqTWiE3ZoVfG6mG5C1ayMewM0JY9AtGWeKpPmYU/rkF3wdwj0knvnAC78O4GgcFKCy6HFd6UiQnAhiaOob2UOzRd9OHGq4Jnq0ZzkgOPvYqS7645f/2dm5ix8m70mj7/iuSQyL6JNBsYAuM1If8Kt0S9GKJe/HeIkVBM=
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 21:44:02 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::7f) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 21:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:02 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:58 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 07/14] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Mon, 28 Apr 2025 23:43:10 +0200
Message-ID: <20250428214318.1682212-8-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd5d3cc-2569-47a7-54fe-08dd869dcaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CX1+zy4F4N5GoBbiRUZqX38xO0czpgV0R1q+gqw9j8FvVYlHf7rEYb/Wxv7J?=
 =?us-ascii?Q?7CFN/A6wy6Lr1eaVWkoPK2h3nS6YXE/syq8A8BAqDMXYEge6UnJPogEQlQ+f?=
 =?us-ascii?Q?aOF3EyLL8lKA/ID4O+16ZYXG8KZm4peFjMckTkeu0zopXX0KuSa/xVH08u39?=
 =?us-ascii?Q?6uVExnr/YNzeKTACLXjernq88DIbzFgJr/YgD0ozcD257nqyGQ8CUrhJA9+0?=
 =?us-ascii?Q?kIPIN44WmhzDBAcZqfJvj8SAfXehK2QHr6AzdI2yo62zS0HopBYKkf5AiK4p?=
 =?us-ascii?Q?67g2acHLn6y+jdrwvfB4CyQjirpU/eXbt8rHEVy20nNEOBy0U2BZCfgNtToA?=
 =?us-ascii?Q?q9zVYOhTWcd0GrvxO1dvjqSpEc8tDpKt6lgVCM1APMYzEywxV/0nnC/zm7QO?=
 =?us-ascii?Q?dm/GJHx+iBEHLZrAhq3qn5OjZe994+mrCgJNG3LO8EOmamNccB4KihaWTBrC?=
 =?us-ascii?Q?pHf2qNr5+6ev6Nlu3lA1yAWN3YG49oMfenU01STOie2+CIDJMcZ97Bv1fsF/?=
 =?us-ascii?Q?bBmMa4XW0lf/SP1HVGVKu6mgQechNXZVO0It4vaWp302H5lnPjppHjcy1KSe?=
 =?us-ascii?Q?aB6KhjgwJbdZikYqDA5MY9FLpb7b4fXHLfUloCaWcXQaI4y1bmtddsvM+d3T?=
 =?us-ascii?Q?NBgfpJIiGCar+uKGQJ1Eb4LeOtX6WxfghYI6j9zX/nMAUNls1aCLrII3bGKS?=
 =?us-ascii?Q?otlTHdr6jNO8wF9ta9wOxRl6rBw3MmTiAT+tHNZ9byqQ8w3UoBEsFklC8gKT?=
 =?us-ascii?Q?9zEzh4q4ikiPcl3h7u8w3WDF67o59Xk5Y7zkDg0aQ0rxgTLuWevKFs8ibTt2?=
 =?us-ascii?Q?jwSt2bDJSEbwvcMW7QGZ6DvwOOGw7kp4IShFCwWu3uwEK4cxY4GlTKnvgiWN?=
 =?us-ascii?Q?KfX+Nx3tKePQb85dPOq7p2ptdKR15PIA1nyf85FxqqwAl/UtX7d6rvzI9Jer?=
 =?us-ascii?Q?rogvXtujU9r1BvY3Jz4RbToCsGFkUmkrMyyy/YFL4ZvqfGJwJg+SAT+HPs4A?=
 =?us-ascii?Q?fMD3XMl90JzJN0AiuUS9jbjQyKMCzvjZXkvGKp0MRabyaLxsM6elWGA200ac?=
 =?us-ascii?Q?6wlki+gzL9ttvRlZHrxsUZ6/1HjbPFgPdqdni1/YaKPEO+8BUY9ZfOlHrLAI?=
 =?us-ascii?Q?R5BS3oW3jtUHa5nf/Ior/WsAxSUBDQNFwqnqqRMLR8xMqOKBdQ9qmWSTvWyl?=
 =?us-ascii?Q?b9k6bzf/yi/4cx+jsugKamSX+8XKBMKtQm8uFHDgDGEB2HNLZrh+bba6Uz0y?=
 =?us-ascii?Q?Z3KTAZyi9twjc3inyg57jcMi7hWkfDS4BSXHKZ0K1gABElJbRdZCpYFbmnVu?=
 =?us-ascii?Q?Cn+H/2UQAT3WK1W4BJKvXl8G3jpWxg4OjZyNAK66F4xvk+/dTNW6Z4HbwENM?=
 =?us-ascii?Q?y6SLtBxLoQlo0IiroM46uiRQB2W+Xelw6SV1ZBhFL+5kjTCq2NqSyjKxuCj7?=
 =?us-ascii?Q?EkR7diK2tjdg8tRSPdDfBQ8nCBnbVEQeaxIxQVX7hApNO5eGbJDC6sSXtsv2?=
 =?us-ascii?Q?lT2c7haCEmgjfp9i8a7V1aW4CB5wCygPY6CP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:02.2508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd5d3cc-2569-47a7-54fe-08dd869dcaa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649

When adding an endpoint to a region, the root port is determined
first. Move this directly into cxl_add_to_region(). This is in
preparation of the initialization of endpoints that iterates the port
hierarchy from the endpoint up to the root port.

As a side-effect the root argument is removed from the argument lists
of cxl_add_to_region() and related functions. Now, the endpoint is the
only parameter to add a region. This simplifies the function
interface.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c |  6 ++++--
 drivers/cxl/cxl.h         |  6 ++----
 drivers/cxl/port.c        | 15 +++------------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fa3d50982d04..256d4dd631c5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3385,9 +3385,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
-int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev, *region_dev;
@@ -3397,7 +3399,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 24cec16d02a6..960efcc60476 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -857,8 +857,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_port *root,
-		      struct cxl_endpoint_decoder *cxled);
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
@@ -870,8 +869,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
-static inline int cxl_add_to_region(struct cxl_port *root,
-				    struct cxl_endpoint_decoder *cxled)
+static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a35fc5552845..fe4b593331da 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,7 +30,7 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
-static int discover_region(struct device *dev, void *root)
+static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
@@ -49,7 +49,7 @@ static int discover_region(struct device *dev, void *root)
 	 * Region enumeration is opportunistic, if this add-event fails,
 	 * continue to the next endpoint decoder.
 	 */
-	rc = cxl_add_to_region(root, cxled);
+	rc = cxl_add_to_region(cxled);
 	if (rc)
 		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
 			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
@@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_port *root;
 	int rc;
 
 	rc = cxl_dvsec_rr_decode(cxlds, &info);
@@ -126,19 +125,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	/*
-	 * This can't fail in practice as CXL root exit unregisters all
-	 * descendant ports and that in turn synchronizes with cxl_port_probe()
-	 */
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-
-	root = &cxl_root->port;
-
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
 	 */
-	device_for_each_child(&port->dev, root, discover_region);
+	device_for_each_child(&port->dev, NULL, discover_region);
 
 	return 0;
 }
-- 
2.39.5

