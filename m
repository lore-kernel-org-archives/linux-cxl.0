Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E923FC62;
	Fri,  7 Feb 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942734; cv=fail; b=s9f3D2GUAb9j1puNvph26G/88wQbpjHQbF7ICemBVu6FXr4asJchZ9zW7o58Ky86ODKKJ9CUNqsbnFszrJScLFwQVCp/fBZT/WMVDsu9bk0ZlW7oyMnTey5Gs9Zxso3VLklN35U5kSBCm+SEXbyy3wjdUAKES4vwsOVVYr2injc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942734; c=relaxed/simple;
	bh=hiHgfhtRiN6EczvP1uc2hb2K049fvFaWnJB0mMOtN1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEr6l4kFJ97oENBhhTwou1YKIi9TkBQeeX9d83Rj9LSRaKjTtv/NPwIejluuB1SGAEmZqdxjwKSTXjSbW46E+QOk3b3FqwUdqTvcvabS8X0mLT0RsuOYoy+95TEF9TXPaZ5ygB5+to/S+NtT5/3nweGAhgy9efbyU/LEBJHZtsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2lCJY5D9; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2lCJY5D9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjRDcCI5UgOvQuCfaj6yf9DvskG0lwc//7b/wqB/fdl8UZz0iDvg997Ma7s11CIn7C2nA7g3+6fPfdNgpn4hkSVV7sJgDqr8j96j8n1qGsU1YUlxo6lmWm858yiY9xvGjfsA5gQ6buc3rrHST7OJOPiGafdB+PraTo/KlZPNTVIsQ/4FAXdZcQ1mCQmQU+dV0Xsal5nFgqe2a51Tfsqaa2l8gMoVLqrnRleovDvB4Bgpvvs7ihhpJmeW3UIzmaXXtDTYfFZOSWewv4KS/p3CTG8MDSzRHtVPwdwjEuFxgUPrrzquAPh++7cdpFSKf3kB9AuLC9KAxSql772dCLl65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96oaL2/DdPHzMeZnQqUNr8mn/Qdhf6WuSlHr2OEY0t4=;
 b=OjKHRPL3Kg4FLRG91GZ20KRlXPxXkFuXwjmvvt6mQKRxzel/savm/bw3RBWy9lSmtSla/ALrqTdF9XIyJA6RwdTie6lJhW/v+MmkgbXTHg2TGOt0WVuSNbOehekL5whT9OpeidvAk695rSBcZtRmF4L1TjQjPY+dauGZiJ2fB72PVRTE1DqA7ovauG2qMT6jhZkpEMzuuEKwbgAToTikau5edJ84fO3x5dF4/t1jOrSsThxf8s1Z59FhrvEXWksjz4KUCwY3wHv2ek6mKgklk9cDA6iRZQ8xbFLM+ev36TWleIFivH4+vpIZz46hbFeCvh9XjpB9lqQvYA7h/j1GxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96oaL2/DdPHzMeZnQqUNr8mn/Qdhf6WuSlHr2OEY0t4=;
 b=2lCJY5D91zYJHUjFa7cg8Vds3YQ1egUWYGJbYNBozNVcup4n69rj+CCEfA9GUqa19t7u0RuXficMUVvwLsKeILYqoqWb9OCvMwT+T7OpgfAbJns/H3iuSDKGmeYhZ0ZAWZpwbs1/m3Ct7HzUTsyd1vwxs7RPf3e74kC9YYxCUaQ=
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:38:50 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::c8) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 15:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:49 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:45 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 09/18] cxl/region: Factor out code to find the root decoder
Date: Fri, 7 Feb 2025 16:37:44 +0100
Message-ID: <20250207153753.418849-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: a96faba1-2694-4bb7-5c10-08dd478d8471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CAvOFUwa2GbBOqIh8xkWTWzLsE7ZsQIEGnW/Sa0Z64C+wmq2L5WOX1p7dard?=
 =?us-ascii?Q?nvumP8wmG/YCIZbYHQBboNiOlGsOloKnVK1O9lE5a6LOuPyOeIrrr5Tjs01C?=
 =?us-ascii?Q?2mJS2COEZYx3i8gD1VvqFiotJmoThWVQmQSGIVYjxe9tZCReqJiQwWrgqXyn?=
 =?us-ascii?Q?rVh69Sv4Dy4Rkmq0Ct1QwPQ3tC48RiAUCFXCVT5io0fODxE7Av12WxeI3Yn4?=
 =?us-ascii?Q?UaA1spuwHvHzWtnm0M+1xYtDCHbzQAQDHMLUe53R2ZLDNchphFbb5QIg22d/?=
 =?us-ascii?Q?WOywbVkDoNOZjhKxsH7949ut/DENc/pg2ZGzGvZn7Dlmtsc6g8KJ4f5zl/cH?=
 =?us-ascii?Q?E1TBnFFxcyup5ETFrlu155EaHSbd5xdQW8zTaSMBeHbT37p5jTHwbsvG42Ns?=
 =?us-ascii?Q?cR4dig+2oF9ChzXkoXKzSoHr9w2vIhNe77s6yUKhCpRwdAONcsuWmdybONl/?=
 =?us-ascii?Q?Xddqe2BOCYE88Dv1omHCrN8W1H3L2KEOSa8b0Nqa3E+/wtKmkrkmbM/p3euP?=
 =?us-ascii?Q?xzeOwCCDKFsVyjFaH4xcO//G3iHv19Ki9XiZdAiY7XOADebl19rOYOPOXYBD?=
 =?us-ascii?Q?EEs09+rAkbNKmKs2+DxGpcVAzotFWrIq1TZZBe1ky4jpft+isbIGATor1s4e?=
 =?us-ascii?Q?RRdyuQRMN2EhOYAAKwVPPA3bcZr/TWmd1esMG4sRTCirBCcBLWEBxfA9J6MM?=
 =?us-ascii?Q?5/+iTKou94UZjBZW0+EJNyHCwmcT2iHzBqiltViGmBROeZHk+merkvIuK1Wa?=
 =?us-ascii?Q?G96buGCYpZ0cvpse6MAGFcjs4U138ZveNirakFQ6PrJFGDM75rCf/WWRL8K5?=
 =?us-ascii?Q?eutLI/b1QaHkYdPt2fuzj17Ix4w9ckfEKduuyYvWg9OSdeIOaNhOYCb4nokY?=
 =?us-ascii?Q?etlPL225fBSszh5NdYhsMQrBgABNNSsgVjCGuV/e8Y/zG2YmHWFBmisZUldZ?=
 =?us-ascii?Q?7nRBKwL4wnc1SIIjAR1iDADYsj4PR9e6rHbakmmcogE9hPS4cLfH0WCkdJuh?=
 =?us-ascii?Q?BhL4nuvwTE7fAZ+pjnnwZbxmOXm+WnwLVZibRtR10RWvuQ+0sHtbNObUxDKO?=
 =?us-ascii?Q?+2ORJQ0zzH5k2XmpiTL8/4+zb9ajBqtUfnv8HPUVDEuYzVBQbf3oe2/4MORt?=
 =?us-ascii?Q?MJTw/Q1t3y+NRux6bsfUTdrVlX0M/mvWUNbEDFNysbYIvSYPWGnV0jSiXLAu?=
 =?us-ascii?Q?YrEhkXDPuIQxICuUG6HqZ82OcehxYEgE1eyGW418Kf53Is2LS7c/X930HTeW?=
 =?us-ascii?Q?v1C0RvQaNIq7cX9MB2pANp9Db4lC7QGyxm/0Ft209vQjURv+2MPrL4HL/eJz?=
 =?us-ascii?Q?xxfe1QhwniIQNJq0+V4X84thTIte4Q6viDHgd3+y7FwC7IMnKKSxysf0ioao?=
 =?us-ascii?Q?JN6PO9VLr9e4pC2FGm3FF9L0D3G81O496/N0CKcAx8iGn966qECKpa9Jsc0j?=
 =?us-ascii?Q?6ANZZ9NFwqu7XvjOWBW3wf0urthKdXtfrLCps9CoA+YxTkM0v2XACdiKhGJE?=
 =?us-ascii?Q?1rq6a2TYEa8RaBM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:49.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96faba1-2694-4bb7-5c10-08dd478d8471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

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

