Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF92367A6;
	Fri,  9 May 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803283; cv=fail; b=TLD5+N4/s7wdX4oQY2mq72ejdTKKL5h8D+Wa9mvuelhfubLmfAABPCS+wk4ph6/r+MMMXpe9acSlUdlkdgKPGD6fW0BD2reZPWzOYh4LRUO++XMq7CDbzcIbznD7UHoeyM7lY9fU91TUQrvHM39pDtjxcKyX2cMXKNzo3lx+04w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803283; c=relaxed/simple;
	bh=Oamf70oASRqmy8o83ono98/8yJR8LM7Ps7+bvV1gsdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKUBwh0v0NlGq7W7ln9rEtBWTTijumUKjOB+yxYn/LEvoUsuXRB+i+xrB3qvJsINi8dx6d5ogZnNTHro7kC53zyFctC7tDyfi+88rhnTj70rLOc/3f4pDCWSntZ1SOkDcoshYM7+1X2WivIWcBOG3uiQ66GOsuXouSSf92ep8WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BfKMDkcd; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BfKMDkcd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDTtSNXyaMG5//TpIJ5ziywmCIzewODdasNaYmmHT1ufyj3lbr2o/iFJh/481z9GipKof0Q/9U7TU9r7YCBZsbpzNIYf61+Dfg0zpJL/dDb731IUEpcTW0MYumd9hRhuV5StYhUKfxJKtfcr/iENVZf8fBLYnkQVRtZupa+ZXUby/ONAfWpKRQNaDgKfhNR/oGeXx6uBSwL6cBXTmz1lhH/IRSjEHxG24ef4SltBlDZrUx8fk4pIC4k2NP1MTKHvVjoLU+AXWbqpVLZ2VPkORrY6kL/rBH7XzRnVvjqFuyasyJVmyO7+R+B3H/ocwlU2XaG811RVu4vWWYBAt6hR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyKwseL9ZVVnFD3/stsUOnZ2nm7ScCg6wDGQwiE8BvM=;
 b=Edq412IF2h6wBansMXM5ja+0FEjlBZiJGusHWcqJBu/EpKH9eS7y+ZWHTFLy/L1XCDueg7GFHNRLiEMCuAMTjNLSMs9clevbhKPcD4NKDfjM3HqMW29DGZNXj7mPEFjg8lPZy6l3tYassNOqe92NVStrpfoLbxiKQEteL2MYN1vKUeQqbMcsBUWLq08gE3ks9s1DDwbcRk8B2ekG7PoeNoyKMFRz4eZtQK9hiBOip8VSndQKtLsJpKb3Ub5SqfSfEvGb9MFmOPO+bNgiXH9bQt4P49KF70tBmFgrOzsc7jNAUoF/gSzLOo9h+Aq8wi7V7YnZzcLWM4fq/8AVUDr1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyKwseL9ZVVnFD3/stsUOnZ2nm7ScCg6wDGQwiE8BvM=;
 b=BfKMDkcdwFyTxMxtkbDihCoK6DMzG2KDpROrzuKOF8iFi2qMLGNmvVJVm44bZSREEEa9/lTU0LojWM38cThzNd7q5O00i1bCgBeN6Vro/+TS7TSqxOx6Unh8nBMLqz2oeeGhlcv0UKXu2J8iqD35bIFTUUXc4vsS+++7gTHbryY=
Received: from BN0PR04CA0205.namprd04.prod.outlook.com (2603:10b6:408:e9::30)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 15:07:59 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::bb) by BN0PR04CA0205.outlook.office365.com
 (2603:10b6:408:e9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 15:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:59 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:56 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 06/14] cxl/region: Avoid duplicate call of cxl_port_pick_region_decoder()
Date: Fri, 9 May 2025 17:06:51 +0200
Message-ID: <20250509150700.2817697-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c66ec92-5855-4f9e-7018-08dd8f0b4933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?el0VamybHjJM1Exl5M8y8EbE31ijLucN2T0J8xON88gbIUD381EaxCCqGvth?=
 =?us-ascii?Q?pOZxehJr/O8IsLKl4HZn00LkYJIFcr3YZ+QW9jiKwUFJ44Aed4NAN9+0KTe5?=
 =?us-ascii?Q?z0l8kbyGQQwFOiu3aUPd5fFTusaczz9m90QYBqAnNwnYv57mH5igZ/864HJz?=
 =?us-ascii?Q?TYSp8/vmSj2r0CR7WDvcbuF9uKxXXsatQPbXg/XUAj/D5L4bVAEBNKa9ZZTS?=
 =?us-ascii?Q?2tafozPC2Dv0BTr7+AillHnwC7Rd6/w3Xd476ObDRCrBUncRuzh6l3imzKXX?=
 =?us-ascii?Q?0xU4SZ9gImnTnyoEUJHkTjTFnGXVUS2+IyzWflOFhFQgu5kKl0IewxtsjuG2?=
 =?us-ascii?Q?HtqJ5gRf+pa6LWOhxXSVr21VOOVbRK8yH+2S3XZHEMEN7dv3/0vSSkTa1lDo?=
 =?us-ascii?Q?gee1rD+fCWTsQALyWgy0jgHwXGYhb7dpKUWUYau7l9EaAVceWuSj7BbNhJ5L?=
 =?us-ascii?Q?MfiVtunvrUDkqVZ+QPWUeA20BycVGVknmMQbi9Cp8neN45L9EeeApLMM8p+t?=
 =?us-ascii?Q?swkDqI2JSUfW3e88VuEOTe8Vzuqr4lEpCbIzVwSOFx8N6l0fWsbiwNpOCQY5?=
 =?us-ascii?Q?2DRj1psdMbKKgZp4qHQe7Ij/hT66TEIwu0mjYjM2xCnHMXGTdGuX9a20SAYe?=
 =?us-ascii?Q?l3RK+pq5WRG7NwVpDsTdFbIff/YOJYr48ICfULHmwg/8dnGt7ZHLCVNAZadC?=
 =?us-ascii?Q?qBykbSt86jk+DzqLbd6bpJVCh4hIcar/Pi0IEfLknIVBKZSxK7agtfhFvwun?=
 =?us-ascii?Q?C4EbRM816FgeAxgMdn72PnupWhdij4+x53DNa2bkdQrJ5F0MR8/yTSruxslo?=
 =?us-ascii?Q?lzi9s5MSFByQBTPHr7e82ZcracBtxLHc0z30zygcukE5qo/PlMpbFFVMHy4Y?=
 =?us-ascii?Q?mhpzQbPNzEC7bAaUiRUOcrJ1w/7rbqgrPZcu+1TbCBXjz3V3nJqX/+1xDIx+?=
 =?us-ascii?Q?ERN2PqW+Aa8ztQ3ms5RPhq46ySkjf6ybX5LxWBGNd05T/z75aicrBK5GLmSR?=
 =?us-ascii?Q?/ML+i0ri/so7+b+E2G3BHPBTOJXzlBGQjJIIiYH83P7Nrkh6fftH194SqPcn?=
 =?us-ascii?Q?cuhkhvVm1qqgqyrEFGdBcLY95MwUEn7uMX+Fagb3kwss8tpCRCszD/9OA3SP?=
 =?us-ascii?Q?COSEKJg0J1Vh/sgR8F26CTgu7sVnS9Rl8m3TA1KoMLJLoHdvMI/sTHuzmaDD?=
 =?us-ascii?Q?6WRPQm4gD44cnGO1l3WJnfiaqeHcaYkuceeV6C8bIgCSAfFqixdZXI6/dvHj?=
 =?us-ascii?Q?O9akrqtCZ+wA40KnsdWUCOWJCJEpUCSnrdVYmjX2EDSwRu6siUC5bxCPA+B8?=
 =?us-ascii?Q?3/h0sgsQmrSzJSWr6swV1Y5jMq6OtjseZUKFg9cihtGLvW22nqfcsDl1nh2p?=
 =?us-ascii?Q?5ur8v+qQj2OT32DOtLugQILDdVqffUOPan/Wc38pFJijy9Bj0DkTIKEYRzJf?=
 =?us-ascii?Q?GErBr1dPSq5d5R4ntzA4cFv3Vnnl59csR+gamS/DSQvAbKGs78mJ1E+a9N64?=
 =?us-ascii?Q?9UH22MsFTobjgbIS41Xm4M9+k9ELsOf3hGUs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:59.1557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c66ec92-5855-4f9e-7018-08dd8f0b4933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721

Function cxl_port_pick_region_decoder() is called twice, in
alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
subsequently called from cxl_port_attach_region(). Make the decoder a
function argument to both which avoids a duplicate call of
cxl_port_pick_region_decoder().

Now, cxl_rr_alloc_decoder() no longer allocates the decoder. Instead,
the previously picked decoder is assigned to the region reference.
Hence, rename the function to cxl_rr_assign_decoder().

Moving the call out of alloc_region_ref() also moves it out of the
xa_for_each() loop in there. Now, cxld is determined no longer only
for each auto-generated region, but now once for all regions
regardless of auto-generated or not. This is fine as the cxld argument
is needed for all regions in cxl_rr_assign_decoder() and an error would
be returned otherwise anyway. So it is better to determine the decoder
in front of all this and fail early if missing instead of running
through all that code with multiple calls of
cxl_port_pick_region_decoder().

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ddcf4e54e2cb..988de8e49df6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -928,7 +928,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 
 static struct cxl_region_ref *
 alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
-		 struct cxl_endpoint_decoder *cxled)
+		 struct cxl_endpoint_decoder *cxled,
+		 struct cxl_decoder *cxld)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -942,9 +943,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 			continue;
 
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-			struct cxl_decoder *cxld;
-
-			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1026,19 +1024,11 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	return 0;
 }
 
-static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
-				struct cxl_endpoint_decoder *cxled,
-				struct cxl_region_ref *cxl_rr)
+static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
+				 struct cxl_endpoint_decoder *cxled,
+				 struct cxl_region_ref *cxl_rr,
+				 struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
-
-	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
-	if (!cxld) {
-		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
-			dev_name(&port->dev));
-		return -EBUSY;
-	}
-
 	if (cxld->region) {
 		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
 			dev_name(&port->dev), dev_name(&cxld->dev),
@@ -1129,7 +1119,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr, cxled);
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
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
@@ -1138,7 +1137,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 		nr_targets_inc = true;
 
-		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
+		rc = cxl_rr_assign_decoder(port, cxlr, cxled, cxl_rr, cxld);
 		if (rc)
 			goto out_erase;
 	}
-- 
2.39.5

