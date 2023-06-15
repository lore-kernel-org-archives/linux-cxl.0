Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A242EEB64DC
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjFOS2l (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjFOS2j (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 14:28:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFEE10F7
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686853716; x=1718389716;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HWFTjwmruWEIy7TFDGrU2JoTJ8UlIht9nTpAdt6jk1s=;
  b=JD+uajBZFgUYkEmeUPsbL/LQOwg/AGAQfBAgYCJlg+swag1Y085cvr5P
   fTIYXVpjrpndLVuOV8YkX6ZGFgbj5iSkg3xzharKCNFlmhb5+VXg82kyT
   /pJH4jnzHsNhvS8707XmYWrV35u4R9/zvrx8boIt58Otev6cQHhj9VwLg
   gCksLmcKTx18xXjarfZMeQju1KwmHguctTHBoWy2kP3KnVxkU2UrtZz89
   jImdCeujzA97/ihCGziXhJqpiZ7QVDDwUOWB+MDfP1R38nSNRrSw8VhnN
   UzrE9HUSbPyQicsbqCi1oLhmNGQvcrlnVEH/+hOsPDtTKlxQtWeZ7ddVq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359000725"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="359000725"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 11:28:35 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745724325"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745724325"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 11:28:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 11:28:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 11:28:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 11:28:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 11:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+MTJDcwRnc9GYDs8lo/E/7var24s9GbT8qUWqILkaU/CmEkkUaC3xoxt5aMeG/bhdp7ImxWFgdoE0309VxeZMGNrTs6k8n9fMq6IP66SJG6jBnP1gVNzdeQq7vjStfpWdLx3WhJf7SLepw9JbiFlw0HjqDLzZQWD1nhx1KCVfEeI5nwvxdMfOmXUwlGFd928RhPjBelL+HagVQCRY7nx8y0ZAoSrUjygBWePJgmcZ1oIi39sXcGNtoNzk8tozU5H07hHK+1LIt2j65dejLHdhi0ZNPJfrFHQiCHfaVedxu33arPdblOgug4ugSms7amKYXPAZawP5QdmlseOYcY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVmq/fpNp+BevpaebNHLoyX8fctpw9oeSRAoCQ9nUGs=;
 b=MA1R8KdJeunFn8S7G04uJOU4VdAopDSUhgoI71i6xmWblJjFI6IGkQK5xb7Ctmpi0tFKN4YZ0haoZ4YcvnuiA1rpldBZMGn8XhKvPZPvTWS7hVCy3AHB8lgiYbsEeNiuvRnnaCYLuxslzgTfBru1Xi/pkN4wwSeZn5JOkO97XoTjWi9elFiLoan7KjKNfa4vvUeDdJ0Fc+MNmWwx202NBQ9bsYS6mAEu1nE6LlhcRQELfFp48lMZKxI3h1qOZqa0OJ7SUuZYLWpUogBXcy3DFJLv++zKIie4KlgijJfSoPvCDUJ/xeDaG5XM6TAd/6GWvcBPhA8vZTs0qGxCIm01Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 18:28:30 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 18:28:30 +0000
Message-ID: <06bcf919-1abb-33d2-105b-b7e7a7c73b96@intel.com>
Date:   Thu, 15 Jun 2023 11:28:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
To:     Ira Weiny <ira.weiny@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <f6cd4851-b024-c8fa-8f6e-fcc27843f120@intel.com>
 <648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f21730-80d3-40d9-bff4-08db6dce5162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0Bn9lL9RhwthK9bv9O8BCxx/BAcElodwTzpuNodpu7sVQzFgfXR9OrwX6cSwPAoE7rys4aCZHS+Ftx7kVvq8+d1MTendaA3gJ7MfSnRHJI+T6JNL4xDdQeSa9YY4GrSYMFCIo/2PAAZPqeLIHWrTr13FBxkvFpAl/YBSM/4XuWIZZzbsIStFQbDSIjtSVWTRdJq6joyVRPqagm04/eMoGwHNkdE0GCVdlv1cLsdUbQyokLONHdgMiSQrT/xelKuFQcEw63d89qro20+edx2HnmNqoHNPybuhgysSXZKTEIrt0TVGhYbN988hanpolGTEP137TWsTr0WQtQ9E91txsxoQ8lCPGdkkfVMm6k51tD2X3R+3jqeB2zrorE4PQmzKuxeGq57T65HiewNN3h3m/B0dduDVtBal5DgRPnnUrw1wekEQwPBV+4+kN5X7dc0ZJCqg0QkzwdeGPu6qfjqgUXBITnsRphWLsWo8it4w/hl0xIPnLTEteuQGE1tsNHGJaoPYkb37Co55LYniqcUCdaSJDgbgfEFMOJKFB/M4VDaHf7XJzZA951BlAcxICT+/1J9OM3krCmWT2jk1xYiO5CRGvFEKIi0DQ7gAWIYRaWW64ycuiERtCbKavjCVrwP0zMrREUF0Bv3f+GBeknNEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(36756003)(86362001)(38100700002)(478600001)(41300700001)(8676002)(6486002)(8936002)(31686004)(82960400001)(31696002)(110136005)(316002)(6666004)(5660300002)(44832011)(6506007)(53546011)(6512007)(186003)(30864003)(26005)(2906002)(2616005)(66476007)(66556008)(66946007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndibGNaVVBkMUovNXg4SVBuaVBWMzZLZ2paM3ZCKzVNM3JmTy9nWEZlZVk1?=
 =?utf-8?B?K28vOTR0V2g5RVdoVkd5OXdtSktTaFZpZW40RkFodVM3U2tFckhvemhsMzRa?=
 =?utf-8?B?WGx3d0pBRERnQ0hrK0prSXpyTSsrL2JCSjhVSm5kbFRkSkt2MFN2dGRTbkcx?=
 =?utf-8?B?RFUvdnU3S1FuZzlpazR2d29wVXB5UUVISHpoc0IzdUxoQ1F5d0lMY0lORXFU?=
 =?utf-8?B?TnROSk9CWi9kYVorU2JkY0N6aThhcTRra2s4Nmh3Q3pyUGk4TDNVWThEay85?=
 =?utf-8?B?U3RlTEdMYVNWZCtmckJTZGZ1ZTMzN2h5TWJjNTVEWXA1eVlOOUJEUnJXMFlx?=
 =?utf-8?B?N0hlNFZjc0dHRDJSOWo5WmpRcVdRT3ppNkF4SXlmK3ZTRHluanNYVHB5T1Jl?=
 =?utf-8?B?TThmbHVTTCtvOU9ldU4ydG1KL3pCbUpyR3I2T00xVUZWSVZ1Y2tyM1VGWWJR?=
 =?utf-8?B?dHZtTHJ0WE1kbytoWVdScktkTWF4ZE5MZGN5WmpBM25tbEkxNkJ5S3dGQ2p1?=
 =?utf-8?B?aDMxYUIzdjluZ0hzc3A5OWd6aFV3UzJHQTlVeG1aeHp6QjhxYzdWZ1ZJeFhL?=
 =?utf-8?B?dHVnRGZRNDM5bmszRHYrRW84MHYrbjZERzBYSVJTbTBaNC9VYS9NMlFKdXVL?=
 =?utf-8?B?UTdteUpuV2UwVXRqOXdSK3lqTXFkVW1BUVZYMjhWaGRYZlppdWxBRTB2ZzlO?=
 =?utf-8?B?UVoxYTFCRG1wTitVOUJYZy9DK1M1TGYvMHZaK0pkd041aXFVWGx5cFliZCtq?=
 =?utf-8?B?ckgxMXJtUDN0L1V5YzROblkxOTRIdmU3QmxhTlAwSHFxdU5hZkxSSTMzVGJn?=
 =?utf-8?B?V2g4Qkt4aFJBSnVRSndqVHVKdE1HLzdXRDcyZmtsSVBzVEl2V0RoeVhpbm1C?=
 =?utf-8?B?c2FTNXgvSzM2Ung3bThFTXFnTWVMbFFXbWZiVk5meXdGQjRhS0puRU9iZk9u?=
 =?utf-8?B?U1FFY2NyM0liTWVHeC9TZXJqTmU2NnpTcTBBdW5hMmdZN0ZlblNoMDlxbDNG?=
 =?utf-8?B?VnE3eEkweEdCUUVJNXNBbHNnOFhUcXB1ZlpqdGZGOXBXUFZTR0RXd01XR1VZ?=
 =?utf-8?B?a090UVRuSm53eEgwVXFic2d0YlJ5MndNcFFBRTlkRWo1K3c2T2oxWWZqQ0Ni?=
 =?utf-8?B?NWVVb29mSFdiV2d5OC92ckRJZkN2RmVVTTZ5NTZQKzRTaUVKajBQcnVBMmlw?=
 =?utf-8?B?bzJ6NTIzUStTV05jWXllcGhVRkVaN3ppVTZwa1dRSWdOeUlBWVYxeXZoV00r?=
 =?utf-8?B?QW9KOUNaMDluam1xWWhDdEhYZTAwRzRjTzZGVlY0NDZmdnFKRE8xR3RlQ3RQ?=
 =?utf-8?B?ZmJReDJTMzBUZ09GMktEL2xRQlRFZjVyNzBsYmxtQldTbEtMZmJGc2tkc3B3?=
 =?utf-8?B?V1gwWCtNa1NYTVFqakpQNzM3ZDQ0RmF0Ri9HRnFZd0did0Joc2FQSzNQTzIy?=
 =?utf-8?B?RTB0SnN3clJUOGdkMGZvRzV6Y2d2dnpJU25XWlBFclVwc25rR0hZeC9vN2t6?=
 =?utf-8?B?L2YwMGRwb2pOVzVUazhvVDg5MmZiTitWRGRRY2VhN2M0bWNlQmU4S08zNktP?=
 =?utf-8?B?NVY4MzhMb3NYS2d4OUtDektmRnBLTDdScXVlRWRWdlp5RktmQ0JMTjVCMkxm?=
 =?utf-8?B?Vkh3WGxibDNhZ0VJZ0cwVUdiRmVPYURQZ0xmRVBPa05kUlVYdDFINCtRc1BK?=
 =?utf-8?B?QXVhS1JERXhWck8zOTdCYzdCdkEwTE9hVVhlRzF1Qm1jUmY4bE1xMXdnSm5V?=
 =?utf-8?B?empYaVJqYWdHTHM2MTJLWlZKK1p2UnUyU1NpZXVUMkhtYytMVFpUcWtYNDU5?=
 =?utf-8?B?Vm5kWUIxUjlSUnBjNUF5VXZkNHZ2VU4xeVhlb3BZaENNZ243ajRQWXd4OEZT?=
 =?utf-8?B?MmZ2OFFJWXJEU29GOFIxbGx2RkhYVmxFeXlMYkVwRFNuUURDQ2dLendiWjN5?=
 =?utf-8?B?QzZRQ1VyYXpRTHAvcDR3QzhFQVZRVXF4b1MzR1NHYW1oV1VKRDNMNFBEOTBz?=
 =?utf-8?B?NVUwdFM0R0hoMEsvRVBveTdFaS96QmVYU3lpbzd5VS9DQy9aY0pYeFh6cHh0?=
 =?utf-8?B?R2lGeG8vMmxNYWFCUlB0RjdISGpUN2JLaTdPVG9wNnB4elllTW9INkU1blZ4?=
 =?utf-8?Q?KdqCo/2b/CAO4mkr2ehzzD8Fk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f21730-80d3-40d9-bff4-08db6dce5162
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:28:30.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKIKiG+nAqjDy3zbgaFfHHYbIpZ+yclX5wWme7tvb6pxBGrY/BSs/jhndw8VBE/tL5o9rh6GroAjSLycljAeHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/15/23 11:12, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
>> On 6/14/23 12:16, ira.weiny@intel.com wrote:
>>> From: Navneet Singh <navneet.singh@intel.com>
>>>
>>> CXL devices optionally support dynamic capacity. CXL Regions must be
>>> created to access this capacity.
>>>
>>> Add sysfs entries to create dynamic capacity cxl regions. Provide a new
>>> Dynamic Capacity decoder mode which targets dynamic capacity on devices
>>> which are added to that region.
>>>
>>> Below are the steps to create and delete dynamic capacity region0
>>> (example).
>>>
>>>       region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
>>>       echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
>>>       echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
>>>       echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
>>>
>>>       echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
>>>       echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
>>>
>>>       echo 0x400000000 > /sys/bus/cxl/devices/$region/size
>>>       echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
>>>       echo 1 > /sys/bus/cxl/devices/$region/commit
>>>       echo $region > /sys/bus/cxl/drivers/cxl_region/bind
>>>
>>>       echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
>>>
>>> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
>>>
>>> ---
>>> [iweiny: fixups]
>>> [iweiny: remove unused CXL_DC_REGION_MODE macro]
>>> [iweiny: Make dc_mode_to_region_index static]
>>> [iweiny: simplify <sysfs>/create_dc_region]
>>> [iweiny: introduce decoder_mode_is_dc]
>>> [djbw: fixups, no sign-off: preview only]
>>> ---
>>>    drivers/cxl/Kconfig       |  11 +++
>>>    drivers/cxl/core/core.h   |   7 ++
>>>    drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
>>>    drivers/cxl/core/port.c   |  18 ++++
>>>    drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
>>>    drivers/cxl/cxl.h         |  28 ++++++
>>>    drivers/dax/cxl.c         |   4 +
>>>    7 files changed, 409 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>>> index ff4e78117b31..df034889d053 100644
>>> --- a/drivers/cxl/Kconfig
>>> +++ b/drivers/cxl/Kconfig
>>> @@ -121,6 +121,17 @@ config CXL_REGION
>>>    
>>>    	  If unsure say 'y'
>>>    
>>> +config CXL_DCD
>>> +	bool "CXL: DCD Support"
>>> +	default CXL_BUS
>>> +	depends on CXL_REGION
>>> +	help
>>> +	  Enable the CXL core to provision CXL DCD regions.
>>> +	  CXL devices optionally support dynamic capacity and DCD region
>>> +	  maps the dynamic capacity regions DPA's into Host HPA ranges.
>>> +
>>> +	  If unsure say 'y'
>>> +
>>>    config CXL_REGION_INVALIDATION_TEST
>>>    	bool "CXL: Region Cache Management Bypass (TEST)"
>>>    	depends on CXL_REGION
>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>> index 27f0968449de..725700ab5973 100644
>>> --- a/drivers/cxl/core/core.h
>>> +++ b/drivers/cxl/core/core.h
>>> @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
>>>    
>>>    extern struct attribute_group cxl_base_attribute_group;
>>>    
>>> +#ifdef CONFIG_CXL_DCD
>>> +extern struct device_attribute dev_attr_create_dc_region;
>>> +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
>>> +#else
>>> +#define SET_CXL_DC_REGION_ATTR(x)
>>> +#endif
>>> +
>>>    #ifdef CONFIG_CXL_REGION
>>>    extern struct device_attribute dev_attr_create_pmem_region;
>>>    extern struct device_attribute dev_attr_create_ram_region;
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index 514d30131d92..29649b47d177 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>>> @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>>>    	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>>    	struct resource *res = cxled->dpa_res;
>>>    	resource_size_t skip_start;
>>> +	resource_size_t skipped = cxled->skip;
>>>    
>>>    	lockdep_assert_held_write(&cxl_dpa_rwsem);
>>>    
>>>    	/* save @skip_start, before @res is released */
>>> -	skip_start = res->start - cxled->skip;
>>> +	skip_start = res->start - skipped;
>>>    	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
>>> -	if (cxled->skip)
>>> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
>>> +	if (cxled->skip != 0) {
>>> +		while (skipped != 0) {
>>> +			res = xa_load(&cxled->skip_res, skip_start);
>>> +			__release_region(&cxlds->dpa_res, skip_start,
>>> +							resource_size(res));
>>> +			xa_erase(&cxled->skip_res, skip_start);
>>> +			skip_start += resource_size(res);
>>> +			skipped -= resource_size(res);
>>> +			}
>>> +	}
>>>    	cxled->skip = 0;
>>>    	cxled->dpa_res = NULL;
>>>    	put_device(&cxled->cxld.dev);
>>> @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>>>    	__cxl_dpa_release(cxled);
>>>    }
>>>    
>>> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
>>> +{
>>> +	int index = 0;
>>> +
>>> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
>>> +		if (mode == i)
>>> +			return index;
>>> +		index++;
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>>    static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>>    			     resource_size_t base, resource_size_t len,
>>>    			     resource_size_t skipped)
>>> @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>>    	struct cxl_port *port = cxled_to_port(cxled);
>>>    	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>>    	struct device *dev = &port->dev;
>>> +	struct device *ed_dev = &cxled->cxld.dev;
>>> +	struct resource *dpa_res = &cxlds->dpa_res;
>>> +	resource_size_t skip_len = 0;
>>>    	struct resource *res;
>>> +	int rc, index;
>>>    
>>>    	lockdep_assert_held_write(&cxl_dpa_rwsem);
>>>    
>>> @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>>    	}
>>>    
>>>    	if (skipped) {
>>> -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
>>> -				       dev_name(&cxled->cxld.dev), 0);
>>> -		if (!res) {
>>> -			dev_dbg(dev,
>>> -				"decoder%d.%d: failed to reserve skipped space\n",
>>> -				port->id, cxled->cxld.id);
>>> -			return -EBUSY;
>>> +		resource_size_t skip_base = base - skipped;
>>> +
>>> +		if (decoder_mode_is_dc(cxled->mode)) {
>>
>> Maybe move this entire block to a helper function to reduce the size of
>> the current function and reduce indent levels and improve readability?
> 
> :-/
> 
> I'll work on breaking it out more.  The logic here is getting kind of
> crazy.
> 
>>
>>> +			if (resource_size(&cxlds->ram_res) &&
>>> +					skip_base <= cxlds->ram_res.end) {
>>> +				skip_len = cxlds->ram_res.end - skip_base + 1;
>>> +				res = __request_region(dpa_res, skip_base,
>>> +						skip_len, dev_name(ed_dev), 0);
>>> +				if (!res)
>>> +					goto error;
>>> +
>>> +				rc = xa_insert(&cxled->skip_res, skip_base, res,
>>> +								GFP_KERNEL);
>>> +				skip_base += skip_len;
>>> +			}
>>> +
>>> +			if (resource_size(&cxlds->ram_res) &&
>                                                    ^^^^^^^
> 						  pmem_res?
> 
>>> +					skip_base <= cxlds->pmem_res.end) {
> 
> The 2 if statements here are almost exactly the same.  To the point I
> wonder if there is a bug.
> 
> Navneet,
> 
> Why does the code check ram_res the second time but go on to use pmem_res
> in the block?
> 
>>> +				skip_len = cxlds->pmem_res.end - skip_base + 1;
>>> +				res = __request_region(dpa_res, skip_base,
>>> +						skip_len, dev_name(ed_dev), 0);
>>> +				if (!res)
>>> +					goto error;
>>> +
>>> +				rc = xa_insert(&cxled->skip_res, skip_base, res,
>>> +								GFP_KERNEL);
>>> +				skip_base += skip_len;
>>> +			}
>>> +
>>> +			index = dc_mode_to_region_index(cxled->mode);
>>> +			for (int i = 0; i <= index; i++) {
>>> +				struct resource *dcr = &cxlds->dc_res[i];
>>> +
>>> +				if (skip_base < dcr->start) {
>>> +					skip_len = dcr->start - skip_base;
>>> +					res = __request_region(dpa_res,
>>> +							skip_base, skip_len,
>>> +							dev_name(ed_dev), 0);
>>> +					if (!res)
>>> +						goto error;
>>> +
>>> +					rc = xa_insert(&cxled->skip_res, skip_base,
>>> +							res, GFP_KERNEL);
>>> +					skip_base += skip_len;
>>> +				}
>>> +
>>> +				if (skip_base == base) {
>>> +					dev_dbg(dev, "skip done!\n");
>>> +					break;
>>> +				}
>>> +
>>> +				if (resource_size(dcr) &&
>>> +						skip_base <= dcr->end) {
>>> +					if (skip_base > base)
>>> +						dev_err(dev, "Skip error\n");
>>> +
>>> +					skip_len = dcr->end - skip_base + 1;
>>> +					res = __request_region(dpa_res, skip_base,
>>> +							skip_len,
>>> +							dev_name(ed_dev), 0);
>>> +					if (!res)
>>> +						goto error;
>>> +
>>> +					rc = xa_insert(&cxled->skip_res, skip_base,
>>> +							res, GFP_KERNEL);
>>> +					skip_base += skip_len;
>>> +				}
>>> +			}
>>> +		} else	{
>>> +			res = __request_region(dpa_res, base - skipped, skipped,
>>> +							dev_name(ed_dev), 0);
>>> +			if (!res)
>>> +				goto error;
>>> +
>>> +			rc = xa_insert(&cxled->skip_res, skip_base, res,
>>> +								GFP_KERNEL);
>>>    		}
>>>    	}
>>> -	res = __request_region(&cxlds->dpa_res, base, len,
>>> -			       dev_name(&cxled->cxld.dev), 0);
>>> +
>>> +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
>>>    	if (!res) {
>>>    		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>>> -			port->id, cxled->cxld.id);
>>> -		if (skipped)
>>> -			__release_region(&cxlds->dpa_res, base - skipped,
>>> -					 skipped);
>>> +				port->id, cxled->cxld.id);
>>> +		if (skipped) {
>>> +			resource_size_t skip_base = base - skipped;
>>> +
>>> +			while (skipped != 0) {
>>> +				if (skip_base > base)
>>> +					dev_err(dev, "Skip error\n");
>>> +
>>> +				res = xa_load(&cxled->skip_res, skip_base);
>>> +				__release_region(dpa_res, skip_base,
>>> +							resource_size(res));
>>> +				xa_erase(&cxled->skip_res, skip_base);
>>> +				skip_base += resource_size(res);
>>> +				skipped -= resource_size(res);
>>> +			}
>>> +		}
>>>    		return -EBUSY;
>>>    	}
>>>    	cxled->dpa_res = res;
>>>    	cxled->skip = skipped;
>>>    
>>> +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
>>> +		int index = dc_mode_to_region_index(mode);
>>> +
>>> +		if (resource_contains(&cxlds->dc_res[index], res)) {
>>> +			cxled->mode = mode;
>>> +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
>>> +				cxled->cxld.id, cxled->dpa_res, cxled->mode);
>>> +			goto success > +		}
>>> +	}
>>
>> This block should only happen if decoder_mode_is_dc() right? If that's
>> the case, you might be able to refactor it so the 'goto success' isn't
>> necessary.
> 
> I'll check.  I looked through this code a couple of times in my review
> before posting because I'm not 100% sure I want to see 8 different modes
> DC decoders and regions.
> 
> I think the 'mode' should be 'DC' with an index in the endpoint decoder to
> map DC region that decoder is mapping.  But that change was much bigger to
> Navneets code and I wanted to see how others felt about having DC0 - DC7
> modes.  My compromise was creating decoder_mode_is_dc().
> 
>>
>>>    	if (resource_contains(&cxlds->pmem_res, res))
>>>    		cxled->mode = CXL_DECODER_PMEM;
>>>    	else if (resource_contains(&cxlds->ram_res, res))
>>> @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>>    		cxled->mode = CXL_DECODER_MIXED;
>>>    	}
>>>    
>>> +success:
>>>    	port->hdm_end++;
>>>    	get_device(&cxled->cxld.dev);
>>>    	return 0;
>>> +
>>> +error:
>>> +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
>>> +			port->id, cxled->cxld.id);
>>> +	return -EBUSY;
>>> +
>>>    }
>>>    
>>>    int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>> @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>>>    	switch (mode) {
>>>    	case CXL_DECODER_RAM:
>>>    	case CXL_DECODER_PMEM:
>>> +	case CXL_DECODER_DC0:
>>> +	case CXL_DECODER_DC1:
>>> +	case CXL_DECODER_DC2:
>>> +	case CXL_DECODER_DC3:
>>> +	case CXL_DECODER_DC4:
>>> +	case CXL_DECODER_DC5:
>>> +	case CXL_DECODER_DC6:
>>> +	case CXL_DECODER_DC7:
> 
> For example this seems very hacky...

Not sure if it helps, but you can always do:
case CXL_DECODER_DC0 ... CXL_DECODER_DC7:

DJ

> 
> [snip]
> 
>>>    
>>> +/*
>>> + * The region can not be manged by CXL if any portion of
>>> + * it is already online as 'System RAM'
>>> + */
>>> +static bool region_is_system_ram(struct cxl_region *cxlr,
>>> +				 struct cxl_region_params *p)
>>> +{
>>> +	return (walk_iomem_res_desc(IORES_DESC_NONE,
>>> +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>>> +				    p->res->start, p->res->end, cxlr,
>>> +				    is_system_ram) > 0);
>>> +}
>>> +
>>>    static int cxl_region_probe(struct device *dev)
>>>    {
>>>    	struct cxl_region *cxlr = to_cxl_region(dev);
>>> @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
>>>    	case CXL_DECODER_PMEM:
>>>    		return devm_cxl_add_pmem_region(cxlr);
>>>    	case CXL_DECODER_RAM:
>>> -		/*
>>> -		 * The region can not be manged by CXL if any portion of
>>> -		 * it is already online as 'System RAM'
>>> -		 */
>>> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
>>> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>>> -					p->res->start, p->res->end, cxlr,
>>> -					is_system_ram) > 0)
>>> +		if (region_is_system_ram(cxlr, p))
>>
>> Maybe split this change out as a prep patch before the current patch.
> 
> That seems reasonable.  But the patch is not so large and the
> justification for creating a helper is that we need this same check for DC
> regions.  So it seemed ok to leave it like this.  Let me see about
> splitting it out.
> 
> [snip]
> 
>>> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
>>> index ccdf8de85bd5..eb5eb81bfbd7 100644
>>> --- a/drivers/dax/cxl.c
>>> +++ b/drivers/dax/cxl.c
>>> @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
>>>    	if (!dax_region)
>>>    		return -ENOMEM;
>>>    
>>> +	if (decoder_mode_is_dc(cxlr->mode))
>>> +		return 0;
>>> +
>>>    	data = (struct dev_dax_data) {
>>>    		.dax_region = dax_region,
>>>    		.id = -1,
>>>    		.size = range_len(&cxlr_dax->hpa_range),
>>>    	};
>>> +
>>
>> Stray blank line?
> 
> Opps!  Fixed!
> 
> Ira
