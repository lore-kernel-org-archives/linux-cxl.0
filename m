Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64E1D528
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L704263F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704313108; x=1735849108;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lVIaGe8r2OCs0gSk4HPGk7lbT78hYajjxDjZGMs1aEc=;
  b=L704263Fc2FSYtdBQYlYMbBz/WlodSKqwR6NI/AQcr2O1ngAZdQrtJ1I
   B/BTPH1Q6dLhwr1ema7xQSBCboTYC6yU+GTmE6AXup9PCW8CXK/VNygZe
   6UARo/pqsH8s5KIbC2oXopBHuN3h9yK1PtdbVSbxMFDzaXCSEbb5bL5dV
   2H8SJvVwLOrTaFyYifDtdMCGfnTiaNSIilfrIxMx8w/n1U1SYVTubs0X7
   KSwZGz8Dy7ayzjG2Y2WnTT/Zt6y2y/ZA18Knv96sMcf+3b20Qlbuk3Lna
   5ys+Erf4Az6lCgEE7KnMY2vOF0wwnVZH8JEwEFpEi1yurw2Bl43CCNIj6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4141946"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="4141946"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027170387"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="1027170387"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 12:18:26 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:18:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 12:18:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 12:18:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnpsEy7ZkyIMmv0REw1KSAdUga5d2A8HNhUJ/PGWAXozWoBbabl/qM0oT1Pu1Gnwj5lCZY8dXaj91ck3JwO8AB0teBv0lsMCEdC+rUbh/hmPxw1gKScXvlVQvw5voH+tJ5/ZQpOKSN2hneG9VepJU4vGLtIus/1rmETEB94HWNXvYSr7rTqtDoz2dd7uYC9NNdOpwxp70QtG2yRhcJQ2UORuUgzsdocHobzHY6A6U63VKkklpvoo8ze937cBTE1p+CRCHNRZqdcW7TwJKCoLLj0ntarKDh/Cu4iIVOBUcsqUJhcAdm7uvWY5FLJWpdIQuq0wGDHF2Z0XAq5NxlfBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4Mts+7zudErDhu8AEs9v3ohyWlzA5EkPUgsSeLWaXQ=;
 b=KuKnTh1mz5zWcvX7yqFw4oPPdeDMVV6aBoQpOa9D0DG0AE6j5NZocnYYdxoKVtl+pE8xc2K91dAZt9zZV4z61ScE/4OAsViMy3L7jmaH9ULHwvyhr5d8mh+C3te4NS2KP5nVTcLfEsEtYy2lVWg9ZZuWb7XBsj+8eHpbSRZVFC9j652DPmQu/fmG66lk6Zp0LFnl2+IdqcOMO29HOMwL+jfBWqbhTB/knuNmRyGUhP8GPPmJ25UKCWWNYLqv54Yt/LLodhdVlv7dwXd5zyHwz11QLDzR51rLCmP+FXkOC1L96bcYzcMbPxduFFblMOf6lr0iSkCvw3DfKd9TSlRdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 20:18:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 20:18:20 +0000
Date: Wed, 3 Jan 2024 12:18:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>, <x86@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] x86/numa: Make numa_fill_memblks() @end parameter
 exclusive
Message-ID: <6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102213206.1493733-1-alison.schofield@intel.com>
 <65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZZWsOxhYRAdPNNCv@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZWsOxhYRAdPNNCv@aschofie-mobl2>
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e87f682-cc1f-4b9c-8d77-08dc0c9920d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI5/xca8oZSQXtzIPL6zSWtX6EglQ1DRjAGIYB/cElz8Z3yT1cIpRE3TEPLTcnVv6fwHKE15h2aPhHyGAFq95AQylAivyUkFEEu7mn1VJAZ5eQLqEnGhKhN7QbnmqYPsjn4k3eK/pR4BDD3nHj5LyqpcvaqOge/H5KtZ7OkOQcuUKg3ayFDqK4hG8hUrAxe/Rz0fhsP0eVLxy1lGxlsTbInvkW84azARwGwx3Loy5E0uTRPyHBxud7Oh8q3nH8FLQSx4wmIA0Ih3F1fxmIDUXueko9aqa5wRgyIh0pOwm+3GHB2qxIe0yD9mvEll44vscqmg17giL6j7YRMn6jwVS+lVkdXhRm8GofwopsWu/NGJtZKSsZZN49G9WxW1YzuCXIvsBnXmho0mD3ilNeEysbZ3fcCqVcLGerLKU6P89dwnyJu3eYWTGf5XO32H4t9+mQLqHbAcceec0z7ALFeKqdFu/PAXjOHFpNzh3986v24ck+Ec1x60PyTy3x+SZ6wr1aYseHd6/SD8clK8caJs4d+BSaUNGJzjQVPza7suVqJ0TOSLbAPYl7I/rVoV6gqQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6512007)(9686003)(6666004)(6506007)(26005)(82960400001)(38100700002)(86362001)(41300700001)(8936002)(4326008)(83380400001)(110136005)(7416002)(2906002)(5660300002)(8676002)(66476007)(66946007)(66556008)(478600001)(6486002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycB9/0JlCJV1LocyfMOkg1gumQVV5mSha98GioOmAMOXKbgopDjgds3FYJjP?=
 =?us-ascii?Q?ukjo8N1gEqzY1LJI+FJjTcBpJb5OoYTvIYZNQNUCkQ4kTR07TzA9/TbG8iDa?=
 =?us-ascii?Q?BkeVxC+wFVlPGKgqXgilD9mlZsQ1Ma0ruO2n34Qtg9fhgwXGL8AQv1y3xUrM?=
 =?us-ascii?Q?xuo3eMgsc6pmVxFqXfbguNa0+PY2nBjTrsv7Y+BeaGiwDXD0CrB5Mv64SrRn?=
 =?us-ascii?Q?2jcvmRaxiRFX2TdgsOscS5ARCRi9bLy+Sixh9tkau0RpptPGWHly7qJ75Dut?=
 =?us-ascii?Q?4HgUSbV+A7D422x+aV/Wrcfv+jXbSM9YqFBR7zY/hQjJCR/kAL3IRaLY34+h?=
 =?us-ascii?Q?zJzevDfiZjixVnVcPL4vYPexeaUqjUbmGE9YTgq03CQOwFNV4qAvN2pQEya2?=
 =?us-ascii?Q?EFInGzv9/SvoIIn/yWMYYveDtKfdxddcE/ybCcgMJtwogN00YvWW849vTgQX?=
 =?us-ascii?Q?hkjg4ZhAXeA+TUwGzUk0w0aKXuyU8/YQswffYxxb1F4FkZGmNAOC+vEZrkjW?=
 =?us-ascii?Q?mAVqTEKXGEXz+4MNuBqxfS2t9d0YkYSEFTrKqETOTQl5xpICoNNppRvN7YJA?=
 =?us-ascii?Q?dxbNjrv3p562xoukB9L+L68b/A2Q6WzZrZGnxPTmvj5MYtbIsweJYWf4OJyx?=
 =?us-ascii?Q?Lr+c8pAjmz1JGcbmpeyl8BkGWkT2+aAw2MnZN5xGjzypxkwpfwkqNi8MblUs?=
 =?us-ascii?Q?mTiw47S1PIuxk+JSNWTIz3z9tx6erQYwIsKvf2tSM0Le5zprxQDspTrGFC9O?=
 =?us-ascii?Q?yhw+3acf3g3lypgRyvjTwbm7yNNTIhNdWTYI9oDKIYtl6hX6LCyx2Wz9QOiX?=
 =?us-ascii?Q?55jS9CwX0k2t7Arn+wLG96bXzUbgNuS2rReX9bC/MVI29GyU4M+is/wX5I+h?=
 =?us-ascii?Q?hvgbm2yZcUlpVj1m/O5QH8gXfeJ8AAv4RqzFEMZLN3wacZCIr2pzGZM+0cX1?=
 =?us-ascii?Q?ddfqRjUlMLJwiC8bGFn0714wUUYKhdosKNjxF2FHqqkbPbGBkPhK5jKMxUXF?=
 =?us-ascii?Q?Nbt3CyG2UYyYliQwVA+zXYsL2AY/TctkiZSEJGMrCKA47Cu/L6fRbUbGvR20?=
 =?us-ascii?Q?TTN/qfFnfREmVtXSk029Xf7+CZOvoPHgCzM8/MO4DeGWN0AsKu74gtPrQdLY?=
 =?us-ascii?Q?YpvVbf+fgYV6Ad/yzqeXkjRrJgJRF04mf8dE9O37EeLGaby+ojYNKJ8WJYa2?=
 =?us-ascii?Q?Y2Ls0w/gk2kukQ/vQ+DUYSkR8+yxBlPwOfH4vH/traQ4e/0I8MM7mMpE4r6t?=
 =?us-ascii?Q?FdBIrXzFACTRKyke96+RTn2v7meQkac/YTVRQZ6CWvBwTnHISLvWX/2CJuf3?=
 =?us-ascii?Q?u67cGknYMUfCN9nRaal0vMBZLT/GKeANEEVaw/Obk9bfbAF+Z1qoM1i9ykum?=
 =?us-ascii?Q?rir7Wu67jHdDJxmx9LC7qpyFVOJV025TcfTDPdPx74pRdvQocfUiCQxewqxU?=
 =?us-ascii?Q?vYoORLrpDeg3bpJC8tKEsd6XfLy1xHHmW9k4WWdFRkJw+pJ6hILrh2dbXSSk?=
 =?us-ascii?Q?sA/asNU8AHk8hNE4fX3UMkxfTOKLVT0hQKCq+MWXrhc/YM/phjUGNkUSFn0e?=
 =?us-ascii?Q?vXeDX9EGnhQ9QWfnWr3ViwO3UayABen2fAamFaqOX/bWuaDp5jT12sMAPpGO?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e87f682-cc1f-4b9c-8d77-08dc0c9920d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 20:18:20.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef8rm54zcvfkS7uYTuTovV53V7gSqEzgGpGSKZxs9UtihpNwjz/oVks/jdbcPuSV1lAQPXzKos1vviHIyPAChVyLb1s2VyqwcpVhgKMX5jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Tue, Jan 02, 2024 at 03:42:50PM -0800, Dan Williams wrote:
> > 
> > So I realize I asked for the minimal fix before a wider cleanup to
> > 'struct numa_memblk' to use 'struct range', but I want to see some of
> > that cleanup now. How about the below (only compile-tested) to at least
> > convert numa_fill_memblks(), since it is new, and then circle back
> > sometime later to move 'struct numa_memblk' to embed a 'struct range'
> > directly? I.e. save touching legacy code for later, but fix the bug in
> > the new code with some modernization. This also documents that
> > numa_add_memblk() expects an inclusive argument.
> > 
> > Note that this would be 3 patches, the minimal logic fix as you have it
> > without the comment changes since they become moot later, the
> > introduction of range_overlaps() with namespace conflict fixup with the
> > btrfs version, and using range_overlaps() to cleanup numa_fill_memblks()
> 
> Hi Dan,
> 
> Your idea to use struct range in struct numa_memblk comes as tremendous
> relief after staring at open coded usage of start/end in numa_memblk.
> 
> With that acknowledged, the minimal fix to the overlap issue could be
> either in x86 or acpi.

I don't see how it could be in acpi since there are currently
conflicting {in,ex}clusive usages of @end numa_fill_memblk(), right?

I.e.:
...
start < bi->end && end >= bi->start)
...
blk[count - 1]->end = max(blk[count - 1]->end, end);

> We're at x86 because we wanted to be 'like'
> numa_add_memblks(). A partial cleanup now makes numa_fill_memblks()
> diverge further.

Yes, but numa_add_memblks() parity is not necessarily a virtue, however
memblock (with an 'o') parity might be, see below:

>  And, to avoid the partial cleanup from being throw-away work, it
>  seems we'd want to define the full cleanup ahead of time.

Are you referring to throwing away this cleanup work for the eventual
memblock conversion, then yes, I agree, if this is just talking about
the numa_memblk with 'struct range' conversion, then I disagree.

> Also recall that we have a bigger hope of replacing this whole
> numa memblk usage with the "Memblock" (with an 'o') API.

2 wrinkles here...

1/ From a practical standpoint is anyone actively working on this? I
   would definitely stand down from the numa_memblk conversion in favor of
   memblock, but it has been years since this idea was floated, and I doubt
   it shows up anytime soon. However, "be more like memblock" is a good
   idea.

2/ memblock appears to be doing inclusive range math, which shoots holes
   in my position that numa_add_memblk() is an anti-pattern that merits
   conversion. I.e. "be more like memblock" contra-indicates a 'struct
   range' conversion.

> Maybe I need clarification on what you are suggesting wrt 3 patches?
> Are you saying you would not merge the minimal fix unless the partial
> clean up patches are included in the same set?

I think your memblock observation points to a third way. Lets uplevel
and steal memblock_addrs_overlap() and use it for this broken
comparison. That nods to an eventual full memblock conversion and keeps
the inclusive math status quo in memblock and numa_memblk related code.

> Also, is this something that has to be merged through x86 or might
> you be able to take it though cxl tree? Yes, that's me worrying 
> about the review and intake burden this puts on x86.

I can always merge things through cxl.git with an x86 Acked-by, or a
"holler if you don't want this to go through cxl.git" approach. Lets
keep maintainer busy-ness concerns separate from where the best long
term place for the changes to land.
