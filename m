Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6735C1AE;
	Fri, 14 Nov 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156402; cv=fail; b=RXSkx6Kue179rO5qePLG6+kZDZKBpsZneF6swmTkJz/p8w2hbcZI34yjrhZ31AbUQ3X17FcNaNR+ilNRp7EUdXvN3Ly4JzWMXRQcFx6WxpgRjCIZuIiy/ubmiEYd7A+RNk/EkggrTOkTGzfLUxZbryS9Zzi/vGroJVXYjG2R+Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156402; c=relaxed/simple;
	bh=rFeByDsxyBOl4GvAKL+jHGD/ANn3GVYNmoAXQhkpfUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNf707TDs91X5zo3Et2SYsonOpYQjjpDxXkHk2cg8fgNXwl/1YP3taYEjghR+8oQ0TD23TJMwiadgGW+BaNn+8YMBjvzQVaLIh4Aa0UEk5UB2vSyoUQoU/dMo8POTugAhso8pQW+EY5lEHhM1EPDbNsgoWGr/FBKWi2O2iLegW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ak3Dv5h/; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ak3Dv5h/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJgwBjuZu2nBC/mIUMfpbFlF8pxIuwJkcDzGIYJ/xtlz6ED0rwLxba9vmto1Gyszn/bC2w65EehTFd4bj08DcixPkQvk3S69VNhCfPcliaLge93f9LqrP/XyULfqnKOEJoeiMtUNGAGv5w9kLOE4Pbaf4nYODka7X0sBrnQOe/QRe4UznLzfG5eD2/kQWXRaOr/gWKhqKd9dSy8wqlV3JV8MInKqgz2ZTFa69JdEEfqiCcwHmjB6PiAG1Fx765EDB03vDQQhqL2VEUS1Wg7SfgOer2JA94sYNuxdwThqI9M4XOpEapheh7GKkmyK8r+CcUDkZs9c7Snv/gm68oZi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ7wsX7LA3oR9Oe2ZJQT6W6FeRhidUPF9O7J8GDBD28=;
 b=ydl7ZvWaNwV2B0UiDnCABjEzxdjBLCEefPu8CJLOugcWT48rDJwld89w8jcSGNGdd/egezeOcOtFrnVRiO6nztoti+nKqYZZSxXTVOz5Tb2ceUWuN5mQ3F8Hobqx+nERRBYMc2j4482wB4Z1GhXTW55hLj3D9HzGnu8bZfxDgcU+JseReqdwJZ1EkmkO3BpaFNqn28dSGyzyHNHcGcJPqYCjQlPgTIF5Ts+BUUv6kIbLRC+FPo4IaJ4j3yakwsttObToajzqwfIUqDWNgivJWxdfi0btlEVuNw7u8oMGQ0Ql+5BXCUuCycB6clMNBkS6FJDN4g/yhEuRg3up7p+Baw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ7wsX7LA3oR9Oe2ZJQT6W6FeRhidUPF9O7J8GDBD28=;
 b=ak3Dv5h/LWElE4ot6iIogiIrZY9YvuFz8OVgz/MEXmAv3JqQkTkJCHwyz6urcrndIV8adVKB1vz3/odu0I4QPlXVV+18iNLbymfEwIEdkzYpDUiw5F4JtGM4ien0eLG6MmBx0U30MyBH2STN4Hm+CbaHo4bniqxjKCGHdRDsWlE=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:39:54 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::3d) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:39:53 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:39:50 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 02/11] cxl/region: Store root decoder in struct cxl_region
Date: Fri, 14 Nov 2025 22:39:15 +0100
Message-ID: <20251114213931.30754-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4adde6-7325-4d67-9d8b-08de23c658ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWHTWqo9FXQBnU0eA9Nnh45TZBWUTbCmyViZnSmGVC1ufkzBFVRceIV8EMC4?=
 =?us-ascii?Q?queC6Uxl3PIbkNXH6kUiXGsOpu7RnuH5QaVpR6GycbebFlhVPN5jFcwKIVnO?=
 =?us-ascii?Q?aHCqa0gJMmgadsJ0Vw0TxV8nmjW8xu9LjMDafii9yq79Oqmv5GGNsbE94Eit?=
 =?us-ascii?Q?vsvD6qSW1PwSRkCxDdgG8FvHyVHI9/qnfiyJ4Dpzh48gjb+voF/s9gdlne0F?=
 =?us-ascii?Q?GhnK8onfzyfPO2H4uwwd471NS7aR1j+VZQ0jHIy5l9ed8hiwPnJYDz97ZFvW?=
 =?us-ascii?Q?WJ98OrDnFN7tMEdJZ6KDqIQ6kKHhShcbbQ/aLm6s1syqoyRPopwh8lEaPGtj?=
 =?us-ascii?Q?4Fp/c4ZltkdowWf3CCAKLgezRBJYmprSX16YvH9dQSUhed/oFR1zEikZqQct?=
 =?us-ascii?Q?hU9gN/eaSBxD+Gg3gUlPRORHNRA/hzTm3xW0Eg547/+mGq/hVM3C6PoERUou?=
 =?us-ascii?Q?XueKeZ8QXpP/i5C2vdhFARNfUwWQ42ahvj01MlRYjig7Smo7PIUlHeO1Y47q?=
 =?us-ascii?Q?kGQw12J4P4qYz2/Cyw7K5s9xYciwBkUVZ5yzCkLyJV1ofparmCnHGWNdqC3H?=
 =?us-ascii?Q?xHaGya+Dflv8c5dqjlVPXpPwlkIpuU1haUTyfOn4RVQiyhb3XoUXOAk0HcCa?=
 =?us-ascii?Q?SLFFzTXt26qCGS2rSB+XRWBHeB3xXA6nV8yaFGktm45LGzY6cmbcqPZUxjyx?=
 =?us-ascii?Q?fb+55hjM7HDWe5/fGv9B/TtRJ1dOhCrx8+bVzRc7lrqoX3+d+ir4YhL3hDJj?=
 =?us-ascii?Q?h3lF4Q5QxwjxtbDYRia0+g+cdVJqKSXVKD1eAqr3InCUYiZC2jF5Q4miYzXr?=
 =?us-ascii?Q?aGcZMOhgFzO+Z0L6gDr1DM4ZdICYyEUC//6M8kZDLeb9g9v3lTTLfMv7PpsL?=
 =?us-ascii?Q?uQ7RCijIJ22IG4mLMwCAqvwSN6g8USc8dR8K1p8hTDyXaSGJmTv8OryJx/tp?=
 =?us-ascii?Q?NgHgBXfIOuDC3hSep3MvqCQRPBd4OtzWHdMOCjwtiG48IRENgX5wx36g5z6d?=
 =?us-ascii?Q?OcdjqZdsezRIw6FtsbHrBSjPAcbnGG1SMkWl3bh5JxdzXWp9pJu7PDP7MGIk?=
 =?us-ascii?Q?othm2+N2y97cONJvFSwHsiGN71F7JfihLvr4Wul1+xx7dXukaVMgCWvrC2Ht?=
 =?us-ascii?Q?SzZCHjwv5geUE2FphUZHivNZJY5OqB9AXett9vqhgWPFky2T7OZiAANGR6GJ?=
 =?us-ascii?Q?jm2YjiitSBpt7k17JbOeeaPhdcVcV8P+QKkN9LQg1eWfehZZpuRZ7xeCCIW3?=
 =?us-ascii?Q?9EjpW+vnjoAr0TljelCqompBNh+S4RHdRxSwLJvzinQ9mloBL7mKUeAi5N1k?=
 =?us-ascii?Q?nxb+qwOOmOLUdHqxObqbdBa0xeTJjapBjOfkGdzhPgCrTqwLHocDfsSdvbwp?=
 =?us-ascii?Q?wlTIhmZB2MvSiilJz1l+lI530q6264Xn6NUhSly576ncZ9Wd9lAFooIBUWVd?=
 =?us-ascii?Q?rp5ihMyYhYIoRCiFgXkRqSZH+zyoDOq47iUQ8AMWvr3PsAxFiYTJEX2dIqPj?=
 =?us-ascii?Q?fdKm0vqlmX1ey03juJ/IYmK0PSRAIIKr17y/jAxuE1ko5e2wQ0DwaTkbyTfq?=
 =?us-ascii?Q?fNGmQG+KhaHKXrivnoI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:39:53.4901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4adde6-7325-4d67-9d8b-08de23c658ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569

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
index e108819593e9..d3bd8d074033 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -495,9 +495,9 @@ static ssize_t interleave_ways_store(struct device *dev,
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
@@ -558,9 +558,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
@@ -634,7 +634,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1327,7 +1327,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1685,10 +1685,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
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
@@ -1925,7 +1925,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2030,8 +2030,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2054,7 +2053,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2350,8 +2349,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2434,10 +2433,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
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
 
 	return cxlr;
 }
@@ -2926,7 +2927,7 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
@@ -3002,7 +3003,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u64 bits_upper, bits_lower;
@@ -3393,7 +3394,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3429,9 +3430,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3523,7 +3524,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6524b242e8c4..e61e274cdab2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -521,6 +521,7 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -534,6 +535,7 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

