Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D245027;
	Tue,  5 Nov 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819852; cv=fail; b=k9UBZgvIUnZ0xEVFpzUqVb+xeI01bOHA76uqGAyp1XC5mHhwRTUrA+hY2nGSjiSt5c21aKfcCGW7K34ekPK1vNTqBrLdUFsB5rrV3s1NwOBFvtiUYAdG/AdnHEbXjM7cletYUjcmLLiMO90DPBXno31WqUARVzR3AnaAYdsv9Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819852; c=relaxed/simple;
	bh=qP6PEBfADSVWxJG4IIIa4fFsN7t6d25F6ysRBeLxWXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tmr+0rNv4twpoBAr5EVyBHMQYSOZ4XfixMAtrvEO1pQGfZwqGlAGK1jHge7nSO8R3xDnuqSjAMM1PYPx/Tczp7sGKW3ktQyzt8t9syNXLYnKVcLsNi8WBIboLN4KMGrjIsor5mgcha4+nTzLnUBTVBmQ2xXVMl8xr9oC92l+bmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pt5rw2YT; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt5rw2YT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730819849; x=1762355849;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qP6PEBfADSVWxJG4IIIa4fFsN7t6d25F6ysRBeLxWXw=;
  b=Pt5rw2YTb4I7F6Wc1N5AfZ8qxi/j1nc9WNS19U+W9AbhBMmEBIuZcHve
   cjCvPHz+N4lyyI5OV4GS7BZACZcismxdwRscrRq6p8s+1eUgKeWXb8nJj
   JhDGbky7X5gTTxmmSvpdt1IHCsFXxmAefrAOMReTnyB9RBQWaYCAWbgLU
   PvjZF+ro4WjY8t5OQhJCbjW9NNnAf4/5fN3nggeqqMAA/1vB0sz7Mc0ua
   n8q1aIbbe2neg6jF1ijZsJcdFYosfC+3nimnwqRKdC4auI9ZsvhJtEHeZ
   u+B5aJPYamTDPuRw9B+J6MfNOWazJWBni5QX1Bk61TGzfYqaClST6aLfR
   A==;
X-CSE-ConnectionGUID: JtiS3UbQQreNN0L6hpYvPw==
X-CSE-MsgGUID: NH9sQ5MMQMyAhWJF88fcmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30735489"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30735489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:17:28 -0800
X-CSE-ConnectionGUID: q5zpUIHNQ1uIppJFfmU35g==
X-CSE-MsgGUID: 8wsAGz7gQFu9ILeGr/Pv/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88841092"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 07:17:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 07:17:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 07:17:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 07:17:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrVlITW1ZJYrmQrtTiJB+JXeBWGBkrero2BswXZ4LQ9AVwBhkgkTs5m3+WVmEs6UrEvkLPmHIAW9OGyf9HDajJGd06MZ9rCJ8O3O9v/nLRwSKgqFmo/8KmOWI0XdGJbsf8g7xFEOJ0PClDORui5zFx70ubUiTX3MnruPLbk3+ZpDbYi+IkfDuZMVDu1gNHERw2LYSldxJqkvz5n/y0jxeOOvd+qi0EfLklpoyusP+lC4mi9w1wqXJrv9otJxqlQ7bGOxPJRsrPykmsvwP/EP88zIE55qzDKAStbmlDwiWYa2bOwjtUq0eSq0VhcSjdM1bXAQRsNU8swWbXwRiIzwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzebFdRejtFMOtsVENKCOlaBvpZ1V8THLFivAoN548Q=;
 b=FAfP4DNRVfKjWMXG6r5/QmVJSHpVog69iRybElKyBpOBezaXLqMp0bnpdqcmCa+IuuZjHpDReYys1WIpV1np8Cn1cHX93W5Re2+cTTW+ns2Il5juIKD32MDG0ctP7lte2ZElUx28WNHF6d3mSO3cM49V0alebdtdtkDKzGKfJsRpekvrOIpG0oRO6sH0U4VTj4LGm8Kn5rzrs3xeDaU5fpmjaPtVbkvu4QxRvj73mh+qytvsfHuuufCw2+V6KDm4WN8qf77HC4NjPG2BVnpDpLjSFfT5VPqV9skqDJ77krkuwPjRAYmKLqeG/9NnbXiCw9uU3yNCgNDL30vw1W1e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6183.namprd11.prod.outlook.com (2603:10b6:208:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 15:17:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 15:17:25 +0000
Date: Tue, 5 Nov 2024 09:17:20 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <672a37005ec2a_14ccd729427@iweiny-mobl.notmuch>
References: <20241104084110.583710-1-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241104084110.583710-1-ying.huang@intel.com>
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 895ed979-3bd1-4d2c-b7ec-08dcfdacf459
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SnbUNVfaO8gNwjQdMYfLHTq8U122qeGQ+xUgrJwJrMP5enqNK1eVWNYhw5WK?=
 =?us-ascii?Q?xVXtRe8fHMnWr+4VF9X8cmlcPb5a32xcnR+Hvo9PfSlsQNzlsK7UseciRUxc?=
 =?us-ascii?Q?bKC2Rzxox37V9qdA1WmueZy7YAUYkddwmDswuarZUbQcLA0Qu6K4oISURClC?=
 =?us-ascii?Q?LTtq1K/SaTS3uj4bV2l3sEhVFPrusdN95SsWq5wRCqJp58lUeNfMQOaQh6+3?=
 =?us-ascii?Q?EsdpBaYdH6Q7r3K/LbJY8oTc1cZ9EyDgRyegZ0NFuuOqvcVKRce6LaSD2Wd2?=
 =?us-ascii?Q?h3cudZ2MuK/TQsv0WbaLP1YKnXrtXhpyZn9c53MBXMI7LhN5uPJ/V3Yg4l4X?=
 =?us-ascii?Q?YCVgGozAXO4In5eeUBJlHQ0m8KtNmEYaTeWcIgS4sgWynlko6DAmkP8/BSs/?=
 =?us-ascii?Q?YTDATzFFjy9S8EFXT0SLZkh4ulIWKA/sINEGUD02q3VAU1OUlFK+9ClZAn2q?=
 =?us-ascii?Q?bRrs1as8QJ1glOf1P2nqT7aFS0KpdWwf2JXkVVyozyCvx/USP822cs6tBgoN?=
 =?us-ascii?Q?Vo+l/PDL7ZJ08zYzfhVWTyNHkKdm2NvfFyxWe9ZcfLtNAmHpVfDQsDddDwsq?=
 =?us-ascii?Q?06X0DK2Wsp1BZo0oDrTTbNyudTe7BznyWqcFGF5Enor0vI2937Nh/vqHlI1C?=
 =?us-ascii?Q?b1bsvNZutApeOwoM42BuybowUmNY/UYYZqQSe3Jcrstw02nQZVu66CG1DSg2?=
 =?us-ascii?Q?0rjre4ri63+9+m9S/Y9Pze8b0cK1fEIIvBFJ1NMVv+sq17HpztqtxSHi0z6d?=
 =?us-ascii?Q?wwSL1Prj53Zt/Rrf6cqnHtnYTfPYfwXBtF1gbbmrSHcxAiRPGSf6NgdkJU7b?=
 =?us-ascii?Q?mrqtDfYuX/JXKo1YKYIqRBNmBtgqiilywMYOpZBrZP2J52S10tP9mGFEVMaR?=
 =?us-ascii?Q?EYBDS+OR8b2arcAHpEwsNMCTA03lbqWgmtv3t7059JRUF0QSMP8WySdGMzIl?=
 =?us-ascii?Q?XxBTTIEkpTuZSUQd4xlBoBLM4WZCwRbrUXtDs7+01sPKoBX8RAwXqJPx6OG9?=
 =?us-ascii?Q?Zw1QZgCOwR08yojUj2Zlz+k5CHcA3plq3Sa/2KZpJ/lYuztoXwyxpy9KRYXh?=
 =?us-ascii?Q?RrDPYXht+55utMN+2lBEcm7geGO9GX/aog9Ks3NoV9+wCnDI3VQvMPuY9KmH?=
 =?us-ascii?Q?rvKJse8eqBJ0T72XwRHj31zz2+GxkolI3jPnInsp8XMHQ4QNKHYpurc2sdzI?=
 =?us-ascii?Q?lnG0Bjj4Y5zbnXP0edHV/+RFa19Wv3qkJQ1LaPSRxsapX0wfnob20Ga9rDbt?=
 =?us-ascii?Q?p15MkRUCN/CIOOfNFaxPE1taWl7Mp6Lc4ovd0HxbCKgeMe5lT6mvs3qcGOnp?=
 =?us-ascii?Q?TSr+6UyAE8VlqOr4n5d2oQdb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huuQ6SdUsAqxGZ/tLhcYGCr1UiqVfufrE6nSwFH2zljamonAWCqoVDYjMhd4?=
 =?us-ascii?Q?Ss37U9OLKQ54qwKmJf1NuSOzA1PeWjiSj4Ew0KS/mM/8LIX+wkzgEsNAOJW3?=
 =?us-ascii?Q?5eoNpD5+QqotpQB0de3Mdp6RE4XZOy3QFD+sUrrvxOWMCLtMGdnfi0k/GHdW?=
 =?us-ascii?Q?c5kTWBkiixdtsn2wyy7lpSOoponm+N0UKRHwLTBwQ87SbV9BXXtYU7nF0R77?=
 =?us-ascii?Q?Pp/5yl/T78wdYWC2WzMAs798R6HtSJcQWdvbbGhQl3VYm0slL7myL6ZR5WYy?=
 =?us-ascii?Q?WoFyGMRJV2zZ37TUIhtEXlJSOCrJGQ3KqrRN3tdOoJPLfG4rADH8Vj6HHqmP?=
 =?us-ascii?Q?GOe/Mfxfxf+4DHEk2YNJKJuhR1Mfq3/Umh3RLj815WnY2H7m01sop7FpZJbG?=
 =?us-ascii?Q?oBF0X6clXCdFBozQ+Dtpus0XcnrKr3up1yUX7BOn8HwV5SAhbpFSxUtaBnEf?=
 =?us-ascii?Q?CRUsmiJJifVDtFfXSpa/ZMUumgjyi0aYCQ0kmC9wvK/14t1mpGuE+TbX8LSF?=
 =?us-ascii?Q?nqQlqJy79TjtbJonGGs8VvHUHEAJvK4AO7MRXn9vw/HfILo3xLz9x7S0DUIJ?=
 =?us-ascii?Q?Pb9bDT0Hdlt9W4I1DaPzsDPw1gsK8Q6Csd7i/Juq3qR0vzCCWYSpqCou2OMl?=
 =?us-ascii?Q?Hb/3nkAovL1hZgzsqc9VgK4vfYBB33wNSVV8VXn2YPbmE7IJzMfr9P+nfwkN?=
 =?us-ascii?Q?wA1Z5A8OPaEgQb/Fg2bTw2lE0/boDb8rmayQUBAKaRPL8ZLLLGc4U8lNfq6v?=
 =?us-ascii?Q?OrdtGHI78CM03vNDeUcCi9Y0fEjJQsN6BUxWqE5nk8/z4CXlBJi6aMopurzB?=
 =?us-ascii?Q?w5LuoRPdZX7Crxb91+0Gpw/iByd0vfBZecBsbhJvgjL/IXJsq7BzoNzQOvqq?=
 =?us-ascii?Q?AOfNkYETWx9BgFbK9SoCoM3aRv2tL7Tsx3AhYiGonJ4VgM70Wr0UVDebUPYq?=
 =?us-ascii?Q?yg+W2j3lS91fkKtXTjrWATJMQ6Hzx2Z8jHWf0NgfKOdNi5gcu8Vc3Erps4NX?=
 =?us-ascii?Q?gI+PVqPUYwiEPqcZ5lDYmwZcHGeGDApiDVFWzsBpMwxTgXmwX0DWEJ5/Ja8i?=
 =?us-ascii?Q?2U7c31iPbc0KwTHSUPHsFInxR+ci2XmmBkoS85/5qHwfxNtcj9qsO+7sxtCw?=
 =?us-ascii?Q?z3eyOe16nkoa7En1hEl6bZVegoE6oTrdAufteTqkdTET2n/NJWMA9i41W4k4?=
 =?us-ascii?Q?X5wxOOY36yVsDq379I6Ba9gX/6qrsBQ51C12Au/vEICVUU27tCwlB03pmCNJ?=
 =?us-ascii?Q?0sTYAQ0apencpsHhbQ1FQs+7EWKYGnK3mTcdCfyvdGZJaWbl1+CZYnpKRWQ5?=
 =?us-ascii?Q?KrUCOHDBWpNOklC12lIn/NblM+cU6XC9BV5x7LGzAyU/aznFZFWuSYOlLctB?=
 =?us-ascii?Q?/6vlyRqHzJ97ew6lypRbbGjKrP4m1aEP0Ac5LI9sVbKqm37hMDQbNqSVaBvR?=
 =?us-ascii?Q?TDNBHKiy0SgTBug18oLsppwoVgFQBmQnPfbFsM8wNzflOPpIuXI7fmlXjE7b?=
 =?us-ascii?Q?pWiY74pCq4HxES/U+ML0g2F8sFSw64VebPWCRufz3EwMMc2k3/PbBOrFU0TD?=
 =?us-ascii?Q?W0DJOGDXlK3yLbFkk5FKAWaHuj6OYZT/YWvjjhEz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 895ed979-3bd1-4d2c-b7ec-08dcfdacf459
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:17:25.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiwZ60qun9lV8HEwA6A0fyKc5ebDKqVzdDVlq3jbSJNnuYZsO7KT95xRHKuY8vff5vQmWzOIVSa+K5mdwGVbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6183
X-OriginatorOrg: intel.com

Huang Ying wrote:
> According to the description of the "Window Restrictions" field of
> "CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
> Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
> formerly known as "CXL Type 2 Memory" and renamed to "Device
> Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
> and renamed to "Host-only Coherent".  Because type 3 memory can only
> be host-only coherent before, while it can be host-only coherent or
> device coherent with "Back-Invalidate" now.
> 
> To avoid confusion about type 2/3 memory and device/host-only coherent
> in Linux kernel, the patch renames corresponding bit definition from
> ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
> ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM.  This makes the kernel
> code consistent with the spec too.
> 
> The patch also renames the corresponding cxl_decoder flags
> CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVMEM/HOSTONLYMEM.
> 
> No functionality change is expected.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
