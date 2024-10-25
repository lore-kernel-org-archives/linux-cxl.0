Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD1217F52
	for <linux-cxl@vger.kernel.org>; Fri, 25 Oct 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893039; cv=fail; b=hpddDQhw73IGSvoOcPSMQKqGjzgV3r5ThNm3K35gF4A3NCKyXjPPyx8PH7/iBzpaYZEMLHLKgS6Yii+ia6+44Qxt1gfTLEq/kouI/pHpvM5wXSNyj+RZROgYHHQhXwa6TdlXfRp8SXo+7nLuQIMP3M26ck/CoxCLrJds3P7cxsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893039; c=relaxed/simple;
	bh=ratwHqwzsAK+DzZV5Xr8pe/Xuxj9dFLpsTsddYmYwac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtqQVeTPi4cUOgqbnlS7mkgMAIKKsvRq7wpAe6/jhh8C45AH0O6FigGezVLGcR64fHtV8ej6xFx/sVDo64vWwOIYapGUMfbKmwQBOu63WhIwaX0FeMgyBm8d1wdtav8f+BOYei5lvksb1gUAnuHDRGMkNGGEb2BRU4Fsd6HpMKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MA1ydCw2; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MA1ydCw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729893038; x=1761429038;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ratwHqwzsAK+DzZV5Xr8pe/Xuxj9dFLpsTsddYmYwac=;
  b=MA1ydCw2FzwGT6C3HjshtQO/QDfjKmZ5pjcPeGm/nOOeKkQh5WXxUi16
   dQeSuHgHLK8QsgmRIxfWPyUGcz9Z7+q2DX0KX/QEpf8kGqXQAE9Zv5MHO
   XGguRXb9fWUfdHUPdt7Zq0VvKY13maMyyajOWbFrTZWWEjwlxTdoOSEbw
   Y5LdXizpNEvJRSOxEGX/M2OPVpwp9LukDNG+V/HSxc8Ti+Vf2jnnckjda
   ic3pAJ6kzHaBjhAmwVQYQM9kYX0dahImLZzHqlcd4cAgOdULTflEaVDvo
   pedUxm4eSb4IY++vgbbE+Qu4cUko/dB9B/JQ4yhwTDhLB9Nr5awkZZG6H
   Q==;
X-CSE-ConnectionGUID: NBPcvMBZQlqGlex1BGFUXg==
X-CSE-MsgGUID: Z+9/hMUIQXmCQEoFV/XvUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29440231"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29440231"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 14:50:37 -0700
X-CSE-ConnectionGUID: w2WBDc4aQiWeRyWBnKp8Lw==
X-CSE-MsgGUID: KZyEx8tLQuGEnbFLz7RBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="81141404"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 14:50:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:50:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 14:50:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 14:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+jN/eRFF/fXgQXcfmXi3N9R0xYVgLnYsVOojY1h8gqcRjB5hJlPZ5tIDoBxKVyV9q/oTfNhO6KebBq47PfjOQxb6AunAb4qsqvfHHI3sRJnSk0CRAO2YzExnIUO/IdBqkQgrpjW++mEOg3TQXS5tP7i4Rav8vWJojYHOndy0kYqQ3FpVDGSN3GsXeEMMZQ1LD+Zl5gPDyEFjcqvdnBzkzGlukg93FnzOMPQz9n9Jp1Yc1EhHWZbkMQvKjo0uyrRGR8IUeZc6ReHcBMLFOHRvTi+qy/2bEhltombKO4+1b2xes8P6DH5C/42U4cFqlsyaigeLZat3Qb7qwJ2xGynLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ratwHqwzsAK+DzZV5Xr8pe/Xuxj9dFLpsTsddYmYwac=;
 b=HKybJz/cIIioURJ15BdHcSXNEg4yzeKrzOa4hfnvh5eT2x31F1kbzSX3P1wROsrZMLBn2Lx6dfBelCP7CMLd2pm7qlrapz81US5DIp2k7V8NeMMGmZPuzJ33XneG8evBTnmA9ohPwYmJi6SL1sNqcqV5vo10xlNhT33Fidem8lLLVM+sGl/qXzV3TO4w1qU0VMG7Cp+9dvSvAVogwN6or5x9KsjipujaCfXH8rKDZ2t5wDXka9ECuVkCuDKnfxkZmZIIsMegI0zVB0XNdHNQ7VTLGgwpG6sTgXDLs0I3G0jA5rp480kTet7U6TdvpFOpqwiMugzGRG6fYkTrqt8Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Fri, 25 Oct 2024 21:50:21 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 21:50:21 +0000
Date: Fri, 25 Oct 2024 14:50:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Coly Li <colyli@suse.de>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Coly Li <colyli@suse.de>, Kelvin Shieh
	<kshieh@lenovo.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: downgrade a warning message to debug level in
 cxl_probe_component_regs()
Message-ID: <671c129aa250b_10e59294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241021050443.318712-1-colyli@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021050443.318712-1-colyli@suse.de>
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DS7PR11MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d7d05d-41af-4618-a135-08dcf53f05e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0zz1udqzewGTVOIDlFp3CFNb2NPARqPbtt6dmF2yH38Zo+7hxixU7fs7CDhn?=
 =?us-ascii?Q?naXQRCh9rU3QS5QGKcsZIsU61zNmU8rTh9U9ikbzbmEji7f3wgf5HRJDsmiL?=
 =?us-ascii?Q?3J1kt8u0Pr3JRLBo6nCrp8zHDnfUidzJgxMbp9Kmk96hXYdIZUubyO7d1U9j?=
 =?us-ascii?Q?dFlWLge6pM9Tkm6di9xC1ZcAGUXwDgWQhqLUixPE7eQqUD9Qv1aFed2OG4Ry?=
 =?us-ascii?Q?qBjqNxRgLDc+zySTydOB4MYERzatlk2N2T07O/efYXiuaIIfggVs0TOn8pRr?=
 =?us-ascii?Q?K+1fehEVY+f9qCk8ghWswbiCPH1wB0a+3wwsiEDoF9bFBP+tlvGP0uZqJext?=
 =?us-ascii?Q?e0vN0GkwZMK+N1acB9EyoWB6pgryz5aRz8zh9mQhNkw1eMbzro+AeuFk7Z/h?=
 =?us-ascii?Q?xGhHTOH+hUWSOiiAJsQR+HtpGK9Gx4PNN5kL9hvvduHubviitxXI4UlxJd2M?=
 =?us-ascii?Q?H+9760FM7LrFtsGid5PkVKhhIgPL9H9P94ItkUf/YOHQVbrDbHXMLFlvDBag?=
 =?us-ascii?Q?//BasVHPSXtC4ZLJ/NC/ASuMMC739SlVTaOqGJZn2jXWQWn2CAuj5KGJgFoy?=
 =?us-ascii?Q?BlNt6oczTIfIX6KkP66x4rMYcNLVfeCsRELHD8H71t3/Ja0jf9gQhqX88QvB?=
 =?us-ascii?Q?+hwLSwLRBkaoawQ25xDhJXfZ1ojRzgfuizp/XnZeQ2YIMRa5umoKtaTPUMJW?=
 =?us-ascii?Q?iNaY85SQKz8WlnRtRJR9npXS//V5bOvvmuXrb3bsKr7U3W40qGAQ+sEd+Szf?=
 =?us-ascii?Q?gvrsOT4eFkecg3fwEaGizZ43OH572fsNNkxePedkxU/+sDZR3BkrLnNYy4nO?=
 =?us-ascii?Q?7+grbXqvnrxqFlLNg3/Cd3kBsXtMx4dRcDEJ95/ZD5QCCqRxXe6oVi3TJxwa?=
 =?us-ascii?Q?5o36wfHKw/Nr1SZrbCOjJw2nulOTLbK2S77uQ3e3zYLS78J98eiVak4Ekhjt?=
 =?us-ascii?Q?12unFu+MpX+X2Q/kg74mea1XuAOXmzvwukTb3P9Qp8c97n+xEc7MBuJ+PnEz?=
 =?us-ascii?Q?e4qKahmGS/S1DRCgzrgLiUVpBd2uXZNdYFG3AzXICo7pg4lvaC2hDPWUGio3?=
 =?us-ascii?Q?oXDf7PvfmzUd27vt04FvGU9w7snKEcDFnuXRU4z5JPUA+DaN+Z5TJl1Qi8II?=
 =?us-ascii?Q?Cb5Vb0SjIXGK2EB6fYrt2Cf6Mc7r3cc5EFRSWGf609sh6ciaka6sl3gaB/Vk?=
 =?us-ascii?Q?EDgN0YI2JJrQEmgC7MrKpUPtEFz8AzvbhJyaoyI2/b/fvegr3vjY7lIF1wX8?=
 =?us-ascii?Q?fexxhu+JujMw/z8gjF35/v2v0XNGslPvzbq7j/7JauO5mHENKz1t2pFJSTGu?=
 =?us-ascii?Q?CxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OYzWW+dVoh6V34YgGQ+FHkQLUZWRsQRkn/cQGZnqfy3NjBRBMCX2Nc4e0Evy?=
 =?us-ascii?Q?oQ5gRCMGHKuClcnwvBksEs5HzqIl3Sv04Bmh/T1Cj6wM+ul8NH5amwjags+M?=
 =?us-ascii?Q?vBlPuIWD35kYo8FskYVT2kBAUHrBubrc7PuYioTTeonj5bDt5z3ypUmxM1mL?=
 =?us-ascii?Q?6eNWXlyE0gK91CeaM2D2mqSFdcn/FtUF/2iWD7BZFzK3Uiv7bCLPqJ+BzwnM?=
 =?us-ascii?Q?mjTYkqeoPio2a0Gty4fkJ57J98EJckh1kjh3fdtuuiUxyodoDypkbnyNYGDd?=
 =?us-ascii?Q?4hLUTIQ/bUvAGgRYU3ww10wNNCnmrMYggn7tkuGIMMtG20cZqYXhFwhQaOYF?=
 =?us-ascii?Q?WbwXd0kJ4w6ahg5k/j1R2DM/umEmkUKew8DyGkUoHn4YZ/X+sD+/kWt2ZaKd?=
 =?us-ascii?Q?JlhkWSHqHP+O8yFKxEEeMUKfXhNUn5zCVcF0ykkAw1mK1DfD7xWP31sTJa9c?=
 =?us-ascii?Q?GNZZMjxd8RY2ceawyNjCTsMAPJmqKh16UINoPbxyd1t6N8cDXQqthHKqSnO+?=
 =?us-ascii?Q?E/h2vHeYOFq1fB0vXihoXCjTHpisyP4BGxYQOBKm5FIt7gqECn/lWX6Rn91j?=
 =?us-ascii?Q?hG1TSSFcWujrMeFMBcL4ky5/YVrGOtnkTMuUBHBjt7mxGuikjJ4Wy0M4fEyv?=
 =?us-ascii?Q?kgSKu3QXY4+DxjU9Z6OdVfwcogPEymHmblqTxUIQYP6npBsVjvRLl3TMl683?=
 =?us-ascii?Q?yCN7An8sPxu0+Jh8lNhNd2iXsmTI5A8HO+kuriQJ/zvV3Bg/EQO3tQvCEtiy?=
 =?us-ascii?Q?FFtY4u39xava5ynwxm8ga3zH4ISGrZKAi7V29xS25h6WzEgM1VtXMdjIIy/8?=
 =?us-ascii?Q?aeD23TTqMzsXQyDo7SFiM3eMy5x4oNU4DxMC88QKIL0xeMiPBFSIl9OoM8oD?=
 =?us-ascii?Q?Haocfv5n9Jn3mVKSd1Eeyi5z9E15hzeVWtzVxtbC3z7jwe8zhbo3+berSJbS?=
 =?us-ascii?Q?U2zK4QeHlk+/BHP9/fXJyee1tfZd6AdNuEPEIVlvwPAE9ttHaRGEsxcFfHC5?=
 =?us-ascii?Q?MYgsYLypue0cdX0Jc+POHWETBDGj8C+TVHpo9FuJLIwdwVnRzUiQAMVNo1yb?=
 =?us-ascii?Q?IQ2RLr5Wkgt6qErxNdMIyONSzNRwsmdVG6+m3SikmJ/oN7UW6y0fPAocGqO5?=
 =?us-ascii?Q?KXCtrUmqrLOfVzVBXv1x6WaVpXaTAknnFU6wZo9l9oMoHZd1ZCrykaBaHOBe?=
 =?us-ascii?Q?wmziKv90tKSR57NdsVaXN7+YY36mB0fxrWSGK8WWM5LyIg8xN0E6sXiqx97I?=
 =?us-ascii?Q?pAhYlLSGzG58GdYjdXl5NowzJoh1DAQW9+tob4CgnIjj08/QoIr1qpo8M5zZ?=
 =?us-ascii?Q?0pyeVgsbFjdBMSnwbguSN5upWuGTrudu57QsOOJjmrdG2Z3liKncfV00kS9O?=
 =?us-ascii?Q?5DRLTOQQmTh7zMHJVOIB5mOFl2CVEjd7LZeh6hJIabKZzdrmINOsvvLnjyuL?=
 =?us-ascii?Q?urjYjowZQB6p+r0+4P0kjJml0A07c8qyu84HO656bFeLXWabtfN7p21tDW8I?=
 =?us-ascii?Q?DCt1nLR2ZLm0YZv9I9IIrnWCpOMDD8nUEP4sSM5Uqys5pOHd6xyLvZs8mNMO?=
 =?us-ascii?Q?4gzTI3RxHZyNMVkFNtmhmu3VIBjQt9mWeihZxzy26GWKqdmflhcD8A3bQE7i?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d7d05d-41af-4618-a135-08dcf53f05e1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:50:21.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3YlnyaVkc8NMzHy57NHiEjVb0Sh4g7fmm82ZiFpLOAU6N54+f6AxwyKv+/IqVpP6AYf04jF0J/un49sxZ15eDXQfoFpYha4KIoQ8j0ayDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com

[ add Dave and Ira ]

Coly Li wrote:
> In cxl_probe_component_regs() the error message "Couldn't locate the
> CXL.cache and CXL.mem capability array header." is not a critical error
> message indeed.

Instead of saying "is not a critical error message indeed", lets say "is
potentially a false positive error condition". Because if the code could
accurately identify that a CXL device is attached, and the CXL link is
established, then it defintely would be an error worth reporting.

> Downgrade the message from error level to debug level
> by using dev_dbg() to print the message, and the end users won't worry
> about the message anymore.

Agree, kernel should not be emitting error messages unless it can
concretely point to an end user visible loss of functionality.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Dave, or Ira, can you fix up the changelog per above on applying?
