Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC319343B;
	Wed,  7 May 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652719; cv=fail; b=Ks/yXSSTD6PX3TANsCQHSWhbUqAvYU0ZlRf0VZmX+ju35tu0ZGEZ1T6rsWTu0xPiCVRA4nZl9+jGL/qo1F0HCKndF09VzxiANdovemHEpLgfTfNBrdSmc/NTRrQ8TPKug3E1hwxe/tNuFr4Kwif3cwaUv4y4WYCD8Ebyg0H70PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652719; c=relaxed/simple;
	bh=e1Zun6n0+rwIXe1TMx+9q6o/rjoXqrd/H/ytMIYbaF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A97jwjB+jr2+BTClqlEB/nMwlV8ZGb7EQx+xT60V3mWBOUt41vRZpr0RxcMoGpHvb3X2IE5qfb4kjZIe9MqFGMaequxr4X/6WuBzEzZXlb+SFxXhi6uzKANmwuTpioMdQAxQGlX/uSxCrF5nD8kNAZ+2WqoemVxoJGnndAy8yuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNQ+M9iF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNQ+M9iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746652717; x=1778188717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e1Zun6n0+rwIXe1TMx+9q6o/rjoXqrd/H/ytMIYbaF8=;
  b=mNQ+M9iF85RJw9rS3jT0ErxZkZsEKzjq2C2/rLlO5nW6Nczf1RQXhn2j
   Do/BhjiaAwEepqWRWkDu4gH540aUIF2HeGt7cfbFPVG9NCx9Qbe/S5B0R
   AwbYIhJpZiDfnRjnNg61fo68ePvr0qQQ8FITBAfGQIgNmAfAlfR5e8Us7
   2ezcuSxn1r6ghG66BUFk9oKk0B/Ol23WgdKdOyk/x1NbHV6vhTZlx8RSZ
   deEbrftTZ8y6ZmMoqy/OpjxM0l7K1oLcl4OZi6XVh4xet/sEKl/56qXje
   oBYqSOcBalGLzTBIp9zcCtgAk1hNuOXSMCulfii1h7RhtdJEB9Ogvs+4g
   A==;
X-CSE-ConnectionGUID: klcvv11bRH+44Q6hm/JYwg==
X-CSE-MsgGUID: rB29VdpGSW24JPgyMWtW8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="70908556"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="70908556"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 14:18:37 -0700
X-CSE-ConnectionGUID: UQW4Mn2FQ1O80e5lCO0MXA==
X-CSE-MsgGUID: wYnHRDlXSfixbQJrQRg2Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="140848713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 14:18:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 14:18:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 14:18:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 14:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hInhrK5G5vXkcf/6aITLAr88uzLC1FShiZCbojt+xuJTNeM3Cfx6IslglbBlZL+LD9VdRr8ZX7/YOiyOjFQYQ3wr+Ig4m9MLeq0ay0l0ZzXLt0U/UWavHJJxQfe+vgMVq67e9/5/LrHtcoGBD59zRBnq/GaBjdEvsAOeDVP4jD6fIjw3jhKrvjj1713a0rTD8SEzPhF/20QB5X2f89vtixaKKrCKpK8CFs7EKfyVumMuEUl7M7pvd9Du2lLo6k3vfF2R3uAVECHG5NcVPRRpdRoSUDrpWy8+3yY+iGZNmB7+8mrGYMHtVQQE6PgHPkRcbe+ng5gQFfUtLxPIw5gzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKTCg3QJh1KHhK+cpuWlG+D77XUnWAJB0gzGiRqIBJw=;
 b=buhZVt/vPEaioBSRh15f4ASI56oLwTrN8+jmRvjy0+t9x0zGjzjddzrnEtznv9niUqWoqR82rO0DT7frS7Qgvd+FESzOO6snn2/2IpKyiRxxGADsUQWbpT0wRtVyS4I2zD2g1nKlN4vkxaKPvQatJ7EgYFTiWkwUQhRho15cKTIKFQhgXjjE3AHE5IL3tR7AqeSNE3y4TkGfCN4vSZzm48KfXc1gNmw55/Bz1rLXoO1sUXgXpWIaG5ZweDrbLQUnj0XZiClzj+CAuiRw8P9u7PssCQDfZlfZYl4+0hFYG7f8pBlAW5LD7SrQ1zrZ+ryLcW0596AEjGiDwgbPIpI2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB8939.namprd11.prod.outlook.com (2603:10b6:208:580::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 21:18:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 21:18:29 +0000
Date: Wed, 7 May 2025 14:18:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"Ingo Molnar" <mingo@kernel.org>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507093224.GD4439@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: b85005c7-a673-47d8-0d85-08dd8dacb656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dxOBDQ4zLm+Kr7M7J0k3unnlaGjqU0/lgZ+vxAU3j/NQvcv4oVGw0kh9wq6Q?=
 =?us-ascii?Q?elu/YDGRd3UWKDW8OGNj7/aaHQZYljDZkkIQa40o3iK93SmSd+dK6QCCzFn0?=
 =?us-ascii?Q?JDaapAyBwP91Gg27x5Zdz6h7umlckgBmj7u6v6gZYYpkvXfE+HKJyNUP+86c?=
 =?us-ascii?Q?h4cATdz4pCG/AV2YqqXc44tOd6azBDCps5bwqWfC23JJdBu6vTlZf6DOtvXl?=
 =?us-ascii?Q?kDXDwAMObll2S1YofxRM/pGcK7u+8lB2MooTfaDEdMACJRSe/9yNioDOh/zy?=
 =?us-ascii?Q?GyOi7RyB2PIYsMuSI1cElLEm++9mRLugb5+L6BX6z/Gb8AI9rcHANsuwY+OL?=
 =?us-ascii?Q?7dtWb58xEp6sDZ1HxOeWjV5/0m77oVSquUn58BExFUNrF2HzK6MCs1cMMT8F?=
 =?us-ascii?Q?J1l7I9HPNi//+HyMV7QCS4YLMepm6mVup4qa1+09GV5ISkRF73UrUubsRoXs?=
 =?us-ascii?Q?w1jhK0EM1nd763PuKnD9qKt5oOtYD1VkbMQ8ATWLIOdtZrJ2+plaMkQV9rS3?=
 =?us-ascii?Q?z6dQwCE+66M0LX23UIf6z1AeUNh7U6FXnwb17CZu1gHlLhoFtqtaQtkZAd+p?=
 =?us-ascii?Q?YZSsVjyWmqvedJuiQx8iW+d62VuAZxjmpsAMSSDgud7x3MeEXQBdUwiTdGwe?=
 =?us-ascii?Q?mwFMbEHO0p/NE1uuLx6oUH/F56Zf6Tp1PkYJZvA6RZfSV6EdBoAsh8LFkIFK?=
 =?us-ascii?Q?furDjJ8OoZXMpjn1K0Xhq7s+NStYyaMN+h8bqgTD2Ucarl+JPEW3LrX8yyRX?=
 =?us-ascii?Q?NHw3Yxf1M7HckCjtLUokHT8iKswutk0ZuSpBiBXYbcrZPGuLi5FwXsqHwIf5?=
 =?us-ascii?Q?v7oZDZ5GjnMwlt/dYGVpz2DGwV1/neMcGyzh5fW73BC+KO3z4sVoFl8wYTQm?=
 =?us-ascii?Q?dNpOMnTkd+JRd0bBmunff5FqfNRLs2diI2TyPPTSwqmxRbAZ4fzkJyDxQx2T?=
 =?us-ascii?Q?W87qiav7QqAV7+/6hHWdFkQHtFur+ENOlLeuSwjDMflNWuZcBlYKq5otoO92?=
 =?us-ascii?Q?ls4wuYhbAYmiRDzfNVRPm8VUUsV8grkgTbVw9pj6kgME+76AiS23OEjPRenU?=
 =?us-ascii?Q?skHx22BaYz4/XaGpgcFeLZYopnbz6YsSrpv1qSt1NIXBvGjObTj4/1NL1/zN?=
 =?us-ascii?Q?uoePnLEV8DxH+KC+mLrI5WRu84JS4GUgGpfqfW0g2M0bCSukKgLB1h0W1DHF?=
 =?us-ascii?Q?GsRfZyjeIiCNkeUI6WdHzv+hk7KTCyYQNUCG1aAEoiYeiNKL8uoqAA7f5KAd?=
 =?us-ascii?Q?ujLWYuXtHtFlp3DFOf1rMYV28kvDEcNHLl8WeUMCaKJi0Nfy7HUCNIqYjmAi?=
 =?us-ascii?Q?rDOaMtiaJAe4iyZ8vYn5qPvshiUPRSpWSskjAhMLeMgOHm8OyoX2xksz/f4w?=
 =?us-ascii?Q?IzZo161iNsBeoXkEqiCOJIb3HmRdVG8Ow/pINP6e/VoZXE0UaWgRHBChVUGl?=
 =?us-ascii?Q?2+UyP3qIrDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sDZTPIu/sykizu6RB7ZBXMusb9eJzSkD72+tWKrxWsBinE8QUyXtFKyiwTyR?=
 =?us-ascii?Q?7EqUHsybJgT9uKPYUxAMGDmZQV03sjJSw8e3W9NrDi+AQdMCmzOn8+S0JHn+?=
 =?us-ascii?Q?YOPnASCWGU8Lk6OZhSWk/RlccOqgS4ODdoXbrIaZUUuDwClc8L9SxXkG74IK?=
 =?us-ascii?Q?W38qWZ3qhRAN4a5RqXasA/VOX1jCUSMdsVWGNAr7WRCyhk8+341FNKgB8RBN?=
 =?us-ascii?Q?0kJy8AzuliagOzCEywe5w1/bTO6m4FdWyyODvLonE23S/5SAgz+Mq1SfQNUK?=
 =?us-ascii?Q?w3m8OoJJ2Uabh2usTzBGWSwZaX8D9J2NVBK0HBwuTuU6NYMpqzYw6lPIfnYM?=
 =?us-ascii?Q?JZvUCNfTL5peoLPi1TJKJHQ73sj9+A658iY6Edyow0dHmtzOg+TuVGm31283?=
 =?us-ascii?Q?/q+hjJQ1yBOztPEG/fgQIuNSv9wkH6ZbI5cZstmW8FwfKSI4FuPFwosPfYBG?=
 =?us-ascii?Q?Ece2Df8j6WSi0WI2BER49WNGOygu5nH8Vk7vzJI4n+5OM5wIJaLeRcMM0IL3?=
 =?us-ascii?Q?8jp8iEqooUHqNT/BBTAoN3jSfjn6EXtCNI8C55xrq6d163CXH3RQGkArH21e?=
 =?us-ascii?Q?UV14muyuQ/JtN+lFFRyL95Wdhqc81tOq9sOcyC5pnT8PT3ScZ7ZdNwb5qyZ5?=
 =?us-ascii?Q?Ts0uDkhRYciax/+WFGk+0QhtYLJuXQ5VC/3SSlZCp0KU09XIXm2zy3l8e+9k?=
 =?us-ascii?Q?94V1MKB2uvGfI/tvyE7jiAz+BjaZjnimDOygBaF+kAiFDvDPIDEv9c6PKbcD?=
 =?us-ascii?Q?Qn7hqqhNK9I3iUGhD+zYc6MMJ1utIFVKIL0SJys2/L+0thxxMEX1/kWgMOEK?=
 =?us-ascii?Q?cnSJ3nx46YiEUF+XXk2W5Ummg6tBAM6vaosCwVWk8tPzMSCRIkAk4+pZXZIW?=
 =?us-ascii?Q?588gO5zmLEUzCBVc2D95l69i8d4i50h6tYkO8gwK6piPPs/UBCi03xevHWKW?=
 =?us-ascii?Q?rRvYLWoGOHLWzglNjMIEsU9E9cYUwQLd1Vh8m85uJCroMZGhvDa0o2/2axPy?=
 =?us-ascii?Q?CTSk2NpSbgk7kj/rEgYyZxsTHAjWMcNcAw6Iy17ajFeF8KWmowmCqX/HF/Mk?=
 =?us-ascii?Q?YjL0A11Llt88y5t98Bmk/JPJUY7bW66Nql4014VWsgtGRSR4ATT1Uu7Pdabl?=
 =?us-ascii?Q?xS452xB4gia3qw7f520ucnNxZI6yYyu8k4uaIlEenx3IFwV6pNRWLuee6KgR?=
 =?us-ascii?Q?r7qti3uoCk2BYC3zGGfQ3OloSY+acpwHPb2MOagvUjTQZAXbwa7oq1IVLS4K?=
 =?us-ascii?Q?KUWDUZqHcFcllBKmanOB48iO54RI0h/b40yvXHNsKnzzW6ulWU0s5X6GltEq?=
 =?us-ascii?Q?dQ/yaEdIRgmXDvpvDrgfYnW0NqKYPhHf8c4uUwskCdIvx8Z5wlagYlC/tge/?=
 =?us-ascii?Q?N2f8eIC+OMeLMekIs8YjaHY1KJcJQh5rjV8mFvX++MfgNEATD2xQ/2i8kmun?=
 =?us-ascii?Q?YFUcK2HygLmLEyHA5EX/LjDVHt6ONQCcxlgfIMVnO3d+aZP1QaCA2vwh7jvG?=
 =?us-ascii?Q?eaI9fJrn8IcQDRPGbVrfONt3cxTrAmFdEI3vyozDd9PXs4CFyKoIDrQ8TNTf?=
 =?us-ascii?Q?EZu9ZrTQMmPJD+52nM7i2uqR+hwplttySbdml2i0DSJ9Q5DDLgYeVPbNRkWE?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b85005c7-a673-47d8-0d85-08dd8dacb656
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 21:18:29.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKSlRNtatCLTP2Z5qZqVg3v/YNvZmveOTb5rZah2ZhmepJQENMIantDGXCdrTFf6tOFeMcqe6QcQ1KQ/wbK/+yar16842KFz6QlZ1peK5II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8939
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
[..]
> > @@ -202,6 +204,28 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> >  DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
> >  DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
> >  
> > +/* mutex type that only implements scope-based unlock */
> > +struct mutex_acquire {
> > +	/* private: */
> > +	struct mutex mutex;
> > +};
> > +DEFINE_GUARD(mutex_acquire, struct mutex_acquire *, mutex_lock(&_T->mutex),
> > +	     mutex_unlock(&_T->mutex))
> > +DEFINE_GUARD_COND(mutex_acquire, _try, mutex_trylock(&_T->mutex))
> > +DEFINE_GUARD_COND(mutex_acquire, _intr, mutex_lock_interruptible(&_T->mutex) == 0)
> > +DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
> > +	       mutex_lock_interruptible)
> > +
> > +static inline int mutex_try_or_busy(struct mutex *lock)
> > +{
> > +	int ret[] = { -EBUSY, 0 };
> > +
> > +	return ret[mutex_trylock(lock)];
> > +}
> > +
> > +DEFINE_ACQUIRE(mutex_try_acquire, mutex, mutex_unlock,
> > +	       mutex_try_or_busy)
> > +
> >  extern unsigned long mutex_get_owner(struct mutex *lock);
> >  
> >  #endif /* __LINUX_MUTEX_H */
> 
> I'm terribly confused...

I suspect the disconnect is that this proposal adds safety where guard()
does not today. That was driven by the mistake that Linus caught in the
RFC [1]

	at the same time I note that your patch is horribly broken. Look
	at your change to drivers/cxl/core/mbox.c: you made it use
	
	+       struct mutex *lock __drop(mutex_unlock) =
	+               mutex_intr_acquire(&mds->poison.lock);
	
	but then you didn't remove the existing unlocking, so that
	function still has

[1]: http://lore.kernel.org/CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com

I.e. in my haste I forgot to cleanup a straggling open-coded
mutex_unlock(), but that is something the compiler warns about iff we
switch to parallel primitive universe.

> What's wrong with:
> 
> 	CLASS(mutex_intr, lock)(&foo);
> 	if (IS_ERR(__guard_ptr(mutex_intr)(lock)))
> 		return __guard_ptr(mutex_intr)(lock);

__guard_ptr() returns NULL on error, not an ERR_PTR, but I get the gist.

> I mean, yeah __guard_ptr(mutex_intr) doesn't really roll of the tongue,
> but if that is the whole objection, surely we can try and fix that bit
> instead of building an entire parallel set of primitives.

Yes, the "entire set of parallel primitives" was the least confident
part of this proposal, but the more I look, that is a feature (albeit
inelegant) not a bug.

Today one can write:

    guard(mutex_intr)(&lock);
    ...
    mutex_unlock(lock);

...and the compiler does not tell you that the lock may not even be held
upon return, nor that this is unlocking a lock that will also be
unlocked when @lock goes out of scope.

The only type safety today is the BUILD_BUG_ON() in scoped_cond_guard()
when passing in the wrong lock class.

So the proposal is, if you know what you are doing, or have a need to
switch back and forth between scope-based and explicit unlock for a give
lock, use the base primitives. If instead you want to fully convert to
scope-based lock management (excise all explicit unlock() calls) *and*
you want the compiler to validate the conversion, switch to the _acquire
parallel universe.

> Notably, you're going to be running into trouble the moment you want to
> use your acquire stuff on things like raw_spin_trylock_irqsave(),
> because all that already wraps the return type, in order to hide the
> flags thing etc.

I think that is solvable, but only with a new DEFINE_LOCK_GUARD_1() that
knows that the @lock member of class_##name##_t needs to be cast to the
base lock type.
