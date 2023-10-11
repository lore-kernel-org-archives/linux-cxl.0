Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFB21110
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYXNRpAE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A96A9
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697060612; x=1728596612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gB9sHwa0ix4MibX+2wq9s2WzOqLeZzyzTG0nals8njk=;
  b=KYXNRpAEMln546TFDRqbAAXDt1FlxE2SmM48M2Nmii+ixXDpM0BoKT9I
   sM0RGlU3oV0KpdcZqbzvuEQDM9VRvTjuiLnbc5j9fFnqtBvFd4zyjhQa1
   SwOM6PjQiZ38Gvnp5pmI788rurZmVaCl/adK62vtmFGBhkp10+XiNnBwH
   qiFaY7qrngrIjXrbh8Qsu6l73d2C+WOFNLLSk3huGeVkh8XE9iBoLC9xV
   rKEqQQL1w+XBqVPuFjCsXg9FTqgwdpfYgBhjVY/pVp0UMjxiZ8oBs27ZS
   Gp8VqpJEwD5pnSBYOq7D846QpYQn2/hynM+8YXCYrnk7dlBDXfb9cVgOH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384625514"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="384625514"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 14:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="819879009"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="819879009"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 14:43:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 14:43:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 14:43:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 14:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwvtoKpgSLfgSn0vU6t6cLLmKWN6i5ahnrGe0GNYUe3zcUq2hKYFd0zWuM6DjwKKPf+6ixlRFrtl2SOfpG3apBkkcUu+Yg47toQVTOCI0+OmTuIbPE7QcTlV9gJeaP8NT8dyohPgxAldIYh4B5MZg7s3zWBJJlutZ7Q0XqjQECKV5Cvnos09ababiONEt5lQcfpbvd/Xp7mq8sfMHSQM4YOnyuVvCmZItekmWeYc/9PCj9Rhr1qblpLako7DBzARD8kn2Ovoc/uhR3Wbw4Y1bQxEajb241dpDw0aBOoMuuoOup5PCRyEHkDxXo2aCtRZSMil8NWn0CMelO24l0m68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YX/L2KBnEnHkaz36iCBq5AnTmoOsYOGNA+gNg5yZ8U=;
 b=AcpC9rq4DXBnIKQDJeFJuDBZ0bnznRmOVlq+XfKgek8h3letFKe1ejHS8CrIBgoU5iRIu1N/6j5lUvGBty3fY/Xhs398oArZUAIK5djMcv2VfuchFSFRe1Kyx1IT3qxlnPU4rQsYX+bQmKYVPngKhE8GUhvVJbRnoqHjvqzC36k431fr8nMq9Q291lweLNFAHZZoJMsE4SaTxLY+uNWr6il3OXZBwhta5AjC8CjS+fPmbeYTMdslMjNY8PKY4mriayJPhE0rtNflgTsK7/3LdmRo0J2QmsKLe34pr5fssxN/pV8G3ZcQZsO7XrJcid6+ROKy0jDeUHupD8052hF1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 21:43:17 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 21:43:17 +0000
Message-ID: <48be28cb-ed68-45c4-a271-bf9492c75eb4@intel.com>
Date: Wed, 11 Oct 2023 14:43:14 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v10 21/22] cxl: Export sysfs attributes for memory device
 QoS class
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
 <169698642598.1991735.4883136743132463123.stgit@djiang5-mobl3>
 <20231011142626.00002b16@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231011142626.00002b16@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4a0000-dd54-4c1b-eb1e-08dbcaa31479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptdWaYrFEwtZ1ZV5X78s3KgfinmV8cUmLO2kwxVz8cMXffvus55vH2gc6IpIFa1Bw2Zo91c0UJjgMww39r9GyifPVOmhjAmB+y/F4kAVHSep1enp7a+pPlbVfSLScKNjpi23N1br1ZtUEL8l7pXDC/MdqaAcKND/bvD3gaGLlWBYDVdMg728vrDtAGZG577KbS/aHtdL3nMGJDvkLMnkLjZ/txWeGafeLnthdpakVp8vCbYZRQi2l9lldxS252cM4LxyIK2oaMfYNdpGVyZ/f/H6qMadxu6xZTpGZUJHQ95xTtOoXyAavFh4XSLX3r/r2oWTNd2qpGaqlevD5Qn5J8DPwaLQY6V/QmL4WbSsMhbanQHBgL6PpchnkbCw+uEQZgOf9UPAtNI540XAUObaf0ejiPYw/Wge9w4KcNevNLoohMhXCRszEruTiIKzBtGpOaEBgAwFS7zs8dhhAh5Uki6o6qho5hvV8k1eLep1gBcK+W7iNc8C0Q9OdHeJrqIMfwf6MWQLpFCJay9b9vu0FSYjUEs1/3+3R113Uc5/omMvfoKXrA88ikWtO2cMND6l6aIYz3q+87q4aWO8YPFysM3P7mUBJzi+5JgsHlnEFVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82960400001)(31696002)(38100700002)(86362001)(36756003)(31686004)(66899024)(53546011)(6916009)(2906002)(6486002)(41300700001)(6512007)(478600001)(6506007)(5660300002)(44832011)(8936002)(4326008)(316002)(83380400001)(966005)(66946007)(66476007)(66556008)(6666004)(8676002)(26005)(2616005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVSWStHVFFmUnAwTWhJNVI0ckZOUlhrSHlqOEcvZ09JMmxEaXEydzRxY3NJ?=
 =?utf-8?B?TW5yRjVROTg5eDJQWlQrUXFTQkJ5MGxTWXFwRmNNWlVKQXIyTEJxQVpFM2RW?=
 =?utf-8?B?Qy9rZ3FiaUppUWRpQWhWM3FhSS9FamdjejcyQ3p3RlVoWUJFc0k2THUwc3RV?=
 =?utf-8?B?WVFDTnRpYU8wTks3UUplalBVSFhoQW9DQWtqMWN5ckNqMG8vdHIvNmNsQWxw?=
 =?utf-8?B?UkJXSlJ4S0M5aFVZZlQ3YTRWTlltT0FQc0VrSU8zOEJ6aXBXdTZaYUVZNTBm?=
 =?utf-8?B?MitNeE83cjN5RTRHRjJuOFk1a2tzOSsxVUxmbytNak90VzloN1A2SDM3K3l3?=
 =?utf-8?B?dDZCNndTNmh6NndMaDdVQWJqYkNBZ2xUd3pPT1JpK1JyOWRuaC9NRGxpaXQ2?=
 =?utf-8?B?aHNoeXJrNXFxRnNrdmRrdG1vbVpFa2RCblJ2THkwVXBoSnB4dnIweU4ydDNx?=
 =?utf-8?B?Qlora2t6b0hnQjFFNFQwdlZCVXBLOHpyYUhGTFNCbEtLYzI2Z2hkV2hNSEl2?=
 =?utf-8?B?Qko5eEdDcEZHdndMbkRsUzlrSlV1dS9xK1M5QllTc3R0alVrN0hHcEdWRWVa?=
 =?utf-8?B?YWdiRDFJc1J3b0RGc00xQVZGeGpxKzcrWkdqMENMNHA3RzN6YU1Sd0NlTXVX?=
 =?utf-8?B?aWRNUXFHT3Bzb2pEejRXaUtHTnlXQ0M0WmErZWJMWTVuQzd4YkVUVFJvZUQ4?=
 =?utf-8?B?ZHRSZGdWYnZIc1p6YmtOV3JQQ0FZdjhyUldQNzIrYzRFdjRDa25PR3ROd0FF?=
 =?utf-8?B?NGpSTHRhUFVjbnpmZlg0ekRoelQwaEVrRzUyNlRLVWVpa3VXbFZMMzlxbFRr?=
 =?utf-8?B?a1RTdUkrQjczNzQwYTBCeFZ1eXRCVmdXTXZSU0VLK0Z2aWdFY1c2bHYyb3c4?=
 =?utf-8?B?WE1xdmQ4RU5NT09lOHZyeUNQNCsxNzEyY0NnWkZIK1BPQzdHNGZSbXpickpl?=
 =?utf-8?B?ZSs5Q3h2REhSQXord2YxMStIakNuWGJJMlVNbnlrN2s1MmsvMWVZU2JhbDFY?=
 =?utf-8?B?VlF5VVdyMm5zK2RTWUhyVkFKbmV5VjV4S1pWYkFXYU1mSFlNM0FUQ0VWeUJl?=
 =?utf-8?B?QlA5RTdMb2VOdXJnRWk4ejBaMEVVSCswMC9RbkJiZGdnRUJMZzFTR1FDQlYr?=
 =?utf-8?B?ZndpOUhjaC95WUg4STA4RlVlRFhDMS92QmRXbzYvc3hmc3BNbDd6a3BsMXJ0?=
 =?utf-8?B?MjNaM3dGYnhxM2NVbXFuRE5UNDhpbDdTQlBRRXk5eUtsNy8vRmYzUExCcDNk?=
 =?utf-8?B?NEtUSG9jM2ZpSHBXb0tzcFhCUEpFNFA1WWlsdUZkTk5WdVhHY3J1YUlrZGRV?=
 =?utf-8?B?MkJkeGJOUjdBZHRpenhwNmhvc1BHU3hWbE1ncFNqN2tvbW9DK3I4SXkrYzhS?=
 =?utf-8?B?NHJ4aVhrTzMyTC9hL0JBN2dtRXRrYjY4MjE0dEI3bjRiV1d0UElGNi85cXlq?=
 =?utf-8?B?ZUNXZENHRnQ0bzRRbjR6NlpGbUNkclg4a1V3VzBVdC95Z21WUzJIbzBITTYz?=
 =?utf-8?B?cTlRU29kUFc3RitmZS9xQlBjaWZlUEw2NGNmZ2xSeTcxdDU2ZTg5amtEaUc1?=
 =?utf-8?B?bG5qMVRMMmI3aUVWbExpNzZVNi9ueUE0ZEFWVjJrK1RwR1VMUWR6U21xcWcr?=
 =?utf-8?B?ZmZHUzZxY2k5aDdQcVFuenBhbHFLa3prL09UdU1YTzFSM2FvRGt5WEdVaVlN?=
 =?utf-8?B?YlN5NGFoeFk2RG4rOUIvK0hNT1hnT1ZkZnh1V21VamlnTEZ2REx6TlFnR2hC?=
 =?utf-8?B?SFJlZHNyQ0JqRDFTNDRRNUxIUFhuVHRob2g2dVIrVmlTU216ZUc2TTQ3R1VX?=
 =?utf-8?B?QzZpbHU4STNoTE1wWTZZWEdlUVQrVmF3N1U4aHhTS0hyMTRhaU12SUlXOHUw?=
 =?utf-8?B?NExsQ1kyUWg2V0wvUG5SWUNNallVcUYvQ2tIVGk0YS9vd01EN1FtQjgwQktN?=
 =?utf-8?B?WDY0MlFhWXNuaVIydUN1Y3dETnd0MXJTS3NYSk5LRUs0RmZQQjJ0Qld5WGtS?=
 =?utf-8?B?ZjRnL1pGczdXOUJPN2ZDUWtSU25OK1NWRWZyUng4NndMT3k2aE5DYWQxQVRs?=
 =?utf-8?B?V1N0QmhmWmp6d09vTXh5aUN3Y1c2dVRpYkgwWHN4cTdLTWowTTd2SXcxaWxm?=
 =?utf-8?Q?/eicQ6mclHeLr0kfq8caTs4Us?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4a0000-dd54-4c1b-eb1e-08dbcaa31479
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 21:43:17.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qejX8xBaE6oB2MkpGerFFAaYu8YpseRlFFiu+duCUd981qagQq33v8Ix2ykF/+L4RBJBrTQfVPO0MoW4XvirBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 06:26, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 18:07:06 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
>> should show up as /sys/bus/cxl/devices/memX/ram/qos_class0 for the volatile
>> partition and /sys/bus/cxl/devices/memX/pmem/qos_class0 for the persistent
>> partition. The QTG ID is retrieved via _DSM after supplying the
>> calculated bandwidth and latency for the entire CXL path from device to
>> the CPU. This ID is used to match up to the root decoder QoS class to
>> determine which CFMWS the memory range of a hotplugged CXL mem device
>> should be assigned under.
>>
>> While there may be multiple DSMAS exported by the device CDAT, the driver
>> will only expose the first QTG ID per partition in sysfs for now. In the
>> future when multiple QTG IDs are necessary, they can be exposed. [1]
> 
> I'm not sure this will extent cleanly if we get a two dimensional set to describle
> 1) Multiple DSMAS entries for RAM (so multiple inputs to pass to the _DSM)
>    One nice thing here might be to ensure we have the first one seen.
>    So if in future we do need to extent it this corresponds to the 0th one
>    described.
> 2) Want to describe less ideal QTG values from _DSM 
> 
> 
> Maybe it's too early to come to any conclusion and the single 0 is enough.
> The cynic in me suggests we call it. qos_class0_0 though to give us the space.
> If we needs DSMAS ranges, then we describe those using first index,
> and second is the priority index if we have multiple answers from _DSM.
> For now it's always 0_0

I talked to Dan and it seems he prefers the simplest form for the current version until we have a need to move towards something more complex. So qos_class0 -> qos_class. We can move to qos_classN_M when there is a need.


> 
> 
> Jonathan
> 
>>
>> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v10:
>> - Export only qos_class0, the first entry. Additional qos_class entries can be
>>   exported later as needed. (Dan)
>> - Have the sysfs attrib return -ENOENT unless driver is attached. (Dan)
>> - Removed Jonathan's review tag due to code changes.
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++++++++++++++
>>  drivers/cxl/core/memdev.c               |   34 +++++++++++++++++++++++++++++++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 44ffbbb36654..dd613f5987b5 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -28,6 +28,23 @@ Description:
>>  		Payload in the CXL-2.0 specification.
>>  
>>  
>> +What:		/sys/bus/cxl/devices/memX/ram/qos_class0
>> +Date:		May, 2023
>> +KernelVersion:	v6.7
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) For CXL host platforms that support "QoS Telemmetry"
>> +		this attribute conveys a comma delimited list of platform
>> +		specific cookies that identifies a QoS performance class
>> +		for the volatile partition of the CXL mem device. These
>> +		class-ids can be compared against a similar "qos_class"
>> +		published for a root decoder. While it is not required
>> +		that the endpoints map their local memory-class to a
>> +		matching platform class, mismatches are not recommended
>> +		and there are platform specific performance related
>> +		side-effects that may result. First class-id is displayed.
>> +
>> +
>>  What:		/sys/bus/cxl/devices/memX/pmem/size
>>  Date:		December, 2020
>>  KernelVersion:	v5.12
>> @@ -38,6 +55,23 @@ Description:
>>  		Payload in the CXL-2.0 specification.
>>  
>>  
>> +What:		/sys/bus/cxl/devices/memX/pmem/qos_class0
>> +Date:		May, 2023
>> +KernelVersion:	v6.7
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) For CXL host platforms that support "QoS Telemmetry"
>> +		this attribute conveys a comma delimited list of platform
>> +		specific cookies that identifies a QoS performance class
>> +		for the persistent partition of the CXL mem device. These
>> +		class-ids can be compared against a similar "qos_class"
>> +		published for a root decoder. While it is not required
>> +		that the endpoints map their local memory-class to a
>> +		matching platform class, mismatches are not recommended
>> +		and there are platform specific performance related
>> +		side-effects that may result. First class-id is displayed.
>> +
>> +
> 
> 
