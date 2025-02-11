Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F41F2392;
	Tue, 11 Feb 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267694; cv=fail; b=kE7vKb+SuZ4ilR9Vv9ygK4Z0GGC53/KmExITxd66MKuIzUsKvHlRlPTBSjTOaMHNZ4IE0u1y4UDiRrGkEIUUt0zJxHRAL8y9Q9KLsqdqOzdnIcq1xONU9cbVXQlhMyuQJdFahq1Yfx7lqQ1o12EjIGyERBgbCAu6l5zz4vbZ7+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267694; c=relaxed/simple;
	bh=Y5MyD7SzHix0diTgoh5fIfav2qg6kogMkIKh8bBgXhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka/FwmWRAm8Btitkk+W4JbFOhGTuiQ+YjDGI5ir74+MAhNhjUFdsrfTKtS8jjfwM1jQ8idwX6TD+/c6KsZRa9aaeL3FdYUKvkA86v+xdtx6InuiWajXbMRwLxt2jArcLOzW1C8Q9w0Nmd0roWPrM4ZluloF+/gc75cVJrpIhQWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YkAXQ+sc; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YkAXQ+sc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlv4Igt/9zA9q/NLKm+8Syezozk0yQCS7H6G+KDGQ59aXqqjroZLP9/z9FMWelx+F4dtG3eluYWet3Hc14v7nCgdEewDqM9k+7EuHDxHf/e279HA+/BWQWybYUAK9gFgCaQr7K+BnmtXw25LRWMUP14MvKJkEjGcJ7FbA1UC0v1OYLgy97TOVMeYCKsH3Cswp6txcrcIJ/7wllxy3NY/YZYmcGWdpSV/IH9yCpEUUe9HUAibXJirMK9cbGr+/7bncVXwyUISsup7pknP+A0+ZH32DeojfzdW8S1qurzPGi9Gn7xEp/b56mUBBsj0H5qZJNiOvDU7B6Ttc0hkVgKQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QsujJCdPttlfcwQAOfyizaly5ruBDmj1Klwtmt2/Jw=;
 b=Ja6hUUhXs5CHliOyrei7LFns8AvJJbdoyabXsXNIvK9uB7p6atHTx/ZOGqHehThuBm3Kx+827F1V+oOKE5/0/O/JsNqDNr3pkxWFv4EoJUzxRo4ek3LXcdwTVYDqvckPxQPCBHYuJwfulMT5QtCPDntjREwhuoEWBnAQlDeecEUiutdgXt7BBZcud7Tj76s9fX7AlRw87jEgG7BhX2NaVoNZcX+qaZpqX8Gar0YeNtaohCHbeI03M/MCizgd0gETkvwHXd83tjGBFSoLnXVmM7VRDIP9HXUI2AakLYUsrlYloi5cxi2b76X47TSffQ7ucvti2FrBbbinAeaIkeZ32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QsujJCdPttlfcwQAOfyizaly5ruBDmj1Klwtmt2/Jw=;
 b=YkAXQ+scAxlMEU8shWK2pVp04nuAsUxEawV5IFKSJVAK8/0onmjYscla89wouSF0EWG81jfu6cWcGsOwNNCxQ9Oy1onSakyK1eVsfvDluJXeselifeJ7dnxi0P3bpifynZ9hFG0AQWi9ETYr6OyctCzNLPjCrg6IoI5XkOVbs5U=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 09:54:50 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::80) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:47 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 09/18] cxl/region: Factor out code to find the root decoder
Date: Tue, 11 Feb 2025 10:53:39 +0100
Message-ID: <20250211095349.981096-10-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f6b9c9-32f8-4c68-f26a-08dd4a82203b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RH6LpehLn5xjT+OaSremXH4KgNj5HZMK5D6OQjanruyRckSBg1+QL8CbRB2k?=
 =?us-ascii?Q?S7sJxAMOCO/b+L6SV4aul5CymTnrGgrEUE9et7avI9HQ3ccAaq3pbKEs7xVi?=
 =?us-ascii?Q?IGZKrvB50EGRGmnSPkEUqfQ2hgr2UElUyUG53K4i4s7XRbsewiP0fQHtSGvC?=
 =?us-ascii?Q?PT0VH+MQSqNXG7fSyHcRlnZu5cIciKQQjLYjey5p/3/54RcCxQnx+BbOYMeH?=
 =?us-ascii?Q?plsHy2u1BtXtLr656oj5zzzkR/gx2i2vAzVkeMI8aNpkleJtLBbGOY2n9UMD?=
 =?us-ascii?Q?SfkfDT4kYtgw05lAoBzZkO284HhvUs1dKvl7HISC5+5qYO2XmvM1kxFe03zo?=
 =?us-ascii?Q?/g9PJ5bD2t6zHd54bEFoPoSKNITQ9/SDupu6lBhdLzEOOh+2knrxDHEvn8MU?=
 =?us-ascii?Q?vbCmypqjRdrD0jdGujEexKNNlP2ujkMoMROkiRMTxfuRGbO2zoJ5NMJrikyg?=
 =?us-ascii?Q?cmu2u+ZACJ3eRZK0GaMIhmjcqL2pxBAiWq6NvRqI6kTSG7g5+iB5t+kqs/ES?=
 =?us-ascii?Q?i7jBBKNQ8Tjr7YlGHDnzPMb7lMk9AK8o1I83LLIRoahMOygtCCzzdXE/irCw?=
 =?us-ascii?Q?dY08HojPLcS0vdw5i1txxQYh3p0jAOfbYamWu7Dq4S0OoT6FNSHNQt+n24Gt?=
 =?us-ascii?Q?uxx7IMhqyZOG+1xUSxDWDTl/jembQytUMjW8fPVwekhrmm4ISYONP9hBweDE?=
 =?us-ascii?Q?aA7S5mcetf5GSk/D0BUIQsGf1JlATgt52luEU1EM4AJhFOW+HAp/+iGVDOA3?=
 =?us-ascii?Q?yFBvXhNh8UWvx2J1dN11m8At371ek+E3FpXqt3CmiPgGlKXx126IUc5+6Y1N?=
 =?us-ascii?Q?TVZl1Dq8J82DBRMaCyUv3ahmaOV2hZ3NPILYmOdoJPcdQvO2TuhHwoRG6b4B?=
 =?us-ascii?Q?yz/wNo80DNdTL73mftRkekyAi90u54oJGurKceDIP9cDrsBF3Q9guF0CFxHu?=
 =?us-ascii?Q?b5ahmHSBO05u6yTeXTSana1pKXSqV5XD2kdJxyK+VmJnQTZf3XJbwMqILi96?=
 =?us-ascii?Q?cKHVkZNye1WmFmTXRyYaAmV1UHtgB/aZ8092rWhMq0Xtsx+0xhaOjje8aiXh?=
 =?us-ascii?Q?8NCE8PnbbbYU6KfWgMpOZxX3GAo2mWFnQaqGayMRaloq8wKND/eJ9+dSDFXW?=
 =?us-ascii?Q?ukkZDhmDQQ02srZkiAXCa3Ix7G2jLRWf1bcLOEhp3z4HqTIDQMGhviH7X1+T?=
 =?us-ascii?Q?fxXCvfk34IikH6HeYvVIDWeBoSC0mi4txfsCnUwKsWJEZecE/t0PuONSpd0u?=
 =?us-ascii?Q?DHkwbDFs4rOjiI5eClTQzIuFLaRvKNwKfeeESEEtbxzNnkJVFUn8qHvn9e1x?=
 =?us-ascii?Q?+CWMfvJvl18ZJDFLUXtJhXWiqizg736u+vgrY8XSTwtXwTx+0vC0Ivpg+R7Q?=
 =?us-ascii?Q?UzKdXQZ5hLb9BVPDOk4NSA6ewIFRA4CfX2JgkVRvWBftZ/rDYDILb74PPmDI?=
 =?us-ascii?Q?LZ9EOu1sxVIW63ujSrF/9GQ4pL7xGfr/baHriDh9Zuac/jD1IE5v7b5ecf6+?=
 =?us-ascii?Q?ds69zxy8h2OWF48=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:50.2700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f6b9c9-32f8-4c68-f26a-08dd4a82203b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

In function cxl_add_to_region() there is code to determine the root
decoder associated to an endpoint decoder. Factor out that code for
later reuse. This has the benefit of reducing cxl_add_to_region()'s
function complexity.

The reference of cxlrd_dev can be freed earlier. Since the root
decoder exists as long as the root port exists and the endpoint
already holds a reference to the root port, this additional reference
is not needed. Though it looks obvious to use __free() for the
reference of cxlrd_dev here too, this is done in a later rework. So
just move the code.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0e38bcb43be6..c641c8922455 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3203,6 +3203,38 @@ static int match_root_decoder_by_range(struct device *dev,
 	return range_contains(r1, r2);
 }
 
+static struct cxl_root_decoder *
+cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range *hpa = &cxld->hpa_range;
+	struct device *cxlrd_dev;
+
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+				      match_root_decoder_by_range);
+	if (!cxlrd_dev) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			cxld->hpa_range.start, cxld->hpa_range.end);
+		return NULL;
+	}
+
+	/*
+	 * device_find_child() created a reference to the root
+	 * decoder. Since the root decoder exists as long as the root
+	 * port exists and the endpoint already holds a reference to
+	 * the root port, this additional reference is not needed.
+	 * Free it here.
+	 */
+	put_device(cxlrd_dev);
+
+	return to_cxl_root_decoder(cxlrd_dev);
+}
+
 static int match_region_by_range(struct device *dev, const void *data)
 {
 	struct cxl_region_params *p;
@@ -3314,29 +3346,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_decoder *cxld = &cxled->cxld;
-	struct device *cxlrd_dev, *region_dev;
+	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+	cxlrd = cxl_find_root_decoder(cxled);
+	if (!cxlrd)
 		return -ENXIO;
-	}
-
-	cxlrd = to_cxl_root_decoder(cxlrd_dev);
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
@@ -3354,7 +3374,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
@@ -3375,8 +3395,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	}
 
 	put_device(region_dev);
-out:
-	put_device(cxlrd_dev);
+
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
-- 
2.39.5

