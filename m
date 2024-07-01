Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A01E871
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847989; cv=fail; b=A1iXSLWnysm2TgEnrg2SD2EWpleCO69rybmmUxqZveHFZDI2zhZcQmYIATqOGeROVpTT/widXV/fdc7QFxI98Qpqt67pznZ+UGBnOXZnLsMZJVaWodlUSMVZ7ogjrG2uncQE6l66UwL4Eh5sKtve08ThaL4zMU9MLKtsCogzF3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847989; c=relaxed/simple;
	bh=WzVfT6zGtgPEMtrEnpuRITxbcLRzXJKByZIYdk9GV14=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLxutQT4yV+BU9OTZ4AHilGcrPq1DtYWoLU1zvaeTJBAxv5CEutBfZqoTXqhbSLlectkrpkVZPPfEJjyXeWOaRMLI1QAmxIGGzhjuEJt7sxLSo5iJtjFPj2JRLQATuwtuyCl1oIyBEgkB+kVbMqjFPRSu9a4+b2eSSFWilo3dnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoJgRRB+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoJgRRB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719847988; x=1751383988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WzVfT6zGtgPEMtrEnpuRITxbcLRzXJKByZIYdk9GV14=;
  b=UoJgRRB+juLdfMN2upHxmrTeRbFcOeWEwyL1PBPRCQJ09ROyS8Q21ePo
   OlpZs9nQ0O+fsjeEpbKtsU4KxgrUuF5yy9sR6VAkMNzyzyKk24EqLftHN
   LD1wBZC3ve0Qbo4kMV6OsicSDDsVVDAPS6B69l2eRxBeVZBJEcTdmijUU
   zvAH81Jq5TkM1l9kLn5idGkQTMJXN8w94OSjLq2AAj2RTk8rPLbeKKreg
   ZZoyZaA0QjT8TbpBRK3xJ3INHgAy0Sxh2wiFucOcQE8MwX4vjgqR72VnS
   ZNdDmzCHd389NaNkoDcNKBil2LgFftET2et7GalPu0fxP1s9HdwgxR33t
   g==;
X-CSE-ConnectionGUID: M/w5WiizSOqPWN8XmpF4AQ==
X-CSE-MsgGUID: je8Nl59yTIOd4kxOxlgokQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27603222"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="27603222"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 08:33:07 -0700
X-CSE-ConnectionGUID: 2Ae8DCZJR1uatuazH0WACQ==
X-CSE-MsgGUID: gOpr0YjLSPeIfuDXEdcOsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="76276920"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 08:33:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 08:33:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 08:33:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 08:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oib6P7N+DHiQGPvRjd+N++ELHMyobDaoF5KUzDPI6+aXejzOkT12b99H3ePBLjIc8af2mwmLL2rlX1uKGsEvmnhx6Uo9/RSoW1/Kur6AtEK8m1hibsvpoKOZXX/sGqUYh/TuT3YBonhJdRlG92efzKB/G7plazZIVkE4tDQRvW7TUJktFG9ex2DLgOlvCdz0acae+hv/cIs+2DR8JQfGeGJ2YE4FLss3YrAw7x5S7I1ZpPRDk5ytS35jnP1JtwY72qpLtf0o5NZ/vfHvrTrDL5P2PT2FGPqAV6QmxQn7t+13o67TY8W6JIafFQ5cpmloXJig1JJEbosUEjcOCnx6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvy7P+tscpOsP/+3moLQZcPRnnGlmVtJVUXVKCcUtWY=;
 b=hdy/fM/JuDEgmGMQUuZc9zJ8r2GA8hPkYF9c8lbpjj4R8fmA6ELBMFKPt8lxZ6RxFgO70UrrNDaBsCZmFn1xOvSrVG4NwskToDNtY6xtfAADFCzLDTqr/hquoyI+V+8TwAVCh25BGaGfAUYSNcuv1WeY2stnynZ+d9rgGN0TIdRjJDKVw3W5My9Yx9HENYkI6UgT8MTjiR6p/KI12A8i4PJi/a2DJNz8BUcHrkz8X6XtjPuM9uy9O7O6cgYbjH4InajzpxG6KivYL0gKL7byo/EZF/0TKRm8gJG+eqOSq0M4SXcM0X5PD+0R2bNpf87V1OQeMLMxp8rpw+OcZUBIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:33:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:33:00 +0000
Date: Mon, 1 Jul 2024 10:32:52 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v9 2/2] cxl: documentation: add missing files to cxl
 driver-api
Message-ID: <6682cc244be30_3ae25d294ef@iweiny-mobl.notmuch>
References: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
 <20240614084755.59503-3-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240614084755.59503-3-yaoxt.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 3737470f-7678-4301-fdb9-08dc99e316b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9VGrnO7AqCRe64hKau5l3yDME+A/P/3jHmO+0y5HhSNoubwbCEUCaN87g6LU?=
 =?us-ascii?Q?OmiS8nQM7pfTg9Vno7RtrkMSZHkAifGmVTvpeYQ9eNuY5qK9OZZhTMzurIHM?=
 =?us-ascii?Q?QcHuI4bZ+IT7/YEvNKhm7Zdk5DdCMQLyKrqpjsVRF+8j/3faqcXmFxXvFo1A?=
 =?us-ascii?Q?SlqucTotXmXSA8lCIyJYC1UrxPYfyZOT4vBoWBXq49gMVzUWe7jtobRcDI3J?=
 =?us-ascii?Q?eDhxObIL7HDX/ebExpCc4x9SPlxj2RWGEuzRrIW953vxO4EjBcC7gh4x+ikb?=
 =?us-ascii?Q?HAjlb94Mk2X8Bhv4TYozdfvEIr0c+p43sokv/AEmO0FR3khfyBiOgNVOQZAr?=
 =?us-ascii?Q?+/UxdysQv73zBqG8hIvEuR5G98DNsr8Y0/xHX12yCPoojQMqwKaZh6HRo+5S?=
 =?us-ascii?Q?LW4Sof/E7sEE29s9qKVPQhDjWM2I8r3wC7D6FJiJ1Rp2iVt9367VQFTjGFQS?=
 =?us-ascii?Q?Nti9hLr1xRQPtaKEoZmTAvkDGJDhkXRIwgCkGPXxekdP5cBpwdznuLErRhSi?=
 =?us-ascii?Q?fKc+vBajIU5HBXqYuPasO1Aks3POzP7FvLUm3gjGIlXoCBWNBBqKwYUqh+DY?=
 =?us-ascii?Q?+/gm0njj2sqAV10ycBzGr1OQuA+kg2JK99+474DUIY4ldw6mNiFkGEiJ2RMT?=
 =?us-ascii?Q?/hTT8YtEjfhzy1ttqk0ivx5+bg6RGkO/VV+H0VlDhPuYXVm3sT37WxGI2HRT?=
 =?us-ascii?Q?wimlysEkk9tqAWE4OUit4Aqp4oLi0qgNnTkr9Q/BrHwTUq7fDZOvgsvajZAP?=
 =?us-ascii?Q?ZE4iBrDuq1E+R6hE0e5IYSyiCCC1pSfYlcN9YRrnbgV5SE43/TOpn/lditd2?=
 =?us-ascii?Q?AXAjexLzQvKiom8HL8POCqmr587tzGJtHZqglFTsfVRa4kwvomWxC38Y1JuP?=
 =?us-ascii?Q?/+O8NJjjwbZW6zagmr1CQmC9mGdL7ZX72g0KcMfiXWiSvugm7N/mZBDlp89w?=
 =?us-ascii?Q?+Eh7/buIZj0tOCzxo94tfrrWwNiFoT9ezSr65W18KH9V2h3uMaZQZ+G0Q068?=
 =?us-ascii?Q?aZbbShQZxXlOYMGcCYxgpCdsc5nuETwhKr2uCThpxQ2X3/l8VhiDmR3rSsEY?=
 =?us-ascii?Q?TDbUTQN44qtanCKuIu3QnHH6VyIUpcmq7ZKwan+Fda6weW2gGixhusxOIr1j?=
 =?us-ascii?Q?yKLK8Jh7rzhihBMwbm2HOPloMQ1tjbiW+cMltFgzGJITEEONJ+YtfIrZojmO?=
 =?us-ascii?Q?D1ell1FlIsMriHN1qCpz7VCMbFIv5xWpoNHwF05fwQDDhibzePqyAadRVekn?=
 =?us-ascii?Q?unoR4VP0nfrnKykTiWfG58+Rv3vGoRyLMzeka1ZKlPP+7YKJUAj8HXYtrtGb?=
 =?us-ascii?Q?3TZm8CLKPhPdSgsqsCAe0NqI9qOt4uXv7ZhPIxVijXhfOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB5yN/0WKBUhzG1dq1ShLv6F+HOoFPd1yqXX5koQUwddnPfbPsJhRkXu5j9w?=
 =?us-ascii?Q?uPIJ7/tsI0wI9v9VwmyFTJVK5c7sgK4LRiBD62Ve6gsAQZ5Rxl9HmVGwT/Ox?=
 =?us-ascii?Q?QddjbYoFTLG1EH1W45v4Ucr4xR0Kdh4Tuvat3tY2hp3pfnUZERPBafmZwOVP?=
 =?us-ascii?Q?tKb44qB3bQijE0cjb8cRfvSNjO8NdYxMXA7pa/TsmdeRKA8tBCasydSdAb+q?=
 =?us-ascii?Q?LTi0U3bJ0CSVRQLW3wzoZb7y11zzelVgaRSdZBH3AsjhSqPBFalIi/BCoxAV?=
 =?us-ascii?Q?euern+nfM0hlPxiZPXf3dQGt0H8isUSXAQGqgCUD6C1Zjb/j4DqK7Ksl4mam?=
 =?us-ascii?Q?OA4vdNwf4QqguO+g0dJEiXqfQ/AJt363OyO8WlQVi8V0PLi9Sdz4Mc0OSp3Q?=
 =?us-ascii?Q?ELG4c13qfBDxBI4ongvrmsIH18xI2W42kjtQkKPOKXpIO60xoCjm0PZeOsEG?=
 =?us-ascii?Q?x+dgYC1FY27IEtJ53zwBbUSG7aEqlAwMiZBzzAxhIN2nmK9MrQzKg38zWcto?=
 =?us-ascii?Q?lldG6A5FE1/u1zl3McgXDbjlecJAL17XCcnAYspBaj+khyC7W99hNiTt/9Vm?=
 =?us-ascii?Q?1+LAtHSMZK0mFwDflsKI6jbCnpNeI0WhTM+uV3hVyHPl2moOO3/spkeEAM3/?=
 =?us-ascii?Q?1x8+1W0ptjaYAHCYkK2X4Mt9mIfhfFIK5vEmmZPiHezdSsZsxv8440BAiLXZ?=
 =?us-ascii?Q?oxY4b+b27Sc1T2H33PKpgAocSF0wkJvqDFzmH7gSAzPNSvRANuukBM+qXMEt?=
 =?us-ascii?Q?Kdr9NdLdt/tJ+C67YQouCuT6aEo6AojbWRegmf5hGGKTmDVICLyzjQL58wFN?=
 =?us-ascii?Q?pgSpLqiZBG5+0pVvfP3yHQen/lqTvVgLCQuelBaTDZNPQddVY2lnSWta8Rkn?=
 =?us-ascii?Q?NKg7DrNmbOZYNVbCBLauT5NyP7OuvPFN4gbOj8VUufKTvJQmdrltLhTD2cOo?=
 =?us-ascii?Q?rT3rtdJekaIXJip7V7m3dpPUmsWfOPULLSwbUGNB7SdAm6sHOdhO/UfFjqk2?=
 =?us-ascii?Q?QgQA4P6WbeGYaP02jWyprjjslYZ0zvPGLjEyGEQfgt7kQthso9iRr3+KpCef?=
 =?us-ascii?Q?DYQUrGTL0vAr2r5KXY830Ld0HVKcA2J1IE4n2wyh5M5aTFjvdDFPOkZI2EK6?=
 =?us-ascii?Q?83r1nfMuW0WFle2Al7NpVNeGmkVdnh9yWyV0Gahw9pzHV9WljibI6zhFGche?=
 =?us-ascii?Q?rf27Er9I8cxM3h8YhFpn4CVlU3LquWo06e7AYGiVkDbsg7HgLiPqL46LQnU/?=
 =?us-ascii?Q?ukMv2YDmu+4u8ftKg4awEL4+Divj2dicD6jea0E7ZR1JF59uUooyl0cNVAJ9?=
 =?us-ascii?Q?YnObuAOH+oCUgt6mFZJCcPYG4hnmsTXBvyFKcZWTbjuZ7jK3oSot2TeY/+u2?=
 =?us-ascii?Q?Ocob/5SNUPEpzGGHBEwFqCrHk9NXkkSURt2607HUtVtkua7s2BxqIpw7z/a1?=
 =?us-ascii?Q?8DzwXVIKD6gYOOqxkz1mgvkw3TJ3oS2RqEZBRwKxmz0j1D3UEg8G+0lga72b?=
 =?us-ascii?Q?xqmxc8zQZphCk3zebn4EcVFR0z2P3TOUE61eS9yRY60uf8IciqqOwEnx1IAf?=
 =?us-ascii?Q?kG+garcQiKdqVEykBKgu96armz7248VQfBc9zARM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3737470f-7678-4301-fdb9-08dc99e316b3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:33:00.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YT9ho7w6+NQu6tRd1ifA9dnt701WNBzmuZXX3qpnfY2l5btZQ11fQScmYnyaokl6d8cCSRFj7PwSI3i7Wuukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com

Yao Xingtao wrote:
> Add the missing files into cxl driver api and fix the compile warning.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

Patch looks good.  But I think linux-doc should have been CC'ed as well.

Also, This should have been sent as a stand alone patch so Dave can pick
it up separate from the interleave fix.  I think he can pick it out from
here this time.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 15 +++++++++++++++
>  drivers/cxl/cxlmem.h                            | 11 ++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 5149ecdc53c7..d732c42526df 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -328,6 +328,12 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/mem.c
>     :doc: cxl mem
>  
> +.. kernel-doc:: drivers/cxl/cxlmem.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/cxl/core/memdev.c
> +   :identifiers:
> +
>  CXL Port
>  --------
>  .. kernel-doc:: drivers/cxl/port.c
> @@ -341,6 +347,15 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/cxl.h
>     :internal:
>  
> +.. kernel-doc:: drivers/cxl/core/hdm.c
> +   :doc: cxl core hdm
> +
> +.. kernel-doc:: drivers/cxl/core/hdm.c
> +   :identifiers:
> +
> +.. kernel-doc:: drivers/cxl/core/cdat.c
> +   :identifiers:
> +
>  .. kernel-doc:: drivers/cxl/core/port.c
>     :doc: cxl core
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 7806194d2de1..af8169ccdbc0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -395,9 +395,9 @@ enum cxl_devtype {
>  
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
> - * @dpa_range - range for DPA address
> - * @coord - QoS performance data (i.e. latency, bandwidth)
> - * @qos_class - QoS Class cookies
> + * @dpa_range: range for DPA address
> + * @coord: QoS performance data (i.e. latency, bandwidth)
> + * @qos_class: QoS Class cookies
>   */
>  struct cxl_dpa_perf {
>  	struct range dpa_range;
> @@ -464,13 +464,14 @@ struct cxl_dev_state {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> + * @ram_perf: performance data entry matched to RAM partition
> + * @pmem_perf: performance data entry matched to PMEM partition
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
>   * @fw: firmware upload / activation state
> + * @mbox_wait: RCU wait for mbox send completely
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> - * @ram_perf: performance data entry matched to RAM partition
> - * @pmem_perf: performance data entry matched to PMEM partition
>   *
>   * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> -- 
> 2.37.3
> 


