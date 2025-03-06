Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89725486D;
	Thu,  6 Mar 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279539; cv=fail; b=S5raULfconUcPS/lmM3pjVXOo+EeQShDf4bzGc0RoEbjusmQG/6+HO/NaUrMgs/WLN6BrDnkAUoIw/aF74vFf+VdA5Bfp4H2m5QxyAdkDvnxPeP4xcZwRE+l2MQf3oIyvqXZfX829m3q2K3jJ69pue3+o3+nOtEbYXcmo585KOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279539; c=relaxed/simple;
	bh=u1IvfuoNf/RVdz63/cWhWSSQDpJmpZrNCBkzIgK1Ny4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzVaSM9cATyGu89Au36CCOjkA2erYEfz1pJf3Ls8HR80MOMvgzQ3SVjHNOLw53SqrWZL0TySOztwe+U4tPK65NmJWTXb5IRlsBvSuSU4mniGZ8kTAZILqwKP37eURkBGzwOakKcS71mX+Us/SwAzHyMkipduu9wEFxZwiCEykyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k46Tpa7v; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k46Tpa7v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7T8HcBn5+8JU4h5h5kxhXdoDgeeZ9OCEwxKBveYoRYFyxq/lc3kI504U4/biIM8ARtCNaVPy0oeTk8yzVZZUx04b/z1frHErGQG9Wc9NYY5OhnHkQz2vblv239vstatIc5gDSCA0JmDmt1y4T8xGBDhopX4UoBP0eGWxsomZsqjcjlbtMNccGIRmPEdAtcZuJmCQPr7XWMfgzG1bxmkYEYM02HWvL4sqPq4AQL1XAT9hPgv3OPOF3rUwmu3ixOzKR3ccRnGECBbv8maLq75qFe5IQYI2SICNgyPJpJIyHC+i+hQRTUXauG2iSE95JSWtK8FLPlBnLShkm4+IvT2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD+swixVqfBZ0kQEZPxPUcVQPWvZUVHz/vB2Lig+53w=;
 b=qQnY5OWWiiSJFYJXdwmhl+NoMKNSJ9Gl4hEdzjNXmPrn69QA26VV4FnOmnYV55fMOEPkLqHCizV6YRCnWW8mnHF9XhbNGqPZjVcKBhWUXy52oBC1x6JxoZPurN3U9Zb80cDS4v09LCPA5rwjdl2br9eQyHW5uTsep/qI3v0djlDoXl30KmZiOCiDQjlGUOEXXVAhqPZJjP+e8mpc5Xf14FgARX895mbiSeEXGZUwcuMKoTjoa8ReFAxDt8X074V7vaklqU6xqMONdlIVzhQuH+eYPM7/9b/TVMDv1OCJGIkZ8h/7jHsB8/TjrhAzmPe41R5cPOwQLSNYtovJfE4gaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD+swixVqfBZ0kQEZPxPUcVQPWvZUVHz/vB2Lig+53w=;
 b=k46Tpa7v/hLJO1ywXMqNa4iYNnOVaqdMmWLqwg6iobVvgLidFc5X57uT4cdSSXYGvSMMRt2pA86PSLa1lzC/W0auCPb7YEesAQ7e61LXf/wd1/GOc33llOYF4lVt18sZaTAgBhS1ZRSTtwc3uZq9qqfOHfqUWChsK1NxRPrhFis=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 16:45:30 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::dd) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 16:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:25 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 06/14] cxl/region: Avoid duplicate call of cxl_find_decoder_early()
Date: Thu, 6 Mar 2025 17:44:40 +0100
Message-ID: <20250306164448.3354845-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8803069a-0e32-4157-cb3b-08dd5cce4dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BsAGoTZH7/NyOLBuZuv1aZxhDty5w0+8Wpt/6qI6PDnGrlR+ZZdsnpj4ekTd?=
 =?us-ascii?Q?TRFO1R7AZk9oZX9atg97MRVBHFRNyMSm3uWHdVuI1HkMfC4bH75QsViiu8Lx?=
 =?us-ascii?Q?tQRuEuSLpL6MmaciIZQvDyYKw2VKNeW5CcupiAPevTo1SIogsKpQD34kWVei?=
 =?us-ascii?Q?av5evFhlSy82bMJFlE2mdLsHjjUiFfqyJ6KAj61yOi1D25CHi/niBBf3vYjS?=
 =?us-ascii?Q?WMQquSCQlYyDV0tPgJCq8eIU+xs84BkpWcgQSxoa22fd3RuqFvl1SjzPP5QO?=
 =?us-ascii?Q?vdXctFgX7X31TyFYHg98qySbBFVtO42evtkMS8ImRHUAC4vGi+PwyI+ivaev?=
 =?us-ascii?Q?BSGDqKcI2nHGQl3w2X67Se450OYOZHO+irvpDXLpRGrOBlvnOujPp6blHhqS?=
 =?us-ascii?Q?oZwjyKZYM9NJoonA250UGHQK8dOkSo7lLYL7uZHbZ1oDqqCpohB4pCUsSCsf?=
 =?us-ascii?Q?MvSzhxxwBCX+KXwg/xTkFJHdmBRI5lsNUya38SIpyYNGp0XYRrUj9E6Ntf61?=
 =?us-ascii?Q?ZFnHFFGHzHAop0zEfxRodU7M8tpsi86rfNGcFzVwCD9tVgQSboiDlgx5PZYZ?=
 =?us-ascii?Q?ABXo/f+OVChONfrdzSmplqijfZFQ8YBA1/3B/h1HEpTmhJI7rdQeYhycmH1A?=
 =?us-ascii?Q?HUw05VIMVOzKdhgT0kvbRELlvh4fnf8+ZWhITHP3HFNbOQCSXa4Cupe2AwtY?=
 =?us-ascii?Q?lm/OisYRaSBgesk6KH7gafsKoIYZCEEMx7c4H01TpmjrmEthT+xk+Mxhbssp?=
 =?us-ascii?Q?0EvMHRQ/vs3I2OXmNSV1uPeq3dP8MaEeouiCBy5Pu7FPyWyW5pVGIY1jz8bM?=
 =?us-ascii?Q?Oke6v+BgqyTBb1Lhtr9rSJKWlJAtMWe8xRgknNfPiXzcJfuQ4T5YiUdMTg+V?=
 =?us-ascii?Q?VsMCa/kl04Rmuj2XwNcrykAArw2XUTcRHutVN1+zWQqNEjcQg5/0UHSMZL0f?=
 =?us-ascii?Q?f/rtqHDGqx8jtnwZ+10142tqWSfYPFG/VsTMU+uCuaOfEHiGLzOqik1rpl7v?=
 =?us-ascii?Q?HKs9kIIKZM4FXFtX1knEfQYjbgT2XKbvyh/DG/sya1Vyp5WhZcrWCN149ecZ?=
 =?us-ascii?Q?i1+6PsEvQ+aLhh3D4wC//c1wphJ5Vwg3OgrZLq/FeirCqMsuHc22RM6zefg/?=
 =?us-ascii?Q?l7tTgU2sakwfbpXYM3fgn/yOfKALMi92PrKZM2k7MQJdEp80HHxWk/gjxNCh?=
 =?us-ascii?Q?EmBnMsFNKRn7XMFJXWrW3rojNLAAQZ9INiW/zOZiA1wkz1WS/pq54mPo8iyf?=
 =?us-ascii?Q?AnmyAWmsovSCcNaGdGLxt283JBQz/09eWZvsrrEDVVaWb4oduMrgSdiw48i5?=
 =?us-ascii?Q?s4GGBN79ErK2ZJ5SXcqfAFQMTqOBz0ZZjZvPldVDpwnoxlNC5ViUxv6I8mdp?=
 =?us-ascii?Q?iIw6k+Kaom7xWqmwVYeLqKgHIf4sPhTAF5rmQtsZrbnSTbzzL3VZ/she+B+g?=
 =?us-ascii?Q?QVHBct8fFSn6V3bYKhSrTTn3N8FchgW/690SxbOk04bMWoQ0xRd1hTiVZqvX?=
 =?us-ascii?Q?u8V9Fa/Zm5esTnU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:29.1996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8803069a-0e32-4157-cb3b-08dd5cce4dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

Function cxl_find_decoder_early() is called twice, in
alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
subsequently called from cxl_port_attach_region(). Make the decoder a
function argument to both which avoids a duplicate call of
cxl_find_decoder_early().

Moving the call out of alloc_region_ref() also moves it out of the
xa_for_each() loop in there. Now, cxld is determined no longer only
for each auto-generated region, but now once for all regions
regardless of auto-generated or not. This is fine as the cxld argument
is needed for all regions in cxl_rr_alloc_decoder() and an error would
be returned otherwise anyway. So it is better to determine the decoder
in front of all this and fail early if missing instead of running
through all that code with multiple calls of cxl_find_decoder_early().

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e40ae0fefddc..5a7a1dd583aa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -924,7 +924,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 
 static struct cxl_region_ref *
 alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
-		 struct cxl_endpoint_decoder *cxled)
+		 struct cxl_endpoint_decoder *cxled,
+		 struct cxl_decoder *cxld)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -938,9 +939,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 			continue;
 
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-			struct cxl_decoder *cxld;
-
-			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1024,17 +1022,9 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 
 static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 				struct cxl_endpoint_decoder *cxled,
-				struct cxl_region_ref *cxl_rr)
+				struct cxl_region_ref *cxl_rr,
+				struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
-
-	cxld = cxl_find_decoder_early(port, cxled, cxlr);
-	if (!cxld) {
-		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-			dev_name(&port->dev));
-		return -EBUSY;
-	}
-
 	if (cxld->region) {
 		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
 			dev_name(&port->dev), dev_name(&cxld->dev),
@@ -1125,7 +1115,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr, cxled);
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_find_decoder_early(port, cxled, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			return -EBUSY;
+		}
+
+		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
@@ -1134,7 +1133,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr, cxld);
 		if (rc)
 			goto out_erase;
 	}
-- 
2.39.5

