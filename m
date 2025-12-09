Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1E303A02;
	Tue,  9 Dec 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303735; cv=fail; b=X2cgfhNEUtaX1lvJbPmmuTcU4sjrmOT9fxge974Cez7So5hS2m20i2AbApyqwwaU00LxDMHC+wYi83HuUQOOLmswjuN8qAkNSxkG7XJdxteNTz1XoeF40xRpjr6JVQeT0JPendmaASj1JODoni8vlAdZgEL1XbVVjHkpZ1puexI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303735; c=relaxed/simple;
	bh=sVyPM3C7KjryNK+8+Lj7TikmnVKdCnqqu7zFCk0mjE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMZAMEFjjAEeO0xbTURsbE51qSiGBpZ0oclCFcLP1ipyUneVKjVr14zHtA7Z6E8kQ3hEWfKuVDrzzyzW4mCWh0VnPngIao7JoDE62hPWQvcETYU7TaAUJ4TNueZZHd5QtEDeWWis4GfMTU7/GxmHAcMlyICZJ1O8F7wMLNqp7pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X+RZ/BVK; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X+RZ/BVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsJOVIsFWrPvrSLzeS0ncB0fI5M5Ye32W0BP/xL21TeXlVIeESeOKkGKvceG4IQMQNPGJ7ezqHSHSo+aYbvdv69cAAwK79hVPB2wBMPgEuiFBW8txvEfnr4Eoqv85E1H9wuZ4ZWNnsV3k0VSauMSdMUggnMa350KNL6FeE292wfvW7gG7ntfu3b20tAVhIUTRNhP/CNiF7uH3p3Hoodp4QX1B0abosTXYusyMYjPSmrY0FAPyf8vA9maGzRzbIPktRLGYzGt9ncbZ/y2cR8NExFTxG7Aa3neGT0RM72deJ+Q+u93p9AQjyGzaymqXaGl4w0l95KUoQS62GcZMmZo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9rwc3IiAQpRDasqx4GahZjNEYHOLmXEYpWkM/DAYZ0=;
 b=D5/OaYacEGV5GucCsYP6q/taoQVfVY9C9RJIfF+K0BaQbGSWRci83BBBfuQZluET+m6fdzzvk1oXFdzxjgSs6y/R+9yLmydzy4G2wc7T2pMRa/5zQJAhIx1WfZPqe0/fc/yfdGZa8oA576+IXXRR2sCm+LlmmuuPsHaTNcCY+qtRhzA7s1aUayRoGR0W1rUhxwOKxdZFqIEE+pv0Hnfkn/HrWRh1sNVxHiNM6DNmgjFRdjL1GHw4LIZknB8bhOf1ylayrptG+CWI8PbC8UUfDZHZ59ewqr/AbEo/FeAbhXaHPB81tMNgWCKFxLj3idnn96QMno2EMclayOaX/9ZnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9rwc3IiAQpRDasqx4GahZjNEYHOLmXEYpWkM/DAYZ0=;
 b=X+RZ/BVKM9Unt+WyTBaumo2vVMUjo6VvwNjnjAk6yXtrl5WU87PbvLEr7xP7M2u1BBV8vvPrC56avElaBexn+SSudAAMFlN0wlueGWEHRkyuNB+hBrlup9e7+kEUzf2ve0jh/K48jhLajem6B2EO57rbpZY4QolVl72AbqshmT0=
Received: from SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:08:46 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e5) by SJ0PR13CA0078.outlook.office365.com
 (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:45 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:42 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 13/13] cxl: Disable HPA/SPA translation handlers for Normalized addressing
Date: Tue, 9 Dec 2025 19:06:49 +0100
Message-ID: <20251209180659.208842-14-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fba126-f3a5-4013-71b3-08de374dfebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CG+/ha6A+31wXnSsmC5MX2OARwF9GmlnEJFw3w4Wx+3etTEK8J8wI/YT/SNE?=
 =?us-ascii?Q?BuSnoNBWFJqvjfKqG8HR4S1UYMBw7OI7ylpgS3UR5LieooenTAvM0u8HlmYg?=
 =?us-ascii?Q?dg7QXbwGlKAQcDie0IonErC1VvXN8F6OTG6lmPYXAhMbFJfXKGsUFOU7QMoC?=
 =?us-ascii?Q?0ZtcQska8JCQLJfLH4TSTxlLeD4gL6xTZm95F3xsSGMx4nctZwy1jhwAW5gT?=
 =?us-ascii?Q?Z7nqgINm2ZoJFhkz2+ChEeDx2Iin/FIqiHGpLh/YUjyLqm/5WKP/yBkK1MyV?=
 =?us-ascii?Q?qmkvZLyBwplfmkDv2pNWWtbgi3Am5+tvmA9bqTO8UUHmpD6Kms4Hwwr3pwZ7?=
 =?us-ascii?Q?SgkWdqW1jogu/qk/lSIKmHpPrFYybzovGHhYAekivtwuNfHuTsBmmTlt0mMO?=
 =?us-ascii?Q?ukl0BmZ87g3cDmU4KWSNVswsTNj/R3QPCHEq0e+dTmiD+EAisZlHwLJs3VJi?=
 =?us-ascii?Q?VhXg4HJXXgPSYXt0lU58tgJFEKrYzB5D7hZuB6nxk6/ixJVNuC3Ts+YPCSf+?=
 =?us-ascii?Q?yOy3kKGysYCrk4BQse1L2kVjJzcj7J7zf01Vm124xcnjBVc9C79fgy/ZskMN?=
 =?us-ascii?Q?rf9E1a6Jtz2kCDTRcpRuQ4H//1lwjlG1a1tkY/HiPrDVByLD4B2B8qSGxRVt?=
 =?us-ascii?Q?drEU+IvMyZKSS87Kb4DIr8o/EOvoNL9YBBX9MX4IYyPVMdxrpRQfFM2lyzyg?=
 =?us-ascii?Q?nDc4JcjFGCqF/O+h/kxHBby2+EZwrBhh56OBUeLmxuGsB0DzUJlyZ/zQCc1A?=
 =?us-ascii?Q?XQztxlWTia0yXzooNwHpXGVcOTkNPYc1dBPHQgS4TtkOSPGJvB40rdyDLv7x?=
 =?us-ascii?Q?tcj7NOKb5xvly0ErNgzjmwKrA8UA9QXAEnAViCdR/wHvpLcIge03etzKg8on?=
 =?us-ascii?Q?H/pBaWM6DQSxIcSKZe9PkFBWFeW0BC6tiGKLyc4XTEkKyaLsu+Cg/gEAHDBh?=
 =?us-ascii?Q?Bbeg2aTMpi18i8YZMY15o9Za4lXrsT+paZwYitDMQRvZd/aYRyyvDXPNgN2b?=
 =?us-ascii?Q?pjOuaCm5laXO0NtZBVUQfZdLjumoHeO/yv+5noTWFDhhZXB7qVtPOfiUbE9f?=
 =?us-ascii?Q?WI/A9kRIIqL6NXfKZiSB9fdq4kByy+/h5Ys7X4c+xsXLRgMDMkfbeVcF4s7v?=
 =?us-ascii?Q?hIIkcCRSrNjjZ4yAsgqQLEuEAwqQ47ey6IehBTNm+pZNctwgntUIQWU7bWQ8?=
 =?us-ascii?Q?ucGk85OLh6atsNwlrPXrvCAcxND/yMFw8VjK8m39DM2pWhX6FRLAwP63p66A?=
 =?us-ascii?Q?f00QkHbu490wBZQan2Jl6Akjk+Ntxgp2qVUPao9hivaGhOS5TsQiSvrNDpiw?=
 =?us-ascii?Q?/0WJpyfLaxvDLPHdUK3IQLsjZ9pseGHa2e45xVL81JCs+ZsjrfeLUrewcf0D?=
 =?us-ascii?Q?UVQxKAwrmrpejYUnNnU2eyPqPqUEHS7Td4+ljwYQ9aZVZkjaz5rruonxfAkf?=
 =?us-ascii?Q?zn7RzZ/MEEl3kkvP/XvEMon8RVl6i/tlSxK+OxqdRLvHF9WWEx25XtSxGDeZ?=
 =?us-ascii?Q?XsMbghrmtRimRYX1xMlvPu1zBcDSDVhIbhy+BNscABXYuyjKSz0O8hFJb3Jt?=
 =?us-ascii?Q?CVoMnSKHP3/6ZeWtmCk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:45.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fba126-f3a5-4013-71b3-08de374dfebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

The root decoder implements callbacks hpa_to_spa and spa_to_hpa to
perform Host Physical Address (HPA) and System Physical Address
translations respectively. The callbacks are needed in cases where HPA
!= SPA to convert addresses for tracing and error handling and to
setup Poison injection. Currently this is used for XOR interleaving.

In AMD Zen5 systems with Normalized addressing, the addresses of
endpoints are not SPA and those callbacks need to be implemented.

Now, as ACPI PRM translation could be expensive in tracing or error
handling code paths, do not yet enable this direction of translation
(hpa_to_spa) to avoid its intensive use. Instead, mark the HPA invalid
and return an error for this case.

The spa_to_hpa callback will be used in region_offset_to_dpa_result()
to determine the endpoint by the position in the interleaving
chunk. With Normalized addressing, the order of endpoints in the
interleaving chunk is implementation defined. Do not use this approach
and and return an error instead.

Disable both HPA/SPA translation handlers for Normalized addressing by
returning an error (ULLONG_MAX).

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c    | 35 +++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c | 21 ++++++++++++++++++++-
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 4bd2289b8bbb..9d05a83bde73 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -57,6 +57,39 @@ static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
 	return spa;
 }
 
+static u64 atl_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+{
+	/*
+	 * PRM translation could be expensive in tracing or error
+	 * handling code paths. Avoid this for now and return an
+	 * error instead.
+	 */
+
+	return ULLONG_MAX;
+}
+
+static u64 atl_spa_to_hpa(struct cxl_root_decoder *cxlrd, u64 spa)
+{
+	/*
+	 * The callback will be used in region_offset_to_dpa_result()
+	 * to determine the endpoint by the position in the
+	 * interleaving chunk. With Normalized addressing, the order
+	 * of endpoints in the interleaving chunk is implementation
+	 * defined. Do not use this approach and and return an error
+	 * instead.
+	 */
+
+	return ULLONG_MAX;
+}
+
+static int cxl_prm_setup_region(struct cxl_region *cxlr)
+{
+	cxlr->cxlrd->ops.hpa_to_spa = atl_hpa_to_spa;
+	cxlr->cxlrd->ops.spa_to_hpa = atl_spa_to_hpa;
+
+	return 0;
+}
+
 static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 {
 	struct cxl_region_context *ctx = data;
@@ -183,6 +216,8 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
 
+	cxl_root->ops.translation_setup_region = cxl_prm_setup_region;
+
 	dev_dbg(&cxld->dev,
 		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
 		dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2c070c7c7bfe..130af1cf95b7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -623,6 +623,21 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(mode);
 
+static int cxl_region_setup_translation(struct cxl_region *cxlr)
+{
+	struct cxl_port *root = to_cxl_port(cxlr->dev.parent->parent);
+	struct cxl_root *cxl_root;
+
+	if (!root || !is_cxl_root(root))
+		return 0;
+
+	cxl_root = to_cxl_root(root);
+	if (!cxl_root || !cxl_root->ops.translation_setup_region)
+		return 0;
+
+	return cxl_root->ops.translation_setup_region(cxlr);
+}
+
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
@@ -666,7 +681,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
-	return 0;
+	return cxl_region_setup_translation(cxlr);
 }
 
 static void cxl_region_iomem_release(struct cxl_region *cxlr)
@@ -3663,6 +3678,10 @@ static int __construct_region(struct cxl_region *cxlr,
 	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
+	rc = cxl_region_setup_translation(cxlr);
+	if (rc)
+		return rc;
+
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 20b0fd43fa7b..f4623728a815 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -653,6 +653,7 @@ struct cxl_root_ops {
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
 	int (*translation_setup_root)(struct cxl_root *cxl_root, void *data);
+	int (*translation_setup_region)(struct cxl_region *cxlr);
 };
 
 /**
-- 
2.47.3

