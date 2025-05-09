Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C3235079;
	Fri,  9 May 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803289; cv=fail; b=YhCUls8cznPGMN1N9k92yOedRQQaAAjkJerP3JERbeVi+T70OodT4vJ+8819ygcFBm486W6zI/8E2lf3qxzinFGQzvcv+pbY/c/yiZpusB5Hsy6NJr+pLh6/JHQsvxOH32fx/B0SkmJl6rWA560+vvPVqnwXetdw4t2i2mSX28w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803289; c=relaxed/simple;
	bh=1Eb3kJPR1k18bAlKlHJ80Ki0iQwLfDALtaSDrwOiacs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2xBZQh0e1vyYKMkncRB18hzrgAwTFH4JamK+raV4fpTDvNsuEwjjfcmu9NoeOvL1H5G3DAwwfj2nFSRFIEoV8NkcYKVzsJl55pMP0Bhl4tVCMN6N6nZZ3Sk+Fq0GD5f6N2iOqa+NDSSFDVl0WenLAkRhpFGj0kRg67HzOcaORI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yCS5qTkM; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yCS5qTkM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcaJGhwkTpUUbBZnT5BShQXzMHoECCF62PNjvw8RED6IwOLMH2l2M7SpxFweMrGxOx8yNepKTYsO9vsNGayyvRMiV7NpvUdiXwBuwgqJkkcTKDCsCs3TX7j96TW39tom/kFr+xymoVLpN+mUvUw82arbpLPAxhMUoCgaCcMFzkls71YLIWTlnsoCaQHd+p06hDyjca5LOIjmGkXZAsqH0cZ/Kq3RcFo6toPjE9UuFzs5SvUdxUyzw4M548rNF/RTW25PgcYSOox4s8tIT5XSbgshPwsrVVLBAftrFmZ8Yaj2Ih0cL9s8pABaHRfrQccQTJ8EDxXr0BxxZap/tJrZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlhlnOGnSqISvGH84t2AfbDNvmnVnGgNXukZQmIVfxU=;
 b=hxDF6UrDXGyYQ54JsPrkTUfufzJxJj91YS4XyymmltgFL4k4LrA+LQKQHZCHCft8TQNFyYDyEHqF4Gpqyen8zz87yYeNb958WHOuPxjAKsbTJKZZtJlD59Il3XWqruxl7f8ryKLeXQ3o1FZxG1U0rLFLE/+r09vAnplOCY0JxteJlFml0aTighglSuobrgfJd/IQrg2XnI1NHaZgXX2H5tQcJPd3OOcmQAOEQ+FGIGFyc7tETUNo78SWn51z4bFJdzwAoXtOzA4E18K7j5GbIru5ci0nWDRMQmpOqxlP1Id1ZrlFa8l3ALl4jPTm0l2qh0Fd9ZzxhG/JCK7bik2Xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlhlnOGnSqISvGH84t2AfbDNvmnVnGgNXukZQmIVfxU=;
 b=yCS5qTkMJXV8hqPo2HUqGTGmLUYzjZnDEpvxGV58yYbEpYu36MJ3pnbsIdoCQUZD+LmseR1m44tKf76pvpyS+Z0zK61MZtZEg2iVs4iHr2igh+uDpxW7+wfgSPgnxNh5Kb1EZU/srO37yHByuXGVsm3lB0ASHx2dyIK/vkYYtGg=
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 15:08:04 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::99) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 9 May 2025 15:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:03 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:00 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 07/14] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Fri, 9 May 2025 17:06:52 +0200
Message-ID: <20250509150700.2817697-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a5a06d-9525-4341-1993-08dd8f0b4bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ucPnBg8sWCAS5f9wCsxecUu3w5pjCvxPNSOhS4ksmM6PfaRgFuaoEKCqHtCP?=
 =?us-ascii?Q?hfhwil+arAldnt+NujxNwyZbdVcyX1C94GVN/pM+BFo5MoX81bfZuhZjAbEX?=
 =?us-ascii?Q?9ToH01Q/2DrwgYzI0po28lyyjSxtrq0GDvqeG5o3Vr/AbcoBmL2GHzsgV9MC?=
 =?us-ascii?Q?3sLvG8C7a3riW/MlzrWl04RtL+l4783PyvgieE5C4n/rcWtfWjNnh7AmiCRu?=
 =?us-ascii?Q?DHsc5Th/7rkcN3tGhzAsfm7hNlkb/7h9DT1woar+BYcacUX3bC7HWxcSCAKn?=
 =?us-ascii?Q?LaQLHT9gZMKAcmIJbhTYaW9C/N/0Kd9TZJ4XJnOUySGKZQhd2hqflXrM5q+2?=
 =?us-ascii?Q?nUachkw9zMiVmd6dEBFzEBKl7Z2nL2cbWGR91Gwff1nJlrivBOQIeN7ZHHpu?=
 =?us-ascii?Q?9bn665GVxETQ2Hn05G0NOgd3i/dC3DGNcwTAyKEmAeeZTfq8XqKDydE2tCY/?=
 =?us-ascii?Q?mehFbvRKdshz7QRSfhh/pIOKyFhWnuqaWI6ARFJh2n9yVpnUsXi3aWAE6KQd?=
 =?us-ascii?Q?vWmnp5L/+P4EH9e7G5nAWFxB1Fb7LBM6naw7GKGAS8Z3P8Hi+wB/KPbBk/ob?=
 =?us-ascii?Q?JXpxxfhkkNCh5foVceMJwfkZdaUqgzUeXf++HnlN/JivD7PmzuO1OfdwU+/0?=
 =?us-ascii?Q?o43tP7zxR2JtZxAKP6J/wKo1jAvezW1X5fzQER5NAZjI4A8XIHLmURYmyNds?=
 =?us-ascii?Q?9w94aT/OJ/W9YuTSUQRzaz2tu2n1nUevGbpoVjps5ykPz7mnCWZVD5gBkkms?=
 =?us-ascii?Q?w5lXs2144fxRWdJ3p33E/nmhTR3qPwle/FIgEJRQV+roPUiONrlMhQwUcRqY?=
 =?us-ascii?Q?VJy06q8TfE0Sw4SlEx+UVTuUuI1SEzgzEJJIms7t1u9mQE9uK78PyOWyhzg+?=
 =?us-ascii?Q?hQvWkjxS7YJ6uGKtBdRhzldV8U0zTYC8Acd6FlrpNeHxVoLEowl7n+v5MgL6?=
 =?us-ascii?Q?pziBEQG/J/xotsKhF29qc9hyF/6x8N6Qgf6NBfQvTksNVWwIGlfURGivRUmb?=
 =?us-ascii?Q?tcHWj87i62Ra8lTeUNKJlETpRTScE2K4N4bmgBNBX0NJVjUGnsTw2LCH8NND?=
 =?us-ascii?Q?75sGlVjWRtxjS8gFqO+GDbmj1e4zRNKInQKOoaRfsx5VnM19gKdeo3umdhMd?=
 =?us-ascii?Q?hOpOYVtd+xShK84wdY2xZg/PTLf0AJczeK6qKka28wvSBkUngipEfSO3B7U1?=
 =?us-ascii?Q?eGtCgSedGUI7jPfBs6pV5g4wXpciE4AH7P/66ZWXPTL1RIxU9hbnokFmQUWD?=
 =?us-ascii?Q?R/bWDIQlv2ZjMivpU3ntTEev3UB+nBswD34DqO4NdTGNmkD5EpjA09vDqGP4?=
 =?us-ascii?Q?ZeXYDRwGm8POdKO6GATU8JVO2TliKBZPAS00FyOkk1wyFPUyi+jhKU2Inpjz?=
 =?us-ascii?Q?wgoi/RK3s6Wru7yh6yz+sHEcT+NcL8zJxfq6EiemWdfIdCDkGDrrbaDUO2ou?=
 =?us-ascii?Q?H4D7MT+KHjyQX8rJNVSTp024/0aZuH/SPtofZq1ILG0M3xrjqgz0Ct/eq271?=
 =?us-ascii?Q?uMMVV9lG7+IXr6nw9q5Ivqd/bYnZZJeADwzX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:03.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a5a06d-9525-4341-1993-08dd8f0b4bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636

When adding an endpoint to a region, the root port is determined
first. Move this directly into cxl_add_to_region(). This is in
preparation of the initialization of endpoints that iterates the port
hierarchy from the endpoint up to the root port.

As a side-effect the root argument is removed from the argument lists
of cxl_add_to_region() and related functions. Now, the endpoint is the
only parameter to add a region. This simplifies the function
interface.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c |  6 ++++--
 drivers/cxl/cxl.h         |  6 ++----
 drivers/cxl/port.c        | 15 +++------------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 988de8e49df6..59d0d6becbd1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3382,9 +3382,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
-int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev, *region_dev;
@@ -3394,7 +3396,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 14e20b44f2f4..3266be2fe5ea 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -857,8 +857,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_port *root,
-		      struct cxl_endpoint_decoder *cxled);
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
@@ -870,8 +869,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
-static inline int cxl_add_to_region(struct cxl_port *root,
-				    struct cxl_endpoint_decoder *cxled)
+static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a35fc5552845..fe4b593331da 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,7 +30,7 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
-static int discover_region(struct device *dev, void *root)
+static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
@@ -49,7 +49,7 @@ static int discover_region(struct device *dev, void *root)
 	 * Region enumeration is opportunistic, if this add-event fails,
 	 * continue to the next endpoint decoder.
 	 */
-	rc = cxl_add_to_region(root, cxled);
+	rc = cxl_add_to_region(cxled);
 	if (rc)
 		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
 			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
@@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_port *root;
 	int rc;
 
 	rc = cxl_dvsec_rr_decode(cxlds, &info);
@@ -126,19 +125,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	/*
-	 * This can't fail in practice as CXL root exit unregisters all
-	 * descendant ports and that in turn synchronizes with cxl_port_probe()
-	 */
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-
-	root = &cxl_root->port;
-
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
 	 */
-	device_for_each_child(&port->dev, root, discover_region);
+	device_for_each_child(&port->dev, NULL, discover_region);
 
 	return 0;
 }
-- 
2.39.5

