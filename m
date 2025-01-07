Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9421F37BA;
	Tue,  7 Jan 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259075; cv=fail; b=lLeUzoNxH1Neipf7s7yyF4i/+xFaj8cNoLr6L5s2xwRQJMYB3uutIxWSs4n/b7KHcaSU1LqWDtfc+u4EZUbfsvmHm18woG0xXZ3se0ho3+1Fmow2lR1cYdeblq+MMylKLG9NGELFcBp1c68hDp6aGa98gxJ9TWxuyD3cWEMxwhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259075; c=relaxed/simple;
	bh=GEBgT45HCyTyQX6vN1V3U6KUFqQlul0FwxLMGcduzBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1O5ZVElQthlchhNNytKGhgaXt+qN+aue/MVE0nIUKCyZbsVbcBIqya9lnN1fxEZG3XQlyG1wqdfgDsx4PHzrms9fmwBMQFK/TcZIclLQ0oPq4j9rx/ktKXtCziaquv6TcYaa4VzZF4fGPbB9nDvKVcQjl/1VJdtTOF7uq4XigI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c3WV9T/Y; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c3WV9T/Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anVbd4dBrW259mqzYjX6INXbCte8OBzmc5hxBZB5Gu7yAdyk8ZZmGzjCqM5PVB5nI4BcxbnA1Xwn2+FZj8uwq0+Pyzf41Lmp3ef7hp0uzM78ouMAVJRpQf1QS7H8mIkAjdIoCj+qtLIa3vozqjWM1OHP8VJrfOAVhaA/9F1Vvg2NvHfir6XvsFBLpRyEC+NxaIciinY6Gni9GdYX+frLc5K3JQIJ6USjc4aEH4X4MyXcLtgpsQs/SJ7Zpth8Lzo2OCGQ2QmAaZYr190S8rhs5qfHQG7Vt61xpiyiQE+boWriaqzjwb4IUA6i1irHXFsxt5dcyVDJICDKNzkgP2c8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRw3jMtytFaKXFztKmtkQdS2KYZAnLmCIu/YhHtVrfE=;
 b=nPHT9eIhOe53MB6RWU4T0Njfyq7Rzsok0WXm/Y9Oz1fSvHFqvRobETZamk7hhu8X7ZGYvmWnevW7FXeMo9xeiWdEoIgTsEp0LMD2DOsTSH8JoJDRmxQ3nU32DEmkyZjfbDTZDbjMMOV/6xUs+zJbcLUu1ydDdumgBfdAo8Yht228zZrJTbkhrgth++hBTJ6hu3UjXYc5Ki8mFhgJ5j8+j69Vc0GwUpIL4B1bRloaxGgJVXJOYUTxCPUP58Il3EbptGU994x2lfFVx6O+gWKwKtvsEJnVJ2BlKWvn+SmgshUwR3BbPWj/t/MurjVdf12BOksc9XDgwtagZCOI5tvshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRw3jMtytFaKXFztKmtkQdS2KYZAnLmCIu/YhHtVrfE=;
 b=c3WV9T/Yu5y3yqU2Bi/H3SJtxMIQ5YZYk2BeKTkTGFLa7JCmK0WLFqxHrGJ+GNjkkfEPCAopOK2CK+CHrYuHnJ+1WeuEspK6pwkd1VImyWmbnAA+xT5atRFJLYtCKc8dIOV/hBu2zQxnRfCXHPEhquYq1gJu8auTSNP+pwugn+k=
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:11:07 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::46) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:06 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:10:59 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 06/29] cxl/region: Factor out code to find the root decoder
Date: Tue, 7 Jan 2025 15:09:52 +0100
Message-ID: <20250107141015.3367194-7-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f79c5c9-282b-43f9-b558-08dd2f2520f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aUUn/X9g35ZhjXj/U5BAVAtmpVCHyjSX+36ivGvZ/xtdPvPjvRGCVc6L10W5?=
 =?us-ascii?Q?xQ+qqjKRxHvAKOywxoKRmWVr3Bb8hHIVLvkS5uZ3aHqP6uYShUCszW2WGRfk?=
 =?us-ascii?Q?/PHcrsY4yxAX9IoqmbKkKC85aYLq1aK78LxNVjihJxorr9uhS2XeaFpWPYgJ?=
 =?us-ascii?Q?KbFJzcwM6u61fm61ZKNBvnnrhGsQww7j7Ol06GuHhntglIsLUSuU5q8wlWX0?=
 =?us-ascii?Q?JF1ZOBVZy1juLhyLDO8JBXZzDAMeOqzJhSlzos8atU53NoRtmDElo1OBcJan?=
 =?us-ascii?Q?Y82ep5laZHCUPBaWcy90MuVm2viaSX++tQc36rTL8Rwomlq7JhOy9VTN6pZS?=
 =?us-ascii?Q?KYolRaVr+307+BtPIe754T6AG8uaEZNhgyNyE55Il1OYQtzHjdvAOw3kbH/X?=
 =?us-ascii?Q?60t0HgZO1+8q8cQT3dEhenyAZ2jkyKD2D65UJanlo0y4lsXC2Y6B4wjO+qOJ?=
 =?us-ascii?Q?x06r2uRvVHp0xyqCH08rbsg3hWbZwbmiJ9eGvEl9tAlN1WWatq045TtCSM6O?=
 =?us-ascii?Q?n6Zm02QakMmtYOXv5Wx1fDxZVRabdPitTmhMjCUwd/mKEx43of6GJWOWDnWq?=
 =?us-ascii?Q?46tZSuku1LWaczmK7pE4mAQ5lyHzu2LO45TYAqSOoICbq2BsMs25YKwCDfVU?=
 =?us-ascii?Q?DK4H+7mecqfH9313WTCe9Yqk5Jfkkuyo9CvPb82V/EKRsHxHrMQmuju6+Ua/?=
 =?us-ascii?Q?v/DREv3DN3UFrSaiyCKKXfzh3ETVc6AmzLylRTGFbWsg+3F1LCj0YnvnRK6r?=
 =?us-ascii?Q?vQVoAPfqWDVwaysy6QOlZNv0NFJuJy9GGxQAn0DNYPQ/z0JM/OVhNbt1B50I?=
 =?us-ascii?Q?uiFvVywH2Zg7UT2iHzJY6/mQ+v+1r+g4JzJvFQQ+JHS6uAzgoyVdTph6Z1hn?=
 =?us-ascii?Q?cJEjZ/RJWiOZoC4A5cVaEqBRyKA+8T6hSmLfjd8A6e9XCnfIdcvdLpquONnd?=
 =?us-ascii?Q?XNIAZ9k3E51rcDoKUbUfOWAclGWboMgqkJfUBAap4im2hvuiiA7JEKI0oGY5?=
 =?us-ascii?Q?EBkpS89NEx+QRR8fOTLiQXr24Cia9xFe28J8NHULw9krrwk7+rN0DFXu/Mn6?=
 =?us-ascii?Q?0i2hfzCX2+zDBBybIxcbEQJsxhoxuFRwK95miQMX6GXiyh7c3DxXsgdH+g5d?=
 =?us-ascii?Q?mDfZqhYdZIxSrBNl7MSbDr+JWWUnpzcjckkg2Y2OwbdykkH311MdA6YsANJa?=
 =?us-ascii?Q?skO7/Y+kAI31gPL/q/iPGfAPtDL2Lx6IXppHLJ/FvEX2s1OEgXBQbjvjInNn?=
 =?us-ascii?Q?4lP7scGcRzwFKcjvHHqB6UYxuzevZZ27qoqY1l6UZeHDnSxoeNJfeu7vfsoQ?=
 =?us-ascii?Q?RSYwqjMmtMArQA1Hf0GYZHybgo9sypQn61Wo3fsnGMoMnGjaBvSmw0SIsYma?=
 =?us-ascii?Q?WPXTlvVKda5rvwR+GVLChb8ETojNZu6rtgBYmYzV2b15qplVCqa0sHhPPzmY?=
 =?us-ascii?Q?gJifVgyd2mhWe61Hg1lEySX2KgsjlbAipswmgqNglimpJdzrwSZI6a16i1qh?=
 =?us-ascii?Q?HfqRwogO5oe9bQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:06.7988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f79c5c9-282b-43f9-b558-08dd2f2520f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

In function cxl_add_to_region() there is code to determine the root
decoder associated to an endpoint decoder. Factor out that code for
later reuse. This also simplifies the function cxl_add_to_region() as
the change reduces its size and the number of used variables.

The reference of cxlrd_dev can be freed earlier. Since the root
decoder exists as long as the root port exists and the endpoint
already holds a reference to the root port, this additional reference
is not needed. Though it looks obvious to use __free() for the
reference of cxlrd_dev here too, this is done in a later rework. So
just move the code.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 752440a5c162..448408918def 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3202,6 +3202,38 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
 	return range_contains(r1, r2);
 }
 
+static struct cxl_root_decoder *
+cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct device *cxlrd_dev;
+
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+				      match_root_decoder_by_range);
+	if (!cxlrd_dev) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			cxld->hpa_range.start, cxld->hpa_range.end);
+		return NULL;
+	}
+
+	/*
+	 * device_find_child() created a reference to the root
+	 * decoder. Since the root decoder exists as long as the root
+	 * port exists and the endpoint already holds a reference to
+	 * the root port, this additional reference is not needed.
+	 * Free it here.
+	 */
+	put_device(cxlrd_dev);
+
+	return to_cxl_root_decoder(cxlrd_dev);
+}
+
 static int match_region_by_range(struct device *dev, void *data)
 {
 	struct cxl_region_params *p;
@@ -3309,29 +3341,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_decoder *cxld = &cxled->cxld;
-	struct device *cxlrd_dev, *region_dev;
+	struct device *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+	cxlrd = cxl_find_root_decoder(cxled);
+	if (!cxlrd)
 		return -ENXIO;
-	}
-
-	cxlrd = to_cxl_root_decoder(cxlrd_dev);
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
@@ -3349,7 +3369,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
@@ -3370,8 +3390,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	}
 
 	put_device(region_dev);
-out:
-	put_device(cxlrd_dev);
+
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
-- 
2.39.5

