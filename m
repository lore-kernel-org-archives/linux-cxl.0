Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BF26F471;
	Fri, 14 Nov 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080891; cv=fail; b=ZoFpsEPdTXGFE8D9hwy1gu+jkdLXEw7khKgfNKwz10rpxrKk7SHH2Bim7DPnlDAz8hlrSaGLMS8I1ZixKviu767MLcOPaAAiGhlvabOdzb0/7TfHFD7hty+m41R1jwEdiJ90pUPZAwqbEvGUQIcGuGDNWOefpVO0d3N3cAQlPXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080891; c=relaxed/simple;
	bh=d06gooiMiKPsC5Bx+E7CE5qgN7rQevYOEQx6OxWdwIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBgrctGXWuRMv87fWxm+TnLuzwtMud8bhf3bsQPxaSFyQZNJUmEFoZUUB0W6Tsuw2BsWklV6/ThBMXLfr9sR4ZU6a6mF+2/w/26uVN8luGSpAp0J3xGm1IA0sYOZfYLZeVFzD8AfoY+IJhoeTPEohSsBo/VHzrF0x8TaakrAS/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qcg+cfZx; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qcg+cfZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDaXxqfe26KzA65Oe4aa7jAc+AC3FV+/V/Fi+Zn4ePRepm+cKvMpboB3/oVsm1gTuaAVM8zobagz60w+2JY2Zeg3F3EGwkzqJhnWCD+GefDL4BWNve9A1tMAX3+0oDJgvDiTXhmt5bN+8UoeTYZz8kAiPUCLy3B2Z87N7ThfYPffWInCZk5PuDv+gaDUx+R0BAYRRUaRy0s4N8sL5SvoX4RjK1QeC4aMtVm+Sg7RkQwTLXA+ptP33Zx5FcTKmJiUks594IIKFwfOUIkChQyrs/ld/MgmrT57KaHawvp6AJcffI+ZsxaiYqXMjoJ/Kk7a/rywPQFwYLhgLYi4ywJAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bvyi1cOSEXnDetmw5p6jhn1TIZexq6antxJQLAL7S4=;
 b=VBje+McmFZ4rNZIjyifuUTWHZjYmiZrlxbYbBgyhLkSNp3TIxmMuVJvgEAuk+BFownp4zFwrtx1df3SG+KZCeBDoU9fifI/6c26szUsueIfmIwmUFt3YfRTzrTl7SkhXX8IaJitg3+HfurZNqJyBSpYBa4KI0pdZISsw9Xjq3DK+RLC3vjdjhlGpGuY4/gJAhQYYE86xfI2IZFHbzQOBDJ0UaUTKlf+WkgfcS5Qu5K3kzAJGvbWsp/3U3m8gt9VoSQCb8RzVarTcPHdFdMYmWcAqSdN4Tv1p2GDk8/Ue/L734/GZHTBmRfw3ItixjqvVgxc2HfmBH1OOMlDvCb4bcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bvyi1cOSEXnDetmw5p6jhn1TIZexq6antxJQLAL7S4=;
 b=qcg+cfZxbcRhsKf5FX3hupTGk0EoILg7lG7/IqEUrCfrVSDLLa8cJmKgzRAbRWqJtZ+i22x8tggwT5b8oib6H7SlT2+fTq12o71JbpwbNOOZjwm9aPJ533Nand1h+5u9rKekwnaCxK7CHzdni1XLHH1ZBB6T5hK9VTHCmhDuSWw=
Received: from SJ0PR03CA0260.namprd03.prod.outlook.com (2603:10b6:a03:3a0::25)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:41:25 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::7a) by SJ0PR03CA0260.outlook.office365.com
 (2603:10b6:a03:3a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:25 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:19 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 07/11] cxl/region: Use region data to get the root decoder
Date: Fri, 14 Nov 2025 01:40:12 +0100
Message-ID: <20251114004021.1310661-8-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3631df-5a62-459c-d546-08de23168a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jB4cwi0TL9iUUPON6uDGji2jVAiaXqVu2XhBZTuNC+n+ELnczpiIVTcjYNGz?=
 =?us-ascii?Q?f9G2WjcHZfmWmVJsLWSSYDNbSCz9EqE/smhMMCnvUjklJjpwCUArPuMl9vw/?=
 =?us-ascii?Q?1ddxnvTUS9yho3z0B4WFx+xfWEHhV7mgtbR/55PqkIs0CZ9OTH2UXQ9PoqMm?=
 =?us-ascii?Q?OumetDzemJujfRsOFk1DKgStoNJ7+EX78s20185wbBKL2VsQ1gzceYqBbKhq?=
 =?us-ascii?Q?9UCAIiFb8CdPUCU+SUI5kyyrqHuT9AQ94lGThde/Vd5eAv0B4SBNOVn8+ooV?=
 =?us-ascii?Q?Wtd9VAEzWX2Nq12mv3T+9MbbNxs4EwQs/WZd+FTZyGM9NxuBTTa9kZXU6RTH?=
 =?us-ascii?Q?/RRPsVo87IXB/QsOWVTfHBWkDrMNIEVY75WQ+8BeZ0ZCoEzxsO1JBU9AKmFi?=
 =?us-ascii?Q?Exta+ZOVJ7/UdkT2nyQCrtYuAUEVFH+68an9xGpFosuXAfl6LcBcXlah2y6n?=
 =?us-ascii?Q?ZhZoxFDTFIGq3Mnze5aLW0Y7EyKbRpWjS3N5XtYfkhMmbljQ+mZiw+A9K/fJ?=
 =?us-ascii?Q?RB4b5zNPMr6psduquoTqGxp1S1+gz/4VTs+cloQkAGHK7710ulq6a0MzeTXM?=
 =?us-ascii?Q?8GpOR1mUev/bCKFX6RrMx3tsH/zvXwHd1xhvt3DKe61M4PE9jm2hmhZdHYPL?=
 =?us-ascii?Q?r0tZW9wF88av9+3vAea3CXEFXqc4Qin6i/H09xDJdLPDc3Sx2E54jLf3IqiC?=
 =?us-ascii?Q?C99oktGRHM2HVwXklkX9eUDId6aM3L5s26h3J5PY9RF9nZDnxc2eE3o9k1xY?=
 =?us-ascii?Q?34/KQoW/0tpDwpFZJkw02ljlANyHgJuziQ+rlOsnrLaTLBwd9wx+WniYV53p?=
 =?us-ascii?Q?kkbbf3S1Tf1hRCSodLSKekjWmrTaR2aEr9OJroxjxsdbQ1qH1C5ynRWmcUf7?=
 =?us-ascii?Q?G2z0cK1L1DgMO201roWj0Gg8FtOnSHKAK698NTLa9mB3BeKQMlXNWnN1lAVx?=
 =?us-ascii?Q?IPSPAZO+g+RGYS/AQ7vHdDt9tg0BjeXCdumrSykwi3sXxwGDLzFper+dEsxP?=
 =?us-ascii?Q?EUqodKtTPZ49um3f7NEKzgaVCOAQgNgYFAl3ygb1lWv5iH3+inifk7Qic3/z?=
 =?us-ascii?Q?h2UILH5A9Ixgg2F3vJHLfvEwAScWqGZsOINU83Al9+T2cbvOIxo/0bKL4ceq?=
 =?us-ascii?Q?6wP4yRpC4Xb5TwJ/m+b/R0BfvI/6bohl/uWUmnvCV/lDO6eU3sVeJ2miW6gT?=
 =?us-ascii?Q?ieAzk2AiyzgOSbF5rGVESTmKTzeADFVWH8RsLwKALtKNDSAXpoVik+bux7Os?=
 =?us-ascii?Q?rr53gSDH7WlXGIWBhYh9XJ9OX1ODmEQg8z1F36OOuFrSgtQFaNqG5NrPmiVc?=
 =?us-ascii?Q?VAlbNHb1lFbWdjmQCDaxcywJqzTd9sqhuy+wwqtmFAIlze05YBt7+5iLsP1f?=
 =?us-ascii?Q?+44/QP240xUqO2puiwb2/btys2nn8ygepB3X6mCLce9DCsQd/sxjWK7CuGUB?=
 =?us-ascii?Q?hzUrYyZYm3VCemM4mpFbzaFKWPrhwpHvqcRuUIdst+WL/wmSykRs0/4scVCR?=
 =?us-ascii?Q?AlUOJX0iUSQkhUvs8g38KecR1Dj9XAuXFPewDiScbk+Phz8eGdSmqqqHrcV6?=
 =?us-ascii?Q?+YIgQ3lj+tcY/Pw/0Gg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:25.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3631df-5a62-459c-d546-08de23168a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806

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

