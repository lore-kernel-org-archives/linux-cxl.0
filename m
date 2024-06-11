Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8D757E5
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718148435; cv=fail; b=DIl7yciT3Qk0eQ5QSGYoNLah6BGEQ1ELEQpK6uW3h4lrNiZwbBPvWsjcrm2Oim4kc00G1VCX2+DUow8chALqqA/dXBFBhSJKI/wUeJDhb34Xv7KLAKhonyPFYuAb4fkt+7PBT13QBLpAEZ7NvDTRwAnKENjCgGQI9Zdi3H0JaPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718148435; c=relaxed/simple;
	bh=olLU9wZbasQD3pHJM33WY0mVmJHWbHNoaEmqrJG5VGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EjcPIXi75JpX8kDbqDxZczGmemz6bGUQRareZNdyRmC5Qzf3jBA7Lm3rcwFxSiNjuTcK+9OKmn6Uksmb0BRa1kRbXbvCEqAHR1H9y13vWznxIkfXxXsmfrExjST0sv4suTIpcgpDh5iNuytWSs57ruuxPoNioPp5DZX25zgLayA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff8c2WcQ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff8c2WcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718148433; x=1749684433;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=olLU9wZbasQD3pHJM33WY0mVmJHWbHNoaEmqrJG5VGA=;
  b=ff8c2WcQpad48zpcv7tEalmYRY9lDC0sGdVSY0io92FxNNywJ11qZrlg
   IYOJ/2LelNGUbvvU7WrXg1+NETG4WkyGJm0PMuL469ypLu2H82Q5hqEmB
   gjFgHDi12vHgZIFKKwianHwfgwU19RyT7cx5Ue2kztxtxoLvQCIaUmNjx
   B2OfUfr3cOcTCMbMLB9XV9jNpYsV4n0B1RrqX21OYJWk+csoVh9aSlbLj
   Dk1GqttEMUaNSaLcoxpMN0yMCWChTt8STpO9VeGQZ/xHVobIGwl2CghS1
   BjOHVRkpIJ4U6eQajMv3PtYdBJeVbcYs+dBcnm/1W44t5DcmSeIgQVzQ4
   Q==;
X-CSE-ConnectionGUID: 40wE9XTkSruaG6z1T9FDPA==
X-CSE-MsgGUID: 1kij+f+aS0iPq6pg1jcBEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40294654"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="40294654"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 16:27:12 -0700
X-CSE-ConnectionGUID: 7s5Izg+vTEWqKdZ34RMOXg==
X-CSE-MsgGUID: /PiFqcJjSEupkl6Kf42Haw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="77056761"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 16:27:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 16:27:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 16:27:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 16:27:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjIDiWYPi2fqKvYkXsaYwWoBhxgaAAdNl7wbOWlprvHXeFeqgNYc90Ka1xI2p4rDSuJDqYKJpdDeblKrPeLj7SWiAKr1Ws5pWWSnfwG8MJEHfGwNr+J727Jt7WVjWGE0ioC3Y42bjalbNevs/hYHuYKaxRuPJKky0SydcSTB2SUc7J2eSmm8OznxByKZ71E2FVW+yAvwbcJiUkmGDeo5z93cQ06r3cW+aTbxdgw5DqLv9OZmsSWuY0EXQ7NOtOq3M2V2NWwjwlu+ljFQGbj1vUWjB4Tsv3Lh3CllWI1xhvKHYOF1yrN0elx+1BHzfoXDR3fhGQ/4c0/ON+K+4ZoaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37JQU6Y9UZeEkHmnciLsv3txhJirYFjWHlVU8StJ08U=;
 b=GTW/rnWvv190WnFb/qBluIfwRX0KLCykudiYQwZaI3b9yOPg9yJgJC2Fq3hPlt744VMebvedNvaPPQ/nqhymow4bS1rvuxbBDAojMtQUVZtHHiiit/7cGG2uBQA3/e4/VFiAWciABHTMYXxlcewVbazXvLVU6800bocFYfSgKpwZO9Oo5LCjmOguFHa+DWqUOSH0ipRfsmU6pVgxCCPZTpyfTiOTgXJ0P4vr1JamDW9rt6O5pQKdY2/ySuhv+doLOD9ktSxq1t3m3mwVUQ6U+a/jH2FG+i/yIMfa6Cg6Fj285DOYXxcRxHbE+iLfjmGxJTnnViAkB6NxwUegM7MU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 23:27:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Tue, 11 Jun 2024
 23:27:09 +0000
Date: Tue, 11 Jun 2024 16:27:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6] cxl/region: check interleave capability
Message-ID: <6668dd4ace491_31012941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:303:dd::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f274d9a-2dbd-476f-c93e-08dc8a6e036e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UvsahisEnIla5HQjosop5ts/yGJidbOo23C/9uCEWEgIf/nZcxylJdG6yXEI?=
 =?us-ascii?Q?/8b+/QhojmC0pCzlXKLGMojAU5Vwyp8tCSmrKOjXSJyie0qp/mLgJFyk2FI9?=
 =?us-ascii?Q?Lfi1anugEVIPzEGchIw6bWvYlyh5W/CFBqifhQAN6Wi5Lt7oYcuk6+8Hs487?=
 =?us-ascii?Q?hLWa89Q3Wu8Ozg/ZMj7wHughw2kzht6z5L7lVjNz5lKecqgbARBK5nx6NLuO?=
 =?us-ascii?Q?oRtQJSv5aYFO9uuHmVKXeh7dIXvxA3paC2Vi2Ajx8vgvbEpto6wrTda3nwaq?=
 =?us-ascii?Q?gVm1+jf6um6GqR6LLENMxGWIWpQXs4JFWraQYfwhKhKXYGbWTHBDOQb2Lm44?=
 =?us-ascii?Q?gkl9OAG0uRYvAnVZsBud7JhqYylOrY2WXyaAvevDMvKsTSfVdf/oIv25gw3u?=
 =?us-ascii?Q?HuCVcm7wRe32LYiPb8OFDvq8PkLqjhG6Mp4Y6fI0IDPhVBfCT9ojiY+ccf7z?=
 =?us-ascii?Q?DznL4inwyJGE4pZVfe0nUHioddFfMvyOpJb+RJciyI6dMhqpgBByA86qWAr0?=
 =?us-ascii?Q?5b+7mABpWeyZ6DE9pIdLQ4gag3pVkkssPRhAdxn6BNn1pdAFbA4TaNELqvNJ?=
 =?us-ascii?Q?JKxDlPk5EJdwEWlK9yzf7fcvMAcmLk26WOtk+JClrjV9+xwIOFfctX8oSjHF?=
 =?us-ascii?Q?z9VvUHTMJlYiVdHkn6/kwsbw2dKZ+nTdlYMaTDFu4yu/V6uqOHtnQJfFAINn?=
 =?us-ascii?Q?GrEVacNcJHd35DzYT8R7w6malbH8hjYGs0ehm43D6XXXLjAULtIbdLmJyFSq?=
 =?us-ascii?Q?rJYJ3JxcbLVZNM3BEUjiWpgmaueNmJpSIrXKZW1MHWX1/KkS2iwGbtC0l0zY?=
 =?us-ascii?Q?cuerAfi7N/dGmk1PlWkF07kRfyxboUgj5na0AFCW4RgKRIvcPX+jnC4zHQEb?=
 =?us-ascii?Q?jmLVsua3uXpu70o13Vrb91hFjN8VaLC95F3T7sqw0uzAXuy1+6ZtVi9u63PF?=
 =?us-ascii?Q?v4AnFv1NsPJxxEkJOVvG20fib3ae4hvngNJmw2N5V6vOvuwjCyZp0al1lWpY?=
 =?us-ascii?Q?LVAgE9wf2681E1cbf2oI+C3qgYuUzSc7v9E4nNd16CCoUrFNsSw/c+dlo2fV?=
 =?us-ascii?Q?x2gyPzZD8/0xvJf3/FN3X7sBsbbW4zUKJkN54XC+8okMjCJtrp8Ixd+srRTP?=
 =?us-ascii?Q?wYmopyQgnzBJzMDCG/iUYtO6Cs5Exh4U97+4Iy0yIuTuz04saDfx5j8CXMZx?=
 =?us-ascii?Q?d9c6DE+E42nAty71f+jdu9Nn32UZS5Toz+EPWRC2qPzPpZyUAwSqtPk1RjTr?=
 =?us-ascii?Q?drkLJj5bbOm7Lmv4+SZWehqHV0Kgv+ebmXX74ASLPmdVY3dRzFp0YDAxquQc?=
 =?us-ascii?Q?TMzcQbdA001vA6dGWcbSjXQb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUJfLN/aVA9nIg/gi2b9kkgzaecnv9AAgcHLjg+WarKgFLU5YTGjfTlOKrca?=
 =?us-ascii?Q?dD5FCDwovOgcw0ZdLyxujIPJy/jJDY7OoSM9BB8SHD9U3tuaplJg3D1P4dxY?=
 =?us-ascii?Q?vozp13LglDRz0H2bCexTohppJ/TVQpIKzhUjSiZiZHxmYTZ7IrxdyFj4A89x?=
 =?us-ascii?Q?wfQRFeZyh6M3wjv/0f2sU5Xci+U2TFrTFnP7wjmvvkZpMcbJMTRR/rWpBnn3?=
 =?us-ascii?Q?pXT6tBNM9mSzlCQ/lIGUx7xIvUJxFxXDyedgBkt2Lt3PEykni9A8lquVnqHN?=
 =?us-ascii?Q?EkVVorz0+vqtFYXoXq11SYhVQAieFPT3lFOFC3RQkIROaCzfodSqxa66rTNv?=
 =?us-ascii?Q?h7NyHYxdsSY5aUdOHBZesJGgiL8yLg3YYgWKrCLOhHns1wy51Fv5zJiDarri?=
 =?us-ascii?Q?ipTZdJmBwpib4UsAYSxiQZZ+MtySD/xNR8tWDGNkGv7zPwvWwmFeI6vd5lq5?=
 =?us-ascii?Q?E8L353/nwl/06Mnhk1pSahmGSDjDYm1NSO3W6pvA9ru+EBNxM9nwk8d5yscT?=
 =?us-ascii?Q?Sx3B989Q3FU+VnMd+d06uYRptMtFXFxwfeh4FLpBoV1vbEwOZy8CJTNqzspK?=
 =?us-ascii?Q?cvzLRJKupF3VTCMB6bwdmASoMILG+KxOWTmew8IRxmFVenxYjtcYwUnckmsC?=
 =?us-ascii?Q?E7dY7A9og/hSnoYMwpkjTqHKNmKFMaWebWMrJV+irCF40qpFmmjquKP81xss?=
 =?us-ascii?Q?Rynia/YX0Z1hZmUc04TLuTVnnvMyskjTP0On6tAL++39b41lyc6Nzi9LLfrZ?=
 =?us-ascii?Q?CAJmGdrRmT4Cg6HR3qreAblPBHEQHWMQFMlSzsGKk6Cc7K1hyFtiUlcUuh8p?=
 =?us-ascii?Q?4c5UUfxRlwa/MCe3ZPQfulhCKGhyh298qOlP9qLp0UhFc2K85qgBp+pw2Cg7?=
 =?us-ascii?Q?h7mmpc4Y+7ZRI4ryfMk4xDm0DnD1xE5F2NGqPXNYQRD7XvdxY1WgEhqx3rXZ?=
 =?us-ascii?Q?BSXeuG2hI1e5WX9NJgINr9UhFV6lGgo/4ev1DHBD/iiWazaXpX+2FovBKHnT?=
 =?us-ascii?Q?VnAZHIoMJMRpGPgEkf5fPLrPb9td0G8oJY7jENVuSqk5UcfKORPkabFIpwN9?=
 =?us-ascii?Q?9Jss4mEwkzhcfbMoE9IPU8xhpg4sudZXt0nrbQ3zTa3F+DrvbsDJnch1cEdh?=
 =?us-ascii?Q?kKsYHI6vzfL+GMBwryaE0m5K8Ux0BDJ4S9HgyQLHyUE6tu3ZJvLcT/Qxtrpi?=
 =?us-ascii?Q?G1rql2W0vnhhEGNTkUXvMjsL00nSrZQq6F/MzcRCRi3ahQXUlzJial8YtPgB?=
 =?us-ascii?Q?LfU4Rbvh40eDUWPp12Q4wbbdLhJa8ICOzK/Xwj88GmMG+1SqkGnD3DoFntpX?=
 =?us-ascii?Q?6XtsnlDAns99frGmsHhJedC9LOK3q0ycK8LftfBC41nabphjWZzZ7JcYz/2R?=
 =?us-ascii?Q?mWXyTLXl/FAEzvrsd255dBl5k634ZV4cVlF/l/8a4LAk3GE1QnPIrRHpm+KP?=
 =?us-ascii?Q?YoLUMiFER2XFfrgBOk1VYVOfYb9prheckLBm9oF2DRHufrRxdSewzplknmpM?=
 =?us-ascii?Q?g7Fmxa4k7u/dH167j4PT2pBCGHHJ93zs65AM7dif2s3rqqwbAG9U8bqAtLrL?=
 =?us-ascii?Q?T56Z+TcrSXrZ2CZ2XKbiErq5rseLRPIas9pED/PmbQ7R6pHfrk6Q0Nsj6CSw?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f274d9a-2dbd-476f-c93e-08dc8a6e036e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 23:27:08.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g3xfQxyxJtYMq9HMWACNDbtyX+4nvJXH+4JmsPT7xyaZ3DnpTWGneF4SCvYXPAN6M3+z8nBonBmMI/b5OS76n8Ilz4g5ayOiIyK8gzv7FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com

Yao Xingtao wrote:
> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.
> 
> In order to checkout this error as quickly as possible, driver needs
> to check the interleave capability of target during attaching it to
> region.
> 
> According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> Capability Register' indicate the capability to establish interleaving
> in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> be attached to a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 in the same register represent the capability
> of the bits used for interleaving in the address, Linux tracks this in the
> cxl_port interleave_mask.
> 
> Regarding 'Decoder Protection':
> If IW is less than 8 (for interleave ways of 2, 4, 8, 16), the
> interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> 
> If the IW is greater than or equal to 8 (for interleave ways of 6, 12),
> the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> 
> When the interleave ways is 1 or 3, all the bits of HPA are used, the
> interleave bits are none, the following check is ignored.
> 
> If the interleave mask is insufficient to cover the required interleave
> bits, the target cannot be attached to the region.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> ---
> 
> V5[5] -> V6:
> -- fix some typo.
> -- update comment.
> -- set rc when check faild in cxl_port_attach_region().
> 
> V4[4] -> V5:
> -- update comment.
> -- add nr_targets check while attaching a port to switch.
> -- delete passthrough flag and allow all the capabilities for passthrough
>    decoders.
> 
> V3[3] -> V4:
> -- update comment.
> -- optimize the code.
> -- add a passthrough flag to mark the passthrough decoder.
> 
> V2[2] -> V3:
> -- revert ig_cap_mask to interleave_mask.
> -- fix the interleave bits check logical.
> 
> V1[1] -> V2:
> -- rename interleave_mask to ig_cap_mask.
> -- add a check for interleave granularity.
> -- update commit.
> -- move hdm caps init to parse_hdm_decoder_caps().
> 
> [1]
> https://lore.kernel.org/linux-cxl/20240401075635.9333-1-yaoxt.fnst@fujitsu.com
> 
> [2]
> https://lore.kernel.org/linux-cxl/20240403021747.17260-1-yaoxt.fnst@fujitsu.com
> 
> [3]
> https://lore.kernel.org/linux-cxl/20240409022621.29115-1-yaoxt.fnst@fujitsu.com
> 
> [4]
> https://lore.kernel.org/linux-cxl/20240422091350.4701-1-yaoxt.fnst@fujitsu.com
> 
> [5]
> https://lore.kernel.org/linux-cxl/20240524092740.4260-1-yaoxt.fnst@fujitsu.com
> ---
>  drivers/cxl/core/hdm.c    | 10 +++++
>  drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 102 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..5b7dff19bbfa 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  	struct cxl_dport *dport = NULL;
>  	int single_port_map[1];
>  	unsigned long index;
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +
> +	/* allow all the interleave capabilities for passthrough decoder */

This comment is incomplete / misleading:

> +	cxlhdm->interleave_mask = GENMASK(14, 8);
> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);

...because this is not all of the possible interleaves.

The precision here is not helpful because it makes it seem as if any of
these checks actually matter for a passthrough decoder. So I would be
happier if the comment and the code said:

	/*
	 * Capability checks are moot for passthrough decoders, support any and
	 * all possibilities
	 */
	cxlhdm->interleave_mask = ~0U;
	cxlhdm->iw_cap_mask = ~0UL;


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..dc8e46a1fe82 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 36cee9c30ceb..6b8cf20ff375 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,6 +853,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned long iw_cap_mask;

Given the code assumes that the reader knows that each bit is identical
to a supported interleave value it would be useful to document that
assumption here and add some kdoc, something like:

/**     
 * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
 * @regs: mapped registers, see devm_cxl_setup_hdm()
 * @decoder_count: number of decoders for this port
 * @target_count: for switch decoders, max downstream port targets
 * @interleave_mask: interleave granularity capabilty, see check_interleave_cap()
 * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
 */     

...with the above changes you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
