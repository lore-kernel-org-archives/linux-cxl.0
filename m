Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049C33B973;
	Thu, 13 Nov 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032553; cv=fail; b=l9n5w535kfpWnHJQl8qa+eD9ykm7pxVkScyNOnQYI5fRyRnjMSeM8urfX7Fd6E2XHgv+wYjDHsoZCOGrhyWqj1gKcHXNCQsio/RkRXgreXRXr2ZWyUaZrID1vnTH+9uaAhc8WArMD9Jmh5k/r15AwTYztt9qYGKPrauL22JdsF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032553; c=relaxed/simple;
	bh=7+Hjy+PDq2PdSEF7i0bQ7MLRpOpqLnmU7cOIkXfw+Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWkpuoylXBGySpgwAR8AaoCgV3Sj2fEqSaxZvv7iIj2MySraEpSvjqQtM719a3bnNZbJZYb6Qkg74zfqTr9eGcwn9vb2vc2J4Jt7qZ7MsmwaYg80ZZ5x8IS4k4iqishgY+DXNlRTcfvAyjAnSgVd3f9BPRDfkH+TQaLsaPAn7Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afIH4eLR; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afIH4eLR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXANAhpnn+MaQeiR/cM+crKGSSFTocTzuCfyVM0CdOIbOV5eDy3kZZGF22hB1mWRuOymkIYdlR3F1GrZ4YReviFmMfllDKzRXc/i+dPxjDtUp0NN7Nw+ZVvUBXMawzj/+eBafgEYXPaWDKTG4DmZRcI8ZsVnsb5/Afbs3LXrKKzbfVAtiJx1gMKebOoNGKyc9Yf1+vY212V0cjXuY/R4qiTnm5wg8XLdX63JmKGfSsBkygfjL+FiEPtpppxIoEUEiXlBrfyf6PQaK7TOYk7dXJe+mE+bCQL027I6DXZWAXsnQpcybTFq5ybu838O+RKp4hiFC0w5s1c/Xdu4imJuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4VPOM2mzU08wWe2ba+a0RzWMXB/iwa4wsy6ZqLsPMI=;
 b=VT9ni6f0NsrKnoJnYQg7E9jIKVXq8u/33egm7s37C9rDX9xvDsXNLNa083JIcsNgLLVzQh3wZfY2M/zELiMgQKag+0owPhfsK0/LOtoVgfaw1gAc2+dG2js0uLA75fCf1Uk7mG2fPA9nym/vCzpsBDxGJbjOWfP3d54hHjUIvvtbB47BefcH6gFB5XTQivw+1ZGprPS1ViQxdDry7vQe4sO6pbscG+FOqpK7Tx+oSC8ydN4t3fyCxMNs7ymx164CaaFxXUmTKr4YvjXkQT/0VAvAyExsxSzoEE+absPBfFevh1gpixy0QBpahX0gxlkn+sJ8327kU5k+6ML44464gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4VPOM2mzU08wWe2ba+a0RzWMXB/iwa4wsy6ZqLsPMI=;
 b=afIH4eLRJgZiUZmbXKtouENrGgv7LdRK9hWgBFjiEH2oHRs3hGAkR/8xbRxCIZSrwjTPxyk44XDRvio3uknn0BTMZwZ82npmFKohFCT1R37AcAXqKHQV0ZobQU3rTlviD4wl+cjhBpGT7mvpB6eY+lbDzZanY1FOAur+mPT1XHc=
Received: from SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) by BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 11:15:47 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::7c) by SN6PR2101CA0027.outlook.office365.com
 (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Thu,
 13 Nov 2025 11:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 11:15:47 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 03:15:44 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 1/3] cxl: Simplify cxl_rd_ops allocation and handling
Date: Thu, 13 Nov 2025 12:15:21 +0100
Message-ID: <20251113111525.1291608-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113111525.1291608-1-rrichter@amd.com>
References: <20251113111525.1291608-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b8d5d7-e246-4dd1-4787-08de22a5fedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KMBdttl0pfIIvbKn6eWG/c+Y6J0VvektwkNJdrxUC8f49H1yeyj3ziFbK2YM?=
 =?us-ascii?Q?N9XEzVurNY1QiD3b1soKOLFKa6L3133Qi0t5gzZZM2cjaExeCerssWeGKFYD?=
 =?us-ascii?Q?ptEou0Q59t1Tz9wdzYM6TOSwJbF30i+dQl1Lwy91PrO6L0narm4pNtDhd69+?=
 =?us-ascii?Q?DDIXcJPlg6j0fB1KJeAYAjplubcg8DN3IFqLxG5hTDI80lGkcpFdDmDRoiK/?=
 =?us-ascii?Q?pDQ2yvFgFhOfoKh2qHMMZGrLs1lecdlR/m684pk5uT9N3zuvCgFd+pURwJ9e?=
 =?us-ascii?Q?f3l9xt8aNwQZ96Cm+lJhLDIewRd0SRuHSiLFrHRGxwZ+rK5KoNPqxy7Zy0pQ?=
 =?us-ascii?Q?/ecmxOzDpab1Jk1xJDl5eFo/axB3mecC9rT2I1hwQLbJsQEgtPSuZJMe80YC?=
 =?us-ascii?Q?eG+3nGINCej/bZ8HY0GUz3fM4jzGpfAhZs69G9fxFqFty6UwNdQN3BBgA4tb?=
 =?us-ascii?Q?lvkoKS2TwQvuZOHeoxoS8IkXuyfw3DCTVDsP08FW7Z13sAC5ytHjb2sKBbfg?=
 =?us-ascii?Q?frM8ssR61HrfMCJNM6hDzgqTyJrWX8vFuPzximnhtXTtH4Ehhg21ORwvMwKa?=
 =?us-ascii?Q?7W4DXZopHWx3lov8/nKL6DS1vK9tNb/TF3FxMDLkEQG4bM7qdpj+O1UIZJtd?=
 =?us-ascii?Q?B5TMRzdtvW2NCIeVBaFNpgfRpaMVVixYDjM6NdaWkkxusjFCm2e0Jh/IHb3j?=
 =?us-ascii?Q?Ia0WPGSlAnu1UdIiNSjqE9aWZfrMrVY4eJtIbPbKqS983DrW4sQe08n34Aby?=
 =?us-ascii?Q?HQME8/QaH7pk/VGTaaYOYEXpGFC/wh+Z0QfOZKM50BjjIYZD4oPFqxozax3x?=
 =?us-ascii?Q?Ct/krIUPXcBYou9Ge3gx6dHuOs69iOLMFyi6KNo8SU0JaEELADUmc3iOBf5s?=
 =?us-ascii?Q?fDHaCNNvi876ZzUdlfJJZ6GPO39LgTJE6nr59Dne2NlFL61Gv5VDeY9hvLyq?=
 =?us-ascii?Q?5/Em35tSGMxjtw2M56kmaOq0WBh2sXsST8DEOPoZUKOaQhriTHu6aKBvWfoa?=
 =?us-ascii?Q?AsonkALItyjAGogMYOPFY0BQ6Epbo1fSyWVhMCX8lpPVESiIp7WTp+Y9P2eS?=
 =?us-ascii?Q?lPiwA+vZrDJ7LZNbrOViuvVC9PKP8zp7ICTlZ0phgEH7WlBsQ085ruRXBNuN?=
 =?us-ascii?Q?VclqEZK4rmOJ/9rG/kDGvK93FKurTmJ625r0FKJqO+Ft+VNXVpzLeQr6VVOF?=
 =?us-ascii?Q?BdvshcIZzfmDunzkwpu7MHOpZ05ObcrBhs8L5+m6ubTrkpNvRxulh/BNgmBu?=
 =?us-ascii?Q?u3O9T+s3QNVoPfOUIc60mWHWAkDVdMJ3CDGhF8aeppu8zel4Rj3ZSzxQ/p4J?=
 =?us-ascii?Q?eSykAD5XMpuxqvmUF6zd8G7PDxk8sScmtcNoJ24PpP+Zz5NwBZXm8Zi56fzC?=
 =?us-ascii?Q?8bYgmaRxfIUSn0Kz5Irx44OmgF3CfI9Aa2E7yg/2rhOhU3xy+uSgmVO1GrL0?=
 =?us-ascii?Q?GeY+jtXrD0w2VaaknC0AmObVnOC3XWIG7XqvMe4ARM7CoR4ur3uv/mhVlcyB?=
 =?us-ascii?Q?pGSfeM0DFMtw+tYz5Vh2CFec3Kq+G3Ls+2QCySAeMa4qtCoFrCOO60cOTW0S?=
 =?us-ascii?Q?sNr/86s/x8pr9VXeDNc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:15:47.3330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b8d5d7-e246-4dd1-4787-08de22a5fedc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

A root decoder's callback handlers are collected in struct cxl_rd_ops.
The structure is dynamically allocated, though it contains only a few
pointers in it. This also requires to check two pointers for the
existence of a callback.

Simplify the allocation, release and handler check by embedding the
ops statically in struct cxl_root_decoder.

Implementation is equivalent to how struct cxl_root_ops handles the
callbacks.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
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

