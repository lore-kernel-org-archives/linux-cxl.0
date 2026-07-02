Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA047CC83;
	Thu,  2 Jul 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983376; cv=fail; b=rVkLuXLQNZwc5JaZUPEzPAfvPW4JwdRtY8eQZKxuCOsZ7MYrmqln1RuUMZKnj0yek7eEM46n/7f4To4XMUQhN7hzTaeJmt9pv0vgWHVbneJDFvrXMwjr4jw3Rv4on/v4Y+5CfN891nJuSZO/R8xD8pRvfEdorR3p53rMzYNElCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983376; c=relaxed/simple;
	bh=nTzOBqDKwrHH9hLIwaADaWDvcgTL1XcVE0q8qnym3gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qupXOkJd5PUhXnzYxnA89OZOIHkzir+6DJqyPUZoJ2zPhq07ggh8PyFSu0iPX9HgZxLro7mCNtkC0BrwHy6tgCDWSXIG2Apk3FEAT47WX46Hlz/7smBlzvIDBwRSRbZQSoTn9bt4K+TAXaDy9hisJV3hAZpYqbMoZ7rgfkgqNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d1AhC7Lq; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d1AhC7Lq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXimJs2D0MLitczreBDX51rUyz6l6dICsqlU4fhv6wsm8jOUCls0I3spZ0Kl2joTePZS38230XczYb1xxZpAlUdR7eMzsO+JPbpJLCC+d1JKUSJALvkCxWFhOFBdOYRU601MNCaK6cKArPdVC8DX3rwAwje4Q3WRajPHd1LQDmo7TinwP49xB/hMuRYWcGotaK5X/hgAmMNNB3oHvhYh1/uhwNAExbwTbkg/GC1q5yeEOAVHIM+oCZjwr+AKqAFTiMYXbVAHtLRSOXp6sOGfXYWJHxa34dMN4RNHmr+9C0fNlLqkYh5uZVS/XcCk94zaue/B+CAN+XpQ2RIqHopjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7odmuXvYLllfxPGzpfoqdBPpSxcZ7Bul0C2a7HqwEzk=;
 b=aWiYTdD4o8piU5HJK9LCsVMsAmNPnkK+90SDoR48YveYNyh/H4aCv2FNleSlnF5GeIts67+66jJrcjNQ8TDLK4566d/g+YWQCbbdD2wkPMGKf2FKZP50MpLU8Xbs6NAMhGJltPDYgBYvXEcSQhqPtNu4HfGChnBqLE5hmE27pAyhchoj+8VOHlZ96QMyWdlLB7L6TH0sHT2hWjueo9ULC7+fwnVSyL9a695/a8s0fhFlrLVdW815VIn7OERzOyLJPsEVjjA+WcfNjA/lSHilBkhQDjhPjYRq4WS1l3VuNwP+M9yVExZDFlttXQDUMPhMvNl7yxP96vv78GrOK+T+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7odmuXvYLllfxPGzpfoqdBPpSxcZ7Bul0C2a7HqwEzk=;
 b=d1AhC7Lq7x7mdyNOePYiu46ncrbfC3EuZ7O7SpRbGkRZqXDbHA1UjAAnzPsZ/QLXQEzek1VR7sT01R44TlBR3SAB4RfYr7DRhHMRDrHHKJrXb0/oncTli3JclrWL6p0D6DWogQ175PaKHyY0QGa2PMwmBPPTI5YZ7M/FfCYVvrc/z2fOs1GCpzgEJkzABe+gpdS1gl3S/zwHxey9XzRg1z1d5fmeRHBoTnWMwlgZKPA9BUJxR+36xRvfHDoYOYlYXYGmD/odnHcyjtQdVSJDb1K1sULXBvIdOufds01fONam/p3EG5svs/MFVn/lBot2MhL0t4IxNnaC/GxK4eqReQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:09:30 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:09:30 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 4/5] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Thu,  2 Jul 2026 17:08:48 +0800
Message-ID: <20260702090849.47501-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702090849.47501-1-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0079.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 1136b108-d876-43d8-5206-08ded8199fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wucA421FxdpXWM4DmHGNzV9h7y5y3CpG6MmPjikwZ8ZOds+GWbz+umQ07RVI5Dtjfe55aPaPYNWMifTG05TfII4CO8hTAGGc+Rv9CI0PE/SbrarrhvXULZ/Nv/i1R9W18DFmRX6AInPVZJBfTeQg/3yVVzJ6BZDkXeJH5k2ikjbW6wDviEErR0N5CNk01TkTmL7oWQP+idtmP911QQw4Sbr3HaZiVtrm+ZMydZ1JWp+w6WB5cCmDAoGl4510Ng3nVvm4j9dtzB4N7xABrQhuHrD4uVnj1+YGmbBDVgLwwuw9gfUSoqBribyPF66gi0ZqlMBQJILYKLszpJixHsKUlm44guET6QeRKvxlhFnvdeP4IRmFVlW+4p7qystHLBDM7ijvYKCpHau0yb95pzogZUWS6V2w6Wc77QntPaXL58HYJiQjENCqcILXsayHFA48srV6rtIa5kSTK3R0xu5rh9xBRDRci04zESXljuEpbbO5mhOL+/UUrqE2RbQ5qLdmo0TjEyhzp3TGMMdmTJrK7HxPHqyQ3oJq+QvT04mVfPpNf3bd0bFl3+J5tQNMYBwY+mchdgX27agoB7UMu+/79FM5EmIX8avjsyxlouBAvrdMNvqPrrdy5F0A8faa4StouLX4tofeHvKFE7bjOoNpmrxBoboHBhieyOlnsLZS0eI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lGmj+5Lp3cRELft7Ghgfran5MioYlxgAVOmxEAd1nGIbcXaMWcXanRGJTvsn?=
 =?us-ascii?Q?6mMMH0cNsaEGwnMmmorXTYJzcOtS61Uc+XH1GY5BtTvpdIIYJhslQoMa8Nj5?=
 =?us-ascii?Q?0ndI6V9RJn0WALGMy3ua7t+Ucqxm7Wzaj0sF7ghlZzdKgmrDkkaWjr8ah/WO?=
 =?us-ascii?Q?gg1MLSCZCf1FXbes3Bl1mhSy44eF3zydcZXYPgrEQHeqnht8+GtKUqzMcAKe?=
 =?us-ascii?Q?3lUiRKjWl1uynUq1N59/v5dOC1LObjJeXG2kfnoyUXLMdBIGAGEWo3+J0Gxd?=
 =?us-ascii?Q?xiO9ZlT7aaaAaENPnQApqGy1JezCxEUF9nue9zXryZGFnu86eKdVustL6yvR?=
 =?us-ascii?Q?NdaZzOa6WdAs6BtrIvas7zw5uXMcUvjuIYx9aFiUkF3D9B4Ee5fLEokFPo5l?=
 =?us-ascii?Q?DTA3Gd9OsAmh0oQ0ATN7i52m1i4CClKRTrI/+7BKuLzhSVX/QLhl316kjX9a?=
 =?us-ascii?Q?PtBtkty1RCP073bvjBT8HlVrtMr/5SD58/oh6gZka50S+qfT4klJ57Mhw6FM?=
 =?us-ascii?Q?TNV6jvgDOdsnAN18s3gZh+XV3jLng1+HeAkRLX+7s5QoDxYzgM2tCUaa3VKj?=
 =?us-ascii?Q?1mLYV2qAo6jQxgWMbyyvWBp10uMs7K9l2WRQowK4f8Fyf1A01bOxzNCXeU8J?=
 =?us-ascii?Q?eMqFENTvBfbT9ObtF/J6LCIyA2PrkO5RbTjk4nM503bqrN4amjbJ956+6ZaG?=
 =?us-ascii?Q?1Oz+JmkpbbH25Yp4+eO/YHzIR+DLfMQsdQcsd3c7wLYBODngdGZh1EPCDD/p?=
 =?us-ascii?Q?e1XCgQpd13l4oOJ1ZXIYe6eplixrte31dvsNyOUlhtnd7wn5vyNMD2bCYAwj?=
 =?us-ascii?Q?4yuONMR6Mx2e8rhTF+1FVAaG7Vr0pg2wcxu+tuq4gIeBitBA+WVXbtZXkxQw?=
 =?us-ascii?Q?Ybtk1kkUHUNtGkHxnkCVsUT3YZu2CyB2Kz0q0q/buvyyB0qUdSANQaInhHIr?=
 =?us-ascii?Q?0RiB2zqsZDjY4/bohfeKtOLVK+cJWiltoYKYCrjtas94P4bV5q9d9p91A3y0?=
 =?us-ascii?Q?nCDPMC1ogkAktrycmDw053s3h7L1MkaasBWvO1SKFC/3CJNFOC9vpE66KuiW?=
 =?us-ascii?Q?+0mHP//PmHKBY9yJ1ZR6z7QNPtDO9p25W8ezaEJUUCzlHOD9vaDaD+DVECP0?=
 =?us-ascii?Q?FyOCxjgCRUy1M+E5LcxYClkgBsuxTo7VokVzN9NllTQQ1qC7xVZ+/38AU4KO?=
 =?us-ascii?Q?g5kdhJJvihwYb+CB6NftrL8BltcYr4WB6TcuY94IzoxJO2P2wOkDDR2Y0G87?=
 =?us-ascii?Q?dJDGY5INrVH87aPSNIVX3IGDdkHcUnrj85IqJczzGrMfiSbYmv8k2ElbHfd9?=
 =?us-ascii?Q?hnDZENiFyzt9K1yJhGINjhMEBOGUD7WsRuqt4cAOUZqzPmVeDg73dRqu1qo4?=
 =?us-ascii?Q?+u9GWJtKMHr+UPTQNk//l9Nv46z6PhKvhkQe1kWcRZ0WzGKfcVDPKT+9zZYe?=
 =?us-ascii?Q?403KnnWtSibunw7W93GEtOdV8/YQYJbuufoPyiJ65QmOY4tAVcX1/BEmeeKn?=
 =?us-ascii?Q?YjwC0TvJyUFUWwIx2KfY/IyerxunKmxTXC+5zVM22xktWkPe7PDaWZz6+QXn?=
 =?us-ascii?Q?ulNNUup3xIgyTuPkmNROdgxmn03mSXVCbrsLfY7mpAib8C8ic7fYr6Se2OD3?=
 =?us-ascii?Q?lwlDAiIiiP5ea4WpsQXeIwEMXNkwbFdTduWsokCAxTHKa1h+aCH2MfPtq8qc?=
 =?us-ascii?Q?6CX/3y1oqq2lpFiq0UXNgqBmK7qqJyJXyqgiaKS7yLNm+9snI80WO8ZRD+58?=
 =?us-ascii?Q?MnO0rolGjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1136b108-d876-43d8-5206-08ded8199fcf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:09:30.3869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbxDpzDxckzJGbmHplHNGXu1w18G3KEAXjFm18a7PmPIKWK0FvShFp5fqCysUS+jWrwVGd9pq/IAaQDXcmepcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko's report )
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 52ba8e9e4288..ba77416055f4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2910,7 +2910,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	const struct resource *res;
-	struct resource *p, *last;
 	u64 offset, length;
 	int rc = 0;
 
@@ -2923,10 +2922,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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
-- 
2.43.0

