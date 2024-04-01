Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C0535B5
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000279; cv=fail; b=jN0nmgn3ZIvGfShFExTF6n0t/1A9nZh2hVulJMyuvMuum51MvrX84fG2Wif57y+jOONH9ksBSkC9x1QdF24TTGWado6YdGQ9DbaA/dKp+fixfkU1C9e2EPts/pw0bnzTeiUm8toJ0AaIy0Zul/8gETGuS0hify8IqITSrr5jUno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000279; c=relaxed/simple;
	bh=GKIWaBfXbWiZEy8NqSLz8WFR32oqiwb4bioGR9NL450=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eSB/tO2forRIdHTWjmiyI8yDqLrqdMBgagQzrB+ob3LNP/cisZ7za/Q2kDSOTzlDsYPGWH24jgvuZq4qKGmHXH37C/ZaCq+BZC4E2hNA+o46NZDGUeyki8cCQ7sgH1C4T8lMkclaDpfm3MxmdCxeACJQFEC96aRbtSyBMk219Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iV2VBYVX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iV2VBYVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712000278; x=1743536278;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GKIWaBfXbWiZEy8NqSLz8WFR32oqiwb4bioGR9NL450=;
  b=iV2VBYVX4aTZVENQUJIF1DjaPqGFMaFW8TUt1sZq87CIoyPfHZHQIhi8
   3bzhCRqXMI8B2rY4a3KcPD5IYw9WpfZ08TJwU/0NcrnfoA1VN+TuGjlGd
   U2+2kCg4ZX7AS4tndJEW1BmZqvPDZP8+shfQQjCIG5Z6A51W5p/eX2fH9
   SPDBpXRXpqRvvOPsJIstt9fV9FrxdMFSPYWm2QNJWGhRfD279daOybseI
   u56785avBQz6xLe5y0zp1vg9FLBUd5FWUzQNbNJt3ym7etHBLQ9IZua5n
   V+c0Kk3KRQ0v2t1rxrJSYhULyx8Tc6vt5xbsbhGDCeXKhMeIjhRMAnZHi
   Q==;
X-CSE-ConnectionGUID: IOAi3xhXQierzrsC3QbroQ==
X-CSE-MsgGUID: FHAFjjVySTKmMt1BcnLZow==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7353704"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7353704"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 12:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17869283"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 12:37:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 12:37:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 12:37:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 12:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKl6zSNHfqkHixTpa9uL92qw1hYuV5SOeqVMPiVOdGzaA9AZXncV1w8i/yooYOOh6kIcWJlOKnLBfccM8otorD+k6lDsVjTANBYKFDRfBRh1AljTzS96ILyOE/GrA+fspLvUCCbqkncfWMvlQAFLyt+JeJOJt4i1ixXNOGCh9sLLUZ8nK9zMhAsxc28tBx9eXl9kLBLrIuzkM/c6LYCZ10vnDCU+esy36PPtlqLD/IpeTMm+e38Xx2KQ/FHinl33SAi8dVDwRA92KgHv4mL+zhLkiWrjXqU6QFhUFIowxwiu8S3mp2t+j/REvgbyR15n6swpUZriCQArylrKdN1ueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArkHxzXzO2QWOE9MhKT6CAxrqFPUObzmtttqn0wURoc=;
 b=YaLpZygQ2n8cK1nGsyqfKOJeDGGwNwkheowR91sZ2ZPCvxki87Epd5ERhhqgGySD5lu+UFS9IBf79R1ZZ/oFaQuHtDds6qyWO1vMxh0oNqOi50asZf/cURjhQ2j9KbP6XxHhcaMV7GTdk9XpSAu+49EsHSCGTj+ZA6fe3rhkmFEoZ3kW3HfOS7JHyQgAlIOfajRsYztBKXyoyMwya+OM34JKAiZAk4mJ0icLaBWdxlM6F/AZGR4tsLtv3Fs4DHl4ws6QeOPBT0bynkUr7G6z6gdTIvv0HeDfzDK/smi0w7e76dDa0Chsrow+S0d1wpUPw0bjC6nkrmzoJuLGhNSnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 19:37:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Mon, 1 Apr 2024
 19:37:53 +0000
Date: Mon, 1 Apr 2024 12:37:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 4/4] cxl: Add checks to access_coordinate calculation
 to fail missing data
Message-ID: <660b0d0f5c83a_15786294fd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
 <20240325230234.1847525-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325230234.1847525-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:303:2b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6651:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPRNeQyBmQ0CBqSl+yUuAXQi4PEJF9rn6JYkWPKdbTb+kvcaevi9/bbYH7PN74Ch68epIEcwL4hivldMV4RYqgIXJo+tldVKaqfu1bI6F3BUASvN81TiHGPbV+Pn7SanLoasYK3RnzB4xG8D0+F1WeyI6C/Hw6rjeodojcwW18MAk5xoYS+MHglJ9V7Mn2r6uqtD+dyVKxTeeSYQ1zOOMTXzfcBsV5XTDs2unxvkf3geY5tpUb6ylWXON+DLh9pSKvPdvRSGlOi7O74t8CB6SXpVu/jQRXjZqxQ30B/TmQ3qoqQ0L8PCT9lHHcXyj6Wdc1H2B4aHtPKKGL+AeufRiIZDeXK1z1gS9C3XYEdvrSgb4JQLefPigyAScO000tA63pwKBtrLpd/kA4S4xRLvuB3Aw9XvClfxino/ar/AKMrX9fuOuBVFIVa3FqMetol47W0wD5Un8fkYuNGVxee6qJsrIrPnJXCneUnj9CAdoja7WL9bBp8zDNJziX4pjQhpef+xittaLh+p0hHTmZFk88AnLd8iuBILTl8WF2d0xkxfB7diREqd+8Kcz4NI+IL+Npa/DCbC0gaMS42ViXqzQmxpq7uc1pro3ffb651jOdbMuOQlo4Wiz08XLYYQUMD39qhwmV2RsacmMZdgNbNXfnedH4F9scCqPQPNVHO2DFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OP7lTGIANKvgLoYLMQy3OGHItcIJJ3HxzQzkq71XAU7mu0OeIN4bOi3OvrUD?=
 =?us-ascii?Q?c6lz0Pcjp+Jmgw/KkI8V986nmzFFaWnkoxKOeizQ0RASati+maC0/jTV+uJq?=
 =?us-ascii?Q?FF119nS1+qk4/aww06222Ziny9VVf1mzwlBcEMui5fjh6O71/pM2VQYQf9X3?=
 =?us-ascii?Q?k0K/CoWwnqp/tHnJDBME+02MWQsaR93VDpkp4ljJbRLRzriFGtQd3nX25QX2?=
 =?us-ascii?Q?R/XHkH5ssCtMRuHOcIpD85GvQWLLeC2i4oys9cvowb5hCvgDzvXmSrC5Hran?=
 =?us-ascii?Q?92q+QY5DTBvJoOwzpkmzYjHitmgBCNyCirSST7u/pVjKIoYCAvo/2UeOmeUP?=
 =?us-ascii?Q?0fzohX5vcBLVoFAM2cuO2mNz+/cBr9bf5H8ouHy287ZnY2GB1eUIh0Pj2wyq?=
 =?us-ascii?Q?JteNwJyXCz57IKArRiYCXacVTzeW5TDHAL/OuwdC5joTgQ9+lBxlTah5kff5?=
 =?us-ascii?Q?kxGXnDHPZUjkuwTiNfG79Kpfj2McdiNXtvR2lhhLQEucTG0bYBtYV4LRBiB1?=
 =?us-ascii?Q?kGedq3zTHh0g1r5kQaYjqWkr3a4w90eo58n6ooANhG5pkI3kQZwTB8Xqt2I8?=
 =?us-ascii?Q?6TxH5c41gI1UpYeLwXyqt1ldXnokDolY7Kp1UeVdSIFwYFXYJ5RjR4GLBbKc?=
 =?us-ascii?Q?aFxXRoCHIvOmkHWRySPr8gRBK1hYPaU7AyaYIBNBAqObly2OeIjXSpzOOD8O?=
 =?us-ascii?Q?CSIzQCXa0XVXd4+ZeiOpkxHOPkjbMv7zuS2bMjec4Wmt5qm1hIVlfetbshaT?=
 =?us-ascii?Q?r+AXvLhUf1382VlvS1k+ncLEnGMkAT7me40MQTK1oKVQJ5HADK7i4TWfJEx+?=
 =?us-ascii?Q?hw03GShoC0/Rkn20rO29ixtLmwIDVG0rJH9AQuP8vFXRS3ovqpcS//6siFeU?=
 =?us-ascii?Q?5yFCLA2bAkhsL82t1ywJ4pPIPPZVXU4q3BKU0bBGyq+5ksELZe7DYlvQlohv?=
 =?us-ascii?Q?eJ7S4u67uDCZc4GjhNYUwazR6YHcwLj/YO+VI25hH0LUKwyqoKxNhLQV+Xgb?=
 =?us-ascii?Q?4Foz7nHsu3ogXKH2/M4dpZ9qoqqCdmWhz4mJxRpsk72a5XFKjG8gEQDfZnaB?=
 =?us-ascii?Q?HIFV+xpphGFMtQJwMx25ZSy5J8SCmOueMniDNLfiXQxRwW8eRbV/R63QLvzR?=
 =?us-ascii?Q?X9WSlVgC7xWS86CRHVEWvYcLGXKNWNSNv2ESzT/UkOA6cw4WcdxuZnD81/ko?=
 =?us-ascii?Q?3ybvjm4wzn5h5BxtEsnlykOgjmHXysIG/XbWw122YtsOQjwEf/znEYaaKGBg?=
 =?us-ascii?Q?dbTIFGdt+DPjRq5TNi+0L4G72iwbEyULzrfmxm4BZyMFnd81X6xYlmOg0pHU?=
 =?us-ascii?Q?8fI7ps/AA8f53hvykmmRkXmaSBVA4uip/6KMvGXjRt4D9z22BSmjur+GhkUm?=
 =?us-ascii?Q?UNTExmsId/tggrC0ospTJIUcR+R4N8PfRjxVqKWGfTi9UOKSnoHElMkp65dm?=
 =?us-ascii?Q?q5Ib2FqTSHLXjvInf0e/Hzci2PtOkzx2A1qDiYkW3oZ/+QJxP99GPFLVkpTY?=
 =?us-ascii?Q?AzmTdLM4NCB+KZ9sm9HT4bWjyPijDN2O0svDs2Pu1jFxw8vvshrzA1mlNsFC?=
 =?us-ascii?Q?DUYB0VYPmHEBvL/JJ7UYzkKfqqwfs705dmKrUPzF9YPS7zyLvWc1KfHKNjbl?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a01d14b0-8db6-4833-5f64-08dc5283393b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 19:37:53.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omCwneodBUEjQfGP6TeNyLTYO92WuboVcgihYQE7RqlThMKTCpIGljMfif2HeK5bPz2arCDLmvjMm5rVV77y7jYVLlJ18+SmwcO+9glb+Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Jonathan noted that when the coordinates for host bridge and switches
> can be 0s if no actual data are retrieved and the calculation continues.
> The resulting number would be inaccurate. Add checks to ensure that the
> calculation would complete only if the numbers are valid.
> 
> While not seen in the wild, issue may show up with a BIOS that reported
> CXL root ports via Generic Ports (via a PCI handle in the SRAT entry).
> 
> Fixes: 14a6960b3e92 ("cxl: Add helper function that calculate performance data for downstream ports")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Adjust for multiple access classes.
> ---
>  drivers/cxl/core/port.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e388f50675f8..ca5bc9ed6d2f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2141,6 +2141,18 @@ static void add_latency(struct access_coordinate *c, long latency)
>  	}
>  }
>  
> +static bool coordinates_valid(struct access_coordinate *c)
> +{
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		if (c[i].read_bandwidth && c[i].write_bandwidth &&
> +		    c[i].read_latency && c[i].write_latency)
> +			continue;
> +		return false;

With the observation that a coordinate tracks nanoseconds while the CDAT
reports picoseconds I wonder what this check does for sub-nanosecond
latency values. Does that need a min_not_zero(1, latency) somewhere...
and if that is in place does it mean latency can never be zero?
