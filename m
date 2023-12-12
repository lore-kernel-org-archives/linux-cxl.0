Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNQ/nXbQ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845EADC
	for <linux-cxl@vger.kernel.org>; Tue, 12 Dec 2023 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702409457; x=1733945457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8vXmQ5vdKpAG62sUz1mxbeNRAf4X3l2PB9HnHPd4Qno=;
  b=CNQ/nXbQb1LK/fv3dYt8l5d04Ayc7hFLmJyKUkFNsAccCjBF12J2Dq0R
   y19ytr2udzsWxGLOorZThVU7kpUgf2tINhOL4Em6VZWnEV36eee9Juz2Y
   G0afWzkHfptNubuw7uQfyrsXxsx+b0CKuv353Xuz1B+Ho0atn8sfB78gk
   MPmxApUvmOc0kyG5KzcijytzBfJo1QCvH+n/jiAShplnf0sYvib/R97bB
   QoOAJMqmPWjXS8SiAA1CE0JWxcvLj+CKZ51RH3EEYp6uijvCzszVxpCgo
   Wu40Ttliys7VB0YwuGw/de7I5VGwbtdcdUfQWZtrgPd7wiVeMsDLPqG0G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="385270697"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="385270697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="15133904"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 11:30:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 11:30:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 11:30:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 11:30:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W15NsB+2VkyxU60cVfd8VimQYJ6o4657tER7bvk8CQhlQuSjy1z+QDr4xyyokFM57OTGlLmJWw+mFB3eI09T2ozXF8LfSO+0uynj4ToqKs5KyyohWAes2RZ6SNt/pe15bcK9DGhmLPt7qVNRSOAi3SlhAKKjiV+rBGU7JONAmMv9e/8fBNOnG6aY+wpWYyjGWA6WPJY3CtC7Gqw9LJoSDmElisKFjjMUcV/9LgaikBoBpIXsAnix7qI09akifjYW6Wd6bBpYz0n3xbiLIChcnpUmsErHA5hoZ6taqh0Mv1TcDgONaedHC/O62d9HV1AF70qcXRHGKCQ6Y6zaDoqBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVQZssqGgJOOwJYKCUMu8421nsueeieQytUlKb0kEss=;
 b=caq+MM6p44LcfjtjtkPz8Jo/Phau+Eha5SCYl2p2csE95eAP/nYINMZbZp33RwOxR338DIBOmLNT2k5vs60E8SsO9AKqehbzZmJ3u57sgwkvPyQIidVZ9sy2m0LDU1y46DDIuhCJGVf5plPapdqtcnP9CyJpVxdUeGrLklcq3b+85zHb5RyOMt3dDSEOxdik2v7+vg4LopobGB4OinxLYggPlRlvTigMmFxb0WRhyQ/+qs2JRJeZA6GD692rjpbaubysaLT76/GHQIAdDokepMPz+zXMEBLuDRzaY+0zKsGetlaq0g9z2JyKkP0DQESw1yjalWjyn4SGc/4n3C5vIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 19:30:50 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 19:30:50 +0000
Message-ID: <500b0900-f4bb-475d-817b-6a72f18e0134@intel.com>
Date: Tue, 12 Dec 2023 12:30:47 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
To: Brice Goglin <brice.goglin@gmail.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
 <23a78aa8-e076-4b98-bd7c-4299aefd9895@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <23a78aa8-e076-4b98-bd7c-4299aefd9895@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: b5089463-aaaf-4d63-ccf4-08dbfb48d909
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5EbNg62hjalahmO79wawGm67vRj+Nv5OZZ0tPwdDHbv7cVail2zh6R11nJK4mmt9fXnMP7JPozLWoftG2J8+VuOD/ywy/8ajCp8IlaX5aYtJ62kag2tsNrM9i7EOslvNpXaMnUc8PIHru7jJxwtRjBB2ix/zE03E/hlKcSGEjQmYzj9jp34qLAVS1JviOMWAlpTm4WuA1K375ckD1YagPoM3xsI9cVSM5DU9PLjQypjNuSnDzV/PnXlXVBZh9UAKdOST43HLcmKSRgr2uk1rkR0gvmd9adfafBjqbrbpE3qab6zGMG1uTcW2E6gj0VohHZjcfPpFb5P/eczMtxKhXdPsvhZ1cj3Y3aLzx6VVWJN3ycyQKJ7+CbqHz/G53TNGXB90z3B+IV5FMeJHJfuGSNEIWpzYV4wqh/2pCY6aThf/utSnWcXNMQWwwFnreMcU/PNRzjkJ+GCAHV3HigWXrX/ggPZ62VsPqtGmlooGRxu+7lR8YB7J5e79fDoR6De74qLE9RtK4oBSdXTdKwKX95ynKY0g9Cb15TucgyzUU018uz/aiZiPd2uBT2gSRoFOIf0cw827ZZB2L4ACFJ0tOs8+cGkNZJONZpEpGdMzk6vuS+hYQ2+50EFZC0antDcU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(66574015)(82960400001)(66476007)(66556008)(66946007)(86362001)(36756003)(31696002)(83380400001)(26005)(6512007)(53546011)(2616005)(6506007)(6486002)(316002)(2906002)(6666004)(478600001)(5660300002)(4326008)(8936002)(8676002)(44832011)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRsZTJ2Qnh4UDFWWC9JREVBaXNSOEpQVUd6cGNOeEN5dUwrT1BVK1RXNlhP?=
 =?utf-8?B?Mzh4alIyTHFuUm9tQUQ3VEFPTnVCa0haQkVIWWZNV1JySUhXY0FVZVpXbnor?=
 =?utf-8?B?K1hIZHA5ZDdRcC82dDhnWVR2ckpLWlI5dmxZMDllLzByVmRxN0lPRkVoQU1U?=
 =?utf-8?B?ZzVJcXRwUVEvRkQzWjdTZ014aFF5bGUrbU5GTW5RZ1FNS0NQRTNyTEhvcnha?=
 =?utf-8?B?cVVOUWNpSlFUNkxlK05udUF2UnNOWlVPWEdWR0hxWlIxbjZnYzU5K3Zlcko2?=
 =?utf-8?B?dnZMc2RmNytPY1BPMSs5eTFLZ2JIcEtUbzllRFExYjlNVnhONU45bTJIZWpS?=
 =?utf-8?B?UzQrRlFoOGVpcE9TVG9BZnlreVRTd1pDUDJZNWtkdWlEVDBCN1hWTTI1ZkNW?=
 =?utf-8?B?cWlyZWNTQWs5TG0xc1hCT1NtVnNaei9BZ1BVVHlUMnVDRDhnVXAyOFl3MmV1?=
 =?utf-8?B?TThDV0FxeW5ha3M0bllqRVhoVG5Cd0xZY3VoYndMUzQvaUk2eCtOcW51UDRt?=
 =?utf-8?B?ZEErWkwrUzV2dVNDNTZwQmQ1QmRLeUEzOGYrakwzS1JqQXNLOXlKbW9BK0Vr?=
 =?utf-8?B?SmhGNkovOW1PdTN0akFtVGoyK3orU0tldFJ6ejFBcXVWbFdBaXhQTTkzM3NN?=
 =?utf-8?B?QWVYZllIUjVFa05lNnFpMENQbHhWL0QvM2Nyc2VyTmhSVVZVVlJWZDhFZ1dl?=
 =?utf-8?B?NHpjZWhEbEFwaFdsK2V5ZklsTE9Bc3ZDUHcvQm14T2ZDSlBML0hvend1bW15?=
 =?utf-8?B?cndRODRKdjQ2TlU3Qk5yRTh5NGxqSHQvL2JrN21HYkl3RTlSMUVUK2tNTHJT?=
 =?utf-8?B?d3IzTnJGNjJvZlNzMmVPa0lsQzRXRDJNWWxkQVhsTmVRMGFocGdMckt3SHBP?=
 =?utf-8?B?ZXg1alk5cUVaZHhHWU1SbzQzbVczMTFJWHhldG5CSlIzOVUwMjVOSm9IcWtT?=
 =?utf-8?B?amVPT29rYVNRVjJVQ3hMaVVobTdmWCs5cVYvVU9tWFVORmVETDlic2xrZWZ0?=
 =?utf-8?B?T3hIV3RnVVZXRytFMWFTL2ZVVk5RTFRrMkxseVR5SkhPSWR0RkpaRjh0dE0z?=
 =?utf-8?B?Ty9xWURhalZmRzlxazFzNmI0SzVNYUxNNzRVeUFxcngwazZuU2VOanNjTGF4?=
 =?utf-8?B?aXFvT2VWQzZLWnczSnliOFFOS3dFSGhjaHNWSXpxcjd1R29BU2w4YjRBTzM5?=
 =?utf-8?B?L1JORDNoeGQ5WTNNUVRISkVQZE1QbmJpOTZaeHdzK0NCa0xOL2ZSVUZPaENk?=
 =?utf-8?B?anl3ZHNaMUVNQXp0SGhSNVNlWHB5QjJCUHdtcUpjTE8zb0gwWjQycm5NaWpO?=
 =?utf-8?B?clhuUy9MekdCQUNnYzhVeU9SUU5DY3JIWERDL0lWKzNGSWpwczRnK2QwQ3Fp?=
 =?utf-8?B?TU9wRFJxMkRJZGxHdVpKd1BtSUl5QUdDR2tVMTQrb21VUURNQVFJcDZDNXJK?=
 =?utf-8?B?cTBjNi9OSFAwbUZ1ZU1KK1JVRFFQRU1jclFmV0VURS92SmMra1E1dGN6ZVJE?=
 =?utf-8?B?ZVIwWFJZb216TXd0YStUbDhhR3RpRE44YmxoZWpWcnFhQU5odkxNV0kzOFho?=
 =?utf-8?B?eFhWMGtuR09pOWJneitkai9TZno1MnhSWjFLQldvWlRqWWNBRVN3dDRWY1VG?=
 =?utf-8?B?TW1EYWNCRDhrMjRBQ3pjWG4xNnFpUjJPTnFBRFpvZnA0c0FwVU56OEtQdFhm?=
 =?utf-8?B?dkdpYWdTeDd1M0FJRnZydHV1QzZXVVBIbng2V2dGQ1ByZFQvWDFlQUp5TUto?=
 =?utf-8?B?NlV4R2JHRzFZRW9ia3QyR2dXZytYY1hVWEh0TWRHcyt6RnJmMU9nTzBHRjhH?=
 =?utf-8?B?NndFV1hFZVd3UmlIK3lNMTFWMFZPUXFjc2pIbEwvc3JQOTArazhDY1hXZHov?=
 =?utf-8?B?eS9EbXVpMitBejQreUgvU0VZcHZ5T2s3TmtpTnMzbE9rV1IwVzhhbUhNd1BM?=
 =?utf-8?B?WGNMcjhiek5vb2huYlVBTVUzVzBERDFTbTN1L3VkM1BEOUtlWUZmanNZbUF1?=
 =?utf-8?B?K0lqWkJLRUE1ZGsvVHptYlBnc0tMN205Qi9teSt4K3VHTXFXOE9NdFY4eE83?=
 =?utf-8?B?ZEJmY256SWZYMHZYZWRpZHJYZWJkbVQrMmZzcyttNisvamZ0TWRzS0xSRXky?=
 =?utf-8?Q?ygOaNupnPZuf8MrYE1czMlKUF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5089463-aaaf-4d63-ccf4-08dbfb48d909
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:30:50.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQkw1yzW9xxpUP5VSmhMDeMpzuCZCDq1zeVVeEw/BJ9suB1aMn29WJ9WUHlOi3NepNuIYdQSPxuk/jrK6CL+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com



On 12/11/23 02:06, Brice Goglin wrote:
> Le 08/12/2023 à 00:31, Dave Jiang a écrit :
>> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
>> region. The bandwidth is the aggregated bandwidth of all devices that
>> contributes to the CXL region. The latency is the worst latency of the
>> device amongst all the devices that contributes to the CXL region.
> 
> 
> Hello
> 
> Which initiator do these bandwidths/latencies refer to? Local CPUs near the root port? This should be specified in the doc.

Currently I'm only storing the numbers from initiator pxm 0 to these targets in the hmat target list. I'm open to suggestions as to if a different way would be better.

> 
> Brice
> 
> 
> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
>>   drivers/cxl/core/region.c               |   24 +++++++++++++++++++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index fff2581b8033..e96f172eb6a6 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -552,3 +552,43 @@ Description:
>>           attribute is only visible for devices supporting the
>>           capability. The retrieved errors are logged as kernel
>>           events when cxl_poison event tracing is enabled.
>> +
>> +
>> +What:        /sys/bus/cxl/devices/regionZ/read_bandwidth
>> +Date:        Apr, 2023
>> +KernelVersion:    v6.8
>> +Contact:    linux-cxl@vger.kernel.org
>> +Description:
>> +        (RO) The aggregated read bandwidth of the region. The number is
>> +        the accumulated read bandwidth of all CXL memory devices that
>> +        contributes to the region.
>> +
>> +
>> +What:        /sys/bus/cxl/devices/regionZ/write_bandwidth
>> +Date:        Apr, 2023
>> +KernelVersion:    v6.8
>> +Contact:    linux-cxl@vger.kernel.org
>> +Description:
>> +        (RO) The aggregated write bandwidth of the region. The number is
>> +        the accumulated write bandwidth of all CXL memory devices that
>> +        contributes to the region.
>> +
>> +
>> +What:        /sys/bus/cxl/devices/regionZ/read_latency
>> +Date:        Apr, 2023
>> +KernelVersion:    v6.8
>> +Contact:    linux-cxl@vger.kernel.org
>> +Description:
>> +        (RO) The read latency of the region. The number is
>> +        the worst read latency of all CXL memory devices that
>> +        contributes to the region.
>> +
>> +
>> +What:        /sys/bus/cxl/devices/regionZ/write_latency
>> +Date:        Apr, 2023
>> +KernelVersion:    v6.8
>> +Contact:    linux-cxl@vger.kernel.org
>> +Description:
>> +        (RO) The write latency of the region. The number is
>> +        the worst write latency of all CXL memory devices that
>> +        contributes to the region.
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
>> +static DEVICE_ATTR_RO(attrib)
>> +
>> +ACCESS_ATTR(read_bandwidth);
>> +ACCESS_ATTR(read_latency);
>> +ACCESS_ATTR(write_bandwidth);
>> +ACCESS_ATTR(write_latency);
>> +
>>   static struct attribute *cxl_region_attrs[] = {
>>       &dev_attr_uuid.attr,
>>       &dev_attr_commit.attr,
>> @@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
>>       &dev_attr_resource.attr,
>>       &dev_attr_size.attr,
>>       &dev_attr_mode.attr,
>> +    &dev_attr_read_bandwidth.attr,
>> +    &dev_attr_write_bandwidth.attr,
>> +    &dev_attr_read_latency.attr,
>> +    &dev_attr_write_latency.attr,
>>       NULL,
>>   };
>>  
>>
>>
