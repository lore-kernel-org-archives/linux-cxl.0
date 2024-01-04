Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0628DDA
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiTrfFEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704392823; x=1735928823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y9arb+OFemU5NxjBhozZF3tv724UkoQb6J5Mge8RdsU=;
  b=NiTrfFEzHmytvWM1PKrzD7E67Vw4WqohyKeQLQH3yZWOJY5e7B2OjWIF
   WvjVUwDdvPA6T5xcGUeQGn8EcGuSsEcYPpJbtBDCrRDuQ+h1Cdjr7d6Ij
   vf5bqpwQzW79pbCS8d4QsIHVBXaAwJwO7MnJjGh4XXs6AuFEPpmPEk3gX
   IvBPdhJPX5fnJdX4jze4PKhxssZrLkiZx6hQQXS8hIA7odNl3cdkes80y
   SFF0Dw7K9YhOlxFhB0INparb4G6dcP9VSheE2ZIkc6M90wXHeHyR8fqh4
   oNg8N+y+sDN6qkUtLdzOyZvVw9OIjT93MfH/T8cWXQsUy00T6OvEfNdCm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4435533"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4435533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="814729645"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="814729645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 10:27:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 10:27:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 10:27:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 10:27:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTYvQuunb8rNNP3V3puyUlk9jYp9jdR3MHq4RWJAoLffAnu0M+6fV/6jyp0PH0qO/XLsRxMiYXGr5MrsX3sPWmfUyBjR5uK3/K73aoAVWF7CZ1Uxrdl/r4V4osMOqVlq9Vy2gUIFkStHmBIpMSobNOmkE8tusrRSSLmQvL3pd81SSPgnJ5ppn0NDjJt0aVgta2uO9wPYD2JPHJiVK61fIjlCaY9aFSUxWgdEQdaTwPruvUNEbQcWywpmKoO0SHfl23W2iq+7K4tyxHj0Wipo/qaAi3F8C9NgO09N4Wghu2+hSMuJHjANBQ/ftHEH0Wxl8paXLQp6QmneeIHlMUwaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8QBrSxxrxV/o+eK/U/asQ151Djk+YbtespyMfVymFQ=;
 b=QqS9gNwvpJLHAYL+7+u3eyips0hZVqMLU3egXvFTbRswdYN421KrEBv+VO+OMj2rvThxBsqkf0VWqlD7twuGvqjpH/ou7iXQEEk/KtZ38lUQTgTxlOVSDyXyDTFUhsd2s1o+5viW8EjDQRE9VCz4YXXczHziUDy/ANzsf97vUDirrzg+fISWMannq66h4/XAYWM2IzLPDdz8beP5D9KC2EIXRJAysvu3pYxX+tx5FocAjdJZIzwL+cEGCzCxR29gpx5OSDQ6FO95xv9825gRbdbVnHPInOr4ySpw9zc5WClJGzhbcJrCRRfUgXxS1xE4Z6oXZvGIv+EK8b7uxw81mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 18:26:59 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7135.026; Thu, 4 Jan 2024
 18:26:59 +0000
Message-ID: <21b78581-ab11-41bb-8cdf-455378c19e62@intel.com>
Date: Thu, 4 Jan 2024 11:26:56 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
References: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
 <ZZb3bjsxYT2Rik9e@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZZb3bjsxYT2Rik9e@rric.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: b36466de-694a-4bbb-5c14-08dc0d52bd1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QESWyS41z7Ep1VGL+JG7jaPYAMszq+fFYNBfNN1OsKLQrAk8tuXOY6WDelOTWb7VEy1Cwwy9X0+g8PkFjXhlqFiwdUbl0EJDRVPiIQtb2KiX0qNRgyslftoX+Z5I4MbFijId4SW8W37FhG4xRHLU61OMoE1qEkEKRpCZ7CN9qYI+XETXSTyw6XSSoHOOfuyIqJavoPMmNSzpldNRsULYjOzj7JyTTk9xT5UvxNfnl0FTPmZ0mYOXzOMWzypBwIIEImw0Nsk9BKfeXgv2XeNhipYclAQxBHsdSNFmxzkp1JHU5T2Q11JYCe8wVlv48mtfPWqAMJLLQqdXckWZdNAAwoVKwIYn0oiIjjVYcCifzkJW/d+30WwUxEK5zISKZQPTOmXjLxWEE9WpeIeXpMEg2HZHsiqseHVWFaNXFqkpHOFIaCqWChkekkS7Ty+EOyRWulsydwB3GDkN6havRVaZGncP/+GTR+QRJ5JmTgVdE+5BRrOAqV9lI8DxgjBXBFdSKnEa8MOU8TgCcdppA6obzepV7rAJqGCHx+vaGCztiaCmUkLTF4iiQVqdLtGrKvt2i4a2EEckPYtiFZoEJbV9Hjtm/3xtV+ay83FKnR5KTmqRoNRO37O44EuAGoJM3YOb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(36756003)(66476007)(6506007)(26005)(478600001)(31696002)(66556008)(6486002)(66946007)(6512007)(86362001)(53546011)(82960400001)(38100700002)(83380400001)(5660300002)(2616005)(6666004)(2906002)(6916009)(41300700001)(316002)(4326008)(8936002)(8676002)(44832011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBRNnFFTE9nVFYyeThBQnFKNUVBUmc1VU9WSWlEeExtSG5JL3NNS1g3eTBh?=
 =?utf-8?B?cjIwY0hCVXNlRWdtd1B2bVB1UDJiVXhaWGgyMDcvTzRYc0NkSncvd1J5aDQz?=
 =?utf-8?B?NVk1aFNEUjVpeGdMQUwzWkZqdElzUXBNZFlTM2ZNL09vS1N1bzFzR1czbTFG?=
 =?utf-8?B?d3VEd0UwWUNQaFg0RTYrcXk0c2l0QVQwYUJmckg1eEUvTjl1Mk1aeWxjMFRL?=
 =?utf-8?B?SDc2Y05VcVFrdzlRcXpUa1owRmsyWkY5UWYrZks5aExTMVNMYzdsc2VRUnBt?=
 =?utf-8?B?dHJFNmErTkxmT1FwTlhnRGJxSHhpUmJsWjErSnJvRHNOVjgyMGJoTkQ1QS9B?=
 =?utf-8?B?RGlFVlFDd090aENxNWNPUldaT05YTUlIaTVmZ1Jab2RZaW0rbDFmNnBrTEds?=
 =?utf-8?B?d1AzbVh0UG9uRVVFT09vbzB6dGZad2doRm9mTVAzYlMrRUl2RldzOXo1bUJN?=
 =?utf-8?B?VnN3UTdsR0xoYzd3QUlEakpMUmFBa1BlRDhnTzg4NWxZWFZYMUhFV3F4ZGtM?=
 =?utf-8?B?MGl2TVdwVi9TQjBncWRVT0JWTUQybDd0N1N1ZC8zaCtMZlQ4d2NyL3QvejB2?=
 =?utf-8?B?UUlBUGZoaVNvOWdkZE52RnBFSVdhWmJiaWNadThrbUtZenVrMDVQR0VUR0tF?=
 =?utf-8?B?L3o0a3N4aFdNcTZrREN1SW0zN2ltcmVvUHU0L1RTbURQMTlvNmxJT3dyUmRz?=
 =?utf-8?B?ZWQxUlFiY2FhMk5TemlodUhsUS9TVUdLdlhET0tKTDBjMEhZc1N2S3p1MDFN?=
 =?utf-8?B?K0tiZGVCNUFFOVZzRTJlenoralJvRzVocndHNEg5aGNjV2l6Wm5aUDAxQXlk?=
 =?utf-8?B?TUNBdnE4KzdGZFY5REhMbU5LeG9lazBKU3ZNUkJycjQ1NVVmaFdKRitxS2hR?=
 =?utf-8?B?STIxc0NDKzVSalNXWFV3cEVCZzdNdmhoWkIxMUR3RG5IZ1QwRUxONmZIaTQv?=
 =?utf-8?B?TEhrdzJWTDFhTzF2Y0VhcGl4N0xjNzFpdmtnTFZ6a211aWVUOTlBUFZoenlV?=
 =?utf-8?B?SXY3eWpBek4rZjNQakVUNmdGYkpRYXYralNvbmxlUGlNcDZTNG9nVXBvTVBC?=
 =?utf-8?B?SXh0cTJmeXB1ODB2Wks0K0pHZUcxbzBMTkRvRGczZStURzZTckxOSTdWLzBU?=
 =?utf-8?B?cWdENkRDNEVOSkZIWDNTQkNsbG8xRHc1YlRlS0NEU0NCYXdoZnBJd0lYSUQv?=
 =?utf-8?B?bk1xVk8wbC9pWmxtQkJUZVYwZG5XdEJaajdUMTh5R1FrUDc0Y21pN1kwdkhY?=
 =?utf-8?B?T0MwZWcyTlJYeCszdlhOUU02d1BrWldtUHZJREJqVXRCbXB3d3dBYUEwR09U?=
 =?utf-8?B?dGtQdUxmb2FISVRsV3FWamkyNk9GNngwL3NyYmU3MWFGVGFxak5LN3F0UUlh?=
 =?utf-8?B?eExsaXRrTU1TbUVzeDlmOFlDWUpqWG45WnlVS1g1M1V2Y3NpU0VKSDRUVU51?=
 =?utf-8?B?NmlBdEFsSEt6WHd4aWN4b3VyMTg3NHo3bi8wZEVPV0VFMTVWcnh1UU1Ya2tJ?=
 =?utf-8?B?RHJlN1kwZGh6eWxBelgvS1FMLzBpOHJGN1MxbHhXTmVUZW14VmNJMWNKOU1p?=
 =?utf-8?B?dG56aXV6UVRLZGV2b1lxQmRZQnRJRXpPM3AwOXBPQXd4SlNJakdOOXBUZXEy?=
 =?utf-8?B?M1h2MmNRY0JrenU2NzRPMDJ2R1AvZHZMSmQ5SkpHaTVaQUxVQUFQMTZHeWdX?=
 =?utf-8?B?a1NuMUJFUUZvWEd5b1BwdVoxcHJJS2V4Z2Z2ZkVFS2p2M1dDenhLdFZBTXkv?=
 =?utf-8?B?SmZoWFZSMEFBUkxJdUJESTZhV3FPZ2hYc0ZzTXZzOHNlR3pxY0hMSXZqY2ww?=
 =?utf-8?B?c1hQY0g3dTJ5dll3SklKQVg3VkVGNkxwVmFRM0tRak5teU9jOXBWR08zM3Rn?=
 =?utf-8?B?WkpGNkhVMU05cFVvOHRWV0JQbllSaDh5UU9YV2laYWsxMldPSWJYU2dCVUd4?=
 =?utf-8?B?Ni9oRzlHN0pCZkNobSs1eW1EZjlnZkpDMys5N3pKaG1URHZBN3hNWWxUcXdW?=
 =?utf-8?B?UmtISmljbTdCWE1JbzJBOXhIK3RvUVVCTjVmbGRwWHd3MmxmcVZ6VUJlRTcz?=
 =?utf-8?B?VHB2YUNDczdDWHU0YytWTEdLY2JkSkVBazF3YmNIZ0t5S0NHc2dMdlhJNUJl?=
 =?utf-8?Q?Zr5qixyaxLcv8wz+CXUaeAhRB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b36466de-694a-4bbb-5c14-08dc0d52bd1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:26:59.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X0TABzR0U6sTss/lGQYgeXmHUUIZ9tkEdAunCQorfLrTaBAXiWsO8yNzdBK1BsdjjQtnHaxiGbrWOP6Sjzg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com



On 1/4/24 11:22, Robert Richter wrote:
> On 04.01.24 09:08:05, Dave Jiang wrote:
>> The current __free() call for root_port in cxl_qos_class_verify() depends
>> on 'struct device' to be the first member of 'struct cxl_port' and calls
>> put_device() directly with the root_port pointer passed in. Add a helper
>> function put_cxl_port() to handle the put_device() properly and avoid
>> future issues if the 'struct device' member moves.
>>
>> Suggested-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/cdat.c |   12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index cd84d87f597a..d6e64570032f 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
>>  }
>>  DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
>>  
>> +static void put_cxl_port(struct cxl_port *port)
>> +{
>> +	if (!port)
>> +		return;
>> +
>> +	put_device(&port->dev);
>> +}
>> +
>> +DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))
> 
> Let's put this in parallel with find_cxl_root() to make it part of the
> api for users of find_cxl_root() to cleanup.

Sure that makes sense. Will do that.

> 
> Nit: remove the additional newline to have the same style for all uses
> of DEFINE_FREE() in this file.

I was contemplating that because checkpatch complained. But I guess if we are moving the function to where find_cxl_root() is then it won't matter. 

> 
> -Robert
> 
>> +
>>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>>  {
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> -	struct cxl_port *root_port __free(put_device) = NULL;
>> +	struct cxl_port *root_port __free(cxl_port) = NULL;
>>  	LIST_HEAD(__discard);
>>  	struct list_head *discard __free(dpa_perf) = &__discard;
>>  	int rc;
>>
>>
