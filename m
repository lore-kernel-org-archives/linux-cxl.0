Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA525A63B
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718334; cv=fail; b=EYI6LxMCprCdyqFKivHUco93f9DlGgi6Ddp3e3AmOv6zj7TEqsXV4a9MyaG+lIZOt2rMYs2cMlKmDl3vIj2RagHtyEa/KLhqrjlobG+hZHG6dL5OywSUpHcBD9vTp1rXxjMeNq2LiR+EVXr8R4Aoadb/Qi0SJC9WSquFSVEoibo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718334; c=relaxed/simple;
	bh=jhjZ8h3LXY1jXG3I8K4ReUaqeE/NSjNuetPprmpoN0Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KoGK/xrStU3ioLHr8qfsTQH33+/sjofOh4gr1+15xpI0/POrn/PrB1aQYDhDRX2arQilGj+/bG7bQ+b/4tPxqTBhqFBs9OywDBTrF4jopw+rNQzQKSNEqkKov/Q+W5vxQuAmTvh4ILiUdUirmqnnByi11xmX7SR/Z0OuNKgYA0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcQbAS50; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcQbAS50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738718332; x=1770254332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jhjZ8h3LXY1jXG3I8K4ReUaqeE/NSjNuetPprmpoN0Y=;
  b=BcQbAS50E08XJIbVQEGTgOYUUxMj32jNoiWhLZwZih3uZPGo8by7yvx+
   hWMOZtSLe9u4iQAWW2NdG5ouHE7DNd++6/CcS1Ydoky+33VtTn0yfWrN7
   Rr4xChWFp5Scp9LX+XaJ9RZrHf7nN1Ll3to3YQan9OVAJSPEuNsrAxfkM
   NVpSTtvY+Hxo2w4ac2udCWWQcSu9AwHuOEOGrSb/aGhaSmUs4qQ8dn8pD
   AbCLe26x6FwA7IbaWrFOLkt1c7rjsAEUVbdRXC1NgMWduS752ZOnog9DC
   c3wAI5MoqmQ1ZEl6vCSBzHB4lFuL5fNcmX84PPuKn/tcXIxVg14JkJAun
   A==;
X-CSE-ConnectionGUID: R7aq63wET8i3OquGRZ6A8Q==
X-CSE-MsgGUID: Ak/PysS4SnuZToAub87D/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42927758"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="42927758"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 17:18:51 -0800
X-CSE-ConnectionGUID: c4sR12BOSMe1Gt11FqofgQ==
X-CSE-MsgGUID: 03FGVX7OQEqsR0s73tjj3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="111334141"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 17:18:50 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 17:18:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 17:18:49 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 17:18:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyrtaUlIqEdJzgTWRoqQyK7hAqWfQnpR0TVDW4MLgwiETZI+rVv1EPC14udJ/M8WRDH7nSVNhu4hdzDAyzG43ObujGma716AtlpQkysr7YFNoa42dUWHOU4eBkNFuX3IDaDqJAiOBUDotOTb6/fVOMYjFz8ddkoT2voNzFuql6xMh7Xhp6jzRBfdFms6R7UlBCCJg+bOHs+exmy96BDe2/XXIfDYPsPZSmbokAL6ysLLxDYhHCBw+guf9XAey4SD69/89Y8aww85bLfjPTiCWI6yP5UEdJZ9Mmk01D3yduE463ifEv5/SAp4GfM+g7L3bxUM4zo7NG9iTWmtLjet8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGDky6oVoCbNkH+DvHe9gjfxkFd6v1/gZL2loFq2/VE=;
 b=VVOV3B1NixM9gn0h8ZMwJhnB2LB+GDqMKiDJOlllk4qvocLjCjOp6uoQp5ftFM7HF1uEwIewu0KEbJjAt+TrnLgq5U86CKH3KBAcAVsPcw1hNQV3GmnIy4JWOO0oQ+W+NyGmOehxNJ2SJUxGyieXJmlLGAWEkile+kGw7DAITBL7pQU/MyhEehIwCEpugYJeujP1J+YNiXMYjMP0aSqGzM5I/Qf7zOXvWd9+kLldcrpp6FPY4mpQ20TqpzPxAXHiieMKN8IV6lWPaEX8AJZzmJqlncu+Z77dEade3JU33w6mVlklC7W1VCFwpfGs4lUFefVCskcUB7W2fl/X68TEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 01:18:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 01:18:34 +0000
Date: Tue, 4 Feb 2025 17:18:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 08/16] cxl: Add FWCTL support to the CXL memdev driver
Message-ID: <67a2bc67b0c4c_2d2c294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-9-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-9-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a4fbcf-974f-414e-f622-08dd4583027e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sVkAo0fT00lyO3xT9xMyGVJ2dwDoiGyNqX0QIVf9Mci8HNJ09OIb1SiTQ1h2?=
 =?us-ascii?Q?2w+rjrEEs/5OWsiQ7Q4YkwgPChHfdQ+UV4HBpnT6StGjLb6gUJSH0Khav0n8?=
 =?us-ascii?Q?QbsF7mdbzJzMrPpuuRxFVEqmz9yYGd//m9v0SBdJfYOHwC1g2xl/wwmEogTV?=
 =?us-ascii?Q?LO7GkoIbHDSCqN+OEcmvH/7y3zqrR8JjjaJGuGgQxOyr49ANXoq7Zmjx0nJ0?=
 =?us-ascii?Q?NBqxW7NSl89wlHk9phLxiV4sGGUOrU6AtQtbv5U4NUmnj9SExyzcAEyX+Suf?=
 =?us-ascii?Q?H1niTS+YTIxXOGisewz+R6Rb74NMk+jpFnlZMaCGnlT8nwgz8H+6EX6uaNeo?=
 =?us-ascii?Q?iNWob4lz4HX7RBbvrA6Fv/+Fv2qy2IhCstvuM8GRWMYOuYvLlgboxomKbO1b?=
 =?us-ascii?Q?LGiMZIQcw003GWyehe2HHc1WUH0FQa5SF5S27IndnGzicNBwcyjV1Dr62EOa?=
 =?us-ascii?Q?QOxFGGXThTIfIq0pweWpulCFABqoyLZ5PVaf1VuQtBiQvwGbaW0pQzHqEkwS?=
 =?us-ascii?Q?1BptdkuoaxjYAmFPaRzngts0CiDcP8J8g2XtcDQj5RFJACeh3eoAvyYBZGa1?=
 =?us-ascii?Q?/YPsnu0OhyUC2gMW+XwMriIOI5Z/sQzkI/9VsEY2WHPbkaba9B5UmcKbQF1d?=
 =?us-ascii?Q?kRTUAG2BApH7FX0NLzfmXdDOH2HMr5avtl7BVdtSgvlwCperZcax4nOH8ibx?=
 =?us-ascii?Q?PNLUUNmXfPnyEuhGJZqqGifmykzGwuXG5c/RYT5CS07va4pMivYHrZLQBERf?=
 =?us-ascii?Q?oe0X1sNpGHIJ+cKA1FrxjJ1Pt8li23zpS1S9njFcLCDuZfjPoV2WDfu5h8l3?=
 =?us-ascii?Q?IxxGbQHAedff2KS+78zWAcbPIGkK+569FrBQs29As58zzuVatwFNCqeFm4W7?=
 =?us-ascii?Q?Oi+oATexuDsIlzNoypdoluG98hkvJWGPH7yHZ7Sxn36yWk8eNNc4/CqMZR1W?=
 =?us-ascii?Q?53ySqyRp8dkJklX3AKdikawNL3g8felu3/f/tPwK+sQDmi3Bqc9Jfr+aOxM5?=
 =?us-ascii?Q?hdSaAPHplhsCaKX+dwsjbeSr+5FeEWk0koUCFn99fWa2zpZWJDy5DWKNN20I?=
 =?us-ascii?Q?XAamFBioFbxTrJhSloCYwvLBwDEolZqpghZ3Hzg/6sv3Au1VyFkHoA7O8E10?=
 =?us-ascii?Q?47nUUJSVA/88jprc8IqtOg5nQIS/yz9O2+ac+qYgwGuejOEPEeGA4tbHx0fX?=
 =?us-ascii?Q?D/RGKjSjptfdzNgfBoS6Z+w1RAx0wqaX6Fxac4XmrWHggFKiC8l20huEg8ni?=
 =?us-ascii?Q?sT9/JxXrYOuam63X/BjkbhznTC0ZgIl2z7WbopGga4PGhp4oiWi2CnE754xe?=
 =?us-ascii?Q?9ndR7lrbHkkcgMIPKwJJUI7xJEVPJDCJ6WfAwl0ItW5qyCPnJ8mA0IWXwcVY?=
 =?us-ascii?Q?JrP0WSQSJuH5iW91Iu2SlNCbKk3L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?om7gx/YS+QtzAfuJWY82Vqjv7wPpcDAwlT5u5x4ZHLvoX1v9V2GDcwHviUzt?=
 =?us-ascii?Q?wUjuiIaxV27g9pdrmQsVniy94Sii8jVNUS3Zfxdhdq04Fpb1u36UCzYYOBN9?=
 =?us-ascii?Q?ziRDJ/6yOwqyrBn4zwv6AKdjrsH/P6nV2ImDKv7i1Gom7aKS/2OmycnmbF1b?=
 =?us-ascii?Q?JknShMcup/jxptqmfhq8s8O/JBSALv2OnWuWn4QGg+OZVdXFRnmGHvT4slra?=
 =?us-ascii?Q?d1QfyXDhELk6i3JboXerJnPLMhSGYt4VuFrikEGJf3yckQaexJu/nOeujokJ?=
 =?us-ascii?Q?336wdLWH0+wK2isPoEDzp92P2+sAUg2nwggOHQ8tEwOJ4QlibbUvR46WHFk9?=
 =?us-ascii?Q?8yI1KGsv92rCJdrGKneiUzVJKN629/NbeSps73C+aqNv3Ht/pYKI/yCWfVGv?=
 =?us-ascii?Q?T1ciuVwRNMpuRHWwphwBjX3T/iebvnvmLATgGOMoVGyKFIVGNnol1qzZB43Y?=
 =?us-ascii?Q?xitDVZ6Z6LJ/8G7Jh0VPYhOUHsWoTnf1g6H951LTMIBRFSgKN0Lqhdi+fbgE?=
 =?us-ascii?Q?StIKdhR6OmSvB9elWXQi5kI3Ppzl0EpwDRUU38haavnBgf7H4HKzsMXKuX3t?=
 =?us-ascii?Q?YOCILAAxhbmRQ0pRzMGqbHqczwgbhxt8fdgN1LVbIsgGdfJt8oWopHd66eww?=
 =?us-ascii?Q?z2L/z5S3mte6oBmDfuoJwSleLblFbTPIfGCUfWtoxEqkEsMG7N+T+buUjaKS?=
 =?us-ascii?Q?/8w0P35rd41hwy8uUiDYOSxCUfcRTkh8MMdBx1ucI4MDgBZf+ChH1njiMwnv?=
 =?us-ascii?Q?ayvVzSAokNjTYiz5f0PtiDZ3zqWvHn2Lbqo4mAO3ygpz4TyQgK+SjmPyWHh0?=
 =?us-ascii?Q?WjyXucM4K807hfAuFs0dfRoe8bZB41lPvdpUPVctHhU82hT17hQjQQxaP56D?=
 =?us-ascii?Q?bhjGuCVKfchj5Z9OIt1Y+VoTpAhx8Ihsp9bVGKz9p7ZpH6tgf4BwLRSBooNe?=
 =?us-ascii?Q?FqGChbLIlSr5KdP3/BQe2ugoYVkGzvRQMxuhcNkIL8uillDv31eq9I5DJwR+?=
 =?us-ascii?Q?D1CwoV7i6w2em9gYvvq7SIZbvbBE1o0Dvkkm4lNYhhVZFUQg2nAv0uJeCl+V?=
 =?us-ascii?Q?QOpw7S5eznuuR7NJJICHWH2I7o6ei4qIU2HbbQvGFbWn4xHM0OGY8f3d0qCw?=
 =?us-ascii?Q?ju1GrmRCoyhQ8EkZYvpdpvbZ48r4+Mds/+it+DylwwASYtQyBMYYvrCQNrh2?=
 =?us-ascii?Q?Sq1gvekB+wQKeb5Yzup01AIF902eKLcdyiQimJv+ORWp3pMppHVxLNfIzz/b?=
 =?us-ascii?Q?Hyq7gilVlkBAE1iE9ltxq2qI5KKYkODagUGI9FQ+TR8ZFzZ0tOo6COYV7cCl?=
 =?us-ascii?Q?9uOc/ZXH83pQ5BLbQvfLsfHE8IeZ7xJsX9c/OOc3dIkEy76f5w03aiWdLG7t?=
 =?us-ascii?Q?RtpsJjtKVRGBVTHIEaoZsuUp2LTEkNCzRJtMT1UJocqWwXZoMmLYk8XpShFn?=
 =?us-ascii?Q?LszcSwBqjFVR/nvSHGPNiTi1OKeHoXe87c2B48pBTKH38hTd8gy2nMRf8EOt?=
 =?us-ascii?Q?fBCxJGXVEbB3RQM3gAxSdMMy1t/Y/Mqizb0otc2C35qvuvMOJdQB24x20qif?=
 =?us-ascii?Q?9jyoDjnVapxbavu5KeSK4GPHgOI5GPA0aV1rH9stiy8nBWvU8r9+qtsFch69?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a4fbcf-974f-414e-f622-08dd4583027e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:18:34.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5j/9I37rJCunBBFM0SMmfbc/o0zNRKUaccPbKOOwl4dh0kfSx86OGA68RTdWtJe099liLWBI4ZqQjvDADYp1V9nLV6jZZ5EJITDbfzDGhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Fix spelling error in Kconfig text
> - Remove errant blank line
> - Drop using of __weak. (Jason)
> - Return NULL for allocate function. (Jonathan)
> ---
>  drivers/cxl/Kconfig        | 15 +++++++
>  drivers/cxl/Makefile       |  1 +
>  drivers/cxl/features.c     |  8 +++-
>  drivers/cxl/features.h     | 29 +++++++++++++
>  drivers/cxl/fwctl.c        | 89 ++++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h     |  3 ++
>  include/uapi/fwctl/fwctl.h |  1 +
>  tools/testing/cxl/Kbuild   |  1 +
>  8 files changed, 145 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/fwctl.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..6bb1ffc74956 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -102,6 +102,21 @@ config CXL_MEM
>  
>  	  If unsure say 'm'.
>  
> +config CXL_FWCTL
> +	bool "CXL: Firmware Control support"
> +	depends on CXL_MEM
> +	select FWCTL
> +	help
> +	  Enable support for firmware control of CXL devices. This allows
> +	  a FWCTL char device to be created in order to issue ioctls from
> +	  user space to exercise the CXL Features commands supported by
> +	  a CXL mailbox. There are some Features defined in the CXL spec
> +	  such as memory sparing. However a lot of those features are
> +	  exclusive to the kernel. Most likely the Features manipulated
> +	  by CXL_FWCTL will be vendor defined Features.
> +
> +	  If unsure say 'n'.

Per previous comments, combine this with the CONFIG_CXL_FEATURES config
option and treat it all as one for now.

> +
>  config CXL_PORT
>  	default CXL_BUS
>  	tristate
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 12fbc35081bb..cd28fb3bf855 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -18,4 +18,5 @@ cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_mem-y := mem.o features.o
> +cxl_mem-$(CONFIG_CXL_FWCTL) += fwctl.o
>  cxl_pci-y := pci.o
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 0086fdb20bfd..c14dc6d45985 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/pci.h>
>  #include <linux/device.h>
> +#include <linux/module.h>
>  #include <cxl/mailbox.h>
>  #include <cxl/features.h>
>  #include "cxl.h"
> @@ -173,7 +175,7 @@ static void cxlfs_free(void *_cxlfs)
>  }
>  DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxlfs_free(_T))
>  
> -static struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +struct cxl_features_state *_devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
>  {
>  	int rc;
>  
> @@ -191,7 +193,7 @@ static struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
>  	return no_free_ptr(cxlfs);
>  }
>  
> -static void devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +void _devm_cxlfs_free(struct cxl_memdev *cxlmd)
>  {
>  	kfree(cxlmd->cxlfs);
>  	/* Set in devm_cxl_add_features(), make sure it's cleared */
> @@ -231,3 +233,5 @@ int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
> +
> +MODULE_IMPORT_NS("CXL");

What symbols does features.c need to import? I think this all gets
simpler with the proposal to move all of this to cxl_core.ko optional
features.o object.

> diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
> index 8706f944b476..a51625774b58 100644
> --- a/drivers/cxl/features.h
> +++ b/drivers/cxl/features.h
> @@ -3,8 +3,37 @@
>  #ifndef __CXL_FEATURES_LOCAL__
>  #define __CXL_FEATURES_LOCAL__
>  
> +struct cxl_features_state *_devm_cxlfs_allocate(struct cxl_memdev *cxlmd);
> +void _devm_cxlfs_free(struct cxl_memdev *cxlmd);
> +
> +#ifdef CONFIG_CXL_FWCTL
> +struct cxl_features_state *_devm_cxlfs_fwctl_allocate(struct cxl_memdev *cxlmd);
> +void _devm_cxlfs_fwctl_free(struct cxl_memdev *cxlmd);
> +#endif
> +
> +static inline struct cxl_features_state *
> +devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +{
> +#ifdef CONFIG_CXL_FWCTL
> +	return _devm_cxlfs_fwctl_allocate(cxlmd);
> +#else
> +	return _devm_cxlfs_allocate(cxlmd);
> +#endif
> +}
> +
> +static inline void devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +{
> +#ifdef CONFIG_CXL_FWCTL
> +	_devm_cxlfs_fwctl_free(cxlmd);
> +#else
> +	_devm_cxlfs_free(cxlmd);
> +#endif
> +}

This looks odd. Lets just do an approach like this from cxl_pci:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2c943a4de0a..47d432e34ccf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1002,6 +1002,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
        if (rc)
                return rc;
 
+       rc = devm_cxl_setup_features(&pdev->dev, cxlds);
+       if (rc)
+               return rc;
+
        cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
        if (IS_ERR(cxlmd))
                return PTR_ERR(cxlmd);
@@ -1010,6 +1014,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
        if (rc)
                return rc;
 
+       rc = devm_cxl_setup_fwctl(&pdev->dev, cxlmd);
+       if (rc)
+               return rc;
+
        rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
        if (rc)
                return rc;

...where Feature command functionality is ready to be used by kernel
internal paths prior to registering a memdev, in support of use cases
like EDAC memory repair. Then fwctl is registered after the memdev so it
can reference that object.

Then the header file looks like a more typical:

#ifdef CONFIG_CXL_FEATURES
int devm_cxl_setup_features(struct device *host, struct cxl_dev_state *cxlds);
int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
#else
static inline int devm_cxl_setup_features(struct device *host, struct cxl_dev_state *cxlds)
{
	return 0;
}
static inline int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd)
{
	return 0;
}
#endif

> +
>  struct cxl_feat_entry;
>  
> +struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd);
> +void devm_cxlfs_free(struct cxl_memdev *cxlmd);
>  int devm_cxl_add_features(struct cxl_memdev *cxlmd);
>  bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
>  
> diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
> new file mode 100644
> index 000000000000..985315d5d503
> --- /dev/null
> +++ b/drivers/cxl/fwctl.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
> +#include <linux/fwctl.h>
> +#include <linux/device.h>
> +#include <cxl/features.h>
> +#include "cxlmem.h"
> +#include "features.h"
> +
> +static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	return 0;
> +}
> +
> +static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	/* Place holder */
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			   void *in, size_t in_len, size_t *out_len)
> +{
> +	/* Place holder */
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static const struct fwctl_ops cxlctl_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_CXL,
> +	.uctx_size = sizeof(struct fwctl_uctx),
> +	.open_uctx = cxlctl_open_uctx,
> +	.close_uctx = cxlctl_close_uctx,
> +	.info = cxlctl_info,
> +	.fw_rpc = cxlctl_fw_rpc,
> +};
> +
> +static void remove_cxlfs(void *_cxlfs)
> +{
> +	struct cxl_features_state *cxlfs = _cxlfs;
> +	struct cxl_memdev *cxlmd = cxlfs->cxlmd;
> +	struct fwctl_device *fwctl = &cxlfs->fwctl;
> +
> +	/* Set in devm_cxl_add_features(), make sure it's cleared */
> +	cxlmd->cxlfs = NULL;
> +	fwctl_unregister(fwctl);
> +	fwctl_put(fwctl);
> +}
> +
> +DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) fwctl_put(&_T->fwctl))
> +
> +static struct cxl_features_state *
> +__devm_cxlfs_fwctl_allocate(struct cxl_memdev *cxlmd, const struct fwctl_ops *ops)

This is more than "allocate" it also registers ABI.

> +{
> +	struct device *dev = &cxlmd->dev;
> +	int rc;
> +
> +	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> +		fwctl_alloc_device(dev, ops, struct cxl_features_state, fwctl);
> +	if (!cxlfs)
> +		return NULL;
> +
> +	cxlfs->cxlmd = cxlmd;
> +	rc = fwctl_register(&cxlfs->fwctl);
> +	if (rc)
> +		return NULL;
> +
> +	rc = devm_add_action_or_reset(dev, remove_cxlfs, cxlfs);
> +	if (rc)
> +		return NULL;

Same double free bug here, i.e. needs to be a handoff to the devm
domain:

	rc = devm_add_action_or_reset(dev, remove_cxlfs, no_free_ptr(cxlfs));

...but this also might be another case of a function that wants to
move the devm action responsibility to the caller.

