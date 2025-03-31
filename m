Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A353E47B;
	Mon, 31 Mar 2025 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463382; cv=fail; b=iNBvn4ZQ9vQ/wVI+jpdKmhBg9oeYucDWNxzIrBaQ1mKvMJk+b4QF/FX2F1TgXhNT5OfCVHjrl3N2rx6qMC248YLTCi+cIzqeHt889W4gzZRy4gzTv+Iw/q2t9SmYfyt+r0/qsNxi67KM4zDWZk3IcT9O2rXLmcaq/QhWk/vJr5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463382; c=relaxed/simple;
	bh=gWFn0r3C4FkjD8HvOMLjYOp5swFB/L11EoJ0rLJkcr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6cwMRXTTTrz4RN4yjf2Ph4kB7vziEN9vRSeuuSQ3octhAyjgwrtM6K7KYBPpkO3Odsvp71PMDwz+qufRtk7Ucas3OK5RHbgmg0prkbJRB6fvwGxi4CqiA62oe0Fl9WVJywGvlPs35PDti//c2/rvL9l/U9qayVEP11l/+MYVhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwQihNrI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwQihNrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743463382; x=1774999382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gWFn0r3C4FkjD8HvOMLjYOp5swFB/L11EoJ0rLJkcr4=;
  b=DwQihNrI1g5gC0BJyF08kiDGmEzx42YHwQiuu2FI7QZu2++MPNPp3B1L
   LDtQbEHKu2zKrfCC2gID2V1M7OPJ3x7R6UT9L1IHCgp1DbNu57JZBQkCL
   7jkVHgSp72yM2RqhVbz+Jq2FtBC1vAn72onkAtDC00oSa74Ztjuxhspdi
   HiRobbs7PVgNrK2QS4qv+FZvGBLW4GckGutUgrg4ZMOgM5fFnXDyNUAXr
   UmAFTae4J8ImW1z1/p5ZKKKpoM7DuLqVEmqzaSReuSX9crPtLAJV4LQ2p
   UM/2/YhObUzKIjpEAU3lrIuRa3q02F/e6jXCjJnZRg0roeL/3GUNDGWuj
   g==;
X-CSE-ConnectionGUID: /K4nrvUUTWiQe1wT9HhgEw==
X-CSE-MsgGUID: HltOQHtpTjuC+1mL1+z0Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="32369920"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="32369920"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:23:01 -0700
X-CSE-ConnectionGUID: wJZTFgIfRPKqWL2FfCVHGQ==
X-CSE-MsgGUID: 1AbpBD7kRrKZ3gr3/XkzAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="163452168"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2025 16:23:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 31 Mar 2025 16:23:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 31 Mar 2025 16:23:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 16:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9E+KG4xlj6+1su57i9Oi8LbMi6qbc1zqi+QNnF3jjw8TMoQYgxRo+aVhMGDE4cXnGxMUkoedckiWaIFKanzOC6Zx/GQsDhYxvMETCi8q20qSA0g2SUP7RzmqicLqwe00r7JzjrU1/rJrL1qnsvVHoc+rYPsQDVj9RR7oGpcRWRF6ZcR3EOZ4yMvRHHmzIA1d3GgLfhsegA/aj4ADthUbdQmiRgdUyi7HH173U/pc0j0iTAKw6AqcYVOn7DGuegAFaZs1dr8EodGtLZ+N1Aj2ZMHLvVFSvDbSnPEuqHj2QFHYtk3pjieVbwD+d5gFOKa1PEVUTsy8Vs215aFjHZ0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWFn0r3C4FkjD8HvOMLjYOp5swFB/L11EoJ0rLJkcr4=;
 b=Kl2OwoH7BGLwq56ktA6mJR84fQsI3J/YuXiqQTRsW9ax4Lf9DwArt85ULURAliM2SpnApmKpLOvGO3wtJQcOZkPD2Q9PGKN5U1d5AZ6NYYBe8jK95cN3hq9sYth8A4kLVC9f9Uv8qqTvoQ+Ma1YMq4t4uSC8g9ulnKKOR061XrpsdxYz67Wx6R8AVfhBOuxST6Yfy2oQ08rjkPjYCAmr+TW7qXU8PUrjZXG4GMKyJCMK5UrVP6AXz1QRkm9TMG7OAv4NEF7yIk1ZWEL4Sl6Drh5NvUiiYWjVMNEXaY/CrqU8PArPJ4UNPXeROFS6s8q0QATbctke7YitaMSucONwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7466.namprd11.prod.outlook.com (2603:10b6:806:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 23:22:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 23:22:54 +0000
Date: Mon, 31 Mar 2025 16:22:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>, <sj@kernel.org>,
	<kernel-team@meta.com>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<minchan@kernel.org>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 1/2] zsmalloc: let callers select NUMA node to store
 the compressed objects
Message-ID: <67eb23cbcd0b7_11987294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250329110230.2459730-1-nphamcs@gmail.com>
 <20250329110230.2459730-2-nphamcs@gmail.com>
 <67eb148e1f818_7baf294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAKEwX=OEQKdoWbyAO=LKE--ssLzBH0UVhz3EYaCiodpbMtQvKw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKEwX=OEQKdoWbyAO=LKE--ssLzBH0UVhz3EYaCiodpbMtQvKw@mail.gmail.com>
X-ClientProxiedBy: MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: d764ce11-aa84-49ed-4823-08dd70aaf6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tKOBcgWM8GlcPQPz8LjIjXPDTZ6s2WpzAymKIqE3ffvrdTUXNyojoWBZ4xQS?=
 =?us-ascii?Q?3SWSw4bRMDu7oDcBLYRmaadyWhohVcOjCkG2vboGhzj02sIs7gOWpuv4fsZy?=
 =?us-ascii?Q?DUc2ggzUkAf2s6h4TjKnepuyrdGQ7ba41o5ybUydMr5B5PqnyHO8GfyiYJH1?=
 =?us-ascii?Q?QTuYB2pgXIlZ657W7/z4zesZvY8WVlIJ/Q/hrYK/CZxWHrOLKxuzuKdNjWZP?=
 =?us-ascii?Q?OFfkjVper6nKuz77OPAOA16GWswuy7yeiAlBR7OFTlwpia/Tn8VhSOhe5O6Y?=
 =?us-ascii?Q?VL4oItTXep5UmZnMW3R9s6KxsEc3mzr9NS9G0ih+f21xXxZXW/ch5PfN8df6?=
 =?us-ascii?Q?tWTeKSsfYywmzCS0mPe6ekgzPLaCTKvrO6EUSfwl8TXetV2VITNf+m9r+hoi?=
 =?us-ascii?Q?V42BN8aagO5FjMLDMD1XOQeqzQKfsK5gH1g0Nn3m+LPK+zKz9JQ9AHPY8PVp?=
 =?us-ascii?Q?tfPMG7kesFYqNfQ4ThGtu5ZqzAFD/Mm//KdgaM+VO8vCf7AGpzPVPUEE7TKD?=
 =?us-ascii?Q?OGznlfQ3FaBh5WFE1gGR5vh1/hKxMq8E/4s2Aw8hdjdVVYuVamTFKGVpTENQ?=
 =?us-ascii?Q?gu40rkDNBFaCWMXW11TeX1wkZWp3JJnx++rKyy0ZpPmEjIKunCC9dLE2dyji?=
 =?us-ascii?Q?2HyKm+Pu1MxonpgUNENWEjN5aiEVvrALXdeBqwWCxwWmDe0Ca7qycTnWIMa5?=
 =?us-ascii?Q?dViiFTAiNSeGXAc0jY5TXJ97KYvrkGMrqotXStWG1TkE5DNSbrMqDvjpeB7+?=
 =?us-ascii?Q?vcpvm/5HSPW00u7HrwoMQwmsajfD5t2LRbZL68PivDzLCKiP2r1hTXSoB1Hc?=
 =?us-ascii?Q?9D1Uyjy2WEvedVVkaoziBzeEfMRdPsiheYH2X3s7XjocQ3veJudNJMH73Un4?=
 =?us-ascii?Q?9KqJb+2SD4uhtrRLrdtnGZPUMWGA2QBQftNknnWGNAOpxaQf1XB9qBvDIEj5?=
 =?us-ascii?Q?BufurAYCREDbgmbM+JM7k98yVSoGtziitAnMjKATTx6T6/sx/i1U3ny2LeJ0?=
 =?us-ascii?Q?Xt4SO2gLyTzZeyAyKFMmLT7+hfL4zZLDqQ2nFIohB51T2Xg8KyW3i0/xTbDm?=
 =?us-ascii?Q?/jblB3G6rr0K4g+aysJtm+KXzcOiPEluG9mrXOCkbno1Heu3N9OXvjVA6qKM?=
 =?us-ascii?Q?wfJHDZBhuS9C9IP4HnJ52JJ1mtQMe4lbg5OJu31kqpRtZfBDQJDv6K179vVv?=
 =?us-ascii?Q?Q8RiGDuNTIjQuEaH8k59qfJjsDnsJkSi3VhT3uvnJV9U7Xo33721so5cd1hV?=
 =?us-ascii?Q?DgS7xL7bkwmiIyhj0HOOMMserbRY/zMh7a0DMCLAEbGLXawCnVaxoedM8XgG?=
 =?us-ascii?Q?zbjypOffWrWxN1i9DAYzZdrPTCQOwf9lCxm9sWKzwsdctCPEVd2p/OZE/Ibd?=
 =?us-ascii?Q?Uikg5Oms8yYv9ImBE3AB960EPhJH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQ32U4W90arUwaBYSR+o0+jULmjYmG8Xr/K0Np0ZnKRpOuIYSCtbP4wgZxMS?=
 =?us-ascii?Q?GBqTvITsCl/NbPWYLRYzVkCyGYvEuNgOITFcUP+J74y+fKB2QWIfH+hKRMBn?=
 =?us-ascii?Q?gFGb1nBKcioKkygj3GnjkpHaacMrAPp8w8qX+9Bh84LuAwJQYYH5tsPW3HKt?=
 =?us-ascii?Q?kM65VnnYD42yjx8CRkn7HC6ZdQhcO7i8QyHgdw9atnsT9WUa6D2FC2LLOJMz?=
 =?us-ascii?Q?FPpVV9XZAm7Y2IDGxN/2X/i/xWynFCk/kN0bcZnqT56fbjcH9o8XU7OZ2Eb3?=
 =?us-ascii?Q?JLlpCWIHuADyqSIG/iNz83B/Al6m7atSnjBQwP9VhJPusSc2dsJ64UNaWhNm?=
 =?us-ascii?Q?m1MDiraW8xCuKkxqtZA9KTwJ0+teESZ8rIRsMBCCYRFv3esaPYK4vprfaoCf?=
 =?us-ascii?Q?iIEGUFqB1D1lNKAjNzDgP7P5+q7nrFLRhow6lJAmsJ1odNdYB+7juZ94FN2u?=
 =?us-ascii?Q?cE41fdaS6obU3eU83Uy34aU+XzAdVHpmqMxOWeeZuGSwLe9QBvZ9MvVuKn/r?=
 =?us-ascii?Q?CBBEqzvQCLE1e6vOoFmXBJqPgbAgOLXaNadlbC5CZSgNomwPcZLh5RoQqGfI?=
 =?us-ascii?Q?QPzJeUklgelLp+ytbXqq9LgOhLJkXKtv3N65YzHtQcp21EHH+n8QrdajRCuq?=
 =?us-ascii?Q?7BdSQQfKUPSJnuooOfUJ5zTtGUnNfEgQLkWJt99xy67muzJTGb68XQUk2l1O?=
 =?us-ascii?Q?GiMUocdpR1ozfNJCD/SR5/ALByaKYk8BAK3ApiAQrhZSzAQtZTP58ihPvQr0?=
 =?us-ascii?Q?EiV+EKD7rvOhiXA5rJACyOIg2bGHukSABIk1cXC4KckrdIpWlt6VJ9rVkj0a?=
 =?us-ascii?Q?1xyG00FdSV2M8M7AtEnWJgFRqRffWw+kRkUL2EmIeYsNLJm6KuH4z77348N2?=
 =?us-ascii?Q?Csx31pzYM3GmwvaitWERsmSRL3WMEWCtN38SQmy9gefTBSYbAvxkd9ruPHAj?=
 =?us-ascii?Q?RH/qgaV7ehWnqHub3C0J+SIW6xJTIt2OPYrFiGmVPmeosYTBk1gJawrh8jDO?=
 =?us-ascii?Q?miqSSpO8Pa0L0UnGhAi4VWY4QZYiDJYGM4hgeUEdpdbjxVEOSFFFZLNd71Et?=
 =?us-ascii?Q?kl0nYOVeGFe08wFQnMBrJpeBvBXYebmhD2Z2vkAU4N9u7MJCbrzs8HtUxfkF?=
 =?us-ascii?Q?C0i3xcRAGEL2S97uU14EdusVWl/V6pvghsBpkjiD204sMXoU99SA2WdH2K25?=
 =?us-ascii?Q?ay2nk3IuRn48OZLuhg+Wa8CYv4U9Y0+OecVmK60Ht7YWW2hxBCuWr1gQ/joV?=
 =?us-ascii?Q?C31TTS2WkZSwPUh96nnYLYAyT7rfsN3j99Z09qJENV9vBP0P8vwcuQIW9niM?=
 =?us-ascii?Q?jAB7g62pNn3qjmpkzG5fNd9VzqND9zH8rmJVQhw0r5SxPjrIAdg5D/OEcJqo?=
 =?us-ascii?Q?g71rgS+JbaFQqwGxvOcUZ8794K1ErhR2DFVNj5kCtPOo9Ppjm/TeXYpBDoTI?=
 =?us-ascii?Q?7tLljQcZPbZyNPAAAMTb1KVJCQ3oQ9tE5JBbhUHTCuL3B8tptzqlBPUuVYFH?=
 =?us-ascii?Q?vMkpp3PDptnQ/FGw+djKioBU7Nw0l8NgoTzVD4WjbPeXxpu8v/8G4avBDFqt?=
 =?us-ascii?Q?il4uQQyIo3qMAHH9kal9+MWnMd6Cz1zroyoSU5Xokz9o+XhV1FNnojJjmTDn?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d764ce11-aa84-49ed-4823-08dd70aaf6d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 23:22:54.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWhqG/iUEGhXj15M+I23R+OtxEu8vKDX+5jdZzcCcDiH8vgPOmUgTX6wfdAg9V3S1R55CRR+h9icbukXqe9JsGP/V4voEgUZa9HyvE/GWl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7466
X-OriginatorOrg: intel.com

Nhat Pham wrote:
[..]
> That still leaves zram though. zram is more complicated than zswap -
> it has multiple allocation paths, so I don't want to touch it quite
> yet (and preferably a zram maintainer/developer should do it). :) Or
> if zram maintainers are happy with NUMA_NO_NODE, then we can
> completely get rid of the pointer arguments etc.

At a minimum make the argument a "const int *" so it does not look like
the value can be changed by the leaf functions.

...but I would challenge zram folks to ack/nak that change rather than
maintain old behavior based purely on momentum. I.e. add to the commit
message an "exclude zswap from this policy for $explicit_reason"
statement rather than the current $implicit_guess that the old behavior
is there for "reasons".
