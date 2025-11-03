Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647531D74E;
	Mon,  3 Nov 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195753; cv=fail; b=S/vvN+juR4aAvZq1QfEyOyitrywgic+v5VC/ZULkmKLKTECCSR7JbTyvUeowSU0xC4wqsaZiyDtSjzQu2XZSJUwnDCFI1gthjbkrA6oPQ0sveNtFc/qCgSjo5Vh/s0NEgQ4WQir+F2FEBCaPhd7wHxpUDeMdpLAMNgo2zHeiTkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195753; c=relaxed/simple;
	bh=XKRWIH3wXRpqevVReJO9j3XZ9CBjkM43+Gdxf/hOc78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgVZ6vgJTSWg/dLdXnXaDKdwnAStDCXXtzk85E3t1+hbvU5w+YRucS3h5/vcgMxBxjZHbxIdkHF9YgsMDcyX4anQrj3ka7id0SqUwyjUuaazfIvYBABI2aNz9ZxaFm8RUA8jWG7/oJFN9KPVjGcNC3JY0Naq7UviRRzyyxVwDTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sTuncWxk; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sTuncWxk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZVE+OamswIfE+havId3gY2SIgle3Jku2j+f3ha8oHtCC3luOURIrELOZgeivNaxUYqqeJ2LaZ1nRyOHwOZ2jwcUU0B/mtt0E7EEeKHcPsqSsPmU3/f1a8d/gIbChEIjFDZDI43jNzsDOgSdWRbLYDirovqw8OKoSFGu8D8Tgvo/K7WaPpcWKQ9ZqBvt8dlRtaXXPmTH8NcaL0RQ3Gg0PeYtrvCCDcRKmHpTZsRvxfWaUusMIqrwtgPO5O6zTollV2xVZM1VafNZqLG7DjxaWbcCLfdFBZW/W3NwC0CFgBxh+ekyJlJDjEIf6H+WdN3wgnq8+9FHkAGfSOsrJeSq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFIoqAluA3gESAv/e1znczLTMcfycsRLRU2JoYoE9c8=;
 b=ydR8r24bacAhhh3BmShGy4ttpNC79gU6DkisSUvEsubp3TvFsBb4a7gX0nn07SmozkuJsUVtiVYkgjpWRqqsGLjq1PYA50lR5/Rmy2wRm+8DxN/bE5bYxNoC9bpU8+guOs/M+X8cwxuj6CT4gjFungWHSDU2slbCuJBiDBWJQOhS4Bh2YxSUMPCSG223eZ0sHmppVbXHBWw8dzXZh/z+0gYgeLXSPUBCPYnK/ajWMVpEwuly+NEWWrIa3GrevFBCrlfGpwfhl4p8vY6V+fxRzHykyCSvst/qO6NR2BmyyZTLwva+CN2n9qPgZ2EoECGt3NSuU71tLuLzxMy2A4hZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFIoqAluA3gESAv/e1znczLTMcfycsRLRU2JoYoE9c8=;
 b=sTuncWxkwTjDYzmEotdspFaGbZY2ZWYNVrD4Gly8HzJRAoZ3gyf48fTyV1qIVG20zC9diFjdGKpyCkJti+PeRY9MTbmwbf2G6RbLKQUrd3X/iZ7OvkzBO3dcrBDKp4HplKwLTbC5PvbRjhxaenQlg9kA/wU00qrfABc8mf5cML0=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 18:49:06 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::62) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Mon,
 3 Nov 2025 18:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:06 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:48:58 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 05/14] cxl: Simplify cxl_root_ops allocation and handling
Date: Mon, 3 Nov 2025 19:47:46 +0100
Message-ID: <20251103184804.509762-6-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bb3c2a-5a9c-4048-2a50-08de1b09aade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IbS3hqN48y/8R00W+dShjSyJuFMgvhfMdGf1alvaH2/u8uRNPo43Yb2fLI2a?=
 =?us-ascii?Q?ozZoL3pr8noKjvm/vo1FireA+YOLT4mwtsdR5q25sYNlnq2xCpfxp88JxXZh?=
 =?us-ascii?Q?zxM4sSkUEQOgaz/tD+Vb+mOwTonlUO209BZGoJ2w433Q98A3uPP7IKCjSAIm?=
 =?us-ascii?Q?2/sd9UN1FJiQHo6KXLh9vHVyrZHWSz5Vc2LblLWi8UXbC3wqceMvFtPG81x2?=
 =?us-ascii?Q?oxewbh/gAw6+8V7PhxjJRSYytFexZKqC3gFPRyPAqQaUCYh7VOo6mXDXsj/X?=
 =?us-ascii?Q?eDUAw17eu2usL89beedVFrrhp4fOYlh3Ur3/2i2VVcLDl8Q5QDGwNc8ArvWZ?=
 =?us-ascii?Q?sayLbHd2piUOs8BZncLIEMlNaNObLLHEoBv1oHY4THVHgsJAl+uhdt5pKWAM?=
 =?us-ascii?Q?AyzzfoPQ64x69qQyttE6aBWCRZ0MG5Rh2ujBrI/cGgBrGOXHHdj/OBREH8Rx?=
 =?us-ascii?Q?n1lK3rrKuSi9MmTTJwZJu8IlykQ7X237KlhcHHfqDnzOTnj0f9mcJX2EAteO?=
 =?us-ascii?Q?BNjKG4w3d8FkREnLhjJQel8ghthjX5ynurUIoTOGq1ZdUTr5XDyvopGG6IO9?=
 =?us-ascii?Q?Ua7pVXnKiwFLtI99S3iNIPUcfzHhWW1Crx+ZDZ/em0IjFDNgr4oLSo1YlEl4?=
 =?us-ascii?Q?jNulHNB9ytr5oBCD4QeEQBJgyaYsJ/u7U71gqDXl0lY/BEiwWVMIuIjV6W2v?=
 =?us-ascii?Q?9eV4Wr1FNnehmMUwVNlE1OcvZKJenqEJpKGDCW56R5BT8vhlAzO74EAwP+oF?=
 =?us-ascii?Q?3RJnNJBVvu6B6Cp1H+069qLhocDkxFyBpSo1QZNWnRm1pEL0A6+OvUoMrkjn?=
 =?us-ascii?Q?KCEkLDIT39Zvli1TB0FbgqpEwet4Pn1MKa1Tuiuf8h6k1wr1JzDsFYoIEUMZ?=
 =?us-ascii?Q?aqop0+eGhaes6jle90edvlHpJ3ErvJJ1iKkYVOazFXu1uCXHPIUatRHL0YeS?=
 =?us-ascii?Q?zeQA7jf3WhjVCKJxtLZ6fn03YWtCbTE4GdseznjVluqNXNjM+m0EcytU9aiF?=
 =?us-ascii?Q?eVuEtNFnAdNn099G+9M3v8KlHu9yFCnLwjdBC3tHw83GFYJ+8WWAwDYLpYgy?=
 =?us-ascii?Q?2U2dArVv/a3vThM1Yi035lh3dwsLKmVLP4fI1NBHnGb1SpwPiZJaZIRhskPh?=
 =?us-ascii?Q?vwvCy3sSRhYpiQe5Sutp0GpomyAqSWbNqI6R2NlB3bqpNaKbhxrtjolWqWqq?=
 =?us-ascii?Q?O8D6zPwWrj5Nk34pGYRHpBTf+y0nY7QXqaH2KEEhGOMVtUXz22RctityIGRq?=
 =?us-ascii?Q?WbWWQbixlpbxul2tCuUaLzSli+PAteA/zAcKz9mi9cTuAGApI7cuPvxfshDs?=
 =?us-ascii?Q?4WuIJyD9CtYbd10Pqwav2n2nL7c1U/ZHtxGTTqnFnE8WolXRYoZ1UPJ7hEgG?=
 =?us-ascii?Q?X8aTo+0UCn064C/7NnGdj86elY0dHtD7TcWQW/VXQAVN/5xNLL7PuU3KO685?=
 =?us-ascii?Q?uX2bGn+2rzl7d9VFeEtMZsknJtSdS1YNIrFPCP8DMyO223McQpb6XO4FgL09?=
 =?us-ascii?Q?/DuN5qzoY6wTqzIUvC6q/cfwIUJck/7H9CTZtqoZuMchF27mf2ocSvOIcfve?=
 =?us-ascii?Q?trVUGlYhEC5i9oEsoPI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:06.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bb3c2a-5a9c-4048-2a50-08de1b09aade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796

A root port's callback handlers are collected in struct cxl_root_ops.
The structure is dynamically allocated, though it contains only a
single pointer in it. This also requires to check two pointers to
check for the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statical in struct cxl_root.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c      |  7 ++-----
 drivers/cxl/core/cdat.c |  8 ++++----
 drivers/cxl/core/port.c |  9 ++-------
 drivers/cxl/cxl.h       | 19 ++++++++++---------
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index bd2e282ca93a..1ab780edf141 100644
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
@@ -914,9 +910,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 8128fd2b5b31..2338d146577c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -459,7 +459,6 @@ static void cxl_root_decoder_release(struct device *dev)
 	if (atomic_read(&cxlrd->region_id) >= 0)
 		memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
-	kfree(cxlrd->ops);
 	kfree(cxlrd);
 }
 
@@ -955,19 +954,15 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
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
index b57cfa4273b9..9a381c827416 100644
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

