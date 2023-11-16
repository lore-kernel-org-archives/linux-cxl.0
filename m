Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co2OViqS"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900DD192
	for <linux-cxl@vger.kernel.org>; Thu, 16 Nov 2023 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700152033; x=1731688033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MsLEPscoIO4fBHzq/DuzDC5ssZpFZ/+qyRMnDHAgRg8=;
  b=co2OViqS0Y/3etG+GeO4bvI7OfpmPDq1CA2zF2ei27Ay4qR4Ek/qM5Iw
   j6/AgEwp2Na5xsOeyjxTLwX/isyWJu020kxjGtPAah2vQqHG/udXecDjA
   3cBairMwz1YAhuvLq1jfU3K3suJXpkj2j3pEpWFNfNRznou6Hy0u+O8yL
   2peWZMQjJT/sPMAUdiuJx/r4yi/r070Sch8+Yrc0T6rtTcttXLpLdyCRJ
   rn5jTCuJPLv9Ctbvnq5akxcFAFmXQ4YmsXBSl1WzhQLDO46JkmPjxwWlF
   v/qvE9SPtCyC0bumbm2jyM2WJIqzJwtOhIJRGikXpyHToZsvMRYcw9SCf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="389978066"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="389978066"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 08:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="882802878"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="882802878"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 08:27:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 08:27:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 08:27:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 08:27:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baJQsBzmdLoVvCd1TJ/npoLY1YjC8VtsN0u3MjEqGnnTZBiORRsToAj/qjMpMU1yGbSgwSNoefZo5tl6+lgMtCstdvGl5xfSDEVQXxHqdihRKKH1CY+XrlV6w5h61COIUGnlDyKtVWePXqq9zYdU93Ulr+N65E2xQucSC6/W2v+eSGuRddJxEnWxdfJ5smfok9ro6n3t2K5uOiq0MvGx4ytB2xOdj6xVQA7NJgbKmRnryfkH8ayDouNmb6/F03JOBYzeK26PvQn+Qv3CP6PdGRT3lgBN7+OGp703AvW3E5jKFjZLVNTSj8nUVUP4gWwiBpTT6KSYDaT/x6orwCbyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdNmHtkqtMsjsqPUOMXFHDw9R1HPJmUfyNKm3ioD4rQ=;
 b=RvEgUgwMxzPpQT3dAZIqZTLvFuOpCS9q5L7gQlTQ57v3I6AhYRROhvp+CN+xszHZzoY5Gl8quu/lhsEbZAaOAQuWY2zeRLd/7o5zvqiJG+TjY3tRFoB5HRVbS2ZMOtCn5pahafHnkddZ1tQ9ZvWlucUeZYa8hCh1vRiMBdvNByuUPBC8aHJEPsZ4THPLqOgGQf4U0vrYprywyajE+6Jl/cnijjMNKLCNAA8SDdcrPSGNd55wA4fnxDt4zxu5INd3v8K2xlK13sVu21vPFKuq6T5s5awy2tbj/N4AaN0modM1eQ2rlmBQ7VPAc3fl7t90ZhNJUSic2V+D9kSZF/ejCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 16:27:10 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::66f8:2b23:6ddb:e566]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::66f8:2b23:6ddb:e566%5]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 16:27:10 +0000
Message-ID: <37212b16-9176-497b-a2e2-26943acfdcb6@intel.com>
Date: Thu, 16 Nov 2023 09:27:07 -0700
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
 <c35ce419-4881-4cb9-999e-d3034ecad8ab@intel.com>
 <ZVV7nYEFHVuXskm2@aschofie-mobl2>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZVV7nYEFHVuXskm2@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:a03:54::46) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|LV3PR11MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: f160ef0d-7b68-4868-2037-08dbe6c0e1ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJFyAOcGYR++OV0Gtl7mycprp9MSd100AtOvlwvRGnpja3XseJ6EFe2b5UhNO4YenWm2phqRo1X/lpjd1IWzF61ye0J3dFTKr72Fcun7Pd6pzRmbEeM4piTG9U9ujPtmFe6v00gpg2OrnJgg2IKsC93zLPizLw9CjVRfvkTVHssi4pTZXxusu8cc0JTONurLsBCCKXsWuzqbseuv48TFKVh9elw98rO/Xv2C9t/6OgH3R1XkKJYE4NaLUWEpKxVqsLrrrfXWWY+ouAU6D1PUgBxo+nKrMIKWLtRSQTFL43JV/VxvyyDuk8b6WpHIsxk+5MLIn9HBm6CUC3ZGqaojin59Ij6/hB2e3HLRjDzc0f/6gaOP8tJzHrY38Dq1S+yDarWymnNFnZX5gj28OfPb0f1vp+SHW/kFQk9FFMbpJ/p4fPviPnPoIQL3VbZrdjFT6TnkQSt85u7AAkDHr59IpiM5trG0xRsBIbDwOiFPQD7i3iFXeuKbDP1gddSoWlug1qG+j1C9t8vsYaKY7n+Qps1UDcghGsoq8Ycb0JNKmv3FOAon1RRmP/vN1b0gKKQdwoi05mIJpLSgPpgFCrSqg9CAtx/XGuh0X2/tc1MUKAyLZY2x6dCIfSqjLVpsTC+N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5990.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(6666004)(31696002)(478600001)(8676002)(6636002)(6862004)(8936002)(4326008)(53546011)(6506007)(316002)(37006003)(66476007)(2616005)(107886003)(26005)(66946007)(31686004)(66556008)(44832011)(82960400001)(6512007)(6486002)(83380400001)(5660300002)(2906002)(36756003)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pzdGlpTGhyK2t2djBBSTc0NzREY0tBOEVxcmVZNTN2cTkxYXlYSWFpVVFK?=
 =?utf-8?B?eDNrNUU0WlRPcWZtYy9ZVkY4KzRiaVR4bXVBTmYrRTRmMXJtY1g1a0VIMmox?=
 =?utf-8?B?SzFQVVZzT0s3YWV3QWRtT1Q0cXYxNlExLzVyQUJxQUZjcGx0bktHUmwrMVRL?=
 =?utf-8?B?R0dDVzk0Ry9iU3AxRnRDdUV5M2RpRnJtNC9ZMFVENEVFZ1JHMERPcXU5Yi9k?=
 =?utf-8?B?ZGg4VUxRWDdMa2MzaFlSZGRBQWZIaU1LdE93VmFSTmNRbi9YVUw1anE3MGZZ?=
 =?utf-8?B?cFN0b1d5cTNqMU9QWHkyektVTFdYNGZRK3oyZWxxbW9uQ3dEU0FtRFlhZTJV?=
 =?utf-8?B?YW82TkI2RGtSYnpVb2NCZWVLN3BjWTh6VktZaWUyNnJycHVhSUJHbkFSc1U3?=
 =?utf-8?B?WGtHU0xRNXJXeW9QbzBVWlIrVEtZeUs4K3NWeTRTZXk2TXdhQWxtb2JlR1d0?=
 =?utf-8?B?aTliTWdnTWlRUmlneHd2R2dsaG1hdGNHVndaMk1qLy9RTXR2WlBlb3ZWUTRt?=
 =?utf-8?B?MlVEbS8xd0pCYVVTWEF1ZVdQZ1YwK09NV0lDbmdRWG5LYWlBaW5JS0dTakg5?=
 =?utf-8?B?VmIzcHdtd3ZJVVBKN0p1VUMrUFpGZG14WG5IRlFsSlgvRjJzMXBKQnJKSVJZ?=
 =?utf-8?B?SW41dk5EOXdjdWtUbmVzWTRpUEVmNUN6L1FCMmlwdXgzdE1lZjRyVDFRTkQw?=
 =?utf-8?B?RERQZUpCeWkyMFVXVUEwYlNUYmE0TUcvNFJ2b3RIS3JhZnZnUTI4ajhuZklo?=
 =?utf-8?B?MnZab2UvSkFVMHRnVmUwbnJsdk82R2ZRV3FlR2o2SllWM2lUcjN1b3dtQnhB?=
 =?utf-8?B?ZTJrenBlUDF0UGhycFZtN3FRa0JkeHVhRTFYNmluZUlZdjk4aWp1Y2FCUG5u?=
 =?utf-8?B?dE8yR3FrWklaNkRuM0N1a3F1VXNyVlEwbkxKOFJFdmpieU16RmNrZmp4KzFO?=
 =?utf-8?B?ZUVKQ0I1R3RYa2IwTll5QUpLbWdyV3UrSDFPbUpUMHBNd25EMTNVL0JvNDJo?=
 =?utf-8?B?anNCMEJobHpCSGdQWUVXTGFuQ2VBRTF0dExaVGs4VGQyak5EUjhMVWJKcWp3?=
 =?utf-8?B?UHdKTFZrK0RGaENiMDd4Zlh6amtzdlVrQTRldStrcytvb3JLemtYV3M3ZUVN?=
 =?utf-8?B?OThoYStSTytOOXR5RXJLcXk5RGNIQTRvU292SU9kM0RTczNRbG9HNkt6TlZX?=
 =?utf-8?B?UllhSkszajRndDF2bm9QeCtHcDdsU05XNE5KNCszSER1bGJ4OFBkcHZYNDBJ?=
 =?utf-8?B?eG1WZzRhS1ZPS1VMVzBRTTdmNFMxUkw4SitjVTZKZmV1ejJGenI2cXd6UzAr?=
 =?utf-8?B?OGhrVDN6L01vUkxPTmV4bHVtWUFRbFB5dWpSQ1Ywc1V5M1RxNGx6RG81azhT?=
 =?utf-8?B?SEZadzRneXdFeFo4amp0M0hWeHNxekJSVWNrVTkra2o0ejJYeTFidzlIS1hY?=
 =?utf-8?B?NFFSUUI2OTNXc2I1OFRtL3N2aEI2Q09pWHI4Vy95VmhKRStkcTFnL0JCSFdG?=
 =?utf-8?B?Ylg4bk1Tc0dSbnlkeTVicUVKV0hjTVhNNkpwL0RRTWhvSHBTRThQbTJ3cnF0?=
 =?utf-8?B?ZkdnQ1EwK1ZmM1pDYTdYMXl5ZEhIVjRlSWZiT0V2MUFaUXF0ZHZiT0szWFho?=
 =?utf-8?B?MWlNS01LbHZOVjFwU2dNd2hvUVNKemFvdmxsVEgrVmFkWVJhTUZ6ZndkaDJw?=
 =?utf-8?B?ZHBtQi9IQjVtdlJWRDBCWXROdlFrQzc1SFNqWjZXSFpINTRwT0tsdDhYUFZ1?=
 =?utf-8?B?dDc4WFM5TGJHWlE2QzliY2FFalgwUCtaUnBESWhQTVJ1RGJMY1I2a1VKRkds?=
 =?utf-8?B?ZXBtRnI5bWhDUXZiWTY0YlAvZmtPT08yT1p1ZUlLelR3SnlEREc2dklZeFRo?=
 =?utf-8?B?eGxtNFVwVDNvSlIxQW9UZmtDaThzcUIrZUpaOW9aeUZtK2g5bURpbUdzcHNX?=
 =?utf-8?B?dkd0MG0vQXdkWm0veEZsVkd1cFdrRXVCNU95OVZUMXVkamxUWnpqYk9xNUU3?=
 =?utf-8?B?VDlSZFFPdUErZ3pxMEpKUEYzbUJ4T3hxL0VoRWhXQ3R3UGIvV2s4TkdDTEU1?=
 =?utf-8?B?amRKWUJlSVRkZGM3YTZmVU5UNmxwYk1vTG5oSHh6WjJRanV3YkdKRU5NTWxj?=
 =?utf-8?Q?FMHs/hxcFcGh+dOQT5jC0wU1q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f160ef0d-7b68-4868-2037-08dbe6c0e1ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:27:10.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYxK0qEahYQjZMzJmDSE5BbhTfx24W5eR2HHK2LICky+IT7qw6jMmQO6qjwAr+hxzinXyrL1tgrsPlVPBExZ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com



On 11/15/23 19:17, Alison Schofield wrote:
> On Wed, Nov 15, 2023 at 04:55:11PM -0700, Dave Jiang wrote:
>>
>>
>> On 11/15/23 16:32, Alison Schofield wrote:
>>> On Tue, Nov 14, 2023 at 11:25:20AM -0700, Dave Jiang wrote:
>>>> Cleanup the rwsem usages in the poison ops to reduce complexity and reduce
>>>> code lines.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>
>>>> Hi Alison, follow on patch to yours. Can't be backported, but nice clean
>>>> up going forward.
>>>
>>> Tell me more about your backport worry.  Are we expected to avoid using
>>> the new guard any place where there is a backport possibility?  
>>
>> Given that there's none of the cleanup.h support in stable kernels, I don't see how we can backport the guard() code automatically. Thus your original fix with a fixes tag plus a new cleanup patch follow on w/o backport issues seems necessary. Otherwise a separate backport patch would be needed no?
> 
> Sure, it would be needed. I guess I'm looking for why this backport
> issue is so special. (not being sarcastic). Is there specific guidance
> not to use the cleanup stuff if we think a patch might be backported?
> I don't usually consider backportability when adding a Fixes tag to a
> Patch. Have 'backport folks' asked us not to use it?
> 
> I'm imagining the slippery slope of not fixing something the best way
> because we are worried that backport folks can't figure out how to
> merge it.

Just auto backport vs manual backport. And if you don't mind doing the work, then I guess use the new calls. 


> 
>>>
>>> I'm thinking I should just rev the patch with your updates.
>>>
>>>>
>>>>  drivers/cxl/core/memdev.c |   32 ++++++++++++--------------------
>>>>  1 file changed, 12 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index 961da365b097..9ab748fadb38 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -227,8 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>>>>  	if (!port || !is_cxl_endpoint(port))
>>>>  		return -EINVAL;
>>>>  
>>>> -	down_read(&cxl_region_rwsem);
>>>> -	down_read(&cxl_dpa_rwsem);
>>>> +	guard(rwsem_read)(&cxl_region_rwsem);
>>>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>>>  
>>>>  	if (cxl_num_decoders_committed(port) == 0) {
>>>>  		/* No regions mapped to this memdev */
>>>> @@ -237,8 +237,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>>>>  		/* Regions mapped, collect poison by endpoint */
>>>>  		rc =  cxl_get_poison_by_endpoint(port);
>>>>  	}
>>>> -	up_read(&cxl_dpa_rwsem);
>>>> -	up_read(&cxl_region_rwsem);
>>>>  
>>>>  	return rc;
>>>>  }
>>>> @@ -324,12 +322,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>>>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>>>  		return 0;
>>>>  
>>>> -	down_read(&cxl_region_rwsem);
>>>> -	down_read(&cxl_dpa_rwsem);
>>>> +	guard(rwsem_read)(&cxl_region_rwsem);
>>>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>>>  
>>>>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>>>>  	if (rc)
>>>> -		goto out;
>>>> +		return rc;
>>>>  
>>>>  	inject.address = cpu_to_le64(dpa);
>>>>  	mbox_cmd = (struct cxl_mbox_cmd) {
>>>> @@ -339,7 +337,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>>>  	};
>>>>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>>>>  	if (rc)
>>>> -		goto out;
>>>> +		return rc;
>>>>  
>>>>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>>>  	if (cxlr)
>>>> @@ -352,11 +350,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>>>  		.length = cpu_to_le32(1),
>>>>  	};
>>>>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>>>> -out:
>>>> -	up_read(&cxl_dpa_rwsem);
>>>> -	up_read(&cxl_region_rwsem);
>>>>  
>>>> -	return rc;
>>>> +	return 0;
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>>>>  
>>>> @@ -372,12 +367,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>>>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>>>  		return 0;
>>>>  
>>>> -	down_read(&cxl_region_rwsem);
>>>> -	down_read(&cxl_dpa_rwsem);
>>>> +	guard(rwsem_read)(&cxl_region_rwsem);
>>>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>>>  
>>>>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>>>>  	if (rc)
>>>> -		goto out;
>>>> +		return rc;
>>>>  
>>>>  	/*
>>>>  	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
>>>> @@ -396,7 +391,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>>>  
>>>>  	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>>>>  	if (rc)
>>>> -		goto out;
>>>> +		return rc;
>>>>  
>>>>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>>>  	if (cxlr)
>>>> @@ -409,11 +404,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>>>  		.length = cpu_to_le32(1),
>>>>  	};
>>>>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>>>> -out:
>>>> -	up_read(&cxl_dpa_rwsem);
>>>> -	up_read(&cxl_region_rwsem);
>>>>  
>>>> -	return rc;
>>>> +	return 0;
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
>>>>  
>>>>
>>>>
