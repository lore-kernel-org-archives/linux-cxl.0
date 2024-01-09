Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF939FDE
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hsx7pKX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704814735; x=1736350735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sqZCJs3RcrFKAFMqHPriHYOA4fJQvGQ2HlQveeAh4hw=;
  b=Hsx7pKX9BoDw0xE/AeP7XvmY7E6OciE0IJ0TLWSI8IhMWkXTlUub349i
   MW+SCoxTMxEhKK/KkeyhYQ8NfzLC7x/bUgRtGOS1/vtXjeMEK+AEdReRW
   h9v9ULezOQqh6Fh0WzNct554QshOniSgsi96WpAaGIYlUTC1+O7MrVpZQ
   HulGEMLVwvyedaouaAYOhWkd+OpVfO5dWHsZc90whzeZfz0BokWtVO2XJ
   vDdkBpUcuIqgBJJH9sFSVrt259R08SnGQMyxzBsGCQh2xiBu4TZ7QzjFA
   M7Npa+ohakuxp1YRXqk/LUYN516DxIJX1uwDCLMkDLbKco604e7274ndc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388673857"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="388673857"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 07:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="23915625"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 07:38:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 07:38:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 07:38:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 07:38:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwTw79cBR+/NkRA7YcRzA6SIK8n3jZifB4Qk9kbxrE+8LbNTCxuG2Uf8MEhi86eivhZcDjznTQDB1tu9V84rq/d+UX1WHtwdhzEzMHDXoUjV4YcWUgIH6dcD5nSJ5RfESOqiRHCIIvj9XS0Y8/xotCb09Sn6+oswTZjOE6REDa34MrqSqYg3aPeGxa829s5q6oiSfHMA+V242X4YB+FFws5o0enrUrjm3XwVzCbcxzk0VmBcynJr6J6UrbjrTuyM4cdz2nJZ1m05weU+aDNr4J/5UsEwaSItjBHPU9IeYG4YJALQUnt2omj0JuAIktgRVL7C30J1hT/SjPr4tj/HjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/+8e8keBp0GlH4NpjeAdTrxgVXebXApOw/HJkeTi0=;
 b=SrDLRjPXrDy6BiQIb2lsekEj3Eup+QT7FlHymtTOA8U1jqQaK0p2rg1nPFFlrO9jKRuCZPqe080BCZ4eFat/mGvLK64H/WhHVkB+rCWHvpsU0HwZ8Y3MmLK9hYDLKkNn3Ss6T1dhWxwk1+/J7UxmWs5zJ6m/U5PWQN4M458nKGQ6WBBPalTQiOgAaShXsVsvWMhnDfYGUbOZ0wBnHtrqmo/BGRHTDO9FHosIGRWfa3HnWIoBUyDiZzKhBixNvlXVS4c1xM+UI7Kb0B9hi/7NoWr/TClcahmQ2An/t5rH3I+uRqBvz1/PCLvKjd4WiKmersz/4231S/zsprIa7/xfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 15:38:35 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:38:35 +0000
Message-ID: <c2a9b434-0aee-4860-aa56-cfcbe66978e0@intel.com>
Date: Tue, 9 Jan 2024 08:38:32 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl: Cleanup unnecessary uages of cxl_port local vars
 from cxl_root
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170476243490.115624.648453218819673314.stgit@djiang5-mobl3>
 <20240109152953.00006d96@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240109152953.00006d96@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: c2775b20-ebba-4d4a-4ba5-08dc11290aee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6lQFNAa6fCwiHhyeDaKan/1MtwnmISPbc3ofVRuEBdypTIJEKLCupH5QGpCmSHCnqYGSW1LXmQ3InRpnv76QJqt5Upy8TrLhch19O9idiA7g2AF6DF346tCDxJygZuLZRwB+OId9+i77kdwj6+9NYYxAZRHaXgImU1YMJID2XP6Svxii8ueWesOYQ7DfPjIvQDsvf1pAnOjhakem0Uabphc+Wp6zjAd7Cp7ImfLVIwJ9CP16Yh0io5Yba78xk1ZPy45hVaqJcQpsUFWg0X1KthOUL+97xNldbB7CqdjWjMZv3xDH6zeeYeyZgtw0nlxJfXfo80qLTRD97G1UI7J/QhRqxcvsiX9PQN0skpi20tmJqpwJWFYS5dK097VkHHxU0wsV250m0xWmE2dLzx1MvMCb33+cmusVFdqsnXs7UUZy4QLByh32vPyjNyVF4rLNCj0sgXa1eD6F3uYXClPQwUWLFZydIaAQ3KEoURa5YNGpINg/s6VOlIiEnGinQcIIOSjNmQxPDZDUajaqqWxfgoEOL5TW1rFSxc4cen9mhzbOeaAUqQMADFNysbADT3hVQVrRYilCkUkZ5kkh9/JvdazITbPALTZylLpyTQTUmeU8OYkZ1EgdK9ttjbnTcgA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(31686004)(8936002)(8676002)(36756003)(31696002)(6666004)(6506007)(83380400001)(4326008)(44832011)(53546011)(66556008)(66946007)(2616005)(6486002)(478600001)(26005)(6916009)(66476007)(6512007)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dCRVNtbUtEK0dhV3JMTGdyWXAvblAwekpZQzlhbWZyV1gwMVJxWk9sR2Jr?=
 =?utf-8?B?SGtEVVBMaGJUb09YYWhNbUZwMHR0SmVwVCtWNEc0bGxQMWlsNEVuV0tXL3Nv?=
 =?utf-8?B?Vk5NSTJPMkZPTWFJUmJpMkI3bEtWZEJPSzZEanJoTzcrcFByc09RUlJxWUFa?=
 =?utf-8?B?eUYxYnFJK2VsVTlhdmxmbVM2Yyt2WFFxYXB6S05mdG9PbWtZcisrczVQOFU2?=
 =?utf-8?B?L21NNVNZbEVRbkREem5xTGNhb2RySGRFM2NYdkNsTkZGaXFpbVM1aXdIZFE2?=
 =?utf-8?B?QmtTY0w3RS9rRnVoRU1ueTFxMmQxd0dZR3I5M3oyMUQwNjQ5ZWkyK1MyOXVK?=
 =?utf-8?B?MDV4b0MxL1V3SXlWQWVIbUZxdG5neDROUXcyazlPVVVreWlvN29SZ2pOQjRL?=
 =?utf-8?B?Sm5YdVFNd2YyeDJyeEtPQnVJYWpRTFVVWkN3N0RhWHlIbGd6TzIrNmNWUjIr?=
 =?utf-8?B?U2pxNVdPMGIwRzV5ZXBXTVZpY2dheGx5S0tuVCtvRmdBWWgrajMzdEhNTFlC?=
 =?utf-8?B?WXlURWFHQlAzQ1hGVUl1b3lqNnpuelhKYWJNZGdVbkRQa3V0dUc2UTBuT2RJ?=
 =?utf-8?B?ZzEvNmNaaC9lUVJESTFtYmRGN3ZPTW1KcC8yQ0c4dStwL0ovekZSQU9PUTVK?=
 =?utf-8?B?bWlWbVorRm8rT05sVmRsckNpQ0gybGFCbTVTOU9NRXJoanBwQnl1SGcvUmla?=
 =?utf-8?B?V0o4ZDFtUjhJMDV6QVpOZG9qKy81UlFaTzI0bXBQaDFaN2pGRW1ORUlvNzVx?=
 =?utf-8?B?MGxvcml5eHczWTRRK3lBNzFOQ2lTUGo1SFl2SnkrWmdrTUNmYmtOZEdXZ05o?=
 =?utf-8?B?K2FMMEtXaWkyNUxqQnVWV0haVGZpc3ZPOUl6bmg2SmV2WDlUTWV3OE5CdnZ1?=
 =?utf-8?B?UkgwV1A5TUJpalMvMTh6Wk53M3RYTVgxUnRZZ2RnVjlHeDBJbzdGa1hqYU5E?=
 =?utf-8?B?ZkxRMWZodUFqaDVBNzF1a1VtdTA5R2dLNk9PVjlIODBCQ1VoaE0wVjdDK2dC?=
 =?utf-8?B?eFRhN1FIbG5neTg4T090bFR6d2I5REZmSW5Uc0ZsU2VRbVAveUM3SXlVcktO?=
 =?utf-8?B?OXg3VnNpMlhVVmNzWDc3b0xQM1JEQm5IV0NjQXBoSlhpTlRpdUw4TXFMZHFl?=
 =?utf-8?B?UnlZNFFqa0M2NmJOeGpSMnlNZCtzZzRVUW00Tlc3cUhzSnF4V3drSXdmVEVC?=
 =?utf-8?B?UDJiRjMwcG9WQUwvSkVhYTdXMUJBUjNDUUgwcm5ickNLTXNjeFZiUGNoNDQ2?=
 =?utf-8?B?aTJ0WDFYUjhhT0FGV1p4em1aZGt5Nm5BUzQ5MTVrcEpYZWxuTnI2OXdXQ2ZE?=
 =?utf-8?B?NWRtVFZMeUNqNkJBN1J6YTFDZGtDLzB0eG13VURFTzM3S2F6NysxUHhycUZV?=
 =?utf-8?B?UE05RHZYSE1QMDh4YnpNSlkzNUtpVFRrQUxmck1RaDU2bVBmQ0RheG42dFpx?=
 =?utf-8?B?b1Zxb1A3ckN2Zi9xdnVZdFhTQkRqZUlmMjVFL0hKeis0bE9Qc0F3M2hLelZa?=
 =?utf-8?B?M3BLNHlGTWIva243cmQ5cjBCTFlhNk43ZkZZaDdSb2R6S0pXVVpPckRIZi9V?=
 =?utf-8?B?U3FKSkNlSUtVUGh4R2hYR3lPbEZHNEo4cXZCTGVMTHo5MWxKVkdYVW1CTEdB?=
 =?utf-8?B?ZFU2N0N5VlgydmFUVm9vb0NZWVBYNmxDU3hodHNuK0lKWnZ5MFA4YmN1VDM4?=
 =?utf-8?B?Vyt3NENNR1J2NU8yUEJMNVlnWEIwZFN1ZE5Fa2YyanBYc2VlTWNqVGhSU3lr?=
 =?utf-8?B?N2FobUd5N0FkZkxqS2RpTVBtYnpSVk13SWZlR3JjcTMrcFRsK01mMHh6VVU1?=
 =?utf-8?B?cEpwZzN4ZWdNM1lZNkpVQVplakxxSmdxc1hyN3d5VXVrUjh6Q0VVaTNIb3Bl?=
 =?utf-8?B?M0ZCdXo3RjVFS0FvK2thM1ZEbWlzY3dQaVB4SzJFaXp2UE14dFlpUUhuRkJN?=
 =?utf-8?B?blBMYm14bTUvdCtwT0h4dTJNWWpkZ2R3YjVvZGdWN3J3YVg0RlUvazJ2bk8v?=
 =?utf-8?B?U1RhblQrb0hqdTEyRFprQ3hoR1hBZE93ay9zRHBCYVNaTytVT0o2Q0tIcUp0?=
 =?utf-8?B?UkprYkVYVDI5czdPOVdEemJMcVRueVM5Y0RTTmxVeEhxYkF6WENLWnVxU0Ft?=
 =?utf-8?Q?oj5cAw3Q7BN7QtZ8jUTM2KQEb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2775b20-ebba-4d4a-4ba5-08dc11290aee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:38:35.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3YlLKDf+44RkZDWflpn/cAnilk4yab1UBmtROQV1Lry0NHC6+XDo1hMPY5q7q1NAjwz7XN215lFnU8FagHFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com



On 1/9/24 08:29, Jonathan Cameron wrote:
> On Mon, 08 Jan 2024 18:07:14 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Remove the local vars that points to the 'struct cxl_port' withint 'struct
>> cxl_root' and refer to the port directly.
>>
>> Suggested-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> A comment on existing code inline.  Otherwise LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>  drivers/cxl/core/cdat.c |   13 +++++--------
>>  drivers/cxl/port.c      |    5 +----
>>  2 files changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index f7ba7bd2e459..140935511bab 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -290,7 +290,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>>  	return 0;
>>  }
>>  
>> -static void cxl_qos_match(struct cxl_port *root_port,
>> +static void cxl_qos_match(struct cxl_root *cxl_root,
>>  			  struct list_head *work_list,
>>  			  struct list_head *discard_list)
>>  {
>> @@ -302,7 +302,7 @@ static void cxl_qos_match(struct cxl_port *root_port,
>>  		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>>  			return;
>>  
>> -		rc = device_for_each_child(&root_port->dev,
>> +		rc = device_for_each_child(&cxl_root->port.dev,
>>  					   (void *)&dpa_perf->qos_class,
> 
> Whilst we are here: Why is the (void *) needed or useful?

It's not. We can remove it. 
> 
>>  					   match_cxlrd_qos_class);
>>  		if (!rc)
> 
>>
> 
> 
