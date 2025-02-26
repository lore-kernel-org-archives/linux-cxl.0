Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0227561C
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601996; cv=fail; b=eEyM05acM7+6UdZw7k51GjiuAf6QFusQYlpk906h+2HG6kHa3/LRzy+OgMHmQ8On8/qc0ItQTawXUC9+RM6WgZDSmYdsMoA6nQYbJ6Pb/6/7PaDAdL9hGQI21g+M+H2ehz/VlFUY83PD6IK0vJB9/4FP+rDHqj/V/h9C8HPITDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601996; c=relaxed/simple;
	bh=FtSlPleH++C4AFCJeNq66H07kBvv7SKFJrauUlIr588=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z91K1uWy2IjkrhKKL/6xpPvTnioCtp+dgBZsp3nKnYe7jDKcoD2bALnS3LFNkiX1soK2IWqeqk403TRzRa4OnElVbw42xzT7ybuWTCXE3mJzCrweuS8uUTdIO4i5pbIrE3zTvKmiSIE/2XdNAjUgMbN3oWecfQ/QVVv/dmaDLrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGY/mQGY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGY/mQGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740601995; x=1772137995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FtSlPleH++C4AFCJeNq66H07kBvv7SKFJrauUlIr588=;
  b=jGY/mQGYJqK7EI0Y0XHOH5wKpzuYZrjXSTQGIixsFzBb7OYNKiaiaMgO
   6nZ5Eg7E4pVG64CwR9J1BpmLTd3QLuJt8s9uRgNKZEvzyMhFpDFsASyB7
   pmtMWNngTPOZE4BEIyAPgyg0XBIEh4rSDQ34yrkwooP3C5h37WtxSSsSL
   Bf6fPWzUgWghwRtqvOY1/j8jO2qy49/IvaanR8jfxv89HYbYnYB6a7NTJ
   N7TdL4ropU1Kp+0DvdnaXeoOKYSWVj+qqLM2ATk4ERwn4eMrMjI7g1ekC
   5utBLxvOE5opOL3rdqkTIbCfza1MQ9ndIJ9PkgepcYg3+AZpr7mmsjJK4
   w==;
X-CSE-ConnectionGUID: gtsQDSbXSkWPwaF1WFa4zw==
X-CSE-MsgGUID: BIFe+IGKR8SgxVSMEF4PUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51677507"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="51677507"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:33:14 -0800
X-CSE-ConnectionGUID: xBQ7tWcXRHO2J/OSSjzk5g==
X-CSE-MsgGUID: v9QKfN2UR2KrmLkQXnN4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117725744"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 12:33:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 12:33:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 12:33:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 12:33:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrJk+JDX0wRF0uiPctZjjlrHGTeeCtdOILpmGrREz0SjlnajB09ZsodDI7wwYGqf1YIh2t6enyR16qLEhWw3ZlelhAC4sTEvU99Z6JDiksQjfUPxVqnibVfGTggUsVMuqj3eR4SxJfV4fRs+wSEU9981YQWH9n/bO0L7dOXkRLmKj4s3g4RbW70UjJdh7dAdeUS6Q9YZ+kstz0H6Bb0C/OCBLdsYvsiQvCiKmg46SwaRbBJMpsdpTY0n5QYkouXvpiiU8eMk5HF4nzhmuWokOzpjepnYtOWjdnR7mRqBS2HixeDqwHYZmydXitYldfHRnXz8d7qjayoVBxbrG3Pfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuaSbht5Z6KtiX4f5KznpgsJsHp1WrZzxnxyvcTAKPc=;
 b=W8OsNZCcUezBVcztlUHIYnKfAL+VSIspzhdGvTcMq8jiHKOa7Dwv4OOjuDx/+YawnYfM3M3TptrPCs6WDGhpPmGCT/B6/jTZB/nnkGgw/UMoXxFWgMTBHSD5gEUiPMHUEtHLQGqIRnlVyawQzWV9mfDia/QWS2ttCrpBkIJiHLaiyYvGSkuf8MSxp1xpxw+RKbF+PfEDujK59wFSh2AC+Af0Q0HDdIsxUoyQpU3mN85QyMN8i9K404tsb3uZSyE3AaggV3m+7tDyfRJZhSKraGx2sfrXhwbu6AXQ4RxThS1yqCKctirANpsymlH0HrWbiW4FLAts0psVMLxG0Bw6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW6PR11MB8390.namprd11.prod.outlook.com (2603:10b6:303:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 20:33:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 20:33:11 +0000
Date: Wed, 26 Feb 2025 14:33:14 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: Define a CFMWS capable of a 3 way HB interleave
Message-ID: <67bf7a8a66180_5bbaf29425@iweiny-mobl.notmuch>
References: <20250224235032.2259058-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224235032.2259058-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW6PR11MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: eac82ee6-8685-4d41-398c-08dd56a4c9a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fjz5lrrS1PyeVW8/MVsWy750PTvR2aJ8lF4euIh2AWJmESFdz4VuuVZYTF+Z?=
 =?us-ascii?Q?/LNLOrwU8Cft4bS5lrJEcmuVqTg/x0sYa002qSNd0dDMII4dOFH44u9I9R88?=
 =?us-ascii?Q?J2dJc1j0bwW+D5ZpEglZELjaPTQhFqFMzkNdrYLSQDQGvEnN27oRaFLitWSA?=
 =?us-ascii?Q?5WBSXiyf3CVcb6/9kkSI30Kkh+J9eQyC2nMsGVu1nUYLDSPlngImgbCtdbhE?=
 =?us-ascii?Q?6Oe5VJADcpFNRLkBkPa7H/XL20y8jhisFbZmnpkTqBdPmCjmcU20wr5RgZLW?=
 =?us-ascii?Q?yv7lRSzmlb4sxaI+rfmVaxP2GrfcbGJ3IMOIo4cSDX/nd1izwm5RLDs9+HUc?=
 =?us-ascii?Q?2DFgpf1zIiWsfGx1BqKRlPSIiMA0U1Lx4aj+n/Pis7A4+z79pJGLnAsDqDb3?=
 =?us-ascii?Q?P9DQ86gvBUUzAVnTX8xD1+oxFq4Mlaps3NYU53dvkGFiiyaLF8dxsu8lhS5Y?=
 =?us-ascii?Q?KvKvtX/M+PSK+Dx5smRM/SV2j0A+NvKajPix+jSAmAcva3FEk2pFRJfJa3AD?=
 =?us-ascii?Q?Fn/H2ljDpizOoPM2+LVrvs5BRUvEsnCSq27XSSXcAAre5U5JnCaU4eeVYzA3?=
 =?us-ascii?Q?Y/q1jiDdzRDcro1rKgnVa9voM1+/D/WgxXL+cWE+sTfJ8UA9CMDxgW32BTyR?=
 =?us-ascii?Q?B1vX0Dp8o8L1G1JKOqVt8hNfuQ7+FFwnKH4pcUoBopfnATO9lIDQA3rUvrSC?=
 =?us-ascii?Q?t/Sf8IsW6ZuUw3sbXO1IZu/ZRwztEfWSf0WqDvaLutdoWdSupyhx8hkMDMnE?=
 =?us-ascii?Q?li9la4P+k+cls7GhuCpb2o36V+bU8s9Z1bmQQiJ5eEN5DGQNkTV+is1AZQAT?=
 =?us-ascii?Q?0D5LlFaEJI8z94wW3YVC8B+3es7qFQZmsVpyg8bVygPoyCvWJb6hiF4rb4t0?=
 =?us-ascii?Q?cZB6Ur59XYKr7kbmEkr4kJeWeD7qqnzFd7db0VkY78JB2MOz+ZBAi8d+7DF9?=
 =?us-ascii?Q?mMCgx/856uN78vvIGvcGsgQgDhVWREU5OIDmsMaEoMxuDqEYES1SG1lGBb7e?=
 =?us-ascii?Q?KDAptkI7W8F2wnL8f1552p4+FXh8hRYDkx5qOOQuswRD7vjGc1A/F9BqwqTh?=
 =?us-ascii?Q?agFq23g4IWz2rMpV0oq+ELYwTIsCgphyaRUMsYvRAyHPXMpg4MnQDCyy6vGj?=
 =?us-ascii?Q?ttFsiFkmNu3Sh9HLfC0enA3/uWP7OCVP2zPQKe/yqMKlmRjoiYkOvz4p1SNR?=
 =?us-ascii?Q?xpZzO5W+20xOfdP69XV2LxRID6vCJJMCw55M9nXWY0VxPZCpNSEQOY+ZLWtr?=
 =?us-ascii?Q?Fw7X6Sblc93xnvhtXKp7poVtFaxndYHftY8uSLHBuHLkCEX0OVNMlMqhU6Hw?=
 =?us-ascii?Q?rVpDMExPXgusUIaFm73vL/1T7ozLQpCRNQVm8dbUNPvX3m9AzgoqOFwkvljH?=
 =?us-ascii?Q?BDGWGQHE2Bn1498ON1Y/dmGNhrDR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+OEtem/DLvSX227Gt9EL9b84En63V90omvZueN4pRmRZG6QrdaahWTQOaUo2?=
 =?us-ascii?Q?O9WJdAAGB7tTYBmbPjS7KozZaiGjbtQTvdNDO1A2AqUkJREYWaDSS+vB7z4M?=
 =?us-ascii?Q?rB7ckVC9I/CCkzuQYXPidQ3KHAc4go8qJsaUZCBFP7Dp6vld/vQ4tGgyUQKM?=
 =?us-ascii?Q?jN5F75lPU0by7R7YGUgDLY0k6D0k5uAaiQrn5nLUeeS4KYaGWfsc9wEvWPOV?=
 =?us-ascii?Q?AAgqPbObp4NxtS0P/WkTXy4ruo51XuGiakt5f1et/1RQPa+XR43YPnjS0qan?=
 =?us-ascii?Q?l8CFknK6NSScEVm7cu+ym37sCsUNtt2CHu4CXWwCNOCjZiVzrkhhn009WMHv?=
 =?us-ascii?Q?V3bvW4uuSvea8rGn0kGcAltOgZXReVXTSDjYnovCQ9BNpALfS1jL858Z4Jy3?=
 =?us-ascii?Q?x9Oy8XVKpuXmRoqhgewx8EX6tcEcocihCOFJfwCrCuKcmCWZDLZQ39xRFe+x?=
 =?us-ascii?Q?g/vhLYYxgD6jzJQfPLw1okPUuQxiOWzlpPviR9gzGN03ASHhIiTbPl5WWf7b?=
 =?us-ascii?Q?T/2focEi3OvEp/ERJ8nDaGFSlgaEj8griUBIwVgMkcfLYpGlLIs7118+wf/L?=
 =?us-ascii?Q?+O+MlUJdzHGErnsLlDMDU2XUCrqMEu7Riemr3Pj3gZDSykf4JCbLpf4GnES5?=
 =?us-ascii?Q?6YV7U8aPa0TRlltarPZZNG1q+0ONWbpym3G2dwV2xThL4CZT7YQgnNZUZx6Z?=
 =?us-ascii?Q?N1FdNg78kevgUeof7rJThQL+Yca0sJ1xK6b0la7iUULg+04VDwpyXr9kgfjN?=
 =?us-ascii?Q?xwVvcqE+FZd5VLU6MaboqxZk04QkD/YodBwtKcG9tVSd1212UxragpPAgPmQ?=
 =?us-ascii?Q?XwyQE/RtIQ+7Tz0i4zQwktBDzaNbq2ytvRWqbrrcySyPjTIoRRN3P1cfqIJj?=
 =?us-ascii?Q?wlOVpmRjbsQw/TNr/xehk2/Mswpih3U+Qid0wSaLMNimEHFnnvvHeP3G7gbl?=
 =?us-ascii?Q?hce/XzniK0o9rmRAK2dE986PGxxcuuwsRTkIKB2I0Nei4TH1QJKVcI93IDkS?=
 =?us-ascii?Q?yXB1aUquIR7nZFD2ddcsrxPJ4Uv7q3oxClLP1bjJvm6AJJ7JlqLacnBkkwTq?=
 =?us-ascii?Q?Rvw1RsdMp1dNtsZLKWQApaP2fzMkW4x1tqJwmtwExTWh5p0EuQ2+yJlvh2im?=
 =?us-ascii?Q?ng3t+PyLjGljc3prZgeY1mQYQgpInXim+IqML7Cmmu6iLnlPDGM02n806C0M?=
 =?us-ascii?Q?XBkqDva7U8lC/2zCs7AEUOR01vwQEvR8Or5N6nNFlAvJpRfW55YUhrTaHFih?=
 =?us-ascii?Q?l4FlQufs5reSL1IyIoIdiup2nDcd1jLY2k9Tvo/ZBC3vTvSV2x8CYjNAJZeD?=
 =?us-ascii?Q?njzlNXGsX03+kHxkqB/LE/J0o9rsJWd/4+TSp3L2nSNNB/fTT10SwrmqSW9Q?=
 =?us-ascii?Q?EEyMkybSE6Hxindd3N8/yX+UuJGjG58NgJuTifTG9b2SUABLn7wvwnOih7wX?=
 =?us-ascii?Q?/3yFySJKIqDk1EuI8vorPeLDH4GUtB2729rYWqrqrlMjoLTTL+JmKMdnNoNP?=
 =?us-ascii?Q?5kicrkiHXzCRe3yUas2pjVLpZo1dm0518S8CfOMXmLmeJNfzALllVRJs4YBW?=
 =?us-ascii?Q?VM3E/IIoV6dMqsYVAJ2y9AM3xJs1i836/KeNU9WR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eac82ee6-8685-4d41-398c-08dd56a4c9a3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:33:11.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2nNGsZVBthy0H7ILY2wqiiL7KmQ8jzZlBiJ7mhaDdstpt5ej+BWK5vBNbJwRc/5hYO7unHPCDA6LBp6TV4I+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8390
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL unit test cxl-xor-region.sh is skipping a 1+1+1 region
> interleave test case because the window is not defined.
> 
> Additionally, upcoming expansion of 3 way HB interleave test cases
> (like 2+2+2) require the same window.
> 
> Replace an unused CFMWS with a 3-way capable CFMWS in the set of
> CFMWS's loaded when interleave_arithmetic=1.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 083a66a52731..e5cd874614d2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -331,14 +331,14 @@ static struct {
>  				.length = sizeof(mock_cedt.cfmws8),
>  			},
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> -			.interleave_ways = 2,
> -			.granularity = 0,
> +			.interleave_ways = 8,
> +			.granularity = 1,
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M * 16UL,
> +			.window_size = SZ_512M * 6UL,
>  		},
> -		.target = { 0, 1, 0, 1, },
> +		.target = { 0, 1, 2, },

Minor nit:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Should this also include:

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index cc8948f49117..f0b5b7b8d1d0 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -155,7 +155,7 @@ static struct {
        } cfmws7;
        struct {
                struct acpi_cedt_cfmws cfmws;
-               u32 target[4];
+               u32 target[3];
        } cfmws8;
        struct {
                struct acpi_cedt_cxims cxims;
