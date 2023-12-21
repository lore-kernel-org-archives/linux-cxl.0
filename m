Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32F78E72
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQr4htNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703199073; x=1734735073;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUmL9hKUYvVq3D/QnaTNMlYKYYP3szrs8EaD7E/r+U0=;
  b=cQr4htNf52gNjZJWpwnV8saSUhFh1vaP3I0urMKItCi49b93Nl0zmkj3
   IQH6BT/BxZ8ERRJH/4KeU30/eHrDMDroM8URIrnc3euozpGf/8hTUvHHi
   /OfbWOico9Dehg/oNzf0MoQbY8MNWVcSNQINRRGZRH3f3U2hKrO7ZZD/x
   bOU+4Kr0kDIlU70yUrsSIdHmCy9+I1G8yZSknLaDCXYSA5EvUJrLZYTrr
   MtmyO2mYm0RcNp924IrWuxXTOAxaWVRIB6jb2JtjSIY/x7JXVvkphkWr6
   qARMk1pbJewCL3rqGq54O0uYTXdIOtA6PL8EktrWPRUYxdY8DXXkg+xMA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393212521"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="393212521"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:51:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="18497971"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 14:51:12 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:51:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:51:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 14:51:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 14:51:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I91QBA3aQuFGjS99BOv1dIxLG6uFziuD/ASM0wlNlFinklbUqUCD5qbvgYHk0jnM4Ja+2knEQfR1FXbi40SLeLr4Vq2hreTq7I/3unNj43uAKpCiOCsRCiBgYlW4UViugZ1Fss/XZDsdIYnnhfq89/H/xXDPnpS8Qs00oopE2WpenHCX9cWApGqTWjvDSh6tJgdTL0hx+hn2G4xC9w5YoTtNM6yDC/iLgqmfFVl7lpFONdVlO1/XAXWAkGeSUpvKZkeUKVD85lfXeb9B5ZmTxWyHbzNnlj5y5n7AwMb1Dip4dxXpOTDxEaMPopGEgFyq+Ymb186VTYi9zCvE58m5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYf72IBk304gG56ZJdkb+dUwp3teN6z4hm5Jl0lakcE=;
 b=jXxzraF8kqTMxU1Q9QPc29KVEG5fS7jdZP4h8P4OIVEh95LkYHC8aY7xRdTUVbgF9mmLTrtkpIP0i/1dxSH12JynZc7zZdWL2Hs9VLF9pHhbY93zBBkgLe+YsQZgr8NljWmxjtVuFJl1sttzlPxY7PAnnQItm5amazuyWPfQvsft2uAuiBP4sGYEnO3Mad7hGXQXUOyzHrytJChkxEqb4IvVWMPWCs0Uwj5vbiOvl5I9d64PPItVHDB4bIXrWGQAbXjHePjINgQOEHOt9cGpIQhKDC5yi0taJoo/i1Vl+AWmFOzchIYNc20Qrf35XeRvuw1s2WSllDAYvygiUVfqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CYXPR11MB8730.namprd11.prod.outlook.com (2603:10b6:930:e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 22:51:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 22:51:09 +0000
Message-ID: <477b582e-8237-49f7-8817-e259c144c152@intel.com>
Date: Thu, 21 Dec 2023 15:51:06 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/3] cxl/region: Calculate performance data for a
 region
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
 <170268215975.1381493.16321994239389305102.stgit@djiang5-mobl3>
 <20231219145135.000021f6@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231219145135.000021f6@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CYXPR11MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: b43afa7f-3f54-4954-22e9-08dc027752e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +W4nQ2W+tOYdm7DSgOSeERZhIHmJMGItGuyA9IKRMh1nL/raa5b8GUJF4AdzBLtfVur7ERhS6LFWx1Y7EUbORq7SneZM+eOivj2fH/08dgKD2hSet2w5nDW+Sg3WpLRcR3ju0ISKOPThYo59uwj0d14FapIwHMHdNzf73Vx9/vBBYdqfveIkZs33s6kFflTTcXWdJi7AvE6w+iDksJ6kWJ2fNxfkqQ8jZCF6pnYrsCWwphauCv4foTLcLCaaGnIQsz5gxp7n8Rwa0Rw9+hocknQiieXfjt8jpnN2vDl8rVTpU3e7XE8K/PH4euJDyXXYY3HhQdXqgOi1binMN1AuHbn/Pf4x60WhPbX+O3MknGX2+0EdxhBGsLoMNLKrpWDjGyLQHVJQitXUF8JsMjqsTvAEa9CDFBTkeNJQZHS9nij90145inhdpX1e7mO9IjJ9jkqO7N34WfZGYiCwd/3PZH1JfsBLqSzEjVha/+XeTaJMPsczfUjX1wI+HUK6Uh+39JvM2ehmFoMZs0oqUtHXV0uWAeFUOGcAdb4z+gkAy8sHgsEmHuTKT8af4iAu9m0FYgP54RuFf6ynUMZ1q0lZWHFoW+RjAWijEUnhdWNBY6u5OkcxA+/5S2gH2vRK8AgH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8676002)(8936002)(4326008)(6666004)(66556008)(66476007)(6916009)(66946007)(6512007)(316002)(5660300002)(2906002)(44832011)(2616005)(6486002)(478600001)(31686004)(26005)(86362001)(31696002)(41300700001)(6506007)(36756003)(53546011)(38100700002)(82960400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3k4S3AvNnZuTFNmOXkxdGwxUWdTaVk3R3FtcTQzNVdMdmF3NlRTVi9MQ014?=
 =?utf-8?B?VTh0SnRqZ2lremRGL2NPZHhjbTdEMTJSaW44d29SVDZoMkpzWERGOVBOaFlk?=
 =?utf-8?B?VmsvRUZPNlphUXRQK3E1NmtDNzRNdlVkZUVqNDlVWmVRbnRRdmpJTi9tc0tG?=
 =?utf-8?B?TmNpY1hIZXpqVjhuVUxGa0hFMHFJS2RORE1vRnlrZnRRYS9Kdjg4aVR2ZE5U?=
 =?utf-8?B?MnBJY1RCZkFFcm8vYnh4UVFhTVU2a0hqbkVYZ21Ec3JtSmdxVkhhSXFZaFRW?=
 =?utf-8?B?dzhtWndUY0s1VzNuNjVWdFFNd2NDeFVxSmh0b00rUmNvdjJocHM5ZzJPMi9S?=
 =?utf-8?B?T0VJYlVnd2FZV25ZN0VwTmxZclpDWXZEMkRqUElMdjNDWTJrUDZSU3FBb1M5?=
 =?utf-8?B?TkhnMFlxM0g3d3BQbUg0N0R6bVd2YmxmOElML000L2oyWDdUa3JhaU5FeHcv?=
 =?utf-8?B?ZWxCalpZMnVBS2VaWGNuVVFObk5ZaFdRQjlEMWRwQ2pKZE9KQUlKK0llcnZ2?=
 =?utf-8?B?ZVVTSXpIdUMvL1JFYXRTZjFJQzJJeFZnUTZ5c0RZM2FxRE5IQVNrSVBNZHo5?=
 =?utf-8?B?b3NYdWFWRDg1MzZudFN1VGduMXRkQmpKSzMzTEpqVGhOQ3p2UHlGT3dkU2ts?=
 =?utf-8?B?ZE9hUnBpRStiVWExSGdFaUVUNVRqS2MwT3J4dlE4d2ppQjQwaCtHV1lYMG42?=
 =?utf-8?B?VWlXbTBNaHlzK0pralRhS1prZjBFbTFuWmZUKzEvczlJS0NtUmJJTmVPcERB?=
 =?utf-8?B?a3VyQlhyNHVhTVArYWVTNHd5blBIV0pIRWRKUloxRXBIN1lXRmsxcHVXTmk0?=
 =?utf-8?B?TjJZYnFPKzZ5RTczS3pLRUFKdVE1R2kxQldVU2lzeVVuNTRzcjF4Q3FRTkJq?=
 =?utf-8?B?TkNZVnBpM0wyOWE4dTN0aDlyNzJrSjZlTXJGN1d4WnBlcDRvUFFTVEZVdVcw?=
 =?utf-8?B?MlNaMW5rby83WHF5NVJkTUI1YWptMVg4d1JDOWFta05CTU9najBUbVdZK0xS?=
 =?utf-8?B?bzM1LzRIMWE0Nk9FSGE0OXFTSUVvNGxGQnozWGUxeEJ1S05CYXNqSHZxTjgx?=
 =?utf-8?B?OUIycWJxZlN6dzl1UStmamg0cVAyeDFYVUR4Q0JDdzU5R3IvNUxuSll1eTR4?=
 =?utf-8?B?V2J1d1FsUElmV0Zyc3RXdERBSnk2MVRCaE50dkw5c1ozdHhrRUtYaTk0NDJG?=
 =?utf-8?B?NkNpTklObUhrT1R1b1RIVUlWVGJFTWFkdy80b2JjNUQrckZDK1NRaDVwOUdS?=
 =?utf-8?B?Q1ltQm9QUGpPa0hwNStlejhWRWxuVTV5UVN3OUhqbmlJdzBvOEh4dnJBRmVN?=
 =?utf-8?B?SHY4Q2I1VW5STGNhTGM2dkQrT1pFczRuYjBIUGtIVmV6Ukp4M1AvdnB5M1lC?=
 =?utf-8?B?TFhhaHpHWnBscXM3ZmRnMDlXazRGRW0xeTNNNGJIdFVOUUVFQW5tdE9xM25N?=
 =?utf-8?B?NGNTeDhWL1IzcDRHY2kxd1BaWlhxNGtxQlVRYVVoVkFhT0tHaVYvckkzT2Yv?=
 =?utf-8?B?MGwrR25mNjNiNjhGTElaRmlKNzAwSUhJWmV1dUMwMFNLQWhHSFB3bHdFajZK?=
 =?utf-8?B?ZDVUZmxFUklBUEQ2WDY4ZVhnZnVkUTVPTzRFSWZMTXkyQmYyTFVuSStDcm0v?=
 =?utf-8?B?NlNQSWU1MzQ0OEF1cmlrWWkxQXpVam0yTmlteVlFSjZwWW1VVTZ0MThHUTBR?=
 =?utf-8?B?aVFxeHJkOWxDbTROZmsySjRXalFRVllHejRRVUM1ME5aUjdVTTdEejdQQzR2?=
 =?utf-8?B?bjRlY0k5Sms1QU1JNmpFNmNZSXR5ZDkrSTJXMy9SdFpROHFtOE5IeFB2QlFE?=
 =?utf-8?B?eTZXOXhwbCtIekhZbUlpMG9OUS9NUFk3azR6UHRYZ1Z3ZkhYK1VFU3B5N1RY?=
 =?utf-8?B?QkVLTW9CM1RKMTVNMmlxdXV6K2doa0NhODkxSStBUXEzZUx1bFVsZ0xMVWg5?=
 =?utf-8?B?bk5NYXVEdE5oZFJKVnQydVFhYUpRVTVyRWlnSThxbCtTWVI4K3FEaXdhMThK?=
 =?utf-8?B?WVBvdlY4MDBucXdIemxVSzVCa0g1Yk0yMTJnMWhZRFdKUWIwR3pRZWJaclI5?=
 =?utf-8?B?QWxrN3VTd05pRTc0TVpGVDZXY08vMXZrNTNpMmZwakRmZFZSWFUxVFhWczVk?=
 =?utf-8?Q?UWnpdbt1n3grQLPrwzgivY2qH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b43afa7f-3f54-4954-22e9-08dc027752e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 22:51:09.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr8wq8BO8pFxSoyL2U0CUKG90cw7ovVUKuV/asPBAfyJ09ZgVyGnWE8QciUUGDeo5gPCx98FB2TqCNhM32ukDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8730
X-OriginatorOrg: intel.com



On 12/19/23 07:51, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 16:15:59 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Calculate and store the performance data for a CXL region. Find the worst
>> read and write latency for all the included ranges from each of the devices
>> that attributes to the region and designate that as the latency data. Sum
>> all the read and write bandwidth data for each of the device region and
>> that is the total bandwidth for the region.
>>
>> The perf list is expected to be constructed before the endpoint decoders
>> are registered and thus there should be no early reading of the entries
>> from the region assemble action. The calling of the region qos calculate
>> function is under the protection of cxl_dpa_rwsem and will ensure that
>> all DPA associated work has completed.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Trivial comments inline.  With the HMAT reference tweaked,
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>> v2:
>> - Move cxled declaration (Fan)
>> - Move calculate function to core/cdat.c
>> - Make cxlr->coord a struct instead of allocated (Dan)
>> - Remove list_empty() check (Dan)
>> - Move calculation to cxl_region_attach() under cxl_dpa_rwsem (Dan)
>> - Normalize perf numbers to HMAT coords (Brice, Dan)
>> ---
>>  drivers/cxl/core/cdat.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/region.c |    2 ++
>>  drivers/cxl/cxl.h         |    5 ++++
>>  3 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 5fe57fe5e2ee..29bba04306e9 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -547,3 +547,56 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>>  
>>  MODULE_IMPORT_NS(CXL);
>> +
>> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>> +				    struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct list_head *perf_list;
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct range dpa = {
>> +			.start = cxled->dpa_res->start,
>> +			.end = cxled->dpa_res->end,
>> +	};
>> +	struct cxl_dpa_perf *perf;
>> +	bool found = false;
>> +
>> +	switch (cxlr->mode) {
>> +	case CXL_DECODER_RAM:
>> +		perf_list = &mds->ram_perf_list;
>> +		break;
>> +	case CXL_DECODER_PMEM:
>> +		perf_list = &mds->pmem_perf_list;
>> +		break;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry(perf, perf_list, list) {
>> +		if (range_contains(&perf->dpa_range, &dpa)) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found)
>> +		return;
> 
> Could use
> 	if (list_entry_is_head())
> 		return;
> and drop the found variable. Though that is a little bit specific to the
> internals of the list infrastructure so maybe adding a variable is better..
> There is precedence for both approaches in tree.
> 

Hmm....maybe not having to rely on list internals makes it a little easier to read?

>> +
>> +	/* Get total bandwidth and the worst latency for the cxl region */
>> +	cxlr->coord.read_latency = max_t(unsigned int,
>> +					 cxlr->coord.read_latency,
>> +					 perf->coord.read_latency);
>> +	cxlr->coord.write_latency = max_t(unsigned int,
>> +					  cxlr->coord.write_latency,
>> +					  perf->coord.write_latency);
>> +	cxlr->coord.read_bandwidth += perf->coord.read_bandwidth;
>> +	cxlr->coord.write_bandwidth += perf->coord.write_bandwidth;
>> +
>> +	/*
>> +	 * Convert latency to nanosec from picosec to be consistent with HMAT
> 
> HMAT version what?  You may ask why is there a breaking change in the HMAT definition
> between 6.2 and 6.3 but I'd rather you didn't :(

Do you mean between revision 1 vs 2? I see different code for parsing it in hmat_normalize() call depending on 1 vs 2. My ACPI r6.5 doc says the HMAT revision included is 2. Assuming the final HMAT latency coordinates are always in nanoseconds and our raw data calculation is always in picoseconds, the HMAT version doesn't really impact at this location right? I think the hmat_normalize() call in HMAT will ensure that all latency data are nanoseconds base. Should I just say "calculated data resulted from HMAT" to make it clear it's not data straight from the tables?   

> 
> 
>> +	 * attributes.
>> +	 */
>> +	cxlr->coord.read_latency = DIV_ROUND_UP(cxlr->coord.read_latency, 1000);
>> +	cxlr->coord.write_latency = DIV_ROUND_UP(cxlr->coord.write_latency, 1000);
>> +}
> 
