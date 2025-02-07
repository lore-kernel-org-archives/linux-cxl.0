Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AA1EEA23;
	Fri,  7 Feb 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942721; cv=fail; b=ne53+uUlQFvdUsBBejggJT48+rm87tXyozRGvjbz0U3ReLq5/6vje8FLwnPSt9PidABoFfggMAEIzUHiFQFo/EYGMD3yVGRpEzZHrFw7ZK+S66gWwXZjJi+25eTguyR9+FPYt1UWbLpv/FMM6UhHXjDsj8/usLWEr4MZCwZObZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942721; c=relaxed/simple;
	bh=tuau+x9ot/3hwgTSZBu6qQJlGlVNdgQMIBuicgC46Gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUSHMfBSPe0NNW6Z3vTYu6IX6KILgFGU6vFM02jDtwN57x5OzdxU48D58DgRjnMlHNEPp3ljGQmcmxR06wGQp83XEMINSrEAF1YwsCM5loKdu9AbCfC9b1Njrtrgz3kV5Po/Mk+OxOmhBNdsWpw6aR3Mody6x+pDRUczWBYori4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qdn5b3XC; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qdn5b3XC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfA7AQ/pYkYJGYVgnS8YTEX1otNGclJIx4+7R8m8EHqX+jTG83mjljEafrgfZYuYu1mVuT1mmmypld9kRl8Hh0zWEMkD8/Xn+GZVTnpM8AwAsUbafueDvvPhS88yOYYRs+VDRRZQIijRPseHJPap6LEUAtMeapTSO2PHyUuPc0MId8GixV3wIwMk5LFhXHtmObY1x4Fo1Bpw+HLZ4TCl4e+N93dn3IJTLzb0TAKprOi2+8DO81MOhb9z5xnIlwLvcUDPjhvpC/UfVNTBhivq6LIOC1wIMABKsoVUVaZUzyvO8KFcbzMWlIPyEhHv/E9NJW8YnRtp1pTCD5HUYIMUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6uNmjQkdXuNYRpFAWJg42anHaB7ViVkriROcPbFkII=;
 b=nzbobAmylw7cSHBM8Scp+QOEjel6RkNMUTwontWTDsxboAHSDIc4xCqAg94pBQjue14T5J+iRlcuMQUCw2i6uL7pNuiMCkhRajOv+aVu8HUpNJWRBe8gu8h7C68nHIaQ8Rzj51oMB4smySs80/gmvT9ej2JBZWMRvK7TNnmM5FB/DEG3kBynW5MDHkRziYZnvTV6U+H0N8URRUGNg/kmMJxmMlz6XEldMWMVK+rm9lG6iKjqLFD8JOm8bCO+Mh7AIjdsbo+tQdmCUz9HlLxOcRu/M76GPrCY5fwznhCzOFRdzlbl/dg4MAsYpUfNkFz2YU4Iu0dH77KXlRzIosSt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6uNmjQkdXuNYRpFAWJg42anHaB7ViVkriROcPbFkII=;
 b=qdn5b3XCgFwYsbDWEcv1hlI1UBiiDvFDYbZ+dRxdbklLR9JETuWiuDhlYBTsNDontmrxpxNgea9EHgrn4++NfDcnKQFs4V36HpSAsXXHbIaq+7Ujkd+5M+UbPBXnSzyUUE37Emi4Fd6kgjUR5qDwrcoF9+Fhi7bg1zVbtdIyh1Y=
Received: from MW4PR04CA0117.namprd04.prod.outlook.com (2603:10b6:303:83::32)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:38:36 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::e2) by MW4PR04CA0117.outlook.office365.com
 (2603:10b6:303:83::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 15:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:34 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:31 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 05/18] cxl: Introduce parent_port_of() helper
Date: Fri, 7 Feb 2025 16:37:40 +0100
Message-ID: <20250207153753.418849-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fa6cf8-7fec-453a-4fdb-08dd478d7bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kK+K1iyCMJjzQyPld3Dyhapxk1VFuVlrwli58dQ/0VVH/tOZDkUVTJyEOkWw?=
 =?us-ascii?Q?hR3dGmKcfxhQFtmw9Ai7mLrJdfbqk7sv/zMUajviKgGlzP1cSX8YAtXka+gj?=
 =?us-ascii?Q?UYeXmqkuv23ieYbEOHoPMoCzV3C42rKsieYjYJW5IowOQm5r4SWtVy2z2YJz?=
 =?us-ascii?Q?fkKEagYWbHdc3jFR69ktr4YkDoyv4xMDeaEJ39RhallOZPqo+IT35CqDZ+Q8?=
 =?us-ascii?Q?KxSUaRBi0QryiOo+xDdB2oynbDO1KMcO7c3Sdpc9+fzNfCIazsUad6/4jaJu?=
 =?us-ascii?Q?ezWc/06WyW+9MdDtCZKDHurhK3ZdUrmx91ppF3SOwMfb7U9+6WsMwyxG67Fe?=
 =?us-ascii?Q?LoqFhgJ4lejyQUZzP4aCXOjrfb1dUr8wUI1orCZ3C+kxiGXF6RHtKcuoaMM0?=
 =?us-ascii?Q?R+OemKLZJ/iJIAp9aZ5pJzhuAufAg9+KbJSW6hrMoZA2o2BOQJayNbZAJZsq?=
 =?us-ascii?Q?8Pz4CvKL0SqJhICpISXt0fP1r8JleHOVsZD4ytobQ/NHPvmvfpysD0kEaIOE?=
 =?us-ascii?Q?EQJSEFEhmkhOXohNONNnfXQZGpp5CpaWkd8MKlJOTyRb1u7iAhSHbFvE9iBu?=
 =?us-ascii?Q?jvEgkA9RJmjahloV2MpGwIkKxlnaHBTQ/SEKSBXo5DV/Mh3wsZ7rJOBccwgZ?=
 =?us-ascii?Q?rCuiFQlUrSz9Ta/aKbUf8ZFl9aalcwosoKYxjxblcnkJlmBNciBOJT5hOC65?=
 =?us-ascii?Q?iz5RZdOVBaYhwl5z1v7Ol1ypJ6pQNHu6/d5giGWx3YF40q3xnLSaF0GJ7nnE?=
 =?us-ascii?Q?8OJJ3CGiJNZQlW2rF6nDq9IHUIPhnmxFbB3RupwUrFOaSZ2JbX+Fs0fbTt1e?=
 =?us-ascii?Q?HXebQgZutzEU6k+0qsTszW5qVg5LmBPkjYJMpi3qkN2rHHvZ4L8JsuxPAfgX?=
 =?us-ascii?Q?/hpZ3WBfI+5BeQacfVVJ5IjVXvUoXwdQjPYVerWn6dEY1BPuZqX6CZ5dnjez?=
 =?us-ascii?Q?LoG21NRCY4jsYsGzoKIdUhbzBBNzU3jXtitxy40BLDwz8PsdStodHdlvTKB7?=
 =?us-ascii?Q?qYrwTpTt5NmjrGv1h1YDusk5OP0GYZI8sORrpxUDiVXAl43ooX36DyMg6RVx?=
 =?us-ascii?Q?I7L83Lpgvf0RJzOG6n7As5vo01CCk2//WZpgCTP71qs+eHxo7lbAZKQQ1L5r?=
 =?us-ascii?Q?Ff5BrN6TxumlvQizz1apSgMCB+POi2YKNT5SpC7s0lKHirKU/N8uYia5/Glt?=
 =?us-ascii?Q?GxM2iKR5gQ4V2IV7H8rKbLLRMe+I7+wEK7kbsqT9XuDHZeH7FTiffgatVVw6?=
 =?us-ascii?Q?qwI+5FV3DkwlaexlBiY3qlP31U+i4T5ziSFmh/t2SGFvG9xKqH0/v0AhCTII?=
 =?us-ascii?Q?MpvuNtZkfLR20XpeYjiLefMyuaifcXliHwLH+fyDCyZ93t0+/Z+ItaQt6UBK?=
 =?us-ascii?Q?kac/+FP6w/gieuEF7Fw30IQHFPaQ3pYeD6l6UH0Ey8mI7MdmTGoKGLGGR86Q?=
 =?us-ascii?Q?h1ZnJBMzLO85rn6M1DHf7JCtY+F+24xNN5AJNW+DoZeA4GF1lpEQBfNn7E6P?=
 =?us-ascii?Q?8KiPKwREkumPkAA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:34.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fa6cf8-7fec-453a-4fdb-08dd478d7bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

Often a parent port must be determined. Introduce the parent_port_of()
helper function for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/port.c   | 15 +++++++++------
 drivers/cxl/core/region.c | 11 ++---------
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f9501a16b390..d19930c009ce 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -606,17 +606,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
 
+struct cxl_port *parent_port_of(struct cxl_port *port)
+{
+	if (!port || !port->parent_dport)
+		return NULL;
+	return port->parent_dport->port;
+}
+EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent;
+	struct cxl_port *parent = parent_port_of(port);
 	struct device *lock_dev;
 
-	if (is_cxl_root(port))
-		parent = NULL;
-	else
-		parent = to_cxl_port(port->dev.parent);
-
 	/*
 	 * CXL root port's and the first level of ports are unregistered
 	 * under the platform firmware device lock, all other ports are
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5d252dfae138..54afdb0fa61c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1734,13 +1734,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static struct cxl_port *next_port(struct cxl_port *port)
-{
-	if (!port->parent_dport)
-		return NULL;
-	return port->parent_dport->port;
-}
-
 static int match_switch_decoder_by_range(struct device *dev,
 					 const void *data)
 {
@@ -1767,7 +1760,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	struct device *dev;
 	int rc = -ENXIO;
 
-	parent = next_port(port);
+	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
@@ -1847,7 +1840,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 */
 
 	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = next_port(iter)) {
+	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..0d7aff8b97b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -721,6 +721,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+struct cxl_port *parent_port_of(struct cxl_port *port);
 void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
-- 
2.39.5

