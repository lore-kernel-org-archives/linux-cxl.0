Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B0623
	for <linux-cxl@vger.kernel.org>; Sat, 20 Apr 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571805; cv=fail; b=HXk/UDKr9kU+/KcfyIp/WpZ7pmc/xYmpCbxajfHmoW7C25Oy+ZaOG7N2cOcCew2EI08rt7nDw5ncyGow7U1unPqJgwF1lrwTYh3Pye7kBwBD0/PjE7BU4GKtQf8/xUsrg/HJwMjHU1hxSnmCCBg9tmkKJ3RnsnsAA+RqoxVh5Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571805; c=relaxed/simple;
	bh=6cgjEs8aJAj5qTYF3vi0kI8sMUGbPDFWKB1gHjkEDwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J9aYuus6W+3/11Iwekvv51Slv9YXJmtO73UlNWAlzls6aWkfDQaB/blUuEG2fe71lIFhG2LUz+z8XeGUSiDtPIgmWunM156xU0rajIYGug9rt1oM9T7/Qiy66ZVDHNIeScOCVslHx48bca89RR+TAmnuyoZNbtKhcdf+OFrYVMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw37KdxU; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw37KdxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713571803; x=1745107803;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6cgjEs8aJAj5qTYF3vi0kI8sMUGbPDFWKB1gHjkEDwE=;
  b=Iw37KdxUGRmjB9pxK0wgTjU0aJUjQf43ywIHHiR985j3by6FSrx5Zrx8
   q1o6aHrwWYrYdVw3eqPf6hQLYhdzURtuETFXP2NnalrdE3xSlV4g9lgPg
   vBmRuW5pxnGdS801/FN1uM6uLxilyBdroheRVMhypC7CJDuQjRZs07ArA
   UrR1KfRMd52OpsH1HXVHj78vM2PtC2OtmQoxLS5BBGVJJWbq+bWiZGo/q
   AtIB+/34QYGQLJVF4Qfiz0jZWsDg0pAagM6wkS6/Z7aOoLuKx1L2yvN8a
   i/GSJoIW9E8IEUeQ4eGjuRIm6RzPbL6V04PGxr7W3rQ84YOKbFEJkgWpN
   w==;
X-CSE-ConnectionGUID: FTDMEzThSeCypZ+7Oa7hTQ==
X-CSE-MsgGUID: kBsj66mKREKAIZpF6KKEOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9055782"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9055782"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 17:10:02 -0700
X-CSE-ConnectionGUID: oEy4e0+YQsmW4wEaSWaaHw==
X-CSE-MsgGUID: 2ClCBBqmQl+H4iQe04BnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="60922203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 17:10:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 17:10:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 17:10:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 17:10:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGv7LxH6mBJ9Duu8nWlUK6xmK2qA0/rfvB4qRb437oAf000iSwMbvK46yteAQbNvA2iOb1MEScM/a9fFKqCTxRzpwt/aweNWy+bgSL7h5mmat8QPc6/LrkjZ73VqN3he4fivjvjp+wwacNG+3DTe0HbBzXEegXcx4ttflIrmEESsUc9xdC7pq8AsxFLqpzxb+9Mnh0uH2hpkE/nkBN2QjAIVJf09XhiKKIn3ElmMujbFoH5SzRzZAkH+e2XGgVTOi67feg5gXXXsd9chrPb7OtLZR1NMXqsBq5SxnwZPBckJpaif6NzP/U3z8eozlBqfmrmzmJqmdFzYi7hz7MjHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eHzo+5h7Ke3Dmrr5KOUSsrxf78MHHF0zwhQv5yJZ24=;
 b=V6Dl5ccpYObD3w8eR/Pa9MrWBsBQUvBSGQeLKsm+HBghbgpp9pNqV4KIc35Sf0AUAy1h/qWPXjmyNfwf/L2n9x/qm0uA96HrQgEuges3RFa8p99wjlS53eAM20EXGxo/pLxlj09o7Cbwv/1roScsMN3DVE4nwaJmbOT0Qe+HV+T7PU3mRnWxp3BwF3yK+Pj9AnlcZm1U+EJgZetccl7Uwejof0pJip12I4SzWs6cdZPk+ODcT3ket1jEVoUg6hduTvnM3Roe/ccQQpvNcUNzrTXnpIzzShxEFgTB2Cifitgo9qu66jJVsud6V3kwOtyFs4bCk69rF7HQdUti7WbTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8300.namprd11.prod.outlook.com (2603:10b6:a03:548::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Sat, 20 Apr
 2024 00:09:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.014; Sat, 20 Apr 2024
 00:09:58 +0000
Date: Fri, 19 Apr 2024 17:09:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: Kwangjin Ko <kwangjin.ko@sk.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/core: Fix potential payload size confusion in
 cxl_mem_get_poison()
Message-ID: <662307d32ebce_4f2872944f@iweiny-mobl.notmuch>
References: <171235441633.2716581.12330082428680958635.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171235441633.2716581.12330082428680958635.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d1a1f2-d713-4c88-7fe4-08dc60ce370b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5B2+T7cvLSO9rN+mbAgvREs/8gNt662l1E0u2DpM+sBxN5wyJM1nE2Ad04jP?=
 =?us-ascii?Q?rvuc0ej+zZcXLMH/B3ctBochlwxv5efXCrcRmOSmR+iFx57HYavkVIEIaVdJ?=
 =?us-ascii?Q?dUNC/UGHS/N5xN5tEVqFqGzTR8F95RSd9NB1Lmp5tWprZApJL/T3yyWbpaso?=
 =?us-ascii?Q?AUWQrhN1jcbXoPjoYIdur48Ov9yEvhDkBRZPWyc9WVbBuG8I6E+z1wwZvmFm?=
 =?us-ascii?Q?EmefebyZxKw1Fzk1XvB5B5fTCovpKcBm6MHLnNi8QytzdYphkXK+3iOKhwJR?=
 =?us-ascii?Q?WIF1C+quJ5J5XF6phyHawcLF/tr+IBq78Biz+F05Yjne+bSZLfpjrgK+ulxV?=
 =?us-ascii?Q?jVDGXUeKdy7VOgLSB0D45Kmd13rm7Mx7wx9+nU2RMKKOl0y65Lkw86LoFb7S?=
 =?us-ascii?Q?66sVsE3oXbo3A53OxUwfoHnCSOJx8qerjwLk7fbID+oeAhxvr1Y3YsvinFf4?=
 =?us-ascii?Q?Gi7szZcieCfSTf2BBUZXF3jhu1EvLBQy0rBsq2hHZYXad+hBLuYbW105ulOB?=
 =?us-ascii?Q?1vAFg//jSYNUDrZe/e4y6UM9V7fSgafJVI4G6gmGOqrs+tee3k8kLTK9Rcvh?=
 =?us-ascii?Q?6kWWfq3ZkM88TPzRRgL0WazyP/km7EVnk1CXtRieUJkjdbziM7j4fJkn4KK+?=
 =?us-ascii?Q?QZPuC/5j09jEVg/gVBemHsy5T56jz4kRvErWM/8VhCWqXHwgDUg0cLAJGXan?=
 =?us-ascii?Q?OW7/bk02W4uWP2o4R7U4rHgmJ9rmKgokbT0ORHNEuQxiqVdLGBbSyfxpG25V?=
 =?us-ascii?Q?8dC94rELapuIsbnijeel/pbyYJFMaqF2SaFAaotNGwbW1hUvpgcHC+/dCU3B?=
 =?us-ascii?Q?YcZe/0OYdHRh3iDYIvwUdEtCNiXhActq1gjs2yAEWY3i+b78UMRHEtZZeI3Q?=
 =?us-ascii?Q?/KfUqmWHTeHOZ6sVekN03AbVBBFJHSvZO4K8fE2bGn6QTL5plhmqyfvgOVl/?=
 =?us-ascii?Q?YDMTyV/dOHr7pbIdiV+AAgWT0Ix1Vsa5B7XUuOfN4+32OS7JyN6IaTTNxA0W?=
 =?us-ascii?Q?nBcA+Nnm8apXJ5p9huGlJPrV+ZPKGcKEWkOAEBJG3fce51c5nAN5LPh74SrA?=
 =?us-ascii?Q?ypJgQXVUOZFZwGKoOIlHWc7A9o6IZj8vF/0UO8dQi8Hzcu7LVY1EBqo3ALBk?=
 =?us-ascii?Q?jSrSlTBFGeVWgLrpYkivFmq0H0C8xsetzwVbQo5v9fL2oVAsAjH4HG5VdrF+?=
 =?us-ascii?Q?lvTNphfDtutHzACZ4T0FgRshakR2oHwlqKvL+ejXF5XMtYxRV0oLlAlDJIp8?=
 =?us-ascii?Q?Bc0ZFa+/uL0nxJCzaf5t/Cv6sT3wB30FA3USNZHbUMQghattpV+zOevyAvla?=
 =?us-ascii?Q?Ztc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFut/qz7xy1qAD50YaC1mlRQbRFsCH5Qa6TEvd4MtuNimfRxHqBI/BuNLbB0?=
 =?us-ascii?Q?rvbjn6zGDc6NRmJQbqDJoj3AF4kuJwmKuTOqB5WEwdDhIBG/b6NrXrsgVa0D?=
 =?us-ascii?Q?UJCLYsyKP5R/WZ78KDvPlVoGRk8fnxs8Oaa7AFta5HwHJ6m89cxGQ+jUGgOp?=
 =?us-ascii?Q?jMOImsLotpWEWTiEdw0yj/EYDpTOZRjFhkaFXFO8N7IPXOFfEgnYRizlA3G+?=
 =?us-ascii?Q?Hz4OVmmJbibP0yZQr/QqwHHfv0uaF1KXrjBX3ScXeBkweVzNZ07pugVCsVM7?=
 =?us-ascii?Q?Fm/QCeAl9/E+qOqrrlQZtrKFMLK9Z5g+RphfMVL2QRCy8pEMtNn3xe1MoNP4?=
 =?us-ascii?Q?D4QAeWi9DOqkwUducdhByswrXSGzjR2jWcVWg1Rp2HaRpInfojJOhJjF1HMt?=
 =?us-ascii?Q?rCFHuCNtS/aHBE45GsQdYQBkfqe/dl7y/MJxfhKX6vrh3wG0NV4mMiR0k7Gf?=
 =?us-ascii?Q?WXLEyvZXGpMq8hXNbpMWOcYyypW88NNN6YEn/dLhLxbLdOZkVI5Yuib7IOoR?=
 =?us-ascii?Q?YeeAY8N7nu26Nf8SPdw0m2HODFwXjGYajK5DQO45NCIOEFZBRYUMMVTwuDTj?=
 =?us-ascii?Q?KIl4X+Mpiw/ojtvU8b4GADQUg+O5J6ULIaYgKVt+j7QgFwb0ZvFdt02ZASnl?=
 =?us-ascii?Q?+qmf8nSK7ik29IjCjK4vasCgasaRKyvbMi6Qv1P3Nq279ztb/kxc0APegUHv?=
 =?us-ascii?Q?7fzxCL2YKDkANUn3gJXNb7VCZdiXpnxeuFsYpHXK71JVjtAyBFcmQqvmpI4Z?=
 =?us-ascii?Q?xQsH2kHUD4ughgZ4IqCrdb8v5e+DY0RvA9tZ4RuQaOqo0ef3nLcSE8mjJxMf?=
 =?us-ascii?Q?URxJLpBZSYvuDlN4tmgzhQgCpkdPNQb7K0qAvXKzY0K/qwq9bZF6y3HM6I2d?=
 =?us-ascii?Q?X5mHEoUce1t5XcNZ7dizIhZVDNPJ2qW1fwshk56h470ITkkAUBBWhaBz/ABw?=
 =?us-ascii?Q?Pd0hZjZGqMaFNP7zWr7SG3fD+zuynj8A5COewTi5mLG4r5iRyWufBI+Op1Cs?=
 =?us-ascii?Q?wrDt2GYchO5Ugg/ZZNDqxZr8l/CgK8GbD3DrYdNHRIv9YvN6cZ1i+iefu3XK?=
 =?us-ascii?Q?Ll5+E7fHU82rKi7bLP4PgM7yw2lwH9O32bgq7vMFE5UNRk4WNNrUM8X0kBDo?=
 =?us-ascii?Q?Sz4f1W1S89soK03T28zXm98ZnVYCZzFt1cmiHgy+iAfJGC6RDmMhjefjaUiO?=
 =?us-ascii?Q?CmtLjsmCmFUg/Z6hoXOd3H7VUki4/w1H+DIgKqli40kSdazjZeDlaQ0FH76R?=
 =?us-ascii?Q?r+aGr9V14pXCRPbTn+ciV138JsX6fem2ilE/jvyYWBDv/uF6E/FpLtJgyU3N?=
 =?us-ascii?Q?prDDdybnh2tMiQkQ1GIx2ENTwYG2jyEvFOIxi5Lk7Nx6fkKnquBl+zNpPACv?=
 =?us-ascii?Q?MEEonYdK1nead4LE1T0r27auf4GZWO/ULveUqQzBpwNDG1fqrlFqP3XRMNjD?=
 =?us-ascii?Q?5mXz9gLx821gKC2ONDpahnfOfJYAjjL8a79WCdSLzs/nVLEbrTIzVL/4Jzw7?=
 =?us-ascii?Q?nfkcSmNQOsPB1DSNFE9UfpufqFNj/0kbkcMMiHB8TqyX0X7qGYDlle9Yj/Iy?=
 =?us-ascii?Q?032rtOsX4uyjBqOkZU1bSmGd9KuQaVj35tLRn81Kh37837M+xf24mR7oyzte?=
 =?us-ascii?Q?ycDnsWT5WvrWhfjAKi5jqtwMC1EM0+698mNnjCjTrzcR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d1a1f2-d713-4c88-7fe4-08dc60ce370b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 00:09:58.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmaCu3CK/4PSDCgMhHH3BIziB7sgOFUO5xYlKeD2D7VuWBJLdzX9OhjlJ//t4dTI3NU6+rwsejGPRav8rcp9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8300
X-OriginatorOrg: intel.com

Dan Williams wrote:
> A recent change to cxl_mem_get_records_log() [1] highlighted a subtle
> nuance of looping calls to cxl_internal_send_cmd(), i.e. that
> cxl_internal_send_cmd() modifies the 'size_out' member of the @mbox_cmd
> argument. That mechanism is useful for communicating underflow, but it
> is unwanted when reusing @mbox_cmd for a subsequent submission. It turns
> out that cxl_xfer_log() avoids this scenario by always redefining
> @mbox_cmd each iteration.
> 
> Update cxl_mem_get_records_log() and cxl_mem_get_poison() to follow the
> same style as cxl_xfer_log(), i.e. re-define @mbox_cmd each iteration.
> The cxl_mem_get_records_log() change is just a style fixup, but the
> cxl_mem_get_poison() change is a potential fix, per Alison [2]:
> 
>     Poison list retrieval can hit this case if the MORE flag is set and
>     a follow on read of the list delivers more records than the previous
>     read.  ie. device gives one record, sets the _MORE flag, then gives 5.
> 
> Not an urgent fix since this behavior has not been seen in the wild,
> but worth tracking as a fix.
> 
> Cc: Kwangjin Ko <kwangjin.ko@sk.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Fixes: ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
> Link: http://lore.kernel.org/r/20240402081404.1106-2-kwangjin.ko@sk.com [1]
> Link: http://lore.kernel.org/r/ZhAhAL/GOaWFrauw@aschofie-mobl2 [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
