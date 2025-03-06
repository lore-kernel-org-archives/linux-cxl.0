Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2E257437;
	Thu,  6 Mar 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279546; cv=fail; b=iJmcpe3TcZbtC5u0uQ/jfBpClsBj6T04aOzrPvqq88JD+xLHR9MPWP+gIx3ivQIeHd6zDZtmPAwDDPdLJVfQCoXccJBdGsIKdimrvfu8a6ylG5SV2PAlnFBS2mp0A2kti8KdY9E/dGFuv5Mh2wNnbK2fpCZjmbAO87vDquK3eaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279546; c=relaxed/simple;
	bh=UFQBkuxJzFs4K7cZmG9oqlaVqczn1YQC/9dqAyRl67c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEzeOQt7xOaqSGCjNq21ULvM0jOCVZTz2jPzIj5LSrK352jv2kgDC0C4cPEMD02jYfpC+xTGTiEHD1iMVJNke9dJIINqiuFMIue0oqGGI5zqMUea4wlk+mBubp5sAcoycd5oghzwtTpAjsMtBIUNuS48MfB1j40DA0ix39tM2hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J21MGZDq; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J21MGZDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K18UrPyXj4fMtE2dDMBys8LIXh5g90208ra+0XlmDDTZ6XL5NQSOxYAtDXrY3nw5JGOKsU0F29i+kxYb8H1l48sfQHVogS6JCDShZpGgyM431CFFzp9S2KOKkKTJmwXdAvgFQNImQuQgcR7KRQZeYrGrZhl7AUbKR9c0f5ZG5q1qbXQUVm+toY4P1eHSie6l2b4aWuyJuRjsBPm6ywZ7LISwABCoxQZ+ybzCaxqE1IDEFRo9FwoxMpXORjdNKEFlWD+mc3xI+aJn4eadzcSc4pK0Nw4ILHRgrPAYBzi3oCmUz2e6IX6h+pbfHpI/VSP6rCL0CfarwweHr/kmXzgwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6Cil00/1reT36SE53vypkTZFVkHsLvsqdGmgM0Tf6s=;
 b=ASPmQk7OroPWo9wWWWj7kMCggraPdYzPLhlUHAD5Pn4kySB9XwQaM/UrKauKfuUh3b6JzcTEoCjKNefdUPd19Gdqj56dlEcfS60+TS2RSHu0R+3NgQ90szl4NDMuNKwRm33W+lNKh+T9yENhvXf7J8+kJrzDeYqTJ5mILLLZVAuSJoyNfQdKAQ986nnOFqgnVn5iXJ/vfrhAXUkfapMEStzbVxKvOl54csTA+7PZbtaKC7mTEEc9P4GMWKNfN0DbsZQhc9NRnVsAbVd4hrGvc3+Kc7rUyrd1hGOQiKTGCmLRdR/3Jjin0q/iZRpx4lltwosLMU6IDHAhkoNz4bZy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6Cil00/1reT36SE53vypkTZFVkHsLvsqdGmgM0Tf6s=;
 b=J21MGZDqk/+T7ahr3KkcztDTLHILwP+/PwvNw1GnslvpqzjAlWw2DuHVtLvS71X04KRYmK6DgVFrvyXyCzBLBYJIiTb11M8tw6rTdZkO+nifbnOW2mmN2UcEH7CJzA3jik57wl9qzza6tGiTe7ZdOigCJSPR9FcfIkCfUoEt3y4=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 16:45:39 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::1a) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 16:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:37 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:29 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 07/14] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Thu, 6 Mar 2025 17:44:41 +0100
Message-ID: <20250306164448.3354845-8-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 7494ce1d-3256-4ce8-a726-08dd5cce52c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WDEkyVWHx8KY6uRnTEOJ+/8JAqgIl6SUKG/0Wqd3XWFCwC+sbCmY5fAFYTHf?=
 =?us-ascii?Q?mCXtkZ8N1uSPUJMDflRc/t6Z+MZcUk1Yq0Vej5BSmn+SRKfY5GjgEszugaIw?=
 =?us-ascii?Q?/zWSg4caHeTsinfZ3E2FEhTcj+HZln844ks2yWoYRmSxTh2oSI83LY8odtZ7?=
 =?us-ascii?Q?6CPVibMCZdCGGPCvIe4/wcillDBAXIHYA8rApiZnbj7wy8roSHV/XVTwBgQk?=
 =?us-ascii?Q?Geii2IArNEwkxdD0Ep6Y0ayiKpKANs4bxSUOLlWWmBqcyNOLVRbhtQt7NXQ8?=
 =?us-ascii?Q?2sBwBsaCfhwoxZEa6iddvfsNQzXr9ch0A6NHbdOTaAMw26dTDi5HIDNqQs55?=
 =?us-ascii?Q?NGyghZ0PtnwuZJaLx9B4dfLpYjKCX+4O+hjNF7zxcR6Ll4DaMbQY2HMCTEy1?=
 =?us-ascii?Q?3yBfOGTzrsdS0LsYxLU4pDmhfNkSFcfBE++YMqi7w2OONhYBtz5RBbHrKK7f?=
 =?us-ascii?Q?4bKWPPh5vTe9TaWFoYPf+TzIwKjhpdvO0UA6hdr6QUif1BJyQZnb/RHjPqgB?=
 =?us-ascii?Q?7kV56wmGbt30nvb0L6Gv6cAldGXu56Mh+imIUgDmYCxS5eYe3mjB4JTbEp37?=
 =?us-ascii?Q?J5Ymvy7gQRR3zoKWOSUtwOZxitpCjal43GRfMvWS7+QdeVN8U1O1d5BLASPo?=
 =?us-ascii?Q?6RXDWrAm6drGc77NotmA0NEzFMS5+jdehPBduWMFsIYwWtzm1sBzUH41pRR/?=
 =?us-ascii?Q?AvzxQvQ4wOyCXBSXA1NBxP+iuezuV68PD9gFXxIBtvfvRXqhvcTLMxrFKXkk?=
 =?us-ascii?Q?mmzh5PwFuwMnvay6xopAZLfWSsMG3dOUu/r87pIThCDBOto8OTgs8e7H0KOn?=
 =?us-ascii?Q?CHLlQ/7FSM2076kgdAk47lCKVXcsju9pH2AFLKMli4nFtgVWoaI551rrIAlg?=
 =?us-ascii?Q?yNSInh0a1Omy5RNtLAZbYC+Mrx0abQkfKgJBwt3zyWu8IvWYfgS7+UOoC5sc?=
 =?us-ascii?Q?/3GcCNwWBFXgvrNhruRV89w2thA865+/mpV1NYiM06S7scSvkTomvMfC5fnS?=
 =?us-ascii?Q?rFnnPTPiKPiAmh6x96NYJf2f27MinE6kOEbUs0sV+RcjzjO5ywnJqylUjTvi?=
 =?us-ascii?Q?PEZ87iuRZdYcLopD/jZQr0L804lDTbU0q2OYVyDOLIELzwlHEh5EeBi36cJz?=
 =?us-ascii?Q?v5X8YSPQmdPRmOV6H/V63Y9NEFPqKLucPN/UdA4v+VwyvxAvfQRCe9/j4tHC?=
 =?us-ascii?Q?ICjxwaDOIsftvyxczdLzdflvAZ2Ap4dXDs0by48i3W11BXVZOHIgVFovwCom?=
 =?us-ascii?Q?bcx0DhzPPOC+KJBakNw8O+E2YCDZZhGpSm2dYHwyEH1jcmPZTviAQ2aiCjeV?=
 =?us-ascii?Q?pSGxO8liJiW+rRvgELjZHNPmPxRhDW1En0DR0zWsceK4sMhClk7TEuxpE9m/?=
 =?us-ascii?Q?jgIVbWHRSUeRQziNbZbYXzAI4bwWsdz4SEp3BcKmjiOb8b7hcfrOlZRef1Pk?=
 =?us-ascii?Q?UUWlcj98C3DbVpQethx1Su9w07ZFf3upRyveHws6VyLL6Z6NHnxPW2OkvEM6?=
 =?us-ascii?Q?1pM4aU1B3tuXo/U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:37.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7494ce1d-3256-4ce8-a726-08dd5cce52c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

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
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c |  6 ++++--
 drivers/cxl/cxl.h         |  6 ++----
 drivers/cxl/port.c        | 15 +++------------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5a7a1dd583aa..8244a27d0fd6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3384,9 +3384,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
@@ -3396,7 +3398,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 24cec16d02a6..960efcc60476 100644
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

