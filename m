Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F951AD3E1
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917463; cv=fail; b=KN1mgacDcp3k8HCQzbsSY5eiA/Ps9DET5aFbXNhPJaM67Zuh82xlXVJ2eH6V0xueCF4+aSozDqnT5V/KAUwVk6d7RIytnX2mYxfzbDYWsSxcBJMXb5lFpRAkHpotmQ1thfkeapId79/NeWabPQucElqDrl+BcHNxmgqp3vL04gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917463; c=relaxed/simple;
	bh=BPAl1O2QwmvfEmcsUN8akKDnUIzZhX6Or8jsYJ12nbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Byo8P1TBwWGpUNVwathVVgQx93iL7YtzL22s72JXWKCtqKoWy+O4ho14wLRt02LLDukq67yYq/c9OrbD5K1FBo5xyxnGfdEqjc8T2I1xWvsq+MxKPG/r65NHJTRlJ+ekY0w5GoSfkcskCdwkSzsPK6g96oiPbT7pTyM00veuCws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ207D1z; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ207D1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728917462; x=1760453462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BPAl1O2QwmvfEmcsUN8akKDnUIzZhX6Or8jsYJ12nbs=;
  b=fZ207D1zDSCDRdf7kbtFbisfAsX0cg1aLqjTuhzIpd2jh4afhRDFyZpe
   4PJiTafH455h9D4RY19VJk8mAF1bghLOAn2ucG2XQyjn9F4SHbvQaOcO7
   zx2WhZuBGQ61KNuz8Jp4+lxmdVD8gdr+4+wVICYNyS+ZpnQW7JIrC2KkX
   AGL6KLed5hVxzjFZvaxSYMKb/MxPgSlanPRoykZW4K9BMsPtHHJGNOwTu
   H856Pkc6Kh7Aq08dbW4DMiLPjxwYDeZSColDXdIDyPtviZu6mxaA+2WzZ
   sIB8AfP/jUwR6mFbAldjT2F0YbiWxqrPs0mGd/IMvTQMLKOTPeS+XNJEE
   Q==;
X-CSE-ConnectionGUID: 7pwyZDgNSxSlQtkAMlmJXA==
X-CSE-MsgGUID: VWLSPRCMRBeEU7DL1WU+rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28410394"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28410394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 07:51:01 -0700
X-CSE-ConnectionGUID: WSSyJeGcTOy2UsGVGeGxbw==
X-CSE-MsgGUID: srwZb24lSAinNTT69IWaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="108330152"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 07:51:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 07:51:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 07:50:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 07:50:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 07:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjBiPQszTMyTMdB/AnYQcOdUK4TkRMxXg2Zxerao1xaLQeJXEO+1mObxD49vf3Stq/r2mWSBSvImv7v0RjlmhCpboPMtElwg6OmtNwvDayWdT/t2xKOIk+FjKqVswEe3KN9mN/cHMOynOLpzIcKFOgoPSOqrNs4dN/moVHHFYTWyvtR9WaOuQGkyrWdhYseh/AiaYNLmI6X0SH13+BrcqkWEPuhpkXC1j40buN/2tJjV5jkhuEgjIBHlN9yvh4/4w7UPBk/jubgwPkrKIExGZQ+jUBfI5SXj5MlG5WpsCcWg/fLFSR0UY7oZyGoi2zcUZ0wlQbuvsMZw+EqVeCtwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9owxnL5wW+u4xU2815PkB3hCFQ25cQ/GgusCQuTPe+8=;
 b=PGMf8K0vQmLdWzOPtuQ7kvv+nBHRYFK0oPeOOo1B7FVEJGZgUsnXd4+3mSky4nJkZOo0mJSR5JDBvZY7nY0uqkXiNji//ZUK1BiYXAvC6T4LVihHSvZdwrx/lPNj/4huEDQzrR0gq1zPOymgbWojaDWA99H6qTAV+jLCvyYf6Vr2E9Ryk+mKxy0ngtM2KJLpFTJ68fE/Ql1+YODNyqmDpTXpZhuH02lZ29oJ1P3yrgYMcDOZXtioy2zo/iELvOFk0SG0Uo13OCAH7tWq/IKIH1iKLfvj/rZTAxxj5QvVgT+0Ac4gRptVQLoml+tY7mbav7CYitrQGvzgZmaiWWYO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 14:50:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:50:52 +0000
Date: Mon, 14 Oct 2024 09:50:48 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH 1/1] cxl/events: Fix Trace DRAM Event Record
Message-ID: <670d2fc83b507_1357e2294c1@iweiny-mobl.notmuch>
References: <20241014143003.1170-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241014143003.1170-1-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d1c815-b96b-4d98-18d1-08dcec5f99c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pg28EiGlGLcxBQQ5dVwK8wqyZ7QdTbGDgWqSUuzyJVDjhoiGe7RjkwxmuOGr?=
 =?us-ascii?Q?6Lzvl9ohHoHgi5S7415UrXQa/+IW2qHyqw9zhKD1YIRwzh9ZPcfh4eIBwhvy?=
 =?us-ascii?Q?Ea7usVzkQhLsqiqHuTH9yaE/TjkYeVZ5h+APxal5AjU3/Jhjx2KCnxaeHxd1?=
 =?us-ascii?Q?CMgtCbrd9R/YZU4E6o5Incx5ZG5Yi/PUPCStb1jHm9gZtcsJhahFM2v2gw02?=
 =?us-ascii?Q?EITNKOVNzaC/87HCoKZJ2ONVF9byWZ29iw/Hys1jPAM0lFQ4hUvJMSAxX/L/?=
 =?us-ascii?Q?lFczFBER4ZuP43ua327v/uPQV4Nm6uOFwwcF9WxaKlP0a9kI0nOiqdo1AfVc?=
 =?us-ascii?Q?xYyyr+UC4mquqEQariehk7yE4NB8maZ5a7y7+HXyXnbK3qqF4tNkHRAhamH8?=
 =?us-ascii?Q?fOnVHwLGTVtFdTH2uP6GLs1SzNsLmjqJuWhahPXrA//NJunIyfiXA0njXwBX?=
 =?us-ascii?Q?wkoHLxcQext3kwqQrJz53u66rj09HmmvlzicQzeLr6QWjjvNk/JygKjZuibl?=
 =?us-ascii?Q?agVRQiAHLcdLXv2gJRnE1eSpDhqgBtqMW5rDJ9BR+JWwWwfg43bndMWomcZY?=
 =?us-ascii?Q?ci8OsQmHIQSgfkOryjCtg9jpVPVuBLsA5bYevvSeVR+VmO6dLjxxDKSu344i?=
 =?us-ascii?Q?8h+XTCb7nJ8NcoiVcjpPmGz9145835ILEAHom5m2RbvG7/uHuCwVcwxTKEi5?=
 =?us-ascii?Q?vv98aH8TV9oJLNNFRYMopqPP657hfgozHtMBgPxnq5VEBn43j8bVV3H0s6Ha?=
 =?us-ascii?Q?rIecDiincTwHcIyFWb6/NbUG0GdfWDB0xCGzBxZcLQJ8/HvTgXjnE/LF/64x?=
 =?us-ascii?Q?3xAj2ynmQK8eRq6GSZ6QzSi2rOa4sf3qPrKr+bnvgG+97IjMuo/56xIXFbnn?=
 =?us-ascii?Q?wEEkPiGzYNPaITJh8cKXrgFfILO+bj0xnfq7xC8H8xBC2NT8iEm348oAkFDY?=
 =?us-ascii?Q?qlywOWVtzuu3HNpZ1nUnGYxDiCAbboHx8nhOBzLYC0XycnMf5cq257FqL/Lt?=
 =?us-ascii?Q?inibjnon2D5TvcVmQNd9rZLw0w0ZQCPFQHNyhKPQYTybwfV7LlC7JzJuGzNx?=
 =?us-ascii?Q?KXK17LdvCOAaalMpSGet1tDEUQiTUBcITw4NeISEpIdD0DgkGnKD6dJM9L8J?=
 =?us-ascii?Q?9WeuGztJ6ZFf13Zdjru1oWOTY761zJBFSef3lY1x1HTkaKL46pvvsylJvh4D?=
 =?us-ascii?Q?3FYVI3NW8WlBkoPHjfoAz8CPZ1SMa3/pbqpR1HbG4U/mdU5htgnkGi1rq98l?=
 =?us-ascii?Q?+E/ML7kjG/Q7noCO9b9xSvAoPhcsFZc+el+ECRsI7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCZA5zYNjhtv1P0vIwopb73de8zfQxcUBMD5DaU7gQqWa3H1emE0COhvPW55?=
 =?us-ascii?Q?jQ0MA+RvGDjENvTk2Bc4CUc5UXZHv2j8zWCpmXqaxShE5tlmzFOS8D0CsmlG?=
 =?us-ascii?Q?ygoUQp65hDhfDLMHeAkv87chBGpDV6+rFDYBvUrRmLTrANaQWGvJTo68jnZ/?=
 =?us-ascii?Q?sIthNii9+YnATa6B0vQMlqNBf4yQ4QCGkq3c1BIUpyhzfHakH2U03m17/+ot?=
 =?us-ascii?Q?GvA771xqZfLSy+Nzd0Hnehlt04g5B2ew5/MhlZLiSGfA4IKMLxT4jyYceBR2?=
 =?us-ascii?Q?g8JNejjIuFBf9CTeTzHey0941mDCUyFekIjoqBnkYqP4B3OwzwsbeqS7BdRM?=
 =?us-ascii?Q?XJTI2Ok7sfpbq7BZrf90HZ/BTdD/w0vxwK7VTixcQ+M+vM1UDmNBq+mnwnzr?=
 =?us-ascii?Q?+ji4tW7OyR+hgEu8RQhfn7NsmL+cr3vpIv71roWZdmrW7LX9LUIhH4AG95/l?=
 =?us-ascii?Q?cGsrulBGfu1anfv5wIjAPG50coucaRCqnA5mpMqsXyZQHJVyawSIAfkeQkc7?=
 =?us-ascii?Q?axy+Z2vzXsFt6KYalS/Q8wPx/LpSZiefzDwNsk0qw4ZykJ0zR/r50Ay5jhWH?=
 =?us-ascii?Q?6m1K2i5HgMdoRpusk/XHP7NbYfwiqOUZdO9qBSYAP6mSxYYFr79Yj3IDycjM?=
 =?us-ascii?Q?qgs5ghVsw7QCiAf9rCMjR2+Jh8vCm82wBMvEKf27wHWYaoDhb2JEAONe/qZp?=
 =?us-ascii?Q?oSXIUQ8ySl6XajgtCU3WK5jtAUJlR0WpPmsmmwwut98/WYo39gLCti2609A5?=
 =?us-ascii?Q?HXNXj1AFplvYnlYGGBE7T39Le7Rzn/+eRyBva3rz+Lj8cEuz4vh3sGK9yaWY?=
 =?us-ascii?Q?fITjA8A3gkJASvYC39Is+D2asrskyEkrrOnvD00KDy+WcfkbPh45cV63awYq?=
 =?us-ascii?Q?lhayq/sXSQkscPoxEPSppG5hN8O50Zl7Lslzo8axhmkUSxgDed+2N0WGUcN2?=
 =?us-ascii?Q?PKYsbYexZgGHpiLzn5LKm5YX/v9dZl4zTRRbtyGLdIBwwqvNNB1ZWwWu+EOU?=
 =?us-ascii?Q?jAToNoGI7aQnhSxFiLDR/gfJQtuBvhrG2jl8pbtYoSO9Zi2Yfr1ERtepafgW?=
 =?us-ascii?Q?BukqK6BHRZq/mNZfoK179lJbTZAmqCFyxhp9Bfvfy5E4TbupWUNoAd560bAQ?=
 =?us-ascii?Q?EE4yZJOGaT543SLg/8Al14+yQ0PoqhnA09TgLcw6S/rv7uAtyWI69oQKOUhQ?=
 =?us-ascii?Q?HxPFjRrGQOoc0V/20vBl2kxcRmMYAG93F3/KeQ7iK0N4hRxvWVlimHxea1wH?=
 =?us-ascii?Q?04uzQRVwfChGLC9uUyJjFkf4gixh8lRD/r/fXQlObFAXY48grXtSohF+CEqM?=
 =?us-ascii?Q?JV8mbJ0HDj4A81l81y3qD+5phOf7/e3m+i2nkapRr91muzOYGAbyDR+1RR0/?=
 =?us-ascii?Q?jjhC3xKl037LhtVy2K/mGDhepmr7rIHnChk/Gxg1/wO+5FmkTEsSzChut19C?=
 =?us-ascii?Q?hFjWi0B5o0UduQtcvagkrLf3YJRFxu5f6Z0qXDTyeG7/rRi/RkC9B4xyM69G?=
 =?us-ascii?Q?OYtph9EOMHNnfl8suFJaNpWwXZVMMtupC3zD9V2ippzX2EexBQe8rpfJ6uvm?=
 =?us-ascii?Q?5UACjXD9YTnA+O5W2qw6GVHuXAZ6uRpMhjUHQrao?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d1c815-b96b-4d98-18d1-08dcec5f99c4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:50:52.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAxCDmgrleBphv1+jgc2JFwY4+6+9svbQ4bhNovv3V/JOcrINcl1H/GuNIQ8vwQruDptiSbB41+gCzUxOvit9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> 
> Fix decode memory event type field of DRAM Event Record.
> For e.g. if value is 0x1 it will be reported as an Invalid Address
> (General Media Event Record - Memory Event Type) instead of Scrub Media
> ECC Error (DRAM Event Record - Memory Event Type) and so on.
> 
> Fixes: 2d6c1e6d60ba ("cxl/mem: Trace DRAM Event Record")

I assume this is causing issues with user space?

If so I will add...

Cc: <stable@vger.kernel.org> # 6.3.x

... and queue this up in cxl-fixes.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
> Updates for event records in CXL spec r3.1 will follow shortly.
> 
>  drivers/cxl/core/trace.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 9167cfba7f59..cdffebcf20a4 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -279,7 +279,7 @@ TRACE_EVENT(cxl_generic_event,
>  #define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
>  #define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
>  #define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
> -#define show_mem_event_type(type)	__print_symbolic(type,			\
> +#define show_gmer_mem_event_type(type)	__print_symbolic(type,			\
>  	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
>  	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
>  	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
> @@ -373,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
>  		"hpa=%llx region=%s region_uuid=%pUb",
>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>  		show_event_desc_flags(__entry->descriptor),
> -		show_mem_event_type(__entry->type),
> +		show_gmer_mem_event_type(__entry->type),
>  		show_trans_type(__entry->transaction_type),
>  		__entry->channel, __entry->rank, __entry->device,
>  		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> @@ -391,6 +391,17 @@ TRACE_EVENT(cxl_general_media,
>   * DRAM Event Record defines many fields the same as the General Media Event
>   * Record.  Reuse those definitions as appropriate.
>   */
> +#define CXL_DER_MEM_EVT_TYPE_ECC_ERROR			0x00
> +#define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
> +#define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
> +#define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
> +#define show_dram_mem_event_type(type)  __print_symbolic(type,				\
> +	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
> +	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
> +	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
> +	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" }		\
> +)
> +
>  #define CXL_DER_VALID_CHANNEL				BIT(0)
>  #define CXL_DER_VALID_RANK				BIT(1)
>  #define CXL_DER_VALID_NIBBLE				BIT(2)
> @@ -477,7 +488,7 @@ TRACE_EVENT(cxl_dram,
>  		"hpa=%llx region=%s region_uuid=%pUb",
>  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
>  		show_event_desc_flags(__entry->descriptor),
> -		show_mem_event_type(__entry->type),
> +		show_dram_mem_event_type(__entry->type),
>  		show_trans_type(__entry->transaction_type),
>  		__entry->channel, __entry->rank, __entry->nibble_mask,
>  		__entry->bank_group, __entry->bank,
> -- 
> 2.34.1
> 


