Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C882DD5E2;
	Wed, 12 Nov 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979544; cv=fail; b=fzHqAM07ytUlHl/IGQ9xi0i/ACrnZqo6CxP1ksyrHESCzNEw2oXSPnMsvTrj0eGcRiWH8bxA78klhzYFYLcdGYPlfGbJk6Qi0uzbwZy/uFEjIEFx35Uc9TZK7D9BGWkS3VF93FxGwN4n3Ws9XqG1kVWJk2DjHDwvZj1HCtaqoBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979544; c=relaxed/simple;
	bh=sApybQ3GRZwO/xTeEUMDTJyVV5jPis86cxcgpVQoqPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvldhnZi86UQQcfEtpai0BUixpYOQcsyzYE944UBShzJ8aFpGNVr/0za+AXAJqRDlOgAyMp9e6xSSNVMFhSkWHWA8G8Rhic2q1fgoK4w7hFvYRJ/N6/8n9HmeoX6vhtHdGWPMmX7zuZZ5wmbTSJW6Oa255J0/o68fXG7AtneTwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TJRRD2kp; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TJRRD2kp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBAkw7bYbLRCGhXifRyXqhZp6SC38JtU7nM5w1+PzdRK4AKSokcXkogz62gs1zqPYXbEdOU2sQsflXgde9BwfcrM+eOE4Yx90y0ngIwWVRMDB12cmn1sTecOwW5QEdMhcpMgKf2MbYfvOo3GKTMoHVjr/t4cW6TcbKltbbagKiPxh32uWdB+o1tuU3wJFt7Y1atkTCiLTZRmvcYUhTO2ktuiu2jAK9CPUQQXxFmcnDpQ9YowLEbMdneBbX7x6Ju9JFL5HtOW5P6YM+nFKrwJZ8djc24XdeU29inxNVQyaxi2Hv0aDDOprLsRawyzxUR6nBxt0xZ5aohc6vf0nZm2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JLs0TVwwRMxPWlbEC9LAP9ek8PWz96Q1t9JcH6GKoo=;
 b=r28ty48shIP+0yx4e5Hx5kafnS7b+OGjk3HCsFptP5wTgRbkvTW1yyJTiUPJ8pJ9GeV/k5lGnWDJOZxxeFaWsHbnoo9XxAkowPw7jT3mqcS2ANgz2KJXwJoD5Y3Q8oXk/j6/Ur4WGs328OXVy1DtKtsEJgFoWfcF+MekHpfy6XVVaVowcbX9v4y9/oeqdGrisI32tS3tY805sDXa/cSIR/flvExhzIQ1PXiY8c39z38hCiTiHuNemXVu9HmYHPKB4j+tASiZ3tDvMupZqzU4MOv78srbHO8Gy/VBPtcQUxusDl1ZRjLCeAmVO5k0ZIbYVqvEuWu4SGYdmkZDAff2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JLs0TVwwRMxPWlbEC9LAP9ek8PWz96Q1t9JcH6GKoo=;
 b=TJRRD2kpdaX67i5RdBgxrK9qcXekeH9zBtRxFBJi2mVZ8lDzSE1hzmiD5u4A61nikCGIcqpuiY4jr/y41K5+ttbx2lafSnxznNdc4FV1doFufZ9F+OGbODdGuCLEEsy+hQ8e+x08MB1KPm2UpMVv5v1CP3Tcz7qFk0IHmQXJlgY=
Received: from CH5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:1f4::15)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:32:20 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e7) by CH5PR04CA0009.outlook.office365.com
 (2603:10b6:610:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:20 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:17 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 07/11] cxl/region: Use region data to get the root decoder
Date: Wed, 12 Nov 2025 21:31:34 +0100
Message-ID: <20251112203143.1269944-8-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f22042-a538-4edb-c67f-08de222a9443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+l8aq/Lk6UyWQKAe2k9W6F1tbDDs9uqTKocQAp8deUhF+7UkyE5sc3lJzfg?=
 =?us-ascii?Q?rKaAQzowYLqZzikg4OOe7rUIHp6fplrHRhY6LXNmHsuQ7i4GVak7XUrH+1EF?=
 =?us-ascii?Q?Lh/HJe0HDsyxzsZ4eHx1RIs0GjEU8N7Lny8NgQaiXpnC5vqdCUSOb1955yEZ?=
 =?us-ascii?Q?DDsRovwOaezVpKxU2gD9k48KCDDaOjeo3G1bHyDONecCKjvMZXp2WN0Bpewq?=
 =?us-ascii?Q?EVmgIHG4oUWKwOxRUtt6j1XneHMgAVK9VTNwOoZi5mlBCdGC2cbiZ9NRxWVD?=
 =?us-ascii?Q?YbHntY3MeMlfQRWRB8AWnBmX11nL9cqcFVOn/IwLFcomxWMKBlci6RZ0CwSp?=
 =?us-ascii?Q?F1SGa5op1a9E6KSNDwr7vJAj9sUHVK1D6Muigwn47N1DJjGEx/yOqBsmlUGr?=
 =?us-ascii?Q?eM+Nq+TnDlaqrtcHPjGzw7ZtvVzfqQgH5fekFg/aolhSJ1qiUHqa9wDF7cKL?=
 =?us-ascii?Q?reptvMIknM9nJmhRQO7FLV+szkbZ3Bq0NewM/seODfpeT5mvJyaEU0TavxCr?=
 =?us-ascii?Q?jqKB9HpV99IBtR3EQQYpze8TuJq3+f5xN7/gqxWrG6JcA3Ho/wJH278FIRU2?=
 =?us-ascii?Q?Z7VRSpHAahNfEDmZ/W/2Vr4aIbQcfTViu06GOqzAtZxKEDcPaIz+4i9MHY1n?=
 =?us-ascii?Q?Jj1vmJPhoxJ3ykapqYflu5W9H907R7B/48OyFaO5oL0B9sw2/Y983A4arEHu?=
 =?us-ascii?Q?asGLwEJYbsFYLP10mzJlB8oZ8KAW7A1uMMKJIIXKnY6/3wcE2cY80sbabwmB?=
 =?us-ascii?Q?BKc3wSTntEGwmpNQURYFKZ2m6SJSoVgo80ORooOWi/AFR45w4nnbFm/9NnDc?=
 =?us-ascii?Q?g+nUEBKdKWKa3vUFsYVHHbid6TcibGb3ORZ+fn1DGEkQmPtJs+yWM+xhngLm?=
 =?us-ascii?Q?9We96keyo6vg9p8DrLjFle/QpGN6BXuDHFJ02yT6OlamFuNmunZz4WesTNvO?=
 =?us-ascii?Q?JtOO/KVFyQJqbwJMmjDSgYvtagIHBuPI98xEkW1jMeu7OxvyllF10rZ8Ub3Y?=
 =?us-ascii?Q?16luYfx74LxD+9Fc06puo7kAImuDQOdOUjC63EQS6eMkSxolHCI+WVLd/Uq2?=
 =?us-ascii?Q?cYdsKrXCnewd0E5kliTBW7cQKRGNPpNIuyU5ax07BzCJWmr32CRhNSwt7ZK+?=
 =?us-ascii?Q?d3wHqIZTMc6WSU5Q8TYoO2zvghuk+qORql8+a+Nsy0d+tX33sM0rr7Xj+K4t?=
 =?us-ascii?Q?SSdokcaWGCif5ldZg7HWnZxRNoFz9/3+b2HXKIbBHPeUePkm2QvCgPAX5k4U?=
 =?us-ascii?Q?Y89PB5jN0EFJs4R6CdhJH5PeTGBJtKptKlB05LdjD9l0CvdRHPwSVKfHruyg?=
 =?us-ascii?Q?kLcGsntLvia6umAV7ykX1zqpy9dxLD/cwwkDY3TG/iIptH6Hx3ANHgEL5IMK?=
 =?us-ascii?Q?UjoUNfZGsyYJD4EWR0ZKEvNRMl01BMocXWliB+SpGNCRzK+Prmr9sOgUz0Hy?=
 =?us-ascii?Q?QjHLZk9uK0n1iaFR2+OPSMV31evC1zTm0fjjyy/KZKZPhhHOXFPRKkn0qgKl?=
 =?us-ascii?Q?koYsUK/nrnNfH/Y9bm28UvVcKST1cs+7+jL4Qgo/D2AByOgNrgyklC2ZRlKY?=
 =?us-ascii?Q?A7gTt8g58EK9+CZBLEk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:20.3839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f22042-a538-4edb-c67f-08de222a9443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727

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
index 0fb11017f16d..bdd44096ea02 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3458,47 +3458,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
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
@@ -3695,9 +3692,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
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

