Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216E3B791;
	Wed, 11 Dec 2024 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733892287; cv=fail; b=qnmxGUAxtWNSWm0PZF/S4PCuiI+mXsojdbkmt1pPWN5NFxLoMFrUG4xPGbYDWMubGa1r8NCmOPjb+y25st3mKTbY+iDj39Aul3UZFN91Q6YJgN1XZmblLUo2Ca8ecFpVDFNDpnxlrx0kpAolpQDyq0t0lEE1QjWqv42JllbIx3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733892287; c=relaxed/simple;
	bh=spQZckInpaHp95Ajm6sEmnI11MjWfRHNqMXZUkgZBKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DnFzBdjFm+6vj4sHibuy7Hnea0L2opjhIDrDeNDSCmuHWXr9Oay+BpRdvdcWuGCUEuJsfRs5MqrH5QBcwlniHEvVrp/ifraer5W5k9gHMh9MP58hcc4ykr+UPCCLj4r4mfuCEdH/T6z4agi9GCuy4BKuciyXLonYuKkK4ceqR9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6bizE6c; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6bizE6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733892285; x=1765428285;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=spQZckInpaHp95Ajm6sEmnI11MjWfRHNqMXZUkgZBKU=;
  b=R6bizE6cpy3YqrxTBM89RjddTMYzzK8bvTxIevAxU9noMQVgnnQxRxMj
   SBOt7H3SY3NEQ/E8JERvuhcZKf93YInCcxGKRJmBQuF1xLC9RGVEGXu/M
   ihjxrNyyWugpK+we4gf72SLwvDkEX/q/CrgbPIZHt0r0ZiujD1881DB6c
   zMvj/+l9dqHC5nEdu+MTzQZLrP5RCROgqHbhlE5om6jRs9RoNx0nx7Bmn
   3Zq19L37zeKimBqj+HJ5K3aXqCCJ4b8ss/4XHICJfW8SYUCFkaTYwrCMq
   neVyX3JnIwY2OqsUuw5ICc+goohZFYIXWLBLdPxKy7kWm1S9wW9EUAzbX
   Q==;
X-CSE-ConnectionGUID: wpnMrAYBTxuUu0z9fXerxg==
X-CSE-MsgGUID: Mxm54wfHRdSOYwVprTdB0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34398862"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34398862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 20:44:44 -0800
X-CSE-ConnectionGUID: 2qcRB1h7QOu+6HEuI2WTbA==
X-CSE-MsgGUID: +6t2NmcxR2K2QJMSp+vbqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118895570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 20:44:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 20:44:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 20:44:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 20:44:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLSOOo/5CQC3m8DG+gGacQIlL5M2dBp16MGJxa24cSIZurzehged5Be25i1R7HzUWeAN3fyDwpv63nFPx91UGXsveF6BPK2ntLxw9RQZRr9wQPlTbIPI9Z+gdvcFShWOk690gQY4H3/v09d/LRpfLp06pR6AagDjTpIV8B91usFYdQcZ63w1CNSOxmC81SzxKKC1Cntc+faSmzmqIQdAmvD0tZkfJ5XJ/SGdlF9HaSploKsrljmlsVjGmGWRq0yibhaIXlM96HVDKuZeUlKhqidJbcvK5rOIIaOwLxZjid4xioYmGTannU8xI7/yF2HmmXSVmF26yefAcOuvAzeJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5ONMMYAPKKJLj489lNgej+dZrEt+sdq0qBKo0uf5MQ=;
 b=TkNLQpWX+ZsleQhgnziBpWkpXNky+iI5FrRRwzb2yhpIcBjmfk2sCRwCVrIHDBaDsuBjr0rXvUEwM0VNyAK8bwU2DVFgk1DYCEX5145WdYYApsQYoigY6NyZEnaCBDqbmpiBh35IYyczCNj1Kcq5Sd6Al+Aow4GH2mWQtYjmlrnuMeV8an8r87xk7MFdcVaXQtH2WH0P+ODxAqKF+8Lecv2fSfVi0egDg1/WERaTpHT8nTNde32o369iZXG/v2xbdOHyphewFlLs6ZN4qaa6jbKT48NkmcJ1ympuCq5eTxSF7Il/6pLe/mYwOvShDF+DbtiI6AGO3uV0UBv9JoE9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 04:44:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 04:44:39 +0000
Date: Tue, 10 Dec 2024 20:44:36 -0800
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
Message-ID: <675918b414c17_10a0832943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
 <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
 <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b849029-adb8-4d3d-d98f-08dd199e8561
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ugOpUEEGc/mK+3HD11Wht5uzNiC4Oq2FCcHA33VLHHol7jnxsA+rGsUUyp9E?=
 =?us-ascii?Q?G84RTb2C6DM51puzdxvBgG+iaRVnnTpJvwtIlep0Iso7ub9wf4qERoLrZ6TA?=
 =?us-ascii?Q?T8GmN6x4bSNYmU6BwvYKqte8eblE+KUjHpj0H94Ef8D7GqcCioP+jAXKJGBf?=
 =?us-ascii?Q?+pxr937v0bfRHqBJh6TZWhQ5yEnIXvW5oaJRxb/ePwQGPdYWX/TQJzIbgsMz?=
 =?us-ascii?Q?2uAjce5IByXkZZVT2e8ej6qwJTK5IRjwVb0ZZhmU4VmTfLyiwbVQUEQ4yaxb?=
 =?us-ascii?Q?myzVX5tqbAprulVR8gnz6R7Byb96PLA2rBl1qczs8NPFK4QC2ZtpBYkpSXuG?=
 =?us-ascii?Q?B7Tx2t7Ss/zRJ8T9XSibxkcngSgh7LPxyPJiwX59j97nxSTsZNUVbnwoO6Y0?=
 =?us-ascii?Q?cHdU4Vh9n6mzovgz504gXk4V7wapWD4TUQKssnSgJEzI14E/+0jVObDselxu?=
 =?us-ascii?Q?NHRVneTGTo2unQPQN9KeYDjIXksNGuxcaQsoNxYP0Hm6GzGv0sX5i6GBzza8?=
 =?us-ascii?Q?8bibB0XgGGFqj6Tk0qryI580+bcK/HidG6dLiz6Gv94H53uT11WQzxzvEabw?=
 =?us-ascii?Q?npvne9gzyE0GiYZU0FluSgt0+4AjxVTJmUaiSifK7FEqSrsZUIkjlkXOBl+5?=
 =?us-ascii?Q?klNRbVGuhvi4v0cwq7voIydgJ5MulktrV/Hlh8O3Z66cGUp60JPbuUsN3o/W?=
 =?us-ascii?Q?H5tyntOnbORNlsq/KyvNiY2qq0Tlj7Yb5BrlgYxvKt3v99Uf7yjaYYiTL8nK?=
 =?us-ascii?Q?oxWUujaH5o52OX1rgCDFtEShGtc8B3yFAry8J/2ZZW2LU5YU1x6pMj6CZOLM?=
 =?us-ascii?Q?ck+YeC/1t0WU+EKFGnWbDXOB0fCuGKV+d/+mDuLO3pgLB4XKQJ5KNz378PVG?=
 =?us-ascii?Q?yrDrC5mvrE8BrR661oMnJ3mJjwz/QbTBCUqjajKQwt6f6/eAUB7GBqdlBNbr?=
 =?us-ascii?Q?iBfKeIqr/asF+Lzw7un3mrG6btd/pm79X2nKsDISFzDaNTtuAWeupW6RM2U6?=
 =?us-ascii?Q?WHqe1DwlcTLQqfwYMVmF3RoaJsTNlMFkQSw/yiGzg3mA3nwxi9r7zrL8VU9p?=
 =?us-ascii?Q?AKWpifBEiyKTt7laQ9l+WBNUMQJBtDSiYnuaGNQ3ST/yUeinZ8xBaGsO/dlv?=
 =?us-ascii?Q?dsLaPxZA+sT+EqTpRSuUHOGxZjMDuCTRg1yxHz/U/4fcJetBNa7xEfxgrgef?=
 =?us-ascii?Q?9kZAfE27ChqGtLCUXuQNbt2kE8ZcTYA26bIwU1L7kurQq2uJyiQVRCo8tmGC?=
 =?us-ascii?Q?d4MZuG5HXWO1lV2kaOG+PmQmICYSLWSt5xK/uxOEc9R8PHeGDOYGspMBMlQw?=
 =?us-ascii?Q?naRxde9X/AWy/BZzJZTop/oHVAR7kn2g+196QwVuf4en0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLe2My2gMQYNyvgxZJ7yqBgtRR8tjmQIDFJ90CZKsgMYFZay3QD6Mf0pqR+X?=
 =?us-ascii?Q?wyob+mLkB0HhYk953eJhDrdxk8T2fOunhRZ3nPJyreh2F59QPuqzaByY28a8?=
 =?us-ascii?Q?uN+0Cn5GaFEApBXQPyv6ApgR3QazWGbU5PE9On7UKgQO7zhv/6ANgQK4aSFV?=
 =?us-ascii?Q?D8YueNQwEiy23I93uuBjfiH5qqFtfbRWARhcapF3DU6Jxlxw+KaMh9NH0vTI?=
 =?us-ascii?Q?z0drEPHaO/7v1N/qzu5+ogFPGQ+qrlR/cF7On4lpWR381NhKOHKl/PBPLcyo?=
 =?us-ascii?Q?dH8SKT3jc5CB9/cmCbB9CyuiSwoRKNXkfFCm3OQxNTi/vtfxVW6Qf71/2eXI?=
 =?us-ascii?Q?dOIYyKdDr3pdKwV83HRiCOBQ6TVktxtbUU5jsF8ybVPTnkRT/4rSmEKL88yb?=
 =?us-ascii?Q?NSagOCkz6G5D7MwUsdJLnUfRQeI2UtZcBeCJGCfLo4VsC34vj1/xjj8IeI6c?=
 =?us-ascii?Q?qt9jQctIhlq+fqQt9U/whTivFKDr507MuBkzPVvCMC4ZMjhw+3H9dc2EE5Nr?=
 =?us-ascii?Q?ueB3iY6tKjRwmyeVZ//sb8jJDO6V+5xuZB3dDnaC2tYhslxULooNxNw5lVk2?=
 =?us-ascii?Q?8C5pm8He+mINgb24TIEHRga42SinP3Lk5Zu4MpJrrHONZltseazT9Z3kpQ7x?=
 =?us-ascii?Q?NsA9lChQ4ph9M7cko8QGUYDF6ivMG6DNsTyjFDrNGjyrFVZVoTkyUpUhZvpS?=
 =?us-ascii?Q?jx5jccnCMGEFSbjXnh0HgkgbMQiInfn2y27wU688Vwu6pMoSxjyQaNvhbIxE?=
 =?us-ascii?Q?LVFUapd4kfa2VIB1ETEH2YnmCV3S59NmnMc/jaxH5WD9r9R5tg5QsJJk6I5h?=
 =?us-ascii?Q?cDt+46vh9240iPtRKmELRHysH5Y/vqsvgNS/CH5lzBpxD0er0UIRt3/hKf7e?=
 =?us-ascii?Q?lsxKg0D/J1s1xueba1MloTWbXwkVkC1maUU+gHpiAON9pbJwGojtUgDiPGOC?=
 =?us-ascii?Q?HjiYCvuF1ZbLhaQAFr+G06eBfn5hppKq1RNkyHpKjLey76qG/shi8UrrfMBm?=
 =?us-ascii?Q?P0RaDAEkfxM8IsnlNxB9TDmI/BXK9kHp+p9U99U93LRM1+UT+il6mOYzhMDo?=
 =?us-ascii?Q?LipAr702uH66Dh8O0WY19LS6wWhZyHvDj7yS0AEUVWcR0yypDTIsTOQdO37M?=
 =?us-ascii?Q?iNFm0qkGKSJ839I8hOFL9eO+77u3b7BP+Q6h2bolez4k8j8NaOzLBQG5gVxT?=
 =?us-ascii?Q?+T/kf68FhmNRLtxvgcrvC1v5XJ4K/tZT9nsUb5mtH4XD8oUbnG2smuy4Olz6?=
 =?us-ascii?Q?P4ZN7x8jKHc50tH9RXsbMCG/PqNp3vPdiv9L4ov41E9CAEBxfFsGpMK18C2l?=
 =?us-ascii?Q?ZYqwGqyrC0C6fRGmqMfnILmK2zl5IplHZYfnGArVv732ma0eUI53+D3GLR/s?=
 =?us-ascii?Q?OsBqYceihXJqABcvyqUBfAE7UVN3Te4UuNA16XLxL0+zW5yQ5KjHy2z0m6Rg?=
 =?us-ascii?Q?OPOj7FEdqI0fIFHZFYyULUMkOxAul/MTixn+hIT2W/h1Y39lNR5By2l4vVjv?=
 =?us-ascii?Q?igGbc7v7SjLC+acQTy4BCOT1Y/gChYh1SbDs8832jSHHmU59bBDT0DRrdKOM?=
 =?us-ascii?Q?T7l9f+f6kOEV5uNU9PU0qOleWDMlQ9S+FXC8uC5lN3iysEmWbQJ9gmtkwyY1?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b849029-adb8-4d3d-d98f-08dd199e8561
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 04:44:39.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBUwz/z7HHo7SOdAfB+vcIPqYnwU7n23cGzxb62uJTwUHUF5JBMMA4QXABpy7zkRbLz/kKYzcXZ61tWkwN89c7uO7bnNMqEN5yv4fQjdy3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com

Raghavendra K T wrote:
> 
> 
> On 12/6/2024 1:20 PM, Dan Williams wrote:
> > Raghavendra K T wrote:
> >>
> [...]
> >> B. /proc/iomem
> >>
> >> $ vimdiff success fail
> >>
> >>    4050000000-604fffffff : Soft Reserved
> >>     |  164 4050000000-604fffffff : Soft Reserved
> >>     165   4050000000-604fffffff : CXL Window 0
> >>          |  165   4050000000-604fffffff : CXL Window 0
> >>     166     4080000000-5fffffffff : dax1.0
> >>          |
> >> ------------------------------------------------------------------------
> >>     167       4080000000-5fffffffff : System RAM (kmem)
> >>          |
> >> --------------------------------------------------------------------
> > 
> > My eyes only know how to read unified diff (diff -u) format. Is this
> > saying that in the failure case the System RAM range for dax1.0 is
> > missing?
> 
> 
> Sorry for that formatting. I realized later.
> Yes. dax1.0 missing in the failure case.
> 
> Looks like problem is that,
> 
> 4050000000-604fffffff : Soft Reserved
>    4050000000-604fffffff : CXL Window 0
>       4080000000-5fffffffff : dax1.0
>          4080000000-5fffffffff : System RAM (kmem)
> 
> this use case where,
> 
> |A<------------->D|  CXL window
> |..|B<-->C|.......|    kmem
> 
> B->C range that falls within A->D as in above somehow
> not covered after the patch.

I was able to reproduce a similar set of conditions with the cxl_test
environment:

f010000000-f04fffffff : Soft Reserved
  f010000000-f04fffffff : CXL Window 0
    f020000000-f03fffffff : region3
      f020000000-f03fffffff : dax3.0
        f020000000-f03fffffff : System RAM (kmem)


...but that did not result in the bug. So there are some other details
missing. Can you proceed with providing the dmesg from the good and the
bad cases?

gist.github.com is useful for this.
