Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511B3385A7;
	Sat, 10 Jan 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045660; cv=fail; b=RTDbCYZNgmu8d0p74kr2Abz7X6FSzHGAYEBHNYfzt7uXuXsHirqblbwNeYukSEH3/XCa5P5SQBn3xUT370dt6P6zWak5ErRGDc3BdVziUC9ciCHtDc1kyb4W9yFXGRh+bc1d1aBQLacfAiMFOkdXgSB76trTSN7htQwUUGirSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045660; c=relaxed/simple;
	bh=tUua2U+PvIN3pqTqyiX8Sp4SX8iNQtEwFpmrdNx8dwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1fvkNBhl92C53jAKJOimbEd8/jAYZCP2EVijggs0FE09TF33MHa6Yo7gY/XVIKjMzx27i/7ZfrpmX768/ogc7YNKqPvBzEOgZFG6lA2Xg1JEC2Y112k4uXpF3Zv2YzByY1OaOE7gKLSuau1Zi5Txo8T5MSx/4BoFm/r0ETpG2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BJKO3Ikb; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BJKO3Ikb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhr42ZA/gtW/rySFLClSL7LC4vEmvooSQoGMvqWD8YWcGeW3RUzjseT+Hem5OodXsNf4VivD5oKZfdGi63CJlBIiJt8T9HvlNiMgbev1ape4t6xYZtad7cZWB0lFZq21Oj6WOTHQDTrVVp8atZzWIYx0ddE7YpJ3YZv73DeUSBKYxt62J/9CxYMul4Fl4bNsETdjS3mOQca5cnzKB4pvSv81U3gST5/+DkmcPx6vQI0IrlcraxFGIwHydF26grxL3UFPtwflSJU6U3yrREnzH7nEZcsONsL62N1tXuOwDqTuF88jgnW3ASGGrJuQKxbc9tMre+vpd+sevJ5GRqq6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJivIkN9kr3O0JnjowThX56YrRWDnNiFk0FWKB11Br4=;
 b=ehL7kmk77MgavoUeLg2cO/U07AI/wrttYWJMtgZN7xEOIiQ3didx5ADc6UtXTmydi/jFroygTBZNPT7SgjxHvxZUPOzrQ92bOZOfgt7rzcoutE27frRjpd9P//KridTBklbv9u+yQrCVEXAuIAB444OQAfFZVBBfBiyrGiGTp8ufn8717T04wnCu8mTcVDPoPOO052Gq2Y6AHmnnqd2L8vuTMVkO55w3l5zYZNn9twrGthF1hInl8PUYjqSHfI9Wjaq5e8LXYINaChKMeFeu2EKjexkOupgFSNSlPYLuXDLNsPZyu2NtFg+p4RpLSOm7bwFI6R7SrJJkKe3pglnJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJivIkN9kr3O0JnjowThX56YrRWDnNiFk0FWKB11Br4=;
 b=BJKO3Ikb6J0CIzbthXHcXFuqW18qd65ve9uab78i6sTp7tFnbcXybk1fl2JVr9drmCywR6Q1lI/BOPxOo+UB40lZDLkyMfpWND/8diEPfIimSO3SicmwfWtP6AF/VpAhWeRfqoPbs1M6D5Wv47T87bR6jNeCYhLS+A5oi/ami4U=
Received: from SA1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::15)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:47:35 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::e7) by SA1P222CA0023.outlook.office365.com
 (2603:10b6:806:22c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Sat,
 10 Jan 2026 11:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:35 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:31 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 03/13] cxl/region: Store HPA range in struct cxl_region
Date: Sat, 10 Jan 2026 12:46:48 +0100
Message-ID: <20260110114705.681676-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: abac03ff-0c45-4a08-4fda-08de503e0c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsSzCVWvU93t6Pk/ZztTPKxDYih7pt5o9KjaX1FUMXb0Pn+ixVrJ2rYcElIu?=
 =?us-ascii?Q?Hwu9QxWjLFDNJzkIWPbcaHczgqleqEnuCU5lHSeYtNNqaRPjQuGVwj3rcJtT?=
 =?us-ascii?Q?wzD043jsSHQg5K9cPjUCuKmB0/xQDZPubknRu7btOfrLUPO+Sa6yB6Du5rz5?=
 =?us-ascii?Q?fIIBMqNda1JSGrFdvocp+ZyFWACff1EFYyep+8ISLCd7dsvGfZ0k/Y5g+GUx?=
 =?us-ascii?Q?qBC4WpJ51vUZH4ci0fz8967TMRL01Gf5cy7W2lsPD6jAVOmIVHTHqKMTEG82?=
 =?us-ascii?Q?IYmimbgPcMtRC6znRBZB+r46mZ0kO3UEH7QBZY36J95A+4g/p0etSan24o3R?=
 =?us-ascii?Q?Pf7jVYeRBeBlldgYRiuIw/vlyRdOudTm2iiqVgx79e68SkvNMGZW5kBUM8D4?=
 =?us-ascii?Q?zXA0HDLst+f0CEhPe0CLrzWuQ4fruAtWX2I0xfWwSp0yNSB7dQ8e0b89oNRF?=
 =?us-ascii?Q?HVU/rnkvfI5ep193gzKM8wCEBycnnB0eBreagKQetdPlFKtemSkL5RRfWNqd?=
 =?us-ascii?Q?6/B6iPrfJ3xnl3l6qLfNX4nxpJUsGT0JhDTdFEfWceAYxxHsDlJSavpgK3Q5?=
 =?us-ascii?Q?Waxqkd7LnmxVc+MJfxiRUiWDj2eY1lf5++zI8NNbwEjPEFXYSt/W2R2McSl+?=
 =?us-ascii?Q?gGnf/KEEjqtpeqlgAki7xpDLU0t3tKCigCLYUgS91udRSR9ySIKPulcexE4T?=
 =?us-ascii?Q?b5QkW6VxiAaCO5Sizd6tmQTGCVnzosUILE5KsZ0g8KSg1kP2W7565fkigp7d?=
 =?us-ascii?Q?+VopsNSW592wvgtfZhRjzFxQpyjO6xd7h/RrXop84/SF/d1whnZl74KGPomi?=
 =?us-ascii?Q?LFaD7q0KpuyIKc8IpY+sJ7yU7SwjV/Qbs4i1xzG+DTmlzSyupGq/goZdlfa6?=
 =?us-ascii?Q?ZJ9qS/94DxdHryB6iTVjom2d9WKuFVLdf2X/LnfnwOcNBKVh+fFh2baaENis?=
 =?us-ascii?Q?QP+gBiwq6b8Skhp/Bbadsoc3VoWmJsHOvgchs2s/vof0Uq3rO3NMgMGcHzNp?=
 =?us-ascii?Q?9bKt+xdxut5dW1lhHjsvGRdX+hni97EnBCMwaHMPtXawvHS1bjimrJzK2lwq?=
 =?us-ascii?Q?nof6UftmbI7soox95e9gXLnbzMT6QNV4z5DS6VmuOHrVJzEYJET0V5Ku1rCM?=
 =?us-ascii?Q?cEGubXQzbJrXw8c2ClWIDtc4n2xzaFKZnoYm5IqqTwvyxL+IFb3F6uTp6cnm?=
 =?us-ascii?Q?m9+1ElfBEb67W7SOVXs11YgJMq4BhP4KmICaIld8n1Q5XTXLdAGk/h1nqV8/?=
 =?us-ascii?Q?+H/8FWUfgoF/qWfxwERCAbeM5vdD6W/+9PH9LLuGiaG5NFzBk7rmEtNIE73J?=
 =?us-ascii?Q?3tLj13ote+CmMu7iIU+SqR/SOQxadDeUz4RmMTOon11v/aLyHjohOUfWDFj7?=
 =?us-ascii?Q?htit+vCt0DWeEU5vW0wdze20Sse6BVsrlizTQd7j6bqpWecg9YRlqz7AEwbo?=
 =?us-ascii?Q?E//hjmEOtv4FkvhEFDXjEr4RWC/shS0YzsRB8AHqMpAyfe4HmXvF+DYz89/1?=
 =?us-ascii?Q?1RWC9ufAbLCD17h3VMpgBRekQ2qGfVGRr1E2rXbjvBYosM3nYcHrr3ljnBp1?=
 =?us-ascii?Q?UIufBgVUj6eLqixq1s8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:35.4499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abac03ff-0c45-4a08-4fda-08de503e0c25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698

Each region has a known host physical address (HPA) range it is
assigned to. Endpoint decoders assigned to a region share the same HPA
range. The region's address range is the system's physical address
(SPA) range.

Endpoint decoders in systems that need address translation use HPAs
which are not SPAs. To make the SPA range accessible to the endpoint
decoders, store and track the region's SPA range in struct cxl_region.
Introduce the @hpa_range member to the struct. Now, the SPA range of
an endpoint decoder can be determined based on its assigned region.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 7 +++++++
 drivers/cxl/cxl.h         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 22bd8ff37cef..04c3ff66ec81 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -664,6 +664,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -700,6 +702,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -2453,6 +2457,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3579,6 +3585,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 10ce9c3a8a55..3a5ca1936ed1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -530,6 +530,7 @@ enum cxl_partition_mode {
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -544,6 +545,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

