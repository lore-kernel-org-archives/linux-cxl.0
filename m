Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3425B0BE
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773640; cv=fail; b=nhvA0QUiyZooYuiJJf2Ic8bVNyI5Lw89gobN0roUT63cjZH6SImjE4W4y5HGI42hAFIh4KHpx3lSwQnKHpGSZAXKDCSRRHBJxKi6BJv1wwwV6novAp0OOaPzHSQczwd9ggrJW/Jc+U8gECUr90/kz4c4ffl33bIolKtEQBkGrBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773640; c=relaxed/simple;
	bh=68yiYCzVUVPvZZy+RCnEFG8rG4dMqWImWcSG+YTA3fI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lj5Lte8QovC1mizE1GJK3bDbinvL+bZWEjYFceKsAtBbvZadw8cigfxeBPzd/nn6sfmRUOJZ44GsGgUKgy1t+OjaVqrr04qRnmuxDACRfv3qSHp/InLsVxffOu5H3nWvRQg9VNjtVhfwV40+n7jxIXSyUPXx38AIH3Qc7Vd+g9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHhPDrbf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHhPDrbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789773638; x=1821309638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=68yiYCzVUVPvZZy+RCnEFG8rG4dMqWImWcSG+YTA3fI=;
  b=hHhPDrbf1AQuVXUu8Yq/wtkWrk0z/gXFJt34yXWHnyogZJ1CpWqBnWgu
   sf1oL87fpTRAFB5Atmk4+8aGVJwftb6mihYqzKv+MDZd1I9ySi7gbHOKk
   pM67MB7phmDlYLt3j3M/XeaAIY5s8/rkwXx9TCOPeIOUcloXas8rZrdiB
   s3y8+GEHxGpT2S3iALIBRKI2wJ4+HPVcEpNfde5m1shgt81xsAuYBOjoW
   bco6TGw2fM9Ai8kzUdNOZp4QYAXZTm3im9cXgeK47F4ElFZLy7POgzyLP
   qjscy8vEmje/sG2ko7Vw3YnlCeZayYusGuxWiwiQkLvHN5+1XTKThdcY6
   Q==;
X-CSE-ConnectionGUID: g820qy62Q1yROOugv2qw3w==
X-CSE-MsgGUID: WTPmOYlcQgKkiFBYvzN0xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89444955"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89444955"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:20:38 -0700
X-CSE-ConnectionGUID: FJxooH5RRU6TmU9MLy6G3Q==
X-CSE-MsgGUID: F7NbrZSPR2mLtadbQacbpg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 16:20:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 16:20:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 16:20:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 16:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLqncuK4Ur/MVhHwpeaxjMdiF1ijmh22ZovU7sGfdqd8d4eSqXZU1hbo+EiJWxosuKtOQYSOMkAy90h8Is/4mcadu3CeUD16Nl9lU/R/troSKPVbYBt6fFi0dooirp/2bECLZ7fktKn1pCoOptvIZRrC43aYqVrLZNcIpNKwTZLWBD7H1Kw1eD8m5+SNwSmoXgcQO70P7nIHvVCbunUYwmrUEdNCcBRt8dpi2aTFbPbG93/+Q0/mFRcHxYEzCjsCDgZnxxXXCUI1HKUQfkcnW9qA50YCO3yJkN2Mf34vByH8NCHNtRCqDIp3MUllmEDoPGNvMVWlEP7ECu4GrNAyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO/+jSPnv35QrNMfLFZQZsP7oAisDM1VX5qKVcKB7Qk=;
 b=F81BaTXSR5TVbjpc8KNmR52HusflOjL8WaxqPGuKTloIvqvh92Q4oAh9H05phdl2ufmRsqu46JOHndKWhGlHtZze/zlDO36IB7Mw+ZgpPbZ3Ff1wLf/FDIxUiEsSX130tgmsRwMyf0Eyl8xKREBqUSKZGfxBB4349du+6MBdjf9DzLtpsJpbzqbRk0HQ8ZRPy2YTRzywT3HjiNSw1VuntZlyaQ+BkHIfUE6h+gtK/TWo0q4qommOxO7uCFwoqdwYD/k1nOyAk3hh+s3UKYeRLN1DU+7FGiF+W+DaOPsxrwqjRX5hpOHavrFx+VS62xnNYb71qmSw+XMIL1YutB6y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS6PR11MB533224.namprd11.prod.outlook.com (2603:10b6:8:46b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 23:20:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 23:20:30 +0000
Date: Fri, 18 Sep 2026 16:20:19 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] cxl/region: Generalize endpoint position mapping
Message-ID: <aq3HMxr3wt2O6CA_@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
 <aqqkmU98Hpv5xZ9m@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqqkmU98Hpv5xZ9m@rric.localdomain>
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS6PR11MB533224:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a560fbb-4b6d-43ee-890c-08df15db6e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|3023799007|5023799004|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: tbMKsZs6ulvSk7cbj+QCmwDtrz2HjvYkZ8UzhvLYlUuaIBmWWrkiNFKww1aWn7pWqgF5IBzwtAToQJgrHVUqtAq9cj2EZqhQSx7zPz8S8aIgFvmNHPMOUaQurVj0G+NxmH5ssbeYHyBki/NXxwHpRIrCWrV66amj0TUxz5IaoM0F+J9cbDv4pIZhjez0fom44jew6mOY3wsg1VQvrVC49eVWIubo99o3WPptTUnQ87y44ZjAIfEVAiCksqKqD4Nf2eKHpWA5NRFCmGY5KrQ0w8tyYxjIUuRSU45TKNS45RhfYGqECNGuFya10ZEAicdK8BFz5U9D5zbhubCZweoY083HVnjSTAUR+uKrI7Pp5nyjwXAzyDiBTz6UEpWI30mPShdmThOYOUYb3yDOFi1KIT4ibO6ewBsMzVm29hA5KBMOkoENQIVgWzDVQlVXoXlsu+ilfjnBinA3YwZIHR9gXwAZU5RXilOns6QUbevIOws4MQZg5evqBp2zX4K305VacElNDBGO8PPZoSVeXfD92smRegsq3XjvKcwo3AQDRKS7X0qJv/ydtHCc7xAbmG7iQ10iCILSvtb8K1YIoUnAWCH3mCUcwBS6RRzmHqa9y4injeWVPYX48WTHvprQO+QcW+BEVnIg5kZIGfTxyjTbffQO+Zodloei5Xbf/dMQtgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(5023799004)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gPrXTpDME5ay0tmEaC6QSzaI1CzoBJCZiamphf4tfMb4gO4UXEkNbEVO9YIA?=
 =?us-ascii?Q?N4PUJTxNVUFTEgRcJwflWzM2U1igjCv/6zpEZJjGNc6vSZUIrkWpkX30l3ej?=
 =?us-ascii?Q?NS5LDw0+IaTcmT2aaKhpYhRjgTPAq82YOOSt5dkVLnwZrLK68/96FIlfcG9m?=
 =?us-ascii?Q?nGIovKoJDZEhctChaBI3mUNxyaVfzng9SzhrNZszrf4Wf/DH0k/bN/0C5Fxw?=
 =?us-ascii?Q?yOYbZQ808CGVCLCMCOGKKedm2I78KdnapudYvc1ySGYyOvMyI1IzJQpA/JAa?=
 =?us-ascii?Q?5eb0xXMOHbXvV8FetVluixdPJZfizEo+8BAeeTaOYMZkz55gT2mJlm2AKrI2?=
 =?us-ascii?Q?n1uGzm8mRsgM76RSeaWflRGDcHA/G81jzHCMCf/FMaWIvD6Wo9vEQzEAzIqI?=
 =?us-ascii?Q?XwXs1wJ3p8FP4yNTovOP+zO7yM5RWz69xVQS/d6CH0Ix5sJhg9Wrvc2UCt9h?=
 =?us-ascii?Q?4ilsMF0HYeO4aGmFlktGpnfryMyfvaKTUfUe2rE7t4sEpHSF8iu7K0Qi980g?=
 =?us-ascii?Q?SRj8Q4i9TYW8gLuaMwbmd8BnPvUL2ugag/UcyVLRZ4yVApsYwdETmdDKsGCJ?=
 =?us-ascii?Q?Yed+35lhfh9uYPxlOsTHaVZjFNUUoDb2F0Pt/pf6dibdau52s6uotZG5pdJQ?=
 =?us-ascii?Q?B1THo9kB7M+FwYRlivRm8Z4jX2Z7Ctwy5YTaLDDIpk9zu+Ir+wpJTVxTJjzl?=
 =?us-ascii?Q?qpbKli6HP7U5ury3KtuG8tyVeE4nvaOz1uzY+e7uL2ku5e01UJKHEnDvZslz?=
 =?us-ascii?Q?ux5Kac/UhXF1hQO+1P0eFh02Hm1YqkTty+YVyA/BnW1iB5sPsfvKzpH/iaQL?=
 =?us-ascii?Q?JW1AWmAXtq2LhM6AMxY06X7BOyVm5B9ii2XDPehRGQC73c1IBc5OIFNmi03G?=
 =?us-ascii?Q?hQN0lNff3DuuaEnKEY8bEzFIO48yif4AQCipJZ4Ds/WJd/ZqXbeNa3iwBQnJ?=
 =?us-ascii?Q?Zh/H3H/a6rEyxIORFkcGzO9k/qEvQaJy+WmyElGDvDPR85+jgS3DEtWe1Lr7?=
 =?us-ascii?Q?yPC2Vx6xQsB8FWcUZuVT9COaYMhX56Lbs1F3+pXxHXIx2Pdj6axu3/17trIS?=
 =?us-ascii?Q?P/GObVCDbaBjdUe1Mo+qLN+asSMDav1Mz1ABn2QnGMZbP8B95nOpon6FQVMo?=
 =?us-ascii?Q?2lPXXe0m6L+JStUrzPtcbpljki6R7XVZaC4U7lWfRMOx5oNjJJPDeWTCMi8T?=
 =?us-ascii?Q?kbuz2artGjuoNuz1GE0XRE0EI6qoIb+EX0V38P00oJxKgdDsgmALFvMP5qbr?=
 =?us-ascii?Q?4kM1sli9Vea96fhEXBzjKawWoFXeDB/NjN2uEVPgdquTc0tzFfJA6racXlzV?=
 =?us-ascii?Q?LOTAJAIYIGMrLQiAtNXomuKn7ZnSPhglA3FXuCgoiWYR/5zGlJOt6qu8KCwe?=
 =?us-ascii?Q?y4lwSKebCDkxBYnZj3OnYeRoEf8l3iCaRYXgT6e2J614/meuLrGw3pdnwqxp?=
 =?us-ascii?Q?l1IK77Ra8NXIAbtz+d6CeJUl0XO8R8i8g8Fwy+Rf7DRtWxbV07YERGj4ljt5?=
 =?us-ascii?Q?9OoxRbyM5VcFN0mKhV1fho8waqfaEHuu+kPlA9RtF04Id4ZYHSg3C175a4cp?=
 =?us-ascii?Q?VkSTgPeJCFcV0T/M3GFcVYd6d+jUEqMTIT5BK9kNsLbF5va8FiKMyzQCUKLJ?=
 =?us-ascii?Q?9mS02iZGOlkzI/4LP5Hh7dPUTVRY7C3GM1eA4IHSir7fR7S/PVjf/vyMeOKS?=
 =?us-ascii?Q?zmJGVoWPiXibqFHUDJzNN0a6pW88TdbAH7xYHIbxNW1f3DIcAhUkL+YgUJx9?=
 =?us-ascii?Q?FaiYZFi/TQwp3ccemj5gm9MXwCA1uFQ=3D?=
X-Exchange-RoutingPolicyChecked: IsYJ6gxtDRmTK5Slv2elmqMBRCNt7Tu+zUwrA4VhzqcOd5KjCqbR1/QBPtbpKdwXz+4rXimukGPtCK3+n6zyzHe1kAjQ8c89qeO1f1VxFV31UiVAzpBGUrVWunHf1f2KepKFExUeDH2sQsHQUMycMazM3KtrmbawdlMJrI6tkLlvzbG8Q/Y1KS3qt3IIewnBVWz7AAAIUHrFrXcXaBAYbgExYSl23pZl+KTVo6CKYY6mBEeVtdYKphL5YY1jVFjeCM8PYILSmgJsc+GRbVanbQrI6xNj3tj0YelBHXsC+9TTfDRhtmZdd8tDrJ0nr1ewfpA6tvv2yRdDJSdUyHW4Sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a560fbb-4b6d-43ee-890c-08df15db6e13
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 23:20:30.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvcIlTRDGM/VuyLuHg7IMi2yfegooBpCerHCG9nmPgOoAPU2ZJKDsK4TsKz09TUidxJB28RZce7viqJ9EwnCtvfi2io6pRDf1skw6zsdELo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB533224
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 04:15:53PM +0200, Robert Richter wrote:
> On 03.09.26 16:23:45, Alison Schofield wrote:
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
> Yes, that reflects the stripped off bits the endpoint does to
> determine the DPA. Actually this reflects bit positions of the
> selector bits in the SPA:
> 
> |XXX...XXX|SSS|GGGGGGGG|
> 
> S ... Selector bit (width is defined by region's ways without factor 3)
> G ... Granularity bit (defined by region's gran which has the smallest
>       size of all decoders)
> 
> Position can be calculated using bit logic:
> 
>   target_shift = dec_gran_bits - reg_gran_bits
>   pos &= ~(target_ways_mask << target_shift)
>   pos |= target << target_shift
> 
> Assuming target < target_ways and reg_gran_bits <= dec_gran_bits.
> 
> Note: the 3-factor part must be added too.
> 
> A rather prefer the bit logic here.

I think you are suggesting replacing:

	parent_pos * (parent_granularity / region_granularity)

with something like this:

	target_shift = dec_gran_bits - reg_gran_bits;
	pos &= ~(target_ways_mask << target_shift);
	pos |= target << target_shift;

	Plus the additional handling needed for the 3-factor case.


The current expression says directly that a position at this decoder represents
parent_granularity / region_granularity region positions. I find that easier
to read than converting the granularities to bit positions and manipulating a
selector mask, particularly when the bit version still needs separate handling
for Mod3. Also it is using the objects and concepts already present, ie.
parent position, parent granularity, region granularity.

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
> 
> In case of Normalized Addressing, only the Endpoints have different
> configurations. Root decoders, host bridges and switches keep the
> config as is, thus the region's granularity is still the smallest
> granularity programmed in the associated HDM decoders or described in
> CFMWS.
> 
> The address translation code handles the region detection before the
> targets are enumerated. Normalized Addressing should not affect the
> target and position setup.

You're right. Normalized Addressing isn't the reason to pass the region
granularity here. The position is in region-granularity units, so the
per-level weights need to use that granularity.

The NA explanation is stale from an earlier version. I'll drop it in v6.

> 
> > 
> > For currently supported regions, the new weighted calculation reduces to
> > the existing position calculation and produces identical endpoint
> > positions. The exception is a region wider than a same-granularity Mod3
> > root, where address bit routing programs the level below the root at the
> > region granularity, so the ratio derives a weight of one rather than three.
> > A later patch in this series rejects that layout.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 69 ++++++++++++++++++++++++---------------
> >  1 file changed, 42 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6a698f36aa6d..506b1cba1a92 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1806,9 +1806,15 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
> >  	struct cxl_decoder *cxld = &cxlsd->cxld;
> >  	int iw = cxld->interleave_ways;
> >  	struct cxl_port *iter;
> > +	int root_pos = pos;
> >  	int rc;
> >  
> > -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> > +	/* Root target selection advances at root-granularity intervals */
> > +	if (iw > 1)
> > +		root_pos = pos * cxlr->params.interleave_granularity /
> > +			   cxld->interleave_granularity;
> 
> Use shift right here.


I prefer keeping this interms of the granularity values. The division
operation make the relationship being calc'd explicit.


> 
> So root_pos is defined as the Nth host-bridge in the cxlsd.target[]
> list.
> 
> > +
> > +	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
> 
> Isn't root_pos always smaller that iw? Better check for this
> assumption and use root_pos to directly access the array.
> 

root_pos is not always less than iw.
It is the root-granularity chunk containing the region position, not yet the root target index.

For example, an existing supported configuration can have:

root:    2-way @ 4K
region:  4-way @ 4K

pos:       0  1  2  3
root_pos:  0  1  2  3
target:    0  1  0  1

The region makes multiple passes through the root interleave,
so % iw maps root_pos to the root target. Removing it would also allow an
out-of-bounds access to the root target array for positions 2 and 3.

The new mixed-granularity configurations happen to have `root_pos < iw`,
but that isn't true for all config this function supports.



> >  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> >  			dev_name(&cxlrd->cxlsd.cxld.dev));
> > @@ -1909,12 +1915,13 @@ static int match_switch_decoder_by_range(struct device *dev,
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
> >  	int rc = -ENXIO;
> > +	int ways;
> >  
> >  	parent = parent_port_of(port);
> >  	if (!parent)
> > @@ -1929,9 +1936,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
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
> 
> Better pass cxlr here. That covers both, hpa_range and region_gran.


Agree. Will use cxlr as param in v6


> 
> >  {
> >  	struct cxl_port *iter, *port = cxled_to_port(cxled);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	int parent_ways = 0, parent_pos = 0, pos = 0;
> > +	int parent_gran = 0, parent_pos = 0, pos = 0;
> >  	int rc;
> >  
> >  	/*
> > @@ -1981,20 +1994,20 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> >  	 *        |    |           |    |
> >  	 *       mem0 mem1        mem2 mem3
> >  	 *
> > -	 * In the example the calculator will iterate twice. The first iteration
> > -	 * uses the mem position in the host-bridge and the ways of the host-
> > -	 * bridge to generate the first, or local, position. The second
> > -	 * iteration uses the host-bridge position in the root_port and the ways
> > -	 * of the root_port to refine the position.
> > +	 * The region and the root decoder interleave at the region
> > +	 * granularity, so each host-bridge decoder interleaves at twice that.
> > +	 * The host-bridge decoders advance one target every two region
> > +	 * positions, weight 2, and the root decoder advances one target every
> > +	 * region position, weight 1.
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
> > +	 * mem1: pos += 1 * 2       meam3: pos += 1 * 2
> > +	 *       pos += 0 * 1             pos += 1 * 1
> > +	 *       pos: 2                   pos: 3
> >  	 *
> >  	 * Note that while this example is simple, the method applies to more
> >  	 * complex topologies, including those with switches.
> > @@ -2005,12 +2018,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
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
> > +		pos += parent_pos * (parent_gran / region_gran);
> 
> How about squashing all the logic into a function and just return the
> positional offset caused by the decoder? Sort of cxl_port_interleave_pos?
> 

Maybe - I'll see how this actually looks when doing v6 changes.


> >  	}
> >  
> >  	dev_dbg(&cxlmd->dev,
> > @@ -2029,7 +2042,8 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
> >  	for (i = 0; i < p->nr_targets; i++) {
> >  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> >  
> > -		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> > +		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
> > +						     p->interleave_granularity);
> 
> That interface could be simplified passing cxlr, see above.

Will do.

> 
> -Robert
> 
> >  		/*
> >  		 * Record that sorting failed, but still continue to calc
> >  		 * cxled->pos so that cxl_calc_interleave_pos() emits its
> > @@ -2214,7 +2228,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		struct cxl_endpoint_decoder *target = p->targets[i];
> >  		int test_pos;
> >  
> > -		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
> > +		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range,
> > +						   p->interleave_granularity);
> >  		if (test_pos != target->pos)
> >  			dev_warn(&cxlr->dev,
> >  				 "%s: position mismatch: calculated:%d assigned:%d\n",
> > -- 
> > 2.37.3
> > 
