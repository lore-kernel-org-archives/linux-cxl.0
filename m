Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C92F6930;
	Tue,  9 Dec 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303702; cv=fail; b=phhqkmNBLksneIUVDcTa3C6t9oypKgU62Luc+bx3R90U+0TS8BH1btZeZb9TIo2XYdEKB+K2mI4HlG6x93gnZJ/ypY/Ex6W4hmrroQQ0Lm+muwbfrt3exTx22pNUncqKXAyAU9u62I/M3K1o/7gR7k8wWQ0aAfM3No+ZnM7mNnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303702; c=relaxed/simple;
	bh=6ObiKiWV54yLWxlnSE/WT+jUYUumTlzJb52MLeHiuQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4sJWOtkfCwQEVloqCfeQyYnHXUUai/jWVXBDi0L8sL/+z8LySCzeIiK8L6Su91HpVlxyazhTg2ZVx5UUK9TVRQVDeTkLmB/2ByItBApUvFtypO+NxNYKEzfehXgbNnml5K9Npm61/3Ul9DcfoisYdeunj8GaNHyA0TkbLndBz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VnRG6bTx; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VnRG6bTx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7UZwrfnGkSca6b33+AH+MnaOb1laJqoW+azE48P2slDc69I4asiCRksrTRteR7iDP1T6iUD2pkFPY6pQ6dil1iIFTi1VKC69Nm6L+EFny2r5mJej4jF8vf8Vs2/Vqc0SaAZkWMZ5MvzIHdNXv1ebrJ8XqC3Ad0XNjWc9zWeUYFtS+jKKNBwBulGzfA58OtmTN8tg96eNVDxFtF4vAPtgWkvLbdSJdWQgWVAtuh3Zwm6EH6ejWH9z6jaYWq6hWUE3kbJtqO2QXHmdQvdesb6VNj1z7C48F2pNMPCmDnjwx6kTuYVfnGLQktuNzVPv/SeyRDnhZNvhDkl+rT2z/UxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0yelE2c/ZuL5P6VesS4uOJ9qegp1keNSh1VY5OZn1g=;
 b=gVjlMb4TbBO5UMwV/2sNb2xfm5lv76XPPHEByfyJ9zosURj2hVkDclepXDznAzeeB72mwa4Gon/+NICb+rv3FmZRSXlt0tvGg0gTDV1PwbrvNFZzxj6qUZzwPkhumO1B+Oh2RSkNXzjBDAtmXHTP2LiUh8eeOFSiemSRV9SQca09h7I0Iumy1f2eNV3hBda2RqUhCiiqEUGv4A/RlMEqJz5B1ZYrz6UCDV3IkTd9x212iq0E3m31qW0ify19efsyOyXg8WQEd7eE90LR6pjuFHlXIK3J+0GAMPiRvW3hvrKfB/6HXsJX6jVx/w9nSPxvLxVTVzQY4oUDE2/iZz/3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0yelE2c/ZuL5P6VesS4uOJ9qegp1keNSh1VY5OZn1g=;
 b=VnRG6bTxDe2UWyU1HBZsNrZllZQ7ASPds11sxHLkvLpcja7fXfJi1F0CKDmu1rrhGE61wUpARUT0Dc2mXTSQxAMHtUSYy4oKQ7dOgm8+Qw/odbSG+wicyjSCxr6II+nXFjovyV/zP4bSToIADLdOxwDrgBUqs8vqMKns+5RGt84=
Received: from BYAPR05CA0101.namprd05.prod.outlook.com (2603:10b6:a03:e0::42)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:08:13 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::57) by BYAPR05CA0101.outlook.office365.com
 (2603:10b6:a03:e0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:13 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:10 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 04/13] cxl: Simplify cxl_root_ops allocation and handling
Date: Tue, 9 Dec 2025 19:06:40 +0100
Message-ID: <20251209180659.208842-5-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4cbc1c-6379-4b6c-c0c8-08de374deb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QUMZO+HFwfQ18dfnZlC25FD19Ft3yM+SozxrlUfyJlgpSMwCgpmnSDfJoJnT?=
 =?us-ascii?Q?wUj9Ygdm7s7m9RUmC3oWyFFQf74y+SnSZYw8/Lw0q0ixwZIbRdnvOpoHU+S+?=
 =?us-ascii?Q?wLYmcMXQ3UhYTVLBbLtUQgKwsfYG72Lx0vwoDX9qCVQ84W0AdSIGRgHopALh?=
 =?us-ascii?Q?A2dPtThO9Bos+MORO9yRvPB6PLnm/PLHpNxLJNAFw8nh1Ich9WvfPrsM6VHO?=
 =?us-ascii?Q?weZkElf6wSMNWNSjCP8IkWRZHTNWHok5uC+Txlw4c+0sXBPhXxCTyzOYU15B?=
 =?us-ascii?Q?aq2NJp4wmMcnqyJu3hJXUMZZJiyMAehP3fbaAvTE7nYAGgOs9fkAA3v+bp0D?=
 =?us-ascii?Q?JBCn4Lhg2yW+EHTXPMULaEtrglcpDw8Mn8IF2ddeNArNox8Ksm2pqqGVv2SV?=
 =?us-ascii?Q?G/ldBZCCvxU/qC8bdPxcjfr9NexPG1qfeo2s6kgjsr1Wsol7M9kWKrGE+IpS?=
 =?us-ascii?Q?bcwM2gS3nzHViL/xnwQ6eZrzjhJV63uPh3hw+NgF4MZzyvfiYpYPFmHuTbHD?=
 =?us-ascii?Q?/CAL0X8yzTfXUWZbfv81BTgu4w2uoZr7evZkGIVKTuMEthaqA9ygHYiYFckK?=
 =?us-ascii?Q?Vxh0nTwyofp/9PWUugHO7Y4C/ud+/NwXdRwyPyn0xa1Og0hpgOeO/R2sDD79?=
 =?us-ascii?Q?GSI/GcTyEp8/0xgY+Ab0+kdxRnU1J1Qb1pJJ7l10/8D99/vHuxgsvqbUMB5H?=
 =?us-ascii?Q?EmIV6tZwUzMstsumvZKJ/48F6FlAVIdxhCx7kUC1z3DDaoO/QHDAsvKWwvGV?=
 =?us-ascii?Q?pWLoCNVbeHNb+K6kaToWclnAyfdIyTpQgVkYUQm9LnK5T2VNcaiOd7kGWdtk?=
 =?us-ascii?Q?EQZgc3F7AbGH8pzpyY8qoA8psIyIjNSX28SjjmzWswQb2WnMmd4WZ1WAm5sm?=
 =?us-ascii?Q?BQAcMwQfkGiRpMyu4ciiHEaYESrN2pYe0vExtjpAluS/A83jTUak7WMQfkJ2?=
 =?us-ascii?Q?QOkMLKD14kS7rsqmqTpPiJIeVuA7n2tTsZzn5Gfr2fiToAp2FhH8RsX8VVEn?=
 =?us-ascii?Q?fkECRH/riUqGqa0S7eRYlfqVERZbeeLk3NoffLAXIXtHUio9s7FjFmk4obpw?=
 =?us-ascii?Q?z8vnPJcAcK/gR3wvgKVHsSIyTan9m28+BIm0420935GuG5mbj9K6aZ6cYjmZ?=
 =?us-ascii?Q?Ie5awu66oEnPjhNOTBgckRu02K61HSzr5f9ktRDXd6srTg7vKY4gBCqSes0P?=
 =?us-ascii?Q?ZZOaa2yW4O9EVVRvrhQe+J/Qcd3bvvczZRkEtUpJ2bsMjSpoJ7Rj1DtHME+B?=
 =?us-ascii?Q?jetgVE3dLBd9S7uHeHODc0FHBVRum+E776ARJ7IP9kKfx0y7wdemM9qa+BWb?=
 =?us-ascii?Q?muifx+hwzUVVoxxIvReL1QZ+Zbup/+5DteXANHxdrUqkQSaJvC0N4VkTlWWl?=
 =?us-ascii?Q?6tT1ZA5OGRx+YTH9p9WrS4eA978O81jLyJZEMhLkRkcaoOIsGVXnbMQkODXy?=
 =?us-ascii?Q?du0S19BPCNqv1+8Y/fudIN+a4LGokWn9jnyHTkmJSutI+42C1hz7ZHDZ+W4C?=
 =?us-ascii?Q?yOpyFK4N2BjBU3oRHyIw330/rxd9jVcfX+q4WQyMin2rqaRTDWGYCSK6E26c?=
 =?us-ascii?Q?h6tOQF08D632LPglbXI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:13.1362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4cbc1c-6379-4b6c-c0c8-08de374deb41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

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

