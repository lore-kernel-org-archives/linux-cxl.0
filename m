Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F335E52F;
	Fri, 14 Nov 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156418; cv=fail; b=I19FiRn4kQjVu9o74tEcv4DdMBODzJDoG9BzqJ4F4Ib3h4c3tLh2288ybB7UDQS0Y5kPzY2hZQMiBKPZxnZeQ0lppSx7C3wx/lLNptynsjz4AfdQd/TOnwwo4J38CYyRe58MbEBKhhUoQUbtMIKUPV64oCSCOlV/nSNebU5f/Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156418; c=relaxed/simple;
	bh=NndT+k3MCNINVWqo3EPl3NPWWiToLoamysBBp6eJQKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ad7G5rglMDpvAFrFVHQNtgtVp894eQIi2OWjUFpL0W64FJFXKtELRwFwLI60LRINE2iEaNv6XV4GoyLDN+qq1pnl/NgA/JMs7X3Pe/CkFYefDkZHImfk40sO+TlsF5DnKQy+EcY0R0OcFe+87GP2RyOEdriuD8BN9bz+V/pirKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qYRpsvHF; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qYRpsvHF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmPTmRMX/4xcDblJ634Qap7pb9p5+uCISM6ltOwjxARoWnO+Kxig/HY74HP7Zzdn3uqKDLKx2VOYCQQGZjiNPAsweHqTj0aVXbmUk/HTYJ7qcaSP/tWyq6RdyWP2lvxfLhg8aONWfinor32nAs9P021GBQzV16EdbtGLIy3pyWhYlNb9Ur8zvLDYKapwWCMG6qFuNr5Q1HLH6r9I6sw/f99y8jbCnNuHsviAI4V1Kr46FEMpkG9AW2pcVEPhVBM901cEVfFW95DiRJ7VUUotyqEZ3jaTxDLeaMzPlCQqIf2pJorYV9FjR7ZwbEb40ubSOZr7vVBEtWZPrPNgDtaJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM1vnZU7MoOj5AeEB3TDs69T1a55Gy2TFxe8IBC6cLA=;
 b=LhAKzcbLFrZkdy8uGVo6tXwb8J43sV2XPEmSRCPiEl2iih9kS4TttGWZvUqUPMh0cdxXz/Nr6BsfF/WAmbXcxFNU9ki6JJGqPbKcYHfBRC3v07kVUYwWSCMUN5Bg7nczYvcejbzZOU9QJL9L0w0Pkq+zC9cJp0AYugS/qlrnJeflwY7Zyz6Wf0KdB0vBhGMdU6zSGTYr+yMACehCFgtecWW6WSNtJJNhb84KvgDSrOY6hlEvlKODpB0A4+ZmIP1rlCY6t8OLo8Ro/4+65CCMXX8iLKkPe4PRNlciReMrrHgKbI147G+OXbGbn9gkqo8uywPLNuhkGOLgTq34cOx9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM1vnZU7MoOj5AeEB3TDs69T1a55Gy2TFxe8IBC6cLA=;
 b=qYRpsvHFsl4iC4naxbrrVL+I957YUayG9Iui8dG+Hg0dZaAJZ857wpjryRrx+KIWZ4jJ2k1ci2x4tBhXzmaMx5pWnt06Qlhay6Re/ahGgAmHuqRsQokueo4CBmDPtFzFuy9CLIRp0x+O03WDy0bRPW3f8Ual5XK6CbuMFvXICCM=
Received: from CH5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:1f1::20)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 21:40:08 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::8d) by CH5PR03CA0010.outlook.office365.com
 (2603:10b6:610:1f1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:06 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:01 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 05/11] cxl/region: Separate region parameter setup and region construction
Date: Fri, 14 Nov 2025 22:39:18 +0100
Message-ID: <20251114213931.30754-6-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: b71c306c-4fed-4fa7-0488-08de23c660c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoH5t6cl1xX8JTdrmnzVeWGV9tuM3clCRPpcqvdQV85k8IRvmkFYSHDAn2jU?=
 =?us-ascii?Q?zxAQYh5k2zNPHWBwbAdzUJoaO2jTeacZZBfH4kQ5Z5fnkk9G+SWEaGgqfZwi?=
 =?us-ascii?Q?6yOVygdcsz2wRv+7x9/V97iMJrPs7umJnGWXE2JQeW1Z866cBM8Fi1ygE6MO?=
 =?us-ascii?Q?WNDO+I4DeuRWYuki3hw7dTr1gM4m1SD80ZmYbixRylhVV9pJGzH0ENFWUwHq?=
 =?us-ascii?Q?RFiLlb1BlvOJO+vLYMZuLhJYY7IQJMpJO6SS3hw8H2/BEAAuqbwbkBbnj5qb?=
 =?us-ascii?Q?SR6wsKM1/fKNk7VolQrar8v+W7mKPTfselFJpVsXXkHyqN7aK+jrw212eoWH?=
 =?us-ascii?Q?IH+uXZ9mcJXraJWGrKXNva2bR0/QbfwZ355MJx8vjWqUneic5ECRpIm1y/0v?=
 =?us-ascii?Q?BAQ8vq4lyMg4T0a9EC0IXFmb6zN85k31M+3HvCJg5w7BSCtfaueJwtZWjqB8?=
 =?us-ascii?Q?HT5jhu+cYTEjdTC6ptLk05AR+LJXJD3lXdQK1wnqvDHAjswXY9L/kJASYtTX?=
 =?us-ascii?Q?5gnjU33Tr44KxpxgFlBqxbA2gA+ur+1xxuNNV2qXWfbzbbagP2YUwISrZUjW?=
 =?us-ascii?Q?09LS8FKsUDr7znT6PoE+PVR6W2lcWQrV7km/hLdl3dBBb/CjXheT+cAIkdwv?=
 =?us-ascii?Q?MxN78amTB5ESTVx/1ggxKi/lgivRgufA9uc7dZ/U0iFgpV07UuOyN1dWykfO?=
 =?us-ascii?Q?CZVI5I//ZPi67XmJT85gwJYX4Yttann5YmUkzAbteFrnTh8YUWxB+FWcBtpk?=
 =?us-ascii?Q?iuNHhX31KuhTXSdtYo3c0FQZRQHfCtOJrvCnuevsXnwVMjwGigTnZ9xPBfHz?=
 =?us-ascii?Q?IUoDS2JgK1IVtEh2cLlhGPSeWORMnaR2Q0fVFCCWh2WJZ2IbrrXgm641qYld?=
 =?us-ascii?Q?ihKhSf0X8wzzhRJscbY4PhlgxPRXezc7yfRzEiHmiGVU5wrbmAHakyF6EJrD?=
 =?us-ascii?Q?8BHjETdH2c+QZd9kd+GLCPhtL/JFSC2AfI6zbX28gkwbz/heFq6E4C4Db60w?=
 =?us-ascii?Q?CO0PjzgAkAmJyh5FJBevaZmcPlyG8vD6B2t55l1lDBp6MYO6QVX1nUizE49z?=
 =?us-ascii?Q?2WxpClQxT5S4r5NqXMwRiDrTOQdBLGUYzC47IhJbTvONKQ88SkOkY+FG4vqE?=
 =?us-ascii?Q?aAl7LlpLP3ZRKsFH/oOAQ00JLbEHChLrlIa1hrZsReUHWCng300HvEqULlkD?=
 =?us-ascii?Q?xV/HiR/TbvXgBG6JYSrICI0l1ilOh9OAKnyjJfJt1M2seTd/m+tKr8JOgNaU?=
 =?us-ascii?Q?mBllcRI2fKR/T83uhI/gOxOS/3afSCAxZIcBC7fGKQpkhwzNcpn7T6ic3D3R?=
 =?us-ascii?Q?eq0eN9zpNx1bB/IDW/Zuu36yi//SpkEwp4PqhH0ReMfXRh0ar8o5+F7RM5ku?=
 =?us-ascii?Q?4mgun/s7AHOsVFXdVRE3ENXULa1CSlzkDnZ5nxoVoj7Gyp2SQlNs4ijcobCV?=
 =?us-ascii?Q?dNZU1DuVlB9ZDFxqV+JuQ7hXomKAdNuTcp1ldINXkaGpqNAcI1KfFvv1ckQj?=
 =?us-ascii?Q?+QN0dGsZQ9M2q36PMzfKSguzDb94yucGWj0eEpIIdCp7nt+vRpozocF7HMaj?=
 =?us-ascii?Q?L9UB15bJslxeS5DM44I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:06.6328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71c306c-4fed-4fa7-0488-08de23c660c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

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
index 13b4e27248cf..52924006a10f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3436,11 +3436,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
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
@@ -3489,8 +3490,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3510,8 +3511,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3531,7 +3533,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3556,11 +3558,18 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
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
@@ -3573,9 +3582,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

