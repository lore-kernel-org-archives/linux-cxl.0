Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D636302CAC;
	Tue,  9 Dec 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303730; cv=fail; b=H2d2f41Mjf5osRI7u7G+x0EyGsyMBT99f7PNYeb/d1U2ZuPWn2Lw7OHlI79WVmJMZn8JwPGzkuENFmPPW1sLwjBAex8EI+UoT9h2Wl/GpbRnYhyhQfO/rohXwBw0VFaaY19ruTsnPNhkFs6Ik6EqtgFiWH+1umwBFFwQb3qoPC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303730; c=relaxed/simple;
	bh=uHI+W0cT9ZhI8JScrgO5GFr63Zzeflhw2IuwKi2h9+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYKgqaxpB2OI8lHtHf5Qc4YM1RhSXOzyMl7VF1o+nhKbP+lpKgqar1BpcFoySdeDyAHS+YzrhsK2aPApcF06OQ2+xA7DXBFPhzP1RMQLD/zxOzzFw3DDz+fKM7xCm9//6CWqQgHsvpuKVs6HbtcadswsAfJN7a4aqMN8P9OD7oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5AGgm3ex; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5AGgm3ex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIzfMwwYIYjPkX7ef1zAVsE9XDiwXj+sHYw/C8bXlP7NJPasm4mcww1i8+AIwohipM0JVfKIV4rFJGwx2lhvFEjbQz7EnaH8FUTK4/+Rairdcti/OzUWp7vJuJ9rlMhNManQGbDbq1B49xIFsHIm4k1EpzFzjf7SBlIwyIiUj4LE6a8jSp7JYf/fGlL9wGPBfPQiAQEkhrUNgQerRVhDqrZlWbxF+GRK+5p6tg1OYCkPhX+IF2+Ea+GM28Y/ZTWK5fF+GCJTzyRgVtoc674Eb4L+Nt8Re3ZmoThnnVtrXR5VQgS0spCSXppWwwz3TeCKBGH67PLM7E0zfKIPkG0qgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIw+qhrhHtmt6GazXqtiTu/Sp5xn4g2JerECWJD9K0U=;
 b=nCypVOLeSz1mL2ebyyNDInbL7nY8AQ5If68u6GhBypw8BpC5tk7ozY/FWKzi8om2razI/xd/bjW5++QPibBSXZmX7kUOwtmXJd1/D0d92h6tAiEXirzZtJWdezYSeXqfYZfSrXauygqV+HMRVXWW98dZEuYhRDT8o+tSmKVb4O8iSY5Cvfc2Fe1ichEpjDeX6QKytePMezBzWt2OA298JnY8lrhG7SYOFE8hSwK+zfPHAnFBMN2nar7mQ/0GuoBEDQOsVI8V9lqtqgMBIKzXon8GovSpRWTLOzBUYXj1HufwGypK9uwCuFr6fWnslOtWCcxED9MTjBUENphMUYt3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIw+qhrhHtmt6GazXqtiTu/Sp5xn4g2JerECWJD9K0U=;
 b=5AGgm3ex0FVnKDW6Hmq7JYF3qoqq60Xvs8SCQON1JCQoCy5VaHqek0JJwdsREZKyka8VahqDoYt1yQpcc20N86ASqp/kPkou5WwJ9/LW4ONGqIOGVd1tE+IDomhxWa6JVTrRmlT4PnQ0mK5qFY5PkDSgNb4/k0/A2uG5xZVpAJk=
Received: from SJ0PR13CA0086.namprd13.prod.outlook.com (2603:10b6:a03:2c4::31)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:08:45 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::11) by SJ0PR13CA0086.outlook.office365.com
 (2603:10b6:a03:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:42 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:39 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from translation functions
Date: Tue, 9 Dec 2025 19:06:48 +0100
Message-ID: <20251209180659.208842-13-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e9b60-389d-411d-eeb7-08de374dfcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zUiEXoJPI73FlnlgTuOUuxRFZkNo+A+C1j1aw9st+VdfkggxZKyJyMU6so0D?=
 =?us-ascii?Q?K1vxNzt34CZUnI/61XYQJOYNSXkiwePw4jv0NjdfR3392VgKQ6BU+fO/Lz68?=
 =?us-ascii?Q?XwKJ3SKXgawWt6HteTRGpQegiDlWwb64YhzGRJx0RVAW9WwcGjNt1HL63qqQ?=
 =?us-ascii?Q?17cp9rnYBzWw7EMm+oiK9oONwpRFrmV/69ge0A0hBBrvKBsPybbG42cVerBt?=
 =?us-ascii?Q?EvG90dQQpsKVgF5rIhO/GBW1twkpyFP4uls9vl1sXbXuUFsH4lYNgPZ9pje/?=
 =?us-ascii?Q?qSRlYNazMoK+ciBNdQCNTTctFlzGQfNRia7UBRNfOrYW/Vqj6khUVyVRSIdk?=
 =?us-ascii?Q?LjYBXCngrz/NGUr41YfGgI9df0rkHe8I8eL6DWhwL3weBSxzrcWQly3l0UNf?=
 =?us-ascii?Q?f7+Cu6r3J/gjvfS+6WcO1zhlV1GBt7rL53stcHvT2cuiMEKYpk5u2HSHeyaY?=
 =?us-ascii?Q?qC0cFE4hPmdzv7n0q1MbzO8qI34T4O+jQeZ7k8eqtmzQUxF3YCOfN/hkdhEp?=
 =?us-ascii?Q?invudN/Vz+nwqyRXFzOeZmsAs+GIuSTPowUMdmBeoAhs12MmP3bTMSRBGJuL?=
 =?us-ascii?Q?GM40865iupHTAEGieEzUpJNt2Q12REGwJS8FEvaDj4d9nlE5o+809fD/XZaW?=
 =?us-ascii?Q?VeglkKcIgdcgoPBlXr/ovfDBjQ6Epc4M+j2lzXHZhteHzNF9KroqgYUBr/B3?=
 =?us-ascii?Q?ddzI1UVRpiCKcyHSp8UOx/NGCDtSpMQJJlVc7WjWj0YPYQB1C+rE2Mu2CXxQ?=
 =?us-ascii?Q?kcHrBwRsBl2ATQtR2v4FPg1xlbxjmybNgngtOA2Aji1nJmZ7tNhzFqSJdyRo?=
 =?us-ascii?Q?NlwPRcmayERorTDDPJhMRy9Fy1RCObxwu80SUrQRGbUMrZ11WPEaEjbN1dsg?=
 =?us-ascii?Q?R+46rSYIchVz/CNBCehkjzO4aCS+R1fnlfeeBxQZ+bYQwNq+QG8QMrnJMPxe?=
 =?us-ascii?Q?G2uMtZbEtWKPsn5u0Y8vVy6+YWAOJ/izEUCLJfXe+5o9h8/mgdm3XAII9INv?=
 =?us-ascii?Q?/SsYY+wkJuBgCxbQBOSk/KLV3WALyImge6Q1csdyY6lAYe00PBcFhH98sqKg?=
 =?us-ascii?Q?P27ncsfS1z5Dl7I+8c+eZvYudnNfi3lFtQe4PonNeyXXj+eGYMUfrlxvEDDn?=
 =?us-ascii?Q?ZwP94KSZPNsw20nEdoP2SuZ0BBubZpdb01+mZuD7eJ5pFEMUTeij2ZrtIky6?=
 =?us-ascii?Q?3TVEasGdVb/nI7MT7kj0oxFvfLuzmqWgIf3NiwYV+gwek56r2JMK2EfTdHjN?=
 =?us-ascii?Q?hJ3dRgFgjWqVQZHBc6bUeojPSAuI9fuDmovURbgp8YjDjk7M4AgQkono32T5?=
 =?us-ascii?Q?sr29/RSaRNsKvKyFqyyV0aXf6+3+pjffaRz4Cqbu0uwZbvZMo3G1ev3e4KdE?=
 =?us-ascii?Q?B0tmyx1u7OU3BqB719ywntay73z2rI+2JyXqBVJeOkabITwWulfyJqBcdNQW?=
 =?us-ascii?Q?MT9O9BHXT6LGLmASyApLLtSFGRZQ+H1Md9oyfFDxT7l3VioSbGFcFZOUp+Xb?=
 =?us-ascii?Q?VPN4ahvxbezta+ytR2rzHE7S5fYW173ybia90u/bGiYcF2jJQ6VhPKPHGchh?=
 =?us-ascii?Q?LR0nNdem8OMJ3Py3Edk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:42.8258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e9b60-389d-411d-eeb7-08de374dfcfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

The return address of translation functions is not consistently
checked for a valid address. Check if ULLONG_MAX was returned.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/hdm.c                 |  2 +-
 drivers/cxl/core/region.c              | 36 +++++++++++++++++++-------
 tools/testing/cxl/test/cxl_translate.c |  4 +--
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1c5d2022c87a..8b50cdce4b29 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
-	resource_size_t base = -1;
+	resource_size_t base = ULLONG_MAX;
 
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	if (cxled->dpa_res)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c7ac78f1b644..2c070c7c7bfe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3124,7 +3124,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
-	u64 dpa_offset, hpa_offset, hpa;
+	u64 base, dpa_offset, hpa_offset, hpa;
 	u16 eig = 0;
 	u8 eiw = 0;
 	int pos;
@@ -3142,8 +3142,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	ways_to_eiw(p->interleave_ways, &eiw);
 	granularity_to_eig(p->interleave_granularity, &eig);
 
-	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+	base = cxl_dpa_resource_start(cxled);
+	if (base == ULLONG_MAX)
+		return ULLONG_MAX;
+
+	dpa_offset = dpa - base;
 	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
+	if (hpa_offset == ULLONG_MAX)
+		return ULLONG_MAX;
 
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start + p->cache_size;
@@ -3152,6 +3158,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	if (cxlrd->ops.hpa_to_spa)
 		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
+	if (hpa == ULLONG_MAX)
+		return ULLONG_MAX;
+
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
 			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
@@ -3176,10 +3185,11 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
-	u64 hpa, hpa_offset, dpa_offset;
+	u64 hpa_offset = offset;
+	u64 dpa_base, dpa_offset;
 	u16 eig = 0;
 	u8 eiw = 0;
-	int pos;
+	int pos = -1;
 
 	lockdep_assert_held(&cxl_rwsem.region);
 	lockdep_assert_held(&cxl_rwsem.dpa);
@@ -3193,13 +3203,14 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	 * CXL HPA is assumed to equal SPA.
 	 */
 	if (cxlrd->ops.spa_to_hpa) {
-		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
-		hpa_offset = hpa - p->res->start;
-	} else {
-		hpa_offset = offset;
+		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
+		if (hpa_offset != ULLONG_MAX)
+			hpa_offset -= p->res->start;
 	}
 
-	pos = cxl_calculate_position(hpa_offset, eiw, eig);
+	if (hpa_offset != ULLONG_MAX)
+		pos = cxl_calculate_position(hpa_offset, eiw, eig);
+
 	if (pos < 0 || pos >= p->nr_targets) {
 		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
 			pos, p->nr_targets);
@@ -3213,8 +3224,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 		cxled = p->targets[i];
 		if (cxled->pos != pos)
 			continue;
+
+		dpa_base = cxl_dpa_resource_start(cxled);
+		if (dpa_base == ULLONG_MAX)
+			continue;
+
 		result->cxlmd = cxled_to_memdev(cxled);
-		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
+		result->dpa = dpa_base + dpa_offset;
 
 		return 0;
 	}
diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
index 2200ae21795c..66f8270aacd8 100644
--- a/tools/testing/cxl/test/cxl_translate.c
+++ b/tools/testing/cxl/test/cxl_translate.c
@@ -69,7 +69,7 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
 	/* Calculate base HPA offset from DPA and position */
 	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
 
-	if (math == XOR_MATH) {
+	if (hpa_offset != ULLONG_MAX && math == XOR_MATH) {
 		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
 		if (cximsd->nr_maps)
 			return cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
@@ -262,7 +262,7 @@ static int test_random_params(void)
 		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
 		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
 
-		if (reverse_dpa != dpa || reverse_pos != pos) {
+		if (hpa == ULLONG_MAX || reverse_dpa != dpa || reverse_pos != pos) {
 			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
 			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
 			       eig);
-- 
2.47.3

