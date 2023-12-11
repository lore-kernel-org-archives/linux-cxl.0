Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIrb9sFw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B13A9
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702318433; x=1733854433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cpcHKHdhjHJmMjKfH5NiXBUOKjsf50mV9ffj2hFo9l8=;
  b=NIrb9sFwHHfC9TiN7bRxGzBRtwqBFReGuD+OGGlJxNhdBI4I0HCU86pd
   5y/sxbCvwos9HSDJNY2M9kvbrCIeUasAHbJd/lWmo92YlA9I4pEyb4w+Q
   cbQ217CWNSNNIzwdEhAMn3G2cOEB2j6NLTUxF0A+oIY3W8yv188iYfKzk
   qvDxp006yAkfgXLjCd93AkDFz+yk/IiTIXpiZd8FmZZNGLf93j6CWlnmN
   i3VuCIYSqvg23s/J3EkSCDx1rxeJZoMfD+UvxChK/xnsNCXjiKHyJU7VR
   GJ+USerwP51JqpR0r6mxEgl/oIVPj9AVNngwngJAhfh0FFNCzubnYWnuL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1505433"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1505433"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:13:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="773186064"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="773186064"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 10:13:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:13:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:13:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 10:13:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 10:13:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci3OiRI2kCqjeeGCbbumXzH2Wg+VGJeKq6LyiC/elOcvfPdb3In7wxC36aEnaNLJpSySHNtTL5BoiMRzwEkRx6I1cKksoZ6M2KLgKTsKd+VkdoXPR1HuBcSTCVPxz/7HagfCIkTzJ4kofVIL9dnEd8VB0+BpbTe1h2mQgCkrVNRBftFjofcoNLTzU+0XGGYosYdyW8UudiW39tUO0Tnct1S6Y3jGUHGrAtibpqkHIOHkGOxGUauHE/1UuuqzIuMiF2khfkafw0PSGbZmaaq2d0QCvTYOFOc8iZ1mJl9Rli38t35Whqs/OGxwjXVExXVm8ECxzcvmAkFDnHCR3W3UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDjkeGvyX/uhSEcFyOWcXsVEFQhRyOMKm+/Gwdy+weE=;
 b=PalIFsLYP93FYOsXZuXVUHruZYVzYhDU80qEHSe7CHVUQqEhfOpraGLA53QvUyDJUwYIl3gqSTHLZXS2TTYBsKJ8TxEEC0DKqIabl3iQxj4u3Re2YKLTh0f/AvMSe4JvqW9o2y7AZolq7pPan2IPo7EMvHxE1Uo9ZLQ1X4DCvAUiHxzsUBSTCayMdkvn7WP6G1nAwsjsa6unRe6e0girdnbG574CDp6kcHrNF1Rs5uaRDQ6X8jbkPi6jYyWIhCuKaDP66is7IuvgoL3LbkeS6462RjS52Gn8uatKS/6YcMHgjad/yfDHlFHYAPCdr/rFQLkxwOa1z5jFgdQQ35d//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:13:46 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 18:13:46 +0000
Message-ID: <567d1abe-906d-4ace-aad7-7fc22f9e97e8@intel.com>
Date: Mon, 11 Dec 2023 11:13:42 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
To: fan <nifan.cxl@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
 <ZXdPBMbWau0dePxv@debian>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZXdPBMbWau0dePxv@debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 97305835-eeac-4113-caa7-08dbfa74eaaa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRJLlDZxKwVc6/xYhAdU7zja/VJ/tRwkKWd1emwGLy3kIOA02Ui+o2MW6MmYhIo0sxAMt8WfFdb4lHeQvkFUmuiVLm6zq2ZeR4FCcXRqV5w2iharYbya7Obxj/E4v9HqwcqvK3PN7pwMX3L6Ai854iWke0qnnflPiqXCr3Vu5s+Q1HZG8fblK1ikEKRfVtytjGIMgGOEn0/V1/sdEi4IkVpSQ0GOkPtYvOKstC3Xoc/VH4P8FXtSgIOlVbCjKSBwCqWDYLlgSmRP4DCyFDN8h29sCeOyH+/fHeTGEXgD9VP9YqidfQ42e718+qQURWEIGG9jy69Ig6klaUohUSJONNedtl58h6Vb/DuXBOwaR5SfFlxo+DIgmWbhJx7Kggu+1k9O7zY0x0opT5n5R8nBQJDQHmoj7YotuNU+r8A3GPnw3eARZfR1kq/Igyl5ag2L80pGOPVWwGMbH2cLjrKLcBM33Trx2Bp/hL1ny/fCubEUdcwajF1NoOACa+94+3eI30TbD6BCBociz3+8Lx7zX7/DORGXBBj8hF8YjWH9InvnaxRIctsT2+ephaXe0CiHP74e5ClsB3wdjDL/wAUaE/dNVhyRmLaMwM1E8ykhHDBYJMjPAJx7WPmz6cQYc0CM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(36756003)(31686004)(53546011)(26005)(6666004)(6506007)(6486002)(478600001)(66476007)(8936002)(4326008)(8676002)(6512007)(66556008)(6916009)(66946007)(316002)(2616005)(2906002)(41300700001)(5660300002)(44832011)(38100700002)(82960400001)(83380400001)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhGTFBZSXBNSUltdkk1WnVSeVFYMHZaZHR0VGpQc0NWaGVaUTdJaTRwZFhj?=
 =?utf-8?B?QUlZQS9Ua296Tkk5TG1zUnYxbG0wVkZ2Q2sxTVZsZmFobDgrS0dsUzAvbm92?=
 =?utf-8?B?cmdRdDQ5L3VRK3h1Nkh1dkcrNFVqNWl6NWEzdWtycm4yR3Y4SXZ6Ly9BeFlV?=
 =?utf-8?B?cGlIcEw4YWVMQ3Fib0FiN2czWTRQcm1wRTZ2dUY1YlJ1VDZMYzRiSXV0OSsx?=
 =?utf-8?B?dTFnd3NxUVFwa2Y0RXNLMlpLK0dJdDZRbnRydDhPbEtGMjdKWmRBUXVlR09V?=
 =?utf-8?B?UHU1aWpXRlhGR3RSVEtlSnA4MHM3d0tyWlVUZmVZYmN0ZStUV3Bmc2paeVZr?=
 =?utf-8?B?eWoyQWg5eUM3SVpsbU1BVThkMnROc0FncFBWQjNjd05ITkFPTjVJeUJUTHBp?=
 =?utf-8?B?UDBaK2ZCMWk4eXpCR1lQS1cwY1lXazFNY0VDTW9kZndWWlF6ZjZPdW05K2Nh?=
 =?utf-8?B?NGZMRDR0bCtWckNPMVhJMjluOTNUdXhQN0VqTlZDRUdhZkZwRjA0M0w2U1hK?=
 =?utf-8?B?R1VxSWhYWUdqckE4VDBNM1dHYk9ZbUwrQ0JmSmIyZU5sSlZGSzMrL3Q5UE9Q?=
 =?utf-8?B?U2RvYU9pWWNwUUsxZjhzV1VHbkFzc0duVzZpak1GWDRpOWVzUEcvY0JCcUdE?=
 =?utf-8?B?UEhqZFNSYUo4bDV1bXNDU2JCNDRDUktvdXB2WDZnOEQ5RzVwTzg4R3k3YzBV?=
 =?utf-8?B?WDlpQ28vZTJVNC9XQVdGbCtzdU1hVnFIYW94REZkWVppWVpsUzJ2R09XcXN4?=
 =?utf-8?B?TmR0My9lb0hmTVYrSmJjeXMySHFFWDVZQ3ZyUmVlRFg5NENld2JPUjlyTC9O?=
 =?utf-8?B?U3Z0SmliVDhDamg2dUxXTlJGRnBidmpBSmZOR2ZjQWpQRlkyUTVmaXd5M0M2?=
 =?utf-8?B?T0tCbGhqb0c4ZFZpMXJCSGFpdGVzZGJKTHNTZFI3b2R4SXl2UmJKa3lOSk96?=
 =?utf-8?B?UzVWTm1kT3lvcUFXbDFHMDU4MmJJUEdQRWhoa204MnNSYUFnWEI4OTczN0tr?=
 =?utf-8?B?M1cwWm8ycVlmRVg4VkNZM0kreVNPM0Y5M3g3Mjlqa2ZaNFZ4TzBJR0ROSlEx?=
 =?utf-8?B?VE1XejVZYXZCRVJ6Q0FSbUFPaVREWTJkQWtDcXhyRldaUGpQVVpSU01zaVlp?=
 =?utf-8?B?UW5oaGUzVFpuTUdnZzlYM1hwRE1nc0F2TVd5ZUp2aHUyZlZZQ2lIM3d3SmJH?=
 =?utf-8?B?UkltZ3o4L1pmQUFTSVdmc2lRcHZGekRRTVdzN29SYnIvQm56QmhKcWJaOHRV?=
 =?utf-8?B?cFdKSFJYUVlTNUFnQVdEZzZ0T0JLQWVNS0JWcXQvSmFERVFTNGJUbXN1Qm56?=
 =?utf-8?B?MVJ1Z1B1Wi9jWkZMWHl6dVRUb0NzZk1JNEo2bTZmZ3BCelg5dTVVMCtUcDZs?=
 =?utf-8?B?dTdQTWZPTW5SL3YybFd3Q3F0MDVLWW1zUTNRTGtVeTdPMjFTVk9rbWUrcUw2?=
 =?utf-8?B?eUVOek5rRG82MStRbTM2Z082Y1hGRGVTdDMwUnVLaVFjMlUrNU1maEhWZ2Vh?=
 =?utf-8?B?ME1yc0tmOUVSelIvaWRvcFVPQ1YxMTRTdmdjSDkxOWlkRTBuWkJ5QlhIZ2FE?=
 =?utf-8?B?SUI0UHdGSloySkpqNG05NktZbko1ZnMxd3NIUTY5bzhLK21YUWRncWIzWFhP?=
 =?utf-8?B?KzdNdFFWckpwVmxFN2R0YXlFby90YXY4NHgvbytNSGtwaXpiRTUxeU5KVUtm?=
 =?utf-8?B?M2hydVpSS1Jza3VQT1A1eU8xWDRad1NGQzY3bi9wMUFVdGx3RWdrRHN0YXM0?=
 =?utf-8?B?UEsrVy9ma2prMEEvUURiWDhsaUtnTWw3SGt1MGYrZEM4RnF5VVJGWW9aWGxv?=
 =?utf-8?B?RkZEMHV6Z05xMHFCem90NDU1ZmRoTTVPYXpVMlY4NjMzOFlBN2FjN21iem5t?=
 =?utf-8?B?VDhNNHU2Z1FrUm9LaGJxSFhVSi91WmF3K21NT3F0ZmdsOHdDczJrZkFSSGxF?=
 =?utf-8?B?UmRsN3dYT3hRaHNNaWJWcWNUMUYwU3U3Q3QrOFdBWVZJNFpDUWJzWmNycm5X?=
 =?utf-8?B?VVp1eHV2OHp1SnFDVXBwdlpGRlJnZ1piVENYS2lkQVRNQUxVSEtFQ3BmbVlm?=
 =?utf-8?B?NnQveXhLYW0yQjBHc1p1MkJtN2REaVBwTTZmUms1OHBlSFZiUDJ2V3JzUURn?=
 =?utf-8?Q?X4+S6IjscaSwtSs8YXHGuBlBv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97305835-eeac-4113-caa7-08dbfa74eaaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:13:46.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ4wxscPSHZu9KpD9/CmVEiPh2lL9ZfVg4GYLU3NEQjqcV387mRtCRz3yPFOOAqeEoqQyyjzcsHZGEAZb/Jvcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com



On 12/11/23 11:03, fan wrote:
> On Thu, Dec 07, 2023 at 04:31:56PM -0700, Dave Jiang wrote:
>> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
>> region. The bandwidth is the aggregated bandwidth of all devices that
>> contributes to the CXL region. The latency is the worst latency of the
>> device amongst all the devices that contributes to the CXL region.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
>>  drivers/cxl/core/region.c               |   24 +++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index fff2581b8033..e96f172eb6a6 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -552,3 +552,43 @@ Description:
>>  		attribute is only visible for devices supporting the
>>  		capability. The retrieved errors are logged as kernel
>>  		events when cxl_poison event tracing is enabled.
>> +
>> +
>> +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
>> +Date:		Apr, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) The aggregated read bandwidth of the region. The number is
>> +		the accumulated read bandwidth of all CXL memory devices that
>> +		contributes to the region.
>> +
>> +
>> +What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
>> +Date:		Apr, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) The aggregated write bandwidth of the region. The number is
>> +		the accumulated write bandwidth of all CXL memory devices that
>> +		contributes to the region.
>> +
>> +
>> +What:		/sys/bus/cxl/devices/regionZ/read_latency
>> +Date:		Apr, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) The read latency of the region. The number is
>> +		the worst read latency of all CXL memory devices that
>> +		contributes to the region.
>> +
>> +
>> +What:		/sys/bus/cxl/devices/regionZ/write_latency
>> +Date:		Apr, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) The write latency of the region. The number is
>> +		the worst write latency of all CXL memory devices that
>> +		contributes to the region.
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d879f5702cf2..72c47f624d63 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -645,6 +645,26 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RW(size);
>>  
>> +#define ACCESS_ATTR(attrib)					\
>> +static ssize_t attrib##_show(struct device *dev,		\
>> +			   struct device_attribute *attr,	\
>> +			   char *buf)				\
>> +{								\
>> +	struct cxl_region *cxlr = to_cxl_region(dev);		\
>> +								\
>> +	if (!cxlr->coord)					\
>> +		return 0;					\
>> +								\
>> +	return sysfs_emit(buf, "%u\n",				\
>> +			  cxlr->coord->attrib);			\
>> +}								\
>> +static DEVICE_ATTR_RO(attrib)
>> +
>> +ACCESS_ATTR(read_bandwidth);
>> +ACCESS_ATTR(read_latency);
>> +ACCESS_ATTR(write_bandwidth);
>> +ACCESS_ATTR(write_latency);
>> +
>>  static struct attribute *cxl_region_attrs[] = {
>>  	&dev_attr_uuid.attr,
>>  	&dev_attr_commit.attr,
>> @@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
>>  	&dev_attr_resource.attr,
>>  	&dev_attr_size.attr,
>>  	&dev_attr_mode.attr,
>> +	&dev_attr_read_bandwidth.attr,
>> +	&dev_attr_write_bandwidth.attr,
>> +	&dev_attr_read_latency.attr,
>> +	&dev_attr_write_latency.attr,
>>  	NULL,
>>  };
>>  
> This way latency and bandwidth ABI are defined seems not to be consistent
> with what we have now.
> 
> For example, for other attributes like interleave_ways, we only define
> one attribute "interleave_ways", and use two separate functions
> interleave_ways_show and interleave_ways_store for read/write operation.
> for ABI interface, only one is provided
> "/sys/bus/cxl/devices/regionZ/interleave_granularity"
> 
> for latency and bandwidth, should we provide two interfaces like below
> instead?
> /sys/bus/cxl/devices/regionZ/bandwidth --rw
> /sys/bus/cxl/devices/regionZ/latency --rw

Hi Fan. I think there's a misunderstanding here. This is not reading and writing of bandwidth and latency. This is read latency and write latency and read bandwidth and write bandwidth. They are separate and unique properties of the path. i.e. upstream and downstream direction traffic performances. 


> 
> Fan
>>
>>
