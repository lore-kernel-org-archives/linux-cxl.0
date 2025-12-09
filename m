Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781542FD69E;
	Tue,  9 Dec 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303695; cv=fail; b=W1+d2TA18YL2V7daWaRkWHDRhkFw06sUKT3YOu1O0ZT67wlKqlvgFkbylWuAH0jxaoJdxDFeoBdSypR6c6Zmfff0BzpSvw30ApUuasbSNbZR6TPy1m+Aehej3mo02QPc3tFcyYTUfypPh4TKuHad327XU6U6UNgZp9ypluBPHSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303695; c=relaxed/simple;
	bh=52WDnIzJJvUDblNKbg7TAx7/bblRiGkGV9WBIjPBm9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV4Ig9/xZUruHVW7emSu6UkN8iMpgPBi6m6ikao89G5HUNk8DctwXiurm33JxEV8XIPzwdBrAtkeh47NneERkZYF42TZSqaQfN/IKdHH6+KDpvjlg1RhW7TrffFry6XmDAEyMPLu2h9wIiDKNHiXx9d4XVQs+TIhi1br4LcPg1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hS/MdDLb; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hS/MdDLb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hliC+nf1pMNg8DM3wSORXzOe9GeaXtYir/EZct7PTrVPxWjs2ZIQSaY2GxaQkbsf4WUwplILPklDQ6vd26eeS+JeTY3Nhx1yVmvPkx9G8x42I8vz32blWdC8xiSG4RqLeGeus5Rbg4W9fXgdne9iTsbRfD0zXCrY9e4h4qeCJju+mpNjDHwo3IfYfLwJLVrxP791yOQSZ+pprMGdbtuWjaErl6DuIbtGL4EPlIO3WdVIBRgqouE1iuY2E0i+OI34tRqzNimrwAYqMlLw9KCmizgxmEqss0bsUjk+wc304jsTJVSICYqU5XgnHmnbGp2zYSCSSlKycvPJKsoUgs80lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1KUSV9LjRIvaGQf4UCIxLgi5Za8vxOzE7RUiZQ9ZAs=;
 b=ErSJcL1ZpS5v/dDGkiWuVtbH1VDAntmVYg+xOkLDYxS5A5M7DfNH/ZSs4IwnNk11X+pGUB4+Efkl5bpwWOBbAURTIRRGIcx96bV0G6Ucnwwo8a4+StGnvPRHS/cigex4Id/0/6QHCpzQGCOMN6VyB25suAF3bq9WGEYGXoZVn5wSL6ozFL6bw0IbMUsVRRtnXdEUxwuHK5LiN+ShkRobPwr+aVFpm/gXzX4Or3hGhtZ9hHpn6xXWEtQ44RUIXGWV1O/WABdB80BY9zHYtohL971vbjx5MRrF1TsbycKOPEk+8Gp0ejwdkA9vlV60tK812n8JkM49evL4FlNAE00T5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1KUSV9LjRIvaGQf4UCIxLgi5Za8vxOzE7RUiZQ9ZAs=;
 b=hS/MdDLbIiJdjBq+rRbhcyy0An7rq37+BRKxc1ICXMvYdriDbLGGub+Q6o4T218LD391SMbtS229qHXG/h/n9g11z1fcvGvZsRg9eaYYg44cKNKpZKeHc73YvgQXI2v8VMFPqHzeae6nX5JB4u9Y56m7sgjBrwbtcELuY0a6Pts=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:08:06 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::74) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Tue, 9
 Dec 2025 18:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:05 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:02 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 02/13] cxl/region: Store root decoder in struct cxl_region
Date: Tue, 9 Dec 2025 19:06:38 +0100
Message-ID: <20251209180659.208842-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 450904e3-711d-475d-aa9a-08de374de6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ltEAlUNzcS/to0uj7WnInS2ddmPKYXPO1LeHEJGmg52Et9vgR8Oj3i4XPeD?=
 =?us-ascii?Q?ORTZ/CR5gLcLK3MnkVfkthUlHdEibKfW12tSzDTIOAIAtWVOajIGKMHaEHbj?=
 =?us-ascii?Q?gUb07CIQ2u1WFLYRI+CWx/OJ/1V8bGfyc9oHUkJLpqEcpv67hqjYStPsG1Gx?=
 =?us-ascii?Q?/aOvr1zX3342puCq4WV8c0MtHtwtOo3oI/Roj29VnkER5GjqYx4tU/B0g+/n?=
 =?us-ascii?Q?rXyGGqqvQD/9Zv2KBpPxuUlAZHnKkgvEHBWDj1BxhjsY468dfD4nLruJkx4z?=
 =?us-ascii?Q?5KtFm+VZmUc/FRjGpOUrcdJXGMKAd4W+pJss9UA1XaBZcCw3hJwy/DbjXXD4?=
 =?us-ascii?Q?JMyd6wpEcfG9gY5TEJnoCR4v7+vInHV/VtAkOttkftknDz/RpkIZadtPGJOA?=
 =?us-ascii?Q?yD8t5AW/ZKpW4/L8+eA6F2Hcshy2lNklRFPNRv6l7qutALn5IRkG1BADdrVF?=
 =?us-ascii?Q?q1q6csnqT2YP2QpzfALU3rg5mOGJkP9vcCJ69vZfQIo9g5mHvTbhhk1HOegz?=
 =?us-ascii?Q?QVF9uO4hKvOszuV1KCjxmH5bPdepNI34QpuOd090L5FJPtKPbK4wY+qsXs29?=
 =?us-ascii?Q?7US4I4MiCY2NgkeVTuBkJQvk7OSGZxgcboH4V85liSvFDSOsN7yWgGcjvwA2?=
 =?us-ascii?Q?aan6NQtcTrDD/QLTc+VRK/5Y5fOFxsehBaGa/KkMre/ubNpCfPnw/IMyDUIn?=
 =?us-ascii?Q?75YWfADEJCw3CbFx3GrTiVWtO2sc3L3kNUJNTpFre/+ntMYf3EncWPzb55OX?=
 =?us-ascii?Q?EFzJPcdUQgzwPVG78x+RCO4McaK2885pOzSfsCTY8N5zq3qUYetn/81kHpp6?=
 =?us-ascii?Q?Zq4CYc17I0W1QEj2vAYl3bKcRT26MlGDeXKD5v2GfbPW6y9cll0qmyPbXyWI?=
 =?us-ascii?Q?3+Uk4Ckz7ZGMTa/JQXMGX8zXT6DEOFVWJ7vpf58cCiyQdKDKUafn54vo+2gl?=
 =?us-ascii?Q?h75AMZ1jObex8bNty+ZbMtcXUog0nWRpPTrmsrfyWvLGFEhcvT0xpJh6USUK?=
 =?us-ascii?Q?5THyrVPi4qaF5vT1oDjFaunIzzEMNhEGM8xTaHtZ76av/vjyr1eFeG/xgDA1?=
 =?us-ascii?Q?usufYQ4SK1IDewcAnrhLz/iMRxrxULQAFOTw7UMx+ClK+jEQLr07vQJ5W7KZ?=
 =?us-ascii?Q?BgpyqnWH86aeb5ElIFV/PXwOuZ0Bc7XeYQc9GisQQS/y+aHmSimTSRa7/BeX?=
 =?us-ascii?Q?7v299TPA9h8ps1uYGWP2M/K4bbz3WUK05YVYQ6bizZ6nu3B1oTrM9Be0NqRu?=
 =?us-ascii?Q?YpxwNeL2hvEGYuac1tjiq6d53VZSinmGUFthmUxO1KP7/66/yybc93AicDQU?=
 =?us-ascii?Q?m9F61ZbCtHboqZQ7ccKsZh+Imq3r5nssEFh6D752lA4YMCysskzyqlJvEdIv?=
 =?us-ascii?Q?M+6uQ5EMK/6JmUfoyn0vLMXVvpmVRygeTnZ3sEMnZ6xY62kKJXmwq2GICczY?=
 =?us-ascii?Q?zmrz5i0VFMIAU45MnqAD8Du7gObn7W3NkBvtiimV7q+dQMlOHVIuKhyCUt+A?=
 =?us-ascii?Q?Euj6n+m0S5u7V/yhzMFctCf35b6zcG7TFWQAWk++bj/dDQ/Bpp8+fIQ8nzV2?=
 =?us-ascii?Q?NhhmkwjpoTGaFq5MbEA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:05.5415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450904e3-711d-475d-aa9a-08de374de6c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

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
index 1fd2a13288e9..077cfc75e081 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -486,9 +486,9 @@ static ssize_t interleave_ways_store(struct device *dev,
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
@@ -549,9 +549,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
@@ -625,7 +625,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1370,7 +1370,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1728,10 +1728,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
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
@@ -1968,7 +1968,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2073,8 +2073,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2097,7 +2096,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2393,8 +2392,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2477,10 +2476,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
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
@@ -3112,7 +3113,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 dpa_offset, hpa_offset, hpa;
@@ -3165,7 +3166,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u16 eig = 0;
@@ -3519,7 +3520,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3555,9 +3556,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3653,7 +3654,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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

