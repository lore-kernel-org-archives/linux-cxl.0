Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007558249F
	for <linux-cxl@vger.kernel.org>; Fri,  4 Oct 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065902; cv=fail; b=tGlqkibgB1HAWu+/arQJrXWiSQ88njL65LNhy2ZoGs17Frsyo+D4DQ1fdSzyrN7zfv5U6jnc0UdnjNY0wVGmxSmBz16rMBIAU7TnvU+cpCo/kwr3k73J5Nci+uh1aQW70J7G9IZ7VgItK3NrQkJDPyucDulJqlc1TOkDPTkfeBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065902; c=relaxed/simple;
	bh=8RaT7FHVSobHXnLWltqIbnfa7yJsNyd8cn5cbJe2FZI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5E0/v4J5JGz5BIR02JjyY6LX7A8RnaTyRwSCs0TZwmkvYDZhdvyhgbn6sl6g9d73SO3TQUtKIKAHDiGhVQaLJVJaReayPpjpJ+TtTXUa5B7haw3hvnp38EqGHOSHbn7B5scwD4MUxUqMw50OXV1AIOG52tnrmU2ZdPIH0nsAtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QGGZjYko; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QGGZjYko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQcE12hz4eL4VA3NJhaQkFIsCo1dPxWOAvbKylOk/SQkTm+qVgu+BMlfV0d1PUmsHNKWvIxeL5UiHXlMOwBmwCBW2/lgfJk6Aet4UeGuSdp/1aYmb2iEN4p2h7jzvsWBBPJ8ru6NfVmrAs2Zdho0bDNY01/SIYeZvUDOog/8eh28e7qG8EgRuGRXXeV4BH84N2Kih0puYedC4AShJLkgRNxoYxSWCK/mPSFqCww2e8RyuBTQa7/1t+3NIeTnViL7lMnvqvcWnSlXBDatqj0pMd8ttobOeKLc0bXdA1WJfSejSzBFX0YiYeV6moFLaOflDYy5UvKqZqomAii+4w1kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ0P0Uh9fxjz1KIuMJAXZb/iUCNgyLJXdOJVqSAcdmg=;
 b=wDtSGJSMgVtZ8oNrw09KeOYbWfbqE/XEJ/8kcphVPw5xsM+qbF87izv+M/Sd6+cfgBHBnfnsFfVkY5ng0geQ4cBaFXCtFc8Gl5I9MaV8cyPYxY6heOEqWI73ph2B/sSMXrywVWGbMOjx86Vn0VGvmHQpEZ34f6j9FZc9oyuYGybfv9wSnuZsVMqmApLuI+xcZsURxCoVx4EAairyIGDZv2N5mEU++g3zuPUeu5r83abe+aY1Z1fhHDIsFfetVPJ4H6CPk96Lf98ayKpA4pGzBNDtWJOn/+B5KBcfBW2cg/mxAMGqwznHJD+DzH5KgYsPo2bgnvrpsHge6JpPFgSkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ0P0Uh9fxjz1KIuMJAXZb/iUCNgyLJXdOJVqSAcdmg=;
 b=QGGZjYkoupcmz8LnjRudopsGbVz77sug+0cCaYvusjfJWWt1592Yxkj73krTKhnqj5xs5X3DDbw+ZrfxGjOK6ztZUUxonaTbLBPocMHQrTo/UCseeOE9qNYpfwGqt8BRS/cikodhDFGLPvSBNhogZdthlZPZzIbim9aHihzosP8=
Received: from PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::15)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:18:13 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::67) by PH7P220CA0128.outlook.office365.com
 (2603:10b6:510:327::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:18:12 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 13:18:09 -0500
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: [RFC] cxl: Update Soft Reserved resources upon region creation
Date: Fri, 4 Oct 2024 13:17:54 -0500
Message-ID: <20241004181754.8960-1-nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1493f23e-cb8c-45d3-9fa7-08dce4a0e8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aBK8b6VN8oDhsHvOxBi9F5V0AaYQDVz2gylNZXu4d4i5jdBQh/LvLiENN6C5?=
 =?us-ascii?Q?KTR2PMaxPxkKfVt+zRLH5lIZNhJDNi2HvpcyNTmshTTI6LO7hkQPeAGVUDo+?=
 =?us-ascii?Q?ToOKca27ZkIPvFTcn4xg+WHJYbhyv+VEE6U8clPGp7d5lv925TR5T2vsUM23?=
 =?us-ascii?Q?WRojS6zEprgWnS2mk2A/81sIDY0TtSZtygsFeDULN4oDHepaex0dniWWC8NK?=
 =?us-ascii?Q?pKZiNhN2CeQHCOGKpiHyR92KbdfELKZBXLophj7Zrs5EhGqbcbmosK/Ek/wL?=
 =?us-ascii?Q?QS8bg8s/uNudxrcdV6KqdFidZ8Q+9Eaf7ZS7fxv2iS6waFemgkDb1Yr5c9VA?=
 =?us-ascii?Q?JBrUhMP9bz+ZKm4FkbXnzfwTBOGwJwa06lUT2DNhIUD8A7wQrRY2dXCmeJ4D?=
 =?us-ascii?Q?1cV0COd0IsxCc8I8ApuHxSDQtChi7nH6gXjPJ4nITF4YAM1vOCsPiluVUDXH?=
 =?us-ascii?Q?4PVFZiMZCd5ezJYmyRDE8WQbtQAit+0j/loVZcsedI/6/B0dY9Rv49w+edNp?=
 =?us-ascii?Q?5WVbxTQyHV/AiD4MGteZrNpEtuOBxS7iHXZWKpavcY8cZfmA/SSCwHXXnM87?=
 =?us-ascii?Q?tw1leSftZqT56pqYPkVfe3PCPg0hpdN8UKkYF+iT6Sw7cGp+6yCDvLYWHtl9?=
 =?us-ascii?Q?9eKDd53MDvf5YVcSiGj7Y3Y33h1H8ZqcQm2jt2Syp1qvrde4DTm0rYMiCcqc?=
 =?us-ascii?Q?j/zd400gluLtR4OxeBvDZLo5JnOeHX5yEYsY6BHqOQMmtoj1HIrkiN3o0qCs?=
 =?us-ascii?Q?vEP60Fj6NpD9nazY2Gtzvb+Bd0O0F9bEzdPpma15LOvi5VvB/9GKgui3bYmt?=
 =?us-ascii?Q?mlss1w8XCcRA4z9puChTNSPmW/0rZRU3QOnjOltanErZ/fLbVXclE3v0H3mO?=
 =?us-ascii?Q?87LQPi/ooiNqeIi1DZhs2G5shc+/oLZEQAh+JdA3T2Zin0OqZsrB86Gt0SbV?=
 =?us-ascii?Q?yAYXeK/wkD3tn8il5tmxKUqz/eF3ppAsa1iAKnhb00rl8gKjIp5vYcK9cwFc?=
 =?us-ascii?Q?Zb6GN9NzWwd3P5sRr0dOq0YS8NweS+KOnCT8s0bGe5QQ8ZoGgfWwwe2AsVSR?=
 =?us-ascii?Q?FbTRoxJR7s8H3YQjUtmGf/YztrxS716YiCz5K2BYC9l4HfsUNjNp/3yL260i?=
 =?us-ascii?Q?W3CbyAKw4pbi+aFAEsDgKF52MNigVkcWdtCoiv5TfKvGRURuWGpGVWIEDt5D?=
 =?us-ascii?Q?6pDI0ikTe+2aApCxiW2zuTr4srnkltnIZDCWWMqy2H+CKAmma1bGpc4N5EuO?=
 =?us-ascii?Q?uA2j+l25Tt/eq3EahTXyVOhwAr/fCwW4GEPG+UATwz7tiYJgrca9hLgpW048?=
 =?us-ascii?Q?X36nZwVSIYNCjAgXMmsKS2rZLYRoHpCYqvpf8lHT9WhnphKehaxuXDlN4d6u?=
 =?us-ascii?Q?iyOHjKnAGde/erKj28sq50y7tHXy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:18:12.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1493f23e-cb8c-45d3-9fa7-08dce4a0e8aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Update handling of SOFT RESERVE iomem resources that intersect with
CXL region resources to remove the intersections from the SOFT RESERVE
resources. The current approach of leaving the SOFT RESERVE
resource as is can cause failures during hotplug replace of CXL
devices because the resource is not available for reuse after
teardown.

The approach sought is to trim out any pieces of SOFT RESERVE
resources that intersect with CXL regions. To do this, first set
aside any SOFT RESERVE resources that intersect with a CFMWS
into a separate resource tree during e820__reserve_resources_late()
that would have been otherwise added to the iomem resource tree.

As CXL regions are created the cxl resource created for the new
region is used to trim intersections from the SOFT RESERVE
resources that were previously set aside.

The next steps are to add any SOFT RESERVE resources remaining to the
iomem resource tree after CXL device probe completes and to notify
the dax driver so it may consume the added SOFT RESERVE resources.

This patch includes the use of a delayed work queue to wait
for CXL device probe completion and then have a worker thread add
any remaining SOFT RESERVE resources to the iomem resource tree.

Not in this patch is notification of the dax driver so it may consume
the SOFT RESERVE resources.

The goal of presenting this RFC is to drive discussion of the
current approach for trimming SOFT RESERVE resources, the use of
a delayed work queue to add remaining SOFT RESERVE resources to
the iomem resource tree, and methods for notifying the dax driver
of any newly added SOFT RESERVE resources.

NOTE: As this is a RFC the temporary pr_err("CXL DEBUG...")  messages
have been left in to aid in testing and validation.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/include/asm/e820/api.h |   3 +
 arch/x86/kernel/e820.c          | 156 +++++++++++++++++++++++++++++++-
 drivers/cxl/core/region.c       |  14 ++-
 drivers/cxl/port.c              |  34 +++++++
 4 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f0e935..542a52871beb 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -44,6 +44,9 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
 
+extern void e820__trim_soft_reserves(const struct resource *cxl_res);
+extern void e820__insert_soft_reserves(void);
+
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
  * the ISA region.
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4893d30ce438..855c26460bb9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1208,15 +1208,165 @@ static unsigned long __init ram_alignment(resource_size_t pos)
 
 #define MAX_RESOURCE_SIZE ((resource_size_t)-1)
 
+static struct resource e820_sr_res = {
+	.name  = "e820 Soft Reserves",
+	.start = 0,
+	.end   = MAX_RESOURCE_SIZE,
+};
+
+void e820__insert_soft_reserves(void)
+{
+	struct resource *res, *next;
+	int rc;
+
+	pr_err("CXL DEBUG Inserting Soft Reserves\n");
+	for (res = e820_sr_res.child; res; res = next) {
+		next = res->sibling;
+
+		pr_err("CXL DEBUG Inserting Soft Reserve %pr\n", res);
+		remove_resource(res);
+		rc = insert_resource(&iomem_resource, res);
+		if (rc)
+			pr_debug("CXL DEBUG Cannot insert %pr\n", res);
+	}
+}
+EXPORT_SYMBOL_GPL(e820__insert_soft_reserves);
+
+static void e820__add_soft_reserve(resource_size_t start, resource_size_t len,
+				   unsigned long flags)
+{
+	struct resource *res;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		pr_err("CXL DEBUG Couldn't add Soft Reserved %llx (%llx)\n",
+		       start, len);
+		return;
+	}
+
+	*res = DEFINE_RES_NAMED(start, len, "Soft Reserved", flags);
+	res->desc = IORES_DESC_SOFT_RESERVED;
+	pr_err("CXL DEBUG Inserting new Soft Reserved %pr\n", res);
+	insert_resource(&e820_sr_res, res);
+}
+
+static void e820__trim_soft_reserve(struct resource *res,
+				    const struct resource *cxl_res)
+{
+	resource_size_t new_start, new_end;
+	int rc;
+
+	pr_err("CXL DEBUG Trimming Soft Reserves for %pr\n", cxl_res);
+
+	if (res->start == cxl_res->start && res->end == cxl_res->end) {
+		pr_err("CXL DEBUG Releasing resource %pr\n", res);
+		release_resource(res);
+		kfree(res);
+	} else if (res->start == cxl_res->start || res->end == cxl_res->end) {
+		if (res->start == cxl_res->start) {
+			new_start = cxl_res->end + 1;
+			new_end = res->end;
+		} else {
+			new_start = res->start;
+			new_end = cxl_res->start - 1;
+		}
+
+		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n",
+		       res, new_start, new_end);
+		rc = adjust_resource(res, new_start, new_end - new_start + 1);
+		if (rc)
+			pr_debug("Cannot adjust soft reserved resource %pr\n",
+				 res);
+	} else {
+		new_start = res->start;
+		new_end = res->end;
+
+		/*Adjust existing to beginning resource */
+		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n", res,
+		       new_start, cxl_res->start);
+		adjust_resource(res, new_start, cxl_res->start - new_start + 1);
+
+		/* Add new resource for end piece */
+		e820__add_soft_reserve(cxl_res->end + 1, new_end - cxl_res->end,
+				       res->flags);
+	}
+}
+
+void e820__trim_soft_reserves(const struct resource *cxl_res)
+{
+	struct resource *res, *next;
+
+	pr_err("CXL DEBUG Trimming Soft Reserves\n");
+	for (res = e820_sr_res.child; res; res = next) {
+		next = res->sibling;
+
+		if (resource_contains(res, cxl_res)) {
+			e820__trim_soft_reserve(res, cxl_res);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(e820__trim_soft_reserves);
+
+static int __init e820_parse_cfmws(union acpi_subtable_headers *hdr, void *arg,
+				   const unsigned long unused)
+{
+	struct acpi_cedt_cfmws *cfmws;
+	struct resource *res = arg;
+	struct resource cfmws_res;
+
+	/* Validation check, remove when finished debugging */
+	if (!res->parent && res->end)
+		pr_err("CXL DEBUG Should insert %pr\n", res);
+
+	if (res->parent || !res->end)
+		return 0;
+
+	cfmws = (struct acpi_cedt_cfmws *)hdr;
+	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
+				   cfmws->base_hpa + cfmws->window_size);
+	pr_err("CXL DEBUG Found CFMWS: %pr\n", &cfmws_res);
+
+	if (resource_overlaps(&cfmws_res, res)) {
+		pr_err("CXL DEBUG Found SOFT RESERVE intersection %llx - %llx : %llx - %llx\n",
+		       res->start, res->end, cfmws_res.start, cfmws_res.end);
+		e820__add_soft_reserve(res->start, resource_size(res),
+				       res->flags);
+		return 1;
+	}
+
+	return 0;
+}
+
 void __init e820__reserve_resources_late(void)
 {
-	int i;
+	int i, rc;
 	struct resource *res;
 
+	/*
+	 * Prior to inserting SOFT_RESERVED resources we want to check for an
+	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
+	 * that do intersect a potential CXL resource are set aside so they
+	 * can be trimmed to accommodate CXL resource intersections and added to
+	 * the iomem resource tree after the CXL drivers have completed their
+	 * device probe.
+	 */
+	pr_err("CXL DEBUG Checking e820 iomem resources\n");
+
 	res = e820_res;
 	for (i = 0; i < e820_table->nr_entries; i++) {
-		if (!res->parent && res->end)
-			insert_resource_expand_to_fit(&iomem_resource, res);
+		pr_err("CXL DEBUG Checking e820 iomem resource %llx - %llx\n",
+		       res->start, res->end);
+		if (res->desc == IORES_DESC_SOFT_RESERVED) {
+			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS,
+						   e820_parse_cfmws, res);
+			if (rc) {
+				res++;
+				continue;
+			}
+		}
+		pr_err("CXL DEBUG Inserting %llx - %llx\n", res->start, res->end);
+		insert_resource_expand_to_fit(&iomem_resource, res);
 		res++;
 	}
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..539cccfffda0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -14,6 +14,10 @@
 #include <cxl.h>
 #include "core.h"
 
+#if CONFIG_X86
+#include <asm/e820/api.h>
+#endif
+
 /**
  * DOC: cxl core region
  *
@@ -3226,6 +3230,14 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int insert_region_resource(struct resource *parent, struct resource *res)
+{
+#if CONFIG_X86
+	e820__trim_soft_reserves(res);
+#endif
+	return insert_resource(parent, res);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3272,7 +3284,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
-	rc = insert_resource(cxlrd->res, res);
+	rc = insert_region_resource(cxlrd->res, res);
 	if (rc) {
 		/*
 		 * Platform-firmware may not have split resources like "System
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d7d5d982ce69..9f94730c488f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -7,6 +7,10 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 
+#if CONFIG_X86
+#include <asm/e820/api.h>
+#endif
+
 /**
  * DOC: cxl port
  *
@@ -89,6 +93,35 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return -ENXIO;
 }
 
+DECLARE_RWSEM(cxl_sr_rwsem);
+
+static void cxl_sr_update(struct work_struct *w)
+{
+	down_write(&cxl_sr_rwsem);
+	pr_err("CXL DEBUG Updating soft reserves\n");
+	e820__insert_soft_reserves();
+	up_write(&cxl_sr_rwsem);
+}
+
+DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
+
+static void schedule_soft_reserve_update(void)
+{
+	static bool update_scheduled;
+	int timeout = 5 * HZ;
+
+	down_write(&cxl_sr_rwsem);
+	if (update_scheduled) {
+		pr_err("CXL DEBUG modifying delayed work timeout\n");
+		mod_delayed_work(system_wq, &cxl_sr_work, timeout);
+	} else {
+		pr_err("CXL DEBUG Adding delayed work\n");
+		schedule_delayed_work(&cxl_sr_work, timeout);
+		update_scheduled = true;
+	}
+	up_write(&cxl_sr_rwsem);
+}
+
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_endpoint_dvsec_info info = { .port = port };
@@ -140,6 +173,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 */
 	device_for_each_child(&port->dev, root, discover_region);
 
+	schedule_soft_reserve_update();
 	return 0;
 }
 
-- 
2.34.1

