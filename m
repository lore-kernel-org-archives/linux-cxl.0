Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EB38643B;
	Wed,  2 Sep 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327565; cv=fail; b=N8EAqdTWeSGYAa5NkLAfs9a7isLR/bjJ23FdQA+wDck7d9t4F7hgInjuqx1DaOvVNVbMdCvtj1On1dXq0WODPR3CAgqrVG6J3lVy9Tgwl5EjqlVoXIIjwKPI2lzGGZMiozedNqZHblF+xAfQGdwrKvZm74JnA9jdQgz4oVX0UCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327565; c=relaxed/simple;
	bh=y0qVfNKazWpcwW7oLyLszshJo6GR9y7vR3mpasEiKZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZ3fkNXrtWBZCk8YdvZWZBAM7LFU0ZORpnDfP3yfg+xGJb+GhiTKYlibB7CrTS4VGrKGeUuyy/BIGflJzow0Eh6gEkGLDaPGUgNzZkxEbFovoXDndTUDCmlBOtfsKBeBH2d7KRIjCIHLE+UsMwMysEi6LtUiycFH42ZCFguRbEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G58iUJAr; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G58iUJAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEAfMqNiKm5zgqMluFZL/5bQov3jTLmp5uES4jISvyccw4Y6yJNfn/1YL51Kbrxj6esnc55K6WCK1hpdGGVIkWdU5x7GvVc468CHssvk+qAaneO0QFm/TdLm0uS401wGY853NaBWVHc9fjizYp7Dwu7MUOU90FoVCK+bfRD7ln8MHjMqteS9M4jHHntW639+xab34Myx47sb9DZpJWRsKd3SUZIYi3HgVT1XcEHiLatMBwVp9EXMP96Zs0BCtHdKkc9O+RJx+TapiUgG0ZweH+TiUmoRw02tRPx3x43M90EJYEuk2f/Vd+M5nvZ7ZH7k9w36FkC7CfMvd9RewOVNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSMcd5whCAUogFHcoM2SQ8q+J9eMgMsy7CJMZ9Ri2+4=;
 b=HrxKCt6oZBUy/fgAeCxNmyC091E3Uu18e6APsbtzYihdjjIpqSQVRGchoEviZ82L7KABh3QUr6LJ9EY7vJwlOHRm11mIYjUYqH6uNTyFg8PbJBVGsirTw38oPiXV17nHsotAXg/CVbR29JRPf+mG/n39lLny+o9SypJ2T8AgC0wCrobC5mvIiO7tr7PR0GnFKGWsnNwCKGmJ1whMOpJ16EvQBbE2nXgp4KqYq4NlxFCpHpXGjgBTNyfEUU5o58D4qc27SGv9EJHr4jvbHocYPPzNnMzfsDi3yba5WZIHZPUN6K77X8BvvaiGqfbRyS23IM7KoxD64HWj5Np2t4TdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSMcd5whCAUogFHcoM2SQ8q+J9eMgMsy7CJMZ9Ri2+4=;
 b=G58iUJArZwRJjKqFmOm56JVaRmg7Gj1j2OmbLNtl15KUpzTmeXM8pQne287dSB28zhLrigk25337/Y3HOB0IhSeHHa8HPKzXrvcG1l4gDtr+3ucvXhlgkFIpngPQSzPnmsK7JxQcSz7gCsdpTo6RSwNQAreB2l/hTuBHngid1i6t085TbvknEMkdX8+JQvnQumY1JoOoLNqTZIViePUKQOhgjTNeaPMN0mqPsNioV/YHN6COTmXGUn+xlaNOEvqtmxSLsHN+lVimhOMgqDJNiAqTbFcClzAMLcqOJ0dixednJz7+HXv+UUbV/eJpIxGLcv2jEfDQ9+gcHMpmmPRS4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:39:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:39:20 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v7 4/7] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Wed,  2 Sep 2026 13:38:36 +0800
Message-ID: <20260902053839.25595-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:4:297::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adedff2-8db5-49a6-ee7e-08df08b48915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ggT/38ihsbQqklX5M9xyLcBE5g0qLd3BWUsHSqJyitGeefpoD0wunWsUQADLz/atmxP+LFXoqH64VfQVbGMdVRg36CxLWwkZWucwCYuN3ze88105Fi/KTVtmQgs2F41uQS3a6/nO4s7xg2NpbUTF6J2gqHQ2vT0FvTUANgwFKVlIOByxUpwwzKbVHkf3Kl5QjeAjp6iYo77jno2TSAzWGhjzr53rnDL3/it4AkZX7pn8Z1maYnCR7Z21X6sNNpooNuMN3h6KC7RAyd5qCBj52EKfQPloYlM4LeN5ygHTyg6YYsbMgxIKy9BGVngLJ2bWGfFIcH01RRgVAuXCZVnT+OzOuyCw2rMseVKxGlFwWLFcKMaL6czcWJAjs2QJ9qtVezIlDZdrHIBTgjRFLMX1+bxH8/RpT9jdXXfskJup91BAWRFmdUqY4DhuuP6Sk1YqEhNvVoKnvEt0gBpucxqaLLd7mZ4havncY0h4Bscxsim+v/FKotxKxQe8RZTAvtLmwe1BvIvlsfSUTDuGRPS3gUlOvdsLj/PQoMwRHD0Ux23h9LEfEaawojI+A1k/SlFtMpLJR82wNUJRXajIdytsryG/cpk8lBlrJknhYkfX5Nm3/cVyodBT54VliiOKPqTfKHYxY8XN9MR+62Vi8IN1Q6P1GobibQB7xOasz4zE78c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Dzh+L04UAqHwgowiImCZbFBL7qB7Jx/NZmqGsu7/Ou60jpN0rAU+m4jYXJQ?=
 =?us-ascii?Q?aaczNkzhfUacTb0+oMAsrYrA/Zaa7InlBmt3a4VRSHjwmU/wGAbvLY8XfTAh?=
 =?us-ascii?Q?YNxgXBx6dEo1wWaDcv3IRKREVEWngewUHEhLzVphM08HJ6pRZzbi4jzyiO+J?=
 =?us-ascii?Q?LOwxI0NEtNIh/cghIkixzrmCM1lzahr1v47nuvYEYPGdf8jXMm23UakD6i/t?=
 =?us-ascii?Q?HnKGLPO6mwNlEEp8JFkS40gad4v/4b08SyOlTJZnZqJt2AfaD5JntftvjzHi?=
 =?us-ascii?Q?Og5+dHB+nw6BdvzV2XP4jf6WeZi30LorfRXHco5r0pNmAAoWp0lJBDtdioK6?=
 =?us-ascii?Q?zQnDqBILABQm8G4v3szx64maitjVTW5VCGhVw9ivIA0Jyezq9/8JPB0EnGQN?=
 =?us-ascii?Q?DqLC3xc9PfzFUmDShH17pS4dO0J3vEu0ZW2bSgEUAbBDFv693WA+1AGkerYd?=
 =?us-ascii?Q?SXOb3YJ6nzzGTG6Q82aBI7x4ui6Z2E1Dh8mM1rinnMzK/+Ar5FljY2XnZY8e?=
 =?us-ascii?Q?lhiKGAK9EfPexPni3Xq2rjoo8D99qLVnCT2UD00E0PELQRBKRSZgSW9fk8NR?=
 =?us-ascii?Q?HNeUD7Pp3Jjyya0H+vsAt8UTxV85XeV6cn2bw+K7LMYFVSrGV6GFTDBsAtu6?=
 =?us-ascii?Q?s2WYtSNm4A6LI7ktAGSGdHud/1cgBiEghYz7HfdO+teWVXL2NBCWz1U9L4qP?=
 =?us-ascii?Q?19YVjPDl1UwZUCkQzKmngLACY5YZ7sTEkAKKqy2n/eCXr6/lcZyIROB1Uiew?=
 =?us-ascii?Q?Qa6MxVBUta9ubyV7hbnqkMvKy2hKpIsNua1LSAnwSZYJPeb1Ng7K0N3KMRQr?=
 =?us-ascii?Q?5s1Dqf0o238FBgrPq+jMAgu0f1+YRcogNSOwa+UoQV88t4lx2qyxuug099HH?=
 =?us-ascii?Q?GKLNaXbafcKUstMFZKBphK6VUdZrXbA/0CY9O2QGi7qnV6gKXLbulP/P7Lbr?=
 =?us-ascii?Q?GayqjTMrA9C3ZrxOL8hAlTxC4c9fBmucoPsPoElgZu++c4iWoTXa1vwv8TKo?=
 =?us-ascii?Q?QA/PDEfmNk7PhiSwiF/frgzoxh7wO5VkCRMDdeGL/G7gchfcTsNPwqfdQ8jS?=
 =?us-ascii?Q?DaNg/vbLxaxlgojTdfkuC05nUugTeBlYVGsWIMNNBL07de7juB+Y5oObzNAO?=
 =?us-ascii?Q?euSAEvl2oMyljT5/Wqw9Jm1fTc2taR2EFSM0vczYdOclawO/aZCJZkcG0bsZ?=
 =?us-ascii?Q?X9DFHtgmqF2XkjYG2OWstDJx/iKY/BrIp90OMD/sjdojRyYMlDzSRQN7D63e?=
 =?us-ascii?Q?Z8qQJEauqXX7xbhMqIh/e+ywowoZc2SFSHd4LYnLasFdE5Jlt5AHtCd7DQ9g?=
 =?us-ascii?Q?349ax7VfSiOLyqnrsjd/MxRmvjz2NMyX2+REa5RKjUcE8NGgYckVgp5AfWYC?=
 =?us-ascii?Q?vTcItz2NFixBtiHGnk4FDBV1Mki8H7Bzsh9aMIxdErgOWmFMPm1XF/lbcAQU?=
 =?us-ascii?Q?+YdYU3nWUllP86IIj+TPsf9v7t5R2vUDhgraUhVLb1+F4lxAIXbLZG4ZD8wY?=
 =?us-ascii?Q?kT88+8SAmKqJ/xX6Ocu42+U7LOi/k6Gci33o861e7CjURym5URVmcK8C8wE5?=
 =?us-ascii?Q?WH/9qDnp8EdRtj08JsQytOCanZw7rPLTsh5EW1esoPq/oI2kn49ZkWIPcoxU?=
 =?us-ascii?Q?dRsFlJNQHQosrZ8fzcdHdhuSbgiVjQxJByQhWqrCOhgTukl9dHLyhbw5ghB1?=
 =?us-ascii?Q?s2YZ3merMYSpw5RmgmY7gYrFX/a/WKCTopOmvYvax0iX2t4d4cNNY+pseQjl?=
 =?us-ascii?Q?8FT4YBSn2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adedff2-8db5-49a6-ee7e-08df08b48915
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:39:20.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3+EqfNwYXvbxaDJVzVvXpZIRRo3GzfZLjHNuzcX7BghBr6+IzVUae/GhYvhNJ2imdgBB/CA5ZG0+sErH+uizQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ddf12075b95c..b7dc5d4988da 100644
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
-- 
2.53.0

