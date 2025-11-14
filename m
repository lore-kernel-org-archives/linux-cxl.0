Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874335CB9F;
	Fri, 14 Nov 2025 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156414; cv=fail; b=m+tgQlPDlASNbPFbmmb44ZebEPjg47iPyKjSm5zBK9Wzhdp2ju7QqmPE6Qt+rVBUp8T/YIaj/KVLWKOVE5ib+BQesPrWOVpcej/30Mvvb70OWfE7EkSqQ3M/op5/9C3ySxqbvxITqxlj29woszeCcusd7oXKGPVFIa6hexZ6Zr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156414; c=relaxed/simple;
	bh=D2nn/7d43b6StB+50Mrc5CzHNcdxGpoqaludcZ4hH/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktYY+ZoRVk5cAE+WM8oHz7BZfMhiw8TahipkcUs/xKCMX1N3vvM/adMFpyVp7AFD8rDC6CL0WxSjXrt7tX5k+7Oes1WU9kmlsGOwiSp2eWnYUXrVqqGQnVTnS3gA0xgfWMYg3MHZGkSnR+t7AN12vGOkemoq3AO200v0XJGyRdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nE0ssVXX; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nE0ssVXX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNHrqN3g9HvwbTTqmPiDjiaVe33xRfZ537HPs1YfUTnscO1h0HFt5DGLNn0NepuUinir872N9E3HOHo9GyrIeQHygwc2AMZf4MJfuYO5X16j1q1daVcc+6svcsMDaSdCnmRy18Zch7F0ftkTiKvTnr+AUh17Ey8aGDkQT047gH6iJs9qIsBUR5eG+YZdFYje+DoFpvGtWPQ0wOsxBGF3HZXH9VuhIOX86ApCzVSNrYMgRjSKJrh1Hn0/PArPU6s2F1X+pLkt0nKHcAJ5ZGKixzfWRoWlInD/AHmzVBaYOHjExm+ksZ3KSg2OE1qgS6hsGlOBm+ctDVcsxswhHDg3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXMZtfPyDB48KKByRPJ/uPczC4YfeaiH/bOpk5DLcQw=;
 b=CneXsAaszevoR/ophqgwj9dxpzat8+4w5pKuo+BhcNbXjNG9qNFTN1FoQLUdjfTjzK6rNgFtGoIEm3VcblCF6gOTduzR4fT2nsUmlTW4wTbI7SSgHPTTsG9DW9RSHxyGu2xxW6VXo1ADL9tO3+CPzMPlMYFSZV++XiH49dTZIFsJtI0X/lKkiGJMn4MDntUf5feRqw2iMa2EgHM3C01A7egyDZzfQOxfSWpyLLdjnsfLJ6+YeuS1vzh3MtMdyrIRZsgRYwyG5CeOZAHE9s6UV4oBMfQPEZrMwd8whWT6cnDE2wpHjePvmzNpbN0dnPfikPtBqv+8H/pD3s2zBWOvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXMZtfPyDB48KKByRPJ/uPczC4YfeaiH/bOpk5DLcQw=;
 b=nE0ssVXX53RA2crKZ5E+CrZJ9Lh4KB2B4YAFusguaFTFmnRip+8kB5iene02FqsMDowZZUxZ2Kru3bAT+bhmLomDy47Eb2qowIbLmHMmT32JZUwQgK7mPTVxYueuw1d20u1t1P77JVp2XzSQ+9eF7DZ+Wu8LVXWXN3BdDsWSXVI=
Received: from CH3P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::34)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 21:40:09 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::c4) by CH3P220CA0006.outlook.office365.com
 (2603:10b6:610:1e8::34) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:09 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:04 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 06/11] cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
Date: Fri, 14 Nov 2025 22:39:19 +0100
Message-ID: <20251114213931.30754-7-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 763a34ec-5ae1-4222-6063-08de23c6626c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmC+lEBHREeSSW6KlKeesxNTJNPg7DP94mWg06Ngg/FzRPwpQ7O2hFic4qu0?=
 =?us-ascii?Q?bKKENqYu+DHzlEgmmhcHT02ASFWnKCtT+AKmWcucDDpgp4MMdHhDXIlU5XRb?=
 =?us-ascii?Q?W5+wF1LGCNAMuH9mcjvvvIyVaB/361QJlg6r8ppJlC93vGyvc/9/4eMYCPH5?=
 =?us-ascii?Q?d4CZXhd+jZOJvOXvR1JqlGN9xOFC+1jegfLSb6uuMl/3xFVgm8a6R6C6HqId?=
 =?us-ascii?Q?iHmycfLUcHxCxiuY+lQTYSQ7x9XIpDOuf43SdRmHlWpm8gsdTB9hdaMTA/Rr?=
 =?us-ascii?Q?Xit18+z9WUZC1vlFLNpBFPN4SqcePbj4UopUo63klOJDHF6yjtb3EMnUCD3U?=
 =?us-ascii?Q?VR0zbXiYvSiiCqUnIJyvfLeXO51gJc9lJBhT3g4Fr7Xlf/6VqSf2ffzcueur?=
 =?us-ascii?Q?BOaAOtuJPGS50Dx19CyDNUnoRzGnBZcaBT1c8Anft3OqiWCJEQTg3EG5bUCB?=
 =?us-ascii?Q?Uh02gdnXTYsL0wqWqj+NlXOGJxnJRYv2uWJmDyX99BBhmn1s/ylPkct/38rt?=
 =?us-ascii?Q?avcSocrcfJKkPQdkLpcYqpFjtgV09/ly92Nawde9glEo3eaAm6SVBXBgW151?=
 =?us-ascii?Q?NgUmB59hn16jkC+Pu1J8x6IK1p2347LtYAIdPuHAXCUNFRrwMAmz3XqI8swD?=
 =?us-ascii?Q?nJsLZD8cvFqO9lHWRUmOt8hVKYC4QyFr/RtfyvVdEPJI0LyQuF1r0NOCti9E?=
 =?us-ascii?Q?INUAY+BosXArGRukYGqrf7msC6CyjmNomGpEpwFX80iVr0d/XZA+TvNAwoph?=
 =?us-ascii?Q?SY4Yu2Sk+bO/xJh18l1epAgsr3da0S0FA8UqIfsNO3CEg9v6uhuNW0oCFRst?=
 =?us-ascii?Q?Pk1Dw1XsITVATXnRYTwz4guUS3Liduze7unlnsIJsPbYfw9OSqLVyideZUZF?=
 =?us-ascii?Q?KnQQW/YmwdOMdhHQq52zi+ci5FhdDEiKShVGXt1OdtyFvNbOyieqEqn9gXI8?=
 =?us-ascii?Q?Wo581VTQjH9jpoNAaFA8M7eFBiS+FkJKX5r5pMj2nfCL5mm/4ZX8UrpDS+FI?=
 =?us-ascii?Q?T5THlX5GR7PMDYmq8Mi0ZQ8smEY/pgrwm/pDS2zI2SfWLIvBCtBkgcaiypl6?=
 =?us-ascii?Q?mmkx4UOIsiaMm8/5sFZKplWX4BWA+EKqjapQE8Mxr/oSfcVQnM05ep15b9K3?=
 =?us-ascii?Q?0he+gFZkD8NPnD82cQ0DYUYf/ZpZdYVcLndnMp6D7Xy1or4CpxkKS60dqIqc?=
 =?us-ascii?Q?Dd6b7BQpzNN7LzJFxR9Z/VdpS3mfGWn4AKk/GIPXNu40YbcELYhtM2Pyzkm3?=
 =?us-ascii?Q?b3/nPEQ5shijwQQSmYBD33GwfbSjx7sBM1lpjFPstFDQqCtIuEIfzxXJK0cy?=
 =?us-ascii?Q?r3tFyINobX25+XPWwmpBtG05JLZBs5CMOt42HfTySD7IvRAsXzcow3s+k2+d?=
 =?us-ascii?Q?6c0GAMMQTnFqz78n3tjfhnvh+wZnAhmxaC9wZII5YXoEm9NfUuBTrIUZ9bJm?=
 =?us-ascii?Q?MPYE0Ov8ToBSljHRBLP/PQpj4Dyg3RdXbO5wsTh2+OHcYHIUlvENs1KURSUF?=
 =?us-ascii?Q?Twpfj8M3UqzkDnBwr+1lUqmhBkFfIv9wpL6w2odGTCuSBn5dX6HQrnLSPVzX?=
 =?us-ascii?Q?W9qukbiGo7FBTeOMwOk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:09.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763a34ec-5ae1-4222-6063-08de23c6626c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
determine its interleaving position. This requires the endpoint
decoders to be an SPA, which is not the case for systems that need
address translation.

Add a separate @hpa_range argument to function
cxl_calc_interleave_pos() to specify the address range. Now it is
possible to pass the SPA translated address range of an endpoint
decoder to function cxl_calc_interleave_pos().

Refactor only, no functional changes.

Patch is a prerequisite to implement address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 52924006a10f..01d23a42a6de 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1832,6 +1832,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1844,11 +1845,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *hpa_range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1886,7 +1887,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1896,7 +1898,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1909,7 +1911,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -2093,7 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
-- 
2.47.3

