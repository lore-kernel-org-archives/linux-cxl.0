Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6242A781
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785282349; cv=fail; b=g1194RAJC6MDBVkzrawrZ7svwSs5Xm9zyxJ3LF5ZNEWLFfu9ZyF7IQy6A5g+1//DBEa9xPUmy0viA/G29LFk1b0JjQMMxQ9wRZYlpGzZR7iX9C8V5Z1A+1R5TTOKgcf1TGMuP+ki/AlPesbqv3ymrQDPsPdSY4LRUmxG84XtkYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785282349; c=relaxed/simple;
	bh=U3PqeoPgKhaRcCPSFYYHULVqyBnaDEAqkB6cDzzB3Oo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A0ugGZqej9np6m26UwgraD8Soo1V+ag7DIENi1AMSl68Nq4zHroFhyG1waHuO/oIPm9V4vx3gSjYq7FqAPeRPSv4MTG2Uu0a/VKNnvhNZUl19gU/0sPtRdoB46dnsH603T3GYeCcEhDENNvBD7jyyoSV5LuNEWqLHmBQqK5FqFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMjRYSVy; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMjRYSVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785282347; x=1816818347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U3PqeoPgKhaRcCPSFYYHULVqyBnaDEAqkB6cDzzB3Oo=;
  b=eMjRYSVybflniHyPfcWD3lIDOa+tlAvlpM6ubEXRte2mUfSiEv7/weNE
   9CHe/R5gPiNDpqk1/nenIO6RPIjXUjbtxzH5x9sZECr8x7+WqX46klX0y
   0y3MACOaNetUQEUtJe5Ke6Xw4C31612kpTIVfTaS4sFOEHfh4EsmTvJRw
   cXklrMhUVglKFHU3VGJikd7kib+AHROrPhxJYOszOGUVf4gNAdehiwzFC
   BtdUN156l2+qRcEFBMmYOuAdt/ZYm2VUKG6H+ZYpgd1C9OzRSTjfbOomV
   v7PwNkAR8ZUl4MdVjKG1Ycvehzq/RJfY6hsKaOmozqfDY2qw4iDLONjT8
   A==;
X-CSE-ConnectionGUID: 7p1WXrZkTpih3N+d5x3Jzw==
X-CSE-MsgGUID: jpMN/XLrQEaO3AAV0POadw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97392592"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="97392592"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 16:45:45 -0700
X-CSE-ConnectionGUID: 321KrXswRiiwrmy9jkJWRA==
X-CSE-MsgGUID: Em+v3UtsSHqqQlTWTZ9vVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="260487789"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 16:45:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 16:45:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 16:45:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 16:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN/ZZpvwkqjaxZ2r9dyDFbjUS+kk4iGyLVH7c71zpEaZHF3+RxbFaviR5ePq7TyKoDKKXnS0InaaxZKzBcPe/9tSaki0CGQx86wjLUJgPiGq7fA7nzdX5iH30AI0E+g/l0zU1Ckc6fJb1YvTDcviK8IUMtBLru/9QVytP2SaDJEjhFQIEA49k37EBTPGXzaOyB2A/RgGCBk8sQhsp9vScn1RzK/YM2WH+eOZE3lwN1E787dF7zZkDbRxKsi+Iq0tTCIsoZQzBNWvcE2yy/X0d89rucRJG/3l5jDDIFLT5oic31TRMrfHdUTZDmQ0top9XaG2fpWWTtfrCMOH8chQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoOQDBZpokQpYhyFJtKhfiUti2BhxX8xrPfR2ZR0iAU=;
 b=OmbvzqSaEAmFyTI4oKE5mcczqyfelmo3MN1vJwqAc/72tukH4tLZFnb1kB62Sye3VZFtMxJ53YCM/dq5Ua0YZcIEEIZyxY/j36ssDAnKfbZGiGVB14bUiQf094D0s62kBLYFgluyblGz2Pj5oFF5SiAtcvVfRygenf0RjSQsUSjxvV5RigMtCJnkFHpacDPl6gB8AZ7OAlxJiVlC00nAf6eTM1L1g6Rs5a4GUd+/NQ4Ji5zh+XFiKVRzyOZWUpKtcy0YQ30GO6rtnHcJb0xy2rc+QytqznkmHW4Llia/bL0HD6jzeu5eARBDTluvPZr41n9dYlW7uVcjH/BjQEI0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Tue, 28 Jul 2026 23:45:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 23:45:40 +0000
Date: Tue, 28 Jul 2026 16:45:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <linux-cxl@vger.kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] cxl/hdm: Robustify decoder target list reads
Message-ID: <amk_IetrE7138TT0@aschofie-mobl2.lan>
References: <20260728230228.781303-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260728230228.781303-1-dave@stgolabs.net>
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cffd4c1-df14-4213-0362-08deed0254d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SwQjmcNBzuo68MEJ5a9M3tkR5hug6rVg4WlWSG2z4tN+E+fSzQlXSYG2yNwgvJSRjYToyqQ8Sx5JYO6D9V88HBlnIDLupg3OfnxwD3fwWRqHD7apvBqlUoOsOSyqX9irwjHwI9yklF7cOmtpGYFcAu7g5G5Ah/0w8d44Ellc6JYHamFpr7CmU56MOsOpUQkdwT4BiiM0xsJxqgci4qGAvhIR2mxO1cvjs/pwDEewXL/CBUl/g5crA9+0x0x7IAUzWr3mrcG2w8pOSCkXVJHnEnqyByjYOrj0F77Q368K7U9tt6xIaV2OSZ9zoF8/BAntnoh8HzP7oe53uaYKBxt71bC6NhWx/EIzLjYF86eoF8A26hsEdF0GGLOR+bEmRt2IrifnxtdLCzGxHjkNYtxy09ib2qiAD5u5IkmchI5EK+5J2K4w+efJTsSyDKL+SVSu6I2NNF7wpT/FPydAUF3GTunTynErXjyZmLTfmj9MRqERxZ3AylvO6Bs4oNhvcBdotWNwNwqCFaEBNpOwfSNmlQusLUkXDEFi7tyBao33tLv4x067fmVfb+ouDF6KFQlMVwrbsUWkxVjBsl4hSzImPxGUiQ2o51kYHnDt78bvmRZ5lDYJ30IjKd8dxOEx6Vs3+24dHsSXVTZatNfhDiuxyv9yXp8qwWCTXBDpQ3OzNp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnwPs9Iga+AfG7Pl09cJLvqR31PiowETOkVbPIfF3ybDkfpKgUqrExAwahFz?=
 =?us-ascii?Q?m++9xz5KhwTmqCLVwt2oGEUKsj+doZ69u+cDxYh+/ZJt239/CRqlO3CfuDTZ?=
 =?us-ascii?Q?4Y1smiom0iibVX2tgA/Roq98ZVzfup1d2t2/uGefxyyTOP1SI3i/bkDI1ULB?=
 =?us-ascii?Q?Bq6ah199XPqNa3kAca3Pk19wLaYf7SkKnNVFheRDyuVvpCVRESCDgE/htUrL?=
 =?us-ascii?Q?benOaraPT4XLAJkqo1x3n3pdXy4OKrKHAZJKeFo9zEDMXUeMuz8XGclq1mZg?=
 =?us-ascii?Q?8fgOPGk6w1W4p7uUw3K/9XIXaTJgerjv8/zUwAxOSz4/Edzc+8Xix5QM4sy8?=
 =?us-ascii?Q?q56uiToWxoPcwV+buQQ8Q5cwz90nWGtlz2sNhU5TaPpR5v1zGe+LBLKPhBVz?=
 =?us-ascii?Q?qcO19nrvrqIV8+MDIqcnea0MWyNFNY78QDN/OWa53y05d1Ac4eJSNVAwAYgm?=
 =?us-ascii?Q?nVKdhACk25avfCcSveJvK7XoOwuuwFs83z00pWBsIIEWpSkAiiw5+vBInk0u?=
 =?us-ascii?Q?pcsPlYuUtrT0OZvmjLqsIKAViKnmc0mUEF6FQ+6ocPhHzXl46LZIq8vT3K85?=
 =?us-ascii?Q?5ZApgE711rwir+DteBezOsj97POtU5gsDn0VDaMziMf7i/EfvfppBWXNbHW4?=
 =?us-ascii?Q?h9nFuy7Ox14ah7j/fsI8k8M2OEVQoKim9HkedmAO4RMha153QwQAK/mQQq94?=
 =?us-ascii?Q?3F4EPa4vs72KxytUHKcNCBXr1whI5thvuEPnLPWKqXqk32xNiedxMHeBL0th?=
 =?us-ascii?Q?q65XekDi0NPSmccMgHjOvpfia9Otk05h7H2yAzpgOqdSDyzFixBJrjiTO2e1?=
 =?us-ascii?Q?BnU3VRJoojBKheFPT8GycDfSZDOZYbzgdrYuIbTZ71ehLCaZFikTaAVRTY8C?=
 =?us-ascii?Q?O4zUTP45tiuh+HIPtvPTjhK1PyFsiFe9DVLm1YbWJnWsWr3f79SJys5NMCFH?=
 =?us-ascii?Q?FOz+z7hn/d8Bv1WLA0ut/GKjrwLDnJuAIYs8g1fJKSlhdGmRe2P4sY6hNDVy?=
 =?us-ascii?Q?9GAJSGgJXzIJMG5GwgZtQaBMLp/S+e4jlJlKgUF7YhY81aiyO+Yan2Mzrp7J?=
 =?us-ascii?Q?uSDK6OcDmZhfIcS8gEZIDUIeDPvWeMymsVcozSmkcBJNFJXem/zjKJDcfz2d?=
 =?us-ascii?Q?noZT28PXOWcCClmVA25IMsHfBHDEl5m7qrr8q7cK1keoyyeRxwwSI/SJ7yD2?=
 =?us-ascii?Q?8pCUj0mlFP1LQA6ox+LOxbxgZrH8KlmYgjIl0xQ+0qATVNf1jSvFgQoOVNVO?=
 =?us-ascii?Q?loo1eD9tjcWXhfMuCpVJl8y091DEGROh0Do6ny5UlA7ongKw0AE+QHfvUW53?=
 =?us-ascii?Q?QVyGZc8M2xBY4YVvHZK+mtXDJLjIs34ZKCsA2oCI9DAQCTrimBrEjGqbiYLM?=
 =?us-ascii?Q?wNIq0Zrv85M14+NHtXMltbQc2pvcT1hMDak2XeTteqTK9C9a//tHzvo7nxmH?=
 =?us-ascii?Q?TiHhOFafBSm+fTgW2PWJi/CHpyXn/ShZij3/CDsQknKAFqfPi7FN9owafGJl?=
 =?us-ascii?Q?7pNiIPOJhAcM0Pi+6AhznJvmOUfIytQUnMipShy5oSGCFCMWPTHnK2uqjoon?=
 =?us-ascii?Q?vpgFLSnwSbkyLXS6gVtFUXDEAk0kzfTn6axm/zsMYsblJUTK1m8UH+vmipnS?=
 =?us-ascii?Q?a6tXzF2WbwtdKfLZuSICd9SA2/t3oi5QS7JnJ5Kpv0ldq2J2yyo3C+kQ8PBX?=
 =?us-ascii?Q?QwuopQ5XZK8WjPKGRsULQyb3XqmQWeaxTMYfWV6ZsicBPqipudVd5WQjSQ59?=
 =?us-ascii?Q?08ZuquoMLFPXJAcNa6Bbdme96yNlysI=3D?=
X-Exchange-RoutingPolicyChecked: RjxUWxOFluOYDKiNhCDJ5D7bIFYh+98u52kq9HBmDU0QS3F9Vs1c9HbCuT559nTReWOpfBg43A1sppYzbgJk7+Glr6ZCkN44xLqezP08DwJJ+ionYXPjT3WqYkRg5ac0P0EZFV0nLH9vPPavmuRHJW2fCJFTcOSwxDp1k5JklEPOUkFwo73VH4yRTDIYyK4yyXcBVVXd0XzDx54mQHg7X6zXT6r1g6eT+7ZPPhg5S8n/HsWe6IboOF+IIb2d7e21J92eZaV2tpktZxBX9cSEbyttunsYAEH1Y46rUN3ggBThBEjOwGeIho+dw+0RI9nGDJTzSCxGAD4nmQbL13J9DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cffd4c1-df14-4213-0362-08deed0254d3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 23:45:40.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mDitl2bCqB99Qfon5fdsLdeV/eBPPZbENDDE+CRirOSdL1h0pVpQuxuqAZhrU5rQ1QSBZVbM6bTCChGkT5lnf0NHojh+Z3atY8pJ3vkWTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 04:02:29PM -0700, Davidlohr Bueso wrote:
> Since the target_list union is fixed at 8 entries, if a CXL switch
> device has an IW value larger than 8 (such as 12 or 16 way), things
> can go bad:
> 
>   BUG: KASAN: stack-out-of-bounds in devm_cxl_enumerate_decoders+0xefd/0x1b00
>   Read of size 1 at addr ffff8881003bf180 by task kworker/u16:0/12
>    kasan_report+0xe0/0x110
>    devm_cxl_enumerate_decoders+0xefd/0x1b00
>    cxl_port_add_dport+0x9c/0x200
>    devm_cxl_enumerate_ports+0xa36/0x1190
>    cxl_mem_probe+0x26f/0x710
> 
>   The buggy address belongs to stack of task kworker/u16:0/12
>    and is located at offset 40 in frame:
>    devm_cxl_enumerate_decoders+0x0/0x1b00
>   This frame has 1 object:
>    [32, 40) 'target_list'
> 
> While this is out of spec (see Table 123), we can robustify and
> just reject such a decoder - noting that cxl_port_setup_targets()
> already refuses to program more than 8 ways.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Hi Davidlohr,
I think this issue, and its spawn (the endianness issue), are addressed
in this in flight patchset.  Please take a look:

https://lore.kernel.org/linux-cxl/cover.1784595445.git.alison.schofield@intel.com/

-- Alison

> ---
>  drivers/cxl/core/hdm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..87bdadeccb5f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1084,6 +1084,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
>  
>  	if (!cxled) {
> +		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Invalid target list (iw: %d)\n",
> +				 port->id, cxld->id, cxld->interleave_ways);
> +			return -EINVAL;
> +		}
> +
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value = (hi << 32) + lo;
> -- 
> 2.39.5
> 
