Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676C313E3B;
	Fri, 12 Sep 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688362; cv=fail; b=HHWYKCN3LrlUD9OO9YfQZ0wOCu9iSJBaJ4Ov2BFoMHVPsd+7dM/ymC/Ee7FnsGwk9km9wJKd5AJpTko9f0SAFxak/ToXziE+VQ/TWvZfKdPhviFLMWatgzLXbKaK1gcRYQgHiaG3H2BVQUAdNMEIKj69euo7sTH8nMlpPZwbxPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688362; c=relaxed/simple;
	bh=mMtWrkrxUDaX+RY0i9yJgzdECSAJeH8XBuOV9g/t/tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxVyyGJndj67y9zseChIRJyuTtEWnxze0BctQVOIsuaKFDZfhqWTrABAtRJXu2nw65bnpGTH/u6vuHCwv3EDEB65hoeBQiaLtepOZR/3f6sPMCDCFxHvpvvt1lqGshj2cd6VW2O8rg/CzhFtdERQOfXq+kFKfBjXTFnpz1h/6H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Hpm8GvJ; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Hpm8GvJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuq+f6kLwREgIdqR/KLzEKQEvqTy0zeW7IDAx8s8S6zDaUZaLKtYIazqn9zUPWqC6i0F3h/Fm2zmZCOxrBDArbWCY+PcZ5YD2rv19O+5QAo9qH8TS6ptIobGhup6FPeOuGC+e9oZDS+vRFSfn0F98Z7RD3hKzVMO6HnbvlEHyHm6BGeBfYtBvvquieMwey1D8VDFIaqsaPSbJfQk6ie0ifhEXK3dsEN5DUHDgIM66U4byLvWPO2dXnOj5WD/V+hb0jzd2RXy78/daM1LJzBmZe73wfU6wQNSc4ROZ9/1VwcZNX3GkjyOqU/0U2imjMqwVr6Tqf/UkTqeKNZNu/OMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABkQ8DbGDufvSX9J3i2I4Yt8xme1Fb9h+SiWjFsovt4=;
 b=necv9woM+e+xcRwvyur+tLVUg1ph5eEpMHz5/r5QZO9JNfD5oVRIBkaIn+AOmPJ02dh7RPCR/QoAasm7UEanNV5s5WPLG9c25LHTtThmRQ4SDnOuzox3xieRRaL+VJUsb62NTEBzEOT3k/14Hz0v2xz0/FtjxGukx3aTjHGlIQMvT5PD/PGS0amkgQbcaeSVjsKAXonC8XjBIeyMjwlBrk1z+KmwUrBfcP8qdhAk/2OUiF0D7fyYk2cjMaCMfGXKnIwGFqBYKndp9pSyz8un/5MukdNAdqx1Fx1jLCbdIzMRJuXRmZdNQvNNEo6wBTfFPjilYVT+AJlFJe0zizz85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABkQ8DbGDufvSX9J3i2I4Yt8xme1Fb9h+SiWjFsovt4=;
 b=5Hpm8GvJU7J3O9YeocJSOZiHUnvMotS3giG2H2Mc30CuFmHwfRRdGuPqpJ5NXf4ttC1hBJ82NtMJ6capsK7wMFcEk+EhqWIJpj/qacQGmkX9AvP4pvSqSGLFDADK8r/+HDZ3b6avYwb9FIyeojNmwEbfhu14WVa2CyC76Swb13A=
Received: from SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::6) by
 DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 14:45:57 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::d3) by SA9P221CA0001.outlook.office365.com
 (2603:10b6:806:25::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 14:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:57 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:54 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 06/11] cxl/region: Separate region parameter setup and region construction
Date: Fri, 12 Sep 2025 16:45:08 +0200
Message-ID: <20250912144514.526441-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 26db415a-60a1-4d43-0a5e-08ddf20b158a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgWVuBnKyOCUQD3q4wIVJM82pCM6/I6Xp4YGHZ63YhwueYAU+TVTRoTAu4bs?=
 =?us-ascii?Q?Bz/0RGtiDsEupAnb1bMz3acnZv7K0Sxkij+/z/3LUfxWi9ClXquf0iy9kkas?=
 =?us-ascii?Q?Aiv89gBmKxJsSuo1VyQOpbWW67Ql9y269g5bwP4OKBOzwzXb4aUlRPqn6gyF?=
 =?us-ascii?Q?YdMMMaCx9izNnbK2+2xUDs/HN+R5xOqeL/rA6B3Ry+s0Z+pZxjc8Savv31om?=
 =?us-ascii?Q?yPGFUfNR8ntPk4mZY1hcP0WbvSrjnh/22mBfcsA66/aA74+DsXpGGRFUBIwT?=
 =?us-ascii?Q?XIUD9PoCdw51i0HMeIEWDM6VlP+olywAhoA/0tVVH/QLbKX8VUhqkYEPs93e?=
 =?us-ascii?Q?ekGlgkOK4lwvGEKy0EpfmdA41FUzZhA+UY8xSBpC1trena07xmy90lCZVigJ?=
 =?us-ascii?Q?V35vbKNH07S5NITpR+g+lG9haJIDMx3kFBy+YZlGKeLschqjwj8mjm9IwP64?=
 =?us-ascii?Q?MmwwBKDF8hh4SPm0ZoMS5TBU1hNOEY2c+tdhCEXl3DCjiqKsWbCK5h/z4+RH?=
 =?us-ascii?Q?1+VQVUdA4753fnQlOluMaz03juqKWuNgYnvRQKhSXJvVJta8lKPpXFMgdaEg?=
 =?us-ascii?Q?DczknluwjoyZRpfmrQt/GVH4TeKeyBjCykQf04BHwyWIS4fc5BjUl1W8aonG?=
 =?us-ascii?Q?4Zohn8k/NIJixIRkxNA5nHFYPyW08aCtVueiOUJD6PlbDfCyxtZnUcbHPxzb?=
 =?us-ascii?Q?J0+YUJaM35GRpYeU2+Y2CdOpSqcXfpnrb9lT8oIt8NEYmZ6bL3AfMcUxOQhd?=
 =?us-ascii?Q?HRkiMbORnshw32X76COhVRYbdYnkPTYIw9h0uO2ci3xMYdM0Af1lbHfnH1HE?=
 =?us-ascii?Q?TS7IzojVQpSJ71cx0cqvOjQsqRG4UL+lIb9sQlAD42rG++v4/V+P9HvPedBA?=
 =?us-ascii?Q?/f7waoYOYbIeg2bGVoKAOu8ZwWKFrERQYvYCZ++2HQr5GZOSi3Jiin6o0k8u?=
 =?us-ascii?Q?VkZGlOrZQC0VtisI49YR+lG6cBR/9FXk58/EICD6ZratYxpiuQl0KGhkPLbI?=
 =?us-ascii?Q?FiHD4UkLmcJjIQfz2xJt9HvmuREEeQFLKjEBpDpvBBTP2pz95ikxFuoDpy60?=
 =?us-ascii?Q?YobwP0grBSvS9SacveyebCLokjBvL3GFG1J6rHSHcgy/e0bpt6lx1D/rH3mr?=
 =?us-ascii?Q?2uIa8GOFXF34ly/ZIekXiN1C9mVZ7CHfiXYhiyCuh0bcbuKRu7pEIag9DGkw?=
 =?us-ascii?Q?8YlwCNFUOUDvyO6YVqF5idgvPcW4jI2I2CRNCvYmCDKmLQKcwgIFXDR+YFnx?=
 =?us-ascii?Q?heF6aEEDQMsSKQ7RRpVfTa0YKdMXsIFu3jAgIt61UnqNEHTefxdxypqrOVtG?=
 =?us-ascii?Q?r3zXKRqLeMyY2qsVPdfkzuPhjJKRuIF7uEI2Z4kV1RdFWB3kgwGVyE+Y0XmS?=
 =?us-ascii?Q?6+HxFBdiWrxTQP4/3MW3THkym8znDBu8YBm1oF3AloToMpp9L1m5v/Scp4sF?=
 =?us-ascii?Q?kF3ob5g/fifv67uv7SqM/euIVpOvM/UeorJQEspEQ3RG6KTHq16nFYwzcxa1?=
 =?us-ascii?Q?hxzaaJxRsBnAjCFihC0f8sj3LVhLI461rb8K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:57.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db415a-60a1-4d43-0a5e-08ddf20b158a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

To construct a region, the region parameters such as address range and
interleaving config need to be determined. This is done while
constructing the region by inspecting the endpoint decoder
configuration. The endpoint decoder is passed as a function argument.

With address translation the endpoint decoder data is no longer
sufficient to extract the region parameters as some of the information
is obtained using other methods such as using firmware calls.

In a first step, separate code to determine and setup the region
parameters from the region construction. Temporarily store all the
data to create the region in the new struct cxl_region_context. Add a
new function setup_region_parameters() to fill that struct and later
use it to construct the region. This simplifies the extension of the
function to support other methods needed, esp. to support address
translation.

Patch is a prerequisite to implement address translation.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 106692f1e310..57697504410b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3414,6 +3414,26 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return 0;
 }
 
+struct cxl_region_context {
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+};
+
+static int setup_region_params(struct cxl_endpoint_decoder *cxled,
+			       struct cxl_region_context *ctx)
+{
+	ctx->cxled = cxled;
+	ctx->cxlmd = cxled_to_memdev(cxled);
+	ctx->hpa_range = cxled->cxld.hpa_range;
+	ctx->interleave_ways = cxled->cxld.interleave_ways;
+	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
+
+	return 0;
+}
+
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
@@ -3453,11 +3473,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_endpoint_decoder *cxled)
+			      struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
+	struct range *range = &ctx->hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3506,8 +3527,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3527,9 +3548,10 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int rc, part = READ_ONCE(cxled->part);
@@ -3548,7 +3570,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3572,13 +3594,17 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *range)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *range = &cxled->cxld.hpa_range;
+	struct cxl_region_context ctx;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
 
+	rc = setup_region_params(cxled, &ctx);
+	if (rc)
+		return rc;
+
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled, range);
+		cxl_find_root_decoder(cxled, &ctx.hpa_range);
 	if (!cxlrd)
 		return -ENXIO;
 
@@ -3589,9 +3615,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, range);
+		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
 	if (!cxlr)
-		cxlr = construct_region(cxlrd, cxled);
+		cxlr = construct_region(cxlrd, &ctx);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
-- 
2.39.5

