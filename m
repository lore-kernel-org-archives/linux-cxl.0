Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842A32A3DA
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403191; cv=fail; b=R/gX83FOP7pfFt9eCeEnAjlzYjlPBS/mDnot4L61v46Pe+2uuum6Xrlvjr8y2UYx5cQKUT903FqJDwv1FLrOOR4YW8GLqDY9t2NU/NHlLQJlBFTS0PR+oX6Opl053zSFh4Jnaa5AAcpNrbOlgmy/5nqEPS1LsLpg8GaPRvtr7LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403191; c=relaxed/simple;
	bh=SSAKrDkE1i6ZEB7lkS2upKCBtN+/17cwtPo0Xq6ySBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FjnYa3CjnPkSgv0+9JCgyDfErMP8tengv8XSfyQNAoN8aQe43roN1Vr9Th8vuGcOeMzRJNo4kPQLggOura1GbmTKb0RocjtsYmVMe4fZh5G2GOVBSOVJstFEaO8dXe5Owxu5sIBVp2iy9IdEWG22+vRUwYsnf6j8ZZ3M8GKx9ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGJyZvF7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGJyZvF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788403188; x=1819939188;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SSAKrDkE1i6ZEB7lkS2upKCBtN+/17cwtPo0Xq6ySBk=;
  b=KGJyZvF7CcrgB0XG7Dczio/jPoNuku9fNpsK5LI137iRm8/dF7DcQnlh
   x2KUWVSz0evYuxjC673sV/TG/uwbfj4X3cXZJpj9DGn/j2EBnRvoJgjrp
   lqX9A6lh8LN/Lx7q9J1k2CY3uSyhIMSFb2p92BQ4fSGwibaIlDhNMGcXX
   zjuoCQeBgmODf4LAFtqqASWn36Y8N823aW1fHEspGXdAKOi8GtVdzSJ0b
   eVVPCL1k7k7V48Q6+WlHYMGhpMyaoZcMWU3GUWyvYbbSxs0t9wibN0GFN
   8ykfxmYUOMVw2lJ4gngZftpKK26MdY5uwcvJIgWz2mSySGvbg9ScdURg+
   g==;
X-CSE-ConnectionGUID: vwAeIw1GSqu3PAPr+T15vg==
X-CSE-MsgGUID: nOt0uXXUSJqTCIZHTOS8LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88925135"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88925135"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 19:39:47 -0700
X-CSE-ConnectionGUID: G6OvAEJIT8OITXszWm6zIg==
X-CSE-MsgGUID: 44h03/YOT/aJ3Nbq1hXLbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267824389"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 19:39:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 19:39:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 19:39:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 19:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW1DXHB46miD0Y2zyWBq9J6Fc/DGDFX2GIAmZ6/efq5/0Y+28egxXEeqlZMxap/sKbflas7M5Y1MqMDIirw8dwGb2p0/CLnoChXI/HXvnN3DRE+Bb7VcVrsNQ9GRU0A5DDektV6h8gtDU3aK4WqyLmk2OtjmV8EAXWxGB7QsBabmUjvzNea0BkfVohPzLQBmUM3u3hbRdyKoVYtdl+p8jtsebcf1p03xCcQgKUw/sK9SEfE0DK2nnvhr0NkFErMW1sik3sBzN7vXAY2yMsUEiU+gliFxN3vttZOb6LQWvyOXCUjokqeHzE5AJ6ePPPPkv+ruLek+Bv8u4mFhG6N/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6sVTz2IXlOfOQF4FYOXKbxJJwqNSdFSdLGpjmvFq08=;
 b=nPTTBYX7JlOEnYvB/V/EfGvsXbWrbPBswWWScU76BFOn9HOqT5jyqbRGXCWUIjSi7phiC7zrZhiWjyC9kIrRlnBX9810hk0wMfuxCTWutK5NnHaK5G6+d+Vd7rzSi2tXK/peq6euGa3TretuH4NjEtaJoI9Uz3Nz+xmm525uExSKd9ki5btxwSq1cLpYkA5V9LNhBiiwYeSqqZLlI3wPhr/kCHOeBPcBPZgmhyrSir/U2J0a553NnNJCra0X4INfn7M/+ePL1LjZBAViLl3dPTIDFBA7m7Gis1/MggQDMx/rFagshV6js0qDlRepwCf8xuyEmbTvCbuQQ5PfuuoN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 02:39:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 02:39:38 +0000
Date: Wed, 2 Sep 2026 19:39:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Message-ID: <apjd4MsKRlBcR4bw@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
 <20260821215450.3cc4d69f@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821215450.3cc4d69f@jic23-huawei>
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cde9b0a-9873-461e-c55b-08df09649906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|5023799004|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B8csa14csibt9bk4h7GOl6tbt1/RBT27UWOL0IAk2R1+8NxaQbFgaKjCHjzSV+/Tmmwj/QZ0CuDyKgwtGB2OqZ6O/BnhbN2fQ8mPz+4P9GmcaZfq+eLtogw3vRsVhbUSBlFr/xiPATW1Ca9qgevT1w+vIaAGMx8V9YRpINuNMmpRWOd57N4bymNwJ/Z6gX1CPbyjJ4Ty4ph0nyxUMh7rfQKsZqBFgaOrDi5VwjdG3dCY3PxAMqk4ZOlmrMV2hLgawEcmfRPY4HPK9n0It071od+1IFVPN6adZTMxsWHVDMldjNeXx+PjQR+a8AAByDEHHw1PqtiYrn/BE8auPzeJmBZ/ECCXOQ3MHb2HTNqXnnZj8GLtELOh6gt8LFKzl9/D6dbGDJpkZ+9O3vro0lyr7N62R3+QXFutr7HMZwBuldTV0xw6y5xTW3Ttk5y2Euxdu0gtTd8qrI8qqTeKmv/ueH7to61b9ohm9KfYDdWRgAXysafSwH4jUEOQhLgLb2cTaLGCwEQe2uDGsnjJFflMyiFV5SKGSZy9raodaadGWeheSJLF8bDqKhQLQ6sBh5k2pNGa4BBbQH6EG7q01RUjnrhF4DIsM4t8x7jja5jzfth/AD5NTDkcbC/mjY2MMlxgNyCW9cDkqyyZ4LG8SB84ByWobAtJ6woQAdVV4qhftDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(5023799004)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?couPZk3V0wk7v098wCntov6Azhs6jd151PhRHjD459DPHr7ejnMbpvH6Cxci?=
 =?us-ascii?Q?74JXiZdL/LRjEp2cN1aKmEjsRj8o+PkHSi0GHfPAG/qqtarZtQkL993SPRGJ?=
 =?us-ascii?Q?1kih7R5p2YjYf5j8OQzmFgmomDsWvRbg/6rj9kIiQ14Ym+CsdXd54Bq/B/mU?=
 =?us-ascii?Q?oXM8odlfoN/vqt9GHPmBg4TYYuWPOGfEbt5tlN41o4xYHfvZ0PsopEa/1gbR?=
 =?us-ascii?Q?lcrg1xniw/JCyJxYsY9fKbDq9VqLTIiPuO2oSwOWtX4N7hM7OdoooZgCSc9d?=
 =?us-ascii?Q?PEAICo0nka6Ou8rZj4tq1B9LOOuse02CPmNrtpx0Wn2CXVdFtVFY2bMmcH/B?=
 =?us-ascii?Q?qafUd+uwqwmItqZIW71LCNf3CHXd2pEiqq0FU2orXD7qf8WURUZlqzeK/CMe?=
 =?us-ascii?Q?k7MZ1ruwyVW7065nG5JS0vKDp/0tXRYfnwAAF1d815c9DPShNjtg9+RQdjkO?=
 =?us-ascii?Q?64ZHt+wwKFl/NgEVhz6wkMlGHmSeXPtJ8AUH6uXyIBuoa0Q15ENSkOJM3a/0?=
 =?us-ascii?Q?e2kNbgIaTDNtSv0JBHNZWGFwgVT/J+F4hKdgC+kgLc5bnFdsBoxJQAhKVHX1?=
 =?us-ascii?Q?k2kThqiy1DmtzUlr9cjlN/XtDfW32KdnvLgGB4B+f0UBxnMP079AD9wp6366?=
 =?us-ascii?Q?B8wXGZnmXjc00DUfHkv4FsQiipUgBfW8DuMiGe99+0vLedHOTNWpeSzGShV1?=
 =?us-ascii?Q?/4OLCq4keUD2l/vz5kHEBbj2LNOzUMmGsBZLBdNJs54swqSjRtb5uob6dbLb?=
 =?us-ascii?Q?RpfaTasUsvC0BA/tUHnKpYSnwkexWsrzK2dIFWROr0l2B3kNEeX3mZ+awPUE?=
 =?us-ascii?Q?DvNKDTHdBPRiOPoeAhcrj9xKLygVqTPiVonVqedteWBGScL+I0c+1ompaLyd?=
 =?us-ascii?Q?VFBmS15DT4fpCfooKfGS5mNJjEkafNv1AnHWBpKZSHtLrqwSWr0bKgjNnNyR?=
 =?us-ascii?Q?402e3hmXFn1npQgjCEINnkNvoQzGqHu8qrRYzzK6Jfw+653E8eyb/rayLfh6?=
 =?us-ascii?Q?u9lYyBHOxXA+P8LhuvHRLWVqLds1/SlcLntI8kzUAEaIszqUMA2yTj2Bfquu?=
 =?us-ascii?Q?RHRzzBlOlcB786b/ZBxj8uYPj7Uk6zvDHrKjRpYiTyr89x9rR3rHqCiBvD7H?=
 =?us-ascii?Q?ZVxaYrIqi9+8ieeKReIpmaqClNNXyiyCunjyNz3nH0HfC7bBjhJjVJOVoTt0?=
 =?us-ascii?Q?MRXvuhc9x8QtSH7aikhIMmKRrp+LWqlh9nJlPgAv8HTwOiTv1DQzsbNpLT9d?=
 =?us-ascii?Q?dZGrtzyddI/67fdaR78JXGDa+irD2gGv1UQP8AnA8JkOIPwRIyDq38aMQ0MY?=
 =?us-ascii?Q?ZdMJHpkHvUGomWNU/DeEyvfJ21UIGfBz/yGEO/0v+Gd3YqyHldS4NBnyRIT6?=
 =?us-ascii?Q?pvTyyQSvcHtkbuySFUZgNhELZ6QkfoFqRe4CEviGfE+7gil3ePJW54lFu35Q?=
 =?us-ascii?Q?hj1wznT9k2AgbtT6Zr1h5mNRzFV9rTGJTgfMSRI8teXV+IcZs0rPdsM5wRkZ?=
 =?us-ascii?Q?B/N/B7DkR3MoH6+ND6gWtIZbmLM0GQ73EBmroOnp44YAHzUXxLsPDjwu0HkH?=
 =?us-ascii?Q?8d7Bee6hl6UXG1K/2buSRJMwoD9uOSVvaboGusVk+DmiXhcdjuOMrzemxoZt?=
 =?us-ascii?Q?3NoeAYfdLlJvK8KdCxI1wkEFiVEmBdWAVK9GEjrE4jC3YrYOXT0pBgLx9R5U?=
 =?us-ascii?Q?Ns4mApvms0vZPEteobdc9U2RRHaixYVJkPUJFFgaxWGx4zBoPnPOGK/VykVb?=
 =?us-ascii?Q?dRjjUPeuGAsAVrWIaVaWSQFS+jndOpo=3D?=
X-Exchange-RoutingPolicyChecked: v+Wn4Iy1JnTbxXn0nP2lXMtBEKqbXfsfxZC+A/lOt3AdCJ2dE6MU1r6rlcv7rw5YRFxpq/oAJ76ve8itbhUxrouY4UJYTKdWsn54TusRB/FLLxqsDDnBL3MdvgieXe/7O0kBH7AcVbotDhG5qtyZ63MBS2LdLlXIJFkY4TVA2VeeCXn3FN9GxEDaEe8Zcj7lOtwzqqMQFu9tSw0Hz1FxZSnJ6kNu2PWmZehl9xlpV0tn5DXw9OM7nuTd9gUlToU9eRPxOitqNEVv63c/ZDHAGn8wdAyVu8NLhVdqthyehD71tH1adUrpckUfq+b/gujLbb5uSBQ7XbGMCZkWP3c9jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cde9b0a-9873-461e-c55b-08df09649906
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 02:39:38.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrsWeq9KDssSf4O55pZwiLP6FJgoSXVDyjKLTdbkPKeWO9x72Pq54eMK9cRcIR4shpn0YacyD10KQAFeZ0l6dHtYUd2TIBtS2WGfDBRSGhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8665
X-OriginatorOrg: intel.com

On Fri, Aug 21, 2026 at 09:54:50PM +0100, Jonathan Cameron wrote:
> On Thu, 20 Aug 2026 16:31:20 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Endpoint position calculation currently relies on the requirement that
> > an interleaving root have the same granularity as the region. Auto
> > region creation builds the position by multiplying by each parent
> > decoder's ways, while user region creation selects the root target
> 
> decoders' (more than one and belongs to I think)

Yes. Done.

> 
> > with 'pos % ways'. Those calculations are sufficient under the current
> > granularity restriction.
> > 
> 
> So far no definition of mixed-granularity - hence suggestion to drag
> the docs patch ahead of this one.
> 

Done. The documentation patch is 1/7 in v5 and this one is 3/7, so span,
region position and weight are all defined before anything uses them.


> > In order to support mixed-granularity regions, that granularity
> > restriction will need to be removed so decoder granularity can change
> > between levels of the interleave hierarchy. The position calculation
> > needs to account for those changes to produce the correct endpoint
> > ordering.
> > 
> > Change the position calculation so each decoder's contribution is
> > weighted by its granularity relative to the region granularity:
> > 
> >     position += target_pos *
> >                 (decoder_granularity / region_granularity)
> > 
> > Use the same relationship to select the root target during user region
> > creation.
> > 
> > For currently supported regions, the new weighted calculation reduces
> > to the existing position calculation and produces identical endpoint
> > positions.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 60 ++++++++++++++++++++++-----------------
> >  1 file changed, 34 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3b640c9ba5a0..4f367feaf6c8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1805,9 +1805,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
> >  	struct cxl_decoder *cxld = &cxlsd->cxld;
> >  	int iw = cxld->interleave_ways;
> >  	struct cxl_port *iter;
> > -	int rc;
> > +	int root_pos = pos, rc;
> >  
> > -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> > +	/* Root target selection advances at root-granularity intervals */
> > +	if (iw > 1)
> > +		root_pos = pos * cxlr->params.interleave_granularity /
> > +			   cxld->interleave_granularity;
> > +
> > +	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
> >  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> >  			dev_name(&cxlrd->cxlsd.cxld.dev));
> > @@ -1908,13 +1913,13 @@ static int match_switch_decoder_by_range(struct device *dev,
> >  	return (r1->start == r2->start && r1->end == r2->end);
> >  }
> >  
> > -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > -			     int *pos, int *ways)
> > +static int find_pos_and_gran(struct cxl_port *port, struct range *range,
> > +			     int *pos, int *gran)
> >  {
> >  	struct cxl_switch_decoder *cxlsd;
> >  	struct cxl_port *parent;
> >  	struct device *dev;
> > -	int rc = -ENXIO;
> > +	int ways, rc = -ENXIO;
> 
> Trivial and perhaps just me, but I really don't like combining declarations with
> and without assignments on one line.
> 

Split that.


> >  
> >  	parent = parent_port_of(port);
> >  	if (!parent)
> > @@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  		return rc;
> >  	}
> >  	cxlsd = to_cxl_switch_decoder(dev);
> > -	*ways = cxlsd->cxld.interleave_ways;
> > +	ways = cxlsd->cxld.interleave_ways;
> > +	*gran = cxlsd->cxld.interleave_granularity;
> >  
> > -	for (int i = 0; i < *ways; i++) {
> > +	for (int i = 0; i < ways; i++) {
> >  		if (cxlsd->target[i] == port->parent_dport) {
> >  			*pos = i;
> >  			rc = 0;
> > @@ -1955,13 +1961,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >   * @cxled: endpoint decoder member of given region
> >   * @hpa_range: translated HPA range of the endpoint
> >   *
> > - * The endpoint position is calculated by traversing the topology from
> > - * the endpoint to the root decoder and iteratively applying this
> > - * calculation:
> > + * The endpoint position is calculated by traversing the topology from the
> > + * endpoint to the root decoder and accumulating the contribution of each
> > + * decoder level:
> >   *
> > - *    position = position * parent_ways + parent_pos;
> > + *    position += parent_pos * (parent_granularity / region_granularity);
> >   *
> > - * ...where @position is inferred from switch and root decoder target lists.
> > + * ...where @parent_pos is inferred from switch and root decoder target
> > + * lists, and the multiplier is the number of region positions that the
> > + * level's granularity spans. A level that selects a single target
> > + * contributes nothing.
> 
> Wrap is a bit short.  I don't care much but you made one line above longer
> and one line here shorter.  So if going to do that, target 80 chars max
> for any line you have to touch.
> 

Rewrapped toward 80.


> >   *
> >   * Return: position >= 0 on success
> >   *	   -ENXIO on failure
> > @@ -1971,7 +1980,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  {
> >  	struct cxl_port *iter, *port = cxled_to_port(cxled);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	int parent_ways = 0, parent_pos = 0, pos = 0;
> > +	int gran = cxled->cxld.interleave_granularity;
> > +	int parent_gran = 0, parent_pos = 0, pos = 0;
> >  	int rc;
> >  
> >  	/*
> > @@ -1984,20 +1994,18 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  	 *        |    |           |    |
> >  	 *       mem0 mem1        mem2 mem3
> >  	 *
> > -	 * In the example the calculator will iterate twice. The first iteration
> > -	 * uses the mem position in the host-bridge and the ways of the host-
> > -	 * bridge to generate the first, or local, position. The second
> > -	 * iteration uses the host-bridge position in the root_port and the ways
> > -	 * of the root_port to refine the position.
> > +	 * The region and the root decoder interleave at granularity g, so
> > +	 * each host-bridge decoder interleaves at 2g and spans two region
> > +	 * positions while the root decoder spans one.
> 
> I've read this a few times and don't follow it. What are region positions?
> I was assuming positions in the region. In which case the root decoder
> spans 4, the host bridges 2.  So I guess not that?

I think  your reading is right and the comment was using spans poorly.
Rewritten.

I think a region position is what you assumed. That is the index of a
region granularity chunk within one full pass of the interleave, not
one per endpoint. The comment was trying to describe how far apart its
own target advances are, as measure in positions. The documentation
patch now names that the 'weight' of a level and defines both terms.

For the four-endpoint example, weights are 2 for the host bridge and 1 for
the root, because the root advances a target every region position while
each host-bridge decoder advances one every two.

Please take a look at these defines and comment updates in v5 and see
if it makes more sense.

-- Alison



> 
> >  	 *
> >  	 * A trace of the calculation per endpoint looks like this:
> > -	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
> > -	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
> > +	 * mem0: pos += 0 * 2       mem2: pos += 0 * 2
> > +	 *       pos += 0 * 1             pos += 1 * 1
> >  	 *       pos: 0                   pos: 1
> >  	 *
> > -	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
> > -	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
> > -	 *       pos: 2                   pos = 3
> > +	 * mem1: pos += 1 * 2       mem3: pos += 1 * 2
> > +	 *       pos += 0 * 1             pos += 1 * 1
> > +	 *       pos: 2                   pos: 3
> >  	 *
> >  	 * Note that while this example is simple, the method applies to more
> >  	 * complex topologies, including those with switches.
> > @@ -2008,12 +2016,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  		if (is_cxl_root(iter))
> >  			break;
> >  
> > -		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
> > -				       &parent_ways);
> > +		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
> > +				       &parent_gran);
> >  		if (rc)
> >  			return rc;
> >  
> > -		pos = pos * parent_ways + parent_pos;
> > +		pos += parent_pos * (parent_gran / gran);
> >  	}
> >  
> >  	dev_dbg(&cxlmd->dev,
> 
