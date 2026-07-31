Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CD48986F;
	Fri, 31 Jul 2026 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457125; cv=fail; b=PQF9Q2Ms9+rvlU0u3JhCVXy1DYcF75Go7OV4d+iI0CoPQG05FpUgwz3sT4cYu2WApq6IIO5qLPV38gRXwJH7SNGtRqNelg6xndgc2UUpRyV1h4rMEadP1nSTqI6IOVknmQW0PofrLzyB/uskgygSXXkLTFyx1roxcOu1vTvIMDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457125; c=relaxed/simple;
	bh=haUoJV8Nrw3WjpfZeR5MBS5IqXjwCoKsLrKH7u0YoMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ps09pyGMjqhDdvQSPXDwhtxPPoBCwAclFWL60I+sZvOdXWVXYXGJ0/ORV6JxwUMCWY/Ez+RGuXQj5NCZPTD3cG6ay+AUJRW2aJjpS1U3M/DPOb99o/WIf+oG3SObj5MLLB10xsQe3Pm02vql89WA8NwIx/BZyUrfXcr/6VDR3/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLcCcIeB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLcCcIeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785457123; x=1816993123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=haUoJV8Nrw3WjpfZeR5MBS5IqXjwCoKsLrKH7u0YoMM=;
  b=RLcCcIeBbeXkjQ+TK8YUSxiFeBVYltSnfeaVisvyCQO+XdSp3jwm09oC
   PBOAqnYr+ZwREt1horfvhp94cyCiSndLb+jzlBzuntclQbLWWCU98bPhk
   VFPgIP2JwoQtw9Cpny0h9IVp3sJXQsB/si4YWN6YLtqYEuegkS3nDb2IO
   GSj2OCGIfGrFt9IJB4yFShJX0YP0gTbZ78uoLOwOsKkQwOi9pn7VwsJGY
   5e8d4wrkqFeKOj55fKoIo/VPB0xXtGODLlUb9g9gfQ9woKqv5foJjFa+7
   U5e1h8teYK82M/RztqWVxFO3qb3LMf7db4Ipionhn/glzvNqCpytz+u2i
   Q==;
X-CSE-ConnectionGUID: +NkaH2juRsymNBHefInapw==
X-CSE-MsgGUID: paqXoUnKRA2l0Pucdl3pgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89974842"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89974842"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:18:42 -0700
X-CSE-ConnectionGUID: VYE30r/uQ6Wn3Ds47+uxDQ==
X-CSE-MsgGUID: lVDW0t+yQe+496iQTy4DFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="262383840"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:18:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 17:18:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 17:18:41 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 17:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xli45mAr43CfFrGL8hjkBpwavG0kzSwAcKyKubrj+D1sFu8hVpoHNuHMHUJnhSEXoN7w6z2r4nOgiL1qQ/zKMxxEeUeL+PrA+oc9wpb2fkPsrlEI8Ad9AwF/Dfk8H7P/1++YOFZMhb7sx95eupCN1TJ9MDufebCg3vg7dX93KPR47TMJfLJqhd2vgMCblBoi7SEUG+I1sWej8dBRklTPsYB+GkfahVfrRgwG/wXIB+J8H4ZImbWNdXgYwEE0uVuK3q2tbJNlqs3V//TaQbv4l196LTWyXJRy52kaaqOOygYZtYDgsjG5IK1HGBmK9PpcZn+AK/8EhC5kSFY5d9DdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6R0CXKJaVbO/Pxx3IWi6tys9nhTl0u/CdFOG7x3uUo=;
 b=TF16+D8pGtK/hv0le4NzTGPPB0C2Uw2tWecfr49JVMLGqoqbTNWr0cF+/78jryn4JLi1vkzF0j/ld9DBIaGFCt80pwjnCxd083a7D6hJZXa3Dyt0AbxJjJopdX8/hIwMBLzFkwVlyciXjpuSRgzNBPmdwaofoxQfz32CUMLSuwgGBMdhVYQvenqDN0UVN+pVtc4HCjWGB7GgotntvJgw+Tv32VUZwjJYiu/TmuNdV7i2EY3pxrTHxaC18SisMh18tx1hczd/sQm3S9Yx7sLyDzr5enswOJRLMfprvDI8aps8pcpnnJ4DHdMboaC8PXrmWmUYLQJHrTPkLE365FYYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB7951.namprd11.prod.outlook.com (2603:10b6:8:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 00:18:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 00:18:38 +0000
Date: Thu, 30 Jul 2026 17:18:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 2/2 RESEND] tools/testing/cxl: Enable zero sized
 decoders under hb0
Message-ID: <amvp2sZnlvOCvZBJ@aschofie-mobl2.lan>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-3-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721085715.39322-3-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 33926f0b-362c-4c21-49eb-08deee99448f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: IDyG87Z6cxRDSvAcujo1m7NPejjPTaPYqu2vPpFNlBgz7THNuLTYI78CB+gVWNUnVCrgRYqYOmZxhMvK/Wlb2T7MezaJpqHTY/3xRNVxyuBaoJbEKCh6z8SH1xNeZE6SCmSwm2BXmyW9PQoq0pnMDxt3LhKTJ5dWZ3V2XvSHAXf+/wTxdF/PTJhJQ1iTkVFlCOdz1/FGI5ZPLMArjMYhNbm/wWP9i0Ye7Wwz2Yka6o4A+RMZsoIA3U+i2fY4NTI+IcMVUg49du5G68vx3vsojGVxvPpicGM5FS9UWZs2cu/NR4B7EJCrQnhovvTiR11ijYV+D8om3dP1R2Z2RVkc27QcqoFdIOXI25Pjbye+s5J4kCL8FnoKtrh8rwq6dK+GaOjTrHQS70ieIsxdMOqjSrQ53l2fzKvMi0jvEnPwFzaowV9YHIlkm2H+3gmRwV7s2cjfm9bPapHKSkzXC8O92AJ9MEWOktBWLCUqHmEvjhJ5fEomJkolBXUj+4zzF5DYQrPN6sPHSEfCAYSxZeWxqjZVkXfOVDKVO/5M4YPixm3t2QMdyRQA7uwabM3NcmcrDD+qCARznelHJNQv0yKFcnO+jbtsxblJYXL63hWTmfFJnPQSuZHIYu+Rpq4KZUcCsbCePvEUOG3HtqA8uEVquwdRQP6FIsiCre5bitvhOcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opvqZisNyLHyT5Z8dp762n1wBJd2mPoCyI7cSIjZHBRSIQQaI1qkD84O5PeD?=
 =?us-ascii?Q?x012/8Qr80g7htlwwxn+LOfmbfbWQv23e0ys42zTMEfYgT54/WrcpjBVdcbf?=
 =?us-ascii?Q?wyfQPa3iqPC98QhwFNKRrqD8xwR3uEcoUwHXTXN7dUXXSxEuymKO0IErFyz0?=
 =?us-ascii?Q?bzcCh+XdJN9jl0vKlXfewkVvLApnu87jKl2ubXe9aaLtM6ajeVcJhfeM/lLz?=
 =?us-ascii?Q?hMBCPVKTgLKPx/SEYxFNHGSZ1FHacdAIfj9DEm8ExUUpGyPKkPW39+jkZMI4?=
 =?us-ascii?Q?WsU0JtRbr+kk/Bku1fWSQ785XnpSd3DBL6YE3HlShymbJuURVSc1TqLVqO63?=
 =?us-ascii?Q?xzDryMTsyuRqvJbshH42/Wgi8I5HNcwdEXRzkqpnPAhARD90ZIr4i+4wJo0i?=
 =?us-ascii?Q?IqTUo2zQwt0p2NUZdFuU5w56vG0iTnXRmf5JWnI+LrpFvkt0i5CC63UQqlDW?=
 =?us-ascii?Q?OoXc1OYIXAvTegI3rBGb5XFYyorxkIty6uDGOLNHODAMb3/L97RmJkZWxJ2h?=
 =?us-ascii?Q?D9Pgb4+x6v47RHPg7rIpXodQ0u3sZCxFrA/8HFCQlCvrkLKOuhLt1E8T5WgR?=
 =?us-ascii?Q?M9yrb+C6hGpdOB/ikoyI+Rt8myQo4rojUgPNLjBzFQgIlBB9V/HsND+Niht7?=
 =?us-ascii?Q?If6eQoMQEVSPsyT5u9u05Gg6/B1APOF0Ud1lDlavIOnqIXuJCg1fs4eaazYQ?=
 =?us-ascii?Q?zFqNvhqi8R6qWR51hurhIQEfTNNmhXwTZTlajdvo776hafVGPtFtLt+Rg8MO?=
 =?us-ascii?Q?qGVOR/yl25UO9+6ji5Hj08n8h9Yz54Uis7dh5EX7MZA473QbFHExQRSR6WG5?=
 =?us-ascii?Q?TWkXk+Nu1qtyXeREm3AdDTT/ZUPl6/aYkenFcDDsM5n3EInMzgg8SqQbSd+i?=
 =?us-ascii?Q?jbj44Hy8TckSzJxmpON2TWoACamXASvQpH+1jiosQaUuY1Ce6FRGspvBB0jz?=
 =?us-ascii?Q?DLBy4Ays8b0OyPn9wQsYN5+3ua6CKjnqLXJ1Uk2cqnL3b8KQO8PJqmUleyoF?=
 =?us-ascii?Q?4ByEbx5pi4BUba5ThxqR2eQvVbTPgC+fPJ+XKIFmM+YyVfbSMcurPrag1jrb?=
 =?us-ascii?Q?pYLlx3F7RRDkQySlFxH7Ox4MYhAJqhVzhbnHD6XsLRPnJU+1cPGtqMakR14K?=
 =?us-ascii?Q?GmGKJ7EKQZvAVROuBNGwVOmQMQxL57bCarfVog5tXuRG0buf2SzNUQ4cepN8?=
 =?us-ascii?Q?PuFbBrB7hVzDuFKssjIEEwt6/29TZBhmEeh6SXKqHnApGXGxkhcKBbbo0gMj?=
 =?us-ascii?Q?GaJ+IAJGiZBzESBA+PQ33Kh3aVXJz/yw98/uMD8HNvGUb6RceLxQ/sbY015O?=
 =?us-ascii?Q?9ek3NH+Iu6cQ2zzCpAw2ZLv81Us3VMbkIsZC/PdDk4DO0BCz1bh4aJYBbhbX?=
 =?us-ascii?Q?ZMt+12Q5mHl6sknKXcCZLmpzpxVadOgfmWS8q+x8sL98hZOEkPI4ujug0mHE?=
 =?us-ascii?Q?VwZ7SR4LUkmvoa5D3M5KMCwTH+TE40q50psurVjpS+zf/l3MXDTfoGuf79ne?=
 =?us-ascii?Q?yZcCnnj3Ioc6LfGGhOoPchb/1t8+XFh6K6uZsrunb1J3FVtdAhCn+YmGHBGB?=
 =?us-ascii?Q?BaCkzDjRIkwTxkk96Vo5bqRNPc0Qwd7fqP1HpbEArZDHzn6DVFMu6E+iuHLP?=
 =?us-ascii?Q?8unrne4h3gOXwYmcGWyPL3eblkd/3md6cy+IFOjQMt+AO8y3edf9jdMNZ0I/?=
 =?us-ascii?Q?qDSsAsUWbYck+Er36Bh1cuddEOsTv1w/MPzM92CM4a6GKbBuB8Q6AYhhx9JD?=
 =?us-ascii?Q?LffRhMb4mDhQF46Fa8N2A5o8eVKu/Ss=3D?=
X-Exchange-RoutingPolicyChecked: GEOWrwuuGjbzJlL1x+6trRS8yrZwWICJlPXr8VdoSNTlIHejdkmPEsk9CnTPtc/T07Z9c+PRXP1AWJG3Lu18X5JJ7DVDlQl/avOlhxjHouozGZ0eBIC77T6jAuQIZE41Vp8+lVYx/Sxv+wNH0wBchqmcRQe2eKaztBQDVQdTuI+c2Q5/gL05I0qLQiCFZmnzDZqLpVfoFNj0hH84Qh3oIRwfA0jwWPH6tGZMqJq7fsR8bScivvmKTQP0nDs2YrjDvIfZaGIwTZ7ok9mxlzRRV/sDDaNHV98HVhSQ/HeRBHCihokli7k/vmDU5dezY38Bo5zS9uAfNgReOWcOQKBJdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33926f0b-362c-4c21-49eb-08deee99448f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 00:18:38.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FRVExTyBWt4zk1CJ9OhvRmkby6gcs80PP3wQg7NQbI0iigpflWUbYDcd7I6oQFhAotttReNXb37ZFPTuZZ/cv1CWR7/oC/7WJtjrnNut3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7951
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 04:57:15PM +0800, Richard Cheng wrote:
> The kernel now allows committed zero-size HDM decoders so BIOS can lock
> empty decoders; cxl_test needs to exercise that path.
> 
> Add a mock_zero_size_decoders module parameter (default off). When set,
> the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
> commit decoders 1 and 2 as zero-size + locked above the decoder[0]
> auto-region, mirrored on the parent switch and host bridge. The mocks
> take a real zero-size DPA reservation, like enumeration of real
> hardware, so commit_end lands on a zero-size decoder and the
> reservation, poison-by-endpoint, and teardown paths all run.
> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
