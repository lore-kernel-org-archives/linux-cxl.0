Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BF23504D;
	Tue,  1 Jul 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383145; cv=fail; b=j6Boz+iO+LtnrwYJXBMhPnB2KljihPkPIEzLghRXxxR5B8LCGrNvohqrH5IAIDKRB0bIt3qLQiXJ7gwzXu/ZBpLbwZpBMuVAEKEWojfkfdelIQIBFaPcGw44gxF6vBNhDJtZBIaPtR3xwkNUtzalp8NQ+OELk7tPxhbuLTMNMgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383145; c=relaxed/simple;
	bh=QZu7ahqjCjTd2LIgc9H2gdi9d3GCy376I8AF8CUET1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j8d1b4uZ+xbencDDeDEubed1XSisFOpXm0VPZMyvI0DQWqRkM+OrRhEvpvjT2/Bap/VnKJVzHWCKMHatd81B6EyVt2haPWLqLb4+PqLDadewcAOE+MELsIYSbg/nB3FZy/RlwfiB5tqgqq4vsw0txnBlOKgaMV4xP9j/M1aXNGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+NH8ntK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+NH8ntK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751383144; x=1782919144;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QZu7ahqjCjTd2LIgc9H2gdi9d3GCy376I8AF8CUET1c=;
  b=T+NH8ntKaJr/Q4ZK+LW+EN4EeMSCr2vcLvqdu3f54GZqKffKs5IeEtt5
   eYwZbki5L/YQFvCrKPgihbjG2W55DexvnVViVt/z2NaCs8KWIZ3cVW1XE
   SZmW1vs/82T0PyirChJJjmdZccTeGLXIsTDrhrA89t7PzlUpGmje7ZpTV
   4A6E4/rs8bHn0OYkbbROaEW0eb6/pnYZ40PfB9/uCoPtU58Fd/fznYYuF
   1Ll27ddTnIik1y9Tj5d09IU4tQb0prdBTqFZIFtNz058bfH5J7ol1TpGC
   M3hlCmNX8/BV1D46HtPjdfbhqE6oXR08GctEQIxuDvhOmxF5d0Iq6R8Zg
   w==;
X-CSE-ConnectionGUID: 8SfsfKJLSUytH0t0feDrQA==
X-CSE-MsgGUID: uDqBiSwVRuyXUZoNaE1nNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53590023"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53590023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:19:03 -0700
X-CSE-ConnectionGUID: pU+4x1xSTN66LyvOtVxgag==
X-CSE-MsgGUID: xzOxF6pCQH6a3y+2t+5I5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153211865"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:19:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 08:19:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 08:19:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 08:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHFMBadE2VErsksNEwKu2lTNBnsqghQDe9Cf1c2U9Ice8LSma/D04H7fOs2KSIp79u9wtdbhiah0HnL7Qd/tWjypeFMzzTWBiLQLYriSzvPZskKXD2RpS0/q9md2NzEDVzCN3xOU3klCGCUnRROntDbi1Yc7ff/ypie36KyHck53VEYtfOizhzdQN+S/4bokui45LVtfynSJiJpl4I6XtO4n4K8B3hbi19PNeAZfYRi17mHb9HuDKDFx1Dt6dUNxelYCtqnLl7tNAck8TQq/iVNUyqgjVrl3lv0SBxCioArNETiDJds66r6N/WIzUv+/n9iEmXkVbGhb06Y9NOvcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQKCBrLLJldMDDKjfXWLhAimNeoXEQyM+MXxtQCcVV0=;
 b=QLP1F6S+gFILbSv07hcgV5R1MGRSinIWh9Ph9Riwpm8gOSfDF45KZh693Vxuqde8+raPqyCydVit7mBFwb/mwsMdqROa3/3z8gi03fba4C7S9xFTk4B4sQkFCoFwbIjo+uKvNh9C/OW1TQ7JvVJosL2sD9AII+UTXzwHZojXVlDTHoq/tP1bjrPDG+iX+YSMBYUhVpmyXtH1VoZA+dh0Lj+QKIFAkn5FxpOabp41bZFFiziT3dcMfic0fnqaQl5ySdTXOTWLbqpc0zW4ek6KceYhF0SeS+zFs8LwQk0KMVf8NSaSTfxTlgePNqWm0Vg485F3FfEqGYagyZmqRNvuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB4938.namprd11.prod.outlook.com
 (2603:10b6:806:fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 1 Jul
 2025 15:18:55 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Tue, 1 Jul 2025
 15:18:55 +0000
Date: Tue, 1 Jul 2025 10:20:22 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Nathan Chancellor <nathan@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
Message-ID: <6863fcb649c0d_2ff1fe29428@iweiny-mobl.notmuch>
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c91ad8-4b7c-487b-78a6-08ddb8b2985a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UklVajfuckB3GJqi5DWdRIQB96WDIXX2HZHFLlgryTidUycd18cB0kyOM09O?=
 =?us-ascii?Q?wGh1P/GGsGleQtnwQwt/tc1PFFGYvxXvBLfupsUiU29yNaJw14MkAvc+OUf1?=
 =?us-ascii?Q?9mgCPSsH1ztXhgI9o/76YnGIbj0I3aqOnTqbHWvDyw8C/q77p38QMfslOSPR?=
 =?us-ascii?Q?HlS9lakeEn5WdMllriQZZ2lq1DQ4wMfg1Ja9ML4WiozyT1nMfw+2f3fvrSMF?=
 =?us-ascii?Q?RdgjJA4mXxt4xLbpa4t3hoqpsqH406kKymA//T1tsOp+Xb3LgAJnoNvto8hU?=
 =?us-ascii?Q?oad8KUg46NTk9AL9N/0BPoLMZBSY/fGalagcJmIW8IUzGFfeBbusM8/ALP5h?=
 =?us-ascii?Q?YEDLkB+tpokDlG7lJ/TyCUkk5t0BDB5mfhXRdTspR9HEAG8KUYF7rMgilPPb?=
 =?us-ascii?Q?SMVl1acpgVErEOxGnXEIMc1J3wvIzFdGKbq+ZW8/Xhk+l6B3Q1NTTcLVRx1W?=
 =?us-ascii?Q?44yvlb0un4Nt4k0M37Yxjx63YbBzA3wSLPPgYKaHjjzJ9qO6R04QVovFyuXv?=
 =?us-ascii?Q?X+/lA8b7xWF+FB9xGmqW0hpWPoM+0Y3+8k3GMc/CAzrOwcj2N6PgvEdyQIzo?=
 =?us-ascii?Q?HyicqKI7c1s57D9rDdBm8aoNeOPZC8+gBwR8HGzR123NtkmO0FyXNMKJdzIN?=
 =?us-ascii?Q?610ORARX+FmNW1/bFxA16EDDecoQQKEGIHWRoBUUdSR9Rxjo1CDAS5gtUAIU?=
 =?us-ascii?Q?yAkFckS1Ey4iiKz1e4mm5t3JVb+I4bpIgbtCKJI+38sDKqVy/s+gxafKrQNN?=
 =?us-ascii?Q?+t0T01/YkLdj9xkY/I6h+/EOlCPNksd0yzycYqxPGg4VXPHFc0v5s+rVrL+A?=
 =?us-ascii?Q?gG0X5XRzwlzI43HwNAtDQLVmiviK7mXLc1EPVjzCB0BlHYC/l6q7woiNC7tQ?=
 =?us-ascii?Q?7iLUwevAjPg8EXHkRHXaU0RLLBEqfBAVqWLWGW3phlP2INjKDp/lSXW5zlka?=
 =?us-ascii?Q?AFehcxLrZ4Q2n08j9zqo51/gesF9PzO/izuNLsHqHqEUErMfXnOyu9rncnHS?=
 =?us-ascii?Q?/ze5qZS6iTPhv0IDOBh9kNYTi2pxL3xIQh9kGFhouS3IuX2Qt5vHu0bHdwNP?=
 =?us-ascii?Q?ceMO+QSHieNMKucY4YbN+CBhLe5h9U+y7wIULHu1zvjQ38ENpdyO43ALwca+?=
 =?us-ascii?Q?i/ZanyxVr5Hphk/K6rkTd+/3Lc3E1wkqNuC7pMw2bLOQdD2E+sVcHFJ7lKep?=
 =?us-ascii?Q?4i2paWcytgLz8dJ8/lkbRaQSOpLpomVypi/sn28BMTIQs+Smcc3bDhCyfgnv?=
 =?us-ascii?Q?QE++MSW8cc7ouEw+DX3xdp3qkhQNOUY2c0/zwx/0wY20hg9XkhZz2/GIHgf8?=
 =?us-ascii?Q?5+jugv28vIIYxq44eQfIerSrQN4EnwB9uXd8Oxi1ksLYPb+R7RaS1WaD7upV?=
 =?us-ascii?Q?piMarBedHVbEHqOfTZBmj3NgYmttKkMMsNiCz+P0bzo43JBFOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hAcG9uhP6ZHsInvdAUF33OQU9uyoc0Qx3ZI3kTmaToBHIiXry6CTfusZJWCu?=
 =?us-ascii?Q?KZToWNr8KC+yUr65XnGJ82RdJVEdP1CIzF9LcCCWXM6gEdb9P/T6nPxhAW6R?=
 =?us-ascii?Q?2siEzI8Ij76TuzmQGFzr685NO4dynISKqY0dPA/yrp6wntcog7BMbwXA3Oo9?=
 =?us-ascii?Q?9VMVndlHMmS9emvx6+VaEyUFkK5+lrT7fsSmjdtqqLLQv2KjQKESziaxB2Tr?=
 =?us-ascii?Q?sMi9I7grLkmrrREA7Q0F314rSIoE10vr1E6k5dpqQSblm+f3/vIX62iuigVL?=
 =?us-ascii?Q?tp8Ut/T65F6a0e5MwoUDB0rjg/21oH2nCsu15vDB1xXjYXTlIDKpOOEDAhfH?=
 =?us-ascii?Q?6cys9DdyjJ96YRl9w0O6hJdLbtlB/ZftmDQnVVPfY8yB9zawYv7oAZhsUxhF?=
 =?us-ascii?Q?dL/9MSI8/S/VO0CFPSF8Siu+XNBq/vHRWMYRAtYHSfzfN0b2eYFiujemVxWu?=
 =?us-ascii?Q?dqDmWsJwz96iowJ4XHO4c6cDqmlS0BXkM9zTxMLqE3+GALoY7t8Rpos+RVx2?=
 =?us-ascii?Q?f+9pESnRg5chUHmcx6v9LL9BLrEh6q/NJJ6f8PVoy6RhAHTO7VbxQU4RqzCd?=
 =?us-ascii?Q?/Y2t4Q09MdlYM9X4/ELcJcdVE2UeFDI1GexWxYJ3GVu1sk45sfWrC2JFV0gg?=
 =?us-ascii?Q?IF4rqKAJNYoGydpizRace2MOLHQolsxLIwWvO2PeoLIDzjJuBKivRSr9AG3Q?=
 =?us-ascii?Q?v9+HWkgyceOfFmpOl6B/NlffRSILnBZZrT1s5Dmh8LQ38BeB1N7smrwb34Jw?=
 =?us-ascii?Q?8NBzwSHZOJZWGG685PT8hlgNP95RE8I5VWTYshv2LLX22F9Tf93G3slvLA6m?=
 =?us-ascii?Q?kGWxoi3Gls1vXbpwOS9yn66bBGU4U/JlA1KdsuMH6V4W4GciHqXcDqLSVLTO?=
 =?us-ascii?Q?LrYy1Ay5DY9WyS1EY2V7XO68o6Wr5fvRoOgBXW40bkcA16PeAb9qieei3Qs6?=
 =?us-ascii?Q?iImiajPqbBWi4ETU9547u0n03xYtIIu/54rRDP3DWXnDiBytUGLJpTFC3N19?=
 =?us-ascii?Q?jVrdTC28ex7nXX2JhTfjymNFlpE+/4mTOq+bWpYEdvOeY+YzPJW05KtJOyB1?=
 =?us-ascii?Q?EnWk9AN98zV2oZJr032BXPdqb4WMvg3wx/JrQLFgGysGPUiYkixdUh+c1cIP?=
 =?us-ascii?Q?8mQDrbLqycp/INmfaGyI0KxLExmdQ2UNHoMZL7lL3FWsiu0M1HRXq0GGs+WO?=
 =?us-ascii?Q?xvnqW934wsxTsNiCfHDkXNuXWKZ63Xh+wMXkWyQCcy2vcmkTIU7wIOtdCJs6?=
 =?us-ascii?Q?X2MPPMT6KZSmRvgUaQBMgyu1bA9dVg4loHYoCBCQF0aXBLKiFGjQ1WGVU7dg?=
 =?us-ascii?Q?GbUqVUGsMGlWl+u4xtgX5zo+Na7pjQsqYbKUk+Bb71TJOj7AtN3SvqWZYrBQ?=
 =?us-ascii?Q?bfbGA0WWDWAyPGQSSJgl/4Yc6uDT9/q0Z9TGSZKytLDK//DDAJW/K+aiW84D?=
 =?us-ascii?Q?N6aXHW7I6Az1OMNUYgnaETSdpUxhHvhhsa9joF5s8K9wLTUW4WLLNWkA+lIQ?=
 =?us-ascii?Q?imDcPLrcb5kkTTwYIPwQ45J09/bZ3Tm/RTu6zj1vH/XLyGKrBup3Je89iuTF?=
 =?us-ascii?Q?hC+G+K+XSnwYpYPmIeJnioowzPlvu4lO3+KPaiJu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c91ad8-4b7c-487b-78a6-08ddb8b2985a
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:18:55.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVQYNHK16/dVo1LCHWoaNUWMp4B7z5YqQtvscMc+RAAPrIi3mE6MvI1Spt5NdHWpOtwzoV3DjPTwfaiupJfL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
X-OriginatorOrg: intel.com

Nathan Chancellor wrote:
> After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> range.h may not be implicitly included, resulting in a build error:

Dave J., I'll pick this up since the nvdimm change was pushed through
libnvdimm.

That said, I'm not seeing this issue.  What config caught this?

Ira

> 
>   In file included from drivers/cxl/core/features.c:8:
>   drivers/cxl/cxl.h:365:22: error: field 'hpa_range' has incomplete type
>     365 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:562:22: error: field 'hpa_range' has incomplete type
>     562 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:570:22: error: field 'hpa_range' has incomplete type
>     570 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:803:22: error: array type has incomplete element type 'struct range'
>     803 |         struct range dvsec_range[2];
>         |                      ^~~~~~~~~~~
> 
> Include range.h in cxl.h explicitly to clear up the errors.
> 
> Fixes: aefeb286b960 ("libnvdimm: Don't use "proxy" headers")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/cxl/cxl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..b941ff94fe0a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <linux/range.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> 
> ---
> base-commit: aefeb286b960a0629273d1dc809ea36754f42d98
> change-id: 20250701-cxl-fix-struct-range-error-8475cbbf3358
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 
> 


