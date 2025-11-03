Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4F31DD9A;
	Mon,  3 Nov 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195727; cv=fail; b=PxiFdKKtch5igjbcgknyF9sDztYd2QdNzbSdSIfC15OlaD2XJO+OTU1MjCCPFlnWAuLGtlTT55ZMDNmO40/8MtfDgkBBcd0tiGmCxqkE0MrWDY6Tu6a3JkvI7HeXP/PQlodV43tHmCy8D0ZyJmpq+TsTDMtrGSNj9oz0hZzkgNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195727; c=relaxed/simple;
	bh=mRGicrTfxHlZCUewk6/itXDV9ZSWaIfpDko8RNcT1Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5J5a/q4/VCQdI4t/axtbAP7zdtmrz+0PVT5IAZd8VwUoatkurqtRNL7LkLB4smcxtPSjrZnXyFTmUYaK6o6ohgFhj2gQO/3527NSZRTCXxE+VQ61p8Z4j/em+7cO2WhYLNP1a6v0fToOS6IZN3/hGlUI6JHvIao2+JSkti9FwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YY/MOjhK; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YY/MOjhK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8hILA5Lbs2g+WmrapeblWdgfp30efeKvPqgMVrel6KloN44yxGHvYuV0etZjT8ndVpsV9BFv7g7Rbf4r54rkeIZHW9lKYJ5Kh8DtvS/PcgDVgGIQjydZl8WwFtxdYEVi38JR3AYZV7odlVWOr4XouxV7TTPNQ61UxRpFQrz152tYNMn+bA7h3NxFL4JsWmpQEsnEBHkOFSDrhBNQswC1f9rnHdaKIKmY2se3hHOD0irSKYtM0JTkE/sOZLu56G3rS83lwfGnbyStyf0kvOrfixiZpFqeEiYizdp4YY/h1evaXTzSTHBse7PNgNoeLgR+e03i5bsC8mFOWoS73w+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zScCo3nDWmjqyuP325XSZUiroNP5VItb51XuMbQUAmQ=;
 b=MFdhVug7wItBUwoJ94xFl7GpREYj8KVvKHaR0rQn/uejUGWhAYwhENLrqrgX4z2dH4oVl14zITXwBehbkNELjic9d7M9gai0G4f4LjobZlAZY73JaQBlT5lYKxwvQfhUkd+6w32C+UMDtXZuWU6UGjPGyynToMBG3VdWSuhD5J/KsQTwD5or4UdKR5D16gI/dw4KBVpdnKaq5YEg3dGCJTtCDx4wkmHOLBkpZNOtj3ORfgOF6L0cdQSvRJYAeJPWlKnPP0NFQm1vug+sPbGRM+RQ4U4ogfHmf6iMXBkl9kERzhtEefGd5sAiDFsufLHpL/+qW0QxFE2Q0C/RjFOXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zScCo3nDWmjqyuP325XSZUiroNP5VItb51XuMbQUAmQ=;
 b=YY/MOjhKusYaxAi8TWSuEizvOMSRK1PrJzmTIlz01ZVWOmW6rHOYb0JFeauNIB3wUuRc3cEapmXtgRI0MVF1xCzR/9kuKpIaIz9OlS3RDaJp9sUgSa/G4nMnZUcFTCpoTHJ5KXvqHGBtej7BSmIKwls0E2YQrHfSch4W8JWY3k4=
Received: from BL1PR13CA0102.namprd13.prod.outlook.com (2603:10b6:208:2b9::17)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:48:40 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::57) by BL1PR13CA0102.outlook.office365.com
 (2603:10b6:208:2b9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 18:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:48:40 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:48:34 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 01/14] cxl/region: Store root decoder in struct cxl_region
Date: Mon, 3 Nov 2025 19:47:42 +0100
Message-ID: <20251103184804.509762-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9d7b71-ad7f-4499-6e7e-08de1b099af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TamTZOgjTlF4WF8r8CMWoLZgCmfS7PYp/tdSbaL/ThpYwu7RSD2zczX5pw1l?=
 =?us-ascii?Q?Xwll9CxfyHTtpBKRhUlUMvYTs0PzogXeaohv44R4WLltCFUAOJF4Hu8foCIq?=
 =?us-ascii?Q?5yftkCaC+dbiRcVY2mGyyClf6TqECjtNU0jIPAqOENB7o90aufkwmK2w2ZgL?=
 =?us-ascii?Q?bDUPVgudKcqBGe9qjw5y6o6ky7lRCefZhh5PTJRVM8+ZJ7ewggygrWdMuTDT?=
 =?us-ascii?Q?x8VlKXEEfXlxeELKlna7L0FXsAG+h67nsr4+pP9TSa6g5R2vGchH4Xvgc8O/?=
 =?us-ascii?Q?bMlaEFnIoTNThhe50w1ZwPanNPEhWbF0GHIyWThwRwhyQAZI/XGg8FDfn7CL?=
 =?us-ascii?Q?Fy/AK7OMy2VCR5tHXyKEgKDclm0EkmTfUYkTxc4JGjz685gyW3tYTCKSLcyb?=
 =?us-ascii?Q?OyzK1OlUgEI+m97EWDfQPi9BqA2wVbrxcJImcUVthFlyzHmJcL0FS9kNqFFc?=
 =?us-ascii?Q?byfA5YshZSRdPAYC0I6myND8LXFn20Ly94E9KXbbl5AcQ3E44uQV/QWzZPTg?=
 =?us-ascii?Q?9F3oM/Nb2Gi+1ieJsJAWgCfSyesEo30w2BDTxIekaZJ/nFp2VoloUeAjxt37?=
 =?us-ascii?Q?DMkejDFfPFPltFwGmIB71N83HISS+IY+5KE1NPn1p851iOFLPhznGSQN/Alk?=
 =?us-ascii?Q?r042TD0JPfw62JiPxEgT/9YHdKgEFkuIdx0wtOs3284X5Sy1DIzSKyha1Wvb?=
 =?us-ascii?Q?5lIwXHNpCzDGteh+NNDJDMgyhoCir2grTB5lCTASqmgA7yTF1RXwBNFaxgCs?=
 =?us-ascii?Q?D1xHH5AnpAoB6UZjT+O+We9h+86MSC1O0n8XoGuVeE0HOfgANixul/TLPI6K?=
 =?us-ascii?Q?auVkCXLHZl27+c6+KnDWfzW3LYBS/PDFkAdFKE+v2pXpxUWfn6sU24hNpQD+?=
 =?us-ascii?Q?5VW2EZeiYjXccjlK264HkF/N59FRBhJ6w6cNWO2Ois75oudOvav6quNtR25D?=
 =?us-ascii?Q?ZHFaEqADtZ1a0Skx6ahiMGky2R8JbVAS6cXf03t31fvsNN3TNLgOCXvcz31T?=
 =?us-ascii?Q?4xJgy3wQnS+jWkh6wYZ6nZI93UsnVKcQtwKXYoUZd+60cMdGu13C734Zg2D9?=
 =?us-ascii?Q?jF5oWh0XJTCb6a44eTbUSNh0etU+cQ1UcWC5SnzxhAti+JdQdnKEdtFXvuIQ?=
 =?us-ascii?Q?X3hniPQd/+Ut+6OBPQj96KD97rMJT2ESoxEvBLZu17deeIHa3+NfrvKqKkSF?=
 =?us-ascii?Q?hNZtiSLVlHdIaYNM3V6Jr+whnFT1KGXQ5LJRiJvfGjgaON7cgbd6cHhM0NQ1?=
 =?us-ascii?Q?Vz3EYXII2KuCCP1gznxyWFTiXgyElMKg5VAPPapowOeM66q99oVCzHTWiN5Y?=
 =?us-ascii?Q?pA5I9cq1Aigcl0r2yCotYFwcJUHTyJ7EDVwYJRdWMFsiDB0l5Fa4UkaWoHgc?=
 =?us-ascii?Q?BXXQPSj6MTGxxMOG24fYAK+vXyTUDKDAZ4JCGBZNuza9u1FmNluv3hhsuN1w?=
 =?us-ascii?Q?s3RJN4uz79dFQHA3uRWGBY10FD6sbvgT81cK/LUzSXdncvb6G8Eu1xN53Rka?=
 =?us-ascii?Q?djwVoE3ZVE9UykB8CIsQht2iVBnOKLcW4ZPq9QFkf04HoofoNhtdwYk6PZai?=
 =?us-ascii?Q?YsjlhfIWj7+M7S/MgLE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:48:40.1380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9d7b71-ad7f-4499-6e7e-08de1b099af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

A region is always bound to a root decoder. The region's associated
root decoder is often needed. Add it to struct cxl_region.

This simplifies the code by removing dynamic lookups and the root
decoder argument from the function argument list where possible.

Patch is a prerequisite to implement address translation which uses
struct cxl_region to store all relevant region and interleaving
parameters. It changes the argument list of __construct_region() in
preparation of adding a context argument. Additionally the arg list of
cxl_region_attach_position() is simplified and the use of
to_cxl_root_decoder() removed, which always reconstructs and checks
the pointer. The pointer never changes and is frequently used. Code
becomes more readable as this amphazises the binding between both
objects.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 37 +++++++++++++++++++------------------
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..45b1386a18d7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -495,9 +495,9 @@ static ssize_t interleave_ways_store(struct device *dev,
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
@@ -558,9 +558,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
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
@@ -634,7 +634,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -1327,7 +1327,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
@@ -1686,10 +1686,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
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
@@ -1926,7 +1926,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2031,8 +2031,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2055,7 +2054,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2351,8 +2350,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2435,10 +2434,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
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
@@ -2937,7 +2938,7 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
@@ -3013,7 +3014,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u64 bits_upper, bits_lower;
@@ -3404,7 +3405,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3440,9 +3441,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
 			      struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
@@ -3534,7 +3535,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, cxled);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..19b8b62a1322 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -521,6 +521,7 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -534,6 +535,7 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
-- 
2.47.3

