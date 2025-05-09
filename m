Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB1235059;
	Fri,  9 May 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808007; cv=fail; b=EVB6HR6bgwuo2Np+DC2WrbomRPgBJ17yqZ6BZq/zhLnfWfySA7z29ZoHFoNRcJar63pDL4fPk4B2rayLHtCbsOO9VsafbPvEatRC5qL//uXnm+k5tMdIzUAQAIJS0C1zmw5a+H6Aie9SIKjTVIa1EQqUT9oYglkGQbigv28QlX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808007; c=relaxed/simple;
	bh=MBFT21aIRz5LIrok2KF9Pxjt9YwW0bUMP0r56/xYQ+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0ruaTGuSvH6f7XSzE42wJcjkO67bndkqB+2KzmQ23uGhitPcBwdrozvkHOp5XT7J2OjNE8GzQZphznONUx5/6kqO7nF/gLJzVpsTBW1UEIo6asVEKQi0lt8I5/yaWpLE77yGooHy1nMLyquciOSiLVWalryvoF2TOoIHE4+IaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuWC6mFn; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuWC6mFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746808005; x=1778344005;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MBFT21aIRz5LIrok2KF9Pxjt9YwW0bUMP0r56/xYQ+4=;
  b=OuWC6mFnIyeQTXm0NAIz/RRCnnGkWuQSN/GNfyZyTwtBO1E61PJtdm73
   19nzI2KM2rs8eV37bGwe6+AxDl6D4JTbDXxBHDnB9n0018UVnxCp0OGnm
   RCMVAAjPz7o4EP3qphTwXzRAAd15YyePiOFTcABb4n8karB9TouCbLsbr
   6BUO0AME7Owa8gd4no9KW+9jGnZVLpxAd6P/HFAzAkoQSYYptkK7uM48i
   rPcYBbxQcnFdbFE+VFtsO4jC0qbJwC1HcJXhJZPn3SS7z+TSl+yOv3ooI
   lt/XpFYgj1ScsVdfPK093l/096F9otVYoiF8w8JjGauzHo3lVhhi/H+Qt
   w==;
X-CSE-ConnectionGUID: S6wL7h2VQBC879+Z8VhpSQ==
X-CSE-MsgGUID: G1Vds/h6SbqqOgaygBrjhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52296512"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="52296512"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:26:41 -0700
X-CSE-ConnectionGUID: 01bIQ/fOSSCG7Hz97QJa7w==
X-CSE-MsgGUID: QwWClfIxQ6STS/+J7g8x+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136611924"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:26:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 09:26:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 09:26:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 09:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Whq7f0Ued5FvDdE4wtw7MCPMizj0mFw+thIaBFxPQhzp7+GHvbgBD7ZwOcK2sknzpEDWZS1yqpOf+47sMuPUrZSL6rPiiwmkcMRIzR5hRDkblcBmBGOmXbM2zZZjN/7jszfiQ3TvlxuMO8YjB4vb50mWYtW3mdKUUjnxeFabLsWAvvVW08b6ld186jXBtJ4EaBmpR7H2TrJp4WRKTgiQ+9Jjsgc2+U5x2ry2TxkkbnptEp90D+zun9zRsmNWvGXzPkcnszoahEoIkYZO/rYtN1SR+cQ27hoCrCAWn5lph4iKJI67fPwkBx8QuXbDeiUoaEaMCO8dPT8PFhhgINWZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5OEZwJOW9l24hcjFtkmtCuuteLXzl0A6mlJhA/OXCg=;
 b=UzUV+yXGUQFwARDotchSiv8DrzUIhuVLXVWljtb75Wu0gPqHbmaFtbhv65cPpwwrPjd/lV0+ebJFNyaLxm1gbgplFjSdbV7UsVKD/bTnKEX/cpupdOPagC1RxwKPB1DVUdbZ10IN1So6PkW4sb+EbOywzlNLe7j7+qXRhN/Abt8+ULvHXd5O7g4dFYN8CL0OmN8BlT48EpBbBb5rRjb3213+iCdqszZxDYgYkMKUFz6cq0x1Mja/rPaEe4jvgwCGfS85f44cXT+F8BXbndgb9myM3bQ6+G4D22OBy2IHLmn2UPCWCK9tg8w7AggYrDJLn6MRlhsj7tDZUHkjvHSQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 16:26:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 16:26:33 +0000
Date: Fri, 9 May 2025 09:26:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v6 09/14] cxl/region: Factor out code to find the root
 decoder
Message-ID: <681e2cb5ca5a9_27eca0294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250509150700.2817697-1-rrichter@amd.com>
 <20250509150700.2817697-10-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250509150700.2817697-10-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb7ce42-678e-4636-765c-08dd8f16430d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ev9mB5jQYLl9fxQTT7K4H6P9vMW3TIFqaY+1bQgUkNsCuJh9oniWHqV9ul8K?=
 =?us-ascii?Q?BI/1DuJtT4XJwaLx+grefFiu3AmVH145zEt/yvB5Tkj0JhUCDMN1fvsBZ310?=
 =?us-ascii?Q?18vqNPq7GHlMc8NCE8C7PN26B0eojWHmTk+4769AfQy9mDvNEW5SMhf8MOxR?=
 =?us-ascii?Q?dJPJ/z0tsIlqJMyApX4ITmbhoknPMnvLMS9rti10JMQlkWZX019NhyxJjHF7?=
 =?us-ascii?Q?je7TcbnyPX2ZeoFHRXO6qX3P4BPkBl9oaagVVokRy0oB1lGb2UvfvGtQP9J+?=
 =?us-ascii?Q?U2pavC7Ruk4AAKv7nfjVmfsKd36nHowN8/cdTZK5rLGtod5/FIk5b+eNhc/r?=
 =?us-ascii?Q?f+Ye4EM8WC82HP++olkaRij40xzHVEy/cF+Gx6MGkXOZrAnOV70piNAfcMxK?=
 =?us-ascii?Q?g5mvTjKioMsqHpoa65CQAjGsQ+hNOINs8qvSQfaY7Pp4Bl+VCD9EYNR4GCvO?=
 =?us-ascii?Q?9K2q5pELJRp7Le6Uz+ZCzBgy3w844n3loPkLvY9/6ChJ21IsqZAnJ8D5Ka6m?=
 =?us-ascii?Q?7G3YtgdzFRxbmdpBvoh77Dy6Me2LaaLSlC2ah/QDMMmDsHoRre7uHGvpngVI?=
 =?us-ascii?Q?8bggQPZdOkoOudG0nBCnHyJ+TDErNo+vQCVX7XP8ulAaGvs/p1HAgdbeyfzl?=
 =?us-ascii?Q?bkQHIZyLYSRhxirVlQmUdjyBRcogFZcui0q3PuHJByXg5KYD7rzqv9e3kGaL?=
 =?us-ascii?Q?Ij+0XClAuWULuDS0ySHrMlAlwB7wNSdkwqJiU7UBZTktnd9UXd70bHdAVUao?=
 =?us-ascii?Q?YNYG+3xqGZ1mknEZPWvDoobTEsz2YgDiPifCbMWAqc6FJWJGMhNfKbDI+8Kw?=
 =?us-ascii?Q?Z1MeE6Q+bW/d5x9X85soRUXflFjp8S77+WoGdDXgLh8uUI9rN6bWzRvrT7d9?=
 =?us-ascii?Q?Gk1P0+Yv4sNvp4sOHk2afhIZ0Tp8w+5fAKncE9SPVNV9JwykCgYmRHAVymtJ?=
 =?us-ascii?Q?7DRnpPyHTFh6b4aY86FQFp56PBUJ1gtUUB+eKS0/6/M1gV965izF5SdiILu1?=
 =?us-ascii?Q?r7Mw1q4GbmbOoEM4g5zwuXbMNoH5aBjGmG64ufSew+xjzVzrB71wSoS04QBq?=
 =?us-ascii?Q?+Dtiro+YwvFeMZYQhXL4miPsOBJUaTnUuaE6kmHSxD86aQEbER6aE3V2UjGO?=
 =?us-ascii?Q?lqvAiQNIV6CAEzGwWLlUqOb3f00NG0wR1TM5VEaO/J5cAFOeF1b3z5EEloZ/?=
 =?us-ascii?Q?qdQrYN5xbfNAimQnGWK5GMM2LWSSJ+ToVDeCvqjBYQMFUu7L+dKxAAde3QT4?=
 =?us-ascii?Q?lqfLDjBZAY+HyE257I884jQai/QY5GVSpmY2tzjgRJi9JViwF6ksXpULy79e?=
 =?us-ascii?Q?iQeLDoIZAqlf0DTIQlCEoJ4D0wjvkoLS5VeEDgt+w64p9ez/qOm9cx7RigJW?=
 =?us-ascii?Q?zQKhvmsRrO9Rw8ZERl6gM/qnrVob64nr0rMfjW0x3gQXeEXQ/bRFfJW4o9+T?=
 =?us-ascii?Q?FuEi0Q4i+Fk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jP2LeYIT32mzbQXC1tC+npMT6oPF9z/d+NLA5y2TEXorcW9Bb/jzWKcLlR34?=
 =?us-ascii?Q?yfYQlF6o/YXeNjfsw3dGB0F13UdTqbStBbjxhWUTUpLa2XkAodmJCjL/ok9d?=
 =?us-ascii?Q?g3Ribm7uUbe/v9MpRC/qkd+FxehCxrTPchBy0dl3F2LGfHCXbSH8OkhK4T2O?=
 =?us-ascii?Q?K+78vTd7W6vhEZf9klPKPyMdWncLxGCpw2ElHCcGIpXVBgbfa2pDxRFP+Izr?=
 =?us-ascii?Q?M3OiOoQX4Ip628xWcfilwOQAXxsTE66x8A/GXKs+cJLGDWQApvDuswKmcPuN?=
 =?us-ascii?Q?6Ip3l2YJoZoYntQ/iPjM4ZwBTGzi1gsr/jLYRSzPRmCYRiqEgQXqTCCXFPac?=
 =?us-ascii?Q?B6X47xXN0h4OdSkrsEZ11b6gRTwwcyiDKIinhj36MWIozfCiuWZ6dwMOkmhU?=
 =?us-ascii?Q?a+nhJTfYF8yqvw7WU9lKUQreYLLcRbb9T68pRq7BbjM/YeEwJAxWX7hmR2zv?=
 =?us-ascii?Q?yIDe2atxvHTk02/oaOkkjPEwBfMSoCdOjMnXBfXQKYyPplkVJgi6mL1DlWXI?=
 =?us-ascii?Q?30iy+er8Pr/B2eAcZK11qlAlLrJHxp5mRs8yhvG8UJTsOuP+i99TvM3zv70O?=
 =?us-ascii?Q?+eLxGpdhSonlH9x9BFFF3vV2jGmWSOvIejeladCKik8LW5OWnQLjn8GKOTME?=
 =?us-ascii?Q?ej111E0Oyjoww5FxTfXVpoz1fUp96fUVY/2kRGU5wqZ8fKN0S3TV3BwKa/Jc?=
 =?us-ascii?Q?zj44jEvCXILA0JVNcmlVtGupMN16+bDpjUosS/d2z1HPyNOSXX0KYaMW6uWJ?=
 =?us-ascii?Q?SbMArDA3V19ZeAVJ32Q0L0itnnNtJ9cN5qrtjm2qTvEw4v1QqT4ZZCfjvXJR?=
 =?us-ascii?Q?ipD/TOSqy/s4eEdbIYrTyuuD475/Jn2oEmZ2rom+XCOWZBHHfFFqyE11Zv8+?=
 =?us-ascii?Q?2fhBZJFIarKN3/o475vMEB7K/buY9wZ0dwiO9n9mit+wA34n1geRbIrz9b+C?=
 =?us-ascii?Q?r3DV6Nx3RMdRoyKIo+wGPiyqPwPWFiIKRDEqIiRH6ctl2HRZ91eQQnA294Kw?=
 =?us-ascii?Q?JxxG+7DktfvjvF+OJyYujMZJYfqvU2iF8F2uNZmZHjCt2thrFSbVqo7Cn0IB?=
 =?us-ascii?Q?X7u3pxfNlDA1g9lEf9rrpCRpFtDIUB4o2ycz64kRtADvdOV0KU3yD+Whoovy?=
 =?us-ascii?Q?faqX76QbMZevVPt/PYejFstsf7h2c8Y75BBgAl1cL9BKVrN0sa4gjmIqU1iE?=
 =?us-ascii?Q?+EiLsUkxjmGKLaOG5MZ90fM7rhcII1orVw8Mw+F2zR8p3LRICvvTc5Og1mTi?=
 =?us-ascii?Q?/YkmwEz/LJ9cekcURraS0H/zSiaBxw73UUW5wkZL4FwlMwz26SVV7f0Av1gS?=
 =?us-ascii?Q?jpvNlqAIYNNjm150JwzrawKCzJWbkzf5PI1DXxcVqJT8l9vFY7qQ5XLO5kob?=
 =?us-ascii?Q?Fi7h2ou2JD3Hi09YXR7mZQYlypgw2SxVC9FPTe0spaqjfHOgyxjRq5Qpp/jp?=
 =?us-ascii?Q?met96c/ipxV1aak2L2GVhAvHxb9IadtterMsgC6Iy1Qju4Tn6ooZEWxwIP4/?=
 =?us-ascii?Q?qqX5bTJcMXj56zg/C98QamGXJkNydKczxD468Hzim0SW0RPK73tCJ//qhhKu?=
 =?us-ascii?Q?/gp5L11Y/fua7LfSH9fudvDUs1mVgHFo3AE2Cy7vk//bNuOyiXoHnSL2xC5C?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb7ce42-678e-4636-765c-08dd8f16430d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:26:33.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL3432h+BMjlJB1BxlezKEP8IsZtLzDvit988pY4gQOfbQLKXw/dC/XqhEvwn1SFcibhSkO/NI6HYClStoK5bD9fZaqis4cGi2uN51UX7Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-OriginatorOrg: intel.com

Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This has the benefit of reducing cxl_add_to_region()'s
> function complexity.
> 
> The reference count must be decremented after using the root decoder.
> cxl_find_root_decoder() is paired with the put_cxl_root_decoder
> cleanup helper that can be used for this.
[..]
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 59d0d6becbd1..45f5d2c7dfdf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[..]
> @@ -3384,29 +3407,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) = NULL;

Please avoid the "obj __free(...) = NULL" pattern. Per the documentation
in include/linux/cleanup.h.

>  	struct range *hpa = &cxled->cxld.hpa_range;
> -	struct cxl_decoder *cxld = &cxled->cxld;
> -	struct device *cxlrd_dev, *region_dev;
> -	struct cxl_root_decoder *cxlrd;
> +	struct device *region_dev;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	bool attach = false;
>  	int rc;
>  
> -	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +	cxlrd = cxl_find_root_decoder(cxled);

...i.e. always instantiate and asssign a scope-based cleanup variable in
one statement.

	cxlrd __free(put_cxl_root_decoder) = cxl_find_root_decoder(cxled);

Otherwise, this looks good.
