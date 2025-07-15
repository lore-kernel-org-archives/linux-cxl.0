Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B522BEFE0;
	Tue, 15 Jul 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606740; cv=fail; b=GAVM5L7oFd7nqRJtv3JEjSZ0lv6aS5/rHOhaomXIy2cjtbfM1xITgyz053b/UTJng12T0YCBTv99suxiZ54i5aNfTlBuZCMmO+HvY4cr6YhIAyh3UCwBz81+E+xYN3ZBKgg416NCLVQWvpbo5PmT1FxG9w0jj4Yvn+XdD+8Njx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606740; c=relaxed/simple;
	bh=X1VZXt2XLYYfCHT5FVPV3Rvtz+gp9AO6cwmLQ1b3JEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB84mLDRR9/nZ4vVQkaxEojD0pCL5MWAchdQZv3g1lIrcjzJ9+JfOywGAA2nPNf3nZVK+Y36xgj28P2OV15HoTZ9k/42cIBVKX1fLDASvj7/U9c2T3D55NIRRgQBiQ0Rcjhqk/EbbsZZ/4FugFxvi0LoSqVeOPJ1hOwr6yyOk8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QVZ66lj1; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QVZ66lj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+qKInttHswNO/0xPSZgrWKSPVfuF1gjnl4oC4eO7evL1E4kpu4Irlul/Ia9FM7fYztMuzzFRN5Xyg0nraRY9/UeW0WQjrGw8xBjxZ5Mmv1tG+gxjtTsNV+aU+QZ3kSehMc7xzjzGqw7rJ5pEjWtSrImZ2CFme+AIM8bI2MrHCWQjkr5tx9uKWaA01RNSacnfmCujTpbEnwQ3ZFz/+hR36cfgRidvonV9hWtj1ALeJiGhR6WVIZzC1dk1gpHVzogXvX7ZXTGKbwT9EvrQbQC6PyBhWJQuEuSrS/2Q0nEX5t41DO8WVW01+qnib9bNr3R0L2vFPfydiKQGxTVD0hR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obdbZ2nggGv32RMKCX0JcK8gukoePWqWBiHZk7BFGqk=;
 b=xC/xvtnYgEj4Pl+wgTBbXk444oUIQ/ZAxT2itZrNmaoM+v//l9WJfXx2G+VWbXyIS0w1tvKiWpTLfQOmA5jDG5AU5qfLMuw5XmM9hr0YinjgZ2/jSZMpZzG+Si/VtqzQZJNq+avAmP0NcULY2rnDxGqZ/29ml3kbPdesf8U7yfgJMi4UgnOdWJ2aDoBnhxkeG3ldrRCMeIE9gaaq6RTB4XYdoIjyQ2RkOfxU6t32FHOg84hulDsUSS3usNbQcrmABkPkhJzeaA9vEcK/NGDlfu+ABr/yJPAwGBjsNpan3ZXyPIhs39geOqoG+RCvrLiD0hYtbV/fTgvA4rrx6L7gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obdbZ2nggGv32RMKCX0JcK8gukoePWqWBiHZk7BFGqk=;
 b=QVZ66lj1AdivZx+9fIR2HU/koaSU1eRuWf0jE6c5jdBh3ON66Gd4dnb+Ds63nVE0SwhEHDqefWJGfC4V9ARUyXDThpkM+IQrMuQUJGAbfcBudovcSyycMIz3jl4eTRC5AgzcMNTKOxf8e31fBY3Qrho8y0Wvqu4si2+7G62JQMI=
Received: from BL1PR13CA0204.namprd13.prod.outlook.com (2603:10b6:208:2be::29)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 19:12:16 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::81) by BL1PR13CA0204.outlook.office365.com
 (2603:10b6:208:2be::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:13 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 01/20] cxl/region: Move helper functions closer to their users
Date: Tue, 15 Jul 2025 21:11:24 +0200
Message-ID: <20250715191143.1023512-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 189126a2-6169-4180-d699-08ddc3d38335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VmzMQ8WSAS8qeNLz+KC/O4C4pImMqBUfGRg3q5XAibHwp2mSupX5om1AAiG?=
 =?us-ascii?Q?er9WAG0CIwPQCx82iMfH0aw97C9H2sW/YwSVWtC0+cvC6w4VnZ1MbraOWJTZ?=
 =?us-ascii?Q?9ODKHKevns9d3FUSKkH5/y7cmGFnoevOWmfW4fWkaRf2tnRiI1taaYnCT9Aa?=
 =?us-ascii?Q?1QHcHlzBgWbzuRZ98btX90yXS+0QiLuuFf5KzKC5QeTLSnIo0UIWI141j6PL?=
 =?us-ascii?Q?2mG8k95OIwXkdkZx9AdF5ETQF5YncOcDojWQsoig7chnMGcoMbCnpNz/cRAs?=
 =?us-ascii?Q?4XElyfJj26GRQyNYeSsPmgxZVg1xLYjE6Y2O+UwuPNhVnePoMGG+XXzHjkIl?=
 =?us-ascii?Q?Q4y3rcFNbKEG76KrUqu7SbFx6EyN9jEhcsNkN1VQqYgfQdtDUeigBk4zM+Hz?=
 =?us-ascii?Q?t4vxf7zwnqJRHsq4vL092YBlfShf7KNhKEgPv0p59oyJfhXbunudhrFmnGea?=
 =?us-ascii?Q?lJNkTMVkh1ypPZ6zaNJTcER6IOWTKa0FHiooYJtxF/9wN6t0iQFP5tChrFDG?=
 =?us-ascii?Q?qB0ac+TbsEPJAmWLjpP4dj69+oOuD1tFbF/9EOdG5YdyYz06cF2JAUi+s8ib?=
 =?us-ascii?Q?x78CXavGflBqtcDHNjIo/ZA91GCoYWzX8grZ4cUpFXw+hMkeVcwo+TKAtDUY?=
 =?us-ascii?Q?uZ8OtE40iqmQxLMoLVq+MP/pVASKPXg02tJpkBglujgeYVNI0KF3Yeku3rAZ?=
 =?us-ascii?Q?2qU0bQWvtruhfvbTLwik60pM7tpyBtWMKFS04pfD0cqATKGGfrcEb1DQPsNo?=
 =?us-ascii?Q?CeGcdidGe259ehOBOnWzENr0vnuaI9JlQZ2SBM8RqwKL3b4i2kF5rerO431S?=
 =?us-ascii?Q?rGkdUQrAlZ5YmcRMXuxQ5CRJCgbOIxjmU8+Mf3mvKBOmWCczhP1YTRV60M00?=
 =?us-ascii?Q?nQuNtsH4Ist4prSuzspONpJWSRkudgmPS8keqWAy6sPCnsHgHhtbto+iwhI3?=
 =?us-ascii?Q?fVPuWdsLFhYlm3nAKq1j886uqA1XZFpjsTevUYS2i8uQXvYBMob3NUPrn/z8?=
 =?us-ascii?Q?bzrbLYMA058Q1go6jT7U4rzsfxx4C77t9evJYYrvpMrUnaGChwHW5ukovNqv?=
 =?us-ascii?Q?fWJsneiBw8aN39YUvh4cCOKuQB01mDf3sffQKlL09fxr8wG6PPh+Gnoxc3zJ?=
 =?us-ascii?Q?F9tjiZFjcsGz5fxqhEHsf741m0O+BFDiw+4QdnlQ/iBHG5Z8FTjzy/Ku+Giz?=
 =?us-ascii?Q?iOEd+4ukl3YeplTGddCKtlPTiqJ3XM0XmsEZSEEmlIV9QWE3h9SuF77k1tri?=
 =?us-ascii?Q?BR0idkB3jS13ae4LSCBZe8AZixOiMUGTR8msbT6Llu20xBZNGKdsSH0qOlV3?=
 =?us-ascii?Q?xYzmfXUR9duLgS5Q5WsYf9TQXt7rpKpHEDo6EJG7T5+U9ZSICkb5nkDYLQs7?=
 =?us-ascii?Q?mq6wYz5jrhr8Hxpz+h8vu0jiQxf/E/JjVcPZ03+rjGuPkgH6F65iyy3I5r30?=
 =?us-ascii?Q?3hcq7gUgTmpTeXjMwTuCrBRh46kzjjN89MzTCd0pfNmmWo+Oo1Cvq8Y7O3AL?=
 =?us-ascii?Q?UZJ3e1frGTouhETG+1NOIm4wOOC79yrHOvgE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:16.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189126a2-6169-4180-d699-08ddc3d38335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728

Just moving code around without any changes. Move helper functions
closer to their users. This simplifies code and a rework and reduces
the diffstat of follow-on patches.

In particular, do the following:

Place cxl_region_alloc() and unregister_region() before
devm_cxl_add_region(). Have cxl_region_alloc() first as it is used in
devm_cxl_add_region() first.

Group match_region_by_range() and cxl_find_region_by_range() as both
belong together.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 126 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 08ac7f483562..f22ad20b0db9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2365,56 +2365,6 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }
 
-static void unregister_region(void *_cxlr)
-{
-	struct cxl_region *cxlr = _cxlr;
-	struct cxl_region_params *p = &cxlr->params;
-	int i;
-
-	device_del(&cxlr->dev);
-
-	/*
-	 * Now that region sysfs is shutdown, the parameter block is now
-	 * read-only, so no need to hold the region rwsem to access the
-	 * region parameters.
-	 */
-	for (i = 0; i < p->interleave_ways; i++)
-		detach_target(cxlr, i);
-
-	cxl_region_iomem_release(cxlr);
-	put_device(&cxlr->dev);
-}
-
-static struct lock_class_key cxl_region_key;
-
-static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
-{
-	struct cxl_region *cxlr;
-	struct device *dev;
-
-	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
-	if (!cxlr) {
-		memregion_free(id);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	dev = &cxlr->dev;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_region_key);
-	dev->parent = &cxlrd->cxlsd.cxld.dev;
-	/*
-	 * Keep root decoder pinned through cxl_region_release to fixup
-	 * region id allocations
-	 */
-	get_device(dev->parent);
-	device_set_pm_not_required(dev);
-	dev->bus = &cxl_bus_type;
-	dev->type = &cxl_region_type;
-	cxlr->id = id;
-
-	return cxlr;
-}
-
 static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 {
 	int cset = 0;
@@ -2498,6 +2448,56 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	return NOTIFY_STOP;
 }
 
+static struct lock_class_key cxl_region_key;
+
+static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
+{
+	struct cxl_region *cxlr;
+	struct device *dev;
+
+	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
+	if (!cxlr) {
+		memregion_free(id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dev = &cxlr->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_region_key);
+	dev->parent = &cxlrd->cxlsd.cxld.dev;
+	/*
+	 * Keep root decoder pinned through cxl_region_release to fixup
+	 * region id allocations
+	 */
+	get_device(dev->parent);
+	device_set_pm_not_required(dev);
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_region_type;
+	cxlr->id = id;
+
+	return cxlr;
+}
+
+static void unregister_region(void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct cxl_region_params *p = &cxlr->params;
+	int i;
+
+	device_del(&cxlr->dev);
+
+	/*
+	 * Now that region sysfs is shutdown, the parameter block is now
+	 * read-only, so no need to hold the region rwsem to access the
+	 * region parameters.
+	 */
+	for (i = 0; i < p->interleave_ways; i++)
+		detach_target(cxlr, i);
+
+	cxl_region_iomem_release(cxlr);
+	put_device(&cxlr->dev);
+}
+
 /**
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
@@ -3277,6 +3277,19 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return 0;
 }
 
+static struct cxl_region *
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				       match_region_by_range);
+	if (!region_dev)
+		return NULL;
+
+	return to_cxl_region(region_dev);
+}
+
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
@@ -3419,19 +3432,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
-static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
-{
-	struct device *region_dev;
-
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				       match_region_by_range);
-	if (!region_dev)
-		return NULL;
-
-	return to_cxl_region(region_dev);
-}
-
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-- 
2.39.5

