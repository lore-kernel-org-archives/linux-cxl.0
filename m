Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C161E4BE
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355904; cv=fail; b=BdbA1LEQLmWIwNIPnpf0/ZfcH4VxbWZfkoJLjSew5Md5rk9Gh90f2yHKrfCgAUNZfgCggenRbCi1DZQsOXiH+6u2Pk2uIsm5pitVf++25RxlNczpy+QvfS2gK+IHHybZu9Evm3V+0VFX3n+t6X1Tt2fdUTVWanBT9ES/qf7JuaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355904; c=relaxed/simple;
	bh=QX2wuyqmyWvh+z14HQtQfsDFMC4xoNXhTF802UPOPgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l1xey7HUxg2/tBnEaB2WcXiqLkP9o54QMSTv3WHjK6ROMDRlib55YEFyusNn/SUaXoMFLEMDllz75uE36FCalz2VLSMs9EUO4L17K5u9VF/kCbukqXnORvVmiV5aXCwZ/HlAEAzcR3AGiNPgBWJZ4Wbire8kxAoF8P6taaqwMIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4mQSd70; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4mQSd70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712355902; x=1743891902;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QX2wuyqmyWvh+z14HQtQfsDFMC4xoNXhTF802UPOPgA=;
  b=G4mQSd703TvPn7HMxINa1YCgSaqbl3G0JNN4cOyyjxjvQHKtjCDYaqDj
   TTyxUOcG7TwtT6lpO7MK1Qkjf8KgmMpjxRD/1mjy3UKLpxpYgWQnuJP11
   Uph6+xQirvGF2uhScPXqBPKaEX9VrK81FAjY1Vohe0gOB0q6tjaPkfBfE
   P9HmFLtXqXMquny3kkG+1jAOmQ8sf1NwttJbwDEo3Kg0CL446Lvj6VhU8
   lsrtpy1RaWNOl0BXElbSC+5ukzfPOYL7yupXfELH2+7VhrCXJM5kZ0kQ6
   8vYvswESv8i4c2zbLH1xLf/VyYGIFryvJEiAJ3IYAVa5G4jJd/j2elBlz
   g==;
X-CSE-ConnectionGUID: QgiCUecvS5KxdRFNcG0akw==
X-CSE-MsgGUID: E8pDKoMTQqKoHMr/p5uvRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18436690"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18436690"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:25:01 -0700
X-CSE-ConnectionGUID: QlpwNY/mQbyVZH8B9FNzpA==
X-CSE-MsgGUID: k3bmwqInTfSm0ZCnE11Kaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19737141"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 15:25:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 15:25:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 15:25:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 15:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU6D93bg9HDMeLK/cvu/SBL8K8MNPSJdwuTqEQLjuh7U1JtR/a4ftyt3RLltkv5NNOoVfaF0qwNfQsWvuc5mL2SR7LJ5Q+oD3aoGEgifSd9Qlzp+LUQpTKlL2NMXbklg2rxnVmnAE/1BBbNLbQKSjA32FVJXjotFuS4n73oI2iJtkYamVodAhUeiQWhcq+dgDJDzwIlbLLj5nt72G5z4XosNhmXBwBQSbGZ/Ez+s5SvzGXCXsTPqL6uv68zxeAACVBp04XMDFyvthHbYAy4nyekUJ24NNa5vEz67ODwiZwOxOmu/nk2IzD/LsbZfzY20DVb9vg6v/qSeJOa8uqFKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMzQrV3Z1ffnzHbEGaH9Hv72xwToayVlk/xy+SzbgWc=;
 b=B0piz8zKj+dfXuKtUHYVz0VjP8RSpFC1UhEdPslS3X1EuW0Tbd1ttCr58mNGmvjHKi0GJiffIHkf+WC2AGwdOvtQ261QqLmHGe3jKOErOmOFvTTeU4eviKYWbxXaNWYA1ZMqnHwS3Q+C2LJb3/k1d8R9ydsAvqfn0XUs+mrVFVY14wyyOA2UMcevQt5CmQSnSqsuvhyqyixbWzj+X24PTgE4UXVQO9ZnWbkStYh98AnqozHwl5Ppf2cTSyaJuo0PkBQ84qeXPmochUEsjJBeKvhLp3SI759cJpAMhL9rzxLVxFUem5lS8DCh2ij0B2Ucz6XyeUt0ADfU8H0ptO4Fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Fri, 5 Apr
 2024 22:24:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 5 Apr 2024
 22:24:58 +0000
Date: Fri, 5 Apr 2024 15:24:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v7 2/5] cxl: Fix retrieving of access_coordinates in PCIe
 path
Message-ID: <66107a3790c72_2583ad294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
 <20240403154844.3403859-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403154844.3403859-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:303:2a::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5892:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJ8cF7fltSmAdMiHjP/MFCEHtGGRxJSBXgwt8ILorgUVJwgyH6XAG3GMghYd3oKXLYJyT7CNeT2t2hVNdM4/f8RsfpMN/b02ZVwD1MH+Ys/S0zjR2atf3PMvzZSLjn3C3+39om+/T/6ZwoY5Q34MT1R9HCWvNBkLt0ocJmayTuxyUxYYMqMFGLQAwNhs7tJS0SLY53zBgXUP3xCyWrXIrT6TLkH8JHJiJR2OEDPPkDDBXSXQLhJCV3NR8zpC74Oq/USCZZ7iuttE5P8reDroqER2CA5r4aoT+9rypYBzlglyzfPFs4HPg0UaRsjOMbkhHYt8v9L5RjeCp711Iin7zNS7Z8OJ+4MQdqgQD6CUF93LfGedOeZUvTxv8nOeB4pahg1lsGgttvUaCeLcuFVU9oxHO0wvCe/D8gz5QyIJrgUbsBqGQlTlTVhLLWkZX1RortUFNdkbN6GkY9K9jgILMW/nCla9ijUu4XQKIU1VrxcCkHATck1238c094FSnhJ9M9RZzjYUxZLDbhFPEEiFGfMIqFzkANAxHxevL0fC5/gISSqYPP+tXgUS1OGd8diEcCJjzEwJynUkaEbwjW2YqmdprHMV9fXVqpORKe/gAzXJd9VDLrwywGz0pX0yzD8m/QZCZnJXs5YXUElUzAURWCD7x2M0o48YDM88rE9AzuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rfkMHAk0UxJ/9Tdgk0Qni+EQruEMOgFyNsKKYDXZzP2ySZfZIQUmFvZCTFDI?=
 =?us-ascii?Q?E2qFcqBPR9ViDOEmKLwR7R2fVtDPlIkYl3yfD0DPF5jsf/mHQROP2NxOXBG8?=
 =?us-ascii?Q?sOSEeXtWLHgo7/pqewXoKkN0NNxLx3/Ve7fImM7ZMwsfErrWP1qrkePnzPZ6?=
 =?us-ascii?Q?CqECQR+KCMgm2etJS7esP5aFPH8aFytmDf9XeWZDOXybJW3hGoJMC7lE0pWb?=
 =?us-ascii?Q?7dX1CxLMs7WCqiEAU3L+EDGEXccJZBHZBZODjrGMgBZzjfsuoCMYQVIo9K/7?=
 =?us-ascii?Q?B1rYI7L0uOYXq+aLxZXGS4Ed7UQb6hRhtBPvZ95gBLkWv7EX3U+RF8ShWxDA?=
 =?us-ascii?Q?cb+cNBbJ1+cl/OMevaSMJnOED+YhoncdKZ7yAEK7EqVlBmLe+YO1kK8aRePz?=
 =?us-ascii?Q?wO8cy6KFkZWxl3Ils6VqN/WwQXyjk8ZtDEvFHTDULD3MpGudZPb8cicCbHv/?=
 =?us-ascii?Q?MrR9nLkmHFHN1IIJO2kBdxVssiMiVqGjc4USi+pgy8RolWoywoVkeivXjx+j?=
 =?us-ascii?Q?p86ZMa6Vp8aSezSsXUZ+2KoSUCEznvCnxJD7RhM1qeRW2/bWS6a3H+tNNHx3?=
 =?us-ascii?Q?7ngIot9USe/13+k1VNC8wv372OfltZtvS26pOL59G8Fmxecctxt1qJUSps2K?=
 =?us-ascii?Q?ZgZZo9GIzKHZ/ZQx3hWH0wudGcYU1UtL73kZOW4fCteviAThie9jekEGJpZG?=
 =?us-ascii?Q?7H89GLwIBqxbQ91QaF/fIuuSZ59VkH+f3GTbAqcMZ3F+W7OQRZ+fzsaKpK8C?=
 =?us-ascii?Q?AYWx3VrNRoR4feZMyIvFCUmRyErYwOoJHcyRHAHhJEvIcB8PPfLSGxfLyB9h?=
 =?us-ascii?Q?byhG689TNxqfYF/Ge778xhct4urC1IzhCbeFnBwxQ2Lkes6YZjKt6kEmf7Cw?=
 =?us-ascii?Q?fxEVHFSCrKcMSHmGyS7o1ao7tyY1hk40R/7oyM1RNWr7Jk3s3CoGYCOhNVUf?=
 =?us-ascii?Q?mn2TqLGF5xVNPVIk+1eQEQpf/JDcMH9x2iavwzi8l+X8ymMWjz3w7gZLzBgf?=
 =?us-ascii?Q?Nlyika4DE4Llo7BDLtA23kgHe6Fs3ENrlWo5ChnEJ0GAdF7wlqac1uDEfibP?=
 =?us-ascii?Q?8hupWuDPwhf79MrSoQ7oca3A7oIIct/DYws90YZEiLv25Aws4/jdWu7mCAk2?=
 =?us-ascii?Q?92Kx1ujbJYQZDFMCoc0wCYEIdjh/+WPZmAxBPF2DGY658tPuTKWi5JxGRZe0?=
 =?us-ascii?Q?tGTIMEci6b/BgfsoIorc+cEKYtMZCPGRTrNckdc1GGI27vvYLSjtTe0cX8ws?=
 =?us-ascii?Q?dt7d6fgfhHOWkQLjRVmUwb+j4Lk9YAMrx5Q1YYo2KBcdlaz3ejqY5K492AtC?=
 =?us-ascii?Q?2CrlKs9tem72bPOPOo0y0PnWJNR3fRHzOXF4FIuEyXUUa3jPPuVyTf2K8WrC?=
 =?us-ascii?Q?qxBP9+FrNIOE2gf7etW/aLqPfQv1WEsSJprGtdhrP2TDIUvhaeNQ5bVghh2u?=
 =?us-ascii?Q?6j2BNoLA5FsQ80X4vNCoxcEkFb1IwRA2dN6AqClQKRFziVv1CgBhuq1zStbv?=
 =?us-ascii?Q?U3W7m18ee7fVEAFI3rMIJzrk9I5auXwSMn2W0+Zj8u/C/N3NPNNEAcYPb4ft?=
 =?us-ascii?Q?E/p0Ud0AILMUyga/hVzldyKP+kJPH4IxabFyb0h1HJ/wjFGZSYxMfvV/lX/A?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a82a8da-1059-46b3-ce16-08dc55bf39e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 22:24:58.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li65MEC7k9T7oQB/cADYPm9sNdzSck48hZM9IizkIxEBft+1eE1+UDvxOAw425ZYnajPJZRnjAfN1h3q6zH0uxkXKr66L6R3IGIgk4dNsp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current loop in cxl_endpoint_get_perf_coordinates() incorrectly assumes
> the Root Port (RP) dport is the one with generic port access_coordinate.
> However those coordinates are one level up in the Host Bridge (HB).
> Current code causes the computation code to pick up 0s as the coordinates
> and cause minimal bandwidth to result in 0.
> 
> Add check to skip RP when combining coordinates.
> 
> Fixes: 4d59ba915318 ("cxl: Fix retrieving of access_coordinates in PCIe path")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks ok to me, and I see the Generic Port details are considered right
after this walk to the root-port.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
