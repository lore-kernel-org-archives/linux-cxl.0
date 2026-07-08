Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B23F888B;
	Wed,  8 Jul 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496611; cv=fail; b=IZY/lQWCQMk+az59uM3wH1e8ti2xbQWF3PjwIF8pG58NM0ac9jZ3rjxeXuvhzubJblipnPvyktGTkwdCWYN+TdsVOz3Xe8GFjR1vsLQmUwDKCQtga0Fv+ZydBQ+Ykt1rEULcZYhuRrEaO0oD83lR4jTqWoYuZA8B3Zzq/FLWVMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496611; c=relaxed/simple;
	bh=hJBavGEap7o5UaK7Ez2ws1Z0RfRZxETRGNvXUOAlQIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSDujCljqRQqjVbcV+3x9HdtEZA9YzeK9JrR3lgg/E/5GdHFZ7AZyJloLLM6jqW0K7K/WZxkyHm3a4V+vkAkxhBvVjiCpKOGJcH0WEYpUNc/9XPUCYiyPfSACAvirZCkKRtt0ekMcoLux9u4yQYZr96RBkkekMruGkInsCVf0jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rYKR9YLk; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rYKR9YLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md8K0UFZO1UF6wO3Af/08Ny3srI9Q8kbaLFMXTZYekEfrYhWSACa4aIAAdnnsjeoXAUT1a4f5s67Z6UKmZWYPRMBuEiH1dBC2Oqtnhyg9C0y4XyL+PuOG9G/PArW7n19z05SrP4sBMgi7P0FtvY75mUG2qD1Ny3glc8I1kC45bLwSezFSjCtXP/tHLG5PlIjk4aP76rZVA14klb78gDmC5yb0D/5aXpofpeqa0+JEyTOgopaA57MqKgSPNDlFKZ1saVQvnn3aIQUGPC8AAES26bzVtYEpxMLkFUSP9XWu6vnGcgjRGgh+EclNByqf5shwyGvGPYVeFBMTKbUTqWEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaMO3uMZoZ75acsKBZV+twGH+vjPhFVnYl2fdCV4AaI=;
 b=X7ajl3xKMucqfWtYCsLBi9LuiV/bL1DCQvQ2lVBog9BC4hyPF2HjFfTicFcnzPyJBQTVdPW/F54UXNka+CIOy4qw/4EWktoZ3C3qTRpYvKDLNt8IM/KVaWTTn0zwEx0b/wp1qOIbremB0IEkCHb3pSXKP3urUm56PE2zAJd0xdjbvXBBUJGJGjOWBiX/73SYUabGDe4F6h8bt4Bi5RDPawnwwciglpk0dkC33vVeupa5Ubs6cmHNzonvA3mkINK0NXR6+ke2JP2toWP6i4zg95rcM8QY52t8DkPrasZUAreHBt3pO6HlYLRhKAPsqDtnB//beirEiPUpFXCjCsrvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaMO3uMZoZ75acsKBZV+twGH+vjPhFVnYl2fdCV4AaI=;
 b=rYKR9YLk6DUnoyHtYD/98OsFyE4tVcYa+nO5s0V4G+hYj547azCyj5jDbYjBSqF8E27NdzLEzNtBv8IJco79cfW3fo5ccvMN3LUmoXHPvM51cMLjZYsnQ4cCOGvEJjRIT6ntF3l2RgEnCD9+G9pfy8mt7MqnKBmfACTc5Go5n/pIBe/XeZLWdSTOuckpGqSD0+fh++Vl+ZmoZnr0+3VHCPqsOfXXLjmA+vvetRmFyNaIglaMz2zeR8UfaOs1ukHsUA/lP3uAGD2tba9AvO+O1gHD8Fdu+3s5AwHRr8EhMCXeekfbmAgjEP2Zob2tS+RRhs8xUbhvbqBTXuYDlYVWww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:42:58 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:42:58 +0000
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
Subject: [PATCH v3 4/5] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Wed,  8 Jul 2026 15:42:27 +0800
Message-ID: <20260708074228.43654-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708074228.43654-1-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 287a87ce-e45e-4e40-cbe5-08dedcc487d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q7a2sgd8C7krCkclUuppKYoWg15318dScdfzrdzE0jFg4Zs7OZIfxQsm6xwutAfsN1IiyhmPh5NhaM6OBnp6lAwljQXd40oMIo+9Mxn6fGb+6j18L2f3Uq7hzdXI1oGAxVC7ucp89cBBpSf8d10LmS/zSMigzS/teN78m0Lq4W8NzWMb4+lB3h08xsrhZWQsKJ6awPg+CC/KiwsWU/sOXww5Qt1juA8iG9FEhSuERW8R0moDV1Vj9gEekryjrDWUT4vPiZTc+xW0odsWfE7UZgcaRhbXqhJKMIJgON4kBZQrewsSeHZNaOdhxd/o4QixO8ha+40n7c/PnjcrMo73bSlYhKP5cYI5a5JQKr75g8GiH11L9stVl7Df/XZRpx9BtchE0XbppghOUYTiyWmqMmHjvycsEhiIh6T9/xqBeYJkiaXXwWL2EnP3rYLtzR8TATrPxIQW9MjAQOxNUPkCiNjJdZ3gA7qi6NKonVxSoyxSkEYnZqljFoXJcJ9QV5Hr+/czh+3zCi1EqfBRs26wVIvu5jcRXBkvwt6s8NyeiptjNwYLRzkWjLnjoDcCqC4jE3i7DoK29AWK9H6RDaFhcRc7GKsV+qbsz4zJkpdqUhzPxL2Qp5P+6iAc8TdGAAdyiogeqNg1mdps2Pcz65l9/XJxY/n8G4vDvp95b7Bw07A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rc35t2VHXkkFKROeX+qC8TYq49wrY/lwsWmWA839uQK42jNyyJtGClIXD409?=
 =?us-ascii?Q?QRpxbU39ZSWm3SOgNmGyg+8uxaqHwyHpLIU0XHYH1s/un/80v8KeRSuR9xBw?=
 =?us-ascii?Q?ZnkzI5D1eAymFzmG02eNEptdkq/qiNmwzwkD3AoObRdAHDvB++5jMy0kLrgb?=
 =?us-ascii?Q?N1zzboL+LAGna1WTtEpuVrDacpw54uq4ahabRplYqsmy3UH1IKkpGpFJkjez?=
 =?us-ascii?Q?LlJv0SRP3RkWnfPRbE5wBpB2J34LuFeoVinsM163ut8itMjzlS1C0IEgucwm?=
 =?us-ascii?Q?f2k9n+350Jg5neVl+lU77KxEZAEV7fYh+kOXfvrAzQ6VSQlj8fgp4LnU9n1e?=
 =?us-ascii?Q?dHoz1Lzf89PTreB0Bf6vzwrhbfrxBqWsbLuzwzMciO0/mmVJHfzofgs0lu33?=
 =?us-ascii?Q?t4twkHPqQ7w1USi4JQtUL9kh41/30MycORg/E0rnYo22GcQrCjgNlHsmjSqx?=
 =?us-ascii?Q?uB09QxJgrkwxNYFwOdBTVrl78t3s2lPVZzaJJF6TkhaSTBa/MlimDcOyZVYh?=
 =?us-ascii?Q?jcnNg4rfhy49aO+lp4lXi2wd4MWHtgdOVcnHMtD6jLn0yp4fyBg0AQCa89VN?=
 =?us-ascii?Q?/TmPAGaaYGwhNbubckiqZeq+4GAgBIlbq4qDg3elOF2TJ+b2WPqRVqOr29Ll?=
 =?us-ascii?Q?oCgphG9RXbPq0Gw8qraQ642sxu7HDnI56AxizdtTJTtWciu/Z2zTq53+01/g?=
 =?us-ascii?Q?KLxBMfE9CdPjhVNfpbbK/wKYQlevm00aSUsqwQD9LCBwDvJgnFyB5iJJ6z3o?=
 =?us-ascii?Q?hxhIfLsWLNsnJAfbKnsR5q4fSj0LCgu7Dg5rNEP/UWVg482XWGzX+qQQkslp?=
 =?us-ascii?Q?+Oyj/on4b2BWGj45UgGp8cqOjhMpyyuQmVON5uyBQshbCq3pythTOdK5cD8j?=
 =?us-ascii?Q?f1Uy8zwSW29Zab1SuP8B47aS+UJWo/vFlTjhf/peoUlc47J/KFLNQ2W8/A+K?=
 =?us-ascii?Q?A0q3AmqWLUrCUfg1qAAb2xml6rj4sGcyCH3QPqivfrE8x+ZNHBNpaXMDpKly?=
 =?us-ascii?Q?kIgPMofunPvz5JEbyXRxN5zTrBBof0XT/k6exOp2ZkMSxkk7/iLeZa0hyehg?=
 =?us-ascii?Q?Z6zBcugSpCxSyM05fZhyV2f8urscRlsQt54zEQoClaCuFYAljKZJFNYXHefP?=
 =?us-ascii?Q?hqNIM1FbRhVrGptcfZTVTMS4g4ucxbf6NJw84RHTtmh6U7coLI6Yl997jRRj?=
 =?us-ascii?Q?RP5UMELjulRtvdQ2b1wEdkbMNu6ji7oC9Iz98JPTuvlSZJdvidxsnvUrTgIs?=
 =?us-ascii?Q?yv5l0nKpJPVWLcX80GijuFK9631GW2vPOp2TlEoBhShO5l2T0RbU77/8M/n5?=
 =?us-ascii?Q?TtCwoLfkpBR2VAF4mlLdZReGD0k4tICnx0c0d97wDT6V/qSHEP4svopvAwOA?=
 =?us-ascii?Q?WVzowV7MNojSWe4QWMxNPPc3s1an2KH/uEamlCGiHpg3uesLf8W6N7rZBK3y?=
 =?us-ascii?Q?AUlgP5cF1NQPhRbhwBsiKJW0v+fFvLD+vogQldIB25p5ZMeM1uqahGJPw5FR?=
 =?us-ascii?Q?+IqVFEHLRFzEm6yXmOKbi/Hbb9JlRLTPErp2tklfknTg7kF7mx30NYOaUALx?=
 =?us-ascii?Q?n8qC/yXBj1F7WKde/1omDqwRz6qkaro0dKKqlT/aMEW5XWj//GjEN8y0o8SG?=
 =?us-ascii?Q?zwhWBYdjXMgCLpNxTgxZLE79SyIf0Q6/zs9an2EwvZWmPxlgzMnmZ3DYs9K4?=
 =?us-ascii?Q?E2KN7xiob0hnzKYZkbOHYRr70mZzH7xcur77WvFH4FtmAcGzSmMoyn9YnSlu?=
 =?us-ascii?Q?Ehmv2bAKkg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287a87ce-e45e-4e40-cbe5-08dedcc487d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:42:58.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrWsoW7bK4VSWOu98gDm1QV5MOCAVKQrZaHkqdQ1IBhSFMbxMUI1ZhRLxy9zmo8JivJp7zOsZo8NQOY6S94pxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

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

v2->v3:
    - No code changes.

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

