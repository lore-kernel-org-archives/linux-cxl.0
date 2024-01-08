Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173154BDC
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDV6hvye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704737990; x=1736273990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3hPa7zeGVfcOj9okcOjAAFhhkHd1/3i/T7hpUBWpHUI=;
  b=GDV6hvye87RHXWgeizDuII8+VBCmjyO77qiToT7xjllI0PT60ucSstPV
   XEE8MT/QDrVdl4lPvecDGOqvgDywgCOxvOnsIMtufzvk7CkucFIneNfe2
   fR0H+AGdBbUQfWb7u7vtMaOv4k2pv0dx4vi8cGbZw/QNwTOMpQI5vuoVr
   +5CieVt06BYHJHiwZ4/AlTPDSqHjmput8U8GX2A3nSBEN00+U8zswCP5w
   vbFXeIi+l+C4l+BV/fF/73qdNAJrZlTJmjN5rJWSTBmQGgcR/1ubg5XcB
   oajQC7dKGTK2EZhbxoOIrnYn3ULI6OSrO+jOUAHyXehSoiq85dLXenL36
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4725773"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="4725773"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954731636"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="954731636"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 10:18:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 10:18:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 10:18:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 10:18:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 10:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRlBpsVnePVcV696f0kR3n0M8MiWGr4W/vaNaM78Xc5/OJ9jkLQqBEsp7BJDLdgJOGeLN2EJ0KJf6CuamualgSbTLtfT8ZI8OMvyj3Ji2zHGiCAdje8RXom3KYNbYgBLGHpM/ayXIiYEzaVnA075DgUem1JpN5QxJaenM87koWtN6FW4H8mCNKmZU7ekuXEQjw+BjOdDrO5/C/Yh+DbfwTwWZ2Qi0RQSI95lMOt+fM00Ei7tYdGcxotZq6HhCc2pj5nyVMzWd9jifQlXKs8NqS/borv71xTSSLl39o8g89DXlt0UqCfyAmseuQMqv6fPjvvWunzQ1YXblfty7E9wPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaKdGzJ/9vaL8lD6PQvY1sCmvqvmsyq+NXOSHLHDvb8=;
 b=hRNbMe/dGpoVJEXQGfTAMYA1fguLbp/EnwCtKQANczS0qbwCMOTWhp56QAtMJQTeWKi71ZfLnTXKTYRZsStZZ743nlNO5iSVzlrVgQp++RYbbsZOUzGklHYIPw+DZWEwXEfTmsAn1VtY8ujPD2YO6xZFFl3oai8hQD8oV1wVXBaqxGtqCLLtOVcGPNw+5x/7rbiORDAeOuw1mZSUZk+hYx1efCi9XhK3LaO0XxVORpD+WJh+Y9aYoYBAMjAj/08d7sLLKZbnXtDHPi0Mpv5j8ThVpudNTOi/LpGZnTfl8oOOcK07mlm+jpc5QRbKRzB4m8thP0n6+xY24j3ZYCTRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB8362.namprd11.prod.outlook.com (2603:10b6:610:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 18:18:37 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 18:18:37 +0000
Message-ID: <38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
Date: Mon, 8 Jan 2024 11:18:33 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Huang, Ying"
	<ying.huang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240108121538.00001369@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240108121538.00001369@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 4201f0f7-2a52-41df-3bdb-08dc10763b6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvnWCIzJaZhLORztOCTwOIlu2HRfqsI3ysBQfA9ejiW1A641wZj9BlRGtTVsyHwo/INc2meao4kJBCU2g1SaH2GKduVFitbuf1v+idU1pyGcHIiAzCX85g6pUJuApeNtLuJ31l6/PIJ7kTELTNtIdyexHRP5Ad5v/QYBrIfEX7BZu2WQGe+ZaKPezFwuOK3pdvc/uPdzMMdU3qgBJQ8eBoFqz7kESJOK5PfPQ/L5rlSqVMeHV0Hj9igVhJ5Mm5BTZzCnZ3Re5VrMPV2y7uVVykwH4/MHkiFSrEIHuN0PYMqQ5dDP7h/BCJeAvpurMtCtyDNZH/zDyH/Z0ys5/41JHTs+vRQIxvMbA2ToIRoA+UZGKRN8XrN3O9rlOzDgnyZCyAFyGRZxbrSjhq0rYQGSzpL1Oc3Nj/BhI7Ae6krJ2LH9daIk89cNzAX/H4vM2btzk1P8JSP+g+yzlP3mtnDCv+Gjsoxv2EITOE0QibJXZAh75HckDYeKC7nIc6WVdUWp6wJGEj+ud0iUmDmE97ntTXCjUOekIizIjTEf6+P86o9Mzi6SIN0IUktAl/iNxf1H/2UYJEEJonUIBauNrizQUkNLAccdrK7c5vCOlBZp23pUyRU4SjIeOgavAPailoRa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2616005)(83380400001)(5660300002)(26005)(31696002)(86362001)(6506007)(6666004)(478600001)(6512007)(38100700002)(53546011)(6486002)(41300700001)(66556008)(6636002)(54906003)(36756003)(110136005)(66946007)(66476007)(2906002)(44832011)(4326008)(8676002)(8936002)(316002)(82960400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjIwcldQL2ltQ0FUK0V6TlQ5cklPelI4VUVIVS9nNjErZStXWlh1elVDZ0cw?=
 =?utf-8?B?bVVpcDVvN0xiNW1hTzRtSmtscll3WmhrckllWG95NkhMTEx0QjRSMXdHS0w3?=
 =?utf-8?B?VzhxdFVkRGdLUmVQZDRGM3FvOGl5TTYraHQzRERsV25pNzNYMWFJZUgxZXRT?=
 =?utf-8?B?WDcrcjVBZUxGSmczaE14Z1ByUURsN3o2cXdtSFlSN2NhampLdWJ6TUduUlV3?=
 =?utf-8?B?UDRULzJMTG9ueXNhU1EzUkdMRDJhZWpreEFLNzVWeUFUTWNxdXZabVRGUDRp?=
 =?utf-8?B?cEZWRldRdlNHY0JsOU1vcjkzdVlWbHZnMlpJUFpBQkNIbkJvN3NLYnlmVTNH?=
 =?utf-8?B?b0xOVEtJS1RocTFSOFcxdVp2bkhxaFpHNnRQRFpwWmtNTGJIZi9yQi90WDFV?=
 =?utf-8?B?TUtJT1gxczM1SUF1aDhPNkVZVnpkOHFEOTB6cXB3NHNoVTRDYTFTOVZ0RjR1?=
 =?utf-8?B?YWJDcnVWeEpCZHFFaFM1TWdibFd3V0xsUnNwZWlYSVZGVnd4REszR0ZXR2pa?=
 =?utf-8?B?Zk1aZ0xCalEvU1I2citVclFPUHNLZ0hnZTlCV1NIRnJibW16eUV3WnNaYzBT?=
 =?utf-8?B?aXA1emRBZGRHWExONGxEUWZLdXlTeEZRRnpCeGw3Zi9RNytZRCttc0NlUmtM?=
 =?utf-8?B?WWVyaFMyeEpzU3FiOUc0R0J3NHNkb1VlNE1vWVVCM2txT0ZDQUFxeUVuUTZD?=
 =?utf-8?B?SVJDTmVHcjg2Q2VFazk1ckhBY0ljdUVzQXcxZ0dZLzJ0Y1hxRnhEQTJLLzAr?=
 =?utf-8?B?OW5NN2FtbXV6bllCSjZqcE9IWUkwS3F2dTZCTVlZR2VNMDVsanNZSWtYZERw?=
 =?utf-8?B?RTQ2KzBXVFYzcUgzTW5UQnJlTmlzQ0FaTGxrNVk5Y0phdTUwM1JJNWtHZW1W?=
 =?utf-8?B?SUxvZE5MRG5TSDZzZkVLNkFMQzBpdGcrK3FkTmdjUnFRbUVnT29mcUNzRlFJ?=
 =?utf-8?B?ZEU1RmtZT1ZkZWg5MmdubUY4M04reDZqNDBMNEJ3aVYzUDl2TFlpY2Vsd1ln?=
 =?utf-8?B?bW5qM2NFaFBhekxMRmZubVBuQ09tWFk2QklHYnMyZGREUmhGVU5lb0FEbk9O?=
 =?utf-8?B?ZnFKREJvbkU2VytCWksvQ3gwaXdTTWRFRzZXMXAydWVhZHdhazVzZDk3Y1A2?=
 =?utf-8?B?VldPK0NCV055WWxFbm5NelkyU2R6dU9FYlNncWFER3UyQ0hmY2w3UkhDeklK?=
 =?utf-8?B?TkFhd1RRRUY4elNtS1lmWC9JUXdjQXJIOW5HL3dzK05XS0xrZVBZVWVmazUy?=
 =?utf-8?B?NWdtckl1amVvaFZzbklRdTZaNXBiVlpqNjk5N2hjbDdZZjhMcGYxT1NQN1pS?=
 =?utf-8?B?Ukgva2hCeWgwV2ozWUtmMERIbkRFYUR0M1pteGNiMjVXWXdCSEhOeDNNYUNo?=
 =?utf-8?B?cVJTekRLM0wxdFU4d2lrWUx6di9LY1FSZE94Zy82aHJ3QnZhY09FS254WmdV?=
 =?utf-8?B?Z0Y3eHhnR1lRaHJ4dm50enhOQi9PSlEzZUo5Wm9OTFpwUUdEWk5HQXZFbEVy?=
 =?utf-8?B?OGQrQ3pmcnlhbnhNU1p1dXdpdk1Yb0xCc3dsbDl5S2VjZElqNFFSQ2Y5NmlO?=
 =?utf-8?B?aWJ5U0ZidFNzNmpzV2FBSXFtbUJvamxjaUU5VzRZOHE5bjZmVHFwenVrVnF5?=
 =?utf-8?B?dS9hbVJzb2RVMVhtSzBSTFFudVRId3dCNENycVJDYmJDaXYzVzVCRHRZdmti?=
 =?utf-8?B?Y2xFQjhJNXczaGZKT2hhcmNRaHdPSFExVjhkWjVVRDUxZjZkWnNXaDRrUHdx?=
 =?utf-8?B?WUpjVmpGRExZenZPdUtVR3YvMVhpQnJZUURhZDhocEdMUEZ5dGlwUEx0U1lq?=
 =?utf-8?B?UmdNTFdraTJBMGtCV3psVzdPNHpTUnhmTkwwTzcwQ1hRWUtYbERta050WFdS?=
 =?utf-8?B?K3dMQ3hwejk2K2FmdC80bFRwcHVRcExhdWxMWTA1UW55bFNCdGJtNTRVdkVS?=
 =?utf-8?B?TDE5aUFGeEdsN1hoMllCRlAvbXJFaGZTZkc4M2l6YjlRTzN5ZVdxOUVoUElq?=
 =?utf-8?B?TkFVaUlVVlVZV21FaDNDZ09uTDNvVVJaaUZQS2d3WDdmcGRDdEwzQThrczZK?=
 =?utf-8?B?bmNXa2JxUVArK2xoUXlWR3pYRjIzWEorWWhzMlpwRzRIZGQvQ2JXRnNKUWQw?=
 =?utf-8?Q?jMZj/pyoAyobnpC84nBV3zLfs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4201f0f7-2a52-41df-3bdb-08dc10763b6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 18:18:37.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1PuMmj3O/5flW15IxiaX29t4e8ood6GB24914GgVMbRewLwJfX+3/p0IrmuvhzE/b6+FhOpvi0pgKWSylGMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8362
X-OriginatorOrg: intel.com



On 1/8/24 05:15, Jonathan Cameron wrote:
> On Mon, 08 Jan 2024 14:49:03 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
> 
>> Dave Jiang <dave.jiang@intel.com> writes:
>>
>>> When the CXL region is formed, the driver would computed the performance
>>> data for the region. However this data is not available at the node data
>>> collection that has been populated by the HMAT during kernel
>>> initialization. Add a memory hotplug notifier to update the performance
>>> data to the node hmem_attrs to expose the newly calculated region
>>> performance data. The CXL region is created under specific CFMWS. The
>>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
>>> Additional regions may overwrite the initial data, but since this is
>>> for the same proximity domain it's a don't care for now.
>>>
>>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
>>> for a node. The sysfs path of
>>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
>>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
>>> to the proximity domain of the CXL region.
> 
> As per discussion below.  Why is access1 not also relevant for CXL memory?
> (it's probably more relevant than access0 in many cases!)
> 
> For historical references, I wanted access0 to be the CPU only one, but
> review feedback was that access0 was already defined as 'initiator based'
> so we couldn't just make the 0 indexed one the case most people care about.
> Hence we grew access1 to cover the CPU only case which most software cares
> about.
> 
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>> v3:
>>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
>>> - use read_bandwidth as check for valid coords (Jonathan)
>>> - Remove setting of coord access level 1. (Jonathan)
>>> ---
>>>  drivers/base/node.c       |    1 +
>>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>>  drivers/cxl/cxl.h         |    3 +++
>>>  3 files changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>> index cb2b6cc7f6e6..48e5cb292765 100644
>>> --- a/drivers/base/node.c
>>> +++ b/drivers/base/node.c
>>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>>  		}
>>>  	}
>>>  }
>>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>>  
>>>  /**
>>>   * struct node_cache_info - Internal tracking for memory node caches
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index d28d24524d41..bee65f535d6c 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -4,6 +4,7 @@
>>>  #include <linux/genalloc.h>
>>>  #include <linux/device.h>
>>>  #include <linux/module.h>
>>> +#include <linux/memory.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/uuid.h>
>>>  #include <linux/sort.h>
>>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
>>>  	return 1;
>>>  }
>>>  
>>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>> +					  unsigned long action, void *arg)
>>> +{
>>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>>> +					       memory_notifier);
>>> +	struct cxl_region_params *p = &cxlr->params;
>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>>> +	struct cxl_decoder *cxld = &cxled->cxld;
>>> +	struct memory_notify *mnb = arg;
>>> +	int nid = mnb->status_change_nid;
>>> +	int region_nid;
>>> +
>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
>>> +	if (nid != region_nid)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	/* Don't set if there's no coordinate information */
>>> +	if (!cxlr->coord.write_bandwidth)
>>> +		return NOTIFY_DONE;  
>>
>> Although you said you will use "read_bandwidth" in changelog, you
>> actually didn't do that.
>>
>>> +
>>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);  
>>
>> And this.
>>
>> But I don't think it's good to remove access level 1.  According to
>> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
>> characteristics").  Access level 1 is for performance from CPU to
>> memory.  So, we should keep access level 1.  For CXL memory device,
>> access level 0 and access level 1 should be equivalent.  Will the code
>> be used for something like GPU connected via CXL?  Where the access
>> level 0 may be for the performance from GPU to the memory.
>>
> I disagree. They are no more equivalent than they are on any other complex system.
> 
> e.g. A CXL root port being described using generic Port infrastructure may be
> on a different die (IO dies are a common architecture) in the package
> than the CPU cores and that IO die may well have generic initiators that
> are much nearer than the CPU cores.
> 
> In those cases access0 will cover initators on the IO die but access1 will
> cover the nearest CPU cores (initiators).
> 
> Both should arguably be there for CXL memory as both are as relevant as
> they are for any other memory.
> 
> If / when we get some GPUs etc on CXL that are initiators this will all
> get a lot more fun but for now we can kick that into the long grass.


With the current way of storing HMAT targets information, only the best performance data is stored (access0). The existing HMAT handling code also sets the access1 if the associated initiator node contains a CPU for conventional memory. The current calculated full CXL path is the access0 data. I think what's missing is the check to see if the associated initiator node is also a CPU node and sets access1 conditionally based on that. Maybe if that conditional gets added then that is ok for what we have now?

If/When the non-CPU initiators shows up for CXL, we'll need to change the way to store the initiator to generic target table data and how we calculate and setup access0 vs access1. Maybe that can be done as a later iteration?

DJ

> 
> Jonathan
> 
> 
>> --
>> Best Regards,
>> Huang, Ying
>>
>>> +
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>> +static void remove_coord_notifier(void *data)
>>> +{
>>> +	struct cxl_region *cxlr = data;
>>> +
>>> +	unregister_memory_notifier(&cxlr->memory_notifier);
>>> +}
>>> +
>>>  static int cxl_region_probe(struct device *dev)
>>>  {
>>>  	struct cxl_region *cxlr = to_cxl_region(dev);
>>> @@ -2997,6 +3034,11 @@ static int cxl_region_probe(struct device *dev)
>>>  		goto out;
>>>  	}
>>>  
>>> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
>>> +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
>>> +	register_memory_notifier(&cxlr->memory_notifier);
>>> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
>>> +
>>>  	/*
>>>  	 * From this point on any path that changes the region's state away from
>>>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 4639d0d6ef54..2498086c8edc 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -6,6 +6,7 @@
>>>  
>>>  #include <linux/libnvdimm.h>
>>>  #include <linux/bitfield.h>
>>> +#include <linux/notifier.h>
>>>  #include <linux/bitops.h>
>>>  #include <linux/log2.h>
>>>  #include <linux/node.h>
>>> @@ -520,6 +521,7 @@ struct cxl_region_params {
>>>   * @flags: Region state flags
>>>   * @params: active + config params for the region
>>>   * @coord: QoS access coordinates for the region
>>> + * @memory_notifier: notifier for setting the access coordinates to node
>>>   */
>>>  struct cxl_region {
>>>  	struct device dev;
>>> @@ -531,6 +533,7 @@ struct cxl_region {
>>>  	unsigned long flags;
>>>  	struct cxl_region_params params;
>>>  	struct access_coordinate coord;
>>> +	struct notifier_block memory_notifier;
>>>  };
>>>  
>>>  struct cxl_nvdimm_bridge {  
>>
> 
> 
