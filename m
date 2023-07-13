Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911EFC001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGMQ7x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMQ7w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 12:59:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7C2700
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689267591; x=1720803591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=42WSerha1zjibioew5su5VXlgosZb4zLI3IyCQM9X3Y=;
  b=T/pXpZuqhJ2msq+R0I9bYv9guq8zNrqv/3cdVCtINf7gcb0wmAsTZzjH
   98c/BjZvTdZQyYKryyKhFWSqR07ssNh/0XCF4bAUDlJjp9XUr3FRjTRsT
   RO+1kJymbP3ni1PC8C0VErI3lBp6PQJDR0T5W4XtAxE5C8a6I4WtzUY0f
   N/wpkSw+bPYjuAoySWDThi6+d6Bf2ChTdSL/BVJppCJgFK/O/ZiT7f1gr
   3aXD9wswnmSxAZPXIke/PHntkGMtIl1eqf85hOL3cQ0+OINSoqWOwFsry
   rDFq+IDVE0YdKF1JVXQEG78iyDwc1k+ColKVKNiCt1ZCcnuApaT9G9iBI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344847000"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="344847000"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725376344"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="725376344"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 09:59:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 09:59:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 09:59:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 09:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrgTDkJ2sw/DO74d3bMVWTZBH7IlV2J4hjxcR31KoUjP7f2bvMXZBemcVe/HJcWlc6LYeqNMLl+Pr1iQAKEINgQn/pTVfIlrpmikHIh/mcP2bc4nFXkMXvA1a51DAFmSjsrPl4ZW+wTfJKWrlfMes7ZcL+MInIQwskTSlhNyNoqxuYu4XRJKghI+4pvp6kX556ylagRuwr+WSF4tRZPx1OiJDjuISdIqBMrdwdP1Rym7vqShDtF0Yc4PHTAMZqY276I0kobFCJlUm2+fnrnzCyQJJdW4shG2qPs8vHBLc5o2skX3pktHTl7Kt7+jhF2NNs/EbJLqsC/rY6gaXC3QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYUtVvmA2tC8rRGY9c9nD2lURCM1YePuUSDJJTdtnbM=;
 b=DEq7k4fQ6WJZEitLSMVubyXrmP/F+6LvGTGWNDY21mKxV3c2ZhC011uRNrX5kxYJX9vxP4FcIsZwiM9vujgRdDRg6lKHJY03vDqa8A/MUs1DsjZF/6aBxHbZcxRChxPMeDU6+CQZ9EOlcUIlPxzEKEZkNHOmwv+RAKSyFX38ebRNrXxTCtnKZrZeMLhJ2SaXvPy7QtVo6kLPEB4vBhU/eB5iLYvDozw6aRqMrtUtSWsepW44S0WooMEQGohge0jsWHiwle1O8bfIuqFyRzz3GmzS1zTpr0ALhaiTAewTyTBOspqe9hoIoQZoKblPrb291spw894RHIg9qU1rJDjfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 16:59:02 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.025; Thu, 13 Jul 2023
 16:59:02 +0000
Message-ID: <03a3f114-bf47-13c5-911c-58dca5969009@intel.com>
Date:   Thu, 13 Jul 2023 09:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v2] cxl: Update MAINTAINERS
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
References: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4b4375-d4f1-4107-3215-08db83c2753a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kVFEosO4DjXjXeWR/hW5Xu+oe2XYCh0SCWtXGhFwsJg9puTgs0SK0Sj8/KOpWR5WCgu4oR3905yVz9Xw3Kvw+xi0z2oJLmZjzR37WULHzHNpSWbK4sySEdedo1jMSypolkzVq6tGwZlG5Y+xFxxi8FdZux3dz5YBTKbmUr3S9h5iVJb5BHTOQuPs2ofE6NN1VCv18OqY1x/55PaLAJ3OD9yp6lV26I6ogFE3dkQMqjUR/MBAJIb5ROVCCJC2Nc2NGRxna6KGboarwCwYp/sU8yGhcFjmMFYcGKLimX0icj1Qmd6jw7ipfcRswhxcTKjLMNMyd+c3wLqUD0Vl3owWcLllQguJA8TZ54ZfJTN0ab/I8ehsoorzLQ4z+ZT2UA+DsjLQm0Yg0rkayVBXymVoxO2RBjn+m0zFv+Bm0UGTpQe9Uevgv5d3CEgkLEx30psCcobZEzdIy51WAmJPJKjSVjuEzeRCigpOEAR/9+Eh9HIAu+4JeB3WZik4JKktG7NdLamXkAWpm9UV/etTyPlD9jf5sDr4k2giTkZVBYOpXHF3rab+k2E1F96kdSNoUq61RRgF0/oMwJVd79m1lrHq8LCehD+1B6LnoLvYCv6T4vFe/Mt+vtpdULQovnCBXqXFTObE3wLxWyESTOzglFKBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(44832011)(4326008)(66556008)(66476007)(66946007)(316002)(41300700001)(2906002)(478600001)(5660300002)(8676002)(8936002)(31686004)(54906003)(6666004)(6486002)(6512007)(26005)(107886003)(6506007)(53546011)(186003)(36756003)(83380400001)(2616005)(38100700002)(82960400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9waHFkd3NpSkl0Slk5L3V4ejRYR3dXN2VxSG5ycEN6c2JGejdFbDZBQTFW?=
 =?utf-8?B?UHN3S3pNdm9hanB5N0ZVS2tZeitkYlBSZTBRQWdwd0JudXU3S1VhV3lrQ3c1?=
 =?utf-8?B?RVNKVnpMODEyZTUxQ2lWU1dIS0c3bkhYN01nV3k2eXc1NmFQNld6WEgwcVdF?=
 =?utf-8?B?UnNhWFRoQm9HTUVRc2FIeXNRQmxuZTIyQnl1WHVIUnhPM0hWcXN5d01iWXBt?=
 =?utf-8?B?Y0xxWGdkOEZpM3lxMDdEWHA2bC9NejU1NDFPYzRVM0ZTbzcvayt3bXB3YVhh?=
 =?utf-8?B?c0YxVThQMUJialRHUjIrM1g0RnhlME5uTGhLakMrcUdwR2xScEZMY0piRkRD?=
 =?utf-8?B?N0ppNWYxN1RUaDdKLzRTVHZWK3J1WmJ2QnNaMkFQS3oxWWlWZDRLeVpyT0Jp?=
 =?utf-8?B?Mm5oRCtieFlYUFQvUzY4TWtOcjY5d05ldElxVndVTktSa3p3S3lrRUlxaDdw?=
 =?utf-8?B?a1hna3hMS3RUeERqOFlPWUEzL1RJZWd3N25WZEc0bVM1VmgvM21yR1M5RTVs?=
 =?utf-8?B?YTZBNzVoNnQ1Q0tWZDkrRE5BMjlUSFVta0doTXlhNTI3SGpHTG50R0xqMWlE?=
 =?utf-8?B?R2RDMm9oNHRpSUpDcE5xRXJhbTIyOGQzZ0pCRS9ZTzJIR3liMkY1bUlOOENq?=
 =?utf-8?B?NGVpdlp6RGdweVV6aHpVTDJtRng1MVNHWmtiK0JlMHZyd2RoejhpOWc1ekg2?=
 =?utf-8?B?L1dXNkF1ZXNYQ1FIcmN6ZjM2MXB2RGZtcDNsQTJIT0pHRUJWaUVuK1RKaWho?=
 =?utf-8?B?aENWRUZrTDFHdGM5dUs3cndxbWxqVVA2UU9QOXBIUWtZZ3hUT21kbGlxOGI2?=
 =?utf-8?B?d1l0WjdDdW1vRTZjUUZyZDFHOTBwZmtTOXVoVW83OUZaRmphS1JVeFNhdlFp?=
 =?utf-8?B?ZkpRZFlpTzRxc3NEaVI5K3cveTJyRjJZRkFlM1NuNC9SelRtWEttN1l3aGJW?=
 =?utf-8?B?TkhnSjhMbkw1ZXJ4SWg2WkFhb0lKcjkzY05jZjBCYm1BVkxQcHdEYy9YRG8x?=
 =?utf-8?B?NTJ1b2RYMjR5bjF6QmxjQ3dLRDdtNkd0NXBNNnp5Umh1QXh1RnI5NU9sSmdP?=
 =?utf-8?B?eEM0Z1hsVWcyeHp6bnRsM3RyYmsxVlB4ZmNWRUEvMDM3WDh2MGY5Z3pqb1Mx?=
 =?utf-8?B?c3ZHVkRQRlpCL3ZZZkFKajVoN0tBQWwweW1yLzgyd0lOdnJPVmtxQTBKYVVV?=
 =?utf-8?B?UXFibm1lZ2M5SThwbzkxOFZHMXdMdUYveVVpZ0dlMXE3eFZrOFl1Ly94bE0w?=
 =?utf-8?B?ZmpoVXJMV2xKWlAvcTF6WEtoUkY0NFU3WEUzWHM0bEZiYlVqa041V0daQ2FS?=
 =?utf-8?B?QnlxR1VnTjFMcVBwRCtvbktIcS91TmNVcWVubnk1RTFKdWJxcDBzendaSkxs?=
 =?utf-8?B?Mk5yZnhXS25LeCtJdnl0a3FCSllJOVpzV21YU3JpNG9FY2lhWk8rakZvZGIw?=
 =?utf-8?B?T3IyeWdwNkZoVkFOaGgvKzJBM1hjZTlmSGJEcnl6Z0dWaVM3K1pJUFJBK0NL?=
 =?utf-8?B?SG9ibHZpQmoxWmxIYUU4dU1iRlRma2hVMXRSQlhuSGpHZCs4RStsa1RVMllj?=
 =?utf-8?B?UklHOENrTEVJaHplemVmbENYSk1uRjI0MnRtUkd3YmU4TDh2ckV0TnY1S0Ro?=
 =?utf-8?B?WUxaOFFnSmd1L3N2OVM1YmhKUEtJMlQ5aXM4M25JUXlwK0hQc3lSRFRYbXhD?=
 =?utf-8?B?aHN6U09XbmtzZy9mRDV5Z0N1ZlMxenA0ZXhQZXRMTHF1MHBjV1NkQUZSUVBJ?=
 =?utf-8?B?QnJXODNJUEFFWDRYWHplelZDbTBQY2RrdDZSV3B6U255ZWNCSGorMHdFdFE4?=
 =?utf-8?B?UGJnb1kwNFpQTEFOeERMSllad3JGNVZNLzZqL3I2SFhwRHhwdlErUWpla3ox?=
 =?utf-8?B?dkg4VGdFSVp1MTFQcTkrTkpxWkdvVmZGdmxNZ1FJbzI5OG1FekxTVk04Tkdu?=
 =?utf-8?B?MnBuK1luN0hUNEZjNmx2WW0rU1U4aExCWHZuOEg4MWg2Nnh5WjFjQml3a2Jx?=
 =?utf-8?B?N2pxTytTc1kxeU9uR29ZWEtuT1RaeGVHRWZ6NXpWZ1o5L1BpWS9jRm1lb1R1?=
 =?utf-8?B?MzZJQTB5b1AvZlZmaksvV1dRRnpUYTZDaXhPdG93dXlpYVpPUk41OUsvb21M?=
 =?utf-8?Q?F//Zdu+ST+NnE6hqCyomG1OJT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4b4375-d4f1-4107-3215-08db83c2753a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:59:02.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mwd2DsBkf+1mPY6TX//o+Bv8YdFXbV3bty+OUGLX0zNNu8xDA2QSoQ1UL6DgVEMCZesvArVkKaH3loZ3tMELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/12/23 18:50, Dan Williams wrote:
> Ben, thank you for all the work to get the CXL subsystem off the ground
> and establishing QEMU as a place where hardware vendors can collaborate
> on the new advancements and mechanisms appearing in the CXL
> specification.
> 
> Jonathan, thank you for your continued review and collaboration, you have
> been a defacto CXL maintainer for a while now.
> 
> Davidlohr, thank you for getting the background command infrastructure
> off the ground and your leadership on and off the lists.
> 
> Dave Jiang, thank you for yor continued attention to all the
> cross-subsytem plumbing issues that CXL continues to create.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks Dan!

> ---
> Changes in v2:
> - Show Dave Jiang his due as well.
> 
>   MAINTAINERS |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..82de99b6b340 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5140,10 +5140,12 @@ S:	Maintained
>   F:	include/linux/compiler_attributes.h
>   
>   COMPUTE EXPRESS LINK (CXL)
> +M:	Davidlohr Bueso <dave@stgolabs.net>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Dave Jiang <dave.jiang@intel.com>
>   M:	Alison Schofield <alison.schofield@intel.com>
>   M:	Vishal Verma <vishal.l.verma@intel.com>
>   M:	Ira Weiny <ira.weiny@intel.com>
> -M:	Ben Widawsky <bwidawsk@kernel.org>
>   M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-cxl@vger.kernel.org
>   S:	Maintained
> 
