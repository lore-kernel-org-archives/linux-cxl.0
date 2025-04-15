Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33B129A78;
	Tue, 15 Apr 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752820; cv=fail; b=BS0v6pgS27AAYdFx/q0M3SPcoatmdLCkMJxWxg2IoumdVl2e7MWCUTuT4/gFHj98T8DQjSYNws5tLV88KlP9m8SP6mHOrTUqthDcaV0aKbJtiT5DSy3OMyqr+cnh1uSeJ4F5RjDVLqQ3shKdIivb68Q2QVH30OEHbxQjdHV6Ye4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752820; c=relaxed/simple;
	bh=uSSeBm5VKpbcre8aEwGRxgT7Y1Vc4YWKLYwMNIBks4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eXT0uuxHW4Jhuag0PtgUnWOAvgvInXXHDDTswRL/QE79su8YwuDkr7UOlskmZOE8sySTgSlj9b9/+tQSJ/VhyL1upIM8stReLkcYK7TQAajj0J7GKBUXIMvb2N5rh5r0NXF8PD60zFyhakpucG0jSxmvtmQbtyDeORB3ewxGsCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG4Rzd3y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG4Rzd3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752819; x=1776288819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uSSeBm5VKpbcre8aEwGRxgT7Y1Vc4YWKLYwMNIBks4Q=;
  b=nG4Rzd3yJ+3ki/Zbjc76MedcNppvCEIx8oHKAzsJM1fGsrF8YgoMXYNk
   icdPG+pkYvrc27PgQBFm5q2VdCi4RoOnYJwFoMQkVlJ6lyzmxIXZ3NUw1
   n2pabFajwTTs3QjVFcTYXOBKuvd2AxATnX9URwiGmxIhY83Hi0ErWFOo1
   HFn0fuCjp0idsDVFoENVsunPZrQ+miP7FeSmVuFCiFmd7DUb2vP8mWWsR
   umcAHE0NeZBe+jbBN5g0yo34jLx8mCKIUD9L30aMsLOMMWQfDJw7L3KG/
   adSybsdHFetXWwtsnCA7wEu8GSKhQlPEW6VIlrnhKd7qMsTZUhIJWTIio
   Q==;
X-CSE-ConnectionGUID: twwt1FlRR2S5fGaLv7mjqA==
X-CSE-MsgGUID: yEKyrNRxRK+xf0g7CSF6ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46298541"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46298541"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:33:38 -0700
X-CSE-ConnectionGUID: SOV6LWctT4eVBsnDXksOcg==
X-CSE-MsgGUID: JT2lGZjURzGv25Us0n+flg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="167412502"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:33:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:33:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:33:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTkSVQI7ijoU0rDNRtgz1OpkcbfJ1inJsBaJWtsab5Y4WzI2nuKU918CyEH+zpoFwMEJXCepff77NWdaudTRXVM0tdkd64HyUg9v5uMtIdnFfpw8EbWlCn1YHvUAZYgyQ/hDe+n2ouMZodssOC/WD7Ngtr3GkAXHLYAbY1cT7rA0yocXIop6FFnoQXFzML4UvWi53SATyXqTmypf9DJSeYWxorghFuH8S6R+ktmyLQBofdr2m7wpN+YlRH4W7EUxek+1vRBY8ba+ffdZJRTm1Pcg0eT8+btyb0bv8eAD2bmTa0Flpk0HZjTyB3aZiG3roXML4scGRhoN0k7ezwUbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElQZlbt8BMt4RWSy442RqDVf/YOCRgKR3O2BynnB7g0=;
 b=eobuWayneW71zXjH8eW4OywSqT3i+BHX+Q2VRPyQiVpIbv7nYaAzF219nAyh4GqgewXKQchJ0C8aGPie6Ry2Y+RstBX2CPOkXStU8A3hrrerTV8Pw4/7/YYgryy0yxFpTa98/15U4/xSESBG8c0E7RA0h7oBjeX45w7xi8LRkdXD5HkgwFP0Z+OhgZF0b3nn/Ibfj0Iu63sbPoXm5Nl6A0ybBaNynTmw9NEXHQ9w85ijzTE/CwltAk6k104qA9/clk8IG1grbRt16xuL6EzFqZod55vqdOnQSO1TIIlJ75MACFC+XHB3gvQjp2Z7GY8gcoacj0lA+j4R5vUs9nYmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:33:34 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:33:34 +0000
Date: Tue, 15 Apr 2025 14:33:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 09/14] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <Z_7QquqsT5Y4nPFV@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-10-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-10-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d29834-da58-401f-46a3-08dd7c652d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Yb45fNMYMCgaho7GVu07bo3SOObm42E4ZIZhu22+q//fh23UpjZHTRKjmHy?=
 =?us-ascii?Q?mnDcgY9OGBTaSRtZLA3NidOF8cPvAFglzhrcZp7zICJG9ooCoI4sV8jYMCd/?=
 =?us-ascii?Q?PHaVYnVQZM0PFAFfkZDDGbO12mxXyd+tCV58hx4rR6WGHi6RT+ZYu9eQX/Bv?=
 =?us-ascii?Q?FHTwdI1T5V3NvPzHHwgbA9q1iDj30+YsvRq99XV0xiP0pC0WkS5cWxcbwGQM?=
 =?us-ascii?Q?tgTZGLu6j+eb7G2c1MthgVARysM0ihmZSv8mT0HVBq5Q+aYY+dsu6zJ4wfhb?=
 =?us-ascii?Q?KfuYXhDCyxVfe+4jdR5Oiu6xeqBSUiARw0SWisctFLDQzCEuiY7IpdkND1+d?=
 =?us-ascii?Q?bgwXg5mxP12W7xAPrTIHgiCT30yge9Cwl7BZxq4mM0M/doGeVFXD+0e6i1kQ?=
 =?us-ascii?Q?K/d82F6HgL1ISiFUgAgxZm5K5H6o/hKYC/wnNqrRg2Xj8V+VjbFJgCBsQK+x?=
 =?us-ascii?Q?z5kRn3e25BjYFqwP2YlqIdK+D44W795z41fmxtA9vHFPlBGU59WFqaCn1dlt?=
 =?us-ascii?Q?MPSdUPH5oVztE2/dA1kn5ECPLypl0euKzAW0KN/PoSe2U5CcyY8ZAfILDC5M?=
 =?us-ascii?Q?FWl3XX7Wzc4WnEnShfJwnMZeo0vWllt7c48rcy2DneTvDHdihTpUzL3OI3Lc?=
 =?us-ascii?Q?edfHX7XpaGjSnbfEddfC52p14TQppAUGf5iclZ3/+rKUaPkwG7PHLBmxTcOH?=
 =?us-ascii?Q?l1vstGbJ30T/pqPGpofXFDdEoGKqjDyJzvTSDyutBn/sn2lmNnTBGUobHyj+?=
 =?us-ascii?Q?1bjrN5d/7TSW0t0S6sHyt9E/hVxI95cr42gKN0M0WvOzBQZ4LTmHRRBmy7Ve?=
 =?us-ascii?Q?p2XE2f3cSrg0u9w/kQbBrkHAsfGIXMJQhft00aJHwEb3TYuSxVlw9GjyfAjB?=
 =?us-ascii?Q?BO+/Uxssgc7ULJaWejIpqsElktrlJkQIRK4g3Sv81Pl/8fOkEIw7MWX3xi86?=
 =?us-ascii?Q?9+/Dhl8pHz68wVkO1KyuolSJ/V8IfZ+DwDp/ziwYIsbBo7HNHOVKTTo6F8BG?=
 =?us-ascii?Q?KAw+cIxR/rKGNEEfv4pwHH2Bd+5eCqJaYfzS8+l00l6GwqYqGKcTvrgsEHI+?=
 =?us-ascii?Q?8pMnXyWbv53qXs+zmCZIbiW1qbgr40DBhkihmhswvdVLkijvwLXD1iHyY+Hz?=
 =?us-ascii?Q?Oy5O1UQ3iEw9SJLTWQcnUIaqs/u06vhM8ePiPtw+yxnHhHMKUDwM4IitnqrB?=
 =?us-ascii?Q?ky2LJoFQ4iZoBr9nrTsgGWwYo/zYFIBY+rDhdTxGSfnOqVB9RpSWScf7VcNH?=
 =?us-ascii?Q?qyJ3BcyEen8HsrvzcAvnZPDjgYkqPpCASNKs8PK7Zjhdyq5Jevds67xVFCjH?=
 =?us-ascii?Q?XtX4JiCcfHkV7lFBet91Z80GD+k/Pdvt1lW80RBeTlK+wFwvVPg/pxF+6y5v?=
 =?us-ascii?Q?VYnvEDJHbzQ0jpvCqBGMvsiZ2Of9xBxsb2QZw4QH9ffXiFo+rFRNjvN3M1V2?=
 =?us-ascii?Q?nnSXVAn9VDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dkx66co+sWINMwvOW62M4a3VBW5IPBU1kHxTSr4MoJ+93/6V/NWx2lV68yk?=
 =?us-ascii?Q?99lc0KanTea4EZTirwogckhZPn3QCJ3GGF3M9yBQlslURRud1P8vIrMFHD8l?=
 =?us-ascii?Q?khZqr+cP8BbQEDS9LY0mWACT9mw/sobpFQiRwjl071l5VDiaoPS9MK0Vuoua?=
 =?us-ascii?Q?Ynn5zLQP7a+/Qhp6TF0aHj7Cjk4jl9gqIlwwyx+pcOpuwh73KP27J+8Hobax?=
 =?us-ascii?Q?p3NoTz9fI96SvMi4GoStU//mSsgMjfduSR5TjOeuP2nZGisO+VMght5DmHHP?=
 =?us-ascii?Q?+PRvpKABJTFmrS8Lg1WdsQ6JZIdYLMgPlYz/6TGXYJS16U93zPA/af0+tdHV?=
 =?us-ascii?Q?165IB6E5Jpy1M4oMuvlQgPnH48LoEXsk1H6FQ95hRuw/9+UBodqSzSim92Y+?=
 =?us-ascii?Q?fQ5tfRho0PJg3KRlXNCklzJwNkL4wHpl96f4m1bw/xhH40rFvG+ikkKL5bBq?=
 =?us-ascii?Q?XyNm4EmtnypRwuvxi7Go1mYa/8D2NKH2IPkQ/Y1FU/dLsLtxDKQZbKJy66qi?=
 =?us-ascii?Q?jA9x4JyKkUIVivSjfvtSjjfJ2zZHXFFVj4uGevfeQD3/wYbDfjUe7gqTWSvF?=
 =?us-ascii?Q?yZsZF6Aru2CSaFr27qVxk315uRu3E6NbOUJMkxtbeaZOvAYiL4PsOdoOCl+1?=
 =?us-ascii?Q?+EYbnBHwzBEAN2xs4B5Vjn+BKXa2/P0jVZudSIw//7hvIAQ6WrULPLwRC16q?=
 =?us-ascii?Q?QxJulDLqrvUWPL0ZdWaj2Ko77zBSqcVKwNmWxRmCzpsLtOvjdhRekuVPiUtE?=
 =?us-ascii?Q?/dIrpzJzsBRLSM3kjBVnobcvo7+I0M3YJbGaI6HqBW5CevWBUWqs7HOVUSN6?=
 =?us-ascii?Q?Gk8+st/4IGYNjmT2jAccA/FCBY5AwmZtYEHZ7UPhmMm5YqJ+MC0f6DfsBjnQ?=
 =?us-ascii?Q?ZqGMj1bYzrrjnyXMKT//Dx0eggLSlGFoPBhJ0MgwL1eWhEkpqaoWXbHGPp6s?=
 =?us-ascii?Q?0+tR5x62clQEBBmeEEB7h7Umsu2guwxLuSopwwR8qXqEWHysoxckb58OlJaz?=
 =?us-ascii?Q?SPp27yHBgqtZ0yzwII/c5whoJpR3ZG+hd7EhTwmq5oBxe3qwr1xH4O5vMw/l?=
 =?us-ascii?Q?6OoXuKnD4i2ndX0302FmhcBiBFVD/rI7D3TJ84GaHdDc83iWJDRffe8n2q6C?=
 =?us-ascii?Q?bmP7Ci4NKIf6PvMd2db1Z9bUpDGFKiCtcnVL4eOwZku69ZW6Mk0cfm3w5EqX?=
 =?us-ascii?Q?s6dgwtMmTXOqFegbsPkqVdgL6gX4UqWq1BzbTmiWPBppy9/ITYjWfZaArqpr?=
 =?us-ascii?Q?TSLxfCHlbG4tw8OQrbGLaNU6ZZ4A/0q2FpIGLEx1TL3rEIYSu1xELXkYYOb5?=
 =?us-ascii?Q?Jay2smGTRKvzMUQReIe+gyU1AwDImJKJR1pQcsyYxSDI6N34FcU8n/SbWXjY?=
 =?us-ascii?Q?PRzCkCs2AGaAbQxoNX7gly7LB5wdFIQIRGpHLaHD8QzHXugr15CfvAw4qBaE?=
 =?us-ascii?Q?x9kQ7u/WkT6EIUqIFBUJgqTiz0ABro6r1czgn/w2sT05e2cCZ3G34oxDPeWA?=
 =?us-ascii?Q?0DW1GsJ3rtho5tUdLjfLyE2e6G1tzHAucnZYqW5oiqN5TrAhfYfS2nfDsERC?=
 =?us-ascii?Q?TECGNcnZon8bwgGSdMs0DmUa6VTsHO5lZOettqaoAei0k1Cr+gok4E4LEPA8?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d29834-da58-401f-46a3-08dd7c652d04
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:33:34.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OucVc5egb1RBMQdHbfgq5FbWxss+S69I7EZ/aSydblGLVbIpaFZxVgtpySDEptS0QTohB33dFR5SRtT9coqOI9W9vqQhyTqgag63/BR5yq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:43PM +0100, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


