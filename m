Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1E246BB9
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449292; cv=fail; b=iQQkLmXfDZ0NV0P0KkESy6vfuFMSKxh9FZ0RMfLJelhviKIUKDx75kZ2Q/Hh4v4c4k1fI3E5ZEZCN5gRynE7E4EVdTGEdPmMY88TuRO1lw2t6UQGGGh2eS5ECZm5tMy+taYZZ+5Wi4S7NnGhcMNSbcZ1IASEU+/swT+dbCzqgMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449292; c=relaxed/simple;
	bh=BRMYirKq+/6lZhBgBTXL04687hzHJOj3vt9vFLtCGGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwTW6m9Znai/a3RinTvrHJVxiQrmOXtHIVm3ko0gpbb2/N4r2tkc6g+9iGDChlRkyIZO7xnsjoQQtC4IRKeQnYzae1XHaA8JUR70tyS5uvHJPVZsb6WeITYujM6V0OTVNqaUYOg0zVQmL6nq0zn907/k7hiPKxibvI/Ay+YUq3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEs0wqqy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEs0wqqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756449290; x=1787985290;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BRMYirKq+/6lZhBgBTXL04687hzHJOj3vt9vFLtCGGY=;
  b=JEs0wqqyPa8MOw0/ruXkN4xCro+7fBloU2zE7wy/G+OzOH579Dd+FRUr
   dTXZw8Hloomyzy17Gd1PB/AKJjMMU+qVomgZYVjPiP66SBg1iQAxHlW8k
   vyk82Ulx3iC82ec+VYsxExfmVlhuu8djidsoJyX+1Fqn+HQ+o1O8McbLN
   Il67KhqJ8L166rkUrdOXhWG6kFWMQo4EgpUBqMLLhsvzJRrahTOQcHzkP
   I60otp114BR2LMnTfXc9fW5nef8ECO6fBQ8SV0Djlsg9AFLl5W9IQLJa2
   47yPTai9LZ8BJ1B92XZtGOY33ZV9xh6wKVbrRtt4IhFRcW8CovTulAwCJ
   A==;
X-CSE-ConnectionGUID: bzcLCzGnR8CAW4e8rmN2iA==
X-CSE-MsgGUID: CAfG6rzlT9StOLEvN8S/jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69326214"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69326214"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:34:50 -0700
X-CSE-ConnectionGUID: lJxip5yTQB2XwTWqMQzu0w==
X-CSE-MsgGUID: t8KKxieFSn6RWaY38Pt0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170697404"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:34:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:34:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:34:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:34:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzbvxo7+yjnLG7ZisFVt1SCSyaoOdTqGjjk4PQbS8yumYSRmzmQmOTonikWP3cWeaU8jFsxTo6DDMhk07pWcG5J5pmF9bQtmsZ4mdPB037r+H/2qEdax6TWuZoimxlJOKeCf+NEPsYrYYapzHm3bKr+dgNRmp/xPki2GZ+ZGmz15XcZi33OyusoZZOuc3EPhnqAvjQ5TppAyAWO6AQWXfFZcZT426IgypUnWURwEfpwQLtzkdQuK6kzhSNoBMAVDV1qrUMKDAi7zHXmkI42yiNMZcO0Wzg0NOqkQZ5ZiUUJBxtACcLguTxwXq3RmOdKvD+gTf1miLwjhRE1zKuzkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrkOkPLKDsaFHFL3f4aEaDetHdNiaDw4ARRnDZ+qRjc=;
 b=qmaxp8Au/KysfqW39dx/kLaSbhJlsSZai6xePRiEukFsSswQYH+kV5/sGlYoLFxJ/5nyquyJaRwXwxBpQTEY5c5ehSB2zg5klim+MQ2crn7O7sKr/tHtJXWETX1kHaFKLWb6jVueo7yHBW++n9mNavVEviQ+VLoqHaA9BRVtHdjjE4o/vRPu5O2r3ZCd3fXytfx/oGQXunYiYYk0AtSoDeXOAhDe73tqiOZED27aGRc5gFWMijzKNDFZ5MaHsIDY71vSCWXpCaOwMG1zgGPXTSCnBR3QULOz7NVwjRcyritwE1ZdOvsJ9MbIBZJLCkly0guXe/5jSCq32E4lw3alTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPFDA9EFDFDB.namprd11.prod.outlook.com (2603:10b6:f:fc02::55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 06:34:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%7]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 06:34:43 +0000
Date: Thu, 28 Aug 2025 23:34:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/region: Refactor address translation funcs for
 testing
Message-ID: <aLFJ_190Q1nkFcqM@aschofie-mobl2.lan>
References: <cover.1754291501.git.alison.schofield@intel.com>
 <d60d89dab66e1431bb2ff5cd7da1f0960bc2a057.1754291501.git.alison.schofield@intel.com>
 <04dbb916-f923-4bc7-82fb-7d1a98abff23@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04dbb916-f923-4bc7-82fb-7d1a98abff23@intel.com>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPFDA9EFDFDB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8c8747-f034-446b-23e7-08dde6c6235e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvx00Lk6sjSIt9ma0pAZA2/I/0nURmdJiurezv+2yst2LLB4QKIrEnAnR7L3?=
 =?us-ascii?Q?Sx8LFIJgFbZatbDZ2iWFtJxBMtRNwpkPC2Wd/IT31k0pDd1gqe8pofmJXQBF?=
 =?us-ascii?Q?mCH0hLEesecXxZadDryhXkzYwI2a6xzmw3Q07Wy+d+VanJkjTiKtpQ6GcV0D?=
 =?us-ascii?Q?bxy2MqXAsUIfn5nJY9dlAyUB2idC1ct8PKCCBd9akiQKsHV13nONlF6zyx0T?=
 =?us-ascii?Q?z7MQUECe9RUBR76l6LbcAhzty6aZD4AkTLajBzm6HnJ3BTi1sQ81iXN/bF48?=
 =?us-ascii?Q?6tArxu91c5QUeJHARLNGoL3UhTHYqTekKxWFej7hP9KEHsQ/JZc08C6UZVz5?=
 =?us-ascii?Q?8jP0g5sYM8yhc1Iba3PfYjzh65/JYOM9wxRXz7UnJeHmj98ZgAk6LHWQqDdR?=
 =?us-ascii?Q?5CxAePn/ZThnfY2uu4dYtyeQOntoCgrlJCKx3K+D0VhL5JST8+G7ERn/PGOm?=
 =?us-ascii?Q?wYN72cILXshDLEY7RflmTSWGh2CF7rgLXRanQZQNtLRx2oaojVh156R1Hems?=
 =?us-ascii?Q?bKCYhJ3mG0HUKen3c6n8mCWvsio4sB553r8/4ed5SdiGsb3zA9jycahlJmMF?=
 =?us-ascii?Q?BQljFONWAKN0sCIJ1AbvK+XNNXB9MlLTndk3whpHca8kOYHBbHooCJAabOx2?=
 =?us-ascii?Q?EuqLmzXZ4WssIUzzBNYVV10sER6/nXdGuDtduSVlfvqD7c9VGyzHaj356vD7?=
 =?us-ascii?Q?J5Z6Zbofh+l+xO+RwJnzIoNwNWVUaDuzEGKrkBSQnaQNCNDho9r1xu2rvaLG?=
 =?us-ascii?Q?VVyhBRIC6rX0GfR1aH4mphPcXwJIlaW0NkucShrKSj6DdYUMyO3FiCnoYwOw?=
 =?us-ascii?Q?U2mzbgYbXPgWZMpKQTS5NQt5+iol6h81KFRrMIb79QuGPXEHzYRzy5wCo6g9?=
 =?us-ascii?Q?s7+TEUwjO81wnO32k0/i1JfC4HYIlLFF4vntjSlllKjEuWr/ov+BqqjJCTup?=
 =?us-ascii?Q?eOSE+LYqCVNiMC/HfI/orYJXg9aK1t+yQ8EuZtrMXgDUgLBExr6pZYGQQ5+z?=
 =?us-ascii?Q?YzpGfUL8VImWM/SmPdU/4gkVEAqTT4F8ETEVu+REB964ThdBQjcwubexySel?=
 =?us-ascii?Q?YskhBmAf8BDKnsILuVzblJTOmDxWWOEfDqDu/hjyToV4L3Ygjmy3ICU1hvgh?=
 =?us-ascii?Q?j6HaGY7BRBZ97I+V1VErzUPUNlgozPk9u1lFOTC403slR0Iz3paq2yrCW8W1?=
 =?us-ascii?Q?0ItTIegAlz6/Yi1M8k7ARu+oEnZv/OXF2zqsiJQvX7GjVfbcI0yjMSde7AMh?=
 =?us-ascii?Q?+CyaLsnZKZRclwFbkEFqwr2jAhEZksv9JlUvQvsxHdKT8D59b1JNO5wHlakZ?=
 =?us-ascii?Q?+S5GFZyDjXJzUXnjER0XBlel1aaY7WVuMF/X1BW9HXCY08MzuF3KirWtc9sL?=
 =?us-ascii?Q?LbcxxPtv6uQ3xIxkm+BF+WnPdcCFPrD2n2xs5hYWrbpYFri+llQiX/NpszyR?=
 =?us-ascii?Q?x1HezQPmE24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dNgB0Yrb5dpp+yAfGx2C1VZOHwUVcujlSaWVcwsMhhsvU9V4SoF8t7xcRUjY?=
 =?us-ascii?Q?ubFT01+or3lXjozMXQNtiZAhjzeCD82+tnVEOhYjoxIIIddVQJHLoJrTbo+O?=
 =?us-ascii?Q?2Chle7ZKKG4Nx7v7wlf+7cOBNxoW7HLm6vru7EaDicM1yN6bRjPlYWMvcWzC?=
 =?us-ascii?Q?1c/ScA5K0eSbOuz3xDHJpVbcCbcbq2eqgpg85TrJQoLzoPOi9cvm1G2Drrw+?=
 =?us-ascii?Q?WpjcFTX7FBhiKEofaNBN+D4WKhFxyfuMXPUiN7NdG9tJwNVm/MPq2pBFS+yL?=
 =?us-ascii?Q?Q53vAATlFBPWJGUMhV21uyuSAjwwaay1keH8ujgrrdnwFRIEOG1VosG9zbus?=
 =?us-ascii?Q?jgfhbACwTyfCiuYc9avr4on2nyEoFqCU29Ml61RXGpNuloktztDXgKKR3Rvr?=
 =?us-ascii?Q?S3wtTtqx4Lf8AIUBQys05Dz+bneU62T2webHNJDDXcO3k3e2pF5eVEA/ZcAl?=
 =?us-ascii?Q?r1ESEmtJcBV6Uxozl/K+g5dpldWwEL5PEnApiXWbiXbfLW9DtbhPbpSLMjqK?=
 =?us-ascii?Q?fkAF0owyaNM2H4GqiIUV8M9TFL6taLCc+/KV/g5WAUsAIDP9z1M31I6ZstIM?=
 =?us-ascii?Q?NEmSpHuNOemp2zdON5yXCrkavmVCgWIfVddEuSXZK+tozUebkfZ8/+DDzJP2?=
 =?us-ascii?Q?Blhjm2BrqU+ObAdnaDHSDG2vcjfnd+qRHpKwiGvgSlmh0bQPeOBEBMq23VMQ?=
 =?us-ascii?Q?CYlfTrJSJVuzpYCB9zNZeDyV399zWTPUn0xUx3xlnxjZirUxF18tGvEv6npW?=
 =?us-ascii?Q?l7NKPh1ouF/K2nO14kgUjWZgkLWPDVIIp88tV00yKe8AgZMEOEpLBxlGvZvu?=
 =?us-ascii?Q?lfJdglHF7yuGJJGiQkS8G7kkoqXcD89ShcKNResPWtSQJ6R6ht4brH5uS54m?=
 =?us-ascii?Q?73Y/BtJ9YHbH7NdSH2RxBAtw/j7GxgV79Bf5NPeYwOxBqTqOKlajrXdN5Eue?=
 =?us-ascii?Q?gWaZxDYl8Z+YyDtWhy8UsEpvVOFfGSEHHdXRd85e+ZUDOgmAcybsNL81lOoj?=
 =?us-ascii?Q?uD2BuTxHkswNNuw6lF5HbhMB5RS8CGuvmQysW46xE1Ty16iTRwazfBm6hP9R?=
 =?us-ascii?Q?edXAmHcWLNsV48Vo8kgN4KM5i8jgQf1g/2pjBk3lU1KDtgCqa1qyakcOFe4X?=
 =?us-ascii?Q?okQ4xang9waRfa5ApCStFeYCSvPCHcs+Ilwws6vFzCBsJaHNfLn6AUvNGfdb?=
 =?us-ascii?Q?pc+gfGqDRs9m8G5TUJLk4RhTJG9f4sOMnp4FCMU4HybotmwGF9Cx9uaNlLm+?=
 =?us-ascii?Q?QrT10SpmUr6eHr5E9GJ3g/WW006jfS0pExNAAfN9t5m9z424shbsd1X8zZ70?=
 =?us-ascii?Q?NNrB0be7JZpGLKNTQKhu/g83Sjjk8CsNTVucBR2E78ryg6q8YCdYvx6YMiOc?=
 =?us-ascii?Q?W6gqqFM4mkj8czlmPkparRr6EgZgQw5hD10zguA+8rduKCI9xoW2bezV7tJI?=
 =?us-ascii?Q?ADkhnadq7gk6j+LQIzFzcWk2lbQVCNLtE8O6BrfrySc3R12syNMUKqLZlcHr?=
 =?us-ascii?Q?a9sX4vqjlNyCWOCrFsIewCcrSDlH8u0c00nvInmYcRJDRom6uVy6+AvEKvxg?=
 =?us-ascii?Q?wdAVGpRgipgvIAe4kF9QliZSkMss4bRdgq8iDkHld0SW++zOSab52Hq16CoG?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c8747-f034-446b-23e7-08dde6c6235e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:34:43.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMVVGT/C+hXjdIJawdethLsaRvoepiuXxgx/Niit9B/nab2JVdZeOLmgayQI6S+Ax6YKR4RByPt7avtgo1cQdb+Yzmsg0n2BUvQa7WJI8OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDA9EFDFDB
X-OriginatorOrg: intel.com

On Mon, Aug 11, 2025 at 09:00:44AM -0700, Dave Jiang wrote:
> 
> 
> On 8/4/25 1:52 AM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In preparation for adding a test module that exercises the address
> > translation calculations, extract the core calculations into stand-
> > alone functions that operate on base parameters without dependencies
> > on struct cxl_region.
> > 
> > This refactoring enables unit testing of the address translation logic
> > with controlled inputs, while maintaining identical functionality in
> > the existing code paths.
> > 
> > The moved code has only one change. In the new cxl_calculate_position()
> > eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
> > since the new function cannot depend upon struct cxl_region_params.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 145 +++++++++++++++++++++++---------------
> >  drivers/cxl/cxl.h         |   3 +
> >  2 files changed, 90 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 281a31df686f..ccee5049d700 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2929,13 +2929,91 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
> >  	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
> >  }
> >  
> > +u64 cxl_calculate_dpa_offset(u64 hpa_offset, u8 eiw, u16 eig)
> > +{
> > +	u64 dpa_offset, bits_lower, bits_upper, temp;
> > +
> > +	/*
> > +	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
> > +	 * Lower bits [IG+7:0] pass through unchanged
> > +	 * (eiw < 8)
> > +	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> > +	 *	Clear the position bits to isolate upper section, then
> > +	 *	reverse the left shift by eiw that occurred during DPA->HPA
> 
> May be easier to read if listing the steps instead of continued sentence:
> 	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> 	 *	1. Clear the position bits to isolate upper section.
> 	 *	2. Reverse the left shift by eiw that occurred during DPA->HPA
> 
> 
> > +	 * (eiw >= 8)
> > +	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> > +	 *	Extract upper bits from the correct bit range and divide by 3
> > +	 *	to recover the original DPA upper bits
> 
> same here as above

I didn't pick this up in v2 because it is in moved code, not new code,
so I didn't want to pollute the diff.  (Granted this diff is hard to
read already).

I'll keep this in mind if this needs touching in future revisions.

> 
> DJ
> 
