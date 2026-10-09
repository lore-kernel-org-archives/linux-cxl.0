Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27D3CA499
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585586; cv=fail; b=D0BaIxS0o4OmyInOBdUZ1k+ISBSRgnzIKKiK8BCsFYiyrMgyaK4bz1sSG4WkMDkrroP8LTI/GfnJVzBDIs9HXcykfvWNh8IPNpgxjPBpMRMA8IdnwU+QWT68AXagLJ0YiGTO3uLoobm7vImKGKb2Pkxymu+F/wEhsiWRp3rBhG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585586; c=relaxed/simple;
	bh=KrYJheyPjJBj2uWWn7qF6E9y+S9gClplpWpYt8l+PfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GXxFI5F50GinF0jbQLxGvfOohaoQ4xQcXxk7vfZDhqHHvjCTVAn8JpkXjydMjBLjQPpzePILKIAu/xDXQRCVEHsIXbZNFJlV5mzK1iUnG+jhxw4YSDWAWBUGrA436/zO7NgbX17ivUBmO4c6CfIhX+BRbUjttsGwJrJCZz08lCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GN+kc/rU; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GN+kc/rU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791585585; x=1823121585;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KrYJheyPjJBj2uWWn7qF6E9y+S9gClplpWpYt8l+PfU=;
  b=GN+kc/rU5NNwoVleRuiBwqBjkI86HcNGXe62PdUuQj5/ncCby22BghKV
   QjMkN4o2UhfwuAb7LtD3qaUbBamKHjg/+cV3vw6FxpvJEZqekbr6AJIdX
   c1LcBLU93Q8WxL3XHQFC9nq9C8rYRCjtRmELBWGV5jzA9hVZ4QeiRRw60
   zKUL4qZGW3r1e1GrkVDfptfuwSVdFrG7isDJt2lHneYyHvYYjUjKC3t5I
   V4hkZRxGC7k5+FnDWMN4P51G06qND9BrLLy/oqdJjVWz/L8+PZx2QncA8
   VuRBKPRoPBgImnmTdzuCdBMDFnRFdGF5FNvgerjU2i7Wz9jmzclzmPiTJ
   g==;
X-CSE-ConnectionGUID: gcAvAx2tToyz9jeEM1wJyA==
X-CSE-MsgGUID: EgZRBd2PQmSjOYXt6k+b0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="392964"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="392964"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:39:44 -0700
X-CSE-ConnectionGUID: MOQSE7IfT0qMq3iPhTQ3Hw==
X-CSE-MsgGUID: RymnqO2MQDiw126tEjImGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="344796"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:39:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:39:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 15:39:44 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 15:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZcV95oxLnIomwxg5VjmCeLKjOqkg0/TPKKHjf9NHczxYT96BqsWEO7mXiqe8h/hbmf66lJ+wNNwMCaxeOJNfkTVo84ovPacoqWKbQbNUCl4IZIJ6rpRC7ftxO/uaW9nPnvIbK35wun0VZ2EauKloM2oKrVrJxol0SJxfVo+EyBTqSyxtC+WKKYm+czgFTPE6ZuJlEmGar82G/Jf2FUFYd/59BIcXWt8WsFdsCrQ2hWTK9X8JHKEOypG5X+bCo6581KjM9j1w159xWRxYDL9GUwQSHLJ2+wdv9GHTLWYMeUokJI3sOvuBxL7NY3gG/swl/gKB+edtLTsq+JtzStWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7syS261kQpxnHVPUgujPSexsWxRFOnOxDuQPITPD4CU=;
 b=u8SHZVJowHdzXbufDrJqyKYhcbPbDk6hMBg+JsI9s9xJsYZQm3jbOPiWMtITUYRRdQOArV3f7kHMs08kYSzmDVjiZKrqNZgAfQjkILWCN6W/o+E3AajIuUv1WZlTS+X9YoW/msVl2lFkY4TrJzozDPBho0la+c+Kpj8SNqPIU2I0j4gpUPZvFivK8aF8aykvDSDJgWkvJOAwc2/Jb1v5pOxY0SlN9aXNcUpvvgTa6GfYJq6GcuA+CRxC5DCVcJFpWZjR3BzKNi5g0EHqzspT+r7xURasziy30QWGXyiIz7DHlW3I+n4f6qH+t7OlH9F7/0wekpvbnDO8h0DfbSbhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFCA4893B55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:39:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 22:39:42 +0000
Date: Fri, 9 Oct 2026 15:39:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] tools/testing/cxl: Skip the auto region when no
 volatile window is active
Message-ID: <asltK0wWLcLGlPny@aschofie-mobl2.lan>
References: <cover.1791582353.git.alison.schofield@intel.com>
 <08e082b7f77318f295fe700b2ec917e0e0815c08.1791582353.git.alison.schofield@intel.com>
 <sashiko-outbox-166129@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-166129@kernel.org>
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFCA4893B55:EE_
X-MS-Office365-Filtering-Correlation-Id: e24def10-251c-44a2-4518-08df2656359b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|10067099003|22082099003|11063799006|4143699003|260925021911599003|260925022911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: Wh1VXYXVZX3tcv6aZo8rpCy9QMcppF11turUFYbKGrSnTaxl0kN+GoFhpPACFHHS20dPLeLNf9WlKeLR3G9RKZZ1uPRZVD+3SjKys9YqnKQnUEZnlCU2vd1OQk+JKhxLesnuuBoITuBx6WnMkVCzswTdXZ7xic0CRfzAzDcQ0ESb8M9upwPi/Rb/X1KqEqauk1u2SLL+gtf+YmF6Xuy84u+NLc7oObjO+7iD986TDV3WhvTNuHZ8khoKvq3UD/8fTdTHD1kOYXiMGAZ2zKx6Ybo8iTxfbV/AVtRIjBlW0jbYH6PfDPMkMriyP5gZjr5pgfy0tR1hC2r8ENg3JxM7to5FTwi7KWTvLWwQued3UD6Y5D45s4wKa+zinBrwnYqAmCf6FNhNHappAD0l/4DXYduxkgu9qBXQ/FFJfP1EAyA1LmmIkiDBLQbEacUhAW68g7+k6LcH++l3iQVk8+PbKI6QFtWTisij5pvsMklX5taUoFtVeE8fj+yJ5249z4E4Mc818IVt+jIgsnrUC43BUUYhTYiTB69CfT+gFs+laFb/ASHw6ZzZQMnK6I2VSzxrZSS1u3nps2CaSjw4Uzt5oDzWxfo4gIC9zeyWGWJE684=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IScsy6sMhPkn+B9OvvsRzrKl+vJFsV2WplLk+z/j6fksTFU1eUgkuSP9Rz?=
 =?iso-8859-1?Q?YSQhOytw08yOxHHoVZue5S4x8B/gQR6+qetVjAG/dXyX54TropNoxZTEvz?=
 =?iso-8859-1?Q?2KVvnRmFo6Omomcdv9dJd+RieK7xu/RIVUSzig7bWiul+TNj7P/7++OQcO?=
 =?iso-8859-1?Q?VEd6I+hoyevQK7Syb9ph0SGM2rLSXUJm3Al/9b5Fw8aH2q+WD/11UkwqoT?=
 =?iso-8859-1?Q?BKghvZqJNKdEo1WrPyb6jiWl63tb5CH+m0O4Giu7RGF9vocoMk7J/CXT/T?=
 =?iso-8859-1?Q?i2wg2+/nRSuOTMBo2TvhNF8ipvTwXn586f5wRblpeBEX9OUGTi09r+uG6J?=
 =?iso-8859-1?Q?sUNbsnlou2Ej0BoNcgtggnCuNwGAv6+NvOeDLei8plOI4y95SVHdghEhJm?=
 =?iso-8859-1?Q?MOwpPgDG2d2mjTGK8iwkqrMqDpSslUymlEkgf94zOvX8MxcyXAgakgGgpE?=
 =?iso-8859-1?Q?axeoRxG+Lbn1kgbkd/lQWg56TxgmoGMho5H775DvcHB1JUyJZa/9+ZNJHu?=
 =?iso-8859-1?Q?1FgOMmvDO64so/EMGvDeVs4C/cEY3XYNqCQkxdvb8MENshrszGe3Dy53nh?=
 =?iso-8859-1?Q?4bwBkjY/pc+04KaxPRv7vuyDhJMPDejnZlxuUkiHfUu/Sp+ffu1Sd1DKGt?=
 =?iso-8859-1?Q?OpPfjB61hhtUFFqr+kMwT1mOBf+PEyem6dKdRKqaw0Ksu2NcIrsaUxNU1O?=
 =?iso-8859-1?Q?qRUu5ytGfb9dWqslxlJxLJtNree4trdrIm+ng2VqTMFYfNLPzuxEIzyfw8?=
 =?iso-8859-1?Q?cfDQKof3Ct+oyvOEdeG+ngJ48fIuU+Xk74MtkIA8Xs6DFh9OHO0JsRaX1Q?=
 =?iso-8859-1?Q?Rn5Ch/0S4B1QyGa69qOeXiQJNGdSnqRhjYgTV9gbs2mIqpGpVcWJtcduwt?=
 =?iso-8859-1?Q?D1a+Hli8I6wO2KuNPN8YAPM7SUyL0+by2bgBrvvVJU+SGeQop8ELnObHry?=
 =?iso-8859-1?Q?YtLI33bud1jI+M6Pm5Cq4473EwuyhL+uZjOmB2Q2DGr8xKlBZ/lEPQtfIK?=
 =?iso-8859-1?Q?TPef2JAAYhlXypki07mRaeNWYITyXb2KAoBgZ2jg/6uyDxld/GR/HvSlKC?=
 =?iso-8859-1?Q?Ia6yZjRg04xxfdS7BlDh9JgvEiYiCGjGXBqaYO13hT0QubB2lEyuRmjXKd?=
 =?iso-8859-1?Q?F6Z7tlOkaEYxbbWUgUJcDRI6Si8uxu/66hfckzz4j7MLrel6ARf+OnJGXn?=
 =?iso-8859-1?Q?4ePSDIfg47JoUA1t2gqzf6chaHfIsk7OgtH6Z7TVNzjMG+aOFYCppO0rcF?=
 =?iso-8859-1?Q?TvWKorEY3XB3HbS/UdYjeKoXVo3/W8ooFKNukBu/W5Y+ucr3XDctQUi1CY?=
 =?iso-8859-1?Q?02VsXdSvbaDdGQ/r6wPbfZHH9DouNfNof+EAlCd9NP/rouN0kgUNLVEpka?=
 =?iso-8859-1?Q?ZB4fpstESsPtKKxljc/K5L6rorLyeX6gD5T9dwlK7lNIYgoU3eUSAf47gh?=
 =?iso-8859-1?Q?x1RRFDR5Q3Bo0VrCC9SwOHu5vVskPFp/qFa7SgORacfr9sacfhmjdxQnOL?=
 =?iso-8859-1?Q?jVCJ+HDpJPR/Jt3RbYz5LGKXme+llilGXeDvhK3E4e9KkjJIiRNL58Ga9B?=
 =?iso-8859-1?Q?4kmtjriHZbUbvHyDtS/FMXU2C7yWIFSStGmLZZPaEok7JdhQxDYR/hYZXK?=
 =?iso-8859-1?Q?q6u1QI8vFeaeuMhD476YI37x1HZxdkeslX2beosbMpYkUm3FRc3nkZ8Dm9?=
 =?iso-8859-1?Q?hoMq5GEysOBiwJJWCZmQN0IgwsddtDmfWvuXslK/zNusfZW3B/BKUVNAl+?=
 =?iso-8859-1?Q?jv9tvq7DElgc68U85XPFIUxnQ85YfWAXKyXjBXDn+BSnCIIjiRn6OfFbNV?=
 =?iso-8859-1?Q?bWj/Xrd9KGr1Jj1sFx2Rz4JBgSerirg=3D?=
X-Exchange-RoutingPolicyChecked: VTZb1MLG0Tl9NmFxu/gnTl9g1CNSzGAyRI0Mth9I181hO1veU5koLz5kz7XlkVK2tATNS6ySVkDvmdrwhe/U5V6r0+dfGxWeumJv9yNlyw4aS6QU+wCuBeeW7KGLrzdeWcTMPWG55QiGeBknAid+CEXy4KqT3uICyvzaGf+FIhyl8TAJhiqGuP+5bIi7tXYTKifpwCJbw25twN7H/215+wQjFAa31ZusYdfkFxpxTEsNBQrVvfVEo1ERe+yLSx0ZKW840v3Fn28I2peMVFsFO52jhlJjFeGb4Pq98qIm+MAtsys9+JGZDRtNLo/8VaCDmgQixSACifF4sbvuR/K9dA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e24def10-251c-44a2-4518-08df2656359b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:39:41.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBRXbQYGs8/omnfZDfVIoMJ0k21Qmsv46R2w5AyM8YTkyqHvCnAJ9yBzyw2auXrMmDpS3/f3ua+pSVvSIwgNK8h2LoG/eZ52xIcygWqOp24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCA4893B55
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 10:24:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] cxl_test: mock HMEM and region APIs still hardcode inactive mock_cfmws[0]

not an issue

snip

> [Severity: Medium]
> With this patch introducing `mock_auto_region_cfmws()` and removing the
> hardcoded `mock_cfmws[0]` here, should the mock HMEM and region APIs also be
> updated to use the dynamic window?
> 
> Looking at `mock_walk_hmem_resources()`, `mock_region_intersects()`, and
> `mock_region_intersects_soft_reserve()`, they all still unconditionally
> reference `mock_cfmws[0]`:
> 
> tools/testing/cxl/test/cxl.c:mock_walk_hmem_resources() {
> 	struct acpi_cedt_cfmws *cfmws = mock_cfmws[0];
> 	struct resource window =
> 		DEFINE_RES_MEM(cfmws->base_hpa, cfmws->window_size / 2);
>     ...
> }
> 
> If `interleave_arithmetic=1` (XOR tests) is active, `mock_cfmws[0]` is inactive
> and its HPA base is left as 0. Will these functions falsely report soft-reserved
> memory and CXL intersections at HPA 0 instead of the real volatile window?

No. These mocks only serve the hmem_test configuration, and cxl_test_init() refuses 
more than one mode parameter, so interleave_arithmetic=1 and hmem_test=1 can't be 
loaded together.

- mock_walk_hmem_resources() is only reached for hmem_platform.1, which is only 
registered when hmem_test=1.

- mock_region_intersects{,_soft_reserve}() are only called from dax_hmem on resources 
from that walk, and fall back to the real helpers on a miss.

They are tied to cfmws0 on purpose because that window is the hmem fixture. Patch 2
only changes the auto-region decoders because they are the only cfmws0 users that
run in XOR mode.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1791582353.git.alison.schofield@intel.com?part=2
