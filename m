Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66332C83F17
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Aug 2023 18:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbjH3SxQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343963AbjH3Rhu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Aug 2023 13:37:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778BEF4
        for <linux-cxl@vger.kernel.org>; Wed, 30 Aug 2023 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693417067; x=1724953067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2ORZeo/RbTYU130UJIKcCNHhwoiolicEBia0LYQir3c=;
  b=OaFzCoXlt4fqPcpHi0OOpS6WhHRYr3qlDmBJKhn87tpMxQWGb5jw5AhX
   7ZaCA6jKwfUWy16bHU+xKc5bxfvj5eYu2hJWRZWzJyyrwuVN2cS0lEk7v
   yze+Wo3pVavN3HOi48FpuZ3QAUSMqEYKXsvMY/GprDCVxrlWO+oM5+fk0
   zA4878JQAe+p2NEW2qIuGlMSwclTuJHyPq4c3/igmXtyqZGNbbjkcYPBl
   6CLzp5VY4S8iKVfvMU9TjPzJzwyuxdAf0dYOifTZh1xRnPL9eydEg6NGM
   bkdLqIK9K5+QVJ3C3hlpW6zUb/p277EYyF7CKK8jDxI8B7M4UCSEZ87bt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462084786"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="462084786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768491312"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="768491312"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 10:37:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:37:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:37:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 10:37:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 10:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0E6YkkBioEr4UWjaGKV4JCMf9W+1QyxFatdGleneUNUTwWQ+eDM7P6WdkwAnwUklT54ph6S8HcNUb+3XxCPQPsGapkdPTjgZJqM3EcmPsi+2QZrOo1+D2Fx1wbr6e3lyEpWVBcMLnaqXidHTWYo4T0LT61/lDh/gAUkMPT2j1piG1KkepG3UEKTlLfTXsQEh9mbesIQC6o04ysA0tB5qQDw6HrHClv6c85MhyTahnMId1Qgqrgczb3bpkrMlIVoBs/7foMGw7ZW2TtpATn16dZosvPJI2YBD1nmVoWig4bYhGSpBZExZ8K5JrG8+mI5QhQulWdBDMVuqTQil6LjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV/Pt8AbLupyXVAZlAVtN4tpTL5k6FAAuUrrfF7Ox2s=;
 b=Sqi1EgVxTnTEze/AHTdELtFj0S0vKIaSgB1uRCcI3NpK/PnFw8p9fba67oAVdWIoblNk+NOb/+Wl3qY3aq4bk6cBA1Kjlcx2nnrmrBIRu0hO5ta3MoLSd4fNbYS4AAqGG5CBchwy9nMVAVvfHBRk3SMguAT471vawiUk+/yXbdPC8XvCHxunK21GfdQzjOXpxgQvr4aPjZc5kLkG4eP+dIJvf6xnCOjlKTbbRXluEu5Rh/w3yQxXaQlvHv9ShByPClhXmabaBUsM9yDsHrJLfU1DtsuS6Ir0z468rJeWfVlvrqWnwfjr/kG4gv19X/F4ImIfY9sq9kVlj6z2uKbb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6326.namprd11.prod.outlook.com (2603:10b6:8:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 17:37:37 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 17:37:37 +0000
Message-ID: <a20a7541-00d5-d815-6a50-01849bea5432@intel.com>
Date:   Wed, 30 Aug 2023 10:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl: Add Support for Get Timestamp
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <deepak.ukey@samsung.com>, <sathya.m@samsung.com>,
        <d.palani@samsung.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20230829152014.15452-1-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230829152014.15452-1-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: abf02bef-edbc-42f2-ea24-08dba97fcd57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUNeqBAzg+LPLnr67MZsFbmupRUIQJLWhBJI5L4HCXwrlrNPr250fZpzh87VWztRV1ua5h5tbuRfMKbJKR1TeooMD8D1pbm/fe/9mSj29ZFJ/EuTJfjFxN6wex1cqTaalHUfFg7O1qjlOEhnDEmCIv5Bwd16W7eJdAXcsIFcQTeukUhFOAitRCg6aezALNO6fPsdEhCpswQpk0fqgYhixt9cA2Iea+Gr0DMyqdLoK5DKY+T5DY50gTXz2/RV9mDj4DyBVTiRTMJOiC9lQzK6uVG20/n3kaITNCrELasrUlJ8nFNvclNlZ0vxEgyeXnxS3CS7lLOR9H9OW0mOqdEdfUddeilolSvlzPYsrMP5rwfxIP8Fz6S/TgqdBUr+RJVcj+YMlh7D5mB2vfGVxQpr6IwMoECDYgCRvV5f2oHFg7BZf0wpQF6suTgUIcsinPzw9y3VpSiQ1F+rPK42Vq9zMKcFE3/zQ7R9+cnmlPK4lqT1rY591TfBGYtoshZfSGq/amNdNg7JprDtP2JJ9oC7+a1t21GI5EB9rTCla8BfaX3elYHnSlEeGkuvF+bYnVdg4Ceqs+61WdCvaipVwSUP3v0yt4u/3ialY1W893sBOLnsRPcr1BN5Y6nArTGx0B5sT5mo5v0pcToM/CiRY7b8Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(66946007)(82960400001)(66556008)(66476007)(316002)(6636002)(38100700002)(478600001)(2906002)(31696002)(86362001)(41300700001)(8676002)(8936002)(5660300002)(4326008)(83380400001)(44832011)(53546011)(6512007)(6666004)(6486002)(6506007)(26005)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjg5UlgwYXMyWGlsZGhra2txMlZQcjM2d1B3MUpTbXFLYkFHMVZXS0NieFh4?=
 =?utf-8?B?cVUwNlpjYjlpQ1llZ2h3aTFaM1hKUWQ3Ti9kZHVsL0VRQ2l4eWIxSXJ5ZDF5?=
 =?utf-8?B?M3hlS0p0RmZicjMvK210bDJCMnlxbURWa284MWQ4aTkzQklYeW5OSjhTNVZz?=
 =?utf-8?B?d2w2ZDlZRmNsNGVjUkFlQytKRHpWTTMwdFM4WnlmUHFIV2pGcnZTSXorSVFu?=
 =?utf-8?B?S1R1L3lBbEZPWGZSSEEvSGhPUkFmSzczeGVVL0xBVkp0eHVlWVI4Z3pKeDJr?=
 =?utf-8?B?K2lWTkJ0Nm1CYVgyOVNBS0ltK2RaU3NiT1lmSzI4ZCtyaWhFclN5aXIyMjJ2?=
 =?utf-8?B?RkZkZkI4MDZFT1J5SFRmU0dPdHZFUnJ2SFJxd2YvTHJ5aVBYQ3pLRjYzSzls?=
 =?utf-8?B?T1YzaGowaUFIRFVTaDdwLzdDUmx5amRnSnFqWE9IeDZJSzc0Qno4UmNqV3I3?=
 =?utf-8?B?eUpCQUZJc1MxMnM3a0ZPeXMyek9YdTZlTmIvNTZrbVdUTWlyeS9OdWlqZDVR?=
 =?utf-8?B?WGZRVlVKMG5UYmZFQll3UHYyZXhVMzl1czVDRm9rQ3U3c2xraTYxbnFlVWhN?=
 =?utf-8?B?akNjNnc2b3l4STdRbmFscXpFQ2xCZ0dpMlk5ako0ZnR6akg1VVV2MWY0TVgy?=
 =?utf-8?B?ZHZnMVNLQ3BlUXJ2WUZod25RalIyQ0NrTG1NcTdSYVJuSDJmNjNUYVI4eHhU?=
 =?utf-8?B?VWNIcDRJOWd0dldQYzJSMWhwVnl5ak5TTkY5NDJmMWFFMFBnMk9iQVo0d1NO?=
 =?utf-8?B?cHNXU2RlOGc0UThEYWFmeFlHSVplZ0FuVnZBT3pLbGdLUldoT1Z3TklhTVlm?=
 =?utf-8?B?M3hCUjlBTlJGSmhxcXJhVy9PY1ZPM0NCYWZtOGVzMHJJZENUd29ZV1lobkVL?=
 =?utf-8?B?WFY1Mi9FZWVYSXkycnBGZkYvR0N0YlRDSHg1dXNXd25MK0djaFJEclV0RW9y?=
 =?utf-8?B?Q0J0MU9GeGFhY2YyNmdnd0tHY3cwakhENlpNQVE5cVhqdUd4S0lNRy9KU1I5?=
 =?utf-8?B?Rkg1dU4rb0xyY1BzNHJraCtqMFNVMVM2S0ZWYzdBY2h4T0ZOSjlKVmNqbHMx?=
 =?utf-8?B?azk5dUJpZmlxbklEVjZXQzJkRUEyUk1idGxKSmF1ZHBUVnZtZEM4UlcrSUYv?=
 =?utf-8?B?OEJyYjF1K0VMcjRPbGVzSjhRaDNOeGVyR0FkVXI4YXdoeHJXMUZVc1U2eldK?=
 =?utf-8?B?V0syVTlqSVNVK1NWQVVVekpJaDVpN3c5aWJacEtCYW83RHgrb21ub0NLc0xI?=
 =?utf-8?B?THorYmFCRWUwTjBuK2hlM2FqNHdyN3p4TWpoNnhSUzhqYUdQYWplOG9BK0hR?=
 =?utf-8?B?b1hQc1JCQnc0eE5CNmJxMEVrYlBYSzdOZ1RrZGFOVmpMSHo4SDEzRFozNHdX?=
 =?utf-8?B?NDNjclVRbDQ0TVlZeGs0cGpSQzZZU2dYb0hpdmpCakJvbnRTNXpnZ0dvNWFv?=
 =?utf-8?B?UWxTNWtvbFhUZGx3L0hLVUxycFBBazhuRzVGOW9jWFFsQkFYYUZSc3J4Ty9K?=
 =?utf-8?B?WjZMMHIydkRudTZkdGdzbEc0NFZYaHY4OWZNRFRQOFVham9adkdkMkxFQnpi?=
 =?utf-8?B?M1d3TzJ0eGJma05ZcFBucGdEMWpidG9oYktuL3R5b1ZZR1BuZEVRMFRJS0tW?=
 =?utf-8?B?L3YvQmtJT0lLREttQUpZRWRaNlFENVB6RSswUFp3THNJREdKQjNLbDNhQ2Uz?=
 =?utf-8?B?TXFtSSs5YW10UURLQVpGOU56YjQ0SUl6c09KdzJWVkgyRW5rRml3R005cUVr?=
 =?utf-8?B?QnNydWI4bjcxMEM4YnFCUzFIeWVjSnNjRVlQTnVPcFV2WUFPWG91YzFWL1Nw?=
 =?utf-8?B?WXJaYVpqMDBRTHZvaUdCd0ZrU1NQbStrOTJ6WWoyaXhGRXhucXd3Rk05Lzkw?=
 =?utf-8?B?SDR3eFN2N3pKN1Z4SER6blFXQzNaZkZIU2xTZ1M5dzBOaGduancrcmt5QUtv?=
 =?utf-8?B?ajQ2QjI3bmc5dkdaOFczbU93L253eGtQSGVFM3lITkRLQm1MclFaT2FRRE4r?=
 =?utf-8?B?SmdJVU5tek5yQ2tqQi8yUUZBVUdXKzNBV1lOWlBzcjZBcmpJWStmY0hEZUNO?=
 =?utf-8?B?bDR6NGcxZ202THVJSjYwMlIrckkrZGkrd3ZLaktuYVlkMTBwYmtWRVRoQzBC?=
 =?utf-8?B?K1RBeVlSZVRuUUQ5VFdmdjJsSFdwYWZ3OTFnOC81TVpobHdvSzlYL2NVcjRk?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abf02bef-edbc-42f2-ea24-08dba97fcd57
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:37:37.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BsHdNZMVJn6DADiiw76L/Ff+tBWTsqjA074P5pM9Jo3Fm6PqB7Nz91/9VzwXJUrH3b9tYpt6rJgYCfAsn3QfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6326
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 8/29/23 08:20, Davidlohr Bueso wrote:
> Add the call to the UAPI such that userspace may corelate the
> timestamps from the device log with system wall time, if, for
> example there's any sort of inaccuracy or skew in the device.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/mbox.c      | 1 +
>   drivers/cxl/cxlmem.h         | 1 +
>   include/uapi/linux/cxl_mem.h | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..2444faac1e4c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -63,6 +63,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>   	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>   	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>   	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>   };
>   
>   /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..ec6dfcc7bb99 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -500,6 +500,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>   	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>   	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> +	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
>   	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>   	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>   	CXL_MBOX_OP_GET_LOG		= 0x0401,
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 14bc6e742148..42066f4eb890 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -46,6 +46,7 @@
>   	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>   	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>   	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
> +	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
>   	___C(MAX, "invalid / last command")
>   
>   #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
