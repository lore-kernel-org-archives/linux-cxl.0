Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65A2D12E1;
	Tue, 15 Jul 2025 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606771; cv=fail; b=bPhzRogJ3HiiB7p6rqQjsSVwpm3LGxQZkdgTSCQZbZQWBI01kwhXa3XlD0xlTx3brPCwAEmNjPJ+GskD3nAOCwNet8NZNXV1bxKsP9U19izvEaeAOsZvRFCGh4Koxni57ZL75Jg9mGYDpeCSfs9zoBq8d+/p8Lmml43Axksqu/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606771; c=relaxed/simple;
	bh=fwg+zat8Y+6cP8PUz1cF3YiqNeLpwPyk7ZPGgeYqLt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lC6t9YPz60m9W+NzUAOGplqE0m6l9VJQQUE3/rmn0QTVaybGre6nr99iGwiMTshmJySWN7Q0hu0oohc2Jy34JvDCe9ZnVDfSChNaj3wGnYWnTEoEfPvxVLyXNhYecRZ9ikutOHN+UrQTgly/Ae4+NFJhhp5gvubCGX84GNOdPy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nsg9WEyb; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nsg9WEyb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGlI5gT2oa3ESRdk3DbE1ZbpypXus7ecGjhqFm9IT1I4P8hpWJKNHuXqa2wDsqR6+Gy/13QT/vWOmjH5biNvZU07APtaUiHrZl8eUtG6tqEWcfvhxC5T9n3HnHpmE5PsKSOcy9v0IT8mb7T97Krv8fjivKjK2cqURE1dFVXc19Re6qxFrr+AnAX6fTGhpZO4wbra5etPuQ5rVhrT+ovfk54KUFL8QHLanMNihqoxZg9mqfAj+vChK3oNQfSjcJmPOjaY6ykKH4Dwjgxfd7cbaabKcCpuJLmuBliEYzBl+xTlYGsOTRIs5jo6+2GDRStymuwa7BoaI/PG6Kaw64pdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu5T17ZnFlDyQ6w7gT7xNmGannZ0XZgkBTEY7zmWIcM=;
 b=No0ghvjybIjDUEFnMFdXCWlblO209Kg2wlBJk2CdMrNOXSejBG8YBKqvdBNTRyKDdRSdEcHfBwXTJzhN6jMG4kvi9ERkT0vogl6VjWpR9cxuRgs/019f8BpXkwcYlGomgJiMGXFnfjDI4yW2prNBQ5/ufqghxwHFNCiMZ54VXYGSyK1N2d6ivtBinnvko8IfnGihuzhbnSihwhgZ7X5Q1Ct2D+HcHN5iL6V60YnfqjIeI2ycRWrbbfwl0zXR57Il2F/FVPji0a3iALMWkxixKDJ6odR6JxD0y75q4qSnFZBThru0e9pQ9g3XtyV4tDepBMRFR2fjSXHbQuzbV/E+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu5T17ZnFlDyQ6w7gT7xNmGannZ0XZgkBTEY7zmWIcM=;
 b=Nsg9WEybUEGyOVx/orkCeL1ARAJjSEpXtj5mTDkAnh7Z5ONNyKLIgDhEcRNWd7ycCHbsiT7b4HsU1Fugjhz/zPnLCLu3qNorajyy3h4oRP8BrwLXSP2kbh4fSuJp/dEGEff0rJ0eXXLuLniy9c3Ka2L8BcZYaH+C+c4yCpFfsqo=
Received: from BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 19:12:46 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::59) by BL1PR13CA0106.outlook.office365.com
 (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:42 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 09/20] cxl/region: Change __construct_region() to use it as a tail function call
Date: Tue, 15 Jul 2025 21:11:32 +0200
Message-ID: <20250715191143.1023512-10-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 497ae509-ea31-4fbe-1eb9-08ddc3d394d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PpLEcIz2Ub5M+FOnpboFYEB927HAi79+RMP0P1Ydf7Lf43LIs7Rwc6mWKuuX?=
 =?us-ascii?Q?5NIl6mD0cHSYW94jRNrdQBKuW+d74I8u3eyKplgP829NRZzbET7lYjwcSzLW?=
 =?us-ascii?Q?/ZpQsTRPuPsTMcSCw9guRO0SLkUjoWYdvPJy8EbnZ1yDKUlNTRy7f4xzTum2?=
 =?us-ascii?Q?C/JRoJFeV/7IGbw9MKC3VGRrPMgt4zueuPauH6dkF9FPk8wEhRs1xCpHwc+K?=
 =?us-ascii?Q?wCmzR3n1SkBks/+9oNowENy81/Pr2Xv+4/HSi0Ui3EFjkJ7ajvXYPxodryqk?=
 =?us-ascii?Q?2A7t6vfX3XzQ2olSDLGNESyvSZcDDrbYxXhKfOGIumu2ezcGlBkExpXSpcl8?=
 =?us-ascii?Q?+6x//aMMv5XeFBbhzDOZtFXbtC06dEhudZk3BZq6/OnmHWYlyrQydQVRHonV?=
 =?us-ascii?Q?oXeN2p9s1Fw8I4SvAJzYpHAseTeGkGwLF+X+NBhtXsdfpLXnr7qQW/JD4N/P?=
 =?us-ascii?Q?/3mbTRVUF+evWGGsYjPFLbojLrJST+JC3JNvNqN+mQYgUhtuMLGO8jOnH98Y?=
 =?us-ascii?Q?N6ZkqqvJm+cVSHGjj+ySCREnmapCila3PGEGYtUruF0w0rSzUNIGTRFS5orG?=
 =?us-ascii?Q?+yPsEQxZnV2QdbOHoOfj8EP9/9S4vrlnf1153V4tFO5nAyX96TKeXSw12/JD?=
 =?us-ascii?Q?2MX6AkdDHvd8xYkqU0crb0xvK63KMNPXEDKXUZBgc8xAYCuFCBU+l+hS8Zww?=
 =?us-ascii?Q?xgwVxwA/G+w2Xm3q8GzO41QzKQgbCHFXrBcQpW+qG2NnM9J9ZmgWyu9GXJb6?=
 =?us-ascii?Q?+gKCfSQBKtgzhU9CQREmXY7BbyJvLM1XYGrx1XRa6re0jZeobfPsscRn/GMs?=
 =?us-ascii?Q?ujhYqgulMx9YdVK22Vr+bwhz6ImSZCrP1AIwOlwgtM7gehYBrrwv4iCn4LHC?=
 =?us-ascii?Q?K+UKpse7HCHV/H0f2IMYTvtzyIFvzKEyNc7vTxBr+iQgJSCE8X4IjVoCGCw3?=
 =?us-ascii?Q?NPDIxoCCT5JTvBwCMQex73GBmNQJAx4VFiJmFcxmlAqro05yEa6Q3CU/OufU?=
 =?us-ascii?Q?xEMRJfEURMZrtlGTnOrprmhTw0KCzZLleq4nvrW9EBrJENQg0FVduZw+Kt/o?=
 =?us-ascii?Q?AM5iIb75SLCoLjH4MjKDnfVsdkGXXEtgSDjEcnqYOQnWyLxKdA+Yxa4w8nol?=
 =?us-ascii?Q?3Ily8VBZlt5mkERhOQGI02xi1H/+nTKukPIo27JKNWEaK80IlEzqQxODgK4a?=
 =?us-ascii?Q?cs2uBPwyxcL7fWQkadPjavbxPv7uHwLyP4A2xRRf3WyNcmam06dJzBBM/0nr?=
 =?us-ascii?Q?AkdSej3kKP0gSmqDB3xyWiznU2nefydTots7gQogSe5bxbrohrmeQ+Fa/3yh?=
 =?us-ascii?Q?aZGTnyOj2KFCFF9EH/n+9inQgX6y15mZeOHmZfH1fLBEj5po1hrn7ob+q4+j?=
 =?us-ascii?Q?b+LHYS/yvivK1AxQl6iAjx9cgn4No5si4UqvKuKBfYjxeBUOWjya/htHlZL/?=
 =?us-ascii?Q?58hF18/9Gu9TeIxPy/giI8e1xfhZRspxskDkX8WCvKWLh/feDTNbtmxJAf9F?=
 =?us-ascii?Q?QxYMzY45rT+J0MmZainas7gRnZ5+ofHQ9O5h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:45.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ae509-ea31-4fbe-1eb9-08ddc3d394d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861

Change the function interface of __construct_region() to use it as a
tail function call. Use the new cleanup helper early_region_unregister
to unregister the region in case of errors directly in
__construct_region(). This avoids additional error handling after
calling the function.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 34ffd726859e..4743421c6db5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2540,6 +2540,15 @@ static int register_region(struct cxl_region *cxlr, int id)
 	return device_add(dev);
 }
 
+static void early_region_unregister(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+DEFINE_FREE(early_region_unregister, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) early_region_unregister(_T))
+
 /**
  * devm_cxl_add_region - Adds a region to the CXL hierarchy.
  * @cxlr: region to be added
@@ -3347,9 +3356,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *__construct_region(struct cxl_region *__cxlr,
+					     struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_region *cxlr __free(early_region_unregister) = __cxlr;
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
@@ -3364,14 +3374,14 @@ static int __construct_region(struct cxl_region *cxlr,
 			"%s:%s: %s autodiscovery interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
@@ -3406,7 +3416,7 @@ static int __construct_region(struct cxl_region *cxlr,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		return rc;
+		return ERR_PTR(rc);
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
@@ -3416,7 +3426,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	/* Pair with cxl_find_region_by_range() in cxl_endpoint_get_region(). */
 	get_device(&cxlr->dev);
 
-	return 0;
+	return no_free_ptr(cxlr);
 }
 
 /* Establish an empty region covering the given HPA range */
@@ -3424,9 +3434,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	cxlr = __create_region(cxlrd, cxlds->part[part].mode, -1);
@@ -3438,13 +3447,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
-	if (rc) {
-		devm_release_action(port->uport_dev, unregister_region, cxlr);
-		return ERR_PTR(rc);
-	}
-
-	return cxlr;
+	return __construct_region(cxlr, cxled);
 }
 
 static struct cxl_region *
-- 
2.39.5

