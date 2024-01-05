Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C77360A4
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpcJzste"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704499195; x=1736035195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWTHr0655bXZ5ruXtWyhafk2It9qASB7zBZh9JFmXkA=;
  b=FpcJzster9NMEB3PmU3uYsP72HA80xbkhQng6reherm5uUycnlbBe0iM
   7wA/Y+pUNFiURiFd/kRm8iHR2VUxqrEIzaX8XukFXFv5aM05rCfsOg5O0
   sq1mo7Js73VFTdte7tT6mgW9H0KWbilfmqa3tUZVLtGVf/CuqeSYhpGBK
   IHt2pBhI2SAeADCeofwoGeTwj72vo8ly7aLuCyCznl9aA2P/E+JQUglVh
   zYzp856vGw55W1nhEYbYQ0kHmomN/8qDQl7WjtOLqCTIOObHS6Tbi+yYN
   AB92MwOYZCok3gNMnSfdeHNvAGwNZxNSiQojaGmZ+iJWz/glAlhNhBaNF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="397337221"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="397337221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 15:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="815085612"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="815085612"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 15:59:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 15:59:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 15:59:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 15:59:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 15:59:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR749NhCqRkCj6AlxdsNMoi+i/datJhJ9p2Y65wjEAZOmBH8pg57/mTpaqZ6sJ+iMSweFhDefHF99lR4vRadF9cjeF3dYnZUi7EEPsoukUrW1EYAoc/KORVIuwhuUITyWUuxQXBGiyyTcS/u+Xfrdm8IKSaUtO5avTNcxd77GioZcieGG8Dvce4u95zeIyoinDKHQN9tXgWG8t2vPZ8DRO7rZx1Cf6SQ1HR8aP/oR7fFmOTGH/+PkS8+duuEybBVZvXPu/A5f521G8TqJ4diGzqbuoy7JVIu2zLR05ruGV1sIMhqpFMjk4IRXLdaW1sRv6omRbx7XsvZ1YX62MLExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni/Nqjb3SQTcM/gWLCosEHSoh9o0BiNXUPW1CARLTHU=;
 b=Zh0jhH01yryo83E0Y6NupceKdJZC9x+KOvJhtwwtmMyL/PCjfu8QFVi8PPugg3rCsVBiFIAL8RO9tyG+mpgQ71lQDrgfMTdocVSVErsvAXN/2Nqk1AY7sOv8Ordxsq+j1X1JnwqxzjUJQCkhMZoaWeLiWuTL75piAvUFS7mfoY5k18Ep5/rKkleJIK8zLGgNlrF+9J3M3lhff0AMxEB2moOyRNHD+OIguTmYUOYj0HlNtI67omULBhqUC3CVXvcPAy8glj1QH60eWmfuX9CQqLKqaPYB6YCqWj0BG7JJ8L3z1hmAi71MrtaTROS8P0S5vPkAToBiRa5rwuFcvWWv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ2PR11MB7575.namprd11.prod.outlook.com (2603:10b6:a03:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 23:59:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 23:59:51 +0000
Message-ID: <3d0a0ec2-1184-48dc-aa09-5d62b17d06a5@intel.com>
Date: Fri, 5 Jan 2024 16:59:48 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v6 3/5] cxl: Fix device reference leak in
 cxl_port_perf_data_calculate()
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246681.3779673.2288926019977963333.stgit@djiang5-mobl3>
 <ZZiJMN4zjjDErSRF@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZZiJMN4zjjDErSRF@rric.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ2PR11MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f779b8-e357-4ad2-4e2d-08dc0e4a67bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7HCafMsDcqf8kGdVRkKshJsHdtH6SASIhhhORnF86xMhFzlmIKpjuDvbJkZoR7mH9IaJivKPpVCCq7cEwZUr6r8vOU43Nb+KLxIdxzKgd/5K1HhKXS+n8iHNNXYgm5gZh0gkcDwDyBIGJpgD5BwmhIUEtYZutFboisY+6NCoqvFsgYdrQ+ePHJHz2FWFkgb9j6sQxR+7WQ26kUV9spK1MXilEReU7BSsBCRhoXUlhM3kHWOepXpbQFoIQQr/8ap/P3pADLpDZdbhALvhc7oQE98cX3GRsgLDzieibO5Jt+XlI0yF+3l7ZwuhN0vfrdwVxspOIT98GZ356GFw7nVRtgRwYv4EW6EXnkLxupRYGPPJAvLNGjcszBVTMdUKbG5w174yesm8Hftpecdi9kkUz/in1p/CLCWh61Q/5Xsul4OoWwXxrW/cVWNMgM4JB0+bI8eQHineqLo6jIYwXQ3JteBxfOEkLrP5V7cFy//BjoGGoLA+EKXOGIl2JigjpyoM5LgTDEsao6CxrRsb+mnClwrMQuCAB4vg1OgWOKe4OKR81tzHEA8F/YZxKb9KVjttM03vITWeOVCflDJP6wH4aRo4MTGFaRhnZRlTYUFdoVTTgAaj+1+ethAWG1lVNUE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6506007)(6512007)(6666004)(53546011)(31696002)(86362001)(26005)(2616005)(66476007)(83380400001)(66946007)(31686004)(6916009)(66556008)(6486002)(478600001)(316002)(4326008)(8676002)(44832011)(8936002)(2906002)(82960400001)(38100700002)(41300700001)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1jcnR0WGd1SjY1ZlNNUjlHYktXaWNYU2dkQy9ubVJ2U2tCV0s1UjV6SVJZ?=
 =?utf-8?B?bVEvdWlaNEw5K1Nra0psSldqUmsrV3FUd09veTAzb1p2L2NhTmNtZUttR0tk?=
 =?utf-8?B?Q05tVGNPdnJXbWJVdVdWcUVPbWI4QWJlKzFTK0dIdzBvSmpGQVdZODNsd01p?=
 =?utf-8?B?VFpVbklUc3RpUUowYitBWVdWQzgwc0RUQmFpWXViS2xLZVB6TDgrY095dDRS?=
 =?utf-8?B?UFM5dXVsQVNXNldrcjBtTlNsYlY3YTZGeXdsRm5IeWFMQjlrK0g1ZVF6cmJJ?=
 =?utf-8?B?eVd4cXB0d0s2NmEwZ3d5RFVFODk5RkVRQkl4NGtLVEx1aXBhc3c4eUZ0L3RH?=
 =?utf-8?B?eUJiVmRIR3NpZXFPbUdUdGZqaGRtdDRHaWJmVWFHUHFKZ25kZFA2OTdMSytr?=
 =?utf-8?B?L2tZNWpvR05LMEswRlpqZUpQbUZYeUprblFoMGg5ZHVaR3VnQS9velNtYis5?=
 =?utf-8?B?QjJadjdNUkV6c21iM1cxNUhaZU5obzBpVlJENjhXN0YySFJrSUw4TGpXNWZZ?=
 =?utf-8?B?eWtQdTF5M1FQQzlzTE9JKzdtNkU0akNLb0dVZEZTWTM2d0xXUEQxUVNDclpn?=
 =?utf-8?B?TWpFcGlBQ3VkY0xBL3ZGUzN4S2J6elB1MVRjUDNqQkpqYjFMR1dwbktua0di?=
 =?utf-8?B?Z3Q0Wksxc1dWanVRNHJFRWxJc1ZCeWcwUExEZ01lMFU5K1RUbUQxZ0JyRWJy?=
 =?utf-8?B?UTJ4aTMvbWthWVEwZWJiMFNaUmxGU1M1T2xNZlE1SUhhOW5jZlNDRkdiUkNK?=
 =?utf-8?B?eVA2dytha1U5MGRSa0lVbVFHLzlwY1pGTGZrbVE2eXh4Y1lkMGVqYjBMNk00?=
 =?utf-8?B?aWtIaGlqR1RDUDVxb1NLTmR5TWRqSllmaDMySFJ2UDNadmJoU2NtbE5Rektn?=
 =?utf-8?B?TTQ1ZjdwcUN1ZFZqZWhNMkdnMFF1MG5LV0lNQW1VellIR3NONkd2RFhTT3BB?=
 =?utf-8?B?ek5DZjBObzZWN1R0dURGMFRjYnE2UjZaeUNCSDdENExRT3BqdGI1Ky9ZN1l3?=
 =?utf-8?B?MXA3VWtuSkRDTUNNZUJ6aHVweXJBQ2tWY2hWTlJDR3RQT3YxSHY5VFV5Sngv?=
 =?utf-8?B?TlhLZ2t3SmZmc1FjRGhMSnFQVTRSSm9PNWVPM2JFSmZvS2RWTTl3c1pTMm95?=
 =?utf-8?B?azA0cTVwKzVYdlpqdWVNSTArRTFRYmlzUjkwUzVJUGY3aXI1S2VPTUlNWUla?=
 =?utf-8?B?NzkzeGZ5SjZXa1dOZ0FiREY5TGtodXVsTTJzVFF2K0s2OEpJZkhnWVdTVXN0?=
 =?utf-8?B?Y0JSZlNRRFFWL016OFdYUHYvVjQ3ZFRrd3U5VDUwZE9oZnRTYjBNMlYydjNx?=
 =?utf-8?B?QWV1TU0wdm9FYmFlZTN3dVA1TnRTY015bnErWmsyOFJMV1Z6QXNpSno3S0hk?=
 =?utf-8?B?Z0NEUm4xZ2dYVXF5VGVvbEMyWjd0NEVGMTNBSlVrcXdjcVloblBwejlRb2hk?=
 =?utf-8?B?aTVpYWhOK3F6WHB1RHZ0NkdDSGZJNGk1Z0diNjdwQzROYkdaa2lyang0Tlhw?=
 =?utf-8?B?eG4zRTRvUjVmWWkrU0x5K3ljSzVnMzVoR2hEZ1MzMHBFOHZ0bFJteEg2cU9R?=
 =?utf-8?B?dTJpanRxR2xPQnpLVEN1TUdVaFlUSVF3YURsM09yQ1E3c3lnRjVoak1peks5?=
 =?utf-8?B?ckZoQkk4Qm5mMWNub2tiVGhYcEZnNzBPbFV2QW9XazAwS0VIcmVVYTE0YkU4?=
 =?utf-8?B?L2kwR2tqTG9rQlNWbzZrU2RJQlZOSG9abzkzYkl2OUI4V3BSNW44cEphY0J0?=
 =?utf-8?B?eUxxWFNhOC8reDgycmJnWkIyN3hmVFZ4SkxCOTl0UDJaVTZJdmhoMDNpMUtX?=
 =?utf-8?B?Y0MrZFZNRUtPTERCdTM3YUg1cS9za042L2l5ZFlmRWNCVWZhbXJzYTdXUk1s?=
 =?utf-8?B?YnBuUDQxYWxzTVhTcHFpWTc2VVlDMnU0RndlN0NiRVRSUkllL2dWQjhSTkxR?=
 =?utf-8?B?ckhOZUY3Vlk1ZDdVODBQeGpXQzNHQzJqRDV2SVprNVNFUDdsQjRDc0dncG8y?=
 =?utf-8?B?dXVHSlBwandBc3FLRDFWQjMzMXlTYzVoQzVMM09aUElLRDVtQlplSWdRb2ZP?=
 =?utf-8?B?MUJsdU5OeU9iYTc3cko5a1V5NU5Od2NKb3hWSDRkZjBEdWFFWDB3eS9SWnlz?=
 =?utf-8?Q?nvCx3DUXufklvgD/PbkMDl6L8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f779b8-e357-4ad2-4e2d-08dc0e4a67bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:59:51.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34N+xwLyhjyKVFg3/DiNdRBIxiOAeFWyeRTZ6UCsUOaIs5idN1ayIuFG9UgzdG1+xP18LRxo2DMStlcqFN8ODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7575
X-OriginatorOrg: intel.com



On 1/5/24 15:56, Robert Richter wrote:
> See inline.
> 
> On 05.01.24 15:07:46, Dave Jiang wrote:
>> cxl_port_perf_data_calculate() calls find_cxl_root() and does not
>> dereference the 'struct device' in the cxl_root->port. find_cxl_root()
>> calls get_device() and takes a reference on the port 'struct device'
>> member. Use the __free() macro to ensure the dereference happens.
>>
>> Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v5:
>> - Update patch title (Dan)
>> ---
>>  drivers/cxl/core/cdat.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 0df5379cf02f..c6208aab452f 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  					struct xarray *dsmas_xa)
>>  {
>>  	struct access_coordinate c;
>> -	struct cxl_root *cxl_root;
>>  	struct dsmas_entry *dent;
>>  	int valid_entries = 0;
>>  	unsigned long index;
>> @@ -174,7 +173,11 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  		return rc;
>>  	}
>>  
>> -	cxl_root = find_cxl_root(port);
>> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> 
> I am not quite sure here, can a definition in the middle of a block?
> At least this is uncommon.

From what I understand with the introduction of the scope-based resource management, this kind of declaration is ok for that purpose? Dan?

> 
>> +
>> +	if (!cxl_root)
>> +		return -ENODEV;
> 
> As Dan pointed out earlier, isn't there always a root port in the
> hierarchy? So the check could be dropped?
> 
>> +
>>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>>  		return -EOPNOTSUPP;
>>  
>>
>>
