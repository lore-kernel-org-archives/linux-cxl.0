Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A52F30
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477854; cv=fail; b=FXoxyJV9gqkgcalc5Iw26u5ItgZ/iZccul67rIpzXXPLrUnp9gGv3o3n+bRedpNaI4IAsDDmOXNYx0mZKJEa8Q7XtpAvdk2k86k82LHZvXTQCcdMjyu04MDJhrxXLmoxTtLZeaU0rEkP5bDNxU/MWqxGUGRLoco6xluy+2R1iEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477854; c=relaxed/simple;
	bh=sIkh3aXLRhE0ri0Z7qiqnmXLE2qDJEEvPwuLLapSovo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eM6Zx6plnacZQ0xecnlRbC408X3k7aEjTkQDCdM6PAsDfxLgy3O3eH3lErvtHkn7gur4rBKf0vViKdpq3qlRYq8mludVmH/j5j6ysMiCg3GLCtbxVM3tkspoKqTWtAXsTXmNsfefkBywSziw52v5jthJPlUBGaZ7ygs2XPGftLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDqQ2f9y; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDqQ2f9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713477852; x=1745013852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sIkh3aXLRhE0ri0Z7qiqnmXLE2qDJEEvPwuLLapSovo=;
  b=iDqQ2f9yr+LYkj94yAou0Hc6mLwBaAFS+LkQv6iu2rar40ySNmFEkKvB
   FE1ZDQB5l59AE0lazV5d0QCs22nfLNhHmcSLVp8rk81xm8wUkxY989Zvp
   /ucYUvrrP+cRvZ9sNMKT7Fj3jcDe1xLrAXwea6RGiwmue1WOZIbz5DcPg
   SzDtM+QLgAoP/8lMcKA6Qrs0JFWzRdTPGRnSDoW7h2jQl0j750AIIE24U
   9sFPjQsgJ7skmOImD/P9oGBJj6tFJmCV/EGefGOXl8DRm2CepVsDc5iE2
   DFjGEyj6yxfwtmPv6RA9MuHKiTENFJ6I22YLEpoDI577S9J422L9ZobDS
   Q==;
X-CSE-ConnectionGUID: CquoPkjHRS6QxUejqcPo+g==
X-CSE-MsgGUID: ktTdQCRCSnOjfgwJEO5xdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8916011"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8916011"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 15:02:37 -0700
X-CSE-ConnectionGUID: Jfg0q+GFSdOgJPf0rpCLhQ==
X-CSE-MsgGUID: O3Hhm+/YSZ25JyTv3xP1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54043788"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 15:02:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 15:02:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 15:02:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 15:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXVZIiaCVDffs/2wZMpXogILFCaI38gRO/QveByEFxUPAQbpNQIzAdD0dreIw+KQH8U8ZD+opBIumCQCcqIf7KuRuQRbMpACEcOW8gag+cFLETDtWVMwowBGjKgsH/HBJWE4l0stZnI71hJxEevjRxuqGmDqy1S4bKwEgvVjT7dS+TWB7/D6iLJrQ/NlgSGvha50DUBzy0nQ14WHv6hGr6kte5+zGy41/1yYRHDxLBlbegl69L9d/WQ/Ahm16CQIc7U1nwQICosEefaqusw6Qtd8j6JatzeRM/SacyRehBxqVlA1t7k8hi8z/RvdcMZ9kdKq3Z+FSC/etOj0DtU00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10UfYqpeh52EB7HF1GAbj0Fapuhk8NeYCdfDyEQ78ew=;
 b=DszmEJG+qZx6ziK8d1zPwt+t1qFEjMFmfi6XBPEEFMzC6t8clLssAHr30l92DSiyiHm+g822mdhzFHM7CCOA8qPmfPo2+osw1Ziq7ZFTmgv1CulLn/UBqYibWKd2xx45u4HR9Sm0rCmG4wdV0Y+EKKaJShs9qoyx2VLE40I2ls6YIH2SVUwAWWovwtwFv4N9S71jr3h6S3iSiRmysqzwwEeEDhgp3AgaptzOJEh4MtWO0mFGtDB6bsX7ec02yxz2bEa7X3J5d7NwJecpFAFbnZBrvpBMWUJtu+ITTNomKRxV+Np2xuvWAphla0/BIU7ulzbOb4HG89rdUNCg3vvOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 22:02:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7472.027; Thu, 18 Apr 2024
 22:02:33 +0000
Date: Thu, 18 Apr 2024 15:02:31 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Sangyun Kim <sangyun.kim@snu.ac.kr>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Sangyun Kim <sangyun.kim@snu.ac.kr>
Subject: Re: [PATCH] cxl/cxl-event: include missing <linux/types.h> and
 <linux/uuid.h>
Message-ID: <6621987729944_3ddfb2941f@iweiny-mobl.notmuch>
References: <20240417035043.2791431-1-sangyun.kim@snu.ac.kr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417035043.2791431-1-sangyun.kim@snu.ac.kr>
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: b298f780-04d0-4ff0-8577-08dc5ff33fd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7deNS7kmnZXAUniaqE08U6+5UwIBMB59ALDEVGlYp2PfUYFMGenvnbZ3dJKtl3/ME2zz20pLReU/Nv3edMYgJXMQsFFLLy+F63Pt6ew70/qHznxqmPS8lvxtpUyD/vnNj/EsdxB3onEzxFgwy3o3IFk6mOCi6hrzTQ7ef8qhGmmv7ZHc/eObcWYQsxlkNHm6nEhtWCbyeffOwls9Hxbke6homl1bLMt3Q2q27bE3l8VNJqXFWglzK5qlphLYrKO+kH+5eopJEuVrxNfaFiBz2rVA47c3ZofK4qBMuMPB/mNSyfy2lCw4vD4ml9M0jQ49pIbOop9PHc478HAuNQjadcuybyGghAKpBnDqXhDWxGoG+f5qrBPO3XjCrEhA97WUdoggl38Kcc1SJOzqzMHyNzj6S5be/qJ0tMUYncYTwyEQ8Q338ynhjgVsOp+5FfA+gytZ+UGZx3FMTrN/Gmo66DLojqmnomvw2f7/ojAUx3CbQPuKAcdKRmVnEJNRksVMI7yon4JO9tFQfm9Onchql0VuSLFOZ/rSrgp43ZoHd7yGM6sScmXo2BjrKYSZ5U+l47GpKCi000AyaAU/Q3NUaAp+YTDvNYQJV4n+93T4eSRzOnJmZUmCL4WSJI6SkDJ11bY1fc0TErN5S++IrzrRe+EdmC4ocR1USUlzO00s4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MG2OM3gR88pb8U8DGMkVtnl6ZL0RvXw2qPBpXzwTMTxBPVp08Os4gBfhGFkc?=
 =?us-ascii?Q?LoJbu8UOD3y6hoeYdRcERyVUPMXAUwIhr8lD220lhPGaE1vvQtoxrGExtc5l?=
 =?us-ascii?Q?VLVtlS2gEALSr0l+x/kvqu9B94zCnL8zJ1f7kus/aWoMhHgs0YdFdujQYCT9?=
 =?us-ascii?Q?85AzPpx4qI6r2vHbZhZWCuS/1nk/krnfpl0N6yCWRzsSi1mMJ78ecqFbLGGw?=
 =?us-ascii?Q?/0WkK0TkSCHVIpGj5bFEj+GYxOq+0UR8CPYO/TXZEa7UegOJ4Kgo+iK3paBi?=
 =?us-ascii?Q?N0+Hns7NC/iJUw69OLE+v2utHyd0HYfmbuQDC54MnpdrDfEAdWB3IE6fNLXs?=
 =?us-ascii?Q?ugInDBjcvXbXqczD7GfL1BsDRQ5WUDzY7mHVuNQYiriu3obpAvmwkScJ/bOM?=
 =?us-ascii?Q?HkyvXoGrrMio2qldmbbauQUj0/A6rjkM1Mfd1sLN2p8BATKzPmhz/WP4ekVr?=
 =?us-ascii?Q?0nDoS+WU/zeOvfD+8p6YiFoZlnPn6GVL/rkeK+eniV7S+bbsq5oMP3Ai3uSA?=
 =?us-ascii?Q?mW1wCHUrTScbZT8HSE2XU04RllCyW6yAdWdNgd/Bv5eZlk/M8wEwX1yjHn4r?=
 =?us-ascii?Q?9a644s/Y7ATEAWCscdtghmxRMsrCyl9yOQtePxmKGEog0Ep0V1FB4GAQLHee?=
 =?us-ascii?Q?ruliGR0zKk6x90sDPDw/FK1iOpoKv3GhK8KNVk1AO1oto8DuA52vLmWsHESw?=
 =?us-ascii?Q?++dHFyw0fGQkgOzssGywX6qyJieoTxs6GLvdx/SgFp+wRamYevu6gGqBoRhA?=
 =?us-ascii?Q?d3TsENQpcq6TjgiG3qOm2/6sf9YNJiPbgBfuh99q57LLo+pDCickix5z9rBO?=
 =?us-ascii?Q?XWTUJjS8WIhufsYvB+5XHNFkj+rN5iHwsfyF78+K+zYDOVC8UoBoQ2M+E1Mg?=
 =?us-ascii?Q?TXTUlWXJKxF3pObdbsrrKZCbVKRPrigxa2NLsdng+UWjAB0ZEKKuXOG6tiRW?=
 =?us-ascii?Q?Fnp4bJUigy3dLej/OrKMNbo+5F8CgtY8zVgrcpJBEGkmQ5ppO04cPE/YDLVm?=
 =?us-ascii?Q?m1/TfWaAAuxcXUE4fH9LMWz25RPq7BFjsA4JVUADUFmvQt89iwm2/3Yuv52J?=
 =?us-ascii?Q?Cd34f+/tRgrbXELQ+ef/YY2fAYcwDiBrMYQaCdRzQi6tz+KAMOW1kJfn+nsm?=
 =?us-ascii?Q?5d/5PReUjW25I9lS7MF+Ze0zySNvU/EZ9DgWqGxA3wgcUG5z00ExIeh8ctzx?=
 =?us-ascii?Q?g18EBr7Ntw5GUZFjpDErVsFJkTrLLtiNtDUFp8dhCUT3RzpUNA0lZRI04sqF?=
 =?us-ascii?Q?CO8MPDJ78AYcxg63OOZRkFOOzAl72V1iQGMxe8u3MdTvo6a8kWZqj58cmjJt?=
 =?us-ascii?Q?5IDSR6SpSpmF+FbENf+VTmIj6HEx+UcFP0ZOjim+RnZAVUJ8yx0rOfKC0pvS?=
 =?us-ascii?Q?7jU9/9De2FKKPrNI0QNWy3NlPZpnuqdsWXfHwpLnvj1VZrltXoTVPcV68WcX?=
 =?us-ascii?Q?dEzMccfMjdrYPXZzrfVVEoWaq/03QU/NkZHrweUUxykbpcTtJ0cPdcQ2aRJb?=
 =?us-ascii?Q?jZ6jxvkad3Ar9jRijBaxR4DdexMVRc2jocag+PcQftV2iWWnQ8+zEJ5rBI/T?=
 =?us-ascii?Q?a7Mu3duhSgsGHsHIzB0w/Z910jrMdHZYv0N7ezZS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b298f780-04d0-4ff0-8577-08dc5ff33fd7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 22:02:33.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8aabUHlhO8GxN8XGETpkzRtPIJJ/Q1BglOYVsYHudFEYxYZVTMlxEQBIimt4GdrcBz8vOnWOKZnrvQ9+H6Bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com

Sangyun Kim wrote:
> The linux/cxl-event.h header file uses the u8, u16, and uuid_t types,
> but it doesn't include the necessary header files,
> <linux/types.h> and <linux/uuid.h>.
> 
> Currently, cxl-event.h is only used by drivers/cxl/cxlmem.h,
> and it doesn't cause any errors because cxlmem.h indirectly
> includes the required types.
> 
> However, cxl-event.h may be used by other CXL-related code in the future,
> so it's important to fix this issue by including the missing header files
> directly in cxl-event.h.
> 
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>

I pointed this out before.

https://lore.kernel.org/all/20240228-cxl-cper3-v1-1-6aa3f1343c6c@intel.com/

Dan suggested a fixes tag.  I did not think it was technically required
but it would be nice.  Regardless.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  include/linux/cxl-event.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..812ed16ffc2f 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -3,6 +3,9 @@
>  #ifndef _LINUX_CXL_EVENT_H
>  #define _LINUX_CXL_EVENT_H
>  
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +
>  /*
>   * Common Event Record Format
>   * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> -- 
> 2.25.1
> 


