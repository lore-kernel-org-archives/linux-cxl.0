Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CA1DD885
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957653; cv=fail; b=DUwGHFGulGQV749cCzlGsA2SUP9UCrTTlMamMx8kexWzpRqZPN8T0mSzAyA/6VxZy+nGB6SJ9EUr5CMcgRJZdEfD/JlS4jyMAx3F1DXj6NQxI6F4QMtOyb/m7jPvtHjTB5YQhgorhsgkxAvk22njrbR5XNH8/8mpv2oDt3bcoqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957653; c=relaxed/simple;
	bh=2XZ2BLLtjrElgb/3SNN1BkcPGkEYVxJBOwOfzwepERg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=InuoC5XYK7FxRezF73u3nTWyR7i8YPy/nITmb9rfYqJeNo/tCLKW33KzTBsmanIeqP2AVZY+l99Yp/NBXWAft6IZstcqtBi4uc/p36soLmiyHDyNKERvCRRDdHGcDXWmIYWcX03utM4M96C4KPf4BZhY0pfN9302+Hpa+ZMBAv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZp320+t; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZp320+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733957651; x=1765493651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2XZ2BLLtjrElgb/3SNN1BkcPGkEYVxJBOwOfzwepERg=;
  b=gZp320+tmwB3AMtYJ8GeJFnQE+G7qZj2Isna9Su0MhFDDjHDvEmbC+rr
   xaKAtMe3i9I6Z3cW9CNmxGkwQDvCWtDGltPEumLrQDBD1ULq/CNZs11Lq
   N6Rxq5pVob5akho3BivF8xOk98C+lYeSZJsE02xD3SNtjw+sva6z3fdwX
   ycw7y8KA7bm/2/KHCtnz/VRRu3hkFIwREjKg8USWsNv5LznympUIwq3Pz
   wL24vNqECaYXdCfY2xexg7oAAqwZI2frwMuSerhP6UVmpx3xEamVON+wD
   LgIpm2B3znSeNevkZ1ZtQTjg0pTavAYN0iH6ZMJjSMUgT44+f8FshnNsG
   Q==;
X-CSE-ConnectionGUID: qwdQBpmOQKGdkOFgh19JmA==
X-CSE-MsgGUID: rIcp5mZ4S22+DzCYENai3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51773117"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51773117"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:54:10 -0800
X-CSE-ConnectionGUID: +sGIjLjYQz2Esjp88EW3jQ==
X-CSE-MsgGUID: cTKRVqAUTzyPUsZDh8Yh3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100099303"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 14:54:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 14:54:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 14:54:09 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 14:54:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB67mnSMz2OH87lGA7cKuKAWfYpJKN+UXI0UvqiXsjL+zH10lUdEmZ0cqPh3WMW+QUU4HmvS/+pWUzwnjsDUbzC3yLruBBujPCahWKoDjtKUWP/+KiwNsQCxbAkznqSsSjnyA0oGN06GtwDav1eSUY6LAKOiBJCTsP9kUF7UBFgM4v0HHFmBsWvPChiSymh9WCmVXfVZI8HNOe1vTdE/s+98YUk1xL9XVD6PIZPofKmX3+TbA8OKfILIWZyGDU5YCG8d6qrLi+mg2jPXwUxAgXGz4FbXHN3BJK3HwMrKyFvaHXBP3+JhGcAMKNVkd6+GQ0+FcNzmZ5xbK0KrH07hBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWwWI1vraz4bLiM0Y+eYHsT69vyC4E/wwm7UjAaib5I=;
 b=Jhp1r1P9tB/UysNJTrHx17oCeNqqJYrShYNahBMlKBeIDansqawQA+FIena8J9BptTwIUADxIC2g45EpeihUzY4VzXFc3jCLqp3JhE8ZTuHEFnl6M/IKVcY1JWT/gfBCe5PRvGe9iiMv4OOT1o7GkLqiiPk4Ff8X4UNwwZxmmzOeq+q5eQpPrfDb2bmiGUvJ/jHzbF8NRcBATsAbWaGcyQep96bxSoo2/AMOY/98tVNEbW++EKBcTN1AfyKvNzKQudGEIreSMP/r7JgK9c0ag5O5nKOXuhE5XhJ5R+ymeR+0VnUHLhnEXhAjgXy9+E1SpFhtmRjJio+cmUroLs+I0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 22:53:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 22:53:53 +0000
Date: Wed, 11 Dec 2024 14:53:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Nathan Fontenot
	<nathan.fontenot@amd.com>, <alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <675a17fe8aebf_3e0f629483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: f21ec7fe-27c8-4a46-9680-08dd1a36af5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jpe+zMoE1ZHLJ+N+HJ7sMZpZX/qeJ76b9xVil+qKYX3nFH5uhBFSViR/QDrS?=
 =?us-ascii?Q?DFYjkH8F0ypjGlTGSErQFt5rLETnE8woKLWVbNBwGSpPs2t9FFys4ba3Ms5h?=
 =?us-ascii?Q?ycsj0NWWdWhNESzZPQgld7rKOyUGroTUaZO5VAC5kScVEhv1ZO6vd/klwsjK?=
 =?us-ascii?Q?XwewVP/ww8nl2vtUgUeYrwc7IZIoRw9dTFkKQcTp4rRVpsg6bF6zfuA0T3HC?=
 =?us-ascii?Q?zDooqChhWtK5o6P8TPHevNsw9blawtyuW0FcfDJaP2AjqLPTN7e5DV99Qsve?=
 =?us-ascii?Q?ytZ71RK1LgfroKZvzuq2iPwZZZEcFutq4F5OvUg9zVAlWHl/2BYFKZ3eiyvH?=
 =?us-ascii?Q?BvrnBrojKXyeQ6UVJusRQiK0f517YhgQReP4UZkHDKVOW2CoE+23KWuqlHvq?=
 =?us-ascii?Q?Y+FTnjIhptFPrX5eOXfJZEc7in+Aqpv8PxzBeo1hk9pXW3JG9Vb0qG/yJCVR?=
 =?us-ascii?Q?N+d0zUO/yYpMGCEX8cPK+Pq1eoYmWTE7JhAxP1eXuLu+BpYsWm76/9F+Kn8G?=
 =?us-ascii?Q?bWoVKML4BvQQ06dOAQM6aOFjaxq1sz9vn0ulHAGSaZUQvkOKRkTTnVpn0+TR?=
 =?us-ascii?Q?68mP09aIY23XxipOybxJIxdWc1clLMqO0CfV2ktYap7IOSO/pduQHlFOxySD?=
 =?us-ascii?Q?G1z1YcS5s74JwnE0QqhF6fAWuw5EFfChmVQhVfi3ivByuctHeBZ1UCnm+DEG?=
 =?us-ascii?Q?5c9BlebSEmJdmY0aQqoO8Pdg/hxZdlQYgIpgEaGg3ee+5+N5c9h7dsJSdwQl?=
 =?us-ascii?Q?2qYBWSMzEc0iEwddCTGQAhn5Zfs0pOQ4jyftLMSy8AcGPA8v3WSC0FnkqfhB?=
 =?us-ascii?Q?As8APx2Ra6DqWaXHfPxzN2EKBpCd+WROJfY/vtyNLrb97yJPIruyH/zy3mgJ?=
 =?us-ascii?Q?z6fwRY9sn7yWks+4z9fo4Qy8TW+FkO9zxt9YrrtnuBOqeKhBbOQ+YaxOyNWk?=
 =?us-ascii?Q?WvudUhyK3rlhKu0Bj3/hEQrWORTn27GEktwYcQgnx+v66bL34uRs+giy5ZLL?=
 =?us-ascii?Q?Aps9I7DzG/f2LxERCc6qq/hIseG+JVpZ/Zy8HV2yiVbYETtPfS76jlG3Tu96?=
 =?us-ascii?Q?FtaBDPMKDL7jobRZ6FZgxNY9Hcl8pVTFdzjhj8FwOt0vfKQlmd2q6TagCBkK?=
 =?us-ascii?Q?E39FzVsDpodNo0zDmB6OwiB6r483c5dGWjYYo09ZQPiocIwfb3gwrzq7t6LZ?=
 =?us-ascii?Q?mGGbjAIpUukolfiNGH9r1MkTzZQuToYdEmL4wTNyWTm4oiyA08A9UgrGqiXV?=
 =?us-ascii?Q?x22Ujpn2o9Cg98JzW3MXQYY5W/gyhQ+dExRxcESgBLYpsCSFxKI/gfcLg44a?=
 =?us-ascii?Q?Swo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sDTLqoGV15f6VTmZngmFgR1dfGxxp/9Nt5TF+GszvnQaeYVejWBOPx0tTmf?=
 =?us-ascii?Q?v8z2tIVpqlkpTETw4EoNpnbZJ56HWURbgUWxqkAkw0FGucnLDgPb9JuB0ww8?=
 =?us-ascii?Q?X/fWPC+hwqStgD1GLWulpz15y76ezsRv/w8+6p+o3szRKKwY8kTiHqaLRLOT?=
 =?us-ascii?Q?dp9D+YEBY5lF121gxE4uUo4U2uolwE976B+TYlrXv47JexlfV5yTt+Ct+wj1?=
 =?us-ascii?Q?U8XaO18qwgmz7EyI8x40ePwpVqch2MEhjOOl3ZpaRyfKI534axwLa+f0TZAB?=
 =?us-ascii?Q?vziU9ZU81Z3X4bewoYX0H0OZvs0a5JojhtcVfBrGumUtl1i4YRNctz4EzDTd?=
 =?us-ascii?Q?nMtpuL5H8SlJqJyaRF2eCWrxhna9WtnFtMTwyxQ14SWWk5AQGNr/caLWKcMY?=
 =?us-ascii?Q?S7CBXeD3gxw8FQtpyeLsGgqnKKPqaKtmlv3THLTHpfKcoaeN0dJi39bq6jLv?=
 =?us-ascii?Q?CNQhAwE3FL9itmF4ppeX/nkGAhNr3xDvBcGUTOFIc7TGi2YB0t3a6ddtdg2a?=
 =?us-ascii?Q?8jmr2UCYibhR5NLGUmSxD2AGwtZ19wRMncghLkKqPzAigiVlHxCLZFvwMj0V?=
 =?us-ascii?Q?YCgrDx03XVcd8Gc4g9rylK8sj7yhYus6QN+eNxV8a/Hf0WOpWi0rIUA3GI/+?=
 =?us-ascii?Q?YrT2hdBigbUqJkM1VJgJ7RlA6lVTLSzt1OdWPP9oFcW5f715yZPS+iEAMcGH?=
 =?us-ascii?Q?AiyRLOnBJad7av0JDITyTUQTioXpPJ/jyCVT8qSc8jRxITvdlnGWHlF8q/4a?=
 =?us-ascii?Q?sebywWUVHO9BlaQU4qY0faozRMWUQyo9AsfS2JrB9mWtG+PBJOHfY85jwzQK?=
 =?us-ascii?Q?b4jSSWzznPifDNY9P3UcLocfL9ZR5fgVzDu9qaoPokwA/w/1n/gaFZyreUfF?=
 =?us-ascii?Q?x2FCH4YVKWJJllDe1CWAfOKEA6Bwqkk7w8+p2xZSI7Yaev1Y+QwiolOGMnex?=
 =?us-ascii?Q?oik9k4VZcFobVe355RjEmaGgT2ilWiwlBMthT7Qa2K9X/ueAqiIAQ5AYyGCM?=
 =?us-ascii?Q?omC6w7aPwB+GVs6oOAwYZ42YjsiHtMQArztkxBE/5pUIYjR4MwV6WWmhA3NG?=
 =?us-ascii?Q?ejgv2CvmQnRsT4hGNA6xldVQh40rgPO1CrgYKPu9+sOjO8VrIXi7ZT5TVTBd?=
 =?us-ascii?Q?83NrZxZ2RI+lwju8V0YrZt5fsCIHxXGMccI1Pl2WXyDu8XhA3tJGbHCiINti?=
 =?us-ascii?Q?bjl4HN7FsxUAHmSwzm0/mzlIw7dmPIKpc0Hl8+Ayxk/woBR2mLAta4XKbjCA?=
 =?us-ascii?Q?8Xqd9+ItYUj6baqWIVC+Ex44Tu0j6Mx/ofxAcwPgjQlbl9J+ijhIn5AsZjfY?=
 =?us-ascii?Q?XICsCUSHRAIiENqmXgZ7i9hE627vsGfMDzpe8kkd3y+a8fjt4yWQC1IzHEB1?=
 =?us-ascii?Q?yx7Qf7ZYLLzsml7Y530mAmi+feRiHiBqXkKdboZ8n/ybI0qE2BrCJMV4FKny?=
 =?us-ascii?Q?n2KFIsgfwc+J/Xs+N5BiDRPW2p3mblp6jTeYkx8aAbnFjFyrz8ZsVKvcrXyF?=
 =?us-ascii?Q?f3fDe4n+d0CZ80yBXT5qoOG+p4swdCBuT/s4HHKjknoHM5pQ57jqdloTTii9?=
 =?us-ascii?Q?wpRaIipgyeeWQwonHzSsM8laX/rMced75Mp+wz6yP2Fhw2cthfZJjD3JIP0I?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ec7fe-27c8-4a46-9680-08dd1a36af5d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 22:53:53.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QgcxcL/NmYJHavG7O7lM8JRGK6D0yE4XQhr5WY2g6edEv/4r8e9Rf+xtE1D0EKWlgUnoW6+ztFOgv4/k0jBwzHx0+W/G59PkxzvNE456GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Nathan Fontenot wrote:
> > Update handling of SOFT RESERVE iomem resources that intersect with
> > CXL region resources to remove the intersections from the SOFT RESERVE
> > resources. The current approach of leaving the SOFT RESERVE
> > resource as is can cause failures during hotplug replace of CXL
> > devices because the resource is not available for reuse after
> > teardown of the CXL device.
> > 
> > The approach is to trim out any pieces of SOFT RESERVE resources
> > that intersect CXL regions. To do this, first set aside any SOFT RESERVE
> > resources that intersect with a CFMWS into a separate resource tree
> > during e820__reserve_resources_late() that would have been otherwise
> > added to the iomem resource tree.
> > 
> > As CXL regions are created the cxl resource created for the new
> > region is used to trim intersections from the SOFT RESERVE
> > resources that were previously set aside.
> > 
> > Once CXL device probe has completed ant remaining SOFT RESERVE resources
> > remaining are added to the iomem resource tree. As each resource
> > is added to the oiomem resource tree a new notifier chain is invoked
> > to notify the dax driver of newly added SOFT RESERVE resources so that
> > the dax driver can consume them.
> 
> Hi Nathan, this patch hit on all the mechanisms I would expect, but upon
> reading it there is an opportunity to zoom out and do something blunter
> than the surgical precision of this current proposal.

Note that the reason I have new / enhanced focus on simplicity is that
this mechanism is probably our only way to resolve regressions like
this:

http://lore.kernel.org/d8d2c310-2021-431f-adbe-71ad0a17896a@amd.com

In other words, mainline is now failing to enumerate memory in more
scenarios than it was previously. I do not want to be forcing Linus and
the -stable team to to review wider changes to kernel/resource.c than is
necessary. I.e. there is a chance this proposal needs to be seek a
v6.13-rc consideration.
