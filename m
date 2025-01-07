Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3F1F2C5B;
	Tue,  7 Jan 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259074; cv=fail; b=TWVKzRPh3zQ1QQQs8wnkxFbXajTpS00f7LwVAgFiMcsVjiC7hHwNQoyaaUwbI+oASywolm7N4ODrPpp+Jl8ZtyEwVY06ksnoIM6hKwybFdfXkaQFQgBqdCHUtD/aAb0xrKbBKYbbk4HtsrHyihZikI3DWO89GwHRPZXywlTBOXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259074; c=relaxed/simple;
	bh=EnjN4gMK6b9f2BUtTbjziUPEG1En35oxa4NuPahiDik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKNcdYDA6QWUDe6eQgwWj/hAURDKZ7GjQ/fSCTNRHzcPEpUDXjXOkMJSlFsOqiHTqjRXVhe5f7DjmIDneqYfBbaWM2DQTIhQy+zBQLEvr1st0cCgsygg6L0zd0FxIiwpGA6wolJ6ta4N9tyGnnzeo4eEAK+cdZw9DEpEM9viMF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J9foHtWh; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J9foHtWh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7fQxrr3d+Hv2CLI3/oZad5rqO1KuxsQe9G0BdyooOK7U+Bc16Vm/UqAQUldJqRAPD5RD3MjvBBHl4mGzpawfYe2h/25/RCO8vTzVZbcvJhu0caFX6WXfpzTI91gza4cAx6al1HaTmPFZEjPDRsJwat9pp6PRqLMFLgqnkrXKa5TE43AuvYjkTU4EyRMOtDrf/4fUnyvsGMcsLMcJtitFc+2WJwm/qwG1DwYcCyDZJzO1NHz3xGzhFijuNF5RAf07kN9BWRQIeA4LfRLkIykNYuEuY1plobk1gjPTy1m8d80ZvN1Z6fddZU8eFePvWAUahHdIJj1+a0WluqgF8aTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whxyqsDgQ2ZyEwMy4Bj2/Dr14V03u5vdpzJP/Qvi6gQ=;
 b=AYDVBJl9XGxQiZGRsSgTRcVQMvPdxMt3K8G6YzVJ1lxOPj9uivnq5OdM9vjp0SifZXCTp5VYnfZz22SpduWQ0GOJPFeGKiwNCcP+/qR6PY6Cz5guVCjvI6SM0//qfGsGzWsEJzoLwOBClw19ezqW50fyOftz0QYnFtNosTaW0mqN5fjwRVfEz4QQqph/jxCFfWR2ySw23BcmR+0oqV08xa3lWbW2NCMhvVx7maTNpu09mMHVLBBS2IZMMsrroBTXvbfoBmPanImw6NdY+PjHdRS4h9UKH1Bv3BFvr780H6lbTVB1jMMQjbGqyG8F3GrMVoiGEK6QS5ZdaBQhy9uPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whxyqsDgQ2ZyEwMy4Bj2/Dr14V03u5vdpzJP/Qvi6gQ=;
 b=J9foHtWhNDjum6U21mahE3G/yPJHMB1uJEtY3X+mL9UarQOnX4MRglZ2+h/TqQ6Lbiay4zx5tylYUXn5+lsjs2UiWj+/d26qNz/w5KRIX1SJKUb66SJaXgJzPDFUMrCQgH3wSryyL+q2ZKDPiV2dGAoQGpfhVpOgXl2oPSJhEzo=
Received: from MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:11:00 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::4b) by MW3PR06CA0027.outlook.office365.com
 (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:10:59 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:56 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 05/29] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Tue, 7 Jan 2025 15:09:51 +0100
Message-ID: <20250107141015.3367194-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: edb6c9ed-3277-412f-4920-08dd2f251cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?myRnQnx0/2L0uNGwyPFMbn2uda9oXTV2xJVQpU2hfeBCiKUCgGN8JNR4riiK?=
 =?us-ascii?Q?+XDgEYTJBHWtI8A2lFBnhH5jfVs1RABXL2+17gsRWxqH5DAxGqYp0f2qskRy?=
 =?us-ascii?Q?3llh9S+ec8GGmE40+LJ9lE3tcozZji2Ob758e+TSQTIvzbiZI7Mzyy/TU0+m?=
 =?us-ascii?Q?fsGZUOK1Jm0/UUDm0C8rwLw25sIO8kAcl2v8t65paMVUWOX2wGcSWrhk8eat?=
 =?us-ascii?Q?0/9jB08r8lS9sBidCRkYQfDZE6a1F9Yj/G9uzLmcq5/IQrQCODXgXbyHLMYX?=
 =?us-ascii?Q?d8913FoIvDRkZvV9idZ3tBN/Cn0l1BuKrQp+/sYyVxwRK8oUNhlUP27BiIwc?=
 =?us-ascii?Q?T7vNpXhOGNBK3SLeP93ZZR/B3/gtptjw0lNNlZ4QEVSXNYOxPrU+lV8WqG6X?=
 =?us-ascii?Q?oLk/KuCGpIgGcwmnSeVCFAHqv1UVNP/3iD4oiV+di0ENY94z5MxkKwqxeNZw?=
 =?us-ascii?Q?K3GdfEVhhvleIZlKTB+fqO9jUv9mo0ooxwB8IyC/Liz+6j8bE+9rIKobPdWx?=
 =?us-ascii?Q?fyQ70q2TX8TBQR/cGotd4tdTURxNFqaHIQ7UtmpBGUQt0JpRX2RAiY6xdOYS?=
 =?us-ascii?Q?SxwQ0ZqfXQntFc8oo82RZgSB6pbIrPCrrlA6Mbsof4QoJOLbw5vVIbwwoDmB?=
 =?us-ascii?Q?sEw1fizaAv1kUH1zTRSU/tNKBGmXDY807P7cwOompmAOzN8ONLHG7b3uM7cr?=
 =?us-ascii?Q?uRVa5d4if0rBBS6aXuLdvRKP9ULxGqIdUwZ3J2CR+O1XuaxENQz9r4q7k847?=
 =?us-ascii?Q?3tLI8NbPQnq8/PUr43LYHbhZ4c6trbNICbQUlyqPxRfF99kav/vi1p379Hhp?=
 =?us-ascii?Q?ocsCTwX/C9WxX5esShfibe08DVUDZ8Gjlz6AyzmmV7zGsMUWKY1ioaThKnrM?=
 =?us-ascii?Q?R7dkaWVLqkwha3/9+PsqKtYM6XhPip1GUuvSfCno4jDDbkT/BxrB6qA1EVTd?=
 =?us-ascii?Q?C991xqCtR0RB29gvCpj3sty6BMlvH+4sjXSI1Qxddy1t/MMSqE4tfweYC8B5?=
 =?us-ascii?Q?qIJBL2s8/faZbxeKrQXVNy15Ibx4cOj63s27n6b6Zt8XKsghS4oiL3PxriZr?=
 =?us-ascii?Q?BsjGDdJDfIIXxzLBgULvCIil79YcVBgjRfKQzRq6puP65RwnFwKhnC8LvpwX?=
 =?us-ascii?Q?cy4EsJmT5nmlGQ5566N+R8gNw862j3ony6NZCD/H80+uP379QANBvoqGl1Tt?=
 =?us-ascii?Q?tXQSoCusbQcNbZME1v7W8YbiH47XUEUeO9R0C+k3UsheY5cU99oZgWOTxgOM?=
 =?us-ascii?Q?uO/EOPo0ZkTwAmQ+peWRKyplDfPOjAjQAlsj9b8MayLIRIkm47QgfIylDBL8?=
 =?us-ascii?Q?9gCyokIdIs9SJzE+8VFx0S021/ggIAW+rppTQl9ZBJPFxgLN40wicF7ZXshY?=
 =?us-ascii?Q?eB1n6MP87LA/sCmlAc+ZUHAYYBMEoTdD3mcQtPEYwRMCFj+Rc2nhbZSKTILq?=
 =?us-ascii?Q?gfESSacz+9Z5Uq5I66Nvy3LxFr1MbZdxdHkf6q++vEQocUzkn/C9I1i5RLQS?=
 =?us-ascii?Q?KQXCLCCFEXsas7M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:10:59.7050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb6c9ed-3277-412f-4920-08dd2f251cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487

When adding an endpoint to a region, the root port is determined
first. Move this directly into cxl_add_to_region(). This is in
preparation of the initialization of endpoints that iterates the port
hierarchy from the endpoint up to the root port.

As a side-effect the root argument is removed from the argument lists
of cxl_add_to_region() and related functions. Now, the endpoint is the
only parameter to add a region. This simplifies the function
interface.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c |  6 ++++--
 drivers/cxl/cxl.h         |  6 ++----
 drivers/cxl/port.c        | 15 +++------------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9b3efa841c8f..752440a5c162 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3307,9 +3307,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
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
@@ -3319,7 +3321,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fdac3ddb8635..5c1a55181e0f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -872,8 +872,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_port *root,
-		      struct cxl_endpoint_decoder *cxled);
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -884,8 +883,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
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
index d2bfd1ff5492..74587a403e3d 100644
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

