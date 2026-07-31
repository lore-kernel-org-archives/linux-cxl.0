Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E347DFA4;
	Fri, 31 Jul 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524824; cv=fail; b=gEEn0n+sx8TcCG56GStI7MQGwZ+B5gZwVvIMQDNr5zDdGB3B8M1QVzla7TrwzTgbf36/OUdnwn5E3wHPYUzONuvVCzTbKZM18h6YxvlNeUF/HfWKzfeW3zJVcsVUmOfsZPejPBICu3K7tI/xrRyZyzsuV1PW30S2nKbb/QYP65k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524824; c=relaxed/simple;
	bh=ucyroZIq9d5+zFj6ZBuKoz6YqnyNk/TU4RTmMx16zBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=scMHbEgfW4DNMfKHNBYr8qY/FUlQFtDbbt6yhYVyE0HriUOmzt0MNp906ptiPjmUgTs0Ww+O/k/cU14Qlvl9AWJ31UV7bMCB0Ca+j9v+FBUZRoHFvANdHMhXfpdjOnGIizdByg9jRZxiejW8RLnMYt8IXIc025tRy0sDAnRJApc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVLWUZA/; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVLWUZA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785524820; x=1817060820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ucyroZIq9d5+zFj6ZBuKoz6YqnyNk/TU4RTmMx16zBw=;
  b=PVLWUZA/xTvGo4bSXJ7biDQNuKEyga4/0AYvfS/rH1PCEkS5gFHiDctd
   srBWbd32ccckebQFixjUMC3rk6DQ1JiV8MLJrzd607qe8fcKPNMV94nOM
   d7pfZ7HrMfy2UX9/scdRD9taVayfKwlgaJ0eSVFVLLCQiriMnmvrNFKbb
   91JEYH5HJ8zg/qtB2S9SJ1U+qcSShFMIhT7uAEh5SazHnXKrZbEIBogpq
   Ke2k6ky7slPHnv7oayl+WcRv4/OIDpt2UIMOOBsvN8Bni0+M6LYgLFpwJ
   9qZJ6Z0/72XKT9QDEnlZi9fO8HcDkpahKj05HVIpbVLVl4zRkGbCkZylU
   A==;
X-CSE-ConnectionGUID: u4tsJnXSSaeQm6Nsw/JMJw==
X-CSE-MsgGUID: h7q/T5b/Qw2QGDL6HfCN+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="97529166"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="97529166"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 12:06:57 -0700
X-CSE-ConnectionGUID: g8l6Sik6QzaQfzccdSY/Pg==
X-CSE-MsgGUID: GYuvNmYXQXiOy638tqhriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="264911715"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 12:06:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 12:06:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 12:06:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 12:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6zGCdXHuvbGHK9hPz7dmeRv8jMwvL95XrcweEYzGt64pRzSKvPbanLZsXsyLjY+ICJ2rzkAIk6MWf7Le/4JBEwnJaYbCcqCg6yYfzFj18MtgvKGu4MLHnc64OS3mFYQ0zCfyuqTtnmXqOg9KkeqYKlT5UwweJ0Enp325oOgfJsktXl8ZQvsca8w+YGWlGJcq2cbFsVQ6ywCYPt2n0n+m97w31fUA3RCGDP+1JQJl3duejDZ0NhfrgXZx/TJPz/IExkMgkbC+HkKtuqcfyJrFXkVdaxTorfj8Tucr8gU9Mcl6NCdtUrgJnm8MmcYBFDDOM7YsFsmGYwpdBpEQK4YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJl4PJH/fnojqmSbsSRgMawvMIT8aTe9Lnv2AwvrbCw=;
 b=Gc6+lJIJRfXL30rGjx3kHKVyrcSpnBhVYcO9DfxuXRelZwlEXMIsRBZ+6yzHAQA6ozOCNU+4upJH/XRFokRHXOFWTYL0EeMcdtU+dpiAMtvAXVWq2C2kNcczCC0VcCfCMZG5dTLJn8AYJbPz/N05xxrYn6f8zeX/vOdJlAMuqUBRVj/ZgNJJAktFUygSf/3ZMt8kvYUGJtxHawWJ4p2MJzbALWF9EfGYJqJsadyrQP/YYw9gDkxXrZ6kKSZVw+oFNzQ/kxLR5PVJku/bxXB1ni94giupt91WiCxPfm8w6uT9VplhFaaHv1TVW8zodv4dbBpRXTa+dfTRb0icbIOSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 19:06:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 19:06:51 +0000
Date: Fri, 31 Jul 2026 12:06:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <jic23@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<mochs@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Message-ID: <amzyQ1BTDiwfe1b1@aschofie-mobl2.lan>
References: <20260731064902.34127-1-icheng@nvidia.com>
 <20260731064902.34127-2-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260731064902.34127-2-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 13df7588-89c1-408b-07f4-08deef36e081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|4143699003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 65ofDg6XV65XS4KbAjuM2x23q8jDVsmv3J50BX0TrrBA99RHhWBCbEbI8MM1ufrwU3VSw6spYUTQNDKh9CNghkiApJjT7BV/PzxiZfrMcfxxIMv16feTOtrBMiai0S3mHEHxWmY+a/zWguZXtjuH48IHFkeZnQtwGUcXZIr/q78IMxCcEqU4S08sXw/V0nIJ8T2DROCFUufED20mDEEO7ZAcTYj/Xcpw2iSzs1NFvZRZGt1kctB+HBD488x8QieoFVyqiOM74Eh9HiLs+0WLRYpLNsaitymG7Jg3yuCzn5D1aZ3IjG3ixMLTO2EaLbabieNSN0yqqGGhwR/nWWu3eVNBudM/hHw41UDdN9vo/bA8he6go+Uo6OEYrJhuKko2xWaqx982CKuqTN+jWi1P+3B049Ag0/T6gNpyKTJOpUnEHn6pTRxxGof9dzi5nDq03T8/pjW8oALrgJGu7Wj61+dpKGgZyUSiEQqBov8ShAx4lCShgLZETtcBo2dJEXoqYJeWGNPkrjTXc83SfWl1buCFwUcga/DkEENfukHymaKD+1HKWzFynHSa1JQY93Lb1dBySVm7kbQsnevwH6uzM18uj9K+gnuwJ0KnKpdHaeiom9ML7EJUv0gosePMBoG0W8GCQ0nBxzGEUqyN38VUPI8bZp7Ww/caEPcIcF7/Epk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVlKgQzencOkONTt6YX76CXZCUFMvIY0kBvEc8dPL29qlodEjId7cO9TD7at?=
 =?us-ascii?Q?k273aYCi/caDv0F65gFHJrraQOeDvWTbQ3dY3eMcuDmWviPLFv/tXHmUjWSF?=
 =?us-ascii?Q?PbM+V3VwFXHSdCFXnYiGIbKhRKkjXc8tUztOEWrctCsdD1/GHyPZ7FPsrGgV?=
 =?us-ascii?Q?sdQsvP+0I1gxojyBLPPeg0uS1cEimedx+slYy5iNHRVRvmj7WVsYcXjVm4I6?=
 =?us-ascii?Q?OQ4LooFA69jgtwaBABt5da9gy7MViW94MnI+YiWBL5y5ZkH46WZQOmf/qhdS?=
 =?us-ascii?Q?AOT0s5xXozmigtn+eQFkvV6Q3sWyELeHwsAOGyPylc8uj53wdfDJdovFqtBh?=
 =?us-ascii?Q?Gl3zqFC4YF4SzMW2nQlJv7QQ4WvVO9ZGGMQ/o+FaGcerXY6j6b71doQVF5FM?=
 =?us-ascii?Q?hBzZ3Y4ZpZtBsL5CLX5ODjEybUqJvMyLvENEtASA6aqwHBhd1eKVsj9883Fj?=
 =?us-ascii?Q?E+2k8SLHpX92Re46R6lPaxu3IcovHWIWzTSKlA5cpcN1n42Luify/c9qp4PX?=
 =?us-ascii?Q?3YShS9k51gvlm9/9/pHq1iSEfbbZKTikCwpWKwKIOl752MyKeX6dVCqrBJRV?=
 =?us-ascii?Q?FKQxoOfcV25fSCZC6kI3P8KaI8ms2GqmLXTSezaStES+9g1os+vVfkyP8xkf?=
 =?us-ascii?Q?KPmnJJIQR4RpvJ54iZaeQFIHFtTXYwiOt0ybyF2ZLFNITUZbt2VuijupWcP/?=
 =?us-ascii?Q?u5idG3ekqtlCuYyJhxDqftMJFjrkngBuuLDN7EfNqKVSdMds5vmxqKCKvCeA?=
 =?us-ascii?Q?+VN18z7DUhs7BpqT0Ezxf6X4FqhdlL58q1StvqWuldywByVlxuWoOTCl2G61?=
 =?us-ascii?Q?8j9N4AL44BRU0m0X7FyZyB252XwinoVbHS/zqkWmFkr0gNHI7e5EzCv+ZiCQ?=
 =?us-ascii?Q?5MQJqOuGLwtctEM6+Yx8GqfnILM8FfmFXxdB398fnWuRuxumOm4V9pFdcYiT?=
 =?us-ascii?Q?/dBHt/8vvw2NJFY3VsyiIgXcQ1gsifd1J1MIelug9Yb9kPCIHW1cLlJ9Ejvh?=
 =?us-ascii?Q?A+Q0lWkqf5AVTvZaMdtz0b1zz0DVtMp8eoor2SHxiYS2qMngALSCj6oJ2Xd9?=
 =?us-ascii?Q?FeOJY4V4TKQeCjiv13OnlcjLoxEawEPMlEztBn8jnQE1AXoDQUO8tT4KvjD6?=
 =?us-ascii?Q?X8wWkOEybshsUQjtXyF3M0B1GNwAkhub50HqBcB9Ulpe8OJ5B5gw4wwfB8M8?=
 =?us-ascii?Q?IblfqNNU1P5XCZWYJBCMjL0A/I12ZCSVXArgBucifUbP5zpk4Six1NRj5kgy?=
 =?us-ascii?Q?CjsUBJ+XPUIcBeVOwQZAcFyOYCtgrI7aalXTPzCvfhaNKL1Y6PqiiFOgD34M?=
 =?us-ascii?Q?mXrOJ3NrvRiifVgV3V/4XWbT1Cgahy4hhNWWiNdPQWkrUEcNeme1BC2QwCTx?=
 =?us-ascii?Q?41M+dqRgTDIyyolMX4K02UAcB27JxmJ90Sd0hFr9TrxigaQ51B8yv6uBUrg/?=
 =?us-ascii?Q?aNowsvu2FR2drpg3F862kf0tYhPJnxmQ/ink330dELwIU2Hy79PHGU8P82Y8?=
 =?us-ascii?Q?ngtEjHaHeT975k1Kwmdm8riwQhXhVca1C1fG/1WG+oW3Rbfg3356/2awP1/W?=
 =?us-ascii?Q?8kEhUzf6vAhW7dXFdZpuNkIAr9KJ3Ss8nKcAYCuHSZY52ZgEqgobuRWWusRX?=
 =?us-ascii?Q?Qo75qiyCg8QOo/9cBB55B+SdFDS14Ilo9+mIG0Nrc2lXspPeXGueFz8KuHIF?=
 =?us-ascii?Q?qybt0CfFUe6eJ7MjBHBr0/1U0hqCXAlTS6P1lCiSq1x/pjr0XS0/WnHOt3cx?=
 =?us-ascii?Q?yLJgmgJtKjC8T6tu8+Y1wxZnPBLg8t8=3D?=
X-Exchange-RoutingPolicyChecked: i5hutNtBv1W6lkpU2Fvnd0so9VEf4PGhqp/zw9CRxQ795yphkjDQox2DeJmj3GF1UfdZXYK64ySO1Bt/cLRj1tmVGmS5K8gldG81k8tw9/JWetbU6XbA3jjrH+eSzqx1T4A9+vm6ywcaPyqgS4FOF3XMlV/o42tjreOV0zkKPDPU7GoxYDE+aXCXIvwa/pnYoR7hrhoQmY5ud5cGcjBdW0uAppUywwEvwzxXxxk7pevtX6EVxXuiFIaRJXX0JtjOQ4JgUx/QI/yMnfFyD0oAKwmQzwAZlk9CUVbieN6zIFQzIDx341BKDfpshFkG3es/Vhems1rVtwQjkqyHc/VJmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13df7588-89c1-408b-07f4-08deef36e081
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:06:50.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfLwcQFicnXrqTIw738dM7cqC05jo5KyIwjpD6fVF8dO63D+4eQVi8xdugmZYXjWiWPGvCgXGo14aTIevSMGsNhAP1NK2+ZpqVW2b+YWss8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com

On Fri, Jul 31, 2026 at 02:49:00PM +0800, Richard Cheng wrote:
> "rc" carries both an error code and the loop control
> signal for device_for_each_child(), so returning it bare is misleading,
> the early guards mean "keep walking", not "no error". Zeroing "rc" to
> forgive an -EFAULT on a RAM partition adds to that by discarding what
> the device actually returned.
> 
> Return a literal 0 where the walk should continue, and test the
> forgiven case directly instead of rewriting "rc". No functional change.

I walked thru to confirm the no functional change.
The old rc=0 was never read again on either patch. Each return rc you
converted was reachable only with rc at its initializer.

One comment below wrt the EFAULT case -

> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..fabaad3469b1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2950,14 +2950,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	u64 offset, length;
> -	int rc = 0;
> +	int rc;
>  
>  	if (!is_endpoint_decoder(dev))
> -		return rc;
> +		return 0;
>  
>  	cxled = to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
> -		return rc;
> +		return 0;
>  
>  	cxlmd = cxled_to_memdev(cxled);
>  	cxlds = cxlmd->cxlds;
> @@ -2967,18 +2967,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  		offset = cxled->dpa_res->start - cxled->skip;
>  		length = cxled->skip;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
> -			rc = 0;
> -		if (rc)
> +		if (rc && (rc != -EFAULT || mode != CXL_PARTMODE_RAM))
>  			return rc;

I notice that the rule "forgive -EFAULT on a RAM partition" is now spelled
two different ways within twenty lines of each other.

cxl_get_poison_unmapped() uses the positive form, while here we invert
it. Can you flip that or add a poison_efault_forgiven() helper so both
usages read the same?

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
