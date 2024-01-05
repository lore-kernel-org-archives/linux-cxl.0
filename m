Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599735F0F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfOuXNS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704495023; x=1736031023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKg0GUbNkVDFHNUETs0NsCjHYR4NgSKWNQpdTGEDnh8=;
  b=kfOuXNS5kiPDvPcjUekeQepi/TMjbebElitXhi85ZPqJ0xpubc8fsHFL
   NK16g9mOxlxdi4feX2viVa05wMXwu7vHYjcJEldEY+PSRwwmOvRWAQKqt
   0Cf/cxw/3mPgdkwgK01zHxRMX37rWG5LgpsCo0XgINzbNNwMxwu2FjQ/C
   Rk0pDJHEvutHUwyllmrLhjaGN0dg5p7tWbrxKbG7Yhtip/wwGQBsxrWyR
   6Jij+0Nto5tVGTtU91nf9pfFEe3Jq0UEjwhtZC5wPaGxGY/P/mIJ1WSXA
   7aaMETA8e2EpicfIO2WVpBp9QiIEPtk8+14VznLKRsuG/6djoeNNGPZmb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="428787656"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="428787656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899774909"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="899774909"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 14:50:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 14:50:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 14:50:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 14:50:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJJq7iYq6t+iPJPKr8U+igpfKdTDIuPPSZEYZBn2KyOjFHUxKllFOLwmiUvudt67jXHXvLl09wbOmIyM701oiBBsYtV7nF5hPDVDM48Y4OH4bDh5ZTtee0s8pnZi9mjMQgH6LbxzQaeoQ0ycB6BCY3KfPzic8rhkioeO8qGHZtaspYxOZt4QrMqxh1/0/mYHjO+9xc3EMhL9nuOquaIGm0v6shBN4EPihbK3WucigW0rHOMqyQMwjZsTdqRZHYqzwLXx8v0e053yiVBgMyveOTn4lTD2RkCTCAMjM9+xLmO9unxNrfdDhhSlocW5H045rum40AF5wr5uGc2mqnrv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7XfXssGzh4VKfDgFg6r/K7cNYc+VMuUR+APH9aOn/0=;
 b=My6G+4trfUDi7V7ykxGFqLexwIeV+kO/PHd1nORdeW11L9DYwF7KZI632f0mIE6G2tUs39Tk1k9XBJ7HK0cyp++w/vdzpCwTTMHL04KuZglUY6/8jogwZ0QDR5Uvf/HBB3SXfllI0MfWtRB8wbe7cgqzPVTBzaIo+F189huBxs4eJ8hnWKd9w29nBFWGoJ/6Gm6fyR8z2EnlVoOgV9OBOqbKpDODStwvF9GW7GxLPrM6GVnH8vnmZuGzvtLdVKXXGmk82PR9f36uX83Oi+av1ZBzNkFPGszZ0bx3IVQXobm9HS156UYsA07ZgX5hbkq+TSGveKyZ7DPGazI7+ihhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 22:50:15 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 22:50:15 +0000
Message-ID: <e230cbe6-836e-4a90-b046-13ab155d2ca4@intel.com>
Date: Fri, 5 Jan 2024 15:50:12 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 1/3] cxl/region: Calculate performance data for a
 region
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441210328.3574076.8557138214621981436.stgit@djiang5-mobl3>
 <659748504009c_8dc6829435@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <659748504009c_8dc6829435@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::44) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 73839545-5f6b-4fc2-ec21-08dc0e40aec1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Esq218aY7kRgfA3D5yuJepzpB6y2jUUNYMRNVzkIlSqAyx+H11B+NE4A+v6K3w+mNT2rZNROrlkYhx2yWzRL+y+DVB4ecd5rLxneMC1OgJ04hOCJFn924/1KCwfG1SuMM0NMPDXmaiWhqLjDFAfZRbLwDde0skN+jqtsL9NTNjn/X2dLyPb7eRWRtHEk6d3YwhkLWSP/htls08XMw98ll0FaCiKfqAZCPfmT/T6ZmqThQ6eW/828WdzHR9JK/O7sJpnhoMLACgl1uvAJxWFNCLpNn9YZsAvFRJcU+H2U+Coqn7/t8VLXLzI+NDpQdu8td0fSrM9zxma5hiB93NHsogIx+GAqqI4j7LoiQVvArXczUTPVzqzfYiL0z1yMXxG7FW47uMBvq+htCBHNj2qsTmEXT/L9h41mM4UK9X8rF8z8HY5+a/XJzkTYG/1r6/Mxosmn6fsbdCQUoEpOYV4OLyVN1xSvvbdcGjTnpOJJdW7532B92SwYH3h1Rjk+5o+s+ib0nfGxijcPeLpl9RJEm/pXG/UI/ZGvMDWat2FZ6j9cSiZw5GJHEIuhU7MqKHM5MBSg3srtrdOEVYCd0tK+UlNX/W+RrGyJoiikdqqXqIrLAt5Ww0o/hI+/dW3KgrW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(26005)(53546011)(6506007)(6512007)(6666004)(86362001)(83380400001)(4326008)(316002)(8936002)(8676002)(36756003)(44832011)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(38100700002)(82960400001)(31686004)(31696002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGJsQjhWdmJiQXV4dnkzNGlabjRVSzk5TzVTZXBzUE02OHZRZFlqSm01MGpq?=
 =?utf-8?B?QzJiejZLdUxDR3Z5MEljRWZaek1GeGVWcHRBdzNyN0JFQTBwWDR5SlFHT3Zw?=
 =?utf-8?B?cHFzQnJ1emg3VGducG4xSjNSWk5KQlBteVlHNCtsMXBJMDZyRFpxeGhDVWJ3?=
 =?utf-8?B?SmpPSmpoZllQK2xYUmJSZ1RGZ253YVUzN0RlL1crdXNqM3ozU01ReElyV0pH?=
 =?utf-8?B?NDJZUWl3TFI4cm1MZ2VsSDNpRVdWeGNmTjZnbTgzRG9HK3pNbE1SV2dQdGhW?=
 =?utf-8?B?QzB3WCtvaHBJanhBTk9naXFWdmI2SGZFck9UVFBSMUYzQ0JxazB0bHNKOUFM?=
 =?utf-8?B?anBNaTRBRGNDZlBUY1gvTXllc0FCZ0Z4QzQzUENBMWhKTysyQVRkM0FxcUJu?=
 =?utf-8?B?eUxXTktWTHA3MUhOeFV3V3B2am1Xdi9JTUY2eGhPcjl2bTJKbXZyR3VaYWEv?=
 =?utf-8?B?OFMzV3Q4eTZIVUNwbXlmVGFrNXNlL3JkekdLaG1qcUhKTjU1cUFVcG9ET0ov?=
 =?utf-8?B?dlJZVFZEY1FIWXliVC9TNkhGM2hZa0lLV0dQdzE4ci83bnAyMDdCcDJNZUdT?=
 =?utf-8?B?NTJVMGtvQU5NeHByQlpOL1ZEQkdrR2diZ09ZUFBTWjhaVXNySTZZdWRQbmI1?=
 =?utf-8?B?YXJtdUJ0MDk0N2RvV0EzZlNORnZ0cEV3WjVML3pSSUd5SFBLTDZKZENjSm42?=
 =?utf-8?B?UWxaWHpTQkVrS3NiWTFXenhsYWtxSTVvT04wUTdpSk1XaHZZV2dFWEJyU21z?=
 =?utf-8?B?QVlwT3p1aVZBYU02RUdxMlNaNzl2U0JhSHA1aEVrZlZUTytmRkw1K3JnTTJK?=
 =?utf-8?B?STdmYUZVVEp6Y0FkbWNYNVk3dktTUzdvNVl3Q1BWVjMySENXanJIdXRnMUN5?=
 =?utf-8?B?ZUdIcVlaeThMaVdQcDdsUnhIYXVDQTZSYnVLbUNnRE44MXZ4TktxQzBHRDVs?=
 =?utf-8?B?QXNxZDNQSnhrYWdDYjNyRDJzdG8ybHhpYWJvN0Zyd1RSL0l0SWtnVDJoZ1c5?=
 =?utf-8?B?ZnJPdUlvQ2FpZWVMbUc1ZXdEU0Vld0V0cXd6RzdqWWVzYzRiZ0oraG56U3Rt?=
 =?utf-8?B?RENibkZpR0dkNjdRS3huVitDNVlURkRHZmJzWmJnRkVXWFk5VDl4ZXAwSTdY?=
 =?utf-8?B?dEhMZXNhd24vUTNBbXhxU0lrbytHVjBvU2prSW9zSGtNKzk2ZUJlSjZTRkV4?=
 =?utf-8?B?ZVhobDlqNnJCQ0UrZ1o4Q2NmRDZvZTV1bEQ1U3lDWG5SWUsvVTNWZUI4dnI1?=
 =?utf-8?B?aUZISHh2ZllSYmdkdXZLbHVtOVdYVjZVbHVobDZrbElXTHVONzR6MzhlaE1h?=
 =?utf-8?B?ei9aTWEvdDQzWGUrOHBGR1EyblRXSzY2ZUVCV09zMkRXdVAvdEN2Ykp4OWc1?=
 =?utf-8?B?bm1lK1BuL214UlRsN0V4c3ZZYlFCZVlsdkN3dVhDRTFNdDVmMnRmT2xtS0Fk?=
 =?utf-8?B?UENuV0R2eHBMMDNuUUVyTncwMFArWkpnRlpDRzVKZFlURHNVNENDMnBOUCto?=
 =?utf-8?B?RjlBNUF1MGJRdjdiNURNWGY2TjFVREJYRDJ0NXhlNklndjdkWW1zOEg3c2FY?=
 =?utf-8?B?UkgzdXdKcWQzV0FhbU5XY2gwYkFlR001clN4ZHJmNnZwRVR6eHF0dE13MUtU?=
 =?utf-8?B?SWlQNDVuU2ZiL1BGZDJMSGlyOWNaM2xCUGRZRWxXejI0czVpWFIyU1dPNndV?=
 =?utf-8?B?OHBpdnFCMjRNd3YrVzBBVnhmVTF1UG1ONWhJMDk5a0Q1OHlWR0kwMTUxTmhp?=
 =?utf-8?B?TE4vVWNjbDg0ZTdEUkRYZk9ZUXFjR0VpNXdHa0F2OGVtaXovVDFEQzFQSmhv?=
 =?utf-8?B?TmhqTlNISFlNWnRIc3J3dE1mZFU1N0pMOUxTckloU29XRWs1NG10MWl0ZWRy?=
 =?utf-8?B?ZHU5TXNLUUxGTk5wbmE1L1MzL2tjS3NTUElmdVRFSzg2OGxjZTNVVWpTSWtT?=
 =?utf-8?B?ZnFYY0JGajF1L0hvc3Z4UWlvRHRMczBHaGxicHQrbUExS0x4MUZMMm9KREky?=
 =?utf-8?B?OEs2TzBPSEpNUVh4aHFtSDNRWlFveWExRkZyeHpFTG1KaWJieXJwejdYUHYx?=
 =?utf-8?B?cGR5ZHJReGNRdk1XQUJMVksxM0VsdDRlU1FaY1doUXNlZ1MxK2hCeFBrcjF0?=
 =?utf-8?Q?BchzsqIJtheTfDBOCxmfUxojk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73839545-5f6b-4fc2-ec21-08dc0e40aec1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:50:15.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ImKTzGqDzDG5i5VJZLzSMqTA9XqcPOecb3O941roWNlyb3ex/4kNnBvfzOb80CtIXLrHieYlZUzLVyxF0/PPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com



On 1/4/24 17:07, Dan Williams wrote:
> Dave Jiang wrote:
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
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Clarify calculated data is same base as the coordinates computed from the
>>   HMAT tables. (Jonathan)
>> ---
>>  drivers/cxl/core/cdat.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/region.c |    2 ++
>>  drivers/cxl/cxl.h         |    5 ++++
>>  3 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index cd84d87f597a..78e1cdcb9d89 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -515,3 +515,56 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>>  
>>  MODULE_IMPORT_NS(CXL);
>> +
>> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>> +				    struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct range dpa = {
>> +			.start = cxled->dpa_res->start,
>> +			.end = cxled->dpa_res->end,
>> +	};
>> +	struct list_head *perf_list;
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
> 
> Given how far away this function is from any refactoring that might
> happen in region.c, and that the locking documentation in this changelog
> will not be readily available when reading the code later, it would be
> nice to "document" the locking here with a:
> 
> 	lockdep_assert_held(&cxl_dpa_rwsem);

Ok I'll add.

> 
>> +	list_for_each_entry(perf, perf_list, list) {
>> +		if (range_contains(&perf->dpa_range, &dpa)) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found)
>> +		return;
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
>> +	 * Convert latency to nanosec from picosec to be consistent with the
>> +	 * resulting latency coordinates computed by HMAT code.
> 
> Do you meen the HMEM_REPORTING code? Since access_coordinate is parsed
> from HMAT data, it isn't the HMAT data directly.

Yes. I was trying to say HMAT parsing/handling code.
