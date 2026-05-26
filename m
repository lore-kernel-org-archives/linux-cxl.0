Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A8352C52;
	Tue, 26 May 2026 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779836761; cv=fail; b=EMBX3GMb+G5Z1gMkvWEDzNJL/M+IqjrksE9nxsbXcGXm23cbAO7W3Hz9pnGexvaFJWBb7HRK2asJTV5/VaQxGph4lEhMY7LJ0lxyvCA/FQRCsN0uwBSt7LZPdCluX/bCRDC1dDcIFhEDHhAurLfPkn3DlmWs9AJExGLGxQl2xQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779836761; c=relaxed/simple;
	bh=HkU0feNsD4TpSfqEtm3s0d+BWtQx1MQI5/0WUKaphY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jd6/fsbveDkTq3IyT74N0JUODMfUZLtqDHmFWZNlPxxWmr4b39/Gq899TT/HwjFkFO78FcorJMYIl96SXOJaB+1OaTT2iGFEkZ1KV82wwXV4Aqwo7Noj4oaXSp/Dg/+c7lwkhkp7M6o5dfiO4Z0ha7C/BW8TldWGuNpcYFtdQsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwTTjmid; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwTTjmid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779836760; x=1811372760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HkU0feNsD4TpSfqEtm3s0d+BWtQx1MQI5/0WUKaphY4=;
  b=PwTTjmidRYXuL07k0DbLbPmX/iMDi6Jhe7SDUEDS5hkqz1ws85Ew7Hqf
   8Hf9Fduk1CpmICI5z4+E2YJo3FeFHb+lioKt+guF6EXpP9JlCknL41Qvv
   bXWpmHWbeKHI9qIVlam5+pY0NbXwgqwFj4RxPnRJ2iyZU5O/sRjdVKzWB
   TbV3xzDa89gqAv4nYvNXvi57VyGHMX3wc3Wk/UcsVYdmFGY+zNM7cj7IM
   zd0ZAx7JMEFH38HQ752qvUeoCt6Uk6/qXTrhv9EBK4YMLZ6gzJpPutLFc
   iXQqnOZpphIk+UFWT/qJZto0Qio5kZDuCFhU+NQxBaNLuyU78kK7T86kP
   g==;
X-CSE-ConnectionGUID: nuPgq1baSHqlzI30mO797g==
X-CSE-MsgGUID: KtYEs5wxSdGcU/OQtOwCwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91769479"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91769479"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 16:05:59 -0700
X-CSE-ConnectionGUID: TcSBjYqYSjWlygdjdBW0CA==
X-CSE-MsgGUID: SMziMgqWRveBk6mUht832Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="239057656"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 16:05:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 16:05:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 16:05:58 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 16:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enjEyoAKZZKwg0vT64HVRo6PuYp46cJsuZoKQFoIW3c8j82O2sC7YALSyYwh68YvPF5FR6i507Fvyg0bPONGs/dMTVTJdhMlCapAOjjUOsAGnf1hq1tYHSWTnz1PbNfr0RpLipLe/mCzSq6D99i6ucFZln+gVZqM8P+1LegZVNKl7v9NlNAvNqQf1VS8jDPiEH6Ry18sui9yyR1rPqU9UTh2WImeyd2QrXowK+lTgaV1PS9ei2kx4aNP37fn6VdyTtGbMtO502Ao9l2GbxDPYdDy0dRFfikpbrbpiod1vqdXlG2Wm67Dq9THHM3F5BS44CN3yaJv9MrhbCPuWNObLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p/8mHtIRiHWuN31gDyOMW2ow8WwBYkaJRlkEoCT2Wo=;
 b=p5wgqBKe0XLobEDr0v02ae8v8rNiDn+ErwEYL6MjK8oQ0iibvwyM7gPjyMeg0pfDF+TihV+KflamzCBTxvX7lDxdnhqhfJP6rB6Xahfdaau2vaXDEybYe63241cEHDfEa8cmpgN+Liu/ZfV/SLQt8EoNM9Y2RqcOZYyq3LdF3Tvi2+r75cZQ+fJayGs2OPJCQ9VpBtnuvroef3P1/aldWsDAKT2o82Ut7RyBNtcLfd0gUAsk1PKhJCRCYHwYw+F9S/BWH2Q2mYaGxDMHzH8LJQ/itE8mX9+5qOnQDk3QJPfZpZs4cvmGY/vLHJnh3rzhOkDx52vE90vHgLuRZrfVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 23:05:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 23:05:47 +0000
Date: Tue, 26 May 2026 16:05:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
Message-ID: <ahYnR1hMdweV5o3U@aschofie-mobl2.lan>
References: <20260524095620.636535-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260524095620.636535-1-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcaf336-0055-4ac3-1e94-08debb7b5269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N0rgN5+us1jFq2beX1pZJkr8tFddw/y81yM4ZeWQh1QGgv1cgnFGUZfvHOw3aA+E/wFl6dvZhejBu7PFpcjHj+Fh9W124nFv6cl3jKr6/IW4QQXvxlF8eT4WsPziryUp5dO1cfDX2EklsOC9TYllt0+qBySAloYxuqtyFXe56kzjfhFFyj8qToFEd1uyaqTC8SilgiPgHUCL2NgkYZQ54uxhYNu2v+FuoWRfW+WqfLJxkH1mgKije6dBF+1Sw+1sm2fXU5d53KaL9n832GPA+YD7E0i6XMFZ5FbtBggdI8jaAmxe4GuWGnkTKosYQOigmi3eSfiL4sA9QLha7QBnDnsInwJfvPFjmWNWX/txIwNdcdOo8FuB6/z5mOAeV6RgED05bd15lCYLG2apez+ydOougd+7K/B5W5+zFn3Khyin9cKqmoB0vX2alkkI1fzxuWBn21gVi+BoYaCM11Ec9o1QtTM1t7718nnxjHbaezqPl14wvE+lvSwOpaiF9H7Mth2qtpm1qMGh7pDT2GZhT2hx99uywhzWntp8L1Z1weuapQnnT1iEwGMaIcXDJmDUvvI+VaiSi4SyxANvlTxILLP4E6YhTljrbZOikRbz7Iy3ojMfpvDeTYKB6owcaa/dO7nHhLNPXkTbSQWexo4E6RXEXdlJ6Ao+t9OBXNDeaY0ee2s4xq/NxZqwZvXfHyfJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DG7RBuloRAU+qkxB+NPct88V82ZygIPlyKc3FPfPvc04G4y0TiEKN/UIvzo3?=
 =?us-ascii?Q?rlJPTD+TI9QAMQVDoYMBN/l90HjOB8Sb3yIL4nH3lU6PYVlNhUy3vn0ZRDHt?=
 =?us-ascii?Q?+cAnv6oxn9+auHEYJ1nRcwpoHnzDsk8Cudw0n1WSXR630TtM32r6AgY7pU60?=
 =?us-ascii?Q?qiKlGGciv5FqA1FHdL2mLJ+gHoU+aKY9tEc2WvJV3U4g+3cgyXh5+Rbppusx?=
 =?us-ascii?Q?oSbw3JoGlvhdGl/fhlP9djqryo+P8ETOSdtlbkZ7ISStXSTg9SydjGrrXslr?=
 =?us-ascii?Q?0gSEROKMt7LiP3e5mRIES1BP7X6F/WPU6W9uPV3Hi7TAcDqdN515ur3OBfHQ?=
 =?us-ascii?Q?2Ph8PwfYM4Fr5nn5dGJPETbp12uaCJCn++jwDafOtQeQR4zg5Ibwjxge3n0x?=
 =?us-ascii?Q?bCX9zc3JJNTOohNvCIgc4fxF+jJ6VZRqQd55p/c138lzOTg/5cwtmQNSEClB?=
 =?us-ascii?Q?kRJZbPzR6MlWRSq5BKScnkzWx3n+2lqODi+kVLLPu/YXhS9KVAy6Ur3D3Rsy?=
 =?us-ascii?Q?GY1ErvQascu/s2VRHkI3nDiVnJJoqHy3eyl3BGIwd5ZwFfi/Cip2DpHphDzI?=
 =?us-ascii?Q?bUaEbvPSr8EPJkyZWuw9xAG5+bG/qjgGrwRNcXGyeq8NrQDWR7ZFQxdkJTdC?=
 =?us-ascii?Q?89KJp6hSLvDxRJtYKeDmlgTF1IFsPluNQjkZmIO1yo+wucYaWKzM3Sv1MnMz?=
 =?us-ascii?Q?HBAPJ935uucxivDoWiUnsqDb7PZJYkWibYLv4Bt19OqFitie7lL+RzjP4gbS?=
 =?us-ascii?Q?YeIXD4iC5OXONdi2miyQ5FHbRX56l50wms5ozMvpHzOm/ibzZrfGqJ+/+s4V?=
 =?us-ascii?Q?kANgkxNvEqi+AAuJNBSQ8tpjUTBid6AWCJMW6gzsR2ys+JFamv0AiEzm0y3D?=
 =?us-ascii?Q?sr8YITttOMehmckvFhONv1i2UMSoSeYYyiTwpe5ZWquRE5TIePibOrEDCNYK?=
 =?us-ascii?Q?UIwfdDX41QfQyyYz562q3aikRSACzfYGTt2ZnAC4kUjEf6FJJmVRoeI8AmvX?=
 =?us-ascii?Q?D8mpuZCkZCtERFXMSZcWIE7rn0ac4otDenFKMdBDWNMHy0P7KBVOxUiEo2YV?=
 =?us-ascii?Q?f8P/rPBf51R6m2kQZ/wFX3Z9F6/xmqeYkDvmo8MiMpmPEg88MceQtxlaXT0d?=
 =?us-ascii?Q?xKvwBflICR+vtHm+x/FKqL2o0H8pkI06Hy1euxQAVGHGeT4tH990KNQAgL1c?=
 =?us-ascii?Q?5tvq2T7tfozjqoJSdcXsYxw+cHK3OPDbeHSnb6CceDB3IV7/fph80iXP8c2V?=
 =?us-ascii?Q?gwmzXMRcTd9GVSOiYYoRvjD0PDw9O+TeZw2dF0fJpyAid9bfDhXR+Y42V9tP?=
 =?us-ascii?Q?K/0Wpw9v0TjwI/1Yh9siMKjvZb7+QeoQvI6iaYAjTPxxXcQI0B38OyOGsm+R?=
 =?us-ascii?Q?xWfEmV6IhDW7OiE+f0I1YVtZPsA9aVlFq0lfj0cZlfE/JYNikL5bbRS7SVWg?=
 =?us-ascii?Q?Lq2+aptiLJakC/9L6Os+DGDzoQsXoHMybsaU3MuYa8ZOb8Ml7qiI0apCchZ9?=
 =?us-ascii?Q?w7SRKZ++awiLROd2bhf1Q1SZYV+KIkiOLtX+0UDO+S8vnXhmVzdFCR7yM3/5?=
 =?us-ascii?Q?ulIrJ8x4Qc+AJmquuxZNoigXnjbd7hEWzI2zXdjBPh2FWfC2i7n8+Hso329d?=
 =?us-ascii?Q?Q62gAOsF0ccQmFj5j6oyG9ydmjR+uC0SkX/7gnl5M/yb+Tc8JLpY7yUxOaUj?=
 =?us-ascii?Q?+DfkYY/cEQQuyYDizmYCv6xWHNIQY8NJxTtXqxweQicgyWo0LWCi84exb9La?=
 =?us-ascii?Q?iKP+rbScO6cD0WVYPIaQSqk4O3lFliA=3D?=
X-Exchange-RoutingPolicyChecked: DUZ4pW/URzfGh1l6loXgYzRK0+mQcKgdhoTwX2cJJDk/4PXIbb2pjjMykJsJSAJfOldLA2/Owag5BPxLNcZMqIyP/pRZRiMb2gzTMBsMgWqJSuaceaWdtPX4u72wRJvlghjIvPZ8daLKT8kQDp7kyG0HUBRCgp+ggmfYXWA8HM13l48xulA+cGzjEoC/YmG5nUceoXsUeh1rLtLlrOQ56vcvQ/y0cmoF6r9/H/IWgZBw4Cpy8paF9BUXV0vKzn3MwDa3ta8GlBlMJ95BQR4o+XpHRcQABk++f4t8PewX6M4MN2fugxhcbL2E3nsA+d7puF3vCMX0KuezCqgHsGHYrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcaf336-0055-4ac3-1e94-08debb7b5269
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 23:05:47.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6IYaHBB+jmx8Cydz1K43P47uLs9Pfcz1eQ/2EBqu1QCR6RMwdCp50LLIm39WMtv4H8D/85O4TTxNUDsactIGvLXWWljGLY+7CXFSmZr9po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com

On Sun, May 24, 2026 at 05:56:20PM +0800, Li Ming wrote:
> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> accessing p->targets[]. However, cxled->pos can be set to negative errno
> in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> causes the driver to use a negative index to access p->targets[],
> resulting in out-of-bounds access.
> 
> Fix it by walking p->targets[] instead of using cxled->pos directly.
> 
> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> Changes from v1:
> - Update commit log. (Dave)
> - Update comment in cxl_region_sort_targets(). (Dave)
> - Fix potential 'hole' issue. (Alison & Sashiko review)

The switch in v2 to walk using p->interleave_ways instead of
p->nr_targets fixes the 'hole' issue inside the cancel walker
but there are more places where a corrupt target array will
cause problems. 

cxl_region_attach_auto() and cxl_region_sort_targets() both assume
that p->targets[] has no NULL gap. We need to compact that array on
cancel so that nr_targets remains the index of the first free slot,
with no gap below it.

If you do want to fix both things in one patch, then uplevel the subject
line to something like:
        cxl/region: Fix corruption of p->targets[] on auto-attach cancellation
and have the body describe and address both the OOB access and the compaction.

BTW I don't feel too strongly about combined vs separate patches, but I
don't think this OOB patch should add in a partial fixup for the hole issue.

> ---
>  drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..8956b049c462 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
> -		 * cxled->pos so that follow-on code paths can reliably
> -		 * do p->targets[cxled->pos] to self-reference their entry.
> +		 * cxled->pos so that cxl_calc_interleave_pos() emits its
> +		 * dev_dbg() for every member. which is useful for auto
> +		 * discovery debug.
>  		 */
>  		if (cxled->pos < 0)
>  			rc = -ENXIO;
> @@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -static int cxl_region_by_target(struct device *dev, const void *data)
> +static int cxl_region_remove_target(struct device *dev, void *data)
>  {
> -	const struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> +	int i;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
>  
>  	cxlr = to_cxl_region(dev);
>  	p = &cxlr->params;
> -	return p->targets[cxled->pos] == cxled;
> +	for (i = 0; i < p->interleave_ways; i++) {
> +		if (p->targets[i] == cxled) {
> +			p->nr_targets--;
> +			cxled->state = CXL_DECODER_STATE_AUTO;
> +			cxled->pos = -1;
> +			p->targets[i] = NULL;
> +
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  /*
> @@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
>   */
>  static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
> -	int pos = cxled->pos;
> -
>  	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
>  		return;
>  
> -	struct device *dev __free(put_device) =
> -		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
> -	if (!dev)
> -		return;
> -
> -	cxlr = to_cxl_region(dev);
> -	p = &cxlr->params;
> -
> -	p->nr_targets--;
> -	cxled->state = CXL_DECODER_STATE_AUTO;
> -	cxled->pos = -1;
> -	p->targets[pos] = NULL;
> +	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
>  }
>  
>  static struct cxl_region *
> -- 
> 2.43.0
> 
