Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE61CD3F;
	Fri, 22 Nov 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296406; cv=fail; b=Zp1zIVLs01lUl8eP2+24mwZer6a6MSnl458r9ziAimYKy3/8GjHj2SJFOx1QUSw8+IUihAykrWwsHmhQaS5TsNfo/6yPX4yxI6MxjISqlcW/hyef7SEmF4mH3cQss/M827cPV6kEk2JN2N6Ryc1bCX6OcjBchUItLHpvBk6lGJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296406; c=relaxed/simple;
	bh=E/DGGX3bEWa6/VRm9yINThr0f2WCZAcrxmWyRBAtUSo=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=saeQCG8wxNf4tcHLEgqSDJT//btdi6zwa78DObWBkHNMVqkJSRCWzlN6SEAOCEK2VAFHYHHXI/SKE/fxcMOenPvdNfhipdtcwYpqXbW9BLXB1e+AnBt1IL+PDvD4tNN8MJW1HcCKhnk9Fnco6LdN0bYoLL8N+cIlT9wOGqRGWq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSqfzO7l; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSqfzO7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732296405; x=1763832405;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=E/DGGX3bEWa6/VRm9yINThr0f2WCZAcrxmWyRBAtUSo=;
  b=TSqfzO7lNslTqIOdTbTfA8CTMoZVOHLyUzEqwlH6d2l+v4OkUMqgJelk
   TAlQfVdFgey7oxi8mlozbrbti564kJoyn/Jr9ugJwStgcYID2QxwTb3m0
   2qeZUj/uK6jxFQSDkQrKCivQsf5TXB0cBd/7HBhzlWAbaPilfI2HF2Wjh
   lrcktCU0j/1ZalRaAix4lkyxaf2W9IXudI57WQC3VSYgbrpEezFgzVRH8
   g2eHbtPSgNXxXVbnVwAOT3gaNZSezEWGwQDXfagVEMaX8rVZeVpKiOHii
   BkrjR3rjYG+8ij23TxvEWHYyWKkLDM0m0yrEMEzyZZHSieLm3yc5IMQus
   w==;
X-CSE-ConnectionGUID: HrdWzDASRISpHkT70LB6UA==
X-CSE-MsgGUID: xj5vdP0OT5a8QbsDsq7bdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32398378"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32398378"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:26:44 -0800
X-CSE-ConnectionGUID: KhLjbfshQCmoLvsER42rvQ==
X-CSE-MsgGUID: Hbvl4PvyRRKlfr5M6mxTKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95717516"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 09:26:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 09:26:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 09:26:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 09:26:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc85b8yxqDla0YQAXN2tplYYVGAaA+o86SwlUzkbC7om+FChfeS8/MUzJwhN6bc8fJDCtMb2NDbLTRenQWrZcfqZKwbxp4dFjDDW479jRLNw0uC9pku3O3CcEwvdpFUgZ3HJYGZKDMe76rjcB5zyIZ/Tr1LtuRLAW6n9KbauhHFYEx0GFl5voI/Z7LvwrvsZzjBC5Zxt9WA08egRxqrD39jIck6B+2dB/fx7gpiu6/t07UmEGutgGx5X29rWTDY28+f/mWjwxq77lpWUK6aoqfE8ycVqwmfeQZtnd7LV+QHWYTVTmy3wjegMt6zKURr9v3mWt0MfHhj6NR2z5o1iRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1yF04Ys2ORpiOXb17/RLf9grkb3oj0I/XW3KjZTJ/c=;
 b=Nn5f4ZRjW5DI1BVhR7Fxf0SH1xsrmQ+QD3GoTnl9YokFzBxMWnpzZ55HHnhQUpjhkxzDOaiCSXMRWEpo5CEBLHH+cZaw476rAYLyWSXhakJm1ugTVyhqII8xMbVP6Hzi5xzuOihaVvTHv3seWJtEOaRM4YO1uMuUYWxDsMrTLgbb2P1Camu/QwYL0zwXpwQesHVg9AF/aLWamvtmR+2am9kQR/q8SNYQpBVCWT4Sbc3v9PzHT1KSxSlikMA0IOWGvgi7iRcGcxZVJdtXgVrS9VxCKf7QwzrryTNlFN7dWk4wH5bXMY0ICkOEcRvApnGUChjJKVV1+VatkWXMpWScmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 17:26:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:26:34 +0000
Date: Fri, 22 Nov 2024 11:26:30 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming
	<ming4.li@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/test: Simulate an x86 Low Memory Hole for tests
Message-ID: <6740bec64c092_2de57f2942c@iweiny-mobl.notmuch>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed6090b-07c7-4d93-2927-08dd0b1ad023
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Asi7k7HUwz3eZ7CcEHW76KOLD1GhR4mwiWZ8VkcAh9E9g9NS5RuKGkxJxX/?=
 =?us-ascii?Q?I5EIkgqwzk+yELSIr7RL4qQoj9I6S8qwpVGKKnSnLCWGbDG7WqYN7hvWSp7O?=
 =?us-ascii?Q?SKpwFqHYoKAwf+utaigUCuDGgVut9ghJiJkfZJlhWFBCVx5DrE7uAUQaKL2M?=
 =?us-ascii?Q?k6Bryw7beuZ9iNj2ktpo1TX+c3+EJSgO499iSzhYn6pZetxrogxIDTWHzVYz?=
 =?us-ascii?Q?V4aoXl+t75T/wweFHG8mxyQHyDjPpM7jYkjmaOt9bDavr/mkn0xof5JagXyQ?=
 =?us-ascii?Q?BMvVDYhNklHyzXUwwxA4UZNa1Yit0p8WSsOT15CbRSRbSS7IfuRwJptgr/4R?=
 =?us-ascii?Q?lxOjdKtY/9UGUedz8enjiZGaU7IEl6LzbdZP0UCno4k+TL5WMVxk00ioeKM2?=
 =?us-ascii?Q?JmSMzJjE9G9kBsOyGA3lXzddFOhAurzskp3J1Z/dmSaa/fdS51o2HSLfNfx/?=
 =?us-ascii?Q?IUF9xZpzBAtDZvzV4A5uK4XfhwVV5yzizlu+6S16vcNLiLHlPX5Qb+wmphNG?=
 =?us-ascii?Q?8Ea4pGNYEBo9/iKq+1jCxD4l9vJgAut/Pfdvnc8hcApiYjsdh09DksQ8x45m?=
 =?us-ascii?Q?72zhyu5jDZgbfkDiO3Cni6w+1siY52vTSRZhjUPCan9PKpp7HRs9z9agsOKY?=
 =?us-ascii?Q?F/8udwxmNO9RMGXAkCmX/Wdw0Tp2mBAwIiWzW0TjdbBlCkeZFnrhEpROLI21?=
 =?us-ascii?Q?xe3269eMXWWfo6SZpVOktzWKT7c0d+rwYZs6aJx3GY7Lw4NHYb3836H7nVW0?=
 =?us-ascii?Q?qZi2zwU5f0D4DF9J6+bziiXoaGtTaKLnjLfThl/T8Dp14BAFx87r0TLPSXsX?=
 =?us-ascii?Q?XbYEY4qutLvnIs/XPHNp5VnyMo8WhG8fR1ERhTod8Uej2E060WPx6ZXbQaSV?=
 =?us-ascii?Q?t6SlUTgeVO4GRcN9VGQsA+ksDD1HGefuXSRwCpkU1AvmnXM4T+bx0kOrbsY+?=
 =?us-ascii?Q?S5R0BORDN+OSJAc4OKE5Wlsytt7iA7Nvx4wwE91x97SCFWE/oGIZOJ8qaihZ?=
 =?us-ascii?Q?qXeGF41zsn4rkhpnAeYwStI0RXtapdsGZh/xFd9zczrICvPd4+tV54IkSWXQ?=
 =?us-ascii?Q?RJSMZLQVlCzzxBO9OinOkgab/iP7WSphLzco7A6vhWMBZ0jOEEdgSNA69Wss?=
 =?us-ascii?Q?3yKPJbkXwnzFw08Xsvp2JM3kKaPQi6hWorwQcRZjY9TRFBsMgcJOq19lc22x?=
 =?us-ascii?Q?w/Jl22bffM/INNtfU42hwiBnbN/+znavj4jTFwLSucsCGVpCtlSKGUQlYLuN?=
 =?us-ascii?Q?fWmvpEmTGmX4P6yA8fkir5E0dh1EQVpoANoTFSlBoPCGeGZGKmT0YctzFKL8?=
 =?us-ascii?Q?PjcDucgUqveG/JM/GQDO2QKBJTEw6Lwc7dLQGpb+rGdkNHjJJXnVr3O5gNP0?=
 =?us-ascii?Q?CbKAXIY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7Hx6kudLT8XG6QTVmNiSau4a/yQBn33ku/oLyu+i+4AHznqd0lTXSPUUFhn?=
 =?us-ascii?Q?/Ii3f82UBBOJgQmhw5xuS/EYTbWfGkUcP2sCB2wT0R6WbxfMThSPG2kdeYsA?=
 =?us-ascii?Q?5tkCyIY+aggcdR5ztw4kcthtXRQYZnVpkHD/S4+chs9GTsvjwJLfoV0u9tbw?=
 =?us-ascii?Q?Hm8NmmH6bAK4ZQpElcIOZl4eu0zI+cIXPr6G1PFuvLeFWRa5/hONWD5StyuU?=
 =?us-ascii?Q?KLk5k87nE7gzXm9XfBmwaPywwOMcauh7tSh3WiPU6wiToThNBcfOe/NahinK?=
 =?us-ascii?Q?tmzuOL12gWO/zDkHPdZXyPLrGn4wUY4c2ei4Efer0dsgd1IOFPIhlyf2tn9z?=
 =?us-ascii?Q?u8eM3wAkEf4CsW1nw/PggRhXjO+eoX4UM369eGjvpe+KGuOaAiYgCuKLzV5O?=
 =?us-ascii?Q?0oAx1sCDq+OjuApCGAmbqmZ+wiEAqshyb0f1zeMUesQKz58XjYKGS1IBeLM3?=
 =?us-ascii?Q?q51omBe1HmcjYPN0YNvnP8nb/j/sPedwECm7Ey5CZlh0LZbv2y0kpHCBN0N5?=
 =?us-ascii?Q?gVoNi8j4GSaC2a+FsfJbiEXfZd9cbW/W4fOIqQX0O0wU6If0xPLwK8oOlzP1?=
 =?us-ascii?Q?L2bIEo/CMj7gNKynUcpcQ0/zN8i8esfDwEcQi82EXyMtAAIhPvlvE97VyEf8?=
 =?us-ascii?Q?iInwCXQYprqUX7O3mCbD2ZOOcnNPi4iAIIxavz68xHvqOCiTSQlArfdXWmPc?=
 =?us-ascii?Q?XdWlabv6oZPcZ8G1XS+uDyT1X+2E70KJ05ywqzs9fa6aqZbgFssbmtRSDinO?=
 =?us-ascii?Q?yWcD8gD5eb7pu6BeLxkJs6dS3si0AnPc9303UU3mizakDxpPPlhG+xMTVqcw?=
 =?us-ascii?Q?QonQSRbKCaFT/1L3xD4IHma0SyIKitKpNeTJejW0jT2lP1OhtvCs6wu3MIRW?=
 =?us-ascii?Q?dK9KlI3yv1EbQqUNstW5ff908AgMIEr0Rz/KtUTofEKRRLMYSRxBMbiEU92V?=
 =?us-ascii?Q?sAjd72sgAQw/j6VOQmZRXshpPFw2MXZv4yrPJgvQmixzgeNTJM/IbnTGs8eO?=
 =?us-ascii?Q?3A6P4veGAJxdrlGh+zZBM5/2Zjqhlqgx2icRngUdiOtuhoTx2eRCUZTqQnqf?=
 =?us-ascii?Q?JJxg08cXuUo9xkASnUR/IFeuKthIxrL13m1WPRqf3adUeBcNQPs631P53wRu?=
 =?us-ascii?Q?iw7QpK7aNngbeVfvpeN/auklQ+Iz/ZG0039ZSAS5WfGATNxTBAYJ9IGUS1Rg?=
 =?us-ascii?Q?Ok3MongGcERd64rRbik07lPNNHgXhl54BK4P77n33qS4Ov2K+Yis3M7qoxVQ?=
 =?us-ascii?Q?u/Q7YTkTz+joEumD7VUF7Yn5tZudd1GmNZnkUVEq0ULWWnQmIgnRc27mQVrP?=
 =?us-ascii?Q?JWvz/y/cSX+9EPxPrBRKdsENhBTSyj1tL4tofFXZRDWR6p7EFwZ8/a/l+G4z?=
 =?us-ascii?Q?f3tSj83Q16BrWEf6qh+7r6IBJDxCGLLZ36umvUK1gna7iOyi/M0HCauYNIqh?=
 =?us-ascii?Q?P7+O1QzzGuQCBhwtgXomOAGLL7yF0Ui5h6HTk3BqGzYOC3icDFTlcmy9D6ar?=
 =?us-ascii?Q?8u+idW8DXv70cJ19T9GAGDIz/tB/xonc6aOocRmsssJyhVWYXmq4PrVyVfAl?=
 =?us-ascii?Q?jZnQa+WGE/OSY7UviEjnU4BIZFojDouyMHw4lcQp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed6090b-07c7-4d93-2927-08dd0b1ad023
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:26:34.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YreouQQMnQBrwJO4LYD4kOA6mBxijMmn4u7KlqRjQtZVnc5rTOzK9K85y9qtd6b61BkKtCuutmug/VABe7mx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing
> mock_cfmws[0] range size to 768MB and CXL Endpoint Decoder HPA range size
> to 1GB and have get_cfmws_range_start() return two different addresses
> which depend on whether the passed device is real or mock.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Nice!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
