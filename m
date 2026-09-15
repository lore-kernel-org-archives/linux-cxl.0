Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687613612E8
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449176; cv=fail; b=TIAWtXYfYsCv6ahiJLacrJc9kSrbZr713oH/R7ArJyu49nA0x6zpd++w4pGcafD87j+37Bzzeme7UDOxjYEB5c2YvFmBDSXRO4t3i4BuGYBqDi8Qb/e50zXT0CEthnO/mLLgfyFW6+ALgW67yXsxcHsIDdGin835/mnmMOOQYXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449176; c=relaxed/simple;
	bh=HGLqX5lWX8rgrqjvCRkFearlVXdglzy4MfNz5TVLv/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KnD619+JacsWw6oNJs749qNesZE6W/C9mpoT0HAjwTct0c/ySJyGOw6H1eiX3oZdgy9NaNhhfsk97uH8hHQ7CBhW7jC91Hiq7G9Q6oSTOR/pBtQlP3sFH5ok5ZnB9baDVxMgE0uVbQM4UrBS8COff4QddLWCUcB0Va6rEQmZ2f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/YuDOKG reason="signature verification failed"; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r/YuDOKG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFOwukoLvTrJWS58SaRxqrZrZRN+0KM52IX8qxnzFg9Q9INnWwbCRWWxN5Ji3FkaKJ+sODaZlZPfc11DTP7CXGXXUBx5gD/FeIftn8ReEvTjZ3aLWw5Ynfw38xpBiHWsZJV8z19t10FV0xoQzSwsi9m8cikl9OdAKutTo9aIy8j79z1brJMNotEfulSiprZHfmkDukVn5Y05eV4yQZOz45ZXeDiX3/TnKjizuZwYkzr9oe2oC3jvdq+I9LS6GStqFFKsKw3eN9+FjmmWLxWzZ2sYaBQ3Sv09mITTCttg2luA/zlMsl+UJ9SVFVcQB4fajxclLeFvsj4TJyGkaZmsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9DDMyn3Esxk8p7hJvv2DsX8GCnjxwy8j4g5mu3EdtU=;
 b=DXbjoi4zvJaEDnGvjWmKv7aR6m3kTwxc8/0NPiEy0WbF0xEgWMLAk6Q4dFNcMr62tJ9nAS+cUywuDWO+B5v4p17hpMak4X/uAjMSxfVtChtW+79LmN0EapOVTaVCMEvSyhSS5Ba1XEeoeRkGWs4P8IQeb5HeJMTpSH5XImNenqp4nZWY42OCH1lTE+LhWf/Z5etxd0ugu0ed1R/aqzLqNshtJrxHZ8Vkn5CmuBmuz9VoB7XUdbHeltpEa2iGXJOqQEbBqGd38FJzit8TQOkdY/SiSpJCDXrYST2savhjNBr/A7CawiNqlUI98IcZ54QFxibuV0rBTzNqH9Z7DkyzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9DDMyn3Esxk8p7hJvv2DsX8GCnjxwy8j4g5mu3EdtU=;
 b=r/YuDOKGulGf6OZSW2HQZlqZsUeTYK4vKQQEOzAkWT17UCblAEjKMxRQntHTCFM+ItyMPdUca5i32p2PIuB64xbyUbTeen0ku80irv5ztPBLY4gO8u1BzrIyY689EWx1O0+JY6aZlra2tpw87iKh2R1rP1yqwkIyek1olZ+bspby+nVjKpRsm6HxrPMwqohfEafC07ivdlJsZLVVsC3tMBGYXAVL0Wx7L08QHQ3kGcJZvrdL/352D9jGwGAtIejMdMuNSwtMeG+hjgPFj0ml8H01TPV+4OCDwjquu5mD0Ic1CgkA+R3TleQ8k/XSUPqelCs+OA+kfzk6B2zCQpbMGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DSVPR12MB213845.namprd12.prod.outlook.com (2603:10b6:8:4ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 05:12:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 05:12:51 +0000
Date: Tue, 15 Sep 2026 13:12:46 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <aqjSLWq9-uFwdhXE@MWDK4CY14F>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
 <20260711201508.082531F000E9@smtp.kernel.org>
 <alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
 <alXqISpyXQVzOlmq@MWDK4CY14F>
 <20260908000455.32884adc@jic23-huawei>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908000455.32884adc@jic23-huawei>
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DSVPR12MB213845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f998ddc-d6ce-45cc-a5b2-08df12e7fd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pltyc1VlR76hnKMhFOwyUvCUez+JSgckKzHAJhn37wi+6o1UIQWgTF4JAh8Q1FJoWoIxWMlQiQxCNOcRnV6EIiAWV5/fMWXwRDQCnB2tnYBQLZUc1b4TaQvT3IveTNy3aoSLmHvlk+a73elqBZ/UzrcSkDzfYFVfU/NiwXZzk13RrSnoCgKXnPj0ELX9IEk41iIs3HVfaMldcCZZHvZpR2I0qr/2zk6QoTm0hHX93Ap6QHIzOehiGQQ3Ycdjsz1TeYlvfks8eFTUQKMoofD/DRetjWYpcmvgKBb4oKAg22quEXD+Y9jtKwKLSUC1wyZYatwnHw1NBNk91+IyttdJaGpldT9A/XXwqjV87ByIibBWm8wb3+HUKCHwI1h3pqkkXTk9mt4uJKj3AndsFle5NuE5fpG9bNvLP6joF23z50epUioBuW5AhaWgzc99CpaNnJEFQcII0xtocoEtCcFPIAfKCTv0/QgVJV6QuJo1p4DySnmRva4y0domyPzC53GtBSjRwlvS30SSNJ02RYJtRyWpOTbKdu8OSwvgmcqtC8ezYVOBh36NAV2p+Mvx/ABjXkyGLegpj0jDEtvfzz36/SrKc8D9j5iUvUU0rq8v/bqA7g5Kvy+sngZxgm279fKFJu+ta63Dgl4F+oxQQRcPlR5J0iczU+5Htn14W5+xvRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?EftjFPQanSPHaTneLo7qR+WFPPocZR4FH9JDELx5OQW51LyiIsbaOlbdhG?=
 =?iso-8859-1?Q?MgZIa9pYpIBDs8CUkcr2FnPiHNoFke9wOUS/9kH0vVcf3bL4i+TEaiT4uk?=
 =?iso-8859-1?Q?EyNZEzNcx59TIHhEFs/ZcQnd6J8JklcFezDBeA94cDZpkORnemxhA5EU1I?=
 =?iso-8859-1?Q?z6Q5TSnYO7u0nwtIP/E0y6l6LXb3Og08M1qone9fwszJQKeuAx2vveruBu?=
 =?iso-8859-1?Q?P1nKygHTbfFsMtptJwq4zEvnCAlpzlrvgIyO71Ba4zDJv9AcrWNJ8x3t/o?=
 =?iso-8859-1?Q?jF2RSoNpHiVZRS5rALztFF8QlAivQO8IGIhGCGS7Gnq5KQHSkndsseH4fe?=
 =?iso-8859-1?Q?Cu/GJlzGkIW5seAvbYRREv9u5cneUyHYmNK4SkvY4U1F++xYv1MY3CXSPw?=
 =?iso-8859-1?Q?ZfpiNFkLtjeR+nCimKQZkn/P3HNbsZygt2cQO3URXiWvLEEWgOToOErPUQ?=
 =?iso-8859-1?Q?bOD4asQKCvC+Q49ImA51wjOE3DMSul4B2hiJbKpYVbFUF+EOauHbMLRBW9?=
 =?iso-8859-1?Q?1kNG+R/Je9hQFVcD+dyaQS2igcJezZDizjinp1EbgZwH+vP2bTNyu+4Vm7?=
 =?iso-8859-1?Q?7bJlOFoeu8lQq6wwaG1pkp3IGmoRP6M71P8HJOCuJqCghCyHqcQoQozsyn?=
 =?iso-8859-1?Q?+GPe29kPUXJPQcA9vkCZuCKs85DIfIgZ4ZTfXhvQKCTNNNGOax7rse37yV?=
 =?iso-8859-1?Q?z5nsYUGPU5zMjmgO11OrDjO5Xsx6gEJVj5XmEJLcE/2cCFvWwCXMXK3Q31?=
 =?iso-8859-1?Q?ljqxSVRZyG21rRAwR3GH3wQ1aUeT/NwBNRBHD9U/pJXYkTW4W2wqSxLNCs?=
 =?iso-8859-1?Q?cJMFHabp7PiCzvw3dL447YxvQla9DCyBIjy6D6QdygH+non7UjQ3XW7WS7?=
 =?iso-8859-1?Q?RNIJ/cad37bh+kQ1yROSufWxIGBX9LartZnYz3q25+y+qzpb9/dxCLuupy?=
 =?iso-8859-1?Q?rkoH0U6ZYXRwpa5wStM2M53N5NF0veMJVnaG0pXYqRG55qv7gh5usOJ2VX?=
 =?iso-8859-1?Q?fWd6GPCuR+WX7Dd3gIUizR1ichcJEUsIAwAktW+tasAdaJJxtxP+ymfkgJ?=
 =?iso-8859-1?Q?TIR7owKb45tY51fsyx1pq8OCB+XDUrzwjwBXiwjdFKRCiS3J9kHabFW4wT?=
 =?iso-8859-1?Q?e+W5ImLvjZ7gkfee27qrrVYe8vnl9NnNvXQv1FpBii/rUDCZ3c73v+ODc+?=
 =?iso-8859-1?Q?49vBbFy0QA96svtLj+2M8XQcpCgwrEJpGdOXm4nE71lVaaJV+JPA9Y4R0I?=
 =?iso-8859-1?Q?v7tClgcsnlapgkVU4UuUXAvn0ORyMexVTH0+JGf6LJHREi6DJwTL+G3BiZ?=
 =?iso-8859-1?Q?ho9l+lrwaWhwejrfCLA5YEhskB4/Gshi+LkkaCeUHI4WhHnzjV3vF+/Zjs?=
 =?iso-8859-1?Q?i5uvfwMeqVtzEKN8n+eUrKZiLfD6gUvvVkkW9Kaxdp+oqqqha8gABGRTx4?=
 =?iso-8859-1?Q?BmisDVxV0AOMa1EDwV7NwY+73KmwYzuwHuk4eaqhN1bSnr9i8an6kCK4Jv?=
 =?iso-8859-1?Q?EYLqWBbx1DglCuRO0PdrskwM/YgyZfWFJfRITX9n3imzicCVzPNMVA+tZJ?=
 =?iso-8859-1?Q?SQpiRRMD7a9XO2tI+of0/HE/WToITVy2/7StVfMomsziTbpPDYMmgyx0+x?=
 =?iso-8859-1?Q?UOodE+QU4/Y8WWqy70lqNWaljxoJ6HOjdMfqQMjUQMgc+OFwmqum5i9sN7?=
 =?iso-8859-1?Q?xH1YLDc6IMP1U5008VV62mfL3Wx13aglVlXEt8p3A6f4oAry/vOhs1pyXO?=
 =?iso-8859-1?Q?rUrf5oMTz5c1ph0c2rRXKUa0Pj4yS3aP3jyVH/eguyiuQq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f998ddc-d6ce-45cc-a5b2-08df12e7fd94
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:12:51.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PkqyF/K5jwy66v/leAyFaAFGQcphq+MusSETqlnK1ctjp+oyca46RWUfpHBRk5+VCD3Ygyv46oJ+IxTT4Cjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB213845

On Tue, Sep 08, 2026 at 12:04:55AM +0800, Jonathan Cameron wrote:
> On Tue, 14 Jul 2026 15:56:18 +0800
> Richard Cheng <icheng@nvidia.com> wrote:
> 
> > On Sat, Jul 11, 2026 at 07:09:47PM +0800, Alison Schofield wrote:
> > > On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:  
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fail to update their `interleave_granularity` software state to the computed value, causing downstream decoders to inherit incorrect granularity and fail validation upon reboot.  
> > > 
> > > Same NO as in v1[1]  and I don't see a way to graciously alert you to this
> > > in the code. Gratuitously updating the field is not the right thing to
> > > do.
> > > 
> > > 
> > > [1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
> > > No. A downstream decoder can't inherit an unecodable value into a failing
> > > check. A >16K granularity only appears below a wide interleave, and
> > > everything below that inherits an equal-or-larger value that an interleaving
> > > decoder couldn't encode. So every descendant is necessarily passthrough and
> > > never validates granularity. There is no path where updating the F_AUTO
> > > value would prevent a failure because the failure cannot happen.
> > >  
> > 
> > Hi Alison,
> > 
> > I'm thinking of 1 scenario where a regression might still happen,
> > independent of whether an interleaving decoder can appear below a >16k
> > passthrough decoder.
> > 
> > The new cxld_set_interleave() behavior writes EIG=0 for every IW=1 decoder,
> > including cases where logical granularity is encodable.
> > 
> > For example,
> > root: IW=2, IG=4k
> > passthrough: IW=1, logical IG=8K
> > downstream: IW=2, IG=8K
> > 
> > During manual setup, the passthrough decoder gets a logical IG of 8K.
> > With your change, committing it writes EIG=0. On rediscovery, that is
> > read back as 256 byte.
> > 
> > The AUTO path accepts the passthrough decoder because it skips the IG
> > comparison for IW=1, but it does not restore.
> > 
> > The downstream decoder will inherits 256 bytes instead of 8K and its 8K config
> > fails validation.
> 
> I was looking back having seen some text on this in v4 that confused me.
> 
> Isn't a failure on this combination a bug anyway (that we should fix)? 
> The downstream decoder shouldn't inherit a value of granularity from a
> pass through decoder (as it's meaningless) it should be getting the
> appropriate values from next level up in the tree (or further if
> there are more passthrough decoders up there).
> 
> Jonathan
>

Hi Jonathan,

I think you're right, one problem I'm not sure about is that whether
a passthrough decoder will stay as is for the whole runtime ?

Since we're assuming its register will be ignored with IW=1, it makes
sense to me if that's the case for the whole runtime.

But if IW at somepoint becomes larger than 1, not sure if it's possible
in any scenario, without the correct bookkeeping we can corrupt the topology.

Maybe carrying the effective IG/IW through the walk would be better ?

Best regards,
Richard Cheng.


 
> > 
> > Could cxld_set_interleave() keep the real IG encoding when it's encodable and
> > use EIG=0 only when an IW=1 value isn't encodable?
> > For latter case, AUTO still need to restore the computed logical IG before
> > walking descendants.
> > 
> > What do you think ?
> > 
> > Best regards,
> > Richard Cheng.
> > > 
> > >   
> > > > --
> > > > 
> > > > --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> > > > commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> > > > Author: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > cxl/region: Allow passthrough decoders with >16K granularity
> > > > 
> > > > This commit allows passthrough decoders beneath wide parent interleaves
> > > > to have a granularity exceeding 16K by programming a don't-care value
> > > > in hardware for non-interleaving decoders.
> > > >   
> > > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > > index 0c80b76a5f9b4..d164662668c19 100644
> > > > > --- a/drivers/cxl/core/hdm.c
> > > > > +++ b/drivers/cxl/core/hdm.c
> > > > > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> > > > >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> > > > >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> > > > >  		return;
> > > > > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > > > -		      "invalid interleave_granularity: %d\n",
> > > > > -		      cxld->interleave_granularity))
> > > > > +
> > > > > +	/*
> > > > > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > > > > +	 * don't-care value instead of validating the stored granularity.
> > > > > +	 */
> > > > > +	if (cxld->interleave_ways == 1)
> > > > > +		eig = 0;
> > > > > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > > > +			   "invalid interleave_granularity: %d\n",
> > > > > +			   cxld->interleave_granularity))
> > > > >  		return;
> > > > >  
> > > > >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);  
> > > > 
> > > > [ ... ]
> > > >   
> > > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > > > index 1e211542b6b64..5a443551288c4 100644
> > > > > --- a/drivers/cxl/core/region.c
> > > > > +++ b/drivers/cxl/core/region.c  
> > > > 
> > > > [ ... ]
> > > >   
> > > > > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> > > > >  	 * Interleave granularity is a multiple of @parent_port granularity.
> > > > >  	 * Multiplier is the parent port interleave ways.
> > > > >  	 */
> > > > > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > > > > -	if (rc) {
> > > > > -		dev_dbg(&cxlr->dev,
> > > > > -			"%s: invalid granularity calculation (%d * %d)\n",
> > > > > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > > > > -		return rc;
> > > > > -	}
> > > > > +	ig = parent_ig * parent_iw;
> > > > >  
> > > > > -	rc = eig_to_granularity(eig, &ig);
> > > > > -	if (rc) {
> > > > > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > > > > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > > > > -			256 << eig);
> > > > > -		return rc;
> > > > > +	/*
> > > > > +	 * Keep the computed granularity for descendant setup. Only
> > > > > +	 * interleaving decoders require an encodable granularity.
> > > > > +	 */
> > > > > +	if (iw > 1) {
> > > > > +		rc = granularity_to_eig(ig, &eig);
> > > > > +		if (rc) {
> > > > > +			dev_dbg(&cxlr->dev,
> > > > > +				"%s: invalid granularity calculation (%d * %d)\n",
> > > > > +				dev_name(&parent_port->dev), parent_ig,
> > > > > +				parent_iw);
> > > > > +			return rc;
> > > > > +		}
> > > > >  	}
> > > > >  
> > > > >  	if (iw > 8 || iw > cxlsd->nr_targets) {  
> > > > 
> > > > [Severity: High]
> > > > Does this code break region auto-discovery on reboot for topologies
> > > > containing a passthrough decoder?
> > > > 
> > > > When cxld_set_interleave() configures a passthrough decoder, it now sets
> > > > eig = 0 (a don't-care value) in the hardware.
> > > > 
> > > > Upon reboot, reading this hardware state will initialize the decoder's
> > > > software interleave_granularity to a stale value.
> > > > 
> > > > During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
> > > > path skips validating the granularity for passthrough decoders (iw == 1),
> > > > but it appears to be missing an update to correct the software state:
> > > > 
> > > > 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > > > 		if (cxld->interleave_ways != iw ||
> > > > 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> > > > 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> > > > 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> > > > 			...
> > > > 			return -ENXIO;
> > > > 		}
> > > > 		/* missing update: cxld->interleave_granularity = ig; */
> > > > 	}
> > > > 
> > > > If cxld->interleave_granularity is not updated to the computed ig here, won't
> > > > any interleaving descendants read the stale parent_ig, compute a mismatched
> > > > expected granularity, and fail validation?
> > > > 
> > > > -- 
> > > > Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783795720.git.alison.schofield@intel.com?part=1  
> > >   
> 
