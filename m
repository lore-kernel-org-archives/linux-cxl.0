Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68292DB7B7;
	Wed, 24 Jun 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334500; cv=fail; b=IpBJd1VWRA6+8KpuLYtC+BdEI6yGpl3aqMRr5lzjkEDFsObbxchIURpyV7fdCEUcJpRb6NeypeBa7P9hPPbpTAyIsjGS5M0f5PndoK7Cums4/jj2WQxSOpnuL2Beoa8ZZN9k0THhHOFhdkZUeopvlbKeAHXosA6o1W16ePTznVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334500; c=relaxed/simple;
	bh=mmmlp4k5Ss7fGJcWs+S00P+bi/yYMMgWCUMJHjJYmZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNmNWbXGtmzrk3gzwNNF+TieaCXbOqYbwcRvHyJlJW/CdW6o0rs+eS+v6RI7c10NkYtsgy3qsS00zPUodiHxdrQlJqxIoCLiDPRLjYF2DYgzZnNbwxCUlnInynRd3X4w7kQ0OBIruX+sS8FyS20ljDPNpZhzxieMUHs3sMUAUYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyRPzZKo; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyRPzZKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782334499; x=1813870499;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mmmlp4k5Ss7fGJcWs+S00P+bi/yYMMgWCUMJHjJYmZE=;
  b=GyRPzZKorNWMnlcRxeR0BnvEj9B55518X1DDUxYDP+Jts3OqV5vMqJi4
   M5bzwHjXzv4Ez/uyKAturDRxSTEJb9tUvenG2jT3qUUwwsWM6x9IcFl3f
   mFIR0yYWjSYwIYuFbt20DXzw8rjvlgKLqzHQ0M1SOjhgJR0ttADduEZxG
   LCOEkCtuo7hP5WkfQQ9k3/kIuCvIa2KARCOfOZS28MZqNKS4YdpkbBeVZ
   +l5x4RQyGDViBBDlG684VHvjcBnQ+SyKjZKmdQojqjoAE2oVuHPQ2Q8ey
   POo/NF64ALsnDdrPRx2uks/W40bG5M6GQXJajJSPrzkz6NLsGLEsFpEE4
   A==;
X-CSE-ConnectionGUID: G8JIPnNVSTyog21dOvn8xA==
X-CSE-MsgGUID: anXjVhY7SKeieQFU6TYliw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="105900968"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="105900968"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 13:54:59 -0700
X-CSE-ConnectionGUID: dWHZ28A+Ql2XSOxiRDujXA==
X-CSE-MsgGUID: AzAGsjkPRFGmoPvW5g93og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250110255"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 13:54:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 13:54:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 13:54:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 13:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDlpAZ+V3GYm2i5LUaBxSlIAwO932sTJmAmKAATXnua6y3SP16+nT3GeIiL447RBFHWpyQeOfxKEvN1BwjfWuNJyIhtJ4Naf5LhOL38yzz7HZUDNOrNTpxB/241ChCqM/E0t4Utqff31sjgeCN631Xfi0VTX1KDeDHj4X54QM4JTFyKlDouF84CDK6TMA6LK5m0IRO51UqD1d1A3WFJWwkzuphZh57GX23oucMtr1D28YiV1dVSZ0uhDvEC1SJoAv7GfJv/20rfBnBNHDrOxLXeIQ4VuTWlE/xzFHNRKR2H7SgJFIIBCxLUd5qvQly1JHHDtEYIGEsBtGERviPuBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XipSyq6D/+jAm6gN0vsXQoruuoGbsMzCgCeOZbA7AyA=;
 b=V538NDj6CTWRartmeMQVeb43FcTBCuIMml9LAgM261yTXPfslgCb3q/aSUScPOZSqIGg89LvFL21GaR8KwXk42nG6UAnhgE+FFMkeaFT+1H8SpTIw4ANGihbmI026l0WK9OPqGrBbLy3MsQchTJ1qEErpIaxrhja6cS2seUH4NNxxzvzo+Gxrfib5ctwAJsUt4KKqnmyBDwZ0SVD0uQyRv4vTJsQgRbAIAeJGurjTQigtFvkCeyeYTvh9gawuXWjjBLAMhyR3geBZg5NKC0slABBGigEU02fmeeQdOudRGeR35y6Fwc6WByBKpbzu8e5bTK/P7e6j6Bd8PGOZ2I1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9545.namprd11.prod.outlook.com (2603:10b6:806:4e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 20:54:55 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 20:54:55 +0000
Date: Wed, 24 Jun 2026 13:54:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kobak@nvidia.com>,
	<kaihengf@nvidia.com>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than
 the output buffer
Message-ID: <ajxEGmGxOhryENl4@aschofie-mobl2.lan>
References: <20260624134737.49166-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624134737.49166-1-icheng@nvidia.com>
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 8899f1da-b38f-4ee1-f47a-08ded232d837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|5023799004|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: OzTR+fu3Hr6UCSw2NIRLXvaPd3hGGnCBHVwSuIygTXsbwxCAXwAcO9CplvY5ap/MQ0OXDiR72jhj8/4SJUVPZPJ/epuVACbhn/A87EGBh7wq2IPhgbVB2BN0tGdxpblKeA52hfK5bEHUuLiSEYPZoy+DL64batMh/S/wiNlO0/Cv78ODSlqRJr2QzpCf6sJsfqqj4kbULdd7tY5FCDfyiPp/W+N006TLLpbCXMoM4KXjq3UcGRIzsRY24oN0ydeTHTADpJMeQAP8vaJd9fc8hDF7KFqY3ryYfCuD4LDdZUUVqh7f9dN+8nt5jWQSAk766CWcbXfZtwKxfAv7MMFGu7p7PqOl6VuyrBjCWVGUpZ79ttYyWLpzozoyuegY2j2Wm9jAFUl7l6KMGYDsXW+BzwFz9HEnh4pKweqxGM8vbb7NgBIEs5EVDmqQrkc6rZSifjgxxdE8DUVMqjAreQKTjAJO2G4YN/oczRdVYBFaIkoO+Z22rKnuWTZZQKoYUC0WnN/zFWMemeQDTZZqCmBS9E92LVOTpRs1S/NKrnKOhcpUsWuDJ9xDFuxnw3tC4r7CB+OzN3QDetUVS6EAsO5KL5W39hmxC7ZrUPrxtLi1gJH8B3ApK4catLbh2N0LT1jQiIeoI7fsQY8Jj9GK/E9D146FpfZJd9TGgmsA+U1dEhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xo1ax9AHIihOohoG/k1kNsOy3kTYywkGHpAqfcI462tmsRyw/QPB6cj2lscn?=
 =?us-ascii?Q?iydpPdm+q8rx9vOqgi5yB/mwcwkm53B1JqPYX85CfyUafrp2/wVBsgZkWzZp?=
 =?us-ascii?Q?xVKDEjRa3o/3JhLqe6hzZYYg9nexpGBR5prpHKh0ZoG3WwK+Qgp+uZwQrj4q?=
 =?us-ascii?Q?O5HYPo0LUWhP5hCgoUvTNiFmj4ZtJre4T8GJn7dPEtDrzkcAaceaNOq35nZK?=
 =?us-ascii?Q?0SptHzPEr4vnHRSrjFoEzI1dTfP7OwTZsgWUHomr+97/+cFXSmtG9cL/hLkI?=
 =?us-ascii?Q?ENEaJQcWXg7XHbTr4R4AjUNYKzLWrYRZTUEL2U+d343xWBc467Oi9Mb3SzX/?=
 =?us-ascii?Q?On52buAZrfcLc4/A//gN0h0naGmw2g2bN/SZtx4P4JmszvD2EUFiYMyNt3ws?=
 =?us-ascii?Q?m105bRKMsYFkTiiNJuiWM5/qCKVlZEk+P//f1KqHThAUfUzmtMhpdJs4uSFR?=
 =?us-ascii?Q?NIHWnC4wFnsxwdPXkKi3MNJjzSHlhDYg9hE6au533ApU9wjxQQ9gbpYjbwq0?=
 =?us-ascii?Q?Awv+3GskH96cBSbHyjzY2Gl9uXjDh7V/tpsvONPafdULp9+/WAASPr+9kPKR?=
 =?us-ascii?Q?tiZv/y20qH6RdTyJB9PzTjGktspvqOhIBN2yxD51l1wqUzneZN4qbpY5fOWA?=
 =?us-ascii?Q?1i17B86Ockr/gywtXDot3Qw2Tbnss5BLz+GAgOA8oI9VF18O2p7xNgNA45oU?=
 =?us-ascii?Q?H+bCtNwRMDW9/Q1AMyOg3sn6L0667p8qIIiH1dHoprsVcI+p/4p/EZyTsZcq?=
 =?us-ascii?Q?WUcSuO47gyOwqgnI829xH9T0pOYyFUtJsEIgMq4wDvgcf6FWKP1Olj37Cf48?=
 =?us-ascii?Q?vBU8Evfri0sDA9p+uPqPpCSMocqWMLFIEAw9Iot6XLtfZrLXmBgZHazjbqj+?=
 =?us-ascii?Q?BPJ2hdHMSfwMyRv82/nWPcy5v37E8fBa0Rg6JO3QjOQzpQo5Wy7IFeJubFJG?=
 =?us-ascii?Q?Pzqakjbc6xBQsm1cw/m7xVVa9MGE4RTVK5RjMmojQu/yOZChWNNTNzG8q/5T?=
 =?us-ascii?Q?tTHsAeU0wmj+lEA0cHPCRQcmNw0JNl5XzCHhIMSsTKPdmf4UYwSXJ1huEBKd?=
 =?us-ascii?Q?nwrr2dSAOFirdTs2Fk2N7kUA6bCuxAmRuUGA9AzBmEKR455J7ObwIns3XXyc?=
 =?us-ascii?Q?/vdeTD/SVbQX7XxKdDK6ckMto7e08Ls9Ei6feUesYcx1e2Ewe/mfOuFFlYjo?=
 =?us-ascii?Q?SG6yFUbB8oY3JvSUJEHEN1jpKo0ez4I6eB7tckcNDd4/Akk0uy7yNTfCCzGF?=
 =?us-ascii?Q?8v/FHM68SPLmcInuGsxu2zYwxkBzrsmIBCADqAb+vNoejNaT6Yc9bq5/6CyF?=
 =?us-ascii?Q?7NudjiNAeTCPWGmWyIa7/y3o+tqwHVSUN6JIOhueG6LiRDicpcyoAmpiejyM?=
 =?us-ascii?Q?Xhrn0pbrYT6Qfxtl57Nydm3mDOGAYqDS6AQBcj3wtlWsH9gzGtzM6ATrj7fc?=
 =?us-ascii?Q?y4sE74GJh0iUpavhEMDP6gEHjPiojJyV20T1w8vDemERr1OkxXdYw9CEQKRI?=
 =?us-ascii?Q?v4eZDRX+L7NlwYTLggcxDc5KbDKzwB8hKYhXLc6Q98bGSVAgMqr6e6yBomnK?=
 =?us-ascii?Q?CKe5L4Gb1JL4j0lCSRPVLGC6V/U1VGurhjLAnL0JbPLeCdR0GNk8CvcCp3Oj?=
 =?us-ascii?Q?JZbRU8RMZjhXd0MS1+3q2QRUIgqDhD2G/ruh/csVkboefiB/iYRst3L5Bekc?=
 =?us-ascii?Q?6GiiKFEHe4n2GV9Jgm1wQywEd8/g1xfTEVSRd8QooOgVq0dfqxUcgo58aglW?=
 =?us-ascii?Q?iBot7VYb6I4xz8J91+O0KNaXlzHpHDI=3D?=
X-Exchange-RoutingPolicyChecked: Pf9/6wU6AmNDUqRtzNyT9DtXSAC9hFgY/KRjKOGBkjFNbpPsCkLiTa5LmuaYVkb8yvLtdus5DOIrecU/rrBIc+CbND2iqiMicO9kD+4FCDtjGVzF1vHwnnFz0IQveDWMkkUFZcy+Fkv/A9XRUZEp2A5Sa4xZA6LI14r5bFO5CybTu0RIjcFKh0uPvpJRFG6B76t6N0hIEItC97y7PPw50uOINNBXrax6istkjVaoNAuF7L2tw+8Vqt3Ty03+883lTfHyq4botoI3NIP2mJlx0H+fTd3IRibHnRMkLFEjMJNP0A+X6pEeYHetGIKoM26Dp/lRDZb23FjbQ8T8AmlXPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8899f1da-b38f-4ee1-f47a-08ded232d837
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 20:54:55.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbNKhnqBXL2FXpVB3BxbgIQw/XPMTSgJ92QC1q2VI0Q+aIm22ORiiHOGXL1TR31d8AvEBJUjY0q2opVtfV48aCpbJW1Z5RX6hxXilCqqBM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9545
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 09:47:37PM +0800, Richard Cheng wrote:
> cxlctl_get_feature() sizes its output buffer from the user's
> fwctl_rpc.out_len, but the device is told to write
> cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
> separate user-controlled value. Nothing bounds count against out_len, so
> a small out_len with a large count overflows the kvzalloc()'d buffer.
> A heap OOB write reachable from FWCTL_RPC.
> 
> Reject requests where count exceeds the available payload room, before
> allocating.
> 
> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
> 
> v1 -> v2:
>     - Drop the reproducer and trim the KASAN splat in the commit message
>     - Sent the reproducer as a regression test in ndctl separately.

This patch itself looks good. Looking at the other bounds checks
Sashiko suggests, I'd rather see this all fixed up in one patch or
patchset, rather than dribble in as multiple patches.

Maybe it all fits into one patch, like this:
cxl/features; Add bounds checking for get/set feature commands
or maybe it works better as a set.

Either way, doing in one swoop would be nice!

-- Alison

> 
> Best regards,
> Richard Cheng
> ---
>  drivers/cxl/core/features.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72..9c714ee42a41 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	if (!count)
>  		return ERR_PTR(-EINVAL);
>  
> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> +		return ERR_PTR(-EINVAL);
> +
>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>  		kvzalloc(out_size, GFP_KERNEL);
>  	if (!rpc_out)
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104
> -- 
> 2.43.0
> 
