Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9A2C186
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHn67npS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703269051; x=1734805051;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nanPUOCMy8ia/uGx9N9LaeSBetvcC7zsLFVlg3lp3SA=;
  b=fHn67npSeW5HrPZPOLruTEe/eYhM4s+JbIG2Xqzt6kMk3r28nhH95KFD
   KNy6oCQV0BXV6bXIK8dnUyukPAbE3VlShHUbY7YWGhNm+VBHYv6SjDco8
   7qCu9OQQ7iy4Sqwc/BYl1VtgrmomRoNpUoXqsAV02XgXF3ug9k83Ba7Ci
   orEL/vCREcVEY5NYEfPhDAjupmZK8EVs17eLtPmrqqoZhngxUMxfYcthT
   xdpBCLhSHghY6SecfJ4cN1lpsCeP53vtQQi6bEMXln7kUR+WOysQNjX6b
   aatl7LDX057r728UhPp53mTA4Yecqlpl0vHATdvSZz8wQDOOGtzK08RBG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395885310"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395885310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="770356237"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="770356237"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 10:17:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 10:17:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 10:17:22 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 10:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBxwiUfzq2eV/jSylKli+2aNwBGpA/2Pmdw68Ts0tCq40PySkx2WPJCFLHaR4OAto3tfOKpM/xUo+Y+x0+E8AwNJVR5ZC/d9NImXgrx97s1YylVWsZaMe8jZo67du9CS29GpIR/QASTbBfBPoZ84ggCumuHwy5wQ83I27PCkNCjUNyZjYhsBGZ6P3CBLOvbj5FLr5/917GhjolQiZv+M5HqFJGATZJjpUnRQkb+c04YjigfldhWYokc6kI9btdr9f77CT+MN9CStw6TSYdGWf+zqs876AIdGjmTOK/aL7hpGRxsSv8nH9ngruB+UWLqjL1XtA8txzGJXW6NSAM1/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/7bOcogjPep7a4AeIceQnTtsRtlu6KWZ6ehe0QgVHc=;
 b=Zeby5wmdrrZPZ3UIU4yp6H0ef7b+P2Umtk5YobTKp7msGAO9PT6LKmCA8nt61lP3ISeE4sNVB8u6JZLFUeDnJG1/hbRTTw5joIL9X6BupVGuTk6gXPWxcGc3Efr7eSc/TojcCk1USfd/h1SCPal1XwfAXbQGUqIoflQC981r0d8JA3RvA3z2tbYckVymhPjcIG9UMfqZPCOR4Gt2cAp0zx7M5MKpd47UkNVSKhy3GmGwt++FXkfILrCLHTU9IuunBq53GH5CX7JV/HdGQqdIM7gV7e2jS0eayAkFq5d2cls+QHkYtIXvbqkvZHHcHhpfXg3pCscAbaqeTdHgwm2mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 18:17:18 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 18:17:18 +0000
Message-ID: <af8ef32d-bb8f-468c-aeee-ade0e3c1ff39@intel.com>
Date: Fri, 22 Dec 2023 11:17:15 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 3/3] cxl: Add memory hotplug notifier for cxl region
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
 <170268217159.1381493.10875292326564731198.stgit@djiang5-mobl3>
 <20231219151507.0000226f@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231219151507.0000226f@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eb2a85-198c-447f-9367-08dc031a3bb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R58bTSVrA00A0DoOIc/MyTrNhNUVbgMfcQFbBIe969ksBDshkpmEJRbkfL2tOcvM7DHl5x9px9IChC/vuKXmnH6WTFGvbRFCQKOagRrseAIY+LBk+aTQkMbv0ef/tcweBTRYRM/N+YdbKZI7yPsL3sa4AQDEJ/vGnG+sBvUovFqDUbUeTIhcwIGR2+OGsfBbZMauck3Gb6r0x/GkVbCQpuzPXsUSRT7oijaPwbcl6PtpluViUsjiOQVwTqKg78VopO706Ir1cS3Sv4z41TjmbwRsZeGxCmYpqHVDo7DB2HbM0bc7I0tYN/+UGcDzKW8iNGiSF72QWlXswYHmWVpQmJPJSHpDghBjDT2BPmpUI19kbo5nMYBMwKDiGX0L+z1da4JXx8LoGxaur0alIDeXdYLSiJEnSnqZDBBQQbZx/CWbjVR847fS+oamUQRLMVwP6t0SggG9iHy5gLztmzqocd/lzq89SMFbn6Qw+1LRWH2QQYhQUQcoXgaikTIKIv5eRy4Rrs8Haamy2r4jVppzKxdd//A3oI0ezONGVC0ndtmvwEcbtHYBKyr5QOmc0BUe4OAkbtCEpF4KAyFrPhpeWonUdfaLmCgImGXq3vz4NgWXthZHdMw3zAo6Zkr+9qHQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6512007)(26005)(6666004)(6506007)(2616005)(66556008)(66946007)(54906003)(8936002)(8676002)(41300700001)(66476007)(83380400001)(44832011)(4326008)(2906002)(6486002)(53546011)(478600001)(316002)(6916009)(5660300002)(82960400001)(86362001)(36756003)(31696002)(38100700002)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlVrdmo3R2FaalJLV1M3ZjB0SCtMa0xGWGdIcVBpRmVlNUhoNlRuMXhLQXJW?=
 =?utf-8?B?NEFibnlYNWJDN1l5TDgybGpkeXI0Nlc2bUVpMmp3ZjZpWFVRR090OEVTYmVi?=
 =?utf-8?B?QmdORGhQbGdENVg0Si9DVW9FcXpSTDJaakxxQWFHQmdabTBNMWREYzNSbGhE?=
 =?utf-8?B?UU85VW5uamJXKy9pUzdrSk1pbGNPK252RHlKQk5FVXV1YTM4Rms2a21nUWM1?=
 =?utf-8?B?emFDNHB0c25ORVphVXJQcWJTSHpKZFVoVHhUYUcyUzAyRWJBL2piK3NWRjk0?=
 =?utf-8?B?bGo3VDRJTmV3cGNFQ09UUFkxaFdZOFdEdzlsYjBTb2Q0YjBCZnVhV0VFV0Vy?=
 =?utf-8?B?dTl5MFdvZTNLeVp5WU1CTGlsVVdZWTRJWml4RTVBNWNQTU9rN3VQNG5IRWZk?=
 =?utf-8?B?WnlNOE5yZ0RiMTBwZDRMSnZNcDNZK1kxc2phL012R0hWalRzaVBZbGEzdzZ3?=
 =?utf-8?B?VU5adDF1eEZNRlNkZHVpZXFmeUNFVE0xRjcwWnVkWHViUEJmY3ZFeWRWRG5H?=
 =?utf-8?B?b0U5RUZKSGc3bFB6ekpvRU1ncnpZNHlUV2VNTksvcHpXSVRqb3FCRXRlZWFB?=
 =?utf-8?B?QnZNMm12eXo3QjJmS2pNWGI1cmtIWUgyVzN4OVNVWkViRFZIeFRaMkd3Wnho?=
 =?utf-8?B?UnV5WktFTGhJdFNmUWxXaDFVNEpXRjRiYVdhVTg1Y2xqVTBSdVNjcVJqNEFO?=
 =?utf-8?B?Qk1JUklZVUJtOSsxSFJIbWUvbzdsN3hRdnczVXlFd2lzQTBBbHJZbXFaN1ZV?=
 =?utf-8?B?cGp2MS9wRHZQT0xBZGp6Q2xUTW5WdzZQMGdwYXVDaUNZK0pCSko1blMyOXNT?=
 =?utf-8?B?SWZFeWs4V2wyeDNPNnhmbmJib2NPUUxXZGVmVktjb1lQNzJkUXZZanJGK20v?=
 =?utf-8?B?Nm9GVGM4SEdhR2oyQlEzZHAvK29NTHF2dkowUy8wcW93dFYyN2s3RWw4WkVq?=
 =?utf-8?B?K1VYU3BvOEZ5V1g0UUpZRTBEZEtoWlZEQ2RxeEJSQlZmcjlJT0FzdE9Feitu?=
 =?utf-8?B?YURDSEdnYk9rOWwrcW5FN1hRekxUcWw3UW4xOG1uenpaVkhhclJHZWR4aDJE?=
 =?utf-8?B?QytlTk8yWVZuWmRQZkNPeVA5ZTYzL080c2xOQmJRT0VZK3NiSWl5NmRCTllI?=
 =?utf-8?B?eTJESkVUaTlNdXdUUzJibnNyTWc2dlVVR0FOUnA0WUhEelBONXJOL1hBMFFp?=
 =?utf-8?B?WWRVOG5EUHpaY2ZyMUZ2eDNMTUZjR0orS3UyK1ZPWTVIWDlGUmdna0lqVWY5?=
 =?utf-8?B?V3ZUOXdNcElpRE9oOXBUSVNnejU2RU5XeEJHOW9xU0hOTG5kV2taeDB3ZUx6?=
 =?utf-8?B?amEvQ2paMVdDVWVtU25XR21VUXR0aFBzUitiRHlGSEFhTytlQUJSWUdSV2Q5?=
 =?utf-8?B?WjJvOFdPTE1oTzcrdTU1czhxNkRJa0kvMWZHblVCNndxVEN0V2lxdFkrM0pZ?=
 =?utf-8?B?S3d3Uloyb1dSaTdVUlYrblROZGpMM0pQaDh2L2txN0IrWGUzZlNjUTFYK3Nw?=
 =?utf-8?B?MVZyU2NkMTA2UVVDZ2Q1eGJHYjNlYjdEQUpmZXFwMnY1S1hlamZPb2ZmOUh5?=
 =?utf-8?B?eS9rNEx4c1RxV28yb3lUSTViTDZ3R3ZuQWNHdHhGWWE3bU1VeXJwSkpsdUl1?=
 =?utf-8?B?a2M0VGY4b21CR0tBdGx6TGt6c1hHZkNNdmpFZk9TdkloUjhXbU5tZzN2Ly9Z?=
 =?utf-8?B?N3E4NHUyeWpQYlE0RTNNQXlZaHNsaG1mN0ZjVkxxSEkrOHFEUWZTWFhoVW1L?=
 =?utf-8?B?dUxyZXppSWZ0TXd0K3pZSEdKMlBHYm5wYnNGS1A2VHFtRm9zY2dhV2xqeVRo?=
 =?utf-8?B?VmxVK0M4YklwVzRlVWx3bVErZTl1NzN5cTg3ZnZkeEJxa1Q5a1ROTTVzYjFu?=
 =?utf-8?B?SmNSdEdQVHVhWk91VzZPMnVmNmpQbUFBSGZmd0ZtSitVT1AvaExtRUEzWlgw?=
 =?utf-8?B?Ykw0a05RWDgzWFMyclBwYkFDcFl3b1VKbnRRaEhhUjdQaFA5MUFXRWJBb2hh?=
 =?utf-8?B?aURBSUxaWEpwTnpnUDdlemtuWnF6T1VCTFNwRGlwSHNBQklpdHgwaTZleTly?=
 =?utf-8?B?RTcrbldwMVAwS2tBRU9veCtmZXk3blN2dnZIOTZDUUNLaG9tVStyYTlzZUhl?=
 =?utf-8?Q?q9MY5LXAkeWUfjm804DmijBSl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb2a85-198c-447f-9367-08dc031a3bb0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 18:17:18.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdmSCnJhz1WmnKhMCMqJHVPCX88RpeUgZOLkafKsAZxwWjJlAhFyqneqVLjTQRhSW6Bbu0LJVBOhwwRpRJSnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com



On 12/19/23 08:15, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 16:16:11 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> When the CXL region is formed, the driver would computed the performance
>> data for the region. However this data is not available at the node data
>> collection that has been populated by the HMAT during kernel
>> initialization. Add a memory hotplug notifier to update the performance
>> data to the node hmem_attrs to expose the newly calculated region
>> performance data. The CXL region is created under specific CFMWS. The
>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
>> The notifier will run once only and turn itself off after the initial
>> run. Additional regions may overwrite the initial data, but since this is
>> for the same poximity domain it's a don't care for now.
> 
> proximity
> 
>>
>> node_set_perf_attrs() is exported to allow update of perf attribs for a
>> node. Given that only CXL is using this, export only to CXL namespace.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> What is end result of this?
> 
> /sys/devices/system/node/node/access0/ 
> /sys/devices/system/node/node/access1/ 
> With just the bandwidths and latencies?
> No targets or initiators under accessX/targets or accessX/initiators?

# tree ./devices/system/node/node2/access0
./devices/system/node/node2/access0
├── initiators
│   ├── node1 -> ../../../node1
│   ├── read_bandwidth
│   ├── read_latency
│   ├── write_bandwidth
│   └── write_latency
├── power
│   ├── async
│   ├── runtime_active_kids
│   ├── runtime_enabled
│   ├── runtime_status
│   └── runtime_usage
├── targets
└── uevent


> 
> Or have those been set up earlier?  In which case do we handle
> the worse bandwidth being inside the host CPU?

I think it gets setup via the memory online callback notifier the region driver registered.

> 
>> ---
>> v2:
>> - Fix notifier return values (Dan)
>> - Use devm_add_action_or_reset() instead of adding a remove callback (Dan)
>> - Add Ying review tag
>> ---
>>  drivers/base/node.c       |    1 +
>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h         |    3 +++
>>  3 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index cb2b6cc7f6e6..f5b5a3f11894 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>  		}
>>  	}
>>  }
>> +EXPORT_SYMBOL_NS_GPL(node_set_perf_attrs, CXL);
> This feels ugly as namespaces usually about what is providing the facility not
> a 'who can use it' control.
> 
> Also, I'm aware of at least one other user who will want this in the not
> too distant future.  So if we want to namespace it, I'd prefer a NODE namespace
> or something along those lines.

I'll just make it normal export if we are anticipating another user.

> 
>>  
>>  /**
>>   * struct node_cache_info - Internal tracking for memory node caches
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d97fa5f32e86..1765bf716484 100644
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
>> @@ -2960,6 +2961,42 @@ static int is_system_ram(struct resource *res, void *arg)
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
> Could future proof a bit to allow for RO memory by using read_bandwith here.

Yes. I didn't realize there will be RO memory. I just assumed that bandwidth would always be > 0 for a valid set of data.

> 
>> +
>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);
> 
> Hmm. Assumption that the access attributes from no CPU requesters is the same
> as the CPU bothers me a little.

I wasn't too sure about updating this. Should I only update access 0? 
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
>> @@ -2985,6 +3022,11 @@ static int cxl_region_probe(struct device *dev)
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
> 
>>
> 
