Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6526059D;
	Fri, 14 Nov 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080865; cv=fail; b=Allbh26SJaL6Oe/OECicZsLR6TTgP87swnwxLYUxaJ9JIEs1NDu41HR/AD8zqZRpjYsnfhsAc+Sqj+2pmJOzlRZp6WN+BzqAndyc8aYKdPJ1nyG6R7SkTbkdu0sS46lAN+V5apAZnPNFIqS/yjWbf4x2mjPpXHTTi/+jZ7AAmHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080865; c=relaxed/simple;
	bh=rFeByDsxyBOl4GvAKL+jHGD/ANn3GVYNmoAXQhkpfUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUVudKe3V5D9U6so5VCZ7qCbQ9gLlclBgWB/0s7qWTxUnryNdAA0o2coPLLpthFbwq+s2RsI+aGCsbkePwVnCK8Zk0sa0KQid0eFMfCq4uNRqE5F0ZbXEoDfS+CVbWCHEAqYhz/ROqPfnbJHnxVr4+DPsFj64iRkGue89DpQE/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TaTwtt20; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TaTwtt20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdqPkqbsPMajXO2TeuqP3pjuujEx/smp7zjVkrTq5h/FijSsrRDhlivuQ0bYfa42ViwRbPC8msihZElBgYoJ2ns291HKu51/wG9nWP14fMbgkNPLggS4Vm40+4bQnDS2OBAszkJkmZHwgrh6ndSRUOvXewTFlzTj3f8ZCd1lDC8dxRexyvKP74LKGQP3UKUZGVZlWJsq0LhWnUjhsf8uKD3afdT96Vr1Ls92Ysx8SOF109ZRTZLHU3+KEdVywWHL0zJwzbNxQqgiTHebHJ+qnmiV7jsrn/1p2hmqaoN90Iy2EUDONIRZHPnNloxaD1a0LLfg8uunLcF0OYG+lnR76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ7wsX7LA3oR9Oe2ZJQT6W6FeRhidUPF9O7J8GDBD28=;
 b=pEU5Y83ENbEKm32k7mVt2v4vO/V0BMycBR+xk315WUgQizDsa9aHCeclkn9oAFr0IBKP7sOldQObXsB1LibHqwJ9lJYpsIKFBVr58StTc3J8CfZz3/Yj/JCziYWtJ2hpitg8xeTJOlZU/EuRRB4qoZ2tg3jj9INZ3AccY/qy4dcvY8NCNmUKsiZq+K1YCx4GK7ukp1PyNLVfQIRLpGYvObtpWaZBHrAv1646youNftVCddrU9bpcelttDUilQihVIMuyLUTXEOieTiAjA9948WCyCo3P8+q8XoUL3Q8wMNP/rZMs7Ip+BmNBiOacNq63+QDmEV5zmUFuYGmL4Dcoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ7wsX7LA3oR9Oe2ZJQT6W6FeRhidUPF9O7J8GDBD28=;
 b=TaTwtt20vvtvfQTclrxN5dp3/HCFD+o+J8N8EaYZEpMnbZhhC0CGk4Bqj+Jtnuny+4GFPk2f7s774Ir1dH3UaEaAoo/OyhFolkNGA8QyUZbhH2QjutB1/IPDlr33WQh2c2jLzKNb2/8UGgjqsxPKyHVhVAmSRy8MGomM+CWb2hE=
Received: from MW4PR04CA0369.namprd04.prod.outlook.com (2603:10b6:303:81::14)
 by DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 00:41:00 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::ba) by MW4PR04CA0369.outlook.office365.com
 (2603:10b6:303:81::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Fri,
 14 Nov 2025 00:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:40:59 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:40:54 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 02/11] cxl/region: Store root decoder in struct cxl_region
Date: Fri, 14 Nov 2025 01:40:07 +0100
Message-ID: <20251114004021.1310661-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DS7PR12MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: e03c4259-40f3-4378-e8c8-08de23167b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qLLxlzlk1Spi0atx4uQ8+M2mG7Y//dDm78lPML19KLgod8dt9xyZf5mPFFOX?=
 =?us-ascii?Q?bb7FJay4VOMlWxrwyEZaCFrKP1IT88Y+va9AdxKf2nx2rnO1Cd0SCUuyCiAk?=
 =?us-ascii?Q?23bxccp8jPaXJ+mFOjud8i4EvXbQ9NVarHSE22uQ6hlkoT4WcLo3lS2v/3rg?=
 =?us-ascii?Q?yuFvuWnVUZhUHggSdMqnj6s7tvK7MvhqnNFaPgPl5btT6NE2FvPhJiMtBDWB?=
 =?us-ascii?Q?H00VFlcYpm8Q/dTwZuCVIwA3eXDBHdmbeS0WkZkoZJAkVWM9+TX+tukkoqOk?=
 =?us-ascii?Q?6iSZ6Ebn0GAdr/P4uI8O1rCFxL9ShCWy+6a4xbyIvKGmjZ+9A7Y32XpPJRx0?=
 =?us-ascii?Q?h3zUKrOMaKaPVhZV6tBoMI9LnCaJnkqXW2aXDyVP+0HNEtzPK71+GRvtm362?=
 =?us-ascii?Q?DGnX0htsNU+9PtsRquJ7weAX+kZp2prbgJkMTp8S/kP63YHHtG92YgMQLKWd?=
 =?us-ascii?Q?mZZmGwL5rUjgjwkmGydUWa/+T7LDA1iZVYe+P4AJJate4DmOTu8qI/nQqyG6?=
 =?us-ascii?Q?7Kw6GxvfFVeBcKva0xgKzUUEbhvHUYajU6nmt4Hm5AC0gIKFzx361vwOF0nO?=
 =?us-ascii?Q?7lJwrQxixBZGQ6E+jaiBs/G7sx1WHAyCjx53GKVYJKy/sqbUonnzWNPwnXF+?=
 =?us-ascii?Q?jLOPz3FKqPydodaMv56QNg3sLWC4dXzuYQu8flaEjHc5dz9HzQgobPLYZqYG?=
 =?us-ascii?Q?IhrkTUJxyKmDh4gUrqW8W+d6zp04lzKTCXciXQoicJ9K07txuYizS5JLKMHB?=
 =?us-ascii?Q?j/YzRl3eBGUBvEEB3NSryWQIxl7QNRXqnrCh7JgorZsqHuErUACSiT4EVM0B?=
 =?us-ascii?Q?zjlmsqsQpz2nnQ3WKMmpsX7r/RR2HDin1zoUD3PkEb3hlD98vushfGaKdRcA?=
 =?us-ascii?Q?/40PiFUGhsP002RgozoovcrIRFeLXQ/oiYNzY1SZ87NTl3oOjugNl01W1uB7?=
 =?us-ascii?Q?M94DMY2rdN1IobT6Ql5xBqIg3WuGcC7Uk6wXbxZmH6z/QfSegBgFEPl8cNxH?=
 =?us-ascii?Q?oHzGev2e8R3DQZsU0wEeD+YOFmThunEMOA5hUmntADYQcWNdzbfNEEU1H6dQ?=
 =?us-ascii?Q?LkSdc9+PHF6avwIcYtYhJlKGni7R7nY6o4GJhQtswHzJsHuQ6pZkTdYEYg4c?=
 =?us-ascii?Q?ekOuJZTcw3DisynVwheRynf+fRGU+wvemX6vPpvct0am+Owo537GoE+a3pOA?=
 =?us-ascii?Q?7jv/1u78rdd0fvG6um+NLYsoNP9vtBcx9Ztc6qPDfUHQKtr5PmcXXXCDgbGR?=
 =?us-ascii?Q?bci/JDQVEyg3ERqXvihesX9J4q5PHsN+PkR00cFWJGhyaHAi/2DEWETWYCz3?=
 =?us-ascii?Q?Zot9/UULVgLNWsaG4IClXgp3EJknZ4QPV0d1GQf4ooVUhM/z/Gyxt1KWWxpF?=
 =?us-ascii?Q?B/sm3+BpOq2hzEFmXZkVbhwpZiwTcgJMfwqk/sFR2SxxA/0cOwi9MEkLsoDP?=
 =?us-ascii?Q?4p60PMNnbh7iy8/LW3m4ELQEyiLL2J+Ye+Oz2SC4JICtY+Fdy/Xt6fYePPSI?=
 =?us-ascii?Q?o1du/mepLHQuVwo9j9W6OpVlSitmYXY8grLOM1BoilGXBYHnPmZzxl83qYA/?=
 =?us-ascii?Q?K6+c/M3CdRgo5FH6E4E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:40:59.5017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03c4259-40f3-4378-e8c8-08de23167b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9501

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

