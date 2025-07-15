Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197D2C033C;
	Tue, 15 Jul 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606745; cv=fail; b=Tcv5TVFZEdDgNo06G2WJYHI1UeQx523/kOSjQMdGs1uhXEOr9Tnwyvd+QTjq4ZKOHVmEuFfe2b4juizFnqNiAPIydspUtI6yYaf52oMyOI6Jmkv7Vlnu47FQcdtigSwAsN3EGrOjKHK0u6DCbrp3GTKIA77sodIKX/FNBMUeTnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606745; c=relaxed/simple;
	bh=ejHY0fkm+wbijd5VaRpiTXNwJgv6hb46AkMRP8SUVp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6Zz/5tHmlDYMNKcVyTRploOqoQoRArd+M67K2hy3vi6XGjidf12AtzCcycgAyscfc49j3JLQFtT3g6m4j2FrBykrkypvoMhEOi2q/ahRzwux3hWWywa6zqLXfVFGo9TXWO08RMk791bTUigZlW/dXmrElkFjg8mnNd+EShJ6Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fTmQX4W8; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fTmQX4W8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN8KHUh0B9BTtzBgxjOxkMxY2+SrKHtj5Sr3AeLHMRBavMy2YKbRerUUr//RBXspGa0lHHBK7BQbh7fRrNmGDTXRvKkTFNP1FdvKEqhncI0pDINGIpRAO19ekjs5g9F6kh5n3XiqVCIiVQJqYzJAtD1fKGlVHWbpwY799eNRaM39i88vFeEVbHC5GYSYPLv7ZDV54vIa0RBLsyWnNLqBf7VTeZka5PI0W+YM+z1exQqVzk69SJhA2Emqdxhir5eIszfsEpVk9TL7BmGcyHU/JHtoxs1foDSYRyE6NW4mD8KEC5qrhtdPadL5dhzXElzsZmGTHsb9JSfu+2RgADlD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m83iI6fl3+GwB0FSLDg5iv/NED2RUacVj32MwYPAR8=;
 b=tu5gVyMW1lmbuHn3vM089xctIqHpYZf68uY/ZzvF99lqmycMW2z223H9Y0MvWyIXhc3J2RwKJRfl3ec8Yt8dnOrN6VQcbd+LCJMjiwIs8vjh8rrABkV14gCmT+QaocB0jtlRmZl4cAjNipcXMVklBWlJv6lOeAGqcQ6lFRFVmJrD2ZkOMg9YceC1VKhrAzF0zgOjZB3sXcKFxeK0g07S9pUZFK/lgp8er4JQGEkVa+X6LGnyPk2rW8b6a2Z/V9BU2jsdF0W88O/m8btxOJpfkRN1eW1v+h4JMcFIntumhxNm8hzoG0Rl5xgpcYED8eygXkWTbISmWa5ucZFCIdvHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m83iI6fl3+GwB0FSLDg5iv/NED2RUacVj32MwYPAR8=;
 b=fTmQX4W85laa2vdfzLBN1IAlnzZoOUu/8SzklvhtRrkffHh/BZG0s2gtq/F09ajGPyegUZHj1LfTgH+uFjETqxw5S8053QU302AzLkZuTasU33dS6j4N/PcCt5gqXSMvVeD06+ziC3PIcAz6E+nzUWcwAksPfcUoXF2kZDOSl+4=
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::989) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 15 Jul
 2025 19:12:21 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::2) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 19:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:20 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:17 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 02/20] cxl/region: Store root decoder in struct cxl_region
Date: Tue, 15 Jul 2025 21:11:25 +0200
Message-ID: <20250715191143.1023512-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd2e6b4-76ee-477d-ed41-08ddc3d385b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dy6cU2cRuGe+QXJIN1+6AOZEQA8fF/oRNK81omiDLWqglZXLHeuM8ENuTSp7?=
 =?us-ascii?Q?X9TLs9L2fGW7AJS/f4c6aj6U4638omS7LzC0vYiqy3H5o8loQnY/KXigHckC?=
 =?us-ascii?Q?9XpPz4WOjScZECMdzx8LYIGVVibvIcGcIi6Ffamccf1jiTnyHqq411LxO52C?=
 =?us-ascii?Q?YietKWIiTyB4WXMbEx+1iaxCMG7TrtTzsOxhsTsG047ILSgugobnPC4kPr8Y?=
 =?us-ascii?Q?LNtlBf/nH+SzjPSuL/uS4wq76uEgTlABYGrATB3kzC2yS4OepJDKCPmV/KRQ?=
 =?us-ascii?Q?XoRSKNKfCVOJh9KR0Lh2b9dWu6KMm6MW8PDw1IWDFu9St/P7TxKnmxT6QtaT?=
 =?us-ascii?Q?mMBQUTl8ARpSlESX3co78xSBA9RmUOo24vI7eH7AihjhIGPzG9sqyxcxi2PI?=
 =?us-ascii?Q?Nd2RQg+zPskKcUYxpQuWucGnykGMDCFBnLSLkDqWmyrWjXXFTASrZnBGmty0?=
 =?us-ascii?Q?Jhu/6Sao9CcJSLiQ5R2qqqlrudDRsw+S/AHwg2ITpYh7Xa+GjtY0UrTUBdm2?=
 =?us-ascii?Q?ZBtImKKQWd4M6N1n0qMub9eBGbiKkTnpW8fIaQELcNEx5y7tbPCh44LPG7Ur?=
 =?us-ascii?Q?KjBP/qaC7VFOl/YolEwwfIrBMYWXvmc4G+qcA0BlL3G1pR1jCpSYnFrHaLtF?=
 =?us-ascii?Q?L0yXUOl0sgKbwUZveenGiR//GSJFUxRqKH3im1DJHH1xsqbc+r3qZuvT/YYr?=
 =?us-ascii?Q?lIF1AeRTkE0FoH4BBLI5I53AkId3W2whZ4AqrzzJCtqgDjrzQD7fo+LohPJJ?=
 =?us-ascii?Q?nur38/TkHUppTu+G4UOh7hs6XJxf4e66TBOCBGmcrlBmp+iHqR7MZTd+R5r2?=
 =?us-ascii?Q?CmZFtaE2hdKp3wK+PdsWsgqFyVz5EXyeH4F1D9y9bM1DvTfwxUPTI75t+uEF?=
 =?us-ascii?Q?U47c4HBjl4Of9gy7vgrs51M1gc3nMxMvxjhtCfQDiDp8ySzdv43JffVkp728?=
 =?us-ascii?Q?6lAGbRN3cMINFdz0MdcYEAKkh8ia9TLcwvztj6FwG4zidap7n6OXzyiTT+n0?=
 =?us-ascii?Q?plFLigOvyRr+SaJq/3HhcehyrfYP76KoHzUmGgp4pQ2laYqOmeaHx72xNU0K?=
 =?us-ascii?Q?rmfpvehLx9puxRpL4kNKZgzpuJfdRXUSdTfb5jvwIdRyy21jxG1Y3s6Pll7d?=
 =?us-ascii?Q?63KXeJf3tmOYJmrgOC4CFyBoTLnUq/u8G6UX0lmuMeFs9Ww9W/N8j1TVZ1we?=
 =?us-ascii?Q?Wz8UQe3H3BwOX40BS48nP7NgjsBAK3nARXP9z5C22YDnRR5jtWcq3UYXGUcp?=
 =?us-ascii?Q?TOiyVTX5OfWcw2ZhuVE90tB99KT2up6TOMG+9zbgkR1uyRSUnm0g5Jn91QiW?=
 =?us-ascii?Q?5BvozUYfeIDU+dy0y8fzHMJtYlEyoHoZKTUIDTRP4dXIFQj6JPyspEzTJtVd?=
 =?us-ascii?Q?VUlIc2eWwhFyCCd8TSzp//COGkCPYysFbLQUmzuPCWUkJgOBPUykzbnZ4UVk?=
 =?us-ascii?Q?ERxpioSWeE0tLTzqZ41F8O9guqwmLjDbiaTFyOyvDupQ5H7VhgEwEEsaNXCj?=
 =?us-ascii?Q?Bs7dfd3g/qJZOaiCtpMlRjiMC0dYUGR6jtgy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:20.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd2e6b4-76ee-477d-ed41-08ddc3d385b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D

A region is always bound to a root decoder. The region's associated
root decoder is often needed. Add it to struct cxl_region.

This simpifies code by removing dynamic lookups and removing the root
decoder argument from the function argument list where possible.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 33 +++++++++++++++++----------------
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f22ad20b0db9..a18ab5e30138 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -467,9 +467,9 @@ static ssize_t interleave_ways_store(struct device *dev,
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
@@ -535,9 +535,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
@@ -617,7 +617,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1320,7 +1320,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1679,10 +1679,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
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
@@ -1919,7 +1919,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2024,8 +2024,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2048,7 +2047,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2323,8 +2322,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2470,6 +2469,8 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	 * region id allocations
 	 */
 	get_device(dev->parent);
+	cxlr->cxlrd = cxlrd;
+
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
@@ -2905,7 +2906,7 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
@@ -3293,7 +3294,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3329,9 +3330,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3423,7 +3424,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0730f92df038..58c9db0bfb93 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -508,6 +508,7 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -521,6 +522,7 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.39.5

