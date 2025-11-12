Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5322D77FF;
	Wed, 12 Nov 2025 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979532; cv=fail; b=U+ELApNb0gxGvhcJv4/81BGWXcrqQCGNBTmM4a8FMCCFzTENOAWkNo4Gm2+LGfTHSFtqG+WlBjrcjlXOMwcWGPKKC+V17/WDggT1kRHdZnFytb6eZYfvLkGLfLUvT/iy8fiFDr/TvS6Q3J0+HNErGBvqbQXGfl31KtO1jbgFJ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979532; c=relaxed/simple;
	bh=6p73E+8qaDTSjS74xDy85Quprz52gMzbvXp5ns0j2Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJfyIkygXi1JEzHY78NDw6CrPyLEfC6/5kR5S+FqEgOmEJ4MwsE/IzrJTh57BG8aCUnxv1INA2exMHfzEPatQImGOES7FSOmAS1Q6pohmNx9jc6SIFQtidkmz+7v/t8eGkLm4Um2dON1YrpGzuTmi+CbXpM0Rl5AdIEONPQikl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LbECRYYJ; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LbECRYYJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEfHw9fUO44Hy8GEqQsMpBvVSodzMoVnS5QdKT53afKlPCpOZW4QM1IRZ53kE3fE2I401IBousriy0Sp8TvgG/55iyp+GlnFz+2kn8mQESUbUpdeuojT6cPWH6BDQM78tT+c2uTCe3Cwf0HrDdCMi7wLX3XThK1P72K4j8O6CqolzwO+mHTk/Z5Clc51oxPqRAg+5pup+0TU9uQYm40Gzo95JAQanpzxBYyzEyiUoiOMtIDkaApP3IF0IrfoXuTBfxj3j6NAlZ79VLybyy+8iF6KmfsfMh55XtQ/YpTuSR8v2ncHI7E1eoyLP8Ke10Gd5mY7gguaZDcD3mfOnkrNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/KyuMspeNsZukjfyXJGajUs94/rOX68Qg2N5tCAIao=;
 b=mb4kK39b47pc989ynj9k4vWg/6HHQC8RXytEE28XOWAiuLIu22FapFxDthgZixbnX/HVdDZzhAH7GiXvTyxmcPK5zJJt7+UfnI13IoSHbyluEs4v8EbrRiwvssktMaXYNJC78lTm40fbaRAwzeS393yEXlvyZH18MJ4B30KVyn7HBRxGkXt5qspLTpvoP7nYV515iYFQsaX9bCDf6YhprPagiNJZlbipWGzbnS+YTDzNPm+6rIuEKknSmQ9k4G49wRs/Z762ARsNtZyHvW2MRARGNMHfYHSBa+sOF/6NJ8jMJDn97Eat+IrCD9lLu7OhEFrMzXwQhrOAT7dB60FvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/KyuMspeNsZukjfyXJGajUs94/rOX68Qg2N5tCAIao=;
 b=LbECRYYJ+mug5ae6y5jBxp/d2nE9uwvbiwnvU7wS00jXcTmxY/TGUzLyjDFsbSMn6aNvEdNCO+4ze8WllBF/FD0viNwaCyvH43rVxaNh5/6WY+6/57J/Zg/3rhSAG+SZkAhFtH0VQfS6FW4nGI9wCu+jS/2m4RP6HEARv/DcRDU=
Received: from DM6PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:100::21)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:32:04 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::fc) by DM6PR03CA0044.outlook.office365.com
 (2603:10b6:5:100::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:03 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:00 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 02/11] cxl/region: Store root decoder in struct cxl_region
Date: Wed, 12 Nov 2025 21:31:29 +0100
Message-ID: <20251112203143.1269944-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e3450c-8f4c-45ca-d14a-08de222a8a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7F6wJEPZ9yYfI2mDD+ynm1r8gF5b/OoSGrVFN2EhgQB23nGM5ufKqbvAryia?=
 =?us-ascii?Q?Ooi3xniHubSC5ps7ymVsjhRgNsCGUlmZ10nSfzYgt7t7E5vsh1eBYymp3X2x?=
 =?us-ascii?Q?1byXHk4oxMxgteIV/UMWIJSK4kHckZ+IakEnP4IgVR9OMKg+YciqpaHt7FXp?=
 =?us-ascii?Q?hzTlmJhaG0mKC1zM0M5mvnO9uiwbaFD/E2oHxeNPbRDtXNb73enhmisvxP/N?=
 =?us-ascii?Q?/rG0rd0doHtArTqESLsdkX4uzCxoXIfj5t1QpIN2RUigH8olSwG9zmP2sLcK?=
 =?us-ascii?Q?I8srjPls1db8nCZiURc5RdzILSInagEejLH3+1jGSACTevZ8BISjaYmy4Rp/?=
 =?us-ascii?Q?lgRdIBuPjRluLVIY3ouCR37KADUMxwwsS4ITKU8oWTsEfBwT0w9sfilQFlzR?=
 =?us-ascii?Q?S8jdC5xBoP5v6xNXXQUdtlulcq8R6bcmS79PQmN7ViBnxmT0sQ+RugH137Di?=
 =?us-ascii?Q?ABXQbDiytrEaP96qQXtI17J8oG3h+gwuKWmeCzmyz9+33tTy/jHRiSFOFwrY?=
 =?us-ascii?Q?Ecq2BEygakJMKRCt0XtmrPFYGqJuJsJx8evqFaiCtfz27gy3aVgv49GNa9aT?=
 =?us-ascii?Q?X7IAd1aVArV1nn/6459dQNeKVn+fL6WflriuIvmpL6EgunLGAWW0HbNHVpir?=
 =?us-ascii?Q?2pDE9cmAgR59GYwi/SdPvXrBfyLDAPF8/VpyYhKsR+jzo08aWnxb589V/axz?=
 =?us-ascii?Q?JV2CiHvK6WnpKHTEiw5F1JX9mFHZXxyPkmfDlgQNASXNUJgi5nm/z4NEQpyr?=
 =?us-ascii?Q?rwldzeeQXWO8xloxed+lfJVjBtvyAMxdkXtOJcCgY0tszrHOZLbjYeeJK+yb?=
 =?us-ascii?Q?SML3NTX/m+R8N9M6UfypfL+BqhAY3tNeDLDev58CWSNXdxOMd1yFedhnY7Wu?=
 =?us-ascii?Q?aCEfDDEsbIZ5A9Dv0K/gXkabtRlpmC+5TXUwkibSzDMJ0K3N5a8X/dCdWN8p?=
 =?us-ascii?Q?uakDf8o4/epnNG8YC7FDPe0oFSaWRyTt+AiU/oB+n8Z8DHc9JlME1k53DJbe?=
 =?us-ascii?Q?XH4Xc2hsYylgVH9kE0J2SUkJP1miwJ7DUZ+wet6oc1BzKRZ+1c0lCLh4c3Ir?=
 =?us-ascii?Q?wlpHOoux1waFsPthTNbRQnpYWzX/mKvrlSqK3sV4Qq+2dN0LJg75Ww2FZ90+?=
 =?us-ascii?Q?3yaFWVZw3qQeTM9+6EIJJBJ89iVmRuv6zrPccjHwjGM2yvBl5vNwJ3r9Ern7?=
 =?us-ascii?Q?TFuQ5SbzU9fveRKFBny6mrKPB6JZdObrlDhz5LIx9YmZy/GT6pKl0+DGOi2L?=
 =?us-ascii?Q?qTV8xZV9cX4miT+fVtmlJVsioOhhhVtNufYeglJCLGmX1YG3b0TZCtUNhDQQ?=
 =?us-ascii?Q?MQnLZt4wYRWCQOHEce+KRsbno4GiXrK3GTCA9m3dKAUC3xLZSuNZytBrE8/8?=
 =?us-ascii?Q?gkVu5H6GRBnNvY4Niq9jNvupUbvb0D0wxNjXYQI1o2OkefK74BlSTpGC4IUA?=
 =?us-ascii?Q?aqJ0n/X82B3EOYcJBOpOE0Dwx1MJEazmb545JPVZwmrEOvUaJtJvp34G/H7h?=
 =?us-ascii?Q?QC2WieDIUVgTX5+F1lO2gbofhDRyxnV3YpoJs8mAtSmubGG83gJzNXEb47iT?=
 =?us-ascii?Q?OHmhY3z7/rCqc3idl6w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:03.6644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e3450c-8f4c-45ca-d14a-08de222a8a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

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
index 500aacf66d36..a7786d768699 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -480,9 +480,9 @@ static ssize_t interleave_ways_store(struct device *dev,
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
@@ -543,9 +543,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
@@ -619,7 +619,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1352,7 +1352,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1711,10 +1711,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
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
@@ -1951,7 +1951,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2056,8 +2056,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2080,7 +2079,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2376,8 +2375,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2460,10 +2459,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
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
@@ -3104,7 +3105,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 dpa_offset, hpa_offset, hpa;
@@ -3157,7 +3158,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u16 eig = 0;
@@ -3511,7 +3512,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3547,9 +3548,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3645,7 +3646,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e8931b626fc6..99e3a1a6587b 100644
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

