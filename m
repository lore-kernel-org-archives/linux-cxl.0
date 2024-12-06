Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550B197548;
	Fri,  6 Dec 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471463; cv=fail; b=YL4+cCo8N//Z6uszvY8W0M/HBgL4Smj5X+l8l0psghVN+PYyIECCthR686xjBYEk2Mq9na5acWXt5myaAaj6MfNU8Y0NBf54/rTNbiLv5Jw9FiT2cXaIeYRJ/ua1nBypMSJdwNncBCyd0uz8tILs7SfZ73ZlCcBwqXiuTNadFGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471463; c=relaxed/simple;
	bh=IFgT+V1XuK6aet/dSYcLVF1+A8Mm1Y1eGPCEmQfSzx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Znf/i8ehzFvdHx3LKpa5/BNTiAiqMEPAuF0suNrN3i4v6qfmcThud7C9cWdMyybsHsOWAwbm6SUl0k2ELYqpuaveIuwZLCLjUtsfLXGfWXWlvLKGpnP0y0W5B5TBl2OGIwfV7L1LhG86RSIGnm2ZC8xs26xHqDrSQM5pC5pNYAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI1XjUEA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI1XjUEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733471460; x=1765007460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IFgT+V1XuK6aet/dSYcLVF1+A8Mm1Y1eGPCEmQfSzx8=;
  b=QI1XjUEAyWsdjXU2BX+WLuvllFzdtMS2TbyMWrjd5TfPOKYfPLPJC5vQ
   E8E/Be1cmJjoHh6uLnxDr3wibxyC1OZ7wHMKoAi77KuhGf5HEtYzzl3bQ
   cNJNw64lCuQLIbug/BY6TBLpD6zg3+VHFW7ijUtAczwDWmZ4Ucn/AuzGE
   Z0Ac5/9ttR+duzFQiCuYMnlMOJt8HytNVpTJ5ymMr/MQFRowm0VukbPed
   zQptV0hP85AH3bZF9QbNxif4NG9Vv8I9UFUUdUWRAu2tf236+G9jvx/3C
   q9p6jEuKQkCxxVYkowymTKBTYHBCnbyW/J10RE62GGsUpvGlQ9o9eINDl
   g==;
X-CSE-ConnectionGUID: n9mEvH51QWqssHOg8vIV4g==
X-CSE-MsgGUID: 62L9L6BHQ5CDlxIsjWv1wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45192223"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="45192223"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 23:51:00 -0800
X-CSE-ConnectionGUID: OYx+GhFcQ+me3QOcg1uAKA==
X-CSE-MsgGUID: vCQD+OTFQVOs3P2VNV2ZKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94141750"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 23:51:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 23:50:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 23:50:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 23:50:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSgBVSElvmcSiowXXW/AxWZ7YLnJpPynAnRapqUQkaWfZFrH+tFEw4WnKooNFw7xTXrSX7R7vPlW36ttuIA0tOJI5vCFIHDYkPJHN7BM2apVT9G4n7W9pYUv2Fit+gwsUTaA59Qe8xrrzwq4ri3hpzpVZvdOSUekj/p04GCClE1IzHw15OiuqLB77/aTbrjMiGJ4wcFbhBHm3foc5JK7q3MGFlSfxSB+SXxOPzlEtWe2ra71DYkZm++uCQCg+vt9ExJtjc38KbLCgJC/pc5XvfrH7laCNAoaBc3Woy7xFrxLGT0oFZBlJgogZpr5EEaoS2aFhVm6/iCQMchIYSqpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaBxPUD3j7GV3+1RG+22CFgP3DrePUpfc9eKtOWncx4=;
 b=DAmSL0RyZzpq31I47N0dlh+8e/5g7jS2Lmt2+PRzeSSyIH7IxlhBRkye4yCdYrQCT1O2p/WQBgoaMkbSEZGre29Fb/KYUiuAyNC5hq4LvsAoGh6nYj8AXeSfN822DREoH7VwS6731h/Men5tdzyLVunwuzWtqRGTj3wng/Ddk1PFeGj0tj6PKCGaIrL/rvawlogRjr7smFgqTRPLXkj1mdTm94YvBcKtZbr3JZOcD4/9ILNChCfsB9Fxckxk415dOi+vFkuGRRugCO+cYGMXe7oMfYgYRBU0CfxsCTFkHsvlJ9ww/Zpy6ptVfEP4m4k8beGGpeJ40oGIpxUCEHBMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 07:50:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 07:50:52 +0000
Date: Thu, 5 Dec 2024 23:50:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <bharata@amd.com>, Huang Ying <ying.huang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Alistair Popple <apopple@nvidia.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Fontenot Nathan <Nathan.Fontenot@amd.com>,
	Wei Huang <wei.huang2@amd.com>, <regressions@lists.linux.dev>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
Message-ID: <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd4e36b-d9ca-4e92-47ff-08dd15cab535
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LzxmoHfQZ4iez0k6BSJ73Ikcn61/1xCXcngKvNRM/EJErtYSpie6WgFFaED2?=
 =?us-ascii?Q?By2vxXXRkfibgxRg4cFXQlUrEWx93NbQepH8eckb8GIlwAt7pioV1qDFy4ch?=
 =?us-ascii?Q?LxU7cafc9qPeDseUJjrSTl6O5G1K37wjk2Po39E4CMAnglpfKFMSmr9WHKMz?=
 =?us-ascii?Q?XZmS7htIIikp6aGQbPX1tHEs+e444FuOx6Vs7l+zDDX83yu8kBu041PGCUSr?=
 =?us-ascii?Q?iZHQzLEPLNmRG/FdFaNxqjZ5+BBRsAJ8N4PmyWz81M8sjvZVD9Jgn+5PQe2y?=
 =?us-ascii?Q?ZwglOWZO/39rMThplfJGgSmvi9wYUI7uQfdIDuxgJTl8wlsT2FNpoBaPUFMX?=
 =?us-ascii?Q?oUnNkY8sb+cUVN3qvkLQr3oPHS54CfG72F3if4sWqeYp+IAAO6ecTUt6apZ9?=
 =?us-ascii?Q?jQZEyzuAedojJy8th9vcAJipcvQN7OWgSX0+PN4/0ZooltiwhRkRp1QGgm+6?=
 =?us-ascii?Q?DFAoPX20UX11DKPt+l3E1Y2JapXHmTDOcvrw2xa2kB4OsWgaZOFPRT5JqrN+?=
 =?us-ascii?Q?pz+TIiWWSPBZaGY5ow8WtF5zXlsG5eBPgoXTqsFssiTvM8Y9Ffj+bQZWrI5d?=
 =?us-ascii?Q?3CtpxVYul0LogE4t8+wiw0TBzOXHR2g+oxlkzzdCOwawV3FpS/0/DFcj9cSx?=
 =?us-ascii?Q?QQIq9zmD4XjfAKhfcauYhuMfIxmgl4vJzhIYtpeLr3esLi+hVSWEIGQcw2kg?=
 =?us-ascii?Q?bLWBHQ3dBM44bE/doJADaEbMMDPa7SzenDt1C/nIV2rSx/Y97OchNYv0uzej?=
 =?us-ascii?Q?aZMblhVG5YflWCr1rJD4c2ug8oDLVLfcwitxS2qkBeEBKv4tPvve7oDkvFvs?=
 =?us-ascii?Q?zzqbo80b1CJnj7I/ARTmRkv44JYH4PNFYvNYwhvYm/PvxnrdvZoPhmbR4ZAx?=
 =?us-ascii?Q?X7vCDvgLafNuxxLwLrWQoC/kcs4UTFYLsVCc7jBvv1HueBpKc1x4m8SfaK5c?=
 =?us-ascii?Q?WvDDQS9tKqw8ZK3xbm8nfmDbrzZ5fEIb4adNiZY3DG4IPC0aI1CIM340lNZg?=
 =?us-ascii?Q?xEOpXQHkB61T4c5bF/+ZRaVQzsa22tVazWOAyFk69eBUDtiNFWoAuCisOdki?=
 =?us-ascii?Q?k/RNOnQXC8T8EfqhOofQwo3YPau4wYU2bg9tTEc0cVDA30k8qx12dijQjW7N?=
 =?us-ascii?Q?8gLf1iLdSNF3tKxPOHUfH76n7m/6i6LTonTq8qoo5LikEDTnEi3r8Mrmq9Hb?=
 =?us-ascii?Q?1na0AgU2x3VVEw7RneWlUAU2G1mPmJB2+7bJf+j+/C6Jdy+27lCx4+DPeJWl?=
 =?us-ascii?Q?Gcg9vReXr6RCRztV/8L7ZwUFcZtxRZ4fOS1EcnqU03XYI/VBGKxMBAvS063z?=
 =?us-ascii?Q?Agyf7I+uB+nhQtqNDJI1QVwu+XrA2v1C+C0inn7n3uOlMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oUarTb4BA4SJnRppEPsLRbdT6YjY5lcbzbBm2vyGV6dTPBHsPkMuZeJnblIH?=
 =?us-ascii?Q?b2Rhu0HywUpI8Y+nlsbU8WAu9rhKUOgVmytJrVaxMWwzrgdmQZb2uZwtcpGc?=
 =?us-ascii?Q?OLy64vzlRxLDN3y3QGlZJvbgn/4TVULzpsaM+OUP4rLoQohU4Sw+Dt6m4hVl?=
 =?us-ascii?Q?PhVlL4rcDai1at4Q1mFl55nlITSXk0RyGz0lbK3JkvDUWzsJUWiWrKVvqx++?=
 =?us-ascii?Q?bTZTzT0fj/UbpXcDkE2UVFRYct89T4l4yw7toc4echWkXv8XNEZ0cPBvPJaP?=
 =?us-ascii?Q?D3P+Ban5x4o0is2RoLptT+CbZ/657xGWJ/gWIUHKdiFD+eIlu/D+TWipqLzp?=
 =?us-ascii?Q?k7FWdvJrLGz+akw9hPQCdEcwLTcRCCWooLNbkl/H6kF8BIwIQrjG43W4xXWX?=
 =?us-ascii?Q?n1TgyPQq3XlcyXN92Fg1z6JE+9uU0B+Vo8loKXQlhPEqDOzyMdkjliWnppXw?=
 =?us-ascii?Q?ADmmGg9hxGffesmH+x05o1WzBdqVmD8BlbIkQ8smMO2OED3w3c/oYcKxDSDN?=
 =?us-ascii?Q?WhjhuDmA8Pam0iPaHSJ+tsGdns5VHNHRFfTPBMuG4ThaJEEwgEpjpuWWc/P/?=
 =?us-ascii?Q?48nyktwckogriFK05exhGXiP8lECC8y8XFmgPHy3zlfnGE+Ym0CAbjsKGIB2?=
 =?us-ascii?Q?tDPkq/bouyj5mOO4T79opSgt+Z9xT0kdvqWv5F6LGY/mF4zTmRyB/dG2Qyg/?=
 =?us-ascii?Q?XouZB9gxN6o8K1128ehRiw12LcGY31Lpie2IqlXMZdAkQRn3AvgYja347ykz?=
 =?us-ascii?Q?j0A1Igj1xez9THpQzI83lMCniOeJ8DAyQ+lxoHkEktrk/YgEtbgSkoebjiU6?=
 =?us-ascii?Q?8Geylgda064TMhnioo+pbcruT5FfeZ+wGy2sMM6P4Bh3/+Hw0jXCt5USp+NR?=
 =?us-ascii?Q?UZvNjJKe8+tIayGSR5UOcBSz82Sdt7QqxtffKUc1Co8H4Pi7G/zAyEHi2X1c?=
 =?us-ascii?Q?88L6rfKvl9CbdbC8wacuDbFig0QpwQV8IPZTKPS9lAFnNq0rmwVBizRYg2WF?=
 =?us-ascii?Q?At91nEXG15Vo09a3s1iLwSnZSwDe1BprT03xjApbEbj1Q3Vl5rK694Uu8c/+?=
 =?us-ascii?Q?yP6v82dtsPv/ysMRKQvwuaPBxFLOpSJOyySL8kxc7nG1D5qCMmEBdr6168OH?=
 =?us-ascii?Q?ArekhCP0vG4H7rYApJK0qeKrW3Pty7+fzCQovzI08Hpr1BjayrshuHhRGHjP?=
 =?us-ascii?Q?BY3OgSlsY06BkwRsdLICZotaUHCnfWg8L7Dy+YfE+xzLjKiToKMXBQbmn/pr?=
 =?us-ascii?Q?nJv+n11UZtbOQKd9mNDd5RKqS7TiKi5a+jpjeTurSM0EwgD5c59jhadg6gIc?=
 =?us-ascii?Q?4vN2DGU3FPd+5GnUp6FP3s7zHFrmkMw1Wodks7yKHQ89Ky2fujWW+UzKKITl?=
 =?us-ascii?Q?uZ987t0ij21psxZA4u13S5sPT7ByDiYS8cP8r1Oxwmzh3qiJJJkUSiFKOTcQ?=
 =?us-ascii?Q?HEUj2SYMZnxfj7YugcXOf8jnfipmwdcLB8mJBR6nny1mH/nQRg3AAUBAAlHv?=
 =?us-ascii?Q?RNZbwMv1ItmQJ1GJcHkQ4vR3QFJfwKBqayOXOjb1EOydPJCkCDGNGCDu74lJ?=
 =?us-ascii?Q?VCEcpaDrZXxcqFcXge4KM6oEy6w06yypW8yOxmmkInGW3fOfgPaEPUNPuIda?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd4e36b-d9ca-4e92-47ff-08dd15cab535
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 07:50:52.5642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xTij1nDt5nho8xwlu3lZl+Gt863RffkRQqjjxIzaNnB2CQvOGN1c1ikSunn7psMOfhNFGtwBb1x+mu+NRBRvzCdOIa7tOOaQqbJRwb0u8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

Raghavendra K T wrote:
> 
> 
> On 12/4/2024 9:25 AM, Dan Williams wrote:
> > [ add regressions@lists.linux.dev ]
> > 
> > Next time make the subject of the patch:
> > 
> >     Revert "resource: fix region_intersects() vs add_memory_driver_managed()"
> > 
> > ...to make it clear that this is a revert, not a fix.
> > 
> > The revert should be applied if a fix does not materialize in the next few weeks.
> > 
> 
> Agreed regarding fix.
> one thing to note is it is not exact revert.
> 
> > Raghavendra K T wrote:
> >> Before:
> >> ~]$ numastat -m
> >> ...
> >>                            Node 0          Node 1           Total
> >>                   --------------- --------------- ---------------
> >> MemTotal               128096.18       128838.48       256934.65
> >>
> >> After:
> >> $ numastat -m
> >> .....
> >>                            Node 0          Node 1          Node 2           Total
> >>                   --------------- --------------- --------------- ---------------
> >> MemTotal               128054.16       128880.51       129024.00       385958.67
> >>
> >> Current patch reverts the effect of first commit where the issue is seen.
> > 
> > Might you be able to dig a bit further into the details like memory map
> > for this platform and ACPI SRAT tables? A dmesg comparison of the good
> > and bad cases would be useful (those can be shared via a github gist).
> > Even better would be some debug instrumentation to identify which call
> > to __region_intersects() started behaving differently resulting in a
> > whole node disappearing.
> > 
> > In terms of the urgency of fixing this it would also help to know how
> > prevalent the system this was found on is in the wild.
> 
> I have compared dmesg, proc/iomem of both success and fail case.
> 
> A. dmesg:
> 
> 1. Address ranges is different
> 2. extra message about printing Demotion target
> 
> Fallback order for Node 0: 0 1 2
> Fallback order for Node 1: 1 0 2
> Fallback order for Node 2: 2 0 1
> Built 3 zonelists, mobility grouping on.  Total pages: 66145521
> Policy zone: Normal
> ....
> Demotion targets for Node 0: preferred: 2, fallback: 2
> Demotion targets for Node 1: preferred: 2, fallback: 2
> Demotion targets for Node 2: null
> 
> B. /proc/iomem
> 
> $ vimdiff success fail
> 
>   4050000000-604fffffff : Soft Reserved 
>    |  164 4050000000-604fffffff : Soft Reserved
>    165   4050000000-604fffffff : CXL Window 0 
>         |  165   4050000000-604fffffff : CXL Window 0
>    166     4080000000-5fffffffff : dax1.0 
>         | 
> ------------------------------------------------------------------------
>    167       4080000000-5fffffffff : System RAM (kmem) 
>         | 
> --------------------------------------------------------------------

My eyes only know how to read unified diff (diff -u) format. Is this
saying that in the failure case the System RAM range for dax1.0 is
missing?
