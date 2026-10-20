Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792473277;
	b=fJt3LGn/yy1M5/dCNxglp8NUiLjd808z4WwK6QPqKfhUuJn8wYxlb8NBApK/l5b+fRkm
	 /J5DJoeu7B3l511wCPrXzpSW7STVgLAv4ocgLlKeCt72/Rb0HENHy47WZ2y8Vx80FrDoX
	 Ca4PujREXSdc1hM6o6pKZtfih/laujkfazhvhPK3IOQ9mtgGGuF+EjmDM3fIOkRjm/P6p
	 LLqEvt3B1pYkJfI7xr6yIoJ68N9Tim6cTBYm+wupIryuaNEdRVgVG6OviahJfSvkrVaDf
	 MgK9KFsaxJsJiwZHsNAcV7e0Tma+9xpzkXXhcQ/A8egn5I5TO16QNEc2qY1M8DMOpRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473277;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UTZX9yvxItJd745E+trGn5gfBNd8DuXvxeXNEmcL2T8=;
	b=R75mfoT4qZCC0uPS+ERlbVt96JRzpYLYF5HVMRVy2wnl6BguX+GM4JWuN8gWFFZINTs1
	 rUXitcyn8tvYWhIUBtzfbI0nv59VQmro/xu6J0EJf3OQh4aqHbLi0S65Whjt7otGcX6fy
	 TojCg3z1/yC83fqqIhQHJx2vsX8CnGmCF4PewGLJWQR+VQUrYwvElyP6insqLrm5KMDaD
	 /SH/PnpDYcDefIGQ78XvXgEq6JKnbj2nUSs6XAlLqIHjndKocgA8f+YzbB3+jb/sd/Q74
	 bezFg1NRiQWppVircYphuewY2+OIVF0kR6ua+Go2w4oXHZ5eVmfumVA++J3mkB6Twwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bTX+UXnF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.20
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD0606A319;
	Tue, 20 Oct 2026 05:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFD0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bTX+UXnF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiB/e9L6BKNFgn67Vg+9j0NqGmdF5cGFc2Hf3F+c0geLI9mZJSLih49nunuE1F5b9SdHZKIHwg6SJ3UyePWLM6iPEdw7XiFmduRCtIWUxdBWpOw+fwTSfhqHRSlxRaMK9HOeV3dadOrtQfZ/+3mnWh3Lor+8C/d32weFBrSLCOMaCxNLdQRvp90CB/owO1v1ctHguuxcn5ONlsg/3DTAXlNnjzffIlp+hpt8eFPbuZUs/YsWYR9cI3+W+kuszMZ83q7dlwUtCtdIrNu0NysE+pX4wE7slPViZw+Wtf/7U4yXLJUJKntcJAd7/qH2mBVt/YVc/v7LfWEPenxUxoaekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTZX9yvxItJd745E+trGn5gfBNd8DuXvxeXNEmcL2T8=;
 b=uGiatawCHwICACOtmw2Ucrb7Edh63Z+ezDU5Z/QvFjML3Emxe1Y7vgz0cbAXVdut+BpJOpynb9d1Sv3Slpn2VwRmbO/xG4CZ6bHurNGp67ZZooiyLWI+jOxSIIGl0vJabqohADl2eYNi7A01N/UO7Sq1WKgA/5rOMWrofSZz+mPYK53MpYDwpxBcJi3spzpYX/ZxKfYrcEB8P0n+wU8GcDIvf+cQhwFi34QBEWeq1TgcqtwwtZbV5fWRfIR9Q/HhCgk8dkdGr357Anlmc0bnveSia6ItgfI6325koBIlfdknA7IPpbgJOgpAA464JjdxxpoTgI1pJfv6GtcBsS885A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTZX9yvxItJd745E+trGn5gfBNd8DuXvxeXNEmcL2T8=;
 b=bTX+UXnF3rBgyK31GBGKiCl++ZPKfXbisGQ11GQkFTLHpqSMNaReZJpJsqpsrLPJNPs7nTlbGSjeBp3cZ7wpcC5gQ84w9As5ZA/X+L7HiEHMO9euR4CcsIlQJ8CMIcaLaIW+xW0SKrfKtJVlKH4d0q24dSLnqZq/lmx37j8C7HD5o4ZikTZnC5zxWbFOKUfReqLiZxx3zFRDbTtR5Hgi7tgRsNqCr+BAK5VmjQlxAGnyGSztj/nERGvojXvqxs9keSiAN/mqfkldCZXbHfBRzrgxMmAD5XQIf2/4VSHzHlfjf4llxiXccA3xFD1GxQBphg4UyOkmJD7ZzWk/6Uwr4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB292992.namprd12.prod.outlook.com (2603:10b6:208:5a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:14:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 05:14:34 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com
Cc: gourry@gourry.net,
	terry.bowman@amd.com,
	alucerop@amd.com,
	icheng@nvidia.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 3/4] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Tue, 20 Oct 2026 13:14:02 +0800
Message-ID: <20261020051403.14186-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020051403.14186-1-icheng@nvidia.com>
References: <20261020051403.14186-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB292992:EE_
X-MS-Office365-Filtering-Correlation-Id: c4394e83-df2c-414b-0cb0-08df2e690761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xlz+qohpKXYAf8odJGRHUauT40h6G23aLn8AJ5Bk9oot8m9wpcMtCLJJHCwUuKpVBz5Mzlb/pZTaizHG1A1XqRl+Vxvc0f4b8go8TTm8XkQmQUralzEejrcvuN9E7WBXuo2F3AXkGgfgUrXaTeVq/KXe8mO1HWSgirTXwLqKT/JV9UF4sVe9YOXbs/iN7m6hIgUoJARXqtlIv6C+IniNQYQ5jLmCpATSpsPhEVTWyIZeX4z2amTZC9SyZ6yhCHCrE/pyH104QxaNNrKAwV6JLelJqEzTu9PK2SVLEXFBCwum1Ls7h4bd242yfNEoZUZd2zSXs/M7jrUztO4bzlakfz5EIWglfJM/KXJhEsVwMSCB3ThGCgp9bin3zoJFZOLDaZF+M/OL/GNVgcZrm3aVMWGpuIoganTbKKbRXeZCyEjPEnjWycUoFA0IRqmQvCH+qRx2JlhI3F8M2O1pBGuyhtX1AHe6Jki5gboK3Ur/sEHj/1lyYOesB5tRaK120Aq/DuVnBoJMsn4unpxDq/TwVjF8VpPznoaKIpbBXqMxqspadZfPIqyKcfeKsmucmw68DZvbNjaPVJmlGkCZyrHhT5cwR2XsxWLwaKzoSNG593650wJkok7mpq2GoZ+46Td07SvGJjNcZheHmfq/S770lcsJSrcEPugudYfy1xE5YWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BmKMPP9l6l9WhZLsDgBmbKXOQ4eGyLfa8eYvKZF3ni+X7grekwCCQqOvEasG?=
 =?us-ascii?Q?7kZxclzbFMBw5w2x6dyTGNjX+FFCWw5qs80FaZ0T2Nprd4+FJxoUWNB6UbOm?=
 =?us-ascii?Q?nJ8WBi+h6+CnrM5MF7Iq4EqKfGaIK2fCgePrA+Ff13JAsGS3MTcgyFt6FT1P?=
 =?us-ascii?Q?LSqqVPXY11vIudPrGfM6bxH2pzQ/kNMiD5eUiAS4mfj5KZhxgKmTo7GWAttS?=
 =?us-ascii?Q?bMQEkUo/p4al1cQEC8VrjQe/BRNB4BoZrucCiEU6yjQvHe97AxCpuDHTitTs?=
 =?us-ascii?Q?WLK52Rc8Vje/CgrnZBlCwRQMa1RAw/4rMnJ4Gr4AKKLFp9NsBkPeKDBiXX4R?=
 =?us-ascii?Q?lhKGrMbGaLqNv+VMMEfcnSfEEdL1xkYg7chkFXieoeTvcEGTzF2jppXUdJpA?=
 =?us-ascii?Q?CjsUR5dkN2Y1D5O/f1P9BlLphYQC2oJ8V3QrDfvV6n0WLsnGcDf55rwNVKcH?=
 =?us-ascii?Q?kjSCt1XxhkFEVYxl2qBExvROLTrK5XuyDuO69XIoJoayUJDnMdRPgkjlhURm?=
 =?us-ascii?Q?vhHR2WmON7PIbvLFK/BAGaAbYFamQDMUN3MkKIUryrrrPyFgY11zEwfURYbP?=
 =?us-ascii?Q?U9VNnmoc7ptyAmLg0TFOz31nIVVLrh8Kc9YvNPZFZEgAgE45wy64udy36l3o?=
 =?us-ascii?Q?UY5Bx7yZ6LYbcqiwonoOirkNgJcow9ZV356+GQBfb9njvhuz3UQ+rA3xMtom?=
 =?us-ascii?Q?SqLcmSc7U4W1XrcyaOF4qxN2wWW3o+hioUTk0BaEt4KniGtHQ6k9mbAx194X?=
 =?us-ascii?Q?CJuLXZS+B6xrK4f1z8SjotQ5tQoFJM+6aho+5nTuFVPfemmANVRv6DPyZPsm?=
 =?us-ascii?Q?hb8rSxuMRMFGfZsm4k6wO6xTK4nMawhxz+cBYtk5wYAOmlbSSAkCRFmX346O?=
 =?us-ascii?Q?CsP/l99ZspO+dj/PQpPKQZY5F3aRMrXt5kv6CEdlfgIwakS8FdDgFCT6YoOT?=
 =?us-ascii?Q?vWQ5UbYWVbWwBKWOrLhI784TTVod1ENxp3FAwTjbNpXLvwffeIhKr7BGc+M6?=
 =?us-ascii?Q?xlGdMV/3BV3t5JKy3s7/ua1cnzi6WmMqt8TwBJZzGsIeu5IAZCF6Do82EjE7?=
 =?us-ascii?Q?UWF2PRP4JvEMj2tKmMT5x3VH8OVXjHW/iSf8/LQrLmvbO3hWOW+tSidpHjC2?=
 =?us-ascii?Q?jaDfy+Zq+6ERCNLZ4rCzMQGVSIXUgf0bSTk5vwzBwWEIfm2fr1obpHhM7AW+?=
 =?us-ascii?Q?iwF2xgeOi8gMjpi3bBSLCQ6tKXC9IV8UMnqC6BSJxJp/gfKTV7+kVZZx0bbX?=
 =?us-ascii?Q?X9iAz7E3wWBKfnsIW/Gpt34M/cKgAnfbpcpgIm2A9T65xB4q6ICk9LU6BBbL?=
 =?us-ascii?Q?uxInwxFfWfujcnSEW5Kk754MUbClWHBX3WInJYFQ9Dq3aTrcsnWndKFwSbCQ?=
 =?us-ascii?Q?P2OSPT4B7fLrzEmUL0ioOVk5iCNKDtTb+1zhB3wwixY6a9Ndly5s2TUV5DHa?=
 =?us-ascii?Q?0KxUGrgSHBGzx1/Op/mv7Bcn6eCJfpXxFCvYjutrlcVgxVquxTyVwmMiK1vw?=
 =?us-ascii?Q?GTMLfo9JyT3HK9Dli8rXDTKGaFHVxURiB+zgxrg08GpkwmV/jhjUNZXSuUJI?=
 =?us-ascii?Q?KvwxQTwFoa6K7GE4cM9rbooH9SZQ0U4DkVLLsw78CA34zlYtGdCedZ1jbOre?=
 =?us-ascii?Q?JIqLENJppMMDvQoj//yLq22bFIQ1Orwq11poSrGi7rILx9kSmt/6CiYdgsWJ?=
 =?us-ascii?Q?Hqlu9vQWmqIU1nI8xL4vJKoxf3u8QUCMOusainetFxNqZ04F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4394e83-df2c-414b-0cb0-08df2e690761
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:14:34.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XuE6evKeOZfqREaiZNyX9nvuXev8g8LZwwb39K9oosC/eQJUy9uI30naFF9obUW5LI5Ao3N90vv5qA0dDK/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB292992

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocations exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Also reset ctx.offset when falling back to partition 0 in
cxl_get_poison_by_endpoint(). Resetting the partition and address
together makes the starting position for the full-partition scan
explicit.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v8 -> v9:
- Rebase onto v7.3 of Linus tag
- Include the partition-0 fallback in cxl_get_poison_by_endpoint().
- Reset ctx.offset alongside ctx.part in that fallback, suggested by
  Alison Schofield
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ddf12075b95c..18114d25662b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	const struct resource *res;
-	struct resource *p, *last;
 	u64 offset, length;
 	int rc = 0;
 
@@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	 */
 	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
 		res = &cxlds->part[i].res;
-		for (p = res->child, last = NULL; p; p = p->sibling)
-			last = p;
-		if (last)
-			offset = last->end + 1;
+		if (i == ctx->part)
+			offset = ctx->offset;
 		else
 			offset = res->start;
 		length = res->end - offset + 1;
@@ -3001,9 +2998,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 	};
 
 	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
-	if (rc == 1)
+	if (rc == 1) {
+		if (ctx.part < 0) {
+			ctx.part = 0;
+			ctx.offset = 0;
+		}
 		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
 					     &ctx);
+	}
 
 	return rc;
 }
-- 
2.43.0

