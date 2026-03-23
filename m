Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEB248166;
	Mon, 23 Mar 2026 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233457; cv=fail; b=anzka17jJXLmIKeHCSYDYi664+yTTZ+EIslVlSfO/ub27yEb4BGh7MA3p2+R1pffoWKtf2YBOurkspDjg6UUa6GTrY0bdXdHphGkGm/bSGQ9jV3g/4k2K+YFayrIfHV5VCBviljilM77tgD8ZjzZFbQz/l4baqISJ6Uwrxi3R+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233457; c=relaxed/simple;
	bh=FVOEETlF4c1ES2qhIAVmfJuJspQszJ/yy0PZMLSXTnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IzpfY7YSMKHHVNA7kVEK/VA1LvOZvZVCnRohnyRVonQTrxcQu8ERGEo5zoj2MOCweHezgTYzeP8g/FZ2xd+tKpi7J83Kw4Hw5GnEpB4hVoP4We+4NnFFHIQ7tTCktjXH+YYxCxQvwW9wzz4igm5Sz450VLP0Hy8WhuXRCCGcktA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGyZRtrv; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGyZRtrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774233456; x=1805769456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FVOEETlF4c1ES2qhIAVmfJuJspQszJ/yy0PZMLSXTnQ=;
  b=QGyZRtrvsQaFduhmNdlRjQHGY8cL19Q8kXnR7y41u5ZjoaNEUZMI91iw
   Y70aOacmy7z9CzCDxQoa/dxBHnVgFf7pLnF8c0ayKBTje4eMIBWY+Gu8E
   FzZhwIK2JQEMAQJhFzhSep4U0SOR9AromW5UQ4RKJt8igMvYUeAe5LZPz
   Dckgr5HjxyX8rsFEdIaeWtfbLmnwiF+bKsWzu7RvoSnrev0w1vKfOtWWv
   mCKSgDq/4te5JK/DONOlLSOQKW+X6wQ0fMGxC9FJoUgrJkiSO6pkSryvc
   TLLwc9JVORP0Lmc3YXYattL7McL3eS/fUYVLxasxm+CFIB5F4JFFL6JAd
   g==;
X-CSE-ConnectionGUID: GVy0G+6wTLeeyUwbjBBZrA==
X-CSE-MsgGUID: 4CdQFx4iR5aO9QsCVhz3HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74940279"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="74940279"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:37:35 -0700
X-CSE-ConnectionGUID: H/b9LHAHRwuVID9UCDeWSA==
X-CSE-MsgGUID: qIsST4HpTEaU9pwQtoBmIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="220649978"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 19:37:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 19:37:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 19:37:33 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 19:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQC+8/TdkFwbHDw8GsB3v4Y4QnynLwSJtMGq3YilNqktXgQBWP6ASrB+aHojobnnp/M7n+wsKBZw2JQ48BWEpTg+VFbIJMYq9YRW2ar1LvcYjXbZheZZi5c5jl55mL9qF7oauC0be1EY/F6ylxRltUEaJe98t6zUtDOGB2/z2RpTph4EbFp5qa91QZsL4K+A3/99gyaCGUL1RGLc3oUS/kbIsYg11Xw368IcxOad9968dkFlmHZjsQ1jANjMXpBKxORPADIT4k7yb7V7JUSa3BR0kdWsmKe0RVyWgNZnxsMIwPd8MTvOLnZFqDZgi9AguhCTCgJbUGKLS5PnlAtGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADqSQ/HIiLKGHd+P5f8aJoSlxDBbVudu3GjCHWVO7+o=;
 b=AxweQP18LEEphql5KhnqSLNkFHnL5VZfRRTEfFupH7oFSSYPu4qaSTLDEJtBHXV8+7z94YW84hr0R8XymibPnCrNn3RsP7aDowmfp7wjRJY8K4/LbAwP9ssfuKzfQlgS+0leiVva0V/CYwIxaLGezxBTFlq89prVENCo45Ug/MbBAcqAFUWXjMRbOLuQwXv7/AuZfo9Zzg2gyfTg6yGldwF+TPSLb7WL3znV6SZHHdeglnR0MHDHfxJdbqg7eyvC/+CRpLAtGY7ZA2AtgpFI/+mW7j0KIl4Mmo1gCu2BgMxSFButJ1NgbPVEMZ3xMqGaXcsgXC0Q4G3v38IHEYp8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9781.namprd11.prod.outlook.com (2603:10b6:806:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 02:37:31 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895%4]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 02:37:31 +0000
Date: Sun, 22 Mar 2026 19:37:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <acCnaN9MIRByjUPd@aschofie-mobl2.lan>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260322131638.3636725-2-gourry@gourry.net>
X-ClientProxiedBy: BY3PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:a03:255::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd78f64-c1aa-4c46-c72c-08de888521ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 1vqYmAIkacie0EvnVgLLEJa+prl4MxTNQu6hIICwC0OHLTL2xauRy1Nbh6/wgkx4t172byPtu906FRXCXwvy5dmX2CjrBUMwLsfKHCXFsefh+WZKyCiWzVxhERc6wogNe3FUlVKqbUuClG1YTOlz9widf2rCjXfvD6Dwc9QLpneW6Ql0k6Yugzdm8Kwi5FHo9Lrq2d1bbzjAkJWiEhoOasGVdaIwG4x5Sd+CO4lS1Bj69BskgNX0q3Ho1ulMXEDSllRvCpemsX8NXgN/cQKP2bB06mnBTZV8IQkFSMM1AKx4fVOWeb9stUYa1umyuIlV09a6iCnRqjOZHT+X4kRsD0qmfmSKfmHjQll8Zk2cshrdvwJlEuoGc76K/i600MPNt+HQGM86oANsQe+kT017xjMS0NFhc/OUWIANIx94daNkjfhk3vrGulLqX1BvqJszjwcB/zyBoPfpWIZI6XJfJIK6f1jmexsD8aVNPal3yo/ZEI926PH+9jIV2YdPC39V3CRmgAhfbDSPhpJd6bgsyzxArLBFNB+K+xiJG9BBfIrLoKHUFw+CBHeqMmTPISa1zYVc+8zbz41S95mfHEo4it8PUl2wld7SYq3m5QdLVfSmpg9KHH12m5CHxeUFTBDzZNNTcoeTm1NBG1Kpr7O7ya7zXZfiEfPfdQqx6hC5/jjfcJfAtnXLD8EhbMP8Yd8cHnCYuDupwfZ6v+ZqiSlyDHQt2iXPhHqG9iv40u0vXww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73APy5/lB+Rwef87B2Pn0ddYNFudMdU5Srr9SkcD7/pWKssVEK5quHP1Zd2+?=
 =?us-ascii?Q?zLFrLSC+2KNljSPQUETihpo+EZrVGRFHvfSXmX0OcqDrNsBE4KiMvCg/pRnJ?=
 =?us-ascii?Q?QhvhcvfDov9f/tUbKSPSuFuX/ePJHlfO0ovOE1M1uJQM48lnXYtV0+uXshWP?=
 =?us-ascii?Q?gOvk8yTnDpcx8vTfW2MJM2DkYhwHxpwiybs8HSAqsYXXWDfN4uqP0OVBN1Dg?=
 =?us-ascii?Q?1GGlW4RMwTRSLV9/c9dATQJJ1OnIhtZnV324gruTj6tohCU8UNJjNnOjJsZV?=
 =?us-ascii?Q?uTNdLCT9IsdR1c1xnQyhWAseyNQEZR7IvISgXNzBNZTlMCPIfUm/o3LAIi/g?=
 =?us-ascii?Q?/lb+e7dKpBq/GElP1U5IjMAwYiVcsL6ZVpI7x+MgErWzdb1HD7OI2TF0Rqw3?=
 =?us-ascii?Q?WG13zMzaa1BHSpvHZLlyEBu7ejw8Qk1i0gFpbt5wMOMPQ2n4UYwmBJ1rpsm0?=
 =?us-ascii?Q?BJ1o0J97daLQzD1n6V8I0T0BXehQFXJ3zGkLDuvTOKA1KNCaGVwrI+5W2fhZ?=
 =?us-ascii?Q?AIkyhcI2YQvWsAb4mjCqisYo9BEaTz26IuIT006NpjNGCYsfm+MBAN1gAmum?=
 =?us-ascii?Q?D5XvMeHPf09kk3zb1TDDkY2I6bf+dBXfBkO/ydbVsdDvVXezQJpYXpE4ABnI?=
 =?us-ascii?Q?UBb79LsRFZrF7sfd9U789T77BqwdFzwmUWjgrHKw2dutsAe97ORynG8NV/jq?=
 =?us-ascii?Q?7I3PHbOqCHTwGvBNpuGwFvMyFshb5I/YIIzW1J6DvWv2oSTW79ZugEJuyepK?=
 =?us-ascii?Q?EtocISHBp/Cbq4YSb7A/ARlYLL1SI3PkR354b9kMMP5/WCuLzS6urBdZ5m0j?=
 =?us-ascii?Q?MuLnqlTuUeLr5rq94hzD/6qLgYebm4bbNP1xweWZNeeeu+erJY2JCHIUiOzQ?=
 =?us-ascii?Q?hFI7oXb+8gMfkIiUyhH17uJW6+6yWjXqAL/+/F0+qQj/m8yovlePknHUWakM?=
 =?us-ascii?Q?SpzXC8yH4KtKQPFwjqbUX2qvoNsoS3SLriYsir73rKb5XjKAmV/8cH8siyiC?=
 =?us-ascii?Q?npPLsMfZmM4kkqvxaKKVUgAVFlVjFmdeaEDfcXBD6gXaSVsHsC2/rX4qKlcy?=
 =?us-ascii?Q?6ZeSd5pryjw1ypq1S1qV9+p3SsaBumC4z3Qm70tRZo/zNA0HQUHtbW4A/yap?=
 =?us-ascii?Q?Hky2caed8mvmLlRXobsBa2k6nRnb7NKuUcRkHKFzUmU/Ata92vgMbpb+y1bD?=
 =?us-ascii?Q?aVVwQ61uWtxAoTVZI8McG2sWJUHb9ubuwp/cFd4J0+tH3c8PXb7qtXY1UYK0?=
 =?us-ascii?Q?MR0uoL0E1SRqIVEVvUd/J/sPBOu2YyX5ApZawZD1qvA+fRQgQQqRHp1/pmL+?=
 =?us-ascii?Q?Na9HhZvrEOfv5KMz3xFNC7mEhYMvfpjtCq4cmJ/Q8QpitrUrCqEjqmZlyZE8?=
 =?us-ascii?Q?9VBXlqv4Kg/RZWd4aWMGa0ZDbjGkhkP8Azk8q8L3QcH6eKkurdSMK+B1dZAE?=
 =?us-ascii?Q?7RvQu1Bk+hkdWDbC0wcZ63s30kh2eFrA90hoyMCyW9Xp0FXW1+TMOxsCJnCZ?=
 =?us-ascii?Q?XSWVZzPsq04vmY8X2hh103/JGnoN0+fynIUZMBflASttz4yiiZy7fhCRd1Ba?=
 =?us-ascii?Q?VlfFF8dlTjPEZe9eoUazoyByeYZF7NFF4benfSsW3Cxgi0It27ekz/qxdY7u?=
 =?us-ascii?Q?+ElPqz3S9ZT4nxuh7v7s019l/QIsFEyWXvYZ7PQo7wQOOzUB96zYYJa7ZJah?=
 =?us-ascii?Q?0LjNyWyw3zDEKcEwxw9pp3u1kw7osWjgO2vvXHv3twDhRPkDzFpaWpkT2oxt?=
 =?us-ascii?Q?4cZDUZF1rfoWdS+VUNYLAnyW2NaD8Sk=3D?=
X-Exchange-RoutingPolicyChecked: NixiKTdA6ma4AJnR5mzqKyuRUPRZfVFbF8h1dpEEnEhCDkjVuCBHPyoBK5CwxjzXd+ZNMzlHwXclwAByN8C0PQt3eGQgITjjkPGpdURIY7hRzpb4z2tE1/rZP+sKj1XogG4QnCzLV7h0/nq8Z5hJNf8b3hQMYGN5XQkPCIwsPw0xzGqTTwSr13SlbBWAc+0Eki3RJsV4FNeLG10/oLWlPRdvxBvIPN0xaWAKY4wWN/5KsP9oyp0PhjHsLUBu+fBpqEL0pxr34Ztrm0CFKfEPP+ubFxa/beq5rsXMbMiTe9BeJDBo6CX6m3SRJ1gJRW8FAnQIbxuM0zTG4jOAQXy+eQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd78f64-c1aa-4c46-c72c-08de888521ea
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:31.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFmKAqaY4DzzraNIzl2mVcCCsr5czl5cyTZWTErP1arv+m62PrprAhC+RCo9yTGGpcCmcdcDPj+oBAxdIPmLd6XfIdDvj5a54fjdEjs32FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9781
X-OriginatorOrg: intel.com

On Sun, Mar 22, 2026 at 09:16:36AM -0400, Gregory Price wrote:
> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the pmem region driver logic from region.c into
> region_pmem.c make it clear that this code only applies to pmem regions.
> 
> No functional changes.

This always adds region_pmem.o regardless of CONFIG_CXL_PMEM.
Are you heading towards conditionally compiling, where region_pmem.o is
omitted if !CONFIG_CXL_PMEM? 

Similar question for region_dax.o

--Alison

> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/Makefile      |   1 +
>  drivers/cxl/core/core.h        |   1 +
>  drivers/cxl/core/region.c      | 184 --------------------------------
>  drivers/cxl/core/region_pmem.c | 189 +++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+), 184 deletions(-)
>  create mode 100644 drivers/cxl/core/region_pmem.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index a639a9499972..d1484a0e5eb4 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -16,6 +16,7 @@ cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_REGION) += region_pmem.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5539e941782f..ef03966eeabd 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -50,6 +50,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>  
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f24b7e754727..72aee1408efb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2781,46 +2781,6 @@ static ssize_t delete_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_WO(delete_region);
>  
> -static void cxl_pmem_region_release(struct device *dev)
> -{
> -	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> -	int i;
> -
> -	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> -		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
> -
> -		put_device(&cxlmd->dev);
> -	}
> -
> -	kfree(cxlr_pmem);
> -}
> -
> -static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_pmem_region_type = {
> -	.name = "cxl_pmem_region",
> -	.release = cxl_pmem_region_release,
> -	.groups = cxl_pmem_region_attribute_groups,
> -};
> -
> -bool is_cxl_pmem_region(struct device *dev)
> -{
> -	return dev->type == &cxl_pmem_region_type;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> -
> -struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> -			  "not a cxl_pmem_region device\n"))
> -		return NULL;
> -	return container_of(dev, struct cxl_pmem_region, dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
> -
>  struct cxl_poison_context {
>  	struct cxl_port *port;
>  	int part;
> @@ -3476,64 +3436,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
>  
> -static struct lock_class_key cxl_pmem_region_key;
> -
> -static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int i;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state != CXL_CONFIG_COMMIT)
> -		return -ENXIO;
> -
> -	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
> -		kzalloc_flex(*cxlr_pmem, mapping, p->nr_targets);
> -	if (!cxlr_pmem)
> -		return -ENOMEM;
> -
> -	cxlr_pmem->hpa_range.start = p->res->start;
> -	cxlr_pmem->hpa_range.end = p->res->end;
> -
> -	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> -	cxlr_pmem->nr_mappings = p->nr_targets;
> -	for (i = 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled = p->targets[i];
> -		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> -
> -		/*
> -		 * Regions never span CXL root devices, so by definition the
> -		 * bridge for one device is the same for all.
> -		 */
> -		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
> -			if (!cxl_nvb)
> -				return -ENODEV;
> -			cxlr->cxl_nvb = cxl_nvb;
> -		}
> -		m->cxlmd = cxlmd;
> -		get_device(&cxlmd->dev);
> -		m->start = cxled->dpa_res->start;
> -		m->size = resource_size(cxled->dpa_res);
> -		m->position = i;
> -	}
> -
> -	dev = &cxlr_pmem->dev;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent = &cxlr->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->type = &cxl_pmem_region_type;
> -	cxlr_pmem->cxlr = cxlr;
> -	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
> -
> -	return 0;
> -}
> -
>  static void cxl_dax_region_release(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> @@ -3597,92 +3499,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  	return cxlr_dax;
>  }
>  
> -static void cxlr_pmem_unregister(void *_cxlr_pmem)
> -{
> -	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> -	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> -
> -	/*
> -	 * Either the bridge is in ->remove() context under the device_lock(),
> -	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> -	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> -	 * lock).
> -	 */
> -	device_lock_assert(&cxl_nvb->dev);
> -	cxlr->cxlr_pmem = NULL;
> -	cxlr_pmem->cxlr = NULL;
> -	device_unregister(&cxlr_pmem->dev);
> -}
> -
> -static void cxlr_release_nvdimm(void *_cxlr)
> -{
> -	struct cxl_region *cxlr = _cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxlr->cxlr_pmem)
> -			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> -					    cxlr->cxlr_pmem);
> -	}
> -	cxlr->cxl_nvb = NULL;
> -	put_device(&cxl_nvb->dev);
> -}
> -
> -/**
> - * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> - * @cxlr: parent CXL region for this pmem region bridge device
> - *
> - * Return: 0 on success negative error code on failure.
> - */
> -static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_pmem_region *cxlr_pmem;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int rc;
> -
> -	rc = cxl_pmem_region_alloc(cxlr);
> -	if (rc)
> -		return rc;
> -	cxlr_pmem = cxlr->cxlr_pmem;
> -	cxl_nvb = cxlr->cxl_nvb;
> -
> -	dev = &cxlr_pmem->dev;
> -	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> -	if (rc)
> -		goto err;
> -
> -	rc = device_add(dev);
> -	if (rc)
> -		goto err;
> -
> -	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> -		dev_name(dev));
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> -			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> -						      cxlr_pmem_unregister,
> -						      cxlr_pmem);
> -		else
> -			rc = -ENXIO;
> -	}
> -
> -	if (rc)
> -		goto err_bridge;
> -
> -	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> -
> -err:
> -	put_device(dev);
> -err_bridge:
> -	put_device(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> -	return rc;
> -}
> -
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
> new file mode 100644
> index 000000000000..138c373a5700
> --- /dev/null
> +++ b/drivers/cxl/core/region_pmem.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_pmem_region_release(struct device *dev)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> +	int i;
> +
> +	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> +		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
> +
> +		put_device(&cxlmd->dev);
> +	}
> +
> +	kfree(cxlr_pmem);
> +}
> +
> +static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
> +	&cxl_base_attribute_group,
> +	NULL
> +};
> +
> +const struct device_type cxl_pmem_region_type = {
> +	.name = "cxl_pmem_region",
> +	.release = cxl_pmem_region_release,
> +	.groups = cxl_pmem_region_attribute_groups,
> +};
> +bool is_cxl_pmem_region(struct device *dev)
> +{
> +	return dev->type == &cxl_pmem_region_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> +
> +struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> +				"not a cxl_pmem_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_pmem_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
> +static struct lock_class_key cxl_pmem_region_key;
> +
> +static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int i;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return -ENXIO;
> +
> +	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
> +		kzalloc_flex(*cxlr_pmem, mapping, p->nr_targets);
> +	if (!cxlr_pmem)
> +		return -ENOMEM;
> +
> +	cxlr_pmem->hpa_range.start = p->res->start;
> +	cxlr_pmem->hpa_range.end = p->res->end;
> +
> +	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> +	cxlr_pmem->nr_mappings = p->nr_targets;
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> +
> +		/*
> +		 * Regions never span CXL root devices, so by definition the
> +		 * bridge for one device is the same for all.
> +		 */
> +		if (i == 0) {
> +			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
> +			if (!cxl_nvb)
> +				return -ENODEV;
> +			cxlr->cxl_nvb = cxl_nvb;
> +		}
> +		m->cxlmd = cxlmd;
> +		get_device(&cxlmd->dev);
> +		m->start = cxled->dpa_res->start;
> +		m->size = resource_size(cxled->dpa_res);
> +		m->position = i;
> +	}
> +
> +	dev = &cxlr_pmem->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_pmem_region_type;
> +	cxlr_pmem->cxlr = cxlr;
> +	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
> +
> +	return 0;
> +}
> +
> +static void cxlr_pmem_unregister(void *_cxlr_pmem)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> +	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +
> +	/*
> +	 * Either the bridge is in ->remove() context under the device_lock(),
> +	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> +	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> +	 * lock).
> +	 */
> +	device_lock_assert(&cxl_nvb->dev);
> +	cxlr->cxlr_pmem = NULL;
> +	cxlr_pmem->cxlr = NULL;
> +	device_unregister(&cxlr_pmem->dev);
> +}
> +
> +static void cxlr_release_nvdimm(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxlr->cxlr_pmem)
> +			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +					cxlr->cxlr_pmem);
> +	}
> +	cxlr->cxl_nvb = NULL;
> +	put_device(&cxl_nvb->dev);
> +}
> +
> +/**
> + * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> + * @cxlr: parent CXL region for this pmem region bridge device
> + *
> + * Return: 0 on success negative error code on failure.
> + */
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int rc;
> +
> +	rc = cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem = cxlr->cxlr_pmem;
> +	cxl_nvb = cxlr->cxl_nvb;
> +
> +	dev = &cxlr_pmem->dev;
> +	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +			dev_name(dev));
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxl_nvb->dev.driver)
> +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +					cxlr_pmem_unregister,
> +					cxlr_pmem);
> +		else
> +			rc = -ENXIO;
> +	}
> +
> +	if (rc)
> +		goto err_bridge;
> +
> +	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> +
> +err:
> +	put_device(dev);
> +err_bridge:
> +	put_device(&cxl_nvb->dev);
> +	cxlr->cxl_nvb = NULL;
> +	return rc;
> +}
> -- 
> 2.53.0
> 
