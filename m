Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33927944F
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131986; cv=fail; b=J5rU7/QBRQdAfwGzcoYPi+0MEte2zz3VACXmMt1DKUOxRrywpPbdMSrYj5d50X+ekLTJjAK3h362Ha9GPTAiog8NjlerxA4V5yF2OVr0u1QXJzGDsmNQ8RmMR0N5+Q+mLUciS1tjCOFQgIKBHXEYHtXfGsdzHi1tAZo4wJVp0W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131986; c=relaxed/simple;
	bh=Qc8ScsdW/dsA2r5LF/PdjXuIsMnMUO42XOYtxjO8TfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gd2BxZ5anBtLmGGwrLlAGsB9hmkyaBwpv+I7PeLavX1XItSH5w7KZGjDlMKA4eKtwulX49Vr2oR6kJe0hz7fnV9fOh5N9CvZesaYcs2yDhwsnHCW0n7bPMGLfwxdaniE8sRMHzhG2a0TcDzIbD0Rr0GZcoOJwltrWoLTr6ml1GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhEAIqfL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhEAIqfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760131985; x=1791667985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qc8ScsdW/dsA2r5LF/PdjXuIsMnMUO42XOYtxjO8TfQ=;
  b=JhEAIqfLmAlGq1SDI7ah+S5dCHKDGvURBSd0iK2RMH0j5JZsUeDoulY8
   snZMPfzj8bSpjt4dZF2noiOvdtaduVa+WVxjUbEz3jjODEuA9VHFod1Hi
   kFihj4UneXvhiUD8Z6YS+ccQiGqqV8LQgpHs7IrvDonxqQk9BxqyhfgCF
   fuY0p51vX6Q/FRKZMN1DJeF8a9IN06hh2uBRlLgyyEaU3n6gOb2h1tkje
   j4sIycPipXZ6eVPSXLIBhfTbXzY6mxfPJfIshe9TvMTTL9TU2SW7IWpVV
   E2DAYf3TjDToMBau9hZLTkoEBzYZUFwzlWvpx7ZY9xlrk9kREpzJFbNHN
   A==;
X-CSE-ConnectionGUID: 8WeIJKaZSJmatdhmiYYgiQ==
X-CSE-MsgGUID: c+uXdBK6SI+dtVgPEB8OCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62512600"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62512600"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:33:03 -0700
X-CSE-ConnectionGUID: 3V/EMDlYQJmMt1qWBzeY9w==
X-CSE-MsgGUID: rnpP6IgcSbCDB6ivWRVWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="186353984"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:33:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:33:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 14:33:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:33:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSMffPPdzyM/DMCI9Dwqy5lspHF2NS7dUDfg1P4yYQISzZNapRGTpWck69cCJ3vSy9eJch6oo3N48pl6UiyLENIZ9qN5VcvE78vrtBJWe0wFLnmSr4x5nWwJ+Dgf4uYaoazSvK+2OjxnlXAc8vgmJRhu8hj7Gha4hEFldNzoFlXgWOY2eW6yqWEhkdu8CkZds9qJdPLC+KPu5CJZk8fqBv7YGrUOg9+tSfNcPhbyiBJDCsMGKI1PTowEa2PUiRbJSS+xBbUaLtyGb79M+h6xNIfkAZzn0QGaKEza3WOaRBLrr2WHWpscdis9bTgxdB9eTZrgFQwPSniVmiZduD65gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1US515hB+TGZUN5laam57UyzkyVqhUo6TDT5YYcBTBk=;
 b=PAdmdn343f6kPrma2evmK7YK6HS66pp6ZwYvMhll9JHvFob2yNJDFtFPk9dyh2n//ILbYUiBNUlEygZKYBdX7LMOZwThZvjLh4+kBLFRHHxTRN4I+aFowYtofnIBTlSQ2uG+g+yConf+mfW3Bk1CrLWH3O7Tq3umPLcVwlkUcAgI8x1s7cfkztAQl6Ss4+PpQ60xiN6JjxMy1n957XeF4CRHQWb8jhRAQHNMiO4wb4ZSuoFfAPQeXaxuTHNLyq/GfL33a44XV8rffAIDRp+uu63DCTe/hfJGVJMCJX1MWbeElbnjQl4UZ2F5R3Bc2v3sHih6q6ODbsEnhOYY+0kOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:32:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:32:59 +0000
Date: Fri, 10 Oct 2025 14:32:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <stable@kernel.org>
Subject: Re: [PATCH 1/3] cxl/acpi: Fix setup of memory resource in
 cxl_acpi_set_cache_size()
Message-ID: <aOl7iFCYILHHavS9@aschofie-mobl2.lan>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251010205755.205280-2-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3019037c-18f2-4300-d3a7-08de08449588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hw3mliO/IeBe6m/Nzih2jw90FHIoXAqe4G56VpDen819YXX6gxFHf6o0vhos?=
 =?us-ascii?Q?ZmajHsUVBC3kEQJEOuZH52ZiDoceVC1abnJRHJdPOzbCAK6sQ18TlDvTdvxr?=
 =?us-ascii?Q?UpnSSERl+Ukrs4tcGWV8LTkH7hviaT8/YO6RY3h5bCs8Fj/wme9R9Hx8uHzu?=
 =?us-ascii?Q?czpxvE4NCG1C/eOmCUTywG617eR5oUdtS8UVGU326elQYB4WFUOgMyoHmrj5?=
 =?us-ascii?Q?oCpypaqifM6xXXQIvLzRfraufzetiW8wwk+ir5PAL8mTZ8+znufItqJHfo+q?=
 =?us-ascii?Q?JbPdZxpUdYlTfuUJQzitN4LChyKISTNO70bJxeufObvVGYxKurisHg3vNd+Y?=
 =?us-ascii?Q?xf014kgKIdZFV7E7IPRLydF2+Djs0DOgVoF0SdxuxpWsS6z96JFUnX7+efIG?=
 =?us-ascii?Q?nam1OEv8yTiSSXE0YV11AxgWfU4kwPJt0QZ63dFI6Q6OQFCjNGmRjAFinivv?=
 =?us-ascii?Q?Mu3hx9F8/XTldgyUa8L1X/VmJH4vi7aL7OpKV9uvy0Kade43BKXZHFlpDxXf?=
 =?us-ascii?Q?W2yhF3xasXzi4vwP/jUjG3kEIlFoa50XAt1DHvxfzn5CzI63gMx4c0n7UVFw?=
 =?us-ascii?Q?xxBSMuWnMZzrm2SByUCZNwvuvfdXrNSgkky36BcgKchNsI65/NPZ6HiNQrUr?=
 =?us-ascii?Q?s6iBQ2mlw2X/Wgu46ZBtontAX5ifCV3bOmZ/xtTuMZcygn1d+crhdLqbN35e?=
 =?us-ascii?Q?x9OmQak0xOHmIkKlut3S07S13JwCwe5CXkU5TcaMPuLCwmgkCbi6oWiX9Xdr?=
 =?us-ascii?Q?T6gPR2nWm9KGcfmiOyuUfuccI2aA1UKFPIDptIR1IrteO5oOrTiLviynocdw?=
 =?us-ascii?Q?cZ2y6YInn1fzYPge3LLQCPL9aawDtFNOuRM8YfD4VXU9iKI+d/enBGmboPem?=
 =?us-ascii?Q?5ty4mlK88i4RGTwoaHAdbOR7PGFdfOSUvsSJVZFQImLFrxYSUS3RB0zePrCw?=
 =?us-ascii?Q?qJL5Wd1WjJxLpWkKxsdvMPpvi9X6ri+dPnkgXu2o9hopNGeu1Uexg4zEkQz/?=
 =?us-ascii?Q?VtKyGq4r0JuqgrCw6+yjxT5Dr1bm6vM3aWX63w/bHyu4KD9WrdD2tdyKsAlo?=
 =?us-ascii?Q?S4IXRvfuru/T1QyBC59EuIK0kRFbYNEe5LZ2bjEgF6TdawTKceWwh24VZt9m?=
 =?us-ascii?Q?h6r2HRDhKHRih6RMeUidV5gvU+Gde7rdovW7ndU1WcVS08fLz2y7YL6S0zaN?=
 =?us-ascii?Q?09MXC0NwnTsVTV4MhDtjQmSHa/DO6T8+AJYLb5jFt6CK8WdQGwo0O/Qs7RSw?=
 =?us-ascii?Q?1FXBG/OqjFw9KMH/nlRe/cCCIjuo/FwQxoJ49lzM1mAbMUGgzzu2aRwWZfXN?=
 =?us-ascii?Q?v3xiYi2dKn2sxIEEijcKVte50XzYcT1Gu0Wd3BZtV77elskSdv0cE9dD7dCs?=
 =?us-ascii?Q?348tn0iYI66qPEwJRDrW/zkjSAKV3yyTa/ZwiXisplT78zgSutaOf4/aSaHK?=
 =?us-ascii?Q?a9TvYSDvgAWTP41BhhFLMRSF6s+wznuT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YnVx80PeSM4vq0V0Z06qTMdKbgWAiyFyV8NweqnKhvNK/DtK214T/AFLQf3x?=
 =?us-ascii?Q?jr/ZQalb17FE3BxdIz1SgM0Sdzo3ghiHgbjkq5o1+ruC+BDI31anOBF4rR15?=
 =?us-ascii?Q?bA7s9Cz0Vw6zMwUwpY3fX1JawC1l3Mgkn9hsl1n6QVNFUveiOpQAogC1ouDn?=
 =?us-ascii?Q?ZDCvXPLoCVEhPzhmocTcyBB1gdyrcNzatXsvu8YUEkx1IYsJNFX3fMt3Ex5q?=
 =?us-ascii?Q?9VWgSxwWH7j89zXvQuPMkfuba5rnW3v8YLtUUmFvQbArMuriOkYYhqZu7pSG?=
 =?us-ascii?Q?qlPa+nevyNq6T17BGNd8EraYhPeih1UHw0+GXlxPvper0DcE308zSQEBikKS?=
 =?us-ascii?Q?PqCRZ4FDuxH2kE+TfrMyz7lPCdO/sMeeieUUvHZh3DXMOLmw9XZQyISEMQ1t?=
 =?us-ascii?Q?XnnMsQWcfQUzJXGZzFoni2iQIE0WgiGJFcLOdXQv7qqj00oZ1/Nq5d3pK0pZ?=
 =?us-ascii?Q?W7euv2CPI4MEa1b/L4okVeYzXgYilznKBdsMkA/+05svFfLQe4yd3V19YY4o?=
 =?us-ascii?Q?hA5AvYPEU2cqlZ3ZMMTlZKk2JJ5Uq8pj6OQBSZF8lB0U2zEQBPr9HF467mti?=
 =?us-ascii?Q?9ltdymFRBy0sOetVa1epjOd9h8bagyzqpA0SjGDtuoD3+vJik4xrOd1lybLh?=
 =?us-ascii?Q?2bv0FToOLIaPyvLCoVL2nDETsGph5HlbmgIozJDW+gkz49t8+xwivOaiWVVX?=
 =?us-ascii?Q?qIG3V3SqiTlJVFO+q5/0t5/pFj931PISqpQXICGUI2m3FPVe5OVo6peeI+kC?=
 =?us-ascii?Q?zjxozzJ04tGwnDJ2hBQVUM/e0xx8Nso59g7poN39Aby1RKuaqFE1oSat6Sgc?=
 =?us-ascii?Q?K9Si4GT4MgeIcdXlygfT3CxLyU/c+W1l4yGB/NmoMvb1Fm+RgFTSiHR7ngJz?=
 =?us-ascii?Q?cSL02vHvIPAVqNSS31JhIsiip3dZFam9PP3XZsIPavRyLwPmT5fXFAGpXqMQ?=
 =?us-ascii?Q?skWn1vur9OZ1CUuM17GGnH2BOiKgDt1nkGFJvt5LY7VVfI8eA9Cg8dHbl+ZG?=
 =?us-ascii?Q?FfiwELwq9/quw1EpcS7CAlYN2fmyfcGuR9cu+g7+3ssz/V1dhf2APA/vsBTH?=
 =?us-ascii?Q?CoIMd52mt9o5arpH/O2Wyr7W0CvpLqG9xed6vHNjSJrsc3R/ExKEukxpPvIC?=
 =?us-ascii?Q?JxwIvbo34YPQn6BxW0JJIQNIrPl+WOQNEtUiVSezSSWN3pNlThe9tyYcprNB?=
 =?us-ascii?Q?57WmldPHKETqgbBmtqAdq1H5/xDs3lneQ1WLP9/bgotRRXat52iezth9pB5J?=
 =?us-ascii?Q?A5WqtAmhmtkQJXLJTYc3i58KUX04at8GVvmwikai/lO6E6KmePeNrRJSEcVb?=
 =?us-ascii?Q?VYlYjNM+mS7NVIJ+am/Hd5qKE5fHaT8sTXxZpr8J7BzWiC8V80jf1uo/Uf1D?=
 =?us-ascii?Q?pIqwEx7fK4ZMQ7yU9QQXFWf94TpFfOnFdZio2lvxQfCZejSYTebsTb2iyDtX?=
 =?us-ascii?Q?idlYtWuN2LenuBFwEInJLHqdiYQ814vOzeObkyPbdeST7BIr9pwM5Dpta8j4?=
 =?us-ascii?Q?Jkx1hi1TP7oJ70MgJJynwelue3AAe4Cl7ZgfJ8vXYXM16PTUw86/sAQADu4j?=
 =?us-ascii?Q?QSgRq1kRWfyDHP3niaIsmWrz5wt1Yhcp2ARkfnwRvYmTVi9ZO/ExJZvwfOKA?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3019037c-18f2-4300-d3a7-08de08449588
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:32:59.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsxQBXZUsc1qsVbcyzHXPKvzFGchIaOdYtFWGbrckVI5yVufJ3vRjdyV32VLenE0bBWMOMZy59ssdVtwjCjJ/PdReIPki5eS0a/W1c444hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com

On Fri, Oct 10, 2025 at 01:57:53PM -0700, Dave Jiang wrote:
> In order to compare the resource against the HMAT memory target,
> the resource needs to be memory type. Change the DEFINE_RES()
> macro to DEFINE_RES_MEM() in order to set the correct resource type.
> This causes a regression for platforms with the extended linear cache
> enabled as the comparison always fails and the cache size is not set.
> User visible impact is that when 'cxl list' is issued, a CXL region
> with extended linear cache support will only report half the size
> of the actual size. And this also breaks MCE reporting of the memory
> region due to incorrect offset calculation for the memory.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Fixes: 12b3d697c812 ("cxl: Remove core/acpi.c and cxl core dependency on ACPI")
> Cc: stable@kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb92efbd5914..abd2475b3493 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -345,7 +345,7 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
>  	struct resource res;
>  	int nid, rc;
>  
> -	res = DEFINE_RES(start, size, 0);
> +	res = DEFINE_RES_MEM(start, size);
>  	nid = phys_to_target_node(start);
>  
>  	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
> -- 
> 2.51.0
> 
