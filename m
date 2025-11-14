Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932A35CB82;
	Fri, 14 Nov 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156434; cv=fail; b=DkUX+d4QUnuR6SJQ1SomdtTJDb5x1g85bOJTK74ahPdwHglv2yJFf3qT9WCJvx8hmfzqky8zQDXRE81NlOQEPerrH3V4wGgR9KvEi6aacmnLolBcq+qH4xruN815iH0ZmObj9JoaA3uQ+1MjhspUfMrXHizhqF/u/2S9YHZVrc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156434; c=relaxed/simple;
	bh=xOPCtWUT7P33EpmfjLoxTmamUfTttbHgy4EzwsFjQPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD4loZL91b9j5k1gk//Rn4prH67e6+OUMnB2gXMlODUjIdnbrBTH7kK3OLGb/Y7f6WMHLdLyV8NYE5wzjzGkIsglrciG+UXolI5skKvVbDr39D9LtkeMTexNkBIMHFp8qNT47aUPAfWcJ6OmsOkvbuRwuEdExCj5ooBjBiHUycc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YBgkv2D3; arc=fail smtp.client-ip=40.107.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YBgkv2D3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I49uU2Ip/0O/XYdM1DdwdQRLMPV+ixipOCfVbRd0/KdlWf+1SPHl/EVk5Eg4SpztZNbby5vV27yAitR7t8aaNGQ0N8f06G2BULUwLjh9wBRmVOg63GiixrMRB0PXOzMUABUULx4tRGG3geEOTouFTPCZsUX4HTIoIuGWnn4b6l6LVggulwULq2fA4QSSd9hjLtkb/kGbJTRYuykPU3WGVNSElRW+LFfu0Ma4ge2JUGnUNoaV2HhyZGxINN5H+2Fzq/P29fvoBSwpvfSxB/fulGnf1xerkaU3MbMc9OUPS1CbNMqo8lyKDgGlHF0zzOw5U02HZv+LJ3yiCczCkVi4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6+t0NUqYHH+N9Awb7wmAQ3Agmg0K9uESM7TBBKj0Uk=;
 b=asqnob32Z0WZxH4FWXS9OmvlICo9WYkhqoGidjOMycup4ZxJO1nKyi2fqm+/z1iwyWExhqTMQhhCHQtgbNIOcNTocDOeUKP/nn4IG9WTFeAW3LD5ckONyIwYPZhvkdSBDbdc4mTewqUhDHNdVAJ0N8gYHxY9/vd3K1we/HDlFSMwhkyaASpxdHcSqeIWm7CaRIJ2vDVlGJdnuzFYZ1w3Ssf/zy1fW7V3bMg+OFa2y58Zy0Smu/ewnn5e2dI12xm9ng6ECPFXW7krKgJ99N7q/ZE5hCzm6CVGpaeJITvCUt4fEHO1d3WEWVuZKeFDWA7HgCV1F93bxidAZQl2is8v9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6+t0NUqYHH+N9Awb7wmAQ3Agmg0K9uESM7TBBKj0Uk=;
 b=YBgkv2D3adE9QYgrYPkVVeO9rU67oNC1waPNYMddfS0A630FnNweAN+BSvyR3e/DFjko6bUG53Z0h0x6IAqMNZZzbalkZRr/UrIp/l9kcH//a+YqUSOZiRJyJu5JLrDeKJ1Gyv2MEWJjIq1m+9lLXSHxDT2ZKm1ySBKMaJFqtCc=
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 21:40:26 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::dd) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:25 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:22 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 11/11] cxl/atl: Lock decoders that need address translation
Date: Fri, 14 Nov 2025 22:39:24 +0100
Message-ID: <20251114213931.30754-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dceef04-95e5-4aad-3df0-08de23c66c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sUIL593AjT8AusIt0bfXPIgfAftq8NJs+NYVhiUtPoQ01e8Acc26mYtUUG2l?=
 =?us-ascii?Q?fLiAyNeRdEQihFIUgexfSMldxcLXpijxtC+YwMSq0C3zix196gsUxWlRezMv?=
 =?us-ascii?Q?g2WPHCXVMRjWgkGWkUEHAHfrWau7QAGNaV0a7G7itWMJt3vIxVvknu5MCXDI?=
 =?us-ascii?Q?l1ZtYWWNrU+u/HhWvF0UDPy1sjXVX3gdH3BgFcjJWyO7Lm0njJNg4oJhj1B7?=
 =?us-ascii?Q?Cdj/au0SLyeGQG2c+XJjBjosqbZlam5Y/e1hQ4G+jGhTVG6T5VSF2OyGw3dJ?=
 =?us-ascii?Q?AsU/eG17MjmiFsEF04mp2usgdzSdN36RuKDHzniRPcjqDhMTgllBMCg85od1?=
 =?us-ascii?Q?UF9k6VzIYZSAc+L93ge5vrj/apm2sP76hDRjBrUjFP9nWt/7OYpgUbag+RG1?=
 =?us-ascii?Q?oqxOaRs85VUPvLFRhVfiTU9hAaZPVRzahnB1DoP2PHHUezqMsSKRCiplNcFe?=
 =?us-ascii?Q?jrd5BXHkAogaEfHo3m6S371maf5sp1we2okNQ3zR3tOFwfcDxV3qvR0P+xrR?=
 =?us-ascii?Q?l/+GI+V38BITuDxRbiCrcmOzzINOlOhNIEz+I4pITXufwoKkW4rkyloTgvlC?=
 =?us-ascii?Q?D8bojSIwznnffr512MrEuyJsr3cfJSRfRQEUKzqP8q+kJyxO7srQmI8IJCO1?=
 =?us-ascii?Q?Wv8INz+qCBs5F6fzm1FbxXj2jMg2BwZx+EPdKopeUxNXcjwAjJmPqipReK0R?=
 =?us-ascii?Q?GEtBbtYgYRY+jAJHO3GSGSxnhBzS2B7u2qM9PVmr3FcAVmWDWhlHn4hdvg+H?=
 =?us-ascii?Q?XC+hBriwuH0LT1lnszKSHvS4RdyzMeuL8/Xq4cBhdkRCIgdUmvDRF1yra9cM?=
 =?us-ascii?Q?yn8HWFkkw2Pj2vw+YDvOWafIiv9jT65MrZVcf+pcGzEb2GJ3Sw8tusApYrkV?=
 =?us-ascii?Q?e/kfV4j49iCgqD+10LyJ7Y0DviZThlzhNIV5k5L0O/HiGmLavi+dSXxkNPhk?=
 =?us-ascii?Q?OITm1lyt6XIS5JyW7Z3pWbgOGnALi8wIZncJRI8Oz8lHc0oy+QxrdPO/Z0yG?=
 =?us-ascii?Q?+u+MNy2MLdtkpcAXrZiW6B/8Q9BNYy5TQSSu8O3HNwyxZ/8GElt1SNXvZVIo?=
 =?us-ascii?Q?/k5wwap24q6dWIfo4SXekRVK/DyUmmHVYLvSL/T5HV12jfv6hFwhAkYAC+aM?=
 =?us-ascii?Q?CPYJY9hoYrlOAZun1rTeC31txRspL1t3oP7ywLGU3rLwx+l628/0vSJBe5rL?=
 =?us-ascii?Q?kwrpaXnbReh/Rkw8wwla7DX3HdVDHUaAPyJGBZGNSw+i6Ie99sSCG6P5nfk8?=
 =?us-ascii?Q?o3+r3Rijxmh0XYUlb8im7l89bZ5jdCaAkMpfhtZ6Mj92R0VlLJEPBYQL2ISv?=
 =?us-ascii?Q?hwP1M3yq+T/r5jMM/88o9kC13PCwaiTrseHlbW0fRKe8+BymXEC26MqC7t83?=
 =?us-ascii?Q?YlBKMZnNJPv3oeMlOE8Wfswia7UzjiXXxWehxp2H/hlT636DmYeZmckxHdjY?=
 =?us-ascii?Q?0LcWszCBa9bFJFh3JEVOKzmPEzGeBsqocVyJ18jX/IwBrqNHxQe4Gkp5kYTv?=
 =?us-ascii?Q?K/UHq7ACbOikAX4xsXohmI7MaU9W+Q0xG5BFJCg42pOKFLMuFqwrKtmE3u1v?=
 =?us-ascii?Q?cMFoDgYgjbV2n5U/I+w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:25.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dceef04-95e5-4aad-3df0-08de23c66c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099

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
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 3b02999d3c59..0590890bd093 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -161,6 +161,24 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
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

