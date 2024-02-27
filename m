Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2098.outbound.protection.outlook.com [40.107.212.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17FC54BC7
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018916; cv=fail; b=gCQ+ufRjUahp5amCG5MQz5SJpkYgHn42xOUl4hZbvcc6no+53BsUeZYoEZ9wUUufIONfYr+HU29yDajy3DS/4weMHRcs7mgT/0ARq3X0E/7Rr/omYfg297/JGptcYY7nB6rADujpsxzVlsLflbwQMsylm2F8IZDHzV44bk9v8gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018916; c=relaxed/simple;
	bh=cyfaitpjLrgDXbBEW0Dc441l9BqRe2ohAAOpmtU5OvY=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WUTa2gFyv9k1XMRQy2C114mKmyen8Mv+bC29EhnGoo8hOPMHNsSlzACeRObwPjZ2/AIoI4Uuoz04YEl1s70AAG1DGT0+cjWJiXq8BBZfLxgdntM40LDFtPXdeqyO+isMuB1G6MHZZoHTChDUKGubT+vILm9vkUTJyJBgNcdqsQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=p9Yopabl; arc=fail smtp.client-ip=40.107.212.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="p9Yopabl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6DmF+vyljyVyUujJTLVxYhaVAN0eMdJSeeZ8cKLcS5zHz9qSwieEyOnY6m/hLzEzWqIyQlefD4VCFxqDt/XtdA67zoTg1dMQ0pmFRWp+31Px7W6Apr5+/gJonu4noV2sCU40Lo48mc/JIS3sDrIHWrLrDoVqNgZQ8loiW0G8CLdxIvO5YwE1Zndux+h8yw7MIfMliRzoj7nNaaexHNQB1aN/4s4iX1MX06ahx0JlXozkeRJ5ogAkBOLDxhlNYqGwYi+FnLHwmBcLfVpfJrowRbC7wZ23bMWMttvwcaVHbFk9OuYPY/cuGqf5VPClVbzjBXbosDY38fdgdU9qidijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3EKvR3EY4ag1QXHCNQFmihqyF9hQLigpceIVgWwuXM=;
 b=K+OWkD12WZUX75hLoNaOnpg/zBoNeuTt9iji/km4snI8RspRbXp/hYGE1NX6yxB+G5qcsMt/5AKQsXSy0/Zh6qob+2mlo+/RBkZBH5L4a6N3cNyDYX/tUd6hPyojPMAnv7rCiioztzkJqgD1IXPHjc59iRe47MBHafIKhKjgbmSRZ7gOpOYYuTO3mrTXNdJpxfZ3Mtszgmitt0G1BWkBIuLE7GkWmk3Pi64+3OSatxGM41iBCdRXxi6r7KZ1pdLza4hj4XvTyipunAlW18Q1Tv5pO58IxdwYFj1Fvp1XVGpVEJbl6dajJY7SQtI1f5VvOocuZx0/f027/xjohswLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3EKvR3EY4ag1QXHCNQFmihqyF9hQLigpceIVgWwuXM=;
 b=p9Yopabl6NV+15fsC3nbavtxTfx4hskttWL6ekYZFSsQQuVNfkLb0BeJQj0UUoYUJKNxdzMM5skucWXuTagcgRN1GwDQoqVNJEg4rK0Ad1dMR48Fsm5/wu/L4JkqcBziIOVR8lPzI90kLQTExbzoXO/pMgqaTUFF4v/8lB35O60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH2PR17MB4069.namprd17.prod.outlook.com (2603:10b6:610:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 07:28:30 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468%6]) with mapi id 15.20.7316.023; Tue, 27 Feb 2024
 07:28:30 +0000
Date: Tue, 27 Feb 2024 02:28:21 -0500
From: Gregory Price <gregory.price@memverge.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, dan.j.williams@intel.com, ying.huang@intel.com,
	linux-cxl@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] mm/mempolicy extentions for heterogeneous memory
 systems
Message-ID: <Zd2PFXSzYuMMxiQj@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR19CA0053.namprd19.prod.outlook.com
 (2603:10b6:208:19b::30) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH2PR17MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccd4564-a710-491f-c4dc-08dc3765b200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r+78m922iBMNXoKUbH4RzsClJJlDKHelqVdPlZ+SMuSKJQ+GUPdm7OJBFiNCEOg62Zgd6Q/D5n2ogmoqJlHzl6/tFyUP97KyO2vm3zzoeiF7bdU1ilpy1hxNwKQ7VtxYm+jQzUJ/qrljZiuNn4Eso5JT+oDc9ntwu2h/dqTvM8U9O4k0u8FkuFUm17PxWjUuMfFIqOg5+TKvknx3+utda7A68W4GtT/3NqTkx5UMtB20+tBIE4/Dnxvix0rPGxgGwOTsQalK70KZAOqh3gAbjYoYPT+ri1VWOwqAEGaDm/3LQPxfCeOGtsq6sm7vGggDbr0OMuWUXAc3ihtNZ0Yhm6zJgnNJ5u3SjQhAUwXQZeSVOx7f40D0j5+/EvVxh7I69iN+cS3dBP5DzilyK/LM+W+Mu8FDqvCfw2RSOSTiBNGmcZ17zoVQrJY1sRwNuGM2yOA7PkcQtGKbniO8KwzMIG0K5iPx9+6rg1nMX/mxaBvumDJCU50PUa/Q/w8g5maywv1UL9EZF72RWESxPVyXy+eoD2Lpvt8Q5z4l3MP6ck18dfhqZtF69nPHu6QHZrHOtEE9fQM1kmLRmCpOJN7LYEOu7v+bZj29hcbPsQdICo7zaMG3QcFrp50y75dZ32+07H5fXNvILKPWd4AHLd5tZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3j02vRqdiQUjMavU36tBtT/2g1KAQ3xu7KJqu95RO3Hy7IeBwoQLp3AxC2+?=
 =?us-ascii?Q?Yg/oSVll8MbBsxfhFveYalIsdj9Fr3owshPdImmBhcolKWIOHstc/X7K+BPA?=
 =?us-ascii?Q?9Q5cbkm3ZXgWqlZoBQOZ0N4ZepNsddOt9qPWs4fBBg/eOKdwxOwqIxvcrUPV?=
 =?us-ascii?Q?vJbtkCPI4ZPcb3VpoFE8MzKDz61sPYNcIm9IGp5KsdSS0dyaYow3bj/1ZO7E?=
 =?us-ascii?Q?383ApLfUCgJG7asJMyXcO9tbU7I0F3s7zFRlgIUsGfCkownOamGHQ7b4Dxzo?=
 =?us-ascii?Q?QFvjsSL/LG+f0C3es7xxINfxwXpULXv0Q3gV5HcTuDJI2b+9G7R008Dkaafi?=
 =?us-ascii?Q?v+l4cbGVc086swvT6hAzSjMYN/c0e9ElkXlGqa1MmkMm9J20IWcFnMommOEm?=
 =?us-ascii?Q?Pyl8QwoVgCrjawnrHLGwvWFpnS4TTceu+zoY69A708J5t7vgtjyXzx2Q4oNm?=
 =?us-ascii?Q?8LPgQDIvzxJgWQ8K0s8LveDHVy3CbjbDaULlc9cwuxvRign8qPIvwAYvxuQs?=
 =?us-ascii?Q?IDOh9beNqXxRgIZiv9v+55AhaxH4cgvU9Z1FshvQk8MuEP5XTTVSaSwhFqr+?=
 =?us-ascii?Q?dHxs9xDi4m2CNDplhYDadjIAM94T7GVNt6woOdnoLYTUUY2YUthzNJyt+UsE?=
 =?us-ascii?Q?Bm4xD0io7ARpxr5HXqhnUp+KykHODI3+1oKVPvVtxMGPttoh/bF+0Hq1krUJ?=
 =?us-ascii?Q?qShW2N3kbD7tr5rHhRT2+fOzwzSUhcZ3XTuW5cmnGs/mqfY3WDMjDiJvpG6F?=
 =?us-ascii?Q?+xFGBb7uei1puNCQ97zwL7QjBlV7JmTk8MDCX8wWGHzVzi7ViIXRV8/BoaXG?=
 =?us-ascii?Q?6b4ODLmTNdUfsfJM00BMk7OwS0P1bgPbsze8+3ul4RKYF9e3T5t/15r9uuJ3?=
 =?us-ascii?Q?ZUds7f88ugWBPnS43G//F7UyRrhZkHbMq95kG8MkCqOzQ7uOP2e9wRgJr21z?=
 =?us-ascii?Q?ctp4cFbYXYdUrM0Mx5UQg4SWE5v2NfoJn554ztIv3v03Uk4HRW9fp237ZzK7?=
 =?us-ascii?Q?+rE809Ax3WmgCdIv9it5FRKSz/PzfEy4Iu+5FAiKZZNY6jEKbqSr26wxPL33?=
 =?us-ascii?Q?o8gJQXE0A1+sj4GlvcwKNS40vx+YP2kXEcdgd57+4MmRG0epYxvUgzRo1WBQ?=
 =?us-ascii?Q?6RNTqpPb88mYsFqpL6q79xTgMoME6T/F+cp8ZnxeKASpMF3BP05DG6TTZNeJ?=
 =?us-ascii?Q?r/7zXdw3bTmhydJ9qIdWasizfig387ZWZZSSDG5lERDOe1TgOhM9aqqCiVgP?=
 =?us-ascii?Q?K+XI0Ka8p2jwnEGpjSeDF640P8YrgmgsRnkmf0riLtfU603fcGiYl3mPZ7RU?=
 =?us-ascii?Q?lPJyVBnmNQ7tx8PZkCufQ8Q3UwNNR+XsNjiMS6pVz2/Ww/QrmNcMnPFwYkBa?=
 =?us-ascii?Q?sr2Rkn/JQncFNdIixAGZ3mDEAmy0as6bFZFDy8vXEr2VJQTas82eh+6pcKcL?=
 =?us-ascii?Q?uEBN/l5hs5ghT4NRrV1Sd6uFyF9lW6oSpexqSbCFSDrLAQZJWgCzOdHjViNo?=
 =?us-ascii?Q?TTOTX11wT5+cwR8V2Srx5oS8IUQ5WPa2RvvHTDC8QlarTtBMeMY6AyAlNd0M?=
 =?us-ascii?Q?kY9BEjWaKPXgFnwF0AK9GGOoxO36McAhQRwGRRD+LnLNV6+Fjes+2m9T3fgx?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccd4564-a710-491f-c4dc-08dc3765b200
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:28:29.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxtjkKpzwzmCMJcHBqSuGcGyZXlOSiXE6FqgALCu6Nv+P+kpIGYHIrNOZoV3jz0pJqjnCFmN7tAK4WQ+i2MrpquiaZUdpYHikwXoyOdCrmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB4069

Commodity heterogeneous memory systems are emerging as CXL memory
devices approach general availability.  With it, a number of
proposals have been made to extend the mm/mempolicy component to
better manage these disparate resources.

Below are a collection of topics that have been discussed with
some level of seriousness on-list, at-conference, or in passing.

Some have reference patches, others are half-baked.  Most bring
up interesting implications of heterogeneous memory systems and
opportunities to improve performance (or royally mess it up!
It's a choose your own adventure!)

I'd like to propose a discussion of the environment, some of
the issues surrounding each problems, and a general call for
new ideas - considering that the heterogeneous memory world
is still evolving.

Sub-Topics:
===
Weighted Interleave Mempolicy

This policy allows N:M interleave ratios between two or more nodes
which allows better utilization of overall bandwidth.

Right now the continued discussion is about how to generate
default values for this system, and whether/how much topology
information should be passed down into mempolicy.

Prior versions of this patch set also included proposals for
task-local interleave weights, which would necessitate the
introduction of set_mempolicy2/mbind2.  These were dropped
until an explicit use-case emerged.

https://lore.kernel.org/all/20240202170238.90004-1-gregory.price@memverge.com/
https://lore.kernel.org/all/20240220202529.2365-2-gregory.price@memverge.com/

====
process_mbind system call

The basic ideas is to allow an external process the ability
to modify the mempolicy of a VMA owned by another task via
a pidfd-esque syscall.

The current issue with this feature is the `current-centric`
nature of the mempolicy component and difficulty refactoring
mempolicy to make this possible.

Progress on this feature has stumbled, but there is still some
quiet chittering about this idea in some corners.

https://lore.kernel.org/linux-mm/20221010094842.4123037-1-hezhongkun.hzk@bytedance.com/
https://lore.kernel.org/all/ZV5zGROLefrsEcHJ@r13-u19.micron.com/

===
Allowing migrate-on-mbind to apply interleave on new node set

As of today, when mbind'ing a memory region using an interleave
policy, migrations are only made on a per-node granularity.

For example if you mbind() a VMA which has already allocated
100% of its pages on node 1, an attempt to apply an interleave
on nodes 1&2 - no migrations will occur.  Migrations only occur
if a node which was present previously is no longer present.

There has been some discussion (though no patches, yet) about
whether it is feasible to extend migrations to support
"re-interleaving" a VMA given the new mempolicy.

Combined with something like process_mbind, this would be used
to rebalance memory - although it could be incredibly disruptive
to the performance of the software being rebound.

===
Cgroups (or cgroups-like?) extension for mempolicy

This comes up in just about every conversation I have been
privy to with mempolicy.  "Why doesn't cgroups allow you to
apply a mempolicy which applies to all tasks in the cgroup?"

Typical answers:
- What does that look like hierarchically?
- Does inheritance even make sense here?
- Is that a memcg thing or its own new cgroups component?
- Cgroups is not for that.

The use case is somewhat straight forward. Users wish to be
able to apply a mempolicy to a set of tasks in a cgroup, and
have migrated tasks inherit the new cgroup's policy.

Is there any way forward on a feature like this, cgroups or
otherwise? It does seem legimiately useful.

===
Flexibility on how policies apply to VMAs within a task

One of the frustrations with mempolicy is that you operate
either on a task-wide level, or on a per-vma level.  This
means that you either apply a given policy to all VMAs, or
software must become "numa-aware" enough to apply individual
policies to individual VMAs.

Is something more flexible possible?

For example:

Is it possible to have a policy that applies only to all anonymous
memory regions?

Is it possible to explicitly avoid stack and executable regions
when deciding whether to invoke task-mempolicy logic?

These are big, non-trivial questions.  Here is a single datum to help
explain the significance:

Stream Benchmark w/ weighted interleave
(vs DRAM, 1 Socket + 1 CXL Device)
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
Targeted weights   : +2.5% to +4% (consistently better than DRAM)

In the 'targeted weights' scenario, the benchmark was made
numa-aware enough to mbind its bandwidth-driving memory regions
with a weighted-interleave policy.  However, we can see when
using task-mempolicy, the outcomes were more varied.

The question is whether it might be possible to make the targeted
scenario more accessible from the global interface by avoiding
obvious pitfalls (like placing code pages on far memory).

Of course this can only go so far. If a mutex in anonymous memory
ends up on a node 3 hops away... well, you're going to be a sad
puppy.  However, it's clear there are at least some scenarios
where this slightly more granual control could be useful.

===

Are you interested in these topics? Have a topic to add?
Think numa should die in a fire? Fair game, fire away.

Kind Regards,
~Gregory Price
