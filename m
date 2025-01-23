Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BF1BC3F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737602914; cv=fail; b=lOC3L7ZHdFrKg6JhgrUjMxluyRSuj32ip/BZAw06PmJ1cY9Bf+sUMDnkKYdxQ7KvcDPn+sD75vHbrHUgG7UgPFMYtzhgQ3SPsZP5zkYNVpV+i/moPhoapDuNqmao2pYJrfidyjkcQFOINkKQKxHh+8cJXz1d0euoAVGESvpMMzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737602914; c=relaxed/simple;
	bh=kBh2+YbBDE6vgHRQHwVPFIeQfSdFjUVdgQMMAiQ2srQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TDyxHulxQDOEzA6Qrzr2+VizmReEmdjKpH/tLH6WbfKz5LhccHvGQH7nYLvZA0U+LyPHvylIzGRjx0gtHVs3BdUXwBn2XZ1Mv6L4Te5VbioNbH/4wpb13BeQWHLCW/jDE+EZSCLVeczNsLv/QWmuoHBTWZDjHJ7fjFyX7daSgAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKTmcfvS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKTmcfvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737602912; x=1769138912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kBh2+YbBDE6vgHRQHwVPFIeQfSdFjUVdgQMMAiQ2srQ=;
  b=EKTmcfvSBk2Ef1xgmDB0pKqZA6xBODRtgTUi84Wgof824mwXsiBXCrUz
   VELTECgIRnaDMmvHFufxcQ1cNHt0kAVfS/2r9IUlxFzBEKIAimAAIhaRf
   9K6LH2PmecVwZSNE0k0w1NuHX9rAXfhgBwmGCZoGOlTAwdtuNl+THoEys
   vXX+RkEoDKJwtKrCd8sYRS/ilhqvH4i7h7dfUEmPxn5mRdFwTneMUGfph
   tgETjHco05eaTxv/pmoxGlq4+YIGzV1lK3bcgeS1qM2G+NPeZlL7h+O04
   pRNGTgLur6huAwGrMAJYGdWJvNgdlRysqpUibt1Xq+luNHV4LeL1QAXR3
   w==;
X-CSE-ConnectionGUID: 2pFadmJoSpm0ukGXnvE1Yg==
X-CSE-MsgGUID: qMb6LblvRnqDq1f65JYV2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38253055"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="38253055"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 19:28:28 -0800
X-CSE-ConnectionGUID: nvvQjTHYQA6IBR7KaWOWBw==
X-CSE-MsgGUID: /yMED4WTT7qkIdYhhgDVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="107442361"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 19:28:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 19:28:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 19:28:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 19:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW0W2JR1V2D3Z3C//yv8mAJ92amKFQ1rx8BLkUQ3Hhrgmcb0jpVpibsjCsr1d04kyUqqsjf6aED848Nmzjm+syVzSt1AkQiVLJMZ87VbrUykJnW1g2emYxLcSh/yc9aBFSkcjqwmDAKz4/1k9rrQRmOWp872bvJP9yqGSfpXj8sbuQIwP8Pp4rgseH5s5tddUEG+RH47duw6l32jDcoeIK1qiEIuppLLPPYqMSQKFS9QHPreopXVSPH6EwJLh4WPzNbGVmIwy6rZr9lkmdw8jr/5SOmqqLXytXHlAy4RLHGXCr1h1wU9LK4W8BMNYaVbNG2SBocm8dyk65VR2V034g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L9fKQ0GabGU1XKbq42qxQf3Vj3lasJx+CW0agREfgA=;
 b=CGAtfe3KW1zND1ujrow70dnqvEvDzHwR4mR7tAq6ybBWxOyUau3eCtusNfIqsrKplumLTeg5a8pufLfZhqh3dFfiIN4maE16thU60VQVHw6wtyb8s87A/7rP81Wk+mkcwlXLXyWWaJ3JX7yoR08bT65kuFgFLbbpiBypFbb+RPT1zlF9HxxCT8LA8S/2Ht373Q6IWstV/z8vSn63MhxhMG+w1si5a12EGPTs80W3Z5oTHYgo8kAgncgrleg3nRCV73FQBKAIOKgNeu/gKAsagRLGpe5BVgS80YaFG3KoarUBqLIJIiuFwwYE8vpq863iLqkM4QojzlesLD0OZ1JOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5288.namprd11.prod.outlook.com (2603:10b6:208:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 03:28:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:28:24 +0000
Date: Wed, 22 Jan 2025 19:28:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <6791b7566fb6a_16ffe294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
 <67911d0578ce9_1eafc29428@iweiny-mobl.notmuch>
 <679172a7ac00f_20fa29442@dwillia2-xfh.jf.intel.com.notmuch>
 <6791b430ed4f6_5584029448@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6791b430ed4f6_5584029448@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: a644f02b-f946-4d68-72ff-08dd3b5dfea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?//ZIFcWtAj0lnN3hKB2ft/L2CgSlFHQPB09rUaOk7sBqmCyU1Wd+fBKzzB3M?=
 =?us-ascii?Q?Lv6aGIEb64ZM4PxWzBqEae5XVJnMzkswEz6FEr8wDae2VsoH13UHDfYvkfox?=
 =?us-ascii?Q?qGFlNCcSwOfVITvHRT2JY28PvpWwvIKBUzOTf0FAvGVk2fav7pHy2LNdd1Lc?=
 =?us-ascii?Q?Bh1oD7eahtS729S09AfD0jVPkLQBTvcdaMX67+qG/pnzvi6a5ZZmSceSfWh2?=
 =?us-ascii?Q?SE7GO7NxUZQ9OuOdMiaxGGWMxp563nVP/wO9vyEX9a4KxPpO5Nvg4gxRva96?=
 =?us-ascii?Q?mKxEbH6jBmDQXpqVM8yqWQJFWi/CD6PzcSUKsC232DbpSuf65cSajarvxUBe?=
 =?us-ascii?Q?j2j4UyvHoThlM9x1nVNWhuEPtw2T4zeE25+/3+0QVFIn64AjV8RQtrCA4rYF?=
 =?us-ascii?Q?WStwBfJk9QhGOX4WKR0rRCheYsCjOI7MllcM10c1xeUDzz7nQsqK3BEaeZsM?=
 =?us-ascii?Q?tsbURBXoSeG63952F2huPe4BueHpgBnHfE7v45rckkNCyca2uNCZhEbLi5OV?=
 =?us-ascii?Q?sJjiyd577PyPjXeCSbZ3QkJEhMYDiUNjDuzEKTqRZjlWbv+RcFEwH0phghSd?=
 =?us-ascii?Q?0LLpdDD973qbX1XJ80mM94sX4nrQFL/Wmd1tD0S/+UGPCWwqhG7nYbpfQFWs?=
 =?us-ascii?Q?PH+b1BmNayISF0jewMX+wGL/3Js6xsWa0l8LgHQxi+3O+9xylrfLzTcarbCF?=
 =?us-ascii?Q?+khuWDmuubn/uR9rba0y9xlhZRdgQvnhl2INIvngI/FLdnyz2bZEMqoW1cfg?=
 =?us-ascii?Q?SCwfZOW+c6t4Lte6C+t5xpJGgshoOsZXYKWQ2N1kB2HDmAIY4ZqbtlyOcpcl?=
 =?us-ascii?Q?4bF83pVAGwhCFnHtpqBkJYzI5Hu0Hp+oiescRp74Tjc9LyB4Lk1zi0wtZUg0?=
 =?us-ascii?Q?3bAszWjzXM+anNlmCQ67B25E5aYoTEgDqav4EPccx7xNSY1u5+p7xOx75jnj?=
 =?us-ascii?Q?PLZ0GwXKqeCZkbCeQY+YqBZ4FC3GQ1mWghoHLBEbW3zMRKzA1vlqMARdsh5f?=
 =?us-ascii?Q?NcdliWbX3HL2Cy8SJHNMyJxeADI8niTpp7N1cqlzL2uI2i62CiQgiG8BxfyG?=
 =?us-ascii?Q?IPppVJ1g4QUBgLBfUHFHQYmGmTkANks00LFpB+avkNre1i1wpb6v6UHB55bN?=
 =?us-ascii?Q?gYp5e8Wzft5w3QrH/Ayv+SPz6+HaWNtUsJa8EEtajLbeBmVe5v9YfUoorjuG?=
 =?us-ascii?Q?ke5vmPjX1FirB+PMaDR+C0JbaXGkSlkpwflNxi3E1cXDGaVuvsLdXI1kd2zA?=
 =?us-ascii?Q?z2pJugdO7+8XirfU01ru9m5pxiRvFdMGkdkTsilec6bTQjKjGsHlhhOTznZT?=
 =?us-ascii?Q?3wN8+HlrcoA3gDIRFVaUXTa3KLzc9EGGooDexADr26wq6Uq01mTl7imyL9Fd?=
 =?us-ascii?Q?KELjzIsmaaUHlp5rBH4Bnx+FENLT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRFNXn3WB3RByuWQGGocERCDD6B7LqpINVqPROP+focs+8KGTOafO/FHAWSM?=
 =?us-ascii?Q?0SpkiwE7hPGl2tGOSzIPpAVIOfOGN8yOMJk/SrLYsHhq+KROhHbFoQeQGiOa?=
 =?us-ascii?Q?UqtxSYizWmiw5EseJJ8YQZ4lSwoq/BMSUHYptmwKW4/yawqDrq82e9bnmZbR?=
 =?us-ascii?Q?4+rM5qN/o6rl5sWTVUOEowOuxs751w20XtPhxGebBKmbJLWAF9ATiK0++UDR?=
 =?us-ascii?Q?e/6ohjIRordrW5I7DNUqcc29Rq1XoTNXxuwMx/nxDBe9Xdzul6HMwA7FjEet?=
 =?us-ascii?Q?91xMx0yPdxyKseY26c56Gwo5aS9IecKJ15eTetTL/X0HfbXIrV29DuEwprGg?=
 =?us-ascii?Q?oOBNYfBia9k/GuNUUHUnFsrF25lj6NxtewXopZTIbBmoAwXNI3aFAYjsCd5k?=
 =?us-ascii?Q?czNjNLyTPWFE+2CAvgl/eSkzkx4Fmz63gRRDss9z8UdHSwr0F+98wxxmiBp4?=
 =?us-ascii?Q?Exwz1tpNvq53w0J6MT+kfTphEEE+18xzOREmZB0ijmq7zP0GZzKqa63JPIa7?=
 =?us-ascii?Q?7rguat5/QxPz2A9mpff99xevj9NXCAug/gUgCRRVL/7vSISc9QSAKOb8ZTam?=
 =?us-ascii?Q?Ad1PpHm1OOofpQ7nL9ho2hTdQeDlq3jJW6ppz5wVHGgu+RXJ+Qg1KGMPZWxF?=
 =?us-ascii?Q?sSnAuNdAoydorArw8HM1JSnL4fri/s42jnuiryJGSCkl+nVPYpwkxbuRFWnq?=
 =?us-ascii?Q?tTMMNmV6Mlxlc/bjJ6Oz1mNqJuUV++P8qxI3fLizHH+xZTS+l1sCmAUWY07W?=
 =?us-ascii?Q?SEPQOiXLAQjs2HERn5W9D32IMf6NfN+IzGZm4lixtd17O4fT3mqVi+4jHV/B?=
 =?us-ascii?Q?vFGP9IyfSPd86rhNke6/o2zOnWTIaXJMtb/itu7orLg/OsqnIVJe9QKBE9+P?=
 =?us-ascii?Q?1X+qKX+/wXIsXwH+dOi+ynmiAGktBETwCa5QOIaqVjcd2oxswNyhIZK7yK63?=
 =?us-ascii?Q?UFlREBWIbGnkDiZBxwN9isoRgkokiGTqH3vLuXw+fLGgS7P053H+0X05t2Q6?=
 =?us-ascii?Q?tu7VBzw72QzlUC1RKZ9rmdBTG7KWW7xWtqTQAm7pCkTT+PELihgsBBFCJyvx?=
 =?us-ascii?Q?r6lTh0wrwnFifN+czIaEWMWSWQvaeg4rwLhu3bNbD9on1Mc6+UotKfiK9rB6?=
 =?us-ascii?Q?GfQLLyjmNyq3f/OnY8NBViN0cYuQAxitzC4WVkKGbqHpQFNI6sorUDpZR5/8?=
 =?us-ascii?Q?B9r9p4IoLdLlT9SP6rhtz+UWIsQATX1zqMTMZSRb/l0QNuoXE/EgJJjhlFV3?=
 =?us-ascii?Q?TZGosvBFrCmV7cVGgwLEoRNrY7XTBKS29iNNknK/aCbxLyOUeJ+MAKPaZ/sZ?=
 =?us-ascii?Q?r7zuIbub62VqFMVlMnZNkpHvhQMg8jaZGVvP1+QX9tOrj/Xsh9BAjqZs3y+A?=
 =?us-ascii?Q?uySRF/uOnY79QASY4NnIvZN7cd3/AcreTXqYhSeGBC5TdkIJGlE+TJykPeTA?=
 =?us-ascii?Q?G8G7qBT6qiUt13hvIFsxmBiekaDYXOUQP/nMMkhlVYa276iGboi9xIfShk19?=
 =?us-ascii?Q?pUlCa4FHN8Ul+CXzY31lBlbnESumm1kx6vRNdYMgVbh61CXEqVsJHB2zkKug?=
 =?us-ascii?Q?GjV1T6UOeaRIIQAbL23mZIL/FYpTavXabRckZ2g1kQ9+/4CjkYX532XKoVlb?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a644f02b-f946-4d68-72ff-08dd3b5dfea5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 03:28:24.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce/JQ+DLR37I0SJYH+L4jvU9zlgea0yxi9wiehqLRSHbltWvBaI7GNruygyt4jVypvsPMmwXgEKrynH65TLl4oOGvonyoHq3QsR0NQAy6/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5288
X-OriginatorOrg: intel.com

Ira Weiny wrote:
[..]
> > > Another great comment but it does not actually cover the DCD case.  This
> > > is because in DCD the partitions might also have skips between them.
> > 
> > I think that "just works". The allocation will be bound by the
> > partition, and the skip is calculated from the "end of last allocation
> > in a previous partition". So, the distance between "end of last" and
> > "allocation start" will naturally include inter-partition holes, right?
> 
> Not without a change to the algorithm I came up with.  We could create
> phantom partitions which represent the skips between partitions.
> Otherwise the skip resources need a different parent.

Oh, that is true. Same problem as tracking skips across more than 2
partitions.

However, I highly doubt anyone is going to build a device with
inter-partition skips to the point where I am comfortable with the
driver rejecting the possibility of such devices. Effectively dare
someone to build such a needlessly complicated device especially when
Capacity Configuration supports the concept of decode-length vs usable
capacity.


> 
> From my commit message:
> 
>     Two complications arise with Dynamic Capacity regions which did not         
>     exist with Ram and PMEM partitions.  First, gaps in the DPA space can       
>     exist between and around the DC partitions.  Second, the Linux resource     
>     tree does not allow a resource to be marked across existing nodes within    
>     a tree.                                                                     
>                                                                                  
>     For clarity, below is an example of an 60GB device with 10GB of RAM,        
>     10GB of PMEM and 10GB for each of 2 DC partitions.  The desired CXL         
>     mapping is 5GB of RAM, 5GB of PMEM, and 5GB of DC1.                         
>                                                                                 
>          DPA RANGE                                                               
>          (dpa_res)                                                               
>     0GB        10GB       20GB       30GB       40GB       50GB       60GB      
>     |----------|----------|----------|----------|----------|----------|          
>                                                                                 
>     RAM         PMEM                  DC0                   DC1                 
>      (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])         
>     |----------|----------|   <gap>  |----------|   <gap>  |----------|         
>                                                                                 
>      RAM        PMEM                                        DC1                 
>     |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|         
>     0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB      
>                                                                                 
>     The previous skip resource between RAM and PMEM was always a child of       
>     the RAM resource and fit nicely [see (S) below].  Because of this           
>     simplicity this skip resource reference was not stored in any CXL state.    
>     On release the skip range could be calculated based on the endpoint         
>     decoders stored values.                                                      
>                                                                                 
>     Now when DC1 is being mapped 4 skip resources must be created as            
>     children.  One for the PMEM resource (A), two of the parent DPA resource    
>     (B,D), and one more child of the DC0 resource (C).                          
>                                                                                 
>     0GB        10GB       20GB       30GB       40GB       50GB       60GB      
>     |----------|----------|----------|----------|----------|----------|         
>                                |                     |                          
>     |----------|----------|    |     |----------|    |     |----------|         
>             |          |       |          |          |                          
>            (S)        (A)     (B)        (C)        (D)                         
>             v          v       v          v          v                          
>     |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|         
>            skip       skip  skip        skip      skip                          

Yeah, I simply have low interest to review a patch implementing that
scheme unless and until someone says "our device wants to do that, and
it is too late to change".
