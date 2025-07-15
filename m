Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140832BF3DF;
	Tue, 15 Jul 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606799; cv=fail; b=MCeX/LHWUg0ksg08nILgrz5YV4zJg6hgssXfYK1aJlz3M2keJlAWKEgXmR1jgr6+1yfJSopo4B7BI6qGnyYU0mvo/NELP46PBqErL8Sj420c7JpiGvQzPuB0znh5sIjGX2j54l7xF4pzG6vkJrntQN/vVE0+2mRvTE5YOw6bmOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606799; c=relaxed/simple;
	bh=soOF9h3wFmnbioLrUOc9eV0EwXtAYDTdzXmVDVGpdeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/tVEPx8JEsi67P3HjY1F/uD96q452/YvImgrs5W70Hj9FmKe0V6i58/vQKRDG7UcTT+tX919VTgO2x1sksnlpsJmNnHRjFKOdGdO5vE5e11lxGwKjFSztx9YMUyoMs1rftJTCMnpEopEOcLmS9NgdvEu3bgZLBf825IStKy/+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xTxGVqTV; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xTxGVqTV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkJzvNGw/g9JA6T4jxC8bZ2SpJIR8qEob9MEjKXo2M/kd+D/QKHY0COvEOIlRX9IpM2hk694JIyKiOSx9y8DNhrG0C/mC+ShsrzqNLvz+Ql4X+dl3hiY9xHqMM5o89p9aRoJs2gfisr/gDaVBx6OAD/CgiIY4yUp7dALn2GFY8hmFBoYYHEub2ADCykjqDSLJDgB0w1Cd69nnyfwlyCfIwHDpbp9EJgk6HCfHzyhJC0W4bMlrYY67guynOGbYSK4oiwXw5vgjOZbE44VPVoELejgu9eiNJi2msoEYSIMriaa5sRDzbYihxokdYRiws0hUialHkx14Kc0T3zx7MgY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/LUlWHZBl0viWNFdTOh+eOl/Gxsttp9OAcvUdIIJQ0=;
 b=cVhH7x2qabu/8e0hmyz1drV4iefCNHtrzy5Malsiqwpn+XDvbv7N+eI5InSjZBr3GLZL4VIZ8sr3SFM57VGNACv1dIIpihY8OzhOwXUF19H+ht41P06iD5gB63Nh5jD2LqrB7jZOcFAxjoXMe9kAWBVm11xp3TlMqxu2kHv8Ke0jWjKdvwTZHPYrOCPA+eAScZQpJOOq0kEdB2Tl62SwAPXS8k8vGNYRPm+4fp5SFwI+16MW3bKCqpK3Y3ZM+f8qO6YANqkA7xch6coZGE8hvrYUvbexvLD9YP3sypqLvfmb+oqt3pVdhWkvqTEadyCyleZViiQSE8G9GRsZMeuDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/LUlWHZBl0viWNFdTOh+eOl/Gxsttp9OAcvUdIIJQ0=;
 b=xTxGVqTVn8ROWaShkfQ0f1nVQ/iK6zElpxWhVb+E1gYb+2Gvud7Vqr0xWSJaaF9UEDZKcVxoew5xR7AmyFfRzSkDZ2JVtXunFs79x5m5xu/FgEn22t14Q4qufLiCIjd3iVSvfeBvQPJj6IdbcyeaDi2M3yNZ+9kxr6PLrfGqAqo=
Received: from MN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:52f::21)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Tue, 15 Jul
 2025 19:13:15 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::34) by MN0PR03CA0022.outlook.office365.com
 (2603:10b6:208:52f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 19:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:15 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:11 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 17/20] cxl/region: Remove create_region() call from construct_region()
Date: Tue, 15 Jul 2025 21:11:40 +0200
Message-ID: <20250715191143.1023512-18-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd92de5-565b-44f8-766b-08ddc3d3a67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?61ImbZz7Du3XSWAfaEYgtJLDTivSyYEq4dFwOT1axpBWnLyb9D0CAa7do8r6?=
 =?us-ascii?Q?VPYPbHX6JU311SokGFvKy/ZIFGBuzugdbkT272+q9cu2UAu6RbZuoZw/CIZb?=
 =?us-ascii?Q?RcUaQbwK6pJ5Ma+O3bIV8kjQOm9orpIWIKLewMNL1QJnmsm5+r2BW3V6o749?=
 =?us-ascii?Q?N3Hun1DVq5957c4WYo+hlbzIceT9JlFIHqv2/HoBg/1W84WCC6UejyTZ2fqD?=
 =?us-ascii?Q?FHD7AsnG+A+diZbMX4HnxwXmXVWF+vRcqEgb2FmxYBsbAh67GPyQHetG+pN5?=
 =?us-ascii?Q?JUba3EUFETXkSK3D7EhqSUpHRwKZeDhjiFMfN7SAwLvdnwzqqDUKABVX1+Fl?=
 =?us-ascii?Q?I9dFEMrHDbAvyGO4VSfQCPqGti/ykncpllSq+5P1Kt6F3eEFtYuVU9lgrnfr?=
 =?us-ascii?Q?N80Gi2C4dnMWifhqq7+IN031q5gFCF5p87kkZi0ekgGQFpYVbebGsUWXlg4e?=
 =?us-ascii?Q?4R0bPJLa1zvnn/GTTK4VStFEsOjVO/AeS3MrBWsrOupVeoR4IMfHo3CG9qbz?=
 =?us-ascii?Q?hZp+DedcRc/DRSfB6hF8xqJ5srP4Cn8LfN80xbKztPt54HYeN7moJ32sC+OQ?=
 =?us-ascii?Q?jaNjb1Q53D+gwnO6z3jG/cBi+JlcEoWqGa9FYz/Bnmw0Q2tMkhTkytWonfWv?=
 =?us-ascii?Q?WST0FpUieXUWiLrD+flzYxZGwqJvDwg2kV4wnjlJPetHGfrP3RX2ierYUqxA?=
 =?us-ascii?Q?LNh4DtoMpJ/adyl+9DkDYPl2YPGXfusZ91p6yov03UQCecER9lQLecgoopVy?=
 =?us-ascii?Q?35IusENUYxKQgyU27HBK2WX1GG2ewkAUx2GAmd61NWzkCVWIk01ahfwWRUqp?=
 =?us-ascii?Q?I/K/5ueNQrm3aL5VBZYxfoBEzrdgonbvEiUWPCWgoMLV7A2lVsofPtrQzl3S?=
 =?us-ascii?Q?GXNsw/QYF9xVKPnegifZvMO3KVCcBXqXvMqTLJ3Z8NICQEUMxPDlYQeQmHtB?=
 =?us-ascii?Q?Nr2BN1yPwu4aLUkWnTkBVyDsmF9FNj2IfFRzG91mmTzof+NPfdhJk/Dajnwo?=
 =?us-ascii?Q?EFb14kcThwUEQQLNcBKLKzSg7F65D2bgHcnaJgpMAE/ee7yN1RwWQtv+vjkY?=
 =?us-ascii?Q?vkJePlkz1aNFVrTqoqWsCSohMeTwB7PiVUJV+AxsSfzJW/cWIsWu6OkYFtXr?=
 =?us-ascii?Q?HUco8IHE+YJDEk/lSbrc6UpNgjvGmoWZJ1YHRlpsm7a0Hr50NebL7GRhjv/T?=
 =?us-ascii?Q?eShzpU3OaU6HLU+89M9hrZ54/o145YJThaQp8XY4FCEp9BmqCpWZDQA4MvUy?=
 =?us-ascii?Q?uL42zrgqBLTDVxcg2yrcLML/HcC48LvuDeM4ATIDl3CSqEzkaxqycfzUOi81?=
 =?us-ascii?Q?EQfWYwoMlXKyU+EftgnX3oX78npbNQpjB71ueT31Jx81aGq5tTZcPqNC6SON?=
 =?us-ascii?Q?QR3PfreMHri8d/Y7IQghFw2QbmuyheyAODexKsaa7kI71Fb4zLpyqhDp5zlJ?=
 =?us-ascii?Q?IMlpmoIL0WSmij8AA0xk2ynUVeLTQrCuuls60be1cqdbCAdcumcqT95+IbwC?=
 =?us-ascii?Q?NEHt+W3GxBTQhHmSiM09uXPfFfTiVIQdxSBZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:15.4621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd92de5-565b-44f8-766b-08ddc3d3a67b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D

To separate the creation and construction of a region, remove the
create_region() call from construct_region().

This makes the @cxled function argument in construct_region()
obsolete, remove it and instead start using @hpa_range of struct
cxl_region, which is initialized using the endpoint decoders hpa
range.

The region creation is moved to cxl_endpoint_get_region(). Use
put_device() to remove the created region if another region is found
for the same hpa range.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7e21946072a5..a81278fbb0ab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3363,6 +3363,7 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 	return 0;
 }
 
+/* Establish a region for the endpoint decoder */
 static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 					struct cxl_endpoint_decoder *cxled)
 {
@@ -3407,23 +3408,17 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region(struct cxl_region *__cxlr)
 {
-	struct device *cxlrd_dev = &cxlrd->cxlsd.cxld.dev;
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct device *cxlrd_dev = &__cxlr->cxlrd->cxlsd.cxld.dev;
 	struct cxl_region_params *p;
+	struct range *hpa;
 	struct resource *res;
 	int rc;
 
 	struct cxl_region *cxlr __free(early_region_unregister) =
-		create_region(cxlrd, cxled);
-
-	if (IS_ERR(cxlr))
-		return cxlr;
+		devm_cxl_add_region(__cxlr, -1);
 
-	cxlr = devm_cxl_add_region(cxlr, -1);
 	if (IS_ERR(cxlr)) {
 		dev_err(cxlrd_dev->parent,
 			"%s: %s failed to add region: %ld\n",
@@ -3444,6 +3439,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
+	hpa = &cxlr->hpa_range;
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
 
@@ -3459,7 +3455,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			dev_name(&cxlr->dev), __func__, rc);
 	}
 
-	rc = insert_resource(cxlrd->res, res);
+	rc = insert_resource(cxlr->cxlrd->res, res);
 	if (rc) {
 		/*
 		 * Platform-firmware may not have split resources like "System
@@ -3491,7 +3487,7 @@ cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_region *cxlr;
+	struct cxl_region *cxlr, *new;
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
 		cxl_find_root_decoder(cxled);
@@ -3504,15 +3500,21 @@ cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 		return ERR_PTR(-ENXIO);
 	}
 
+	new = create_region(cxlrd, cxled);
+	if (IS_ERR(new))
+		return new;
+
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
 	 * one does the construction and the others add to that.
 	 */
-	guard(mutex)(&cxlrd->range_lock);
+	guard(mutex)(&new->cxlrd->range_lock);
 
-	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	cxlr = cxl_find_region_by_range(new->cxlrd, &new->hpa_range);
 	if (!cxlr)
-		return construct_region(cxlrd, cxled);
+		return construct_region(new);
+
+	put_device(&new->dev);
 
 	return cxlr;
 }
-- 
2.39.5

