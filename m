Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D233D4F8;
	Sat, 10 Jan 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045657; cv=fail; b=g83O11W9F/XOKfd6JWNu6pWEIu+EsfjkanJT4VV7bvWIDM4njQsTCHOmYVnoM9k2PrfVQah1BpU8s5FlXkbSTwhYgFk8lkeREw5ezF5mnFmZykWUVSXI8Y/J6wB+seiCTkodSgOLJxWZc/CGPlx72SypJBwejEXTqEISii59mV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045657; c=relaxed/simple;
	bh=FfDZghDVshtNusMixOTHHaUvoRi8TYVz+B8BLud1/+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv45zbjk56ix0lSIBsaNUnOxL4WfzSOWaeH99j65geSglDimJVDEE/NfiSiplHvcpH2c46mJEy//OJSaTVFi9z9ZOTxJiMYWPMfD+zCPedXaNyHgwWZp765LDDqzbybpLKDg3BCagOfziWDHySqFVGM/J0bgBXVgJ18p5wcl/SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KefNmWiz; arc=fail smtp.client-ip=52.101.85.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KefNmWiz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMuqjm+95x/ulWbJi2PzhfIMhGYCqDAVN12b5iJhM6Xol5S4kFNeeItU6iBMAgBj5837Q+26pUibNVkoAuZ0cXE4Pd1gbwxqLfzXloA/o+Kydcf8BuvPTSOL6bG49aSduPUO2UOrEZmb3CjjBUuSezOiy8TzT2EPCbZt0E7wPdyBwGedzKcnH4HTfuiAFs/xIC+n1koKaRHzODQ+pTtAiqK+RQtVVd8Y+vChy4U/VQUk3Nuglzka0jqpvM2ebFm460mG/Yb4GQhVm9HblYZfA1wJDJVP31VST5IYnQJlMe6mvVaUoSfp7nkP9CxBS13p7Q18+Li7EBSo3hpIwKh5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6huO/rLPAemua4nM8UqK8HSo8WpIEbw4l0CxlwjdNUw=;
 b=Q0Bwl0mkPXNi7YVPz1oEbcsyGgljERZt9v49R4KfXr59OXji0m+QKFNxzZL9GR/lwZ7UmmKH9kJwca+LU/AO3I2l5U+CalziNaSf8R9imHt38xDWjLvTyCmNuHetwCs+qs4I3KxcoSZkzDnLJR1E0vEWv+WSDeUSnmyMLhsI75ofcapHkk6I5LGHBvsWoeEpwpBYSv6cAN+A30VbI5CtoVfAqBRjihW5ULLHlLrUeyCEl6UHaYC1h5MexbU6CxN9gOZwGhV8N1y/re0yubFkVn+HRIZD+gdG2EuxaGM9ycB4QFUlg5YAQBH9T2vqik7Ddo9G1Zk3+2OGzJEmeXz0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6huO/rLPAemua4nM8UqK8HSo8WpIEbw4l0CxlwjdNUw=;
 b=KefNmWiz+mnSYxyYIiNJ4Wh/JXz8Ll+m/pHXqvVRyypP/1TTEbNEm8x9y1lxvwNEo0OSXBXcjvmxXtLl25lq0cFbDSdFmrIA8JhQpHPd53WSLcSwwyQBvzK5mIm1FS8ej9krkeXDbkfSEpLaa0WY8pO0HeJv68v1wS0mR0IdHTs=
Received: from SA0PR11CA0168.namprd11.prod.outlook.com (2603:10b6:806:1bb::23)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:47:31 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::8f) by SA0PR11CA0168.outlook.office365.com
 (2603:10b6:806:1bb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:30 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:26 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 02/13] cxl/region: Store root decoder in struct cxl_region
Date: Sat, 10 Jan 2026 12:46:47 +0100
Message-ID: <20260110114705.681676-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: e6713d01-9922-458e-4629-08de503e0960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?804DTDVuX4XOyUyVBjP4HCjQnL+dYV4y2YlUfiBtTzu39w0Up208F3BlKHGn?=
 =?us-ascii?Q?NT/eOIeRSEmxbQnIba4i2hLUeqgbluSm5Mvu+SEXGyHZ9+VIyus22Meg4Lc2?=
 =?us-ascii?Q?PH40W1McHbqYCorKDwy1awQjy14tN2DOmaqWc0Y4DRh0O0vwtcSgUqxm14Z1?=
 =?us-ascii?Q?lozowVODst7UEgknWRKwmeX/ncF2SPrruoeyPqxQNFLTtRoDQtueB/hYBxvf?=
 =?us-ascii?Q?c9safQgb6M41kxNH/wIbC/u96Av3iaf/2wiozodU3W8EYIOyDhvS6QIfkt3d?=
 =?us-ascii?Q?Yd1UZwWesQk1KLSCZ4qyjhWmGl+ErB4KkI+2I0ANgM5RQEfS+i9mguWI/GR6?=
 =?us-ascii?Q?WfPFvvr5ljJ3STQGnkNNxyXK1IMD4F9fsM2qEpPAgl7D3rUls+6njRTxnjhv?=
 =?us-ascii?Q?msqRVmAfGrhNVdiUtRmp4aXTH/CS+S8l4YT5PhOvdw0KmP/k/i0uQgVS89T5?=
 =?us-ascii?Q?XOhBJZZRWAM8AK0Ve9cVrEq+T/gtiJKJ1foBBdLw+Jeju+IjtmPkj/RvffAs?=
 =?us-ascii?Q?aUG0lG8ivvxP4K0F9pMbTzvfhbrLYPfnX8rb7+F/nxJmHuoWmSvhKu+1Gtuf?=
 =?us-ascii?Q?ubRyW5QLeJBdsWAo0DT/96T8WJLqT9RvOLnA2kpDDingoeAmPpyETOdlxa9s?=
 =?us-ascii?Q?6ZR0P2RSIp9HngqOAa/pS86dxV0MYSg/4rPo9rpDKTSnqCJIHniMAa/62oT5?=
 =?us-ascii?Q?qJTZOBnAJXkQPtgEs2uZFcfoxWAu67hSDF2Z1dVHQtTwN00uLPeJasvW6r4F?=
 =?us-ascii?Q?DxudsVCaHNneAhhkZTtDsAyc6c0ASt49a5U8vb8WiC2GZOt3Vy+vOq+9YRZM?=
 =?us-ascii?Q?Pg7UM+eEOiNIfBN2AdgunbwE7oFdCchg72lv77afcz4mj3eEMB9cOVsQ1ska?=
 =?us-ascii?Q?8kZxP+aGRbRlxZ348jAY0P19k31rd2rcsoumEXe++dhay2TvBDMQa1w6fDv0?=
 =?us-ascii?Q?oIjRrqUhH+WywOdSAn8hbcvcxHmvahO4TmWgKkEvh2VG9gzEhR6yiuUPs07d?=
 =?us-ascii?Q?DraII3NOf7YGXA01aWHV06WKoO07YbXf4cMlul78ZwW3pg9VpmPZ0tZfLeO/?=
 =?us-ascii?Q?uJZXmgmsqI9K7Lh4dyPx51jBpIB6S/RdbngYpB8qMyIJNq0rB6/M5ob42Ig1?=
 =?us-ascii?Q?c9uHtm0lMtXyeNqhqKx0Zu0ezlvTszVyVQmfjx6gXtaJzUvzLrUZcL9+XGrR?=
 =?us-ascii?Q?aukE46AqJOzYLlTmSDYoErMWhu9vnf17WYWyaBjIhFml+ts4e2+6PlvPezPn?=
 =?us-ascii?Q?VHIPRK0p2E9TD1WVpBNInwxyqVcpkBVUr+xNMJFVMYUlrO/ny8szBnQS22aN?=
 =?us-ascii?Q?wuu6b+Ng8v00GMEJQcSOmqbI5RDkHHW49KI3ZMWudqWZZ/Q6F6t2mMAC9duN?=
 =?us-ascii?Q?RNYDJRwdij8fK7NqBLNKPbAZGZpYwDxsFktEJlzyqI+soAkbFCeCOtqmRWy9?=
 =?us-ascii?Q?cNG4/ZuDZWmGZPlaI2ieUW5cvRSdXNV+hNU+ZlnEMYSecvnTCus9qVJWk0iR?=
 =?us-ascii?Q?vNcyv+GbESzVbN/dIoA3nRpeJmyQ5labJ2/NoztDrl3YZIfg8NhBFPOvwgC8?=
 =?us-ascii?Q?I1ZjenzpFcDTCUBGlxE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:30.8085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6713d01-9922-458e-4629-08de503e0960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

A region is always bound to a root decoder. The region's associated
root decoder is often needed. Add it to struct cxl_region.

This simplifies the code by removing dynamic lookups and the root
decoder argument from the function argument list where possible.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters. It changes the argument list of __construct_region() in
preparation of adding a context argument. Additionally the arg list of
cxl_region_attach_position() is simplified and the use of
to_cxl_root_decoder() removed, which always reconstructs and checks
the pointer. The pointer never changes and is frequently used. Code
becomes more readable as this amphazises the binding between both
objects.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 37 +++++++++++++++++++------------------
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 51f1a5545324..22bd8ff37cef 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -489,9 +489,9 @@ static ssize_t interleave_ways_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	unsigned int val, save;
 	int rc;
@@ -552,9 +552,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int rc, val;
 	u16 ig;
@@ -628,7 +628,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1373,7 +1373,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1731,10 +1731,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 }
 
 static int cxl_region_attach_position(struct cxl_region *cxlr,
-				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
 				      const struct cxl_dport *dport, int pos)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
@@ -1971,7 +1971,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2076,8 +2076,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2100,7 +2099,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2396,8 +2395,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2480,10 +2479,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	 * region id allocations
 	 */
 	get_device(dev->parent);
+	cxlr->cxlrd = cxlrd;
+	cxlr->id = id;
+
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxlr->id = id;
 	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
 
 	return cxlr;
@@ -3115,7 +3116,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 dpa_offset, hpa_offset, hpa;
@@ -3168,7 +3169,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u16 eig = 0;
@@ -3522,7 +3523,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3558,9 +3559,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3656,7 +3657,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..10ce9c3a8a55 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -529,6 +529,7 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -542,6 +543,7 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

