Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2136.outbound.protection.outlook.com [40.107.244.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394771474DD
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892648; cv=fail; b=BIJxzbPS5xlVoS4pgrgeLE3BcSVUaI3tyXH01kOp3z3z6orLiSqjUgMcSS8tlmhy+7/FH/phlEF0noIhO7xkWE59CWSUfg08LeIyHW8VWC5+y6GSX0WFRPyysBSUOSwOjEoLSugxEpi2Y7hVqNl8T8K5SuIN0iq+Ii8Whf2zBdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892648; c=relaxed/simple;
	bh=d4vRNMkJnz6vL8Ox2rCKubhzxZ9KvKDAFx2X1TXqbL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLXujArX6nP3EoosqWqJkOrJ6hcdZOetrD86YpMSK2ic1jLmaLPgJTFbDreUb2FC/McFGZBf1kjSFvhbBxyep1SECZud4kfv3kyTsmzEfof4/0EBGK7jZqJe9/Sl0gNRsgLKPk5ja6xa3wxWaAdswDf4Z00uxWLsxGN1KnXXi/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=sqX5unVm; arc=fail smtp.client-ip=40.107.244.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="sqX5unVm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F19bMzCUEyEGVw4xYUXgZzS4e2kv8bnFPInoCS0slryLP8zFBQMA1bOtK/B9yUvIyi9Nzr2fvAdg6ffkUmwHsQtjad9x1XTsIGne6x4QLtSL1tHn89CromAxbAms72fSYnVSzAV3DFWmkq8tIKzxacZiHfWbMuf9TvhPcos4fQ7tenPJFlJvqqS9GkhAtqGsUkex2IROkhcc/QRQ8mLMFUpXMu6ObWanta619VT0MsIA0FGNE9LWgux8cy12Y2P7q1D+Zb2ZcPPw/Bmc1eukBuLIArBm9TrCLa1LhgLlvlVxpoh/aXiE8T6BjwgjHHH9dMm4JBBIrQvBKKFgmPu57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=312aU7kRVzlYjiHuZeHHkMsNDpyNzN5YnvBdDsEnKbo=;
 b=fHsCHoEv4hunlG4CroA2fSmA5m5F/EKFeao2jceWh6eGZ+Q1VLKB100J8ZiM1FAWAnOWXW6o2Ukv9tGfKmMdGOP0zeWJtzlV0arScNUi34RGlmzRszBQgFOft7DiFn0gxt+2P9B7g3wMse0+i7AgScW2J9UadOU9rVnkbtaxDvPEh5VWM802VW+bv4IwAfX4pELxOIjkq+V3D7sR5gMKOGsI+OFcZ7WlssQ1cgriZsCEwsbeaD2cJOuA9fMHlrLjAJhu47Is6N0x52nurfOFH05pTsnkm/+F/gO9hpCQsZ+7NHgOFCIFpXcUbsce5mHauYm1SXU99NIR32SToG1K/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=312aU7kRVzlYjiHuZeHHkMsNDpyNzN5YnvBdDsEnKbo=;
 b=sqX5unVmotrrcCbUiKQHnaZmesm7SZb78Aycc9Q5+wNj9IejpvWnUW4RPMyll4N8E9oK2Hj94melql5YJZhaAYd2Ug/18VSmFUdniK7+TN4oHWMX0t4vb4cwBAfZHR6CThs5uQ9dHmWLUVmsepgflbZdNCMCyfsSxVYHTuK9N1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4986.namprd17.prod.outlook.com (2603:10b6:510:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 16:50:42 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:50:42 +0000
Date: Fri, 2 Feb 2024 11:50:39 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Sajjan Rao <sajjanr@gmail.com>,
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <Zb0dXy72lyglchJa@memverge.com>
References: <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com>
 <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com>
 <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com>
 <20240202162633.0000453c@huawei.com>
 <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: f86456d2-6792-4a7f-d4b9-08dc240f17b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2yfIhtRJBtm6q/B2NijXpVQxJtvj+gxx4EWnMqJrxlfw3Pb2fujMFq+A2AgPKEeSSNoRmxFFty6356rfW0VizIO9zKTu1wCYiPYeAOyMr9M4HwZJw+5/hDD5f7Aju7J6kvteBOXPe4owOsZ9Q9YBqVRLEjzXnLOee9qV0nMMFp7p3pDESbVsR/z7dNFrmd3bEq+NK0QFYaWTuEb9vx8psL2ub0hOeOjEuzOb1kBm/E5vMjnesOryx5xRdDttvwBFI7qAyCtexFlILeF/6f8fNGJsZ/hUMYEyUT72zfnMZDZLDS+cYCu+kl3dljZD5tEW9vCK/GulmmCTRTlnrBKvvx5VU4lk6C9TTlPt9/Y+g+tJZMUgSsC6Dw3yvSF1iflFpUaiY4+UFghSNdv8DMIaAtXOPDxdaXNLcyI9b+tZGeHm5g64t8thVzJxNaJ8zQTRPS8bvQ0xQd8wB2BU6B9Cq9VCCToy7cQeDIiaSWIQL1nAnDaKUbP4iqA0nLXwSCLJsISppCWPrZwdKJv0tRwvR7K0Z/A4YWDQ0Ur8yn5DATg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(366004)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(86362001)(36756003)(41300700001)(5660300002)(26005)(2616005)(6512007)(4326008)(2906002)(66946007)(316002)(966005)(6506007)(6486002)(6666004)(6916009)(44832011)(8676002)(66476007)(478600001)(8936002)(54906003)(38100700002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJTBY9z6rDY9Mbb0VfUCMaq6+V6zpcJBHy/GKDUs0hAPZUQ3KcvdSnEqxAKw?=
 =?us-ascii?Q?m83mWTTdCAyTjRfHtFssS4iv4udEkqzeSR89W1YOeXPUGsdo7vKve+c7nFpW?=
 =?us-ascii?Q?wG3tWDS/nloGSFGVNDATCPBldT4T3QWZ/HcsjCCbXD6RxcaUvdKnt87lwzif?=
 =?us-ascii?Q?0asvssZ1NvurUCwIq/Gyi90FrJeablIX5H1gqJ8lOkXfncYNWjdhJchc5Br3?=
 =?us-ascii?Q?wNUtUzCDtWc4uDKQU4DOqO7IlwxdBzX7t4UZDDo6Ok8cFsMZHD4cE+X8Mkcz?=
 =?us-ascii?Q?NwasXxFWd/DRLqzvofAzh4LI7Z1YF+Fx5fgu9wXz2CYgiHdPZnYiMekiMTNa?=
 =?us-ascii?Q?asA1cjawBKUKYGScV10i5bJj3bzYA78V9COCE60IAv+9t71t3YPTwckrxHmT?=
 =?us-ascii?Q?3wQe4D7LW3fFZKjFdUKPDe1FFnB7veJXnEkjzRXx0/cxcW3CJLtfZcCCsYFF?=
 =?us-ascii?Q?bRpnZWPBoXdfeZL9FlhYkbUg1z0AkORhRO6RcfOm4a27Y4RcaXnKksHGqHaX?=
 =?us-ascii?Q?j9VtU5L6K/MdSxoNZX7qAxaKMVZvdUKQ3VvpWNlRs1uktcnChFf3TMenrmym?=
 =?us-ascii?Q?WJjzZekMzBi/NrCaZ5l9bh+ZENz3tz/gzXSyS66gHl2NxuJ6yFkm72KrCQQX?=
 =?us-ascii?Q?kpBurgaonsGjGMfc6d1VT1knP/ggKCQqihp+xdb+fy0oxkx9IO5jsKtHPuGK?=
 =?us-ascii?Q?/eXn9dI+gMv/D082AIe8ZBaeFUNAv6jIeLf0E4u72o0KPzb0kRqGPKObGfnN?=
 =?us-ascii?Q?ogHIbO1dTI9YP9JyXFwHrWi1IArM0JX8QFeppMAI9LOTnPhdGBsZqR9ad8UK?=
 =?us-ascii?Q?fbR2SyROs4sNji2dVV0pLyF0/gwBoATOj6nyphDUSMuKfZXJUrXMQaRa61vF?=
 =?us-ascii?Q?fb24RPGX+N/lcfDS9djtoQKupg630PY+bvLYp9hB/Zld8Zrbg2/z+7cMWr9v?=
 =?us-ascii?Q?VYqRlxSO+uGr2KgCrXvti+UsnF1bESiRFD6pC7RlwcijOYUOatzFDE+QjLym?=
 =?us-ascii?Q?4iwPRuSvVSQaxg9GmWV8tOXmyTmZsgt38pG+0rKy341E3vV5/eqI1ZvT8mI5?=
 =?us-ascii?Q?nEYQv6lErz260CpNTDYtL0fSmGJc8SzE1AnQOxCRIB+NXxYEYHBAJvGESSk1?=
 =?us-ascii?Q?MFfPiFFJj6n+NVxCSeKbKrrT5eK0ne7vHAhureniWNRk/qdEsZqPqT2v9eXR?=
 =?us-ascii?Q?y+1uT6wPrcWiHHCtUjLKEk1Mtk2g9e1RTeSmuwesEwa169JH84+uAcRHFDR3?=
 =?us-ascii?Q?iu2C0NVSE8aIgStOe2DQs6LfqKBZR61eUIZiiBuntl+FJK34sm++EWJP/UM8?=
 =?us-ascii?Q?pPj/nByNP6g1nGXSV6YT1XoDrJgkFwBTTFwFXcu6zo8NrH6jWBLnH/UbcPR5?=
 =?us-ascii?Q?meY81yc8zwtQ3PFmnPl3ItGe7Ak3p1ATouac7e0G3PNSlx3fKN77foqUboFm?=
 =?us-ascii?Q?u1CP5HFfo38j/XWNR7x8PxRVc4O0PLHVuKJlU5XW9FTxWjvddMpNv30KP3yw?=
 =?us-ascii?Q?Sbwv6svYrgEzsm5OpuKzTBANBH72qYkWSc/kjetNK+vknvOQmrfTXhMuoith?=
 =?us-ascii?Q?E8n/Ttx4+jRboHvq4101WnVlm1c4fBbpjSUFYQFYJvSfpQRhOmPsQrl8gBV3?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86456d2-6792-4a7f-d4b9-08dc240f17b2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:50:42.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t33v8V26fVpq+b884k2PGzPwc8V959fWY2KNnkc8GPPDGSuxiaVZEslfnaI2AOh6M++OYeFMhOEM/m1F6TreMXm9h9J9IdyOjORKkiJJiM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4986

On Fri, Feb 02, 2024 at 04:33:20PM +0000, Peter Maydell wrote:
> On Fri, 2 Feb 2024 at 16:26, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > #7  0x0000555555ab1929 in bql_lock_impl (file=0x555556049122 "../../accel/tcg/cputlb.c", line=2033) at ../../system/cpus.c:524
> > #8  bql_lock_impl (file=file@entry=0x555556049122 "../../accel/tcg/cputlb.c", line=line@entry=2033) at ../../system/cpus.c:520
> > #9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012950, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2033
> > #10 0x0000555555ca0fbd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efd1d0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
> > #11 0x0000555555ca341f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595792376, oi=oi@entry=52, ra=0, ra@entry=52, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> > #12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=52, oi=52, addr=19595792376, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> > #13 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
> > #14 0x0000555555b4b5fc in ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:98
> > #15 ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:93
> > #16 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efd3e0, out=0x7ffff4efd3b0, err=err@entry=0x7ffff4efd3c0, ra=ra@entry=0) at ../../target/i386/tcg/sysemu/excp_helper.c:174
> > #17 0x0000555555b4c4b3 in get_physical_address (ra=0, err=0x7ffff4efd3c0, out=0x7ffff4efd3b0, mmu_idx=0, access_type=MMU_DATA_LOAD, addr=18446741874686299840, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:580
> > #18 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18446741874686299840, size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
> > #19 0x0000555555ca0ee9 in tlb_fill (retaddr=0, mmu_idx=0, access_type=MMU_DATA_LOAD, size=<optimized out>, addr=18446741874686299840, cpu=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
> > #20 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd540, mmu_idx=0, access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:1713
> 
> Here we are trying to take an interrupt. This isn't related to the
> other can_do_io stuff, it's happening because do_ld_mmio_beN assumes
> it's called with the BQL not held, but in fact there are some
> situations where we call into the memory subsystem and we do
> already have the BQL.
> 
> -- PMM

It's bugs all the way down as usual!
https://xkcd.com/1416/

I'll dig in a little next week to see if there's an easy fix. We can see
the return address is already 0 going into mmu_translate, so it does
look unrelated to the patch I threw out - but probably still has to do
with things being on IO.

~Gregory
