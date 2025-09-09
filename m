Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30B3597A
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439939; cv=fail; b=OivmPYMRyqZ6oCARzvdmOl3Epo2xOVvdwM5eqV8EydxR/JVdbT6WsoBEG9zA7sphASTSNhoXCyVp/viWdOBJDX2jw3g4P7yn/H1nj5LfdjAG9G1I3XcXNduWuj4D1T3xEhAmtJQLvR6M5EUqOz404sic2QlDkEGvYDaZXCuLdu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439939; c=relaxed/simple;
	bh=aQYPtA3k+qZivt5ST5aTMsRVFhiE5EGmQQmaHbKizLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQy7N2rNszMSoG+DKfpJXhnAp1E31/yUUp3EunXMVO+Ery+zn4FJ4mzXKxX2I+JiTCvksKLqN+kSaK9CtUSJ41dhGzd/Ed+CAq3MyIZP6QAWsknfxwRZmXKPqA+C0BIwEqqH+CHkYirkzki1lw39SDO1C9SV+4qi+YQzN8I8Hao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9reGQM7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9reGQM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757439937; x=1788975937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aQYPtA3k+qZivt5ST5aTMsRVFhiE5EGmQQmaHbKizLU=;
  b=J9reGQM7/0z//vUIUzGpclBUtJNWO4fJKJ6YJ3/2vnmnjTDzd7s3dWjP
   YhCSfx7CKyX/A8nT3l09wDmIvM+g0Ec28YhtXUux3+qp2TsC60XpLpffW
   AiABrcfJxNl6AgzLDSLjh0d6mOHFRKsJLzh/2VK7yYpIUua+YV9l+4sd3
   wzUE2+UuaO8fwGo8KutTJujlr/c6+9/MPT0+36JnnQmpBl0+5h5kveGhz
   fWldNWk8ErBUgE8BFKLewMSyW49bXvuEZbu8goPybCNCfrMxhRnxBVVU4
   Ig5lBhRSmqssoxHZM9j3LsX4WSaUQfZ855+Vym97RoBLT+F658WjfapHh
   w==;
X-CSE-ConnectionGUID: i/C3qT2cSbCXwlPm+HFNVg==
X-CSE-MsgGUID: HzYMLkGsRReaAeQ9t247Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62365806"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62365806"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:45:37 -0700
X-CSE-ConnectionGUID: VCBeX6l5RNC6mY7I3F3tjA==
X-CSE-MsgGUID: dSJuYm3VRcu4a5qftKzaXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173949003"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:45:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 10:45:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 10:45:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 10:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQKAqhdCS+EtFYOVarv+roYrYO/tnQkCg8UbTH2WZg7/WVWm05vHMxm5HW06wKUXsl607iQLJUPtHNAYpIsbmiZ4lScTVb81UE2nhhkVKxqagmDOOXMUGGcXKSHr3hEakGVQPHXkjaEtYPGCJfUiVRKQoCxJ1lo3j+DRepHNSvnhDtXty7oZ0SgbK9yOCqKSZtBnvj1wn0L3+mc2/q5kUi8C99FeR9J3zQ75Jh0TWee7Q06FPBEkG/T9YAlaHgqzi5yrj6NpI9IzoPVwJWJvS93A94BG8VCJp9KI/1SQ9q/YEzgEXx5YyzCmBdoSZXsgDpmD9puEUjZXLQlGnCzC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCpeKr5ec1qeHcJOw3kbzaDWYY/qZXukPvdVkH81F6I=;
 b=XV0gBVCTm9ATiIRiaB5bPcCx3A8rEAxuasfSt96sDYEdwkipwz4unDZ2+3QUxMh01QJ3fe2kspgU2RXXQd5VhPSaoyl6rUKefqaoz5H/4TgWidRPphroXwHoDEMM0fCxNIznBETYFkq8ru6eBwLN6BrFMjfKcS2xVt/YRyynptNPhwkeqglENZjMepgwjAqg312VfhnoLhdyuBDy8T+ftdziHIbE2Mw/TS6qEJpa2NrCz6/0Vq4ek74CGJmVd8x0yyHax+ZJk6utNDbVJ6MvZ+splhxLMRo+hrWDeDzzl7cLU+XpnpJFvEaRQiDcrmRezXJdBLlJDvnAUSdcFdNddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:45:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:45:33 +0000
Date: Tue, 9 Sep 2025 10:45:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/region: Refactor address translation funcs
 for testing
Message-ID: <aMBnteQTnLZRwfvK@aschofie-mobl2.lan>
References: <cover.1756446925.git.alison.schofield@intel.com>
 <f0c6fa733cea8585f2bfda0851489bd7ca2e2b2c.1756446925.git.alison.schofield@intel.com>
 <20250909171005.000040f6@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250909171005.000040f6@huawei.com>
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 886e41a8-c706-451a-e638-08ddefc8acdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nq7aZrHm4IhxPEw3fIEDk+XtR/1INlyoRsrvhvAiIRABhqatnpxg+1Urr/jd?=
 =?us-ascii?Q?9bXvOSjyVo8DSzjlpnoAViLKIuPsfLon6Q2aqoSN62pDzxxuYNy2uM5Yv6wZ?=
 =?us-ascii?Q?AokFfzXMHDWAFjpOF6J95B0ceDKupQn+h2zQZqi3B4lmKVonnipgHfhCyWbz?=
 =?us-ascii?Q?pkyVmV+UADsJzq+AIZqYw3oqhKUDB3pgOIuhZKpKC+mg9DeaTnQPnCAvOViu?=
 =?us-ascii?Q?q4X12hBJuUoeN9U0do7XYZEp00VxYeZP4Vf4h/hKH6Ut9xt3VFm3FqG5cZ4i?=
 =?us-ascii?Q?A6JIYnMZZrmSl7rn+OYNc9dUIZpyv/l2zUPtwnMbg71A3tZHcxcgxLzGAYsx?=
 =?us-ascii?Q?T/z8bldJnl4RGaU9iFtVLPG8KeX/D2BfSuxN78t4vK+wswYJFEIB0wSE9VvO?=
 =?us-ascii?Q?PAstT8niSVLyQqNvKhhEJMYZwyN+AJzU5Os5sb33F8ArLykj2Am/uqb/WbK7?=
 =?us-ascii?Q?W9P0PqZsXPYx4GI0MZHG3EPqFN3Qv6lireG86F5ANcfMEWD8UlHuKhXMXTpI?=
 =?us-ascii?Q?tcaqeKhiY6D9U2ApRCzyoQIqt2nV+q6clApAVpR1pfPvziyDGFv6UzpTIJ84?=
 =?us-ascii?Q?67bdvd+DSCby8dhK2QW1r5uTzkh5OM0JYQ3NzudOX5EQjNYSiJREqv7VcsD6?=
 =?us-ascii?Q?DvbaQplGBDiYvBHkvd74fYuILPaHInFzJWYxHRorFX8/H0os3UCEgX5ShlMi?=
 =?us-ascii?Q?a8RWmxZ3nguZwY+RZcHUEt2wYRkJ2+SzElx4Nfy5SlP3ka/oAqP3/SiivKSX?=
 =?us-ascii?Q?P5KsBznM/PaDNHi+ExJW81vco/9ZPSijcvXKq0X1ffgoCLA/3FsYJ7lqhv77?=
 =?us-ascii?Q?+TgKZxH2jTETxvO8oiKqx3ht/CkRB0SIlrEx2ph1zQBrEItWJVhAuiEES/X0?=
 =?us-ascii?Q?0tKmsMHtOZSA2U8Ygzp9/ujD6VyrCFJyz/X4zO7ni4U3F5tfx2/UZRFjlaD1?=
 =?us-ascii?Q?Fi1W0epGY6aoOklDGbVFh8GjzqaUk2v0uxOvxtUKR/I1E5K6qKmXfCRhOyqQ?=
 =?us-ascii?Q?BO5eOeDrb9/YtThvChYNmmvIJ6kI/TLsIsLtheqkUUuuEEF3I2seHjI+vbrB?=
 =?us-ascii?Q?aNulkxbX7L5QoEwyXcMYIe2/ghSo4HndNCaam3P1lriD7rksyhH/JUuzKhyS?=
 =?us-ascii?Q?/90x4XJqyaBzUYt0MpW5Hk+iybo+UVYmqI9wgsUarafYblTkQnSTI4nM2lOm?=
 =?us-ascii?Q?yrMBK2kUhhAJLBfh0sKMU9UaC9GlZF+fsX1HV7uel1/tpi32xbhDzA1X8AY8?=
 =?us-ascii?Q?bQb1ZIlUTWNx7bU/juWpDxa3c4qcHcTvOT6u5tP+/jYRA3SRpIcIwW+q+xlO?=
 =?us-ascii?Q?wr0xPKVmB9sLixVBkKAzhaBnwBZGWqdndVE9ZjhVYR+0+hkss5su/vTfIxXZ?=
 =?us-ascii?Q?mbWP451LnNGoQe+5uaUjzhwR26wN+Gtjf7zOJzYhhPmWGqiP486e78ZoU6td?=
 =?us-ascii?Q?LQ29OoGL5Mg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBPah8NXGMgnmhStiJKwNpXIjsjcqPELFEt6W7jO3djos/2OrF2lF02CNijA?=
 =?us-ascii?Q?0S/XpakB6qMvK8B0h19h/i1iTJKKXX3i8X64cmJtxF1VTbEuSOnmmSBkeU4g?=
 =?us-ascii?Q?JIIxuGKRZT3d6UKJbz0VrNUM5v9Fw2yD1QTK6/YgOHU7hAVMvIGQygRzPUgl?=
 =?us-ascii?Q?BBllp6tVFKnGcHagXiRILRXhESntAgkR0qoxetXjoviWa5US45voJq/QiN6E?=
 =?us-ascii?Q?GgM7CVBM+JnRDsQ3xsbyJME3He3fXCRKF9ENpUkb1llxiey2+6pdolr/fphU?=
 =?us-ascii?Q?XRWYSsbfAZw5LO7i4pK2ImWb3tmOXrIp6aViEOyJoZRjzBzg6sN12W9rI0k5?=
 =?us-ascii?Q?fahLIlstyLDHqQYog9PH1HW2Hp0RUbq73/afIS1YEz8O6AYRzwXsS5x33STW?=
 =?us-ascii?Q?jQHlJMZlmsTM6D38Wh2m3rqQJ7XGYo5URZmwCF1uzOwbgmEafdCFORPnW+C2?=
 =?us-ascii?Q?ciVyNxwZPGOUEDZ2xuxQS7nODHvCxGSPKrQDxEMtyzCNMdQlzdKhVcmbu7oL?=
 =?us-ascii?Q?bVWXsz5gst3uR3gSrzPS0bZKaNTd1JLlE+f060bNV+T48XjwO6czHEg3F2GL?=
 =?us-ascii?Q?8H4Fdcaa4l5Q12OaxgG4pCsmaE31T+YLaYNtkdKzRPfg6WV0i3EArk0F+ztb?=
 =?us-ascii?Q?JYL7XkM4QnLBFt4n27PwsvPVVPmzvTxH1bY9EVkVtQTbQGZ2NhF0FrLCCja8?=
 =?us-ascii?Q?bC3/TSzz4Up29R9jZjz1FUkw7/JFtHK7KDH3IMufmEaK3eabsYMF4SMvb+P1?=
 =?us-ascii?Q?KPY/V377UkMqcot3G8hVRzY3yGsbl+VHfVOmhMzFkyirmeCn0BJGNMnJNuCL?=
 =?us-ascii?Q?nY7u15rdg89wAgz3/J9VpLO2+Bxoo+Wtxo3f6uBSk4NlPcpeRx/invhyMx9J?=
 =?us-ascii?Q?ddduAYy+nrMwVmlQ/gyG9B4MuNTC140MiK61qK0XW2Fd2fujtn4T8p6YbfT8?=
 =?us-ascii?Q?ZaCdyEZY+OwyD4wh6kHWoom5OFDr0gESXtecZt/aQ5e1F5mtN7zJglq8fe6r?=
 =?us-ascii?Q?tPMAcqzoK1wvYhYtQRZ9sgTcvOZ955rZLI+kzunZxwk1hfJqhGwKzl8iANi0?=
 =?us-ascii?Q?6uxs/s0NUQli7zvvf3vAmbdfYhaG6uGlPCSe4RiN1PoJ7kcXQiJ+nkgECU5a?=
 =?us-ascii?Q?jKkrUOsW0QvjQHoMSsaig6O2YqqDAXlPcRyuRAHT6rg7nWB2c5FkA6ofzhJf?=
 =?us-ascii?Q?W4/fgc1V6tmgzxfgXCreMjQ6wx3BhEJa0xR6pbROiWT9nONOEJEggxvFK4R6?=
 =?us-ascii?Q?BcWlmE5xxA3iqZDSuJBGW06HW3sl+ijW8xDS0ytMi+z01fNN3vi/KaZEMtY2?=
 =?us-ascii?Q?TML+BGDhsuHvkuJuCqmqis6Di9uGGKIu8T1oO2vGzXt1Cy688NLC0GmW0FJF?=
 =?us-ascii?Q?WDIgRzNwVFOmhC1InCuE8gh/W88TtuYjPdomTXeM81/SnN4n2Objlm9vlkcY?=
 =?us-ascii?Q?Z3qeW7b9cPrBSTLRLry6o7lDEnuGvR/J7ZLr00h6roYLarJGt3lHZF/c62Ri?=
 =?us-ascii?Q?eXUGaWYK7IporhTGtRryKFAry4uO9Ju45j+8mEqI00GX6MbQpeH6fFa6MchL?=
 =?us-ascii?Q?4wtZUAweaOg41oVS30YZX5oGvaVExS7ncUwpi8gtqYM4gfbiHlr8ZeFUpNHn?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 886e41a8-c706-451a-e638-08ddefc8acdc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:45:33.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrCIGnx0INIyuanx3Me9o2rtZ7xyLvhtSLFH/nV2WneIb9/3Ohu7K1grXyWfBw/GyijHJ5Y/A/I/QdIWASBDTqroTRnahYFtglQdOpgIhBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com

On Tue, Sep 09, 2025 at 05:10:05PM +0100, Jonathan Cameron wrote:
> On Fri, 29 Aug 2025 00:21:25 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > In preparation for adding a test module that exercises the address
> > translation calculations, extract the core calculations into stand-
> > alone functions that operate on base parameters without dependencies
> > on struct cxl_region.
> > 
> > Mark the new functions as static outside of test builds by adding
> > and using a new __mock_export label.
> 
> For the __mock_exports magic, I assume that can be applied in existing
> cases as well.  Perhaps better to introduce it for them first?
> That would give a nice clear example of what changes.

I came upon this new-ish helper and intend to replace the __mock_exports
magic with it in the next revision of this set.

707f853d7fa3 ("module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper")

I think the existing cxl_num_decoders_committed can use the helper too,
and if that works out I'll present it first as an example of using the
new helper as you suggest.

Thanks for the review!

> 
