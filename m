Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19919395ACD
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578566; cv=fail; b=d3BL+SjLIRvwAyQ4FaS6Q3PqncyaJECJtXjV7zZShEBu23DJsghwJEZeWswWBoZ61I1gzWru8y977kz44dB1MH4xSjmgULZPs5hOlpuIaLnbDXDjiEVduKkYunJfR4vzPUv38Vdb8shd1Y5h8K2ZJ21nqMSAnYA76VpUrb0YR1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578566; c=relaxed/simple;
	bh=jrYTPb7Aw6E1Iwpw2feEfXWaieGpBRgDO6/mXx9L8NQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F09Lsc0KbU0UvA6cP/ugh0DolGp1TMAUQGV3G923AC1WXOJF6zs/YkkKXb1fkUFiQK5box3A2+xI6ci0tRh+ZrQQ16/VCp9jjReaw2u9r/QIISt+74vs/W5QuX2T8VvyCoaEqrdM9SD1BqeABa9MnRvhv59mJEV/IgkyZ/jYQBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrMlBY7k; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrMlBY7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791578564; x=1823114564;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jrYTPb7Aw6E1Iwpw2feEfXWaieGpBRgDO6/mXx9L8NQ=;
  b=QrMlBY7keTrkO15feOUbiyehqiAvnDfqqpI1JHsFz+Vd+QjVkSOSJDDo
   bALXr+V1/mZDT2xs93m890cYz2KCoxDMnPJYQZJ+bXeIl7QTUcFLuWqJa
   W70fTVZiDe6qm9tdjLyGBb7o0NKtcopVaqzdn1onISy3MWthF/DCbEm77
   CGMZ+ZpHR0oG3GCTCxqTjlQkGg53Hs74PFVqKKGutueJVPyII8tbqXdIH
   4pyYryiDUaTJydKVpYjb2zt16Q2PvgkJ48W2rR0/4GP3kWDsua19EV6h0
   0g7H08FU2Q4UiNoH7pM71aYPm5dKEqoBCF0ykiDeSjaBcTxuub+PcL0lX
   w==;
X-CSE-ConnectionGUID: 2eHU5k19Sz6O36VNLoqHnA==
X-CSE-MsgGUID: ulUgu7gzS/i1nxmEbezPQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="278217"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="278217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:42:43 -0700
X-CSE-ConnectionGUID: iJzHsmCNQsqDP2w8/vIpkg==
X-CSE-MsgGUID: gHJKcTZqRBy5fmiMF5aaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="849343"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:42:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 13:42:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 13:42:43 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 13:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg8wImdJMbsg+/IVbWsnZaxIbsNfPQxCWKOXXY3oo7ye05sPe0pCiehSrRWyUwzQK7lMKVaIeubx17evdhl4HOzoeV73fuwFmxxRqldNCFdTaRbsFBVohJw6aGeOBsDSyG6IjO9ix5Opy6f0WrVgDMNsOLHYt/NUu2vwXDYK3VOGGH/jgDxNxN+RyaNsYT+XF9G4tvTiY+kc2M84SCdI6qN1M2o2Kwym0Rtuga6DtAWX0JrRfVOzBQzFSkrR6/ygrNN+FessgfMyiidGr5SDEb+5y6O3d5Z07vvU25x5V2uP/nkig16JOl/oCqnqC+tE5Weuv0xmIKGo7UTpoHKpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZl0N5lUhY56K/UyWDkplga1mVm1mBlSOOuuRfknvNU=;
 b=lRlxlR1PQMp2TuemAFNRrsYHTREsoBMPP0xWoM1juAVHsF7NsDMDt0eTj8Ge7nUfpsmdDT74qnF1yWoYW9GpSbTMANFMyKfwOmjowwE4FfIyTXilvYe+qwRRCcwxbfM+x/Oeqjx9lPGHco73EEqDG8w1EiemDQ6addbdrv8DcO+ggVlq6es1NyHasWFlIObPAyGx+JsPIR8yG2AArd0zGZ8LfBZQ7ETDd+U0LaMU9+qe78eqvrtAzMGTz7/lo4mlpR7IhfkV2cBGQb9mzffMwZAjzTe4ZSAbUL/Z15iNntrRJ8cWZUWOvDfNu+3113kXxtiQv+LihG1oZxoeODeprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 9 Oct
 2026 20:42:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:42:40 +0000
Date: Fri, 9 Oct 2026 13:42:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <icheng@nvidia.com>
Subject: Re: [PATCH v4 0/3] cxl: dport fixes from sashiko reports
Message-ID: <aslRvDhS2s-UnZa3@aschofie-mobl2.lan>
References: <20261001154744.1095902-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261001154744.1095902-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ2P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc3eb10-21b8-4972-3340-08df2645dc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|260925021311599003|260925021911599003|260925022911599003|22082099003|10067099003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: /OoN9VU1W1zj+NUHXKKTwgFjkmiLLcTLEI010Rtw46anTJrskG10TuDbRZ3dNGMgmniMLbyePfKXW910K8y9BPw6bXBzbJsNb5oZ4Nn1m/hyqjk09/u30D81TuMwFO2e2mPoWJ2TxFTy4dCVwMlDdCEiPe4yf7oeg3psF6ulF8YRUZlEk/IBU9AfLg1lokzck0BDPqIAhXm7mp8ijCh+F8vsX6by38voOEFmI19rpxya8H9BV7ueAbGNFhJ/KqU4TjTZwxsBeBqVRoiJyKxpmqwC34oz0f3R3cUulag4RWMjRwKP2yZO38+GuCqLmzKN1Aqlm8pLZbHmOtLL6cXPFBS+deZDJsIt2Y+E9vqcNmWI8zswFISYEb4cHyEbUMTj8bmoCLpbnLk/jrrDP73l4I1CS/bNSbkOC0RZZpYILRITggCXVvLsmcu4QvYmNfbce7i8yejcKC0L2txMyDW+BX176+H//pn82jbdwnlXRyy8Cc9pXqGF16OUJ3nP9SuiqLHU5XbpASIH0GRXDOP7QRt390nUqHf3Iv0UYnWuvwfFXNOUJnkBgiwN8fmBW/gaORWWNnKzX4izL26/VJ/S/eueQJ2/lrdgwefb3CsKtijpDyrmhOMERH7zuEGUac6/GVEvlwUftRUYmpiKxjUEwJ7t+6jWk+K+g+nBZ93Z1PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(22082099003)(10067099003)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Xw9Kf7niZHBxagDlzltbshTRTm+OHzmjBS5HvGGNki9mgUg8LCIu/UBr0+7?=
 =?us-ascii?Q?M15aAu2y84TARqxM8eV68UCsJe8B8EDzoluu53CP/kdt4kYrLPcCpIiU5f90?=
 =?us-ascii?Q?FFjso+XmgTPAkVNL7suS4D4tnAMHtBK6MkAaEtmBtxYkcDImoUWBFR4g1zmw?=
 =?us-ascii?Q?t/BZNRrHDluZqLF5IWUJzhHJrNPQ6vt7FWLRI6pUKR5r/0Q94RAG9oeW6Lso?=
 =?us-ascii?Q?/8VJbjGNpOlxWGjHhVm/hyLlQiPaXW2pgAXJnY6AXW1qk8I8SuOWRQ6RVz8x?=
 =?us-ascii?Q?22Anvq+2iFtLBt4frw156011I/XXP3K+0pPgReHmmYQTqq1Bah8f24fdMv3p?=
 =?us-ascii?Q?uGZaqn9zL14Abyo7y7KWrwFrGn6L4pOc16hMXLa36INzN8mb9sstKD3DPOGL?=
 =?us-ascii?Q?5eRV88imKJISwW+FpgcpcDtdYhaFDSshJj0Ig3MShsqqqTiHQhqfC3qNK/Iv?=
 =?us-ascii?Q?NkXam9/20r1Bdtm4kGDnBDUJvhhIwloRO0EGccC7LJCxiBBxn2KyLGJ0htkX?=
 =?us-ascii?Q?XuXs1ojaS+1HLGbaAySspefUrXH2ByucwzIftaPOPcUa8lV6MBDeaPnnwALD?=
 =?us-ascii?Q?e4GaBNJTXKzd5Pq1Tn/TTf8ACdQvH2tIPHuRrsJskF2kdO9B70aQ9pf+6AIq?=
 =?us-ascii?Q?KdzdW0v1Gb3g6H5rwfyl5pPYgPeY4btnr8UlUQlZ6qC4q+C6wA6vRZJevANv?=
 =?us-ascii?Q?pTAeA2PLSPCfkJIrJkCybrNUO6bE7aB8/RZWXFKDhIvb62m6znaSRRGdZl4o?=
 =?us-ascii?Q?hH9dIyB3XduXeeaCizWp5m1HnyjHNpC+MzxhaS9VscrMXm0MV1sVG4msJM9d?=
 =?us-ascii?Q?+Vt81YYAmsCDqfpUTcaWnabsRYdT7wYU4asCLlU9feCAeR8EFXzl8Kg2T7SA?=
 =?us-ascii?Q?NrshfkBnD7270KQ37ghwslge9jkb7NV1BMV114FAAFeg0KHykQPFpDGuNQRX?=
 =?us-ascii?Q?v01AW60J2K6PZfcMDxMq/+2YTtb18bLrio2U5vPnKfnQQlZgjnyVtlCrnHA/?=
 =?us-ascii?Q?tnHErcxTSq/qQFi7x/mFf+5QsIZj0BuUYMRz/M9b1XD0gzZ6ya6zupYKQyHU?=
 =?us-ascii?Q?FBSJ6NU5ZXMzzJSktXBaK+1+n93bekn94Pjgn7/WyHAMnhyjJ5m8d5OcUZei?=
 =?us-ascii?Q?luQC1ykAoIV/L1m4GJE2fNA0vF809VmrhK4Oqda8Ap/c0DB1nV7HedI0FFnX?=
 =?us-ascii?Q?K+VUxI7CfrZmqFYQkPOLGJBI308c++ZZNjjkXJMmSkn/H3slp3B0ayWB0/iU?=
 =?us-ascii?Q?Kk7NIPLl6smHluTRXltG/jHaZfE4teUdpLMBBSgbFC/SNbYuHpIgOOAcBNp3?=
 =?us-ascii?Q?Ecp9mFJEE6tqeTAixBBX2qLKPWr/xVkRYfJ9h+aLI0QYzYACJI2eDkaigPlv?=
 =?us-ascii?Q?gPvcwR0rDbqiqUcVoErwtKTwsrSc8t2NvKoV/6IfCWIE3y7nh1m4WcZPmzqW?=
 =?us-ascii?Q?uDhez2sEXFfDbrqjvQMonDJB22hvC7OewI+8+nZoIiMe6jkeuybZGY6Ggm/5?=
 =?us-ascii?Q?m4a3RYTrmxpTvrEnPCh8LM3fpda3nvXaREfPQXlnylB9t9sizl7b2EaCa5iO?=
 =?us-ascii?Q?5pDDdCNeIlCFO71Vpqr4Fd9b/MW1V3mrJDjft7INra7WDEFsJuAVE8CkSI/F?=
 =?us-ascii?Q?HHh4F0s2kwl6cEWzYS/1GjhT01B7RCqyMOKj1stLQF3eLQ55I/+yiPraKStE?=
 =?us-ascii?Q?IYLyUmJbd5OqsBTTcLZGLXv8wrtY0aoOku6Kk3SqwuFqiFRHDCp4TuQLS+iJ?=
 =?us-ascii?Q?Gsblw7FHqJNcxEvkIw2dYxHWHUYjFtk=3D?=
X-Exchange-RoutingPolicyChecked: nhttzcx7N2+u8Oj9pZki3SPLCqk5seNqwCQVNoUQ8+K8jLhYLDUNOC8SOWP531sZzHyhHsJuDlIlBe6mxEPWeHJrxYyz5b53ygH4QgchWyyidwZk6QoymL9mtFbxpXNoUwMcyHTDFDDBHsBCEUqBJGxNiW2WFf+8ur3nGj6KqEUAIFYI1keUhHte0AqNpROsKfvkhkuNqjjy45KDvS1mt/YIjIIYPS4psPgdhV4EbbKbWInwN4Cyth5GNSXoYwgg9M42JpWy2loRyGfwS6ZBW7N4XuJsEGQuR1BJuB46npNZCGbHq01yZN3UTzucPCJ+Khgtu00Xt4+AAANQUIsOSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc3eb10-21b8-4972-3340-08df2645dc5a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 20:42:40.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXTg8OWC94gtjyiT0XLcmsvjthbh/1X08JMtIOO0OGvUpB+s6fwNgpgyM0ld3sSnigiCO06zZ0BwWN7yq67EaFHSR4ZjO6b2xSfIGSF2gdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 08:47:41AM -0700, Dave Jiang wrote:
> Couple dport fixes resulted from sashiko pre-existing issue reports.
> There are no depedencies between the two patches.

Hi Dave,

Above is stale. Now 3 depends on 2. Doesn't matter at this point ;)
I did come up w a new review comment on Patch3, but I think you may be
able to fix it up upon applying if you agree.

-- Alison


> 
> v4:
> - Drop the unused dport output parameter in patch 2. (Sashiko, Alison)
> - Add review tags from Alison and Ming.
> 
> v3:
> - Add patch 3 to attach endpoints under the dport's port lock. (Ming)
> - Add review tags from Ming and Gregory to patch 1.
> 
> v2:
> - Addressed couple things from Jonathan. See patch for revlog.
> 
> Dave Jiang (3):
>   cxl/port: Clear cached dport pointers when a dport is removed
>   cxl/core: Hold the dport host lock across dport lookup and use
>   cxl/port: Attach endpoints to a dport under the lock that pins it
> 
>  drivers/cxl/core/core.h    |   6 +-
>  drivers/cxl/core/pci.c     |   8 +-
>  drivers/cxl/core/port.c    | 206 ++++++++++++++++++++++++-------------
>  drivers/cxl/core/ras_rch.c |  12 ++-
>  drivers/cxl/cxl.h          |  22 +++-
>  drivers/cxl/mem.c          |  14 ++-
>  drivers/cxl/pci.c          |  11 +-
>  7 files changed, 186 insertions(+), 93 deletions(-)
> 
> 
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> -- 
> 2.54.0
> 
