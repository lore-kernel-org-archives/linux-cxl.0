Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFC1C680
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cONy8bxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704302565; x=1735838565;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AdqQ5F5B35mAiRwaZzpxVebGxcDJXkbwAmPuHE1L2GI=;
  b=cONy8bxJQtFXS5kCvD+Xf7EOevM9r8NY6D8T+qf8uNKgrHNG9IhkRI40
   7JK3EYW8AfAu74DjXx+/ri4+YB/LoGPQbxl1eotA7IpAjW4WmULNTptlg
   tCo3RLCSxGTpjW1mJT9vhdCcBJi8NYiWGUMYShDvE8MnFBlVVRe4K9ydP
   SbFEljH0POtaFXmuWIhSnEDTfG4SYvsx20tYJ+GJUeGQ7DbdRXJTkiJiX
   wtVjjQwmg633RVhk+JMHYxNjF0iUS875vMhwgNKUwevCUhXzEACroQCzT
   G5idb31VtQRe9PiuNbbPP71DGwpgM+t4lzzCWXnytFKC9AFmc29nm+vGa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4385614"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="4385614"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="21836530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 09:22:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 09:22:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 09:22:43 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 09:22:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdydu4ZCOHfHpNT2ti4AabFV38wcG7Beqd4ZKAOvNPBCs9lQhATNbwS2ht5umGmJVXVeTxplumO2PIBJPVEw6CXTFeMFCuetpRctJEwUFxO3PCw+1xNDPN2NJp6plr3JNU8XgEbtD/Q5drDjPVGT2dNe+QlUaZdkQJXSR0kRankDBJNN92sTQsa9D4DMz+A9H/XD3MVa9P4Wrftn9rtrEEjtNs2b+4deBltJQYJEBNuzVU/8cLhMh3J2BYnjHhVE3I+civXrA9+Y4AUYGaWiENo2+xBsvU2ckujyiEV7eq16/xk6IaUIG1l6OiglY4V42UjOvJ9UvM/PAWB3uN3rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAXCxIusq6Y9c3Ozs/I5HKBz48iKVpiXET3CsitfjT4=;
 b=XQEVbWyiOEq5wgjbrv7Uz+xuQU+1WsVZcRzh5WVPSAWPkynVtL5vGVSFAFaugeLwAXLYamTHzoMaB3K2k5qJ3isX6B2xvx0j6gbYr2N46MJ3Wdlo98iQVyglO0U8ObIkV4cyRdKCJrbam8kRXSWW1waWtD7g32zCXr5NWQFofaeDDyZKLy8s0OMj03Z9Q5WSfEf/eJFTX7ZsewQiMq99eIJDIcoN9Sg4oFEWtKOOzBY6ZOpbES2PVIuuqohDJZdzzgoteIEwbz0mrFGoBYoejD862qOkHt6HUN/VMqqq8poCP04G984anVP6nnewZM3aNdBZ+Z+rxqeGVRiutTbM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 17:22:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 17:22:40 +0000
Date: Wed, 3 Jan 2024 09:22:36 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <ave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Message-ID: <659597dc1fb49_16f746294a1@iweiny-mobl.notmuch>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b9b2d8-a1b8-48d2-42cd-08dc0c809676
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KMS08+sP0SXE1Ygg9UhdRu/PgOhSPgLdcVTQK6YrsIewDcPSZXjKGlLh+3yzL+6QMRdU0JQoFtJdiF9M4KxYqVl/iQShSKRWVwxL+MVGr6pPcbG2Y0yrjfiSsq/Ln2O+IQqJIt05uduTzD3D7QMF0MDp4WKjcP3ScIFci7eMsoaIW8u084FLFZRwOo6EZj3nv2oVGPf5M7nprcNVu/B6dK0cEz/bEhPULdl64T6+OLQ7OaHtE/ReQAKfrqJFVixD7zbdxMyE/tcGQ7Q3oS5Z0zVM+XqsAIKRXnPCWkMAjUUUSr4RfHdw1aw5x6v0who9BVUZVXOuqXLxxBaojvKChRjpBaNNmrZUdCMhBzpjEb9PbE4qYcQvnAcXyNPMOcsjB4jDt6d0SJ9IgOiQy/VSIYh8HqsKxv/V/Jo7caxFQlpQTpZ9Lyu/LBBy+NoTWf4U79l9yZtTy7TVOdpr9GaiY9nh+gWY2Lfbo1KJ4kLllL9LMpFDkF03ZHtYKul+UGhpS8tmxCkNbwI1WMDe/O0S8BladdXCvNQ6v5T7mOu69M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66899024)(26005)(83380400001)(86362001)(9686003)(38100700002)(6666004)(82960400001)(8936002)(44832011)(5660300002)(4326008)(6506007)(6512007)(66476007)(66946007)(316002)(2906002)(6636002)(41300700001)(478600001)(6486002)(966005)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRnRnNzb0FZeElqZkZmUWRaZ3djVDk0RkJoUEVId2VJbjJNM0wrS0tsMmIz?=
 =?utf-8?B?ZHRkM0hwZWN1eVlzdVBpbEFqVUxrSVYrbmFLelZKUnBiaGtaT1ZtNno3ZlZT?=
 =?utf-8?B?a1lZajNsWmdPWnN2VFlYWDNrODZ6T1NSNE4vQWNLb1JjR2NrdFpiWTRqdCt6?=
 =?utf-8?B?ajJob1dwYldVdXloVmgyK3YxdlNzMVJpMEVxR0pTWHBRRDdNWXhiK01QUEFs?=
 =?utf-8?B?amFCNmxCVTRpOTVqSitycEh4NEdTN01Pei9BRGtPdlNHWXVCSWNUTlc4eGdo?=
 =?utf-8?B?dVg3TzNHYm5uR3JLalhJTUQ5UElXcTY1UEVvMkkxZzk2RXMvSFZXYnFLU0dI?=
 =?utf-8?B?bUJRWlpMMEFLMUoxdk5pRUJGQW5Fa2pvOEJpQWFZTG4vOUQvOEVGNFVrLzIx?=
 =?utf-8?B?SVYrSjhieEhKTjdUVlRmTjJHZXBqaHhIRWdra1UxYjlnNStCN3Qwa1FwM24x?=
 =?utf-8?B?YkcvTk1XQ1N1ZGJtRERDYVZQSUxiOEFLdTFjT3FWY1QzNDRuVHlkdWFDSklz?=
 =?utf-8?B?M1daaVQ4aHc0SGk3QzdiOFo1SjhXNkk2blFyd1ZJZ05yS0FjeGFzemU2eEpv?=
 =?utf-8?B?UDl5cEN0VFM5dHZtMUlRS04rS1VYd1c4WXpMSmtHSmgycUNUbFRqYVhFYTg1?=
 =?utf-8?B?azNpRlBPSDZoVUpZUDFlUkdGSmJLOSs3WXFnZk0zM3RCaDg3SlhhbnNwdkFX?=
 =?utf-8?B?M0V5RGpXMWk5aDV3Smk4aUVPMFFuTFFjV1o0VGlUR01sYnFxL3dVbnFFcDVW?=
 =?utf-8?B?SjlDVHJCbkxucTFkMktDSklSeXB3ZFpyeUtpNlRxY3dUK3dsWDFnTys4aC9K?=
 =?utf-8?B?eEEzczQ0Z2RGd1pIQS9nTlBkbFE0K2xSMXpOUWw5NWV3SUt4Z292ZHU0bUZp?=
 =?utf-8?B?TlRJS1B4bWI2RkxOcXhyS3dsOFd6dVl6RDZ3aHRHcXYyN3d2M1RKdFgrVkc4?=
 =?utf-8?B?YTMyK3QvS2dJMzZZQzdKRFVHQU81cmRvT01peDl6R0FHQ2hTb1RFT3BiTXUx?=
 =?utf-8?B?SXZNM0tFUkMyTUErOCs1UHd6bERyS2cydFkzZHROZUgvcVZhN0hkYUYxcXV1?=
 =?utf-8?B?dU5OZS9idE1SL2VKNy9OL1F0bE9weWhxKzlsYmh5OTdSY2tYeUNUeEdBV3Ra?=
 =?utf-8?B?UkkvSzIxQ01uWTZidDFzU0Ftd0p6RGRMWkZVSm8vR1RQTDJrdzFCbVRIaUw3?=
 =?utf-8?B?Tk5UYlU4RkMxTzNMV1BxeEJuN2kyZXhlQjlkb3ZNWnlJQXBWSkJLSU8vOVhC?=
 =?utf-8?B?RkJsc2N1L0k2OXo1bE9lZEpwcTY3dkdqbU5vVysyNGtHdFc5SUZxem5PNjlF?=
 =?utf-8?B?U0hPRnNiMGxNWWptTlExalNrZ0laaEI3RHBENjMvaDBPTXFNZkRhSlF2VFR0?=
 =?utf-8?B?Tk1kZms3ZFRxYVhDMGJleHJ1UlAwMVJoVXB4OG9DT2Y4Ykx3Vmxzb0dBbWw5?=
 =?utf-8?B?VDNYK0MxaUtDKzc2MmRwU2k1V2JxUXl1SDdVVFE5ZmgzVlk4YlUwaHBYNXJB?=
 =?utf-8?B?dkFabGJtaW05RXF1UnVSTVJJNE1pdXRYUy9Wb1Y1ZkIwanhxRVpyenVPaTdL?=
 =?utf-8?B?MjArWUlqVVRSRTJENHlrYktJdXdCbDV6cG5yU1U4bDU4WVNIeVFqRTh1YlNG?=
 =?utf-8?B?aFlLbHpVQ3NaSEZiMVNBMWxpQmZDUVk0OGpqQ3VpKzhtdmpUS0Mxekx0Y3Nz?=
 =?utf-8?B?RHpNSEg1RjBuWFpDVDBUYmRCbzR3NVIwUnZMelJEd3VYRE1VVTRCVC9SZ3JX?=
 =?utf-8?B?Ymo1N3hBbmgwbnBSR2REaVFuS2VtVXlwU2g2T3p1N1J4TDZpWDRxbW1hYjlL?=
 =?utf-8?B?UzJmRDBJaWlpRlkxUHdXcXQzOUdEMFdWQnZSWWNwYXBZaUh1cGcyUjgwSVlx?=
 =?utf-8?B?aEQrcFBDZTR4Q2NpTHFlUTlLUEswTTVTTVBVbkozR0lwTHI1elc1dEU5STlP?=
 =?utf-8?B?NEpPSS83Tk9iaTcxV2tGZjVZTk5Kck9wMkpJUWx4V0RGUHJDbjZ0aFNGOXBN?=
 =?utf-8?B?QWlFNWFzalh4NTJ6UkZPUUdiSXdNMVdJVUxRaTNKK0tJLzY3UEI3ODJiRHZM?=
 =?utf-8?B?TXZWeXNzNEViVEdNbDEzNXFxUkcyWGRVOEJHMTRWbHlvSE9UbGZiK0U2L3pl?=
 =?utf-8?Q?JVDWlcin9eFnWFLBcD5E5HMyO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b9b2d8-a1b8-48d2-42cd-08dc0c809676
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 17:22:40.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAAX0LsKw17lLST4G/OZ4JNVmqd2UigKk0gCwpvy2gYR2hz4c7c5+WjPCN7hGaRP2CIYJlUDa1XEW5EYZPJvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
X-OriginatorOrg: intel.com

Dongsheng Yang wrote:
> Hi all:
> 	This patchset introduce cxlv module to allow user to
> create virtual cxl device. it's based linux6.7-rc5, you can
> get the code from https://github.com/DataTravelGuide/linux
> 
> 	As the real CXL device is not widely available now, we need
> some virtual cxl device to do uplayer software developing or
> testing. Qemu is good for functional testing, but not good
> for some performance testing.

Do you have more details on what performance is missing from Qemu and why
this solution is better than a solution to fix Qemu?

Long term it seems better to fix Qemu for this type of work.

Are their other advantages to having this additional test infrastructure
in the kernel?  We already have cxl_test.

Ira

> 
> 	The new CXLV module allow user to use the reserved RAM[1], to
> create virtual cxl device. When the cxlv module load, it will
> create a directory named as "cxl_virt" under /sys/devices/virtual:
> 
> 	"/sys/devices/virtual/cxl_virt/"
> 
> that's the top level device for all cxlv devices.
> At the same time, cxlv module will create a debugfs directory:
> 
> /sys/kernel/debug/cxl/cxlv
> ├── create
> └── remove
> 
> the create and remove debugfs file is the cxlv entry to create or remove
> a cxlv device.
> 
> 	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
> will create a new root_port for the new cxlv device, setup cxl ports for
> dport and nvdimm-bridge. After that, we will add the virtual pci device,
> that will go into the cxl_pci_probe to setup new memdev.
> 
> 	Then we can see the cxl device with cxl list and use it as a real cxl
> device.
> 
>  $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create
>  $ cxl list
> [
>   {
>     "memdev":"mem0",
>     "pmem_size":1879048192,
>     "serial":0,
>     "numa_node":0,
>     "host":"0010:01:00.0"
>   }
> ]
>  $ cxl create-region -m mem0 -d decoder0.0 -t pmem
> {
>   "region":"region0",
>   "resource":"0x210000000",
>   "size":"1792.00 MiB (1879.05 MB)",
>   "type":"pmem",
>   "interleave_ways":1,
>   "interleave_granularity":256,
>   "decode_state":"commit",
>   "mappings":[
>     {
>       "position":0,
>       "memdev":"mem0",
>       "decoder":"decoder2.0"
>     }
>   ]
> }
> cxl region: cmd_create_region: created 1 region
> 
>  $ ndctl create-namespace -r region0 -m fsdax --map dev -t pmem -b 0
> {
>   "dev":"namespace0.0",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"1762.00 MiB (1847.59 MB)",
>   "uuid":"686fd289-a252-42cf-a3a5-95a39ed5c9d5",
>   "sector_size":512,
>   "align":2097152,
>   "blockdev":"pmem0"
> }
> 
>  $ mkfs.xfs -f /dev/pmem0 
> meta-data=/dev/pmem0             isize=512    agcount=4, agsize=112768
> blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1,
> rmapbt=0
>          =                       reflink=1    bigtime=0 inobtcount=0
> data     =                       bsize=4096   blocks=451072, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=2560, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> 
> Any comment is welcome!
> 
> TODO: implement cxlv command in ndctl to do cxlv device management.
> 
> [1]: Add argument in kernel command line: "memmap=nn[KMG]$ss[KMG]",
> detail in Documentation/driver-api/cxl/memory-devices.rst
> 
> Thanx
> 
> Dongsheng Yang (4):
>   cxl: move some function from acpi module to core module
>   cxl/port: allow dport host to be driver-less device
>   cxl/port: introduce cxl_disable_port() function
>   cxl: introduce CXL Virtualization module
> 
>  MAINTAINERS                         |   6 +
>  drivers/cxl/Kconfig                 |  11 +
>  drivers/cxl/Makefile                |   1 +
>  drivers/cxl/acpi.c                  | 143 +-----
>  drivers/cxl/core/port.c             | 231 ++++++++-
>  drivers/cxl/cxl.h                   |   6 +
>  drivers/cxl/cxl_virt/Makefile       |   5 +
>  drivers/cxl/cxl_virt/cxlv.h         |  87 ++++
>  drivers/cxl/cxl_virt/cxlv_debugfs.c | 260 ++++++++++
>  drivers/cxl/cxl_virt/cxlv_device.c  | 311 ++++++++++++
>  drivers/cxl/cxl_virt/cxlv_main.c    |  67 +++
>  drivers/cxl/cxl_virt/cxlv_pci.c     | 710 ++++++++++++++++++++++++++++
>  drivers/cxl/cxl_virt/cxlv_pci.h     | 549 +++++++++++++++++++++
>  drivers/cxl/cxl_virt/cxlv_port.c    | 149 ++++++
>  14 files changed, 2388 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/cxl/cxl_virt/Makefile
>  create mode 100644 drivers/cxl/cxl_virt/cxlv.h
>  create mode 100644 drivers/cxl/cxl_virt/cxlv_debugfs.c
>  create mode 100644 drivers/cxl/cxl_virt/cxlv_device.c
>  create mode 100644 drivers/cxl/cxl_virt/cxlv_main.c
>  create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.c
>  create mode 100644 drivers/cxl/cxl_virt/cxlv_pci.h
>  create mode 100644 drivers/cxl/cxl_virt/cxlv_port.c
> 
> -- 
> 2.34.1
> 


