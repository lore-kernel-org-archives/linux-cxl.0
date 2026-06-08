Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A00367B76
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951108; cv=fail; b=ieywqIh/4gIAadHAYVUobY2gxg2pHeWq03eyXh9EfjyOGE/GrR8jR2wKWZkSvvScqLDKYE4tEhv/3bbVnX7WYDx6gOkIs80YIpWqN955/7w2E5UP4jtaDAUmb4u50fCWqMnJKLt8PTEWw3KChzLHMfP1wTF89lcl4Y/hs7OGaBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951108; c=relaxed/simple;
	bh=aa4idgm14um3kUjDKAD5K3+78fM35gReGvUbJ1XLJHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ci9gwzlONLPn8kUOlGy+nm6AGoThn9f78vFUd7DsXGvT7gnUTGoxiMJTwfs/c8cRcG9YH9P4wWflEAo6NeBnFBTVnYcV87Ys6f1reti/pZ+QT7Wbr77KSK3JMap12elbfVRrRRK1zRLC6QpWEbK6uSDMVJZrAN4W728L6TzyAHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ny1jOeWQ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ny1jOeWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780951107; x=1812487107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aa4idgm14um3kUjDKAD5K3+78fM35gReGvUbJ1XLJHM=;
  b=ny1jOeWQJKpGfnMg+RbJFpwhBxTavv7u2qyxkz3MS9XHokRwq2w/uZGi
   1fSm0w1FSyszmH219Px4rqR8wwCiAmtATlzBiFjwuccPlRVFRMx+KENKw
   SBUj565/8bHOJmrQKk+svk8tvBov8Y4LY1TGOeKD/cAvNmXpE1uZ8wKEh
   VtL8PSyhEwF2A+6hO3h0x7HpycJar7PyOYkfmkc8jcEd74t7aBoT3SikR
   qVI+ejdleNPpEorrbhVeUUDY4LI2bWH4oEFNhNYuuia+H7HWN79wYzFM8
   pldmT9RZ5JTNknohauVG1r2x/gPojOXQWRABnce1uTwNgOiejZYr6Fj7S
   w==;
X-CSE-ConnectionGUID: X9t3kFxBQIWqXcKfMV3nog==
X-CSE-MsgGUID: 2b9iGwloRSGzOdxaIsYJOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93187579"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93187579"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 13:38:26 -0700
X-CSE-ConnectionGUID: fzCfmY/URhuToaWqHhS8xQ==
X-CSE-MsgGUID: nCN8laAeTrKydhliwrMkBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="250575091"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 13:38:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 13:38:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 13:38:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 13:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lERyVpUMN0EDgRRCL8+qm2aBpzZQBXj5TfjwPGB4zcprCz/BnK0x1wGfOT/C2HOJym28CPXyIu9tLw8SflPIXcVHxjy0RNrdrMa/d4kjHEzADpMAzfuy8O1WmmebZs2Fo5nX3ERaJ22yVG3g7/YOTzgXHHi8Ia2vMhlAZxJBmrYpPqphLccvGT+7PTLHzkl0xVYoaBy3seuZyEumzlPph45bAYOKFxEf5oy2JSdviePr6ICKM+FjO9yrbMGxYPOmT/de8wSE1Uiowt9rtRbw7+Mc+sMQbLCNWVlXEMB4CsybN/yC9O/z/asoA62EC52Wqe1JZqN54wZWa9EjKj/+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q9prjLdCSgApfLIqC8b62exZN4f+ypcqX+wOlx8eYk=;
 b=o1fR/KScliCpmkNagtt1NzdDSG652hk3ZmuUBlJ38+72qJ89o3NubcjgLlf1/Q+kcth25YO/g16ZET9KV7bMv8QQXXxIGgzbCpsyJLUF8On8qRl1yNuSzlXsHJu9eWGv376XwXw1inmKbw//YU/i6okjyxZZnVULcKQWEjzIJ/5xpzHpbBVfTyjyIqnZ/q7v21KE5YCr2J9GXWjE+C0KJ5bJobSc+4F06TtMg1b/th7++k/Rr4EJnak1rbgWlU9Y9fWFCsT48wcHG/JG21trKq04MCN73VT1J90jDguNcdGImlYwi6ebjJjZuI5pEs04oR4BT6Vs7dXf3BzYapcq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 20:38:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 20:38:18 +0000
Date: Mon, 8 Jun 2026 13:38:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>, Robert Richter
	<rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/6] cxl/region: Validate mixed-granularity at sysfs and
 attach gates
Message-ID: <aicoNnqa4cpsSAyF@aschofie-mobl2.lan>
References: <cover.1780095671.git.alison.schofield@intel.com>
 <aad9e586a2184f1e9a1ebec04c3809edc6268cbe.1780095671.git.alison.schofield@intel.com>
 <94fb1064-b476-4990-ba5d-b03a7245395a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94fb1064-b476-4990-ba5d-b03a7245395a@intel.com>
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1ace7b-8245-45ce-4f1c-08dec59ddf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gn/mDVbUjZPVSHntJS1cQDh2HqQ8UN7yzXTX3onCPbstZJmNusKWof6+u8ObmJEbHifNqn6vEY6nj/3NH+aWCuB8/UoSRxtNSpygseiW/EneYRD/wibIaruv84jQF0TbPsEFoRFoaEfRans5xzNQcYBaol+1I+DXP6wDFYQbJY9/yA3GcIjP0A08dz7miCwSMaFm71k2S3XJCS+FBlJWxA0z01Hwvem00Au6L/PfOEeKO+3svKKYbon5OP6MAGVUZyLa1/xSIUCkozMg1xFMw8CMlGXVFIVf2ts/IYlqjy6Bux0MrwZU2ZsUkvLhicrXxy0kC6g/1TVndrr5YXNCwtFaXr02zUMKzbFsSq/ZXUqIO3cnlZoU3f2j++p/qAyDv2IfPdvyOpEFcM3nGgA5SkIqvqFw07sOEZxi38FmNpdR9GKd6RM0Y8GqkqvRDOLMQGy/6kQO3Ns/aHaQc5f5AT11WnBouFlK2Npt5l9H9cKyYgma7wuW44BMoZcXbDltax9dZopKLhiAGEyzOi+QL1/29dMOqJXOkJDIi10l1bIGUgK0EF8rdxtUQPIeqH2SPfnMsW2/vhpkw4bEBsl6xNZ2fwB+lHL5cXnwOQafuuxd9WHshSdaq2lhYYxhy2ahUYZPGi29XxE8ZqSZQ52Zn1+sod5C6JAlPZiA3u/yepB1z31DGAnDTFAw8Ifoi9tc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VgDVszSWZFYVGRhXMA4sY1Zx2eHxY4a/yLZFvBMxqGl2wmMfg8d2i01B2+F?=
 =?us-ascii?Q?vQmkURaUk9cT6DJaTsKLs//UC0wEdY0mmOZBt0TQ7dE6ZPgYw/JDIGPM2FWK?=
 =?us-ascii?Q?pVmUJa3WigQimD9OInMOlXYFSEaU9ByUPGMYj4j1sKPcM79ifMZCVIMPrCXa?=
 =?us-ascii?Q?QMKlhFnIe6lQt9esexYqzzlQHl1IaI6djPCZ7IBKFDfo6Jymjmu3eXB9pRsj?=
 =?us-ascii?Q?O4C/cERrsWCtyNLCd0KepL1TLz8SEBMOK7Ps8VDStaYc8V0HzEI1QaN2UEcS?=
 =?us-ascii?Q?6zbzsMR7gJGcEHRfJ7Vv7ZWcekOaOhOetJcm3SJMprx5NXDMiknj1iYzakbS?=
 =?us-ascii?Q?V0nrUeyQXrBzFBNjuCg9izGv8Cogyh6SdF64xgyU9c5mARgPP/xLPB9thAiC?=
 =?us-ascii?Q?Unxx3u69xhedLLGzDRZAVjikiTe4whFN9MrP/5YjubqSQnffSllcFnnIpgul?=
 =?us-ascii?Q?eWPU5UJll+bzCZOZWzXLGVqrKFRQJp1bWjwEPNEM2ZqxxUqBH7MxdoFGHo/Z?=
 =?us-ascii?Q?IWDqCHAepTTXpTiiNmMhjxG/0mAgrssYZQc/FPkKk3/vNA/2TW3S1Bw8pyz0?=
 =?us-ascii?Q?61TTFwxn1UkRtSv6DK/R/7Jb4QEpvtIgRIMowK6l21OTJ9LKTgV4Xjs0ZsEv?=
 =?us-ascii?Q?1LNPM4a90JtT1pxFwOUYYF2mB72q7kax5gCif1m5XO+Ggk5K11+7rhiajnWx?=
 =?us-ascii?Q?a2/Z7vKsrOQCi922Fpx3kIrD/zHJk/O36QtQgLrAo+kqcDopyVJMrU9phNIE?=
 =?us-ascii?Q?ZUEgA/benBFTsBldoWXWc/Uv4vIGNuEh+Li1dJ1UxG10S4WCRPkQsnlCGB0w?=
 =?us-ascii?Q?Qdh/ksKGhp61caA42Gbhi9ez9j3mtPgD7bSNL5gDLOF1KZGQYTr8Lx/ynCwt?=
 =?us-ascii?Q?F2/xUSIJaUTLELDitltkarUDBWUL5A+f2boiqgQBwyogoUs7j5L3NuYc3YRO?=
 =?us-ascii?Q?TQ/4uBFtRt/LxEAenn8QtaWT3knEQU0UKmjFUmPe7CyyglE0ma652mzdoiHc?=
 =?us-ascii?Q?TQuaPVPOSKDe3PHGwira8k+89ZkkWUIv7AiP2T1r6fWsncyoJ6UIbq2MbTlj?=
 =?us-ascii?Q?aBHZ58zX7xX2lPsx4zfgSSonr55BebxxWn6xgriwY/B2+9+yUzhZ5Eg2yEw5?=
 =?us-ascii?Q?R07UbzLTk0x/bCqfk8Q4TNxTrKJcJbEyXs9rPpizZN3S3+ZvoNRw21gXT+w8?=
 =?us-ascii?Q?It2uqPteYuYKuDYLtM6mAZspjNEC5fNnMCc3+qNUFO+n5JxqgfvtphF22lRx?=
 =?us-ascii?Q?lyLZcI6pBv+awd1ybB7huYgOnwLZL9gQ7qk6GlhzonPv1lvZZpYkIQnxVbJT?=
 =?us-ascii?Q?y1SeU+1mEBcJdcalVtdlctW5BYCD7uzfReTgOKehHlH0jgBXFUgURzbv3YZi?=
 =?us-ascii?Q?U+CoQA3lnTtv5T1y+iGTnEaZMxMA5jZtnidABrv7qbUycou7ffjJcFRCeUTw?=
 =?us-ascii?Q?zARRgNkIF5VdQVIEP+PaMr9npu0+gt8n0U48E8qfUxVnf16QHLgzpV+7UA/O?=
 =?us-ascii?Q?aFM5ou4aJYgWQLfC9BldGvDI0BSMJgeQmv1Ouqzd8I33RqyJJGZrzNzm1OeV?=
 =?us-ascii?Q?77Cobhj/DvuFpMyp5Mv2YSuwn56b7Z43xJqWhRUlBY4rdx37ITzoUM2ZdaBS?=
 =?us-ascii?Q?piZXz5j7IFlztnfPQ+RoIJP+Z+VxppRQe9NAWGcim/McGIy0+7Cz6CtMTPDS?=
 =?us-ascii?Q?AXu37HNizRNs5la/+FqyibAKMX6LAj/STXxmWBtC+xaH2fXl0ft51kxd7MuS?=
 =?us-ascii?Q?95JAWVhWC0UmOFw+Mj/i14sQ4tGC/+4=3D?=
X-Exchange-RoutingPolicyChecked: cIeuiya2FzWQOeoweYKjVVrU2pb01P6V9D799xFMACr6MTLDh62SDD9SoLWh7w2edJFj62K3QiWyuu6T0BR1IzRHXidG0zG9DOuUm/1zooQM5lhgbB9HJyKco23WlHswjiue8zBHqyXzl10XEUD/n6dJHVaIprJxM5muX2BDRgNSRwopixXJuuctW2DZRVrebAdqLgRRGzL7hTgPC+eYc509qv5wYDcWydFlzLfoMRXts7EZVjwkt5vYeQ7BFcuLk7Jt09POEe8YvJs1MBUNTAYECzoJMsA5hgId26pDRty8to4wrKnNG5HteZJm0qGN5cv8SV6NKL7z9bSXI+qIFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1ace7b-8245-45ce-4f1c-08dec59ddf32
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 20:38:17.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGL8mcnZLzSTNHFz6NsBwFmTz6879I6Am0ig4Ls8bvcGrAKsjQxcsqO70W1rmpZCCDN0hLya2HqmNAgdrTVXhIK0qADJ5+zo2ZKE21DuA8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 04:55:30PM -0700, Dave Jiang wrote:
> 
> 
> On 5/29/26 5:00 PM, Alison Schofield wrote:
> > User-created regions are validated at sysfs write through
> > set_interleave_granularity(). Auto regions skip that path. Both
> > need the same mixed-granularity rule applied before the per-port
> > selector walk runs.
> > 
> > Replace the same-granularity sysfs check with is_ig_allowed(),
> > which permits any region granularity not greater than the root
> > granularity. Call the same helper at attach time so auto regions
> > get the same rule.
> > 
> > 3-way-family roots (3, 6, and 12 ways) need an additional check.
> > A 3-way interleave consumes no selector bits, so selector containment
> > alone cannot prove that the root and region cover the same address
> > span. Add an explicit ways*gran span equality check in
> > cxl_region_attach() for these roots.
> > 
> > Endpoint decoder capability is still checked at attach time by
> > check_interleave_cap().
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> A nit below.

snip

> > @@ -2128,6 +2139,32 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > +	/* Apply the sysfs granularity rule to auto regions too. */
> > +	if (!is_ig_allowed(cxlrd, p->interleave_granularity)) {
> > +		dev_dbg(&cxlr->dev,
> > +			"ig %d incompatible with root ways %d ig %d\n",
> > +			p->interleave_granularity,
> > +			cxlrd->cxlsd.cxld.interleave_ways,
> > +			cxlrd->cxlsd.cxld.interleave_granularity);
> > +		return -ENXIO;
> > +	}
> > +
> > +	/*
> > +	 * Selector containment cannot prove span equality for 3-way family
> > +	 * roots because a 3-way interleave consumes no selector bits.
> > +	 */
> > +	if (!is_power_of_2(cxlrd->cxlsd.cxld.interleave_ways) &&
> > +	    (u64)p->interleave_ways * p->interleave_granularity !=
> > +	    (u64)cxlrd->cxlsd.cxld.interleave_ways *
> > +		    cxlrd->cxlsd.cxld.interleave_granularity) {
> 
> Looks like cxlrd->cxlsd.cxld.interleave_ways and interleave_granularity used in a few different places. Maybe use a local var to not having to keep referencing them?
> 
> DJ

Yes, I think I can make that more readable w local vars.
Will do in v2. Thanks for the review!

