Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839701E5B6B
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032939; cv=fail; b=AMdVqjZnEOFHaWeWJa20QaLfbwtQCz8PMiePjUEQcw2dT342GwEnnsvSfEZk5WZGq2rb2mAdxtrlDSEuWPwQrdsiRD9gH/K3ES4AHYhFvP/odMmL30E36kQHXKKhm3j+V8GKDUzU7m/qxlmf3NBHt+Oa+FPOzT/FPKzv3l1J56E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032939; c=relaxed/simple;
	bh=D+lGAdOJ+dk3JSXe62tgNADcgF9792eejclCgaawr/I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bx3kddxXSO5vDReCWioCncD2UlLVwXSAneke0BvOrEUGK0d5nsfvWO6Uvbubt3CO0hceskyl113mFxT7bhYmo8IRfcgSpODfut6316WLdA20TVHvh5t/X9kpFJhXAK8utamD613N9n0gJea8GwrYGLR8NL4EMi8ENgx1uHQ3D48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPGhplYI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPGhplYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741032936; x=1772568936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D+lGAdOJ+dk3JSXe62tgNADcgF9792eejclCgaawr/I=;
  b=nPGhplYIRsW+Zk92lsNDVl58+u+3XWKrBsEK1mczz237CAkWijnzNl4u
   00h13duUaZNFTppbMHG2xFJ+auqx+dW/UN3i7i/I4DizekA1ryFhDWljr
   42GODCM0yS+yGTscGbavf6fExuzujVTSyUdydzfYL37/FBVGKdJQzH5Ml
   +GCPdxoygCukOjqhLVHb7b8scqA4Vs9H5svOONaTzczqkHCHvKDTdbn1E
   +cpSpIuAgbG4XP/X86LyHc3EQP4jiDCPYQ2XRM35IIHYY0fWptLRc9Nf8
   PJGkagCWTPIWR7C7tioC5BgRQFPS/l7eqmwjPKZHM0ezbWXb1sB7IviCk
   Q==;
X-CSE-ConnectionGUID: j7iyY/x0TdS2vWrNgM5ZVg==
X-CSE-MsgGUID: EoWmvwegR8yyYmLPI+/2Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45575939"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45575939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 12:15:35 -0800
X-CSE-ConnectionGUID: VZrH03+OTd2iovVW5Ak77g==
X-CSE-MsgGUID: mXW/ddiVRWmGewqZFaV4Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122279652"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 12:15:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:15:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 12:15:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 12:15:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLNG9BERnbssFMQu+crn0xeYhLm+Y51c/g9mkZI9lnKz3HnqSp7qPtwSYgWmMw7MpqY2jweKXu8OSZwNVHxw+PMD0RVV0Yidom0YJ6+YugiT2omXvedWjv6xqNvCvjqj7ZQS983Rnnpuo+cxvHC4111XPNTNaDa9QH6+CW5E52RctacKsfHOC7VJFGPtO5zWnx5tbys5lHdVCARgsAcPIoMSNfNsS4Y0H3+w41v5Jgq1sJp8qKFYj7Eb1Ylqercbw6AGMgT0oQoTLoxhttOy2xACYxk8t5gFlUWTmPZ//pGsJlZtNzdRbTNCG72zu8E1N8Le0LFI5rM66IvWvSEtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF4/KYf5NRn9wTExaEcMmpoSE9IRHHH1CnvClaPzWx0=;
 b=XAy6zhAKMA3lz1HPRXZnVaLJMdoDi01ROzN1RuNf4ryNB+2VJ4/XbWnV0+KD8SSzWeFHOz7LCcV0xEFQvWjp0YOxoN2QAgt678LxdX451aM4LYTLXTI/5SZv0Gu0FvSCUT9PeNqBEJ47nsNecC0X39p13NED6DaYvtij/8wtmHlArrkb0qd5Sk0nBJgfYPL4xilL/hS/lA5QLANSpVL3E6IJPXr6lKqAZH4TVhljfT5hH32Ehunm0BRkGFWsplE5/+QmMV+Evcn+DVvmvz7ufJUT1h3d1nlQOPs8akCKfD+djHLl4dVx0/76oDJgSKJYe2oa/MosaizAf4dU4ks2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 20:15:32 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:15:32 +0000
Date: Mon, 3 Mar 2025 12:15:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC type cxl initialization 1/2] cxl: add type2 device basic
 support
Message-ID: <67c60de1d2a7d_1a7f2944@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA1PR11MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7aaa85-b4e2-4b7e-cfb8-08dd5a902637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aVzNSmVux3vfIBlz8JC4YOvHx6NxN9SFcXMdvlnqXs83ndkM3wdUf6b51ye8?=
 =?us-ascii?Q?aN+ATywdYeQ50kDjd0XqFua4P3PE+7EtN/1tRvdEHzVKukrKYeGeQ+q/ng9T?=
 =?us-ascii?Q?WjMMTnkdPnVJF2t5mhhF7ygqajHmfXoY/d6hOB9Fb023IyBJg44z0T1Tw40x?=
 =?us-ascii?Q?GnGwUuZvJ659Y9P/xOLOaMFSSFLzJ+blPTKM08jTTwmheU/HVofocv32iPLp?=
 =?us-ascii?Q?c3PRRPWIK1VFBf8mozs/5/cMZ3yqnUC5Q1K4JeZ+hBs6okOtjnQ1o26w2lfs?=
 =?us-ascii?Q?+gyHLrErld2lZeSIxr6+Q2BuZxcjM58W9nqeAx7e+H8HQtaCNtfVjwEXdFY7?=
 =?us-ascii?Q?ny/Rf1OGzZ/HbA/13pAA1w7Oq+HEzYUL1fRaqaGkYFHrCtjeF5DSXfMgkrXD?=
 =?us-ascii?Q?r6zNAuuBpO8qoa2d0s1iD/+mrgva6mrEoES7L2+IMU5y0ZkzwaWgNyfWYrGj?=
 =?us-ascii?Q?mderaJn7dQMqp4ByISHwY+0A2cyeY5vsQSPiFcrNWUe+28lTYyTW4bdlqQUu?=
 =?us-ascii?Q?lP89T6AWWZIUYKXPORR+98Zma5PTYOTjJImM1vjGGcjaJpEN1IxHrNnw9/rq?=
 =?us-ascii?Q?mH5NA0G/KJj9R8LuhkAA/GyNL//y3jEoLySMoKo57AKmaZ2d+an8mA0GX4YU?=
 =?us-ascii?Q?3aL350abJ3wAEdpPUGgsQislD2Q69v84LV9eW+2IpjGU+mLgOLWZ+bZeY76u?=
 =?us-ascii?Q?k40hz4To2BrOnN/T/avO9cuu8I62JJBi5xGhDyetwPEXiacFW+2wQrlrFW3w?=
 =?us-ascii?Q?hXMyt9AYLSRiuSSxx0wW8DecXXPyI5pm/5Y6qOK4/S/LTJA77t9JGe4CvBEM?=
 =?us-ascii?Q?Ax7vKgAFsIeP0Fn4QZQrDrijUm/ZCBl+1Vzd5aLbiG7X3XkT7NkVt31tmjiZ?=
 =?us-ascii?Q?/PLRgm1z9ZvdUk56fOoiODslSCXkj+NTcIDqYJbm4RHCwJmJYoHLYIrEHOgF?=
 =?us-ascii?Q?um3j6f2AdnAeC806VGq964hemAmVroW5MHzplxoJbGBtdL+sz+d0TlvVvO/V?=
 =?us-ascii?Q?gzS3au72oGTROAu1osem88wvJsJKKKASKW6crBA0E+Hh4JoJDC6vajfzn4/4?=
 =?us-ascii?Q?I5pkiQbXQKGbfet8AtMYAkjOO/EyDVhtHSg51Wn7S6EB19BBQwDkKS8paDbm?=
 =?us-ascii?Q?+qq9nYZZRRxxCNeTCyVcp4eIyGWKTpr04eT6DZTPKpYiCeBZ1JrRlhadfzFI?=
 =?us-ascii?Q?lYJT6iDVs+WXn+V+9CfhpUQSqTJKNP3kEgsikNq8Xt+EaA/ke5UOHenFhV4i?=
 =?us-ascii?Q?zZ6L9xnVd9Nwgvqj7Y2hqn/l63O85zOoG2HRlMWGiNGY6O2guRmOZgg70q1W?=
 =?us-ascii?Q?woz41VPMPoVHELwNHrzUGCz89RlSynVeQNGwegABIh40WjJmEqU8eH8r01Y2?=
 =?us-ascii?Q?kj9V8XLu6llwsZWsY5rjlcStUnCM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TxHpVIqQEx1V/yoZSa5QK68z/I2ffaNUFX2s+50QcOZOyKoVyjPBe6bOLWih?=
 =?us-ascii?Q?lk/lYTZgWqwnb2hKSnf299ZJvFNBW8TLNIfQyQPLb2/K29wrYJy6DIG863gr?=
 =?us-ascii?Q?6ppDMC2qoGcWnQ0Na0AZsKnIb9oTlL1OXvjuJxdLa8r4De13/nRXNbf9fEpo?=
 =?us-ascii?Q?RrDi4oo8wusnKwBrFscmVxJvk2l1I0KkfYglKqlP4EFQkrpJobnHCcawQB4W?=
 =?us-ascii?Q?xWcn6/vmtidWsZ3dDBJRJ6eFtPeDXUqJp0PigopRhAzOpkMHe9gAiWXhD8Dy?=
 =?us-ascii?Q?ai+Dpm50fcfYjP8iousrJ6K7ovyMCjlZsTv4Em41tdrAOE3SF4wcLx45ocfV?=
 =?us-ascii?Q?uersm3nUl96DNATirTLkAoWRH5IZ5r/9ZH0FbDmsNQAndRlAnsyxsZThgfGl?=
 =?us-ascii?Q?BSylk/xKbzd6gtCLD0+dTx7ZYChgce+m3TokO6Y7GgYubReg7I/HJg1Ddq07?=
 =?us-ascii?Q?8s+8mMIASbmb46snSXSz6y2FWzGHUSo6vl7flYQaA+zNRUDC+QqPo4b0++QI?=
 =?us-ascii?Q?AFJQScN7mIKKgDmHifBbwDAug9B5wnA3yl1p6WrVjGKhWuqy5zF5xSH9EJ/P?=
 =?us-ascii?Q?snBOQD8hs58p/6Q116JRMD2KZ0UbvOIz/1mh/v1qApVsRs1GDp+qMXbRBp9K?=
 =?us-ascii?Q?Kxzj+VrAaoQMwGBJWCO7v4eQ1eJSKxnqLcsj8/6MV3wxJ4p8NuG55mwkzsw/?=
 =?us-ascii?Q?4Va82BBQ8ZsOWKslZCTWEIR3/XgSjUM6d1OZb5ZtcZFUnJeMse1q9RgRYuRv?=
 =?us-ascii?Q?gj2decUhpwqSon9hs+wI4u08TCX1Ik/BpGhplVmTzOLEidbgjn50S0YwJlqI?=
 =?us-ascii?Q?T7QZcvZKEVI955spnD8hKqFoNvQOcFDjWyC9QV+BI8nzrBk7LH9C+88sreLK?=
 =?us-ascii?Q?kVbwcJMBe0UaaCBPJvWfpl4A1ZMBGfBNo7BEIYANDPYA0dYwlsKM5TESWwk3?=
 =?us-ascii?Q?5ZWMmwWVH5ZlMAs/yZNe/AiOJMcj3rebwfGgObyqmI4iQfHSeWLJr4ASdbTx?=
 =?us-ascii?Q?Y+exnuWEY5kj9V4iblLUOkv22p3wUpngoTj7IJzMHiaemwRZrKu+/T0Y/bRD?=
 =?us-ascii?Q?/nJpx5r0tSxI+I1cK7/X4eGSJ7qkOIbqorH9ZVoNmaqvyRduS+5GX1AZD31C?=
 =?us-ascii?Q?qfOuJNiH3IZ+dZZCN17o2GzNIcxP7XuaoEPo8tqz2nimQuAiOrlIXavFR9zJ?=
 =?us-ascii?Q?/zHgsVUsjdaJp/I5rZ0pFkICQ5N4wb4z9WZ70YK6za1mAPoIQsDeLFb9e6aR?=
 =?us-ascii?Q?o2sv9ukSRmUKd6yVpUyqdQ1qEdpabZI0MjuZvgOP3b60+DbmsXMGqq4HmJ82?=
 =?us-ascii?Q?ETpslty116iudvOToDXC7oyh5BWRW4rXM4GVAV6nhdEyqD4VPmuiYA11jWZK?=
 =?us-ascii?Q?hrL6VQSEDtk5zCwdfQ8o1e7hcvhy2lPqruqzwDZEoWvq93Vv6f+NFNRA6Csx?=
 =?us-ascii?Q?eH/rt2I5uqHexvpXKtMldUQ8x/DL0LCsChLkeNDfgnMLUJ67b5rDDZ/0QbKO?=
 =?us-ascii?Q?Jy4Ry/vMbeI6vS7xeEG4FBdmwmnaNVC3UyRwZE3MxtUoyKVcrlKfoug7RLoU?=
 =?us-ascii?Q?4/H5t6u9zYsF9hSVbmSAp9sb3xUShk301YfRJUmmY9+JP8ffgiZb40jI7xRx?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7aaa85-b4e2-4b7e-cfb8-08dd5a902637
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:15:32.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLl2Rdr8oDOQdIv+9/H+DeM8O75JVB6rG6NSqM8qw+aBVDm7t7q4clQG5CO2885TLWtOZ0dPCeJBrN7ejlTpB+dooQS1Nm0YBsPoeF4khJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c   |   3 +-
>  drivers/cxl/core/memdev.c |  25 +++++
>  drivers/cxl/core/pci.c    |   1 +
>  drivers/cxl/core/regs.c   |   1 +
>  drivers/cxl/cxl.h         |  98 +----------------
>  drivers/cxl/cxlmem.h      | 108 +-----------------
>  drivers/cxl/cxlpci.h      |  21 ----
>  drivers/cxl/pci.c         |  17 +--
>  include/cxl/cxl.h         | 225 ++++++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h         |  23 ++++
>  10 files changed, 293 insertions(+), 229 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c5eedcae3b02..ae92db38a921 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1426,7 +1426,8 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;

I would ultimately expect that this starts to use the
cxl_dev_state_create() internally as well to keep those internals
common.

>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2914e3ff104b..14bd74823467 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -636,6 +636,31 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec)
> +{
> +	cxlds->dev = dev;
> +	cxlds->type = type;
> +	cxlds->serial = serial;
> +	cxlds->cxl_dvsec = dvsec;
> +	cxlds->reg_map.host = dev;
> +	cxlds->reg_map.resource = CXL_RESOURCE_NONE;

Let's take the opportunity to now use compound literal syntax which
immediately answers the question of whether any new or not included
fields are initialized. I.e.

    *cxlds = (struct cxl_dev_state) {
	.dev = dev,
	...
    };

> +}
> +
> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
> +					   u64 serial, u16 dvsec,
> +					   size_t size)
> +{
> +	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
> +
> +	if (!cxlds)
> +		return NULL;
> +
> +	cxl_dev_state_init(cxlds, dev, CXL_DEVTYPE_DEVMEM, serial, dvsec);

I expect the devtype will need to be passed in as _cxl_dev_state_create
can not assume memory expander vs an accelerator.

> +	return_ptr(cxlds);
> +}
> +EXPORT_SYMBOL_NS_GPL(_cxl_dev_state_create, "CXL");
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..36a1cf4e59fb 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <cxl/pci.h>
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 117c2e94c761..58a942a4946c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/pci.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <pmu.h>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..556b1ed24f0e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -9,8 +9,8 @@
>  #include <linux/notifier.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
> -#include <linux/node.h>
>  #include <linux/io.h>
> +#include <cxl/cxl.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -200,97 +200,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> -/*
> - * Using struct_group() allows for per register-block-type helper routines,
> - * without requiring block-type agnostic code to include the prefix.
> - */
> -struct cxl_regs {
> -	/*
> -	 * Common set of CXL Component register block base pointers
> -	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> -	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> -	 */
> -	struct_group_tagged(cxl_component_regs, component,
> -		void __iomem *hdm_decoder;
> -		void __iomem *ras;
> -	);
> -	/*
> -	 * Common set of CXL Device register block base pointers
> -	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> -	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> -	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> -	 */
> -	struct_group_tagged(cxl_device_regs, device_regs,
> -		void __iomem *status, *mbox, *memdev;
> -	);
> -
> -	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> -		void __iomem *pmu;
> -	);
> -
> -	/*
> -	 * RCH downstream port specific RAS register
> -	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rch_regs, rch_regs,
> -		void __iomem *dport_aer;
> -	);
> -
> -	/*
> -	 * RCD upstream port specific PCIe cap register
> -	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> -		void __iomem *rcd_pcie_cap;
> -	);
> -};
> -
> -struct cxl_reg_map {
> -	bool valid;
> -	int id;
> -	unsigned long offset;
> -	unsigned long size;
> -};
> -
> -struct cxl_component_reg_map {
> -	struct cxl_reg_map hdm_decoder;
> -	struct cxl_reg_map ras;
> -};
> -
> -struct cxl_device_reg_map {
> -	struct cxl_reg_map status;
> -	struct cxl_reg_map mbox;
> -	struct cxl_reg_map memdev;
> -};
> -
> -struct cxl_pmu_reg_map {
> -	struct cxl_reg_map pmu;
> -};
> -
> -/**
> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
> - * @host: device for devm operations and logging
> - * @base: virtual base of the register-block-BAR + @block_offset
> - * @resource: physical resource base of the register block
> - * @max_size: maximum mapping size to perform register search
> - * @reg_type: see enum cxl_regloc_type
> - * @component_map: cxl_reg_map for component registers
> - * @device_map: cxl_reg_maps for device registers
> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> - */
> -struct cxl_register_map {
> -	struct device *host;
> -	void __iomem *base;
> -	resource_size_t resource;
> -	resource_size_t max_size;
> -	u8 reg_type;
> -	union {
> -		struct cxl_component_reg_map component_map;
> -		struct cxl_device_reg_map device_map;
> -		struct cxl_pmu_reg_map pmu_map;
> -	};
> -};

Ok, all of the above make sense to move because they are needed to be
able to export the size. It would be nice for the follow on patches to
delineate which fields of 'struct cxl_dev_state' are expected to be
private to the CXL core.

> -
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> @@ -480,11 +389,6 @@ struct cxl_region_params {
>  	int nr_targets;
>  };
>  
> -enum cxl_partition_mode {
> -	CXL_PARTMODE_RAM,
> -	CXL_PARTMODE_PMEM,
> -};

Makes sense, this is exported as part of struct cxl_dpa_info.

> -
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8e1e46c348f5..0bdf581044da 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,9 +4,9 @@
>  #define __CXL_MEM_H__
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/pci.h>
> -#include <linux/cdev.h>
>  #include <linux/uuid.h>
>  #include <linux/node.h>
> +#include <cxl/cxl.h>
>  #include <cxl/event.h>
>  #include <cxl/mailbox.h>
>  #include "cxl.h"
> @@ -34,30 +34,6 @@
>  	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>  	 CXLMDEV_RESET_NEEDED_NOT)
>  
> -/**
> - * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
> - * @dev: driver core device object
> - * @cdev: char dev core object for ioctl operations
> - * @cxlds: The device state backing this device
> - * @detach_work: active memdev lost a port in its ancestry
> - * @cxl_nvb: coordinate removal of @cxl_nvd if present
> - * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
> - * @endpoint: connection to the CXL port topology for this memory device
> - * @id: id number of this memdev instance.
> - * @depth: endpoint port depth
> - */
> -struct cxl_memdev {
> -	struct device dev;
> -	struct cdev cdev;
> -	struct cxl_dev_state *cxlds;
> -	struct work_struct detach_work;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct cxl_nvdimm *cxl_nvd;
> -	struct cxl_port *endpoint;
> -	int id;
> -	int depth;
> -};

Why does this need to be public?

> -
>  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
>  {
>  	return container_of(dev, struct cxl_memdev, dev);
> @@ -357,83 +333,6 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> -/*
> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> - *			 HDM-DB, no requirement that this device implements a
> - *			 mailbox, or other memory-device-standard manageability
> - *			 flows.
> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> - *			   HDM-H and class-mandatory memory device registers
> - */
> -enum cxl_devtype {
> -	CXL_DEVTYPE_DEVMEM,
> -	CXL_DEVTYPE_CLASSMEM,
> -};
> -
> -/**
> - * struct cxl_dpa_perf - DPA performance property entry
> - * @dpa_range: range for DPA address
> - * @coord: QoS performance data (i.e. latency, bandwidth)
> - * @cdat_coord: raw QoS performance data from CDAT
> - * @qos_class: QoS Class cookies
> - */
> -struct cxl_dpa_perf {
> -	struct range dpa_range;
> -	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> -	int qos_class;
> -};
> -
> -/**
> - * struct cxl_dpa_partition - DPA partition descriptor
> - * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> - * @perf: performance attributes of the partition from CDAT
> - * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> - */
> -struct cxl_dpa_partition {
> -	struct resource res;
> -	struct cxl_dpa_perf perf;
> -	enum cxl_partition_mode mode;
> -};

Makes sense, this needs to go public with 'struct cxl_dev_state'.

> -
> -/**
> - * struct cxl_dev_state - The driver device state
> - *
> - * cxl_dev_state represents the CXL driver/device state.  It provides an
> - * interface to mailbox commands as well as some cached data about the device.
> - * Currently only memory devices are represented.
> - *
> - * @dev: The device associated with this CXL state
> - * @cxlmd: The device representing the CXL.mem capabilities of @dev
> - * @reg_map: component and ras register mapping parameters
> - * @regs: Parsed register blocks
> - * @cxl_dvsec: Offset to the PCIe device DVSEC
> - * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> - * @media_ready: Indicate whether the device media is usable
> - * @dpa_res: Overall DPA resource tree for the device
> - * @part: DPA partition array
> - * @nr_partitions: Number of DPA partitions
> - * @serial: PCIe Device Serial Number
> - * @type: Generic Memory Class device or Vendor Specific Memory device
> - * @cxl_mbox: CXL mailbox context
> - */
> -struct cxl_dev_state {
> -	struct device *dev;
> -	struct cxl_memdev *cxlmd;
> -	struct cxl_register_map reg_map;
> -	struct cxl_regs regs;
> -	int cxl_dvsec;
> -	bool rcd;
> -	bool media_ready;
> -	struct resource dpa_res;
> -	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> -	unsigned int nr_partitions;
> -	u64 serial;
> -	enum cxl_devtype type;
> -	struct cxl_mailbox cxl_mbox;
> -};

Ack.

> -
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -812,7 +711,10 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec);
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..570e53e26f11 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -7,29 +7,8 @@
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> -/*
> - * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification. Names are taken straight from the specification with "CXL" and
> - * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
> - */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
> -#define   CXL_DVSEC_CAP_OFFSET		0xA
> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)

Makes sense.

> -
>  #define CXL_DVSEC_RANGE_MAX		2
>  
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2c943a4de0a..006a0036e779 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
>  #include <linux/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
> @@ -911,6 +913,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	int rc, pmu_count;
>  	unsigned int i;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -924,19 +927,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	mds = cxl_memdev_state_create(&pdev->dev);
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		dev_warn(&pdev->dev,
> +			 "Device DVSEC not present, skip CXL.mem init\n");
> +
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> -		dev_warn(&pdev->dev,
> -			 "Device DVSEC not present, skip CXL.mem init\n");
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)

Looks good.
