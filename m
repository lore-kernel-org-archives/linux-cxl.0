Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF412FB0A
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462150; cv=fail; b=m/t+z2PHWWifUDLSJl8IQua4GuxN7PNDFXNAKJK9w0cJlQzK0YEKvRpvqxDvsIPLlnY+FW0+Hb8647H45XhJqmP9Ta1gdI7n91pXKkRc6MIaRfIucCWN5mnT6S3EpEDN4cMeFZIoHs7jo+HmfhLJiCF5RbMgEcFPeyOePlRAXAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462150; c=relaxed/simple;
	bh=S8vulEBfcbSPwDJeRW+Ce5FE9D1kEvewerH+e8Fs1Tk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LhjN0mQxV62EgSVOrknhfa3zVHV9MIeJwixxt+3NMK0laxzMzm9Orkc+fAMJlGtqvrg2kmMs/cTqMz1XKQbt/ALz7GaO7r9U7S67OJz77ydKYjAyAI3ABaRnwukRxNrjL99x1NwRYomj4KHyF/4L0JuIC0MbdrAXhcRAwPvFfZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayYFsbzI; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayYFsbzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733462148; x=1764998148;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S8vulEBfcbSPwDJeRW+Ce5FE9D1kEvewerH+e8Fs1Tk=;
  b=ayYFsbzIaAQkyJQMc7/Q8rk5/zc8y6R8WXSYCWd2vL160ssmqlhRAuKW
   rEjSaLnru71Kvv2PM7HcZRXmIy09W8wJd5MM8G4nyw/rlh3nipOtnFKHs
   0yX1vkrw1JkRIHACoaWHc+jXXBP06H8jY/wBz8QUoLN43B5pggwUKR2NG
   mQsV/sQBTrbG6+9mYB7MNYhAh+9H6izjp0hbwBYPvPwqNi3JxW3JZRROP
   EszOSGBOK8ZDKmC6ghTStO26y7tPnenntzzwxqJ/xMEn9I9R3F1s30ZI1
   iAzoXTRe3nPsQUOfFNbVOmB0WjJH6JoNKs4sL/F7/GaAslXqTGgqo+T6e
   A==;
X-CSE-ConnectionGUID: zFiuzNUoSlSdCo4W0aD9IQ==
X-CSE-MsgGUID: SdJxZjGfR4Oxjo1xmrnLLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33155729"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33155729"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:15:48 -0800
X-CSE-ConnectionGUID: vLsVYoKTRYa/zIL9igz+nA==
X-CSE-MsgGUID: jLRUs5tLQx+H2F3Tw0FkQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="99127061"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 21:15:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 21:15:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 21:15:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 21:15:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6WJwTZBH2Dm4hICopTAj5Qy6+0ajwMkFsniBeZAY0cAsrhiLTLGUujlCarTswjTVFXjiZJLzoRSXsqzCPRdb67q8taGT3juwWb1OHX6ciblLaC2IuEKM9QV8yZTa59lXgfDVCVwBNdo6Sy/uaEClFSFbJAsVQu/WHL92qXDd+do37KVYTazq3JboZZkGV6su+hx/M+OiepycVR9Z3/W03n4SjtM9r00UqeCKyVbSEMMQVw1QzwxQa4SY/ktbthavWvcP8jERPRQvzZfARCYMEqVlIfYPre5aEFM0Jt3N/ngnujiDJ1ZY3zu4Tf0uVzLj0Drgz2NE/t+yLmK6ChFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPCy5fVDefMdOeCqlRComOf+7lNoNeGQdmhitxOQvNA=;
 b=W3DVxYO3PrCZNpApa6uVw4twuIlessCgAgtVnL567KQssrmpx+64SN/7c6NhWK4sR26cN8+vHBqnNp5Iu19CMlJCXofVt/Dz2uux83NuVEuPxODzhTi+HDyKvKL9JnTfxw3D+scdv+eIiYxERmroAa6MFsboHvQX27Z5wP9yxmyDdwqNMaGy4CqLnJgdjKdwKXXmjSZBbVVxaRO3RynMY6T6RyRELyMLEXT/sGApdmYMBLpL7qFASe5zVm2n9Tuw2zNodEo8DUZeauwztuwrGQKW/UGgrUBP71kUPQlQ4j9Bs1fxDtO5GutUEycf4buqRufwOqsRnpLNBCiqY0/GGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 6 Dec
 2024 05:15:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:15:43 +0000
Date: Thu, 5 Dec 2024 21:15:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 10/20] fwctl/cxl: Add support for get driver
 information
Message-ID: <6752887cbf8ac_250732940@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-11-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-11-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c59492d-8c31-4775-e188-08dd15b508af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tu9BGLa9r6uI+d+Cr8HNqRhw1BR4bQKGtMsBCPaM/Ae1pDTYihv3BKHCaR2a?=
 =?us-ascii?Q?tdfTE5+k9O0wpXG0CjaH9478sCkXLYdFvufndd/xImRGo84HXzuBaE1YszUy?=
 =?us-ascii?Q?w2+8KN5lBToiQHLH68GgnA9TCyI+ejUFvAYo/ts/1aO5fbIlqiEKJAK019S0?=
 =?us-ascii?Q?vmqxWlzzAvlFviMschYxhMf2RiAYBOTY6HZAZP0oKVQR+TCeLca3NbCWXwc0?=
 =?us-ascii?Q?6kcdmdG3B4WMcgoKkR+QfDdFPgpFRyKvD32zOV15Z9HVse/C6IgJUMUOUmR2?=
 =?us-ascii?Q?PwFAqt1VYhV2/eFfk95ZgCT+XNWisx75nUP3Ryhxz7K68FNSlmfwsXz+Wtg7?=
 =?us-ascii?Q?2+KZ6h5+TJHMW3SsF5PFnqu/bLVWE1/WFyv3wqezK14YLbxkyyjv0k5th06S?=
 =?us-ascii?Q?GVGpdqH2OqM9T/heMm0/PPGYx/BED+8EAkC60+kjfb4b+UrqzYQd9l8jD/lA?=
 =?us-ascii?Q?fAKfQA7kmFh7Ju7g1ZfYss3op51v822utZr+9VxplFoVnVWE8hN8gbdZnf9c?=
 =?us-ascii?Q?YGdscrnJDreK/vcbEyMiMPPgoGeTPA6kEGwibcSzLIfZGauTaDLQzCcWY3k0?=
 =?us-ascii?Q?SMobJ2FE0q4903ZMZ5s1eJLcSHojTLv79hbTrm91mbnD1iNN3FfVe1dx5iKK?=
 =?us-ascii?Q?KTvJKgsya47PIba66N8UIWZDlXXYjAdAdLCckKfQrKZlaKJYvhbNAQqGvi1e?=
 =?us-ascii?Q?RcT0FvYsdJlLKEjHF0YQzsPmPjDUfKSiQ87DOhl3AaM2xrrx12j8aCGvLolD?=
 =?us-ascii?Q?o5F6991+4s1fEowIohQyQDG6kswHzj7b4m4HDhqJy3+vluexYQoLwz1XD9by?=
 =?us-ascii?Q?WDmifVVuI0TCUtagiI12zgUl8mWs9/Ijb6m/+SnFFhCqAvZP7fztJRcoyqMQ?=
 =?us-ascii?Q?zRuWljKLQninWNVYjWsSQTkUGC9rn8wqsQkdJaEqUeM+L5p1MO0PkavZrpqM?=
 =?us-ascii?Q?jmRixRad9J/0QVpPM1xZwVSDLEc6hHSj6Fk5qsKm3nEdn3louqv5xYOY0VVa?=
 =?us-ascii?Q?HeJsHj9lFSg4wmvCAoZdkIoRt73VF7D5OeuUrHOC44mjRZjo/3i/wmNj8t0h?=
 =?us-ascii?Q?57ol+d2qF6Nu6ommbIslYWyXx5p5lW8TLo+lZnTdSqgjA0VF9IqNjTuipeyN?=
 =?us-ascii?Q?xs2ySbS0WN0nhvBDl0rMMReoa5k6ESus+xv6jNUGkDg36aTCmePem5msk226?=
 =?us-ascii?Q?9g4agFxMUOE3WBIwq9XFdwKPCofT/OvRdMEI/aKaaFZwdVB58Ci3GvhLuNCo?=
 =?us-ascii?Q?om0aPLbVWI+qyoEBf8whD3ElSlYPz8JU2skj2zH6cSAcyH50TXrweYdpyPdz?=
 =?us-ascii?Q?zTPCizxu/X+BElJ72FIqEZvwsiRN57/VUcZCKnTQ7/oepQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLKNeWqb1qkoVtycI66CenPFFcwlCLC8/rPol6Io/wLUVsUl1Y2n0lRVn5p8?=
 =?us-ascii?Q?iLah2wIBMP2a/+8oS164MCtW09ZeMJfZh/u05lkrGQnRuUQ7V/KWN73EOGIJ?=
 =?us-ascii?Q?dZcdor13S9hreGZqHJNfGHnWiT4HR0zQ4kmMcLS+JVKqKh7U+bpZlKjnLPoG?=
 =?us-ascii?Q?NGEtd7Rib2hPbB9p67FpOgZ4kUSg3SYwj/2hH/qa0+QYL/cwINx/alHfLCuT?=
 =?us-ascii?Q?4cbXDwrEkFqZsK1wWWcvUovBxevzzRcQJS7MBVIzZ6tgLOAVFwoL0mnvQcGe?=
 =?us-ascii?Q?B0eTPQ8yCteN/G6mxY7ATG3o475tisiuRbLM89Cc5vLpOQJNM5LJUSsWrOC0?=
 =?us-ascii?Q?CYPAzeuPmkzJdbOyWjGLAT2H5zhZEGjj/N9F0gh9Dro2GjpZZR0/MBccs3KL?=
 =?us-ascii?Q?h4zUyzs5RkNo+/9HmOvzKid25KGGgMY7NBnl9NhZnoms5As9lPvn+yclDwHb?=
 =?us-ascii?Q?X/2/jwtgAp0bcS+FPbee0qmLu1WzKb/RAMxOGa9xgtTMfAcZsgZzs7MoPdLz?=
 =?us-ascii?Q?vsmuMGYdux4F9XeOlyJrPvyHZjgrNpTqsp4yOl22nLQuG83Umc/QUNryHHRJ?=
 =?us-ascii?Q?VO3Sk9cho2rR8cRJHYIQq6Qse+pDwV2rOzV6BUdJ8hI4U9BTdvNJuXErkUP+?=
 =?us-ascii?Q?GeD/R5DbIAwJ/mZNcCk8+cS/pZm+WewWWgC1tGLG9hnpFrjxgWl2Gm74T/5C?=
 =?us-ascii?Q?mRgM2+3yxEHg5Cm/+9Voy0ceqRH/YGSOHGDwKvjO1/8NYMz29hDGKLCTdQQp?=
 =?us-ascii?Q?TE0/GWDHBa6Yb8rgspiHAzHnURf1WlwD4w5xN8kBs+ZcX82+hSGDfWqo8awp?=
 =?us-ascii?Q?6LMRY1lM7k29uz31g0TAGMbE+r/M6nLl8xsr+KiZDDw4GxSYQFetB1WUHn6q?=
 =?us-ascii?Q?dB0P+c1PvZ2BCaR5tBGteHVebmBnX4So+hI6/wT6VIltMqhgw8J/J/GzeAw2?=
 =?us-ascii?Q?cXEEzVxNpYpOYGcJIsPNY+g28pGpbehZiB94HkB6Qr8gcH24kNdjVbN9uAZk?=
 =?us-ascii?Q?r7kbilpQZE2rpzp/Jsqba4orG4PfWXeSOsEEUp8RgKgE4zS5aCB30gSxAcWB?=
 =?us-ascii?Q?GZtS+6Og24hZRtP4W4AfNNcZbxNbToD8af+Ojo6noBThoQlzDIcmSwxUV7En?=
 =?us-ascii?Q?F4j1f4mLDiVOC74B9rnMQAt9BY4MWBglwfNrB9R82aS6ggt//MNiuaIOAExQ?=
 =?us-ascii?Q?zcckkL28lu4UFEDuCXzecrcgVOsbQ19hqDEbfrNRwhrdQcQIU5YpBfkpzQHh?=
 =?us-ascii?Q?KRTIUK+5VmkyBar2sE0P/1EqAAVhu3emcuFpgGEEqjHCBtDPTylM2TlGvqNJ?=
 =?us-ascii?Q?Hy1ip+psQsHjedrE+FIpPsf9L3pj1cfrF9VkWW9W9qTBIf7GxeycPjRGWOVq?=
 =?us-ascii?Q?W3nzcyH1JqUJfEDQF9zD/T1GgkKG7Bu3h5LmTByJ6HLS3/TK160qurI5QQcU?=
 =?us-ascii?Q?SFAv3Hm9n/iF9rP8bEoP6eIPcIs79CUFbNWY8xOnF8Z1QxzQwOdMpBhhlK1N?=
 =?us-ascii?Q?nZZERvY6hrrlCcvgzVmT2yYbw5Pmu+hCmmQvfDka+ov+Ul/j5Xhwmzv0qllx?=
 =?us-ascii?Q?tss6lWvTsfGKck1radP66tYN3t1uv4bOhPilg57W3lrWfFHY/qIqxuZ/vPMk?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c59492d-8c31-4775-e188-08dd15b508af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:15:43.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raEHvm6/VCpKYnR7AUoE/W4riJFWj0yWH3ukSWXOypitF7ju54l/pQrf6Y0QeycCRnRKAAg8wqQSXpRJ8dm1FDXT0Ztopa8+r36ouER233o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add definition for fwctl_ops->info() to return driver information. The
> function will return the number of device mailbox commands supported by the
> fwctl char device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Change driver info to report number of commands supported by the driver and device.
> ---
>  drivers/cxl/core/mbox.c  | 46 ++++++++++++++++++++++++++++++++++++++++
>  drivers/fwctl/cxl/cxl.c  | 23 ++++++++++++++++++--
>  include/cxl/cxl.h        |  2 ++
>  include/cxl/mailbox.h    |  1 +
>  include/uapi/fwctl/cxl.h | 22 +++++++++++++++++++
>  5 files changed, 92 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/fwctl/cxl.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 12758e763650..f464eb42f08a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -118,6 +118,14 @@ static u8 security_command_sets[] = {
>  	0x46, /* Security Passthrough */
>  };
>  
> +#define FWCTL_CXL_MAX_COMMANDS 3
> +/* Command set that is allowed with FWCTL-CXL */
> +static u16 fwctl_command_sets[] = {
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +	CXL_MBOX_OP_GET_FEATURE,
> +	CXL_MBOX_OP_SET_FEATURE,
> +};
> +
>  static bool cxl_is_security_command(u16 opcode)
>  {
>  	int i;
> @@ -527,6 +535,44 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>  				 send_cmd->in.payload);
>  }
>  
> +static struct cxl_mem_command *
> +fwctl_cxl_find_command(struct cxl_mailbox *cxl_mbox, u16 opcode)
> +{
> +	struct cxl_command_info *info;
> +	struct cxl_mem_command *cmd;
> +
> +	cmd = cxl_mem_find_command(opcode);
> +	if (!cmd)
> +		return NULL;
> +
> +	info = &cmd->info;
> +	if (test_bit(info->id, cxl_mbox->enabled_cmds) &&
> +	    !test_bit(info->id, cxl_mbox->exclusive_cmds))

If fwctl_cxl is an internal command submission path, it will always be
exclusive to the kernel. If {set,get}_features is exclusively CXL then
it gets even simpler to reason about.

> +		return cmd;
> +
> +	return NULL;
> +}
> +
> +/**
> + * cxl_mailbox_user_commands_supported() - Return number of user mailbox
> + *                                         commands supported.
> + * @cxl_mbox: cxl mailbox context
> + *
> + * Return: number of commands supported
> + */
> +int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox)
> +{
> +	int nr_cmds = 0;
> +
> +	for (int i = 0; i < FWCTL_CXL_MAX_COMMANDS; i++) {
> +		nr_cmds += !!fwctl_cxl_find_command(cxl_mbox,
> +						    fwctl_command_sets[i]);

This seems overly complicated for a submission that only needs to worry
about 3 commands max. You might even just statically claim to support
all three and let things naturally fail when no features are enabled, or
the device only supports get and not set.

I.e. what happens if this says SET_FEATURE is supported and someone
passes a read-only feature, or the SET FEATURE command is missing? That
would seem to be the job of input validation, not this registration
path, right?

> +	}
> +
> +	return nr_cmds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_user_commands_supported, CXL);
> +
>  int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
>  		  struct cxl_mem_query_commands __user *q)
>  {
> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
> index c6a11cbbd937..5eb5eabf2bff 100644
> --- a/drivers/fwctl/cxl/cxl.c
> +++ b/drivers/fwctl/cxl/cxl.c
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <cxl/cxl.h>
>  #include <cxl/mailbox.h>
> +#include <uapi/fwctl/cxl.h>
>  
>  struct cxlctl_uctx {
>  	struct fwctl_uctx uctx;
> @@ -21,6 +22,15 @@ DEFINE_FREE(cxlctl, struct cxlctl_dev *, if (_T) fwctl_put(&_T->fwctl))
>  
>  static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
>  {
> +	struct cxlctl_uctx *cxlctl_uctx =
> +		container_of(uctx, struct cxlctl_uctx, uctx);

This is copy-pasta'd enough times that I think a:

struct cxlctl_uctx *to_uctx(struct fwctl_uctx *uctx)

...helper would not hurt.
