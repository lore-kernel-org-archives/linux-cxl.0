Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5529D10
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZH+2mR0/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0595291
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697040316; x=1728576316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kFnLL5fQZsmqY4P8B0dPo5qVN7R4NWZOMBgEZGfEtjM=;
  b=ZH+2mR0/A614qlDsn+n2i8Br7+E/G1JnNsuLYR9MhTz6MzK+YnwEfXZM
   QsjNR/+ZzUwoCdbZwLCbRZyRT0JKqRKCtq1xD1AOKdLnZCBuoKPEgzHut
   qu8NIauh5S+/oBybwXLiG8nsgQ+SLw1GLZZpoJVDnE1tuU0F454f+2GZ6
   AGUWTsOyyoDb3nWtvWtiySMuqa6vm7pkeAqymHy0B6z0og8+Drwy9f8B3
   qcW5QTrv4NN2h733PvVrauCX1oFM9uGbWA1G9PNYcZHmiJHhdvU4/NtoD
   q0+yHA5PLwcPkFnhK9B0W2l8PToez+K3tfiEB5URhd3FLmVtHuq9CqZqA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384549906"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="384549906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="789042691"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="789042691"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 09:04:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 09:04:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 09:04:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 09:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlofBiFdEhn88Qu1HxoG4k3U5ZBh89dBVpBMGOX1LL0v1m0PmXsih5iP2AXtRS1UAelIUtuOaOQpHVIUwT7uo/kkQsU4MFQUNxEVot6PJUb/koxFn0IMYlvFzkSypu4F7q6UH5G3Iemms/IFKLy6tm2OECV11M9MeYs5GPWDeZTty26X0HjB9BXKgPCd4x+nmXXi8Oj60XYJtEj+SXX7+nffr/JOFSnyNC/iFH36VZYfmxteAjx/qlFKP5iHD0E/peFCD7EcIaUCdIIMAZvwGv53xJOkO2wp7CvzJ1N5mohOz+3e8V0k4XRPG62X063HPwmA+Kf2KcntYGuOk2t74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0jfwkOV9lww4TkE8ltkxVYj6QGMkxHaRDlF0xgSVZY=;
 b=IGU44sxKxhcPVcs/BiUaeJjWlGq816N31fmbAx8xkQSxwGUG8M1jBkxXqGy1CctveZWBE5uZliu/yln8wQzqyZRYLOJrqaTfem/9exAdwSWLEfvzJAlQmRZvEdiodUwwCfFVJJ7zNCOvbqaqMtEcm7GLjvBzWEOH8Qw+qnAyWEzk0SvR0+0XRzWRLo0pf4PEALb2d0ckzoPllLtl6GldCAvWnMm56PxVogYF4oF9SS3JmsDx1I/Cr8FPYkcWl4mgJwY6oTOO2BIvuUdd/8M6E7NNaSkxFLGgEF5QrnoRiSgXRfR6upgwUr8mN8l//J5SIJot3dD3XCxF+SGRzeg5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV8PR11MB8697.namprd11.prod.outlook.com (2603:10b6:408:1fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 16:04:48 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 16:04:48 +0000
Message-ID: <bb95f77c-fac0-4279-bd4d-dd4fef238ef0@intel.com>
Date: Wed, 11 Oct 2023 09:04:45 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v10 20/22] cxl: Store QTG IDs and related info to the CXL
 memory device context
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
 <169698641993.1991735.8821776839011657844.stgit@djiang5-mobl3>
 <20231011141933.000028fb@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231011141933.000028fb@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV8PR11MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: a175a277-227f-4922-75a5-08dbca73cb61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHM9DJonT7a7L7u9wSfs3iXwGcMZJtdTYxUYUA+zry9YNF1MaYff4LZ6SD5EFHhNwCSAdKhmOl1lTvHH2HtdbIYt49Vu0diYybl6UVTIwZ9ycpA/UOPpl3OE7yIAaemM0oypJkembUy5+OyyhQoQUXYwVVV+r1Sra3K08QUPhbyWoU/+irvgZdvvCBd6nIGtQDb7KE59w/2Rgvy/JONgUzjXbBiAFOx+I3z48rqhx+IRVYmcBSnA9faoXaicZd6VoJ7uOnuaQtJ2RRlOU9+Uvs5l95XQN/x+tz+d5CegSXBbQRxnbWdrFD0J4C2jviwDDIuhvYWUyu64JUfbaoQztkLTDAdxc5DbvUZwMJWoNGrnpBe3x/9rMZbAMg9GP2g+ah7bQOv63mdWYbkvMSpHJp0nZOBvRcCwxO2GZEfQp3ZvQPCfVJd1QAgd9fT3Vtqmi33/ZwrjZs1Kob7/kyhj5kuHpOgZ4HdIwD76AjC3XIEp6l1gSd6+XeyiIKFZuc9v/vCqYIJYL8Bt/jUAMMf3E61lavNkXGL+OIbDFzl1zfeWoLqa3U7Pn00B787Dhp6cR4cAiAmCfAI+4MAEkEkq03s4Q4gotZIjiYplPV6QFAYlCO3TIyNMsG3M9qYoushy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(83380400001)(82960400001)(8676002)(8936002)(4326008)(5660300002)(44832011)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(6512007)(53546011)(2616005)(6506007)(2906002)(6486002)(478600001)(6666004)(36756003)(86362001)(38100700002)(31696002)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdMWlVoT3VCZkFBbjJBQk5xYXJjTEFDaEZDVUlTZmtxQ3dhR3ZadEhNNkIy?=
 =?utf-8?B?VUlzdzFGOTM1Z0owU2RPN25qN0NVRkp3eU4rVlBpRmFySzJxSjNtTG9RNFJp?=
 =?utf-8?B?M09XWXBoQ3Ezei9ORTk4V0Y5NlFzajZCaXlaZjZYNUNuRko3RjdIUVhZczhk?=
 =?utf-8?B?c0hKNk9DTGFCV3QyaUV5Z0hkS2ZvZk9tdFdtdDZrcVFLVDk2N3BmU3loZXZH?=
 =?utf-8?B?YzE0dEhmSXpIUzZPQjc5bW5qcGNYTlNFT0dPdk1wd2NTeTJ0Zmw5NDFGR0c5?=
 =?utf-8?B?WHZGOCtDWmd5SmN6VGhKVVNxV3BhYURSTDlLT1QxV1U0RHd6dENmaU5mWDVT?=
 =?utf-8?B?a2pvc3BMbDdUQkhOQ3UrZ01HcEFwaG1RdEFBYlZ1aVZyYkdqSzgvTXNxaHNh?=
 =?utf-8?B?QWN5R0FXdGpMUHNzc0VaOFFtUDAwQlJ0NXhuTzNuZzNVVUZMbW8wZFJjbGZK?=
 =?utf-8?B?QXdVdW5GQk1TK3pFdDk2K1RVNXpkbk42NnZEZ3MvZDR6WElKVEVXWGdiMGVO?=
 =?utf-8?B?a05aQlQwYWtIaTNQWlc0b2IyaUNuOCs1VTV2MWdoMnloM1A0VDNuMHNyb1M0?=
 =?utf-8?B?RSs4bFU4SkI0NXBhOHoyZ2ErMlhyK3pjUld5dVpRa3NHMjBRMWpNNDRTMzNv?=
 =?utf-8?B?emxFOVVxakVha2tFcGMzV2I1Y2w3S0dVbzY2blMzL3MybTRtN2M4TWZuVWgw?=
 =?utf-8?B?S2NieWp5UXpiZGFwdExsQzJ6RnBDVTdWMU1tbFFKaU9SVlNlVlZ0Snh1Y0Zq?=
 =?utf-8?B?c01nS080R2hGOEs3cDNTTkJYeGFGT0RzUDQ4elpMR3ZlK3FCUllZcCtCSWZo?=
 =?utf-8?B?QVlFZFJhNTZUcGNMRGQrQWZtMFNyWjM2RXBUK1JSRW1zbzE2SjNOVjN4SU5v?=
 =?utf-8?B?N0ZaMEpVUWg1V3p4blY0VWxiL2p6YVBoOGltWGErRGN0Nm9UUnBMYVdrMFBn?=
 =?utf-8?B?R2UwclpwK2ZDNHJSV2loeDIvdFRMc2syK2VSWE1TR0JzY0xjMW9wOFMvMVdi?=
 =?utf-8?B?OFRmRVZaRDhZblUrU0hSSTJ0SnZpa2pYdXNHNU9lR2pwM3pCTW9sN1poR1pQ?=
 =?utf-8?B?b0pyNytYcC9tSTR4clBCWnJodmRwLzJPdlh5MEFKdlo5MkhxbVltdm9HSVNo?=
 =?utf-8?B?am5yMmFkWEp1eWdwT0lGUHFvRnpaR3Y5SVRLUFpJZ1hha0pocStXdW4rZ1cw?=
 =?utf-8?B?T2JVTC8wUzJvLytUV25mMUVTRElxbGU1bzE0K21vV0RnektRczBNT1ZjVlN4?=
 =?utf-8?B?SVpPNTBoTDRZZlIwSGwwZ0REelFkL3VVZW1ZSytiZzMxaU5FUmdkcHJraHBN?=
 =?utf-8?B?ZDZOdXhmcUUwY1RpS05YeGNLTForVnNaUTJaS0thQ0tsT1FkWlFIck9VakxQ?=
 =?utf-8?B?MHloTVc2Q1NpS1BzOE5ReDhpUUJLM3J1Wm9xc1JqZ2NBUUwzZVVyWDhJaU1s?=
 =?utf-8?B?dW1yM2RPMCtUdzI1d0Iyb0lrbjRhc2VkczVNNEpLUEZJb3dOL3FBQ3ROODlv?=
 =?utf-8?B?SC9DSkszQWRxczBUa09wOFpuK3FTSDVucXR0VCtBZEZwTTRxYVlNV3BaVmF1?=
 =?utf-8?B?MGRkT2VOVUdoYzQ0UUdFdHlCQys1bjhBMndjMUtYV0Q5eVNIcm0wczh4eTRM?=
 =?utf-8?B?cmdjTWllcm1XUGw0VVh4MVBRS2ovN1IzVVFWaG1lZkROdkVpMmQzaTc1RnJC?=
 =?utf-8?B?a0F1ZDMrcEo3WXZiL2V3M3pZbFd4QldET3dHcDRpb3FPSFBPaFN1RE9NQ0ZU?=
 =?utf-8?B?QmIyV1ZtR29UOWJBd1NDdWx4eVhLZzFLRjA3T0RuRHNnY01zQTh4VXNvM0FQ?=
 =?utf-8?B?TVpUZU1nSmN6Yi9ZZkUrWjBtQmFYSmFkQzNRRzFYR0p2bWxvdi9rT2ZCaC95?=
 =?utf-8?B?V080cTZtZlUrd0tkTS94ZGJIeDZUaWM0em5vRDQyamlMN2NPekFXcmxnQzBv?=
 =?utf-8?B?Z25TK0RZMDExOUdJZzJoaHhVb21sY0l6T2cvbXU0b3dCQ3ZrZ2JSTDUwS29D?=
 =?utf-8?B?eWZTZXdqQnN0WVUyY1ZOWUxhY2grVkMxZ1BtQ2RrSzg2eFJhN2xvbFRuR1R3?=
 =?utf-8?B?cHRlVmdqVzVJdHVrMTRHVUk5bUVaQlcvdU9OdXhjZ1d2WkRuUkhKU3dVSThW?=
 =?utf-8?Q?cBD4oep1wXXFiCSQm61/qWbSX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a175a277-227f-4922-75a5-08dbca73cb61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:04:48.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxOGCXqsxtbQ/9pwFbpyETj83KxdW12BEuBmWovlb+dsFla9U8LrHPulHjFo5iRI9fbxErocN6DATqzwVmakPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 06:19, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 18:06:59 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
>> the return package. Create a list of entries in the cxl_memdev context and
>> store the QTG ID as qos_class token and the associated DPA range. This
>> information can be exposed to user space via sysfs in order to help region
>> setup for hot-plugged CXL memory devices.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v10:
>> - Store single qos_class value. (Dan)
> 
> I'm fine with doing this, but I'd like a print if more than one is
> provided by the DSMAS (e.g. multiple DSMAS entries for a given region)
> Mostly so we have something to let us know if anyone is shipping such a
> device.
> 
> Otherwise a couple of minor comments inline.
> 
> Jonathan
> 
> 
>> - Rename cxl_memdev_set_qtg() to cxl_memdev_set_qos_class()
>> - Removed Jonathan's review tag due to code changes.
> 
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 99a619360bc5..049a16b7eb1f 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -105,6 +105,40 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  	return 0;
>>  }
>>  
>> +static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>> +				     struct list_head *dsmas_list)
>> +{
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct range pmem_range = {
>> +		.start = cxlds->pmem_res.start,
>> +		.end = cxlds->pmem_res.end,
>> +	};
>> +	struct range ram_range = {
>> +		.start = cxlds->ram_res.start,
>> +		.end = cxlds->ram_res.end,
>> +	};
>> +	struct perf_prop_entry *perf;
>> +	struct dsmas_entry *dent;
>> +
>> +	list_for_each_entry(dent, dsmas_list, list) {
>> +		perf = devm_kzalloc(cxlds->dev, sizeof(*perf), GFP_KERNEL);
>> +		if (!perf)
>> +			return;
>> +
>> +		perf->dpa_range = dent->dpa_range;
>> +		perf->coord = dent->coord;
>> +		perf->qos_class = dent->qos_class;
>> +		list_add_tail(&perf->list, &mds->perf_list);
>> +
>> +		if (resource_size(&cxlds->ram_res) &&
>> +		    range_contains(&ram_range, &dent->dpa_range))
>> +			mds->ram_qos_class = perf->qos_class;
> 
> So this assumes one DSMAS per memory type.
> Not an unreasonable starting place, but I think this should 
> print something to the log if it does see more that one.

I'll add that. Also I seem to have dropped the check from before for multiple entries so we aren't clobbering the previous set value.

> 
>> +		else if (resource_size(&cxlds->pmem_res) &&
>> +			 range_contains(&pmem_range, &dent->dpa_range))
>> +			mds->pmem_qos_class = perf->qos_class;
>> +	}
>> +}
>> +
>>  static int cxl_switch_port_probe(struct cxl_port *port)
>>  {
>>  	struct cxl_hdm *cxlhdm;
>> @@ -201,6 +235,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  			if (rc)
>>  				dev_dbg(&port->dev,
>>  					"Failed to do perf coord calculations.\n");
>> +			else
>> +				cxl_memdev_set_qos_class(cxlds, &dsmas_list);
> 
> This is getting a bit deeply nested.  Perhaps a follow up patch to factor
> it out makes sense so we can use a goto to cleanup the dmsmas_list without
> that label being nested as well.

I'll just fix it in place. It doesn't look too bad.

> 
>>  		}
>>  
>>  		cxl_cdat_dsmas_list_destroy(&dsmas_list);
>>
>>
> 
