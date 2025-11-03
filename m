Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D43322A25;
	Mon,  3 Nov 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195763; cv=fail; b=pC/z+cGqkFMTdobNVe9UMrDS7n0vywF+/iY3vwdnPaD7PwecHB12c7PLfdUd84yzWd6jkxjai5Yj6vGdZzNHiGZCIcb6t4t6QB7ltY5Aw5LeSoxK7t5g0aE5GUR3bdz1nPXrQeo8oAi2hh0MfbkNNh7HlQUTYpDhmJPuRTLllNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195763; c=relaxed/simple;
	bh=T8xuaNGQp8VS9lxxjwJNLF13GT3fzcVepTz2Epy0K/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VF2Hj4bVL497hoxhjJyg4yEq1wpCp5JnZEXhZAZPsQoy1hjtSoGvSemL7JR88+s8wxKLGKRwIJdg3xqzMmllAifZaCShJOdcKfYygQnRduM+Vg6kCmuq+iT+Tr2nHumLOCBp7AWZi+X/Yxz1ogD4nrFmsK7Y5WyTSEWvVg/jKGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jDqmoKDq; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jDqmoKDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC3A0Zcf+8taGIQbvrcp71EMOmmCIEuPC9Ph/VGM51o1Y5hQQh/PiNDv1REsPnWPbs+r5r7E+TRTfXAyZAobyfOGNFgUT0MCRbQNV3RYNmzDtU/yOfKjBrOYPKOv2TI3Et0Ro7bgNR0b15kyyNtN7pE/JoxZaEJNNWzUmtPhBoCLnfHdM0Y+ArMZts+iXJlrNZmFqTDlp8+l0mIoui0l2T62yH/wp0KMFQ972gSIYWrCMBVy/ZxkKGSfzFBtnILxbD6A032XjRv8ydWuyFWM7Tubv16kU+anS60eSjOdGVmgMq4xQg403iIqD2gfoLBTa+0icOj/t4+e+s7xIe3VEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyamaiFGDSycYeTgdFLQN5xH6yB3BISd79IrjlY7ydE=;
 b=Ni3Q66yQOhPg5NG/t33VmQz5fDWSYthv7uuYYzYpD25ZfB3FTnRokS7mg+Akk7PJr71WwCY+rcX9W7i5kzaJssB2jD+/sfYI7VeiCrTr5JRwtuGiQ+CSI9WK656IFPo+t8YnjL0CNmWDoLiB+hp34r2oWNlCQsZBJyF8+E47ibkY73xt75S64mxeNRmnHvBwbZW9oRonlQEqkD3j4rqANKhalEezHdg2FmmWfheOl0wwzlQKhn92mM++vdPtM9/CMjQ/HtKolAAAWsCq2eKNVjDYE0dCFAR3zk/Z6/QXehYh6uHklFWaG0dD7ZqMAVPavmR7LA/dSWSefqrEOQBt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyamaiFGDSycYeTgdFLQN5xH6yB3BISd79IrjlY7ydE=;
 b=jDqmoKDqQmT6Nu6WX76NfHwBql3+MMq15E/Om8oM3mBckmR97UduG3Q9eL21OLUuqSmWJ/LX/7XXPGJoA/wukm6+cSFpDA6o3+nhdQUZbxeMUk/xXxOeGAjuMPIM4pqLXKpso/Sy/axwrdwX1tnsErSvnWBMIgMe+MYLwFLAKig=
Received: from MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::8)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:49:16 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::46) by MN0P223CA0017.outlook.office365.com
 (2603:10b6:208:52b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:16 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:11 -0800
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
Subject: [PATCH v4 07/14] cxl/region: Use region data to get the root decoder
Date: Mon, 3 Nov 2025 19:47:48 +0100
Message-ID: <20251103184804.509762-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b47f66e-3c19-4a7f-5924-08de1b09b0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43NXJi85ijgJWoqL113SfjdvWFH8cg6Xs2cBlyuaBMR16mrLLyQRDZgdqmOQ?=
 =?us-ascii?Q?0YZDN0RCoLg1gbsOixJV5OyhkmikumKLkM6cKSFbUhmLMhxRUVWFuY+bdceC?=
 =?us-ascii?Q?0yYrwMTOE4oQO+QX7tbcfX3DeD7xFZXW3aOVAKxNk3nT2WOZYZy9JFyRYevh?=
 =?us-ascii?Q?4UNuD3WJwOOXoQV2AhrW6n3x2gmLZrYkZWCi5NTLt4V9hUNvsay764lu/D4L?=
 =?us-ascii?Q?CQB405Um+upV2Zch/lx3HxR0sb8CKopOazbrWNU0NK78vghSoukcfYli4ogo?=
 =?us-ascii?Q?NfuCT4kHN75o/TNxhwKBtbDGw+Cf+IR2+i33dzs/2k709ylvCIapyj28O6Uv?=
 =?us-ascii?Q?r86DA04A6kLKaEK2jgKazT8v8oTCvm7kIK37L3RYOJzIgFZ/otdDxjZhPAtY?=
 =?us-ascii?Q?xP7SyHZwjnKmq/bLsyn47cOhFm98cx6Dn2II6afPqEXqw8QMgF0iSzYeSV2N?=
 =?us-ascii?Q?9xDQUv4JHgGngP/go/B9eZpl+Fb9uJBxu5vGOkicweJpRLNrsmurWKcPkEoJ?=
 =?us-ascii?Q?Ou6AM42omQEM8q3xkJ7t3ZcXHr4BLg6jBrtF01WresVQrMISoRvjMZTqNm/d?=
 =?us-ascii?Q?rILdBk+kosSXzyXWEx3xCHY9ix6WGAEIw4ZZd+YfnXlDtPVM3vSPpNzGGCj+?=
 =?us-ascii?Q?fx/EfStUrkFCRpcqc7AqCRo0OgK4kBxtL9GBIEy/CLR9AQ1xbIUZ3IO9FonN?=
 =?us-ascii?Q?Nfw7geji3S6LvKhFnawqgUFrD9TOGaGfcr0QFWWp576kKLUe7bfDXIx8Iuix?=
 =?us-ascii?Q?NanzuMQOk0RJT8lBk067eZiB9bcOCSDX2ql6AHmxnjoAJf8lsnd0X3PoQm6W?=
 =?us-ascii?Q?L/Jps0jPtpLlSlHP55/7tpFrRASg3k4XvmQmqDXJ7c7r7WFM0FUVboj8l5CB?=
 =?us-ascii?Q?lsnqkt7xLVltIjdfKBzSCcxkyQ98WzClBSTR4dcFzKz+i7GHxrKGf8B7BVJ+?=
 =?us-ascii?Q?2zCyMVHWJWaUPIJlgjwHy8K0f6V9Epi+ZcPyn3eXXdyuG8JYLtpHVZwQ2II/?=
 =?us-ascii?Q?DzCHHtM254ZRQza4RaFC03gNLAZ1TvbK566Pl2F77csj7YMjlWM7wdDWbic5?=
 =?us-ascii?Q?xzMI7X4yb2D3fouF5QT9FmWAIbJxiO7TXbA0cYOZxHjhuXuG0cYYhZUYFcTz?=
 =?us-ascii?Q?TltjbZilBpOKzyNCQA3f3PN4zgTasF67sXHhyUT/T8i1nMkBtZ9qiAQLpZck?=
 =?us-ascii?Q?NAUoc0eXCyVBI/iSYPYpI0gwiEvj4L6RJ5OrgLUl2UKGudK9C1ifDHmL5EVC?=
 =?us-ascii?Q?cXgx2apkAscuB6QYr/VQNf34b0c9t0e2zksC6XJ9yNsM+6GWABeeM2QJkood?=
 =?us-ascii?Q?u/1BbPvc6ikSSpL8yUJKmEu3pfyNQ2aKVEjp4PWo4nciGYeIwWX+Vlq0izIY?=
 =?us-ascii?Q?E8FItmZj9Ftmp7hRRBRJvq/fjeatV9xvlf1wY0QBOIVK5OUWd3SR8Catobmd?=
 =?us-ascii?Q?sj/M8hFZYDRkPbWt9UroJK3c5LmofGfgL62agRVEgQROgRpC6lqx4CULVibB?=
 =?us-ascii?Q?RissC1B6fyOb1dUBy/1P8gIz3fdFZtnaTvdjxMHvu+rak3BPPHVAmqZmR+2p?=
 =?us-ascii?Q?ONDVS/epr/BJgif/FeA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:16.7060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b47f66e-3c19-4a7f-5924-08de1b09b0c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

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

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 50 +++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2cfc29a2b588..2dd9e9be4889 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3350,47 +3350,39 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
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
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
 
-static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
-{
-	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
-						    match_decoder_by_range);
-
-	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+	return range_contains(r1, r2);
 }
 
 static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
+		     struct cxl_region_context *ctx)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa_range = &cxld->hpa_range;
+	struct device *cxlrd_dev;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
-	if (!root) {
-		dev_err(cxlmd->dev.parent,
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
+				      match_root_decoder);
+	if (!cxlrd_dev) {
+		dev_err(port->uport_dev,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			hpa_range->start, hpa_range->end);
-		return NULL;
+			dev_name(&ctx->cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(-ENXIO);
 	}
 
-	return to_cxl_root_decoder(&root->dev);
+	return to_cxl_root_decoder(cxlrd_dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3584,9 +3576,11 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	};
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
+		get_cxl_root_decoder(cxled, &ctx);
+
+	rc = PTR_ERR_OR_ZERO(cxlrd);
+	if (rc)
+		return rc;
 
 	/*
 	 * Ensure that if multiple threads race to construct_region()
-- 
2.47.3

