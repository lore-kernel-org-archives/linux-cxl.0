Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kO9Vr5rg"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386A1FF6
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701105001; x=1732641001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KTI/q441SQoP6sELt77e+IOpOnaAsjqO0NxUnqt+9So=;
  b=kO9Vr5rggaOXiimSCp+yT2eakq4TbGeElGgjH5/Ho8Bz6hiZ7PXp5f64
   NHkl3S0Z/aZ2kQphdxjkQdy5sfxOZBKxJI9vbX3/QCBLJ2ka3TSwTYI0h
   Pt0moCrm2U95GV8UVl3hf49sp8q3P/beC0BdOVaRBHidAJb2yQMhktIlW
   7V7o+m9xkk4evEHh/kd/su++kN43YZT5of5lhykqWVgxUsot4cFU9CesW
   ZVQRdfKw6g5un/y4TRIypYGAxrqt5J76nLSx7sU/MAeoeCcHAsHQwev+V
   GzZe06PQSzAGxB7kluNZMacYw8mq5dRjuZFGcJteMGaUOc+XlIJnRpayy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396652488"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="396652488"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="9674747"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 09:09:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:09:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:09:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 09:09:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 09:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwkJLSGWZ94JvBFEKA40iVp6gqnhAX7jtar7xXizpI5Tuoyc7uUBXI50y7jz3MKEstXoyziPj4m1loIBlBt5eU6nDr5b4LwKOqqQh08BxjAobefcC9lIN3CXvaSXRKK5ljbea/larP2ioVQIDZEpBh+0Zax9eBDg57RKCzljK0UVIbpqINWKbWeViiVTV2p8tD8aMFiLx6vVr9gipDgj16Ufx356jVdW9X+0PVnkyE5fJEnbJSOEIl1ldS2wecImiEwhB9GV+2uH5l0NfJVdLeceZ+ddTNIvRj+4q7J87gWBNYZa4DxisgA1E/s/T1Ga9ZXdsquULLbfCgdV8+FUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANxPj4j0zDE1fVX59MrG+8jl35CDI2fzqUtxuyw9f+0=;
 b=bRFYMTIPtvKzAi7EymqO8OoBYkpzV4IrEgQ4NGtsDgHGKNiZu+Ql14bBpcDkCI/XatDMcESVBrEVlAEfyu3WZQ+ATKJgahvTx3z/MLrnywW9dCeXSk0IG9NjKbdHPYjhoIej1AFOQQ1ouoo4iXeTJ6loQKCKeYvAGk04FDoQt9yETjEcm0WUzbySkS3BegUrJvafNDGEW0Yv76buTMw/PGJAIUsqwlNnalDRUzw+S8kHbkcHoiXDEDNHJEBnBzWC9BuxBjUypvGrAQb07ZwaRPckz/BfrzjovXDtG7HyJkPFfZ+oNh+ZWaDHAQLuUKFugIN2N3MJjSZr+/J/n/l2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:09:15 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:09:14 +0000
Message-ID: <48bc543b-0003-4dbd-9844-1f8cfa83c219@intel.com>
Date: Mon, 27 Nov 2023 10:09:11 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <peterz@infradead.org>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
 <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
 <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4242a4fd-ff45-400d-3e3a-08dbef6b94f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+WhWWdvBtdILU75latzQAVl+WLupGEyyhdLXKNtwWB9Z12jm0y0w86fIxkk91y6yJDn1kvIA0NJwd2q2I4054HT/dJ6iSrzQR6kPlKVbg2AftKQ7fy27Fe79jPeYqhOYRoGAoYXQqeHLNmc3G/cG7CmvbsXUDkGd6He9i66bLX/Mkx1/RCB7EGidK66Sz7KtAEN4UfgOZYv1D424T9f2wG9BPmGLSjDNbcHScfR03drhu7zhArkscUZ1vaAy9umGLVIaxAHa8d/tywGXMVnEwDyWHsvPwJrpEQNlGwF3QhCVg4F0riVwfecK+whW0EBS87yMaXSiRUIXrbRuiPta+G8f7t8VoUWQ9Lbo01H8ECoMIyZW8sl0cAGBmoPuS4uG32C4AALNEq608cNedc5VpuCzkLfgovZLYKV19rYR9o6KwGp0oMTMu3JB+gWjlqGGmQVhgQKR+vgKhrdQX0M9sYme4aBCRCU40MKlnxpzS8lpmGOPEFoSN5f9YdweG6jka0v0tC9tcbquadXz0JENE+mIp/AZGqneXtzvXMIyilU880EqBdqSxlTv3yRL8lTFizVJYkPsl0HZlfwT/B3weaL2aFwJXXbWQB4ro0TVPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(83380400001)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(44832011)(66476007)(6512007)(53546011)(6506007)(8936002)(31696002)(8676002)(6666004)(4326008)(478600001)(6486002)(966005)(316002)(66946007)(66556008)(110136005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFV4bXlxUEpKL3JaakNzVlhKNUNabExiVDVUbklVWk5QVm5CS1crK1VJZUJB?=
 =?utf-8?B?MkJXN3hEaUgxNUg2VnZYYWlGZTg1bWlKcFNPSDV6RGhnOTFYRTNmZy9keE1Z?=
 =?utf-8?B?TGxScjhPdGlTaXhWcTduV1hUYWRIOWI3YldZOVIzRWhFajZ2bVhMa1E2MSt1?=
 =?utf-8?B?b0lxU0lZWXhjVWxLUXZUZmNqWWNiSzZhVWJyZXJRanNOVjl0MVB4VXFtZk4r?=
 =?utf-8?B?VTQzWXQxNmxiKzQwL0pVK1FOWGlDaC9XZ3FPR0dZU2JLdmZYa3FOQVJkK2Rv?=
 =?utf-8?B?V2xxV2RtbkwzcXU3Zm9sZHlJY281WUQ2OS9kK1hOVmxxcitMaTBiTGhIUEZI?=
 =?utf-8?B?N3pybis3TW0zcU5QQ1k1b080OS9MMi81S0pqOUZPdSszbXl5STRYSnVlL2Zs?=
 =?utf-8?B?d1RMcU13cmJNZk9NYlBEb3c0b0MzK0dqYnFpWWdHMHpRZkI4MmI1OUFlY1ll?=
 =?utf-8?B?TXpzbWxBNTk2eTJJQk5BQTYvYzV6aXkxMDJPZ1NMSVFmMlFLR2d4Smo3UmEr?=
 =?utf-8?B?NzhXcFB5RnlCcDY0cnJkZnFaRWlXdVdRQTVNZGE3UDFwSnNoRC93U0pvdyty?=
 =?utf-8?B?YUF1VlVGWDFGSlQ2ZnRyQlZneHFtc3JvY3o0Yyt1N3VmaTg5SktoWU5mV3dX?=
 =?utf-8?B?OHhWZEFYWEZBMlNqTzlTeWhMb1d6L3A1bm4rcGJOMGN6Yy9pNFJtRkxUZjRM?=
 =?utf-8?B?WTEwMmJOR0tGdE94MDBHNStqQ0RPTm5KRVBxcnlNN0pJa3dxa1pvMHd5RnAz?=
 =?utf-8?B?Tk5ycEV4RWxrK3VQUzMxbWdVZmN1M3kyaWlWWkRObWRJQlR6VnRHRnY4eldn?=
 =?utf-8?B?cjN5MzdZL2IrcXlkY3BYVHN4UHIvMktBSkdORXEvd2E4VXA1LzBHLzB1dFM1?=
 =?utf-8?B?TW5LS1k5eUxLM0tId1NLYzJRUmtsRHhyNGJMZTliTTVCQUptdjZ3Tjlod2JS?=
 =?utf-8?B?elJ3UlhJYldOV3lLNjl4VGZ4QlNUQVNWWGdnOWdYWEF2UjJXTUNFMUZnWnFG?=
 =?utf-8?B?czBPcW1pTnJiNHJqeFI0ZTNVY3pvWTArQUxDTGdrcW5XL2NubXJWSFJWd0la?=
 =?utf-8?B?N2RZNFo5cDE5YnBSMmRmUnVEcTF1N3FJaTR2UHcwV3N6dnExQjNFc0ovVm9u?=
 =?utf-8?B?aENDM2ZuRHdFcG1uUGRrU1U5SitlWGRtc0pkSWJEYkxmb0p2M050SWloaG1Q?=
 =?utf-8?B?K3RGbElJc0FUR3RiWDcvM3M4M2VQLzhYcGdpeCs1eFFvQzUySFNBYUF5djA0?=
 =?utf-8?B?VTVsRjVoVU5wNEhkSUlyVEhoRGhxeG5nUEZEUCtYT3ZEeWtzdGVUeXY4QjFr?=
 =?utf-8?B?VmRBU1JNT2Q0NUlQU1J1MlhGNlBoZG9ZNDNGa1dtK1FsRDNKSElUN0NKd0dP?=
 =?utf-8?B?aVlnZUh4dHVURGlTbitlcmpHUi9DZkJlRUtjTEV0NFJCbEh2d1FRTFlvRkNQ?=
 =?utf-8?B?M29zaHp1WFZaSzNid3R3TDF3MGJhdThXMXlHUFY3QWRGQW5uajkvRDE2ODRE?=
 =?utf-8?B?YkpjZVdXY1V4eUxPSTNuNm1VNXU5aFN2ajBRNXZEQmc2U3hnbndzb1NoVzZ3?=
 =?utf-8?B?d2hINFh2cHBhVVNNN2p0c3J5QWFmMjlBS1k0cVI4UHJ2cHJ5aFVaam1GZ2o4?=
 =?utf-8?B?K2hzYktFbGtRcGdVaUdvenlVbFRmUWtTeUtPdWgzeTVHSjF2c0V6WUxacWtB?=
 =?utf-8?B?QWFhY2hpbmpNd2xCNWtkNHVzQjduYXVQTWFaVmorTVd6NjZBQytKVVVnNVJi?=
 =?utf-8?B?cGJLQTFtOTVuUTB1TUFaWkFOQXk0eEl2N25iQzRGOHBtQ0JEWDJIVWhpbkdm?=
 =?utf-8?B?REpOWUJlT0VKQktkQS8rK3VWV1daNGYxY1Q2QTRJTnUybnBsVjU0OXJ6YThp?=
 =?utf-8?B?bDlvS3lMUUhtNVhZWnRPV1pGQUpFck9sVHBZanY1R1VGQUo0VmJLYWVoaHZW?=
 =?utf-8?B?UmN6TjdzQ0Q2R2lLcDJhdGdVaENRZFMxN24xWWpTNW5HNkRRc3NaaWYxdnlD?=
 =?utf-8?B?S1Nwcm5MY2pDUUYrWWpFSkE0bGRaUjJPY3g2S2JNZTJQaUQ2YzQzdGx0cjR3?=
 =?utf-8?B?WmUzTUtqNnU4bWFJYU1xaDk2ZGU5UGwyUUQ4U2pGTVpBaHozVkxuZnZ0TFFZ?=
 =?utf-8?Q?G6odwa4lkD7rqL5WN0YGQMDck?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4242a4fd-ff45-400d-3e3a-08dbef6b94f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:09:14.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpHjFe9yUxzAFaPJ4TCPKGUs31qnrQTiSclVx2VglAZTU5QKOm9gt+Yp7Xf+ILe8cBlRH0nlr+LDh34Z0OLjUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com



On 11/22/23 18:02, Dan Williams wrote:
> Dan Williams wrote:
>> Davidlohr Bueso wrote:
>>> On Fri, 17 Nov 2023, Dave Jiang wrote:
>>>
>>>> init_hdm_decoder() modifies port->commit_end without taking the
>>>> cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
>>>> However looking at the code, it looks like the write version of the rwsem
>>>> needs to be taken due to the modification of commit_end. Wrap the write
>>>> version of the rwsem around reading and writing of commit_end.
>>>>
>>>> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> Uhmm but do we expect concurrency during the switch/port probing phase?
>>
>> I answered that that detail here in response to Fan:
>>
>> http://lore.kernel.org/r/654eb8ed72ced_46f0294c@dwillia2-mobl3.amr.corp.intel.com.notmuch
>>
>> The takeaway is:
>>
>> "I am in favor of adding the locking rather than depend on a subtle
>> side-effect of how CXL operates, and to avoid adding an unlocked version
>> of cxl_num_decoders_committed()"
>>
>> I will add a note to the changelog to that effect, and drop Fixes: since
>> the lock is not strictly required for correctness in this path.
> 
> I rewrote the changelog to this:
> 
> Author: Dave Jiang <dave.jiang@intel.com>
> Date:   Fri Nov 17 13:18:48 2023 -0700
> 
>     cxl/hdm: Fix a benign lockdep splat
>     
>     The new helper "cxl_num_decoders_committed()" added a lockdep assertion
>     to validate that port->commit_end is protected against modification.
>     That assertion fires in init_hdm_decoder() where it is initializing
>     port->commit_end. Given that it is both accessing and writing that
>     property it obstensibly needs the lock.
>     
>     In practice, CXL decoder commit rules (must commit in order) and the
>     in-order discovery of device decoders makes the manipulation of
>     ->commit_end in init_hdm_decoder() safe. However, rather than rely on
>     the subtle rules of CXL hardware, just make the implementation obviously
>     correct from a software perspective.
>     
>     The Fixes: tag is only for cleaning up a lockdep splat, there is no
>     functional issue addressed by this fix.
>     
>     Fixes: 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")

Thanks. LGTM
