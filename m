Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6235958
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067717; cv=fail; b=gLoiqNxJyafacRPI3L8vln5/8DQBW9IjEV6+5PFihmMH8pH85X1fNDZCc1kso0Bsaa2OKoC1wDmw7DTTbvhqYkuFeL+jBJDQdr92bIubAmgMEGksFWwMyrVOOtBghFJI3ANWHFXGaiv52bLgmM2IKWgGKj9Rvs4A0LayhxtCzFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067717; c=relaxed/simple;
	bh=SQ3LUhN6JF3m32wi5FS3TDjE/fm04P4TwBdIqtUkB5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pX8kAvoHGdeuEXqtOItPt6FGuHKgHrBkmkmTcaSM6gpeOGFDmuYdLbBJ4W2FM2JJpPU/QEH8DHSCzjGooQfmWlYuJoDBs405e3h/NRlPhfE3V7k+JMDkuFvS0oMiP7wGHyLXLZVpaLLpazZt5mS867lhKCYdm2xWVmoV3xicWtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnVnjv5h; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnVnjv5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067716; x=1771603716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SQ3LUhN6JF3m32wi5FS3TDjE/fm04P4TwBdIqtUkB5U=;
  b=bnVnjv5hOi3haG8Wg+WwQ341jmyNGHLgpUO0lOVQOd9Y0m1QIEZVcOio
   dm4rqJWBEygPPL/1Af3+HkI/5NUSUgBFvzpqkB7c4EsAn9rp9BG/0L2fm
   RjFVMRiCeSabks3JyHtPq2S6EVbz+EltRVZ3HQc8zXoeHgsWdrpp+Jnd5
   vYKOKoEOhSkmczFRefjMpFzcwIaog3491bW5TZhZvhGaO0wy0devjYbyL
   vFMgHrDA37mSXuLDmXIDCAMXhs8iRjNwP8YR3HPlxZQzeXSHw3RJjfZil
   WFvHmMFxrN+4v3S3WZSli0QdOSYS5co0pq4Ycm+oxlbcxtAdNBuddILLE
   w==;
X-CSE-ConnectionGUID: 5OrPWlXNR2yFrz2xbVRAew==
X-CSE-MsgGUID: aU0FOm1qTz23tIrpJkenPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40992195"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40992195"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:08:34 -0800
X-CSE-ConnectionGUID: M1v8Eis0QZi4JHVwuI/agQ==
X-CSE-MsgGUID: OYsGWZoFTE2uQmFfxARRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115747985"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 08:08:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 08:08:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 08:08:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 08:08:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/gJ1/0jAvV5aC89vmg+mrcuVvk5v4vrtXy7TrcSFfhzc9jsr9z/ayz/+h2SoDrV/I6OktePPHTWetv5TJYzxjdk3ohpkJKIG67YIS3pBwJy6SCUxxAE21M+Dd5ayLjJoUxiiCqG7gBtNFx0zMdZWS7GG9um1WirHRvMU1aZBIAfSwu35jnSu6F0xHznlyoCePHvyua9MthFXzcytElp/WLLAQ/GC+SECrlwgN6EjxzZ+NF7+HU1YeH/HBqoZXL9N7SZD76eWXAI8367fFQ50DXd+9JOMIzjOwYSEdQcgM4Z8g0iiltsd0mFgEEMpmYsvbvOwY1ltaVcaUQUV6Lg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojEjy7uugI8qh/ObdpzxUoC3CE+anctI1nBRA3Cr//Y=;
 b=J4SMEhsLZi0/Ns+JFaONbwkWVGzc4pWmaU7Q1tAfzpB88Ka6MnaxDFE/nos21bCRgzc0W6l64HczzwC1TfY9TzFsI+IQz42B1dtoaYApKsfkmBoj5NbLswnAv8DrIj6IjjmduCU5wxFIhRvvpUUWTWVu47NrOPtW93KEZ1fS1PqaTghUqYoHTqmhhktiU/PtFOhkk6lqx3CrVL3q3uUDaOlGHaj2Lul52ZQbjDBIoaSB+YY1YUBU8gtouCbp6c9AeXy629CDLRolHOcuBqgs4wiPaii6QysPogg9Hqjq3csoPJYqTD6HMQE+QeU2nCpywmcTmAiCI3EXInEbCdqWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 16:08:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:08:25 +0000
Date: Thu, 20 Feb 2025 10:08:21 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<ming.li@zohomail.com>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<anisa.su@samsung.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
Message-ID: <67b75375d4e9c_2e08a129483@iweiny-mobl.notmuch>
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220013604.263489-2-dave@stgolabs.net>
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea8e6e2-b78a-40e3-b3f2-08dd51c8cdfd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AaMem0g7eO/AbbcD38fOr4oJYOd9JIzTNqiKvh10x/UXGfT7fa61szyuY3cX?=
 =?us-ascii?Q?qydrJ8o4Op0PeQ3/GHTLF3rVpcfEICtI1BXiqixsI/ZwG1F+LQmtC4Ubz4I5?=
 =?us-ascii?Q?40b+SICX8JeVS/mYOt8z2RmkMJXZrS5kcvhTz8HuUTBc/7ft83nCzlgQSC5c?=
 =?us-ascii?Q?/FZniJhpsvo910u0gcgzF+V8lYWeKAHTn2zjD40YJavYSR8Fp7rsFY/jiWH9?=
 =?us-ascii?Q?P3bpDKFDuL9VX889WP2XfHehXlV96KoKNCjgD/p1BPMT2KqaYi87IEaqblv3?=
 =?us-ascii?Q?l8+V9AzkVsQ6RK8X/xpfsJC+GBnNMxS5dJ09OzFAWzcoUw8pcTZcLQH/WEhF?=
 =?us-ascii?Q?WctYkOSe09X2f9HETshv66CJfYUoeucBskgeXRcjD5CXG5N85Lh1vmgiUIMR?=
 =?us-ascii?Q?49Ah37pK8V7NNtH/Ikc7ySC1qjNOqYXbJUeDQywcGK12wqVHdQFR4kbWsaxW?=
 =?us-ascii?Q?gGK6mDgeJK2HHX8a7Jjp5wts9o6hRsj5R0g+RZtVzH84hLz/bsKyp1ipncD2?=
 =?us-ascii?Q?Ruz9uJCiYwinEwIYKJO8+EdvLk5pb28YtlWRK7/Mg9+rkIX26FoY1QgEkYZ9?=
 =?us-ascii?Q?ZzXCBvA0PHF9vpTsFiD7/G6b0Tq0miUM0FPXwFjAE6AOYxH5a7cchTpFedni?=
 =?us-ascii?Q?egT4UzFCbjqWvy21yrHk11KOiOdW0KjLxlkpTEMeQeFbtrAmuJMkxaUxB96L?=
 =?us-ascii?Q?2Axillzf9snW3gawneTSZkdE9+adU20CskxLLumU80K5HnSaXjsTTNaqx7UR?=
 =?us-ascii?Q?yidl9S8iBLSNVu+bz91nUrFX8Iuc6lSDTpIcRigJCUnUfun0G+p5dXlMT/Dx?=
 =?us-ascii?Q?k3PGjDy2UrmYC9bfA7Ojx9jQoi5Op2fPna1/4/zJWJPzWA0Tp0D9VG3lF+Uo?=
 =?us-ascii?Q?BvVELbcKtf39lQGwwkMEEBeaiOfFQ/BbpQvQjEOKM8eSCLywtX/wjHvZMYSo?=
 =?us-ascii?Q?9elzyJQUhuj2NqWA4L2vaAIUTKYXNCM/mT85T0mdqqaisgKXvSP4YkNWAANp?=
 =?us-ascii?Q?AOtnI4YkDmsuWJox2NjpN8tTALyPy2agOce4YDjdY9aC47tgY1U6dgfAfnnX?=
 =?us-ascii?Q?gU6z28iYHvqaC8ZXdWBWQ/Z0P1BjcGE5c6jfw37Y7zWsNjEnxmXoZ05yirll?=
 =?us-ascii?Q?9Cqms+1U2OSRKM4TshHzVFQE8PxmRuGekbs71YHbWULmj6ubBTPCcH9XUrlz?=
 =?us-ascii?Q?VF8nQVWlmMepGSm91KCJsP1PjmoYcyNYaoE3EkT118AJ97n7IwEVryZweJGq?=
 =?us-ascii?Q?qyA4e5R2D/d5a1Y6WigdOdXbqbeTxRqgiUPX97F9g8uBLWIdGZL8Qs60scEZ?=
 =?us-ascii?Q?BNVk+1Dxaq0OuZiGqf4Hiib8HK57gmJPfjrzKtsCt+ICRg2htE1zNx7osQon?=
 =?us-ascii?Q?LfoT+Ilrf/pL8aD4aRKtxdcErgtD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reSL3hEAKF2eUKULNayZLxdE1GhkUNHxyCcb1dYixR5JC8x3A8Cja7+x5opf?=
 =?us-ascii?Q?m1tVDyU2oII+GO5LSykc8m0AB0ldyK+4x5brMJPv4bJ+3d/3g44Na6X/WNZj?=
 =?us-ascii?Q?wFkFvfMnUOvZWwES/1RRWKTWQZO8+siia3lIwQipwv30gElmz+supxA0uzbA?=
 =?us-ascii?Q?rp5jf+a+vfkXOkkazzDNglYferB2XOVl5SUOm5Y47Ioc+nAq0vF4BVGNIt3V?=
 =?us-ascii?Q?n57Bpdno1TKm1YXQ5KWkoJoPZFtAdIXbLLOX6pXhO9xd4Ky77uNQTb0H6kbH?=
 =?us-ascii?Q?+6tSTSOukGJZkOHos/FwjJFTfqY9+OBxGlZKv1ZP3wZcNezmviF7QDMrhWl0?=
 =?us-ascii?Q?H7QvgWaPetk6lsggyr/xiuJgl5lwTnkqSo1mEYJJnkEW0sv5MMH5hfrWxPu0?=
 =?us-ascii?Q?FqHgFX5dxiVRgz2k34KOgDSNNsEw61wl5hoPjMVsvKP4GK6MiO1vwtdf3P+t?=
 =?us-ascii?Q?x9AFy5OBtx9yTplUgoxIN1ysKHiq90RZoyViSb0BdAdb+681e+3BCuX4LxTk?=
 =?us-ascii?Q?gmCuknvXrs1W/7d/MiEdj2z1M+5OSAEqGJQoWoeBGwVAm6aaPt1qoidi3++k?=
 =?us-ascii?Q?Ixs6fNqV1WTJ2Cd0ADJysF0yYKZ4g1gn+6RMxxEy/c8FEEgqR4cWo87lajEH?=
 =?us-ascii?Q?lULX6ikl7n5u3rK0iso2skly5EWx/q4KrIFHtDlmgp2YG4xJXkVsQh+UBSL6?=
 =?us-ascii?Q?drNLSrcZj+EQiXBc2h9MdJ22ICQn9T4RV5xV+9VmwXxSGkEyARYytVhFH/An?=
 =?us-ascii?Q?qmEY297lTUszo9ndf3Yc8Ln8Um664PmmvBg2jKSeZTywDbUDfBLRpSlxZO37?=
 =?us-ascii?Q?eJRtN7u0ykZebm5JyfyO++EASNB32gRq1pxXngryZ8U2XKQqBIPfds+FYcdW?=
 =?us-ascii?Q?LknTGxGpsDFS+8Xi4cm5SXuvDcUtLnEyBJwOb+qG6bCAXij3IOHlu7+Qu5GR?=
 =?us-ascii?Q?uxxbDGFL2PUxLLi0tN9prmClRcorUJQlfoW7ggs9MEJ+4/uPcx4fZqZJ2xqU?=
 =?us-ascii?Q?7Ky96Bj0LPP2zyqoQ37wzPQiJG9WQIKtqDEvtLcwDtawbaJrw6ekJnRWEQ+E?=
 =?us-ascii?Q?0RzFCLPsDqsuhLRVfQsV9UmVfC2vXqW1oB3W0uOWsmHPzz0mo6Iazo59wVu+?=
 =?us-ascii?Q?Jq6aVJ5ulaUK8zihiZJN5aPQBItY5Zj4CjWpA8lOX9SMnMV5uqh46yOP9/B8?=
 =?us-ascii?Q?JMxxT89HgU9QMb+xgMwlMLsN2vPNSxCBMGZqCbWxod2Sf6lPR79OrHAvPHnf?=
 =?us-ascii?Q?/ALuiudWDJUhLVXhnorJyv1v53O6ga8ddFQnRM2ka8HA3SQLaPtViSGXiqOr?=
 =?us-ascii?Q?qjEJ6uc4l5CA07OB2Iyi0IB9cEYj/HE91BYCnLr59LasQ6RD3/Zd8eKsFuGy?=
 =?us-ascii?Q?iGXDPeDU4AT/0kRAgWksHAGwfWsMMrmD4MnuXp3eGc7zAqaGa+Gk14VbnP3o?=
 =?us-ascii?Q?kxKuRySTiQ8oN9VheCquilKc3rPX/tAUZyqHZne9DeSwLmGzaShc8HAEa5II?=
 =?us-ascii?Q?oDrS55rDxIthkPXn5f/laz6juBMETcBVd78/YmMd+zb2bFQInOSUVSMM7Bok?=
 =?us-ascii?Q?n8ieMTQbD3fe8SasEDO5oG5OTU485r2hZGFnQGYl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea8e6e2-b78a-40e3-b3f2-08dd51c8cdfd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:08:24.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSIXOrwfi+MiD3LqKTwOr3q1Z/46kEorlyCicA+Ak8mD+5j+VKHwt6dwON0aYUrIqt0E5CoRPg/LC4vSxUiWLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
