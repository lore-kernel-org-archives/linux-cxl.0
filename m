Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2001E525
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745785; cv=fail; b=RTvgb7gyOXB4QdUMWiaJWXvXgXc+vH1FehXKgXrLJdXM6x5F7SPWtwsFyxu9FEQ8qWLFsVsWYpvM3ZZp3beVJBDo821dGEwL5RtvSQM76sH7FfHAEMeki1sXWxRpuR9vEjIPOILAoPuABaKzEFd/ejZUC0KK1NEcsYXT/4F7EQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745785; c=relaxed/simple;
	bh=lAK6ZCx8xZO0ndSTke0f6cGKkSIbgmKdfkgilMpfl7A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I+277nFvYWcwiAOSxL9RcVScnu6T++Uc/B/YLI9nam1ZjlGBaG0RNWlqrZs0VMAdEHRDkUnbY2br+1Oo0c+MgP0t1o1BNGIQFZbpy+0HxQpn56BFMU9ZvNttwMxsnqjEnbtUMucs01tzfVObXbuOwwCBk91wfoI0vT7WyFDKKsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XD7qLD0t; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XD7qLD0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711745782; x=1743281782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lAK6ZCx8xZO0ndSTke0f6cGKkSIbgmKdfkgilMpfl7A=;
  b=XD7qLD0tGJOdnjkj3DIsnXKHgqzfljdZFMTdFXqcWQL9qNquWpW9jnwC
   VYNuRJfzn0lMdA1nNS0rhATNKrXz5CWbCAKl9Tiq68OUPT23LjsbqlWer
   LBngisi9OKb2cgvMOTA48sOdIIBNJqbzh5eD9kdfx1u39Juywgvg0YbQ2
   AiVpRFbu98rQVlH92B7KD3j5mjEXJhW93kXmp5KEfoxzfT4p/iHTBM8n9
   FyQHA6QBGohdHupbObpMCPZc+isBy8dZ5Nvo9g9oS1E7O3k5qZgki2QSP
   +Dl7OfAHC6DaJfYDzRez98H21FPi7U2cpi6NzLNWbY2Ctb1o8Q6MBVawW
   Q==;
X-CSE-ConnectionGUID: VaiS1s/XRgGOMX7oKnj9Vw==
X-CSE-MsgGUID: gKTLhPYCSIuYOF+A2vu/gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10730281"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="10730281"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 13:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48050225"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 13:56:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 13:56:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 13:56:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 13:56:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 13:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPeni4khJTHGM2Qg42SKxsIoItKJplYPutE+IxW+qnZEJZOMr6crOjCaU/mFkUWKOBLPvLPe1TUyrNVjD19PmmPWG1kAXRj+N40UnTNuz+R+BUtxPnaxu1PBV7Z0XpUjuv+GLswsO8YBXu48r0ZGkHevm0HH7RwVhp4hu+1vaVi1twplVy+eXsdJIVOUXfIKkvlgVaI1JK2tIdS+ZUy/aXGsaPgs2/tFvXcJr1Xq/UXNDSnPSBpvmkDjRk6aQMuwoOIZ6yjgQd+exa9EE+Ox9xpS5dg6Inq2yv1KEwryw91hDPW4n575A38q2RNFxzllP4HzRADhvgzztFo/u7/vSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pOZwajKgZxV2pzGJ0RdIV/O9bbwyNzmkLez4mHXFXw=;
 b=PgrDih5mxt+a/rsWJUzCRDwO1UYbfHugxYt4dQtV3yt4q1D93Hj1iNPnIdT+AFgQ7H4bBmdkMfWeV1vr9ZopaUYWcEfr5jnV1L8EpJ/SG8xzAMz6CqFclnQE3pz5Luwocu0ID0BPSzRJedHQnOoRcph9oKvxEh+J07QVkY51PrQuoujaBuTCpVmna1UzSXd+VPaC7sJVPFgl5+YjCfCjST41ceTfwuX7wnf6LHhkeFtjufLwspjWEOoSQ9r2VeuSPdTHPAj5r343UyB6XBi9G3GPvlq0fJy1akJWnLwkyfCtpuce/o4Ig7RKg0VABPgu1DY6eGmJIHFmrYzI6AwhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 20:56:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 20:56:19 +0000
Date: Fri, 29 Mar 2024 13:56:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 0/6] cxl: add poison event handler
Message-ID: <66072af05b76c_4a98a29472@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
 <660706e8a66c_4a98a294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZgcYnCr19aVhCO93@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgcYnCr19aVhCO93@aschofie-mobl2>
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8353:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2ZmG56MLOfvp9zLB/5PHlwafxjcb3DQL86ZlbIY8Tm5tiertFLfqlcc6vzqXHUfAlTqxtIqEyJjNBZZo+CnfsZdoIQZQklHM7uILPZg/b4JlPFapBxzhwrYCkBbmN5giJO9eoy/cmSQQubDRdtNrm3uYdllRdiczNDaf5OjUx3Of6M5wH16JrEYUbCRfKXE2nJhcu7Gt+uMs8I2aC6kNUI543GtAp92BHOy4zObVVqK5AVryFe3cdUqYynol+nTKhLCipNmL0BLQM5HqY5elNqXrFbsVpt8DjDgqv4ccUBSlpMpxuMGbDOAtBxFe9dfL+rMCDy0jyxNqYbgc83NlW2aFaS4X+i8aRP96/mDBhcjfBCg7+AArqbLGdGzmQlm4wq8B9OJHZfquI3VQM6w9rlCLLiCYsUHm3CQJw1rA9PNKGXKPRGHJZhuxhivwgbedyOzwv8hEt0N0diACQaePTsP5zU1qEGtMOuK6p5fDOXwsyNlWtkxVAQYkzC54mGMBWctnBns2YenfwO6JtOCZzxPA5YQ6WwJFc7Qbp+2RRU7/mR26vU9T3GsKSnXqwhHeN+dINHZnFNu+IqoCvX3Tvl1RAjGm8c0dPSBMRh/aKwX7sf1M2yr7FKdNCca5yQwOLwYjM73D3uiv68NjKvdcd3VTJk6g8FFofMpLmFUYaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kq/y5lHmCtDKNqa+8W0V2Y/3YdjkNbE88DsXVBi11laz6kAfkw2YyFpY8GbD?=
 =?us-ascii?Q?9JPcqLHxf0xnpqZgS4k81MJj5l+eGKK0cD4HfKg5vOwE+UgX9uA2aA2ttddN?=
 =?us-ascii?Q?l0ScrEkDF9U4E+e4kQfu7sWE5pxWYSvqzdG6vJBqTc3CsAdaZWR9yWlFlrOh?=
 =?us-ascii?Q?g/oaH+XfC/Da00GbbKyfZjE0QrdGM1gdEfVd3JeK3ayXIVrH76o2q1GP44yw?=
 =?us-ascii?Q?zcPmwKz3icn53ZVEN4iMcWzKwhxTXbspEVhcCEDOn29SiF9TbWeitrxRjZK+?=
 =?us-ascii?Q?ju4qpAnvuDsXjQ9JVNouaJgWeZoCXiKG6N3Zgyw2jgm9ksjl0CWQ41rWhcq+?=
 =?us-ascii?Q?g9qoAkr8w39OJywlEk1L6tCFQWnGushyJ98jhKu1mHqZka/nAzGjzme/C3av?=
 =?us-ascii?Q?FVOU67ogHvPzm00KQe0QUKnhJ38zknK/VVwFM9numWqwk2uJmXCloEEE061B?=
 =?us-ascii?Q?UPBKOnmCO01+/WGZM8MNA3KduqlSsnd4p5pGkW8MAoR/v4BJ/taw14HKZBts?=
 =?us-ascii?Q?7jkZASPm4SLwl9ENGGbZJx1jlP7iUF22X3GZwHI2SmGQGjrWMOr3zGhry4uA?=
 =?us-ascii?Q?OAgrv5ZlcnxbsRbTAkWXPLBFQh1It1T68nUDup0bQRbSQvj165QPTT+vMuJe?=
 =?us-ascii?Q?BpnjdxsEZqjG+RQ96/6YmX4IAQ8r5m9iUFzTTDvlp2rlC3PFET1iqKEq/Ljs?=
 =?us-ascii?Q?aBJKQ7+KEx35Lm5XDBIr7D/jcF+E4PgWqx6IaWdbd7VrOSK7OaRCWoaIaHh9?=
 =?us-ascii?Q?LBrNn0L9tAwYPFJgwOPORJgvXxged2uf9qMOj/mQn0q7qE3Axm3GKVj5xkQW?=
 =?us-ascii?Q?R4m1265nYlXGdz4fzcPzPOwVLcYqi4u91UgSSBqcNRYo4/HgPtCYvuSft7Pi?=
 =?us-ascii?Q?oTkXm0VfvhHSE2Nbcql4F7+Z6WETJK/lj6OYR1Xj5waG8hnKQNAiZ2+rknW0?=
 =?us-ascii?Q?LPooVjLo2GeaoTnaHHC6jR47KS/f0r1PR4+KqIcf5yz1GdeBzekEJjcrgCe5?=
 =?us-ascii?Q?c/L34inYsVchF3srD15fYs9HuOS9X4lPJwTGmV4XrSXBwyFTHSlJfJZzpE4o?=
 =?us-ascii?Q?KcUp4zOfmnFEAPu8uSA4B/ZJzN7ynXivLmiAqCsJ1zgMZf6Yr+jmx8E9Oez2?=
 =?us-ascii?Q?dFrOlRS63078DEN9gSjw3akpa5xnLZiJd9XBNBDhFcpySFiGHnWwSpA2/QfC?=
 =?us-ascii?Q?GLG6myyYLsLL7m4KcrZKmDkJF/K87GljiP/mHEi4wWaDobDMnsM23UFoavs1?=
 =?us-ascii?Q?OCEBb262lMIx0YZwHgAZoIJS2QlV8lZEwXJyIey5PHmQMGFK2PQVMpRduDWx?=
 =?us-ascii?Q?j+qNv2aNLW4AQTdnpkDhboHrcmCteUwVuZ2unkWU3uTqHILnUK95NZ/aOqVS?=
 =?us-ascii?Q?KQwEktFU+uYwiN/mlI8Ak1crHItv7RJAiuNm6j4SP/TsrYjZ0OFPOxJCi+Xp?=
 =?us-ascii?Q?4v2Ee7ETSKKn5Ocy2wEmdhY5reJBQ7wOotESR+heljglEaGiIyNJgyY7LscW?=
 =?us-ascii?Q?K8NhvT176fTxFrGv5YSrrp9DPF3hPXO9RC0CGAMJEPEhXWSfLOikvBR3rKgS?=
 =?us-ascii?Q?msNU/GxUXH/lqKjEvkwjzdOYLajbYatldGW3XKqZrDpeVJTirmTPNBnXjlcj?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01863d94-ef21-4462-27db-08dc5032aebe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 20:56:19.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etuHTn8bd2IN0OYteu8kC5+u6DGvjRcoekdO7hBeTEYzD4ohysBtS8ejd4B3GiOID7CCy1yTeN/1YCXQCjJhCbcDQNw0TuhZUon4DZIuvVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Fri, Mar 29, 2024 at 11:22:32AM -0700, Dan Williams wrote:
> > Alison Schofield wrote:
> > [..]
> > > Upon receipt of that new poison list, call memory_failture_queue()
> > > on *any* poison in a mapped space. Is that OK?  Can we call
> > > memory_failure_queue() on any and every poison report that is in
> > > HPA space regardless of whether it first came to us through a GMER?
> > > I'm actually wondering if that is going to be the next ask anyway -
> > > ie report all poison.
> > 
> > memory_failure_queue() should be called on poison creation events. Leave
> > the MF_ACTION_REQUIRED flag not set so that memory_failure() performs
> > "action optional" handling.  So I would expect memory_failure_queue()
> > notification for GMER events, but not on poison list events.
> 
> Seems I totally missed the point of this patch set.
> Is it's only purpose to make sure that poison that is injected gets
> reported to memory_failure?

Clarify terms, "poison injection" to me is a debug-only event to test
that poison handling is working, "poison creation" is an event where new
poison was encountered by CPU consumption, deposited by a
DMA-with-poison transaction, or discovered by a background scrub
operation.

> 
> So this single patch only:
> 1. Poison inject leads to this GMER/CXL_EVENT_TRANSACTION_INJECT_POISON 

Inject is a special case. Likely this should copy the PMEM legacy where
notifying memory_failure() on injected poison is optional:

"ndctl inject-error --no-notify"

> 2. Driver sees GMER/CXL_EVENT_TRANSACTION_INJECT_POISON and reads poison
> list to get accurate length.

Again, inject is the least interesting for the common case, production
kernels care about "Media ECC Error" and "Scrub Media ECC Error"
regardless of transaction type.

> 3. Driver reports that to memory_failure_queue()
> 
> Still expect there's some code sharing opportunities and I still wonder
> about what is next in this area.

One area this needs to be careful is in unifying the OS-first and
FW-first paths. In the FW-first case the platform can trigger
memory_failure() along with the GMER by just posting a memory failure
CPER record. So there is a risk that things get doubly reported if the
GMER handling code blindly triggers memory_failure(). Might be benign,
but probably best avoided.
