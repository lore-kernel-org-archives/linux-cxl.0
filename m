Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8233F586
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070385; cv=fail; b=j9LXLOMmR5oUq+Q8Re4iJGLBLsmo+B3THNJWiyay3lywtWamAk8KOYaaIZiVwoQ+LanAkQ9sk2WKfhLnsuE6BxzAYJBEU0U2IdTXeu3qxB0I+GCmmcbo8LB7AtVgJG4R/yXWklga9yFGeD0/cREBIg119xL+WJUUiuO6AQY7Eoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070385; c=relaxed/simple;
	bh=KXNb6Ik7R1v1o62mq+5JyQ5F6G3YpXFv5Zfjz3qM4P4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VkrZXRagjHtVCw36e0zRkbH71Dkj4GSTc6O8LGxJxyBya7iXqKA2mLGaVpNOvdWAwgZP6dXL2JHunLIu7ObHvS4lsE3kEIOffDP8sw4mNUxslX9uPCVd1qxrPU3nNg/qScW8CP77N+X+3QxL5l2f+iXvGJkrWbCJh4AevTN6v90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMcdpnfc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMcdpnfc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775070384; x=1806606384;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KXNb6Ik7R1v1o62mq+5JyQ5F6G3YpXFv5Zfjz3qM4P4=;
  b=eMcdpnfchR+DySpiEDojLSEMUy0/RIv4n6Cn5dWJwSt//r6sYbfm3F0P
   y8E2JIVzDrD7rUS/z0R8hMrV5EzDskORQ4IQ/5aBRTGfheBo1JeNLfeyW
   Zmw79JdoFrNs3TiIPDyncvKzbNzQSEVqgXFfmTAYufbMu3qdws7TTFHFv
   pbHcFGLSNlXmnsKQTdxiZJh9X9HEl8j1WjCJHqkmxNeBzz/fTrantpwae
   rEFqZkGvFu9SSuVyIhflv4YnPLnLBnHWD2pPiLnqh2rMcKYS1uYPVhyz/
   4E7twDlI+Ujma6bKjh0cUku88x8xSsAdth1wk0FFTHPbI/0t8VGfGiQxX
   Q==;
X-CSE-ConnectionGUID: BbqfXbpzSO2fHMZt62hjJg==
X-CSE-MsgGUID: jR3JLIBMSqSqfWZ63nMoVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76005846"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76005846"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 12:06:23 -0700
X-CSE-ConnectionGUID: 8dOlNfG+TGaDpKXgmHKIHw==
X-CSE-MsgGUID: jzAmAYl9Rh6Qc+nkMevYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223460489"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 12:06:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 12:06:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 12:06:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 12:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNgRPDeSrlbPQAIuHyarLXGYJyg6meGGRYdgRqUZLbyNRLIhpDzPw4cSQ/6hP7xQJE+m241679e4DnqkYjeE85hVHbqNwUFk1MCRrUlyU3KNORMgfbkewMBlzpsaSO0h7gkxaqYUbn09rU5ZgPAs+OfIpH+FyII9gKpbyoarQHSzlvpyAc6W82erv2+c2XsSJGgGE5eBq4p+DwwNr+BFicA6NZePcYd/sD/J29b4aNQVCn6/PouhHWqK1hQRtkVfPOhmudLc1937bpN7NB/UoXDZrl25Hd8WCe5obelLnaihhAghSZR+WPHlgzSOpw7hmCe/d3hIqyJgvbUWu+JqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUjd5YPCOw/FUZRQfAwtIZws4td3hmOz3plDDXRZapQ=;
 b=I6YHl0FZSeNEdVzwd+IEM3vxv6C+IRkTEUdJpLYRf3+7X16smxHfppPF+OsI9+wVWooOhHFz6U2XEEerYLDQr7airz/VC3FNfCErokEYTmuUy0JSIAX45E0frRILCq8yi2aYBmogcpTuFX9eUumbDL1bIbvAaxVKxsp8tzrlsOdWwMrkHrxvQKZIxKvnxFI8A0F7S8ZOB4ynhxkX5jhoBnpE8rXFnK1s3e7OcUz0zHPryPLfV8sngHyGeWjRgGrIeVrIDCa+HaexHy5HfAfkzggBn7RxHYHyBBpaTJlAZbxzwyeKUfSNLA6mkgLxRiGTkvEhv0j/Tr7Q+WWxBe/lBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 19:06:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 19:06:11 +0000
Date: Wed, 1 Apr 2026 12:06:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v2 1/1] ndctl/cxl: Show region locked status to user
Message-ID: <ac1snnLIKRO7EzkM@aschofie-mobl2.lan>
References: <20260401124205.1288996-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260401124205.1288996-1-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: b311439f-50ff-4c8e-70cc-08de9021bcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1UfGelv/h5TkaiRgKZaIeSGg2q5AZ0h5lDaZQO89WidXHfDcv8pep31EfMx/HdCfQkGqnCCoexTwhTHLSlmYyIvzXHdWIlJAMzP2VJ+M3o4aJIDWpA8t/JDca8IdC4GnjvDHEKqnuVhyBL4i3e1AuKpgDaV0Mli+9jmR2XIAy/HeXbJ05KEjyZS+1cbRNqOYca4DWSnVSPrZDh0o2bFiBVWipDCgQ5kvVmXlTOii2dUUMwr6MR1y/3Q55O2MfdLBVLrcnGd0R09e2/l3dmFydMejJ/kyf0nr2HwPkUX65w5M+5weWITBxGyEZN/IIhzzDeq1u/1+rv6qLT3FuSpeZNkqYNdgl3WuPxZDvqhL3ry7u36i7vvCalmIEzop9+LLrWmxE4YhDC5q+lUCvogwRCzM9B5Mi4KnsrtYCfO2yLTDSqezYDgmyVUEvN7SdPOA73vpFI/ogEeJJPeJtVFx1dnfd9HkGO/NazEvBfdiqDp/BEO+Y5wk3fPw2vVUGvJLUFpV8nhsgSRqGELCWYtewxPeaKk+imiif3pNCOMFvw5fhwm2jjjC99ePm4w6FJcFRSN/wQGQkIuWhDRCPfpNJ9AyWER+jolnk//AdClJ31PU9SEdKGWdUfiWW4SbbsgV5h9W4/y6otI37K8jbDUYa7+y3GPDjvCbqs++nT45+pgwVnxH9eXPeaEu4kBm4JJySmnIN68jYznmKsMxkrZJQb0pa5L5am6DdV4wBZxlX5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/elP0gUrlv1nBXLfhS0ZbekEVZS9L2o70FpiG+HdvSf6S0OKY77vCZnOVXXe?=
 =?us-ascii?Q?sf6e1nJPGqyNe8JN6ZK0d9B8gCyUyClUVS/IkCqxn9b3vIqaIo9Rm+FlczUg?=
 =?us-ascii?Q?34r2lLg2/FCC1jrmAp9jLKf8Dzmw0BppyBctIHWEguae7jQBv1j0b58l9quD?=
 =?us-ascii?Q?cYV3CybaTftzWRFkcDbgeDJGCmQ8l9xkWV7wb4iYlFtHLZ7+BSoGG5HIYXSO?=
 =?us-ascii?Q?DWsXJmY2Xu1YK84GTkujBg19YLlExcSKYJuU06mrb/GRuuBLq0UY1NgDyYgk?=
 =?us-ascii?Q?QFwHGQgl6UUf2txaWYVK1uIuW8VIp+EKKL+GBNVwCyTVAQQF0CXrf7e0lBvZ?=
 =?us-ascii?Q?r4qfjdLuJOeLhfOVWOZ2T3MAlcoG7/cw6OA5zKcU/gk+ffShSI+mL7Z9Tnh9?=
 =?us-ascii?Q?h5DRKke3KVh7mmWR4GhP+KJyZ9M3foTunDvdR4XpNbfwriRgVXQzlby5r4/H?=
 =?us-ascii?Q?eFREk2lSa/QbehysSO/aYXIYs2SN/S8Soc/iAPhHBxa5dm3IN96qRiFUFw1Z?=
 =?us-ascii?Q?WpqmI4hnkqWp+TVSffPQgmqRlALGf88cr17aI6qixxHcCQfh3R8Wf75c/YQI?=
 =?us-ascii?Q?Q0eXyDxMgwqF5O+CJ9yiG67BmsZzBK2uiFCTZ26mqJCw1AQlLY0IHuam9/9s?=
 =?us-ascii?Q?pRWT2QpmZjqmO/mCmuMPN2I4K2E7oDFVALtkeC7fuCaFh8X2q5XYE1jK2/9t?=
 =?us-ascii?Q?jMEg+F66H+xpp6X+OjZr5OrPlqOMYnS9TsSHL0HdsgEdO0o6AcweV7NOhtoq?=
 =?us-ascii?Q?o8HZGxiRmyjWXNfMmYuBoSJw4c264F7QPhtW6BjeqmyaxJKGJhS574TorjVG?=
 =?us-ascii?Q?x93TS4rRWuNeI/qtE7Rcvu6p6fMvK2Ix0RSl9QRfVYuQyQrYRMWDjOIU3mcd?=
 =?us-ascii?Q?xmsXM6kcDnB40py4x5ifQCJP4Xafegk/JaQq2LA8KExwbTQOAi/8HGImRZbs?=
 =?us-ascii?Q?ublHbdNqe11PzhB/PO6dMiwyB3kmXCXyFQUpfnvN/OHS7LQFZMFA+OG4lIbV?=
 =?us-ascii?Q?YCHf40E59j0eR6gNMfLkyanxHtmJNvohqSeujnJKd1ifpWTaE1ufZgL4k5Wq?=
 =?us-ascii?Q?W5bx9affmyIgZfTjSYNko1Y9nIRTEeTYMIPGQ+f5Oo/bz2PV3ic+IyYLQhS3?=
 =?us-ascii?Q?HD4pN6k1X/cJtNJT4iD7nLy8hMt+cEnjxUVGjXeK2qejUwe9C8hi1UXwWatP?=
 =?us-ascii?Q?43Qpzh8iTw3eHcd/kCT6xVyQ85MJdN10Gt9Q6xc0NuBrmBzGdhvV6uy7S+IB?=
 =?us-ascii?Q?3mn7MYtY5JupjZqTMNNy4K/Mc58oCizQWt2L7mHFKzNuuTAAFOY4jCUVJ+FC?=
 =?us-ascii?Q?o+XXe6VxJLBkClA4lUZsSbozTl66PWVax5w1lHYs1Xfl2sjRxebc6KxU/Bp6?=
 =?us-ascii?Q?h7oGSzDW2ik/BJ5Zx6/owQc5w3iEuQ9y9NQjYXkO7xYYLom5IjVOOqvUje8D?=
 =?us-ascii?Q?/5vS17TO6fDUUfHD4/qc039Vqg+WyllLPu4B0jH4MdFW2oYx4KqKI2iXXuEz?=
 =?us-ascii?Q?e0+Qv/kNt/a2ou+GDAS3lQbWmVNQh9PtJYMajdK39ppMIpthE7OdAfRiwcWH?=
 =?us-ascii?Q?q8kEnuUz6UcNv9OywS0Gf+rZRzJgfBJp0ba5m8xhA4KlVdHkLBfVZUzqwqcB?=
 =?us-ascii?Q?P6HT65A15FcWKQXw4ADD6T6HTNpaubhUYnpIKtzKQjKgt9DwCvr9uBvhtV/5?=
 =?us-ascii?Q?zWsTePMij/vAVr+ORPbpN8BeJ5R9KfGG+ZrNrWA225wKJJ20JemPdEerI3Yc?=
 =?us-ascii?Q?xl1h2p8nPw+rD6LVIcJ+uOBx9H39qO0=3D?=
X-Exchange-RoutingPolicyChecked: goxkLInaU68+03udkjD33No0eNnmz8NeuYcIEPBODp38Gx3MzBGyOsQJVhcExCqeGKHYimaExIChQcu76+i5oiH4aYG1s8MUQZytqHhuX86ebCMH2F7Yy0Iao18DThGfBen+0XL7uO5rfdYN4Ma/HmR3N7rPj98uwXBhDFW4Wx9IkHlef0m6ge/Ppz3EspuPFLYY232LYjJbKH3/xUM2T4eSGSlWNLaJlpRcqxR3SyUhfCfGLPsTk2yVBCL20SU5Y33jkRJwCz2hsp1/7LWQpO9IzyJyh++ct5/iVeJKEWQqUv+POu1XwlM3W8ureN/kynVFxiX12PVtTpfPmbxCIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b311439f-50ff-4c8e-70cc-08de9021bcd6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 19:06:11.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjpnn7SJmeohv+xH7LFm+uTT87mmPeHHPhCxVROMhcWTvA4U9rOVRUP39tUMK7EFxBa+Rtg0ahrTNxr5ybhH+8Gq5p0AU9wFidf1r/UQIV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com

On Wed, Apr 01, 2026 at 08:42:05PM +0800, Li Ming wrote:
> A region is not allowed to be destroyed if it is in locked status.
> cxl destroy-region command will fail and ask user to try it again as
> root, but it is not the real reason and it will confuse user if user is
> already a root user. This patch will show the region locked status in
> region information and output an explicit log to user that operation is
> not permitted like below.
> 
> Before the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> libcxl: write_attr: failed to write 0
>  to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
> cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions
> 
> After the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "locked":true,
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> cxl region: destroy_region: region0: Cannot destroy a locked region.
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions

Sorry Ming, I missed previously-

This always emits "locked":false on kernels without the new sysfs
attribute. Please make it skip the emit in that case.


> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> v2:
> * Move lock status checking to the beginning of destroy_region().
>   (Alison)
> ---
>  cxl/json.c         |  4 ++++
>  cxl/lib/libcxl.c   | 11 +++++++++++
>  cxl/lib/libcxl.sym |  5 +++++
>  cxl/lib/private.h  |  1 +
>  cxl/libcxl.h       |  1 +
>  cxl/region.c       |  6 ++++++
>  6 files changed, 28 insertions(+)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index a0dc343..3bbe07a 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -1077,6 +1077,10 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
>  			json_object_object_add(jregion, "state", jobj);
>  	}
>  
> +	jobj = json_object_new_boolean(cxl_region_is_locked(region));
> +	if (jobj)
> +		json_object_object_add(jregion, "locked", jobj);
> +
>  	if (flags & UTIL_JSON_MEDIA_ERRORS) {
>  		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
>  		if (jobj)
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 5e8deb6..ce2b364 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
>  	return is_enabled(path);
>  }
>  
> +CXL_EXPORT bool cxl_region_is_locked(struct cxl_region *region)
> +{
> +	return region->locked;
> +}
> +
>  CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
>  {
>  	struct cxl_decoder *root_decoder = cxl_region_get_decoder(region);
> @@ -689,6 +694,12 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>  		region->module = util_modalias_to_module(ctx, buf);
>  
> +	sprintf(path, "%s/locked", cxlregion_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		region->locked = false;
> +	else
> +		region->locked = strtoul(buf, NULL, 0);
> +
>  	cxl_region_foreach_safe(decoder, region_dup, _r)
>  		if (region_dup->id == region->id) {
>  			list_del_from(&decoder->regions, &region_dup->list);
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 797e398..7c586f4 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -315,3 +315,8 @@ global:
>  	cxl_memdev_clear_poison;
>  	cxl_debugfs_exists;
>  } LIBCXL_10;
> +
> +LIBCXL_12 {
> +global:
> +	cxl_region_is_locked;
> +} LIBCXL_11;
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index 582eebf..d074122 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -189,6 +189,7 @@ struct cxl_region {
>  	u64 start;
>  	u64 size;
>  	u64 cache_size;
> +	bool locked;
>  	unsigned int interleave_ways;
>  	unsigned int interleave_granularity;
>  	enum cxl_decode_state decode_state;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index a853ab6..6ff58de 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -353,6 +353,7 @@ int cxl_region_clear_all_targets(struct cxl_region *region);
>  int cxl_region_decode_commit(struct cxl_region *region);
>  int cxl_region_decode_reset(struct cxl_region *region);
>  bool cxl_region_qos_class_mismatch(struct cxl_region *region);
> +bool cxl_region_is_locked(struct cxl_region *region);
>  
>  #define cxl_region_foreach(decoder, region)                                    \
>  	for (region = cxl_region_get_first(decoder); region != NULL;           \
> diff --git a/cxl/region.c b/cxl/region.c
> index 207cf2d..8a85522 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -837,6 +837,12 @@ static int destroy_region(struct cxl_region *region)
>  	unsigned int ways, i;
>  	int rc;
>  
> +	if (cxl_region_is_locked(region)) {
> +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
> +			devname);
> +		return -EPERM;
> +	}
> +
>  	/* First, unbind/disable the region if needed */
>  	if (cxl_region_is_enabled(region)) {
>  		if (param.force) {
> -- 
> 2.43.0
> 
