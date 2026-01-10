Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A213101DD;
	Sat, 10 Jan 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045699; cv=fail; b=C4w+x0OVhLb1+jeCB9gZPClqNfs/KOPelaZkJ5HDxn26oX/H549XQVgzDJm2omlwCGkx47+HWMXR75KhCUBBKjXoix9D9SkIPZPm8hVc8ew2AQ1hfi3OJH+Q7rcZRw5yr1TSXj9LgKiCj/+RRLy2NCurKbiw95K9WGsE3x0EtVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045699; c=relaxed/simple;
	bh=PpMzmYNriu+kPjIAZP8pB6tO9TzQKadRlUqAqHVTe8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gk4fgR/cgHD0P4FY0fR1lrcKfqxOGk2XLWglD+4HVv2NkCi0Z9mh/9gJOihZM+m4Dc87G33wQQ4jJu0WENYM0+SvZRYW8aZTI6TSV4kHQeCpsrpRCkmpjua45Edlr843zkWvYwht4B+5FUGtZ5DXs7oEwGL/4JW61IKlqFK/ppg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MhcKndzx; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MhcKndzx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvuATIdEOVcw4YarxGxr/ZUAhxNOoDB28ypHGscmtryY3Vod7AubbZ7/wVVASfvM4Qhy2JeFb8HTi7jNKWVXhXHzkeiWxuv7fBkaVu+AFFzJ2+B6AFodwd44iYRpW8wle/qbA1Qy/Qbw/VhxM/OImG7yrgW3R8GMreKZwKVLktc429nWOefkq9Nd7klmRFKZiVGKtY/bwwc4Konbe7XxFGb8ak+m9Ztw868c7OqsIFX3ysQF0CwLvs7ml1K7IuWDbPb33h/POUFAx8PquYmAHMjmBwCs8XOu0+XxjIv1cYImaSxcbqrHyS17VKvFrBhDprC3CDYj0emS7VPH2WZLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w36FrPzjTCg0lOfwMgs32wGutB/hVoOD3mMkBHCWHOw=;
 b=xefF+Umxm0uwLDz2CjRTdlUHCM6QssD9QrkDrClhZW7B/twmIpvXpO18uTgPsqePXJ235eCY9z/C+NjgeG2TWcNG7ShZDZmNJbDo0456V9NZhcedGLaTAI9SGCKqZuLjdUFnzCDoVsIn3Usak1lB9SRQUxQ5sjpfLCrWsMB/L+1RAsgxM5tutFMvvdse1h+obhvbd47irbsXGn2XMWneR96BtpeMqSalc/1o4dCCsU00fQ+yNkwTv2YZfqCHrkQlxQjHOJAWu793Bqe5QdOVyF6Cj0F7G5vxQGd+7lSTSkS7kxe+D1xYYaBB9q/kb1KH6Sx8cKniN2hBmySUMcvJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w36FrPzjTCg0lOfwMgs32wGutB/hVoOD3mMkBHCWHOw=;
 b=MhcKndzx7bAYQ0hhUzbSOUsnFwIR4b8OH7pys9Iho2c7JkVJbmJGjuLSEehnnSndlG+nweUN3iSDZRvesOw5CWHtoPwkJQhxIeRp5gD2q8rVqbk0shz9bELVEsYAhK0PZON6JjsOPH8Fsuew+bT4bw/jRoxmhravDEMC0hZYJro=
Received: from BL1PR13CA0253.namprd13.prod.outlook.com (2603:10b6:208:2ba::18)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Sat, 10 Jan
 2026 11:48:14 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::89) by BL1PR13CA0253.outlook.office365.com
 (2603:10b6:208:2ba::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.2 via Frontend Transport; Sat,
 10 Jan 2026 11:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Sat, 10 Jan 2026 11:48:13 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:48:09 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 11/13] cxl/atl: Lock decoders that need address translation
Date: Sat, 10 Jan 2026 12:46:56 +0100
Message-ID: <20260110114705.681676-12-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: edb30035-08cf-4d88-758d-08de503e2302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3/+rq5/cg6hQBL+PcT8msXxgxdEGAeDQEIVo5rFcWRWH9tUoOgH7upphVhl?=
 =?us-ascii?Q?6OevCCzWQ8sj3xsH8DrCfNzujM+xe6rSgSzMfxqO6oRAEOneS1Zrhs3BEAW2?=
 =?us-ascii?Q?ZpR9H2OkM9ztNp858EovpZAyJaygkA6YQF9X6Sn/s3rZu69MweX2Vk01Co+7?=
 =?us-ascii?Q?vNwe2zgmB24yrj+K6dqa9t6pgpPWSWqv5JpaOM3COgYXQv4YFu39yqMehLHk?=
 =?us-ascii?Q?WDB+F2b4sTqQXlqnG/wGYo7NYHzM0+3u+sCXVyIJzcGrC7fXTNQvl9Ly1h/q?=
 =?us-ascii?Q?1ViK7+eeayAW/3NrHaQTm6NHZ/k3EA5owPCp6bdxgnvwytw5rz9KQ/qGqRVT?=
 =?us-ascii?Q?A/I+QuxneDPh90yLKTDEiCbD8j6aFM89H/zz8qomU7KtVtU3DXPmHdMyxmEn?=
 =?us-ascii?Q?D5PQ0bJEWZ3ghN3wZEYSUhHrqhmhKUtnCbwmVcuWzoDHy6A5l9itaDyl5wES?=
 =?us-ascii?Q?sXvyX6Cl1mPislfJJ32MJ9LYlEF8Rhco4C270NV0g1JxF+Zp2WsHC3M2Gf9q?=
 =?us-ascii?Q?uMZh57jLiAX0yGslcIySphqAdH7HmwilOych35C1fw7JrdHJ8wyPX4bcmYoV?=
 =?us-ascii?Q?k14pesNmQCPDii6L5ga1stf3tq+IyNukx1I77o9bOboT3NH2sezAGegSg6C4?=
 =?us-ascii?Q?jbYSgEvBIAu8bWLmlL7zJbzqWMVP7kGJEs4KhrdSw3IGUP4NCBI3rOVsk67u?=
 =?us-ascii?Q?QfhaZ4i7Bd0W8JwJzKEur4brWcRM6w7UjGX+yNF4SnEdx77YKLe8xYEm4YUz?=
 =?us-ascii?Q?nucsMw1qf6VjGhR/AsrIjZ/RLwjOAeWkAgxmhrh2s9nJ/HnbOxjGzn97HWwv?=
 =?us-ascii?Q?uRWCQk4XO+YvWORMMSaXHpTF2rdBGS86B9PpyWwIq52+jp/6bHz9q11TvPhE?=
 =?us-ascii?Q?jNGBbjv2imxFHWJ1LL9JIxEjLgHCPrLMKYDjPKiyM09cNn18brdRQcw9Ie92?=
 =?us-ascii?Q?3sZro+s1lA4RoezM1pXhDSlRZyCUwUJG2WSClA2LYfx3HA7CxKWJHAiin0Xa?=
 =?us-ascii?Q?Vb2GSyCnuH64lV8cyjBHZlXkivZ66NmIySCjcp4U/4HN3spbmqEwDi58+4VU?=
 =?us-ascii?Q?af/l1uY6dpj5r1Ju2I01S2KWov0eoGMCyZWApu+NU+4GdV0XHnarMgyS0Hnw?=
 =?us-ascii?Q?91vUlZH8MWKYc1VJU3ewbfodgvvMwW8Rw9sb0ZoOizaAMA3rb7u0DgOJ16gn?=
 =?us-ascii?Q?SsMO3FwUocpGdlwTr2eBPPksm9ySEjBXhW+6k8h1BYm6XGt3o6FUrOQ+HGTP?=
 =?us-ascii?Q?VCeS8HZloLOaEsXOkxA7U0F/NhYYNGUsnTr5udhjSTiqy3PtZ/wIeR+T9A3p?=
 =?us-ascii?Q?0u1QNM9SgbUJcDJuM0INTgExWT/P7dn2j7HIcZjBLOhWp0KQp76hk5Tzk66S?=
 =?us-ascii?Q?zjvYrS8jL66fUmFZhyDw/UWj9t5xPCCMMUszCTiUFtMq3dZSKNXOBaCGJfZ5?=
 =?us-ascii?Q?5vDZZ0VqDyxjkwXF5n6O+MWRq4kOl7KNnuCZ9ltveYNesWSdNuGX0UMS1/CY?=
 =?us-ascii?Q?C9tU2VTNtnjm8GIQIvlgGPUJU4jYNLI3MNNg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:48:13.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb30035-08cf-4d88-758d-08de503e2302
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

The current kernel implementation does not support endpoint setup with
Normalized Addressing. It only translates an endpoint's DPA to the SPA
range of the host bridge. Therefore, the endpoint address range cannot
be determined, making a non-auto setup impossible. If a decoder
requires address translation, reprogramming should be disabled and the
decoder locked.

The BIOS, however, provides all the necessary address translation
data, which the kernel can use to reconfigure endpoint decoders with
normalized addresses. Locking the decoders in the BIOS would prevent a
capable kernel (or other operating systems) from shutting down
auto-generated regions and managing resources dynamically.

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index c36984686fb0..09d0ea1792d9 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -154,6 +154,24 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 		return -ENXIO;
 	}
 
+	/*
+	 * The current kernel implementation does not support endpoint
+	 * setup with Normalized Addressing. It only translates an
+	 * endpoint's DPA to the SPA range of the host bridge.
+	 * Therefore, the endpoint address range cannot be determined,
+	 * making a non-auto setup impossible. If a decoder requires
+	 * address translation, reprogramming should be disabled and
+	 * the decoder locked.
+	 *
+	 * The BIOS, however, provides all the necessary address
+	 * translation data, which the kernel can use to reconfigure
+	 * endpoint decoders with normalized addresses. Locking the
+	 * decoders in the BIOS would prevent a capable kernel (or
+	 * other operating systems) from shutting down auto-generated
+	 * regions and managing resources dynamically.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
-- 
2.47.3

