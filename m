Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC6311C03;
	Fri, 12 Sep 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688352; cv=fail; b=ENqryYeIwwtGKA1Wm0SszagtzPI4drb15YwNz6v8qW352W2uGcTSAPBZid1wl9KCQcSaMuNWCqKanPRbUdjxOYYnu92DqpPZ6nkufccGwDn3r/NeIQK8Gow4+1FIFFGHD8SDBL//QSy34qfm61TTb/L+UnSu2VxyZvWJsiHD7KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688352; c=relaxed/simple;
	bh=Xer4qoR6e5Et14HrGF2qh4LTKLXM+ROr8nJcHOYbO08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hacsNtVwz60G8+gQv5P1AExiM5iYbIRI04QAaodUowt1To8qTfcayXdRUaGsf5EMwD7KugzWtibvSqd1grG5EX6ey0SR3dNYMyYuEm7cgoDXta7HrNS18jMOvfues7T2FMjKnC+hEU6ZTxXlIzWkGlwoT9dWfZV7ITc5zZx9dBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzczFVl8; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzczFVl8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5KJE0oAxamY3f2lWG1q+QztX2vrN27tDAEU6cqA/mqsTBrK5Lk4TpOhfkDPAB4uXW7vOiOVNp5zZQ7Ph+iUHO8iLjr4DjpvxZT3W+YNSXhHgeSu4yppDwIDePkjMv5zQfAceEmK9+L5kAFFgn2c+v68/tltbyxfAsA9REuoqFl/N1hWt9NkEbr1H2HnhmqJIU5IjeTs75OfGrKW5rVSBwLMqrf9QTfLw1dgeQzQZ1LD/1KgK8atDyJTj4NYyV7zVVfECyq/SoxXGf0g5REfDZXmY/L4CwIIzrdvmSfkChEqlXiwJoSM/xEIM9xxrNzrMVjzz1ONfRd1ww6/TE5boQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFCZY2Oi2EpH6SYKCQi2zF4mH2PV0t4uKV0wvz2d3B8=;
 b=k43fRthhFipnLa3DpmneAemiLQK+bB/msEsjyf+qo7ptAG/iZPb+ZM4frMiQvzWeSSvTI0A71jXyanqJtKEtgOujeW6qM7RJv2H9X/go5ZkZnfTDRBqcsKcJl2JmsuSJOu0d0WpuBk6O/MqOGZAtqGFdKPmpBVzf0hYwrD7QuBMwHSm/nWSkKaD7+w6vfpKXduUUIjUZ0yB4T4OjewfcP1U8wGNgYYIMS+gbtOYmGWRO+pC8u3RLr6X9vRVUzKLOe8cRvuvSIpMpnr+1803W6DBMfRQKZjTWfj3WSo3S7mxDxYw1XW/OfouHVFTClu54uq34mGDXVFVz0Mn0nVZG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFCZY2Oi2EpH6SYKCQi2zF4mH2PV0t4uKV0wvz2d3B8=;
 b=nzczFVl8AMRdER1gfXBIaqSclWUrGQwbsbnW1d7PnFBJz3TPYX112v9zEAxSI2iuMyezRw7aIF9bx/JmJmexzuFo+Ym4xjrciVb1DEpeMqBcKEO8x5kNuj7ENvJCLY/Q/9QRCN1S0EfMQoEKp6uNmO+28yl9rL3XfVfaf3Yl6hQ=
Received: from SA9PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:20::12)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:45:40 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::96) by SA9PR03CA0007.outlook.office365.com
 (2603:10b6:806:20::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 14:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:40 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:36 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 01/11] cxl/region: Store root decoder in struct cxl_region
Date: Fri, 12 Sep 2025 16:45:03 +0200
Message-ID: <20250912144514.526441-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7b861e-8fa5-40f6-3272-08ddf20b0b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FXxBitnL/gVw9URLqaQ0O3A4jblzF4GAo1pI3Vue6EdDUc2xm6LlJt7TbLca?=
 =?us-ascii?Q?jM3jTvKY45INYV8UFQsqB2tLgY36ectsFV50Q9y+O+sy3Gv38gtGZ/7nVMrq?=
 =?us-ascii?Q?lwfwDjKdNs/OMbaeWNj9NHTOlVueNqhpg1y2hlRj+W+USJfp6mqYeZaHG77T?=
 =?us-ascii?Q?8y3U8cazTMySL64qyUbyZp6pIU8So6+L1O2/sWHrpi4309a4CvH/MoupWq8w?=
 =?us-ascii?Q?vttWzo0LNjL6e4tzbIA+NrvpXrX+qZzq5qHRxChdhNNA4qWtDpuXuctOXcro?=
 =?us-ascii?Q?tDLiFlwS4G/YgvuIN6fQoB2bapeVoIU61BX5PmV2TwjniLV9zeKdo/vxXtf3?=
 =?us-ascii?Q?QPJGbV0aQyVOcBf12MRaC0Vf4uxJjlHo/e2H2Zm/plBzMQyKQHe2yQRDtwyW?=
 =?us-ascii?Q?QKLNdhd6IVSUa1SuH4GsuYPSF5KX5KlT29gpCh7CABhPiJCzfozszCFotUua?=
 =?us-ascii?Q?XCWAAaF056ewNih2BE2MBjFXriSt4z2rixoB2lrUllW54TGynSOuPMdtTsOb?=
 =?us-ascii?Q?QkLH2t+8BeuYvy3irZPmhKS75sS0PEgG4eUIGEmtgEtuAlkXvntqCO1A3ZiE?=
 =?us-ascii?Q?r8dYE6lUvIqqp6sN/wy5W/gO8scMCz48TBKnlHbxphlj1/bFYTdUU25VFU4Z?=
 =?us-ascii?Q?nkvLl7rTQ38XpIGpOX+XnxFPraNRk2sRjJEK66rDhwzzH9olDnWF1+V6+9gj?=
 =?us-ascii?Q?oBK/NXyEYoDqBudRMhu+btSljK2CCSGi0YacLtWEfrunkfh9UBG60fD0xLhh?=
 =?us-ascii?Q?NMOff/9F0rxuOojKJEO4IByPb4hdoYoXdVDKHFhV5v9JVdac6rLaWx8f/5Ek?=
 =?us-ascii?Q?aSHt3bn18yyn13ioMniHFfh0k6NVmikSoljnQT2DeXqUeIUSfGfLYhrcOfoX?=
 =?us-ascii?Q?B8ir9ntJwslMX+M1Zzwrh54fZ3UvGOQCitpikPBbnDbYJlqz4WUdDC67w1KJ?=
 =?us-ascii?Q?GBMKZmK7Mbg9CsRuTAJ88k3JH1V8EqMCfBWYEvKR2aaNuLzQazrCbuMNZ4X6?=
 =?us-ascii?Q?Sz6tO/dhkjw72TJtQPblrPYr9Mg5qeqqcc2Jg5k09ysgwNKASjwuutgCN6JF?=
 =?us-ascii?Q?h4HB7I/6GOUiNQZPFAC6nWmoTVBKHx5n76c4DgqxjLeEh4dlLMC7WoK27eil?=
 =?us-ascii?Q?UiAnUgPrnZfNw80pROMlzyDVZfCy3WKpHthKaLymTCRVfmKIgOGtLsFz2JDe?=
 =?us-ascii?Q?7tn00i+X+pR/6M8KBM9CoOSBWc5OKNUv4eIHlXIJaB9jkkoyjJuDUXO5x+3/?=
 =?us-ascii?Q?h3S/OPBq4M9gjHTJAONn135uc+SYrqGxNz0Ptea8kHo6otUxIPv+ShCSQFyQ?=
 =?us-ascii?Q?Om/Dm8L3KLbm6wY8rcweGKlOwvhUjou6RcdZ7cRhZM16B2OjEpBF+3Bsu6bL?=
 =?us-ascii?Q?iMJuBfG3OKMPQMgdfVld7QRyI2KogZJKAlbaPbJxnu8Re/1HG2a4nDzZ3Ujd?=
 =?us-ascii?Q?rifUJ2SMSEj/FUyRu3Wc51g6bM+8jCsfgNdHU7ClhBYm5xq7ufxJxwUGJDyX?=
 =?us-ascii?Q?SyqkGrDkddeUQd0e3BZG2PgcsHdjk52QOBw9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:40.0475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7b861e-8fa5-40f6-3272-08ddf20b0b17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073

A region is always bound to a root decoder. The region's associated
root decoder is often needed. Add it to struct cxl_region.

This simplifies code by removing dynamic lookups and removing the root
decoder argument from the function argument list where possible.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 37 +++++++++++++++++++------------------
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 29d3809ab2bb..2c37c060d983 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -489,9 +489,9 @@ static ssize_t interleave_ways_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	unsigned int val, save;
 	int rc;
@@ -552,9 +552,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int rc, val;
 	u16 ig;
@@ -628,7 +628,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1321,7 +1321,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1678,10 +1678,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 }
 
 static int cxl_region_attach_position(struct cxl_region *cxlr,
-				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
 				      const struct cxl_dport *dport, int pos)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
@@ -1918,7 +1918,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2023,8 +2023,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2047,7 +2046,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2343,8 +2342,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2427,10 +2426,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	 * region id allocations
 	 */
 	get_device(dev->parent);
+	cxlr->cxlrd = cxlrd;
+	cxlr->id = id;
+
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxlr->id = id;
 
 	return cxlr;
 }
@@ -2931,7 +2932,7 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
@@ -3007,7 +3008,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u64 bits_upper, bits_lower;
@@ -3401,7 +3402,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3437,9 +3438,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3531,7 +3532,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4fe3df06f57a..350ccd6949b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -517,6 +517,7 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -530,6 +531,7 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.39.5

