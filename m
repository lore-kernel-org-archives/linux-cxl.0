Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3134395260;
	Wed, 14 Jan 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409362; cv=fail; b=SIvhc5KJVAQ7KYoBUyV8erozrRB1RH2IScWzpT9WtzeYL3ugzS+3n2GDBxLBxtLYCaXw0EVZgIz0KGzbxgmNZdMG/LKrgjsi50r6dI0Rq6i9OUOgik+WC8c+P8S07pRUibFslksjtapV1KwQ6e0Gx7de1AEdmgh7NFDZmHqXu/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409362; c=relaxed/simple;
	bh=RBFov1bCg8LPrxfAYDWlACobATsqqb8BLKwUylf8+GI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H7S+BkcokCg/kBu5TTFLQb1Lnee/WJdd/v81lZ1ESNmDUDvCmwBRbeu5W90vwd3UwJEezgXTkcJxr3BiAnYk5GASTc6c8EGowJ7qRIBTiB1jRMC9PGIqicwCfWJbouo/fdsO9uSEfmnxzGh2p1f+pLfxPDjYoowbeGyg7grhvmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PRojUQ4w; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PRojUQ4w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKh0P0UtQegI73+HMfjm/vJX9U0IM9GfpqTyqJaXlYHUVu+0y46j9nzQfrid+/d7VXph62d9az21pKMvGq/Xj7OS3kQGPubLOtxu16DU4zqmlRqBh+zArLg7t7nAn9/LXW5cJpkgZas5z1Kibe4BFlBX3Vy4fAwRWUAach32dXQvxa3915AbcJmy6NGT3BBVb9ne5TSpCkXNdSP8ArMm4Ik818kK09ie5bNt7T35+7A1WXvZF7PHsY32joSGTG8iHgGIOqSc/Wy87UyGHF8CoKzOWIZBSCtqzF+cqjoHxE6Tdmx1KuSmy5XfsyLlLFqptPiGvr7mqW1LbKYomlNU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YguNO3+jfhofxLbvJEo2fphc2r9LyuGu16WV3NJBQww=;
 b=ZtG9Bug9eUJMpubmzBzhuLi2H+IS/MpcqX5JBqkD1P8UALIE1OgIe12lWdcmpCzbcWDOHjj1d0sQVhntHBqBjjHTepJqRR+lr6n3C71u5Isy2VBip+weKZlAD9okgno9mQ6oMIlgv/EKsWmtQCNcUfRne6Vc9R4mifUvZN5Q2+ZAYf9uGnR2x4H/UmmLI+x1OYUWyB2a2FBLh5FeVMtj5oq0POhuerXlbzpWcqDhkCgBZ2/CzLGU0z1SCQvCIRD6Sg/jCdhsrMHeynsNx7dxocxnyMV//sjoZ255pUOWySzAHLDJYQxSVVnVrjR2UiA8Yj1sL8eKiVynBVAs991f3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YguNO3+jfhofxLbvJEo2fphc2r9LyuGu16WV3NJBQww=;
 b=PRojUQ4wbWjWhq5E/Yf6e8Q5wQbPH1/jM/dTa+3TPKoDtr802r+C/p5S6spOTd2GVeKRiYmd25eKtIQsh8x62i9Zat7gHw3GmMB87+Acx8OEKi5o/1lf02fTBP+lRCJZV8l+vf/2jzxifFibz1jsayqjG8Eq2NDL5hFfCir4sOY=
Received: from PH8P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::11)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:16 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::5f) by PH8P221CA0023.outlook.office365.com
 (2603:10b6:510:2d8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:15 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:07 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 02/13] cxl/region: Store root decoder in struct cxl_region
Date: Wed, 14 Jan 2026 17:48:18 +0100
Message-ID: <20260114164837.1076338-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: cee26524-0a38-4b84-00fa-08de538cda83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4pG75juMvGIwHAFgLYGzai4mTbYarZF9GskUR/fWZBLuuxVADVu2fTaV8Jd?=
 =?us-ascii?Q?U/knOlwSJClPwrsJDVNyu7xDmnhGygpfTOKr1Z78hblhPL1zUQy8YL50IgGg?=
 =?us-ascii?Q?adweMUTxskJDiLSBfA3tjiEMAnNfaQAW4Mkv6An/Kz2zTbCpim3acT7uQrtr?=
 =?us-ascii?Q?rDCk1UVujtUqNpnPtROZtGIxjuLSIJEjB0/5uRZvHH3eoJN+c0w+I06BVOaI?=
 =?us-ascii?Q?9tox8dablM32rbN5kwzMT/+kkK4s9WznBybniuAkYqR4hee7ctdUUCpqZNZz?=
 =?us-ascii?Q?vDSWvycuiHD2+tmU0o9NSb/iviQ5Uazsiua43wEMWk++UQ/06kX7goSCqVmD?=
 =?us-ascii?Q?xuP4RnxVfuqBZGix29Eiobs65K36upPRkG+3VS4v2iahqxGfCk3waHDoK5rr?=
 =?us-ascii?Q?li13F6TbTEAg1XAkL2K71Ica2WQrKd0HF/D93clEEHzfRXBMcXkwZ/IMWQuT?=
 =?us-ascii?Q?Kn2DlUvxpJi5zfkNKfCh4CGOQkGCaxTJ/M1XeyiTSCp1+4UvdiDRMZJ3utj5?=
 =?us-ascii?Q?bxXSVPLOhu/hB8+6gWKuu18w8pRNYXsNiwVmcocFh1jYRon7v7sK6V0YepNZ?=
 =?us-ascii?Q?8JEoir1JYxR3tMoSIVF78J21y+bDf7Fh29PUO9zRyDYI3Y802ki9ytxSZjCm?=
 =?us-ascii?Q?ePFHs78qRFikx0LAfUC5sab7YAvOTT3qhQQNIqo3TtPDiyVoQJyjXfgywBV6?=
 =?us-ascii?Q?osItBPyDHibI2LfN+UlQn4wg8Ceh7zTR9ygWtD+cKBN2AQApSbIkOUl9DJID?=
 =?us-ascii?Q?GGWZWar4JXrDxi7vnppBKZtxebnAYgJcRxU3ZAEj/cBfAqk+1xxdwVNaR+D8?=
 =?us-ascii?Q?JW/Yg+A25NXV8U6YblrLac0j/HTIq7KMJBpZ3c2Gya0bVe+rMzMeXW/0tH7N?=
 =?us-ascii?Q?OSDdgpiliMJEFwxqGWjsx+lflZLNpMyxz5eXJ2K2BMxvgJBxtyuUOKI9VOfE?=
 =?us-ascii?Q?enDpeJGUtl6omtXGbIGXHMXWNB9EfMzbrXTppCsrWSFiAL++lx3IvyMVPMtC?=
 =?us-ascii?Q?ort12jO6dFhrOndkA+XLMYNIZpy/G6KH6IQhc65ZT7almQlGyW3tNwv61Ags?=
 =?us-ascii?Q?rZbZbJS5BbPncma1bL6+4qtPVZGdCNT0NDs78vmTvtgRPSgqCZHWNFtmVUGu?=
 =?us-ascii?Q?majMcLEhEI/1aODi//ID3z/Huo4vd3FzvtkctZjTuMi4t6C3vUOLGxtEe+6A?=
 =?us-ascii?Q?mhJeLkWnK6KlHja1n2HxbBA8KzHrWtB61uiCMYQKY+vr1aSdkmjrwIyeqzHj?=
 =?us-ascii?Q?fINIAzpfII9wQSADqI+3iSxVX49RUreBo6KcQLScRuceIwnx8LJTtRzmj93+?=
 =?us-ascii?Q?FMaahUrwub/dc1M2CEy+YnL1yjCbGUBQpjaaa7b3fvQ7aoRwg7u5rn/K/TcQ?=
 =?us-ascii?Q?J2xPjimox6xLPjzANDFUoiWUybqGPsE7oO/5XwlxVp8ZehG3lPxNDRLlJ1/q?=
 =?us-ascii?Q?Yy/dnxOqR2LakZOVhFTz29jF0FjL3gWmHI9pZ1x8pdQHX/rWLLcQrpU+VnnV?=
 =?us-ascii?Q?V8D+qenvN+R0Fq8/HQ9PRqTsk7Q8C8RZ/YzzlRGLW9JzDfhYjXX+IES4wVjs?=
 =?us-ascii?Q?WhgaZekqdf5hkYl6jPF6NIeCXiAYIFQfb5pPOBwcBcR02A/+ptVdb/t0aJVf?=
 =?us-ascii?Q?8LNOu6SH1+qBkGUokUk70d+cJji6A8iehcFcN3NKICdmPnwA0Poae8PkylK/?=
 =?us-ascii?Q?F60OLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:15.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee26524-0a38-4b84-00fa-08de538cda83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

A region is always bound to a root decoder. The region's associated
root decoder is often needed. Add it to struct cxl_region.

This simplifies the code by removing dynamic lookups and the root
decoder argument from the function argument list where possible.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters. It changes the argument list of __construct_region() in
preparation of adding a context argument. Additionally the arg list of
cxl_region_attach_position() is simplified and the use of
to_cxl_root_decoder() removed, which always reconstructs and checks
the pointer. The pointer never changes and is frequently used. Code
becomes more readable as this amphazises the binding between both
objects.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 37 +++++++++++++++++++------------------
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 51f1a5545324..22bd8ff37cef 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -489,9 +489,9 @@ static ssize_t interleave_ways_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	unsigned int val, save;
 	int rc;
@@ -552,9 +552,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int rc, val;
 	u16 ig;
@@ -628,7 +628,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1373,7 +1373,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1731,10 +1731,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 }
 
 static int cxl_region_attach_position(struct cxl_region *cxlr,
-				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
 				      const struct cxl_dport *dport, int pos)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
@@ -1971,7 +1971,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2076,8 +2076,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2100,7 +2099,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2396,8 +2395,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2480,10 +2479,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	 * region id allocations
 	 */
 	get_device(dev->parent);
+	cxlr->cxlrd = cxlrd;
+	cxlr->id = id;
+
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxlr->id = id;
 	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
 
 	return cxlr;
@@ -3115,7 +3116,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 dpa_offset, hpa_offset, hpa;
@@ -3168,7 +3169,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u16 eig = 0;
@@ -3522,7 +3523,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3558,9 +3559,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3656,7 +3657,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..10ce9c3a8a55 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -529,6 +529,7 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -542,6 +543,7 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

