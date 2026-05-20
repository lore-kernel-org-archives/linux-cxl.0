Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44E2EBBA4;
	Wed, 20 May 2026 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243885; cv=fail; b=rJxm40G1UAP2vD2ElpPD6PN2WN+pRtjlh27c/TCTcLpeu5/8WCF0Jyta9/tiVieHCx8VKtxs7jzJpzV+D4RKLNfVUGX0+RCzZNGOwFJSQZttYaiL/r/McJeDcSl7KZxMz13Je8s2KxipYxhQLNTInf5xs0xesSYt8E+zxY2pFtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243885; c=relaxed/simple;
	bh=DZF4P15TGhfWwzbitnYAaqtkHLnFaaeq2ERIg4uwPAc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSQCpS9Z4CdVZ0XbgosIzCHiOKLF0fssC/FzVOd0TdGxs7H55JYYYEXCM1QWc4w+cdElWleBG+do77jKTvVdmfqjC7kNdBrEsmpFu92o4q6F/27QPagNKsvRXttZooJu7hnCV2qRihO0fAPEmLR998DELuezOl9E0L3+bda6F/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIuvtBAH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIuvtBAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779243883; x=1810779883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DZF4P15TGhfWwzbitnYAaqtkHLnFaaeq2ERIg4uwPAc=;
  b=oIuvtBAH8y2Ze3D9MqoKPRrmdt906NPFfHes3ogm/KurSr/J8xXp/nwB
   kDG+nqDvCiDOLi5VW4s2Lm9bsweIwRTuPe4+pCdjETS58ckiR/B3xCJNm
   BwdV3xwxSYBkaD2+GtfuvX0x/FLKGbTNenVksiyF+1e7B+pQ5wj9yKbcV
   24sV5LWFOil/hq5Us0WcM/O7qL3U1rVxmlnNlaRSr9KuofazkSWxv00Fw
   j1yNZFyePhGpsfjzH0mv26dH+tfYeyH/vhn/nY19Pk180f6gtzfWD/OPp
   niZ0LiM1nyEMhEX3se6v7cphzcwi2M9ngj2JWlDkcRaNbdLD/TPLsy7cH
   A==;
X-CSE-ConnectionGUID: 5Kk8utqnR7uOAwqSO7Kmig==
X-CSE-MsgGUID: 4aevXw28QQGTKa8AUPF1Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="67659868"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67659868"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:24:42 -0700
X-CSE-ConnectionGUID: SxEd8f6GRXOiaaHrOoPpYA==
X-CSE-MsgGUID: FSWH3+4dSyqbo+ws+9BkXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="270331769"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:24:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:24:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 19:24:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:24:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqe2ff+kQFdPXlAv1dtXCBaVyQ1GX9fuZyvnvhJw9tvwV/i8To7eShVsrguQN5yvipVSPFZtxwBJQ1tzb1TeEZlArd2JA06pUfBM8duD8Zmrdt76Z+y+YLxtaOmZnoUn5C7VdsFKEI3K/dhjrTT2D8KciKO1BfZznp/s5iw5yBx3sHb60Iaj+8aLC+Gv9hDoCDdQNdhNFb7I6trspWDkiQaR3EhDR+/SynzD1B3ph3FPN8cW/YDzkvnkB77zLgJOuPTSqzoEoQFGZ3RDzyBwNxaOiuxK4P/Mm9dnWjzNEOJUbtuu5NrX3KN4Ml2o0Fq7LN36PSMcYhmsAaFxh2EUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ve31COyVOK35W8QnFdfq6JtQBIokzU36xeqeJ0L9aU=;
 b=UVTJFNai39Xd576VxnVp4gxsIkEytu/WbBduw9XiNVI1fnhgICcDuo/R9Pdc4wk4uOZhWb10kWSJ+VGDB7HazUhR+8exzypLMzCgeqZbwfzPIfNtez8cPErWSRRmTiWGTeouAbals6GfcjcrDM57IC9y3Z03/m0EV51iqBOGHK/5LrEOF/LERQWGhorn9And4nde90yErn5hNIF3pGLDI3MZ6lcGbDbKDSV97tFYmS3Z9TEZKdXWHDX1IZ0oGOu3vohU9XOwahaxfnv15mCUL5gvtGaqlxhXUim+y1mt2xPa565/I2x/ZNo5ghgMoTy4zDyW4tJYbZcbvFVp9WD6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9160.namprd11.prod.outlook.com (2603:10b6:208:57a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:24:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Wed, 20 May 2026
 02:24:37 +0000
Date: Tue, 19 May 2026 19:24:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: Update mock memdev array before calling
 platform_device_add()
Message-ID: <ag0bYbNd0_t6CzpY@aschofie-mobl2.lan>
References: <20260306-update_array_before_adding_mock_memdev-v1-1-a1a6af0952f1@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306-update_array_before_adding_mock_memdev-v1-1-a1a6af0952f1@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: c79a7458-4c89-47c0-8827-08deb616f05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jJV6o0q43COjgZOpm85S+9oKLHzwcQOBZHI2VcTVGaO/1Cao9EUwG98SSNjY5O9ZbgiRgQM6OwYL22spQXLJowprCXFckwI4i0L40PIinlGmcD2d5Mkfu3KK/TPEqZ3jphU4NSn+sxU677TmGc0RhsIn+27AShVYWJ+em56iErNS0uceuodtu+bBP2SX/6zaHoXb6BgmneLq9oDcsu50xM+apcYG3P/voBkbtlIK83AYPeifthHI5Wj7OXcarDhQdyY3q+FHQhEbOhGDBCrn9qc+PcePF5Dk6PE8/U7rfHoIvmhtVcLBonPk49MZR43BHwO7tzxwh50X5SotkyAiY8gHu75nd+UtDFtGaPazQJqq0lMEelrJU5Uu5a/Bzzzd1VVH34i0Chj+rRS7AwJHeLDy0NoBKGnHSnWx51pnWgYO38P8lrKDsqMcYaI3lhvDGkdBebFDQiA10jd43a4ZByRgAdfCQBMWjkzfoukN9uS338Cw6vKri9TRDVp5Glr9qjGTJ6E7oxWtzdgsChSJ0wAhhVfmdZ6MVfotEzy5X9a3cKjY2sKQ9XWBTzG/WkN9VFVL2+VCiNASlRVPj41bnvk78Gsn9lSrBdIKTa4zn5eCcpd6BGmV5K0kcEZtZ+xJtc8GZcZupffBSH96bk9RJWt+NDuDU6qPJejzm2JwdmGF5FwEBvx7ge2LNBOcnplQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+dNcP7gc/xIAeAkOlnY4Vekbc9btipmJJ9SnYuVekNVQZyK+5B0lvtKQh2L?=
 =?us-ascii?Q?vCNj+Rt69mmFOrKHqdEMHiXc6da+MEQRB7VY+NtynuOgYnWNJ7DBQ1RxrQAy?=
 =?us-ascii?Q?TtaUedr+CB17uBdLdISD1ETlIEN8oQNxWY85vwaJrewoAM21fgO2JUu9UN+l?=
 =?us-ascii?Q?eqVYhpVlhURK+sVAMNJWQ83xq30An2gcDLskNJ0D1ryzjjYzL9hPARVeO4vC?=
 =?us-ascii?Q?xJo5fSI7Tm+D8tW1FEmOZxRWJZZdnO4mEhSRm55AKNPEB4guNu9eG5te3JAt?=
 =?us-ascii?Q?CrJ2y8CxIEobGSSj8rRyjKAjKsVBN8BnssN6dNmV9oMibf+XHbVw61yw9tZ3?=
 =?us-ascii?Q?OzhsdbLZo65MA3K2Vw++m4AcTgo43ZG5piHHPECw8qJoCjP89NbMYmn97gf9?=
 =?us-ascii?Q?0tL+SReX6yFwPoad87QYHZ6P64roEw/evshUaGlK5bc/z8OrGgIBknrYqLkp?=
 =?us-ascii?Q?HnAzIOaqdoEMQVgb4qbuDeySOketwEorUDuj9F/43EYtdZEQao6jNVzg1+oR?=
 =?us-ascii?Q?E83DftYrncEoXkg5F1oFCcJl+2k6Qq2iqLtt0kghYycMPv7Ks82ElR3xpygQ?=
 =?us-ascii?Q?ADO/XZXWlfED3RhWoiyhmhmd+iT3RvHo1ETQOmkqzCCjfpAHV+It2RPWU4sm?=
 =?us-ascii?Q?2oE9WN9frTrKQTha0AxQs6kJxggq2aRNuzwTkVR9RAPaHGGipTvrzQPKpou4?=
 =?us-ascii?Q?zV6AlVF0iYkW3ZDZGcv9xbaznMWl5sxhRfQaA07XG/zR6DluA/F8FgFOqPVL?=
 =?us-ascii?Q?Uvl1mUlFVyCe+k5AN5hn9LxQJNwdabsisLsMdiiugHBa4NmLGm/DR7HcJ3/J?=
 =?us-ascii?Q?7imo9Jaq4RoSFSjtFCbABbGwNEPyrxWnSzqXLeY/JP4QtRW4lKQoo7r17/4Q?=
 =?us-ascii?Q?T0+sBEltUfgYFE4kqMWrxul9w/epKtKry/Kn9vAkaRkSU0kv78BKzAuVq6ba?=
 =?us-ascii?Q?dlb3BqV8ypPu8HxJI9cppUvftR92JxFHg1toSEMyB63vp8ODkYblbPziGRej?=
 =?us-ascii?Q?JtspQWxJqTl+aDdafSpMvoHAyzrmiU64dUWbmFufqDwL+D+dEMj0N8Vp8iQr?=
 =?us-ascii?Q?IWhngWAAmjshOX3suVTY7jpWxWRpSJSkrB7PvvDUqlVFMe1gV/IJ+bgYHlm8?=
 =?us-ascii?Q?MgPZWyv4p1uf39dkDiWUkzJh5yTwqo0nTGGKt8jsTtPVerWHDc3pK4CJfRJj?=
 =?us-ascii?Q?kUN6EdSrIwmUxTisnQFV3eUsc+7ba+D0kLLzexLnW66pCsI2V9s1612i4VKg?=
 =?us-ascii?Q?Obma9DY1o2svDRXtzxkPLyfT+aiobkrmOu6l3khOyVd3npDHu5dJd2aUo1jr?=
 =?us-ascii?Q?ZtRyEVcsUpcWrWkcaFVHXGG3fVshll1v1ydnNBeUvMjBl9Z3EM3i+bTQTarL?=
 =?us-ascii?Q?lWaofH//mi1qe9Y6F04vaNLa7naptQf1tgHGTd2KSXIfA9X3XULvntQW/LdA?=
 =?us-ascii?Q?e6zAhheL3It5gBcD2MUiZ78UU6X3YHDQttX3MboTH7AKE78UHELWS9I521c+?=
 =?us-ascii?Q?slwO2zMCOco4dcxSceUkXSb31gjJ6DH4CivBcbkLkei86mmPMhzqhQW0vCZE?=
 =?us-ascii?Q?tqFAG+q9oY+KKfk+2Xj1wikgpSL3pTsD9JlxuiI225qGn3y1MRWw9znXb6tD?=
 =?us-ascii?Q?QCzSZ07oZ8OFpQiukn2FYPRRXJyLhzmEAKRp/phCRa7+Xj9c/MTQ420hev1Y?=
 =?us-ascii?Q?B9RXBGPe0BtDqzNQ8sTJ8m+JwPXn+Bv6Stk9TavtkEIf30Nl6y0iXSPYavOJ?=
 =?us-ascii?Q?iK5RZ1YVNh+jB8iLMBnjs5NEvqbm74Q=3D?=
X-Exchange-RoutingPolicyChecked: p6j8Me+v0C3qXjZg29nhRT6tcefCQp86L4tIUuu2kLFKhJ9CVG8vxa1wkM8dE9/gvD2Jb2UNWSWJw8AXaZjFIQkKBXmVogA2Vd5WHvZj9SCvKpdtg6ObKyZGsQre09cqJGqkgnGXm+lh/pqflaJ9TJJSjg2U6a1kJ4PJfneSoU2oLi4ZGSQGkkCLiiBDzryaVai5wItAJ/ww5ubbLmLcMDhqAIrnC/C9LJXFmUp+o21KFLTbAXN5Yvn6S2bBjftn1bu+MpW7PhXoj0z8cvZgeRlbz0G1Das03LBeWvQsy4uHkZEhMwTfu2xcwpWK07fsWBt4mESelCpeZypnGLfpzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c79a7458-4c89-47c0-8827-08deb616f05c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:24:37.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHindIfWGmrsULYnbCOmKXuDD0I/TqKbqzWEMHtkODrKH8V2reCS/Qw+UZNT4hpKSrEHdBZJJGI6iUMsQ5rFuXGbtBn1L2v6swo0ii+7g1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9160
X-OriginatorOrg: intel.com

On Fri, Mar 06, 2026 at 10:28:19PM +0800, Li Ming wrote:
> CXL test environment hits the following error sometimes.
> 
>  cxl_mem mem9: endpoint7 failed probe
> 
> All mock memdevs are platform firmware devices added by cxl_test module,
> and cxl_test module also provides a platform device driver for them to
> create a memdev device to CXL subsystem. cxl_test module uses
> cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
> CXL drivers calls registered mock functions for a mock memdev by
> checking if a given memdev is in these arrays.
> 
> When cxl_test module adds these mock memdevs, it always calls
> platform_device_add() before adding them to a suitable mock memdev
> array. However, there is a small window where CXL drivers calls mock
> function for a added memdev before it added to a mock memdev array. In
> above case, cxl endpoint driver considers a added memdev was not a mock
> memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
> than mock_endpoint_decoders_setup().
> 
> An appropriate solution is that adding a new mock memdev to a mock
> memdev array before calling platform_device_add() for it. It can
> guarantee the new mock memdev is visible to CXL subsystem.

Hi Ming,

Thanks, I was able to reproduce this as well while testing a new
configuration with 12 memdevs, and your fix resolved it, so...

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>

However, since this is a low frequency nuisance now, and given
that it now touches all three mock memdev arrays, and I am
heading towards adding a fourth (which is how I hit this), it would
be nice to tidy this code up before fixing. Refactor the repeated
platform_device_alloc()/platform_device_add() pattern into a helper.
That would let the ordering rule live in one place rather than 3 or 4.

-- Alison


> 
> Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative to real-world systems")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  tools/testing/cxl/test/cxl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 81e2aef3627a..2664c9de8dd6 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1356,12 +1356,13 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> +		cxl_mem[i] = pdev;
>  		rc = platform_device_add(pdev);
>  		if (rc) {
>  			platform_device_put(pdev);
> +			cxl_mem[i] = NULL;
>  			goto err_mem;
>  		}
> -		cxl_mem[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
> @@ -1374,12 +1375,13 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &dport->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> +		cxl_mem_single[i] = pdev;
>  		rc = platform_device_add(pdev);
>  		if (rc) {
>  			platform_device_put(pdev);
> +			cxl_mem_single[i] = NULL;
>  			goto err_single;
>  		}
> -		cxl_mem_single[i] = pdev;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
> @@ -1393,12 +1395,13 @@ static int cxl_mem_init(void)
>  		pdev->dev.parent = &rch->dev;
>  		set_dev_node(&pdev->dev, i % 2);
>  
> +		cxl_rcd[i] = pdev;
>  		rc = platform_device_add(pdev);
>  		if (rc) {
>  			platform_device_put(pdev);
> +			cxl_rcd[i] = NULL;
>  			goto err_rcd;
>  		}
> -		cxl_rcd[i] = pdev;
>  	}
>  
>  	return 0;
> 
> ---
> base-commit: 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4
> change-id: 20260306-update_array_before_adding_mock_memdev-89673b4d9118
> 
> Best regards,
> -- 
> Li Ming <ming.li@zohomail.com>
> 
