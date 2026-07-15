Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4B41DECF
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131154; cv=fail; b=VHtnC5mjN8IuZAXDWAteALfw2l8h8l2Iqa3dtCXCOHjVfEihM/kE1u5mp2N4KlADhmnZhjbBdrMo9tUeaeYOFzU4LwYigfribOKFZf33xji1AA1AgZY984EfZap6ck2gqhweVglTudKBd3+vKKuP1KoYtwYMUsQub9DZQD0Lp4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131154; c=relaxed/simple;
	bh=M+zKCRt+EFZEeN440ro7te5MNV5FblXmTvv+ga+w6n8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjLsHCh1VTQNtLEItVmte4U/vblofDHJXAQbJT2jIYdBrHS4c+ive5jSSpzI2CMeVftLU/uUn0yQttY+I4j8zl0xKTyVrXozuOTLk4N2bw3TRh1tnw3ZillaTUSJVBc1cE7my4DLg3Q5386JhAOLLoGbIfVrlf2CTEXphgUPNQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnNplKcf; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnNplKcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784131153; x=1815667153;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M+zKCRt+EFZEeN440ro7te5MNV5FblXmTvv+ga+w6n8=;
  b=bnNplKcfWmpheiv5eSX98bi8kzaUk5Et3KgeSFEzEuAQL0ybLXmxjPF2
   b5ruUBwMiG7Jw9x+L/oP5Lxj5RA7x4iyUu2d53scvS6Rcy1OivCLicESG
   LeJ4xUUrXmI74yT53iQDoYf1Cbt6sRSnC32cK07q6pRO85NypZ0NyV0vV
   FW0pBO6gCQnzl6/wXdu3yI06rlBl4bsu6nlG9MPXKjJfHh1iuBO/oJBHB
   tZ/Tj76Ht3uliu48jDIfgB5GknS1rX1DCxapmxwJP+i/IPaGthxsKHQuX
   NaGgbjrWYRtP3+5AdkUbRhyq1oZt3KNCS/MC31pqOjBuPM7AwXu59aqKO
   A==;
X-CSE-ConnectionGUID: RgE+ZzwiRNWZS10AJ0ErlA==
X-CSE-MsgGUID: pHPhHYybRzODDHbBtU4g+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95916159"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95916159"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:59:13 -0700
X-CSE-ConnectionGUID: 3jBV6vc0Tm2P6xUlJj9lMQ==
X-CSE-MsgGUID: BqZmyq+0Q6Ot8C9B8lH+4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255099630"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:59:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 08:59:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 08:59:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 08:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIJBeXoDA/8+cTN1FGnTpIcDNc/6j1FDrFJmLDEXNssRn7G6ZzgYnt0O8H60OkdGnhlF3fEoJuM6tLEE9VT8FkIOZeRWBlTGZj4GIznBEHQI/hqPbhozBz5h/5SEDWu5kMYpXrtB3P61HWttm/qu+yHtZ/OLAERgl+KoWm51+NqaLV7GKu3AfPgUIP9zhtomXqWbguWwKJzJ1AcFLQ5JaZUli2Wyv/Ye9KsJAlAstHbeDK+YS+tGMPAdUj6TVwDyrMHu7HNXZuB0NaVPFiqeHRYVSqU1Pf3tB73Xv4HNdqtFMjvWhIF/WmVw2x16Mpem1rG3XbDEJGu3QGO4iiuBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iE9NoY3KIca3LO6PCkVMjbyPlvq3f8XXC4+R+vjwt4=;
 b=AQWZ/aHBEzPTSxc4ZBOlFn/LIhLBzjVBSSOIHQ6AhJH5GzHxtlTpvQvllO7T4Rr1GX7c7qvgRLyTznx+g7KpgxF3ZhZi8b9p8Vo4lt+dzZ0TooLFB7x9hjv5Z3ZLF9vKL5wZbEpuWoY+y8jcaXK/dVa5U0cIKxt9oGr9FtCDfqH4bfvypQE9j+8996OrWT5CT3Y+Mny3tTKbla5L/BKaF2R6Vbr+NitlTDLVVhKnkQVHUaVX2YMNtdWAwZik8id3b93Tfgc8BpErWE0keSrZ1J7ZhFdbZ8r9a4EQ9iAS8HUp36F/yNBG7YV1QR/dHi1J/DM26f2gH+E8HIw5Tom66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 15:59:02 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 15:59:02 +0000
Date: Wed, 15 Jul 2026 08:58:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <icheng@nvidia.com>
Subject: Re: [PATCH] cxl: Deny Features commands on the RAW mailbox path
Message-ID: <aleuQp265bt7DRTd@aschofie-mobl2.lan>
References: <20260715155126.1629178-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715155126.1629178-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dad4f8-6c50-42f2-5244-08dee289fd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|3023799007|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UiHP7CHtutlgOIkwKlbcuu6JJNSWVAGWCXez//Ux4AKGQjyCipJZePuYmmST8YqNT7Vt4W41Am1pJvjiwDDnEw2Qf8nxf7Q/cVV6fhAFLY71bH2Y3TSVj2QnWHzPWA+s6dpo6V+xspjSHONj/bkteinZ1Ji/aQdkx/CtYLfhpEDTXxWZCOuschF0cMpYV1+0brMLKupeK2R5N+cpaPqOUMLDAfPYs6WWbJUVQsl5cSEe2Ylj6kb4DvMS/a7lvZwuCU19/JDPiqhY2EIuLpvllLHR73d8oB1NjVkxvrhH1skz2oJSpqX4oDRBbe4ZwBCT07nbbPckQgKeQgWvN5WYF9Kz3um33zF5yUt97XpXkrBzBiL5Ar+j+TjjeYKZqg5bz51OYdqyl3mb2KM8v3capsKLCTcSxH55y6YKi7cVGaoDtYLzhoVeAkzljFgQkMJbVQJWLPl+kpNvgdArP4TRbutZr4DUZ1eykKmqgXMHHhwoy9T1C9hH+h0+UC0oF6LJZJOG8j3y/Uvp3HMy9P7yYCnrOBJ3hXc7ZIUT7JYxdZmDGlMucJT58Mkzvj20nhII+kp0F43ooi9cn/nURXHDZb1o/pWD25t5z2gr1YjadIuMtBL6GJoAgdx3Z67cBLS4DxX6F7XqsrdxyFgC/KEnMc2KcJ02PF5JjP7SwUGrru0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(3023799007)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/7Lv3P8mo6iDVU/cFiamVYZdoNrFhy/goybGH7MvFwERlu3glz2VHv9sLWg?=
 =?us-ascii?Q?/FkpXDQjA59nwX/oDZzq+771zvpOIH4brmkcompX9RICFd5Aw3kZkIm4CY2e?=
 =?us-ascii?Q?ybslWVQYJEqDePoMKOzedxkwcfj28f0JT1G4uJ0vOXiI6XObbj33B3DWqP30?=
 =?us-ascii?Q?upRMcw3iGguFoPobcpAa4/V4PNnMHQcmg2LXu26qeQfJPP5mQwMSJuade4P6?=
 =?us-ascii?Q?cq+qtdcNMutIp6WvBidLzV7CxHFKePaYIZp+KXnatEgAxLljEP3IS/8h1xqs?=
 =?us-ascii?Q?aIOdDYNMqZob8lqD6nzr7sZJYxnydxjlCyO56/1kMK3fTXl08/H0OTFcycq0?=
 =?us-ascii?Q?1pZgkr+qvab/f7ARCI9IHJbQmPIRjdHsoqFQX8kLLRU/9nq7pHg5fH89Etou?=
 =?us-ascii?Q?36USi9Qs7zzdjcPfbBN2qtKwZvDvg1TUHZ0wwbbcE3cvQIBo8OIDibQcNO1L?=
 =?us-ascii?Q?FvrzsHLtsCpKZSaG2LKMQlu/FHGfPPJ99KrdBATBdwt5eNFmrvV/6HRgesXd?=
 =?us-ascii?Q?RCmjWe8RPEjR1lAq4RVfiSt00z/pZkb13qOhTnH4aofKrb51GVSElT+0j1fc?=
 =?us-ascii?Q?4/oDsDxQtzhoKktKiipuBIigj3subODQK+01d8gmJRhKl9SMjsC4B97+ef3S?=
 =?us-ascii?Q?bZyn3BBiUpo568V0+oSq+I7M7m5yVJ38QyPidyGPs5s6JezK64QWg5Lri04Y?=
 =?us-ascii?Q?/5r3FSygp726+IK+4whC8TrnNqJauWEopQ4E0WKfRRtFfpdaN2a8sSPyF5r2?=
 =?us-ascii?Q?jyiWzXjEp2wSOcbcHK/25Tv3DaUmBuG3txFdLYU9xJAcpjr/O8UPfDydQgZL?=
 =?us-ascii?Q?aC37SiG/O9q7cYbWSFMLDWyqQkYvBFCq402QZubYnqj1RArTF6uGmg607cz/?=
 =?us-ascii?Q?4RU1jeLKNXLIkxaDj3WXi35Sc1s293U6Toz/h3sSkfAkLEFnCa7XgH+7fHsr?=
 =?us-ascii?Q?gcMLbHytrYqID+7qNpyRsdDmW02dYbo60fqMY67CHPN4SLTs4nH7bznPm/8G?=
 =?us-ascii?Q?Nfc49TTjXA5iu4tyly8sMRsQN0ClpWkfgA1t9uAzD4kiOMGEo7gr/EgmlMDO?=
 =?us-ascii?Q?OWUoV4FW48UNk6wsv91S3XQPNk2SThSkGsOr9GbHcbAGqLyIQcOQQFCmWlA5?=
 =?us-ascii?Q?Fw7oFBO6eWtsQ9pkx/+y4iyTPL/Ay3CA4Ap3Q6Mhj+/eUnDzpZFKvEXvU2TE?=
 =?us-ascii?Q?+4HTbOT4vwvv7uHSsz/Nuyud45I6/yfKZxdg704xxiC9hW0d+TI7McIki6O4?=
 =?us-ascii?Q?pLs1dgbpXkVGX7Wl//FQA8+Ro+Rl5XFcFHpc/MIf4OBSnt1syQqSeAaRwQvO?=
 =?us-ascii?Q?7A5zFba3hKnLDIqGrFOQT12OwgIqtqyJu4jwod4HT5J4f7kdUwWHt23XBUNC?=
 =?us-ascii?Q?ZwKkwHT09Ev6M/kS9NqnJ6XTbUI5reAY0RjPLqSWqGelfrRqTd1voSliyaYW?=
 =?us-ascii?Q?fvgwloXWqsyExsNHYE1JV84uc7evKg4Tt1yf5uCTLBaoebI3ZTGjau9j0/hw?=
 =?us-ascii?Q?vFtIE1ZGe+TmD4hnmnU6tgMRvXIdQg9V1BSL8/LbpJyn2fd3KTGzHQIaWhPQ?=
 =?us-ascii?Q?DuNAK+K6RA7d2qnDs9ApElWqRuBsAeioVhxgfV/WyMRqmufNFqnPqDQdvszQ?=
 =?us-ascii?Q?fGNIZqTcUGJpSkLiiHi8MTp6Z/Gfj65cJspPHj1pmUlYZynA2dr7Yv6vzZXR?=
 =?us-ascii?Q?nmTag67sWF30EEkvrx1Slq20n2wU+PqT0YeaBi7C6Q2S2pYgcuy6GFGi5l7R?=
 =?us-ascii?Q?T5OIpy6eRfAOtjnj5m3LBHKfCaphHPw=3D?=
X-Exchange-RoutingPolicyChecked: dwE2aKtJWP19IU1ogVBOEH6S0AXKhvE0V+UtEZ//Fmix81k2vWLIj+pN8WWRrUxkyB+QaGxHuwVXOOrpe/639jeNBmPdx9II46zRXc3FaFoyi44dIjnMRefaihrfcv0A9o0YlaImmsWY7kWO72Rbr9Bo5MtxU46n/85ykmndaHOrUr5mRk/u/tfW39NMyJQsbywDcEy0gAE53djaJkC+ib4lBM3hEjzwj1MxzvRwFmP/iJc2eo0fyvbe859/OnAQ3pjq8Z6HZ4UabZBM44y1t+/jeOc3iLpnJzLdwsbiG7JgRSl2mwSKKXoOeoYAc6/d9il8s0Ek0SpCysuTm9R6qA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dad4f8-6c50-42f2-5244-08dee289fd37
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:59:02.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz8OSnYhjs0X0uSZPhLJuBr05lNZzIwZNyv+TrRmCTADiFidY4nH/jvQlbHJaXlIlFTmT60E9hvjpstTb2bUtbDWnL3kZt4Z/KhyF3NMTuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com

On Wed, Jul 15, 2026 at 08:51:26AM -0700, Dave Jiang wrote:
> The RAW mailbox command path allows user to issue arbitrary opcodes
> to the device. The FWCTL interface was introduced to support the
> CXL Features commands where access control is provided depends on
> what the CEL indicates.
> 
> Add the Features commands to cxl_disabled_raw_commands[] to ensure
> that all Features commands are only accessible through the FWCTL
> interface.
> 
> The cxl_raw_allow_all debugfs override knob bypasses the disabled list
> if the user is aware of the risks and wants to use the RAW path for
> Features commands.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..6dea70a1ff95 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -91,6 +91,10 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>   *
>   * CXL_MBOX_OP_[GET_,INJECT_,CLEAR_]POISON: These commands require kernel
>   * driver orchestration for safety.
> + *
> + * CXL_MBOX_OP_[GET_SUPPORTED_FEATURES,GET_FEATURE,SET_FEATURE]: Features are
> + * accessed through the fwctl ABI, which applies scope-based access control.
> + * The RAW path would bypass those checks, so it is not permitted here.
>   */
>  static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_ACTIVATE_FW,
> @@ -102,6 +106,9 @@ static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_GET_POISON,
>  	CXL_MBOX_OP_INJECT_POISON,
>  	CXL_MBOX_OP_CLEAR_POISON,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +	CXL_MBOX_OP_GET_FEATURE,
> +	CXL_MBOX_OP_SET_FEATURE,
>  };
>  
>  /*
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> -- 
> 2.55.0
> 
