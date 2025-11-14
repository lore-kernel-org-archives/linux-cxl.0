Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3982BE02B;
	Fri, 14 Nov 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080918; cv=fail; b=iSAaeuqtrMEJnkQX53nC3kUei4/8vOUY5rqnRpkuqh5fvDlix/arB5WOQySKoDuZnOCJ+VASHqizGP5AgeWYAo26pNunNunh+icJtOgVxv0sJPyNHT7jIyMtY4qFCEwm/XJAbXsIAC9eQIzFktOYukudc+ZHeV5tEYNZSYAC4HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080918; c=relaxed/simple;
	bh=fmPkrHHmJHz+BjwGzTLIHNx69R5QxyCJDSJYO7tOfaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OM0fY2xTPdnFvfCXAg/hCYYRQm/UEP5hH8bZ/vGIEljIo68zEb+0GenGhLpNtXAgZlS88z6lmgEdRFJ+ddkvXsj7alSf6cbkotasZvpy7wnj6K04ly9iO+lNPixofQxEjKVyUhKX60oQAXT9FJVIX5nXQWqFJCohmISgFCfX0zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3UXfLvD6; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3UXfLvD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv0hBufkX/nfaN1PsScg+WRNj6DBdmi62dvEGyCv5aURMa39YHXXQD0bBvintz3uyNRZVpD5EU3oeG5kDdWgbzP3GKo47W8Ixex1ERKx2Byp9P4cUNZ0ORi+ZcA2f5w19Mj7sAk8LdNS3rn/ERIIhFVG45p+BYN5kFz/YoTFiOEgLMV4WbNuP8SfOCrhFRarkAANUBORSuQP94KmuniJqQ63B6buSi7mFgyWJ1cuzS1Yqx8TjumP/xCfbyAzZbWb0mlxto9nEs//wTWA0ekOuE8wy8up7lJnFLQDLfYm+7lRDbaHOhBpZld1+4ZoRnaBIU6uCv7pEZUzvbYQTk1iEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f138otZxepqQcsYuXrlA+i4xSPSAgzNPKcGE+Dir3M=;
 b=m89O+jz7FFhjjfsV0zsM0BBGfy+/lM6dDpehtGIijqSnrEbBoapNTC9AvJc/QcUNvZpZxjcVjE6nkIuWn5lwLJVBNDvEPyVMKBAWZzNwo1WNnWhNh9OlIiw1btguossmjaiel1eViS9VV2OiDeh3xZ/gLe1c/BFu7/UYax/jIxyFi6ffu+PNlIO3gwdHydNHL1tGikVkWuzmLbwDKLcA+O0m4/2uHucNyW+AM58sIfFoYYPP7466MXBnFKvgPd4zCVyju3fSuXydRnZ53JRCFs/uWTS/WEFYZGeP8TL9KnBdDC4O3mgGzHPQLCtibMKbra8Ydw8nT1XqAEfqIrkW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f138otZxepqQcsYuXrlA+i4xSPSAgzNPKcGE+Dir3M=;
 b=3UXfLvD6uhKe143Yzq78v3A+DrIs8CaLFhT9CxXXm/0Rjd/RAyPYPwGb/fDYXd+bbtxPbcmJJfOdNnfF7Y7VM1+reteK8g5wg3KH5Gq2tkSa1Zr1xnisdymB/44lPbbukV6aXg6VApdNavZ0NIiAnN6hh4jZd8bTBz4R1iDF/I0=
Received: from MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Fri, 14 Nov 2025 00:41:47 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::88) by MW4PR04CA0385.outlook.office365.com
 (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 00:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:46 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:41 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 11/11] cxl/atl: Lock decoders that need address translation
Date: Fri, 14 Nov 2025 01:40:16 +0100
Message-ID: <20251114004021.1310661-12-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bef3d45-48f2-404a-3426-08de23169751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8/7EKbVByq67CRDkwfJuDM9xWuEdOzsPmR+lnlOdkq9qBUTzzgI6SpFu6If?=
 =?us-ascii?Q?3C/PUpu2QENqA6kGhZ8HsOpmCHCS7p+G6KLi5Am9Ax+ZWvZpATiHbwA37Uea?=
 =?us-ascii?Q?xugr/AHWKyJdj8uQm8AJoNFNxhhTIIFlwhSBN269usqD5gfsJZt3QexGkxHN?=
 =?us-ascii?Q?/BE/bTyniw2BmLwBct8qLlVeqp7T1T3XSIyEFqiredmhIER678kSh1S5VFt9?=
 =?us-ascii?Q?6CswZOm8ELCFCkbMfku6L2Q/CqnWXBACNL+tNDHw5r1wWowcIB8OSU6uSkAs?=
 =?us-ascii?Q?3qa3BvsecnPg8eFby4KAMp+vda/BN0MP6FENwVLPEvpQRCIwMzbueAkFaCvv?=
 =?us-ascii?Q?e5iOmnga/44fmOEV+qCxDhKBUjYo2afyEmqNfDymzizBqmjbhl7hqcP6unVK?=
 =?us-ascii?Q?1HAxBCtQeXsY//2nTjtLB7OChMD/us4m1uTg9dSL1gcUoaAiTuN6aSj1Smkh?=
 =?us-ascii?Q?a5DV2uUyGwyPMwRY3hrIhlYK+dhg7KkhF/qnXmwunbT8Ti2EGnr/prNj2vKB?=
 =?us-ascii?Q?iWGnSIMjig7TfjX2Aoy2qPuLBfgqmvCgiPZQkrx+06Ex1duzX56RJ+v1dAzA?=
 =?us-ascii?Q?fkBHsNuo0dblVQnFISxE78fkzNAc3kEUKB0ApgAkZYKsmBVtu7Ls4GMNscPh?=
 =?us-ascii?Q?K9y23YwjWrV7xvMLDSekIvtrknWQexfYx77a9bcdE7fV9q5Wpvh9dxR4pom+?=
 =?us-ascii?Q?4uX30TFhPw0cWi6vORvpk8tTqCv4jtJIujUp0ttaKnUwiowx+yRqmgLGHL5X?=
 =?us-ascii?Q?rrD+LbD2lNi6JFpQofYJxFEbMVYnG2DS20+2ePScwU3XH2LJHWFbnF6D386w?=
 =?us-ascii?Q?7a1Qsc4U3YjJ7b7NtuycdgSKhv0FAW4REWIlHgwBNDF9SrHlR17mAtwKd6/B?=
 =?us-ascii?Q?ikdJ/UzuQt+6/dfYuZwinXs/G+66XLAptgFlsTUyFoXaVL4bzKKW4bulvSGi?=
 =?us-ascii?Q?e8fHP78UxZTtujpTRe0ouJ5mNmwEvsQNVXWSn4N5d+gbirBhSLIVKCcqIcAd?=
 =?us-ascii?Q?TFUz/ANg45m7CDF37jQz22oVAg///ONx6vyoIdltigMoOdEq0cxIhH8SOIQ3?=
 =?us-ascii?Q?3cSEr1lfx+OS6/QpCLpdRmqnvT+33vez7VAIVcEXo9C9WLYUHZlEbSVyHzIA?=
 =?us-ascii?Q?I+BK70g/FdufWi92HPrYx/ZEuHysZwjZt/xgOK0YUy4LkX1zE/kjGsb9hRkr?=
 =?us-ascii?Q?J/bXcYACCUDyzBdZ8a/Z9agUCHkD9dsBtZn4IMe7tUIdWL50EJ+ROcOWzn4V?=
 =?us-ascii?Q?32hPeP17qhIJxVVk5OxpA7O0ACdYLp1Fu6r+17/RAfrI2QUBVqfA4U2GqV5x?=
 =?us-ascii?Q?q/YoRBavmg0LUzEwvBySLGI/DpmQ++J4CvMRAdAmA9VhwDJXf0GTtB6X39YR?=
 =?us-ascii?Q?osYsG3ko3RWLAd60B3uTYaknJpmxaIGPVT3eNK3Gn2vmqvx5WKIg/LUTNLxv?=
 =?us-ascii?Q?N+mlLtW7jv1yuRUbBOiV6gJbsQGo3uEj1W43Z5t9kF4o4vU3YZ1g8pMXM9MT?=
 =?us-ascii?Q?P4Fqm/Yyc3QIJxu7JZhGOhxH/w81TLhBXTTeE4sgE8W4EY07CxSIAHjfbTeU?=
 =?us-ascii?Q?FloI+I1UpIspJf78HjA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:46.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bef3d45-48f2-404a-3426-08de23169751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

There is only support to translate addresses from an endpoint to its
CXL host bridge, but not in the opposite direction from the bridge to
the endpoint. Thus, the endpoint address range cannot be determined
and setup manually for a given SPA range of a region. If the endpoint
has address translation enabled, lock it to prevent the kernel from
reconfiguring it.

This is more a limitation of the kernel implementation rather than the
BIOS. The BIOS provides enought information by CFMWS, PRM, HDM and PCI
topology. In theory and if there is demand for it, support could be
added for driver region setup. For that reason the lock bit should be
set by the kernel instead of the BIOS.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 3b02999d3c59..4f645f71b397 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -161,6 +161,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
 		return -ENXIO;
 	}
 
+	/*
+	 * There is only support to translate from the endpoint to its
+	 * parent port, but not in the opposite direction from the
+	 * parent to the endpoint. Thus, the endpoint address range
+	 * cannot be determined and setup manually. If the address range
+	 * was translated and modified, forbid reprogramming of the
+	 * decoders and lock them.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
-- 
2.47.3

