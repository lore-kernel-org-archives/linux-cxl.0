Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80482E92D9;
	Fri, 11 Jul 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258635; cv=fail; b=a9GP7/9YDKfcBRnDaDIia+zbR7g9xV/FVGqPwZQFfQH7tPWJZfa5dxpvs6x+P3WJGlE+TveQjsoaXjXd58Mn1iiiqfZFCq7MgiGTzAf4kK3Wx0yR++X2T94jAg3LNOCZn2HEeQNRGmx5qZoC0cWH1YlL+qDsPntPxOujnBnCemM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258635; c=relaxed/simple;
	bh=egnvUwQr63q9k86Wf8IQzpZTaFmDti8xVL32oPFDZQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hk6gG1PAIEe6bsY6LcN6vsVNdEAXX9WubeDrIhXCAGAMLTVbbSoWD70n0/hhNJ14US50mQdrArpFaSK86DZ1xnKDO5RWNC4FuHTmZdw3Eo0B+SdrDmwMQdAgZOhz/TuVzmoFQe8aMhdCJVWkatFNj9BUWWqw3aSgYx0BcoT4rP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMaM/TOc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMaM/TOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752258634; x=1783794634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=egnvUwQr63q9k86Wf8IQzpZTaFmDti8xVL32oPFDZQM=;
  b=KMaM/TOcE6EawSF89zK39RHIS+xTsh7Cp7NQ1gR3Yqf3tcfH+ZIZCcjH
   RvggdQ2palt9mLHbqmpOGoStjyhaaNbDOor97chg4bhIfqbjOqmkE4z4R
   Z5j4uXxr8dao0k0e8+Wm5DNJBOUj9Up5PvMsjweQUHhA0jc7AMSEuzgnb
   nXheTi//Cp3sxsp7VjaV/GYxbIlvfpR6cp17wUvsbUa1nmrgAfAn5Xn7A
   9CWA45kcIOI6MXZh1ITgjrwZ5F5wbgtwfLi8Ioj1Snij8wGNPtpLtUk5h
   JAH+lTpIwnZ/Y9EL9FrYLNWYlGfxduadbswPuOXtbvxFphPpid4qEh/Rn
   w==;
X-CSE-ConnectionGUID: 69gtci35SK2/KUUE1+atyw==
X-CSE-MsgGUID: 4fjQvxpFQpGAVib+dFBfRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54532423"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54532423"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:30:32 -0700
X-CSE-ConnectionGUID: 0+ceeR3eRdynI+Nq4kSI6Q==
X-CSE-MsgGUID: shvjJIScTYqDzqf6tvBHdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156987074"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:30:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 11:30:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 11:30:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.77) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 11:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgntCuS6pN7bQ60Dk9ZQnnf9jvF+H0pWqUb9ypyCH/GW3cZh6hYySxLm/RwYIzueFPPyehX1z6NN53GChg7KT0yuN3Ts7SdKbzl2zrfMPUXDf8JhkHLGvilyRyOB07FS6ehRZJ68o4YkFIR1DwdWJ81UhNSomgFvsN9zGqJ8O4Lm40tZMDvt2w0RIAIJm45QJDV0NrUO+GJube5goHvGMeGjDn1Fu5wF6Nwt/wYqdwsilVXwrfyFpVVAwb/VCb1KtJjikn9AoZGfrGI9Rz76Sj2jf6cVTcPtPNkueQud39Ff5H2hidIrQysXg9HRrUW/raT0tmgLTZq2PKezgyj0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B6rdEHEG8z9pkUqO+CugOWbWDWiPu7icUydm3n7Ld4=;
 b=vNgu63LUlcVM32Nszmb+RwljzxjJdtAXqxNGtU9+APta+qtbQ4mmWQ3Yx+dvR9MDq2oBtIfgaELHojArfzHaDMTDYDeS9RuDSvAiOuH/HIIb8h+sk1TdJItFlU7AbrWTxodVgEZ5qCgZjiczu8v6iR5FJT2L53FGl6EgFvc9xFgpf4AKt+kwO71tO4KKYXvL5LX/MpEyyLh+ZmA4pjbtVe35oKjx0ZKM8fh5BxQvXqPDvymcyBP2ExaBH8J2nYSedByM+PpfzOda63dPEA4ctPejPde9lX+ryZ1g++lXVvSlJPrJNLoTmxschzs4K418EoW7w3LgR2ik4PI6zl3lqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 18:30:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Fri, 11 Jul 2025
 18:30:22 +0000
Date: Fri, 11 Jul 2025 11:30:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI
Message-ID: <aHFYOrxu2gDJkCVL@aschofie-mobl2.lan>
References: <20250711151529.787470-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711151529.787470-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbccec7-5f42-47ff-e348-08ddc0a8feea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fnDqJtsoSggg2t/M6A6YyFWp/2BVmmGz9ng8jIhUr1gsciLovZeQOUb2GuLg?=
 =?us-ascii?Q?2sKKzAlNpu8VZzVWjcB3fX626DfjY4k1q0USF5s0TVFMBVftm4KP9AFnl+fb?=
 =?us-ascii?Q?+ADalPChBs0b7bKys7o6Vq08l0GZCZARQlQq+Un+6epARIrVQCutkFXySjs+?=
 =?us-ascii?Q?LTKQHjlWg6R0kpAND8Iuf07QeokSjyDWjq05rDisUbYI9G4cpIEdM2K+9lYK?=
 =?us-ascii?Q?RVkyTKCqtQgfbRqnYPIJ+GwFuD30mx/e5I9suDTPDKU4mR+F44i5jWFaCs3r?=
 =?us-ascii?Q?x+FXb8IC5Fu1Go+fa1PB64IlglPCf0cV+sUZyLlPLRSuZ9U/mdKp5Zcd1yLm?=
 =?us-ascii?Q?P59qADYI0fx36Ne0ph9zuAMuCwcmdB0b60TNjqACDO4c9iu2ma0W/XHiVB+S?=
 =?us-ascii?Q?lt9EJsgmyf/6byAmO+STg0rB8cUJkm3T4oabw+MKcAls2pGqzRkF1pWVT+bx?=
 =?us-ascii?Q?t7gYeDgiDEquko8BB9figzXbJTvIvXaCTAEo8adsIx01TG3c6CMFKm5NFoBX?=
 =?us-ascii?Q?Ll7Yx7MOmnTNjbnuiMAYDLVVnFcO3s//h63Pug/2m4fNWzJqgniSewxBMk5B?=
 =?us-ascii?Q?38k8Oy773eRiZAFVzplt5PUEkToUdjkpsEs4AH2DK2Sz1Xa+1o0v+Ax63q01?=
 =?us-ascii?Q?zth6DueRNd62gmXOcd4GGky+QbWY+DzGG3VmxnrBceACIqlmUyk8ngtlErM6?=
 =?us-ascii?Q?w7zWGwGq3LY+7z99xDS4Ca/w/MS8/8GA0FXtgcwzlw3NhYE2xrjcOcuoYSMT?=
 =?us-ascii?Q?q6+4Oxfm5CDTz3sBX41HWkJtA/UzDqLn47KOINliq4RGPpNnt33Kq4aIVIGV?=
 =?us-ascii?Q?VhCfG3yVG5mEDW7qRvzRY6AZWX0eH0aebtCnQiNr1xCLi7EyWfHbMxzEc5YL?=
 =?us-ascii?Q?fK0k/2qW3Y4AEVIdqWgND0HdeBtTY2PgSwFg4BWBXfpMoiOZgh/2TgZIyaYx?=
 =?us-ascii?Q?XoH8pKwwdvUcv5NT4qR2OOarPQ5Zw72v9/UHaQYO41Vyb64RmVUrcLG3BsWA?=
 =?us-ascii?Q?IO8DZaqQeBOBL2aLA3lgtfFgkKyFXc45aGTB7RnEXBKnz5GJOGmCXKxVxdsk?=
 =?us-ascii?Q?Tcctt0uTu2CAF2oSg4lEffKk2624Slz8iKev0VO2S5HUv5dYJjbdqflnPdfi?=
 =?us-ascii?Q?E4rImitqe6T9+Vih/PBUNgaCYWGLanTE2ikJhrL47BcHSbbVBm7iDZ8FjwlS?=
 =?us-ascii?Q?cedxXj9VPRS/BRJt/1wYW6vGBWfBb2quAepTMoA5TbudUI9nDx+DQxtzCqoK?=
 =?us-ascii?Q?P7rXCnB1Ex/a4UyAdTdYeu3bLY8yTwdyBRhlDqm7tPbUuA8TOCH//KRbEQ4L?=
 =?us-ascii?Q?hmo3+twQjcbXsfc7KqhDnvG4ertvYQl9AOS9Jm2VLep7jZTp3N3iQOtBbf6P?=
 =?us-ascii?Q?j2hIbpM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLJ9jojLgVh4p4aLtHIsnI/uZP+f3v60QatFOu3EEIyP+nJdEe0OmVuCCoe9?=
 =?us-ascii?Q?mWB/6GGZ6ld81lYQuf+MS9td/sAihHsU8m3x23UFUmdJuyvkjuwQjtQVKWTb?=
 =?us-ascii?Q?In9WnaC6vsmAzWjZTK7j1L8hig5SCCU8bW+VYNqI8fOGwsVMc8lR6WWnOuok?=
 =?us-ascii?Q?uzXvF5QQfJug/80vd91QDEnEGZ/vNu6dmAJsunY6Dx5yISpRkOnH2nWjZX5C?=
 =?us-ascii?Q?w360nHjNlfqtEz5wnDNFCbvPGyouGAoQocoD/hspu6SXbeQP4WT6rPz1SbCO?=
 =?us-ascii?Q?XAnYWXC1kU9pK4QdOlbJFYYBBhGU9SIwftvsRSYTCuFhPXdo2zx7tJid//FT?=
 =?us-ascii?Q?J1jbSrGSCKaKRGtcxXRSDLRxj7MLX5/iwng4PKTJgQ39E8TPyagKGSC8wkT5?=
 =?us-ascii?Q?XMwK/QGR7FUUpw7XiRwCwkOPPdQaEPxrLBhkEQJq1I/FoqkuWmopuHHtUdy4?=
 =?us-ascii?Q?5dOC2ISB8fJlh+lDwmx1hciouZIE+dswrf4jBuSwAQY2PdtzyXvg7W9Xm4co?=
 =?us-ascii?Q?4kW+/dZzM6JWj9D2yHEjJETH0UpRYKyBcgC5Ie+hiGZYCn/8ZUfxna0SI6eg?=
 =?us-ascii?Q?j8H0OIrW/g/NMU95NczvGNCbXWwAnjpDdK9zqI/FaSUMPLDSxGMNA2qTRahp?=
 =?us-ascii?Q?u7ilKdE40tMGHDvkk2tM6ZMc9iQycDBqato+q1JzZSapyL5jxe4V5QKrWcJz?=
 =?us-ascii?Q?POuG0wbH4DiZbhmOSxJLBSflmnD0ptdFsqCGh6si7MhAtn2Q1LI2zGRaufMn?=
 =?us-ascii?Q?5ysu6L/LUnIjdQWXjFkLIK+00UN5u3rAXNP46dDVwXfaPuXhv0JkD2EJV94m?=
 =?us-ascii?Q?1xz83ahHRsEsrIsBKwWpOsHHBUcCHzB1olaeqhZ7wiaNceTezfaUCYF5xRvp?=
 =?us-ascii?Q?WncXsClnbEAx1nrPdFFYIEIw40rvwy+NR1qQZysGfSHrxH8IsixL4thzSrsr?=
 =?us-ascii?Q?I+oqoeXDpTcDvmPickn+as2nchnXcA1zuRyvoAoqHfmbAGZ2BbKdHV7UNpUx?=
 =?us-ascii?Q?OCQRYRmvP5iPmQzOkn6yq7C+zZzfO/sopdgkmBeLpTbnzRhDq0oK8mYXPHIe?=
 =?us-ascii?Q?e7d4WZRNJz//Y0VMeT4+FNjAIkvrUe8xiam5qxgvxiVSaVlYijmTh8IAQrgh?=
 =?us-ascii?Q?G0IY0EMlKM6nycBqupNUqVzx3Ix86BEVqnmB05fMNgyYqC1LXrkKkP4/IaU5?=
 =?us-ascii?Q?ua3TSQwVI7HGSoHCeL0kgACjjVxpnKAknzLi0uF6LjbxZk3Sdr9rwCU9x8GO?=
 =?us-ascii?Q?NveJPfNDR7kEeA7DyMjFfIO0pVnGq2RYuxkUW4n8+6r8L/ftOU/+RBxIjO54?=
 =?us-ascii?Q?cPX1yyOOUSvwO5JKpmBMNgPO2v7STW1Vo6Ucow+ruQmjBkl7DEhyNahmoxGC?=
 =?us-ascii?Q?TaEJ8gxsodaGoWshhN4ATHPRzfJ9EucNMv0ckJM9/Cg1xmkTBT4G8Gfhf4fi?=
 =?us-ascii?Q?3Ex6X4nYO7IpS5DvXhd7D83UAaKmBI1ROP63CmhMOwK4BvHw13VdyTHrxQEs?=
 =?us-ascii?Q?89Z8cpxO2Qpcp9IGIFhUKPZ9mw0GIqaLxfZS021vC5Dl+ZzwGnrIIBHi6ymg?=
 =?us-ascii?Q?JmVdHlDnuUJq+PajtTUmG+te6caxtFg3/do1bFxGcgxTcHn0iu9sJkT7lBqI?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbccec7-5f42-47ff-e348-08ddc0a8feea
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:30:22.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW+0aIkKHZDICCTASO5b2Iymo5xM++u5MBBNkc3Pj10myrIMLiRVjLeISccLYlDFLYC5Y/bNYkCBn6RWz+YNaku/yxbKqbR2yMjalX3ebTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

On Fri, Jul 11, 2025 at 05:15:27PM +0200, Robert Richter wrote:
> From Dave [1]:
> 
> """
> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support.
> """
> 
> Current implementation calls hmat_get_extended_linear_cache_size() of
> the ACPI subsystem. That external reference causes issue running
> cxl_test as there is no way to "mock" that function and ignore it when
> using cxl test.
> 
> Instead of working around that using cxlrd ops and extensively
> expanding cxl_test code [1], just move HMAT calls out of the core
> module to cxl_acpi. Implement this by adding a @cache_size member to
> struct cxl_root_decoder. During initialization the cache size is
> determined and added to the root decoder object in cxl_acpi. Later on
> in cxl_core the cache_size parameter is used to setup extended linear
> caching.
> 
> [1] https://patch.msgid.link/20250610172938.139428-1-dave.jiang@intel.com
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

