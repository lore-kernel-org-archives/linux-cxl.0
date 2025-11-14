Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7435C181;
	Fri, 14 Nov 2025 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156410; cv=fail; b=YEMrB2F+AknpLz5/5eDfe1e9yP1iNkL4icN4fRFIaZEZkyhA++79oH0RPjq4VGVGOKgQs2Hza8RWKEyKHzAAatfcBMbh+rbxu8MifWOFYAlFDSU8pNpGPEC6fRM0bYrQ2qW4CrFF5br2+7qbcCka6kqGQ57dfz2yIOURB85SvIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156410; c=relaxed/simple;
	bh=Ruw6cex6Mkl3tOYxwXtIS9uSljMfdsGuorzsuHZfGmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5oi1BaQhj/TKYRRYBxAt5qmTAlO47Um11StkNUUp6IcIidM5trvLJD32mwOEAjSC+ld2MipbA3eTT/ajpLrSc6tr+GeuhPTQVqEg6Bujfei0EmyVxo8zKcRJGhUSBpoOHY2BXcoD5UIbEcFBNt07MXbO1zmnPCBoP7vql31mtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4enY1ekF; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4enY1ekF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkQVZIkMR7WW3lEWNX5F7BCWPHiDrApK5o4cVPlLv2RRBvbkivciOJ+/4hpUF6+OdP1hRXiMchT4Zj3p8nE1exUqTHnXkS+Vdg9QZtfPORwj+2WO+/gqOiC2QDvLN2Sqd2xi8s9mFRyZOTZnct1b2FSuaRWoLmPGIkz7gBXGy3c1c5YW2+i9s0RCu+1JSJ/1JWYQbDU2+dSFmCJ2yuS1rvOuhG9TWMV2o1QLNW1yFLPB1LrUi+HbAqMDTwOIkFqL7Q5QlX5QCL9Oy6DsT6QUXpTRrLTtfHC7YH7hGr6sra3brsdbWeTXbKaQlU7e5rFmVYBeV++gyxzjrNtrNgmZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI1Hlz+H7En0RaN1e5KhWTcYb8eOSnWXpCGMI4CjbDI=;
 b=OYPy8C/lElJLo32LUyS8Qzu5LJvsr0BJzOPmOYApzDv0/nSz5VKIN8CDBwcltbVjFqCzD2UwfVqL670vq7+r+h+RY4mdCS39027z9UL/rD3irR1GcblKxntKvU23GsmhJNfw8Jq+rPXgjSV8TZbZ0Z2nPiQ1kCov6dUcIT0MeF2tEifUPB4dDugMWx8rwz6/q2j4QUaI2rPkC7dlqRBNu8qVaeJYWY3HOEuOduGsKS5yMh7vKd3sLwADX3Xq7tEB1WnFY7fzbZssr3lNxNJY7l02VT7Cd4eTUaSLqx68PVM2qPcP77qjscP1jWJ8sJ67Xlfc1vY4dbW/3Lpt/Afz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI1Hlz+H7En0RaN1e5KhWTcYb8eOSnWXpCGMI4CjbDI=;
 b=4enY1ekFUoFhUkRabB8kXFS3ePo4LPG5iuXBkJfvg9dE6XqqR4Q1XtPUrIlamJ88k5Zc2zLIUbp7zfT3k9yID4YgtEQ/RYxN6M5A1VNknylBVx7CwAsdhB5RHobuY/5iboL38A+lXMphksjT7S7byhK7tZPIc6obza++jidXghw=
Received: from CH3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::17)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:40:00 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::5d) by CH3P220CA0003.outlook.office365.com
 (2603:10b6:610:1e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:00 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:39:57 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 04/11] cxl: Simplify cxl_root_ops allocation and handling
Date: Fri, 14 Nov 2025 22:39:17 +0100
Message-ID: <20251114213931.30754-5-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 18519ffd-b7a7-4a40-8df5-08de23c65d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMfCHvxWz2inUy2G6PIgURdo0nnZc+DCYxLR4FVa+sfj1N501D6HiNYpbGgj?=
 =?us-ascii?Q?2qE9N/FHIk3xAUO+4awUbTs9RuqReald3DL6Nfr4ZCfcIKTNfaQlwscV6WtT?=
 =?us-ascii?Q?D+pw+pqZ9ReBQL6/5gJm0fuGVPl4s+oNwutNlMtJUDZxrIRhOo7SAzAUImo7?=
 =?us-ascii?Q?jix6BNk9TiQJg4lFvzwGYEWbc3Tnx6bnFSnWXgbsyApgGDcMjMPXpDU0ATso?=
 =?us-ascii?Q?HGyCLaW5KBuBIBsGQycjwyZu641SxaFqHsyBKZMFoj3crsS6pflqgrxQJBcA?=
 =?us-ascii?Q?Ywvi+2HRQKYMLO+LiIsSF2Ffn9OnJDuGn0g7qHBDszs4GY25bU1KbKk64Jot?=
 =?us-ascii?Q?FJrlhGUsIHQczk3dvuMeq/AHZGudeMnuWyuTipzaIk+2NtIZlBaueuTTZwRr?=
 =?us-ascii?Q?VEjVdxKS5rq0Z+P5Ork5V5wCX7K+Ms/mwvzf/58RrKZIDlTkGvvFLCBL22Ax?=
 =?us-ascii?Q?b/DAZAcg7fWar491BN7LPk7NJchSsXqdY+7/oo4ZnfdI7dYWt5gJJu6MJFA9?=
 =?us-ascii?Q?kRR/NEUcwKlMgzqA70nu33TOz9UnnAgX1ecnjBUdOVtb+ZXOvbsrUNnPJMIs?=
 =?us-ascii?Q?8J+WhZLsDBVgwParLwQYrKJZYe6OcMoJHRRsngRDx3x9gg6M+DTlADguRcgU?=
 =?us-ascii?Q?8AyQo7ztkUcv+LzmotbseVO9WhAf6JRNJ9hHiYGts6C2Wdelo1QNtIY+HP2Y?=
 =?us-ascii?Q?Bv/5gIcCa7SfELlRCENtlWqhEvNR3D5xJRT+NCVF4Y1a7ebuzUB7Nv26b753?=
 =?us-ascii?Q?T452m16YsKsd5eWFw9HjmVsQu0lF8dHQmE5hyNg7MaN06sHxx58PntivKudd?=
 =?us-ascii?Q?H9qPZ0mNrcaUYGZWaFRS7jt+yE+NuyBdEf99u0nCNG+WkYgcj7H8qcPVrotf?=
 =?us-ascii?Q?nQvPNVXa0LkEMLk/2Ouklh4SexSIxQLh7IhPZIl5RKYd1s08a3RQcnDVA/wj?=
 =?us-ascii?Q?sKAj+lJ+VUblsuEs2v8lLv+ld39AHU0jtpbLNPV7wSm2Mu/qzNvUNgd96/EQ?=
 =?us-ascii?Q?NQA9qcRG6FFqN/mOU8MwBnYmnMn/roHy4Z3TJ7G+MRBjrdxa3fXeGibxOoFd?=
 =?us-ascii?Q?6N89/MhT/K+v1Oe9kO7rvwycgE/SPHLKX80rakB1iX/FTHeCYesjZtCIFqKd?=
 =?us-ascii?Q?DBam0+iR/MC2mryvVV5jdacT5RFmJVzEJZxXibzNSVVgpm8+dErPhvhpc9AJ?=
 =?us-ascii?Q?mbcwmC4Lg2s18egGadPC6kUnEUFgVGid41OKoZbXiJoz2c1sIg1/7xbKK0iw?=
 =?us-ascii?Q?N0D9TGb5pM0J8IS8rvwVUmzARTxKb41x43ypGiZmidteJaHfSaRvypqIzxN9?=
 =?us-ascii?Q?KI+tXhNNjM8Ip1YYH/DErTJE+MWZuhD1e/IJ+iCpfj5Rp0ngHuG0UYOZby5y?=
 =?us-ascii?Q?xnZ7R1RKOZ+s5Yg5NMunf271Vb76l30sQmkCJWKA8YNCDsI/vEn+nyInAQo7?=
 =?us-ascii?Q?DB9H/AB+WJDho/HTKwnQ8mqw8mdvmUBR9pRSXUyYjENM7zbymp1CH9Rgkbs8?=
 =?us-ascii?Q?0JriS4l+N15mxFsuaEDE4stnmNanVYxDqtia7pRERIgSLVxLSmUevFrcveNN?=
 =?us-ascii?Q?ikwsZzMoDShLp1C4L+4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:00.3979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18519ffd-b7a7-4a40-8df5-08de23c65d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

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

