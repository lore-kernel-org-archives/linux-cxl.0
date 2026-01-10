Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBD3148C6;
	Sat, 10 Jan 2026 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045666; cv=fail; b=FBGbz82MsM120lmrSQpACvINm1B7QcY0qNVfodjIicfxrM9bowmnmAHNej2c+S3sR3HHJ4HQVPaXKtwHmLffRBcYgWRle03uw4/7tCRTaCO4BQPmWlcC1l+bZZeZr2gbtdeCMzjmTqDgCLrc1h59H/pNq7HVjngFhvm01iB/LA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045666; c=relaxed/simple;
	bh=6ObiKiWV54yLWxlnSE/WT+jUYUumTlzJb52MLeHiuQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtTtQqJ4aBUsPyMOUxTr5rpfU7EdSvcW7Eh4QpAAz7VuSg4Ga50fdGBidX9ZRA77VNlUVh/dLDsC/xCocx/zKg/FG2zBiMGITiAhF6mvBqkpxdYiuL/QEzre2lVjQmUQF3M5Ovub+zdErkSjZOFFSA4PdFpWr6bsI9sRykcYK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BO1xzNi4; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BO1xzNi4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdpPsT40hPKpPemQ0ze5JbZlswE+nGctG3jl5aPTnzS3oWKGp6Xp/3UqJIxyxZQjcBNEI3O7GEKCUNx4XYT/Vc1D+/8ZuOqYotJWWGbPkQKkUkqK5R/oeIrummW2Ynn4PLfPNGugyvH6A7HGNmxkScZV8LPmPKlydqQfMnWbr9WTkdxB/c4RPq0nrOBFcs8pSR3Vxxyswb3pGVYOyKjEnl60jXOn1odC7SkOGF0R2dyI6lSjtf3j3wWAOsLfggFnpe4nVpF9FtEPoAkgb9nKA63t3I8z6rpOrzwHBGQo10jp7ReN/P7fVcqtLcsZbqdH0L7ylb9Oht0OZuERc8iGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0yelE2c/ZuL5P6VesS4uOJ9qegp1keNSh1VY5OZn1g=;
 b=Rh0g6cJ3Y+9IfJUOsC3+cJum6v8e0mf3iqDNeIcD8NqsNwr7qRqtKjlG5oFBmIUJ6A0xRU7464ojxGss/ZArFvt/VbP7UVQ0u8TbmI6PNJb/LTArHjGo3ArIn0g2lSXP/DSl0wkJi1muAAbGiOkfWTTvofGAwV5syUsVGphSlDmNT8v0qTFXAAdVkWm7HnOVcYE/f/qrCvXvtlqD5ot3pUfAvFxssAj1LfWlxuKcHM0+j5TRSfjdd/dtkVbEG4a/W7yw62ASx/bkYdy4zg8bxu3y1aL1zIYthByRfDrXLl81Q5T1gZ+mpyWKS+/+fev/9BDPxGvZQiB7eDva9RrTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0yelE2c/ZuL5P6VesS4uOJ9qegp1keNSh1VY5OZn1g=;
 b=BO1xzNi456xpfPJX38u9Fq6mUwgsCfokrG8AusIJGs3t0nhydnzElcIDAvAhAQI6xVUKleRNBcnqXjjn2SeYXCygFxIAjLjlGeS/cbRQmThvR/mNzYbJw7hWHDqWx4CBX7dfZY3zgt/udfs/l7ZBtiBxc+04DD3maDGG5LDcpXk=
Received: from PH7P221CA0054.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::34)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:47:41 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::f3) by PH7P221CA0054.outlook.office365.com
 (2603:10b6:510:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:40 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:35 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 04/13] cxl: Simplify cxl_root_ops allocation and handling
Date: Sat, 10 Jan 2026 12:46:49 +0100
Message-ID: <20260110114705.681676-5-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f342ae-f6d4-4b51-477f-08de503e0f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4QUffMkLsA+Ebp3bcr+mBuVCowdfs7zWQeT1FmUZf38sQ8q7toWXmmlN7z9s?=
 =?us-ascii?Q?E4MrUK9dB09jPZli6ZKSMKK9YVE1eNjzwRaoYr6GZCip2zOjYhKaKuSBNXyw?=
 =?us-ascii?Q?UGF/W/FyAPAGRHOL82N+hKsbP26c8oC2oFPYZyk5n4OHx6VwjLi5dzSD7Xhy?=
 =?us-ascii?Q?b32fJshwVQv5uMDkqPutLr/01EbRoJtGuwjFen8PV2IcnkAAik9cfU/C+6mt?=
 =?us-ascii?Q?gi7VloDF8v4KEC2H3vysTbeKQKPcjNdMc/Gp+JDwoTiOwesrfzYr9LCbdtMK?=
 =?us-ascii?Q?p50P0cA3SAPPhZ3D6a/iSHdbtmQkfeh1BTlq46wpkaRXM7HXlSjIJQHeL34S?=
 =?us-ascii?Q?+ChrheqGB41QeQZQclg6vJ+c6xA9PsD9mYlPI8Psz4257on+oQEPDTxUOOAq?=
 =?us-ascii?Q?Miy/3Axf5RTfVoFRdMH732kmp4XeZiWZU0LMCcbJ0HUIveYSzARBYZ6QC/Hw?=
 =?us-ascii?Q?mtVlstD6S1rk9ZB+WtF+wMEptHHXOFnDfSEMEKAud/IGRGq7cV9ypBHwm40Q?=
 =?us-ascii?Q?FbQT26cduqzN1OoC63DbQpCE+XQ3EtwWniLrigBhDqGtBcRNhGJGjvk3axiB?=
 =?us-ascii?Q?VaYK9xQuJpJWLF7MeWKlZ00y9jrer1s6pKWSzPMmraLvsndcoHWNdIJdFBJP?=
 =?us-ascii?Q?oUKZK+rj+Y00Om10TaBl0oqb41LSFbqYigvwsnRX1hLvd9Sh2PckfAnI0sdd?=
 =?us-ascii?Q?2+5d7Z+b83YfQU/EO9XKmDm+CMi1jBy+yxcqD1XoFbgXVkwtzgxbydtt8uEY?=
 =?us-ascii?Q?HBrKyqm+a+s/IaznpfXYWHFG6HRwtk52d8em4sT+MgFJ9850TQVJwUKGiIDc?=
 =?us-ascii?Q?3ktxY8Sm0bsEeGKAKMkrv6KsDaPq7nppw0mjHKp8F7kG8MV+JvDSTLne+rrv?=
 =?us-ascii?Q?Dh/DoJOKGOV6FjWbaTWwneD11RWxW+lRw94WtWzQ4hLGv+IqaHXpkJ8TDMiO?=
 =?us-ascii?Q?Cy9aNzfNFqvq14lUMs+Dod2d9vBBJlYsjqW8VhdmhlmvNN3PiKv6P0hv+VjN?=
 =?us-ascii?Q?qQHYN1QWoyflClMt2BwFEsnBJqdhJvkSghIX0ijR1xQtR7zzLuKziaP31fEZ?=
 =?us-ascii?Q?6gAyyfUPP8XU/tkHm08R9rfoGFptMZq9P4XboWduibOmc+HAbtz1zzRmyswG?=
 =?us-ascii?Q?MWUwXSUlzBN26d6u5NKzJKf/izk381AMKOODQvA1XEeEsluCmPXl6BA5jZ4D?=
 =?us-ascii?Q?VC4F5kBCgU6/ECVk3a7nFXlrTayDusAVzkhZlDV/wNJAijTo7zP0NL2S/7By?=
 =?us-ascii?Q?qh5P6UtV8iE6VH0bS3t9AvakOwI4Jfd6RV6yxKigwQ+i6s8qp3SYjLIjEbYA?=
 =?us-ascii?Q?tzhFkVJJSfrIDiYFca0TbidRCOJtFEaE37BrH3Uqah/EkpRrOXErFcTa/gaq?=
 =?us-ascii?Q?QjTov6H/hvYherSr27BpRKnOZN7eW+ZCcquNOIe5zW35vooYY+PfRi1JWQTE?=
 =?us-ascii?Q?GWfiUrzwZ24kpxqrWfUPZoll2qH2p+UAgJKYQDDW0v3X7f1rPIrIADT0m2ae?=
 =?us-ascii?Q?alHOOMK6lGgKtWiy9y1OnyhmtD3ff4Toc+JJsh+ojeV3fHFsFwjmBwKvWaR0?=
 =?us-ascii?Q?TAa/dMzXIr8ySZ28Dnk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:40.2475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f342ae-f6d4-4b51-477f-08de503e0f01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

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
index 77ac940e3013..b4bed40ef7c0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -318,10 +318,6 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
 }
 
-static const struct cxl_root_ops acpi_root_ops = {
-	.qos_class = cxl_acpi_qos_class,
-};
-
 static void del_cxl_resource(struct resource *res)
 {
 	if (!res)
@@ -923,9 +919,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 7120b5f2e31f..18f0f2a25113 100644
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
index 3a5ca1936ed1..0e15dc6e169f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -646,6 +646,14 @@ struct cxl_port {
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
@@ -654,7 +662,7 @@ struct cxl_port {
  */
 struct cxl_root {
 	struct cxl_port port;
-	const struct cxl_root_ops *ops;
+	struct cxl_root_ops ops;
 };
 
 static inline struct cxl_root *
@@ -663,12 +671,6 @@ to_cxl_root(const struct cxl_port *port)
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
@@ -782,8 +784,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
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

