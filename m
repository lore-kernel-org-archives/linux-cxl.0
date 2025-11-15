Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493A128819
	for <linux-cxl@vger.kernel.org>; Sat, 15 Nov 2025 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175636; cv=fail; b=Ihtr92yIC6F+cKUWNSX61HSTxabBhmrkf1ECcxT8jQXc519KSiTjZFprxV3RnIDNlyLcVgjJJ8RGO0gtUYLOSkWvOZZmmKsnt6/ffR8/r1IJrbY4WBcyyiKXX/lp1yQT4npZJbKhn/+H3607BcxFhpScliRxMFEE4sI/Hy7qLuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175636; c=relaxed/simple;
	bh=0tMxqtBTc8s0AVFgYqyEnbQKDPJ/tQF4PhRMDTrahic=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPhWILwGV5Xv61X/45GNAVl8IqUTa/g94CbZYZjFfuLG0WeUOeMYZRxQOZC/1XS+iCetbFLN15amUl9pGXfbQ6U/H0jGJqvwhoR9K0tBEc2vkwZggVnR9nxv2PD0HGnZ4o0v1h206bk77QfR0QPi6i0sL9PmlgzjYmTVAngIIdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNtldhen; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNtldhen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763175634; x=1794711634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0tMxqtBTc8s0AVFgYqyEnbQKDPJ/tQF4PhRMDTrahic=;
  b=JNtldhen9u4a8WrsQLahLv5z6wl/nH6pLuVCjHsF4VdmmtK30g7ZGSV/
   T8MU6tPBKozDqwZCrZSmejnVJvJl68PZXxfuZU+xCnxCjo8mfnDqMuBFM
   tYkSXAOLM1k0CKbdc1syi2QBoB8sKMDjIYAHgn+NPQuyA7QiiXZ6ByASD
   YBA1VpHMWJ8kRsEs1WpEWOxnKY+I2e0c3bVB0YY4L4S33y8EG3BCAMA9E
   wMGP5Fjyo5RivumPD6HWiVxEEn0vHJezmsUgm9KS8DUO7zMJ/dzGSMqlW
   58iJ8hKRWSzcDv9ZsGCtYDenhb2OFjjagEJploRDu3J2e8WAQlDNT9952
   w==;
X-CSE-ConnectionGUID: MJwzDIRWS1OtnqqcBjWr4Q==
X-CSE-MsgGUID: R3Fr2TOZRmC7wbmB+tSpOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="69137677"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="69137677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 19:00:30 -0800
X-CSE-ConnectionGUID: OxrC+qYnRt+r05GFnoliDQ==
X-CSE-MsgGUID: iniKR3xAQ2ys2D4hWfxLPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="220585331"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 19:00:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 19:00:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 19:00:29 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 19:00:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sa8BbgIZgaFXf1G5BK27lRfrnuDFZaTm8iF1/bXaTgBPbPGbAUmwK7wWu9Eru0vMDnRA+1IVWbpgrrQIssiqzU/BYzsbdooSxzNajwX++0+7t++UKLv7T/OFrVtmrmlDzEl5NAlGPWmzRvY3+oz5kPtQOA/1/fQ6BG2zQ2vZkuXH3udtT2CXS6ilHRmbuXPn9wDfU6LrpXjmgHasvy0Vg9UK1BkJoObZkuqcFY27OKu+4ymnLqe2EbOkVKisyTFtC4w/GhBPjfFfQEqzXzvi8pYSf4d30exNnNqAm/B1v1KdQNXyPBhW97xub5LdSAdSkOBaderRBliq7Bn0527dNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tMxqtBTc8s0AVFgYqyEnbQKDPJ/tQF4PhRMDTrahic=;
 b=JRgrtKGvu77Z7dwl5TROwuVmVlePa1o1srZPFQoA9HFXBfMy8OUED9xHd8MIdNjBHyKHvS/TpRMYwIWdzXb82XL0PS4m6uLexkoCMVDtoDPdvgR82a1lVb8qqe2o2BwRqqFc/o2vQsgVQaIF3VHKvnlWdpazp4PYdcxn1RJ9oKUGe/loIjv9PQy7Kg6DRHjfX+vVarQK6E6FmIbmAU23i1UagfieqOd3CP+cCn8V2rDN8DhHieulgIlnwsDjmKahIQxprXUj9Z+tLfOyQxtg3o19vpx+FbLZFzAVIxU7bscTC32hymRtLNyxB6F+A5sYDP7QAIVSZ+aS/6d/2qBaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 03:00:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%6]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 03:00:28 +0000
Date: Fri, 14 Nov 2025 19:00:23 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/4] cxl/test: Add cxl_test CFMWS support for extended
 linear cache
Message-ID: <aRfsx3ea0cpF0bGc@aschofie-mobl2.lan>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
 <20251031173224.3537030-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031173224.3537030-3-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::41) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b14cb7-1b50-439d-87b9-08de23f32155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jLT9qkIIhpzlw6ZPspCfHF8TtGAaZ3ltASEvGJ5OMYQlZNIhz0RKejRB6ffD?=
 =?us-ascii?Q?731WIND6TD0BJM1buOLgZec6gzFGqRcFoSiXev82xWXHoLfMfMXxGAT+EJwp?=
 =?us-ascii?Q?qCecDUW8JIHT4w5/0cj7qHB3paPz/cQe8x153uPnkImbwBG0tXWEjCzTijhN?=
 =?us-ascii?Q?8SY6L4znmP03AFnvSdYG0SuXm8N57U3bIzEYMOlP+OCZZxOfVU7brzcYvvrX?=
 =?us-ascii?Q?KCZTytFhAwH/idBo66BnsGu9v539aiP1g5I1hUEkP2PLVNEF+DwDFb1NnOtI?=
 =?us-ascii?Q?0D1F0ufGq7vaOnKsuAoN1eqtlVfPjpj2GKXgie+ziYjF9xLCMG8JKU5HL0/q?=
 =?us-ascii?Q?jgJYKhWnXbUiNcaYbZAOpGSEEDsO7GJL9ZrFVjZ9rBBFqtcAfZetzVX66fQo?=
 =?us-ascii?Q?slfJG0YPjLinAFHTpiJdkuO9/DYteLL/8JE7SHmCzM9m1u2uy+X5rkEkvb7r?=
 =?us-ascii?Q?CgJ2MRS/uuAM7DWp2DzE2jGifAxnEaXooMnfTr2iCR3cYgHA6sD0fliSgK6q?=
 =?us-ascii?Q?CUHywftkpFm/NwgbUQO/BckDZH21sLJE9ixv2wgDqOenRkjeSL6H+gpm70jX?=
 =?us-ascii?Q?XgBvYaPYkM3ItC+ShwEFsSJXfq0ocUAqaHqZuzuQg2bk8oprRrcx1yktVAAJ?=
 =?us-ascii?Q?+4Yj/nlI4S44Xw1bR53OHtJGJlF0MeccZRPo2cgtep4OUaLXA0pgpWOCt2KA?=
 =?us-ascii?Q?AngL6QuZuIKZ6GR6gRkjdITa1MeMHyOSr4pR1j1GNb+wSBavbbnPAakCfSL6?=
 =?us-ascii?Q?4gvIlvLqcQMXGTmH7x5s2V3A5veI54CD+jHwH2ScoNwA5R2tySkGIppZEc0V?=
 =?us-ascii?Q?Y8qn8jjuTwNmLLl9UB/8LHkU8MP+j2qXlxL3XQP2/gx5HUD9J8gvcRdlAo14?=
 =?us-ascii?Q?sP1Bf8qRPZMPkRqBkNeoGm/M0gJ2QEyN5bi+U02RQPhdHSV01u7HZmQU8gMo?=
 =?us-ascii?Q?E69txRD06cSkPsvwA6rv+SoFC8Q39YufvBB/uNchlT/fxXf7t1Si/niHMqvG?=
 =?us-ascii?Q?OxUDzWjtpKNOqf8vYg+bAHTACJ3ZP4ehq6rpdeNYYcJ1YhlL3SYgWQL4ORfy?=
 =?us-ascii?Q?CXKep2LpOGizcEVMDE6/tREjqFuMvZtU4VB6KPzC1pbBhAxbKxKLecLZZREQ?=
 =?us-ascii?Q?uVa7RVxbIWCFbaYBQ1JyAzIO4QK9gJew+jEC8IH/TxmSdhrmcnRLwR9N7yl+?=
 =?us-ascii?Q?XxrUzrTvgZH+Lh+vL6XSnrbnJQQ7IAIJEp+pQjNDJ2BCQP18VfV691bZW4me?=
 =?us-ascii?Q?zId6u3297dSdziHjmYRnSsURSO+GGq+UuVC5XuWnR5LnnfiXhZ43NHrg6ckq?=
 =?us-ascii?Q?W17CiI3BWxm28aZsRNBkJauscyn4V4wVbqWcAcMCRI576aYcrMDgI2nNCtPX?=
 =?us-ascii?Q?vRzFJ30wavcJKHWlkwjvZ9ss4AePeRzgrqa4dR+PAV33/NqGMK0H1PUM58U0?=
 =?us-ascii?Q?iZPexQGzp0aMgWdi2CTWKxWvQSehQn9K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOt2iwsuITa9UwUUvv6RbplAd1JAcOCwPHZAQn90QyZfcUk6cyEKtSEIjtEb?=
 =?us-ascii?Q?zdoZVyKe451ixkeg5DzgvCrjYjfo+FJhkq9eL4l4kPQZoKXAU5Xk+tL5paDK?=
 =?us-ascii?Q?W//6voM4HUqMtXT5YMKVNbEMBhTdaSvQSwo6G8c3EXhGGcgJmwA2DjvKr54x?=
 =?us-ascii?Q?Jgt+SCjTksMpnACkXg1OVQ5MqaduJTiKbOZ2L/QUutxTmj3HHMooXbS8pwFr?=
 =?us-ascii?Q?nihcSzSLKz7WkQETCjPvZ4jZu7oy50h4MHe0wMS7R9Fbee6UpKo2Kloife/B?=
 =?us-ascii?Q?7IAuVVTM1Vpj/GhG2bBU136se5li7mziCx05sW1aF+kqYBXaJ/oUgamOwleJ?=
 =?us-ascii?Q?VvmiM68WD5dDthI4Bu/FDncVQVQsBRnqIPPYw13INWzFqkXDfjBzRWhb6yHm?=
 =?us-ascii?Q?23rgZmgA25hMACfrEdEt+/wU6Z/zxhJYXNdIAqLTo8xtbCAHnH9bjoN/TPs/?=
 =?us-ascii?Q?kSyHFclZtgD0cV6kSnLIcJcLXr537hmorPhfg6dFaX7FPdt/PkEw8cgphIMI?=
 =?us-ascii?Q?b+NlBvFlp+YExeb9pf4GjXP+VDpmVCM7WJsGeKjVIAaYu+gaV9w53RHxjsrU?=
 =?us-ascii?Q?Bvm8UY2UWGZC+9qw3iBOq8dSAJdmFRmBlDjEQQesy0ecdmbrOg5+G1mDuvVl?=
 =?us-ascii?Q?nDTEtEH0FmI2u+VY47IABK8n2egy+V/g1Q7mP6KHqbNSFFmBe5nyqVOiecqo?=
 =?us-ascii?Q?zbcBbhTbHEskoVw/HaTN/udsXsv82bTr77ly6cR5HuDlncbDzK1ht9P2oTs1?=
 =?us-ascii?Q?ruyXeAsQyj+zW2fhGIK087aZJ27LA2Ry3zKJZG98Md7CI27V3ccKmql6jA3x?=
 =?us-ascii?Q?KDb69IAPram1EO2ZNMvYod2o0J+SIXjq7DeNq7Vdga4ht8vv2Y91fC6Dzas+?=
 =?us-ascii?Q?PISwuHpUiim7jonc7hHYKI75rd6rFlKbLWUhCRAi0wydpbpX+sUAzvplgmYT?=
 =?us-ascii?Q?PHUvlsre3IhK+eP4cTu55hLEW2xsLAKQy0UCiXceJLEOReh8UZDjD5AIc76o?=
 =?us-ascii?Q?JTldthAh6Z5/QzdLxILQ5J5YGWzakpWPI63VhihkYYr9jz/RqsKWo9WmROhp?=
 =?us-ascii?Q?9n1c9EKkFhjDN5nmsctvgusyYzTlIGy40kJmMeNLiDwYifaFh2fmI6VqPwbA?=
 =?us-ascii?Q?NXDYF5LxlPe1ChZAFKYZ5GeFHPCYr9VkCA29nCpaGqfpPRWWC4W53k2JuFpU?=
 =?us-ascii?Q?u7CjIeGVbvbirc7Rqv4Wooea9Qr2lbSYOnqbmorR182vIOTrTzNPm5yVmwMs?=
 =?us-ascii?Q?g4PEyYtFq88+STjx0wxfY5a6IGguy8N9NBtbD0LCEU/nBgGd0De2QDNdLVY4?=
 =?us-ascii?Q?26ZRV9EmTeuEzMGd1dGIh+0NVVIoNq9rEwbwpZVTUd6olgulqD0FbbAPR1Y+?=
 =?us-ascii?Q?yZbIhF7e9dSRB1YsLzNkjtkd5WKrupDLLe6Q4OmjkX8V3hTDjG/lSrdU/gnK?=
 =?us-ascii?Q?wvjeWJRPbh9sttTmQC3Gm0G9kbG35PweDWKqO0Kd1RhXNTpcILOMrnMJTIbE?=
 =?us-ascii?Q?abTOmQ8SJVGpRuhpp5X21CupOw7TBUQHfRMSMWF4jMB39RPeWfXRuqO/zutG?=
 =?us-ascii?Q?G0bVfI95BFWMyHO57OZWPYWSaQlSOELoX9m8/YOT+AGHb2ETffypX3AoqS0S?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b14cb7-1b50-439d-87b9-08de23f32155
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 03:00:27.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Qlyzg0IMqOVehAyCdxaVICTd2kZVyTbzhjOlqZftBv6Nqv9/7CE5Kg9Tt5a+aqbU9IuureElMVKs6KWmOdVTBF0U1RTf7HWwZqhQSpUB5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com

On Fri, Oct 31, 2025 at 10:32:22AM -0700, Dave Jiang wrote:
> Add a module parameter to allow activation of extended linear cache
> on the auto region for cxl_test. The current platform implementation
> for extended linear cache is 1:1 of DRAM and CXL memory. A CFMWS is
> created with the size of both memory together where DRAM takes the
> first part of the memory range and CXL covers the second part. The
> current CXL auto region on cxl_test consists of 2 256M devices that
> creates a 512M region. The new extended linear cache setup will have
> 512M DRAM and 512M CXL memory for a total of 1G CFMWS. The hardware
> decoders must have their starting offset moved to after the DRAM region
> to handle the CXL regions.

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

