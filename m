Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58302441A6;
	Wed, 14 Jan 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409375; cv=fail; b=u674IZ2VEUSXZarcZLztyUlVVcOxyW1XmlFDjjby1dixjyI0hNSNPu58M1kKCIa3KbFnodpvB0k6wt1qS2V2AdVKBMt1gNaf4z3hMUlAyT8zNMc8SSxauZyjL3KWfwE0Un8lUKvaKLhS2/gYDtrfr8MZRCl4wceJKyCXC3NjPK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409375; c=relaxed/simple;
	bh=mfZv6vJ3D2mucYXODwbmdwlBi9bDktACu8OdhQAIGVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llCYdeKqYtuzxuQY/OR0vkk4QlPdgXNWvfikb1C3z8eIUcLMLzOrfqsO2Stlg/muMILjqUTFaxB6b4319MQQU6+GCVjGzfFu9XDSjFgXpL4Jg2FdpSja8iHDAca6L7MFkl3eTjblATFY9Zo30NYi+kuPGVQBSHOpsssg+6OdjuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwSoHqci; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwSoHqci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AljDlz1hnYf3ijtu2qhw3vNtTV4F24rKPu+PtNrcdEnFeovoFFe4o4VqcFlHTlciopB8lK/W/kDnXWE/IMVX7IJHmsnUQ6SdUevoQfn5lzIuaR1n/czNrZoFjFOQTmUUkhOQ7aXY9K/8sEb+l2OG7ddTuZG/x3DUTtf80cmMMvV4NKej/dRdrtD4YpTWpNER7t6GEV2a4sbHqGLOMC24zSAx+6hvns1xGGjg0ATCnRIqun/XQcEbAFww+eKBlOhxLvROd/QOM/Scs23JRriy1cwerYTsY69HMactMtOF+egEgM8b5kEe12ZNtgMmp/qlO5hgDmNk5eKDfciks5zrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPBOs8/hvv9P/e2l3jqcyrSMf8SjzGONG2XAFTlMMyw=;
 b=L9cYkTegBQLvgqQmPeT2Gn8+uis2F2PD4SGJqiN8cyZpno0S2i58Otrb7KWJx3y7W/l2VhNF4xq3F6RfHRmOtRDp+26M8dmkowayOCcqID+rzWdg0fmVs4EY6Ea2EAUobmDvXzKrdu4AC0nd3bIrNXkvq4zmBTOTHh+LOppQ4HNNx8l9K1VSpXYKffm/hc7dMJdScbJM8XRHO0FR4nTRmxkfVmtB83/HffE11Qal+11T2ur+fPa11hQiiuTBPNXTasQaEcJPslC5IAClEZfJ181GeeKreul4MQBs5MEozJPNVtijaz+eMIAXQ6ZBHbfTOyiiaJy9RFirjcF90d5sDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPBOs8/hvv9P/e2l3jqcyrSMf8SjzGONG2XAFTlMMyw=;
 b=UwSoHqcieEClKUWOmxRoffH3mcdHvV6yMVtEH6+jTnoVPWhR1z8rfdHd8kblTe/E5NrM6znCbNGQq2yqbOgDilesfV83PlD03YEzvs3waDdQ2f+zg8t2htCDL6elTFjeeXvhl7Kc8d5Y2LjYoGP84fybJ7ksHYjEIFIi6hgC54g=
Received: from PH8P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::31)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:21 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::54) by PH8P221CA0003.outlook.office365.com
 (2603:10b6:510:2d8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:20 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 04/13] cxl: Simplify cxl_root_ops allocation and handling
Date: Wed, 14 Jan 2026 17:48:20 +0100
Message-ID: <20260114164837.1076338-5-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: e7313d44-951c-4dad-fd98-08de538cdd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r42KqwiOgxI8QHr247EanBhC8r8lmmnJYjOXDMbsWsV+0CBJlmMvwWpbkqIi?=
 =?us-ascii?Q?cRKOVWXDI3SicYM8AnBcSCDG5M5nUDbD/O3cY/15oFi5vL+GmPGUNpSuHVoE?=
 =?us-ascii?Q?rmTUFVBfk29Fq88ykGAog28c90+ipm2/hzy43NVjwB712D2sETYGRvRFca/U?=
 =?us-ascii?Q?0f9AYltVM3foyeZLlHopZ37KeyY4tezoua0p4Y+Fk9BnvStwXdw0Is7Gl3LW?=
 =?us-ascii?Q?oGK1ofcCrbygz620Z4DHsHAQ2Mbo2ND4jakJkLhS3RO4Dcb48nv0peFCL1xa?=
 =?us-ascii?Q?Vaj5E8pWBcVFFsvIbdxPvdALBgekMHYp5yxHLgr+i4zmOH/z9kB8yojix9+H?=
 =?us-ascii?Q?kh/kTuDW4vkRiXXKJ+N86Rqbx5dCSMOO+aPfxaoisT5FcPrrvfc13X2Ivrdc?=
 =?us-ascii?Q?HnTwoX6jvtdx0eq5foUmYereWsz7UO3Qr5vYb/ergMSbNiSsGc4M+1bO2WlM?=
 =?us-ascii?Q?YTCyJSELrG8QBP2Yy+jy4BG4ZHyEQjA991bqPAIdHml4lQCV91Q+QKW0QBHr?=
 =?us-ascii?Q?n4Vklf5yt/Cu7YbOyk1V9qlrZ0dyECH4/SvR6k8BbNuB63IU54DxFGoodaTQ?=
 =?us-ascii?Q?/AS2HCwOkg1sjCqZC3+5uHXooUBJthFCy4aj7ORT8EAMM61fDHz75II8nyfV?=
 =?us-ascii?Q?WnnP1u+Dl9Cxr11hmlBj7Xh+lIsL+JFgVcfiJEo5p9Bs2bl1Gtmp50U2sFl8?=
 =?us-ascii?Q?z1eDGrEghHiC0gmNXtl83Cpm+LuH//snsvHonRSXvXssWM+4pFnOpJbO+Nqw?=
 =?us-ascii?Q?AHQRt/usjenULdbP521MvfZvS+vSxqW3cet4no5jzcvF80GZlcaFdVT60JlT?=
 =?us-ascii?Q?zWXsjnO3+f2lvV1m5FWxkv5j72/n9PR7ojk30+PVMbXZN1XznZCCIpKQF+iW?=
 =?us-ascii?Q?x8hzgxfp8pSSmc2HlSomCnCn/fl++9EiMgeZSiVbbDqiMboPoMxByeYvrVoM?=
 =?us-ascii?Q?U3jAtS9Zuiwo1YbxCnvLDiwEqCw5Z1bwvaPUWxVYYWCsQf9UAn1G6gS6zEK/?=
 =?us-ascii?Q?337MWxOkpRfJVjih6U1SNkSVUIjiNSgPx3ZruFqCvKIgkAnHqNydk7HNCD2k?=
 =?us-ascii?Q?odJl0z5nDf6v9vw6k3pvhmeWg8oN8pywX0zu36ax2OYsb9mROMI9ZP0PhIKq?=
 =?us-ascii?Q?JAN+zDigpIzwu4oJTZTRgm3X1O7iDdWb87Kyvv9+9sNXP0pe/g+Xc8zVsVHw?=
 =?us-ascii?Q?yMcrmSl01vDONzxa9AkDdAQUNd+TsY4zRm9ofplm4m7TXr5d2dihZF1qf7b2?=
 =?us-ascii?Q?qtuAi9ljzayoDDKqXTgiPK00k+GARTniood28H4PZWoNeGGMCEo7YS6H+/hW?=
 =?us-ascii?Q?f6jPr2dV9QlyHDEFUiZMMaPbMZNzaIJAetLTFQ8l95HiQxd40TbnhYGrxfa8?=
 =?us-ascii?Q?8W9dI8iA++ObNBkkVmlD0/Zx0RjuLQflr5TdGoReBAByxolX+/isj1pHXsyl?=
 =?us-ascii?Q?7Pv4O/qYjnFwh07+BQH7xhY5HALfSZHZ8yENiNhqR2TKblCdxoY3R1NiHbii?=
 =?us-ascii?Q?Fbo7Y3d598rp3qIszG2m61qttIWGfJ4higtkZg5903XX1NFb/i/mjXBjN39u?=
 =?us-ascii?Q?cXcrDdO0SxNnW6mqgUW4ACpLN6tK9ZjfKzyEEZplwTn0vzMTWCEZvI+GzCAf?=
 =?us-ascii?Q?k6Fb0xmjYuv60AgfBqgKwikA39PGC2Y36nSaP/ZTAKPaLGmZC7LayHXFlQEZ?=
 =?us-ascii?Q?0JGQ3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:20.7993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7313d44-951c-4dad-fd98-08de538cdd6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

A root port's callback handlers are collected in struct cxl_root_ops.
The structure is dynamically allocated, though it contains only a
single pointer in it. This also requires to check two pointers to
check for the existance of a callback.

Simplify the allocation, release and handler check by embedding the
ops statically in struct cxl_root.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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

