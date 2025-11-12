Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EF2D8391;
	Wed, 12 Nov 2025 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979536; cv=fail; b=PEPkVV3izjoigdZapIMYaOlwA00DWlibcAko2pEwZQWW5ucM6QEqIvRjQcNvqYk8GUJtBOd6MHGmzSbMKo9bu4SMKyPRWmaeVtA1HB1z8K1ft+xxdDK8TQCO7P3/f7BNBJHScJ8jS2r0zzpnbQj9ooIH2bNnK0C39e+Q6kfQvrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979536; c=relaxed/simple;
	bh=czDSjMlLd4+AqHzIxwFKEmZ46buv7fxnLLcmHG2W5Lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnUumOde4F4/1EZsi6G/u5N4KAhNRZfMRrMcf3ux2QEybWkj0Q09TAcZZVVT8kbDJnn2ImdYyqgdyVtYFVQ4Q3CNftyz3vv8JPPaZ33VjsVlUDEgF9wowCvrXjHxozD3iutsl32W+YV6Nx5hIKlSk1yjb4efagilpd+wbQ0b5H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=biFRi4n7; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="biFRi4n7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5OfZSTbgcDkV8K2lvQ6/IpdYch77PdlI95jo4mtvgAQnw6zpXzOnsPgbvAknKAJVdS3K8XtvL44nfnXGOsChV/FrJL8kXyJRY14WWrD5U7YJYIMt5cwlZcVRXV06NIpKQnmNAm/dDQCoNawFvAmIcmSsQ0mTrvdY39vkS7Bs4GzuQZ32ku2mIT7IDTZaI4pdh8lQ/KSIL8WRhSC/cLByMBDGh8RPgXpJj8qK5nolOZmjOtwkL1eGF6E+VFHDYRLkjScxWh5jHt95963+JGaNjLKRf/qt6SYgVi5KQdUwVEInXR+OV3fswtm5z6xR8wOvPsSSbFcECVZLL+XMtu0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PWb9PJsViNf5X+6qcTPhU1QEuVwK9Yn/CTVaz0jEuM=;
 b=IP1mhKnKflkEtlInjMkEeQjNcqeCkZpAG3ATW0p+xIm7v9QRlQExKmaGCnGzrwzan9h6qiruMzXONhpFH4ozXl3Wr2pHV1r8p7tG1yrIv0RMaTusbXbo1STwOVuG5CrRFWKqNd7Xq1iHQUZh4qGrGAPaf+r+OdxtdXz7fcrjNRQ5FFL16u2Gw7EhPESf74SIMPJd6BaQWoTTh+x1MH1MVXcrxdPYbIPSQGkcnSDFt1ueGgn9XXnIDb4LRY8icXYh8VTXcheouB83gg0JvYPI0pPZbsORw/UO/aAYha5ToFbCS+yjh+rxAwAeilvnGJZ1HV0tK88JaWZqV43kSLP4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PWb9PJsViNf5X+6qcTPhU1QEuVwK9Yn/CTVaz0jEuM=;
 b=biFRi4n7mMwvKokHP+Abfw1luvwcVAJxy0BUI3kH3UAeQGyUZl98VKXQQebObiObxFODZ0ikseWGlPRNDJe58xDT0uPcgW8yVOykHpkjjydrHOxLghzV5ExY+/csVdK66xUJOvtcPLN5icNxYxy/pR399hu07saooo8hSDlB3hQ=
Received: from DM6PR21CA0024.namprd21.prod.outlook.com (2603:10b6:5:174::34)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 20:32:10 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::2c) by DM6PR21CA0024.outlook.office365.com
 (2603:10b6:5:174::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Wed,
 12 Nov 2025 20:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:10 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:07 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 04/11] cxl: Simplify cxl_root_ops allocation and handling
Date: Wed, 12 Nov 2025 21:31:31 +0100
Message-ID: <20251112203143.1269944-5-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed32738-7ba0-43bb-94d2-08de222a8e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v4vgxEhsfZI0dLZQaxeLiO1SyVYM7Go810tHZgUA7CMAnRmUZJgGymRMADDA?=
 =?us-ascii?Q?UmJlcFXQLjIngUE+dv1Fpx3l6Uf86KEQJZOqWocRk9JpojpY4+J+ffH/sOEU?=
 =?us-ascii?Q?HMlvRwLrZdilKdXDC4t91TEC1cScW7foTSnO67oC1z6LTh3hdCuK6Xv7W526?=
 =?us-ascii?Q?Xe0QH7iQK5JGTP8HJfkt0X1+i8tRlAstTI54fT2Lkpobsu9zEyI4Arq/a8U6?=
 =?us-ascii?Q?iqpVNHnFpUSb93vBBiB02vuyUutGpTW0i9FNWjo0ISk598pHb7/Cz9XI5mNk?=
 =?us-ascii?Q?Bs6xvaB3vcq8SUjsHg9w+VK2ZAA+YKXvRkUsjqHbNQ8Kk8b9qCiRVFcJYXzK?=
 =?us-ascii?Q?6hhoum6Vnx+7Xf9sKIw+pvjuAxTHamJG7ebleSOXcxUbahpW0WmlDCGxXkwK?=
 =?us-ascii?Q?ZwM1mkHuLnaqKj9ZgbEFUId5Z3lCf4nnsFwQAwhZ7GNo5dK4wqfAlVi9MCL3?=
 =?us-ascii?Q?NPGYSH+hs3+CzE29ZCEdc+KIJ3FjlhTE8ZLA+xr7PakxUpgQPuOOzWeUucHx?=
 =?us-ascii?Q?7TlhMo790bUXnpBM9B6exbmJd6lNvOU+k8idDB7tWFO7JyNeMPzEtmurErjs?=
 =?us-ascii?Q?CTrclTuc1eFdOtKdX3rWOZWnKh2kdINxKf2yjZaTOJxE3WOVj0tg75iqXoXC?=
 =?us-ascii?Q?nWq3psIb8wAke3UvHnVTO8xFXgiUCa+JbNXaEaMoFGanf4YhjR9o6IXw5Tod?=
 =?us-ascii?Q?w3irUcvDlKLTdrKQHijh98Lw1NuKPurA9BgYp9wplehvNOXSUZviBPF0KH3g?=
 =?us-ascii?Q?Mjwh43pwjoiIHxTJaAwbdQXPHGDCDeh+nrqPSTu+Rz+sIkCGKNiuMJhp78kO?=
 =?us-ascii?Q?+6W6wxUADgmPbGzMKhwrNWviabhPvapAlC0VDhcg3Rz0TzXdnbGFdU66aav8?=
 =?us-ascii?Q?i9NR36i/WtcVjgGAC7jWyTzVzzmhPqzt3Mjv8N4GlMrdooQxKkhd9hqQW/w/?=
 =?us-ascii?Q?Q/cN6dZqqY0pgb5nRIggHmEcSGdM3R5zQ6psjhd8ROoZvWJ/fbVT2wHRnkFH?=
 =?us-ascii?Q?BsudlIs+PRbnIOcfFYnbtJgI6S3ya3ad/Rb6sM2L9MC/s93Pk1+vVmRI/kwH?=
 =?us-ascii?Q?pQTJOic6fFc2ir9vm77tKlPYtpR3nCVIKFkaSGFNzhfkbM/NILuzhc2sl80Q?=
 =?us-ascii?Q?0vtcTogLO7qR1NLcH1u7dNBtR1EzKyXGRSItyVCqYm1/GzVEyb9ytbrTy9ny?=
 =?us-ascii?Q?DV6Q2Ld+rh3E4hbNAiz4cqHYDH3lDqTfV7V4vNm+frwTKb9N0CgNgpBDb1vG?=
 =?us-ascii?Q?6O7k5h9GNLjaONWuWqM2UDavXG7BqVZG6LLwhYls+QxzvLyeXzgRkzxFwDgR?=
 =?us-ascii?Q?887Y+6H2WM2SmyAEauJtiUyABSVyG3lIoIip8mf6BSLv11ww+wlqYrJtETxG?=
 =?us-ascii?Q?cQ2pXYQrfua3hZWiYZXJV5oXlbMQkruHspTV4uqqaB1E6k8MnD5eleJFPgcT?=
 =?us-ascii?Q?r/3zEcaQPFnRdvqlkaCCZD+bFSLpOUxJc3C6DkFxPi42eljI1n7hJzxm/wtN?=
 =?us-ascii?Q?RtWmNApS+Xifk6gVehJr6JCjeKCcQGVnQes/oAGr96LtLuoRE5/ciAxecCz4?=
 =?us-ascii?Q?/iwicpUt3179I+H5AYc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:10.3994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed32738-7ba0-43bb-94d2-08de222a8e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626

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
 drivers/cxl/core/port.c |  9 ++-------
 drivers/cxl/cxl.h       | 19 ++++++++++---------
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a64e5c71fbd..4fe489244a77 100644
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
@@ -930,9 +926,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 4cb7f66b9483..11709f0f91d6 100644
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
@@ -774,8 +776,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
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

