Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71238FAD
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737772491; cv=fail; b=r/azpEOVG0ZgALNr7JoSra37FKoT+N++8dqVT3KF6QL0r7y16HDgA6nphKKXU1d1zE8cV3aY/vvdSxmlZIV6Bay/4dWedpd5AhUSaqONzeqtRXJ7dYWEzBx7W/XcsPYxDkQz2Xkr6d5EztVf55XBT8vJQtuKaxEzlGd5IXSvPtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737772491; c=relaxed/simple;
	bh=a670NVQubjYQ50Vm620/CAdF58bBHQRwLsDJAVbOw4M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LjBYv8YWa+SE8W4Kl9/pQ7ic4lCBEbxvEANy3AKaqMLyZStZdkpHEThdv/Iut3wIUb9zkTTgu2qzLFLm48DMHWyteC+RbFpD0sXD83vEF4NqzQSNuJm7xUNcfMMEblnMwb+8mfBRlkBFHsi1khPYZs/eG0GbdBNRxqQJ62wur5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEoMxW6K; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEoMxW6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737772490; x=1769308490;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a670NVQubjYQ50Vm620/CAdF58bBHQRwLsDJAVbOw4M=;
  b=IEoMxW6K08dX9a/jVTUsuPPMyJRngDhEjdnvixfF9+d4b56DzYIltZ/1
   7+BkU1dyhS22fPGbKuHhIV36furq9D80raKkqENuwuxE3/O42ljCxx18k
   quQ/7S8D2NHNx9hSyZXszHWtCK99W7ooNCZDjlZ0gbEDuyrE6Fu2mGK30
   gfjXTTTBLH/b9ezZM/9eZ5UTCihu3FGJeON38puNywUFIYIAnrd92R9cF
   ZfurNx8xYfLrooI4BZEYd2wY4D9t7BM0eNIqMhyH1PpLGPKyiwDY8gWHi
   FOeJwNT8y40gJWoaPPcdqsBvqYj2n6q0fcrQwcdAf2FuQzDgEwkZCX+ob
   Q==;
X-CSE-ConnectionGUID: uOmY7DGMTCyxJBrVZTf1Iw==
X-CSE-MsgGUID: 2jLakDoqRFy1ImclP0kVwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49733681"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="49733681"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:34:49 -0800
X-CSE-ConnectionGUID: 9CRWT9/yRQ2JHM7KCOSPsA==
X-CSE-MsgGUID: Gvh4/XpURuS6vF2mOBNI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111956384"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:34:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:34:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:34:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:33:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC8O5znR+vymmk7Yz1tLuLlAhAbOOL0Y0icM73rZhr6+R4/Z1ZBmCkMkgq+r5EMUWT0NE9RZ6x7hixbj76rg9phIfZitY8CAUjFHtFwTC1YlqkCPJnsxv6tN1Lyaa64sT1/Quxzc3Tt342bUDRSiFwxpabHDQtRVZBN/2s6rv31+povoyJlqPiu9Z5Ub2h3D1L1/14dNWBV7srww/gyUnOelBdLCJZAT2WIIevwXW+sIi9nV6FgFdKZbAchHaQSI6jJraJmPaWlkMMsSEzeCbXZ3WaxvaXFPeh+RGb4/7ppLnJirdGyfL/+j6miB2avJ6/YLc1s0E10z+RVaylBKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rYBaavuo63ley7jmCekYn9PcsrvgTkhC6X+20NFCbU=;
 b=xLMkvfGPCLlcSTnWeHXJ1e+yJKUDr4nCU0cST4dsnux7VL9fhYMsP3qzq7hSCj9ADcNL7b+IBGrPF7jjBiHSTjunMQ7WRtOG3N2tFjIHwZx+J9MKnJYBz+51e7PDThFnJuSGsNo1uWDcMxo8b0EIgVlLZWz3Z+DWimWG6JuC6ypibW6I/QRRrdFrtFAs4OCqFpgYmQvDA3HDkm5qGf2gX0CmZ/Ke8+/G9O0WIasd2nSAvGChfYsZsITnrMbDsRyPgSNfVHsaY7+5HP/mhwzhgx/e/Ta3Xj91UA3gJqB7kwVX/Y5pwgC2FMn2O+cjnJzKKYvB5a/m6BYBBoZiWzbZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 02:33:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:33:41 +0000
Date: Fri, 24 Jan 2025 18:33:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 17/19] cxl/test: Add Get Feature support to cxl_test
Message-ID: <67944d8285839_20fa2940@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-18-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-18-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: a006cc89-772b-4116-04c5-08dd3ce8ae39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8FXYcSBpeFSXQGf8v+aoDoZYQJ4wd3qLx692n8wlQAAOZhtuetTFwb96MHsO?=
 =?us-ascii?Q?dJYCBXSq6ZUkmIozJQj2lOfo4gLg33x/SDalhdjE3x8RgSIGAs+nTS+Sj9Mx?=
 =?us-ascii?Q?HIvzLJFX/xbKnbAlyufr+epMREuX6cKvuFO9h7kd+XmrYw7fLMjodcocFG4o?=
 =?us-ascii?Q?NaBbMZeWZzll5yU8OQSuZ4mzminSwSqcIweoYLNgfzPywFDj2NykFXVct2Em?=
 =?us-ascii?Q?9KBmFWdfYcP0VDOnaxSQC7vFXWD6yr/WKdKgePNRTFewpm86vMsZHsD0BNHf?=
 =?us-ascii?Q?JR/gUUjM4wTG4QsutevsKhidc+5rpKZr8b+TD3Hou6atS0esgstDK45ftCEz?=
 =?us-ascii?Q?xqmz+5nEurcHQLbxiqSEaYs4AIvfFnzB5ebup3Zqh+ewy6QQ1FdI7JnNgA8w?=
 =?us-ascii?Q?QJudZzd2biCM3dmSPwnEt7XK62kRWZXEzpXFBKyzoDz5EDMAyJJ7siWqkmoJ?=
 =?us-ascii?Q?OLv7l19gkCblc9efx6O0TwxUnvEla/mdZa99QErhq28MJEtIrzcpE6LAHnd/?=
 =?us-ascii?Q?pLrzz2RaPYsSVnrg1sBj56xNKvn1/UlrbhPXJL9a5T/MWBvpUyVuibauqPFk?=
 =?us-ascii?Q?jMKaYKV2tUgfjoAEsEJwDxbfPQer4u0D3t27tlBy1SIgc3OUxa9bv4pFwfL5?=
 =?us-ascii?Q?gYEErXLh2r81+h2DzLuP6g0wjSNvHCxwYrqZQQy33B7mW7THKS3za85c5vOJ?=
 =?us-ascii?Q?olK8e8cp3hu5HT9ZklLnr/yovEvVsz9ru+CtFhW+91QAQM3jJ1i3dcX246+o?=
 =?us-ascii?Q?61pLKTkqFhjG70MHYeg5y+Pk3Iddi4SWfesgslHJYWVVVfJvQpFPTYMZH+G+?=
 =?us-ascii?Q?jtUzKLHtWj09G18LBRHsNqa7fQYaxnDCeSaKXAmyW86Ix2fshapr/2mCWJ8b?=
 =?us-ascii?Q?LmrFgjq6RzhP5QkR//2hlg0Rl2F8Q1+tQZoXHbMq5A5wB8BlRgb0WeOh/4si?=
 =?us-ascii?Q?Gjnq+ZrCti2WjSXfQ+W3caawLP8MM8kWZx51A1aZ4Emmi9tUzILtYZHgVbmo?=
 =?us-ascii?Q?rgEuu+daMr8miLtJR1SoH1NPrJ05tPnWssL2UzErQaMlAZrDNYhSqLTw5vnJ?=
 =?us-ascii?Q?uBX8Ivq61XozHWFPt5c7Hr8WnvUEKf0Z8UyJX7C5re5i1sik2c7EZK1B3WAD?=
 =?us-ascii?Q?P5ftgX9zNSyiTsj4bei11SdsJPg3hlZiCHXsBHU+oMsiDtBsTRP/FNMY7/9Y?=
 =?us-ascii?Q?4PiCk5gLt3MBLOALbz+Lo/QL4glnxrYyRU7+D3H1u5omXD6Q89/KRAH4tUzp?=
 =?us-ascii?Q?K9c3oxgDhNTZbOIyYz8KNrHTqQvH6Gh14P5yzyF5cwCmansYY1F8+lwtjhKI?=
 =?us-ascii?Q?ma6YZyffrexpR/muYxgnUgvltrDIZYz1rwt29DkO74Eog1f0e3f0HkKytxWL?=
 =?us-ascii?Q?7EbNgII=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFgJnn6hTNLseaODzPFTLRGyOeiZCg6HMswXP7pX+g+qVnffmwa8cVaKVv/E?=
 =?us-ascii?Q?qInuOTM4GWpwmLVzF/4HuarrKVkheIlqwKCm0WF/Qalzkt+Vll3R4Qgij+Dk?=
 =?us-ascii?Q?XNPv7e0ubLzFUvUc113U3zTiiKyb19Z4S5GTdRthF7ajVDmhE3NJqVrX4KUk?=
 =?us-ascii?Q?V3QUikSt4saCChqP1+jDmQjXlacWBGGM12ZAtkGzO8sN2HTdsJQGAeBnKnMU?=
 =?us-ascii?Q?uwdE3L0DXJuJqfG2haH6OzALU0V2HoG+S1g33S0hBY7VCDPQctfTgB82tomk?=
 =?us-ascii?Q?16VTD2BJyZWgzBaI4hBxWSI4/GmQ8/fBXpH8XJbWR+m7agooJBYwBpEar7Gy?=
 =?us-ascii?Q?l3KjiK4MloY7TV5Wtyy4vyydWjt3z5Zn7S+O5bNzkV1mqXcE68GqU3t5HEGC?=
 =?us-ascii?Q?kdh+3HngZ/WLkE/6V6fr8XoU31vKTPg7KOrjmJkRcSETXru1EhP66X3xm2W8?=
 =?us-ascii?Q?wsh9gIK2LoMBqabCv9SdIsLzsGfTzNREopO9dEDZ4Cfj66zARajUBF/bTIJv?=
 =?us-ascii?Q?OU8FWDSgYEzC0USynTMtDeazyI8vz+vrr+pa1njmKxG5+T87wtccYkmHrvG9?=
 =?us-ascii?Q?d4gCGRWGlr+BJSBSI0dVCZglkiSz4mmFYb6Ik84BBYtUpdko9EA8WJAsh7bz?=
 =?us-ascii?Q?i7vE7NaHqwkWgr8S6mMvnN6Z5TI/PsHpf2AFOYiqi4r7KNTultH6Df23vidK?=
 =?us-ascii?Q?Keb5YswqKDQ5AAUqbte2P0DPzhub4Pm/1vow6BaCOywJXdwOz1cM7X+QRWGV?=
 =?us-ascii?Q?j13WuxCxTpzaK6eBfvE3GvO3dBv/OD137MeJF+olvO8d5U3tQi8IJrC3LWn9?=
 =?us-ascii?Q?s+8uTbbRIiseYca57PRlS3aRPvKHfw/IOtFdWJ56KSM1vAFjTQbTaulTmfSf?=
 =?us-ascii?Q?W/g5YQvQZov+D816AEn7Lvpo+mKPhmUiKrJUwNWzl9SIP1ER5hHXKTv2pzyR?=
 =?us-ascii?Q?Kxusd5APYuop4YzTAMvnJmNqSS4FQdS+3K25zsoRZ82ogU3//Z+40BWcgFbg?=
 =?us-ascii?Q?xHj4HBrgnzliQWII5vgldAiJ/9iqDQdrk4O57eqaO1RJZIpfVO8QLhFIkBGr?=
 =?us-ascii?Q?A3eZTvgjGYkvsMDx5FNPZxsbZT48zWx1SdXLXaYT0VAp+U/6BE5g+otitydy?=
 =?us-ascii?Q?XFczRssjaLOYNzqT6vyTk/0YRen1HAXxTa5qBN094bbUotuEYH7U3NPcAqrT?=
 =?us-ascii?Q?oPl2hJDoaA3u7GByv4XC54+/9Os7hfTMWGt4XMvGlf0j9MA+6IEB9eGEK/C+?=
 =?us-ascii?Q?iLxy1sp12JnyR7bi9wUlkyh6T56JJWvFrRxqljFZoJm8R7pOz3Z5kC4vY8fr?=
 =?us-ascii?Q?MRIx5BnvCGf91VnLvjKPop6y13BatiFJe0tbKfVnlcF3Q8gQ4Oar/6VulReD?=
 =?us-ascii?Q?Zw+1UCEAXxmuaxGME8UP0AOP/1GNVkKrkU2fq3tu+zWUSFouoXfKkCq1ab5h?=
 =?us-ascii?Q?cG9PhN8yCy2T6BWTKJG+eG3edYw7Low9g+Il4CHqgg9yE7kU0ZrJiP+2pUel?=
 =?us-ascii?Q?XJVs//M8Hq1wsCDgEAS2cVdv4trxZHqEnawJNi/4vBKDd0RY+8VSIbsCS2NN?=
 =?us-ascii?Q?rzRhWr2dw0IzcEOy0TTYtFQNnl0khNNALOr48992ngXbueZchsBMCmG9STbN?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a006cc89-772b-4116-04c5-08dd3ce8ae39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:33:41.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khKZdRLCWUCPVHHhG5HBhmUAOQcbpdhiuP7pNuR/BMmgM2mh2EaqodHXggIRQKVPMC+o3GXGmC6sDFDLQsbS3gts9+rkrd5UArBR6+tdblk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add emulation of Get Feature command to cxl_test. The feature for
> device patrol scrub is returned by the emulation code. This is
> the only feature currently supported by cxl_test. It returns
> the information for the device patrol scrub feature.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good for what it is. I wouldn't mind it being a bit more cheeky
and testing the "Get Feature has a data change effect" and "Get Feature
reports a reserved effect" corner cases. Those negative tests can be
added later.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
