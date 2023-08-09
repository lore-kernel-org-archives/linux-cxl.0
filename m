Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B262C0015E
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Aug 2023 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjHIXfB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIXfA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Aug 2023 19:35:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7949EE
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691624095; x=1723160095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uBpu+c3ntfva2MxXKaGMYn8ArGhzPZRkJOYhpw4fODs=;
  b=lJKIn/fY4Ocg5Z0pZ9BX6WIoC6ZnIEmKQgDUGwz4UHIGOLxfUGNzATmi
   VbRZHy0duSgBXFrIn+/R+hCIUIGCqMZxXtpedCHxQOy9j3MUwmw5KFb4i
   W1XvcC9ZGXDIHgDxl6G9EAomwa7s/ow6/RNOcLVypdJkpJYMqi4fFrXYl
   SXLzLODroIthDu4DvDf5H+bDfYSeYOIogMQjg0MAlRYEeKuo6owODxyOw
   /6diNy+T2GJGHesMp45lLzL4vQPN/NRIDFqs++BQKQn6+Ric5q4AZxrc/
   UJLU6mJp6fO8nLkZI9iJK8PAv1k3q7Ijd6+FU7ZS+jgzoy/5LFAuUtcxQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374969550"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374969550"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978575501"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="978575501"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2023 16:34:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:34:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:34:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 16:34:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 16:34:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPIuH5nznmOgQqFEtzdB18cu/hws4sh2bvwQnm+bQx6HzLIt8iAjUIBcOj/96q4ndEYt557OKq5SdzM4dU2w8F95j687diAQ9d1pBZngeJfsUIzufTxlQg7iTF9Sl3F5ZMWXlD1iNcpR5yujEmPCOE/ajfaQQzow0+8jtKRP4xlgciUeheSwJCpVKEX1ogS+K6mlLnqkyLl2aefivflp/xv2nryuGSaW1dbOP+Ey1oDUCj8W64Zbxw+0JyYFkswtaLAV+cmF7DZL43zrKtygH947XNAnBRruiNkHNSANxcRmucsqQeGs6ypymOMAlU7+auzl/wtwq4NXRJEHdLZ2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4+k+2xlAE16Qddtm2xsXPNPzRw23+CoY0/mHfPECPI=;
 b=KaKyr2ICXpfqkDXhhQr2Y+Ig6uyj0yFjRKx12iFC6kasHH6oeva5/YJbXzgPeSBdMl/E3T6rHYlvvzul1ld1IH4wOxrun61V6lzVdAjGC7Xe/roRE3j4mXxF9eO3vV4Sd5ZHevmGpHrgmupDCwhQK1yS76Vaor2Rw3s0aBYt811RKHnr2dro0yEf36Q/XZw25hjLghq39uspDtMLB92q8OSMJ49pM2DAb06j+Z43U5032J0czAaHqzPVcRbB+xEhIoEb87zD2vO5fkIT/4XeTWtSQ5Fv/rm30U+1xhJFVMV5M/thPrEMGGBfMILnktMiPoVSM0e+t7Cd9OtvUuZcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Wed, 9 Aug
 2023 23:34:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 23:34:47 +0000
Message-ID: <f0d84d36-44a5-840c-9ff3-0dcdfdeb69ee@intel.com>
Date:   Wed, 9 Aug 2023 16:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 2/2] cxl/region: Remove a soft reserved resource at
 region teardown
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <cover.1691176651.git.alison.schofield@intel.com>
 <2aa10593dbe6a4a8da35077aa492c8aacd363901.1691176651.git.alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2aa10593dbe6a4a8da35077aa492c8aacd363901.1691176651.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 165e92de-e997-43ae-4052-08db993137bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kiws1djbCmoqOKI23IVW9x8Os2JaWpVLSOKImg6Pa5OkVEgLvvqwUgYzOGS77xQPBPGxAO+Wf2ZfIsKxjh8l6XPLFez51kaVLUq+PdcwlkOmlL/L9oJDXAVs9bA0WDYXGypeoneM0H7X/BOuGYkgTTxOrKgvjtkgP9FsmAJapoRQ/gms8J5ognnQybM1oP6fHAjhSWBbdxLBuV8wMCZfdG0aoqiBDf0jVaJx28DN+AHLpIy3LwUSwt72SOw6tIJ2WMogM4UUGWgHVc/emU1+EhrttudPhgl7kYq/HHJfqq55dHELYhKY7Y9k07vG+oYhqfLaqyUegqNyPFJh4oMIdWwJ0q6SAFuyj/VtUdyog7eMDpO+NmOk21f3NvTk5C9B5+/Q0mU4oB3vP8rbkeauZN7Hob2GqTlWPde2DgMdGt4u86L5YlNLg7tluRFONkM4LXdOMlGmg/mqww2PjpxwXQm+cmAaIrQOPlu8+TUdMafQ8w2w7Z1a0ZISKU6C+7LgoeIzCyZXd2eno2xzVEQn6WxY8hvM56G1RmIWkUmbysFxie4PcBGngB5YAZSfXj7JgWVQ1E88S/csrDe2rNr7Wu5hJvv0Wwh2j+pmBvv11UiGHsIAWBtGpxqd1oq9NYylqD/hVVpvZCdU8qz4sFrVKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(366004)(376002)(186006)(1800799006)(451199021)(6512007)(41300700001)(26005)(2906002)(83380400001)(38100700002)(53546011)(2616005)(316002)(110136005)(6506007)(6666004)(6486002)(82960400001)(31696002)(66476007)(66946007)(66556008)(36756003)(4326008)(6636002)(478600001)(8936002)(31686004)(8676002)(86362001)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBDaWkvK0NRUGJ1c080SkE1cG9CQWVyUnJzZ1U2RFowQ01YK2tuc2tnemhs?=
 =?utf-8?B?TmtGVlpmbFdQNHRhUnBlT2xtbWhFS2thOGQ3ZVlNTE5Va2xyZmJhOFJkbFJk?=
 =?utf-8?B?UHVHNzVTenlYWDV4bXh3R0JEcGxyd3J4M1Z2dm1CaTJSTTRmYnlUenZ1Rm5M?=
 =?utf-8?B?VUJVZEhoLzU1eE8yRnZrOGw2Y0t5WXJkeXdnVlRwZFBwN2ZINWVoWW90MlFm?=
 =?utf-8?B?d1M5bVR5amVuS2FuRXZEUFJkTzBUV05XbTUweTEyaTlnVjhtbmdhLzJpcENv?=
 =?utf-8?B?RzNYNTU4TDdWVlNMRzBtMVc0SzVWL0FON3Jad0pWeXZGdVZPalFzVlhxVTIw?=
 =?utf-8?B?K0gxdkJ5UFoybDRYYkgvajZQUmc4V09iampFeFhxeWVEQXRkdTBQOENaVk5p?=
 =?utf-8?B?RXpURkVKdWl3ZFl1SFZwb0pIdTNLR0daK0FVSHhrM3Z0bWM1Y0txS1RZY0ky?=
 =?utf-8?B?SFFTK0ZvYVB2ZkdwQkNYMmFJWXRCWEV0VWQ4dWVIbkY2cE5zZmRFOUQ0NFlL?=
 =?utf-8?B?Mm1SY3BtZE5WT1pRSWlyQWN3NkZIYlFaWTRBRGluVnV1WE5ET3pNZFpCTlMw?=
 =?utf-8?B?TFJkYks3YndPTXhnclRhdzNrbUxyZ01vNHJCcjNIT2p6WWJzOEcwSzJNZERr?=
 =?utf-8?B?ZlJLdnRVSVM5eWdseFhBU1RjalVkTm82VHd1YittOVV1UzRFUEtMdGkyZ050?=
 =?utf-8?B?NHFFajZla04zVGhuc2dCTTM4dnN4aVlqbEt3Z21VYjNnUGkzMVd6a09odFcw?=
 =?utf-8?B?MmJtNUZtZ1F2YmE2TmVnWUhWSHN1Y3RsTnh2UXR1L3dsbDFyazMwY2tTb3pN?=
 =?utf-8?B?ZmUrU29vbWVzUUpUYThTL3ovdFNsK1N1WFg5MkZJNklUVElvelBKR3NQRG9L?=
 =?utf-8?B?dFdGeEFGcy9UYW5Wd3Q3dUx4UEwyRnRuMUM4ck0vUkRLSmhqeEpoaFpXTy9M?=
 =?utf-8?B?Q1Era2g1bU5yaGZkUzhmaGNEWi9UenNsL3c1SUdoeVBJNVovMjBialFyMFBF?=
 =?utf-8?B?TVlNRVk4RHVHZi94RFZ3WVNZMWppc25JbUhoejYrK0NUV1czZ25UckFGWmc1?=
 =?utf-8?B?ZXJzSVhramNPYlBiUjJEaU81aHYzTldKd0x0c294eXNpdjcyajZRMXErd3Fq?=
 =?utf-8?B?NVNuYnFwaHFIcUd4NDdmTnBLWWlrN3IwSk5sWmNZRCtLam93TTN6UG5UWndt?=
 =?utf-8?B?bVBPSHVacWs5aExjRmxUNUFjaFlvQVNsNytYK0tneHlTTGM3TTYwU0FDWWVZ?=
 =?utf-8?B?dkVGcy9yMkxxeFdTNWRadXhiYXJROEdxQ2RQbk1qelFOVE5KbThzUUVYSXhJ?=
 =?utf-8?B?bElyblRnYlR5YmVZcXMra0lkajNUSkYzT3RrN2lJbUkxNCtmTGJzeTRMSUhZ?=
 =?utf-8?B?bWxuL093Uk5kcGtoaUc3WS9jUTRZbTVZRVZzSlJsRjlEWFpuMUtGa05OQUM4?=
 =?utf-8?B?eDIySzhGYTVhUllGaitzUUZ1T0M4VXFrVFBTVndwdU03QTNlSExEWjhUaWR4?=
 =?utf-8?B?b2h1a0puTis3NmYxRmthbWVCUlFVSHp4UGZpakFrNHV0Yk0zQXhGc0JXdk5M?=
 =?utf-8?B?UzZRMkRtSElJS2M1TlJkaHJsbmJ1aXpHeWNGR1BYbzFZdXhCTHY5SWxna3dn?=
 =?utf-8?B?aTBZWmRnYmpZWDhpY2h5RDdVbFZ5RlZnN2YrSWtmODQ2WlVGNUFIQmZFbEk5?=
 =?utf-8?B?Y1dPVjFBazVFa2NUSXRNczRSVFFtOVEwUkU4cEZWU3VNSVFrL1ZKOXZ1aXRp?=
 =?utf-8?B?WEVNRmtteW96ZUtONHcyK1RudGU1SXJ2ZTRRSjFCam5lWnZZUG1yMFhRNkFw?=
 =?utf-8?B?a0ovZ0YzZVdvMkx0cmVYWGptYzBUdFVjODJTMlN6d3lWdm9vaGpFSlhrN2FI?=
 =?utf-8?B?cG5KN3RzZ09jL0YrUGhVbmZhUU15VkpZSmM0d2Rpb1d2aEpMOXU0ZUgyM1k4?=
 =?utf-8?B?QVBpYndab2FpTTRHK3NRaVBUdGdRTzBZNmZKOWRPMlJDUnBiNWJrMmZKdzR6?=
 =?utf-8?B?cnJaVStxYUoweUF5QlJHdmVaa1poZGtnYXJqOGNSUDdqSkpGNlB0R2ZTTUx2?=
 =?utf-8?B?UGdVbXROeG5wMmtNK1FDYkErUVY2eVhwM2txcEpOdG9KNHY3azZRQ1Erc3Fz?=
 =?utf-8?Q?ZzLe412hN2q27n5yKSkkK8AA1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 165e92de-e997-43ae-4052-08db993137bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 23:34:47.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +peZeYKp22QwA04yBxsH74OAAkGTFReVyPE1xg8H1oLzZTA8bc0LbsCQtGrc6HVDatakx4RtrmivZI4+g2vbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/4/23 12:31, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When CXL regions are created through autodiscovery their resource
> may be a child of a soft reserved resource. Today, when such a
> region is destroyed, its soft reserved resource remains in place.
> That means that the HPA range that the region could release, is
> actually unavailable for reuse.

I think it reads better without the comma here.

> 
> Free the soft reserved resource on region teardown by examining
> the alignment of the resources, and handling accordingly. The
> two resources, will be exactly aligned, partially aligned, or not
> aligned at all.
> 
> |----------- "Soft Reserved" -----------|
> |-------------- "Region #" -------------|
> Exactly aligned. Any dangling children move up to a parent on removal.
> The removal of this soft reserved seems guaranteed, however, the
> availability of the address range for use depends on complete cleanup
> of the region child resources also.
> 
> |----------- "Soft Reserved" -----------|
> |-------- "Region #" -------|
> or
> |----------- "Soft Reserved" -----------|
>              |-------- "Region #" -------|
> Either start or end aligns. Unlike removing a resource, which simply
> moves child resources up the resource tree, adjustments fail if any
> child resources map the range being truncated. So, this one will fail
> for dangling child resources of the region.
> 
> |---------- "Soft Reserved" ----------|
>          |---- "Region #" ----|
> No alignment. Freeing the resource of a region in the middle is possible
> if no child resources map the leading or trailing address space.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/region.c | 132 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 123 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 36c0c0dd5697..b8a02afa3514 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -569,22 +569,136 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>   	return 0;
>   }
>   
> +static int add_soft_reserved(struct resource *parent, resource_size_t start,
> +			     resource_size_t len, unsigned long flags)
> +{
> +	struct resource *res;
> +	int rc;
> +
> +	res = kmalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
> +
> +	res->desc = IORES_DESC_SOFT_RESERVED;
> +	res->flags = res->flags | flags;
> +	rc = insert_resource(parent, res);
> +	if (rc)
> +		kfree(res);
> +
> +	return rc;
> +}
> +
> +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
> +				 resource_size_t start, resource_size_t end)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	resource_size_t new_start, new_end;
> +	struct resource *parent;
> +	unsigned long flags;
> +	int rc;
> +
> +	/* Prevent new usage while removing or adjusting the resource */
> +	mutex_lock(&cxlrd->range_lock);
> +
> +	/* Aligns at both resource start and end */
> +	if (soft->start == start && soft->end == end) {
> +		rc = remove_resource(soft);
> +		if (rc)
> +			dev_dbg(&cxlr->dev,
> +				"cannot remove soft reserved resource %pr\n",
> +				soft);
> +		else
> +			kfree(soft);
> +
> +		goto out;
> +	}
> +
> +	/* Aligns at either resource start or end */
> +	if (soft->start == start || soft->end == end) {
> +		if (soft->start == start) {
> +			new_start = end + 1;
> +			new_end = soft->end;
> +		} else {
> +			new_start = soft->start;
> +			new_end = start + 1;
> +		}
> +		rc =  adjust_resource(soft, new_start, new_end - new_start + 1);
> +		if (rc)
> +			dev_dbg(&cxlr->dev,
> +				"cannot adjust soft reserved resource %pr\n",
> +				soft);
> +		goto out;
> +	}
> +
> +	/*
> +	 * No alignment. Attempt a 3-way split that removes the part of
> +	 * the resource the region occupied, and then creates new soft
> +	 * reserved resources for the leading and trailing addr space.
> +	 * adjust_resource() will stop the attempt if there are any
> +	 * child resources.
> +	 */
> +
> +	/* Save the original soft reserved resource params before adjusting */
> +	new_start = soft->start;
> +	new_end = soft->end;
> +	parent = soft->parent;
> +	flags = soft->flags;
> +
> +	rc = adjust_resource(soft, start, end - start);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev,
> +			"cannot adjust soft reserved resource %pr\n", soft);
> +		goto out;
> +	}
> +	rc = remove_resource(soft);
> +	if (rc)
> +		dev_warn(&cxlr->dev,
> +			 "cannot remove soft reserved resource %pr\n", soft);
> +
> +	rc = add_soft_reserved(parent, new_start, start - new_start, flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev,
> +			 "cannot add new soft reserved resource at %pa\n",
> +			 &new_start);
> +
> +	rc = add_soft_reserved(parent, end + 1, new_end - end, flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev,
> +			 "cannot add new soft reserved resource at %pa + 1\n",
> +			 &end);
> +out:
> +	mutex_unlock(&cxlrd->range_lock);
> +}
> +
>   static void cxl_region_iomem_release(struct cxl_region *cxlr)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
> +	struct resource *parent, *res = p->res;
> +	resource_size_t start, end;
>   
>   	if (device_is_registered(&cxlr->dev))
>   		lockdep_assert_held_write(&cxl_region_rwsem);
> -	if (p->res) {
> -		/*
> -		 * Autodiscovered regions may not have been able to insert their
> -		 * resource.
> -		 */
> -		if (p->res->parent)
> -			remove_resource(p->res);
> -		kfree(p->res);
> -		p->res = NULL;
> +	if (!res)
> +		return;
> +	/*
> +	 * Autodiscovered regions may not have been able to insert their
> +	 * resource. If a Soft Reserved parent resource exists, try to
> +	 * remove that also.
> +	 */
> +	if (p->res->parent) {
> +		parent = p->res->parent;
> +		start = p->res->start;
> +		end = p->res->end;
> +		remove_resource(p->res);
> +		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
> +		    parent->desc == IORES_DESC_SOFT_RESERVED)
> +			remove_soft_reserved(cxlr, parent, start, end);
>   	}
> +
> +	kfree(p->res);
> +	p->res = NULL;
>   }
>   
>   static int free_hpa(struct cxl_region *cxlr)
