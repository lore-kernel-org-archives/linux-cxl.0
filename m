Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC400388382;
	Wed,  2 Sep 2026 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327586; cv=fail; b=f993NYiafiB9NKcva89vbuCLP1N7h0y5h1+ubcd/umVO3wYSZM8DNUpIOBK5VktRdoZvUdsl10pzQUPQozQmuzIssGAB7mDyAfQ2hpE7PCthc+xG4YaEKqVn031hgoAkUfreSddSZ4x4boHweBvnQNSUjrFN3Cjb8al05TylBCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327586; c=relaxed/simple;
	bh=QFn0C9ecIygFtCskeh8GPRleJ/gXkBsR3NqjGNtHhMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Twro8w9zR17KyoSapxzHdhLCjL7Vzw9mCN2idQlyxBnDzpkWvonmkb26idjZkNdpkxeH40fhv56asAJXaDjTtDjej45vJJtU5vGuI0OUDeK7jTFcbnDJkcGVoOt5UY0gJldDT3aYDCO+L2N7uyB/XpLXsy/hS6YPBzzQSDqDcUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=naoBPMBh; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="naoBPMBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riSg+D5hmhBV172Ht1/MgzGP7GUdtsWXZNp4yEEqiH2dP+F9BKtBtZRHxV7vMEw1kYUXan4TG6OqRNyz1yYzFa0reHP8n5og728x2qsTClRmkgBhYJ2DU+3tVeOuStYXtZLViEzs0ni1ZvOlmBD6iOqPq9ill9xNfZM67B37HP8QT3rti/VLL4fFp5/sEN0EG1TDoWAGUbUtkuGCUhf2w0n9O0DIWipCBFKjpvV9U9A9qFR6flxFyTfjfnzhMcN8+x3MU51QgjH/OABf2/c9nNRtDBSW3b4OGCE+fpxHPieOdWKFfOc928lLiIJfVjdi+m9ChK6Bl1AC97MpJVduxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aff9KhG4BIxhV8dm4JC5lFltV769GZGyGALlPzgW7xk=;
 b=LAmPQ97DNUkj4Qv94KHKsDAQ65bCPNxAucgQiVU45eM05nWO6ZpfHrkn7bYMSSk5adP0dgMo7/wYUBQL1aN4G9i55kDFQWvJ7FIBGOhFn78mpqJT/r40ZFmckBMixQZWWZrCSWX34RFc38AES60X91IMYau21Uo8HOUz12jHc1/9MP1IygCuFXMO6IaQYoIoa9UueMm9qqqt0mRo1Qpkc6ir6+uo04lSp+fPRvEOAz1BGv+K9tqyycw4I5XmnaSlhUeVIm67Vm6j5FvyLKs9k5lwYQvo5vh3PHwdZX82hjBgIH8/yTnlEU1jXJxvW77Kk4lEjr46bU85+lO/CXlV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aff9KhG4BIxhV8dm4JC5lFltV769GZGyGALlPzgW7xk=;
 b=naoBPMBhB/AEjg9K8SOLvvHdbZifdiJb4+w62bdSaAX+Of4O9L5E8lTjQSZq6VGTe1ZVP6Y1fAXLDoSANFktf6l8ZQ3SWsaSJeu9ML2EdiAHXjfFQfTiNFq6gmwUGCQac9zkJ99NyPKtTJdaWMJsdmweyieT9KAaq9XBm7bYO0JU/2Fg88tEX5XWfedLKy2hMmkzonQN0w2dntmDu0F3psfRYdR/0661PWPlJ36xet4woRFnqtxuMzsKIpJLYS4szJTi7TkkDSihelMt6PF2rWoY/p+0aGhye6gqVc1e2YZbzMI53Z+AfHkKGE2KrjOm5figI8kUOkSItKnBdKcVtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:39:33 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:39:33 +0000
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
Subject: [PATCH v7 6/7] cxl/region: Reject poison scan for decoder without a partition
Date: Wed,  2 Sep 2026 13:38:38 +0800
Message-ID: <20260902053839.25595-7-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 84974e61-32c5-4d27-e65b-08df08b490dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L+FdAvTbxcY0Mhf4Lxv/0vIjv7eud78rlXy9PL0ojDSPP/5V1hwSzyNhWf2Gtmwu2va2fTSnxz6qoNjK0zsJNpI4U7273LHA5AtWvzXAqrNwVC8YoEaknkFWwaxf2E2GMa1rHaFkBsIy4669H6SQ5DShflFEftY2pG+TlLVqyPqZAxNO2h/Xt5CPCPkzRCKw3qOTR5YCK5niq6D5W94dXdYO32Y3xLohMpfipoeiX0cxMLEs1VYvTUezBptvUk3U5YZeMxfHbTMLYUL5hHydHMKbSGN1U31vkStRpgrJ55zGQsvLSwHuELstr2EnMYCZvwWZnkRlWRDeGDRVzs2X1MeLNQxYHD1++g2rwKs10LVr/gSfqd1hJl+c3qWZDW6HjmvHRBXaNEDJIyUv/IM7vCNi+vAKbAkwWqRkQXK3VYsS2T17NcomNwXJ3gZrAr0MhL+VBl2qH6IWRZCG3LUGcWU5mydqi8tQGxbdr/pybIoUeVFQN2foXVRulfYSTxoIrwQGOvlM1+lFvhPSwe5Evhsz3Ta0CgDJVuqoc1lvPvs34SDZ1caLu4X/9yjQNcksucOdpHJi+cvNiEMJgf9ZsfcLqWVXwIscUJs2e2LdB5rAZyV6zubr1wS7gmf9TN+B5uTmQKx36IK+KlZSOgG5ZvRhxwvA5vUAIZrTqLxDyMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Lm/+xkf8VOS29Nu5qZSNVcO0PLyw49A96nk1Qkk6FfA7YzPL+0bs971k66l?=
 =?us-ascii?Q?ABRvwTrngGERw56PnVmzuYwKkkbftnv5oExxU8BSPB+U6u9TFf7s6EzmHOAm?=
 =?us-ascii?Q?dpwHgnFavHN+qqJ3ZGU2IBR9pUfgbC0okvcuo1IOtcUUWiEhbHElFLHnnGG9?=
 =?us-ascii?Q?kJTpmwsMEvUv4B7kNbvrhX2raD7pwH+ynz90IkJeRRi5W38f34ap5h1UUQPA?=
 =?us-ascii?Q?l8ywpjZ8M1upgRr0uJ20EDaLfLWsr9Y+4LoMT4oNaMQcjJCTpmHntOjuRb4L?=
 =?us-ascii?Q?cZCNmtqnmb6m0V1e6ILir5IG0lH5QyYQLdmPCgwtYl+X083njhGN185YZRV3?=
 =?us-ascii?Q?jW4p/Z8P0q9zpcn+vnvOrlksVqu0jOuzGi+SvANozc1mmsNNBsgUffVPRLyr?=
 =?us-ascii?Q?0Wm5eL80MPgMoruERNZAhN9SnF7B9strtbHEZe85ECEG9iUApH+Y2ZeP/KNh?=
 =?us-ascii?Q?tYKOudTs9IGz29bBzyjYd4ETzmkIHeHTwvut9azbhj3At7uKhAV8Y9GoKgGo?=
 =?us-ascii?Q?E1ka8U8e+ucBtgbzvzmktVAu/t9zcX5ea0bUJyQsyr+sxCu6pHYD8jy6+Rdz?=
 =?us-ascii?Q?nbKlk60Q+fEM7Rp7ckj22iIBA4Gq9BNlfqKssnLgnGHwtMvv8dfdZ9+uXuXf?=
 =?us-ascii?Q?ElbzIofKgKY4nOWljoxeVJ4uFqtxqXmhLJjpgfj8bcpHgZi9T+2b8YMIxFCP?=
 =?us-ascii?Q?rb1ITG1mIeLRg3ZLvA2S4x5eazN3kis6H6S081vYq1b8ZmXMy7VEZ7gG4ruK?=
 =?us-ascii?Q?QDw3r6WMhVBQ9d6Td8w1Ljfvg0fh3yjtQmpmkyyslEKTNzW1CLisbQpscz/t?=
 =?us-ascii?Q?1jff5ETWwQy3jVK4rTehrwKffcn8HjCmiwjP6AWnsllr+qjbdn7YdsuP9qAk?=
 =?us-ascii?Q?vl9/9uquLhScPSXsRdCOBAoONzpwwn4vsAVE7kxRNSQZZ193A86+Es21ipm2?=
 =?us-ascii?Q?SMB0r0PVFCb1bE+Nkijt66uCUXWY/9nS1dq3F7fn3s/lmf7FkYlWHD/kvNK5?=
 =?us-ascii?Q?avKTbdLeP7t426LAT6EcRlTr+RYfHa8/B9LTxRk3Uh9NaK4ivbbC6WlkAint?=
 =?us-ascii?Q?mGtOkiqPHg8xM1Q5iQL80ZID3xC7Xdoz4qCBnmyGZ3otGRewYbdfU8zMNGgv?=
 =?us-ascii?Q?f+dRFs+lg4HJQphrc+3/f9LNwRxlHdtMLKpOeSR0JgdB03I48lCP2OsXhSUP?=
 =?us-ascii?Q?XbGQkQV8kYXW/vLRzQnWLBLHJFlOkQ8in7Wppx27p6Ic6HOoPm7EiFJxJtO/?=
 =?us-ascii?Q?1/5fLhIaFAEg4t0xkF66JQFC+G89mLhTpb1Fe1vBSPdNsAA0saaKAaaGdoUC?=
 =?us-ascii?Q?Ur96S8ExyNxDBrjAcKJJfuI6i4vG0Yw0zsW22466kCQkiExF90WCLjl+JPgr?=
 =?us-ascii?Q?I0ZJU/GSoZD6RdX2PYB3kKi5bJHmSLKA687X30r3HU8910n0j8+02SSMRPC7?=
 =?us-ascii?Q?sfXKSb3G42t5ySFxlcT9fDaHSPf9qtpMeOw0QOZUyIsK6O8aJFhGrgRUEY/5?=
 =?us-ascii?Q?RORgQhi1iQsoC148BKZ34SJ2Gb+XellOIG3n8PybBESZ2/spadP32SsnOuIY?=
 =?us-ascii?Q?wk5ITOg963GRorVs6EiLu6eQQD2/R69q735NlmCwsCXZo3dxto7gY6cjQhx5?=
 =?us-ascii?Q?3otlxrAU6ooYdJp9CGByWrazrlWinPCe+mGqHy+6+D8KSmf+0tf4CY8JxYtX?=
 =?us-ascii?Q?lfiQu0A7swBRz1a5MJXgy8Pq1vH+cDUQPBcSsBJf87tSNbtk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84974e61-32c5-4d27-e65b-08df08b490dc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:39:33.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsaJ3SperrqwPNDBseatqYKFKZYPJh/5kYMzkNF4DPT6ifwn4HQuUtEk4MBlNoqQL8zME5RSMO4oz9rirmQ56w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

__cxl_dpa_reserve() may leave cxled->part at -1 when a decoder's DPA
range doesn't map to any reported partition, while still keeping
dpa_res. poison_by_decoder() then indexes cxlds->part[-1], causing an
out-of-bounds read when poison collection is triggered.

Return -ENODEV before accessing the partition array when no partition was
assigned.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b7dc5d4988da..afe3fb57b7fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	cxled = to_cxl_endpoint_decoder(dev);
 	if (!cxled->dpa_res)
 		return rc;
+	if (cxled->part < 0)
+		return -ENODEV;
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
-- 
2.53.0

