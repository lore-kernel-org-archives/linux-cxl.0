Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019672D9EE8;
	Wed, 12 Nov 2025 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979540; cv=fail; b=SITWp3KBQj+3mzqp++Nxe3CPjbgo2hRD/4JQFKLFehsAS79ODXLfVe2aURTHb/1Ww1gj3+QgHqAmBjpBC2scKeTX/ScCw/Lr/7U5hMN7lmF4XYA648oxhCDFqFgFV5gshsdAh0mOdn9YQwpJcqlmZjUma8lXFXVdiKuJbDlPKew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979540; c=relaxed/simple;
	bh=YiXlaCIOuvz+DoQ4hPyukKQYH2sbEQZS4cJXzKK4NMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1dK2rvdUiIuLNDZ7xNyNhJO1fgdt2GJXIfG2qbTPWtwyOItc+jGrHq1BxRYDBQxD9eO+9SbWXPyp15lbw77HSpxSUouydTaw8xa3cI37t8E6hEfCdTM7ZxhK+AUz3+XNtswTuAon3Jan91yV2Ra4W3S+ZFQ5fFN6ZV3AHthAWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MDm9hQf7; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MDm9hQf7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rfz9MWxNdFYpa9Kq48sPJ7UdUP3wO6IBTgv43O4aG1G7NHJSO+1ycg6hC2W0lfSAJAdKCKzw/YtLlGniDdFSIKh440n451Oh+ecgEYgOlABYnGNqm8RKmPj8GRzzemmSqo2ylYyFj6SLQbNhAMxElVqh8CH36txiBRDYrhTxciVlVcAZiTOL+spZ4aXKBUyzWyimsjOsmGASXCFFCRymv0y9LR+c2RUbasoIwscPQywWSkMJAr+JP42HvVho6Y50eD/FZApmh7w+rb+WUSA2ByKRUYcAkfupiEdWEdafjRWA4X2OM4hUdobOc/G+heJRJzsUJa6W7ZRjAGTQouH7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PGfF8QhrYkIdmiHJFm2IWRRaedAmpWd/Y8R04TPvLg=;
 b=qgFRD5IXsxumvqhE/rq3S9L338Vi7k1qrRKjEJfA2ymb35YQlIaAft/QoNTDCVwnsM4Juhy0OSTUobenlLEXR9syMdDlFO+taZ6udoNnZ72zZQabogePji0lO2wQ37fg7l25smunjdw3LsL1B74UJ5E7xn3ysjeuGe83BSvfDSLH/8154wEkQ+tX/TvQfTPlQUqTKHKw/x7FwGC9qvnOvrsdSnP5uXo6P/HctYcZf5MjvuJP04gtWuPP3Du+rr5Y3rh1fdwIxIRjUl61MZPIvqn43PrhRcGqOV7KhCBc0yGQPQ7doRJfmlePLUtJ8NJukjJEZuBOfankYwRyd5GZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PGfF8QhrYkIdmiHJFm2IWRRaedAmpWd/Y8R04TPvLg=;
 b=MDm9hQf7ytB87tTkitaT0/iH6IGFvpOtAiY0uMmIg8wWNyVxtkTNToloBTpG/rYDySAj7a//THriC6cnUuYmfpOMHADH4veYwArE/ZUtHnKSkFJfCin/rciX/4wk7iBdC6c7r2Af5t8Mena7E/A53gl/nuvQFVuhS8Bv/tTOghE=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 20:32:14 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::5f) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 20:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:13 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:10 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 05/11] cxl/region: Separate region parameter setup and region construction
Date: Wed, 12 Nov 2025 21:31:32 +0100
Message-ID: <20251112203143.1269944-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a132908-3d13-467e-3cf1-08de222a9064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AeZ82LfOFP8e+65IiO2hCx6L/CgoTZ68P6XGjkvyBzRhy2dY5aumIX6rafBR?=
 =?us-ascii?Q?6EaKpBli3APW7hv5nYaOAHpKIxjLV5dW0qRT8hBQZmgG1roH+OIrWzb0J3O8?=
 =?us-ascii?Q?qqASx+vtfaruzG4cL4P8mjV87uh24BU8zK6njzcb0XxJBAjBZ4J9Z04ikjmI?=
 =?us-ascii?Q?lzXcw71GCeO9W8jqJMsZLp/e+sxL+hLKQEsfoUrdXVzv5bhiWm/3tXZ7RpwT?=
 =?us-ascii?Q?8td2ewXWZlQEOjv3OKlBtrGeOlQeoqaK4Q6c0ExWBbA4ZBjKmTjL7lxSg54a?=
 =?us-ascii?Q?ejMtm4wfOeHHTiKFldHGOwIBodZXMbWSzZkWIRhUrlXXBg3pkIZjyqYXNNZB?=
 =?us-ascii?Q?54CI5Os9GuOwBFJRXeTWgBS9rVVsQaJe0DwdxuguZjv0FmbieOS9oCcpeXxf?=
 =?us-ascii?Q?MTbV28BsPq0p4+eSBzO6xiwYOrgl2QivdvyV0pFHXU8rFkPRh9wFzbw1mqH5?=
 =?us-ascii?Q?cghEWwPcMtbd0y4aRmW8br8GXGZ0OvUXzCdNQ/Gnft2/FBRhaGvlKAdXkerU?=
 =?us-ascii?Q?uoNMZMeSzgo7N4b7xqsyeRb/BY5ElttZs5ualosuQaNiWsncwIbEP4N9uZnT?=
 =?us-ascii?Q?1QlcO5NOlBvTlo1w8aAd43mT+wArqd6SJ4rB67Mwe/6Ix80fgZbPJzKnyNbx?=
 =?us-ascii?Q?nf5mIZud4PlV4Pyo0Qxp3/U1M2B/g3DE4ivYT30DCou9QTZ6TY4/LZfS49bw?=
 =?us-ascii?Q?J9ujmsT7rMkDGweI6w/0Mky/zLAfmRwA5rLkTAC5xbt3Hyp6i7gedYXo8FSB?=
 =?us-ascii?Q?fEi6KAN80aojKq5nj5okjHXWKWQKNytVk1gGrb7HgFrzLfadnoCKJPe+FwTc?=
 =?us-ascii?Q?afLL9IpsxdB/vMoeOr5LouD1enx8UuJ/j5MsIv9b0nCMM8vUHRQeGg5EYr0d?=
 =?us-ascii?Q?sctLjkWjMM2c7k6hRHPJ1WXedK5wof/HOvx3fmm2NiktoSyrxm1098epQaj3?=
 =?us-ascii?Q?WxU4QMGBQKoNTuPHiruGCTRUprkvs8OkjWykOXsrtL798u01qZ7NmQsBGZN0?=
 =?us-ascii?Q?H2UP9DVGHRgP2+KdikqROF8ekmIEyHRwSAsNxRT/IsJO4PXScsXNtoSQgK8C?=
 =?us-ascii?Q?1lEyucyaxrHOlbbqCsErJYxTaGr+Ue0Iu9MOZLaIWlBFvOSf+bP5gA/3Nt05?=
 =?us-ascii?Q?e2AAp9vTAKE1dEZZ+qdsVKjLASv9cTXvj/+QhlCpwLEmx1juFHfUr+eWpRSZ?=
 =?us-ascii?Q?PxHW8n18DO4l1OhIgGLDKbDluA56bvtUBzDT4RLfBK3uMxhVAy0XWFRlmJum?=
 =?us-ascii?Q?suLteLfYeQLNRcfCTwGlIVbyPhgkn1FaHvLIksSdTVxB9NulCELb0EPYsXX4?=
 =?us-ascii?Q?7V9FAL2AgTw4SInxB6e/5FXMRubRW/YxmjuUiD/I+qtyr4HGqdH39/UtlgLW?=
 =?us-ascii?Q?wxDR4ANNYaVQ23JU85wkzczC3qQKgqy2b+11me/sMZCwlbh8RGsm9g8Rr8MF?=
 =?us-ascii?Q?sjF+x73br2glcp7D5Gu66R/xzaJ50WBkHWl3f/Zp0qRaYBLXXtQRXsVmuA4v?=
 =?us-ascii?Q?J4xIF2dQayW3Ka+OJfmGD/wiGuurBddGXVEpHRjt1N719bWicx+4c2ToVbKS?=
 =?us-ascii?Q?iKyX3Q/oy98b2FCrv/w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:13.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a132908-3d13-467e-3cf1-08de222a9064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661

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
index 5b9d096a73fe..07adc2075103 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3554,11 +3554,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
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
@@ -3611,8 +3612,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3632,8 +3633,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3653,7 +3655,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3678,11 +3680,18 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
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
@@ -3695,9 +3704,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

