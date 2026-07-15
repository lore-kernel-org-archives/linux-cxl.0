Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A563264D0
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151624; cv=fail; b=CyiAgbKSPWxSvOEgk5PuZVbjc/jXCMMmY0qksDNpMxH9k4SW7mi0Rp2lDS0CEVWgyONCyq6OhuqVXTMzh2hTb9IwC5UJNuMHvBl4cgDGlIzODn25SyBtLKiEnLgnaZrFyFfzY7Og3GVtMv4DjheNoJmqlg/RSELlmtEK0UFjfmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151624; c=relaxed/simple;
	bh=CKbytpwO9DAcVlVMeCeXl24FqF67x9bs94BEmacNMSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WCDfHuD/dMpWq1KrHWtfevzoZzu9yU3mmmQSFTfLci3DD7Fh0J/1ZxLzktfxjHz0y1iK+ZNW9m86uo/NjHJWgimy+trOgvOjmgYPLMTR8HY0JqhWIAhqq5LJGRdSfGsZuqN7DTvqjB68RYN4ihe7I9Zunxf3Clu06klbCgFvopY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeQqFz1U; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeQqFz1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784151621; x=1815687621;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CKbytpwO9DAcVlVMeCeXl24FqF67x9bs94BEmacNMSg=;
  b=LeQqFz1UuRjzW120bV9b9pM5r6qpPLivWtob/NIOauPvKquGaIgQtsd8
   Ff6ZNY4RBsdyL/9VLaI45i2ui2OLBGfiKLdtnR2+i+vvsxdsfAdCUKrx3
   3xDr14SDs/jmFsdyQT+65cYyuXDg5cIIm9IXk/RF3jGY9ehpEtBYpNekE
   YzsRh7QTauop+rD5rABAcrHR3rmWD0IsQT1DkvioavlZMHP+BFW6e02/L
   iXMd1Bj/rAGaC0Pr2b8v3DZ+mJB3zf9Rgmcf/A6xQ1xXAGMhOl+7J7UQC
   ekqPWOX6e4zoFZ/5xTiksVCRur9BQAsA+VCSMDSxg9n2RY6rUGAZr9NS4
   g==;
X-CSE-ConnectionGUID: OTZsDhBRQ5KbC2fybi04Jw==
X-CSE-MsgGUID: IiDP5VXuQk6FMElJYt7qzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96319695"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="96319695"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:40:20 -0700
X-CSE-ConnectionGUID: I5MOdqtqTI6XNxoV9nYHwA==
X-CSE-MsgGUID: 8iNFhKy/TMqZoXRITy95VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="294528547"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:40:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 14:40:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 14:40:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 14:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfa5Gxq/z3D4DKkgEhpFRGDIwkoxVgqzMirW9lsku7PhOSgpgnUvYS+nLnVyr5gS6GjCx26wyk/IOoNo+sK/PcWOiLpPLKprf1xlzY+jLdsfm1any59YuxQQMv2sU6IwL03D+LvhMVhykzTtHIo6FVHGDlBZ8+ABq9scMsZl4yysw9VjkqHyhjd6UUXczj0q2QeLIlYBF8BDI8MthIqP/1XGIHatWZurlNHLoGb7cWbshSGrCGQ5IJUVe85VHNDQHk6W+sppNw2HrHC7ZBN84FK98siamFZR/tvUOhb1gmooTup2J9R9NqISJ/HmC3uYa8ZovUfCZpGCvNGlD8073Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFU+3QXWGIbhBypNKXFh19y/txlZpxhrEFhztL++/D8=;
 b=D2WveRtWBf1rWVhAEtdcjWcFLNJk4ZBq5WMJF9nDOFEgkuZhj+WxjthXyD8rl+jcm2vXvNfPmkeBId0eh6VnBM2iuTOktuAwznVjybVVAIELvAzlP71GKfWl7WdsI2f7cfGTf89PvB6j5Rmx8WHRpoNrm84h6sA24VTf0Eh1DcIZ6eEmr5CQuGL/xn/TXLljjNbOKfTQt+z/mJWZlSbc6ECQE0aGAHhzgw73iixn3rfovNZFkncl4GSMTJIYDVT5xD2rpgdBfZmgmpvvHZ4yCN6YROZ7RJKetg3nm5Tkg4qBgk15DL8TnAwL3FBVfBFiq+p0yQaLWqKB3v3dKDvlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 21:40:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 21:40:16 +0000
Date: Wed, 15 Jul 2026 14:40:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/hdm: Reject switch decoder interleave ways that
 overflow targets
Message-ID: <alf-PfxF1-JkbZoW@aschofie-mobl2.lan>
References: <cover.1783974681.git.alison.schofield@intel.com>
 <dad02aebdc2d82537d779ddff459c8c4b5a614da.1783974681.git.alison.schofield@intel.com>
 <20260713210019.A74F61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713210019.A74F61F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f91725c-e642-49e2-6035-08dee2b9a8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|3023799007|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: dnrkakauIwmnNlBGde3gSwwESkO7KmpvtMgVIRMjdQpm7ir7C1F80zJVu8ZYif7Iu10A2gMxVKznjuSyCjlSxArykO6Zk5SpvIogvANTHMjgUB9X63HZRZsJJ6UTGXzqPWytMdjDoG57rK/HxPnk1ygQVkOb7UJ6d04c90MaTp2r/0LQZzxUpaMyzLVAxiVnCiqFev3t723TxEgF3ilPSX3AT3qMYLNp+0JS7E8AhEqLXdxOwhJGGzFEJRGoHpJSzec2voe4OJkhIiMNiKM3MKZ4ea+QtqyGRn46yZheameY541e0uhBmDr1YndsDreMZhQERSg9n1GsOn8SEGMuzhDl0DVCELQe8Nk8XygTQBBeXBcrGpzQxzEbTUR+H7V7FdFsQAfDqLups7p/CSSvsSTEERL0u99EleaAxXH5+gRGIBtQ/jXYStao660lT9OHQFrSlWYwPhzApAfzhrXZETP9y0ANiah8ghx5jBG+yP/89zjmglmxeBydRkrnuv+dLFZtMruqgweaV5U3e6MmjfiV2i5qJFqqSZkYcPOeeUk1EkkBj+kK8eOdRL+HCjdyMAhwXZ7nBqgx4CFJhHIaeXlQXwLIZ8lVIofuYaTSDCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DpBd5WDWP+M/EhcLYlHRhTlvJyyV4nE9X0yg5amZSTjGoQVTh+HeZOS9cu?=
 =?iso-8859-1?Q?NmKUztMZjMWLJG8B8IeBlNkIrHsmvelYMoZf4NnfpeJKxE2aEx+zfbN5JE?=
 =?iso-8859-1?Q?Rdr6XDc2s0tVK7/QYeTdO2Z00Zs5ynvZ3dJVhGgQoOErimZqgktvrUiJkP?=
 =?iso-8859-1?Q?0NfjIIW/7EP82S12bJOBdX6Y4axLDfGyD3prLpl32KUJL/yHfKkZs+VOmk?=
 =?iso-8859-1?Q?KQBK6NvFkVrYHz23ZVCJtSmoIhCOCtha5sgPLdmo2Rq+POiBXIXOF6x6+Q?=
 =?iso-8859-1?Q?GER3bm1xEIPtqW8tVbuS1lKVX95Xqy7ICjQxpU3RMZCbCcfwlVxe3gKJF0?=
 =?iso-8859-1?Q?RJmgzKUDcEJdl58sWhhQeWA3mi+xbS7ULMf0IWIPc7ll33UejSfANdXTgp?=
 =?iso-8859-1?Q?6FlQ+F2Xxq4KdlVBJfyL7XW6tvZs3ctHVEVXQCr0lHaPRt7NFPty2XVKig?=
 =?iso-8859-1?Q?JwEZ6D4SRtSFU2V617v7uoHY4lJfqXAFS5fcWqCkuOtz+NPUIFHxUa28yD?=
 =?iso-8859-1?Q?gbkfhhOp35pPnFnTBVE0V2KSaMGq5Xk3IAYAibwhNg/GUmxAPi5VNRY4F7?=
 =?iso-8859-1?Q?JSnT53+nK0dFASGjPELGmXlrnYbQWsEJO4FflbWoICrBsqSu+IoUmWjsRi?=
 =?iso-8859-1?Q?dbl5GwZKeTcrZC6gmHATB32v7eHzTnnpvizLdvmJQC+v4QsQxj8GNEWdZP?=
 =?iso-8859-1?Q?0T4G0oQLeJVcLh0Npdl0LN1e+Nxc1xXq9GxNkypuMXYqsJQZTKKo93cy3t?=
 =?iso-8859-1?Q?/u0bLhisIMGUtxHxD+o02uVqQDfue3LgEczSBYj2T56b/bQnJZHNZ1ZkjU?=
 =?iso-8859-1?Q?1IeVp8U++gpcorM88+UtJ6nZKIOLpvXZamwle0+ifTcT7a3KcL4TptnMZs?=
 =?iso-8859-1?Q?ySvJVBNgMuDzs2VBhezC/EQrsBPeG1nBtPVJN2BgutfOA3qK/F4a3lr1YY?=
 =?iso-8859-1?Q?YC32tAqdYQXhAV0OMswLv7RyM3jQ276pE2d81QD0QJ0d93rySnaFCoAz8c?=
 =?iso-8859-1?Q?yyXuN70F3WJoCBHmtM/szCgaQH6CGEHFKXz2hsbZJelbJi7aC3aYPXEadb?=
 =?iso-8859-1?Q?/bBAotNggXQhlPZaJspQiHzEWv62tE81moomdgjObrFn3CeD9GavH5CXRA?=
 =?iso-8859-1?Q?cjbrpGezX+wRPUhYRuTc8VDil8ZplAzviyDDYe5e2JJ8pPZfBczubmjbYS?=
 =?iso-8859-1?Q?Rm4cbhPxp/Bx45raqTsC/O2pz2QFwXn0qr3UJPxlhWkmgTBzxDpYpMl5/t?=
 =?iso-8859-1?Q?2gf0t6yHWIwT8omW0yuK7IIQwiY0NTdr43xObUq8UyE76LU+41P7TGfNsW?=
 =?iso-8859-1?Q?KCld9XHwVBbHclzUiPozBwJEv0ocHJucxkKtvHaCJRapbivOIvG45IwUP7?=
 =?iso-8859-1?Q?7Q9Jh9bJyQv3tio3XGH4t/8YfbY3RN3vHMj4Xdby8vA9lTBsbMplXj+74n?=
 =?iso-8859-1?Q?8HElIQomokm6oT5oY1cKIzP2yVU4W2kicDMZ4tYsEOI10nec7oHaCwPqbD?=
 =?iso-8859-1?Q?Ur0nlTGeUh+EzIvk69uWbP5AZUbAF/RKhY3BevvbQUcy5x3vLWZBs/S3y7?=
 =?iso-8859-1?Q?9estr8vJHDWIMoHdYsZhB+3Yr45tfkIL8Vx1POwO0YH1notpYfHuR9auC/?=
 =?iso-8859-1?Q?Ln6GgGDMhLC2tPaVgsZniYgNaCbDswcGS4tft/mIcgMZJ7lXpn4wOLgV4l?=
 =?iso-8859-1?Q?N/unQ+hZKPxy4lodm8Dipz5ohYIZlLnOe9obhjILMcNYJ7d8DcyObPWs6z?=
 =?iso-8859-1?Q?FLoFkUfP+pGqhnfAjIVI6Op2ncF7rhFlWXTFsi+jCeZRcGxq++0bh0Dkv5?=
 =?iso-8859-1?Q?pfkayLwxM4pked7e3uoUO4axosmkILU=3D?=
X-Exchange-RoutingPolicyChecked: XiBFbx8zbmEJaGDqu+DYGZmCdjY9nfv12GIV76wCXTVDuHeSBithAKNW8bckyPKkxH4XaeFqFekVzcyxTPUsJhu+HAkwE/ViqHviwHt8qi5b5QC11JP67Qyza6/WFaOZEuMGvblFUbxs4Z9GoKOsbUM3w6G+Sjj+9KS+I+oOJgraeah5VvzEeJcipVqzFQmk0KNWxSL8drAS42oT9nDhL3Y8DssNl8aj/KwA2ONol0MMCtaGFTRDmPZDoNg6P1GW1tGhxw+CCt65pLSNzIO8Ri+8+sk+4WqUPWlAOJZH/5rzXS5hvgOdacf1v9Q40Vu+ip8jjIwf4x+UFqKQFji9SQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f91725c-e642-49e2-6035-08dee2b9a8a3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 21:40:16.1427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8nYSuYFQyGbvYdbmOsWi8UyDZC5M8052zv66k/uJps5SnhdJzJhKuE1GPTpEw38uzxec5SbCmPWAyywGOgbCVoLKYWPkmKLXTlmIeUXuZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8750
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 09:00:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Validation of `interleave_ways` returns a hard error for uncommitted decoders, causing a fatal probe failure if an inactive decoder contains leftover or uninitialized configuration.

Fixed in v2.


> - [High] Due to a preexisting off-by-one error in `nr_targets`, the new check `cxld->interleave_ways > cxlsd->nr_targets` will falsely reject valid max-width interleaved configurations.
> 

Disagree on this one. 
Target Count is not 0-based. Per CXL r4.0, Table 8-116 (CXL HDM Decoder
Capability Register), the Target Count field is a direct count

But...given the confusion w the adjacent decoder_count field I have
added a clarifying comment in v2.


> Pre-existing issues:
> - [Critical] Target list array accesses are endian-dependent, leading to corrupted target mapping on Big-Endian systems.

This is addressed in Patch 2 of the series


> --
> 
> --- Patch [1]: [PATCH 1/3] cxl/hdm: Reject switch decoder interleave ways that overflow targets ---
> commit 0f855df703f711546a94bba79b4742022fb3bae7
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/hdm: Reject switch decoder interleave ways that overflow targets
> 
> This commit adds validation during CXL switch decoder enumeration to ensure
> that the number of interleave ways does not exceed either the hardware
> target list capacity or the reported target count. If the ways exceed
> these values, enumeration fails with an error to prevent array overflows.
> 
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -1084,6 +1084,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		cxld->interleave_ways, cxld->interleave_granularity);
> >  
> >  	if (!cxled) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> > +
> > +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> 
> [Severity: High]
> Will this return a hard error for uncommitted decoders?
> 
> If an inactive or uncommitted decoder contains uninitialized or leftover
> state (such as from BIOS) in its control register, this bounds check will
> fail and return -ENXIO. 
> 
> Because this validation happens before checking if the decoder is actually
> committed, does this abort the initialization of subsequent decoders and
> prevent the CXL switch port from probing?
> 
> devm_cxl_switch_port_decoders_setup()
>   -> devm_cxl_enumerate_decoders()
>     -> init_hdm_decoder()
> 
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				CXL_HDM_DECODER0_TL_TARGETS);
> > +			return -ENXIO;
> > +		}
> > +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> 
> [Severity: High]
> Is cxlsd->nr_targets a 0-based count?
> 
> In parse_hdm_decoder_caps(), the 0-based hardware capability "Target Count"
> is assigned to cxlhdm->target_count without adjustment, making
> cxlsd->nr_targets 0-based (where 0 means 1 target, 1 means 2 targets, etc.).
> 
> Since interleave_ways is a 1-based exact count, won't this check incorrectly
> reject valid configurations? 
> 
> For example, a 2-way interleave across 2 targets evaluates as 2 > 1,
> incorrectly returning -ENXIO and preventing CXL memory enumeration on valid
> hardware topologies.
> 
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				cxlsd->nr_targets);
> > +			return -ENXIO;
> > +		}
> > +
> >  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> >  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> >  		target_list.value = (hi << 32) + lo;
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does assigning
> target_list.value this way cause endian-dependent target mapping on
> Big-Endian systems?
> 
> By reading the lo and hi registers and combining them into a host-endian
> 64-bit integer, accessing it as a byte array (e.g., via
> target_list.target_id[i]) will read the most significant byte on Big-Endian
> architectures instead of the expected byte.
> 
> Could this lead to memory traffic being routed to the wrong CXL target on
> architectures like PowerPC or s390x?
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783974681.git.alison.schofield@intel.com?part=1
