Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7231A76
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234087; cv=fail; b=BfsMok0YS/htPSVdgw/b7Y4K5MnTI58WC30TSKmLpHwXaBWAHjsumPQ6zmMQXeVDMrcOEQlWiQU3GaDTdQrCnejCC+3augOop2AQX/eYgRmZZtrQuG+E3Kb3Aep5QxlHVSexSzSSeGpZuB5rZKRBFUQ52wVQjeKeu1MzC+hkIDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234087; c=relaxed/simple;
	bh=YoMw/ZQr3qRytUYbo6py1hqD0/UkbDkH6XraW0OgJNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4TYGFD+C8SYu+ZYKPQxfdLCcLzar/VlOXN0zUW1iLtZMvKjiISXzGdH6gYXhnEtMFY0gxJw1C2ZxLXiGrh9MJF96jgBGe99FVlPvF1DRdggLyX7VSav4lJaQazTnyfuRcrehRAuuwTieXnRyHihGXOiQ/7avLAo4Mhl/o5vYFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQoozUIq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQoozUIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709234086; x=1740770086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YoMw/ZQr3qRytUYbo6py1hqD0/UkbDkH6XraW0OgJNE=;
  b=RQoozUIqcGPU4WalcFdpa7nyfKhSrQnzHwEMeSkEnDGhp1xOS62HG18/
   GWe/cmAW/0lrq4e3W1J8Xk7/HuwrymKqmp9eiQ2gwx7w9ayGVPwywwDMC
   AkL7n6sx+WE8l40NkYTQO5iNRzLMkxxmTh1wOUs4RavRTaKocNX4f3B9r
   eBNW/WfyCaKYS6d2uV6bujNkl8UxKV3HGLeWPztrTilhn1FGyNFhCYTfh
   vwQMHI2g8oA5WMf3ugiey8B5Jj5fZjehaLNrgQ7iY26sMpoyXLzB1fFyO
   vNg8MNnZJzzemf+AJkEw57YKTSyY4/gARr0HheQR+O4IYiHk9liRYvEbg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26198897"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="26198897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 11:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12493742"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 11:14:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 11:14:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 11:14:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 11:14:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAPUh+XlvPcrvqtqc4R2Yq0ZRkb98oVjjdjDdpb2f1926XgUKiUDmcRPt7Bpduz4TvNl7oz3nlUlLkriv+aaSSYdALvtQmbnpn7h1hdvLR1KFpGq+oGfh3ROc8bFiYzGM4Uyd2laur4LBZ9kXoY2+m5k5hgtZj47E+0qs7NmIy3m9/mdNH5kIYfkCAs2927bZp2I/1csFs+IlltPaBvpCzpfYGlj3DGHg9k6PHXfgsdgELOs98IPMP6zuC01Yc+fpgwu7+jsWh1eeHDVPR+UleeFjkNa1jTPxaLKgxjadjNCBDb5hs9vf2qPFKqgH5Nv1+1veT1I+tUA+VlIveGd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+DkgtV6SbEd9RvmxxMPVCjgMfkgdVoTymtk5olovzk=;
 b=YEc4CU3tDvyTIUynFvbi6DJln4IpnB66sxub/vAC2uvOtf4vBW05L/lkI5FtkaOga1FcQpVmKEmxWVUCIs4cHgCV0bjPPxoi2TDLxDXK3cHGUhm1TsVkhoyhy7crKFpzJ36GKRbg3qEgNpwF/PRxFBHrcXZymH6sth6UiCjB8dA/2xjbKTgkHrdWIw6ZIveMhcwN1z16DTrRT9wv70cr+B0f9Zb/3OM2cs5aTMPP768bd99yESUG9PEaIb9R7vBgERRkKdAVEl2+SpPvgZqSyZXburbQH0gio/chZmwRLFZEp60VFh7Qyh8t/y+l5SFhkxEqMuuC2alqpvHnJE8HvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Thu, 29 Feb
 2024 19:14:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 19:14:41 +0000
Date: Thu, 29 Feb 2024 11:14:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH] cxl: Fix the incorrect assignment of SSLBIS entry
 pointer initial location
Message-ID: <65e0d79ec4d0_1138c7294b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240229182911.750135-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240229182911.750135-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cd8f50-12b8-49cb-2281-08dc395aadfa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESdVpx+HT5YN+zsnHUDbgoY5ioF2D13l9KbJqUPP0LAqLq1DlF59ch5yDYkDM3ZHG0hk8IQqy8yLygudEITEbpS5yBRcOIxozchDFXB7Xv8kmWUg4DUITQw0hAtF+jkevmQZUn415Nc40l6zS5+Z9FRBnjl+Giht69FbgV7XDL1WxkfRYBc+DhQUsMr1AHd+ltaxSLEy6rRdozNsTg12otXURCV32XIJFk+HgQaFGLjmjMlA9oCiwTLk5WKq8dbWPV5/jgDelFTO6uWLg1pRM8UFfAjlAUhlFZpZjgwo6XXuuWvuAAA/78g+ATrzH5ZfHgYGZcn8BuJ52/wh/gVq0kmU902ggC+2F9LSNBb5nLzM+EejHATgqWo2LLh8I5F9WQbe6fKcjyqIgqWgr0vAjAXKOZ+QiZg04Dh7W2slkhB2VltoH9SfzphZDl+4gxLZkpsg8d8cuPW4JzbB0PtIZQYy7Ly7Uw7t+KroELDmon3FqeOlxnVRqGb+jo6GoEPrFufANO7irEqU5lkBbQL5cuCEXRS8P2R2C0P7GtaQpE9WXaJEAbFzjPXMcjFj6gjVoaq8bwDBb9UovzeXDLTLnalJsUj8nHjVC9S8vVur2Ag3AOLNlZh72PcnrF3FliCXAXZEDy5IU8vikqXLAoZT9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOJxpsIalCCX5HPPgHZSctd0oHAzGdXnI4154OOrLFpoWyOiVFp5prkGhrWY?=
 =?us-ascii?Q?SXl1G01jUBarD3IE5QXZ1LjEnMJfla5O/HjkNNrutR/bEP6d/eM4d1y2ifTl?=
 =?us-ascii?Q?FoZAcUEu6xFq03acrd5Of7JxPKk6ey3NH4WnE5ITWirxg26o8zUoBJhfcsjI?=
 =?us-ascii?Q?AwChU0HdYk53gHFn9kv2BdsYHTAWOPNnZiRfp2aejjC2lQZ6aMIFRyfhgsu4?=
 =?us-ascii?Q?0AXFrItaQHsBJOqJujJVSWnOujT7x38489kWObJc+eAbx8q4iE2J5w1IVt24?=
 =?us-ascii?Q?D658T0IDd33bSAe7JJWoiLIUpMCwWdbIrBd9BUup2LICKihh2QkJNk7bnSra?=
 =?us-ascii?Q?bvcNxXqphP37X+JerX662RYO8FY2+VNYciVMnbzPgbKTHWCIHh1arUnKQo6Z?=
 =?us-ascii?Q?AwgnuzkzNEwGHjbY3V7fe5FQPVvnxmSgNgNx4ajqK15ZAoRP53p5DMrAN+7z?=
 =?us-ascii?Q?ZixS8tmOMzmqd0vTOH9Xhi4xWHrbdPiM85JtRT6+wLcD06wfoNaKAbaNL8rv?=
 =?us-ascii?Q?CcBgPp7d/XEFDFLt2MQscQlKws0Q3Mdmo/1SlPTC3puucMiBas0olke4JKG9?=
 =?us-ascii?Q?EPd+Smcqxv1bYxp8zkDLMlv17is8C1smSKcdg9DWlYPHoE8U3pvjpy8crrRr?=
 =?us-ascii?Q?D5oaAK5Hqy0KzJOVa96q4+JbktCr/1ecFrEk2wt2KynHD45mrgt2HGRuOvfq?=
 =?us-ascii?Q?+uaipNGLDF1H3ulF/+bBM2V+3VA5A7EN23ZF+7Rdpq9Nc/bafQH2dtB7KhmP?=
 =?us-ascii?Q?t1z9NlTbXkMUUXg/8RDUXpBEqeCMJpDGz57p7GhegIpjRmLRv5MejMiXWoKA?=
 =?us-ascii?Q?ZlWuOybbJ6t7LwA2ZGwmCzBoZZ8R/98aum9getmr8gPqWrW6LK3X4Y+/zfAb?=
 =?us-ascii?Q?DpB1aoxgr9PgdFTWR53ONrwxUbf27EDkVykRcCwZMkZBBqcvASTOnghzZuC8?=
 =?us-ascii?Q?k22Lep65RBOH8I5VAQf2YhQ7ho8EaoResQtZRf5/8F+c/QoeEfadwCSiWLA9?=
 =?us-ascii?Q?t1FVLPMD5iGCaUtSXAXvbdhfKvmFcnhtUJbmoCqMLrlVe9lk/16ekGWleO1c?=
 =?us-ascii?Q?WIRjfpTUvdITVxlOWzxfSXAFFxJGPO1/SS0TrupFo0jYQMl9xGxCUsdGStfE?=
 =?us-ascii?Q?Q28ICTX2PwExrNPjBcYtkqiv+34FSPM1mH94GXyCHIOz2KUEaYxUQeJ+9xdA?=
 =?us-ascii?Q?ZJZxqNhCV4MY6Yuze3MCZy6Smwzz0HtNx2wBSrNTWkIcN+g8tCxNooVXWyeB?=
 =?us-ascii?Q?eNxMN3piE40ITn/JUT1bxnIDRvc6qZ7x4+OUNFSfsjo4mmB3o4sQcEu08per?=
 =?us-ascii?Q?zGGn5q31bhwVYeMImXNuDCstyJhz/NTG8Jh9njb0Q1BzPwxKz1/FmRk13soN?=
 =?us-ascii?Q?dhX/jLW+lsAzYI9wzeZrlDDrCXvEibL5Qpbng0D+4WezxPbWRKSIGChjjpUc?=
 =?us-ascii?Q?xzXsJMlyCyBx++q17ONdLwBIcZYWAa/OvTBaN/iIkuVHXjBkJnMu7H7jr/y2?=
 =?us-ascii?Q?HtnfWH0nqI/4gstZJIRPbkQesre7OVLJo98kWuxPfTITVSDL9fhTpW28j9Ji?=
 =?us-ascii?Q?tLctiuuCcoNkbHS+H7DU7VMDxSrFiIdgS4zKpb7fdQnu41aorifZlo5iqOSr?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cd8f50-12b8-49cb-2281-08dc395aadfa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:14:41.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oV19hWAzTZjx6u6DlCFWoJAZasJnW4xM9t125KLRd8Jb3O6/mp4X33y2k3/YeliJZ2UH8VaATN8uWjU9WShLQ0ROVe0JesJhztnhZjnU5J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The 'entry' pointer in cdat_sslbis_handler() is set to header +
> sizeof(common header). However, the math missed the addition of the SSLBIS
> main header. It should be header + sizeof(common header) + sizeof(*sslbis).

Insert form letter => "please document the user visible effects of the
bug in the changelog, please give some breadcrumbs to -stable and
backporters about this fix." A "how found" note usually helps to clarify
the impact of the bug.

> Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 08fd0baea7a0..b7c678d4b1aa 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -414,7 +414,9 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>  		return 0;
>  
>  	entries = remain / sizeof(*entry);
> -	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
> +	entry = (struct acpi_cdat_sslbe *)((unsigned long)header +
> +					   sizeof(header->cdat) +
> +					   sizeof(*sslbis));

This looks way too fragile, what about something like:

struct acpi_cdat_ssblis_table {
	struct acpi_cdat_header header;
	struct acpi_cdat_ssblis ssblis_header;
	struct acpi_cdat_sslbe entries[];
} *tbl = (struct acpi_cdat_ssblis_table *) header;

for (i = 0; i < entries; i++) {
	u16 x = le16_to_cpu((__force __le16)tlb->entries[i].portx_id);
...

...then you can also use struct_size() to validate the size of the table
relative to the number of entries.
