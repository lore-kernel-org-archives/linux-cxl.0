Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35C524AC
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvDWrBpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704730356; x=1736266356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hosm6m/uaMDLWX5qdte5/60eomoJl4IuqZ5RhE6/kSQ=;
  b=ZvDWrBptE2qbNt9rMlgFcGFCJhR0VKixlrbgLyGMmZPP2c3vx26mkr/0
   Em6U8GY13kTHYWQ3G3X2O5VcTGG9jW6dGNmZ3cOYhyiwoI677Wfe496hL
   Kb87mus9/yemLViInWqJNTWyA6IWME8yL2mTkWEn6dIHk2+vrtmbH+VGe
   Yd++N1TWHbIJmKOeVpWOf+N6b1ZJwjSr4T8pQoKRZDo8VPaD+K+H51a4p
   gag6dkH34k0pbtt8TuT+xUi+axIrMm/P9S7PtSjWsf+BffHoRryimM3EZ
   kpFMPyE0W3a0l9p845x9D6qvb2lWvSjJtFYVI9AZVCZKZsi5oDQXVVUV1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5293892"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="5293892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="904844931"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="904844931"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 08:12:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 08:12:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 08:12:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 08:12:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2OFmVNfVv4t9ZzmfjUHGxvUkB1e5jbk5iB0Bu8ZcsoFrFb2fROpdBFYak3+Q1H4tKgazXvDHHPoztWhmrABBBCfCPUgtKqMeX8IyVj3UzMKgZAvOZ8FxyauIY4f9+s6fy0z8p3GDaJSEKkGDftVs3x3hTJP6TiziGEaZBn7v2pXYS58Cut2C88FKFeOlB+E1aciRr6ux0ep88Yf9xNTHjjUGBJ/nwmeTuLlvrNwnWwH/Pa+hAgtVmxSlrjSZUMP0FLeVITxE5Lzz/yAQ70NSt5Qdh7a8+792+dRFKiQZLsBWZLhxsFvuI5xmbqYaKa4DnV/EurDjqlvvMdMX4NdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZGOcedmTVqL3jdAUxBwIG651XuMc1z/8BCok15+XSw=;
 b=YI7e6tlWGAbWVMm/taZUyOWivDasHrltmRfUXpuhq/FWaL5qzIqJtqiPbaCsb42baZ2l4s/wn6qm602rd4wBVG0PhYqOG0OYhopa6MkqKAenKRMgQcZiPU7smWnqtdsyxl6bA9qwZqO3C3L10ZqL7FiOUkaLqX/RYr8p6U/yPrGNWQXGC3Rfduk4GGoP+BIPw1ISOMc7u36h3SuSXNVVUMqDT8GNx0Q8wJdcXH3sWG7jm4857IJ+xCogGBB87dn7gMSf/MoOadK5e9vVGD2uILDkdzgEmLnl5hxnhdoQ/LORanhQ7TR0sCWIyypAU6Lh3qWyYo83JCIUMOA4LUslGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:12:27 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:12:27 +0000
Message-ID: <a59f540a-c852-4b5c-9b2e-e847b8b8229e@intel.com>
Date: Mon, 8 Jan 2024 09:12:24 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
To: "Huang, Ying" <ying.huang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfe5cde-fcc0-4ea7-daa4-08dc10649bc9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0IqYD9F30oLW0xPtEjK+R9VpHzpPQTIrHzcpkbJlSKUtxFQbHjshn9oYBNCHO4qVz1DvDTd79rbcnr0sin3cmCO0WTWg/sq5Fn63YbjiEIJCsao9pPSgVSyW4jCRblzDXufwTqkjDLpwHMr5MOXgCElbKtMPCNyWJHqjzGzSR+aJVjIMBkngIDnrEeTQd4lWyAuRydV3FWdMbm0ilo0PjLUoZ8ZvQMRWU3KcYwz5znWmdraMninhC8fEPnXv+ecrpQ0wfZ3vppfpcHM3j06uAYsIwbj1Df2fO5WxW67iNi3TF9L6dklFTJ+pwDrePh/B5qssHsUKJ2UUI779naI7tUDcLPOiXbS6+3q6zg5aCARW3vE8fLmUWRixVGXV98WIIqbmmAIickHswxUoLSWnSWivZ51VkzTOrJ6z8GwNTHmKtTKrJE2X4AklTCiOceG9Tr1faTJhv0aYDuZANrUmUyAqrK6uk3M/T6zZOuF/yN2JSZxatO54M4LtJTRqPsImEUb/1hUak+8YZvz7Y0z8+OD0mW7px3QednoirLP9PcO6oLu8Xz71JwJQlCc2KP4lsm0t8SYXSM96iyTmHtJ5jcP5GrQYA/7XFHzS+SAqTgziycGAirP5KTo/o8Y9T6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(8936002)(8676002)(26005)(6506007)(6512007)(83380400001)(53546011)(41300700001)(6486002)(31696002)(86362001)(4326008)(54906003)(316002)(6862004)(37006003)(2906002)(5660300002)(44832011)(36756003)(66946007)(66556008)(6636002)(66476007)(6666004)(478600001)(31686004)(82960400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzB3RWprYmJqNllkemFDVzdaVHEzc3l4V2JWRjUxbm1wRndGQncxYWo5YytX?=
 =?utf-8?B?RWdITCtlV1pQQnNwOFpYU05uNkVSQjJxcUdPSGVNYmpiOFc5aHhhaVpQaEdt?=
 =?utf-8?B?Qjk0U0hCN3FVUFNKeFA3SDJrRFluY2k0eDRaSTZGR1M2MlhvRXJzTUpmbE82?=
 =?utf-8?B?SVpJSDExSzRaODFxYXlRUUZLejAweWVIVVNTbzh0ck42ZDhBcjZQQkl3cWl6?=
 =?utf-8?B?eUZJMjJKNWVpMUFwZmVudWE2OHIyaG5vUlhkRkhETXFMRlZud1hNZ2tNa2ox?=
 =?utf-8?B?ZEpXRFJLWUgvYm50TW05NHRmODZ6ZnRXemQyVnB0d2J5TThkTFJQeGsra3hk?=
 =?utf-8?B?TG1YajFINVJ4aHc0Y05STGNmdldjZStYMkRmdDJVT0JnSlc2eFVZa3hnTmpH?=
 =?utf-8?B?TjZZOTZPdnFHMXpITHRMbDZtNXd2emsrU2NZam40SGN3cG51VXlQVWhmY3J3?=
 =?utf-8?B?SmtMRnNEbG1DWFBOTGs3ai9UUWRaTGlsSGRkbGpraWwrbGdPNHR3MExlSWFn?=
 =?utf-8?B?cGFVdW0xTFdVa1BRVzFZVjNSZjgyLzVlUCtsOG1uOEdWVUVTKzAyNGZkRmRy?=
 =?utf-8?B?cHUrWFNyMmFvbmFVNmhhbkVjMjJGRTdPOHI1TjMwOXlEWUVFQ2RldlNXZlNW?=
 =?utf-8?B?aWVlWUtVdzF4Y3ZqeEhET3VHeUFpVFBpdEwwRHJPYVplUGdEcWx5VXdhQko2?=
 =?utf-8?B?cXM0eG5IVlU5QTVLc2pyTW5lWXRyYmhWVitpZktVYjBPUkc3ZGZiRGtiTVVi?=
 =?utf-8?B?SUlIdEJHQ29IQnM0aUtsaFJYbFRSaDN5eHQvWHBvSEtlOG9aYjhCZW1hcEY4?=
 =?utf-8?B?bk5hNVF5WjdWZTdoZGtiZE9iQkI0d044UEQxdnlJdzRLRC9vajRId0wwTkty?=
 =?utf-8?B?NDdpZUI5b1Y4WFhrdlV0RXlSeGdGclhBcWQ4Ky9aMDdOWHhreXFNMTNxQXh1?=
 =?utf-8?B?Nm5iaWIvV0xIR3BldldCWHMvNTY0MkRXNENNYnpOZ1RRR3lObVZQVHI2eTBL?=
 =?utf-8?B?M2c4Y25NUlRieFliZzhjYlNLbW1wWmltS3ljSWNXWWppT0lQVFB5UXNzY2Z2?=
 =?utf-8?B?QVM5N1R6RS9pRk82T1EvZEd6enJ1ejNnMGtuQ1VKc2VqR1VuSlNyNkZseHpE?=
 =?utf-8?B?VTFUSEFPcGxDbW9Rd2pVSlZ3blovYVF4amp4YldzQVI3dzBnM3VtMWtrdUQ0?=
 =?utf-8?B?Tys4THYrellmWTVta2l6dCtNTjJuc3RXM1VrL3JWMTBaRGVmMGcyYnB6NjZ0?=
 =?utf-8?B?Q0ovdzNXL2g5QTZTazRlMXBsdWdKeTBEVGc4NUxYbUxyOGV0TkgyWHpwczNn?=
 =?utf-8?B?ZXh1Z0V3ZmZlRjNUOWQyZi9uZW9yenU3anF5WWpGWmZkLzA4a0UxbFRaL0lP?=
 =?utf-8?B?cjIyTlFlamRnVHltQkRhbEFGNE53c2NyV280M0dMT3RrTzZpVkNINUVBUGFI?=
 =?utf-8?B?TG5hWitxYTNUaVBud1EwRGdCYTcyQk9VMitjaDluVGxjTzhDNGZ3Q3VCWUwx?=
 =?utf-8?B?VERCeGdjYmdNMzd2TkFDc1hSNW41dnFZZEZ0eEpQSGMvU1BRWml4clVmcXlC?=
 =?utf-8?B?SVl6SW9weW0zS0JReTJINXc3RUk5Mlg5eGhrVitCWldsK0s5cStVL3pKR3lX?=
 =?utf-8?B?ZCtBTWUvemNqUnZHeVpUdWwwZVBkQnBTdy9yK2JBb0h5anZDc1I5UDU0MXhJ?=
 =?utf-8?B?SGcvSCtaeVRhTzJrMGVaVlIySVRsc1pMYXlTVTBVYm1oK1ZsZzRDMTRBaHBR?=
 =?utf-8?B?ZFNpdHQ3K2ZlV0I1NDhMMUJadlZMczJ4RjN1TlFaakttdmJKUCtvQnIwWllD?=
 =?utf-8?B?NjhsMDRSbWgvZnZLRXFDWW1vYWRVNDcxcEZaOUtqcUl0bkR3TDc0SFFmaWxq?=
 =?utf-8?B?MmVzZzJmODhwR2R2U1pUeGhiQVhEZHJqd2JVS0gwVGs4MzAwa1JvQnpWa3M2?=
 =?utf-8?B?LzJSZzV0ZHk0cWpCTGFRSlphL0ljUWZveFhKYm9rUWducnkyb0Q4bDNrZ3A3?=
 =?utf-8?B?VVFjSTlrUU1kZDZBRlhVSDNhWEtVSTVJaWhxTmdPVFV4SldKQzJ4aXRmdTlt?=
 =?utf-8?B?UHJJaXVYS0dnV3JaWTA2cVllSEVvcmRKdTdWK1h2RkplZTd1VUhzTWxEZHFN?=
 =?utf-8?Q?a2nqs4lpSwmunxJs3H1+f66yx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfe5cde-fcc0-4ea7-daa4-08dc10649bc9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:12:27.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvFDjBzVzmLXgZuyd9vEWEcF8pvslL4YbuUeOEcwrumfIiXPR21umWvLi9EtU1p7UXII/hugxNm77B3EVuh9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com



On 1/7/24 23:49, Huang, Ying wrote:
> Dave Jiang <dave.jiang@intel.com> writes:
> 
>> When the CXL region is formed, the driver would computed the performance
>> data for the region. However this data is not available at the node data
>> collection that has been populated by the HMAT during kernel
>> initialization. Add a memory hotplug notifier to update the performance
>> data to the node hmem_attrs to expose the newly calculated region
>> performance data. The CXL region is created under specific CFMWS. The
>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
>> Additional regions may overwrite the initial data, but since this is
>> for the same proximity domain it's a don't care for now.
>>
>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
>> for a node. The sysfs path of
>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
>> to the proximity domain of the CXL region.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
>> - use read_bandwidth as check for valid coords (Jonathan)
>> - Remove setting of coord access level 1. (Jonathan)
>> ---
>>  drivers/base/node.c       |    1 +
>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h         |    3 +++
>>  3 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index cb2b6cc7f6e6..48e5cb292765 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>  		}
>>  	}
>>  }
>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>  
>>  /**
>>   * struct node_cache_info - Internal tracking for memory node caches
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d28d24524d41..bee65f535d6c 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/genalloc.h>
>>  #include <linux/device.h>
>>  #include <linux/module.h>
>> +#include <linux/memory.h>
>>  #include <linux/slab.h>
>>  #include <linux/uuid.h>
>>  #include <linux/sort.h>
>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
>>  	return 1;
>>  }
>>  
>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>> +					  unsigned long action, void *arg)
>> +{
>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>> +					       memory_notifier);
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>> +	struct cxl_decoder *cxld = &cxled->cxld;
>> +	struct memory_notify *mnb = arg;
>> +	int nid = mnb->status_change_nid;
>> +	int region_nid;
>> +
>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>> +		return NOTIFY_DONE;
>> +
>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
>> +	if (nid != region_nid)
>> +		return NOTIFY_DONE;
>> +
>> +	/* Don't set if there's no coordinate information */
>> +	if (!cxlr->coord.write_bandwidth)
>> +		return NOTIFY_DONE;
> 
> Although you said you will use "read_bandwidth" in changelog, you
> actually didn't do that.
> 

Thanks for the catch. Looks like somehow the change got dropped. Will get it fixed in v4. 

DJ
 
>> +
>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);
> 
> And this.
> 
> But I don't think it's good to remove access level 1.  According to
> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
> characteristics").  Access level 1 is for performance from CPU to
> memory.  So, we should keep access level 1.  For CXL memory device,
> access level 0 and access level 1 should be equivalent.  Will the code
> be used for something like GPU connected via CXL?  Where the access
> level 0 may be for the performance from GPU to the memory.
> 
> --
> Best Regards,
> Huang, Ying
> 
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static void remove_coord_notifier(void *data)
>> +{
>> +	struct cxl_region *cxlr = data;
>> +
>> +	unregister_memory_notifier(&cxlr->memory_notifier);
>> +}
>> +
>>  static int cxl_region_probe(struct device *dev)
>>  {
>>  	struct cxl_region *cxlr = to_cxl_region(dev);
>> @@ -2997,6 +3034,11 @@ static int cxl_region_probe(struct device *dev)
>>  		goto out;
>>  	}
>>  
>> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
>> +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
>> +	register_memory_notifier(&cxlr->memory_notifier);
>> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
>> +
>>  	/*
>>  	 * From this point on any path that changes the region's state away from
>>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 4639d0d6ef54..2498086c8edc 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include <linux/libnvdimm.h>
>>  #include <linux/bitfield.h>
>> +#include <linux/notifier.h>
>>  #include <linux/bitops.h>
>>  #include <linux/log2.h>
>>  #include <linux/node.h>
>> @@ -520,6 +521,7 @@ struct cxl_region_params {
>>   * @flags: Region state flags
>>   * @params: active + config params for the region
>>   * @coord: QoS access coordinates for the region
>> + * @memory_notifier: notifier for setting the access coordinates to node
>>   */
>>  struct cxl_region {
>>  	struct device dev;
>> @@ -531,6 +533,7 @@ struct cxl_region {
>>  	unsigned long flags;
>>  	struct cxl_region_params params;
>>  	struct access_coordinate coord;
>> +	struct notifier_block memory_notifier;
>>  };
>>  
>>  struct cxl_nvdimm_bridge {
