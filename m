Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836BEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFMXaT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFMXaS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 19:30:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6758D1713
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686699015; x=1718235015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JDDs+2DtjNFfNFaV3WOzL4LFoRWSe+oNwkmx3ahlaMs=;
  b=iqzMD2UrvkueD5QfKCOMw/gzcEUXJjsB4XpYDGt8kWDiKnMkgtOQPegh
   r+q84vnIzsfoZuOnrU8A3exGKuzGI0lFBZ9e6woYmvTs/W+OfZqRmh8I0
   COoIPotL1CvNTInjRqzGgPwq5KetHskB0oCDHMhzsHOFWwNcxzmkn1i7a
   pv9aCvaayoZ+uDR43HLegZB9HVJEJO8YEtArERtipClhJ40nx6/GAibRy
   NFJ4kskRTFK5yh42LTLkwbfWsvOzoR399ngChpw3lpwdLeHdr3lwXuJ2g
   j8+vLQLrv38YT6aCskC65q33mVpW3tNDyajEyBeqonjgLKH83vMTSsBqM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360954945"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="360954945"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="781882301"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="781882301"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 16:30:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:30:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 16:30:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 16:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uv59hrbIWAoSWzYNQD21pF20s4whiRVYuKQzgMbrSsIxHoFPN43Pq1z3J0O419EraZ4hn2XMNdPNGfwSKHXm9yDhXqNQwxGBzC8yBMspfRLGxI3OSWcCzCBtrOxguE77TJJIUPws2Do49cB7aJrfFP8kt0lKkhxp3SA2zp72o1r3JxqmOiNbG7SZwaMlbZrEgkSKZoFXtLrG1/1H/tmJG4irb2QDApeIVtBQAtJDkjVbbpSWs/ORbp7QyiJ/DOCzqT98kD7iCRdDBGpI5dJivMk8VdTszsuMYG5cK9SYjfPjit5lSpbZUmIK9xgBVIe2K71tL3ZVb0Et+DrkFx67Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF5eHeFYolNFj3GhKpcfACN71BtudGSPaeSqOAe2bP4=;
 b=AjdTQSiTtJe6khaI6CvcdsvNsHTQpL/3fUDyAzZYkkiNK/9rqhEuM71fnPtq1ov9BWut/1e9y6JUeTErLtt2vakCjoN4oTP3FzzpykYjvcAe3/sbg7wM49GvbBAsYDgMFkF9nJZmXAoBCcApdKIWFGQi/s8irjnpedx275klJFJtBrHlS7QvH9lxawPX9E6XFBkRNSnJEGOaFfXKW1iikkgECUvSPZIUdJQZWsLq3FmkE4Ilz+dwj7EnB2++CakoO0nLx2AS5AOavTQ7pzLPDZL9kW0452Jh8jmzZawH1o1iscTRltBvt+vI5PJUevFpr3MXRZ/mGKX9bWwoHmQWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 23:30:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 23:30:09 +0000
Message-ID: <eb7f1c62-432e-00fe-d530-7f92265c61d5@intel.com>
Date:   Tue, 13 Jun 2023 16:30:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 12/19] cxl/region: Factor out interleave ways setup
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592156445.1948938.13669058823244900070.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592156445.1948938.13669058823244900070.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::40) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adf9aa4-86b7-4d59-fe0e-08db6c662072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IO+0R1CsvJL3Uccs0XYOCSuZk3RGG2QCydoMAMsoTLQoLeVh0e2hoy2wA4dHuL32P4EfAdE2oJzCKCLfpRT80qqGzcgyIP1VHmKlCme4U5eKkjlpN6VUJIQZZ7gGnTWHR1ZqyPc8MTTQiH8ghQFSqooiW3Mw//gTAVS66c5g4X7nnYn9AnVRLpa99YK2FZjUUVsexxSSqDHHU4xATchzKgmxNFenLVYEwF8PR6TjPgan1joqPyQO2Qu740AJfyLK8iYoFxvaFxGmBZOSA8HrJwypcFbcwb9XW4hV0+Sz4d69QA//4eVlPQs4uuQGrqPWtGpgkeuIvzZXf/8QRWpJ9GGupHsUr+wV1E0EBcNeMuqEPQ+BzGtSHw7AY72HjQqasFudDGHbdgXR6vSyMXdfczDwqO/Rbs5nIDS4hKwCBRNdrN/i+FZwS+pL+bSfHpEDhWEWNyAekrKLUHwZyso501J+YR8MqfOYP5hQU1lP9q7KjAfN2nXVdQIA8UCFvTXYAjKDSKDELiLzv5ylt28zModwgv7v2hteBAKUCVBNUshqW/9pIK/CIFIfpWIiv6fKas3Mqu6JMiRhl7WA4yGGC3484wXhVLdJI2eWCURrQ8vRz4rDIhOUii0eg9NfDv7FGRVmMwpUh+id9fASKkGcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(31686004)(83380400001)(82960400001)(41300700001)(4326008)(66476007)(66946007)(316002)(66556008)(36756003)(38100700002)(6512007)(53546011)(6506007)(26005)(6666004)(107886003)(478600001)(2906002)(86362001)(6486002)(44832011)(5660300002)(31696002)(8676002)(8936002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pSbkdnMHMvTXJGUjYrOERtbGY2UmoxVTJxaU81bDlrcVAzM2c5VVV6S2VI?=
 =?utf-8?B?UFJWdzM0WTF3SG5qbGswYy9ONzR2RXhZVUpRR3U5aVVzZ1gxVVZldXI2Vmkz?=
 =?utf-8?B?NUZQbUh5Rm5iTURlTGlkQ2hYV3ZYUFZmdlhlM3l4a05CYXl6ako3ZmFxSFQ2?=
 =?utf-8?B?RGJsMTZkQWs3cHc3TDBaVHIxMk1pS2xRRENGazFWUU9VSmdDUHBud1U1TkV4?=
 =?utf-8?B?UHYxb3MrVWpDZVMrbUxTZ09HQmhRb25WYVVRSWY2cHU2OWZUZVI5Zk1CNGlU?=
 =?utf-8?B?YVBPdzFwc0NYZEorczllQUNNU0JabEhvdTgrbjg4dTFvQzBxN2dpTmRPdDNZ?=
 =?utf-8?B?eDg0VHJ6OTJ0cVdtam5ncGQ0R2FMOUlPR0NTd3U2NUduK0RjZzZMSS9GVjl4?=
 =?utf-8?B?V0RmRStGazB1a2JPZGJvdlorZU1QOVVBellUVmNIeVZtSHlSTUZGM3kwU2xh?=
 =?utf-8?B?bWl6d3k2YWswNjB1NEo0OXk1RkdHMXN1SVM0Rm5Uc1dNNGh1ZUxLMFZlTWZN?=
 =?utf-8?B?VDQxS2pab2hqMEphZnRJZDY0QUxHQUdBZ0FvM1ZQd3Vnd29vYWJmSk0yOGZ4?=
 =?utf-8?B?TWRQZk9RSGhPWk1wSjY3QUh2aUNGK2VHeWtCeU1pcXkwakdQbXBEaGpuQ2F6?=
 =?utf-8?B?aWVTSldMb2tDTjJHOEtTamtQZjJlNGVDMy9nOVVRbGJSV05yNGwzbmIrVWtl?=
 =?utf-8?B?Z2pWTGhXNHRLQnAwaEtKWkdMUnNqMmJlS3p4eUZjVGc1Z2VKMlVyVkdCNThj?=
 =?utf-8?B?VnliV1NzckZ2NDY1eU1IaVFBZU9WRVVObFI3TnYwUW1RTWVDQmRaUnNHeFV4?=
 =?utf-8?B?RXROR1ZMT2xFSHBUUFptcVNnbHFnUEpSWTNVTHRNQTBJZS9nY1JoVUJLcTR6?=
 =?utf-8?B?bUZRREtSN2JDOVB6bjR6UXg2OXdVM3dPK3FSQjFsR0RtWG9lU3Yxei9Ucnc2?=
 =?utf-8?B?VXZhNjgzSDBBcjI2eXJ5T1dTR3d4bFI5N0FMRWRzbFhsOTRWRDRYbjlpVWlx?=
 =?utf-8?B?MVlOVlNYNWZBb2g1anZQQjFtYTJpMi95Ykd1eVpFdGlsY2tBRS83WUtGZ3Zs?=
 =?utf-8?B?VDlNWlhCWUEyUndUQ3hXTi9MVUZZc2hYM3B5SUkxLzBBMGZEVnVTSndGQ0lY?=
 =?utf-8?B?dEZMNDl0WXlCdjdzN2J0cVlVM2NSOEpRYTJIR280SlNRWDhCSTVLWENoa3hj?=
 =?utf-8?B?UDM5S1JycjdyM0NIMkxJUUYvM25STnBWWTlzWVcrTW9ha0QxaTh5SEpSWDBn?=
 =?utf-8?B?TzBrZGgybkhwcFl1MTJvRGJjMk0zUHVKY2hSbXZyWEU1K2E1Ym5mS0hwQUlG?=
 =?utf-8?B?Nk9QOVJmTVZhSUU5SnRUUFp3cUpPeTRKelZiMnQ2NXAxbStpRTRzMllVQjM4?=
 =?utf-8?B?MXo4eEQxOWt6OHRmUGx6dlc5K0s4RU9sK01TK3pmaGdSQ0FQVllxMXdsUXVR?=
 =?utf-8?B?dzZ3Y1JUaXB3VTExVVQyZnE5b2d4ZUNxV1BPUWZwd3ZqNitVeFM4a2NQZlRW?=
 =?utf-8?B?ek5ES1dydVAwYTJZWUxCZW0vejM4c0Q1b1I3dUNrWjBEcWhXS1RFZ1hxdUYy?=
 =?utf-8?B?U0ZZdUsveElkMkRzYXFhQnJtREhRaGZlTG1IMEVmNTBhTkw1eXQzUmovWDhk?=
 =?utf-8?B?MlpmVFBkVEJhVy9EVE80VnZBUGJxNlp2M25WZVZhZFRhUGlnZ1JsSTJMRTYw?=
 =?utf-8?B?REtXb1ZWQnc2OWllTS9lQnJiN3NBbDFoMnJnZG1SZzBpcWdBbUhrWWU4dXBZ?=
 =?utf-8?B?ZHB5UFdadzMrRzE5azRYaUYrK1VUSHRRSndIdHlZS1B3R3Y3MFRybTAvYTB5?=
 =?utf-8?B?UVV3RlFWQVR1RUdSZERsQzUyUElIV3IzWkQ3c2czcnZMVnhzL3k2QmRjVjl2?=
 =?utf-8?B?Q3JlVy8wL1o3NXFxRGllNUk0UjdnaXJ0VUJLcmtnenJhOGxtVHJicE5LUE0w?=
 =?utf-8?B?TCtSbXNHQ3hLWWFoVEY4dkg0QVFMMUV4NGRzdFBrcmZ5OVEzaG16bnZXSUxp?=
 =?utf-8?B?SmhFQ1lISWtROVU2MnU4ZUZ1Y2ZhOUI2b1drU3hhVVZQWW5ZanFUQkRCdVda?=
 =?utf-8?B?aUhQNnhJRW5ESjkyMWNvTkRCTWhyWXlQOTZERmZ1RHplZ2RIZmFFQzFXUzkz?=
 =?utf-8?Q?BN2mtHqzRf2ZMOiI0JSmLy3d7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adf9aa4-86b7-4d59-fe0e-08db6c662072
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:30:09.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePfxFm1NO49yp5WmgCWRqlhxs8Z9ldxUOD/boF+4M29eSALGE0pPfela1QxFHU4r49gGHxsWoHoRgsl2tY54aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:32, Dan Williams wrote:
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave_ways.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/region.c |   46 ++++++++++++++++++++++++++-------------------
>   1 file changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bd3c3d4b2683..821c2d90154f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -338,22 +338,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>   
>   static const struct attribute_group *get_cxl_region_target_group(void);
>   
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>   {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>   	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>   	u8 iw;
>   
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>   	rc = ways_to_eiw(val, &iw);
>   	if (rc)
>   		return rc;
> @@ -368,21 +360,37 @@ static ssize_t interleave_ways_store(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	rc = down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
>   
>   	save = p->interleave_ways;
>   	p->interleave_ways = val;
>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>   	if (rc)
>   		p->interleave_ways = save;
> -out:
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
>   	up_write(&cxl_region_rwsem);
> +
>   	if (rc)
>   		return rc;
>   	return len;
>
