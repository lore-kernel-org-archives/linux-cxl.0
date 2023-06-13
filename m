Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4811CEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjFMX3f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFMX3e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 19:29:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673A1713
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686698973; x=1718234973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MqHGniXuWJPL39LX8DuBHnhN6oF59c7qV0q/fPs3lSs=;
  b=l0HqNAjyErTaUEZbfz5CjpSVQxYRWlYaRfewCqNW8U9tbScvf7Hv+UIk
   9VzD4refekeTSXHRAcGPsmuJYReKa0xLjWUQbKoAp4Y+LksltYtcnWz9/
   /+DL3aa4mr/SS63ux9W90K2OOxEpet2No8aedq3hsMo44YJOmClSIx5rn
   3T1P/wQR+9vLs/+oLwxoAZeUWgbwJi6dc5/NgSySFJ9UaLZax44OzaKUi
   SwFzWIyPmOwjTvbDNRMhrej5JsUXER1AxQCGnlq1KLM5s8FtoD1A4ZmqS
   w1QuJM2QM1w4kCOnxw08XPlLFGjoaBlKHoh8ILwkW6sJn/0igBXrdo8N2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355972568"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="355972568"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711826691"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711826691"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 16:29:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:29:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:29:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 16:29:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 16:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4c/OKqWIPmLWCGvmS5DUbryV90i0pnBpkfdY976MXo/Ulx3ZyjYUGNNDwTiKt2E297WjP7+D1zPfKHHBuDiS/+TX1nEjvIFrpBlmArfXYGHQDq0S0p8kHg3aZ0gUHRKlpWF03muM1uaRfNwHVgrBGBtApTwIdtqkxqzVW6gLSR4cvdvn39zT5E/7LwOBJuygl87a2az3DJ3GtS3nZNw+adh7XgT453HyQ7cBS4tTVPWjZ4YWVh/Qh1a1jLAPCJMNDdiJS1ljVOa3A+0GGHVb/9UUxHRB78HqnJYDYG4lC+rGfHU3mc6zPBEHBXXFfrJ+TAreZE8V+oJTEzhLtzUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/ozAWrYC7aZImxECoLEM6hXRDNFNHJjN7dUo8NDxfE=;
 b=N1vATAR8bOMhr9hznDliaivADcu3q/nkuzyUD3RzAWHMXE7WLTUBhgsetoico075zG5T7JKohLYwteGCHcx7R2pgZyIKyPqWzWf66Y4/8RThexINxjqyRphQTUtHOA5XASita4Nmv0qs6mOe55+E8zwQLk9sceZHKSt8U/nM/FQqVTtN5kLSY562mqiUTMte65Ty7mqHUX/S+oHNj8ntrfQ5bqiigDqdF92Ga4r2r2ES90xS+B6QD0AbBD3x8Wrv4Sgcr5PTfoApEunj/TICReFkmeFKSXgCjg7oW95u6PmMmrn16pVdp/Q4Nqoe5isTQ0ZZ6BXOz0Em/hOFGrwFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 23:29:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 23:29:14 +0000
Message-ID: <4757d28f-959d-3ac3-6d61-44087cb3b017@intel.com>
Date:   Tue, 13 Jun 2023 16:29:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 11/19] cxl/region: Factor out construct_region_{begin,
 end} and drop_region() for reuse
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592155858.1948938.18413203801464814822.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592155858.1948938.18413203801464814822.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: de7c616b-8628-443e-9217-08db6c65ff9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuxwxPs6f8hDE53YgIHhUNhlG3efOUl6mLPN9lLwJXhZz/nNm09Sox+8G3gdNwBbg4VULjwOXvez67UWhWPLCBRlprklAjtYD+mIuRxeoCRHKhiETCDOIAvaLcEXCwf9CSZ7M0M1y2BbVeU8gRxvzfY548az9wKPX/M9VE4bw5sj/pmxMOdpVNatISU4nn5sMadtVoI6YGvPa1PlrSgPBL2bNgPYxUU4nx5jgY9E0L08EjlIVeNheKereJcDrjr2BsPN29GmKzBALETFcKmCHbzKEDu6y/W7pbg8X3WywoVY2SPNWRsYJnhYkZlT2XLF1Sv0euvmkUEY0kuGB/yzCYfvqjxm3TAvnp8otq5qI6UQb1+WwrgSNh3fNZpO5s1VfvsUeCCvnBOXGgvtX59oBWIYnEfoLgkP4dpQLymXLDkpq58R77yOG/lzOj3g/bAJVhkqGp3/c97cWnZRdGFCQD3tIP9GzNUu4kSAqgrS76zCvJuPZiNB31hu6vnxi32vMvO+6YQiKCOZJw0qI25dSSL4FWITg3BsPUCI8EECn7MAkdQXDWPEQQkt6pP11ymQp/tMB3Cs/W4+Mh3UVU+D5/6BdgbMTGrnLG1/Xm+Ik4KY3LCItMPdGmocOacMsGIKLglBP1c0Zcha+ST6YYy9oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(31686004)(83380400001)(82960400001)(41300700001)(4326008)(66476007)(66946007)(316002)(66556008)(36756003)(38100700002)(6512007)(53546011)(6506007)(26005)(6666004)(107886003)(478600001)(2906002)(86362001)(6486002)(44832011)(5660300002)(31696002)(8676002)(8936002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW0wRDRHdk0rWGNKbjV2Z0dwN3o2UFpFZWNLTGN5bUpiZ2JFa2xYb0dDZEhR?=
 =?utf-8?B?dUxWbk1aMWtZQ1NhS3A3SnpPSXlEOVkwS1BWcVRxYjcxTVJ6VnlneEp0b3J2?=
 =?utf-8?B?TjJIc1pOVUIrd2pqU0IwVm1kS2NMamJtZDdhaVc5ckg0d2YwSTVUdFUxdjBX?=
 =?utf-8?B?RGNPbWV5QzRKQS9sUk93bllQTjNIWXhhZXYxWGw2Y3BqNmhWWklHRnREd0U2?=
 =?utf-8?B?MUF5bmJuSTAvSzE5aE5tVU1XcnNRR0YyVnhSUm03SHFvUDJGT2IyTHBJdlE4?=
 =?utf-8?B?eGU3T0ZFUDRHd2VDYVRZZysrVWswVCttcTlhYVpaU0F6MWdwazdwaUZIV2sx?=
 =?utf-8?B?S3NjZ3VjRnd5cGZaSVRsQ3VKVmd4YSttZ1BHRmZMSys3OUpoaVNzTHM5VXg2?=
 =?utf-8?B?SlFxaU8xTW9POU5LWnlDTnVENUY1ejdDMndCalZYWmRESXk2VSt1TXJ3bjRB?=
 =?utf-8?B?d3JxNGlUS1Q0cm8zZ3ZBT0x3RGQ4enIvSTFyNEExcDRCV253UmRteWQrNzdn?=
 =?utf-8?B?TzRKaXJFTXUyY0xIcTBFWWZiS243c1kyK0Fsb2plUWp1MEpjK0FkTk0zZFpu?=
 =?utf-8?B?VmFuL2tFM2RTZlpMMXlNQlhYK3l3dm5EVUl4U0xVYzg1K1lkbUlvaUNaZXBr?=
 =?utf-8?B?Nk1nbElQeTVGcmpLNm9mMW8yQTRrQTBzTkk4WjdLb0NpMjRkZ21LOExURDY5?=
 =?utf-8?B?QndHYXI5TzF2SVhoa0dIRzVnV3c1T2V5MUprV3o5YUtsT0Qyc0lLSlhLd3lN?=
 =?utf-8?B?eXZJWFgzY2lkY2NVdVVHL2c2T2c4a1huYjJoWHhDbXp3c1dGNWRlRkE2WTZL?=
 =?utf-8?B?Z0ZHek4zWU1iQWtTNWhzVUhKU3dMU3BGRTR1SU43dTZxMVpkaDQ1cHJ1N2oz?=
 =?utf-8?B?VzhPRmlCaW1tc1JFaS9iRk1Wa25xa2tmck9GSWtlSlZ5dFhYRkxad005THR5?=
 =?utf-8?B?eUtKaEUybHVJOVJqcjA5a3djUUFQaXRFUXF4RXMyT3pzaVc5L2k0OFpPYVp0?=
 =?utf-8?B?bEVzQURDa2E2d3E0NVI1Q1JtK0ZONStVZjNFU2Y2d3VKaUZYYWU4ekZsdmk0?=
 =?utf-8?B?TUpxaXZNMFROSnpmLzk2TzlMU1U0L0hRdDFod3RWWUVtSUxqdzM4akZYdVYz?=
 =?utf-8?B?Z1JTQ1pwNTM1UVFSV0lROWxwa2dTMEdqT2hxNjZjandicHNxcFpaS3k0K0F4?=
 =?utf-8?B?WlN1dUJ6Wll6ZWtGcUwwT2JTMCtNZW1lZmJtd3RmRGNQZUtNeDJESlNTbTN0?=
 =?utf-8?B?UHVMNC9laHRjWEpBcG13c2IwWER2dXpMWVExS2JzRFlxZXJWMnB2R25zSXVJ?=
 =?utf-8?B?dmU0Nk9XbE9ZZDdmM3Rjdk16MURydEpMKzBNN2VEZ0Q0L28rdVZ6bXRXQTd2?=
 =?utf-8?B?RmZzUkNYNmFndEJhUjFoODV0dWFtY3p6T0R5UDRISEhLWUJqZ2hBaVhtQStO?=
 =?utf-8?B?Tk03STFUcVRhYVhPZ3lqc3o1SE5FRXh6LzQ4S3NBc2pYdHNEbUJ4dGNLNEc5?=
 =?utf-8?B?MkFmWWd0SytjVDlQRnU5ZmdXUVQ2VExIY1BuVDRJUHJ3aS9kVVdjSllqRElV?=
 =?utf-8?B?ckFFbzJncmJTMlBpakxsdXJZc3NLZTZEUmxxZk9MUFN4RmJvUGJKSDRneWRG?=
 =?utf-8?B?WEt4b0NBTWFHSlNKSTd4WHF0Z2kyMmxqY25DVjYrZXd1QTJpazBYSndFWjRj?=
 =?utf-8?B?bzZNTk9pR2tUL2NvbDdMelk4STRwVTBLNUVBaEVqQ093dk4yRGxadFZVUk0y?=
 =?utf-8?B?dHJzMDVRQ2dtaG9TUHRMalNRbHJDYTdTRnBvTTJHTHdoSTBzYThNTEx3K1Vm?=
 =?utf-8?B?TXI4SmtsWWdkRldqSmlJVVVtQXhycXRmRUJrSHJmQkM5enpYOVZWQ21LUnZm?=
 =?utf-8?B?QXZpNlFXTzZ3Q2l1ZTNwNnRMTG04eFBkaWZQRXovUktLQ0N2TWlTYTZGODVR?=
 =?utf-8?B?Vy9neWJlenJqSEczaDJTcGZRZFEvNzRxdVBOaVRreEgvY1AvM0gwbzh1aFB6?=
 =?utf-8?B?WENOK0IxODRPQXBaWE9PejA4UjFLL0hxUytGY3ZqbWl1eWNoOVBwUUFaWnVa?=
 =?utf-8?B?azRERDF2dEd1WE1jaWRheEwrQ3I1V2t2Ymdjb09tV3hPcHBPUExpRWVENFdo?=
 =?utf-8?Q?JTnK8R1rhJ+2QoqY4mQByKdkI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de7c616b-8628-443e-9217-08db6c65ff9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:29:14.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJCoI4v/XEeWXAisqqHcVgjhLb9o0BhGbkODvOqX/1sT5Wgk9pYQkm7hhhj3jbhuqLkBIZb+ium9qG+RevCZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:32, Dan Williams wrote:
> In preparation for constructing regions from newly allocated HPA, factor
> out some helpers that can be shared with the existing kernel-internal
> region construction from BIOS pre-allocated regions. Handle acquiring a
> new region object under the region rwsem, and optionally tearing it down
> if the region assembly process fails.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/region.c |   73 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c7170d92f47f..bd3c3d4b2683 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2191,19 +2191,25 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>   	return to_cxl_region(region_dev);
>   }
>   
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport, unregister_region, cxlr);
> +}
> +
>   static ssize_t delete_region_store(struct device *dev,
>   				   struct device_attribute *attr,
>   				   const char *buf, size_t len)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_port *port = to_cxl_port(dev->parent);
>   	struct cxl_region *cxlr;
>   
>   	cxlr = cxl_find_region_by_name(cxlrd, buf);
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
> -
> -	devm_release_action(port->uport, unregister_region, cxlr);
> +	drop_region(cxlr);
>   	put_device(&cxlr->dev);
>   
>   	return len;
> @@ -2664,17 +2670,19 @@ static int match_region_by_range(struct device *dev, void *data)
>   	return rc;
>   }
>   
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static void construct_region_end(void)
> +{
> +	up_write(&cxl_region_rwsem);
> +}
> +
> +static struct cxl_region *
> +construct_region_begin(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>   	struct cxl_region_params *p;
>   	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err = 0;
>   
>   	do {
>   		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -2693,19 +2701,41 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   	p = &cxlr->params;
>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>   		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>   			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
> +	}
> +
> +	if (err) {
> +		construct_region_end();
> +		drop_region(cxlr);
> +		return ERR_PTR(err);
>   	}
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
>   
>   	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>   
>   	res = kmalloc(sizeof(*res), GFP_KERNEL);
>   	if (!res) {
>   		rc = -ENOMEM;
> -		goto err;
> +		goto out;
>   	}
>   
>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> @@ -2722,6 +2752,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   			 __func__, dev_name(&cxlr->dev));
>   	}
>   
> +	p = &cxlr->params;
>   	p->res = res;
>   	p->interleave_ways = cxled->cxld.interleave_ways;
>   	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -2729,7 +2760,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>   	if (rc)
> -		goto err;
> +		goto out;
>   
>   	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>   		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> @@ -2738,14 +2769,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	/* ...to match put_device() in cxl_add_to_region() */
>   	get_device(&cxlr->dev);
> -	up_write(&cxl_region_rwsem);
>   
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
>   	return cxlr;
> -
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport, unregister_region, cxlr);
> -	return ERR_PTR(rc);
>   }
>   
>   int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>
