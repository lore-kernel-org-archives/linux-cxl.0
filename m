Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9D30146C;
	Tue,  9 Dec 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303709; cv=fail; b=VXOkFtfggr7fkkLT2s/HGaGi27HngdmnQmsbsHrOn24MrHPyFcTJPtXFvViFMO8q5Iei1QfLSxVrGCshxpIYxBMUC4k0kIWN+45nQ8afWmjue2dfPTLLgP3Px1hYj8t1NuvuglypRV7CVGaoSvx9N88B/th/Q8AzKW/YjuqvjbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303709; c=relaxed/simple;
	bh=nWa4cPJg44LT9EegJIrg1gnmyXHhnmPExCUL8U2pEb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/mqIz+zKM3aiKV/X7T4IVDzoDIyXKXgO6gaKvrgcryQO8x8s9LZpGBcgHIGKGWigv0af4OZb61dIoYb6B1LFT2qXvIIkW/SqbIrG1brXFathCh/cgKZAtQRnpznzCzjtJWVRrY+c2uCxa26WNaBrVNOyzJhPIfs6zPdVJ0NEsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qR7BBAqH; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qR7BBAqH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E63UrbG+mAKwBzcSq/RySGfek4VhEkSz9mfN3HJbj86qkLlYEIgm9wDxJE0H11Xd9x0Ka6vcyaaoZdWWyyFDGF1UC2hKNm3wJJf3c2QKaaTzuZMeCe30OcDnH732Iq+3EgkYC29+HSpDLMWmgJ8do7drVHL19sxr8ooRq3v91+2NWIK99hk1c7DXMzvw9QxWgkHVOGHHPxqLdSqKO61Qyz3A1/gP0toiFu71EKd+vdZcC7Zzw8FR8OcXhMF9fxavXMKmp8tSD//7PWRElxOjhH2S7r9bzIjqSX1mbOxIQaBCBr+3c2vgPedaKYo96uJo46y5OitqTs1sM+BBvm/s9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKtUzt1epFhSs5z1jrLJTf0C41sNORRTXX65bg6qfrk=;
 b=ScNZM6N3gOi7AXH97rvnj9Fcpjgp77k8CHaY/j0YBPrMacl8peSUHEm6oDH2RkJi4DgJubDhZ5x0gPC6g9Dk8+tk/jhBlq5ueF/KW5ckc1XH/Bgc7titjwWRVuriHXdmfnvzwNL/gnHD95R8nOPDBMNRH5VfvHNo2nXhhhT14Ix2NpgG8v2LJu/5dWjtI42vLJoMflpMG6byhMWxP1NB+9Z/aUtJPXNeTLVD1+f47ifMbNN9QSwQV7d6dGG4WOo9HOhNEvacWf7nM3YM17izdBDBwzCBsHVlJqsd2K/5TS22qtY21hE5nYtq8ss1IPogHQOQ77/WdIXpUFuW11Re+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKtUzt1epFhSs5z1jrLJTf0C41sNORRTXX65bg6qfrk=;
 b=qR7BBAqHTPSJFRBvhFQlM8MUYYFJo38EfDvdYe7+Z4zHu8TELtR3f5hNwvrACN90haeu5VE+sWYyL18yP0i4KUCzSmxtPVGbEApmhCT70Z6XkiXyJ+AcqGM7Jj0ihZrh07hV1r9ELzuL5bw1ecxtyUWZQZu8ihSGqg++im8Y9y4=
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:08:17 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d3) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:16 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:13 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 05/13] cxl/region: Separate region parameter setup and region construction
Date: Tue, 9 Dec 2025 19:06:41 +0100
Message-ID: <20251209180659.208842-6-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e57a2f-69e6-45db-f517-08de374ded81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZU0F6onnGDGvFGQEvDf7iZRjiAcMy9poGpObLZ0fs6uERCVvc0XrZWyoKu9?=
 =?us-ascii?Q?D8LVR/bZlWUOJJG1eBBYW6jPBlUbR8V8F6YqQXM7OOm/IEm4AtZO8PaQb031?=
 =?us-ascii?Q?TJHQozstpgyT9XHF5quKhHNI4zw5bBn6iZ/fcnRkaGVg1+tsE6tJIjP1lSPv?=
 =?us-ascii?Q?CUlnor3sa34XOPO0b8gmfXjIy+tEciHAfGguaItbY030zeB2sH6KdqrxaOjF?=
 =?us-ascii?Q?1bEehJFamX50+mnYsLdds0WfrcWr9/nCe9e7roG8OWAyZr3aqaXBs4fd93L2?=
 =?us-ascii?Q?M/kOtXcvV/X1drcY41mVrE2hN1PL1dLnmu0wMswO+uXFnJzXna+2Fk0dfzb5?=
 =?us-ascii?Q?096VOOo8bjHlqU8fUQ8xNqv68fHIHfbbbQPBLflrYSwwpFU0BsprIbhRncfO?=
 =?us-ascii?Q?6WHGp0T+RR2ay4vhefhGprNQ3nBvqL69/l9bkYkmPQHegEmjlIZrir6Th1P9?=
 =?us-ascii?Q?etooxGG1h/IOL8G6diXm1mJI3vzrxUqEeRpF+VWn7WR7yR97kPkwJVJeL6O+?=
 =?us-ascii?Q?UTa9bVXz7IAFMxW0OayzFIAzQ57FBOLmUIeJSEpijdwuoE03kKVIclB20HVY?=
 =?us-ascii?Q?YY+2ehf/Ezlps57BZmAyAYKdj1tSh/pgoIxGGAlMdWw6EIjtJs0rW4wHGimm?=
 =?us-ascii?Q?TfFehRrEJFPjbiBIQfnwrSWYVrXn8AgjYUnNF/+w+2gc/zyuqjTTGaRD9ct3?=
 =?us-ascii?Q?cJgEXYNXChJpteLZE5scoPZSWiV3rNsc6T9QyYZgtxIpXrUQSsSfOF912//w?=
 =?us-ascii?Q?uMJvbZC8CFHjglxFkvD4AvlBDlK1ph1OxG7PNGrOiXe18xxHMWlvhYTLi+uv?=
 =?us-ascii?Q?Q7R5YuwrPZg0KRM+EGQf8DWJmDnAFW5q9uaX797zsVStKe6kPpPK62TR9zg9?=
 =?us-ascii?Q?l1gfowoiM86C01CZ2sSnbqp0jIS6bp7vbi3cTi4F8/uhi61uvbKkjMia3FAl?=
 =?us-ascii?Q?qmTMCtGzNXR/rDN+lDneL+HzFXe2D6/mM0xYqEYqpzjUh8jDNFaigw7piIBQ?=
 =?us-ascii?Q?W0Rm8JSLX3Ng6oEoWSrvWnP/WOzQp61ePh92qJ6UumPvFGSdM3n6yCQHXf/P?=
 =?us-ascii?Q?CeY7UhOug6HXxPJ+FTSWFLlDOx4OdmuiQPy2BYUmRRu6OSbT58kdFVOALz4H?=
 =?us-ascii?Q?2a8P8MmOVJrJpIpOeR2r02wGBVCBTyDC1SeUaWotL8AsvOZLugyvzSeOEndH?=
 =?us-ascii?Q?GIFyCwPAfxYsI05XXHPElCa1rOJsY1Ve0nRQCkKCdMWHiZM7TsLSUfxZKiMJ?=
 =?us-ascii?Q?2uBMf4CbU7lZwNTj0s3jb7wX5UKickyDIsyIWcuqE53imcb3LIhGKWVEDgqL?=
 =?us-ascii?Q?NZJsBhSiyYUe0hN+oOe+3Wc1yRoaZQ0WzVSuvTiAKPltqC1q6hAbBCclIvjX?=
 =?us-ascii?Q?lsRNa3BYkS1lcDHBcHC/706Bf0WJfTXNZZXM0R2SiH9H01EBEOt3rpm/F8pu?=
 =?us-ascii?Q?R6Ek2I/wTRq0ac++GfX8pEl4h0QMCJJ+k6z/ihNQSpknihB8w4K5o25yK3Ig?=
 =?us-ascii?Q?3vBYLAE3fwqFH3o5bmDL24fmurwumVaqvZCxBa2PoNnVO2V5Yhj6GoVtIKed?=
 =?us-ascii?Q?K7GTexmGUaut0vs29O8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:16.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e57a2f-69e6-45db-f517-08de374ded81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

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
index 57cf3ab28f43..dfb21e8b8fb5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3562,11 +3562,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
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
@@ -3619,8 +3620,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3640,8 +3641,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3661,7 +3663,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3686,11 +3688,18 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
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
@@ -3703,9 +3712,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

