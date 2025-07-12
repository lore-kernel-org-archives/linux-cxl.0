Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7D2C9D
	for <linux-cxl@vger.kernel.org>; Sat, 12 Jul 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752293865; cv=fail; b=BpwOfN7aJzG3fVAvH4G8pBTAamQ2Mkpn7hdmb1GwDdWYGSbq1Ui2pRgtOF2yA79ODxDzekhBQhS5UdluArXvMOMnoPPGYq2vdiLuCEE/KEazzZPxbZfYqEOkD/IFafTsle9awY62JYiLcpQWyPqMNBw4FbfpP1x6R/I5KE9V1gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752293865; c=relaxed/simple;
	bh=chr8ag2dx4Oiq8s34H/WYGrWBiITUCEP+teE8mBHLzU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0ULXgn+KOOpVgpuNuvan4WFYoTvDMdkoO1uTeTxrPaVLYFfQee64emWIPKRZjmVBNeGPhbsHAe8TKMTZcGLldQRYgig7MPDZv5aoVhAMoLWEMS+BJvkvYYBNC+MFSwBhA80iWJg0dZL9pwumtuEkPsVskK7sYB0DaWYU6WkDY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVJLh1fU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVJLh1fU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752293864; x=1783829864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=chr8ag2dx4Oiq8s34H/WYGrWBiITUCEP+teE8mBHLzU=;
  b=WVJLh1fUym5Gu0kugZlR87bLry4a2pebm7jUB3lD0BwLm/g0mFwIlQTt
   YCLCBGXs6I68jhMuUG1RtrsXITXgFqUO9JSdmgorBuMTW1I8vJCZRZ9Xy
   CaoVDIsm0us3OUjU42d34k96UDXfyVUtsYzcY1m5eu6um14gjS5I+v69g
   TKyN3dWIhJ42Kxi/wtZozjymMCAzd2e+ijKPZSGWwmTEY6geXuSxTgUG/
   xwsrReC23zWt7rd4LLlmUIvoKCvM195R7M5NWdCr7iNkM5Ia8+L3b3ABs
   XLcTchWpzFoU3BiCVAJdR3MwoedjllpH8Co16xzTpdsnDhnhiNfzhSYZe
   g==;
X-CSE-ConnectionGUID: UAo1j4+PTbG4qDgOvkDGDQ==
X-CSE-MsgGUID: 1HUKosLYRxaTfcJtH44wXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54741980"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54741980"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:17:42 -0700
X-CSE-ConnectionGUID: TM8o2HGjTB+Jcq2xCbTVtA==
X-CSE-MsgGUID: Nm278aDfR4Sn+2E88AUf6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="156131372"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:17:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 21:17:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 21:17:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 21:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhxBK22ZuWMQsV/f5UHSk7IQBg+aOk0y2/UMcO2ROPucxKUEY6ymCe0wJtG+eL6c3l6rcTeYMr00fdnlzIQ1ugst3bOzxLrWIfqO1l0mSHqA1JfUVKIHvDO+X7Zr1o/bV1T1XnEriL0zcyEHCvEDQiYzf1B4wwgQaTD2p4D/l2EBZsuO61FjszDgtOFkErgmvZHFr1ao+rPFnOCcrmm7XbyXp09twibAKgITvqDjKlRgFO+GgSYi3vN+Jfaq+A4qk6iWeyHpFO/pYgoSYebCm2oa33a3krQq61jr/kLxq5gH1IzGOXnnA8Kx/1cJqWuN6wRIZP4EWolxekBxg+Wj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlWGTrw5HoDzC/Qx8zTOPGFYq3Ob93qveBmGRr2QidA=;
 b=rtF1nubmWm/8/vNuEkstRg6KnpFmT1c6UzFYwvIL1j2gc9Zb4tkeCR1dje8ySKA3Zx7zSyH0cFUXXq9Byhat7c6GIYi9wmPp3OqTHk3XjrblZnwgN0nzbpAb/pr6aA7AlqkeN1TjDghJLwjf++Y/bauyIlQlEKMsuhKvyvUnTLh3dInzf5Hbzrszcv/Tgtywsrsxr9/p7L++qtlL5q0A3cugNxmsa4nxjJ5PkpjuwGgzcOh97OLs0Mv+3EAwK0zpnkDJlavaVlf0RzbjZG0cBC8wauuyo5R7iS8Wep61/Dz8QHCzg477tqseG5DIMq+U0e89b15oOupNsj3HdUKgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB5913.namprd11.prod.outlook.com (2603:10b6:510:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sat, 12 Jul
 2025 04:17:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Sat, 12 Jul 2025
 04:17:11 +0000
Date: Fri, 11 Jul 2025 21:17:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <aHHhvz94QWtAkGUc@aschofie-mobl2.lan>
References: <cover.1751513505.git.alison.schofield@intel.com>
 <b3216602850003d06016f4735246b5d4f9fdd643.1751513505.git.alison.schofield@intel.com>
 <20250703152323.000069f6@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703152323.000069f6@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: eb192887-888b-4516-3b83-08ddc0faf8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?50ZOjOhq+Gel2sYjOmymRvqyd4mRsMN8hFajm3ZaisthES8Mw6DBM5prF9MB?=
 =?us-ascii?Q?MEj9n6bpyVAKOeTu8iHE/R9a6iNs5kwuZbyh41QP2KVXUdZWgvkKObnEnFUa?=
 =?us-ascii?Q?en9TES2TAW2t97W7AJqvMYtWJdt41CWDG658w9wZ3tbmdzb0BfWLPmbUtqcI?=
 =?us-ascii?Q?NWMa4EqYlbh4ztdNR4TibdOXYAfutJh5At2tLOA1fPujWxdYIgbma21gcaqR?=
 =?us-ascii?Q?I13cn+/zRrN0XlziwNdqRf7x0qEnJqGyw1D5Cpd1mCww1lytaexFIzlpWQJ5?=
 =?us-ascii?Q?AtLHoMScOnLbMIU8dYczXAhvSKsb+0AEWXKqaf9ET5mQH4pmKfvG8pJpmD6m?=
 =?us-ascii?Q?2warSrEPb+dkRcBJAG+WUcQvnaLZhkeTrVh9QWc2YSYeRsHFZjdjt+ZPhtap?=
 =?us-ascii?Q?urNzgrdQUdKdyB7uyGWNKdkIbrshF3MjuOaxpeEcx9GeRpMlIXlsEU/UkdlR?=
 =?us-ascii?Q?fnEJGrs8abQR87xR7eR2Xj/Uo4yvAb1zbbWSlCUG7AZolkgHBQO63sxKdNAL?=
 =?us-ascii?Q?DiuAKflOY2XAjs20ZP4WiWVXWZahNjoEG/Tltvx5Wpa2vEO5jYE9O1WnAkEE?=
 =?us-ascii?Q?cQJZ/I1/eJMo36ymf4XfeZ+xqR/ScWBcRMzrShizFaNEE9A95KPZ+DCm9inM?=
 =?us-ascii?Q?S7b7CaShssj5KWe29M8kFzgHx1A2ZrWKh1uaIfFv5cdqtW0atXCAN4taWS0R?=
 =?us-ascii?Q?RILlVm9tOEwx/JVZNnF2D56qXKVaD2WQ8NHWZaXm4fERi6aJp6CQSo0vouiP?=
 =?us-ascii?Q?HXrQgz+FaUPMzbBg7oWK18m/ucxwXhqynYflXZnT+fV8DExp9/DxD3nxRd9e?=
 =?us-ascii?Q?gBwDfKc3ydeM8mPwFGpF19JKYQ73NtnZMv0ZvEbAY7GK4Su+uNXzLLxR4CtD?=
 =?us-ascii?Q?DNvJ5N2zI2sbMgBgtl/Sd9BL45ro6v4fGC07koOXuCJS8qF8DWCWA2zbMWZL?=
 =?us-ascii?Q?T9+DZn4vTIs2ejz06JhuoVyNglXO7I3+ow2WdQwpf8j6Jk38iIq7xSpiGm/a?=
 =?us-ascii?Q?afCTSgzfvQmdaoYRMpb5Nh5aQ87sDj1e/nXtvZd5h7eIywP04JPay2nH6Udf?=
 =?us-ascii?Q?fRidG019X1uiudt73mTb6jTMj/4knGacwPG3Di4s3dQvkhhuEQytpvfr+XAF?=
 =?us-ascii?Q?hwR3C27vDbjHj1YL4lBFBa6li+0H/A7l++A0ZStsLDwrzLOhw46ztlEnh2X3?=
 =?us-ascii?Q?n8CWt893V+KCVSLVft1klmfdLTXPExeE9m4kwuE2BI/UrnuNPPlBq25WnGUV?=
 =?us-ascii?Q?mG+qKilGwAxB9SM9pjRjfwrlFDc2clqscbSysQx/Zz41mb3N5vEHq/JUJues?=
 =?us-ascii?Q?68zjAKP9FPrHugcXyZFPG7KQ9qjmOxr3jMbShamYvxwXBhWmuClDG5WeWF3S?=
 =?us-ascii?Q?NVu2DoC71+1sbaUbJF894ThAborveOA5oKj7dDyVkFF0e598KZVhZCfW+JaK?=
 =?us-ascii?Q?4W9YcSayH0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?80X1a0wk0I9eQqJvyee1lcBcBcdpGN59BQyosNbaqJrvFM+sM50wnOUXGSE2?=
 =?us-ascii?Q?Fhw06/LMsK0FVZnvzOi4qTF7n5MQG9JF20GgYD5fDMCLWCbL+svwo56uq3qO?=
 =?us-ascii?Q?oa7Qs7o+rbmSH42HL8/6S56ltwSjV38DsPGYe7w3lzuG5hi/JvdKBIIxby6a?=
 =?us-ascii?Q?iP6UULgFkhx+oTaiSM3K9RRKK96gezs9Wgawk9e2V/Zi2AaAuv2/eSmLN4p7?=
 =?us-ascii?Q?T5QAFqe1Tyh6WTUABRsdR8Xhgmd+actKgNjj4qTf1q21f9cqUEmk8ZMZ8icS?=
 =?us-ascii?Q?1toAT3pzeoZYbDuHCWe/btIQ9nRgtzQ8OtKImXD2j6O+TbpjrCJyqeEtkZmX?=
 =?us-ascii?Q?pBMdikRQQQ0kqhLP8MvkwkmzzWEKTE22jn8Qo9Blw2QvSIRLJxHUv/eoE734?=
 =?us-ascii?Q?71aToitCSaFsvYQGGgnrlLqnuSfZKIrVzqdr0K6f5KaRBHZSE95JaKYHIXmT?=
 =?us-ascii?Q?hMHFpgz07yvLx0sgWKTO0Efzqgtz7A3LEX+czh4cZNrbybk7l1mu0jbz4oao?=
 =?us-ascii?Q?hnnm2tXPFHl8FOVtBTc6wk+JQcCW+n63CbQv58YBElyZty/UCOn6PMeTB/xS?=
 =?us-ascii?Q?1AFfF/gdMcWywZMXnuLwKJ5hBK2yw/WyO96HdabVQjjkP0QLjwB+TJUza6L0?=
 =?us-ascii?Q?Kdk8rQzbDY7HAk/nlU/Jq2lutOQERAuQaTL3B9SZZFPl3nXmqPxF/l+erjEx?=
 =?us-ascii?Q?f5Z+mgj3ILny+WY5CHfdOatE/JXY94DU88nZDwHODUXoyfakLyspz6k2Akjl?=
 =?us-ascii?Q?3behPrQBtopc8R+SuLAnfXVilAnqztk3CxxoZ5VLK6119EFZQZ+X9jah9LtP?=
 =?us-ascii?Q?XEtfvtwIrQl8Ys/XWkNQOfKYxii6D+NOhHzYZ8g++Z7sdlz2CQoO7Chbt41C?=
 =?us-ascii?Q?iF3cU0ss6L97FN2roK1/816x1MpuA7w5WylRue631W/zGXWgwoOO9JjrWyR5?=
 =?us-ascii?Q?zFcbrMDFhT1e46nEemLiB+9/RySgWqPszx1fP86Vs42gcn8dNZQkHah+Kvj7?=
 =?us-ascii?Q?Pdja6Jj41PVbjCsDwtCoNeG2BMcnx1VaFbpfkgPeV5NFWTa39b8GChxL8dpK?=
 =?us-ascii?Q?v1GcyMRgBQYR1hhM4ClvtjMO+ZIbOaI9AiwIm5VDTQ2Z5fJ43+CmwKvTfrKz?=
 =?us-ascii?Q?99GJcix0WRvZIm6EW+AXQn6qKqSKHer280kAr1ma5ETR645h0+0Kyb1oUa19?=
 =?us-ascii?Q?LGUFk7qLm6MOKAyLUKdhrWe+6DcrLxDy2XwMwJUEZeI7ac8hweL0yoEGo9AQ?=
 =?us-ascii?Q?NbjG6y6yjS72C7aKUElXD9AqPdYsYcdcwmZltdfBhUKbJRGqueoHoD95CqQq?=
 =?us-ascii?Q?dIqrqUe5irOKlbtdOSYXaZUCxYA+oBlXTFdw1N4FsK98yGqnIM7VGeBQlyzr?=
 =?us-ascii?Q?zER/h6aSfcy17DiL1KBHG9zp7+P83WdZHcy36Q3P7rHQgiAZfiQJKqCJsXMT?=
 =?us-ascii?Q?NtaTjo3mGi+35hBxt3nh5Ijnt4/lNsKl2hwU/oQR9s3qWQQ9YxV7/1zdXZaP?=
 =?us-ascii?Q?da+MSYvC+jaRGQhmo+PSG8VtKVtdSNsrof+sBsot8PS7JlSuFaBPWVejnl/i?=
 =?us-ascii?Q?gXn3W+Gz4UJwBllQvBmn5FZXL9uLsJWde7+TvkybwAeQoSXKTFuF1s7aqwSq?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb192887-888b-4516-3b83-08ddc0faf8ee
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 04:17:10.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hfE8L1hr9sryjDcdoKhsDoiBEphZTfSlOPsA5WC2/wF/7AbGqODsRbRcMVBgU+TeMN30s/5/3sVQHWGmx6bcbz581EcLI8U9nQdzKWd5cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5913
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 03:23:23PM +0100, Jonathan Cameron wrote:
> On Wed,  2 Jul 2025 21:03:21 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add infrastructure to translate System Physical Addresses (HPA) to
> > Device Physical Addresses (DPA) within CXL regions. This capability
> > will be used by follow-on patches that add poison inject and clear
> > operations at the region level.
> > 
> > The SPA-to-DPA translation process follows these steps:
> > 1. Apply root decoder transformations (SPA to HPA) if configured.
> > 2. Extract the position in region interleave from the HPA offset.
> > 3. Extract the DPA offset from the HPA offset.
> > 4. Use position to find endpoint decoder.
> > 5. Use endpoint decoder to find memdev and calculate DPA from offset.
> > 6. Return the result - a memdev and a DPA.
> > 
> > It is Step 1 above that makes this a driver level operation and not
> > work we can push to user space. Rather than exporting the XOR maps for
> > root decoders configured with XOR interleave, the driver performs this
> > complex calculation for the user.
> > 
> > Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
> > Implementation Note: Device Decode Logic.
> > 
> > These calculations mirror much of the logic introduced earlier in DPA
> > to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
> > reverse the spec defined steps. This case is not the reversal, it
> > follows the device decode logic per the spec.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes in v2:
> > Shift by (eig + eiw) not (eig + 8) in MOD 3 interleaves (Jonathan)
> > Simplify bottom bit handling by saving and restoring (Jonathan)
> > Calculate the pos and dpa_offset inline, not in a helper
> > Use the new root decoder callback for spa_to_hpa()
> > Use div64_u64 instead of / to fix 32-bit ARM (lkp)
> > Use div64_u64_rem instead of % for arch safety
> > Pass pointer to results structures (DaveJ)
> > Add spec references and comments (DaveJ)
> > Add validate_region_offset() helper
> > 
> > 
> >  drivers/cxl/core/region.c | 100 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index a2ba19151d4f..d965f07ba8a8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2956,6 +2956,106 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  	return hpa;
> >  }
> >  
> > +struct dpa_result {
> > +	struct cxl_memdev *cxlmd;
> > +	u64 dpa;
> > +};
> > +
> > +static int __maybe_unused region_offset_to_dpa_result(struct cxl_region *cxlr,
> > +						      u64 offset,
> > +						      struct dpa_result *result)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	struct cxl_endpoint_decoder *cxled;
> > +	u64 hpa, hpa_offset, dpa_offset;
> > +	u64 bits_upper, bits_lower;
> > +	u64 shifted, rem;
> > +	u16 eig = 0;
> > +	u8 eiw = 0;
> > +	int pos;
> > +
> > +	lockdep_assert_held(&cxl_rwsem.region);
> > +	lockdep_assert_held(&cxl_rwsem.dpa);
> > +
> > +	ways_to_eiw(p->interleave_ways, &eiw);
> 
> Maybe exercise paranoia and check return values from this
> 
> > +	granularity_to_eig(p->interleave_granularity, &eig);
> 
> and this.  That would mostly be to avoid reviewers having to
> consider if errors are possible rather than because we think
> we can get any.

Done

> 
> > +
> > +	/*
> > +	 * If the root decoder has SPA to CXL HPA callback,
> > +	 * use it. Otherwise CXL HPA is assumed to equal SPA.
> 
> Short wrap.  Go nearer 80 chars.

Done


> 
> > +	 */
> > +	if (cxlrd->spa_to_hpa) {
> > +		hpa = cxlrd->spa_to_hpa(cxlrd, p->res->start + offset);
> > +		hpa_offset = hpa - p->res->start;
> > +	} else {
> > +		hpa_offset = offset;
> > +	}
> > +	/*
> > +	 * Extracting the interleave position and the DPA offset
> > +	 * is based on the steps defined in CXL Spec 3.2 Section
> > +	 * 8.2.4.20.13 Implementation Note: Device Decode Logic
> 
> Also rather short wrap.
> 	 * Extracting the interleave position and the DPA offset is based on
>          * the steps defined in CXL Spec 3.2 Section 8.2.4.20.13 
> 	 * Implementation Note: Device Decode Logic
> 
> probably better.
> 
> > +	 */
> 
> Comment next to comment is a bit ugly.  Maybe combine them or stick a blank
> line in between.
Sort of done. Got rid of the above general comment and put the spec
reference in each comment section below.


> 
> > +	/*
> > +	 * Interleave position:
> > +	 * eiw < 8
> > +	 *	Position is in the IW bits at HPA_OFFSET[IG+8+eiw-1:IG+8].
> 
> Odd combination of IG and eiw in these comments.
> I'd either go with spec terms IG and IW or kernel eig and eiw

Done. Using spec terms in these.

> 
> > +	 *	Per spec "remove IW bits starting with bit position IG+8"
> > +	 * eiw >= 8
> > +	 *	Position is not explicitly stored in HPA_OFFSET. It is
> > +	 *	derived from the modulo-3 remainder of the upper bits.
> > +	 */
> > +	if (eiw < 8) {
> > +		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> > +	} else {
> > +		shifted = hpa_offset >> (eig + eiw);
> > +		div64_u64_rem(shifted, 3, &rem);
> > +		pos = rem;
> 
> Same as:
> 	
> 		pos = shifted % 3;
> 

I had stayed away from the % but I'm back to using it here. I think this
MOD is OK. The shift operation makes the divident much smaller and the
divisor is tiny.

> How does this work for 6 or 12 way?

It doesn't. This does: 
	 * eiw >= 8
         *      Position is not explicitly stored in HPA_OFFSET bits. It is
         *      derived from the modulo operation of the upper bits using
         *      the total number of interleave ways.
         */

         pos = (hpa_offset >> (eig + 8)) % p->interleave_ways;


Jonathan - I added all this to a test program that runs known good
data sets. I'd used it for DPA->HPA->SPA back in the day. Now it
does the reverse. I'll post link to it in the v3 patchset too.

CXL stand-alone address translation test SPA<=>HPA<=>DPA
https://github.com/pmem/ndctl/commit/0b5ae6882d882145f671c6d6bd9a4fc1edb4b99d

> 
> > +	}
> > +	if (pos < 0 || pos >= p->nr_targets) {
> > +		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> > +			pos, p->nr_targets);
> > +		return -ENXIO;
> > +	}
> > +	/*
> > +	 * DPA offset:
> > +	 * Lower bits [IG+7:0] pass through unchanged
> > +	 * (eiw < 8)
> > +	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> > +	 *	Clear the position bits to isolate upper section, then
> > +	 *	reverse the left shift by eiw that occurred during DPA->HPA
> > +	 * (eiw >= 8)
> > +	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> > +	 *	Extract upper bits from the correct bit range and divide by 3
> > +	 *	to recover the original DPA upper bits
> > +	 */
> > +
> > +	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> > +	if (eiw < 8) {
> > +		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
> Bottom bits already established, so I'd mask out all the top part.

Done

> 
> 		hpa_offset &= ~((u64)GENMASK(eiw + eig + 8 - 1, 0));
> 
> As you have it here I think you leave lower bits in place and or them with
> themselves.
> 
> > +		dpa_offset = hpa_offset >> eiw;
> > +	} else {
> > +		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
> > +		dpa_offset = bits_upper << (eig + 8);
> > +	}
> > +	dpa_offset |= bits_lower;
> > +
> > +	/* Look-up and return the result: a memdev and a DPA */
> > +	for (int i = 0; i < p->nr_targets; i++) {
> > +		cxled = p->targets[i];
> 
> It's getting a little deeply nested so maybe

Done


