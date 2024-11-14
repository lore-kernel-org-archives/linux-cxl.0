Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F11F8920
	for <linux-cxl@vger.kernel.org>; Thu, 14 Nov 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583490; cv=fail; b=MVa/nCnzAhL3bWJIw+rWJmAkrZWTvXPmBJf7V9b97idr9UWDErjV/6t1bHSlgaDkj/PfvFy/ycpVDTaWuT3PDvs+F5ivPipEUq5JL34zNvfWAJnY4uhpJhSLfs1hrTCb4ulYC0zGKxtM+4rFEjaIlWbWzXORq9BobI03QrCtqOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583490; c=relaxed/simple;
	bh=71kCZcE3doKRCjlkWQRfgoJ8n6evvFTUns9mz9WwAJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUaoK0oYly2WqvB1o3pFHEbZgyIb0rE6Ew6gAS8RJ+9232DZp0hPut2B8FqNrf7KSl8bQQSFXr0D1hs15OEvlzSQU7+V3aGidQlB4gFpk3PQz0b4Copdt9dWvGJzL7RVCkQszrU3Ucbqo5pjyi2BzjYAasybHg4brN0wyOxcZLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sHZbPN90; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sHZbPN90"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNUsDuFIy7ivgXTP2D1wob/qQ48R7vJA9Xte8/1gsUi1M5rsyQZIC9CTagnjNR52DHkRkPNfKTRLOF2kT869fcQu3Zd8xyLHefFq5FBkEP+kU8v3UOePiYnRKR6B1ql4XKU2hUZerQuVLHaWVh1qUk1OIwqB0WzTH+dAb4VLnLR1IY8xB4XJfkoSyuTSZilsT0bRE7gr0+z7GPunQnwAZEYtNQvTNTI2qOxzN2gPVnXCOdHfBe30NicVep3pEPwje9pc8i3xXThzXKhRSjEBDhIfy9TIRKpzf6tac+gFmCMm2bFMYYr0NKtyaHfgmiRgLuXDnjoQzfle9yr8cvNC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O16Xsr33lOwS0ErLm9MY3qChMF6wAwCwcMKCJUvxXzk=;
 b=q1tY34MogBAKlKuVSQrvheVL6hm5prE8jktvzgWvRI1ZXvYeiJWqVAqlpystYEhKkSY1ElMgo+XRXr6GJ3lfVcLLwOtyLY/zWSxwpKE0q9CB+XFtE4f8l+/DWwX0JutH75Q2hSfMTk7P5sNiQsFkDOJhewwv2xUcpRgJ67NEoGNgvkv1uMwJ+709Lr7uu9o7jWXWSSTJdYkFrpg3Hny81KD4IG2bylC5XMKIlMtXB6o85oxpoK5iL3PlvU82Zs9YXDjnBl5mqENjmQRmS1R6IFotJRmpzd5huJqlUpokSJ5boQ4dvvOGNdq8hc1Hv4llG4vYZOO6vt22TO9OX8gnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O16Xsr33lOwS0ErLm9MY3qChMF6wAwCwcMKCJUvxXzk=;
 b=sHZbPN90onXPqqS/3HH1/7LoOlfD0omicWpQ9Mn38iMV/0i7+Llh8X7iXe+iKeDSSy4mmms6FhJdXNJ2/rAdIHqWV/om0nEygZalHS1H2BTC7Xfmi6dIuvKU7wLbhALRhBsJe8q/GSaqA4vcoJIkLVwnJRY8OjWHBFZWzDwKfac=
Received: from BN9PR03CA0235.namprd03.prod.outlook.com (2603:10b6:408:f8::30)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 11:24:45 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::94) by BN9PR03CA0235.outlook.office365.com
 (2603:10b6:408:f8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 11:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:24:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 05:24:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 05:24:44 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 05:24:43 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state reference
Date: Thu, 14 Nov 2024 11:24:35 +0000
Message-ID: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: dd61ab88-24b8-4861-f561-08dd049ef0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llP8eKv6btcPEqaSXGgY+Yb6hRPvPEEkuAZPhpu6PDiU9g3r+6DBCu293Du9?=
 =?us-ascii?Q?5uuJj6MBq0M7GUKcFkgt/+21W05LVFySr8e7yLzrMFqjcXuRy8y/rfPjqs8V?=
 =?us-ascii?Q?K2cvtj36Qw78Yu4PTxoyznuGUpHat+z/clNbeqX36reAnUa0+vS/SKwHj4Co?=
 =?us-ascii?Q?kR+GTpa/jb62C7cD774KDtOu/gSB4nslCwAOpqv9sv1+2JgUNjbaV7Di6xBE?=
 =?us-ascii?Q?33CiFMeIyDlgChmnuKp8xYnsa9flYRg1+cuXRJ5rd3pyL3+Kbd2HKDqjGtfX?=
 =?us-ascii?Q?eGexfkffoe2dLHSwbgkRMIVWpQNWpdmTq0dtulX2gbmU1/bEYUfMtp0Jor8J?=
 =?us-ascii?Q?za0gFbLVORXaJALhJ/+XJbRSEAx7/cWjJL9OutCGU3Zvwj4H108VSvBkyjBl?=
 =?us-ascii?Q?f30P0YE06XJcL5URdWV+KahLo2wKd/iynhRLguIY6yHZXNFj0mpizexuD8nV?=
 =?us-ascii?Q?pmrdIJ7WfJPxks6xfySHlxoFv1vGygpcWGcI+TmA9e326Tm4/6FbXO+8VmaN?=
 =?us-ascii?Q?F2AsVrqI522DaH4QQZ3vioX0PYiEPhgMyaEgY4Tm4Qcm6ZEuRoqVZR8JpZMd?=
 =?us-ascii?Q?VXi5T8wgQfE3bi09hGtltL1RFelRierIHNS31Z+Nk655oSER8yKHS/fBsIQv?=
 =?us-ascii?Q?mbEo/E9oZHuxjDbDNuYZJDl8dflN8m1pbrhcqLHNRFqMEvqAjsDX+luldRjm?=
 =?us-ascii?Q?4tp2TPAMGfuVbNgFCvhpzQ9zQFIavPPyP/ZdnMs4VByPkhUkOJbdKfnAOjBL?=
 =?us-ascii?Q?bsuU0WAU5D42jz7+R5wIm/1pkJjfVfhEcpWpKP9sqnKiyNqTc0+049vZ6UF4?=
 =?us-ascii?Q?5fxECyIL43k+txiksbq6dQrPrSXJY4Xp7v798mj7H66b/P2+2onEfJ1TZ9Vv?=
 =?us-ascii?Q?DblEOvuwNVnkD8OVvpEKDaNv/3Hir+QzNkT3Zi6Hv96wx8eXIzNsyksaDcUW?=
 =?us-ascii?Q?D/TXpKfYNgerht+isdcAqGWI0UeIaInYijU+HuKRszVZsGk5yoJq+XkoQIZU?=
 =?us-ascii?Q?mAA+YCWrdANX25M3qLNwj/lMm+BXBJ7Wch7QVq67DnyRELWN71I9PnfUHD58?=
 =?us-ascii?Q?/5S+PJnDd8YKVXGQ6l6j3rehbJWvvfYm5BfMTFjM1lC61GDmWBMtGjAjM6O4?=
 =?us-ascii?Q?wzzI3WQz3RXOEi9YFRPeN4hRZJ1GxCX9t5IQP98YLDLRuso1Jou6D3OpAgG1?=
 =?us-ascii?Q?9NJg92n2RIDXkaYrRrbW22kYXirk4wQac9MiPFY80jxiYA5uAs1q6f6Prgvf?=
 =?us-ascii?Q?vaoqQB5nOubnhuJVt/PRXLBGshONg4blleUseoxzG9eZ0Qcpcf8iB93+4kfa?=
 =?us-ascii?Q?fwys3WPFyMtDqxRR/VxhRVi3JFWeTr7N6hsmw9C2fFs51T8jfb9ocp5AQKaL?=
 =?us-ascii?Q?ddlMmWogFQ9UX39SFmhIIKqUhGgiwcDMxv83x9LNJPG5dvSPJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:24:44.8683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd61ab88-24b8-4861-f561-08dd049ef0e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

CXL Type3 pci driver uses struct device driver_data for keeping
cxl_dev_state reference. Type1/2 drivers are not only about CXL so
this field so not be used when code requires cxl_dev_state to work with
and such a code used for Type2 support.

Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c        | 6 +++---
 drivers/cxl/cxl.h             | 2 +-
 drivers/cxl/port.c            | 2 +-
 tools/testing/cxl/test/mock.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..420e4be85a1f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct device *dev = cxlds->dev;
 	int hdm_count, rc, i, ranges = 0;
 	int d = cxlds->cxl_dvsec;
 	u16 cap, ctrl;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..42a46e78d786 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -812,7 +812,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 9dc394295e1f..acf2ac70f343 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
+	rc = cxl_dvsec_rr_decode(cxlds, &info);
 	if (rc < 0)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index f4ce96cc11d4..4f82716cfc16 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
-int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_dev(dev))
+	if (ops && ops->is_mock_dev(cxlds->dev))
 		rc = 0;
 	else
-		rc = cxl_dvsec_rr_decode(dev, port, info);
+		rc = cxl_dvsec_rr_decode(cxlds, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.17.1

