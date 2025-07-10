Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C68DDC1
	for <linux-cxl@vger.kernel.org>; Thu, 10 Jul 2025 04:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120202; cv=fail; b=b9WQQOdUJmuMSprSBNCLIotbR1jweaPuZB/zC45u9UMr4IIrV0bk1EgGgipJAIyFZsf1/Bxy2k5WwaAKxh5BrDdNHi7GjHtImiLhOETkD/6f6Qm9YUnGEaKFWJ5qU6abH6Y/xWjPBXv80/0pjPq+47eoILZx6t7HDD2y42XjlZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120202; c=relaxed/simple;
	bh=tvjYrc9cK5qYPACdhqkpS/3cq8f+CxzzijjB8FqpcUo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECdigrMJWVmgsUDziwJjqUmdov+zeBClmh9q8Cl8IT9lxdPk5h5+SXAcH0+NhHTJ5X0kxodNNYIq11nueE0VxbzOAttCPEPQkdd09PiPPgaa5iKdedO3JZI9ine3fgvZBODs5zx8rMhmOOZ/DO6x0PyWePtPcmJeTkgJCD8chs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBabNs3r; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBabNs3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752120200; x=1783656200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tvjYrc9cK5qYPACdhqkpS/3cq8f+CxzzijjB8FqpcUo=;
  b=kBabNs3rwUmEhm1YDebpDEfaFvzUmL1foXLyRkDiyEQmaD1tjxliCJdM
   ZuuDoWR9GrNyaBezvHHtJagEaXHHfwmPb80IrsCGbalLS7p5Bd3PyKyXF
   hc3K75JCo2/zXTJ0vKtkIsStgcESFgSzYjdkLKZQ6TjSoWSFHeKDchZcP
   B88BwWm5x9KoUT7mDThc4rCBmm0bujxZtIkj3GezlCvgS+aNCbfzVUGYT
   g3I+gZsUZGecvSDA3C4D1mLSwNwFcoDiCPWN0rdSblYPClzUWsVpLKGBV
   0l2/LyKXjHD+QYkjqk4GUxm3bhhXWS5jSwGF5KmrqGLpNCamMlmpmrnAh
   A==;
X-CSE-ConnectionGUID: E24zW7MtToOFKtjfxH/MRg==
X-CSE-MsgGUID: XA6iDI2VQzybVmP1naNPKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71975844"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="71975844"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 21:03:19 -0700
X-CSE-ConnectionGUID: YRCqN7qdToarnt/Q8Qwgzw==
X-CSE-MsgGUID: RU4mr/cTTN+9/Dc+QjiQ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="160294751"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 21:03:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 21:03:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 21:03:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 21:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrR3mhbjyW3N5oDvXCWLYkYEuaE15qD7p/8t5jVqFHIVcG7YgeDUEzNfa+jmNimQOIebSybKKWb1haeYahFEoEJmWY0qvzOgs5DSo7ckhyONRrHxehmx6rHeyJQtny+kpFKkCVumDNbgiGijqHnBA8sJd3YSeT08NN/ZkctO+UkZPX1mbBabHCR1VXFxLyQ9dpS8oDn6tOozSurJa11nrjJUX+I/ATxuYeq1kdfKHb2CWB9sDLGLRAQq6AecLnh92oBVr1CXrtIosFpL8Zbx41pbKQp2oNDC8+nEDb7F4PM7Th9pUktfmcROz5af9j1X1f9JDANFSUx34xanFwAUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvjYrc9cK5qYPACdhqkpS/3cq8f+CxzzijjB8FqpcUo=;
 b=sXkogogS8j9dsFiXz6unlZXN5Rv9fgL7GIyfhixSznsVG7WljQYBhUNKvP1Mt9wG3exvo6zUPMy67A2cqyzWv3BaK6dC6S5wwAuDI3yuSk14RvWeyuVbOyEst4M8pm4fKSk0VFLkq0t9CqKZwkT7JGEaXjawM9+Ca+jrbQvl4GSKtVZ9uwadtMfgWEuVbojxG35Wb2AITicjuTsjj79CJkeUZRoTr6iiYFcOHj7+oEvNBneu2IC2x3V4lGtgb4Z5DyXlFQjuxhRsPROXFPRGO07VTtukZ87mwCX5Azr9ARuqM8qAkEWHc+sjxC3/vv9PKXOdw/jhK6UBAtWd2bD4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Thu, 10 Jul
 2025 04:02:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Thu, 10 Jul 2025
 04:02:34 +0000
Date: Wed, 9 Jul 2025 21:02:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add hpa_to_spa to the root decoder callback
 operations
Message-ID: <aG87UmfwmrXeWvHf@aschofie-mobl2.lan>
References: <20250709200746.2567860-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709200746.2567860-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2166226c-bf37-4a30-286b-08ddbf66995a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gpMOGADZM+Q0OPRXcid9QcSm6iWqjNOWAqu6DKRUlMjP5A+JiR0pNe56ED39?=
 =?us-ascii?Q?dCuk7bG7+PW6kZadN4MGjkvc9ww14hEsVElSQFF7bG9cGmJd3C/dyjx9RWmE?=
 =?us-ascii?Q?5KmG5m08ANfpStmr62NZpyhi25yFLHgVxJk7yn634LJvZMT9YDRNpBqLuaGD?=
 =?us-ascii?Q?XhoMGfRAxjTOoGKdUEZqnMnHX0db492wJgu/unuyrLMqL8bQzQRHamWoic0q?=
 =?us-ascii?Q?LNdMVwD8yqlnArfg2Eym7K3AemszW2ebfL2JfDDNvaIaOmYOJTlipll1OnEB?=
 =?us-ascii?Q?MrT+GphF2+q1De08LH5VjWxeu2NrB+2uk7Qkdr5f5nxKW96140heazVwl8Aa?=
 =?us-ascii?Q?XyMXaFEsiwa+I8ptqwVeIYn1XK3+IROQLfMZAGTwDc650YQLgUwSS/QPPRDP?=
 =?us-ascii?Q?Jy66gKoFTKOODZxPupKTE406CX/39abrCVH4UW1PBIxRwQ0aTdCjflCFOEm0?=
 =?us-ascii?Q?GTaaJeBk0mDomBMLwAkDO3BabAxoUVtrQztz+IQVHue+UIVay0dPPOakhTyP?=
 =?us-ascii?Q?HhOu5M1VAWIQMG6OldAXwnd6Bl4AVQ/k2kvZX8RfCanXqO72T18xx5wx9Jqg?=
 =?us-ascii?Q?1PqPbmeBwW6XoyN9gd+QlGNAebpIaC+tYJQPQhqpfuA34MrYUDI3lAJg/ugA?=
 =?us-ascii?Q?VWNN3kB3KRV+3S0U1v7wn9XYV1d36QRub3FY5+zUX69CDSzh6qOWz/SCkADd?=
 =?us-ascii?Q?FBOxqahfI1KSqkslvQDOpSR3mZlb6Bt+L+X6rEO8gzuDbaw5IRRCFwn9yhpl?=
 =?us-ascii?Q?abp6ENxMU5xVlZ1p10EvOPB/zqBcXHZ93YD9cNnLqpZObj/C9kpLgQKQoRyH?=
 =?us-ascii?Q?faYLjmqpBeJJwLZICxVlNWkLnLc5EYmVV73kpMXWgOyhRhv055tD2E4HcEbf?=
 =?us-ascii?Q?Z8SXfjEH3bwmgBR34iGk2hN/uihX0EvKP5/tTB7jXbbyH3ysJ3j0tCnV63mn?=
 =?us-ascii?Q?Wz+bYmYwg68EN2O2Vb1xHoHvkdnggChpfLO3oCaZCA6KtL9nXyP3j/l2atNF?=
 =?us-ascii?Q?CMq9Vuht+nFtpqz7BybdBlinTO1TOkvda0yyNZvLLIUmmz/ogQPY55UYpzW6?=
 =?us-ascii?Q?Lt6hyHqb30GwaptkfeqsCuFfIII242Kc+5TS5ZvKGCWoVXHbBQopQ1tIh905?=
 =?us-ascii?Q?Hbfn23f8F1Wxe2nyV6PyzZ5ZyS2+352HO7Xv3/iEgNBSKfeYTKZtuHzWhYNg?=
 =?us-ascii?Q?Wxse3KEm7hoMlmL+/GIfsNsEjCFVWaoIneBuybo3/HGAD1hrlwHgY9V4Oi0X?=
 =?us-ascii?Q?/NKohJDDMXpf+ZYBm1NggagC734v8psPl8OI6S/9/OwBZSpd1aaArtceY5qF?=
 =?us-ascii?Q?AgYaHMszbCPnOU5w1gVwBSqfZK+0bbxR8RA0tGMWqBeQPF54TGxQP+4FOc5J?=
 =?us-ascii?Q?rYMdzpqbpwLOHjk/37GwAgJ/F740fJvC+Wfc0u40B/5lJDPCZSHUNgjXgmFX?=
 =?us-ascii?Q?1vUWqXHKU9Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVAelq2grmrIXt8ot4TDgzR0amxo6GPx2I9fNnf9iD0mB3FK4gjxxOQSlocU?=
 =?us-ascii?Q?DlhGq8DxhKtpe32J/9PODeOlduVpM5C0cTs1ulisS4BoKZcQ+CdjYWI4l26A?=
 =?us-ascii?Q?levpxh5AjhWNVtD1KRUgBn7k/qEFXM2BzToEct+ftzIqQVf6iOuwCSHxwpbV?=
 =?us-ascii?Q?OQX+SFk85S9ajw+M3hVpaZfrcF9RTLZ5Bup8pOREABSG1tY4dlNPq35RZ2Am?=
 =?us-ascii?Q?ndYLAF+rQjmlodVsMbSGAuwJwDq6dW6Q3u+rQZum4xjpAJcAPNHcFfbNuWHS?=
 =?us-ascii?Q?Z1qFa9u+lwmdmslqNqc6UPcmFYll3OZ5knovbi5hm2sWXd7CJmuZ8+hxR2TA?=
 =?us-ascii?Q?7koRdEVf01bFemxS3Gp7ouHKI+IocE8Mt0nF3oTYiIR+uTmyMeGyytmmzCIm?=
 =?us-ascii?Q?fz3bhYJsrBBjQZevMwLg8CLm9G2xTo3TTHv6ZM7IGKub5hcBhWZGRhRHiP+7?=
 =?us-ascii?Q?Z5PAiog5h1S43YWvGYncvO6uQK+4TWXWIDGjiwdwnkayw/fgzkeRpifYSWo2?=
 =?us-ascii?Q?rJKedCTr8cm+HRF5SdooKhxeVsPVBlhrN1ziyzXB7SAfjFtXlrNusi0QIDuO?=
 =?us-ascii?Q?EbgHwsYGEmj4hYMjrO6j5HX4U3GC0NrynI63FQAmt9zDT8Iug0E2yY1+1EET?=
 =?us-ascii?Q?ozYRl07x7J9LfOV3Err1jT5AZFUpw1qBaGEDDyyHh5e4zwPYFmHUShv32vBh?=
 =?us-ascii?Q?0eSHfcXRE3i1HWH9GBEEPytSJueOopem5VAqq37gF/WfaAO6xQxQdLlCZojZ?=
 =?us-ascii?Q?2VHNuCfO0GuDltFdqTPqVtvGmtvVDqGXGife+iG73tkzQUvxQecPjTRVRjHj?=
 =?us-ascii?Q?/aBIGkU1v509BKqdxR8J5odcFvMA1g6X7wwJv+J/uDuFWoljlK13jjIdVJ3J?=
 =?us-ascii?Q?/A+el6e9TWvwie5fxdf+Kd1vSNEHoFYUCzxLHgI2GBCMoHU19uu0/MeO2cgr?=
 =?us-ascii?Q?lCDgcvDE2KhgfNUu0qzrc/A6ZbNGdv1vs8B+uyk66HkHrg0Zg+ppYEEdXtjp?=
 =?us-ascii?Q?bDg7tGkw/dFEdcl4bU4HaJTrnccMARU0sVZ+5OBcdvsmyxf6C+9Aoqpkh+Mi?=
 =?us-ascii?Q?+pgiZyqVpAI+saYAEfdprysudjPkBwyn0Qz73ACHoQPOcUOy7WtQCUs2V673?=
 =?us-ascii?Q?Zb72LqUi1tTVCNxjYRy0BPpN8hWtDtD9N9ueCGOuo9wd3J8BnBeo2CMJ/xjf?=
 =?us-ascii?Q?pYdvg6LRUYSzcrtGl6U8gOtPo7cWlWHikwULaHL2CaFd4oI0CrxhENV7osH3?=
 =?us-ascii?Q?stG0K2jl/IjHY2QvLzanel5Imw5k61ufbQEEa2y/Eu050K1l4LGTy7ciRKdK?=
 =?us-ascii?Q?U6W4Fhvm0HR8i+ezb/hqwlQarpCIJhMav0K7VYtJJOkHbGT1TrrPQJX9I67F?=
 =?us-ascii?Q?GUtDwO3O+kWPGnqW5SdMu+m10RWslBafOhxz8+/wPoI570aOHXRleTt/Tnga?=
 =?us-ascii?Q?UK70YcBNo4Pfj2otIm4ndSjpGIy5v2d4y40Sjt3quHk9BQSHepNVlmiT/Cf4?=
 =?us-ascii?Q?pMwIQz2rBUdi4DdwjDewunLB8pfx0FLkSZiuiff+oZcHBHEUi2myXKRYNOMj?=
 =?us-ascii?Q?NOFYBGr4EjSnvOm11h0WWmmaJxLjiiSq96HByqZ1+mMQI3aOm+rsFWw8gGH8?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2166226c-bf37-4a30-286b-08ddbf66995a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 04:02:33.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH2ch3AZrsbC/7cUfa1HxjijlIjCD5i5oUunu6dYUdsh2eVkasIw8vEIXcJwYKQLfzUoRIdKFfkOEvOIa8kvq1SXWX0gsUY7dKkxmZsbM44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On Wed, Jul 09, 2025 at 01:07:46PM -0700, Dave Jiang wrote:
> Remove cxl_hpa_to_spa_fn callback from cxl root decoder and add the
> callback function to cxl_decoder_ops. Refactor to group all the root
> decoder callbacks together.

This one has cxl unit test coverage for the setup of the callback, but
no test case for the actual usage of the callback. I tested it manually
and I'll take the todo task of adding a test case that covers all the
plumbing.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>

