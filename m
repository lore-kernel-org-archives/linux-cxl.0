Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC921129A;
	Mon, 28 Apr 2025 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876640; cv=fail; b=raaLsHVSntg6ADkDTnDrWcH+v4Wh+jeTg6wlveIxtVLu1F+3lbNUgsdJ+yIAKddm9Iikz+88YgwWA9gJ3t2f/TSyY9i1/MtRZWstDos2hlrKynB6sJy7ndQ4yn6nD/r488r1Wtz6iQbqLGyjMSXAeEqeHLLApoOAs8piaGQnBww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876640; c=relaxed/simple;
	bh=VNKtQoLzoZiGEvZkxZ8tinJDjNVoPF1U3rU63RcRz0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBQ5V1O4POIXId/jNolH9A7NsK/0uktVtgQZU7t5VvQ7xwMIaxbMjEitbt1egWWiZH5/bqmcKTeKMGrxLUbL+L6sv41OsLea0WalKqk35JD0Pahotdkq/niMT5AWt5XmxFn5+5A8fsvjag/TZA7kud9TASizXInCQxmIldpN2Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VfaL1r8U; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VfaL1r8U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqOy0S9U2CwpoQSlWroOQl4/0uhDLzJM2Xyh9P5kei+la/PbK9U4bRdhKih7KNWoGlvrsPfz81Ix/ZLJUmwSb0z52xH3CZ4zmxbqUSPQ88YWtefojmTdgvKElI0V+c7O57Z5wXcv63tbcSWvy2s1oNn0yRiE8/tD1gA82UacV8UiE3YVEKTfIHR/ig8BAUB6BBL7YKq3wmwofFzIOI/YJLAVyxVW6hzwzNjiDNYdJFH3X2Oocccs3lajWwm8TMkCyNeLBbZqBMiyY13w86FWpgjbWBAnp0fm2HLU+f0xL+HJJyK4vVxYTW1bfwyc8tnKPaQ9elJ/UkDysCReG67SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUUMx7IWo04izA0cAlKBBdrPd8Fki81nIButEmD15C8=;
 b=R3wauLkMCb7FY2EAbFT2hlp/ldW/AIgOyroAHFErCFirnxhHyrTm8anaJBNOHD88fBxcdase3/WC3vSvYLJz46gj5J6DXILoKkHfq5OwCSJfZ0WnnYqEyDmPZueQiXerSuq6ySOR0LuTowEH+hN9MVZI7C0U6cAlYTl6YRXnP2KdT5/OaR/l1XQstsu4+3Jur0Hb94jUhcYnuxnH3R6Z95g3pUx/+kv2aZJwHZZSWi4hHRS7z0OK550aUQI1b03eRcaKhBDVdXl/vx9PnnVFtYMFa4E2+3KlPZqLe0r5SqtI8gw1lGJJypLSWgelxczuIfAAWmSPz6f9vuFfw2+tDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUUMx7IWo04izA0cAlKBBdrPd8Fki81nIButEmD15C8=;
 b=VfaL1r8UKBC03zvrOBzku9XrgizY5fE/0vnO3Z+Y1hbas1wANdma1mRys402YIinGqrCERnTiaqwtaiplqRoH6TCKpydOtNEi2lRii5MfY2ODnMN03MpexSEVuqCYxSJgc0RV02aWnnoFwze/LmWT5Fin3U+JNwTWXS6jrsYuRA=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 21:43:55 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::d4) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:50 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 05/14] cxl/region: Rename function to cxl_port_pick_region_decoder()
Date: Mon, 28 Apr 2025 23:43:08 +0200
Message-ID: <20250428214318.1682212-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: a60f77aa-1595-480c-b3f0-08dd869dc5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dq3JdjyflSCv+0nHlMZbtiJX/8p0uuzcIM6KQVrEdVUNbpI9T2StqUvNd9tI?=
 =?us-ascii?Q?DMEjguWnKgzW4z99eKvWxMTPLvl6b7zjSNshYGeh0YGLFGdU2PHQ58+jMoJA?=
 =?us-ascii?Q?ew/9pURVbpnobGHvc6edq6nRUy627pNC7VeMnUoV5Mxa8FM3Bt0i8K1G4AcZ?=
 =?us-ascii?Q?oA0bSMFlxPsqTvaS0WD/KPwmaz0pE0hvU5X/gw/1aWkL6c5+rimxgVe1d7e6?=
 =?us-ascii?Q?CH1e6mJmuj0KuvYhnJ8knbX3Hi3iayuUB0iQtFNuB9uScauCtI13IEDtk7MW?=
 =?us-ascii?Q?xoICKxIzByDpJmf/P39O5HKVD732OEkkCDTEzN99iL53BAEx+5cj9nTcoxHv?=
 =?us-ascii?Q?PZpDyIG46FCLsr3BGAzUqHWh1eaIigwTuRXNbUh8TFW8W7aiIb3VC+zNbs8q?=
 =?us-ascii?Q?8MRlyIIy498yvxnzx+LL7M2cg2xjBE8wZi0Ps1Yx6gD7C2Lq6HiDtBwtuf19?=
 =?us-ascii?Q?cdt8PF7uaZU7K1qDSRt/eoZMoBlnh3eWxBOAiVUR568JSb0TfOxE1i726jlB?=
 =?us-ascii?Q?KN1K7wEy5fTp5S12WEyffvVFG0Nb8+6SlfENDNTRdXqQ0+6eMWXM8c9ok4Bs?=
 =?us-ascii?Q?0Te+S8izp/N6jusQGJC+66JRQsqtTS6by+LpquvtO3caE6KcGhV5XzrVlaNk?=
 =?us-ascii?Q?MN5Tw+yb0thXjx9FTstRPnqZxHa9IuJL01g3DJlhED8JOTuY/IPVC8po115x?=
 =?us-ascii?Q?LWphKv6TnUhrbDizUtBZ/+Qw7PHtt03Nue+MWDjtPdjtkYTq8XPsXF7HcqDK?=
 =?us-ascii?Q?Yg5yLmf+dwPpjNvrKVr/9nENR/NuRWcyLhANGLrlimyz24mO5F+cdaAjd6v6?=
 =?us-ascii?Q?H+gOazYoQUB/CRpJcRzKV323hx+3Rdw2TcBFL4l0KFfAjqcdvMZDOZQXIxgf?=
 =?us-ascii?Q?v9HMuuX2OOqxRHve1PYlr9yMksrQQy3k0bDjBvN67ds1NSxIQejaIQDsnDad?=
 =?us-ascii?Q?SjrzdHy7fPpPNChlD/1oiCtYSwp990tdBk7GCs0rKSH0rctOB8+VISpdZM0j?=
 =?us-ascii?Q?8VnP4I/TZ1PEtXcF3zkxfkjvQsJWF9SUeGLfirx1KnWpN5Y0psVREsWwmJId?=
 =?us-ascii?Q?uPoTk67/l2EYkttCl85D7u8kiU5FpYv6QxKk5sdWlDGPUyD3mPc008yTpZoA?=
 =?us-ascii?Q?vifnCeLhfCFGKwv51htWaa9bDKyuCuq4YfDUitOBMN8J5WLb+te48rkIUEZf?=
 =?us-ascii?Q?VjC3thDN/B3l+n9//b5dDZ7kXceSwsL1BSOxfX1o5c8WUkYQufWMpPlhXXOG?=
 =?us-ascii?Q?pSuMhgRYOPAwUh2DujVVIcQQpDLKIGvu2R6F6BXYO6/1A4HC4ohQqcITISCW?=
 =?us-ascii?Q?hAVUH9rBgTowoj+Ag+rRd4K2tSBd93jKLq2pz8VViTFX3ctKrFzJQy276yAe?=
 =?us-ascii?Q?iW4u2s3iqUZUV1gZyxEtyujMnshuT5uOI/1G4fXCDG16FndkkEDhu8EGWLM7?=
 =?us-ascii?Q?l7i9iydnrGhm0VNjF+htxP4uOQXk6roMHjQO8xTMOldI8gf3tqv7BrhrrQN+?=
 =?us-ascii?Q?8IjOZNR8bz2lGSttgIaLGlLjWOiqXYs5LYL9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:54.2904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a60f77aa-1595-480c-b3f0-08dd869dc5e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

Current function cxl_region_find_decoder() is used to find a port's
decoder during region setup. In the region creation path the function
is an allocator to find a free port. In the region assembly path, it
is recalling the decoder that platform firmware picked for validation
purposes.

Rename function to cxl_port_pick_region_decoder() that better
describes its use and update the function's description.

The result of cxl_port_pick_region_decoder() is recorded in a 'struct
cxl_region_ref' in @port for later recall when other endpoints might
also be targets of the picked decoder.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e35209168c9c..e104035e0855 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -865,10 +865,25 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+/**
+ * cxl_port_pick_region_decoder() - assign or lookup a decoder for a region
+ * @port: a port in the ancestry of the endpoint implied by @cxled
+ * @cxled: endpoint decoder to be, or currently, mapped by @port
+ * @cxlr: region to establish, or validate, decode @port
+ *
+ * In the region creation path cxl_port_pick_region_decoder() is an
+ * allocator to find a free port. In the region assembly path, it is
+ * recalling the decoder that platform firmware picked for validation
+ * purposes.
+ *
+ * The result is recorded in a 'struct cxl_region_ref' in @port for
+ * later recall when other endpoints might also be targets of the picked
+ * decoder.
+ */
 static struct cxl_decoder *
-cxl_region_find_decoder(struct cxl_port *port,
-			struct cxl_endpoint_decoder *cxled,
-			struct cxl_region *cxlr)
+cxl_port_pick_region_decoder(struct cxl_port *port,
+			     struct cxl_endpoint_decoder *cxled,
+			     struct cxl_region *cxlr)
 {
 	struct device *dev;
 
@@ -932,7 +947,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 			struct cxl_decoder *cxld;
 
-			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1020,7 +1035,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	cxld = cxl_region_find_decoder(port, cxled, cxlr);
+	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.39.5

