Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39B2F3C18
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570994; cv=fail; b=bHPdXGQlHl9eyKN9cKOKf/uoQU9/9ME8fF9aUTPN1ylmxwtoopjt1MLAa3Zr3IcsvzAToNQzly/e4mlLQBFxeYeJeMWKzUs4CgbMUrEEgGeUozHjmKwBIZakMP4coX6gyQSpPEVkvZQY5Wp3xEUhCpH4GAachf0qnWL2aMgBJ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570994; c=relaxed/simple;
	bh=UO4wO2lb4IVmnh/QmcyQ48h5+jnRdOqCLKGw80aDM4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j8/z+SW/M/O2YvhNa6IoFZ033uVbnnWMiN35C4Wg4yh4yDXPlzwE3A3ocjrVa/NAV6H2tc+fzxyjWX7svX5zyHuj8hxsgYKyG7yZEvDDs+mjNabInUPrnWvpAgeXvFJ6ZvCFi7dzuaR5Zw4Iy00Ww4W1hRI4PY5L77l7wVZQN/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8RO+loI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8RO+loI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786570993; x=1818106993;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UO4wO2lb4IVmnh/QmcyQ48h5+jnRdOqCLKGw80aDM4s=;
  b=B8RO+loIaqTXomWDK+vomD0k3c/dlIoGSEWLss6TSV5fBMamCk1e28Wl
   UR4yjTHVB1VL1nNxjmntqFdCfp0g9LjfhitNYH7eKe13MJtVd/R+h93gJ
   OOKNGK5/mvlxEHQcuIjBPUMFSAgEOQLUypALr+cqjuKqwCvATgd7Kzo/O
   BIagXCmrZ29MVhtB7Wrwx4s95WqecEXDFtHXgrPcQREbYBwQflReJjhqz
   dHoSaf95LA9yQoYWqrasfv4xVArtS4vXjznXZLImQn8f3OU0Wv7d6CWyi
   VpinCr1OLmWyQ85sB0pSyQI0PSTEycPvLHu+FZ9E67ETGBlcbh5Co1HBD
   w==;
X-CSE-ConnectionGUID: t1zWKglNQEeuxvSnETMcyQ==
X-CSE-MsgGUID: ygtuNeo6S52N9PF3WVYBrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97723467"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97723467"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:43:12 -0700
X-CSE-ConnectionGUID: lDqd+DcyRySPQkbnV9AY6Q==
X-CSE-MsgGUID: zGQJTSmlSLmPQ5tywL1C+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="267616498"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:43:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 14:43:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 14:43:11 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 14:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR+suoWtyrykwrVpAq1uqyqZiXfYuf52XNA4yvn+0xFa4HT155IIQYhCsTPCpqny6qSzlQJaIBZNDUr0F2+9M8nHwUZF1TFGyG1ESuxwPHKZNYAMsmvw4yhce7e/KdvP4Xi37Mx8ZlCunFQK7pL35i1WND8V6VdSBHQLdIPt/L2/4WIciogZc3vyIYXJLWgXqpca//3paXNBotaOgGKW5YoqSGTVIU3vrD+F+6Fyz0857ClZYTx2s9NGMhrO6uSIKJ8niYq9YoTQUX+Pf13nJgrIRmI3oe8T4kJXmaISo4knY2LLN8NRXgRenC70Yr7lkmgOtVTO0920FBDZjwJAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2+HQk2EPWvkTVpzq5Ha9DcBeRbHrhH/VHdOpwuUbR0=;
 b=sjFHGxbQG3m93+9YoSkS51tb7ZqKsUkd3/oqML+PpnTBsgPXFf72c315yAjuEjNODvCZMjzDqpuu9Pa8JWNN3zkfT7WnFJZPtPNnkdtQ8CClANS1qKIMpms2HjbvGQiqc8qU2OR5iXa7aJ/FXpWMBU5C9bj2Lu+I+EzeeIofOkeRdY4NJIQ55g5H3yxwJ5JqeSJQvHPzerlxtGpahqgcG8GwRJpDcjOn7LVKPhgISNQkErfVd3Y/1yg4iSGkvLiNZYaGjNzmTMQGsOfLP/u+8gRs0QwLzJ1hT+GFd49GfpXECsZ33hsiDx71NC42e3z1QUZNj5QH8ZhFqTWgqEIk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH3PPF6CF64E2E6.namprd11.prod.outlook.com (2603:10b6:518:1::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 21:43:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 21:43:03 +0000
Date: Wed, 12 Aug 2026 14:42:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Unregister the pmem region bridge on
 setup failure
Message-ID: <anzo3j2nWsGlZIw_@aschofie-mobl2.lan>
References: <20260812061043.57319-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812061043.57319-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH3PPF6CF64E2E6:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cacfbe-994a-4747-19e3-08def8baafbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 0nehxrmZ3bHbl09HtTtc/U9QpU8Y6Z8EOurUNSTdPMGveEDkZJ8rowJe5YypHVlsTXbMrddMAxXdppbJ+Fxug0GaGT16/Ie2Xj+hDogH2dqOB0zha8ekp5B/nNMWGnSTL73nPqnbmOzL6TQKDC+mL1XldVluG6zlcEiPsjQKUWI2FFhdYTXWQ/2e73ayLcN3Sq9fBWSd6gZygiWCDMK9lJbvZ01ydsGs0x1Pkh/U6vgfmLaFc5E1/CGzZdNmlXzZ8Yvo69BX9IfL1f+JXVIfS4hRFBEbOdXd6l/318ESoGHK5V30NW9FOcX5kBe6GY8Yl1rIpS1UbVpiQYPcIeRKU5yhD/hR39niTW6gRbdYQc3VGg7s/+1Pdgop983GXguq06Yss87cY6uToqpzyHM4eLj/50e3NPd6Kza8Wahg+8MJ5YYgbKtjujd9wYqlysG+YXrTqQ/539r8smJpWilE+f5KPiOEX49ctY8awsnJ8umLRVf/gZdXOzRWG/Umj8wfce9TdyjHfsz9B4j6qFefF16Xp0R9ira/izb5XL7pKv6FiRtD42SuB0DW3HvR640Z3tY1pIBhc0QFEVupxCC46huwYBk8q1MeYcuNPPX5JaGdewSOBi2t3HKjvrYbH+UzGfuFgdBQ1YC2axSX51aacN4LNNZ94p8q/16gRjCuUk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6BOkyNrBNev69RDq+4ZYS7tWpUly2pg9FlD7N0kYl9hjJ++fhVOBtHk7wyj?=
 =?us-ascii?Q?DMUxTsjiLvKZE5HY6GAfUTcTnOcgqZJ9jYpdlpMiaBVbuvqnUSasdlxTkirS?=
 =?us-ascii?Q?MOKvV3cNPrRZ/i2QO3sAK6bq+lZw0yeK49B+6sP/ybisZx3aVcjFdzlZq8R7?=
 =?us-ascii?Q?Zlx+Ene7aAs2r2nkxr9HWNXMFB3oZ5TptBQqzmNInzXSVD9nwOEaUtqUWXZI?=
 =?us-ascii?Q?yxEX8r3UH8F/+CvXj9vo5ZwaWlYclI8wWSotzZuz2AH6G5ea8JyE20m6b4UG?=
 =?us-ascii?Q?2I+IRpfVd76yxoCnwJyb9SG905gh4vjdRN0xzNSj81ypmiW6ifCp3fWxXU7J?=
 =?us-ascii?Q?fOAecDJ9KmllWUbEDY95+j8EwWEudGe6chTjCInJp2gJKzZ136dYpLiJTfyE?=
 =?us-ascii?Q?qXxxdfCYKQEa2iF6IXJbS6brW+MbxerlbzBR5foKcaUrUIZ0xBL7myFBqDvh?=
 =?us-ascii?Q?0sLUt0+EKnl1+njv86lzCwV8HaPMOOc+KIhvDd6V3PQGYzW27NvQ8cIbzw4l?=
 =?us-ascii?Q?yyh5u4rAW0JyMXpHnZlhvzd1TY0CqMMOAtyuup22gDpkblAEWKWkZfk/LFjG?=
 =?us-ascii?Q?xZarkkLhhJbarrtVGtoTfqbz19GCk19ymMjsw4WGDe7cFwxHBsebKo00eCgL?=
 =?us-ascii?Q?1b17ylPga2x/fItJ2lRkCLiLaulD4WBMNvHtuNHW5tm4A0U5Oh1VWNsCX+Mn?=
 =?us-ascii?Q?8VkNoJy0Io1Q9ZKTn4tLuXHtCsYvLnDwneUnQapSnp1fygyhS6JcsWPjAQRj?=
 =?us-ascii?Q?IHwmHKd7p4lztNLFwPYd7RGRzUOb7858+M29VmIT4RvIZNDhEn2VOndvQSca?=
 =?us-ascii?Q?3xJ/BEDo4LX4FnSywCIQntqNP0lqHtuDGy9VJ0/YDLWcKxKhH1tPGEtBDMYd?=
 =?us-ascii?Q?v8FvB0+ibrOWVxAyDmBFcbvcFMdRYIrjXzu2ym/OD7Yq1TrpjfWJ0TNTp8VP?=
 =?us-ascii?Q?qiPe526M0H5bzu6edRJK0hP6y6GF1DkYLDIEQGBomrwKJfmCSTt/9cKVeAKD?=
 =?us-ascii?Q?enaSr630pqlKGp1cPUbL4NXFV1J+DnZGkG/fsEOSm2s2B98bsfh7yWotNDKU?=
 =?us-ascii?Q?bjmbom0QyHFrdlIRvid8bRCbFtUZ6kCGB7vLDT5ODAfEQaMLoKoCGcVT0+vf?=
 =?us-ascii?Q?gdKpj19IFlmMkKzPnI5eE8GDEnCEp9lRGl26tMxjiHdtLN/HxJYkVLFlg30R?=
 =?us-ascii?Q?WjG49McUYBWy8HSyZ7/sYsVmvBsM09qImiQW1PcJ0DFkdsyVYGD7qJ0PpUWa?=
 =?us-ascii?Q?9ktM468ViBZY0CH9Q7UEF3hI2vpw29alUYc4nVq4kC7apuLxf+++H2UnnNvI?=
 =?us-ascii?Q?j4Klp4ZRGHWWchW2JRyJ/JeqMZ3/BRmSC3Pb0MF5qRvi8cdyhrBGrz5a5WIF?=
 =?us-ascii?Q?7gVgkDIDxO09Znbf/OLewCzdKv2o1m1Dks3HnG+qDSjMCuGtxPltOvtF5FIi?=
 =?us-ascii?Q?5pWy4oCoxUldlweUCgIE0snanf4jmXATdGMm5FpWCr+CrXZt/rK+hDkHqt/v?=
 =?us-ascii?Q?vGO7lHvt+J2Y4TD15OcvOe4Z2d6U1xpZnJYEUNBOGvviIuTJIzIXai1XTysT?=
 =?us-ascii?Q?zbAZSn+iNYC/pRa34dicHq0s76CMOyM9RBJgx77ROMht1ajs15ClMs+rRo5/?=
 =?us-ascii?Q?xPYxIX6nbjiVtrirpQ5WE4VAiifvo5rUnWahWJMIAGACOw+TVbQPyK3osuRR?=
 =?us-ascii?Q?ScB9IMKIVac4+cYPuOjZRlWKQjZXk9LW8LmB5s/r2mzMKz8h56c+3d9t2Jf2?=
 =?us-ascii?Q?J20Ri/g0FifnCZsIZVLbYqe+vdQzwZA=3D?=
X-Exchange-RoutingPolicyChecked: dmBLoTt936eG3LplLzoaaKXokRTE7rmR9u0ZuqJ/NNRY0ahx3ZmI0aqzDrJzsG1/5gJoqKR32aQnR8j4aKlOM65eyJcXhepj7qUEMPhH7oxtlq8/h/+JnYXDdjrI6mYUNkXu7acLIkxBsforwpKGEUUoKQG8exiQQsNFFh5Kkc7RJ+X/886fvWUs29igIuHfgWxQ3/9zjonC+HmmnPHXkj4FlotwqXolDk0s5w2FF7cMKc61GqZobWbVpvdj2MhVrHl7KDzs2XNAXaSduHTXq+R/Ec6tlXk/AePXsD5YC0E+3qn6cuf1ls4McM67vlJaZL4mnqXqEStgGQF0ym+Z6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cacfbe-994a-4747-19e3-08def8baafbb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:43:03.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsEcpweIXl8ouPw7dIfh96BRly6M34y7X6f1zrG1ueJE4ASPmq+DaCvJxVug7W/F1hZF+A6WnZLaCgGiZk/6HQGSt0WXRxHS1+KWXTmCgDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6CF64E2E6
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 02:10:43PM +0800, Guixin Liu wrote:

About the subject line: 

Do we unregister the bridge or do we unregister the pmem
region when the bridge is unboound?


> devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
> and only afterwards, under the nvdimm bridge's device lock, arranges for
> its removal - and only if the bridge has a driver bound. If it does not,
> the function sets -ENXIO and leaves through err_bridge, which drops the
> reference this function took on the bridge and returns. The device that
> was just added has no owner at that point: no device_del(), no
> put_device(), and no devm action to do either later. The sibling failure,
> a devm_add_action_or_reset() that cannot allocate, is already covered,
> because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
> that path.
> 
> An unbound bridge is a normal state, not an error state. The bridge is
> unbound whenever cxl_pmem is unloaded or its device is detached through
> sysfs, and a region can be probed in that window.
> 
> The added device then stays in sysfs, along with the reference it holds on
> the region, until the module is unloaded. cxlr->cxlr_pmem still points at
> it, and worse, the name is still taken: a later probe of the same region
> allocates a second cxl_pmem_region and fails in device_add() on the
> duplicate "pmem_region%d", so once this has happened the region can no
> longer be brought up at all.

Is above an observed behavior?  ie can you reproduce this, apply
the fix, see it go away?  That would be far more valuable than this
excessive narration as proof of repair.

More below...


> 
> Call cxlr_pmem_unregister() on that branch. It is invoked from inside the
> scoped_guard() that holds the bridge's device lock, which is what its
> device_lock_assert() requires, and it performs the same teardown the devm
> action would have performed, including clearing cxlr->cxlr_pmem, so
> err_bridge is left with only the bridge reference to drop.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 8/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
> 
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)

This v2 misses the spirit of my v1 feedback. Spirit, meaning I guess
I was not clear enough.

It is more behavior-oriented than v1, but it is still far too much
investigation in the permanent commit log. The first paragraph walks
the reader through control flow almost statement by statement:
device_add(), lock acquisition, driver check, -ENXIO, err_bridge,
reference drop, missing device_del(), missing put_device(), and
then the sibling devm_add_action_or_reset() case. That is essentially
code narration with more behavioral vocabulary around it.

I was hoping the outcome would simply state the failing condition,
the consequence, and the fix, maybe like:

>> cxl/region: Unregister pmem region when bridge is unbound
>> 
>> Probing a pmem region while the nvdimm bridge is unbound leaves the
>> newly registered cxl_pmem_region in sysfs. A later probe attempts to
>> register another device with the same name and fails with -EEXIST,
>> preventing the region from being brought up.
>> 
>> Unregister the cxl_pmem_region when the bridge is unbound.

Please consider that in future patches to CXL.
You can v3 if you wish or not.

> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/region_pmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
> index 23d97e3d78b6..7ab1373a95e0 100644
> --- a/drivers/cxl/core/region_pmem.c
> +++ b/drivers/cxl/core/region_pmem.c
> @@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  		dev_name(dev));
>  
>  	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> +		if (cxl_nvb->dev.driver) {
>  			rc = devm_add_action_or_reset(&cxl_nvb->dev,
>  						      cxlr_pmem_unregister,
>  						      cxlr_pmem);
> -		else
> +		} else {
>  			rc = -ENXIO;
> +			cxlr_pmem_unregister(cxlr_pmem);
> +		}
>  	}
>  
>  	if (rc)
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
> 
