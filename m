Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026C37AA95
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015793; cv=fail; b=hLCio4uzRSndVcFy9tckjhbH+kDnQJ0fESJshkVzkIN4K+M3lr24up1hcC8oQhRfp41vOtWj+qiHSqMuYkhHhRpiWTFU+I2KIb9ocx0UnLAVG1WNNdDrlpR+810ac/6IuwQIsBm1DzWc01zNQRqIUjOOk4eX+qNXHIDWJ1Zcjew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015793; c=relaxed/simple;
	bh=9bswQIK46014oREq4kx99e/8ixzgNosWD4Pl7C3/PUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCP0oZmouOoIJvay2e6XLGnozoTC0WJKaygcEQ4xfw5uKxwqF/9dI5WP+XPK8nQK6t8sx74mhyIH3W4d4jWhF87OAQ2/b2FG6SazS4BrVyi82rAMAHXlHQSID6fQyq+4SGI7wWRitqxuaO0h8cWh1RmDh6J+J+Dj+LP9Byucw4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Id1btee4 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Id1btee4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKdZAFC5vx6tYMPNMAu0UVqpL4TlaHKq3GcQtj4FRkWRGCqsBYxE268VIaMMiZ+fZMVuGD6U9VybVSQc3dmrf0epA7i8AxcIHK7lKk0n02/GjO676JuIvfaTSpkghtEQEN0B8oRQNGZGV7QMqZIxXqytbTY2udI7N3vcLnjlJOl20cKtAhwM/9aFZBPGGROkOOGydeZGPe24ECct/aSSoBpaEANz95B2CevH+Rdh/VEzqn97antHvCtXXqrZoUc/c9W4wW5eqKMrrtkmo8nM8nCtN6w3oupOpW0UJcXJjRovu7S2KQ6doQdeJy7kQDbnnveda0owhQWwLPv6khfo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpmAZxfegBEUX3DYJ0VzGBtW7SYSmdhWwXIgnpHTcS4=;
 b=XBxRi9K+UR9+qZXAdooe42pypdBnvxM2knmMXm3rGruWePjQruvpYAFO81hEC+S5t2NsPWVmJFB1Dliru3vjqYPmyt7jg2ovz2K981HMYvR6rWrgWq7n/TK/Ws1EmEACA/xqSmFJcg2e7s+ONopfGjwb0SggD4MDMPHB6+cfpqQoXC5I3veRZkvHg0YX/yaAQVy0pALWUbsmmtdhsnvN+nEawNEHGYDCBBBaM70sQZMh77UhvwXquUjGvdXbyfJX6Net7etY5Q1K+APvAV317+0MQWCNiKz/l7ZCwsa5ZhNycDCCy4O7oVcq2C+A49gZsVpkLOOzhwDwZp60ScR0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpmAZxfegBEUX3DYJ0VzGBtW7SYSmdhWwXIgnpHTcS4=;
 b=Id1btee4E2IghpSXIXfCbmbKOUsKx0Vfox9ICe3FG4Gtvbvcni/5kYkf5c2JKOuHjis1LXtgJlTisZIvZnTYhr01jirKTwwRVQQ/+e2GD8/y/jpjC6dQ1vDEv97fFJ/Su/8b754PibZUr8cSN34LKboROXfDjGFQ3XUeV8G1YWTALZzU/zfqL/SudSp0f9rPhp6FxEGb0fB5Qj5FREs/e1p+nXxmFWuCdS6vHUvbzTwF222g4aytOSPTjIOp50azZmd7T3cdqToec9bsSz0PCoBVj+sTlU4awAHfiDjyzTVEptFjJlXGTHIKCO7YmZZtIyqQPPo0spKi2P9kc9oDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 07:56:27 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 07:56:27 +0000
Date: Tue, 14 Jul 2026 15:56:18 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <alXqISpyXQVzOlmq@MWDK4CY14F>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
 <20260711201508.082531F000E9@smtp.kernel.org>
 <alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alL3a2UXB38XI7Nb@aschofie-mobl2.lan>
X-ClientProxiedBy: JH0PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b646d8-2413-42c4-6b77-08dee17d677a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uAjd1zc5ZlQNcFaFtfg/B+WNC0AEztBcHjhp6FeTt5pHKL302iStgNWK38HSXkVR0sEW3ZXuGm8hL3glZPw9UasHC+nowBraI0cjz/bsWSqr+eRvx+ZdUSlWqXgbMRPf4k/cm2MHlOxMX4r6jzpbSJ60yAi9o+zeJlFnyYW2fY91KpcIJ38oCrMBs+NzwgwlFmsAonIwcU5iI97CFmQHQXLJnRtW/AxAr1G8oaIyn+OdQorn34b5XHh5vivl5vhqM9oqxp7OMoMazPDLH2TmaSVSHYo0ad62eUsNdirFpZMQNhrZENQ4O9YWnQV6p6eQ8VD8PE0O8D+b+51bkUXs1X49du88dxi7sQq/Rhn+AvtidER+sSOEiPEEDgXrjLw/PCniwYIPj8q8TAxqOxgfBGdIIOeNwkfwOPxe9Z3fRYY/8wLxaw8Xa5SZYw9E3e8Q0FSIn2sR0cWHST4fmObJwyLdeu+rFLkfyjAv45rMLxBY155/YksLup7Lrb/ND8QgLuJnhwoK+nfowjPMOHoCYJ102mKUnXFBL3gzTc6jkfTcgMVs4TruK5GwavdSaiQRChRyqQB0fMKsHJltKN672ulFpp8vin07h4I0j4Fzj689mnhKtCSXirKHdbNOXFZELGvryD9lV2T9T9sCxFfJOhZKZwYKCpxuQ75a2L7ziQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AryzNuLXQl0DEve7nt0JVP5+s37yT415XHstwElW5uRel+4NKln8XJKNlD?=
 =?iso-8859-1?Q?i9TnUBY3bN42F2HC3S/10FHfJvvFCV01ZUj83kZs5PksAs24lavaxwMbY1?=
 =?iso-8859-1?Q?M3yWw3Bt29rb3JNJFESsZnxG8c4OdD4o9AXCWxPIj1ejbWH8U9rg1Xte3j?=
 =?iso-8859-1?Q?fqY9Te8QFYEatfDGI+0qyLmkl0tX/MRJEW9LrKXAdZ6Cues6li1scx0Mgg?=
 =?iso-8859-1?Q?JT/1TDSiYIyCblo28/hKss/94M/tdp0o+AnKjRlWi5SThjauglh3sQE9CU?=
 =?iso-8859-1?Q?PIIfTZOs0gogCvOl6OqL2z44buE6hBE1OGoCZifOApoZDWVVGRttRntQZr?=
 =?iso-8859-1?Q?h0A81ErN+7S9V7Cftoih5O0ol1uixvKgSCxi4o9kARftFOEzeXF2cFQELf?=
 =?iso-8859-1?Q?ESRzMq38JwT4gZcLbbESFXp9fk2eUSmuQsAwtdtfMqEuBaAe7HVWy7nytq?=
 =?iso-8859-1?Q?H8Nu8BXE2QrZUoDcEq+IBSvMw6FAVvaBL5LbWwVI33wN/IT0FLK91v4vRQ?=
 =?iso-8859-1?Q?LEMyYSVE7hvjyE3qdNb7dp7GJ1bMUnNTLOjIkhi19jtwbKZexW9SYEM4KU?=
 =?iso-8859-1?Q?5fkUaCpNXk0hkWpzg55So5/jGiZJbfY3X1ASrTrGUn1D+xOBkRp5t1dAqm?=
 =?iso-8859-1?Q?NPcwlNU1k971lT3TnX35gW46dYCZ72WVBshW0nfkliY1qI97NJdvprj0X4?=
 =?iso-8859-1?Q?EBqX615c1mSNmRG0zZB6M+awsUrq1AQTKLnESzOOi1gCDzMKoXejrfGttZ?=
 =?iso-8859-1?Q?RWzalKPcWiwZTrZ0KyHiEpqmUp2t831nQh6fXpwnYH4fNGWGOiBVtpEr0L?=
 =?iso-8859-1?Q?TmOsHmrsFYLw4XELnz8vmDHEq7eEtlVSjOkgj8Xdql3YYrWpBNdhD2jE6D?=
 =?iso-8859-1?Q?YP3GmOSaq9Jpt8XjAz82/05c1EBr+BBbLKT7pWtHwfxGg1v8oJlo4cw754?=
 =?iso-8859-1?Q?HJP0qLZ5ZSDPiVg62MePX/zJONEecJojs/hfxgeb0dfHX8tFR62td2yQNG?=
 =?iso-8859-1?Q?vHF0GesWXiR30Ag4D0vIHfui76/WL6qwYkGm/UIQbl3Jh3NUtdzANy8LlK?=
 =?iso-8859-1?Q?QGovlxRK/bE9Qse0rQYtdO1nVMUjAdIXhd+eFl4E8w29g48MnbVKdnnUOF?=
 =?iso-8859-1?Q?9tjthKNk6av9f7M8OP+WPu23w/mlf4Qd6FzS8XFv25gNWcVhsLuL7RRWFf?=
 =?iso-8859-1?Q?0Pm4dtRK4qlAeh+G+k//Ll8MzJnCxH5Bd0dR3faEGwXaihUVcOfPClmlAE?=
 =?iso-8859-1?Q?ZttVrmLhjrtLZvT+fWevFP690D7+3WcOeE/selIAQgqo1NmC/74H6UGze7?=
 =?iso-8859-1?Q?A9FiEyKrhLn0y0Bj2xdHFnbfKY82+Ln6fFXiPnFdP92nVbqYWGsbNydRN3?=
 =?iso-8859-1?Q?mIWBctbZpqiR5Nf4+cveATCAh7Vvs5CUD9mROv46Jj0jHhE560P2pG3eBY?=
 =?iso-8859-1?Q?7GZ3HDynD6p6JI8uI5p06SrH+xn0p7cS0oZbJGHcCBuiCKAFnp40bN96EA?=
 =?iso-8859-1?Q?YHFXevarNimBEIhwVf9AXRVsXrYoV3BDzTHtQ1pyePnM/UDD7Bcuadqz5Y?=
 =?iso-8859-1?Q?QLhHNmauxjtKBQ9z9PsqWtPN1pG/gfKDqDNyC8qvBGQzZEk/r2aj3XwDa+?=
 =?iso-8859-1?Q?vFW8lRHDRLDDViLb44iNmEg1bUUyxQvdXY6jN17Deou25BNiZYeRmDjZ94?=
 =?iso-8859-1?Q?wX1gpiP7t/rPyREMWaOVgivPLWVSGXwKI/U5YY4SfF5A5hhS5GhlAloEPK?=
 =?iso-8859-1?Q?diCYkQce6wVdBuIjKIC/pzsm7KzHmuW5gNUR5NxZ3LLv+c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b646d8-2413-42c4-6b77-08dee17d677a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:56:26.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ly2av8eeNvCf9tcORAAowSBh9vNesiexV7uIi6yI0LUaKJqiqNi39qBRGN0gMcye9xMZvtxpsq1WwGzZGYPOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016

On Sat, Jul 11, 2026 at 07:09:47PM +0800, Alison Schofield wrote:
> On Sat, Jul 11, 2026 at 08:15:07PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fail to update their `interleave_granularity` software state to the computed value, causing downstream decoders to inherit incorrect granularity and fail validation upon reboot.
> 
> Same NO as in v1[1]  and I don't see a way to graciously alert you to this
> in the code. Gratuitously updating the field is not the right thing to
> do.
> 
> 
> [1] https://lore.kernel.org/linux-cxl/alKP8OP4DNT2nJnu@aschofie-mobl2.lan/#r
> No. A downstream decoder can't inherit an unecodable value into a failing
> check. A >16K granularity only appears below a wide interleave, and
> everything below that inherits an equal-or-larger value that an interleaving
> decoder couldn't encode. So every descendant is necessarily passthrough and
> never validates granularity. There is no path where updating the F_AUTO
> value would prevent a failure because the failure cannot happen.
>

Hi Alison,

I'm thinking of 1 scenario where a regression might still happen,
independent of whether an interleaving decoder can appear below a >16k
passthrough decoder.

The new cxld_set_interleave() behavior writes EIG=0 for every IW=1 decoder,
including cases where logical granularity is encodable.

For example,
root: IW=2, IG=4k
passthrough: IW=1, logical IG=8K
downstream: IW=2, IG=8K

During manual setup, the passthrough decoder gets a logical IG of 8K.
With your change, committing it writes EIG=0. On rediscovery, that is
read back as 256 byte.

The AUTO path accepts the passthrough decoder because it skips the IG
comparison for IW=1, but it does not restore.

The downstream decoder will inherits 256 bytes instead of 8K and its 8K config
fails validation.

Could cxld_set_interleave() keep the real IG encoding when it's encodable and
use EIG=0 only when an IW=1 value isn't encodable?
For latter case, AUTO still need to restore the computed logical IG before
walking descendants.

What do you think ?

Best regards,
Richard Cheng.
> 
> 
> > --
> > 
> > --- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K granularity ---
> > commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
> > Author: Alison Schofield <alison.schofield@intel.com>
> > 
> > cxl/region: Allow passthrough decoders with >16K granularity
> > 
> > This commit allows passthrough decoders beneath wide parent interleaves
> > to have a granularity exceeding 16K by programming a don't-care value
> > in hardware for non-interleaving decoders.
> > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 0c80b76a5f9b4..d164662668c19 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> > >  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
> > >  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> > >  		return;
> > > -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > -		      "invalid interleave_granularity: %d\n",
> > > -		      cxld->interleave_granularity))
> > > +
> > > +	/*
> > > +	 * A non-interleaving decoder ignores the IG field. Encode a
> > > +	 * don't-care value instead of validating the stored granularity.
> > > +	 */
> > > +	if (cxld->interleave_ways == 1)
> > > +		eig = 0;
> > > +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> > > +			   "invalid interleave_granularity: %d\n",
> > > +			   cxld->interleave_granularity))
> > >  		return;
> > >  
> > >  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
> > 
> > [ ... ]
> > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 1e211542b6b64..5a443551288c4 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > 
> > [ ... ]
> > 
> > > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> > >  	 * Interleave granularity is a multiple of @parent_port granularity.
> > >  	 * Multiplier is the parent port interleave ways.
> > >  	 */
> > > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > > -	if (rc) {
> > > -		dev_dbg(&cxlr->dev,
> > > -			"%s: invalid granularity calculation (%d * %d)\n",
> > > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > > -		return rc;
> > > -	}
> > > +	ig = parent_ig * parent_iw;
> > >  
> > > -	rc = eig_to_granularity(eig, &ig);
> > > -	if (rc) {
> > > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > > -			256 << eig);
> > > -		return rc;
> > > +	/*
> > > +	 * Keep the computed granularity for descendant setup. Only
> > > +	 * interleaving decoders require an encodable granularity.
> > > +	 */
> > > +	if (iw > 1) {
> > > +		rc = granularity_to_eig(ig, &eig);
> > > +		if (rc) {
> > > +			dev_dbg(&cxlr->dev,
> > > +				"%s: invalid granularity calculation (%d * %d)\n",
> > > +				dev_name(&parent_port->dev), parent_ig,
> > > +				parent_iw);
> > > +			return rc;
> > > +		}
> > >  	}
> > >  
> > >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> > 
> > [Severity: High]
> > Does this code break region auto-discovery on reboot for topologies
> > containing a passthrough decoder?
> > 
> > When cxld_set_interleave() configures a passthrough decoder, it now sets
> > eig = 0 (a don't-care value) in the hardware.
> > 
> > Upon reboot, reading this hardware state will initialize the decoder's
> > software interleave_granularity to a stale value.
> > 
> > During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
> > path skips validating the granularity for passthrough decoders (iw == 1),
> > but it appears to be missing an update to correct the software state:
> > 
> > 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > 		if (cxld->interleave_ways != iw ||
> > 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> > 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> > 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> > 			...
> > 			return -ENXIO;
> > 		}
> > 		/* missing update: cxld->interleave_granularity = ig; */
> > 	}
> > 
> > If cxld->interleave_granularity is not updated to the computed ig here, won't
> > any interleaving descendants read the stale parent_ig, compute a mismatched
> > expected granularity, and fail validation?
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783795720.git.alison.schofield@intel.com?part=1
> 
