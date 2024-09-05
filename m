Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F2136E21
	for <linux-cxl@vger.kernel.org>; Thu,  5 Sep 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504914; cv=fail; b=ub9mn1wjs0c27AiqT5035nzC3zp+y/zz6xmRI7ANeQl974BXLJg40KhJepUemJDc3nB7zCOq9jqEaY+aS1+icgip+Lj8E8DVLifDyqTbQd6EK+qdw3+BaI3MpnsTzvbu7X/HlJUenVPGyuJBc5rI1IkBNu9pKs1XHiqYC5R4LVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504914; c=relaxed/simple;
	bh=Hmoex5S01XLvqlRu/Z0Pdb9tZ01yq+kkegUKRz+OAyE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=plqwCJMd2DJHVqBlGBpVv1dijwxbmOtuYKhY/2CEiYyDpTGPgXPohTmC5FFaVQPDkP/9mBe9qcmoYnMQI0DI7aOjCUKI7EFanAIbfkBLlw/8ROEKljBwX5n2Eo1wnWGpfWpVHJdjurdkJ+8aJafEAaL298brDiSd9w2lLfAVaZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXE5UIb4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXE5UIb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725504912; x=1757040912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hmoex5S01XLvqlRu/Z0Pdb9tZ01yq+kkegUKRz+OAyE=;
  b=WXE5UIb42TP3shbsWENXUuIEmWU/nyumFoOra4D7scajCTWLsL0t9cOy
   6wA+NLuSpycAC7fm3s9OoLQPCeNvfnTayJAB5xQjdA6s600sr9Nh+hs3M
   aPa4PF0W2kSpNkW12V/B2wJe26QJCBYBuD+7MuG0KxCp4g65htVloIsaa
   pEUYLzMssHpKDtH1uJfDrBrffRd8L4vaZEQKneAGm3kSOQBtkGApEhboy
   am0ini1rKY/ECu2gUQ/TbxENmLbmmvALy6DYzkKaySetBK7IzZcsM1DTw
   X77xr5jwUmE0d8B8z93SNKW32g929mAQHIVtrdVSslg2CIYzsuXn2FK3z
   Q==;
X-CSE-ConnectionGUID: P1OzbeZHSjub2SJiZLootg==
X-CSE-MsgGUID: NMyC391aSvyJPCgeFnPz4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28085362"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="28085362"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 19:55:05 -0700
X-CSE-ConnectionGUID: jmZPxwO0TtWqO34Gn09D8Q==
X-CSE-MsgGUID: Q1l/Nr/7QiGMVk4q2fyK9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70383150"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 19:55:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 19:55:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 19:55:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 19:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNm2zzt+GrhdwqiTIi9NMkDIVnJ5HajBKHeIU+b6vo6fwYWtQYt5BMkc77sViOMmvMpoNUeGy0D58NfiL/EsVjlGG9+gjKLQOuWy5x/J5j1ZNAe1Y+Bnd4OeF79lNgZxT/79TuGEayIJKIj5mAjt2EOXwJQnmtf4SEHRwbapVAw215VK8o7j3UaPnB/ubYvxobVZLMJDcskFIiSh97ts4tcPRGuVKt1zjgeN/DheqlifUQ2yiRbrh0CLCmcrJG9YtLcWNbADEXz3gHUzxnMybmCJEhiETs/rgP4dAUZnkxUfyRBGpHEAJrhs6YlnwbNv6nnSP/YkHrNHLHlbwTvXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdwA+RVTJHhobrxsjyKF/Vd7N+rlS73HVZYEKzuwb+0=;
 b=G3Jn9s47KF6f+n53/kcdrziERyLWdh0y2HAXCy3r4KC5BEvvMgAPCGX+IEC1UvJVxeAcLTtM8W+A2sf3/bjnANed3zQkt6XTDltNdjsiGNijgrNnP2h3ORgG6yTo2+LYvJUKcW+H+qjie1dX7a925QTWc8Q+sW/UcfbzLMaNRZL03L2SSi1TLuH+es4c+V1JOh0kJQkIVLfBIdBSEjiemN4IpfCuJO8CJKcnSiP1viAbwZ0jurRfHsCzdcpBwzHjmmG/fssf7MQqYfrRojU7OhDCkVllHFOXxsSM0l3CHqjPgHRL5ZjCsimyrlQNg4PpeRvfACs6jLRr35UDMoXBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 02:55:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 02:55:03 +0000
Date: Wed, 4 Sep 2024 19:55:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <alejandro.lucero-palau@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>
Subject: Re: [PATCH v3 3/3] cxl: move cxl headers to new linux/cxl/ directory
Message-ID: <66d91d844003d_286b294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-4-dave.jiang@intel.com>
 <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: a5217769-49bd-4fce-eb00-08dccd56239e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kl37oi0wdaUhsvIoIs6E6OYFIMm0WecvGS10umJNaVamyFDk8a6WBHANdzR/?=
 =?us-ascii?Q?uaJpQPPP+mMwLAzN3WFQHvg3JQbhUcHEGVVPH2jUAV4Znmt7Vf4ziNL6Pre7?=
 =?us-ascii?Q?8JGISmeCtSDeXl7JGgKASh3fQFUxGia61vGNVlPks+9tHbJyeBj5hbjxNX2Y?=
 =?us-ascii?Q?pc32amSyiCcBO4aCOo7nA2k8LLhuSyNkOSfchBcLdUho+Qije9p5lWciJ9If?=
 =?us-ascii?Q?F53TYOjeog61HHYUGCnTYeB3XL0HCeTy+V0j8lFcei07mAZWrDzQx7Xq+YBE?=
 =?us-ascii?Q?ZzOXQ7YtYTuhuH7k2Ymr+FTf60Yo3xKpbsb3hd1tS5vcIyoKOBIFlyBaygIS?=
 =?us-ascii?Q?ZhjP+R2wpPRT5CBfmSlmjwnJFEVBhbTePC5ISwBMRRlSsr6RMyn6/IF+3+i6?=
 =?us-ascii?Q?n14c2g9LNlcenKhPi7nkAT+rCMN3h8djs9TSMrdEgxsbjNMsT+BQhnaL77fb?=
 =?us-ascii?Q?4HCs0qfAjpI53pwLtarj7GXIwMOLndcjyadYNXXFUgdkF+Q8TEDcgzxWs0jW?=
 =?us-ascii?Q?zdIqefPdHHVJpV8cOwJiTR60YBQcVDS/F3OCE7gRhaW5dfq97Ze50rPeb9/f?=
 =?us-ascii?Q?nlF6lQ8E+iql8z//tX/DsvZvCGcJSS6BmjCGR3MNUWeonHiySoygvitIQuqQ?=
 =?us-ascii?Q?9rPLAZYlat8gTWw70uTlT4/3/A7MALyft1MCyfBdywCHaXbKFJnkn9I6szZt?=
 =?us-ascii?Q?4XE8sa+51VOsW99vwtIgqvxtbrBGL+Bc6bIBHDQKyohPHqCqVUzyKCRERx59?=
 =?us-ascii?Q?jqd+BiZga4mXpDkREUBhWL6C0m/6TnQDPdQK8XO8UOfh0o1DrVrfRGBTxkTX?=
 =?us-ascii?Q?oV87ubPKKbYoP18jMMPxCiB29okp9FG+YOtsSe2YMT84PtkOQwp8Bod2OBm7?=
 =?us-ascii?Q?/6I3fTLeXgFYhwcJZpxm9ab/zQ9FAT1MoSOxOWHt/RSobw4FCQtjM1hLux+v?=
 =?us-ascii?Q?gPH2R0zNGbpp3xfp6KqCFvi55E0WLjrqv+wFph7qHifMVDd0afbr/lQyF+ZN?=
 =?us-ascii?Q?MTEQY5k521lkfxrUWF8Zur/HlAxMl8Lok10Y3D9vSy8iABws9UxQpK7e1lHm?=
 =?us-ascii?Q?sfW8oM85TtdUp/ec1X/yMG6YHCVdFaGywVaPTOHZY3OuW68G+yRAYx2gosym?=
 =?us-ascii?Q?WGAYAFIC4n20AgOfrWMjAf6UXx4FLm7lpBr7/IrAIvmCMcvE9ign9KG/TT1S?=
 =?us-ascii?Q?JARrETpap/3IzDmCDR0gLWjo/UpRYILKpSUhyBtL0AMVzT9VYCqicV0XoIgS?=
 =?us-ascii?Q?v57dcC4uqJdKqpjsRMVzlL/7zpBz1zqTAAyNa5Ykge/9tPyGoCz/kc/18+JH?=
 =?us-ascii?Q?dFce39fPkbyAiWxT18yLa9qoImLx0aztdSdDRG4p/id2Bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwZBeKk93N+NlkOZ20bKZ84GHRnbKzzBJsMO22MFDxaimx90ukgUFXySrilm?=
 =?us-ascii?Q?lIYYgeCJw3pmvVfA83RpogBxI9esiQOn6vkv2K1RQS5ifH69E7OehcFR8nmY?=
 =?us-ascii?Q?3dXtvWei5gbJgrE9kywsdMLnQE2OnLmKjd4s6pS8TxesfnyN/Gn90RUuawAa?=
 =?us-ascii?Q?PJ3EZtX1WWApv/7FBupLud9zLFpHWeyhqO7gqM08jsmJ62lCculMBrWdCY6u?=
 =?us-ascii?Q?pu7YH9mkNPhUbO8BRQXmYJ4CnQruI2taBwtbKjtSpI/pn1DqxRxk5mjWb+3G?=
 =?us-ascii?Q?XabKxiDLuwigHHsHbWeV3bI+aKUoy8kD6vxHhGLHwmYnp/QsXZlWYELLaTle?=
 =?us-ascii?Q?DI7349/5mITUfa8ZnOpGfSXIgZJ8ShOxwSXwIzXq6WyQqNuF1DaUrm+V8nr6?=
 =?us-ascii?Q?++Xb4ONtHYPjDhQ6LV+SrQ2Ra3ZYnuMJDiRau0YoM5zHBVPB+3MPyFIOecfa?=
 =?us-ascii?Q?VvlzFfBnrbEGQ3HrRRXdSek+pmPKpmamEssx7BQb6Y7OQnVFO5aJAdCnaNSP?=
 =?us-ascii?Q?OoS4O0tHUzeIh0jWI84zvT6y2q/4NSXo0xo9nNiQbHDB1Ww/BDCAa512fBIP?=
 =?us-ascii?Q?9uidrxObwlTm8AoC5EDdzNr7XRDoAfyng0EBjljF9iEEu/1soiuDhOmO1LmN?=
 =?us-ascii?Q?naT4a6dwTMruyJgKD8QQhxc+fGQs1qjZDg6rePn6hSsHA8moIvE7t7g08qLU?=
 =?us-ascii?Q?+grAlpNywj7Z0nqQKs1hd8prt+cGHCSNcXaXipNfjZAGNSGPOb894HHQg1JN?=
 =?us-ascii?Q?wHfcK8WsvTGHMXZm0CcP43kZi16qAhGtjwAls9v0DABKvWPKoIJthR/64Eb9?=
 =?us-ascii?Q?H7aYODA06td1Wov6AtZoNcewpr2NJCWnyoToyU4D3o4Q8RvhZXjFswZVS3fu?=
 =?us-ascii?Q?iw1aW1IXBLXZuxXXWKhOmOENmBESkT7BuhRccb26I4mpaqkhFT+JfIMJhWEM?=
 =?us-ascii?Q?1iauVpi5Kjgbz0rap6GnMgrqyMWW3V4j91f4bjbDdPtcVwSTx6C+v8X20TwF?=
 =?us-ascii?Q?HKXJF7CqERAj6Mb81GlQrU59u1Wye3kbXU6FKSiytH0s966pycJNiYI82t/w?=
 =?us-ascii?Q?nVEEnrNhp0W/rDYuyMyFeeXHgh9NYwj/sJtYFIMXfQdYzrDmfeB4wLS06Pfr?=
 =?us-ascii?Q?cgI3S9JCeKFqTbZE8HejbFwE/wGtY30JH0GM5BQNuau397SAktrK9oTFg2h8?=
 =?us-ascii?Q?1rRwVGbJjN3I76fVxyPTqv+3ME3RpV/vSxNMH71zaHvgRlLuTu8gkmsLWbtd?=
 =?us-ascii?Q?YgqK6JOrgCDU9+Mc3hwR4uPssH+Xi6QShk+V+RDByF/WDO4ESNylqEVx8OaB?=
 =?us-ascii?Q?UfvLFXwF6Xqzd71G4TAsA4JCIC7oRq3oY4HN6PQ2yzA1WLjXQL1AXHOOUCz2?=
 =?us-ascii?Q?BEQkcOhsHv9BrcEfvuOr+ZlodcpbzmVaXiGb+d5DHrhDDmXKCasjVmF9cjWp?=
 =?us-ascii?Q?ueiCW/XKlnfWzpAQ9U8uGV3W4/8j8miiP8BmYXesOgaNOQuzMro800rMg/xz?=
 =?us-ascii?Q?uEi6Al6m5nlFqAbo/dx1ombv3xYENjl7TSAUhveYKeIS75WMtOhSswtlYsH0?=
 =?us-ascii?Q?1dq9DPUM7mqdiahbCbKY1Ke1BFXuD1Ubec4CHZG/L0kKB07jo8y4rx1V98cG?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5217769-49bd-4fce-eb00-08dccd56239e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 02:55:03.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEUJngy/zY9IaPLvTH+u3LxCEbVeU5Loe3b/fbCYDn3l8HhqOtlC6SJ/zetepiyISCaXaxTLE36sHw0sdApIVdHZKrBDYWNAzmAbD3ediQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 9/4/24 00:59, Dave Jiang wrote:
> > Group all cxl related kernel headers into include/linux/cxl directory.
> 
> 
> I tried to do this in the RFC for Type2 support.
> 
> I was told to just move the required bits for accel drivers able to do 
> CXL initialization,
> 
> What has changed since then?

I saw this subject line fly by and had the same thought, but now that I
come to read it there is a significant difference.

This is not "move cxl headers to new linux/cxl/ directory" this is
"rename existing cxl headers in include/linux/ to include/linux/cxl/".

Compare that to the proposal to move all drivers/cxl/*.h headers to
include/linux/.

Now, I do not think it makes sense to place these cross-driver cxl headers under
include/linux/cxl/, just place them under include/cxl/.

However, I do not understand the motivation. It's not like a new header
is being added and that is the final straw that merits moving the
existing headers. Most include/$subsys/ directories have more than 2
header files.

So what is the pain motivating this move?
