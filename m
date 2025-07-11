Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286A2E9EB1;
	Fri, 11 Jul 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246980; cv=fail; b=HAdDwD3RHIwCZ+1zeYp4jqVwPutrIb7rHo15ozEQPyy3rLi461sYKT5Ylv1BO72MFQRhqygPjr/Dg/dC+m3fBwc1ce7zhWlrEUhDBk1ZPi9b+ou2CwePcbVNwrt4yzty28hmVZz0uoua+Tj2OIootok9guTulTXY+ShBdTUC1fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246980; c=relaxed/simple;
	bh=Lx7mOvcu1jYad+j313PSehH6oljJC/XkMKCVOnVkJDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jPPEwNU0uzA4U9k3zOvLCxZSn3Ammje6uXgJlRHgcITi1BS9WjsCAujr3pxOd+LLIXeB/6XCKkDaNCy5qIycEoJYBt3tSCmHTiZHFA5ILxyVgT27LzWWNW23+ivwLdho0ONq49Jr5BeRdmrb/pD6YYgIVYyzDmnKO3aKeolxKDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2DSMFpE; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2DSMFpE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXN84pMUpExk1sZDubpARAwoXGpSL62pij4zZ9irAfwisfrXatRWTBcGhsWKqOav8dWIRLCXOc0CbkPu9kR4F+h+igQQ4qB3/p9idXM1ghQA0E7QNLbF22YMUwj/p6TnwEilyq6MYSAfE4ERqWx2F6uYga7Ct5uD6YiIR28m8Cz6ZACWbhxzyGyrMq0YEyl2c9R8h2m561nhr5K81I+/TuO5YHXqUJE8wTWzgPbAW1pma0PrzWIDYO8uhC9v7iPbyDZgOY0Tswk7NzgBcWp0wIYviYz/kRA4X9vd0GFOYAMMb2AvL+lqbKA4u9fLbc6t49k+AYE+PEN0GX2zEAFfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlQX/mWbWt5GLQyUOQxV8yVJblApEoVTlwh2vkcRzKc=;
 b=Cudz/G1FpVle/09aTGEL8kntQuSUQQob+JVwQ9szO4nS9yDjSqCY/5g9Nib4yZ4rmQPLPPRXXzL7757nrpB3XHRup4+XSKxhm7dI5T/Vukc1kyxCDf8tKRPGnu7FVp01MDphB7W1EsU51OY2K5OT7B4S0ZsTq/sksvFcjJEGBhO9Njs3yKeoO5iKItIFwDKaYJW5gR/kI0QlX6iWKZCDRT/xZSmqYZ0A4ZrqAl8vCkG/BUHll3vVPSscoeorTUC6wxca0r1nPJfJv8nD34lYR/TcMMTDdD6B1OdF5GP1ie59gFi5jEF/ZAfqcf7mmsIQzMrzTWLJJHxA4/q1BrMAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlQX/mWbWt5GLQyUOQxV8yVJblApEoVTlwh2vkcRzKc=;
 b=l2DSMFpE/2bENdcM1+FdwbTO+48BmB0PI25rkXAtjcm8lVxRj+sE2tnNckoXP8AwuuRz9IinoHecRwBRm20zqlPGJEmMKjGT1hoPm5vFtTgzF1NbI30mRNJXITEEzY04fytG6vQJuulQ6gKa71uwrPfFmgO1M0dG1m/MpRq4Vrw=
Received: from BN9PR03CA0884.namprd03.prod.outlook.com (2603:10b6:408:13c::19)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 15:16:14 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::db) by BN9PR03CA0884.outlook.office365.com
 (2603:10b6:408:13c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 15:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 15:16:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 10:16:07 -0500
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
Date: Fri, 11 Jul 2025 17:15:27 +0200
Message-ID: <20250711151529.787470-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7c44bb-83f7-49b4-c105-08ddc08de01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4q3B8HMEjCZyaZQ4bvQPQIXKN2BC/w1rtlRSEy+mRt6dUHvT2QC52ZH8ciUh?=
 =?us-ascii?Q?GBhfTv4PbeGBkq8rRGsijZvbpstrFX/4YQlDyQjYW2YiK+Qz1zv1Tj4YcSQw?=
 =?us-ascii?Q?r9zqR9gVhtCxpaX+tmWM9yRf5EeM7U6q+wEEcDEqNw46oXnL17TFtY5GVki1?=
 =?us-ascii?Q?nzPoId5d8xs+IkQxPJ6OEy3jpHJSpxGENHN4uvXbZQibDe2ZdBFN0lnL3Fqp?=
 =?us-ascii?Q?bxVkWrrVh8uzNGYJpTS5tsXru16iL+vERAR0/097PjwjS7kki4z/LrgWSI0t?=
 =?us-ascii?Q?319hng7OvYfFUiwUnQgpm4ba4tWjlMONzyApYZGAT5DP8EI6ii8brt6a3+Kj?=
 =?us-ascii?Q?P2isqR1zbw7qoZqXTS82F/2zYGK0QxDIaOwOn/qnFrlKKGWtY2sQUiKojwnS?=
 =?us-ascii?Q?iWh7CDWQwyrEFkktmhmnRKQimc5EwK5j75V1rxCtoLpjwbWt++c55XCY7eUJ?=
 =?us-ascii?Q?ZlEM7T4n5DroluSC5fb1klnFUWn3uZ+IdyxcNktE4wLZvSVlNXDH4iU97z6m?=
 =?us-ascii?Q?5NI6HzFUkW7ps8kSNOwAU+O2ncO5rFF788KoEvyixjTAfFnLRCGlL0nFI3CZ?=
 =?us-ascii?Q?ZVpdOeOLrwP57X5Zr7UnsGnEf4lEKBAS2s/n3QiDk5G+usfNPNs/aPY0sFJ5?=
 =?us-ascii?Q?lEdXnyxM3cncfEtzbulpbQUFV8ab6FcUeOkkVaNt/bvFj8QM7HTff0/mjNEg?=
 =?us-ascii?Q?yVsdrH0Q/c8pB+uBsf2BahmBRq1vmeWzUk8xLksvUDTzOa1FLRsPiBuAGS3J?=
 =?us-ascii?Q?sSkIR7Q6A5eZBfeOedEr8aj3JVLlfFSJzE429foAvwGl2zri9MFN/XQky8o0?=
 =?us-ascii?Q?4rstHZhA7cieUQ9clriEHQyA3i1KVGjY5O4jtYHBuHlOOvnImWdBkSr23sv1?=
 =?us-ascii?Q?THodAfhD2Li5oTV4jTeE62DN+QW+80lxeS/bzly6O20SO+/pd5jP4dfnqPe6?=
 =?us-ascii?Q?lErKd/D6/Vmc/hWFFqs62HSJjy9uWc+/atGV3v1FPSIr15dTZVvswS3KYgQ+?=
 =?us-ascii?Q?KSHE7WOe4CN7vUmUqoRFQepZxIQ6iLLztpU2b8+4GDsX5WVsJumSNJR+MdKr?=
 =?us-ascii?Q?0BuhNtXWSWDe7YeyngNrRdvN6CzUU3qDB6RwNR/yWn1VBXrydjo6yDvv4h8f?=
 =?us-ascii?Q?ZUT6NJaqy6zBzNnHH4+/DF8EM0vYeSfsVm+vTwhjkKcALuLYUNHUDQ35Q3Vn?=
 =?us-ascii?Q?WDXXg5TN090AhmIEKzJsrkqYIEjStP0NGjMgX6g1lruJzbFwo0bme9PRuGW5?=
 =?us-ascii?Q?8EvewQwY6Ul8n7IQOZxsWDMEttSbA2hf41W4CH00CQvIp9qKKGLiUquxwMHB?=
 =?us-ascii?Q?+x+GzlZU3Gy7bfF/RJAd5KEOP8mcFAUQqksY/kMiuZHa0CBC+trSD67lwKJD?=
 =?us-ascii?Q?ojzaDYR8FDnwTmYRcFKAAA7u/g9KOP+zSpq2OSGX0OYnCGM9TReF414+rKHb?=
 =?us-ascii?Q?d+KdbErwQUyC512lQes9aFiUliXgim0k6yUvsvfSkqi79pqkSG1SbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:16:13.9055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7c44bb-83f7-49b4-c105-08ddc08de01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273

From Dave [1]:

"""
It was a mistake to introduce core/acpi.c and putting ACPI dependency on
cxl_core when adding the extended linear cache support.
"""

Current implementation calls hmat_get_extended_linear_cache_size() of
the ACPI subsystem. That external reference causes issue running
cxl_test as there is no way to "mock" that function and ignore it when
using cxl test.

Instead of working around that using cxlrd ops and extensively
expanding cxl_test code [1], just move HMAT calls out of the core
module to cxl_acpi. Implement this by adding a @cache_size member to
struct cxl_root_decoder. During initialization the cache size is
determined and added to the root decoder object in cxl_acpi. Later on
in cxl_core the cache_size parameter is used to setup extended linear
caching.

[1] https://patch.msgid.link/20250610172938.139428-1-dave.jiang@intel.com

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        | 59 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/Makefile |  1 -
 drivers/cxl/core/acpi.c   | 11 --------
 drivers/cxl/core/core.h   |  2 --
 drivers/cxl/core/region.c |  7 +----
 drivers/cxl/cxl.h         |  1 +
 6 files changed, 61 insertions(+), 20 deletions(-)
 delete mode 100644 drivers/cxl/core/acpi.c

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a1a99ec3f12c..712624cba2b6 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -335,6 +335,63 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
 	return rc;
 }
 
+static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct range *hpa = &cxld->hpa_range;
+	resource_size_t size = range_len(hpa);
+	resource_size_t start = hpa->start;
+	resource_size_t cache_size;
+	struct resource res;
+	int nid, rc;
+
+	res = DEFINE_RES(start, size, 0);
+	nid = phys_to_target_node(start);
+
+	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
+	if (rc)
+		return rc;
+
+	/*
+	 * The cache range is expected to be within the CFMWS.
+	 * Currently there is only support cache_size == cxl_size. CXL
+	 * size is then half of the total CFMWS window size.
+	 */
+	size = size >> 1;
+	if (cache_size && size != cache_size) {
+		dev_warn(&cxld->dev,
+			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
+			 &cache_size, &size);
+		return -ENXIO;
+	}
+
+	cxlrd->cache_size = cache_size;
+
+	return 0;
+}
+
+static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
+{
+	int rc;
+
+	rc = cxl_acpi_set_cache_size(cxlrd);
+	if (!rc)
+		return;
+
+	if (rc != -EOPNOTSUPP) {
+		/*
+		 * Failing to support extended linear cache region resize does not
+		 * prevent the region from functioning. Only causes cxl list showing
+		 * incorrect region size.
+		 */
+		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
+			 "Extended linear cache calculation failed rc:%d\n", rc);
+	}
+
+	/* Ignoring return code */
+	cxlrd->cache_size = 0;
+}
+
 DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
@@ -394,6 +451,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
+	cxl_setup_extended_linear_cache(cxlrd);
+
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79e2ef81fde8..5ad8fef210b5 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,7 +15,6 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-y += ras.o
-cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
deleted file mode 100644
index f13b4dae6ac5..000000000000
--- a/drivers/cxl/core/acpi.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
-#include <linux/acpi.h>
-#include "cxl.h"
-#include "core.h"
-
-int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
-					    int nid, resource_size_t *size)
-{
-	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
-}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..9462aea9ce9d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -120,8 +120,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
-int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
-					    int nid, resource_size_t *size);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..bc542a7142c0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3282,15 +3282,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
-	int nid = phys_to_target_node(res->start);
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
-	int rc;
-
-	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
-	if (rc)
-		return rc;
 
+	cache_size = cxlrd->cache_size;
 	if (!cache_size)
 		return 0;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e7b66ca1d423..4643a95ca111 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -432,6 +432,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
  */
 struct cxl_root_decoder {
 	struct resource *res;
+	resource_size_t cache_size;
 	atomic_t region_id;
 	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
-- 
2.39.5

