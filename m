Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEB2F50
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307096; cv=fail; b=a6a+f+xhQg3HyC8kbHrF8+UF1U3gCronPhr1ps22uB1C25L91BmVbjX8amLhD3N0C+B+rFBn/UJguhgHrg6PwIrHUPOhL7rYfWuRgTi4oM00JkcVPGsAbruIxDJFUVhPSt/A1YmDYKvRAYE6eh4HJl6kk00I4i3Tn7TDjB5PXg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307096; c=relaxed/simple;
	bh=AD/ArEVt8W04/dwCmKuDQh8Jknr8Q0YY54FOYL4iMMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tRMuDQc/rJXkT0l74K+y8y3lcL1cCUNBNQgtq2ZX14V1lRZb4UMknZr2fhIqe850vbjYKuJZ+1Jx3QxywHBSb8chVAOXDqgNksid6kIGrtuZXXtho1xvD7KP8UdvsgnBaRP8JrJVOV7fAV7MafrUt8YZk2+t3oadHx5bj1a+VPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4B56f6D; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4B56f6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718307095; x=1749843095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AD/ArEVt8W04/dwCmKuDQh8Jknr8Q0YY54FOYL4iMMA=;
  b=X4B56f6DKm5UcbUeqh3gkldhl5FDEM0jjdJL0hrgGixyApxWTbmVrki9
   TEjBuEw1W3tUHeUVgVVkDV8sL8z8Is2iRIIYDzKcVL+4zTYlJbzwzmWGg
   MtM6YUExYncfObQYJO1Gh4e576xGiKB99c77LsDLLrxWfpaGUihK9u45n
   OnSgjd/Hqcw97MfMuJZU6NTVdJglNEexU61rOa+Q2uSiQSTASRMNOHlph
   QbCrNXUXqZU2CqHJ19qcixgx93iQ3YCnCPyTI0CzftTAEtNE/TvHEnKif
   85LOnlhWgUeLRPsI6KPP1Jret1+zE7pBCjENWeccLFss2m/AZukFPAPd5
   Q==;
X-CSE-ConnectionGUID: 5ma2Z+SYRFegCIB+lXFz+g==
X-CSE-MsgGUID: 6DUWLbXQRhi3d+bKCyTjaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15291421"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15291421"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:31:34 -0700
X-CSE-ConnectionGUID: Hxh+qo4zT22lx7GM/xhofQ==
X-CSE-MsgGUID: hfKGaBNkSzOzij+M0k8Abg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40964881"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 12:31:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 12:31:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 12:31:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 12:31:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 12:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXyJa+3Z9wnq2nTr2d0UcrmWrtdAG9CI2IscTCaDcBjjhPnZCiR0wdB9ShYWbe/skTMP6QzB2yCSVuSAcsH+QkbLRa11vhDco2vNIAD0z4cFvgY9AxS2AxIHluxtGHnYwfaX5ZtQrqGHPOhvdCt2/WU3FpjjBQcVjV7bT6GdiOfe9FwsKjSbr2wyBAH7heGGpwA9vsbRVciKLbkyJYAo4dzwk3BWUU0ZcoHNddDw3GuYcgnvMs1FBekjsW6Q/aVWWSJF68D8NEoGswDO3Tpe5TvRUoWF0cjIrCKSz7KUcbMb6fRvckxh00GQIh5ojsNdJhOJpzmYtg8W/KGcfqsubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9heGP/2zN5hT2F+HVn/WViig4vvylIIFOzMeMeB70n8=;
 b=mJAJ1mXE9ByNr+zY1DntQ2UBWaFfnPMPyG22My6iOAhaW01mP1yvbe5ltZJnGWsEYnDAzPftOlo6NRLKsdUOwAbHH/tQDWJ3eePjNXf62hMAntB570gJ5478FNvl09uANBIMhHs8krXuKNTk8Ov69wHFKdZSQz669SxiGgTdkgH036fM5qGxLh7Le6hzftOleD9WQi1aj09/q3lsCbGsL89BKUxpDXLghgGsZ3JO3CjJBIt+7I1o36pNPBaInVgi8lnDc1zho6EewmXH2Kk1+jgjhzDd6JCLUK2IAVDXfbm3y0j3/GotNduAoMOYv01Z+6qOxCh6Bs6Hg8Hv0Ea+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 19:31:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 13 Jun 2024
 19:31:31 +0000
Date: Thu, 13 Jun 2024 12:31:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: Remove soft reserve resource at region
 construction
Message-ID: <666b490f7a06f_c79a32946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240612205905.1209448-1-nathan.fontenot@amd.com>
 <Zmo9ltXuf5G7/pwi@aschofie-mobl2>
 <34868fdf-2f19-40dc-8ae0-3c5123f3ad1a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34868fdf-2f19-40dc-8ae0-3c5123f3ad1a@amd.com>
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b096c0b-6683-4988-5535-08dc8bdf6d61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0EnXXjCvVZbJx0z/qlX/C7rVUaneeFFFgICKe5dwyFvJwsv8nKAwufG9lc1u?=
 =?us-ascii?Q?VoIJqCQ+H+i4j6qmOpBsevqdycrHP+GXahpVjoWnoTmmd25ukj2yRdkjcPjJ?=
 =?us-ascii?Q?FkYToVSnRY57jXeC/kFXzbTH7tCEzPeq8FZG/7xroe7CHjeB6JdCB3oJ9DvH?=
 =?us-ascii?Q?nOYB70usO+JuIQG0egMGAnN3D4iM4b4aEP6BqAckTlDi2+UPovCyMkJlmq4X?=
 =?us-ascii?Q?DyPp2EH1oLwcR5vsy+MngYqILEDenYJv52cYCKi/sH2GaTcpQ3EooMK3M7A5?=
 =?us-ascii?Q?El/jRcfRuJqkOwR9743s8VQhe8h+nBpeEdNGx9TU7ItU/hj+v3HFmBRbxeaE?=
 =?us-ascii?Q?SPQBykC/fVZUca3mA/pw397yEpKa2FtgzgQ8C9L5voBed2Tp9O2zXMcd8sFd?=
 =?us-ascii?Q?T1gK6vVLgJHpyiGa5SwdZ9NppYN/+ozdzzX5iR/+8Dcw1ji/dab/OkQ97hFp?=
 =?us-ascii?Q?NQnACF9RkCa5M6JxMceHavjBoCYp8mU0sQgXT1Obg8ZB3yczqV8c5zLTy0Kl?=
 =?us-ascii?Q?B1h0ONxk/pve9BY9S2e6rLiOk3UP0ZhXJ1Zb3c1uBp6tJRslHYp+AT03NRGX?=
 =?us-ascii?Q?hR+FbceqLz3j9zwwr7LEdXRDbP1kd9o/XJo1okKxWMKZggMswhN0tLS9SKQq?=
 =?us-ascii?Q?kAo3i5ZbEvOIexh6SARizy5dpMmQnV7f1ZlTARsr+EJVlzSBdF1UcbwMjOQ2?=
 =?us-ascii?Q?O+7zB1h0CzQ5fV2tqwm8MWWe1kAcliTvY3OnctTottO7Sc8NK5cmqYOiPSYA?=
 =?us-ascii?Q?bujqxksrPVD/guy/Ya0+BS0yKlY+7jCEskXgHrTFc/hfgz3RxS/LNmcnghcP?=
 =?us-ascii?Q?Ijeuh1HAPgMiDaBMa5mSubczSBzDISiTf9kHXkWv6OSGZy6u8cIDB60i0REA?=
 =?us-ascii?Q?n5quycS3XVqpwOMSASeF5B/KUyrZaTDKXsEnFJbF0syMdnWNG0fa/v/jfBmJ?=
 =?us-ascii?Q?d4JfWgKPBAogVkm/M/xIyKXWtcsJlGPJRKTbmiLgRZ6X3m/76Xx8Het3vgdB?=
 =?us-ascii?Q?wrK1n9/aC3arcxYuQuvDvxV6h634y4tYH0HeBbUTvzudYEqXnOERs9Vdxt0M?=
 =?us-ascii?Q?TEJG/autB8fviEzfn7tJ6t0pxkglfy1SsqMLrZRo6X9EFfge4Qtqv6nXSqSQ?=
 =?us-ascii?Q?0QOqMcQoC/HdXTxvXoFhEjDaWHc5d+1i6u0JGDM/J3h8SphkHmwU8wUKz0rY?=
 =?us-ascii?Q?iQcTW/UMEurlZ+EzpXRL6zjk0Lk5s/wt8t+MFzPQeNtbmBOmtcE7FPAdJvrm?=
 =?us-ascii?Q?V0rDndDsmlDQnjeAQWszulpIqz81BL/ofnqOsQhMqmB1fAzECo2EFdd+u2ep?=
 =?us-ascii?Q?h1C+ZMrxCGVyC2/RgCD88Uh0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tLnTRQbx5RygKociYd2YciwPdZz2XPFsG9DJ/fsabDLcK5Mrd0CXJsRPsHjL?=
 =?us-ascii?Q?knmyTcguN59WF+GDHELQd7NSJ5TzbwlWFxJYrjbQmj7fYC2b1YJqfm0bMLTt?=
 =?us-ascii?Q?qz1iicjoqo7edNHAv4uvawVysNjwZbTr8EVnidv2JKa/f2Uu1Kx37cjqyfW1?=
 =?us-ascii?Q?/mfV8e/gDthCgRkobs1JhxFByQRW5RO7qC4qSnmz+/wfam0BqyZD0K12O1vo?=
 =?us-ascii?Q?d7y+0TswlAqNccOKNmxyslAF2QxrWJQ6dOp0XC2qUd5Duo+mJr7HjDnoHzof?=
 =?us-ascii?Q?r+pLzmIDBvK6e9jMYKEbkIiacYJJwNkmPRL7Qg97yipvhUlYblmM0oCxoO6u?=
 =?us-ascii?Q?MCQUmCMpBNN8oy3Tvg9z2zaIH2ekYfDtPP6wH8bx+URSsqQl4rOZhEp6rro2?=
 =?us-ascii?Q?CRGSR2T+QMebShaG4B5SBpy3JyhZC7vUFP7rt1tqFkVzRxdsFc4XskeyUQMs?=
 =?us-ascii?Q?3KuBj0jh1epjtsE9jQnxniEHgoTxjPjLLnZCJYNcQxywZmAW8h42627btvdN?=
 =?us-ascii?Q?BXGBTVp8/yTdVFFncHu+0PRuWhQZwwSNtTucSDABZn/DB1Ynq9UP4zBmf/Y2?=
 =?us-ascii?Q?L+4fJFkk4eQ2LOMSAyoFR4cUEB0O/4SFvTy4vRyT5TLKzSXIXenRHchUA5EO?=
 =?us-ascii?Q?qdBUHft6GkSmoV5guhdMRzibr5v/xTsU1sCKO5BIKmeTP/8lwyhpYilnD//R?=
 =?us-ascii?Q?Cfg8VxQaQPyMPdeCTaneACS1WqbHeI+VLh+suiASaboQMQQ7sfaFVq3B42X8?=
 =?us-ascii?Q?QdK/DBSv++VlVE0bW7IWwPW8xJx7sEFyjWCwcGWZVry1VzbVoBP9Mw8LjiV+?=
 =?us-ascii?Q?NLvL020589D2fosTT1miL6+diekWQUsnb4csmvHDCIq9mwy1/JPX6hkO9rA5?=
 =?us-ascii?Q?shve0uGSgyXtQaK5gLJ3ATFbJ49S21YisSR6ntkZkkNe2pCdWQeiV+7gZa9i?=
 =?us-ascii?Q?6rWRF+HE+9KD1xLViRkp/Imi70B4O9UFuyPxH/fPBpMUkpO66x+yonkC4QEA?=
 =?us-ascii?Q?eB2izdHKJMh8fh2aGzbQprvIavYBiM8aCuyZyJdOlBqqszDkGTrzEveVO56J?=
 =?us-ascii?Q?4rx2ZON1kwAOgWBRFLKS1Md9ZuzZZgRE7eA9RK/UDNEeysqiCXu4t0mnIjKa?=
 =?us-ascii?Q?d8YT9ccbAUeghuvsLWLvaOgswkUbJ8ShCHXzBoNKZh2yMcJNwvmQM90oyWG5?=
 =?us-ascii?Q?jXNWrq6S3+bXTmD9pc7YUKB3Nras2pEZQqUDI5q39spG999HH0cdnVYbGwPd?=
 =?us-ascii?Q?0C91rQFVlJhD3OauXU9+Z0EGcRCyuUa4Y+mkFy4v1j6wdioRBPE8RWcL/zqL?=
 =?us-ascii?Q?h9GCltcmB6orrIeobSTvCzXLVbHKmdV3ISZZ3hEv26rhtR+izt7o56fr59j+?=
 =?us-ascii?Q?bNftywetX/st63p25rWzQF5Ju8ITHycEBKOV4SqhMrybiB7EIP9bEsK+AWLs?=
 =?us-ascii?Q?LAzWJdFqUrO/yFu2ecPzxkBgU4PBG16HPJdlGEmSyMqmJtYIfR3OC963foM3?=
 =?us-ascii?Q?+0qCWhK9dBDfvYH4q0wMfjW0484IKNAnXKm0mPJtUPXc/WY3LBONMn2KYfbY?=
 =?us-ascii?Q?icsisnXJjasC24Z1Kvj+lEvIRDtdjB1pRdSWqAXUDf0vIsR4vo8960ltW3gl?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b096c0b-6683-4988-5535-08dc8bdf6d61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:31:31.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeHuK36hnUpMQpfXcu0oVL+0BTAJgSg5YojmHoJgwzABtCv2yybcYgJ0Nm2qLp6T4d3AFzIUb9/HvDQYhh3MN5/HgsCuFrVLwFON2N1ImUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com

Nathan Fontenot wrote:
[..]
> > 
> > Is it OK to remove the entire Soft Reserved when that first region
> > is constructed?  ie. in this setup that removes the soft reserved
> > before region1 is constructed.
> > 
> > 100-600 : CXL Window 0
> >   100-600 : Soft Reserved
> >     100-200 : region0
> >     200-300 : region1
> 
> My approach was thinking that it is ok to go ahead and remove the entire soft reserve.
> I couldn't find a reason we needed to keep the soft reserve after this point. I could
> be wrong on this.
> 
> One different approach I've been looking at is if it's possible to add the CFMWS resource
> as a child of the soft reserve. Instead of starting with 
> 
> 100 - 600 " CXL Window 0
>   100 - 600 : Soft Reserved
> 
> We would have
> 
> 100 - 600 : Soft Reserved
>   100 - 600 : CXL Window 0
> 
> My thinking is that with the soft reserve above the CXL Window we no longer need to
> manipulate the soft reserve range on hotplug remove. The alloc_hpa() call for user
> set up uses the CXL Window as the base for alloc_free_mem_region() and the soft
> reserve wouldn't come into play.
> 
> I haven't looked at acpi:add_cxl_resources() enough to know if this is something that
> actually can be done safely.

Could you please stop trying to invent new approaches and respond to the
one on the table?
