Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA01364
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675601; cv=fail; b=ZvmomfRNHg+DX1/HpEV9oNqYrEY3/Ibf2l5iISflcn9EAttNYmnmPohyzVR+lBwXAFtGUOEZiYV/arqqtqNsELRGlsgIJNK3FlL6r7y8xoUylPv1yJwPEC9AR0MS04msBbq/3yA19PM7SSoAuojWN3CmbJ3DAXlE5OGyTnrexdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675601; c=relaxed/simple;
	bh=5mAS1+LWGgJpYGuVZClS7+j+9yE8HvlfPmFXCK71FQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qaTkYG90j5xfROUM0qBKMt0tcSkuKad5kBK8RgvClwwlj2DruYxtoNT719gsG4fOzBxnEep+ZbV/dquMJPQMhnnwewcmvqEJrL9t+yYynvVhJVK+7GekM7ZZe31O5TKSykX6w3WQUagcvRKdyIOqt3NF6mhles0tkKKvscWBnVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaCXFBgs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaCXFBgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711675600; x=1743211600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5mAS1+LWGgJpYGuVZClS7+j+9yE8HvlfPmFXCK71FQc=;
  b=eaCXFBgsxATh73pyfGBsqcHvgASgdlIgLbQ5usgvC2gqevkvybU5lZ+F
   tZQjHXd/xmRAXXxTcSnB+RYFP/XZeyu04wKe1EqLMZtU1kbyGFQQ14+vm
   xQm6FuMQ/8DAuS5Ea9qFRRl3MN5kAZm1vkVbPpPjLZbm9iGbd955IKpVQ
   2OW6iBH3Xqw6bLOI8bacyAYEA9O6qjio0UK1AecoESmw6Hg3DvYGy68yH
   GiIO86DNFJh4TycwjnmUFQj4GM42V9fMbQpI9e06zNkrT+ZvVDTgGoek1
   sWwq8/MSahlLCa8MVMkhaMHZuPp9UBudkWS/KHi+SuUOl+lFSqxu1umzX
   A==;
X-CSE-ConnectionGUID: tDtE6yCjSSu35DhAinOogQ==
X-CSE-MsgGUID: BMxT/W53QhqxeHABtZgO6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="32263775"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="32263775"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16865716"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 18:26:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 18:26:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 18:26:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 18:26:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 18:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzM+HbRJfeE6qztrcV4rp16MmVW4eRzepaMyPbDOJlGsCGWodGXw6Jz7Rn/UzORAFfJHr2rUu+Y42u3q8M4ilyNQElwp9IxRa01rNTkJeL0mu8dJo6pmheaYpKt1aIU0LNJhkWuKmKNi6SO4rmJdgPQLej3YmQQaIU2yXdphJgEnox7Xq/ck3MK7DmMSSjAHXLKcXO+a4H82RUiCBZjbalGgovDRtsPYpKgk5/v/4J3mK+NDJTiEC7TblroekUDeng6NesLKl82y4oFCxEbQ/EF2Ku2aWggb1dfc5U7n+c2iP/KBUyZ6y2sZiWxYTmsju6Ajrg6RqlxNxp56w+5Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKlw4xTut8FX9GBnmJIDvqp3QS9t20fZr2vewWRimYA=;
 b=WMhK5sR0pQkjRkA8yGhgxdGZDmS8gzdUyWNq4hYAwhM5dgmMNhQTG1RP3+xdA7HtgQdgmXZNBFIaP7a1X8SOgdn+DAJ8HO91TpCQMCiYyBWoE+ZBDyrF+NrWea8lhZO96OCqV4bdz4K6cfZRR0HIi4yN8/n7iBLxBDk/94dcHUFxRUO6yBSoh5QShddv6setU6BChk0Vaj0Ho5LKbOBYH3RLZ3MyLMkm18UROquMS0blq9qdtc5mtzkYHhm0s2JR25HyEE4HzvHr4r4+vBCZPpRj3mGUCes5UVJ9mx115qrQkwJcqP/0ag0YVJ3T/df8crE5hWEXqY+NTKPzqVh7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:26:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:26:27 +0000
Date: Thu, 28 Mar 2024 18:26:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v5 1/4] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Message-ID: <660618c154f78_1fb31e294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
 <20240325230234.1847525-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325230234.1847525-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8694:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoBd0bnzQeWwJGk57UAsEO6ZxJkXf/B2TTM/Fr8AeRQB7m86mwBAMjXyQmJNEqTtY9AUKoqmKiM/tzxyVmIwsPt2+6Z1wIGPwbIEjE1lXylJe7vntEEs7aW3YNdNQMC85b/U1ENTQeLcWj783T1PJ1UMO2i3FKj1AcG/7EdWqHakBTvn+eJXTBYMyuRuqrSbZRZ9uzyQ7i/O0RwV2SaogVBgy/ATLf7YzHpiXKDith/yrT2NxKPd9PeLYIMHWarqt4TL6oq9c4gUqpuaOT59HM3e8TKbDOw8Miryp2+F/Qr94xZSjjsiI4mjni2xthO3JomGZehmU6O9ngnIzojcuGbFfiSQQhRo04yBkeRQmL9MCCEXgRK/Se0EvQGqAtc+NKEN+Tufv2wt6cS/EmGOD14CQwRWElUkasZpdSR0e4X+kG7kA8HgvxHse9CqLHLCduwtrhrv7eE5OD+JQ+lnehN25rEo5QtkyeYfFV7z9bo1cI/WNkaOBgkEYUx+yOflKGv+uS/giTqU4gazegtLyfFp6Lf7r6wepADG89Xcejljhhmh32c4ac/vsE8HNZY5Kl9Y0VrZkO0Q6dBqvO5uatJP2PIwqZZfs+YmPelWg0E1bUOYmKdn7KkL89RNufdtYxBP/bRQg90Hdux4j3fEHWCUZ5OK2/1J2BeLdMosof8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+xXpI/6xKAMJWGNk8bqKldpPlX0cT/tMLSzraw3fDf4Tw9sLBZ8ZPmr6zi1?=
 =?us-ascii?Q?C0jMNu6As1Daw1Cf6b4jU8jM6qNRMecP6C48UzH+xjS9qYLJFk8FWkbYpEbQ?=
 =?us-ascii?Q?cp7dhqlfCCxkUjgvrUNvDSTIjJiIzpRWgnCzb5+hUSm0IL2kkptaX5MB5FXj?=
 =?us-ascii?Q?1sWuSW2ucNgy30502xfACkfKHbH1tvcRcpktZYLHOSNkTLNOhsCagMaGrJ8H?=
 =?us-ascii?Q?ZtjxzItZeFeb3bbKv7ETS3gTtQwhQBGhLM4YfhGRDIbiBglb4HsYEACfU08N?=
 =?us-ascii?Q?wvM9yLyxKhr0LbQDxrDiu1hvHj4KDylja+2Wa8/IRygNDbMKtcJHyqGk8OB7?=
 =?us-ascii?Q?KgjlehJ9+SYQiJ6e4G9ehauPqhwWWnbsBU6AHdbiZq9JYKIkjCMM4v9p/Wv4?=
 =?us-ascii?Q?32ZSkRTe0knLoZ5Se/Uj5piRGce7JhqM5xA30sjYNtsi1Kp4TSaOixhlUrOn?=
 =?us-ascii?Q?FrLAVlIHGyd3R0ez4UmEmN7VJOWbUoW9yTeveUJYHZJhT9VqM9zBTaL/RmY4?=
 =?us-ascii?Q?hklXYA/QDH1qBZSWmXodLFnzFxIfbkdgFoUC/OGyG68NZVcC/9ZBempqWSWE?=
 =?us-ascii?Q?hRqHWo71iBP/cf+fwNMMXXssWqkD/RGTRggtoId+P/NuIKRHVkI2ICxh3YGY?=
 =?us-ascii?Q?xucWbbiKRO+eyM3nrO2zEh0vXQiRj4LH/4JUW4byqq48/MQo1KJZ21p73dT4?=
 =?us-ascii?Q?CBL9w2zdkTp8ia4wmklmS9MM+EIVBMet3+kTrC5sp+u0IWbiX6GkJdPn16TB?=
 =?us-ascii?Q?vKCWTokTiuOSjpIS9zHxmOsvWb3G1D2XRjfjcJXh6RrUPPQ2gAgdNkb4v97D?=
 =?us-ascii?Q?ih+hNloiKFD7UA3ADRINrGRW6++Bob1iDg3YN9OnyZKm/yD3oT7D4l+eXjTL?=
 =?us-ascii?Q?sgZjuSjBkoohCWWBAgnngvQtGH3soERCeUjubI6pZm30X4CIOFsSGX9gHwLJ?=
 =?us-ascii?Q?YIQPrSZSTkSVGoj6l66ualvcBy+UvcjVZmuGPQHNymGgQdk+LQ2AgmArWM92?=
 =?us-ascii?Q?Ah7sniiwZ0XWvmyNV2z13ltWPPkoF1HFjgoSRB7VqBAfYE8LdGzmGn7Plc42?=
 =?us-ascii?Q?DPfrJF3jm7AobpwMiHvaRObqSAdhS9Jz7VpkQu86j40X3EgAfpnX1yA/Naqj?=
 =?us-ascii?Q?BquipJnaWIY3ORtndoIPKvsCXa/r4bT9++69AY/oa12WNxkJwYaCnv/MPgku?=
 =?us-ascii?Q?sIu2GUxUe6EGEuoWjvPLj26s9AQOp9OZW55eCke3Bka49QJNVozsbDs1o+Ua?=
 =?us-ascii?Q?+hl5o/LIBGWMNYO/t1UIaqicS5lminXEnwOQdlxptFovAE/0h1licW9RtuyW?=
 =?us-ascii?Q?AlZq/ZQMJnRGSBNZa6TUp/7ENNeKRSyK6PrZofuLArL/EDSIu8MihVTe2OLB?=
 =?us-ascii?Q?tbs2MZQiegWuH3nCV/EravkESAdLUE/AEk/lvofWR3EaQHcBfSWSKMmffaXC?=
 =?us-ascii?Q?CNWljQIWbD2xJpKSxuRa3ni3ktRHrhoWV53O0e0QR9LOJkhGhb887OtiudTu?=
 =?us-ascii?Q?HAing6iimX3YMjas73jLdce+0ixdjBBhX1zGA1FMUZJWB/iLQ9jcrIfwzMDV?=
 =?us-ascii?Q?jQXU2UF00nXP3GbzLf+GupNkO5EquD/HDWVO4zKlVrUeUAK4igYPnlimNKpu?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a47556-5ac3-432c-4f76-08dc4f8f414f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:26:27.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLdr2Wzt8gZ//or5aQy/fwqSV6QxXk8LPI0hyrqZ+1uSiVyfbn/C7I7qaHqlMa1gsOl5shR+FoUEswpOltNVqQmPUmL/DpECwuFt6Ci42io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
> 'iter' is valid as part of the condition breaking out of the loop. However,
> iter is being used before the check at the end of the while loop before
> the next iteration starts. Given that the loop doesn't expect the iter to
> be NULL because it stops before the root port, remove the iter check.

This description can get much smaller by realizing that is_cxl_root()
will always stop the loop before the next iteration could go NULL. I.e.

> 
> The presence of the iter or removing the iter does not impact the behavior
> of the code. This is a code clean up and not a bug fix.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Even though the changelog is not as concise as it could be, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
