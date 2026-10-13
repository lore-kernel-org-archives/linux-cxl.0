Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804E374E5A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865407; cv=fail; b=caU+H+7ALWsyNXs2zIFsQ+Ub4frj0n06BvtgDGmj6J4gG+rzVUm321be/XVEJl6ljFRM2a1YaL1xG9y4t6eY+h64HPK9Xhr3MVAPWSp0nFo6b2SfxuT4DUNXwHn0z7y2bkNI62Rr1C4FVzVGtiqjDWthHdSJ9bX61EPT6FVGeo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865407; c=relaxed/simple;
	bh=kxmMfnSFlwWW24EOpbGAhm+w0ydS3a8MHCDv8NtIzg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tcS2nOX2ysyfVBubdP6ozwuEo1ywtL4cU39eRBQN6Wiv4UwJpZlcyb079AG22vjEkKRK2mJxPynZyODHGB1mQgRrxhlf8PxkCLnhNLqXm1KQaxdS490uhv+GNJie7ndqkdMy+GWE1fCJ5L8AAcjXUWY9KpzZoxwv5SgRunQHM0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6dsCxSR; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6dsCxSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865406; x=1823401406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kxmMfnSFlwWW24EOpbGAhm+w0ydS3a8MHCDv8NtIzg0=;
  b=k6dsCxSRQh7+MYvW7YSHJzug0Jkh8otunY0cSAhzpBTcNnauOj+Ni9Pw
   equX0FPHuh5huYCmu+EjsC/2n6F3KMLX+KltqQsqof2Vcs65ymt/AqDiB
   65okqG2yVbhOIz+UAeNto5Vc3J+q9iVQxwCbapIGDXomD+4iqa+2Kn/i6
   Vi87Q1HmBAJScoN7ta8t92u8ny8zHOsEs6fx2es3jQSD5ObXHU0yKC6k8
   zQ9cQ7sVG8GFtHGDc+BGc6clAo09yq4zSg1w/EpsiObwt5MTL2WjgZ4Fm
   5pahGf4nZaA2/YnYPRKOKqWFBY3PBEQQQgM4he0LB6Dom3gMTbef6dn6q
   w==;
X-CSE-ConnectionGUID: tsbdISOkRYmytUqvzH7GZA==
X-CSE-MsgGUID: L1ajBbh4SXGhsdJ3JxKe/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="467720"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="467720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:23:26 -0700
X-CSE-ConnectionGUID: VH4vzRQNRHuj2tk114BbLw==
X-CSE-MsgGUID: CmVSQl/wQ6qFY/RT6qMieQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1114529"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:23:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 21:23:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 21:23:23 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 21:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IILa18lbVYYxxskub6GmodJmtmx7aCvTZx0e+jk7dndjCcX5ydC3x1uJxrHAi0x91EroLuCLg516zY4HQXsKjRWQZhe7fh7+MFWOoY+c2ORxNOG5Xu+pEVDRrn3g8hJfjJAEQoBPVy+OdSEZHdpyY7TFw6OHEVnfI7/d+XJtGsOmjlqK5ces4i+sKuTcu8FCrZvqqOgkiLvU7lnPfRwX0BUlgSr4OJVQOkdC5ZWueFf7/Ziki0no9qi0dQfSDubuQyFW2igUkw2rjcJ7UCY7Z95ivHBY58RDFfBaqcZ6Hp+4hy1JlOjPiP8b1PHOD/cZpW9S3Noabr2oUw+4PCinJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HP0j5bqd04hwtj2b1Ka8Bd1R6pNKHHF+Bo/b24eXhE=;
 b=M+4wjOsuicIduXdSu2tSFGlELDDE2JJvoqA5Rl/d2qedreX4m7Vula67M6+7+rmyAmezuyQksh8GNzt2MchlSWbpvS43Ii7bbBTyo3Elg+eiA2jjB1V41sbWgnzTFJUR0pFfvubkNcdBVwPOa9vpA5a3y/8wYF+hje/RKGyB8XUCLPQ8iZhoDdoya63LZTtZ48I5d4Hh3ucGSmtUkO8+puJ5ptoBLK78cLcKI2+JFwbwPun8Y5rXRlvqxOEj9SpmL1T5eSHXGLlXc9K2lAte80h1orISy0JI70M3qmkQwXX1cxVgGWy2mpFUaKWU1CrxAHKDTISuxGexFbnIXvfn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB9875.namprd11.prod.outlook.com (2603:10b6:806:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 04:23:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 04:23:19 +0000
Date: Mon, 12 Oct 2026 21:23:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] cxl/region: Factor out cxl_port_peer_distance()
Message-ID: <as2yM8ypmEPaBBV8@aschofie-mobl2.lan>
References: <cover.1791676454.git.alison.schofield@intel.com>
 <dcbd67bd2059beccba1aaa92ea099ac35dec9026.1791676454.git.alison.schofield@intel.com>
 <20261012161647.4fe1575d@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012161647.4fe1575d@jic23-hlaptop>
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c40765-c024-4282-ff3f-08df28e1b5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ldMQFEDZ7wgQhtKs0SguHOPF2VZMCE4EQZIcsMlkJNUxXGLjsz58Kk1NY20P5uKSNUNz9dXNyrUi+Z4up6CZEHW83fHl36iZI8gu/cdJSusW679YegJub2xuzw2eP69d28wgKA5ZQGUGv396kc0MrblccyrlRqv5lF6+bnhnKcmM+brsHzKCaf+EaxjjxX1Ke9l0zwclStBA22b9OPVZmd92AsRSOWNQwtLUFOktkLOlabPnWO2e4PRB3HfIldGxhMztnYkwgBnYZIF3A8MsJsgKhscCbcZLdu4x3S6BDoFrKZNwdQNoLVTex9wr6KqbOYG/BuFqwP8y5bL3FgrenoHJ8eOUDdJkFYP/YmAqtD/MR9Vu/hrILxAGBmC/ULSPiczyxhjJDOWwVw1T331veHNmjCUJmdBDpNkD5gczxM/FlNhxEdhAA+HlbHbwl22RDgYImQmbC4srGL4CCb0yGqQcq+sFsUHQTOZGNeT+damcWd/40Hgsy06Yn+CYSbTPzUHz44iNZ5SxjG/deWXfg40W34usd6x42vEEDUHhzw3qPOXf8iJ4riQkBCjJi4bj9+H3RUki3bUlhIomt7dFwhaJNvVG+zgFTPQCzn42HBndjt/kgFS98aP2WFlu7ISeJDPNN/giGfpG1Hz7cCJWw6uYFdbwhRAY5Ja2EMtaxts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gURP95TmyOSDmkDE2NPbMdNg198q2axIotOSzHsedscnXe1ZVh4YroQjLdDZ?=
 =?us-ascii?Q?SQjOCbua7iTSBJZzPCdX6hfsdZ+hvrQWrF5PV20agzfqTSoGmOWNZCvnIB0k?=
 =?us-ascii?Q?ZhBCie8YEovRkfzyoimEI0bVFvy5UretmLnV+wD4mDvjqbhEWBRzxKw76Wlz?=
 =?us-ascii?Q?bNR8kZv93cbDpXXUIoaVD11UBkDByUQSntQkifVQdB13vLT3FANnPgnMuQ29?=
 =?us-ascii?Q?UsZhQ7ciowHy/mvNVXgkhFPbiXVlRXaaVE6NkVBphR96jPDD0OvWAfkxeplU?=
 =?us-ascii?Q?aBF2ktxi7shCanMw3ZKpk0OWqRp6mw+lIXoKKQwV57n2OiofY8vq/FFfrmpM?=
 =?us-ascii?Q?9WA0/WddiRY5CjvZ4EAKZxNQISnsYgjdMnRPBAQ8esOiaK0baxd/W2UERInq?=
 =?us-ascii?Q?3CJwNQoHHyCn2DaPoinm3y32W4ujBUUnwcZnGi8GGaiRYPGkdvWg6dH29oXI?=
 =?us-ascii?Q?DOl4bF+pkG35wR6PXKwyF7DTJASEDq52TbMB789PrF8DVxWh/jJvyGWxgNaR?=
 =?us-ascii?Q?TTNMxu2JE349Iqf8WKemUavh+S3zkkIb1e/pdz6OzdRRm1pijAntj47Oofj9?=
 =?us-ascii?Q?befim0ZjYkW4gugbgywuXQdU78wsOekHyIyQA4XKPQYO90dv4Y0ejYONsovG?=
 =?us-ascii?Q?2aUW2HZ15y7YJaL7AMU5oGfx4fIB33CtfJ8Y1IsCoRmHqLqviI11ApfxPFv9?=
 =?us-ascii?Q?i5ItYzSKR5yArJAoAgVP7Z1AUtmORiJZsJ6U2Nn1ntWum5VPigdT5CiHw5kl?=
 =?us-ascii?Q?4doZNuslPoaXRspSw+XnCIvpw9zHUHxD0i/ZnLT9gPU/KODXBY9cmpcgvLUs?=
 =?us-ascii?Q?I+AzALhm8+Pe3cWki2YW0BvnbpJnX2NxLHV13R+Fds6ZhH4suv9EwynBTrP8?=
 =?us-ascii?Q?8zCWvzn0/sIA1OrOyku892U5wfkExMZB8zuebT4eXC79ktc41YiJoB91CLwQ?=
 =?us-ascii?Q?ET8jIXa37BWoH6M94589f7RED6WPdvL6kxgVKXGiiuvxPwtBoGvkuwJXgOe/?=
 =?us-ascii?Q?VXN4aaXyDAk9m1gNYTEPogVp8UbE1pzwWDa0NZ7XBQ99tgf3Q95ZgTUJdrHJ?=
 =?us-ascii?Q?tWtSVEvaY7uib5pzo+84I3diZa8juy+TCXc3uXDk3LEv7KSmsMkfirJ7/B8r?=
 =?us-ascii?Q?IJjT1oM8Zr8zoigwHhm4YVLE+/DDtwPndvwsJkMlX//AjBWT61hQmJz4srbD?=
 =?us-ascii?Q?j/+Qz/Qs8L0dwa9m2UAVI4T29alxOhmLTPpaWscrbKKxhzWLsjH046B3ttkA?=
 =?us-ascii?Q?RpX2T0cukeVDcLEV1vsFGDMyOHbp5BwDvzIu/1/8rA/t/jwVJMP3EtXK+M2i?=
 =?us-ascii?Q?F8kuFQf7AIw4h90drS6w72MUzv9V4pWQiiuwqF3YTE+MLZilTcoUIcO147Z7?=
 =?us-ascii?Q?nMxO6Ywzy87d9AdWDAvf5fgFIp1w/G2d7vnO2eRk1NVzATDSP0tw28TF+eXl?=
 =?us-ascii?Q?T+EKoXWnfVr55dklP0BoO651GoKHRmDZ+DGd6dkrq7acF+xCUvEyfpcqyo/x?=
 =?us-ascii?Q?X4rJ8G1eB4eBAiwypgNk26J4mYsfFNdLZKnflVTYVK+N2SKSxI/rsKzc4dLw?=
 =?us-ascii?Q?nPWbLxbi/zyenZ2cNNMub8kFGWeJsHTJKqpAHJ1XFsIUjTUvmrQ39Q1W0ZKr?=
 =?us-ascii?Q?tfCwX/VxcxvwREwrQBtMQpDRY8sanSvc2TfMHAgmRT5p7QC52s1otcVwXf+t?=
 =?us-ascii?Q?fADkxg5pvUwjBMJE/jMXEOzS8rMTLaWJD710iNnKEdtFVH4E2gp2nRH1b+gg?=
 =?us-ascii?Q?cqCHI1YJme+q0Kqh6x4lbYvm5bAdVaE=3D?=
X-Exchange-RoutingPolicyChecked: XvwahfvA9GOy+q9V7bcsW0njmRtED7niE4YyGX/R/4maupRlBoLeKc1s6NZj+NP43w2Yxd65NKvddsTpt+988eYCW4tdQxRnIgDlH43EOE8e6BuCsZLFU7hy6P77f7vyS0Rx5CqAekzEKfj7Di0an0UnfnCvWt8jkab0azztPD7bRzGUPrI7fMMCT8kpf4DSU+l3VyylWNhQ2+YtBV7gRxHId3Jc+vfcX4rNkb/q2klQ0hV59/tDwjU5CuLY7jaW4687TUSdIkPlYoEhFqrf4bvVvlYUiybOCYaW1L62xi1KpaE/2dA51eQOj70YgZcfiO/2j/dn/ITMXjHc/CihEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c40765-c024-4282-ff3f-08df28e1b5e5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 04:23:19.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEmq/dUrprYGYk93MCxUFYxdh1MFohkXyez74HDeXpY88QFiQu0LAyh4Q/+cNJUV8acCmvIPFpNuBBKzxBOfe+cyPyoyv/yEPwlh+9j1I5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9875
X-OriginatorOrg: intel.com

On Mon, Oct 12, 2026 at 04:16:47PM +0100, Jonathan Cameron wrote:
> On Sat, 10 Oct 2026 17:20:19 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
> > each step of adding an endpoint to a port's decoder. One of those steps
> > calculates the distance between region positions that share a downstream
> > port.
> > 
> > Move that calculation to a new helper, cxl_port_peer_distance().
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> I wonder if the docs make more sense made function documentation rather
> than inline.  Either way lgtm

Thanks for the review, and yes that docs make more sense moved, now that
it's the only thing the helper does.

I think you are partway thru reviewing (me being hopeful you'll review
more ;))  and I've posted a v3.  So hoping you continue your review in
v3!



> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
> >  1 file changed, 29 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index d564443a1d39..b288421203a9 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	return 0;
> >  }
> >  
> > +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> > +{
> > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > +	struct cxl_region_ref *cxl_rr_iter;
> > +	struct cxl_port *iter = port;
> > +	int distance = 1;
> > +
> > +	/*
> > +	 * The "distance" between peer downstream ports represents which
> > +	 * endpoint positions in the region interleave a given port can
> > +	 * host.
> > +	 *
> > +	 * For example, at the root of a hierarchy the distance is
> > +	 * always 1 as every index targets a different host-bridge. At
> > +	 * each subsequent switch level those ports map every Nth region
> > +	 * position where N is the width of the switch == distance.
> 
> Maybe promote this to be function documentation now this function is only
> concerned with finding that distance!
> 
> > +	 */
> > +	do {
> > +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > +		distance *= cxl_rr_iter->nr_targets;
> > +		iter = to_cxl_port(iter->dev.parent);
> > +	} while (!is_cxl_root(iter));
> > +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > +
> > +	return distance;
> > +}
> > +
> >  static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  					 struct cxl_region *cxlr,
> >  					 struct cxl_endpoint_decoder *cxled)
> > @@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	struct cxl_switch_decoder *cxlsd;
> > -	struct cxl_port *iter = port;
> >  
> >  	/*
> >  	 * While root level decoders support x3, x6, x12, switch level
> > @@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  
> >  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> >  	if (cxl_rr->nr_targets_set) {
> > -		int i, distance = 1;
> > -		struct cxl_region_ref *cxl_rr_iter;
> > +		int distance = cxl_port_peer_distance(port, cxlr);
> >  
> > -		/*
> > -		 * The "distance" between peer downstream ports represents which
> > -		 * endpoint positions in the region interleave a given port can
> > -		 * host.
> > -		 *
> > -		 * For example, at the root of a hierarchy the distance is
> > -		 * always 1 as every index targets a different host-bridge. At
> > -		 * each subsequent switch level those ports map every Nth region
> > -		 * position where N is the width of the switch == distance.
> > -		 */
> > -		do {
> > -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > -			distance *= cxl_rr_iter->nr_targets;
> > -			iter = to_cxl_port(iter->dev.parent);
> > -		} while (!is_cxl_root(iter));
> > -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > -
> > -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> >  			if (ep->dport == cxlsd->target[i]) {
> >  				rc = check_last_peer(cxled, ep, cxl_rr,
> >  						     distance);
> 
