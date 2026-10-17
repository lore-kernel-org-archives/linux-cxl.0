Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6A4CF477
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196398; cv=fail; b=AfhERol5tNKSLdE19LCvntQggVi9Vb1l08XsewVMwDcbxUXVDHA7BMmXPHbgQYWrWOunOkJN79ZlN9ZcQK7Fi7See6o8Ca7V4zBrp/A1CnyZwP1v+kUAXpEtGrncOz9LQDVBmXhTsApmpbAddLu3ZYqIdSrUFcZLhJtgVtS1/RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196398; c=relaxed/simple;
	bh=LKcAVrXdAZ19UL5R1DKsld5irf4QYfQE8dxqOyIp1b4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERY9b94YPMcOAeYsVKYIitQZ2vhFFayqh7wyikmKl/aVoG5PtwBWLlqy1SdSXpne69X8dXc/r4izS+UV04LJYf6GfFgBgyUfK+TDPlfwUlsLjWxbLxMb5bdIY7hrPByd2DAkiWEW+7L4oqh30HgVuMB3Ru/EwofV4Sw4FsX5TQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yw1FD6t6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yw1FD6t6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792196397; x=1823732397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LKcAVrXdAZ19UL5R1DKsld5irf4QYfQE8dxqOyIp1b4=;
  b=Yw1FD6t6yf6GKPdYMilMd9Xihz7W6/IH8EN0LmA48G7mW40axgE7Butj
   7BIFLKZrSjt+3ePP6CGoYtpAwlbI3kBiTCnnAmtLWWiadYG5YAV72L7tj
   34f2/5q8Yw4VlIqcOpOf6by1wo0jp0i4TwtovTQHSAYJo6wGjYvlEwr2r
   hZaljJEEG5AMzCuO34OQBJk3AvuIbIEOF55bC0bP0qhmG5kcuC4MNn+DH
   i6vWr2ad2u0a7JHLQemYXldM3mvpD+PUrW+/p6evWFRvELrmjcR14VOvw
   lurgkyiAjiQ/YI55/PZG/xd31iyhTOAC7HLaEEiUT2IYQMx/RvJGOEfXC
   A==;
X-CSE-ConnectionGUID: NZXXPmYESfWCzzn1WHUKfg==
X-CSE-MsgGUID: O4pHeHnFSR2i2FVWQQvEaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="885308"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="885308"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:19:56 -0700
X-CSE-ConnectionGUID: TYOfLBoHSkmuvV179Sr9fQ==
X-CSE-MsgGUID: S3euxI2NSCi8jrugnDSgwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2059702"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:19:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:19:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:19:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiM2w2euMGa9tsHf+zT3TbCeS/Q0hk6UkbBA8vW4WRqdGxkJG+lYS7Cwy4QFhTDxeHBDTR76ksXMG6EUVRAaoLjHKNDdcMntp/EXty2ErPCpMuU7ZsKg8YHyo5uDd7cO0gZzbiIJRYc7Pi18tKAowU7jokPcGa6D0bSLeFgzWK1aeKO+PH1JarP8lTGMo2oHt6XMcoLjTwCuC24XeC3qbvSmQE/l16T37Ihqb5WinJPOk2zEK5qiT+tzW33wmg3X7/6d+IpIqm9IW2thIWgevxOEzFSu2Gw+9MAsPxrkbh0IN0PmhYCuevfPkCB4uXvOqvhNVVqAgEJHdqQr3ea5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caA5l4apB/zj2PRpOqdcH87dXEfgCrLXBRDpNbMMZVI=;
 b=pees7LGdm0r7O47W9yx7Nh8sBRGbtdod3JEYpWVC7shzo0PR8jj9SPyjwo7OwDZ/iMBQuSNCNuzgtHjCYbhd1XCy9yunZz1b8hjwGKBGieVgHEuBfPR+UgzMCke7SRzZ0/DrKgr7sIYRi+jkCOkyh+Q+YxuGu4qhtvHrAbmf2tqYamdYl61wKo4o4d34nOPTXax5ofaLnEMO/wapp0xxFIVIcayOaN7Py4T+FrkGioM0Z3luv4dbnoQ/OasbJWkHvweXjdfhF5/m4tEBnir5Oe1DjQpQSGwKrMxJJqtan+UBC4+s6TsW5RoYWS5BnQ2Gir3QcTNviVGvwOrdsR7RQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sat, 17 Oct
 2026 00:19:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 00:19:52 +0000
Date: Fri, 16 Oct 2026 17:19:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] cxl/region: Factor out
 cxl_port_parent_interleave()
Message-ID: <atK_HlWRv_-gTjSn@aschofie-mobl2.lan>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
 <as9IvZJ8aAU71yxY@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <as9IvZJ8aAU71yxY@MWDK4CY14F>
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8fcb40-a4a3-47cb-5d59-08df2be45cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261009223027099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2/cohcl/kxsE9ASc2MEyJhpnnX3ooxO2bdr1CU2YiGsFK4/EWabuwizQkcEio9m02u5k95XCUO5eVjVvU4+z/bDVsD4w3sThtCQUdCckvv5OL1bBSWBuRHN4GU+X2j2pPkdiiueGKXBAMV+TfgaP2Y/hhOReDpYT7QlttZGMRseObU7nsXpMUHVpccSwwivBegQFERJcgus1j6VCNAghS0Cg1DnknZY/PHputlmKLBxiGYGJ3YkIz9ok+e9eOmgC49dHn8Rf5EOtsTfaJG2z4lqIPdzBf25LYHVkiake6RUoTNO/fgut1igK7c5jek8oO2aaSfZso3XMe8Ixj6636WXWWQa1hdvwy1cvnVBSAiIV8u9W5YVkrwt7oDdE0XkvPL4sZXk0CwhaJnzcynKRZOi6ZczPvzY0THm3QVfwaSqevvZzh42USgfB3V2RI3NwNSSQtsribR0qsL6AAnX3VPimBfe0i3Dnhym8X92lZMZ5QOg0DdoO8DoVO9kjtXu//0CRNh2sFf9KQSwqeZSyCOU5Z+QYkxSzKZLChm5OLBcheoTV5lSeo3r1W9K4ZsEsRHaswSdWZSuhVIHoqGklXIvGc0z1mTlvNRBABFtMXZzU4q87jtyJnZv0HTNoMb/Nb+YgG8YvxoBo1ZxrOzMs9paJ/kjap0coCrnQ1G6dag0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261009223027099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HvYFZDdn9yOa1HcalS3ozS8LrtAcYwVSUysC6f2Fo9Eu2k4tb57QZ58/fdzj?=
 =?us-ascii?Q?d3GecKTYzAz8IW1tPURrXfdZD8Bmxpnj6VYR5vmbrsYn/xupTPRKPucMBnc4?=
 =?us-ascii?Q?BpAs8MkZk9fA5KrfncVSa4768elQL9YXSF7dR8NDqJ4vWrUUYdER+aE6igsK?=
 =?us-ascii?Q?Ux/gq/Mrs4VeHi/2VQv8HREnR/1HyQR7JmpCQW8zzHLdeySa2My90nIvSUDl?=
 =?us-ascii?Q?uzOZfKtrr9i3GUdkR3znSq0BTOWpiOMl+hfToh0V6lJx7YFLbd6Ypvq7gUy9?=
 =?us-ascii?Q?WsqDNDGzLqrUQJSLiM08fLvyX6o23B5gVCL77o4wb7Hk8ZJC49wUrA9I4ks4?=
 =?us-ascii?Q?2svJn3mxpKD1O2yUzik6mN+Bw1CtrX05zGxQrkHT+QKnP6gbwOCsiCET81mP?=
 =?us-ascii?Q?Q0eEXOoq7I9/f2hE8KrlPwvQWoZNNVKbuRplW8/YVimoWFosQT1AYbIL1E62?=
 =?us-ascii?Q?X3+PmGRRualT2Legdr8uQYVqiO0aJ/G3YKfLTMsVjORxQkvFXT6XmK+J1lxt?=
 =?us-ascii?Q?8JR/sishF7ljf66t2gbyBVopqw/wrar60GkBWkuuacWRl4zm8llMyEanbONx?=
 =?us-ascii?Q?qSrjmCpAhQZglrdWUd5QUHmMdBwFuJCjGrCnYYuPxi4LpYIfbdyk1wIaqZ7T?=
 =?us-ascii?Q?+WKIP/Z3SnfEGDnXI+2VUkgErGcXy9yVjLACNyFpLwDV1ZS2u9TOUk9EHyLe?=
 =?us-ascii?Q?htkhWmPpkR/Qwa381uOfq/eX/JOe8nl6akBei/OKjs5wCS4uCuWVZqUKvHsF?=
 =?us-ascii?Q?MRn5/D9b9/C6eYsH+rAYZK6I/14HH7q/QJFxDDRTbAZFiGz5ArR8waeYPBKG?=
 =?us-ascii?Q?HgDXyG3ciW7O1daki2fofGGg2Qh5NSO5oHRK1U3LJm9UR5HOT3I71CNf1JXG?=
 =?us-ascii?Q?dpoaav2QnjztMdJxHl3wnauDyvsP6sGUc4CjDHUnVZx7j8q9qqiQlcwvHGgq?=
 =?us-ascii?Q?Nma8RpUn0kga1tax74RxSFrq4gu90DTlRg9tOfUC3IYRNCXRePK6m2pLSTIx?=
 =?us-ascii?Q?50A7LWMaUnysH2ava65SLCWkhQPsVvHyi4HeNdxF7VkX9/PvOR9P4Kf+95uc?=
 =?us-ascii?Q?fjKO/zMc3Ao2y8cgiGjHvotaK65MzS+DxwjotRebkXapzBb+stEb3TZp8M0L?=
 =?us-ascii?Q?RoyMR1RCXNpBKiV6+zppZ6lO1/STSBj5KM5W7hFS4KZAhIQfo9tA+95kfB9D?=
 =?us-ascii?Q?X+r5u1DOmIqYlMitVZf616xB4ZlAlYg61qpMk3S4TS3WmsJqD7+s/oNGGb6M?=
 =?us-ascii?Q?ynNmLcUUBDQ7z6IRxHoyI/8L9/SHGJwsl+mqX0XFi6DOKW9IUGivS2pY88Zk?=
 =?us-ascii?Q?PwuqqAMR7R40w+ZAwYdi8ptIfIlpWamtooYxl7Q66J9a9h6tphFsD6GPTkBa?=
 =?us-ascii?Q?I/0u+9w2qhDqS/SErH0llv3Fib+NnLpXoNPMtWzZkDDmljMv2jTi8Kln+BUe?=
 =?us-ascii?Q?/2W+EB8wAHPKFxSWqAoNlaZ6RsrCa8QC7eCPwUQNxCVit12JrnK8yrienKZm?=
 =?us-ascii?Q?XCGioEEwzytfQqyKKDsOO0s8yam9q+utOrSr6bo+hq08xh/VZne16Cpyv8Le?=
 =?us-ascii?Q?4XpVOVwaxGWzSdem2jlCXz1jAp/NnJU+GnL1gEtDVq3An27zitpM/E29XhbJ?=
 =?us-ascii?Q?ZIz4Og9TBOpyGlt18Hu78qv4J8O1gMQSZeThHFhev2ICTtRnY3C9IbRzCYSv?=
 =?us-ascii?Q?N2RgQSPkVUyPTaSMqLmhIm2X3ij6AcqimmA5XZbEIYdyl3lCoisNOnIAnJbI?=
 =?us-ascii?Q?28C08vOb6GOSJGJux2aNZQKw9cmHiSU=3D?=
X-Exchange-RoutingPolicyChecked: yOaUJW4rOSM5kujHO68+wd8gdqwOtOBU8ddVpbw7Ulu2fzKB2pwoH3JYZcbuDiOKd6hGQLNPYAIBqRUBuwSBDQeD1iSdOBFTMiVKgFrlgA8L2LifnYSqOl5FSibLxg82UahuysJbE6DjXgd1QQ1oy5c7Ta7i9AWXBr6FKC0I/53nvxeIQXtjT3Uwn6q61+WPrDpM5p5dMfWKXoZDzzABSRaGyz5AwhoCZZJoAZIQmnTGJz8yX9nZh4g5w6M22pMv46ku/6vD37c34OQIRqWUcGIWh997NOKWpd9DFnx66p/tg6CY+6b/rbKQMxymTKoYqYe1iv/sAkQt2HnA9yszag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8fcb40-a4a3-47cb-5d59-08df2be45cc4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 00:19:52.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjZdm517NVOGKueBSoVY4LEP+MseJKJ+6TSgw77zGBxNLMFH7OwGgBIdtafWlLC6CSrowX6LNy6/r+Mss3j/LS+F2ANktEQ7QyFVV/wLSlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

On Wed, Oct 14, 2026 at 05:26:21PM +0800, Richard Cheng wrote:
> On Mon, Oct 12, 2026 at 09:26:00PM +0800, Alison Schofield wrote:
> > cxl_switch_port_setup_targets() derives a decoder's interleave from the
> > interleave of the decoder above it. That parent interleave comes from
> > either the root decoder or a switch decoder, and each case is open coded
> > along with the parent validity checks.
> > 
> > Move the parent interleave lookup and validation to a new helper,
> > cxl_port_parent_interleave().
> > 
> > No functional change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
> >  1 file changed, 52 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index ea281ce4ec49..c14ac041c4ac 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
> >  	return distance;
> >  }
> >  
> > -static int cxl_switch_port_setup_targets(struct cxl_port *port,
> > -					 struct cxl_region *cxlr,
> > -					 struct cxl_endpoint_decoder *cxled)
> > +static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> > +				      int *out_iw, int *out_ig)
> >  {
> > -	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> >  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> > -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> >  	struct cxl_region_params *p = &cxlr->params;
> > -	struct cxl_decoder *cxld = cxl_rr->decoder;
> > -	struct cxl_switch_decoder *cxlsd;
> > -
> > -	/*
> > -	 * While root level decoders support x3, x6, x12, switch level
> > -	 * decoders only support powers of 2 up to x16.
> > -	 */
> 
> Hi Alison,
> 
> Can we make the comment more explicit ?
> For 3/6/12-way roots, the helper returns a normalized out_iw of 1/2/4
> rather than the parent's actual IW.
> 
> Maybe we should document that return value convention ?
> Simply browse through the helper, I would think it just retrieves the parent's
> setting.

Thanks for the review and good point. The normalizations happens in the
root decoder branch of cxl_port_parent_interleave. This diff doesn't
show that because it moved unchanged. Here's what I'm planning for v4:
/*
 * For purposes of address bit routing, use power-of-2 math for
 * switch ports. For an x3, x6, or x12 root this returns parent
 * ways of 1, 2, or 4 rather than the root decoder's ways.
 */
	if (!is_power_of_2(parent_iw))
		parent_iw /= 3;


> 
> Not a blocker though.
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> 
> Best regards,
> Richard Cheng.
> 
> > -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			cxl_rr->nr_targets);
> > -		return -EINVAL;
> > -	}
> > -
> > -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > -	if (cxl_rr->nr_targets_set) {
> > -		int distance = cxl_port_peer_distance(port, cxlr);
> > -
> > -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > -			if (ep->dport == cxlsd->target[i]) {
> > -				rc = check_last_peer(cxled, ep, cxl_rr,
> > -						     distance);
> > -				if (rc)
> > -					return rc;
> > -				goto out_target_set;
> > -			}
> > -		goto add_target;
> > -	}
> > +	int parent_iw, parent_ig;
> >  
> >  	if (is_cxl_root(parent_port)) {
> >  		/*
> > @@ -1539,6 +1507,54 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
> >  		return -EINVAL;
> >  	}
> >  
> > +	*out_iw = parent_iw;
> > +	*out_ig = parent_ig;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> > +					 struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> > +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> > +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +	struct cxl_switch_decoder *cxlsd;
> > +
> > +	/*
> > +	 * While root level decoders support x3, x6, x12, switch level
> > +	 * decoders only support powers of 2 up to x16.
> > +	 */
> > +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> > +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			cxl_rr->nr_targets);
> > +		return -EINVAL;
> > +	}
> > +
> > +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +	if (cxl_rr->nr_targets_set) {
> > +		int distance = cxl_port_peer_distance(port, cxlr);
> > +
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> > +			if (ep->dport == cxlsd->target[i]) {
> > +				rc = check_last_peer(cxled, ep, cxl_rr,
> > +						     distance);
> > +				if (rc)
> > +					return rc;
> > +				goto out_target_set;
> > +			}
> > +		goto add_target;
> > +	}
> > +
> > +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> > +	if (rc)
> > +		return rc;
> > +
> >  	iw = cxl_rr->nr_targets;
> >  	if (!ways_valid(iw)) {
> >  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> > -- 
> > 2.37.3
> > 
