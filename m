Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A92C08DB;
	Tue, 15 Jul 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606781; cv=fail; b=fIy5yDEcqV/wBjZ6gg9l8Pw6WuvLMGKzsSZ/a4SKBAs7TP9OuGx1Pe9sDKMiSudt8U36k2eheehif4toCJXvlA5s0gZZ9wiCb1k+KJKriuPOxnU+YQ2idPvZJorKwdBcnTZoX9/oeC1zdAN4LND7Oi3PEc4HqkcFUEVaOE97Qeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606781; c=relaxed/simple;
	bh=7rkOzc0pNXYw32ET4EPBwamRXsisiAG7bVOSj00C7mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUYGqddxK9szPir7vbO2GzIr3FHXvOv7yuaxU9+mSSXxTfHICaNF7OyHHBtdPBCNq8whckBdrmdLNXbHoVVlaDCEssuIBAoe9qBRucqnppUMHjpNHTpufN0Zz3481/9nLFpoofzDu2z5lKwsUTMNAwD2Wi1OOVjyoAr+4e5kP2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JQ98j7dl; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQ98j7dl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdIZL9n4LZ+aPNvC1oN9riJWAsSwRGGWfXWCYUNmdKOjAMIDry/irOOBlmBFKSxjVH0i7IzJGf2BlD7XxTrlcvnTNeHewdbi7WLj1UmVnnOpVZxTUdESukqg4b51rG3nYZCb9stZRBinlnxuj4Nan8KZyocdoS7S5tD0mJa5dFeigMv6dhgCN9v0lCoaIk6uR8rH49A3OYHLVyKU43WkMuBzCuKNo7DlGyfBPTE6TSnxQkZ9nqgtoGObK15/DAg6uHS0TBTwU8GNOmbX1HOXJ50cKzwKBPe0eihunJed7SlQKBziJKsDYVQgK0hAMRxkx7Wtqd3K1uMTozi0ymhseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ymm3+6bxzLkLKlgBdQAgUzL3ALUtBl5vYa/b2KdOMA=;
 b=dEjDi26aWrbiRxDLIPU5pS47jAS1oOet12lL8XjRSsOgJe/njVC5akyCgD+AFLriPXE3KCSECE0lXDAYUcxZZ+PAz32iC9fyIumcqpcMVb3pEROtAloeO4+k4gL5ctVAwjvZU+8s4caq02QCoHi3UCQRuIP7/FiGAP+2Gle1uN/g+glGci3l/jwejdVGezXeB192TSmp6Ax/CH6cJwdZKdPisJ2WwQuqFidpI5AcZ/wf+LObDzYs7dldWu4ACwNvcjZ+l0eXOC/k+gbV2Eo11kBGPNzVcUCUmQd/oA+6JWcZYGsTGPHlPM9EX33/PzAsUA+DzWbj6+W3u9tC92NFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ymm3+6bxzLkLKlgBdQAgUzL3ALUtBl5vYa/b2KdOMA=;
 b=JQ98j7dlYoJhjJixd3ypKGtTclY96yiH4kMktpbtWYHN0fjEpIjtnMZFot+WHFf+u1rquvQySDnxfu6hTO5RIPQPYJWbX38G0Sq9R0z6TlIsyRaHQe36lRlYX17pcBHMQeR483EtYP0xO6SYENudJ1MP+FRMZjZo8Obj2cj+iTs=
Received: from BN8PR15CA0072.namprd15.prod.outlook.com (2603:10b6:408:80::49)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 19:12:57 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::17) by BN8PR15CA0072.outlook.office365.com
 (2603:10b6:408:80::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 19:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:54 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 12/20] cxl/region: Remove region creation code from construct_region()
Date: Tue, 15 Jul 2025 21:11:35 +0200
Message-ID: <20250715191143.1023512-13-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f479979-32fc-4f05-6744-08ddc3d39bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYzkfQD0vKhd8WHD0oFBmW8gc0lJ2xjO8BEf/35bkBANHbFOHtq22nhSGHYn?=
 =?us-ascii?Q?AGsaF7hZIDb/E54OIAp2ZK4uxGzyoHi376RO57S8qavKcI02D2/D/lrsSINl?=
 =?us-ascii?Q?Rr1pX4nDYlfZzPaDjBkYcX3DWPcYemuBSgSDWc5PFsJReJuI5v3HxYN2fovJ?=
 =?us-ascii?Q?XlNGDFCkyfcgW9LdrY6tDSUk32NvKjWIOOPdNcJkWgYUbEkBmYlrnZJGrcnS?=
 =?us-ascii?Q?DUUNyu6TwvilQfna3vmL3YeNfRJjS1HrCLcXhoUvxkBQq7wt3GssGgTCVDZ0?=
 =?us-ascii?Q?rkkB/SuUI5x3WLgOojdlO1SGTSTMtIUAoxx/3fIpr0Lsum4xVrWK7hxOfp0L?=
 =?us-ascii?Q?/CtFtEYlRo9qYQFHUJguIRUrX/aDQ8hMAYGgF7EHDGWzvSYM6NCiuobdTKQJ?=
 =?us-ascii?Q?IxWLxcf6b5v5DyRLKBpP4yjAfVIJeeG2pxngHo4NkdSaRPDd9cF0VtOcGMc7?=
 =?us-ascii?Q?19XbsLR19K3Y3VOvVRgRmIfurnPCzd20irwiIXkf0NtoCrAFa7ZVXydugq1D?=
 =?us-ascii?Q?A6uHg4e29mNaLJVeM0b2ZPgtvV3LateT91MpCWhnzyywfnbaeAvCkRf+iZw0?=
 =?us-ascii?Q?DlS9Uyu2Fml3l70+HFjAi1f3JSH1gVaoi4VyMKPwGV8gO7cU/4cE1bcUT5Tk?=
 =?us-ascii?Q?00BHyUIpIyOzmGoYYhQ9ZpSHy9K4czSbxsi2pjJM0D2GCBZYme4hjzEEwLZb?=
 =?us-ascii?Q?0GHX30FSDrTlggSBmhm0FKYf0xjpRPpEtXkmmfHxMhLklUYnNCPkIRZvaq2G?=
 =?us-ascii?Q?qyi0+bBt90dgrohVcyhxVo3TAyBBShKOOpOyazepr21GQ2WUZfTjH+D/zB5F?=
 =?us-ascii?Q?Vb40rnJbWQ9xunf7Xc21a32E6vNJ+JRxheRdE/YtrnnQptu6ewGaplv5qeb/?=
 =?us-ascii?Q?q/vEvmT7MJ7v4/KcVAc6gZiGsDiCCipA1mWNDd29dcTlnKRynoROkmU5ur3H?=
 =?us-ascii?Q?aCsWI1S/aKyMgEdTHe/+1JuNip2jSdoVq6nCkxOMUi9cotaEK2BfVOF0noC9?=
 =?us-ascii?Q?DNrH7lb6NiNjs0buji/MlU+Hh67c7L45DcP6gbOp2haDG/6OLsHp4A/ChEi0?=
 =?us-ascii?Q?/2S9ErqlZOcQUad9Rp1M4guH5uLX+Q0Uf4EMAuwnjmM16lQa2meXC7FCIHtE?=
 =?us-ascii?Q?4TN4xzn93YfU3Mklj0winsK2EiOV5mwLxG1T0Mn/XV12WTQwWGX+0RNMWKtc?=
 =?us-ascii?Q?7H1Pv5xUzZBZKkFM7UxB3UpmdERqxJZOMOACmG7ZGMnBxExgENd/d8qhiL8K?=
 =?us-ascii?Q?ivizFWU4uOUJgUBrIGsZsxHp8HCXoW21O7Toy5rawRs9PSDYRLdf5ZfbnlwK?=
 =?us-ascii?Q?nbpTWZU0GZlM5Rn7/3Ka7IcqWokfIsfpOi/IO89I8YvKSp6fpeLktuSqL+dc?=
 =?us-ascii?Q?+DITYNmLD1UZqZoYkZw7pydCwJOLUqhXXFhY5Z0+uyWdpwd5GwWI1pcNEpvi?=
 =?us-ascii?Q?LFJyxiy5DxCQ3gupnDVKv99jPbRW+tlSReZVdXIDxXZlEsxq7xRXon1q5Lf7?=
 =?us-ascii?Q?ptKT9MINgZMoWKnVcgR/Br2NPFG8Y2ANHCCt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:57.3246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f479979-32fc-4f05-6744-08ddc3d39bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

Remove region creation code from construct_region() to clearly split
the code. This simplifies the function interface of construct_region()
and reduces the number of local variables there.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ba59fa726cf3..f88b7f86f0f5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3348,9 +3348,14 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
-					enum cxl_partition_mode mode, int id)
+					struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	int part = READ_ONCE(cxled->part);
+	enum cxl_partition_mode mode = cxlds->part[part].mode;
 	struct cxl_region *cxlr;
+	struct cxl_region_params *p;
 
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
@@ -3367,8 +3372,13 @@ static struct cxl_region *create_region(struct cxl_root_decoder *cxlrd,
 
 	cxlr->mode = mode;
 	cxlr->type = CXL_DECODER_HOSTONLYMEM;
+	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
-	return devm_cxl_add_region(cxlr, id);
+	p = &cxlr->params;
+	p->interleave_ways = cxled->cxld.interleave_ways;
+	p->interleave_granularity = cxled->cxld.interleave_granularity;
+
+	return devm_cxl_add_region(cxlr, -1);
 }
 
 /* Establish an empty region covering the given HPA range */
@@ -3376,15 +3386,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int part = READ_ONCE(cxled->part);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
 
 	struct cxl_region *cxlr __free(early_region_unregister) =
-		create_region(cxlrd, cxlds->part[part].mode, -1);
+		create_region(cxlrd, cxled);
 
 	if (IS_ERR(cxlr)) {
 		dev_err(cxlmd->dev.parent,
@@ -3405,8 +3413,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
-
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
@@ -3438,8 +3444,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-- 
2.39.5

