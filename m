Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99B64A
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166466; cv=fail; b=oKckp/zUHTZKJ3j1UXmBp1W4klWBygF6lJm4F78DJjVXjLP6Ma0oVIvjbLZcmj693kSV82tcgXsXAq7ZktgmM+yHflWULVrhto/+/IMTTWVMkKnvUkbPg727Asxb1Z/HtPd04jHKO8LGSbJlVQZo0VH/mpfb8uMuT/ziPisBeu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166466; c=relaxed/simple;
	bh=o+M60vKXdFt3AJ3BXe0INCoeXA4O9SeM6gX8HY0FhtI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PVnqGVRO1s48CR6BpzF5hcvTxKv30hHj8D03rRqF4lEOibb9ekTPh414PNTDB9i9vqDDKpgUaqzHRcn/m6cdAwvWdHUoKnIcVsDhsv6E6dL8xNrW+HsAtEh4vja0OqmBp5q6Z6cgpWHUqniMwps0WiPS2uSeTw/A66MELbGDVEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhZsb+Yb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhZsb+Yb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718166465; x=1749702465;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o+M60vKXdFt3AJ3BXe0INCoeXA4O9SeM6gX8HY0FhtI=;
  b=RhZsb+YbL/lirV5wWTU0j96RrxBfGjLZJhQBwBNw8GT1Wpfcfnz5Snip
   CMGQroofGcgE1Jq3EfJe/1lA0NiyCecgFFEjHT8q91RjepWXxSyJNRNLZ
   RcFtizhqazebc70Y7Lw7R/azbCkeJq5/SY+2qnjGdTEtAw/fD9H5dJs5S
   xbKgtRb+/IWeZsFedQTwRKfhbyDQh3oJXeFKD5pLV5rM6yaFn1j4zHp81
   oE+rypttvtl3VADUJuMEKSrcIabGFAeYPD08riu2cmGWDdhpDqDYkztQq
   xQu1ddXPiku/cfgHDD7cXgptK1p5bt2809g+B1aLFwZyRNu7/qV4vQ5ab
   g==;
X-CSE-ConnectionGUID: 4pocnrqNQ1aRm8a9gCi2hA==
X-CSE-MsgGUID: wgPytuSKR4OMxaT1b2Ab7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26319708"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="26319708"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:27:44 -0700
X-CSE-ConnectionGUID: 57OGg0wGR9S+kZ3Rzpdw2A==
X-CSE-MsgGUID: gDZsOvVOT/WrMJDrnBw8pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70451212"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 21:27:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:27:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 21:27:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 21:27:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLUeY0JSWzsWJDu7mFRkhMVZIfOJeHq4q5b9cryFVJU0dtLquZNBYhhw27VK6G/L2X01YGTbRFA2F0asPHc0Xk3eW6iIYEfrcMbH7U/Y9b5N1mpOGNOUBwHR+fCHL49shNoNRPKdZWxPKiIHaYQ7Dst5Y2ne2KsSEg0xjzeIwtkw9JyyQQjxTXPEcHIyUsH0v4H7R7Vy1ITFuHvgC342mnIKBZJ8QOnE8pfLzImZ15VyZUqoOrqnX2Ct6tpoN2RsRUVl2Jl4sl6NG/CROHvIR4ELi/O/dYTIQeOcxu/OXcSvDfY/PNsAkfBxzh/t0uZa2FIaood2yv/g81Hdt50FSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtPRs35SLrxlHZvCiNVr12JWNwPPzXdoleFhEZ/QdBU=;
 b=VeKa51tFzYecSQihDcgUE8QD2biCgbpIuYGy7ZDUGZf0dXtp0nl69oCTNo4KVNUYob2chFWrXXbEcPrBFBTYJ7zPDzqCDLBK5R2pjPOib1uWOWbP8gX3CrmJMWj8XFASM460g+muK5xw2JYZM3LD5bqzgBXXnbc4DrzpN8Bs20qzcAXGNEYgHVMbGoOa/TFGSGXosSdrVnEApiGtvH9oB1ddTJemfftXSGMRqvsGU/6tqASchxs+PZZdaUSBDMarxN04/eLQR76BAb63Npll35HfDpKC0//1qaU0oLxNUUOVNb+eYqmq8cnV4ZDLYi+uXkmi69SXg4fff3yRjTyxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 04:27:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 04:27:40 +0000
Date: Tue, 11 Jun 2024 21:27:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <pieter.jansen-van-vuuren@amd.com>,
	<richard.hughes@amd.com>, <dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Message-ID: <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516081202.27023-2-alucerop@amd.com>
X-ClientProxiedBy: MWH0EPF00056D17.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1b) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 99667566-b21d-47c9-3d98-08dc8a97fefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r8lYrCfuuVho1T3uRK7lri9Qhf8QNNwjCPjJl4c8Bod091tbulEEhpc46qnR?=
 =?us-ascii?Q?qjar2RggGvJ8vphy2DomX/q3j2KU0/hO0YoO4orWC42rLHfvWH9ockkAHsxP?=
 =?us-ascii?Q?buI3k/6N14u5ug/Pr9Sh75zKA+RsojFcdtNttw0kjzkLO9EFkcEqT+PL8Sic?=
 =?us-ascii?Q?HBBfhtVJYcjE35yJ5LoEG8MdapdsOIfwTtqW4YmadsnNzBs4pPzuaJ8Vlyb0?=
 =?us-ascii?Q?jZW6VSbkuI0IfzhAHzRDLYE8u9lSlGOOHa8uHDE1UcYukSqJV+QGPYxgxwy0?=
 =?us-ascii?Q?nlX/+WJpX1JmR0pFVSb3KefsQMjMjLMRgwVzx37uvIWDouyZEiGGY1FKf/oe?=
 =?us-ascii?Q?7Lrbqz7OPXh0M/VPlAJYLsYXKqmPyj+LKUkQf8vIYuNjbDN2M0RLwdcLDSqe?=
 =?us-ascii?Q?yKr93aOv7eOElQ3mO90b3FU5OOvUNyd4zEzsQe/HnHbau/rfeNk6MGbLB+LP?=
 =?us-ascii?Q?c2ENyY8OoF1TJO98hoc5rdiUHNy7vM330/FB/5z7mgrJ6YdOr6vgrk/c3CxK?=
 =?us-ascii?Q?wX93l8TkY185/fhrR7P4z0agYSEC6PMtTX48aahrvB5bMyYu0UlBhGECwFfK?=
 =?us-ascii?Q?eZzDkjiufsLBBPvRmRXOBdbZpaTevuF07aZmVPRiCzf779HTamiVClW1qLFy?=
 =?us-ascii?Q?Agrt72aTePGM8unM5Oj2feoHpc1nWcld2KcdhV5bESmxjsKMW8xbMCctx2B8?=
 =?us-ascii?Q?3SlIoyksltx0E1BZb/bmGhrAbdF1ipq5fZ4Br//c7KUaVvz13C9zaYR5FJ4W?=
 =?us-ascii?Q?0CER3r0vxAfMvuaxY871n2nDjxjFrVE+OqnyglgMR0lkWEY4C44Ky3jQFL0O?=
 =?us-ascii?Q?ACwUeAC4jtQ9lh9KOktxuxw3YjFvvfPickgaAa8OjGToB2O+88im+I7+Ma2p?=
 =?us-ascii?Q?3Fs899gGqKT1nAyTT7etYFoL6VThNmhnSHQAj4oopYdJDZ3GlWqFHL9G1i1s?=
 =?us-ascii?Q?CTOLmbIu0WzYBCtkFvE3WHoi6GjpGxQuTM6Cx0bPAcWCGZYwTLTUAQvloG43?=
 =?us-ascii?Q?vBRBbFTYMIy1pp/sAu/qtq5kjn6d51BN6Q96+i0GilS8MLP8I0Kc/+fkrvfH?=
 =?us-ascii?Q?5eyBe3iS5McD+sVFDr8HlMjUvSSZdRUFFioxGTmrBkdf4ZjRlVqHisuaOgxn?=
 =?us-ascii?Q?Op0UYQozIhndPLDcto5H6l6G0JaT5nMkuSMJwOuHTFV6owHREe1t8hcIQ4m2?=
 =?us-ascii?Q?Bmv9U50DF0TwUJ7Iikk6OEO5pJ3m//rMdH4ZjS4GnrWQZQO2B2huMFrkMK5g?=
 =?us-ascii?Q?b9/a5if8TYdRjYB0FrrJMZrfL6kgGs0xQJTIciTpo4VIstLUXnaNYSh67ti8?=
 =?us-ascii?Q?p+c5HpcfVvFJbvTA/nLR8szB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0W3MZ2BMXPVoUllDuhq3raRjp+Z6dznKcQKwrUhhFSjKkIPoslU5cD5rV8F?=
 =?us-ascii?Q?eO6FkWaCUhAkydPLjkDQxpW3YpD/7+ddvp9LKUy5tF78WioqFOvTRj7Ou6Ye?=
 =?us-ascii?Q?yOc75dOVHya32CyHW7oRM6EcvcmKAp2prDX5dCvoaJ3zhE+RRV9TOqs1WEO4?=
 =?us-ascii?Q?90GrClGgYGytWbHJdQmJz12Sd0u3pbVPh9E+gybIjtpkLRxxYLU3sLuSj4Y3?=
 =?us-ascii?Q?6qywFtVteHz7jVUZfyErM1OLWF/78O/WhOjsk4jage5wZF6BElWMKRcCoMuj?=
 =?us-ascii?Q?Ge8RmwNgti2dpA0Oytlqk8pdNJx8TNUjwKXFdKigpfovBbIpfq/sELfZrp0Y?=
 =?us-ascii?Q?f5WesMnIG70w/O88cc1OBvhS6gUAJNSGAuSVv3RBkYDfUaM1djwkKGpeTCj1?=
 =?us-ascii?Q?UxdePUIESOcKTVO8G5f4b6qV4/x08l9m0N7B16urH+ZXzfqxv2pBrcuKcp35?=
 =?us-ascii?Q?sRcbX61/Y6mVy8GgF9dbBsYEO+/LTWJQF++VplIKaDZj0EqXHIBl5uWyd2wW?=
 =?us-ascii?Q?/QU2XxBpkg3oTnAqpte92UyAwTk7hSzHLdaQBAcrMSSebQ5E6SEXPm0EBVI5?=
 =?us-ascii?Q?ZyUh5qjawTzXw0tGRk1w6+JepvUOy6q3nLKJPbBOlRwkZ/kzvKbaVmG8sbwR?=
 =?us-ascii?Q?q92P+5+Ls60J2lLvGLyso920CL/Lr4Sq/CoXwP8S3Y39wE2CCedwH0u1R5us?=
 =?us-ascii?Q?pKJ3DGSAhf1CGcQrrxg7L0CvgjeWHkGGlGNy9vTl2KIeCzRiK5WNwuAqPIo4?=
 =?us-ascii?Q?BJ6uP7zR0LaT/LC24lO05f83/U9Khsmt56EVXUUPhRhDQ7hhtLv7wPqJHy/M?=
 =?us-ascii?Q?C+VmbTKA3yLsVGgKVSf1dUskLbpotDim7eS+rVFSwCWuxHfc0b4Ok+VyM4ya?=
 =?us-ascii?Q?m33oGE4ht4TJbvnZ8nlUlLWbo1k77qbvhGElMIG/Pu9vZTS1TzL6YXu+F6v9?=
 =?us-ascii?Q?BvxBCqZCsK3Kexr6+3caciriFoA6BN04SQNEzr/qvgyz7Cqm6ACT8TF4hCP7?=
 =?us-ascii?Q?khDeN8XyeYBfuC2QGcWA/dMvsBXxv2gY5sxQu3UpARdO6CfoFNMFgBZkEBBr?=
 =?us-ascii?Q?IK6ISISYAvy9bmNwUWlBUI3fQj/tkvAY1BT09D8uxACPHpP1GQ/a3KLiWKCR?=
 =?us-ascii?Q?jbOMkoovWWstPzWaeQ8ToVQjg/KNFmaNtjzKjoghiDOmGEmtr4j4uZauF64g?=
 =?us-ascii?Q?UWeaT+2MOAcBX4xhYvjPx5leRiAjbLgIyiLbkRlAulBkZNqAJdVu4axkiBWx?=
 =?us-ascii?Q?EQWCxFWju6uQph8blDmGpWwsFokSj+XEpr567q6UiUggWukfajujWnFpc3Va?=
 =?us-ascii?Q?pz2quAzaQfeeURRnD+sXKohzfjLZMWphC8CJQAiEKOQ6/n1WyIpvA5dTF14c?=
 =?us-ascii?Q?uyLqat1rqgSFe2V9sr3tKSD7UbNkotkzjMNQrK0PbugOh4gLYhXxcxVvKiyq?=
 =?us-ascii?Q?koGu/K2BR4WbK+qz3XB+Ewy5NRyIUUmvzZsF8+biBzYnUde6xYmhMI6QTUAo?=
 =?us-ascii?Q?z5MxLmCh8VuP9QxAQ5F1Ntt7ZcdpJdkZCtJ66Cvu+bzknOS6SJBOc8f4Hr+o?=
 =?us-ascii?Q?u25tTs72eGtYwzQRecdh1TMrIG71VpTrk9nX1pcElsUKFEmFN3L8bfItTmUK?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99667566-b21d-47c9-3d98-08dc8a97fefe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 04:27:40.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Efp+HzzSXHJACqJmi1kIEDZ6eMvQybYPNnfV92ZcFQlqelF7k5Wx0a06fmEIZxs00Y+rGh/2zM7OMtTa52Fe6iH/ZfBAmVslUypZQWv4s+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL Type 2 devices imply specific vendor drivers binding to those
> devices instead of generic ones offered by CXL core like the PCI driver.
> Those drivers need to use CXL core functions and structs for
> initialization, create memdevs and create CXL regions.
> 
> This patch avoids referencing those files based on relative paths from
> inside the kernel sources tree.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c                      | 4 ++--
>  drivers/cxl/core/cdat.c                 | 6 +++---
>  drivers/cxl/core/hdm.c                  | 2 +-
>  drivers/cxl/core/mbox.c                 | 6 +++---
>  drivers/cxl/core/memdev.c               | 2 +-
>  drivers/cxl/core/pci.c                  | 6 +++---
>  drivers/cxl/core/pmem.c                 | 4 ++--
>  drivers/cxl/core/pmu.c                  | 4 ++--
>  drivers/cxl/core/port.c                 | 6 +++---
>  drivers/cxl/core/region.c               | 4 ++--
>  drivers/cxl/core/regs.c                 | 4 ++--
>  drivers/cxl/core/suspend.c              | 2 +-
>  drivers/cxl/core/trace.c                | 2 +-
>  drivers/cxl/core/trace.h                | 4 ++--
>  drivers/cxl/mem.c                       | 4 ++--
>  drivers/cxl/pci.c                       | 6 +++---
>  drivers/cxl/pmem.c                      | 4 ++--
>  drivers/cxl/port.c                      | 4 ++--
>  drivers/cxl/security.c                  | 4 ++--
>  drivers/dax/cxl.c                       | 2 +-
>  drivers/perf/cxl_pmu.c                  | 4 ++--
>  {drivers/cxl => include/linux}/cxl.h    | 0
>  {drivers/cxl => include/linux}/cxlmem.h | 2 +-
>  {drivers/cxl => include/linux}/cxlpci.h | 0

So I don't like this approach, there are details that are private to the
CXL generic memory-expander use case, and some that are suitable for
CXL.mem and CXL.cache capabilities in other drivers. That distinct
subset should move to include/linux/. I.e. I want to see the incremental
conversion of what 3rd party drivers need compared to the generic
expander case, and consider when and where new shared infrastructure
needs to be refactored.
