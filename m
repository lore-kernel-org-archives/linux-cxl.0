Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED441204080;
	Thu,  6 Mar 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294761; cv=fail; b=KkuRtbysA2YvmVmpOlr5TtHtg8iYUxm3FsejBRTIFD5zZ3p8vqdphLJI1/bu1V9SeNl39AXZSyBaBO/+mOaWgLN0gKJQYDWEViLdX8UYPSilo7j+J+pFXhjU0NWyZ9yVCztJjyODK1/niYkLQRiyzOg1vmJY3MJ2pP6W8W+Wi7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294761; c=relaxed/simple;
	bh=XqI7jgsZFXPYOrYAlZGbcBb9RuGpgZJnCL6OiVvvu24=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJVCZ+XTc5+cmRhcDk4XRFAOt3ypz3huc0rILvGJhHw7SwxdPmn1HcAkbfLpjPkb/O87xS6FFFhlvB3Qq/76K6hHVASj/w48yuSb9wUaRwhhIt3tcNqSd/HShQBo6WVMKD3/rJHxzhUOXuPdjtm5QIoTDWF3CpDtiLLZbJtbWrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7Y94e80; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7Y94e80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741294760; x=1772830760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XqI7jgsZFXPYOrYAlZGbcBb9RuGpgZJnCL6OiVvvu24=;
  b=V7Y94e80bvUY5+/hbvrP5wK+Uaw1s39fGpwJ9OqlnnNP9+PeQCAvq/oE
   q+gY28fZxJBT/Sz/l90D6XkE4bCtwoN18q9RKUa5mKqLkuIU2D4BQYXcb
   wSTZ6IX4iXPSym4DODUdW705sL6zCJkrzGfbx7k2mXpVl2mCWJcu05NB1
   Ikk5fAG+o6aB7FiVumtgeU5VNFp+dtG9eLa+KBk4sXh4VgcK/6OlsQT2k
   mmr79oJFwSFO1xHtdfpqki7Tm3IdobdRrnlJRh0MGbSoHVFrbar+vE1St
   T7U09RGA/ki1E2xXqnUgmooHGJBfUeof4TI8SmS0DnD0GrWFcOWB2/vIK
   A==;
X-CSE-ConnectionGUID: /1/Wo3ZYR6+fLr1buoQshg==
X-CSE-MsgGUID: L12N8gkIQvGh4AAJQ25NHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42528950"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42528950"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:59:19 -0800
X-CSE-ConnectionGUID: QWVuR+vhShKh2SLynoK5jQ==
X-CSE-MsgGUID: xfLbSi7ASqu4Zjxzbgbruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123321162"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:59:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 12:59:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 12:59:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:59:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT0FgZ5R90rVA7S9nATxhzWebpxGyl8iTlM+2T65gBwfMcJl3DTl5aNZIREdJ56y0MFoOABSpEHn9VlbREcHTs+69pn32wWNKVBKxqXmgAAoCY6Qykb+FDIjipIQGdDmKDoiVVoAkkucInMA8Z1gjakCqLm/+gVSJdzM56n7Zw+GQXryA9/va6LCnEPQ2O+Z2fJiXpkuFfu8Jw6XONADQ8yZbq4D8zFt4hc2f4YjZHURaVqV2MLtNdMc5CHD/L6q63lFOhI9jS6eacwEp6RxH9QKykcoFZkEzOsSIv6LoGi1tXDSP4VHKf0g8R6v52NjZXhKwz5vbYupsOy7HxgnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnUuoEZypXn9DALRt3ikPZd5tfHTAzIrdgigACvTDa8=;
 b=l93Ys5/Ao1TCQAAFAmxVE/lFP6tqpKLcp0YGS2BFX6RfZu28RLwVFI6/9XLcHM+eo28LS4XNCMiIcvsByIp3dNjXaBZjKh+Ot2fFTVNW8BL05thN50OnVFymk+6J9UCzHrG/AthDY93JnEUbBD6TtFEKUkU2fe5qPZu1jyG75/erRRP89lMW7ViOS9INZx7LUaKzE9SjDFFqX0RYMaLGwbx0rENesoO3XC7o6o8RJ74IERpPHKdBNQIY3B0VfemNh/+7H+OOuLwyBGi1JWbdu/oi5T7RoYh0lUuqV9f9hWhlYc15rQMordhrWurSmrbb6ctc/jjTojEtr3u35onqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:58:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:58:33 +0000
Date: Thu, 6 Mar 2025 12:58:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 12/14] cxl/region: Add a dev_err() on missing target
 list entries
Message-ID: <67ca0c76d627d_1a77294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-13-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-13-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e7a5c1-bd18-491e-1d26-08dd5cf1a7fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eN5K+CC7JAPCqoSHniBjdUE48OF4OApsRYZy42o03UypGcIWuzK37NPVXGlx?=
 =?us-ascii?Q?k9AjWBP3xurh/p+HTtAQavsFHZEKVtD7bNDZu0kCn7AlNjHS/s9dJwPnKiXr?=
 =?us-ascii?Q?IKK+bH87+8SluvawbttZrVQ/324tNL99bu2lWQ1kOox4tJrqHlFZcCRm+VQ7?=
 =?us-ascii?Q?LS+5lxoJEXO79115/W1/gnyKvLN/EYV5SZ3fP9+IX2n4qQ3KZulIZ2HCxqpP?=
 =?us-ascii?Q?qsunWqEzbdOWZUyHFFmgPqa6zn8LJ2z2mvydxas4kQpzD5x9vW1gNhcaZddi?=
 =?us-ascii?Q?gxO1Ckj9b047whu7a1S/UvcQvc/ZUr63uJOSgs6L8oAEHI2/h70h8Wey2O1f?=
 =?us-ascii?Q?qVVzHVECEGtIhqMuvvrJ4KO0lyKCVcL6ZDt9AKib3R16wBlqhFYueipO80fq?=
 =?us-ascii?Q?KJsRyLvtExN0n2ba1vXhx75HPOjRTsggJXVRS3fWFiCHr4fDdwfeALPdNui5?=
 =?us-ascii?Q?iIE9KkKQYEwOMPQF3OoCMDUZn+j7QLxfz4/NgDJnDJjJt5G2RPQ/k8MqVb86?=
 =?us-ascii?Q?5nvjSl0HyMoWSH/RmvCcJN4KWjuP2AQ9LggXm+Uk/BLNkefwMBY4dcWwcsKj?=
 =?us-ascii?Q?s/T9TSucjrGl2cYks/N51o+y/xMneA7QcSXfXv/OZaGXqEr6v8D6EktqMOSD?=
 =?us-ascii?Q?6lX21Q1jXOgI2Xil2toEan3TkqiTzZLkOUvBVatLuvXpbmyKe5CuYg4yfO4Y?=
 =?us-ascii?Q?csL/R9C51WQ9bwb99yy7wpvmFcOFyH7sNpRMoUi2aTId3A4QwIMWIAJpP66M?=
 =?us-ascii?Q?xLyzD/Dn6wDJNE6ctiV9xVMvuyRcKYu2NcOJ539cvyATMIvJHwbrYGcW5Sve?=
 =?us-ascii?Q?XV1PgUFEgks26Yyi53vStEfFbAB2BmaP2zj81P3cu+Ni9qHSm3gyfn8HUI8O?=
 =?us-ascii?Q?cDzudKB4+kA4Ovzuc1OydaylwuZDugawYh9Hykn8efJogcvvuYM/x6V4Sqg0?=
 =?us-ascii?Q?qR98yX6ChWnTA9wsyTHuP0NnPXdSZpNvOyaE4NXFWl5KE/utADdJg6iz6T7B?=
 =?us-ascii?Q?lAAzAdJB2VOUVTx0rXj7PMRNwQZCwVCVNJz5Uo7wh+CWHkdgujO5y3AHNsz5?=
 =?us-ascii?Q?nv+ywx6QQBldPsVlIVgNMKDalqyUvZZkzDcCqKw8vealTvPi5w4ZZQa9Fhat?=
 =?us-ascii?Q?SS8VcuZggbY2r72Jfm31NT2pIKg3+9Rr8g4fx3WSTVa6Fp0rAaJj79Yk81rK?=
 =?us-ascii?Q?MYExoeMWTlI4wgb/wcnAfaVLxT/om6k+zDrW98+byrK/m4BxyAVlNg/pVNor?=
 =?us-ascii?Q?8Igc5XJEkwfHxlW79+CulEPhRl2xIB+7PpODc7jqzTpvzD5Jd1qgAWKbKsGP?=
 =?us-ascii?Q?wmA/usPez27yo1+cFc8+ZFgijOqaJEVnrZDdkpK/8C7OaB0j04wmvcRm1eJH?=
 =?us-ascii?Q?c9StQQiDNcE2/s9wywgPMvUyvKZ3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?umppDZ7lCYJQw1nTER+GMQQWM1y0CvA/FAQd7jUmbg1UnBtVk2e7u8K0nkQB?=
 =?us-ascii?Q?Xyc0fOqzfb1hHAlankJQdFBG3Y204fR4IuZwhSzhZshILmwI3NpNOJpTAwMR?=
 =?us-ascii?Q?aGyHZLo7TsXTCln6kQx0Yl47Fr+0NhuErsuO6kMsRMtp9622uoOC/BjpbUla?=
 =?us-ascii?Q?xbfZNn41QMDv8o0MOs0iaBU/9rqZn6nHPUcQias53u9vNuKP/z4TIYQO5D7I?=
 =?us-ascii?Q?UOZpw1YzkQMagDzqIqTYNfi6hQvJorzuQVRu9rnIfhTMAB3rA8WWm//3zlE8?=
 =?us-ascii?Q?P1XQlwEhfCpBUpshYhzkNYTBaxXMe5GFN2sTucUUEYE8T7x6VwLiPpIpJHkp?=
 =?us-ascii?Q?wqGTknStNXcJaDykycHvsXwgsDsHyEKEFEez9OmYTnaqJ8Yx1lZ/hu7YkTH+?=
 =?us-ascii?Q?jb6JgHCUA2sK7P0IbHjTbaErPw4AyxbF7Otd6kEV/RqdNsqY5O4Je6+VuuIN?=
 =?us-ascii?Q?CDrqcaqEcDoFRImcO87T1zRQxpNuKFoTLh8z8UUOMOzCZbg4ccwMuP0erjC6?=
 =?us-ascii?Q?QAAR7zoo83k342aYBDisRdEQyLtXvvNixr5O/LIX103LPHITjDX2GVwibebI?=
 =?us-ascii?Q?AExS96Uu/r4cPGMT+huhlOIcY4k6UcOPj/cA2JF/P4tbaeUOeECzc31oTpud?=
 =?us-ascii?Q?g6KeDB+suGWJlhfM2TAeiJQThnRmoglXIIM3zZz17T938nevk7ksO+XOI5Bz?=
 =?us-ascii?Q?2AYZWxEawtBV4fsoftaxeQSq/OOcL3TzrMxEGtJLxg+a/X0/eFPm/lKCmqW5?=
 =?us-ascii?Q?3zyk4QqLC4hVmGmqqCAPMwS6+MJ1XhXtt/UrgNJB/jDqxvJ1hpPUDkVc+t2m?=
 =?us-ascii?Q?oNM2jTtSylFo9ZyKDoq08nsnRI6gV+qt4gHsv9sBT6Pi3z3q7XPpEU3thdxM?=
 =?us-ascii?Q?+cQGRRaAK4VlCxsUKWzUfS6/ztrpHqQL2hPmYakLkyHX9vmqNNp2rTZ5ztZz?=
 =?us-ascii?Q?OOpOuSCttT0994QYPBeRGmt7DcYqR5q66x3sCuPGR8Zp04wgTDyPRKuGh9zG?=
 =?us-ascii?Q?nxJ631i8cm5L1eO9pKJe8uD8OhkgQwrXkfEFFBd9rYJGxSrDmgtZyknk5IP7?=
 =?us-ascii?Q?IvtB77IEzHFzboqikSIeFT29qFKK+dkagCRQZKbfNJyG+5SckWFwD7he0Z+B?=
 =?us-ascii?Q?pApKAZNI2nWwRpcGVMd2VhtL4G0bHvpbtKE5I/BPzkq/QRxTz7/eR/Dlh5no?=
 =?us-ascii?Q?WbHyQrMc6fXV1dryIXgQnbD9rjKIC92kUVcRWpl5CxDDz5xEH96efiju4QBG?=
 =?us-ascii?Q?1kmmDhGIADthKCK0mzG665fS4QabS1VjQbgFqwl7GLkX396SahD08a8bkMO0?=
 =?us-ascii?Q?YM4ZT8WkJYcYsStgQLTG13ae7w8OwI2ZeeiGABTI6FWXf/nW8wgrBGeq/zZq?=
 =?us-ascii?Q?lyHhBDZyRrrB7wDj1GiY5Tuhk+0S/m1VXhpLpqN4K3fx13Tw/pJoDTuE4XKt?=
 =?us-ascii?Q?YE8pmbb9+L7HZ5WiztJh5EUIDIFZo3qNKpuIhwqBw1UOpwQJtcQQXQ9j1yRO?=
 =?us-ascii?Q?znckIgyF3/1hF7HJx82QushFvTacF1NF3hgnhW2OMNiivuTEWcmy6caTNMZp?=
 =?us-ascii?Q?tFUoCYQG19xl+P5p6dQABsbJQ3OIFADhBbyS8m1ioAGOCqy+WJpSCaj9xV4X?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e7a5c1-bd18-491e-1d26-08dd5cf1a7fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:58:33.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bq+RtSNE8tN68iBoVho80p2dT+9QowGgjsjKDC+npMzNq9ErsmFa7xlYWqjgjTpY0RLTgtCGv3zDTR0iZpuPHw0dj7Bw3YUxuthA176LK6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
> 
> Example log messages:
> 
>   cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
>   cxl_port endpoint6: failed to register decoder6.0: -6
>   cxl_port endpoint6: probe: 0
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
