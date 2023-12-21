Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C76F634F5
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXMydw6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703183016; x=1734719016;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2m1U43jxnt6z8wFK6jMohdSWFgC9KGp9ujY3Juy9h4=;
  b=PXMydw6paGC/i7AVfm1JFc+e6hguaBrFTEv3IAtr4f5B5egzSUfgDQ5Y
   +dZvS/+S6gVxGoTCntS3nT3zhIJwgvbWrM611KUe2tZrpQdym9x1jJQnp
   OUMvm7gOsjXRBtjczu0m832y5CF74pEjHgm1HEXHF2VMY5Z7mcx26tfJh
   3nRUVxOkILUT9nZD9quRpyXTEnRvYcLQ9vWXW+oxBrjAcuIO1aBYG8bxD
   CYwfjG1ZH+gWN/79ASRxBja4jBnTHHr0gzCJhurTuseUcxAcxXByPTPk/
   hg/iDkKq+mPHsaNkjQjkA4nklxQje/+9nctK6KL5vdTX+tRldjjMx96G1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="375504146"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="375504146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 10:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="842702456"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="842702456"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 10:23:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 10:23:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 10:23:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 10:23:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 10:23:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emIl5qa2fUh/EuQSIr4120vkM8TTuGrDmstSVK9wvuxKulD1TpUfFSkTL3x8DNpVDJBYV4durZXi0QDAsA/RcS7wFE6hC3HmifzBaWXHaVWepKfpsJwxL5FMVchi6gszuDlY8mHA+FthWUfkYGZEN4a+T9pg8jjplQumfY3jteIL7yT/Vbb4rw0SAJdL68JqjOYAE8jowhY9aBqXSonS7ee41IMGZRvyiHjLV8iR8+mgKX+cyCguXGm6xPWoyQOXmYbzJZtdd+kvd7YnSJvEWhUwDnJvNC2P+a7Akv9NIzNQ3qIZQtB2QrnFD5GUVSJZ/ZT2rdLDJ4Bd9bFD7HZEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZJG2mvaiOvJCgdBPCkZYE3D5gcVozGRcf1oLPWUdGs=;
 b=VwGUaQD04/qSKHSiDC2A3G4RmfmPgZi9o2PQxu2LLQTH4NbXTaZMFtF/wH0YrvUOAvPRA6KxGsRJe84x7IXdY2v+BfXLtii/4Dzo0uuUVrTnrFW5jTrNkVIvotCBoc3WgmUDQJEYeIJBgzmWfIDbMFmRdEio5r6H78tiNl0XfEMpsEnRJ9/mpe0QU/S4sGnU4hPJhwvq15N0nAYln94JsBd2yZFQF1shXpfJE97Pd0TuvZN0jxv8zU1lTkZ6DUkRUU8G6qLmplcSHvoZ9qD/wFuxEVxLCr7G+PDXYyHwENIbcTQ8/+NurQn8J5vZK/bfGTNw24VehlgJdyIaf0/xLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB5827.namprd11.prod.outlook.com (2603:10b6:806:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 18:23:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 18:23:26 +0000
Message-ID: <0b4847b6-2531-4bfb-9b7e-bc4f0b380342@intel.com>
Date: Thu, 21 Dec 2023 11:23:22 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
From: Dave Jiang <dave.jiang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Brice Goglin <brice.goglin@gmail.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
 <23a78aa8-e076-4b98-bd7c-4299aefd9895@gmail.com>
 <500b0900-f4bb-475d-817b-6a72f18e0134@intel.com>
 <20231219164408.0000790a@Huawei.com>
 <190b7c40-fa03-402d-b8e6-c2d581270bfb@intel.com>
Content-Language: en-US
In-Reply-To: <190b7c40-fa03-402d-b8e6-c2d581270bfb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 642bcf28-3e32-47f6-8f6e-08dc0251ec20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiX+GJB9d5JVe5Y2DZWuNn0kBFEsLZw+uD6nhtalNC/kkLkjJlacQP2d/KqdZ3jCIFMMgk0JUt2/wXCTbDuoFjwvHWkB4SMNS73XqS1FVRIRvYwwW79+NSiFyFpHMQZHvavHGR3MWlbGl1cz52DiAdbyDOlj/kdM2xN9Zond5cBt/WnCcM6acrHIY5hTv46mMJ1rw2/pNg2mX83RAKS30NNxtQtbHnCPH4EnjyTT4s8JJkTfyoGnRJgZvDDkyGBSEBloAnb+hMbpJDmD9ouTKNzeq4Skurr9BHdgeMyxUheGBHWoEPF0IjobnGAeSgAIVPwi0A5i84ypuC7kJsdQj2BlbhWhnG0BAOAi/7ujVKuzQdiR9Y5i8AoQBijRB1iuRxsaPtzeapnQv3WItsyO7pAsaib6M7BsV/teBEpFjgYML2mI3HOBhZ5wWoiHL06F9UtvmKOuQU9TixnAVRwT4QzTlaXxMFWp4H23yOtECU6qGCcKsiWw4NbiXi+f1qkkonP+HQ6Z9shSTXAsx6d0Zf/QuNJu+GDVbKsj3DqY0hbKxJvIJEerqAzPAzeyGhHbFkjblBTbdRMzmp3HEpwV87NGQn09unj7U7NwLPICmZQkeK+iyrfJFnlJZyfPv/1P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66946007)(6486002)(66556008)(66476007)(316002)(8936002)(6916009)(8676002)(31686004)(44832011)(4326008)(83380400001)(26005)(2616005)(38100700002)(5660300002)(41300700001)(66574015)(6506007)(86362001)(36756003)(31696002)(53546011)(6512007)(6666004)(2906002)(82960400001)(478600001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVVNU5sb0FiWkFpdFFab3k5d2RFWUlCZ3RaYndPQmJjK2xXNVFMenhtclIr?=
 =?utf-8?B?eWpWNGpOV3hiWVJobmhSVUxsbkhTMXhHa2IreXFUMjlpdmpyS3V3eXhPMG1E?=
 =?utf-8?B?WTI5T25HemN2bm9lQkNka0c0Unlwb3JKM2JnRmxrT3cyS0x1UTRkblAxR2Jq?=
 =?utf-8?B?UThmTFBEOVFFM2pBK0Jac2NGeFlJZ1dQbStJbFhUUW1EYXZrYWE1bFpPb0cy?=
 =?utf-8?B?NUJzMGo1dTZoNHJ1ZklxSlFxQzJWNlc2SWpKUGZiNVlIWGZhY2twV3RIcTJ4?=
 =?utf-8?B?Q3hkbCt0bFBBQXUyRG9kN2VDZ0FqeEZJdDBOb1BuVXdMT3puc3VMdjR5VHQw?=
 =?utf-8?B?VlU3MEFPZUVKU0g0dDBCWjNwVVBoVVJnaHRwc0k1Y2NId0xrb3VjY0hKSkZI?=
 =?utf-8?B?RGdDWjc0eWJVREc1R29GSXZDa2lVZmtrQXc1a29PUlcxT05rL2NtSWZSMjAw?=
 =?utf-8?B?cXJRTWdDRnByZE1tejJnRzFYRHFFa1pTcWZBd0p6d2pIVDVGelZVWGdmRTU0?=
 =?utf-8?B?YlFtMGpRdXN5NmlHNHRpd0xDdHQxbXdMUUtmVktsQWZ4SzRyZ0EyM0ZvTDFJ?=
 =?utf-8?B?Z3R5bmRrLzJVU0RZQ3BhOVF0eFJOd2tmODFxcWJwSkNNMHNKd3JCUGtGaW9t?=
 =?utf-8?B?c3BPc002VWw3VGJNQTk0ejlwWllWNHJOdHczbE05aTB1U1hxRkQ4aHJxVG14?=
 =?utf-8?B?V3FqRFJTSEtLU1ppV3BsTzlQbnN3YWNkMGhwZW1hcUJzaGhNTW9GTC94QWVp?=
 =?utf-8?B?WEJsNDRZRVdvUS9NYXZtZUVJMTdod2VHS3hiOWZQTkg4TDJWRUNwV0lzWlNw?=
 =?utf-8?B?WU5mYmx1RGJ2VUVSN2VVbXFTS3l4UUpKVm1ndW45ZUZJTzFtM0liZ2ZrQ3Jk?=
 =?utf-8?B?Y1JTUytucHJLVkNzUlE1Y3JUUHMvUE1SRzB5NW1rUmF6L0kvK2FycHg5bE4z?=
 =?utf-8?B?NHd6cEFHTGxEZ2pXR3IyT2haV2p5Y2xpdGVIVDVubDBNbTNpT1Q4bmpxdVFt?=
 =?utf-8?B?Tm5SSEFrUVNlT3p3QkVBMHFmaTNad0MwTHdPK2ZFMTE5S1ptOENUcmYwWlpy?=
 =?utf-8?B?ZVYvWE0yamsrb1FiOE9nakZQQVBWNkxIeUVjT1RjSTVaMDE2UkRhUlJoUmYr?=
 =?utf-8?B?WUJubHEzc3RHNkJqYk5ka0NkRWV2RDNlOVVWd3B1ZXFJWkVCSDdobWtJNjJC?=
 =?utf-8?B?S0ZNU0JuRDBDU3JnaENVNnV3K084TzNCaXpXYW50Ung4U3Blak5la2RaWWl5?=
 =?utf-8?B?c2FvQk82Q0NycnBJQ3FuelVSRkcwbGp4c2ZSMnBYQWNRVzNjQkhKZUkzQVZC?=
 =?utf-8?B?bXVIbTk1Y08zNGIyZk53clFRTTdSSkNBYUtrdjZESWlaSDg4L09oU3V3M2Nr?=
 =?utf-8?B?dGRFSlZSVWIvM2FFNlQ5ZGgxeFF1T21OWktyWkkrc1Y5Tkcrb2RNSVNZYjJW?=
 =?utf-8?B?YXo2QlhrMjRFaGI0cDBvK0tDRjZ4YXk0cGVwRnphSWVPRnpFNVRkdUdYekM1?=
 =?utf-8?B?KzFlRXlHWmhTWHhBeCtXbjYycC9rbzlXR2VyQ1NERFgvZEpXTUoya1lDZDFm?=
 =?utf-8?B?dnJqKzFPQXhKUFpEME1aYzUrT0JJQXIxL1JRdVBOaDZ2QklEQmZJYW9rRGRP?=
 =?utf-8?B?K1ExOTZVMk1jOW5VOTY1YmpmY0N0bGVoWDdPaE5oKzh1UTRQcTZLcnlSSGlG?=
 =?utf-8?B?L3R2YjBxOUdrTktlN3k4UVdaMDMzWWpZa3VlL2dFRG13OUhyd2JFM21PMmgw?=
 =?utf-8?B?VHlabEY0RllKSVYveUVZZmlZVlVESzRXSXdqdVFzcEk2MTRXN2ppM1pIeXZE?=
 =?utf-8?B?a29pZWh5VVg1aDI3bVg2TitENFpBSlZCQ2JZTVhSbnAvRmJjOHhnUlpLSU1z?=
 =?utf-8?B?OVpKd1ZLR1oyQkZJc2laY1FMYURwaUk0WmlWR3VsVzV6c05DTHZlaEJ4cTkz?=
 =?utf-8?B?NFV5S1hiY3FBWFFRcHRHWGJUQjI2aXJFTWE2OFlJUVpnN1JOSXd5WWtVMjJY?=
 =?utf-8?B?VG9vOXhTa0dmTWJ2ZzErMDNaMWdyUG01K2ZTandlWnQ5ZWtMeHZmWERoNk9k?=
 =?utf-8?B?ZlkvcjlDS3JCYkRtWStVbWswUDJjcEJWakF2UXAxUXExUzl1OWF5NWtac2Z1?=
 =?utf-8?Q?86SNld8KGbT4/gEByUcdfDZuC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 642bcf28-3e32-47f6-8f6e-08dc0251ec20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 18:23:25.9790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRml49L+HN2JPLya4lmzkrJ4SGtCDyZ1h/6w7aTC/q7jUfTH/D8FVNWVhk5c08/MRgZZJeMlDIACD7SFVFQSEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5827
X-OriginatorOrg: intel.com



On 12/20/23 13:26, Dave Jiang wrote:
> 
> 
> On 12/19/23 09:44, Jonathan Cameron wrote:
>> On Tue, 12 Dec 2023 12:30:47 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> On 12/11/23 02:06, Brice Goglin wrote:
>>>> Le 08/12/2023 à 00:31, Dave Jiang a écrit :  
>>>>> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
>>>>> region. The bandwidth is the aggregated bandwidth of all devices that
>>>>> contributes to the CXL region. The latency is the worst latency of the
>>>>> device amongst all the devices that contributes to the CXL region.  
>>>>
>>>>
>>>> Hello
>>>>
>>>> Which initiator do these bandwidths/latencies refer to? Local CPUs near the root port? This should be specified in the doc.  
>>>
>>> Currently I'm only storing the numbers from initiator pxm 0 to these targets in the hmat target list. I'm open to suggestions as to if a different way would be better.
>> Nearest node with CPUs would be better I think.
> 
> Is it possible to discover that? The SRAT MPDAS structure indicates the association of initiator and memory target domains. But it does not seem to make such associations for generic targets.

Answering my own question, looks like we need to go through hmat_update_target_attrs() and retrieve the best perf numbers via that function. Will make some mods to do that and post v15. This seems to be the way linux HMAT handling code is doing for normal initiator/target setup. 
> 
>>
>> Jonathan
>>
> 
