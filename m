Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D0480348
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809748; cv=fail; b=Ptr2hPljAL3tt+xo8L4/xmOK0ovEwH9FUwmYim9OYK53HwEzokMINd9B2lmVlKXpTLbRHotvqzzrYJNDiXUKRZ2wK/KmjOijStC0LbmRL8X4/k7nK4P0kwhLwpP3OcoUvkgQFW2ZQP/Gib404U0YZztOE6OYtgQPRc6KtofCBAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809748; c=relaxed/simple;
	bh=RCqoSFnFxz0C+TnJTdFvtk/Yreq/rUen0uqROhU6Ieg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f/5vWqO+F+hocCkPDtz3CBtQRSuZEZgH8FP0ctcNPRmHZ4ACqbT+gF+bBaY4zz4V6GZPNEp8jUJedjYgr34pTQ+x/uFm/W2yqRrP5mDSy/Rlw7E36ApDAApCT1/QjxeDc66vP1cOLSMonCLFFTnrdztKD8FMMJG/oISooQ3zhWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCU5YQOk; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCU5YQOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809743; x=1822345743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RCqoSFnFxz0C+TnJTdFvtk/Yreq/rUen0uqROhU6Ieg=;
  b=aCU5YQOkPWrUtyitzvpZC+lUMtt1zeKgxrJGjQneee+ebxPc/LyGKJ3j
   DYJWc5LM7aZ9EkBF3xRLnavvXLvmDCw/63ManfL2FVF/f6KZyqQxwhB8w
   nzcTUmYBEZfbWq7Yr7sP3/53CMyaN4pKBO8ing1NePvUJxJtsS+LCkSSs
   KhQk9MtHZRV8RrVV+oC/rxQK3blUiajqUTq14P+qbqINGkyYPp0hxkZ80
   FNNgBHVrGa3/gIGKZuRexesTjodBfbSx1BoWtxx2e/XUQIGPoR9yqU/1W
   71De7QEjdONRnPEqAV7Ontpr9aRfqHASV1kIIN4+AsVA5MzbGLs24Pzuz
   g==;
X-CSE-ConnectionGUID: 6D1UsyD+RDy3F+Ht5ZcEZA==
X-CSE-MsgGUID: 2SYcvJW2TeyFXMuweUJkYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90595391"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90595391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:08:59 -0700
X-CSE-ConnectionGUID: 4KsN0yG1QfaG+8e1NSE5zA==
X-CSE-MsgGUID: ne/PofbxQRC9D/ye4rbOcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303754520"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:08:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:08:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:08:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrT2yNxfJJ3u65+hy+yvZ+HpoKKYwCaQug2ISlYwGVie43aitEEP5mvUt6SjVg7kQKm04i2X8YU2s6cwdcpLFRzPSIHrKCrtU3W5UzYiQwHy0d6MFdcYwxGfeRxln0O4klobAhIkjb60e8WrZtvKparEnaDLQnCJDqHsfoWUL2/I1ejt6G/JKSYYfZIDSFQbdQ65WD24cH6oo9Nxd0XSxPBUOhSTfSnzDZf9450yYSntCovzw6S/yQqC9Bbkz7lK/m1p4V/7Ug0cmmvXiwtjCgQwQiADXSbnc0ZDTkkOgDT3zp5D7fRvLfKg5XAlpfhuwbLo6x8SNxjDvIzXBgYSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO0yPOysRLmDgD9a1UrSh0aW4DpUNwrZ4nu5FJ+TA7E=;
 b=ZJEF+oSfA0mG/Qjdyy7+UjJNUj8KlY5MpMoHhjnovDoe0/W0XWj8PI7+G90m1FxzvRy4zpuf+hCIOkZRWAy+PemgV4fAK3gV1yoxZYNDS/dhNocMHxY1vbGrMrmiiIw4kR9JKTsyAfZRG5TX2/EwphSdkw3r8ICQ4XL43QFZwvleJtfVp5U2sUEnASjQfchsmZfw6Rr31wyArsSf222xCABC6LOTzdnrjOCrdMaaX7X3ZAU4PU8DrdfP5DdIbj9jk2Hcv/d0mVGFXk5WO4MkIh+UEsuJrm/lLdy49qVAAX6PwWCG7MIs7+kKIvqhG3BoImtFvTN9TqbbDbbe8hIYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF4990C6B9D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::826) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 23:08:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:08:54 +0000
Date: Wed, 30 Sep 2026 16:08:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 10/10] cxl/doc: Update maturity map with BI support
Message-ID: <ar2WgkdshIJSDxYw@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <8d84cdb26c176226070377f8fdd66fc6af5ace6c.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d84cdb26c176226070377f8fdd66fc6af5ace6c.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF4990C6B9D:EE_
X-MS-Office365-Filtering-Correlation-Id: b0accb6e-6adc-4a23-50f8-08df1f47cc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Ns1NuttvPo0H+8TPqJffrheU7/CcUM1Yeq1a1UZ27vi0kMNyYU3tUolrUADXVWoEEZbkgeMXPKo+ZRRBm+giCX5zyjL0h/lZMAVj/OW8FremU5ro/fA4U3I/gOtqU9CoSY1GS/Ps9Nrgrm5+Ofcq/OychtohMreaFiayO3JHb2SEoqWGcU+o5l9wX6NpyObAmBjCwEnU01tAzjVeAUoXYlVc3BVjCJVyIGdMj3oaoIB0q6bygj1hyZP4YhigR4BygNWRkPslO/O920p8yVyc8M4bgKiEUpwqQpLpiOSMdlcSRdhmp/HLUJiGYna/XVXaYwG2sXhDeCWeZyN1nrwtVPThfxLRExkCcfw6tDlqGgXih2TNNxIDSyAFmw+EXOpfkBWsap20+qxBFMze0c6SRzjP6JqrnRO5lww2Yzcex5VwuUBMAG5ECUPWCImhNvNBFJz1/jZZ6A4Z7dwFaDCM7wQf9oGoXt4OunHEahnvj6wPNxgrIhsdc04PwtGNHiA2iXmjFoNsreJvoK71t276L74JBu5r2gRww94bvHPQbEl7zjl+aOvau1tOWgB4Ccp5i6FqSb5PD5ivJFXTGPHH75043UrdgmzB+6Oc/5MfUogxaDUv8JMxElvVe5wZ2WZo0Gi4OfaK+XSVv248N+WswvcRvo73YA4AfF9wHpccvoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dD+AWK3CJ7hNqBovsowsl+yek7cw3Z5PfD1zc5J0uSzHXUmQcUHCPqyAOaVS?=
 =?us-ascii?Q?UP0gtBFUqDjilryevzXUVZN5kdESXfmLlma4I9DjZZlasnTxFA9oEL/gN3uB?=
 =?us-ascii?Q?cwTV5vv1NGfi9zvo3Qm8Bz8USXfdILIHLHuFtfHzRnc8Y0eHaSx3nhnws1M6?=
 =?us-ascii?Q?8vuHFju/Sk0Lpmrz5irFukrWVmXqAvx3mRPUAetvO+LvqEgOP59IBgvLCXJ2?=
 =?us-ascii?Q?7etw3zmJpcKEsZ5/KIuT8jd8RDx1hpOVVCTfA3nDpFjDqh3i8z6PnuazMNhe?=
 =?us-ascii?Q?am5oyf2UjWpacamXVbFViHp5Rmq6ayDRn52F03OO9bkYsFJrbBSJQHwzThOG?=
 =?us-ascii?Q?TGYaX4UtRWkz+5X5dUbLP4eoiVNH/KaGSXSSvSs/LJjHE0BQ2DID5K+VeEL9?=
 =?us-ascii?Q?NZvFgHelq2hh9QHYPOn3EzJoQngDOrl/Iop22rDJXevrL2oUZvVqps0/+1JG?=
 =?us-ascii?Q?KwNNiNFhFmEOXVGTyMIK0qLrmJgS+XrCamNZEwE7h0BCQtXMSYGoHTmEApwo?=
 =?us-ascii?Q?1hOTtI6zsPd3lK9d7lvDV3BLdxUBSSFaa+nTcillwU+1dmEwaIvja9eQDpkF?=
 =?us-ascii?Q?p9mc/Y4RcMCGWJqU7ik3EzcG9UbQ+PIK9bOXE9nanXWeNf3CQoSng0gLFdiR?=
 =?us-ascii?Q?ynospXRn1Y/MWxMU50Pep2v7kLe76aBs4D1/3a2IcU83yVsx60dxPQFQq3Vp?=
 =?us-ascii?Q?evR1COUQeNMHMafSotLyiDRKaKq8OWUCQUvF6lY/HMnZzb2qe6DSekzbnaux?=
 =?us-ascii?Q?+4aFtlfPlXRkJNjnl/xBhMSuNjHrdM+m62KcUYOpF0s59/NX/K7A6nmx1cL5?=
 =?us-ascii?Q?ULA5tw3DA+xnpSv51imMjg1DrmvuwCxPOTc1/s08RaZUREDKD8jOEpLsZzvx?=
 =?us-ascii?Q?vqxyyws6wr0c0pBz9W8pmK5M2zO1/Fy0Bf+OT98AGRGbDbWlLTLEBuR1Bf5Y?=
 =?us-ascii?Q?+Rbl3adU4Hgq32+WRAK3fESACsYsMER7UK0SQsLmmEgwnUKCHTSlL9sW6Plu?=
 =?us-ascii?Q?t25gCqTPCXAGgo0KsKQRdIsVHIBJu/UKjNc/G3fV19rymXbO8opeuITefOn8?=
 =?us-ascii?Q?xq03t5dYfQVKFeVEVKvX3zko4Zpk7yjNHiCaehioZnuzPTJYeNESGJukXhU0?=
 =?us-ascii?Q?IBluInVzawenfA5uedpX+j8lB3cJ2XKnHhTWjRU17r5mYjUtN6ilgKxOWKv1?=
 =?us-ascii?Q?ROYGELn0rDnc01HYKY7K2vzaRgxOcb1YTrtlpF3cpV1M/eyAvxr+Mkd8LCxV?=
 =?us-ascii?Q?kbd/t12rsdV3a9ZJvMHQq1DAFnv3u/YdjDTW4DyCF38eMJw59cTYbGBbDHaj?=
 =?us-ascii?Q?hPOsKk3cSEwxWKAjByR/xzUgECzw7jvocpx3RH9XXn91P+JyORuOdcdWlDcj?=
 =?us-ascii?Q?V/SmmMAaBlMB2/o0MtXPJEUtSvWEyEdn7r9Kk1SJrSKu8jyr31U7yr6dxemD?=
 =?us-ascii?Q?I4nurgFDO40NrVnoCWvmGlBZrY2gA1H7o2w2lE8FNCXiUC2mYPZicuzYzcdo?=
 =?us-ascii?Q?Gf/GPkwGKOq2dtiv4kOQjta3IPWA1x0hhXzTfU/XoAKiqZk6iZI4IxC2MI5J?=
 =?us-ascii?Q?t6Knk2Tmdg2AoQW/pID23JGSYs3QVpX6FRMxov/8B2W076y0abRO9nT7mG49?=
 =?us-ascii?Q?wo2qNmQLvEn8jFp4TX/NQ5C6x5b+50CIO1N7fSfmiSIUJGYghglDAroZfqg5?=
 =?us-ascii?Q?EXddp46AGLtSKNRfLuZo2X9ueFSveUi4uboIULZQ/1h7FOucnu/3ndBxrW8V?=
 =?us-ascii?Q?vnPgR7zIUR/N5TYzzr2lbizSj9OL8Iw=3D?=
X-Exchange-RoutingPolicyChecked: sBI//KA0gvHRvFJSSfmt3qvPuvTDe6Xo1162XhEUAldN2lVm/I/Zxhv4wDCdB07Sb0HMPLPRC6dj9kNm6Jxbbg8ji7DViE3PwxaRwFUeKR6JLtSxM4hspkYYNfaLiZYQRqIi8N6YrdLYNENF054p5F04flWm9AUFA+eBgSmHyM5X+P1BEBZJ5AjQwoQ6cwZtmkO8cWZAd99GmJ/P4PMmkG5oVOFmQYDmAGQc2fM2QZxWXhZ7/+dEQrnpwG97D7Wx27dcUMToAjf2ASKNnRi+CeOayl2c7QgAC/opGYCjsFzeyWtwvOqyWOh4SozHtLkmFVelEvnnCD217066uKhiYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0accb6e-6adc-4a23-50f8-08df1f47cc3c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:08:54.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plvYY27d/bWk9sjrTWK5Zxarq7niko3DIO3HneIDUK2lGIz+SLKW3sywdjIU6qdot8RHlEZmjQokgdAbCaFlDhZGLAXlwveO7dSYu5BvaLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4990C6B9D
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 05:43:25PM -0700, Davidlohr Bueso wrote:
> Add the respective Back-Invalidate info to the maturity map document.

Looks like this actually updates BI and Type2 status, which is good, 
just not stated in the commit subject or message.

If you're reving anyways, please fix that up.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/driver-api/cxl/maturity-map.rst | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index 282c1102dd81..0b857476cb47 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -63,6 +63,11 @@ in place, but there are several corner cases that are pending closure.
>  
>    * [0] Decoder target and granularity constraints
>  
> +* [1] :ref:`Back-Invalidate (HDM-DB) <back-invalidate>`
> +
> +  * [3] BI topology enable / disable (endpoint, DSP, USP route table, RP)
> +  * [2] Firmware-enabled path adoption
> +
>  * [2] Performance enumeration
>  
>    * [3] Endpoint CDAT
> @@ -166,7 +171,7 @@ Accelerator
>  -----------
>  
>  * [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
> -* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
> +* [1] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
>  * [0] CXL.cache 68b (CXL 2.0)
>  * [0] CXL.cache 256b Cache IDs (CXL 3.0)
>  
> @@ -192,6 +197,15 @@ Details
>    hiding some standard registers like PCIe Link Status / Capabilities in
>    the CXL RCRB (Root Complex Register Block).
>  
> +.. _back-invalidate:
> +
> +* **Back-Invalidate**: HDM-DB lets a device snoop the host over the
> +  CXL.mem BISnp channel instead of CXL.cache. The kernel enables BI on
> +  every port between a device and its root port, requires 256B Flit
> +  mode on the path, adopts paths firmware already enabled, and creates
> +  HDM-DB regions under CFMWS windows carrying the Back-Invalidate
> +  restriction for Type 3 and Type 2 devices alike.
> +
>  .. _background-commands:
>  
>  * **Background commands**: The CXL background command mechanism is
> -- 
> 2.39.5
> 
