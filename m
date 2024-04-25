Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437314E2CB
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065769; cv=fail; b=C48K6ky7a1AlfYp5HF+JRWBQ+dWubN0CzB6pgF2GcJVb6VacS2sTZXQKbMvLSe+n1GNu5m+MUCWQO8Hg2oCfe1wSn/a6QW1DbRgPIXzZIcTnL2RWq1W8MhObmYl6Hqk+tG3c+3+oGq50/fvhh1vh5ExdhJVaNfHUqNpe4QcYMIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065769; c=relaxed/simple;
	bh=Uaa3osuWeqsOUtvMqu/AQm7BnjAbB4PxeQdm3bM3EmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCI3BdFjRY4DJQCXnOtZ7UYAgjOakYXvAqdFsyQ+66HEZIJERz2tOHGfdNohMCyV/z1fYDtoBdokCLv5bWSsYW8Hm5qOlcpuW3g6hH+AY18+aWh5eu5Ag/y8VBVYL1PQRcPgE/YbRHWAj76UeZVO5fi+EQL0CBelILoCypSAPg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNt2+/ta; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNt2+/ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714065767; x=1745601767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uaa3osuWeqsOUtvMqu/AQm7BnjAbB4PxeQdm3bM3EmA=;
  b=nNt2+/taEY1mbZg1VwXL4do3rJe7Tg1c0qgEZgRJ9wsZ3Zi8I3xpUf0W
   6WQKtXVyCO22UrCBtU4EyIf7D84eCvIn7jKvagZZugqv7OAoIX0Zie0Wk
   LjqW/lNN08aXBvQ1NMPgXgK+MpF+HrLD9xKYXrCAFf2BfNK4F4wI8RaQQ
   +ggzc1U/TZwPs9TqZkrYTWvyoT4Db2hE/87CXefO2w587HTVMgBrfBqxj
   sk4vDSwnRKgbUYEmioFhG3UWv/j9oDOiLqVNgwsq2UOdokUj9yDBSoTQ6
   f9mxK4AUt5zU1NIw1vE+aFlNHtpFdC2dSNjztKaKI5bZDs1DO1p+4C9We
   A==;
X-CSE-ConnectionGUID: INH6gfx9SamEnbgkKNANqA==
X-CSE-MsgGUID: KgSBJJRfSwyD+dZLyotYOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9890132"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9890132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:22:46 -0700
X-CSE-ConnectionGUID: YKo9Gu8CQ5uFpvDSHcp0/g==
X-CSE-MsgGUID: C5tzdW66RcaF8j3s3250ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25159385"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 10:22:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 10:22:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 10:22:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 10:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkiMPNzJdeYvKICMD8BTp+bG7IinN8WHDCNkdXGVJbq9vXjsG7yaN275cwLu0gMasHBUkusQVL3g0a19Zz9F/y5HCjMVX4xgiwUt9Y8mjy7nAHglnNAt2qMhqIhOg+sTlODC6ckWR8asQeBUwkkKzfDpb9JJoQog0gqwNFLcN7ekABe3V8sqvDHYFbz/EyYbxeaMnCmcTz7mKyzTHSIvXU/8WCAB78Pe2IFziA5ETEM0+DfnzS4rgLA2zbujlUSaSyUH+uVhzWoFVugivEqM6Nu+7LIrhRMmFkVWRORGnnoOO4ktYVnNfiP9nMtJ/CCTGULYdtNVzdg4/xeyQEblOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTKZTlXbsVtwA5TrjvDOPzyx7eE3mFAECZg5R/N5lt4=;
 b=XcZtSrFbdLP3UrwtqGMWxhhxHyN8OVLtCgqnan0ooSrA6zBQGGyC31g4n+PsBe1teBJ3cUmTTsCylWOcUYlpMqGw8ICxsZZabjnngqq3zKW7sB1RU3xk532JeIXFQBxfKIjmtCl6gHtBZsKM3MTK05WT3GJsyc653/3OPfzVJxsR7yZFKmGQI5vnDBBJ2Ma49BDPGB+Bg/H5grXAJ/N6PLBP9owMMUlP3sYYAU5liFA903ibQCjPk5BmFc6GONaZmesZVoU0cqUWYExru7Tulixzz21YtYeYolpkfcJ2wV9j9W1LLW5dFjwi+WlJg1hTaQbDr/dlrwCQxdjtmjFQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 17:22:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 17:22:42 +0000
Date: Thu, 25 Apr 2024 10:22:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Fix white space issues in
 __cxl_coordinates_combine() function
Message-ID: <662a915f1887b_fa7d3294fc@iweiny-mobl.notmuch>
References: <20240425170114.843163-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240425170114.843163-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0029a73a-bc18-404f-aa12-08dc654c5044
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vvCvxa189CsNQ5Or2xLfaMNd1qu7Hoc1CNl/nakr5vqtMk3t7Lz9qFK3ig+M?=
 =?us-ascii?Q?SMfwK0SvGcwfyst87EL74DG8zXzA6+ZBe/Sde2qsR8Ttu3LiTQUM4sD+FNUp?=
 =?us-ascii?Q?3P/2zTRXKdve8/4KXkIuUe9FvBuxJnM1EvXi9U5S0jd+PzCWWSM80syXfBRL?=
 =?us-ascii?Q?YkY7osGeSV4RlNWE62Ap2KYIqbHDya5t7r3aMYqfHNyDToDsnEPOT2CN/gPc?=
 =?us-ascii?Q?Cy3VfghwJGti6w2WbnYwR3PyqoqUz21z0SIEika1w4RaGzBVnxd5Gr9I3EDx?=
 =?us-ascii?Q?JI8v8I7kZHufpL858E3+VLpFiabq1dR4OSSnIe9FzWfRtNy5OTeGEPtFS4LC?=
 =?us-ascii?Q?z/NoG5br/UtR5C44rKLyRXQwGqD0EYdUuwacK+Gkh+cWnOhdwYNRUfvNdIcb?=
 =?us-ascii?Q?AhNanjLV86JCox+P33KxJw+J57teyg3eAkhQVBMqRkeLQRavIa4yR/Ux4ixE?=
 =?us-ascii?Q?UPzhXhzH8ZHlRtuKnH8KaeZGm2+qiaZydUZaMc8AIL1rdJEjJjrV1+grmyQw?=
 =?us-ascii?Q?kKTQzEPH/bWrucKY5SWs7mElRhME+0B1hpDNmx9zLgF3/p4FYVgykTbQSFyC?=
 =?us-ascii?Q?NT3U47nfWk3WeH4yRn1iWfCOIsrVAvkx42ZglbV6EoK78WVUT402R6qzhLm+?=
 =?us-ascii?Q?bk36flIJDe5XjjUnHuuuQQD3TfiXd3RjvL8Uen+Nyv5m0q4+EBitUxh/u7hP?=
 =?us-ascii?Q?cZJZO/zvXHa7TKVoeLVgwJjAX/QzVAD8OJF3kTwxSVlbbOVXz3xJj9YzFxd6?=
 =?us-ascii?Q?8UyXLeVaAuOh8UiwG01YH5L50XVNlpCGVrc6tpe4Xm67fwk/WfkFBTtB7hyD?=
 =?us-ascii?Q?RZ82v2E5sTw4FYmODDBc/L66kUveIdQt20F+TePAdcrAWlwHX4PqL2n0xPhV?=
 =?us-ascii?Q?wfn8N9lAZcI0KjsZ5cKD5aOeNx5YblN4T0cJfHgbusAWLH5ZlYlhh2HdmlBF?=
 =?us-ascii?Q?ra4wwAw59D7IeNEzCvkBKCmwD1YPoe84aXMF4noWZIfd3HrzHhHQ0lCkDeAN?=
 =?us-ascii?Q?7lW1V5zztrRqrgy8dtq6zi5g0TSGaDsRTsMBt7Nzu5RBuUNJtBa7pGmll9E9?=
 =?us-ascii?Q?ueoM87eQ7ESibHXhIerphFhjwVFWfuS9L9Vn+ePH8obM6aVHLa3WV/IR5vMP?=
 =?us-ascii?Q?drqQ47QzUmXVXWY+OrfDcuRP281RyFnh19Gf3/lsr01TzbkNXiYhifeu/13+?=
 =?us-ascii?Q?dqwKlBXmT0tM+PF6jxy8hTZIna24eZ4SiYVFh4+80hGlOqYp004gIZBnZbUt?=
 =?us-ascii?Q?LcNxTbWPJhDeCzotMB1jI7M7NSuJZYFVnW+eb6NmPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1D4SSfgH1vcLVKsnkoD4/U9ryOtGWAomWDelQsdBxOUzI2jhGeKgBhmSgKQP?=
 =?us-ascii?Q?SsTaJQbF8RoTDw90kWb+BKYIeLfEoInsPY1YCtPpxjxwrb3gWyUiSHaTjc/o?=
 =?us-ascii?Q?iOIu7ZimKwn3TVumHnXbUGpEP66lxQE4jBxGXOlzVAiafMvyE+XoMdUmdHd/?=
 =?us-ascii?Q?/3XoIUyNdLtwl+lwjcVIfZkAamkgoB47RCQmnrmsMmWX+ceJTn5NhpjmzmkW?=
 =?us-ascii?Q?eio1TX2otdBefbgQqpq1FXYCTamaw/XVWM5+TcY5Xr3SEfkAJqFanuvve1M6?=
 =?us-ascii?Q?GMAfTNIPPF9DQw5bVHQHXcv/jLeg3FSzPQ+u5snYMLfCmYWeS1WWQ/J6NqTR?=
 =?us-ascii?Q?sHHy3xcrUbpEZMsErJR11Tm5uFQlksUss6eZR6GhdbN2GcFF8ya0/0Zc/jt7?=
 =?us-ascii?Q?83CNb8nJTK0qKtgWGPte0UYaGLX461Mt5X0tiBX/UEETilyGqHE18WUAzz4A?=
 =?us-ascii?Q?gIPoxqU0RbhKUO//7+7/WDjwPjEzr/vJ34HEgcrfFCbqd3lVj3xiEVjUrGR5?=
 =?us-ascii?Q?LL8KZcYUYjzUH/fUBl99O23xiIu5b9wGASKwUiLZpw5Sr753/D3BTbAnQAmK?=
 =?us-ascii?Q?uP8YUe3gVwPJtFDT/wOo32oZD7AyJJdJwk3UA8uLaVpo001owra4/hC3urPK?=
 =?us-ascii?Q?U03NK+CTUAotVFOpU/EYQ8bIp5d5a50Z/gmRc9emzmPv4o9HqwHVPTqVZWJy?=
 =?us-ascii?Q?HMfoVMslg9rgQmAs1UCmC3V77FgeMRPzNWFvX4QU+7Czqz3JJfYsnvd0wzbD?=
 =?us-ascii?Q?O/sQMoFMw29VmO4OnzLUVy7eoL8k+Q++3QtJWGj8oOcQZ4DqR9HNJTwM/mWg?=
 =?us-ascii?Q?WjZOa5z7I8UOJEpKjIGjQckbMYR9WxJWVXx4QEvyzgCmjXHh5IwiFEEwdERG?=
 =?us-ascii?Q?OwwPoxyQMfovp44Qt+fy2K27o+x+NvVSGt5+Cv7Xbd8g/GuEdWnEAhOvEnbz?=
 =?us-ascii?Q?rlNoQeIbP+eCT1uZdxj8HpR44fQy6SKvbUk3Hr8qIyQQau0wmKEPEEpJQnal?=
 =?us-ascii?Q?Bkm0MUoexQeza0z1ogA2nIkysxtOcxwjfNseYqVV23aRUOul92aqvfYwYW19?=
 =?us-ascii?Q?BPYTXn5ympUyM/sYsMtopVDta27DH9ryLF66L1hREOuvHbY8myt8mAvTcS1k?=
 =?us-ascii?Q?V/9xktZb8b9kqbgdUN7Mf5lhdi6lpIlN1hYLgdxtj3zWWrUYi/iIDOck0Vep?=
 =?us-ascii?Q?NTfcC9jK2Pk19Pn5fIJXHUe9JIZEZbUANoJaN8aJ0aq2suq2GMRNptX98p63?=
 =?us-ascii?Q?fbsKJwFhPfJ4mjQV8IDN6r01/fVGfgtMU8X0nbQD49MWrrxIgSISE0U+4AW+?=
 =?us-ascii?Q?n+KIVXVN/hXOvp6qJWAtb8P98zRjy9X4d1Nm2m84WzilWVGQ2b33f5F/BEa3?=
 =?us-ascii?Q?dENzr5oHEoO0j4qZbBHSVJQLkzdQOGyMXINj73+zkB2zXvatHmPUIfdKrXR4?=
 =?us-ascii?Q?cxrgVjm1+JBfmKvTsk0AhwkTq9AYgMVcgvBSytjohw9UV44Y+nTfb3vSEt4Z?=
 =?us-ascii?Q?ApFE39Eg7RussxzY3Id4kivnTk/bM0MALppv1X5YRbeleojFQcp1KU/mYxPA?=
 =?us-ascii?Q?xv24ZWt5Vryr7XAV/5FW7gAE33DDuFNSLFIlcEJG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0029a73a-bc18-404f-aa12-08dc654c5044
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 17:22:41.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n138x65rhJVDQcy8QkObEdt+UN2YZ4uH3sWWQ2Y8CjZ2S9SF2ZyCZVpuU/Og2dcBMTfrHJdfrAguRThHemWAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Fix excessive indentation in __cxl_coordinates_combine() function.
> 
> Reported-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bb83867d9fec..210a66743c38 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -518,15 +518,15 @@ static void __cxl_coordinates_combine(struct access_coordinate *out,
>  				      struct access_coordinate *c1,
>  				      struct access_coordinate *c2)
>  {
> -		if (c1->write_bandwidth && c2->write_bandwidth)
> -			out->write_bandwidth = min(c1->write_bandwidth,
> -						   c2->write_bandwidth);
> -		out->write_latency = c1->write_latency + c2->write_latency;
> +	if (c1->write_bandwidth && c2->write_bandwidth)
> +		out->write_bandwidth = min(c1->write_bandwidth,
> +					   c2->write_bandwidth);
> +	out->write_latency = c1->write_latency + c2->write_latency;
>  
> -		if (c1->read_bandwidth && c2->read_bandwidth)
> -			out->read_bandwidth = min(c1->read_bandwidth,
> -						  c2->read_bandwidth);
> -		out->read_latency = c1->read_latency + c2->read_latency;
> +	if (c1->read_bandwidth && c2->read_bandwidth)
> +		out->read_bandwidth = min(c1->read_bandwidth,
> +					  c2->read_bandwidth);
> +	out->read_latency = c1->read_latency + c2->read_latency;
>  }
>  
>  /**
> -- 
> 2.44.0
> 


