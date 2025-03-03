Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7F1A0BD0
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033605; cv=fail; b=do1fXXQ45W1VyAdw+7nmOcZLuxinqf2O4W9PdmSBcb5j1wQdIrvtXO/7KTA60D2nFcvnMFNh59Vg/TaePu4ofS5mN7xJSMNTsQhYBI/BA/AA9CJpkzmtXdhUB0tzs0Y83PmLABv4daYl4/LGJXTpNqCpBGZJrf3LeZfkCr2PtZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033605; c=relaxed/simple;
	bh=HGbTuCNCyGdrCwzL772V4aDRcB6kPHmaBmSezliuD+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LpjOGuPv+nkeMleD0ETipIQjFh/4LK+0k7J7+n08ukvLF71GunE9fyrKo3ikpZ0Y/w+guxBuXW5L6Gump8wXVaj9vt19GaF2cS2aoIISKYdBXP0rcVdQZhFhbkQAMgPtfvED3oDaYc6aFuGNKAF2sagVuDbDyOdDLwznFUqUlrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FswA3itj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FswA3itj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741033603; x=1772569603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HGbTuCNCyGdrCwzL772V4aDRcB6kPHmaBmSezliuD+Q=;
  b=FswA3itjI6DKMeqRHgdU3wOQJeAjUgMBQDQ/GZk8QMHBRvXVjneI2kUU
   Bvmxk0qhDFXhhIhhbbkEq8WnOeIVThsxJk8kHXdtqG1Q1AyUZhwcCXoNK
   KOj8To2OUwuGEPcwLF8DnuFs+n8TYOb6knezmol+tVPtTvbj3D065hagm
   OQM2lhKH7RlsG2JHq7gNOxU/Ur+Eg1Ul0B7HhZL2Vj9WFu3Jk3iZFobI4
   z94UeBe1uNR2NK5HqHqw9g41tuh/mtsMjwi5aSo3XOQHyKDxcI6UiJ9rv
   AD85o9G3IWgTUKTI6eeBqZg9V3SGVY7POqCXnKBSfvWMxonod1ldoSShx
   w==;
X-CSE-ConnectionGUID: j5lUbgqwRXWSMQ2LFykPWQ==
X-CSE-MsgGUID: rcJsgjs4RQWFeDciUyjgSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53321414"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="53321414"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 12:26:42 -0800
X-CSE-ConnectionGUID: E7zja4ARTJeOaFkFTBnIvw==
X-CSE-MsgGUID: rKWORP2HQFWoIiT5hAmoHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118634363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 12:26:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:26:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 12:26:41 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 12:26:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDtRzJ8+J9r8YE7SsEZb+Ia7nhF2a+vtIxZVDTSUE0joZi8bTxTgzVc3iUUoJm5DjiQ0KuXxi/ClDRDF4uw/SJk4dirUbJ88sy3G9ovcQlV15HYTGeBS5BOoWBwA1I/sGw38nyUunqFQJDRqMNWq9KH+xNl7+PDnTV6xNVgLqcmg6RionrIVvlUfyXYnndIh14H0T5593yWrWAcLVkydaJOyHsAidZ2bOYCFxJQCCGOZYIi+zPOIfkxgp/8qkWGkznYDajZ9O1jDEBXl4c21YrS6xeweIgT3Y0LMHbdoMPJR6D15yiDAKaAjCPHeVL1YTQX9GuB/Y/0ID8aKZ2m6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQHW6OxHzx3VyzVNA4WcLP5aiUa8dM1Kk8dN+G4KHF0=;
 b=FS8u6NzORAKLJ32FkEBqU926nveuPq2YFXQH5HSfIvaHqszA7oASB0VWSnHSsyYvzB8IiEAkj+So9/kEU1SIdPhTJPTYTJHaQP39+EMDsjhBG+aP0GoGk+JZ3ZkZUlFJB7SgpQnNakE/xQBys+DIEbKWtzBrcAQD/BIEd4xICVDc6OmjJgZy3W10c04wCPKcNhoQHAb/YuKEQHj6cdvnJKpiY62rq7f1KllMk7LbH6aCYi1fohp/PkBoiH4IL+Dy2sQ7mhZcCyJJFfqWZ547FZ5+Mvbq2UHv14Dvu46SbpiXUlgPFtj8YOSFVn6xOWHYJupg0hYCpkNgY+6CIIK6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 20:26:11 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:26:11 +0000
Date: Mon, 3 Mar 2025 12:26:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC type cxl initialization 2/2] sfc: add cxl support
Message-ID: <67c610604c751_1a7f29455@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <20250220200041.3891165-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220200041.3891165-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:303:6a::7) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|MW3PR11MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 3868fa7b-7f0b-4fd2-68be-08dd5a91a33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fu+Ifb0sX/2fLxB6hfNQa9pBIY+hOQ1HVX5/tywOF1YfYsh+UW+WuOoPwhmr?=
 =?us-ascii?Q?fIGj8rQTFeXk68renwXrLaD2AUdkQYmOYJIxIQxyZULFoKDGcQSHq6T+WVcM?=
 =?us-ascii?Q?U7aB7WVFwBmOjmU13kSgFHgYyIU/GAMYfi+JdpAwCxMsxtJJlo4INd2h0Q/+?=
 =?us-ascii?Q?YDwcNwA7x0SdBYPhr0jf1Jx+DEFgp+fVcMKgrnyUAdb17J8DSTVLEITdgtjX?=
 =?us-ascii?Q?Rm3QdQTnXqZinUXOT6HY/ByMKkBci2aBVoTQdilxjw6714U7qqp7gKJSX1O2?=
 =?us-ascii?Q?5UQIe3GziANfKLbUvAWd8G7sJhOdWeKPGZe70HErWpRSmW3K3aqAqdXRI9yb?=
 =?us-ascii?Q?5SZ2sf1YbvC17tXjfESdJRwTgqixWafDTSsAnK3LnapWtEr7qFB4m5AvmAZi?=
 =?us-ascii?Q?1bD0ic16aUD6IsVEV5CqkqA475TEQ9NEUisr/JD9taAvj1oOtwMq4G7XXfbf?=
 =?us-ascii?Q?+tWsAgSnIx76Z+LZniE7U1Wyu7PctztbHJinhvgM85xLZ037KYRdTq4dx1I+?=
 =?us-ascii?Q?y0v5UjCT6zk8fo2a7MmaYVJaktbHvO+ph3eeuFe2ZHE4e5/dbdBZpRoG6sFQ?=
 =?us-ascii?Q?FBoTjDcAOV4xp46ZXToUwBXAR9Ek37L5jmMjzIAute5k3CHB6yktyRAzskP3?=
 =?us-ascii?Q?F5TIfcJ1zF0/fy8ip3pnbo3jgU62mxl9X1cbiYQAlhBWZKUriu72wbNBEs2Z?=
 =?us-ascii?Q?3SGDUFAgZGZIjE5bRUgiZM1fKuUCPkHQI5ZZ4niQ787MkIgu1aCJlTdImSD/?=
 =?us-ascii?Q?VsKynGO8nhV2K8fwIAAnL0Zk2b3ORrM2pzj348OFMMc/LjKUdCcxHe06+9s/?=
 =?us-ascii?Q?DNPIfwVGlfHm5RT2U14PTshJ7Q+VKg4sCOTY01KcC4ALyW7ub+cgYryUIcGS?=
 =?us-ascii?Q?Wh5JF/TTscOSZInu4mMvxwAatVy+phKVScb6F15ot0iw4rdfsZDGkuGOV6m2?=
 =?us-ascii?Q?AUAI+HWpBxeAUWygQkYzXhtaiF1AfgePbXPdVSWEa1oGA9QwJcjbOa3Gt4ZW?=
 =?us-ascii?Q?TxMKWUvKw0q5iBLS2FkBUdWx2fm/QXYbewAvsdsJPSgEshy/oARSD1YnzOTt?=
 =?us-ascii?Q?sOAr0jtX78pYc6KZygzHc42QpDou3EyZ5gOLgaTz21Yphp/sIwidm0qOCgVf?=
 =?us-ascii?Q?SwU7CCxj3XZ3SxRIs4mkokzEXb2A9NcAM4AUEx4W4N6QuaRE3wEkql7WXH2F?=
 =?us-ascii?Q?V8L0XyMzgkaTz+VYwn9fvroag/dP61XGeYQXEljw2FXCzreREJGIoaH6sQ/0?=
 =?us-ascii?Q?NHmw+crPM/GhL7xjB+N5dVYyle0V6hEfrShNRKNtJRXN/NXobyvIDODANxdQ?=
 =?us-ascii?Q?GoycjZIyC0YlytuVc14mCKvjpoWomm1i3uUBNgIDBpZaA0ecTaXL/YPtH20y?=
 =?us-ascii?Q?jLk7Yj2rtFIrO0nLpFRucsv5aDG8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mWj1X2747pM1qaFqXtdBRYH4yO6PD2u5am/EkELL8cpWtj2aVsO6DdNGJJ9T?=
 =?us-ascii?Q?+xPr8TiQ/JWzAuzoQZeTKcSLkW1iM6cFEkU4pPS0nyi9KVG/TTH+Q/SgacZL?=
 =?us-ascii?Q?Q1NMrPCFHMoEWwsaxKF3NADSCVbFI6J8VHNYQTMB/0hzF2NefJaYcdDpBQhY?=
 =?us-ascii?Q?h1uC+zI6DmSi/LpQA9pCVWXpL59DjzGBmbShzNXu637Of5hmdHWwy762yXz6?=
 =?us-ascii?Q?DTWSFD4zrdbc4GqlLpFfRIUV6Tp7TwHFeKmPwvbFGMhjT1pIKR37uK3YSR98?=
 =?us-ascii?Q?UjIfJgj9tgGWRM6nWOHNlVOQwVUxEfRkJ5XEnCEhSDFfhISMfWPtuMYymDlB?=
 =?us-ascii?Q?1LKQmrO8cPSv7qC6fVmwX0t7SPicYyVSKJrDJ76EvkRKrhT5/zG1Tyj6iHQl?=
 =?us-ascii?Q?sdrSQAekfbR3jTDeK2xGvj6/4UYfLf8StXOm8PjTQejLuQjjchDaqoXHDA/J?=
 =?us-ascii?Q?f2Iy/5knPB2C//eH21xNCAm/JG0JRBQun6Lm3iKNL1hq1ssV9PsemgtcYZMX?=
 =?us-ascii?Q?rCb6HXwDwGtFAdXYQUEsOuYWej0TrOPbK0tTUrP78OmtQbdBQjDBkKOT78Ie?=
 =?us-ascii?Q?xPUzTuV8wFMQUmtRWnRztSBtjIqj1YNCWxtAsqsBklvqea5VTthxbsKHRV4u?=
 =?us-ascii?Q?too9kvI4SSSRbr+kghhuUbBRt8W0SWy14LDIq7AiRzGlXCym1TkEUvDUToyS?=
 =?us-ascii?Q?e+atTwNukaDS9u4DOzyShMuN5t395hXkyolva6vj3/4BDHIUm9jTil9qvVqP?=
 =?us-ascii?Q?VLVQp9Mie/VRga/cWXgaLOg9VHm2PaSqxGU3VbTaE3PLsXviDc7TOtG6Kp3c?=
 =?us-ascii?Q?nT9GgjjQqikIuMuhmV6AY3apLsdAwMI1PdwRjyhfyB4YfwN+22R8qhhJvLJK?=
 =?us-ascii?Q?WZbAOMU4Ol34b7OmJCX97Gvmh/95OOc3T90fS9CKU850aQfvhtY0BCvLX6OK?=
 =?us-ascii?Q?U7ZW4KHanaVMcgusarHy6VblJblretJUdPWkN452Yq+D4TZhjiOfWSkRCmic?=
 =?us-ascii?Q?JO1IdLQTURxe0RLpibnXtY8tTv5XuYdnX+lCOmY7t/Yi+A0xKT/xv0EG4ErG?=
 =?us-ascii?Q?gBG0VdJXzNhPJPWzkxEj5yPKM6Y/D4X0VjUW96AlhLgmEAvXqQ/2wnPtJIXU?=
 =?us-ascii?Q?wGKaDKo1sxpyNJbM1QSR8lTmHeXoipcGEfG7qV/5mQ1ENUmSaMfiWi1OCIBF?=
 =?us-ascii?Q?Zht+l74t+RImyxwlTZbU59qZ025LIgGlWv3WbG640bJODyIi9b4IVsHyZnVq?=
 =?us-ascii?Q?CCG2u0WtLGu6EqcizJ98g8BklnpIKtzkmvRcGGZ1BkBFpgahh3QtZsjILai4?=
 =?us-ascii?Q?CLTd2jkhNJUxhIBVwDU5oUn4uZVNDeiQClRS4tQxBLBeAwfUXEg1gG9kC7Fn?=
 =?us-ascii?Q?ntI0O5y6n0Jwr3qMZEo3Ne8FO+qiuIYFgJOPvi8dgWMxzn/mkdf2sRGiV2cK?=
 =?us-ascii?Q?eXkPVp8xIaFLRBkFRotUDJxDdgIZaIpsdBLc4jIV7wyubeoxSIzbHeUPtlHf?=
 =?us-ascii?Q?aNxnPxXt2gKEf+FRCYf7hirkTC/CoekYbpGeZPz95Ffdm8eb94H5X2QZ6awS?=
 =?us-ascii?Q?9Wz21cR4SXAkBcC/jl3HleRYpMqCNY/ROQjGmaN3jQMEitKdVxMkzOSgaYI0?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3868fa7b-7f0b-4fd2-68be-08dd5a91a33b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:26:11.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTktPSmm/50vFIneDD1T0CPRnGZ3ngZmeiWDYyaN7AEvMBNEzPRKoDn8fub7ERScZLunUXt0DFFiv44vmQ7R5XhDBgf580KDYopN2M6rGls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  6 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 53 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 40 ++++++++++++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>  6 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..459db14e5ef9 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -65,6 +65,12 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
> +	depends on CXL_BUS >= SFC

You only need one statement checking to make sure that SFC is not
compiled in with CXL_BUS is a module. The second syntax of:

    "$dependency >= $consumer"

...appears to be more idiomatic to me, or at least more concise.

Otherwise, this patch looks good to me.
