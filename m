Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE110E5
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146733; cv=fail; b=AgNcRDxEM1U3qbn+TGylkufL6UGpU8QF1C7FYQJcghg4yv0Wwg0AkMTK7uAeHXUYKUj/lBgaOra2fY8eViN6O4NFVAgn+BPJ7Pkm2YR6cw5F3MUIrvuzfRe1jznsmsKkzZTcTRPqgXwEGoCR8PI+9CWwoUeV9jf4Txkg3abl+sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146733; c=relaxed/simple;
	bh=zScQFdglW+uOq/XEdePfDDNO/E7MRuBR/wcUgHFGu2g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FLjfLG9Aj10RdUZcuy0H0K6nc4F6m5NgQr8E60pj+TWUC+QOfWG6sHwgJU2QZ6m6zQ6UrICjyLHgowZRYV8fuh/rbfaGKMvIu+4MUokJX/UvvvMESeKhtnsBidDjyQInCKsYas9a1zD/ZHVIBjQ0Nw1pjfZJG8CsVKHUXgh1bVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS+sHWlL; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS+sHWlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753146732; x=1784682732;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zScQFdglW+uOq/XEdePfDDNO/E7MRuBR/wcUgHFGu2g=;
  b=FS+sHWlLUGTV+jPejeFRphic1+/3WMiq8yBI3o2j9GyPbp3UDJMmyLIx
   d6TgO0BEamVQPJ8wRL1XqNr3K3AC3I2nROGVtMM9GBxsyiX4HSrzREaaB
   5vVexSRQFNQeKCtEfj/Jr7xBoBNgx4AO4eV2IzTyS8ykgxg4bo8wpl3qr
   j6wCWFr4nPJ/sjTW8Qsn/2Z9esFbD5MOnkgtl7VaBwLiS9O7oHkh9uV+0
   g/tMgCVcaplRHWqRQs2nQ+O7FL9W4YGpHR6gPJB/TRNhA344Z5hWKjqFb
   1/BLHBK3hs1mZk3GGN7a/b6+bSMnLRKcfrT2Z1NArLN73ab0EiCrA2jeg
   w==;
X-CSE-ConnectionGUID: xNAGVaTsSqe9lt47pSOKGQ==
X-CSE-MsgGUID: /9GBb1XBT9SHjh2Uik+6Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72950445"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72950445"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:12:11 -0700
X-CSE-ConnectionGUID: G/Ql1PIGTZq0qhNZtLrOJQ==
X-CSE-MsgGUID: Wx0ZUJSOQ5WSfDbK+I+PMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="164469689"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:12:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:12:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 18:12:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA65K8D0QLBTDOygJIDfM88pr2geeq4kZGczQ4Aiw9elEPcBZAGxZd3R0pWhzRU1dW6oOm0tZV2zlCKD5Vd1JUGtcJBbHEDMLH4WPBG/h6Ehp19MkQ7CuDbqqnliXmdZsphMQjTHYuLgrFAzt87/HpBBRym6ddC24ZqL4JGdG59xn4ng5yGgLUYnCcWIUPnoYCx+AXLO5AtgVa0jWzF71AxsT5aiKHykE8OWIvJ94VwqdR3y+xcodQDFddN25FlXzSVA8wxlRy3uSCKL1FZlgYKpgW/2JjLsbi1vfXudwqltUH7uxBuTkAuDj23K8ybF68sXKdircgfbhMmlq7o7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWXam8YTLg3XoyKxn804/aL+boqEahPyJFsvHeniE1I=;
 b=e343uK+3I4tTUX/mjddXXESvx993wd0EJqFkdUsDjtyJKItw6zAsbzwJQq3BKQMiGS0YIWE9h2lTtj1gxia9JjqwrBOBYCaxdmm22hjo54AYs6DSV3PaaG5gM+6K4b3pbKab/RNSoNnUcK04gxnBidlyggpRw6KrRALc2ezm2WuMq/Brt8cafpwWKOv0Gea8oyZbX8g+BH/zPnrRBNa5TPfe5zCRiVp4mwPDb7kOQJeE6btrAnIE9EmO9mgfZqu6FivY86Wkm8gHRdfljCRfow8B3PSfvXuUjssyYoMBDHCHYjMTwWLYUEu8BXV3u/FjDEaS6GoTMJLqE6y7n5yZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 01:12:01 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%7]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 01:12:01 +0000
Date: Mon, 21 Jul 2025 18:11:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cxl/core: Add locked variants of the poison
 inject and clear funcs
Message-ID: <aH7lWc1C-EAO2JJ6@aschofie-mobl2.lan>
References: <cover.1752365427.git.alison.schofield@intel.com>
 <fce084f133cd1d53fe442ae67dc0cf3b00b2c2af.1752365427.git.alison.schofield@intel.com>
 <20250716115809.000057db@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716115809.000057db@huawei.com>
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BY1PR11MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: df305e6c-8172-47d3-1725-08ddc8bcc31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZQuUWhQF+JTbseyxHdlo/hzghIkO8BAw8NN70PBz5CxxNsdEnXyxIwdqlga+?=
 =?us-ascii?Q?7PbDKOT6fFaiZx6vu51rHo6fM1o3CaeS5g2FuSI9zBIMpX0jeclLx8EeKHwx?=
 =?us-ascii?Q?RK0TXVtjY/Enhj4WtQaiFGoeRv0s2gIjFK3cgt71zDHtnZe0J4++q9QmpiYV?=
 =?us-ascii?Q?XU56075grwz6wtlJmcUGsc1Zhg2y1xoGiSPW0iALgVPX3xshBn6qxpffxLm9?=
 =?us-ascii?Q?GfFpEmoEIQZTRIFiOdZuLF21pz3iMTVJTvtovkgZzR7MSYMCIxlfjaYzMCyE?=
 =?us-ascii?Q?kDN9wlwdHNgQltywIELM8W359We0vWYPcr+475TEneAtICG/ea79I/9RA9dh?=
 =?us-ascii?Q?MhhWZtwS4J8RffN96vRFtShuNLzQVH8CPMLliqkY5fiHNy4UQQLPsox+5xkv?=
 =?us-ascii?Q?4dMV+1K4OHucpjYOGCYAG1tatXYtthKyzSKcaD6I1T0NuZ6XMOe27E8Yz/AF?=
 =?us-ascii?Q?zXALg4QLuirdq7g+tdLSbV3jOd1SyicZwfzTCpczTj8xgmqraHIDqzGJ+mU8?=
 =?us-ascii?Q?MZHjfMlaszVcA6yMpLEV04I62FWp5qbXhFQ36E49ccSeGzguII+qaxMIfKD0?=
 =?us-ascii?Q?4WFljq2eE9Ca4qNiAHqPZPD/P9WmBLxzihVTlPdKIkQzfDm50TByZt2tHswM?=
 =?us-ascii?Q?GLdid8PHv32SVqOdXgxJkmh49DLtCLoTu1Ih3JujvqTUJJWz7cTRlS2K+abX?=
 =?us-ascii?Q?+uA7JLsMn/xqNtUEOnsphleLgh4ApZ+iX+fgjlb/1vKyw18WWivG4jqP2OLt?=
 =?us-ascii?Q?OqYbt/f72yIuOGWoDBFZ0SNvgTGG+skS+AgjY2ByxtNNaX1eWT44P9MKHD+q?=
 =?us-ascii?Q?LYOeKPVGofctkHPOyaq2isK9vLrpsEEoUvj1gAIkiAgUHjzzo11wKIY0+9ht?=
 =?us-ascii?Q?u3WBSMEGUTXUeoF+0QBl7N/qCeNZqP2eEgMJ/Q2P+CKZaVBQAYrA5yww89qG?=
 =?us-ascii?Q?lPK9s07sfmJ9/MvViwONQxhZfUthSkLncWsQHYTsl+4q/GqY8YKZHkZTI3Ls?=
 =?us-ascii?Q?SVOuLHMLjoZlNYdpilOMVk7rieHqvX6SYIiWKnD0s2gE0+qLJ+Z3pNE8oSjN?=
 =?us-ascii?Q?6d/48oMN7BvzfKySR+FGJqtfIp7G2VS0epIOApdMMZmApb8xwfkYuRpeYKiw?=
 =?us-ascii?Q?F6BDNfiGUjmw7l/BvUvt9ifIrr2OSRKnXMmPn97ujm4jadFK7dXAQU0dDba5?=
 =?us-ascii?Q?vv0/J+nh7nTAxp8Cyd4XMxN/CSoU5wN4AeU3AbNCSnOz5fNo9W+piT9LRj1c?=
 =?us-ascii?Q?/0CGs5d2Xky0dMLTD/gjZQPYhbYHoC/1eHvKsCBQSUuSSWNili7N0nNQKEN6?=
 =?us-ascii?Q?OMZ+qsuMPKFenm8WXCvIJYTP0wrGPhlEihGXHKpjCiFv5jT8mnDfaUbc8ZZz?=
 =?us-ascii?Q?u8nMvg3g7DquosbdaC0q9WHk49iauNE7nYEbukFik8Yzr6TaDnOCXxTmkBsd?=
 =?us-ascii?Q?NhUWay3AaWQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jh5azJzckaIbC1mleWE/JSfFR7/zXnRz/UE1tZ1pdGMzBDpC748MRz0twwQX?=
 =?us-ascii?Q?QLlWDBlszA5V8HikyUEBVo8juHEOgloTDo+Cru9MObVxrVaDHWCRqZHimJK6?=
 =?us-ascii?Q?tIKvFzYG9V4jJhudXDve0118QANCiG3E1b1lH7vvYX6ybNHCVc32me5hr1hX?=
 =?us-ascii?Q?DF6BId7RBllhH/VSYN74V8cMtOxfl+FYzl7urCvY6zul/y61kZbK2PftyEh0?=
 =?us-ascii?Q?L/72R5x81pwBrwpzGUO5aLiu/+LrNHWp7d+6k9M+regtyAcL9rZYfSkTvGCD?=
 =?us-ascii?Q?YIEdvAe4YduALhxrtA+7exGap54GfCIt2l0HSr6JmlXyL0usWoS4NDeSkofI?=
 =?us-ascii?Q?aL6h4BII29y5cu3lX6Nt5UDJiv2L8xm/8g/8mdoKRmnRB6I+Ub8eoSeQsgUz?=
 =?us-ascii?Q?cQri9TnWFa5SOaVyAF+kh2ovjZHbMP79tmg9rYWIEbDJb7tlXnXktCblRUGG?=
 =?us-ascii?Q?kMcl5bfGG95nmWuFluwoENQjv25bu/yoKjlSBjtrqp5/ljaWy6EI/doftxqQ?=
 =?us-ascii?Q?RGXufR2VtpkUnK/2m1Laun8dwVxAG81McDQrilX5ulEm7saytwBiEUlUnWhB?=
 =?us-ascii?Q?cZPtlYiKzM6CJm5eZH5h2y2cc4ezAxG/kq/hJ80JL0OJCKUlpJXI6LdYE91k?=
 =?us-ascii?Q?DPsIweTSjtY2AvBoQXLlwFk/kVxUYpH8F8uGe8gjz4H8qJk2h/SLqBm6D7JA?=
 =?us-ascii?Q?3BqXqKXAKHZLP2j/+Xze74mdTUL3RZ4pa86dzY1ZVJ2THW5jGl0lknKNOmgX?=
 =?us-ascii?Q?cWrYH+N0fQnW+uDzq7RnBt/fB+cFaaGFt8K7Uao2uHFP/lKjNoajgvTn5UrN?=
 =?us-ascii?Q?J3sMI/w/aRsZnXbY+uUcYfC7OIS4vJVSwtl5HdvlXAJB0MOWClCTnSq5OoMR?=
 =?us-ascii?Q?1S3/atsA/rtyvu0QofDIJFfL5FKlo7BJmoaaMYd9BaOlqzRn89LiLf0FMgha?=
 =?us-ascii?Q?pHAvg4ow/N2gFvYVbKURniJOnZr7nCd9iHr3T0ScRNzxDDll1dL9PMTHol7w?=
 =?us-ascii?Q?Z7XtIigs/O5zM1KQAv8y6DjKAnpbSVHtU5rakc/QMywUdJJ1BnzoxKWLeez7?=
 =?us-ascii?Q?zAk1c/M58I1UfwkHa98x8NjzxcS8U9NyGKDuvMKlpXpiSO3m1HX298hdzw0Q?=
 =?us-ascii?Q?8j3IXk5eHbtLF+rbglBjGf0Q7B7wXNCBksgMWU3wo3pCJgk3kxGkWB+3rE2b?=
 =?us-ascii?Q?iX3Z34jHzFO73zQ2JpNgN/cCnB72KJ1RZp8t1UX08iuHC/hcBB3593wA6tKV?=
 =?us-ascii?Q?wg4R316HKJKIff1pXlWaD+nE46CMkgiyUqSnyC7P7yxaPoixWswZiw2xiK97?=
 =?us-ascii?Q?qBVcuLYDt/2xAzNm42x+5oaLZIImoIWXkMQDHaIq88vO4U/hREpiYDAeCMQY?=
 =?us-ascii?Q?WNjWg9cs8LpbY+I1ggqaiBD2u8x1i4ZI6DAzwQhQ5smex4SyrcIX94kE+39f?=
 =?us-ascii?Q?jSCoGjNBGwi3gB3UoO6FQwNtbPGKnDgr0gMyJPx2cfUAx93pVk1AhsUXYu8j?=
 =?us-ascii?Q?N+svs/m3abqmRGvhE275ldo8ASTxbbqug3bHPkT4Lk1GqGMtn4GE7tEIxruO?=
 =?us-ascii?Q?RAr4i2G2pzoY/qbdScLC2EAtul5eYr+VvKsuU+LptDl25HnVfDaYJQq2QUdq?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df305e6c-8172-47d3-1725-08ddc8bcc31b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 01:12:01.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kL/gGjScNqjRPexkZULKcpv9w1/vaJ+MuqUQJo0Ic9ivrr6Xd4KfY3nhqGy0bqeWxpAVHV3HlKvW19cgugGykfcb2U0YqfjP60WqEGPc9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032
X-OriginatorOrg: intel.com

On Wed, Jul 16, 2025 at 11:58:09AM +0100, Jonathan Cameron wrote:
> On Sat, 12 Jul 2025 19:37:56 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The core functions that validate and send inject and clear commands
> > to the memdev devices require holding both the dpa_rwsem and the
> > region_rwsem.
> > 
> > In preparation for another caller of these functions that must hold
> > the locks upon entry, split the work into a locked and unlocked pair.
> > 
> > Consideration was given to moving the locking to both callers,
> > however, the existing caller is not in the core (mem.c) and cannot
> > access the locks.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Trivial comment to cleanup inline.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > @@ -324,9 +319,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> >  
> >  	return 0;
> >  }
> > +
> > +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	int rc;
> > +
> > +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> > +		return rc;
> > +
> > +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> > +		return rc;
> > +
> > +	rc = cxl_inject_poison_locked(cxlmd, dpa);
> > +
> > +	return rc;
> 
> 	return cxl_inject_poison_locked(cxlmd, dpa);
> 
> > +}
> >  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
> 
> > +
> > +int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	int rc;
> > +
> > +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> > +		return rc;
> > +
> > +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> > +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> > +		return rc;
> > +
> > +	rc = cxl_clear_poison_locked(cxlmd, dpa);
> > +
> > +	return rc;
> > +}
> 
> 	return cxl_clear_poison_locked(cxlmd, dpa);
> 
> I wondered if this was to save churn in a later patch, but
> not seeing anything related in patch 4.

No savings. I'll collapse the returns for both funcs.
Thanks!


> 
> >  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
> 
> 
