Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B50FC08;
	Thu,  7 Nov 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015329; cv=fail; b=Tr8BhmXF3xErQ11jWZfWt4b3qrKLrYhazpNsm9Xt0Ihripiiuh+BSCHDbAJQehFQf6+qkPPHdEFWAxdJkifprvtKCKcuGuXn/q/8RoYJS1V7C6G7aQ5Quxco5aMFNR0Plkc7AsR2FnFpVVYsaJxDknL+++DTpi30CGh201maW90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015329; c=relaxed/simple;
	bh=Uc40RcKr4ovPkBu4wKk4ImFsVzhv0F45hRSgTjv5sUY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LqJypGb6IBjWGDI7XFw+pqTk0PcrRyECoMDWMqEFrk9n+hFYbfx9Nl5c/y8K9Ve/hFqHz4RvN6ufnlMOQrbi1Bz/Z/XIJCX4TFYkFrAmg+n+n/uM3SvJ6ujYR9lkCQaeZr5FAur01Km5oOIjO4+RsDal5q0PZ1J19fj7u6qTU+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhnEtErx; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhnEtErx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731015328; x=1762551328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uc40RcKr4ovPkBu4wKk4ImFsVzhv0F45hRSgTjv5sUY=;
  b=nhnEtErxukYAxtxmNvqjJCivIazyKnLk5SJ2bmDnCq4qZTZ8FfduiWYm
   5CO7Y2o1XLZlcmTNL2Up07q+g2bMrpTboeQdvkrwH12SzaVeEynFWspCx
   7sgFVVxRt4wHn31mNdUD5EGyrl0k9ekTb4OVyboV6b3qFM0dDgclpIXnz
   NAMV/3iTewz1mqdqY3G0iu0kY2whkHwA19Xee7GH/KETYfPdcvhwXre1c
   gMcKjrr1n8HPq9TOKImEccs65jt6nlvDCJ0KF+xGnynFAFpKpj4BkVMQr
   zvTkmd+jzG+n9kCydGVta41XYwbQBSzq9qWbT0MiQftPpKQ4eR2lXZPF0
   A==;
X-CSE-ConnectionGUID: k2ubAhNaQHGdDv/bS/sR3A==
X-CSE-MsgGUID: RzyGWF1vQoKnLrmwh5mobQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48343070"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48343070"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 13:35:20 -0800
X-CSE-ConnectionGUID: 72XvflOwTPaSr9PglobzeQ==
X-CSE-MsgGUID: zlucg9zJSJuvkFuGCBymeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85243218"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 13:35:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 13:35:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 13:35:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:35:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIHOPeWahCe/JBQekkOEYa8hlBhKC9ZFwHvhb8wtcn3e5yQkex7iPSai6mW1nKCm9azPYyIKHw4RrZAayYqTCr3C8IzX5MIZEXvda6hlblmgblFHSCs4SVWlrSY7dvrLTQ9PphrYiunwO/uy8hzVo5uhXYU/f806cvn+D7bcy0ds0EjPiGY60NZ1iVtPSYaNb5Nz5zmMoEnHHDyZ8KhXkc9IqbCpiPSk6Id7z6OjBy+CJgTzFtfGoJoFc7qqBixIx5+QUsM28Aikiv03ZRbQwAfV63AqQVIT7uWuBjKbtQTyW8S348SvimIEZp4CpWalkf69UUw193BSzK2Mm/snbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AwpT6qUw3rc2mCmz82EVj7NxfbMZUJL9gzRaUwkU6Q=;
 b=wJqhUzwy4y6mYav6fiXIzU68ozGdAVKGQExsJOL7MlDCMncvxyRwQ3wIAqU6Aux+B58GmAfV9Asd+W2i7C+PLwG5erHjBHSAG5PHjEuplYJ73yMUIU+UExnA8IYFAXsf8PA7xj2PlPVIr9DxPQ9cRZt85UWQQXCElCi0HWe6G5d+03euoNonfS66qQh07f3qqZ6DkGgMLmPXV5UbKwpR40sHTq+8/3aCAaZDdU1S9vNdVRiTnXxlGy8YpHhkpo9FDKvgQetzynYs8bAEYtzYpS0/EpuOvF5gtMEzI6B960t2TXz8/TXb7A6CuWs6DBNXf1/wSQeckTF+64yfBwCvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 21:35:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 21:35:15 +0000
Date: Thu, 7 Nov 2024 13:35:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, "Gregory
 Price" <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <672d329119d63_10bb7294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241104084110.583710-1-ying.huang@intel.com>
 <ZyrUFMutrN_uJvPe@aschofie-mobl2.lan>
 <878qtx6q0d.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zy0kt2i9C6eirhPN@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zy0kt2i9C6eirhPN@aschofie-mobl2.lan>
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8fd7fe-8b12-4147-9863-08dcff741188
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kzs4AZuRnxSrYm8GTTj9xuYw45iX2hMKBmsgwWe9ERl4qFIibprNSppZUqHi?=
 =?us-ascii?Q?TNP3kF/u4dzxReV+W2ysvfWQnl/7YkCmpB3SZHvxxFuI4qDwYI1yOefBCVjO?=
 =?us-ascii?Q?i3nzq+98jyix0z885T0RTctA7/LromvIciVifYqyLWfOB9IHhRLyOLSDHJaC?=
 =?us-ascii?Q?G/az0Q/9QgOtEXo9bWjZxC5VPXFCZtC1Dknw4SQWD8w3qQNPGrAculdaplrE?=
 =?us-ascii?Q?oh0WW6rHid0JZjYFwOae52S278Y0ZrQpK+rxEJLgvv9REnzmUHhsJS++K0/o?=
 =?us-ascii?Q?Hro+7eHfS+0Z5FBZdPKgbUhWiXon6IvPuBnwY8CrJXokBEQkun1YK1QS4Rzv?=
 =?us-ascii?Q?00eEkvmblvKagUt4wLCZ0AaQ1OZPsKabiF2pX8pSeBcXxT2Ss8JKzHk8p2KY?=
 =?us-ascii?Q?4dCPiWz4wkU+qFw2bHSkjrwvs4BFgED15WchqnPjQpnXZcYMRjgPK+ozNdRZ?=
 =?us-ascii?Q?4UoUkgfD4kIlqyXhBg333Z2cUJkvei0q8wbIK3xs3ndcmAHXHCJgVed110vL?=
 =?us-ascii?Q?S/U7vlU0GtvbBmyLhihoPeAgCE+GFRCIIszmPnlSLda1k8iDyS1YougEfwKs?=
 =?us-ascii?Q?ePybeMypBw7KqoAHDHBiTfITH6m5jVLXHkK60HgQDEaw97GqkTLKVRSvYyhb?=
 =?us-ascii?Q?gzPFo1/TbsSEI3I0bnPnmfZQLxbHfg3jWyHFrMr/0AGxg1Uw8w8L6ZNRANOX?=
 =?us-ascii?Q?QSZ7mvqOkvPmKdQUOkNXqKs5gtZODHpv9FVkV3/c9pLUf44b197Ib3OfA3/n?=
 =?us-ascii?Q?MS0rSFtWKCGoW02iM1hiTcmMNMdnYVX22XxtxEqZ3m6Cx9B7YDH8XlZU9nwB?=
 =?us-ascii?Q?IPcSwpCnQPeKXM2O65a0Oq7Eaqs2QtmJ54pIV/1Sm/Y4nA9W4+WdvX6D0w6p?=
 =?us-ascii?Q?9VlI5HKLy4GSS5quLZhuyPXdl/rA0tjxeUKJScH0VEUUHUD10DRsp6z/kMzG?=
 =?us-ascii?Q?f1do41UO0c7t/iK4EZSDJ+JQDhqNjCvjkQBZbI3WQ9itQcfNDzA8kgGSj3RB?=
 =?us-ascii?Q?Jf763wWwLZGV+t2raeOFUqgkuSmZqSwva4xcYRQZlpBIF+HPmCNAc9wPmbCW?=
 =?us-ascii?Q?qcLzlfKFDmMFBAvm2mDX2zlSGTPsvbFQwRvIYZKaMGk4cUpQIqL+3QmZsB+Q?=
 =?us-ascii?Q?Rl4QsayC+50yV+VX5oHICEIfOCg5AFO1Zfycgx2PO4m1BG5p8fgjhX2ONaaU?=
 =?us-ascii?Q?fUI4HI+vo7qJHpZu46TdTvw//xYPEElQdLom/UPPP0uzwPEoOFpjArU1V/v6?=
 =?us-ascii?Q?wnqwPbAbTTohvzz66g7k88fTOHrGdEoay6YXNM/HFQ/D54g7efui/1FkEWk8?=
 =?us-ascii?Q?x3bX/0pVBLzwGBHi3P3et4id?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8urjCfil7pPJDFOXa+SIlhye7SmBGLplOOKeLxG+3VPiFyLbebByAJN3aL0?=
 =?us-ascii?Q?/shI9bI6oUEwZPQzZ1UtNExS+IGVQUmALhIZfGttgE77rOMSjrZWDM3szOHS?=
 =?us-ascii?Q?jtM/JrtKB8KbYFHwP8huW6R+ZbKXNNqA7Xz8OTpt6ym/BHFykR17aHj26nXk?=
 =?us-ascii?Q?ZFpR8mbSQnixqkQgHTvrimeSNmLFISVxA++3wu6LgiJFwLZqxNc1DJl+2XPy?=
 =?us-ascii?Q?qjqb85Q0i09akSsk2EFOpQeV1Zapa9hWALQb6H/JGGi6+vfs+jlPfHnGDgdC?=
 =?us-ascii?Q?BMnjZYAO9PnPyGohukhFp7vNvP8W9ctSdIyJscOML82jtyxPVBRy/o08jRC6?=
 =?us-ascii?Q?/EQfiB7rC2iWRCSk63+pXjxt5Ap6c/GfdHS31WTAs1vrZZE3eonGmAvM/Sw+?=
 =?us-ascii?Q?plipJXUwpZMLCh1y6QVG85Le/topHfww8rnQlfxU2W7iUZktLIGs4OWV64io?=
 =?us-ascii?Q?xPud6iHTGI6B2l9uLoWCNK6Kfog/54IwDUS8lb5tLzwjmY3CRy9JJTq6yjCK?=
 =?us-ascii?Q?y7kkt2ADQVPBu+FDvXvrsQjwNGPQ2qCJlh+RXIlYMVsQ8mBCfoU8daIrhghw?=
 =?us-ascii?Q?zE3vA8SdDAjEVlBIoGAUflDIRDaGnYS0iys9MizAP+9NoYLGKgRQeZFAkupE?=
 =?us-ascii?Q?FcmJwzuAlkAL3gr2pJK9bkhGuClScQEYOgF4K9wFu9cFILiZQq3RlT+ycCP5?=
 =?us-ascii?Q?DbFnuy5j5OE9BzbDS2r+iaOEQII0s0p8d7YTd2HBave5xR2a3zYEcPAfrtJN?=
 =?us-ascii?Q?bDjeYME96auq0UrTV6qEAdtnAyIawCimjgVaDdA7sGrQ2w/8pclZzOTf9quN?=
 =?us-ascii?Q?WCHuTn5BaQl+TjtqJvE95oS8qQxB7G7/poteMAPTuKCRz/r6emXPML03SkXU?=
 =?us-ascii?Q?1mODxem7tziK4RFsAid4vl5E+THHTbmgKAh8COBwBvCazgscX6j7TlgUDxJD?=
 =?us-ascii?Q?M+ftZPoAnXpXNcS1IOw01tuiST5lseEgWEohZ2AKhdSHmlosWC85HdnjArtM?=
 =?us-ascii?Q?vEOYA+fp50UZ4xsPWFaKUWnY0vLz9cIXmkJCIfgC58PYdr4xRvqNl3RwGCrO?=
 =?us-ascii?Q?OBiIAEdiEzrR7EhdYZNWtY3FIjK/bCez3JMQUG7D6TeLlQe8xpFHoGJIK8er?=
 =?us-ascii?Q?Ek9kshFLt7+ZejduLoNOJMOq+/Z9ZxV/2TNhESoiQVDXeXWlvANRYqgKmd5C?=
 =?us-ascii?Q?SFu6GEJzEa4nwkgViRmQP+HgQFoWaEAtLWkkfUpp0CXvvM7S9xI89HdHqfts?=
 =?us-ascii?Q?ouPmhhioiM2ov80m2IQXpyfEY89AYOnGHFWxfd5FZ8yvK1PSkEcH8VH/4WzP?=
 =?us-ascii?Q?pawnJmhBut9NqYGhpTcw2k9MRq+LGNfC1pDZCa9z/5I1ZFie6edrqM2GAvnT?=
 =?us-ascii?Q?//OypdK6YmYc7VJS9o1iw0RhFauHB/4IRJBTBXC0TJVXVkKNVPezyWJL/G3g?=
 =?us-ascii?Q?CYUOQ6DLFoKR6eGdYejDpfmICqWTDnliwOow5zxsjd9le7NxL0OM4tCYShKx?=
 =?us-ascii?Q?yFKPQa+CHIZqL9v3iS4/f1maWpntB7oBLpai71iqo+Ahd7d6biKdTAUh4mVj?=
 =?us-ascii?Q?sE5232+bgBoRXP7kv72aqKj1ANj1x911CdBiZBJIgw5ExvVmw/hTgdnKf6bV?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8fd7fe-8b12-4147-9863-08dcff741188
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:35:15.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7PqvCWLux17yLhITxOwIPXHaLKvpYDVky31KjE/jSWznCLbhYbtICVP+kxyNYPlcyOPFv6xxKOabMQkaJjWZr3Iu/xh6kw4fN4N9RamE3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> > I think so too.  However, I prefer to keep this patch just mechanic
> > renaming and do these changes in another patch.  Do you agree?
> > 
> 
> I don't know. I was just questioning where and how far the naming scheme
> needs to change.
> 
> Maybe Jonathan, as the Suggested-by, can chime in and move this ahead.

I feel like we are going to be living with the ghosts of the original
"Type2 / Type3" naming problem for the rest of the subsystem's lifespan
especially since they were encoded in the ABI and ABI is forever.

I am not opposed to this localized rename in drivers/cxl/acpi.c on
principal, but in terms of incremental value relative to the thrash, it's
questionable.

For example changes to include/acpi/actbl1.h need to be chased through
ACPICA, at which point is this rename really worth it?
