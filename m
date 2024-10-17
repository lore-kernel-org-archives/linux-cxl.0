Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168F1DEFDA
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182752; cv=fail; b=s6macnCVk2YGA9cfzbfA8xPx9aBpqN5eVCfWft+jRyAw6UmJs4L3kKXIHff6NZEjvkWa3430MBa1KtqbY0QqVQ3UsxBE0oJSVS7s9wOAfN5RVlwJktUpuF+yR4VtQWiWSxGoX/L8kIw0DRJM15k1bfHnJXwcN8YqSD/TqQT/fKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182752; c=relaxed/simple;
	bh=fLFDsjFRWBGJZi4mqfOjgwgUcdPquY/IK59ni8morDc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLICUF5Wrvo4thDrPeHXnlyde4swhmcG/vpzU5vcC2Rpkjd1z2fIRgZNL/B72A68vIjZawOySQzkyO5QMIqkKgjU2wBbxnArm6gwssQw5JQo5Mk1w3J1i1BFLoqdHN85UE/GVU6D3jkZpDT34gdsUr3Cy2BKPtEr4L1XvSeIKuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciXKdHg1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciXKdHg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729182750; x=1760718750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fLFDsjFRWBGJZi4mqfOjgwgUcdPquY/IK59ni8morDc=;
  b=ciXKdHg1BQxgHa6L8W+AmWeXt1p0YrjxaWK8azz5OoMdaItPIhLXJ9+c
   K0sx1a+Y2yuihQ8kA8I1XuWeixOz2SJ/UZPoCdeVW1E+15I9s+Qk4GBdt
   G98bdPfQo5FH30F0lJxuQeIDNHwj3x80TEQj3zw5eAF9y44PKhMjkBTux
   OKghWOVaTLmxBt2B5rBamJrShwSj2eDx325HUKpLKhdZIGfx1YkjWdB0M
   5wAebQt2ufjX3oMTYv1rbljZSDP4wrDITYa9eTVB7TTD4mosD6TOEQ9I2
   fN38rihqrDih7ZjNENs1IDDK0G21PByvfnlull7Y2Faae5BVAXpG9LnYn
   w==;
X-CSE-ConnectionGUID: bwfAlS45Tcm+mpvmpSRwnw==
X-CSE-MsgGUID: bMOKbo8xTFuNSvxgy+t2ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28780321"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28780321"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 09:32:29 -0700
X-CSE-ConnectionGUID: fiLpcIMsSySNxxHPd9s8hQ==
X-CSE-MsgGUID: 43jfJQHjR1Sh7qgr6/7s2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83245720"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 09:32:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 09:32:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 09:32:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 09:32:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 09:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqG8gE5UqKEO58JI22pcRMuzOTfFJDkJ1+iWQ6GbkFp81wr2P1Qz8BwgE2LGLbzNDwNa8Aw2K7rUXHuQxuDRULb2ylmCcsgg5nY5uPrCg4Nc0JJnY5sLdqR4UWA0r680kvH17ohQ3kZDr5ttlrD/O7ebRdeRs2XFBYv7Crrph9ZMasNoUzpI+PAiyN0HL/mtKwbc33Q3SvwrdU9MyTwU8Af44t6E55rOQvHNRhZnBQ8J3esfa0ybLiZjlk1VhHRQvo7MUJHl7NC4dJ/WmUy4n3KbihGy39jq/h2syz5TWuJHj16VUK0/g7GS5N2M+sQJNYwkfQwrTQJhmBc9suoDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcdxkekbJk+q05UMjmOrIfIKg2pfQq28MH4mI5kHKAA=;
 b=pPLorh/5L1KRm2P8ZmxTAVUKyicwlYKp768Il8OUCoqUtwU9CncIB57ozirU5aSLSoKye9V52kvNAb7aQbRWHklXiaHMB8OZMu+cM5LYzeeid2jP3ov1oeZF+5LaGSch+I4qNZujWQwxrtcMKBD+b4XHaTEN5M/0pL9NFrxsTIquErfPPOKzQF1wLT10Q0Zcejf1CAEyOI2Ba/J2Fa3TJS82uTiF1MpEVWxrjIx+yBdbpqS7YhdkiHjXsfU85iSM089W+5ZP7K5KGbTAxLnY0NgFzjVqE5HBukdukYp5l4n1obAsdNZvE33IhE5fWflHdjjVTvSL2E+NlDwlTGOOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 16:32:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 16:32:26 +0000
Date: Thu, 17 Oct 2024 09:32:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <67113c1775a7f_10a03294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
 <671044082f7de_3ee22945a@dwillia2-xfh.jf.intel.com.notmuch>
 <20241017160445.00005c50@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017160445.00005c50@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5034efd2-2990-4c53-b38e-08dceec9490d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YRl9Zq2M3f78xOkMWanx8jF0+zz6ce0V2aug3ePjImy6KbKQFga6FoZLK6uA?=
 =?us-ascii?Q?jbYBoK8YHTI1a4Aesv3jBg+ipIEODby2pkkxQ5sLeSECIaQyUsAtRyBR2rH1?=
 =?us-ascii?Q?Uw8JrkOC5TejsdmgbTtIJGy1Wmik8ENtqPWglwi6/KTGjenFV3LDZh7Yc8fJ?=
 =?us-ascii?Q?Yv/uvPqvZYrS1n5lnMtuuup9cahsq+RoUR1J8yJAyBaMJEn3IO3rWlq4KfEX?=
 =?us-ascii?Q?9z0SsmcSqEk7cL5C3T6cAJ9UW/YsAHMPYcBVhU0eXUE/Jqka0mj3vlkegOEi?=
 =?us-ascii?Q?H1pLZCReIZRw3Uic/NqjFzRikeyjL+iNi/drzs4M6v4kGakM3nH7mUR1whgo?=
 =?us-ascii?Q?kgMpfQsiH7bGdEeiGUMFsaPcTqujACREEUQsaxCYjV9c5qrGNK1/0ttr87d+?=
 =?us-ascii?Q?trqXN+dMDpSZK1FzKCEHmpFm68ZS/SIB7SBdOxiSRZWwPxeNy8mWYrcfklxS?=
 =?us-ascii?Q?QTVq6ZWmGfLFTKPb1fCeTA5E0GQ8V+iEtyPaLB8/PVjgRdKm73NJMF/9tbCQ?=
 =?us-ascii?Q?HSHXtAbxaxuekHE0/gPF171qqqK+93L41XVMVKoeBtK3D3ogXFmd/ryb+5i4?=
 =?us-ascii?Q?QDC5fjZV/hNT0IA51svvfcfOg+jYRBQlhcWBpUASbuyaM7jkzegNxf1hZDiy?=
 =?us-ascii?Q?6YlZOsHMXEvbzRKUS6ExAQlAJ8hr+6tqCp6BJCL++VwxIajJcn/T/3mVmXEc?=
 =?us-ascii?Q?mgWx2oe8xOpO5D+7sMTZ85RTz9nO7HGx3GU2gapWgdw6KDSPvxeG7iPwnZAi?=
 =?us-ascii?Q?egJI9yarGFFuWfZ27mlRstJM+OyrTE15AYhbGWe78QU2+spiUtWI8DHAa3s3?=
 =?us-ascii?Q?KgPXzK+yl7yFJc29PNn2sLZkjmOVu1+5zTsOV40yTEs0rbXl39YYz9rIeg7/?=
 =?us-ascii?Q?aLZRwQYtKRG6uwIj5iz7VGHrpG2grrf6KUL3A4TmEZo+LOJbxQjyrDp2Lqzc?=
 =?us-ascii?Q?vqClcC6rGhZ7EFv+ZSkD3ooTykbznUU7pQyP71bixhmuaDzuzj3bJCvrAVBH?=
 =?us-ascii?Q?ebhFqIQgZUE7McSykYPpmQxCOb3ssrK95lNRynC+4Tc4LNJp0HyI2rKoqRnv?=
 =?us-ascii?Q?gaYhWoLJG3/+mzZUy8uuV+6+cOlwRRXf/4V/6BvGZhYyppuizGwp9KR5e0v/?=
 =?us-ascii?Q?cohK9Ro/eNhkdLDXNuVAgEnwitc4oTOXg98gECkdPL8kD8p4yyfWpyKIoRg8?=
 =?us-ascii?Q?gD+kcT+dtSVmunQ8aEiRHnnEV9O1a9rqGE55zjUIcI3JtWUscivz8PjELVOY?=
 =?us-ascii?Q?+5Q8YTzjQDMqLZZpAno2RBaX87Clo1LP2XwkSHVxJuzDBQ1TDZ9klBiA2d6C?=
 =?us-ascii?Q?m8WA3oI/zK9flxBSGt/2hO7s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hhd6AE+qs9sDYVykTk9uUJewq5Qg/pD51iJ4OMUo9i7tqKwZqcitL+erqoeC?=
 =?us-ascii?Q?q2cnjUejr9s7SPFy2RgxDeO/6oxAUC4bCb+FkKSxRsNEcH8kwyD1Z1qWs6sQ?=
 =?us-ascii?Q?lprq3//rntM8Z92z4rNjh35I/juJILjinFcJJcbfTSenLrqcEErU2yHDO33v?=
 =?us-ascii?Q?MD0iOWCRtDMuEYxZF+BwPobsQlDn0HDpcmp0LoKORKW9nZQ74tzzfqSdLw9U?=
 =?us-ascii?Q?NnVcZRxYQosqb7FFupWYSemvxUL2N5bXFOAlURtf1vT4WtBhV2FyItnC/AFC?=
 =?us-ascii?Q?pIezCG4KkD+yvIam72KUUIwIWVDacvCHBPsXK2Ym/SC0WjwkPv1gLdVyxx7B?=
 =?us-ascii?Q?0qDdlTk+lo14riWDrKEHjtJ9QkRdUus2owDmXRuLzQPPp/KXydGoXmiZl1JN?=
 =?us-ascii?Q?TpnMn5nRHfqcjlw8lgt0kw+1a0hoG4F2MBQhwbxqG+RW45rOIF72rTwisr29?=
 =?us-ascii?Q?K8gOVEPKy5QJkKx9NSiGyLDEWWyqMp6X2f5noeioNvHbIsDkzn9uhx8Qp2yP?=
 =?us-ascii?Q?6QuBzCbxin8LHXbq4IInRMNbT1ykKjE3iGRtzCsJRTqZURj5cHKABwkP0h6L?=
 =?us-ascii?Q?ctTbdOoH2SopXDia4UVmlvKyOj4rUpHT3H/bOW7cONQtsJgG1Q3EebAcpxa4?=
 =?us-ascii?Q?Vd1aOEnpT1Hq+Qv/B0dNqi62YKgOteiAo64oqK3l1zJ4+mQkpKLFH3XSeWym?=
 =?us-ascii?Q?b73aa5yJHOdTY1T4tCAI2TpFtdpJ2AjWF++ZpRnnom83Ydp/n+lQ5vJKmbY9?=
 =?us-ascii?Q?AlgRvYiGL8IQ32Z6OzsxxjXTwEFSngCujZtjgzQZi3Y8Uz4cXO2Y727muGnN?=
 =?us-ascii?Q?vfuhxQu6l5ipkvgmSa/kv3MSgpWYcBWWHBMl5ZywgUfh+jXygQul2roA7grN?=
 =?us-ascii?Q?5tIwwQMjsOEIzQBB93TgkWEbdaB9Ica5KIfvPC8RsAzDVtkV3yEc8aLHceWZ?=
 =?us-ascii?Q?UygqNb41gvF1B5nZQIIMUd2d8BGdHU5FZBPinjd+CeScmqbiRqvNUlq/SyVb?=
 =?us-ascii?Q?XRqtNLJvSCO0nj1k1a1/MdW0aOn9ouoAyRTvaksOH5kgS8O6euxmy6mHYA7T?=
 =?us-ascii?Q?q4zABQSdAJWWmhlxTWxRddFm2dDxhMhSkf2llUcgKK986F24BTvQRGxa8Pqb?=
 =?us-ascii?Q?TEt7aro2BFZrdiJkkqx3UWwB8+7ltv46ORrANnNDDNxTFu7Jh0z4h3GwKoxc?=
 =?us-ascii?Q?7XyWi7beEUeeumEf5wAYzDRblQ0LuIt5CDRuHskSJhsB+mRLmYDLRpw/2nqn?=
 =?us-ascii?Q?+MY+xENdVZOwjxZqRCef5qYJO41Tw3xhInUBKOcdvwoKHc/g6sOLipz9vhLr?=
 =?us-ascii?Q?tYwa0kKR5SZ5mhJzNO6A1mYqvtTMxFB+Zd38Ews8qM+U9p9r6CRmVeCD2avY?=
 =?us-ascii?Q?cWRBFbyn4X7djuG2qH2atyN9uTriP/C9PQzjpUWmetPj7WkIRQdB8T+Dwi3i?=
 =?us-ascii?Q?yIUlcnj93pAKSZOZHJvqhcCQm9zkGYUoOIwTtk81GZ34fD+hMknEWOtvEglK?=
 =?us-ascii?Q?Q1z4HOnsaS6TkrpUmXVfM92Nmo+E4Znl8VEmMZU3o6i9I1vjtysamg5AgIZc?=
 =?us-ascii?Q?5Byh4SFXMd9hA3CQ603wOiU+F2N+AFaEpvIMJCj1L7r94/G0LHgP2Io8ScBP?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034efd2-2990-4c53-b38e-08dceec9490d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:32:26.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXJOiakMvW8UXL5mwZ1DTuKJ6FfaXq8GxyItVy734mLv2asn6+wvit5DMvkk1l2VbX6Fa7tU5Vrtrb+kvb42Zy1wBx4LQGHF+WfxIh+SzHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > In general for CXL I want to say that no function should be converted to
> > use cleanup helpers unless all gotos are removed at once, and if the
> > conversion needs to reach for scoped_guard() reconsider even attempting
> > the conversion. I.e. scoped_guard() is a leading indicator for needing
> > code refactoring.
> 
> I don't think it's a bug and ultimately Dan C didn't say it was.
> It's ugly but a simpler path to resolve it logically is to
> stop using the variable port for two purposes.
[..]
> 			/* retry find to pick up the new dport information */
> 			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> 			if (!port)
> 				return -ENXIO;
> 		}
> 	}
> 
> Whilst I don't like the code, I'm not sure a revert is the best way out.

The revert is for the scoped_guard() conversion which was, innocently,
trying to preserve the subtlety of the existing code.

It is true that the subsequent find_cxl_port_at() saves this being an
actual bug by elevating the new port's refcount, but it is subtle beyond
reason. This whole function needs a re-think, not more band-aids. I will
fix up the reverts to drop "Fixes:" since you are right there is no
actual bug, and those can wait for 6.13, but intent is to say "let's not
use scoped_guard() in CXL without an exceedingly good reason".
