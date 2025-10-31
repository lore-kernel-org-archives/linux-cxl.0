Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C5320CDF
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944303; cv=fail; b=g54t/BAcjNN35eFUyyWX4HwXmbAGUJ7vZVsA76hXyGvZYv18buCtNUTBSgdJrd/OWCrxv2SYoCkZwtLO9E4B47D9Ldn1Lndkl2VhJ50BIZFLIZLBjxMHFNQLiPy45O8UCrkmvNKVvC2ehFLdxATj+4d97TyATz8fErYlSobbwb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944303; c=relaxed/simple;
	bh=3ksS9GQyrLfzZzbJzsOXFIeDRDqo/moH07IHZnvbtvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sjp0P1BMBfbSONEqLZUPSWEjJcErdfb83qwkeiIC1Jk2GlnOLfrCZauaPtCEqPp7WZ0dZle6VvSpwN/ejJYz1dnmoR9Hyh2Ho+tobROMLqMea07tE5Wh789F1cSggktJZlhDtOyJwP5gdpQJ+Nxs7guD6KjTBGnSfFqJUeu7T7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuQJAuRK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuQJAuRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761944301; x=1793480301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3ksS9GQyrLfzZzbJzsOXFIeDRDqo/moH07IHZnvbtvQ=;
  b=BuQJAuRKdAU6eOTWEC+WUgvKnXBJh2c3xjKWoqRKhvZvL09C0Ua4CXwg
   zNODcGDWSpfAUK2+J0IBTh76A3u5PVWmCJIntPvsQKB1VD6X8yT7AsY56
   Yd30IKZ84I7aX5hgx7bFHRS9p5jZxAy97HWIJuC7bS+C5j11vQC/SXCau
   hcYYjg9ZBZIV64yPRTDAac6NMK53nImcZT7Z4CNgDmvUyvtjBKjJ0DPZE
   vLFdT4OlUnaW/X5RUQeNGyBUOVZwXLsBpwzxD5F5uCz+sRELfNqtS0Z4X
   yANCl4olLPh7R4i1j2PoIENC23DH3T21f9PF1fkGG8LFC4WIfkj4zcx6M
   Q==;
X-CSE-ConnectionGUID: Ph0KYIEwTxeo5bqbz5KBDg==
X-CSE-MsgGUID: L2JJy06WTS6a3hzqnQDyCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="89575458"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="89575458"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 13:58:20 -0700
X-CSE-ConnectionGUID: VOXmNXFoSbKykWnyv5uWBQ==
X-CSE-MsgGUID: 6RhsDYtnRL+8AD4J7NmC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="190675119"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 13:58:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 13:58:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 13:58:20 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 13:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQVZu7p649omLCAeo/DuD24/GdXTq5AXSrJ5F9NfceAU3tk70RRHW+01tYbt+kxon+zSGi4rGjXk2EanClOtr8xsoEYjnrwj6JMAhK81/75X4dbiohQ3HIPKHGvK4nC8g53Z53kqgF8kXeIkHd7qFqNuKBlSXmPXff0ijzMAjPE4gJnZOBWK0LJyh6uDk+zbFwuxEz8zluPbDdYF3D3YVv0cyQHiq6A4M0R/y2X/IRD5JP0xLXBw3TRcffaNOxYqt+Tj6EveiA5J+1LZxGtsDJVFiht4KrCCoesy//ZjrX21MfPIQE2RrwF+sQ6gAq6ATqW+gt2fmQcjo/Y2S2TLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ksS9GQyrLfzZzbJzsOXFIeDRDqo/moH07IHZnvbtvQ=;
 b=gJqzd69uUEr49HYvXiVc9sU91jWS2U1i5+H8832krFHrkrEMtXhrcVqWGei0KTDSsuRAysAl5oCUsVPoAqO1KINY+Yd+hubgWw3sT6UmyFH5Btc1LsbAFF+KRbF2Y1mmraCtbmg4Z+IbKJBxGM4HhuNvbEKPpz1+e8ATVMQ4VjwN5MEdEyprEK8y1q2dgGhKhfWPJkdcz4AfLIhP6jKJXAIRh9uYXXymj4ARtYLpoeiZlvdzuOQjUnyFcCHN4GW9hsQNPAC67k15o+kn7FVhl1D63fviwp2kCGb5ei7b0cqFMfGVmzQrZ5+wgg4qh7ndoQUQupb52RGRMlJintM64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 20:58:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:58:17 +0000
Date: Fri, 31 Oct 2025 13:58:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/4] cxl: Adjust offset calculation for poison injection
Message-ID: <aQUi5Tbcn2IHNgzY@aschofie-mobl2.lan>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
 <20251031173224.3537030-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031173224.3537030-5-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ee9cae-1f9d-43ad-7287-08de18c03726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sws80WT50gPNj29VgVazn6Q6dFoCMVxVbU2+A1b2CtgU0qbeM5uomz+9Ehqh?=
 =?us-ascii?Q?BAZnnes+o7zUSN2k6nHHNZJObgmIF0E2EPJuMDh+MIaOeaE4h96+pb+ri6vw?=
 =?us-ascii?Q?L4SDZGc/kOIenl1GTIsjdiPFNRO8VxxfseCYJL+XvsBNUqWhDXA/Ueu2rKbI?=
 =?us-ascii?Q?uowNtAoaAa6/uo05cRwpDXy+RwnLsN808JJtN3tDfLKF1b7dRj+QNlQ5oIFl?=
 =?us-ascii?Q?E2hDAf+VPS/ssz3zerc7PhSVMuujni86ebHq+QUg66Y4bDlt2vQw1s9Talcf?=
 =?us-ascii?Q?wDeGEtDu4uH9N9bZpWPdZIt6/J7uWLHuBnRnxATrv4fRWKC7aug/AtL67QSu?=
 =?us-ascii?Q?nIpBGkAyWI3NmHArnL9MP/MPMu3vQjl/etXsrQDBKyhADfjEu9P30srczM8o?=
 =?us-ascii?Q?2uumgkUK7TrgAGcPF64zQie8mWLDV+Mag+h+heAnD1vTXC2xi5b7WjTZDwfN?=
 =?us-ascii?Q?mxSW7EPVqbLoVjy0Os2STL8+ICuY2+TkFQV1AAJg4HpSyfSFWpGnIzdbZV9l?=
 =?us-ascii?Q?hJCHukdA7dD3fxymoTXHzfvqiu3XEdCzzaMNVCts8D57VtdcOLfGxHiGxaSM?=
 =?us-ascii?Q?OIVOBGgktYYz4uth5ZdM0TQSppJDAW6SivdTKCSRkskeFIfqBftLlXlv4U+C?=
 =?us-ascii?Q?2IHbtJaqp2+2UWYyg38PL5JohvLh4IzoB4MwdMFGcaB/oSVJkJ8DDiyyNjZ8?=
 =?us-ascii?Q?HrNBmRA4vWaYk0qFLlvS6ET7HxTTVH5zE8EuiPjjW6lKhTimQ5exuvlg9aqn?=
 =?us-ascii?Q?qrzGPZwUwz9Fl2L0r6MvQ11lcgiQPV+d5XsU1jWWZg5DlPQh0C6pFBfB4oJ+?=
 =?us-ascii?Q?3TzLsiLzPdTgmEPN14LLqBdfMJQOp9+AFmLZeTHMCuQl1AYJmNcSCdEW67a7?=
 =?us-ascii?Q?Bv6Faxjh2sYAxDwur2+W2cdgdg1MohYsZqpao6wo7IVk/Gg5YBZDQJBjpogj?=
 =?us-ascii?Q?16q1Hj+OYx3i/CPqRf0AmE6gUkQFYTt4UNd4Yun10kKt81Y6F6k32PGgapN2?=
 =?us-ascii?Q?ENlI2vQca5MsqdRXHI6dU2+nAzOuv7LrjaLCVWQj+95EYr1dRPtIW1dt9hp8?=
 =?us-ascii?Q?ZrFkTNk797AXEeSoFbRDUCnqlLMLC9FKrYA6rFxUSbhtcbyb3hGvrUv/Ajkk?=
 =?us-ascii?Q?b/RacU8Cx34TVh2qHPQlVklsn8CC0xAKxDryQKdBYKJiQDDixbQd3G3iy6zh?=
 =?us-ascii?Q?qeFrH8o5rTNWuJ28fpLVWJ3wAuQGDalIuHSpkg7jGz686//7A3L7sv2gvv7v?=
 =?us-ascii?Q?6lC8IUaHul56+FO4EoZJwv9CEsathhNAEKWEioyNE2KivdTenQnh5MRhcwb9?=
 =?us-ascii?Q?lbEG1yKltK7h0XWD9dFsn4/NOnWS1D2gWkakmI8DYtAsYkMJWG3mE7nN9sa9?=
 =?us-ascii?Q?9+waWwzjaOvXQtJDBf6y/SJaKcfQSAX+ZbgjO4K8sUBWPkEQ7vNOyBKjH6dZ?=
 =?us-ascii?Q?DIZkrquIVesYU4ZLBmv+8ie9RCFV33qA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xMBea7fUu1yn2UDle7XyNMC5Dkv09v4E7dQuG+/AMDqj3G4pt3G7s9ZgA0M3?=
 =?us-ascii?Q?TvrTvvvfybjysRizzjIjtqCwh2xXuA3z1T6X4gDbe3s1Z+ljV+G+Q/ugMC2Y?=
 =?us-ascii?Q?EQerohtCxnA6rxqr8dIywiyj99ZkgMFs4JXYgon9nQZvSQ53kLbL1sirVUPE?=
 =?us-ascii?Q?E1DxN7+lrXjB6O5QQUezBs7UrolvkcEV2bUGQqCNxvrQL3urozyo1DyThcbr?=
 =?us-ascii?Q?7w7s3wPBGeEjajIuIDkvbKoqmkCYNOsSZbF/5ksCVAQ9pKxW6XgNNGozH9h3?=
 =?us-ascii?Q?bb1gPtTbCcCpgxAE2o0zQHhevBOkHGD6nwGgjafmsNbt6A6Zz0NM4jGIC5Bd?=
 =?us-ascii?Q?C0PYxWzw96LSzdxTcV6c7UUWwbUG+PyzSN9MGkiAZrfkPlXrrgszSI6IlovO?=
 =?us-ascii?Q?yDrOj1HLthHUekU72G6ufWIWLgkAEeB8A2Leos1f1Y1LbMXzZ0rJYEAdvicO?=
 =?us-ascii?Q?yCoXFjSVjTmvlcbG12py4AYZnBXBnIJY3IBAu4enGA6JfFH9JODLeL3EB8gE?=
 =?us-ascii?Q?7N9/vzrFXA9NRfJuncLPOhjvcTauiFtHEJL3bYEiO0wD5dMNaTWJwjoT25M0?=
 =?us-ascii?Q?ALFwPzJSEq8b6kYDLaWGofgorILLvcmk9iMCYpMvwlFglUNYQKZWS5kArA0h?=
 =?us-ascii?Q?+Ba360rTrtLNTC6trJbvzCnh67UMdFTNT65+7uEkW/GSTi9bdq3/I3ArvoRs?=
 =?us-ascii?Q?nG86sgMd5UKVwGQGkcHw4ftzhQsFK4Y+SN1YaniZSQdPlgRRconp9LBKX+7i?=
 =?us-ascii?Q?J0f48MK5xUgimx6vhPO+Oz4CDjA6pLS9bmx/ilzsL38mUmuF5HFO7iFGY1Fu?=
 =?us-ascii?Q?HiAp5UYDXjEtBLbKk317izz+8NUL0XUG1dYuw1E977aMUSSrZmGAApPMTrPs?=
 =?us-ascii?Q?33vUmgIZstXdK/Vfb51k/izSoXqDdn5bccTHQyyi6SdkKlZ5n9SRxq1Y50pN?=
 =?us-ascii?Q?R0szTdQNu9R9vp313EJ6Yt/Xl1Ct+TIqI4nQmbcTZNjwZsbz+ej/BcW9WpCv?=
 =?us-ascii?Q?n7ItP0scM0z6+y3Q/+37b/qDAmjJk8nMOjIMiBtqRGvtOe+rkLBpfKq7V36L?=
 =?us-ascii?Q?IIZOIaqRAXbBd6WcWv1yHFA/ZFhteDxzTe4N3jqzNioQnnF0IzLxKoPIJ87V?=
 =?us-ascii?Q?68jlon14kWmbKaDY9FkyIOR0Qeny0IhCK56Pxt2lfbekRpMYM3peeQCF8XYe?=
 =?us-ascii?Q?/P1FFkMGjr34KJkGb+Kx/qzSIVzitPXUHrvfTm11aJ3OMIj/lJO5MiADZncM?=
 =?us-ascii?Q?AgS8BkkVm2wIbCroed3hRvC5hx8afhaIOtn0lEJANQD/E94BKZqRwWkFaVsk?=
 =?us-ascii?Q?y2IdUg/9eI7szrOw9/ZsHu7sqlFo0ZlcrSeCg9GAfUJeYAl4lkZGOcyURrlO?=
 =?us-ascii?Q?RWoqoatqAMTr1tJTJUK69T8ys4zo8/67UGGu2VazuydcaRWBhy0SSNushUyU?=
 =?us-ascii?Q?8+AHCeoNwKcnU6hIs6XrnOc0tRA1d7BHrPxiuqugDKB3WRjvwrUHyakE5C6p?=
 =?us-ascii?Q?r3SR59qgHGAloAv7YVHR36KW/bl34I+GW4TggW2ccFfdPxMlM0Umy+yqPbvQ?=
 =?us-ascii?Q?GJNj/MrspflHWFkl8ZbUYRo//BfYkZ8vVgyecOiECR1uYkSgXql0nzfNVSLj?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ee9cae-1f9d-43ad-7287-08de18c03726
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 20:58:17.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oW4h9JmQUt/FcgTcV90umFmbFIeZ6wO1xBaaaUwC2Gb2THaJEKFPKL6e33u0R1wsDus1maIhRCTI300o1l5N7BqDiBKE8V7y+aB/LCvt4f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-OriginatorOrg: intel.com

On Fri, Oct 31, 2025 at 10:32:24AM -0700, Dave Jiang wrote:
> The HPA to DPA translation for poison injection assumes that the
> base address starts from where the CXL region begins. When the
> extended linear cache is active, the offset can be within the DRAM
> region. Adjust the offset so that it correctly reflects the offset
> within the CXL region.

Dave, good catch!

This breakage was added in 6.18-rc1. Please consider it for a pull
request before the end of 6.18.

Here's justification and Fixes Tag:

Without this patch, when a user intends to inject poison at an offset
in region, it can inject poison into a location in a device that is
not mapped by that region.

The test case in cxl-poison-elc.sh that exposed this issue, injected
poison 0x20000000 which should have been the first byte of the CXL
half of an Extended Linear Cache (ELC) region. Instead, it injected
poison at the next byte of a device beyond the regions mapping.

Fixes: c3dd67681c70 ("cxl/region: Add inject and clear poison by region offset")

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

