Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2B33D8
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465318; cv=fail; b=rJIxg/8waNdNVQBmyW1/2/loGnZpH6tYQpawIuwZzraEsb9pcyXTFBBN0zuwj3HwilyUNx2IiEpH7CSXIN+f2vf/Q/U58vtQz0VaB0VQ3LhcgjIWhzog8rFzMS4dBsH1YewrAdfrtBGByfbE9IzZGFiOJKZWAfEzuQI8mUBPaPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465318; c=relaxed/simple;
	bh=nSZGG7uqrvBEWAvsnASgyh3Mfz4qYyL4BFtcHguS2Wk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1KRRcPrX40XA+0rcfNY3BxzQXvPthIJyEet3TZCCvPHBpAArIvDJeAS4o8LAk1j7Cl2ziyg3zXdxGUJxh/9kEHZz2FTJK2oTPN6tP52dvCJ69JPf3onXZdzQxsu6F3Maec0SlQiNwm3J4ZWPjANmhr8sdRcsolu5y995PWH89s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/AZCX2V; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/AZCX2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757465317; x=1789001317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nSZGG7uqrvBEWAvsnASgyh3Mfz4qYyL4BFtcHguS2Wk=;
  b=b/AZCX2VUIsK8QuzqCHyX58A+thbvTlX8yKejSMCazb9TXYbceNcnVBl
   TUuNu3sk39jLVmJAMe06gHYL21kd0D64/Zr4YUnyKBHGEQO2mng3OWpQs
   v6IzW1t4aYbRjaMZMerGLDHfejeuEpHC6AU49727+Ch6WlK7HrDVi2NrR
   /Paf/6kUoyNBhEY8+2KnwrE6pi7/Liy6NVmRR7n0hjhCBQwFiQlxz1C+o
   LcWtn4vEZ0L+wr/F8kzqJEuFSu4rhGnTD/nV56OYumH0jrNw+1xRZDIDf
   TM2Ck/mc+6cfD3Hxw6ClSdN9kg0+6vNrGjoVe7kqg/+IO7ECSg+AEnUmY
   Q==;
X-CSE-ConnectionGUID: 8degzX5HQfGlmkuv/+jtmA==
X-CSE-MsgGUID: Lof8J3BlQP20D7lmkH8zXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58804847"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="58804847"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 17:48:36 -0700
X-CSE-ConnectionGUID: fd9xMjLOTRa6viKhKoR7kw==
X-CSE-MsgGUID: 53Xd8S4URWmu3Prn2zyxHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="172402365"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 17:48:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 17:48:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 17:48:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 17:48:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpe37jnaz/VR+18yNDhyc98I8qgWHyxwLqSEa9yNZpUMRHdY1MDIh1ib+HYjsM3k8xPXK/PibDyeDGVmsPPGHuZYfCzjG01OmwueQFEKofMwXLogOkGERX6mx/fZSHmzAImz6wgS7N8WiahsGplX4X/7BvTyeGqCCkLUAeQegvHuzdc2W3kUBjRtyPydhjTSKaop4WeAKczPgYL10Hd9Qmtzp2EFGIr9Fni6m3Bi8Mw8nAnYSh1N+qd4K7jgH0t/0Ssgz8VP5UbtlnnjPcU/NuNjqNNI5kqvvhS3/PMBw15PFvE8gMCh8eW9D2Sknxp0+6o2TWHBk6I2ZHZduAitxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSZGG7uqrvBEWAvsnASgyh3Mfz4qYyL4BFtcHguS2Wk=;
 b=S3108ZCu2PbGqBlBZk5F856VnocnsxsuJvCF++hB9qXBXezw9m7DWMwTQ1MGfkaM6mq6cOjxgC/j9+HOmINkqClS7DKLRYLJhkor59Vme0VC+qwqDGbyz5kljK+o1iPsU+LUJ499IJbmsSrCpXfWsfvzeH0Mwn/fySrVvskZ2IxlALEmzJKxIZCMwzBjPGBeNYQSQ1yWddFgQ+2+RNupG6HRvEWChgFJ237UZuBW8FPchHwAi+SAgNUUNtAuz1kbzs7z+V6hQ7hqVcDHjHGx3HJo7rVEisM/3PUqBlmFQ5uhU24KMSvgUe0XDZ87S2Ggr0QE+K3sHtJDzGPQ6VdBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 00:48:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 00:48:29 +0000
Date: Tue, 9 Sep 2025 17:48:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 08/10] cxl/test: Adjust the mock version of
 devm_cxl_switch_port_decoders_setup()
Message-ID: <aMDK2Rn9ZvWbJRlH@aschofie-mobl2.lan>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-9-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-9-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bbb7fd-cd3a-415d-d672-08ddf003c21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W5TvWlLIVLNs/vb67ujCcZOqH4n2h34ePgbeMO68mXuOZVwrROHkPuzwhmfh?=
 =?us-ascii?Q?17H90qSi1JssYK0vwQwTK9pnMw8kb/1fZotBS7OxDMFuAwwPUQGC1he8T8rM?=
 =?us-ascii?Q?H5yeE0JKpZAKkhbgsnXN0EOFsBk4iciB+wkF3aoCuwNgr10qjXXZnEU19cad?=
 =?us-ascii?Q?1yZXFi66di6m8UksXKenBImdq32u5TiHF5FbefweE1qwYG2Ri1DCZ0uTYdNJ?=
 =?us-ascii?Q?/QU5K6cKGtbJmgTrMBe2mv1eUjzTsp85F0vyP7oUgM9qAavLVCiFMJE8A9DL?=
 =?us-ascii?Q?ZLnXYdlYLOk/AziXxDswxHdLl0/lo2YyWhPBFz+yrG2YLBHsKugMryletG/8?=
 =?us-ascii?Q?Q/w8wNfwE85u5TQsn1jAt/IGCIWI/QcvLka7QvSm2m+azErkLzrq6mDbuxYM?=
 =?us-ascii?Q?LuoPeGCWLQHkAqlizXLEBhj7wNO0TbQ80dUYxknUVHrpfjUhLnvHbipQ+SH/?=
 =?us-ascii?Q?KP8cw3rOdk05W1IVdj+mpmzQLV3R4MkbwY5LGfJewV1ev3x/BhpbtGWc1AhF?=
 =?us-ascii?Q?huCFkLK3S8vhLmTJCaXhFArs0iM59O6665vNFl4mjvrvvGQz0tCkmDpNsGoB?=
 =?us-ascii?Q?V0wE2aVRj79fbNUpgwx9fe9F4gS8E5vMCkcXFdDmtExCrHCU5ca6QD1bq0LW?=
 =?us-ascii?Q?AUCMEd+vogqFBb+lgUXpt/qw7/pgPmhWwqhijdybTDBQExlOTy3m7cKxJSSu?=
 =?us-ascii?Q?jFd+wujuWt4WVBU77zN75ivivyQ6Stq3+SIhnUFxZr3BebPgffs59jWIvJCB?=
 =?us-ascii?Q?H4JFZiKTf3K0RZQsw0ZrjZvA6U1ievK9ohU0hwlJbaL3M5joIIVgWuZuxtyo?=
 =?us-ascii?Q?PRAP+V7u+6VocJjVOHovKY5tW2nHgbYdd9ghTTVN7PUO8UXX7Dg/z3KWksAT?=
 =?us-ascii?Q?zKG7+qThULKoz+wr3423B0mivXrrAfm3EDEoVPoFA/U+bxea+zlTDst6rC6O?=
 =?us-ascii?Q?4hm4NvS8JAZ9Ts+6Tc4A2DvPNQf8U4iYDldYaRb0w5lSiRygLQyB0RmtLBcL?=
 =?us-ascii?Q?StF0q2V/b59/m8EfkkPqBvZvf4TLiE0TvyoM+i39dZ++4TylElxYN4sOuMVI?=
 =?us-ascii?Q?GGdog+J2mbYgeheYtnYaLVS2DkgwQ1NZvlj3qkWEOArPHz5iXKJrvzWdRb1P?=
 =?us-ascii?Q?7WMza7ARjpf6DdISs4ZK8LC14G6z90BQgvsPTBJ6TuyoxZvZLFsSIUBRIUiS?=
 =?us-ascii?Q?jmKfo78zpd7pECRYjVqHsDs6OCc8QaHCcCaZ9YZXoK3iJeibhxkpA46XmjL3?=
 =?us-ascii?Q?UwXlweE71fpufeOTpSp9C0CT+hlmIUe05TQY8BMRibP+LoyAZUUCwOG4TKPW?=
 =?us-ascii?Q?qFM9cw0NxIaRMPRd+vVztomgRGL+yQjSXtkFI1weOSmOuXZfTWCWNos2jVeJ?=
 =?us-ascii?Q?0ehDG4n+JYC4FzIt6l6Qi8foDlIcn2nwqOSmLFry8igcoFWhmckYoRReKaT+?=
 =?us-ascii?Q?03xez5vUXzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDdGxYM6rgIaYFmXnyMSgv5wlySRxKrLHJ/5ob2pjbAA1sIC6IoMHRZ+JO/G?=
 =?us-ascii?Q?DGw99n2jCNAtGv+JJbmluKbid4v68d8MDGir0mAAs6D6+qQT10OgC8iKfdVF?=
 =?us-ascii?Q?7laBgdmX0cpgVyBc/5cRHoWs+tdF/o7jBG0RgSrOWfWn5P/MRgGx9TPZzcE6?=
 =?us-ascii?Q?RUe7ilXlVMrnv2PVoLHwPID1h25azg49/X1F2pnq+G1uLfH6c/Av0c/kaYGz?=
 =?us-ascii?Q?3oemni+evBJX1rV809qBD2awB2oubpseWgtw0Og/mA4TginNhjna/DLTYybc?=
 =?us-ascii?Q?tM13SZqvFu+oXAmclV326153Env3R3P7ASy2MRLK33UcrL9O2HELtIFnwkmL?=
 =?us-ascii?Q?//FbXg3BO13TtG3Int/kGwxkM3XGnk4MrW8fJdHuPSFNJOkFdpG7nAvME1GH?=
 =?us-ascii?Q?MGV7UHgF8bEmuJHh/Upo9JcUGwud+JnGNCb/xAK0mjxwFvPUNwUwz2veNtPq?=
 =?us-ascii?Q?SBVvPUs2Zs5TD6AAcHxExrEukUnsnz5QAthiD7WTzLHpNhw8LDTIKwlBKUUH?=
 =?us-ascii?Q?k+GPXQblPby9ADt93xTXR7pkAED490MqCAWIWiqNGAoPy71BAmmriXinwww6?=
 =?us-ascii?Q?jv/01f1XuATeXmaEwDDIX7t9OLCHfUbr3VKJNh2uhJpzCzWJqZ+TMu93oWi5?=
 =?us-ascii?Q?ONtqGQRJYXEEIw3eE3Im3RdXQhCoseOQ91vAJ/WRZywBA7ACv8sUSBzPhZnx?=
 =?us-ascii?Q?q3Rx7B3VPgi5NBmsJmu7RWfDNW6yLB1qF0yP5C05nfc4XCMaG/5ISYPqBMuM?=
 =?us-ascii?Q?3nfllZeHKGD0GP1d1Aw7ZisFH/95RQBf1jhVKv/QgnTsuN6XOw6fx8wJIwTl?=
 =?us-ascii?Q?3/BThWDvb3LAHt7h9Z2jlGq8PhV8ZqEV3y3VP853YrHnOIM7FywSm8Pw5cj1?=
 =?us-ascii?Q?6OCveRF3GXRaUgZv9tK7l0+mflX+01jv6sDhXK1LUDKIc1SHvmpzV7Fy3K4e?=
 =?us-ascii?Q?sMcYLGgomXYngLVYTNY61VPBwE24UV7/yDSMoGI/aJbXatrU8kI91eW35az6?=
 =?us-ascii?Q?8mI7yORelmoYggQJLMkOxQOsc7x+RWPmcQpxE+nz5QQOxpy/x8Z/lnbZmEZ4?=
 =?us-ascii?Q?SesYLCYXEnItn1mba9iflEXv9wcUpOpNh/ZO5vSb2LolTnTgvj1hpMOM24uU?=
 =?us-ascii?Q?TsAi/EVyKn5y9p1cUoOQUOnDG6N67RnhYf+foCqDvafKtsTFh77nOI4blILA?=
 =?us-ascii?Q?i8LVxTTJoD7N9yDc+fNddZo8zrEGSqkyVU/mWJoDK461Rka1sA43QVxV11J9?=
 =?us-ascii?Q?k01CSzxPergtEj+8rhHzNhRpTfs0mroOvKkDG/Ds6KaVA8ySmXLoG2m8wBGA?=
 =?us-ascii?Q?0DVfDzUbrAs0qqtWWOpbP1I+2TDkp/iVPWJfx0RmpI57WVchFRVJY0sIstpN?=
 =?us-ascii?Q?VWZV0JMYlC69AIolJoMWdlZYobbfFqvp+DlvdyLk5bmvfPRQIpM3gSK/F72J?=
 =?us-ascii?Q?JZcm12EAlA/e+LSm3FE0/GbLDoLNZlREQ4ocgxWyHmiUBiKIkqLefjut5w2y?=
 =?us-ascii?Q?X+oQl4DorPGuABIVMPN5ApiiS6Bh2WiR98ye0++fNHtOMoOng3G0T1UEt2SQ?=
 =?us-ascii?Q?/TPF9jp17BSMDc7QxBGfyd2RvN9B0Yofxl/YQ6iDnLDSo6DZeC+9sczRBuBO?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bbb7fd-cd3a-415d-d672-08ddf003c21a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 00:48:29.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKmmJlEVJk7F5cogjYpHOKQIvlcW7S+vGJTm9r1+ElhRAc+S+dElCF1VpK74Ipzc7rRpOQfabN1SFnXiOcw2y5cCRQI/U62l/sxLuK54ABY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 11:09:26AM -0700, Dave Jiang wrote:
> With devm_cxl_switch_port_decoders_setup() being called within cxl_core
> instead of by the port driver probe, adjustments are needed to deal with
> circular symbol dependency when this function is being mock'd. Add the
> appropriate changes to get around the circular dependency.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
