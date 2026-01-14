Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF63A4F29;
	Wed, 14 Jan 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409375; cv=fail; b=JmZjCWaVo+AfkVMkV0TaAz2K6K7uaz4xMSEsTz4tHQb1XUMNNqZpYyA8hCG5CV49aQQZtmeCnDVKX9gaj89jI1AX1Qh2I5DcdxKhyFdBIX48TfNd8UaBCSdE+txsJOz8E5B7VlJgXegc9AaGAjVgV9hXgA13d8Q2v1oLxshWCPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409375; c=relaxed/simple;
	bh=Rdzn5RG8r55Jz4OAE6FIcXYQ9R2LKeQCPJmEfgh/JuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEfOR9BF2xxvfD23XQjtZRRbuKLcJtX8iBw7TTsui+UiQpJaM4lmB6kFRv5m/Vuo1B7leZftTAvdkCE1osGtSrNVDGNSOTWw/xjjB3sqwdKWA0M8MRA0Aw07Wg1uqvbU/cPsM2ZWUAKCqFWyDNg3yPq7nPCZ45OWpUFczwXqPho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d1LdVVI5; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d1LdVVI5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWJT73qglpeAuT6Ka3kogJ9gbwyN0ITtidcAg41rvSGEJ0/TGrEW38HCIn3EdfMupM+urzgH6Uk9yCM+V28zT+dk4DR6ZnuZ8h6nd6c/TXayE4DThPAdalGBvXkZCKgyy5D0sSoJxFCo97mnskfVRzcsBfHQZpv01pg32qrssGHfa+88Y1nr0VinMc68wyU5w1LyyqhoZ4ESkYvGP0+9JGYKtmMAfS7bQNhX2mIhgEaUlojRW2/KCx5NgVz5tjDZvIJLDa2u2nga+eSjLaO0jT1YkGNrtCR40OFGIOB3byf3ecrn7VPzyyxFeMp6SKNmxPkoBFPX/GgGuEYcG6y+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ALj0oluNqm6lY7NXL6PkLUOkvq/nPzIV/Py/V2sR30=;
 b=rEDEHKAeEcqEuZ/QrKJmIkrYVKd13Xlp3kj59NuasNXgs6mAzmfsDI7NfkCMn4RA9NechwtEwG90COx1Nv1ag7aVGKSnvYsFKGd2ztsmh2MTvb8GjQIgEAYDVHCtsV8LkzXkpvoTsIFggU8LNfQotSrLw6CfVEbyuO/NO+cb4bOfaG1A8JYru4fSnv8m+gB5m9Bh+JLV8RLPyS4fLKnFq82R5+WgR72+GHj4ah0kYMRVqZFRIKoVJfNe5ZTD/Q7+J9VStLD5bCXBpv3SXcj0Kdk7L9eNwSyk0Lihb587hJ0foO5ZgzSIiRiBpojvCdYNmSygqsFl45Ncpii5FP58dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ALj0oluNqm6lY7NXL6PkLUOkvq/nPzIV/Py/V2sR30=;
 b=d1LdVVI57POjSqkht+zwDb5ruE8ZWYJS+Ru9ty4Q81U6+RAwvkbpcWpbkH46A4O1VwA9em9IihBNuRZZ7AoPXeh2NCo68HiHW5v64LvDB82nU0ETu4twLtHkdsTqGkPMSJSyL1ZcfE/QLY902HIfqzj9SSnVdmoCIb24/P3MIR4=
Received: from PH8P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::16)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:49:30 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::d3) by PH8P221CA0001.outlook.office365.com
 (2603:10b6:510:2d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:29 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:24 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 07/13] cxl/region: Use region data to get the root decoder
Date: Wed, 14 Jan 2026 17:48:23 +0100
Message-ID: <20260114164837.1076338-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a010890-1423-40a3-1f4f-08de538ce2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1OSSrHayjytNRGKmFUnaayBoMTke8hv+xcCrIJ69sQ0ablkjDjs60+W/Hibw?=
 =?us-ascii?Q?QFsV5jh9tp2e3JBMOV0vH5uFxE9y88kRq3tPEBpDPVo6TJu3Jgg0yL7R3Ezx?=
 =?us-ascii?Q?CzVg+kEF7UlakdI1Wod8P59rI0Pw9a/XmBfhWkkc4sodI0caHZliK+SPiCIY?=
 =?us-ascii?Q?FIhurdjlHn0z/5wZ8V3eC68dO6v4am5aNMawUu1/cZYQj79GmWOR+QY6wgpZ?=
 =?us-ascii?Q?ZorAfcszZFrRptbUFhK6xBYrzYdLLo1wRLURv470iq0l0gYTgqk4lCKDsNgs?=
 =?us-ascii?Q?R7DUV/fYLMQJSENR0o+AcZ1bFXOixX3CcvWHbqiv6/I/U0U+wtEbFwqaIBQ0?=
 =?us-ascii?Q?uZglI6OJQNZGcpvN6Mp/1O1l6ePCJBbzRdmDgm2XA3TovDYwJR0FZBEjkBm3?=
 =?us-ascii?Q?hdu1QJajo0q+Ho54JAAzuNnLZv6BnBUANsSxePHmJOUHi962zHImLZSVTTuS?=
 =?us-ascii?Q?T9EBOW2T5+7NfnFK0pUedf17dzyofg7GrlPPpMQ0amp0G3AoAPyeacOcK8KN?=
 =?us-ascii?Q?h/JMK/jj6jcWSpsqWWmCuxk56DoiqBywMnuX1DoYru1XGt7DHIb5hkJSz8Y9?=
 =?us-ascii?Q?YkF8px/ir7WZZlBiMWb+ZXF6wSW3NMLR3Ahrt2QKTLMVHxUPQeqRuyTuORbP?=
 =?us-ascii?Q?HFxbRdSswmRkFG6mw/feD8LsAOe/SK6sz+xvojqHYdATBOqYFzmmB6iKYA4f?=
 =?us-ascii?Q?5u51YasLptXerJRVcSrD/W4hmS959YSP64h6HYhOU6tqRvfZVEIyrivOrVTZ?=
 =?us-ascii?Q?JxG6vR1Yet3FzTtJSb4tjVU/Jjtg6PPMpKX5DYEA03v3P3BXcq4y/kypxlkp?=
 =?us-ascii?Q?nGmm4yjq1wkdA8/ez8ujgPD4rZsOMTxilqb+39zbFsS+aEm/mvJ3guQsWHGL?=
 =?us-ascii?Q?MYApYtcaYgQ0y5YezOsqH3tQ84RhXTn72VUk0mPyTqvZztgLqXk9xs5lwEFy?=
 =?us-ascii?Q?1sb3RtI/VWVlxbesSBt8+xhP4ZYqvzh31LkibdjdRVa7WaXohAK6oeF2+l2I?=
 =?us-ascii?Q?h8/wF02KTE0/Yzvh8El0SK+IsavZSyeBFWXKUTd6MZYQCPoAMaesteqhBhVL?=
 =?us-ascii?Q?clUsoLfO7UsVwG6LyOrdT5+NmGFdQD5rYCPXbKo4m+TsUy4u+Z/yG88nfFnY?=
 =?us-ascii?Q?+HnFCjFcNu3UdWv6cBqGLMwloiEA9dEWm3/xTePVRsPwciXCVH1gdeLwe6XR?=
 =?us-ascii?Q?DeIxvdb7UdAeU14Jh2KOYV6UWO9NypSe3fSOh1zSoj9dDkXE++DvP5IekguC?=
 =?us-ascii?Q?Og12e1vJ85GGQcxo9Z32o862wTpDxNtA2g40IgcyBz4ndrxh1i4kiqNgKkfJ?=
 =?us-ascii?Q?izmH468zlDJe2XX/F0xXfLjPbY97LVSW/aPI871G8gw1R4kGcQN/05LPm4WU?=
 =?us-ascii?Q?/hIVhOuenxWAr465KWOCeGpGDrJH8WxMUcPL840r8m2oFI8fXoxyooroPNdp?=
 =?us-ascii?Q?9U9sV79NcmT2EweHLX546aW2kVcnPuyxrNsFepOtTpO4ii6fPeoYFB5Wfif2?=
 =?us-ascii?Q?2sVxECJIzI3xCvvwDkBPJ3nIyCIVcNZq1MR+BMAaW2IPu9PGDvirc8G701xB?=
 =?us-ascii?Q?Nyo9QWhaRzAGMhzkUnBJtSJ1rBxRPgnej6nBTekdfFuTRMXfNGV1sYYGBm65?=
 =?us-ascii?Q?XCD9MHwORYhYFpJpwSTGcDNdpeVClsFDzXq6SJ7toc9k/B5L6T64ZD4Btton?=
 =?us-ascii?Q?Fmug7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:29.6824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a010890-1423-40a3-1f4f-08de538ce2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

To find a region's root decoder, the endpoint's HPA range is used to
search the matching decoder by its range. With address translation the
endpoint decoder's range is in a different address space and thus
cannot be used to determine the root decoder.

The region parameters are encapsulated within struct cxl_region_context
and may include the translated Host Physical Address (HPA) range. Use
this context to identify the root decoder rather than relying on the
endpoint.

Modify cxl_find_root_decoder() and add the region context as
parameter. Rename this function to get_cxl_root_decoder() as a
counterpart to put_cxl_root_decoder(). Simplify the implementation by
removing function cxl_port_find_switch_decode(). The function is
unnecessary because it is not referenced or utilized elsewhere in the
code.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 60d2d1dae2aa..912796fd708e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3469,47 +3469,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, const void *data)
+static int match_root_decoder(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_decoder *cxld;
+	struct cxl_root_decoder *cxlrd;
 
-	if (!is_switch_decoder(dev))
+	if (!is_root_decoder(dev))
 		return 0;
 
-	cxld = to_cxl_decoder(dev);
-	r1 = &cxld->hpa_range;
-	return range_contains(r1, r2);
-}
-
-static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
-{
-	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
-						    match_decoder_by_range);
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 
-	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+	return range_contains(r1, r2);
 }
 
+/*
+ * Note, when finished with the device, drop the reference with
+ * put_device() or use the put_cxl_root_decoder helper.
+ */
 static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
+		     struct cxl_region_context *ctx)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa_range = &cxld->hpa_range;
+	struct device *cxlrd_dev;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
-	if (!root) {
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
+				      match_root_decoder);
+	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			hpa_range->start, hpa_range->end);
-		return NULL;
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(-ENXIO);
 	}
 
-	return to_cxl_root_decoder(&root->dev);
+	return to_cxl_root_decoder(cxlrd_dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3706,9 +3703,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	};
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
+		get_cxl_root_decoder(cxled, &ctx);
+
+	if (IS_ERR(cxlrd))
+		return PTR_ERR(cxlrd);
 
 	/*
 	 * Ensure that, if multiple threads race to construct_region()
-- 
2.47.3

