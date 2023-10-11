Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288562031D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAxFHnZJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3520292
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697038677; x=1728574677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IJ2G2lfhR66x5SBzrFkv2HGvfNB5/4dUIInGHXyU/g4=;
  b=fAxFHnZJvm6JMT1NllTsYAGtGOvW/aAhIdMm21vL7TZemt6GCrCJzgy9
   9E78b2xgB53KHRIU8uUytYamklnMkuMgCOb8bu829ejVCH7s4Hx63uufm
   Hm8iWGHkv0Bg6KI58M8oGpGL3wMOVMm4uXODFYsSLewqmBKJ1vuip/OPj
   mkfd+pZaskNPXZlwcrniJ6wv7W0zuLOqKVBlHSFxo9YkQCQh9RMS8zzQV
   9xS9wTYmsTyFU1ZtNaenrgyQjYSNYQ8OBTOUWmpx1nTEoK+AAHpN3Yo8+
   1FieASyhLfeuz/ltH7ozZboc9Nd8iF4YhEEhbydFMIMTadLnpW6sdZvQA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3285973"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="3285973"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 08:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747502846"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="747502846"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 08:37:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:37:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 08:37:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 08:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8iKHBb6yjMTaJjG8wUZA2GN615oy85J7x8u2fUfouJAouP8iA7lp60kRS4K7oTT9V8SsBnezSPHVR3rIwp06BVoLHkdjCiHXRe7M0kDrRYJlMFCNTpO9GCwBiiiwJwfXAzidMylhYomauRAQ9M50lbbYG4LY80dVKr8JY/7x8pWoQUbSF8XLLVrVF0C8QE1UZSW/cmdlUG4x3aa01rcKkhJ6I5Q34Vry300XzOXo6lXEX04omHOCUxdeCcBf6KALCmxev1GX6bHUFwD904GTeS71i7pwd4z3gd1dRFQAfpLFN9T0+xe64AwnFn5y3r3+twExmMortex2ZC6oMsndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orRxVyU7JiaswGAen8YLmVhK6pCxJirGO/7AJZXiWYM=;
 b=IYq0DxownyLZjFyAK+Mzxgzf8wMjZGYoKjk79NF5VKOfP5QBUPwsxA4q6RwvpnK1fvM+vbBAM2m2W140pBr2xsozdMWa9FhRIc3rlmjTd9GgyadNJa+XMl91NwhrZ3eHiWRBdayTCXBr4lnxaK3WRq/M38jlij3f38dpS4AxbTcc/gF/sfkC+xBypxVpZI6zw2PURAQIbTK6H/5fPLi2RzFRJIOZKCX/OuwTA6WnHuJ4aKT6SCsWnaza/4rFbn1w/Ih1ELRHJdZlBOFQ69w6MEpjVGnfN3c72Vm4vTXLTzOtaFfW5rqDcJ3cfbfa/O9s0ua3wxN4aMeOTJzuBzp+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 15:37:11 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 15:37:11 +0000
Message-ID: <f05d4697-feeb-4e60-a319-5816d9487bc0@intel.com>
Date: Wed, 11 Oct 2023 08:37:08 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v10 15/22] cxl: Add support for _DSM Function for
 retrieving QTG ID
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
 <169698638898.1991735.17757157241242765633.stgit@djiang5-mobl3>
 <20231011141052.00002156@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231011141052.00002156@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 907c37ca-f285-4d9d-d483-08dbca6fef5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IZuwgpzytqnNkWy546MLacoW6DC8m0bVtafmwvIxRl7a27IMWMulkwZpZiPiZIL1FrWUtysjyrQrpDg55Zkk1VSV99TYrZ/L6AyrUuYqQANvDv31+5+v9YZMLecj8j5oTOvmR/71/YnahjECPwdPv+JJDP8YrtExSkJwvXtNRWvCsabSKIOwfoGCnTrGfYROS0puCXqmQRQ8gDsgU2WVQmT8ITd2RVcXan0PS2D2eooDH/111fOE5rkwvQFCi90Ob7sssZsjf+GMQcsbdl701aHoQqThjsW73Emh6h9bIrIZ5D8JgpsEMsFZ16TF8nnYz1oM6w3DsoNgKxE3lzH7AhI9iHyVuPr26ZLcfqXr9o+sQAesT5VxZ4lxO7j3cUnM+dbudz1o4yrh5fGJ6Bknvvptz04+awn/AFAg10cSfLaQGyzndzGrofKQ1HohFYa3RNnDiJr9LxEo3OXLIQe37i9u5d2eDxHhGAyRebO0w0FOhD9ZRXz98ZNZeDFhy3fWXRkPCaPuujttGigmqqDvmKzSyiTNVz2ceMovSyPKEJ/JGR3wDP2ybe6DDSWyXKUN4tBkOqRrKG8CJj3o59PEoo2AEgPNMwWh9QQ2yVXhoCW/3uWDeTcL+ODyj+XSw7u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82960400001)(4326008)(8676002)(8936002)(2906002)(6486002)(31686004)(44832011)(5660300002)(6666004)(31696002)(86362001)(478600001)(6506007)(53546011)(6512007)(41300700001)(36756003)(38100700002)(83380400001)(316002)(66946007)(6916009)(26005)(66476007)(66556008)(2616005)(66899024)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzIweDF2bFNBN09KRk5DUThVaTJnQjlrdCtsNFE4MEZXallBVlNsLzZYREpZ?=
 =?utf-8?B?TkpaWFNycWViUVRkdU5aNlZKM3loR0lSWmNBRVpkdmNNRVZjN0NQMGF5T2o5?=
 =?utf-8?B?K1E3VExIb2R0cTlUWkcrTkUvcU4rMk1RTmlCSEV5VVdRQUV1K2NLbnhmUERD?=
 =?utf-8?B?WmRmdTRFcGI5VHk3a1pPTHhTRERwWGdieDlVQ0p0NjJWelpxSXZFUm81KzNZ?=
 =?utf-8?B?K1Y2VnRpWTN4dzV4YkVFYzk2YlBSUW1zeWdCY1MzcWd4OVc1TG9iUFZRL3k4?=
 =?utf-8?B?aTFSeEQ0YkZUTjEzRmw3SjVDcjNhcXlGcnVYUEgydjl5QnBXMHFLeFdpL0cz?=
 =?utf-8?B?QkxpWXlCaW9MUHJMZm1JbVd4YVFRVkNSTXU0QmZKeEp0dk9rak1sSlZGcTc3?=
 =?utf-8?B?RDMvdE5OQTZJZEIvekE1WExtUGNLb0w4MGZMMWV4NC9zQWxTNzB5OUhoc1Mr?=
 =?utf-8?B?TVZLdzBDbFlNb1czRVRJY2JaQW9oWFpuRDEyYjNWQ1dMT0xTQ1hZYTJBelJE?=
 =?utf-8?B?K1ZKbkE4bkxMNkVjSU5xWjBxbFFCT3ltYjM5WXN2TXIzZ1BZOVlJQ0lWQlpq?=
 =?utf-8?B?L0ZPLy9TdDFJUUhjT1NqbTFXeWYrSkg0ZmZ4TG82ek5GbWJLcGtjT0dMc3ZK?=
 =?utf-8?B?RHRTZkJYRm0zRnRzektwbGhncURHUGozcTlXZ2dFdy9uUGp3U0ZWeHlBMU5x?=
 =?utf-8?B?blptVE1naFQ2QjNHcjNqY0p6RW01bi80aGZrUENkK2VsZmJVdkFqSlVrRFQw?=
 =?utf-8?B?akVvR1Y0WmNjQUw5QmJGUDhOR1lLYjZsa0ZGcTFQUW1KcGdzZXkwbGVxRmRz?=
 =?utf-8?B?L1lNR1dQSjAyMUpLSzhad2VTSmk4d2tHcUJhVGF1VFd4RU9WWjV1c1JRUVZi?=
 =?utf-8?B?Q011WWh2dXIwWGdXVWdvZFNINkhseTRXVEE5Uk9yZmc5OS9kZ2g4aXpSc1R4?=
 =?utf-8?B?QU9HY0ovN285UGtNV2FreGp2VXBqMXJWbU1QdTI1bmE2dDJod2lwZkV1N3FE?=
 =?utf-8?B?N21PSUR0RFhiS1RVVWFRUkpIdFl4dzRSYWVPalhkRlc1Nnd1MkhpeHpsUjBW?=
 =?utf-8?B?aVMxeVh2WExMdEljcVB3MEhyK1cvbFBSZ1Vla0p3REYrYVJRZnNiYWpNUlhB?=
 =?utf-8?B?QnhWSnI5WmJFd3lJRWdaMFdOSGNHMXNNRU0yUmxMVWd2OGUvMmwySmJHNXdy?=
 =?utf-8?B?TEJYMmxQeVU2SXUxTHFWcWd0VWlXQW1yWFA3UUEvRXM3NGovY0NiWlFCcmdF?=
 =?utf-8?B?MWFjSFVTU2VzbWZoWTE0a0JROUUyVXV1L2JkTjRpM1d2T01XM1ZQQzRHWmZW?=
 =?utf-8?B?VVd5STRUMXgrdkNLNVdhdTFqMTJybVRqaWE0eW5KdWsrSjI4ZkI5RGNJU2kw?=
 =?utf-8?B?VS9maE8yR2JneWl6dGUzRnlCbjVXZ3d5WU5XVytzczk3YUFDT0NDRVg1TGZa?=
 =?utf-8?B?RVpLUytnZTZid3R5WVh0MGNJSjdvdWxvNU41cUJ2dHdHcnhwSkFESC95Ui9O?=
 =?utf-8?B?bHNaK2lER0lBSUljV1lDamdlV0RPQkk4V29jaFNKWFUrQlgwZ2VtSjA2cTlZ?=
 =?utf-8?B?YWYzekNCcW05eGlmWnJ5TGM2N2wrWDRFMXdQdzNZaE1sTWl5eTdZNnQ1Z21y?=
 =?utf-8?B?NGo1eHN6ZVZTZlpSSGx2SHhydWpiN205UzZUekdpK1NCTGs3bHQzdlN1U1lZ?=
 =?utf-8?B?M0hDS0JxUFpRSmtKSDJldHA5TXB4TkxNb0JZdVpSSkF5Z0FoYkRPOC9tTkdk?=
 =?utf-8?B?emhBM2FZWDE1THJPdjNHSmdlYXBBOWh0Y3NnSHQ3dXhZTHlTR3hEdEdKKzJ3?=
 =?utf-8?B?OXY4R2tXUnlHaHBlMnBBS3IzaGkvSURHT1g2V2VaK1V4NnMxaHJMdUJtRkVX?=
 =?utf-8?B?Y2w3TElacW5JbmxSdVRWTnZpdWswVzgvWlY4d1d2TjBiMDA1NXdOSzRMMEM2?=
 =?utf-8?B?dWNYd1djNDV4K1o2ZFp3SGFRZndWWC93QVUydEVmODVWOXh6SVhVQmRKK3Y4?=
 =?utf-8?B?d1ltQ21rRlFaUVdDVWhacE93R2VPZmpQYVBBZ2E4eG1nUFRKaGhVZkp3YURZ?=
 =?utf-8?B?a1RFbkRUTmkvVW5LVElqL29WMjNNaGI0NHZMSm1Qb3VPWUdhZnlEa2syOEg3?=
 =?utf-8?Q?wlzRjqWgp77RL9xes6aVIZlI5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 907c37ca-f285-4d9d-d483-08dbca6fef5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:37:11.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra+YXPUKDnCs7uiIj3AuAPIoDGQEdakmcbs7sz7V/jLSKufk11+dJG+SSOe6g+90i48Xiwc2qsuOP5gFoBbT+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 06:10, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 18:06:28 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
>>
>> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
>> an input of an ACPI package with 4 dwords (read latency, write latency,
>> read bandwidth, write bandwidth). The call returns a package with 1 WORD
>> that provides the max supported QTG ID and a package that may contain 0 or
>> more WORDs as the recommended QTG IDs in the recommended order.
>>
>> Create a cxl_root container for the root cxl_port and provide a callback
>> ->get_qos_class() in order to retrieve the QoS class. For the ACPI case,  
>> the _DSM helper is used to retrieve the QTG ID and returned. A
>> devm_cxl_add_root() function is added for root port setup and registration
>> of the cxl_root callback operation(s).
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> A few comments inline. Main one that needs fixing is out dated docs.
> 
> Jonathan
> 
>> ---
>> v10:
>> - Remove allocation in _DSM handler. Change input parameter to request
>>   number of ids to return.
>> - Removed Jonathan's review tag due to significant changes
>> v9:
>> - Fix input to 4 ints instead of using buffers. (Dan)
>> - Remove all endien conversion inside acpi handling code. (Dan)
>> v8:
>> - Change DSM return package parsing to use integers.
>> v7:
>> - Fix stray lines in commit log. (Jonathan)
>> v5:
>> - Make the helper a callback for the CXL root. (Dan)
>> - Drop the addition of core/acpi.c. (Dan)
>> - Add endiness handling. (Jonathan)
>> - Refactor error exits. (Jonathan)
>> - Update evaluate function description. (Jonathan)
>> - Make uuid static. (Dan)
>> v2:
>> - Reorder var declaration and use C99 style. (Jonathan)
>> - Allow >2 ACPI objects in package for future expansion. (Jonathan)
>> - Check QTG IDs against MAX QTG ID provided by output package. (Jonathan)
>> ---
>>  drivers/cxl/acpi.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/cxl/core/port.c |   41 +++++++++++++--
>>  drivers/cxl/cxl.h       |   25 +++++++++
>>  3 files changed, 189 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 2034eb4ce83f..a84fef73f8ce 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
> 
> 
>> /**
>> + * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
>> + * @handle: ACPI handle
>> + * @coord: performance access coordinates
>> + * @entries: number of QTG IDs to return
>> + * @qos_class: int array provided by caller to return QTG IDs
>> + *
>> + * Return: number of QTG IDs returned, or -errno for errors
>> + *
>> + * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
>> + * the QTG IDs that are suitable for the performance point in order of most
>> + * suitable to least suitable. Return first QTG ID.
> 
> Return count of QTG IDs I think..

I'll fix that
> 
>> + */
>> +static int
>> +cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
>> +			  int entries, int *qos_class)
>> +{
>> +	union acpi_object *out_obj, *out_buf, *pkg;
>> +	union acpi_object in_array[4] = {
>> +		[0].integer = { ACPI_TYPE_INTEGER, coord->read_latency },
>> +		[1].integer = { ACPI_TYPE_INTEGER, coord->write_latency },
>> +		[2].integer = { ACPI_TYPE_INTEGER, coord->read_bandwidth },
>> +		[3].integer = { ACPI_TYPE_INTEGER, coord->write_bandwidth },
>> +	};
>> +	union acpi_object in_obj = {
>> +		.package = {
>> +			.type = ACPI_TYPE_PACKAGE,
>> +			.count = 4,
>> +			.elements = in_array,
>> +		},
>> +	};
>> +	int count, pkg_entries, i;
>> +	u16 max_qtg;
>> +	int rc = 0;
> 
> Trivial but I think it's always set below so doesn't need init here.

Will remove.
> 
> 
>> +
>> +	if (!entries)
>> +		return -EINVAL;
>> +
>> +	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
>> +	if (!out_obj)
>> +		return -ENXIO;
>> +
>> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
>> +		rc = -ENXIO;
>> +		goto out;
>> +	}
>> +
>> +	/* Check Max QTG ID */
>> +	pkg = &out_obj->package.elements[0];
>> +	if (pkg->type != ACPI_TYPE_INTEGER) {
>> +		rc = -ENXIO;
>> +		goto out;
>> +	}
>> +
>> +	max_qtg = pkg->integer.value;
>> +
>> +	/* It's legal to have 0 QTG entries */
> 
> If that's the case, why not return 0 and make it the callers problem to deal
> with this. Seems odd to have the retrieval function return an error for
> something the spec says is fine.
> 

Will return 0.

>> +	pkg_entries = out_obj->package.count;
>> +	if (pkg_entries <= 1) {
>> +		rc = -EEXIST;
>> +		goto out;
>> +	}
>> +
>> +	/* Retrieve QTG IDs package */
>> +	pkg = &out_obj->package.elements[1];
>> +	if (pkg->type != ACPI_TYPE_PACKAGE) {
>> +		rc = -ENXIO;
>> +		goto out;
>> +	}
>> +
>> +	pkg_entries = pkg->package.count;
>> +	count = min(entries, pkg_entries);
>> +	for (i = 0; i < count; i++) {
>> +		u16 qtg_id;
>> +
>> +		out_buf = &pkg->package.elements[i];
>> +		if (out_buf->type != ACPI_TYPE_INTEGER) {
>> +			rc = -ENXIO;
>> +			goto out;
>> +		}
>> +
>> +		qtg_id = out_buf->integer.value;
>> +		if (qtg_id > max_qtg)
>> +			pr_warn("QTG ID %u greater than MAX %u\n",
>> +				qtg_id, max_qtg);
>> +
>> +		qos_class[i] = qtg_id;
>> +	}
>> +	rc = count;
>> +
>> +out:
>> +	ACPI_FREE(out_obj);
>> +	return rc;
>> +}
>> +
> 
