Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D822E4275;
	Tue, 15 Jul 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606798; cv=fail; b=PsmlZRbvCNc6r0ggAatIkhFnd/wVGsezeBke8FUjAqE7s/5pt8duHgpT7Qnn+8H2dzS6QwH7TUdUCWwZL81LAk1xPj0hRwFR/9G344gtL7NbH0JZd7uSTc4JeujfJ3g/Nz1o2CfmbV9Am5MHUYqT0ja53Z7u6kWoOavoEz6lflk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606798; c=relaxed/simple;
	bh=hTc6Zudht4VurUuMqqJfz4ga/sj3ijr7WFOpVzhdags=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfEohkmk8PV5UrqJs6Brihllr8WQxC/Vg87AvKxSotpFpH82qPeXQHpzVSmbZNbtdgd5MRHLwI6uvJawW1iPeLeunC4J8TriPh3O3YUD6bnAn6I5bzncVfe/Z3Vgkd+zfiblTVkHny+Z7j4P3sz37s4PNc9aNEz96GLLbTAAmVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YBs1HH63; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YBs1HH63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKsQJcRMMcZ1Vf5cU3uY4fHMvbSB3gk/nCvCSAS5L4xRTM7mrGCZUwOFvFJ9GuHG4H/t0f9tV8PjJeil/alvqmaXp0u2WyW2wBfJClRicoDf1r9925zOT+AdLTZT7gJGSozKwVygEIVKBYLY2RfS026gKikDGRWK+VJm+wny67d4XnQ2MX5t8pu4AAIFX3DxnHxVhCkEuP5ymHh62bZv7pNswfqpcx1DLPFSykf+jQH6Ejg11mg8ycyqeswJ9Gb0g77uVSNt0iQf8UF9St4tsfc6Rg9N6jz2IF0UGox4z/Mge+R43rS1hjrrIa8DNHmS0qZUYL2FLckS+4sfMeqDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M1m0Dtye9vC9n16riLzOtCiIVg3iyYJZyk66Ms8Uvs=;
 b=q0efxYMwccQdeIJ6q5Ab+84OsM/B7XXz13+Sb8p+F6FdXoLnt4AVSL9IsO1ZJNKz4ePcBOJWyo6lI7IUcEn0mH3eVsXWXC6OgUWtkP29ZbSTVu4XloS85TR/UaA4sLAncA///y9lBEhJG77p3q5mzkQGR9ktNDNwnCLoUaUyHAwlzch2Nq8L+Qf4a1dHG3UsHBr1GDoMmJPX7oTEUTjwhRbzeftsyz4vjaYr2pDNDBm4kGblU9vudu9yOh9Kz0yO98GDbLtUuSiB5n3tku8lpMK6hJlscZhtVfzmk/kx3KEuZP0UroZW5fyc4oxk9Oz2WJSUc7neKfIuwvM6eI+LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M1m0Dtye9vC9n16riLzOtCiIVg3iyYJZyk66Ms8Uvs=;
 b=YBs1HH635EzGSN1ZgPrVfD5FhxWtq8c4C6REqjbq5dvnMAkXsVTwQ1yd8bgMjGtnBMkNJC9w/955jHAgaxRlSbimvyxoY26V3uzZifDGZZ3voVCvh70qik39AGs/HGH35s1ENviqq/C69MQgNSZEAIqFLBPOILYxIbEob8ER2Oo=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Tue, 15 Jul 2025 19:13:11 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::c1) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:13:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:13:08 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 16/20] cxl/region: Introduce @hpa_range to struct cxl_region
Date: Tue, 15 Jul 2025 21:11:39 +0200
Message-ID: <20250715191143.1023512-17-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 768133f5-d53b-4ddf-088f-08ddc3d3a40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?exwerZaCsvu+zX45ey2EM5TrGour4Q5PUKmU6np9IzUPfBlaTey9LmuYkdjK?=
 =?us-ascii?Q?Pj1X2+bq7s+717ngy07yx+Rctzf2Dko4iiXREWFs3E+v5CsCgYOkkznF/TpS?=
 =?us-ascii?Q?GqEXo4vJJ/nL4JLaPF8RSyNvI6AxHXn2QCEBBIBiuNo09CClZhBeejYfIZ//?=
 =?us-ascii?Q?5D3Yvd/54ib5OVJpEWSv1AYeNLkSwuIm4bwiNbYizTGxO0CIwNSSi6Q7WZDS?=
 =?us-ascii?Q?k4GWPcr+5Ac1TiASFyVHHx1b3+EwctcFWrJh6LjLhc+Y4xpt/DAA2cYpGZlp?=
 =?us-ascii?Q?eeakc8FoLmmOl9PFt3ZOPkD209P8Sp1L5w6yfISK7G6afElOuXPpLhgX6w6C?=
 =?us-ascii?Q?LcNgZAJkTxNbxni8hF9wLzeIgHzMfvUSyua6onbqHTpugDpPQG5j7Ilvv0ET?=
 =?us-ascii?Q?jcY/7BTgNj9PCNo3P8l3+jPqyE6MzBXD0/PbpNMxPQECnRKBi2eZix3pAizU?=
 =?us-ascii?Q?7CjpdsiE/xbC+8b0xBO4uGMJZ1T99rBuHjM1DgVnkgg9uhLb2r87VQHrey3o?=
 =?us-ascii?Q?NOUbd5FFvmTFR2pdu9L7fIMmVgLxqEx5ZPUxCJKq2X1igbjBdavcWxS3t7tl?=
 =?us-ascii?Q?2HpLj9+aW2beZBPxzXM8inhv4q7I/SLFEAn5PCAqnGUECv0BCrOqX3pFoFEF?=
 =?us-ascii?Q?E9lGZBODOYaWNcM1ou5Gq/Gtj6E7RY5k7/wz538c1SCdxqEbb/puuVV8Otas?=
 =?us-ascii?Q?UAGCv7YSGp4deumSygehUs2axUhiXS/iORZcMHwCq2yklbQZW0qwLbTMjxuQ?=
 =?us-ascii?Q?2nKdj33gIicoqs6Ze3xdeg3/hTDgUzY3suOBBjjPQRzJRdUr1rNOc/D5UYHH?=
 =?us-ascii?Q?ttkILXJc0NilWnT8vg6hPYaTK6ofMsgaZ9FO2I5/FCNIN0qOsr38Zf62BsyV?=
 =?us-ascii?Q?M6i+szMfWSqMCQbGkwPmHYMXS0VUgEOi3EMUoICUY/hkXUQfU5BJHPGVNrrU?=
 =?us-ascii?Q?zXtEhS1P9g66sK0T1dJ7gq2YWIOxxMkBQO+rVcWqJCTy7Klwg7rIBjDpSGV7?=
 =?us-ascii?Q?G3zfSPti7Vh30Fm7VZS8fXO07xpT50IlfzR39ttJ2W5IibP7u+9N7uFPJ7hn?=
 =?us-ascii?Q?WyWHd43I30deVV5XzF9PUdwR1kiyT8Bbx1Ep3Iz8BJ8Ps7nEtmnO7PhzvKVf?=
 =?us-ascii?Q?ytS5XA6jDyuGgX5w/mDi9TuBWG7q7qc6O6IHQIMXzxrocNzPBwBaN9f7jEKe?=
 =?us-ascii?Q?Rsxx8eX9MgzhVWajZsoXNpURfIj2Ogc3HCPsQ9fMSF8DpJMQWkA6jNmZ0ER7?=
 =?us-ascii?Q?yivVwPnzYGgJ58vD9VKbRYKhj8mQxbM24lq/e7oaBDQJIfFH/n0SpYxjMQgz?=
 =?us-ascii?Q?4ypIl347BhfBOl8sYzBK2i1bKim0NmzS7u1FWGrzmaLJTtgMG4TcAk5enh3O?=
 =?us-ascii?Q?NTQUbRDPHBmgv8JBwYGsoZxF+DZGbOGJij4oKdBySBMf6AuSN7HzVJ+oKJPd?=
 =?us-ascii?Q?ZdY22zwt08oFGwSJ0DhWVqwvbslwftfaIFxQOIYdwrvrlpMMtVvKKp1SGvON?=
 =?us-ascii?Q?by/MGi5q+4wT3Ab2voDkLR1ip3SBotDS4o/H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:13:11.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768133f5-d53b-4ddf-088f-08ddc3d3a40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

Each region has a known host physical address (HPA) range it is
assigned to. All assigned ports to that region share the same hpa
range. The region's address range is the system's physical address
(SPA) range. That is, for regions there is hpa == spa.

As systems with address translation have hpa != spa, track the
region's spa range and introduce @hpa_range to struct cxl_region.

The introduction of @hpa_range also helps further reworking
construct_region() in order to move the create_region() call out of
the function and remove @cxled from the parameter list.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 18 ++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 81ff9956a128..7e21946072a5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -653,6 +653,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = (struct range) {
+		.start = res->start,
+		.end = res->end,
+	};
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -689,8 +694,14 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
+
 	return 0;
 }
 
@@ -2496,6 +2507,11 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -3354,6 +3370,7 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int part = READ_ONCE(cxled->part);
 	enum cxl_partition_mode mode = cxlds->part[part].mode;
+	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region *cxlr;
 	struct cxl_region_params *p;
 
@@ -3381,6 +3398,7 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 	cxlr->mode = mode;
 	cxlr->type = CXL_DECODER_HOSTONLYMEM;
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa;
 
 	p = &cxlr->params;
 	p->interleave_ways = cxled->cxld.interleave_ways;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 58c9db0bfb93..cdca44556039 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -509,6 +509,7 @@ enum cxl_partition_mode {
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
  * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -523,6 +524,7 @@ struct cxl_region {
 	struct device dev;
 	int id;
 	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.39.5

