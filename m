Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937925A320;
	Fri, 14 Nov 2025 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080862; cv=fail; b=UgP3EID1Pr8AAP9QOk/2wi/hW5cyMbtZdLm8D4iYycZBoj6Hauz0ydmePFBHoVkA2zYbPkJmg8ZhF3H8PWMvo+Z0HagfAStv9h38mZ2c64lqaNlSkbSggwOWeC0HSnD1k11JJw7PllwWsHyJC2kV3yvGF2tyeXjlDyjsYSUE31U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080862; c=relaxed/simple;
	bh=JLS8R12RZ5/HQZ4HENy0nQbnkZZ+1UT5vPEOczjcX5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3fzic/hKkailShB672N75WZ0+c+7MTEaqOKZ4Hir5NMshqpEUYk4fNE3qvwKP2IQI/L5qklASt3FBsM1wNGBzGIGwDfAba7/VIoOWG2EmOiJyZQe/yNTjO1ExXXL8Ce5nQx1I9Lvxf1rdI8vbgFCJXhJrRPpRPwA69Ooiw7mgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IolQyLh/; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IolQyLh/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fceg0fKyq622jAuXlA7qNTjh4CWQNyMqA3xB8cenDqBeD8FZ7hHUt/ULo2QeJSI8tdNnbZPqyfG2V2oCDgVbfAHkuSuPftlnrCRzpzH3uJyPr4Pzgky5JjfAszkapCajYxX4eFD6ULVbQXbWClkOgRpOJ65N181lNB/0NNn+igJRs9SiytLkuiKebdFKfrRrlELF3758cMtFnrJ96ZccpNwEjm+r5MoTbuQzcAmvK7aIzkA7BaZM4T8o+WxPUNPpYEhF0/RVgMqHr06Pe84Yz/OYgj5wFTdyZMf+xMUR6H9QUew2kyjuUi8ho6donICiB2vBHaOogdgwhxq5kw+HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgol9ma4L0ejYAP2rul9IaSjIxNyP2viFpL+ErVHRpc=;
 b=Jrs14/CfNeGOkkTdtMqaCJS/5N5Nd3Q0DN9FofM0UzPeOeoAV2IuSaUb0CYezKMKcX8OZOMz52YADn7TxUOl+3WhyrNISiecVsGPMySV979BGk3Fl9bHtYRkimV8neHxAJ+cN0JRpmubicoOPVJhr40P8CX38ozi68IPpMjIN7s3kYBw23VIKen7D2wOGyGoFVwfXtCg9ceJivmj25QqPJHqHEyTkhw0MQvBaZtmYyLFvNQXOu7mvapNBsVMQVPpJtGFwWIwdGTgyatHUC6inZlPHGHal1cGByKGrFGEcOjq0PmxcmxacSxUWjRjKbGloV4PFbn7f3kJ1wGkZsIM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgol9ma4L0ejYAP2rul9IaSjIxNyP2viFpL+ErVHRpc=;
 b=IolQyLh/GX9fS0gjVIimtmm5G9vTt+EgciwASylZzNpu9Of8IVxMC+VYSExVz2Zq4sfz59BAPpYuL31ojzb/QOZ2RQcMZhiMMYhQpXtuLeWT12BEZRHhngHOWbzoODZQPifOTctwas3H9gWu+jBuxNwsqKLtJST2Z5lhNEAang4=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:40:56 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::6c) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 00:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:40:55 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:40:49 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 01/11] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Fri, 14 Nov 2025 01:40:06 +0100
Message-ID: <20251114004021.1310661-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cf1470-8ead-4182-db14-08de231678b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OwEU/K80oMqUP1hkVVpSwS+AsNUNvA7V3/7vG0Mt3D86kIQEhtF711ucQAMO?=
 =?us-ascii?Q?IIJf+mYxzm9QhIgYiTeF7opI1j4kU/8ROSvvyCkZ5Bgf8yQDOPVBtAr2SRUU?=
 =?us-ascii?Q?+BUUq80Tbm1IWar71umZWyemrF+RRPYhDQCyg7lfzpoKZMcBPIOHXB7Dm2dV?=
 =?us-ascii?Q?loO1A3gKYf1zGRxzaxzItakvBWtSik1qq9S04dWJE9hGz6wAbwpiwjWFAVPe?=
 =?us-ascii?Q?8q1LNXLp1UVdtY4WJXSkGsXHw/INuauTxZGFVZd1nWZTu2wcCuzlE4Rnx7jV?=
 =?us-ascii?Q?UfhiYpm6Z50BBQSxJnLxGDd9hwOXGJ2HLLydICuSiCYtKryzEl/jVsRdc+6c?=
 =?us-ascii?Q?Ik7zyhF+kXi/ZQ3qhQujJM/PnJTh46hc1DkXv0S+JiUbRHtdw2GSmRIF4Nzt?=
 =?us-ascii?Q?B/2T3Zfrjwl5KmwGmAEvlZILVDWf9X1imwoNzDCM9sApATb2Ll5DuhxhJM9b?=
 =?us-ascii?Q?5xDMJrqlC4fySFypHFw32nyVogmsVjmH00RyCiOpE35IuwiOKK6CeOLPKbaF?=
 =?us-ascii?Q?yE2FqVNxqtlXnm1peLIqXTV39MgwA5cjyLh6PbH01zzXN3AIpN4q6PCpJ8xk?=
 =?us-ascii?Q?o6ZwEl+JSDjXf42RZp1FzKRUnvB0M1Jjwf9Ik47NaA1cruOaC7AHDa0Dg1og?=
 =?us-ascii?Q?fz1wL8mESy89b6tJxx/GY17MCDwLLI0qOgQGCXxfde5EJ+VFdB21OpFalk+7?=
 =?us-ascii?Q?wQsLEZFMH0qTB2FrtYbL/55cZDSesNheMZQWhzQrg9rh27temhDjiHV4GiPS?=
 =?us-ascii?Q?eDXJz8JTr5hxm/XKajILWiqtIVy/2CAzcH8O+gFYbup2LiYz4TkVRQrwCSOo?=
 =?us-ascii?Q?8N2rdMwvVMefIRk0qjVqLuZDRSKwTmTBhsn9oUjQ6ZkD83LzWp0VVdD6hOJm?=
 =?us-ascii?Q?8ls6W1U4HXT612ML1GKquJhOz7cogizswN2E/JyC9CQwanyshsraEcny6Dsz?=
 =?us-ascii?Q?x8Cq5sE5BfMoxH1uGpHF27o0GFjWv3FWO8rJWBXZKCwYKKDsvW0RV/cufsn7?=
 =?us-ascii?Q?ZU5j7CAIBzsHwb0zjKV0D9iOp0yrXuIOSKJlpB6vwkcM+lpB2d+/fTQdk8yJ?=
 =?us-ascii?Q?bbHZ+zjLJRAUJz1CjfHBcHy5Yrm3QVZZ+xoHNKhaUQj46k9ZN64KPVbR0mdn?=
 =?us-ascii?Q?PtgWPhlk8r2Q1A1aAyCTqhyjD9s4iIN/Ak65WG/00LC5ot7P18UDlgGiS96X?=
 =?us-ascii?Q?0rRQQrlprnApSGUQ8sQ5IfgMfnev5yU5vXiFK3Mvra/S1s9JmAWGVuSHB9co?=
 =?us-ascii?Q?qHlLBmJCrzxlHqOs7tKPnjjhB5krL1sajSNGwWbo9sIV6OdnEmW1RlKw6pAR?=
 =?us-ascii?Q?CyTyFjhEr6sC7OyPZYgP6+X9p1Ho5fiJuw/uR8OvBDME6DuaGL48+LXh6i6Q?=
 =?us-ascii?Q?1pRuJyEfs5otU7u0mIOuphZ6lPQXvy7KMiBd7qrZ7F31Jj98YbB1i98uUJ7r?=
 =?us-ascii?Q?XWUzTTNxonrHTGjaEflPouVqSkuajVDP2KKRJdgS7CW6u6jyXUvEzxTsVr48?=
 =?us-ascii?Q?yVkbLPT1Hz+QA9PDFExOX7HSykp/eVBKVt7eb3OB0F2t2Mt+/379kp193o27?=
 =?us-ascii?Q?WtZCPYLiRbIN5c/e5zM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:40:55.3157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf1470-8ead-4182-db14-08de231678b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622

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

