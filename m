Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC525777
	for <linux-cxl@vger.kernel.org>; Sat, 27 Apr 2024 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180087; cv=fail; b=utgBb6uzLY7rU8EK7xXDvRyrmPO6ATSIR8OdAvanjOZaSu7OAyAZ+gZSHd1YWVFvHdASrpEJt+cbzmpHQRkRV9Swe+zOsauko/XR3OyU4gx8qjHJgeeS22tVVrogzkintEg3EOAxzcvEGJefmHNO+xu8sKkNTDoDg+FULNFkYNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180087; c=relaxed/simple;
	bh=PiF2kE753zAf+QzYH4jqP0a6mx4w8nT4fRGc/EM8xAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HCtSf69Bc1iDFDskdSM4c02li9h6U4KT2m+Du/Wn9ZhNSbCY65HIHdUQFyHd8QNfQUMK9tmtXWQz/bGubW7WZUpRZTE9ohhUbcjO4V9LUqvDvH3D+wwmYJFvjaCctcPZ9O7dkEYb03wr8OudrfE8DF63cBtxwRDZXNGbJtfX9pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzYAB6eg; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzYAB6eg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714180085; x=1745716085;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PiF2kE753zAf+QzYH4jqP0a6mx4w8nT4fRGc/EM8xAw=;
  b=nzYAB6eglzPpdU6s/r6em1QiNe6oWwMVjL638Ew3f7UjdOhcm2QHHD4c
   eMudm1EN/EECG21AgskJyQ2mrjVl2wNNIoLfUTHAg+7sM2TWST6pgvJxS
   necZsUciUoZI9zO0Ikt31r88R5oxqDYhORtU2MvY8NNfcUD4DLr0V5iE4
   ODLg66hkMY1SYJNQ3UtNKvaoOkwcqcoa7RUMrjmNU3X6tANBlvFxQSZAt
   J5YtDr8gao89otJZh3w0nHVW7Z5uA1n/fmde1CPV2siEqneqx0dUKQEiq
   tSROlZQaB+4tJmeuluW4rdraa4a49cr4+7ODhTgAU8+c+UQAtdQo1a825
   A==;
X-CSE-ConnectionGUID: IgCerSvaSza7tV1kOVJn2w==
X-CSE-MsgGUID: MrxtYsz1SWaW1mk9AcDOXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10050900"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="10050900"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 18:08:04 -0700
X-CSE-ConnectionGUID: aiZw2R/GSkKrudex1+MNdg==
X-CSE-MsgGUID: HUB5mXmPSyuWc23g/7/d0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="26083159"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 18:08:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 18:08:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 18:08:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GygAiwgwPDDFE5qoJN6MerDmT5nnDlX3PXMNlNrSi4xEa+g5QDj2bOPJEMtlDg9Qjho9DkCMzqz3xcfDnXR/ZSqEbT2d/nTuMK1mNGMkTIicp5ek3+zbbMabIRtXIQOfSWQxqQIXPNp18PGr5kj43u+GU8QA89MMubDUnbgfVUSSo+ipav5uLF5hmeTVbAYnOkQMIlgvJlacLDTAct4Z1kMeR2TIo+opAqeQy4zHT4yYgYcoWKangFmIY+vNHkSY6vrE87IjfAbnPBRB44cpKV1fKYUocI6VFJabAMiPFH9o9dfm3Gw+Md53EfbQId/D1YpVOfhYSEmL13aFM/eWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG3xnNVV+xM/IDowRjEsj1cNlf45cH/bfwxWzywObP8=;
 b=ZIYrcCBOxJZUQmX+++Crym2mYCKPVGsuqiUAzMKbMXBCQQseAxFIZNPtQ9w0VyVpQlwjG5qJzMxgsgyFdIzgt8xr0aaS3/9z496RkD3X3cYuxHUrygyX40mWn0fv/Tluvroo3UezGEoc6pywl1vabgA0Q8FsMFD4/BBKnt/KX4Hci6hFPi8dfCVZ3OxxbLV+Wlf1QYXmFgTaXHe/yfn8nIoC5xSA+ZWcgDDqLhWrUo2yvveslIWLx2oAGwqrWAxWq0scc6Ki2mUgT0XNZ4Wng972HSSXU6TT/HUn4/SZ5UNab1p+/xFdavH6qM01bZrtN19kaZpRBnCUfFJzeKtKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Sat, 27 Apr
 2024 01:08:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Sat, 27 Apr 2024
 01:08:01 +0000
Date: Fri, 26 Apr 2024 18:07:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/acpi: Restore XOR'd position bits during address
 translation
Message-ID: <662c4fef695d6_b6e029460@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1714159486.git.alison.schofield@intel.com>
 <d4e689f9a9645cbddb943188d508807da33bf91f.1714159486.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4e689f9a9645cbddb943188d508807da33bf91f.1714159486.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 11098bb9-2e6e-445a-f018-08dc66567c29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XGBDrcr3431guih6Z5w3eAnItoYiWRzBkZfuHNNb4d+MkQPMfvauIT1Oepbg?=
 =?us-ascii?Q?Al/4f4eNxmp4lh8mqfrDirOPdmyAbL6i1R8125MS/dCk1n0O+kJzcXUojwHe?=
 =?us-ascii?Q?d0xYcJFt5Y8slvhmzYe8bLFjcz1oqMJfiyMwytCgYXAje0xydKA69Sv6TsVR?=
 =?us-ascii?Q?Y8PDg1sppxITH3Z0IVjwNXIRebHyCvB0zKPeZ6OvjN6U7m0zQdJPzVN1UddN?=
 =?us-ascii?Q?xfyNZzkf8cLH46S9O8znk8RTZCiOI4b1bgEzNSo9SPWxyiRFU2Wpt19kjQnQ?=
 =?us-ascii?Q?ZT1UfZgVe6xp8Medfc5lngP3jWUhymX7bAB6jf4RPF+IK9UZR85VAgbyz6Ax?=
 =?us-ascii?Q?TsLs3mWrmhxoW440dDDdIC9P+k7D2+1ai2zjBVgA+fNkPiQOTFLHv+1B1CUT?=
 =?us-ascii?Q?8YRr72dr6MtpZyADohdGP72JVPwDoJyi/qXdwlb/mXTd3YkA2gVaWqnNYjZZ?=
 =?us-ascii?Q?jGAE5XEMZ+jcXMyzuBPk2z31SNC4EjHpxd0kT7wMDEIDzV1PYWX73p/E1p9M?=
 =?us-ascii?Q?1y+ABbKxDaPrfdVMv1CpandnWrbLBaOCPx2BoZ2MPUzvZDpBswiaX8qMIPd4?=
 =?us-ascii?Q?Dk3XLWj7PKlQLcRTZk+5lVZqFCQBhQ1oYk++gF8s/EVhJ5B7uvtzjNyDZNqH?=
 =?us-ascii?Q?esJXkp7XmGyBDyIHhhzPOnz7l8nsxXXXihNupwONQNqCHJ4UFScxHcnhMDRr?=
 =?us-ascii?Q?BVGqNLcDAROiDeJiFmYk0l+JxFcpdeCt8nK3T0upKEKnDRbDayeP7/oB0D5d?=
 =?us-ascii?Q?z0xYzcIobQPdx3KCVWWK3PtzgwasI1p8JWpPQe1TAJOX3Nfr3SW91ODDJyvB?=
 =?us-ascii?Q?iCdcZXj68kDeMuEquUvi3LxCfxIg9E7JM9GOc63PV/QZWutp1StZKQEFnkvG?=
 =?us-ascii?Q?c3EzQ2SEGNlQ4OKHPcN9QIfMtOuKjJ87s5bZ6kvECRwYzvoTWvNfmUYfBB7z?=
 =?us-ascii?Q?NffvwMQnebt+i2akcKKYImkE3FyxEHD+9aCY5QysXf309PEYMcPXre5PTo+7?=
 =?us-ascii?Q?0UYNHd67fyyDsff0wEYBPO4A9YMTVeR37v6A55V7KOe0n6PcgL/s8AkIIAzj?=
 =?us-ascii?Q?hHMXYSA3MPZPmGzJ+llc1zRBz+tlc3mx/jrBYulAz49lBQ8ApytRcDraKXHA?=
 =?us-ascii?Q?QqCcha7p087YG+nzuF+PX2V34o9nIA5N3qCPvpVMC0JduMWVc/ujEZfyS8Q2?=
 =?us-ascii?Q?QewDB197BAYGDbOXUoo3FlyGZ041fs8C7ggFJH3qJHVPYsRz+LtedAF8kulO?=
 =?us-ascii?Q?uSmYZEqfobNCw8hRkCX4lLquVXa+lgxdVrgQ5qoTXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAju5YAuhr0VzyR6APuUIsWFPGgmWnKm9V8KAbHq5KRB87zn8bjq0orGJVod?=
 =?us-ascii?Q?QKDCANB2CHooNzt4d94P/l8mMnyPceab0vCL75ICg8e26PNVJRuSE1c0Qoj7?=
 =?us-ascii?Q?KfHSYfb8CUrCjNFK/5eAaEgWBwKFyDjfSA9IToGJPI0ggK1RXfK+OAz07YNU?=
 =?us-ascii?Q?LlIYKLc9Nfw0mKHVKwJ2GP3CCWG3YKVh7UQweyIb8fUL/LwgHrpo0EBbRNI5?=
 =?us-ascii?Q?xFpD8zUQGzCKxsmAXLwcw7DfqQsSO+HM3f/KOaTKGAyZ4snuCnshyFIkjjFL?=
 =?us-ascii?Q?r2GyyGMneySXW/tSyLN35l7EZAGALz4DQjubmiA2XbVMT5H37sQ7SRi/FhM9?=
 =?us-ascii?Q?kc6mprWBpOIRyUhwLRm9QwJ+IfOeJ2iYDbFjII9buJKSeMUu0bAhgaBTMt6v?=
 =?us-ascii?Q?s4soNcKQT79FkVs4A65Th/xRQnlA57N3cbBk+e8KC/iYVaop0SP/rTZA2pSe?=
 =?us-ascii?Q?B9AG6BO1ZTdAHvzqdo712qZuZZ3l4Fz57t3qCCmnkkuruHEWruTKoo4PmJVU?=
 =?us-ascii?Q?eZMJWvL46KFOb691G3BmxOOjSSRQqjmQeb9H3oYwLLRC4hjPsE5qw6tapbtV?=
 =?us-ascii?Q?vU5/3e6VF/1gD8u+wi1s+CXbWtFMhshoX48cKjHswNQSPtJh0zn/wN9J0iGj?=
 =?us-ascii?Q?rAGXWRXIJmHcDpFJpeDQLuaMa+FAbsliFezyCb3WzRZS2tdTIpzvncxmr/9J?=
 =?us-ascii?Q?bN+IOZmcKDD83PCegkYAaGi/qZVhofFZ0gxBG6EZTKgXZUmUgjzl56sfslql?=
 =?us-ascii?Q?L/+AO7Q8FNvGVvM84UyQ5jIUrDaoxacVK0hIU6sobOmI8ydYfOQCulr09m9/?=
 =?us-ascii?Q?c6kh7KHjqNr2E93y/qBGFKKC0osOXGcdzprJi2cgCROh0SkaxFw5coC5Jt69?=
 =?us-ascii?Q?wqmTh+8V9XUqL16RqFa0JaddcCL7uBzsFw8Ojc19XK8e+ONyalVF78dHobyE?=
 =?us-ascii?Q?afOPutqf1nuuFfdGfjbWcRKhUADfTcFwESXNF4AuHyBi6VtdNubrIQ62TSi+?=
 =?us-ascii?Q?lJgjQfS40yf+pxGGtiWb0JPjanCws08ozPbD/Zj2g2rstA8c4tTzqkdI40PT?=
 =?us-ascii?Q?0hgm/WU7N14HxbZ8Gcc6YJOHAREAy7BHrrqdfgERFYzDooJC3YfIdE06VQmE?=
 =?us-ascii?Q?7Urzof+Gz0E3iLWJnkUn+ZNEOtVxrCRYfo4DTc4IWNhY55gQmU6FS7pEKZam?=
 =?us-ascii?Q?r9rVWBN93grkp8cik8lmPumK6sObwG6H5mjmLU4BvrH+OAulnAv5nbvrejcV?=
 =?us-ascii?Q?9X7yo1RVgEbNqISLASr0jfcoEzG7BjLxld/Wfpbq7TGlN9LLsZ8JVBLMKVZs?=
 =?us-ascii?Q?SRjjpPB9gZoVdvFwqh7QeEMwjMcTpvTk7sIx/fTyTI0oXrxT3Hh7U8iaZEy3?=
 =?us-ascii?Q?ng0lkpETyE5LfzXvLuENosyFZ218sV+4HA/UkHYLJBpo34vBVhoD5k4lV8yb?=
 =?us-ascii?Q?jMPr3722GmmHKhncIPf5/Iu8MhXxqyfOuQde40CMoU+r6XMuBQNiOXBlsrxz?=
 =?us-ascii?Q?dt3v6LfNeAnMVWUcl5JKqWbUhy4e8zes/iSlDA3vL5d+uXFv3qD4hIyQRAmp?=
 =?us-ascii?Q?cnU+lvuqvo8/gyuoy1mIzMP8TjDgcrLo+hujv1dtiuwXPhz7EGeqjgnr+6Fv?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11098bb9-2e6e-445a-f018-08dc66567c29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 01:08:01.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiXZAKoX9mmOSojW3rv9UxDe/ZvdYZCqoA5gbN2PyWC7WTAJeet9Hp5ub5MD3fGeuWJVKHJsNMPQI1Kv5K5zEba+JxsE9OjJEdYkkkvfqmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8025
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> interleave arithmetic XOR maps are applied during the HPA->DPA
> translation. The XOR function changes the interleave selector
> bit (aka position bit) in the HPA thereby varying which host bridge
> services an HPA. The purpose is to minimize hot spots thereby
> improving performance.
> 
> When a device reports a DPA in events such as poison, general_media,
> and dram, the driver translates that DPA back to an HPA. Presently,
> the CXL driver translation only considers the modulo position and
> will report the wrong HPA for XOR configured CFMWS's.
> 
> Add a helper function that restores the XOR'd bits during DPA->HPA
> address translation. Plumb a root decoder callback to the new helper
> when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> let the callback be NULL - as in no extra work required.
> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c       | 49 +++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/port.c  |  5 +++-
>  drivers/cxl/core/trace.c |  5 ++++
>  drivers/cxl/cxl.h        |  6 ++++-
>  4 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index af5cb818f84d..519e933b5a4b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -74,6 +74,44 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
>  	return cxlrd->cxlsd.target[n];
>  }
>  
> +static u64 restore_xor_pos(u64 hpa, u64 map)
> +{
> +	int restore_value, restore_pos = 0;
> +
> +	/*
> +	 * Restore the position bit to its value before the
> +	 * xormap was applied at HPA->DPA translation.
> +	 *
> +	 * restore_pos is the lowest set bit in the map
> +	 * restore_value is the XORALLBITS in (hpa AND map)

Might be worth finally clarifying why there is no "XOR" operation in
this xor_pos routine, i.e. that XORALLBITS is identical to asking if the
hweight of the (hpa & map) is odd or even.

> +	 */
> +
> +	while ((map & (1ULL << restore_pos)) == 0)
> +		restore_pos++;

This is just open coded ffs()?

> +
> +	restore_value = (hweight64(hpa & map) & 1);
> +	if (restore_value)
> +		hpa |= (1ULL << restore_pos);
> +	else
> +		hpa &= ~(1ULL << restore_pos);

It feels like this conditional mask / set can just be an xor operation?

    hpa ^= ((hweight64(hpa & map) & 1) << restore_pos);

Otherwise I question the & and | operations relative to the HPA bit
position already being 0 or 1.

> +
> +	return hpa;
> +}
> +
> +static u64 cxl_xor_trans(struct cxl_root_decoder *cxlrd, u64 hpa, int iw)

Ok, so the driver has cxl_trace_hpa() and now cxl_xor_trans() and
"addr_trans". Can these all just be called "translate" because "trace"
feels like tracing, "trans" is only saving 4 characters, and "addr" is
redundant as nothing else needs translating besides addresses in CXL
land.

[..]
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index d0403dc3c8ab..a7ea4a256036 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -36,6 +36,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
>  static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
>  			  struct cxl_endpoint_decoder *cxled)
>  {
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int pos = cxled->pos;
> @@ -75,6 +76,10 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start;
>  
> +	/* An addr_trans helper is defined for XOR math */

Rather then calling out XOR math since that is an ACPI'ism I would just
say something like: "root decoder overrides typical modulo decode"
