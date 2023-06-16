Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEAEB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 15:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjFPP6x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjFPP6w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 11:58:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3F2D5D
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686931131; x=1718467131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DU6KA9saL3xJfuhCsJS+QPbU2PRPOvbZLtfN3mBgEU8=;
  b=D7b33QuWBRww1IQmYEbE5DMVlrph0iF0z4yoYjecBNLx9fQtR2T5Hzd7
   fzQE8JQb7fQVe80MOQkImm2Im87Cr78mEO8RvKMdex0jRgPOfYsB5efkY
   QRyWb/lhTTFBZP24kKPYs1ngW/iTDUCcF2gxV8B0xWTUgIgUYQUWUQY/c
   5oOICOrpKxb92Xl96pNgeg3SNylF3Us3UXSxE9DbebApXHEuHXnXEhauA
   umB6qtBOZDXg71pmjetYvY9AYJUP18LZFouN+NVqtipAF+pqdzQOhJL3a
   Tm5+j4fxqOIJPFPykDipGHA3jbUAn98h7yJuXa8ry6yTQLVffs6LJ9Ool
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="422897808"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="422897808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1043135360"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="1043135360"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2023 08:58:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 08:58:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 08:58:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 08:58:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 08:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFBZEyAOE2Hb6RNdVi8pdqoT8XV5cQWC2b/RhB20KNCuBRDayGk8J1S24hcZQkcDG8QdaH7gozlGA+7llE926mrIYJMIdU0OXwwNKtHAzqL2zQmYQDIc8ufSbGMk0zS9D5ElRo8FcLeSyLhUvTacVajWkiGNc4OK9F58wT4TzeDzGCC0wqpEc0Y5yurFPcckrlDjCSkKk8D6UfiB3/R7oZrRkspWaky4yArB00scRd/cD+iVXk4SAJL39vXQDdPpl7xmYxmyXsTW5euvFZBz0XsmqxPSZP21jF16w/plZzzD6e0urBJORIYDU18LJFsO4S56C0TkrsGyr7xM3YLUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41dHXcOTmAAkTxhbBUApYvyKTLebta51m2fzfPIPDJ4=;
 b=NO64cc41AGWGGqRqwvggfdpt5pRC7rVES/sLkXJiiTB6nq2Jg4I4jQ9z9/P6KlESjwdHVhc84nImUCSVnf3ILFmPokCT2xc1Pl1hUXw7mR/tQ04T8pd9jY7+jAsRcGGsNm5TZhDDMF4OvKaMWeDHc3LRugeVAM2jVeTMF6XmSZrDjNwH5EMGfxdf+MAzSN4rQo/BiLQp8g1+vTl8Rq9qJD94PcQIdyetjuM7f1mkLcMMZ7+8Q3tadw0S/rF9L8q73nmX4FHa5LMMZGqu/DMyk3C8esu6A2BAoeUsMG9bHT8RjcRx5kPZw0zfVf5sOAO5nvQjxa/5UTXK2n4PU/h5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 15:58:46 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 15:58:45 +0000
Message-ID: <a6a0aad8-febe-d466-ed1c-105b8bf4cacd@intel.com>
Date:   Fri, 16 Jun 2023 08:58:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 3/5] cxl/mem : Expose dynamic capacity configuration to
 userspace
To:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
 <ZIpeCsiJgLcD7eju@aschofie-mobl2>
 <648bcd316f4eb_1c7ab4294c9@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <648bcd316f4eb_1c7ab4294c9@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2babbb68-5b0d-4d19-ef7e-08db6e8290b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rQ9Y67AcCnokPLoD57605bAVUdwz20Psi2C5HPuQS0UBrNisdRXP25nNPaPCROz/4aWyBhV/tZ+c/WlTSGIvEcQOHUgNHeAm+Ai4fPu/GRmqYN7D7718mUx51eCLcDregO4PEZE548j9ts2vivzkelW98WY4zdggAXrt22WVA4oP/k1CuPw1QJ8HO9IluF+tRN9gyLGzlLgUZfspyWMwZZutsoVOJ0DLLHQlzxm/+f0Fu3tbMhgm3X9mz1t4adJQ0lVl+iLrDhZj8sug/9ArFctVSQp3vCIYiGBmI9Kz9mI2Mny6fzdlnXxPMHjVhNfLVD1C9HpGicBjvdYb3xJqrht7nfICq0iYHKuFpfEenhtf9dKC+UfwYkKYZrJZplWrYyAF28ctKqC28BASJrplQaMOD3oyZ3FUKss3ygb1HpiFHmo+h47yI1pjxGH9PekRHR+fvcXqqkeVBtHyLTJmgDwRcIKphsvAWsm2DvhsA2eUGHdU/q1kEuLPy2p0MOnWzfJ26pAIunh6Q4I8wxOrWKE9EA+LuXHK5B1rvnKEV8uQfr6vSCAszkN0ZVWLlXbkmqbDnJVqZrwSFTEav81i8HrCN4DTUN+gcTUQwQse7pGtgyqAMid3LuQCADq/CrVpGk2/UT7ndAT1FtfPcYSTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(31686004)(86362001)(31696002)(82960400001)(38100700002)(5660300002)(316002)(8936002)(44832011)(41300700001)(8676002)(66476007)(66556008)(4326008)(66946007)(6636002)(54906003)(2616005)(110136005)(53546011)(186003)(6512007)(6506007)(478600001)(36756003)(26005)(2906002)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEROZEUzRklDUEFuMkZFN3BoOHBuZEkvazdSTmZlRXdRYUY3UUc3ZGNRQ25p?=
 =?utf-8?B?TTFHWkY2Q2Q2WTJmUG9JbU1rWXkySUlYZFFKYzBHUTlUN1h0TGIxaFF0ay9G?=
 =?utf-8?B?QzRjaUhTT3NxbE1RWFo3RFlUMnRWRUNQR2lwdWdhd2N1NE9tblIxOXdJb1pJ?=
 =?utf-8?B?NlZxMUptM3pNNDgxYm13TlNYVndNdWlRQ1k0SFdCWjkxbVFuZ2NQbmdjRHUz?=
 =?utf-8?B?NFI0aFJiM3drNjJqckJyc3YzVWNibll5SlVxSGh3MUJEN3BqM1ZBS2Y2dXhC?=
 =?utf-8?B?eE50Z0k3UzIwWVZNMm1XQ3JpVlNYMnhkbDhtR0NSNUdVeksrVnI2ZFhSTDhE?=
 =?utf-8?B?QlEzcnFvMEgwU3RTMGtPaEN0UkNZSlVxY2RnaEtJdU1sbmxreXJyYUNKT0Vl?=
 =?utf-8?B?eHl6ZG4wdURLVm8yMlEzVi9yZ0FndVh4NTZ0V2gxQ3RmVjNxejNLZlp5djE5?=
 =?utf-8?B?Z3Z4ZXA4U2hRL0JzMHF3QysyTk5EV2JkcEFldk9RVklBS0R0VmxTKzZDaXI4?=
 =?utf-8?B?MytQYnloNVdRc2dqMjhlYTUreU1DTERVUVRqYmx6WmVoYzdmUktIOVpsSnlN?=
 =?utf-8?B?LzMxazBYbEhCK20wSWhuTDV4WFNZT3NlM2xMem5reGVERzRiSzZDblR4UkFq?=
 =?utf-8?B?ek1QWG5oRkFnRUNNbE1ZZ0tNNWUybjYvaGxPaGI2dzgzOXNkcHZMMVJJVGJw?=
 =?utf-8?B?S2ZBVUZObDZSbVRCcEJ0TkloUXBiTTFTcmpPa1BCSVBvNEZYWld1NXN5RFFP?=
 =?utf-8?B?UTBiMkNRdXNBVE1iVjlpR00zSWM3SlQySHdpN2wxS2pzU1lxNjlVeVpWUkdT?=
 =?utf-8?B?ZFE3OEJHbWVEUitIREp6OUUybVIrQy9BUlN5MkJtZmFqbHVhTHA5ZHQwenRH?=
 =?utf-8?B?a0Rxc1VwTURVeG5qeWdZa2RUOEdXaVlGRUJaWENoOWxDb2RwTkRMN2hzcnU1?=
 =?utf-8?B?a2YxU05zbGdnd1ZWVGxYQkNvWGJoYkNIcy94TjQrYWFXS0xZMG5ybjMvSSs2?=
 =?utf-8?B?RENLd05aUXFMOFp4SzJaNTVSeFBmc29kZWtxcnhNZUFzNURPVllOemFPUC9C?=
 =?utf-8?B?MjQzalRVQUJveXVETHVaZDVGdGNjVmV4UUltWkhvdG1TaGtWb1J2RkxOTjRh?=
 =?utf-8?B?eU1pRGIzRzErWHZXZWszSEtVdVJoOHdLQ3psUWJFcTF0b3lXNzVHbTM5cGtl?=
 =?utf-8?B?TWlTYWJOWHJFaGRPRHpkZU1xaldXTVd2MHJYQ3ZYTDN0TEFZckN3dUxZN0Zj?=
 =?utf-8?B?ekNVb3R4bWhxTUtPbnkxaE1uN0dpNGt3bW1KM1Axak9hYmIvcGlTcFhSTnhV?=
 =?utf-8?B?VTFqU2d0dHZqRmtIK0crR21qTnhZelBPU2s0NUoyOXAxTm9LVE5xd3g0blZG?=
 =?utf-8?B?TC9WZTNVSVBCM05DMVMybTZpVno4U1NxWGVhQXdZQ3cwL2dRUzlHWjJ0cnBp?=
 =?utf-8?B?S1I1Zk1qWHIxUFZzak5SMjFhSUNZeVltMXRrTFpaNEJuSXh0R3JIK0pjd3M0?=
 =?utf-8?B?MURqcHhleGpUTTJHL2I4QVE4OU1FLzBoS1BlSHEvSTNteTFCYmlqU2dhWHJC?=
 =?utf-8?B?dVFENUlNMjR0NGM3c2ZXaEFORXJ0TWRjL3VTdThpbit6TmRvMFZOazJJY0lB?=
 =?utf-8?B?aFpMemhHaEhiWEljank5dlNMcWFFTVlyak8rNjhHM1kvKzBRYk9mMWZzVjBX?=
 =?utf-8?B?QkNVaXp0RGFiLzM0eDFqaTE3MzhQd05BSVZnZEdpZ1Vrb05MZ2xwMTBmcWRw?=
 =?utf-8?B?S2htM0JvTTlVbzFYeWFMRTFaQ2Z3R2F2VmNWM2JEdlZ3ZlJkcFhkclJvSGFI?=
 =?utf-8?B?M1JmUkRQamtzQTBHdDUrSnROUThRY3JxQSt6bTZGNVcxWm5WbFAvaW5CdDd1?=
 =?utf-8?B?OXRZUGhUVTJmblBYMFhVYXNyMVRBb2thd1hpdjQrQWF4dHRua09ZS244OGpl?=
 =?utf-8?B?dUM5TGFtQnpJOFpZK0VvTzVOZ0h2SkFqU2tjbjN4S21ZNTFsNHkwZUlRdW5V?=
 =?utf-8?B?eFZOUDNaNDR6eXRxd052VWEvbllPdUNUV0lkRXlJZkhpWWE5Q2RoMjdaaklp?=
 =?utf-8?B?dTJnNjIwUFhIWld6d1lwQWhmdUY3MngraWQyWE41VjRGbmFseW5uQTZLYlFD?=
 =?utf-8?Q?lzeAH5+HoVUTZvS+IQ75EEh+1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2babbb68-5b0d-4d19-ef7e-08db6e8290b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:58:45.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WU28gnpUl6EEDfty8mQnHpIn9kehKBCohIudSHj22D0TNaU6ZXPYqywS/JO4ftg+HQ1mWd1FcuYRSetfQV+4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/15/23 19:47, Ira Weiny wrote:
> Alison Schofield wrote:
>> On Wed, Jun 14, 2023 at 12:16:30PM -0700, Ira Weiny wrote:
>>> From: Navneet Singh <navneet.singh@intel.com>
>>>
>>> Exposing driver cached dynamic capacity configuration through sysfs
>>> attributes.User will create one or more dynamic capacity
>>> cxl regions based on this information and map the dynamic capacity of
>>> the device into HDM ranges using one or more HDM decoders.
>>>
>>> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
>>>
>>> ---
>>> [iweiny: fixups]
>>> [djbw: fixups, no sign-off: preview only]
>>> ---
>>>   drivers/cxl/core/memdev.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 72 insertions(+)
>>
>> Add the documentation of these new attributes in this patch.
>> Documentation/ABI/testing/sysfs-bus-cxl
> 
> Good point.  And the region creation patch needs some updating for the
> sysfs documentation as well...
> 
> Thanks!  I'll work on those.
> 
> Writing the documentation it seems like 'dc_region_count' should just be
> 'region_count'.  Because the 'dc' is redundant with the directory.
> However, dcY_size has a redundant 'dc' but Y_size (ie 0_size) seems
> odd.[*]
> 
> Thoughts on the 'dc' prefix for these?
> 
> [*] example listing with 2 DC regions supported.
> 
> $ ll mem1/dc/
> total 0
> -r--r--r-- 1 root root 4096 Jun 15 19:26 dc0_size
> -r--r--r-- 1 root root 4096 Jun 15 19:26 dc1_size
> -r--r--r-- 1 root root 4096 Jun 15 19:26 dc_regions_count
> 
>>
>> A bit of my ignorance here, but when I keep seeing the word
>> 'regions' below, it makes me wonder whether these attributes
>> are in the right place?
> 
> There is a difference between 'DC region' and CXL 'Linux' region.  It has
> taken me some time to get used to the terminology.  So I think this is
> correct.

I think you answered your own question above here. If dc_region is 
different than CXL regions, then you'll have to keep the dc_ prefix to 
distinguish between the two. Unless you call it something different.

DJ

> 
>>
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 5d1ba7a72567..beeb5fa3a0aa 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -99,6 +99,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>>>   static struct device_attribute dev_attr_pmem_size =
>>>   	__ATTR(size, 0444, pmem_size_show, NULL);
>>>   
>>> +static ssize_t dc_regions_count_show(struct device *dev, struct device_attribute *attr,
>>> +		char *buf)
>>> +{
>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>> +	int len = 0;
>>> +
>>> +	len = sysfs_emit(buf, "0x%x\n", mds->nr_dc_region);
>>
>> Prefer using this notation: %#llx
>> grep for the sysfs_emit's to see customary usage.
> 
> oh.  I did see this oddity when I was testing and forgot to change this.
> 
> However, I think %#llx needs to be used in show_size_regionN() and this
> needs to be %d.  This is just a count of the number of DC regions
> supported by the device.  I don't think that needs to be in hex.  Changed
> to %d.
> 
>>
>>> +	return len;
>>> +}
>>> +
>>> +struct device_attribute dev_attr_dc_regions_count =
>>> +	__ATTR(dc_regions_count, 0444, dc_regions_count_show, NULL);
>>> +
>>>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>>>   			   char *buf)
>>>   {
>>> @@ -362,6 +376,57 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>>>   	NULL,
>>>   };
>>>   
>>> +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
>>> +{
>>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>> +
>>> +	return sysfs_emit(buf, "0x%llx\n", mds->dc_region[pos].decode_len);
> 
> ... changed this one to %#llx.
> 
> Ira
