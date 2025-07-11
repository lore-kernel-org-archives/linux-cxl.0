Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39F199FAB
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259333; cv=fail; b=pt56WERjGr5UDk71HnX6bm+KtXgjGLPFeyW8ArIGH42/V/szhYnWl5+KFvmnafW465rIpVGJ1qedODcPd8ao13wO6aMVr7+8A+PkLzcSD0cWTaQ3rXclDqK5+4Uytw8CtIqYyYOc+Zr/aiv4mdsS2dkpe/TTrpgiX8l6pKEmHaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259333; c=relaxed/simple;
	bh=9P9ridcpcR8flLnvZJyEZyoupNFwB14VL+OVkvSjf8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASix+mIfWbhkEeWuJvt25uhpYF6YSCfU/MEVBVQLznUIcysLLLmXJcn5qJw/KCn6FafMqMjKFrsbFe7aU0lB32cCz+clzJvp2avyFmWl9uTPurxXhn3YIJC7LAWLiI4iQZbDMXyal6uQ8Yoc2mLfY+BX8XNv4NWnDV6/bef5exs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQPjaqhm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQPjaqhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752259332; x=1783795332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9P9ridcpcR8flLnvZJyEZyoupNFwB14VL+OVkvSjf8w=;
  b=XQPjaqhmSZhKcxgwhtCoONwbVwlSLq/ydO6+dYkHJq+AsCvjTGHediKx
   I6DdxkhqJ2i6H3Nfgsh/v7UomBge0FaVQNpFAK+E5tj5aRsUVDOhu1jvM
   FVtqY61Xg5TinIxbzZb/9mziJp1rZDNMje6jlYBish2BhVIW2mwwTZfX0
   wIqEZp8AeDkBAFHgvd75ipjczydSIb35v/6ysBrO5b+OfErs2MR4SSLj/
   et+4jCk/gp31R3ZIKYFZn35lgFfFk+x8jFjwRYjTJx63xq9fec0mJK+2S
   JgI4VbX0EpZrmAnwtEHD4/QmdxuNxDSQyHUcxPPKnvzzs+tTQdhoM+dQg
   g==;
X-CSE-ConnectionGUID: K8US/C1/RD6eHeJLOo3tQA==
X-CSE-MsgGUID: 6K8TmkSiS62mFIbmYQtjlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58326442"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="58326442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:42:11 -0700
X-CSE-ConnectionGUID: dQOV9HGkTHClZ4cAqF88+Q==
X-CSE-MsgGUID: NRgcwnGQTbmTvWIyt+0kHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="160763404"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:42:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 11:42:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 11:42:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 11:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMrBR1LoPXJ571T1Iy5T9tMWTtSb/GxYkYvNjaV6i2pUVB5BzkqeVHVHCyPYfvDyGZtZiHKuxG5HfdVnqEmydFHpuDB1irKReR1FoZF6sVNUUqay0dJU4sR/q3AF0RFHH+Xi9ZgMA6KwMGWFZ/6zQ8fGPczJ7+lWhsyRQupT8wxCeosUtr7Q7NZ9BLXC/ccE3ArYADfqoxpNpZOzRAo2OAnCPNA1WsKMrr0aXDv9gEunSG3wTtc934v+mdcSDr9jee15Fz/qNzRAxaz+XU8jwe09nHuNqZcrOXKS+66X2pgX5/blVCPKvdO2XFkDahcplzi6bERf2sxInqdI9+Oiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+P96ffaTwo7GW+qAGZJCzpu+cq0HxPC+v5F6uBzcac=;
 b=R9G3zCS69jbV4Xdx+K2Fo9+CsIn7oW4EkCPy5rXMCMtb+TmQP8dS7Ln+xqzGEiDAIl4NN9NfavLy6SBbFOtMxiBzMBYwdEXBlIMay4Qfuf2O6KpVZ1kF3k+TYXJc0CEuVkLC2HScRKD/Y6DTumtj+jQZspdqUvnjzgMUf/u4krI0erjwl868+r4zi6gypdFVbaH9UDinXNcT//M4Zb0EOunPC1BZE3A7orbAnLPqfmnOK9N/RbFmKj5m72CCcMwVJfGuOjzhPH+e9EVtDt7cQbp1prtBCS3CFIb270vf/X+hh4JHTtHw3e0HDk1S4Lb7gPVqttxnryq+fjnQo48IPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 18:41:23 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Fri, 11 Jul 2025
 18:41:23 +0000
Date: Fri, 11 Jul 2025 11:41:19 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add hpa_to_spa to the root decoder callback
 operations
Message-ID: <aHFazzPSfwvymGZF@aschofie-mobl2.lan>
References: <20250709200746.2567860-1-dave.jiang@intel.com>
 <20250711174530.0000291a@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711174530.0000291a@huawei.com>
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dc4d99-8ce5-4790-5e4e-08ddc0aa8910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/A43fKHeyHu2hyiWBhWNQYY6qy++jjfWiuM0T7u+VjnF+1w9gvqV60+AJbS?=
 =?us-ascii?Q?32Zpk3zDuJxAnl3OKsTKbNjNDunaoDxYJ0uTxvTRm5wsjsLiPA8Qs1aSvTNm?=
 =?us-ascii?Q?lTfonT0JXElOtlnljEsi2EjK1Wgcguez9yrMvVxx3ql7C4YCcgrutujXtrYb?=
 =?us-ascii?Q?SQ0LT7wdhr5z3TqpprQQ6x8MQON3Zwo6KVhd8ZEFeqBX7Lz+VepQ7YgzfIom?=
 =?us-ascii?Q?bbHJrr8C63APLcL9UausAX+uGrWL0KmyZlqfssHVTLRnqydOVximU5flyfwS?=
 =?us-ascii?Q?78tKKK2ftSlHn5RIlLAS1CVFUQQgymOQR2yVIWbrW1PPK//6lDIe22bk/lIP?=
 =?us-ascii?Q?PvyzMkgPxfabO2/kw6Tou7Akg1C+u5N9B4kgnzmyetCGVVe5O6ghtOKPpKzu?=
 =?us-ascii?Q?C3RkqFo+DF2IMB8aqi/3tJY7r1NadAtyza/3SOEmNuh9peguCJ8+7uMOnC0C?=
 =?us-ascii?Q?jaDAJKuiPdIGzgvXUkOFEyq23v0IepLf+/fBhEHMgjoOkmgDupZpfbRP0IQn?=
 =?us-ascii?Q?ATly4/DoeQTMBcIk5KVW7UHpdXqqdwt74g4VoGfG7WHE/TAi2mnoKU4ktG/+?=
 =?us-ascii?Q?05XNywQePK0KB7DpUaJ0BWlgiUv2Ez4anq/VDFINPtEr6PzcHP/4oxWU1uaL?=
 =?us-ascii?Q?dQ+e2TyqGQBD0Cz40y08c4GSmul61J/v1tfBRV1EbRUVGG0thDkl3oluitja?=
 =?us-ascii?Q?2JnsoGNslRlbyqoaVJ61eN7nOvXHK4UmqnFRBsMSEgAPS3L3ciAPrJPrHxHY?=
 =?us-ascii?Q?SEIsqEGVq1JhvnIvs+L0L8chyRjNvAALAdpR97JzeJHDSeXKQNhirSoDB93a?=
 =?us-ascii?Q?PYUFtY2PSUzknUSBp89PN+CvH2WuX/55p/i1/adcLyQb6aEuwM8uLxDsV3vX?=
 =?us-ascii?Q?urSR15myjL6ML22hZMJXlXKNZRUSDHq81Z3773JlqdnEb1KyoxKxMPKb1TuG?=
 =?us-ascii?Q?BVVIultAEKI7RYIw6FcLyRkpdLXkhWLqTy1UHKg8SEcJZiO8gEls5jK3f4Oy?=
 =?us-ascii?Q?tbPlA69YEqumB1PnuRoS4PTp/PClyaluipBzf7jg6e7B2QpYWh83p3ygc1PN?=
 =?us-ascii?Q?rxCOp4yKtdswVyjSTYovR+7S4Cuv24dN4hunwqseo2lAs0K224f8igrdPRIT?=
 =?us-ascii?Q?rsxyWXfl4n04Daz0bCwYXRCKOFz6W3mgY4l8UnVq/JdOGN2BZ4hqk3H2GgKR?=
 =?us-ascii?Q?Uwjj1nC/Kl4G3CICpbC1RK9V7vsB4VWlFI5VC9g/lYP4ormNgdQdWm3awj55?=
 =?us-ascii?Q?kYyP0TBhj5JIMIkilvApn37nHyQ5xjaz2ax5l/yYYt5FsRGkIwagUkBXTJUf?=
 =?us-ascii?Q?08AsEKzTPTr7CkGY7V+OcbBRIa4IdfuWhcls6ZlAV9/MPK5s3pkt36DG3nLi?=
 =?us-ascii?Q?7HVfjye4VBc6iumrjnJEycZPPkKmOuT76kthzEekXw69CZXi07oTt7wHEVFx?=
 =?us-ascii?Q?j2d+lYy6PFY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nx/fqXvrFUycY3ED81m6kAwRujJRr7Zrej+fXL6Yqz8w8rK0D8LsRZYvyKq7?=
 =?us-ascii?Q?tOpyoEqNIknKTyWtKnoWr5IaKiD2honSjmzrHXtpG/R7W0aSe4GGojNTfuk6?=
 =?us-ascii?Q?Lvjwyo7FlNQ++6paghjKJIetESJ2VQOW96mBxUrM/jAtymTIVIkx7lCIhmmF?=
 =?us-ascii?Q?Z1JwpJMI88Eqtjawxy2ZYsCLdfxMKQ2nh10RFF7Qxz0WF5+46LjBPKQwNy6p?=
 =?us-ascii?Q?zxiyteK50IYT2ELg4EgWw5jc7xRrXL8ldLWiKf0dBRhuahTQl4kos9h26RBB?=
 =?us-ascii?Q?I70oKQ6Lyj4QfU4cOHfl6oYBAHIBh4B0rSvI7jGrk+5zm9cxPCpbx8Ic5gix?=
 =?us-ascii?Q?aEU2Lj6qZD0LguwRDOz7ipY9YzPrQCNGrKfP/J8Gae280z5C+YC15BGcKseG?=
 =?us-ascii?Q?aAGo2/2tR4hQeEZJ4LRUnfHIdMNiQbDEwQihVMHkPHulhrFme+Rsv0Q8ueJZ?=
 =?us-ascii?Q?OYI1zVRhCtZ2Mr/LOIUaBKcbZzRaf8GrFQS0CjEDK+rUiyjyZhyiIudOAvob?=
 =?us-ascii?Q?kUBy92Fr0oljrPjGEG2NNaWMU11ea7vT48VB4IkhttJzUtt217AXEEcG5wCc?=
 =?us-ascii?Q?kzoCPkQQRzDA7qU8dIjdrzU5FsZLzf2SVgtxLTjB5tNoD8o0jtthCPFYjKFf?=
 =?us-ascii?Q?/hwaCMew56LHyTLMn6EQut4aSp8oBkxztGa8thST1Zt0Qt+t3F9BSlnPEXYE?=
 =?us-ascii?Q?YI+X/hk62r5mmK9Zae1qJKJNdv0LlwYDkgU0JUAioeWxLWJdmQZPVu/TsIFf?=
 =?us-ascii?Q?NaUHFrFIyPzduJHR7ugKqX3r4gNicR0kx0vu7YlJenawmiolxtmv415E6tMo?=
 =?us-ascii?Q?xtC3tG6rmxf/Uo0imhnBb9b2ZiybKDczwR7tW9LzLlherGlBLpLaaa5XrQ/3?=
 =?us-ascii?Q?2QXyigEGPNpZ4XWgcY+4jAnuB+FEQHP1zRXhm27pvX5aFwiLj94/7L2nMFtB?=
 =?us-ascii?Q?vqlPYBNi2kdpg/uJAmGuQni/l4iw2YKWnK9aoHOrGSTaD1dDGQZtC4oG+0me?=
 =?us-ascii?Q?L6PRnKgZBlMUEYNDm0jFlbImu3UiM+MbD7LousTtM0eyrqiaWSz8nhBxcKXm?=
 =?us-ascii?Q?tE5U8hsvAItUbt0aIn2KQMa/KIvT7jFJDMGvMRl8/gGL7I0W9IM06C1hnVyJ?=
 =?us-ascii?Q?lqqwpex+ya7qJgVNp5g1oZAuRhnWd8/nasT552KfryYgD6TJiN2qiJ377rDy?=
 =?us-ascii?Q?vM3/eAo71lKlumiLBYE0+peT+LtAUWKW2QwYe1NuE5yKbi2leczjaUZU6OkO?=
 =?us-ascii?Q?IIHTrfux7jajO1g71brBtekZT7Xp80ru54IBpBUpzCn/YaYL8yO7ISO5P0Ts?=
 =?us-ascii?Q?HqiEnimrYz1WAE3xN/6JTDu9FWBFhsbMn2fovyWNwTrfqVq09FL5DCnBa9+m?=
 =?us-ascii?Q?eGHUFLCg/vOHgVgD6DAlAJSyIIFjst+TEd6V6M2cxD1yHLQwM343dSCycboq?=
 =?us-ascii?Q?Y6pJNJS2cqmjyOLqXZyoVkLVRSVqWzE5wA3u4MQDpOrwY0NQYQAOuLJ14vmN?=
 =?us-ascii?Q?wgU2Dwf0rb/Vxj1kyzcj/2tSou/DHLsYMEbrCKvnkts8fhmrK0Yg+9ksxT66?=
 =?us-ascii?Q?JpaOFZO7Tv1qZP58FjFQ2bas3CoYbUh09QfJu1E+wplvHgfJvEDiUO51gbYT?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dc4d99-8ce5-4790-5e4e-08ddc0aa8910
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:41:23.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1y7RliC6mp5OSBMUAZ+Ak12T2QjW/t/ZJkfcAkT00LhmqSj/iNRLmctuUI5EjYb9f992TJwkr3ECDEoiX/W9Y9KaANlxB0M7EtNw+jfTes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
X-OriginatorOrg: intel.com

On Fri, Jul 11, 2025 at 05:45:30PM +0100, Jonathan Cameron wrote:
> On Wed, 9 Jul 2025 13:07:46 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Remove cxl_hpa_to_spa_fn callback from cxl root decoder and add the
> > callback function to cxl_decoder_ops. Refactor to group all the root
> > decoder callbacks together.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Question inline about mixture of types of CFMWS entry.
> 
> > ---
> >  drivers/cxl/acpi.c        |  9 +++++++--
> >  drivers/cxl/core/port.c   |  2 +-
> >  drivers/cxl/core/region.c | 11 ++++++++---
> >  drivers/cxl/cxl.h         | 13 ++++++++-----
> >  4 files changed, 24 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 48478bc406ee..9f7e2a49dc5a 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -20,6 +20,10 @@ static const guid_t acpi_cxl_qtg_id_guid =
> >  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> >  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> >  
> > +static u64 cxl_default_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > +{
> > +	return hpa;
> > +}
> >  
> >  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> >  {
> > @@ -342,8 +346,9 @@ static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> >  	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> >  }
> >  
> > -static const struct cxl_rd_ops acpi_rd_ops = {
> > +static struct cxl_rd_ops acpi_rd_ops = {
> >  	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
> > +	.hpa_to_spa = cxl_default_hpa_to_spa,
> >  };
> >  
> >  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> > @@ -425,7 +430,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  	cxlrd->qos_class = cfmws->qtg_id;
> >  
> >  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
> > -		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
> > +		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;
> 
> What happens if we have a mixture for different CMWS entries?
> Some xor, some not.

A separate root decoder is created for each CFMWS entry, so no
conflict. Is that what you're wondering?


> 
> >  
> >  	rc = cxl_decoder_add(cxld, target_map);
> >  	if (rc)
> 
