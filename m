Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC42D1F7E;
	Tue, 15 Jul 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606773; cv=fail; b=KWCcoNMMzW91VN5PPjoxCqHNj/gts54IMtoAobN084ksU7vL7PJkRkdlobk/XyV5KIb6Rlkwwso8IAGQcEunVwvkkOcbttJ2HW7bU2sxrkrluh5/USo2hWt7sCxnsfmPZlLl+4kniKvxL2oaXF8KsFqWRrfaPRAeKr5yKItgbbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606773; c=relaxed/simple;
	bh=PfimUmjYTXZYZG+7c/GYoZRCPmc4ErUp5mSva0THOo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfPeLQEN9tOJFasss8g1UBIcErj+1WdIXLWGvBN+S2vMozHu0ZWCce34awcm+atDeTd+T7xXp/tRdIYqpDZ9+N1qC+QbfZWIZTvS5oE6T3/aUte7oP8msHLMSr6Eto9YB9SOgUu97HGZ8pM6AKOfZbf7Hwzm66SKsYumH4FEj7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hXhEpGBi; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hXhEpGBi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHRRgUja6C0/9VOw6Y1ttazMfElamNhZxiBmjk4IK4x5cUhys8wPspYdandK+SDV+vVd+bx+Of2YmRMERclrX8a9ACHi89ZCjoGh0+cpgtXxwtM9v8BKQqJQk51nfHzn2JrnCngGaw06oOYnVJcYIltxxAimiO3DOmMCcEnx+AXclfVhVnzEp6S0BAsEr8idbroRWobjcN5ASg6MBL1BynlltE8FOPYc8+rZ/75wmIVBxOQ9BfbkdEnFwzskhn2t1aoZsjBmJNBbgqvY9mEtNLoWjfn5dlXhDWbPgOJYdoMgh1jeLdMMXTKI4lwOx17sMMtOqbiSPsc2Diz97bqDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl2hS5yQdZjoObmKIpxoMbRmmaG+1UfRqSP1SOH1ZiQ=;
 b=t0QID4kr0F1I91C1VEiBhwHLZjlD5hrvlWJxarG8Cnqd/H2bsezsZtAxYjObUSeMp0IjctT56T6DrQcFVUnA5HF4UHbY9ArKAkf0PvnqwWOvvJfmZY9cQq3DJGxArtdWVxXhFi9PIPZ7UMHnGnwp0QP10XQCcEbYaAIBWFUGfidDo1ZKJcofi8lcAdLpKA5UkzSH8g4qnXAwwA26QeCHsUJwylesuuQ+v9svUWTjdHWX+7CMUM6Xy5JwFkBx+EQoubQPHO5j6fp7yc0yW+auvUC6eBHLCWkXegWrYPxdhx6/GKon740WM6KJpgM6vq2gSYMA/aAxjjUuc6HZucUEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl2hS5yQdZjoObmKIpxoMbRmmaG+1UfRqSP1SOH1ZiQ=;
 b=hXhEpGBiZBobkXEWp2gnz6VFgWdBmYPLD1VvtpqVjFAqhtvpcJbwyZwCGtzvH6au9i3WnP+vbBFdsNOTTikL+oaSBKrI4pzQjMWCzcy2LscrVXFXROKXo1DAgSRiGY1mbXbEed66aWnfWG1Z/UXgtXaNzI8J/LG4jyPaEwepl9k=
Received: from BN8PR15CA0070.namprd15.prod.outlook.com (2603:10b6:408:80::47)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:12:50 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::6a) by BN8PR15CA0070.outlook.office365.com
 (2603:10b6:408:80::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:46 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 10/20] cxl/region: Remove __construct_region()
Date: Tue, 15 Jul 2025 21:11:33 +0200
Message-ID: <20250715191143.1023512-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: c6adb343-0181-4fce-9c0e-08ddc3d39767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7QMgsWP1mwbO21zgf6cH31AdiwIIC/s5Xi+Cr1Wk2AuTTT3uHnHiVZMBwD86?=
 =?us-ascii?Q?iF2MuNI8LEhPvGX/zlcZadsnbwdJNYP4t7USy05Hyc/76USC97IESCS1m2ZE?=
 =?us-ascii?Q?jniCkz5DcCO+IAGh/NfEdiIIsbWLqEXC9/IhbDzmDKjQ0nY9OxEGo/9KUIRc?=
 =?us-ascii?Q?EItuvcBHrCGncrbeaW41G6b86Fh4xNtoNoAO58VvmNAugNiavY20oGqzvwKz?=
 =?us-ascii?Q?Uo+yzKdvOwyJGPX3cTDuOvo1d1VuBTVYRbV57HkwaYzZQie1dy3bm4ZkMedI?=
 =?us-ascii?Q?M5cPs6fZG8G18WgCW/am3r3cn1571tmKNPr6uo/JCLjlelpfEF0cIYLjElzz?=
 =?us-ascii?Q?JcfvBIpGbVc/A1QNNO3+vEMMhzOaf0932MkUG/r/coPhpqfXjoCI4z/AH6wj?=
 =?us-ascii?Q?ffpPQaYyS92ZcjfAFWZSagthjEvxwcwMzGbbTvXTlDkHBJeAJnahMJgCrpIU?=
 =?us-ascii?Q?ESeekABPLXirANzAaXYTuvyYTGEnBDHs2rYfRv0X+er42Ca5xAHYQawAN5Aq?=
 =?us-ascii?Q?JxaLq5MiV0AQ9iDx4Iq8ojzsJoCmqA9fELs2IiNrhfRuByvlfchldPICphon?=
 =?us-ascii?Q?U97JrGQs4i3vE5vDLuJqnb6fip/0Xkn2C/03aLSBgGC3GLeZawueEjfoStBO?=
 =?us-ascii?Q?MoBmOKTKdrrdAcrq+WUYeIzfthcZJ7gCS86mhYQAjawt0qn4gX52NhyToeJt?=
 =?us-ascii?Q?Ny2NUzOgpQYHwSYKpQyA4762SqKgyJy7VHJzz/tXzl6qw94Cv4jjDXTS96n8?=
 =?us-ascii?Q?osvcKVjDqvV0nLOcs83LMFFCT4uKuDoFdqD/c3DOgxNAza+x3t3IlCkFk/zJ?=
 =?us-ascii?Q?QE2HUZSKYYhMOa5+m2eGY+Kcl58rKpGEwbNjLcHj/6BLOWIYayMCwOtEdCzU?=
 =?us-ascii?Q?/NA4LEii5brtaJ+UjpCXAs/96sX1a2U2IABD1sY/bjz8/kVsQXTxUzA1QL2r?=
 =?us-ascii?Q?TU9TIbHsTbMOXqeOEZvcM12udE6ESRV01GG22Df3wxP+znLo5iIV4IDfjeWX?=
 =?us-ascii?Q?1krJhmP45OgIT3s03cSbNKTyvSNSg89twI6flhycqllJKJLRjIXAVYQr7gJC?=
 =?us-ascii?Q?GNPODcOps/Z+1w+KKnbDWk6MoPvYUrz7xEuk1hujHJ+8wnRg6F6lkhOu7DAP?=
 =?us-ascii?Q?yDCTJNrUxELp55nhMaA1CKb5a9+yC2J39SUqybGcRGPFk8dZaBnjC+xSAyWf?=
 =?us-ascii?Q?LlZ7E5D0551I7m6sWprmFyQYsmiNaZudrLphdUBx0AMGILPbx3EIEzlkDNiU?=
 =?us-ascii?Q?lHzaqBUTHwQ+sJym5j5ldU0J+WMMTT+OhxvDOVKvZTNMOjlxYQoc9sjY7Vic?=
 =?us-ascii?Q?JImOdbC+wLivkcZ9OBktiTH8JmjpXKkNsNS/tSM56EL93t8HSmyv6Hrtfusy?=
 =?us-ascii?Q?8zKSicWwJ1HseuLktO2n7Qjsq3v5XDrJMDG9hpBqk+YoOVleCJWZwl4KpIlD?=
 =?us-ascii?Q?on4VlTzSvX5eQgFct7bWlCesOq/qIiU9YyL+K+mRlmr7qY57qknQ0RBrjzR3?=
 =?us-ascii?Q?qB0YG4+fqBImJbDWYInhHKgdwBXBsgG6TSz6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:50.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6adb343-0181-4fce-9c0e-08ddc3d39767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

There is nothing left the function does in addition to
construct_region(). Remove __construct_region() entirely.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 42 ++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4743421c6db5..edd1cd9ef022 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3356,18 +3356,31 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 	return 0;
 }
 
-static struct cxl_region *__construct_region(struct cxl_region *__cxlr,
-					     struct cxl_endpoint_decoder *cxled)
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_region *cxlr __free(early_region_unregister) = __cxlr;
-	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	int part = READ_ONCE(cxled->part);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
 
+	struct cxl_region *cxlr __free(early_region_unregister) =
+		__create_region(cxlrd, cxlds->part[part].mode, -1);
+
+	if (IS_ERR(cxlr)) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s failed assign region: %ld\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__, PTR_ERR(cxlr));
+		return cxlr;
+	}
+
 	guard(rwsem_write)(&cxl_region_rwsem);
+
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
@@ -3429,27 +3442,6 @@ static struct cxl_region *__construct_region(struct cxl_region *__cxlr,
 	return no_free_ptr(cxlr);
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
-{
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int part = READ_ONCE(cxled->part);
-	struct cxl_region *cxlr;
-
-	cxlr = __create_region(cxlrd, cxlds->part[part].mode, -1);
-	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
-
-	return __construct_region(cxlr, cxled);
-}
-
 static struct cxl_region *
 cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 {
-- 
2.39.5

