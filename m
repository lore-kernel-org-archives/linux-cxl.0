Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5F3D988
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdOifa39"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBFD59
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699919156; x=1731455156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYzp75WxgMiT0IhjnOXE6tHV2my7jBLgDdfiJBBx7so=;
  b=IdOifa39DRz+7fJjq63uG6x6Dd2sYsCih2H7z6UAqc25A4LCrhVTocw/
   DdeZEPCW9rxFbMc8I5JRAG2EwQYqoIGOsqhXjqkwFfxhs/P2dUczXQJw3
   mQJfYzGmCSOV1buE4ac1Y6T6e99wmBdXhzZ0iZGfxhkTegSaXsfHWcAdk
   G3rgAUASSSFzyNuv5K9Uhp0a7HkRDv9FJ5DMOilEDpc/z2Iwht5FlY9/P
   BKlWQWUpxYR1AzSnWTlg8V9937oa71YfW34i/9Vz0900SZLcRkddWx/OO
   xZMKbEREzGCke35J7xNlmyWUTb4VCvpV6YxFJQz3/Xmp3ZTnmnXZh0vHE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389393235"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389393235"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793565371"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="793565371"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 15:45:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 15:45:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 15:45:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 15:45:54 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 15:45:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkBUsKSwdZVbX/hI6tNPlmAPfmbUr0QFevgthh8MuGvaMU1HRBUTSY14t1jowHFWdDi/59EUwY9eyyLhG/VQKvSZBVL+QcIvkr9MR045rmWas/ES2qaFSLRnvn/JMoe+28eW0fK3cWnaiV9kRsVtsgYmbKtr5D4bV24V8FShqCuOQQUmOY5IU3AFRPJZjmSDU0hkJtFvDXsdWOsJQYa7r6PjZRMw1l3bVcIsRfP8OdzzvctdFXv8BDZ2xn/OeZrNin8dqrkdaUa8NuqwKYHYKgtGnLMImHngX4/NdKTWSbBz2jwNVmyuCK9S16pTS3r0gtJ9ype1galsl38+Z6OKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOTeBulLu7cmXa8EbcUAMfkbFLW7fFcCMHpZVuUpE9w=;
 b=m7LFN9dgAf8sY3lKHbUMo589il6AhhQajEvj4zEQu6T0AG+rww179L2Im63n4LC+7ssZ21T+5Zo66WQAIF+mC/Y20bfhQEeuIoPUM+8LMc0qESBeWLH2etMBgZSXph6NGEW3kEMem7/hC6Hh3SwLXTGLJNk1PRHhJ7Trr39vppnP/AKHUgvUtNkhDau14XcfKcgg439lFWukz4/eoxGo7SsPmDYfiuiGw6qFYmsggI8PFXdETAhEgYQBxXbtK1gn7hYNy9fsD4Wc+vevtAzzvdPPuy2QxuTrm31qBkl5OM3vaRkJjHklxN0Qdy1x5boSVtIW1Ij60C5ErIXZ0Tsp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 23:45:52 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 23:45:52 +0000
Message-ID: <3c809527-731e-4b52-af21-01574c5e2fda@intel.com>
Date: Mon, 13 Nov 2023 16:45:49 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] kernel/resource: Increment by align value in
 get_free_mem_region()
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
References: <20231113221324.1118092-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231113221324.1118092-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e195e-e497-4c4b-4a1f-08dbe4a2abea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBxHdypZv51nSF3FZ5B/fSMekvdfDypgyLZ5bHld6TQ/5b0FOwlE4Kvd7apXzjGjVK1LyE2uokky4R5kcXgG8Vl8H1LeuqUu4E3UFgh3Gr0bSC5Rs3Nl+Az+C/Hg7gNMPO1ZffxDTS/8v9BE64IRMKH/ix7uZcaP63jiBq+LgcP2gP5+dh5kro1iLWkg+gEOBBw3q7Gxm9ngUkbZ8wa6y6t8b+S9gPvpDaJTvht0dX1EYJ0OURCiBNGgfe5Fzz9UbJvShDGVcGtLf1k+j2sQoauveMGyFNGfMeT4UIYqiuO2sskvkVnL/MtR7ERPlRyrvK72pcFsouFNYmI1WSMxrJh0bpcn2ON4G6PT+oDiu6c+p2UThXW8w1TM9XjMn80A6TevDR0ZTVaNm/SVMGLl7p+hlp6K8vtp7MnQfdwK9+YgPIIrZP+SMGBnh1hzdDM19mMByCh6TIXt9B/Cg/FKffJcKcPluDjCStEI5JDflxjQ3P2H3tAjrjtUydcXl2SMhTIwOZlqYLl0WbcLZUt6knkKMGL1fAVPj4XknEZo5s4eX7lAbozModegJ2Bv+eaqYixk9PC1S2fVa8hkNT4dMAHieplPXc9K4+9Dij7qGMzgN4jFXcfDMEJFa0qhZe9S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(86362001)(6486002)(478600001)(2616005)(107886003)(26005)(31696002)(6666004)(6512007)(53546011)(6506007)(44832011)(5660300002)(41300700001)(2906002)(4326008)(66946007)(6636002)(110136005)(66476007)(36756003)(66556008)(82960400001)(8936002)(8676002)(316002)(83380400001)(31686004)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndwUjhCdloxbFV2OForNHVhL0RuRTB1eTJNa0hIUytqekJDMHRBUytQc2FH?=
 =?utf-8?B?RCtWR0JOaGJjTmZzano5TGR3S0d1KzJNNkRzRG9ka3I2SjVSZEpWeXpOMHB0?=
 =?utf-8?B?ME9HcW1vQ21DUFNXSzZPcmJ0M01Ca1p2bkpXU1NkbWg3U0s4dTFNYmx0NWh0?=
 =?utf-8?B?aExCZmpnTTBIZHJyZm5oTDNwak9aWG9nblR4eDNoZjBZeVBwdHFZWWJnTmt2?=
 =?utf-8?B?MDBGTWszbmlMeXhJYnB1MEhjYWorZUxpVlBqZ0QvcFVUczFvWTVnU3Z1Nzhn?=
 =?utf-8?B?NGVrNk1xU0RULzBoWTQvVUpZckk2bzNNMHFvcTZIYmp3OUhNYkhOUDZqbFJ3?=
 =?utf-8?B?TE5RL0YxNVE0cEVUTmhpaGhDY0xBYitqbzYwNXNCVnh1NXRsQVQrLytVR1VU?=
 =?utf-8?B?a3pMSUE0MFplMzZaMG05ZC94K2wyVlRGYUszMU1ocFpJMUNUVUl4a21vMDhu?=
 =?utf-8?B?d1p5QlpQc0hsaGpiVjcxR2pkQnlZZGp4NXdMellnd205d2tLdUZ1OWpZbkhM?=
 =?utf-8?B?U3NQV3gzNVJ1VnpUcXVBbzA3N1N5cWlDZzJ5RWVQNHVza3EzSE5iVjhzaFhM?=
 =?utf-8?B?N1hLTTdYSFljUDJ2OXFQcHpYL1BzcGFIZFViQy9GbkRzYWFUWjZrRm9IbFg1?=
 =?utf-8?B?OWtjbGpHN3RONEYvMERoRWdXVlMrZmFNUHFUWEd0ZVJiOStBUVFwam5aKy9O?=
 =?utf-8?B?bTJQTkZYSU5tODFaSWpqOHdYMnFrZ1dxY1FRVHN1YTl1NElvQ3lkSXh5WEk5?=
 =?utf-8?B?ai9TZnlydER4UWV3WUErcmhVclcwZTZMbFpuZFJ2ZWdJSWpCMEI5TFpZVGRR?=
 =?utf-8?B?VFpUUkp6N2JtL2lNeStJbkNySkIrR2Qva2xqMHI5Qm5xblVaQlYzeDk1eUFT?=
 =?utf-8?B?QWhCbVJUSEpKUXhCMU0zZEpad05jQ21qMkxWRE1LMk1zZm1yd0paM2UwSGQz?=
 =?utf-8?B?SzlNUUs1MlcwZFVpQlZzWGp2NUphV3BJMHMyekJPY0dvLytZRkJGRTU1MENt?=
 =?utf-8?B?TlJVRVp6SHp4T2M1Y2Z2MkdNYmlIZERwMXdmclE5OTZyQ3pINElrMXlEWVFu?=
 =?utf-8?B?TVBjZk5NYWpjNHh2WDJRaG5maHRXb3o4dk41b3dEM2V5RkFDSnJNbVRIWWl3?=
 =?utf-8?B?NzZ1bnEwbXIvbGxxR0ZXZ1BkOXBNUUtvSUZrMGF5WC9VekNlckZNUGFQWmVr?=
 =?utf-8?B?NS9sZktKa0dvNC9zMnVWNGVWSGg0U3plZzBjUzRxOUVKWkdnVGNNaTZGdzJZ?=
 =?utf-8?B?ejAvMGJGTHlEWjJFMkFSaGxPZmVYbWN0QW52ZWdmZUZ6bWlnVkZleWYyc2Fy?=
 =?utf-8?B?ZFo5dHpDcDc2OVZ0SlFSQjhHa0VMUjg4MGVRNDRTOEdHVElsUCthaUtISlhO?=
 =?utf-8?B?aVBMK2VNcDVRc3lCTVRldW1TZHVreGpOeVRwVWVxT3dOWmJSVGp3OXNKMUV5?=
 =?utf-8?B?M1dxenYvRnpKQ3RST2VJTVZFTFRid0VHNXpnMVNlc01QWW9WaFBRWThhUEZB?=
 =?utf-8?B?Myt3em1BNHFzcXVSN1dQTUdNc28yRzl5WE8yTzRnUnU1ajJxU3pPOHVWVDhO?=
 =?utf-8?B?cVUxUXhRUXlOeitJdlFtTEJ3UlR4MzZ5andNUzlWdkJVVG83REgzZlFWVDRV?=
 =?utf-8?B?RHBneDI4Wkt6ajd2SlYrOGR2S0lNY0JrSVdzZGtoREZyOGxBNUFLamNGWlVC?=
 =?utf-8?B?czJtVHBPUGk4OGcraXQ5RHljY21vczA2dkJBbkJvMVBMRDFEYzczZklQaXl2?=
 =?utf-8?B?YWlZQURtVTNwaE1xZHNwRXZqR3ZQbFZ4U0VYR3BuZEpCWmNWaFd2SklZYW1i?=
 =?utf-8?B?YnV3Nm9kSExKQXJzd3JZRkVkRmJncG1uYWdRWEI1enVTTkEvRVhkUzFRK01W?=
 =?utf-8?B?OHJic0UwNVpKV29nN1ZkSk5OMVc5NWVYbDR6NG1CUnBLaTkwNW9KR1BVSWpO?=
 =?utf-8?B?VmtUUFY0TDZwNlJ0cysrVFdobS9SUE9wNTFiSGcvaFQ3S08vWjBWaVZCRnBP?=
 =?utf-8?B?d0VIR2pnWkhBeXRLUU5LNTVnNFduSkQ5N0t5V0xzMGkrRXlDOGJlZGdKY245?=
 =?utf-8?B?L1FuMlZrakxsZjkweHZEa0dOUFB4dnA2TzFoODlzQVhjMkRyeVQwb1owV0I1?=
 =?utf-8?Q?RQfHpfs2SJ8m1HOQtILr4hfdr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e195e-e497-4c4b-4a1f-08dbe4a2abea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 23:45:52.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3s8RrWWub9AzYJikGYPJ9dTMC+AzksiOEc3n2uc3HcpaIRulqaLap+D2r7ieAiRGosPt1+QX6uGivEA2ZLgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com



On 11/13/23 15:13, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Currently get_free_mem_region() searches for available capacity
> in increments equal to the region size being requested. This can
> cause the search to take giant steps through the resource leaving
> needless gaps and missing available space.
> 
> Replace the size increment with an alignment increment so that the
> next possible address is always examined for availability.
> 
> Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> A couple of below the line items:
> 
> The MAINTAINERS file and get_maintainers script did not emit a clear
> recipient list for this one. Start with CXL folks and I can expand
> it in a v2 with your help.
> 
> I considered, but didn't, change the parameter naming in gfr_continue(),
> gfr_next(). It's a choice as get_free_mem_region() is the only caller.
> Thoughts?
> 
> 
>  kernel/resource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 866ef3663a0b..91be1bc50b60 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1844,8 +1844,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
>  
>  	write_lock(&resource_lock);
>  	for (addr = gfr_start(base, size, align, flags);
> -	     gfr_continue(base, addr, size, flags);
> -	     addr = gfr_next(addr, size, flags)) {
> +	     gfr_continue(base, addr, align, flags);
> +	     addr = gfr_next(addr, align, flags)) {
>  		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
>  		    REGION_DISJOINT)
>  			continue;
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
