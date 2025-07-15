Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C942C1592;
	Tue, 15 Jul 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606755; cv=fail; b=L4nnTkgYjwO2BQJX2JxgMAz2agV/1ovdchCz7HUecMjqGEvrsHC0fyiwMr6mXOTKXywzGgZfvHBv76EAFxyoOSHdCbclA1IFAabjZO2AXkqXaaiJd40KnvJ8muLz9fWo5R6IzuEhVTo6RvqTTaAKr4suZv8XzXM+roIR0bXEiRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606755; c=relaxed/simple;
	bh=i+xYiQFoSj4rc0y0K7uu6YZfhpk3Fw69Hw0W33HvZco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAq6OpslHpJYlXLxtUesr1M9U+yRJiKXCNsbZ2RAc+LqgVCXIFZ3vlz6ZvSR1YcjZwmJ6p1iXNq48sZ2AJjcPuW60HZxU9jLushq17VOwjTIXipVB57A9UzvCPj6tpeJEt6RCTg3LtqtdU2fcm0WCglzmQU8okbI0C+CteJUzAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VNgKLKxK; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VNgKLKxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Euqm1o7qJ1w0Tdr0XvDSNBRRy+cUgLts4y3zJBPcvwMxSA26fpgptmmpFgS1vtFBDSkptbVoU1/ntmqFjZqBRPmrxlhU3ZHCrN24RQzu8nhiTrKSq/1WSe5OkQZwgNyXzeSJpjLVSyDQyijv6NG5Qn062JtN5w0KzcDfvdm2OULczJKgOf+heP2cJBBXabtaedja+2k25r4048VGLoU0CdDsuU9aqucwa6k05LXy/kHKjGhGIiLNUiHCoF48sdwm+YXuQooI43aV/GtP6RAE6ppomyN0IE/pywdGnPonqtcNpVJCvvAUFULgWwgIONHoCLTq+Yx5ib/PXWXM9piyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQxHZ/bINGh6Py2yq0MjfnNd2TrXpktrG72jjoy6VIA=;
 b=cRGuIuAGT1fymO5+uhqgOd5ZzME3tYjQDC2uDIKaiD2FeofCW1/s7G+ob1VDcBcrs4Q0ekpID4vxw8R5PSAHgkjpk0MX0AWgrDnY1R556FN8pPj0IIUoyIupOz4/nIlCHzhkwGNzPbILK4lQUcziCn8ezIV25beg5iFUkZM7qmnGEaUB5qNJpdVmzpQTwQJKlC4NxDEuOg1kLHiJhyJyLRxlehiTrmzg9BAWMY7egmSx7sH5a5lijZ2EgJNFZfw056cLJVkx1cdYqtKET+Cdu+UeAV1q6DrMO9nmj4zfYauw2pHbTMAfzAoL8eIZMO63VITQ26NuX6Ty0wctrCoGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQxHZ/bINGh6Py2yq0MjfnNd2TrXpktrG72jjoy6VIA=;
 b=VNgKLKxK/kQiIAqAf1pwFFacP0dj224qL0a9kA0DBkBfJ0u2vk2G+Th4R2Yy5sHxIVuPu8HetGqnrH2Ypw7sYybUUB/YF8rRHoPKrYu28vtZuP9tiZybwm5dOLIQhBWGB3s2fT+PDtBOuGa18PA3BhxR6u3jRkQ3IvlorzqUCGw=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:12:31 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::3b) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 19:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:28 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 05/20] cxl/region: Separate cxl_region_alloc() from devm_cxl_add_region()
Date: Tue, 15 Jul 2025 21:11:28 +0200
Message-ID: <20250715191143.1023512-6-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: ac094824-1cdc-43f3-3bc9-08ddc3d38c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvZ4VqIBV0wIo7zKyMQskso1d6AuQTmveEIIL0TdNLzSw/j/vPC5faKpIokF?=
 =?us-ascii?Q?Nb7De08wh5C+uY+qugZSkzb2NkKpzRZc5a9miehWd6WAWJarP+jSgWxhGIjs?=
 =?us-ascii?Q?vj/2jEq+Zusgw0f1xS2VOC9Xh8cjGqgbWil3G9yy/16osKcglir5slF2FvpO?=
 =?us-ascii?Q?2MZnQutrPo7UeO6/ak2L5/WxxHjmXmzwy3zRsg1KuzkAr6WU4z6veNt0FGYf?=
 =?us-ascii?Q?sEnRHDz7ppCRam6gWpG7NKjWi+tufSLyFNuduLU8LyPm1Bm1gxy4/FOlXRjW?=
 =?us-ascii?Q?842z4EY+aKvflpA6bwA+EUpTD7IZLkoTiiaC8PdbEwIDRmm/mI6RD9lkMMXL?=
 =?us-ascii?Q?l8Va1MXBv6sw4UcS348n/KqLZu4V3TbOBOGISs6jjlcAf1ivqRwWPNkvQWsP?=
 =?us-ascii?Q?niDNK7hFcp0vbI0HyCnZXoq/iaeiQV5z4D23DvLSXTjuIF8ENGyYLD7d/nxG?=
 =?us-ascii?Q?xux5eBMKBfl+JETXO2B2jgPi5OBg3nNm+Lfb8Cdmxef8E142ak2McnTRZCpm?=
 =?us-ascii?Q?E5UmbB5bXEZr4KpS+tJb5oKAb4oub+ninwkznIlwUhYViCN0y2EYSxhhQYR4?=
 =?us-ascii?Q?sGpQPKydvVxDXcnhvtnoPLIAs1gmrBET1TGiyikYnqUqHUmoXZKwszaHfdFT?=
 =?us-ascii?Q?bgzAsBraICSh/EDbYbHGfl8g6bFe5hxdDV/lWzle/xV/OB4uKkAB8lknTRCs?=
 =?us-ascii?Q?BACciT7AVCNgBh/dUYTcK2LVY2xvDjyDTNkbB1EApswd4sKIOBq6ZDSCWyyL?=
 =?us-ascii?Q?bfrL1DxIPVYwSkKQolQwfInSzrKPRcvAlMd7SuwUPv61hVmom9g4vE9LcmEg?=
 =?us-ascii?Q?hUxgx6sxC7yjw3ITzLzg/ir8+qADM3QUTsTZ/P7XIlG9hBI2QwkO5SPTOuhZ?=
 =?us-ascii?Q?W77+cq0hX8MMVTZb6JeJU/DVb8gcFtPK+tP7MY0qxNeF8X9vsj5ZRWUlOYWQ?=
 =?us-ascii?Q?nw/N4+MPsfw9cnVCYmiBb0tv6e4cGQhznh9IqKNNbRqHXKytynunaaappzna?=
 =?us-ascii?Q?G8EXkwDbJNmcnhEQRZg7ZOy8ajzLJcQUUZI4b9E+mVbjr4r2KxNY2hF8gFj+?=
 =?us-ascii?Q?WEBwNXcKE1i+TVVj/sJ/kDOoOiIauFZhPMrtE8OYB6OnF6nVWrVCYAU4Jufo?=
 =?us-ascii?Q?gwGuMRdwboefgXgsxa9LvLh7LUgTJiwdxBNyJWRaSjw3z2xttAVG/+jiBCXY?=
 =?us-ascii?Q?NAD9/J6twZIln3acRcqwZQOAOulaxZzOhwTQk2OXcKTAlY6cTqyoQmcThMbM?=
 =?us-ascii?Q?g/S2U2RECk9BWQCU/kZyylfhOWqbBp3StRqFVMv8M8VGkdpne01eg96y1NW2?=
 =?us-ascii?Q?5fvsBIbt3oCbbG+M3o/g+UkrePUFbMLYxIMVCOq81CCuGenJdj/CY1o+wpea?=
 =?us-ascii?Q?jMNspLPSrcsaIVuUZrCkjzA0bbi36Ofq3XKzGtp80yHTx2OBPyT63cqfB8o6?=
 =?us-ascii?Q?6GrXrNF4kfCdkcuUPh9uvenN8JreIH1vpeuhfRaQixzlISM9wy4gqumSh+Pd?=
 =?us-ascii?Q?aenbN6YPWP+BeNZubL2Ghq0iCEFQwMb6xwrX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:31.5222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac094824-1cdc-43f3-3bc9-08ddc3d38c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

In interleaving configs multiple endpoint decoders connect to the same
region. The region's parameters must be the same for all endpoint
decoders that share the interleaving setup. During initialization, the
region's parameters are determined for each endpoint decoder.
If a region for the same hpa range already exists, no new region is
created and the existing one is reused.

To simplify region setup and the collection of the region parameters,
separate region allocation from its registration. This allows it to
allocate and setup a region before checking the parameters with
existing other regions and adding it to the cxl tree or releasing it
and instead reusing an existing region.

Here, only separate cxl_region_alloc() from devm_cxl_add_region().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 41 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8e2521c6c845..cfcd286251d5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2525,34 +2525,26 @@ static int register_region(struct cxl_region *cxlr, int id)
 }
 
 /**
- * devm_cxl_add_region - Adds a region to a decoder
- * @cxlrd: root decoder
- * @id: memregion id to create, or memregion_free() on failure
- * @mode: mode for the endpoint decoders of this region
- * @type: select whether this is an expander or accelerator (type-2 or type-3)
+ * devm_cxl_add_region - Adds a region to the CXL hierarchy.
+ * @cxlr: region to be added
+ * @id: memregion id to create must match current @port_id of the
+ *      region's @cxlrd
  *
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.
  *
- * Return: 0 if the region was added to the @cxlrd, else returns negative error
- * code. The region will be named "regionZ" where Z is the unique region number.
+ * Return: Pointer to the region if the region could be registered
+ * (for use in a tail call). The region will be named "regionZ" where
+ * Z is the unique region number. On errors, devm_cxl_add_region()
+ * returns an encoded negative error code and releases or unregisters
+ * @cxlr.
  */
-static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
-					      int id,
-					      enum cxl_partition_mode mode,
-					      enum cxl_decoder_type type)
+static struct cxl_region *devm_cxl_add_region(struct cxl_region *cxlr, int id)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
-	struct cxl_region *cxlr;
 	int rc;
 
-	cxlr = cxl_region_alloc(cxlrd);
-	if (IS_ERR(cxlr))
-		return cxlr;
-
-	cxlr->mode = mode;
-	cxlr->type = type;
-
 	rc = register_region(cxlr, id);
 	if (rc) {
 		put_device(&cxlr->dev);
@@ -2589,6 +2581,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 					  enum cxl_partition_mode mode, int id)
 {
+	struct cxl_region *cxlr;
+
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
 	case CXL_PARTMODE_PMEM:
@@ -2598,7 +2592,14 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EINVAL);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	cxlr = cxl_region_alloc(cxlrd);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	cxlr->mode = mode;
+	cxlr->type = CXL_DECODER_HOSTONLYMEM;
+
+	return devm_cxl_add_region(cxlr, id);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
-- 
2.39.5

