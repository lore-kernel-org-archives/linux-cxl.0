Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B047DD42
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764532; cv=fail; b=OwCu6hrD9as09bCh218f6oaF7Jylsn6HBs2S2ZjuzlxdfFC14Pj3Emwpq5VhYRet3LTmagzrOsrKSk+dU8jkLcMJVZjnAbg+xXaZcXd9WgHvSj6iiRq26GFkIyF7mDgZeQID/5J93O0D4TTATo4PgpSG8jluMPfjNpLiOx2ZL98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764532; c=relaxed/simple;
	bh=7hxot8ZUIJXrelgcSSZOl5AKeMNvbEANU1eanpAVQKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aU/O9d67PlNDhX08hgM4g0X4m/uJQV0786RmXsDccUJ6OJ2rHAqh1O7lIbml9hotOKKwFzRXAw+tIEsi1MCu4d2r9qo47bP6JFTFpjLWW1OvogzHnxyVc416/vBRcXt/dUljh6BNS1lhQwk/3bXRSZ2C3nWagH2mx32P9VUHGjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtml8MF2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtml8MF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789764530; x=1821300530;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7hxot8ZUIJXrelgcSSZOl5AKeMNvbEANU1eanpAVQKs=;
  b=gtml8MF2pHaT/e92qdkJ6qf30IS2D6LU/rKrV1CfxuAltdLDOKzlxsg1
   lIoEtaN1snTG14YHOyDfGlbISxrD+1o0GUv/CRB9UMXr4Hu1VgqMxV4u8
   rse6am7jv04afOgi86jsxn46qQMpvHyq1xv+zixAc/KwRwjsHwFjT6qWd
   RwvFggCQHQid6It/sN3p7/pu+X3eP8l9dYL8BKIPtPQUUE3gx8GV8H3uF
   WSxQcroM5EUNcsIot8HHJnEpf8rEf00SUy7PXf0v8YCCCZeHiJU8AO4Bi
   m4cUd3engzletM6pswOQ0FLsz/XSkGkwQZreEtr1+rGQKChYwqOStQ0AG
   g==;
X-CSE-ConnectionGUID: R5lwAptKSbahifYate6GEg==
X-CSE-MsgGUID: XQ82WxJKRPSN06pEPxBxsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="115828643"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115828643"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:48:49 -0700
X-CSE-ConnectionGUID: P19TpL82T6iC/g8FReQjCA==
X-CSE-MsgGUID: SARMRJ2jSnK31OhdhaUIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2811138"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:48:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 13:48:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 13:48:48 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 13:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qD1NvF6W1xyr1hSCGaJfiDFQrSty6d70jD3SKgxfn4H8OyoW4D7ufsMsVU/c8zG/6tlR9SJQLEsfK/pVkZNP28zZfPL+utzDNpO64cCxb0IlYnI6BAWILUXC02ta5qxaMIXhhkOIFu7XLtgRXqkmToCg9TcSaIFi6Q4bLNR4fZNhApb/rH9pOu1FL+L4sQS2Ma2gfMCnrCcsgmFzzZGGQRQEeyJC9oXKjg8uybimwGT5EozLYst8S2yqyQfB5tNRR9WFmzpma3x8vsix+qa36f83QnUv9I1RBWl4/rmijteLAYrOZkPuG+G1R1GDri1WkGgvhxkBL3VkuPRFhHeikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKniFJwrnXFN1CQtrf2cooAJ+Lgjg01ZvkXG+zkFGh4=;
 b=eMT/UhbZ6co+NK/Z4iE1NrAvqN3zAq99vu5sjMQyowbvcV+/qyMmWMrVa85HHNR3NU29uEznByPoDPCj/lX3PG1u+o/dQBvJ56uj5/CexG+XCXbyIyPFtMtzarjruMdl5J4bWSeBSt8oiK3ajZzMk6GVxfKvOVtKWtESbWn+Qn0BjET1cZj3esVQUuN/musGJoIWE7aXfODL2q/LzlAvCK1xvhSU+aw/n75JXXkgrECWlCrlWEX2xBcuUkKw2LL8thXgIteJEQfeC9rncXQdM+huOGs+OhZTNJX4Re/9HtUy7EIz8Jys0hMLFv0w1ylBTgIY1htT2V6p569YzvkjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFD56C4208E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::858) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 20:48:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 20:48:44 +0000
Date: Fri, 18 Sep 2026 13:48:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 1/7] Documentation/cxl: Describe mixed-granularity
 regions
Message-ID: <aq2jjiXfDKo0SwwQ@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <5da4008cde30c04284f5780aadac49e91ae511c1.1788475206.git.alison.schofield@intel.com>
 <aqqCpDux1vOwKugi@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqqCpDux1vOwKugi@rric.localdomain>
X-ClientProxiedBy: SJ2P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFD56C4208E:EE_
X-MS-Office365-Filtering-Correlation-Id: 62972202-a242-4b82-c30a-08df15c63a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|5023799004|4143699003|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7rHXYxq4Ul0RS3KoVO4R3cLMotD/+wc6e0Ujt56W2TEf05MaEamPvArnjppjzVVoUKOBLVh5Iw+ZxsfynIpXNoKrd/7F1/b2HaMAtIj7F5TYfhYWJfGUfPC+FDQWv632SJl1bARjmuF4XMoi71bKpKRvPGbNsY4I1CsYjd4hZsEVUn5d5ATqI6ow30UnfmabtSqDCp+odxTzH83jdF6anK+j0weD6SCrKmfc5AjEoTCWSJ+Yt7zE/MrP1fb5tLb2lK1IqrCaALgG3XQDIpZi4l7g3tQecr6XtcFTwev4R8symKzCsXAqd7Sg3hTitjhbhg24OUq2kIiZHIqe/GzL/Z40CRYm3b9YzHNRiGLsHa4moyG+2KaRpQN7wAssLhHAOLxnVQqKzc0QH2Z3pJTfjSHaGKepD5C1KXjmqDXTI22Vcyn6/YfJ6MUSNOXHIkm4MD6kiB+cc3ERJGkBkUmUupSHJrLmT5YTz5pCgxcQZu0tMTefoDQ33LPP3xho/78s4Wnn4zktJho5c3SGvOZzKqdyaLEOIQdzuMhm4MpJRe7YbWf52pbP1hT7/RmpBEOjhODh2jmKUMYkynoLfzRUkywwFC6/c7f7R5ouaqYnh90S/i/SHFSKC2MSYYpxluasKcsRK3nUh5eL4E856AlBZ6zl0zbefzg1Bk9QWUyWu+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(5023799004)(4143699003)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kke/kqoIka4gfa7GZOTJBeSwNF1Ij1XyalhSCWRJg9AEORrboldsPVf2Z/lW?=
 =?us-ascii?Q?6OlMgJlWh9nAUsS6/6CfLDjPQXTrNaw/igpMFVPSbrOLP2zW9PLTAxlzhMJM?=
 =?us-ascii?Q?AUibzl8eXIa8kuSvgUXJrCwRsprK4KzpuvjV/Pbiz6hGN21XcGgSAkdD4Fa5?=
 =?us-ascii?Q?7IrZpOl6Bc288KiK1qO362FLbVvNf3a94knQvzdfB0POkXb8Hc05fPXnIE6s?=
 =?us-ascii?Q?J1sDksX5WON7I2CQX6c2tkIC6toSDh7pOdP0vXySvKFccasWOw4zMg8/E+H2?=
 =?us-ascii?Q?wyGMbMwbeeQzTYjxdMGb6qWzz2pSDjaQ4BMtQ1YQREtT4LXzFXahrAy/bpNT?=
 =?us-ascii?Q?+wVvWFdRn7NsHuQfFMt9ipviHGvyywLpfo97QCbXQifwfAAUEaxuUNkGGbxP?=
 =?us-ascii?Q?VsqAusM+eEDDnZ80P7qlsAUd6BZVFPcyWdti/8jG9DNO7ULTnKjihGbUt9bT?=
 =?us-ascii?Q?XY2gcZnfLqcRkHU2l1rYiXh8jUTwvLcGBvZN9G3VRSGRiihHI/QXfCnqGmeT?=
 =?us-ascii?Q?kB7UyxPpVK8UwKRBRj9uGse4dkj4qrD2y9vhco931jcN4O3/lsfbZrXIqW9k?=
 =?us-ascii?Q?rqQrtyzbWt4Ds/sEcYV9BPRCIY7jvLOMy6jtMNfmFS3lUCN2L0acgi2e6bii?=
 =?us-ascii?Q?P2rOV5wzx1KhfQkXS1bqxsddMok2/TLWWlRsJBx9VhTjn7Fg0xt9omBvt/0J?=
 =?us-ascii?Q?2BOIwdGLYwBdXwNwmbNUg1Ijh3omtRprzGhl5EmMTYXSJPot1qFVU0NSCrL2?=
 =?us-ascii?Q?zjUi5G6StIIawSPOaqEL9k+Y0qP1L7UqRYx67QJcIKe8/wDWx4QKPGtCxPaV?=
 =?us-ascii?Q?cMTUj+NIVxf3r1FsOJKsLQLQxfRO3IIgBxc1/9QLPALmaUXAxysofFDfs0eM?=
 =?us-ascii?Q?M1Iiv0la+J7z6CbwJCeWab+2TCfs+y6LfXzBwuPvBe69+tJh76kJd0UaRbKx?=
 =?us-ascii?Q?5eePPk1cZRhHWeYmk9mVJhtHOnBtLMyTCeLQhCbmlHaeaJphrj9y8ANSuA+y?=
 =?us-ascii?Q?poyHAYcAQXXQOaMuhBh0i0KUmolC2mkTnDZ3q2J9ODUDVnP5lxI11w5Ux0bs?=
 =?us-ascii?Q?7IvylmTWcE35muAlHVCMI8JZyOJ1lv3kCOTUXRkHXEvA4a9rqI8npQzUSjon?=
 =?us-ascii?Q?XjDk0yTJHMn6bkBic/b3+SvWDP4tpVVNwrXpdgoNeCffc3Av774J4wUhvEYf?=
 =?us-ascii?Q?xefF8KIfgAKmMqPkBSB4lNsly2Yf0oca9DbOmVa713tyhJ+h8aQTcDdTNGhw?=
 =?us-ascii?Q?QPku+7eDAf3MPNgUM1Z56ORNldECECeBDF7idX939hvEtGMkopZVf/7Dk3iD?=
 =?us-ascii?Q?7eS88iILw4YopaOa5w2Hwo94/zAFJM0gTf9y/ow2CYHk5l+0C1FBugDCWSbI?=
 =?us-ascii?Q?vpD50qPGyAi/5Q8vpvLwG1GTJeTnAqP4qSaUqlmd9K4RTZG1Fdv0rAYo0Eee?=
 =?us-ascii?Q?mpD3v6CQ2kGzOZaz0fQsz3cGtgLHekvyFNF62RIW1Onh+aOtjLI2aWpGVJrR?=
 =?us-ascii?Q?PQE1RSeaIkDEcCrV81m85YyrpfiRr/m1LdhtEINUbNULN1t6+MQjG3ymDVDf?=
 =?us-ascii?Q?DUrm0CS24NCBEsSVar5QG7hopD+BDGdjG8Vh5w/Qw9EW9WP0638ALJmaS43/?=
 =?us-ascii?Q?Kvn3HdVIiIPAc/uakNAInUjAsPvmdNuAl8lxs3StOYBCtwmpOrqXTJEj7hiQ?=
 =?us-ascii?Q?C/rCuXHA6C2DOXdfyHTlNrCT5UEaaTUK82xkSUHwMvmc8X30ejv3ttnnYp1V?=
 =?us-ascii?Q?RIP08Yoi97BQcU6Bl1zuougQDcs2074=3D?=
X-Exchange-RoutingPolicyChecked: tdFdqj3T8Q9DmbRWl8w8fqagmZfDq2rPfFDhsjaPCZEEZFZi3jJZJSa1nlVfYLs7Rv9iO0861bpv2LTgkUIIjcWSfdTOZyZVhrRGp6+w5nI1zzFr8lNeMjQzPXc0TPMq/zHZHChbtO+ARp6BV2jq9eTMN1MAX7/o87iyMbFmvPH8tAoNmI3C9wvjEY0+hpnZpaO004ey3ivFoX7Y2aWuhHtGRev192sXgLK6H1gY7QKRFlaet2r9O9g/HmTwv08W2y0dsHq4m3W62i3UDlrsjqse0IFERrYuRUthtMKXtyBo4XEtu9rgK36J7wVwiODQ8nZ+a4y3zZw2EAu/l41QLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62972202-a242-4b82-c30a-08df15c63a67
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 20:48:43.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6Vy9nJX5Znd9Ij5PVyrcu4bbSJdXVhJe+OSzCrOqQBUqcjz8Kj0byefOI4ZgTVJAiG6Yhyq6/0zJ7Q2RmfYqi8MtxS2JFQvVZgu3g3gmF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD56C4208E
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 01:51:00PM +0200, Robert Richter wrote:
> On 03.09.26 16:23:43, Alison Schofield wrote:
> > Linux has required that a region's interleave granularity equal the
> > interleave granularity of its interleaving root decoder. A mixed-
> > granularity region lifts that restriction: the region granularity may be
> > finer than the root's, so the interleave refines from the root toward the
> > endpoints.
> > 
> > Mixed-granularity region support introduces interleave relationships that
> > are not obvious from the existing CXL documentation. This is particularly
> > true for the 3-, 6-, and 12-way configurations and for understanding which
> > configurations permitted by the CXL Specification are supported by Linux.
> > 
> > Document the mixed-granularity model and Linux's coarse-to-fine
> > restriction. Include the relevant configurations from CXL 4.0 Section
> > 9.13.1.1 and annotate their Linux support status.
> > 
> > This intentionally repeats information from the CXL Specification. The
> > specification remains authoritative, but showing the Linux support policy
> > alongside the legal configurations ensures readers do not mistake an
> > unsupported Linux setup for a configuration unsupported by the CXL
> > Specification.
> 
> This doc is too long. It should only contain the following:

Sure I will take another pass at trimming. I'll respond piece by piece
below.

> 
> 1) Describe a brief description of how the specification defines
> interleaving along with references to it. Only add what is needed to
> describe the cxl driver specifics in 2).
> 
> 2) Limitations and implementation specifics of the cxl driver compared
> to the specification.
> 
> This document is ambiguous on what the specs defines and that the
> driver provides. This is blurred in this doc.
> 
Let's go thru that point by point because I think that was the whole
point of the doc ;)


> > 
> > Assisted-by: Claude:Opus-5
> 
> I am fine with that, but we shouldn't use it to create tons of docs
> which we will need another AI assistant again to read. Though, I read
> it on my own. :-)

I find AI is particularly useful for the mechanical .rst work: building tables
and using correct formatting, while keeping the result readable both as rendered
HTML and plain-text patch review.

> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  .../driver-api/cxl/linux/cxl-driver.rst       | 153 ++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > index dd6dd17dc536..a61a20c8bb6d 100644
> > --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> > @@ -602,6 +602,11 @@ derived from their upstream port connections. In `Cross-Link First` interleave
> >  configurations, the :code:`interleave_granularity` of a decoder is equal to
> >  :code:`parent_interleave_granularity * parent_interleave_ways`.
> >  
> > +When the region granularity is finer than the granularity of an interleaving
> > +root decoder, the relation inverts: the :code:`interleave_granularity` of a
> > +decoder is equal to :code:`parent_interleave_granularity / interleave_ways`.
> > +See `Mixed Granularity`_.
> 
> This introduces another unnecessary restriction: granularity must
> decrease from root down to the EP. E.g. The following config would not
> be supported:

Yes, those configurations are intentionally outside the supported subset.
Refer to the cover-letter requirements discussion.

> 
> a)
> 
>  Level             Ways    Granularity
>  -----             ----    -----------
>  Root                 2         4096
>  Host bridge          2         1024
>  Switch               2         2048
>  Endpoint             8         1024
> 
> Or:
> 
> b)
> 
>  Level             Ways    Granularity
>  -----             ----    -----------
>  Root                 3         4096
>  Host bridge          2         1024
>  Switch               2         2048
>  Endpoint             12        1024
> 
> In selector bits this is for the variants a/b:
> 
> root:   bits 12/-
> hb:     bits 10
> switch: bits 11
> 
> So the actual requirement is that the combined mask is consecutive.
> The lowest bit marks the EP granularity. The bit weight marks the
> 2-factor of the EP (total) ways.

Yes, that's the architectural requirement for the selector mask. The
restriction here is on the subset of those configs supported by Linux.


> 
> This series should implement all cases as at some point the issue will
> pop up again.

Implementing all cases is not the goal of this set, and I don't think
that is just me being gunshy. We add support to the kernel as use cases
appear.


> 
> > +
> >  At Endpoint
> >  ~~~~~~~~~~~
> >  `Endpoint Decoders` are programmed similar to Host Bridge and Switch decoders,
> > @@ -619,6 +624,154 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
> >  Linux does not support unbalanced interleave configurations.  As a result, all
> >  endpoints in an interleave set must have the same ways and granularity.
> >  
> > +Mixed Granularity
> > +~~~~~~~~~~~~~~~~~
> > +Linux has required that a region's :code:`interleave_granularity` equal the
> > +:code:`interleave_granularity` of its interleaving root decoder.  A
> 
> This statement comments on the current kernel implementation which
> this series aims to change. It will be misleading to document that
> here. I rather would not document an implementation state that will be
> changed.

Agree. I'll remove the historical statement and describe the resulting
support only.

> 
> > +*mixed-granularity* region lifts that restriction: the region granularity may
> 
> This term is not a spec definition. It just describes a special case
> that may happen. I would avoid introducing it here. If the granularity
> implementation ware generic, there would be no need to describe that
> special case. So better describe the issue of current implementation
> and how it could be fixed.

Agree it's not CXL terminology, but it's useful terminology for the Linux
feature/subset this series implements

> 
> > +be finer than the root's, so the interleave refines from the root toward the
> > +endpoints.  The mix is between the root and the region, not granularity varying
> > +arbitrarily down the hierarchy.  Linux requires granularity to change
> > +monotonically, either coarsening or refining, across the decoders that route
> 
> Why that? It is not a requirement, but a limitation.

Yes, it is a Linux limitation. It is also a requirement for a configuration to be
supported by Linux, which is what this section is documenting.

> 
> > +the request: the interleaving root, the host bridge, and any switches.  The
> > +endpoint decoder is not part of that walk, it carries the region ways and
> > +granularity so that it can translate, as `At Endpoint`_ describes above.  A
> > +mixed-granularity region requires an interleaving root decoder.
> 
> Again, this is current. But it does not need to be documented here, as
> it is changed later.

I'll need to inspect what truly becomes obsolete. If this describes an
intermediate state superseded by the series, I'll trim it. If parts describe
the final Linux model, I'll keep those.


> 
> > +
> > +Every decoder advances one target every multiple of its own granularity, and
> > +the decoders below it subdivide the address range their parent assigns to a
> > +single target.  The `Cross-Link First` example above shows the other ordering,
> > +where the region granularity equals the granularity of the root decoder and
> > +granularity coarsens toward the endpoints.  A mixed-granularity region refines
> > +instead, reaching the region granularity at the innermost interleaving decoder.
> > +
> > +Refining is not a preference.  Once the region granularity is finer than the
> > +root's, Linux gives each level below the root a single granularity, its
> > +parent's divided by its own ways, so the ordering follows from the region and
> > +root settings rather than being chosen.  The CXL Specification permits other
> > +orderings and does not require a monotonic one, see `Mod3 Interleave
> > +Configurations`_.  Reaching a fine granularity as early as possible remains
> > +available through `Cross-Link First`, which this does not change.
> > +
> > +For an 8-way mixed-granularity region at 1024 below a 2-way interleaving root
> > +decoder at 4096, where each host bridge interleaves across two root ports and
> > +each root port hosts a 2-way switch, Linux programs::
> > +
> > +  Level             Ways    Granularity
> > +  -----             ----    -----------
> > +  Root                 2         4096
> > +  Host bridge          2         2048
> > +  Switch               2         1024
> > +  Endpoint             8         1024
> > +
> > +A *region position* is the index of a region-granularity chunk within one full
> > +pass of the region interleave, and each endpoint of the region backs one
> > +position.  Each decoder contributes to an endpoint's region position in
> > +proportion to its granularity::
> > +
> > +  position += target_position *
> > +              decoder_granularity / region_granularity
> 
> The position is used to decode the DPA to SPA, and that is the actual
> definition of the position: The position bit mask are stripped off bye
> the endpoint to determine the DPA. Vice versa, it can be used to
> calculate the SPA by inserting the position bits (mask size depends on
> ways) at the granularity boundary into the DPA and adding the HPA
> offset.
> 
> The above definition is just misleading and only reflects this special
> case and implementation.

I think I get you point, conceptually. I can define what position means
first using address translation. Then explain how this implementation
calcs it - if that needs documenting. I'll take a deeper look at this.

> 
> It is also odd to use division when bit positions can be used. Same
> with the multiplier below.

Same result. For me, division better communicates the relationship being
documented.

> 
> > +
> > +That multiplier is the *weight* of a level: how many region positions pass
> > +between successive advances of its target index.  The root above selects a host
> > +bridge every 4096 bytes, so it advances one target every four region positions,
> > +weight 4, while the switch advances one target every position, weight 1.
> > +
> > +The two orderings weight the levels in opposite directions.  Refining, a
> > +level's weight is the product of the ways of the interleaving levels below it,
> > +so the innermost interleaving level has weight 1.  Coarsening, as in
> > +`Cross-Link First`, it is the product of the ways of the levels above it, so
> > +the root has weight 1 and advances one target per region position.
> > +
> > +The ways and granularity of a mixed-granularity region must describe the same
> > +interleave *span* as the root decoder, the address range in which the
> > +interleave pattern completes one full pass::
> > +
> > +  root_ways * root_granularity == region_ways * region_granularity
> 
> How is region_granularity defined?

I'll addxregion_granularity definition before this equation.

> 
> In fact this describes, that the root selector bits must be the upper
> bits in the selector mask. Even that is an unnecessary limitation to
> implement support of "mixed" granularities.

Another scope issue.


> 
> > +
> > +A region that does not describe that span either leaves part of the range
> > +unclaimed or reaches beyond it, and Linux rejects it.  A same-granularity
> > +region below a power-of-two root decoder is exempt: it may be wider than the
> > +root and repeat the root targets, so its span is a multiple of the root's.
> > +
> > +Mod3 Interleave Configurations
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +A 3-way, 6-way, or 12-way interleave, known as a Mod3 interleave, selects its
> > +target with a factor-of-three selection rather than from binary interleave
> > +selector bits alone.  CXL 4.0 Section 9.13.1.1 defines the 3-way selection as
> > +the address above the decoder granularity taken modulo 3.  A 6-way selection
> > +claims one binary HPA bit at the decoder granularity and takes the modulo 3 of
> > +the address above that bit, and a 12-way selection claims two.
> > +
> > +The factor-of-three selection is not an additional binary selector bit, so a
> > +Mod3 interleave distributes across the hierarchy as::
> > +
> > +  3  = 3
> > +  6  = 3 * 2
> > +  12 = 3 * 4
> > +
> > +The cross-host bridge selection carries the factor of three, and the remaining
> > +x2 or x4 is binary interleave selection below it.  A 6-way region at IGB across
> > +three host bridges is therefore::
> > +
> > +  Device-level region:   6-way @ IGB
> > +  Cross-host bridge:     3-way @ 2*IGB
> > +  Below the root:        2-way @ IGB
> > +
> > +where both levels describe the same interleave span::
> > +
> > +  3 * (2 * IGB) == 6 * IGB
> > +
> > +The CXL Specification defines the legal Mod3 compositions and is normative.
> > +CXL 4.0 Section 9.13.1.1, "Legal Interleaving Configurations: 12-way, 6-way,
> > +and 3-way", Tables 9-6, 9-7, and 9-8 list them for a 12-way, 6-way, and 3-way
> > +device-level interleave at IGB.  Those tables are summarized below, annotated
> > +with the subset Linux supports.
> > +
> > +CXL 4.0 Table 9-8, 3-way device-level interleave at IGB::
> > +
> > +  Row  Cross-host bridge  Host bridge    Switch         Linux
> > +  ---  -----------------  -----------    ------         -----
> > +   1   3-way @ IGB        none           none           supported
> > +
> > +CXL 4.0 Table 9-7, 6-way device-level interleave at IGB::
> > +
> > +  Row  Cross-host bridge  Host bridge    Switch         Linux
> > +  ---  -----------------  -----------    ------         -----
> > +   1   6-way @ IGB        none           none           supported
> > +   2   3-way @ 2*IGB      2-way @ IGB    none           supported
> > +   3   3-way @ 2*IGB      none           2-way @ IGB    supported
> > +
> > +CXL 4.0 Table 9-6, 12-way device-level interleave at IGB::
> > +
> > +  Row  Cross-host bridge  Host bridge    Switch         Linux
> > +  ---  -----------------  -----------    ------         -----
> > +   1   12-way @ IGB       none           none           supported
> > +   2   6-way @ 2*IGB      2-way @ IGB    none           supported
> > +   3   6-way @ 2*IGB      none           2-way @ IGB    supported
> > +   4   3-way @ 4*IGB      4-way @ IGB    none           supported
> > +   5   3-way @ 4*IGB      none           4-way @ IGB    supported
> > +   6   3-way @ 4*IGB      2-way @ IGB    2-way @ 2*IGB  unsupported
> > +   7   3-way @ 4*IGB      2-way @ 2*IGB  2-way @ IGB    supported
> > +
> > +Table 9-6 row 6 is legal per the CXL Specification but is unsupported by Linux.
> 
> Exactly, unsupported config as described above.
> 
> I am good with the 3-way section above, though it just reflects, what
> the spec describes and I wouldn't be that detailed here.

Will trim that.


> 
> > +Walking it from the root toward the endpoints, granularity goes::
> > +
> > +  4*IGB -> IGB -> 2*IGB
> > +
> > +which refines and then coarsens.  Row 7 interleaves the same 12 endpoints at
> > +the same granularity with those two levels exchanged::
> > +
> > +  4*IGB -> 2*IGB -> IGB
> > +
> > +which is monotonic.  Linux programs row 7 for a user region and assembles an
> > +auto region whose decoders are programmed that way.  An auto region matching
> > +row 6 is not assembled.
> > +
> > +Leaving row 6 unsupported does not prevent a 12-way device-level interleave.
> > +The specification defines six other legal compositions, all monotonic and
> > +supported by Linux.
> 
> Again, we should (and can) avoid this limitation. 

Scope again. Why? Use case? Let's keep that discussion in cover letter
thread.

> 
> Suppose the following: This is a support cxl driver config:
> 
> 4-way: 2-way @ IGB    2-way @ 2*IGB
> 
> Root ports and switches are configured correctly. Now, you just want
> to enable 3-way which could be done without reprogramming the HDM
> decoder (accept for the endpoints). Those configs become unsupported
> and granularities need to be reprogrammed. This is very unexpected.
> 
> Changing implementation to use selector bit logic will solve this
> limitation and make code (and doc) much easier.

v3 had selector-derived machinery. The simplification in v4 and v5 came
after narrowing the supported set and removing it.


> 
> Thanks,
> 
> -Robert
> 
> > +
> >  Example Configurations
> >  ======================
> >  .. toctree::
> > -- 
> > 2.37.3
> > 
