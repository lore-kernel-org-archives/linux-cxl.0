Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D791427A;
	Thu, 28 May 2026 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930356; cv=fail; b=nMNF6uN/VigsYwSf0OnFdCUfleSV+r4l9HICDEDdV5q6A/6Vq7otbocmSeM3NZ6yF5SrKF5jMuN3retWS1VwRmAhNJCnvI/AqKhTgvzb6uWh8DNMxLrOmM4Aeu8hX5VCBplUK2eoFVEgrInTaPOb88EWxAtjrvWDn2zOdo4ESGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930356; c=relaxed/simple;
	bh=GRxKbUwYp7YVWR/ewtYZhT4Tyc8AocsEL5AxLRGHXhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIm28SdLQ+d9P222vv2xjNn4LZBXGTGs4uAubJo8HHuHaLbzMU6gav8TtcfPtp8dtRzFnnd96unqN/1YkZZVHcHORkpB+i+qe0NQWI0aApZd8O5xOnqsocHq7kK/r/ny4IRclnFPaF1fP+kkQrBMXEuv6tJ2UhmBxvgNGqzS614=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2uwmosW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2uwmosW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779930355; x=1811466355;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GRxKbUwYp7YVWR/ewtYZhT4Tyc8AocsEL5AxLRGHXhM=;
  b=J2uwmosWUthLjeprh6B5W5gQPLvMM48tMm+eBVLntKam3ZyY+oguW4yo
   6YSM6gfxdUrKK21gSyhPZjtL8YOEm+D016QzxoKYMdtnLFA1bZRwfHc9P
   UrSWlyosVb7XC7c2E/39adm0u8ojWzPu3pqqBXYHf+nlT2OT+BGmFE6DH
   hm8c1H6WS93A46nHsQ8cYhCyUtgnAFTMLM/dY6KvbQyW6jbzh5mX/KsLb
   mS5/pCFhVj1IOTcSqt9vPNjwWX+TJa7Ea1j8gX1PlIpGlBBtb00XSZjkO
   9nb3MM2HOeQLQEENLubU29TwZ/ASRy32ebV776fMMKX6me5YnLXvno4bK
   g==;
X-CSE-ConnectionGUID: L5CGg20mQYiyQ4jxs689fQ==
X-CSE-MsgGUID: tRmNzHcVRra4bQrkspAH0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79921649"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="79921649"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 18:05:53 -0700
X-CSE-ConnectionGUID: 1ORGplCnQJ2qpHb5g/uNpg==
X-CSE-MsgGUID: CNZbp7YTQKujjBWJ3rBn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="239824407"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 18:05:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 18:05:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 18:05:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 18:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oESxHcGl/7z6aLNXPBNU9hV9h5HXMuPHeIoEj0iqCEzaDR2x42VLlmldg9FT51uHVNHD27y+eV+9lS8IFDU7FB7GQb1djK2Rhkr1Lv3V3akYr31mvaYue2NIYYxA9uggZ+BcTNJLo4kZ0ZgryIMUEmz0zsCGaEfIr2y78Su7uJKPoNcHqhNtSK/W8zTDrPlJ5GtmnSv7FH3HyNCFuKn0tXe4CeaSisK6iazgkeSJSqQddu6xpacZl6zVC9Dp20k/CsMjPJFRSLb80HC4FyZkK4LQnxpeSiRKvCFGmj/SZhs3EMEy0vV8m+nsX/n35V55kaoMtAt6E9MNUcPhFq+DzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05QyMaZyjmKJfwHVpSzBQnO8j9L9M4giQWh1XW2EtPU=;
 b=TkZ1ZmfbeMoifU5c/NeZjAOd0fJ4TckFQG5DPGCEKHKifs6rz7xPjIdTyaRWFzY3IK1taZ++lIYABk4zxIrG+M/eaa5eXsiQPpkbQ/wi4TaIvGLWM8mcnkYTcS/LXAkliFwvBB/STq52cjhaArPd4GNmd81uUU6Hrbur9PERSrQhE2dSkBMrx5HU/Pheq8R7Y2BaiVouBCuwtZQoj6XxOw+PcLskrTRAXV5lRqjjD/Ym3ZkzEHegiL/hQeX8hr2K+/HiqUrfI+naG4q3TlzCQl/61ZpW5C9vhMETtKd1gxX+GcduBh6KCUZrfR4W2bVyQvm+FmY7kLdibtDLpO4Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 01:05:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 01:05:48 +0000
Date: Wed, 27 May 2026 18:05:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v4] cxl/test: Enforce PMD alignment for volatile mock
 regions
Message-ID: <aheU6K22fzjoZeK8@aschofie-mobl2.lan>
References: <20260527090332.30002-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527090332.30002-1-icheng@nvidia.com>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1744d3-296c-465b-c011-08debc5540ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|11063799006|6133799003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: DI5EKXIm5dJaQAZRJ/8WzyY5J0hBtMOE46FX9b1zdQZsB1jNKOLGXMOnfbMJF6RIPceRIPIEdLrX5hEfPfT9jtEgrY5PYjH0hZbTmrCQOu/OhsSopi8nt4+a0/iqg7IvN951XQ8MxUImVwHDF0reN7IirP78woPsQmW92RECdLuMEvFuJMbabfLfV54VmItfOoXgNzIo2buv9qYTb9UI0BO2To78M5cR9qTIwN09UJUoJ39utmHPffkORnmUw9DS9Gyu9IfaG865We7mXdhFBINGDCdbhQhh9vR+hKtacqo2pAhjc/BNdFjtKRe9JpJ9WPpGJHu0+g3a7zjWSMWoFa0wlKjCyiVpcLX2HRVy6oJBaWYryL05gxe8TV0ywGI21D9rhpvWLnleuq11NIvhU2gW6RxcfUAFIEpt9JQzS2BzM3CmuUvlzNNVC8YIFQbm7heygpgQNRKQ7BiVKNQ9AG7mzmr6j1d4bsfNdbR+OYHBh6ix5q39XlSSmBD43X54ytPfkP3FWO/yyXJsvLBWxQwLfGvqJLLM5KSV8YgExLgChQ+qlk/DY7xhSQeNSjiAvAxvY1bMdgk5XmJgdn0gAbn56P/MqXz6SPfpGCHIHWQ2qq83fWxxy2W/GBmd+5194K19f7zHEMbEvIxvaMJYCp3iRco3kQKbIkLbnKldvHXtqFbuRgC/jsm2rIhdVCc/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C1CIKhtFZMA+W3cdENN6++3h1seL/ZgoOVDHw6YUDLH9xlPJk3nL/M1qLlt0?=
 =?us-ascii?Q?rAev6MGVjQ4kXT+F/FLfSEgnPxzLL5gJxZvznD8VUWkb8RsXjx1GnZRgADT6?=
 =?us-ascii?Q?2eJJiZbeBV/dPVyFWHIsSMg5rdOj//gs/MCTkQMHjur6KYjdcf5sSKwk6PHc?=
 =?us-ascii?Q?/k3J8KZGfXFEZFzRvQ4MLUzRrqsVX+TPvlo/Ii3xvlK/ajZhU2OL8aJ9AXNM?=
 =?us-ascii?Q?BEYAk6x7CHPfICDyCwR5/rZgE/rCYCIparvcdgXfzdBwtGvCo0Tig9Ku7e0/?=
 =?us-ascii?Q?DTdieglAiYhLCHtinPg5WAX8XHfvZuAYT5akcie03k54+lfu8JGoZulh76Hu?=
 =?us-ascii?Q?42JF8dsq24FebZwtdT9hN2qyoCIdgOqMyw7N7rv3/uYqHDU5esP56ECcEU7S?=
 =?us-ascii?Q?2LOfzozkgqndhhaNRe5hnWoIvOEnQG1h25Bpgbx8Gc9JnBYFrwD4c5ZMD3Ti?=
 =?us-ascii?Q?QuAVn33S9PYfE7TwJxVNEwTs2Psg4lNOCplfpcauCCheIq1MGFbyuTTZwwKn?=
 =?us-ascii?Q?rz89VZHlGlJlxDy9fZh6QhMtrHvU+43c3zNnUTwX58g1dBdAbSoKOHN+y3d0?=
 =?us-ascii?Q?KkUMG3m1D9norXLzH10/Sv1wLFqp6zgbkQX4bLBII91GShu37OhQtZrPKnJC?=
 =?us-ascii?Q?t8pg08EGEKGiVbaEF5hit9+JoG8xZvs7cOHB5vePca2D+pKzArW/Z7tNPYk3?=
 =?us-ascii?Q?1sLu7YMZ5ecUGL5Aiphk3S6TtuNBZN13Z46iQid3+I+CfrlvixaB43XxEK36?=
 =?us-ascii?Q?y2PSFXf0k4tUhcxdYB5nYCW76G128dv/R8LdbUeU8T8NDK1b/2FbgkgnIkfQ?=
 =?us-ascii?Q?P7oB4rldgPFLwdIeme/9NtzV8+ZFfaK+U6lASo9rhPKBpSsIAJ2a2u29U7sj?=
 =?us-ascii?Q?FeClERB+JRwRnp5wJlOgLdHakFAC+VSyYOL3bOhSSDYgcw0MZRRLP64frUmw?=
 =?us-ascii?Q?jh21IVb7yedWhCkAqQH/Z7+yS4nPSSGWFENLYcaEJeI0wOYhWZB4Rz1M3Zup?=
 =?us-ascii?Q?Ti55clJKGGrGi+vTyBVgN6P8PzQqvy/2zWJgXon6y8zMcDRmjpD6cVoAsvS7?=
 =?us-ascii?Q?i0A+ryMn63G7OyrhDq9FGHozMeWrT7ycm/pfWr9Cy5Gzk542AI9tgdbpVutf?=
 =?us-ascii?Q?aqGFL4r0hI7ItjlKiy/KECfqdPNDDZcEOlwpupPx0reOs/0g92TEZNOzV7pQ?=
 =?us-ascii?Q?w84qB749za5Mr6urB9Oq2fRr3kiL/v452y3jiVVBdKSg9Kwmt5hBg2r2yu3C?=
 =?us-ascii?Q?IxkqcZCm1xFJKo30c8ji7MlaFI0FBfYdJWaGj5nreWoyghIp9ZYH7V9kGDk/?=
 =?us-ascii?Q?8ptgX/y4xEADOEYe4sgCRoeRQ1Sb0qqp7TkHx2owlQQk1wN0LzNL8nsb81ky?=
 =?us-ascii?Q?vC54zzn2WtHPMp/y/+JzRvh5OcKGE7Rz/23NFwmXyOVd1e++2Q2iqGpXFY0E?=
 =?us-ascii?Q?eV/buK2W6PqhTIF9l8RkzC1+wU1dNaQ0eLYVHuadGtISda8xt0pm3x+SrTE1?=
 =?us-ascii?Q?Hbb/eTsBXvaVgiA60w6H9TwXzZynNjwonvuYjAEk3jZZoCSbg4X51dXyTjWE?=
 =?us-ascii?Q?Spzt9pNBe9TAmLR9ygZo0VzAAkbBZPsbPikLhDr/yv6V2XJPND2Y0wEkysg5?=
 =?us-ascii?Q?rirhP01zHQOVY4e9DlWe1y7cfZ6EHQ+cY9BvoyrIaq+OxAuK81B8SefE7bNF?=
 =?us-ascii?Q?l8WPrz7U0jIRl4QEtpBAqV9yjyLVdI8rY8CQVWgeXiRM7Rx3EW8XuCuEyImi?=
 =?us-ascii?Q?dfejj5jJDF9exUviitGcyUTu3yFIT7E=3D?=
X-Exchange-RoutingPolicyChecked: qOUCz2Al8zt6SFV6sG25i+/OSf/k0o3YxO56mVTpxtinwkKsGet/MBCEsfoELRrzsiq5t3tE0uMJ1FRElvALD9R+oFOQmEvLbc7FlLOO965uOG9Oipqjq00Kj2khwqWqfqQ1zAho9m5Ylo7DgpXUJP3m3DpCHbFQOUWR510NxFyKwKhAC0YdonNRz7QB5+SGgPWoX2Q+SitaJNKrXai50lFs6eT4obFKJzs1MUqTSAioCa3MWGJeLR6YhH2mj+QIEent4NMoqmNro0Q8u+KgDIjvl4QBtQFGS+UVnoqR2z4edAfml5L2GPPztdyzyDDOtsATDytUt7JGFAOLYde/UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1744d3-296c-465b-c011-08debc5540ff
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:05:48.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8qBggbt/nhcFnJ9tqXBtbs9kGsjsrLCtrwsglPtwk3++NBZgZts+rGpnoDKDfoBYU8xFaMVg79Dnk4wPOwaEKDkkjKmoSckO5GGNapkNgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com

On Wed, May 27, 2026 at 05:03:32PM +0800, Richard Cheng wrote:
> cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> from a volatile window inherits a non-PMD-aligned start, and
> cxl_dax_region_probe() -> alloc_dax_region() fails:
> 
> """
>     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
>                                 with error -12
> """
> 
> Enforce that every volatile mock CFMWS is PMD-aligned in both start and
> size
> 

checkpatch is emitting this complaint, that I believe is a false
positive, and I'm happy to ignore versus add ugly code to appease.

WARNING: Comparisons should place the constant on the right side of the test
#36: FILE: tools/testing/cxl/test/cxl.c:321:
+			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v3->v4:
>     - Replace compile-time BUILD_BUG_ON() with runtime
>       IS_ALIGNED(mock_auto_region_size, PMD_SIZE) check in
> cxl_test_init().
> 
> v2->v3:
>     - Correct hunk headers
>     - Add base commit SHA
> 
> v1->v2:
>     - Reframe from "fix start alignment" to "enforce PMD invariant for
>       volatile CFMWS"
>     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
>     - Gate populate_cedt() alignment on
>       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
>     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
>       in cxl_test_init()
> 
> Best regards,
> Richard Cheng.
> ---
>  tools/testing/cxl/test/cxl.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..6f8fa7504cad 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -318,7 +318,7 @@ static struct {
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M,
> +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
>  		},
>  		.target = { 3 },
>  	},
> @@ -495,9 +495,12 @@ static int populate_cedt(void)
>  
>  	for (i = cfmws_start; i <= cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> +		int align = SZ_256M;
>  
>  		cfmws_elc_update(window, i);
> -		res = alloc_mock_res(window->window_size, SZ_256M);
> +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +			align = max_t(int, SZ_256M, PMD_SIZE);
> +		res = alloc_mock_res(window->window_size, align);
>  		if (!res)
>  			return -ENOMEM;
>  		window->base_hpa = res->range.start;
> @@ -1826,6 +1829,12 @@ static __init int cxl_test_init(void)
>  	int rc, i;
>  	struct range mappable;
>  
> +	if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)) {
> +		pr_err_once("mock_auto_region_size %d must be PMD-aligned\n",
> +			    mock_auto_region_size);
> +		return -EINVAL;
> +	}
> +
>  	cxl_acpi_test();
>  	cxl_core_test();
>  	cxl_mem_test();
> 
> base-commit: 507bd4b66c85d5b65696150cc16d31ac0b2ab151
> -- 
> 2.43.0
> 
