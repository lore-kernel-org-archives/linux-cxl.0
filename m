Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBA13D88A
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895061; cv=fail; b=lClrn89X+cFaN9WAWRaTiRw8842THUSSLOrpSKUxYCOy2k/tEywCp2BfbSbQjIsXVQinUyDNHuPHpx5fmd4DhEPizowQeHzi52hAwk636muNaJ8Q1+tSsLDzFnIxhLsepb0Zw1SahqfnrGXJBFuLCcoemGJe/8FTfv018hDUiFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895061; c=relaxed/simple;
	bh=oFflqd69ufuOQliybkNnUONL+3WCTFeebUaPjGHFysY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IeiQNrJiKail9OvRm50E48eW7tUnu6XUJgrwaMDk0hHSO6uPaZTYaO5BcOAVFUN7E/iyZlqAfUnC+0OQF1nRZ3ntT3+21HPtN0JfLZzGXgeuroW1N5fYY6r3PN5ZXpXGyT18VC6oPZ4cOKuOLc5LCpU2Vfo9rrNOuJqps13xf4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq99NwsF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq99NwsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713895059; x=1745431059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oFflqd69ufuOQliybkNnUONL+3WCTFeebUaPjGHFysY=;
  b=Vq99NwsFBG4twcr/6mIoDwY/Ff0/dkjf2mqQDEjIY0X7OS/2T1GW5kXY
   m1reC2bNLdf24PX56w24nu2Y4n0feeUFxJ3bvnlExSno+1SCXd+pGsvgJ
   xD8th2PYW1JnIYpUNNCn/RSRjWAzFODWgDA90kUBPQ4ggrTszCgxFJPAR
   +89VYAXaOLBG/IUUF3icupe0K4nM1uz5WIUIz5T64qomLuh1ChCkW0pUf
   DgB9qOR2mm+bzjr+H0iJ2L+3QhbwJnLWxwTiLRjFzfvv7UV0/JhR+lJ7a
   99Lgys7Z4BYE5XidNhL8q5q3w8okzpc+SnqPffsLbg/Qza/hjlHNlUsS7
   A==;
X-CSE-ConnectionGUID: nw+a7YeiQj2A0qXbRL5fAQ==
X-CSE-MsgGUID: LcHld0nIRbKMfWnxFR8rRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13282746"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13282746"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:57:38 -0700
X-CSE-ConnectionGUID: PxgvCupxShqXyYuqrnW70w==
X-CSE-MsgGUID: oyiv/fg7TNiEyy1roGD0/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24417128"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 10:57:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:57:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 10:57:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHXDkdQEqUt73k4JxN+Zj0UMNRbZMz2X97P97DKaFW7jeC4VjsUHUkj7n/DB3FvwnR3ux092o8kp9GLKSbH59mandx5i1gKJh3vd8lQpGd+hlot4AWt2lG1RtAV2njGthSehJ+6o3YLmQ7oBrSkHfw+vW3bmH/K6fETQWhfFeib6yNYI+LPHZMwN2NZ24bz6KipnmeedFDBmxqBYbzzQMqNGZIwe8AbFgD5J9sfE0fCsjOALa5fjc6+qfW6uj3yx/ro1bqegymABvTvqTDP2E10CNUG9DPO+wLGpkoWoYJzhnTC24HDL1yJktKVdQ5BVcsoIf9p9JDBsG1Yb8C5FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2O71F53XUBNmg/CwgWrO30cTKhj5N2SjvDFvVRQzK4=;
 b=jHlTD98SiiOcVlvlh1dm4irOXuEQ+tMmz/PdaEVFtpmVTug5fJe7yBflfCxao2xy0+R1k9hlPWppbx0CEpU0EMxSsfOoLTNBhXe/6LLGQpPmNe3QhmkYVJU/zFNGSFKX1aJNbGf5tT8e3GjDOGMJ3bTI7k9PniN/u96gaTP0VV6Dih5EbRi0r1gjOIKnZMF6E4KStwnZTlUqdXWX10pectwlmP53h8NBhPXMTZ8KcszSBxyEtTwRBbytiqnrFL765A6vFYf7VNFFENgJorQmKkkTxOsIOFWQFjoa4ThKocJmbVVaNPh2ZBGHgwq4YK9YzPGpC0Ke5d0QEHem2PvpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 17:57:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 17:57:35 +0000
Date: Tue, 23 Apr 2024 10:57:31 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
Message-ID: <6627f68be4ff5_cd8e0294c3@iweiny-mobl.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 985e931f-51c4-4b3c-9600-08dc63bedb31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7XB60z2z/274yiH4TuWJwPJWKBPUppARFgQDLek+oFIsTdbWeKLGQzECD/B?=
 =?us-ascii?Q?rCysOyZ9aS8PsMo9JFfDPovUWeSF4/TomPDMN+oh667AuKvzZbQG/+PUiWDa?=
 =?us-ascii?Q?vPdCRe7rWRSMFUeikUXH+fAeWCPRAHmU8YbH5GGwoz3VEZgdG56qH5XcS9Bv?=
 =?us-ascii?Q?CFvhrJT1hV+3iY8SwcBI9QGD125n9mInkaRAoZ3Ou++hCD9sanfXk+sU2oJ+?=
 =?us-ascii?Q?tqGsrO15F7b43qzhnmu1x7jVEVdlFkjU/R2tq6J5NUxhlDtjeJrN8CEn0AJD?=
 =?us-ascii?Q?wRcU4e1BrcxbVcpfQ2GVlJM/UA2H07Q5/pCuZ8nmnNnj1Yyg83BVAATI10o/?=
 =?us-ascii?Q?+dlYT//9/G3DeR+Kt5Ig2TM+24+uWYqiGSqy/O52ndkCZ6HecRb61ltWXtFq?=
 =?us-ascii?Q?+TaeHPDfjzQAmUXMRaJlLmqvHxrYD8UXNqB2rvf8rOzaKewvlWDDGz4qKnNx?=
 =?us-ascii?Q?8+P7IpwCifOFwQAPlMk0kWhDdXThh4zRXOTqM0nX8c+fV74LLt1WtoRnY/QG?=
 =?us-ascii?Q?VXs9b2t1y3cytLh7db9sJLng44tHKv7nRNsWZMKtC+X3p9Th+snzJJ6PGtNh?=
 =?us-ascii?Q?NuIOVzNq1rmr+hIAQHNC7M/CAv8I+J0DzWhttPX+FhJH33e87G2DcGtxuQds?=
 =?us-ascii?Q?SPrsU5vkhhehIVyRRy2RSq3uEDMh8v4Rbgap+vHh7SP1A6KMvliYdIkQoEY0?=
 =?us-ascii?Q?tBd9lOIXvRbGjifKxifRcRARUpQEB+iQRY0gulp3mfS1hxU6kNRJAZpgYYTs?=
 =?us-ascii?Q?YUNCSmC81E4uhao6hBm5NzBAAwdQIgqQj0FXTL6SgontCLyGpyAfxjUIJ+A3?=
 =?us-ascii?Q?9Gmnc+lLs3Lbr+fEtTmQzbQzhb1Z8zuOLaZruv8e2iPB1RCHNnVnXvokO57S?=
 =?us-ascii?Q?R1rIo7jLbqzG/BMoCNRDFGNQ4PJ6+tSBYMB+3PjLZ+4DkxR/9vnKyW/fr903?=
 =?us-ascii?Q?vZ0tnk5B4THOUrW8HAorVq0riD834dASAa65s6DqNFSzIT0aNSB10PDIsStB?=
 =?us-ascii?Q?nMmi0+XVyZuTvQ8fmypTpuXFPDlvL6+gVQJrwnlL3V4mKtDkhKPalsHbQjgJ?=
 =?us-ascii?Q?FzQHx0JE5CJ9sHG73j3qDLj0IyzEbI1AOgiVHnEHvX3kbBKpI2hovqlXnWty?=
 =?us-ascii?Q?1hAYsTfXfCz9LVldV2RRp4oPr6DIC0UWeqM2JqQO6BWJJfR4Kx5hAG2opxSf?=
 =?us-ascii?Q?1py75cjxEH7JuoQlQaOi/D/A/RVHG+aeukWTMlCbSjq9HL+pVvsIxWIgD2qD?=
 =?us-ascii?Q?Yu7F2ncJjzVoEkcZv+7Mg1TdtmNbjJH7bn0Ucq0zRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5lMw4OOKGQtmTxZWZlit7bnZ13KfdLe7SkSmOk4no/wH0pqSA41sJPop8c4?=
 =?us-ascii?Q?Voa3uYYsP8ZUuP85ME0M6seOvQH8kLVoNubzTvFLHBv/0arbNBiZK48WRn6N?=
 =?us-ascii?Q?fhBKzLKIuq+//yZ21pqCH1MrjpQoeP/zECRjU57gen3zEfuey5IBIFiE3rwl?=
 =?us-ascii?Q?qoZv0qXyn5o2CEA64cfx39rDWuaoCuhvfqntuAoFbbYiKyu8LXm2Vc/2YxdT?=
 =?us-ascii?Q?21So9AOv/gSl6DtZEX9KXQInpEERnS8eSsdVr7rcuqoxeyc9msXxixuOg+jI?=
 =?us-ascii?Q?kXZHdWsm8sDRyj6tCMzMV3sRt5O/4h9EnLLIiQ6kwjTEi1TqfbtNbVIABUZH?=
 =?us-ascii?Q?Q5q2Os4MORJYlqAtjKutHVdfiH2dF6wyd9l3woy1Z9si/rHUOVqmvUu38jYB?=
 =?us-ascii?Q?nt1ElkX5vtEkYjAw6O9qqEbkxBq64Cb4l54CH43ryfo2wezj/tHcbuQ/bkkY?=
 =?us-ascii?Q?BJ1PwH+vjDM/J/qtLbyyLyjwng0yhd+RhbkNNmdSVbMBvyEXtFUTWZfkqQKy?=
 =?us-ascii?Q?Ru6MQUFdcDRj2y6GgA23tIOcfm+a35dqhVKckEyKEvzkoiniGauR1KP9yu/W?=
 =?us-ascii?Q?pSD6R+iUJd+jw6J0bVacTuZmYpqaM1plnaN+5ZnrE9pHkE4kfarZuwi1dkSe?=
 =?us-ascii?Q?IpIqvSsVLKRD7mHVBETxPhIywE6uWPfVTd+jN2VKb534Dci4zjQ/LK8Mdttb?=
 =?us-ascii?Q?HglEqbJDh19qFfUeye5R+fgOET7LV24Nx0xY7IaBs/XiU/L626WoB2+t1/TK?=
 =?us-ascii?Q?cSBTgnOdCyGtj7gCa6Mv8kW+DgFzygIdwMUuVApFd88VrNS3Gt3RslzMeHuY?=
 =?us-ascii?Q?bqwaTbE7AIYV2E5hOK5K77K1Y9K4F7STW5/ZlfXYkixUkJSOnyDIY/Ux1REQ?=
 =?us-ascii?Q?2YS4ocSLQVRzDue59ZHuffcef1OVhccqbgIa0FpIkIVs21Pk1qwKzHIRJ4Fp?=
 =?us-ascii?Q?uK8F4YZJ32uBguYFuYORaxtCRQoZgXZU8WhB7jMAT6gK7RpZt4kz15AuGKKV?=
 =?us-ascii?Q?ipAtUtmQqTb69tmEq4A0DTnijS+Jf575DzlNlA4atxGFToiRxV8fw4FK0oex?=
 =?us-ascii?Q?wC8UUKPCniPN3IUEUKUvS490G3XUrdCZqVVdSnjvPXBe2vYKEb/Ft9+hzpHv?=
 =?us-ascii?Q?AmHURKLgaEncU+N+0fNYPjq2bCPjq2Hj6RDWIYrE7Hto2ie4Y9ufNhEOmsZp?=
 =?us-ascii?Q?JSXKtp1WTVwHpPQXdMU8accoFUH9xEzmzalk/P0oRXmFl43j9g36BfrhZepJ?=
 =?us-ascii?Q?pODAUYzjPvXWTed7NG2w/sXeVOOhlLHoY/TLZMiDy7j+iYo6Ic9jsuQhVlZS?=
 =?us-ascii?Q?jIEllZEERabq40Qv6TjAlYk45R8ADV6wkrA9J4b8mm4HyOHjYQ6a2t/RfBdV?=
 =?us-ascii?Q?kCkD9dyVjilgc3ChmAorrTePyPmdb53P5okqYMQhzG8TG2XEu2ai4JhzLob2?=
 =?us-ascii?Q?0giqBqdcAweEpjPBjCxf84735n3gWdJAJBqX1/ycGU/n+Mb01Up4AOoY2ALF?=
 =?us-ascii?Q?DtuAj8MBt738iea66uH/QjibqWAELQB0MP4zkRpWqN9pnIcAzJmcZuCLZrdh?=
 =?us-ascii?Q?U3h0WgqyilVftgjcwYlDFk4QTQzhhY88GNodnkYe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 985e931f-51c4-4b3c-9600-08dc63bedb31
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:57:35.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5tChUZ74sXbbduDpYFJZN6ov0boqO6+5i5WsFXR8+hKV3UoLjjnWeKw5iHXHsKiuycOh/5YaqWWUu6JN2PB3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> Currently driver only traces cxl events, poison creation (for both vmem
> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
> could handle poison pages in time.  Per CXL spec, the device error event
> could be signaled through FW-First and OS-First methods.
> 
> So, add poison creation event handler in OS-First method:
>   - Qemu:
>     - CXL device reports POISON creation event to OS by MSI by sending
>       GMER/DER after injecting a poison record;
>   - CXL driver:
>     a. parse the POISON event from GMER/DER;
>     b. translate poisoned DPA to HPA (PFN);
>     c. enqueue poisoned PFN to memory_failure's work queue;

I'm a bit confused by the need for this patch.  Perhaps a bit more detail
here?

More comments below.

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h      |   8 +--
>  include/linux/cxl-event.h |  18 +++++-
>  3 files changed, 125 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f0f54aeccc87..76af0d73859d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
> +			      u64 dpa)
>  {
> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +	unsigned long pfn = PHYS_PFN(hpa);
> +
> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
> +		return;
> +
> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED);

I thought that ras daemon was supposed to take care of this when the trace
event occurred.  Alison is working on the HPA data for that path.

> +}
> +
> +static int __cxl_report_poison(struct device *dev, void *arg)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
> +	u64 dpa = *(u64 *)arg;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		return 0;
> +
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		return 0;
> +	}
> +
> +	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> +		return 0;
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	cxl_report_poison(cxlmd, cxled->cxld.region, dpa);
> +
> +	return 1;
> +}
> +
> +static void cxl_event_handle_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	/*
> +	 * No region is mapped to this endpoint, that is to say no HPA is
> +	 * mapped.
> +	 */
> +	if (!port || !is_cxl_endpoint(port) ||
> +	    cxl_num_decoders_committed(port) == 0)
> +		return;
> +
> +	device_for_each_child(&port->dev, &dpa, __cxl_report_poison);
> +}
> +
> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
> +					   enum cxl_event_log_type type,
> +					   struct cxl_event_gen_media *rec)
> +{
> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
> +
> +	if (type == CXL_EVENT_TYPE_FAIL) {

Why only FAIL and not FATAL?

> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:

Why not scan media?

> +			cxl_event_handle_poison(cxlmd, dpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
> +				  enum cxl_event_log_type type,
> +				  struct cxl_event_dram *rec)
> +{
> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
> +
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_event_handle_poison(cxlmd, dpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt)
> +{
> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (event_type == CXL_CPER_EVENT_DRAM)
> +		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
> +	} else if (event_type == CXL_CPER_EVENT_DRAM) {
>  		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> +		cxl_event_handle_dram(cxlmd, type, &evt->dram);
> +	} else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
>  	else
>  		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>

Why all the churn with changing the names of functions?

Ira

>  
> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				     enum cxl_event_log_type type,
> -				     struct cxl_event_record_raw *record)
> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +				      enum cxl_event_log_type type,
> +				      struct cxl_event_record_raw *record)
>  {
>  	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>  	const uuid_t *uuid = &record->id;
> @@ -867,7 +958,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>  
> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -979,8 +1070,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			__cxl_event_trace_record(cxlmd, type,
> -						 &payload->records[i]);
> +			__cxl_event_handle_record(cxlmd, type,
> +						  &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 36cee9c30ceb..ba1347de5651 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -822,10 +822,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt);
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..8189bed76c12 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -23,6 +23,20 @@ struct cxl_event_generic {
>  	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
>  } __packed;
>  
> +/*
> + * Event transaction type
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +enum cxl_event_transaction_type {
> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
> +	CXL_EVENT_TRANSACTION_READ,
> +	CXL_EVENT_TRANSACTION_WRITE,
> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
> +};
> +
>  /*
>   * General Media Event Record
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> @@ -33,7 +47,7 @@ struct cxl_event_gen_media {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	u8 validity_flags[2];
>  	u8 channel;
>  	u8 rank;
> @@ -52,7 +66,7 @@ struct cxl_event_dram {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	u8 validity_flags[2];
>  	u8 channel;
>  	u8 rank;
> -- 
> 2.34.1
> 


