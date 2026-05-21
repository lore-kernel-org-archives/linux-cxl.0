Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AD395AE6;
	Thu, 21 May 2026 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348340; cv=fail; b=K0aPdsyRWqnKScruSSJwZE+9EsVhnuG3sputlVtvCrv5+QtFLymP8NYsnGjmuQTdy0aVO+c76IBrrUfET2aSXOSKozB4Tahb2cU9SMXAz1/eX1YChYblVFt5gdVFedg6G0r5wvE+SkfnlBBtScfvmZtMFwvWqho3z9SCCNWsJCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348340; c=relaxed/simple;
	bh=WDUVwM7Cpro1tUYdPIpl0ytbmMnIVfyfUJGDh8gYG24=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qa3DHOlU4455nCJfeCRRKcdkTIQzp83xw8tJOleBQj9lU0EHL2NLfsld9BJ3DcrnzpL5mjvOIHQn6WKCKXPm6G1hpeLUaTTZ1n2tU0NqTE7o6rOVY0u2v6tkp0qD1r62KPqpso5xWs5oj7KjX+e2aCQpm0GbjQ3dU/BzhQvCYB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbOjUBZj; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbOjUBZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779348339; x=1810884339;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WDUVwM7Cpro1tUYdPIpl0ytbmMnIVfyfUJGDh8gYG24=;
  b=hbOjUBZjqtPzh5hDbTR/Q2GUQLLgsEYLYtJr05bkIjuO3DviNa8hzcxn
   YJd1nJs5F59s8v+AHG86zWzR2BIip3HUZlpa0aBPnQc8FxKp1W1QoIdqT
   zsTJXupI16WW1BTqvUj1vblOyE3HrSf74iSa5cciKqCHpZaNVMsy2K/tJ
   6hqmz7OJXh1TjhS3IM9YqMwdHB6DW+yHm7JmPMSJWGgUlcIqh07NuVkd6
   7fVnlasLcd80weMzcXsnGMJUfmz9OiosuOGxcOFvF7e2YbyumJDB4fwN+
   mkiqiV7F9g75ozekox85SGDbL6e/HTIEqqaMIXTL/VFJsVVa7VLQ7vEVz
   g==;
X-CSE-ConnectionGUID: yRhPyftvSTCGUQ4sqMwxNQ==
X-CSE-MsgGUID: RulCxrzZRaCP7enI+2rk3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80294091"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80294091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:25:38 -0700
X-CSE-ConnectionGUID: iI+3NikcTOqVFql+Jvg7vg==
X-CSE-MsgGUID: wtT84RY3SC+3n4Xt9uFSSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="245442994"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 00:25:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:25:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 00:25:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcHxxtNsTjsg0svS9u4NqMfDPpkjK3XkBhd+dDEDpsv4FoPP6bnB5A0ue3ySao8BLzMl/pDWWpExNuc/Cv1GE8Lr25mw+/MRcfWctm1p2W+5uVVqmi1lsitV7nV7fOcyZ8zEDaoljciP88a3pdUr1Zfx9Sd9/zGJXbbnSEg0i2/r3+nuK8g7UUbvPbifqSvr/itY1dusquZrqTxAezuA456zk28TqWZDFzePq6aA4mTjLxmKWQkRwYvujVy9UzLWtrKT578p5d7a2HE0UEOXiMe+vBk1arniW7QX3Bp93SvZ3ZL6pSYKW0YnwInXVADvZAQCoEIEB+lqtwwz1O+XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwF8MwnJWGH6jdGgDrvmVLU7URQIWB+1htlwwwDUVW4=;
 b=aR1+F4tBbBb50m3dS5G7Efke4gkvX4AV4ZgBeTmEEDJpZ8xhqA6L1+vL98UHem8cHhHdKTb8u9siH6vMeBZGDBccV5whKdXgLf1uStdSbdGpmVyDOiiw8EWpHnjF9tlqmjd/hhVhMZf7nJil/nuOx7ENF1mU2hhtW1tAwhrDLZVVX1rZsIRBngJzvE9QHJGLi4lcyuM12orhkdzTDxl5BjGWP8mVNGIDAIqJY2f/TXovVyxOJsCbGGP0YPpCus2ooyL6claApBJk5ec3hTUiJryMj6lmGivOiJCxVtEuZf2L3duiNwg+xl9dodWm3OQni7pm6cabYLSzgi8sDAf6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 07:25:36 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 07:25:35 +0000
Date: Thu, 21 May 2026 00:25:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] cxl/test: Update mock dev array before calling
 platform_device_add()
Message-ID: <ag6zbJFdvxkf6Q9I@aschofie-mobl2.lan>
References: <20260520121457.234404-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520121457.234404-1-ming.li@zohomail.com>
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ff32d3-c7d4-4340-a2c7-08deb70a268e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: fJBerkqPx+9EAIFMKccZcLd1l1SAgKASzz2ye0eU+PI7sW/eVFLv41pWqvw4d9tNcQ9zJXrZV1Vqxf0cNAt8EnUTL3tzByo1rcmCySvHlg8SnugfJCucCx2IHqQSkNRCKTmJj7gaV7lkZ5zFUwWm2hHuLtUm/STi0qCpvbOmmk7Py8c5x89MQRCezkCRA5U7CigB1K62RdPPOE4G/HlQuQrdvAKNgecgm8qxnb0lob4i7ImbxngS/usHquztGnRN539EM8H/47G1EAzj/PsuDIoW0K5CxzH60FVB2wV8PhMx6khBmf+PZb7FCQajFhvDG960gh1tt4wtdG3OZsT2V0QvEQQSoOHNJPApmGS/cp1RXqTaaQRlqvQ9YCA2rlJoYhR6agWJ7w7t0x+k/V3FmJsz4Lnb8K0RhJ/NjhPqvzyaC0l9WVZaWLPXCNfl+1lG4sXMYKLXW7OV9DQ0iyVgbf6b1GRIdVj9LjigoZ+Dsn7n3J71YYIQlcSYrlSala+gPOBEIW1BTtqnbaNO6gJ/TOw+R9J1eSYZxOof7olNMjZscxGE7/ZRzsmyErSLFrAqvoGMGQVVlXRvrCRa+cgqeCLI45LpUaoQH47Xdr6FgwPPoKHYZpoWfDibuXKLlCtsWwE4hxA2zbOiiL4QB4DeG7m6Cdu5CP1Mbw2P0Q098H5ZVyoO+uveyDV5fj5E8N0J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?doHyRnDPHQu+sZ+sVLZrxzQbOA2NOk4k9twN/uIqrdLEN/hE1OF2eSQHZ61D?=
 =?us-ascii?Q?Kpvla+ST0wcfohg5ppCW8gd2bg8soj+DR1V04i0jMXVyNP/vdnU6oAzbxZdv?=
 =?us-ascii?Q?Xj++7d0KdjZxWmTMzHsQ2x9slBXj+al6q4IER4cToeoORi2u4JDDnSZW/fYf?=
 =?us-ascii?Q?AE5Uf8vnOcNwnWBISN3w190n+ki54IEkbqIksJiLDtzopIecjIGvmP6iROaf?=
 =?us-ascii?Q?8wlbBraA/hvcDxUqDXPQs4ylZ+Bjgzjj0RsPkVzFx18GSx8DWszW5/1ZfV6c?=
 =?us-ascii?Q?ijC+AjrAJijJLRtmqKLJsxe/jeJgbQFKA+wCuhpP9BNIu8q0urgJzBltKanQ?=
 =?us-ascii?Q?7lv/nR0QCLAkOrPRJDKw+4Fs8lwTK6nM1SweA9RQ8pT11xzOWkmZdA1WTjCG?=
 =?us-ascii?Q?9WmqeqIAkWRgIxtuJHqzR3ygS22NNKoNiZPUrti8Z7JWaa+TS/YjKqCK0hPu?=
 =?us-ascii?Q?e9Xbb4rBTvDJtc7IAAaIdXlmMs24ze3rd6BE0iuQW4VsSy8BlTWwEJgV88Yb?=
 =?us-ascii?Q?NPu1ORhNktQwOdkHfxKC85PkWFh8c7wZ88ACAyi2RzEEWRvEewlMZJdMHLQH?=
 =?us-ascii?Q?d8TqgSGInj6sxcn18gnQxHsBoY87C5GmaIwsiSwnjWIj4UYVA5c9qJWkyckn?=
 =?us-ascii?Q?/qo3tnBmT5vD9RFnmOCYQ3CSbgLgT8QmTd3dsvLzHsBXDK+KL+PvR60xfXOZ?=
 =?us-ascii?Q?r0yu+7qFVtaeBcNaTFY16HMlHcUDq0WIRklCW0FSH40FdVFYJIfUtIuVlLxL?=
 =?us-ascii?Q?UVJVGOVCqPbm+aODjON5hQn2sbjJbIBccegGWNp+wK4MhpzyiCst23rj4glP?=
 =?us-ascii?Q?fc7sgXwnKZ0Rsw41BYnaZ9gA1HLgS2MCnId9iZhE1E7KwYtXZcnjlKnLXpu6?=
 =?us-ascii?Q?Nry9uEKR37CmAKdDszMlIrdk1IStwZaVW2m1SF771qEwDJmgW9pnd5/sH/wi?=
 =?us-ascii?Q?2Y05q7AJw4W6EfmbtEtx5gUAh7F3llJtcHh5qLRL+1DqzilCrsvwYJBsKn//?=
 =?us-ascii?Q?TnU8tsENsM8NUI1mILStqc3IyRYHYrhNmHfFTXJV7iVSW6QiJYMUAgA5aevW?=
 =?us-ascii?Q?7c0FnLp6YtPb/QLME8imnufRL6v9Kipt0BabwHqBlVEU97H0KCdvqy4Z9YZ6?=
 =?us-ascii?Q?cG7U5yfkcYV7ZxNoSLofdb2UHn357Q2qrXrrbBEr5pgNdgJDc1Zp3h0SwQTH?=
 =?us-ascii?Q?jSoubZS5pzw/fxgRjYl75dDTi7xKGwlcvVLsksUgfpxj+JyUqvWj4CpzlUjV?=
 =?us-ascii?Q?Zz3F6SM8SN5RQ95Dylz5OOH1NZLEad511A4WF8vV2kFcWfOV5aM1neZZV7by?=
 =?us-ascii?Q?ZkYyqEF5whJ4uHzpCkQ955wSmdqVhvvkosVFOjplaJX15enai/1pcUADFgFM?=
 =?us-ascii?Q?vp7YPfgl6k7H/ns8ApYknqutx2VVGz6llGhV6ojsaJgJEvA7zjkEAM8xpPVj?=
 =?us-ascii?Q?O+ubcNMR/Vh3C5142AV6Q5lXIzBeIdfvI/6bbezSbTdmzuZWLcgz03lzvbf+?=
 =?us-ascii?Q?DIXl9d9gaqZuyISZXPzsBF2mjMyl15J17EkonUNXm0hEofN1PD696Vue4XVB?=
 =?us-ascii?Q?qcTP0ojrhoZUx45pcKb0vgD+Vb1Vuf0Zfu7WzO4Lu/aB1lV3gd9/MeHjQpJV?=
 =?us-ascii?Q?5t02YYEKozbVL5HxDF51xUoRf/LLeVtbv3u6NJ1P63TAlF607fCwS/85C2Yg?=
 =?us-ascii?Q?/s5jldTKxF8uIVkfNROChhVY8ez3xgeskVxbN31BWpqB3EaefMtWO7p7W3Wh?=
 =?us-ascii?Q?WC3cEyKKEb0qjpHT0Pq+ABysWacWoIE=3D?=
X-Exchange-RoutingPolicyChecked: mG83S5qx/u7ybviCLow5wiRD07depsSvXtigDNjUC61RuLmtcqSuu8+HaXV1F2mYjuTImR1e66y88s9xeK4qrzvxKuEg5GqrDBsckZMFT04fw5Ev3O5DhpMp/524EeFzVvmKslrA2DJjwHY/gV76Bu4AGk9uXO+AgZUrzubG30cHw23MqYDuSiJxhFQS5jolcDT2532pmPrGFg4xISzk5cnP2vuiD7+egeGdUcTciWvDBzRqLAHzjUtTKc6KA0FLnJoICf8DVtFORZ6ha8Mj9HzWKbeCm62dsJn6dD32AVqVp2nBDSEJu4TASqmwMK1qYg+4EkVmXVUQJPVFah7kgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ff32d3-c7d4-4340-a2c7-08deb70a268e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:25:35.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGtbvCQnerX4up0KPtjYlNdwkm+4jOEbJnbZGNseHd49LPaBoC4JGN/tNrqtX0fwv8Bpr95cymlninEGvaH51XS62ZyXaKBn8W5ZY7SLonM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com

On Wed, May 20, 2026 at 08:14:57PM +0800, Li Ming wrote:
> CXL test environment hits the following error sometimes.
> 
>  cxl_mem mem9: endpoint7 failed probe
> 
> All mock memdevs are platform firmware devices added by cxl_test module,
> and cxl_test module also provides a platform device driver for them to
> create a memdev device to CXL subsystem. cxl_test module uses
> cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
> CXL drivers calls registered mock functions for a mock memdev by
> checking if a given memdev is in these arrays.
> 
> When cxl_test module adds these mock memdevs, it always calls
> platform_device_add() before adding them to a suitable mock memdev
> array. However, there is a small window where CXL drivers calls mock
> function for a added memdev before it added to a mock memdev array. In
> above case, cxl endpoint driver considers a added memdev was not a mock
> memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
> than mock_endpoint_decoders_setup().
> 
> An appropriate solution is that adding a new mock device to a mock
> device array before calling platform_device_add() for it. It can
> guarantee the new mock device is visible to CXL subsystem.
> 
> This patch introduces a new helped called cxl_mock_platform_device_add()
> to handle the issue, and uses the function for all mock devices addition.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative to real-world systems")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> Changes from v1:
> - Rebase to v7.1-rc4.
> - Introduce a new helper to handle the issue. (Alison)
> - Use new helper for all mock device addition.
> ---
>  tools/testing/cxl/test/cxl.c | 105 ++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 62 deletions(-)
> 

