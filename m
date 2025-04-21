Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BD1E5B72;
	Mon, 21 Apr 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257203; cv=fail; b=c6ssixoG2Q99iqpx7+P/3aeyt2YoxJyNv4ZyxKoWtiGxkgu4JC0pYhyk7Dbs4ZAapRhTaxgxR2MueI4NvgAFFpRtWVdPtMkb72VvefmHbNNS+FR8bIuy0cM0Gh3Phm8IblL7oueX5HtqkTCsd2Apv/jzrNvCYk30XeKJqJhFup8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257203; c=relaxed/simple;
	bh=A9LEC0PBFrW5iaTwIrwiLbP1KJgNKdI2Im8KqTX//PI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PkW+Baj6Lcz7+TR3Jv8gWzPw8AxyExzRcUfsZ/2hZqfyC0V1Z89Xr3LGxwztdy38CHKShaMGyPQtOATS+kc7CqYe5kB8KtpqzsxVemPDNR4Wcr+LE3fgB/Io28/6HvLmtkcDTPcKTvj3P/WJaDrrNrF4ODnwrjHNOFMmBz1+0/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzzd3i/f; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzzd3i/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745257201; x=1776793201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A9LEC0PBFrW5iaTwIrwiLbP1KJgNKdI2Im8KqTX//PI=;
  b=bzzd3i/fFq0bIJbjIghuCJeOHWJxuXO1lnLN4AjCU+GPCL9+uGN02Obd
   Eh6qKHe3h0RlAYEu+GIn6sSc+RQPr6woSQPhZvp0B7W2EvRVKxUstXfTp
   u6SPsFLnp/s15RZ+Qa/ypi/EP/VZuR9q6XjerTIW4inBV2NlzR0sI+bW3
   0TtmSH9X5tFiyu6SfNE5bVinLMfRei3p+AR14mU0LjxeMe2q+sX2Xg/z4
   kFwCFtzN1BZUk2Bw6ArvTbDjVO9JNiOWJPiXh5Fa04m10+98qP/HOc/Vs
   Labt6GPaxrIfqmO5Emwmw3rbv8Uw9SpK34I15/zDMFwOk7DCvadMLQaks
   A==;
X-CSE-ConnectionGUID: tufI6qbzT8i0Lu3oMe7sFA==
X-CSE-MsgGUID: KZc6JJmpSvC/u4SVL4uJHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="34413107"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="34413107"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 10:40:00 -0700
X-CSE-ConnectionGUID: 7Nsc+iy9SFCHAAyCico9xg==
X-CSE-MsgGUID: UnqpGf6PTYuibo3MJNVr/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="136573097"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 10:40:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 10:39:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 10:39:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 10:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdPX6m+MzjA8JIlrAKuZqRhtDpXzd0Yz7IZahh3bASH0ovKvfNHEAj3+1Qcr3FTbIuIS7MbBMc6ASMvQizVgeQsQP7JSCBCqawsLqJ6teBfMCi1+m6+f3iY8Ik4dasmXp9m8VmkKY8Q09bSh6xe5IW0u81gYDYVVapEuZVuZvg5cB+Qh9AzSQkuPt/2GqPSIjyBFdfo8oqdjdSRWzkWE2qiO/ARYNUFFS165iMuZjqkADuKz94O7tfNj2cd3j/icXIJ6iAFwYDKctrLn75y6XBP35ixHkbI15/Q41VH9IUf/eNmpa4ijBRfdk6tt5DhJl8WX8RJ8DmgKcqbQU28PGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DENWwFG3jfPcbAkuWZcA+Ui/Rit8XIqhZPyvntHT7JU=;
 b=oi2eUUk2ssLQnVAwsRQ2hEav8+giTlulfmxFemAFYrLZ68dDEEet1a0d77sMxb/wpwIOamwKn4dZ6eXLIKy1X/vjmtYAzvgjnTH2SbmTSXKIXj/Gj5l2+CpMJHw5c9Li9bBtGtdMEhlcy8jx4CKoBiSFlCj4wNfB5ee5Tof8mcP0yNetbPxoR7cjmKuW2MiuGTvj7XjYpwS03abwbY5eprlQdyNNZoxRgOh/gbngZJb6iTxDeLTD7yn5morO27OFf/N9v2nqYbMZsoZ6loIEFJK8G3uqN8Wkb14x/QIlYHqxn9Y6I/+kCMDeV3SmUCpdu8xVwYYK0lNB+s+CXxhhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 17:39:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 17:39:41 +0000
Date: Mon, 21 Apr 2025 10:39:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <ming.li@zohomail.com>, <huang.ying.caritas@gmail.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Purva Yeshi
	<purvayeshi550@gmail.com>
Subject: Re: [PATCH] cxl: core: Initialize eiw and eig to fix potential
 uninitialized use
Message-ID: <680682dabbd09_71fe29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250419203530.45594-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250419203530.45594-1-purvayeshi550@gmail.com>
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 21200bba-ff41-4803-003e-08dd80fb7f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YGhy6jJuIqYmnJxryyeJ4G8DoJxdgVpMI0cyENOhhnp6zB8KTxu+XWGbiSJy?=
 =?us-ascii?Q?ZL6yGwcaCfNlT2cAeolzG6FxlUYtZI2kyttkPUCPrZyEaQ7JIyPMKmWeW/HS?=
 =?us-ascii?Q?BYXiRrnKHMsZ1tAZcilaKEITQbSYol2kQtDb51Lxwl1JpzxCn1gy5la/HaR4?=
 =?us-ascii?Q?qqQCfJWzWwX4/BR4YspnICNazfINWuu76HCZ/FkxP/dJY7dwkBDcoxuP4xIU?=
 =?us-ascii?Q?kzMZ742GBS0f+L6SaOi4wBpFcQjJhdPJuOfMVhlKfBTB1uLUICTJPF6//LjU?=
 =?us-ascii?Q?d8UUsUswGA6CvFulLgkqMjR2TNBpRRPQNz2P69AT2Jp7G/56xC5yPFMHY0Oj?=
 =?us-ascii?Q?oEQvgUeDow0VylnD0kCbMrwQddXVjyfwMtqqptz6e6ndSX/OpHtLH0UQUnoa?=
 =?us-ascii?Q?PflzIvyTnNAtV/FXCAoMS6C1sonzuRAr+p4HOBRt/JKXgcsckZ+1plctKa8s?=
 =?us-ascii?Q?/NFkWnatiKQNWtrXs8//zx1wARfxUoHLDCjKdvfEtX4UH+cjFZVJbUwlTFTO?=
 =?us-ascii?Q?lb/qHwM89Kr7YH1F1GPiL9soxaFIw187nY+0sqB4VkfKUx5Sda6OEV1owHCN?=
 =?us-ascii?Q?qyeYJDbobgeTw1Nse6Dspapw1bBzdixKYwnyOTIllTzRlEkAY+KZUdcIkuaK?=
 =?us-ascii?Q?LaBy167wW21N0WVmqPPDlAYPw53DA47ZXSb8H+LUejODdagNHPYR1OgAXZ24?=
 =?us-ascii?Q?Gfq0QW6PGeMmz3PikT8k5nnwkEwNVUfLzWYlrBiZqHjy4n7Poxm9qUDjCr1j?=
 =?us-ascii?Q?LDtIuc1IWAkglIrI/ySReRfyYXizgwtiqgLhBvq8FmUc4ShYBajb15S7JLhC?=
 =?us-ascii?Q?C7mhJta3r+qrMVb0eq92RNVdKxZZt8nKRXhKUHxRWg+s8CgSbJtDOWTcW/nm?=
 =?us-ascii?Q?3KQTdSzHIfDSdAYBk4YvDIu7BdcgthFfFbpTOzTR7zKYO7JLYhdm+7meivuY?=
 =?us-ascii?Q?8z9m+OCfc10e+QFS4DZ4+bnhSfMSIEiFG0dtmq6gxhstwLIPWJjFk+zKcajp?=
 =?us-ascii?Q?PvtB8ImEMKHrqCsuO+pF54zWEO6SSQnHKqd1hkfySc7CFPC2PrK2t7fAR8Vj?=
 =?us-ascii?Q?a+CkHTXb1oWRti/qXJMqzm+dYGiNfWsdel315lzU8BtHoFGBEKyNPwiXIsq0?=
 =?us-ascii?Q?74vPh7uTXYtWTEjnsUX9FeLEk9uae1zEN5Ev0Lp3ab7jwN9laLnEf3pRwkHk?=
 =?us-ascii?Q?f46aQ8bZzbtC81IFJFN9obsmypUS3juWL/oB26nvYE1wmPna1FIqkHhbuG5H?=
 =?us-ascii?Q?2AxlF6aMFDGATZY8hBV35qpJ5NVe8CllwBb2/XrO7toUgpUV8Y4ZgJjvxGeO?=
 =?us-ascii?Q?eKmCxj84+CtXs+6mND2kb67o7KxM0XBelgF7TxQu+jUkYJwz35Tf9a1owtva?=
 =?us-ascii?Q?RCeHW8vXSJkfZEOLne3NZb56xJOmWGUanwEDB5JVeTx207Sb39dV/hmnaEZX?=
 =?us-ascii?Q?u0CueOfviiw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJyBAvw8xT4LSNHdAAojd6eGAofvKk0fGQm82TRzKg0i1JAcqjGzoT/Okkpr?=
 =?us-ascii?Q?hbO3PnEwpInITh3/28iN/+6IwjbaJ0bO6MdG/bvpvAIHGTbQ5EVSwqLIoWZF?=
 =?us-ascii?Q?nAmQ5FXxbALnrfVcTEKDlPDSva3jG70dScd+F0gdljpGTHUVxwc6hzIvP31Y?=
 =?us-ascii?Q?6wnD0u0qSrzfOf3L+rrUOWbp50/kSdMAgniAJ+qeUWU8St0YlyF+2qjPnfKR?=
 =?us-ascii?Q?Op9iT+ziE4w0gAox0MIvoFZyt7VlM7HN1Fm+y7R/0xxKqRzS+JU3Acl+WUB9?=
 =?us-ascii?Q?ZN/5eZa6dvuKOPmp+ka50i9AHCVdd1s0QkfxOlTURASNyv6vgaEmcE9eGMO+?=
 =?us-ascii?Q?otIFco59wjPh1LCd8jyMChRpDFNGfUlf2uGrCaRhUwxTQYuojMkQYMf++dUR?=
 =?us-ascii?Q?BBhVrjdLLsGMMXeGCvwoWFo65IVzrF3zED5/L1YthLLkiU8uZC+kZU2MMvo/?=
 =?us-ascii?Q?RlPLMzhk1FDIj6gmqDKFic/YmeRwLaTv8H3uZZf6hhBIXFHzGiXop31m0Cf1?=
 =?us-ascii?Q?PP52IHEEcIYjjjzpyCoyz0m3OkzcCmWesA1wNBbshTfyKqZKEWyctlcIPog6?=
 =?us-ascii?Q?gAtleQsw7GfM5FG5h6BPpF6veTi6FtVklii5XYA98oWCgXyvBAdKRIsUkYER?=
 =?us-ascii?Q?wpHJVyTZTUYB54Ew00V6hEoZA1hZHedVZOo0KvaaTsMKpBL6Aiz297FMMv28?=
 =?us-ascii?Q?ieWb8mP9GqB4lJzvBs7vycaAmGynz9t+38vew3fWgZi5D90pWwHdyDFLhU3a?=
 =?us-ascii?Q?lNzQW756nkVu9WLJG+u2KqwS+NArTKHKo7dwT03KTZbVNHgYxOv841G/t7Ek?=
 =?us-ascii?Q?gaKFLOKwavraAVvI5u1yBN0tNDzeV8nToAbi675NfxM7JOynt2pGyJBN6R7Y?=
 =?us-ascii?Q?lnLqlQc/o7GLRBQWWZUS53xK+Zmu6yWOlMGRiuCLS2/5gt9chomoJHm/WQ2B?=
 =?us-ascii?Q?YqomUboOrE6LmpWmhbnRgd4AqQMErjlFGnwquFd5LQUlCFTm9w2kXszzXC1r?=
 =?us-ascii?Q?/3+rANn3AzS+AOh8COvUuoAmP7vL1jAIeZbem2ATePg/gICYvOGwXS73Rt9d?=
 =?us-ascii?Q?GrJsBXbgGkRfgZCzXunIRdUHXBaLdWI5rvIWP8sDGy/DPQOah7MO+bl4m5Yl?=
 =?us-ascii?Q?4bKri44K8brUQg/cK591M79bcnJK+jTBSL1yiWgbEWNnCdEOfiKzBHankVyU?=
 =?us-ascii?Q?lp/P4d4t+yFdi69M7YmKbrdd7AM4U3kjNqj26Kjn8pZ+/ZcasYNjfHwi3e9T?=
 =?us-ascii?Q?s5rQkLi0PnFFyRArS6je3rb1n1rnXI4iH0I+9mnMXJrWH7tx9lmg5vYD5whU?=
 =?us-ascii?Q?i4rPv/GjFtW3QwfwKjskprbvrx1fHbkvLn2Si2MyrvWEDb8AZk2+g68IMgsz?=
 =?us-ascii?Q?YF08y2/n+I55TPH7araTM47sUnjWYQKDbo3PYje4PE6QxEK5LaHv8WWjhbDK?=
 =?us-ascii?Q?XN4fwd+BngkJT/yHpCNYQ8GX+twjQWRlYzqjNlOWMM3Om2XNPykpMUgG6V/x?=
 =?us-ascii?Q?G2WAN9Z1UmweTBZ1XZ9WlNA2DLD4JDj33M089nene38d8hNHhmAaxeduXDd9?=
 =?us-ascii?Q?Ie+ACgLrnupvfGSQpWU9aQk8ANHJKrklF1dyH+axiHy9WTP1ficRw4mIYWCJ?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21200bba-ff41-4803-003e-08dd80fb7f3f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:39:41.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzLZhXl3TRIsJhmvFb5xfhzxkK+hUF3JUlCIgvV7kwO37YVxBDYX7zfpM4TkLZZpobmx1yCeYnSeeLO5UTgXXpg0l1LLAOmKAAfYYeP/qGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
X-OriginatorOrg: intel.com

Purva Yeshi wrote:
> Fix Smatch-detected issue:
> 
> drivers/cxl/core/region.c:1292 check_interleave_cap()
> error: uninitialized symbol 'eiw'.
> drivers/cxl/core/region.c:1297 check_interleave_cap()
> error: uninitialized symbol 'eig'.
> drivers/cxl/core/region.c:1299 check_interleave_cap()
> error: uninitialized symbol 'eig'.
> 
> Smatch reports possible uninitialized usage of these variables if
> the helper functions ways_to_eiw() or granularity_to_eig() fail to
> assign values under certain conditions.
> 
> Initialize the eiw and eig variables to zero when they are declared
> in check_interleave_cap() to prevent potential use of uninitialized
> values.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..edf8636f190a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1266,8 +1266,8 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	unsigned int interleave_mask;
> -	u8 eiw;
> -	u16 eig;
> +	u8 eiw = 0;
> +	u16 eig = 0;

I appreciate that this quiets the warning, but it is leaving a trip
hazard for future code refactoring. I would prefer to make this scenario
harder to repeat in the future with something like:

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..5f20919207ae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -107,6 +107,7 @@ static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
 
 static inline int granularity_to_eig(int granularity, u16 *eig)
 {
+	*eig = 0;
 	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
 	    !is_power_of_2(granularity))
 		return -EINVAL;
@@ -116,6 +117,7 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
 
 static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 {
+	*eiw = 0;
 	if (ways > 16)
 		return -EINVAL;
 	if (is_power_of_2(ways)) {
