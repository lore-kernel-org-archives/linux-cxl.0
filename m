Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FD218EBA
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631575; cv=fail; b=nmBtkkdjYfrsP5296Xa1Ya3BIVJeW66XAkomo7ehZAGNOevVts/8m2yENczVXuMu2+r03kjpMRuaIkun1+T9qREyRZXDkkl14GfF94WmHOatyVB4Eh2bA8+mK+HJB39gYZbNMw94GhviI8v9W4+viqCZfW4O4I/oQjqmOMQJ3QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631575; c=relaxed/simple;
	bh=/IPAyFQk08URrsSGok1yLDvSJKhmSXEASnuDQJiHHNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=twReYSqjc/VXzClSxCYiyxxIY5Q1gwgPknc7+fb2qPpZWHY211krflT4RnE5z2M6+bECkmQm9gbalksl6mRSjCAb2T7DxuNgMTC/tX3yK9bOij94MZXjCUYmQUCgM2qRqVsSiru4hrU52tTFFGViQpCXlm+1brmYJFV3yi4VHxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZKc3QAh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZKc3QAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631574; x=1784167574;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/IPAyFQk08URrsSGok1yLDvSJKhmSXEASnuDQJiHHNE=;
  b=HZKc3QAhnfNbtKq3AdR5u7zdG7REuiLhXD6Dej0/HiCy4MBzSm6TpCsF
   e6MLBH+9sLEL2Hp1SpbKg4dme9K2Ia5q6G5ak8AD5kFEeGsoaXGQid2Um
   4YU53J054oVV86DgXmboLShF2UqMX8IEPxY3JUi5pZBIsJDEbrvgfwShx
   +oAajWeLe/jsLUdGi2asxKKFdCP8RnJ92qlCWuJvMh4ER56U6AcwP68Oj
   wVXJGOLWV5fT4EdaRTyK/xxMLyhP9aDwoV2GzL27ZmWqMZWqIAi07IYID
   4J9LoYKrO/BXfMlE2Yvm714e0Z0ouwRAbnnOnWjK9038JwfOkuGG7vsKI
   A==;
X-CSE-ConnectionGUID: /YGsqn+XRbCIIArCtl6YRg==
X-CSE-MsgGUID: oIdYs9+MTY2S5/dceRhOTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54575593"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54575593"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:06:13 -0700
X-CSE-ConnectionGUID: eoT6Fg/oQd64zCg8Dcf1Tw==
X-CSE-MsgGUID: PT72JqNkSne0r8aedf5Jig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="158097554"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:06:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:06:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:06:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN14kt6DxajSKJPnjiMWikXwWKMi9C2Lr7UkGaC6uKPv7Gk1y4xjaAuU/Kp9OIuiVhAsCY6mfjBQpd/Xbe5mW6/cFaO8FVUMxitfqe2tWW4Di8FZsUh6P9fsV/5crXVn5IXP4MNceYELK+sgC0R8tlet3tibycrTpZttCTusqgNqNQvClpg9Uewjofl/LjMyhkGEQl+NTUfzAjjK5lJFwVTW76Ou68qvpvNs2vbDp4A4CyWkhigNsmoeiyG2yRnkBsnbOKY3XuX/jgN/SFmtibEGv/bihObV0FucYXYGPDIdNTd2a9hajX2EkihvfF9apRMXnlrEpckaPnNt6Uvliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuEle3jvKOtTSVrXwVBN8J9QxTZF59VCo6k/VCY0XEg=;
 b=SOLrQ17SJCxaOREj44ubyplnpGjNgcKpf4VOEqbaRmvf6E7fyhVzFm4to1Zi5tUE1FfRtOzPUto68XHDOSuEL0QG8rzlBHCieNIxDwLU6y7YXGLxSRC1IMT3iHi79dFZ9g0V2JqSjG8IcN1EO0UxEt0Uik67QvB+9/yc4c+j6lxfJbtJxaitjgP3uKJQHxOvyB/WczXcwuNTa999yyDRbLzNVmoa7EsRZNw+bTZ0/S5LEeiEXoyPrE0D+0d6TXFvEcGLUNxKFhUS8EiA6gBAsmlVLV6tMaFiuX/mPc25/K3OfHPKyd5z5WxKB0UqwjpI/wG4L4UuFXMqdW0hXc2LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:06:07 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:06:07 +0000
Date: Tue, 15 Jul 2025 19:06:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 08/10] cxl: Create an xarray to tie a host bridge to
 the cxl_root
Message-ID: <aHcJC3H9GghDue-y@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-9-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-9-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b53e63-46a8-4f0a-b377-08ddc40d53c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y/Ez9RE99NvDwrMndse5e2nGEHhkPxhG5wOR4Br7wHI70Qjw0bCwrxR4kETE?=
 =?us-ascii?Q?CwMXdsEiYvsLrMUw7p5K2JMTCixfPa5WP6hf60T6Aj4fD7nb4rZZctxUi4pu?=
 =?us-ascii?Q?zE0cc3FiOsgeDF3820/0D0jm4XyAGVPxe2EyLBHJcpDvSjGcsHn6RtcmjbND?=
 =?us-ascii?Q?ax2nWctykW+3139tl2jSjKnelWsuCIAcV+FbNm68w2rUsVxfY9zOP6BCvbpr?=
 =?us-ascii?Q?TVgyiosm+khah1Y5Longg0r9/vCVyfq2BUtAuWKyVWcETJM3POJer04eCqcz?=
 =?us-ascii?Q?0tMCwqk94kpijf6NNJKwAQNPYAqIVbP4p1hWrrQ2r/1GICsgjr9Mf0QgbMAI?=
 =?us-ascii?Q?TuqwgaKxJJj3LcVs9NpdcgiPVeoUkR4T3vEIMRz8xJ0mwyC9qXIVhE/8P70l?=
 =?us-ascii?Q?i/R3T6NVoWWxBN41vV6xRGWjEKjdn3QOtFKZOzsP/TpmkcrHb6+tpQaSKF1F?=
 =?us-ascii?Q?7ZNv+kKeF8ZkMPifHqg6k2+Q9FJ+vAyEO4Nw25poo1+qx1Rs69KBT0bBXm5g?=
 =?us-ascii?Q?bgGv7mwB5Vq7mnaXCjrP7k1t5cF2pk4W0fxy/u4V0gus92bqbqsfYqK4iSz3?=
 =?us-ascii?Q?sA10aIrDkdcQFB2jF48UKNy5BJ3XRoYPlEbJgER6c3pARYiEt0rF9FbBAtHg?=
 =?us-ascii?Q?JCXOuC7x6aPCacmbeajSr7tjzh4w5djaRZWkka9VWFvsZs3re7l6KtGrJn6A?=
 =?us-ascii?Q?2lD3MW7ur4MNcG/48sMZ6R28oD8HM/qBmQii4lG79YdLbBsBTKdvinruOges?=
 =?us-ascii?Q?FRUjRL6B2rkMOYiwJ0GwD8ADw/5NooGwqNB9VWsHyTfoPzkkurM2uwbS9rdS?=
 =?us-ascii?Q?wLyt0FuaEiAytrEeEMpI1EkGX+odtFO55B9ul3wQrYQ+MF5Y8hzIbqCxpLPp?=
 =?us-ascii?Q?X4aGRapeMXF7mvC1jRdlZESSFX7f9y1mdlR5joimXnRSusP0ZFb1TJl0Q4ZN?=
 =?us-ascii?Q?k5BRnGVivtBn+HWLpxUHVsa7dhLV2l/CDfv9mItZqmcTT/zQ6QYghO56Vr4A?=
 =?us-ascii?Q?3vYcreUgcdnW0mRrCsg2HfcSTz8JTpsUPcKyU91186yBTwfbHha1V2os5sa6?=
 =?us-ascii?Q?5IedFrYMQwq7zdZJFJpOAavURivyTy9hknKKwbXKEM7hBm/dDUcnzhCW7MCj?=
 =?us-ascii?Q?zfDmiyshQQ5BCu05Lu+WoQ66KbHojCYyz2EItoUWhnrggIb+4IGudRgSoClI?=
 =?us-ascii?Q?c6caGxb/aKpOYLmeJKnzDQTeVGpi56xperP5UkAFsjazTN/6lXcFWNzIYqU0?=
 =?us-ascii?Q?mkGB4oUJ/uxXI6K1xRbjmdN1dyNqY4P8yZnwZ4mdezxnYHO3tiAAoTkuNTx9?=
 =?us-ascii?Q?qv2UHmJmQ0SBHYDxxugcBjdVdnZ1qw8QX2B9SBKzVyS+clZsOoZNtSHmXQuJ?=
 =?us-ascii?Q?QLBsOuqZv5f0HE/ywX1ALEaQxuo4RvdAHSlIZass/Y23u7nxBdFT1zYrVXb/?=
 =?us-ascii?Q?0m0WOKXpkUE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeIGujewaJe5XXzhhtNNRQn35ERGxsxUF++UdOsPsLeKPOC8LUWBev1lrfeh?=
 =?us-ascii?Q?faeJpyvyam7BTvMwo8kbihMfpAiFg2AckkrySTshv7QfQOfzP2WPSIXXlNRP?=
 =?us-ascii?Q?sveFbNJCfSfD/lGSoMEYZqZODvcbAE12KQCVJtVKOcyhjES8HCeJWGT9UYKO?=
 =?us-ascii?Q?tTOMkb5jqEHn6Z6ISoOcd3TQsul884e7aMmiCPr99TADkPNoJM3scDll+Ht4?=
 =?us-ascii?Q?VyVum+QaMrUsiVXlLXNtPTWx3aZY88LQyLj+4c4WaOdmzlIZri1rPVkv6sjZ?=
 =?us-ascii?Q?NQy8fVDbbuh1qVSAAAk9bgn/katIifb1ir3XlZPjJSiHV+jSMn7kX3kYGC+Z?=
 =?us-ascii?Q?3GdYZWYE4Jkzyr3EkNwT9Qqc2jXVPGH0JdnUBZ5WZShJ5qY4EbXXzBjUcXYs?=
 =?us-ascii?Q?hWcSzp6Qls7UPr6mwztNaAW06sXk/6jUlG5VjoB8RdGbkd5/cZull5uYf1eO?=
 =?us-ascii?Q?qCCeL4hw6EhaoUcttTN9en2NFtEn1ndtROQI8nxl8kOqygytgh19yOimCOVt?=
 =?us-ascii?Q?wksUdRHw9QV5wn9oHQvKng36pFrUfpC/Xvg8TNDgoR+TaabYVzeZWPQb7W2q?=
 =?us-ascii?Q?RTP5jdD2tmmkKts7tR6rtVqkq6zKNZ7pFK/2tz3SebGp/v2F/V4bdNSggkHy?=
 =?us-ascii?Q?ZLCiFkrGMO/ow6gjXxq3ikROdQu9puOo9wLnZ59XasdfnwK/0RJh7MjkZ3hf?=
 =?us-ascii?Q?Xqgsz4l65T+8PY8GPT6sTpXEr1K0p0gTOdQZaZNqrZo36Yj+z2ixh+J0rkYk?=
 =?us-ascii?Q?SRQ8vOeULlFbqqtJKzouoeGrQEFS+3XvFWktRNLN3saY89f+teIFhipTRQ72?=
 =?us-ascii?Q?gwyGhWXd4+VLdQhydn5njmgdE6rRTyw00/2HHCTl9spBT07DKZ88wNbMQh9Y?=
 =?us-ascii?Q?BiIfY6Mg3Dbr63x/7bWHOviYQN0csfd3Y3tWS0iAnlHrcH8jvmsSQ964Hw40?=
 =?us-ascii?Q?NuzZMJNDfJj6EKCstaBv2z1HaQZoDA/LXm4aAhsbqHXt9wJDfyhiEPpwuvhw?=
 =?us-ascii?Q?w/J91k03QFAdmP+j7cLZGAC3qxHCWuW8GsWyA4OZcfhOaz8o/2k6fZVha6jN?=
 =?us-ascii?Q?lFUhFLObFMaUmQvs5TrKYLxKupXgTzvaaOKyDrUwMOxYHMVF2O/cKHbhcHex?=
 =?us-ascii?Q?eM5M+NftH/YJYXL+tpasx5JXbRiXXw+FpEHDx7lrX6LcgE0RK9YZ3im/ldD1?=
 =?us-ascii?Q?GQTX1OwRqI/YtKVYTnupP+VioF3w2OmdsJ4dQIc/Rk/hqXZVjwJ5vlvpzqG2?=
 =?us-ascii?Q?iY0QJi0tiqS2YTU9x1CCyHeZIT0n/i7gx2mLDmW2K9KRf1WkVaGVQQC+oDWt?=
 =?us-ascii?Q?qgc3CHf6NRnysYHkGC1xDr4jGvpEtPdSydzj92kOlNY8dTzRWxdMeF88j11t?=
 =?us-ascii?Q?I8hWmHThhwzS2Wag+ndWCkIM8A7zGRciFjEICX50FRgIwfQfqBFouEdHnjNg?=
 =?us-ascii?Q?CY+Yt2Inm5qIVQldPRseGvNKWfYPqyw1wNXzCGbXAXa2GC7t6fhR8qMKnqDw?=
 =?us-ascii?Q?IrVJxXKkk8+Rvq5bL6cks79OYdbjZ0TXiBZHSqwkFh3TRcT0wby/KhWm9uwf?=
 =?us-ascii?Q?RrE6gSxAL9mPqd4MdQjokkCkVT0ysRLcR6pVcqL/NcXoShzbkWWpjc583Bpk?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b53e63-46a8-4f0a-b377-08ddc40d53c0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:06:07.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICSCV61PsWvZIxgKzP8R+BqbcgUK/ucVK+oSPA5FEUNSc5i6R4In+sTf4SYaATqEILhh8ZvUqc3DLg8twk7Uwvc6TprfeAgNsgVzIHzOdWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:25PM -0700, Dave Jiang wrote:
> Add helper functions to setup association of a host bridge device to a
> related cxl_root. Functions are in preparation to support the moving
> of host bridge ports creation from cxl_acpi to cxl_memdev probe path.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
