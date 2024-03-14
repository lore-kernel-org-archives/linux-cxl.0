Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61B2E410
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424443; cv=fail; b=M2fQEH30uypRBLtImwVY0xnOtYUOCgrI8GogxRzeETQe29iBYbDshacRMb8kfOAvYcP4Ns4eQEls0KYd+t3vsoow9cNuM30sb04WRvL0zQ/vGpRLdH2/Y91SYybC3RT7Gi8AMrylMGYG7EPQv3aatzcF7GPxP0THNXjGzILtKs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424443; c=relaxed/simple;
	bh=QgkAkL1IR+mTrXaY9ASLGybUElOHOwd7qohKEYNzMrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=leLKf8ld9jRd0K1Y63Lic0w/CzvvNrBr9n/JpkW/fug/b6HoMFP87QXKsVYWn9YIRc2P5bWmk01s+hFcQDS/oNiZMONx7eQhnyxVHMOCcEyiqgyRx6QUEPAiHoYn+yZEfO99m3taomcfmpeo9GwQ0Fuy9CPytztagctS1tBTquo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKuXy2pp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKuXy2pp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710424440; x=1741960440;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QgkAkL1IR+mTrXaY9ASLGybUElOHOwd7qohKEYNzMrY=;
  b=YKuXy2ppAbzd7dbsb5d5hBghYhJxfI6yeJt2pbTOC10BEMJWf2IWXTpa
   XuZDtSvYoKnAPAJWKdJQwUZhf8h05i0kDr34nEx9EdI+/7zUB6t1VEZjZ
   0Qr2T1gd/BYPuVbS0J1dF8EmgW00/E5I4sRk11qujyqfOUYkzxrJohihd
   Y4FULmWmuI2iIKI7CXX3plgFfpYimQMFVXh2MH4XacNrTK5igyULS7jLd
   hZo8mgdbyekSfeh48jS/nMkHN4qI0HpdPNDiDnAplam7U/RkjEM2Xhj0h
   vN00Z1oxDfZs0SKErpArcgH/TVrOonLLXMHFj34iLbSVeps46vdGQWD4f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="16637464"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="16637464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="43217938"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 06:53:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 06:53:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 06:53:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 06:53:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 06:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaWPZsZgYk8ztb+JHaZ03352E8NM8tEEIrdVupyWqC94SlKc9CVu4EJwh1lMslfSDlcRnafbY3FJg2dKJz5bglxT1xaGmJSrup+mUnOb2Cpz9CL1Eqj5HywMS/NuaiDCdkoDihyk9oWN5r+b2Jaqv4S4kjBHuZ1aAazKJv12o5qE8Nh+N5urjmIwgQ5EWb9FbujDc6iBsSIb483TKGQYWVu521lVaXlWgZXZhYt8lUz5/TNg0d97BbhpE+fS2ZlN5Esar5olT2ZNw/z7cnS8Pcr+3riTel7MZJ/kIIz8PfSQFXkx+4iGXpgOzY3llHwfZRA91z81L/4sgVs0yE9NKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILysZQ5JX9LMKvuGablryqkjxl7gSq2QO6MC1JKfH6w=;
 b=PiIkHletPqccIac12B9CLzoRDadCKTBSpNeGr2pW5bo7ac63KmnBD8yiBEIPNrFPk+1hGvUOLSpNytzEnbUD/qqapgf/e/lnW/+tg3Z3EuD0ZxG16AYKT1sCb/f8ukhEhzP8VQ7hU8g4WOGfsJ72AwJ4jS0bjf9GMBd44+nU8qU3VPICoSpP3kUiUKEkd6uy5Bw7oMwZaG8a8uPRcVj5BQAbb0lDv8e2w7i8NBf2JWgnALT79nJ+zEeY3x6wLjDf0c6Q3LRRsXLAFYvnGfGqCu/ooGMg90/AK34S2ImXxRVYgTQxlSnhNmG8epd6oiXup0JS6EvhcpoGBYcHi0y1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Thu, 14 Mar
 2024 13:53:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:53:50 +0000
Date: Thu, 14 Mar 2024 06:53:47 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314044301.2108650-1-alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dac3f34-709f-4ac0-987e-08dc442e2da0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6c6dlY+Hvqc3N0uru2IzPgmqiHQBp/TEhMz9KJJMQ2qZd7t3ZFqiJZ0EmYj0ut26UwWfY8ledYSGzf4gy0IIkXVrwXUXG0ovTacFGpjQCF/uYH/A7Bf2vC0Czf4OxnYccfNEgSA8zh53Fi68FKGlTVyPx0P5XapUsFd8qglwvw8uvhWpBoQW8cQAGCkqf4Chdpa39IkCSbdKZiA8pDzI0mCyvRydnFTNkcqt1kFqvP2FPbkNoz5sjTNO9TtH0Bk0HRa124+EdNIsRI5CmkFG6Z7LgiNm2W6bGuVeqlpKnimU4rInTOcAjAe2ZhJY8UhyqLF8Hx3nj8LsoQNgnhG4Tt5bvm9qHTjhYCGMKyfn3VpVydMfSKn3f/JkhLPbM00Lkdvr1TBM9ORqw3vzjmbJ68L/QrWeEJs63KMnEey3aUSHy3JNZoNwNQe4HcWnm+3KuedRhVg0KA9Lp/dNFNTNSchaEw07uFzgWhzNjiEsqs4JieNIvtX4lShAShjBZXcFdUJIbHQuju729HuFt8Nf5ICbmCRMXUA72UYBrAEnZoQ3GwDEduGMmKt94N0f+M161Z9RebXIBgxjJKTiNw7P0bCuR4gxZFrJlCjBqi5JTgkgtcmq+jDHzWKPla2tfMOUqKqfqApgXneeWsMxsZMjGMShyHMlXW949yle+om/tfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLSYyAy4AXlCV4e+f+bgyC/wV28Gavbb4VKoi2Kxbc6ipOz5Xna3dsa4FDP4?=
 =?us-ascii?Q?LIQNRT0JMeAVytNpJCHTJNgJx5kR0V5d2Wosdkzpw+O3ntv9QQmcJGj21TCA?=
 =?us-ascii?Q?/7bczNl328TPyhSOTDT9D7ENRsOph86O2e7zThWCtws5QqZ6fIC0hENUl8nW?=
 =?us-ascii?Q?PeeGmCC3KmaJYBNGNdC35QEyEwmlTd8OpV8Xl2/iSzgklJxVveLSEJjikYma?=
 =?us-ascii?Q?TyP16EwxhzUZ/WmRxMu7xIoEpRhgz9iZgq5Vgc8IRa6StUHxxvvbp90frhOF?=
 =?us-ascii?Q?P0gKdmYVXuFBVCcFhX84YslCrN9/sR3aeBlBO/PPFdD2Ldr6+bwip0kUq1F+?=
 =?us-ascii?Q?is4HdZQ3LyNM+dt9IdLb7suLUQ+yx3qPUbLfxh1byXuPN0Ddn+eDjQeg0gtn?=
 =?us-ascii?Q?GTqEi60LHSb3tocQewCs/k2SaYDxd+iQxRqq45KF/OvVe80HiCixKln8YfsI?=
 =?us-ascii?Q?/NkVCyGM05TV6ynjQzTs94hfDLHPm+yes+XgYDY8BEqvzv7gTJveWVX+ZiXA?=
 =?us-ascii?Q?YpDEEDzsIYm1SMIbirQ79monGcR8V3QN7TlIQssSpuxWF92jo2kUu8u92GVr?=
 =?us-ascii?Q?YgXN6yWHkT4aOlsiQBTCGGbz86BteegA0O/7orEEgtR6og8nrOEtNj+D2yKL?=
 =?us-ascii?Q?YSVr21gk2EUpD5J6KdJMBCSaVaVtiv2qG3J5DdvKlIrTExX/a+GNySXWmiUT?=
 =?us-ascii?Q?nG9MPbNeNP/F91Cma05GbsN0C7VcghgRsvQHp+wRds3uGFBiSKqGkOXitgu1?=
 =?us-ascii?Q?/RVhdVkcuDAmlvkGJsZAENUCf9Rj6ejHJJQaJvvBBzv6f7wdb4I6pnlqtoSc?=
 =?us-ascii?Q?sGdkt/BSuBeCqxvckLiDN3UzlVK2cxvFlwV7B+gxBr4hinsrIOQaSLVKJgla?=
 =?us-ascii?Q?KGtsJAhWJqrIqeOG2aQacCkBwQc+OSeiYcEzXbyKcj+eEGgN/+AO8GLB9CHZ?=
 =?us-ascii?Q?MZOzwBNFLjpOe4FtK9w34EnRPagyUaZXtm2Ra+5TY/CqeTprhuzemT49DGx4?=
 =?us-ascii?Q?YdZ+/sINwJ02V2fiP9knqtaCZUoqmNnHbMFbwSZ+Gt/v6dNUKhUmE0MKlv6M?=
 =?us-ascii?Q?FufdcUAt3FWF3/J5Rwm+Qo/prS7jrWO+KSCPwsceiJz6Z5+B8NmeISSXdSl6?=
 =?us-ascii?Q?SIq4MN6sjZikAGvF3M81/wdjSUgYhUmEsVY+DFKBQkjcOcqdHAbiUHMKK/c7?=
 =?us-ascii?Q?NuwVrnKuZrOc13q2ZY05qUe63B8+UnPqb0IdzQ4mksnHEtwSkBopPLHuqx3x?=
 =?us-ascii?Q?nS0GLmkaa3wKzv/TQ0CnYNCv+EYZY8HKv9AeYX9aNbGRlsByYKD8elKhb8y/?=
 =?us-ascii?Q?XQwO4LZfVqAEPgCPEYXT7VOnaxa/ed7ZOfaDirD23eB+F3GRjMaHb8VoY4YH?=
 =?us-ascii?Q?5JfeNhjj7mGNb5r0FqwIEy6zabHsQqKme8+d3l9a6hngpzArU+EMldnSv91n?=
 =?us-ascii?Q?EvPZKn+S813L+gbf+sNahMsJzvAG+JkVDDVi/iEfZWBpkG8ZZcRgtQVcTKWO?=
 =?us-ascii?Q?61rhZ+kXYZq/gtpw7LBsUP1xRp+lLSij21pZk74Mt0cqX0FVvQ9dVYt2ku6r?=
 =?us-ascii?Q?GbxcXj94X8UFrHCnIc59x/0MswHT6/fUyEAypqU/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dac3f34-709f-4ac0-987e-08dc442e2da0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:53:50.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXWFC/A2nBvLpV0tyyzfvPqobH5aZb6ov55QRk00i24ySh4vhy+DW/Carnk5jVXXqFJXQSi/O7Nbb+Ro+ytEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The TP_STRUCT__entry that gets assigned the region name, or an
> empty string if no region is present, is erroneously initialized
> to the cxl_region pointer. It needs to be initialized to NULL
> otherwise its length is wrong and garbage chars can appear in
> the kernel trace output: /sys/kernel/tracing/trace
> 
> Impact is that tooling depending on that trace data can miss
> picking up a valid event when searching by region name. The
> TP_printk() output, if enabled, does emit the correct region
> names in the dmesg log.
> 
> This was found during testing of the cxl-list option to report
> media-errors for a region.
> 
> Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index bdf117a33744..bc5ca4d530d1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
>  		__string(host, dev_name(cxlmd->dev.parent))
>  		__field(u64, serial)
>  		__field(u8, trace_type)
> -		__string(region, region)
> +		__string(region, NULL)

Couldn't this be "" instead of NULL then remove the __assign_str() if
region is NULL?

Ira

>  		__field(u64, overflow_ts)
>  		__field(u64, hpa)
>  		__field(u64, dpa)
> 
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> -- 
> 2.37.3
> 

k
