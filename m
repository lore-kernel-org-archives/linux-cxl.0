Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BD227BB5
	for <linux-cxl@vger.kernel.org>; Thu,  9 Oct 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032071; cv=fail; b=a0oZg/i7ZoQ5H/Lemma8e7b8xAdkb1BAnNCIksNeLlhM5TzF3fP+fROUjvKLaxmWjIbtJDjKkdJ4PN0BqrooWonLUnmuNvJV+/lD5mCFN/g4DeNlyqyIrRLG24/tzJKIdQeTxH8Enj8Fj2DeJkOqEucu1wMeVrOYsBpF3Ys6Npc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032071; c=relaxed/simple;
	bh=BtzK/1htyT8rB/FnynaRRBIWXCkbzqqPIgey0PPJg4I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PFSj/B2jw4U+jPI6Oyj2eaz3rHQVaWMkbz+Ju/XgxSptIZHouKjdcmMKXBcwa3GPkwG4sg87tMXdr4OyCy1oH0M86CrSizcnUSlrLaEAehzZFRk0RjMIxIauHzBIpex9JDkBiGA0sjjwSbnJH0RLm5fa2/oDWlBS103uLPyZXTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ae50csa/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ae50csa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760032069; x=1791568069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BtzK/1htyT8rB/FnynaRRBIWXCkbzqqPIgey0PPJg4I=;
  b=Ae50csa/E8dvvUeGRu55pvU7N88HckZTdQ87XSfAZG57j2k6R3QsCQf+
   zEshmSxrqDvdajxzJ8+a4KeKN+ktl2j+LJjm/HevCcLsRRP9CPQ0UPY8n
   DfLMHFUFVd5uEa6vPL80/jjHFYeY8jKPEhhAYbMQJ1GALE5l+lB1xvbVl
   PoTpBZhl1Lu9pMf67dWjv/LCdMEXass1ISHy5sh/gmTuGgy/T1ax+mAzL
   GHrKf45K3oWwStp4gnq5kJrtVtWXxGQjmhZeAcL8GdHUHfZo2WZ/RST0x
   teQ59A+yrAvf07FSniHPh+hTP6oqubAIv4Agg5vJYSdJYWqcJBZzBIQ1j
   w==;
X-CSE-ConnectionGUID: YGzZcYbXSMeUTBzdwCpFwg==
X-CSE-MsgGUID: tItqpd4MT9yMEhOkk23yMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="62348520"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="62348520"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:47:48 -0700
X-CSE-ConnectionGUID: tldSU9yEQX+BZ+NuPx9+Fw==
X-CSE-MsgGUID: vld5+QpZQxC3QBheqqsqlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180457633"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:47:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 10:47:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 10:47:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 10:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWFdiOmoEwqme+xxnbqNcWwiEFC71XVnUyeVSTCgxwkRA803evXjCHh1jjz/8gKJcCLcDfvyjdHsumCP9rds3yym2of99Av6PaizLuqMz0dN/hdOBdj5I559BGbolRkYPQG6gZghQWlsaGQVi/kznRj45BG9wmysVmU5JXilRlvyigTI/60nG1Q3DouLdZA/Da3soMIR4GD4sqMCfaVaTuEx2AagQ/hIr32C970RsPcJ65ol9Y1QeFa0eEzWhyL537qA2u+XSHozdlXvbgCM9oZa3+3qAV5hFNdQGXk/7CBrAJowHRfUbEJ7Zc5r1LYw7IgZ8EWMxVqy43Zw+35/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcLtoVTJpVsNG+FdFALEzzKV5vkMYjOKon6ZPstAJBo=;
 b=TVpyCuogDVsT4BrAqMmO8Acy5vvxMkS5w1Rus3IOd2mnWfyK73een0+beNMjR5R70UWdoWDUqOKrKdllV//6aGr1jZb7rhl2K2ThLdOXHq9x7nfd6Ha4kg9d67kSRADQa73Yz0RUI99YNnGwgaY0S9ZXSObaEAxp6IQQNl+ZV/wyuK2sH359CQTieZ7lhRiqDKPDf/nKtJXarLRsiYRQUs2WVDcrc6CwS9/CIT8pe2WdXPiabZH2/+9JE4pai94zicTUQ3DH5wtgn9IbXSc8FrO3csJCg/PsE2hIFDjORuDwUs6b2BLzsqke7Yg2+xZx+vhMc4kwyqEmQSNwy0dzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFEC87B8781.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 9 Oct
 2025 17:47:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Thu, 9 Oct 2025
 17:47:44 +0000
Date: Thu, 9 Oct 2025 10:47:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/features: Add check for no entries in
 cxl_feature_info
Message-ID: <aOf1PHa8OK34Y_pz@aschofie-mobl2.lan>
References: <20251009154001.2660917-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251009154001.2660917-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFEC87B8781:EE_
X-MS-Office365-Filtering-Correlation-Id: dea3b03e-bbef-4359-352d-08de075bf3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R76duJlXaOdb4Te4eQr8d5x2itO9kDe74Zd3b9mjy5lVAQzmt6leOyPFoDbM?=
 =?us-ascii?Q?XitP22Jyyua1W4uWJAfPDk/AdwrlwkYghRTz1PHL2Svu+dqDJCoyr0dZxLVE?=
 =?us-ascii?Q?xGslqQVaZ9GadcuPQ/JloJcQq2yRQ5+0GTgKPiDj7I+dArg1mfqDwk+RfNuO?=
 =?us-ascii?Q?4pV5GTb1Egyy3/K8fV9HtxBeUsIy6dCEgb5l5OGt8W7gxsUqlAxkCFrNaK+p?=
 =?us-ascii?Q?yCj/cBATV8GRtnU8ZPVYT/xmzOja6f+FjoUPeAapWhAGOysWUQjPzOJK7k35?=
 =?us-ascii?Q?qXPy7e2z5dX7CESJe6KF6dOvgLZD3+g+eyRbDldTGAQL48Vq6fgLl5n/yLKX?=
 =?us-ascii?Q?OnZYlxkeFcU4Q8mG+o7WHH3r/ij8Y/bVi1XY/9Dn9LSVAxJ0/mzIjuWGoB/k?=
 =?us-ascii?Q?zFsXkVS656O4Ly8Nz/diY8UmH5El2hrj+cV7bt4fFmhSQuct0GnD/iMIY/Pg?=
 =?us-ascii?Q?cu00li8KXbRXMmuwH3WUpiKGB+4mXMsie6x9X5a8A+PhtjqKTB0VXiSfu6Mi?=
 =?us-ascii?Q?1cy3r0MhOonaG+RIh3YLDDCDjHANKkZ2XVHNh0J5U7bxJfTVJ71yjxV0wsNl?=
 =?us-ascii?Q?wTuHtHHRafW/OStWFEFqZFHV0ceMfauKdZcZD8PRxA43gCDK1nlpsBlky0IW?=
 =?us-ascii?Q?Ywf7+M+Ei7c/JO6kKzlaeR/zaWXJ7D89DsPUPrBtro2DrXgOPdca2vtL49QS?=
 =?us-ascii?Q?Cy56kWMuFMUH+LZAgKg4MCqgFu8//AajvzKT27/j02KRmyRB0qsDyWBuc1Et?=
 =?us-ascii?Q?ZCExao10uaJA00DGas8fwxAnmvAUSAuBIsofTziR8sdcBVt7cSRLAQnh7wf6?=
 =?us-ascii?Q?PsGyoaCglHImlZdoLtiLDSljEdzhC5Jg+wYA3vTZH/QAlE9BUA8NxaDphZgU?=
 =?us-ascii?Q?u/NinEH01MPZLPvkf8SsgeETWqDIxry/RhZU9jEIhPfB+lyaom2C4pAGcV+O?=
 =?us-ascii?Q?pRcr21v7wXSQ7P6v7wM2PKDlKqTSIp0LO0OAhVRnwvqTc+uum6pLTdcHiSlL?=
 =?us-ascii?Q?CQGEBJUqjsVaW/0twE+mjU9hgupuqFcjCDUbF6XP0ZW13FJQIVVjqBppbFkj?=
 =?us-ascii?Q?SaW96QnyCu274XN74wWUxyQWWIQey/pizia0BGzvxXjA44H8u3bI254f7guX?=
 =?us-ascii?Q?tBf3cnsP9jEbQdMULUafZ0/PAHBgrrp4V7VwieybK08cHMeQNyVHbB+LiTSe?=
 =?us-ascii?Q?3d0is0MBWpyq3mxaPAkhVuvK6uVIrs5BzerFTzGA0I166H8jRRPHKRAQstNp?=
 =?us-ascii?Q?JsqrEj17PuhFVxkWnWX7TfeTT2E5beik4QlgJFmayBWdpv831O2Y4vI77OAc?=
 =?us-ascii?Q?Bp2/CaclLPyyDmx2dlRuS9Lty/2szoQjqisu2A9i2l4TC2b+HiLT38UWY0gl?=
 =?us-ascii?Q?Ad7/H9jReIePRMLv6r+ug2JkZw/NKpieqrNCbDaVDS3pU6FYVxRvxNgh0sp1?=
 =?us-ascii?Q?HMsJyJxp04ncA661KUt1YztuQbPQSNYd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBkjbOR+bkMxM6Rqvngd9oZgw4S3BMJk31oBk2ex+eukF8xMl8RSTvrqm7xQ?=
 =?us-ascii?Q?j+75unVjYbmTn7ZcOUXhBnbduVrTvkgAtL1s2p/sGp5Wxkp2poVm3LH26R33?=
 =?us-ascii?Q?N4V8i8oCiA81QB/3WB08Z1GCQyOKB696xv8BAY+0qAyVEdbax4zpPcXV88jx?=
 =?us-ascii?Q?3gV8KZP/Gihl9Wr3uU72BkDyYmKYu8Mk+c4HBLxChRKzD4A7ZsWWg5Pp2b2+?=
 =?us-ascii?Q?O/YV84n6GrQ9Q7j1W39VZ8Qx4FhcILWCZaXL3ETlM5xIdgpSxTl61ef7EcWa?=
 =?us-ascii?Q?6Ngvxv98jPx0WLl2CA5ythenpYzNl0Dt+frSLDVYKzwZGmQvj6gCT+SoIRRE?=
 =?us-ascii?Q?iaH6WMoxdjPbP6y+Rxa14sj9O8Rre/xHG2iDqxRtv+AveW0l0jrOvcF+sxIT?=
 =?us-ascii?Q?nK+dKQoBlvMcHurp/8ZCVx3O0Vozpyo4IRW/yD1i5C8Sgr1JM604M42Zf9M8?=
 =?us-ascii?Q?wxx6e4gCi0UvO7I+X3gAEoS5JTQBEFigMzJyMj+j0wJnTMgQN/fYPRNj46AR?=
 =?us-ascii?Q?HAbHMZiic+MsC2y7zqgxLxGN8b8J3VCzqIi76gFGcNCcmJiQrw06zWbKhWBL?=
 =?us-ascii?Q?mnMf/dVn5d954Tr7tQHuziJaVYiGLiJFndLcCPshXdvni40VlRPN2dmICpS0?=
 =?us-ascii?Q?86dBjZlUxIn2ghE3b2SWXDsTYtVKImfYVHcPUDjUoiw+K8VI9ginPKQM7oDa?=
 =?us-ascii?Q?UBwiE3pzSc9Xr4JYrbMDLnTefG0Bu5JJr1ZvuevkVECIbGyq2AOVumQxS9tn?=
 =?us-ascii?Q?dkvh/NMNWFZ26KlIDpCOyfWdHVYw+Zv+erXXgDJ+iocqyaFdXtQVMV5TF9Ja?=
 =?us-ascii?Q?orF4rBzH40oqry+bWyWa+Khdn9fdOxltMFIRquvmuyEbcXb4wuKZICFI6/WC?=
 =?us-ascii?Q?ZRm7f31lwGDPz3Ckr1uKoKuVTG4pZmDggJT00cfLQjw443ab1yPaMiT1FPpN?=
 =?us-ascii?Q?BTHYpqjb2xOKocudC/jtDpGhB+Zi/ILa1dkvHWMtkHbYIoOh84AMikOU7yvV?=
 =?us-ascii?Q?laWsVGc3nLqtR20WeD0PlU4Q0ly2X3XbqJ7i3ujPZ3UA6585L/D5e2YIBE6Q?=
 =?us-ascii?Q?GOCn8PJkm/cvxBqHwvvefTFwD7neDKPPynCtpws8r/JOgRgNUmasS/nH0e95?=
 =?us-ascii?Q?AYC6ZlbNAEWa7g7Sa/vyYvZAGzMwULb+q31O6m7RgfoxSYdyVCLo2HQgoDI4?=
 =?us-ascii?Q?4+GpuDPMG5NmBhUQmbQP5zegSI3G1otUxQfX+GOHokU961HeLpST5ilo+YU4?=
 =?us-ascii?Q?C3BGx23lnRj2Tli3DOL7aDSfeAXBxIRIKYyhZH+UUSMuyNilkBUWp51OJ/tX?=
 =?us-ascii?Q?B/TzaXr/1Gapa2E6URFO9j9+HOzU2e/TwOm7Bh+gDZ1Sw8a14HwKtpwHHAMD?=
 =?us-ascii?Q?sKLfdTwkTWOOuAxuofdED+jqz3SkvIBl4Ka6GK0A/cZwptf/vr+z1R2R5uZh?=
 =?us-ascii?Q?ZszgMQxd9u9eLyD27fn+GQY39cbQvDgpHBd7+0PZ/phYdXpfjgcB3lsnOziy?=
 =?us-ascii?Q?y0cMjWVnO8B7+DG1gytKv5tFPnqkoTQaxKgF9uBlGBeYaVq1GHwJWL5bdwTf?=
 =?us-ascii?Q?79pisNojqqjLTvAbA4UhHaqw1oqmtplNVh2KHOtIlQ2kTx5j00ch3T8Aia1B?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dea3b03e-bbef-4359-352d-08de075bf3ae
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:47:44.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9tqISW6154TzJbW8CwTKyYG5EQf9rnRT4Zq560WOsaMSNGYzwRpm/9s3i20XTQ8wKQRc84N9GTJMlDYOfQhiiJn9iLPKtEBd5IfIW84epY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEC87B8781
X-OriginatorOrg: intel.com

On Thu, Oct 09, 2025 at 08:40:01AM -0700, Dave Jiang wrote:
> cxl EDAC calls cxl_feature_info() to get the feature information and
> if the hardware has no Features support, cxlfs may be passed in as
> NULL.
> 
> [   51.957498] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [   51.965571] #PF: supervisor read access in kernel mode
> [   51.971559] #PF: error_code(0x0000) - not-present page
> [   51.977542] PGD 17e4f6067 P4D 0
> [   51.981384] Oops: Oops: 0000 [#1] SMP NOPTI
> [   51.986300] CPU: 49 UID: 0 PID: 3782 Comm: systemd-udevd Not tainted 6.17.0dj
> test+ #64 PREEMPT(voluntary)
> [   51.997355] Hardware name: <removed>
> [   52.009790] RIP: 0010:cxl_feature_info+0xa/0x80 [cxl_core]
> 
> Add a check for cxlfs before dereferencing it and return -EOPNOTSUPP if
> there is no cxlfs created due to no hardware support.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 7c750599ea69..4bc484b46f43 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -371,6 +371,9 @@ cxl_feature_info(struct cxl_features_state *cxlfs,
>  {
>  	struct cxl_feat_entry *feat;
>  
> +	if (!cxlfs || !cxlfs->entries)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	for (int i = 0; i < cxlfs->entries->num_features; i++) {
>  		feat = &cxlfs->entries->ent[i];
>  		if (uuid_equal(uuid, &feat->uuid))
> 
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> prerequisite-patch-id: e3c6c0e3b81959629a6ffecd3994f683d0d530e4
> -- 
> 2.51.0
> 
