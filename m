Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65D1BD9D2
	for <linux-cxl@vger.kernel.org>; Wed, 30 Oct 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309291; cv=fail; b=Dh8TWbMcBiC04KHO4sxnZBuJ0K9q8J3u+v7VYnfWAEadKnf7RXdBHrIGxGKYYwcmSzeOSPV/RUDfN038zd50twD9dKzL1OmxL6k8RIY5GRPf/BoHKa6GZ/03HtmIKUMMkkNFbkq75JJCu0nuBTUdN+/BAOhbmawkq2KTs78OoLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309291; c=relaxed/simple;
	bh=IGYETq7v1EpTQ5Vfp+YNjbZ1VpKAUFRruvild7ipj4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kuz3p+FoiU1l5muKvGnU4x25N7CWPbb7C6WYVlS5z0c2emXg9OpR2+qnWg6bONfUXCG6E4UlQ+E7G690xkVdQAo6cZrolBAcac1cPnZM5eFYMsfFTOOwtFKSCm5UUDduPQO1VRQYdxGfXMMnZOf4a6RxyHWrJF0asukOl/Mz4vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LEDFc32L; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LEDFc32L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlyXAQQEdPlWW2yfGeK+rDquB2jv9vgKA9XSoUgQXK8KXt+5GyTXl5LTudqy0oRk1JWy6iy8MmZPaZpb9IbVDP+UVoNuKyaLXgcM6Yyv3O2nDX/onRFD1+Y3DHdzi+fOk8WH6O5tczPZLRsw7MTKO777Ay1xpzmtHpTKrKlBqb5rtsqgLl5Vh9PKcmOiO7vi/n5QRXYqExRhg58fvwd+N0aJzgp6p6lM7m17gZcS95E9lisuiT3rEVo/soaziuOPsheBmrZDQJRWtyG/xESpmLOPZ63LXvy1fkp1zMW/UiQQEUnfF8ocMSGqmGdKHMEgFEL2nVZwlF3j2ZZSS7v6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLFjQ0S/RTPk9aYDv3kokNCQBr2Ukl7HcqzsSqj7N3A=;
 b=PyRno9IE9/t8Ox8tLIBYOnCRIrpZTRs0Vgmi/XZQbZEGfZqATTwnSzUNAfDgL8cgg5atEQML+QK8EyVD0xffpTgg7WQx04jafhG8sYg/8CbW1tulTkrk6hjXttQ00eRmuVLN1JQsVrEsBu37G0DCkMi6IqVnyLYW8luCYbQrq1E8VT8EFH0euroPKKy33w8j6G1KPzWVYXpoLSEK7XoaHr9V4XSc+ZKJMJibLpnh1VkFhlrB3MvBrAbb7kE0/NQSaqj0TisuaBp5G86n1iN7D8sT3Anjw4xjASqzqxSdh4FqhWmXc/0ioKpRtjILaLcvA99QE5jjV8UiHbHrKzabng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLFjQ0S/RTPk9aYDv3kokNCQBr2Ukl7HcqzsSqj7N3A=;
 b=LEDFc32LHvCt66DWSJInCGUY5ZRDsp+87ESHfX9Uhl3Hobc8fvxA1cQdIIOTfUwx1gVxyzRlfm1OjWlIxH0cNdzT5HyswyryxeatZQf1sIFwxtBtuZyL2lz61JSXNsuvjNVoG90Ly0QFCIyGn1ZQIJubonO68NTXFWxhFSLIyV8=
Received: from DM6PR06CA0070.namprd06.prod.outlook.com (2603:10b6:5:54::47) by
 DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 17:28:05 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::23) by DM6PR06CA0070.outlook.office365.com
 (2603:10b6:5:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 17:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 17:28:05 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 12:28:04 -0500
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC v2] cxl: Update Soft Reserved resources upon region creation
Date: Wed, 30 Oct 2024 12:27:51 -0500
Message-ID: <20241030172751.81392-1-nathan.fontenot@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: ba47caa6-4de4-4327-753f-08dcf90836a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e8rsppsDJ+SohiKja48cLuDlBF+fdKdNc1Xa3gNTOULLwW5uU45kejHowAVa?=
 =?us-ascii?Q?bSqoJgN2vQZJrgS4jhXXhudFLyLhu7lkSaaPmyyL987cxcV/7nMetFC8vg0h?=
 =?us-ascii?Q?FoOvQZ2CJSYHSyqsCeoWYJ91JqwzqGEej5mFCcFap3+pOc841qyQzp2wNdH7?=
 =?us-ascii?Q?khLml80L8ORsvLWqP455pl72iTgs6bZS4dbuH+5ED53ayS47DOm0k2fZz+Yy?=
 =?us-ascii?Q?IADHrE/W9CSNOVaOSiRkV6HH/zdT5VnWKJB2nT3CyphZcSld3+jV9t8mGEp7?=
 =?us-ascii?Q?TFvYxqx0C11C16GJ5beJvyKztiFmL+xZLob8ASnC0107p+xLQjLH6snFGHsg?=
 =?us-ascii?Q?Pt5PaAHSZMG3iRNOaINGPhEyy0PuvnujQnVKjLelvy6gCANw3BSAhLFItyFj?=
 =?us-ascii?Q?8j9iN7gSoVRyG01EyZJfmeWfXCDFnBwFWWBwIvztuXanbS15MsYcmmMSpRXn?=
 =?us-ascii?Q?dkvoKfFy0dSY8U5zsNpIKYZSTfixqtTbzUcjmONO2bE+b6VV5Uqye4sLxvtj?=
 =?us-ascii?Q?U65s5AukSIv2xXEB/6g60n8VtGPFY1CmOgltiw2U9MJde+QKAViWM3PdGbiK?=
 =?us-ascii?Q?j250k9uD2bIWKrIEfe8+PCJJgycKXh6aePyF7hz1SvsssKc5fDxOVJkvsqek?=
 =?us-ascii?Q?mxVPXnS0NTQjgrIuDFt+GzoFOdjp8b08fNpay9rfOwXFcbytMUOF+mc8YpVY?=
 =?us-ascii?Q?NI5vMBbItWCMbmUpfXiK2ZF0wU2mdhGZINl0chXL5DWxxoiTSo5otFg0+UcR?=
 =?us-ascii?Q?rBteeepGLPwX5xHSbSVSVeY1vecW0furukHxwLy7vV8dQ1T3thlXYNHHBP4q?=
 =?us-ascii?Q?avkoEq3kDYhXDoD9Vdk9ANtuFUywbcAdnh2mjwxof3IKVbNNQSsJz24aea/Q?=
 =?us-ascii?Q?GfiDs4TujTxLWG0Z3nwtqAd1+oE5VjfUZhISCnslx5t3+GPCUfvpsCQOdA6R?=
 =?us-ascii?Q?KO2wLh1icYqeB71DeFMX7TDhKHAzfEwWjk7pszCPEsl2uu19XDlM3YHSl7M9?=
 =?us-ascii?Q?Vb2BZZLnfE1CVaR1AQbeVZwKy/dgyXe6iPIJmtvaISWNUR63zvAwrt2puzS9?=
 =?us-ascii?Q?YV/7l4FoZsZTfFxSWP3RwMb5a5EQnA0WCDT9ahqnpde+knkspy4lZYt2Q9iT?=
 =?us-ascii?Q?r+ha8XrVayUTJLGfDQV0nBzvkoANGhyxExpGZgijYpLkhs82OqLlKPm8BJ7u?=
 =?us-ascii?Q?vaHDfNqPlcggtoID+DKm+ifBT77csqyiPpfdva7+bWAp2UgOdG46OoeGmPYC?=
 =?us-ascii?Q?Mg/hrDG2fz9mQL51mD1bHJlyujXt4cMNirDraslt1hO26weQvAJlfrkE+AJf?=
 =?us-ascii?Q?bai+s5e78nXGowmVe35/iLb8El5Jk0sRp+Lx6gChVGWj8HE8FiV9JE2YA3Z6?=
 =?us-ascii?Q?PXF3fvozpyvz4M2Jh1TrGOh0PU8OnslLT89YC9E71GwBj0UFnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:28:05.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba47caa6-4de4-4327-753f-08dcf90836a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

Update handling of SOFT RESERVE iomem resources that intersect with
CXL region resources to remove the intersections from the SOFT RESERVE
resources. The current approach of leaving the SOFT RESERVE
resource as is can cause failures during hotplug replace of CXL
devices because the resource is not available for reuse after
teardown.

The failure occurs after the hotplug replace operation when trying to
recreate the CXL region. As part of the cxl command's steps is a wite
to sysfs to set the region size resulting in a call to
alloc_free_mem_region(). This fails due to the presence of the Soft
Reserve resource which covers the same address range as the CFMWS.
 
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
for CXL device probe completion and then have a worker thread merge
any remaining SOFT RESERVE resources in to the iomem resource tree.

Not in this patch is notification of the dax driver so it may consume
the SOFT RESERVE resources that have been merged in to the iomem
resource tree.

The goal of presenting this RFC is to drive discussion of the
current approach for trimming SOFT RESERVE resources, the use of
a delayed work queue to add remaining SOFT RESERVE resources to
the iomem resource tree, and methods for notifying the dax driver
of any newly added SOFT RESERVE resources.

NOTE: As this is a RFC the temporary pr_err("CXL DEBUG...")  messages
have been left in to aid in testing and validation. These would all
be removed for the final version.

Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---

V2 Updates:
- Move the handling of the SOFT RESERVE resource tree from the e820
  code to kernel/resource.c to make this generic.
- Multiple general code cleanups as suggtested by Jonathan
- Remove cxl_sr_rwsem, no longer needed
- Update delayed worker thread handling to just use mod_delayed_work()
---
 arch/x86/kernel/e820.c    |  20 ++++--
 drivers/cxl/core/region.c |   8 ++-
 drivers/cxl/port.c        |  17 +++++
 include/linux/ioport.h    |   3 +
 kernel/resource.c         | 138 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4893d30ce438..942597f104a6 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1210,14 +1210,26 @@ static unsigned long __init ram_alignment(resource_size_t pos)
 
 void __init e820__reserve_resources_late(void)
 {
-	int i;
 	struct resource *res;
+	int i;
 
+	/*
+	 * Prior to inserting SOFT_RESERVED resources we want to check for an
+	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
+	 * that do intersect a potential CXL resource are set aside so they
+	 * can be trimmed to accommodate CXL resource intersections and added to
+	 * the iomem resource tree after the CXL drivers have completed their
+	 * device probe.
+	 */
 	res = e820_res;
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		if (!res->parent && res->end)
+	for (i = 0; i < e820_table->nr_entries; i++, res++) {
+		if (res->desc == IORES_DESC_SOFT_RESERVED) {
+			pr_err("CXL DEBUG Inserting Soft Reserve %llx - %llx\n",
+			       res->start, res->end);
+			insert_soft_reserve_resource(res);
+		} else if (!res->parent && res->end) {
 			insert_resource_expand_to_fit(&iomem_resource, res);
-		res++;
+		}
 	}
 
 	/*
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..c458a6313b31 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int insert_region_resource(struct resource *parent, struct resource *res)
+{
+	trim_soft_reserve_resources(res);
+	return insert_resource(parent, res);
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3272,7 +3278,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
-	rc = insert_resource(cxlrd->res, res);
+	rc = insert_region_resource(cxlrd->res, res);
 	if (rc) {
 		/*
 		 * Platform-firmware may not have split resources like "System
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d7d5d982ce69..83fe794e887a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -89,6 +89,22 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return -ENXIO;
 }
 
+static void cxl_sr_update(struct work_struct *w)
+{
+	pr_err("CXL DEBUG Updating soft reserves\n");
+	merge_soft_reserve_resources();
+}
+
+DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
+
+static void schedule_soft_reserve_update(void)
+{
+	int timeout = 5 * HZ;
+
+	pr_err("CXL DEBUG Adding/modifying delayed work timeout\n");
+	mod_delayed_work(system_wq, &cxl_sr_work, timeout);
+}
+
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_endpoint_dvsec_info info = { .port = port };
@@ -140,6 +156,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 */
 	device_for_each_child(&port->dev, root, discover_region);
 
+	schedule_soft_reserve_update();
 	return 0;
 }
 
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6e9fb667a1c5..0260e993ebbd 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -249,6 +249,9 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+extern void trim_soft_reserve_resources(const struct resource *res);
+extern void merge_soft_reserve_resources(void);
+extern int insert_soft_reserve_resource(struct resource *res);
 static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
diff --git a/kernel/resource.c b/kernel/resource.c
index a83040fde236..e7ed99cf4243 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 #include <asm/io.h>
 
+#include <linux/acpi.h>
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
@@ -48,6 +49,13 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
+struct resource srmem_resource = {
+	.name	= "Soft Reserved mem",
+	.start	= 0,
+	.end	= -1,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 static struct resource *next_resource(struct resource *p, bool skip_children)
@@ -1034,6 +1042,136 @@ int adjust_resource(struct resource *res, resource_size_t start,
 }
 EXPORT_SYMBOL(adjust_resource);
 
+static void trim_soft_reserve(struct resource *sr_res,
+			      const struct resource *res)
+{
+	struct resource *new_res;
+
+	pr_err("CXL DEBUG Trimming Soft Reserve %pr\n", res);
+
+	if (sr_res->start == res->start && sr_res->end == res->end) {
+		pr_err("CXL DEBUG Releasing resource %pr\n", res);
+		__release_resource(sr_res, false);
+		free_resource(sr_res);
+	} else if (sr_res->start == res->start) {
+		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n",
+		       sr_res, res->end + 1, sr_res->end - res->end);
+		WARN_ON(__adjust_resource(sr_res, res->end + 1,
+					  sr_res->end - res->end));
+	} else if (sr_res->end == res->end) {
+		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n",
+		       sr_res, sr_res->start, res->start - sr_res->start);
+		WARN_ON(__adjust_resource(sr_res, sr_res->start,
+					  res->start - sr_res->start));
+	} else {
+		/* Adjust existing to beginning resource */
+		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n",
+		       sr_res, sr_res->start, res->start);
+		__adjust_resource(sr_res, sr_res->start,
+				  res->start - sr_res->start);
+
+		/* Add new resource for end piece */
+		new_res = alloc_resource(GFP_KERNEL);
+		if (!new_res)
+			return;
+
+		*new_res = DEFINE_RES_NAMED(res->end + 1, sr_res->end - res->end,
+					    "Soft Reserved", sr_res->flags);
+		new_res->desc = IORES_DESC_SOFT_RESERVED;
+		pr_err("CXL DEBUG Adding resource %pr\n", new_res);
+		__insert_resource(&srmem_resource, new_res);
+	}
+}
+
+void trim_soft_reserve_resources(const struct resource *res)
+{
+	struct resource *sr_res;
+
+	write_lock(&resource_lock);
+	for (sr_res = srmem_resource.child; sr_res; sr_res = sr_res->sibling) {
+		if (resource_contains(sr_res, res)) {
+			trim_soft_reserve(sr_res, res);
+			break;
+		}
+	}
+	write_unlock(&resource_lock);
+}
+EXPORT_SYMBOL(trim_soft_reserve_resources);
+
+void merge_soft_reserve_resources(void)
+{
+	struct resource *sr_res, *next;
+
+	write_lock(&resource_lock);
+	for (sr_res = srmem_resource.child; sr_res; sr_res = next) {
+		next = sr_res->sibling;
+
+		pr_err("CXL DEBUG Merging Soft Reserve %pr\n", sr_res);
+		__release_resource(sr_res, false);
+		WARN_ON(__insert_resource(&iomem_resource, sr_res));
+	}
+	write_unlock(&resource_lock);
+}
+EXPORT_SYMBOL(merge_soft_reserve_resources);
+
+struct srmem_arg {
+	struct resource *res;
+	int overlaps;
+};
+
+static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
+			     void *arg, const unsigned long unused)
+{
+	struct acpi_cedt_cfmws *cfmws;
+	struct srmem_arg *args = arg;
+	struct resource cfmws_res;
+	struct resource *res;
+
+	res = args->res;
+
+	pr_err("CXL DEBUG Checking Soft Reserve for CFMWS overlap %pr\n", res);
+
+	cfmws = (struct acpi_cedt_cfmws *)hdr;
+	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
+				   cfmws->base_hpa + cfmws->window_size);
+	pr_err("CXL DEBUG Found CFMWS: %pr\n", &cfmws_res);
+
+	if (resource_overlaps(&cfmws_res, res)) {
+		pr_err("CXL DEBUG Found SOFT RESERVE intersection %llx - %llx : %llx - %llx\n",
+		       res->start, res->end, cfmws_res.start, cfmws_res.end);
+		args->overlaps += 1;
+		return 1;
+	}
+
+	return 0;
+}
+
+static bool resource_overlaps_cfmws(struct resource *res)
+{
+	struct srmem_arg arg = {
+		.res = res,
+		.overlaps = 0
+	};
+
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
+
+	if (arg.overlaps)
+		return true;
+
+	return false;
+}
+
+int insert_soft_reserve_resource(struct resource *res)
+{
+	if (resource_overlaps_cfmws(res)) {
+		pr_err("CXL DEBUG Reserving Soft Reserve %pr\n", res);
+		return insert_resource(&srmem_resource, res);
+	}
+
+	return insert_resource(&iomem_resource, res);
+}
+EXPORT_SYMBOL(insert_soft_reserve_resource);
+
 static void __init
 __reserve_region_with_split(struct resource *root, resource_size_t start,
 			    resource_size_t end, const char *name)
-- 
2.34.1

