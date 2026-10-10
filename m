Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372A1A9FBD
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791592408; cv=fail; b=gxifEXVs1Fy12hVZh/9zRUns2ZgZGaPDI5OnJ+8zafrmek3yBn+YADOq/J0AwLjCcG0lWDfXsfFF63nyXIzT8HnweC6uEB1I7+AjxBpycFnZTvMlhSf+3ESr2crrX7Os8o52rxDPYtY6ef/m4he/NGV5jd3lKAucplmESqBmrY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791592408; c=relaxed/simple;
	bh=a2+ksKrkkSE8pagOauR1vPJq1nEz2A4nibfm3yyIgSQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvxH0/fiC1W3bNA/f5l7EN3F4ItghEl/OAZfCKYuViytKM7VeA1s9OiI4WD2y72/rpipTbqha4hIs+yA3OEZF1Eo0qOQqoFKRujvgoJ6TzrP76K9bUyww0f8gNwXg6yul1ygEoTr5mxIfr7/2bIf0w1WGvDHy31araAEmpm9S7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUGK6AbR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUGK6AbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791592407; x=1823128407;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a2+ksKrkkSE8pagOauR1vPJq1nEz2A4nibfm3yyIgSQ=;
  b=cUGK6AbRJh5h143HgHCLqqW4BfE4jGY+D4UWfb0u50S1kJF8kpQCk6sw
   QTWDakrCZhZs9zBCFOALALb2yYB5cGLOu4MNjJu7EwWOtXPXOvnbEbpXQ
   i88TlqR23Hx/K3Pgk15iZQ0cL9jNwvPP6A2DDHvEdK2te9OExbYm2mpCl
   eaRwGf0xvoB4FohKS+z5XbEO5/N3Zc6dOsvCzHvlryQQRErki27eOackh
   78A/GbMrdiUagEZCgmFOOjZbdkN/v8z9gQuUUgcVfn1z039Wr2iz0OySn
   6whl1yI87o4kWaCo3yCn+Drp1panDFaGn/Nq6nxbbfFw2hWG/Tr+zbtmq
   A==;
X-CSE-ConnectionGUID: 6ymMjhZbRviw519vHSK1MQ==
X-CSE-MsgGUID: 1o3ACJRVQDWSXgKoR+IJZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="422428"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="422428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 17:33:27 -0700
X-CSE-ConnectionGUID: vr2t5Tr+TMG5VI9YLwjbLg==
X-CSE-MsgGUID: MFBOHayASJCBiJHDdfih1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="420338"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 17:33:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 17:33:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 17:33:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 17:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxUWKFSuuZqRCwU0fKyImZE0gaTkHV1SxeygKxivmGww9urNN97ibQRRVN4whLJC/5txAsFF2DXudaHCHCSxFzHPlDtNWOjMIKMQVsKwr9Wvtz4Rh7rEqSbCI1BDLC7Z6CH1709ak7S+nwRVCZqEJ4ovtFwj9MFp0foWdn+KAJVGOYRaSXbZCx+8ZGw69TBy3CiVE0tpIQn1P/ShzHj41jkgP1tWP6glNK4qVhsV+IRiH9z25o+KZdn8qyNXFHEKY5xGVrOyay5ter3Qw9erYwEmCo87huwtdbHHK4sYN8O9C+BdLdO1Kk3uqGjJjR4OUw8IwZ/EfK7fuxuoVS2jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CRH2qOuGWVgcmEMeAo9DQsQxudfs7hbiMLrQ68QhMo=;
 b=hVtht7Ik7KfDktujLxZaksnFONhYU1bsFXuIZMPnX8Z6gyHCsOHlmRaEtfczXXAjsuHHnIpufAPd8LV9HdgFxuXVnB2xPfL/8jH4bja3l+Gth4xaFPYCzUgC2DCjH2BJqHZ+nK3lgPvq62RLxJFXfHZJwniJ14ELIDg+4yeE08Doj9xy/nrFiIEIrmyTvq8g8BlTiS8LUQ4bCfn97D6llPzx/92bujWU0ac8ou2GNw4QU8cixtd35SVG5fMV3mf4hRICwVKBNahqhs7jHxc4pEzZptSRZC7jhjHMOQ23xRGzKuu0hA3FWBq3UJ3z9r+8BynyzW60aTgmG28X4MM89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB8891.namprd11.prod.outlook.com (2603:10b6:208:56d::20)
 by IA3PR11MB9208.namprd11.prod.outlook.com (2603:10b6:208:57c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sat, 10 Oct
 2026 00:33:23 +0000
Received: from IA4PR11MB8891.namprd11.prod.outlook.com
 ([fe80::1128:c90e:54:e8f1]) by IA4PR11MB8891.namprd11.prod.outlook.com
 ([fe80::1128:c90e:54:e8f1%4]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 00:33:23 +0000
Date: Fri, 9 Oct 2026 17:33:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/7] cxl/region: Factor out cxl_port_parent_interleave()
Message-ID: <asmHzq9In9P7ZcOV@aschofie-mobl2.lan>
References: <cover.1791575481.git.alison.schofield@intel.com>
 <e0d73b783d15ef9bc39481934c86bd915be9c98f.1791575481.git.alison.schofield@intel.com>
 <e54ca303-18b7-46d0-b02d-832cf900651a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e54ca303-18b7-46d0-b02d-832cf900651a@intel.com>
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To IA4PR11MB8891.namprd11.prod.outlook.com
 (2603:10b6:208:56d::20)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB8891:EE_|IA3PR11MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 558ccac0-d81a-4515-4e71-08df266616ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|261009223027099003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y49WeakMNvrfHwYHYHX263SWX1aIJXSUloufpuJ8q+joPm78Ir++QcbraoYj6FC1QNTfgBJW7Ij10C9HvVr3pY2AOCMIJNBPWCe/wAA/aXtVsepsNc7Uyc3mNVGZOuYEVkkyGTTIIgczxRwIOOwklX1gmWeXGTMrdf683rrcY/v54sD4shtOvnSrX2hDk3r+fnkXweJFtriya1DsxpDB0iHmCrXWWl6vblXh6hiL+rhZOZRtmwvuEQyMtfxslLSHWEc5ebqjZs8ueHbSTr7T1Yz9Vv3WYfRc9QV9hrmdEkksQMGiNw9+AB0hyt20u6pUHievIYCaUSQKHuc6P7bgjrnBhNLrN6MG7ZdxSCqPbbu0b8Q7EJzo5tRAwpaXLHtE+eEtpBhlEfW6E29f/ziOPiz8UxS8RMCouOtzyh40yZ2Uzb02JzMORUunEhr/saqS6ET9ofRwq8xZjRlu7uBelfJ4CvYv3iuomJCws/hO5DYS9tyJeNpMLNaIOFeia3LshAfVnUc0qp3Cn4mlxxlVjWNwi1/tjoWrfyrq8zcgtZeXpVAfQpU3aDfEC4GlCvgLODSziX2Egpt+a34NY5jwoCJCIl7kZC6dxPIbgxRm9K4RyVKyY7efkSsnNcgWhfzRVAy4Ie1TqUjRS5AtU8abmH2dQW6Ajz9je0Mt2d6C9SE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB8891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261009223027099003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQbOOHjbkjea26u7dOsFvi16/khZaU1dreOkECsl+9B+/bl27GXCTEjEyoD/?=
 =?us-ascii?Q?5kvRXCgB+EaUKky8flgg6PCq+exzPmTttHf0qZUEEhr1koQsWj4PymSKoKfN?=
 =?us-ascii?Q?dGkCb5nZmoNTafSNiZEpzMlNYHYp8x0bR8ooq74ZDtDTh+cwKSTOly53zteP?=
 =?us-ascii?Q?SGoO/H3zT2uf3uS3DLMQ/uqg1bcF5ZP6vLHK5kHAX//xt033tMzGafvuW1r/?=
 =?us-ascii?Q?ED0Wa4qLeHsXRj7U5gHv8H3EbbEvSzstk9ELq54bXJYvxY75gtTiVKQAnxLK?=
 =?us-ascii?Q?pVvnrsLzL+KDTT3ZAexCk01E2Bcyeil443wMmJnn+Cll+AfS4hwO3pHIfi2C?=
 =?us-ascii?Q?w9saZ7piGYaCJz8VRueH40IpRL5u1jqEySf5vU/GIhiWhn+OJKCw9w8l32xT?=
 =?us-ascii?Q?f557Xr0sF/4j5psXQpxz/iGtQahMR2QbH/wQtXlBlOiRD7BoRDc41Fk8EkBp?=
 =?us-ascii?Q?ldgnQAM3Q63+BlQDpSvg6A4puf3+XKATG1UvYKyDtku+NRGGIjtYNvnAVZVU?=
 =?us-ascii?Q?3b6Oe28FD0t9IQLa2zswihITJz2I2D9NMyxRRFb+GRTJH0JfV2v6u9wZhO6B?=
 =?us-ascii?Q?+T8qdW3m3pvPigyvtBqXK8kQ2gR3Py51qPwWXEp616Tf9fBrLMVg+fbd9ozO?=
 =?us-ascii?Q?KFvk7oVkiWHvg8ivqzM1ACxffyi6wB9znbyJP7q5btaGLDZvs//FVTohQHUf?=
 =?us-ascii?Q?XsvBH2htFAFTssriZXGwjF9r5ggV986h6jVnHYGYEbCcJadFhNC5fFF74xHb?=
 =?us-ascii?Q?7gQNt1Jr6Y2G5dxsl5qYSqFWCcIKkcb24LkDwVgMtvNyV6hq8OIRgWYD/gr5?=
 =?us-ascii?Q?CIJ0gGrmTgGgkDQWEGxBDhwGA+vNuC6dk7Ebn3mzAxOXxaHqK8P9T4c1cFqX?=
 =?us-ascii?Q?nUHEJx+snNQNMex4Ywe8ZAiZOqMjj3rsqEZwTiOTLHReu6Bsucvv7rpB7TzL?=
 =?us-ascii?Q?uVePQPR6hnFJG2Ye7PfU3S3Tp/pVqcjGUhalMNJ8uUFs2dHqZuFGxJg/aqf3?=
 =?us-ascii?Q?C2qQPIgJTT/tYrIa58eg49lpNwvS0NaF9dz/h4CuOx+xJxB1SI4CPNsWwUJN?=
 =?us-ascii?Q?2KHf5XkdbDc/75A9kTIrSKWTXjiD0AKLCTjq8dI6v5vQtWjIUtTIOgREjQTq?=
 =?us-ascii?Q?zh2Te4mkJTRxtf5tjpk67OrrwvIlf7u698jfieHucT5uopvHNyEgdxPLDbt/?=
 =?us-ascii?Q?XlauIFSqqhK4ruaUOW4V4r1BJo51UQLGYhbO/4RlGS18Qnu3JAj6UaDyspOS?=
 =?us-ascii?Q?XmCp2VMpmovBQQ/m7KB0SuvLiEPcwT/QZU4ZPvc0+inSh/rHMp4UWKmxTxs9?=
 =?us-ascii?Q?2usOZgAUxtLez73/nkXjq4aq/DRN5iRt0fzQXNSmdFgAqbUW6p4wIWyVSJyl?=
 =?us-ascii?Q?0xtwUNcYfelcDDglWBbOCGmrmEJwJWp3clzjS+tOeff+PHoYa2QNqDbTnXAd?=
 =?us-ascii?Q?0vFHQud7WJQo6Aj0eMgq1qvthU6dgAAhizaDg5eIw6x+A3IQskvCOIY94YzU?=
 =?us-ascii?Q?kUMoc4l+SaGkugRHejYbfPKb4hdynlmYtoS4XXRLSUcYBS52uLHQ6SteO+1I?=
 =?us-ascii?Q?GFGRpW0q9SAheOqu0VvkKXXYFfV8xIGUTsr4HwGxgATtkbuznKK1GyPbLiBE?=
 =?us-ascii?Q?zHJCPv/eYmsXbgTX3uLedgtRHZlucGqETBvLcFqSyvnPhDSeGnimTaBY6nxF?=
 =?us-ascii?Q?rnulaOR/+W3rrFl8hNqgguNbaWGpIdA3qlB+ae4N6361LwrUNjHHXNTNd3nB?=
 =?us-ascii?Q?2uYzal4nhnRStuIq7uxNb3aR6Mtw2pc=3D?=
X-Exchange-RoutingPolicyChecked: Qt6K56Vu3/OGyuxODA7RpVsJtOx229wI5ercNvkkKPaauSdzHTZA1yHhmt5biblSfvHBmXJpalAriflip/IOzexu0bGaM2VxpSAuoQ9PgGiXO+ShnrRGjVxAGO0GY0jhTHtTyYlYprlU8rwJO/BpvzbPuy9RbVzE4C0V8qcxGRLGI9LIzrh5VXllsEZ1RvB0kTwYuhrjdJUcOHea2hiqCV93YxUAzYZ5PRzHlAg29RAlephFYz2aQnpSfNd+v/UAq2eH9A6l4SPgsAk1S8vWHqrMW6TXfNQrsZSa2QKJrRdJ8thNfzZYomOEwyLRl1D3TZZKPiyJxttDxw+f8x9AKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 558ccac0-d81a-4515-4e71-08df266616ff
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB8891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 00:33:23.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvpnpNb7L4SluGa1ZDDkGZc5mjQ899Lp0YFPXwhXEwiLFUrprK5LLQBGAgZ1vauTC/LUAZg8OM6mm6oGJIC9LMns/y3X7g2dg3gcYTBS9PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9208
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 03:39:43PM -0700, Dave Jiang wrote:
> 
> 
> On 10/9/26 1:24 PM, Alison Schofield wrote:
> > cxl_port_setup_targets() derives a decoder's interleave from the interleave
> > of the decoder above it. That parent interleave comes from either the root
> > decoder or a switch decoder, and each case is open coded along with the
> > parent validity checks.
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
> > index 80c40716c368..c1866b7b089b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
> >  	return distance;
> >  }
> >  
> > -static int cxl_port_setup_targets(struct cxl_port *port,
> > -				  struct cxl_region *cxlr,
> > -				  struct cxl_endpoint_decoder *cxled)
> > +static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> > +				      int *iw, int *ig)
> >  {
> > -	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > -	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
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
> > @@ -1539,6 +1507,54 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		return -EINVAL;
> >  	}
> >  
> > +	*iw = parent_iw;
> > +	*ig = parent_ig;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
> 
> Do we want to just rename it to cxl_switch_port_setup_targets() since the function basically is handling switch only?

Yes that makes the scope clearer. I think I shall add a new rename patch
before any of the refactoring patches so the subsequent patches all use
that name.  (Rather than sneaking it in here where it is first touched.)

Thanks for the review!


> 
> DJ
> 
> > +				  struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
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
> >  	child_iw = cxl_rr->nr_targets;
> >  	if (!ways_valid(child_iw)) {
> >  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> 
