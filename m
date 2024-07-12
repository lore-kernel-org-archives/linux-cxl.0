Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A317D2;
	Fri, 12 Jul 2024 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744336; cv=fail; b=ZYR2coPnlGI/BResWbBwf58gc30VL9espGvn5fmh0l8yhGBnT8xAp2WBwUVzyMGSElCKf+b70dCW2GYpBf3XcZwFXcWxesL1vS6d0ioqe6VgfY0bRrtJ0p65Yqbox40pKA9wS6JlVANRxgO7IWD97b1OvQyQxkcE9Ozdelu1T+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744336; c=relaxed/simple;
	bh=yr2R8yuFSz7OiD0M9xT6yxVat4tayro8c0p8PzMVAmI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iw0pPMbrprHTKnMT6LuasXDEHtjOCViqv6c8EqraFdTgDZwM0fkCwpPCFfSvCubkO2oflk8itTOyz2TCScC6lsRLCjdi3dUP8FZwzbzE9ttKQGUtEQnJNeL8l6Yew4MzcbwyCuLu+k62sk4n1GXZIy/LdwXbITv+h6JhVoys38k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQysABYA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQysABYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720744335; x=1752280335;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yr2R8yuFSz7OiD0M9xT6yxVat4tayro8c0p8PzMVAmI=;
  b=TQysABYA09Unc0FfrpsGphEcDJQdNhLq7ew/L6bdIE/7yxbdP3tdh0D0
   CL38Nxrz/GvbVzJaFHDFq+UGZDQBmuixI02h6RWGMASRSOzHV/LPUQUkE
   851slM+7jijYbvBBpzuSFP81pUBIDbPAe7fznfwYubRztbSLr/7vISEb9
   r8/DyPISZFMpXQbMz8wjAsVok4LL0CErB5NgWhAHTaICS9b0g703P/gnu
   M74X13rTkIdxiuwYN4/mv53Vn5YWdAtRypYFGm0cuUUnRrQh8Y+bPT1vD
   dZgs/nMzQ33KRRe5tJdr+mBT+zXt4Zo/WM7tWXJS4h+BKmVbcbWvIwIBO
   w==;
X-CSE-ConnectionGUID: iRUCVPf4Tvau8adtFWUftA==
X-CSE-MsgGUID: BRAXOSB3She1rcIcEFo40w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28769904"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="28769904"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 17:32:14 -0700
X-CSE-ConnectionGUID: Bcq+ZkKrRJmhUYbhBqLkYA==
X-CSE-MsgGUID: j2zseXtqS3GMyBlfy+5FUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="49507210"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 17:32:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 17:32:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 17:32:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 17:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajyxv48+QPQdLmQJkoLyV+l0oFYUK3Pv5AIXoaa2cpJbJxx83cNVDktMbljNOMgcnUOzdGXOEk3k+BkTGqyde3vQ7tkZbztB6peuvlb0syCxegTqY3XmJ5IvKh91ApMskT3WTmL5eAzN4OcixYsiN0RO32nh089N8xHOgEJzAunebyZkYw/lTTjCJ1AYX+LlPg9tBsRyNPxSPfBed/Ysx7Jtg6oxZ5oXkTQjC+j41lOuE2gDLNyPQmf9tpKyvvkPMWzsNlrU871U5PAh1hnCpHwAnAKEywbav2cunl53M5ARbZ3nLtj8FoA63VMC7JbifJmA9Edb1lONG+tl5cyXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6aV2L6D8IFOPT5L1iVBuAqI3g/tIk4KPBVDoegIglE=;
 b=oV6YB3es1Dkf+Qmngkz9nAfsX+5wOafrbmJAPh6Px0IUp/trtZzkuLsNWtHTlwZLASJcsnUnxOmDk1e3KRaTRxJyqiNSgZr17Cp7M4ypc6G2o2GqYNE3IESKNEU4XLV2NDnREOpGQjRrx71rZccsucyZzNOo2vnagS5X5/xIPy+UE/gN/gnxBiMViKReX9j05ZUfTMaqChMjsYxZghi01PpjHWO/W4FWdbBnD3jQaX5euMYqgidAjNZ0od3R27Bb5m85ie/ZdG2j8o1qbX04bhBxwA6zIchvBm7c9pNV5xCj1JnVbDiKuNux+Li/9y7XHY7JDSMG2zVJvF2O/gQQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.41; Fri, 12 Jul
 2024 00:32:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 00:32:09 +0000
Date: Thu, 11 Jul 2024 17:32:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: Re: [PATCH v2 1/5] cxl/hdm: Moving HDM specific code to core/hdm.c.
Message-ID: <669079864eb84_5fffa294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240701174754.967954-1-rrichter@amd.com>
 <20240701174754.967954-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-2-rrichter@amd.com>
X-ClientProxiedBy: MW2PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:907:1::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 79920548-c723-4c10-3c71-08dca20a1092
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MQmln22RMpctt30JZoByQWJu1yxyOpl6DTQTKTh5U/XRISVk37hmKyPeQfyt?=
 =?us-ascii?Q?kYhl2uwSvxQlyrhJPU1ejtTEBe4GKcLqo87z9173a4rcsRUs0gIw3CtlBy8J?=
 =?us-ascii?Q?OzaUjeCQUkYcf34JEGa74sVoRlgtT9DIoz6C8OnmKxHfGpmP/LoWxYQIzobd?=
 =?us-ascii?Q?3FXxtNIW4w3xswZWq4J+nfOh90+KXpOX/N5OXnMnNL56oYfJwwVlW1V+kDf4?=
 =?us-ascii?Q?FPkfIYhsu4rMVID62gku2dVX/XUQtOVFVQYENrBIXpGQSxiQCh2qEWg9iHUl?=
 =?us-ascii?Q?8Q5DAa+5vPKSrgDhhXFwlXxqJwoyTxWUIjT2gLabC/xlW4CKld0/I8c1hXrz?=
 =?us-ascii?Q?tYBY7R61JVlIBHnBScD/ggs0eaWfi8JZMhnT9B6i7VaY21ukpPdXEBbhF4te?=
 =?us-ascii?Q?47CS+fnwQgqavhEIUF3Ap5bAjl0+hCk5AlJtKW8OqSQYDgUfcgjQMfPlf7du?=
 =?us-ascii?Q?bl22tviEr82sEDsaYTpaRwTIpfvL/ejWiQFekmy9LIFmWyetp7025sFEwyIw?=
 =?us-ascii?Q?t4gcbIi8AxloslBedktZyKPY+uXVDj5dTrIb98D0QOXsYKMGELBzhb8khJwf?=
 =?us-ascii?Q?lIIS6VKONlm37Y16cHghOJDo3YJppsIDi3SN/q2YwqTAlGkQcxyJLK4BZ719?=
 =?us-ascii?Q?csDyIFk9gOUb9J2ocJSEcl90RqA561Xn6qEBrEPRc/US0KC+nYPM39JPPDRH?=
 =?us-ascii?Q?X3mNOmzalk9sliqowpDtnzscCuX7GQoN8z/ffGD48Uot+dcL5ogBcoRGZJWA?=
 =?us-ascii?Q?AwcdseBOT/C9yCqMCXjf0JJfMrRQpOkOv02XZseHnnXuowc+o2A/FYokq5Xf?=
 =?us-ascii?Q?mUeEEGVWxusTFn/bk+Z0CHpj44uvRGemSAsUNMLAk9iIDz0a6igx1EqwA0Jm?=
 =?us-ascii?Q?y7GH2gH749riVTuNTelOQe8OxNarQIYdMtJlM1Ipbanc19/Zc6ZgU2FGdzCm?=
 =?us-ascii?Q?qwp55KfungUgRph8gfcC3guzjQ5uDUhMYQjqerrCENqV3/WGSuucpA5XVlOs?=
 =?us-ascii?Q?551RezISJ15KDxIUuAue38s2Ut5UFUgpVdyklIAajv+sgU7wRgCr793gHnLB?=
 =?us-ascii?Q?BclH7I6O2/GJlkYf2APPAuEZRhLvWmruJdY5BWLi3X9L7y3OPq1zymb2lGKy?=
 =?us-ascii?Q?PqXWJkf9jw8hUT/6CYh0bOyoAmT053rqdzfQLiV/+Ihciq4JgMpok84NvD2s?=
 =?us-ascii?Q?1YJA935ICYlQbCKxqvQu9goc1GoYpiVsLg7MxLziwCcp4mofiJSsWu3T465a?=
 =?us-ascii?Q?FzHrgN0kK9W+C/SYTeW8I8qJSTPzqWBi853VTxPZNNj11qA+Qva4wdIc8xRO?=
 =?us-ascii?Q?AYEyJVGEOHKywaMfcxZ5BEq/MTW9HAh8awvMEHTCu78x1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GC0qDpFiuNEz7aRGPvZmLsOMI6wAhaoRrAYXhI+Figa/nsSUbmy2qoXXCvzl?=
 =?us-ascii?Q?nwyjZWAB8vdMcUDEeMbvycdOYLdMXLFLQXrIqDbE22wtjdsPluCKTqz6EVLu?=
 =?us-ascii?Q?KlPYu0GxQwHuaYWRK/TcLl2NeaMotEHFHOiPGae4xnEZZ/XCs4jYGeHIaUce?=
 =?us-ascii?Q?k3+ic//THe5nxeSa5bzURNLnj4vrHcuq6LowajwwGn56JHhXvDC1K3S8d6u6?=
 =?us-ascii?Q?8UTzTN5Ms22eUYr79jumiD+7WbR/6S9mAM7ihujHaS3VNHQTOJWoEb8OefwG?=
 =?us-ascii?Q?7GOeH+DKB84N3Z0+vSOJ6ZPwyVdZHso9N0Usk5s7467TcFkOs6BO2K13jo5l?=
 =?us-ascii?Q?GlBoALH+IaWugRubah8pMn7c5htSjP1rJvYPP8DNxreEU99v/mXH8prPRqgY?=
 =?us-ascii?Q?1F8ugVGbLWA/i/PdekLqnDoxhTKLVRWNA7kOgS2C5iGhWiPc9oUgcMtO2KiO?=
 =?us-ascii?Q?mGtOZiQYZvE9mcgP4g66fet6/L7yA/88uZm7GWzNcuNaA+aQrk7MtMo8J50a?=
 =?us-ascii?Q?wPyxeYTKjVdLjNydzUGYozYc628jIfvXTv+dQlOFiAjGYQKHqW+BE232s8dd?=
 =?us-ascii?Q?OH+kMzZrAYdSTZx1DvAY2NwqGPEufKibT5HlewuVF7yU9hf4F6a1FBw9MpUq?=
 =?us-ascii?Q?s2sYVQVdcmkQBcTYSqUiY2/fr4RxCrApzXnLQSMIEtBdWo7fqmWYSZqFYCGW?=
 =?us-ascii?Q?xyKrElO+su+aAt/kpyiLvT06jT6r/IU926QsrzIB7QbMRzIdRQRj0/ApkeBn?=
 =?us-ascii?Q?mVY3E3EA2a2ROwggKlLuJ+WLUCi2wyv9yJgmAfp4SAJazsQfAUUWnJhNGWKx?=
 =?us-ascii?Q?fEivqG7NmuERYPQ/THgoG1mOPhJg+tV0fIq3rCj+VCWYNpxBNYb8NXlsqC78?=
 =?us-ascii?Q?7gqDLfCC92y6BV0G1jtDehTv/vC7JLb+oxJ4tmcfx0jICQ3zvPZUiKg2tCTA?=
 =?us-ascii?Q?mt1X0E97RCNoJLGtxBxXC+wvjpGRxj0HiBY6QebHV8Ompc+BqVIXS2XnxnSi?=
 =?us-ascii?Q?ZD2Nbg5FAOYLqUs0Go5/bh8Ofvj2tvXNfOE39M7ejy4FSN2c3Uf197rIuDmx?=
 =?us-ascii?Q?MApf9WzZ6Uqx2FGw8ACZLzjAkIoFIqptr0Bq8ugkOlhlkz8pFnqL+FEGxjbL?=
 =?us-ascii?Q?5by8RgcOXkYHgi5eCtDVwpBLIoqRnAzCLoNcCLjpZ/xdoV0ad9aRRnPk3yBl?=
 =?us-ascii?Q?vOeACVnOpMMrC+oCWK5qq8Sw3qyjJ0TUB5ViLuxjSIN+gSToEhyhd5Ddyqrt?=
 =?us-ascii?Q?+EXQKQ1mh2LdhZQ9KXXMvg9SAKI5HS/eM6//oIpKJ9A6VJsVbKOL4iglHBau?=
 =?us-ascii?Q?4daoZ4rlFbfLv2p76E4d35lxWFJlz7VUVQXZk856D9siX4rMLtzc3t3F6w0t?=
 =?us-ascii?Q?uHJM3Ck6XC6eNE0PIni1FcoiDgo8wcocuejeO+o3arDnbrYN48L3Kb5w+3zk?=
 =?us-ascii?Q?v+4Hti8iViXegeN9wGY++BvDmFnxfmIhaeWq8pHqfJW1oTC77LsHGDbyWmum?=
 =?us-ascii?Q?eVYADqjIhMYKJQWPxk/UJGx7EeK2qEROHItyH18pPdgK0wPfEKnTIgLkrmpB?=
 =?us-ascii?Q?CLm4/aQnkZOnMsnmv3l7gy67QYG/wwqodqPvbWT1HC/Dq6sfSoKbnMPk+k/N?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79920548-c723-4c10-3c71-08dca20a1092
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 00:32:09.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LiD2ng6vZg85joC/sANFOvcexroBZosvvaI4Dx46fRJJFuDfyVQO8VDFqSLJQAJp7TGuc6VzpqmGQzh9B3/+gQKdNu4t3xSj85wlwSLL1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Code to handle HDM specifics is implemented in core/pci.c and
> core/hdm.c. In both files helper functions will be needed for address
> translation. To simplify the introduction of static helper functions,
> move all HDM code to core/hdm.c.
> 
> The function devm_cxl_enable_mem() is no longer static and is shared
> now within the core module. No functional changes otherwise.

Looks ok.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
