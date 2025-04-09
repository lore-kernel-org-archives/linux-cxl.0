Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807C20FAB6
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744228613; cv=fail; b=bw8hg24nvk+ZuRpSnd1hHq+lBGCGT7LXjzFH+4tH1oIRWPKAmkpTOjTEhSsXRgg63UZ7Mkg835KZC4HB7a5uRO2EGDd5t5MmFQnFgEVKqRNUkR7VAdgffKW+z5Lw4hOFfAFh0V13U6hSfgj3k+J713DspDuPeSnxnTJVUFlpnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744228613; c=relaxed/simple;
	bh=dSqdE1YvRhGgtZfrA6vmYj7je2oH7lO6IdWz5vH5mNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RlvfPRwsWVSptI+GtQ1gox1Dq1AlXMu/f4DzaIo/Ohe2AdZ8TpaYP3UgaqTnPKvRpvs3rd1d816veDCPu35FnQKyTZ3kEP9I4mkkZfKiYYDBnAMSFU7g7exCzhPF1G+qy9f6loxJd9h5Goo6y8XqeANWuhWV0Jl04huplxIvKmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNNTXXTe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNNTXXTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744228611; x=1775764611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dSqdE1YvRhGgtZfrA6vmYj7je2oH7lO6IdWz5vH5mNA=;
  b=TNNTXXTe3RjDzFpnxzlsMqYi2S1w+WPYZXh90hiccPiiNVD2Tu4csGgu
   BYkpJZDt3A/UnfhszBEVm7/5JEXD3DyP67iV4U9N16tQxS19L0emOYARf
   PpoL3T5RihuUMzUO6gJZA1dwvJkuvnBnGcCq8AVoHF/aaAVvzXAwvbiZb
   pyhF8SIkBykvveZXEoLjZrRWPLge84gte+kVjVuYw5VQreqNOGdaUKeJP
   fI+JRbR1xIhWS0DG6cNBo0CIBTvW65XPChl3hdPwD1pplb5j+ZSz7IzOf
   o925y4cd4epcpVoUnAkCLkrmkdh6rHFGtmA1Fy9UD7XoPKb7Jz+SGgJDS
   g==;
X-CSE-ConnectionGUID: V0DDLKUoRNmNliXDAoAghA==
X-CSE-MsgGUID: +/STUTT+T0GEI27wsWkkmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="33330544"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="33330544"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:56:50 -0700
X-CSE-ConnectionGUID: yBhIP0sUTdu6KfFrGlAAHg==
X-CSE-MsgGUID: TxK0iz2xR1W5ECmfzUHTaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129033370"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:56:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 12:56:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 12:56:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 12:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcPDJhvliCQvyCDDUVmbi98lcD0o+l9WGQeW9LMGO7Q4fh3unFJKv8yD5Fb55+qwRaXYPOwcS/gfQk3U24WCbSCGlrEpAob+EVilCgihpvet7smJvmUD7A9a2g3mLSpWnsyb5x9IQJT8TMi9feFc9Kwyo4PRXnADC4wy1tlkgzCy75lpTyg03HGMcetJaBSUNCU1NggaMU9PI5PGgpiLAoMEt9pQ+HnokuZi6WLnGJFHGVY/yEgJ5XC4Q4euGzdq1rqZOF1E9WeZeQtNB65iU9XqJGxMA93wIwPYBNcqj8qF0AUQ6TRjO9ucDrzaPK5wvxPdHyVx2bVK2CwqEu8V1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiQNEhyg4TIQwD3reyZpt5rTxS6nLR9kITdMrnkkIEY=;
 b=QMu+WRuYW0EiJeyFGvmZap9xqtGoEncqa00zSlvXlyctF4hMxCe3shEgdqJ4L0uiTRwaPSpXYwBVwd6bilnuUm52nNsrYq4YMw1KfuFEPRmUgAFv9CpOE6IwQ6LXcgjE1Sfv6t9cupWNUc+IXBLtDsGvShQcwcXcZQ33EG8iJ7XgLJCR/T1EeQSn/Dqg+zqjcUAUCkSUKcpnIl82WXf9TkNelRxKrKacgjcE1I96DCE3GE9SO3igxn4ZP7mH88C9jB5e2RrfGfw0Kq+el/FpGUp2OTE0lF8CETNT7Y3O3Tg7I3vNMn+7teI5/GQBn11sVODkCotL8SLJ3v6YDuHiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 19:56:46 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 19:56:46 +0000
Date: Wed, 9 Apr 2025 12:56:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [NDCTL PATCH v4 2/3] cxl: Enumerate major/minor of FWCTL char
 device
Message-ID: <Z_bQ-mo2QnxcVbOK@aschofie-mobl2.lan>
References: <20250218230116.2689627-1-dave.jiang@intel.com>
 <20250218230116.2689627-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218230116.2689627-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:303:86::21) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd9a231-b86f-49f2-7e6f-08dd77a0a84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V80VcAgMIELN/7GnwdbHYvL+47c702cltcf0XuaDbfjyY138VpyAoJjkh4Ke?=
 =?us-ascii?Q?16ITnjEkAwFJZgaPmabmJQzxX0nEJajbS4+LZEzkaTehr99J72KG4/huJHep?=
 =?us-ascii?Q?OFOMnkHzeXdVjx3G+oydgy4SqIT0ZeWG8X2g1C8pnqD2NDq37qRbk9Wv5uJU?=
 =?us-ascii?Q?DlxohiQXD77vCMiFJAHh3FCNDRR+RrnTZct5WU+ADSxHbQF1Wmx58RViRL9k?=
 =?us-ascii?Q?lNmczdrkTdcCUdNWudfLb9MsXfpbUKCYVX++URCAALIRpIhsFeCNE2zKZFFp?=
 =?us-ascii?Q?lmLac2q4eouxd4Fy00VUl2j6AE55Wkb6wEVnqFBVi44sShw+BjCXZ+i96Bdh?=
 =?us-ascii?Q?UpdJbibKUKiHsGVy/kWhaHYTknuVr2Ht19a1fZEtsKpl7bwwsvMUrjNmFGd2?=
 =?us-ascii?Q?hlM0Vu08CPcacQ80VJNfr2ckvFBw2ktBLPyN7V5kmga+bOJxK5OZ7x3HVG9I?=
 =?us-ascii?Q?Do4bWHEQ/VAEn39BAFE/H8TxF6N7EKhGl4GLJSlDc2XmSzsIMQb34dc1Nb57?=
 =?us-ascii?Q?vDeBQtg6PM7v2XpxBzBYwm5SRfIktpXPtXEnWONu1pnhauQzwq4gDkY1rwnW?=
 =?us-ascii?Q?WA/JJ5XQjvC4vukrMAsLNsA3sBgGmoAr4nJZ06MLDDcrfvp0F/2PqGslx+XV?=
 =?us-ascii?Q?y0VoQzMqUQyLxj68q2Ew3T4GshqaX3gGU1sQYcOudvR/PlXfrnUFlBRh+2MX?=
 =?us-ascii?Q?e0f/vnSTqfvM6LrZvA+brYW9jp79pvxAj1NbPNdTq91tFoCS325/OXNzZx8R?=
 =?us-ascii?Q?lIQCKj9dc06JDCAl5dAgSzlAT1fLkZt9Gr/W4n5QtgylX8D+krhYkaMahvXj?=
 =?us-ascii?Q?6NmpE0f8ZTasZerRVwFvEUqG8l3RiKOXCQ7Ul6ceqD3aD+9zLSnlF9O3OrxB?=
 =?us-ascii?Q?t+tWbX4Yn6STd0kx5jb4SlBWSzfpQj71fwPOix3W0ZpnwkNMrB8IWtRSf9Wj?=
 =?us-ascii?Q?WC8I3rOZWDwQaXoJR2QXPnpIH6dSpBfMR8J9P7GRR3A70on+3/n2gm6fETYH?=
 =?us-ascii?Q?WAjzzeJ57LldFqT00LJsW+N8botuiIQsSdNwRLymUsAjDLA9LHfgzGeuOsuE?=
 =?us-ascii?Q?ZqDIHgC+QRtno7Tpexpl8Z4O+M7dNV5LsevI4AexVbE3p/jqSRalRApbJhjw?=
 =?us-ascii?Q?jXnLLgvISTs+P9XeO1el+nRz4eymydY+wgT6UKtrWCBREM3hKNzilNuiaRqc?=
 =?us-ascii?Q?Ol11E7o3VFcSRxgmiYRnTp5bxvyNgah5CNhYsWOklO/QoTrl19OSupuoNaAH?=
 =?us-ascii?Q?LAeKflC48qIk3QA4ThWMS6fMmNdmSLYkd4Ez6zRod/dDiydZysKQYd71eTPS?=
 =?us-ascii?Q?1GOxGNb7U0l03vGN56TLAk8zH0oBobCMS+9WrRyb/4lU1QhpkdJdPelmLsNq?=
 =?us-ascii?Q?bHjetqUEcgrcqKWu7RplFRaTn2FMf9Vuib9PaLN6k33RHD1w5aRCFpyJv+0y?=
 =?us-ascii?Q?vhimftM+5vY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/j/8Eu1VkQd6TEnjNODpqPuG0gb+LpqWDA9U9jpvjR+rCHZ+0N0qBkzigfm?=
 =?us-ascii?Q?7qZENrfWeuH0K2R7p1gqyqgPk5d1UAbdXjrA1u+EA8EMUDnxuhX1fA4bJhk3?=
 =?us-ascii?Q?M3akuF9i04Z/4kqocGbPPGgc45aar0iaQTi6Os6LsSCo1Uy96RYrL5fri0Ps?=
 =?us-ascii?Q?TmfhJXfiYeXrjPslQXqqNFMdCopuFHd/H/axaqkqp2jZRM7p4UOx59c4KPZI?=
 =?us-ascii?Q?U52AyobfZAfcLM+4IK/tbJPK+OKz97GMLX0YYv7RmST21RNkEsN8R+VefvT9?=
 =?us-ascii?Q?aY+1/SSro3toi1zEkOn9TyUoUIWWsIP1VRgFEAMYOwHvwlaKNVsjgb3rtj+2?=
 =?us-ascii?Q?w7qejXAL4Y3HBMF5lKMUUyy8KooTwUyYnmc4guhzK7IZKbglL0GRAQ5yvogk?=
 =?us-ascii?Q?RrQE4ukXhQmhLqnGe2bI2nKVSU2KqxLn4d4YrR0Qch/r6IvE+FQC25hi69Tw?=
 =?us-ascii?Q?/17nZZNebNFJLOVHIwpBpZj2IdzrKNf+H2o9ks3x7Qkxq1yo9HRS00rMMMg/?=
 =?us-ascii?Q?mhQYNr9bgTeIZXMHYlM988rp58Plf6Vek1VWdqTO0o6G/7TBK6/cmgLHiY0t?=
 =?us-ascii?Q?2GEMKZjGPUYKG3PQ0UqWLu9zh6ayGS5M+5Y3UPJmhNdRYvwhQPihRwe6mdyG?=
 =?us-ascii?Q?2DGBOIJa/uxrXPgT8Fbfp/TLBuK+TbghUi90ByzCas6ZJ9YgJZeLbpWMlKVs?=
 =?us-ascii?Q?9McWFYmFLAMudTtJfIPRoPxVrrNbmqRY5mwerjV0bbR8TmHM0kbhH1z26RRt?=
 =?us-ascii?Q?SE89P8ZJTOlgeAJR8vaLbTytF7zq+ECESb+XZT2rbxknIUGqcHipTZEYrYtM?=
 =?us-ascii?Q?D0EP3RzSJnlVbqDE29D79N9XkuLw3sb/zbeWmmOkmOtVzSLmoYS1Q2X/FYuQ?=
 =?us-ascii?Q?V1wb8U4itdn0TE1ezW8lQcLKVp7C5R0MEveJ8UBQWYumxJIzQa+NG2ThRIXV?=
 =?us-ascii?Q?IwdzsZ651O9lfG3lf5bkY1C1y4AbLhSFyUDS7/wvbjvVXL4nLjZVlIQZk9Lv?=
 =?us-ascii?Q?3vBrwsQ+hpAQ0jbWcIeeyWDAdbOwqR+bUI3Y5A2deqvrRfHLAtRMUXpOLK17?=
 =?us-ascii?Q?gnHTvkmL8fucgUGuFStwnbUZy6AKR1jcCaZ2VFaSpA+sggtql4q7J9D0Kyi4?=
 =?us-ascii?Q?p3qfDwpwh7xrv/fs/eAFvMEe9CW36JICyIfuLWwDVNDkrWSziYr38jveOQiH?=
 =?us-ascii?Q?+FCV/Kz6gBngKRnIfERHvAN2d1MPg8ECJXDOYk4mx8mOMyLdwPt1DL29T1xU?=
 =?us-ascii?Q?PPjMqKXN7EmdABuEZXfAp6ZU8kL2+aYWfrLlQU4MLiAs9wVuJICGeCVtPCq9?=
 =?us-ascii?Q?KdwhJaS+dnz1as/yijqfZrYEhK7fVW1oOvmK3pW4oqbR/L2s+WTLFpRwdBqy?=
 =?us-ascii?Q?PI7nQn4abV+h4j2+XyK8MiYqfQZVjFUCtsLeRxioGIUeChJjG5j1hz5KVSav?=
 =?us-ascii?Q?6PJTbsU/U1nijqGSYMW64lxuY4t0ug538cLPqPCcmfd2XMIfVte2oNamfXQC?=
 =?us-ascii?Q?iNlEfiHIL1QGP5NP0JkLoPeZhgB3kwVfhiIeZ9NmZ7V4z+PnXsirLVa/c6fR?=
 =?us-ascii?Q?wn+Ao1PERmhmVIuS8cw38envrQHO4z0fqPy8bZfdBkCIn+lH+v4u1GF8C1dQ?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd9a231-b86f-49f2-7e6f-08dd77a0a84c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 19:56:46.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kk84Z0B+fLK7XVtP/R3b2opep5gQMoyzcRNsJeaxD0UVJ8RKjnnE+xCLyEXtawczXoc/wRmCXgZC5eyv2f8Cy3/pb08IqvhdfrkWalSLyow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com

On Tue, Feb 18, 2025 at 03:59:55PM -0700, Dave Jiang wrote:
> Add major/minor discovery for the FWCTL character device that is associated
> with supprting CXL Features under the cxl_memdev. Add libcxl API functions
> to retrieve the major and minor of the FWCTL character device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/lib/libcxl.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  2 ++
>  cxl/lib/private.h  |  1 +
>  cxl/libcxl.h       |  2 ++
>  4 files changed, 79 insertions(+)

Please describe the new library interface in 
"Documentation/cxl/lib/libcxl.txt"

Add To: nvdimm@lists.linux.dev

> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index bab7343e8a4a..566870acb30a 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1253,6 +1253,66 @@ static int add_cxl_memdev_fwl(struct cxl_memdev *memdev,
>  	return -ENOMEM;
>  }
>  


Can we define like this:
#define CXL_PATH_MAX 512

and do this:
char path[CXL_PATH_MAX];

in next 2 funcs?

> +static const char fwctl_prefix[] = "fwctl";
> +static int get_feature_chardev(const char *base, char *chardev_path)
> +{
> +	char *path = calloc(1, strlen(base) + 100);
> +	struct dirent *entry;
> +	int rc = 0;
> +	DIR *dir;
> +
> +	if (!path)
> +		return -ENOMEM;
> +
> +	sprintf(path, "%s/fwctl/", base);
> +	dir = opendir(path);
> +	if (!dir) {
> +		rc = -errno;
> +		goto err;
> +	}
> +
> +	while ((entry = readdir(dir)) != NULL)
> +		if (strncmp(entry->d_name, fwctl_prefix, strlen(fwctl_prefix)) == 0)
> +			break;

Can we exit this while loop w entry not NULL, yet not a match?
Maybe a found flag or store a match separately.

> +
> +	if (!entry) {
> +		rc = -ENOENT;
> +		goto read_err;
> +	}
> +
> +	sprintf(chardev_path, "/dev/fwctl/%s", entry->d_name);
> +
> +read_err:
> +	closedir(dir);
> +err:
> +	free(path);
> +	return rc;
> +}
> +
> +static int memdev_get_fwctl_chardev(struct cxl_memdev *memdev,
> +				    const char *cxlmem_base)
> +{
> +	char *path = calloc(1, strlen(cxlmem_base) + 100);
> +	struct stat st;
> +	int rc;
> +

Do we need to init memdev->fwctl... to something to avoid garbage?


> +	rc = get_feature_chardev(cxlmem_base, path);
> +	if (rc)
> +		goto out;
> +
> +	if (stat(path, &st) < 0) {
> +		rc = -errno;
> +		goto out;
> +	}
> +
> +	memdev->fwctl_major = major(st.st_rdev);
> +	memdev->fwctl_minor = minor(st.st_rdev);
> +
> +out:
> +	free(path);
> +	return rc;
> +}
> +
>  static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>  {
>  	const char *devname = devpath_to_devname(cxlmem_base);
> @@ -1279,6 +1339,10 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
>  	memdev->major = major(st.st_rdev);
>  	memdev->minor = minor(st.st_rdev);
>  
> +	/* If this fails, no Features support. */
> +	if (memdev_get_fwctl_chardev(memdev, cxlmem_base))
> +		dbg(ctx, "%s: no Features support.\n", devname);
> +
>  	sprintf(path, "%s/pmem/size", cxlmem_base);
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>  		memdev->pmem_size = strtoull(buf, NULL, 0);
> @@ -1515,6 +1579,16 @@ CXL_EXPORT int cxl_memdev_get_minor(struct cxl_memdev *memdev)
>  	return memdev->minor;
>  }
>  
> +CXL_EXPORT int cxl_memdev_get_fwctl_major(struct cxl_memdev *memdev)
> +{
> +	return memdev->fwctl_major;
> +}
> +
> +CXL_EXPORT int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev)
> +{
> +	return memdev->fwctl_minor;
> +}
> +
>  CXL_EXPORT unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev)
>  {
>  	return memdev->pmem_size;
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 1fc33cc6e1a4..b2b51a72673c 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -292,4 +292,6 @@ global:
>  LIBCXL_9 {
>  global:
>  	cxl_bus_get_by_provider;
> +	cxl_memdev_get_fwctl_major;
> +	cxl_memdev_get_fwctl_minor;
>  } LIBECXL_8;
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index b6cd910e9335..676bf1573487 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -37,6 +37,7 @@ enum cxl_fwl_loading {
>  struct cxl_endpoint;
>  struct cxl_memdev {
>  	int id, major, minor;
> +	int fwctl_major, fwctl_minor;
>  	int numa_node;
>  	void *dev_buf;
>  	size_t buf_len;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 3b309968a808..26aa906740af 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -69,6 +69,8 @@ const char *cxl_memdev_get_host(struct cxl_memdev *memdev);
>  struct cxl_bus *cxl_memdev_get_bus(struct cxl_memdev *memdev);
>  int cxl_memdev_get_major(struct cxl_memdev *memdev);
>  int cxl_memdev_get_minor(struct cxl_memdev *memdev);
> +int cxl_memdev_get_fwctl_major(struct cxl_memdev *memdev);
> +int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev);
>  struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
>  unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
> -- 
> 2.48.1
> 
