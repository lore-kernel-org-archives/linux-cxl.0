Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94427E076;
	Thu, 28 May 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932448; cv=fail; b=L9OVue293IP8FphjzfmjXICqhhsN1G5a+C5rP2acK0dF9yzE2pJ7d8bwE8fdIQaXnW8/AcBaIXqDC8sPWon9sdKRZZJz29ZeQ+u/PRKiq7eMvcm2Ph468+eKuzq++9JdDUJ8XTPPIcP2lYvaHNp8qgMIgaw8UdkcT7HpXOJgSGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932448; c=relaxed/simple;
	bh=zOuwRDCB1JPCJgEleJa2xlQ3U1G8D/BTRMVwLMPGruQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NvH3eJ6i+b9kc6hqhbWlGJbVLekXYyq8JpssjvqM2+rsSR2OqysVJwIJZlKYQwoxClY6ZSi3XaitNq/IFl2mVCCX0KZ1KAsGbkb5fbUg2EGNvBhRI/1WVK+FzbS7dJLG+ZLfXHpNdfOzXDBWyKiYvcgPv0PVPpluJIQPyAZnD48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUvqF0jI; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUvqF0jI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779932448; x=1811468448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zOuwRDCB1JPCJgEleJa2xlQ3U1G8D/BTRMVwLMPGruQ=;
  b=dUvqF0jIxK7PXaGtEoyiO0ZLok4Z96iOJXHR3+5pg4JpiVPgw1vqrABN
   fnqlhpqzYgBoS6Z6qyr0v9tROB/ZWS3rPtdZy2DWhq7BhJA8XOaMybphS
   wO6HRTAYYMsJpk8x2dUGjaxFaa9XWoWmKJKACY46pdsFqYPBLD4EeEBUK
   q0FQOhlbWdlybBfQzI1I3ThFDl4u/GQn+DOEZ9Jo8Ku5lj7u3WtKokqNm
   WDIPdLk7Xupf02o4+eoIVEEL9b/W73T9CwF037/ECNyQ7SUKQCMmOAApP
   fbYGjQFdqU5kHwYaat2Bq9ehdKhg3lfZHxl7rcwG1zK4ibnpMK+Kx2eaD
   A==;
X-CSE-ConnectionGUID: huTNBa+gSAOOg0UXdaIT1g==
X-CSE-MsgGUID: h76PibQAS7KmxdusEn7A3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92160325"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="92160325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 18:40:47 -0700
X-CSE-ConnectionGUID: b53zisbLRmaxOroRHL7aLw==
X-CSE-MsgGUID: EZxYnK5FQJGupKBORmzP3Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 18:40:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 18:40:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 18:40:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 18:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+87DdjZfr5TCvlUIyNPOspIxPG/Jrlr0i0uTtl5FyErsMVPymAk6QAhGrpA/XpicLWZJ/ToqT1MDmLfD+Fi1MX+WkmKeXZjxSk6TpHwQd4RHcatdJ0SDyFstpMwq9oXuiLqjLRwgOy3mFq9UYwA2mlI1+yaZ6sG292T9EcneUAMJZ1xHTszi72b3n6r5muqb3VFDRTRSU3V2Nk0zTPJJQ5SJQNxgaMLHEjzV101SCU3PGmyPfkA/N+EdvLd4iR+LfkGQEIjisXJ+cJ8eVgM77B4GWrYLLp5NaJbc+SUIL5Mu74moLIrZCWLrgbCG5sIEsfu2rASt/AKL1PfZtHsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa3eGC3Cp59Sf+LKgx9k3Tavg7+om62P4UZQeBs+/xQ=;
 b=SNExC6pixvX6H3FpffKi8d2ycRfSvpPMmyocH4iIAhGi16YN4qFZ7GoYEhbLU+5+vJ+MDXarcidzc5ptLtj5GPdlXC/9KADG6l/2gET0Pxm+/EbTTUTB0pyWD5h4CZUwH0xOhxg05yvQK0P6u8NnahgGbU8NNVFk21HT2kvtHJ8hpJErAZVrj7teSKUCNsTWfPVfdkg148ur2vgtUaEAfXWcBYjkHET9DesGshavyIhKaFybTn9depzUlRsHCK9osLj36zx9QLIDJUtJzH9waSm3epPpQDybPOz/yLlB3mK+cIlZ7H1akX8gYNn1nlzDCxyqSgkVXE4av01fEgyvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 01:40:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 01:40:38 +0000
Date: Wed, 27 May 2026 18:40:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.ne>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [RFC PATCH] tools/testing/cxl: Support multi-decoder
 shared-dport topology
Message-ID: <ahedDZFbtaMUqeBM@aschofie-mobl2.lan>
References: <20260521084806.28232-1-icheng@nvidia.com>
 <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
 <ahAvg9I9geuaBrEK@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahAvg9I9geuaBrEK@MWDK4CY14F>
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: f525179b-2e1f-431d-62c1-08debc5a1ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: G2Cnd6bydbFL/NJbzRW+zR3cEu0kwyUwVp2gegcyRkAnSamSkg6qVMYqXH9lDhdSSUV3V7U3zhfF+ZA/zT6RCEDKUTRIXi+Pdft3Jjx1Nd4rvAOF5Mhi6GkkVFXR7G40dyjgzbCSOEonFAJmDBuy5l1zc2G3hmYWL/Kh9zDIQCnnSnY9HRMIC4MaGfnG+ci6sMSf6L84tqBnKl3ZmAYCweD9pbogladtUDpnytdVEC/v9i4S1+X9RWpAxSPVya6yKXgWdTmYUsBF/nLlfyVjzGfSBPgm3+0R9KUUf7W0Ujb2ihISPXtUYPnW9o1L//BvQNort5WlmDn2ioRe+lyNwImCsTl05CBjOrzg8dn/E7SKHsqtZeyLks79U3E5qXqji6x/w087ty1aeYhBJkZ0PLbTP+/V/UH16gnpyOxHKn6p0Cju6hk1+VBd1DkwL4lACnAzMjnO71+LmkUsLN0LLl0rhmRj7A7b4Saj6agFYfIn/R8dkpnPKmSEaP38VprHq4NLqTI0oDav0nGhNlimT9Je+ppYtHcMwwo4MCcUqn2qnFPCluO6Y2R7U1IGFuFpYXyRy/uQwqesWdqR+V+MCSqoChi+iDWuoQ1FNe+IuTuPBV12eJ2C+IN+Y2HoC2Y/qfhU+VFK+DfCzkGxUYXdk2D2cAbGlinWYMSTHts8PG7l1rDTI3Wmtaf94dEdczU1SiU8Ux4zfkoXMPI5mcRSrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OAevZzR9HxK0Om1WF/yrRT7aT4XjVkWqoY7nFF1cuu2lHDTYFlwiDIWocEKc?=
 =?us-ascii?Q?/+o++t97rie/NXYSmah+tOiAlTUv6Ut27XwIkC5g26Br6Ozr23HY4EajTtXR?=
 =?us-ascii?Q?p/w/he35NO3F4mo63s8BjSAfCkp0WiarNXrSPtQZP1ZXJBNEq/L3/oSXeaih?=
 =?us-ascii?Q?64F7oUtg5LfqF+myshdvqI+4NpAJ53sZ69usGvfPISMUwB1K85UyvHMFH3BR?=
 =?us-ascii?Q?RXx2zjo0SJXV4MmVwK1zEthc9H0q/t1k/n5U970EGG4oDU3COvNrnZ7EiaL9?=
 =?us-ascii?Q?k2dGgSspWv1hHrEiKR4I29IjFzi4qvmPQ0hJD0wKVWBhCtXT0O6ZaqiovtEG?=
 =?us-ascii?Q?DR5VzOG1DkOoi/xcL0gSbgz735EirV5FFVLaf5kPIP1Tqgju/4sz4aP3R0A5?=
 =?us-ascii?Q?buP6gyaQzlWx7XLSSUqpJfbGjPwmIWTfu4akEcEM8reKrCN8eLyDx33DqHDy?=
 =?us-ascii?Q?J+gBPyD/0pXU6w1X3qGfyRM7Ktd0lmiRa9E/USddh8EDdGIlMBaZe/mSs4eB?=
 =?us-ascii?Q?Jlkht2FzDTN9P1vrT+3wmU1hpuTJUO6dgNuR1mYG+OBNenP5gPFaTDRkKNmT?=
 =?us-ascii?Q?21TetR0e6PT7ezLaul7nuZY+tE1uV1cBmCKdVgjJSCXbUbvR+chZl97x8lkC?=
 =?us-ascii?Q?whcVgu76S8U0iYWp/XgMMfnkIgnuWImFUH0waPQc+pQsW2RzgM2Q+NiCE9xS?=
 =?us-ascii?Q?J54G43ihZ09mqOwAdXrExJqJdQ5H4bH2BeRiGS74zbsu6nCQpb9AjERZSoPv?=
 =?us-ascii?Q?tobnoNe4Pxu97OtrXkdcQrnzvcjJwR5EIoNT8lTZbauOrBhO3GFcKnRtqBLi?=
 =?us-ascii?Q?KNpW6LCvqwck30CQY+DSpsfuYvfVpW1QvCEuJ5SN5AqiiqpnQQCJWZkZJbph?=
 =?us-ascii?Q?8wU4Pm+QY9BaHT4ylXT9RqQbch4GAgFWJKEeqjdnHlOSY1sF3Gcenm4e2H1v?=
 =?us-ascii?Q?YDAFN5/q8fxTqBojCuGlG6KtLteJvlsETJo7QM56q5e+evx0hgl2daARqIkD?=
 =?us-ascii?Q?/UtZsS9AlXnp1klV7xNGX7FfFGK5ua3tqoPsAFU8SxmhJ+2CtoI5/Q090RjR?=
 =?us-ascii?Q?xGdbtZpNocnHlmIWtV/Olabx8WiY6fyu1lomiOshVY4WETk1EOR5doVL/EAx?=
 =?us-ascii?Q?Y6S9JgleR8lyNSkdD2Xk+s8p6fF331FB/3RjQsxQ9XJduxSaCmI4UlHeW5qO?=
 =?us-ascii?Q?9soTmFGje+q22IV+PhCytUitGBbxeMHPy4/1CLPnVC0qlqESc9yeQhqGKtxC?=
 =?us-ascii?Q?4cmyb5qKpc8hdPCpX1Jekx2vKK5fvRWlSpufvjtUzCcHcliyL4pTHUxRZ4g+?=
 =?us-ascii?Q?bM8GEtnCDEGDGAsP23PVJ1sFVhAb+wJmqoxF0oiAqtlJNbKJ7v6OvDkNZr1P?=
 =?us-ascii?Q?VLcSNYW/gOMgqR3UyzZJJ5EEkLbDLB1WL3ovCefwFap6gcLDxzQdePzWa+bD?=
 =?us-ascii?Q?hpCg8Evz2p/4AV4zUuq6VNOHi9X3xmCRYev3D/rCW8m/8FFQKpvPoLBVubk8?=
 =?us-ascii?Q?5a1+VzPhaZNp5HhVqp5euOpGFh2CtZn5tNkGj+B0+eRcSDjChGndJIUfXdsE?=
 =?us-ascii?Q?sMDmIBWNKpOSFT+f2UOTljCcaVj5a+xRRMaPK95R1XzCIVIR44FO4VdMED6C?=
 =?us-ascii?Q?oQt6FvGwD2XOiWGhRtx8QUFiSIVsLRgOOvTKmYeqUnUPlNReTvRVrcBKi1yv?=
 =?us-ascii?Q?0wzzjt80YmwkXt2wu7reI7IV3cZq9aJRr9akpFcHFyLxkZxT+nLWeYuuY1LK?=
 =?us-ascii?Q?MtoHYOn2qmTcn+C3D6mhqYahRAwv+Tc=3D?=
X-Exchange-RoutingPolicyChecked: o04ORPdD6PBPCR1JpZhyCPLBGyyZzPRXJk5Cc7EM1qOJoGYV47ERs0XzEWxFpuZD+ZrmN/qfqKVmCKYhZOgrgUa/WXc2zYUxAqauTtgUDVImM0MZWtLmkUALq259/yzXb6RdotlDA4r6ynWeB7mYNihoREvy1DaU4tGD6ViV18uyv7oiYEwD3la7Ed4qjvnDczK0xhpF7GMAGrbiNZ7iKWM7c0wcUNQpruRZxgb+jse0XLCqzxPs7NumI4GPrCMR2VJyzAhIGvEoA68iVsdmPLo8dnE5VKqdbR+2Q0uExxDpcoNmlPlTmbppgu/517ng3MXc1QC6YOz2/lk82L0OSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f525179b-2e1f-431d-62c1-08debc5a1ed4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:40:38.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56sP6By7ZLPlJpfOd2MshxO4259a6/ipATZMNwGMNtB/jOMccfCLBlJUZliL0YdLYGGZ7pBS57+MA52a6ke0Zufj54ijkugJPNXYFayyuzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
X-OriginatorOrg: intel.com

On Fri, May 22, 2026 at 06:31:49PM +0800, Richard Cheng wrote:
> On Thu, May 21, 2026 at 06:29:22PM +0800, Alison Schofield wrote:
> > On Thu, May 21, 2026 at 04:48:06PM +0800, Richard Cheng wrote:

big snip

> Hi Alison, thanks for the suggestion and I think this script is a better solution
> then my patch, though I would like to ask can you provide the implementation of
> reply_regions() here? it seems like a missing piece for me that I can't execute
> this script on my machine.

replay_region support first appeared in kernel 7.1-rc1
f3b1d2260703 tools/testing/cxl: Enable replay of user regions as auto regions

and the tooling support is on the ndctl pending branch:
https://github.com/pmem/ndctl/tree/pending
ccc1955b697f test/common: add helpers for CXL region replay testing
81c7cdd6cbcb test/cxl-region-replay.sh: add test of region replay workflow

> 
> Secondly, I want to make sure do you have any decoder with targets, and with some decoder
> without targets ? I wonder your filter might report that case as buggy as well.

The filter only catches the specific signature (1+7) of the bug Robert fixed.
Other mixes like 2+5 aren't expected from this bug or from a correct kernel,
so the test isn't designed to catch them. If a future regression produced a
different ratio, this test wouldn't notice.

-- Alison

> 
> But the overall intention I can see this can be reproduce by the current infrastructure.
> 
> And yes I'll spend time to work on the region replay gap, I'll send patches once I finish the
> work.
> 
> Best regards,
> Richard Cheng.
> 
snip
