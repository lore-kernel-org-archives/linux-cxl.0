Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69AA221FA4
	for <linux-cxl@vger.kernel.org>; Sat, 15 Nov 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175606; cv=fail; b=iacvpQCoIMzNVhkpKbHD21siQQ0pbGyYkPWLiCK46Rk5b1MPRSRsQ1/Usjkgg6CUlp9kZUZfryOZu83KrtL9k/f0sDtaPaBFEcYd5TP7stPG5MYqHxC3gttZCRsLbtlVn10bqnTCh0hTUUeulSkqM4wIb9/jXF+ixRdf90IsbfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175606; c=relaxed/simple;
	bh=r2bG0CuMzxy6vJ3iy7KcSu6YYYDVHisJrFHfVXuiecs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ri5eiMXk3EuIHqXYZSmhbw78N3L7bh5JLhvNacblq3ZUcejw1CAZudjX5qZUsBhatcMO/Dkitfv2T5aFCQSOFKEgCRtLR8915RLbIu/3o7WM5XsVf1go23pbY+6CfzMueyG7HNNnYM4O1D7wd4UvPp53lWnIARxaiFlbci2S1aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgRJ+Zm3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgRJ+Zm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763175605; x=1794711605;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r2bG0CuMzxy6vJ3iy7KcSu6YYYDVHisJrFHfVXuiecs=;
  b=EgRJ+Zm3zJvzcxO2nlIU11O8bBx0W58T2MFbd77mk3EdI059uo+efkYH
   ZreqqdJkj3qyv12uyyTmHwUZxrGQAeye2EG2kMcFk5wzn+IZMPHPkFaEM
   0b97lIn8h5utHOrhWRllamRaGg/8xpEA4lLwl1yTM9VYvyPWx7yAqSWx4
   Tpear5B3rALl23URg36hbWvZ8noHrYht/XXXQVEQw+gw/ijJ2CzsGo1LB
   9oka8b1uSO9xyR2LhQd04iY+ycxfRA6s4doWiZIx2kXiAg0iiob9t/FPI
   dUQBUq5oAMTOIEDJeEkwVutepk8huYDUL+hn73bFBN/tWX812HYgVd6os
   A==;
X-CSE-ConnectionGUID: pOmzqbwkRNmRW2xEsjtpIg==
X-CSE-MsgGUID: tR7DMsEhQXu5jUa9NZQcYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76735159"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="76735159"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 19:00:02 -0800
X-CSE-ConnectionGUID: TuhM4b4xTfGd82GIO0357g==
X-CSE-MsgGUID: SJEc+HRPQ56yZeE+e14QPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="189222124"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 19:00:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 19:00:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 19:00:00 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 19:00:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjWtVfMf+JpcPRxJl1Ty0Q+Y4tTw9W0OnGMpfByEKigCMl9CX8rhy1mfVymYiNBuj/KNpC1B+tbaZa9Vq4xeK5EvGubqWcrmrnAimHE6jue0xdllmmSxGsUla79oBC7AfB4Y0OsEiPNQwXC15zKzGy9JfKuH0o/yH99bEbzdk8XlhMwFdCw/ZKyd5vNyM+lVboTQeAyRDgdtslCG7qUUkYNKeh290cF8+YA2RtU9StYnVm/XaZdcEbLPz2Uf1SQgKP/SzkLKEF8B5JjpKuIMD8ija3hvptzKQMG6f77YlrDRl/uwQZpRMfIDUSv48uIguWByYTbjTT8xcroepp6lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2bG0CuMzxy6vJ3iy7KcSu6YYYDVHisJrFHfVXuiecs=;
 b=kA1Bi5/mMcSnUZ9mYLs/yqpsmqUEj+cyDNQrEuY3OmKefcIZVAL9PZjJ+1DBqXONyCgW7dMUOMhcfouTLVAUyfxXI6MRboQXSjXhhTh/8bdBvml0Qg/i/Op0LEHzfH+FauF0snLnoVm8T3maDp62aZeiuHA6/SFsXLw6MGqhLKrrzqllhq2V2aDlVx9qGhIO1YwzL7C8W/EYtFT9v3K3aTfqB02eKCpb7+CDLZbQyynElCb8+/p/kqqACVvkIeu5VkUqtfVOcU6Owne6WqLvCFV5WYXF0DI/NYw84vyxM2dVc1d/4s/tnSuqYxm6c19rnaiOJewE6Jwp2WXwbgvkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 02:59:58 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%6]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 02:59:58 +0000
Date: Fri, 14 Nov 2025 18:59:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] cxl/test: Standardize CXL auto region size
Message-ID: <aRfsqj2m7lm-SPir@aschofie-mobl2.lan>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
 <20251031173224.3537030-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031173224.3537030-2-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e47ea1-3577-4b69-b695-08de23f30fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LqB4hbSHU2Z8TzjJY7Lmw/Um35kuuGOK1yO1jupj7S0AqqnnNBKjXpLRTDMU?=
 =?us-ascii?Q?/+DcKZ2IQbkVSXuO2CwGpzshzfxuCB4udobQNsA+BTibl5QxmGXm/yjRGhj5?=
 =?us-ascii?Q?nNqd4+oZxdc8A2zp624S1Cltc/v2QG9T5A31ZseZWwwvhuwWNdcsCzotmj+W?=
 =?us-ascii?Q?3V+v2tj82OPe6g4Lp2ykItkt/SWLiR4g1VsEDI9JF0CTqzuTexFjZ+kX2fss?=
 =?us-ascii?Q?UorEYZNJ5j8TtemLKcgOm4t0hNJ208Kz/iBG518Ue7zWhWzKNenHOH2fU/jh?=
 =?us-ascii?Q?gr9oF6PEeOQxiMvG9lRPbULQYtu+JGvg+RpppQWYzR0B+RDT0YmX2hJUEYN6?=
 =?us-ascii?Q?C31QQyST1xVTmkuskeFofZt+Jd5ZBxXlwBFkLU+W9eu6bmGuX7qlRqhwrMRT?=
 =?us-ascii?Q?7Qg20k4wvoKOPPHOmYcmsOqsIBtWBMDdOWbRzGabS7iV56hBQCj2x5KbMdki?=
 =?us-ascii?Q?rCiTJI7M/hpNYQeWgsExAJs7YmirOBCTvzAKotZ9EvZSC/ZhlJrTB1VxBlis?=
 =?us-ascii?Q?O65zzju0iSph1YSwNFjuMmV9uT5t6JSNXXPUm+aEGnnkCd9XejdSRuyZCA09?=
 =?us-ascii?Q?V9lEN4Ngn3fJbmzvxBUdVLER9/treP50sPDYRlHDwuhgvggItJW6WvzGHglx?=
 =?us-ascii?Q?9I6gxUUZVD+3BOx1Ve/zNVh7zws1KxltwYJOVG5lUkLcEfg2CuDKDKcKZZcO?=
 =?us-ascii?Q?KvXaGWEAqWCjVNtI3YAAPKVrEGSON3BOe7esbCXGwZqMZH7A8gonNvoOmGuG?=
 =?us-ascii?Q?O/nR1P94KkW9R7utsOyV1OsK8QVP47s3/P7+wbiS42LFTcGkHMxoVoIt9LFs?=
 =?us-ascii?Q?Ct2PGM1GepaDmFZvrDzcE0zjN73unzBUUPtdhzzQk+O5/rqXHYpetzctctus?=
 =?us-ascii?Q?/HgTSBqm0Zu4JXWpxQPs6vWk6qzNtybKVu9B0Q+ucQ6SsOQEv9A7kd3HgFDd?=
 =?us-ascii?Q?HTVey7EClfIgXhxbayhCJ9qQq/q+DaDoPxCAIBNVP6hHxQChAdMFW4nOmrVo?=
 =?us-ascii?Q?LdN0uLh8a9PWlKqM4Gdrwm4jM3Zgucy6rHAQo8q6VuYLQ+Jy2RVMIyB98HN7?=
 =?us-ascii?Q?P78BSYamLpljxMOT2l4w97lVjGX/VuH1KxG2N26UX7bjPpmzGYZYXEkA/Mu3?=
 =?us-ascii?Q?0ALthqLuowrMbItzynRJACwyDpqKtC3XRpGwRS/MhlKYRWlEFhghrrbWzOpw?=
 =?us-ascii?Q?ugoLF2FPmXGZd8YOk7+ZlReZHOXDultFaJ8DHMoP4Iuz33ajutxV7BniqqQQ?=
 =?us-ascii?Q?Nb1BaRaDAE+246QpH9LovZZ/Qzq+s57ulHQQcm8DRdVL6br2MuTgjai69CNb?=
 =?us-ascii?Q?N9EHstOOwZfMX+G0ONkWMU8DJe5YMBPQnsO4gERZHU/+AcZzcYyL2mMABkqK?=
 =?us-ascii?Q?Fp8wcFmeWTQx2GAjLg4p36UaGpr64G13Fd+/0yF0HTiI7gOqxZNBZx1o7oYf?=
 =?us-ascii?Q?GhF2/Z2xfpGBwIrkAc2Ew7wNxCNfBVML?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0A6xJ6nSzsNt0felfLHGi1cEJwbc/cIFWJlCcndcH+5WPVH6sWxdsVCLEtuA?=
 =?us-ascii?Q?/xCpzZIXbtmvFE0RPtFy+Fq/rUlLlMyFkIJbwCUJt02ONcIzUqxqYMCmC7+a?=
 =?us-ascii?Q?ynVUY+gbfhHkRalIW/chI0udavk4RE0d9gtpATeVMTDcerFxRhhkdv77Nfuk?=
 =?us-ascii?Q?VSGk3pVnEdeXm4qCAfQpUGI4JFrs6x7BKG39z+GEsFkPrHVjXxoG5FFsCxDP?=
 =?us-ascii?Q?eMt8eSwmtsHSBVmHd4EBD7osvJILyOpoVi3uysiaewbS3k7REDDZrq8YFutu?=
 =?us-ascii?Q?GHx/ccdT8ASoiEDXLpzr89FghHBO7EmJ9aBjiK4TDQuhgPny4N4iRxhvr8cd?=
 =?us-ascii?Q?K0d0yaN0e7fhtNQhq8jHia4INdvUZ9TIM+Hw5doxJCifAX/F1E6V+XJvKmzy?=
 =?us-ascii?Q?0Wpk29YFmcsUVWBJTqH/vVa2RvJZVpWK91L8Or3BPY+RDr8cyRC4GsF57t9B?=
 =?us-ascii?Q?Hq3agLbfGYlc+OkQzPjjPd+wNmM1hP10zZ9qp8J02Ee16r452W1X+7Vgp+WI?=
 =?us-ascii?Q?3+X6gyxJo6ua6t3gnsg73DVJrnU+LOVCLatDrifZWXuFd2rEDvK5BEqCWYbe?=
 =?us-ascii?Q?wdnUl3ncVKpcie3TWpCANi87i9d38SsyF9uYaCJhOJCH4WZJCCstcn53tRI4?=
 =?us-ascii?Q?H3aGsWy7Gw16cBtShGldOT5hMrA7xrGVpyJeat3ImkIEd932BAygt1BnGFYr?=
 =?us-ascii?Q?SqqdDr9D2PLr1AeUeXdkhwG+0KYKFDMp/tiTaTMgDRsle4D98UxEigdJw0xp?=
 =?us-ascii?Q?5IbMY8QmQdr3Y7wwHSC5XxADLiMbeUSlqgZVKXXvXwDqaLMhFuoHEBEdlTSZ?=
 =?us-ascii?Q?oYVgEE4B3ZwEX7JxZGluVpjzZNAibsfH7+fmZZQxBDw6T3Q1vW80GAhoEjCt?=
 =?us-ascii?Q?L0UBnEef/7LM49bJbNRwEj3spGzwcIuMnhYG9c0WKmhilIUQYLIDr/HZIbfW?=
 =?us-ascii?Q?nXqgJk0LcA7CFbJgG7uIUi4WKENptFWnkVPlyGbXZIxazozeoy8d+oTKkgEL?=
 =?us-ascii?Q?khspXl5eEsjWT34xrr3qvn3KmSEODWcpBf1Ed8etSghEMf6Cx3fRNhz27Ukr?=
 =?us-ascii?Q?oXK7Fms4ibNbcsbB/sOeeejjfPmZJ5fGD7QOGe5lZVac7y3zKIux86KoAdOE?=
 =?us-ascii?Q?ocdz5qjmzuTga/6eASONAV8xWRFaPhxP7KkSNhNmIfhY1LMf+T70jptSHjKl?=
 =?us-ascii?Q?twWnvy7i93d/aKuuaYqgh4QT1RoRV9rpMC5gbSJ7Oi6iQWgQt3d/lx5onpZj?=
 =?us-ascii?Q?3FBlhxxF4RauRrgOVVQYgnKdUOantEjpckinjvOJjirTXU3J1Irb7TVsMCU4?=
 =?us-ascii?Q?lxFmU+NFR6ozShOh98HGaDI5KUDBbVbtXym3zt/oVYPcvGms3nVom+sG8Z5e?=
 =?us-ascii?Q?2hi9X0veMTyWIZo47Km/eBwzirP9ZY3zWbHMO6NTZ+oiEVVqtGEJKAadc2Uo?=
 =?us-ascii?Q?g7+NKr5eLUcxP+x9BfQ4TbIkmQHOzbXT/X7CDrH/RpBUvnU0tcU4SBT/U1SU?=
 =?us-ascii?Q?rJaOQjIo4Lvfj84+/2iD3Dgg79k/NwEnKd+SmzzllIH9ok0jB9vYa7pgqQHw?=
 =?us-ascii?Q?SNiqk106HbhnGuTSF8tna8Hm4FUibInPHI4UggOQkD72R6A5iO12jd64iJpM?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e47ea1-3577-4b69-b695-08de23f30fa8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 02:59:58.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/OBFvoPeMZ5gorh6yLqtcc76sGMj9KJ/TJ+WlDVaaQbf1HO/JPlwDh92oQgpFjQrDgQiBoauwFytHHTdTfkOA7PKUVIKq8zFOqkut3xSjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com

On Fri, Oct 31, 2025 at 10:32:21AM -0700, Dave Jiang wrote:
> Create a global define for the size of the mock CXL auto region used
> in cxl_test. Remove the declared size in mock_init_hdm_decoder()
> function.

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

