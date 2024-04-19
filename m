Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF528F0
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545545; cv=fail; b=DqV0YMf/ap+eKUkRO+IisGNi/ly/MwMT8cMw1P3/7ZNVMCWFLG81Dztk0rnZD7fY39D4ZgIPZah3fa8JNPLtLdc1JrIpyyHUtqNJCvsfWrRQ5qKigFLACEWMAQaB7EILSKqCBX9z8yTWsAo2e859Gro/GftZ3TJAHBl1YFaLTD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545545; c=relaxed/simple;
	bh=C5SXGKP6kx71eG72o1Zna9DhtA8uJOGMKdFq98wBUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h9q/6eTEiCiAqF3CXK7Vck0s5GrkzLAynrVAYg03tw9aQ5utaJG28yxEUwX1gt9CcvHyAXKsuv7k53ZORKvXIcpEQSfinARGJmEuuhy7vY1JvMNjDOJEE9cv2FSKFcE2p/auJedbKnxq3qJsyErOb24whtyz3XuW/1V45DS0RI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=vIQ1L4p4; arc=fail smtp.client-ip=40.107.93.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="vIQ1L4p4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaSmq19ZLlT4VTw25uMkScahBPzrNYdnfhhT7bGa04LbsRnJnzjUEjzX+ym4b9VCNas8M6twTDjeMWnM59mX7rqmOfwtdQ13gE7JvQbA6zudt2E5YnUuNz6zZTeJdyyt9/qdzOu5UHiussEnuq619hG6hCWNLgVTsjh1CyjaspPazRphWB+jMW3pZB8dCUmz0aq/xQ+IugL2FC9YpBUEWhuSvsGfJdTaZOz3+cpVLARHOLd5SzzbjyC2rkzb566Y6O3M8Hd3IXiA1erk43hE5XQEk7HzyItgFYm7LuvY7D9eIZX/EJ0qFHhHM2qkcUVkHKqzCwPZdkTC+oDrMI/qnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojHiFc3doZizGwN1NTZGBbZq0acbQ0vpJZJoUTFPA28=;
 b=IplMBxD46c5vCNZ6meu2yU46cURSHjOtpXce2DvHhmMzHO5nM7zZlSAr58tiOED1LdMNK3WHt2+oauAVI6OwiudkHeGxZLhZDJ+fT9LjHJZpQrc+gczq8IHtymH3hL12WdYruXSFz+QHtjXwKuE0BTkbrtI5OEzvEHfsSSeiIQBzzy2bL9nEOJQiES3cE9AW04cGazpvLGASTuSYnpR74HAOZ/x6FMxX38MnGsqthvRwWJj1K1UxhY5Tn42iaQAtLoucL/y/tIqzWh7ookc75pyhOp9buuT1NgGEbuXo95PhQXmObLyiE43y53shNdClzfGUQfXswzt5x6/sg250AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojHiFc3doZizGwN1NTZGBbZq0acbQ0vpJZJoUTFPA28=;
 b=vIQ1L4p4xJWCBEyKJkK+/0cQrsl7VIoqdmsq9VUX+22O/JncmWv7Aln6xGtGIdBKN3xG0X/LG6ME+sE7BKVdgOCF5UWtbJyrkui2A/6td+A+2K/HA2TSNXh4D9d/YQXp9nrCRaEaSfIvctCgzeO+jEeXd7zZ/uqRaTJ4ZGnn7gE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6291.namprd17.prod.outlook.com (2603:10b6:610:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:52:22 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:52:22 +0000
Date: Fri, 19 Apr 2024 12:52:18 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 07/12] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <ZiKhQt7kUWPrtFnK@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-8-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-8-fan.ni@samsung.com>
X-ClientProxiedBy: PH7PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:510:325::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: be95999e-8993-4e37-1c78-08dc6091152d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCy6HQrm7lbALAH2zMWovXucKQJclEDheThR5B1nmr0zqQ3QXkin5H7skS9I?=
 =?us-ascii?Q?aOPSCRvF8xRAzgOLwsVdZM1Yhj4JIvTsfEFFu/H4KHxpKlbu71Ch0rpUzERQ?=
 =?us-ascii?Q?eFlmq55iau6eh6PJ+9Q2AdPDeZrPKU0bvW17LByC9ZGUIIhM9o9mGiqdfByn?=
 =?us-ascii?Q?zRWWsZ4uwL/3i0mOz9gv9w+Ym0FEsyjzNmtjijf3yBH8DUmlKCx3JgPGBWdN?=
 =?us-ascii?Q?dy/DkkKsseJZtOdPIOvCZ3lGrcmGnTLcv4DYqsG61C57FOeDtC6HfLUZf4Gc?=
 =?us-ascii?Q?Qb6ahRyA40RbevyP6I/quDJuWLJsbk98QrXcBfiQk1sQanTRK4hoCkU5MHOJ?=
 =?us-ascii?Q?Jrn6r7DM5GXKsEsWOmT0sa3e83e5yTeX5/BnoGT2ypNmSK+N/IUjjql0uBFi?=
 =?us-ascii?Q?eRv4FFj2+rRo7kKJFP34ukp+NK38SzHcD09EM8oUmwH9/xf9w3pAI3WatwRF?=
 =?us-ascii?Q?tyEqBW7iTmhEhUtcbMIYrKnLrcW0/eJrXTzI0knQbftaITIi8icSyu9VM0oJ?=
 =?us-ascii?Q?Rg0ALvTeAqZhCHTIquS1RLThfP1piuObYZvrYwdPO/JEjTeq8Jceh1inS6kv?=
 =?us-ascii?Q?0xCQIwuTW5svJBT03HJBYV7gIUtHxzY/j+HgsTnF7xRkj1DE+R46EFKZNAsG?=
 =?us-ascii?Q?EiZWXndSBTE+qjgQmxbjaBFmvoX7owt2O0RZoUxCo9DGtUn8QK0jvyQ9bmqU?=
 =?us-ascii?Q?NBYt6FbhnDSurhGpAvv3RaQDLR2g2RNHcKjq86nvlmWFNO8bCmUrl+NV9kLX?=
 =?us-ascii?Q?13JD7a6z787w6BhJ1TaXaGoH96ByZXn4qreKKLGyEgU792ZPE8cxM+cGMnII?=
 =?us-ascii?Q?KSch5sVxxF75cANlgtkXKATkyJ1ZWsDwIFs71btf7HAtCMEh4EGs5xPvhAkD?=
 =?us-ascii?Q?mbaRnAZt1w/lbTLfEm9u1wa+xX88b16V/HlvXm09GGXFKvA7QTKwIXB7KE+o?=
 =?us-ascii?Q?MVXsD3sJayNFhpmZ+huNsbmZ+HHkp4WkZ+iiEui5FOoem8eZ+TDJAZ6TXAKU?=
 =?us-ascii?Q?orqgs6Gu29xlb1YfsZY6rhQTtPksLWgpw6A6GL9yKVGufydxWkPj3Jt5XE0U?=
 =?us-ascii?Q?ojVA3sGtJc2mkEq53GAwY1F02jYcYpUAEXL7uPpevZF9lcckXLRG47kNi6JR?=
 =?us-ascii?Q?vRdweU3l/DWXlG0zh8vizUTizFeUfq8uom0TCyRYk2/j6N2/jkvg33smAnWj?=
 =?us-ascii?Q?7n877SU6gdQYWSChik5kRYR+bYjTHFTLIFdn4tF1b/BnMEmh3mhER1B41Ewp?=
 =?us-ascii?Q?5iuNuTr2ouZ6F5pNrCuvZfW73gPndrEDngo2NUUmBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3cjf9eS1kL/pxwav4AL60u6bZG3B98geq5bHs+lKXFPB+SfgK184CogFPr1?=
 =?us-ascii?Q?ryuNrbXKd+WmGWHG4/6GU32RYGNHwOVukCTcEQXmUoIYLKH0Wy+a8N1OgnKb?=
 =?us-ascii?Q?8wL1ZBhd6nbEc/xq0+j/i4s6XVh82EwSXonFsBXyDQ2VFo6V9m0yQ5ESJpVY?=
 =?us-ascii?Q?2U/5FMY847cXB1DBg9Ri3RO6ZcIh3PPAc2dmn6WdwoFa8r21u8muSK9cTcmu?=
 =?us-ascii?Q?EoEf6Zv8M6xlyRAhiNFoGCbqgwTxgnZmgQ9lYagDNUWpN1/F0Y2W4Ru1Lxo+?=
 =?us-ascii?Q?1ZvzqX7yfbiXF3ujQUDUmyJOQ+topDEquwseOBanaD/hWIOlPl7KFAyaYlcu?=
 =?us-ascii?Q?ZFFt3WC+Fez5zW0lVaSn0mWsTa5+oZlIongAC936FFEPalgXZnAk63wRvKw3?=
 =?us-ascii?Q?YvArHyJ7rO/hce59GgT2nyj4my2JApRbStFgOiHfjsiyIq9D0u5/NQQ0vjIE?=
 =?us-ascii?Q?FHqF2z+OYw+JHK31KbnbypPOH54WS4/dVZ6xMA9yryq0ndIflfd51p0DhoJu?=
 =?us-ascii?Q?InMch5c3GKzBekguApv9Sbx6Jz0tJ/B9axFOixwPGlHxVYGOvKfbLfEPxcXB?=
 =?us-ascii?Q?ZFTKXrziTsJIX7SIQC19pT/+HGqtowHyLZnbVWcgr7d4X261aqGcRowx4STl?=
 =?us-ascii?Q?2eRbFpLWSxSfH9jwqavejoaSV9FjZnpJpDzsjxktXgsO2R1Iw6rWgTX71F3Y?=
 =?us-ascii?Q?5Tn+HAgSrZsxtD/bIXNbFuE0ZnKM65X8pLQ/3WdBF0wX5+FwyFddmZn6LXah?=
 =?us-ascii?Q?96zwjNDGbTv6NPEVJdstXM95CQ1qPwEbZnfIHFnqeKTkz/+KvLXAXHRgcTNh?=
 =?us-ascii?Q?jXGmIz5Lhq9UnkVj3snDB8tDeGNfBsVZggcmnofCbL8LH4pG6/aSQkeiJUUX?=
 =?us-ascii?Q?lqeqdgI2ah68RV4F1TZSRg4Sr+04yZT8S3oHWZyL09BsSX3CXqKiIrxJZbDd?=
 =?us-ascii?Q?RvWv2QHhrQn7JC5LzFrNvKa/cg/q/lCTUWktupVQ8BhjqbFZI6bB4PsR8agx?=
 =?us-ascii?Q?3kJxMRFiU18dFKEfZx7mtabup2nTjXzm3egxQQtyt9OV+2/zzo3bAB5ubN+p?=
 =?us-ascii?Q?otej6zZ4Xb8m6FM566thJ2rlI4WirfTYjofo/ulGo9XGBO1k/VE7PvzOq9hV?=
 =?us-ascii?Q?QM6RxDl1W78JmBTBheiPxLBiKm3moLFyRGNwByYvvRJOja1f1rKNAXDcR4jF?=
 =?us-ascii?Q?u6Df18QboJYEIzhLK0+JooAj+MP+4Hx7kHjjEHXwN+qcsbh4O5TZgmCmfUXm?=
 =?us-ascii?Q?01npEdmG+bdlxyloPwikTgjC0syW1i9hsB8bKSB4IH30nWXXuOPe3Z62RUS2?=
 =?us-ascii?Q?nfiUYSjx6hXK7Ly6siuzw4ZGi6Qjy4Jhj0v+gxnArLF6XQVcDS30bebQ2dFE?=
 =?us-ascii?Q?3C2iHbZpY/imspshDoSVhf58rAeHJk6oNEOmQfR+MaxfI6M+7SDdM3PGEuPy?=
 =?us-ascii?Q?TalVYe0f2vkLgjOdeA7RspSdG95KYElFmnpPrNMpO3pDrw0U0V8gX2MIQZ1a?=
 =?us-ascii?Q?GU99+eLs/18aPdMnKsouHYuq0koWCs3sp8F/+aw5bSG/Tgd6JcT0mxNcgEDW?=
 =?us-ascii?Q?8/o8zCaZgx1tY5OtmzmJEtxbYlixqvHnM0AVfPpz20h8u7o8Uk0WMqW1m1en?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be95999e-8993-4e37-1c78-08dc6091152d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:52:22.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/bF/t1CtEUZ8HkCvlPtz/vzqQJUs+4Eqd4XoZOxd/gSbF1Jhy8REP6+8gqBVQrI9c38BaHzmRNXCVcHuT1QSdDGBCCQTehuYoj3yMEHZrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6291

On Thu, Apr 18, 2024 at 04:10:58PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and implement get DC extent list mailbox command per
> CXL.spec.3.1:.8.2.9.9.9.2.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h | 22 +++++++++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>
