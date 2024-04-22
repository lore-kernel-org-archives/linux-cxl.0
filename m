Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E651BC44
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821725; cv=fail; b=hRmjz5mMQaHm7UMcyux/U/FohEdxdEGgCiSl2WLideEQwg7SeCLgloZOhk9zX9ceoSWGrj8P22W/s9L3y2BGtI968Z8BgexBj1Vg665R2rhx7I/oWtbfmQhI8CxflPcRBmdI821igF7vUEm64cs6floSQpPPnvbbq9lh7xw6O/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821725; c=relaxed/simple;
	bh=lW7rvSOkxbYAY4sBj/yTjov96bVOwCVGLzsYR30u6WU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgmklNRw/BOqe3yqQe2kmhxPM0hCtYCw0GJd9a7NwQ3ccmX4TFIKelP8x91/awHgiInuzzCcRW84+9vPKkzWVpKBofyqudCm2bLqdgxRmgVmI9iYQKvXVLpSzBomaNI/SVDNlM6U96ueHe9FfLbQcjAZ5kgsggTXH7XuEqWcdyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KORlNooH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KORlNooH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713821723; x=1745357723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lW7rvSOkxbYAY4sBj/yTjov96bVOwCVGLzsYR30u6WU=;
  b=KORlNooHsrezpXRAn9LqwgQluup61xzdX1zeL6/WI3p/dU1dSdc0H6ls
   PgmWlyC4mmEvLAnRQgJ2CoxEt/OCiYQHphgmJSDE9fqR0iRhhnD01Zqry
   Vc4fMOE8n/QTmTtlwvKiK1APJN7i2e/TRqd58RC/1YteMy8/JpA48QiOm
   fiTQ/XmNZKuFJrHq3Ej0SC+ZmRgKrVf/ptAV7Un4cH9/sPBGLcf3Gdi0d
   gpaHRd+Q1O3qVkm+qPLxvEG7DGP8iOlTeDLa1z7aWudid6v9cdSBHijoZ
   eM89SaxvAyUhtl43XMpX1If2+RjWz83l+TOtHzhwPiruHTs3/KkTS4wSv
   A==;
X-CSE-ConnectionGUID: TuP69q8KQxilEE4KXJRwCA==
X-CSE-MsgGUID: f8urz9m3SXy9NjJ8Wuqmog==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9507458"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9507458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:35:17 -0700
X-CSE-ConnectionGUID: T7guUjBLRtC4hqZjvUzklw==
X-CSE-MsgGUID: iDncJCG1QKq6uQmj4RXv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24122685"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 14:35:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 14:35:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 14:35:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 14:35:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 14:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bByui3auOzuxvkfJPLcZWaZAOoQbtY5Z+syE0IjSP9Uig7Q8kwTERYU/pYqvjktoUf4bJ9eWl411enQCnK6rDafeRQLwyihPjiRqGuL1UvY8bRAO7WR+9sk5dRVmT2DYQUBNtW91kgEdI0P0feddEX68ZZY+VJoFIvJsIBQJN3f6oF6olN73BCDyO+zLMUT/dw0q3VLQtDP7tugKttFrLI8dIW1gnpgWQZM5AWmY9FNhH/JX0CHUwrZ9x5v6N1tyGDckRmKOLWWXXi8s1sUVH7Mi/2H21BD1BhhzLs2o1RkJ0JOhHzGXiX1qbfphysHB7sVTC/Af7xdEy37hlCjXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uPXfGkrax+YtdKBh0zTRHWaJ+PyMySCzAecwMxG4/E=;
 b=bs3/xcVbjnsg9bK04yZE/xVsGUoIqx79FFWqBCShCLdFTcBmRMhDcnInXYWQ2sDobQNLXeVrkyGwOwfmKhpkw2x/RHhRD5aCRI5Gx7QqvYtiK3Wrym/SbG5566W1OnWqRwNV78QHYMr4OicyNEcrP+yTdBBs9r6B1mH13fyHK5C5ZRwDTIvoHHHC33XTHGhgvEDRhVzXrQXS2wBs9KjP5eF2MVRIhEsSqM4GgVWl+ADT3kL9mr5KizHQMY85PEY1+lI8lInTOsUbw+3BTtAnJIJqB/S4trdoI4PAYZWaqO4MeW1PuBquLHxAazJ19kxoowPinjTRPHBYoPinvod/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 21:35:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 21:35:14 +0000
Date: Mon, 22 Apr 2024 14:35:11 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [NDCTL PATCH v3] ndctl: cxl: Remove dependency for attributes
 derived from IDENTIFY command
Message-ID: <6626d80fa51ea_ab5652947a@iweiny-mobl.notmuch>
References: <20240422211755.417632-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422211755.417632-1-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: b8126d2b-a8a7-4139-c22e-08dc63141868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2jcjR/f8kvO9ilZfkfTWpQkL2f2XuNv86VtdkQkSM3teWKjPi1uyHcCzltY+?=
 =?us-ascii?Q?leS87UEf9CvoqgQRkdXyKdJJ7IcU3HDWPOX7A/dZffSOfstQUuZ7C5+Mhy5g?=
 =?us-ascii?Q?b9oo9fUhNSzFzqxPbhdVYmAmXZxnMRymV/8YelUWHHU+LPQVTbWZRzz4jV4y?=
 =?us-ascii?Q?2Q24G7BHPwFGmRC+4zO+uuPIl7ir7wwIlL1c7DP4VUKt0TmSaPR0DciTI+S0?=
 =?us-ascii?Q?KmSVvJVSM9GztxwZoGMohZEHoLTYvM+8RY6HygEklzwU6KYHdhhV+8ZGA9uT?=
 =?us-ascii?Q?llHKtIPBxBW+0ejI8rlfoYSAbHFql/3Dc41gMRP2D92TrGZlgJurSMOptm5S?=
 =?us-ascii?Q?eby/VkfgMezdP/oTYxmrcvDtQaLFYj0Z5cIpBtnOnEpxiJHMzdrHCNblzh4U?=
 =?us-ascii?Q?dF9el3BoeJZQG6LltZJwBnWpbfKzmdkpkaGackVg+iZtuqcgJZpNVpRRly+d?=
 =?us-ascii?Q?vkNpQgM6Q16zAKTvLGfEngcEHl56tgOxZpYx76Tn5GyafFgJ0UvX5FdNF6r4?=
 =?us-ascii?Q?wHcAqbSEyz9AyoogduTgtkVBi6Wky84UI3k9GT0i5RhbodQuJxvPb7JYWR8C?=
 =?us-ascii?Q?3+dUpcawVquh5+kCZEl55gpyXbWKJSEq7jIJJF1goqb5kiocibqQHDXXsTzy?=
 =?us-ascii?Q?hOVWQ/9sRzJp+r4kLr+uE8InO8Up5Ir9VgON4b2OlbkmduKVEls3L3OkOjA7?=
 =?us-ascii?Q?FMTKcPYQzrS0XtdxDly5RMsQaUK4t+m02S0B1i85ZU3R5HRSgoj9x2QLab0h?=
 =?us-ascii?Q?RARxUpIIoGQO9d7wufSIuLcdXOgIB9D+vwubhQ0vJAY7atcr+FkT/kOZPyHh?=
 =?us-ascii?Q?0Lr1HXig4jeNjGehAtl60bVCcLqCUrDpC+Jl4ohTPbHZLhSeXJdMkspVFBxN?=
 =?us-ascii?Q?JQC4vnvI6LRNNJN7NQ4jzQZh1hmSERZIafq6mp3fOlxaifMSFmJNzHXBxAxx?=
 =?us-ascii?Q?TXpuRlBSFMbI3YY+uMqXvlTj++BDxSkGAL720WksFl7ylCnXH2fjB6o0gwpB?=
 =?us-ascii?Q?xN52cyaNNhCay9JUXmBteIfRvuWW4t+uvNFFdERmhQy4l/n+1INPBonPO/Qh?=
 =?us-ascii?Q?bJfujzBZTPJlgrWzCHfUDMmhbg+FxClSPsDHvUs9OUMHND3zbzhEtauVwKpt?=
 =?us-ascii?Q?Bwo4OOJi1vuqCT+5ZjU2yjtc5GjNUjpkFDU1VUj+l4kJRmaFMpuubc2IWKWi?=
 =?us-ascii?Q?WvRX+wScsFE5X5HTzYdtlr8GBM+ZK2ZCMjRDISXlDGHWoPwoujWwe9vImxaG?=
 =?us-ascii?Q?VqqWx6AQWQyoM9E9lmXlzNNuirHx2kYaRuxFVla8Zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMhV6f8lKqEDmV5cFnJ86Hz/uChwWCVazNAprrlxqQZJAKwU9qZl33ZFk2RM?=
 =?us-ascii?Q?ZJcENuE6Bg2Q0lNfC3jMg+MPfnmEQy9zQ6YZFZxNEVCw6D8ZTEIBiXh8dk2N?=
 =?us-ascii?Q?B7eUMRbLb0ofV1w6URy/web8Mgmpi1uuPunRG7FOMJhE7+VEiYVcgLcWXkK8?=
 =?us-ascii?Q?Gykk24cqtJPlwFYRviwczyHP/CV1IAxC3xyuB0xgu8mW3l+jkAin20MmJ3Po?=
 =?us-ascii?Q?fGFcU4EtP/19t2804KOQutd/jn/8pp47HZ55uwYnm1dNi+f5I32g62mqX1S1?=
 =?us-ascii?Q?dgi/PxVZpB8XfTT0UAm6CboOBHP4EJTZ0z0igRqNGjCdIANiO0xDz0xHEI+c?=
 =?us-ascii?Q?JJs8FoGauX1mkRLutWo7e+PA1t60KwzCv+ENS8BbzxwY5/Q96isyE6XQJgM8?=
 =?us-ascii?Q?nJAyqm7PLEy1Ky1yU3Key6vl0bOluWTbBoWNH9Wir7wmGO2p6YefecAE0B+N?=
 =?us-ascii?Q?ufiGMTILnMZnxGXzrpsqJYgZ6PCw7j3vI42oEacNYbdHXyky4/fbnd6o4X9Q?=
 =?us-ascii?Q?Gnnt1kaa7U6PZlaHpwthvsi4RMayszracC5Eiafqc6WZ33OWnkNOk+ETLOks?=
 =?us-ascii?Q?NpjbJC7r1/HnPNKSJgbJx0/ZwP75Wh9UXkGPNruL8KjDNYU7OcfeSlkaTbE1?=
 =?us-ascii?Q?iGju2zp+TdWFGtk0hlPJrPwfjzyBGi5+XiG+RAwsD2rR1ohUAAv6v/mV6xZD?=
 =?us-ascii?Q?/gc8TnEVVsTn7ICpJlmnOUXkkUCodcwGFe1+ayXlrG7XoBD5mvlrDpPdpWtG?=
 =?us-ascii?Q?qKy8uMhcN8vQEaLP+0+DlzCeIabM5hJ6NtcErrMEkLVONf2/+KJUNRIl/zR/?=
 =?us-ascii?Q?Zjyr9FT55jcLCUld+LZPe3N+yiSg/emVw4U0XP+UG93ocStEIhSLLddVTlF7?=
 =?us-ascii?Q?KDQvp++Q2n9LxaBPaA8ju7d9Z1EZii48POp4vVT60E/wZbOzUmS/Qy+NdHai?=
 =?us-ascii?Q?pRh3/67Sb78Jlk4VMZSUTnZfoKmf1OIbi6+WguIWXkhue+Ovg2xaawzJUnYv?=
 =?us-ascii?Q?XEaHqoskex6Qs9qokdzvqgxOlk31+fgYHefj3tgnX4tLBCV0me58Ezt0QAhv?=
 =?us-ascii?Q?/jHD3OPdUkGpjGaRyMvJNtcU8a0C/xozLf1MXwBvbaq53PyhGdrv8b/qId8Q?=
 =?us-ascii?Q?0m3MGl3w3XnVwNVA15GmTxK/vn6Ejg7RxQlymlZpbrJ2JERP1fyWTU3JMo7n?=
 =?us-ascii?Q?OlqqEB/QaxbUR7s3rHHWvN/+49ZPS9voujtOLBwVRkmqSnu6CueyGr9ck2Fy?=
 =?us-ascii?Q?bqeY0FNci3gjpgB3cZDemSczXCNvmOvxxeqPrj/4AW7A0sxFFgh0K2TEEkUI?=
 =?us-ascii?Q?zAfDxPoyjkvRY1em6fMtAUShQzTSA7pnF692qCiw0eCTa2Mp7Zguc+ITa6gE?=
 =?us-ascii?Q?iypViNuwanWFiGmAVWIYUGN5lkvDYYikPkKAqacc8bo4dpbViQmVP6o7eErw?=
 =?us-ascii?Q?0C1ldUYCH0nV4P0KaNr6bwtKdW3LCkAZujptAL/2itU5iBi6FZxKE5rCTygJ?=
 =?us-ascii?Q?MWJdYIZ/9yyC8t3O2+LpGsI8bIL+lWAA0rjU6Z5ZGba9m7UOA5xcONKVfvlk?=
 =?us-ascii?Q?w534NXqzg3qQoxRw0U+dc3wESH8mvaUNcbrfXgfq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8126d2b-a8a7-4139-c22e-08dc63141868
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 21:35:14.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6g/FeCujVp9hsQBeVGIIxDeIuF8m3kW72ZPYeMCEvenVJx5IlXx+IWfAcCdmwsa9fmSBGrmRhU7f08wdeEKaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> A memdev may optionally not host a mailbox and therefore not able to execute
> the IDENTIFY command. Currently the kernel emits empty strings for some of
> the attributes instead of making them invisible in order to keep backward
> compatibility for CXL CLI. Remove dependency of CXL CLI on the existance of
> these attributes and only expose them if they exist. Without the dependency
> the kernel will be able to make the non-existant attributes invisible.
> 
> Link: https://lore.kernel.org/all/20230606121534.00003870@Huawei.com/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Patch seems ok but what is the deprecation schedule for the kernel to drop
the attributes?

Ira

> ---
> v3:
> - Check against SIZE_MAX (Vishal)
> ---
>  cxl/lib/libcxl.c | 48 ++++++++++++++++++++++++++----------------------
>  cxl/memdev.c     | 18 +++++++++++++-----
>  2 files changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 91725ac7ffd8..91eedd1c4688 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1280,14 +1280,12 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>  	memdev->minor = minor(st.st_rdev);
>  
>  	sprintf(path, "%s/pmem/size", cxlmem_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	memdev->pmem_size = strtoull(buf, NULL, 0);
> +	if (sysfs_read_attr(ctx, path, buf) == 0)
> +		memdev->pmem_size = strtoull(buf, NULL, 0);
>  
>  	sprintf(path, "%s/ram/size", cxlmem_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	memdev->ram_size = strtoull(buf, NULL, 0);
> +	if (sysfs_read_attr(ctx, path, buf) == 0)
> +		memdev->ram_size = strtoull(buf, NULL, 0);
>  
>  	sprintf(path, "%s/pmem/qos_class", cxlmem_base);
>  	if (sysfs_read_attr(ctx, path, buf) < 0)
> @@ -1302,18 +1300,22 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>  		memdev->ram_qos_class = atoi(buf);
>  
>  	sprintf(path, "%s/payload_max", cxlmem_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	memdev->payload_max = strtoull(buf, NULL, 0);
> -	if (memdev->payload_max < 0)
> -		goto err_read;
> +	if (sysfs_read_attr(ctx, path, buf) == 0) {
> +		memdev->payload_max = strtoull(buf, NULL, 0);
> +		if (memdev->payload_max < 0)
> +			goto err_read;
> +	} else {
> +		memdev->payload_max = -1;
> +	}
>  
>  	sprintf(path, "%s/label_storage_size", cxlmem_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	memdev->lsa_size = strtoull(buf, NULL, 0);
> -	if (memdev->lsa_size == ULLONG_MAX)
> -		goto err_read;
> +	if (sysfs_read_attr(ctx, path, buf) == 0) {
> +		memdev->lsa_size = strtoull(buf, NULL, 0);
> +		if (memdev->lsa_size == ULLONG_MAX)
> +			goto err_read;
> +	} else {
> +		memdev->lsa_size = SIZE_MAX;
> +	}
>  
>  	sprintf(path, "%s/serial", cxlmem_base);
>  	if (sysfs_read_attr(ctx, path, buf) < 0)
> @@ -1340,12 +1342,11 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>  	host[0] = '\0';
>  
>  	sprintf(path, "%s/firmware_version", cxlmem_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -
> -	memdev->firmware_version = strdup(buf);
> -	if (!memdev->firmware_version)
> -		goto err_read;
> +	if (sysfs_read_attr(ctx, path, buf) == 0) {
> +		memdev->firmware_version = strdup(buf);
> +		if (!memdev->firmware_version)
> +			goto err_read;
> +	}
>  
>  	memdev->dev_buf = calloc(1, strlen(cxlmem_base) + 50);
>  	if (!memdev->dev_buf)
> @@ -4570,6 +4571,9 @@ static int lsa_op(struct cxl_memdev *memdev, int op, void *buf,
>  	if (length == 0)
>  		return 0;
>  
> +	if (memdev->payload_max < 0)
> +		return -EINVAL;
> +
>  	label_iter_max = memdev->payload_max - sizeof(struct cxl_cmd_set_lsa);
>  	while (remaining) {
>  		cur_len = min((size_t)label_iter_max, remaining);
> diff --git a/cxl/memdev.c b/cxl/memdev.c
> index 35920fc81d66..6e44d1578d03 100644
> --- a/cxl/memdev.c
> +++ b/cxl/memdev.c
> @@ -487,10 +487,13 @@ static int action_zero(struct cxl_memdev *memdev, struct action_context *actx)
>  	size_t size;
>  	int rc;
>  
> -	if (param.len)
> +	if (param.len) {
>  		size = param.len;
> -	else
> +	} else {
>  		size = cxl_memdev_get_label_size(memdev);
> +		if (size == SIZE_MAX)
> +			return -EINVAL;
> +	}
>  
>  	if (cxl_memdev_nvdimm_bridge_active(memdev)) {
>  		log_err(&ml,
> @@ -523,6 +526,9 @@ static int action_write(struct cxl_memdev *memdev, struct action_context *actx)
>  	if (!size) {
>  		size_t label_size = cxl_memdev_get_label_size(memdev);
>  
> +		if (label_size == SIZE_MAX)
> +			return -EINVAL;
> +
>  		fseek(actx->f_in, 0L, SEEK_END);
>  		size = ftell(actx->f_in);
>  		fseek(actx->f_in, 0L, SEEK_SET);
> @@ -561,11 +567,13 @@ static int action_read(struct cxl_memdev *memdev, struct action_context *actx)
>  	char *buf;
>  	int rc;
>  
> -	if (param.len)
> +	if (param.len) {
>  		size = param.len;
> -	else
> +	} else {
>  		size = cxl_memdev_get_label_size(memdev);
> -
> +		if (size == SIZE_MAX)
> +			return -EINVAL;
> +	}
>  	buf = calloc(1, size);
>  	if (!buf)
>  		return -ENOMEM;
> -- 
> 2.44.0
> 
> 


