Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECEAEB64DA
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Jul 2023 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGJP4d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Jul 2023 11:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjGJP4U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Jul 2023 11:56:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C81716
        for <linux-cxl@vger.kernel.org>; Mon, 10 Jul 2023 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004562; x=1720540562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1EwnSNWW7wLUTOD/oLL7mTYot4HTsf6NtsVVXA5Wl1E=;
  b=L0sv7u6L7XDjPel8X1PONh1cCGkmkEUXgOQj1hzp13Y6L1yjmz0S5trz
   Dy5rjWgcDQ/7QW/0B/L0iZBuia+N3JAnloEoaa4EDYjr65bzPdJ0wNOpg
   kHIkv+MPakKwEw365htwa/LkqiOigUQGkVkMgXnZBxfHI3a4s4SLvRc91
   NOYjH+bQlsMXQHPKnrcy6H2R7+Kk60R72jGdtpNdTb7aE7JVP7ezcWA1U
   gWl88FIrXvMkb0w1tkS5JWt1vFQjH/UyYYeb/RvfX9vNfCqkbbedpoiIz
   S9++VNdokDYHfihnE+rjZJMHrillPAoJ6bsWgfL0wj3xqJ/XYZKcksDSJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361844364"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361844364"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720745425"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720745425"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 08:56:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 08:56:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 08:56:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 08:56:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 08:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi0zKBhKkgcbblepRoh8UIrMEMhLNd/gmOroEmhcAoGK9SPK1jHnwuKm8OwEELfqtZqxUpSFM9PLT4oOnBeP5GB8+H52CM7esaf5LRNCvA+KmSkYHDJDhyZwUBS2ycALUjh8RtPArFLqX8VmTx0TgOyHCJO96QcRTcSGRbp+246KkoMBP23Er5CdwZ4BAwvNJy707h4s/sT2MCuF4rxzLWgL3gSKv4oHhwa8J4ID6qweyR3X832vCxD0iMMeL6BrgCavCAmDOKtkTEf4F1Mo6u3X2Og3fa7dpprEvbI9Acmogdq3CtPMMS8kehYkTVFLchbvY0yTrm28MDAtX9wL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MZizensznXwjzRrBufVpn/Z/73jl86rVevP+7Nc/WY=;
 b=izpkW7ESRQow4uaBvR66XwyfTkhPki1M86mXEi7GEg35AwV8deaMO0YaRVgBBpQD7QjCBeA4oHEmiPBVhaUEfFe4epAmVHG0wBe0zzB2OqqceX9QFsSWFvVHybVng1p1P9DT77gxxw7VOOJ4nQo7Q4TVGCaQUqqrmyatlNLma98qMnlK4rDysmU/XS6TEsO3djDG+XQYZHU8MWaTtiaZeyUZVNB17ACZjtJXiToj+K2ZxU7v0TJG3vTrkruPZ0zVXg4Vb8oaQgaX6nPb6//D1fPFeE4nNS4ypB8If734qw0gWLL9+xNikZ8jNZjNIADpVse8NGSYSsaSBSbv/KOgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BY1PR11MB8005.namprd11.prod.outlook.com (2603:10b6:a03:523::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:55:58 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:55:58 +0000
Message-ID: <2ffd72ac-7f74-c7cd-e88c-619f07ed402f@intel.com>
Date:   Mon, 10 Jul 2023 08:55:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl/acpi: Release device after dev_err
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Breno Leitao <leitao@debian.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <20230707161616.3554167-1-leitao@debian.org>
 <ZKiPFu0KY0alQxCJ@aschofie-mobl2>
 <ea6cc344-f65e-4eff-268a-3c0890b5ed0d@intel.com>
 <ZKi2vH1XwK2D/OtE@aschofie-mobl2>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZKi2vH1XwK2D/OtE@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: d842d97f-3cd7-498a-8ce3-08db815e2705
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAWdYsxEejuWduXVJBT4sUt2ogf2S1WiNNx3NhCxZPhDNv+UZ4MI1G+eHpPIywAMZM6jvkxOEaGu+syxSGEuFAi4KN4k5iFdbEEBeWnQK7wDLhzTAJmb2mk17oC4Xt0aey7UhkQRk2CJgib1L+XipiB9s3aGtbHkXjB7FYCfc9OSHDGn3vEjTD9bVYhJzj/Lz2RGQaCvgDC/ng2qsD32bmky6jqBK87SaslvquWeEEGYPXzv25RO1GBaxik2ZUoWtwqVgAFgh3y8T4ZWs11kUMzv71o1Cn/pwbfq/zW1EKH/WNZiSqZGKjv88hXY+PvlPzVaowwN96xwQWR6MrdKfOINmYCCNyU7w0Xg4HTrUYdbzYc+YGVlxbo0hNOq4KbVCgoHvUO0q/OUeeD+3+ILD/GlOx8Cjdd3TLvPRrHfVvjBehUrcjlwidVBtAmonkMgxv3IKnlirmUBESeB0J8GmlawT0nmU2Vs9Lu4WCyRimgjxo/C419NaKsK3nCqE4mMS20ltdJctb6sjLw8CSAWyHigXPIC/HeKigJRWvOUXKm91NzGxUbDrbWw2obtCaED5Y8EawXQmdCzNwfb1gC8guQD8VvCfE/x3V8V6pIu0aj9NOKgqJbxpL/NgIBge7odQLfXKf2Z81XPil32tHmF2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(2616005)(41300700001)(53546011)(6506007)(26005)(83380400001)(186003)(31686004)(6512007)(478600001)(82960400001)(37006003)(6486002)(6666004)(4326008)(6636002)(44832011)(38100700002)(66556008)(66946007)(66476007)(316002)(8936002)(86362001)(31696002)(5660300002)(6862004)(8676002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0lDdlF0ZmNKamxwbWt1RE4wV2VjS2JMMkpldWZQZzlMVkpyZjJHcnkrU0Jn?=
 =?utf-8?B?YmpMOEJxZmlnYWZHcFM1dmljNUJoV3lORzRxUkMrZDJLTjdHZVlTSEZvcnZR?=
 =?utf-8?B?STBpczJadWxLdGNhenIrb1ZNYTYzbGJlRDNYY3E1dVduWFZoOXhLclUrYU9P?=
 =?utf-8?B?MDVxM3MxZEtQNHBWeStrSmgxbnpIaXJYbUt1QVBjL25YaXEwKzEzaGpuemNJ?=
 =?utf-8?B?S0VWemlBcC94YXlzcEJEVXgxcmtLeUdOOWxIREZja0Jqc2RKRkxxVEQxZGR2?=
 =?utf-8?B?MFk3ODNUdm1yS29MVGdlLzBpRjZ5c1pIUjVJdk8zYWlRZ0FXbFBuY2RXN0RL?=
 =?utf-8?B?YXNYWVJYNFVMM29MVC9uTUlXSEtMS2UxenlhZ2N2N0pZeG5EZW5YMmg2a2Nt?=
 =?utf-8?B?YVlaaC9FZ1hIekJSSW1kTjBkbFhJUGdNTy83NnpWZFhnYXl5a09VaFBBWElZ?=
 =?utf-8?B?aUFTa3hGZjFOd3pqOWpqcndOZkZ6dTlJNitsaDRmSUdpNFN4eE1SUStYdW8z?=
 =?utf-8?B?OXI3WjFPTW52NTJGZ2JYaExtUjVGKy9FQWxpNUw2NGw4TEd3VkhveEhIcFlu?=
 =?utf-8?B?U05qUmsvb0JUZ1RtdWFmeWJwejVySkhiVGlwVGhoUnJ4QktRRkVlM3B3OTEr?=
 =?utf-8?B?Y2pxenJQdWJjc3FvYjZmTjg5SkwzQlUzL3JCZmxnN3dnclZCZ090ampjZHc5?=
 =?utf-8?B?N3Z4UlkwV1RDRWNwWG5kNnNaRTVYeXhScnpsQk93OUhreFlESUFKWUhRT0Q1?=
 =?utf-8?B?KzZxdWNmV05BektYYytHRUlTeE5ud3ZjRFEvVlhMR0ljdkdUMHg3cmZ6aVU3?=
 =?utf-8?B?Ym9nZW1GZWt6TllzZHVnd2p1SW1BVzJDenhNc2pXOStmK0hUditISEcvSmJ1?=
 =?utf-8?B?Z2tXK1hCWkNlVEFmODc3ODNoSTF5VGxQMElTMmFIYXltM3hqVlpkejJJWDNH?=
 =?utf-8?B?U1MxbzIxd0lMcXQ2Yzl6c0x0bG5mZExsbFVzR3lTSTUwQmlnYkw3a3Y2cUk0?=
 =?utf-8?B?L1lERXJnNEZhMVBLQmdndFhhS1dxOURwTXJyUVI3Q0MvUDRPZ084ZEpDcHhN?=
 =?utf-8?B?RnNuT1BlWnBFSzVLRkNUd0grZUhWT2NqbEY4WjhldDF5WFFpUVBuT0RXUDJC?=
 =?utf-8?B?cnNpQVByWVUrbUZPdGhXU3k3MWQ4UWpFU0JaRTQyQnliZHYrNElORjZ1bVZk?=
 =?utf-8?B?WDZOM0tBM01DZnpZVEtQWFJVTExVdXFCbE4rUmNTWmF1c2paTFpRVi93ZWhz?=
 =?utf-8?B?Tnpzd21Pd0VJeUpKTzZBMmZqNFFCdzY1bEZGZno4RnlKUHdESGg1SU1wTmdo?=
 =?utf-8?B?Q2w0UkEwV3pXMklHRml2dGk1aDRYaldnZW9WaWhrOFYrdnBmUmdURCtsVnRZ?=
 =?utf-8?B?QndETUMzWU1rNiswVUhycmVhdTh5M3NxSFViazRiK25NdzYveTVvTTNsc3By?=
 =?utf-8?B?YmNpMjRYY21pM2NvQ1o4YWdDdEl2cTExK0R6NWJzMmlkdkJvQUZHM3RIRUR6?=
 =?utf-8?B?anM1aFcxNTcydU1QZnBESEFweDFmL1poVjFvMUpXM3FyckhPRWllai9vQlpv?=
 =?utf-8?B?Q3RLellvZlNLUTdid0Fsd0tIejhKVWIyU0dVbjVrTkI4S2d5U28yS0hlNURv?=
 =?utf-8?B?RCtpV08xZFZWd002UktNVUdIVjU2b3VuV3RhYW9oWFRjN2NyTmk3eHNBTjA4?=
 =?utf-8?B?dmJHeW0vbVNCNFNBemNQZHJrdHgyb2QvTXhpSVpyMnpxSDJsSzF2M01IZzRt?=
 =?utf-8?B?anVJanZCSExQZnRMZXVzQm9IaGc3aENLa2lieUlZbHU1MlZoSmFzYmYwYlZX?=
 =?utf-8?B?UlVHaFpLZ2hubG1NREdjL0tIYzZTTmhXNDFXa0lhWklLMWY5aVVIWEd6NFc2?=
 =?utf-8?B?SmZVRk81alRvem5zYUMvQzFtd0tCcXV3Njg5U1dRUHlOb3Jzc05Ic2h1cUNO?=
 =?utf-8?B?UkpWZ0UxVkd3Z0RLMXFONS9CTmVmZmw5eXNDTzFrVDBsbGVPeURybC8rSzVW?=
 =?utf-8?B?RGNTNHRjRXRRMXVudHdFcWxpVFlTS3ZYR2hZTGdMRGtTcWl4ZW1aNlhhVXAr?=
 =?utf-8?B?dGFOZGtNMzVXcFd6YzlpTUxQNkFaOTIzRnNXK0RORDdqQVN0Um0xWUpKQzdu?=
 =?utf-8?Q?GfExPHh9m8obljLqCW4N+xTZU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d842d97f-3cd7-498a-8ce3-08db815e2705
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:55:58.6482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgEn+O+gv3qeDpB3eANN8HgaJviJo3Mp9yvTaQ/FyuiV9bVwymvqPmc05rYvw2+je4+0aw2KVPvyuG3N4a7DdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/7/23 18:07, Alison Schofield wrote:
> On Fri, Jul 07, 2023 at 05:33:02PM -0700, Dave Jiang wrote:
>>
>>
>> On 7/7/23 15:17, Alison Schofield wrote:
>>> On Fri, Jul 07, 2023 at 09:16:16AM -0700, Breno Leitao wrote:
>>>> Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
>>>> fails. Kfence drops this message, after the following:
>>>>
>>>>     BUG: KFENCE: use-after-free read in resource_string
>>>>
>>>> This is happening in cxl_parse_cfmws(), and here is a simplified flow
>>>> that is coming from Kfence.
>>>>
>>>> Use-after-free:
>>>> 	_dev_err
>>>> 	cxl_parse_cfmws
>>>> 	acpi_table_parse_entries_array
>>>> 	acpi_table_parse_cedt
>>>> 	cxl_acpi_probe
>>>>
>>>> Free:
>>>> 	cxl_decoder_release
>>>> 	device_release
>>>> 	kobject_put
>>>> 	cxl_parse_cfmws
>>>> 	acpi_table_parse_entries_array
>>>> 	acpi_table_parse_cedt
>>>> 	cxl_acpi_probe
>>>>
>>>> Alloc:
>>>> 	cxl_decoder_alloc
>>>> 	cxl_parse_cfmws
>>>> 	acpi_table_parse_entries_array
>>>> 	acpi_table_parse_cedt
>>>> 	cxl_acpi_probe
>>>> 	platform_probe
>>>>
>>>>   From my reading of the issue, the device struct being used by
>>>> dev_err() was removed in the put_device() before.
>>>
>>> Hi Breno,
>>>
>>> I'm not familiar w kfence, but I don't follow what it finds
>>> suspect here. Does kfence point to exact offensive lines of
>>> code, or ???
>>>
>>> The put_device() removed &cxld->dev and the dev_err() that
>>> this patch moves the put after, was using 'dev', which was
>>> assigned from ctx.dev. It is not the same as &cxld->dev. I
>>> wonder if Kfence thinks we can get to the next dev_dbg()
>>> statement and misuse &cxld->dev.
>>>
>>> More below...
>>>
>>>
>>>>
>>>> Put the device just after the message is printed.
>>>>
>>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>> ---
>>>>    drivers/cxl/acpi.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>>>> index 658e6b84a769..5179bf4211d8 100644
>>>> --- a/drivers/cxl/acpi.c
>>>> +++ b/drivers/cxl/acpi.c
>>>> @@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>>>>    	}
>>>>    	rc = cxl_decoder_add(cxld, target_map);
>>>>    err_xormap:
>>>> -	if (rc)
>>>> -		put_device(&cxld->dev);
>>>> -	else
>>>> -		rc = cxl_decoder_autoremove(dev, cxld);
>>>>    	if (rc) {
>>>>    		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>>>>    			cxld->hpa_range.start, cxld->hpa_range.end);
>>>> +		put_device(&cxld->dev);
>>>>    		return 0;
>>>> +	} else {
>>>> +		rc = cxl_decoder_autoremove(dev, cxld);
>>>>    	}
>>>>    	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>>>>    		dev_name(&cxld->dev),
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>> (pulled in fresh code snippet to get the dev_dbg() in view.)
>>>
>>>> 	}
>>>> 	rc = cxl_decoder_add(cxld, target_map);
>>>> err_xormap:
>>>> 	if (rc)
>>>> 		put_device(&cxld->dev);
>>>>
>>>
>>> This puts &cxld->dev, not dev.
>>>
>>>>
>>>> 	else
>>>> 		rc = cxl_decoder_autoremove(dev, cxld);
>>>> 	if (rc) {
>>>> 		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>>>> 			cxld->hpa_range.start, cxld->hpa_range.end);
>>>> 		return 0;
>>>
>>> This return avoids getting to the next dev_dbg() statement after
>>> put_device(). We cannot get to the next dev_dbg() statement when
>>> rc is non zero, but it seems kfence thinks we can.
>>>
>>>> 	}
>>>> 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>>>> 		dev_name(&cxld->dev),
>>>
>>> If we could get here, after the put_device(), that would be bad.
>>>
>>>> 		phys_to_target_node(cxld->hpa_range.start),
>>>> 		cxld->hpa_range.start, cxld->hpa_range.end);
>>>>
>>>> 	return 0;
>>>
>>
>> Seems like the code can be cleaned up this way. The double check of if (rc)
>> is kinda weird anyhow.
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 7e1765b09e04..0573b476d29c 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -291,21 +291,21 @@ static int cxl_parse_cfmws(union acpi_subtable_headers
>> *header, void *arg,
>>          }
>>          rc = cxl_decoder_add(cxld, target_map);
>>   err_xormap:
>> -       if (rc)
>> -               put_device(&cxld->dev);
>> -       else
>> -               rc = cxl_decoder_autoremove(dev, cxld);
>>          if (rc) {
>>                  dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>>                          cxld->hpa_range.start, cxld->hpa_range.end);
>> -               return 0;
>> +               put_device(&cxld->dev);
> 
> Why do you think the put_device() is making deref of cxld bad here?
> That cxld is still present.

The put_device() can trigger the ->release() of the cxld->dev and 
therefore cxld may no longer be present.

> 
> Maybe the unrelated bug here is that we are leaking the res.
> Rather that returning directly, take the kfree(res) path out.
> 
> 
>> +               return rc;
>>          }
>> +
>> +       rc = cxl_decoder_autoremove(dev, cxld);
>> +
> 
> Now this rc is not examined.

Yeah, should check here and return rc.

> 
> 
>>          dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>>                  dev_name(&cxld->dev),
>>                  phys_to_target_node(cxld->hpa_range.start),
>>                  cxld->hpa_range.start, cxld->hpa_range.end);
>>
>> -       return 0;
>> +       return rc;
>>
>>   err_insert:
>>          kfree(res->name);
