Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED92BE053;
	Tue, 15 Jul 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606812; cv=fail; b=BYHSrGvd2vVbtno293xei0cjsK6Hx/urL3jhOySXUv4Zs4uvz4NDVMCPTFTRg+DDAdZ9EcjVjsakRwptwtZPFVONl6ApHNeCbtMrn0/8bZdFyALR5MwvQxOufVqY7xrWn4A2s4xTO4HL4dpCkTKUssYmEOxeqww7x/bpOfiXVi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606812; c=relaxed/simple;
	bh=Xu0GA1YJAwCvRDFLYnxWCkdKgP9XzJ3RnijdHULK26s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEMKt3Iy74aV47qyVHZdUv5AtAkAgSc0e71K8olDGoAeGW4KohsljGxhe0uywnYi8zITrrXv+1S+ipD5u1e9Zq6IHyXtJcikzjRwzRxkrUrDzdaJslNfyI88XC1A3uxcBaR846ViAbpt+1rEKZxugZsfI0zH5SORpqAT8CipL4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEeQJNx6; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEeQJNx6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWxxbOycbRyzCPw7cGPZZsW8s3yThWCFhQgNear3c/jn9GsNrZBsaBWednh7tvhlA+Tu19AcUdIcwtjUozPdbz7JfvGBY0Wq/TYyn893FB4NXzTbalXrH3Z9UCEtokPWO4kIY6nzbnRNiuU+7CZU68gJ10Il0ER+Mej/mUUEw+fFW0CrpL7FHDvp8WmPO7pfRhmgrl7iuvntknAV5u1eFWpjfgLLlQgny70CFsuxMqSbfISAqbZPYh3XPrxR0mvZPdZB8u2JpmbV00U5c4QBuTcPOIWAtO0SlRy49wuk1SZ2dpWsxnss1SXvwxoetD0dyijxqYV8Js4I+iuQOt6Qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVOhtcGltJs4OysNnljLDQxy3rYgb6c3UF6qSZethfE=;
 b=wGqz1Yxw08Yd3PasQ5Ws6T7dgBEir0DSCYAgg5Xp50Y2ExLk1eNocpqxA3SupMNKFtjAbKrLWMJXc5IOPjzMFzX03jCeoiJIimGozzk0T3/sWwyfLKkeG2phDvy7RPK2uZUV3T6+4AvxhOhUHwWLrlaI7UYQcOQu2vRgCNP9axzMbyCBG6iy9bvDbUEndj7UMIqRMpii92c2JvUCz6QHTIRdVkruXGBCG45CrP+0pc3daU9tUXOgRVTXOuDQhgs/Ib+Cwzuo5vGIVFJCsxk+W+XY0gP0JvAAdFuEDJGK6/9A6U3tXt/c9XuUrOsNEzTFqLVR3KpCGuizYMM5HgNXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVOhtcGltJs4OysNnljLDQxy3rYgb6c3UF6qSZethfE=;
 b=PEeQJNx6jJETKj5Gkr4LJAo0hCl4jG0BSYNWML7dRDyBzwDlOfXqACYOMHqYGjA+k953eh1Lx55YQEjdMMXB1opmzvxJyHtJUrbZ9hfELD54n3904fm9DYITSzxGyAe/bJn4IxWIhpGbt928KqGUX0y8Pjx5AMLwjyoMrEcJ7Ro=
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:13:25 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::7c) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Tue,
 15 Jul 2025 19:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:25 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:22 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 20/20] cxl/region: Early check region's interleaving configuration
Date: Tue, 15 Jul 2025 21:11:43 +0200
Message-ID: <20250715191143.1023512-21-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3b6ff4-e935-4e75-3e5f-08ddc3d3ac62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QRRWu/9UyCh5AKvd/nWKurHX/fCLoIzSeLwtXUkApIBIc/ePer0D5M+4t9E?=
 =?us-ascii?Q?qAp95qDi3427aXD1wFrAeAm3UEoDWri7wUG7NBmRJ77da+FZ5PetzVi5+qSs?=
 =?us-ascii?Q?aDQOkZQeC70BsIKyKl1gPyh8vOOmOfn/kLvmhREPfz7MyEX292GQh+YtJhOX?=
 =?us-ascii?Q?wbgDf+JESps3cpPRYN6rEFbXN2BehbxVkzAw2R//2nK+8i4VsrDMMWBVInAx?=
 =?us-ascii?Q?8FXDiVesJDPJeof24MFlzeB8Tl+k/PEpB/Z4pLD1TRTxHFIa4ZQT+Fjp83zY?=
 =?us-ascii?Q?ABe4NQquX/Qohq/oOoREYRZzn8Hpgy+R+L/BPDLaR8i0csnJob14uha0qM81?=
 =?us-ascii?Q?JQWpowtXYs5FsnOVyrmVs7CDqbgzcHwKKt0P/TBDmOH+MKDtdIxL+4TbC4tl?=
 =?us-ascii?Q?OUlqz660HGWaWqhWanTRmPm8n+CvaPuP8auaovpq3Pi4j4cpFCCxxM1TWkfG?=
 =?us-ascii?Q?Ck9+0NuvxwzslleapMFZ3DBhJTQMTx8Y6o0C9FG+kan1bqxT2LYuYCf23MgX?=
 =?us-ascii?Q?lfhnblF3b5aCADwxyjSYYLk6IWGy/RD2ifwVLpAp2lwp8I/E3LtCc0SK3zqI?=
 =?us-ascii?Q?sMp9L3KO2F8XasXXLjLrXhh3gT+z9P6qPx6Da3JmF7B+4weDQv1OmudlM8JC?=
 =?us-ascii?Q?VY2WfTBAGLv/QpuahjEAtV0vZJ07jsq6iinMz+h3eLuqEXeGQHbGwsxKF71r?=
 =?us-ascii?Q?6g1Hq9Itbv4Ll1mkmNMt2guQgsT6H+bRt+bv3J3N1oGgo57CeC6yPuon1ZSA?=
 =?us-ascii?Q?wVV9nyuk+y9VWYBZ84oBf6uW+7/iu/vVPqmSHiDy0fknfsqqScPsECllICHl?=
 =?us-ascii?Q?m76d8EoW/+wsNVWy7g/KvceOH1bkpVp0VV3nJXGqiOPHazRGtRF43syjAORi?=
 =?us-ascii?Q?iNxc6tV3z6cthDuZG7xTxt8nUtQSfIGVl0DUMToVCDA08FPrjMJx8q5zCSQd?=
 =?us-ascii?Q?886VFhgh+CbP1SHiQYThnEyGn4BGORVl2i7oZus0udY7oth396rqdJjabNdt?=
 =?us-ascii?Q?Tdv4Q+Y9Riy9x4M+beKG0h0ULzrtWGpzRc9EuAOcGB4XDLYAccQeie9RelDK?=
 =?us-ascii?Q?FYnUSni1LslNkrTskh5dqaVYrK1FLfZyyR9aiMw/gRnaMX7C9BXdLXh+KFaO?=
 =?us-ascii?Q?USBPYoySAXEawSiXXDBShbYqfWXW4Dlg7yvmEvSoyhPUhY87NpHUtoR20NIH?=
 =?us-ascii?Q?YIkRX0SvlQi5U6EgNK1TQ9yjxL1k8Ly0f5jYlDO0hRTOaUToORRK1G9syeQh?=
 =?us-ascii?Q?QiAR7ccunrCBPGihS4Mxqv6nvno+y5Qt2vOe3MBSR1ae22HgWpuU6Wh/8eHp?=
 =?us-ascii?Q?q+2ETGVsra5zYw6BBXMQ6P7qhp1x4CHVyEUoOpwP5VwdVIfcwXX2Yl0RjhkB?=
 =?us-ascii?Q?KEx4aCcQi0yo8a4i+CwgJr5Z1Wa6jh486JITWBqgoMYyX6WRKxqvc/FhKBhy?=
 =?us-ascii?Q?zrsAOy8pl+xX7Qas43CYx0+5oYVviDeLTu0lGo9L/su3LqIGrjQYWRChFg9X?=
 =?us-ascii?Q?BA8tDgAnj4h1sQ4lpWYHuCQ3BK/yd3sr/thx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:25.3682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3b6ff4-e935-4e75-3e5f-08ddc3d3ac62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

In interleaving configurations multiple endpoint decoders share the
same region. All endpoint decoders must be configured with the same
region parameters. Right now a check is done late during
initialization in cxl_region_attach(), and an already existing region
for the same hpa range could be bound to the endpoint decoder. That
region may have a different interleaving configuration.

To reuse the region's interleaving configuration parameters for
endpoint bringup with address translation, make sure the interleaving
parameters are always correct and add an early check for this. Add a
function cxl_region_check() to check memory mode, memory type and the
interleaving parameters. This ensures an endpoint decoder will only be
attached to a region with matching parameters. The region's parameters
can be used during endpoint decoder enumeration. Also, a config
mismatch is detected early before trying to attach the region. This
helps to identify and handle errors at an early stage.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c30c417de1a..aca02d011c57 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3493,10 +3493,42 @@ static struct cxl_region *construct_region(struct cxl_region *__cxlr)
 	return no_free_ptr(cxlr);
 }
 
+static int cxl_region_check(struct device *dev,
+			    struct cxl_region *cxlr,
+			    struct cxl_region *new)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_region_params *np = &new->params;
+
+	if (cxlr->mode != new->mode) {
+		dev_dbg(dev, "%s: region mode mismatch: %d vs %d\n",
+			dev_name(&cxlr->dev), cxlr->mode, new->mode);
+		return -EINVAL;
+	}
+
+	if (cxlr->type != new->type) {
+		dev_dbg(dev, "%s: region type mismatch: %d vs %d\n",
+			dev_name(&cxlr->dev), cxlr->type, new->type);
+		return -ENXIO;
+	}
+
+	if (p->interleave_ways != np->interleave_ways ||
+	    p->interleave_granularity != np->interleave_granularity) {
+		dev_dbg(dev, "%s: interleaving config mismatch: %dx%d vs %dx%d\n",
+			dev_name(&cxlr->dev),
+			p->interleave_ways, p->interleave_granularity,
+			np->interleave_ways, np->interleave_granularity);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static struct cxl_region *
 cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_region *cxlr, *new;
+	int rc;
 
 	new = create_region(cxled);
 	if (IS_ERR(new))
@@ -3513,8 +3545,15 @@ cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 	if (!cxlr)
 		return construct_region(new);
 
+	rc = cxl_region_check(&cxled->cxld.dev, cxlr, new);
+
 	put_device(&new->dev);
 
+	if (rc) {
+		put_device(&cxlr->dev);
+		return ERR_PTR(rc);
+	}
+
 	return cxlr;
 }
 
-- 
2.39.5

