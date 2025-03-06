Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CC25524D;
	Thu,  6 Mar 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279522; cv=fail; b=tfBiqDPlwDYaPMe1X0RTz9VTBYJxS7yeBebjVmSLBSJiLkcbEkJgK4dZ9eusVsWomENoe4P+UFD/2qkJLrgqVZOJ56NNQdxT/HTeL9AeBKQBYlfSWjdvbgytFm5IhzV1IygHabY+ldCsq9cOnVnzXXXEDWZDcSQt1IhW2grVLfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279522; c=relaxed/simple;
	bh=WPZddSnoQ5xIt1R0pWGs5b9ptNBAArqsInfuxgxAlTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMTdgPLZVjOqA3zlO+LYbBQPuYa1NkNjlMwNOF+AYZG+4BG5zXyGj/edniADt47uUgtbOcjm5a4lpwADVSuxaHotQM8P6J4pvxuhdbMy40QKpvEZ4hOKPGEqS9SjnIuUalxXy6f5lhv7SbcjXgTj1LbPJkdSGFCSuFjsfdYmTa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lHaLM0JD; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lHaLM0JD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozvulBmF7F76Kwv54vI9MkStJGrjGKPvkQWZ9N3CRMMPnC0Q+K4jQ/PctefEvxbbNQS5b0o9Hyz2NwA1F3aoKMofEVHdNyADNW8OomXjIuVQ+nt9m63mLcaKOd+9MMFABMkcBF78S6cOknjdsUGO6RdOxT1drsjkDpiUsqIUKykBmmqdzQsXCf35gzXy824QWTWGGYv38oWE5pvV5vA9ZtAyGRY8EJnkvstKHRI2PhgQHzl5zgChkAlnNe+TPm2PyI3ajtvVeVCtg6MOaifH9A1tSZYRh8cq5KZ2sW1Gvl8y3raBlHLojRP+JuwW8BqS2G8PTVm8LK5HgSCe/nkmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlsWRYcKfZvWVL4jSl5LoLKtk8/TqmhwYkL15ITB4ps=;
 b=lzFS8aeR/yoBXHIy68MIVjheOS9WfuMBjcG6Vz/aEqEWesy+EmqnhB2fe+7oeN2qIGHqP+A0TnghlpU2sHLiCiv2NVjFJXqmSRwooCfYqDFdNwaQ3kBO7ct7FJZNer/kkzHadXYEnD3RNp5zemz0GJXCveK91xhr2UPn5/duSqGozJkQFxCPH0NkPtDNTZdOtEcbLSGLoFQ5vW8Q++aWfwxqE9VJYwf9sIGJVZk6gXnqQ/VrSjv6mqjaoAFV8HP9ir++5RoqSgi9xNbygkrSJuDj68Mm/fMRRqYEL+vbmqKvOTv6wEpxbw+I8FqNedhgyv+ZiIm3xMID7rBb0E62Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlsWRYcKfZvWVL4jSl5LoLKtk8/TqmhwYkL15ITB4ps=;
 b=lHaLM0JD5O7oJX3uOA+nYNLxd8vWUCEcQOO57ANogexlTKqX3a3vH7hXhM7R+TrgR8Ma9UueCtSE4OrCD64/FGEgpO02W+/JpaUGzViwHMlMiMx0/7+ZN0Q/sgb/1tmfGqrNepRoVbiZFZySqvTKq4iQ65u5rdNtlpqkeS8dQOc=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:45:18 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 16:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:18 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Thu, 6 Mar 2025 17:44:37 +0100
Message-ID: <20250306164448.3354845-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f28bac-31da-401d-2825-08dd5cce4710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1d0HcFf171UdEckYCMN3F+k7GfScEJ3CHCqxm1amP7woCHWPYxWd8HGVlP/P?=
 =?us-ascii?Q?nQ0GP0h6eYohe+F5oIekbI2DsQrmBE3D9ikZtfyv8UL+y9nP0MAnhfrtN+OG?=
 =?us-ascii?Q?Z0gcNAf1GT1aRLaeeJZQm3hu+1fdKrfnDG02x/OxniTtrvfznx+7wKZlsMNJ?=
 =?us-ascii?Q?p7471Oduu03wGX9nhLNjAKK8hlvvY3uFkc/C8KKUa3u4pbtihMaV//7IVAGU?=
 =?us-ascii?Q?VpQVLwkrxWXA2GV19urbZNTSQirzRiNHqErDeQhwN/Pe+Oyg+R72HIrWYHde?=
 =?us-ascii?Q?434mm2cAG15O/PhnR/EXnYyeKhNmjAhrx+JHBcdWWh8wb4UpSJjfRiP1f+7F?=
 =?us-ascii?Q?uRurdZJbvEjErbxGeP24t9INXtfB//f/srCAagbSSc6eY8vF4rA5eFw5vBJX?=
 =?us-ascii?Q?KVjUBHu43fxYhlcQGJLBrIkGlxnq9I5ZIlZpal6vHDjG9ye+kmOg4JbqQKm6?=
 =?us-ascii?Q?NqArvzrgsn47WLiW4fGrAg8wH8xUPkt8DjgRwuj45rt9XH7CHK32oKeECGD3?=
 =?us-ascii?Q?7+JMx1uMSHO316yD62QKxsdh2L70krJSo5C0vwAC2z4roay2oEyzbQZv/3AG?=
 =?us-ascii?Q?OmkAiVKFvMP5bkovxPQO3ZRZpHrDumWiKj1HSN6gIO/dxVf8ibjWpMCSXSuS?=
 =?us-ascii?Q?l6OLAysy4OXh488JEX1/Bs7L0bPBWjdYQ7hvHomrUioizpeQg6CI5z5+L+lf?=
 =?us-ascii?Q?wH7bYYvQHEE/OhNsKytf5PHji8YTTBcZ6ILLrJpWGzRRB3m70Z/+NSlpvIvT?=
 =?us-ascii?Q?zvadmwni7V8WHyQH44tEBbn0DwBvo85LnDLjyuFZKgn9pxGmqR+86H3uhOSL?=
 =?us-ascii?Q?vurJekQ6fvcaSO7N0fKNzXTgOEjXHG8/Ybbi6HZ7QMCJyEZWxa0FkdoK+O1D?=
 =?us-ascii?Q?OW62HG6haj7zvW61Kp/jLcqFfAFGfM+/PL5yKw14B5+uRfoAO/kRrjbtNFcb?=
 =?us-ascii?Q?SmQbCQK+07NSZS5+8s8NoffUoZZnt/JSXOeYZtEGZIhZdWCtb0bjQ94GpREg?=
 =?us-ascii?Q?EvaRDx5doUsT3VyPpmShjZN13p4MP2wHoSFvIaUgczmNdiYiL6Gfzk07NBX3?=
 =?us-ascii?Q?9W39RrYeOxf7S2JAPdB9AI5sfzIluJdeWB9pHAC3Hb7qS6R1SAF4eyZNGWVK?=
 =?us-ascii?Q?FUEjNpsEr2srAHag1yZJBV69xVYwEC9VtrUDKcGr6IxvMnYKoBKAh9Z7RdFM?=
 =?us-ascii?Q?U5cfVb1bQC/7c1hxUSV82QSTQw958bpv70e2kdrTm/h9GnnZrZH7bR815LWm?=
 =?us-ascii?Q?9EIE0Z3F5EyvkoHkicDmOvo3YnPUDdqcKBOR8RUHWCve68wwgMe5t1SqUWLh?=
 =?us-ascii?Q?zN/bm0MQgpWLY7rYr5pOyIWP+5AK9mOJbI5R+l/OyvWgfuwGypG+eWm7AU54?=
 =?us-ascii?Q?BY/KL/NachbibXyR15vUHwRHIwyIZiaix7GPWY0dXFfe7afk0T6pLvhFoz4I?=
 =?us-ascii?Q?L+IEJL3oqZmH0GIcQ3uNGythgEY/q9RFSrjN+30/HINI605bi7c9lRpiXr1m?=
 =?us-ascii?Q?YvUg7uolYbLhv+k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:18.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f28bac-31da-401d-2825-08dd5cce4710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063

There are various configuration cases of HDM decoder registers causing
different code paths. Add comments to cxl_hdm_decode_init() to better
explain them.

Signed-off-by: Robert Richter <rrichter@amd.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6386e84e51a4..ef4b08abe424 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -416,9 +416,21 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 
+	/*
+	 * If the HDM Decoder Capability does not exist and DVSEC was
+	 * not setup, the DVSEC based emulation cannot be used.
+	 */
 	if (!hdm)
 		return -ENODEV;
 
+	/*
+	 * The HDM Decoder Capability exists but is globally disabled.
+	 */
+
+	/*
+	 * If the DVSEC CXL Range registers are not enabled, just
+	 * enable and use the HDM Decoder Capability registers.
+	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -427,6 +439,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. Check if at least one DVSEC range is enabled and allowed by
+	 * the platform. That is, the DVSEC range must be covered by a locked
+	 * platform window (CFMWS). Fail otherwise as the endpoint's decoders
+	 * cannot be used.
+	 */
+
 	root = to_cxl_port(port->dev.parent);
 	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
 		root = to_cxl_port(root->dev.parent);
@@ -454,15 +478,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENXIO;
 	}
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
-- 
2.39.5

