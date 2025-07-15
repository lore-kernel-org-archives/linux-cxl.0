Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CA2BDC26;
	Tue, 15 Jul 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606752; cv=fail; b=sywdDp+7iF91nMHdK85Ny1aCP6+DbHMZmWbectHV9mKshwXObRrSnRwEmOlO9EqVZ0JcmJyrkAPpbpjWy0EbT8Vjsgx0BhWI+LUhZAy4geqMCap1FqYkydOPtF0BkWjlSUZqdWwB14KVgF7PPKN/fwhboYHDULtcl+NAWlokmNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606752; c=relaxed/simple;
	bh=CeYtmnUlMbpDqENrRvZOGfm0mI284O3dKdSZNCquw1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH0ahCDwoGOpOZyRsHDYIeY22q6b9yO77hsA4nk1xkL0LST1mWveReew9oPT/e4vZtvWLAid46kutxJtOQ6DyF4PHD6/rJVJ0X101ymdPm5A38NdBe+AcgYx1ZMXjuhTKN/F9x8kYzxRGqd0WEYW25exJsA+FrOqy1jdL5BArgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NDhLloxV; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NDhLloxV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/z2WLg/MPqzTacFIuaKa3oB97c9Y1RCeQNc8LaR3VTeMnID3RaNJtFrbgDWkSNzQ4v4yMtMFFQVYDDyqPKeXUqbqZpol6FQVi7gE/5eyPOKG6x6Qzl0N4gAX2qRgjEhOPeqDP8V8YEOZgPk6kMa3u13MbtiAGY0Ww82crWI83wywhTOWfJ3XxbP6LYHdMyk9L+o5SoUcSPgBjrTSWTbonzYev63rbPkPDH5kz/cjMQBKLiWPBfWReD0Yxy3GYoIWDiZLC67GI+Br6RYdTjCsgJ1s6HFF0SLiB0y52YQ7EhQqFkrUB2hoIR0CM76LkyKW/YEni5dV60b4+CCiz3xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX/zHQGaOX8IFzAw90vyuQa3/aY4GWAgfDg+7V1Wtn0=;
 b=flUcOIGUY1p1rrUxyBXOdkRA1tfZ/1JTtdkz8JRI8idcV2fNkRNiY9d6OL3Bar/ioK/OOlP+8tD13SchwmHQ+kOHeqFbhzFz+WFFAjxmiXE4OgeOoVKWlJ8LTlOuUchpn0GR3kYKwiR0xcoOSuPhkaP0mIb2qsu/xhXahb8wiJeKX9vdFFvG7kAoXwdXHXMmrDfZvYwtZ6AHFZVPv+NvKhedVQCZk8GZ45gUKdEEs2wW1sY6Jb1qO0VcfPGBC8bUA09hzyUT5NiCJji4Fz7EBWmrawmk4TPo3pW40nv/tWSp+IHE8OIYviHBr4NPqyKXZs6tCqkJu3D60wvrBCpygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX/zHQGaOX8IFzAw90vyuQa3/aY4GWAgfDg+7V1Wtn0=;
 b=NDhLloxVkbSCjAx/b9HQ356yfM3wwWrQt1KAG5Wd8q31oj0lnKxQAfpDM96Ut9k7iFBw0OnDdIS3SSJdEOX4WxPBeX45CZYF35WdgrNgC5d6TBhgf/F41ha28d5IlQf9jcJvRkFyBcHBRLEzmZGqQzaz2xB6dbD4Yz6C3VKk2Tk=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 19:12:25 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::cc) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 19:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:20 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 03/20] cxl/region: Remove region id handling from cxl_region_alloc()
Date: Tue, 15 Jul 2025 21:11:26 +0200
Message-ID: <20250715191143.1023512-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d696f9-a833-49bd-f21a-08ddc3d387bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K232a0Ky1fO6E6XmKUyyforGRYgnZNkTnJaFNpB877P4hBSa6gHUtdaboi+g?=
 =?us-ascii?Q?bAfZxDs9K6glj87UZOMqPFvVrJo9rdzZmvnB/nbNxG2xS3/YPBbE7mMLRoMs?=
 =?us-ascii?Q?KmfAar/+bZsLCk5YfTZRdguy4cKwbEnrdlBLSoskdkqgUX1rOlyL0M9+alnI?=
 =?us-ascii?Q?NnOrIrp/XHP5eRAF9Jw6M5ctpogrwerod99hgjdMtuMlfrtHiCDAY2WKuvlC?=
 =?us-ascii?Q?aaP+cPuSfWtRGkTlAU6ZlrZXEiFiOfu72z+5qYbLPfKeLiBl1kRjdysyEHTy?=
 =?us-ascii?Q?Ly5QGwHjjsjRCdON+ywDAObWHK6A8dZ+iTPBmycK9UR0FrBbDlfh3nP7U+Dy?=
 =?us-ascii?Q?pe2rZQZkmX3nl3l7JTH306gPEKcso9zFMwtb2gE0o78PJKY2ycmdexjG6SIZ?=
 =?us-ascii?Q?27jM4XT77cWnREVZxdqXUvtk1n8IMgnPk+NITxcav9wMQZcog1uADBLG6ng3?=
 =?us-ascii?Q?q8rvRjMkDMX/Kxt4b7sgZqXL288u5ros0bseR+2RTVd1kaxrQHdVKrfct6+A?=
 =?us-ascii?Q?YLSJcLujGReUWPyoEDJQ5ONmL8DgdWCnazcKVmUk9r/H9SFYKxhorIW2XeOS?=
 =?us-ascii?Q?XdDXIVJoTPzbDawb/tgkzpwBGL/+NPQOnSdsdcqgs+KfYXLKLZVHW1TvxBTk?=
 =?us-ascii?Q?sET2VwXVelZU97Bs3sKh6CsSaEFVr1TYaSEixbUP4RXw/FZgxEzs4ZDT6LL1?=
 =?us-ascii?Q?lPn5iD7JgWr0sGQnqnKFFIDtMuJMSyQRstnXUqOc7hnhYBgq7FpoM/sFmylV?=
 =?us-ascii?Q?Yr5x/7VnjdLuULCVjfp87DyqyWHn8woCDfy7cJExi6EwD9drfTD8ONZ86e6X?=
 =?us-ascii?Q?NBDMPg+pKO68OjzHKxgZWxxkm43VbSywvz2jeHBEzPOYj8Ja3J6HMTUdgsLC?=
 =?us-ascii?Q?M8hWExeYSYgUokmunZrB+oyd4PsIbHF6FcrT/NZYQwkCgjM71yYdn9VmdV8y?=
 =?us-ascii?Q?vf6lcUk5iU3v3H/lV9iSJCMihZ1OF0Yjeax961ThhgreKkxGPmco43PoZR2g?=
 =?us-ascii?Q?1isICiEykNvVCoOZU1TTd/nh9bWCM3hTnYQpTy5+vdKpJcljRA0eqrfaY8RT?=
 =?us-ascii?Q?Vcz+NxOJKHJ9ZjL1Af7Rm4hpvH2Nn/QNeBP/UTFKYldaFa7zqGxp1s3FvlFF?=
 =?us-ascii?Q?mJ6QRPd8qRToPahJuof8PdiiLm0X1NLigiGPGiP3HAR1Hycf0Xbl11yToLjB?=
 =?us-ascii?Q?a2lWbPajG8llCLa5DpXOawlegwmPat8MR0I8wU5rTMcdMiT8xhWBygHBD82K?=
 =?us-ascii?Q?PA3I1nJd7bHEhFPDjnOYWhPF+rlM8e5k9uJwslv8CV9/UOuWpD5j8ccNFySY?=
 =?us-ascii?Q?4PgIc8oLkNfEanMHEeCaqLMSYPcNhZS5UUKUkm6h8cbVQg0WlhSYld5OzHul?=
 =?us-ascii?Q?8us23PhC1+xyKTyDuFmz9uts1aM30EQKHiuac+OCCZC4X2Uvd1Zn3OVjCyzv?=
 =?us-ascii?Q?M/TyHtihEawMhr6+ryOeg8UCkyhIWaMGCzdvUGqhwQG/n4yxPnvoAI/gwnJE?=
 =?us-ascii?Q?jiXUsyclJUAy52aIkHJ0SzIemQXU09XAGqnI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:23.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d696f9-a833-49bd-f21a-08ddc3d387bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

The region's id is not needed to allocate the region. Move the region
id handling out of cxl_region_alloc(). This simplifies the function
interface and allows the implementation of an early region allocation
when an id is not yet assigned.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a18ab5e30138..b968050ad3d7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2449,16 +2449,14 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 
 static struct lock_class_key cxl_region_key;
 
-static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
+static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd)
 {
 	struct cxl_region *cxlr;
 	struct device *dev;
 
 	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
-	if (!cxlr) {
-		memregion_free(id);
+	if (!cxlr)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	dev = &cxlr->dev;
 	device_initialize(dev);
@@ -2474,7 +2472,6 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxlr->id = id;
 
 	return cxlr;
 }
@@ -2522,13 +2519,18 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	struct device *dev;
 	int rc;
 
-	cxlr = cxl_region_alloc(cxlrd, id);
-	if (IS_ERR(cxlr))
+	cxlr = cxl_region_alloc(cxlrd);
+	if (IS_ERR(cxlr)) {
+		memregion_free(id);
 		return cxlr;
+	}
+
 	cxlr->mode = mode;
 	cxlr->type = type;
 
 	dev = &cxlr->dev;
+	cxlr->id = id;
+
 	rc = dev_set_name(dev, "region%d", id);
 	if (rc)
 		goto err;
-- 
2.39.5

