Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AF3C001B0
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Aug 2023 23:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHIXWO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHIXWM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Aug 2023 19:22:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6CE7F
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691623330; x=1723159330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8J2tUZReCDCfFrVLfvGF1DSbT2db/C4KY3lq4U3a6Y4=;
  b=b2k1mQ1Fmf5UqlQTWBYQliAPGX9cDTdbsHARS7gN2ELjTThyT8UOSoaa
   BLWIXQdl/i18e7fNln/snVCrKnGZ38pEsl546JLqC3Z7SuVCih3x3VEYP
   6B7Qhe13/iA7ZmAoMUK5GeUgCpoj9yKyR1oUI89awXZJfBZcPLvogAO7y
   jBbZc3jeadSKk7mSKjKXSKBqpH+FvzpCpgA3xf90r/0/P1/A1/cbcR4R1
   dBE5/W04P8Zg5hw2DOR0Z04R2HbqspsV5Ea0IkjiTxpD5PeGkfecUyMVY
   OCmdyKttNzkzjV1xRMtkn6m+ySZujweArXVJX7zbD+JCnZJd7312jSkK3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370153202"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="370153202"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="855716914"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="855716914"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 16:22:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:22:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 16:22:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 16:22:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbu4lcr0ClZXV5gZsHGjJvNNg7uRmxKRE5DO3n8pX8xFt5IGU1j8DD2MF+qXnKjrThM9fUioKxzxlTCHDW6W+prz+UlKOMGJJD8/7FvnjlCGIvbLsSdqDXE7hP6xOlhkc2pIpI7QZhqFwGrIEjdjFZD0iPh6ieLFheq7IPcb6u9prGWbhrhQSZoyWuEEv/0PvizLDe89E2A9KxJte0dqQDne+nYZ+xqWE3AhASA/JopwMK4kg0v4hDzF9ruOOyUljqcdwRIBWaDDDtK9jUPcPR0rLvfNMwKuA2hcViJJ9r9SJbdPcs3kmdI0K4CFUkP3gHcCReW2bFyEG6YnZAeUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J95mqddPhlQLdtLYSpMq0qOdynkKKbjgYbrKQWPX0NY=;
 b=Jzhf4e+t/bPB+vn8kg+1tmppqiTzA2URkJE7GndU8Z2VmBpoxQAhuaZiu32h2Ytz42/UyWZDa9s+bGay+RFmnzgEKuyvlCGXFZvT/O8Q83IPDRNuKCBfaWtY/e1RkG0czNSXThyq1NMTCjudn5CN2X9JTxDXxAPDKtJOB0vFviXrIUazgyQgWxPBewEL37h75o3aI17wuT+cTcnPc662ZXctdgJyqbfPk8ZRHlUTQta0kLYCAu8/s4KTWCyKBUDRfiDEa/NGih/pKnPzdaUbiB7cV5tBHMcXRAwzZbGBA7sCxbnufdiFgZGpeu5OBXyyP4M6/pmrwMxOrVOe18cx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 23:22:07 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 23:22:07 +0000
Message-ID: <e6431435-e9cd-8595-bb3d-f0a132eae371@intel.com>
Date:   Wed, 9 Aug 2023 16:22:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 1/2] cxl/region: Try to add a region resource to a soft
 reserved parent
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
References: <cover.1691176651.git.alison.schofield@intel.com>
 <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b4d410-5d12-400d-3a2b-08db992f72b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VuF+tNULJEUt8uu77JJAIdxEXsQxPbaQsj2wJMNJkryl3t6ceCG0XPN3PNT+lilmCO2R+5aYQwaaYh3mEx1UanplYrVIFOA3vWjUNP8J6O0qgT6xG3sFUg2quz2kRrtC026n/2+EQlOOfoSXUl1cNzjHjphVh00HHFfLv+aE+RbBoFobRCEmnp5kb9G1A7tPifeQ2dgHlG+GZbgi5JZ8hBbW8hIFPgoXgV+b/5B516RSJWOaYol446GhmgKx0BSjZwmx6uvYxX6QwCo0nB0dnmUL/cBXpYKBvkjHOAgZwyifIlWtBaRZ+k34PohfB5lJ5TBgzGf/1u3r0X5VaBUGRtd8+8fH3AmfbRGKgB2RXV/Id065btfNEkYPjS9aG0YfuedCvFBIlcEkv47VETmskOU7ibpH58LEQxRDZUuYuunYRCSidlTzrrrEI4AAhBeZWWOOcayXqUGMXCKSE6Pz165DWFrlIL4xS0uiVTQStcb3zdThw2e4W8pPRiT+8skSH6+HTS7xSkYV6mOevX5PWB0ma1l+MSpZ5S5Kn/CAHLMKhK1Y9bGZGV6Mxgraz0Or678Cuw/ZYEYBNHyjTwdFAxt8FJM+7imNNRqL5Ql7tlWwmBYcRhHRCTYFBTea8K6uVWwih6JihL0A3B41hUafg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(186006)(1800799006)(83380400001)(2906002)(36756003)(5660300002)(2616005)(110136005)(6666004)(38100700002)(6486002)(66946007)(66556008)(66476007)(6512007)(4326008)(82960400001)(6636002)(316002)(31686004)(26005)(41300700001)(86362001)(44832011)(31696002)(8936002)(6506007)(8676002)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9oVmZKbGZ4ODFYWW5QN0pvMlV2alpXWmlvcFJoR3VUTmRRT1VndzltaWJD?=
 =?utf-8?B?RmtIb0huczlLQ2ZhRW5TeDIxSkpRUDVmNXc3SWlQaTZ5QUpUd3N1QWNST2xW?=
 =?utf-8?B?WFFHWm5PYzhROGZvdlVaSElLcSt6YWtVaWE4VGRhNXRTR2hRdFZCOHZwM0NO?=
 =?utf-8?B?SjZ5ZGZtVFRnUU1DL3pFN0JWRkdzbTBYYk50Mk5IaFY0d0w4MXdlbHdTS05E?=
 =?utf-8?B?TGZGM0RTbVhqeXgzeUtZR1hNRXd0ZC9rWFJxUFA1MFdXb2pYdlpTTDY0cUZD?=
 =?utf-8?B?djN3ckZWY1pOV3hXSDdwOVVTNXR5dGcvc1BacWt1U2pwMVVWSTdnblNxVnlw?=
 =?utf-8?B?OUVXUkZ1VEx4cHAvUVpYb0pLdDlxdXlHWGNmR2NJWFdiNVZJSE1IaTVVTmFp?=
 =?utf-8?B?VXd2L0JjdnlUdWJuNWwrK014VGVzQXdlSEFUMDc5UkZKTkw3bjJwOEROc3Jk?=
 =?utf-8?B?K3NDQ2NuNmRJbDhCWUY5d09paFQrNjNWVjZYTWJKcDVPVVRJQTA2YnhWZjhB?=
 =?utf-8?B?bVBRaEdLZmpZVE1VZ0hxR2FsU2FJb0x3OFNQN0wzYjdqeURpSnB2aFYxRVUy?=
 =?utf-8?B?bXRqMTlvY0ZlWVE0dWZpUlU4NExXN3RvRlpSTUVBeGNjOTZ3dHlYN21IZEZX?=
 =?utf-8?B?bHBrRXMyS0hhL3c4MU9CQWF1Zm5jcFBMdVJhNUo2dU1UeTRMby90WitGeHNw?=
 =?utf-8?B?QXNJSC9wbmxTS2pFbFpHVkNiVWFNemswTk5SWm16amlCK2VWNFg5T2tUc0Jw?=
 =?utf-8?B?cDZ6R3BsMkI3ZC9rNkFwNFg1dHNXOWcwUFNIU21VbWVUbzlWRmNGVTNTbGQz?=
 =?utf-8?B?bVRCeTlpUkJhcXlVOGVJMjZRSTh5VnV4eGMwZllPaytSMksvbUhIa0R4QTFj?=
 =?utf-8?B?aHJ3enFlWFNibFkzdHVuQlhWeER2cG5GQ2FQd1p2MUVOdGYvSnBxbHphVnJU?=
 =?utf-8?B?Qy9uWEo4Sk5YTE4zTTNzWlBPVjg1OHNLU0FJTVZYYWRnT21NSE9WWmhLd0lq?=
 =?utf-8?B?eXBKRjdPNzFCd1dUOXM0N1NKM08yckRCVGthVUVsT0RMNks4OFRWSXR0M1Ir?=
 =?utf-8?B?VTdocktwb3grMUxBQ2FpNGMvL0FHMW9wbEg0bTQ4MFJRQm8zMlBFZDlaVUZQ?=
 =?utf-8?B?SDB0MmJTemp3K0FHMkIyTmVGWWYwYjMzQ1REOGZ2ZkYrbEdBN29UcXZFb25r?=
 =?utf-8?B?K1lHR0ptQVE0VTlCOW5keGxMRm13TDJ3cG9zbUV1WWhqYlQzdDdKbHZRQ3Vi?=
 =?utf-8?B?WENmcHQvYjlZbnRQZ2pvNmlrd3hMdlBmUGhMSWxBTVZqMEI5TTl6dFR1dGwz?=
 =?utf-8?B?Ny85cERBUHl2bHpLTkw1MVNFZ2VDc0dNb2pzejRYUXQ0Q2xvYjdDR2I5d253?=
 =?utf-8?B?STBZTjc0T3hKaWZOUkp3OE1nYWs0TkxiVEZFblNoN3N5S2hUeG9mbmhFNmg4?=
 =?utf-8?B?L2h1dXU4bnEza2tIMjM5NFpCZUxmdjdDeFdDOW11a0hzWEtrMmpveXZncmFZ?=
 =?utf-8?B?MnF0cGRoMWp1MzZNcjN2QndYTW0xRGVmaXhqQll5NlUyNmJLcVVOMVNWM0xp?=
 =?utf-8?B?UGlPUnpIeFNxczRkWmtuSW5ITllNdjZqNzg0V2x0MHpzbVFGL0M5aTA0VTBt?=
 =?utf-8?B?SUxRMVZLZWdYOWhFWWpwS3F1ekcwTFg1MzJ3ZTRrR1RCK29IRFRSQVBJUFVy?=
 =?utf-8?B?N1dPR2d5amZyb3NtYlZpdWl1WmNIZEFlMU0ybXB4Wit5bUFJN2xHUDVGcTI1?=
 =?utf-8?B?VGlrYnVucEFpbm1aWnVENlZvV0Z6dGdEcTNCR1Q5UC9EUEhGdFl4K21GZ3lD?=
 =?utf-8?B?NUZIOHhTSWtLaUlBNXRXY2lYZS8xQW1wU1N5WXA5bFhkcmpDZWY5VnozZS9W?=
 =?utf-8?B?WDRpaE1TNlZ1elRzZ0VoMC9sU3RKakM2RnAxaGlXRmpodFlzeldHQzNURzJE?=
 =?utf-8?B?WXVOSTFIRUpjdFlWZTFESHI5NDF1aXYzZnlwV2trOHhNMmFkaGxYZ1k3Ylgr?=
 =?utf-8?B?d1JZQ1lqY1NGMjh2VWRHeHhETDdBWEcyY2VTZXJrTlZiRFdZa282UytyMy9P?=
 =?utf-8?B?OC9nblY4dGlwWVVrQ0NkUW5EYUE2eEl3Sm01d2ZpSkt1a1crT1pNQUNWRG1E?=
 =?utf-8?Q?VHyIA5BiUo58t9qwDon2KY557?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b4d410-5d12-400d-3a2b-08db992f72b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 23:22:07.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW5K8kh0E1MAbAtF+d5AXfB7VvpjSY0comYjqRUxCMLTefAUiaRTidX4uGi3U3mNlTUND3hydBZu1P3h+7fK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/4/23 12:31, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> During region autodiscovery, the region driver always inserts the
> region resource as a child of the root decoder, a CXL WINDOW. It
> has the effect of making a soft reserved resource, with an exactly
> matching address range, a child of the region resource.
> 
> It looks like this in /proc/iomem:
> 
> 2080000000-29dbfffffff : CXL Window 0
>    2080000000-247fffffff : region0
>      2080000000-247fffffff : Soft Reserved
> 
> Search for soft reserved resources that include the region resource,
> and add the new region resource as a child of that found resource.

Don't think the comma is needed here.

> If a soft reserved resource is not found, insert to the root decoder
> as usual.
> 
> With this change, it looks like this:
> 
> 2080000000-29dbfffffff : CXL Window 0
>    2080000000-247fffffff : Soft Reserved
>      2080000000-247fffffff : region0
> 
> This odd parenting only occurs when the resources are an exact match.
> When the region resource only uses part of a soft reserved resource,
> the parenting appears more logical like this:
> 
> 2080000000-29dbfffffff : CXL Window 0
>    2080000000-287fffffff : Soft Reserved
>      2080000000-247fffffff : region0
> 
> Aside from the more logical appearance, this change is in preparation
> for further cleanup in region teardown. A follow-on patch intends to
> find and free soft reserved resources upon region teardown.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..36c0c0dd5697 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2709,6 +2709,28 @@ static int match_region_by_range(struct device *dev, void *data)
>   	return rc;
>   }
>   
> +static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
> +{
> +	struct resource *parent, *new, *res = arg;
> +	bool found = false;
> +
> +	parent = soft_res->parent;
> +	if (!parent)
> +		return 0;
> +
> +	/* Caller provides a copy of soft_res. Find the actual resource. */
> +	for (new = parent->child; new; new = new->sibling) {
> +		if (resource_contains(new, soft_res)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (found)
> +		return insert_resource(new, res) == 0;
> +
> +	return 0;
> +}
> +
>   /* Establish an empty region covering the given HPA range */
>   static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   					   struct cxl_endpoint_decoder *cxled)
> @@ -2719,7 +2741,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   	struct cxl_region_params *p;
>   	struct cxl_region *cxlr;
>   	struct resource *res;
> -	int rc;
> +	int rc = 0;
>   
>   	do {
>   		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -2755,7 +2777,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>   				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> +
> +	/* Try inserting to a Soft Reserved parent, fallback to root decoder */
> +	if (walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0,
> +				res->start, res->end, res,
> +				insert_resource_soft_reserved) != 1)
> +		rc = insert_resource(cxlrd->res, res);
> +
>   	if (rc) {
>   		/*
>   		 * Platform-firmware may not have split resources like "System
