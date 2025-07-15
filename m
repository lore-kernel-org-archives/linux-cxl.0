Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E52C3745;
	Tue, 15 Jul 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606767; cv=fail; b=AHT2voD6mAaohZAGk9purxnXj+HkGGrWXMoWNKw6icXrtlXO2EiWqh+ozeHMg/m4Wc6JbSC+Md0jMnMke5QyN9u/3JiQ9ISmHuDw625+O9TfKuqxj1LTrTGugWpcm5c+6NnY39HvDPc0cMujQ/EbT6vYeuyV7BKUbKwm4TYanqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606767; c=relaxed/simple;
	bh=gjw6zz3ovQZ8Q0LQwNWWu1wB6p70udPJC/6Q7BR/ftw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3NWeLJnqCYdLihgpjpRKslYxAr4eMjaqUMbW+ev7fVah8y37Z6CGfxGHe59+1IDmaQ3NXVpXCMgXwbJI2PU4wvZrDCYv6vgvlXm09M6HVsvAX4875P/+8ST7Fg8uluZhmlucn1nc7gUJfqrIoBs17qiL3u/Ob2L332d3b8Du6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2DvNt1kj; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2DvNt1kj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhDZa1tRn71+mH7hmoSkrzfcRE0yRcLOonh8YkzrKfPM2238DaTJSdCYaBw3qVNq2Vdne/bpGpIpqNGr7PktQ8v+dZhZ2B1VwV34tho7ivrMPH1lgnDs2u54GnbUS2VZjeIilVJzeVRPN/GzJna/0jxO0+KqGiOINHdRzQbSrlClZaKEcAECdk9C8dkoztQkfViLILvWwdvXRp4NCM7Eeu+JADStNWuL85hvaKgXPI48P005Fh3yCUWOJR6/2QkjjD3JORHUeyNVIM2osSakMQaTDBvfW0Yx+QEucHPQy002rZ4bH7tdaQTkAlwdFryKMn/+AB3xMGAg1uakgr/3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXosJKZrP/dFUC4LnXSOu3kVkoziDtuXk5Ds72nt4f0=;
 b=sYn6eCt5F4u/L46cPFRtVwcB0Ga/0LIA04GmbWD2cpCMvX0VPbb3pTbGrIkg92H7CG6gTLtjvPhgPz34JiaeYWADQwO20T4K2aq7MH8t8PAF1u+xjuaEPOfxLP7zJKL8DhiBb3f2rgQeBt8YPiQ6urNF/EUhb5SFHPDMi9VSoTEQ5ClveFfzkEnmcU/M1fb4mf9UVkAMtUana8AoX7PcUGS7oUATugJPKBV25XVlWjt5uwy+SaymurejRvBfaBNNT9DlAjOll7BFBmT7l6E6t7SDCB0S8LDw0VY0K2jvK3U4UdIn2JqV/8UptHidY/AbJI/J/tSpyvbroquZ3synfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXosJKZrP/dFUC4LnXSOu3kVkoziDtuXk5Ds72nt4f0=;
 b=2DvNt1kjHTRNDsZjfjzyfYmw3sy1ck8GF2+0fj2LfeCj0PdzbcUv0Nyy13VLkgfR26hr0b2wKbObGEco2Dmthb6Ods2cm+ByKTnRwxVMivqp1NqQek33TrjPXKX+wkm5sgBm8YIBqxApz0xGTkkjrwzVi6+MMGqHP5KJYs4q2So=
Received: from BN0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:e6::20)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 19:12:42 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com (2603:10b6:408:e6::4)
 by BN0PR03CA0015.outlook.office365.com (2603:10b6:408:e6::20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32
 via Frontend Transport; Tue, 15 Jul 2025 19:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:39 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 08/20] cxl/region: Rework memregion id allocation and move it to register_region()
Date: Tue, 15 Jul 2025 21:11:31 +0200
Message-ID: <20250715191143.1023512-9-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7c84f5-e80d-4dd9-1bb6-08ddc3d392aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0AeTtRAD/3ldxCkwEXOz+ageMstrKSrIGjlo4B+fJFNFB6G9JH6eROh/DZY?=
 =?us-ascii?Q?BkyS7i5MLLVXAAiQF0bAALFQasB2hAkO7JX3IvdgoryTZfpDBSrLwnqR6ZAG?=
 =?us-ascii?Q?Hy+FQXQEyeK7NIcBkA1n6wNCzD+C3uW5MqST7An1x/LCLC29aM+rRYFPccTe?=
 =?us-ascii?Q?Npbc3YYwl1Bz8c79Kg/em2wxiP+onVhiA5zgC/nv1LBiJhsHCqxZdjQzdd0m?=
 =?us-ascii?Q?w6FuhGsLHSKBYD2TsCP5ZTDCH31VgTkHr84OhwjXNCncck1NU7iYbN55R1si?=
 =?us-ascii?Q?7sux1Vh8j0VkLbJTRKiZaH2bNS1VlCErzmCDM2qRSMwhstfBg62KSxICsy7M?=
 =?us-ascii?Q?Cx73RLTdtOh2E3bSdXdnnrFf/X/WN2ADRv6lfgXyn5JW/eY0yc37AdV5fL0c?=
 =?us-ascii?Q?0RqurOoig/75W11m5SNUV91tuj/zWTOKoodWvRlhiBkW8ClWeozN+7tomca+?=
 =?us-ascii?Q?+6Xqxmc9ShtG5gU15Oa4zHfiFOt8rB03N/ae4rZTuTRrKN/4ZewckoFZCaxv?=
 =?us-ascii?Q?R1QppXYIStkpvdkF8Dz1y0Re8LQmgfnbUCm8lOaA0vwsn1bM0STJPLRW4+UC?=
 =?us-ascii?Q?SvcXaEWx5Ei7uJ4lN3UoiC+y0RcKOA1cXIz++TlRFTp9BiWNDTOVHhRCI5CK?=
 =?us-ascii?Q?ggvXcRRk6mXvyiRERYVkZM+KvrMfAes9iTwF3HOJCmqNZAYrbwb6RrX29jcW?=
 =?us-ascii?Q?u0UcQ2cBxPgQt11rVrw8NPJCz74w61xF1cvtKIxLO7ooNGdEntr5Uq7eWFy1?=
 =?us-ascii?Q?oMQDurzYMedknoCfX0aPHMNFpbH2bYQnYxXAvzfuX9oaMjscgdQgVu1kbL7E?=
 =?us-ascii?Q?67RQnuzIm+kC03ggWgepTenE+mL409bd47yf9HlD4bpB9nIIlHLFsRejobuM?=
 =?us-ascii?Q?K5R7dq1T8BbfG6VsE5AyZeL2FcMVs+4wkg/45YcuEIdhuroZApOK9VgaIbTY?=
 =?us-ascii?Q?e1gXLGedPGX2f8mV/fQm/rZFP8PKKaE8TstNYnaH2tR7JGOQtiJIq/nU2tWl?=
 =?us-ascii?Q?aSnVCyz8LS8FtFYKqg6c9UrjZqp+03uWKtnnQNvuFKUSWB4MSS1YEvryf1vj?=
 =?us-ascii?Q?zcF+lgCgVq1BAP2hadYpQOL4qXRCFa8ZUgZKRhpdw7YQEIv2WI75jlR6OMi2?=
 =?us-ascii?Q?qjcjE3TwE8ziSyX6iA+KVTuL7IAimDf8pDbD74kb4l7+I53oo7Gz6NLNUgKT?=
 =?us-ascii?Q?Qd53BWh9kKxdb9AqoiHptQaBA4tUZ8ANhlEOAPr2Rhhr5gsffiRLbCbUQRjL?=
 =?us-ascii?Q?sTCMlD+WlMVjW00hFRJeOMBY2Zk48eV/a2WSSkaWTexL3dnVxpTF+I1hZD4F?=
 =?us-ascii?Q?zvUex+Vwjsw4ZTqgurcsqZ6P0sPyCkeJNFOovLr4b2vn4jlTevht9DdPbzw6?=
 =?us-ascii?Q?rONdCy2KOXgZPDnOFV+QX/wIgt4QQvpXi+q6wuddA540Xng83ab62L6fES1Y?=
 =?us-ascii?Q?MWaZ8O7Zu5b9GKs6Wbqq5Oi3gUyKvc5wbxdluqXHqPSicXjpyCoR11A+Wanf?=
 =?us-ascii?Q?qpJ00ajYKohuV8WiXk4GUuLnoxmxpRht8gT9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:42.2135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7c84f5-e80d-4dd9-1bb6-08ddc3d392aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560

Make the atomic_cmpxchg() loop an inner loop of register_region().
Simplify calling of __create_region() by modifying the @port_id
function argument to accept a value of -1 to indicates that an
available memregion id should be assigned to the region.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 57ee758bdece..34ffd726859e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2504,18 +2504,34 @@ static int register_region(struct cxl_region *cxlr, int id)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct device *dev = &cxlr->dev;
-	int rc;
+	int old, match, rc;
 
 	rc = memregion_alloc(GFP_KERNEL);
 	if (rc < 0)
 		return rc;
 
-	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
+	if (id < 0)
+		match = atomic_read(&cxlrd->region_id);
+	else
+		match = id;
+
+	for (; match >= 0;) {
+		old = atomic_cmpxchg(&cxlrd->region_id, match, rc);
+		if (old == match)
+			break;
+		if (id >= 0)
+			break;
+		match = old;
+	}
+
+	if (match < 0 || match != old) {
 		memregion_free(rc);
+		if (match < 0)
+			return -ENXIO;
 		return -EBUSY;
 	}
 
-	cxlr->id = id;
+	cxlr->id = old;
 
 	rc = dev_set_name(dev, "region%d", cxlr->id);
 	if (rc)
@@ -2528,7 +2544,8 @@ static int register_region(struct cxl_region *cxlr, int id)
  * devm_cxl_add_region - Adds a region to the CXL hierarchy.
  * @cxlr: region to be added
  * @id: memregion id to create must match current @port_id of the
- *      region's @cxlrd
+ *      region's @cxlrd. A negative value indicates that an available
+ *      memregion id should be assigned to the region.
  *
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.
@@ -3412,11 +3429,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
-	do {
-		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
-	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
-
+	cxlr = __create_region(cxlrd, cxlds->part[part].mode, -1);
 	if (IS_ERR(cxlr)) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
-- 
2.39.5

