Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068630C61B;
	Wed, 15 Oct 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496095; cv=fail; b=Rdq0WGMaHmKfk9YVNU6UW2a9f1oVyQQNJPAerr7mRpI35L7jXNA5nuZfHvXCb8a8ll+y/mtZ4NUdUpxO/8n55omv0L3rOsQJAMkGK3ebuIyll7HpxzF29dp4FEUEE8LZMK4X9FnKY5u93Kw4twpPB9KNL2L+/D7ZcddMPSO1vto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496095; c=relaxed/simple;
	bh=6Z0FOZ7PEwFmgN4F8a0AboRI6rzmPZdQXKvAn5zT3FQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beedNR0B6qXnJI6O3OLb/4hOxqDu925lJ7eiEvfyQ5C5KceAnZWBBjfQlE2kYj/OdneBvLnaPwW3oMNJ3cpKanN2HztNBupzfT/GhEYipzhh6S2gNh55YyY+2BruD9s//n+0KNg0PiBiMedVRaLkg/vG8K9/yjPJZ5o7FbOYBiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBUPoksD; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBUPoksD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1+DkeVwonPpypRVj+Or3nnXUPn+QaJ5nMRiEkthMd8/7KCyna41baYDylzs5HI7Fk7wf3I9VPwcNG2SI6ElLX5DxoBtI6YOCo28zzq56+uIZ+CGsnfgGUU3Z6QBUIwKvul3wWJ5gdANg5KPIoYIrAYu6HmBgHmEoe9CgkLN9MRihl8IpyRGx6+J9AuO5ys4BFrDI6yOuVQ/ZireUnNaBpj8lo5AjXRD910uPZbhzDgwICvIVbcmlZaIs3b3AUrhYthfVTn6nmoHw3Co5ehaPOZxV6O3s5MDAD48XcI2xzWHG2/xxUSd8qbdoJNXvZnDhhA0+iLshtuta4V1XeiZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4VQPrFvpGhL7FTTjnwAbwDtVWBEyq/rbLJIAQsy5Pw=;
 b=WEO99wtS4DW55Bq4Y2sjmbgafKEApciwcorQxq5D+s3tEqN6SfrK5Ytc/Jp5JVivlSBmNp8SFJ9MWoWHwiyAJwWlU3clOAwwWdibeAUowQOOcWN0BEOQ513uJZHkSBrrB1jcogFZsqxOrU4szBPO+OzthIy8NiP3Jg2J6kLmwDvm4Uo8276nCccTj/pRwUCflFiiW4VKJ8rqaCFU+SRVvtA/+QINDtuJCmud6+xMlfDuXGqTbUB22G8hiMIHeaPzQfAyeO3z3JNHKCC5r77tJqHjL9GwSQB3ULJ+4QE6+OItwtGmDekGcvkoOxn6HThQNL4aw+9sZBeiaP6O/Ix1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4VQPrFvpGhL7FTTjnwAbwDtVWBEyq/rbLJIAQsy5Pw=;
 b=VBUPoksDpgkE22WDjXz1SrwtsWwCwRk/MMxnLKgSKVg/VJQrrdZdqebecFYuBz/YGA4j2Ox0rJa2bTxAKTm/R0lpWZilZt6x0uGr2ZSNvpo6ZKSs1gyGNmMo9mmKVi1f1pMg3wGay+u3+k2R01Oze3DrYkQaIyh99Y47USwXocJXhk8puRdFXlNAek5DhmsWn0b9n8SBzDT5DZ8sSkrEUjXv1CLc7l+EIT6aJ5ADJNrhO8/2fZd1TXK2HD3vGZJm1w50GvMoPv/eGX8wb8JB6YfPaWy6UuxeYci0Skm60uvwwiEvQ8cRHoEag4p5zQVd7avdvzRXPbsO5lFttMxNdQ==
Received: from MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 02:41:27 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::9f) by MN2PR16CA0051.outlook.office365.com
 (2603:10b6:208:234::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 02:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 02:41:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 14 Oct
 2025 19:41:15 -0700
Received: from vaslot-linux-dev.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Oct 2025 19:41:14 -0700
From: Vishal Aslot <vaslot@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Peter Zijlstra
	<peterz@infradead.org>, Vishal Aslot <vaslot@nvidia.com>, "open list:COMPUTE
 EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Date: Tue, 14 Oct 2025 19:40:05 -0700
Message-ID: <20251015024019.1189713-2-vaslot@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015024019.1189713-1-vaslot@nvidia.com>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d744c3-19bc-4639-9583-08de0b9456a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+o/9VGhWIxk0JyukiewCFqvc7NYxqSv5Go0tt8hOZcJ2VHFG96eKfhEmOZNa?=
 =?us-ascii?Q?ltlpxy1wN5bmVMx4F/dimmVXPlEDlSJBPYEWUyGNiN+MOo8SOpTaJpEkU7MS?=
 =?us-ascii?Q?FDMRlw08fasYzmbCXFjR99ZT7dd2BAXcQ7oGRPXWzjSe/62yEnotSR5dF09n?=
 =?us-ascii?Q?qACwOZkZsTwfhCJrGm4JfXhDMDYTiH9TdK9yW0alG/ot6D93Kv0cy+G8RG75?=
 =?us-ascii?Q?wlMuGKUZp1tVVI07lHIuQQGDFA8MAIPg/D8t1nhnZ5hM9xRl3fdJj+Ki7XYF?=
 =?us-ascii?Q?Z4WKgZ9qvp2+r9h4UBXLAIRxJoAai3cX+mpUUGBe1oj8UPef40CookAfpqt8?=
 =?us-ascii?Q?bJuBen3YmKDl7K6N1xuYlgq38Y8owdT8WRkRSuSVNhlKosKneRwZZ0Lqcwym?=
 =?us-ascii?Q?3tkqhs9sQFgrc7ghSyj7kXgRAUYnUrPQmiJw+2q5lWTIRGv0pcTREuEM8mqk?=
 =?us-ascii?Q?E/Tj1+Gv4uwijQECIzHeU+hUOIXmfnCiVKEAo3N9hLvSYYBgzzivcl0zNqE6?=
 =?us-ascii?Q?uIKV+FLUZD9aZCWPZlh/WglxrApI2vurB2i59vCz0bmuzcorpCOXTXtiaA9+?=
 =?us-ascii?Q?9rGwTyxjoQuRmiXBo0Pwyhm9+otwseZG3wAqISADVBiqbxlvQH6XlxQ9am4q?=
 =?us-ascii?Q?yWqSIS4iZqDk8sk1cv4fK5sUV359zKEgyj+yXLjSAm76ewFXhP4pCGk5DEUN?=
 =?us-ascii?Q?ZIOHZBRBCOuwnsvnNTdqZQN7UQgOEq2WnGzCpWSaHu0MjgBSOUN4bvYr+SPY?=
 =?us-ascii?Q?rHlGm2RKJFJqa5eIzEJI2YBWpMVq22bYiHCDC+05e7sS8CXeSlSwMsv7Pvzj?=
 =?us-ascii?Q?Fq9R5YtwXZsbr/7gT6tfF3QIma2HO8e3EFTZdeEf77anRaYGMXcDXlDshnz4?=
 =?us-ascii?Q?R6/N8lzss8ozm/LT+ojzeYNPA8BLevMVFslxOThsZyfDC4bdrF7wOCqG6wcX?=
 =?us-ascii?Q?lPR47xRJE3tc2F6EKiGhue2Ac/szLWPR/bWknRmLrPvnPUMB/XO61KX4DS4A?=
 =?us-ascii?Q?LF9xSySnl4xxvHDFv+AKqvqnBzMkewWszmmQNlwIPHn06LC3Zhe0tUVa4ny3?=
 =?us-ascii?Q?MsQbQDQSvzFpgUQzl721emoOD306jkDyZ1cUCZ+SO16YkOJa3hpV1utkvLts?=
 =?us-ascii?Q?Wp9Yht25LVHHToTw34qBi6eI1PoAmvNbCzmsnAgSmj0o9myhOZk6f4UdaLAm?=
 =?us-ascii?Q?sCjwTLRhonA8flGT5AaB2/asL+SOwa0n4eBNcLOUJEszTVc+8K/MgzUSw7VU?=
 =?us-ascii?Q?Hackipx+fGXsvCL4AGbZDPHT4T3FU3jIhY2zyw8jph6wFDMXW+n/RrksMKN4?=
 =?us-ascii?Q?RCUPoDQkz5cCRSDH755b9kwFKhqIPs3kNg9yRfsRncC6lludcsy1D7eZIjZF?=
 =?us-ascii?Q?66IFBHqmtLCuy95IoFlT+JoXiltQAJHiMnMGTAm4/+ekJKJuXjtyA2X+EWbI?=
 =?us-ascii?Q?zsbvSJedHzx+QaQShJFP8di+l2mZWgAjipW8/MFRnbpEU/qJOBkYPHG5HeUV?=
 =?us-ascii?Q?iYGSdgR30FyR/zD9T9z+XJEFeUCCbO8TC0NDPIY+bc1jOjkpEPnD+uQkKYLj?=
 =?us-ascii?Q?SQQXDujs5x/3PcbfFg1Fj00hoFhEVHQre+wkvZW8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:41:26.8265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d744c3-19bc-4639-9583-08de0b9456a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

The cxl core in linux updated to supported committed
decoders of zero size, because this is allowed by
the CXL spec.

This patch updates cxl_test to enable decoders 1 and 2
in the host-bridge 0 port, in a switch uport under hb0,
and the endpoints ports with size zero simulating
committed zero sized decoders.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
---
 tools/testing/cxl/test/cxl.c | 96 +++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2d135ca533d0..cb18ee41a7cf 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -719,6 +719,45 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	cxld->reset = mock_decoder_reset;
 }
 
+static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	cxled = to_cxl_endpoint_decoder(&cxld->dev);
+	cxld->hpa_range = (struct range){
+		.start = base,
+		.end = base - 1,  /* Size 0 */
+	};
+
+	cxld->interleave_ways = 2;
+	cxld->interleave_granularity = 4096;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+}
+
+static void size_zero_mock_decoder_sw(struct device *dev, u64 base, int i)
+{
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+	cxld = &cxlsd->cxld;
+	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	if (i == 0)
+		cxld->interleave_ways = 2;
+	else
+		cxld->interleave_ways = 1;
+	cxld->interleave_granularity = 4096;
+	cxld->hpa_range = (struct range) {
+		.start = base,
+		.end = base - 1, /* Size 0 */
+	};
+}
+
 static int first_decoder(struct device *dev, const void *data)
 {
 	struct cxl_decoder *cxld;
@@ -731,6 +770,30 @@ static int first_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+static int second_decoder(struct device *dev, const void *data)
+{
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+	cxld = to_cxl_decoder(dev);
+	if (cxld->id == 1)
+		return 1;
+	return 0;
+}
+
+static int third_decoder(struct device *dev, const void *data)
+{
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+	cxld = to_cxl_decoder(dev);
+	if (cxld->id == 2)
+		return 1;
+	return 0;
+}
+
 static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 {
 	struct acpi_cedt_cfmws *window = mock_cfmws[0];
@@ -743,7 +806,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_dport *dport;
 	struct device *dev;
 	bool hb0 = false;
-	u64 base;
+	u64 base = window->base_hpa;
 	int i;
 
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -767,6 +830,20 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		port = cxled_to_port(cxled);
 	}
 
+	/*
+	 * Decoders 1 and 2 of the endpoint under host bridge 0 should be enabled as zero-sized.
+	 * It would be even better to make sure that the parent switch uport decoder was
+	 * also enabled before enabling the size zero decoders but there is no harm in doing it
+	 * anyway.
+	 */
+	if (hb0 && (cxld->id == 1 || cxld->id == 2)) {
+		port = to_cxl_port(cxld->dev.parent);
+		size_zero_mock_decoder_ep(cxld, base);
+		/* Commit the zero-sized decoder */
+		port->commit_end = cxld->id;
+		return;
+	}
+
 	/*
 	 * The first decoder on the first 2 devices on the first switch
 	 * attached to host-bridge0 mock a fake / static RAM region. All
@@ -780,7 +857,6 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		return;
 	}
 
-	base = window->base_hpa;
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + size - 1,
@@ -844,6 +920,22 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			.end = base + size - 1,
 		};
 		put_device(dev);
+
+		/* Enable the next two decoders also and make them zero sized */
+		dev = device_find_child(&iter->dev, NULL, second_decoder);
+		WARN_ON(!dev);
+		if (dev) {
+			size_zero_mock_decoder_sw(dev, base, i);
+			iter->commit_end = 1;
+			put_device(dev);
+		}
+		dev = device_find_child(&iter->dev, NULL, third_decoder);
+		WARN_ON(!dev);
+		if (dev) {
+			size_zero_mock_decoder_sw(dev, base, i);
+			iter->commit_end = 2;
+			put_device(dev);
+		}
 	}
 }
 
-- 
2.43.0

