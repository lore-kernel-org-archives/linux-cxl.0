Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E252451D1;
	Fri,  7 Feb 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942724; cv=fail; b=YejyuWFFQ/YNuyptWNqfPKbrrb3toYTCgvDNphrgiX+1frhUou5AOsJcPylhqfaUvrFrGOCOaQLcTuWx+E1/lUHqinOprCZmlK5Uryc7BjD1kZhDrfeGqH4m+gAe3rvaV7DdiEuYtzcgTpbSRRMh5Pxotf9iZChI1qfIyn2Coj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942724; c=relaxed/simple;
	bh=P+GOyHJrmZ20apYZCMRpPuQz2k1tboqLxRGHRTMTdMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZP4BV10yzbZW8ipuhRETjtr0naVCU4MlFEJ+93VthygmJ/Hsmh7ztJG70ob8I2Zla+ml/WgDsJFjGhucBbQZtjEMUg4wmy2b+7BqXHLs6/NpgvIb/0+gogAulgatU3rjhOjzZmgnBKHe/ZlYzUFIjVlA0hQm1y0rLdKVEUe1c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=25iQRD0c; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="25iQRD0c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIb6ocuxeFdvQROquQAT4pfKyGViEf1WJTFnm3YjOA2U+ecUeil/DWGxaAmDLMqK4zPqVnvQMiWpkibx8IRtsBpVv6IyStVOdv2PIwXZk8rvSwY/Zlzimegl8BRvtABjsw3l/z51XqU2HXhKoMb+000u5DGX9TSfOtxfHhcziA6QDThVWO4tw8GJbQ1XmoP5w+11cVWgGMbRqd975vN9L1HWHi80kcM21n6ScPB4tE/L6rGmgFLlMh+jd8lm2idPeFi94nXlIWtiBvtNfwd+6GXEDdX+t3L7WpT+EuQ6y7QZb5E8TZIizGv7RV2yyLZCo+lwXvH5zlrg8jaZMpiqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5d5NSPOavwW0hA28P4ldcuJA6Ho6BmwrdgySGQcDyw=;
 b=CD53P4v2pys8pO8k83WXib1KYWy2TrK1GDuDVNs+hqY42qAqZASHcZzjdErQMJ1GvKIfBtzvRGkKpwt1nr/fN6Lstf62QdzzWIA2M8n/vKR56Cgvp3ydHPiA8g6fLrF7KIw11X7UXCPHkhXxjcd3vApuP5aqcuT5OohFmP6mVfEXYZtm3YqwxKPh/cTkcQNUmDVs7X/jLeF+eqRQ4D2QCwLwdRP0Zd2Mfki+/1SpNDu33dVk1veCIT/eGktWlKpmFvsYJiY161siX/FjL18E/SemtQ/2MCzzbKtv7uMBPcp++K18oUNgPlVleuPacxxj8kNIdKoTxUcl1sF17HuUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5d5NSPOavwW0hA28P4ldcuJA6Ho6BmwrdgySGQcDyw=;
 b=25iQRD0cRB/sQss1iKUOePeToCdz+oRgZ5N5FNXLkw9CIzTYb4VkFaKP5qOi58sJ7kW24GnqhEt/NJB04FrlT7M+SL6l6ass6CBcxjmDVEoMdHuRPRWX+7ekQylXIzo7xnYo8Kh8HXX0phgN9ryTbmaw9K7OEmJnz19iIf6OvXM=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 15:38:38 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4a) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Fri, 7
 Feb 2025 15:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:38 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:34 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 06/18] cxl/region: Rename function to cxl_find_decoder_early()
Date: Fri, 7 Feb 2025 16:37:41 +0100
Message-ID: <20250207153753.418849-7-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 17750ecc-58d6-4d93-9353-08dd478d7dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uub1YC17GaWx5bnOkyhHYRd50usWhKFhgqIr2IE1dxAub6VFPyH7MaKDHQGz?=
 =?us-ascii?Q?ROtViEPN4Yj+YOTgqBsGgogkvl1Bhc3yWJeiV/0HGEEuFHql2S6fzhCz1WZo?=
 =?us-ascii?Q?CDI5fNAtmV982h0mOxM0zywk3oV71NNx5p1JNzKrJ6VzQznqMeLy8guvaaXd?=
 =?us-ascii?Q?bFZove5nkwA1f07bpU8jtozm44dahp2/PBYwdJSKR0w9Mb8g4wRH9h7EV7cA?=
 =?us-ascii?Q?EerDDcEmdF478N44Sd4b2rNic+2FugaMOc6kIXEUvqlYG2qDw124A2jn33kC?=
 =?us-ascii?Q?CtBcUrO5L7XkEzjvuxsl/x2eNVzwFR+oDVvHkSNaGs92AQ+Egw8gJa8v16/C?=
 =?us-ascii?Q?/PEhIrczBQnKxu27s8hXVHbKMqpijdbTOQiA8SGQTZoRqO7/hhEFSbhApNlC?=
 =?us-ascii?Q?3sJ8oobRKM5hl4E0CZlY9nZehypdgspsW73PEmz40kxzjwXgNwb2KFg/Xz6X?=
 =?us-ascii?Q?67CImZgQitvyfWV2gMj1R6gqhYr/iNPIDhi+rnrytHNghActUjY9BgaLmdiD?=
 =?us-ascii?Q?K9sjojNssM0VsMYFL9xS/EF0ap8koy8EqQQQ1hTHo1KYvRgUK9p5xh16PVAd?=
 =?us-ascii?Q?VZLWZ8TFFA8zlFoToW7Us6/Rey2d0hf/hLZB6HXQFNYxXbstNMzxDBmA0u79?=
 =?us-ascii?Q?+o9TS4qtjcOUIwXSYnMa9AKEzbthhz5pB+znUOvvJHhz9I4WuNK2ZSDLeOnK?=
 =?us-ascii?Q?95lCn9naLEYhRvdDxcReo+Amxgh5cavDqI1CLCnQt5KZKscWmQQ9yOUKx7mQ?=
 =?us-ascii?Q?2vXI9twSx0rgZ9ZGw7Wu9A52Hw9kuD8DftJNNadF/y7wJGBCfG3u2XyTMkf3?=
 =?us-ascii?Q?uWBuJ69f2zmyvDCb9/nqB9YfoYiXRKGy3G6nudsMNMb4JAnHwHerGfKPndeV?=
 =?us-ascii?Q?VU0oO/v7rp4vNsLLHSC9V1P8mvjRGq7DfMvvl5/jWEYP5lLMc2MWHanQnHAs?=
 =?us-ascii?Q?t3H+b8E2M5FRT8xQPWQr0tH4PyX8Y3uC1hlDmLFEFvJKSg8LDv2M/mqLY3c0?=
 =?us-ascii?Q?3Kz/ARFRmas1ABVF/EA+eU78Gcq/s5rmRqU9MSAXeJ6wurlZDjvbAXOhNfRQ?=
 =?us-ascii?Q?rx0rWQ6R/zZCIibaI138Tis5lhnxG2ula9zMFndD2v/mzmLD3Tn0auwWmuSW?=
 =?us-ascii?Q?zWqyziXX+9hMP+5178Z/LDYYJamCzkQhlhPRzTNVpCYUIxS0Eca/zzOJkalj?=
 =?us-ascii?Q?90n+/oG7CbQgQphhNhgQJea4S5TXgQ+S/WmTIZaE6eCZXvhw/76Sc5zHj/hx?=
 =?us-ascii?Q?0BaVvZAwOsondQgOdKaSqZIaSuX6JgNlTCi/AmuuzJWch7Est+EcpjtBxSpk?=
 =?us-ascii?Q?451XvncsgJHbb6mkxKUwPTzn5s7Vwxk3UQe6rGk5ZcnweOnMcPcPC0YgLWCY?=
 =?us-ascii?Q?jI5AUvC14e/j+I3VZWKExt7xRJnhBkPHZAlWPifnEdVfPFetRFXQK+YGR0+8?=
 =?us-ascii?Q?dBuysM0U0ixw94mVHulieSQgiRX/x7icMqZMmpgndrNfaEIf5TU304zcCF/h?=
 =?us-ascii?Q?oLSqASpjqfIwgIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:38.2156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17750ecc-58d6-4d93-9353-08dd478d7dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

Current function cxl_region_find_decoder() is used to find a port's
decoder during region setup. The decoder is later used to attach the
port to a region.

Rename function to cxl_find_decoder_early() to emphasize its use only
during region setup in the early setup stage. Once a port is attached
to a region, the region reference can be used to lookup a region's
port and decoder configuration (see struct cxl_region_ref).

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 54afdb0fa61c..13e3ba984a53 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -850,10 +850,17 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+/*
+ * Use cxl_find_decoder_early() only during region setup in the early
+ * setup stage. Once a port is attached to a region, the region
+ * reference can be used to lookup a region's port and decoder
+ * configuration (see struct cxl_region_ref).
+*/
+
 static struct cxl_decoder *
-cxl_region_find_decoder(struct cxl_port *port,
-			struct cxl_endpoint_decoder *cxled,
-			struct cxl_region *cxlr)
+cxl_find_decoder_early(struct cxl_port *port,
+		       struct cxl_endpoint_decoder *cxled,
+		       struct cxl_region *cxlr)
 {
 	struct device *dev;
 
@@ -917,7 +924,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 			struct cxl_decoder *cxld;
 
-			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1005,7 +1012,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	cxld = cxl_region_find_decoder(port, cxled, cxlr);
+	cxld = cxl_find_decoder_early(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.39.5

