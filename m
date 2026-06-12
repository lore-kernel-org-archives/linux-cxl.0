Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B878F4A
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225254; cv=fail; b=bZIWF9CA1f1u1FmMcOY7bN4MEbG/tkESZe9H42qr6z8g+pjI2DWTJi4hS/LNlWK2p11odjB/i3bZAoc7cfh/0P+L1Vb6K4A1Xsx4DzH59aZIUy0nutfH7+QAFvZzdgZUmLgPyqGljR9dWxzWU1TvIuEMothUaCnFPgigHnE4NQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225254; c=relaxed/simple;
	bh=cLmB83XgHmWF2EwHTBo3mCtR90iolmck7E0zn7QRJYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RM01L8oNhEeP0JtBWd+/070tlF0SCRNnFLZPj19E3rjOUvwwS+HqSFgjtAi9uL39zN8OqkimUafSwYsXN6TMltZ9cDGblJIxbDMmOGzwhMsKPdH5Je1eScXjkYwAc5uFwq79lCHFubvnhkApsYfP/HRNnJf3pyGWb00L8CnGNDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiKrb8GC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiKrb8GC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781225252; x=1812761252;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cLmB83XgHmWF2EwHTBo3mCtR90iolmck7E0zn7QRJYs=;
  b=hiKrb8GCRpM8jLtXqX7Vi8EBB9fnbNvrEHxBlvLPzArMH+drUTznYKJK
   wc94vsMMYpITsx7UmyIqjO5d4E1Tps4EQ0SONwKMe1wfKSB/LpLHSqt8j
   HD5FBsQS7NC68NMzAQKCbxCuVRtLimIpkhXVTCX1KHc4Mz1VwYuw8Wv3t
   ubnCvymUgMAY9tf4KwS8s3+8n54dLEfh7Zosfrmk/q0Rkw3qyurcS63LU
   /BibXwX8b41cKf620rTziEpSX6mJqs7bMH9YXTPLsSNvJQX+mgoGoBfJt
   lu8ofwYVZLf1697Iroo0YLirs3D846IhEutszaViwcXpDA3vinGKM0Gdn
   w==;
X-CSE-ConnectionGUID: drCBLR6cSRC7NbyJopo4DA==
X-CSE-MsgGUID: NgmCyv7lRZa4YqT8xHm75Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82099495"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82099495"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:47:32 -0700
X-CSE-ConnectionGUID: MGCtq134QOeLYAVo69pU+A==
X-CSE-MsgGUID: 971UtV5iSmmDpXl0nuqIMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245779154"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:47:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 17:47:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 17:47:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 17:47:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZVVt4Tq2jcdPkZdnnFETfh7ChCoE3vbTcLYMD0xXzgtXQr/b6y6NhIRZeW/4UEBpnvRZxZxSGev+wA/aQLzSQZfGhjBsQvc5MVC/1BOZtTTRUkO7sf9ZeDt0AP+/8dyFGUMziBSJp79/hskyIdFPzDxLOTl8Gl+WO95/psXNgpfH3P3FGk472ClR2sXcHMt8ZeMGSH0bMxItpD8tfkiKzIodIjQ0bGkjlOt4otIrtSGuI3iSJqyRhEyUXy0ai36i5VXXunFZCLOSB76HJ+BrGwkg+sRTAi39i8LneGv3M6N/KMjHcX7Yzx96EZTs3n5JoaXgDRjlUSdkBfDoBr8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLmB83XgHmWF2EwHTBo3mCtR90iolmck7E0zn7QRJYs=;
 b=yj63xjfs/G3dRkAcVSOxSD/mPRe5SKMyIgQSxVkIQUqTe7dNsujkt4qN/KRxbOUV+4rU/ORvtBWFK9iJgbZzNrRPtIgkbMfhx0uQYu8SxGN0y1KUkGuv1+L7bRQolvph1hOrLCyElrBebLd9ktavUeXzH7OZ1LECtomKQPGuq9hp9tGgOzdrxY94Q4vlQLx05K526+9C+HSg1GfHHcRYJFrtq1m6Ft7QSY9qlk9UG+lHpLdQqEu+RTGzrOqx4ELtMDWNeTPZQef/SXKl5YCpiMKN+pONYM0zKOgfgskH/RM6aEu/5Xnt+LER7TD/rr5sRKk3WKM/pV1rmp6pzyQQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB9700.namprd11.prod.outlook.com (2603:10b6:510:3a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 00:47:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 00:47:29 +0000
Date: Thu, 11 Jun 2026 17:47:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>
Subject: Re: [PATCH] cxl/test: Unregister cxl_acpi in cxl_test_init() error
 path
Message-ID: <aitXHrmGJXwTFt2A@aschofie-mobl2.lan>
References: <20260611230355.198912-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611230355.198912-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fe94e7-a824-4f16-ece5-08dec81c2e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GmlqwFVlUiSDH6Qh10VpQyHprVgXk1vX6xno5rMFv9NoQaS0lH5Y5gqlH6u0STfGBPLICLtSG+0I0acBox+NOwMYs1gAggjjcbOH3QX9dQdo4fHc6r5Ns14MNIDfhK7K2tq3oXSXIi5qf+diOEG4RClhxkaqjJ/pxx879SU+qfAYN03HTY0QPEZCqrukXeeevhweyXxgwZAKQuHACj28AodaLeAfo1An+n2Ckf+UQImxSRhxp0RG6sOvB9Q2XtWZFx7g69xDiaIxxX2iLQHTjY1NEK6XHU5T65eRP+Mg482qKKtAt/CtHj5I931V3EGdqegU7D9HSINWYXjAvsBJmsslSU48YAOM6rjuWy7W41NtMe0QDv9qqg1dtB2RIVpu3in2W4mEnt4AH31WOneIk7x//OhfpnppSicgOuBjXuDvaS7nN9wJRQW3kIkaWl1GL9Fj64Dm0EbxgEeiEmobgKijXrpDfsNefVtyFDYpdksVtiHrtn5p5v9OhXPc7E+L5DyBnC3jRYs5p1fZZgC+Z3oaKqIWia5rck7Yw6RMoTH+Yj7cHJNW92D45iPwwZyz5MFFh9CklItmoh5m39oZ56tYp4hmn2NJGIsGT3O/tWDfy4SkwmF+FlkCv++SKTSwWbL+mHLUQ5IzgXWUdVTZa4VlGcU5AvhhjE/cRYEvubaXCwMJ+6x9yvCWaQjb+eSb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXhVIjINgJ0ht1VEYuhezjxi8p5mOOuBgHSRcVUfh7UTxzdnUIcsGpFe6DV7?=
 =?us-ascii?Q?aJWq2jkxOoXsrLFaq6loSumvniwWIJqRUVEMqVhZIgg2/b78a7pGsVX2ksbX?=
 =?us-ascii?Q?gRBRnIonLiTDYdLpeDvYiCFOp+iyrwSsgYbfIFC+/PIXDEw8ruSE/38dZ+RP?=
 =?us-ascii?Q?M8k4s0AWBbW7h08DAm/5aPTpi33oVttE4YiGYgA2zwBYwhNGuiXIfT/MeUzg?=
 =?us-ascii?Q?Ub0usiKYmxJD4oBX3+zWoKHOMZwSchohCQhrjOceP1EmdpQI+BDnq5q8sfwh?=
 =?us-ascii?Q?COlnHGgnFFlKf7F98qPdg7FgVIfd47zzEteJFoDdNhJNkmNi9/FnE22JZMY/?=
 =?us-ascii?Q?OYJYRLnd4+wGUk4qF+/wyDsVzBIkAixy9HK3TCUI649ZSCUbizPpECvYUW5S?=
 =?us-ascii?Q?6U1SKb/Z0aiuCpkIrGSZkJvtM/4Hht9XwJauFs1PFlUUKfOlXXBT7bGsO0ov?=
 =?us-ascii?Q?XHxgmPMTibNJEAwyT5hurBaINY3xxZ27tphkJx1INrgyX/nq+8DpvEEv+i3i?=
 =?us-ascii?Q?0dCv0x2h65BeYPKRwvYwCKT1o1fPApl0uXLhuI+ubc2PTVMXvVXIpkUrl+Sx?=
 =?us-ascii?Q?qmJyB8XqR0PM85eul3mpa68JKBvChGBAvp/GTjtfMJa/yfFLpc+XoewMCqxy?=
 =?us-ascii?Q?N2OiZPaJW6sHJ963g+jvF33LD9XgCLJ07O6udqWIROIrj8jIiprbCnTIG4wW?=
 =?us-ascii?Q?OD7N2+pNn5pppVFjnLvGH0WNdArJstp5yGG8VgYK/VwAx6dabjpPSllMRPR3?=
 =?us-ascii?Q?q9FTz5JU64wj7w+TLTCO2OiTL24rJwYZf9KEuapv79Q2LfrgHP4N1mlU3Z2a?=
 =?us-ascii?Q?oNt5yPOz2Cfjokbup/rGL+/psN+0nLTe5pAcjxbbqlC8A4rfxBPEpohc1ur0?=
 =?us-ascii?Q?ctY15NUmk2aVY5GOplP8C+gMRdCSiDGFFJXbD70dWZcVOpUYLKLLRy05iw3I?=
 =?us-ascii?Q?a1qf6Pk20RzdJzRqmBuJsnxuSUxYM/yu6IukjDqnjiYTcXba/ZewdzZMr/8l?=
 =?us-ascii?Q?NxB6jfTBwblVLD/eTbNr6QjYlQs+4+yPSnSXBlAFV75DyEsgmtihW6BM0qwz?=
 =?us-ascii?Q?g87zSOoHe3b4l0S+PhOB5Xx53Cr3bv4xNAgJrdrROVRKo36dBTya+sYmnimI?=
 =?us-ascii?Q?WDkN3llroQrNrLEyoFlrcQYXfOGYVvbxfAxzptLnbwaYemeeNORhQzwkRTjf?=
 =?us-ascii?Q?kH9H4tRticeJLkPz3NhMV5PMBx/sQ66UHfe+o+OaQUPWPTkEOuxholkZPgJ1?=
 =?us-ascii?Q?RpW3c4ZYVVxW+kU6YYddV63dyWhWqXowJ80FpnhmOdrdw34IiajBW+yAbSPn?=
 =?us-ascii?Q?2HJnNffqymn9HKnFFHM5XE5vC4zVmIALf//LV0GTkcQeeaKi+fQC/e6br/w+?=
 =?us-ascii?Q?dlh9GEuCe4xFK0TIo7njBwfd60csDe0wDsxHAU77upxKgpZye5gKrPCTtM3u?=
 =?us-ascii?Q?gflK1NM5HA9MWMYl7rRzmtbnfNabTiHoldoiVrI8Ct7Koc0duE2/NpX+B1nK?=
 =?us-ascii?Q?E64M/jOZkigV6HV8frbWKjHO5Z4PAycEaoxxHjIgiiiwLcOwwjhl7ROWmVSy?=
 =?us-ascii?Q?g+9DmuUTV/kWRS2N1t/vFYblVacSP78K/4FEx685EBi1qkQIsBhldCubqadP?=
 =?us-ascii?Q?8YCMv3RYfod8wUlZKCm8NGAyqHYJ/rQn2g22UjdsJ8p37legi5+vAfsWupRV?=
 =?us-ascii?Q?RExish6SCZqL4PKw4kHN8uLDfbVB4fauHgAbIis7NYQ1mTk072NhrEVSgs1m?=
 =?us-ascii?Q?0ltxm/38PxtaWkD8GESCZF6Msb0Rw+s=3D?=
X-Exchange-RoutingPolicyChecked: gKwvBlaHU174afCowdcg0RAYliInwTcoubrCHO8xWY8ppiB35Dw5GgyAu8VeFHl2Ct9hHsmmTJ+9Nhed3G7VeA9APTtdZK+IDgTmAADaqaOKaKH4hUVgnvv3Brs2nZ7LVOOXBX/gZaH5ziHBfDC4eiXrm6f2wyeQTejKxad6QtctA5SrVLVBv6JJiHMbfDDEy4g3M0mR923S5f3G0jQtqOZ7rFOFprNfvSgWc2ekHO0iPZzwq3v9Ie1VLyk42A2fb2+AI2awDQkrICokZbvC/dzSDaV3xxtNGFRsTArdC1pG4MItUWofS23ERuMyZ7dRbKCA8aNZguNc1jAKGm5UCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fe94e7-a824-4f16-ece5-08dec81c2e53
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 00:47:29.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q09/gCpnljemcYCTSHpmYFz67oM2YxHqLheX04qDNzdhLMMShzkXTPXqtU26H9uMxM637hYsuW2VSM/5Rx6JvKmS4V+5cf3o/oCWbmdYeak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9700
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 04:03:55PM -0700, Dave Jiang wrote:
> In cxl_test_init(), Once cxl_mock_platform_device_add() succeeds, all
> error paths after needs to call platform_device_unregister() instead of
> platform_device_put() to clean up.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
