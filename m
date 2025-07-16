Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFB264FBB
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631414; cv=fail; b=Z676UU9HaLcOXJPiDQAP29W89PafqyGBBou1qNRbY3wSESEq6OLrdURxkxH6KPzZP7G4If3RJ2x9I5Dj4OYUqvbRDF/Fx12g8FJsz30iP9o5wGCYs35mrC9A+vmwdAlsDnGVr+G5iFLfbN/PZAo3uI9ImJCHxZ3Qjdevwqr2Rqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631414; c=relaxed/simple;
	bh=tPVw3I1T5I/pIVvYv7nn03utXc8/WkgSJkmQOroR92E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qz4Ai45hhUhr17i9swntVBrn0huSdY0vjFWNavLjXDcmVn9VYfZOnKjrFMtMKN2r0swbxzRuLj9hdV08JIEixE0vBqlvJVqHlr5/o2zdHxSH0wdLQ/PGIHjwWC9K/I15uvXqMcaqcnH6roe4x5pfACZbyQKl5IzqNvTKZnTegxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLOdx3XU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLOdx3XU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631413; x=1784167413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tPVw3I1T5I/pIVvYv7nn03utXc8/WkgSJkmQOroR92E=;
  b=gLOdx3XUeGkD8yL7ppTOOzo9K13Nndk5TiILlkrU9BzRZ7HR47owtEpC
   SwdLZ+MneCUwat+UwiUZT7a/opiKXcG2AXyXvNShDZDnbqNnCgf4lJ2N/
   Qnn8Mtn5FCP+7o9to/7Gaee7HVPA/jikG/MI7io4pkunbl41VEo1HKdv4
   FAnTfwIMRHFL1s3Lep/zBfLAEGCL0xxdz8jBtwX1EkEo1R2wIbD/O857F
   64jQIC7f8dSgEbWEy15j/uGzd0pKyTV8EsB9irLwK+bT9VRe2I5w6VxKR
   hhLJvGAhbwlb2vF7oHXWuS+Lsn50sdS17b1szNPwHVBcQzmtJkoASuc9d
   A==;
X-CSE-ConnectionGUID: bnZ7VSJLQBWKHSUD5P12zw==
X-CSE-MsgGUID: 7Z2AmR3wStu/XOU+9ClZPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55011115"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="55011115"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:03:33 -0700
X-CSE-ConnectionGUID: D9p1EppNT8mziR1eLbeFTA==
X-CSE-MsgGUID: PzCniw7xSBGMKMSdXI4ORA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="156773302"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:03:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:03:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:03:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMaFs7DT9j/uHAifjO9SNsqnlnd9SE+jQE3ISTZVXxJ7OdBdxXDV5EVWAWa7u4zNBJYUcJOHRQtG4rWgB4jlfH+FSPC2+9whD5cML/VE+2sAxp/rjPhcNMpP7aC7UvDqxgHqnAylJ0dUwpt1+2IWm6/bEDDsmwD1rUvo29OrepCEewtCXBgivF2TIRO0pDTNjGHurqMb8CT49U+a3fEm4Z/IWHAXmRFZi9QjULD0XuzKv/5rJjmSvHsIGEhe4eRo2B+SsCiKKaC2B3Gk/AP4rc/XD8ZiO9ElkKo6TOfWb1r/d0SEJpDj2fY4CxVqTjxKop9/II5NYgIk7LSRgAd9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACEMgvEZcDl+k8eo4QFh7p52iZgBOdnJGty1njTiRx4=;
 b=jWzDSr0UdhHvym5mxkCeM0I0M+UcoV8NBy3F1OPKLq8DVRH15Mf221ZgWAVrNVLU+dI0joWJeY8DhVnwk+yUqMwmiIWcsBPCUv7RihY0dlS0o7yin9HSHE57a8FGPSjhlSEOI50he5BhmqprEVqljFV5a8xOCQUYYTB5K9LKJbalsoFWjEhkdawFgMQxQxaX4t/V5HlMPN7gAN/zFa5cXpucq7X7ENS+zDUxW/gmRFQYuEp8HKztHpXkz5kPvXadnM2ioJoDgZnI+rk8mPJJIXG7500MVkn6jNtJ85GHIfqSXLuhdmV9JCg5s12D/8/xJZSAih8TiyZriTIjveDFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:03:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:03:12 +0000
Date: Tue, 15 Jul 2025 19:03:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 05/10] cxl/test: Add cxl_test support for
 cxl_port_update_total_ports()
Message-ID: <aHcIXOMXGuP29JnV@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-6-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: eca6a6d9-5cf6-48e1-20ff-08ddc40ceae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lMRqKPkgkaz/8bhIGoCHQKuC0Shng1GESoJbsXRnnzCHnaWZ1NDHFFamX1it?=
 =?us-ascii?Q?6fErKtva5TeubNmm8LvjncwcX2uarKfmZftEZq5z/6X4X1Kabcn24YOIQKNn?=
 =?us-ascii?Q?g78c4+HciKfG7+3XacoaqV4q7D/IMzV1zSBawChjayqHVbczbefaoNeZrhXw?=
 =?us-ascii?Q?GjjoNOompD4ecgMrzJjh4JEEffM86imw/ULfb5aQn3EmdyX3TyxWtzZz0ehn?=
 =?us-ascii?Q?TFq3Nlb/Eao6OSENYU6HgotpI5cvokOwpzK2S7Eoq5bVphT4Zr4srKS25Acp?=
 =?us-ascii?Q?69iK4/G4Mx4NYjGzSmRjXyojlPY05uo/3RIIKWSGnTYiA2s+KaJVZb8eh8Bg?=
 =?us-ascii?Q?GAjb3BRvCF4Pwlh1yduuvEnSEdUVJt+mL+qBWsPV/MRsuxFBVslZBVcQD38h?=
 =?us-ascii?Q?i5UZhKyzp5PpBsCTpXEe94Ulp8jcz6orGOEOvfgk3eN9pNJWhJzTofpiphdp?=
 =?us-ascii?Q?VCUypSpDjLHyGueZpWsVKNocWuIg8M0+h9+CB9nYjC2HdbW45NHgJvSqWhNO?=
 =?us-ascii?Q?rS5vpoH5G40bn95rZPGiEgLGu4W1yH6FdKC//0JJSXvjMmGTlnaht4T6L3So?=
 =?us-ascii?Q?uanBZiwNdoaGxkMh3j1x/oCZcGnRwGPow3EFUz1kZDGCJcF/yqhKxxOfBMqB?=
 =?us-ascii?Q?5u/Zofs0N5WFYx5LNc2VZOxJJ4PD2Jcr0YonzkpOQDcKeMbG6rS5tg8GlvVn?=
 =?us-ascii?Q?i5TiiEXqjyN55kBeNEeeQxA0msfh2iX52TcVcaRZfnL0as1qI1CRsVlOqYov?=
 =?us-ascii?Q?0gxp6ejwGuY2bz7NSxlanqra9Jj/lkdHKdYDd766YR9d08jbK7fL0mKR7d5q?=
 =?us-ascii?Q?7xchE+h8/EutMqpCm78Giv0o7TRlEDj1uudxu55xtWuKerE5olotZBCTNp09?=
 =?us-ascii?Q?0V3NPxLLlVL3n/dHgYb845+JJSq+yzO0hlhWoOtjIW8C3Po3CwNCBEmgtxZJ?=
 =?us-ascii?Q?dwL9AyRD//EUlRYrraCrJzuns/86ArqerNke6k3ve6kFGFvAEsQmxtkkuqcC?=
 =?us-ascii?Q?Ut+bkOHwJpp5+Ak6GP9SKZSUpmZSf8k0+0R0WTnI9YXTk3rLfYnwL513Bi7/?=
 =?us-ascii?Q?0noWp8aZn9Bb0z9w6qO6yZ5PQUZ2MljrgfhAcacVwAdx5I3Qt9BRlePyaPDI?=
 =?us-ascii?Q?VkoJCTtN5q02gWojBY1fPMwv7CM+y/3cr4Y5Arr6fDl6IWxUNwBJeK0eH1nO?=
 =?us-ascii?Q?jBUpE78iEhMd/vN3OKjLLGk4GemzeRG5Qev8/XRBFHOXfzL7aSzNCLmeD7u2?=
 =?us-ascii?Q?oFFXKdSFcLq3WqiviLMDpL2s+vrZ8hw8JB50nqN4rN+7/SeryNin54qwS30s?=
 =?us-ascii?Q?9QDiPP2km3dygZozu1NNXMrywPLMnAXngqC/jd4wCVTmujWBsm8Q/TOHjPuF?=
 =?us-ascii?Q?ItkjK9HKRlM64dDo9So3X5zF/pFFzw5hPbdHdug2uCZ8xqZtBmziw1Vxqwnn?=
 =?us-ascii?Q?9t/RLxFZX7k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nF8Sljnjsgjvb0zc6SSXJYjVwmeiv6KIeLm2qnkya1Tta+83oVs7Jpsi8c03?=
 =?us-ascii?Q?Q77l5v+e49t0C15DrxpR7qB+UIyzniOSf0lQJDjPWJvEaSrVjDED9+mYyGs2?=
 =?us-ascii?Q?qqPf0YlZLQWBJOQ/muGfp4AFc2UlHbnwtsO4841W6b1EfiJ0ovAqv2pahSv1?=
 =?us-ascii?Q?YB+XXWtBoWaBec3Vnp2erhPQb3HjJbfFRcwNijCPGZNoJzZGu9TEnsAdGoQp?=
 =?us-ascii?Q?yVraQFmNyqlwJ+jy+0AoEY3AipdC2+ZwrZjNvGbDDHV9yYUVN57exQtpQ/iJ?=
 =?us-ascii?Q?5qIJoJ29nHp4fhIeC0iQAaYkpM0w9fLW1dYmHedzynQcdJRolfz4J53K3c/N?=
 =?us-ascii?Q?memHxrgnKDOdjBNYrl4W0xCx5g4lQ+suMfW2VyC83Yhwz3U3YRJgatvm1oZ8?=
 =?us-ascii?Q?D1qLhqJTXyDIxsy4a3UASlnUjkau1ttQazzaRGcsYNFoPwGczmYM9Q3XDDhe?=
 =?us-ascii?Q?8MKfEoTMCz/MYgJ/mel0SH2EqW6stnoRvS+d/Xp9pdxHJcF6eqIuHXHPQwte?=
 =?us-ascii?Q?R0CkADh+v1cgZaCRNYv8hgrN4oLyWnJM3nj932ymO89NmOVArQxb69wVfOIl?=
 =?us-ascii?Q?Rz7wr2mtBLYqtFs72VivIgyuFxH3gU/gxo+L1iNtcW+alPcDKDGTg/Dx81hJ?=
 =?us-ascii?Q?PB/AJ4IJPehALwiwh+fO0QGf+yBlrdG5shqqkbIbBTrRA5WxeehkudSLOPMg?=
 =?us-ascii?Q?GUTGalSc22y6eb8mQ16n4lBIWbLx5vZTnd8z6ogUEQvl7eqyjTAfH0yWFBah?=
 =?us-ascii?Q?af4f2q1b/pVkhBMTP2houuUAIhVH05cYm3pawaH6I48gFiQBX6B68CS2M7Ag?=
 =?us-ascii?Q?9KjeW0iDsJyW2c84IdLHdheNeHhaQ72ZGXvuHGX9mgTXu5DyvMH1SsoNpqd0?=
 =?us-ascii?Q?zZdCxtOJ3ObEtuPE1I4ApmkV0mFc45TaeIq+BzGQCPVj3C3g22e28cOxYoe7?=
 =?us-ascii?Q?KvdUq/+NqrepL+DEyEH4P2W5G5v6rZSX+8qFhvXC+vjs/mx66eKGdjxRDzIK?=
 =?us-ascii?Q?noeDnoUgfEJbHOEsWu4jbicOlxrgXh7eURcd7D6b2scmYe8giLD74dGNBKnB?=
 =?us-ascii?Q?PFFWhErDDaZEKeIDaCNFWYymiqIvUX4A35mCMEeF5z7qKkeWi6HYEc0N/Vme?=
 =?us-ascii?Q?6PNHGTOwxpaxV6z2ANc5T82a2T/25fCf/ZV6PdiDynBmDW5UNKlJYMqUiyZX?=
 =?us-ascii?Q?3DZ9PI0pfERWJ36twCqNlvwlwPWBAghA9InUoRmacwkh98LyCifscnqS/UQH?=
 =?us-ascii?Q?BzDqrbQruH6TGRybA4pvs4ewC4vogNSrZQ72t6ZayihirM7GjqTm+h6V5qo9?=
 =?us-ascii?Q?EbQCPfAqQclTyTvAHRCr5nM8VvJHq74cwVLtDrciqtDdPRsCUYFRRdOQ0FKi?=
 =?us-ascii?Q?YZsADcRznGGU/vIA01U7I5hqFhD8W3B++bgjc1UiqSBxEpTHA4T4IeU23TVm?=
 =?us-ascii?Q?MEmhl7uN/5851RXM5k0RWSsfzHfyMm8hss61QtsXX7EOuUfp6vYKgw1BeZF9?=
 =?us-ascii?Q?hXgQAgjenCEj2qtaLEnOt/wXHZGzKudNya+a5YoZ4cN/MczcXMWDflPFRZ2C?=
 =?us-ascii?Q?EaZJ5GGCgXk9DpalKtZddBdS0BqWMexuywElm/2apCUzB6kTYHuAmEC5kybG?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eca6a6d9-5cf6-48e1-20ff-08ddc40ceae9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:03:11.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ao/NwOP2SXUxXJM9svgQMUuXJ/1W6xZ3CUUO6Wm6jTpzsh5ONkrW/SETXsGit/pzDcipcaP+ilx03lxmM88yg2qSKm675KYJ6XZsgFqOcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:22PM -0700, Dave Jiang wrote:
> In the delayed dport allocation scheme, the total number of dports
> need to be discovered during port probe. Add the mock function
> that does it for cxl_test.


Tested-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
