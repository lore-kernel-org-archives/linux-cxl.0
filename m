Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B760B96;
	Fri, 16 Aug 2024 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784476; cv=fail; b=bR5v3uv7X6y4m6Vz0b3enCcV6rwkJk0nNtw3ruHqtbuWlfQFRazyUKz7sZVKmd+12HUZOD5Gh5we2rcBCpV2uUUcfeJ+Ny9Ms9KAkbsjB22INhukpAGqRA4u8o1woGYNOONz+ZwBAiCh6E4OkJe8ipzFQ1VEbo4mdIxG9jV2+lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784476; c=relaxed/simple;
	bh=0j3wMV9YiAA7LLiBls0Dv4GCmxUmRHoS2FP7j5jmARQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZruqJ1tB8tm+cdV5UbRv3gtiOVBaHbOWFEzmvr3eYbXSCOo4n+pg3zmxel1Q2qIZ/ZoLCDY1Vp2t0SdaZZCHGDoBrk7GGS5IYXJO5HgyDnD5IMLL1T6KIW1q3aR0KwqEPPonOA8Kr5k7iP5xU0EDznDSRQ4HRLvWtIFJZa8pUt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvaFkN64; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvaFkN64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723784473; x=1755320473;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0j3wMV9YiAA7LLiBls0Dv4GCmxUmRHoS2FP7j5jmARQ=;
  b=ZvaFkN648OCtCXtQRJj5dBCRdcocki3F0dUiBlF/qJPdwW25iat7pjOd
   GsE3tDokU2KkPI4eRAIP0oM4iPGoE7vg+Kdd7YLIAF2d7dEWILG+kFjwh
   X7Mnduvm7wq8PagzrGNhxsB2AqxHQT3rtz9ucmAYaHDU4MQGrUGZFkEOI
   yNP7xG818A7B1otKq9pSZCAMobQ7UKpgoYMvWxrz8jFPAFXo15EeiVARR
   BRHA6tOTAXwOhnYKm9RpL0GYaCEvj26AJAWF/O1MJ0pY4urHPg/grj0GX
   If1aae27pQ99aeGi+BMQt6PEcZ4LC2toYGVf4NHxQZCvAafkkPmWg2HfQ
   A==;
X-CSE-ConnectionGUID: ZdrqX05kS+Oi8s3l9+AWGA==
X-CSE-MsgGUID: RYajeg5xT9arVmOMCeyu2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33483266"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="33483266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:01:12 -0700
X-CSE-ConnectionGUID: erDSir0cTsK2yTjrpRF1yQ==
X-CSE-MsgGUID: qa1kK/M0QtqUcWrH0mbZyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63976065"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 22:01:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 22:01:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 22:01:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 22:01:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 22:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpMyaqZV+y/jYA4f0OIAAsEjJWdPLp654nFCaEEgHbiXySEou4Y6ULFgqtgLS4dEhxMOC6KO9ZuXOZcKqS71G36gsaJoYtZ+NJSEtbjrXLc0sfKub/KMFp2ChG5O4MMvv04h0rvm75bFCKHdbBClK6JCgxpP0XOOEMHe/JejB3isOgqTpHTUP1xYH767BFxVftEv9zxwpZVpUvnpbQQaPRw+fuVWWVZgX+Q2gMRP/J2QESGyg74XIcKfpjtOU+sjZj+2yYAa8nmL1ZG+ojh3/zqat6RmR4HufMGQAoNyDnA2pVfzIh2ozKGmW4hLCzKNq76/h72O2g+fCEMOVFR4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9DjrwtEn/r84lnrGlJOwmyQMmLCxRFrg2FlgpWL4lQ=;
 b=oXYQ/as06W61Rz0qkTS5aCkwQEEVE8K3VKWv54u2FuA0nn52+usPd1kWtbkq/j/bo/IBmIbqeG1yCN9tkte/O1MOOpSa5KqSjUSCSbjCeH4QLrHgln+E8O4BvX8lrhzbfBNFyGkC7spXEpvHaGzFlKK+WhO9/OyzKzOlsib1zjNsL+975jn3BaKAeVOowZA7yghEmrDsRMcWh38Tr1yj7/SeDbS40Xr25K3DhzHfGJyEfJ3KFS7x5BWIAqONQb2E5Jx/ypGIoHhs3p83ogWlzgVIvfoVy6S46w1glThEl0Ik9KdQ8rbRvHUnnSGDTLRptDR9uVASUvttBiqEHTihLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 05:01:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 05:01:06 +0000
Date: Thu, 15 Aug 2024 22:01:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair Popple
	<apopple@nvidia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
Message-ID: <66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240816020723.771196-1-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816020723.771196-1-ying.huang@intel.com>
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d934e8-aa92-4081-9d43-08dcbdb06fa9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8646btPI3WJ9H+qa75iSMsiNI1O2zBB+8yo1RT94W8qMxh8xMfnotHob7YbN?=
 =?us-ascii?Q?R/L7igrO0Dfr5s04bWCn8RR8tbfABjejZTqjtYDnaqH0Xl0TFGpNWAi9eaYu?=
 =?us-ascii?Q?/rFifMYERLIoP7z5PzEH9U5Im8z2On7vGrwoH80B/ijV42oHU5/Ol0/3qy/6?=
 =?us-ascii?Q?uYk5qhrFM8KmZQ8QoQ2pW7xtBXXYZxmI63mlKlOqd8muPjejxSak2vP6jboB?=
 =?us-ascii?Q?bqfobZX7uoIJtGJxaBvNm+5bwxKeAlnWBNQpnGjL6ZkmZB0LYA0fO3tc1Y3W?=
 =?us-ascii?Q?KMpEpe6AGCfwJZxBwzmV296CG9Svf/Dwsfkkxt9vdF+ftSL7oFsZMMV363ff?=
 =?us-ascii?Q?smKYD9rCKA+LUJkcb6zMbxVVdFzlf8QXxaXLA3nK4mo5fR6fEi6kLyU6ArBf?=
 =?us-ascii?Q?PWUTmvXet5klHQ+DDTjsZOrMfJvgrY19IU4kLu8F3i7qwlyH/8HJq6P5g/ju?=
 =?us-ascii?Q?32D5A69A1DsvKHnU7JrcT9nwHQoNbfuyjiF0NRKaW3VAHrAu9swOfYfWO2RQ?=
 =?us-ascii?Q?4pM5JB5DE/O/QMxjylyThhnqMw2YTAD6hdjMFKBJzUFHXnJGm5YNvlquqTV0?=
 =?us-ascii?Q?o0ZtJWCWKY5lN1L2zX2Wo3Cgj3dx0n/gz+Yk/UXpWoBDILNGs6JgyqzKGnbC?=
 =?us-ascii?Q?zRi6t2bT5cvZgHW/9DRuEYPiibcpGdXdugRQbRGBALe+3ApRSvHNcBCn2891?=
 =?us-ascii?Q?cWLrQDnPb3CMVnwmCrUZEdrPZZTBy9TBAcRlTUixATTjsTnqyP0InIXW6oeN?=
 =?us-ascii?Q?1N6p7Q83LCUgyh9AtAzlxtlVrINCUbc6DrFKyWSPjQ6Te5I7wwgEoTCvct2p?=
 =?us-ascii?Q?UbjljVsIvUjST8Nchfj6jA/DU7OXmvCjQ2e02WBkKgj5Z6UZ87oAJ13TWVEk?=
 =?us-ascii?Q?ge8hvV0bqOvaT5bBWIgbI9UjTM7j4c9D6FcBq/QqvNRQQwJtzWGIlkGRaJRl?=
 =?us-ascii?Q?zEeuCm0drXOIq39FHuLDVeedPf4Nuj3pcpJqI7AGFk9tTcC3/5zScU+p7Zs4?=
 =?us-ascii?Q?0Wj7wyrKw/YONgQoUwfdtwBJpfektZ4QYdUhSqm3p0PDeeQJEaJzMhfv0taa?=
 =?us-ascii?Q?pudHpHzC2hv+VVH5n56a2AnKcPM/79Uvvz322ixZFMuiRobJ9iPTNUoFJagq?=
 =?us-ascii?Q?vTKIKGI3jNvbRJZ8WhmXJ4jg88APYQTHHJ2pAdPjBpz2egVfLmkGOmw40RYb?=
 =?us-ascii?Q?JuCkX+UQp+V4KUauiYcx3wOb8I3ipipz0Jhx8tZIK/eW9PqlmoK6ic/UVcPb?=
 =?us-ascii?Q?5nfadlmr84ZKqLSq4IVsKTGJ+l21SXB1rpTa157nuA0/r6MWmPPiF/OSdSyy?=
 =?us-ascii?Q?AoBJcCG56aAANpwF4c8MbAbFN22j54wv9Zy7ycVapgxafg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L/Al9HcAdA45+CoaPj8JsImTa1vj8pv6kAaCKs7z4HibtM3UQ0GZa2odGrpa?=
 =?us-ascii?Q?AIefnQTgWJOENhO3bcN4pcZTUlQcCjkd4KO5MF4zIgWtheEM1NljlouVyXrs?=
 =?us-ascii?Q?DtFlxvx5vma5frD2MDx9IgWN0CzbT1nqNshliz3R3QJES5ubzYbtJcQkL8pN?=
 =?us-ascii?Q?7bVwVB6T+14m4SYIAX5EN1eBDydnE+w2Cq7Uw2+cjNpHrSGRDirBByjrb9vk?=
 =?us-ascii?Q?yERUu+iO549PItRQeQlL/EOExYS3OOebB0ru1BxL6l4m8Oe4RQxympviKrvT?=
 =?us-ascii?Q?+Vhkap4xwJP/I16ymvbgPuD/T7aBGqXulyeGaD+eFnsHOBOiQlJUZcNUJlGk?=
 =?us-ascii?Q?ovsLQkGhSO5/klhxG+iite2UWqBg935X3hF/dHsAwGriI1kOgIvaHV5kRfLQ?=
 =?us-ascii?Q?LDyrkqjvIK4u09Dzuh+gEJ4fCUjtGt5uzBr+AfzcBrDSt0HBP6ccm8xdmSy5?=
 =?us-ascii?Q?A88zQ37OoXwX8IwM7NfNLxdDgN6vQh5W2OsYz2rO23NR6NHHEb5FiDi7ZlnS?=
 =?us-ascii?Q?6d7ZcxD2Mn8s02WsGhec9bgqwbKYjLNLyNTrPA/Bz3mGRf+J+niwsDhvJ02e?=
 =?us-ascii?Q?gTJLZUpfLt9GGMT3+mOdvIpmiiXs/tMZIuN+Z4d+EXeqaSJb9CJVOZSJpW3k?=
 =?us-ascii?Q?DAd+wTnnkZ9YAbwr/U6G/mxvSvz4VKfRs/syYFfqz1p0S4aNva+cd8hu7YIO?=
 =?us-ascii?Q?mJwr0b2mCLmjmaghwhCSj2RV7NDoA+tDTyr+aXSTueVKyiyU4i2najafW84Z?=
 =?us-ascii?Q?7Z1h7QXL1P4eXWpigYnd4njUDPQdbJ90t+niYNK70zVMYkSdxaYWizOMpfOv?=
 =?us-ascii?Q?bsCmVGh1JF4hIDzl3Z+8QX3yc1QPkuniyp1Lp7guvNGgZuaMcg09CIm5HSHL?=
 =?us-ascii?Q?EmhqHTClwbXjCgJIX2ckvda0mBhPUTgDPqW9I82Ks+ZzMBY3f+ddZcuAuSqh?=
 =?us-ascii?Q?Snz69A0XlFErvsJP/RgcYUG7pnTBd7rDGnaRVacdGjCwqIHmFsahuwxcO84l?=
 =?us-ascii?Q?mlV+kgpGF3l2yQrk/hFUBndGGQ5tgVfZLBugGWyMrTQlsVLDdGf7iB3nOoNV?=
 =?us-ascii?Q?EiBblhYIh2pYDM4RFKi1H1TdAMvRZuCjrYZ0lEvL1ZcVfHRbL1D158lBBF4Q?=
 =?us-ascii?Q?aNWCbMC8XVH7lnhf48jkjQ6rzw/uipGZrsYvxJlbH9j/O5Xy52OSZ1R8wKEE?=
 =?us-ascii?Q?16nWh6GhHHXB85/W1/WQYM0cgIjUfky4whCUWC4DTCvm0bxaOYv4uOqYlWum?=
 =?us-ascii?Q?pO0twCCmXCnwdUB0h9uSjbY9HPKV6OdyGsxYI8kC78MXI4d507C8TP7Y0bK/?=
 =?us-ascii?Q?wCjFcAV3rXEa0AYe/Y1AAU1PO5HarfD6KlGcPok1ZUOyxOgnh+dzS2ngf/DU?=
 =?us-ascii?Q?Nv38sj0KIhfbvm755bXyt3LbeEEY0RC0BCGLqimIaMvc7xrSGpjxyIN13Fro?=
 =?us-ascii?Q?umSp4V48An9oyXzn5GIi5y6AR0BEwpm2+h0p+URS9RJ+g9P31o6aTnHOJdp7?=
 =?us-ascii?Q?8JxRtv4+DRyblE/f74rFEbY1wf3eDqJCrBJRmDSfgHuiJfacoKhP9pcDihgo?=
 =?us-ascii?Q?Nfb5/vH72ypz+0qyji1t2Vb8FxOgi6yaEWEs0R0O7hVKZQ0vaJHvqJj/z+9K?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d934e8-aa92-4081-9d43-08dcbdb06fa9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 05:01:06.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HzAjKDuFkZkCSA095uqQY0yGbHVph+17OSex08hvQ0tX6vcp23hsR1h5d9ueNSzMPc66fpyw8/rBWAoRgoRTVXfsnNhR/6g307OeOacnDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com

Huang Ying wrote:
> On a system with CXL memory installed, the resource tree (/proc/iomem)
> related to CXL memory looks like something as follows.
> 
> 490000000-50fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)
> 
> When the following command line is run to try writing some memory in
> CXL memory range,
> 
>  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>  dd: error writing '/dev/mem': Bad address
>  1+0 records in
>  0+0 records out
>  0 bytes copied, 0.0283507 s, 0.0 kB/s
> 
> the command fails as expected.  However, the error code is wrong.  It
> should be "Operation not permitted" instead of "Bad address".  And,
> the following warning is reported in kernel log.
> 
>  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
>  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
>  Modules linked in: cxl_pmem libnvdimm cbc encrypted_keys cxl_pmu
>  CPU: 2 UID: 0 PID: 416 Comm: dd Not tainted 6.11.0-rc3-kvm #40
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:__ioremap_caller.constprop.0+0x131/0x35d
>  Code: 2d 80 3d 24 6a a1 02 00 75 c1 48 8d 54 24 70 48 8d b4 24 90 00 00 00 48 c7 c7 40 3a 05 8a c6 05 07 6a a1 02 01 e8 a3 a0 01 00 <0f> 0b eb 9d 48 8b 84 24 90 00 00 00 48 8d 4c 24 60 89 ea 48 bf 00
>  RSP: 0018:ffff888105387bf0 EFLAGS: 00010282
>  RAX: 0000000000000000 RBX: 0000000490000fff RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffed1020a70f73
>  RBP: 0000000000000000 R08: ffffed100d9fce92 R09: 0000000000000001
>  R10: ffffffff892348e7 R11: ffffed100d9fce91 R12: 0000000490000000
>  R13: 0000000000000001 R14: 0000000000000001 R15: ffff888105387ca0
>  FS:  00007f86c438c740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055ba75b1b818 CR3: 0000000005231000 CR4: 0000000000350eb0
>  Call Trace:
>   <TASK>
>   ? __warn+0xd7/0x1b8
>   ? __ioremap_caller.constprop.0+0x131/0x35d
>   ? report_bug+0x136/0x19e
>   ? __ioremap_caller.constprop.0+0x131/0x35d
>   ? handle_bug+0x3c/0x64
>   ? exc_invalid_op+0x13/0x38
>   ? asm_exc_invalid_op+0x16/0x20
>   ? irq_work_claim+0x16/0x38
>   ? __ioremap_caller.constprop.0+0x131/0x35d
>   ? tracer_hardirqs_off+0x18/0x16d
>   ? kmem_cache_debug_flags+0x16/0x23
>   ? memremap+0xcb/0x184
>   ? iounmap+0xfe/0xfe
>   ? lock_sync+0xc7/0xc7
>   ? lock_sync+0xc7/0xc7
>   ? rcu_is_watching+0x1c/0x38
>   ? do_raw_read_unlock+0x37/0x42
>   ? _raw_read_unlock+0x1f/0x2f
>   memremap+0xcb/0x184
>   ? pfn_valid+0x159/0x159
>   ? resource_is_exclusive+0xba/0xc5
>   xlate_dev_mem_ptr+0x25/0x2f
>   write_mem+0x94/0xfb
>   vfs_write+0x128/0x26d
>   ? kernel_write+0x89/0x89
>   ? rcu_is_watching+0x1c/0x38
>   ? __might_fault+0x72/0xba
>   ? __might_fault+0x72/0xba
>   ? rcu_is_watching+0x1c/0x38
>   ? lock_release+0xba/0x13e
>   ? files_lookup_fd_raw+0x40/0x4b
>   ? __fget_light+0x64/0x89
>   ksys_write+0xac/0xfe
>   ? __ia32_sys_read+0x40/0x40
>   ? tracer_hardirqs_off+0x18/0x16d
>   ? tracer_hardirqs_on+0x11/0x146
>   do_syscall_64+0x9a/0xfd
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  RIP: 0033:0x7f86c4487140
>  Code: 40 00 48 8b 15 c1 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
>  RSP: 002b:00007ffca9f62af8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>  RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007f86c4487140
>  RDX: 0000000000000400 RSI: 000055ba75b1a000 RDI: 0000000000000001
>  RBP: 000055ba75b1a000 R08: 0000000000000000 R09: 00007f86c457c080
>  R10: 00007f86c43a84d0 R11: 0000000000000202 R12: 0000000000000000
>  R13: 0000000000000000 R14: 000055ba75b1a000 R15: 0000000000000400
>   </TASK>
>  irq event stamp: 0
>  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>  hardirqs last disabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
>  softirqs last  enabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
>  softirqs last disabled at (0): [<0000000000000000>] 0x0
> 
> After investigation, we found the following bug.
> 
> In the above resource tree, "System RAM" is a descendant of "CXL
> Window 0" instead of a top level resource.  So, region_intersects()
> will report no System RAM resources in the CXL memory region
> incorrectly, because it only checks the top level resources.
> Consequently, devmem_is_allowed() will return 1 (allow access via
> /dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
> doesn't allow to map System RAM and reject the access.
> 
> However, region_intersects() needs to be fixed to work correctly with
> the resources tree with CXL Window as above.  To fix it, we will
> search matched resources in the descendant resources too.  So, we will
> not miss any matched resources anymore.

Thanks for this Ying!

I think this needs an explanation of the expected semantics of
region_intersects() and maybe a fixup to meet that expectation, see
below.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 14777afb0a99..c97a5add9394 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -542,18 +542,48 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
>  {
>  	struct resource res;
>  	int type = 0; int other = 0;
> -	struct resource *p;
> +	struct resource *p, *dp;
> +	resource_size_t ostart, oend;
> +	bool is_type;
>  
>  	res.start = start;
>  	res.end = start + size - 1;
>  
>  	for (p = parent->child; p ; p = p->sibling) {
> -		bool is_type = (((p->flags & flags) == flags) &&
> -				((desc == IORES_DESC_NONE) ||
> -				 (desc == p->desc)));
> -
> -		if (resource_overlaps(p, &res))
> -			is_type ? type++ : other++;
> +		if (!resource_overlaps(p, &res))
> +			continue;
> +		is_type = (((p->flags & flags) == flags) &&
> +			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));
> +		if (is_type) {
> +			type++;
> +			continue;
> +		}
> +		/*
> +		 * Continue to search in descendant resources.  Unless
> +		 * the matched descendant resources cover the whole
> +		 * overlapped range, increase 'other', because it
> +		 * overlaps with 'p' at least.
> +		 */
> +		other++;

This results in REGION_MIXED whenever the target of the search is found
as a descendant of @parent which I believe is unwanted.

The semantics of region_intersects() has always been within a single
sibling level to date. So, I don't think @other should be incremented
until @is_type is non-zero. It follows that if @is_type is set and
!resource_contains(p, &res) then there is no point in descending because
it is known at that there are no descendants to worry about.

I do note that with those changes region_intersects() will start
reporting REGION_MIXED rather than REGION_INTERSECTS when the passed in
range intersects a hole plus the target, but I am not aware of any code
path that expects to ignore resource holes. I.e. better to report holes
as occupied in that case.

Lastly, it would probably also be useful to special case the "@flags ==
0 && @desc == IORES_DESC_NONE" case because there is no point in
descending the resource tree to look for additional holes. Those are all
visible at the top of the resource tree.
