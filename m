Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0D3191CE
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402447; cv=fail; b=YcSaDMPvSfE/XWcpVnIlcL/IZEotPVSzi0c61vhJdH5INjPdpuXkR+mHY5+NxTyvRsBQwHtE0EeeROZEcyeSmKh9MY5gd7XzsAs9+v1HaMvvaTfOkkPunwtDN9A37Jt5+tFvg/WqC0XGn9tAKg/CJxdxfQHtFlrDXzaB+mI/v1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402447; c=relaxed/simple;
	bh=1c4Tvey+J1kQVwA/8vc8bRXOlQ8eJ5KhdZlaKu8Qq44=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HeCHpMfxfGOSAA9XoxrPgY2aI2QBlL++hrd8h1M1OteuNmy1yZ0EKKz815Abtn36TKGyner5ZWp4Pt3W1z0/4Wb04Eb0jEPzq4pEGYYB90Vqa6NQaDeROrImuYH55TryTKyiSZfldbq50D1RD11ZlUIY5zekTZQf7EiPmmQ/554=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEkLMzj9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEkLMzj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788402445; x=1819938445;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1c4Tvey+J1kQVwA/8vc8bRXOlQ8eJ5KhdZlaKu8Qq44=;
  b=XEkLMzj9ymspjdKJWLBQWMAdWRbNKr1R1mrGHLSov/6wj+8WEQoEQAxU
   wTm/5ScFrxZctn17OE/FMyHOMyEg3HF+keyCI5730O5EWs+QvQKhJD6vc
   cYD9ur5djqouREEGGxgR8+3crzy/ht7e8T7UwhYaDIApkpDnSOFrS5tX3
   aA8MLZCeJCGIJYVb2+Itnrn6rtqkZAcnzqfqWgoIP1tYh8CzUQCLGITcP
   TVREuF9M7fhbhi4OmpDX9GXbBQM2xzDeJhyc2aSljK3mJ/7Y3Yk9hpuzQ
   lG6VtkF5Ztw0sKJ9rXtVCs8a51J9G4hSUFPXFOHwFuFCNsn6jDJ3Km88a
   A==;
X-CSE-ConnectionGUID: PbWlke3/Sc2vzASfOqoIWg==
X-CSE-MsgGUID: YKC+/oi9SjS0X6MJuvWdZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111646495"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="111646495"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 19:27:25 -0700
X-CSE-ConnectionGUID: O0nKFBPoRNWZqTzATCtNAg==
X-CSE-MsgGUID: GJZ+DmBRSuuHNueC+JDX3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299450730"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 19:27:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 19:27:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 19:27:24 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 19:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJkrXCXvEpUvmW6WhAIu8oQ+x22WQPHZ65n/drgD6N0cCxgJCpo9VJ2UrEKMUOC1iexubF6wct4rL9NsZlqt7pLp6CFYqyBeV9Vvyterrvq4DzW5gQSYur5C5ZUlF0yK5zOeozPUM/bXqWCI8NukW454va+ZGMKtLjZbML3kdb6WRsGw8a4BhMciXKJOAmU38wgKzxFaWjMrX3M+Sm9+F1HdDN9pk+bXGaVoSNTWCcpo8iYNbcKmIoptN+j8FSylBw8suyO+sEBjw/bKJYtNpr8NZE21ryx6pDg8Uli7dp8/u3aZY1smRXgdRDJz04zv+qysQFn6+rqykiODA2Uliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3fGtZG9u77EVQjJ6DJOArQSywbb2DXYW8FsME4lGn0=;
 b=HPOH2snd1HR2hZU6NHxuWCDiy6+rryVWFG9tOKW2RtJpSb7vcS92L1uapPVpcfp9VXaVk4VM+jgXU5DNWsaOstQfOA7IEwAlb0V6m/re/jeBbHPvuYotCbmkf+MdW0jPtQ3Krl8w6tMZfEXyvyfzvqYTojx6KIctrAKkgVXbC6Xk+gEv/IArWZV2SHWqLMk5KwTcbuLjiHHVs61D6AQzZPPUp7USjrl1JuedH77mztLoHmWDo/I3P6LIsb82Rxk0M4tMyiw4L5CnkHIVHEoJy1DLTWBla16/cOims7Celqtf9tBda3IVOGtycwOJNWneieg0Nn/h5XtwiAPSPvEb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFAC7DDD7F1.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:27:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:27:15 +0000
Date: Wed, 2 Sep 2026 19:27:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Robert Richter
	<rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Message-ID: <apja_2UovcuvZG4o@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
 <aovZXTZ26siN8PSQ@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aovZXTZ26siN8PSQ@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFAC7DDD7F1:EE_
X-MS-Office365-Filtering-Correlation-Id: bb085555-bd18-4610-be96-08df0962de26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: UmKk/hPiZk5pqkZ+7+PbepRlr9ak7g9aX15QKvqmENp97MTBJ4bmHqxsFxLMkWTu6Z+ts5iNTA2iwQ4iMqqvoyHqG+aQcajDrvSOgWukPY2833AitGeZBoVFaNGI0n+p6skkK68soIS7JzmL1z7KMxUSJj1xuDBp/z91okpKjH0C4M9ZgdzS8zgYhqAk6Q6cABc3XaHpdKRUHRsqmFqbu4vhpwac1pI3iAe/eM0hXkI6RcqHNPzrnefCIJDfWwtV84heK3fDOLgBV/cKG9zV+onf4U14kXc2F4tQFR8osQlUmgzyK2RNN5rzNKpVOR3vVa+NH/RpenC0JAP5Zele30A4z5P7EWJq96lOr/tJZZ9TB56P1aMGKXkNTcI4aPom1juDLWtzyofDamPyEKl+76S6BTegy84UQgcuHXcPnN7Qj0VpQ7vv6171YEAObEz2cTqpQvSxAsaxHSkt5rBAptphXsWZPK5gOJofxWlxbesPjS30iL8gM16JHRCRwak/Qfq73GeQAZXbrxYuMch7Y9UAOqmMt5K8ToVcE9e1bbsyW6cC1KnMRwrDyClz4XgG17d6q4vu+IjOZ0d7hdfOR6Ek8nBcfmnyBCm+WGsdvvUoW/U5vrTVePyKv9cGs09DRlFDpS/cGbf1apN4jJOpQjtYGvBO4V0x6kz1t7wvQVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFUkUCxvMFg3ZR3wLYrfbSIJIi8PGFOs0Cbut9p9nmU2CtScAejvx+QK2Mri?=
 =?us-ascii?Q?TBRLHf/iYTbI7DW78feQv6EALDqlkLi8TF+JKpnUB5RWQOCH8vrDxP6iIqKz?=
 =?us-ascii?Q?Uy42Dl3/ftFKcDrti0Px1pfb0OIyz6nxC+40AHeQDE9MO4UIkvE43u5dgbHN?=
 =?us-ascii?Q?k94p8o9wvTzNm534WuHEk/sYUWBLvEYUhRy7Tsatj83NKp4qrAYrhvtUMunJ?=
 =?us-ascii?Q?jdnXbyMSrVFpImzhFB8/QVx0FOR3WJd/qC1QMcrz0NtqPCC71VibzQRcX+8T?=
 =?us-ascii?Q?46KxhvK2hne1DC5ioYOn0sz6EDvJsRn5or/bGx4akqFy+fpG6O0NIs+fKZJC?=
 =?us-ascii?Q?Keoi1Ubad0L+3Vj7P0roKS+iCVgkCw9cezirTNC8UBidTdfks7WO5pIRkFQK?=
 =?us-ascii?Q?IKzXdVGj3i1OiIeKwHlBeBP0K/oVV6gVRIs2223eIBuR04MVLWC/eEWjmQ8u?=
 =?us-ascii?Q?gIhAEzKem8S/VbER+wo6U4h6ZRQHfzKlE7LIdfOjE0uIFN+W27KFzOofaGIS?=
 =?us-ascii?Q?JH1BBhQZDnaYbSjXy3a79yAk01efbtYp5eaz0WBt7z3d2SyfXuDznWa2MS45?=
 =?us-ascii?Q?D8E3Eut4P8JpG59LPTvDJw4kjyFesaFX0p1spym2Q0Sp2WGYZU3OauODNck4?=
 =?us-ascii?Q?9GZv+2GACR0iyiCQklMyVjhd06dTD0lh46nOrd8C4/9jcdkvOysmc8Cs8NfU?=
 =?us-ascii?Q?RKNf4m9usowFQGesXuvxk6khA4NuZX7tgqE05CbloVbX0Vm0lmz792Ko2Vhx?=
 =?us-ascii?Q?/3DZMvUg06JRYUr30cwgUSxG8Np5EDq90a216pKOwUwepX8PG9jZ1mxg3H8s?=
 =?us-ascii?Q?r1GOeDimQgV1UaUqpqyYhDf9tXdwglJOzTgBU731otpWpRBqnqopnm5yP/J+?=
 =?us-ascii?Q?UsAJ6bwfeybMIkitXSQz8s+eycuA3vTh1bSTRJUFmhCR/dZFvKXo8AJm1RYU?=
 =?us-ascii?Q?mNZXgIqHWzcIg74bc3Sear+/Gk1ZwKs6pSN/3ycbQRwwG7FN15zWY1UOznPL?=
 =?us-ascii?Q?rSY6WAaVHL/fcOyar0KWw2zlL2zhlaGperWVueb1MvDj/aY6Vo92n0qugGu8?=
 =?us-ascii?Q?nLU6lQ/5zq6P4mbrGtmabP41nY+w4Gjsq3klZ2yata9MTBBVPUN20IIWwRkF?=
 =?us-ascii?Q?zEwQuv4nzo2smVJ2wqKUJpHRRnvTXh7K5l4ut/eyQ81kGiaPIXS16LgqbImX?=
 =?us-ascii?Q?YmTpmnIS06+oBWmXXqzC0pwhl+CwpNSiwnhiC4s2Q7loL27unOuG5PKBqnKO?=
 =?us-ascii?Q?WDilwM2HKESuQ6W2aPn7qlf2pNBOubEzxGmTIqYHa9loIrV8z25+kvXBXaK5?=
 =?us-ascii?Q?LmlMHsgrd1r4naycOiIsPwN1YyOc0ZoqC3lc9s3CGeX7rZu9DpQyJdP44/5B?=
 =?us-ascii?Q?zfP6Hg77mOyEC2n8uWCnhEuxaFanQAEBtdLX5r4Vch0sQzOKuFZWB0919YBA?=
 =?us-ascii?Q?vywxg2SKAPm7aQK7qikDBJ0TPyNlXmM7VkOcKFs5vGkZG2f6P/ytwyX2bVEu?=
 =?us-ascii?Q?rTj9jX11rXugdLKe5NsTy1Y+M19NJYJA6k5kiFyHsdngVaQbkXDLv/kPYEDR?=
 =?us-ascii?Q?NUPYbhkWlIPNG95rlUVPf8VCZ+QJkMZZLmzaAC0G1z676wxAEqx1jbYytk4m?=
 =?us-ascii?Q?QTseQ0SKcxZoiqnwujHp/GcbXzSQbpQ6zyWhSH9x5ZZ/jJ23bTPyu7XAbpme?=
 =?us-ascii?Q?+rYMoptj6eiORYXVaYlabuMhLtqF21LhMH0fHOdlVynaIp6pYowF3kOwie4g?=
 =?us-ascii?Q?wqOxE9olpZer6wuChnjZ8/bCQrAPylg=3D?=
X-Exchange-RoutingPolicyChecked: 5Kh4D3rkuVI1X4BQzVLoD8+vtT1NDDv4XM1jRhX2KuF13v9Q16eaPOyrxcKRDOaceM+/FxMrUZLYlcnq17J4xSVomCMhxMCs57BzV1nLDlmtV1imkF/5fNOkcgnkBdsNtc4cJCpTrNkHL58pwLpHK99l/j826uTqFMAOUkJTiYplOpbcEwo/MkI1d7kTvwANZ5CKFvJuoq3nM8KL0Fh0O0j5R//5tu+DASREhd6ydsxly76VcmBXRjeIkGY/crEZgcBzEJiQ0XLjKddu/v1r3mju8EPUD8UvfhO/4YDLEKS+6XmeAbNfkCFoDO4ASnCmUbgpP1AXANKvrYzMwfOcow==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb085555-bd18-4610-be96-08df0962de26
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 02:27:15.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7FS5/jjbw9bBO7xICvoE6gvEe59afw+1WNE6aCbyRew068zlLtKkSF0m13F/c7T6NJLYLaxIVkm9ieQsnJi2sa1MLOCM4PjfkiPOBhva6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFAC7DDD7F1
X-OriginatorOrg: intel.com

On Mon, Aug 24, 2026 at 01:46:10PM +0800, Richard Cheng wrote:
> On Thu, Aug 20, 2026 at 04:31:20PM +0800, Alison Schofield wrote:
> Hi Alison,
> 
> > Endpoint position calculation currently relies on the requirement that
> > an interleaving root have the same granularity as the region. Auto
> > region creation builds the position by multiplying by each parent
> > decoder's ways, while user region creation selects the root target
> > with 'pos % ways'. Those calculations are sufficient under the current
> > granularity restriction.
> > 
> > In order to support mixed-granularity regions, that granularity
> > restriction will need to be removed so decoder granularity can change
> > between levels of the interleave hierarchy. The position calculation
> > needs to account for those changes to produce the correct endpoint
> > ordering.
> > 
> > Change the position calculation so each decoder's contribution is
> > weighted by its granularity relative to the region granularity:
> > 
> >     position += target_pos *
> >                 (decoder_granularity / region_granularity)
> >
> 
> This looks correct to me.
> Please see the below comment, having a question there.
>  
> > Use the same relationship to select the root target during user region
> > creation.
> > 
> > For currently supported regions, the new weighted calculation reduces
> > to the existing position calculation and produces identical endpoint
> > positions.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 60 ++++++++++++++++++++++-----------------
> >  1 file changed, 34 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3b640c9ba5a0..4f367feaf6c8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1805,9 +1805,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
> >  	struct cxl_decoder *cxld = &cxlsd->cxld;
> >  	int iw = cxld->interleave_ways;
> >  	struct cxl_port *iter;
> > -	int rc;
> > +	int root_pos = pos, rc;
> >  
> > -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> > +	/* Root target selection advances at root-granularity intervals */
> > +	if (iw > 1)
> > +		root_pos = pos * cxlr->params.interleave_granularity /
> > +			   cxld->interleave_granularity;
> > +
> > +	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
> >  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> >  			dev_name(&cxlrd->cxlsd.cxld.dev));
> > @@ -1908,13 +1913,13 @@ static int match_switch_decoder_by_range(struct device *dev,
> >  	return (r1->start == r2->start && r1->end == r2->end);
> >  }
> >  
> > -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > -			     int *pos, int *ways)
> > +static int find_pos_and_gran(struct cxl_port *port, struct range *range,
> > +			     int *pos, int *gran)
> >  {
> >  	struct cxl_switch_decoder *cxlsd;
> >  	struct cxl_port *parent;
> >  	struct device *dev;
> > -	int rc = -ENXIO;
> > +	int ways, rc = -ENXIO;
> >  
> >  	parent = parent_port_of(port);
> >  	if (!parent)
> > @@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  		return rc;
> >  	}
> >  	cxlsd = to_cxl_switch_decoder(dev);
> > -	*ways = cxlsd->cxld.interleave_ways;
> > +	ways = cxlsd->cxld.interleave_ways;
> > +	*gran = cxlsd->cxld.interleave_granularity;
> >  
> > -	for (int i = 0; i < *ways; i++) {
> > +	for (int i = 0; i < ways; i++) {
> >  		if (cxlsd->target[i] == port->parent_dport) {
> >  			*pos = i;
> >  			rc = 0;
> > @@ -1955,13 +1961,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >   * @cxled: endpoint decoder member of given region
> >   * @hpa_range: translated HPA range of the endpoint
> >   *
> > - * The endpoint position is calculated by traversing the topology from
> > - * the endpoint to the root decoder and iteratively applying this
> > - * calculation:
> > + * The endpoint position is calculated by traversing the topology from the
> > + * endpoint to the root decoder and accumulating the contribution of each
> > + * decoder level:
> >   *
> > - *    position = position * parent_ways + parent_pos;
> > + *    position += parent_pos * (parent_granularity / region_granularity);
> >   *
> > - * ...where @position is inferred from switch and root decoder target lists.
> > + * ...where @parent_pos is inferred from switch and root decoder target
> > + * lists, and the multiplier is the number of region positions that the
> > + * level's granularity spans. A level that selects a single target
> > + * contributes nothing.
> >   *
> >   * Return: position >= 0 on success
> >   *	   -ENXIO on failure
> > @@ -1971,7 +1980,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  {
> >  	struct cxl_port *iter, *port = cxled_to_port(cxled);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	int parent_ways = 0, parent_pos = 0, pos = 0;
> > +	int gran = cxled->cxld.interleave_granularity;
> > +	int parent_gran = 0, parent_pos = 0, pos = 0;
> >  	int rc;
> >  
> 
> The "gran" here is using EP decoder's granularity, I think maybe th region
> granularity is correct ?
> 
> They're normally equal, but in the scenario of normalized-addressing auto regions
> they're not.
> In that case the EP decoder stays in passthrough mode, for example 1W1/IG256,
> while ccxl_prm_setup_root() discover a translated region at IW2/IG4K
> 
> For root target 1, this code calculates
> 1 * (4096/256) = 16
> 
> The correct region position is 1, a 2-way region only has pos 0 and 1.
> 
> I saw in v3 the regrion granularity was passed into this function explicitly,
> maybe I know the reason to make this change if I am missing anything there.

You are right. The divisor has to be the region granularity. Normalized
addressing breaks the coincidence of linux programming ep decoders w
region ways and gran.

In v5 we'll pass the region gran in from the caller rather than reading
any decoder, so both call sites pass the known value and the ep decoder
is not looked at. (FWIW this is breakage from v3 to v4, now fixed in
v5).

Thanks for the careful review!

-- Alison



> 
> Best regards,
> Richard Cheng.
> 
> >  	/*
> > @@ -1984,20 +1994,18 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  	 *        |    |           |    |
> >  	 *       mem0 mem1        mem2 mem3
> >  	 *
> > -	 * In the example the calculator will iterate twice. The first iteration
> > -	 * uses the mem position in the host-bridge and the ways of the host-
> > -	 * bridge to generate the first, or local, position. The second
> > -	 * iteration uses the host-bridge position in the root_port and the ways
> > -	 * of the root_port to refine the position.
> > +	 * The region and the root decoder interleave at granularity g, so
> > +	 * each host-bridge decoder interleaves at 2g and spans two region
> > +	 * positions while the root decoder spans one.
> >  	 *
> >  	 * A trace of the calculation per endpoint looks like this:
> > -	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
> > -	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
> > +	 * mem0: pos += 0 * 2       mem2: pos += 0 * 2
> > +	 *       pos += 0 * 1             pos += 1 * 1
> >  	 *       pos: 0                   pos: 1
> >  	 *
> > -	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
> > -	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
> > -	 *       pos: 2                   pos = 3
> > +	 * mem1: pos += 1 * 2       mem3: pos += 1 * 2
> > +	 *       pos += 0 * 1             pos += 1 * 1
> > +	 *       pos: 2                   pos: 3
> >  	 *
> >  	 * Note that while this example is simple, the method applies to more
> >  	 * complex topologies, including those with switches.
> > @@ -2008,12 +2016,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  		if (is_cxl_root(iter))
> >  			break;
> >  
> > -		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
> > -				       &parent_ways);
> > +		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
> > +				       &parent_gran);
> >  		if (rc)
> >  			return rc;
> >  
> > -		pos = pos * parent_ways + parent_pos;
> > +		pos += parent_pos * (parent_gran / gran);
> >  	}
> >  
> >  	dev_dbg(&cxlmd->dev,
> > -- 
> > 2.37.3
> > 
> > 
