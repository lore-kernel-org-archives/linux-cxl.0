Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58E3AA4E0;
	Wed,  5 Aug 2026 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901192; cv=fail; b=HXfDVHm6E0L4Pqdr7prIiyUY6bIebWe2ivUVSnjAZybP4H3tUA9Yey/PacL+zkm5r1fYDVuQFSzDTd38gqgNjLEYT2o0tGNJ88wmXotTNau0fJzVdSxM/U9yLlJaE3etI33yZpIxas1w+9HW+Z5CrHIZZWZzINa9dILjPnVpTzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901192; c=relaxed/simple;
	bh=l9Nf4Y+zw04nEaRJwfjhanh61dESy5wn46onOkdSsFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LmksW320z4FRcEssethpU7TET8e/ScWlgb8WPBWswhZg2bbdIChCYAn3iEKJf4c+pQpn7DLoxmlRX1kepCLV9j3OaG+VhZ9g67mnjcrt2nE4zPx8LbQk7iN6LjlhPBj6HZlUoHWyOBnkvOi4yYGy/Gv/6dMekHtgooUXZNMoMlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KsF4ovWf; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KsF4ovWf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkrhwLRDU7aVLrBap3SUwfwGxtha6v9aaFKrB6Bo3dSgIz9ZUAq+RBZuRsRss+dWGOI+Jq2qxovmdGLIGgHsfQUnmDXIErQc9216apN/mrfqWjpQoNxx0nFhKBLgpEnfWk7ieP8s7YzrSSKcFcIVnDADrv/kzMtFKGVSNF8wyYr8jA9xd9XdILB4a8hjKvCN83VreW8zblozIEOVU5c2yCq9pMaAybspp613X8qLp9iqAdNrMvq5pGX68jEf2Lx4XbX0IzcRi6jp/01/MxaqweNClz3Pr1xrO5ajWdN+ZbCbwJfDdEjj1w7ziL1TFOkmOG7sLlj1DR9mY5R0uRH/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8abm2swbw7Hj2mAmX/+J1U7mmuUS7t00PontRBYTvo=;
 b=v0G2yabc7sYHifhcTp+4Zs3Itkf0HaFPudIEEltdNiV9vm9NqGGDjfSg1ijCB8G0LrV49Js6mG7jcLJmk8E0L6Z2zsAvpiW6ZehjpBbFq3fSWQpISFcFCYQLme7yJaIVUYFN30Fm9qO7H2KTLspyvwOtsb5NUv0KxdEW2BdRsCZDNLMzjvZOH9ItNi0mPMl5N74UyV9yy4jdyXdE8nFgYQ2pr4/O/U3KxJYoHvVMXm5AnYNSwE/06q6NfithXQ/tVlrfentlZjS3bZhQn4CFK0qgTrHy0tbJt220XryiC2NHRFZw3g8lZ1c4Oq2eWAV2Rizt5Lpd/Yn2I55veYxA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8abm2swbw7Hj2mAmX/+J1U7mmuUS7t00PontRBYTvo=;
 b=KsF4ovWf7kfm45hqRsfVDnQEWt0n+EWuWGtOFfEM/L7qgSggNarI1cSPUOfEaRcf3bOBKcdhrn3oThRxspHz5gt5VbOycqALG4HcyPdy2M6EUnsypc8018jjhh3hSl+re1zXibSuzZulR9RzOs07we8RlMFtBwuo7RntEkUfJ1qgSFQ7SSt/mWj8ISiQdNd5J+sD8gmIvB/PidJD4T4MRTj14MxOLpDou62VIlxBP9b0GAbLZdHajNsYxXPX3Mwv4rkiIJJzGcBSczy/xmqkDeASzrR915P1y/02jSUpkrS4VlGsEUg6nIYVSf3T+P1W5z8ijChh97Ly2wG+aPBUww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 03:39:46 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 03:39:45 +0000
Date: Wed, 5 Aug 2026 11:39:39 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: jic23@kernel.org, dave@stgolabs.net, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	vaslot@nvidia.com, mochs@nvidia.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Message-ID: <anKvyEzNhE5uB6rQ@MWDK4CY14F>
References: <20260731064902.34127-1-icheng@nvidia.com>
 <20260731064902.34127-2-icheng@nvidia.com>
 <amzyQ1BTDiwfe1b1@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amzyQ1BTDiwfe1b1@aschofie-mobl2.lan>
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 929fbb7a-0dbe-4cd9-e85e-08def2a3314a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jn43qHEal7OrXDvVBfJiMkyj7fU+BJXV9LTQko9YxKBLVYbKt+D7LliLP2hPgZXGwJ3VAs0v/WTVi4JyCvx3eu16UMQVpEJ9YBp/K2uNuMo6nVxQU5eQ9SOAdCyyWz+Oosph0rmAbdbJlph7zy7ivNnp3crefuBZcIUYs2qVF0KGzdO/vOhAznemla3bYZFlBQ+UJSHDUDG/LNcBbZcbtYps0Bx6WTysN2QNqO4BmBPyNCxgRoQKAsBV0M0JoSxacxXapenrhSU7G6v9/njaIwxrmnw+UNt/R9ikKPbTCmT9Y9zDrFZOAb+jhwzGIpkzoi00MmgS2rmNAysokMUDJZO/+FqJMO4+xKdRz/V5munE1XRhwOscc1XZJ1TeGpYG56tahPGF07npakjWXZi25TO/kqzCNeaoIbNx+cWTeeWLRz0Ww9lWCDM0V/XW4eyZaDIiZTtC7rIugnKNoYeLcFGagfwZkg1DdrIQlac2hZRNPMZXdMbyvisRQB+Oma4+I06UgUTJxMch8CceT1cWf1t5CbZ8js4cHXoyrlbjP0ctCm3psKH7wav2GGviDYCZjG5VZvMfXD6ztb32tfOHUo4l9LRa4gDHFFezhscZkajM7nZrplbSn20DmQ7U1q1fUCDgKktTtGYUtSpmV1YODMzmODRj/rHELnYDPyGXWec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mUAWfc+DamxrcKIYbtuzSpyunDjXnO0MMVH7AV2+9YwVkzR80k+VOUsBAvly?=
 =?us-ascii?Q?RkPJoTuCuLhhp4djGV6xzf1ZZi6/RBWqvLLRR0GZYuO4ZgzYiXBT/4PmWAzG?=
 =?us-ascii?Q?7j1sFLyjMxPoSyk3CgQpwmJyuHMm3+f6HqnuBM6DDQow1tkS0q3FFw0DydRA?=
 =?us-ascii?Q?itrc/mHOOdzzNF02b5mlmDvmoweiKQHymyOd+LQErtFUdGO35pP6LUazEheX?=
 =?us-ascii?Q?82FZhEs1KSaru7SmC4Y9cB9kuipiVJ97UvNSINYKbxTHCYb5J5FPq8TM8UgK?=
 =?us-ascii?Q?9sRVg4mGJ9XB/aIGLEjlFLea2s70YlSQM1JZA7BAet6LDAFYJ6/b+NCy4KkA?=
 =?us-ascii?Q?/crT0Sv4bb63oDSUZYFaePYKCGTXMT+h1KDnObYUjRgFiiOl8xycq0z4bJsH?=
 =?us-ascii?Q?uc7jli7Gjm1OweCkOcKifHLeSm2f0WZZRsEsTHfiK1t8Pzil76bBYg1wSroe?=
 =?us-ascii?Q?ecBOyptWS5tS07yrLU+4vrBmqzcLqvX93EYXcxy0XVP03HhfXdJamCi2KwsM?=
 =?us-ascii?Q?Z95VkL+KQXnhG6mpn7r8TNoHl7XfxGgOEF8LD1D6Mp7GpYAKU6vMOLQqmDxP?=
 =?us-ascii?Q?WudaUDo9frMlUFUGyVX9+9BjnbVDOM16Z7yOCBTH052v7zHk+W/wpfg77aw+?=
 =?us-ascii?Q?TDz1BFgc9Tpm1wzcwv8fGOPCagMWWPmP2LuKIcpXjoyRMj+dmWx5JU5ZzaQ2?=
 =?us-ascii?Q?uWsjNGKFwuwBcc4jU0yggMxTyJw7ANc5Vrj9WbTu5ajfJWNaci1qYrws4OfT?=
 =?us-ascii?Q?/80oRwIpkUIdm4TV81cuJfWqR3mSXBUqUkeJgrAh1XO+Ai3Mx0xHwgbFoYhk?=
 =?us-ascii?Q?g/VVNmYcn1tOiGnsMzhRuyQ+DWE01TUhywvunEXOql9WCgLCgnPfrDT40KlY?=
 =?us-ascii?Q?cduWlZ6AFJtagTlAheyfIlg7mKCRbVVrgM9oSqMW2E9zZQfsV28snhKvOq6R?=
 =?us-ascii?Q?CY0rvjcYYX3K1ioFtsc/K5EkY0gRyGMjFzl7r27NYnGwEQIq7SA4KzSzY3IO?=
 =?us-ascii?Q?H/Y4Pd3zwq8sI4ZxwDp1+ZrpmhTojAcGnemBQ0ll4U10gDv2CKQOnirE10ay?=
 =?us-ascii?Q?SJ9EWQjJf95iGU2pYF3rBZuuO7R08o3nCW/PBojBeKbg3slDjMeZoPTCEtFa?=
 =?us-ascii?Q?B3Xlxl0TZghV09VN/JBKa+oBeTsXaRSXUNmyr7hmqGI2gzAyyVWocPWNFFVt?=
 =?us-ascii?Q?h9FkDn+mIxHmidAb+1XUVa6dHn6HY4sLGZ1SmxDi3UIoyw+YJ4eIc8VsStTz?=
 =?us-ascii?Q?jytha8crn2lb1RstSbmG36ydy2MtbFp4b4ovbAzyP62P/mfHQOUdbK4eR6Fb?=
 =?us-ascii?Q?8Ja3D5d7E8N0lAZFPQJgH8iy/OmemKzEh3UooSRsmN55KhY0CrwRwt1SNETq?=
 =?us-ascii?Q?W0Gfpc42JYjmMMieW/ortzDIExxHZbw2JFLzanYQhmqJ/0g5ux1VGgsZx8r8?=
 =?us-ascii?Q?OuOawybbHve0da3YTvN+Fp83nbXTSci50GDgrnA4sFaLLFSFFbaP88aUnJgu?=
 =?us-ascii?Q?NntWizGx3VtHpzcsTPAajyeZuS+wNfEFxrORWpOTP3ZRb9lju7aERmtIggk3?=
 =?us-ascii?Q?/u+13BmWXvW+mpFFTnLflfLvx2p3oFut2bl/UmwcqWOVrXN5QWpCex/PATZa?=
 =?us-ascii?Q?47yP0Axx5o/BAISAAOXTUKocRh9BjYgRB4EonfvaNAVFhkA3ICZORePPvice?=
 =?us-ascii?Q?Yd1D7nV1dll3VUsg6Ebki2qOPgYj+7asEKyCIiFwLTZ3+rYX6sSlFD9eYdgU?=
 =?us-ascii?Q?t2nLD/Rlgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929fbb7a-0dbe-4cd9-e85e-08def2a3314a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 03:39:45.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+3VTqUb2E+DyAqNM9K1B/5Gvz9ARvmTsAk+xr30LJEZic6ydX70y13+sbl5klSffYrdyHdLPXt9ANz+LcA93A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

On Fri, Jul 31, 2026 at 12:06:43PM +0800, Alison Schofield wrote:
> On Fri, Jul 31, 2026 at 02:49:00PM +0800, Richard Cheng wrote:
> > "rc" carries both an error code and the loop control
> > signal for device_for_each_child(), so returning it bare is misleading,
> > the early guards mean "keep walking", not "no error". Zeroing "rc" to
> > forgive an -EFAULT on a RAM partition adds to that by discarding what
> > the device actually returned.
> > 
> > Return a literal 0 where the walk should continue, and test the
> > forgiven case directly instead of rewriting "rc". No functional change.
> 
> I walked thru to confirm the no functional change.
> The old rc=0 was never read again on either patch. Each return rc you
> converted was reachable only with rc at its initializer.
> 
> One comment below wrt the EFAULT case -
> 
> > 
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/core/region.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..fabaad3469b1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2950,14 +2950,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
> >  	struct cxl_dev_state *cxlds;
> >  	struct cxl_memdev *cxlmd;
> >  	u64 offset, length;
> > -	int rc = 0;
> > +	int rc;
> >  
> >  	if (!is_endpoint_decoder(dev))
> > -		return rc;
> > +		return 0;
> >  
> >  	cxled = to_cxl_endpoint_decoder(dev);
> >  	if (!cxled->dpa_res)
> > -		return rc;
> > +		return 0;
> >  
> >  	cxlmd = cxled_to_memdev(cxled);
> >  	cxlds = cxlmd->cxlds;
> > @@ -2967,18 +2967,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
> >  		offset = cxled->dpa_res->start - cxled->skip;
> >  		length = cxled->skip;
> >  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > -		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> > -			rc = 0;
> > -		if (rc)
> > +		if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
> >  			return rc;
> 
> I notice that the rule "forgive -EFAULT on a RAM partition" is now spelled
> two different ways within twenty lines of each other.
> 
> cxl_get_poison_unmapped() uses the positive form, while here we invert
> it. Can you flip that or add a poison_efault_forgiven() helper so both
> usages read the same?
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,

Good idea, I'll form them into an inline static function in v9.
Thanks for this.

Best regards,
Richard Cheng.

