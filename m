Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F791A9F97
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146446; cv=fail; b=fU9YKQv5qSpyEgr20JIOQekPdlrNVOlHlHaHxFfe042yVEljh+1IirO3YVirzxqoN0IxNRQ8c8TBOY1qpQ4JBd/K9ZgwpBAHHWUkliqaWFLbvTtYXfkhxYPDKdpwrEThF4gvM/n26EaY7Q/ODt3vT8UmjswLEKjo0/gvOxZZtgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146446; c=relaxed/simple;
	bh=e7AhtNFWvqpR0A/uIa+zCDSFrC9Cy+rlO6puLEv44Ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gABAH2ID+yPWZpHrpIXn8OtaIDFSfmPUe2TbiBdZQBiFhhXLpORzCqycELF911Ey5mlarFGz101QOtk7PZBQokACN5H8A2WQwGTuuZP9vSz+wC5vKZ57lSt08Oo5h5JezFEk9Xt2QIFsqeyyUjitsDbvvAejpuftuPygdpj4fjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzwR+YA8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzwR+YA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786146444; x=1817682444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e7AhtNFWvqpR0A/uIa+zCDSFrC9Cy+rlO6puLEv44Ek=;
  b=gzwR+YA8s92GRgUDJWWs1SHtRZBEPFDlk7z70eTFOEnRIfRkMaaBSjd6
   EYHwASuElIfskmFzLvi5fX+yQs4a8A4Vm6a2/5ckQCshLiKe96HS5042c
   NisRyOKbxHi82cntMqLRmzw+DudlzX5hnNxkl6Kp2I8eC6TRN6886b9JQ
   BwRu8fWA6fD/V09NLizSiuJnau3fse4tNW56a01QRJ+tmJLR2X6iMbXsV
   TdzVDf8n7wgxY9PG6P4+/dYP0P/cfB8ETQmACb7ZbkYozoAa6f+YILbC1
   fBvbF0jHWQTyxghkeo3jqmT1HPDYmY6fW1dmnXDnncs88KU6QXI6Y5Cn2
   Q==;
X-CSE-ConnectionGUID: POJwCwNyTRiLkOXBJMgfag==
X-CSE-MsgGUID: JnLtk0dfScCB8ZNfcnbl2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="112309341"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="112309341"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:47:23 -0700
X-CSE-ConnectionGUID: ij5uG/bsSyKkovZJ+wssBg==
X-CSE-MsgGUID: 4xhl3Z4wTFOIJfwhPDOmug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="261231094"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:47:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:47:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:47:23 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3xs6LgrF7dAXHeHjp1UJ8ybDBOzHZXJv8FJ4IV1z9dOcqozf8yHEGBiX7m0v4/bsTFwJczwuLAlEh/RRv6IheJNL3Q1Ue+GC99gaSXNZwPMRgTrmjqGOgyOf4lSUZdjSMZpQykHiQkjBon66teopaDjIlaWiksi6Pot1B76WQT9aSX3AhlVImRAhYRym/eIwcsDtPaQADHCD/VJ5fE6GE9kkidfjpyM15SpDyQHtKfNP3kMMitRiB1jtoYCsxQM+aDtZT7oE+2u1iBXEPZ4HD5e6orxcIRfvL4hP1NOtDP1nTXZNDrcifgWwUPOW1Itlv9G844VfkSDYJe+Xjl4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PQxxtoY3hw41FNMRm7HkQvv0Kb4CFG44rpwyNES2yg=;
 b=R9x9MI2fK0WGcdSsj3Jo0my5dsk3Jm7kldIYUCg0G5gJJD0/UCqA9Ss9m9mDRTminQzUO6FZWjsrIfvOE8dbl4fADIPzwX9FTZvKd1h8vxgxb4ETu5WKcQaSa6zK4HnuhDKQwjXJ4+PCYZiBkzSBMnGc6/jIYu4CFVoUocISXStYmKmzFFvgTQC/lGZiNCe8vQ4HZOqTdSS8Xgt74jaj5CBq6qqG6C8Mj1nSK8f5jS4huFYUorWyQ3j5ZPtvRa6W4QtlXt2uWwhFF3AoNHkzOU50pEiTSTgqqjrffMqAA+MY82J/3noprw3pOcXQ9QXRrqZU6xqsAR9I+ybNi2EsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DSSPR11MB9617.namprd11.prod.outlook.com (2603:10b6:8:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 23:47:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:47:20 +0000
Date: Fri, 7 Aug 2026 16:47:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 2/4] cxl/hdm: Only interpret interleave settings on
 committed decoders
Message-ID: <anZuhM_aiMibSANs@aschofie-mobl2.lan>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
 <20260729163435.7bkqk43tngtkx35w@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260729163435.7bkqk43tngtkx35w@offworld>
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DSSPR11MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f00966-8fa0-4f2d-e890-08def4de388f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O+cHmcsrQzUshazXCtTQNlkcJC/jUuhn7C83VkyaN7evkkCVf9xOl4WHf8qYjFkfE/ZpA050FPP7Les9o6uL8cEcmxK/4j0iOGWSmRBrz0L8PwBe5XmNMplFhh3HfzpyH6vE4Kkz1nfxltvSNqGUy+kO0itz5sGxCb0o7eG75LPl0KKK9RGeb4WEnQBhGMla5hC1p00VZDBhe9FD1BDs46kXRMbVVqf+TCAu03BsB6PAvh5GSGbkGTAPgCbuk+yhLiArat2mvQJu0u3efOliJE3V2OfBFYYygEOpVktv4c8q2XrFq4yCpcyP86tVSkXlJXVloWlE0cRJd5+IFcvWk5wdfDvEQxNl5aZI3uZlwWxuue8ZfXbTNpdxL+dHXa2ZvytDTaPY3UWDTugcYgjKtiR6CwZiYrVQ2kVa1yHvzFkVNKK5+OKENmJ/b4pSYZmqKUv6sl3y1h+MrFbCGIaD60jAGVN9vmJshRGe9dMIsQxBor+WifvmC16imjga1PYo9TixFjrzKZG9RMxJ1pbZlOJ12wmlQvHSC7ZIq3AtWTOmom4kzueIFkDI5hdymfHHov71DPOM67M0xkSX+4SiZdlpjZdVz58dIv4B1XgBETl50wVk186zu9EFP+ya49DvgWwVrnajG5kGZkEVT+MlQzFOqxydr+W9PNQ6pyvIDSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwifkpYotoahaW3nzTqsWu008QpaYPoFfMm3zwYfdyVbl4llvHM21IgVHrkH?=
 =?us-ascii?Q?B0+Wt4WTzpXLHfwrCIG4dTKMsNxFJ54kq0Ze/UeCE1YdR5Q0N2zWFjRFR31c?=
 =?us-ascii?Q?OgItoxd19c5vgnllVT+qEjKU5BDMkFLZtIAJM4ACo5vwF4bpvDeU9/mVs7so?=
 =?us-ascii?Q?drQ0xLUbC/yOGBe2BXWsY6j88SQN+0U8xg1Y2EyHDsGTwN80hMwjxEOaenv+?=
 =?us-ascii?Q?FImHu2VfLeSTKoRBkdnsU3caO2SokEjxazaWh0Gk9f9HSOAlsNxOozMSYh49?=
 =?us-ascii?Q?Rownfz6Icf/zIZ/9h1fh4ZyJ8+SaLRTt077auHmlAswkr+zbZU6W5ZSANdQh?=
 =?us-ascii?Q?ZxJA8R6TBJ/mICslS3CiJRyw67QIymCklX9OHTGRbWGAQ7HmF3T/CNPYT6Tp?=
 =?us-ascii?Q?RbRDlLtxwmLQbeJpFnW8jcjz3hmNNVpBUbfFR/XsErGMnfDeLsgJpH5uOYoD?=
 =?us-ascii?Q?tcq8PLNw210vO4BlhEGQ2ueZ1TAJn/yFFSVvT/W3JiLL+5fWXqc52BiFSI7Y?=
 =?us-ascii?Q?USGWAjnigMXa2dXittUYBdBmJLUZs3Uq0PENzJhGMs+d3+nvhgdUlSkASFHR?=
 =?us-ascii?Q?wutbKBtgg5oNiSU6vKwPCuzRjmY9UOoH85+gkLoMd7eAEvic6LghxZ/8q7wt?=
 =?us-ascii?Q?/ySZB1+IrI+IQibpAsFcSJHyKNnd+1CC8xP90Cj8Vxo8X9A7iCzyESz5XRtU?=
 =?us-ascii?Q?URANPWlpfsGHvRDFYpMukzqjlKMXXtBcxt2a8+3/tt/MwJ6chac/YMFZTHB8?=
 =?us-ascii?Q?uScYqX4K2hadJQ3ugv4nK6h0ntvLYpGND/KpWxoSQnBfhhvf4MVK3o1FcbRd?=
 =?us-ascii?Q?m7119IWN1h8TsnzJS2qAAgPJor0sBN/nkSvzpX010AyN6SocCjiCDCSttaIR?=
 =?us-ascii?Q?2nbcrSytR6wVZ2kBMopClCDzmEaWqCTl2JJSnh1uvMOUH69CRD2GO3lo/dSC?=
 =?us-ascii?Q?8MXHnXehAzYp05Q8RK2fw1kgGLlC32etD7GuvMnJwgxWhWqYdsgeO4Te0onl?=
 =?us-ascii?Q?DJ581HQHUKKsulFp6y3TwiEnAASfzUsM62FrckQFvEJD5+kUa8nmHZS0CNZV?=
 =?us-ascii?Q?QShdhdzFY26oKDvABSiJboJTU215dKGE3anTZzmE8j9YKZiO43bwqDzQxZab?=
 =?us-ascii?Q?kc7Fa6w2lOnUn6w3MYiGC3+hOjylX0yPB2zu18GmKK9ZZxMjWVQJIf6SSCRk?=
 =?us-ascii?Q?HvkljhiIKRdEJNLzmuIQHWGw4yJANp8d7nGAaM6Z3DI99IXI2kzr4C3eoqcI?=
 =?us-ascii?Q?mKVIfSsM4rR01VQIS7WI++8m8yv9XA34uwVw6TWvEeqtgmGh0O/kXQMjZv7w?=
 =?us-ascii?Q?7GULSwNf0ND2FdIYRZO/FmnSOO67KO4Ec0qqbNsPW0ECBehSBgYur0codAmv?=
 =?us-ascii?Q?W/5MonXM4SJzCYeQK0YDDvVvZadisWpwmNKVfTdcrwNTv/4rSgfZ3RREtuJV?=
 =?us-ascii?Q?oipHB6/aTRZCMeKEJkNtYo0EAkxG6P9ACRi/AhD0/9yL8FAh6tRo6vlqGn1d?=
 =?us-ascii?Q?s+KAgvDTYpvay0mxqAUOx+O7+bsZS4h7yQpRZLeXrP5iQ0R6ihS6AYnUd/m5?=
 =?us-ascii?Q?0RnoKo+cCUy4nmD/32eSxaL4h5fA8KWOdJsoa55xBMocp0h91V7qknCCgBvm?=
 =?us-ascii?Q?Q6/UK9LrWey8LOc9xWhIEToP3Lqly572fRva5FpgEzB6aGdDqN3OCBjwozSn?=
 =?us-ascii?Q?wSaDKNM4WNsRach1F43tCWpF9Ngn7RD6WGrwYCcGWd6KGMV31rynQrOZ/nuS?=
 =?us-ascii?Q?PrlMW5PhtE9Iz2Wb4TrXV/zxVPx2crI=3D?=
X-Exchange-RoutingPolicyChecked: qj+yMoAIvnZpM/pir7uv16dfRctiwn1AALnfT8nrqrs+CaNw9oGP4CE5krZaAp7k+NTU5Z/XwhEtzIeao90+lhu9orj5DCQi8NmJSZeapENVgwxI3WHsYgG3A6P2EGYXlj3Dz7Nqb+dtevJtHEnDujV8xh77/bvmi+A/j/HmvVGLcczhoCTWzKnCptkkCBrAxGDs8rqFhGkyX8hW2CN/SNXkO6YkJBHHrSY0iPyKN/I53Q5l6+bzUvKbl3vT6iHnEVwn5SjZ8tQTJaBF4DTHucjYVNaIlaWy9TLj97ZK9NZFpr7bJDY57IeDs3xPMaBVuDfMbD6kJu//pK/uTRa4Aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f00966-8fa0-4f2d-e890-08def4de388f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:47:20.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qtivz/4NuowRXl88CFpiwEDODPF+wgToRbwf2XxmBcevQZIzij6xbkXXuibUPsHqhYuywzjLnFYfdH8+SYkLD8HcJq6BdQobrO1rCcIfDQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9617
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 09:34:35AM -0700, Davidlohr Bueso wrote:
> On Mon, 20 Jul 2026, Alison Schofield wrote:
> 
> > Decoder enumeration reads the interleave ways and granularity fields
> > from the CTRL register unconditionally, then decodes and validates
> > them for every decoder. On an uncommitted decoder these fields are
> > stale. They hold whatever was last latched and are reprogrammed when
> > the decoder is committed. Interpreting them serves no purpose, and
> > rejecting enumeration on a reserved encoding in those stale bits can
> > fail an otherwise usable decoder.
> > 
> > Decode and validate interleave ways and granularity only when the
> > decoder is committed. On an uncommitted decoder the stale register
> > values are not interpreted. The interleave fields are set when the
> > decoder is programmed at commit time.
> > 
> 
> It's weird to cat the respective sysfs file and get bogus values.
> imo this should be kept as is.

Thanks for the reviews Davidlohr,

Agreed, the patch is dropped in v5. It changes what userspace sees:
decoderX.Y/interleave_ways and decoderX.Y/interleave_granularity are
documented read-only attributes that report the decoded register fields,
and skipping the decode makes them report driver defaults instead.


> 
> Thanks,
> Davidlohr
