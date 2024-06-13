Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF0179AF
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246844; cv=fail; b=VmYSS8x5qbtZPk6Qm7AoE2poFesJgMdX8UZq1ExeUc1DU1R2Gl7mYrrpBKWkz94hlWp6tUz35Yo5beGh59g+550fZprsK5AQn7ijsQDIcWLlcuRh09nISKlgsXp2BcsF/LIYx3C8sJQFHmGiB1Ehbbs7P9vitMQpyFfoh1D997Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246844; c=relaxed/simple;
	bh=oqiRrbYNjrc/+oVtkoBI2O5Zf5n4QRgKNEDlczbyMrI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qaBsGWnd3vHOUcCwncnnCzZOVfLOqoLcwPnGIGpm76BdTXD6Qv5kLse8lZqhxekXJj3G678abUxz1qs9AFNLldJRbK10UIAAzLN3/nlUF8DU0caNKfAIYmYxcOUl+qSVp0LI5Zk47yr4u4FnBH0DGRFL/m+Q1aM6A8QqDtbWUNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nzi1s/mj; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nzi1s/mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718246842; x=1749782842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oqiRrbYNjrc/+oVtkoBI2O5Zf5n4QRgKNEDlczbyMrI=;
  b=Nzi1s/mjf4uD4Z1xF2XFG2Ny/gm85d1DyLK7A7+2BAf6OuRm0XpYzZv4
   UKPEyOAKKUq5tvCgiv8vtk0PdKdudQ4/rBPDkdepkiDImnnq8pmzq2Kan
   keji9tY311uhUbPTb65zr2yoMPb0FaoEbY/Bin+H0iTTFMlk+VB/fXiTv
   N3H4R/xlo5ZtHCgjfiv+l6Q7Rrpr7OFXYjdU0Vx7FCvjp/7iuvibeJbcI
   J/OIVIIVPyHeYefyBDBAzHtHI2F6d9Z19mPLY1oEkLFPMMP50QsEZDkFt
   IriF/4dg6dfiXlnjjLcl+zSZVvTIbyCV+vEtbuEDXHKyBIL0eqE+Pvbuy
   w==;
X-CSE-ConnectionGUID: W7llvJiiQSeujgMsXfIW6g==
X-CSE-MsgGUID: TT+vFnXtQVqGAT0nd1SH0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15166429"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15166429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 19:47:21 -0700
X-CSE-ConnectionGUID: hxdOOv8TTsOxryQ6P9PB9g==
X-CSE-MsgGUID: EK5R3EB6Q32lEqofNZd06w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44890286"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 19:47:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 19:47:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 19:47:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 19:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ8gQYYH9zme4j5q6gitaJXCk0u/yyypfNGwjcOKguNQIDAS3XgTFYwW4nduxsT7CEbNA76gM+ebCsLtm96aZcKXRY37B7HAM7qjh7ItRoeGvjUGVRxm6sg6Zs8ndMjqUi8K+yw+5rINKG0mlkNUlQoiX2zNEkB0oNu4ZJ8egAE5Z5N2DqqeYMcfxE1bqQjU2CBLevClFjZGId1Zww9EYhlfLRdxKoqTbFu2oz1LycOtJf1vsNzGGYqt9e8Bdy9MZUCkD/aWTQzYdSVcaYfTSsnaUUpjMXMPARl0dwrV0S3HkRODkExwwmNVIJRb3SOloEjrzDsqiR8GT9+qQmMxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKUp+Wd/6koo+Zx8bXCU/58aZMfEtpzmQMWKgghXoqI=;
 b=Ivg/PX/4Ub46tv2YoW6k49zc084ZsM2hS8Xt28/6KKh6ESqYHWvnyx2pW6i+q0JbfNWIPUIrsw5eV2JJ6eJJ1SAyTn3CuDwH/yBzHJt4AwaefWCIiIDWGr/4QIzGEWlpvVdiDz+1x89memZ7n/D6iw0+W8myVS18sWEVK8Q60gVA2bC3a0OwvH853y4c3XYPAU3NxBK0aKcgFVOKk7Si2HKrez6qwOXXtjOYltQs3itS8YJwc5fB9etqL9lRZQEy6Xe9SH80M8RS0jfrssRwXq8MDm2imQ+GXxSdtQQ2DVFm7ajM1IgzvjytnzrViexU+QbIqPmkVhq4hmzMRg+lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 02:47:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 13 Jun 2024
 02:47:18 +0000
Date: Wed, 12 Jun 2024 19:47:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: Remove soft reserve resource at region
 construction
Message-ID: <666a5db3d4d71_c79a32948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240612205905.1209448-1-nathan.fontenot@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612205905.1209448-1-nathan.fontenot@amd.com>
X-ClientProxiedBy: MW4PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:303:dd::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 552a496e-7e95-470a-75f5-08dc8b5323f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uJpNU3/w5eaDYsB7VkuXtc81OTj5Av6MvMku4O+hDGIAL3WNGJqLiy5wW3xq?=
 =?us-ascii?Q?uDVMr0fKwIwlxfhLu7FZU0RufDWLfPCsF+JynsjWonQAxgclkU+gzsDIm9Ah?=
 =?us-ascii?Q?kVGk3m+BJL1cUd4Mm11wcCOnw2r7pqahDq3Qk1EiwMKxSbtdPIIfMG9AC9Or?=
 =?us-ascii?Q?qzIynfJ3bEqyFrUL67Qfs7mYlBHO2w1z0bzcSTsEmpL2z+YUxkshFI0XvPFL?=
 =?us-ascii?Q?dypFgPonv5BpHW/UXui1oaiQx6bzyj0kyDZSZqjIt9BXGm9AO0G7a60tTHw1?=
 =?us-ascii?Q?hUYCG+Ip4nnKYyPq+4P7kjSDgAlSJAGA0huCPwDE20LuVfBgOCt02bYvHyQI?=
 =?us-ascii?Q?NIlNkoa/1owhamsimbMMLJpKWV7OBD7gwX9vSo+fQrFtet1Y1MboavN+QfmE?=
 =?us-ascii?Q?kQu9VWBnSeonJzMdWPCsKt+M1EYcH6BtZBQ2a4UjG+BUhr1EkEwmoz+atc7G?=
 =?us-ascii?Q?C+3eajJBRhR3dftfrrXsyrsU18mSg8546l0kQ3YnrRI0BDH6ko/vffAkXnMs?=
 =?us-ascii?Q?9kSPViU0gVeWieTuuGGNdqNKOz5soMNJitFWA+FLzpKXMyX8HY7Fvb4wFNBK?=
 =?us-ascii?Q?xjBQrxRbxBsKbzip/vbFop66yRCHCEjC0Q/IRJefbXUg9nn6RXdHlYGo4k0O?=
 =?us-ascii?Q?hTvWI+p1EuMljlLS/HHcLGop4oKU2Y4KIchuruC8bcorkx2mqNtei8W1fCwJ?=
 =?us-ascii?Q?2uh6bf7mSQ65BgtLL+K4Apm73gkoZ87rzB1yr6zWpBtU1y4f3qcM+1ZTQryB?=
 =?us-ascii?Q?EXtXwdGXiQfTvlFnbCqq5oZlPCYA7DnOHmEQ1Unz7qnjCa+T2hu7XSTe/f1c?=
 =?us-ascii?Q?lxHxV2KiPJyClQ28/5w8t0O0xXL0kzT9/BcsK7zkyOy+hYHUFZPupwS8woO7?=
 =?us-ascii?Q?T5FZnhS4jcYQjh/Q8nUwS4XcQraU5ZimuQmjphLpVEPMAWJm0WymgRk14q0T?=
 =?us-ascii?Q?IeHz9gDoyJA+tMiNXsZ+aYaPPtjgalDdO/nrsoFV0Zs/CBVgt+s0zM2z3clK?=
 =?us-ascii?Q?EuRaFH1TONZISRkTfQgXjwgWzHs/f/KmKQfnA7YUMDiA0Qi3iybBN/90Upb1?=
 =?us-ascii?Q?J/Y1BrwEzRX2SeODZonLVLli2z8lr7I2PWGqYqTG61hXQqD5j/xtiIr5wKCb?=
 =?us-ascii?Q?3n4tfOlptX5bEC6Vei3FqXc2I2xMz29EKhVqwGNJR3ul3/37kCtSMhis7/Vx?=
 =?us-ascii?Q?hBRTxUOeSfUqQolUp91+XtzjWyssoXDskDX/Ej1tn21izzIGbK5um0KXQ4rb?=
 =?us-ascii?Q?bexshFDsDMNQUNvWl/pBauavs7salUfS6QBg4fEkbvOmn1/7yZQ5Zh31fIJ0?=
 =?us-ascii?Q?a4wmCNvox2JCTBmDfmYzYQcD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWKenM49vNJudbZOBYQY72Sg7ZMe2N+x9XyRsfhZi5k1P0VeqRJd9hCFIMfQ?=
 =?us-ascii?Q?jAg8iK/lgM79JSLrDJJko/0R5exLVrliKjTV/hzyUwm0wPdFECZGC3edr+pd?=
 =?us-ascii?Q?JRGBcR8ZmHyTC5N1WXDMDkaNHpPVNLqwTyv6wMxtIbWEc0jff4jxYlWkfvky?=
 =?us-ascii?Q?qFXUFGZarptTSriBytx2imXFCkAtuilphSIQSamjK7AawMRn6Ph2Qqqb1bGw?=
 =?us-ascii?Q?GZvQ8/P4HffXOuagj+9pNWXi2evCBTpmeK/Nz5Rx0wiTr48+roHIgtR/u6OY?=
 =?us-ascii?Q?8BMRE1M4N4QAE5hGw4mVK3ANi9I4ax0B7iNwOe2EnkqCU4ZwYX2MMCSMg0E5?=
 =?us-ascii?Q?CQUWUEG+R15jNTx6r1F1PHCXz3XtTdboTX53KEeY6ri/Wee4vgRR0JZGe/J2?=
 =?us-ascii?Q?QA6CALytUIDs331pJ9hFnp/bXVgZOym39Qo0joZZaGFL96AQE/clPFlONEJ8?=
 =?us-ascii?Q?dI/jMls2w3+uFnM4iLz8jU0bZCImryAe+Ikh36CQhDafa2E2VIrDIi5H2KI8?=
 =?us-ascii?Q?zyN/IUvihtofUkLrUv9UKSRqijHgX4rd9Z7tEi5yRy+aYmlFoKcL2GzMdqCv?=
 =?us-ascii?Q?fBaHnfbPW2EFsgHzEhHZj+B9UiVUt2KnvoGCaG7hleZeae97j5WfhkfQaNDj?=
 =?us-ascii?Q?aggCiXB8kQib1TEdwqeyaz6UO1vBMCWviI+HbH4Z3wfSTxJ9Z8P3OT/Os4El?=
 =?us-ascii?Q?oVzB6DAZjy0XS/BRo8lOdJlmQkwXjaVcZIfasXV8afzhamkATIk79nBBDnra?=
 =?us-ascii?Q?cxZrxL+I6Xq5xglcolFYHqse9BR9Hm+GFOZ6qoRIT5fYSPny3G4hVP3sIHk0?=
 =?us-ascii?Q?3llHI2Y0jgBY4o89YV+7irGUd+tO3qutW/8+Ajyt8G6QbWf6hmocyOBjITqo?=
 =?us-ascii?Q?abi1NiC9MtqveU5i8Vkc89dXp5grabuQ0Yn92778UVV5cyIzRCC7x8OmkYfQ?=
 =?us-ascii?Q?Zl0zDr38YquHaqnyxvDavV17NQoh02nwXdAxmoH6umhxNJ2l/9D1Q5ljGS/4?=
 =?us-ascii?Q?KNNzXujUHI+sJZMiU6h4BtrYedxodoRF5/6jKa6tuF3YQiIzMWEUvEcG7lEP?=
 =?us-ascii?Q?0llC/6gAQ4guWnaj/sWDxRqZA6OJd8875MflBqCJuHmoGLxPtyi32wGMVeWn?=
 =?us-ascii?Q?PNoN1+ECZ3aAP4sJ1e5SIYncerx9ReN4NUm1qeeas9LVjxDhxWNuYA/UguHH?=
 =?us-ascii?Q?Ll1pDdsP0T/Uqx6rI1Q1D0Z1e7NqM8DwN3baD+VFREWDB6Yrs1nWL/1gxKT5?=
 =?us-ascii?Q?0UbruyGGkLWMSkr8ptuFkIFb3jZ33ciT4ieoi8wHfCib8OSZGJWY9hDodi0x?=
 =?us-ascii?Q?kY3wktHwVjLLPhZH6RSz7CY95Yw8sT5kqYIMN2gYkVfYR4exZ/MdLRaRhgkg?=
 =?us-ascii?Q?9VtBAr+3or256fnRqCbJJ9CR86lzcKiW2fv3WbhqcmR07nyTDh8I8pydq55C?=
 =?us-ascii?Q?5ShHJLQX/xCcRp4wiOe/ukOb1y0MA5I5AgXiBFWqOXR34SKXm19cNIhrBpJS?=
 =?us-ascii?Q?0UloYZB1MV4AC22Tvix/H3+mN9OGKvwA0X8HobWrveeCg5thcGCx+lj/z8/Z?=
 =?us-ascii?Q?A9PSuTF5gsSRDM/5PBx2UlWIRV/XM1QA5mT7+G1HnO4jgbFT3Y6npPQdGRTM?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 552a496e-7e95-470a-75f5-08dc8b5323f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:47:18.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qy9clDkYNN0aRg/Ww3TZeNbaVXCE2G5hyD454dUZHE9/1VLXYpKdPvTha47X7eD6pXUfkBx2313GStgHgpn81KiqfivVEosFtE5iZChXXDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com

Nathan Fontenot wrote:
> Systems with a BIOS that creates soft reserve iomem resources
> for memory ranges covered by CXL devices, the soft reserve resource
> needs to be removed when hotplugging a CXL device. Without doing
> so a new soft reserve for the memory range cannot be created
> during hotplug add.
> 
> The previous approach from Alison [1] was to fix up the soft
> reserve resource at region release so it longer covers the
> memory range for the region being removed.
> 
> Instead of waiting for region removal, remove the soft reserve
> resource when constructing a region. This is done by walking the
> children of the region's parent's resources, finding a soft
> reserve resource (if it exists) containing the memory range
> for the region and removing the soft reserve prior to inserting
> the resource for the region being constructed.
> 
> [1] https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/

Somewhat disappointing that this changelog did not address anything from
this write-up:

http://lore.kernel.org/r/65e0fcae989d6_1138c7294c2@dwillia2-xfh.jf.intel.com.notmuch

> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>  drivers/cxl/core/region.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 00a9f0eef8dd..90e5c84230a5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3096,6 +3096,34 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int cxl_insert_resource(struct device *dev, struct resource *parent,
> +			       struct resource *res)
> +{
> +	struct resource *soft;
> +	int rc;
> +
> +	/*
> +	 * Find and attempt to remove the SOFT_RESERVED resource
> +	 * (if it exists) that includes the range of the new
> +	 * resource we're inserting.
> +	 */

I wish it were this simple:

> +	for (soft = parent->child; soft; soft = soft->sibling) {

This list is protected by resource_lock, unlocked walks are racy.

You might say, "what about walk_iomem_res_desc()", but that does not
allow the callback routine to manipulate the resource tree.

> +		if (soft->desc != IORES_DESC_SOFT_RESERVED)
> +			continue;
> +
> +		if (soft->start <= res->start && soft->end >= res->end) {
> +			rc = remove_resource(soft);

The concern here is what happens if CXL region assembly eventually
fails? There is no fallback possible. Instead the approach I outlined in
65e0fcae989d6_1138c7294c2@dwillia2-xfh.jf.intel.com.notmuch is where I
would like to see this effort go.
