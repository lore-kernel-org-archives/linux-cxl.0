Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD522BFC8F;
	Tue, 15 Jul 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606762; cv=fail; b=WZPaqI6tiiPbE3EzWl3CfcJ7QjRDVGf1uajEyVEwQ6GMzXt3i+JIgcdDX4lXux186xIoD97oIvNXMDOJQ1UGTC6XSkRFt3hngu4vYlRCWuwhs4+yK+fPgsUizlnkv/IpRMlPpFRDMhyJMD4gTKITROf2AcBW/chAxpxRuqqhrIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606762; c=relaxed/simple;
	bh=YPflJ2iwGhrDOpZBmXmQEAoQ5Q3IIVhQAZNtjw7Nfv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsYx9L49Vxf9rlZ6a7IxVeAnE4SUlCmQeb43/mcSN6cOnVH+p1hq+NJwbJXQQxoClgN3DyZv8ud45m4FLxliWcbENesDtvntylWuGakYI3hnnNSWIxi3T3KfAhjU2XWohp84e4O2xqv1weOJfiASPnn4kR8bEPijwxn/z+yC8SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zzkIlVqi; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzkIlVqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQQs+2RDBj9xoS8+XuQx1EbQCqitffxSZ1kzT/KBOWJyNJ66ji/ehFZDa1IxiQ2S+Cgo83MjOuDggh/fjIxfgp/ETTaBiWHpXdKSxZ8vhwx6hGxXISq64gNRbZkg+27FxmCHVKJd59IFJjvTMgZi6dspJZwCoDMlMTI6fRBYdv33aGCjJJSb79bPE0wIQ91XDJ+IUwxQJk9ACvmm6dQTWGHzGlCEenAd4bft61k1kHm9ELhbmMQDx7G+CDFj4OWDhuTM1MqniPiVov7UIy1RfKjHpw3bAK06wTw5wuH+kTf6hVf+q1fm5LCbLbFEcAM8HzpT5+a+tUln5U0OmPgowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToaKCAv3br0JjcGH2sMDpHLhJlVnaJfLBO5Pui5UXzo=;
 b=czvuwWH51v1LLo63i0Evl7SSo4M5sgWHUu8FLZdGuLg76vaM1n0BNwzQV4ZKc63bexxNZ7QOfcmJk1UVBM4TVcoicWGmMj5Z5rMadkg5NHe6wsGarPyVTCi1UxbH+FXz8VumBbOUBMC1a6vN0OQaonnmoDjRUbOfKurexzgHmAkjrFiBgPRBVJOUcW5d/aCx9u2tRwUrOMt/yNPMHOkQ395KEcS+e3JAryzhwFXuEMM3Ue1kndN5NwxZgYfOfz+lJQnI2uWS9HYiF4yATH+6YofyE/LOMz9iQB+89FenzT7xL52b5qVCIdNBzldzvA0ADuZUcaHts1U5xR1tdNRVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToaKCAv3br0JjcGH2sMDpHLhJlVnaJfLBO5Pui5UXzo=;
 b=zzkIlVqiRL9cBD5/HTEBDuNqQz4a3cyZm4OoUEP55WmdamftgmbWY+4PD70DXB6CaOfX4C1n0o4TXPQS+4h3rlHvRPmiPS1oLDb6ESHTbAHPrpievlToHqzkCfckuOKdbFeOwmax8Ad4gf8l81fIasFgyzR26mXQOsevCpvt+D0=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 19:12:38 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::64) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 19:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:38 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:35 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 07/20] cxl/region: Add new function cxl_endpoint_get_region() to simplify cxl_add_to_region()
Date: Tue, 15 Jul 2025 21:11:30 +0200
Message-ID: <20250715191143.1023512-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 82910b2a-dbd1-4536-dd80-08ddc3d39083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TrsvExiT0gI/ux1gB/WryP4IvTcbRNdDt1qxZjkFY1vBBkx0cIkVpCl+2WsF?=
 =?us-ascii?Q?4K+Vm7HmrMa/mFk3wYTer5O/EVVTPnusaEfkPwc3nsq77gNNP6EVum/t6guW?=
 =?us-ascii?Q?rUw278dPwz1NEUKRY1ueIkx656qBNiXkOFwmOnEXi8MNGyiiDdZH2btwPHsv?=
 =?us-ascii?Q?1zZotkYu0Z3KALeMvapqfRYcRohM9dPxR5wpMVwttGbG9VpOEBm61U0ELgsX?=
 =?us-ascii?Q?Vowf5CSyx5ZL6c2v4ieU0RE/9huuAaFDxFQRAjjHg5b5GGdBI5QH3fTdkr/U?=
 =?us-ascii?Q?+wqa5d+Zb6edPql/rwLvF90Q16NsBIcmFKV2LLPiOVytE7NNbWZlDPz04Tzy?=
 =?us-ascii?Q?uDu1NZf9L/7ji1Th+x5pUYh/pfNoEVxoVBq8yEpAa3IzOPPcEVXfD4DWh4PZ?=
 =?us-ascii?Q?U6McswtBVZJupoEIAPVVidHmT5bNXoxzhMvBwX1xHciyKQ00YZ4gns6z+JF4?=
 =?us-ascii?Q?KhRz4jw2hXguWLWQxrwbuhaOiDr500Aj5NToWAMeH76AZQFXccv2WZNoP/sw?=
 =?us-ascii?Q?0gzkxoGRr+DUhgyKqnAIqnOtshfScg1GDQQDApxpFjQXSGKeWMCe6kFJ8A8R?=
 =?us-ascii?Q?22ylwISZ36UiviMn72nJugNRXSX/HG/mjcBhG8Gv57Vc0eIj8upaesiHrbgn?=
 =?us-ascii?Q?AowoqlpyTZDR3D7xYvVH4LaDMH2W9CI2CK9yl5iDNCNJqlNVoy+RdKvyt9Cg?=
 =?us-ascii?Q?7vYuHJ0QSawblD3Jta78OX6JsK+YO3cjIut8V7+9XAAgSBPG3d1JJF7UAj7J?=
 =?us-ascii?Q?naMrngECWgl+EiLdkTpxVDXHV65+vwYe6B8t7ZibTzuxpV2W7vxLt5GpCQkU?=
 =?us-ascii?Q?gmZAITO6teOY9jA2ScUfGnS5n8AQ/LfcarpX/TdxYr++e52Huh3TVj6UO123?=
 =?us-ascii?Q?oL0cC7CEyvBvjsRIq2dp8Aej29pT5TBDMGdUs4h3QgTg8dbfIWYd1NzLoatu?=
 =?us-ascii?Q?MNAkqzMDBRMnXYnZSAuNfh2iDPqHq2stCAJUSsekzewofHasIwzjnrnkAyeT?=
 =?us-ascii?Q?/fP1iZuuGQSE4VqtnE1jw++62L1sn6a6rWmbH2Iez5DT+TdT+0+RqPAOaiLt?=
 =?us-ascii?Q?TVlQ3p5DKTtTbh/3v5cOyuy0ID1XjAlq9P2XgsR0EU8O5FJanMiXrAirVkzQ?=
 =?us-ascii?Q?N0yJcw/eTW7KM8pIMpCy+OtgbSxSm6ciRBHJY5ACmJZH8Qbzkv8RsAyKdkgD?=
 =?us-ascii?Q?R7fxBdMaMBZXMU/RguPM3Wvd9BTYLtKCaY4cA4LyzQVn9vhu0uShV65ytSFr?=
 =?us-ascii?Q?8jzgIg8UgqLb+lPVuyUbaTOWSb6cK2ln2azn9ZSZRG/4tgT8qjHt0spDR0Sh?=
 =?us-ascii?Q?t2Rjrr6f//z+cTApJqSiPuHBucZA4m1xeZzWdPuMYVSt+f9X819FWSdDTM3R?=
 =?us-ascii?Q?OHyDudn3WQV14g1249ydtQcguFMYXJ3mUTY7kqUUVcp/DewZNrvAu6lZyCEb?=
 =?us-ascii?Q?825VOfIXohG3RLH4F3/2CJ7JcZqOLgFLCWpLSa/GJl9Lg/9MsAKqlYqKwZ5q?=
 =?us-ascii?Q?q2dqhGT/mAp9IiWsQc/lgyodkpncSNpGin/h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:38.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82910b2a-dbd1-4536-dd80-08ddc3d39083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

Reduce complexity of cxl_add_to_region() by adding the new function
cxl_endpoint_get_region(). The function handles the creation and
construction of a region, if a region already exists, that will be
used instead.

The split in two functions helps grouping the code, simplifies the
error handlers and further reworks, and reduces both functions'
complexity and number of local variables.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 760455c760e8..57ee758bdece 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3396,7 +3396,7 @@ static int __construct_region(struct cxl_region *cxlr,
 		dev_name(&cxlr->dev), p->res, p->interleave_ways,
 		p->interleave_granularity);
 
-	/* ...to match put_device() in cxl_add_to_region() */
+	/* Pair with cxl_find_region_by_range() in cxl_endpoint_get_region(). */
 	get_device(&cxlr->dev);
 
 	return 0;
@@ -3434,13 +3434,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *
+cxl_endpoint_get_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_region_params *p;
-	bool attach = false;
-	int rc;
+	struct cxl_region *cxlr;
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
 		cxl_find_root_decoder(cxled);
@@ -3450,23 +3449,31 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			hpa->start, hpa->end);
-		return -ENXIO;
+		return ERR_PTR(-ENXIO);
 	}
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
 	 * one does the construction and the others add to that.
 	 */
-	mutex_lock(&cxlrd->range_lock);
-	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+	guard(mutex)(&cxlrd->range_lock);
+
+	cxlr = cxl_find_region_by_range(cxlrd, hpa);
 	if (!cxlr)
-		cxlr = construct_region(cxlrd, cxled);
-	mutex_unlock(&cxlrd->range_lock);
+		return construct_region(cxlrd, cxled);
 
-	rc = PTR_ERR_OR_ZERO(cxlr);
-	if (rc)
-		return rc;
+	return cxlr;
+}
+
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region *cxlr;
+	struct cxl_region_params *p;
+	bool attach = false;
+
+	cxlr = cxl_endpoint_get_region(cxled);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
@@ -3486,7 +3493,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
-- 
2.39.5

