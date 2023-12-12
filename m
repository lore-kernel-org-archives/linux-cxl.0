Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxTaC4kN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4F8E
	for <linux-cxl@vger.kernel.org>; Tue, 12 Dec 2023 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702396878; x=1733932878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cDc/O+52ka24wGbVcS3Vo7vwoAJmiJk/GtKTBv2whdw=;
  b=CxTaC4kNNKlEjlyMI12mpYQtOJGFl8hWahvr1211jyNo3+rsI+/rPM37
   xW0ziFVr85cqATP0IX/p6kN3nt9LUZ8alvmaarWH6nWS3qEvwSVGKLSOP
   DErSnrsUlo2lI6CyK5GT9LLj8bpSqba4hvSVPRTqMThpnOtAUcPhLj1TE
   bldExhTpguNtNJbH8jgsuZpLUGeLBTXrOAiLQTUuyfGatSPkbZDEwCTX4
   buO1GTc7PdOgCTy895txGRYz4FWvA9hIJn6iu//9/tijPkZVDl+1EuAxN
   bCis4xSNAaug+XqZD8Kkqo8XzY1wOfrelA5X5tvcNaJKjnwicFlylVp1o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1664343"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1664343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 08:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807813859"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="807813859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 08:01:01 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 08:01:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 08:01:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 08:01:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 08:01:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjAii592xIBA3CCTWgTGse9B4xNZLfVoaTmU0oF7OdjJCKEtKDT1dxKsmjmQhmNxYNaWNI1puQ7AOCmdXfIN13WgAb7zjd6/iEKWMYchvF6fSPFp8GX1NQdLSi7KCOYNPZkmJs8NNZy50GKQQlvtwA7h4Obxx13QD6h2N5Y6a5bS+2o+SvcnUNAbsBk+q9asrXi54xcv8B9bjZb5owdLJWnec2I6+zjd4GJ/B7c5zrkdpNE4V7CxvyUgF2lL4nrz7WmDVnEa85godUwEQWuq48YnpaZU8HYMhoL2Qx/8czV/SX1f8zf74b2FUNJsdjG92xvVNKd4Vt3gMun0TyDhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuUgjJB7HrXDAUYU5EfYgkEnOKQtqykIEKsZ0rL1reQ=;
 b=PqUKui6WdVPExQ7eI1VVGCbwYiXhzeCZZde/Ruja77IvkElHTMBOa6J0AHn4eFMG/ZpuaJgR7QMZgcS7u8RsGMVfiQUXbmYTawgbrFd/D4jIktieh/q08CDldw5FnaOL2oGFV4hLmDd1Y7gG1OvVa8KIlh/H+dEDI69Z+ELB4OGMns5fmD9bK7kUe0hI1xZ9ZivsJFTb7zQg01orcuHxSRe5eFs8TFqVA1LpoVlzDUpt9NMwMcltV+PmtXT13hO1mfJbuQ5j/AbT8eYx9fEMn5jdb85YNxf5OexRZXoMELhrY2s0iJA57VhUyL/SRDFrR+EiRrxqmtdB2bt6TiJzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB4866.namprd11.prod.outlook.com (2603:10b6:303:91::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 16:00:58 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 16:00:58 +0000
Message-ID: <5197621d-7ac4-4ed8-a4b2-81136b531fa7@intel.com>
Date: Tue, 12 Dec 2023 09:00:54 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
To: Brice Goglin <brice.goglin@gmail.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
 <d7d17fd4-9587-4786-af58-a68d1ebe074f@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d7d17fd4-9587-4786-af58-a68d1ebe074f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2bc799-36f4-4bcc-c32c-08dbfb2b8708
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lJwfwXPdqxdNyl+4/V9f+QH+DtyLqBpQUaLpyAlE2QlvcLz2/yQfWupkqUb3T7M15FdOSldigtCybypyP25nHLvlBz99gtdtTShPlJbceguMxbY6XzziFKv8NQ4hP0fyjGys1x20ga1Wq/eGkRLfo60JPSQBle7vEk/jMlxAwEWmymXirMaYRs6fAov8sVVMmXZXSBvxkJkbzB/sQYemBED2E4zYnHjx51+I1avbTLOFFoyI1e1KL+XuxzXhh2Nij43LwCwlYSvRGMDKIyNZzpN0ntX+2gIsq5KyJiXXPbIOlvkAet2HKHGL5bkqm/ZMxsQJf2D0J5v147WoGW75bVEDrS0Bb0Vz//mVl5V/zj7vJ9M+roOEWICCb3oxXxEMD+LsGTyXk6IVoFVVxOwzuME9bLQD82TgRZYzz8p2fZcpPSg4/njqd3/Wu8YlPYegnV93/4kx7lfsV2MJqWXILaTShs2ts9HcWFYMehUmVVJN3sOERR9J0QH2Og+s0QhoTUzq1qVq/xRMaIaIHY5SUsLzg4l2a8HD2wERNY5f0HGJEH95wh7rWmFPJD1zpsms+LRdu39a3tNc7vgCkV1Z9DUE80rVAQiNG/fgrOuP3Z+3RXtH6qPN1+PNcjqIScN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(8676002)(4326008)(2906002)(31686004)(44832011)(316002)(5660300002)(66476007)(66556008)(66946007)(478600001)(6486002)(26005)(36756003)(66574015)(6506007)(6666004)(6512007)(41300700001)(53546011)(2616005)(82960400001)(83380400001)(86362001)(31696002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnYvcnlWWTV5UjM2OTBaZmIyY0JDSFRGRjNyREpoVVB4cnoyakdhdU5teS9Z?=
 =?utf-8?B?YS9aVUIvZXRrYm9zejFRejMxclNIeXF5WWJjVW4yUjAxOEZqYTNyOEhST1Fk?=
 =?utf-8?B?aWtvc0l6bXB3UG5BSTlSemwyWStyVFVmLzM2cHNvZlJJYmZWejVxdm94SWRx?=
 =?utf-8?B?OSs4OUVmSVdUNEZXcWE5eXdYQy9sTStEWDcwTG9idnE1d0RzUEhYS3psRXVC?=
 =?utf-8?B?THBDdTdEenRZQVRnUUtzQU5sWDBwM3lML240RVJoaWZmSnZNZ3haRllFUERC?=
 =?utf-8?B?a2lxcXUvUkN6VDAvYVV6bXBDWnRqQ3hab212N2VLS2c3eERJaHhaMUJ0QVlH?=
 =?utf-8?B?YW1SOFh6bjBtT0dIK3dmSERJdEFSUm9ySWg0cWZkTzZvUHFBOXI1d2VjQXRo?=
 =?utf-8?B?TitOTkNwaERjU0tzL0duT0x2Vy9zOWtNdmFiRTY3N1pMMUJIeE9JMkUxTTVK?=
 =?utf-8?B?YWlXS0NrMXgvbUloR1N2TUFqejBUN0R5akZCRFFkblFaSDJ3alVZbEVBRGhn?=
 =?utf-8?B?bnNPeVlVVER3SUlVWGdEVDRMNlJPdlJOWVdSSVJxSjdFMU1EQXFySEREcmdC?=
 =?utf-8?B?OTdHbDkybU00TFV3eDE3VFhid0xiMzFVOTZVNi93YU13elFLL2l4YlFXU2dq?=
 =?utf-8?B?bG1jZklNQWdUTUU2MzlUb293UXBLbk40YTNBTHRZYlFaNmNBSWlEMmQrZzVB?=
 =?utf-8?B?UTBCM3RwcFB2NGxNS2V3dllyOWRwakJ3bTFlVUF4b3JmbGlPN1ZtQlFzWU1h?=
 =?utf-8?B?ZDRycnQ2b1ZCOUQvWkZ0NzhmTjZLRFhKWHBCZksxclFtL1JXanVXVTMzY1BX?=
 =?utf-8?B?eXpqdkFCSWVlOGhuaHhPRk1CNXJVK1E1M2tFYTdpMWRjeGRJV210NFFoQWtq?=
 =?utf-8?B?RWNBeGpnQk9WNmxJbUVZYS93MVRJK1JyaFhtMXc0Q1NZa1ZYSVBuWHBHQklP?=
 =?utf-8?B?QUpXWUZIbzRFRHQ1aEVzbTVvN1N1anRTaWRPNDlTSVZyNFlGOXQybnJGQ2dF?=
 =?utf-8?B?d1hxckZJS05IN29ML2pZTElzaXVCYnJzTVFuMXlJVCtLSjRLL1ArVHQxaHlP?=
 =?utf-8?B?VGJ3ZStmYmtITFhrcDJMSHNISlZRWmxCRURmejBsb0dndW51eDBHOTBxaER5?=
 =?utf-8?B?NWFTYS9CeHpOOEtUWDNXR0xWcWl0b3VrdElqR0pOcWVJcVlWNnBuWWp0VEcx?=
 =?utf-8?B?RzJwSTFOODlxR2pIbmhWNG9BTk5QMVd2akxJZGNYdkdXaHh3c0o2MHpJWmRG?=
 =?utf-8?B?Z3FDQVRTaDlIUjdIWEJxWExSK04vS3l0ZVF4WEVVTnRaOVRMMUt1RW5tTC9I?=
 =?utf-8?B?Vjh6L3lPUzM3dkRiK0EyZGVlV2FWZ2xCTFUvQUdSNlVQZjg0bFlWRWRleTBC?=
 =?utf-8?B?b2h1QVRDa0VZaVBqUzVCMENaT0dSUWgwRVQ5bUFZaE5kcnA3cmlCaVUycTYy?=
 =?utf-8?B?cXhUQzMrV2tQcU9VZ0Z1ejdoMGJ6bWR1aHZRMW9rV29GOWVaSXc3bXN1MWQy?=
 =?utf-8?B?cUdYc1RSSVc0MDg4ZUdqSTZjT0tuVzhKMWxYRHR0anpYcWFpYTBKbFVsU1Rw?=
 =?utf-8?B?dE9oSnZ0QmJKZmhJejdKQ3AvMFRLdDNmRjdaQU80c01GV0IxM29zZnhmODJ1?=
 =?utf-8?B?U1c5Z2h4ZmhQYUFXSUE5b01XTGlDSUtTaHZmeTM3T1V1aW12VTFCZ2YzOXVp?=
 =?utf-8?B?WDJWVHpUeVBPTlZMRVd5T2FSWnk5RExGNnZxQzdkT0F1L244UzBEQ2xBVnVw?=
 =?utf-8?B?dnRad24vQktVNW85Z05rMFBpdDJ4cjE5S2k3L0VyNjAra0gzR1l5UmZTODND?=
 =?utf-8?B?cFVRMytVNFBMbGs4eWc4OTBXYVJBWUdVOHplc3h5My9LR2d2bWpRd3pGT2xo?=
 =?utf-8?B?alN1K3htZDRyUWp1bDAvWi9GRW85LzB3cEw3ZENXQTZOMUtJR3dCaVRGazVN?=
 =?utf-8?B?VzFTblIrVGlFUmxmbVFxMWJYRVdYQ24vbUtzYXcxVVoxakp3MmVVTW56dllr?=
 =?utf-8?B?R2F0d1pabkdtdGk5dmdJckV4YWh2Zy93NmY0UGxucWd6MGErQWdrVFMxWnUw?=
 =?utf-8?B?RXp1YWhVbVZUSEw1U1FYV0VUTG84akc4K29hL2I5R05ic0owdlRmNTVySmM2?=
 =?utf-8?Q?2xmBqyq+MiZtYbRbR5kUtQjLa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2bc799-36f4-4bcc-c32c-08dbfb2b8708
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:00:57.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7WApoe+DSc0e4TIqxWUHtXCnsTvhVNHkeq0MIpmNIKpJAUxrF3qKdKiNDXJ6klaL7LbxkH9XVWpx5xItf1XZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4866
X-OriginatorOrg: intel.com



On 12/12/23 06:46, Brice Goglin wrote:
> Le 08/12/2023 à 00:31, Dave Jiang a écrit :
> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d879f5702cf2..72c47f624d63 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -645,6 +645,26 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RW(size);
>>   +#define ACCESS_ATTR(attrib)                    \
>> +static ssize_t attrib##_show(struct device *dev,        \
>> +               struct device_attribute *attr,    \
>> +               char *buf)                \
>> +{                                \
>> +    struct cxl_region *cxlr = to_cxl_region(dev);        \
>> +                                \
>> +    if (!cxlr->coord)                    \
>> +        return 0;                    \
>> +                                \
>> +    return sysfs_emit(buf, "%u\n",                \
>> +              cxlr->coord->attrib);            \
>> +}                                \
> 
> Hello
> 
> Latencies ares off by a factor of 1000 here (I see 586/686 for r/w attributes
> for NUMA nodes in Qemu but 1000x higher for region attributes). For NUMA node attributes,
> you're dividing latencies by a factor a 1000 in cxl_region_perf_attrs_callback():
>  
>         /* Adjust latencies from psec to nsec to be consistent with HMAT targets */
>         coord = *cxlr->coord;
>         coord.read_latency = DIV_ROUND_UP(coord.read_latency, 1000);
>         coord.write_latency = DIV_ROUND_UP(coord.write_latency, 1000);
> 
> For region attributes, I think you're missing the same?

Yes.... I was keeping the original computed raw data in picosecond base. Maybe I should just convert it to nanoseconds here since that's what Linux uses to begin with just to be consistent everywhere. 
> 
> Brice
> 
