Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF87208AB
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9YxWM04"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80DD93
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697041764; x=1728577764;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l5WSjXUiTwwGPI6QlABuW6Iz4uqmvXXuxf3mJFAxJ7A=;
  b=L9YxWM04ONYCYbZBnPiJ5EeN4dhUrnRj0oUmC6XFLhVFRzaR81IzvwsH
   P1NEXLkt6z10POr/N1dIPThvdQrzPLFTJwl2UG8fdQkICnIZ2NTyJPBE8
   6Pzzmti2+0gfpvI+HiPA+4+nuEe6DHhm7iwKSQjzx3GIrvnF3FQSNTErm
   jo/AwxyAS4QleCM5/BDv7WmAHrMR8b/7Gc7KPsU0ymEFHT/JYjiuw9O3e
   cIh7fcNeymgEggP7t0r0vy/9QsUm071hpAJSBVyy49MOy7XG59j2TFQ45
   QsU9VuxY3p/JU5BtIAg6/tYYtjEZqT4mrZHHc9FjfOGF7S8T6DXMMfTSa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="375054316"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="375054316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783309851"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="783309851"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 09:28:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 09:28:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 09:28:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 09:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3AUfnKKDGPs4cdLd5kou0GLplOJLZtB8OMqfkqWjt/AP1WGWfpOzzL9FWFTxVH5WSk5gfgbVP3Njk0pGr8vu3Sky+DklZ7uLwW+LFsgIBpt5YxVklYhRF2vywBqHI6AIe0u4LXXJMH9fyqVts2hW0vOP7oemqHLLWLA41SruUdCcsWoQoonGcJ9qkEH5r61Pb/Nr7UcQU4GxJ2F4T0QJjKEYJwiM6h66DTunHBalchOouKogAzVDqwBBqbGg+sgpDaHl9pk5ja95unhCtj9eldXMa88dVSzSzetdOACG09D772kiFnWgRHG8SCZZgXSqX3LMQmvIdeP4RqAMUyKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tz7qYfWtpUHwP8qwfH3NsNkJyE5QLclCuubEGysPvo=;
 b=RBUWcZSnffLubXYwc980Yfr3GkdXNy9yxWxkhckmvpy8EYNcIU39cFTgYeR3TugL7pjBl+hcpa/NWCRxX3Z7cF/lyLAJVVXokWjt+XBgIQTH8xXj8gqw8IVy3evrLxgDSw3vKeEAV72JNU07/iEKvNgSf3WMmYVEGn0slqM2DkeF2wFUSoHJU2Vbs8Y3iLdfQXd+ah0ZQ9Sg3AfhQ/aj2qEejEHUDDuGm2GMnFvdrgPxmFkz7DPj918paSgTnGAvCP5C/p08OhJgy0lFTyrrqfF3qqJOXHsypt4tEW8nULx/TkuLyZMgQDYaTWZRw/r5Cxihj3P16otNvHMwgnnXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 16:28:37 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 16:28:37 +0000
Message-ID: <fd0082bf-7229-4767-bebb-ef318596ea52@intel.com>
Date: Wed, 11 Oct 2023 09:28:33 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v10 22/22] cxl: Check qos_class validity on memdev probe
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
 <169698643180.1991735.11469426905286068135.stgit@djiang5-mobl3>
 <20231011142924.00006060@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231011142924.00006060@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2ac9a8-eef2-4e81-544a-08dbca771f02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLSp5dbpW874WLAIEP/DcFhJtEnZoJB3pIjAAnsiUsbFFUEICjjd06u3ljEqOqdptDZ3Wwn0RDOFkxcAA5BVsUl5lvetidpfKfNNHNt8XLmBR7W86XpBfqyXFIfI18H7pJ3Zt3Z2sLjLhsa9do3qXeYt9jnIsxC5GgWESOivhQeOE1nB0Tzpe5NDkGiICgjd/gk07/bxeVs0KhHercZPVUjK3MceJw1dRXW0EWYWL/L2+iLDNsqUroDicrhOYe0+ebrjP8zrdwPy40D3a9gy/YVN9pYscYuD1xXM1Q0quI5L5t6ihwW5XPdTCr6d4IreMlFnKCgJStrCluhOUWMwEBofpC3Ni5+gLI5QGGsYflxjQ1rVqJY3gmKKCd91niD3AlRo2HrN+rH9ucqG228hK3Otx/2V02zGbk/EIu/4hQccY/qKSh9n/tY0UgFVLcRm+yarwLf5RTiNN0PpuECj/sycCd8fNxFmCR8C3tXRmmSdb34+AMSi9Fj5m1uRar47HBgR6GL2i8nG+TtJqkq/cu62N38J8qPOyOQQPp1qL1Kb4MiWuCocoNkILLWrUPNJ7WW07DyNI8aT/ljhJp5fNjX9EKj1dNZODz3g8fpUd6eIlqXeJYjiqE61k9Uu2UWl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31696002)(478600001)(82960400001)(6666004)(36756003)(26005)(6506007)(2616005)(86362001)(2906002)(83380400001)(6512007)(53546011)(38100700002)(6486002)(41300700001)(5660300002)(44832011)(66946007)(66556008)(66476007)(316002)(6916009)(8676002)(4326008)(31686004)(8936002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEFEZDQ4Q2tLL0ovcFhibzd4bHFubnczTlF2SGdHRFhSNkZUY0k3RldIU3pY?=
 =?utf-8?B?VkZDOWRneVFyekRpM1JkSlJoVC9SYzd4R3FKNXdLVXdVV2pwQTd2bTdGNUpm?=
 =?utf-8?B?VGJyb1BhK0xBOW9VYThBL05oOXNKaktIWjNCM2U2aU9ObTJUZlFwWDdUaGVh?=
 =?utf-8?B?Wmdyalp0VGsyWUJsYkpIMEpRYTAvMXg5TG5iSUxZYnJlM0d3bFV0NWdrVmJy?=
 =?utf-8?B?SjRHWm83di8raWE5Znp1Y2gzMlE3aCtHS0dLN1J6WTlFTlJLc2laREEvU2xK?=
 =?utf-8?B?ZllkMzgweHp1a3ZNeS9yTnduY3NXRmpaVThVZVFsU2MvTmJHdWV6N1RzMTNl?=
 =?utf-8?B?YXpWSU12K2xIanZzLzgzM2Fmdms5Zjl2NXdNWThQWDVzb2xjZGswZXZxaUxF?=
 =?utf-8?B?eGxPTkZtZ08rVXluZmI2bGtkdXE3WG5xM2hhK3YyT2hUWWNreGhYTStOZEhs?=
 =?utf-8?B?K3kzUmMxV1VwUHhSQldpV2lkYkFXNDNvR1U0akU0WmFla2ZTSFhIUW82R3JR?=
 =?utf-8?B?UTNsUWlDNmorbEphL011a2NpMkFBOHhEcytVV0dkUUZaalhKRFczSGQ0Zndp?=
 =?utf-8?B?bjFrRU5SdTQ4RmFWVTQ0NHZtZmYyZktyUVk1OHdieTJlZTRHODErUTV3YWFy?=
 =?utf-8?B?MTh6K29uS1Q5NEFpcExmaFZkeXozb1ZWZlNJbFp2TkVFVWdOYlJPdzVsY0Nm?=
 =?utf-8?B?SFFaNzJsV3VLZTNsaGx5NEQrM05aK2xZZTA1NFZ2Nk1vYnRDeUNRR0xFUEFH?=
 =?utf-8?B?V3d1VWUyaE1xNDBrWEQ4Wk9OUVE5VjkwTlJzNEIwK1pZOTFwK2k4YkhvazRr?=
 =?utf-8?B?d2pBMTBrdm1FdmRFbVNyYjJheXh6dDFraHFVVC9VQm1JdTR6UnB0c2RyUExt?=
 =?utf-8?B?WEU2clFmbHpnWFd1dmRxQkd1U1dTbzUxU0tLMW5WamZsemdNc2o0Q3NsZEtI?=
 =?utf-8?B?NC81TzZzdTJUMlo5bmpRcGprK0ZDR25IZkFrT0hiV1NIS3dQMTBFYkFLQXJx?=
 =?utf-8?B?TE1BcVpiV21lVk5mYWpuYUw2WnIydW5jNHB5UWhQMWVrcDR0VVRyaUQvajJa?=
 =?utf-8?B?MW51RTRGYUhPQ2NrdmhOVmI1MHh0VDBkTHFIVk9yYXF3amZ6cHVBZGhYbzBk?=
 =?utf-8?B?aUZXdmtmR3diU2dXbFl0MDA3UzVibEh6dnZ4U2lvM1QxU2wwRlNXSFZNT2x4?=
 =?utf-8?B?MzJveGVja1pwaWxlL0dNRTF0NFJ6WHg0UzZjRm1YV3h5NzR4YU54NCtHeXds?=
 =?utf-8?B?N1k3aklJd2tlOXBMa0I2ZW50akZ3UFhsd3ZBdkl5K0g1bENMa0tVU3RlS3Y4?=
 =?utf-8?B?cWxxRm9iK21JbDlUTEw5RlpzdjdHeGZtdGc5OXBYam5NTlJCaE5jNWZHOUhB?=
 =?utf-8?B?RFZZY1N1MFpjRE9YWGFCbEZ4dTMwcHpnMkVrdnZ0MXpWaXJzR2t1dHRhUFBC?=
 =?utf-8?B?ZXNBMUh2M3AzeUYxRkpoeUJWNlFVMFNwbFNSSUg2M09WbVIyeWRhenl6V1d2?=
 =?utf-8?B?NHN6bmFZQkJQS0pyZkVCTCsybjJhdmtuT3kwdDFxenNMeUk0LzlSbTVPN2hs?=
 =?utf-8?B?MTFsNkRSb3ZibHkrRjQwN1ozWnBoVGZjY3RhS2lYdzFmclg1VU1XYXV1cm9s?=
 =?utf-8?B?bUxMRWFkdzd6bzhCcWNGSHFzZW5VdmpvcTNUejU4eGRqR3RybUJ2VElscWJL?=
 =?utf-8?B?NGtJL0EveXNxaUxVb0lyRHN5d01WVCtDbURVcFRHeTc2YXZ0c0JmUytwWVBk?=
 =?utf-8?B?UDkzMy9yL0hvczdNa05NS1ZBeXdINnByTVBmcDNaSGFKaTZyOGNiQmtIQ1Nh?=
 =?utf-8?B?TEY3V2FuMDlydzVSUEtjZ3poTG5sYUJNTEx4Zyt5L3NzMExNVkt6WFBHTFlp?=
 =?utf-8?B?TWwyOFZDY28xZFhLb1RMbmVqT3k5eGszeCtFZkUwV3lIWkZsTWRsQ1UzV1Vt?=
 =?utf-8?B?Vk5MbldUYzJxdno0RlVkOGk2WjhpNitGM1JJYzBXY3lEVGZrSThmTlJOUGhX?=
 =?utf-8?B?YWgzbWtEdHBYWnVpOGVkN3hoL0R1bDdYd0h3ZjVYdXJWVnBJUFl6UXdleXd3?=
 =?utf-8?B?TG5odHRpZHNoQW56Vnd5QldvbytpN21ZczEwS3R0MWtYdW9od0hQMVNuOFVM?=
 =?utf-8?Q?UkvnT8qmmi0PGD7U36NdzpQlT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2ac9a8-eef2-4e81-544a-08dbca771f02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:28:37.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcWYl+7uvyHweElSa6zpICXkd2J94PmbZwVXyunm1t7ShjKrJpfDiR97dmdbWdc+lSuLb7h8AXoUAvGQmy5BoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 06:29, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 18:07:11 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add a check to make sure the qos_class for the device will match one of
>> the root decoders qos_class. If no match is found, then the qos_class for
>> the device is set to invalid.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/mem.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 317c7548e4e9..3495119d2edf 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -104,6 +104,70 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>>  			 cxl_debugfs_poison_clear, "%llx\n");
>>  
>> +struct qos_class_ctx {
>> +	bool matched;
>> +	int dev_qos_class;
>> +};
>> +
>> +static int match_cxlrd_qos_class(struct device *dev, void *data)
>> +{
>> +	struct qos_class_ctx *ctx = data;
>> +	struct cxl_root_decoder *cxlrd;
>> +
>> +	if (ctx->matched)
>> +		return 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	if (cxlrd->qos_class == CXL_QOS_CLASS_INVALID ||
>> +	    ctx->dev_qos_class == CXL_QOS_CLASS_INVALID)
>> +		return 0;
>> +
>> +	if (cxlrd->qos_class == ctx->dev_qos_class)
>> +		ctx->matched = 1;
> If matched, why not terminate the bus_for_each_dev()
> That is return 1 and amend check to be if (rc < 0)
> Not that this ever returns < 0 anyway.  It might in
> future though so that test makes sense as defensive measure.

Will update.

> 
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>> +{
>> +	struct device *dev = &cxlmd->dev;
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct qos_class_ctx ctx;
>> +	int rc;
>> +
>> +	if (mds->ram_qos_class != CXL_QOS_CLASS_INVALID) {
>> +		ctx.matched = false;
>> +		ctx.dev_qos_class =  mds->ram_qos_class;
>> +		rc = bus_for_each_dev(dev->bus, NULL, &ctx, match_cxlrd_qos_class);
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (ctx.matched)
>> +			return 0;
> Early return doesn't make sense to me given not checked the pmem one yet.

You are right. Will fix.

>> +
>> +		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
>> +	}
>> +
>> +	if (mds->pmem_qos_class != CXL_QOS_CLASS_INVALID) {
>> +		ctx.matched = false;
>> +		ctx.dev_qos_class = mds->pmem_qos_class;
>> +		rc = bus_for_each_dev(dev->bus, NULL, &ctx, match_cxlrd_qos_class);
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (ctx.matched)
>> +			return 0;
>> +
>> +		mds->ram_qos_class = CXL_QOS_CLASS_INVALID;
> 
> pmem_qos_class?

copy/paste error. will fix.

> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int cxl_mem_probe(struct device *dev)
>>  {
>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> @@ -181,6 +245,10 @@ static int cxl_mem_probe(struct device *dev)
>>  			return rc;
>>  	}
>>  
>> +	rc = cxl_qos_class_verify(cxlmd);
>> +	if (rc)
>> +		return rc;
>> +
>>  	/*
>>  	 * The kernel may be operating out of CXL memory on this device,
>>  	 * there is no spec defined way to determine whether this device
>>
>>
> 
