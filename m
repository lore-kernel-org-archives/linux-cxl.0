Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9531C5D77;
	Mon, 31 Mar 2025 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743459493; cv=fail; b=D75ysX25wWD93aLMqA9fkxkB2JkwrM4S2p7UKWfJfLc0DjyPFjOxZPnN23kccgQm4Vq8sd3Tq02RdDCuDZ7UU1aIGmYwNYqyCOiYm4COUyYi6KqZW2vsFXNvQ+U6F9doAP+wF6VKinH9PQ6i5ujPAIIlFzI1Hb9cPqJZPT5T9Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743459493; c=relaxed/simple;
	bh=ymyzGw6ZiHX6lR6Rwk6+RAEdhRAhnq3UWRjn4bsx9/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SVIA9rruxPDHazRqHICr4NrbxgexB5F6HByrmqKsNBU84OZJrRUg2rjMj8JislMMUtdSNDibbqBzQaTYC4RK01+0qx5xdPHJ4CwzBDGuAmgjGVF84m1tzSIYwydCKEaDpaI+PbhxwMJHBejU4uGl88KUEiHtdmK6igp8KxnaKBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIEsXEwL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIEsXEwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743459491; x=1774995491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ymyzGw6ZiHX6lR6Rwk6+RAEdhRAhnq3UWRjn4bsx9/8=;
  b=NIEsXEwL1tVgh9b958NmaSMJLrsT0ipmtJGpl5po0Vgugitq4dOs3bUX
   8jIxtAATcccXdjhrQEmryhJIkGypX1z2s0cgD6uSPgLPDZTpLhDnoRw9f
   GdsNXXmIm6TY7T3MFUMyddK8uoxJdSkJN6I6YlbtRvbxbIl/sJsUYpfvf
   q4HFMXhpPst9fWtdmWwipH+VyI+ycADCwtNXmZrMNsh6N3If8RfLZHWeJ
   7ieKQ0C49QO/vrivV9nC/6XYJbOKXeah9jzfjbbRcqh6KxKtfEAAcm1Ty
   d/v2iORT9abo6ipw8PqgG/Rf71PTFXqD67QYSq1BBvDqjhuQXJaeEUVww
   w==;
X-CSE-ConnectionGUID: y2Fpy4iuQmOJFZqrFwSSVA==
X-CSE-MsgGUID: lawlIKnfQjyQAEniuEQumQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="67239935"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="67239935"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 15:18:10 -0700
X-CSE-ConnectionGUID: 5KBG4xuUQlCDfOkWrfGk5w==
X-CSE-MsgGUID: +oBcZzWcTaKn5W5z4NAvhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="126678061"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 15:18:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 15:18:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 15:18:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 15:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7Wyf/K41yvRqZJctfX2ITaYKS/sdQ8nYgv0f49tip5Nu/KTwwj0SHPa7L35eFGcmV32W4BIa0VHI9hon/jzt40osUKYOAoO/+NSZtl1btp2NbkygpvCbxP7Mo9c40UL/Tkg23bXDldLoe7I7rtcvb4MpABXQO9i0CYchKB7tKbp7FzWCQDXg0L2R7+KeHF6rXlCYApXy4k3Nv3abv+OU3FmGlDKn+jRthA29gjQxtv7D3lP7/KCDAicD9yMpl6jut6XGWaXRll9DvyyqG7Bh0YrZpFfLnkegQDnEeXlzN9yjXMx8IomZK7l0+14ffz3QKZNuhJERqbS31Qo466dwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thH5EAby3ZN6FmIXf/Qnh+pkDQgu3pQfu1x5xqpIhPU=;
 b=of9F5G4x0ehyiyNce6th4g3A2YEdkveeOEojkRNesR5k3TEBWBA/SHpYSxUYLsSf8OW383y9KeNpkwBsqZbU6jZ6AcXTC3JPDnwg8NKCxgq+9VgFhCbxQxpJteKbNhZ0iajQS3p7H2RNGZ+s6NteqmAXqOd+jzaDMrRMWnGpJeHCL3GnJ4Y1QJWK8n6LjUl+7oguUbd+8QRUWfcYTvjPv6jopluGhxi6mU778ffmidVNIgSJyqSJHh/S3XA7bZWGu2hK3AObZwrTG0dP7b6Ydzgim4ZTtTXEZd9WdDTOnmECOTU/KfMgf6bWLuhfkyheRRK+h7HoT2gME3OdmbNEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 22:17:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 22:17:53 +0000
Date: Mon, 31 Mar 2025 15:17:50 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>, <sj@kernel.org>,
	<kernel-team@meta.com>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <minchan@kernel.org>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 1/2] zsmalloc: let callers select NUMA node to store
 the compressed objects
Message-ID: <67eb148e1f818_7baf294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250329110230.2459730-1-nphamcs@gmail.com>
 <20250329110230.2459730-2-nphamcs@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250329110230.2459730-2-nphamcs@gmail.com>
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: aacf7426-affa-40b4-89d3-08dd70a1e181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tnt9QtyAQr5SMAmJRbyXSgU42Pc9oW68vW0eMAm7QDtqym5QKlyPUyXDQhwq?=
 =?us-ascii?Q?vj3AmH9RyJWd6ASuMgnBuaTRS3c7RKKbiaDfsiUsl6Az25Lg5t2lscUzy5KL?=
 =?us-ascii?Q?7+6QsQd6ttmKgvQYG2hP23uimFEo6vaoLBgeQ45ljTPfCC3cTSEuZUIbBgkY?=
 =?us-ascii?Q?DvkRkOSlWMwgemjPvaDwP5CjhUzf8je1dkCtgQ9BApi0L11OLCmUlkqxf8/4?=
 =?us-ascii?Q?cAWZ0D/qonurdM8eW6gf8CPOE4YYgnE2xcZNW7FeEvutMQ22G+QbzSXx8aTT?=
 =?us-ascii?Q?AUAEuoA8wQhHeuuk7dqIIpTEX1xreHe0x5mVC7gCHvacXimgZCEqmmi58oYK?=
 =?us-ascii?Q?2I6QXenvUciNr/rb5bLyhMZwafJyeOvpl4WIoTpvILixV2FiXEMGBmSaDVhQ?=
 =?us-ascii?Q?w86G3ws9rxfXscLMNSfUb17dVZkFBp20tf9ZYb0THJpPp1gLHp0IMlMUmqxb?=
 =?us-ascii?Q?8Iz9jPQJNl2SDxuiq5khkf/ffSaK5LA1W3xAqv8sYpjMgC0kPzPtlL5cgkPi?=
 =?us-ascii?Q?KWfwP/vSP/V4IqRSaQ813oOWIaJJgQI2KoStRGZwgUQ69LdluluqKdumzzg6?=
 =?us-ascii?Q?wvn7Cw7X26tjMwDShtKDmpz0UIGiwNqpWdCphFoN/g1Ol/O7nihF0rcHQV8p?=
 =?us-ascii?Q?SBRp3JO+GkrCJJgkNpe00YzF//j/9RhWp9KmezseXaE442At5SZRZHtbfw+B?=
 =?us-ascii?Q?HCJONQstRvRMMmJmYZQJMjyR3FMSlwe5/Y/sBSmx2b69uNmU7mfA5dD06RrU?=
 =?us-ascii?Q?0qUBt1qAr/LuQu025HPnZzuvWJTp7NbImSKkBcNIwzk/KYtS09h9Ai1nGqxT?=
 =?us-ascii?Q?dxe6B+/zCAILRuKyan9V3R5fhAnFvLmvrPqEQyQ8OD7QZQ2dgXRBkbrxiIvy?=
 =?us-ascii?Q?MoFYUVh87io2XWWyprWf+SjVIspt3aGEYDZiAAeJ43Wxv9ZS1PpN0gxGnGXH?=
 =?us-ascii?Q?2qoeJABi7NNm48wbCBGFR8CSlMKV9zvlscZQXKstIiCqN+AnsjlrkGNabT70?=
 =?us-ascii?Q?3lTu6Y7uE91U8gi8lHEG8ovM9Ca57hHKr+jbJA1rnAxYQPs8batECiCmREZM?=
 =?us-ascii?Q?Drrx/mzNy2bXHC7CAwljgcFekKV3I9N/8Z+mW9faeeR9kNpNO2YjNlNkfCxC?=
 =?us-ascii?Q?xY22CdX1HY5hZr0wjjHRnF8DHG/a21I7XsMllP7BoIs+0NK9i0jSid83bqPB?=
 =?us-ascii?Q?tOoeM2llUhkBtTTEhYlxiqWMm92mHEVJHphYc46OuUFpb0bZWKSJdiGDsACN?=
 =?us-ascii?Q?Zd3595dRhhQqRqR3CMe4jYm/lkqIbFTrLEQc+Fk5w0Zy/McZIVbkdJVPNsLS?=
 =?us-ascii?Q?B4PLoDEHpWYO943hHbiAxvgD2142Diz1kRlRGthX1eFW45FOSjKrSsGaMYia?=
 =?us-ascii?Q?WNWjqDZKLAkUd6f0tc7zfj7OohyL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hitdlmX+DmVq5e/bcsdXPT6m6VjJ4XxBR5ufOc6VG1VmVMg3TchI5GRbVUBg?=
 =?us-ascii?Q?matCpnJIko4dRZmM9+q88UZ/ze0AHeZKT5Jik5zzAxvWVmxXw+qDKBw2RM9g?=
 =?us-ascii?Q?HlE1qwP47UaqitmgYVTp0yvhu5jSJfyGpGcOobLwud+JllnBdbw1IK9OgG9P?=
 =?us-ascii?Q?w/Dg97uMFmSNN2Pln9LEZmM+QPDtIx1cLjl6gunFU/6oExM+r7t7ABe48TIJ?=
 =?us-ascii?Q?FlAU9eODqW2Iys/eIVLVEyIxIXG//pv0rY7funVEKPVp4QlZ/N4a93WxcypA?=
 =?us-ascii?Q?jKqtKESjhHhx9xq3om/uaRZchZzlNeRvx8lkZVSL8rrk/16WGjQbKU8SAOP7?=
 =?us-ascii?Q?912W5LDjnHsfh3KXJKhhJtSqwCOvMs30GtgAGx+6wa/ChztQbZExgaiZTF+m?=
 =?us-ascii?Q?mCZ5/wCemMRtvo3K7XSePbx/vdJcv8zaDT8BrF+hhqamD/a7/HA8kRIHahwT?=
 =?us-ascii?Q?gJIXNFYEuMPppKv4iY5D+O/8s6PaQ4IVoxYk1Fv6HHdK2Lg8RtdMo8npoepX?=
 =?us-ascii?Q?4hR8Y0hQBryLOBzxyvptnSyWZ3lkk57twXmKv0pt0DMkgbvRzvWROlg4FLNM?=
 =?us-ascii?Q?60OPkxS8ryCFcJTLa98l9JL772Gyd9iE6jQForEzRedlSkL1zjvjl74iRP2Y?=
 =?us-ascii?Q?JC78HYU6NehgK1eIB5eA9xjZCz2nfmH4AN90+nV2WoRCjRlu7u2LNdjkwWTI?=
 =?us-ascii?Q?RkxCA20rnTXkqB+R+52hwoAJPHAViFu1xGBxdTAPgHpVWtAKu4an+tWUlXeJ?=
 =?us-ascii?Q?m4oElL973T3PR8mxXbkQjdxf7rRSyWl83ezHxbWifKfwwlnYA1khJn6NG9yE?=
 =?us-ascii?Q?PbJGtJynyatAErwE4viJ9q69kMhiOPIzjQMOVko8Mg19Zei/s1JDWCcT+QQr?=
 =?us-ascii?Q?aeR22onZEWM4Jv6b3Wgk+qNFFQ5m5QLYvUdYewS1QMTM1l8UA+tTR2Q6o/JL?=
 =?us-ascii?Q?HWCzyonp/Yu+TAHRU3/5iG6BsxcCdCwGX+JnfFKf0J4VN4IXCYx8U904/kyH?=
 =?us-ascii?Q?kM6IcAGww0ci/CqhSoOxrS4hQPYOZbmR7PIikVDYBFelcXGyDIdLB9ZCoRrf?=
 =?us-ascii?Q?qd1wJvTCgZKL0MU5AV94Zs+2GYu2UchS6jcwcqObySi7+vyub6kE8KJWrhdY?=
 =?us-ascii?Q?iuZMw9RQK6K46NVZsXmlzPa2Kx/M0PhcYw/zwAwAXorYSCcwNlsFIULWx9vD?=
 =?us-ascii?Q?V/SsWuQP38anU7rJIeFwnl9EDJlmNNr01tCabbvRsdxt9sL7W60H5rhYCP6R?=
 =?us-ascii?Q?kXKfYRlsOm0dAQg6LCrAPFqXCUJIjatDVfIzw+pmBZFpF06wlp50L4tVbKOk?=
 =?us-ascii?Q?2zgjvwuHDk72iHP5OdZM5HZNWVHdGbcjyL/Vjb0RKTNHKlzoumnv4Lt3fgaK?=
 =?us-ascii?Q?rkLHZnHYaQqs9hQ4Y/3xIVU/79zIH3hPB0DKkHo/aMRRPEnH9en5wngrRY3g?=
 =?us-ascii?Q?0mb88rtKZJXfV+xPzGl7M0qAH0ry3Nopfgl5hBAdBFJUMaK3LAy2s3DwqAI8?=
 =?us-ascii?Q?F8enP+rBaofR4mUCRkni8gHS1y6z/1f/kdkUzV5flLAOvLVQE/w/+RgERRmX?=
 =?us-ascii?Q?XPCIlXgdDnWiiD0cvUIWgFh9KSkBTNYk8NMXHPg1mFlRny9ZRvk5c6kAW9kg?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf7426-affa-40b4-89d3-08dd70a1e181
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 22:17:53.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQIzJQeUS4TFgUmU7bP+t2KRhUafxu72h68a/3RHSuR9PmR4jxt9UAJAiBEm9w8xYzKU+kQ3dn3fiKaEeqNe8DKezQgX/PFsI+vfUGwch50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com

Nhat Pham wrote:
> Curerntly, zsmalloc does not specify any memory policy when it allocates
> memory for the compressed objects.
> 
> Let users select the NUMA node for the memory allocation, through the
> zpool-based API. Direct callers (i.e zram) should not observe any
> behavioral change.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/zpool.h |  4 ++--
>  mm/zpool.c            |  8 +++++---
>  mm/zsmalloc.c         | 28 +++++++++++++++++++++-------
>  mm/zswap.c            |  2 +-
>  4 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index 52f30e526607..0df8722e13d7 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -22,7 +22,7 @@ const char *zpool_get_type(struct zpool *pool);
>  void zpool_destroy_pool(struct zpool *pool);
>  
>  int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
> -			unsigned long *handle);
> +			unsigned long *handle, int *nid);

I agree with Johannes about the policy knob, so I'll just comment on the
implementation.

Why not just pass a "const int" for @nid, and use "NUMA_NO_NODE" for the
"default" case. alloc_pages_node_noprof() is already prepared for a
NUMA_NO_NODE argument.
