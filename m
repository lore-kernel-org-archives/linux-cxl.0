Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F866EB45
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsbRgd9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705075058; x=1736611058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73HJAwXIdM/qtHIa+LS9oupovQgQvLJEmxFlVErkg+k=;
  b=AsbRgd9kF8y3lP59q1BVFM4pOplhKQhDOdrCCK7LqPFHAQn3uOypVehZ
   L397QJGWCZaP/rhYNgNHI+PnYvGm54BtJsTOfALey4/08T0h6dCi4hDmq
   VVXNSpwy3kkbict9D7WwS9rlvEiIuq8uFdjMGqyQwcc0oNL8d09aLakDP
   TeKQ2FZADLj5P1Vn5Aiy88c/tFguLuvvwbiHFLpaJO+bNULHoQ6m/F9C+
   d/WCMVmB29BQ5nY+V/QBMwzYvESmpCOvVF9iuFDP5jP3MUL83VnznuT9X
   seaeL3Qv0gJKX0YDuejmpOXHphOvNd+oPzTxwR48yQrXLKCxQsSXLTx2+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="389644856"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="389644856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 07:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="902007369"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="902007369"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 07:57:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 07:57:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 07:57:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 07:57:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arua6CjMpOyJsJFkP2YHCp3QxsJvCrG9qm/KoIUX2llIJv1O0bBArlGj26yn7XtZn8iEssTMxCf6sZRaT9bqcHpR59ctofqpdLMdM6IabexOjsEUrQXV2hcZd0LkW+KaQrBUy8cmBoq9En3qHbubaBELrXKj7yfUuYNtZRrAvAvAMyDj2Y03C20FN5lMPcFOJWezfowVX1EHsnqhsr9Dd3P21CaZpKxyKiTY6Xa9C+r44n0qLu68l9EWdWikQxGJ+MQegNMD4pEC57881brATbfVdtGMmryy7gwP13L4MtYHFu0JFpIRoZaxzPrtvtLDpmskAmJVSf3jq4UCLKmjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ml5O4jbHO6E1YVwIBhW1uzSp+mWct87xp5Rc3eGKc=;
 b=CFHjKC3GFZtewc9syUbFmjQHVYX+HBhp3j36npb3tSuXT4U7iu4JLWd/6XAK7MNedY/uabjaNC3JaH6LkXlVGzL9UWPOH9aSXpDvPuIe2gOZhWRGHem6RldTtvv2dhcUHYfcDQXee+PVOOB30xdkFIa+0JHhnZ7XOeat8adf1Wa/xs5NTGydNg94gy5jD1fVlEPOluu8EOgFGJ4bMTZ5ClQnVvWzIT/dz//XIHyeXw9E/QjKbalOSL/pi7TrXJPEHaib7NlgK5Ocgz3Vn7brotSxRjg+ZqW7GBzBpv3y6Y9ZKy6zWkDZkVErnz3vV9YEnB7Hl3OQS8TWSaNuwD0cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 15:57:32 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 15:57:31 +0000
Message-ID: <cda8dc67-5955-40fd-a40d-c777a14275d9@intel.com>
Date: Fri, 12 Jan 2024 08:57:28 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240108121538.00001369@Huawei.com>
 <38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
 <20240109162753.00005b2b@Huawei.com>
 <659d9e563e1fd_24a8294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <20240110100048.000062c0@Huawei.com>
 <6132c975-3208-40f4-a710-b7b7dac608a1@intel.com>
 <20240112113023.00006c50@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240112113023.00006c50@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a5817e-b424-4ebf-2b28-08dc13872f54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +b+2W0GD0BZtigtJAVsEnTcx2RiddAs3fA1FWmIP29FAZIr9oq8WlFvKXPeNLUj/kvVIOD2fFL34eZfxZ+yr6J+uoD04+cwC/9eLjyQdETaLRaqAvjI+sCRe0P7A8kgHnXCd530M2gKsXGQhdKS6dPzMYCXs7+c/730pwZPejQ4vc5HdypdNzAj333bepcfz5vR2/wKW55MmwMLD6iFpoQmSl7q64NcYjcgVSQSb2MmoAkTCWzP5wI0qM67zKNTX8jNbwkOHHLbTSiqR29m3pp36fe3maFNPZ6eejVRYL7xj900qBRjfCjIMgE3+bE85Hdf53sNm6GJcTc+PXLM4MV9RtKT7WiIdjqf5mgo5NMRHOtKn3UrT+wSqAbyy3i3ysr7qX5lZWp9P/NhrzJj1i3paYqp0b9rSxGjQMtkXGDRUaX+XgIAE9C1W8p4e/OGgPRggzjRNs7FRaDe1fwICTuAi2trRg10rD0pf82FdE1ENzyCK9mz1qt6SzAxmppO/L0g7eILPxVNoZuD0s+64pSGp3rV6jPRqxQHtPkg3d9TkdHfWQF3r7fT2lei51fCYbfpfeJ4Jdgiy2BcOKN0uMCDtH84nDsLdI9U3Y9nG11oCyl14fQbeaS8G27S0mInl0Rs7QIYElmuH2Kg6sET7QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(66556008)(6916009)(66476007)(66946007)(316002)(53546011)(54906003)(6512007)(8676002)(86362001)(26005)(8936002)(4326008)(6666004)(966005)(6506007)(31686004)(478600001)(82960400001)(31696002)(6486002)(44832011)(38100700002)(30864003)(2906002)(5660300002)(41300700001)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1Vpb2dPVUpFdmlhNC96dFlTTGFmZlMySVF6cHFMOWRLMEd5RlhWM1lZbXhi?=
 =?utf-8?B?Wmw1VEdWOTBxTDRVV1Fhb1o0eFU3bGxvb2ZnMU1GdFozakwrSFFkVE9jUzdW?=
 =?utf-8?B?TXZqb3RibzJiQzQ3V0I5R1h4bUplMTVGalBXV2J5ckFBN1NQWGtXcTFKMmpi?=
 =?utf-8?B?U1R0OFU5U2RyYnA1OG92Z016V3VsbzlsQWZzUjBxVmNBV1o1VmxqRVVMOVlo?=
 =?utf-8?B?Smplb2UrMDVwbkdyUkNGdjg4azZ5Tk9rU2RnbFd3UTk1OHBWVUZxZW1RUVkx?=
 =?utf-8?B?aC9GdW1sT3I4QzBFTzB4c0pFcVhDWFNTUXp2a0xlc2RBT2dWSVJZMTFKSFFJ?=
 =?utf-8?B?L3o5VWFBU2pQVXE1bVRzbDd0elBSYTB1RTJrRmtvR2xvWUZUaFdWTElocDFa?=
 =?utf-8?B?UHg2SHNUbCtGeVJEVjRyTFBHK3ZuWU54WXBBNDUvTi9uUjZHMHpIZEZrM0Zl?=
 =?utf-8?B?QitGS293b08wQVoyQTBpVnExU285djQ5QTZBZWtPMFI0SU9Nb0RyUU5rQy9G?=
 =?utf-8?B?TC92cWEvT3E5eUM4cDRPbTZyVWxHeDZqTitQYUFIT21PQWhCS3BVb210a2h5?=
 =?utf-8?B?RXM3NEQ5ME5PbFNOU0pPTExHWWZCcXdKVElVUGxyZGlQamNZYVhZMHQxVDVS?=
 =?utf-8?B?UGJPdll2RG5wMm5nUS9iV0JBZmI3aC9Bb1gwcEYvQmVJU2dHeWdDbXRsNVhV?=
 =?utf-8?B?d1gwbFBKYlVkampPUWtXN3ZFQmc2SENmMXcvTC9FSGR1S1hyQ1NVdGcxblZI?=
 =?utf-8?B?aW04OW9HczBmU1JuT2ptMEJXazcwS1JqK1piSlIxOTgzbnRjVFIwdWN6MUU1?=
 =?utf-8?B?NnZjYXRMQWdQVVd5OTVicGswalAxSVhwRWlxSkxnRXdobDRGUk1GQWVQVkRD?=
 =?utf-8?B?Z0pWeE5OWlJVYStac1lwQ250dWxjbEdtV0F2anJSVUxQelRNd3Urc3VvUUsz?=
 =?utf-8?B?R3RrMnVoMHZQSmQxQm9qdDhXM09xWVNORU1SQ2ZzMWZrdWVzS0Y5N0FydFFM?=
 =?utf-8?B?YlNtRWdJZWs0SVFEV0pwelhobzB6V1RrQ2tXUGtrdTlpTnBKb3BTd1JsVWw0?=
 =?utf-8?B?V3BPcURHTHdwVTZ5VTRadmFacjJBYVpGajh5eU9lMlJkcWx5VnF3WFpWbi80?=
 =?utf-8?B?b3RTMVhNQ1Nlenp6ZEIwVkd4NTdjU3RjbjNoOEJrRDVsOXpGTTU1ZDhUWVZM?=
 =?utf-8?B?aEd3Z1VIZnk5NW03UjJZMkhjeTZNbkg4N2JGL2FubUlOQWFxRkliWXoxa2dy?=
 =?utf-8?B?dUZkNWRkRW9nSmVTS3FYZjNyY1pRZUdVMVNnOXRqVE5GaWJheUQ5UEtoWGRP?=
 =?utf-8?B?WThuRmpwTS9NRlNLZmlRanRIMWR6QlZEWFpPaW5SVlR4dGJja3VHTXNxSmwz?=
 =?utf-8?B?ZE9QM0FMNU5VZEdSY1hENUY5OUlpUEVobUQ5MEhTNkdnZXd3T3pJcCtLbnBw?=
 =?utf-8?B?bytLaWRrNU1xamFOVThEUnhYdldTVTZZczNFb3FGdnFTSzc2ZGQyUG9pZmdt?=
 =?utf-8?B?em1mM05vYnN1RjV0Y0VkRDkxMFpISVhZb1AybFI2Q2pWdWJMU0dBZHFOOE5i?=
 =?utf-8?B?SWRqMURlVytKMkwzWFNpY05BQjN1M2gvUnorZ0o3dm9jZVlyaTdQNVowSGM3?=
 =?utf-8?B?RkVvS1NacU5jejNFK0lCUGErVEpIcHZTd0JkSnVSV1FneGdkdTZjZGd3YzNu?=
 =?utf-8?B?dHVoa3YyWlZsMm9nQmE5S0dxZTNFdjcrYXdxOGJLenFGZW00NGVrZzRSRkNi?=
 =?utf-8?B?WGkyRGZteEczV1RESThHdUpzckVsbWJmNThZcmh5UXNxTDZnNVh3NFZXem5u?=
 =?utf-8?B?dkkvRzZuZ2Y1eWlFQmFYcCtlMndqYmQyWHFIYVRtNG92QitqcjBiUnNib1I0?=
 =?utf-8?B?U3lQcTJhcDB6MXg1c1p2Y0hRUjcwbGU5dHBFaGJXUUMwUGZiOVdzeFpjNmRT?=
 =?utf-8?B?WFQzSzVwUW02cXpkdXJzTnpRWVBQYTZRVU1HVXByUk05Z3M0ekUzeUFGSTJx?=
 =?utf-8?B?aEtNeUZZSklKeGtmVVFBeVN4K0R4UnNiNmRuYUR5L3cwMEJrRDdZWjBUS2Rk?=
 =?utf-8?B?aFJLcy9UY2tVTUVNMnNGcjhNSkVwZG5PeC9jVitUWjZtMEZtN1FOMTdHR3Y2?=
 =?utf-8?Q?DPpvibz0CugFvDNdrxJSvmR0H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a5817e-b424-4ebf-2b28-08dc13872f54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 15:57:31.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zX+7QH8nqbnHtxXnjoiQmEI45aR52uwiePhMPLPOjD6+0QIkrAijnB4/YcyI5R00RzptDuj0BuSEDIs79EXVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com



On 1/12/24 04:30, Jonathan Cameron wrote:
> On Wed, 10 Jan 2024 08:27:57 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 1/10/24 03:00, Jonathan Cameron wrote:
>>> On Tue, 9 Jan 2024 11:28:22 -0800
>>> Dan Williams <dan.j.williams@intel.com> wrote:
>>>   
>>>> Jonathan Cameron wrote:  
>>>>> On Mon, 8 Jan 2024 11:18:33 -0700
>>>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>>>     
>>>>>> On 1/8/24 05:15, Jonathan Cameron wrote:    
>>>>>>> On Mon, 08 Jan 2024 14:49:03 +0800
>>>>>>> "Huang, Ying" <ying.huang@intel.com> wrote:
>>>>>>>       
>>>>>>>> Dave Jiang <dave.jiang@intel.com> writes:
>>>>>>>>      
>>>>>>>>> When the CXL region is formed, the driver would computed the performance
>>>>>>>>> data for the region. However this data is not available at the node data
>>>>>>>>> collection that has been populated by the HMAT during kernel
>>>>>>>>> initialization. Add a memory hotplug notifier to update the performance
>>>>>>>>> data to the node hmem_attrs to expose the newly calculated region
>>>>>>>>> performance data. The CXL region is created under specific CFMWS. The
>>>>>>>>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
>>>>>>>>> Additional regions may overwrite the initial data, but since this is
>>>>>>>>> for the same proximity domain it's a don't care for now.
>>>>>>>>>
>>>>>>>>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
>>>>>>>>> for a node. The sysfs path of
>>>>>>>>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
>>>>>>>>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
>>>>>>>>> to the proximity domain of the CXL region.      
>>>>>>>
>>>>>>> As per discussion below.  Why is access1 not also relevant for CXL memory?
>>>>>>> (it's probably more relevant than access0 in many cases!)
>>>>>>>
>>>>>>> For historical references, I wanted access0 to be the CPU only one, but
>>>>>>> review feedback was that access0 was already defined as 'initiator based'
>>>>>>> so we couldn't just make the 0 indexed one the case most people care about.
>>>>>>> Hence we grew access1 to cover the CPU only case which most software cares
>>>>>>> about.
>>>>>>>       
>>>>>>>>>
>>>>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>>>>>>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>>>>>>> ---
>>>>>>>>> v3:
>>>>>>>>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
>>>>>>>>> - use read_bandwidth as check for valid coords (Jonathan)
>>>>>>>>> - Remove setting of coord access level 1. (Jonathan)
>>>>>>>>> ---
>>>>>>>>>  drivers/base/node.c       |    1 +
>>>>>>>>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>  drivers/cxl/cxl.h         |    3 +++
>>>>>>>>>  3 files changed, 46 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>>>>>>> index cb2b6cc7f6e6..48e5cb292765 100644
>>>>>>>>> --- a/drivers/base/node.c
>>>>>>>>> +++ b/drivers/base/node.c
>>>>>>>>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>>>>>>>>  		}
>>>>>>>>>  	}
>>>>>>>>>  }
>>>>>>>>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>>>>>>>>  
>>>>>>>>>  /**
>>>>>>>>>   * struct node_cache_info - Internal tracking for memory node caches
>>>>>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>>>>>> index d28d24524d41..bee65f535d6c 100644
>>>>>>>>> --- a/drivers/cxl/core/region.c
>>>>>>>>> +++ b/drivers/cxl/core/region.c
>>>>>>>>> @@ -4,6 +4,7 @@
>>>>>>>>>  #include <linux/genalloc.h>
>>>>>>>>>  #include <linux/device.h>
>>>>>>>>>  #include <linux/module.h>
>>>>>>>>> +#include <linux/memory.h>
>>>>>>>>>  #include <linux/slab.h>
>>>>>>>>>  #include <linux/uuid.h>
>>>>>>>>>  #include <linux/sort.h>
>>>>>>>>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
>>>>>>>>>  	return 1;
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>>>>>>>> +					  unsigned long action, void *arg)
>>>>>>>>> +{
>>>>>>>>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>>>>>>>>> +					       memory_notifier);
>>>>>>>>> +	struct cxl_region_params *p = &cxlr->params;
>>>>>>>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>>>>>>>>> +	struct cxl_decoder *cxld = &cxled->cxld;
>>>>>>>>> +	struct memory_notify *mnb = arg;
>>>>>>>>> +	int nid = mnb->status_change_nid;
>>>>>>>>> +	int region_nid;
>>>>>>>>> +
>>>>>>>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>>>>>>>> +		return NOTIFY_DONE;
>>>>>>>>> +
>>>>>>>>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
>>>>>>>>> +	if (nid != region_nid)
>>>>>>>>> +		return NOTIFY_DONE;
>>>>>>>>> +
>>>>>>>>> +	/* Don't set if there's no coordinate information */
>>>>>>>>> +	if (!cxlr->coord.write_bandwidth)
>>>>>>>>> +		return NOTIFY_DONE;        
>>>>>>>>
>>>>>>>> Although you said you will use "read_bandwidth" in changelog, you
>>>>>>>> actually didn't do that.
>>>>>>>>      
>>>>>>>>> +
>>>>>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>>>>>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);        
>>>>>>>>
>>>>>>>> And this.
>>>>>>>>
>>>>>>>> But I don't think it's good to remove access level 1.  According to
>>>>>>>> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
>>>>>>>> characteristics").  Access level 1 is for performance from CPU to
>>>>>>>> memory.  So, we should keep access level 1.  For CXL memory device,
>>>>>>>> access level 0 and access level 1 should be equivalent.  Will the code
>>>>>>>> be used for something like GPU connected via CXL?  Where the access
>>>>>>>> level 0 may be for the performance from GPU to the memory.
>>>>>>>>      
>>>>>>> I disagree. They are no more equivalent than they are on any other complex system.
>>>>>>>
>>>>>>> e.g. A CXL root port being described using generic Port infrastructure may be
>>>>>>> on a different die (IO dies are a common architecture) in the package
>>>>>>> than the CPU cores and that IO die may well have generic initiators that
>>>>>>> are much nearer than the CPU cores.
>>>>>>>
>>>>>>> In those cases access0 will cover initators on the IO die but access1 will
>>>>>>> cover the nearest CPU cores (initiators).
>>>>>>>
>>>>>>> Both should arguably be there for CXL memory as both are as relevant as
>>>>>>> they are for any other memory.
>>>>>>>
>>>>>>> If / when we get some GPUs etc on CXL that are initiators this will all
>>>>>>> get a lot more fun but for now we can kick that into the long grass.      
>>>>>>
>>>>>>
>>>>>> With the current way of storing HMAT targets information, only the
>>>>>> best performance data is stored (access0). The existing HMAT handling
>>>>>> code also sets the access1 if the associated initiator node contains
>>>>>> a CPU for conventional memory. The current calculated full CXL path
>>>>>> is the access0 data. I think what's missing is the check to see if
>>>>>> the associated initiator node is also a CPU node and sets access1
>>>>>> conditionally based on that. Maybe if that conditional gets added
>>>>>> then that is ok for what we have now?    
>>>>>
>>>>> You also need the access1 initiators to be figured out (nearest
>>>>> one that has a CPU) - so two separate sets of calculations.
>>>>> Could short cut the maths if they happen to be the same node of
>>>>> course.    
>>>>
>>>> Where is "access1" coming from? The generic port is the only performance
>>>> profile that is being calculated by the CDAT code and there is no other
>>>> initiator.  
>>>
>>> This isn't about initiators on the CXL side of the port (for now anyway).
>>> It's about intiators in the host system.
>>>   
>>>>
>>>> Now if "access1" is a convention of "that's the CPU" then we should skip
>>>> emitting access0 altogether and reserve that for some future accelerator
>>>> case that can define a better access profile talking to its own local
>>>> memory.  Otherwise having access0 and access1 when the only initiator is
>>>> the generic port (which includes all CPUs attached to that generic port)
>>>> does not resolve for me.  
>>>
>>> The initiators here are:
>>>
>>> * CPUs in the host - due to limitations of the HMAT presentation that actually
>>>   means those CPUs in the host that are nearest to the generic port. Only
>>>   these are considered for access1. So for simple placement decisions on
>>>   CPU only workloads this is what matters.
>>> * Other initiators in the host such NICs on PCI (typically ones that
>>>   are presented at RCiEPs or behind 'fake' switches but actually in the same
>>>   die as the root complex)  These and CPUs are included for access0
>>> * (not supported yet). Other initiators in the CXL fabric.
>>>
>>> My ancient white paper needs an update to include generic ports as they do
>>> make things more complex.
>>> https://github.com/hisilicon/acpi-numa-whitepaper/releases/download/v0.93/NUMA_Description_Under_ACPI_6.3_v0.93.pdf
>>>
>>> Anyhow:  ASCI art time. (simplified diagram of an old production CPU with CXL added
>>> where the PCI RC is - so no future product info but expect to see systems that
>>> looks similar to this :))
>>>
>>> Note the IO die might also be in the middle, or my "favorite" design - in a separate
>>> package entirely - IO expanders on the inter socket interconnect - (UPI or similar) ;)
>>> Note these might not be physical systems - an example is a VM workload
>>> which occasionally needs to use an 'extra' GPU. That GPU comes from a host socket
>>> on which the VM has no CPU resources or memory.  Anyhow given the diagrams
>>> I've seen of production systems pretty much anything you can conceive is is being
>>> built by someone.
>>>
>>>         ________________      __________________
>>>        |                |    |                  |            
>>>        |  Host DDR(PXM0)|    |  Host DDR (PXM1) |
>>>        |________________|    |__________________|
>>>               |                       |
>>>        _______|_______         _______|____        _________________
>>>        |              |       |            |       |                | 
>>>        |   CPU Die    |-------|  CPU Die   |-------|  IO DIE        |
>>>        |   PXM 0      |       |  PXM 1     |       |  PXM 2         |
>>>        |              |       |            |       |  NIC (GP + GI) |
>>>        |______________|       |____________|       |________________|
>>>                                                            |
>>>                                                     _______|________
>>>                                                    |               |
>>>                                                    |   CXL Mem     |
>>>                                                    |               |
>>>                                                    |_______________|
>>>
>>> So in this case access0 should have PXM2 as the initiator and include
>>> the bandwidth and latency numbers from PXM2 to itself (where the GP is)
>>> and those to the CXL memory that Dave's code adds in.
>>>
>>> Access1 is from PXM1 to PXM2 (to get to the GP) and on to the CXL mem.
>>>
>>> Note that one reason to do this is that the latency from the NIC in PXM2
>>> to CXL mem might well be not much worse than from it to the memory on PXM 1
>>> (cpu Die) so placement decisions might favor putting NIC buffers in CXL mem
>>> particularly if the bandwidth is good.
>>>
>>>
>>>   
>>>>  
>>>>>> If/When the non-CPU initiators shows up for CXL, we'll need to change
>>>>>> the way to store the initiator to generic target table data and how
>>>>>> we calculate and setup access0 vs access1. Maybe that can be done as
>>>>>> a later iteration?    
>>>>>
>>>>> I'm not that bothered yet about CXL initiators - the issue today
>>>>> is ones on a different node the host side of the root ports.
>>>>>
>>>>> For giggles the NVIDIA Grace proposals for how they manage their
>>>>> GPU partitioning will create a bunch of GI nodes that may well
>>>>> be nearer to the CXL ports - I've no idea!
>>>>> https://lore.kernel.org/qemu-devel/20231225045603.7654-1-ankita@nvidia.com/    
>>>>
>>>> It seems sad that we, as an industry, went through all this trouble to
>>>> define an enumerable CXL bus only to fall back to ACPI for enumeration.  
>>>
>>> History - a lot of this stuff was in design before CXL surfaced.
>>> I think we are all pushing for people to reuse the CXL defined infrastructure
>>> (or similar) in the long term to make everything enumerable.
>>>
>>> Arguably for a host system ACPI is the enumeration method...
>>>
>>>   
>>>>
>>>> The Linux reaction to CFMWS takes a "Linux likely needs *at least* this many
>>>> memory target nodes considered at the beginning of time", with a "circle
>>>> back to the dynamic node creation problem later if it proves to be
>>>> insufficient". The NVIDIA proposal appears to be crossing that
>>>> threshold, and I will go invite them to do the work to dynamically
>>>> enumerate initiators into the Linux tracking structures.  
>>>
>>> Absolutely - various replies in earlier threads made that point
>>> (and that everyone has been kicking that tire down the road for years).
>>>   
>>>>
>>>> As for where this leaves this patchset, it is clear from this
>>>> conversation that v6.9 is a better target for clarifying this NUMA
>>>> information, but I think it is ok to move ahead with the base CDAT
>>>> parsing for v6.8 (the bits that are already exposed to linux-next). Any
>>>> objections?
>>>>  
>>> Should be fine if we keep away from the userspace exposed new bits
>>> (though I think we can clarify them fairly fast - it's a bit late ;(  
>>
>> The only exposure to user space is the QTG ID (qos_class) based on access0 generic target numbers.
> 
> That's a fun corner case.   Which one is appropriate? My gut feeling is access1

I can fix that in my next rev of the HMEM_REPORTING series if your guidance is to go with access1. It should be a 1 line change within the new changes coming that addresses access0 and access1 for CXL.

DJ

> but if the GI is in the host, then the QOS may want to reflect that. If the GI
> is on the CXL bus then whether host QOS matters is dependent on whether P2P is
> going on and where the bottleneck that is driving the QOS decisions in the host
> is.
> 
> Let us cross our fingers that that this never matters in practice.  I can't
> face trying to get a clarification on this in appropriate standards groups given
> it's all a bit hypothetical for QOS (hence QTG selection) at least.
> 
> Jonathan
> 
>>>
>>> Jonathan
>>>
>>>   
> 
