Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AE3A4F31;
	Wed, 14 Jan 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409374; cv=fail; b=txYw5q1diarARX+MDxExHmrtIrTKERlbJsOziqXBheyMre7fobX5byFYXDNj/j/cwHyx9NxNNV+XmP+yohUhys1zWSRrQfAod8WRcYBXOPCg/22lAhaFlL0VB/jRJKqnr11eJSVcJ2BsK796TaofTqUwLvBraPFdK36IoarHPDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409374; c=relaxed/simple;
	bh=T2qZEc/Ds2t6IpxQFVAFGLA/D8M6yB3z4oAHURgNLNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLKWz6ikprov9QaS8WVJiQ0qEy5degBNZawgpVdehWr/1rJMNxBSZbL11X5rIXAY5y+YB+9uDLWeJAuKDP9AaphIhjbZnb0DMZvfewzWBWmxFU6IvoZIjI/z9AqpDof4/quTponxhzkYmLZBxjP39CLPR6N9KjoKrMyjD4Wj5jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vk9kJM/o; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vk9kJM/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9SXBdBOJgOp6+yXBkWqLwyp85PbW/ICCTR7/6qJQPABmVRVnkqayEe7qaoiN37ypv978Oq9r8j0JwTJ5zqMbHsyFuR2PHPKo+cJF5LKO33P+Z6zNfSwCnNKYlcMbf58K3+HB2q4b8aY3HnjMTTLpkNyfnVqazAJI+pJZJ7ZqO5CQjks7UZFi5qC6jUf3GN2mpwW8CD9V2z9uEJkt3ewqUbXKSU8gBliAPWHRH5xAfsIOe4xjpoqCS+L1GD5IrSbzzJbAfyjrjfy5QkAlW5ozWZrwplYFkosPxSMOejTQcahbPKOM9HP8+qgfcwu/ae2oQZubrwtz2b1r9EZsFy0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX/LOzeTAkunfGV6Z5ekrVicZNBFsREdr+CYHlAh250=;
 b=nEHg77TtDWkFqJWKhfPcuh9DeVScvdlglDG+PQKe2BDR2lEfJEUQ6vv2scnqf5gETzPqg0DlGDGnu+7svNeFUtaUE/JVfI3oMuExe6zDBiRz9uQS1agmJo0FsjYvLcoj+avMaKYR1Ol0Fv22t350tCAsXERvfZt39jO4cVJyZjDbTwU86dGBv5RtFXHqMCl0feqIeaG6Zzy2Y9tynvNMj9Gvw3x5KAK6yBi02wPHuz2jH308i8Np/BmujEVq0x4T/HYpfCMVlaucXbc5TKQQJKzNjpCTfX2xBaEwJ22o4fBaYG6y3d3y9vwvawMkxOckRXbt7lXzN/AVugHviYHXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX/LOzeTAkunfGV6Z5ekrVicZNBFsREdr+CYHlAh250=;
 b=vk9kJM/oOEIwo/9JMfb2fFIigH2RS7nDg6TTBMyM1tNxI81nu4JI8dcwAwixXKv6gk1BQxfXlHY9rdUxUOQYgCG27Ll62//sZqn+Rh3iL5r1cdwOwc4N3fYyd62FSs6iO7BdKoYUSK1jXmWduRMktTKGmH88/trP1n0TXX8R5Tk=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:49:24 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::31) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:24 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:21 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 06/13] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Wed, 14 Jan 2026 17:48:22 +0100
Message-ID: <20260114164837.1076338-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e64005-82e7-4906-9af9-08de538cdf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3vxVJ01mHqNjVRJMo8W00c2OjXKVJ0JYCh9Lz9AlNm+Ww37Bmw8rKnkYKdgT?=
 =?us-ascii?Q?teyPcbz7Ffw5YX/FahoO80AKz7hEg2RjXfu7sJryZ3FjDA6xIkHzG4+vgHmT?=
 =?us-ascii?Q?rDfKwiLSfCPTSo0jNWKYcz+yx/TFmwiyHWmQNXCuzV6XaF11x5AAK6rLR1Ed?=
 =?us-ascii?Q?5lI3CMveCkr4M2yXY3USvQTevgYkMYufNcciG6xOzHL1pHtqfcWkmbiJ0yUh?=
 =?us-ascii?Q?vNhiS3HTf/BPE9yveSQcMG5p8bh4uGEGFmYpGi5gce14HnG0ReQjqJdz5OGw?=
 =?us-ascii?Q?3fU+w7yibrIYApEFPY20PFhpiwIwAhzEqmzD8ibsrRd1jo0NqyYXKYMDogW0?=
 =?us-ascii?Q?GFuuqwYYDkxE4WAA1XkgJxBuTblpyOiRbiaj/sHp/W1QVrUTuR5AcBTtezFP?=
 =?us-ascii?Q?hjy4dh+GLMYPjKWXvJyqIs/wKSbSvkFamjn/xXQIPKZpHYS+iux7w27Ol08u?=
 =?us-ascii?Q?s3g4+k6bv/OP23mMpoBYT1ZSD7KOCQX5wh/K0baT/Rvke3Q1RXA+F9e+/7t6?=
 =?us-ascii?Q?NYrT21601wq7ZJoYjE9M9pI4vLBOMhxkHDLRl/HhWjPFoY2QDfrVLzYQ3UwN?=
 =?us-ascii?Q?m702PkFxGvXsywA2Pa7rNRFgmCz0Nsddbn24BNyP03dDjpREcXgVcW3BQfA0?=
 =?us-ascii?Q?zKB0a7Rtm3VTPF37YeuYdnLpqsMYOQeT3eDogJa3T9mQb4cOvYmxjIRFM8Ay?=
 =?us-ascii?Q?mlD8RFfIHwiwYIBJgwaiNk+96CC5BAzir6PX9QGQWVeE1sub0WD+/9AptiNa?=
 =?us-ascii?Q?VgbND5ZDj+3mvtTpNA2qD3uhXO19abd2/YwNS4tObO4AOPcBXJNzUmnsLUdC?=
 =?us-ascii?Q?+SsRIxAMxHbJ3LZxe6LJvQGGpW+6hY29CQtPt3Z7NgSVB0ppTGq484i3HGSL?=
 =?us-ascii?Q?9jBIrXKF3lOeOpjLVIw/zwAFb5u1pHBxIhWaVqj6LQleECaxt94DzvurXUAP?=
 =?us-ascii?Q?YNvTUgHLG0fS7EQyM6PVO4hjGF1fBtytAtFCcGIoTS9OMJm0gd/n7Ez9t9Zl?=
 =?us-ascii?Q?aP1jqVm2Ox6cg3xiBOceu4wcr8vkyKtJ5WX7fO0T/DXWhqEuy4gLnp9KWlzq?=
 =?us-ascii?Q?xop+i9tGfyr6/iK5vpxVs9BXd7W2cHEIxnMbDTpBAECDMOLHy/9ZeFNtwZpX?=
 =?us-ascii?Q?76CtyPjqc+NCtM+IHd5vKmI+GbZPAlh5iZquLt3SY9KwdICb5K1KXzjeRvA5?=
 =?us-ascii?Q?HR+PB6W9kSd5U/e7lQVsaiuNRKR01t+1Ej0mkbpZIzKUNKx4k5irXxbWGnmN?=
 =?us-ascii?Q?FhFsCp3bjP7qqds/cW6sib25lDepKGFuEuK98r2qF3NxjFF6bpYm5YpwwXfb?=
 =?us-ascii?Q?MlvuR9cI1Se4xb0lMgVfwVoxAvspoGIKLWPzSGeM6RJoaJ79Af1EQudopXCe?=
 =?us-ascii?Q?G/0UsZ9m8Srp2H3GC6NMr3mvSsZW623Zr1xseoseJ5bI4RBaQQgkUVlDITv+?=
 =?us-ascii?Q?x4GlMW5rZ4Uc4743GsQ88ArzTZ3FhCCm9+poYQY2K7Tr5vbAMY7/11C8dpSe?=
 =?us-ascii?Q?WQ+KBE6F2PmdPIyPt229mM0aCj1rlVIpnMUGl8PKOvmuPun/cFbV9VAt6ee5?=
 =?us-ascii?Q?Y6WMk5V/7hnMcwd/hn3yVOr8kQ36+i9Afa/Uw+MWqGmLbEQzn7SWohRuls2p?=
 =?us-ascii?Q?X2P231HgLC+e3esfLaQDkouAtxNLlqm9MEMfBW4KxBUeosX+0D1TKuC/AIA9?=
 =?us-ascii?Q?Q2KQHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:24.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e64005-82e7-4906-9af9-08de538cdf98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350

cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
determine its interleaving position. This requires the endpoint
decoders to be an SPA, which is not the case for systems that need
address translation.

Add a separate @hpa_range argument to function
cxl_calc_interleave_pos() to specify the address range. Now it is
possible to pass the SPA translated address range of an endpoint
decoder to function cxl_calc_interleave_pos().

Refactor only, no functional changes.

Patch is a prerequisite to implement address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5ae77e9feb4d..60d2d1dae2aa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1878,6 +1878,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1890,11 +1891,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *hpa_range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1932,7 +1933,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1942,7 +1944,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1955,7 +1957,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2139,7 +2141,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

