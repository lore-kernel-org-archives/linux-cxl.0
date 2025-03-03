Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538311CA9
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034980; cv=fail; b=EPjQtVFaft9336VC99/w4sOPHUJd5K0uLL0GNMXdw2m06hUejo6gIuhkU4B1KaouGN0peeD9pgCfXnYZD3VtGlKhq5gZecvHsvKldG2q/c3b5xMjlGmfOelpOFBwUAm2tGCt9UIeI7MABBMok2YN6GiOublpsyWhzMIJahQT5Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034980; c=relaxed/simple;
	bh=s/W0f00K1MU9oLESWg1mmcXjzSkqqBeV0eEOKf+kpVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YZ6JNEMDdCVXf70wArV6ebI9AuRVUsSNv1XNeuFMVn/UjMjPkmy4yjH4XEn6IbyBAXg0kbP1oZXF7NkttvaWX31JJ0Yy05pihsXiELOcJcaJEIXFksUMTwd67z6wg3KX0i8/ioh62zO//1d+Vm8wuetzgM7jwSk2vgP0jDvUqOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyaKG6wE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyaKG6wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741034979; x=1772570979;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s/W0f00K1MU9oLESWg1mmcXjzSkqqBeV0eEOKf+kpVQ=;
  b=jyaKG6wEvliHXKUZnX99vW2I2CY1n9rjD3fqCSycEZs0SgJpwV5F1wUE
   WQJru6U9hlLRR8WWDkv7ZUSLu+q/5L59rsNUkA1ULYZk8Ak1LZqQzmY6T
   BtLWCuCC7VavRiSuoysdWWDrabq/oti++ki/fYi7yORDphrzjf0FQ65da
   9gZH8HTizUZ6WeSr/XoXx72z0JxVk3JlW2UkJ5HlTyJSLOL5cRDNe+04N
   PI4jI92mPQ7Wey43R1sRlvfVSG1qQXcIzdl1zu0rpuHwZ/ObtQoaFyqfk
   2Up9IpAbgMRLzjh4UVKutyCgiG06sZE+wkdQSk2JILKtRd0LADNOHbDsC
   A==;
X-CSE-ConnectionGUID: ccILYwPjSda1DjCiXVPBDA==
X-CSE-MsgGUID: vXBXxpwsTcC+GFdEayl71A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45854209"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45854209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 12:49:38 -0800
X-CSE-ConnectionGUID: VUO/1XZkRaC1OUSdKrsimA==
X-CSE-MsgGUID: EWYW/jvTQ/WjH/HHi29k5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118149421"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 12:49:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 12:49:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 12:49:37 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 12:49:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuQsWGOsGBXDpZDkv6AjA4ADQGN6IFBOUch0jyHjQaj3piWP2DWmV61ZZhnm8RABfzUmOhipG5/V4lBBEw2oe/h8QpLYUCUcHydVXL7zdT2T8FttHoigxCTZSx3ShOrKnUe7NNI6U5pCde9LqNcVIJxSnjjYwJOh2TjfFIE9iXiNGgcgX/5Ouet2r0O6xQX/uJEWwSY1uQWwR8JdXXXvMnY1pt42IIvgmRRV3/yjF4ddVcWCc8djCNuMzA0MuS+y4e6VqwYRMjTEpQUeGny/a3RIcHUs1Om2+yJg7gI/SFcvsGYY0nlU+Ym/T2mWGMOIq/1lc8YwpYHlqgOQKEpPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFZVbks0ENA1cbKLZqdWNKI6IwSEjtTctpMM8at5dyo=;
 b=xd1ECq5+SunJ3RsRHhmwfIrBsloZ2qhcbm3zJcwDpZII9kwMQmuEWlG2av+NiC0MPbyTF2adqJ/oRyk2EH69qm9BgAfHa6aJT57BZrkA1Z7xHk3GbQnaW1dyNKpNbzxr77WmZj6BbU46zTRHodorDgK6z3/WfowAXJGayYW6wR6KLUePP+Gt0O16vsakvu90stLT29Ah05eFBfLCj/Z1Vpk5pIui0xqOLpcKdEblqubnusrf10r7poOUXEiI2cnlp6Zf9gXS73+99GpLUb07eXR5XqmpTSQ30m77YSSZcjRH1hCA78t0nijEx3qGlCu0bsSS89VmP4qbnGJkMnMhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA1PR11MB8352.namprd11.prod.outlook.com (2603:10b6:806:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 20:49:33 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:49:33 +0000
Date: Mon, 3 Mar 2025 12:49:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [RFC 0/2] type2 cxl initialization
Message-ID: <67c615da5dd98_1a772947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <289fc275-43b6-424c-8c0c-28c5d527ac35@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <289fc275-43b6-424c-8c0c-28c5d527ac35@amd.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA1PR11MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 54477c1f-f5a3-485d-b63d-08dd5a94e6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N4yVdggSiE4RKCOarNRsSQUszGP/xYMx8zOCz+31vknEe6hUCHRPbGUOM58o?=
 =?us-ascii?Q?iwuOlobgSch0OYClGKtWWs9luNbhPYmHdkVJvz2t4FtTo0QwhzL+S8zYRzHS?=
 =?us-ascii?Q?09IHSk7bSeVFohvXQm5oombjqTcM5uvslm+/EQBZ466lQ68d1IvOfSKKtBNQ?=
 =?us-ascii?Q?xf46fqw91GOzFmmaTIBRjZI0/aIhG+XRA562/dQWc06VDdLOPdqCoSB3y7Vo?=
 =?us-ascii?Q?AY0wr/819+vGx2O2AYJ7v0AAdrOvd6XfMSIc8N9NKWOqnSkQmjyPeY8s63o6?=
 =?us-ascii?Q?SVbhVLkGpJNYI6b+bQVjzepkjoFerruJ7yCkFjj1AVfhVIKbhtYSSA0PUHBr?=
 =?us-ascii?Q?XtCzrSXSAwv4xgz+2AKUEJ3v2LLgkxUIJvL6JSgbo5GSiF4XiLDRSowmwUrN?=
 =?us-ascii?Q?eh/vvnOc9/UqXR2Wrsv7YEBg06j8H94sEaGW1e3Ry/00O6OAtqJ4yoX8qu1o?=
 =?us-ascii?Q?ZWFEC4iEdNxsJMl/GuX1eGO/nLraoDUGlhTTEFGWTkAVVPXGd+26m+rJpaKR?=
 =?us-ascii?Q?ksZVAwlH0aeaEyMDdBlb38F1xibDUE5P0TzTO7p42fzLnkfErl+RftUxnCC2?=
 =?us-ascii?Q?40pS6k63i22/7DEPMfOYHRkL772dYTAO0tTBajk8IEkLFn2hSbfgFWGWUi6J?=
 =?us-ascii?Q?K6BV6VB8WAffVTpwm23dtt65Lc1fN9Ia226mXknaAMul2vFxrXCwN5JG13Xi?=
 =?us-ascii?Q?d76wOPbGzgGhi3ncFLwak3zisLq/LdgE3dkDiGMYnvVvKW1bUnVPOjJyzIDo?=
 =?us-ascii?Q?Zm8kjcHi3DtLYKiLS3VAADAZjKYGoH2fivXr5YcwIm2NGNeajc1jzUBEoPKC?=
 =?us-ascii?Q?LgUOWKvBso5TvvlAXr5wJDtptVxp2Q/CqfE3hfyEcmw09pX/1lmI9q3/rQtS?=
 =?us-ascii?Q?9g3Ru4+2fIu4BAbm+slN4flV96Jl4VyjTY6YlX6MJX3mMGdYNcChymLY+rGu?=
 =?us-ascii?Q?OEtZYBI+YDLvmQtxuMLpXJDuOE0WaqnptV+AVsT0e7aZ47Jfg20pA4KzyySP?=
 =?us-ascii?Q?02ziKT4gbvyQmyNZwwbTEf7Ylk5DRZcJMUCA0fIBabY6m6b6+xjIp5ZysDn5?=
 =?us-ascii?Q?KSLsdV4xmUSavdTHtYGkYVJDkPuPgXZDV9x+QovrPYnvzpjKISYUDYGa6Xsl?=
 =?us-ascii?Q?52ZXmmvTnwLH4Krnhg5SiuR1t+bDTYXaAnFfXV8ab0VtqB9XWbkuPEic5yt2?=
 =?us-ascii?Q?cuCm0KgTxdSBExwiFcqMHI7OmUegfXBOxneOwh2bSaRdUaBIGE5m1+n7R1r+?=
 =?us-ascii?Q?n1FlC0qsV9fjxuZlQULvS8Ymx/kIaN08i6JqkVMgKazbsVZbP236wUzQFUi+?=
 =?us-ascii?Q?+NsWHvNpfe1gq03X/gWyHq7T7rITJfCB+MQAOqYkvgwa9dbxolX6x+G+E2wE?=
 =?us-ascii?Q?NByOxuQ32evbUUKHJQdoXQPAM0LB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bO2GRn51zSVQFa0TInwhQh95czdhjafuu4WKb821hJckSDxVhGTxIN1G5BY?=
 =?us-ascii?Q?wa/Mtx22upzUpX8kEzDfhKUd2a+A3IkV1NHf1RIG0Bet2Oe7+hON3WPNmUlx?=
 =?us-ascii?Q?rQA0CzMmfvDCwBXAPsNB+h67wiunlbEysrYwQGSWmu1+5YRpyW5SfA+5Ly14?=
 =?us-ascii?Q?no0WkH1noFlKRZZWuG7smLUZOoteVSK3MYoJUKGwhhtFk6O3bIEPl/ibtlMt?=
 =?us-ascii?Q?2cG34bxWQAKX+x3lh9q0hcZjlHYTahQ5VtyWMCn7e5rzIydSrkVPu8Az5VDF?=
 =?us-ascii?Q?X/DMl6GcHo+P+NaswDkWVvEyiHu+6mvq2Hphjk919PWZJk7/wjSXNey4AD+c?=
 =?us-ascii?Q?4sbqxVQ3plQlio9n5rEviE5iKUwQgJXrJz8CHkeq1aOlDNYTOhwz+T0LwPrC?=
 =?us-ascii?Q?7bmaGw79e8m+IJeC0KaQynKPRiwqGUzJrq3BDfif4UwZUW6RJbjdCvltuW6a?=
 =?us-ascii?Q?LPMVdIriCmUNz1sh+XWWrcycWlhnEQvwQh0ku9hKzv2bQcl5nv2q9FvpFFMZ?=
 =?us-ascii?Q?Ons6a5WxbY4Fuv+0OMR8lTfCrWiE4orw4rUPcOXtRoV7Oxs110pa8zoxGeWC?=
 =?us-ascii?Q?EUmoolF2xGdZ6SAxW6CLeW9AYjLLf+u+ZsmW+avDRgVjeaNuFoCNZor+KJmR?=
 =?us-ascii?Q?YXBvDLz/QSs0UwmJV7AR1JlKgTUph/5uios8KyjYAEQ9DKafphHhM0HDYeso?=
 =?us-ascii?Q?d0gtbUSdzLDx/5t0IMdDdo0Fck8OuWEwsRIqadhpBC+jphWRlVggGfQCVeuk?=
 =?us-ascii?Q?mp390/yYGiF3VRXS8CRMrrnRA9C3zljrA74w1BtukdB8uwnJbAout4ifGUS9?=
 =?us-ascii?Q?up2qvKzkT8gEpCDBZUhxsPISbwh80cligVHxpFC98xsp4kc/lcEa+psjjcon?=
 =?us-ascii?Q?QSLQ4gDzUTNoix9Svd7SsuiPeVfuw4uDWc/51Jj/Ch498CJPNmq/Th0mNcLn?=
 =?us-ascii?Q?qoVwzyjBVXMKrNarc18lDbkDzVD24b0YzcikLeDq+Oq2xaVahwp7VoJbyTRX?=
 =?us-ascii?Q?TiFxSlVU7k8+iFx3m1bAsXzRB0lfooTv16PV0B78ULHSGgCuReYldKhNjnbD?=
 =?us-ascii?Q?dRwCO1BYyW81QhMlo3pz+PRtUUmY+npHiM2qJ3wsCXlm+IHSK9gk/MH9/bgU?=
 =?us-ascii?Q?7uMBFIXSVheAlsct828een5CAtM1gX1k3jgQpZu4/r72Sx5WYAzQm96w3MjX?=
 =?us-ascii?Q?pfDHCz5lWN46J2YY5Q33jfCDUi5Aq+yc33BKbuZlMg64RRIHffOlT8QswVqH?=
 =?us-ascii?Q?aUeBMMNeVPYbq44hIN7JQr4pA5qgQ+cbK69dTdxnV3pkF5Tj0oAo5WhL97Gh?=
 =?us-ascii?Q?aavthG+WIfIvTK7Kf+k5CvjMZB41ZvfSDviQB1O3/nzK6JBFnKlYZSKlwUA8?=
 =?us-ascii?Q?8vu0LVaxnUICfiCRIhdwpty0StaYSUrxyj7H7+BU292wyyMneuH3tvBvvFTS?=
 =?us-ascii?Q?s5fzdvqxvxT37NzChmlipPHKojaDlMVxckmAtfzOflZwF2WRGEq9Xq0Lgkxr?=
 =?us-ascii?Q?3dFGKIuRMkNuTeos5UWkpi+v/b7wk0Jy0Wp+HPVao/ViRKeXnG54OdFCe/oC?=
 =?us-ascii?Q?ipDO3Mhr4HOdw/6Kbh4K4zKp69VwgH3HwY+zU3gsOufEsxLNmerp7OFuoKRl?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54477c1f-f5a3-485d-b63d-08dd5a94e6a9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:49:32.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkX0VEF62a8wAMj2kFo6jQ7nQYO/Oi8qH+zUvardxpQxHQXbJ1YnYFUpO04iKNDjHDI04HifavzajuAYPn2uIXX6icSIAryQ7h8KsTJnMuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8352
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> On 2/20/25 2:00 PM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Avoiding to send the full type2 support patchset until there is an
> > agreement about how to do the cxl initialization from accel drivers.
> > 
> > Using the idea from fwctl for embedding cxl_dev_state in a private
> > accel driver struct and a macro helping for the allocation and
> > initialization of such struct.
> > 
> > The main problem is the amount of internal cxl structs which need to be
> > public for accel drivers which we tried to avoid since v1 of the type2
> > patchset history.
> 
> I have a suggestion or two in the next patch, but in my opinion the only
> potentially problematic exports are the cxl register structs. I'm assuming
> allowing accelerator drivers access to those may cause stale values in the
> CXL driver, but I haven't looked. The only suggestion I have there is to
> use pointers to the struct instead, but I imagine achieving could be a
> non-trivial amount of effort.

Hmm, say more about why you think those are a problem. Those are
"write-once at init" things, why would an accelerator driver have any
reason to play with those post init?

> The only other member that may be a problem is the DPA partition info,
> but I don't know enough about that to comment.

I think it is sufficient to mark the bulk of 'struct cxl_dev_state' as
private and then move things into the public space as needed, something
like:

struct cxl_dev_state {
/* public */
        struct device *dev;
        struct cxl_memdev *cxlmd;
/* private */
        struct cxl_register_map reg_map;
        struct cxl_regs regs;
        int cxl_dvsec;
        bool rcd;
        bool media_ready;
        struct resource dpa_res;
        struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
        unsigned int nr_partitions;
        u64 serial;
        enum cxl_devtype type;
        struct cxl_mailbox cxl_mbox;
};

...but otherwise let accelerator drivers see the full definition of that
struct for constainer_of() operations.
