Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044826F28D;
	Fri, 14 Nov 2025 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080890; cv=fail; b=RSck3q5r4Co3iDXihVPbhFOhT3Fc9NvMTr109rSPaX9/RY0SBcICn0enomWlHpZc8T96nCJpOT9ihORKr0xYMXTXvDN4NyuW0XOlwix0KsCWLBP1p8HNC84tyvKqI7EW9e7qRmTe2fmNLoHY3N1gZCFdTwdT4+PnKLouhTEJBLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080890; c=relaxed/simple;
	bh=NndT+k3MCNINVWqo3EPl3NPWWiToLoamysBBp6eJQKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQu0yIVnzHRU7q2QwMUEI4Z4GWK3Rzka5Ia26GioAzB7Xqxb/SZS13gSCaprdDh6EItHDjfNHqmf0P+bFJVLyWrAgWZPnyQJSqHkkZ2V+GITyDTIS9YLNG1q1D4JsuupsMSDSdtn4Tsw/rtyFjNUVTTtL85BEhhIV0IUulifSGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Po5BTiGP; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Po5BTiGP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPipCeqX3CtWTr09HhnpBWBNh+YE+B3Na79prXqZiHB/Qo8VD/jhKLmpD6Pn+XpOfS4tpXb7/UoTJrXMhWXYgmjs7yC/1iWdtx9FS2AfQm+T7tRhnB81oto9Kq7oXUuPZT55wKgtiCwK9kA59HY9o4kpIjla4xFrj9awkKtOtDhrXMAYJUGjSKUABg3al1svhk7LzXrycq015a+SAjAh3Is0eYQdJYSGoPFl81AjZK+Mbc8/kGMd3H+ITWhwD7u9o4UD+TMiGndFUK5rHqG0FuepnDlzRAtxd1DUguvbxo/xwmOntwjqmgI9WHGt15wz9/fqkjmmT2T+sAPKFq4UVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM1vnZU7MoOj5AeEB3TDs69T1a55Gy2TFxe8IBC6cLA=;
 b=j7pWcaT+73GsS6fS5YVSGGRFunjbIwj2/JSeuOLYp1I+qJEAnNiU7q+ygespD/5g1CPkyrX+sUyU4qqBf+DIPuHy54JzI2prjXcPgLXxA6GqkX8MmIP86ni4KR8B9jiV1gwqqhzTpIuJJK2VsKcRqmCGjZA24Nl0pvdH79Yx+JkTY4syKJomLzaD30GMLSpAHzfudJMB9BTppmEWSX0ORKusismjy/1mXBMAmWEVQ4/EvVSF50NJUi3y3YoodzV7p79N3vVG2VStSMDff7n7aA1jCJ5ZsX6/PubuWGVte9Wt2zBAWurzef4HOvAoIDVo5KhALE72Wivk0nmRvwRmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM1vnZU7MoOj5AeEB3TDs69T1a55Gy2TFxe8IBC6cLA=;
 b=Po5BTiGP3CJO+nsgpnjaYJjv29w3K6Y5RnyG+PK3agmz7yKlDS+9EbKKbZJLALS7x3FIU1XYKLonJ2ooULB6IZepH8pMxFEWlQtx8r3NvK7TLpxnev/DwRJ5ycG1IW4cVxsyIuCUjLzeTyX9dezE4fmJ4Y2GIQie6sSlS3s3JBw=
Received: from SJ0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:a03:3a0::31)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:41:22 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::9b) by SJ0PR03CA0266.outlook.office365.com
 (2603:10b6:a03:3a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:20 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:10 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 05/11] cxl/region: Separate region parameter setup and region construction
Date: Fri, 14 Nov 2025 01:40:10 +0100
Message-ID: <20251114004021.1310661-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f615c9-03b0-4130-3025-08de231687ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5buLhjl6/v0F5w4GbNcJvJHfeWuc/zziN/tyE4rL7W9Aof+Wc7kpTWQvPDt?=
 =?us-ascii?Q?o4whNGsShC5NNoKjl8sMxvlks2lYGThcVpjjKRlYH+ZfCeTfVIkM3tTZqPGA?=
 =?us-ascii?Q?HECrtCS5hfkIqs04Rs0fXfMeyyvd2Ezn3Zy7XKn5iP3siz5LD7iRaIdBnCar?=
 =?us-ascii?Q?7sGVbMXxQjZgABZqf7jNYbvc8bBr+UcBfyBTPz3wFPb3cj6+kfLH/V0rlMmP?=
 =?us-ascii?Q?rNxXsW8iNVm8i1zdnF2jVEXriB6U0WNpTcodqv7f2nIdLeStuiACInaxC3Gr?=
 =?us-ascii?Q?pnx9PMLq//w576pwYMSLDbokBHIN+1h36kK9UuskO+C7X7sEeZ8zk46L4iiA?=
 =?us-ascii?Q?YG8gddOzKB9r8zB4ZKo0k9N/bbPW1ACvoXU/YxskSr4z9rkpymcUP9w+uXvn?=
 =?us-ascii?Q?ylBfsTzRZEZ5ealqUSDjsVIFmO2MwcH32YBk6qW6BIsDWRJD2Zffo+URYzfZ?=
 =?us-ascii?Q?ELhYJ5KJM5m7hG0UfwkrWKdBX8vE3jDnSAbl7qrdVwDckmt9R7Zxpp8DwNFA?=
 =?us-ascii?Q?+j6WqHA1Von9n9fC8po54AzTr7lpZF61vRi/Xw9NSEiAmrVrI2brvNN+Wvdz?=
 =?us-ascii?Q?dHexkB9nWXaeXFbot3aUh7qApyfqJFsVshhV2rsl+Hbfv/2v/2J8IXaI+BHk?=
 =?us-ascii?Q?tQsE7mhS9J+3oGErKcM7mXtWpidFFF4TbcZjT9opEyOn8IXghMBSNWzmTPYv?=
 =?us-ascii?Q?nmRyDGF5tXhvWNtz6gaYi9jdhVmdf6tj1DYInBw1ZyTvygOq56ItUHUWlvmC?=
 =?us-ascii?Q?tv+rOxNN1E+ZcpifjcjNnC5G6Q1JIU5A0/M4Fi9h1rYRbhInI6T16W7i4TsZ?=
 =?us-ascii?Q?ejvQq5MsZuXAzYxXtN+HcYzSJHnSqixxc1/b77oPY0Jn1juW9yw8SMn+OPhf?=
 =?us-ascii?Q?pwpBpRAZ/TQHEmrYGz15SRU+Q/dJUYwzujN72ytnXFIR5zM/8WXm+NyOxLhm?=
 =?us-ascii?Q?oF6Ah7nlXjJHlgKWF4Ck2/zhe2LEk5JmyyJ+9U4Q3nzvJOWm3NRl1+p5Bwy/?=
 =?us-ascii?Q?Jp5i6S2/XOXAsT4JzqhS0SonjAh11DQe0lh8ptyrSYC1UY1tTn88L3SNWK33?=
 =?us-ascii?Q?iL7nPRCMuFZ+tscK0EgnrKrvNqI2nlhTf84vs60ii+uRZGbLsJbaEMcDbo14?=
 =?us-ascii?Q?86pb9TNEdXnFV67mqVDbgiJggVhITKZCOAx8CWd0uH96nCh5GICteyXi5dZu?=
 =?us-ascii?Q?wjDzN8MyYuuKf4x9OClgXFzmTXCXZZxyNS3SThsNB4RQndS8tNogC8XqzVFB?=
 =?us-ascii?Q?vMZfmIWo/uHNaruVj4zAB4HHMj5qgsO+ANfjXHhnWb74nQX5SCIpNEE7dzPg?=
 =?us-ascii?Q?HskZzx592Ypedz4lsPx5WElXTAwT/clEZUwmpNd2xApuoX+EIjNyP6ze2gBx?=
 =?us-ascii?Q?BO1ysaF315OgNv41vJO8IMkf4SuCHZSY31/GnTAf+ZFIZyLhM+W0uGXjdR/z?=
 =?us-ascii?Q?DIxKw/sMjIRY0lSupJEWIpJaS9Jiehb9uYz5ZZmBZTm31c2CgNjANuwJ3E8m?=
 =?us-ascii?Q?lREd4y4MVBLljehUaiI9ozignT9DG/EB1YZgyBwPug6q3yBqi2rTf7IocwTZ?=
 =?us-ascii?Q?uw2ube/s6TsT45bIdZA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:20.8382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f615c9-03b0-4130-3025-08de231687ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

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
index 13b4e27248cf..52924006a10f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3436,11 +3436,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
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
@@ -3489,8 +3490,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3510,8 +3511,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3531,7 +3533,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3556,11 +3558,18 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
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
@@ -3573,9 +3582,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

