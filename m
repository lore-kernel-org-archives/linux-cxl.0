Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7320ADC4
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592759; cv=fail; b=lagveN//DOyx2OFNx1bFuFij1k718BQmqDxdwb44GElHodqz/X/5tMQ5CRxPTQYQp/vouoNZxzq4lPfrQIAftH1SUyR8jp4ziwsQE8b1qomXqy7V36k1sSg3oZ+KsnaFsFSZiYF3qFu1PVT2zbv1AjxyWws9lDY6pLTtRFJQ5Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592759; c=relaxed/simple;
	bh=YQr0XUWroELiub5gax0Ca2nNgywyGnXt3TN0UHUjdos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyXMDxzbV0xJBRqCzghWZ9Md9J5nQVNAG+M9vx4BPRivq98G3iNp5lgTruEsGpR8QpM27qGqOS1OrHoQcQsTTff3MjjA0CpZhfmQkSFY0nvZgVSho3/S59+767cNAzQPpzKircZ6175gW7BzmGzyLBm+TGn9Y4FHCv67izI9UG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8Xfeqmb; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8Xfeqmb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcdrcj81ky0jIBcvH1HsetnzHSd2iVUkAkkzXzSA2qdMBa6jEhSfPoskNCyruVN2RsTjSOkAx1QOIOnqYJBT6snrOUVo9YtGvrr6ZiCEfC0o/lJ5mU+oz6Cr79lEClET8e704Camd2hXgIwqK/nWFuwYesl1Ap4JTQCRCqBstKBnNFwi9Z6bg30fjb7lolwPVyoVsIbQp2WhNF3fJ77zhLsZvaJMgf9t23/BafiSiIAZAIiGwdbyQXhEniR16jqE7NMLBlvh97Qm5iCLeSDAXDg4nNIxQB41rSstXbEUbKeRikjL+Hj4p9bW5qCbFT5PJoVd8JRdqlWr8YRHHcRtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoas6TZktEpibEJDyghROtuIsFsVybwK9KCh9JQy+CM=;
 b=wP1jpwp9PQnyyInn8mO++D9wIAxRDhQXwehsaP3akFx16/iVzTF+qTk6Mfh+47lZ8j5Z3Sx/wdFn13UEneNn+WBGsFRYcnMFk8OvM1RE0x2G7n0xguTlrSjYTJXmCx0HTCUcCzy/J+JhCF461Epl5Wbh/PjWDS2NrK/K9DpI5KZaKaMAxkExGlpeV0Q1v3zIjrOzLNjU7SakiARu1mNGdglSgyQC6qu1JYaW0nDLCigYJ3mP19uKJLjIND2H8PFSM6a3Z2VdMrNiat0ua7kMf8aI80GtxIaA2/NnouVh2vckv8Vq2ggsBF8DA/Tdm5n5OeMAZGzFiIcRIE1Gbdy2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoas6TZktEpibEJDyghROtuIsFsVybwK9KCh9JQy+CM=;
 b=T8Xfeqmbol1ofaBK39vwgMH86yk2GzgUt7OZE+AxtWq+9+XrXn7gE+Ilx0G5l9mDzBl3imIjSRd92LWpK/Jj7mgJ7UYJ6NOYXQ9L+brvSqXkW8VIxAzlxXEG/RW2c92kFpAj+Fq4U03BAPrvrhdPYqQvGAd8GTagimCoVihp2P8zj7E388bz0VlxuFZycfKv1c6GNXPo3AhL+gSXNPzmv1+uZJ219hqWwDQ7agWDVOLXF5rNHFQLJcylBurx6RYvv3Vf7h7ZEh1mD23eR6vao6WNWaHCsDLwSoHluu5wrB7dhlNcosTiqRLNrIFMj82r7NMbaVfkdiRsqHHwPtGMmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 14:25:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 14:25:55 +0000
Date: Mon, 3 Feb 2025 10:25:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [PATCH v2 08/16] cxl: Add FWCTL support to the CXL memdev driver
Message-ID: <20250203142554.GV5556@nvidia.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
 <20250201004459.466499-9-dave.jiang@intel.com>
 <20250203124232.00003dd2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203124232.00003dd2@huawei.com>
X-ClientProxiedBy: YQZPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: f038729d-a0ec-40b9-40ac-08dd445eabd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mlyed8QJsKlzYGNq+NaW/QqfWygTO7lLHBRHB3AkJ+ywT6ilNTdstJsRQglQ?=
 =?us-ascii?Q?oonKB27tj7ksAHPpLAovXE7zf6OCyXO2AyfhXu+Bzv14F9BH44gbBjZt8Mo3?=
 =?us-ascii?Q?2VYieHntCHZcbzzVfMkdK3Ojh56qa2u4+ZMC2TwXyrgX/7QFV0B6jH9Vd3Ss?=
 =?us-ascii?Q?26zevsdEGtaxhyHGN857aoidGHDQpPwkZ6GNh2Jo5sOKV64bT3qUn6KiWC5C?=
 =?us-ascii?Q?ZLkdULxKZ8fxOkkrG/wgK5ZBm1Vt9aK3GA+74qM1ig7YK5Q/T8wFrbzJHTIy?=
 =?us-ascii?Q?1eDuqNpFGcR0xHjAnpi07//DTTGSZBwRecmdaiS5jSRzt2QY+10WsjOoL4kL?=
 =?us-ascii?Q?CjCuLCLGdZyUgHpdMmLBynOmcX3AEqjq02FvY+PfNFjhgrMjv5OeCHufwYtP?=
 =?us-ascii?Q?o8K1+lOSBblXkAKxYwqCoMsmxEnU5MFv6Iu3aC40/GmwaUXyfjMM3dZR7RfN?=
 =?us-ascii?Q?jr42TL/EAJQQ2z5AruQSt0ZeTGbAqB7kMRDNQQhdCzsYru6CqWfBI5avXVwP?=
 =?us-ascii?Q?0DxJ42/2sN8jxhCMLAWcMXtzURBVvRWMkYFG5zJYUpBwdxG5ZzHoa7KtfHvW?=
 =?us-ascii?Q?qwaRFogk9N8ljfNRknlqpXfC4ahJwPjZfF3OhA3UaSNp0chr9DtaUbWU97mX?=
 =?us-ascii?Q?q6GOaHZp9eBN5Sx1Rwo7qTl0/G6dKYMNOLktEXUWPa3jEZf3YRdiS3rtxA+P?=
 =?us-ascii?Q?J9XlJfC8krBtS6u5v3tkNePwSyAHOaa9W2uwmNOTpjOPxsLFWNEA9VGFtyw2?=
 =?us-ascii?Q?rSoui9ql/qmx06gXx4RojJrZLODN/63slhpZXjev05f4k5Xrx+Rwe0VBH098?=
 =?us-ascii?Q?iEXObnq5apC7EV97JWXfEh5gvyJuENQ2Oy2XBIaZLWkpnS5hqFEhYQvk0lgI?=
 =?us-ascii?Q?tQwEu2WI9IvnrMjHdlHma+1WZWEN57hCsTQwY4eFFrne2FOadvBNha5BnEUZ?=
 =?us-ascii?Q?pWlYZ3a50O8D4LbGJ1UhjqftI+X7dOQTcFTWj/Zwz5USBujwaK0oQFAg3dmb?=
 =?us-ascii?Q?RjwZxE8mR9+SLvR+y/bEWSkHy4xfchN7rsvf613v6vND1AGew1dFwNnbU8w9?=
 =?us-ascii?Q?jz6tQYhQnONA7cOnGRSG1Vd+VQLhKWpbneQOk/hoqFZHGB+yj+xrwckCV0Fp?=
 =?us-ascii?Q?kfUftxAln7kGxuYJrbrDgzie3SgPO5F2kzaXTw7I4yyEhiQUBUstjX+bxosO?=
 =?us-ascii?Q?6VNathZ3Y9UWG56GrrmH59w6Yg/Ls5sZfi7hCqmTM7CQNk/noi98F4ZLU0zG?=
 =?us-ascii?Q?jyTtNcrrRpCHO2wDyPKu8M9vmJ5hjdaZeAHshxJhfkMjW+G8tEYWzafn8geY?=
 =?us-ascii?Q?Vw97fwaHix17O4zbeqSRA6sDh7Sg2nip0BoJ2P9F92Okh2wNO2mhAHk1WP2u?=
 =?us-ascii?Q?zjhoM2jMSoAAXlRYI7j5egjSM8G9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OR/88eyfwevnKtt8cGPCqyum63/XjTzdif8dM0F160D+deVK/RYaJtvYY9xq?=
 =?us-ascii?Q?PqmBzQbG+erba+B7mFfLEvcS5AOoDwSUTtwMY19g1let4PBNvXz0u6GgyQoJ?=
 =?us-ascii?Q?5yJAusWdKcWGyn/pt/+B8iuvqTmjrqSHyPJRIDfQueB9bWVqkzDnNMkV4ipr?=
 =?us-ascii?Q?dPW1JCFuS9yU+PtQ9/2o4U5y46ndHE2hUydgxgDOO1/82/F6+MLlqwHZPnYN?=
 =?us-ascii?Q?ka7GdnKncY7/4ydCv+J+3BYtl0tq0QsBIjeF76rWcv45KZAVB7TE0bhqUgR8?=
 =?us-ascii?Q?ZH/qInMMZ6fXRo7oQumpR3hmqwsBJeYpLfZIXbGfFRaiWomLMrWxUMJ6LErO?=
 =?us-ascii?Q?0z92IM+OBbFvY7NZUM5C10BGhOX+9Vn4svmWpOA6s3hTH2/EIGXBLBdNH9Zw?=
 =?us-ascii?Q?X04KHIELKdVtSJtfr1+4wJB+/1erup9cgJOTG0ZUwZhFCyl3ESraMHXHuguK?=
 =?us-ascii?Q?PMSysUKHd4UXqkUpve/E3dCR9RxR5uxxXyqFy5NzuJbXB2x+sP3qh2l72wg8?=
 =?us-ascii?Q?1T/fY9mwALOYDikc+NwYZWyKTTovTQjC7Cd/MOjkQ+9VrZbeWKy3m0M3Aeh1?=
 =?us-ascii?Q?wxhebYcuOtB9P63taddjSd8u0R58kDozDbi/yMo0NmmIKlDsU5K7mclNYvVY?=
 =?us-ascii?Q?bB20BEwo5QX2DnrRFe61z0NwZ9vQ5DP8Syz/mLNM9KWRKfua8vHu4QRodtlA?=
 =?us-ascii?Q?NDb3pE+fh9tMDigFELSHv0AqcHABqg/S+mIh8ni4XElRBP8LXAGJbbG6+yej?=
 =?us-ascii?Q?dSygWyc0zp5KUjsT6OAGcSQyPPvow/RESrArAyYIks1+1yRPq2alRlXpg9y7?=
 =?us-ascii?Q?KHecqZbKwnwYQwWPPlscZkW13gat6I1s36ECkEYEI+DmVOn6Gnhbx6/XLKZg?=
 =?us-ascii?Q?7M4tFJ1R6dI9CAlpqKe21DNrK1GmBAJFyFrYRLncFmodHZtOyEeXKShUsUTm?=
 =?us-ascii?Q?VC1S47UGiFWVwd4zNRR9bf8fNxyEIdSt7MOp83FP+XiFRlSatI7mRnkvP9aU?=
 =?us-ascii?Q?c83GVTr/Ld+jyJKqQPyYJdsFBd86ufwHP+uUwxZ/Yza2Bv/jLgsvNXUdOQTm?=
 =?us-ascii?Q?KD9mcRv70yn5sb6nvXGsoHUGd41kZzuX+d2Zr/sVyGx6yd/ZAFo3UjparI2t?=
 =?us-ascii?Q?LgLLllbSvcVV/PCJiPN9Usk+Vmv/1wqWN0cf2ap2YQNdi8RThHNy8CDpeTU2?=
 =?us-ascii?Q?8DwPbAgVMwyZ77hUZystZ6beNSFy2Px5Khb946W8FHgwWaDi6S6H2nFE4chc?=
 =?us-ascii?Q?g2b6NBrR94cykDJsycSvDh1wzHGFYgpTB5DGj25EP6sGnUN59mZJub4za9GX?=
 =?us-ascii?Q?4GTSui3+3czSEPLG3jS148xN1uLinSmeigjzET3LOUZgt6/IiykLSsH+BbiB?=
 =?us-ascii?Q?pLJAUJ0IHO99L4GYBUixCbWtqLJDSwqNxoMco1UcsHnjl8yXC//1CCgejneV?=
 =?us-ascii?Q?nlubbTmfUaEreiU7PyhGcCLe6wwgm7vBLOmpAPtQiDNoWYrmHkE1Vra+B0EC?=
 =?us-ascii?Q?LJZ4EKw2+wAygpLdzHeK0DSNOudfOf3/WmSwCaOA7nAbxVMgWtb/bvWPLLCb?=
 =?us-ascii?Q?qOndTlN8qRSV2YUiq3kDEx0qOc2UBoCFgnpD1Qve?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f038729d-a0ec-40b9-40ac-08dd445eabd7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:25:55.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS3jR2I99Gn7FvwrIXA46anXIPwi0Bg0eWAOnN+BrH/hqtRLqDuob8INqWMrUzd5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

On Mon, Feb 03, 2025 at 12:42:32PM +0000, Jonathan Cameron wrote:

> > diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> > index 82598a409acc..2dcfefdfa6b3 100644
> > --- a/drivers/cxl/features.c
> > +++ b/drivers/cxl/features.c
> 
> >  
> > +/* The __weak symbol gets replaced by FWCTL allocation function in fwctl.c */
> > +struct cxl_features_state * __weak devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> > +{

> This use of weak functions is a bit too clever for me to be entirely happy but it
> seems right so fair enough.

weak functions have become frowned upon lately and I can't clearly see
why you'd want this? Can you do it without it please?

Jason
