Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40A325719;
	Sat, 10 Jan 2026 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045672; cv=fail; b=upgPi6X1KelpTVux8fYzKPcj1HoP+EoEKKdzSP6e1rAZlJhhZxHJRZc5fVVHRZ+DEfXChkJyM8LczBttz7DKDI2HsAVkEBRKtek6ZTHU1psK+t2DP5NvHKtLSqZ+H+tI3+uzgr0ciH5Jy5TMAn4g2p7IoIn+M/cbNqphOhNT6KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045672; c=relaxed/simple;
	bh=WSbH2s9PaDomQZYuGg0sG1E7ksIZMUsa6WgnHbwvoCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpsD1vmviPtlWkA+vZXyUtxtaueJzuf99a71x6Ybz53pYAUOgiJXIXzV7Qksf2+2jBmS88kDnQmySfRDbNOLHgb/3LARTyLs6FQcjEW7x7OLg6C17wdO0aHBKDQ2PWwpkl6RiGRFDhU2BN5Ccxe53BDOGCKtXgsboS2F7GePr60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iktTxsPt; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iktTxsPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+Q4CBXR6cm5zo3CiHGCWzN2PRmtvxHVnFW5hGjilUzz3pzUD3oJ1h3RP1PkMtnlFU8lJjxM++sKXwR0pkkUWGlPgIXVBW3ddSOS5jqFF+4xxDIjO48y64KjPyAbpbUqPht7L0K9xfEBDS9QRyHKkjmwFEiacX1zDADcE/viUP0d5iYko6kExEpHgXxdai13+e+5iI6uI2LiSPazEzVpQGvV1POsDcPOglk05SOAiIdJR75JK9r4id80R2Xy/edFBev0AzY+Nz2CRDzTJD8ZTRduwMRAHHVkA06XGiFp/Tq1Jyf/CkY2c9/fQPWKpMVpkR5X1UpyFeHpUxGbJhwuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7xuUajMDYVJSVKG4pfP3zjDyTBmde8Weshptk5gOjU=;
 b=QIrrGcKmOk2+S6jdLcOz9jPiDgXVBvvxHUSsRxhhW1EB8C1f9J76oY2O268YJ5A/qHiESi/wUBoXi3G/ovJ2zpqpDctogwQiZed4zF8QmOLiL7ry7kXhWQu1n0Qqi7zoO73NBrxsWTt1Rjh9p8zpXthTwebjkZ07XV5qBRnkEMR5XEZhF6PRwd5pYX+rD9VyXpI7i5JVyjzNfxz2mOsZ140VblELPq1RewbnNZ2+SuiqPh3EdIXIKzmnJ5jQ3kV28RuqzwUhoKxTQGPaTt+JE/dJbWYH0sT+uvi37RUmwXzGylaf+sOrPhdHC5nO5fhVoTghNu3OnErM2nPi6ulsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7xuUajMDYVJSVKG4pfP3zjDyTBmde8Weshptk5gOjU=;
 b=iktTxsPt3pk+Xd5miK3EDWaUbOnv97LDjYjkpPFrAnl1n78JJKgkjj2n0SM2VEYjxExZBqQlJkAqF0FJaaYPI5xJ8eBu2Z1xIWO+f/OrWO83TtKEK8aCeHZDbJB+EbT/yV4qItsUxC/MpRNl4FgKL+VpQBg8s+dmUlYUgSooTxg=
Received: from SA0PR11CA0174.namprd11.prod.outlook.com (2603:10b6:806:1bb::29)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:47:45 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::46) by SA0PR11CA0174.outlook.office365.com
 (2603:10b6:806:1bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:44 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:40 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 05/13] cxl/region: Separate region parameter setup and region construction
Date: Sat, 10 Jan 2026 12:46:50 +0100
Message-ID: <20260110114705.681676-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6effea68-fb87-47bd-a2ba-08de503e11c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?977KcBMunvQtu3dSt+SJ0bQCyp5rn1mnSzN49iY3CAqdUuQlk0eDTRXq3KrX?=
 =?us-ascii?Q?cV7gcJ5fqML4ZsXezZBIs/nwb1rGxzORKNxKflQcMChEls98GVrcY9DPeGOv?=
 =?us-ascii?Q?ooW0rRjYeCPqysrZjqrICYXTmEnhU+c5x1+suyh7opXEYzqAkgZI9rcqYASm?=
 =?us-ascii?Q?O/4KwyyxIgX15YKDwnD3cptLK4jVGCrq3fJH5oRaOCLXgXwmpr5CMT1+qBF+?=
 =?us-ascii?Q?tU2f549dHJ1Pt7I9P/Mm3cSMNqpI7rYUVrLEo+m8d7m59UXz1gUK96VQpEF8?=
 =?us-ascii?Q?MWvCQgNeFMOv8S9/+mrOxjD2kdczgrIB/M+jwF1xLY2xjJjLRN5hIWP/xEhW?=
 =?us-ascii?Q?EElZSifdnnqKRlpZN42vcekZ3CVZhbJI1FOF+KWWRoKiSGCDrGUgGdPpr683?=
 =?us-ascii?Q?i4gDuivfwvNvKVzSLPDTAjMcOBWVYrXTyLPU/lWAoJfZrJRq3Nc+bTDL6iyP?=
 =?us-ascii?Q?nkSO+kA6GJmjBCi/dqoPWp3Xja0WGoiOh3yV5/A6cPvzcBXfjw6sLNoIFgqS?=
 =?us-ascii?Q?CNUvY5a+BGtLxYmRi/+IIZinLMAqVX2v6ekj1A578vLIn7BadddtgH5Jvc3h?=
 =?us-ascii?Q?1OS3/Sd7OmYp7/INOB/SOlKJKaQd6VKuOwIIMLGmEqYiI1NdCuaNXa6F7OjU?=
 =?us-ascii?Q?CydLT0ze9eLWwPFWCyp23l39pCtDHkYaN3bOdHsllDJZffEHVc/8c718628T?=
 =?us-ascii?Q?ico0uwjbbUO+g/xElqjTRMrv/FkCN/rZYGbug1UEioEkkJpOYgDm9cCYA9Zn?=
 =?us-ascii?Q?1j+oOcRx9RQyBWCiz3+fWH5r5PpCgwheC6BEJMJWmNKKS/+C6+Oc6iXPYiQi?=
 =?us-ascii?Q?9VUnPNGwwwtOMRHp6HnfGr5VGsjOSmD3E9107jg1VtnSmUTea7mcBXhZi3tS?=
 =?us-ascii?Q?0myA+crYO3tfVlxpPaa3uTbG+Bh6bGuEhjwEdWk9lOtYJ5kVSLZhbhXk9eDk?=
 =?us-ascii?Q?a73RGoOSsHIol3vMmlHvT9K1QwQFql1YU4V1uG5jCNXzuwyFhvxpJnOPXsyx?=
 =?us-ascii?Q?pRMNfAsJAACNi5w5Cugjf7XOm4JFisnX3qL8//ijYbpuJLn6VODv6HK68F8W?=
 =?us-ascii?Q?gzeyiyAQ2Taoprr5OskM4KSsEQWoTUGg+9DV80wkS2ca/4OOXAa7MAdTEsGc?=
 =?us-ascii?Q?613Ehb67C2827CG5UXFZvq6g4ahmVkbKMOCMOHEa6PvKc/7HVhDRK2x+Tc+1?=
 =?us-ascii?Q?DlbdiEmPAeWp4yKDo308PTzSAb1yp/6Ed/lksXCXytXRi5aSMKi8yqgOOA6D?=
 =?us-ascii?Q?0tAYIKGE7jl/SDnV1aubzy50TgokdUzsKh1drz6vic4+i05+ShwXlPr/WZMg?=
 =?us-ascii?Q?QHfk3wC/MLrs8z4J+v4yOA4YtGlxUlFCS7KCc2zfvACeBh+8UT63KRiIJDd5?=
 =?us-ascii?Q?x8gZ45tncJPtyncN07EIIVkuta2F5UJl07kSiS5+LLCL1n0PZqIFONN7c9A+?=
 =?us-ascii?Q?6CwquSapI1vA87TqrEUFSdq8M1Om+t5apTsWCuo7J51U2HgzZI17OKv4F/8t?=
 =?us-ascii?Q?dwLc8jN2meuKOob2PzE5Ak1J/PoNnDmuJevLBylMNuj2yMYuYxjMbQvC0lLq?=
 =?us-ascii?Q?aDKooPviz2N6PZSW5m0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:44.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6effea68-fb87-47bd-a2ba-08de503e11c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465

To construct a region, the region parameters such as address range and
interleaving config need to be determined. This is done while
constructing the region by inspecting the endpoint decoder
configuration. The endpoint decoder is passed as a function argument.

With address translation the endpoint decoder data is no longer
sufficient to extract the region parameters as some of the information
is obtained using other methods such as using firmware calls.

In a first step, separate code to determine the region parameters from
the region construction. Temporarily store all the data to create the
region in the new struct cxl_region_context. Once the region data is
determined and struct cxl_region_context is filled, construct the
region.

Patch is a prerequisite to implement address translation. The code
separation helps to later extend it to determine region parameters
using other methods as needed, esp. to support address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/core.h   |  8 ++++++++
 drivers/cxl/core/region.c | 27 ++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..ae9e1bb51562 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -19,6 +19,14 @@ enum cxl_detach_mode {
 };
 
 #ifdef CONFIG_CXL_REGION
+
+struct cxl_region_context {
+	struct cxl_endpoint_decoder *cxled;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+};
+
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
 extern struct device_attribute dev_attr_delete_region;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 04c3ff66ec81..5ae77e9feb4d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3565,11 +3565,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_endpoint_decoder *cxled)
+			      struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa_range = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &ctx->hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3622,8 +3623,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3643,8 +3644,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3664,7 +3666,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3689,11 +3691,18 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa_range = &cxled->cxld.hpa_range;
+	struct cxl_region_context ctx;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
 
+	ctx = (struct cxl_region_context) {
+		.cxled = cxled,
+		.hpa_range = cxled->cxld.hpa_range,
+		.interleave_ways = cxled->cxld.interleave_ways,
+		.interleave_granularity = cxled->cxld.interleave_granularity,
+	};
+
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
 		cxl_find_root_decoder(cxled);
 	if (!cxlrd)
@@ -3706,9 +3715,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa_range);
+		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
 	if (!cxlr)
-		cxlr = construct_region(cxlrd, cxled);
+		cxlr = construct_region(cxlrd, &ctx);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
-- 
2.47.3

