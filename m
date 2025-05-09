Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE834238171;
	Fri,  9 May 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803296; cv=fail; b=Qx7FOD+UZFeLUuKunqK3TZzj9a+Q8sK2kWrLNLBEGUeIqSklANUhgWiKMQQL0KhShyhD3b0LmxWVGeiGqpgebv/V9Mjz/9WCU0/g448K42Iq7bFvHwfna14txifgTHruhFIadhCh0pKlRWmAfgjRm/LdKqoLGrFaTqP0nQZMEBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803296; c=relaxed/simple;
	bh=HkWViIPLlUWlJZyHyyYTWLIbnPtFd4YGG+Cd5XX9tPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9JplE8aO+VKvMsWMJogzwJOr9N+sYbS/ZBtOg3GrcRuoypD3BKwGQgDQEDG/JJKHZwhmpXv+5VIt6f0L9TsSynIDEb/Zn2oNmuCGBQHPPPn+7+cHFDtHuVTIJ2Qu9zspBDFlRUQq15o3vI8fwCpRaaFWT2wrLdd2KXFX+3p7Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gww9yrfI; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gww9yrfI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txq5SoHOjLNjogyM7RgF1ak/PIsxovWSJQ06SoM9aFXPDKw0F/yuy9Pz1vBbtqT5ad/y6Y0q59umeMycGv2PRhZcXLqlZzb3z3KYtGy2ia5+aVjhU7e9kw0NrNTHONwsCwOcvFs88sDS4kRLS1rGJYLSv3OT7xrwykAM39nsK0zXTk7YkX04IMqOvteLcNbCo9oGwrx+XF3PajD1gsoIf8xJ37Ch5BNWliyfT9k0qmDGn4es69PwQjfbLeuHXi0L3DnPMzfrMujPUHwzJMl4vl/hikdkyKKPK6OE21/bVd2KkETEqrOyHgTfuqA9KQYOYnW6DDAeNBtZdweTa3H5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9F+sFPlfNtRb2QT99WI8PKiEvRyDsJ0hn7SRu/KtxE=;
 b=neCHZnVl76VHKdwZZIPqYlb6RqtqRP7zYiFCLQWC11TQ9ZB6XiITn5TT55nIvl2ZMcSW5xoiOrtfAGvZ3THsD3Kbj50VXUrr7g2gdz7O5JajeJLUcvF//6muKHrX8BqYoNPAoceJ95qUlIQLrV3VuMJiDBEOxzW/iV7EEJcwBxRZzqZUf18q5dCk/HCLXghbzWQVrkRc7tcWkuK8jGfVgP4P1IUKk43urG7NO/jLpbaVvN0WA3/I76ZS+9RqlZiPwADHKqgwchWRSEnWa1ejfY4ULBlRPlP9EpgitvAhI7fkMCO3xIh49+sxz/ZsVijA+3/ljEGSC0iHcvJkvZBRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9F+sFPlfNtRb2QT99WI8PKiEvRyDsJ0hn7SRu/KtxE=;
 b=gww9yrfIDgLCWeIbfdUW53Z/TobtAg2Fte4ZE2NvcBAz7d6xluLSlwYyF1CLOXKGJRDWlccw9F3/MSSptV+7akmIm5hLla4/J/zO1KIaUUd3nUjyTd8gCUZciF92w/n/VtrcvxZppbuxpQDfCaqvg4MgX1ypt+1MTdW9vNOdk0Q=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Fri, 9 May
 2025 15:08:12 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::92) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 15:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:08:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:08:08 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 09/14] cxl/region: Factor out code to find the root decoder
Date: Fri, 9 May 2025 17:06:54 +0200
Message-ID: <20250509150700.2817697-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f131335-6f7b-4c2c-5b08-08dd8f0b5099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RaGk/M7xTbJCXKE/GUlY2dOdUFYg+BZI1KH9FBM0D72bI0qRuyq08U7k+/jJ?=
 =?us-ascii?Q?P25uN8YPw/P+5rtDg+udvXe/dKWRlKciMUySrLlr+moPTVRNBpzK6QlA9gYR?=
 =?us-ascii?Q?fJUuyzG0saGtF7nMA86QU+f9gXVqyjSB0NfAULoS/K4zoPzHqhmK8jqhPKbb?=
 =?us-ascii?Q?y9nnWhjzUNpewDOfpumZ5qyMhJGPcnnd2+SavKvVzLzwZXR6VDNL8UIU9v87?=
 =?us-ascii?Q?rvDCowkHgdQxRj6wZbWRcH24vJ//rJAu5rV3ZT0zk6EYD0oNQ2k/tnZ3KMVV?=
 =?us-ascii?Q?ZQWAxYJUPgahIRo+uIxy1fVZA7sNkbzVocDRlBECJx45GRAqe+RKFBLqQRcr?=
 =?us-ascii?Q?pbL7++fIZZNSKx65xDBKjOh99RtPg0BITQv7XYpxZxJ46QCFVDdtu9nuAD3T?=
 =?us-ascii?Q?VsBJ+5LRL45F+xvpjeVWti0WpVw9N+G+5TY1xLryMIswc8yZIIQ7TFdWnFKC?=
 =?us-ascii?Q?i2ncDE+q3wWDGHhb6XbDpjDNV05eQ3xt3Jk4uzJ0bmFdwmGNMBLpWMdSnaKe?=
 =?us-ascii?Q?innVqlfgi7/ig5k2Cx57mws3kHWevTdlYR2dRMp9BA7YurJ+nNPKZ1rmCcPl?=
 =?us-ascii?Q?iw+bwVAUb7pjwGrnhxVuFpkw4QBAh3rYYgmc2K2/mFZpk6tGozdLCTCzixX+?=
 =?us-ascii?Q?Cph0FGJsfE33F5M7r4oTlO5UbtDf/zTR/eQ756wHGQZvEWSOkhgLJNsZIdTW?=
 =?us-ascii?Q?ELUiuzngHt2AtbukcpIwEO4DOh45DdE2fH8/CTo/DDkaVUrP2KU0j5jjHKy0?=
 =?us-ascii?Q?SGBErCAKYae6ETmau/2Ubjk+ZRwU9DPWjPfgpA85uxx7giqHUzUwEw9FyxCQ?=
 =?us-ascii?Q?AR5u4aXxrDspzo9WQvVjLqUUVhZiKvMzEogmCvXznz/6ZDuRiH316xPQRW5E?=
 =?us-ascii?Q?aw4TuyO61fwIwd+u7UszCwHT9vwMJHhtUkk/MPa+5y5w/m14zrNfUvBWNxwX?=
 =?us-ascii?Q?iHogugUvIjHdRc+hCylrDkfZ9DwyhVyVOIuB49AETeA5gvH9kaS8jnq/ubmq?=
 =?us-ascii?Q?Ab1qulTXYVo2BWitJH0CR/K7cYX4TrtntNcmMxn1kk9EEjq9MqWotNoernBh?=
 =?us-ascii?Q?9gIz6UCQzVSVd7M1zS7PUHObYvqmHdDFJ2LXfa8zVJENuDllRnY7SQvBkXKC?=
 =?us-ascii?Q?v20OeUxsaPehndNAEIyyajV03ERBHZpxtJv2UlKDXpsmmIrEE7eo+Mev6tYj?=
 =?us-ascii?Q?7IGVnp2LXYxVb5CrQlzV2S2+mmJb1Hkjqxlq3IVWQ8165InOvyo1mOoQR/iO?=
 =?us-ascii?Q?2rM/tU+VKwsF9xV3gxMQGt/8En1VYno9qKOfXI4+D0YEvqSlal8DfnPz+yph?=
 =?us-ascii?Q?2HpobaR8uIyf36DUczS02KUGuGDqx43G7PrIYSKFFtclqwqr7risBbKs5GMG?=
 =?us-ascii?Q?xjljF3QiHsJEAN+0/84HkZFkd0KAMPjNliVa7LR98ukWdk385tuJqJmZvQlZ?=
 =?us-ascii?Q?SPA2cYSumArxiyM7MJIaV3+3zI5FneyIKlIA1wcxMcCmIZJW0XYo021t8fwl?=
 =?us-ascii?Q?4hje5IC+A0UTLSfYDbKEbN75YdDWP6aZoZMJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:08:11.5673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f131335-6f7b-4c2c-5b08-08dd8f0b5099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442

In function cxl_add_to_region() there is code to determine the root
decoder associated to an endpoint decoder. Factor out that code for
later reuse. This has the benefit of reducing cxl_add_to_region()'s
function complexity.

The reference count must be decremented after using the root decoder.
cxl_find_root_decoder() is paired with the put_cxl_root_decoder
cleanup helper that can be used for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++----------------
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 59d0d6becbd1..45f5d2c7dfdf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3216,6 +3216,29 @@ static int match_root_decoder_by_range(struct device *dev,
 	return range_contains(r1, r2);
 }
 
+static struct cxl_root_decoder *
+cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range *hpa = &cxld->hpa_range;
+	struct device *cxlrd_dev;
+
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+				      match_root_decoder_by_range);
+	if (!cxlrd_dev) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			cxld->hpa_range.start, cxld->hpa_range.end);
+		return NULL;
+	}
+
+	return to_cxl_root_decoder(cxlrd_dev);
+}
+
 static int match_region_by_range(struct device *dev, const void *data)
 {
 	struct cxl_region_params *p;
@@ -3384,29 +3407,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) = NULL;
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_decoder *cxld = &cxled->cxld;
-	struct device *cxlrd_dev, *region_dev;
-	struct cxl_root_decoder *cxlrd;
+	struct device *region_dev;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+	cxlrd = cxl_find_root_decoder(cxled);
+	if (!cxlrd)
 		return -ENXIO;
-	}
-
-	cxlrd = to_cxl_root_decoder(cxlrd_dev);
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
@@ -3424,7 +3435,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
@@ -3445,8 +3456,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	}
 
 	put_device(region_dev);
-out:
-	put_device(cxlrd_dev);
+
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c3f50f2d5933..371f9dcfb61a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -740,6 +740,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
-- 
2.39.5

