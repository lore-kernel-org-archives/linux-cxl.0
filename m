Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179E4F55AC;
	Tue, 22 Sep 2026 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071951; cv=fail; b=Y/iD33PV12sG4w2QZWm2o+JVppSu+d8Vjhu8oL/ye0jarKhNhaKwu7KGeuc4B5ms+KdfAiZMsj0fAXk6WkeeYKljHCteqNA+SBn6YwjwWMPj1CtfU/uyO8gFqSXb4aMthV9Mbn7fGYwhZKY5rWv2ax/jx9oaU/DVDPUOLs3QXBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071951; c=relaxed/simple;
	bh=5VOmN5lyekZOecUAYhXMl1esJSESGIaF32Pi00UtLYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7ERyF7OWQ0Ws9F0aW8KPsILlvpkbOYxZ6Ibdp5BnOQ9vLqASThBCEL3WJiSTkdMtaZ+N//pVD3tZ1TVpekkvWtVAzfp3PSaJ7wRgpCuuVdeEaoTo56BfDXeIL3x+Mj/WaS88n9PtuyC3r1yfKbaqWBpUahzDQ/q+1Tn5oJAvWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdgJ7zhR; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdgJ7zhR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbehjYaIkduVjBGY6Xu11skTyfCfZvix0Yfw/T8TZmuRu/OREQp+RZ5KlX3/383i7ITY6zsvx21+cysn1GRbdM1XZ+HDR2bntgPPlBqZFaJ3kfSDqiXEkDv4dwxNoVnRhAyfrv6os0qlUlY0KGQaRcbsBqpkFDSUzLVVSPjsqXkfJ3NZfuoNBDdvz5Adlwukx/36TkiomILkkedv+2GiaREspA0GphPz3uZABXwJEouXW0HaCTFl8GM2vPLFe7WdcqqfWT7HQdgREdczOdQw5w5i/uCkBrRdb6mnN1bUIgrjgvJDOXP+89teEmUcgfdxoyhK+bI/rAniOs4ljIlwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUY8wkOedzWja5wUnHFmY7fCgtUGb9QSjnqti5Px5D4=;
 b=Edn2u+uOjWuD1ERc/VhLTNiuTcDPGunE0BkmDFQpFTfrVrufpAMY/RmGVYlqHbdTNP9t512y8kK+RwzfVIuvMlJl1KRshlaNOpK0q2GmL7UUiTkRzHn74nkRGU0WDANjf8AyzPVIccyNkONhiPsndDKljrNCGZulh9TyXMoAT9pHP7nIGJ9egk/RVviur/p5iwqr+lHaMOg7PmASSwXFmdHPMtxI4Gez3zgEJObAe4tIwd3AbT1REB86LFXDoPWeCwdNRf1UyWf6/xbI0MUbRu9Ii2fOLkjtnn41CT6hJBAw1BW8uak/Ii6fC3NnYxLKr3TdyTIWZJmP0wo1CqaKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUY8wkOedzWja5wUnHFmY7fCgtUGb9QSjnqti5Px5D4=;
 b=fdgJ7zhR39LpGwAdVNvNWFZG3qrdelM0drIH2hW2CVUbECe5P5cusanNxy+7Ku0EuMEUWLQra7cGvkLLLNglFjh62KzU2CFefWAmTWDvEwclSkr4GV2RxFlgW+qqXK6T3rZPzQNu6+C1BTYayaSMOK7mlOlqh/+CqEEVTkHQhLd1e1Odzx7cUVSo4dmiv5EplK1e0eg3/Kw+13lAx7awoLKQ2qbFHBhPnIE7HyGFufhs2QSbVcOkv/R2Bc5nEKtK8kiLUJ7OjqaB3dZ2RLym6E05EL5fzdg4ocYmwKCoRNYx6OH9D8Uyoe2oMcQmyRvZrXKAlMzr6BB3cEoKZN+zrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 10:11:58 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 10:11:58 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v8 3/4] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Tue, 22 Sep 2026 18:11:28 +0800
Message-ID: <20260922101129.52794-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922101129.52794-1-icheng@nvidia.com>
References: <20260922101129.52794-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 151b3b3d-cdf3-4329-f307-08df1891efbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MDy56jvVuHm80ei+bCwipysnslkXqGQ3IqyfShW4t15J4+YyeIthhzue9BXyKriyEYynchfD9f+ql5wnkxRqiP9r5ViXy23Dv33Rc6P3RqT9DpEfJWyre2pVLJy/4T3hbqZlPFgnW1nIaZZUHBGKpJGifHY4uDnNGbsL/8MTaq+TTC4JroSt8VVKnH41eC9H3V0wqT7R0em8V+4XwFS89TAu1hKJBx0BbEhDezjv8vkyXh7yMiGsjwtEbKX72KHJr4sr4RGL3jXJMx4glQ2QhCnV/diJU91QzU0RetA1GgkLJEJdILv/Syy+vdAJBeyfQdl/Nx6zS5aWd+4m/dw0ZfkT24a1JfMk+TLlyB/x4bserlx9ftlFL7LVCw9/GEKSEOrP7wEavbeqfR5LRuZUOAoedmLc7AJnYAU+cDcqcSEnR41GrRpcApGlwhivFRBBR7qAor+I5icBQIHZveagrBQCdP0sehIlpDZWKeatn2zGitWkh+ZvMyENrnK838J9XRc27Nh9QnClfTA6ke5DM1BnYxUgUo92cuNSCH/sWFTN+UFXnrmhXUTVt4cersUFFrd9PSV0jXaRcidxpSW9e5TIdY+6OaePuI7hqE6r0hlLzBaLnt/xTXwmeRBkeUB6uDLwKLaJbXnQ6y0u7vKnasyIPxP2LV+f9kMlmzgdHCk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qNctt2+YrzA/tf+D90Butkl3gp3P21ie8AOm1YrZq7ycI/rY7nb/aZCG82zF?=
 =?us-ascii?Q?peqLwVB7LJg7iFkXcD5lObYmsA8FtZrM8RdhCRgL8F406hIi1A5M17mIHhVp?=
 =?us-ascii?Q?8lnTyFC9dSffzM71LXamwA6BFVs2Jxwb6ezP+wVOEAIsADzRJL2t4BLgVS9f?=
 =?us-ascii?Q?T2/erGVVX/rW5hFHgMP6GsWD7sDesXXIgfvDecb4WXg8KM931XLMi988KmiY?=
 =?us-ascii?Q?M8nsjpBBZAHaHAc1kBZDXxNvfHWs7W8OwXaP7Ci8+hfICdILuPDh+Pjm54GF?=
 =?us-ascii?Q?r4ncDkA0n0EWZyI+BK/jgK/u0JrQScObBDeoOjkoUze5Sh4Fy9b7AGKkQC3z?=
 =?us-ascii?Q?wtw3OIE6y/U4n9nG21Ih6Bqyphp/BepsNOFMPEBz3HL/kEL5lfqVrwx0HypY?=
 =?us-ascii?Q?HyQpdOTiG3uXdZf8LTGwEjjCdEJzdBY52Pzu0tD6HwKwkLD+4t211lNAnvjm?=
 =?us-ascii?Q?NQrwZGPjqZ32XuqIAmAhnHz4eQXwGpXHsFprLRdqCCtjq6pmiGMIR3tRwV8L?=
 =?us-ascii?Q?e4UUNq7fAh42FCWsVORBD7rpVbqOeJBDBlw2A3PZAB+CMXEKCCqgAbYtZXFN?=
 =?us-ascii?Q?1EJI0JPKtjUGVVZR9/n5mLchxIlULEwsMy69TcEB4FeASzPZhCa/DluNy/KV?=
 =?us-ascii?Q?5+VJXPHMjitj9tHBU+oFdsCJapKZG7xWWvBoaSOsEuGsEvb8ykGarpETLF7y?=
 =?us-ascii?Q?F3ZtT09teXpfP9/o+wqUh9KAK0PHxdUpSYgSbXe9+lRQqBkGEI4mbtZFeI9J?=
 =?us-ascii?Q?BiW2Ar2MnMUb0Xed1UaZFG5/P/U9YnNWWgfPo3uOyk9gAy2D30HZt0L0NJYA?=
 =?us-ascii?Q?AgqjHL7OfpJgCRs729FPK/g3xDmmy7AWAVbWlF5/asdsofu0vkOvnRmXYD3C?=
 =?us-ascii?Q?V5TWUyBUhB3B4WRePBKRZDvY8bf1sKPNqCIzgogLHrY6NY9+C/e3//tX0+X6?=
 =?us-ascii?Q?aI6ztzPbbvC8O7OD0aQkDOIQPIs/FPXLdXhc3oiqR6r+GfaEcCNLO304f8cH?=
 =?us-ascii?Q?9QUuVUoHvoByJ+Mz2eN9uc8Ss3EfzlBsQc06MtybmuHdAO7MU9W2RA+ar3EG?=
 =?us-ascii?Q?NaazfL70XSODqt23XqzHipXAAFWU9lfheBrhG3+SSPCd1pOx/UgXsCTDkVuH?=
 =?us-ascii?Q?4i94gE33244dqvgMsAIzzNdQApDYc3T9nr1sPe8m5H3o/eJzPasFSVfAcHCb?=
 =?us-ascii?Q?npiFc6FQB99jgNQ6OEdZFLsS1QxelBMRncWeIaqy2tCRAcD6SEUpTnLE666k?=
 =?us-ascii?Q?YzDWwgCYfO8XOMB9jj3pT7FVMzKJTt2ha0SXO66Q/87KJ0bc5jS7/6U0JMP5?=
 =?us-ascii?Q?yBAePN1BZLzkxQPFDYkpLnPpBzlVH8+dZJYUA7Bv4oQ/gXnynEpFED7kqb9s?=
 =?us-ascii?Q?0n91uqohchukzaIeR67ArOn4olSqo4yqPj5T9SavKz5qkgBNfRKuqTr5s5mO?=
 =?us-ascii?Q?fJGjyUtGDeNleh1ZVHyIKIj4NwQtAC5xtHpe27nF0vDFfD7EUzFdjmp/glRZ?=
 =?us-ascii?Q?2dXZJZZM3F0exgUC+O/amYHUDCU0uKLkOYptJlZ5PMbyfNdM3hGxjMXbs+6N?=
 =?us-ascii?Q?1ac51L/kmKG/aBaA/yWSX9zDfTbXrEJtOa+miBe4qD381ZtVsyWGfT4M77ze?=
 =?us-ascii?Q?RxpU1U+bTLaqoWjEHGKBlo52u+zeLU+Za+xB76A0bb+mugCc1mwrjqyct90g?=
 =?us-ascii?Q?GpypfyaHWcgScl8qVmt4mrArsG+G5uPqGikBDz9uduIhY4pUIz9lyefA39+B?=
 =?us-ascii?Q?OZtpNAN1JQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151b3b3d-cdf3-4329-f307-08df1891efbe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:11:58.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms3yYT0vmk40PwN28BB6jnstZEEiBxtb/0KI7Njtjoy/9Fe/lTtN4DXxLjCClIFEdY7npfTTowwnTeSpBJs6ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 042356c71ed7..4869cdd6a3d4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2931,7 +2931,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	const struct resource *res;
-	struct resource *p, *last;
 	u64 offset, length;
 	int rc = 0;
 
@@ -2944,10 +2943,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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

