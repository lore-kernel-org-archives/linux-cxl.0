Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E97255E55;
	Thu,  6 Mar 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279547; cv=fail; b=qM3wR10lX6SaPv+YdBap5RZ85W1WxWgLEWjqD8OYLaZnsIMeOYEVwpVUSY9bF20ZoVSqJlpJBESbNzPwdZedWiv2jSufAh5vG4e1Ob8YCFdvwrbO5WBJj4Q4qo+g3OZWSkjlkF8y9oSr8zeS0S2J5Zx1fTWFstq6qWoyyyvraUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279547; c=relaxed/simple;
	bh=A7h+AtL8PaQpBjh05QIpuieTYJ/qglI42/UV7vkyxAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkt7PC/V6q9GcJpHjBFpMa7UYORDiwVsvLHa2gxQFv8NXR3ECFsFPxhxeFJuYSEHdbIeZBDsQPGW0nSF4iGkJMBiq+3f7yZ7PL0rvG/9TxZfitvVNsfrCtBBVLIt/FKqRwhNfvRkH9I5Wa8vUhbIu5gp3c5av0ubeKAN3XAMBJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hoeXtYuU; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hoeXtYuU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPp89iSfIsBM3xocotl0yDKGCMHeJAOiaJWBhNfSHQvYpcO/1HBz80Nl9+qbm6rIdXW7yYe5TAKCEqCuoeGAmK4xOu7ySx43ozvCsBkVc49Z2tIP7fidK2BPoKX+vzNkUl1UXYYupqPBkpdWXEC+sd77dV812HpHdfxbGlbhsCgL/kYe1ELuaFrPEMeMILBt0XAZoH/5xaFT4EW53ydkNsi031JC1jP8rMFe+d76WihAATrAUgPUlIr1XuIvbv1kIM7dKbsFNtQnk9wSPjwFPl8tFbDs10LkPiUpo7cINnJjdlSho4CCJsvzxANwO04DT5gvo8TTFks0CKzaTusJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZz5DJq4v6ay1Geg1DjXJxJGLS8WFfoNIC+nmrAgyvE=;
 b=o43A52FvtQm02P/BKHX2zoNE+eyb9o5AGZNeU3Xr/fHy61rgj7K4ng4L0EIabiy5ki6Z597tFs+tn7pZTsNYuvQ3IPPOEEEp4Goq4RfY9b28b2UKC2zUJNDPOoxcn+gb8AjJTEsWjLe2WJv/4H3EdnfJbYlPZa0+0zbW/V7WA/yUUH/eMnzynkI1/0p6o+KAMufiBn1RfBP4Q1rZ/UATNgPzxQxtxgayGysTAnR/vWeVamInj41xxyZ+JKNqpCHRiq+arLIntVTbkuc/LFazio7qcJd1fTXxyMS6icGth2QFrQAVdy9MZbbC8WqsNatI1Rzj8H4iHujrzzEIng4pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZz5DJq4v6ay1Geg1DjXJxJGLS8WFfoNIC+nmrAgyvE=;
 b=hoeXtYuUj2BBQYYx1gZPjPZgMVpBnlMoPU2UtKYH45Gusm6o44or6nctZFhKbU8w8VUtWyucGZngpCy6A6RyYF1OytCZIoBPzDzWR445vdkJuMUX5F9EX5Nbnb7dfsugq+zyald0I/lUSFlG2s28H1n1fgqpHnasPvwWRTs+cZ4=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:45:42 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::bb) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 16:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:41 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:36 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 08/14] cxl/region: Factor out code to find the root decoder
Date: Thu, 6 Mar 2025 17:44:42 +0100
Message-ID: <20250306164448.3354845-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 526bd804-c356-4cd6-3ce9-08dd5cce5543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1y2wp6x/m5yGMjT6udF4YsZcgt5lTYGi+dMgjWPIKNFsfehYlVJUXYgrHZTr?=
 =?us-ascii?Q?uwY1EzOfpDBgJK01I7lIeW9EZ+mAZnk6JrPoKdHVj7DHDe7QesRMdHA2UrfB?=
 =?us-ascii?Q?qLRaDhbMMc14TE2PsGELgNSXipgEZv0nY3Zp/ye9IOGOWaE8e3nViYG3+EXW?=
 =?us-ascii?Q?myh58vQbLj9wGC8Zm5ao6QlB48qK5ccoe1YyZBv6PrXqojMwSCSjOoKwnJsj?=
 =?us-ascii?Q?USP0g9nADaAmOEmq8Dy1q1CCT46UwpIrwQKbjfSEENoBMkTrVS/jObZf9ntm?=
 =?us-ascii?Q?0LxDPnuRWIbbag+molNnwsqdn2p1zR3PDQYmczk3g9nK3FknrPt/rdlW4kyr?=
 =?us-ascii?Q?JMRdrKzT0wVbbGJjZ+rvoNT/AXvYtFHGHJ2v6orrMMy1q2MgSWxCCx38A6c8?=
 =?us-ascii?Q?L6Jie8jByqFNKAlUVRcuLYPFJ943qD8guByT7C8Lu6bBAi4ToTb6VcFz/IKe?=
 =?us-ascii?Q?6hTCBnH2aXcFT3ccGO5ihAtZ2+3+1pVWeTowp2wrZRVTT3+rQnlCS/6MyP3b?=
 =?us-ascii?Q?fiUA1RC2sckRVpE61tMnWO2d6wV4iFKE/OSWkUX6G5pB26gfiF4FatFHiyNB?=
 =?us-ascii?Q?qe5tYfV5euYiC64kpFSzabXxHXlN4c3ygBrMoJmpETAPSH4KorLcsJfj+ruJ?=
 =?us-ascii?Q?MbYoRX+UR6+alz+dvJXL64Z1uy5NvWIC9IEElmwm5bv1+5k4NmqTBpVmEjHk?=
 =?us-ascii?Q?QOfAYCmYZPT0tar15aU5l4zIG3RU9ZMDezgq4GwTFKOTuzD/HX2r7yntnhiw?=
 =?us-ascii?Q?WT3uTPzE/6OUmQJpGtqVwOMLFs6gtaHGKcRQHd8SWKvyRxR0icJBxUYj9Xth?=
 =?us-ascii?Q?skUrxJQLXt/lMNVHiqa9b1KuQq1KwPUHGvyt4q9lKDXCc4W9dcfIVqlOo0jw?=
 =?us-ascii?Q?lJL6Bp5JEB2ZOqZIUkr4jBzV9efQLhiOuLLFcjNgprB6ruYA0S6WZz3NHFaK?=
 =?us-ascii?Q?cqd/Ho/FsVeAv/Vt1LXRNlVibH+tt0WNvJ6LG74yNtEQpjY9A8HEFoAJuPXB?=
 =?us-ascii?Q?bLD27f3Vi/lkW7q7hs63UrfLkzN+46GlQ5Sqgik3gD/AbVMMaMIN1gYpAr5w?=
 =?us-ascii?Q?OxHvuvhc71EIFH5lvQ4jQi5ax5l240zgOGMnA7RC8hRELSkGDIRIv50Qj/DZ?=
 =?us-ascii?Q?cmLv2uGhKjxqXs8FPqxAPpv2eSbJp4K0yLiWiSAUKkCwfkICAR84IQ/gJVSy?=
 =?us-ascii?Q?JijG3j1+dqd4x1bhAimKMjFTs5gmIfCxsThrwXywBABic+erN9NqaavPnuwl?=
 =?us-ascii?Q?+H4T01V73gxn6oyZ0wUlfvVu4mkHbeN6uLjFfyJdoO21oBfPVd03CE8cP68b?=
 =?us-ascii?Q?j1MixAGSIwdr+NIZ/hVL2AEcdi574S1Fqk5ig2BJVYRDg3JMNKLRD6k8tZi4?=
 =?us-ascii?Q?gdkidfAXLmIGBgBw156Te1o2QnjPQw73u+CnYq1vZbyd56gycEYbva3IgU2F?=
 =?us-ascii?Q?qG6RFdfYXlWLIo7/r8vuYP+nkPPrwNxiqIeb58xG3hD6HlKFrx4tZieIPtpd?=
 =?us-ascii?Q?t7gn4ihh0qZOQHc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:41.8247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526bd804-c356-4cd6-3ce9-08dd5cce5543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

In function cxl_add_to_region() there is code to determine the root
decoder associated to an endpoint decoder. Factor out that code for
later reuse. This has the benefit of reducing cxl_add_to_region()'s
function complexity.

The reference of cxlrd_dev can be freed earlier. Since the root
decoder exists as long as the root port exists and the endpoint
already holds a reference to the root port, this additional reference
is not needed. Though it looks obvious to use __free() for the
reference of cxlrd_dev here too, this is done in a later rework. So
just move the code.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8244a27d0fd6..7d9d9b8f9eea 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3212,6 +3212,38 @@ static int match_root_decoder_by_range(struct device *dev,
 	return range_contains(r1, r2);
 }
 
+static struct cxl_root_decoder *
+cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range *hpa = &cxld->hpa_range;
+	struct device *cxlrd_dev;
+
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+				      match_root_decoder_by_range);
+	if (!cxlrd_dev) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			cxld->hpa_range.start, cxld->hpa_range.end);
+		return NULL;
+	}
+
+	/*
+	 * device_find_child() created a reference to the root
+	 * decoder. Since the root decoder exists as long as the root
+	 * port exists and the endpoint already holds a reference to
+	 * the root port, this additional reference is not needed.
+	 * Free it here.
+	 */
+	put_device(cxlrd_dev);
+
+	return to_cxl_root_decoder(cxlrd_dev);
+}
+
 static int match_region_by_range(struct device *dev, const void *data)
 {
 	struct cxl_region_params *p;
@@ -3386,29 +3418,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_decoder *cxld = &cxled->cxld;
-	struct device *cxlrd_dev, *region_dev;
+	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+	cxlrd = cxl_find_root_decoder(cxled);
+	if (!cxlrd)
 		return -ENXIO;
-	}
-
-	cxlrd = to_cxl_root_decoder(cxlrd_dev);
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
@@ -3426,7 +3446,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
@@ -3447,8 +3467,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	}
 
 	put_device(region_dev);
-out:
-	put_device(cxlrd_dev);
+
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
-- 
2.39.5

