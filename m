Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9652356A8;
	Fri,  9 May 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803305; cv=fail; b=CfvKVGKBLh3nX34kdvBzwjLleoM7x9JKbpTKXHf3WYxruyX/+kzJUdUlNNF6R/dpwLL48N7xzpnl+l6qFpPLOlz/yOkRaA1vXJ/pth/qz05pvaLMHoFXJqfTJpU3//DjABfIuEdv32QEooryCHiuJJQGCbL15X1XZlhhLxIhgh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803305; c=relaxed/simple;
	bh=EVY608MSRGAyJg6soKxpzCSkhW3eTBd4swI/fO4HQr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL2LNCb2XvNk1NwSsOQcrjzdQjTVIJfCrtjaPlwrAXsMRMYurdQaF4FnqjgxYIPF+nf6/8Ul2ozUbb2SMB6D8PFxDN5Rkd35rwtLcDwakpQb9PZwCdhEfcaU49jgUir8F13g8goickZnpplJsiMYezPK8wvLgXMUA3OC5ewdqmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GnHCz8gS; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GnHCz8gS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egc+F+5w1WGAYr1CQNMkP2VYdVocIqG0P9Rv7wn/ebX8aEJ+jO/bQlCcLVCIYwFHLAbuMZ6jBJkuEuWK0HQ9HWjzN4uejUmJ9msrkDLxfO41ZuHW6rpkajIB7zGwJSoiUf7rAymkS1Pb+DtAsQPms/bZQe6GJPkNRzMn9svCxYMMLwvzWIHLn3ivZxfACSZ/xGK9cQzzwFSCnrikB2nLnwynx6LHOyhXhWaUKDeu4OH0dwzyNhAhXlgeTFkOY8JAnc59ootYMJsYy1s8RQgZer0+LENwboJOnpl0m+qsK9VeT0MiMvfxsZ6ZRAXL25DUDsO51zH+8U9B21ClcqfyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt/5lYbuBYr7QnCT42EKg7CM1j0/9ElH/ZocySjS8tM=;
 b=mgEJyLuk6eOlkgyINniJZ9vldDCs582kMQzo5Y4c22PYoHSqZHjJHnXqTWz5zGm2l6ejH8eatmIjLdTRflgaHErlAKMIUhpWKP6hO6upRE+YF9NM9j87n/13D0Sb/62K/6UathChJbJd0nEpYWOEfSnNQX2dqO5Jj+9WsK49xZqgaTJ60dsiRqooBHUyHBlI2oci70h/UmjrGHxMiG1c5UhV9aJx1OyTeFiXviFpDG9mFpvQz4B0TjB8HkkR/pquks25GI09dF9cZrWNVSbULuV59MhPdPJxPgVo6fGVN4myRxujYKKVm+864/2Dq/rHZGznoeMGAK8lvfsZP/lteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt/5lYbuBYr7QnCT42EKg7CM1j0/9ElH/ZocySjS8tM=;
 b=GnHCz8gSm/YiqZEz1gnnyFh9bJX18KGrd3vRSzAF9aFSDf9zeaGTciXvJZTbFj9xyLTfO2SQ32c+aEhVDixwhIxlIEeZtE6Nr5QsgQ9SOpQcxN2XQzz3EdaQK2AJDhSnCBb37U+VIjwNCndDuYjFcYBzb0KkAmlqOfUpe5Ucveo=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Fri, 9 May 2025 15:08:19 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::ed) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Fri,
 9 May 2025 15:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:16 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 11/14] cxl/region: Add function to find a port's switch decoder by range
Date: Fri, 9 May 2025 17:06:56 +0200
Message-ID: <20250509150700.2817697-12-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b846e73-1052-4d7e-8e57-08dd8f0b554e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EwjFjvVLAb1sXYGxOd5RPs8cyc9NGX2/pdfCbQLGDwlBa5M/m1dvOrRJonoG?=
 =?us-ascii?Q?u9uYIyGRkT9THAg/4/ml6ftVGTbP3JpiPcBFy75HJQAYWW80xaVZ8SdPCGCp?=
 =?us-ascii?Q?Zhbm7eHLU6FJXAuSltVdV62W99yK4CIRCdIMmUP39Uh+In/fO19YlPNqyGI5?=
 =?us-ascii?Q?JQo51BulQku5jpVpZH4vL9qnhl92DKi6lRZ/gM35EqKmicBHG+YTNExbVxst?=
 =?us-ascii?Q?VT4AUVHLJQVoXEr6EpndyJpa88uN/0VHsfh3Uqm1ROyO7k2MhaCR4GVcwNZf?=
 =?us-ascii?Q?LkvZIB04lHtCeqQTjFWUeq5kjQP9EIWp/tiNSO0VgY8Y+EF28sLRxsqqKv5k?=
 =?us-ascii?Q?f4BJ9c+LIMHIpzsXMGPg9jweS3Ji/YupDIxgKnpMZ6E+RBOIsW3upRaPhAKu?=
 =?us-ascii?Q?jFtX+8SqrmDerH4awfxg817imyzxjtwYkYOaSB/7GvKpL3EP0Do3m2KujING?=
 =?us-ascii?Q?yxD+IFwtusdyPXZ/e4l/bGVQPJ2fSVncIxXc5iBtRxwdnwFN9yhUYnKoJd90?=
 =?us-ascii?Q?E1xMrPQG7aD0/oVrd0VAzA6RZLpqMnGzpHO6OPfhvrXEaMdfeESfVkEB8n+b?=
 =?us-ascii?Q?a0/9j6koHBmHFEdmdDF6Nj7VROvG02trAfPlF2Q5wERz75RxTnvimM/cERLD?=
 =?us-ascii?Q?6qfs4Gr9rL/5wPn7giJgT/gnCRtNajpueLpU05jwdEJfhFLAEz8iWzaA55aT?=
 =?us-ascii?Q?c+m3+Zioe0Rz2KnXXNfH7/T66yUoMMnn35yzErp9su5m9lssg1Ztxy5e33Ds?=
 =?us-ascii?Q?vqvIFjhBbsvRzyoyBj+XIgJheuEz/k2fKpMcIcnS2LvRYkQs4c1Slg/tSNEY?=
 =?us-ascii?Q?IRkm6GJYZEy1KRLidEHox+azalCl1rDQW/1McLnaMoO7sExnqCEtQOFUvIeh?=
 =?us-ascii?Q?IBBiUYst5Io9QVQytWAyFvWrqxyvUlPbVdNotKTCWfCsicYOoAVkYMWcOMnt?=
 =?us-ascii?Q?cQswuWSwQaFGo4sAjyjbrBLNo89LFHdMJmFwmtgZW+D4S2tLEocn2IbVecTl?=
 =?us-ascii?Q?uW+UbCFLkmmHdXANrAnUpole/2LnTqoxzJ/t1zUVg63fBREGM+Qwet+CfBkU?=
 =?us-ascii?Q?KuJExwxP8BiRMPOfJ4Oqk/FEnbzynaBp+GGaH/ZwzsbKcWFeRjSItbL7rxX3?=
 =?us-ascii?Q?ve5mWwQB5P2U2ruseLUg6U9nqsabxAB/LFY06HA/eCh5Qo3QAB3FaSu4BU/W?=
 =?us-ascii?Q?lAgIKG4Bjha/5aflOZkpf82G6wsgce88AjphzgYeykbjlQXi7XAbp2RcKYZu?=
 =?us-ascii?Q?2JGdDYH7ZlFY9ajG8dR9Ad7YvBYHEr+Y3ffWyDERH9IwyBvKGM76h+kiixdm?=
 =?us-ascii?Q?FNIwMNtdrJmyqCznSkqGD9EJ6eLp2FycyS1jHgxOuysei7bZp9w0t1bXU2ga?=
 =?us-ascii?Q?DKM2giJhVjlc5jqeQzi0uP//jMwTzbDLFj5BAmJGjmAVhhVl+duPq8BqZOEK?=
 =?us-ascii?Q?wlQ06MzUG5O5SkDpy0ISYgay/kNkbBxEY8MU/jDPvD7y3Te0Rkuz7iuJEVaB?=
 =?us-ascii?Q?I2WL5YU4/rSz7X7c8VXpPAb8jbz+T00t/0ep?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:19.4669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b846e73-1052-4d7e-8e57-08dd8f0b554e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230

Factor out code to find the switch decoder of a port for a specific
address range. Reuse the code to search a root decoder, create the
function cxl_port_find_switch_decoder() and rework
match_root_decoder_by_range() to be usable for switch decoders too.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8fdf03058b2f..9d3f97ed664b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3202,33 +3202,39 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev,
-				       const void *data)
+static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
 
-	if (!is_root_decoder(dev))
+	if (!is_switch_decoder(dev))
 		return 0;
 
-	cxlrd = to_cxl_root_decoder(dev);
-	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	cxld = to_cxl_decoder(dev);
+	r1 = &cxld->hpa_range;
 	return range_contains(r1, r2);
 }
 
+static struct cxl_decoder *
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+{
+	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+						    match_decoder_by_range);
+
+	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+}
+
 static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_decoder *root, *cxld = &cxled->cxld;
 	struct range *hpa = &cxld->hpa_range;
-	struct device *cxlrd_dev;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
+	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -3236,7 +3242,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		return NULL;
 	}
 
-	return to_cxl_root_decoder(cxlrd_dev);
+	return to_cxl_root_decoder(&root->dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
-- 
2.39.5

