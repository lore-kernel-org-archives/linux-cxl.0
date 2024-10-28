Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403F1D2796;
	Mon, 28 Oct 2024 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150991; cv=fail; b=qP52P/ljGTb2aGaPa9qyX+Nfzwdc76V9L/b8bDpeNxlMH/0XuUVfubqpmvkEly5bjxs3EZ/x3rPhqfykkJKfXkjo8RzumgKQCgAvqlE1VUmOV23W5+Dfxxk3iYGWcoSdPSXdpnh73gEjZeVqECB/EkgespBx9HGpLV357GRn6dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150991; c=relaxed/simple;
	bh=ichky8FsL2d2dD2oxS5OUmpLsgdok5NIvx2KXuX9FVU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kic65PXiHqCrg+Y+z0fXhHjZ9rfIbE4HCA1oJn60pY4GzmvyBCk0DwYnNW78pVQeRlrm1w5jDk6EGdVjfaNqH2sE9tHKygP5ltd133O126ptm3wOaes2n4lk/19wLGgLbAXZ89Ga4MtlxiqxcjcVAkAM/Tnus/B/3B2Xl2UqlCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aa+93kXg; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aa+93kXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730150989; x=1761686989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ichky8FsL2d2dD2oxS5OUmpLsgdok5NIvx2KXuX9FVU=;
  b=aa+93kXgevYO5QLrxHX9CHI7kDGlorn9JCKRtvA2hgYX6YjQhIRKzCyc
   qIsZNZD7QcaLUFQxEGFDOyHGgC19DWXmyV/IS+gwsQGgz30k6r6iKPw+f
   CedUggBAVzfiNKSdw4cw25JNigJMaJxYZ8j9aikEQAORE1DCGLfE4Llo+
   8e0OQqiwcIl4vgJy25x9ijjm8vHViE9hVR6VeBUR84b9UZJmUW91pC5Mr
   HLqslL4jjFfcf2J48gRqS30qBlGxX5xgzHWaNHZVW0mANCKYBUtuS4HtL
   MnVWo+qnHQKgIo/PBaNHnzBhN8lTxiGrWu2qjp+7fNMy7muDnIqJago+6
   A==;
X-CSE-ConnectionGUID: LcmWUNCbQoOjb96k0VsDxA==
X-CSE-MsgGUID: OqxFmKnnQCKyFiLPow3lcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29540861"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29540861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 14:29:48 -0700
X-CSE-ConnectionGUID: DHKMk1MKQMSVHr3vEfNExQ==
X-CSE-MsgGUID: nmNHMAGBTCOpv4EcAhp9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81901551"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 14:29:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 14:29:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 14:29:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 14:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKPgXqZ6bb2d0bj+fWanefwxlA6BRk9V8QXZ+MhXEYL9U291F6kHVjeuPRxve33MkFSXdTxHZVYVJBYJ/jkATFqxzJtbHc8Iw2NO09WiZNJQXuqOPZDLLkFQ3nS0a1a36jQXmUNbCmW50tkLAH2hWCsNqbjUMI5Rg5eDRRo+CVyAs/MjImq8Bp4bmvVINlqyyGdgWgNJgkSRqx0C3y2Q79R53902hYSXj/WWA5EQ3SYS11gr/KOSdVI3T4ly/1Nvi7RyztrILhW7GjxA70jmnhSke+P3fg2HD7zVcHVDU/TXX+dDKZNoX6jFq4gwot3xUo7+HCft9ggaBt6iWWcquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV8QOwRmmg3h+z1kpOgh7/wjf1ezJCp3ck6NReeLYpM=;
 b=ISX2HQ0TtSXxVnt4EqUNAD7D5me11G8WSuy5afe9jyYFmvolSn4e8GaPgbUYBu1tau50S00tGOSfGeuVQb0X1bailcJN8iMwd/6fH1KrjSX1y8IlcFD8mXFmorZWUVlOAdqaSEX0LAG5tjgNYQ2pqZ8vUrk7CGfNpvn1ldSojLGXP1cN2oyg5KX0pm8/Ozm2liovqDwV5fEX1GIB3ia+Vk8vWyJSKACcU4gRJ+6aBSs2qtqPU+MWpajGmFRxGxxbMOWogD3gaHASRP4CpiabB4aMXyD9+QA8gfinFLyRvWbDoJOeF80brSbPOKtUZcB8MboKt4GAlQm7sfY8jJIyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 28 Oct
 2024 21:29:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 21:29:41 +0000
Date: Mon, 28 Oct 2024 16:29:36 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya
	<bagasdotme@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] test printf: Add very basic struct resource tests
Message-ID: <6720024064336_865e2949a@iweiny-mobl.notmuch>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-1-123a825daba2@intel.com>
 <Zx9UNA5Ht-RrWFIh@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zx9UNA5Ht-RrWFIh@smile.fi.intel.com>
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c06f96-5d5c-43fd-7c26-08dcf797a234
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ZcEEWjK8hNYjfJMiGVB3KBSjfjHwYNHJ2KMW6gEVX8WA1BrH3aEkTGEuB04?=
 =?us-ascii?Q?RaLmu+0oso2W18N8BPlvR8Rbbmi38HnizALaoiURe9s0wM+VdQLYu/hQuUlF?=
 =?us-ascii?Q?SeaHs0Z2tWY6FZt7vP6B4y49Ci3GUhzAmMFE5mLbep/8El0t1BKTPc2vXtF9?=
 =?us-ascii?Q?TKYlgsUed6dC14QN6dhIpXbtQWc2VEe0lpLdhESf9YcyJ8L2dSIu7nEfDvbw?=
 =?us-ascii?Q?F9gaK2MJanlYsK3WFny9C6YjR2pbjrgJ8HcY5byGU2Ds2+L5eRyYdplFEiKP?=
 =?us-ascii?Q?1LF289AhH7AHTTbJkc/OIioMkyCYAJ77kQZCPHADlfhDulYBcuy1INCblaQM?=
 =?us-ascii?Q?6cjY41uWy8FdI2ALIpBqKPhmFk45cWWwb//J9E2ZyZffLF3wnKPrbI/rshVy?=
 =?us-ascii?Q?jEbywnlYDO6A7BubWxinTXc97OLHAKH0YeDI8g7XiAM/envAGOP998M3cjWh?=
 =?us-ascii?Q?mEE9pVdMLjQh6EwBErYV/nOcf3Qzpvbv0zsewBar0vVpsENo5YQEt58R1wFD?=
 =?us-ascii?Q?dTU4xAFNBMv2vFc6Q1WOpSp9p8hoOvgox7OqVPeaY1DHAby0gK1YhChdj6T+?=
 =?us-ascii?Q?FYe16Ti/OAWQRSqIevlcbNeVHJ7bHsm8+NynDbvRFC2wxI8iXWlcuyACtL3F?=
 =?us-ascii?Q?DSjpakB6VnvPhR48W2FIqo2LUGvM5TI70YaZZy6CZoq1mA8xp+kKejfjiRw6?=
 =?us-ascii?Q?XR0j+NThGWTQwEubUi63GwcQtmHJDuvkx8vp+wf1QUh2wt63h2vMc4UDhcoG?=
 =?us-ascii?Q?JP6U9e+i5xWNGHc5qk47U7uVd3TT+N9rVXBHJUesIvaqqk8Kxb7HI+iwkIAn?=
 =?us-ascii?Q?KqsZD7wWsn5mGSB8OKUH/SzDfN3bmF5VPx5vc9kXJerAYsxqmO/0h0aQ+hYo?=
 =?us-ascii?Q?BlpUa3XPvGkSmC3NovNExB9poTEBOzhKdncSBoxud2kv8iRCkmNY3+4GzZqU?=
 =?us-ascii?Q?cv43IVdtOn2823jvj4tip7SViDdC8ZV8cD1Svi98W8Szdd/gAS5P3ZaXafqg?=
 =?us-ascii?Q?QIHgsXalce/NVz3qJT9opVdX/1qam1RpmOTTrfwSke2NyJs1pGOb9uALpE4d?=
 =?us-ascii?Q?GA6OOX4l8/mBmaRnr92hWaQSE40DLK7g17ALDE/JwiL85hsGkFxAp0etSRRz?=
 =?us-ascii?Q?7MenjSehSGFCddBzHkM/lZ2DM7E+MLa+MiJfEUHfxzXuQ92nWW3fyJOFXoMZ?=
 =?us-ascii?Q?0Q3JQ91P8pmPhj/JtXkLPpCdBv65HwApUnv452YY7nwgnpjDCMvUezLFy6Ot?=
 =?us-ascii?Q?DptoJXTXzQoGNlEigKRb6qs1JmTGtyeaeDNQQZvqrpeuiFxWDscx4UIVY7kt?=
 =?us-ascii?Q?gZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mK9qZXBsnAqoAsQIr6rHCxZNnaSq0c6QjMWFL5b0kTwAnmvr6kZsUmaZqmyg?=
 =?us-ascii?Q?IMS14KQPQU/2XIqpL28Pei1aqcClI5I1mLRP5GTLHPscx0U/RdYUv2dOCBCj?=
 =?us-ascii?Q?6gYnt3Gus41H7dN42Tm3kqxYKTysejJfKq3L0HYgwCVO58B3lliSr75zyeIC?=
 =?us-ascii?Q?f/OG7IAJvFDqqpwy/q2ILjou1ph0sQgrbNBA6Mt9s9iHcuGrC7X6RJMlolV+?=
 =?us-ascii?Q?WNx72kh1/TNXT/CaT2csRJesc63/7AjWm8crLVRvubH3fzTCYKTVNZlTRlhv?=
 =?us-ascii?Q?rgwqyfSlGHqtx5/UwaGHziq5NEq5oZ2MV0Rlqb+Axm/YCqesWganPVKM8MDc?=
 =?us-ascii?Q?5ksWgJvcAo4i+FK6C/YpVDOZywgeqVDd2T6xFmin4pDvfnjcXAkMRpn2RhbY?=
 =?us-ascii?Q?IFy9ayCPu+3Jq501gXbaIBOOaIDW0hWqCqqbEzHg0wlMLYjNsZdRmt/yiw8x?=
 =?us-ascii?Q?ZXd3dsR98m77wZ9/0UwVsjQFPR6WYIQ6uiN+4ZQvfEtaySrEc4JdOKph7rKm?=
 =?us-ascii?Q?KqJGSm9shF2qdXjediFR52v3f/mdVnyamiTbz8lBSX+krwni8kEx2kRw0b+6?=
 =?us-ascii?Q?6cSRzIg68O7KxUD33eYLRKVapzpDh5RC2WMYDzOH+q5spbDzZgPmyDUxzEJq?=
 =?us-ascii?Q?X826Tht1J8BWFVqP+z7hdwoibnr/URfugSzWiCAbbdcZ5RUvfE8GnVHPq3XV?=
 =?us-ascii?Q?NunN9X/amkH65nqhulExWitAkC5BwpR3HjMLozsPwi8v1CcRPp7MT7XqUUeQ?=
 =?us-ascii?Q?cieJSWMFeiicwfbvZe2slk704pEL6RuFjZDfg//vv/STKnDotGd5kMEvic5P?=
 =?us-ascii?Q?iuv/grP4h7zWuNoWyM+3jB3NNZfksjSQUqLPnjhpRWI4ftZ35gbztVq/xBBh?=
 =?us-ascii?Q?GXa9Kuh1diQzFbYLHJmjLUm05vubVrQhC0lstqauAPdXNQQe+aOeVeyNWpA8?=
 =?us-ascii?Q?sVP8lW7lyoRtD9zDD/d12dy16INT3n5B6bvA63elFBLOaBAVTNNgu2Ktv7Z6?=
 =?us-ascii?Q?xn6riyiH2B6aB/jgFqfx5Vz2MVrwU4MArZA1FBLup/XJ8PAXyYnD6koGVjzr?=
 =?us-ascii?Q?LmgPHR7JP33/Qdu2sbDhWU36m39YI7Q7v13TpZ5XE+xJVeYJ1VGaH86rOd4K?=
 =?us-ascii?Q?F5u6alxrahqFGTZ393UNbaQgQJqvxe18FRsVMq3zpB5ZkdW+gtrruVHL2VXo?=
 =?us-ascii?Q?kKcYJX6SCf3JhieQOcFt+L2hJ1/WGFkFPdyZoVDXSfG+CclyRR3FyzrMmv3n?=
 =?us-ascii?Q?38aLBeRyFpMRGlWt/oVlSNJzbQB3/JSewwDISBSMXkcW/6+Aia1YXJvju2/A?=
 =?us-ascii?Q?qCAe1fBfFtehfIzcU+VUIetsnTEt5xO8B1oLpRKA3LrekCu/bWuDOBOk1M44?=
 =?us-ascii?Q?by2c84Mm9xiIYdKaonzQatYySu8qUjjFnfPqtUUmGznZVBo4W/UUPOuPQQcK?=
 =?us-ascii?Q?XHl9C9UldQV2/fZLYvyUYdbQlgmkNhD3qJ3RMNU8x0U9+/STnIz0bw91U+S5?=
 =?us-ascii?Q?WXFJQwrUURrPn9y//jJMO+fMPsg6auW8uyWfKc7vwP7jnw2TOZyHXskXQ9TX?=
 =?us-ascii?Q?/EUFtrs2kByKtZg8tI552pNgW5nN1aCDDRBAN7fj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c06f96-5d5c-43fd-7c26-08dcf797a234
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 21:29:41.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6/O8YSm92/idERlclx2ILhZkvBul5EEGVmzZGBH1+ClsrxIWpfuJ3lrHUUZwub3mOGg5bykMCt8bNx3bdpk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> On Fri, Oct 25, 2024 at 07:46:53PM -0500, Ira Weiny wrote:
> > The printf tests for struct resource were stubbed out.  struct range
> > printing will leverage the struct resource implementation.
> > 
> > To prevent regression add some basic sanity tests for struct resource.
> 
> ...

[snip]

> > +
> > +	test("[mem 0xba5eba11-0xba5eca11 flags 0x200]",
> > +	     "%pr", &test_resource);
> > +
> > +	test_resource = (struct resource) {
> > +		.start = 0xba11,
> > +		.end = 0xca10,
> > +		.flags = IORESOURCE_IO |
> > +			 IORESOURCE_DISABLED |
> > +			 IORESOURCE_UNSET,
> > +	};
> 
> I know that I have given my tag, but I just realized that you may use
> DEFINE_RES_*() macros here.

I tried that but it does not really make things easier IMO.  So I kept it
this way.

I'd like Dave to pick up this series for 6.13.  If he can then I can use
it for the DCD work.  Otherwise DCD can go ahead of this.

Ira
