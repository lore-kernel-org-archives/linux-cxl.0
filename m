Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FED382281
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379544; cv=fail; b=P6B4+YI4XJkmcGZSniR5iv0LS8Kn+W8MxrCXFr+vRveWkbdSVmC58gEsRl5NMmlBeq7i4gVpp3GF5rl9FRL8gdvnJ4UR2fYGMVnff0c6CEGPVGPsUGUEU+J+pE4nx582I+6qQI/W4WaU/rHjJtxQlb0M9Y5PCAZDUzQPiKu4ihU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379544; c=relaxed/simple;
	bh=hsiyVMm8qsxVikPS6ABD9juAFP+XJ1K/xcmUDAk8eeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pq7A19cxgRdUJ6UogxNava23K9U8LepY8YpzAZObekqy/suSpbZgRbXwquwmmiKwP4eaa7UaS0Y3lZL7gkpYqw2R9Aq13v/R6D9ETH6r+fPKbz1U7/y9gABlaQKmWX8o4nOuRJ+euoYo2WLTzopbqRKCLNrqixegFd1d/WbvrUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tf1LIvzr; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tf1LIvzr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyisS8FzzJ3Hvy9CiTvT58upgeevVXReJjHRapi9Hth3cCMvUk4KzDr3MvxcN9io/LxVjXTi44bAwgC+KrVavgj97qHg+9o1AydXowRXDZPp/yDejfMwykjL/Z4yy23o4RkmtFIzrwMwhWuHOa+GDFCy7Cx8Splmj96i4XPa3UYCsauILUfgkKtZxGmdaIaRkNdohyqjPdB+4uyP+nUlims9u1OXHm7iFWBipb9RoGqNeGW+xPIUl2Ei2Puj29FCOEWYBCdGpXvmYyXKpiTPyekXytmYGWo1Y8ob52GPD9ZwqSvwgj7Tup198PlV+gix/2pg7tUqmTARLt2mNsBbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB9aTinBoOSsM2lC6UfYdczAdErsZBseexz4cH7QWaU=;
 b=iSDMhyIiQrujbMEn7Jj4kLeZo8BeJ87oO2vPTfwWDx7X4Z1WA+vs88LvULqReDnnboWCFsIgSaySo5EAinogvFTgG3uM1RRaSwoVuwDS1H5qZe4R7+AucskGuw6p+wCnnf+9eZ8isowh0vlTqlSJ4106u48TbTqhrztmllQ4OL+sqH0q8IIxfdKG4ZejvsVnlGIzsFlVKAcYtBKYavaX9duLt4vSMZSyBbzAkgbsDjwxTwMWtjRwlN7Q/wf+nYpIccLGMwRHpR8YLtSVvz5zQENbZCef+0huzxNpc3iJ5Yfl7kKjT9laAASVskPz0QCAbRUur6DVgwynkpLbCZRMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KB9aTinBoOSsM2lC6UfYdczAdErsZBseexz4cH7QWaU=;
 b=tf1LIvzrH8jXXvPM+5nTsITEsQL7++MslnIgXk9K2eyp6UVipYjKQDegsPCXwzn0jrYdsvbTF6h/7ZT+x8D3ufJGYRnbdkhWK1Cxg9I3FDrlrhbrsmZopeA9217rVsozM8w/AYmCJlnd8s3eLAMb3uCrwec2bTCEzeHAuMuRo9/IWip1rwmO4W2uAqm5sQqJQwIy9yyKWMsIhsocLdZygFz7rz+pGV0dSv8JqEtAI1OGgVoOej/K6zJivQ49BR4dfhacCpFhFPvvehqIYFULCgcYglGA7rf3COLgsdtVivnDYx0pljCBxlCntZpVCqeO5TRnRCjh2OMUYlMFU5D3mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 09:25:39 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 09:25:39 +0000
Date: Thu, 25 Jun 2026 17:25:34 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: sashiko-bot@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 1/2] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <ajzz42D-4FYXfrNh@MWDK4CY14F>
References: <20260623091019.33417-1-icheng@nvidia.com>
 <20260623091019.33417-2-icheng@nvidia.com>
 <20260623093738.6B2C11F000E9@smtp.kernel.org>
 <6a3ae4c17f641_3c9f100b7@djbw-dev.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3ae4c17f641_3c9f100b7@djbw-dev.notmuch>
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b163260-f986-4d4d-1ae0-08ded29bb87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|5023799004|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	24jGB2FUS3edL7MWkWodxZ9icbtW9vLy1aA3v6znH5jx1OSMOtDqHf+QHv6bQIsW80m6RuR4AkX5fYKCfiqdEZDFPR5P6NQLOPjAYIKNX7WcsRkkgOd+arRIXgWTGvLzK9jFjjyz5ps5ardA1hg2EXZbbJa3kKBFNqokrKwcigCtsqJQyUBAszw4R1GP4XO1JX84kj0dQp98Ah/JudIKaLAEYkRQQYsKABKf5g0lIvf2eBBvVSp30+gekR5B3osg6liNmNz5fJ81ol+AyXl6nMR3zPm/lfr2MNTDtTv+F+kTx0fS3nIfKTCPnLXcdC7TyeVzmJjLkw+ow8O4q/0dAe2DY8kdxBZ25IaAv+ZRAPvi0wp2w0unSaptMggkKZNiJ8mtaO8x6tMumEKbJq0Ihf55C1CtXHAPcW/kdMA4suKJ0Oy0FcN4SqTougLMs0qNWn+qfEnwyZDeAHQMAdRfBE7pDBAhcS9jj1/ZjGptF90FR0OHsgXrS/HwBVXrH0Sq+QG6UP0KZBzUeUrklO4pCp1LkW8fk65vbce8HLxQRnGyTNahQkpX7eX/za7Q8LKc70Z1dcsrtPxQ3+d0kgINmDK1adyFdu/jdk/xDyw6QxuYKsd2DHOMNHulWNxGoAiIBPgVRKZvo5XMD6tDmksGlQszCC9h7FpW8YLOVr++Gf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(5023799004)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dBUo5yZst0wmPY8C8ng8gSy0qd0DeZ8BqB2dBlC3fynaLjoLq/qWe5R52ipx?=
 =?us-ascii?Q?Wf8IWEOwQBkZfY+iXfblwpMe3s1IkNDUpyBspqWwUv0T3+TCEdTKASQWNxgO?=
 =?us-ascii?Q?RBNlipQwGQnyQa/25VtYTgmIv7L/ym9IwiTmPXCU/opIpL3TWpV7nmf5HD+w?=
 =?us-ascii?Q?z3yzQOnADGINCbi8Z8B8sRB6Dis+vTa9gzrsn9GOTlP28WdAMWtP4FlZD5II?=
 =?us-ascii?Q?sy1VDjbTWAEw5DK3KgbkWITMB76W2LavVUIaYJwtaA9HCqp9H2R4WugKNyXk?=
 =?us-ascii?Q?l7HVzCW4vQ9vL+8m69IJRkRIUyjMZlnXDwIfcS6bkn+R3+KE0eClEGiJIuZ8?=
 =?us-ascii?Q?JTq2FlvFeyC4AXiKYTt0LCbpvf/7wuSVH+1wC4JwIbNT+4E/qEdKDPUdQR+3?=
 =?us-ascii?Q?4ZJ4qtmtNMzCiOS+h2JkE5uBgmwcJdpT+tiU9oVkDsAdlUIxNLfGUeflvBK6?=
 =?us-ascii?Q?tggwtmlhCa9lytWtFRQjksHzekREP2VYoR++V5q6ftDpzIZnYb10JB1WVnhE?=
 =?us-ascii?Q?4xE/GIf1ZaT0l4S6WQkNJFwnWdKDjBJq+Grf80uooDV+Wc4pCSSFiStuvaqk?=
 =?us-ascii?Q?PNiW/fAsoFcSwleNgcKlEOvKx/mZKQ33gOgqTjRausg8p5JzbAd5K2qkFxvX?=
 =?us-ascii?Q?uCN4UDvHv6GG2SvkjtKE5mBhgJ08RsQNQBkgxM4FMQc7Pd85irLHHo/0ul9I?=
 =?us-ascii?Q?77k7dMtwkPAXlaCHzxdiHKY8w7AbogpOXh7yaLW32vDHb7GXUuII1Yr8YjtJ?=
 =?us-ascii?Q?LYTLc++3QC3YEi50ajlMJvHRfeuzOndYrAxMQ8kIXgwv7YvjUIsSoamKlacJ?=
 =?us-ascii?Q?SB9XgYDF0XmHC2rnqKOT/HiwxOn98VQiK8r6wGlaI5rzZR3vL63IrRbCXjF4?=
 =?us-ascii?Q?uOUIbKbJOQ+2dxXq5JSHZtygU6GZKeYjibfBqjjX8bPfRqMV8SwjsAmfho77?=
 =?us-ascii?Q?KZaiWNdjpciJaPZza4aeBferZbPnL8AH4suB4fxZ5H2/bEZmvXXmV5oem1C/?=
 =?us-ascii?Q?2HrShDJVqN8MIWputpyAzicNHW6MG9cI5gnj+8RMajagdYbtE98xMoU6C/rb?=
 =?us-ascii?Q?7Afixg1TRWsnT+f1yf9tTf0L31e1LXV2cnIjfyLn7rY4ro9RH/KrYKNNbGDV?=
 =?us-ascii?Q?TdyEBvGcaZjENfwjrr+FcAh7gKgV6pOsKteSkYAbFCtqYvdtANsr8YMpf+hJ?=
 =?us-ascii?Q?/+46yagxavF57zyZyKVWRmHw2BWW4G5rhbNlbgJUzzfrgZOsr1AiraO2BkOU?=
 =?us-ascii?Q?rP0gX1zmVm6u6HpKL7myRVjO97LP/PseM1Lwgw7RjgJt1r0CTMo+152FBpDz?=
 =?us-ascii?Q?9lYQqJqr4pq9esYmFg/bzvf/KtA2+E2acUbTfGkE2oWBl0a0+ftNLJ2KxyeU?=
 =?us-ascii?Q?3Ug9JJ/2GHjbdk1pJNAXwNwhWulWJdBVmdqgep38fl3+Y5wswjV3KGErZO1J?=
 =?us-ascii?Q?jTe/4lkNkwfhdl9Up1BLsQNVgpEX/VMdKVFfYYhDLxvF0tFxlK92M9q78PKr?=
 =?us-ascii?Q?dpB3pBDRHbnqtrB+G5mZicXiFe2hn3mTOi31oMbfQSyVXpMnA0xolUWSD9Ki?=
 =?us-ascii?Q?1Fmyp+fwIYtnygE+Ycuh8NIK3Dbt/Mcw+VrHdvMMJL7ID5c5DrwcMouUSAIw?=
 =?us-ascii?Q?3jBkU/+VE0P7AeGbi3JISn//U6Yj9VMhzpnE7qW/iXSqcmWJJQfpNW5vM8XP?=
 =?us-ascii?Q?UuhCCCncMTcjUUkPWStLG29hlRm+4/ZKMKrdvh18RwmpiQaJEOxmhx/kX5pO?=
 =?us-ascii?Q?8JGVlNAG9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b163260-f986-4d4d-1ae0-08ded29bb87c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:25:39.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrWFcdJXAOELRV3VYlmcd4frSmdPAozIibLHrU1szcu+kR88HiKh7R5apKjgrMKxhXTd5+vKYmKzDtjF3mstdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

On Tue, Jun 23, 2026 at 12:55:45PM +0800, Dan Williams (nvidia) wrote:
> sashiko-bot@ wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] cxl_dpa_free() incorrectly bypasses teardown for zero-sized decoders, permanently locking hdm_end and breaking the LIFO DPA teardown sequence.
> > 
> > Pre-existing issues:
> > - [High] Pre-existing bug in cxl_get_poison_unmapped: prematurely breaking out of the partition loop skips poison scanning for unmapped partitions.
> > --
> > 
> > commit 66fbe5db5d8f3f27534b45af8c4ef71b88ab7f3e
> > Author: Richard Cheng <icheng@nvidia.com>
> > 
> > cxl/hdm: Allow zero sized HDM decoders
> > 
> > Treat empty decoders as first class instead of special casing them, back
> > them with a kmalloc'd resource, since the resource tree can't represent
> > an empty range, and keep the skip and hdm_end accounting intact. Guard
> > the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> > poison queries.
> > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 0c80b76a5f9b4..ccbab2e21f060 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > [ ... ]
> > > @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> > >  	struct device *dev = &cxled->cxld.dev;
> > >  
> > >  	guard(rwsem_write)(&cxl_rwsem.dpa);
> > > -	if (!cxled->dpa_res)
> > > +	if (cxled_empty(cxled))
> > >  		return 0;
> > 
> > [Severity: High]
> > Does this early return prevent decrementing port->hdm_end for zero-sized
> > decoders?
> > 
> > If an unlocked zero-sized decoder is freed by userspace (for example, by
> > writing 0 to dpa_size in sysfs), cxled_empty() returns true because
> > resource_size(dpa_res) is 0. The function then returns 0 early, skipping
> > devm_cxl_dpa_release().
> > 
> > Because hdm_end is decremented only inside __cxl_dpa_release(), bypassing it
> > leaves port->hdm_end permanently elevated. Would subsequent attempts to free
> > lower-indexed decoders fail the cxled->cxld.id != port->hdm_end check with
> > -EBUSY, preventing further dynamic DPA reconfiguration?
> 
> This is blocked by the fact that there is no path to clear
> CXL_DECODER_F_ENABLE due to empty decoders not participating in any
> region. The permanent nature of empty decoders is ok for now.
> 
> Might be worth a comment to note that emtpy decoders are not manageable
> by userspace.
> 
> > >  	if (cxled->cxld.region) {
> > >  		dev_dbg(dev, "decoder assigned to: %s\n",
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index e50dc716d4e82..eeecb588821a4 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > [ ... ]
> > > @@ -2953,9 +2960,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
> > >  	};
> > >  
> > >  	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> > > -	if (rc == 1)
> > > +	if (rc == 1) {
> > > +		/*
> > > +		 * No decoder with a sized DPA reservation was walked
> > > +		 * (every committed decoder is zero-size): scan all
> > > +		 * partitions in full.
> > > +		 */
> > > +		if (ctx.part < 0)
> > > +			ctx.part = 0;
> > >  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
> > >  					     &ctx);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does cxl_get_poison_unmapped() prematurely
> > break out of its partition loop when encountering a fully mapped partition?
> > 
> > Looking at cxl_get_poison_unmapped() in drivers/cxl/core/region.c:
> > 
> > for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
> >         ...
> >         length = res->end - offset + 1;
> >         if (!length)
> >                 break;
> >         rc = cxl_mem_get_poison(...);
> > 
> > If it processes a partition that is fully mapped, length becomes 0, and the
> > break statement completely terminates the outer loop over the remaining
> > partitions instead of moving to the next one. Should this be a continue
> > instead of a break so that poison in subsequent unmapped partitions isn't
> > silently ignored?
> 
> This looks accurate. On entry for a fully mapped partition ctx->part
> will be initialized from the decoder for that partition. If there are
> more unmapped partitions they will be skipped.

I see, thanks for pointing this out,
I'll send another patch to fix this one.

--Richard
