Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105919BBC
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737604792; cv=fail; b=tQoqillDUeRDCcfz1Mwq8dyqSNrMhtOyeYIhQgJqvEZnLA5EiX965KrlvcTxy/7AR+s4CMMAdB09tqvJBG/xAWpWTqt4/vcbm5lzjfBwIBO+a7tOjlFuS/fLUv9g9Nzzdk5ucYq4kXLzM2b+G8bOHcqCX46CBsWP6qfyc47O6ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737604792; c=relaxed/simple;
	bh=fkxF0WpgNp9qbgiqmJfl7kKzWj7IDs2j6bCXz+TNuEQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Meu1vIUg5HqwHhqEVRZUQlW0Hm9TGM29BJv9ncAQB0h5luwsz4McLz8Qsuog46gsBauBAa0E7z8MTg5pKnOVR0j0Za9R8aT4yYCMk/zaHk1+3UM0Y+FNu41OSkFs4KBWUAueG7jS5AL+tzJlBwgMAOircFHYQqsELonkL9myInA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1WRcXWK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1WRcXWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737604791; x=1769140791;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fkxF0WpgNp9qbgiqmJfl7kKzWj7IDs2j6bCXz+TNuEQ=;
  b=k1WRcXWKlZSti07Qz0fIRt+gn+S/ZsZ1Y59XFTXpoznv1vM0mLvjw5Ss
   D2d+HWjcw88aurTPIKTxlYe0rlv0KMo4ZwSv4+ANboWrrVNmdskgidAr7
   ZDnv+7tWdONZRt8GlMu+2AjwK72/XxELi9uDyLq56MMe/t1AF8N0UL0Gv
   g4D6cjkkatnQltaQ68DMS1q9ZWes8KqPjs3fdi4WLfwFImbJnySQdlYkj
   13cvxukRoEX15+hBqXwzJinMqCmXc41DT8eB7NQpAFQVH20RICV6kdgLt
   /hBUs8Vl6LmVAo5Ke8hnwwk4ZYj04vmjWr9CMwLB5mzOcMhS7k55BUvPO
   w==;
X-CSE-ConnectionGUID: Jx0B5SsqQPuxIhSj84+cQw==
X-CSE-MsgGUID: hcS4cX+5SBqRCwMB0mZE8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37970119"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37970119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 19:59:50 -0800
X-CSE-ConnectionGUID: TAHTAIXTR7ybGRnjKD6OPA==
X-CSE-MsgGUID: t6H0kF2PRNKRGNXDjGbp6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107197824"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 19:59:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 19:59:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 19:59:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 19:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2KOYTswfzUxpENZtq5hnfJoR/olo0AU0qOlOPaaayQSALfCBbB5+gRLZjCwzExY1DcOVbzZWZqhPUn/sMbtzeoggmvj6MIckJAln2kYNPlLGkw8Ez3aQ+ZkzCmczcr6k+qySEf1AuWO6JNICIcGAyBEp1JJU38i0g8EjRWm5Ny2IUattURMd13tVuLRzjy1Saqv0S49oA1u7YLebs3yGZqV8GSp/gzL2YSMy6Ojq0KdWqW12EcYgOLfA9JEXc1mU4HH6Lpwtvplv1AkNTCW7/MPQ6Fa8vj/z/HbWdPoXcZKDDNUiiC8btvmhz4v1qB2FB1LxAFAVHr9ziDlaYZyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNpqLpPSJ1DWxQiETV+OgaZrVx5RTQPn5PleVnpjFos=;
 b=rTS3WyVkMs4SJnAos+/KmuJqVkNR235pR1JE2yT0iEwFZIC2cetjBgw7GaxJ2WzvqfjCA6PZ8MxKkIYHHFdFYRoiKSaRDz6FA4ZOCK5MZ01a1z1RkREz4ljUnpTpYUKAHaIdsanlo65DkaBnckPyx1yMRUdx+8bcAKCIPXpiYkv7tZKPNIWoF2tjkHZmQCiTcBOzEZoDTXW1XYMofsyJehp9CwlvU2yB6fVsFIGsXMltL/+e//Q5VbannaqPI8SH6SqWMDI/5IcFQTxU/qYGEPTtY0Tjv2mIKfS8cIU+mW12kZn+Pr5y6eku+zcihgO0FdGIdc0R+RzWduhT512x5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB8853.namprd11.prod.outlook.com (2603:10b6:8:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 03:59:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:59:19 +0000
Date: Wed, 22 Jan 2025 19:59:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 02/19] cxl: Add skeletal features driver
Message-ID: <6791be94971b2_9b92294d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da0e77f-edd1-49c8-c0b7-08dd3b624fe3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+oYrbT3W69Fjyw5PBBuzxxK5HMVyGaT4mEaJHxhjwoQjFLuYewsTwhm97ji+?=
 =?us-ascii?Q?ba5duOJJvn1N9eLD5sadPISl6cvr6FnP09sYsj3ApoN0M9Bq4MkbkJbxRstl?=
 =?us-ascii?Q?Ae4SPyV/VaZZ1rFhz/cl9+h8PRz0pi/WTp9Q9wXDG39UdTtAbEs7TysvBnCq?=
 =?us-ascii?Q?WXfzRBucKkCuqL4Td2bgmDLspJ12T7h2/7ysopoWntGCZTuWNrUsMVjWyPJP?=
 =?us-ascii?Q?wDdG1Xha9h7SK+rxmmeQHu76o/4hydk8qvWRP+Ywb8tPOdz97Ez26jNme078?=
 =?us-ascii?Q?9pdXm7jGyE2jHNxfvD179uQrmsT5ZSyUXrWjiQ6/wY8MqRYHMsLXbTowIunB?=
 =?us-ascii?Q?zECb8Jb2g+Xm4RmBgdJczV4AK6wY3kU1WIrM/GORkI8OH5mYWh1H5HqAjlEp?=
 =?us-ascii?Q?8JuktOLK3pb6UbH340nZzIDNE2jjyxTNNT6E9Tnm/5Da6GWGCep/o12hfuLg?=
 =?us-ascii?Q?cUyus2jZYuBqTVBKIOiSbEtdbDN6u23gfRRkx574foKkMhw+DBPO3/zxTDuc?=
 =?us-ascii?Q?sLJJVQppMfKYJXg3TcVlD+nRYhTYuxmXVTM0yv1X0l4zGZeIhih9JiqWU6dp?=
 =?us-ascii?Q?c2cIz+OmLxVVHCgZUWffAehqnalZ0XxgWS8Zwa5LGJ976lHVM2o0sDl9vOW5?=
 =?us-ascii?Q?mplpVtFyvuieWxEp/VyE653dDhK0KJkFi9ZCWTq+CbuT/HM9og/Hz3NlSC7X?=
 =?us-ascii?Q?OQQMlHg5oSYYU0q4HCt2VvKyvdQIYixVTxUmJutpREveD7ZHHg5L5elrCu7+?=
 =?us-ascii?Q?VFvse6zDCosL3/sdhMkygrfbIX8sfEZEdl6YJdkPNMzipPcxfO+83Aleyv6Q?=
 =?us-ascii?Q?CUzKix+IhUZGAEzvDwQ++QVePutmnPLyekWdqOS6cwydxCxjqrvMaQySP8V3?=
 =?us-ascii?Q?FTqdotyKLX114iAVXQ7Yr/okDDAURQbWpLFekGt8jDKjUa/X2r/A2NqhQiBd?=
 =?us-ascii?Q?XFTdOBhKrdSghH4UQZi2h75sktDysf6otRnoRsAld+rqvmXOdKe4kzNq/Za0?=
 =?us-ascii?Q?r8chsIaRE0XFADmJjP+KXwBMSwCc58WsgiC++9jBN5WmZ7ltzsPTaihzGdqY?=
 =?us-ascii?Q?obLn2374up9zC7UAfFrh3XxTqakAe7MCO4OTp40NWrqoYv8P+rClysE+vk2n?=
 =?us-ascii?Q?cE7UJVPtv6naJ+ms1+LqrB/48TBnP5sOEvxg3pZy1sO2z2j3fscy60s/3nVT?=
 =?us-ascii?Q?xUvXlqTLf3W4KiizdbHRNlMgxg5vkPRKw8hrQYQbdtLu2ABu4Q32Yy1WTE+h?=
 =?us-ascii?Q?2G+QnkW1DTGJbJD/Xigm3paGsEI1F5crOwn7FoAkZs+/rIuwo9qdmmce2xTt?=
 =?us-ascii?Q?36BOqjG3EUG9hGNkPDQbP1UUpjBDZE+B7p2uNFY3B1HzvOonyZA14rSwhOw7?=
 =?us-ascii?Q?hC6ogpN2ADcZ9k+ULgqAm+udqKLy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FM+W28ILxVJvHxPVTBMK+1P/Hakm1tXR2/Emd1CPn85FsjZH9YejWi6QK0p/?=
 =?us-ascii?Q?XpPReURuZvr+rgi86+ihPS+m0RuEnodPypagf/EcEyD7rRFm48iTWZRmTjh2?=
 =?us-ascii?Q?t7cCYwwUyvYhLJq1Nm8LuvwezDA/k0oDuWMppeG54jFpxT4f16dwjFdO5VVJ?=
 =?us-ascii?Q?ybfrAsgR3ZE/7+Rp4LyhuT6Xf9/d0LCKisIUu3XYPGsgiHNti456Jrq/xYvw?=
 =?us-ascii?Q?3e35Si4An9QJNXuX8cW1l87nrmZPkZvDOXFHyCzMLNb/Or6czXMZg/FGWw3m?=
 =?us-ascii?Q?kcGVtgIV1COAm265hQlgIygemCPvZAFUNPOTfpHeVIAYt0CpMFSV7ccDdDJo?=
 =?us-ascii?Q?wqAS4pNtjT1f5Q7b10bnwZifsGd1EunZDIMWe8VqVBcTUmsByp55eqBy+Xv9?=
 =?us-ascii?Q?vuwQqap78bKluTd1adw0QTReyN7dus4WmwAQaZMae1uA+eX1nT54tjCQzuuE?=
 =?us-ascii?Q?xV4dOHoMjy5iSXLf3PhQTp/38htAsvxyKhncoq6VxN8Sxtdp17nxNjGvPLSy?=
 =?us-ascii?Q?PYOA/izblia4as0DgfDIWTzDwmezbA4IVchqGdaNDeWPJvBS+rRUtvFcnHC7?=
 =?us-ascii?Q?yCTZfKTHxM5wvPqRQpXXGE8nzl3+5vQUPtTNHB74GaMWtYcNYdF+WHeOQZ4u?=
 =?us-ascii?Q?waABXrPYOepcLpT+Tv0hb1R61Y4lMsroJPDXg4J+kKHGqC/x3GENHOIksJIr?=
 =?us-ascii?Q?e42OQplzNTO2nFhmVe66aMsG1a4GNKwYjfdNZLDOnfCEnUintHBjp1gRsZ4y?=
 =?us-ascii?Q?A1Oa+ixrd/Jx3hSehqc6OKSD7UvZ2Mb/b2ySRe04YNyEF725+68nz5gQjz+W?=
 =?us-ascii?Q?aDagOlpVraoDajq6mcr3Uq+JX19zYriGgHLfdM/QRwGL6DuboKlY2aibMwBj?=
 =?us-ascii?Q?igWCuYKdu7Hrn70qYmj+kyGNt0F45gGa2b/fC7F93zHtnU5deRJ0V/WXSd6Y?=
 =?us-ascii?Q?flq8zWFgjpTD/4ssGtRQ82chLknXpdEY3Ponz9CUKwDpbvgyMRO0in4N6TNA?=
 =?us-ascii?Q?QTJWr/KQiBcXthgUCFKvj5p75s6r/2Umr4xbhRuiug2OV7T2JVKSbD0Zr48B?=
 =?us-ascii?Q?o5qo34uT20+bGLWs+qMyb3k9aiIxkoXF0zUvlnAfLH87omVLtOTENFs0vhdI?=
 =?us-ascii?Q?sTly2mDQ2d+Pv/nw7VtFjn1LSvmnDCn61HIufPojSGoj9AAw9riEG/sbnzHT?=
 =?us-ascii?Q?NyuW0DYn5UVgEJ+k6jjDmCthBIYcvWz1LizYYwDPkylamXatifx7EuXzVNNr?=
 =?us-ascii?Q?tGUplhP9lzl+uyNJ79MRImpcsftV0VvsMjJws4WSHBz9ZU3ufNSYNrUFRPTx?=
 =?us-ascii?Q?A9ooJiVkHVBcl5ZORSJEpfVzRxBxFilA+LdsGIYTyk7TzljOaYGivefkZusb?=
 =?us-ascii?Q?YXI5zjxcx7tTBbgOTn5lFzZs1mPbxpfBX5hnIAFkTTCG4sZ1rv8LZ36HCKFX?=
 =?us-ascii?Q?aFDzhcIoPNQfJaMYCoUYaXj0BtIzVJC/t3yUXbH8tEtqQv32XZ+TcEn83E60?=
 =?us-ascii?Q?3eBVostLxToV3CvB/LcANYDiD3QkW6814a9rAPwvnKbKCm+jtonphLMn2o4I?=
 =?us-ascii?Q?0vQPrW+Q2yecWovt7q1LqU/nZmuMMHJCgTAIUkXRiCCBvi4q1JcVlZ5bgzsq?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da0e77f-edd1-49c8-c0b7-08dd3b624fe3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 03:59:19.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/V5EcHZMiIXZIUiAKHA5PDpo6xDTOEuqWsU6pKS5QPu4nG/5Uej/sZIuETwBCenbpZ1y8e596pMM3+y7J5b6FPh19bNfTVHuga3b6//1Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8853
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add the basic bits of a features driver to handle all CXL feature related
> services. The driver is expected to handle all CXL mailbox feature command
> related operations.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/Kconfig                   | 11 +++++
>  drivers/cxl/Makefile                  |  3 ++
>  drivers/cxl/core/Makefile             |  1 +
>  drivers/cxl/core/core.h               |  1 +
>  drivers/cxl/core/features.c           | 71 +++++++++++++++++++++++++++
>  drivers/cxl/core/port.c               |  3 ++
>  drivers/cxl/cxl.h                     |  1 +
>  drivers/cxl/features.c                | 44 +++++++++++++++++
>  drivers/cxl/pci.c                     | 19 +++++++
>  include/cxl/features.h                | 23 +++++++++
>  include/cxl/mailbox.h                 |  3 ++
>  tools/testing/cxl/Kbuild              |  7 +++
>  tools/testing/cxl/cxl_features_test.c |  6 +++
>  13 files changed, 193 insertions(+)
>  create mode 100644 drivers/cxl/core/features.c
>  create mode 100644 drivers/cxl/features.c
>  create mode 100644 include/cxl/features.h
>  create mode 100644 tools/testing/cxl/cxl_features_test.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..9a6ffd81ac0e 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -146,4 +146,15 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_FEATURES
> +	tristate "CXL: Features support"
> +	default CXL_BUS

Not sure this default makes sense. All of the other "default CXL_BUS" is
because only an expert config would ever turn on CXL.mem support but
leave one of CONFIG_CXL_{PCI,ACPI,MEM,REGION,PORT} disabled.

Features are purely incremental.

> +	help
> +	  Enable CXL features support that are tied to a CXL mailbox.
> +	  The support for features including the feature mailbox
> +	  commands and also FWCTL support of the commands via user
> +	  space.

Perhaps a couple prominent examples of Features an end user might know
by name? Otherwise "Features" is too generic a term for making the case
for turning this on.

> +
> +	  If unsure say 'y'.

...say 'n', someone had better have a feature in mind for this optional
functionality.

> +
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 2caa90fa4bf2..4696fc218df4 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -7,15 +7,18 @@
>  # - 'mem' and 'pmem' before endpoint drivers so that memdevs are
>  #   immediately enabled
>  # - 'pci' last, also mirrors the hardware enumeration hierarchy
> +# - 'features' comes after pci device is enumerated
>  obj-y += core/
>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> +obj-$(CONFIG_CXL_FEATURES) += cxl_features.o
>  
>  cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
> +cxl_features-y := features.o
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..73b6348afd67 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> +cxl_core-y += features.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 23761340e65c..e8a3df226643 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -9,6 +9,7 @@
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_pmu_type;
> +extern const struct device_type cxl_features_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> new file mode 100644
> index 000000000000..eb6eb191a32e
> --- /dev/null
> +++ b/drivers/cxl/core/features.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include "cxl.h"
> +#include "core.h"
> +
> +#define CXL_FEATURE_MAX_DEVS 65536
> +static DEFINE_IDA(cxl_features_ida);
> +
> +static void cxl_features_release(struct device *dev)
> +{
> +	struct cxl_features *features = to_cxl_features(dev);

Perhaps make this and other local 'struct cxl_feature' pointers 'cxlf'?

Just to keep with the theme of 'cxl<short-suffix>' for local pointers?


> +
> +	ida_free(&cxl_features_ida, features->id);
> +	kfree(features);
> +}
> +
> +static void remove_features_dev(void *dev)
> +{
> +	device_unregister(dev);
> +}
> +
> +const struct device_type cxl_features_type = {
> +	.name = "features",
> +	.release = cxl_features_release,
> +};
> +EXPORT_SYMBOL_NS_GPL(cxl_features_type, "CXL");
> +
> +struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
> +					struct device *parent)

So this function is alloc + add + devm auto-release. I would call it:

    devm_cxl_add_features()

> +{
> +	struct device *dev;
> +	int rc;
> +
> +	struct cxl_features *features __free(kfree) =
> +		kzalloc(sizeof(*features), GFP_KERNEL);
> +	if (!features)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = ida_alloc_max(&cxl_features_ida, CXL_FEATURE_MAX_DEVS - 1,
> +			   GFP_KERNEL);

Does this need its own ida? I expect it could just use the same id as
the memdev, and that saves some potential confusion of which
memory-devices support features and which features interface correlates
with which device.

...or how do you imagine that working?

> +	if (rc < 0)
> +		return ERR_PTR(rc);
> +
> +	features->id = rc;
> +	features->cxl_mbox = cxl_mbox;
> +	dev = &features->dev;
> +	device_initialize(dev);

At this point @features stops being freed by kzalloc and starts being
freed by put_device(). Which means that no_free_ptr() on @features needs
to be called before put_device().

So I would put all of that in a function that does the
alloc+device_initialize() then you can do:

DEFINE_FREE(put_cxl_features, struct cxl_features *,
            if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
struct cxl_features *cxlf = __free(put_cxl_features) = alloc_features(...);

> +	device_set_pm_not_required(dev);
> +	dev->parent = parent;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_features_type;
> +	rc = dev_set_name(dev, "features%d", features->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	rc = devm_add_action_or_reset(parent, remove_features_dev, dev);
> +	if (rc)
> +		goto err;

...otherwise all of the gotos above causes a double-free of @features as
far as I can see.

Mixing goto and scoped-base-cleanup... often a bug.

> +
> +	return no_free_ptr(features);
> +
> +err:
> +	put_device(dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_features_alloc, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..cc53a597cae6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -74,6 +74,9 @@ static int cxl_device_id(const struct device *dev)
>  		return CXL_DEVICE_REGION;
>  	if (dev->type == &cxl_pmu_type)
>  		return CXL_DEVICE_PMU;
> +	if (dev->type == &cxl_features_type)
> +		return CXL_DEVICE_FEATURES;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..ee29d1a1c8df 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -855,6 +855,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  #define CXL_DEVICE_PMEM_REGION		7
>  #define CXL_DEVICE_DAX_REGION		8
>  #define CXL_DEVICE_PMU			9
> +#define CXL_DEVICE_FEATURES		10
>  
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> new file mode 100644
> index 000000000000..644add26975f
> --- /dev/null
> +++ b/drivers/cxl/features.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024,2025 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <cxl/features.h>
> +
> +#include "cxl.h"
> +
> +static int cxl_features_probe(struct device *dev)
> +{
> +	struct cxl_features *features = to_cxl_features(dev);
> +	struct cxl_features_state *cfs __free(kfree) =
> +		kzalloc(sizeof(*cfs), GFP_KERNEL);

Just makes this:

	struct cxl_features_state *cfs = devm_kzalloc(sizeof(*cfs), GFP_KERNEL);
> +
> +	if (!cfs)
> +		return -ENOMEM;
> +
> +	cfs->features = features;
> +	dev_set_drvdata(dev, no_free_ptr(cfs));

...skip the no_free_ptr()

> +
> +	return 0;
> +}
> +
> +static void cxl_features_remove(struct device *dev)
> +{
> +	struct cxl_features_state *cfs = dev_get_drvdata(dev);
> +
> +	kfree(cfs);
> +}

...and skip the need for a ->remove() routine altogether.

> +
> +static struct cxl_driver cxl_features_driver = {
> +	.name = "cxl_features",
> +	.probe = cxl_features_probe,
> +	.remove = cxl_features_remove,
> +	.id = CXL_DEVICE_FEATURES,
> +};
> +
> +module_cxl_driver(cxl_features_driver);
> +
> +MODULE_DESCRIPTION("CXL: Features");

Maybe a few more words:

    "CXL 'Feature' command support via FWCTL"

> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("CXL");
> +MODULE_ALIAS_CXL(CXL_DEVICE_FEATURES);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..eb68dd3f8b21 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -386,6 +386,21 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  	return rc;
>  }
>  
> +static int cxl_pci_setup_features(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;

Looks like this function wants to take @cxlds directly and skip passing
in @mds.

> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	struct cxl_features *features;
> +
> +	features = cxl_features_alloc(cxl_mbox, cxlds->dev);
> +	if (IS_ERR(features))
> +		return PTR_ERR(features);
> +
> +	cxl_mbox->features = features;
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> @@ -980,6 +995,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_pci_setup_features(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_set_timestamp(mds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> new file mode 100644
> index 000000000000..b92da1e92780
> --- /dev/null
> +++ b/include/cxl/features.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024-2025 Intel Corporation. */
> +#ifndef __CXL_FEATURES_H__
> +#define __CXL_FEATURES_H__
> +
> +struct cxl_mailbox;
> +
> +struct cxl_features {
> +	int id;
> +	struct device dev;
> +	struct cxl_mailbox *cxl_mbox;

A bit uncomfortable with a 'struct cxl_features' instance having a
pointer to a 'struct cxl_mailbox' without holding a refcount.

This all works becase cxl_pci_setup_features() knows that the @parent
it is passing to cxl_features_alloc() is device that will also
unregister the @features device before destroying the 'struct
cxl_mailbox' instance in @cxlds.


> +};
> +#define to_cxl_features(dev) container_of(dev, struct cxl_features, dev)
> +
> +struct cxl_features_state {
> +	struct cxl_features *features;
> +	int num_features;
> +};
> +
> +struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
> +					struct device *parent);

...but this is proposed as a public function outside of cxl_pci. How
does cxl_features_alloc() understand the lifetime relationships between
its @cxl_mbox and @parent arguments?

I would have cxl_features_alloc() (devm_cxl_add_features()) take a
'struct cxl_dev_state *' argument which makes it clear that the features
device must be unregistered before 'struct cxl_dev_state *' can be
destroyed.

...or something to constrain the freedom of a new globally public
export. Does this need to be made available to any other drivers besides
cxl_pci for now?

I.e. should this be include/cxl/features.h or drivers/cxl/features.h?
