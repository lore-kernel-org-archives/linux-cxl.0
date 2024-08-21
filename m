Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790416EBF2
	for <linux-cxl@vger.kernel.org>; Wed, 21 Aug 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277015; cv=fail; b=K3nrOo5szjb7n5wXDe5bUAjT/yLljQzsNVlZ+Ye3cxtuJGqFx0AcQ+uZGFZFS7ZewUlJdY78lr28oE1OjD4VZHORfaDou3bEFg62tcaVY7to1g60pBTbFc4MjHGOSAYguZbzIGFGRKgiRegGwd5AS+z8Yty9rCpzO1J8Bgf6Zbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277015; c=relaxed/simple;
	bh=TY27r329jNkqMWaL/bJ0lUoqUcRVPMDHFlxPB5TVinU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKkHKnErgdIRTMJ075yIVLQl+O8xxDQlWrRlsq7Sg2+m7cQIOGeV9pWd54+wRvvmYYGw0JLNQ9dlgBBZ34FGQU1nGwzEb3/c9t7n5fA7f6OOHGugxpmUHjuhFAVeGhHpn4AsqJCX6uV0fo4Ya6UC9PR4ApSgh2vDtizpt7QvxYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxZDE4a9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxZDE4a9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724277014; x=1755813014;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TY27r329jNkqMWaL/bJ0lUoqUcRVPMDHFlxPB5TVinU=;
  b=jxZDE4a9O3jReOMvdKcggDbaumE1A8RDStjelfxrKhEZ0xrhVOUYTI3L
   LzZKWiIDG1YFZS3DAycORo17PdXf1vecWpeOQ4oCkzYlPTZE+BZPB3FrJ
   7jopxkDLZzaVPvSs8uXYsOldBSWHFJIcdG1A6qJbznJtvbeuSHUruF32B
   1J8uQ6TCO8Pem1lh9CxKM7cKeQuI2tfjfN5/ArXWzbWF3VdGfT7bo1Cbz
   nVU8CCtvpccljZR7oppjDQVC1UrTVgMFOETLtU6sy1NOnxpFGWffR18yY
   bXX+Ci/iAloB+UTf9BqveMeNkkk4P/kTt1Hd1ruZ6wwJZE+Lx0yMWpS0D
   Q==;
X-CSE-ConnectionGUID: JvBs2ue1RD+g44CB//FqQQ==
X-CSE-MsgGUID: hDcQ1ZgORy647XREqTSClg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22633745"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22633745"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:50:11 -0700
X-CSE-ConnectionGUID: Crn7JK2uS7aNYXGPDp0dTw==
X-CSE-MsgGUID: Aqx2jilNQ8SwHsfCFMNRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="98728761"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 14:50:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:50:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 14:50:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 14:50:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gE0KVZNw+BParo/C09dmoS+zItjmUcPhomkRLLgnUk5++2VbnArKeUQtKEIBshq4QjXg5dwPhKBS4tpbXMRmbLZ3EkuSN4AkEGV3rlpXOOOZr6QDL4PzUOEqc8FREN3KO6CZYMF0ZH5VxDviK/7evqBWyK2IsLafNBID1eYNvsBnrGvnWcgbPqjWJlKOGnSYyYvJCG1RILMSYEkovPZ4Okgb+9LvsEC/aspbk9IRl8aXGtQAaaNB0M8ewEuZEyy6PSsUdybf4k5ARXcbIn6TMBzhxAp0vqQBIRNvGiQRgLnkp60tHV+ijMOjKgJBZrM3zpX8sOADGQsW7KPEpV6QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+oI6Ew37nZ2kmnHT4rioprapHtAesdjjNSQb72tffQ=;
 b=t2+hXfWEioFpSsPSvKbgJ686Pf4XjJ7UdOsYot5IOfXRzhY3ozj8yW4unqh3QdGF8QRF2u4rgfoHlDM7NOnVVwFuQC9WbwaWv6bFvs27UTL4p1CqIQwhgN0cHvQZw4YnAuKwqnUXZUivEQKcnNcEGnMq4W8DhLHG0PL+PfKdLbScR+IjgSctzVmunrGsHFb8wLzZ2UH8aIT3peNIgfVUAJJH7LpGfPclT+VZY6d/JUhJsKSRZFe+vPY9UM5mRrAV41kCQb0xMiu29Mg9vSt8J7naa8sQVLOjKejMWjWUldYxVq/lnVOCwvUWxkQ1GsT2IsTZyHQgYVTocuJcdz+UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 21:50:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 21:50:01 +0000
Date: Wed, 21 Aug 2024 16:49:57 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming4.li@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH 2/3] cxl/port: Use scoped_guard() to drop
 device_lock()/unlock pair
Message-ID: <66c66105891fe_1719d2946b@iweiny-mobl.notmuch>
References: <20240813070552.3353530-1-ming4.li@intel.com>
 <20240813070552.3353530-2-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813070552.3353530-2-ming4.li@intel.com>
X-ClientProxiedBy: MW4PR04CA0338.namprd04.prod.outlook.com
 (2603:10b6:303:8a::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea60040-6ace-403a-5335-08dcc22b3538
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KD+KMd/p8k3GmmYvB0PS74vp+YixrZj2xmqDzDf4GZubPrOCB+yOMD+p4zjy?=
 =?us-ascii?Q?cVOtnoDTP/H6u44oHwG8vrzWwjEdjx1G0eHwjCi9OTVOkqIEceT130vn3+jc?=
 =?us-ascii?Q?Zx6h044zhu44fBX9eP6pJdH9BTlv+Gi8OlfXbSj3GpbQ3leczMkI1iTIZK4s?=
 =?us-ascii?Q?RjaV3Drrt16mL333fL+KkU6jelTW9SEXs19sDt6SNKkBSsysLwdhwrY1v4fs?=
 =?us-ascii?Q?ZPDtaX8oa6xeRwyJcKfRoljgDZ82/BzvnxovrgYj+oz2fplkFT3wjZHkdO1D?=
 =?us-ascii?Q?GZGuBIlN7bPgva8Gxo0SMDOESKW1VOKpPZvEearIhatKbCX37cGQXiq3XjJk?=
 =?us-ascii?Q?SXactOJXRgrNI8F1/fB/3PM0rr4Urol+ml3jNyH7nsMV9XYjPdD3tXoouFRD?=
 =?us-ascii?Q?lYsvSu69qc7K0FZjwiEssekyzFbrI9zFR96Sc9CDqG7wVan+m2HhCydlxTpm?=
 =?us-ascii?Q?reaCOps2mjrvpn2nEmNcLDitiPLyDxD63mUm9PWXUE6mGt0itKo+0hQnuKCb?=
 =?us-ascii?Q?tuhybAlDp16NOvQMN6Zvz6svgxdp+C7+g5QVCWLEdCAZzNRbMnPI/QdFwWop?=
 =?us-ascii?Q?WMkZXejuT/uv3Gm5wmiIhEsckyRHbg9gv7XuVg1Pg8amDfpb5NxeumW+8MRL?=
 =?us-ascii?Q?WcNzSLPc69LYCoOVfFyVdBRKAuB3w0CrgmX45vIkJtJwZp1pRcnWhxbYn5SU?=
 =?us-ascii?Q?NS5e3Fm69khRmUgY5II5m/YoD8imKibmwQxvsYh59AHV0/SDI3J/2bld61IH?=
 =?us-ascii?Q?gl1TSnNIoUjhB0oZxkskM9YoGd+MZ3KhHeWx19rFOhcvXL3uzxOP7i03IRz1?=
 =?us-ascii?Q?ZXmDi8MjID2rIASggTnOTO/PxhARxbyBkZLfGKJ4GoqAsSvFNyqAKP+KOkCR?=
 =?us-ascii?Q?iZLzCoY07pSqi77hkw3M/fyweoHfarEsUNQHuYjzO1xk1PPwYQwKM8YzBtcQ?=
 =?us-ascii?Q?p+NKg7ZIo+dj1wvaP14YHDvz6F8ectl12mhq34ZSA+nmI40t6vgg0x0/YoU9?=
 =?us-ascii?Q?oZi34lO4lTMQ5//aH+J3nm70h39T2Uj1vmix1Xl4O2SX9bL95DFr0k0tQZni?=
 =?us-ascii?Q?NVvq8/w4Hp3Os8sHK8s/KiWQ+Q2OEjgHzoT/l33zAopx8mk7V7Tl4eKhmIjJ?=
 =?us-ascii?Q?HrFa5f5kewWQNiEXtQtX0/XmUswpQK5lnE+BWyQSN+MK/f3dFNeGu4khnJcH?=
 =?us-ascii?Q?8hOpFQE18r6Wyb+lYNimevzvpKKsMEjLMcORQm957fY760+jI5KzSo/dAaPb?=
 =?us-ascii?Q?AYqFfA2lXMvDdIVA0N+ZtSy5+ohw0r7PY+x2c/QjuVAjHvRHJiL1ay7y1ek5?=
 =?us-ascii?Q?5X2IOFSyIvxJlLr6UCfJRUo3CxB86Yt5sztpmSfzlTV/hA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oj18ry8mBP7BTMGgCTBTJI0GQpCo+26miBAcmizoW0kjI54BhE4AXNWjPRzi?=
 =?us-ascii?Q?nhYjjHw/aEjZRh+t49bALzYpvkMTNisI4hK54iJdKUIW0XU/LNs8cz04YTpR?=
 =?us-ascii?Q?KS+NfRxAqyQeynm5q97zO+sxd0/MH6MM2VZ+3HRaHLyUKRxZtwf/wpcuMNW1?=
 =?us-ascii?Q?mCBWcpkcSPMNJSLpAjfBh/kAWJoxDkik8BSnhX6Viv6xcmYk4bH1LfeQI94w?=
 =?us-ascii?Q?hfcsLZ2SXYMYDRKsrZFCqk+WtQjxLEEHrBsPFHLqM66a5I22jfyzfTseL9ij?=
 =?us-ascii?Q?asJNddCWMfrgaFN343E7U/pW/2HYFkem6n4DaeEHnYUOokdHBKqcoYylvErd?=
 =?us-ascii?Q?rKqp5EYPT0+v3FIgHNji5ZfU+br+hOliNjdHFpKXoPqDDgcvpmURJYDk+fLP?=
 =?us-ascii?Q?dYEfbZT4vo/r6zXRfQ27L9/rhZxF77G9DOByB/hh7EmHImhm8QljuuD0mbv9?=
 =?us-ascii?Q?Pgplt2RUcC7jyhm9w4bGfldCnT/rB/AAPkCvyELMvS37S73vrJaO3DcWZQnT?=
 =?us-ascii?Q?7xx86BCcYDl5lXiFc15CGP/3If6SDAao3D5Yx+HuMQ07ovF9djlsPTJCcOBR?=
 =?us-ascii?Q?UXkGl70Kytti0JER9JuhNDIE6EADrvtZZPWaG0hACI/rYVD9QjltKIqwWNxL?=
 =?us-ascii?Q?AsSGH5u87bAyqXPdcTpzhuxYKP57MHIkcN9Vq2ZLaIkCHyhGzWWM4t8Jkxyp?=
 =?us-ascii?Q?yaZTmZQVYlYFDP6sc+F1oRG0f+N+VR+JvR+JEweY+NEwY/D0/0Bg7LTL9vFN?=
 =?us-ascii?Q?Vq8XwGuubpCoMfg7rut746Mvmn91KjN/tfl3sG4D86Pey4TmJRFIMQD2q8f5?=
 =?us-ascii?Q?GEVnEoE210HBudSeODo56m3eSY+oYVXZIWIgllxgFCaMYVVj+eG53iBDcbzu?=
 =?us-ascii?Q?B/3Soo+4JccvgdaXRJLDwxd7rPGZ2dxO8BwpZNDIsn1qFQ+52s1nDerMRi+5?=
 =?us-ascii?Q?azXg8z+5lbzti8n9m+90TYQUihtPCez2i8A4LF5Cme3BE5jrt2vGpBuYhldo?=
 =?us-ascii?Q?J+5RC8dcOCPwEEfUUzmcGARunlgk/NgUB3LI5Eb+sQ/WFnm6MhBIDfrOypVc?=
 =?us-ascii?Q?nZyexVXU8qx01d7bUzeNwenunk+ovcbnq23nZ0NK+RO4JPA3j+cOu8b01tlw?=
 =?us-ascii?Q?4Z5HnBqOvK7G7ttZzNk9q+qaj4ij8l5CWOWg/ZAVU+YoLJmlIhGMZzSsrRmj?=
 =?us-ascii?Q?iZ6VBgTaklXSn7FLKs2qnrMGQnuIJ+UqqO7Z4uC2BNdgtQLNjxVWAjlbJ59A?=
 =?us-ascii?Q?oG1js8ISTuuvYXaLbf/tt1NlJ5+vzrdS2KQXmt4kRBJlPMi4ohheEcm8U7gP?=
 =?us-ascii?Q?TTK7+owT+sDMPGrwGGJxtXeTfZwelSrnHj8MpzM1Kp6kepVV+6zx72SAqar9?=
 =?us-ascii?Q?MsGngkoeJ+7q9bQcW/BlofXhJgKHeXLpXRKYXOY+JGIkMJDXq4ANwj3O0w3w?=
 =?us-ascii?Q?NqNbda0PAFWXnyaNSIEI0G6jQxGF5KpyDFb6K0fsbJRd+r0Z2FJcXnYWQTd1?=
 =?us-ascii?Q?7sjwfRUNqnFEBPp4xOAMQLXL7r6EKZ0PGoxaeMpyrwaUrzuZ6rnLZwzkxnUR?=
 =?us-ascii?Q?ti0wQ4OWsW/Vh3h6Nw4XtXjyQVdMaYJVGjFwT4xD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea60040-6ace-403a-5335-08dcc22b3538
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:50:01.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGvddclbwwRewxgnUwm9k8OqAu+uH5DMutLgUlbvZVxktl1dU8hdRfz/fXAhsc0SvKtJVQ08pAKS/wxgAY4VNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com

Li Ming wrote:
> A device_lock() and device_unlock() pair can be replaced by a
> scope-based resource management function scoped_guard() which can make
> the code more readable and safer. Some device_lock() and device_unlock()
> pairs in CXL subsystem can be simply replaced by a scoped_guard().
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/mbox.c   | 26 ++++++------
>  drivers/cxl/core/port.c   | 87 ++++++++++++++++++---------------------
>  drivers/cxl/core/region.c | 25 ++++++-----
>  drivers/cxl/mem.c         | 22 +++++-----
>  drivers/cxl/pmem.c        | 16 ++++---
>  5 files changed, 82 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e5cdeafdf76e..a8ab5f2697be 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1214,19 +1214,19 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	int rc;
>  
>  	/* synchronize with cxl_mem_probe() and decoder write operations */
> -	device_lock(&cxlmd->dev);
> -	endpoint = cxlmd->endpoint;
> -	down_read(&cxl_region_rwsem);
> -	/*
> -	 * Require an endpoint to be safe otherwise the driver can not
> -	 * be sure that the device is unmapped.
> -	 */
> -	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
> -		rc = __cxl_mem_sanitize(mds, cmd);
> -	else
> -		rc = -EBUSY;
> -	up_read(&cxl_region_rwsem);
> -	device_unlock(&cxlmd->dev);
> +	scoped_guard(device, &cxlmd->dev) {
> +		endpoint = cxlmd->endpoint;
> +		down_read(&cxl_region_rwsem);
> +		/*
> +		 * Require an endpoint to be safe otherwise the driver can not
> +		 * be sure that the device is unmapped.
> +		 */
> +		if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
> +			rc = __cxl_mem_sanitize(mds, cmd);
> +		else
> +			rc = -EBUSY;
> +		up_read(&cxl_region_rwsem);
> +	}
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6119cb3ad25c..53e2593daa95 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1260,14 +1260,12 @@ static int add_ep(struct cxl_ep *new)
>  	struct cxl_port *port = new->dport->port;
>  	int rc;
>  
> -	device_lock(&port->dev);
> -	if (port->dead) {
> -		device_unlock(&port->dev);
> -		return -ENXIO;
> +	scoped_guard(device, &port->dev) {
> +		if (port->dead)
> +			return -ENXIO;
> +		rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
> +			       GFP_KERNEL);
>  	}
> -	rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
> -		       GFP_KERNEL);
> -	device_unlock(&port->dev);
>  
>  	return rc;
>  }
> @@ -1393,14 +1391,14 @@ static void delete_endpoint(void *data)
>  	struct cxl_port *endpoint = cxlmd->endpoint;
>  	struct device *host = endpoint_host(endpoint);
>  
> -	device_lock(host);
> -	if (host->driver && !endpoint->dead) {
> -		devm_release_action(host, cxl_unlink_parent_dport, endpoint);
> -		devm_release_action(host, cxl_unlink_uport, endpoint);
> -		devm_release_action(host, unregister_port, endpoint);
> +	scoped_guard(device, host) {
> +		if (host->driver && !endpoint->dead) {
> +			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
> +			devm_release_action(host, cxl_unlink_uport, endpoint);
> +			devm_release_action(host, unregister_port, endpoint);
> +		}
> +		cxlmd->endpoint = NULL;
>  	}
> -	cxlmd->endpoint = NULL;
> -	device_unlock(host);
>  	put_device(&endpoint->dev);
>  	put_device(host);
>  }
> @@ -1562,40 +1560,36 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -EAGAIN;
>  	}
>  
> -	device_lock(&parent_port->dev);
> -	if (!parent_port->dev.driver) {
> -		dev_warn(&cxlmd->dev,
> -			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> -			 dev_name(&parent_port->dev), dev_name(uport_dev));
> -		port = ERR_PTR(-ENXIO);
> -		goto out;
> -	}
> +	scoped_guard(device, &parent_port->dev) {
> +		if (!parent_port->dev.driver) {
> +			dev_warn(&cxlmd->dev,
> +				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> +				 dev_name(&parent_port->dev), dev_name(uport_dev));
> +			return -ENXIO;
> +		}
>  
> -	port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -	if (!port) {
> -		component_reg_phys = find_component_registers(uport_dev);
> -		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> -					 component_reg_phys, parent_dport);
> -		/* retry find to pick up the new dport information */
> -		if (!IS_ERR(port))
> +		port = find_cxl_port_at(parent_port, dport_dev, &dport);
> +		if (!port) {
> +			component_reg_phys = find_component_registers(uport_dev);
> +			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> +						 component_reg_phys, parent_dport);
> +			if (IS_ERR(port))
> +				return PTR_ERR(port);
> +
> +			/* retry find to pick up the new dport information */
>  			port = find_cxl_port_at(parent_port, dport_dev, &dport);

Can this call to find_cxl_port_at() fail?

> +		}
>  	}
> -out:
> -	device_unlock(&parent_port->dev);
>  
> -	if (IS_ERR(port))
            ^^^^^^^^^^^^
Does this need to be checked above?

It seems like the logic is changing for the call to cxl_add_ep() but it
might be ok?

Ira

> -		rc = PTR_ERR(port);
> -	else {
> -		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> -			dev_name(&port->dev), dev_name(port->uport_dev));
> -		rc = cxl_add_ep(dport, &cxlmd->dev);
> -		if (rc == -EBUSY) {
> -			/*
> -			 * "can't" happen, but this error code means
> -			 * something to the caller, so translate it.
> -			 */
> -			rc = -ENXIO;
> -		}
> +	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> +		dev_name(&port->dev), dev_name(port->uport_dev));
> +	rc = cxl_add_ep(dport, &cxlmd->dev);
> +	if (rc == -EBUSY) {
> +		/*
> +		 * "can't" happen, but this error code means
> +		 * something to the caller, so translate it.
> +		 */
> +		rc = -ENXIO;
>  	}
>  
>  	return rc;
> @@ -1986,9 +1980,8 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  
>  	port = to_cxl_port(cxld->dev.parent);
>  
> -	device_lock(&port->dev);
> -	rc = cxl_decoder_add_locked(cxld, target_map);
> -	device_unlock(&port->dev);
> +	scoped_guard(device, &port->dev)
> +		rc = cxl_decoder_add_locked(cxld, target_map);
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..a3ce7cbe5c6c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3094,11 +3094,11 @@ static void cxlr_release_nvdimm(void *_cxlr)
>  	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
>  
> -	device_lock(&cxl_nvb->dev);
> -	if (cxlr->cxlr_pmem)
> -		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> -				    cxlr->cxlr_pmem);
> -	device_unlock(&cxl_nvb->dev);
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxlr->cxlr_pmem)
> +			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +					    cxlr->cxlr_pmem);
> +	}
>  	cxlr->cxl_nvb = NULL;
>  	put_device(&cxl_nvb->dev);
>  }
> @@ -3134,14 +3134,13 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> -	device_lock(&cxl_nvb->dev);
> -	if (cxl_nvb->dev.driver)
> -		rc = devm_add_action_or_reset(&cxl_nvb->dev,
> -					      cxlr_pmem_unregister, cxlr_pmem);
> -	else
> -		rc = -ENXIO;
> -	device_unlock(&cxl_nvb->dev);
> -
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxl_nvb->dev.driver)
> +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +						      cxlr_pmem_unregister, cxlr_pmem);
> +		else
> +			rc = -ENXIO;
> +	}
>  	if (rc)
>  		goto err_bridge;
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ab9b8ab8df44..ae94018a01bd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -168,19 +168,17 @@ static int cxl_mem_probe(struct device *dev)
>  
>  	cxl_setup_parent_dport(dev, dport);
>  
> -	device_lock(endpoint_parent);
> -	if (!endpoint_parent->driver) {
> -		dev_err(dev, "CXL port topology %s not enabled\n",
> -			dev_name(endpoint_parent));
> -		rc = -ENXIO;
> -		goto unlock;
> -	}
> +	scoped_guard(device, endpoint_parent) {
> +		if (!endpoint_parent->driver) {
> +			dev_err(dev, "CXL port topology %s not enabled\n",
> +				dev_name(endpoint_parent));
> +			return -ENXIO;
> +		}
>  
> -	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> -unlock:
> -	device_unlock(endpoint_parent);
> -	if (rc)
> -		return rc;
> +		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 4ef93da22335..647c7e25ef3a 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -233,15 +233,13 @@ static int detach_nvdimm(struct device *dev, void *data)
>  	if (!is_cxl_nvdimm(dev))
>  		return 0;
>  
> -	device_lock(dev);
> -	if (!dev->driver)
> -		goto out;
> -
> -	cxl_nvd = to_cxl_nvdimm(dev);
> -	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
> -		release = true;
> -out:
> -	device_unlock(dev);
> +	scoped_guard(device, dev) {
> +		if (dev->driver) {
> +			cxl_nvd = to_cxl_nvdimm(dev);
> +			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
> +				release = true;
> +		}
> +	}
>  	if (release)
>  		device_release_driver(dev);
>  	return 0;
> -- 
> 2.40.1
> 


