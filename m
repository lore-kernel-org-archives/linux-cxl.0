Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784432C8B
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042732; cv=fail; b=S7HMiYENxKUAxGx+Jg0za8Hdrb59dDipvUKCdqjIy07QMUH74hSvbUQaNHYFrC+n/yODxJx/AcCHrBnWh3GkNow56gsMOpwU8xzkszbe6B/6vt3k/J55aYXRxCyZxGVa5iaRPo93dVWUgyh2rBNCHmwBQnyw3nrJ3G5WFXCaFDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042732; c=relaxed/simple;
	bh=Ska3TmhAdIqeYkpe+h1k+/LFUvJ6/D1JSxAQefmev9o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R0PNE+FOufSqBGi6brRvhjPapjIMldWMhtbtbBKo23N6CS8KLrl+KXKUutugBvpHdqR2XFA+3koUbKNhDB0s0zlOOewENu+OpX2QVOKzWAfjeJRQpCh9HTfPiE3xwhvxth0dlmldyLwQFG/szrH0rZgwf+Q9aRZAj0EkKKzamRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDkUrOeA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDkUrOeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778042731; x=1809578731;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ska3TmhAdIqeYkpe+h1k+/LFUvJ6/D1JSxAQefmev9o=;
  b=IDkUrOeAKF/VZFEqzY8mkH+Qj0Tt0qvalz/5Hrn6AxuZUlNspoukoBv4
   r5d5BguJpAPPn25F5k8mUx++YAtf0WYVmugBemT+mjpeXT0HSMMXH+Q0s
   dTo2VjIgmc4kdjIgWjzGpKHPiZx9GK2wJVCk3lTfIxwEFgYg8pL891pzL
   icaPiUYQ1j9cCgJE14MDHEaQFq6m4TcWpf8z2PdlEko05LlaY0m/LqBdx
   6K6ThDLfO24a3Sq2JN3cQcG+ZQB1I877VKsEAtdbDtv2dO9eBj9wYHXyy
   6lWMK1BlBoP53EKsxPdzfKepPox78YVYrF73PJC/3yCdgH/WZtgLNUnNN
   w==;
X-CSE-ConnectionGUID: eC1T9so/T2eY+rQlnqripw==
X-CSE-MsgGUID: mVwWjmb0S2eV4vRcChlDsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66453613"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="66453613"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:45:28 -0700
X-CSE-ConnectionGUID: /ajmhk9KRhaEoiQspZMkSA==
X-CSE-MsgGUID: I0w2bpGYTkimRvmgGfi24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="266356296"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:45:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:45:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 21:45:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcVPu7q2m9ryU+RpIT1W0L4pkRqcsYbij04rU9sYOBgxwFaexxV/F2BRQ3a4vLdOq+2p0WNmCPGZ459lfx2zV0djKPTdeibA466nCh4O9yC7JDPq6wrhvZfqG4HOGlCHPiQuko1pTmefrCl4VyLGMvNU4VsATRCVu4/peSaFQ5V8ZzEXdA+861bRlK36rNHnARMy1docD2+rVPxRwc8H+dUQ/a6vnHVznD0RklRfpv+5KAB/xC2BhnjOnIpKujYKKJe0iK7NsOgrQzwO2bLgTNWunpgqGwCyMqFac4mbY5zpaEzCPfF3Q6QfY+7GB1cCeL95YqVQc8kxDbfnpDXswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhC3Hc+9PiJCEctPet4sABr3Rqx/JZ2AlblE0l20UfU=;
 b=lC1ENPDs+EqrtBjV51U9ojIb25Cmg+iDGfE3hlvQWbvNDjBuFdLKlRCdIPFkRhuxKSU/OATXCQf+NDlP2yVcAYcp+iNksLVoIi5yC98D/2/JRfQ5OOKLrsUoSreORxiMmGK0auzfqiam/hJetebr1S+YVQu4vT7CEct83zc6l6nFYei/ucXIDpLYH/s+VxofwWkVDig2JFIwAYA2o4wCi7UrBFGKerNjMkK0jd+bzLZ9k1RufkLQCJaShmnUj388t+xyTegrcH2lcUWpgTKbT1HeTSyPn7ebkV9zh59/679HH3j3K46dX8Ra+gtwZPygZsGhrE7zbC6oAZ7Jl2FHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by EAYPR11MB9585.namprd11.prod.outlook.com (2603:10b6:303:2c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 04:45:19 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 04:45:19 +0000
Date: Tue, 5 May 2026 21:45:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 3/7] cxl/test: Refactor platform device enumerations
Message-ID: <afrHW-6Rn9TEbwIj@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-4-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|EAYPR11MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: fc20222b-49c0-47a4-683a-08deab2a4699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5R+KhpURmjwZjco4PcXQPWelE8AebGHMqrHS7LW9iAYQN3+1QHNwUCcs3M6sR37J5TSCqClThnfziUAM+FThHo1et4ntfjjyaSjWLa+CxDLCG0JocYwgH5W8iaW0vlsjAIU8jCVR0vIuYMtphfVqIIwBZ+62BYKtmbHAKP61II+zMBm65bgpqBo/T+IFTIUdW8nn+W2VdXDucdHJw54qJovGI8sNCS9rUDlLBRKBRqydt7s5cuT/+JkJJTzzreCp4A4S1D5RwK7SYbYTrCibuEUsgJOll7frH1NCnT+0uM5vvZg6r6RNeT7dVbKDxsWzlWHnj7FpvP3JdyJ/xMfnHFeb3aYePEfiFtTAinblq4fSNrQXSM2ifjVn7QaH8kQ/PzdphWy+2UJmjZBJEHrMm+2FUE92DZF4DFCjWRfjG60LBgRGItsfz1SzgHbaHoOf1HRI6D4DZ/eZsNUaTzvgxdVbY92Bnim2MAF2pOl1xwVN0g7Ft0XraBN+iba5P5WuApCwh4plWcuSD0/zAym34X7jlq8s2H40m5zQ/q8YZbFEgdrcFfy/a/Y/F/7P+GnKKgYascrL5unDcsrDA1DcCkEQYVS1rJ2l7/2gDR2ECRD5VEnwEIWlogmEG5G6Qo46UXK7b+O7Ma9VgOvC0P18PvjV6+9wo0pV97MrypJOAeU7Hy8smiXqCRCexjQKlfwH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMvxcvpx1NhxZzrt2c6pfV0IPH9+XcAqu2dM1zHVkdnmwjdGwztW9DAwGppN?=
 =?us-ascii?Q?V5LCGckLHAplolbdPhmmzBQCTSeRnQn6k/JqnLIe3CH6/va1K4ZQMngyVegz?=
 =?us-ascii?Q?vDrYIZZifTdLHJF9BXEkHETGVVPmIZgWrJOLrXlKvas56mqTPqjwYC46sY3D?=
 =?us-ascii?Q?3bRZATob0FTYB/O3NaZmrmNtC4Zi1sJjp+/EMi0dPYhERLx+0/UcFTbL5Ujh?=
 =?us-ascii?Q?+6SACiHgFcczuIWI0mf4Fq6KzfhyD0dolAKS8Usom4VUd36p0iKu9jul9ky9?=
 =?us-ascii?Q?9asdvPW4HuUXFlEeEKvoqaSoRqiJd2e4C1WA/VAnBgJOn7ySZpb4dULN0YtI?=
 =?us-ascii?Q?dgQTp+03kEzM+YdPgqJQ/f0gmWDEdmZ7es1pPIPuZyw4Ua/nwmlQf4PzapC9?=
 =?us-ascii?Q?qpQovsyMeswlIDiUJsg7qC/bAB9oJLJxRhDYpjY6JXGYnv7fgTxwu44yLTaF?=
 =?us-ascii?Q?UjE3jla7WDzNlapC7nWi5nemHgxDxqvHJJrJyn0/Pq9wlAaQgb7016h44B6U?=
 =?us-ascii?Q?OEHt3nUboXja+wNVmqQfHqIj4/H5IR0ngrNPhTp9FaHMK7tQpl6c0H/nvkuo?=
 =?us-ascii?Q?esoS5M1SycCcfiPvSGrz5ziWVhirW/mrfTNlvxVH82rAvIu2ciUminXEEEm5?=
 =?us-ascii?Q?YJPoYY0j0yesjgMp9UwYr0CVQLdNoW+Vr/qyHcBjitQKAeO+/eqgW3GLh6Vk?=
 =?us-ascii?Q?wUZqbnDbC4ww5P4Z3EMBoSGlTzqbJSNDMOrNCstWhFS22aw8/7AysxyyBv5o?=
 =?us-ascii?Q?9icaBB82874APCrJmHZ9hoSMgvVmzV3cddc/A3wNPos/oLpdJosirjR12E4P?=
 =?us-ascii?Q?s1tEcxiKsj+mvdSF1ZxSIZ7LdSJ/F/ABCeB4BJFSt4adQbYxyxF2aZuxAzkL?=
 =?us-ascii?Q?kKA7xwe7HDTVOaAovKp5mBZbvlb5SM+Chfr7KYIAGu11wWo7hZXEVqNM6p8y?=
 =?us-ascii?Q?MHQDocjGHFRP2urWjV+Ut7qqWzk6r+yC5WNGJAvSHy7EmGdLglCGUYEL89rC?=
 =?us-ascii?Q?Lp2eK7/1KXAnAvJZRgprLTKMKeBxvf8cz5ejnE6ijdQAGdGlrCcigENCYwDT?=
 =?us-ascii?Q?+FjrLDE85crbhXqQQTwfRVI5t75yfDW6As7VxOpOz+Ui+JoPlcH89ZMr5Wow?=
 =?us-ascii?Q?MxFlVguCT2sHq7FTFfFOn4BpQgK9JqLy9Tgn5GZdDO65WozZP5iP2KoztA8F?=
 =?us-ascii?Q?5BE2HuOYN1L2p0SZ8wzjKuiqmly2rryldyEny6o7jEybg4UfU6GiQpovAkMf?=
 =?us-ascii?Q?7MrsEAm63SP0zsNlordlUro/ouGKjOwktOAamNVW99SgKmml0KWP9mDyDNHJ?=
 =?us-ascii?Q?iQStuh86xGIlbgAFKJ5Lh7hZUE0UZOE5f8bEcqOYHMj2hXVhUdDOi98/oR8X?=
 =?us-ascii?Q?PnrQIVm9z+EOk+SCL44s1SqAcDGFIi/HtIG/oZHP7tTk26X2cWJFnKEJW94H?=
 =?us-ascii?Q?wgohih4CNRv+0szrocn/LkCBoKYW6mJH3gGOsKPx+V8A1dtkT/saTzaVXa+5?=
 =?us-ascii?Q?5jjMg0hNS6Qsnr1Bim0K4fGGjemGPSQT4oZARuT/hPvyNVzBnzgqaIM9SkXx?=
 =?us-ascii?Q?IosbBBebdqhl9jLOJeDxw74IFxVKw4hvtOKVw7mgoC6QRl7s2KSU8hLjz86F?=
 =?us-ascii?Q?0nxMXEE1rhT8iWThjwJL745ZZ5J+qVHJ52AGmJuyPTgQijLrkMJgefSBdv0O?=
 =?us-ascii?Q?BzPtO3zbb3AbfVjDOF6Q3yUi/psiQ+VKM46llrHgUTLTczPqu1jQ25mwby9T?=
 =?us-ascii?Q?nyHnuIZRwI5lrlChDtyMN2BF9XtOANM=3D?=
X-Exchange-RoutingPolicyChecked: gnv8YVpvOnwZ0nNnOMmhYC1AUXwowvlXOOau05S+aLWFq2EE7uGEZuAVevbSjbUSwemCYOOOmi0hilZ8RGGX1ygmake5Wh2Hh75BLkAEp5dM+DTZuafBDOYnHS8bVEczAXdOwX13OdlswdhHwXKC3eyRp8q5gEEyVBTmvg3d/fSbXFxrmdsgkcH+b9lT9XGFq1NB+Uvd78pDbon3EX5D55CJKVXk85CfQiLPTxOIWoY1Cph8jvpb2mkiadqLxKMB2bNmUGlt3UNpvjd7FI3armzhKZ0Hi7/hTRNVzhG002db2pC3gs1kZlUBaQeSTbOOtMXtncOwYrcU09v7kDwt7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc20222b-49c0-47a4-683a-08deab2a4699
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:45:19.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLodUsB8qCoQsdl0+ZBwvq+sGu+8NVGimoqYRSU+EgCQHNgY2EciJ/sWmf+ZXsqG/QgK7JMSAvKGtIlVYhpKjsfioQDy0u7+y/yYAkbEgIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9585
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:33PM -0700, Dave Jiang wrote:
> Split all the host bridges, rootports, upstream and downstream ports
> enumerations to separate helper functions. This should make adding
> type2 hierarchy easier later on.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 327 +++++++++++++++++++++++------------
>  1 file changed, 217 insertions(+), 110 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 903223013e41..5fd73f0634c6 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

snip

> +static void cxl_usps_remove(void)
> +{
> +	for (int i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--) {
> +		struct platform_device *pdev = cxl_switch_dport[i];
> +
> +		if (!pdev)
> +			break;
> +
> +		platform_device_unregister(cxl_switch_dport[i]);
> +	}
> +}

snip


> +
> +static void cxl_dsps_remove(void)
> +{
> +	for (int i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--) {
> +		struct platform_device *pdev = cxl_switch_uport[i];
> +
> +		if (!pdev)
> +			break;
> +
> +		platform_device_unregister(cxl_switch_uport[i]);
> +	}
> +}

The bodies of cxl_usps_remove() and cxl_dsps_remove() appear swapped.
ie the Usps one iterates the Dport and the Dsps one iterates the Uport.
I think these above need a switcheroo, and then the call order below 
needs reversing:

> +static void cxl_switches_remove(void)
> +{
> +	cxl_usps_remove();
> +	cxl_dsps_remove();
> +}

skip to end


