Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E833BE4F
	for <linux-cxl@vger.kernel.org>; Fri,  3 Jan 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927329; cv=fail; b=V3M/JsYX2Aphzxi3FWH3rIBqNzE6R6cVdBCYfFXs0c9RP/gBOJKmzVWxmoUIC+LRHQ4vQqi0jcsHRNEh3b3xqBuQV6stVzI0ZXtODs2db4qoAE1BlZgO6L/gh0J0l/EGx8q89SGQbZnJ73XDPreYJ9xju/nuIVMlBnK5u3A3ZHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927329; c=relaxed/simple;
	bh=zS03DkOr+yRtRFubNvN0wUoJZpuXgCCZRHmQAG1OlqI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GlIJJPbpH0RwdFPSZjN2esdApu5F0DEama73EkEjY9sYYgEyuKQKRwqCbtkYctckR0LudfNcYyVJcMglfa2bN9XSJC2IHHeTdANKp8/uXqOCTjupiYV4yVemr+Z72iaHZC/AmrcWRcRnHWtIWssFnI+i5L5GJ6CTvmgpTeQ7zU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsNDFv6n; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsNDFv6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735927328; x=1767463328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zS03DkOr+yRtRFubNvN0wUoJZpuXgCCZRHmQAG1OlqI=;
  b=KsNDFv6nJPG6MAuqZTf3Mtp7GiztbbitGePG5uXMtqNoDE1dkS4JeGbO
   ZEBkiOhQdulOsZHXv6rn3lxhVCo5MtscxlbWGVLTxhU55xXPtOEzJBOmr
   UnPfX844Ft3oCDRXNTYzIxB+ViHyvNXHcsyU0znp3Fg1JjdgQbhbu6poP
   CHK4TIvtvGG739v4KtcIYKPVE+Rpryh/B+EKAbRucKMafYOBG5Af3XkJ2
   WBntsLL/DZXBaSz3jayZMJOWyyI75wM5g9izBIhJGjacWL0ETReKdla76
   Y8knURtmclb30YbvGQ5gSPu5epsXA/KvoskBtsHaMnOOmBxj5OyD+bgVv
   g==;
X-CSE-ConnectionGUID: XrOSjmRCTKSalU+i5+hAFQ==
X-CSE-MsgGUID: X7hFEYtTRFqokZF+wOxVRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="36289186"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36289186"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 10:02:07 -0800
X-CSE-ConnectionGUID: hZkny5+WQSSjf9kXUWf6Yw==
X-CSE-MsgGUID: 7eRJlmvNSTWJQHoasAm1/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="132695235"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2025 10:02:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 3 Jan 2025 10:02:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 3 Jan 2025 10:02:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 3 Jan 2025 10:02:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSCjwZflbzpc7UyJeRXZ0DUbowcxnU9w30a+XofZVSRj/EvwytxKeOevIqzWuSEayKqblptHOvu4gonbQ0oImDiVTtkJVV2seir5eMiL8UoAtayuYMyHt2WmPpH3twQv1n9t2mMx/rBxtbq9TvHQ/cfUqG3N902+r/BWWeABWK+ihpN17EKli4WcgMOXn1n0vnFdtLOQxnYHruoEeq934jnhS96CW7bbFeLgjnt0tN3X7HhxnXn7DBBrvDEQmrdiYSPZn9VB5Sho894vR7vo7vUvcgh9vPip7EmStRHxjfmTb41ABSCCuBUGcwBhD/XeFlYKOSUXy/fvr6HdCZ7bqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISJ2uHIPRNHkRWNRhf8t4+N2/PB2WHIyo1mEHEA2Ng0=;
 b=MPkUz8pJ04eFMUaN6Noh6i6IMb1BFmlL1nESVavdFEk18Sn1ESBicRNpbEQrsKWUc2mZ2+XHFQtRjG3UzK6Tz+EIpt+E8Q6FVx//g00XfOLETW3ZD9K/J3aOSYUEMoyURWMZlAFDipcMWAWOv3TiYW/HkICO2XjvXzixRLlmJk6IqKQGgUnJORHXl/9ER5hjbQy8PaqOCcZTh4X/xnq6ij3PUsb2LvXgtSDCHPq7lCij0OLW9aRqn+ctIz8CgVKS+ab4al0zXFHAHhkBMlzb4ZJopbFgOX8GLMxmnXDinrkYiMa9YNk1SMik6CiyNT4SThUGvBDDoG8qDC0rEFgkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Fri, 3 Jan
 2025 18:01:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 18:01:17 +0000
Date: Fri, 3 Jan 2025 12:01:04 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <acurrid@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v2] cxl: factor out cxl_await_range_active() and
 cxl_media_ready()
Message-ID: <677825e03d092_bbd3d294ca@iweiny-mobl.notmuch>
References: <20241213103906.378950-1-zhiw@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213103906.378950-1-zhiw@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 790b6f3a-9dc1-4c9c-426d-08dd2c209e8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WQGkCDvJgr0rrXwWaf97y+G5jPznAt84ANcJoA8I2L99CGRTElm/WueA5DpG?=
 =?us-ascii?Q?ogDfSaIJwqGiAoFael1CXalVe8vemGknKIZZK53Ug0BKF7nRwNHF/sOniwjs?=
 =?us-ascii?Q?td4Sg+1qznOJ37AR9+t+QGwuOCPn3eftn2YAndss8aTznVavdhQDUHYsylYs?=
 =?us-ascii?Q?yoBJzNegqgaNoLOgNSfuw6JLd49fXrLX63DlXgtA3LLjJhm7Cr869v9LkMmY?=
 =?us-ascii?Q?PYVdL2YIHUDVjOk0msXOjSiXxeKkrslEq+on64s/WHDI25ZvVGkOVatxCyli?=
 =?us-ascii?Q?REtbRt9jwqlwu6tSstJh6INhYYAxS14wiILH6BXN/eR88dX1DQNILQtJOs4E?=
 =?us-ascii?Q?6PFcLb+KjKHdHS9dGuw6znLG4a/aBdFjCpdB8rRs/lDtkELtbXLL2FoPCR0w?=
 =?us-ascii?Q?ruBqdo96ePpqqQnRCIOQRZGIc1+BiUmDMm8CyaSDllOikqBSTLpXaknwJbw4?=
 =?us-ascii?Q?uUgfodeDlswaOVM4omk1MlY/A5QI/RhfaaYMzRAwNw0X8eafivzl2X2KzVqS?=
 =?us-ascii?Q?RDSZaWZ3KFchSzSxfYNP2P4/D607+0jQ9YpCiwa42YlVTIt6tW8ibrzpL0OY?=
 =?us-ascii?Q?4xZAZ/lXcTWOE4HxvuIm+O3vByNLKXq0Jp6iA5tpmzly6rOFaLBe3D/Ihb2e?=
 =?us-ascii?Q?JIHQE/u/EWr2il5WDmUxXRO4L6G6E/Yr/VP6ngZdsbzmjvjNjw/qsq/Rd4Mw?=
 =?us-ascii?Q?wMbYocnaeHG5ljD0i+UXWKcu44azRB/ecUe6Q0vBDm1EDujAPKejs7fKcd3/?=
 =?us-ascii?Q?aPhslFCCj6iVT/a7Nnfe48fmxiy16zwlCrBSMlfwX1KwrIrR4Lj+MT020A//?=
 =?us-ascii?Q?kva0rnnp6/6RibzA199eSymVoJxI1tKYWGmw0khmE7IJVLMtbMr3gsWMgAf3?=
 =?us-ascii?Q?xnkyyjUmgXKvyQpL4g7aeKzziQEOZEjT6cKoat+qHe2WuqJYA09QzRlTqD6m?=
 =?us-ascii?Q?HE8ziFfgbs9iHE9OqhK4aE5+xX5zM8TeyyJnUF5c/aAAgDEAJ5uWI0Iv76fI?=
 =?us-ascii?Q?fWVGMcC4jdIqt6EXTXTZ8EL3y5JTEIuCb9ztyqxEv5TuLMzOwcLITXS7JOcV?=
 =?us-ascii?Q?it0imrVsRFUEP/3QbiFokZrTZiGPocQxAAs2nKYtOAgsT08kV77EPwYjH+rk?=
 =?us-ascii?Q?63bw9YVgezI0XbhCSk1/H8qsMJv6+yCaNkJQL5mKJ9OzdV+fjQpVd7kVXB25?=
 =?us-ascii?Q?WO9gFZTOqHfnvP9lo/a65CKYFyoleLF2lhBqiyNnxQoReVhVQh7OredorgSb?=
 =?us-ascii?Q?rHFmxNU0rVqCeA2faJT1qoEu414OCR3M3i5SGXIla5+LaZ/mwk+wD+IaB0GL?=
 =?us-ascii?Q?kEuT/oIstKmkyLNU+mGo1OVxneTUpmL3RdYezB557gRILXli+k6bqm9GKUsg?=
 =?us-ascii?Q?OAy4sVXWa1Fy19DQmT8Za3I9wKL2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gKgJoRKi17MzXp3myF4wJO4+98A33d9tZCY4xx9lmPNdRcUkk0Hb4ZH9nZ3?=
 =?us-ascii?Q?YWiCVuqyeFXnp5K86u0kuBt4kJLrRBINPle48mUf7eZzovCAkGh6lkwcAufJ?=
 =?us-ascii?Q?h3r0AmCJkIBg/p+eiRyybDEJMXxRxhysIE5+qatJ9s+BAv+49/wvx1tX91eh?=
 =?us-ascii?Q?WTkz9q0G/dB1lmqLrvdcz/p2rW+ZClV24kHKqhJce8ZX2BfjCalfnsdFjNvG?=
 =?us-ascii?Q?Oj3DKBuKTmL4QI/SjOroIfnUifSCXvVdkxzKyDzwksUAVYFEQoGt5kKjln+r?=
 =?us-ascii?Q?GuCVeZy6vSCFDqCfyKpBwwaDaaHDR7mA3MlOV0mCMZ4Cc24p5JN+xUfY3ZaY?=
 =?us-ascii?Q?y1uargMuU8V97WbDXgShh8lq6CIMGT03tZNqibucBwfcaD1wE05jb460yD1f?=
 =?us-ascii?Q?qpTjPmlGQNVQSAIottdtsrq450n56LB75fZhbt1ouxPV8/SY1eLyuyo/DCmG?=
 =?us-ascii?Q?LI6v4mllk/WZYzCwAjTjgsLwbFggGWkBYGw52Z4ZGGK7j9f765BFzoG86yly?=
 =?us-ascii?Q?1WcsZXhrC/CmDKwl+PmqnSEcjkIF4k9cP158coXmuyKnCrPa7K6aAGnJRITA?=
 =?us-ascii?Q?GUMHgMsDL3HhQyeRmq5sTkvmxF7Cf242+CrO8h8sSN3azK6IBjre5p6S/slV?=
 =?us-ascii?Q?BmRnGG2oYRR7DVaZVM/fXUpr4H1GrlXgDhr70W7ZwL5AtFai4FbL7eA8Pqq4?=
 =?us-ascii?Q?nj+qNCT9q+tUUm7rRNESRE725r1vyZLFWy7rFX9ybtWpQ72I10OIeIpRWeaW?=
 =?us-ascii?Q?3mriubwYNujGB/fNLpcXXqjQOBodGNxdF9CrHnk+BsylnPCcWsqHBD+uZKb6?=
 =?us-ascii?Q?TY9+vtCkbhm2Z6h6Q/q8vpgENFrFu9Umk+9Kk5bHToTe1sldYyweSDHv1R6D?=
 =?us-ascii?Q?noIymdJN2juAvqyJGFWPVqtMu10yvdsGFmFks1MxX7A1gBx7aOjgOzV5nGdO?=
 =?us-ascii?Q?bAX/xwKdvYQfCTlhKfrq1We9ixFzQWu6CSrvqOhsOBBycRl8WBEFzJIB0zrs?=
 =?us-ascii?Q?SkiEA5dhvC1W4k66rmXHo+G2zyNSnqGZws5SOISgedt3wUrnO/g15sk9e8rR?=
 =?us-ascii?Q?g5GTT+xywXSwCxJsX+GPqQ+H/6zjb7Pus2UVdTs261o3a8BBUm0pDPYnTiFJ?=
 =?us-ascii?Q?JK9atKNyVE4uMNiePMKNHjEBnoTFMx3gQWVqGUBrT3gWHg8iL3JJ3Lf+1W0g?=
 =?us-ascii?Q?pR4SJRmWqY8Wc6VHHG1zRqT7JJWlPvHCzkFOerLC/hBGc88v5CwLUSUZ2LY+?=
 =?us-ascii?Q?IgNvBtDTEE1FExVWXtaRIFXwgssLQYIavjG0nzxbxxcIP/9ayrjoSVhzwIhw?=
 =?us-ascii?Q?QMv3rIvLkK03+gU8gY5W7lKkvTIut9Izw+QE16LWDy/mk+N/3/UlqemX5Kj7?=
 =?us-ascii?Q?EVzku6gsbpHgzuVjB/2j1tMsZQuip6g992MyH9bRNnYDbRAprMdTsL8ERg36?=
 =?us-ascii?Q?rtdLwAniwLe+J+g6iipLdmDwARLzJDIMAUh1k/hV9zirelxjBD6yWCjAH3DB?=
 =?us-ascii?Q?V4UW8b9yZgoUl8SyujKZqPjkaeqrMFOULmYh4tb5AU0puO6on3H3/qOx7+2s?=
 =?us-ascii?Q?rCySR/6ZE+OWP8gSx+R+Ve9AbA1CVq52lzxwsUCO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 790b6f3a-9dc1-4c9c-426d-08dd2c209e8b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 18:01:16.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hHCuT1ci18SxZUJdWzbppVSRsmR03iE8xy131vYtV5HJ+ICrCKENFF5L7sPpZz2j/Z2pJw6OYiJIcWt44zXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com

Zhi Wang wrote:
> Before accessing the CXL device memory after reset/power-on, the driver
> needs to ensure the device memory media is ready.
> 
> However, not every CXL device implements the CXL memory device register
> groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
> on these devcie will lead to a kernel panic. This problem was found when
> testing the emulated CXL type-2 device without a CXL memory device
> register.
> 

[snip]

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..6fbbaae4a79c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -846,8 +846,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> -	rc = cxl_await_media_ready(cxlds);
> -	if (rc == 0)
> +	if (!cxl_await_range_active(cxlds) && !cxl_media_ready(cxlds))

FWIW this logic is awkward for me.  To me this says 'range not active' and
'media not ready' sets the media_ready flag to true.

Why not make cxl_await_range_active() and cxl_media_ready() return bool?

	if (cxl_await_range_active(cxlds) && cxl_media_ready(cxlds))
		...

?

Ira

>  		cxlds->media_ready = true;
>  	else
>  		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
> -- 
> 2.34.1
> 


