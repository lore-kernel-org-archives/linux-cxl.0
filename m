Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931551C5D44
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898591; cv=fail; b=nryFUgevelTHY3VP31hrQvbSAaDSUs1Sca5sEj00FnqMb6jII8Nw0AhpTVNJ/iVPJ3TNi658QZI71OhzEIZGZNmGA9NB0X2wV7E8xW2Hjm/PkefONoCj7+el18eioB4HcoV7dzcVmY7SQ5Q4FJoxIaMa+No/LAAsGutFaU8RuDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898591; c=relaxed/simple;
	bh=0jN2vsw/RtrvsB8u8pENHdZrww3ZZGVhuQpKSfhS5+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=blh3d/dgWZ642f665PN1ICBujIgNZT5j7EntMDOc8ZvH6t6OcoYBM/REB6bc58B6gbhkf/6JrDka+fnNQkVzSGhN15SgwRBrv/AdWtdA/JAf0zFPVnRgdybGO+52uFJOxZokDqjVntkZoTSnZbrJAtuWkEJ4wNPecdB7KVXRGI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOOaXXcu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOOaXXcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771898590; x=1803434590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0jN2vsw/RtrvsB8u8pENHdZrww3ZZGVhuQpKSfhS5+w=;
  b=nOOaXXcu4MoGQAbK8gDPWxZ84KVFcM8YWKsdGrZs4EmPkamG8jrVpibc
   yqh0KSsjY/8VPuTrLiDis51RlSWXImy5ohwGXMFAgGyVf9oiOMEUQYrDw
   lFIeq2NnL+CDdIDIsKKoaJFODwIjPnejzGAdZMh5LMbJC/XYCSyHFm0Tv
   Hvul/6EiCq+EOmGvgjMjziPenJLgWxsQkbcytYElBGxgacXDWYB4o/59m
   F64tk1UgBjTbIOMl+4JOclez2DtlAQHnqlhpMOGwja1w9QfeXNLVBm6nk
   VAMJZkGXfiS0UdMcYgg9uoqMxPaXIVnM4mCfrAIwSpS0X5NwSHOcvwqhj
   Q==;
X-CSE-ConnectionGUID: Q5lPmqYQQwSTll33UkIJUg==
X-CSE-MsgGUID: BFzzHUzyTCKuFaRbZKscwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73014189"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="73014189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 18:03:04 -0800
X-CSE-ConnectionGUID: 1rARZKMxRs6qzY3c6f8VLQ==
X-CSE-MsgGUID: d8HxIUj5SR6Ip2Cx2BIj1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214127168"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 18:03:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:03:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 18:03:03 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 18:03:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtxsWYMIpcthXtFPlwTW9zm5a6vaclIKDH4pp1mIyHq1GPvov9yv+7qQ5QNVML2xsX+f7E/jBMEcTCsiPEGprCBsrfNqTUSumKhtkykRH4IeDdkgvrZaEPq27C2SP39LdrS3UOJelHJaV5CiAQEK1WQco3GpjpZ//jh8gob5sfFTqm/XK69knii98rvicUsMeASuD/wb09neOj5WEFTPi/mBiBnuqlR0LyDtGhIvkE1h4NoyD1W8VNF1QKQCOOkO9CaQiinY+GshFOZ22Gu7j49yM6a5zNWGRoINFbFH0ifZmCp7oBKrmUAJS3eqjHXMpT/GoqK8oeBkiDJdWIg84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ3cP+tQP7osFPiya6NPAtjW/1N9b0WJk/gOhBMTPbk=;
 b=necmZn0gcQ9rTB43nQaytlh3DbBwfU+sWZdodnM1ALZObL+oM+HBrvkmpQ2zCtJf5S4OJWFBNnBaEf3WKZ6u0VwmoUFtZybn7PL4Dol6HW9IeqUpj1VvpH76PnGMz96kIBE5Iitr5lJOW2cXLmaIYz18EL9KVwQ/IgQ27z4PN4x9RR850YuQqc7eK96bVzdHwFGtlP4izLq6/1o9tILYeZk6sue081hABSSqqmNonsoviS9KqXtjomGVLEszulfMbU6Sc8wtQFV/eIejISuyMDmJR+neRI/ZT/aujZKjeLzha7MZmlhvWtmuZeKoDtqlMCtzXCJX5jW0s1cFQ+CBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 02:03:01 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 02:03:01 +0000
Date: Mon, 23 Feb 2026 18:02:53 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v1 1/3] cxl: support Type2 when initializing cxl_dev_state
Message-ID: <aZ0GzfdM5i24ymFr@aschofie-mobl2.lan>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260223142633.2994082-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 17718691-8354-456b-1c7d-08de7348d6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3xPH5dEaqJrZhd3ylmrpA3dojGSQhsBWa6OvekoCkzcoV4aM8g4PxR17tqAG?=
 =?us-ascii?Q?d3+ziSB9NpkkcP6eyaYIeBi0FLrzOeBh05+qkov7JXAn9HsIFx+KTMlFu77C?=
 =?us-ascii?Q?LdjCCwAyiWFlyPDV2Cj45tdVAVnKHCP1OTLaVgcWn8pJf2sRUBIM/zzCJzBd?=
 =?us-ascii?Q?pxurM6D18JBH5q8CT0JHwfSfqRU0XU5h2ncIf/ADJv2RPZmawCL125RDyUqD?=
 =?us-ascii?Q?ajRpHeGfr0d+oaVObU9C4aMoWEldC+JNDaIn1L+hrSmyspgPe4P9nFWGgA8M?=
 =?us-ascii?Q?iAeAAdF4VFsp8svDN8OA7IZ+4BcM/vKJBDU4Ha9AET3OwA2jOZr9bJVqqEba?=
 =?us-ascii?Q?OBUI9adZo6dE9s0Yzzm0+RYi9VfpGpW4y/wENxIYbkYr/gtyOUaaEOnlonzo?=
 =?us-ascii?Q?es8+fNEg+fqVW+uRW02FAxou19qOK6sNg/zo6fHTlVbVMHE2K7SuUN4uoJV/?=
 =?us-ascii?Q?gDcc9VjB5ca/sFZOhjqYaiXieBFZPfyhK6YsHuWcqG1nC2dXtOC5onuhC+zd?=
 =?us-ascii?Q?l/W5McMcJCTA+vlbHWMH4Qvt48iQR7kRJEb+OI95Kh9+nsFXFz8W/NQ6b32J?=
 =?us-ascii?Q?GgNbqhpeZfItF/GOG6SgoQQcrwLkB6Yh0+r52TZobKrEZFs6NS9AWwRWrCL+?=
 =?us-ascii?Q?Y9DjqxG469HaajbuM1rnLWCAHzsAzgRb8UlpX9pOq+q0mL0vYHEBl6qMHjCd?=
 =?us-ascii?Q?kNA79XDA2GZE1dC9PMLO4W8HhcN0T7puji2VyBuuQv23Z5kn5T6RbJOrQVn9?=
 =?us-ascii?Q?bYvzTnP0oMVweuhDSMTl1Da1Tyl/EsJI7dSxCrwyls9sAlFzwey+NOf9mhM1?=
 =?us-ascii?Q?Zd7uYpPOE6Msi6lg1q7SjlwCP8H+VIEYOElYm1sR3vi/p84+nQYbr4ypdDvh?=
 =?us-ascii?Q?pEzHOYwQLqpkVeueZF0jCcuidORCdS9qStHFMRubGCMI0bUAZsbDRCeHlRMz?=
 =?us-ascii?Q?Z+zbC+q8z4eKta+d5KrmpGsBKlUTCH7B03QP+MFP3Mudebm3g2zZYBj8wnR4?=
 =?us-ascii?Q?bywDlWv66tFh2nHZ2zTZ1T6ADLTSJdWWnePBviYHHNLw6RALXLsMo1XGpw0n?=
 =?us-ascii?Q?aFpXyT3Wg82ln9wdNfg0eF2W/yxZHdFVUGPW5WZQOiKBbNfronIrxmaHq/Ah?=
 =?us-ascii?Q?4wlk3MHrhfk/3LKpjbrKsgmf5qcZ3CW6Ie1d3rCdZSHXkvGGhAcGsQpGZbsP?=
 =?us-ascii?Q?uFwV+p9QTq3unYlg2nfU+Z/5lookBV1PwnlqHVO9cHobBQaJZsozKofdD8yG?=
 =?us-ascii?Q?h/cZMcHeopBQOJWvBjrd21uTMdPSgj0pS9ftD36VKnpGY6/fjLf3OKYFxaNQ?=
 =?us-ascii?Q?P/i4kuLytO00/04+lLKwrobJXeFoiGisuMnsRHi+deNk2Bvk4VnrRUZfJzrV?=
 =?us-ascii?Q?Dh91eL2kpVdgfBNnSeSxYusmr8HemRXLKOF5JTlBMqX/KDfv7V/6bAbxsuQB?=
 =?us-ascii?Q?1crVhE94zrWOUkeT8irVFJECCjbBRKI5HPwqleEfi68hK5WZZujisJQ99hga?=
 =?us-ascii?Q?cARN53vPfgHQJGi8QVUaacFMTSZug2iI/xBKDjSit0YUmHJST3khvgBtL/L4?=
 =?us-ascii?Q?havkpCFgb9HpYpCUZS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qkknM2vyzEHrk6CLcS0ju68RRI0ND9i++0cfydvAD5HWBEQKfE1FDHcAuIYk?=
 =?us-ascii?Q?lFqzQzr+IMbCD4zGffkCniKTApfgdKKGNMLqUaRfWwUEbuHVCexYsfKeGuOd?=
 =?us-ascii?Q?J02L6czoDmGxryqOjvH9Gi9M8SriPNUkOGHw07F5ZmCM00VdCHUx1tGJ92bR?=
 =?us-ascii?Q?UY9bwYsL9w8D1ydSQYJbnO1MQ4U+edhsXIsTJoKPjAio+hFsDx6CGIloBnWA?=
 =?us-ascii?Q?lRcDiigV1zPjnLxiGB5fNngd5RZGOaPc7bAFnHqpfH77aDMEILnrufnSaWgk?=
 =?us-ascii?Q?ifrVjNwKxLqLt5cWXxbRn7ztEqw3Ur0iAs7+6KQCaiMqw6sAcX81HrJ/+zYm?=
 =?us-ascii?Q?hO1NnTGsVv8/7XLsbblXxFETO9bWSCz+hZnQ1o6LsouRNoUCulx3GM2y2Pa8?=
 =?us-ascii?Q?k+Ipp7AIfW6qUINwFLdyQV/Q2XmthI3Poz4uLNB/h7/WvIHr9H6Sj3icAXmD?=
 =?us-ascii?Q?DKXHWEN63pB9/PPR9Qy18RY6H7rV1SZVcJEWAUED58ONhcYevRknd8jiiH/X?=
 =?us-ascii?Q?IkeVlqeML4O/OAoyjZ7kxIldgsHHv9oONRzAFSU5dUGLZKgcoaHqKGsgS8IB?=
 =?us-ascii?Q?WAKGBseCqSprNZLkySk/cXH95qbL4yNyTmSZDHk6evJqVfQCf0JZe7dRnGY0?=
 =?us-ascii?Q?nAndMm/ySDRY9bHPqf+fiACW69onYhy+gU+L7Z4cjLH2Q31RUtVn20KO2inF?=
 =?us-ascii?Q?3sgb1ZpOZf3767Tzn7zgoUibyOBYuLfLzn9RLadW+WcEs145ZPsGlkc8qiZY?=
 =?us-ascii?Q?NrsOxiYWiuG5klA/WS8cY4b2QWMFjHL3WvXTuNciIlqFzGrO6H77YjRVhGGQ?=
 =?us-ascii?Q?+JcrkOMghASmgbVZVyqP4HdA3fVO0Hf2A5GEKlC9b/SYoqVVInlGB6XcN2eH?=
 =?us-ascii?Q?wgngl33xFVAquytr3eUHQ9HZrxwZ4JUgjAzsgdDYcGdPfWdBwQJp4rX+JhGy?=
 =?us-ascii?Q?nrbr33bnwSjLh8tApNBDuIRZDW1pAzcGskPXeTygTBiyjum44OQZsjn2g2V6?=
 =?us-ascii?Q?H5tl9SaO4iNnw5QfDqlCQ0dIaLNn2XxmgsjLclK9Hssa3xtgLWZkFt4ft1Zk?=
 =?us-ascii?Q?tBaMoYyaTdiL0B+E7yijBWOA0pibKUM7DpvgsJxJzIKenmPErxhh/NKlPAhc?=
 =?us-ascii?Q?d0b3ZFscnM+o5B6p7iXCQ7YhxhOMhFT55BSQFhRxSMz0BfojQmz0LIAqiTQ3?=
 =?us-ascii?Q?KIdjInBqvr3MqNMMIrTVhvDzvnhJsa55PF4TaPX4CrNGzQWjvxwdfAKliFYU?=
 =?us-ascii?Q?C2Tw+Rj4hgBNcXUTAujAL7JATTNx96oICCSUWe6SwJlv0AQs7hQ2ft+dfVLP?=
 =?us-ascii?Q?Ci4rRKxwmucvqGmaWXUFY+swhmkcD8F/ed3Bbe1tRzFQRJJW9TEgcFGvuEV0?=
 =?us-ascii?Q?61MuE0xYB4HKjPy+es5NIlOwSMilV7b7F6LAk6d6VNjRtcLd68QOIqSEsFdS?=
 =?us-ascii?Q?s/rTqTDwEE4uQwQM8AwR9t8FnUBnvJBxS1+N8nX0HOifykx4owIAZB5CzNHU?=
 =?us-ascii?Q?ub0uzjY6mDHGC9KUmAC6wUL2VOPbA37lW9rb/tYVWlBimvOs8FvkT37WvAsd?=
 =?us-ascii?Q?pNJbDrTuvl2r+UAupDrFmtbgPeMYdtehfzJyUCfczyEKYzzd8UDNngtaOaYu?=
 =?us-ascii?Q?BpMkkmp5p5EfWS4ghymCJLWIi9YrqGR43868F21kAOPusen1lzuR8S0Dixgg?=
 =?us-ascii?Q?oWipOJFLH4o7TbxxP7ymniCOz8TFErVkKtZqxH8mqZZumRVNLMaBDcTmr8VB?=
 =?us-ascii?Q?nAfFPvK7RHRsRY2k3lXuNpiiIMYk81k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17718691-8354-456b-1c7d-08de7348d6a1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 02:03:01.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3fa/j8Gtmq0QRs4LAgxuwcEp68KSZfGxJjjMMCPA0BxuHiS2g8/HTznD27F2iklg6gIEAgZ+RjPrD9ktz0+or+pxfxnNdq8S4F9DP0qQr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com

On Mon, Feb 23, 2026 at 02:26:31PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for type2 drivers add function and macro for
> differentiating CXL memory expanders (type 3) from CXL device
> accelerators (type 2) helping accel drivers to embed cxl_dev_state
> inside a private struct.
> 
> Update type3 driver for using this same initialization.

I've got 2 simple nits that could be fixed-up upon applying,
and one question below.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f547d8ac34c7..ad131f053bf5 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -656,6 +656,30 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox)
> +{
> +	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +	if (!cxlds)
> +		return NULL;
> +
> +	cxlds->dev = dev;
> +	cxlds->type = type;
> +	cxlds->serial = serial;
> +	cxlds->cxl_dvsec =dvsec;

Nit one: space around =

> +	cxlds->reg_map.host = dev;
> +	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
> +
> +	if (has_mbox)
> +		cxlds->cxl_mbox.host = dev;
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");

Why do we name this with leading underscore when we intend to EXPORT it?
Thinking leading underscores are meant for internal helpers?


> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops,
>  					   const struct cxl_memdev_attach *attach)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e21d744d639b..9daf4bc42692 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -523,6 +523,37 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox);
> +
> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.

Nit two: function name is actually devm_cxl_dev_state_create

> + *
> + * @parent: device behind the request
> + * @type: CXL device type
> + * @serial: device identification
> + * @dvsec: dvsec capability offset
> + * @drv_struct: driver struct embedding a cxl_dev_state struct
> + * @member: drv_struct member as cxl_dev_state
> + * @mbox: true if mailbox supported
> + *
> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
> + * struct initialized.
> + *
> + * Introduced for Type2 driver support.
> + */
> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})
> +

snip
