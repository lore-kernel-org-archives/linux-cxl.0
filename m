Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059C25334C;
	Thu,  6 Mar 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279549; cv=fail; b=H7N+Mm2CTjGG0pzEHE9hoI2dN3Yz8xGNu+GRWRVlMj/M3vbjnqGcHgrB7WnN7EBboh3rCMv+guF45nLGTOVnoyyjIrXTncMIoVTbBDbA0vgPDq37vV38AzgzZ+f58LudUAqAvXdPCZqPd9NhlxZiFDqyilEehakzqLg+kxET+Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279549; c=relaxed/simple;
	bh=eCaukBw8cUoKNQzhdoS2Bl4oZOjzVRVCZYyHhR1LRGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAxt33mXOm0E1EzWmvbUQWHYNw7EtiiW6pZXU+2tE6DQsu+4wE1l5deycOCjnQdJVgyVkl8QvYB1YdUes1zskSM/zllsoVBPcSKe/yslN8RtuT6ygCKeQ2aI0RGeVzW5L9sIGc0Pj5TkWXpxq2o3Z+hugvO3893seUS3iWqzHH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e77K3sM/; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e77K3sM/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNdGy3egS7Y1Em6tfHwXCmPWkdVVd9xcoj1PpTuejeFoD5w904KTTjLgLcUFNR6cy5Kg4MkEw+oqjCUJNVwNqhqLYPqIWK5BQl4T0+RxaL+GHejrzpmerCC5DdrONLAkQwcLofDYANiySKrfdNP0D+ffXDkEQvociQ68Dt/N0hEb7v7FckL9U99s6UI0ZACO/eT6UqtleRJB/g7l0vWzAX1uPQpWd3MHbHl9uQ1T3Ye5GxbRIJZn9x3ATlcjLGaRxv5moRA84NJGKCdxORBPDsXkkZTMrbXK8JKY63TUJYzeUyfrSA3LxUyuermevnMw51feVdOYVh9GIjMPHlooZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wT+6LuaX391X/me5hc7//eactxEIRxGUDORxFtsRxw=;
 b=IG0MWavxcSOZekyV3SWGN2lhJPwGGKU4teDogvRuXazVf8aojTrKP/eiQ325eo3taJU3UEJ6pjya97INRgs8z/9aSI/NtE9SjawChnk96s+H8y2AS6tDC3UNtihulYpgKogc2Rvdw9e2/J0+9RGByWO3ICCN5viBRIqlQZQj0ZHQ1Su5okLdP70TXliFx/GLaZRu1aXKM14BrU6s2xYrF0I8bUgJlvhCW7z8+hHHTsR9DBeCEmpgy2Hzmghta3YL1JiqDvsQPASxlb0xC5wj4q97wKKwP1lgdZpKQw1RxiM65+1Due9xoqLfhzZtHssz1IkvwAgncjI65q/QDTp7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wT+6LuaX391X/me5hc7//eactxEIRxGUDORxFtsRxw=;
 b=e77K3sM/UGzw6CO+/lLdQLz+6Al8K50YZOAAa+g9i+i5Tz3TttxXllPMMED5dIuz29aPd2A8vbmrmUmBzbw3oQKwvKIcxkDcrjQ1ql3cESlqHA2SnEZ3dowDxhZaLUJZlLhXuLyrLSCAPrJf24iJ04w6FXux3IKAaaQKJN6tzhI=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:45:43 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::66) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 16:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:39 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 09/14] cxl/region: Factor out code to find a root decoder's region
Date: Thu, 6 Mar 2025 17:44:43 +0100
Message-ID: <20250306164448.3354845-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: d63aedee-899e-4f74-0116-08dd5cce563c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMAAQ+svEWQw6wOuEILVr/ItfbVxtKMuvmFdek3MHa6k4l2DP1jlYSAPMlyd?=
 =?us-ascii?Q?E2H4gVmRylfWAesXGf+IsnC6+NK6OFu4b4+uLTCxt9s0lTBAxesIpwC9ZIAA?=
 =?us-ascii?Q?nXlHSL+duFT6qcTG3CFnE3pQjbknstmqgbquz/wpuH/UUnWAuAYUB7ID2AMo?=
 =?us-ascii?Q?TRYp1zETD25i+1DTPeHBS/gECWhLQf6GmSdjaSSrPcRbJ8TvdV3d+DRQi3vt?=
 =?us-ascii?Q?9QgXy/uQvBxf41tmAGoVpedaHU2o9aRwgAs67rS6RztPK4gpvmhYlrNWO7Ko?=
 =?us-ascii?Q?IWrF12jKWjixSee+3KDT2Zk8ERRkXcSsF6WvNYfRBZPekmLDJIpEtMJ9B/7/?=
 =?us-ascii?Q?9zLOIYyDQJQZRLRGroCI+68KpgjsCrv+qThq7GzX8sQmYzqsJpcGSBc9yKYC?=
 =?us-ascii?Q?DLmrr0QuGLii8WcVZFBy4dqI2BncYvznFKmHw1FHeeuY2TBFUBkgYn8SuHIb?=
 =?us-ascii?Q?k3xbV0z1usmCflafOQPFpQMUQDVOPiSB/OrdShPFDnnTiHfV6PQQqhlTZuPM?=
 =?us-ascii?Q?S1b1UZQOLVMyMSYh6MQj2NprJpqW6QtIjEtCGZTgOIBglmqy0G7xDf4AOA0f?=
 =?us-ascii?Q?AyQgHMDvaR1a8mHrreUyuBRZRk2DcSBo9hhE2DlF1aoiyY2iQNyuLbNxvvO0?=
 =?us-ascii?Q?+zj0lxAEStFTUEim6RqILxezisyxJBErJXZ/wqQYs4DhSnSZ0eJQ4LwTvqN8?=
 =?us-ascii?Q?hVfFAMgUFfaZVNfOW1xCRtZR9/eoCFjkVeFcWPPEJAMHG4KPubHcmqJLpbgg?=
 =?us-ascii?Q?+cRUOt092uqAyPyiV1vm/ZaGTPDNTPHqWuY24o1Uy2JSqHvm4KPz7ZsSy1uA?=
 =?us-ascii?Q?VC4RpUUvDCD3PL7GJa4CeBN9RBOo893SVw4NPuXmfuF4PfmdoeKXVs1/PJ2J?=
 =?us-ascii?Q?CUxaHC6y49UHGVKUdPX8Q8PM8w3OvItCEG5U74Q85FiAtI0sa4EU5JTP57GW?=
 =?us-ascii?Q?kCM+JukQ/92hYYOUjLXW66sk55Po6T5bLVOK516JA2y03DMs+QdctmuqhUGU?=
 =?us-ascii?Q?JFlsAtjPstXo3ngoTBN28NZsybQg/4o07DVy18j9akOQyge0uSSF+CKOnnXu?=
 =?us-ascii?Q?bsDwdbOBpLY2teYawje94PY91vNvDZV/K67IfKM7Z8FPX8Z14tuJpokCWqbn?=
 =?us-ascii?Q?DolaUQq6yTOOEA4A+6Vv+7yH5+Vu4oT2adzu3CTBjeLWAO5z5ebFBMUgFBM+?=
 =?us-ascii?Q?bcDKzXL69wLDnHxgLRv9XwIpJeD6boL3cEJZf8knJf5ADaE1OBXYiP9+w2Wo?=
 =?us-ascii?Q?aTbgF+Cr9N0FMTlgSrkEso39xtJix1Sz3hiE5xXTr1/j1OlDf8nR/YBafaoR?=
 =?us-ascii?Q?FlLJwD00ol4HAFpW7HFZU1R84vJ0iBMa8iPHpqUMYQI74PfDdkKN4NtxnNvs?=
 =?us-ascii?Q?AZNHTV7qqiMJszCAO7ydD/3SuLxbxAyQMROJSedxbjTOiNfK2GtQrGyyKcFM?=
 =?us-ascii?Q?krLobGp7A1WzNws3+owYT3jxmxL6ObefHnNMa81kmwHIO84AI2TaODxQOeg7?=
 =?us-ascii?Q?k7/JXmxytWJgRX4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:43.4707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d63aedee-899e-4f74-0116-08dd5cce563c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

In function cxl_add_to_region() there is code to determine a root
decoder's region. Factor that code out. This is in preparation to
further rework and simplify function cxl_add_to_region().

No functional changes.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7d9d9b8f9eea..70ff4c94fb7a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3416,10 +3416,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+{
+	struct device *region_dev;
+
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				       match_region_by_range);
+	if (!region_dev)
+		return NULL;
+
+	return to_cxl_region(region_dev);
+}
+
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3435,13 +3447,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				       match_region_by_range);
-	if (!region_dev) {
+	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
-		region_dev = &cxlr->dev;
-	} else
-		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
@@ -3466,7 +3474,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	put_device(region_dev);
+	put_device(&cxlr->dev);			/* cxl_find_region_by_range() */
 
 	return rc;
 }
-- 
2.39.5

