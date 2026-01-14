Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32073191C4;
	Wed, 14 Jan 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409354; cv=fail; b=hcJ/w4Mah3hsswqDbZn3X+n6Y5zzlJIWL+zhN1ac1vFv14LUrKaLdSiG18Y4QRXajNW4/Y/1mY+pw1U/SH0rnzqOoGHQNE6Ohd2Hzel1GLBsamzvfHxad8k8oFTE7TSKxkuZxLY1mRAS3af8dcfbtBhEyx9/CMkWLsuppQKVeXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409354; c=relaxed/simple;
	bh=6jdHxc4rHQWqGcLuJelwLC2kPoIZnYzrMQGPkO/9LVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYqCIGA2o6kw3V2hF5FNcqbnYdVHNzhfe4qMAMvw1GUBs0Usx3zUp0BQDopi+RKIEqw8x8TohIfLBwUkEpWZeXTpvIlr0/DnRC/v5XZoTvmkj1UFjXRPnv747tvOPbG5P7CKOKFPOi5dcKHh18kUDoBA5dOdHcIV4Sj7eBVDbOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5tLFc/NT; arc=fail smtp.client-ip=52.101.56.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5tLFc/NT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmVD+pmdJSFNreZGSZhWqBtYpPkeoAzvxMZa5GYtqFajQTAkim3IZU0lO1JphrthYIjk5vMxGFQhVu1K0GuwzqsQRmh+F+Bzqh043+lSZLtozv8ya1xxIHxzgkUgTRPfhoG71TJkMYTMKB7b8LQZZWFOyl9Dh572vg8egRxFaYXq2pB9MKv3u8mlx0/WvN078U/l9hL8tSA36AmAGIEQj+bJFQiDbStc0rFFLmVoU4iY2NyBnCPRk7etA9en6pnd6Iw/wyGS3LZ6vZ5rUKrLksip28Ibpk3mcmfQbh3FeVhcqA0r8jdBCJQRNDbZCYqm+xtveyqCXPeLGGNb1cdFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tx2eWF8JbUnDyj5N18WVpH+gvpW9QnGcwP8EmhyHQM=;
 b=KAjILLzBX3+BiYSODxEtywXRm/44djHYdmAnYhwEjZad/+yIj76vfpusRzkTpuP4mpEcgf7xxo/E+2KxuczcHksQR5+SKwrJ9ADHBEHix3Yfu/P7zltWfriaXSywOFpnYAn/ReH8lOzDCFdpTAsG7I/NZLFepkMJxfejq3uokcsCfCKBjrFhJSDIUceTH4ZrasmLzDMybilx40Cjknh6k2zESTBDgnYEssZG12xzoUhpKBaI1eQYh8RjdB/LgGT/sw2FTXLX3gY7kE7e2Fpt99LOURkhDSU+e3Qtg7+gbEhyluoLbvvnW/a+sAp00BFns40BfVMjhtBvCUsvEVbdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tx2eWF8JbUnDyj5N18WVpH+gvpW9QnGcwP8EmhyHQM=;
 b=5tLFc/NTugbBPzTA+COd2PNA+ChEKjlsgGhw14Muf9lRNCEx37JJHklr/hwTknk9fu3Mgq66RVVJWr4AHoWr8PBFuXWK8axp1uIojN4s/dDMJgPlFDDo6EJG3096pstio0cVapRNq3yNRxZt7iZaa1T6MNU1G8+OYRsZuUchXkU=
Received: from PH8P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::9)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:08 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::6e) by PH8P221CA0004.outlook.office365.com
 (2603:10b6:510:2d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:07 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:04 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 01/13] cxl/region: Rename misleading variable name @hpa to @hpa_range
Date: Wed, 14 Jan 2026 17:48:17 +0100
Message-ID: <20260114164837.1076338-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f1b3b1-680a-4caf-8114-08de538cd5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?audjNIBVYMJGKGcaxzqYqYVyGEzlQjYFKzo043tVCxJHWn4Yfv92YFhG1n2B?=
 =?us-ascii?Q?A3Fc0LrtgFyhEJ8hxx6VtUeDw5o9F7EDrLa2ilhQrnaMMqvD7OOus4lamcB+?=
 =?us-ascii?Q?9n5t8yGBhynS+LblzZ+T7jfB/hK9q8w4cazgy6lkRrKpDmQ5BxhmI+RQ01Np?=
 =?us-ascii?Q?+GNgYFV0a24XOxkGdFB5u16CfrvBcs9B+u5h2dwtrCdNvuJKzpQaWdF+BfGA?=
 =?us-ascii?Q?fu+DkArYUJVwcCjFq8/Q/OF7balzfM1MjVd0rmQ5za1DKzRk1Bd1avlaEdfV?=
 =?us-ascii?Q?dDTr9QROiJ9RfZ79ojx07/EiVBrDPTRJukRQP5dHUAxDe1T289Ygbv9mCtNZ?=
 =?us-ascii?Q?PUjs/bp/pQgoS2wcvMtOEOOU+u7ClvAg7nMfVhGCVhdAvKI2IFFDJolX9b/k?=
 =?us-ascii?Q?gptyPrkLRU5B790TOpVMTFqbKeZTpf3FXubjUSgg4L+WoM1+GjOI8NUSkgod?=
 =?us-ascii?Q?gghI5TBfvpJz5nj71DiUeDZ5wwh9LSQLyAblQFuUAv5B+XID4/vvsxtVET16?=
 =?us-ascii?Q?44NE/0/g8WI4y0pvS4i/2PFF3tJJUXRktTavJ7z86TRLAGIDaYijzUiN1pW3?=
 =?us-ascii?Q?bRfoOwdBHqSdiMOx2RcBzuwTsa6ucV793v44AxZ6D+7YvHGsU3P1v3LBi6oH?=
 =?us-ascii?Q?U7ZhqfnddcUyjmk718R+D7PnjxZpMxeLBtK3py+++7QLSiezqeRLRe1SSR+4?=
 =?us-ascii?Q?h6I/Lw8h62oLSPW7X3gpndZ1HATpxzrDofQwZBFWiG29wJ3yECNv3r+RGQw3?=
 =?us-ascii?Q?vbzCJ9ZqvEnBadrlhbGxoJN5DBs0iakqHFKfJk8dFNzBdr7xBeeVQFJ7Dfbe?=
 =?us-ascii?Q?8kUE+VC4FM754WF237bPFyDRFt3GGeQZMBKmNRbnow2S/ijo00iWtK1W+IeI?=
 =?us-ascii?Q?N5cAbDMJC9GDHcBqSP0QwRt5Vj+SF5YD1q6P4NfVwCkfESGiVUPv16eHeMLY?=
 =?us-ascii?Q?UeYjs5bBUz5Oajnd2drQPxcPSQCds5dJgJ6XwsJ8w4lSndnYXI95fAbrZot8?=
 =?us-ascii?Q?63JjePeeU6csZN75kZZ4P9urJt9cq9P7srzUVMMQR76BNvc79xCEtaUSxdYW?=
 =?us-ascii?Q?9O+dyG/zHyEHEEFBKSFGcRqnfZ08gJ6vkK940VEIw7zj+ktcb5vDDcdAlbbY?=
 =?us-ascii?Q?46/k1YIyMLA2KUQaRNjmBJVlNt/AFqwsx+Bn70tMY9ZA1lnKRJR68rBqY2AR?=
 =?us-ascii?Q?gKUsaZ4mUTtJZvVr7F8v1/AVcqxnNqWufHg6CH6Cg3JfWAOHEDAaKxNPj7Xb?=
 =?us-ascii?Q?NWB3vRoov/o9D75FHWIU+A4QMiu8bGVPJbj1gTmtR3AKLu/wjZ95KHdptvAh?=
 =?us-ascii?Q?H7ac040s4X0PIT9RNNPYGuqavYNfsf1+AtfgPbMCivh300YsXq5mFO74jybI?=
 =?us-ascii?Q?p0lycp/03jD+gyqj+uPIcCOt/FpewVK7mCN2LiGU8O17FvYSjGZEKIjzxNMK?=
 =?us-ascii?Q?k/sVNbyUaf0lrnzsJPfm8mp7rRXvV5EJSgDzKiNqC7bM1V80iRef9rYqif/L?=
 =?us-ascii?Q?lRWTGlAA0SulW8ltYwE/v/kKX2gR86NXSCsCQo1p4SA4ZUGrKcc5I8j+tMmq?=
 =?us-ascii?Q?05ZXFWjWz/0B7fPnTRMenD0Gh1VbXXcq4BKs3QV2K0mPNMQjh5VWlnGdiJcX?=
 =?us-ascii?Q?6G2EWstBuWASgencTc+6Wb+FkGlHaqyNNMIp+HaAQxMeTUr5Ng+w5/lYqdYn?=
 =?us-ascii?Q?BgM/Cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:07.7439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f1b3b1-680a-4caf-8114-08de538cd5a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179

@hpa is actually a @hpa_range, rename variables accordingly.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..51f1a5545324 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3474,9 +3474,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
 }
 
 static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
+	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
 						    match_decoder_by_range);
 
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
@@ -3489,14 +3489,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range *hpa_range = &cxld->hpa_range;
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
 	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+			hpa_range->start, hpa_range->end);
 		return NULL;
 	}
 
@@ -3562,7 +3562,7 @@ static int __construct_region(struct cxl_region *cxlr,
 			      struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3583,7 +3583,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3666,11 +3666,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 }
 
 static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
+			 struct range *hpa_range)
 {
 	struct device *region_dev;
 
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa_range,
 				       match_region_by_range);
 	if (!region_dev)
 		return NULL;
@@ -3680,7 +3681,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
@@ -3691,12 +3692,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that, if multiple threads race to construct_region()
+	 * for the HPA range, one does the construction and the others
+	 * add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, hpa_range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
-- 
2.47.3

