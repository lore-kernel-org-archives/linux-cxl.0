Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A33191C4;
	Wed, 14 Jan 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409368; cv=fail; b=OmYdYvQkv+9Fio/Qjvn/HZhZCZg5IC/a0Dfibv4XtPLtM86B0yGeHW+ni6WhpyCorroRP2K1v3PFrHkCLjZhQ3YSUp9+cRZ7QUzOQ2QicrtKuxyt6clzUXEOQnL90v/KTVmJ2DaVN9ac6dnc47XT1LLyD0y2sopsC2bu8ireC3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409368; c=relaxed/simple;
	bh=aZczS4SSNZg5/Hu1dWEOcZmKrLE2wK9qQ8ly+H47qDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5WBCbdtwe+f6RD6ZPrieOoWjiNwODVqI196Ajj6T7qvTY0/kwJrnIh3PlQRMM9khsnI9PZ7pPrCr+uQH6jxXtFVB/nlzvxB0GgcQAdDM3kZp4RDUGKBdaC2qBPUAsY7py5lrRg7VbOq/sr2WTHMwrWcidPfUVh4rwJj8ZBBH+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VB/gjDX8; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VB/gjDX8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acy9Qzm+o3/L1cvu/ln9C9tmy/31RxtME+CGHaMIjcWR6R2A2SLxKdeyRjjsjJ1boeLTTIFTF+UIDNGNzmWWT4nnsD+CmWYPW0vfKKW2TgJqx/DaC3S8icfZaHA+sb4QlfBnnf2kxE1/xcBDMQra+s2T12e7wMsbrB53sQhNsHMa+XNfVIYkteLp73XSIKtgxKwDHXCypW6/4ptBs+6n13OjR9EIjLddMymMns94AKOkm0ufS/UkKHul2Ai5TxfLJyegWLXk0XGeb+/FdC+w7KWiCRP5Jzqcg+kER/hnpBVDSfsZGmmAHM7UeksWhCFoPXzNRbdzfRkB6a5gUY6xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6oR9AhquAkXNwE9hPP181BvC3Tkun2/4g9hZHsDceQ=;
 b=qrNUrUbOITe+iei2xLOHVU6EZ0Ta7ygIRMvQFiesnH4VvbABHzH1WPGxp+oKa3AtP6N5CkBu3Piyks0fQDOqTMHYp1AcMysYooVWFqR69Oz8viw2PaZ7muxXT5H11z9yYXGx8LNEP1dEI6XRw5LxhZxg6QCtQ/7a1YDwNVPinIeliQyE1rZlWIEUqKLHQbc2w8bU9Vv+i+OFnX021Z8/qDKIcVOtTZKAjAyghkBPwRlleU951DsExkBqCkcrZf1vdnu0L6Tp3pHArSQQNdS9qc63ylBy+ahCUCsoKZ12hmBOfdFqNHwgMjCX9cbX1UvnZHSwokY0zNuJROrvajD/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6oR9AhquAkXNwE9hPP181BvC3Tkun2/4g9hZHsDceQ=;
 b=VB/gjDX8eYHRM9KeyrIpYsFgCWKI9CsbzygVAC9o5CmGt5dkj3Ny4l/HqSRFOi+sZwEolR6hfBvS/BtTjiiKlg1Iz1LbYq/WDhETBfRRrPk3KWWfTFvSXpdNUjCGMQjlvjW6244RVEGgzA1vnBT71cOCKum0zjOJ0rhEO3r+Dm8=
Received: from PH8P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::23)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:49:22 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::11) by PH8P221CA0006.outlook.office365.com
 (2603:10b6:510:2d8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:22 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:17 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 05/13] cxl/region: Separate region parameter setup and region construction
Date: Wed, 14 Jan 2026 17:48:21 +0100
Message-ID: <20260114164837.1076338-6-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f1053b45-4674-406b-dc1a-08de538cde2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CikRZ9TR3PHa148NsHIrEDfdSLudon9PjUmQhP35A2OporDDEhYh9bJpZ86i?=
 =?us-ascii?Q?Yp5+/EidfB45upM42r/RrBTQ4HwLptFbdIb/NKXvz4zjz/nsVCx/80Sd8BD9?=
 =?us-ascii?Q?stJtIrEkaYcew42BLdLvEZA9ZXzPQ4/ZM7ZLaYhh8LWVcj8Veovdcq4riwIT?=
 =?us-ascii?Q?vCkd520HBVdzHxIBL8y6uiHzN+D0VXp4Iy/ArfyarUzLUYNLvk+UaU6nXUBQ?=
 =?us-ascii?Q?CImkJisKixwBuM0aqU5/PO70Wi6maicv42Cf5LSEnIbqpfkHUWb62hmiz+G+?=
 =?us-ascii?Q?rXXPRPHLb5Hzucgb3sM2Av+F7iUvvSY9amhJiJ4Eat3vo+ILNjP7OgM6uzMk?=
 =?us-ascii?Q?AkK3jTAZ/2mJ1/QC24vAGxytAlnRA7I0KibnxBVMqOaW6FZ4/jrgHwLgyPPC?=
 =?us-ascii?Q?7t2YGpSzwco9U5NAjJeAqtQ3YjsdDLLEjFskgP2IO5nNIniDwXJK35iPXF3p?=
 =?us-ascii?Q?yI/PlNi1ZjB5FQtZGnnTngBS3iyawNJpBW3dATbApqbNKOJS8oYOtUU+0LCd?=
 =?us-ascii?Q?Cs++nt3807RdVWRSzB52wuHDJwzUta5quh/OR8+IGz+edLjkDfYaSdVc3SPI?=
 =?us-ascii?Q?xPXLtCANVhStwZnz/8hnPxpqgZsx8Ja0K1IBuw8b1JRB4EXvVSGitm0ZvgQu?=
 =?us-ascii?Q?2mMpHz+jYd9CZt4nMeZ2sUd4cV85aAM9L+cChVjVxEBrTEII9dKgCCqyPlp9?=
 =?us-ascii?Q?VesEfSJ/Ik9i7jqkxcvtjr239W+Ff9hGuvMvwHQrSY6LUM3WWtp/DHl8/66m?=
 =?us-ascii?Q?PGtldXwYh6NqiHjsaZNmkD6K5IpaiauyH0cwz8hQX2Gtu0SiVb16WpcaXGFg?=
 =?us-ascii?Q?SftBE6COJsS/8EhIBvtjGnALtFVBP72YLePcILwIH39fSSHK9WKXt8AwMSF9?=
 =?us-ascii?Q?JEwEpfkUOwxlkgii+ldw17+X4HzFpPBt6gugAGZ55nsujHvN+dP0G3IRexix?=
 =?us-ascii?Q?Q9W/mfG6xxI/sSseJJqhtQxEItYSqGujImHg8ZPETunzKzklOCFWQGs/wUKS?=
 =?us-ascii?Q?2ezQ/P+RVTGPaMl9kh7nOkP2NxBeVsaKBzXC7IofI6zEq2Oov0dyeeJVp5XI?=
 =?us-ascii?Q?9jZBK9M8kpHR42giiUYY0Kf6eB1Fz1CahjbmE/5w7nR4BbgviC6dN4UqTJ5t?=
 =?us-ascii?Q?jdxyp+F4Pux5GoINGtST6yqrfD4sFHpU+LpAV7Yt+hwJNqjgKE7a7zJC9PY5?=
 =?us-ascii?Q?b/tQg7kHiIC1bHVgcUtcnaypXG/kNa3/TCBMwJsG3gtQuIjyaDN311mROxql?=
 =?us-ascii?Q?fERvmem4BFWIwNqXb1R1dPJ58uHrQYRsqZVlTOHgf+p4nxm12Szit2Oijb0y?=
 =?us-ascii?Q?pgn4ImE4PP9thttDIoPVyk0tmxgBYMrWxHXKVIT8AcY0OsHln7TYOzZ6Q+qY?=
 =?us-ascii?Q?vdUyB/yxvwYcXhkHo7GrIAFHfN8hFAiEprZ0mUxwVYfFrAIbvgN9Y0gND9As?=
 =?us-ascii?Q?nYb9PE4c7p1sYXWycBUDX5QKF/eYYGVc5QJz1kDCJjQRk6vzXIPnHk2AKAli?=
 =?us-ascii?Q?8bjBdI5Qa/sofpSHzrDczb/UU3SyNaA/XVT0BmQPw2vWpF+3RB3P/hipPXn1?=
 =?us-ascii?Q?gCJeXqLzw1kiP8pSNdXW68Zk9Kaqs5AxHaASqRSgszu9uv7IB+uA7HO8/w5F?=
 =?us-ascii?Q?EKhEQFPzGAOKcOXC2edyyA5/UGKpVtgo4F31tTOTN9yWwzaTucDynETUPnTJ?=
 =?us-ascii?Q?YhGbdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:22.0333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1053b45-4674-406b-dc1a-08de538cde2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

To construct a region, the region parameters such as address range and
interleaving config need to be determined. This is done while
constructing the region by inspecting the endpoint decoder
configuration. The endpoint decoder is passed as a function argument.

With address translation the endpoint decoder data is no longer
sufficient to extract the region parameters as some of the information
is obtained using other methods such as using firmware calls.

In a first step, separate code to determine the region parameters from
the region construction. Temporarily store all the data to create the
region in the new struct cxl_region_context. Once the region data is
determined and struct cxl_region_context is filled, construct the
region.

Patch is a prerequisite to implement address translation. The code
separation helps to later extend it to determine region parameters
using other methods as needed, esp. to support address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/core.h   |  8 ++++++++
 drivers/cxl/core/region.c | 27 ++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..ae9e1bb51562 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -19,6 +19,14 @@ enum cxl_detach_mode {
 };
 
 #ifdef CONFIG_CXL_REGION
+
+struct cxl_region_context {
+	struct cxl_endpoint_decoder *cxled;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+};
+
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
 extern struct device_attribute dev_attr_delete_region;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 04c3ff66ec81..5ae77e9feb4d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3565,11 +3565,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_endpoint_decoder *cxled)
+			      struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa_range = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &ctx->hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3622,8 +3623,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3643,8 +3644,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3664,7 +3666,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3689,11 +3691,18 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa_range = &cxled->cxld.hpa_range;
+	struct cxl_region_context ctx;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
 
+	ctx = (struct cxl_region_context) {
+		.cxled = cxled,
+		.hpa_range = cxled->cxld.hpa_range,
+		.interleave_ways = cxled->cxld.interleave_ways,
+		.interleave_granularity = cxled->cxld.interleave_granularity,
+	};
+
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
 		cxl_find_root_decoder(cxled);
 	if (!cxlrd)
@@ -3706,9 +3715,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa_range);
+		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
 	if (!cxlr)
-		cxlr = construct_region(cxlrd, cxled);
+		cxlr = construct_region(cxlrd, &ctx);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
-- 
2.47.3

