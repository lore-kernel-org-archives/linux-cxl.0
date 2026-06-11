Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AF33C194
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199781; cv=fail; b=fQQGA9xR3TnKK2u0alE1tKRIw04HFGAPlN37se424MzFG+x+ZMP7ZOhN3/VSGChIk0bql/xwTxKDu4uLrwDB6ar67xIhURrNf8hQY6xFpQ2BdsJ7V2i2JbdBBqSk/ecLffQbh7mi/7hkAglJvSalo5o+cBicfO6YsfWSrz4s8KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199781; c=relaxed/simple;
	bh=8naJOTZhM6x/wqqHbyqH9UU9MLixZ+e3y+DsF27iR00=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNjL+o5uCJB91+OBcj3vNsxoSr4HLWJtbugK13jLEXBvxBuEjvjN9kA7G+8bhioPwYJRTTo64TJxQihEIo/iNhLyz62sYw8n1asti9kU4TL9FBPrc3qXvTsYes7D0n1GTT6raKzqi3X3LMndQsgNPcI7AGijU1rpHws2lQqa8as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nabndgqr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nabndgqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199780; x=1812735780;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8naJOTZhM6x/wqqHbyqH9UU9MLixZ+e3y+DsF27iR00=;
  b=nabndgqruROwsF8NAwWamOUrYeGjKTEMAIGOJJXzgTqiDtJOoGwTv7jb
   zY6CvfX52Ms9tH+8gz0zruayW8CtM1luHqUKG1rrRWgPVoOy+gM2clREp
   4ETiH0ZiSbTz0J9Y2Id78/LoemkGGMfijWHU/ZMtaYMvXHycvpxAliLzh
   kPoy/b8d1oe6vBp9PL8yjpJYT+YSxUxxv1onmwlnBzpJxMjlWQF3fgNx/
   y215zDZs3rB7NCsVPEUyMuXy+9eHXpSs6bOQ14Bta3WcrqVtNts8JnCus
   InG+qL8raQudblQOUjlIheZ9R1MzNOHrXFWH7wpSBM0VYytHQL98Dv+9s
   A==;
X-CSE-ConnectionGUID: /u7bd0qRTI2t+whsUzT8mQ==
X-CSE-MsgGUID: NVOE7rZMRkSND3Jt93KVCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82083899"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82083899"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:43:00 -0700
X-CSE-ConnectionGUID: EJxz/wVlSK2eBBWRKoDmyQ==
X-CSE-MsgGUID: R9ROnrTvQ3OdrPFW9ktn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="251643366"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:42:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:42:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 10:42:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzoKbc71L4oVNjiPT+07IGs5dM/zbReRPe/okN3MzAvFXMj5Np/fU4uVq/cUjDAkf4ec7M8J/Mbx14j0Z7iLitr1uHIPpacID24778CJrt1xp9PK25nyBSjMJwyNpo6CSBNPuyAqK6JdqvneSDqk10GQepvsUl9+VeRAJi9BCwSJur8+HWpMIs6Pff+guZVNFHYUokhkI6MinHYtzO1SYu1sxtrKLqr4/kq2hPzESxJxklCG6QkOr+4V5zzr+DfxxcSHzoeFI7vuldqmlJvnMqLxbyWTF3Srf5URIwM79o6/OEoqgBU4tWdW8WcCgxy0FTGeUeuk/UHsca5agwzLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1imyn5+BXCj4wKdRYHVpRXmv0/82Jh8xDpN6qkSj5w=;
 b=wElOb2tU8OoCmOH7cK21Q6GcrS6FwKwyWMxDvs50zR5Zz/eY9Y4jLSZwlrRtVRy13aka1dYtTJqXgA15kzO/dQZc0JNfsMy1O0b+1cd9k73lw8cxFk/ugcTlWlnsgamGEIThqSMrSnJjYnbuMFK+2izje7AEkCZuXHANUjvVoFtcF9TPlbHJvZhJs/p18EoolFmRVgYhg/tlIYqbJGSx1vx/dkSCotDHDLich9QdVtNdjpFRnuBKFFxdukoys5nhaxmvwn8O4uH7vURwX/g+Vl+VPUqyqYJ+AlS+2RZ7K4BunVjHpBAe/7kPxIJoW9fE0fUHRAjwnROOff51BOjr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 17:42:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 17:42:50 +0000
Date: Thu, 11 Jun 2026 10:42:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/6] cxl/region: Validate interleave selector bits
Message-ID: <airzlycL59Eij39H@aschofie-mobl2.lan>
References: <1a8a115cee9eddf5511e4a75f6dcb86783f0fa1e.1780095671.git.alison.schofield@intel.com>
 <20260530001915.7A7B21F00893@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530001915.7A7B21F00893@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: f852db4c-86a3-4ff8-8f8d-08dec7e0dbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BJoyqScS/5wyIqM1W2w9lLKY9yBwftNBcSO1nMo28pkprcwoN2y+iu8Roy29sZ8JupkEX315ucEjpGnxijuhfVlAkCrhLpv3ZQJQ2utHhR/BnPLn9HHlO5sqwi7GrOYxeiU1MJ6PKIej3vsOLS6uChcZ6di8XqYF5iNCT3u7LRTl7mwru+qF57vE4vXFyAVVtBalbHi0HCXR0L/9DfdvuZ/XfMsNijQvhKBbiET03iqur8gN5KGkDkO+lKxqEpdEyAs6BypkCCtqi8sJVJ0R/y5l27Iw9V04eqjoJcT/RnTtGlJsFY+MtTjsFSkZq/VJ6NWIsMKu0bxGQ1C6rUbgJLewa14MTq3doMwLp+sF3FPuBx/6m6223tkqlt6HPAwd4/vXAm4nJezEmGT5V1VahOErSSebjHvCqx6Q/bT+pddpYH6fBMq09l7mrTk+hm1b13KnmT4OcmfS36DRtALQ9pT3lvm4D1y/tRVxBXhDJkr+Vqiw6eyR18f+5Gdp7INtpm6kn5t8zKlI3dZAbNDhhS1oVp7Cn4ZCG3h12WRfaK8j7p1WoSAT558l0nFQzYB/FmKYZyg6R2Y8bIm1fz81DO3KJopLqAv/DoWYCvBKmkGl047Ep3JK0Xxm9CjK9oUbPn1/qGM2wO782N4gISASEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IeAmPTLsmbQliK/4Gm7mj7t4i4/KLobryjKmuZhlXV94SuttXzyq/0qtjg?=
 =?iso-8859-1?Q?/76Pic+BwLhxdZ6AtlhVgEgc+rVn0+8kgLSv7kpzBhv+iK4zz+q46H9Sql?=
 =?iso-8859-1?Q?c5jwEwKKbZnlqJONAa0vuuSjPtARG5AtRAvkbd7J0wP6tXuC1BczPpyeD9?=
 =?iso-8859-1?Q?0qkqIHujiX3wYGsDqYH3s4PlrV5tGNQAYgMCA+D9hv73NbvEO/8gNfjAPz?=
 =?iso-8859-1?Q?TGvpizD5dETarEOudLAbYSIafDah+335W9MU49ON74pkB4hlEfEPYiohth?=
 =?iso-8859-1?Q?SX19bT/qL1UVpjr8uh6EIsU2J8MzEWf/wDP5sU58p42f0qOvRGy9LDgCO1?=
 =?iso-8859-1?Q?MxBzbMBjtM3nn7o+0c2oP1tX9C08Y0U8mFpkbWRH913aoJ0JkbioldThMz?=
 =?iso-8859-1?Q?cTqIRhLJ56EBAr+gjp2KaxUPMT0zVG4LVp7HqxL14ygNOwPKCoHDNRX25d?=
 =?iso-8859-1?Q?ssVoYb16SDUrlLwwGKZgy7lSDnMNFqeulp3YITM+4A8Gou2sYJecmN9USe?=
 =?iso-8859-1?Q?ECVwcLU/W6xHfx5XyKAgQJzLl19FkTkpn8DvP63EFT3RuiNZURdcCVl9H2?=
 =?iso-8859-1?Q?taqgCRF/CdDwKwqQP/AufVH++8BUH1MRxSn5dtqeTgHwkvWwaxmPVkH9me?=
 =?iso-8859-1?Q?T4BASBuX6IcIAfVsXT9iT47p/rnjnO9uVPOTkMCyisG4XD82f8hli8COv6?=
 =?iso-8859-1?Q?j2QRD7O3kxx5MBa8k97tOliQkDI2eHCPZ4GZvI+gGaUydomZSeV77xQx3f?=
 =?iso-8859-1?Q?HoRLWp6Vo3Kh2Ly7WKm0XFQrwlbTapIs5aS1Q9Ie1ykrw8lW6wjTFc14u+?=
 =?iso-8859-1?Q?qhSL5il7Hr/O+GbxK7POjtSRtNr5A074jUn0kHuPJryVtVxivC1enJhaGF?=
 =?iso-8859-1?Q?WHKmzICYItJdr0ML4Snz+jm+/jPa5et4vuuKyB+1vjFnq0vhlPxLJHxU2G?=
 =?iso-8859-1?Q?WtQ3UlJNfqg46M1yshY14p5hKT4AyplXsqSojBl/fU5UTCaeFIUNIQPQAn?=
 =?iso-8859-1?Q?eQN3rBcb4lJdogkLr/3PYRz6gywMabuU1f3qWt8vI8uvSO8DJujsYQANaT?=
 =?iso-8859-1?Q?U5DmPHEGKrAh1ExgIqlQIeZjhdEo/fhbhG5z9AbLelo+QLNz41ofEn39kO?=
 =?iso-8859-1?Q?rLWgDL/APWBSwFglidcvd4RmomOz9aN/l0lWwzt4pocrIAK+77dSPcvDyh?=
 =?iso-8859-1?Q?IOyNATmIhmZ66wzDmFI14MyYwpNSuImdDRNNG3QMQGWg1Xqe/xKQsQcGQA?=
 =?iso-8859-1?Q?DgmtVyk/jAuFptWwoT79PC3kkg+ezKIO9Df5ODrWHagDuAzodRecT8bhhW?=
 =?iso-8859-1?Q?1qkyTMFbdC7lhyYunNaTiXheINOWpydTLLECJ8NRfhSH+JeFak4hXs48oI?=
 =?iso-8859-1?Q?qx6ulK2myPoFIPJXtjs9QBVgxPGQHhHmhLPxtQgDzZeUugYcN/8/IeOKQj?=
 =?iso-8859-1?Q?LZbuJaHw+cGaKUN7cgaESg/s8+4TTlCGYHukG0gIr8jV91Z93agGwLDday?=
 =?iso-8859-1?Q?dx4lclnRtlmEqIw/0E0kKGQauKaKOTe7CbPjgGj9RNdgFI8uQ9j7IjPkjt?=
 =?iso-8859-1?Q?IpT+e5SG5YnkMkM9PY+xhh1cE8W15VViueyx9JoXpsU33Y4937QIyWyJGe?=
 =?iso-8859-1?Q?x7FVF58dIOFYjCIZX/0y8w/Wbns9WFibzUgue9zvMvzByu+sYP5VNn44SF?=
 =?iso-8859-1?Q?mZkL5PmgHS/Gycyb0/OZ9px5THgMo0+B2Gg1oCIMDBlLFsE0NepyplXio1?=
 =?iso-8859-1?Q?pqwCqDHMU9VgohPPG8+PgBpqIuEbZmwVwoJdgnesS/yUfAi+EWxhIh9E65?=
 =?iso-8859-1?Q?cslrppUdwLo39aA93AWCW6tE39+ka6A=3D?=
X-Exchange-RoutingPolicyChecked: Em1+VPPi3sC6w9R+q0w6F7A2a005gQ81pyyIOqvKOO4vw3YPlQa7cVwEjs8n61ER1uqDRdddyzHYfD0R/KRrGJR3/GZs93tHZH/lbHAqSxW/KaFx80HqAtJybmYTjcg9bkpSwCOsNitOqA+shEnBRkvW07yIBa8jkiCBIjwAJ7fExq4riWbp3yE92aK6Hgxse3BG4FJyxYxUn3U5sO4z46aZI0UcM0iaHhk8J5hnvspnm+3blVRuxxQkxJnnU/AF+4Tb6p3FY/Z21Q64Ooq5X6RmrXPai1KU904SBvbA6qp4f4lJMnuBN/jbIu++FcIz1hdbZzUQLY0XUoMgPZoQxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f852db4c-86a3-4ff8-8f8d-08dec7e0dbaa
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:42:50.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO6HnJFAD8e5B0dUdOmyTz51Qq7xUNw7ZuMw1a9mFdzfWTEq8mgVx6ghdmukzH30lYXq0tCIIlhhvoYpXG8Ezm1ysL5y1/731lUjsONtrJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
X-OriginatorOrg: intel.com

On Sat, May 30, 2026 at 12:19:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch removes interleave granularity validation for auto-discovered regions, leaving the current port's granularity completely unvalidated.
> --

This will appear fixed in v2:
- Patch 1,2: Defer the unused selector var store to keep P1 bisectable (Sashiko)



> 
> commit a2adec3549842d4a09c81232586828cb3b57099d
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Validate interleave selector bits
> 
> This commit updates multi-level interleave validation to account for
> selector bits from the root toward the current port. It accumulates
> selector bits, rejects overlaps, and removes the auto-region granularity
> equality check, relying on the new selector walk instead.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e50dc716d4e82..87fb1a9f2683f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -1452,28 +1475,69 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	}
> >  
> >  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > -	if (cxl_rr->nr_targets_set) {
> > -		int i, distance = 1;
> > -		struct cxl_region_ref *cxl_rr_iter;
> > +	iw = cxl_rr->nr_targets;
> 
> [ ... ]
> 
> > +	/* Accumulated bits must fit within the region selector */
> > +	cxlr_sel = get_selector(p->interleave_ways, p->interleave_granularity);
> > +	if ((cxlr_sel & selector) != selector) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			cxlr_sel, selector);
> > +		return -ENXIO;
> > +	}
> >  
> > -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> > +	/* Selector bits still available to this port. */
> > +	selector = cxlr_sel & ~selector;
> 
> [Severity: High]
> Does this code leave the current port's granularity unvalidated?
> 
> The available selector bits are calculated here, but the selector variable
> appears to act as a dead store and is never used to validate the current
> port's granularity.
> 
> I understand this is fixed in a later patch in the series (commit
> 0b56c23b98964cba7ba9487773eeb9e989d957d3 cxl/region: Derive port
> granularity from selector bits). However, shouldn't each patch in the
> series be self-contained to avoid introducing temporary regressions
> during bisection?
> 
> > +
> > +	if (cxl_rr->nr_targets_set) {
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> 
> [ ... ]
> 
> > @@ -1484,87 +1548,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		goto add_target;
> >  	}
> 
> [ ... ]
> 
> > -	if (iw > 8 || iw > cxlsd->nr_targets) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> > -		return -ENXIO;
> > -	}
> > -
> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >  		if (cxld->interleave_ways != iw ||
> > -		    (iw > 1 && cxld->interleave_granularity != ig) ||
> >  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> >  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> >  			dev_err(&cxlr->dev,
> 
> [Severity: High]
> Is the removal of this explicit granularity check intentional before the
> functional replacement using the selector mask is fully implemented?
> 
> By removing this check and not using the calculated selector mask
> for the current port in cxl_port_setup_targets(), the lowest switch port's
> firmware-programmed granularity goes completely unvalidated.
> 
> Could this silently accept overlapping or mismatched interleave
> granularities, potentially causing incorrect CXL memory region routing?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1780095671.git.alison.schofield@intel.com?part=1
> 
