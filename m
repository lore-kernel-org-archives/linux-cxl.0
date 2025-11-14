Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14035E522;
	Fri, 14 Nov 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156416; cv=fail; b=C7H61pq3fQGIIL9eaMX+BQPWzOSZbBNF7gcGd/2Ntn9KZPzJ5TyBcKoJxpMKCw45MEe/jqauLUKEC+WgovZbOgkjVg3PoBIS8wybqFM6T/LPXrdGrfYEyP4ZDwbEW5Sk6yEPg+nRydyKUA30gZC6BzgH1BVtthgVanFXNJle9JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156416; c=relaxed/simple;
	bh=d06gooiMiKPsC5Bx+E7CE5qgN7rQevYOEQx6OxWdwIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oqc+RUQoVMF6akBbXQNPvaKMlHsa1WaU6wWbc22ALisN6NgL7iWytf9Tf1raWZ3mzgeEXex/ZBdqa/fy4HHfwKDsqnPkibLXWIMbt1OQTfu6IStXTJ8QGbGWN1lsTvKYImuAqJTE15kwVoyS5avm74zngtkdY831U3kE9FTx2TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mKx1+qrZ; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mKx1+qrZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyBKd3cwEMPVKbdKnc2dYRwPSRkz0YdtQpjuxiYhEtg6I6lmXpBXI9BQmWRKBz/8dA3e9YgDM7GpbQHHVr7q/yOnfIJCC0gKkjwnItZSGwhXcp97yCpKZokXmIf7ukfZVPzHOApaOm/h81+keya08c+JIifJK30WobBMkbSnQS29WmtmltcnyvDmWhEHvWXF1oi0it0JfE5ZNRox+/dd1lsG8iH/XV95ZLgJYEvz6bmrsLeOE0Zk1/SRPMqdVBH+8XlPDO2VlgndEzo7Nj+7KQtUtoZ3Siu4f5VlGNI5fOMfeYXgF+BYqh3uS0Ixatn+V8NZbdlu6l/Da8ThThNlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bvyi1cOSEXnDetmw5p6jhn1TIZexq6antxJQLAL7S4=;
 b=pqf43SCzNFUdLRLaRcRmamnQvPZopsTsl9SPMDAzlg+XgGkK020E53jC0qCKnmVNQqe3B7rhzS8lMMpZRtdcryOpmE/PbfXU3DwHyElepUMxKiVnT+n6/Fyjl6m08b0e1dnWJNLdo8kxYR1wUC1by759SiJT2nW22V2SI0NX1O8tjaSPSLqNy2zbBVj5r8c+VtFaEROITUSCwyTWIy8wCSHcvr8c6RCfy47oS7PEKut+r+OC9oWpy01d8aN6bcgjtF/gqqFyZInKVU4NwzmgETitIYHaUvsSK3moyoOlzQTvOYRGiHT93wnBU3Osr8Pltdf/VSy42a0/sHjoxSrPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bvyi1cOSEXnDetmw5p6jhn1TIZexq6antxJQLAL7S4=;
 b=mKx1+qrZhn21/EPIj7RlyIbpqTIJ0fK0sAxb1oaD/AUHtCyB+5ZbQnM4ZtlVJVJq0hLWYCFIBOtYwmRumjS+y1l+XCUF9V3BUuUdh4x9JSMVqJ1ZXiieY0S0oYVTa28ymYSernPngzxpZIzW9iGhjDdPutDelFPhh7bFwEf9vxQ=
Received: from CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::30)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:40:11 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::4a) by CH3P220CA0024.outlook.office365.com
 (2603:10b6:610:1e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:10 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:08 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 07/11] cxl/region: Use region data to get the root decoder
Date: Fri, 14 Nov 2025 22:39:20 +0100
Message-ID: <20251114213931.30754-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ee0684-fad6-44cb-812d-08de23c6634e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SxRYMcubOqbOXaE4sO8Zk1AGTeF7s+xEkbK7H08esYLFAzLocFpk8zB9Axx2?=
 =?us-ascii?Q?X/PjDl94h/nQr0fat8P2Fj0sLQ78355AVHkrN3KUlYYy9byPlvy36vNsa73V?=
 =?us-ascii?Q?oLKL2eRSa3fLvAADGyPST5vThINdVBl86uYdHH3Vd094E3m6K5XvubFFnkRJ?=
 =?us-ascii?Q?Nubx5lmXElzN45aUIrCGLI9rGAT13VVo9iQmdj0iM176kBumaeGDkTmBNcCB?=
 =?us-ascii?Q?p7PYCR0563u8j31ofjt1BWhlfH4lxpiVg7ijfpZu6emFrACv2MoVsA1X4u5Y?=
 =?us-ascii?Q?Sh3adJslNfDPCVnliVSRpvdyppHdS9ZedH+jdg0zfHuQP+GS+7JbWTFngZt1?=
 =?us-ascii?Q?d92Zti6CRhvhzrHO7EO4b0NY+ZgMysVaHqUCQjSHpBv9VTFndH6e6VkT5ePu?=
 =?us-ascii?Q?gy0BGC40BCcLu6zEVegGn8UdZRt4eHQgsNhgtLIite+2vN7C9RJoyguZSXVA?=
 =?us-ascii?Q?sCtlevH49kvyRI+DmdM2CFahzMPr9B6qZLOXnFl3ZGbCBUDUu9xCdc8blmad?=
 =?us-ascii?Q?+7uXoyqyLob6qlU3JqSpczIdqZPLObXqSM+oQTEWMFwaSs95R4JZtMwhTeA5?=
 =?us-ascii?Q?osL45vj7Nb/3xmR3HxzrHXsVJNpzeat6rxheYyixDWJRQewzZdktuFayscYO?=
 =?us-ascii?Q?WsN70+K3o4UplljdcszpVScMw4lhhkVgftoB4d3AXyixehPeL2M/6NPDpPqx?=
 =?us-ascii?Q?GD7M28wfpq02l9d3X2863iU3q5I1S97um0kx05kwG2eMBLJy7gthryhw/5S6?=
 =?us-ascii?Q?1oF8OwJc1kBSnfopRWEYWQ9YlYOkToxNBaCacvW2p3ZtGv8F5Dk6AAUjd8iu?=
 =?us-ascii?Q?2BUdT0zN4NG8w6lQ9JTlbS+BWbVqv/Kwjn2eqfuuLEQIyQ0l1IBQCSPhoTRC?=
 =?us-ascii?Q?dDkRG6wSUi1gIfby+j4K/EY9Fzzy455UsaES8iJWVmqmbzqsMSvnDKa1zZnL?=
 =?us-ascii?Q?2UJld2DKeAJytIpKL3rejfmiwUfnG0IDj50JsJ7ZkbMl1xAUoWsTZKHHxYUa?=
 =?us-ascii?Q?kPZJpUq6iPC89dbw/qryFqPPUd1Q6xrK0/ou5DpHsm6AsKc2nmsStuZpSHJU?=
 =?us-ascii?Q?OQ02LXc+A11LsYG4ojb5kMGbdwEoRMMEDEd9rvcqLw6uUZROG9E0Y3HMtvDZ?=
 =?us-ascii?Q?d2266h6OQbNCPK/Q+lPVPz/6VQQtBLURgU7BWg1kK1AGS2WQ+G2R0ZxPIaog?=
 =?us-ascii?Q?r59Yv+8/nesIiFX52jKN0zXx/D3XMnJzSZFWidn9pHHkHBXnAKyLaEnjaPFB?=
 =?us-ascii?Q?twPzAtjVjS2LB6UNe2TYnE042296kgPQZZ648o78sATLnuGMpK+lbGZCBHJk?=
 =?us-ascii?Q?svCfdrQMiajAbxSPDYUxZbxfS7FA6RDjvUnPKTT6iOattwNSRV/PofuvZ9J1?=
 =?us-ascii?Q?varNMxSzvBDGsXm/Kdvfs+S8myvzTdVxRYUMN+YB3ypGPB1OfFjjC99d6NId?=
 =?us-ascii?Q?OBDVhf04+ng1PNWXtTCtOJcwj3/u5lnUHEc+Y20jOSmWI4WZIOlJhCugsVyN?=
 =?us-ascii?Q?1zCpOLhyIOhhFlPWu+hroo1UluvlPkaPtvsa4iOVrC1kwjZUVwwR2wFwIsD3?=
 =?us-ascii?Q?Y8ixQ3ucj8N5C5CAoeA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:10.9219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ee0684-fad6-44cb-812d-08de23c6634e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805

To find a region's root decoder, the endpoint's HPA range is used to
search the matching decoder by its range. With address translation the
endpoint decoder's range is in a different address space and thus
cannot be used to determine the root decoder.

The region parameters are encapsulated within struc cxl_region_context
and may include the translated Host Physical Address (HPA) range. Use
this context to identify the root decoder rather than relying on the
endpoint.

Modify cxl_find_root_decoder() and add the region context as
parameter. Rename this function to get_cxl_root_decoder() as a
counterpart to put_cxl_root_decoder(). Simplify the implementation by
removing function cxl_port_find_switch_decode(). The function is
unnecessary because it is not referenced or utilized elsewhere in the
code.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 01d23a42a6de..c028b772cfab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3340,47 +3340,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, const void *data)
+static int match_root_decoder(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_decoder *cxld;
+	struct cxl_root_decoder *cxlrd;
 
-	if (!is_switch_decoder(dev))
+	if (!is_root_decoder(dev))
 		return 0;
 
-	cxld = to_cxl_decoder(dev);
-	r1 = &cxld->hpa_range;
-	return range_contains(r1, r2);
-}
-
-static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
-{
-	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
-						    match_decoder_by_range);
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 
-	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+	return range_contains(r1, r2);
 }
 
+/*
+ * Note, when finished with the device, drop the reference with
+ * put_device() or use the put_cxl_root_decoder helper.
+ */
 static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
+		     struct cxl_region_context *ctx)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa_range = &cxld->hpa_range;
+	struct device *cxlrd_dev;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
-	if (!root) {
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
+				      match_root_decoder);
+	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			hpa_range->start, hpa_range->end);
-		return NULL;
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(-ENXIO);
 	}
 
-	return to_cxl_root_decoder(&root->dev);
+	return to_cxl_root_decoder(cxlrd_dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3573,9 +3570,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	};
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
+		get_cxl_root_decoder(cxled, &ctx);
+
+	if (IS_ERR(cxlrd))
+		return PTR_ERR(cxlrd);
 
 	/*
 	 * Ensure that, if multiple threads race to construct_region()
-- 
2.47.3

