Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F21181BA9
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000856; cv=fail; b=Q4LKgLj4Cbz5NZ3n+dHVxY5k/q5LVBQsbLTy8p5fO1EUj+m2d/+PIpUQ7vsYtpe6BmKqjUC0DXYCmAhh2yeg3k1l8ZyX3qk3DpAUOHwlj5+b/cTzHxfKRn5itV0f1tc5rVXvKeBvR/BBYWKfjV2nNE0+JUPRA4ZgTHEyLErodtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000856; c=relaxed/simple;
	bh=Eyg2RwMbPOJkOcNnnLgxHgDn1z/WThk4NNkTKsONUZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SBnwFqBdsXGu3PY5tjnRs5QIVOLZfF95EGN81MfE8Pn70aN2A7n2bqaY58bABpmBoKk/vgQl2ft5D8WtV2BTQcszHqAmciTLGC7EpclbfGPsSAHpsFjAskyyOBGoh5Z00urDDL4V1+Gwppso6gc0sW5b26CXTH1e5/Pf+9lQMTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=U1HR0tuM; arc=fail smtp.client-ip=40.107.220.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="U1HR0tuM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFeHCaNVGxJ+2ZyyEU1hXU6rEHo2Zk5GM7Gwm5J4aqmOcx8uJapqpVoEVXwUnkZaDSr/OJ+bljvyt4bDH/akpk34jBOCUF1CM08f6W/Js2/k1UJdwO7k65U67sQtZgKzaiawfSz5bdjTTOdCjFmXmbYHtILVr+vPdt8ZH/5X5EXcTW+9Kafw0BGE9CZe3QojBf3O5tIhV3LbVOODFwWjlKuffB72ewG053hBFF0mM6PFjZknp30G3sCaKnNfRQsxnKRVv7HlJe35Q9g0qv8ZVGj6IwulbwCZOvTeUlyOMz0AHjl+GCgasEdk6AMERLzyte9Z74sYdtjpjkJCGH5KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4Ju9KcQrJU6BqFQZBTfKC6qaSkXnO6miyTxMPTK+ME=;
 b=EplIflcqZIdaF9su0LO5Sv5HD0l74lrn+6W0hDHUfCZgkC2YHjERbnMHLVJtf/5KL6a72eSa0SNfuSTUjzlUZzmgBkblKcVhgwwDn1a18yridhjIy+6cbH68IJtY/Fic0xsMnWjlXADPNbBSFwbBAj1FtvjZEmGB+J55v/C4i9P87YRevgtQd3HyYYX7S0Vs6e8dw2XiOuCeVUkRpxqHyTyGd6MifAjqA7NitaGGIYl62u2qt49MP1o0E6N63BtHSaWM4SNipQRngCKNuuHia9ygOXTjUeDCdS1r83eZ4qDM8Y1LxFHbjxbz1fGXcZQOQlrkpyfxzpf7lo2j26t+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Ju9KcQrJU6BqFQZBTfKC6qaSkXnO6miyTxMPTK+ME=;
 b=U1HR0tuM7D2cmlIKCb0KCq4dTAYZdgEas6xU9HbtV9ypYQ7RqnYvJY/WEEjBgpMba/9GQJT3RIXiIuqNnTGmtzXwylnN+JoJ+TUBR5QM4pDiZWhhvUtXUhKgvywemAdJohj0YXnlhwzAlBJl0fl0/mBvy6r7a9FlyK/AKFyviEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from MW4PR17MB5515.namprd17.prod.outlook.com (2603:10b6:303:126::5)
 by SA1PR17MB4852.namprd17.prod.outlook.com (2603:10b6:806:19f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 16:40:50 +0000
Received: from MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::a27e:e0a5:9b63:297f]) by MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::a27e:e0a5:9b63:297f%6]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 16:40:50 +0000
Date: Wed, 29 May 2024 12:40:41 -0400
From: Gregory Price <gregory.price@memverge.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Cc: 'Dan Williams' <dan.j.williams@intel.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: CXL volatile memory: How to restore the previous
 region/Interleave set
Message-ID: <ZldaiYTv1fPcGbCs@memverge.com>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To MW4PR17MB5515.namprd17.prod.outlook.com
 (2603:10b6:303:126::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR17MB5515:EE_|SA1PR17MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: e30b88ee-3708-4fa8-6d26-08dc7ffe192d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cWq6JGWpxIKxyOIM0FmrM/CleTGcHrjmY4Omep8KqMoUtG7yfOdhEb2xgf0j?=
 =?us-ascii?Q?0UANwXhWuSYigdwRq+4WcZZRs1HDTi/xPb9ViBXc4lLc/wB54PLX42vx/cgL?=
 =?us-ascii?Q?S+STvC/0OgiISCAWiEhPZn3PcZCZ3eTn7VpCV9lpIXi0z5nUvr7Uq3lkrII3?=
 =?us-ascii?Q?vWLuQwLLmP5pbd3QyFADXpcsnl4V7BMJA7bE0H4tyUx3X+azgrLZGonCQHac?=
 =?us-ascii?Q?lWAj1k07kgvSdXWA5cp7+mzRyyVSWaBW3pV+sJboZFfOtYwJXKOJ1S1xG9WZ?=
 =?us-ascii?Q?Nw/sUYL0SidNKrsIBbNwae1f+Z4HsFwM2lR7MBEkN/b5Z2htTro3POMJIXRE?=
 =?us-ascii?Q?nCm1nHHg0NqmmB4qOMhmIllW6h2rwgf+rNxHxnSHASad5cfu0OD5g5nYde1n?=
 =?us-ascii?Q?2aPoRtpYXfIqkg/O1fu71JIrnLFNrcx9Lc6NoT8pmA6TAisSbg5BD+2ISph7?=
 =?us-ascii?Q?J8NNYxy9Fova++YfZ6X+y9OlOfSNp1+nNLOb5AIwwDGB1ORrt4laZvXTjpTL?=
 =?us-ascii?Q?LVmeXSE08dFIf5o7trgvu0xQGpdK2dKz80pzKQzRo3B1o/BA/sHQfdp7295f?=
 =?us-ascii?Q?cmI49y6EMdl7exHqa+c3CYuLChkeeMBHuqMPrJt3ZcFQuyhACFdjOyuX3Wrv?=
 =?us-ascii?Q?2VWTbnbtVdIix0OXQWr5El/AJ0Kflvi7dBx0cPIJZRd2VWc2A0qVXHmxQwPt?=
 =?us-ascii?Q?i340t4aHxdu8VAAxMw40Ctei0FxMRXpmtZqEdVaJ3hdAUizQoYXzVMRA1ELK?=
 =?us-ascii?Q?+OqtGTUAAbeXPrjlblwDRKyxGQIk8LR35UTZwdLi7hsTAEX/0oB0gYKmc/78?=
 =?us-ascii?Q?zfbx17+BixzAi85pnsgtlZvEhZrF7M4v21OOjZh5cIsNepWa98eywCcw0fmh?=
 =?us-ascii?Q?5UaBKfJpIvg3BzjhDU/uW0vczd03JdD5RzYkFPOE2nDUfD+qWXfad8HxED8n?=
 =?us-ascii?Q?pPP38tBfWWu4Nx1QVJqm+L9ULs1vFA8zXtEpOxuNMi4F/oZRPu+yxMpCyUKW?=
 =?us-ascii?Q?eW612ObP/Pc/FS9gKSoo8G8FmVLiFkeu7AGBpYWnYr9b2A9tBBGjua1F1bYf?=
 =?us-ascii?Q?t6+gwN+pZNddGfA+ZJTwHr1+WAzbwDBwBPKHZlwmXvrbKkMaKYzS9L8d3yoL?=
 =?us-ascii?Q?BrswJyxvtAvHbwNe76Vgp2/bmxFzCjZoQvrHZkGZH16cYDT//7w5XT11WAQn?=
 =?us-ascii?Q?+kX1ALs9PpGJtkye6As9Tzt31RzZSenoMuezKoOtkEfFIl3iPgjEPvQQ3nbI?=
 =?us-ascii?Q?XxXyeFVefPJmK1nuNTxJ7EFqzxRs1DIXJpePH6N3cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB5515.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zG4Gj/9QX9nySHPw9LAGsfG1d9PTIDZRdL1ZYUpugT4DdpOky6TCv9iV0W0k?=
 =?us-ascii?Q?2uwBk6cq47ISR4Gb0jwCPE1btMn4sljhAsXRvWrZNE5uC0m0UKWXgyqSpieC?=
 =?us-ascii?Q?nferOFV15te1gIow1FZT0rX25KvcpSDbo9jWLwTy/4gr+CvN85yiFJG4XEkc?=
 =?us-ascii?Q?KEAYOa+2nyUm0EKb0IY/480rhDYj6Vhp41HGZocOziEIHAxexuiObSRJdp2P?=
 =?us-ascii?Q?xfbNDtsSS+V0L1tyst9MMYszUCcIauTMQEH1lITjydz6Ub/R1VedZn/Bl7H9?=
 =?us-ascii?Q?ZyeuVijpqhYPTufrC0AAx9bQs/tjV6Atn8mIcgdp5UA4P9xsZfKHg7MFp589?=
 =?us-ascii?Q?t3ylRLZ7rJXUVhXWKeWIcLQYE91deTRTW0uNEhEtjS7zCeqbJzZqrqzCqKFp?=
 =?us-ascii?Q?eChjc/WSi97Xugz6et8iPcYTdFHg0fiLdL+eyN+daELTNqSjj3K9am5qvc1r?=
 =?us-ascii?Q?D/4th+IWamw7Vj2VY8AqrcsKjZX9WmuQ147DAM0lCDN0V/bPZ4ndZJ8LdZPZ?=
 =?us-ascii?Q?2e1dwx2yjlhvxsdIz9CGu1AlKl0wvRTbUEC51+a6Fa+nsnnRm81km9KxcovO?=
 =?us-ascii?Q?7hPTUF0xIHZQJtRKiPDjZ17HTkVGLcCfUSbjLHkz4LtMqdaLCHj2DrwJfxcT?=
 =?us-ascii?Q?ZhaAnHIgiEFaYd908bzx4UHkaRgDoLO/x3TNngTYUJ0hZ8ktGmTtjHb3VQjD?=
 =?us-ascii?Q?KE3o4LTMJhW6U50J9UmewQHRxEyMUr5J38VhNq6Lb8kmVW5gdVRxzSIXOn8y?=
 =?us-ascii?Q?UaOfcDD0dhpbgPbT5n3e3hjtVYz7SnclfbW5Zifd4gaTNTT5gxih42bZ4GIW?=
 =?us-ascii?Q?2UmpIKVa1NMLq0Hc6Wh83QL+xuKylJ5b+Tq/MWUa3P84L8C0apTIYSZwuwQZ?=
 =?us-ascii?Q?APNjBTewxzNiw0Z7FBdWCDhyLj5awJyjnQ7rkkDVmrcZvUqkkGu6kED5EU2C?=
 =?us-ascii?Q?+hdxplNrYs+gREPITG/Ctur8NaMFELJKoyLFIpX61rsCbv0MgrTxU+ABzds0?=
 =?us-ascii?Q?DMkLlUrDy1HGkurXJyfVCo8N5mOCAltIc/G8dYXkc1d8gjZHKr92rWtWYLat?=
 =?us-ascii?Q?DEoQuCcjjsqg0zQ1+8QE2C/zi7+sWLYgb3DBNqpEwCooKX1HusS/yOfnpdIJ?=
 =?us-ascii?Q?dLq2kpFYb+1nvLQ1dsAi9wOCyWNRR8a2GVwo0r6NRkfSFvx6dlUzUUWnpdgv?=
 =?us-ascii?Q?Ycvf9WRPAvTt35g9yka3M8g6KoegCLCe3gFGVn0jYZH2ZPLC489kGCbiwRoN?=
 =?us-ascii?Q?g8u+RM2TLWyXL1Ugz7glWfZxtM5MEtjKBW3FN6QS2KsqfPWwnQwbKqxo8jU+?=
 =?us-ascii?Q?oOuZDaI5fp93EGly695L725B/Cd5hIbl/BKKpD5c1bP1lk0899cM+dV9dOgJ?=
 =?us-ascii?Q?/Yh2sPlV2aznj4BU6gzLpXfH14qo9BjpQUkKPaEp8wDctBUMLYpCBZDyIOKI?=
 =?us-ascii?Q?a6ey4DS0ZZbP2UFEhIJGrYgxdNt1Fonx6ZSEocb4eT0VhOk0muglR7v5J4gS?=
 =?us-ascii?Q?LPctEPTR5cySQppSWNxKoRxoAF8YMsCrMKZBV90JcA7JCE7WJ5wt4Db3fR5T?=
 =?us-ascii?Q?b/MOevoBr7/Y4MQEBPyh9yKuhliClygtxoZbOmDOdb4PKEU5cLT+rnUYuK1c?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30b88ee-3708-4fa8-6d26-08dc7ffe192d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB5515.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:40:50.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2By3VAelkgVR/k5oZxMmLIL98DzTDQmoxWGXEXh7Z4cqo+8VolOdEbtnBFFj9SrzB+HhoLwRr2cN1i4bFl9Q4Kj1vqoF5IC3Xf8dE8WazKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4852

On Wed, May 29, 2024 at 11:33:46AM +0000, Yasunori Gotou (Fujitsu) wrote:
> Hi Dan-san,
> 
> > > Q3, For CXL volatile memory devices without LSA installed, if users
> > > expect to restore the Interleave set to the previous configuration
> > > after reboot, the questions are:
> > > Q3.1 Where should the Interleave Set information be stored?
> > > Q3.2 Which component is responsible for restoring the Interleave Set?
> > 
> > The expectation is that BIOS, or the OS for hotplug devices, deploys a default
> > region configuration policy. That policy in the common is likely one of either
> > maximizing performance (maximize interleave across host-bridges), or
> > maximizing error isolation (create an x1-interleave region per endpoint).
> 
> To be honest, I feel CFMWS seems to be something incomplete spec.. 
> 
> When I first saw the " CXL* Type 3 Memory Device Software Guide", and noticed existing
> CFMWS, I thought that the firmware would create it based on some configuration,
> and OS would read it and create region for each window information.
> Even if user would execute cxl create-region command and configure interleaved region,
> I thought OS would tell it to firmware (or something), and CFMWS would reflect it on the next boot.

Ok this has just made me realize that I really do need to write that
article on the various forms of interleaving in a post-CXL world.


Quoting some of the specification rq:

CXL 3.1 Section 9.18.1.3: CXL Fixed Memory Window Structure

"""
The CFMWS structure describes zero or more Host Physical Address (HPA)
windows that are associated with each CXL Host Bridge.  Each window
represents a contiguous HPA range that may be interleaved across one or
more targets, some of which are CXL Host Bridges.  Associated with each
window are a set of restrictions that govern its usage.  It is the
OSPM's responsibility to utilize each window for the specified use.

The HPA ranges described by CFMWS may include addresses that are current
assigned to CXL.mem devices.  Before assigning HPAs from a fixed-memory
window, the OSPM must check the current assignments and avoid any
conflicts.

For any given HPA, it shall not be described by more than one CFMWS
entry
"""

Dan, please correct me if I'm wrong, but I'm fairly certain the
following is accurate.



The CFMWS is the BIOS/EFI's mechanism to report the system configuration
to the Operating System, not the Operating System's mechanism to change
system configurations (such as interleave).  What you're talking about
is re-configuring HDM Decoders to interleave devices *presented by* the
CFMWS to the operating system.

Confusing, I know. But stick with me.



The interleave referred to the CFMWS is the BIOS/EFI telling the system
that memory accesses to this (physicall address) region will be interleaved
across the set of devices that are backing that region. The operating system
is responsible for reading these settings and presenting the memory to the
system accordingly.

The BIOS for example could configure all devices behind a single CFMW as
a "Single Device" that interleaves many physical devices, and the OS should
present it as such.  In this scenario, there is no need to configure an
interleave region via cxl-cli - the BIOS already did that for you and
presented all these devices as a single device.  All you need to do is
online the memory.

Configuring the CFMWS *should* (but may not) manifest as a set of BIOS/EFI
options that say how to configure a set of CXL devices behind one or more
host bridges prior to OS boot. This has its limitations. For example, you'd
need to reboot the system to make changes and hotplugging a memory device
becomes impossible. The BIOS/EFI would also need to understand when the
prior configuration is no longer valid - complicated and problematic.

Additionally, for more dynamic environments (devices behind a switch,
or a DCD) this more "static" configuration may (read: does) reduce your
management flexibility.  I.e. hotplug may not be possible.



Alternatively, the BIOS may configure each device separately, and the
OS is may create a region that interleaves those devices explicitly by
programming an HDM decoder.

In this scenario, the OS could tear down the region, hotplug that device,
and recreate the region with new settings accordingly. Greater
management flexibility, but more software/management complexity.

This requires the OS to recreate the region/interleave set on each
reboot - and is probably the preferred mechanism for configuring the
system (if only because hotplug and device failure is not uncommon).

In this scenario, re-configuration looks a lot like storage mounting.
The device is either there or it isn't, and the configuration file
either works or it doesn't.  Alternatively the daemon setting this all
up is free to try to make auto-configuration decisions.




(Final note about interleave for completion sake, but not really
relevant to this discussion)

Alternatively you could just online each device as a separate region,
and simply use something like set_mempolicy/numactl to implement
interleave on a per-task basis.


> 
> But, really is that the above scenario is only for persistent memory with LSA.
> Even if a user configures a new region for volatile memory, and I could not find any specification to
> tell the new configuration to the Firmware. 
> 
> Could you tell me why such interface is not defined in the CXL specification?
> Is it just because there is no place to store region information for volatile memory?
>
> 
> IMHO, users want to keep previous configuration after reboot even if it is volatile memory.
> Though users don't concern about contents of volatile memory, they want to keep region/interleave
> configuration after reboot. Especially, if previous configuration is some years ago, I'll bet
> users will forget how they configured regions against cxl volatile memory.
>

Probably we want some daemon that reconfigures this similar to how we're
doing it with storage.  You register a preferred configuration given the
hardware environment that is valid until the hardware changes.

The OS shouldn't really be telling the firmware to configure itself if
only because what happens if you unplug a device?

~Gregory
