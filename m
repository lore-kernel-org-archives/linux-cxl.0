Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB5EB64DB
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jun 2023 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFTQsV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjFTQsU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 12:48:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85961726
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687279697; x=1718815697;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dH7IdTpHzHTm0wJsgXFHop3CSkuBP45sQZ1/ARJ+D+A=;
  b=DbhONexk1GBgiUJ95dtq70nlp8LrHIGdC4wyN3a2lg4unDWsKA/NUkec
   p0cfdtYK78SudijUoclMnNOIsyGk1hbCh6EjXVNWc6WvYm6XwcPzDWDrP
   jIDOkrZK6o+DdnyjNk1BmGtMPkSWazFl3PDzgjUo6c7uFHT1z76vf1zu5
   Ebj1gqEFJtjCA0WeEf1DaFdgHi2cdVJBe0bAgTuSrzr5LJKhSHFXNNHBU
   Nq9EmdABnNh/G6jtsQCc5nPacKyym397k6CEAl6OXrJCbIG9sxX0BLkSn
   rI1TKYH7hgiViBUxnpWu1sDNWVNj6lWhvnc6eiiDs8cRHD8nXSOmDVo1m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349648453"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="349648453"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:48:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708359198"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="708359198"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 09:48:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:48:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:48:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 09:48:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 09:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJu0lP2E8Mp9OCOy2N5ZS5uAHXXbljQyrp74R17oah8qkqP4nYppKi3tyj0I/Hohr3Ph5tqxYBj6U0D00UmqdAfbZDZ8ewlR85B65LxTVlzKsNaV5RX+MTmZumFGFoNaDq6L0OFuIpziEkPIfJCZWJnSQxkc8WT6pCxdzB5Moe7PlYnBGdpNE2F4lCoO0+A1yKgbvAwTTXd1DdFwGRe/uwWcjJL0Bu2bRbEuX7FTGGa+z2DYYkj1698MipNCinpLI146Q3R5HEMx72PE5woDQiVlBHLsBC0XLa2GemUDtFMy1gWOj1EhgSLzPid4l8dR89tIseU96fvG4qw2T8gMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0UXLwhPYp6v+ua6NEBZwyocrSpFOOU2O7jw4p1j8JM=;
 b=oGqWk6cbY6nB/JA2DvloQENvS2SaL5E7X1r2rhmONgCS0/yoPPokZbRypythMsNhfujSe9GoBZZt1yCTbQStD3o+nOoF8KXndhV4GxphqyO39MNkg3pJIRwYRV2tynoJHMj2zVkS7A7hpBXfitkx2kyxiok4H3aA6SMrAvB8ji3VgYr1lWc+rVoULphBRyXXjSGvr9FRPQTml+evlQVzzqBJK4pln2eTjTYdWg6aLILxp90kZ+qcUBAuFgTo4EnnCX03yQU27vTtUehGTE5FAnRM0gVAdTRPr3OMZb+7H3oUN+QDYSLwAlWDeVe/CHZknjmwG0oxaeiZ1sfYXMf9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 16:48:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:48:13 +0000
Message-ID: <f578437a-be83-f66e-424a-17e2cfe2f554@intel.com>
Date:   Tue, 20 Jun 2023 09:48:09 -0700
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
 <a6a0aad8-febe-d466-ed1c-105b8bf4cacd@intel.com>
 <6491d29c4a019_483a2941@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6491d29c4a019_483a2941@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e13a722-3935-4a0b-dc67-08db71ae2302
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0cn0Vm1KKITYvJUreZL3wzW9ZNwDa8xaBtWbRI71N1wkfai7lwSMegJNuvqP9ktNdddBthC/yN0+WZzMVfyGsNnka5KWZQvSj58XOAu73XutHbCx0uTH5nj6B1QR/uZ/mJt3Wdsc7qnorXT9ys/FIkOl+yDfZBYD+zxpMP9ghuw3b1zL7RetJV9b7LvfCns4ncOo4zfJVtlhVC1gLulU9YaD3zTfKC96XdjpsquVrFuO8R2CBmRA04Zip7AHrgoE87lS7K5B5gpPGOmYii1Gm+cqJtrk9f5QGyIDQpb0H1wXlVgs/8egLgNiS39jpagACILXAhemdHbo08BhOgYgG5QyNlNa7d5tdoSzmqevyT6+8pg9aAuDrzKBQ+7b4+bYu62tMBLhQwBoLAsopp7BKSamVAIqAXJtvzF7bPgGOlBL9Or/hfbhrD0SZny1nG2J4rFcaCG3duwkDaGXwlLJdxe2Xtd9pMPHzUkLS8KSztttGD6RHf+rjiSBQdSSpvh08iFLHObGcRjvVmccgrn/06pAWWompuxitkjMe9pjUc9CubOx73pr12OJVY85Pgz50apWli2j20J9GqJDg5UPRbPn8P3CKMUyJih0HF8syGkZZSMmPNWrDDMGVJM28KanjGr2+xBUe8ccS+huxh/og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(8936002)(8676002)(44832011)(31686004)(6636002)(4326008)(66946007)(66476007)(66556008)(316002)(2906002)(54906003)(41300700001)(110136005)(6486002)(6666004)(478600001)(26005)(6512007)(53546011)(186003)(36756003)(2616005)(38100700002)(6506007)(82960400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3JodDlSaXNPQk51VWE4WG54S2dpTWdydnBPRHZhOER0UTdZbFhXZ3Ixb05N?=
 =?utf-8?B?cWZuSzFXMVVGM0haeWZGQ25sZTI4Z0kyeVdEaWRSRkkzb3ZSYTBTck45dXoz?=
 =?utf-8?B?WGU3SW1HSlFQdW52QTFuNXUvSkN4cVhHU2dlM2Yrc3Q1WllwSU9BSjl6SFVW?=
 =?utf-8?B?aWlSSEFrSVA4QXFQL1JiWEozU1BXRHd0MG5YYmZ0dXh1ekpjcjBpdFJXaW94?=
 =?utf-8?B?MzJWRmVPaDlYaWFyV29uM2ZJMHpHZkFRTGhIa0FJQmJBdnpWYkhMdUliWXV6?=
 =?utf-8?B?TzBGK0lsbC9qeFVxc05uMGJkY1AwMVZXbEg4ekRTN0Yvd1BBTXlCSUovc1k1?=
 =?utf-8?B?UVZKdEU4c0FqRU5acCtmQk5VMmNuaGs5SnpCL2ZJeW9FNzFLTUluQyt5bFMy?=
 =?utf-8?B?eXdRMUE2WUtDTEx0WUhaQmtmZ05GWDFRNVk4WGRjWTBzVzJSTDNQamc0eWp2?=
 =?utf-8?B?bWtQdlh0eW9IQU5qZ2xLdHZNSGlQb2sxUFlPTGZuM1RoeEtMR2s0Z1lwakVq?=
 =?utf-8?B?SytRKyt1T3dKcVh2cDlkZ3h0blh3TVA1VVgrall0L0gyR3pZcFdzb3lxaEEv?=
 =?utf-8?B?aEVtOEl1VGt5enRlUzJCczhPSFJsUzMwcHdCVUpPOG9MNFAvZEozZTMybkJH?=
 =?utf-8?B?bFVXM2xUTW0rSm1IOHd5MGNtMWVJQ3RodVpBS1prVk9zbGUzTER5MnpVT1dR?=
 =?utf-8?B?N0ZjRG1rdmtzYzg5NHV1cnZJU3Y5MmlKRS9hL3duNG5OYWZmdnViZkdKUVJ4?=
 =?utf-8?B?ZmZ5RWsyd1VRZHM2RWlKSHNzTzRtZkpwdG14TFJxUE9rU1NQSTQyTTR6VFph?=
 =?utf-8?B?R2V3VFRxa3VTcEFOckRmbmg3eUpvaDFGSGNQVmZhSkM2VVVERi9BOE9helNz?=
 =?utf-8?B?aGhDVXoweHd0TEIwcTZ0YWFyWks2NGdLelZKUlZBSkw3L0VzZU96WU5yVm5Q?=
 =?utf-8?B?dXY2QjFLNlc4bVhhU3cvRTROSHZXSXc3cklsa1pUeTZ2ZHVHWVdnWlZyOWE5?=
 =?utf-8?B?bE16SDFTSEtXUzRISWs0ejhtbjliYU5SbWFLZVh1QTc5RlM0OTI2RkIxQ1hu?=
 =?utf-8?B?NERtQkh3QUhFbVU5U1JFQzBqWnc2L3BRUHRsZ1huUzcwWHdiWkZpRXd0UThV?=
 =?utf-8?B?WVJLZG1WeTJLZW8yNTMrcktBL21EMm5YcHNWTHR4YXFGRGcrNlJwaXcrTDA2?=
 =?utf-8?B?SHE5eG13MnRWMFc1MVhjNFZ3dlFSZDZlZytkNW9vdlE5SVV4UFJHcndwUE0v?=
 =?utf-8?B?RHV3aUV3b0llYlVBN2ZQT3drWWNEQVRyREdNYW4rU2ZuRy9CUnhtU2l0T1Ra?=
 =?utf-8?B?eXN4b1dOT1FwOHd1OGg0bkpOQzM0UmNIQkZNT1lLb1FzU2JndXZmRWJ3MFky?=
 =?utf-8?B?NVpCSFVIcStYRVpGQmNzQ3F2a1ZzY2hzOXBtWm1XOHBaT0dxZDR4NkdpVzVl?=
 =?utf-8?B?RUxLc0VmZWFDVE9SUk54eXJWbXorMGYzeEZJckQrMTU1Wjc5NHNIaXhiUG9p?=
 =?utf-8?B?VXRyMWFNV0lObGt3eFU2eHR1ajlYNUVzR2tad0tpeDg5Tm5lNzU2YS9MRnRR?=
 =?utf-8?B?V2twaXU4L3RSZDRpWXRveWRva2QzeE91dnMwWGI5bENsc0VGRGtqaitpSFll?=
 =?utf-8?B?NXZpblhoZC92YS9lbm41YjI1V1FWUmdFWGtRQ1N0QWxDZDZra2V3d3djQXIv?=
 =?utf-8?B?ZnF2U1hjdUdtcWxDS2NGS0JOcjkyN1lDdGRnYnlHSDA0c2QxdmdFdDg3OXFL?=
 =?utf-8?B?Vkh2OWd1MkNZOGFLZzc2WHVPdlZzM2ZvaDNLS2JpWW5iM29NZFJsVjNVNlBw?=
 =?utf-8?B?MndmWU1qdXNza01ZZDUvb3NFdjI5cmZ3Qysyblg1YU1kRDd6cXliblp5UUt1?=
 =?utf-8?B?RGpaZjNsbmR1MXVUK2RPY2U4am1nVldXOW1BOHpFdmdVcWx6bHBBbU43OFRy?=
 =?utf-8?B?aVJPYjA0c1dhbjUyVjFBWmpQa2xWUW03Y0FBZ2w4bjE5TU5rdmJpbmMxanh3?=
 =?utf-8?B?VmJPa2ZCNVNRNStmSUtDQnJGbGJNR1hrdXFja0Q0Ym5TemFtSEVMOXNEdHRK?=
 =?utf-8?B?aEdweW0zSU1OLzJHUXAvUUs5eHZqa0xtWHg1a0pPTzlvU3ZvWnZ1QmxNSEsw?=
 =?utf-8?Q?YTdQ5A31gFJMuEfftl0zq1m9H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e13a722-3935-4a0b-dc67-08db71ae2302
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:48:13.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGVJnUXpM15UlBB5PzX0dGVLScHO1jK2ASMV5r/yAk5E+UHN/O9nHHHQ63HOClijp7guh5MhTwqeIgdWdaJfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/20/23 09:23, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
>> On 6/15/23 19:47, Ira Weiny wrote:
>>> Alison Schofield wrote:
>>>> On Wed, Jun 14, 2023 at 12:16:30PM -0700, Ira Weiny wrote:
>>>>> From: Navneet Singh <navneet.singh@intel.com>
>>>>>
> 
> [snip]
> 
>>>
>>> Writing the documentation it seems like 'dc_region_count' should just be
>>> 'region_count'.  Because the 'dc' is redundant with the directory.
>>> However, dcY_size has a redundant 'dc' but Y_size (ie 0_size) seems
>>> odd.[*]
>>>
>>> Thoughts on the 'dc' prefix for these?
>>>
>>> [*] example listing with 2 DC regions supported.
>>>
>>> $ ll mem1/dc/
>>> total 0
>>> -r--r--r-- 1 root root 4096 Jun 15 19:26 dc0_size
>>> -r--r--r-- 1 root root 4096 Jun 15 19:26 dc1_size
>>> -r--r--r-- 1 root root 4096 Jun 15 19:26 dc_regions_count
>>>
>>>>
>>>> A bit of my ignorance here, but when I keep seeing the word
>>>> 'regions' below, it makes me wonder whether these attributes
>>>> are in the right place?
>>>
>>> There is a difference between 'DC region' and CXL 'Linux' region.  It has
>>> taken me some time to get used to the terminology.  So I think this is
>>> correct.
>>
>> I think you answered your own question above here. If dc_region is
>> different than CXL regions, then you'll have to keep the dc_ prefix to
>> distinguish between the two. Unless you call it something different.
> 
> But it sits in the 'dc' directory.
> 
> memX/dc/dc_regions_count
> memX/dc/dc0_size
> ...
> 
> So it feels like the dc is redundant.  But it is probably ok as it is.

Ah I see what you mean. Yeah maybe dropping the dc would make it look nicer.

> 
> Ira
