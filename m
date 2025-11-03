Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B17320CA2;
	Mon,  3 Nov 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195757; cv=fail; b=VnzEUm7GpGRhtWTpwB+8lImWnFB4KZZoYkIonqV8/N2dY7P5s6N56DzsfZczfwRaAS+ZWo1PT0ZdhLKqhz8oqDKLzEM67b24TOUkGyNHNcTSFxr/blGIPm5KCwWH5w0TP1gQgkEbfVXkrLSbMEY557uaViin18w2aGgAMWm0+Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195757; c=relaxed/simple;
	bh=3y8WKraqwzqB/l4/F3tZUzCLqfK8w0WnZbdrxov5uqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+V1JU943ctags1XJVT0THYmvMw+hibOhaYxxrMLe7iQf8RIKJfzlG6e/k52h+5c+UqcsZKpThR+mGvVuX+kdVRAAZdVLWkijItsuG0MppnF0i5EFK4uf97061tjbNfJ7bSEOmJoSueG75WjDLDBegx3cocXa0nH6aa4XjpQITw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1xU5NJTh; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1xU5NJTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8JqKJoATVxBPinnHrpqyaER9YZRCixBZCM1zenpbwy13NILP+m1K2oHVzG3Oo93vlU/yYbwnGKgbj1aJWtbiP1jnTTT5T1rdT9wGlHqDyrCDv3zYPY4/fspxZyOoKE5HPWxM18lZmEb5JW6DoiMQjpifBxVsHD81RaQ/X7VehHooc77Htd9+nsdgaNOV12vr6syrxEzbYKjlK89ZUOWpSBi4//1mjTurNf2LpxxQnjyAVwGUrRzIhJnA7HYB8C94wJTWj9X56eQFT140sdYet0U3V6gLCmCkExe/zI4k5xlRty79pnSY1sFK8ztDZrhwOhm+Kcm/+6ZviNRGO69yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NnRhJKGdnAmUdR0DpgqMkM/UbLnSsc4GTGxKMVgqNY=;
 b=qKUv38pMNW9VZe9Jk84uU0PwMYCrfRW2zreJXk1FxCY7xKoRQVzwaHCthX9V1bS3ni3Q/frl/dRFnWQjuDA5r46WjOht63BLsWKR6o2yBXWcYEQKqT9whqF1sfyqG4BpiGNbV+BBAl2nu+QJJ7CEAOrqRU6XWPumb3Xe15adLoxVAEddi6yfPc6dHw7RNRQ49m8ebp/QkvbMHoW1KLgT8TqDOUSMxTnWaDr9kUh7DDw+4Iw4sPLXDX2qGa7z9PTzQhw3cBCviUEVY+CCbnkoxcAw/1B4IAyS9EpRczlQyairJ4+NaB5vK+jfuDK3ZYoijq6UxFyTEL2jRH9qOe350A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NnRhJKGdnAmUdR0DpgqMkM/UbLnSsc4GTGxKMVgqNY=;
 b=1xU5NJThPfo11cpgGqIAMA2nye5AU2IUbYuLVFQIg2xzWzAWtw+QxyMlKLsmlWEc1vTFq+mb5hq3EJlJoj2SrXDEBholaDYYHvdWMz2t8xThaAfvKU8FjPMzPLT9niRqe+Rtk/Lj/rAh3lWlI0eBj18+vSLrGCee4c68ESpiUf4=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:49:10 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::df) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:10 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:05 -0800
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
Subject: [PATCH v4 06/14] cxl/region: Separate region parameter setup and region construction
Date: Mon, 3 Nov 2025 19:47:47 +0100
Message-ID: <20251103184804.509762-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 442524a6-63ae-408f-3195-08de1b09ad44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z8JmoWNYtoJILocaGkjFTW9uuQvgZV1KDRXH4FrCJykh2jOBELBs5YQnv9aP?=
 =?us-ascii?Q?nHYY8lWvZOoG7BPZe09BWl5234er13kvP4MV1Za+1MutAtqur7cqyyGG0F27?=
 =?us-ascii?Q?KZhbQg8y8VPMOL9+POBlTScuJbtjuntXpx/NJNXIyc4KcmDwIaUa8Xn4SOUO?=
 =?us-ascii?Q?bhbySIiqU/zKWlDocQXYssq4QNwxLPC7OR8kcqrcMuO45l3s99vkrVxg4GP+?=
 =?us-ascii?Q?o4FPEW5LcTavghhjBP4vCfJR0cmIg7yb1KqIqSMG8SjHgm2G8XJJBJzIr4Bk?=
 =?us-ascii?Q?OKC14kG36sLcomdgVLfA5rwIVJJKnzEtj4scJJ7KWbKr3JoRK6EJHwHFLmWl?=
 =?us-ascii?Q?LRPWvAeDEBtEcOssPCPfjNBA9zysAlmn8wcbrRZwtwIznbCWB6xfN5ANRBBb?=
 =?us-ascii?Q?xBXUkvpVwb8ENL48wB0z1pgHUBDWvRrkQNp/kszhi1CXrrfy7JY4P6kf7dMl?=
 =?us-ascii?Q?l4EE6pl7QPc9ExXpW7ZaOdI68uNIm1GQwYXJwitHSz8ow7O+W5F/+5+Znquz?=
 =?us-ascii?Q?OmTCp2B3bxhc0M61up5BYphfC+21HAhKDHuJYQS5/caOFjXaf0Z+3zt7zMdQ?=
 =?us-ascii?Q?hrAvaZs5bNNv+PM2z5YmTlBkTXLLYHHowdhKQXxeMtsV4VdJlHCHyOn5/XCs?=
 =?us-ascii?Q?NfUOz+1nXrjh07h+F+E6S1JwUPUNzbOQvKUYcV2d6mtCoyXcLRSlyquOR1Gc?=
 =?us-ascii?Q?NWudovci6xjhzGHit4J3tROybDkqNwYZF8GHlXT6w0LiLjrnYriR+B5F/oVX?=
 =?us-ascii?Q?7hRURilv9y7hbLLdu/jpunqInefqrZHonq/RYn6h6v43kdxLPwHlxXuhGqkq?=
 =?us-ascii?Q?CzNN1R/LWU2o02iFKAucE7osd3P4tpeLTGvKmpON5vTh9DsqWyP9LdRANMQ5?=
 =?us-ascii?Q?haExWFE7OeL07sRzy/76IoyVOu1t1j5fVDb3gNS10box3ugaScYMlxmwTqg+?=
 =?us-ascii?Q?AT8QkM1Z5w4zt+PIlGuwNWQV+pZZR3ij84sEnO/tOBjtYg6owcww1ZgwVKXz?=
 =?us-ascii?Q?5qtR6yX6AJPMzckL+DzSYShGrrv0LJeUHGJqD0SaIE73SLi+Osy0hFXmZQ/M?=
 =?us-ascii?Q?M3o6LYdA/hL9aMQJjlGHCPVKpZrjaEKevdq0wkWunGmaejo1rAseeV6d/IfP?=
 =?us-ascii?Q?A6csXtiWHmOJvkRXB7V/Q6ywNRwLTRpvjZGKiblK4ajb+fywcFMQLTRS9jS6?=
 =?us-ascii?Q?QA24yKTiremWlQuwwNJ9i1TEZkC1saq22E3KXVAmYr7sM/P3QtiFJ+bR1T0y?=
 =?us-ascii?Q?+jOxFXvNgflBBRhs3Jtd8hIU6FoLsA+mEASgsiaYQaqLXnOeJ2F40aca8tog?=
 =?us-ascii?Q?BnOYhNTO2ZGFb+zV+f7re42vzFnL7Bvy9ELdBUuM2c6IAw4Odt/eJ2Izr6Cr?=
 =?us-ascii?Q?r4UWHY9npX+yLL6HboEM4Y6bgMhATIMeDKoTRX9/ccTK98YI4gV52s4r7ff/?=
 =?us-ascii?Q?Y/9A/KebVCm/W56jRknPICp/QdiyAmDtZkCVoDnT4ikvRjmJM3DUxdoBUU9P?=
 =?us-ascii?Q?C+26Z1bYcqJwWa5BTuGVWJE3k3oFM68kZmvwrlcMlWQ30l4btCLKWxubJSvS?=
 =?us-ascii?Q?B1MfDre7F0G3SS5xJos=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:10.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442524a6-63ae-408f-3195-08de1b09ad44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

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
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/core.h   |  9 +++++++++
 drivers/cxl/core/region.c | 32 +++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..2bc37f3aee21 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -19,6 +19,15 @@ enum cxl_detach_mode {
 };
 
 #ifdef CONFIG_CXL_REGION
+
+struct cxl_region_context {
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+};
+
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
 extern struct device_attribute dev_attr_delete_region;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d3557d9d5b0f..2cfc29a2b588 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3448,11 +3448,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_endpoint_decoder *cxled)
+			      struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa_range = &cxled->cxld.hpa_range;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
+	struct range *hpa_range = &ctx->hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3501,8 +3502,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3522,9 +3523,10 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	int rc, part = READ_ONCE(cxled->part);
@@ -3543,7 +3545,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3568,11 +3570,19 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa_range = &cxled->cxld.hpa_range;
+	struct cxl_region_context ctx;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
 
+	ctx = (struct cxl_region_context) {
+		.cxled = cxled,
+		.cxlmd = cxled_to_memdev(cxled),
+		.hpa_range = cxled->cxld.hpa_range,
+		.interleave_ways = cxled->cxld.interleave_ways,
+		.interleave_granularity = cxled->cxld.interleave_granularity,
+	};
+
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
 		cxl_find_root_decoder(cxled);
 	if (!cxlrd)
@@ -3585,9 +3595,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

