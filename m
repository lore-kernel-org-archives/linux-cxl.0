Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F53CB902;
	Thu,  4 Jun 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567951; cv=fail; b=hzqjjcAqi6d5ljXahbAHLZ8tc88cZcZ6pjBiI8uCeXc2cPKZT4W+yi/WMrQ+E52WIquwMZHV5sSilIVQeOyG8BlB7td86bgi6fAXsGsUtPNwabKwFulvCkugT65eIsukKHHR72wee7SA6/o9bJmnzOImzDwr/dSo/yE1l7Rbi6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567951; c=relaxed/simple;
	bh=58hN699m8VcTc02N+qSbZNo2qH03ksWGJbZGHCUMnRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXQi9VY9IEsjsiimKkYywAxEE5ahBBmI1wnhn0ZehQLHaJBtzwfIsNZb6oluFiA31sgxcmjmu5TIpQ//kNgMdMATDfebWZ71c4noNK3PPCyUGJD1vYfHqQUDmuKBwPvEihcw1zT+5y/VcTOYfa3K+9s8MAaXde+izXw5n4aJQ/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QHxQjxO2; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QHxQjxO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcIAX1FU2g/aCcTbNrdDs62tx3mPO8Nkd3ckVGPthkSK3Jk2sFlexE0b1ryzl3+XYXJK2SSuUw6nEZ+kqXbfXcOSBg/NOjZBLTzEt9lGKgLP+PtMiViJuIVSIO09J5vqAJkbW8eScOnXlOaMo/UHVg2roh4EABsI1GJrHIwIRivgkUTJ0IehBGuLdiy1s63hvOHxXV5t3rVjf8VNlJ3Uo8gtr15jn3n5f2cSoraAz9vy22QvOiY12fqfcq42U/3GJumPGl6twiSnuwlXolF3s6xNxp2SQvwsZjVFIlaSOuWXt5YolqHfShFcYXEN5Hc6kyVQv2vzQhzkuTvXuZAABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oigT5cemxKjoKrjspIByIpzAdFSbHFLjj6rYRskORIA=;
 b=Z6bPhbT7/vWvXuz2vGuJB8BdshROcjdLkFLJBq5UK8OhpHA4TG8t26Lu3pm9EGPM54NbN0Ld6IqxlEODCpQAc2H6B6kmlo8jJIpcv8OBjWKVHrGvcqN+b6iDSTMZCNeTPR26SPwPn6xHLl7qbZn7GE8MI0xcSggj1GumMFMOjIDLonsYoLn+/qOMA3/Z30q/UC6ogqi2FXaSctIvtYaXEJpcoJ5PEITvdAgi4cEdjBFpm1sHAI4xEDrFiUgtS0HVd83flcL1V13Xv4XtLy/AQIJEzNYrBMeolt4i/TefDaZisgQ8hnQxIki36hrO9P9tRwUDR92fOvXDATyypHVH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oigT5cemxKjoKrjspIByIpzAdFSbHFLjj6rYRskORIA=;
 b=QHxQjxO2eZH0W7kw2MAohlyDxDr49mQJ/lJFJ21H0OqkgLFh3FmXSiVwyHgwecO/3J5P/yQ6vsW/0UZYvlK2fNYDnDaNswSj+JFmJi/yLCtgiGrrD/2ltwl3I42Df9C6y5S2O4J+X8lVNAv0DDgFORy2J7eUEJVsALIj4OMPDAYy0qJZtO4igIkJP1ZQKmW8xUVwNBWapV8N8dzsWuz2MYg78uCDvOp87CUKpz6BRRszj9gJC+rUoHnUQbgQqPuUsW6PQFE20SOapd3iREzL2e+JociMopt99jJoGDvGNYa6rMA2j0WB2mlUxMztZOjdRm6moKUg04aVRgNyVQE6IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:12:19 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:12:19 +0000
Date: Thu, 4 Jun 2026 18:12:11 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.ne, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [RFC PATCH] tools/testing/cxl: Support multi-decoder
 shared-dport topology
Message-ID: <aiFOpiSNyakaTazK@MWDK4CY14F>
References: <20260521084806.28232-1-icheng@nvidia.com>
 <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
 <ahkkXoNE8kReYtSt@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahkkXoNE8kReYtSt@aschofie-mobl2.lan>
X-ClientProxiedBy: KU1PR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:802:18::31) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7c7770-f634-409c-76e4-08dec221c2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|6133799003|22082099003|56012099006|11063799006|4143699003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	ndK6xpVf1nF+kgar3ekbzHL0PIE28q6wTKGPHfdkW93qCH55PQNGvf1K1TdR39BQYMk9DbEb63XivHXbdSOKpFyCyXaw86JSIVJACzSz1y03z3pwrNT0BI0Dwi4xw34v7A4M/LsAOaRK2wgt70AKWbRzidZ28Q3zC8w0SHM/Qdx9Zh1itlvkWMZVzGa507Wx6sLNinrWT7ZPZhacbqQ0+Risa86DCCrv3jC3R4wElxFepgrqTmpm/BPpGi+tKL2lxQgXsK5Ho1XT87SC9wjpX2nyna32rP4h/EeaAnEkPxZYMeuJPBK3ELk8JnBkqI9xjMvnL8C/LQFzS5jsOE3BsW3H2woS6iVYFOc/Th8mlBvZpmqhQbMwIb8JwOYfb/juvc/uvLXcttwd+Qe3P86R/ivr5C9V1CElIpJDmYIPtYKSFO4dmoJgDlLBQONp3rw6X4J3K2vRSt71yoMops201unTZwJSt1fJtWuFPFKeZV1mmqrvcdJ0YCK5m29EeD37/zlxkO/WpUZ5DhUXWWw7M+2L66KHlHq2uhXUHOMLlnvQGclHbeutmjdmkJPUV6M3Exai/KSnhst6iKlQWfff1wG4FHwwp0pQchrCEH7N93dcVAqSGq8XGWoiJ1Q1F7r6q7gsRhiF8F9A/4+D+qv5e+r26qal7WtdS9zHV6tBwmeqrLm3agmmG/Q0t7nayeNVpImcKm7VstwPqvaTADoCGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XmXRRzSP9ddY03pbizcOMLiSyN7Bcwrgl+b49DPBLeagJnnhcCFwQSEl1ahZ?=
 =?us-ascii?Q?tz6Wak0cVlFLYEzEAXUVwL0b5kXuYVU9Cn9C/jr1BG3loQxzCbYQHwnsQI1+?=
 =?us-ascii?Q?Bqz5ifNZTIlxd6s5tlYzYaBFZXqCWOMqr/F6MpzQHMdXQd0Aub/dykWbJEcA?=
 =?us-ascii?Q?lGfmNKWtkWr3rdZeAXT9155+gqmJHNQANZO4FrLT7hrRUrWmGR2BUZ5HRaEO?=
 =?us-ascii?Q?V+KU42JHaSSMrjzTcQrVgPYoWSWJtRUz7Kl95bE1BJPNUguw14tOtbgXbfBd?=
 =?us-ascii?Q?KIcGGEjzadLMx0tCyzc3q4yaXh3W3Flz0TNTJUtAxvxeTmEW0WRLf3IvrUNJ?=
 =?us-ascii?Q?ZX/T4CjhhKjV6+s1iihIX3sIqzKDEAH5x9S2kQPYt/HCPyjrd1O+FThkjri7?=
 =?us-ascii?Q?bbXdzv1hyJmSdYHIEH1CALDlHhKY0UusAZsQP1gpzSLZdOAdZEJu44h6sCCK?=
 =?us-ascii?Q?MgAgC80iIsuW1AzUV49a61diOHB3L7EDgLEYLib7Cv1nBoTn6aXeEpqPsiZ+?=
 =?us-ascii?Q?pJFH9nllZI/b1OOZlzBNCJR7lCXvLAi5kiWEOIECjSjekOG6LLxd80EVZVly?=
 =?us-ascii?Q?RcjRMBnNlEH4l+halgugsKTR6nt7HB14KS4lKzkxFzM54qbodCZBVtDb3iu9?=
 =?us-ascii?Q?xcMvL62Opz/f+GCzSYTuOsKcZ3GRbbZgKxYmiYDTEeTU+imW7FlcQepM0HS2?=
 =?us-ascii?Q?7k3qY4BnpOlmKlO83Q7QrLl8TVWrtjBmaKf1dlni3B2IgESh+688D/EYEb8h?=
 =?us-ascii?Q?gd78+1kWXRbyI1HjkiczBbNCO2mTHOUk6cuFKd0/gWci5+fN6a24Ul+0WOft?=
 =?us-ascii?Q?F8sLYsdOJzxigxZpAac/Hfq5fg1ALzwrZn8vV55ckJcdZ4ZO6/0DbXa5MXoK?=
 =?us-ascii?Q?Adxc0ox1I4PHn2emds4ct0ujeG8blsInWaOx6VVCoEY45xLJjuCSo52f65Wh?=
 =?us-ascii?Q?DhaBVnSvdppmaZ6U73IHp+GxGxFNFS5wyWi4dBS5LWtYABPahTtUkFpMLvcG?=
 =?us-ascii?Q?/I1Oid70btJPl0uPwEtFygzZkeDk3hgI5DuAg2mxB25YeYUqAuSdet2EGcGo?=
 =?us-ascii?Q?opzIvUGB27d5yFax5xs7tkvpZS9KQXLiwNkPrgNj0fTs/HcWcznaMAh1D50O?=
 =?us-ascii?Q?quAy95geRM97LMqCrGW7q4esl3Qv/TKrsWS4cThQ/Pa4v52MdkaFvrXmQQBO?=
 =?us-ascii?Q?eiGY1D12xpuKkEcQ3d7mB2XokGf9fuokncFP9ZJrtRkQadWSe5KGp8KHCq9h?=
 =?us-ascii?Q?m0wMJJYt7nmXULxRs3NInJ4x5AhTtRFTzZZHWPJV9/EL/liW+hz/ZUDoH1+R?=
 =?us-ascii?Q?Vp91CCTQNEk9LmC/SvjaBCujvMYeva9UF1J32cOEui9FRcBHx3b63uGj7MEZ?=
 =?us-ascii?Q?UE/I8WFhG/61TC5Ws2N/WhCzGli+hJih/f8onQ4+tRYxxMJG4fMXEAcjOGZ4?=
 =?us-ascii?Q?gfoC38xr2FOrGZTm6V1Oz5JHoOUG8XmSITZ9NjBZg6bWYt4yl4Kn9CZ9pALi?=
 =?us-ascii?Q?wz0vDq7VoiFKArI6mOnqm7J5lk10p5OmiUTejWhQu88cjsRqzODWZuVDYOsa?=
 =?us-ascii?Q?Yis9HMa41IYDuCtcx5GvjfRL526mKZZjINLH/hkVZ6G8dSk8qqEElNoTbHxK?=
 =?us-ascii?Q?nboM32m3o3VtRH8Vjd0vS1GUqFg7DuLeq56VtWQsmJcjv2jlYtWsjjqopLS9?=
 =?us-ascii?Q?YDSVDOTfRvKakRamK2jFloP4pj+m8XADVlSfdy4b3crN3yVmg45tKIm1sR31?=
 =?us-ascii?Q?mWsc43s2Lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7c7770-f634-409c-76e4-08dec221c2a4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:12:19.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYYJfTwvS9pv/W4xcZk8qyLDa2Uwpnq2EirE80zoEwdWfvUZShtTl/P8fujO/G/JlT364lvPtlpyh6l5ePbWRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

On Thu, May 28, 2026 at 10:30:06PM +0800, Alison Schofield wrote:
> On Thu, May 21, 2026 at 06:29:22PM -0700, Alison Schofield wrote:
> > On Thu, May 21, 2026 at 04:48:06PM +0800, Richard Cheng wrote:
> > > Add "multi_decoder" module param to the cxl_test emulator. When enabled,
> > > mock_init_hdm_decoder() addtionally programs decoder X.1 on cxl_mem.0
> > > and cxl_mem.4 as a second auto-region carved from the next
> > > mock_auto_region_size of HPA in the same CFMWS window.
> > > The result is 2 committed switch decoders that share the same
> > > downstream-port target_map[].
> > > 
> > > This is inspired by [1] so the emulator can detect and test for scenario
> > > like that.
> > > 
> > > [1]: https://lore.kernel.org/all/20260108101324.509667-1-rrichter@amd.com/
> > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > ---
> > 
> > Hi Richard,
> > 
> > Welcome to cxl-test and thanks for the patch and the explanation.
> > Before we add another module param and hardcoded auto-region, I
> > want to walk through what's already available and see if it covers
> > your need.
> > 
> > The fix for `3e8aaacdad4f` ("cxl/port: Fix target list setup for
> > multiple decoders sharing the same dport") can be duplicated with
> > the user create region path using cxl-test default topology as is,
> > and that can be replayed as an auto region.
> > 
> > I've appended a script to demonstrate it. FWIW, I didn't know
> > this for sure, and was wondering if the auto and user paths might
> > diverge somewhere in this config, but they didn't. I was able to
> > watch it fail without Roberts fix, then pass with it applied.
> > 
> > ICYMI there is a test case in cxl-topology.sh that detects the
> > failure pattern but not a config to verify it like you point
> > out here.
> > 
> > Your implemenation did make me aware of a gap in the region replay
> > capability. On real HW, BIOS programs the decoders, then the OS walks
> > the dports, and update_decoder_targets() is what populates target[]
> > from target_map[]. But cxl-test bypasses that ordering. In cxl-test,
> > mock_init_hdm_decoder() writes cxlsd->target[] itself on replay,
> > which IIUC is why your patch called cxl_port_update_decoder_targets()
> > from the mock to reach Robert's line. Lifting that call into the mock
> > unconditionally, so replay goes through the same dport-enumeration
> > path as real HW would widen what replay actually exercises. I'm not
> > sure how we get there, but if you'd have interest and time to take
> > a look at that, patches welcomed.
> 
> Hi Richard,
> 
> I've been working in this space, using region replay and found what
> I said above started off true about the bypass, but the bypass does
> not actually apply to region replay, only the default auto region.
> 
> In real HW ordering-
> BIOS programs decoder and writes target_map[] and then the OS walks
> dports and update_decoder_targets() reads that target_map[] and
> populates cxlsd->target[].  
> 
> In cxl-test, the place we would need to fix to be more 'like' real
> hardware is the initial mock auto region that gets set up on module load.
> It is the path that takes a shortcut by writing cxlds->target[i] = dport
> directly and setting target_map[i].
> 
> The cxl-test replay_path actually already matches real HW ordering. Target
> lists are populated from the target_map[] during dport enumeration.
> 
> I still think there is a fix in there. The setup of that auto region
> needs to set target_map[], but it needs to stop setting cxlsd->target[]
> and let that happen 'naturally' when the dport enumeration happens.
> There could be some ordering issue with when dport enumeration fires,
> so could get more interesting than that.
> 
> It would be a good fixup to make the auto-region more 'authentic',
> ie force it through more of the actual auto region driver paths.
> 
> -- Alison
> 
>

Hi Alison,

Thanks for the suggestion !

I've sent a patch for it at
https://lore.kernel.org/all/20260529094119.49331-1-icheng@nvidia.com/

Please take a look while you're available, thanks !

Best regards,
Richard Cheng.
 
> 
> 
> > 
> > Does the user-create followed by region replay flow cover your need? 
> > 
> > -- Alison
> > From 0fcdebae75d307036d83f8b7be971db305b83660 Mon Sep 17 00:00:00 2001
> > From: Alison Schofield <alison.schofield@intel.com>
> > Date: Thu, 21 May 2026 17:39:51 -0700
> > Subject: [PATCH] WIP test/cxl-multi-decoder-shared-dport.sh
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  test/cxl-multi-decoder-shared-dport.sh | 139 +++++++++++++++++++++++++
> >  test/meson.build                       |   2 +
> >  2 files changed, 141 insertions(+)
> >  create mode 100755 test/cxl-multi-decoder-shared-dport.sh
> > 
> > diff --git a/test/cxl-multi-decoder-shared-dport.sh b/test/cxl-multi-decoder-shared-dport.sh
> > new file mode 100755
> > index 000000000000..5f15b23f3a27
> > --- /dev/null
> > +++ b/test/cxl-multi-decoder-shared-dport.sh
> > @@ -0,0 +1,139 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2026 Intel Corporation. All rights reserved.
> > +
> > +. $(dirname $0)/common
> > +
> > +rc=77
> > +
> > +set -ex
> > +
> > +trap 'err $LINENO' ERR
> > +
> > +check_prereq "jq"
> > +
> > +modprobe -r cxl_test
> > +modprobe cxl_test
> > +
> > +rc=1
> > +
> > +# Regression test for kernel commit 3e8aaacdad4f ("cxl/port: Fix target
> > +# list setup for multiple decoders sharing the same dport").
> > +#
> > +# Create two user-space regions on the same root decoder, claiming the
> > +# same memdev set. Topology routes both regions through the same switch
> > +# downstream ports, so each switch port ends up with two committed
> > +# decoders sharing the same dport. cxl_test enumerates dports per
> > +# memdev attach, which fires cxl_port_update_decoder_targets() against
> > +# the already-committed decoders and lands on the line the kernel
> > +# commit fixes. A pre-3e8aaacdad4f kernel stops after the first match
> > +# and leaves the second decoder's cxlsd->target[] empty (nr_targets=0).
> > +#
> > +# replay_regions exercises the same shape after a cxl_acpi unbind/bind,
> > +# so the regression is checked on both the user-create and replay
> > +# paths.
> > +
> > +destroy_regions() {
> > +	$CXL destroy-region -f -b cxl_test all
> > +}
> > +
> > +# Pick the volatile-capable, 2-target root decoder. The cxl_test
> > +# topology routes its 4 targets via 2 switches (HB0/sw0, HB0/sw1),
> > +# 2 memdevs per switch. Both regions below claim all 4 memdevs, so
> > +# they share the same switch dports by topology.
> > +find_x4_ram_decoder() {
> > +	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
> > +		select(.volatile_capable == true) |
> > +		select(.nr_targets == 2) |
> > +		.decoder")
> > +
> > +	[[ $decoder ]] || err "$LINENO"
> > +
> > +	# Decoder window must hold two regions
> > +	# Each region size is half the window.
> > +	decoder_size=$($CXL list -d "$decoder" | jq -r '.[0].size')
> > +	[[ -n "$decoder_size" && "$decoder_size" != "null" ]] || err "$LINENO"
> > +	region_size=$((decoder_size / 2))
> > +
> > +	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
> > +		.targets | .[] | select(.position == 0) | .target")
> > +	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
> > +		.targets | .[] | select(.position == 1) | .target")
> > +
> > +	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
> > +	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
> > +	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
> > +	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
> > +	memdevs="$mem0 $mem1 $mem2 $mem3"
> > +}
> > +
> > +create_region() {
> > +	local size="$1"
> > +	local region
> > +
> > +	region=$($CXL create-region -d "$decoder" -m -s "$size" "$memdevs" |
> > +		jq -r ".region")
> > +
> > +	if [[ -z "$region" || "$region" == "null" ]]; then
> > +		echo "create-region failed for $decoder"
> > +		err "$LINENO"
> > +	fi
> > +	echo "$region"
> > +}
> > +
> > +# Similar to cxl-topology.sh - test_switch_decoder_target_enumeration()
> > +# Counts switch ports where >=2 decoders are programmed (one with
> > +# targets, one or more without). After both regions are committed,
> > +# every switch port we use should have >=2 decoders programmed.
> > +check_shared_dport_enumeration() {
> > +	local label="$1"
> > +	local issues
> > +
> > +	issues=$($CXL list -b cxl_test -vvv | jq '
> > +		[.. | objects | select(.depth == 2 and has("decoders:" + .port))] |
> > +		map({
> > +			nr_dports: .nr_dports,
> > +			with_targets: ([to_entries[] |
> > +				select(.key | startswith("decoders:")) |
> > +				.value[] | select(has("mode") == false and
> > +				.nr_targets > 0)] | length),
> > +			without_targets: ([to_entries[] |
> > +				select(.key | startswith("decoders:")) |
> > +				.value[] | select(has("mode") == false and
> > +				.nr_targets == 0)] | length)
> > +		}) |
> > +		map(select(.nr_dports > 0 and
> > +			   .with_targets >= 1 and
> > +			   .without_targets >= 1)) |
> > +		length')
> > +
> > +	if ((issues != 0)); then
> > +		echo "$label: $issues switch port(s) with incomplete target enumeration"
> > +		echo "(>=1 decoder with targets, >=1 with nr_targets=0)"
> > +		return 1
> > +	fi
> > +	echo "$label: switch decoder target enumeration OK"
> > +	return 0
> > +}
> > +
> > +# Start clean so we own all RAM capacity.
> > +destroy_regions
> > +
> > +find_x4_ram_decoder
> > +
> > +region_a=$(create_region "$region_size")
> > +region_b=$(create_region "$region_size")
> > +
> > +check_shared_dport_enumeration "after user-create" || err "$LINENO"
> > +
> > +replay_regions || err "$LINENO"
> > +
> > +check_shared_dport_enumeration "after replay" || err "$LINENO"
> > +
> > +# Destroy in reverse DPA order
> > +$CXL destroy-region -f -b cxl_test "$region_b"
> > +$CXL destroy-region -f -b cxl_test "$region_a"
> > +
> > +check_dmesg "$LINENO"
> > +
> > +modprobe -r cxl_test
> > diff --git a/test/meson.build b/test/meson.build
> > index e0e2193bfd51..4abad21102a7 100644
> > --- a/test/meson.build
> > +++ b/test/meson.build
> > @@ -171,6 +171,7 @@ cxl_translate = find_program('cxl-translate.sh')
> >  cxl_elc = find_program('cxl-elc.sh')
> >  cxl_dax_hmem = find_program('cxl-dax-hmem.sh')
> >  cxl_region_replay = find_program('cxl-region-replay.sh')
> > +cxl_multi_decoder_shared_dport = find_program('cxl-multi-decoder-shared-dport.sh')
> >  
> >  tests = [
> >    [ 'libndctl',               libndctl,		  'ndctl' ],
> > @@ -207,6 +208,7 @@ tests = [
> >    [ 'cxl-elc.sh',             cxl_elc,            'cxl'   ],
> >    [ 'cxl-dax-hmem.sh',        cxl_dax_hmem,       'cxl'   ],
> >    [ 'cxl-region-replay.sh',   cxl_region_replay,  'cxl'   ],
> > +  [ 'cxl-multi-decoder-shared-dport.sh', cxl_multi_decoder_shared_dport, 'cxl' ],
> >  ]
> >  
> >  if get_option('destructive').enabled()
> > -- 
> > 2.37.3
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > >  tools/testing/cxl/test/cxl.c | 88 +++++++++++++++++++++++++++++++++---
> > >  1 file changed, 81 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > > index 418669927fb0..929bbee471db 100644
> > > --- a/tools/testing/cxl/test/cxl.c
> > > +++ b/tools/testing/cxl/test/cxl.c
> > > @@ -17,6 +17,7 @@
> > >  static int interleave_arithmetic;
> > >  static bool extended_linear_cache;
> > >  static bool fail_autoassemble;
> > > +static bool multi_decoder;
> > >  
> > >  #define FAKE_QTG_ID	42
> > >  
> > > @@ -1041,6 +1042,17 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
> > >  	WARN_ON_ONCE(!cxld_registry_new(cxld));
> > >  }
> > >  
> > > +static int decoder_by_id(struct device *dev, const void *data)
> > > +{
> > > +	int target_id = (int)(uintptr_t)data;
> > > +	struct cxl_decoder *cxld;
> > > +
> > > +	if (!is_switch_decoder(dev))
> > > +		return 0;
> > > +	cxld = to_cxl_decoder(dev);
> > > +	return cxld->id == target_id;
> > > +}
> > > +
> > >  static int first_decoder(struct device *dev, const void *data)
> > >  {
> > >  	struct cxl_decoder *cxld;
> > > @@ -1079,6 +1091,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  	struct cxl_memdev *cxlmd;
> > >  	struct cxl_dport *dport;
> > >  	struct device *dev;
> > > +	int max_decoder_id;
> > > +	int region_decoder_id = 0;
> > >  	bool hb0 = false;
> > >  	u64 base;
> > >  	int i;
> > > @@ -1129,9 +1143,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
> > >  	 *
> > >  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> > > +	 *
> > > +	 * When multi_decoder is enabled, additionally program decoder
> > > +	 * X.1 of the same endpoints as a second auto-region that shares
> > > +	 * the switch's downstream ports with the first region, so that
> > > +	 * the same dport ends up in target_map[] of two committed switch
> > > +	 * decoders simultaneously.
> > >  	 */
> > > +	max_decoder_id = multi_decoder ? 1 : 0;
> > >  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> > > -	    pdev->id > 4 || cxld->id > 0) {
> > > +	    pdev->id > 4 || cxld->id > max_decoder_id) {
> > >  		default_mock_decoder(cxld);
> > >  		return false;
> > >  	}
> > > @@ -1142,9 +1163,14 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  		return false;
> > >  	}
> > >  
> > > +	region_decoder_id = cxld->id;
> > > +
> > >  	base = window->base_hpa;
> > >  	if (extended_linear_cache)
> > >  		base += mock_auto_region_size;
> > > +	/* Place the second auto-region right after the first. */
> > > +	if (region_decoder_id == 1)
> > > +		base += mock_auto_region_size;
> > >  	cxld->hpa_range = (struct range) {
> > >  		.start = base,
> > >  		.end = base + mock_auto_region_size - 1,
> > > @@ -1156,7 +1182,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  	cxld->flags = CXL_DECODER_F_ENABLE;
> > >  	cxled->state = CXL_DECODER_STATE_AUTO;
> > >  	port->commit_end = cxld->id;
> > > -	devm_cxl_dpa_reserve(cxled, 0,
> > > +	devm_cxl_dpa_reserve(cxled,
> > > +			     region_decoder_id *
> > > +				 (mock_auto_region_size / 2),
> > >  			     mock_auto_region_size / cxld->interleave_ways, 0);
> > >  	cxld->commit = mock_decoder_commit;
> > >  	cxld->reset = mock_decoder_reset;
> > > @@ -1165,12 +1193,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  	/*
> > >  	 * Now that endpoint decoder is set up, walk up the hierarchy
> > >  	 * and setup the switch and root port decoders targeting @cxlmd.
> > > +	 *
> > > +	 * For region 0 use switch-decoder slot 0 (selected by
> > > +	 * first_decoder()); for region 1 use slot 1 so that the two
> > > +	 * regions exercise the multi-decoder / shared-dport scenario.
> > >  	 */
> > >  	iter = port;
> > >  	for (i = 0; i < 2; i++) {
> > >  		dport = iter->parent_dport;
> > >  		iter = dport->port;
> > > -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> > > +		if (region_decoder_id == 0) {
> > > +			dev = device_find_child(&iter->dev, NULL,
> > > +						first_decoder);
> > > +		} else {
> > > +			dev = device_find_child(&iter->dev,
> > > +						(void *)(uintptr_t)region_decoder_id,
> > > +						decoder_by_id);
> > > +		}
> > >  		/*
> > >  		 * Ancestor ports are guaranteed to be enumerated before
> > >  		 * @port, and all ports have at least one decoder.
> > > @@ -1179,23 +1218,36 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  			continue;
> > >  
> > >  		cxlsd = to_cxl_switch_decoder(dev);
> > > +		/*
> > > +		 * Region 0 (decoder.0) keeps the historical shortcut of
> > > +		 * stamping target[] directly so single-region setup is
> > > +		 * unaffected by dport-add ordering quirks of cxl_test.
> > > +		 *
> > > +		 * Region 1 (decoder.1, only programmed when
> > > +		 * multi_decoder=1) intentionally leaves target[]
> > > +		 * to update_decoder_targets() at dport-add time.
> > > +		 */
> > >  		if (i == 0) {
> > >  			/* put cxl_mem.4 second in the decode order */
> > >  			if (pdev->id == 4) {
> > > -				cxlsd->target[1] = dport;
> > > +				if (region_decoder_id == 0)
> > > +					cxlsd->target[1] = dport;
> > >  				cxlsd->cxld.target_map[1] = dport->port_id;
> > >  			} else {
> > > -				cxlsd->target[0] = dport;
> > > +				if (region_decoder_id == 0)
> > > +					cxlsd->target[0] = dport;
> > >  				cxlsd->cxld.target_map[0] = dport->port_id;
> > >  			}
> > >  		} else {
> > > -			cxlsd->target[0] = dport;
> > > +			if (region_decoder_id == 0)
> > > +				cxlsd->target[0] = dport;
> > >  			cxlsd->cxld.target_map[0] = dport->port_id;
> > >  		}
> > >  		cxld = &cxlsd->cxld;
> > >  		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> > >  		cxld->flags = CXL_DECODER_F_ENABLE;
> > > -		iter->commit_end = 0;
> > > +		if (iter->commit_end < region_decoder_id)
> > > +			iter->commit_end = region_decoder_id;
> > >  		/*
> > >  		 * Switch targets 2 endpoints, while host bridge targets
> > >  		 * one root port
> > > @@ -1212,6 +1264,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> > >  		cxld->commit = mock_decoder_commit;
> > >  		cxld->reset = mock_decoder_reset;
> > >  
> > > +		/*
> > > +		 * For the second region only target_map[] is set above,
> > > +		 * not cxlsd->target[]. On real hardware target[] gets
> > > +		 * populated when dports are added (BIOS-programmed
> > > +		 * decoders are read first, then dports get enumerated).
> > > +		 * cxl_test's order is reversed: dports were added long
> > > +		 * before this point, so re-fire the update here against
> > > +		 * each existing dport to mimic the real-hardware
> > > +		 * ordering and exercise update_decoder_targets() with
> > > +		 * pre-programmed decoders.
> > > +		 */
> > > +		if (region_decoder_id == 1) {
> > > +			struct cxl_dport *existing;
> > > +			unsigned long index;
> > > +
> > > +			xa_for_each(&iter->dports, index, existing)
> > > +				cxl_port_update_decoder_targets(iter,
> > > +								existing);
> > > +		}
> > > +
> > >  		cxld_registry_update(cxld);
> > >  		put_device(dev);
> > >  	}
> > > @@ -2049,6 +2121,8 @@ module_param(extended_linear_cache, bool, 0444);
> > >  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
> > >  module_param(fail_autoassemble, bool, 0444);
> > >  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> > > +module_param(multi_decoder, bool, 0444);
> > > +MODULE_PARM_DESC(multi_decoder, "Auto-program a 2nd decoder per endpoint sharing switch dports");
> > >  module_init(cxl_test_init);
> > >  module_exit(cxl_test_exit);
> > >  MODULE_LICENSE("GPL v2");
> > > -- 
> > > 2.43.0
> > > 
> > 
