Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C03D6664;
	Fri,  4 Sep 2026 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499540; cv=fail; b=BbV+bBy4T8ZF/88UHERJvIIvaQePwIEwCEgkGD64wsIsfw0cEi1EIbjeWTIdIT9CrQFyhnv1C4yz3s+kz8HRhNfllv0JKN0fIweQce1Trr+re57ZE/MHeSbvP9VWb7tGa8+77bxn1AIt1wInoCOTPgwjoc7LjTbuPKO8M8LimNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499540; c=relaxed/simple;
	bh=0o9LKo3sklWDKVpulw4BMzFr++4xEXioEmvZJBfJMKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pdI7cmdTMS14qirfpQqMMmwu8uGpnhur5GWgIPpqZgXnG72FVMYsR1WT8/irnrxI2ZtL2NlF5C/u+he+DYBW3mM2oEICK671/AsvF2dvcC5Bi2r6ERWWsFKOqMDnGX0cekbUIvqAO2LIA5XVLm1UKahgvN2b1ynqlQoZWooZp10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8y5s5kL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8y5s5kL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788499538; x=1820035538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0o9LKo3sklWDKVpulw4BMzFr++4xEXioEmvZJBfJMKA=;
  b=E8y5s5kLwQEo5KcPGm9TMbPpw3vFB+QnTmLo39wwx8gcBP/n8AUCOaTI
   /dBi7sJKk7gQli/LO7vdz1E+rJl+OTR6iAEiMadnChGd4PjeFFyxS8cLr
   XyyP1e0Y7dGiEXTtMxCe0sLcfvyzstj+esHwVY319cz/F2YfKxBI8xKVb
   42BbmFIbOs9AtsFCuXsZ1HV0ZKmpfYrRACjhRcximqLdRr7gxCEPG208Y
   NvHxzuiRGe0UH7X4PO5NT74u5YtKaF8OMuEXWlkPkw8y25fO79d8QaHJz
   /+4pGrfLmIKWL0LSqDbn9XHq8KWQSFMLZhDpty1iK2qco7EJb+W4MteGs
   g==;
X-CSE-ConnectionGUID: fYU9qg8dTq+/rwhyXPzvSQ==
X-CSE-MsgGUID: rQUCK4HHTl2vUWhAxxkjew==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100355106"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100355106"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:25:37 -0700
X-CSE-ConnectionGUID: L2W6/NtJTQudXa7gdiNSHw==
X-CSE-MsgGUID: N60re7BqT3+cLE8emZnswA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:25:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:25:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 22:25:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1PsGsyukuBLZt7hQPFCAk4B//1/cyfTMSLn+zVoxhtP9v16pKSJMbANF6zw867wNQqeSdpUcn2Akd91V9jmL/sROJxqeujj+7zY75k8CbPJSZ8Rs5vPusg2Ama8bgKnagejYWd+AixnxBn5HCuhyrU2jGPvy77Oy/+rb4mvctvXUAP7ECmZHW8YgLcW7LLBDx2uqpC9gpCC+MHHJfCJSxeeskVyMV9iCSvUruKMdB9Y6qoeYycVvEaXdaR4SW+WDov8Kh0CZIsYvfYBEywU5aWLIgroPOmlj/3AnSaR79zcbJeZBUhkUUy051+iGzNzQ09pT/ee5y197V0p1jZN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B9bGRfzGFzxBcnvzifYswfI10ihDcZxM2jxVQBZwz4=;
 b=SI8qyXliUXcsP9J77dHBGH8flsrWcgqYtpMZMz8IadysMvH50dmN/OMAaPa05+c9FBHgchj2dr8KJpOAYR1umDv9TyiCBxAzA+es7SxdNI2451sLDcJf1zuRZsJgGKFi8w2j/02/8UxSkz5eBiZCw1UnPA9geuLRPXG34LHqIXSoFAOM7eSVwsmE7lX6RcRrYGTmySRz9EKkbikHSpgMiXwT0PEQDnFG1wWZYsWdYrse5Axh9M93W5obVAMgSSyanmCepVJDPEzStzIpDNIGyjeAkXkJzBzo8CXzRj7Q6j/dD9yB8vvVRbhZJM6l+7O4JOdRKwxOx0nx6fMrptgEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB529852.namprd11.prod.outlook.com (2603:10b6:806:51a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:25:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:25:34 +0000
Date: Thu, 3 Sep 2026 22:25:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 3/7] cxl/region: Don't leak tolerated RAM -EFAULT from
 unmapped poison scan
Message-ID: <appWSlo5UJwg6Z90@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-4-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-4-icheng@nvidia.com>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB529852:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc752e8-da40-4d21-0cc7-08df0a44f1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SCX246g6iJqDaaYQQLeXgWqD3QEhFp8OApLBnNSelO9oNhH9lFL1EJC4qz1gIKIh6VIua4R3kRptNg6+FPk0gdVfixTPhwmkbPXTngkKWHeJzlPDbAzkwRU9mSeVnWHTxQrbb6OtnzPmtcvqYYCS4l13XJ9J/kg9q2lAJBHJ5FuzDwAiLYOy0lQcHwMgW49b2sPBFyiFLlOOldwXhMTeYe6MVLTE47HXjGQHdHxHRWAQ7Z7O2TpiyOwMjdKugUhw/qNS4zNO67JKNunQUM5IQtl8/Ls6ccTZLKTeq9V4U/naffJLjK68Zp8DiRQVsKZ2kAOo78gIz2/7wilOgeEHwqFHyYucmDJFz8iq8faDVNEOa8HCIyT+FUbt1Tcu8D5Gz33iaUSmQlE8HTgC8FqrYicF52erOwGVqwRambPZ/5I7MU7srQeUJkBE67dDMRRTkDkh1HN3Fdf5ct0ip9NenLmsDcbzDyHxdZsRpnozYkIJ9BTHxbiomwIInJcDSX44AkmkxScrz68jIxssQSuCY43jB8VMgi/l8ep23agJxgp0pCr3oPBjrR53+AZ/vFA+wz+9HD6lXDYo2rmHwHTEg8GwReDDoV3xeyL6zfD5Iocp3OWXK9DBaoijACsSFmvG/yc3ijUjJ9vKjaBBa1oUiLULHhvo/VO4Io8EhMt3ySk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlPWAO3Oxx7cjl5qpL2qWUzEHcsJRkld2AKW1Lj8ojXDYqRlQ4EivIUZNfdt?=
 =?us-ascii?Q?7jAUHal+SC5aJtI+PP2IdZWH49GHYne/DycYIwmBU8GAl3bArYEwsQ0rSXEx?=
 =?us-ascii?Q?KcqoSABtVaq+qrOopWA3aNxKdCfDkIgCDZ9xP0UKjDvZlDD7r5sWivfVQ5gU?=
 =?us-ascii?Q?hck0qjkM8iDi8COkEwBKquLU5X4aMJdCWgerok0UbAm7Gm5yW7lG94F2lvOa?=
 =?us-ascii?Q?+VqHbWYayPYOv8FQDkkFaR0gjNT16f0B2ED3EUvfmGWvyYmtLTqk7lHVSr9/?=
 =?us-ascii?Q?Cfzwh1pMSfXlexaGgNQf8kwqHyQjCagn65+s1q3H5cJbUwhk4ToWjIt2UM/M?=
 =?us-ascii?Q?80gc+WzMNLHbN4ud8FV57449mfH8C/QbC94kSA05GzhicfUT0o7FhnzOaUsC?=
 =?us-ascii?Q?lMIixIbWzu1Zz5nwN1vXbyxa/KDJfQoTPHU7L44mV5dfh0rAoXaZdLhsp83O?=
 =?us-ascii?Q?4O8jivy4pw2UCIYz5HztYVsK6T/tE7e0TTVo08CSSxuELFJYfSVH8088yM/t?=
 =?us-ascii?Q?4ElNwLxRtxYIi6HMgo/Ho0Q24/O0LG3nQ6ctOPAzwERMxDF/OzMzs+7pWyqn?=
 =?us-ascii?Q?m/0dGveC6i928bky9SemZQC7I6wqqXbgkydA66urkhq0QK+zDz7L40DSd796?=
 =?us-ascii?Q?p3QpJ7bvl7F4OQRVGWGa+WRZkUerobvhlGMtcWz0m7nuTsf0Y4Owsk/uL6qk?=
 =?us-ascii?Q?tFqAf+hzf+wL0GALNT2rTN5oRffCxOt4m0gEuevsgyHOr17J55d3hVYziu6Q?=
 =?us-ascii?Q?orgOHYvZZJYearw6KK7IVkalhR9oL899fAAfV6uBi1TYGzMJz9fnq+JmGxuy?=
 =?us-ascii?Q?eW2r3n4y+8l2gxnP5pZthiPrj3PblcFb4Zso/vuOe6OKrxPpoIFBL3zH8i1N?=
 =?us-ascii?Q?0pdwNRjaKvdvUMy84+dll4lb1yR4qNs9L+tpZCXI7d1zDN+BbU7zpXgZbjRR?=
 =?us-ascii?Q?KP7vHEohq61Yja47Y+c9LOUMf1/1mHQ5aImiXq7jbsva4rkFa9lBrsmLWPss?=
 =?us-ascii?Q?tz5G3alpi7Y0VKKsknttbqNAuk7SyUp53emTw6eSy0mJELukQScm5a/MXhOb?=
 =?us-ascii?Q?gouhjVIzajqvmCMnXkqEpRnO35F0qoa8H5XblsWF3adWHX3CV256/fNsmMmp?=
 =?us-ascii?Q?aVWtl6AtAmQLWrJ7RWzPXANRPyWdY+vyXSIbYuGDwutKAnE2R5HDpEk59CXY?=
 =?us-ascii?Q?ppR2z5hDQ8y5f9tE6HJto8kkNG781wGrkNUiXAhYy1oYRolk2v6YiIKfvpla?=
 =?us-ascii?Q?r8Sk8OOi75cDRH8KcMqJjQmZ9QqikzwUvgMyGZEsNCxowgaJiHY0KkXCHNVS?=
 =?us-ascii?Q?BuXKw8rzKLoci0z3kYLJaOwh8ndmlm0XspzUmT6k7+ujgS00dcj6ZZViCy2Y?=
 =?us-ascii?Q?uST+Cp3f39QR2kP6RWcY34qi/LVTJRCeCfhTzedzrbD6yNZ//EgHq8JMnUH1?=
 =?us-ascii?Q?xNeFIThoXcOeEZi2FJIr6j++4HGIahL8yzxx0kk1UZkUzt5yxcoQGiD8+KzE?=
 =?us-ascii?Q?ck6exlMXrcNAzmk0tJ008Ng05efndfnlmMq6NarXlqknzhBJmHg6LvgET5dE?=
 =?us-ascii?Q?dPUzJ9plUrh5DuK1HtEJDMa+spOA5UWMiu5KF5Rq5PgqzRUB2Qi+M1K+rIeu?=
 =?us-ascii?Q?aYRPLEfOxz8fSq/xNx/8mNDmuf29ohzk/UuxNjGQ7VfjbmkG/cpsqNOW1oUp?=
 =?us-ascii?Q?TTvDkChgkEiLlaxxSr2Q0NPN2Ep8w/vhTMkO9mWESZDp2cZjcPUD7An6GNUi?=
 =?us-ascii?Q?mqlfaDiEvhtNL0GTsC8iC1r1V0f1aUc=3D?=
X-Exchange-RoutingPolicyChecked: PArXDX9g2hK+50o1JKAFCenR7y3ehCPT2SHMqQJWSjozryZgMx3l4Xdf6Jk/m0MRlENT8gc3Xqozk4ba4BzjQQq4Fm07iolXvBx919gawnytxZyhD/c+GpqQCmWnnm7VVjjXP7i0oVN6We37eQoKEb2sanF6mV1rxhLqh6om2p6llN5TsoMyLu2763P48zw1MMfDFWw/QNmWdXjs/lkSY8pLh5RHHy4J1uUQxsGFyLhxYS9rJKYP/mHCOnekEDHFTSl0sNM0O2LJfQJb+yNyrNTP5erOwXos+tVOabCoxYgFCm/SfwT82WrnrJDOSYUg65z//PCIOBEdBWe7id6xCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc752e8-da40-4d21-0cc7-08df0a44f1f4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:25:34.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjlT3xpR6golYwi3iqHXgRNgHfsKenDDnhOn6hsNYkRCahzjcJwVtas+zONU+ztUH7S4dR/livdJtD7kxkk/icmdLWLPlrEFD8Bu0dWNO2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB529852
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:35PM +0800, Richard Cheng wrote:
> cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
> for Get Poison List by skipping that partition, but left rc holding the
> error. If the tolerated RAM fault was the last poison query before the
> loop ended, the function returned a spurious -EFAULT and the poison-list
> read failed even though enumeration succeeded. Reset rc to 0 when
> tolerating the fault, matching poison_by_decoder().

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b03f30c04d35..ddf12075b95c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  		if (!length)
>  			continue;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
> +		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
> +			rc = 0;
>  			continue;
> +		}
>  		if (rc)
>  			break;
>  	}
> -- 
> 2.53.0
> 
