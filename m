Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA142264CD;
	Fri, 12 Sep 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688377; cv=fail; b=RWFt+DGF8jRPs8xOlHEDrrzK6Nht0ia5CnmyABd9tG+4A2Fh/Jops/jLGBe+168do9Ym0N0CthM38liSH60u95lpKvqqQr0285DeWHrpRGFEZV1MWswug5/g0InLo4aKgKeh/AJ1ENDqd2k2T6eX58Jux2JAPXIvjkwXx7jk2N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688377; c=relaxed/simple;
	bh=60/n/fmPdghGx0lfqFxsfGhiI0QResi6ln1I/2TwR6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6p07W4I7c5FiIDcVlTYt0um+Ht2vKz7FONzimafzSHU4e6UCk1UDwIA+sVj9HvafWpWMk2sSHSudCpzHBszr8Zsv+JTTE+U5t2XI+tySSfOodYHSVU1BIak220mfHxvsig5jVjea14bethWc8t0ZDuMXXZC1sdKJozy8u1ROP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C+zPxygb; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C+zPxygb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+PwEn+6IKwmEA3OFE4NsWrisRwScG9hd0n2m8LYEHwxgiIM2Ya6EXNpx+JxK6KfOhsxZ7qPS+pRgNmnD4H70t1AiGF9hysD4V3yxG7P9RMnfOAi0BsPCLxGCgCaDX7uPiiu859Oaq9AyTqSQbIjfdEi+BYcX2zURl4hrbAyxaM29TgvXZgUpMw/Pi6S0AM1MWrlZz23SVzdVuE+9L9axy/0YkMci8jJC/cKBE70iWLvgGCsXOgtRP/GTd4147LDJ+VM6hqtYCY1fuXg6pySXXwwISWqfGSx15qkks3k5JbACioAkTvbBzASPnirF7t5OvlFRgCWRPNSEzklMScLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW8Wgc+e7rJxF96/0NQStRnpbMrdOleRvTPH+7XEHJs=;
 b=XhiwOXxBEPllaO/PJFPsQ7wOePWrzr7aWjWpob3yO5jCHRg2p1FF3LVMFdD//VN13a5SlePj4gPq1QMJspVsJWVS8Q/0gG2KtH2Uav9D7semZDtP+W9Ga4xVilts04whz4YvX2s6gSjEaac7hYPpogZbmGppb34SMd5pyjt7aIORYJY4TEzHGEBRIqjubWFo7jBxQSaQp8YtURBMRoydgjZ8KIhZXzencJZDTWjtb7EVLI7ZYsd3rXwJsZPtzYyElNs3m2ySzpXxTF4kvSVSfUE1VeDYm81KQvrVgL5Opcwx7FZ2Bt85RUQJh1Wz5xK5wQipc3Q5cGn33YpGcDzS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW8Wgc+e7rJxF96/0NQStRnpbMrdOleRvTPH+7XEHJs=;
 b=C+zPxygb89nLWnZOSeYht1aJRMiA+QFZeMLOSSAvkkOzNtmPzwdsEEMkuUDN3j/O/i5A+E1Hw9Y/L99dqywvPlXTkCjZnKZKgbweZ4zVaCnLWYpa6iCjPp/Rauh+xh3+3AKgMT575b2ceYIOwoqlkZiMJVcX0Smn+9Fw2OHlkaA=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:46:09 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::f0) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 14:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:46:09 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:46:01 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address translation
Date: Fri, 12 Sep 2025 16:45:10 +0200
Message-ID: <20250912144514.526441-9-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4d2159-92ed-4850-9129-08ddf20b1c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rdQjv5Sd0uWNJv5bc4eOU37qw1DlovfQdkmD4rdQPGSXBhpGnw5cycNp5yCl?=
 =?us-ascii?Q?Md0svLr61jxfq6/blXa3pPdAE0+PWr8gGhJq/dASWC7NK8PUuQ217NPAzJhj?=
 =?us-ascii?Q?Ja6+om2WB6rw3R5CPRqni6zJW7QyuOL/yPWSXsnRN+UrcB9mcTD1OkvQ30CC?=
 =?us-ascii?Q?Vxd2/lIQBgqd6aOybVZ66PNyTQN1yVB1Ns0e7LFl2U8m+NLJz58+cSh2vJUV?=
 =?us-ascii?Q?/9tZs6VkHfmMz+XERDDuBvnqHNulNCHIM8SVSa0L66gvKHbw8QLfXYLYorP+?=
 =?us-ascii?Q?Lp4FfQO9Q8fOoMwecPfJ3Alrr97XOg/RkqHcs5ucqMqbB/fApQSLP5DwMWtT?=
 =?us-ascii?Q?IVTC1d32oVNqQTRKsF4VXfDEEcPgsI/sOwIKbxGgs+stzjk9gP589Mc7Jr0w?=
 =?us-ascii?Q?CiXgY8FHmh8pJrRs4b3umwiy+4JMHL64RtIOLOf23CmNZgZAuJJx8KtiXNb4?=
 =?us-ascii?Q?HaMo+Ulv64t/cc5xYCjGXHEgCh89Epf5qdsW9QIhm1zKy8dfOWTv5q0GUCZg?=
 =?us-ascii?Q?g+KjXzfSTJuZKwz1L26a8ZRcZ8kuAXcEJDrVlhOMTtYIj9n6ghGqtO5QjpUs?=
 =?us-ascii?Q?qSnWW0TRw8Pq6Etr3Es7OpQtueRLQwWOHfcRw2nDYT2QsCUqItEo7B2XLn0t?=
 =?us-ascii?Q?+V3NZQq10PwQZjPl2dMbJtWOs12a5sSahbgvyCH9eI0YFQ9O0LXCVpKVeuBm?=
 =?us-ascii?Q?bmqCz+8f3TWs0qHrcIde5ZEN4cxyw22SqFiBmjtysEW/KDGrUufP6bacCjxN?=
 =?us-ascii?Q?gDwlftdR0dHBED/F0lLTA91sRiIp3PQhAy9XFZil31d9af7AC5FNSFHW3VmC?=
 =?us-ascii?Q?2YP0KCGEdlfDuEWtQKl2kqi2mZ/qpHIYK5wti2ux9SVujsZV+P6gjHaOm/hu?=
 =?us-ascii?Q?XDpZqi46352pt09zcMazAvwYU+YVE3fh4laYJ33T/JUJSTGQ+Mr5mZV6sNGQ?=
 =?us-ascii?Q?LXuEpxbBP/vMKr5Af/9ZQDgGB31H3I/TU8hOWFZAt37KNhlTFrLTI8h3MH0f?=
 =?us-ascii?Q?hW8w+HQnx8P7ar+s3OKuQ8DktYcMsFy15K3MDLh1Fr419F/24wyywngiYLN7?=
 =?us-ascii?Q?6qzL8z5le4/dOQn0RgtRd3hb3748tpG7dpZOwE0lWcpoPijylPLf6zXTxcbx?=
 =?us-ascii?Q?tH6hzk94VQi0R6Hib4soJkluLSWtMgpDft9zepaGvsiSXBgzGeqqK+Rw+PIR?=
 =?us-ascii?Q?TmGyuy9W1y1TL6gS5Nkn1M8Uy4/RMUyxk3Ni2EpgcylyC4KsXQiiy+U2w3e7?=
 =?us-ascii?Q?lfy37N2lXhKEdQ/U8bY8v+6Ci0vSfnq5fvMTu1VwJ/3BtkqhW1dkGR7y9kf1?=
 =?us-ascii?Q?udiJjhmDT/i0lRKsSuSFbMRR+mHZf0KyMh9anriFaXS19vIsoRLVs2zgEBeJ?=
 =?us-ascii?Q?TxK7luYgyBCB2r7OhQiVOXf2vVWwNl1ihHy3d5L3Iy8IwevJqno4YZyS/Faf?=
 =?us-ascii?Q?0HWzTntoKxN+WX8XyyeNjhShXj6/e04OC7VRF0r7ygh4qL9O9v2+TBkoEQOW?=
 =?us-ascii?Q?4Mo1yedEODNdV8t7E+oc1KDAHcbK5NAymFGs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:46:09.0375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d2159-92ed-4850-9129-08ddf20b1c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

Systems that need address translation have the endpoint decoders
programmed for a different address space. Host physical addresses
(HPA) are different from their system physical addresses (SPA). The
decoder's address range and interleaving configuration of such
endpoints cannot be used to determine the region parameters. The
region's address range must be SPA which the decoder does not
provide. In addition, an endpoint's incoming HPA is already converted
to the devices physical address (DPA). Thus it has interleaving
disabled.

Address translation may provide different ways to determine an
endpoint's SPA, e.g. it may support a firmware call. This allows the
determination of the region's parameters without inspecting the
endpoint decoders.

Implement the setup of address translation given there is a function
to convert an endpoint's HPA (which is identical to its DPA) to an
SPA. Use the previously introduced cxl_to_hpa_fn callback for this.
Convert the decoder's address range and ensure it is 256MB aligned.

Identify the region's interleaving ways by inspecting the address
ranges. Also determine the interleaving granularity using the address
translation callback. Note that the position of the chunk from one
interleaving block to the next may vary and thus cannot be considered
constant. Address offsets larger than the interleaving block size
cannot be used to calculate the granularity. Thus, probe the
granularity using address translation for various HPAs in the same
interleaving block.

Note that this patch does not yet enable address translation as
callbacks have not been initialized.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 95 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 57697504410b..9fb1e9508213 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3422,16 +3422,109 @@ struct cxl_region_context {
 	int interleave_granularity;
 };
 
+static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
+				     struct cxl_region_context *ctx)
+{
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent->parent);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range range = ctx->hpa_range;
+	u64 spa_len, len = range_len(&range);
+	u64 addr, base = range.start;
+	int ways, gran;
+
+	if (!len || !port->to_hpa)
+		return 0;
+
+	if (!IS_ALIGNED(range.start, SZ_256M) ||
+	    !IS_ALIGNED(range.end + 1, SZ_256M)) {
+		dev_warn(&port->dev,
+			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
+			range.start, range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/* Translate HPA range to SPA. */
+	range.start = port->to_hpa(cxld, range.start);
+	range.end = port->to_hpa(cxld, range.end);
+
+	if (range.start == ULLONG_MAX || range.end == ULLONG_MAX) {
+		dev_warn(&port->dev,
+			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			range.start, range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Since translated addresses include the interleaving
+	 * offsets, align the range to 256 MB.
+	 */
+	range.start = ALIGN_DOWN(range.start, SZ_256M);
+	range.end = ALIGN(range.end, SZ_256M) - 1;
+
+	spa_len = range_len(&range);
+	if (!len || !spa_len || spa_len % len) {
+		dev_warn(&port->dev,
+			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			range.start, range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	ways = spa_len / len;
+	gran = SZ_256;
+
+	/*
+	 * Determine interleave granularity
+	 *
+	 * Note: The position of the chunk from one interleaving block
+	 * to the next may vary and thus cannot be considered
+	 * constant. Address offsets larger than the interleaving
+	 * block size cannot be used to calculate the granularity.
+	 */
+	while (ways > 1 && gran <= SZ_16M) {
+		addr = port->to_hpa(cxld, base + gran);
+		if (addr != base + gran)
+			break;
+		gran <<= 1;
+	}
+
+	if (gran > SZ_16M) {
+		dev_warn(&port->dev,
+			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			range.start, range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	ctx->hpa_range = range;
+	ctx->interleave_ways = ways;
+	ctx->interleave_granularity = gran;
+
+	dev_dbg(&cxld->dev,
+		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
+		dev_name(ctx->cxlmd->dev.parent), base, len, range.start,
+		spa_len, ways, gran);
+
+	return 0;
+}
+
 static int setup_region_params(struct cxl_endpoint_decoder *cxled,
 			       struct cxl_region_context *ctx)
 {
+	int rc;
+
 	ctx->cxled = cxled;
 	ctx->cxlmd = cxled_to_memdev(cxled);
 	ctx->hpa_range = cxled->cxld.hpa_range;
 	ctx->interleave_ways = cxled->cxld.interleave_ways;
 	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
 
-	return 0;
+	rc = setup_address_translation(cxled, ctx);
+	if (rc)
+		return rc;
+
+	return rc;
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
-- 
2.39.5

