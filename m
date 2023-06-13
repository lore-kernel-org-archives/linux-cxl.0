Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B0EB64DA
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFMXAQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbjFMW77 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 18:59:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FB173E
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 15:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686697197; x=1718233197;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x2bG8EeKgRo4kWISMiIeCv7TbtgVczjyJ3emZ06TmRY=;
  b=G7ZzZCB3dhrw9tG4HkqnSn6x0nl1JjzsCVuKtz+p5tWtjKZLcAfDulV5
   cs00nEQiVd+BQd5YWSR55qomjXLebqqScoLiPLVNb+FxWYe3WRP9iN5wi
   ldHXH6d+H6Mo9AySFVZXQdYxfz1fvfYzRYvzxi0bVByzXN/zP671G2Q24
   QgzI11BNcfglqApbYQSsDXTf4vKEPGm7BWTtFliFfV6iRGvGZnORWWP6E
   eLhQ1fX131Zb5aqJ8rq4nOufhDEhpfw0rilV3Qp9HY2BVdvAr3Mn4oI91
   /EQqON1oSRE6KpOuVWiEBuL+VUjYdvhBxRyuY0QB+Lh0Hbioh6zJ1l/X/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355967103"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="355967103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856280211"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="856280211"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 15:59:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:59:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:59:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 15:59:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 15:59:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4tvsk5P3K1qg9J7m9PRLTXQ1QOUoNZ/zpG/16kjjAtgkx4PhXsurNFGqAHfNrik344EclgqMonRoYmvUL+p85VnY37p4wbrXb/wiAAjPc/W93GVvcVJ/jFsxWcxWbyuIQiTUkJbFfUZxzsGVo3nLW8huC7LK1ilCxoG9AkgkAQ1hgcLds97FHU2KW6gDBRjeCwQVMGxb9tm0snm2ljEYqhOvO7k5oOgdfpjpUD/J72junL2p2wD7MMfBz07NsHHZAr6YIji5FnwhNoyg+vJ8ASbg1ztiGbjP1Um9Zd1D3hVXUNz6wkrPrbR2QqtDnVmKAtfiRccxTd3lSHK7Ov7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYsL4YhHh7pZnpZNvipn4NfXQ1gBWJmu8yvcFy+JTM0=;
 b=Zjo+MKRRRty+N13Av2qcJbErkdAFQmdteZuq10vmOnb3ZrF8ildUeA02ZzFPReT1QGlwtCUSsgWfsA7k56yvnDZpsw08lYfAhoLhDrXt+HqKbkv7yJ9J1aAzf8+mwm64dnvdVe+VIYwD6QOlawBLzjhoFr9DDjlaPnWCCJzBJBwUNyvSUPJ0YeL89Fp8bBQpgWDDprKIfpBvpviovniy7/pbYeKkdDiMszPte/5AEzrVaSDKx3uANpjUNemFoKzeLkiRKvIfp44pHLHPGADUgv9VTYSbm58TFjFplft+SQcl3Szt95AQ9HTx4j3tyaNaeUgH5TR8+ybalxJkuUtZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7404.namprd11.prod.outlook.com (2603:10b6:208:430::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 22:59:54 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 22:59:52 +0000
Message-ID: <a5099d00-a505-c6cb-ad3c-a7864d3ff412@intel.com>
Date:   Tue, 13 Jun 2023 15:59:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 09/19] cxl/memdev: Formalize endpoint port linkage
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 178ee570-3eaa-4fb3-7c0d-08db6c61e57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YhUWau4W/4kNsWF63w5rVK41rKUe9OcwCtZAwgodXIItkuW43vnlsLSEDMtyDeDYfxRG1i0WaoW66VT/hlwsEBFIpaPH0uoVkiVIVTmQRcOaDhYEsU93rVosCRAedEXHn2JFO3FyOtS4HiD3IPpo9k5BIEHPfMX7voNDxBYbsebwdPNOJAKlptWEVHbydr8nfZZTEVAVxtSGpi3DFy5n6Vcs4yX95a6mXOJHWsBzgeN/k3tZhS0otJjiYA+SC13Bh7lSrz84bMyLICrQJQwbxGBJbgvXKPQltLSXzRsSgTn1+gDA5D67N9Wsn5KdWu0bKjPG++ni+nJDrYtt5IKVhyJf2WGxG6rkvrBAjMFRKZd4vVsV2QQeqbnUHIy1+mzuSoT04ZswB5xzX2aiRaMbreGUkUGDXe6YCgf80JJwwWMyXG0sYPlP2UjWW47qv5yAtmpnqgYmfngCdymUKqvP6IgxEios4R+2DjijNICpSq1VSy5dQ1u+bKOPtkXyUudRwzbFykLbBz/M5erdrvQr9gYKnoWMFR8y8l1fZJUQGCElDK+ma52CcSdOHRMW8ywsTQfiplrf9UJ3MKWCr1nhtoZofGc53alstnr2j+m5dK9lRC4cqtHBAsbw6mAlWgL+z+AmCrImuSUzNfjK9dWgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(107886003)(26005)(186003)(6506007)(53546011)(6512007)(31686004)(2616005)(83380400001)(86362001)(6666004)(6486002)(2906002)(36756003)(478600001)(82960400001)(38100700002)(44832011)(8676002)(8936002)(66476007)(41300700001)(4326008)(66946007)(5660300002)(31696002)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRTRTNiZVFqT2NiYi9TTVN5UFdIalI4N21Ia25mbFcyaVZ1ZS9XeUx5TzdG?=
 =?utf-8?B?cVRHQm1hV3FMRUk0MHo0VnMzZ0l6SzNzNWx4cU0rTkNLNlNVdzJpZXd3dkZr?=
 =?utf-8?B?VERDdm0rdjNabnN6Y2pWQ3ZmWWJmbjRLTFhvVDh2MzJBTEhOSmx6cG43aDY3?=
 =?utf-8?B?ZDdIQmN3SHU5a1YvZlZLR1A2cVJFbUliL3pkWGtRWndaWkE1UUtTYzFvcVlt?=
 =?utf-8?B?ck54YlU3Q0R1Vmw0aEpFZ0ROdE1jblA1bys5RmtleTVHQW5XVWRxNUFuSU1y?=
 =?utf-8?B?VWlWSENYQ3dkczJvdk5QSTUyM1RDY2pqOGg4YVlYOVBVc0VDeHRXdDVzVFJ3?=
 =?utf-8?B?ZkJIbThNTFlIYnpXN3NrQVcrOUlKdzVqNjRtYml4aDhXNitKZnhjWEs3NFZh?=
 =?utf-8?B?SkgvWkJYK01yK2xzUEVmc01EanZZTTdGU3hBYmFETDcxZ3NFQ2dRM2w0YlFK?=
 =?utf-8?B?SEZaYnpGayt6UHdoVDRnY0FBM2ZFQmZZc250YW9xV3pna0U0cGxmYXdCY3d5?=
 =?utf-8?B?RFRPWnhnV2Z2MW1JTkNxc2I2Znh0YW5jTDFIWUlOSXFRYytOYlc5WWJwcVN4?=
 =?utf-8?B?UVJxUm5UaVliZ0M4RkdpRGdkNysrZEI0Tm1Gb2ZablpJUXRrRUt2NS9LU0Mw?=
 =?utf-8?B?Y0JHK1RTYi8yRE1ralFGY2xsa2ZIay9VTG9qUy96QytzOU9EMmZFWmhFM0xn?=
 =?utf-8?B?c2dLY1c3RXVQZXVZcUhVRDF3Zng4dFFCbGs3T3ptajRFdkV3QjVIbEp0UElC?=
 =?utf-8?B?OGJIUXdJOGo3YkZ4c1FzS29tUFpteUlod0ZKNnpFK2x4dmFvaCtweTR5YVBK?=
 =?utf-8?B?azI0V3Awek43aldVYWk3T1Q1bktDSG9CS0o3Q0tZZTAyQnNvMGpVUSt2WEx2?=
 =?utf-8?B?YUozUzJsYWlWVzVPYitLeUV4NWNVdmliUHFpcGt6M3d2OE0vdEE1TWRPbExo?=
 =?utf-8?B?RXA2MjZoQjE2S20xV1A4UWtRcDFYS2FqL1RVSSs2ampibjBtVUhZdlhlY3Vt?=
 =?utf-8?B?SXlkdk9lTHMzbks5OEJ0REw1alZ2TGNQRkhOZ2dXTStodDNYYlNRa0ZocE1r?=
 =?utf-8?B?b1JqVVJ3LzV5ZW0reStYT2t3WDlFRm1DaXhVaDhzbHcrMHgrN2h6TWcvYkZL?=
 =?utf-8?B?VktLLzd3MW95cjdOcUszN2pkazRRbCtMM3ltQzBaQUQzc1FCaTVBZHdPVkkx?=
 =?utf-8?B?eTdaQVp0cTJ6WHRmbHQrYkJ2M0JGbmswNEk1bytHTWhkTXJwSlQyUWV1U055?=
 =?utf-8?B?S0tBeW83U3d6eWUySWFFVUNOSTlheHVwT3dLL09YUkZBaHdFUEdQS1ZZRjJv?=
 =?utf-8?B?QmhlSnR3NG83WUJ1NXRqeWRySURFY2xqMXdjTy80NElPWkdWTzdvdVhzYjAr?=
 =?utf-8?B?TW1XOUxJcjdiUHBTWGtUbVFiTGhGV3NBU2ZIODFrTm92bzNtTE9KeGZSRW9Z?=
 =?utf-8?B?N0Q1alAwYUE2UElIcW1OK2dDM0pDQ1JYWTh3eEpKWEFZUmRuN0MvamdBR25q?=
 =?utf-8?B?RUV3aUJIbDZFUU83Vmh1KzNBWmcwbm5Kb2tZZXdISThhVFlhMmxKaVh1bWhx?=
 =?utf-8?B?dTRIUzlFdU51NVZiUEUvYUx6KytyT04wRlh6QWZqQWFMdlIrWDM1SXMvSTdq?=
 =?utf-8?B?c3NzOURQV2xBWExQRDJRVEJGcFpPemVTSE5nNzNQMWZYNTRuUWx1MGxXdGNq?=
 =?utf-8?B?TWF2NzJCdEpTUWdJOVFqVXJ4KzQrZ1lDTk5aUnpzZGVYeEdJNDU1dURwTVZt?=
 =?utf-8?B?bm9seUJyWHdxY1BLTEpZWHp0eTRWT0NnSHVheW1LS2RTUVJsUnRHbk5qZW02?=
 =?utf-8?B?TnJzSHZSakNOakU3bmRMYmRiQkltSEczdXF6NlM5S1RMdkg3V25qczArQmpO?=
 =?utf-8?B?Rk1CcldYY3pzYkZNVUttc25mNFR5cjdMK0t5Q2pEYlJBaTJoa01sOGlaZG1p?=
 =?utf-8?B?Y1JvTS9iN2dpamxPWDc3YWNIQ01abE5Gc2orS21Jem11dkMyYkZVbkFBYWtO?=
 =?utf-8?B?Z0I3N0NmQzFzeXlOTlJyc0c3T3FkS0NWekpIbnBUSEFscXFodzVGS1lFYkJn?=
 =?utf-8?B?MGZWekZwQTJ2Sm9wOUEyMk53M1JmZXVKN2ZKSG1QV1MxZmlQL0J6S1d3SFRC?=
 =?utf-8?Q?ccaguL6EtpbZVLox/tY0yHhAx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ee570-3eaa-4fb3-7c0d-08db6c61e57a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:59:52.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUtfb6WYPv6MZhXrbtYUvDkQF4eslPQbkWPGTuMRGy6lBso5UQJ+xlG8LFdUOIvGmBF8LXm2QhPs+WhD5B/QQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7404
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:32, Dan Williams wrote:
> Move the endpoint port that the cxl_mem driver establishes from drvdata
> to a first class attribute. This is in preparation for device-memory
> drivers reusing the CXL core for memory region management. Those drivers
> need a type-safe method to retrieve their CXL port linkage. Leave
> drvdata for private usage of the cxl_mem driver not external consumers
> of a 'struct cxl_memdev' object.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/memdev.c |    4 ++--
>   drivers/cxl/core/pmem.c   |    2 +-
>   drivers/cxl/core/port.c   |    5 +++--
>   drivers/cxl/cxlmem.h      |    2 ++
>   4 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3f2d54f30548..65a685e5616f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -149,7 +149,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>   	struct cxl_port *port;
>   	int rc;
>   
> -	port = dev_get_drvdata(&cxlmd->dev);
> +	port = cxlmd->endpoint;
>   	if (!port || !is_cxl_endpoint(port))
>   		return -EINVAL;
>   
> @@ -207,7 +207,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
>   	ctx = (struct cxl_dpa_to_region_context) {
>   		.dpa = dpa,
>   	};
> -	port = dev_get_drvdata(&cxlmd->dev);
> +	port = cxlmd->endpoint;
>   	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
>   		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>   
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index f8c38d997252..fc94f5240327 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -64,7 +64,7 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>   
>   struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>   {
> -	struct cxl_port *port = find_cxl_root(dev_get_drvdata(&cxlmd->dev));
> +	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
>   	struct device *dev;
>   
>   	if (!port)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 71a7547a8d6f..6720ab22a494 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1167,7 +1167,7 @@ static struct device *grandparent(struct device *dev)
>   static void delete_endpoint(void *data)
>   {
>   	struct cxl_memdev *cxlmd = data;
> -	struct cxl_port *endpoint = dev_get_drvdata(&cxlmd->dev);
> +	struct cxl_port *endpoint = cxlmd->endpoint;
>   	struct cxl_port *parent_port;
>   	struct device *parent;
>   
> @@ -1182,6 +1182,7 @@ static void delete_endpoint(void *data)
>   		devm_release_action(parent, cxl_unlink_uport, endpoint);
>   		devm_release_action(parent, unregister_port, endpoint);
>   	}
> +	cxlmd->endpoint = NULL;
>   	device_unlock(parent);
>   	put_device(parent);
>   out:
> @@ -1193,7 +1194,7 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>   	struct device *dev = &cxlmd->dev;
>   
>   	get_device(&endpoint->dev);
> -	dev_set_drvdata(dev, endpoint);
> +	cxlmd->endpoint = endpoint;
>   	cxlmd->depth = endpoint->depth;
>   	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b8bdf7490d2c..7ee78e79933c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -38,6 +38,7 @@
>    * @detach_work: active memdev lost a port in its ancestry
>    * @cxl_nvb: coordinate removal of @cxl_nvd if present
>    * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
> + * @endpoint: connection to the CXL port topology for this memory device
>    * @id: id number of this memdev instance.
>    * @depth: endpoint port depth
>    */
> @@ -48,6 +49,7 @@ struct cxl_memdev {
>   	struct work_struct detach_work;
>   	struct cxl_nvdimm_bridge *cxl_nvb;
>   	struct cxl_nvdimm *cxl_nvd;
> +	struct cxl_port *endpoint;
>   	int id;
>   	int depth;
>   };
>
