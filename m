Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447A2868A4
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249950; cv=fail; b=RtxSXDeORXfjPQSJJBVZRPpxwJIaz8YqUXIRje+lQHKoWyiCH9OxTVY6iY+585O5eFDNek6xqSXeyNY8cXiNvvwuf8K1/K0QtUI/cLi3lL8aOR7FNW7a0Td0RPkIDbh03V/MAc2CHVzzku7QCa7ggSxYTLE2mCdLiiZMnrsXfaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249950; c=relaxed/simple;
	bh=XNoobF/iP+7weNrV4lb2SprK3AIxSaXBZHR6+CcAoUY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUIdp3G6CYnCnCZvleEMbrNJJ/8KL7yntKRrJO/DmhC/jdiHK8LE+oWS3nhrx6A68M9WMi0fqj0zabNwHdQnXxvwSZm+C4dOxwlGmv1+WyN9jZJYgILcN/ZOIvkR+48Vpw1Os4wLg2wjWPBcJKB8QHjv7X8g5HZ4baLxuceNawE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7uoiUTm; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7uoiUTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747249948; x=1778785948;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XNoobF/iP+7weNrV4lb2SprK3AIxSaXBZHR6+CcAoUY=;
  b=B7uoiUTmUg7WKjqe68rQOXa3MYFrbGpeBW0vMk6bu+neoumg2DiVrw49
   qzM/OPMSmjKygxL9gVBQgYshxqwYWK/n4oDwiH7i3ZN9hgOFbHe5qtuq6
   tCKr9dfKrdD6pp9rngVbRm9QWOqbpMzXEX1HLFBGJKgQM+UHMEBaLVmzE
   LS629JzllIlOPUeLvcC7OOyEzXAG2j8hzdmI60yIu/MvHaimr1U3VwSAN
   UGPB31a19PElb2/KGB+/GLPermhlp5AQOSP2RLMcgRJ8jlRVUgTnJaRY5
   INc0a8Nlgemu/XDSdCdkkP/74ZJQSXuRI2kQTA9OWuU5O3loJ9HsNSKUF
   w==;
X-CSE-ConnectionGUID: CYHpXMUkRpCBVgFh0OwXRQ==
X-CSE-MsgGUID: QTPpNHj0RqqNh1gI/h+gtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60566354"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="60566354"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 12:12:11 -0700
X-CSE-ConnectionGUID: NB630/YQRPqq6qJlOLABjg==
X-CSE-MsgGUID: fiwUFjSJT967OITBCYeZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="161419766"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 12:12:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 12:12:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 12:12:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 12:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px7OtYVnPVTAH3EjRwM8+mmqW6jFABH4OCU8Cn6QwgcHJ+6la64uFc9AZ1SuaBNMknxqD9HpNYnZvPxuPPvtIOjQJxXQ1rEtzKsWnDXnQmIidQRD5TUnHZF8lXG42f8tXCxGTAWrf492Z9HMLnYf0sBc7IHll3UCBZ71h41/V+iaL4dDQ/K4ZAGEnmeRIO6GYhNS9wTUe19D2mvcigPQFGSx2Y4xraFw3kMiLjlchlA8ovWXGlF9S+4M8ZRZ8grI+wlUDzfdh2e+dnLBh1VP6zUHMyJdyICAoX0vHnjyPmNMi6d4FweDwu1BbhY4toIMo6DqyI+Rdt+f8DI+cuqWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u9C3KK18bAPxn4aOQxvH3D5S9TvV5bxFd9mIcpG2xI=;
 b=GRmCeHMDnvMKqGnYcWSWjF1Jkwovj6ndxV50abvhaf3vTDdQ9aZBpvkluQEd+hmu5U3fqIp5VO1fKxDvkFcc/qsZnRH7Ad2lI18L1UN5XRsIN1tPrMCxXOcyc99suVcUTqMfDRVfBcstEhdUMOb+mLXJ70mdRmzkCNFKoZFQAIiGjDzxGFRntDUFJJ2i0ezUJ3wxnHb1MLf6xIKBLGGyBxKNrJjTkc5zcPz9hCFLfPDpe25IE2ebVV7vq/iSy1WW8Np6mSPrMt4mEaiSqf25F3KjxxDhy9CZbbLrq3kEfcKSaGSdj3NSfzZLxgSKy+kgiUrhdgCbQhKUdIc+HXUesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA1PR11MB7016.namprd11.prod.outlook.com (2603:10b6:806:2b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 19:11:52 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 19:11:52 +0000
Date: Wed, 14 May 2025 12:11:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <nifan.cxl@gmail.com>,
	<linuxarm@huawei.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/1] cxl/events: Update Common Event Record to CXL spec
 rev 3.2
Message-ID: <aCTq7IX49iLBiwJL@aschofie-mobl2.lan>
References: <20250514151913.752-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514151913.752-1-shiju.jose@huawei.com>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA1PR11MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf98b99-a7dd-4882-9e94-08dd931b2f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R63+AGK9apw5djgttk+WC9zsjf4g1ng2mgUWdzR2Jstlel2mG8sah1T3nBaJ?=
 =?us-ascii?Q?eQckvR+68TGkczp1PHQZOYCaVRWYq1uBboybee33qEo4/OhhQzVipefnG+Xz?=
 =?us-ascii?Q?iISP0R/75ssOzxLMDg1HuytcczE7GjyJw14VjCvCWUIc+u3FuWHLJV9FDF0N?=
 =?us-ascii?Q?jAbgkxhmj+999t0tME4iE4twYQ9Ga+kRqAuUYNeFzmDVuntDtw0DSndk7uJ0?=
 =?us-ascii?Q?QuwFwyM4tzUbvGf+cO2EsNP8rgsb+ANZ8/O/v/njJFw0lF2XB1INFFIKtc4B?=
 =?us-ascii?Q?KUvMX49i54qso+icad9ic0vzWRI0sF/wXlpfy/D74KHHNu3wpBuSjr2Z2Mr5?=
 =?us-ascii?Q?6jaz1Hdh8da7lFUUNfCcrS7LXSaJoc7GNe9x5533MibDdUb0YyKRrwnXXgFF?=
 =?us-ascii?Q?XKSRKS5JmJTQGZAmMeZThFJ0mbyzLN5Ov4gSZaEAE5keK/C82/p8ka3QBFmF?=
 =?us-ascii?Q?zbMiJ+KYINet08Rcf+ylnnAXhjWgB8/ibi87HdPGSq8xNj2RtspEKHZYq0my?=
 =?us-ascii?Q?RMYmw40atgqRTKslqlmYEdfVfqy5fIGQy/RVn+bUUc1DLLktP3najYQ39bMe?=
 =?us-ascii?Q?dYNVLi7XQ4z9Fm7eqmo2vpwvGSyWx9VwvVwXxezsOopJkbRl6z5l9/c9mbeP?=
 =?us-ascii?Q?CD7TRBKRStryT4wJPNyhQKPRl1gj0rncR2RQX6dL9MRJTRZ03fxc35fGysyG?=
 =?us-ascii?Q?RlNkm6xa8EJ/hOdk8sm0pmXjuXUXrHV5XNZjtEdOjeQMzrmV7Z30YsKvr+or?=
 =?us-ascii?Q?zd8lR+rVfy60c6m3sT9gjIwv2eyFZ9JfUVvK3WbKQaYmP7qUT8oXZp/GS01m?=
 =?us-ascii?Q?sZwRltGFmfxRlOzvh9VRmm7QZoKefJTAetZuRr//+Ek/DcU2ksSGH1d1K0oO?=
 =?us-ascii?Q?YrDCqMadSDKG1XTLSMKKaouhN7fsN+VWFXTuUg+vuoRp9NFVjzHGe9M+nWGb?=
 =?us-ascii?Q?tUllLbzJzEWa14Ll/aGgZqBpnJ9bhrWsHf+mvkOPMrq6oqxeqcI3WHgPep8U?=
 =?us-ascii?Q?dk5sro3KANz2ttCN4+AIRv5Aj899D/66dWxT5K8BdrgSfmXVlZ6MJS3nxYu7?=
 =?us-ascii?Q?1LQtQ4IrQAulUWs9RLp3ZApa21kCQvsfJaf0IlVxiH1NC/bp23NV54KawsQI?=
 =?us-ascii?Q?aJ7wTI6AOGq97F2h8MyXDqPsOsORZ4PlxVb/WPl8aScPStah0t2qFgzpNBfM?=
 =?us-ascii?Q?AsdCkGjhGg2iD/dKAKEJM6O2pgeZANYz8rwj21uNa4a7vo53lC82RAioplm7?=
 =?us-ascii?Q?RQyJtS3JRo+aul4JIrnbmA+uKmOxl0si0UxKsJU6OWplr2a/gWhoC0WIxDJX?=
 =?us-ascii?Q?KigX89VOjqihzbXkG5pe9DBt06PakXMRWK2lPgKHunf8rdVYI6qqwaPpmBaq?=
 =?us-ascii?Q?yhzIXshrGRyJNkwlkdPzj1RZNxfgojbdy/TUO+d9WER03CSLl3eZopLf4r6Z?=
 =?us-ascii?Q?ZlzSAGgd2Eg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Vw64488zcuOaCC96Ts3I+xVzklV/ONmVA4Uv/HgTvHAXEiLW9rU1J7CdVSk?=
 =?us-ascii?Q?KHC9zAAe2aUk0grcoGz/oR1AGOFOLUOGlNOCUfgZl+mXr+cUwPEXgwxU0CJS?=
 =?us-ascii?Q?pVmH9dzlTbgw+0W9zd4XYQ3yMTC9UmGtZ/qwYwhHeO+5sOjwv3SA2eWRL7Qg?=
 =?us-ascii?Q?PxOmuM9WI63bw+X0Ahk7gb7C36vogvD0I7F33Le1++P1cHaDFffbmJGmpaWE?=
 =?us-ascii?Q?yQ4buStavftmi6ChGiqa+7ECq7SxtXCKm2S0/Fb/aqLN8x6pe1uFwaJrCW6s?=
 =?us-ascii?Q?jWNPbn90+CuM5qqCgbnlrVod19+v5xSvPC739hPDfUtOc5ti9Lbl3QmFpgea?=
 =?us-ascii?Q?H6naPUuBSk2Nw54U40M/E51ABcyrridZN73OeS+X/wHbszWmBSqBNpJQZjkI?=
 =?us-ascii?Q?Fwm3tHsla5sMyxaJ+CQxV3NTeJH+Jagaz6AVsHsMsAZfpPBj9tvnPo8CcjqZ?=
 =?us-ascii?Q?de1HP2xHfsO0rEyqOuhc/3tVrZifmgzyTemE0Ur9M94dgpe/p1A8dan4gDsB?=
 =?us-ascii?Q?K32gWVfm1IMcCDRyD2SFruxlExesSLPGJ1f807O+qScarI0wr+53whjd4HIj?=
 =?us-ascii?Q?zpILMgCqgDSXnLYLHACMoekPGICFtmb8OqqmYnJewEXfd6XNaina8OPsmPG1?=
 =?us-ascii?Q?28g5e3NAZBekRplp3V/Y70Qbmh3pfkjRE5urQDrvzs4z2o3jVFbas+D6Kze1?=
 =?us-ascii?Q?8XuoA1OnVOCHqHCejYW/L7uJAHlJESvRv9u9TOegiQKYkCzvtR4Kkl2FhBnX?=
 =?us-ascii?Q?TkNpVYlNaBAZH55DxLWVHOgO8spV/S7Nwr1rylFgH3pGxgircgad3Gd0duc4?=
 =?us-ascii?Q?A9EGSxp4YDbW6gNV5hIgZbYgLw+pgcuf4uBpAuY0ujXipAsob+wsX5TmzZz9?=
 =?us-ascii?Q?C8nhqaHfC6A5RkOoIoxHLY0xX8UB8amM/43yRMT0CEiZfJrlzQZYBwA5MWsZ?=
 =?us-ascii?Q?HzZa8y7HS14rWyDVGTmmOHQMhy5eq8/TeZuf5xj7goHmrG2I6vkZtSORqv7/?=
 =?us-ascii?Q?3YoHbk7FUu2v96S1FRE4QIHtURn3x6VwUCgqfcn2cBPCUEA2JuwAslMFECCh?=
 =?us-ascii?Q?am6qLdwQWP5xp1hpwHK0T1MrtcWzqvXNjc0dWLZkdJ0/bsuigyQ595xmC4n6?=
 =?us-ascii?Q?gl/fKUsN2KYs8yX1u1916jEJihPT8zphKa9gu4/bj3cDPHvYuJ0FqLZ41CDS?=
 =?us-ascii?Q?HudSbZJvu71EeB3Yxiu2aYWZFuSQ+6ocaAixkCoXG+J42V+ONU5Djodukgw0?=
 =?us-ascii?Q?NsMp7qzg+FTuxLZGdRgbq8X8LuqsltJpYRZMZrBXoiL+8ETjNyMQ2VCXKCdI?=
 =?us-ascii?Q?YVw/o0fmqSApW0B0IPrIvvnzAQmTCpBMkF7Kt+8QDAKG0qTT1Tp5+QLhDrOr?=
 =?us-ascii?Q?D7/5hK98sMWHjVOjWnCzzpvDDayIyK2nVNtS69JMWSYbs426NLBe0fhyN/v1?=
 =?us-ascii?Q?0yZPXKJZh+SsYA093hY/iVI6vu7zioQinpfsEWOMB+XXX/gaO1VkzTicHbzD?=
 =?us-ascii?Q?Tm4nLkD4FCbBFXnAtFnlBkEiKHeAB88/vbmAZpQr9rWlMGmbwJKH57SRqowW?=
 =?us-ascii?Q?owl2+7K9ZAM5fvlz629Bw+JlCKYqwhfqCL7NIaIjHUxqAbD4lFHUCpM84cC+?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf98b99-a7dd-4882-9e94-08dd931b2f05
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:11:52.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onyevdFAXX3Lize0RgYTNCG8/LrIWVVlvES0CM36ZtNZAtOvYy5sbQy75WhJUHaxJlDT8Xn73OjxBeCf7Ky5cuLrMOuofQC6wfUTgp+D6Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7016
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 04:19:13PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.2.1 Table 8-55, Common Event Record format
> has updated with LD-ID and ID of the device head fields.

This comment is less important now that I've opened the spec and looked
them up. In addition to a spec reference, please take a moment in this
commit message to describe the new fields and what they offer.

nit below -



> 
> Add updates for the above spec changes in the CXL events record and CXL
> common trace event implementation.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/trace.h | 22 ++++++++++++++++------
>  include/cxl/event.h      |  4 +++-
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 25ebfbc1616c..ce482e57a477 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -214,12 +214,16 @@ TRACE_EVENT(cxl_overflow,
>  #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
>  #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
>  #define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
> +#define CXL_EVENT_RECORD_FLAG_LD_ID_VALID	BIT(7)
> +#define CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID	BIT(8)
>  #define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
>  	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
>  	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
>  	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> -	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	},  \
> -	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }	\
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }, \
> +	{ CXL_EVENT_RECORD_FLAG_LD_ID_VALID,	"LD_ID_VALID" }, \
> +	{ CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID,	"HEAD_ID_VALID" } \
>  )

Is there some spurious changes above? I don't see why HW_REPLACE line 
needed an edit.

>  
>  /*
> @@ -247,7 +251,9 @@ TRACE_EVENT(cxl_overflow,
>  	__field(u64, hdr_timestamp)				\
>  	__field(u8, hdr_length)					\
>  	__field(u8, hdr_maint_op_class)				\
> -	__field(u8, hdr_maint_op_sub_class)
> +	__field(u8, hdr_maint_op_sub_class)			\
> +	__field(u16, hdr_ld_id)					\
> +	__field(u8, hdr_head_id)
>  
>  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
>  	__assign_str(memdev);				\
> @@ -260,18 +266,22 @@ TRACE_EVENT(cxl_overflow,
>  	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
>  	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
>  	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> -	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
> +	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class;		\
> +	__entry->hdr_ld_id = le16_to_cpu((hdr).ld_id);				\
> +	__entry->hdr_head_id = (hdr).head_id

clean

>  
>  #define CXL_EVT_TP_printk(fmt, ...) \
>  	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
>  		"len=%d flags='%s' handle=%x related_handle=%x "		\
> -		"maint_op_class=%u maint_op_sub_class=%u : " fmt,		\
> +		"maint_op_class=%u maint_op_sub_class=%u ld_id=%x "		\
> +		"head_id=%x : " fmt,						\

clean

>  		__get_str(memdev), __get_str(host), __entry->serial,		\
>  		cxl_event_log_type_str(__entry->log),				\
>  		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
>  		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
>  		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> -		__entry->hdr_maint_op_sub_class,	\
> +		__entry->hdr_maint_op_sub_class, __entry->hdr_ld_id,		\
> +		__entry->hdr_head_id,						\
>  		##__VA_ARGS__)

OK (only OK because I may have just started a new line to avoid the (-))

>  
>  TRACE_EVENT(cxl_generic_event,
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index f9ae1796da85..f4cb8568566b 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -19,7 +19,9 @@ struct cxl_event_record_hdr {
>  	__le64 timestamp;
>  	u8 maint_op_class;
>  	u8 maint_op_sub_class;
> -	u8 reserved[14];
> +	__le16 ld_id;
> +	u8 head_id;
> +	u8 reserved[11];
>  } __packed;

clean

>  
>  struct cxl_event_media_hdr {
> -- 
> 2.43.0
> 
