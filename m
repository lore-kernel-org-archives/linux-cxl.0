Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422A2C159D;
	Tue, 15 Jul 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606792; cv=fail; b=SmvLDdzYhBwI0QLNTH22LAfMbLDIDt1zfO7x29dPvMwkTXNIrPe0sJ3oMTqD+hOl2CSCAVnCP2nlF7BhjJq8PvQRmTkGMTVb25DoItt59Bd+Ia5SH/NsHIF8xjztOiwnLot/gcgIMAVS7PjZ+pXDsysjx428YmEkUja/BJziswI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606792; c=relaxed/simple;
	bh=tBfIr5xbBnu1Pw3spvp+np10nJb+B+o0U8RbWo8/vVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4+9jxUSHNdtrKyWfNLKjjFY3k37lt8E0K+StavS2z5OakGTFBJlIGsk8LLpiRV0eqm8GXvXtK5Qqk/QmYN4p3hVTBRf2CKAd7LznM6zPkv4yMNvkB2/gW5iMeLe7PNzJYOoVcqd0UxxXwUphFhhcH3OZFV1xNJm25DtZMrAgfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5KCEy0xh; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5KCEy0xh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbt2bUNaOEgK0Nnb4f9KrdXCPsW+t4NSc90OxgBbhn6PpYN7WSb1hF9ZcLaPLZWskJoSsz/7l0cob11DrXVtvxkI+IiHcKesKJb/OFvyw/g5wZPrpeQkS8ABWq0cmjsvKZdSQyQdLNMJoQosxEUMIAE4Zs6wXpGsA6mMVp9EtkUXpZOC3kqWVjFPQ9rnEIGX9MvZS/38kvcp3gJ5nVSR/EMGzYw+FdfPrSvc8lr1upc0qvfiTcUmFqTOcN+/i+R5VxbImpiaHbtIAYKeGzg1E+LMzdSLEBUUowvHxGXNNuuE8AH9G3z4wUO2Z5rlMf6Ikz79kKrNxL76t3OTs0NR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0PJlIvnuMl+jSinX3K5Lm16u/7zzzp3f3NSyJmB8uc=;
 b=rofwYIec8kENc8BsksXQgLFqDcgYxw0JYVWLqar02yJ41JwDmlBg0BrsP08/UoofkaR12acvVjibLG5txHggAXOX3gfR7+YYeeLq/tEjV7cvdz3KTtzTbYnIx0+FK4Tpa1piFW9wOS2EsY0vOBguoRFDm1ll5efA5vEsQnDRR/TK1Ab8ZEaqw6xz0o/ldNh4jq4oS8wiVIwB0KG3ck+uhAUCUJeZd3oVMIUaZks87ZWz5omcJCTsvAGnio4KRGfl3xmavFmjdLp3+XZzeWxE9LfcF2co5HlDbiyag8EP+E95cFjS3xKQ32vDWHCRtp3qnuuyNr5mjsmUx31ueWPtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0PJlIvnuMl+jSinX3K5Lm16u/7zzzp3f3NSyJmB8uc=;
 b=5KCEy0xhfkuykETtNN1JTBx7HoIb8ab5thODtyW17ecalDdxuQcSyrmnBcR6rqwpV0x/ei/PKx5MPapPHTDjGEPrlHsCgod+aEyfqIUsOASgMP08OdJbVf0ye2qFTU6BqOUtO3EeUHw6/U1YxxY6Fj38wSMP5pCwRtbrQ5eig44=
Received: from BN8PR15CA0065.namprd15.prod.outlook.com (2603:10b6:408:80::42)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 19:13:07 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::62) by BN8PR15CA0065.outlook.office365.com
 (2603:10b6:408:80::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:07 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:04 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 15/20] cxl/region: Prepare removal of @cxled argument from construct_region()
Date: Tue, 15 Jul 2025 21:11:38 +0200
Message-ID: <20250715191143.1023512-16-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 231912bd-3830-4abb-6da0-08ddc3d3a1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UfkcDxmXO80/leVGAFO7T7HXIjxpRDMloqYaQ5TFSIUgfq/Aszu3PUFxIOMj?=
 =?us-ascii?Q?LsDscNhaeDTUAuIWecjVzNvBgXweBzyJ4gtdkpYprKqKdIEmeTDxinSRUmx0?=
 =?us-ascii?Q?PonjdGwCOMp2wZsaMCU17Z+zvMZacM+WcA7zly94bN7/6uNcs5WTfz1ItmIX?=
 =?us-ascii?Q?Wxs0brmS3nak8ZzM5X3CveiSZY3OYYooa5kolLM4jYBKthwP7GE3qjNNpXMN?=
 =?us-ascii?Q?h5GaowY/FHB1BXqxjDmbgF7mEWPLUkjdTUerAFIkMKtmXInAVQUTD0/h1Usi?=
 =?us-ascii?Q?nhiJt3ITx3EKzzBOTljt+LenjY8uES+eiMtzos1PwIjttJkIOXRn8cVbf2uE?=
 =?us-ascii?Q?9Gm4lP66kDGDWGKmdzzWHh/dtas8o44TeDFyM3CpVRbKN8cLYin35OrY77Sh?=
 =?us-ascii?Q?ldSbVp92GDLUo7kt+o37HMR+UzlPJs4yJL/P+DBvheBcEVI74ujKIqolas75?=
 =?us-ascii?Q?N7ch5P+n56rv/p4lNQ6E8MZntaFPDUW1bpc/7F9ZJllPedC940E4XTab0fwK?=
 =?us-ascii?Q?YVIJznL2Vvn4oPBSX0ZTmgnxp0iOXL3MYY/fPFlapMyUVZCSRK9sPpXb76Oa?=
 =?us-ascii?Q?Kx23fvfPrnQNNTQdSOQq8koCucXWSQ0lQMm5QAz3DlvClSmGn4EK9IYsu6XI?=
 =?us-ascii?Q?f8nhbNzqnnaZCpqLsH351VcAoDL5r+DzW68F3rD07fkBZ+EsoIWq+gvhFTzt?=
 =?us-ascii?Q?MD+poVjlpfX3/97lcm9qEvOBo4umT9WWPlDhCh2lH5FSPmR2iCf1q73DC0oQ?=
 =?us-ascii?Q?koIIpncxMGF9eYqYYEQYnUbI5m6sZrVyiNNtu4vyFgoe4vpAXKz6mIbZXex/?=
 =?us-ascii?Q?RK86f8HAZF3ZgoRO7WGdDbrapUBAmcojuR8wacdbBvSWyv4BF8ha9uMVDZLT?=
 =?us-ascii?Q?LjzO7MgdskL5nbUS02e+AXf6Zae44vRX1utsyfHSoIEzx+go9+GipfkY9llF?=
 =?us-ascii?Q?Fw03sHU5Nj83dEnVcmltFi/DJiWl5ADMTrgsXqOufmvTyrSzGzGRSPPbzz2m?=
 =?us-ascii?Q?Lix9sJTOnPaS7EfO6+4e9Mz6YCOHhKleLjA1buB50Xz3L1monCuNHmPZoSWF?=
 =?us-ascii?Q?KbtkPmhIB4VTPGHkgmeBo4wNtZUIm0zrYyB4cEESQVOVgG+8C3rmsI7ife4b?=
 =?us-ascii?Q?pM4cRtTaIkbpkQBguZIEgif1yFwJDoXvjViuJAmP5lHpVfjvAFz4GMBU3BT6?=
 =?us-ascii?Q?fPP4ahK5JRQYOv0lpjPsBPihcE815rub3t64U716SLo+nDuCfmGoAAEJ3gWt?=
 =?us-ascii?Q?bCjfmt9KyCB9DOknTtBp3zR/Fa9BgrwhJDvIKqpIBlDNSz+HXhkWE8maevGA?=
 =?us-ascii?Q?UevttzR9wu3t+ZaWCeh4A2/E3VGNR1JHBA7X8+x35YlaJK6UJ0o95LNRVGxA?=
 =?us-ascii?Q?g1AOQ+UVZFq2QgMI8mYbS17IXKTBnfBpuUh158E2QV4nQBppojf9dcoovkqj?=
 =?us-ascii?Q?u79Q4qBDtR0dlCCl7K1yGybtSgvS877/PR6dddMssq3b4grMZwM4Fy2gnwUa?=
 =?us-ascii?Q?lQfbmaSwvte9z8j859C2qlAU5YIoc9dzcpqZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:07.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 231912bd-3830-4abb-6da0-08ddc3d3a1c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

The @cxled function argument will be removed. Rework all error
messages and use the root decoder as reference device.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9adec670432a..81ff9956a128 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3393,7 +3393,7 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct device *cxlrd_dev = &cxlrd->cxlsd.cxld.dev;
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
@@ -3407,10 +3407,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	cxlr = devm_cxl_add_region(cxlr, -1);
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed to add region: %ld\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			__func__, PTR_ERR(cxlr));
+		dev_err(cxlrd_dev->parent,
+			"%s: %s failed to add region: %ld\n",
+			dev_name(cxlrd_dev), __func__, PTR_ERR(cxlr));
 		return cxlr;
 	}
 
@@ -3418,10 +3417,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			__func__);
+		dev_err(cxlr->dev.parent, "%s: %s autodiscovery interrupted\n",
+			dev_name(&cxlr->dev), __func__);
 		return ERR_PTR(-EBUSY);
 	}
 
@@ -3439,8 +3436,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		 * prevent the region from functioning. Only causes cxl list showing
 		 * incorrect region size.
 		 */
-		dev_warn(cxlmd->dev.parent,
-			 "Extended linear cache calculation failed rc:%d\n", rc);
+		dev_warn(cxlr->dev.parent,
+			"%s: %s Extended linear cache calculation failed rc:%d\n",
+			dev_name(&cxlr->dev), __func__, rc);
 	}
 
 	rc = insert_resource(cxlrd->res, res);
@@ -3449,10 +3447,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		 * Platform-firmware may not have split resources like "System
 		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
 		 */
-		dev_warn(cxlmd->dev.parent,
-			 "%s:%s: %s %s cannot insert resource\n",
-			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			 __func__, dev_name(&cxlr->dev));
+		dev_warn(cxlr->dev.parent, "%s: %s cannot insert resource\n",
+			dev_name(&cxlr->dev), __func__);
 	}
 
 	p->res = res;
@@ -3462,9 +3458,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		return ERR_PTR(rc);
 
-	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
-		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
-		dev_name(&cxlr->dev), p->res, p->interleave_ways,
+	dev_dbg(cxlr->dev.parent, "%s: %s res: %pr iw: %d ig: %d\n",
+		dev_name(&cxlr->dev), __func__, p->res, p->interleave_ways,
 		p->interleave_granularity);
 
 	/* Pair with cxl_find_region_by_range() in cxl_endpoint_get_region(). */
-- 
2.39.5

