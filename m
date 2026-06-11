Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F334252C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199675; cv=fail; b=LQ6hcuRyW7cEZHy4RPZGaB38MUwZlluShbJ/bzlfNz72QkQPHJzCcmX2nL5cj1kfoid89pQSZY5q/lCDAq+1/87icK7mowZMEQtkLPBEevVT2e3Efkz/7/aqawfRz8xF9tbbAryJecF6sB5q51/UcXZ7AS+qFqrts3UcYqNR9Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199675; c=relaxed/simple;
	bh=Ul1kAmbGIdrQ5KmcyICSG3vSJNbcA3iXksw9HhWyoS8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSoTu6Kclxgw5KpuhFr+qe13w9xGqOpaWupc59JaDhOPDe/mhahezXgDnRWYkkoj/PERgDP7zPkeMyU6vftuejQb1uJx+QZ7ZJTytjD76d+QKaKNpEKHf34HFKrSWtiWugsQ9ZNf0KFzva9W/6USPkHsyIpSTdv01E1kx56rOiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D17w6MGO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D17w6MGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199673; x=1812735673;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ul1kAmbGIdrQ5KmcyICSG3vSJNbcA3iXksw9HhWyoS8=;
  b=D17w6MGOjs5+k3wNMUFrFaKNTehl7Mr7uF/sQLcZnQ0x/fBAk6oWsd0/
   7Op6xYwwBFsYoXlz6WbmGh8iLtAl/4d0VDr2llInpiBcX5QWXpZwPbLLD
   X5eS+nIJ4OY+tg5CxW9BKqqN3IUP5e2sUoWlZ5XsUdU/GJf/F9q7qhj9Q
   t18WgwOdAS4qITM3iPiRPkqkj4+ulqx4jwynkXf3hq1oWCv3Y+m/Z3J5l
   8IXeibrqDOvJdYroHrgf00e6r5wILFL5GaIKUz96HoOomCztr0ulN5987
   CSMYu4HdQ7klba+Xm9vqCbOHIbCQ/isBLOMJi7de8zajCkPfjgjSgN4//
   w==;
X-CSE-ConnectionGUID: rVo+pk32Rs+vR2ETNODSFQ==
X-CSE-MsgGUID: UyKdWm29RtaG7mC76BQd8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82066380"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82066380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:41:13 -0700
X-CSE-ConnectionGUID: 5c91zNKiR+2kaBEQxP9/tg==
X-CSE-MsgGUID: rpOYPDH6TAKMcidl9IKQwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="250488853"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:41:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:41:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 10:41:12 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdA0U1/UBE58eAIebf7Ma3MCLdLlrOQ73OXWpSyoGQvP8eQsvWLYplO3kNwW33IMjoUDAoDzG+2v3qeORXN6K4M+pNIm3ULngdU9YqBKY4PPtYrVuJaUwO+uV8Ap2TQFIfpIoAgt31gQCRbnE4muCGySJsDVFL4H8aspRmMtaBVRqgCecR5Hz18thkdA0NtOf8mY4lSxWP82TXLBwSaMAERmTKtWkyUfP/yahBIGfj0+Ae72oUUfx9emCagJek9+fdMNt0AgEsXzOCytdJeoqi1qHxPhpnIFysgy9ixHsKo6d+ROsO/ym05b6G+2FC2Z1AngPM4cQ+hDSppG9gmWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5syWjC9/cxFq+ZmfnGdvKdT5u/QBKnsoFE0979nyhQw=;
 b=tG3ejziedow3ZacdmWuhU0mt1fBx32A1cm0UPdMnOBv2O5bTVgf3lW934mZdr5AQfuU7mh3KxSlRvvhAbw8ffqLChQJScpzhCH4QuJXOy7nKEoI07izqC7pd0Mmdebr2cnkYIXBSSkhQhF7vVV4IJVn7+FVzQ5xCuz5v1rzHyNcRGbDVc+vJU5XfjiT7zIYXaVWL+ymFoyBn8d8gJDzAftqoy0dbne6C048L5LwAUn2LlyVxvHcxe+zXKu4Jn7k3H3M8yislbuZ/uREkVUBHctNMylbTTYSGsnqVnb4+1Bob/SaZ6FLRbobPZtrRxywBu1DOo41XWLQOz2mrzqhQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9351.namprd11.prod.outlook.com (2603:10b6:208:57c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 17:41:04 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 17:41:04 +0000
Date: Thu, 11 Jun 2026 10:41:01 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/6] cxl/test: Add a topology to test mixed-granularity
 regions
Message-ID: <airzLU3EZdTb4Y-0@aschofie-mobl2.lan>
References: <2ab2466fafa96f07df65ee5f6b4f8511240f4c93.1780095671.git.alison.schofield@intel.com>
 <20260530051731.9A75D1F00898@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530051731.9A75D1F00898@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a39ce3a-5519-42cd-af4c-08dec7e09c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: u6542+A1JMe/KMArT807pgmtwRY/4oTMI+oqrxhGWcpzVCCD4U11CWQxiosJZC8lxeNAcGTIe6EPxbZjEYzVkS0VQlofz2+tyzDN3hvnvaQnSpww2fx8Hno9KsGxBaqGl1bUGmp+4biJ2NcWV/O0uhaA/KeWADFFet7EOeOVf9x0jbMX2WKS/rt6T1YIKfQoNsCYDoCEnz5qnD13DXeQn9sOaGTeVJsc/mEQ5rF/z2BbyBpp8PbvFX4j8vetqrEfj3sEXcObaDUg6+XwgUqkhaoUlup2DbdgOZXzlC960p0ea03ih+Jgf4lxMuwnsfrb3731i43Vv04NOPfvnlnLwAcRYE2BcYs1rA2pBA7tEmXEMikQ5jhC44xsg3BRjye7oOIoN24vZCGDJ9trPC9e8N8JYKbe7qPaFmn6xi11ve5mU5jrUFXGK8gbZT4DG05Qlz85SOXTdUZkMXKMz2QeCpvCvHeLR3SRvh3LeTTT16Qx5d76InepfzfUzM3xvw6NAAUcLJh5l/wJsTumnk9aTzcp10MF+fMhExJGt30JmREjG3NanE7659NduedDKTRqhOo1CGl8ySamGEy9v/CjnskkO74quNQ4PVAtzNJI03qTD2yLAR3ECfXDG+TLuUELQkSkiFo1FnPgmfIkWbo9/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pU4oLGY5Vy2KiNhSX8cqkNKlfzuTUB+cgSEWcK8eS7eE2h/LWtUPQwsPFS?=
 =?iso-8859-1?Q?C0K7el8hi1zU9pvfqM2AYKJlmBKU2EVrYbvOQ07/ji44bWjQTYj8/6qSP9?=
 =?iso-8859-1?Q?NL6vlM221AYR9ujP9nZcf+zOiRdD1HIpK/wxZP3ZCeWz9F8cxdT5rLSthG?=
 =?iso-8859-1?Q?NuoPTKS/B3IVV6dH/0zKgt4WFT/T9E4PxCJ9IqHD+k1VdhDwKFgUZb9z/i?=
 =?iso-8859-1?Q?A70UNJgUmyc/igjQeKvqkFwZJemPvFPRHn8v7jBAsFJGDHRvWDONA2zCrg?=
 =?iso-8859-1?Q?xV2DtkbnjJcTB6Q8p8SrjgoxAIiQ4P8NqbkTSHq1P47ZYBWWcKsrZH+euE?=
 =?iso-8859-1?Q?ot0CUIFKXLK60AsMbEWXCR4QHM7FthFj9xEAIsL0HDMx8Ym98YgnzXr9Wd?=
 =?iso-8859-1?Q?/MJLvdViQkY4ey76/FYbMX2+5AM1uPsMlIt2R/0J1pAUkHFvsuTibfStLD?=
 =?iso-8859-1?Q?jORmx+mtz7PRfUrJfUnWHe4BamdmrfAMHwtL9YqDUAT9LZDS5aWFtax704?=
 =?iso-8859-1?Q?Sy/KJdmGvSR1gYDgfrk8pfu1qoYCl18QhKOBV/8W4gWMEVsRb/deW18gzk?=
 =?iso-8859-1?Q?Ea9xR2O/VSOMAGXVitKdvlQCvwZ+JQTOBAD8dD7wNXVcq974jj2p8dAHIJ?=
 =?iso-8859-1?Q?HA/DlShNMWikmYUGqwDobT6k+JVWWWxZhfaZaDyc/ScxxzitYvP2Hh9+53?=
 =?iso-8859-1?Q?gEugpoJYhkmfKP81KOpnBSuElnoGVOH7Vv37tAk2SH45Syqr6Nvo8mHBBK?=
 =?iso-8859-1?Q?L7jkJ2wQVtc/HElL8Spb+5kFmVQ3XDRsGFPMJFYV/iRuxLF+lvkJSU+y93?=
 =?iso-8859-1?Q?vY0eYsWSJrQavg7KDSGMK+/GbH3eR6dbJnLvc7bzN2dqiJXo7jyDv8vbEx?=
 =?iso-8859-1?Q?/EYzBKjkBVB/l+RCLwYQ3b/gcVOzajLNODnQZ+2MX5lf8j9SIUrMQscKaF?=
 =?iso-8859-1?Q?SZzniuXSs/XpXQWyONLPAEF9gQZuZGhApsk9jx+4s2cNl6hABeTUe1znzB?=
 =?iso-8859-1?Q?JoZB6loaqBtHmDSnJ/aNkyd0CIhQHVIeRAGhRNVTAt/mLc/Y3rVD5HCpTA?=
 =?iso-8859-1?Q?JbPJe000fRfY/M9pbg60TXATa1fDpTC1edumUF36QoF0uynVMRvcvrrCjM?=
 =?iso-8859-1?Q?R1FukM4gBSVIw5BVK/ACY0hJcyZdDZq47+a3j9pZIe677Focce/iaTOByC?=
 =?iso-8859-1?Q?sW9sf1GLtvtCnBlB9lffXoUYAwkan3YCl0Vha3QEm2/TjnMOaU0W2FjmWd?=
 =?iso-8859-1?Q?+pOi0pIC1df1J5ndawKjsG4kP9HtMN8/c8vklKDSKOkNgpV6S7djsHc0+U?=
 =?iso-8859-1?Q?SfLLGKbVos5GS9NlRfJe2xpR948EdnLqxwlykHKELp1ad7ImXaWmxqhAvq?=
 =?iso-8859-1?Q?bvKjfrCrD0Aw5tl1Z1Gr4crcqsgyJCM948Bf0DRFRPFV3Izmq5nj5IlRgf?=
 =?iso-8859-1?Q?PXksJBPIVAkFYNO9hsT1h9AaND98422d+PynXaYmqBIGtXLAaEnOdU6yC3?=
 =?iso-8859-1?Q?Qi+ASgf4I1lPr4PoN9if9OhxxGM0+FJE0maKAp7VFXqtqisbtTILl8bSeM?=
 =?iso-8859-1?Q?46ILLsgIggdNYX2+T8LmTnq48d457fNRIu30q8Du26Ucq7VjKdyxlA5YiA?=
 =?iso-8859-1?Q?DeQofkazw5V1iS6xUouZvUIIhltqw3Uk5W70NfZRWo03ZasyspJQbuCZM3?=
 =?iso-8859-1?Q?1Y6RogB2I3ADrnLSazunMOoi8TGHbKU0W/IFuPUgDkMPyQxVS/1eKqlj/B?=
 =?iso-8859-1?Q?V+8T6VMaWmQQbxJ9LE44pDgg+KE1X2GQHmKgT7w9SLytx9Wvr7WHg96S8R?=
 =?iso-8859-1?Q?/HbTIbt7VB0Zoz55Zs43xu9qLU3B630=3D?=
X-Exchange-RoutingPolicyChecked: Hs7BtG312Ff2zKuYXVe+pMJLhoz2nrcTWm8Ga4VNZgQLIThFmR0xrjU2v7fDyVZ5iCq6xs49VnrA2RUpIJ4kRTBI0bD+veUDgPOhpWHwCNDNi3FzWw93W/YvobwsQ3W7mS4M7q/G5/CaeaxwigXvoSnZeIyc5fRBSVUqk+PilYq0I3GDRfxs1aXReCJou46l0dGsf9HjuIxQmC4d7K53Eh+T1cru/3BZofK+JJsqSCQ/rDD/Of5cRvFHFo4T/gfGFO3R7KjQ+0NKu3bxj6iDKJDp8e3hI3mEAEnm9kpZNR/x/K5sE8Aei9zbom7BfwvlTc4TWrZr3dC7XwjNgccylw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a39ce3a-5519-42cd-af4c-08dec7e09c70
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:41:04.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtZUo2wEcJw+d+/9VkjakxmPTx7qYBiI9tbxuIfcFcW/uxWISN/hTKyAFe79cVvRJY/YMuSrU50IcFxnE5q/nBF2dgRsLeDkPdeM28MmspI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9351
X-OriginatorOrg: intel.com

On Sat, May 30, 2026 at 05:17:31AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Evaluating `&array[i]->dev` on uninitialized legacy topology arrays causes Undefined Behavior when `mixed_gran_regions=1`.

This will appear fixed in v2.
- Patch 5: Add NULL checks on unused mock arrays (Sashiko)


> --
> 
> commit 8ff651f212fbb657c03e4fc54d032f721af040e6
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/test: Add a topology to test mixed-granularity regions
> 
> This commit adds a cxl_test topology for mixed-granularity region coverage.
> Setting the module parameter mixed_gran_regions=1 creates three host bridges
> with two switch levels below each bridge and twelve endpoints total.
> 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb00..b44db749873f3 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> 
> [ ... ]
> 
> > @@ -130,6 +172,9 @@ static bool is_mock_dev(struct device *dev)
> >  	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++)
> >  		if (dev == &cxl_rcd[i]->dev)
> >  			return true;
> 
> [Severity: Medium]
> When mixed_gran_regions is enabled, cxl_test_init() skips initializing the
> legacy topology arrays by jumping to the topo_done label. Could evaluating
> &cxl_rcd[i]->dev (and similar legacy arrays like cxl_mem, cxl_host_bridge)
> cause undefined behavior here since those arrays are now left filled with
> NULL pointers?
> 
> > +	for (i = 0; i < ARRAY_SIZE(cxl_mem_mix_gran); i++)
> > +		if (cxl_mem_mix_gran[i] && dev == &cxl_mem_mix_gran[i]->dev)
> > +			return true;
> 
> The new arrays correctly check for NULL before evaluating the dev pointer
> offset, but the legacy array loops preceding it in is_mock_dev(),
> is_mock_bridge(), and is_mock_port() do not. This also affects functions
> like mock_init_hdm_decoder() which unconditionally checks against
> &cxl_host_bridge[0]->dev.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1780095671.git.alison.schofield@intel.com?part=5
