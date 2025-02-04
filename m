Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F762163BA
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712088; cv=fail; b=NniCu2jI8Gy1HXRHBVQ7RYeGqnMUGf1yGUN6aMPBWtRFMKLGCgiQ3cz/aydsB6RHVD5ZB5ZW655NxmBe3E0zzxnUIRhFj0a8Z3oxAGJ/v5j2FPHaKYZPvp0KiVMnQ1czB+ttXtWGAefQ4gEoBVB/VokgS6eqoHn1LRjA3TmX70M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712088; c=relaxed/simple;
	bh=wjql2kJLuXKnkxAqSC2bVj1pGKbWZgPFLF5m0hPIKkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0VUZXpWjuYGHUVdI3iyrphCwHgbDeKvteyYITFCdiE3VIGKUuS5Fa3TmI2g4cTEsgZZm29fqjyLHsHf2ba7OcmxCgmdkG1Z8GDqV1ok4BWLhWCm6lko5G6fDrnhoBqXRFuLvCUaRypj05yR38uGYoAYwJe/J4dIdfVJh6lwL88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nc7A0COc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nc7A0COc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738712084; x=1770248084;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wjql2kJLuXKnkxAqSC2bVj1pGKbWZgPFLF5m0hPIKkA=;
  b=Nc7A0COcG1eOknbHqyBCy03kx3DIsuWuqm6dQn8vNtic1nY3rwxuriHr
   UfaELh6Qndbkx0MlEDw9rMmujgbb2+dFyoKtkpTVLqBct6OzWXFMU6Yll
   /yqSV+oLNglgt2VZZf9F8OfvYRpgKdBGdd1SD4Ph2zrzMjj+ozmsTSAyI
   c5PYQ3ddpYaJAzoG9IZxC5Y+GPnDGBjOPzoiq8hsha6ZqGcmT/AS+X7zW
   hwjWkELo5vDcxC1EVyqc5RiZOkblErammCj75z30C8P+F9gYPU5pGQTDw
   4hld05k5vqHtxYAM7g+MdCw6UYRxM11loxGgcwklge1B6D1AqMVZppSji
   A==;
X-CSE-ConnectionGUID: 5k4IFb3/Rna5O1GGRjh83g==
X-CSE-MsgGUID: RUWNx9vmQ2+OfLc0+p7u2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43183432"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="43183432"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 15:34:40 -0800
X-CSE-ConnectionGUID: MUwI6LT1STy4MbG7eufdrQ==
X-CSE-MsgGUID: BAt19DVuQ8Gkil7/bhMkVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110573627"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 15:34:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 15:34:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 15:34:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 15:34:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUEUam6EPqstJhqw/LL09Q1UMoedsIF4TlF8KSkUBf47geU8Meijx74ch9f7Yl/2PPTAcwceCV1FlYSb0Ugo37HUj79WhKyVvSOB01Y1Tk4hMP2ttD5BEYDlLna6EfZMYVhUDxSOU0oWXRrvlwUgRcxdhgZmzeXQel4x5HdElXpJOCZrKhI4MAEP5snw7Rnq6BFEzIl2a/S85Rv+cXljJC+F90iomJ6Uv96szTUCPeL6DCo6Umsz9bAtXIFPb0N8JLOVnenfqTIZwT2VODeQ8yzUNKBSd3JOH6wWp0XxF8104S0xyLN/M9fqpmcjPpHfZJcEBG7ZgelSYCu3zraPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWbYxtO045dXJMGQfEyITr0VRVqnv1DT+CdkNrxYN88=;
 b=FYnPIYh3aqOB30JowDieoea2sM2PSiuCNEKC8VwqnnYdJeN6WIHckeLZAdgXqqcDESnCX4oNoqFFODM8EcLbcugCfJ6oqFKnQljP0vuFmGBnPerDF3ZF9qMXUO7OzA8pTgH0AOgNUkL3f7bNJ29nJ9Wffhuwr6gZ6cxbDe7/LBrg4HaZPQWzwr8LV7E+fKLZjDd07t6kDgwTiepahkFros8UOBDYKuT5yNDsBql+ATiL3D3fC87qd3iuqtwdY62dkcGjSS+PraW13R3NFYyY8En4H/CiP8xhgGrE2f1b5SHdCSjz4Ddn18AMP293EqQ7hka1m1Nqvg9wjzh2k9fyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Feb
 2025 23:34:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 23:34:06 +0000
Date: Tue, 4 Feb 2025 15:34:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 02/16] cxl: Enumerate feature commands
Message-ID: <67a2a3eb96d93_2d2c29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1ab362-04eb-4fb7-e111-08dd45746a80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?za6GoXvu/0yRss5K6ZkXqeQ0zmfz19nVhyVOHx+LgEgjuYAJ55gQFnjVWcYW?=
 =?us-ascii?Q?noios9X2o/TOACL1kpsD5xnHtlH19055rcGY+bCQtMqp9KpiMmuLcAqjQfJm?=
 =?us-ascii?Q?cU5mibbTNXsIBIXC31Rjh0Fp7k2PjGHMNR+pdPT3NivrFtHu6FqbD+3Bzjqj?=
 =?us-ascii?Q?c2PIlS1Bt90ImvMt+uYU9ysTz5CVbzK7FToIHaQsf2aYBMlZRRHUIDBU2Vmy?=
 =?us-ascii?Q?k/P+JHBv4urwzEcPoNTIRZWNqBxyuYYI/j0dwEJRerOx0oU1JBrtetxLp5pA?=
 =?us-ascii?Q?f10IESEFvz8U5rJ/yhIVd65Eobfs2fLOxmdqI+Dhgam6gINouZvLnnBm2Gkj?=
 =?us-ascii?Q?7ynt8rwdHcwAuUeScIgRoMUzgcxmS0YOkoUzyJ4OOcbB2hCXMuOERCmBmZoE?=
 =?us-ascii?Q?Zd2253YteCyGP/k5TYmOL7o/QjxZkcCAZHF+RKN7qB1y4hg7v0VmBCyaC/Av?=
 =?us-ascii?Q?QjuHefoEM+RDAe0aMOkkHcaL5tQrjdIQRe5TdQAKUarHz7nIDXRojnca8w7g?=
 =?us-ascii?Q?N0gZ9NUjL2TgPkAQdTDYoxLnfhCN2oFlYBqm/gNpJWMDNit2GHsFuIEw8Wt4?=
 =?us-ascii?Q?ctpjE4IjlAcgRuHam2xcStJYz79llZSzTxlLNu1hViBjGjQfaVqFeS1toa8M?=
 =?us-ascii?Q?p1EO5XGQZ92YEpk4OWelInJtpddSMBsIzIKVd+tXAFfpTVDaJGy1yTFBObtF?=
 =?us-ascii?Q?h/vvGq+ElDXNIAOS7kjmQjOdPwHItgyFqbQCIbZfB0rfFxKnuX+Mhv0PfVLK?=
 =?us-ascii?Q?IhZrNZ+wIwrJZ+6xSd6GwItSElV4x1XllbUmESFIPvfkURHIvfM1sT8PKhaA?=
 =?us-ascii?Q?HNdv4/mEpLB7dbpLtbgepCzt01jTFPPGrJ6IHuqIys3wiTFaGyiD80V5p/co?=
 =?us-ascii?Q?2/2cHLHpuwMF13NSblAk6+QinK70ecGFK7GdCwfroWGgDB+al/MCgsrpBOZ9?=
 =?us-ascii?Q?dr6+t+FeaImACQZo6GH5YaBGL8CfF5LeStKY0hX3rC5Ao/KwxEdjnhMK0rY6?=
 =?us-ascii?Q?yqIcFtireKMoAqDNEjH0oy+cR/N1DIPo39RD4WUgWvXt/iDTAyMMOgxbstU9?=
 =?us-ascii?Q?ATpGpbSqEAkHIKVvK4QvZAMRyhDT6uoFbcRq0ciokm95isU3cblohQpdj6v+?=
 =?us-ascii?Q?dMFwIXuWcZT52n/PsFH3ZMVBp/y69ZfYZ8XAsUsDX3oN/niT40uvdwXp4G4/?=
 =?us-ascii?Q?HI9L57Hnc1KYd409HylN+XcxIutnlzZoEamGfE8BCO0DfYO2oAlSFyaDpk59?=
 =?us-ascii?Q?Yk+KcKQ6kR10AUb2WW+sGiISs1BvIb6kwiQBik7+FwtPAL+6LPgUdpgIClMY?=
 =?us-ascii?Q?n4I4EJINcc5vYhGeM9PfrIcvSjsO1DJ3WI1nnJR+29n0CnFasqDTjx5f9CEx?=
 =?us-ascii?Q?7wADtb0lyXxfOMQRI2fQ1koR1HBn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dmt78kLnWGCR612ovsqvumJn/0aWUTJeUe5R1Cflfz2Q/XGNh1sKxhP9s4wl?=
 =?us-ascii?Q?MUP4bt33VWZYhxfcyOktX0QSXoewJBKSGVXfwqrI2Bm/aqKDcIOHbgsGIMGE?=
 =?us-ascii?Q?NqbImiNuzEvthTY8XJifZmxm399y4Grdpr6tgLIEuob2tzPRVegrcYTy+dNE?=
 =?us-ascii?Q?KIel1OPxePiRU1DJ+TC/t9hPxs8Xs5nWNTB9LaHuNv7ZoVi1sOwLWz1QQ9p5?=
 =?us-ascii?Q?BAvyUY2A0L32RuRzEJLNPblFHy0XeUa+O9Z9TCfy0YyE1OFRsOforgW8X32E?=
 =?us-ascii?Q?XVhq7LZ44rOtfwIY7ifiXCrDkRQcI3PQc77CUd8V3W5wQxLjTcGw4b+D+O+8?=
 =?us-ascii?Q?0nHzn8YYSZVykXgtvFaPX0EBa40ooA4hvUbhhfIdNX9/7kmiaCiCgkqKITHS?=
 =?us-ascii?Q?gDqSs5AYr0WcaCfeoggpuuNn+d/DS/0Nm6DjqlEQylwbh/nhdJwidQkjbwF0?=
 =?us-ascii?Q?Uj249/vtBdNqU/dPZvhA3v139329gGrS+Xh1eu6yMqLTVolUgRBafh2Scv8N?=
 =?us-ascii?Q?DuN007APtPQ+0GP7fj6bpHhLRBwFJo00/OgPVv033INqweYh2cFfI0Y+GhCj?=
 =?us-ascii?Q?QZuj/8+t8k/tOCoS3UCUxfc6OBolW2yerXbUxN/XL09vQdaCAilX+QGAbSta?=
 =?us-ascii?Q?6Q7uP/aSvWTWQnWfe2tXXwB+mYg4Bn8FHjUVLgLJMs5hYhCmk+/a4IOjVkbg?=
 =?us-ascii?Q?9TlSsFdgpO59mGMFZ1moKDt/luCUaGXsfVM4PlWjQack7l6mW2SUkaSYKYBg?=
 =?us-ascii?Q?FCHDG8RqKCPuQZwJgiinY+tkLNc2DMN9LLdLf2MCLiw4qYfh5R+glR8f3y2/?=
 =?us-ascii?Q?iUOKKP6Bw8fWCc6lGLDK9hW/+0v2bzmsHJy6Fiz/t7o5742PdzoyFGAS4H+1?=
 =?us-ascii?Q?uUIHky1iD2P9IBwJlXaO4QXQ7lia2cjJyNX5aaTafpEXQFj+Rnls2BHhfsf6?=
 =?us-ascii?Q?4+12Cb/J6zEONtaQjIOR+CCOIjTvQIZTY0ub6pfHmW8knLphAaStNMyWVDOW?=
 =?us-ascii?Q?/wKfF9/ozlcvciD/p9HlX0WkS4txYXePlY0IQQampfN+BYAtnq9Q3kt6+HtY?=
 =?us-ascii?Q?kqE8lCsHpzG8ZDdXkAchpeeKV7VBoIpaHNBM2W0iMH4sNzVkDFK3PlkIrfQu?=
 =?us-ascii?Q?oJ6x5Szp/fQSDCDOGQyAUjhsnyhl7avd8PXN9aYIk2Wrdi2K3qAD8wF3egvd?=
 =?us-ascii?Q?OITx4C12A5VJuaKqcfXqFGv5DTp8QaEbtTwuI9Ym2vgXtvCcBO/2NRBm2wWf?=
 =?us-ascii?Q?Uee8/h++07SxVelHQqJhfi0Op3WA5VhjnEkzpcFqLKx1PvJ1hspAxuSIxuxs?=
 =?us-ascii?Q?hYUVZDiMYlmVCEWmXJZ9EkPLW7odcG4PH3y62pRvpOawpKX1DrItgmtBhGOF?=
 =?us-ascii?Q?iN0gt8In/r83nOP5TZqKvvrVef2OEL5WkSbVSdNKnkX7VlJIy74IVqId6c+d?=
 =?us-ascii?Q?djczC5y9C9IkHo0wS3fHWu2BNLioIRGZCxic4pEqWflvBkt4x7GTUoXMvjUD?=
 =?us-ascii?Q?VKEieSXCpCmT8LN/IROSEnD+IOCPCKKCcTJR08atU7roX+8Gqri6/8KqTPis?=
 =?us-ascii?Q?Y+iabb8Oxm4L7rA9CSozKcWh0YPQCtnfsVDQ59jsn81OpsBMca84OReJVBvR?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1ab362-04eb-4fb7-e111-08dd45746a80
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 23:34:06.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pig0JhBLZAWOIxMJJluAYPhooLRtzBZ7kRMechDCY0aN+N1JOrGaKNvJzA8MroCqDnGJqfaEkvvwzac4jq2ECdXUoc/Gg9Vqt45udlN1PFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Add comma to enum entries that are not end entry. (Jonathan)
> - Pull devm_cxfs_allocate() forward from patch 8. (Jonathan)
> - Return NULL for failure path of allocate function. (Jonathan)
> ---
>  drivers/cxl/Makefile     |  2 +-
>  drivers/cxl/core/mbox.c  | 30 +++++++++++++
>  drivers/cxl/cxl.h        |  2 +
>  drivers/cxl/cxlmem.h     |  5 +++
>  drivers/cxl/features.c   | 91 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/features.h   |  8 ++++
>  drivers/cxl/mem.c        |  5 +++
>  include/cxl/features.h   | 35 ++++++++++++++++
>  include/cxl/mailbox.h    |  2 +
>  tools/testing/cxl/Kbuild |  2 +-
>  10 files changed, 180 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/features.c
>  create mode 100644 drivers/cxl/features.h
>  create mode 100644 include/cxl/features.h
> 
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 2caa90fa4bf2..12fbc35081bb 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -17,5 +17,5 @@ obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
> -cxl_mem-y := mem.o
> +cxl_mem-y := mem.o features.o

Wait, why is this unconditionally added to the mem driver?

I would expect that all of this functionality would be optionally built
into the cxl_core. I *think* all of this can go into a conditionally
compiled into a drivers/cxl/core/features.c, but let me keep this in
mind as I go through the rest.

>  cxl_pci-y := pci.o
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bdb8f060f2c1..9fe552e3d465 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -69,6 +69,29 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  };
>  
> +static u16 cxl_feature_commands[] = {
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +	CXL_MBOX_OP_GET_FEATURE,
> +	CXL_MBOX_OP_SET_FEATURE,
> +};

My only nit would be to call this "cxl_feature_opcodes" and
s/command/opcode/ throughout the following functions. The "command" term
is burned for the Linux command numbers / ioctl numbers.

> +
> +/**
> + * cxl_get_feature_command_id() - Get the index id for a feature command
> + * @opcode: The device opcode for the feature command
> + *
> + * Return the index id on success or -errno on failure
> + */
> +int cxl_get_feature_command_id(u16 opcode)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(cxl_feature_commands); i++) {
> +		if (cxl_feature_commands[i] == opcode)
> +			return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature_command_id, "CXL");

This export potentially goes away in a world where Feature support is
self contained to drivers/cxl/core/features.c.

> +
>  /*
>   * Commands that RAW doesn't permit. The rationale for each:
>   *
> @@ -734,6 +757,13 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		if (cmd) {
>  			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
>  			enabled++;
> +		} else {
> +			int fid = cxl_get_feature_command_id(opcode);
> +
> +			if (fid >= 0) {
> +				set_bit(fid, cxl_mbox->feature_cmds);
> +				enabled++;

See enumerate_feature_cmds() comment below, I think @feature_cmds could
live on the stack.

> +			}
>  		}
>  
>  		if (cxl_is_poison_command(opcode)) {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..2d6f7c87e5e8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -911,6 +911,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_feature_command_id(u16 opcode);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a0a49809cd76..4a42cdb64b5c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -39,6 +39,7 @@
>   * @dev: driver core device object
>   * @cdev: char dev core object for ioctl operations
>   * @cxlds: The device state backing this device
> + * @cxlfs: The features state for the device
>   * @detach_work: active memdev lost a port in its ancestry
>   * @cxl_nvb: coordinate removal of @cxl_nvd if present
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
> @@ -50,6 +51,7 @@ struct cxl_memdev {
>  	struct device dev;
>  	struct cdev cdev;
>  	struct cxl_dev_state *cxlds;
> +	struct cxl_features_state *cxlfs;

I would feel more comfortable if all memdev operational state was
retrieved through @cxlds.

Something like:

struct cxl_dev_state {
...
#ifdef CONFIG_CXL_FEATURES
	struct cxl_feature_state *cxlfs;
#endif
};


#ifdef CONFIG_CXL_FEATURES
static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
{
	return cxlds->cxlfs;
}
#else
static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
{
	return NULL;
}
#endif



>  	struct work_struct detach_work;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
> @@ -490,6 +492,9 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
>  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
>  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
>  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> new file mode 100644
> index 000000000000..958e4828a58d
> --- /dev/null
> +++ b/drivers/cxl/features.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <cxl/mailbox.h>
> +#include <cxl/features.h>
> +#include "cxl.h"
> +#include "cxlmem.h"
> +#include "features.h"
> +
> +static void enumerate_feature_cmds(struct cxl_memdev *cxlmd,
> +				   struct cxl_features_state *cxlfs)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	int fid;
> +
> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
> +		return;
> +
> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_FEATURE);
> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
> +		return;
> +
> +	cxlfs->cap = CXL_FEATURES_RO;
> +
> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_SET_FEATURE);
> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
> +		return;
> +
> +	cxlfs->cap = CXL_FEATURES_RW;

If at all possible if the mbox can just house these caps directly and
skip the ->feature_cmds indirection that would be my preference.
Otherwise this is burning space in cxl_mbox that never gets used post
init.

> +}
> +
> +static void cxlfs_free(void *_cxlfs)
> +{
> +	kfree(_cxlfs);
> +}
> +DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxlfs_free(_T))

Does this grow more complicated in follow-on patches, because this is
identical to __free(kfree)?

> +static struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +{
> +	int rc;
> +
> +	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> +		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
> +	if (!cxlfs)
> +		return NULL;
> +
> +	cxlfs->cxlmd = cxlmd;
> +
> +	rc = devm_add_action_or_reset(&cxlmd->dev, cxlfs_free, cxlfs);
> +	if (rc)
> +		return NULL;

No, this is a double-free bug as when devm_add_action_or_reset() fails
it has already executed cxlfs_free(), and then the return NULL triggers
another kfree(cxlfs);

This would need to be something like:

    rc = devm_add_action_or_reset(&cxlmd->dev, cxlfs_free, no_free_ptr(cxlfs));
    if (rc)
        return NULL;

...but I really do not see the point because there are no error exits in
this state of the function that need scoped-based release. I would wait
to add scope-based handling hear until the patch actually needs it.

> +
> +	return no_free_ptr(cxlfs);
> +}
> +
> +static void devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +{
> +	kfree(cxlmd->cxlfs);
> +	/* Set in devm_cxl_add_features(), make sure it's cleared */
> +	cxlmd->cxlfs = NULL;
> +}
> +
> +static void cxl_cxlfs_free(void *_cxlfs)
> +{
> +	struct cxl_features_state *cxlfs = _cxlfs;
> +
> +	devm_cxlfs_free(cxlfs->cxlmd);
> +}
> +DEFINE_FREE(cxl_free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))

devm and scope-based release are difficult to mix because it makes it
exceedingly difficult to think through the state of the pointer relative
to the state of the devm action and the device.

This needs explicit hand off points between scope-based world and devm
world and would usually be via patterns like above
"devm_add_action_or_reset(..., no_free_ptr(@obj))". Like above,
scope-based is not doing anything useful in this path.

> +
> +/**
> + * devm_cxl_add_features() - Allocate and initialize features context
> + * @cxlmd: CXL memory device
> + *
> + * Return 0 on success or -errno on failure.
> + */
> +int devm_cxl_add_features(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_features_state *cxlfs __free(cxl_free_cxlfs) =
> +		devm_cxlfs_allocate(cxlmd);
> +	if (!cxlfs)
> +		return -ENOMEM;
> +
> +	enumerate_feature_cmds(cxlmd, cxlfs);
> +
> +	cxlmd->cxlfs = no_free_ptr(cxlfs);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
> diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
> new file mode 100644
> index 000000000000..0cc6d9e6c441
> --- /dev/null
> +++ b/drivers/cxl/features.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2025 Intel Corporation. */
> +#ifndef __CXL_FEATURES_LOCAL__
> +#define __CXL_FEATURES_LOCAL__
> +
> +int devm_cxl_add_features(struct cxl_memdev *cxlmd);
> +
> +#endif
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..47348a52bc05 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,6 +7,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "features.h"
>  
>  /**
>   * DOC: cxl mem
> @@ -180,6 +181,10 @@ static int cxl_mem_probe(struct device *dev)
>  			return rc;
>  	}
>  
> +	rc = devm_cxl_add_features(cxlmd);
> +	if (rc)
> +		dev_dbg(dev, "No CXL Features enumerated.\n");
> +

I think features want to be enabled via the cxl_pci driver not cxl_mem.
This is for the same reason that ioctls and firmware upload are
initialized from cxl_pci, device repair scenarios.

If the device is failing media_ready for example, and a Set Feature
command could repair it, or a Get Feature command could diagnose it, then
you do not want to be dependent on the device successfully connecting to
the CXL topology to get access to Features.

>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> new file mode 100644
> index 000000000000..8e1830f0ccba
> --- /dev/null
> +++ b/include/cxl/features.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024-2025 Intel Corporation. */
> +#ifndef __CXL_FEATURES_H__
> +#define __CXL_FEATURES_H__
> +
> +struct cxl_mailbox;
> +
> +/* Index IDs for CXL mailbox Feature commands */
> +enum feature_cmds {
> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> +	CXL_FEATURE_ID_GET_FEATURE,
> +	CXL_FEATURE_ID_SET_FEATURE,
> +	CXL_FEATURE_ID_MAX
> +};

These are unused in this patch, I don't think we need them, right? The
code can just work with opcodes exclusively. Maybe this becomes clearer
in later patches...
