Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826E3A4F2B;
	Wed, 14 Jan 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409385; cv=fail; b=QvT/plJIa1PQoPskUqFSxJD5u+BtmUaTcnVMfcReGuVI98TI8T6uuwSuZb+Y+A9fTKPQ7cLHlI02aYngk7FVGlWXDcN7Mgbi56JNv+PgTYlm7HVHGmKWyF6JWK7kQ7q9I1HSVGmnLaD1vXgJgUinrbcupOvP0/3Ee81oHh1JksE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409385; c=relaxed/simple;
	bh=PpMzmYNriu+kPjIAZP8pB6tO9TzQKadRlUqAqHVTe8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2smgBUmFMYYv/592rKU3odR3tm0kqqw0BIFIQFBnFsS68rzt9FhWLZBfBRoRUHz9O8fnwFPgT37fj5aPy7SLBZWB74QM8RD/Q/+8Dr5i4v1cVV/efTZO7u5v9chji4rlikF3d9mDmW3LWVJGXHxuYgLu88hy0DPaIOxFzH+0Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=coxF0DUa; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="coxF0DUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luu3a/vtzA9YQl1OsS8jyXMxLhNxxX9sYQ8Z8gPKFiCOFmNnoIaDLZ+OPeanaP04TxSzVuRRXD1dL+v82z0oQG5Juz0lLSFZuNBHvqtYwm8QdUTCRLbgt7s6529lMfBwkJYMwre1I6OHbTsw+AJfdelFxwnTFXs53ezrQqUTitsTJ1FgjaPH8w3nXZcsLHnphXprcNCKvknFjnXJ0xfPGkTO4iS9ntXOWnBQW37i1GXu1opfPzCKTJX4OKg+tBPU3ZrYGMz27zmmRKfal8So7BTqN7FvaDc4eAh7pw4MaDRkLaAbE8pQ350Ah82+jhnI4MsjabgRq31I1mMDnQiqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w36FrPzjTCg0lOfwMgs32wGutB/hVoOD3mMkBHCWHOw=;
 b=f5F70WwUad2kMmVrk5jGjNfx+GpZa7ZNPteLbTMvBTgXFEwPf9eoCxIuGJsVoZAvnHdD4+yAoDUupWXiOg1oY0e404eX1ps88xqpJD3Ir7p/SBID/6cxkxGC8K/lHEUKzH4hPzhiYIjkkOByG1+9pbNhzHt3oZVDoJwOl5byWOdYSqCNEhZuHzZwodsMva3Z9ucEtjt6EQVsIYMtQIG2C8iBM5q80q2fyftl1YiOA3B78OJowkbU9gxvn8j98IbMge4HWPue+xtVe/uN2OpogEEqHFR9octSrnuZWcAc3XUn6UFfyc+7aVWUKSOrHrSM0vmKOlkeseZZDqKd+vtQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w36FrPzjTCg0lOfwMgs32wGutB/hVoOD3mMkBHCWHOw=;
 b=coxF0DUapsjWPPCWj4N7Y6qkrHt7d1CtVKqUdUgOfHbN2brLurpHPwHjNqQ8iI3dnt2+KggSIWnNN3NFqp1pxJh3QqhpdOqdjR487Zfahs4/RDdWuWeKRyTPujoy3DxGnGZ1rNc/R5porYBwpJT3BbG1dH4d+kREE+kGA4l4zkw=
Received: from PH8P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::34)
 by SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:41 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::db) by PH8P221CA0029.outlook.office365.com
 (2603:10b6:510:2d8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:41 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:37 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 11/13] cxl/atl: Lock decoders that need address translation
Date: Wed, 14 Jan 2026 17:48:27 +0100
Message-ID: <20260114164837.1076338-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0deec6ef-351d-43c5-8c05-08de538ce977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?apLf/9qnJ2hIdarNiU85SY2ECCUl4QuMQ3zGgIdC7jweK7GfkcmSXqmRuQyL?=
 =?us-ascii?Q?GjJeDejhKFSMyyoJou8/+5Hp7hXCY/ieznYlKQF4LzhFngN3LlljGZSgZRV3?=
 =?us-ascii?Q?E5gR/foNtyPgM1B6GHOmYWTCVb/i6Ms+1isf8i15nzZNSz+oIhD1ircB2WJI?=
 =?us-ascii?Q?f1zWMQRHrN/88tYvyfCCjV05xzuMs+WB9PQ3d8Ptgorbdk80IcB847OgNsJf?=
 =?us-ascii?Q?rNOT8cAOy/elmgoz8lTnnLJyanrffeFx3pHIJiGJV5vgRzmt3x9SEqpZB1nA?=
 =?us-ascii?Q?7oi1905OVjXbg/apO5U+bMYGadGItlQDZvha59wpm1yF4C/jZn+m80lfKbSX?=
 =?us-ascii?Q?47iTq9YdZnRMe0y2ZwNZqJV+YFgfpxdL3aaSkisrgJnftccbU/7qBhRpeFqj?=
 =?us-ascii?Q?r2wccxlNtNsEXYtjmjMJLYhYULFs0MqMvrd6pTvjZ15AXI9OECS0LLNfDbNi?=
 =?us-ascii?Q?F+HNXXL0zc1qCKJxlbzBQNLTSwJmmgjnMBBCJ+Q/RtvAXyk0U1X0DcXjMZf7?=
 =?us-ascii?Q?AEbgEx3XrPv1mwN0QBZmSDGLko/WW5/h/TgSdG6Z49J6ZBHpBmuD/WCLJhcj?=
 =?us-ascii?Q?BwFnT50a3rqkOBTI3C8+0lAm5I0mPHrETYjDYFZ9QQVKY6a2y4JEmpZ7L0dF?=
 =?us-ascii?Q?UZ6pyQBM+QIkDjMLjV1LjpE94PyJX8qLP7SWapY8Ia+FepajNn35p2P8gH2G?=
 =?us-ascii?Q?hR2IRJ2fZT3TrzyoV4WHenkJVpOym2iaN7e/IWvWf9Cn+YnM2sjP1ZRvjMUT?=
 =?us-ascii?Q?lvV0hHz1tqavvEDV5qf/Ltw1U73GDLLVMh4brjuxVOl6puTdQThvBWl8FiXs?=
 =?us-ascii?Q?6kdIInsaPGAq+JJqga81wcVvX5jVeewiES+HOLHRqpw0N0/q5RTeHbifzT18?=
 =?us-ascii?Q?zbX0mb2DDW7pREOTVAHNgcuJWF8yMinZqisNc/UVfX4orkI84blg5oKcaE4A?=
 =?us-ascii?Q?+/G/VmLHDfuaxphMg3/MqL636KZpSytS9HNUEc27tJWrdJG1PIIR9AkzEcJm?=
 =?us-ascii?Q?GiA+upLZeqbvqBhRMjP7Yv84+Ym/q5V1GgrMnweQFUzaXzGw6joV0lNvPfS4?=
 =?us-ascii?Q?dW4/MqzqxU7Ge6yXFpjn+Ar07HPL7af3vktXCD3tsrrmR0xz0y0dmHnTVn32?=
 =?us-ascii?Q?9ygj2XweIv6SJSLP/NZsTU3mtBjn/XauKflPeM4U1ROvkAG4I0STftLBBjjq?=
 =?us-ascii?Q?1x+1RoayAkSDmihg7oSSR5s4GOXw2jZGapLgfmST+fPjCOEwBCRrjq3Jkzti?=
 =?us-ascii?Q?GtNPuMcQFzxQE+pyDqi6/Sm8iIz8R3zsI8zGoOqN8MtUNRUHFyfnLae1EbQE?=
 =?us-ascii?Q?yxhSqSFhhVkVOd0L9jFIMKeS6x2GDsnq+4BTWPlEJ3LhhPvRybUjKV292kEV?=
 =?us-ascii?Q?rb2qbATN+8AENSkAPspE8j/0orhSXWVWMKWQPeQklnFyZNwrCKVPFH6drnCa?=
 =?us-ascii?Q?/G1vvSybxVX2ANfFuMy7dEOsY8pOp/ZrRCfORfQsM2zse2AlzqOOFFs10NAi?=
 =?us-ascii?Q?ZT/yUI2u2QGdQeR5KiZwm2kl6xhkZiAZI3kVZGvVUwCn1ELoTV9kWMYfJ23R?=
 =?us-ascii?Q?GrE2ibHi3qE/jiLnCLtLuRAbs/n6eAwRzm4jYPqB6d3i4GN1Pkrw50qVDalU?=
 =?us-ascii?Q?nY/CIWtR5eKaL3vNMhkLzayJW/SFqnxNAi9GCbujLfeOWvnvi3VA0hwsIMvG?=
 =?us-ascii?Q?BVU2XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:41.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deec6ef-351d-43c5-8c05-08de538ce977
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448

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

