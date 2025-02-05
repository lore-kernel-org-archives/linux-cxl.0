Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332A20DD49
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738720266; cv=fail; b=GQNnJXuELB6R+9X/W8xyroacYdE8MxYAVsGk1G1Zg7w8gubSGz3H+HKe0Z1Kcuwkpt9b5kebsWG3kZXpMvx58ffNqWgiEyR+zCaIrVCmInP9r8AR2TA8wPoqQ/BXwhu6zYJSibSGIo2P8hyS8xRvRACcKCDAFzhHzNUGnXEh0OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738720266; c=relaxed/simple;
	bh=JP91ZsPmloHFcufIIQvB1YHUVKYvMauHvn7gPFtkswY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1N/DuqkQxsBA9fWq30InEbgi+n3szGn4cwolaj4TvLkMHIFOsMwKHtnxG2pyArlgLyEXinqwMZjOaM1N3JL+xxIGV1APulasTRjRDBk7yLLCAT7EaLm9kd8adDLTDTxyzNNnQUXg6MQxU69989Tdc0DYu6iqia6SYUKNtfKrZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HV4oWu/S; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV4oWu/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738720263; x=1770256263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JP91ZsPmloHFcufIIQvB1YHUVKYvMauHvn7gPFtkswY=;
  b=HV4oWu/SBP7tUrb5ScXaupBY/+ESmym/MGvGj2OQoW3prS2+dDUxOMd4
   mj7qvy+M30z4gTzEbnXzg6evEjffA9ZTGEFMCX3CHbxVTDckZ/DxQrZ+X
   xBYb5rfhKGwDT8Jz3fSX3+URDs6IiLezHrcWguu7aluEAQBGT9TJXoCcp
   scStjJoMsAljGpr3LqTeLXW7KZgErTDFFO7Cbm49Soo6PoNQoEwip76cz
   +R2wdAKMTwNhLuMdbWdgk8UyMezfUW0kasoPyX+Nh7un/RF79mFyALaGd
   wQZfNIembi7BMp3ARKKKbHuO37xvWYJ1tRvZI2YTylOS1AQzAZVW50wek
   Q==;
X-CSE-ConnectionGUID: TIJehsExTNmbU/YPLrILZA==
X-CSE-MsgGUID: xdHdNHo7TCeNijY7E9dp6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56698650"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="56698650"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 17:51:02 -0800
X-CSE-ConnectionGUID: rcJW/KdLTB+BalHKJ7+FAw==
X-CSE-MsgGUID: FTVJX2HTRyKsswTY8gJH8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110653847"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 17:51:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 17:51:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 17:51:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 17:50:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyU1xfuYCMe2Qs0i9tlZYszNiERCuzdfsGh8M9RyY/0L/vJFWpsKG47oVazZ/5lfwlH0vwRtaxH456DiYXZ4A6bO+Mc7K6q51vSZoccHAtc7d3tDDz1nhGFOWT3A2uE715Klx3RKgTb03DuyulGe/DQ6AcCaqNvL+6oYsBrSW2VQ3PHgPf1x1DTFqVgeeJZeRCpNtFPPr6w6jC5AMlPqlFkt0E1+1Oeup8IRCiGUdOAdDzXXFriFCEen04Sr0gYv6XCxZ+0uS0Ha1nByqHlIUm5qfpDuLuD52oKQp5p/ZoIkmqbUTdXslBDsDl3jqwIJiP7s0pFG7bCLwGHdyr4fBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpOoFDn5GSAQVb8w0qvN1Z1LEvBoreFxSbgAK7wt4LA=;
 b=Jge0WXyUOv+XYStbkTO2DRkV/YZ66YNYcM26pEDGpZItehsJPTeOhKYQfNyXHXhtvSUQ5qQL3eqNX/9+GBZ3Q4oEJiKssfPtR8OG9jvbvHwS7Hpy9P+xA0Hz6nsgMTiPuCVT1PKVuc9XB8dSkRx18j5q30Ca7J9d1+z8l86L2MtVQKc3aznX0cxnvYM4b7LLgevte0H0ZD/HokkZjHcsfdMkoLJPyNEJQdnuJGghUgx1RNszlTzna4owmSCOvFUyTAq/vrSWi1T2QxTxqABm/TTxy+qysHre78YFneOD4Bo6tn+bxb1fJ3zWRT1df839iiuSPFa5MfFuzGX79MbJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 01:50:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 01:50:16 +0000
Date: Tue, 4 Feb 2025 17:50:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 16/16] fwctl/cxl: Add documentation to FWCTL CXL
Message-ID: <67a2c3d64966b_2d2c2942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-17-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-17-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: c37e045e-c4d9-48d5-742d-08dd45877061
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rEHl64srfhq+9ihygYBMZ7nYJnjIONU1NWgPIVT2yRp3r3zGpNbDOjRQOrTx?=
 =?us-ascii?Q?pP1UlLIJW0uQga+Tgqbe3OBYn3GahlaDkbL/kOh8zjVM2G/AOh++5G7k62w0?=
 =?us-ascii?Q?ef98V5gvmCRnJjYrB+3WxFMkhhF4taGMWiJlJOEEPrj0jpQ6SLSAlDJvzXZJ?=
 =?us-ascii?Q?dglkk+SftgFsGasE+gS2thAS0n19XOFpH1LNTYSk48EBEPsFEwGWQTKEq2G+?=
 =?us-ascii?Q?5rUP1OKnZaSizUL3qX6kq7nLcoFMXzMX5uDEFaenEKNQSLngQMz+z5yyXR0O?=
 =?us-ascii?Q?ClaUFpv0qUljeh7Jfyl7M4JYTKCV47XMNYvdne0dASRc6xwXd8OLQn5BSSOM?=
 =?us-ascii?Q?QtYkiTWIcfMAiRi4BB4zOn+qDX7ijnf1FkBDXV7vRR8BpRj754f7b7YhAyvd?=
 =?us-ascii?Q?/UspY0fbWYyn9tSZlsUks2zEl/BmeIxAfkGVLudkxvpcEN5QfFg12KiW5+h+?=
 =?us-ascii?Q?3dU81u9OARuTUUxMFDZeSwTiR6LP4/1TTRJDxopGAxaJQ68zncrfQVU0Je2T?=
 =?us-ascii?Q?4MWx8FBAXA+6dlsRplB0Hydk7/ivlH+g/9EumBGcWwG92lO543aeS/6So4mj?=
 =?us-ascii?Q?C8C9E0s2KfvX3DchAFgLCoCNpnwN4yICZ9Ihfql6yZ9LwgH8nVmMskc+svxg?=
 =?us-ascii?Q?R+oBUMrIVK3Rpoa93PHDJpmF9PAPI7w90Cn7WxVp8D3FiowHcdAnOhTzJ58i?=
 =?us-ascii?Q?fVZcQaPk3ISWirsnj2I0Hy+52/kWRVbmwtvJc59MI2CM2Mi3lRXkoJWMStjF?=
 =?us-ascii?Q?P2RdqdeTYOSw5IXod0hIEBaDOMasVCuZ73fwk9KSaqDwENnqv7lLg9ijSf69?=
 =?us-ascii?Q?KKytU+x3G3jaFUjRINJmo/BKKfx8y+8YW4nbKCWEmY8+qpeCHjnvqBjK+Um4?=
 =?us-ascii?Q?fW8lYwlo9PQ/tU4Vr3+e0TSu1g9b0CRrbg66vo9ilTw2jCdyxar+9vJ7LHgA?=
 =?us-ascii?Q?n487cIbWvtK0IbZxd0iPmdal46YU1RNNaF8yzISxHMlh8c2sA4cNjXsmKxnl?=
 =?us-ascii?Q?PMrNkJY8yoxPKZd6zgqD/dcVKQYuBsm+Kt0z9haY49auCPfz/cTTPBL7BglY?=
 =?us-ascii?Q?UK1j/yI5ht/ssIcAz2x6wz4lZ64neMhd9CuGxHaiXOb6W2c6/dAApcb1AAFC?=
 =?us-ascii?Q?bilzkx40vKZM1JPzn+UqU5RYZcxzJi4/cF+TBgqSd0YhKWYLSd/EHdBdyPc1?=
 =?us-ascii?Q?UWjK8bm+xQzZCagE+xsKpk7rBhCeafgi5Eq/RQFeylp25DV2uHb1zykBYFpf?=
 =?us-ascii?Q?6C7FmhhzJe7vn0iy2ePtO9xan05mbXpMAaV5DLL6+JBcjieSm8EhwCnbte5E?=
 =?us-ascii?Q?QcBtisFc5xL/KYknLcMzRE8bQh5I6mwsu5lZyXuVtmVYocejR+xqJSDdJOiB?=
 =?us-ascii?Q?muBAEoqWzN4m5ngx2lcRUwjKIf6a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cApqYyX2QrUarnfw1n4d2dgXZGRkaKE4I/541RSUbo62O78rVBxisF40vrVy?=
 =?us-ascii?Q?SL0QD+twB8uVFm5WrKxIgBLpTjo8978eIPAKAVek0EIPi4fZs/HZJCCKlNnj?=
 =?us-ascii?Q?fPgwE+H+gQsVLT0W14HBYZetjh13A5xeZjnuAnuM33B8JYjzM0ULOYBNWgg4?=
 =?us-ascii?Q?sfJndW+a61dVPJaSpqa4Vfc8DQRRGBSCnivQpiAKmg9SIOFX01RJVv23O25T?=
 =?us-ascii?Q?0OA07otO8BVNIatTBhfrYO6cGV63328sGSA5gQvNgGFzFR34HRku7oO3cWcH?=
 =?us-ascii?Q?i7/dPyn79bfgsnzcCdhITGT6J7NxBjpV4dyWACRC/wWygD3BN/YmVHk01G2g?=
 =?us-ascii?Q?okyxUr6ScIOoEHp0k7fcYIzJz3v1a1YilkHdSGzsGuQRwzSuuLNEvWK/OwDO?=
 =?us-ascii?Q?hrQXkvbEs5pgSiikOehx1mF7MI1kML15GVsxF27ByRiaASS3WS7nfreoV/rO?=
 =?us-ascii?Q?n+1DVavmEkbWthxBnl6/FFqKEluEyznAvDpliD92KUojf8nm9zY3pHnbyA+F?=
 =?us-ascii?Q?Uo12IB6NgQefRf83hSrFZbQUP+5X3o8+HipZ0PAWAbWrxgChlf3pkJBywzw8?=
 =?us-ascii?Q?d13O+RasUXILCL4G69lxAt2QLmX7vlUJt6S4v1GbVhNhg/7YOQpTqOH/SXaI?=
 =?us-ascii?Q?0CJNZZfb1w5ti2ZSOrpSwyYbl6zpg8HI6xg03qeLy8Vhv+AmRpc3a3GL/38r?=
 =?us-ascii?Q?XetqCbIGDLVdB1nbfDrnqi3BjPhQtKij2SV9zVGSourVGv3b6fD85n5jxDQg?=
 =?us-ascii?Q?WUjnm8IPIOFmWYfaVwUiRcksRW80CRloa6dPRFYtaYfJMhu2rH06kEzAOfJ/?=
 =?us-ascii?Q?ADWjH3zBt9E6u0mQNZgfj/Juc++ANlL6IWFOjf8ZMp1LwC+EVIl6hgcjQmae?=
 =?us-ascii?Q?uu1MvqnTe7a/yMls7S3r+4r6auiZHKLoZkZ+kn4dfpGllvnB07NoFV679Fip?=
 =?us-ascii?Q?Q4UraW+tqrcGz+c5y1GY8C6eQFPfRYbXv08F7QCIA7CZ0x1mzmvGLsZkQ1Yd?=
 =?us-ascii?Q?YCTgvkRj5YEr/EY6jJXAGtOLVBUvxhYmfbYx1r2CrXp8peffMSSG67YUWPrx?=
 =?us-ascii?Q?TNfaQvY7axZoMStLB7jx7igeBW+f0TzzbNRg0kgl+d/luARWEUrR4PX8m46S?=
 =?us-ascii?Q?or9gj3ZdEk17HZ8POYtERaKsRKn2pPldwLDXaMONt0YARmVc9tW+mgLg3z+4?=
 =?us-ascii?Q?IgVPOD5++WFGR9Dh2ZxpaNaDT0zA3A//GlhUl2ZLI6CSURdjFn/QEcweVKkv?=
 =?us-ascii?Q?NGrKQneZTauWvcquffL+oikn9d/3qNtg8un4OyhAGRieZhuKFpWkvXuQA+SK?=
 =?us-ascii?Q?LAGkxb4fNv9kmcm0X5U6rj2vibjvOjXAE6je6IURVWJBRFvWGt87sornXtsQ?=
 =?us-ascii?Q?c2SNArwvz3UsV+T6sGRpEX+gCMwSSThycL44taNDxvvCYCZRo/9NALjBiobe?=
 =?us-ascii?Q?UM2kbAs8VV/BDVxStrpXxsTTgaAZcF+0C8xaJPtm7kSYjq8tovv8iPWL/pHX?=
 =?us-ascii?Q?GqdWs+HdJWQ4TAu0RpyplF8RaQzPCXIsG29YFay6tY06qA3emJgtuYlHY2yU?=
 =?us-ascii?Q?GCE2LdTb+g5elbaeFmj0JPLJB2Z8Z3bNe4yOSqU/wxwLAr/lpFTEOQCOLdvh?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c37e045e-c4d9-48d5-742d-08dd45877061
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:50:16.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObjE4o27rfm4H+/P24i0vXrWO8KH8z2eB5808omoOahAj61DtlroJB2XcpuSOJp+n3QgMcRsLSeOpGuBgcOMwbo3Hmh+iD37Fak1N4BxVG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add policy and operational documentation for FWCTL CXL.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Add a sentence on how entries are filtered. (Jonathan)
> ---
>  .../userspace-api/fwctl/fwctl-cxl.rst         | 137 ++++++++++++++++++
>  Documentation/userspace-api/fwctl/index.rst   |   1 +
>  MAINTAINERS                                   |   1 +
>  3 files changed, 139 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> new file mode 100644
> index 000000000000..81c694f6a44d
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> @@ -0,0 +1,137 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fwctl cxl driver
> +================
> +
> +:Author: Dave Jiang
[..]

Thanks for the verb tense changes!

> +
> +Code example of a Get Feature
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: c

Nice, thanks for the example, it finally allows me to put a finger on a
naming nit below...

> +
> +        static int cxl_fwctl_rpc_get_test_feature(int fd, struct test_feature *feat_ctx,
> +                                                  const uint32_t expected_data)
> +        {
> +                struct cxl_mbox_get_feat_in feat_in __attribute__((aligned(16))) = {0};
> +                struct fwctl_rpc_cxl in __attribute__((aligned(16))) = {0};
> +                struct fwctl_rpc_cxl_out *out;
> +                struct fwctl_rpc rpc = {0};
> +                size_t out_size;
> +                uint32_t val;
> +                void *data;
> +                int rc;
> +
> +                uuid_copy(feat_in.uuid, feat_ctx->uuid);
> +                feat_in.count = feat_ctx->get_size;
> +
> +                out_size = sizeof(*out) + feat_in.count;
> +                out = aligned_alloc(16, out_size);
> +                if (!out)
> +                        return -ENOMEM;
> +
> +                memset(out, 0, out_size);
> +                data = out->payload;
> +
> +                in.command_id = CXL_FEATURE_ID_GET_FEATURE;

So this should probably be CXL_FWCTL_GET_FEATURE, right? There's no such
thing as a feature command id to userspace only FWCTL command ids that
translate to one of Get Suppported, Get, and Set Feature(s), and the
"id" is implied.

> +                in.op_size = sizeof(feat_in);
> +                in.in_payload = (uint64_t)(uint64_t *)&feat_in;
> +
> +                rpc.size = sizeof(rpc);
> +                rpc.scope = FWCTL_RPC_CONFIGURATION;
> +                rpc.in_len = sizeof(in);
> +                rpc.out_len = out_size;
> +                rpc.in = (uint64_t)(uint64_t *)&in;
> +                rpc.out = (uint64_t)(uint64_t *)out;
> +
> +                rc = send_command(fd, &rpc, out);
> +                if (rc)
> +                        goto out;
> +
> +                val = le32toh(*(__le32 *)data);
> +                if (memcmp(&val, &expected_data, sizeof(val)) != 0) {
> +                        rc = -ENXIO;
> +                        goto out;
> +                }
> +
> +        out:
> +                free(out);
> +                return rc;
> +        }
> +
> +It is recommended to take a look at CXL CLI test directory

Passive -> imperative:

s/It is recommended to take/Take/

Other than that, this looks good!
