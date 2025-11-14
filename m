Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2122B8CB;
	Fri, 14 Nov 2025 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080888; cv=fail; b=ULhV4BZ+hixreAK7g128xpECFjcYyqP+t4SfuDgoygaBKS92kx3uy3AGGS0Z1FYM6YAqKiGCOwU6E+yXc66uJ88mUcA7KpVPt1QWXOJerOpIV3ODFsSR0Ucdbt2TFW/HwnBB2WVqUUp6sPhIXl3MxphFy35WPsaA9/PUoGU1E8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080888; c=relaxed/simple;
	bh=Ruw6cex6Mkl3tOYxwXtIS9uSljMfdsGuorzsuHZfGmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2WvqajHNezjGwxUi1mA4GkLwdlirIlx8EdgmIoJW9KEoIMUpnDcU8SgzaJS4d2HHI3j1FRKVGKCJnMGRdSwyqwaKxchxclh3Fo+aeKNydYpBz45ChOdismPibsbvgOw2ez8kVixtfsgB3Gkakz3vcTe+VVxFhJeiDOpb0cr7tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3OAmDN57; arc=fail smtp.client-ip=52.101.46.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3OAmDN57"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4IqTJjS2/RqPr57wC7LrJxFB2VNFeuAUbyeEG8YQdFsYkpLpvOo/Qu4lETuIKunI2iqnfL3I7qFHT+65lm+2okGl87VEoobkDmhcjuwp1z8hVxlkB41ThdoylzyIrXVmpdAu9TRz2FqDQ7SpFY4gXiaKPHaEl2Jk+uQ/Urr1K+9pPRy641B340Ma9QNH4yzrEItjwz/voyLQTE1u80T1HUXm/wvbxbMfD7q5iTEGP0vMqiPlc2st3HL4qqJaBXAYGn5P8+AOoQR/oBWH90z6gzFdzq86sb2+CS7TO9KTlGHfgg2Dir9XgRsO2AF+LsNZmSidL5kfzUxolFjwpCKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI1Hlz+H7En0RaN1e5KhWTcYb8eOSnWXpCGMI4CjbDI=;
 b=BOW5h4Cj9NCiPRCT7v/SGqgeg4akxTaP30TUc6LXc/tlgWiuVe8GOZgofPfj1qrEFHXgEpbQthDmOO8bvoCOjTorIIBsbTcEKhdxpnjfxO7fV7WSY4PyhTIV0KtrOAM59lA95d0Kzko2FehtgxeBkj3ima0CZ4W8KcwP44UZVIHfEg+gQFyORENQvtP0k7p+EVsZzR+ibWCo7B5dTMQe/a7vHJjtqcZvPwruL/iNspq10OnTyfb5mAWMbxG2kUx073iItBQhB2/puGc84e5QEwkX1kOKE+yhICDeIBQ8IkzOOee5AHUWvGyNS5QBsyjazJj4GKJQzFeHOSrH5IKgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI1Hlz+H7En0RaN1e5KhWTcYb8eOSnWXpCGMI4CjbDI=;
 b=3OAmDN57PQ72POFv1hBhrlAxVtgbPe61a7ifNJcyauuHl7VHVSqfa1Rfwp6nWaM5q3VS2i0nrshEjk+9tNkqUDIsUHirPEVoEjvM+QGbsb+ahb17P7gpE261JEI36qy80FLsW0VdYE/JjDiRDTwwybGKVnS/ZxAxgYdKIc01/2k=
Received: from SJ0PR03CA0266.namprd03.prod.outlook.com (2603:10b6:a03:3a0::31)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 14 Nov
 2025 00:41:18 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::d8) by SJ0PR03CA0266.outlook.office365.com
 (2603:10b6:a03:3a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:18 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:04 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 04/11] cxl: Simplify cxl_root_ops allocation and handling
Date: Fri, 14 Nov 2025 01:40:09 +0100
Message-ID: <20251114004021.1310661-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0a4bb5-3a1d-4a2e-7202-08de2316864f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OvaZqWZzjf9ogXwXgKxq9lXhVZn3VEm4EQX7ZBcPRE9AbAS14ihnJ8dqgs5I?=
 =?us-ascii?Q?mScbHcL24KFPC5PuBNJFhuFMeohdEYJ4jcOd2gsDjrSmd7UmaIkkKIoWSVYA?=
 =?us-ascii?Q?s2qy0U7f34XvD4EWpgzF/gsJour9RT9UWjTJ78QntlkPbpWQQbaKwiT7eQFd?=
 =?us-ascii?Q?ffEVpGoTgus36kr3p33rExsWNE/PCr0vWZWPIbauJ5aYXrefgmKKqyuOnSBV?=
 =?us-ascii?Q?v2aekRNOcVJYTNiNrCoZV/R6Vhw2hTIetNtvtzXiG44u9mQpyfzdFjyxOsE8?=
 =?us-ascii?Q?z/pXyeHc7h3ASqDlugEj4upoTxUrAmN6IjSiocWkIUGOw53El0tAKors3Wyz?=
 =?us-ascii?Q?S/o8+4nUhyqiV5ZxYlGMA0mPQi/VFI/mTYovuoxOdIcH9T6i0vOHoMacF+IM?=
 =?us-ascii?Q?uiHG32/wLWFW1RyHOeegSbgg4j0+geMLzh/gYGRuhJj0WlB808T6SOKA6xhz?=
 =?us-ascii?Q?NNgxNDG63mmprbwHIV90owtqqKS32bM+gYaJJ3LviH3/wnxuKeCc3uJ652ZG?=
 =?us-ascii?Q?HRKhB+Z5mOy/uQ+ujAtktc9ENVaC6nt3lPu2wdQhrKNmJI4U2hbhHoF4/DDL?=
 =?us-ascii?Q?8nE6bYCK0ES7nDZlHGNpeoEiaSmuDZ0Ibh18vzC/wv2PFucq6RdfNM157Ie2?=
 =?us-ascii?Q?kc8dMr0sM+Y67KGM5A9IGzs8JgInbsR2TIF6x2TsJkEj1bHe3YR/XLmDFWvP?=
 =?us-ascii?Q?RmQ1k3ogM41D7qayRPeOSU92lxVDUEYbbgZXRdXTOc5XSmACcW2mRdeHNwPm?=
 =?us-ascii?Q?v6dWps1WdHiLtuVSaw1WaOTBiC7NJwuokCqs+OpCeX3u0b1q4jqyYhgy7rT5?=
 =?us-ascii?Q?RI9TooQS0U/3Teda5YKbWHq+SJy2mW6jsfkbsazVfKq2PH0xY6pT+KuCBfYi?=
 =?us-ascii?Q?c7Eh4DG8JN9Sd10M/5BU9pB+z4YSdbo3/qT0qnmnNcD+phDs2BN6Lk9r9lF0?=
 =?us-ascii?Q?KPbBzBNPH6RasRO8nXYzIFbfgv1uYQiC5LNjMwcFots2F3BOCWSZdYOWlk/J?=
 =?us-ascii?Q?mwRPEmS3wtl2Ewf/YwY2Psrs2w0agI+4LEfqBIKpEAYLeD0ohU8uZeAH7YcQ?=
 =?us-ascii?Q?mTZcC4SJvvWS8cYMnjevzA+7W8Pw2aW/y8wLKKqDAwfIIJGgKEGq1RGUdAP4?=
 =?us-ascii?Q?BZYdg+Zf1V/A1umHEjfQ6vW3OE3QcSCQIE5KnpVRrk6wYxyxDHU+5M4g8cdF?=
 =?us-ascii?Q?949aKRQz/zeosDG55fjyIwOhRj9ev/s+FKiYLJkjcFHoRFptEwfGgmVe5QMo?=
 =?us-ascii?Q?7trz6QzhKIUzPOvtuKxgauhf5AlJMCIYIcRNKifZRj6Dex2rmOaPRVaXVmLd?=
 =?us-ascii?Q?UA6wSY6KEsB7e8viUvm9WKY8qWYz5pP4kybnNyp1i/y/jh3EGAGUwcG+vyPW?=
 =?us-ascii?Q?/sD+9XxtI5V7JpOtCnGZXs8pTJXTe2B/c3kG7E+ZYsxvRD5wqeKzi6RytFlp?=
 =?us-ascii?Q?R8CtJzGaOGaG2mwNVWCeSw6pvv6JX6bowqwWYidR1JPgPo/qKqkftF6Ap76B?=
 =?us-ascii?Q?XBfCgEK8bRSduDkeRfQkQe5+aDx5v7R93HtnNxBFGguE7OFDpjDb6A5C1bUC?=
 =?us-ascii?Q?lZEXT7r+N01fBweasPM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:18.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0a4bb5-3a1d-4a2e-7202-08de2316864f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721

A root port's callback handlers are collected in struct cxl_root_ops.
The structure is dynamically allocated, though it contains only a
single pointer in it. This also requires to check two pointers to
check for the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statically in struct cxl_root.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c      |  7 ++-----
 drivers/cxl/core/cdat.c |  8 ++++----
 drivers/cxl/core/port.c |  8 ++------
 drivers/cxl/cxl.h       | 19 ++++++++++---------
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0a1bad3cafa7..866813e1b729 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -299,10 +299,6 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
 }
 
-static const struct cxl_root_ops acpi_root_ops = {
-	.qos_class = cxl_acpi_qos_class,
-};
-
 static void del_cxl_resource(struct resource *res)
 {
 	if (!res)
@@ -907,9 +903,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	cxl_res->end = -1;
 	cxl_res->flags = IORESOURCE_MEM;
 
-	cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
+	cxl_root = devm_cxl_add_root(host);
 	if (IS_ERR(cxl_root))
 		return PTR_ERR(cxl_root);
+	cxl_root->ops.qos_class = cxl_acpi_qos_class;
 	root_port = &cxl_root->port;
 
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c4bd6e8a0cf0..b84a9b52942c 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -213,7 +213,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	if (!cxl_root)
 		return -ENODEV;
 
-	if (!cxl_root->ops || !cxl_root->ops->qos_class)
+	if (!cxl_root->ops.qos_class)
 		return -EOPNOTSUPP;
 
 	xa_for_each(dsmas_xa, index, dent) {
@@ -221,9 +221,9 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 
 		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(cxl_root,
-					      &dent->coord[ACCESS_COORDINATE_CPU],
-					      1, &qos_class);
+		rc = cxl_root->ops.qos_class(cxl_root,
+					     &dent->coord[ACCESS_COORDINATE_CPU],
+					     1, &qos_class);
 		if (rc != 1)
 			continue;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..2338d146577c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -954,19 +954,15 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, "CXL");
 
-struct cxl_root *devm_cxl_add_root(struct device *host,
-				   const struct cxl_root_ops *ops)
+struct cxl_root *devm_cxl_add_root(struct device *host)
 {
-	struct cxl_root *cxl_root;
 	struct cxl_port *port;
 
 	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(port))
 		return ERR_CAST(port);
 
-	cxl_root = to_cxl_root(port);
-	cxl_root->ops = ops;
-	return cxl_root;
+	return to_cxl_root(port);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_root, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4633004fb770..8945dc1532a7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -638,6 +638,14 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 };
 
+struct cxl_root;
+
+struct cxl_root_ops {
+	int (*qos_class)(struct cxl_root *cxl_root,
+			 struct access_coordinate *coord, int entries,
+			 int *qos_class);
+};
+
 /**
  * struct cxl_root - logical collection of root cxl_port items
  *
@@ -646,7 +654,7 @@ struct cxl_port {
  */
 struct cxl_root {
 	struct cxl_port port;
-	const struct cxl_root_ops *ops;
+	struct cxl_root_ops ops;
 };
 
 static inline struct cxl_root *
@@ -655,12 +663,6 @@ to_cxl_root(const struct cxl_port *port)
 	return container_of(port, struct cxl_root, port);
 }
 
-struct cxl_root_ops {
-	int (*qos_class)(struct cxl_root *cxl_root,
-			 struct access_coordinate *coord, int entries,
-			 int *qos_class);
-};
-
 static inline struct cxl_dport *
 cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 {
@@ -755,8 +757,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
-struct cxl_root *devm_cxl_add_root(struct device *host,
-				   const struct cxl_root_ops *ops);
+struct cxl_root *devm_cxl_add_root(struct device *host);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
-- 
2.47.3

