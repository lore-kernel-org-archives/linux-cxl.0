Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8C235041;
	Fri,  9 May 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803270; cv=fail; b=WjO/L1fxf5tPeiuEN+tRpB44f5WJiw2Z00dENijs5OCEhNtzwsKWZ1RaWv20eKb8iKSjplaVckht5NqD9p6FwL9a5A0kB+h95mDcn5EhWKPYzrO2iJq2TZ2RBVb8nx1hzyEVUqDUlnRZjS6fcJNTxrXL2XUQ8Nf4pMiF9MPpoug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803270; c=relaxed/simple;
	bh=MK60iwf8j81vlAvH+uU6orMh70e22BGn5Z7jeTBN+SM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPBrs0+/BCMidf0DpUvqwRmthcY6qflYqIi4tuU2lBgzMYPE9n5bkLvX1KfIQ59yuGsZSbGzLrdi6ubKPgdrMgHYBJMQxnYjkEvBXA/yTgP80nSWqDYbwG7CS7QS61Wlv8wdDjus40tTHaMz+AhDvMyBoqcX8SQgUUNKzqtJz+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nRCblHJx; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nRCblHJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYztdzzlFd4CZHIbQG41F6wlsy3DLDVgDGQqTg/jfX2KypWgTBVYabdcfv8+EJG3ktWgTvCkOGhCg5uPTREj4xSOeBBjM9d1bL4RTDXXIfbNTpImZBvsmG693lx4Wm8UA+bjbTGGW6AcFxdnMSSJudZE8heKTUZ1yMkR13hj/be0RhkW6XJ5XKUb0SU3DuU5+nLqfB/ez0px05LNJ+IMeYcloXeg2IDXqnHIJGfgo534+gE6t6uVlKFvwfyQvnGhvD2BAfel2TLzGGspsU6bHftt6srfK9Q7bQ0MrHAunA489xKmWuiNm3FhGmYsYm0PnJ7dNG62jqmq/DYoVBDsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PZiJ+rO9gNZWh/HkLnV1MDSN26KwMrxfBxEKryNXck=;
 b=sID7RkvTiD2vz19PgJjh89QP8WX5rl0fst2GBhak5xLaibGeeaA1GXnmVGeryTokSH2811DD1RpfyIwUWYVkzPFpcEvugg1inZQ6CTy5UOt8jmQmLCOtsSlpaHW23vhWkpj//dG50tLGcpnxHrRP6jA8n2STwMQ1dMvtz1EOcZ2+DmnGnVIqFjsnvMQIHNecvj4zL+cApO5Q7eyxZsok+g8DannIYt+dSy5a4NzzwwEtl52ey/NvjvNo6uwciyp11Ft3dECuAmp1QeeI5qv6HoncZkWi5DaaVm8aDN9furaaACYFlG0bhI67CuoNcZ+VvB9MdpwApX/CKKT3sP7R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PZiJ+rO9gNZWh/HkLnV1MDSN26KwMrxfBxEKryNXck=;
 b=nRCblHJxSnI3qpPVu5WW8xbuZdAoaM/Jp8ilmX2ZvnKvLVHuNEwpTOr6tFWRGqYA1BU7+oYQ/ljAPkB7vpA+P/AyQ7lL5BmcjgRwu1oYhxGyqYeZtvAnuA0xqWQ2IPo9OI9/Uz8NzVNzwcc00VBHR1nzPLSU/zvjrW+B7fpJXMc=
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Fri, 9 May
 2025 15:07:43 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::44) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 15:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:40 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Fri, 9 May 2025 17:06:47 +0200
Message-ID: <20250509150700.2817697-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e2e844-c297-4a5b-5305-08dd8f0b3fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DHrg6UY4hEmUSwW4MMwT09e8EU8gaMmjFKqAYBsNJYmGnMr/aK6MjulhF0fZ?=
 =?us-ascii?Q?2c6o5u6I426eOIvXP/+093tJ3jx/2r9Ub5FHGuDEg9X0TLg0fTwH6HcC08B+?=
 =?us-ascii?Q?C6BJfvJVlq0RdH+i2VNMiAdjoKxPeKvLyHx9UcrFPlqgV4er7JTvGlMkl4Z5?=
 =?us-ascii?Q?QMrCVtT5Mzx/ZKwvv4dZ3nvO1tSIQ9YQ/qqZo5wfx9u7mKfb85hL1Y35Xgg/?=
 =?us-ascii?Q?v6KSQ7JTC9mnZYU4ulZDSRMaG2P8Sjv+kyavVvj/N95Efkry2r31eau6w7MV?=
 =?us-ascii?Q?GaEAku/X+OJgxzAO88WeVLEK8bfgiobeAFHstPiTh6vMy3PK77KFe0UoEOLt?=
 =?us-ascii?Q?P15lsqXiCq6LSJ4Uc9eb4N4htFH2BHnLnfUUTwMvMbZxoOOYX1xLsZ3fCO1B?=
 =?us-ascii?Q?zpxVqAS/novxKUpVI80iU0PU344otu5Y+1eqmdcjjiZyDYC0omMGYFNRD4z3?=
 =?us-ascii?Q?Di3JepAit5L8jnzit8Ggy9Sf50oDbh+rvCAhJcXBoGVXhtKvumCradzgskac?=
 =?us-ascii?Q?eMIddEc0jFq+nmKk+Fuh0U70UP8u9wHuRhqpl7W3ZhG4UvyjEoVQ5rjrGZ+y?=
 =?us-ascii?Q?hlOr3s0tsphDH1sznFBiaHh9EU85ZsCNPXdZbJAU1g+r1gYx50pD2gZ19Elm?=
 =?us-ascii?Q?5jfWKgmwmxKjru4+XYBcz7PUZCQPWT78Q/5OP7WQQhOVF/qeje1I/jmg70Zj?=
 =?us-ascii?Q?kO4+G8BqSEs4RkUmfaLmK/dMGxk9TbU8VMINClbAihuxCs0q3cDvyhEk87RC?=
 =?us-ascii?Q?IS90m698zeyi11jB318TAXlei2tCjftHx6yy8MymE0ZKP43MB3M7Exmhxmvc?=
 =?us-ascii?Q?l30LS8ROx8n65zHVXAtr52n9MkAlUoqZTiMM9tOMU0/YgBEVG/4heAaV5dI8?=
 =?us-ascii?Q?cM5jnzP/mllGSS88B380POCLt++mF8eWOQ5ab7ADduk/LYMYVp3nmqoe+l4a?=
 =?us-ascii?Q?ez8meUW301t6igxnvM46euR4F3a4DJILEahSksLD3PSmr7Bn7AtyPZQ+c1Jp?=
 =?us-ascii?Q?jEG+94G/472H9mVrxFd10NES2XrEoMw5/CgAcmB2EVhGDz6n++mzhyV5oKcw?=
 =?us-ascii?Q?81tFhUQSy9ytKITSB4hiF7NnZsmmjLSXspQWoqYMStLxgsTCURPk7HQJQpQm?=
 =?us-ascii?Q?dlh6DscFAICsQO/gyqS+SLJX2RyFKZxOTKU0zozzhcjop+eRa7HZl93h7xTQ?=
 =?us-ascii?Q?OMpMFSZr1OUGNmpdwICeYTSac5QzcwoZLBD308/Hm/iIowVdopZl2N9UG0tX?=
 =?us-ascii?Q?8oBK7JKHNhHAF/BZ5IogWgaoQ1N+n4ej2126aNFDVwSRNfEdIe6ZHxId0bDV?=
 =?us-ascii?Q?Hj7QVbxgswml9Uk9E+E4AC6llb9w92lWoGKDkNycVacBthRxHgIbePxgTYph?=
 =?us-ascii?Q?ZpO4m3pMZoVyd/1VJo8UrErlCs7El/YQM1q3BUXhI8HhV/cMzAj4Tb+euAJU?=
 =?us-ascii?Q?PFe9BJoudujKyHy78y0lu6xock3fKs2A3zC4ABsyL82clBmSc0/WrPk8t1PW?=
 =?us-ascii?Q?2UTkz8GCWeJ7S6iT6oElmepI5Rkb9t+9e0rw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:43.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e2e844-c297-4a5b-5305-08dd8f0b3fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29

Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
cxl_hdm_decode_init()") changed the code flow in this function. The
root port is determined before a check to leave the function. Since
the root port is not used by the check it can be moved to run the
check first. This improves code readability and avoids unnesessary
code execution.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 71bfa3bbe436..159674c1c71f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
 	for (i = 0, allowed = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
-- 
2.39.5

