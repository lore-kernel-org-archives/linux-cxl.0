Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585F41BA75
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826617; cv=fail; b=Sb3+1cU4sJalbPPnkWZXtOChDKeSpfUdlyUYxzpAeVEk9+pZrEnKv3gwxy/7eq2GYrXSbfmCT0e2Oh9ydaKiKtTvNmQoBkkcjX5Zef0rIRE4SmjXe/4zMm+Bb27xdJpnFgx9afvAE+GE4/XVOYoCljSQo8n2inILMW7+VOVnqSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826617; c=relaxed/simple;
	bh=Bbu5hxLUVaSkcrsDRYOecZFjI4umIV54iXLvcOQKpps=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W4N+Q1U/TMDKE7XXcmMJK7QtLH9vP/OSQMC9eUv3uMx5AF6hKHMEqzJYtvW8q/UJH7U4of5ULXsivJaYtcac3WPXdm5ugjxb8kWYRaMEJcNLW95cwFH3YKfwNUCHKjDgYEgGL3O1oA/FZwkgCRny/yyc+T5zgPTjOVtBi9aYqj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bkjfvt7w; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bkjfvt7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790826614; x=1822362614;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Bbu5hxLUVaSkcrsDRYOecZFjI4umIV54iXLvcOQKpps=;
  b=Bkjfvt7wPKg8rO0GPmDq7Pkdla6BDx/Qm1L0EE7/SzHlKnIi6T3Cvy4A
   1nXXPVGnDw+9/+kDCkOxh8yNJ2s1JEvk38IgJb/u1N5/gKMTdA050Z8ZO
   Fk6oqtKql37XZShTBUQWP2eJzfe5i+XFJwdTPQMrza7fGbQcoSO8mexZ9
   h+aSj/WZQRs58krWCUgzC6VVHRojgapFSaL7msQV/l91PgBNjQiECJZqo
   6PZVn1sK062IUGha9xrDTlbPZxLcsAtbPV7YXsTypCtU7qwbeI6/Lql4g
   ix16A3ACsxWy1rq4rI5KrvOhhagX5K8a6cSnH/yXzIHUwxSkWAzOCmY08
   Q==;
X-CSE-ConnectionGUID: 89WGF2APR2GmKSUcHumUbw==
X-CSE-MsgGUID: N1wzL5BZS5CkLc+W6TOb4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90342612"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90342612"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:50:12 -0700
X-CSE-ConnectionGUID: q0aRNz+DTOCM4HZubPbsSQ==
X-CSE-MsgGUID: pPR+KmH9QJCb1c+z135RSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="272318562"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:50:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 20:50:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 20:50:11 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 20:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYIG3e8SRNvBcPIuC1GBeGJdlHv817HsCBV1JOk0AUDYKW6TqZ6KgvgeTwwyWe8eoX4pbNFhjz2sUaQ35CV8D7jLNJ53Bi8wEkj5WKmEq5NGF9+lQsFWBsGDg+ZEPUErnuhzlleBz765cXfDPK/fOpV8XJK1yLgcwblrIvdocGX+4iN7A+YH+8MBmatZpiNuN/dA/sc3+zobKq8BiGwkP7SPdmuTivXSoX6mOgL09c1DWm7LCUTVVz+4GhHzh8Eyc8Dfcyv0nLfw39ZMHkSUH6QzVm+5sg00s/+ATCUIMHOYrQMG/kCH3bhmMCRVM58yhqdPlfm2q7gc72ZlADnpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCgyP/U9d/JKkQvyWCZyxnDjmWhA4yiT5F444Tg913U=;
 b=wX0/raylcdkyrXpKuGKM2T4bAPXWmpWSuQbr+ZI+oUqCXi2ZyGxCZtpyxVJmnEUNz7Xkrnc39kOdFq64IADdqa2l85YoyCbRILmtLkUDUnolnKNbaNJeCGcgGXAXcjGSjm/aDnHPf9i0ephsOhfgoiwW6K4tbg8AiwSJGnhyIoq5htxHphuGuI2XvPqEfoqOKwaw6s5GUPjEzolH5wHfmSgbp15anYTiKzOPjv0UKHMAomMbRwyp6UFme+iU4DoxOlOS7jQ1HwQIQUShJlEBvSIdYpsIn5Lu3wVGgtBogz/4LAXsMoOkihDEMVAWp3E2N5NtSbKPXNXZfUPCq57k5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 03:50:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 03:50:09 +0000
Date: Wed, 30 Sep 2026 20:49:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 08/10] cxl: Allow auto-committed BI hdm decoders
Message-ID: <ar3YZtnQbE-n13qz@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <60fe8a8a0f66a9535905092e1dee604c1f7ae48c.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60fe8a8a0f66a9535905092e1dee604c1f7ae48c.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b26fe0-8b47-40f9-7144-08df1f6f1671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|18002099003|22082099003|6133799003|10067099003|3023799007|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UayvNBoOqet84AW2chNq60UXv2O83f+R5Y+mGsULKMJcL/eKK3hlxgo32LVeMWvBjkmOq06uyTHYu2/HJXByBgUXhAaZqvmrAkeRIngRoI3BhqpyJCzyycMlvMUAKhlW0kOtlcjOG8Ub6TSi6trsimYjRBAFIaFDWsyacXWxi1TF6EiXo8320Ag/01L4TJGwoWo9kRHiV0EFCvYNBn0Uj1FfQpUM6Qde8nXS1+FQwW9djV9sv7MKDWasFRu1Ga0kKHizE/PyaslBlimuOa81J3tpHzZnkBsOuxVSSUNz6rgPnbsUW7L23LeLrpuU8MzJ5KgYNUgIqk8lPQWDvAGmLiLrJC/QjuoPv8EBiPQBEvk2XCdU043KGSNdVzftGidTLnkFu7yJUoC547FyHzFn5iY/+8kZ9kvlu8ZHCoNxLwEYyeWVW3xyVr/AS5D6YY3opWcqIAsTkEL1wLbXiCy2RI8xhxlRR6B2haDXRIm33pyLoB8gf5Uy2G+c2yAMlIlLiYjzjiayEzpRil0B5nWO5rHTBfiFTeE652DVdjfbTZ5yrZUzU3UuEuiVfEZaOcHsPzzTLLzauZEuRISVfp3rF0CcJVEpyuDBX6EmqmEnogWy2I08ek4aG5VwHoCHP/37c8DHdcfDQct6KoT7p1GCfHO4pZj6OkcpWGIrg17OiSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzdApzf45/KlBdfJilPAcP0G5rAVZFWMW7kK4OoRsL7kFQCh44CMSlhEwSap?=
 =?us-ascii?Q?Jwe00xaOrpJgYnCnO6sdFqaI8iafP9kemCOKDZ8pxdhdvC7mRQ7n4aOfcI6v?=
 =?us-ascii?Q?D5PLt8ex0IutpLIeCBbJyhDLztmrAKbexVGcTzzHt1sADjxYY4/ItCSyoo9u?=
 =?us-ascii?Q?WawVSChoNaCqRHlUDvg1XDdnNzB3YnbWA+FnZl0qpbg0a1plM/YxZXgSq255?=
 =?us-ascii?Q?U92Tf4wV/bQHhWqqqfs7ZuT88i8eX1KQ1cQE0tf+dsHRXwf8ypphZf9GDZTH?=
 =?us-ascii?Q?SMkxYbzZrCpXsUBMS2kKGEnw1NJScdPIc/H7EAkk5OR36tqyxVIslvaMC4jF?=
 =?us-ascii?Q?2h2NshzcIRrgjGH9jtQALkcbJ0U0+eF5q1s8Iweo1YqXiFc4zYur0mq1SySa?=
 =?us-ascii?Q?7yWoPhjnSDjxry7ULdGwR4v9RkV22p9RJDd/ZBtiXG5g43A389soVTmYG3eD?=
 =?us-ascii?Q?/kyUuSMjAcxYr/BoMay6q+Hrn9FlldEkFF5CzfVvpHeAsasnpyrvoQs7b0fZ?=
 =?us-ascii?Q?eEOdGyN0acodwEiEkwkmN1ti9iseQzBOnWBC4BKdKKACdVtPSeT8QaEg7ZOc?=
 =?us-ascii?Q?funoUeg0TyXmuE+zKKDyiwv8zdnHdOZgg+Z3T+XaHpQMJw6v+QO38ynTWvfi?=
 =?us-ascii?Q?Iw+FDTwu4qFTJyCUY/dutdbj30quRnBUAH8pC9pJA9gh7NNELW1KeM3UjlTr?=
 =?us-ascii?Q?Dksczerh8Qe08YPzDh0gWp/RlBk/R0hpFxtaRGT59gg8WIbcSG1/Ax2cFBxz?=
 =?us-ascii?Q?HCWLUIlQuB3mmJnbfZrE7OQ6nZBJS53YD73tVwQm7VmvFajESsa1lnFXgMPl?=
 =?us-ascii?Q?JTNGlRdatrvMU7OY+cuBRvrX8YFv0X3wPxfB75arFAEu9T6MOPtlPvm9zIT4?=
 =?us-ascii?Q?48/hba9qDv+1Msoi0egW1feD1ve3Si02UAAmPwnA/d4yZmR5FjoPf26jJc68?=
 =?us-ascii?Q?3zoTnaMKueQ4w5aN/HsltjmJHg95vFJLsgdClH2gvouYRMirGlApEzSJsLZY?=
 =?us-ascii?Q?E4VJ4123qgdg4AiZx3G0BaZmaURDc2zgsTvq2MVKMN/Np5Vo8q0ayzQhHO+/?=
 =?us-ascii?Q?tYq5633sbMCq5b7H3rwoNm2Ppo9Ztstg5z8a+TFWpwkFqFeRWNnsA2VCKC/p?=
 =?us-ascii?Q?/uwkYXfsCaoQygosQpNjK5a2P7zNTkEZOeYEXfrf061IqwFPWNx4fR7tQFB2?=
 =?us-ascii?Q?BYZ9VgWsGsDxlzUp+FVBzjU52MQ4BvcSCtm0IWCuQe5y8L9FE1RVfNyW8/g1?=
 =?us-ascii?Q?MVBH26pKHyr3kTLNrIFYnregMmp+yI+/yF32KtpMnLVWxLUfkfCOvpIuAXFa?=
 =?us-ascii?Q?rSrdMeHWUd7RLFm4yOofOWaeaVmPYfYHeMSMI62qzK+8pCmEvV2M66SEO1id?=
 =?us-ascii?Q?ZLuMcowJdGsRkK52AoqGO/adjpSBZRuBFFf9/ESYiojkwg/tttnBXND+E0xx?=
 =?us-ascii?Q?R8zA4g2VCYKT58vwqeu+izoork9js7NGSzr87n+W9XV73Z9F6Usk4WAZR2LA?=
 =?us-ascii?Q?6H9dKsrR4f9hHDil2rKIYD6IkE6eeguecSo/91Sauk0nqdY+qh82F3tf4Chl?=
 =?us-ascii?Q?jiWeb5R3mMu0XIwHHjthB96ys8xcCAnnqwWMsgh+32zMsNGN13Rw1AdI5ubx?=
 =?us-ascii?Q?OGmrlR6Rkqx7n4mSYx+AwXBNzwJiBSyyMk1FZwr6CaW8SRXbex08ARi9ruMk?=
 =?us-ascii?Q?bOwNV3AOenm1NQXlMH069GSUfvbST6uCrKo73OB9SFr7N1qu71asYaW7qw61?=
 =?us-ascii?Q?UwqX+tT5Pa75Ajd/ZK6JMhJeUCRpUbY=3D?=
X-Exchange-RoutingPolicyChecked: Cw6pHFbf1oIjOVN7IqpXyQK8LaleIrfHWcMaxbmOwfdv5WSuxqWD0pgY1nsy6R2XJTcM5z1hdieViuObZo3czexABLp03ypGY6tEdWZq2O8982wbQwGWp60VoS8cR/LrTWfRSVNZGkIbhjlu7E+46yaeBiFRdGjLzhVZAovc9+vyWk5jn7wABMdnYjM2XS5d9r7ZLI1ROOqvZr6FsvWEYRvqOuk8Fx816j7V3pfVXYoUMTqazPPjbJUlM0NNvy5s37Vd6X63nNW8MO3RN/ZZN1vyWH3U5qkze9OFmvXdvqJUPm1scQmR60MKU0V2hxqP1AiTqL87N4PYk3XSeW9zSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b26fe0-8b47-40f9-7144-08df1f6f1671
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 03:50:08.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4+ghr3CUwmrI8rwNx01IcU18EV7OrYDtCZutd9/96iEcp35D92tjEFhd2ycSrthWfkrv6+00LdtN2i53l7szPMg/eRj6QrmisEyU+szpmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:45PM -0700, Davidlohr Bueso wrote:


The cover letter says the series could be picked up with or without this
patch. I'm guessing that is a stale statement. Today a committed BI decoder
is enumerated like any other. After patch 3 it fails port enumeration,
and this patch is what fixes that.  So not really optional?


> An HDM decoder that firmware committed with the BI bit set was
> refused outright. Accept it, and refuse only what is broken - BI
> paired with a host-only target range type, or for an endpoint
> decoder BI on a path that cannot route BISnp.
> 
> Taking over such a path must not re-program what firmware already
> did, and a dport's committed state does not say which device it was
> committed for, only that firmware committed for something below it.
> Two endpoints sharing a level show why that is not enough to go on.
> 
>                         RP      Forward set, but for mem0
>                         |
>                        USP
>                        /  \
>                    DSP0    DSP1
>                      |       |
>                   mem0      mem1
>                BI Enable   BI Enable
>                   set       clear
> 
> Adoption is therefore seeded from the endpoint's own BI Enable, since
> only a device firmware itself enabled can have had its BI-ID
> accounted for above, and carried up the walk. A level is taken as
> found, with no register write and no commit, when nothing this driver
> routed sits below it, the value this driver would write is already
> there, and both the decoder and the switch's route table are
> committed - the table carries a commit of its own that firmware may
> not have performed. The first level to fall short ends adoption, and
> from it up the driver programs and commits as for any other device.
> 
>                     RP    Forward, written but never committed
>                     |
>                   USP0    route table committed by the driver
>                     |
>                   DSP0    Forward, written and committed
>                     |     ..... adoption ended here .....
>                   USP1    route table already committed
>                     |
>                   DSP1    Enable, taken as found
>                     |
>                   mem0    BI Enable already set by firmware
> 
> An adopted level owes no commit either way. Table 8-152 and Table
> 8-156 owe one per new BI device enabled below the port, and an
> adopted level is not seeing one.
> 
> The endpoint is adopted the same way. BI Enable already set was an
> error before, since only this driver set it; it is now kept and
> cxlds->bi taken up without a write.
> 
> On failure the walk unwinds only the levels it did not adopt. Since
> adoption is a prefix, the unwind drops the refcount below the first
> non-adopted level and leaves those registers alone. Teardown is
> unchanged and still deallocates every level.
> 
> A committed decoder is refused when its coherency model does not fit
> where it lands. The window must permit it, and unlike a decoder this
> driver programs it cannot inherit a region's model, so its committed
> Target Range Type and BI bit must already match. Assembly never
> validated these bits, so setting them wrongly costs a platform the
> auto-assembly of the affected decoders.


Assembly did validate Target Range Type until patch 4.
cxl_region_attach() refused a decoder whose type differed from the
region's. The window check this adds also refuses non-BI auto regions
that assemble today.  More inline at construct_region()...



snip


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9bf05820c142..f83f5d1d8255 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1087,6 +1087,29 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>  				    scale, base);
>  }
>  
> +/* Committed, or no explicit commit required */
> +static bool cxl_bi_decoder_committed(void __iomem *bi)
> +{
> +	u32 caps = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
> +	u32 sts = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, caps))
> +		return true;
> +
> +	return FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMITTED, sts);
> +}
> +
> +static bool cxl_bi_rt_committed(void __iomem *bi)
> +{
> +	u32 caps = readl(bi + CXL_BI_RT_CAPS_OFFSET);
> +	u32 sts = readl(bi + CXL_BI_RT_STATUS_OFFSET);
> +
> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ, caps))
> +		return true;
> +
> +	return FIELD_GET(CXL_BI_RT_STATUS_BI_COMMITTED, sts);
> +}
> +


Above 2 helpers differ only in register offsets and masks, and repeat
the EXPLICIT_COMMIT_REQ caps test already in __cxl_bi_commit_rt() and
__cxl_bi_commit_decoder().

Could they be one helper taking offsets and masks, like __cxl_bi_wait_commit()
does?


snip

>  static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
>  			      struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct cxl_dport *dport_iter, *failed;
> +	struct cxl_dport *dport_iter, *failed, *programmed = NULL;
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>  	struct cxl_port *port_iter;
> +	bool adopt, clear;
>  	int rc;
>  
> +	/*
> +	 * Adoption is a path property, not a per-dport one: only when
> +	 * firmware enabled the device itself does a dport's committed
> +	 * state cover this device's BI-ID.
> +	 */
> +	adopt = FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
> +			  readl(endpoint->regs.bi_decoder +
> +				CXL_BI_DECODER_CTRL_OFFSET));
> +


Is this cxl_bi_decoder_enabled(endpoint) from core.h?



>  	port_iter = port;
>  	dport_iter = dport;
>  	while (!is_cxl_root(port_iter)) {
> -		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport,
> +					      &adopt);
>  		if (rc)
>  			goto err_rollback;
>  
> +		/* adoption is a prefix: this is the first level not adopted */
> +		if (!adopt && !programmed)
> +			programmed = dport_iter;
> +
>  		dport_iter = port_iter->parent_dport;
>  		port_iter = dport_iter->port;
>  	}
> @@ -1301,8 +1360,11 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
>  	failed = dport_iter;
>  	dport_iter = dport;
>  	port_iter = port;
> +	clear = false;
>  	while (!is_cxl_root(port_iter) && dport_iter != failed) {
> -		cxl_bi_ctrl_dport_disable(dport_iter);
> +		if (dport_iter == programmed)
> +			clear = true;
> +		cxl_bi_ctrl_dport_disable(dport_iter, clear);
>  		dport_iter = port_iter->parent_dport;
>  		port_iter = dport_iter->port;
>  	}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f322a8a4a66d..0e3ba7c79a75 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1861,6 +1861,20 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	return rc;
>  }
>  
> +static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	u32 ctrl;
> +
> +	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
> +		return false;
> +
> +	ctrl = readl(cxlhdm->regs.hdm_decoder +
> +		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));


I'm having some deja vu here. I may have asked and you answered this on
an earlier version, but now that I see Patch 9 it makes me ask again.
Patch 9 wouldn't need to mock this if we stored it as committed BI 
state instead. Maybe in cxld->flags using CXL_DECODE_F_BI.



> +	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
> +}
> +
>  static const char *cxl_coherency_name(enum cxl_decoder_type type, bool bi)
>  {
>  	if (type == CXL_DECODER_HOSTONLYMEM)
> @@ -2179,6 +2193,24 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	/* a committed decoder cannot inherit the region's flavor */
> +	if (cxled->state == CXL_DECODER_STATE_AUTO) {
> +		bool bi = cxled_committed_bi(cxled);
> +		const char *have, *want;
> +
> +		have = cxl_coherency_name(cxled->cxld.target_type, bi);
> +		want = cxl_coherency_name(cxlr->type,
> +					  cxl_root_decoder_is_bi(cxlrd));
> +		if (cxled->cxld.target_type != cxlr->type ||
> +		    bi != cxl_root_decoder_is_bi(cxlrd)) {


Looks like only need have and want computed when mismatch is detected.
cxl_root_decoder_is_bi could also be cached once.


> +			dev_err(&cxlr->dev,
> +				"%s:%s coherency model mismatch: %s vs %s\n",
> +				dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev), have, want);
> +			return -ENXIO;
> +		}
> +	}
> +
>  	if (!cxled->dpa_res) {
>  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> @@ -3838,10 +3870,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
> +	unsigned long need;
>  
>  	if (part < 0)
>  		return ERR_PTR(-EBUSY);
>  
> +	/*
> +	 * A committed decoder defines the region built from it, so no
> +	 * attach check can find its coherency model wrong. Only the
> +	 * window's restrictions can, on the BI and range type axes.
> +	 */
> +	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
> +	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
> +	if (cxled_committed_bi(cxled) != cxl_root_decoder_is_bi(cxlrd) ||
> +	    !(cxlrd->cxlsd.cxld.flags & need)) {


This refuses non BI auto regions that assemble before this patch.
Why is this in a patch called 'Allow auto-committed BI hdm decoders'. 



> +		dev_err(&cxlrd->cxlsd.cxld.dev,
> +			"%s:%s coherency model not permitted by the window\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),
> -- 
> 2.39.5
> 
