Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880830F54D;
	Fri, 12 Sep 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688355; cv=fail; b=qWSeXo7z1EKSs6dGmXppIioI1KNILUzaEv5cwI10tM8R88mPuiGxnpjkC9RWSicNqrkfFw3hzMBunAHhs2Z+oDkL8pcrlB2XIYcGiz6pEcQhGtD9MKaZaJ/vuTvupv/8VytS+/POWYCvY+i43CBBdM57l7qvmOh54pG3Wdwf3Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688355; c=relaxed/simple;
	bh=UzRfvPe4/8jzSpRMg4PNreQVvSP3YAmHHnavCKI+k/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOpfQEeHAJ6GY6G+3g6B8r26KQR8ErazYUZ029BJNGyKGAwxrTJOlfWbp0XOLIJ7k+4q587fVHwL6MykJBxdWzvFXIAeH870tr4tESlvZd2dXNaczZrGSsib6Y1MhIHoTcC0zMzwrlDiCah/bjT1DluzHGSF5FcjRpBMT+TXc0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AqSnMFnm; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AqSnMFnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ6WvlJZY8DiBicw7KEnerf9LJiuIl/WsTIA38nWPNyj4sjqg0uuerCNUYoPAGcDkfnrAXzRn7NJTMS+X+DX0xV+usN9yKnllyrpd2Pbzcj5SKBhDNcjPHHcOR6ZRbP63+3qzEveKO8oYYVDnlRvEbSZn/a50dZC1AgF4O7kmZ1YKY7HVkdCo7NY3vlTss/CEeQlkzgrf3C39JtqHK9nGAizaS/AEPw3PddVTvQ8WCsAPRPsCDRHuzNdL+CmzJ9iPeKT67jLUT11t3dXGZwQNeHjp+9p+TdfaKgZEI8oN+tSLR/htnBuQSdmdzia6NF50O2SlTJ5IjiAs/ynKzSWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpyd2xBRmkdczl1hpokooZzVL4+xIlz58Am7jxbITks=;
 b=eoQ5s4ggOu15ZK/LYQ3IomfWHfhwJmh+BHgVKw0Um04SIze6Kwzuym/E7TL+cj+Y24aDNkVydKTTkZ520/HzUrcvq0m+mlQGZ65CqCTlKp/9DGT/w7o24vrPYG8BNvUlrU/eOhwTnh15wnif6hiRVtRxslA+SmJ5diXWCJMkcqEXDx+UvhqZdoA7nzeUYBYqVGriIDgd9itJTYPxdN12FR9fODRza4PLrzcS/uCRfcIczWnGZM4Nn0CHc7d7LtBDr+Zl98JJjOqrGe/Zt+0uOwbicf2PRwg3SdaFcU61eVVIeDiJTQJTQQ5gDfuzuLOnahov2E611qdX3uV9G8LF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpyd2xBRmkdczl1hpokooZzVL4+xIlz58Am7jxbITks=;
 b=AqSnMFnmv/AEdHWzynk82mcaRcC2YUv1zwiDXoINGer0Pu5PRwqQM35btCc0eZUx44VPFK89wi0Mv3XSSOXGILEKq7TQztEZhCJt0+B63YtiC5Lhc3Ycs2fN4xAdmW5+Uh22Bk+BgwYTfX4ILAagFsKa4qnCelJSmnX/6aeKdFo=
Received: from SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) by CY5PR12MB6408.namprd12.prod.outlook.com
 (2603:10b6:930:3b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 14:45:46 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::b5) by SN4PR0501CA0109.outlook.office365.com
 (2603:10b6:803:42::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 14:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:46 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:43 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 03/11] cxl/region: Rename misleading variable name @hpa to @range
Date: Fri, 12 Sep 2025 16:45:05 +0200
Message-ID: <20250912144514.526441-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db248ae-4176-4469-fbdf-08ddf20b0efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Odn4p3mzSs7pPGaEc/aVBhgyvfs91wKWfP7/kR0aRnW4Gk/qYdTcppv7JUBi?=
 =?us-ascii?Q?qtrSKZt2TVpbeGB8SmnQYrys/lKFstPm+IUQCnxC7CTmn1LPQ6IQbjtFtiVm?=
 =?us-ascii?Q?tSZvHtUDs0znDRCZlbMzrfue6yC9mmfJuHJG0e6md7o+scxhfDe94c8HLjjN?=
 =?us-ascii?Q?AlPS4w+6dJmyV9HmkrsPa9Gj4YibFXQFmk+mUwUBhQ5fzFFI4SFGGm8veuPj?=
 =?us-ascii?Q?56GDb2hHh4ZijB/L5o/mWeJzeFqJZZAxiN2NQkQfDkr3wU6+gSTXFQSI7TaB?=
 =?us-ascii?Q?OV0NTvs25cyqWa+nefLuGqf12QsNSi0BnqdRGL510xGwa2XczLjvjq7aKaX+?=
 =?us-ascii?Q?p44q7zfhFNYzY34KNfTfDd5xK0CKSctk6S9PefZVOftKoIjCtgA42Q80XFoO?=
 =?us-ascii?Q?INoP/aQRP6qnXtCAGNwz3FYEnADYhqsdxQY3gaKl7iwAjX1XeC+JY8JevoYk?=
 =?us-ascii?Q?AAOj2XiEmIGlgYWcu22ufJI1Sn8C1zXUW6RLQ0kcG/4k/lLlSuiEllxr59jj?=
 =?us-ascii?Q?6mNY/VB03RuWIIpCTeer2iiznXISMwl8BEAMO4USpC2kt2wIp42CBMBIkJs8?=
 =?us-ascii?Q?Ok3GuQOCRGuk3kWTo67bEFwwMnfBc+923FrHX6LwKVal9SJwcEQfkQTuP1Re?=
 =?us-ascii?Q?7ze4YimffZCooI3y/PxxebqnOrsPSzk6EhffZWdar0qhhzpSVrgxhtv/o+vg?=
 =?us-ascii?Q?UEO6A6MRv3WGctyooQqaMdwxOATdRQfQgADiiJaYAAiGN+YsPDQC6DBLSPsp?=
 =?us-ascii?Q?WJvtgY0c674dw2RtWvrLtjo95DPmjvCHS0TMsltxlcdbTyCCxwRqlScc7qgE?=
 =?us-ascii?Q?7OwE5+v+WoF0KGDy5HuvRE2oAGyMxWbq7V7NZqbh1sAHLYCxKRtE65A+B1sW?=
 =?us-ascii?Q?a9LtUUtbKbnw5AlEWyoANc+wl/mIIBP3OidNAdW/Hfm4xohbSI7jvysMrWNs?=
 =?us-ascii?Q?Zv2DekbbJLWpcMP+WrvmB3bEtw+BRdZJD2fQJu84YKNuzwXleltb2rGiEAiV?=
 =?us-ascii?Q?skl5gAZLO3/qQt5e87nn9EWONsV3KgT08iwXuFsYnxk9LY7bSHM1G7RRDBhs?=
 =?us-ascii?Q?xU//UE/4PImJzFT460oN/d0FX6pQ0vRO5/yVKjtL/+x00jQto+jTayQ50MYe?=
 =?us-ascii?Q?qygPCSVz2EKewa2+PuMgPc8BuGLkJIIY6APU5n8U4Wv6d3MiRFb2nIGxmdmT?=
 =?us-ascii?Q?38lkGorK11Ae97Fr6P+utVceMCi9CgM9M5Qbw0WNIdWSl61MztWprbTRCazT?=
 =?us-ascii?Q?GLWvKks5iq7dawxswjNPkRDCyxLsBHrCJfVAKZvJrp8l9wqoF8wZRl1O7Rsj?=
 =?us-ascii?Q?Zk2RNV+3/tFiBPm82qo87sJ21m4pM6w0j4GLVPh0ExVaOPSZUcCtfVnbWW6Z?=
 =?us-ascii?Q?+cHrRBNyigzCbUo7ooV8R8fqsz2cS+ONHWvAN3MBTj16hSQ9k3AE2jci/CU1?=
 =?us-ascii?Q?WlwmbhT5+I0rcWp2v1h6JivndRh8Zgm0rlglAptBziSBqccNDbA9Lkj7Ozyu?=
 =?us-ascii?Q?SgL8RIBV2DXN78EEOAdcsvMZjfXEAvTK4pJ1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:46.6030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db248ae-4176-4469-fbdf-08ddf20b0efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

@hpa is actually a @range, rename variables accordingly.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 777d04870180..13113920aba7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3367,9 +3367,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3382,14 +3382,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range *range = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_switch_decoder(&cxl_root->port, range);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+			range->start, range->end);
 		return NULL;
 	}
 
@@ -3458,7 +3458,7 @@ static int __construct_region(struct cxl_region *cxlr,
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3474,13 +3474,13 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
-	cxlr->hpa_range = *hpa;
+	cxlr->hpa_range = *range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(range->start, range_len(range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3559,11 +3559,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 }
 
 static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *range)
 {
 	struct device *region_dev;
 
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, range,
 				       match_region_by_range);
 	if (!region_dev)
 		return NULL;
@@ -3573,7 +3573,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3584,12 +3584,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that if multiple threads race to construct_region()
+	 * for the HPA range one does the construction and the others
+	 * add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.39.5

