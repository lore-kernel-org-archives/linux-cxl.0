Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848491EBA1C;
	Tue,  4 Mar 2025 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131798; cv=fail; b=XH6AEYutqq8Av38Qg+cfCBzOY7/RerlmoeFU9bMZxpRh6ifiq5hgMykhV4rQAeTZDHnLzRYqhOAGmy2cMWBKDSsMImOQruWUcF/EzZxbz0L07ov7kPc0yPR9wu2uL4lzz3fRjL3PA/Tcm5GYgwIHMvbTOoHKbg1GCzylvGjXL7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131798; c=relaxed/simple;
	bh=gOdXd2Rmm8cXM0D5W3165GA3J/U/aBwwT4gLU6Y4ZWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L+7VLhClXzzY7JBmFuivI2abnjRHIsX0L4x3JlFTWCHXxUEJyp1snxzqs2ihn/AEHKbEsPLkWT9SIWKzoM/6vFTPFAJWDZQNmQpXCkne0wYLetaPPSEBKJZ7TuPImbE8ekTAdCrSnq8TNh+ZdO/TgpuX8ReXwbfgZxGMinoNhW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORG+lCv4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORG+lCv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741131797; x=1772667797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gOdXd2Rmm8cXM0D5W3165GA3J/U/aBwwT4gLU6Y4ZWs=;
  b=ORG+lCv4Cnw5S/UjzA8V0SkwmD175e6l6FZ6Nz4dT6XMKJMqQqppwvIh
   LhGMn62kCZpIXYFmiMokiASMCmhjX8rNKz5o7DmzSkt4S4Txdo4JEfWtW
   8p4VFI4miYsa8g2Ozs8EqxpPfj0WRY7V14CU1k01GZr6CX/icrEDCqLwg
   V7udWEgGP02BJCIEjJGIl9khdloirrzZqtUY2kb0GQ40K5aKBNU76Od5k
   WjWSlJj+hWAcI9H7iyOxpwoRk/PHy+BxhqNId2mnH1VaThlUdKwSswTvT
   QOpaFr+PrR0dcinB/6e7lYSe9e/Kh8UNPtuG4rW2ISqGvMHbwKdnBrCkR
   A==;
X-CSE-ConnectionGUID: Tf5+CmZXRKCgZLVHgIGteg==
X-CSE-MsgGUID: K8//inldQ+mlwTD46zQnSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53064713"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="53064713"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 15:43:16 -0800
X-CSE-ConnectionGUID: dWNtAQjOSdGA87i+6mXaKA==
X-CSE-MsgGUID: 6XCzloIhSH6Xgxsu1Q5a7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="141772134"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 15:43:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 15:43:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 15:43:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 15:43:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imu8GJtSEeGmx5KtjpiuP+dbkChOuxrzJtoqQx4F/ffqwJFmXeI6hemYRkQiGYyAq8QsNpR4/iHT1ifk1HAMmkuf9UE+ozpgD8XnFqKoLWGzenaJ4QkncJjhhMMJ63Yj5n7xlBHLa0Z2XNfwaW8foXGb1GQ3/iayDNllWztOlVLMuz5CzXT+skEkCjGZ6Fa4bShSBVighuqm2J6JNsGAMrK3P9aXE40xdKzt3CQVQmnClMk/wfZqQyUSydPGB65XZScl0AiO8ejfr9cnc7MgCgQZhv9p9svlKSqRHZfGRhbwMOhNefZ93o5V0ccmkYhEWslfjoeV0Ot/r1mP84KDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGfRdliFBZMjQ+92qlSVUXQuieYLqpg7cMtHDXIGA2g=;
 b=M0QReD1fTHyJkIYsirWg9P2tigphjySG8dX0w/ppBOjE2HBwhXRm+5qTAb4J9CS8AYNKSqo5KLaskUnJhnWBYJrkxvYc99iSNUHGNkmVaR3uzG86oAKyfJHev5BS3h6md+qKyVFexbjXf42oJDgOm0SlzzFHwHwPBmSYu8+Y0NmPkqKVWMh738U/Y/np4+L50Kdp7JeGMvJqrolCbVZiLiw7UMMZ07DQRlaZAsYT1TFT7Ywr3ftuPbI0xo840F1XzlDQp4ZohjB0ICpIVoQG7t9JhcPO6hZJml574qEPFyNEBm8mLzzJ4tUaLkfb+aTahZ81HCJBF94nNRJA2RIU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5102.namprd11.prod.outlook.com (2603:10b6:a03:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 23:43:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 23:43:11 +0000
Date: Tue, 4 Mar 2025 15:43:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Ying Huang <huang.ying.caritas@gmail.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>, Li Zhijian
	<lizhijian@fujitsu.com>
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <67c7900c976ed_24b64294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250304043415.610286-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304043415.610286-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 095a7c74-ec47-471b-0cc9-08dd5b7652ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XSbNt4qAmOdpa95zuaQXwnAFfXTgK+3wh0aaRBaf62kWrTaSY5buynOHY3ql?=
 =?us-ascii?Q?iM0p+uMxE4Z+EXTXA2rDJuqn+TFky/SZc6ErZmCEW3f7BpzS6aQK4diryRzB?=
 =?us-ascii?Q?SOgp7JoOghxgAwW/ZoKwXgJasOJSjjt+i8Ek+HuxaAgkchVgJnIPNnZDiIHl?=
 =?us-ascii?Q?mOGmKXKbxhi4N+HVKtFLQvlIYOEdbQsUx0HIi24XVu7ChABiPMltDZOITDIJ?=
 =?us-ascii?Q?GfmtDPS2dl4B0m7bhN3/SaJ2zbiChdnOf8IVJ3Snf4f1jopwVSyu/lktujtt?=
 =?us-ascii?Q?iX9bs3AZNZNRNFitq3HZ1HWT/BqU8TC/syHOXJaoVVnOjpQWHdlLnwRjAFz5?=
 =?us-ascii?Q?6XXipzsdncaay2NRwWticGSnQJXIRCxGuAOv3Qy7LVMo+fEjrGaI3S0pq6cs?=
 =?us-ascii?Q?knihmcWyTTruGcA5AdrUbAx00qdycLKXohRaOIFxY3B9QAp9oc26Si9l7jzl?=
 =?us-ascii?Q?IHmbCN5dyOkSncTrkgIpwVJxMu9c7uspuStIcrMrE8Fs6pV2YXqGRXcR0npe?=
 =?us-ascii?Q?3eR5E/hHJfLx4Ke5DqTlI5ohpvI3Aiximb2uuYd8uN76eFzjePvg4Kxb5wgq?=
 =?us-ascii?Q?UcDUMzD+dbiAKyCsMa3WQaTOVHhqSadu7UE0ZrFeCxVgKaIa3mW+K7sTJ5YR?=
 =?us-ascii?Q?hLpFImw6iYLIsWqabOeWSaH23A5amgHYOF0zQBHuVVCc8P8p3x9jffQHgN5t?=
 =?us-ascii?Q?Vb65FIUaj42qkDTUNCjaXFAiHPU19gbuEoJzFCRNsdwPleh//EyHjndmJO41?=
 =?us-ascii?Q?C7Jig4Vke3N2RYUbsbG8oeNfM9MMbdwdczhXybAkUv+JyEsyFcXZ/HOsDHKw?=
 =?us-ascii?Q?M254hJ7eK3P1WaPN+/y6rkPgX6t5LgM5nVPqPdVD9xrvLqevwrb9BVKhbLFK?=
 =?us-ascii?Q?mCR3CPke4lLWbaAre5VXCaHtzmHUAAT1JrrKD6vSaWUdehgvpWatOFwXwNHY?=
 =?us-ascii?Q?xYyI5zM66UsnX9T5PgLsOlU4k9V7d/VPWvNZu2GKT0nIzQ0M2zldsboIjexO?=
 =?us-ascii?Q?lFqHPFHtZcJaQNz1ALy/8qFzi9TLjXPpDJwLuqRsfJQF2F/NABuMCVU7xL1Y?=
 =?us-ascii?Q?GbH/aWSRS8M37DyG+WGcD5QTXh9sZcZz5BWdcy5hCNy9GCXORwzHFcriedG+?=
 =?us-ascii?Q?f11tmqgBgold8ZteVfRlXmoe4Nd70daD1eGFC/f4ARLXzPgRFFrtkOo8Z3zQ?=
 =?us-ascii?Q?eJWHXlUsYhrxCWum0/gfTSpDQ62iBUW8g0gYmjUP6oIIRs04KpQTtmakBJ1t?=
 =?us-ascii?Q?FPdisOf1h/wLUxBEI+SczzcVfTiyKURjZJpuNiecMO9yKaFbLB/3LoadCeKO?=
 =?us-ascii?Q?M8wQXHAsoZCjsTweWDURznwzKX6CiPuewAlvXP21lnBNBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+DrZ7m9K7ESq9xTXLiOfKETaUnFEGZlMkBAtkDS5mjzo0ToGZ7R/QwvtTCA0?=
 =?us-ascii?Q?Zv1rCctXUkmKSIS56QI3bYA4LJxgRnOL+3bCVOiTCd+wgXnsK3y5ICqUgXz2?=
 =?us-ascii?Q?sUgPhibq3CwyGnz5qo8viw+v3Spt3d+TJeuD0uwi/QwiRGqJkj6MYzEcFlfJ?=
 =?us-ascii?Q?1VGfVz8e1k3RyQUX/k6gf1j0fZffa1ppWj2SKgZWTVXgnHxXrha3AKrm3RGb?=
 =?us-ascii?Q?UxSP0v+R7FfTdzTrx2fq1TOu9uKC9dpsfGiFg2sBizRJHSDYKWbZLZShQikm?=
 =?us-ascii?Q?FIXlRqbk/W+2hbCmZZT8qAzfwrahQvqgI3i0szPoaf1aRk58WCPI4J435h2m?=
 =?us-ascii?Q?Ph4z/ESnLuoc/CBqKdnav/X92oe9k20aGbJoDKj4WuP9FJFUuosfja2qILb1?=
 =?us-ascii?Q?8k2DhGQLq50gg9hbaQMNoKhdWtsQrNgcSsWti2oAZK58OZnGuykqJQlCRcS7?=
 =?us-ascii?Q?6VH8cjcJsX9qHafiv3z9ORT/uTZDNILjnuLBJu+rBNA07qmzZ0Zh83oizLHz?=
 =?us-ascii?Q?vZr+qJ3fGxAItdppbn4aVGntmxptMp5Q/iCQ6cqn0IZDjcmz8iAP4HX9fVWD?=
 =?us-ascii?Q?p0C//bekCkx89hXUsqlm8VSLThj0e6gKY7DCtQuyis9Yv6rutio/ZZecLAEK?=
 =?us-ascii?Q?9kwVZ/hNKl68IvgsBr7uNwPFEgMLOg7trOvPR9YyLfYj7J/kab58sVzMgW3f?=
 =?us-ascii?Q?zMb3FeB/kIE74LMVPo3ExXNrFPvevNGTd1/YEgrg/DFWfNZWPZC1pblQtt18?=
 =?us-ascii?Q?HkZaO9e+n9K3U1em4dKmIG5dUab+V25ttcbXpCI1msjhtAqCtbNbNtSTYF7h?=
 =?us-ascii?Q?w0W1xbQvQe/7GuSAPzG3sWkDr0Vuc8f4UTY2JPsnzQ1o17xAOKLKGwOjTNXe?=
 =?us-ascii?Q?83I+GeW96PyjdhYKUYcOgtHw90VWms/vK81YmTjEs81bOJm7r4viHiHCKDwz?=
 =?us-ascii?Q?fOG1pYw7LyNlhxLPKD91YEbqcl4SF2UY07n+d5UK08EQocljah0aLrda8NGX?=
 =?us-ascii?Q?2FxswlO4dHb4oBw6krXF7mxxON5e7VAPy3l2MXNy53Hm3Fdm+y/K2E6qLOHt?=
 =?us-ascii?Q?4inDohymlV0xBg2J7gIC/7ATaU9N+mdwu7bHE2TrxSyHQqgSYbe+gPoMi+x5?=
 =?us-ascii?Q?nI4/X1UJnng3J7GFrx8X4N4H0pohXVWasVTwA4d/YcmoOdWLGNaUQ1VYA9eq?=
 =?us-ascii?Q?B2lrlYj+DAHVnqE/8jY81XNyKkpFLR0WB1lKvJIM2JHVkqKtv6wlJoYxn+Bo?=
 =?us-ascii?Q?+LspKnh+YXVbIhtiBJH8mMVqAig8R0ZaQa3sTtQUAHejQSNV2rnQpg7SmELY?=
 =?us-ascii?Q?dZBIs667sPtcKUQCm3obatDeNqB4enQlGOF3+w+Xa8pQ4Unt95xOhXt75xHW?=
 =?us-ascii?Q?5VcwsS3Z+Y+/tvCzurCVh5q49TD7ZTIpnClSBsLkMD2qfYbFv1Qk3hkeWJUY?=
 =?us-ascii?Q?tebd1MqP+0/XbmamaLWIn7mjLhjuQTB8aPjfpxDozb0EJOp7gwqnyt/FdfMe?=
 =?us-ascii?Q?dYErmqWPQ3gZXPMr1Oi40YoCb2hSPpGXHLLB5wu5xz7IspQ4fgXe69ots6Dq?=
 =?us-ascii?Q?Q+QeRHkOktkVXELzmndN5lvv+SuUO/5WD8F5d6vESuXzVY11gbFo+QYx6yEh?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 095a7c74-ec47-471b-0cc9-08dd5b7652ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 23:43:11.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4WQ6yLD8CTYD67CpJcLEY76kQMq2US/ODtmxvMN2k/7oIjClf5tj0AY/3ShCqBusB62AIfGIA4TzECJLlX421Jf1Q4i5BiY30R3W7jvIj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5102
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> The leak is detected by the kernel memory leak detector (`kmemleak`)
> following a `cxl create-region` failure:
> 
>  cxl_acpi ACPI0017:00: decoder0.0: created region2
>  cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
>  kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
>     __kmalloc_cache_noprof+0x28c/0x350
>     get_free_mem_region+0x45/0x380
>     alloc_free_mem_region+0x1d/0x30
>     size_store+0x180/0x290 [cxl_core]
>     kernfs_fop_write_iter+0x13f/0x1e0
>     vfs_write+0x37c/0x540
>     ksys_write+0x68/0xe0
>     do_syscall_64+0x6e/0x190
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  kernel/resource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 12004452d999..aa0b1da143eb 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -2000,6 +2000,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
>  		devres_free(dr);
>  	} else if (dev)
>  		devm_release_action(dev, remove_free_mem_region, res);
> +	else
> +		free_resource(res);

This looks deceptively correct, but if the __insert_resource() call
succeeded above then this needs to optionally be paired with
remove_resource().

I think this function needs a rethink because mixing the devres, devm,
and alloc_resource() failure cases makes mistakes like this hard to see.

Here is a replacement proposal, only compile-tested:

-- >8 --
From a01a28304e547da1f6287eecf3aeb0ebc6f48e2b Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 4 Mar 2025 15:12:19 -0800
Subject: [PATCH] resource: Fix resource leak in get_free_mem_region()

Li reports a kmemleak detection in get_free_mem_region() error unwind
path:

  cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
  kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

     __kmalloc_cache_noprof+0x28c/0x350
     get_free_mem_region+0x45/0x380
     alloc_free_mem_region+0x1d/0x30
     size_store+0x180/0x290 [cxl_core]
     kernfs_fop_write_iter+0x13f/0x1e0
     vfs_write+0x37c/0x540
     ksys_write+0x68/0xe0
     do_syscall_64+0x6e/0x190
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

It turns out it not only leaks memory, also fails to unwind changes to
the resource tree (@base, usually iomem_resource).

Fix this by consolidating the devres and devm paths into just devres,
and move those details to a wrapper function. So now
__get_free_mem_region() only needs to worry about alloc_resource()
unwinding, and the devres failure path is resolved before touching the
resource tree.

Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Closes: http://lore.kernel.org/20250304043415.610286-1-lizhijian@fujitsu.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c | 105 ++++++++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 45 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 12004452d999..80d10714cb38 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -172,6 +172,8 @@ static void free_resource(struct resource *res)
 		kfree(res);
 }
 
+DEFINE_FREE(free_resource, struct resource *, if (_T) free_resource(_T))
+
 static struct resource *alloc_resource(gfp_t flags)
 {
 	return kzalloc(sizeof(struct resource), flags);
@@ -1631,17 +1633,29 @@ void devm_release_resource(struct device *dev, struct resource *new)
 }
 EXPORT_SYMBOL(devm_release_resource);
 
+/*
+ * The GFR_REQUEST_REGION case performs a request_region() to be paired
+ * with release_region(). The alloc_free_mem_region() path performs
+ * insert_resource() to be paired with {remove,free}_resource(). The
+ * @res member differentiates the 2 cases.
+ */
 struct region_devres {
 	struct resource *parent;
 	resource_size_t start;
 	resource_size_t n;
+	struct resource *res;
 };
 
 static void devm_region_release(struct device *dev, void *res)
 {
 	struct region_devres *this = res;
 
-	__release_region(this->parent, this->start, this->n);
+	if (!this->res) {
+		__release_region(this->parent, this->start, this->n);
+	} else {
+		remove_resource(this->res);
+		free_resource(this->res);
+	}
 }
 
 static int devm_region_match(struct device *dev, void *res, void *match_data)
@@ -1908,43 +1922,19 @@ static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
 	return addr + size;
 }
 
-static void remove_free_mem_region(void *_res)
-{
-	struct resource *res = _res;
-
-	if (res->parent)
-		remove_resource(res);
-	free_resource(res);
-}
-
 static struct resource *
-get_free_mem_region(struct device *dev, struct resource *base,
-		    resource_size_t size, const unsigned long align,
-		    const char *name, const unsigned long desc,
-		    const unsigned long flags)
+__get_free_mem_region(struct resource *base, resource_size_t size,
+		      const unsigned long align, const char *name,
+		      const unsigned long desc, const unsigned long flags)
 {
 	resource_size_t addr;
-	struct resource *res;
-	struct region_devres *dr = NULL;
 
 	size = ALIGN(size, align);
 
-	res = alloc_resource(GFP_KERNEL);
+	struct resource *res __free(free_resource) = alloc_resource(GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	if (dev && (flags & GFR_REQUEST_REGION)) {
-		dr = devres_alloc(devm_region_release,
-				sizeof(struct region_devres), GFP_KERNEL);
-		if (!dr) {
-			free_resource(res);
-			return ERR_PTR(-ENOMEM);
-		}
-	} else if (dev) {
-		if (devm_add_action_or_reset(dev, remove_free_mem_region, res))
-			return ERR_PTR(-ENOMEM);
-	}
-
 	write_lock(&resource_lock);
 	for (addr = gfr_start(base, size, align, flags);
 	     gfr_continue(base, addr, align, flags);
@@ -1958,17 +1948,9 @@ get_free_mem_region(struct device *dev, struct resource *base,
 						    size, name, 0))
 				break;
 
-			if (dev) {
-				dr->parent = &iomem_resource;
-				dr->start = addr;
-				dr->n = size;
-				devres_add(dev, dr);
-			}
-
 			res->desc = desc;
 			write_unlock(&resource_lock);
 
-
 			/*
 			 * A driver is claiming this region so revoke any
 			 * mappings.
@@ -1985,25 +1967,58 @@ get_free_mem_region(struct device *dev, struct resource *base,
 			 * Only succeed if the resource hosts an exclusive
 			 * range after the insert
 			 */
-			if (__insert_resource(base, res) || res->child)
+			if (__insert_resource(base, res))
+				break;
+			if (res->child) {
+				remove_resource(res);
 				break;
+			}
 
 			write_unlock(&resource_lock);
 		}
 
-		return res;
+		return no_free_ptr(res);
 	}
 	write_unlock(&resource_lock);
 
-	if (flags & GFR_REQUEST_REGION) {
-		free_resource(res);
-		devres_free(dr);
-	} else if (dev)
-		devm_release_action(dev, remove_free_mem_region, res);
-
 	return ERR_PTR(-ERANGE);
 }
 
+static struct resource *
+get_free_mem_region(struct device *dev, struct resource *base,
+		    resource_size_t size, const unsigned long align,
+		    const char *name, const unsigned long desc,
+		    const unsigned long flags)
+{
+
+	struct region_devres *dr __free(kfree) = NULL;
+	struct resource *res;
+
+	if (dev) {
+		dr = devres_alloc(devm_region_release,
+				  sizeof(struct region_devres), GFP_KERNEL);
+		if (!dr)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	res = __get_free_mem_region(base, size, align, name, desc, flags);
+
+	if (IS_ERR(res) || !dr)
+		return res;
+
+	dr->parent = base;
+	dr->start = res->start;
+	dr->n = resource_size(res);
+
+	/* See 'struct region_devres' definition for details */
+	if ((flags & GFR_REQUEST_REGION) == 0)
+		dr->res = res;
+
+	devres_add(dev, no_free_ptr(dr));
+
+	return res;
+}
+
 /**
  * devm_request_free_mem_region - find free region for device private memory
  *
-- 
2.48.1
