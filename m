Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023324A7C6
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049367; cv=fail; b=nfucQFaUmStJZgfeDDeB2pvMBfoScbdjNzccZzG89wlcRS8kPQcW1QF45+8VC8t9h1lWwvR6KcPoNi6mq0W6yXYwKsOJa0TmlUfbFEiuDvkyveERDnUOuTZQ8keTCTI1xh1dNLIP2mpfrk04lT7CuB8W18CimHrzi5diTSi85F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049367; c=relaxed/simple;
	bh=3yfu1UG3dTDg0WOjWoOG3i7/zHYr8fq3qAnrXb8Wh8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCyyZ1LcFupMewXaJzoSfoaUouzVy/syI/Ar/2hgf7E5rXqhlnwvEYTVBJBWU2InDJsegH/IszUanNW8oPRRFvOunHE0DoaLiBOom3bMkpJfAL4R5eFQbJ+GOPchCnlJqz/KmkkfoCgDKleMEub5ncAxVh7f4b6fhblqUHvxK18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbLgNKu4; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbLgNKu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdLLlCkgS8sD719F68n1NpThzAy8B3RtO7DldUrtsc+QfBIMG9nO2AoIcAmdSFV85UbjsPKvm5Aa1HXEDh4YmK9O6vXjxpydxRVYiv4noF3V0MIF0oW06C8ORzJc1DdcqZZhdas0aIC/SwgBN419ouYvXNB7wNVpyegUnddE+RgGT99QHjBUUBBgvdfQGzQc7zXl247PHuah7ae6s++8IWAGPxAhg7Zc7n6mGhkIvd07c1T80pHT2/6yLiQ2KBW7osQ/01tsRdpt5tleANxV91A6xkghv36/+KKNfcohzkPhObJCHOsryalxQj1ynTPbogj4FBARgtxCu0xhfzpZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES3Oj0e/tNMqS405e+zMLmMRPFZCzhTcxi5HBSVEc8o=;
 b=WeyJa+BjpK42UN0nh/k58+cWmDpRYpcsoplWC37lQoGvaw33rRBdtMrUdllMycyT9/x4Wq5eKy+bsBnGiKxO6EcbAp+rKmdfdn2/ifX0u/erobsFgI3IMZJkC+OkMK1KuSgsC9t9fDIAGXc7VwV2cBW5BOHu+A2i44STaFtwUsgpTuP0hidznzzSIOe9dwjDhI4H5/Y4GkgNSkqvO1wRAfqn3cw+u1c6dxNAiU0MyPDVYiY5/+wIBA3/EGZNEMe1BlrIE5+kJEZtQ/Gs/+crkxH7rpT9BzyPzerp5sG7+aL9z0L5TZcX9lG27T9S656ajQ38CKw1EXUNvfC3S5jNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES3Oj0e/tNMqS405e+zMLmMRPFZCzhTcxi5HBSVEc8o=;
 b=gbLgNKu4dCCgLrXuhVBQB5aW9IG2suJvt85UhZD2u85GKuXCF9RHiy+430ajSg/VNU79SWsToSOpFSNEwuzjuLUmJLJm56Q2Gmu1zQEtMtNQY07MnPrMVrlrgthNETRr+Xyiils0Q7Elw5yjJAa0JAu3ijOemVvyChHiqKFqYIs=
Received: from BN8PR16CA0013.namprd16.prod.outlook.com (2603:10b6:408:4c::26)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 17:42:41 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:4c:cafe::42) by BN8PR16CA0013.outlook.office365.com
 (2603:10b6:408:4c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Thu,
 16 Jan 2025 17:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 17:42:41 +0000
Received: from AUSNAFONTEN1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 11:42:40 -0600
From: Nathan Fontenot <nathan.fontenot@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED resources
Date: Thu, 16 Jan 2025 11:42:05 -0600
Message-ID: <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737046620.git.nathan.fontenot@amd.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: ed52cced-8c3f-4421-b356-08dd36552d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvWTrq1veNnUkforj9xJ1dC/yo+9QW3PnuPk4Vxb49lyP6ClPuaoQk/ySQv1?=
 =?us-ascii?Q?2NtmWdjghqIvhiYXuFEZxmNjeNFWSJJlsSStBTV7X0T+IxLz0fYCULy7iF2r?=
 =?us-ascii?Q?/bR422heHCkjC1W9l0qPhU3hRzARuGJkFCqf9g1/4WaTf5SJuu+qpQvDlzGP?=
 =?us-ascii?Q?xFtjQLNFuDj1jTMmn1cyt9Sjq1eZsnJFmjCx7IxSuHroOX89bZQJ0h6vR/iS?=
 =?us-ascii?Q?flSGXn/xO0MuBTm5dYLN56bzmOFAeV/Nk1wdkW1XixDIcfXKly6cut75GqF5?=
 =?us-ascii?Q?EqtK3dehlpq1dEi5vII40msB7IV4PSwImyFZpQc9O2yStYF4hyJHDl2bpFie?=
 =?us-ascii?Q?UVOGyrEs2zSOpQhbJDiCiRaZwcKh7iy2SAUC//eFv1KY6eNHWA1nYMaIPaJZ?=
 =?us-ascii?Q?a/OAYP3NmVKNRgRCNMaJAMCtko4I6MkvP+BNnzm46Awwitqii0JFqe3pAWeJ?=
 =?us-ascii?Q?vS3BbBUdRwlkZHwkXIyrRLMJjgHX0sO3/1HtQBizWXbOKwf23Odm5/GLBhlj?=
 =?us-ascii?Q?Nr6tesVF6Aa/oKzNuq/3rtTjGJ3NnHg75cyEqVI4xZ5/XypkYkKUEo0Avl1w?=
 =?us-ascii?Q?xt4LQeyYxvvbgmfM27ZlpCYhUlWcgK2psutRnJVSyz+H2d9+Cq1sgvFexIYP?=
 =?us-ascii?Q?tA4xj93jQTeVom31iEbNIRaKAWvRbYPK9ovaQkM09c0kLp0R0U5oShjTLdoK?=
 =?us-ascii?Q?eBiGSaj6e+Lnft0eD1kZ/3JgQp00LYyJ6TGnpRlcAV4JFaLEfWfahSRfMEO7?=
 =?us-ascii?Q?L5ezPnWrYhn8gqPQVyecCDJKaWzd5cR3nQJLqrOz1aIbZAEPhcDoO0bomkDo?=
 =?us-ascii?Q?Dhlc/j94Sbhw2PcW1skwhznGmLk8f8pbNjLxQv60h/uLln0tXqsGS0uufad6?=
 =?us-ascii?Q?sTXNusWZdguHK5LLSzUoYFcod0H0d49jUweoStXRfSnmG7mvsR17K2AgDwzi?=
 =?us-ascii?Q?JrujUc2DdU2FgPhyszY1X0n10O8Dz0UhHGiuv/5F9hJFyPmS7UKCoTlwIhuN?=
 =?us-ascii?Q?nh9u+yQ81go7PfE8Icnh9CP0+P++MPKFkUOES3GrSDFNYADgbtvWpYr/Qbd0?=
 =?us-ascii?Q?4FIkgACh1TkmpRpyk2cJZYkBaL+ggUhJLPep3D/KV5iJuJJ0X09a/GQuBEsa?=
 =?us-ascii?Q?37OyFRKUin2ElCF0ekRn+7VOxTCtJPRtwgITml/xDcxIJ/Rcbk9aboNpx1hN?=
 =?us-ascii?Q?fKp7QF/TMq+0hpnBPsp7fKseg+2zQhiCM3zQFtqypiG3hU97QV04RiKaoHSZ?=
 =?us-ascii?Q?6YTjtmQh2GjS9EP8bp6uXMs7xX7hJ/BNF6e61N7S7+U6EmhA3NISN0vNsWLu?=
 =?us-ascii?Q?HvIV8YRW3Yp1aqWkav0GWFt6Gcb9iznxr1P8NVcZpweFJ6+/RZVJMV8ILXmB?=
 =?us-ascii?Q?jhho5BdG9WgeJXFEjZjyDJESoBLsTc3EQ2LT5x4HucbHNlpB8hZF3cwTxjCP?=
 =?us-ascii?Q?jjDRmB4dV26uOO/GLAZhAUscIoM9VfXHDpP72ZYZu0Rb5McBGhoULjlNQ8Ep?=
 =?us-ascii?Q?QaYO+xsBZbLfUOs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:42:41.0837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed52cced-8c3f-4421-b356-08dd36552d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247

Introduce the ability to manage SOFT RESERVED kernel resources prior to
these resources being  placed in the iomem resource tree. This provides
the ability for drivers to update SOFT RESERVED resources that intersect
with their memory resources.

During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
on the soft reserve resource tree. Once boot completes all resources
are placed on the iomem resource tree. This behavior is gated by a new
kernel option CONFIG_SOFT_RESERVED_MANAGED.

As part of this update two new interfaces are added for management of
the SOFT RESERVED resources. The release_srmem_region_adjustable()
routine allows for removing pieces of SOFT RESERVED resources. The
the merge_srmem_resources() allows drivers to merge any remaining SOFT
RESERVED resources into the iomem resource tree once updatea are complete.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
---
 include/linux/ioport.h |  9 +++++
 kernel/resource.c      | 79 +++++++++++++++++++++++++++++++++++++++---
 lib/Kconfig            |  4 +++
 3 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6e9fb667a1c5..2c95cf0be45e 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -249,6 +249,15 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+
+#ifdef CONFIG_SOFT_RESERVED_MANAGED
+void merge_srmem_resources(void);
+extern void release_srmem_region_adjustable(resource_size_t start,
+					    resource_size_t size);
+#else
+static inline void merge_srmem_resources(void) { }
+#endif
+
 static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
diff --git a/kernel/resource.c b/kernel/resource.c
index a83040fde236..9db420078a3f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,6 +48,14 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
+static struct resource srmem_resource = {
+	.name	= "Soft Reserved mem",
+	.start	= 0,
+	.end	= -1,
+	.flags	= IORESOURCE_MEM,
+	.desc	= IORES_DESC_SOFT_RESERVED,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 static struct resource *next_resource(struct resource *p, bool skip_children)
@@ -818,6 +826,19 @@ static struct resource * __insert_resource(struct resource *parent, struct resou
 {
 	struct resource *first, *next;
 
+	if (IS_ENABLED(CONFIG_SOFT_RESERVED_MANAGED)) {
+		/*
+		 * During boot SOFT RESERVED resources are placed on the srmem
+		 * resource tree. These resources may be updated later in boot,
+		 * for example see the CXL driver, prior to being merged into
+		 * the iomem resource tree.
+		 */
+		if (system_state < SYSTEM_RUNNING &&
+		    parent == &iomem_resource &&
+		    new->desc == IORES_DESC_SOFT_RESERVED)
+			parent = &srmem_resource;
+	}
+
 	for (;; parent = first) {
 		first = __request_resource(parent, new);
 		if (!first)
@@ -1336,11 +1357,12 @@ void __release_region(struct resource *parent, resource_size_t start,
 }
 EXPORT_SYMBOL(__release_region);
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 /**
- * release_mem_region_adjustable - release a previously reserved memory region
+ * release_region_adjustable - release a previously reserved memory region
+ * @parent: resource tree to release resource from
  * @start: resource start address
  * @size: resource region size
+ * @busy_check: check for IORESOURCE_BUSY
  *
  * This interface is intended for memory hot-delete.  The requested region
  * is released from a currently busy memory resource.  The requested region
@@ -1356,9 +1378,11 @@ EXPORT_SYMBOL(__release_region);
  *   assumes that all children remain in the lower address entry for
  *   simplicity.  Enhance this logic when necessary.
  */
-void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
+static void release_region_adjustable(struct resource *parent,
+				      resource_size_t start,
+				      resource_size_t size,
+				      bool busy_check)
 {
-	struct resource *parent = &iomem_resource;
 	struct resource *new_res = NULL;
 	bool alloc_nofail = false;
 	struct resource **p;
@@ -1395,7 +1419,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 		if (!(res->flags & IORESOURCE_MEM))
 			break;
 
-		if (!(res->flags & IORESOURCE_BUSY)) {
+		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
 			p = &res->child;
 			continue;
 		}
@@ -1445,6 +1469,51 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 	write_unlock(&resource_lock);
 	free_resource(new_res);
 }
+
+#ifdef CONFIG_SOFT_RESERVED_MANAGED
+/**
+ * merge_srmem_resources - merge srmem resources into the iomem resource tree
+ *
+ * This is intended to allow kernel drivers that manage the SOFT RESERVED
+ * resources to merge any remaining resources into the iomem resource tree
+ * once any updates have been made.
+ */
+void merge_srmem_resources(void)
+{
+	struct resource *res, *next;
+	int rc;
+
+	for (res = srmem_resource.child; res; res = next) {
+		next = next_resource(res, true);
+
+		write_lock(&resource_lock);
+
+		if (WARN_ON(__release_resource(res, true))) {
+			write_unlock(&resource_lock);
+			continue;
+		}
+
+		if (WARN_ON(__insert_resource(&iomem_resource, res)))
+			__insert_resource(&srmem_resource, res);
+
+		write_unlock(&resource_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(merge_srmem_resources);
+
+void release_srmem_region_adjustable(resource_size_t start,
+				     resource_size_t size)
+{
+	release_region_adjustable(&srmem_resource, start, size, false);
+}
+EXPORT_SYMBOL(release_srmem_region_adjustable);
+#endif
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
+{
+	release_region_adjustable(&iomem_resource, start, size, true);
+}
 #endif	/* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..4f4011334051 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -777,3 +777,7 @@ config POLYNOMIAL
 
 config FIRMWARE_TABLE
 	bool
+
+config SOFT_RESERVED_MANAGED
+	bool
+	default n
-- 
2.43.0

