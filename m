Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72A2931DD
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888679; cv=fail; b=YXtBKOzawfWMpWI/qhJAO0xxrshoMAliSuyNg2PmO1waLegElxvw6C76Sj666TaCt1PrAHqkoAWl82TfeMb8hXj4asMLWO4tscSINXLvk2zkSn/YfaQGBqqmpy8Mz3odkJhBtMGIH9KYpKOuGZUlHbFTlwprobQBhcuPi+BsE3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888679; c=relaxed/simple;
	bh=NTLxzTzL3IqzwWvwdkH8blAxs7jOaTXEeII/c4Cwx0c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJ1/R7s7rGRI5OQhTiOlXbV23Kw8sfP6+H9uqy15eLR9fZP1AIuTEsKUa1mOTbX0SCnJhlEh6NjI3tQWx8qC9oboZ6vyVG/Hc9CblMoPjKm6vn+ergTzkBKb4rtM/ctuaG6xJQSqD9egfC8uA1w3bjflb1mMzvQfH7HJwIp04yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBsOl6aE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBsOl6aE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785888678; x=1817424678;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NTLxzTzL3IqzwWvwdkH8blAxs7jOaTXEeII/c4Cwx0c=;
  b=PBsOl6aEX7252f1rzELfd8ZLY9JI/qje2pM1Im+/PQ78bwSDi7t4mCnO
   7uwxoTPxZvOT5iIu/AmhN4dtIaFtfFM562NHPIG/juPhLCifIs/c7ySdr
   TEjeuyPttOl709gQoeF/92qG+y+pyyNeSSfDDpYUyliT01k6NUD86XOXN
   ec6vozca4C5K9FUttRhL//9ko3hwtZP5zIQuF4mSKlYnEkRmQe/o3gYKV
   6eQNjpT3a+V895RHh2fyIp8ihUD1GG2vDOqFPrZrFJNbCQMqjVgfzCPun
   2QPphffE4FQZOMUvOpl7GJJPZ+tA96qfcAUXZPuT53KfqB5pwSDdFWBZf
   w==;
X-CSE-ConnectionGUID: PPkeGnqXRgCtD7lZ0hwRzQ==
X-CSE-MsgGUID: aFROO5B4T6e3LIYZ6u+T8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="109242518"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="109242518"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:11:17 -0700
X-CSE-ConnectionGUID: VKqelntUREatVIH/+Cihhg==
X-CSE-MsgGUID: 4jyaYosVQKuTSqrxvE6pIA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 17:11:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 17:11:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 17:11:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 17:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNc8ucxD8GDfQdHqG17tsYxcwlado9ZbLad+gU9lZrev/yoSYeYPulw5KZoEG3hnNUfg0NV/qI5zesAVPGcmDfAEsBG0JdM38QzvKJ/BF1OBn81tZOCPnU5Xi09u/gfgCiwUQvmFTZMa3o2Sx7t0QMZJy5q/qMOmPoUFc1pqdf+eX/M7IKb42p8kNFcAiIxBL8Wb1ct8bUiXyClAsF6mUHUhgoKlrf7EpwwX7fTJ9vnodGB4qN/0UMlsaX/CWxd6QQScLvvziyTPcaDe4ccL3MkR6iC8186jFBOAB1Qo1d0+goObquaekhVuZiAzrMRKzKyqGR5BoDfU4R3oiZ8Dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lQhlcIRFuDhJb4NtuJxNY6kSeBkpqQ/QnI/1pNJToQ=;
 b=l3J2rB7K8qTR6Cep4b5reR+TY0Nc3xZsuVpsfAIby0lKC9vbR/Cr4Ce0DusHQbdjdL8AeCpe4TonanlHuMSTJ0G85aLeut42XrDN/YI3gFRJ8MMrlmpaz3OCQhTkvCvpw8U84CZPOMpraT19h0QKQWnJTGrh9Jn/xvUqD3X0RC8QMp/tBexzIdUqCT6iFUuD6n1t1VpHG4TMKnPuVNJW/JS7pSZMEdPWO4/A+JGX0IN+lyvqWoVrEA7uJdFP4T8pN0Hg5yYDtx2Lxk5zhhG03/T3wfeAq4uVLDih6J8Oye0wnvF5umAZpJ6bP2Rz3yiaQ+LgeLQ3Q1iO0OySefcOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7909.namprd11.prod.outlook.com (2603:10b6:208:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 00:11:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 00:11:11 +0000
Date: Tue, 4 Aug 2026 17:11:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<benjamin.cheatham@amd.com>, <alucerop@amd.com>, <dongjoo.seo1@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7 4/8] cxl: Add HDM-DB region creation
Message-ID: <anJ_lwQfXvGaoLxJ@aschofie-mobl2.lan>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-5-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-5-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be428c0-4e61-4ad0-7ef5-08def2860e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: fpk+LyMm6CxOKvkAH3+Yqtr61RBpt/BmJkMaAGSKGW9o2Ess9RIzugaUFULUBiRmoxBa8fzOdDgLjsxxDCNJTUnHkPYo+4adX4wsC4JbyT1HMw10ZNbf+hM3i5b7niO/T7qilY3JO3kk77iVMt/4mw2y0L0zGAQam/tbE0/kR7/74vPbJFbK0kV7NvmcdcGaqHx2mTj6srirfBj7aXgUx3O6CdUfGoZUu4fYr70nKJQBlLaV5nearbWcfY6++GCXLsFtckH0D5LguMx4vACj1sF7GsYzD6E8LWmOzDieJy8bdgy8Pe2dzXaMcmAYv57g0kxgVx6s/AsBild38VLWfxbLUqArmmkVMlQcgX2VBSzOEDfolIxoHHsyVnQ6bbmu42X60q4zDUTbkqStxewQzJw5SFPWwYbK1HeqZbzNBN7wEuhzc230YQhJP1+lc+2d+wQ2mOosgPMynl43a0lvcSRKtRIndeE0/LFBEXcM8Hi4btBXYLp9EtfGnSNu2A8q+RnifAWBhfBLl2vMgfZiFUiqC8Oq8oNh8K3nIeCl++ONa8kLAx2/vCHIpH4WWtXRT5omp2QvDZz6tHYFDzjhenWfoBBJw9Il2Zx0n4fhkycSlbU1n4MisKJz89L5z7GQth2JM9SzeprTObIyF6308qlcy04xXDOtLQ6HzHgKG7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voblFZE4jyfgxxu/kwX6IrLJJnrg2K1enJ/HSWdfYy4vdbfyz2smrqkg3eEE?=
 =?us-ascii?Q?d21KLyMTzclywE6iLeE7XgV6B8rmd34FjOqDCEmY+xJTip8NgasjFmkXihbE?=
 =?us-ascii?Q?qYlCdt1Yp8Wx6wIV+IRaIXOdZPWT4AVPZYaSa2wEy7NjYcrSr6WTanGUL46m?=
 =?us-ascii?Q?p2wZnuyijS40Upg/FjnHHxOqGNB5GbJX8y24ACtO+e5wvzjdoX1guf5v5dx3?=
 =?us-ascii?Q?riCC30D3xJ5xN5MgaoaYTzRNK4MD75N+Wqepe705WylyBkRnPpUBGamKDXaP?=
 =?us-ascii?Q?BhtEd+SVHoiIa83c8DVu+KKgGML+NagvyJeZtBec2VDqwXPdm9QAwM0PmYTD?=
 =?us-ascii?Q?gC2MO66taGAzfTGWOqGjI1ax0lFCf6XAQEtr1NovHFrzqkBbdIuQhCFgm0CP?=
 =?us-ascii?Q?qeARSri4HMERn2Y4dnL9HhoFR6w9awY7kRt0WKnTx4yzazq9nQmyN4EGn4ag?=
 =?us-ascii?Q?yjWD65b+RDibbEbgdFtx2dxnc2ILmgVk7tCl8Q2sDOHhkuqYV8R2fWwjv1De?=
 =?us-ascii?Q?lN9olWmz75zTTjl4NC4JHE4mwcfUzrTh7dhBZJNUiAP0k3cJxQ8rPIkc058F?=
 =?us-ascii?Q?gY9kG5uP1yxx15UKB2FamWGjUrJxRqcasWXFaEO07mr7DZCiFEivZyrjJX9+?=
 =?us-ascii?Q?n1Auodq0nuEQolyVkuN66/ANeJU3GwK56PmZpqjiMbjhv9sK4rUoTSoqjF17?=
 =?us-ascii?Q?UbtrhWMEggWio12pud/zhyi7Nr5ZwXuNIY6cyIGbSJOlSteoPTIOqIYTiZVZ?=
 =?us-ascii?Q?KusIoof314qFYpPUQJuN6oyzNR2Bnwn8sXnz24uqGLBt5vkNkT+W4fk+HIkW?=
 =?us-ascii?Q?HnYO5hyUyxitS+4qjNLN7RovuTKtDJ4HhEL9dweCTTDURToBq9rHiff8kR2S?=
 =?us-ascii?Q?+KH/itArb9kc6ypEV4BN72Aovcc6dlVULe0FLaFAbjcJb6sNCULIR5MtVCBI?=
 =?us-ascii?Q?QwVCulh2jcIvSU3RnsZdkFQi8rbQ0QlDBeTXLuezB5Vaam2HpNanNiXMk/5z?=
 =?us-ascii?Q?9wraEB9bcNkrGJult6pJiz+MjIr7YZpJb5n9YAMQbgQW7Czqy+gu/oHFnr3B?=
 =?us-ascii?Q?N2fGr9IwLcPBtPvQq2KAHrYo6hrEEDqzHRQ+kEVB2aQlUvEJkT7DSRP01TX1?=
 =?us-ascii?Q?aGkh5S/aaXezUrnlJm8Uba1MS2LaJ7Z+7xlL3xSU0D4DHYUfxmMEO47mjRPO?=
 =?us-ascii?Q?E9loPTJYTvpDczqjMJ0gmupxOxbThNh2/HtO9N/jeywMtp2b8oA8SoqaAE8a?=
 =?us-ascii?Q?r/p4oaH85e+mllqVaHu13wgja7/5c0E+GDR4QjqDd6mjY8ZsCK2b5MQ5hPpm?=
 =?us-ascii?Q?JuewN8Yin9w/g/+/O04EiapE+hmJFQOcRMADBwAina4t9xSVeEFWUb9hfTJR?=
 =?us-ascii?Q?MoJzMIqv4SN95MynPfviug3FilEjlz9pV5xy9qL++h/UFyp6Jpr04AhnZwlY?=
 =?us-ascii?Q?svz17UsKc4ylSJxmz9O8KK6bxzxXTsO0ZO2m/O1Libf8DaagzkTmCHLXqRs+?=
 =?us-ascii?Q?2/MWG3omoKe+k+y7Y6e51UlnQfo83Ll8HjnOfG2swCV4PvAkJPSxFgA+b80l?=
 =?us-ascii?Q?/CT2ETmSzeFt+nuo5fSKtvZnegNFJ8M/uNrq8/o99FO4PrN8hdIzg08V0jcP?=
 =?us-ascii?Q?NJTINV6thZ2Btwe2u2CjdYPhcJLtAFaLyoOhwMainnXzK1W6JMIXVLP/TW5r?=
 =?us-ascii?Q?dOaUnYMi3X29hWETeVIEB522eMXBV927buC+VHYbb0fvgTfPuLfV9uf4beER?=
 =?us-ascii?Q?R/4gJG9Sd4a46WsEhw6sTcDafHRBjaE=3D?=
X-Exchange-RoutingPolicyChecked: ebiO/Y8nKwzwmpo5PTpIxbx8F9ZD8wL6u95bMeX7lo5TCtyC4gphv5CCzNai0LcGBzbXebV29f1yRxktJsuH5ObCkPiqErNRMx+2P9vgKzbaps2Ir212X4nhCrpYSdEZK0YreB5Bo5Q2MSvX2BvLL2teveqfc61jyW3/q7Tj7O+gu6T2UNSNpN8pnvb6V1lS1mQ2lnq8lC8F0HnC2uNcqXLcyqsc/JqVJKOZDI3FDbJgsjh/lWI5/DLOR05KRy/ukH4IWWYX70ZFm1eWFjagO7n63ez3B/rUySuV9/qhI6U0xHa2EOGBysBuwM95ecdlFONunt668pgy+DMuSStRGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be428c0-4e61-4ad0-7ef5-08def2860e7b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:11:11.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XS6d/AL84o1o1LSnT4VKivX/y+6IrtSYSOXdMqwZhZ4gIYXrr44xH42ev0Q8SsQbtW2yM15wdnRV7fFbehqx8XTXBasAtaYfmm3K1T61Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7909
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 07:41:32AM -0700, Davidlohr Bueso wrote:
> A region inherits its coherency from the chosen root decoder: HDM-DB
> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
> 
> Surface the topology through read-only sysfs:
> 
>   - decoderX.Y/cap_bi (root): CFMWS BI restriction.
>   - decoderX.Y/bi (endpoint): '1' when configured for HDM-DB.

Hi Davidlohr,

$ grep What Documentation/ABI/testing/sysfs-bus-cxl
shows that we have a precedent for spelling things out in the
sysfs attribute names. Even long things like interleave_granularity
and extended_linear_cache_size. Suggest doing same for these.

one bit below..


> @@ -2108,10 +2106,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);

The new checks below seem to ignore CXL_HDM_DECODER_COHERENCY_UNKNOWN.
Does the existing type check need to stay for UNKNOWNS?


> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
> +		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;
>  	}

snip to end
