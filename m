Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWsWqi5R"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2419D
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700092522; x=1731628522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hLp9GTU4IpsFWTCTRmQ5/MNxXueGUDATTeJFrQtwgw4=;
  b=NWsWqi5RGi7ea1AB8AOwQGMRypa68fFpz7yhoWfJqYrRfjcQJ/xPQT/d
   jT5QNCClKZ15GKzuJZyVJcgtufv7N9q/KN+D8Vf2AsKIn7UiqHXHDbkrW
   0rMV90IWhU44affR7XzJOa7aJZ0N2zvplXG/tT0KbzmBX4yKEjpsNbUY0
   ISgsODXs5QzVNp4N1WZRLhJGyJ4I9w7I/75Lll49ZS6/c0g6rgxiWlAEf
   6SHaGj9EpKfF1lXGbaXzIx078NvYyj6vBsmpyV1ZAkSZLQjeAPhf/PEHN
   KoNtteCZ22rbLsB/cWgwWFmSVo32Mm41545wauGLPd/iHtTGVu6vcEZHQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457476508"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="457476508"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="888733134"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="888733134"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 15:55:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 15:55:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 15:55:20 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 15:55:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ5//eF9s9KdqVZzmb9QRSJVBkeKU+i+uyhwtW5kV7vsWLf6F9fRIjdQp+XanQp+J1LlYuAwKMlI8CDoiAkVVixnE8Q3d4FfID5iZQwFUluZ3j52Oagtv37s0lOoEVPIlK6VLZaAbE3bZDW/f3zUEcrqtTm5O5GlQdl7AjD7jSMjGN9J3hthwsK03e8X4tDTGdhakI6MqsBSBseRq5FCVcwnHlSq/bQJqDgdVGmoo3pP49pZ9MW+c7sH/ikMe0TKaJFuJprObrih+N09qAtbM8C1It0o1wSB6BhVKNx7PMRYZ2zA1y7oom13GAXpOVBCov2Gmcx2hbDgw/RTSEFDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIc8uHBAg7y48+JOWsIOaZu9IfweZM8A1iqe2q8Je20=;
 b=NZUlGv9uLTSQ7UHcvmbcxZETEKUf974Aqmhd6jMhUOSX4pUn7RycL2cnQvsY0C6RRSQ29PTns3EXx19yVKjc14TCwOh7XosS5gvvXaFOiU4uqflrWW88XLEYMNh/CJOZYEpvCoa8Nr9fYk38lyongs0J8YY6ioaI/HPwBJdG0oHkvlcvViXIw4i5j3qZb2IuoXAwTbrQzyUMQIHG3KeBbeJBc4laeneaut1+toqrYbm9/HinOptZHxmAlVvo1vXlIoYiPgDIvkzQnpMbwk4bv6jmtpl8Bn+vhmPcpqgGJo+a5vbEbk5zs9XhBV/ERuHf7iYNaGf1BAU2FH78/SvA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 15 Nov
 2023 23:55:14 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 23:55:14 +0000
Message-ID: <c35ce419-4881-4cb9-999e-d3034ecad8ab@intel.com>
Date: Wed, 15 Nov 2023 16:55:11 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl: Convert pioson ops rwsem usages to scope based
 resource management
To: Alison Schofield <alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
 <169998626910.1958731.10157698499207717733.stgit@djiang5-mobl3>
 <ZVVVH8ITotdk1nyN@aschofie-mobl2>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZVVVH8ITotdk1nyN@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d0d983-5d48-4592-af41-08dbe6364faf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdvZLAMIFPtEEB9AJNjQgV70DH3a3Xm4bFMt0X5fe16j+z9f+HSzLn1yt7jkzoBdeCl8iq39ErXuU8sg2LlVHdfzS+uE5w/IPdoK40K392TIg+S1kzhFJHsUud8+h+SlEY6F8vav1p45mEfLFXC88e30Rbr5Tk0Rd/I1GooO8FEL5ApULRGhTwmL+XyUsnKShNvRXEecTWqL+6mSGtq1fBf5AZlPC04w47K7LNKKwh3qSrxutHhlvPSLQqS+kMdQDaguHhURfKhSI5pEH8bcvav79UE3vb4nm6b/YBrAgvKCqIyMqxgTz9V7IVOPq0EdHRJRw7F5wW3/qICMn2iwijFFmSPFLmqkahK7FZBe0uiCnmchwT3HA5betmb9kemjMBuu1IqEICR1CnUkH90qR2fNoa40kL5PUMZJwOl8XoINZMzODmVCEAYkVLCDeHu8YhqNw24rJ1JaLz3qiLROy60ycpq3p5s0/bppqVPzC2KY2yEwHV++V68JIAzN78faEvhGLBjYgPYnZrJxYPOSk9sJux0hXR6Y51yXuh89nUK9I4C8LbVXKURXbhoCRSJQNUTWGrNwDXeKvHhVr6SBCkUUnp2AJQbDH5Uuke8Sxxv1P9EYsGViYlCDk0/R5WxD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(316002)(107886003)(2616005)(26005)(82960400001)(66946007)(83380400001)(6666004)(478600001)(6506007)(53546011)(66476007)(66556008)(6512007)(8676002)(36756003)(2906002)(6862004)(8936002)(6636002)(38100700002)(4326008)(41300700001)(5660300002)(31696002)(6486002)(44832011)(37006003)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBvTE1hcFdWYnNBTmZLY1F5SDUyUXF1Z1ptVmR0RCtKR1BSZXh4U3lpMVo5?=
 =?utf-8?B?Mmg4dVk2REtYR1VKQXY1a2lWZDlLU29UQ2NsR0dqQnJ6ZzNaOTJzNGRUSHAw?=
 =?utf-8?B?ZWhOWFJ6ZVIzT1djeUN2Rk5hQ0MvdnZlNzdrTGtpcWxNTzlsMkNLMUVWNWxh?=
 =?utf-8?B?ZWFXN1dEcTBYYlh0YUtNSjQzckNFS055UERHeDR2c092Skw0elcwamc1YnRt?=
 =?utf-8?B?K3JESS9hRnJYY2NIU2w5RDZydGlTVmN6b0pJTzNpUWtiZnRLYXpjWlEvSDc4?=
 =?utf-8?B?dFErQ2NmaXJPUHYwRjdaM3FLZmhmM25jUVU5djRSQXp6RXVLSGZzbzRiR29L?=
 =?utf-8?B?dEtkRFNjU29uOUNxWk0ya1h4M1oyeGhWaldqL0dtbzRVRkZtSnV3VStxcmdn?=
 =?utf-8?B?NHhsWGkzR1lQbGtkelhPWDJYL0tZZGQwa0NKNWh0UTdvcDF6MU9iTWpjRWFS?=
 =?utf-8?B?QzRxOGRHS0ZjWUR0cXZwOEdwYkh0dlVwWUZJVE5YQmZCUEZnbkdxT0RyVWRJ?=
 =?utf-8?B?V1E4enUxOGptRHY5WnJwUjNILzk4ZmxTN2lsemJTd0diZHdaU3pMTW5EYnVl?=
 =?utf-8?B?c0lqTzd4a3RBVEpVQnpwWVZvL2hYSnh4VFV1VVFwNURIdVlTalhnUEhQd0x1?=
 =?utf-8?B?dzJZR2tKZldCQ0NJTTVOMC9vMVplR2NCQlh2MUNtMTMwcTdOcm5UNHIwcGt5?=
 =?utf-8?B?cHpGQ3M4V0VkU2cvNzJyVzNob0ZheTlsdjBURlNkWUg5elRsTHdkVlVIYWlV?=
 =?utf-8?B?dFd1NXBUVnpwQ2tWZUZNcThHZHpkSGduT0l5L2l1cWtPbXFoMjhRdTZrUTFU?=
 =?utf-8?B?bFV2ZWs0T0hOdWV1MVU5d0NqRUVrdFRaRG1HajFEQXYrVHhOeUwzdUpGY1JF?=
 =?utf-8?B?OFBKT09ETjVhQ2RUVSsxa1VIWmRqdXJYRktTcitocHZyWmNyTnM4L3B6SnR1?=
 =?utf-8?B?OE1FbC9reWFJU3BTMVVmV0t6Um4wOHgyTTBNNXJPMjNNSkM0OWo5SjRFaEU2?=
 =?utf-8?B?aFczTVV0ay9jOElMVWpUUkZDTTQvNlJ3Z1JDaWpBYkZFSXdIMEluWVRFN1pZ?=
 =?utf-8?B?ZlNWRWJaNnRuZ0Z2aTNRSUJrcU55UEJabFR6K2c2S01OUElVUTRoV1pSYzVq?=
 =?utf-8?B?QW9LYm0yZEx2Yi9OKzR3YkFKYmFyVitveXlxT0k1ZFdKb05sejQrN3pka25s?=
 =?utf-8?B?bStqQ1JMNXFoUWpjUEJkZitQK0IvalU2SGxxWldhbGJzeGdVWnMxWlVVcVdK?=
 =?utf-8?B?NGxTcFYyWGczOGh5YjRLSHlOb2V0azg3L1Rld3NPTjVHandqS1JLejJKRk9U?=
 =?utf-8?B?UVMrM2tsRVdiNk56QjRJczNPWlN1SHdkV1R0dytOem12M09SQ0FPWjBjdFBT?=
 =?utf-8?B?RFRSVEtmWU4zbTU3eStOZElrcjd4Wi8vTjRqcEpDTlY0Sld6OURvMnFlV2RZ?=
 =?utf-8?B?blpTSUVxVTJ6N21PWmlzR2JWd1dDb3B3REhtc2JVTWxKTC9lRlhYY1NkMWRT?=
 =?utf-8?B?S1pQa2lsYXdMY2FrYytUbjdTbklHQ0RZMmYyWXpYd29taEpqTXlINjdaSmM0?=
 =?utf-8?B?QXhZYk5hQlBtUE8rQzdZYW5Pb1RieEx4Zmx5L3A5ZzVMdjVaeUlDYkNqd3pI?=
 =?utf-8?B?ZVptb0pEQUlTSmwrcFlZbk9VMkF1N0JoWHNSdTlYdTlvV1BrZDJSc0NDc2pt?=
 =?utf-8?B?bVBQYWpUSFRmT1RBL1FoNUhWWTRIWnVkcHg1NDh4OVpleWpzcFI3V2N6UXRZ?=
 =?utf-8?B?R0FGWlpFbUVJdlc1ZG1pVHByZ2VBQzA2R1MxQlA4REYwcHBvUlFRUW56OWhJ?=
 =?utf-8?B?VEZwOHFDeVlaOVFGeG5yVndXeHpML3BMaUl1RkxDNEpRUDJiUDhhd1crb1N0?=
 =?utf-8?B?VUJZQ242RCsyQVJEd2NTOUtrM1J1dHdOcG90Y0VndTRycVBwOHNCN2JXVlR1?=
 =?utf-8?B?NC84SSs5TVNkOGtyakI3MkppRUQxNzVIaEl0K1RUSGtVemxSVTUxS0hqd1Js?=
 =?utf-8?B?ay9XR0d1YUprV1hjUE1uRy9RSnVmN211eXNsNmI3NnliYWFzbFlxSU1Ed0JJ?=
 =?utf-8?B?TzBjcjBoeGxzOHRnb0kvellhWG1pZGJhQXQ4VHRPYU85eFNKeWhBU1VXYlN4?=
 =?utf-8?Q?2tUqE26jAiNSitKeNWuilZbS3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0d983-5d48-4592-af41-08dbe6364faf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 23:55:14.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ251LOduX/GNVJrldFhhpI5UlIi/MCFyVD0RUJd8JJ44ka8qxsHOlrlfb7iVN7bHy4eIoXAsw+FaiQfmF02Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com



On 11/15/23 16:32, Alison Schofield wrote:
> On Tue, Nov 14, 2023 at 11:25:20AM -0700, Dave Jiang wrote:
>> Cleanup the rwsem usages in the poison ops to reduce complexity and reduce
>> code lines.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>
>> Hi Alison, follow on patch to yours. Can't be backported, but nice clean
>> up going forward.
> 
> Tell me more about your backport worry.  Are we expected to avoid using
> the new guard any place where there is a backport possibility?  

Given that there's none of the cleanup.h support in stable kernels, I don't see how we can backport the guard() code automatically. Thus your original fix with a fixes tag plus a new cleanup patch follow on w/o backport issues seems necessary. Otherwise a separate backport patch would be needed no?
> 
> I'm thinking I should just rev the patch with your updates.
> 
>>
>>  drivers/cxl/core/memdev.c |   32 ++++++++++++--------------------
>>  1 file changed, 12 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 961da365b097..9ab748fadb38 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -227,8 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>>  	if (!port || !is_cxl_endpoint(port))
>>  		return -EINVAL;
>>  
>> -	down_read(&cxl_region_rwsem);
>> -	down_read(&cxl_dpa_rwsem);
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>  
>>  	if (cxl_num_decoders_committed(port) == 0) {
>>  		/* No regions mapped to this memdev */
>> @@ -237,8 +237,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>>  		/* Regions mapped, collect poison by endpoint */
>>  		rc =  cxl_get_poison_by_endpoint(port);
>>  	}
>> -	up_read(&cxl_dpa_rwsem);
>> -	up_read(&cxl_region_rwsem);
>>  
>>  	return rc;
>>  }
>> @@ -324,12 +322,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>  		return 0;
>>  
>> -	down_read(&cxl_region_rwsem);
>> -	down_read(&cxl_dpa_rwsem);
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>  
>>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	inject.address = cpu_to_le64(dpa);
>>  	mbox_cmd = (struct cxl_mbox_cmd) {
>> @@ -339,7 +337,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  	};
>>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>  	if (cxlr)
>> @@ -352,11 +350,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  		.length = cpu_to_le32(1),
>>  	};
>>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>> -out:
>> -	up_read(&cxl_dpa_rwsem);
>> -	up_read(&cxl_region_rwsem);
>>  
>> -	return rc;
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>>  
>> @@ -372,12 +367,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>  		return 0;
>>  
>> -	down_read(&cxl_region_rwsem);
>> -	down_read(&cxl_dpa_rwsem);
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>  
>>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	/*
>>  	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
>> @@ -396,7 +391,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  
>>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>  	if (cxlr)
>> @@ -409,11 +404,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  		.length = cpu_to_le32(1),
>>  	};
>>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>> -out:
>> -	up_read(&cxl_dpa_rwsem);
>> -	up_read(&cxl_region_rwsem);
>>  
>> -	return rc;
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
>>  
>>
>>
