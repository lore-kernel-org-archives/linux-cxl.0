Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D963370AD4;
	Mon, 20 Jul 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564723; cv=fail; b=mtO/8mg5M/2S5fabOSspoZqZE67F4wqsYhS2Kzy7fBhJ8rM3UrJVfiLQZXZ7W5D+4H00G1einuuxPTH139TkkY08eXOQGtFIdwBJA+QouwjGCAa8l3NA8kn6B8jlH70ENcKnbluCEBYQFT+0zezAXKKP2KYZJN3KyklnrZiV2jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564723; c=relaxed/simple;
	bh=5dKO9l8ILhwWXjl+LGHZmNvnMk4a61SMWv2ms9fZkFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XhLOiMLybGrIbB4HQ6jH2qp9trvyoii9slP7fqf64rLUkFsCUIQzJO3eSpU4X8BaHdNnBOLb0FlhW9qfFyNitmWiWyr8pPZ7DVtJ3UEpHcFfwFHyj+MIHzVP1Ox2ttVh28zMjNXVluSUdYmBz0soLJpemyic5S2vFfCqEe5B/V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVfzfNxm; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVfzfNxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564721; x=1816100721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5dKO9l8ILhwWXjl+LGHZmNvnMk4a61SMWv2ms9fZkFc=;
  b=RVfzfNxmD0Qul312zm7StWgHkKC9TIPFp52dJbkJmysJ3lIp0REXuWUI
   Z7Z1tny3oRNbVupuEIs1qYuUsbsg7encjmH+ylCjC+37S9iFoBUy5fzLb
   tTjqYDk0xDH4MB0cHqTz18jJ7E4mFHGwO7y7eDWphZfZjhJKQSdeoWVMU
   ms1Z842Xm0bhqOi9DJbeQCtfJn+eTPzZnHeEVR794NC/wng3DOAitPV//
   1h/ZtSLKDS71RZzX4uKPBYJyR5mQhtpPrlsI/RFkb20lq5yPn+qJ0clkL
   MAyDUSl+T1ypDujaWeObZlMNwFEBLBaSeGV1grdGnY+sCswsE1VSD7/z6
   g==;
X-CSE-ConnectionGUID: HVN0XB7UTVaFwVRTf7hHcQ==
X-CSE-MsgGUID: ZcIVwt0SS/GJxCiIp8y5eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110702586"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="110702586"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:25:19 -0700
X-CSE-ConnectionGUID: oM+07FkTQriHUQbDFFLY8g==
X-CSE-MsgGUID: jKC2OUhnS2q9EUZjK1jOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254091115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:25:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:25:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:25:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwb9LB8ZjIyJOr+g5BbR0u9wvv4Sf9YA/3+ze6iUaA4svISC0eFuHWexf7VcUn2p2WK1gnCLyJqsA++D1N3jult++zFZvYdXEYyiOj3ZrZffdXKyXLsZ35wLfZ9/O7MBhJCl9OIgaZo0ykprcsxHLcyx7Fj/6nsUlL5/1OGg7VXGs8HFcP0FdHtEsp3YfkIT96HfdXKOVQzWBiEB8tgezaSEHJXAvWy5A+1/LPdxsmVt916OAs9vC1xVeHAV06ee8xxCj6ch0K+WhjsbYv+L22/bimJtav5BMGaJdXIGC5UTBU/nZUusNxaYuKOQlbLlu4Htn0iecWRRLErkleYu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm3UzSuOqGHra3FHrJ0VrKamS/zoDSDLjzPHCVSlyu4=;
 b=DPrjzVH5xzhPsam/uuV/3Y1QOmAR/2zA4hdDIZ+/KohIwu8e7dsGctydUsxuRs8r/kjwVk0FA0UO7vDjkm3WqH3C4t5ClxRc0uRTFsrdGxMfDzBbyvy3RYvjuYpbSeLad+NCFMkeAjs4LcmM93By5H6Ib937oE3VOB8cOWJg4i4TzTk/PwyYV80p37AB8TdUcYVX4Ea4sFcfraM+DtnWcDz3XEIjDQ3F98Bm1g9l6gvziv97ut20JfVKyge4f/98+mJLCdreCTAz+yF5TrYBjvrw7HYcdtHTXbOugPMroSlHXI0qsjf2UUxa+lYnsujAi1Mp4JZv+puyHAJwmjejGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:25:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:25:15 +0000
Date: Mon, 20 Jul 2026 09:25:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 03/10] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Message-ID: <al5L5gITz_pvo0e1@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-4-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fa50d4-4964-4e71-828f-08dee67b7b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|3023799007|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h7wd/LX/I/gkYdaz44MByjhLaILYtrMQ4Z3tkGRLcaFjkLh2rrNVO/rFAQKZBKYIvUzdbEDKJRbtNW6Qg7O8xprRQgEqDHxx+YLPbw4CKeqICcZDBO73Qoxk5+SbbK5iC3W2jD8SRv5WM7ozr/LV+9Gniv7hSo+KVtlsSyMduxXjwP9yJD3m/Ec7jMbe/F2VQRqCkKEvoyO4cf8q6V/SnIGN1fG9GtHwjR5iUZKgqkz10/uxak8HTsv0Um5VxVL6ySh2599bvJQe1ptq4Cp7QYbU6w+8CA2b+6Ocx7TuYOoQYxYcdI8vi2s6h+K7TxCh71hUqqjKyDANVg5Nps6+v9bUZjLwMERBQhQVwhL3qs5/9iiT6MKBLqWIflBTFXmUcUNkGfQitoEHuMad0BdQtKI3qQFKgHiY7F5clMaQIEzNfnTMdRNSLDnhQMQrlKvuaWmt0g0p8IHWWKvx/lSynjQX1IXQNfmvDyX4pm5Nvmpuw8fy+LkYj2mSdoqY6KzQvyjDEfKUERUgb1ngksBiUCmxUtLpa+YokQIgnlG+eyen1qxERWqhOmhENE62Irs7OPFo79t9pik404iNkcgPqdjxnEKeIqO8XrF4g3H7y2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHxOApkFdVWqMiTi0YKOkeI1B8bQEkGVNf/sF3CI/cXViD3eYkPbIt+0Z/nh?=
 =?us-ascii?Q?TR2zUFmlsphJYgvz2wA8oPIpFFMVnO7jhmdgZJenLTlP02BIuKqit/v6swOc?=
 =?us-ascii?Q?hSWdrgEnfyXtzfD7SxuZKpS/jPTuMtjZgFDmXlOXxedO+Bvkjo3QsmDfMsxC?=
 =?us-ascii?Q?RWj7RqJI9QnKcA3wo3FWWkAOug+pbOqPJvmgmPUS0lUVMmxo+6M3qc6QUgNa?=
 =?us-ascii?Q?zJ1/FQvLThaZQWFFLin8M1gEfJJ0KyjSo4Mq/59DdkK3/lWBGprFPxQ+fjMp?=
 =?us-ascii?Q?jzu0UxfuC0tUfiH4bxnPSTzsyNEITBedrlOpJf2oc5AJ86J6UlvafEzwBN/w?=
 =?us-ascii?Q?Qesj07FKP9lTxZZhY8S+SjMDiwccR5Okh7IzO7fr53gC6P7ECWJ9y52w3EYN?=
 =?us-ascii?Q?kIp3ECaZ8tV3ARiZoKAhFmrI6aWWNeuczQNw5gv7yrxgoh+Md0HmeIEP95cp?=
 =?us-ascii?Q?ghi4WASpGGFEua7Jqxfbjz6uOsMBjRvzPrTj8j5xH+UrijM9K4iepDm3aDBC?=
 =?us-ascii?Q?gpvHemS0+WYi8G15M8epUxb933KSnRvMQFWpTSrkIjhwSRf31OHB94cUz8YH?=
 =?us-ascii?Q?8lRyo/tEQT19SSOQXo8aHiLTHgkjY3itBRmNzVJj4MYLS5zWOlFqmIS5nFR0?=
 =?us-ascii?Q?Qp3qQtAFgI6ozhU7ImgUeugvSNAeuDPVbW9cqXn48VQiaK8X9JksAU7G8PhP?=
 =?us-ascii?Q?ZrXs7nboDRqXTcLvyzP6BWHqh110PvkubLJqNbfEEXKftxpeaA8F1Ao04tEy?=
 =?us-ascii?Q?g9BqV0I+DYN/xkJZ+2nyyb/P/MjSUj5CvVRkTRA0CeHGjKMpsFEOj0w/WVwN?=
 =?us-ascii?Q?eFit6oK0ovWb7eruMvL6USTebEGcwtohyK/dd+zK4jlnyHC9q24E+tYo4GWn?=
 =?us-ascii?Q?7rzOmaFoMVodRgUleFJwGhAwXuT0VwtWMQEVNpFq/oG2RBzCwiYsb6yp4DGt?=
 =?us-ascii?Q?HpawP+bm4TUL1UxA1lWV4S+jiPszoUYyFFqESWMCz/YONoIrSEGMntySrUq0?=
 =?us-ascii?Q?ytGYBZUX/8CPAQZLdn/4P7Dmx6CMi5aXw/HEFLg7VE8zUcCYcVQF0dYGZVY1?=
 =?us-ascii?Q?Mac4nWCTYH0dCretuIhOBs+0J6yepXHfbAfLcGKqVY0tOHVyHgJu1rRAy40P?=
 =?us-ascii?Q?qL52GfcEgD7UQQUR0odPKJPbORdmfhJjXnuC72hxZP/Moh4n28UGZvJmvZBj?=
 =?us-ascii?Q?kz3+liTSdMFJCd0BqifgOuaFhMnHLsPKY/3vDbhMW7bq4LfoyE1fVgHDQF/r?=
 =?us-ascii?Q?9ZRtq09NKnAtQer7cmHJtUN9j1tqzVCl54IhOIMl7oG3MMFnr25Th4uC49ig?=
 =?us-ascii?Q?C9snwLpHn4LiRc3cmFPZSqVnNba0RYhoR12po041WPPjBNrAkicLqSb/E/Z7?=
 =?us-ascii?Q?T6sOrdbMC1HQBxNHmxCgG1EZkll4x215H5+YYLnXDrWgUyVohIVrvzfXGqnH?=
 =?us-ascii?Q?llFcvfot7EWaH9YtTH/vidbmf++iz9o/THXOy6gfv9JlrSHNCofMASv4rLGu?=
 =?us-ascii?Q?JCIulHLbWx7wiLjHzly3Zv8DZFdpXIS+f2u/qXUsra2FTJGX3HIV5Y8M5jDZ?=
 =?us-ascii?Q?ZhvWOv8Z6Yh4uVTBCkeXNJGuSnQ7+I4ob1fGFKwm2nJXQUcSNepZecgvs+oi?=
 =?us-ascii?Q?/oasWP27hejwOMYJ415/l6xiZ2aCpZ74hbEbrTCoip9qbQtzWaI1F1FEyUqY?=
 =?us-ascii?Q?9Zn16NAAvM7vbyYv2OeItLmk+nTI54nb58sLpiKU3OjEcsStfmZSqGFx8n1Y?=
 =?us-ascii?Q?STVmHS8MyhlD0MZQDgvOZfCEZE1pGTw=3D?=
X-Exchange-RoutingPolicyChecked: AoA9dO68yC6zqyIixJt3apAVv++gzJ6EHEG55XKRJqCDOeEmKWZC+3dhWws7P3UesoX9h+hH+KecdtbOTBRBmj7+YmrRhLQFzBGRCmX1BbUmYKtHxCmDQDjcUbYRKfMZtRCWx+773b5jM3Rr/W5m6kdyYwo+/9kMvgO4F+b8HFm6CiC+UKU9jvUJyNop1TZrYkNZb8jK1I0PsbsDZetBO1TsgtawPVdrLt73zQI8Fr73NI8b0hqRPi55XouPYVjDHspwLzqhNQfTtlGwxOfMzslgGo/kkKIKsj+nW4aMxEsoHOpfoBj7M/D0TQpf3vuUy0woJyHvjUDrdi96ziSyCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fa50d4-4964-4e71-828f-08dee67b7b49
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:25:15.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll3TiDegAODV30GIRjFX6hhS2v+LyxkiaE3ytDs062AQJJOGmtXgvOFk4pGdN7/ueHoxG3X7dq7OLaNzSXOtK+dMwOH+lxYga9DJ0z9AJrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:40AM -0700, Dave Jiang wrote:
> sashiko-bot flagged an out-of-bounds read driven by an unvalidated
> firmware dvsec_len.
> 
> cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
> prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
> firmware controlled and never validated.
> 
> Extend cxl_cper_sec_prot_err_valid() to verify the section can hold the
> header, and that the header, DVSEC and RAS Capability block all fit
> within the reported section length.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Fixes: 315c2f0b53ba ("acpi/ghes, cper: Recognize and cache CXL Protocol errors")
> Assisted-by: Claude:claude-sonnet-4-6
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
