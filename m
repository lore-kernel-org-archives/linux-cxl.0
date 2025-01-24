Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4F1662E9
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759733; cv=fail; b=rXGrwKCOxlLVYS1QbesWsHygCzi1yeeR5vRJ+3spFnj5wjG2jNzKAou54EQTdUDW0Km9AeNNGlviSyGNyDlbbbe1p3PIrcg0twUOE25iiz/ZiqfcSMDGP0kjVyzKQ2z7q9LJJXYiPVikZP7bdGY6kw/UFqBhzw0t15qhQDg13X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759733; c=relaxed/simple;
	bh=R/ir7HlXdIPO8jXvACOush2PXepctABJEHTTdQWLho0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1MupvVr5BVnQAAxRyIkGStu35J2QAsNYqdCKkgazkBSmMGhvZy6W001wtk2kbXrx8wnQqnFHK6PkJ28GTGi7L2PuM496oT9vV6LMcZj4LgLDjQ8HjreUaE/kdUQCKND5kt9Po7KWepbg+mgQGH8MaiPPSrqqzGi7pCB626uThk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ477QO6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ477QO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737759731; x=1769295731;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R/ir7HlXdIPO8jXvACOush2PXepctABJEHTTdQWLho0=;
  b=QZ477QO6d4zUV9cGQK4jI8oPwCuZEHkj8tJQ1RnOwG0VZqIbA10ib+Op
   WsTTooVcprSeOZ0vrFVPq2ohn72gmWxMUcwTNPcdndTqfVXX02AXgApTj
   0BhqHrEkRrb0kv5YtxQgBn2ZNL0skVtxI74SNuqGvxnIyU7yWdmReix3W
   /UpPtmSWOuvtxCM3xc15SokAvd80d0CUhR44oSGNe5Lkd968cmQomxKol
   8CEJJmajHjwBOeWW8ba9libxE6x2Zw4zm6JgbZgIcBPufYa88BsG9LMHx
   YDlF6GiPPbOIS83nhd5DZ+gwmvt67V/dE39wyuGqQwwuja6Mv67MDDKlQ
   Q==;
X-CSE-ConnectionGUID: ua1tBciMS0uCLYMuumtnSQ==
X-CSE-MsgGUID: dkd/au4iS5KnEGJLPPXhEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="42238722"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="42238722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 15:02:11 -0800
X-CSE-ConnectionGUID: YBucOKtMQ2C+zAh3WIPzgg==
X-CSE-MsgGUID: fyhnoL3bQBa48pdjRVnb/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112837068"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 15:02:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 15:02:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 15:02:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 15:02:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPB+3xRj1vBGsQjgNXSpesLibpL69idAik3R4lcEWdS7Ws92U3R1jkLf3HC3QpWRWvTDquHyg3UjFIrSOx+VtcSXoBjRo0MqtDNeL0BwYDTcthda1/IYsX97RUWWJIXt7HJ1IiVCPmzjPy3d8nuZ9NPJlpCL+TNsbVPSVQVUg0dbXHUW5fAHqpHWiVDWyuTJApGd9ojVLBm7DVxygXiibR/H+sj3RH3ek2/YvN2HqEFtMXBUm8aMBR8+1/1BJuiRgVi3dA0EcVULbqnOeRTbddsXno2jZ5gceW5hvfrrNqP5faa89QM7aC6E51KGk6furLT9FKSU5DNth0Oa1QKgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrZsMi0FoCLT+dSSyrvn/coy0quwBBS0qFlUH2aQit0=;
 b=NRJMEgPF0x99vPOU74XatkpfaL9QMZxSHgm/bLUiJHiskTFPxgVgGLgJaaHLEVKGgxWytsUcnn3YqEvyOR8jXb1KIY/G1he+3iEFvnzeR7ho+USQ2bBohdusW3y6dSt2DLUg3Q0ORLVXrTogCSlYYF4UDpjtGxw8aNPX5PCfGSXB8X6THki662MYmNY+XuMfcSEFRG1XsMLqcD96YZJ8Z/QZnlZI0bOYk1rk+LqV6+0S8/GKWZGuV9xgKRyAybcwxacKzr2o/Zm44nLOCEjwJdIlrFDSsTUU+S3QJyjOiZz0gqr6voNQEQf+5myN5EVsFiYBVi+Cxm69VjgE/9Xh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 23:01:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 23:01:25 +0000
Date: Fri, 24 Jan 2025 15:01:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 08/19] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <67941bc343405_20f32945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-9-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-9-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b17a66-261e-4603-3129-08dd3ccb0752
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+vcJ0xsoICnzhU5s64Z52pJXZoJXX91hWMgqnL/djkdqP82NzwIZ6pqPqUl4?=
 =?us-ascii?Q?Bp2HxOIxej/k3u8+6dzx/jH1B38FY3p3hCxX5cbZ+a3GiJqDJFI3JhHKTlXG?=
 =?us-ascii?Q?WBKIuXopteKIrIYHI+BfQIJLt2LKU2nvR1roL8UrPmVi6LQzPFoPU40wcc6M?=
 =?us-ascii?Q?XqexMICuqr+IS1qf5PpbYk2dW8OrM79PYgHD5F15joSgFKZz9d14nPEIniQT?=
 =?us-ascii?Q?vHRLcHDkBCfsb1459+gcE64rOdlV3l1ghE8mPoxgYswThUhmgahU/2Rh0ihd?=
 =?us-ascii?Q?OysHKkOLLRzqMPZSRd5iBUGy0p+r0xlwx7ZpPEVACbxTc+qoiQJH8C0Hs7OM?=
 =?us-ascii?Q?Bt9+ZXcDA/ZjbOsuNcCsK0Nf4ZbPuBAi48ySMfnu29WMgjPjInTpWEN47fYM?=
 =?us-ascii?Q?3B4eSqDCu8GyhF9dYVIEKmXcBiwgkmQL7x+0q1pZZyz3ui0VKbjhjpNdqva+?=
 =?us-ascii?Q?e5wPfCp3mrc1T0ZLXjDmReRQ7EbxUsFrr3uWRuGx4+1iWT9weyxAYlJk05sU?=
 =?us-ascii?Q?NzbmpYwcHl7DP7xqMoPkuG33Kh3MRr1EVLPymRnx/Z6UMdxFBqP1ZbjVyY0+?=
 =?us-ascii?Q?HcbjbDn632mxN/OD0vN7f+HKKvnqsfscAF4cCtg6Rr+QfI2tOkTIsBzvgBSv?=
 =?us-ascii?Q?6hYlKm3vlkm/QQoCIC6OuQD98JEVMyJIcTg130szp2NNuwX0A5ER0jch9Fhp?=
 =?us-ascii?Q?AAOJ4TJB2aWKiD1xWgxBSJiM1eG5PzvE8hozjCHJOJB79uc7NJJ211C7FRn4?=
 =?us-ascii?Q?VRaXb610j9kJBwuXbwm8B2mXKX7LzV1jm0Xu67iQR3frQkjuVy5Ah0TXdNPf?=
 =?us-ascii?Q?s3lKmyCx67eWiFb7Gp4jEFT8RUnxNvTVbHLOjYo7he3Ad6mf48aR44IFTzoW?=
 =?us-ascii?Q?STuenmDXrSrhZOhez3iwaugY9aKOBvXEYwf7tnbs8HlLWlVGENeQYuzeRA7r?=
 =?us-ascii?Q?VRyk4ZAHi8NPKNfe3kID8mLU+8H9l5FMtin8CU4SclBNSsmBtoB4TN3EEn6W?=
 =?us-ascii?Q?19V7umeZ72CBtYLoiup6vG4YuCBghSf8NKCB8J4YsQqvs7kB9ysUyt0QEsCc?=
 =?us-ascii?Q?/0trG3ANVKta1SsX1BTwfVNu9KzW3atmB6XFfNsLB29rrCY50zNVm+JpeIXl?=
 =?us-ascii?Q?10NJrO7QAZFExRqbeWxaMtkE1r8lKp1bibvJlx7vRIgwGfV94dvO3mlPNxf3?=
 =?us-ascii?Q?SyN/PZmw4NIbqY0a7SV7E3jJwSHaLgJQuyXyltxTM+3b0+MQ8oes/OmIWrAo?=
 =?us-ascii?Q?jQEGlVxEMikkgQkO27SRd1q5yoXcWn0b2qecuQJYTrfqawYxf3xNC6AoPQqQ?=
 =?us-ascii?Q?anzcbVJpWEauBoJT8EUgDqqJW9WDjmT7rQiVPIW4qCJFjxnhz4xMhCGoHYsp?=
 =?us-ascii?Q?MxQXmXBPH4bQQZWBUjLy7m5k+aCN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EOnz4J3fHB8qzUN7abez+7hz05CLFjZqHPXHesCx/DUjfJymLz4fQVQbvsxL?=
 =?us-ascii?Q?EKtNpT5fC8bdxdzQ4dThIEO8nx4C+JuOjYsO/YweQDZsciAstpfPXHo6K/bK?=
 =?us-ascii?Q?+ayCi9qNU80Z7sV6zA19bKoZguxm9XPfQBGegngWF0GQEDiInvYsw8nZVzbC?=
 =?us-ascii?Q?GdOzQ7/OnSjvhvzLN4wv0g5w5MPzFXWTrFa6hniJQx/M8XX3pT/+DZxQl3jW?=
 =?us-ascii?Q?gLasl20WnSFASbRhqkiMLmSnYBhU0GPUPiGl26v4pQvi522n+cs5fHPqcV5/?=
 =?us-ascii?Q?DSVGSP1PRY+lbjXbGnRdhm6CMa0PnmN+wKVar3i2YOwZWEkmIrig5KbzCZJp?=
 =?us-ascii?Q?rZZ5eIL9FqBGx51+yJSpoYjv5YYxxf5WqW2AxpfKQERVUxzK1wTokQm6i1Dy?=
 =?us-ascii?Q?FDY8oWYYaLSXKXMRw3dMDoUjaFqJJdOnXBIv6Ej6CkyvwQqputBthRCmqELC?=
 =?us-ascii?Q?KNBFK3w8XpfLLI0qr3mNVaT3gt4Gi8QLYtreeLlQPQtBezwhtGOaIDl63JEb?=
 =?us-ascii?Q?2AuwOffKS/7Z5RQ29+SQYJ3dsyNWvEqfVG80mchn5IBdwowndA6v6n36GS/t?=
 =?us-ascii?Q?6b9rZTGyZQOOes/K5ieTOOHTSlxrbzYqmHb8PvtavQubF3r7VVntWWMWrHHj?=
 =?us-ascii?Q?dPSjbzdwoaBSEukV/7YNeTRcBzB61DRDtgwNMsTF0wuxL6fUU0SNurOPr9Cj?=
 =?us-ascii?Q?+fcElKi02rHxeqEMTM8tB56bfWyGpB/1k9hrTUV63ehCdtYqPlIpghLX83Wk?=
 =?us-ascii?Q?/aXq+BCAW9/nwXgMQacqMQOUOopmalnN1ErstzDFBiR+vuHe35QlBqvQbKfA?=
 =?us-ascii?Q?PlTVM1SDO9yw+/L5fL8ccQ7CQ9x0L2t4IZ5tyDlvOozpPV6dH524EIslEiEq?=
 =?us-ascii?Q?rnu9HRvcoza4D26qQe8KtKlONHnXqqSNSlmoNMV4Nlw6BCbV9Vll3o97HJZm?=
 =?us-ascii?Q?QS3vff4xsZWZLU5+tJznH18Fyw0RXenLesXO/PnDk7Yq+j6IXj3ECYHyK92N?=
 =?us-ascii?Q?n6aN/2XXLgzjyvsS76n4HJFhqWNQcL5d1BKVBli4l33L+cK5ag8Ylafv5/bM?=
 =?us-ascii?Q?vUMfD+Kt40oBWBv3jk7LQeik7t42HkNpsQodXDw2wsOSYOypdLjQpPUvBE7I?=
 =?us-ascii?Q?o2/EZugBXznV0vsIS5SC3eoPP3Bi3ukFcFf7mkt4BLTzwaBHMdnCu11ZQHk4?=
 =?us-ascii?Q?jaLd3kVwKx5CdR7leT26E2XXA4WBPhuTny8tU8HAU7pGIug8DYGCXAWf6MZZ?=
 =?us-ascii?Q?ETmWY7KNwm41Qkuyyd2Ao8PeU9tVIuCkTNLga07aMwSzP3ZIN74qiVPLIcM5?=
 =?us-ascii?Q?lCx/4PqJOd6CaLL2I7KCM4HLwKJB3kKHy+xA1jSujocuOfSErBCioON88y95?=
 =?us-ascii?Q?YmLpajOgNWpIlgj9/wXZPw7yoZjc5kOwzyi1WYAYfpkzrv/M7nPV0uNkY2Ph?=
 =?us-ascii?Q?PDqf4escEcwtqczLrXunWtg77xKgsh4PD4bnrp1Sy1Ymo45uoutryMgYdKB+?=
 =?us-ascii?Q?BRY/hs4MrYH7FGXVDHDelcxfKvW/IoAodoCylsnR4M2vjDbOdRaE7WGu9+Y3?=
 =?us-ascii?Q?J2r+l1ChMThlJhdxeeVGt7ohlB0+wdUjyh39Y227/RWxQq19bhjv+IRiyfnA?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b17a66-261e-4603-3129-08dd3ccb0752
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 23:01:25.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI6+k9Oo9/XVyAg5XJ0noFQrZTkhCUqsDXYSagJMMVbbohupdwdHL90q75W1+9ITvAi9wsT26erJoNJIHXwPz6eZHGbxzgZvCN5W4gn/aUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER enum must be set to 0.
> ---
>  drivers/cxl/core/features.c  | 92 ++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h       | 32 +++++++++++++
>  tools/testing/cxl/test/mem.c |  1 +
>  3 files changed, 125 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ab9386b53a95..932e82b52f90 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -171,3 +171,95 @@ size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
>  	return data_rcvd_size;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
> +
> +/*
> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
> + * available in the mailbox for storing the actual feature data so that
> + * the feature data transfer would work as expected.
> + */
> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
> +int cxl_set_feature(struct cxl_features *features,
> +		    const uuid_t feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u32 feat_flag, u16 offset, u16 *return_code)
> +{
> +	struct cxl_memdev_set_feat_pi {
> +		struct cxl_mbox_set_feat_hdr hdr;
> +		u8 feat_data[];
> +	}  __packed;
> +	size_t data_in_size, data_sent_size = 0;
> +	struct cxl_features_state *cfs;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mailbox *cxl_mbox;
> +	size_t hdr_size;
> +	int rc = 0;
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +
> +	cfs = dev_get_drvdata(&features->dev);
> +	if (!cfs)
> +		return -EOPNOTSUPP;
> +
> +	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_SET_FEATURE))
> +		return -EOPNOTSUPP;

Similar boilerplate removal and function signature feedback as the last patch.

> +
> +	cxl_mbox = features->cxl_mbox;
> +
> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
> +					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);

Unless you know for a fact that @pi will always be fully overwritten, I
would kzalloc() just to be safe.

Other than that this looks ok to me.
[..]
