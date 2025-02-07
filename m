Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186A23FC70;
	Fri,  7 Feb 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942743; cv=fail; b=CiMNSmpv5gDJLYNHFDBSm4aFG8Ms7hbRgc4t942wMmMnZeeu0Z9M5tLKP68DVwkJz9R3FFZ+6x+M+4weMMRSbuLnSxCvaeI4raQxaAWJ6Z0Zs+B/MwNRoSK7oai+4AqmvkpVi02BIgUWazZwCoI/UNQzUpyV137ZYx3AAKKk4ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942743; c=relaxed/simple;
	bh=7+KYygj+Ks0LOQxe/1XLMAzsOnWJiMX5SzlK++OklHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmz6meFo/P4OY3p3BUZSR7WzV3Yz0a/mYBIyGNWxcANHNSCfF/zLqgde/efEDrBeXqRXhIE3QFoZx+faE9yTzuOrpwY9gxetLHph0hYEglil2Ir3aDHwg7lNFlglf4rCJiTj+OYAgudh3+ImcSErP7OCW4iJ27p71c5bbSFVUW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XEKxIWPj; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XEKxIWPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRekN85U+p5PgKcNLrCXgD4UVHI8C07ueiLpjOy454yqlWoK5rNtHQKzK5MzTG9whQDc+8S6DZd/U8FqU2jfx1pg8OHgRtlyVTW7chrTBZGfYyy+NwlYGJuV9e/kDt2C94etxtm4k4GD9U7EPgvVzCh42KPgOEDpWFntgH0y2ks8plgPgmGDt0cqHLzyGKz7iHyoEPy2By1urD5+1rnkfUmPdZwECppG0lpJdZQPykmmKUuPn/cxVzqKVF0wtGK5Jqt6Sy20Oj7AVboFSO4vXKxQhh8xvd+vj72Otuv87lp8C/8Cmc5gCkx+H4E9/cmryxxGJPdnup3HGm7S9zbcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHjJOVfevhw2cA/tXK0SsW7GrGvPn+rBE4pc2lvT/E0=;
 b=Mem/tE/Td4QvD6AdpQ3eEWON1+MYqRWjV3dkcCRkFIgh9dcv3WfWVAQxjJejPyV8C3lJ7+4cwQGHFW+tt63GeUUphM2NVBZWgQ36+87z57NopwtwHpTiNuG1GQD97SlxvqurwxXs9uimBlp3Y4OzlDX3xwMOYPh6n9EvWWQeWrsU6k9CdvA1ft3VbWFwhgHdSx0ezHsYuco0bas/Dz28wurYtVssdcdbM91Q0z8OBmRKmFf8blfQhTlIWOQwjahMnNPoBQb2ZqA5eemk8UqYNnz8+HgzfGFiRWE70RWUU2rtnhhlhTAsQ3sAXhcdSRNxErV62m8F0MTc9DQh2tjZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHjJOVfevhw2cA/tXK0SsW7GrGvPn+rBE4pc2lvT/E0=;
 b=XEKxIWPjbAXefaJnLOHrv/Yv0dSG3qKX73bLy3uWo8gHPKatbsTWrc5h4y4UfeliwEGfXadltj/KrI+chTYvxFYwX24Wl+MvksxykHu87xnKk+PjFWss6MtMEDeGWbZd02mpqNGz28+T4JDlRbvvk5p2RnbiguUIyl7lKIeYpBw=
Received: from MW4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:303:16d::34)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 15:38:57 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::aa) by MW4PR02CA0029.outlook.office365.com
 (2603:10b6:303:16d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 15:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:56 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:53 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 11/18] cxl/region: Split region registration into an initialization and adding part
Date: Fri, 7 Feb 2025 16:37:46 +0100
Message-ID: <20250207153753.418849-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c96d8f-c614-4e91-c57c-08dd478d88e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CSqu8if/yjTt+OBUu/vP9JHxzZhWXrXyKHWpJGzemoyMAi1pPI2rKkR0uuLT?=
 =?us-ascii?Q?oya/AZz9i/LmV2pgHNS9HVJbDjZYgiVttb7D2Bnr/nAoJggz2wroJ/zdJQk2?=
 =?us-ascii?Q?6B5h4kDu6rVkN+Zis13lN4b4trOHpliMGIj7HPeZLnly6K6xyIh1BvCKfE1d?=
 =?us-ascii?Q?DmXdaLHDa4TH5D3kaG7NcB3b/fTPV+bSWqNnapgfvgtGDAwmxz2MlOq1SIFs?=
 =?us-ascii?Q?Fa7/ApM7hCoOWRYcedLNxePuH1gblnRQ5N7uzyjAyczD54IC6DyEYaq9CWS0?=
 =?us-ascii?Q?MyJy8MQZd3s5LVBQT7IgZ6n94Tep8SNW0/IWRy8shrBC/O/dtSNHAN4Z2i5+?=
 =?us-ascii?Q?DQfUDqeNIJY7Wmx6mdt0bts/vmP+Pxe7S4PC7cRWEUOAiuj7L0Ma/D7ZUalj?=
 =?us-ascii?Q?PixvzXpfz8G4qCXpaUlM4gK2pRwoqQMbgFr8xMwrZZzmKDWT0A83MzvmorZY?=
 =?us-ascii?Q?cGZ6pwB9xOBxgcySe60PIxf4PWlsd54DRlpc3Igt8nyF2Gj4mXAQGbheE5cw?=
 =?us-ascii?Q?vWCvCZQ3BH4jeoReLjOnXidguUmWVqf62df9kZKNMOE+zjWxORsqs8oPd8ci?=
 =?us-ascii?Q?2+2Z8d4hc31clBbHCrvHoOUlTdn+4FvXeBzZ8FXoLhw/XksFdRswOZDeOfr2?=
 =?us-ascii?Q?jOqKncThgZK0UVrRmY02R3PDxh2U9qFhx0GrqXaeESU+VGagp8kOmouNhixV?=
 =?us-ascii?Q?rzEighiV2Aoh8ZSqTmbPJIiDRgqNrMOkKcMpCLvixyj23boD2Kx+COjsctWe?=
 =?us-ascii?Q?i3K5zh0ofjCsnDck8YtyIyyy0CEQUpzcUJJIz1t3eqPAI7kPrdlsz6B5Aprm?=
 =?us-ascii?Q?JPAqiFo89L+t78Qbwaq/R4zLYy7EV0hDXU/mwTIXFBDQUsuElk/p48N0Nb+m?=
 =?us-ascii?Q?TiwsOaumrCAMTqivNJZq+pfYnEoh9lJ9B2KXFZF78cHnWEIlWYOUP9RGLUcA?=
 =?us-ascii?Q?aDpKbcsCMLmAdYA4UP3ueid6I70akGzDI3jCIWRfeX+ImMS2C62iSGpX6p7D?=
 =?us-ascii?Q?Pe5E+nlg/m/dPxwkFn+eHVqEjTj2pbd01p4DE8i0fg+rnvuG2e/PY4KMXNEj?=
 =?us-ascii?Q?w89PJzLzJYAkvySXK/fGbMfof+xpRHLZtqrNPk0mqN2SnpPOA75iJ0XGrVGS?=
 =?us-ascii?Q?iNyeH36CRumeUTmsgoOljjUsx6NhmJxJWSukCaUnzzdFGj0CZSj50eKdNv1Q?=
 =?us-ascii?Q?Vg0CsrkFfh7pa2veioXQbvnTDlwyP3ZZ13X4fJNt2xD+7a8novkNq7QObzON?=
 =?us-ascii?Q?1JiJHkUBsdgNjpRjpxpILG8ofefeUwCWpyreBb0w2mtKpvwV4llCWaacupxy?=
 =?us-ascii?Q?ArnHa8PfzEHYmXufUDILkoAXjsDonpCtpaisH0/Si56hcxnDMP2yqzTMsPGe?=
 =?us-ascii?Q?iszrwlm7EmH0WYNCHdWB57ocExfXQ5TdbCJoWb+AQ5EauFaKYrTS4WlIGhW0?=
 =?us-ascii?Q?LFkkSeIym47ijMaqfl15W0EqkLKb1l+/7onfBPLEjZ6Ra19KDMI3YHxAluPL?=
 =?us-ascii?Q?i8GbNZlkqTx7ATI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:56.7898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c96d8f-c614-4e91-c57c-08dd478d88e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

Before adding an endpoint to a region, the endpoint is initialized
first. Move that part to a new function
cxl_endpoint_decoder_initialize(). The function is in preparation of
adding more parameters that need to be determined in a setup.

The split also helps better separating the code. After initialization
the addition of an endpoint may fail with an error code and all the
data would need to be reverted to not leave the endpoint in an
undefined state. With separate functions the init part can succeed
even if the endpoint cannot be added.

Function naming follows the style of device_register() etc. Thus,
rename function cxl_add_to_region() to
cxl_endpoint_decoder_register().

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |  6 ++++--
 drivers/cxl/port.c        |  9 +++++----
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9ce0282c0042..fb43e154c7b9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3345,7 +3345,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		dev_name(&cxlr->dev), p->res, p->interleave_ways,
 		p->interleave_granularity);
 
-	/* ...to match put_device() in cxl_add_to_region() */
+	/* ...to match put_device() in cxl_endpoint_decoder_add() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
 
@@ -3357,19 +3357,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_root_decoder *cxlrd;
-	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
-	bool attach = false;
-	int rc;
 
 	cxlrd = cxl_find_root_decoder(cxled);
 	if (!cxlrd)
 		return -ENXIO;
 
+	cxled->cxlrd = cxlrd;
+
+	return 0;
+}
+
+static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
+{
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	bool attach = false;
+	int rc;
+
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
 	 * one does the construction and the others add to that.
@@ -3406,7 +3415,18 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
+
+int cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	rc = cxl_endpoint_decoder_initialize(cxled);
+	if (rc)
+		return rc;
+
+	return cxl_endpoint_decoder_add(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_register, "CXL");
 
 static int is_system_ram(struct resource *res, void *arg)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 85dfc8df0a80..50e7d878bb6f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -392,6 +392,7 @@ enum cxl_decoder_state {
  */
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
+	struct cxl_root_decoder *cxlrd;
 	struct resource *dpa_res;
 	resource_size_t skip;
 	enum cxl_decoder_state state;
@@ -854,7 +855,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
+int cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -865,7 +866,8 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
-static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static inline int
+cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled)
 {
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 74587a403e3d..36e487366c7a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -46,13 +46,14 @@ static int discover_region(struct device *dev, void *unused)
 		return 0;
 
 	/*
-	 * Region enumeration is opportunistic, if this add-event fails,
+	 * Region enumeration is opportunistic, ignore errors and
 	 * continue to the next endpoint decoder.
 	 */
-	rc = cxl_add_to_region(cxled);
+	rc = cxl_endpoint_decoder_register(cxled);
 	if (rc)
-		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
-			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
+		dev_warn(cxled->cxld.dev.parent,
+			"failed to register %s: %d\n",
+			dev_name(&cxled->cxld.dev), rc);
 
 	return 0;
 }
-- 
2.39.5

