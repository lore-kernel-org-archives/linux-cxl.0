Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD21DF27F;
	Fri,  5 Jun 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678803; cv=fail; b=LMWmYVRw6GQ/ji3wdXRpS/cMc8+q83RsDjMBygNZsZku118gaGjcJuOShU+bsPvsR8QgM1WGtQWGmxrpTtjJRO1kHqXQ6q1ioGp5Ufa65IRIoX+Id3GnYbbvaq8zTLioKWaWQ+qeFaPUYEIURY+j2CuwsDyA5CGgPtXjhHidHaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678803; c=relaxed/simple;
	bh=j82ZIfFzlRVKk/gf7YhrAAHjQvHsJiCL6CTiVy1Thu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFn9FqE2mSHvKMcCycWXfU82+nRPzJRLaqWZZZ+8XbM08hSArmHasgLC79n/SpANn6Afzlmvs8XOKKKzdsiFps3W8rgofTcnTI1KYDFpYYKk47NQwka4V+lknqcHtIEdrG6Pf1MiafNhfG8B/nCl/qI6Axh/9nKdzwkBfvQr/84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ayzy6OE9; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ayzy6OE9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzoff4e4O2FarT1iQtnz5oQ1XEKrWWXhlt2vGlh5gFzEl8Fsztf3WETQdEQ4P+x9wiOH3CPyu1tQorQ+6+wmpUqmUz+OQ5aa5IGEZUVzHiRlZMSBDZmzC6oLNAC5U/Qd7912iCjSM5k5YXD8xzvI3hTnx4B6lLAbgM0X7O2ZzR5DxsqqPmsyIagAsCFAZ3i1R1HePYwfBwXtn5hPCp52A0gRGBvbcC/xc3pn0kls/tmgUNr3sBtepVyD7D0U01Rk0GdX+HcYK1jbbnaogm4guJ9x47Gt9kOvbmVlk3WvhuwBpC2MJbNpTp6jJOUeymFRaqcT3a6WO9G4atrk2+ltHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEZ/mG3welrprebAEscXj68ephcWzO9rqq2JaavdtUs=;
 b=v/wbVMK0gdgQdHFrCFOrqd/0j1H4O3SXCf6bGjlFvkBAWPZiqXcUsfpnrDaWwSfKB0dCzNSPAcqK+4n4425wQQHxt8xsz3ZTO7jfdUjRMqcq6uQoVd37+wegF1deJbgGNOTOv5WBTNmfk8HxuZTBguFaeyFeSxIBpQSYdQAL0rinBAxThIDlvMxyCsGn2h9JA48k8AfhUluQIuQBJIuyE4woKwGetP31cmjxKeCkNFZcOexaEtS4N75xO265ogl5Cfv468Tf/6cI5byYl4V4i5+dzP79P3hfi6FOxmW0LplmjjtxYdY2CSYJpxpMA4F98Eebz1jp1DLu0IBcGwgh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEZ/mG3welrprebAEscXj68ephcWzO9rqq2JaavdtUs=;
 b=ayzy6OE9XmdaL1Er6GHMbfzB52yRKqhBbWDedPgAqobK9zH4eShK+Q91R+ie+jmGItIx21KDY+8rvlFH7VBFojZJQgjYT0iHX7Ovuo6jhF7Fk4nNuTBrYjyZv8D8vCX5HvRaQTreLnufcKlwEDuRcjVV7ClA7iumTsnGjPXQp/LvLyfIYJUqPtwup2iicwBzxDFlbkIEB89jwffI1VjyysmJUlyRuxhkbxOKdvy1/shy1iK/C7BlE1Bx6bUIHWYLmx5ob1TNxDA0ydYZqXMdfEY9ulLezlq7eO5sePKdfuPkQXrT3L+ook9J97Ki9J3DWSikln4ooOLd9Kw0pITp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:59:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:59:56 +0000
Date: Sat, 6 Jun 2026 00:59:49 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, smadhavan@nvidia.com, vaslot@nvidia.com
Subject: Re: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
Message-ID: <aiMAVuHbjXQGaCf-@MWDK4CY14F>
References: <20260605041602.37944-1-icheng@nvidia.com>
 <951d3e9b-f9f4-4d16-8119-1543ed9e44f1@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951d3e9b-f9f4-4d16-8119-1543ed9e44f1@intel.com>
X-ClientProxiedBy: KU0P306CA0034.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c1dd63-12fb-47ac-5207-08dec323debd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|5023799004|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZtzffBzaNwwBuP2tmFO0V16EU5wWUV0UyY4nw7Oa80E+WFLTZOdI+olodz5OLnnVC1yRuYHtYDXZ19JAKZ0/mtPUwgzbo1C+JWj3UK74EDn5nybTiewlkG04lvHTi1HWRI/Fym3/xDMtoMJ074kdMwjPnbhEraygq+l8k7/mVDwbbd/B3XikwSkL2APUvRCEDQvqyxTky8hAq49l7jZI+ZYh3imfl7QBXxrvXPsPM6lrS9K0Rt+MFFSuC/gdRpKJxfowDbLv/GhRQedM/dbDuEHvF24Goofrus9JRLHslEd9/4pZkGBWsKW6nzYw21W7pZvAyOCgmE4cdASrT1M1ITs4/0xcn4t8PB975xHMxqUb0xnI4z/72ytVLh6Zre3dkIXz2/vMkuRMUvSxaA9AfsAp5anFtfJJAN+76X3jIcejL+AoBKsau7RHpZ7ylqkdIrwYlwl93bBl+ZuEZoblxC9Ew4mEN/opYPMxHrwfuwTsradxPA1NZzX/p5ZnOTy1e6ZNOElLVgF/8HOjGrahPgL2rJ1Mr4fU74MyZGLkOoxeHkhY2FUCYunOmmLW7iiz/EPyu8iMbKMi8oqv6wgqhcVtp8rwFwWKuF9o8Jh/3jpCVzslup87dsvH3IrzZctvemU97AMPrfTwlggLo6B9oH22e0NSgtHsT5Q6juHj+ZoiAcYPFEyj+E39u0uqnidzFhzBMmJspdUmTkB5upS+eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+ciW/CGkO1pYmQYZJ71OcC6k2SY4OFeFGrScFjeQWiU95EHnlnIVer2Xh31?=
 =?us-ascii?Q?3f24c4PPzCaApjI5Fq3kiDKHkijwvC08fOLzBfrKdFa7BmqviMiq63abENkm?=
 =?us-ascii?Q?rhIbeYD2+waRkQPg2vPQbhgBvdtbmCFZWWCbC9LirIMH5xTtpXT/CspgRslz?=
 =?us-ascii?Q?xDTAhTeWgdwCpZlhdxblp47d1kmPFut4jsC+E2nhPf3LAPX5rmFdaCRDrSVa?=
 =?us-ascii?Q?+hLw0n9qJL6AEcznvBcGudjSxZgrlvt0zQDx/dUDZ+a53+namoOTvIpd/2Kl?=
 =?us-ascii?Q?Lm/KlOVlEgO5ZjCNBrRQCKRyV2bhBzLzM2++2UuHLlbBp4SVQXiqWlSquKKP?=
 =?us-ascii?Q?1bnyljvegEXAywdyefnL16gma0ZUy8gWuFQGAKrer4rAIBshvf1X20Pbc4OU?=
 =?us-ascii?Q?KjKrFwzR8ghAjL4cyQEwzW4lTF9+oM4IjMv3ChVF+YGWXK6EQvUb2ZdjIn9u?=
 =?us-ascii?Q?gkW9K4V8RhLeEQH+Yb3KIPyCnkkHpA0mRoR2IBTd6uY8Jzk2req7JM/lYLXO?=
 =?us-ascii?Q?4x7N3/YDeyf41oSAoRQW36AS8Qjx7Ql4ViKZi5ljIwvEpE1uET5Kd9uDmTWm?=
 =?us-ascii?Q?kIR4xjheLXxsqXHeFQOKSuo2SEJgzooV4DBHSjn2oP+bz2xY1nJCXcU7IZZB?=
 =?us-ascii?Q?rc936Q1wiegqo514iOT5zTP4WphN9xxYWr/yWQB66QLw9C7YlQnfrj+yhBlL?=
 =?us-ascii?Q?QOvq8p/QeKa2cVzgrDJQPqlg2VafPHzPLgO3W1gVDLwgtguh5W32VBkPKXlI?=
 =?us-ascii?Q?YAdlyf0q5dfsTlL4ne9tA9W8EjIY5RKo35pEzghCCAkWEnHTLAedAXOcBDCc?=
 =?us-ascii?Q?tua//sOeSHDoqL4hExuZjmcPV8iEWLz49IrbNdB5v6dWPY+m9ufFUfZ5kece?=
 =?us-ascii?Q?lTtAUyVCKDfG9/X7kRS8zQmc5suNQup1Xqr0S6vgnKqZHZVxGFpxWxCWwlwr?=
 =?us-ascii?Q?ZlaSsG1BRHI3dhkstO4VCAof2VSgkxPF8+YMM2W/N+l/pagado/8xFbKsEZL?=
 =?us-ascii?Q?sVBSTmoz+LBHbkjf5jbLftRyK2r9yCvJhwePBAi3GSm8pIXbWfP+g2qWFB0O?=
 =?us-ascii?Q?RNizMnnJuYGPir40fyfh7igR1DfQzlwupZdEie8rrDXuCX7Hpu9kIf5qqY/W?=
 =?us-ascii?Q?vsrAYC3B0L8VM+TBc30z0TvhnHDZOvItwMQY+H4Qh2SRzMyjI1JuD+mPvHvQ?=
 =?us-ascii?Q?7TyTbezcB5eLegWI+bRVwM0LU1PGaFmjlxj6Xnpu9FBp4Ytnf5BLGkOIvA0z?=
 =?us-ascii?Q?Jy2C18ErgLqhKM9dBDB0QovmYxV4yxDIShVqQM1VZTJCX5XxW6hQDTNeyl63?=
 =?us-ascii?Q?w1s0m1o2iw2Vddj3Z9cm1XogFndUQfny9Gm8tNmwZd3cCxdLcyQHTbxyEdje?=
 =?us-ascii?Q?Y4TOKdqAfttW5yvXsmNPswU76IlaqofbOR3YMHF/YqAgFQdRtfWO2RcMco8M?=
 =?us-ascii?Q?DHAykt8SGA88E0ERzaXB0Jw84LKwhpU7/HxQ/Yk54jUNQitWsV2X19sgtNFd?=
 =?us-ascii?Q?s0bgCZy3McCMF112zKv/sgRAgZD3taXFFxzG8/v1sFfk4XfpdLw0DLHNFnH0?=
 =?us-ascii?Q?CCrxX4QDN+n9LE2byKJt2CTUbPJuATJVKYgX5lYCxuL+GLFV0CQs3XvsQVSu?=
 =?us-ascii?Q?6927reGJJOTWYshkVmR8Bt5TJkOmSxb0awzfgZFbRxUKhwLh+Fmm1XpHohcv?=
 =?us-ascii?Q?a8B+rCvpGE7nTtAFBhQMJVUE+/TGszyBWqtPbzR+iGQ7HwxbmLUrLnnd97e3?=
 =?us-ascii?Q?ccI1EsJixg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c1dd63-12fb-47ac-5207-08dec323debd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:59:56.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzIwtC5I7hFn1g8s6hCrOvSQObkPRqQhUxUstisP8gyyR6c7dh1Rvwfpi3VtSjyQmn8GG7VmJ8K3jh+PBNaCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

On Fri, Jun 05, 2026 at 08:30:55AM +0800, Dave Jiang wrote:
> 
> 
> On 6/4/26 9:16 PM, Richard Cheng wrote:
> > The CXL RAS Header Log is 64 bytes, but CXL_HEADERLOG_SIZE is SZ_512,
> > which is 512 bytes, not 512 bits, so the kernel treats it as 8x times
> > bigger.
> > 
> > header_log_copy() reads 448 bytes of MMIO past the register, and
> > cxl_*_aer_uncorrectable_error() tracepoints memcpy 512 bytes from the
> > 64-byte header log. On the CPER path the source is a heap object, so the
> > copy runs 448 bytes past it and leaks kernel memory into a trace record
> > that userspace can read:
> 
> I think Terry raised the same issue and this [1] is what Dan suggested for the fix as there's rasdaemon (user) impact.
> 
> [1]: https://lore.kernel.org/linux-cxl/6a0e33507e961_1717cc100f6@djbw-dev.notmuch/
> 
> DJ

Hi Dave,

I see, so is he gonna do the fix or I can send a v2 with the suggested approach ?

Best regards,
Richard Cheng.

> 
> > 
> > """
> > [  297.704020] BUG: KASAN: slab-out-of-bounds in trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
> > [  297.704032] Read of size 512 at addr ffff0000dd6ee118 by task bash/3078
> > 
> > [  297.704038] CPU: 116 UID: 0 PID: 3078 Comm: bash Not tainted 7.1.0-rc6+ #1 PREEMPT(full)
> > [  297.704041] Hardware name:  , BIOS buildbrain-gcid-sbios-45660680 Wed May 27 08:27:58 AM UTC 2026
> > [  297.704042] Call trace:
> > [  297.704043]  show_stack+0x24/0x50 (C)
> > [  297.704049]  dump_stack_lvl+0x80/0x140
> > [  297.704053]  print_report+0x100/0x630
> > [  297.704057]  kasan_report+0xb8/0x130
> > [  297.704059]  kasan_check_range+0x15c/0x240
> > [  297.704061]  __asan_memcpy+0x40/0xc8
> > [  297.704064]  trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
> > [  297.704066]  __traceiter_cxl_port_aer_uncorrectable_error+0x90/0x108
> > [  297.704068]  cxl_ras_inject_set+0x278/0x3d0
> > [  297.704070]  simple_attr_write_xsigned.isra.0+0x198/0x298
> > [  297.704074]  simple_attr_write+0x44/0x88
> > [  297.704076]  debugfs_attr_write+0x78/0xd0
> > [  297.704080]  vfs_write+0x1f4/0x960
> > [  297.704083]  ksys_write+0x100/0x220
> > [  297.704085]  __arm64_sys_write+0x78/0xc8
> > [  297.704087]  invoke_syscall.constprop.0+0x150/0x200
> > [  297.704090]  do_el0_svc+0xd0/0x210
> > [  297.704091]  el0_svc+0x44/0x138
> > [  297.704095]  el0t_64_sync_handler+0xc0/0x108
> > [  297.704097]  el0t_64_sync+0x1b8/0x1c0
> > 
> > [  297.704100] Allocated by task 3078:
> > [  297.704102]  kasan_save_stack+0x40/0x80
> > [  297.704104]  kasan_save_track+0x24/0x58
> > [  297.704105]  kasan_save_alloc_info+0x44/0x88
> > [  297.704107]  __kasan_kmalloc+0x108/0x110
> > [  297.704108]  __kmalloc_cache_noprof+0x1bc/0x588
> > [  297.704111]  cxl_ras_inject_set+0xcc/0x3d0
> > [  297.704112]  simple_attr_write_xsigned.isra.0+0x198/0x298
> > [  297.704114]  simple_attr_write+0x44/0x88
> > [  297.704116]  debugfs_attr_write+0x78/0xd0
> > [  297.704117]  vfs_write+0x1f4/0x960
> > [  297.704119]  ksys_write+0x100/0x220
> > [  297.704120]  __arm64_sys_write+0x78/0xc8
> > [  297.704122]  invoke_syscall.constprop.0+0x150/0x200
> > [  297.704123]  do_el0_svc+0xd0/0x210
> > [  297.704124]  el0_svc+0x44/0x138
> > [  297.704125]  el0t_64_sync_handler+0xc0/0x108
> > [  297.704127]  el0t_64_sync+0x1b8/0x1c0
> > 
> > [  297.704129] The buggy address belongs to the object at ffff0000dd6ee100
> >                 which belongs to the cache kmalloc-rnd-09-96 of size 96
> > [  297.704132] The buggy address is located 24 bytes inside of
> >                 allocated 88-byte region [ffff0000dd6ee100, ffff0000dd6ee158)
> > 
> > [  297.704135] The buggy address belongs to the physical page:
> > [  297.704138] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15d6e
> > [  297.704140] flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
> > [  297.704143] page_type: f5(slab)
> > [  297.704147] raw: 017fffc000000000 ffff00008001c1c0 dead000000000100 dead000000000122
> > [  297.704148] raw: 0000000000000000 0000000802000200 00000000f5000000 0000000000000000
> > [  297.704149] page dumped because: kasan: bad access detected
> > 
> > [  297.704150] Memory state around the buggy address:
> > [  297.704151]  ffff0000dd6ee000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  297.704152]  ffff0000dd6ee080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  297.704153] >ffff0000dd6ee100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> > [  297.704154]                                                     ^
> > [  297.704155]  ffff0000dd6ee180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  297.704155]  ffff0000dd6ee200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  297.704156] =================================================================
> > """
> > 
> > Define CXL_HEADERLOG_SIZE as SZ_64. The trace record's header_log field
> > shrinks from 128 to 16 dwords, but only those 16 were ever real data,
> > the rest was always junk.
> > 
> > Fixes: 2f6e9c305127 ("cxl/pci: add tracepoint events for CXL RAS")
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/cxl.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 1297594beaec..f322d7c79ed2 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
> >  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
> >  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> > -#define CXL_HEADERLOG_SIZE SZ_512
> > -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> > +#define CXL_HEADERLOG_SIZE SZ_64
> > +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
> >  
> >  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> >  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> > 
> > base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
> 
