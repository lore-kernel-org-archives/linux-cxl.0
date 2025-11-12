Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D32D1911;
	Wed, 12 Nov 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980693; cv=fail; b=gCQKlQORAgFBAIDg6XXCx56pSQL8dx8yy4pKwIN1YqucvxRG+B3ZbYfMmwy9uHQZByAVZ8VO57IBxYGBEy5CF5FwrFWi5GCF2OGcnHR+CHlvCiOAvbuGMnDctdab1mmxPUMOpYHkjUL9OHuaKyVhlq28Dpfhy2LlByFEFrA1UME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980693; c=relaxed/simple;
	bh=8fEuaUJq6hnppPcJgE76MlplmW/P2brzXo1BFCCJvj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWOw9DOqPkl14T6pnT6Tk0sXy4DMnE4u8lBeAPoQRCAfXrLDEvRmZowMSNFf9X1Q/un3h37ZN+kf9nbf3m86/J2lNx4aX753I/6WhtyqLXM7DvIT8Yh++c3ncRkM0sGxN+UoIuscu6RjTThaBKSIvCcJjZjsDBWC0RKsG1aSk3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FYSsp93O; arc=fail smtp.client-ip=40.93.196.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FYSsp93O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chQV3CZXLRCeARWy37bxe2Z3ccmyjaTv0CBrQRh3C86ux7OcuC35VhxVWYTM7TiJnw8nRw/jFVDgJevfhTp+USEYqtU4rXUnMkB8R5nPXvotcbSWIuVi7ShXGu2u5MfQwQEordcjPfSz8bbdK9UNBTrUZGyBTTgte/poXiOJwnq2c8xFc45cQGn+h+1AkqzpFIqc89FhpbSsD9W38MjVviqnSyiUJlneZ2KL4g8IS6aBFdLtApfQP89U5FCnM4drf/N5gcB2EsnwWhkXSut4PyT2QS45WW9s0oAohLnaw3kwzHL8nGwf46HdPp61H3yU6H1W0zzsSSXqNrcqhN7lIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v7jgDbos57NmVjFsBB0NnJdEk8rmOjeUDghDshnTRM=;
 b=qExN99gnh1U3YQLsQCORTXFeHzo8cK+NY6TpxFt13Z/EpW4evjGBprsNEmGmYcWhyJbFx7OeDTVO3oUauY0L5k54rHnf5HXkvUVC1UfnfbBuurk7HwS7DEnCGS2dpzeuN2Pc91nilvJS4fjwOYjKyLQtR2kXyfLAs02DZ/QzlDfoJf1hh699mgyGhIIdyRFchBa1ozRFtJHyg0xTM979+/+AlkatE06JfgLEOBso0SggdKOzlZml3sDuFiqAlk5siEqSrC2rXD+BdMaaS2kLJHQyztk0IIeacIUATmfMUolQYj7ifHKdhpYM3Ks5PgECfvtgh56C5fUKVCJsuwNbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v7jgDbos57NmVjFsBB0NnJdEk8rmOjeUDghDshnTRM=;
 b=FYSsp93OsAa3UbNBEYmhasXDbv63ZTQfIRS4h7lDqpxwp8V4d+Ay/XcqGgQF4vrfLFdFvUz/jvms8BqBX8eGtMhAooKzRLncPet0Pd+TMWNatEHigQ8P5QJyzePz3IMEReuaQu7J4Wz8mdYQLfe6IkIm8QrzkI2uJCDGkQQq6LI=
Received: from SN7PR04CA0192.namprd04.prod.outlook.com (2603:10b6:806:126::17)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:51:29 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::fa) by SN7PR04CA0192.outlook.office365.com
 (2603:10b6:806:126::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:51:29 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:51:25 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 1/3] cxl: Simplify cxl_rd_ops allocation and handling
Date: Wed, 12 Nov 2025 21:51:02 +0100
Message-ID: <20251112205105.1271726-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112205105.1271726-1-rrichter@amd.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: c34ab8e9-b809-4953-f7b8-08de222d4106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m0GYajwfDOSBOmIw2923SbKPzQH3S9io5liq7qgkMx8Mg0+Jb/eAuBWLalNa?=
 =?us-ascii?Q?HwdI7sOcPQtLtHFFIOO9jK3o8kvbo6yPiVdfsLleKKH8cLMhhjW7e67/Ozgo?=
 =?us-ascii?Q?4/2Al2FPr8kA1+iMA1C2Bv0xuDe7E6X5AizUXIrD0xS2Xe7hWcFr96D5PcoP?=
 =?us-ascii?Q?NeYhgvEmw4hsuv8pZLsJ7Ae2KeGwePJLG0AoeXMM/00CprTPxW4VGG2hWbHo?=
 =?us-ascii?Q?b4WD/DY+bNRftF44rGS/FfiencjsZxBMHjm/LH9JyEAkHoGTzj0u4wTai4UP?=
 =?us-ascii?Q?n2EAecfE0pFqk9v0lURsevriSpsA9rowWRkKrFMtST5q8wpn4ZKnf88ZO7ZT?=
 =?us-ascii?Q?PrXdpyRYLApQ5JA15HJ8IxuAmsVlWyJU/8dVbE8Ut9wgKMNXdP3HbqNF2V40?=
 =?us-ascii?Q?7ZRhVZtO4iRzaQApZFL9GuUjJTmd3PTz0bVXNKrM2ELqnCNYKx0bGFVAbOtt?=
 =?us-ascii?Q?uBUB6DpTmn1hB3l9Wp2IcdhhvxO8LY8EJB6a5Wjz0VbaMp3ZEjhxgG1zbil6?=
 =?us-ascii?Q?6bNTXzMUv+ytwRwCFeTg6KuixqHq2UKuK/jvj7UvQt8GBmSvCe07nTGljs9Q?=
 =?us-ascii?Q?C/8QXHZu6ZQGGTFyZ7GDTCDRZFvdKzuKEb+575L1asqtA42vFJiyuW95DFA8?=
 =?us-ascii?Q?Ohxv/WX1FOBn2uzO7MVu0YP6N49I736eks6sMECw5ZYMvebAyOYg6ZcuTCRs?=
 =?us-ascii?Q?HBsliwOBborD3pBTgbR7cBhF63+o5dWOPeSd8HVkZoTC+4DtltYxdpx546hb?=
 =?us-ascii?Q?QVahGEL55c7llOXmCm4XOQql+H4IljjBjbXDYUbjojllqb0TNcpT9y9kr6FU?=
 =?us-ascii?Q?8G9eRwrHbVAT24voWOFhb6rPCKVu9Vtw1kki4IZWoEVpjZx+W2prjq0z5Q5E?=
 =?us-ascii?Q?vINyxJ0/J9nJWNGnk9hkrRJgdGtWM+l1BiO9zyeHsIy4U2UHyxm/Qrl3IGU0?=
 =?us-ascii?Q?/m60XzhvUZJBvWyX3RZ9Z+KQ4ZKID4jHCYub7QXMYFMW8qZkFTg5coUDD2Dn?=
 =?us-ascii?Q?rsiU2mREP62OS3eYvbWvGaOe4JsGRj9QFDynu+RRB1LQaD8JBP4vxEOWvKU/?=
 =?us-ascii?Q?YJk5/ou6GdbQ7+WMSAemb0Qb0TN/S93VXIvsofJz6Ac5imOk5xOcMBHDGp0z?=
 =?us-ascii?Q?YQjgIyF6ASlUFt1IxVRysu+YTyt14YucSn/4kSLhdrt2VY4j+PXaMhwH2yUk?=
 =?us-ascii?Q?3yxypJlicEQM2eEEUWiHO5Xwcoq8/Gu88+aTQnmYUEu/fYeVpLsZkQEIsEVb?=
 =?us-ascii?Q?6XhTBOfoXDgV7An3IndybpP+jCeNh8gB5xaBvLsoQlA+cITKqVnZOf+fwf57?=
 =?us-ascii?Q?Vk3VwzKTEgJdX9V1HmaZLDgCV0yn7J5/UzRzTW/tyPQH0vpq2atMPp5sNwJl?=
 =?us-ascii?Q?MjnXpVrpyKKIldf+9HRKfJ/Ea5kjPNTFd+lv+oVQfu0fm8bYxxfDWlE8TpjH?=
 =?us-ascii?Q?UGUMKSJCYhGI9VhBkBFNqHU8yKN3nDJb5Z9Qu4LAYtn2OJ4X30did6FYeL0U?=
 =?us-ascii?Q?alotCDkWDj4KDrGVxGw5jPxsmlulzK/PnGhcVXxNzb9Ed9rHD3NHO9YSooNm?=
 =?us-ascii?Q?WPkWasV0yKyY8fVxdik=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:51:29.2384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ab8e9-b809-4953-f7b8-08de222d4106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567

A root decoder's callback handlers are collected in struct cxl_rd_ops.
The structure is dynamically allocated, though it contains only a few
pointers in it. This also requires to check two pointes to check for
the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statically in struct cxl_root_decoder.

Implementation is equivalent to how struct cxl_root_ops handles the
callbacks.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        |  8 ++------
 drivers/cxl/core/region.c | 20 +++++---------------
 drivers/cxl/cxl.h         |  2 +-
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d5119de7f5a9..fab736aa77dc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -487,12 +487,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxlrd->qos_class = cfmws->qtg_id;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
-		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
-		if (!cxlrd->ops)
-			return -ENOMEM;
-
-		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
-		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
+		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
+		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
 	rc = cxl_decoder_add(cxld);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 451e5492911c..2b5ae5d9a4b6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2958,16 +2958,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
-static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
-}
-
-static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
-}
-
 #define CXL_POS_ZERO 0
 /**
  * cxl_validate_translation_params
@@ -3141,8 +3131,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (has_hpa_to_spa(cxlrd))
-		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
+	if (cxlrd->ops.hpa_to_spa)
+		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
@@ -3151,7 +3141,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;
@@ -3184,8 +3174,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
 	 * CXL HPA is assumed to equal SPA.
 	 */
-	if (has_spa_to_hpa(cxlrd)) {
-		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
+	if (cxlrd->ops.spa_to_hpa) {
+		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
 		hpa_offset = hpa - p->res->start;
 	} else {
 		hpa_offset = offset;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0481679eb109..91ff47382111 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -451,7 +451,7 @@ struct cxl_root_decoder {
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-	struct cxl_rd_ops *ops;
+	struct cxl_rd_ops ops;
 	struct cxl_switch_decoder cxlsd;
 };
 
-- 
2.47.3

