Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C91991A9;
	Tue, 18 Mar 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330112; cv=fail; b=RhNOZq2JIVmL6F4WK6X+Uj+OIbTpixTdxjKmG+81SC/LnsZnUgKPe7sJeQIU8ghHCxhShdym/Hlaca+8Y611DtX6d3ma5Ti+04MYEaz/Qa/MFX/QBDkTEiU+Mxb67uWZrYg0LRtm2g0K0vW3kb2X4PKHx2gg7p6zI73Gac7XIaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330112; c=relaxed/simple;
	bh=SuXX4wCVBuqBEV1XEo7Rh1h/Wz14CVvKa/rHdbrnkow=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LChG+qjlkcWOTimKxsbvaw/BJ73PgOTRziNC+I0BrEXH+nEdNZk2CFKD1339J28jzriOaEWSF5AbTuzLqMgaJMyo4AFoXtgKXWKGCJvJ7jiwTsAz+xW4ehQ98F+whybX3lmcIaKco+T2Oj2p1pyr7sXI6UUKb/vhDTNzI7umjVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJTOrOfE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJTOrOfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742330110; x=1773866110;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SuXX4wCVBuqBEV1XEo7Rh1h/Wz14CVvKa/rHdbrnkow=;
  b=LJTOrOfExMiUtZiECJTlzQMb9iKq5GnwFTooCYbT4xn8sYkVDwH6DhVU
   QJPXuuVL6Pacxy0Yw/jLSUDwef9l/GR4VuUuy3/SSpEQ8FQ+yvA4T5lOB
   1qQoUUF87mhE9LeckydFcCm3g1vAOAhnzDhO7Pgw+juadp+1TEk42vGkt
   qVUH9lZBma7g2XbKVT9hqO6dYf1TphQmNv/NWlUG9DdAhOH7CkqKw6mP+
   U87wxCXL6MULqzeHm8DTeR/X47bBebiLGBj32DNP0bWyb+avqBI7zSr4m
   F8Lot4heLbqRFBoPssbrQbfLVrVfn5TfDd3eDArMu5Nw6MIRNtDbbO5gu
   g==;
X-CSE-ConnectionGUID: 2M/Os6vQQBqDOPAIdst91A==
X-CSE-MsgGUID: mvBhR9UbT1O1sljHtBmfTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54167219"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="54167219"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:35:09 -0700
X-CSE-ConnectionGUID: I/c1qxjJR1iey2tBaIjLAA==
X-CSE-MsgGUID: uOdi48eLQLWJb5RCJwB6pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122846593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 13:35:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 13:35:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 13:35:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 13:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTHpXcxPwXAoxqzyWBQemZw1/HDeH8mDIoXkLCGodx1j95u6YpQrGRHDunGYAPcIDzxY6zHRsnJrWgAbYVsveISPtHJgJkNjIv6DwaRkjfvdKoBFICrww7Ef4mUJHbl95HrEHECHHK8df43qzE9XPnQ5cURu+zbLSRgTnmlLfeWroNVWX8TciMlotN14nd9ySV4SMatna2ZgKFTaHKwuWET7QsQK6rLPM+JJXzNND/rl/xXoZJJHuMy+ntY4nte3t7QNmFeDYxwsnDxmnQxVIOwNd6zeDjOah+k73IkwFqsqBn5UnShipcWM/B2Y/h8bKpSpVzCLdFDTYUMaNHMlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmlr/pZWVtGdH1nu2iJjSuYvPGyDltUoiVezagNUu2U=;
 b=qnTVRssJ6jopC9vZr4IGsNapru4r/UxMmnbiwgyoWLH4ZBB2YHVVDMQcEZ/FrZECsj5kYaTSrEE7f2klkoW/g79SDXk59YgyIJ5FKb8ATlJDxpMz1UJ544kd8UJ+HDyDhs2Lb/drmuVo060gAj8zt3hsZZ9EwaKk52oMS/6B8tb7C1hzZ3RLBcUHPu9qBCUGRiMiAVYzZuBBjcl9EcI2hfdLVFrF/AX4nfLYxjCQ+RnPB8eSb6mD64fLKoSdr1Jh+stpIDrggBVvM5LeQwI6lGgyt3Q47I6WZWIkz3zNWTdmfKScfwbvZRiixlgHq4GrAaSgmHMsKRoC5lCfvQ8ElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:35:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:35:07 +0000
Date: Tue, 18 Mar 2025 15:35:20 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Robert Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 3/4 v3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <67d9d9089eb52_422c129445@iweiny-mobl.notmuch>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-4-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:303:b7::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: a367e0a4-00ae-46ef-56d8-08dd665c5ede
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aN6WlpaKL++Rf8fsdbrsZxrx6a54FYAyjHIcXp55srNrhopBgrjnEJWv23gI?=
 =?us-ascii?Q?adm6p+K92tOJRCwrd5BBXasS2qBU7BY75hZ6AYFH8orrdxj44U4hOM7zR6p9?=
 =?us-ascii?Q?SiHMqA8T1/BozOBO0CWf3M6tEqb7IrSvY70Oxsu3vCQeCz6nWiV+7g/8XSKK?=
 =?us-ascii?Q?jj1HrPFkRAEtGqgblpTFGq2EX41tbW6meII8RwpBHz12MsDnJbntzgNwELM1?=
 =?us-ascii?Q?VQ7gl0ovdQepvMSubjri4Nxpem4AAxHfpiRTwJn6xDsZmHkbuEepGpWJ+mNl?=
 =?us-ascii?Q?OCZQRwddRjr6X1j0ZbBTK8O9uMjqR922x5WTN6kItHZejA4IaLK3hmmBNHAV?=
 =?us-ascii?Q?byTvZxz2aPbi6/HnVQQfriY9NFeyqo8fvRo6wu1FBBm/l4ifaCcqTRCzbDPx?=
 =?us-ascii?Q?kjQ9oG7dVn8sccXFM2Or1KSNLFE4Qn9TqS+m0lJqqjGiV/7bpiUcdc4o073/?=
 =?us-ascii?Q?/zyqaesQ0CBu18VfNF6HKMwByt/OEEPuEHieZlAXFv0ok8bsCuRBhYU6g/0t?=
 =?us-ascii?Q?VzwNB2y3vyhjsBwnnKOAbWXyPicAK7IImMUdlUOFeI1nbbNYo9Ifzc/crf4b?=
 =?us-ascii?Q?RU4iRGVTv9lOmu3R0XWfIqtahsqzEHMW+3zCxs2p9iYLxedRtQy9aFAlfrEj?=
 =?us-ascii?Q?kpssAHF1cHpqJlsBmOfxDlDrvw9Lv2cnwnHTviFASM8eVeu8h+XSog14Vkrc?=
 =?us-ascii?Q?Lw6wGngpXlycJKxiEtH7a0FjQjNq6sdst/ggSp9kRMxUUPJcPpA8XiexoCgb?=
 =?us-ascii?Q?63Pct5bn7QgpdGFvKiYaG/ExvInf7qDPmIiL6u4OSzkg3M7DU1s8q7TbhVTh?=
 =?us-ascii?Q?Tskq4V2AJNONKRcFgfu+xkBDXTN/BvgYqyddDHpfmNdJy67bAR1JWz+AtmJ2?=
 =?us-ascii?Q?sTEGqXaERFBEtn57PL8BgxnrOS8m8f5jCpSbFNqSv+AaJ5d9WIAlXgTDzrhI?=
 =?us-ascii?Q?W8QHEQCXNBZzZb1kwNIW5LReYxODYVQuRLLjsgnO+yRzxPzLcCWcC6LrXsQ2?=
 =?us-ascii?Q?e0BAhY6eDo4zllofJHd+UlHZTuXLZoHNp79EWAQsBIy9i7uDEHK6fKgdl2st?=
 =?us-ascii?Q?hZd3m/xE57TQfGzP6/P1VqvVeAE4vMMAhVk61GvSBuUk4OeOLV7xY/9OUHyU?=
 =?us-ascii?Q?82buged15CAmXXWFUzKxMO3Nevl289bBxEzjcVup26yyKbgXXZ4juZMK1BUQ?=
 =?us-ascii?Q?A9X2DYrOaX/e058dm72ePDjPd+Z1vAG54sqthdxS/HdM4JLcVRDiaoBy5yrh?=
 =?us-ascii?Q?pv1/0QwfUauUpzydmm6b+bUg1I9WkVPZeD+N/Pqgl5tXmOyiW3/3OwBUkTdt?=
 =?us-ascii?Q?O7wccysO2gvtDvhVfjWpi1wuuAULAA2roFXEl6ghsAP3U/wJNahtQhf6POh/?=
 =?us-ascii?Q?Y/HQA31bHq5UxRtoJf2VRjz38mN1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqWxUyngCNMorf/5c9Xls5Nm7T9qElqRgHgE6n+2sGXc6LfNRETYk8B1Z617?=
 =?us-ascii?Q?m3aZ7dtOKhVBPCjVc2hdc/tans2+Y+tIaJQtDf2LwIgqxzzZNqGrce5HXAzb?=
 =?us-ascii?Q?YneGmfAS2b3nivdvJhCfAbgthA9+aTZJLozyttRfi24/1UsM4KB2zvxQ8LOx?=
 =?us-ascii?Q?G0YvbmrXCGwVtEHmfDfbxvuKkgvl/IwFJ5SPjE2viV0eoteAhaI1UG66jOq7?=
 =?us-ascii?Q?EJf5O9aEOztFLMZYVLcVi/zyfF6K1IKTC0hPqtmBPHJ2j6exhqjovD9vx1yw?=
 =?us-ascii?Q?J0yqkXsqPMxLUVoBtn3qay2X91SLDYVlDGQ0mIKnxbgI6ZSDVJ+FtJ8iO7Y4?=
 =?us-ascii?Q?C+1Wq74MQz0rM8bptfmG56a5jn0rJ0fyvw2heO/7wa2xV3tOLn8hmyX3ZB6+?=
 =?us-ascii?Q?4SpL/XL4BbtyhB421CNcua1Z/Of1yKs1OLDlkaCbHUT+njvaI6X5+JaJzEaS?=
 =?us-ascii?Q?iEeuzOP9g2mIXbx+A5Jf1LfntkAUrf/kNZ9Cxw/2piftQ1ukt+TQkWdt4kRB?=
 =?us-ascii?Q?oMDVQNyoGgpPwLUw6jd39hhi+dCM3BYwTS4fEfoSjVTYMdDMSjguzgBfhNye?=
 =?us-ascii?Q?dlYLzBnTgM81n1Gwep6hCRrhPB3AJqMDJL4nENWhhUFoba2ug3i+ZjOeZNKg?=
 =?us-ascii?Q?nDJTACqh2YwALKKuzA/Rs/djoX4PoBAFcqnVGdmPTTQ6dWcuqqzLKgMOzMc1?=
 =?us-ascii?Q?dLEdHwS3zNbH8Enn8eJn9pJAkM0WNzkd64W91FYoFS7B3EqJcOxI/JtWu9B3?=
 =?us-ascii?Q?ACPepF7+QR65FEYEt5k5jpcgphekwrWb+0OS+NGJTzL/GR/LF7ZhaJNergDa?=
 =?us-ascii?Q?0qXuLJUNl2Pjmb5DV079Dy6zUkzI8L9+vq2oa5YcjLnTPEQRGYG7e0jvQ58e?=
 =?us-ascii?Q?HnWvvAxFuiB5HAMigLMGJfmU2VGtqWIa91Np5OOJpYUjuDFinU6I0px7bGPl?=
 =?us-ascii?Q?wcCGaHwY5UfTXad+bLO+kaVMHCB/Dwk9zww2wktHsxvNloN1yAmRNXJNju8s?=
 =?us-ascii?Q?hPSztpbvc8YtW4J4tjstp+opUawqOP3bAjcUiuHIs8l3Sv3Nu4PT1olbCqpI?=
 =?us-ascii?Q?auTmMjAtbuBo1OC6P9/2f1f0ADGkCOLqHxCWEyAGuytFFGr6HvN+QRKpIMho?=
 =?us-ascii?Q?q4+of89cGyLTU+y/LDUoP2CvLTIOlYo4AMthmZv9un4rCTWuqO/wXzqHnNiC?=
 =?us-ascii?Q?1vR4isdNhd4AC4ciw5s52crzdApUjSSm2cp7gRmGeDXIY5Z4agqIcrLrETdh?=
 =?us-ascii?Q?KkoHRCkuDrCxwlap78NnFl201TsyENRDNj60Lb95DfiBriPiLaHrnYLjko1i?=
 =?us-ascii?Q?ua6QyVMCA3KcvrM9DZR9U9YewUjztopgYDqAEYyhYk5+mpGBAN2sv7OIh+Y1?=
 =?us-ascii?Q?IYeT8ZnqTyrKaQV6JOlM8gXImakpA0F4Hqvlms16Hxai4JQV+zLEOaFMxwCZ?=
 =?us-ascii?Q?iZawdkF2F6RPrqUkaQEF2Q2aVgM+1lab2IPGLuR5y08K5+d6hXZKe5Hugvod?=
 =?us-ascii?Q?9tUJhhvfz+CbHonMw2n8YxDazp2SRZ2m3x4/CirJHKRMxi5bNkufX3g3pNon?=
 =?us-ascii?Q?VZaOHWbXSwxcAVpkKQ+FfRKnN3ei2c0cvS/rzLRK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a367e0a4-00ae-46ef-56d8-08dd665c5ede
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 20:35:07.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Usqk7YVa+tNasaGB5H56tdbB4eQuCyXxX9+a31Z4mgEU8s5jfxOdu318/mu1XNkMEO0A75oWJBn3bRheh+CdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect a Low Memory Hole by comparing Root Decoders and Endpoint Decoders
> ranges with the use of arch_match_{spa,region}() helpers.
> 
> Match Root Decoders and CXL Regions with corresponding CXL Endpoint
> Decoders. Currently a Low Memory Holes would prevent the matching functions
> to return true.
> 
> Construct CXL Regions with HPA range's end adjusted to the matching SPA.
> 
> Allow the attach target process to complete by allowing Regions to not
> comply with alignment constraints (i.e., alignment to NIW * 256M rule).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
