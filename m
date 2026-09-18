Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1C245005
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772485; cv=fail; b=iKga/uIiM+zt4Z8oGODVy7/W1xyNh7YJ3VMC5clIRJ4HBhqbt6+GI20HJdpPjwz0gT1mv70Vvu0ZOR3jiieL+jZpixrynavQWehw8rklANGl5ucF/eNkB/CWjHngeuvMH6lCGQ/OfE5Mqg3VJ94YV8Gl+p8cH0MyBYJImi/LNhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772485; c=relaxed/simple;
	bh=YY6JJjNiQzME39fVs7mueT8r2tbiV3ei3FrK3umKLEo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMqUXNEcdQbxBYHTJRCkKhr2SCR/Q2/n/4Yl9kVJxMc9foZbIgy7rLVNIUn7m6qEKyWShasS8ruvWP5topZAeq9ya8rJnw2lwTjXkH3gR/+LxDdLfjI1Fr8XAB3IIFdYO39woGYorBvOjBZnS8drC3NIW7tAihyXa2wYv2xw3DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhtb+8I5; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhtb+8I5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789772483; x=1821308483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YY6JJjNiQzME39fVs7mueT8r2tbiV3ei3FrK3umKLEo=;
  b=dhtb+8I5z7hSnyz8YJFEATEtXnDJ6MSjOuZURwc9CQCozuBWiN/nifSg
   hNdLUg5sXZHRo8kicIA8dr8jJgN/nOO2vzaLxrTT8H37aJiXRGa2GGYBl
   Tt8s63Bo5vKAcalBIYlANh1ZK6Q3SsH7UFluShyL1ikW9OcRuZ/Axi3oE
   +50JIjHgfPITNGn5TogosspReQGIlKvNyJRxsKLOApC3++ZdeVPbQh7Wm
   3GZwEtJGbUP1HHoOo0Ycli5VRTqK8UmFmeAtL9pU4af9mdc9XLUnx7w4b
   l4g0mmw7A990dV40aVYM8jbzQrUmgJ/8306H0HK2TTnNWfuPH8GNFI3p0
   Q==;
X-CSE-ConnectionGUID: h4lz+5D0TFW54B1gSkXpuQ==
X-CSE-MsgGUID: hbIjogGhQ1qK2KaTiepHZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="77875947"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="77875947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:01:22 -0700
X-CSE-ConnectionGUID: X73brNfIQQe5FEyuqVvv0w==
X-CSE-MsgGUID: g4SJnFC6THuedMDk1R0w3Q==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:01:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 16:01:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 16:01:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 16:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcLrAKT4nqQt5hwYGa1kgjzH80mcouHtlbY1V7mdx4nlpDXp4EPCrkoEiNVjcg9++3pO7DV2kw2NKBHPBitqXKzwTVeqjLFy6ckvpzOv6k7ppNHbgqBsMztDARcxuCAfL5taEKNnPPB44OX3M4FvRRa1zecffkydbKVjK4BJCgI0pUyBkJjf86XkM1gPoxsCpEaRjenszF8cVJ1aGMUx/hU8RVFfJURaxTzFG9Dv3Wdt+fRK/L1utK5NJqE/ZDljCroT+cjtv1rijYxZpA7mO+yFshcv0UwD4B4cAPSY4Z5JXyEf5wddKv5iLCkJfl8bQF56CLgGwOyYNzEyHiyrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNzG04ulUSrkCPyTlaISH83vijBpTTOt5UNKsz7YCJo=;
 b=R4vEVO4yFnsHodDklrSq+vV2XVtZlQIYkutv35X2k5uSqBi05B7t/IGYt/JzaMVNG24VALcBUtuD22fzCq/GmsXii59Oi7giyJd/X/G4Tq+Fkb6MrGUT4dtoylxoOYn0oO9Xh2dUEufN6ubWX2fGHXsZz4TcVLt06IhWzw4MfGGFL+bZ3RNX8oNMbg4/We3pCg9kx6lURbaOHtQWkB9M7Ap/Ey8MrdRmKPz6swtt49zJKnGHgE/v1PILCj/AM0iLbY1e5KreqgWJsNY6ZT/F4aznB1ky/gpnLP8u7wdDYqrsIwsbyWpLN1jzinMyj74Vss2hOG6BY2vitTlWP98Iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9898.namprd11.prod.outlook.com (2603:10b6:806:54c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 23:01:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 23:01:19 +0000
Date: Fri, 18 Sep 2026 16:01:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] cxl/region: Generalize endpoint position mapping
Message-ID: <aq3CvPcUcsqDUG5P@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
 <20260908004207.5875e800@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908004207.5875e800@jic23-huawei>
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9898:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b15bdf-f859-4aa0-4343-08df15d8c07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jSZ4QkXZzMilhAL9uQ9eeUDwg3snx1RdZFCdGLCTT6YYN/kK4XaE8DRlJnM2sBvW/MlaagIPeGojlFd4Imy7Hp/B/m0+tTMaC9ZBC5cHc/ryRPCJDpMO4NdxGqnmHcDWPPYIJ/PdXoqV6wX01jOd4tlOCVoHTdyEA6Nxx5fnItnBa2srDWzerC/lQ9BR44+BHkMiD4UoU2fjkzLNLkWr1n7pgcxbMW+dVXOfuWuSKypxQQbGTxtJtjCq0HtVTsDSEmkNQtktrBhWYpQwjlRic55mekTWjH1/5OaeYWFhLBpsvyGNqrgwGdfDUAUcT0ln7Ts0BoxmVkbbhkW6CMBmkpnKgfjbbqap+9LIMuy26yjQkwgfVbn0jOAJ4xL0kMU1NTpqZvDNsMt6QT3kvAJRyY3jcpjGykYDTTXV0UYeeFUNa0cklCsiRZN4jgfxo7UYifrWf6Dovq4eO1mJANuJ498s6t4oGE4ahTVPFJV/lpyHr6RFPRUW3O0X95rZ96G/CgjFLpgMTpuGYjCiSK7Ty5yaO62EPIjYiqNC9KG03EgKJ1HbChRWcE9n3StFH5b6kKrNiJMXfZineHjOL5CI2FCvl+HWYVG/leM4SFUNRhhad2+D/E7kW+eiMOzIhEnLV0BndB3y6ku3ll3psQb44gu/9rGsZ2bEeXVWcb9XGM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSn0tsPDG5jKoiT5VSKID3OFP7yB1CdTwM3pn4ex/bzuKD38HO9GVbc40CPl?=
 =?us-ascii?Q?C0bwwM23QX8HMUAYzpBCKDDtANBE4UvwZb/NsYMzybF6Deyey3V3T2qQOSOm?=
 =?us-ascii?Q?KthsIRBMf70ypeF+xconGQ71GtOkRQ7te5cG6pdjri72o6npPVW+MfoQRN83?=
 =?us-ascii?Q?0Yq8iCsGuzgr5u/4oRfd+z6lQIGULlB87wWsLikFZoqpsL4dy+sSunFpCQid?=
 =?us-ascii?Q?tefuReB6pRon0389WyrmsImpPg+RFtwSnVLxdiel1LLxXYzZC6VM+IZrqIPc?=
 =?us-ascii?Q?QaGwwoQjnQKUxX5wuGsIdvDH5J3UHyqMPclDhA+LRupnXFIi6AVzOx/bR3Xc?=
 =?us-ascii?Q?TyD/o8xCEyWRACBqfqhApTsvF8nvk70/1rH94b2jQUDy2y+t6uw0Y/ItACbm?=
 =?us-ascii?Q?PP603WR2N0ls5Up3d9xa6JxsZ04qZn1Bc3I+QVIQlvzrpU6rLnMmX2rnSydI?=
 =?us-ascii?Q?YiH9IdJFKKCMOLqKWGKImThU50CgNx2cPl5xUP4eEbKu58FvDvlUcgOM4pCS?=
 =?us-ascii?Q?c6+U4ZEKN5XmjVuhekq3/NM9/ek6taoM0vebhqLsm+jOZnYEcfYHT2GMCPeq?=
 =?us-ascii?Q?LM9J7FDHGW/Jdn7ElH/VS1w2Ny+PXdgmsGMvNZaUSQhiWZKa5D8uFp8KCtyq?=
 =?us-ascii?Q?AjWN5tnGvqqeZsqvaE/GWxrdr+Gj2wB+T9lY4GqcS40kFUj89XcJohVhYiKc?=
 =?us-ascii?Q?yoh/3tN5x4DxY0LEged6Dp46XeNxiEuyEiF6cRjU4v4iwdDS5+Fn26KcnPBJ?=
 =?us-ascii?Q?I5OkAoknS0xs/XIByEoQ8r1OL3J2be3KSa7tYNW7PnuQagyum0Adrn9BsWWo?=
 =?us-ascii?Q?9z6WBKyF/UjwQR/qr/ThaLdRin/t5W7xDHBmW2zZAeM+Jbfm6dq8hoDEH/uN?=
 =?us-ascii?Q?IBXTzd3kTCSnaOhcMMcIuOmyDCfxrE2lTMASYZBpChZF4xJ5UlQo4hkuPZUX?=
 =?us-ascii?Q?M+9HqAxCwMAwlkVxG5C0Fdvv4dF5jJ0iY/a0x02JrdmHHzaRvZDYiV0pdMOI?=
 =?us-ascii?Q?QcQmHvDERlwPooA/Ec6OjUAo06bnlhyI/BLW5PLlSPK40SDGIdN43N5L2NxL?=
 =?us-ascii?Q?OiL2MYa3jEpPvdak0jcsprzapLJV+JyQla9m5W1wJgX2/p8eqKE1+qCVSmK3?=
 =?us-ascii?Q?AppQ710Qv3CPVyeV4h7GX/lY1dbEp9mZJtx1KPv/471DmZOXDM1kUEX3a+6D?=
 =?us-ascii?Q?XOvReujX/ouwl0BSkNjntyLgttmuqXh2CUTFzVj4KdA5Absz2kip1kAAAO7c?=
 =?us-ascii?Q?uuWZCXagLUcZGgJRWtSljWfdbnhYojKqLt3IAd6Qzq5kOcfAxrTl91+a6Y2+?=
 =?us-ascii?Q?PHDTVdGOwAK2SP2cl/cO0oyrDvyN+EuFa6Xpc7wakuycBTQGRDr8dLLaQhcx?=
 =?us-ascii?Q?Mii0u0U38HElUNOE1Dr8yHQFoKTQlvLyria/F3FWvcVyZ5adInBSbqsaWN89?=
 =?us-ascii?Q?C4TEyGD4R1Ysa1iS9e7oyQ+RZzQIEI3D9haGr8B3cD5u94/FmtwqGwOgwnRD?=
 =?us-ascii?Q?u5GonaV9k5jiRH/3CXEOPglw8CgNtJWR3SvSscbCOUIVaxbBDiCHVjkAY1wm?=
 =?us-ascii?Q?Le3LSXhOEp4QZZrMsYL4w+ff0rC27x/F7ePyHJn2295AXBiRBpJziU/mOcyn?=
 =?us-ascii?Q?tJgiJ3UZpAY1nANK/CHAxcwRxUSS41zDCl0SIlEf7pyO9JbhSTSOW8XvY+r1?=
 =?us-ascii?Q?BUL3MluRMQKxcnCFdARWq9so+uCKd9hjjY8roq63S8aHTy5UDAf6P/HrfD8b?=
 =?us-ascii?Q?vy1pxD3MysDC4oCFl4Z/AsKxbks7IJk=3D?=
X-Exchange-RoutingPolicyChecked: upqlQ7viNcaI3to4X5CBYxPXT7evALi3/JUB9H/wGg78N6diLQo1IUhZR0d6sBheP8R9nxjw5iw3Z5I2PoKULLdN6Al8+duzYRhTA7FFwbJB3O+YBWiXx9Nuz4aNRfBV5OAH1UYmNlJjZcDFBh8G2klx6iG6RazHJ0Pc+59DhP9rj8lDpN02zegupzybOnag29yDb7/uL9+zFyJAnccBle6Uhm0otLAIWs7yDAM+Y43qvvtO/2hMe8jqWIy1+XmJnQYs2ya5Yz10/6KnSxb9IE1a4PYsuKqzpgaK8t6U6Rn/MR+S4+wca6eolp/TeXSFRrXk0Q4+PtZUl8fe4i/eFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b15bdf-f859-4aa0-4343-08df15d8c07c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 23:01:19.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xrMqmtsnyqXfbM+yCS+Shx5CpoFVgeSU9ZNvyuwFICOzu3bD6coStf9m9YjkOSmFLs+LHZoz/PmMZTJZZzmdWbcvyvg6OGo+AT38M8jFdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9898
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 12:42:07AM +0100, Jonathan Cameron wrote:
> On Thu,  3 Sep 2026 16:23:45 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Endpoint position calculation currently relies on the requirement that an
> > interleaving root have the same granularity as the region. Auto region
> > creation builds the position by multiplying by the parent decoders' ways,
> > while user region creation selects the root target with 'pos % ways'. Those
> > calculations are sufficient under the current granularity restriction.
> > 
> > In order to support mixed-granularity regions, that granularity restriction
> > will need to be removed so decoder granularity can change between levels of
> > the interleave hierarchy. The position calculation needs to account for
> > those changes to produce the correct endpoint ordering.
> > 
> > Change the position calculation so each decoder's contribution is weighted
> > by its granularity relative to the region granularity:
> > 
> >     position += target_pos *
> >                 (decoder_granularity / region_granularity)
> 
> In the code target_pos becomes parent_pos. The parent_pos naming
> seems more logical to me but maybe I'm missing something! (more
> that likely given it is interleave maths!)

Agree. I'll change the messaging above to be parent_pos.

-- Alison
> 
> > 
> > Use the same relationship to select the root target during user region
> > creation.
> > 
> > Weight each level by the region granularity, passed in by the caller,
> > rather than by the granularity programmed in the endpoint decoder. The two
> > are equal for most configurations, but not when Normalized Addressing
> > leaves the endpoint decoder programmed passthrough while the region
> > interleaves.
> > 
> > For currently supported regions, the new weighted calculation reduces to
> > the existing position calculation and produces identical endpoint
> > positions. The exception is a region wider than a same-granularity Mod3
> > root, where address bit routing programs the level below the root at the
> > region granularity, so the ratio derives a weight of one rather than three.
> > A later patch in this series rejects that layout.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> I'll assume you'll clarify the naming thing.  Otherwise this LGTM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 69 ++++++++++++++++++++++++---------------
> >  1 file changed, 42 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6a698f36aa6d..506b1cba1a92 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> > @@ -1951,24 +1959,29 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >   * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> >   * @cxled: endpoint decoder member of given region
> >   * @hpa_range: translated HPA range of the endpoint
> > + * @region_gran: interleave granularity of the region
> >   *
> > - * The endpoint position is calculated by traversing the topology from
> > - * the endpoint to the root decoder and iteratively applying this
> > - * calculation:
> > + * A region position is the index of a region-granularity chunk within one full
> > + * pass of the region interleave. The position is calculated by traversing the
> > + * topology from the endpoint to the root decoder and accumulating the
> > + * contribution of each decoder level:
> >   *
> > - *    position = position * parent_ways + parent_pos;
> > + *    position += parent_pos * (parent_granularity / region_gran);
> 
> Here is the naming difference from the patch description.
> 
> >   *
> > - * ...where @position is inferred from switch and root decoder target lists.
> > + * ...where @parent_pos is inferred from switch and root decoder target lists.
> > + * The multiplier is the weight of that level: how many region positions pass
> > + * between successive advances of the level's target index. A level that selects
> > + * a single target contributes nothing.
> >   *
> >   * Return: position >= 0 on success
> >   *	   -ENXIO on failure
> >   */
> >  static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> > -				   struct range *hpa_range)
> > +				   struct range *hpa_range, int region_gran)
> >  {
> >  	struct cxl_port *iter, *port = cxled_to_port(cxled);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	int parent_ways = 0, parent_pos = 0, pos = 0;
> > +	int parent_gran = 0, parent_pos = 0, pos = 0;
> >  	int rc;
> >  
