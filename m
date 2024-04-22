Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2125.outbound.protection.outlook.com [40.107.101.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE41534E7
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800553; cv=fail; b=d3kQGe1BLqATv6zFtRwxj/wSLofR8YMbHFpXk4Nh7HaF5WRMY1K0BQG5LIFrxTg0gF1MYKiCH1wkjoPyvVXKKVVsI4YZgfTC054KSlpBqXg2eBwcNp+45l/o3uhl7KRBC9lVWf/nOUfd5au/J4y11e6jBVflOzaSIu5OF4WYsM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800553; c=relaxed/simple;
	bh=zqn4YVQ6q5wtoAX2BXkqpp3sjF93ve6te9FlPuIy7JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fiGhUpBVixIXzgEspR5/vJGdbQtsnuqp+Gdp6hb+bRJdoQPg/42VYIOAOKMJueKUL1KyMFzWESXmBZMw1IY9ui8lKVbVPzEIjM4Gew66EQxnZUzpt7d08DPRrrAbc7me4cdVHRBDr/dphk3p8TBsEJzTz2y5Vjoa/OAL4LqFXjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=gE2Uy3BZ; arc=fail smtp.client-ip=40.107.101.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="gE2Uy3BZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO/NQCZ8pYsYCa+Q2JBOB5Raj2gVGZ8THaEnjSAocQFeNDk9amNPeogtj77sLcI091azNMYoi9TcPqdBXmFx2rNmM6dmlYkHlEgw2kwbBRD81IGIqc0wMdKCYbOvm9Bb96d6NZ8+p0ca7dL/jjwcThZbznePFCyJh14GfLNc/EHuuYEh8IYMXBcwVGNf1PmKdvRes5yMYGEQ7Ih35DIKoXBTEah3icXK/rvqwRTan6arX+/t61OBF9t7U967l6Vocnw5jHtxB7s827TH6a/Kry2MkvKzjJ7ShjfG4tkc/3Tom6gzZ4Ii0p3NrbK8syO9dY9dXE3kt3fBf8mnrSh/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riC2sX5TvCgAs1jkHv8tugHYcufokv7UMZM8+qMbncc=;
 b=BbEc9WHwxL7bxuEABYfvXQ+sdeGYsl6Syj+8dxi9AJyqSeyUEu3DJ43B2fwkvxJH1xXyS+BttP0M4nq4KOraFhIMM9vfiqvx4NlMQnt04+MXnF5VWpojQaWhAb25eMLHbjCIxUC1caW/WPeUF2JX7eKdIqG0ZpRjHCAe3rL3MeU0IvC9NeZCzOtena9kWYDTUfhNeN4BgpDiIh7UC0Inm6z+0ssVUziQ6fFZOFEUMUyK9XVHCcemB/x1DS/dE6RRAhYO3+KHz8UV2UUfNjwnSstv8pgGwsEeJkn4cgfuirWTcqdowh6XHTbpb2/7J8ytzqzcE9jS3uVmGyHLKljCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riC2sX5TvCgAs1jkHv8tugHYcufokv7UMZM8+qMbncc=;
 b=gE2Uy3BZN069u5kCxnYaxAm86iCdjTrNDOkj2Ke2qgfpMCL3Nv703A2uMWwrhskCqr1iA0xBlx96WyjXvI+eoB8izOF0Gl3FegU1mKzrS3iRZoN0Bs3Y2M/1bfNgr0j8dXfN0Jlyv5Jg3kpMnxdX/OqmL9MBPfeDTBoiYlXdmJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH7PR17MB6858.namprd17.prod.outlook.com (2603:10b6:510:24d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:42:29 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:42:29 +0000
Date: Mon, 22 Apr 2024 11:42:25 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZiaFYUB6FC9NR7W4@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
 <ZiK7QtVxutwDys4K@debian>
 <ZiQnIkYjY3ngRLAi@memverge.com>
 <20240422130448.000057ec@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422130448.000057ec@huawei.com>
X-ClientProxiedBy: PH0PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:510:f::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH7PR17MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1937aa50-366f-4e93-3582-08dc62e2d13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDojiZU/zCU4hvqr7UHecqAgcsnAtBUenvWkvfgX1skfr9Ah2VLEqU3vsJwN?=
 =?us-ascii?Q?BQg9DA/Nk1ulE1ceTIZdR0DmL29GCFWqOtV1/7sx7Pz0e3ppxIAJeJZZoQx5?=
 =?us-ascii?Q?xSjHrl6bhQ3rFztxHC7p8xfrtvDHhmqWWqRmIPe9BkjMdpenOkfh/sEVZAup?=
 =?us-ascii?Q?/JNH7ARc1pjXO3wzr6XMTHDN1gkHwRgO6PzZnkZTmawuxxmSUHTzxGvS+q5b?=
 =?us-ascii?Q?Q1wMHkE0G3YwzXNJUvQV6TnzKztY4FUNevFZuSE0xaHC0d7BNpgH+SpyEz8t?=
 =?us-ascii?Q?nvgYZobOon2S8QqRMtGkDCy+QxTaQDUqk4Z92+XHoBhbsc2coGGuJIJDbmyW?=
 =?us-ascii?Q?1Edp6bXQpACJrjtSv7dUGopr5wwnfj9D8pfYThAg11JIpjx39ntnAhXSDMvz?=
 =?us-ascii?Q?V3eGF4uREs21tVwt4JauAIMPlMOpNIrjtaI5Cja+ZnywMGCmo+eYRevGk8y6?=
 =?us-ascii?Q?/+62PFxaeu67blUlYb8fuDY6C6ZnZHxq4ziugY4N6Ad6vvy+UaT6kC9/WC+h?=
 =?us-ascii?Q?VMXXSilxPzfvvsyZymqZ0Ez7pebPR6+zj/ddwi++dMxFQp5Ob05P00bx+FxF?=
 =?us-ascii?Q?N0DH7hLaeJkuxm6zUVo6vF+/YVBFrYndKQPmlH6ZN1NDg0CBhraNMl64phPF?=
 =?us-ascii?Q?9HQTOjjo6F66U0gXLYLoyS95+SDv5XiGS0Cn2YjMhwcQ2gtiVEWShg35vZwf?=
 =?us-ascii?Q?FLjDWSws4BourNxwSJKTCAPaUEDpknlG6oLuDnQjrb6YKHM/0SVxhbjkGHwW?=
 =?us-ascii?Q?keIQo3FvCtANDItEWYIa33BTCouVIsWSvQgGpQ0a9zczeUCC9Q5GR/lt0rJ7?=
 =?us-ascii?Q?lCfcByJ/OGM3zAwoaHelld3lOyy+qpdc0aPdbZNEmwO7LgDc7YV08iQAmh65?=
 =?us-ascii?Q?NUmct33/vlCVsIWuKgHMexIQoAU8fF5BV+l1+dyMAjFqrw/X0QE5urRTk2yr?=
 =?us-ascii?Q?dtrnXOtJJEJuGsfDgd2TZADkchSQXTDfwEjVOsdeT5MZ+YZSMizq/9/SlFx8?=
 =?us-ascii?Q?RsLzr4NKsdzHAEe6ytDaJ1u+GDt0DGoaLKgNAuyxjCK08sWCVs0JSjAjaAxQ?=
 =?us-ascii?Q?bj87tCdCeX3wF14ZJVB2a1XoK9R2yonakhDS0vQoJ2hyUHThgWVc25/ZGbI1?=
 =?us-ascii?Q?vRY8MWGkEyT+fIlIWzOWNpfIp0vun4nsHqNOnW3/nMBgnzRkFFmv7gKpUZTx?=
 =?us-ascii?Q?d4AWf0wqLG3HYEkyx092atezYQa+wsnTcLVZsnuZ7GQCbJ1fdb2OvPzii4C2?=
 =?us-ascii?Q?EigRyKEnYvIAYxFObqDq+7q5Q67uiFO5hIMTkNjz/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KsRryjeXEywDfTBozx2vM2JWX3/f2Z32jPlW/VG7nMrJyPavuqXpAhw9lG98?=
 =?us-ascii?Q?ClS3E7zwCkeDxIjE+yI/h4FL6HxR8wkDRu729wKqizQd12I75mjY9REZdh8P?=
 =?us-ascii?Q?G+ZHkxAR7qaewjWpSzSOJe+jhf+xEUVJkikcS+fPeRZ4nfxQXBGDYnXXh09c?=
 =?us-ascii?Q?i9smjSmNcaHWjv4Jn0WhWnn0/SOA8VA+N/+YSfBWmui6kwdFzVP0c65I1VqX?=
 =?us-ascii?Q?5q2AbeJ9tE0MXv57rkJge00LitlBY5h93VieuHA08n+SZ5p2YINIt2AyjQAq?=
 =?us-ascii?Q?ZMVaVkVB38RHlgzHdXZ8Z55ivL1KpSK1jeAnOSTD4gdz47YnXCeVRFkbXem5?=
 =?us-ascii?Q?XtILQ5GbswYRaS7/VKYXJSslz7oyjxmBC1DK84QH7GlJ4UWVoYWcMZEnGZGX?=
 =?us-ascii?Q?ZJ2NbK3g90KdWoA0YJASmMVFt8BM3fU35ISMSQ7LLhrsHyUIiBAcdFixc2n0?=
 =?us-ascii?Q?RD0UJnSUPiITgKIlIcbdEAC4bMZiZE2GkkYM9al6x6K5TZ1uEcZYsmu8xsnY?=
 =?us-ascii?Q?fMoSUEjM27yxYhSFeD2JBUwAuYzhPfmaxICCV9Aw7jT1e8l3QhnjdAwbrSpN?=
 =?us-ascii?Q?1s3lEP9PKgGRZ+r5bEoq4+UduL5CXGp9S6Uj+4wdzMW7yxJUiWFHqckWyY0x?=
 =?us-ascii?Q?eVBenvwOZVMSvTK3nPIz31pLSOZA3T7UtK1uN6JTCu1NFaFRLYf5sPT/nqNR?=
 =?us-ascii?Q?cdx551WWYm/BWDV/qiFqiCt5QKxUeQuOmVrxQTskWHZANf1vmk1KPqXVVtuG?=
 =?us-ascii?Q?tdg6OfUbr/p2v1Tzhk15TPKXllKTFsDy6USSeAc316GfrcOEC67ZVknydR4T?=
 =?us-ascii?Q?/MWJRzr2nZY4SjeSFK9kKgGzoMOxdoloZVL7ZtGyEmhQ2bNDR7c7Wb1rmJsm?=
 =?us-ascii?Q?4ldTt3w/QhsIS5wxQ4FAdBZFanwOy1AiokHsHwvI8C1TL9QJrYvNCeMCjQOh?=
 =?us-ascii?Q?WcrPHnd4kLrKOeT6zWZ0GeL8lwB63+X+9ucnFj5IW7iThIKCU87xo29+lAag?=
 =?us-ascii?Q?4sUIhmrybaN04Q/ccsXCE5nj/28LFSDjxhyO1/vy+/WvmdCtdWCHRDnIvqWS?=
 =?us-ascii?Q?aN11YA4tNuAXYUEWMKCIule0w0CjjeMB+i8M2AzT656XufPwhkfX1NH2Y+S8?=
 =?us-ascii?Q?6wJxio8nWtcX+LXj+rvxkK350KCBwQ502rVfOwIrfV3TAhQigZfCDdpcJDvs?=
 =?us-ascii?Q?qLvq8AnjeWpaLqxjam4LMr20iufZErToPIoXM/6t9U7ETyFjm010D+3XZs6T?=
 =?us-ascii?Q?sMQfCkE/8+YmLlGs/rE0OpBHiOdAYeeR/p0YKL0FSMCHGZv23wezj3mtE3lq?=
 =?us-ascii?Q?X59DhEHu69FrB/QSjDm1tcKGt+hUxjNJ9hwE7L+/RQsBoH3hRNw6sB5wAM9L?=
 =?us-ascii?Q?ak3XXk+S1Mt0QZeTJ3Jdj3v2lgYMFcqqmPzLluE2iOZCgZF5HlwyTFALypDk?=
 =?us-ascii?Q?5L3CxB47yE7CpRMWCyjxoYxphpnVE/VfMAVGPmAO3wW7AKwRmyCK3GMX4wi6?=
 =?us-ascii?Q?+Vb3owqJpE3AxX4aq9Rxfxp3ROf57UgYzYTDQ+Iw4Kt3HNHEnHzMtEKnerCR?=
 =?us-ascii?Q?pxf9MCITjlXgrRC2LZhftw1u/xdWXApMIcId3+fVteLGHG3N2lk6XV2JL4Fz?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1937aa50-366f-4e93-3582-08dc62e2d13f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:42:29.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/B5mp/xXIBQLH6hY7ONVNOif8yN0tsXER/ZT9jwbfqV5Nq5EmlU2b2etxQkZk62CpHsNcbKMVeRhmsX7joK3stIs+dF0LiyfdP6Mvml40E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6858

On Mon, Apr 22, 2024 at 01:04:48PM +0100, Jonathan Cameron wrote:
> On Sat, 20 Apr 2024 16:35:46 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Fri, Apr 19, 2024 at 11:43:14AM -0700, fan wrote:
> > > On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:  
> > > > 
> > > > added review to all patches, will hopefully be able to add a Tested-by
> > > > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > > > 
> > > > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > > > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > > > 
> > > > The super-set release will complicate a few things but this doesn't
> > > > look like a blocker on our end, just a change to how we track bits in a
> > > > shared bit/bytemap.
> > > >   
> > > 
> > > Hi Gregory,
> > > Thanks for reviewing the patches so quickly. 
> > > 
> > > No pressure, but look forward to your MHD work. :)
> > > 
> > > Fan  
> > 
> > Starting to get into versioniong hell a bit, since the Niagara work was
> > based off of jonathan's branch and the mhd-dcd work needs some of the
> > extentions from that branch - while this branch is based on master.
> > 
> > Probably we'll need to wait for a new cxl dated branch to try and sus
> > out the pain points before we push an RFC.  I would not want to have
> > conflicting commits for something like this for example:
> > 
> > https://lore.kernel.org/qemu-devel/20230901012914.226527-2-gregory.price@memverge.com/
> > 
> > We get merge conflicts here because this is behind that patch. So
> > pushing up an RFC in this state would be mostly useless to everyone
> 
> Subtle hint noted ;) 
>

Gentle nudge/poke/prod :P

Got your updates, thank you!  We should have something cleaned up today hopefully.

> I'll build a fresh tree - any remaining rebases until QEMU 9.0 should be
> straight forward anyway.   My ideal is that the NUMA GP series lands early
> in 9.1 cycle and this can go in parallel.  I'd really like to
> get this in early if possible so we can start clearing some of the other
> stuff that ended up built on top of it!
> 
> Jonathan
> 
> > 
> > ~Gregory
> 
