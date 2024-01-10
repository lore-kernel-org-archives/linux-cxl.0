Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BE4C3C0
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jan 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PL5CMsNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704900485; x=1736436485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tff/6ZwwdSK4K7R+cbw7yRbv9tiQM+M8qStfhJwQwdY=;
  b=PL5CMsNu/8iRMj14WHU+WoQuMfT+3I5j8TTOpsbNc6PTbbClZwC9RvYu
   HOSbeoY5mQxkIXvB0yBvoVXLhhQIYFUhjr7mqqSWEFA0HLujovoTs9khu
   UUTwm0lVFn0HoKoaMBUHkleF/H+0nbkNCpkiTEf/pZ/X1XxKF5LJ6gSEh
   ElLNNVyHM770xnQ8znh42iBkmLoq1nsHrLVxr4mGJV14Zak9gvT4APjRa
   X3Nrk/LDMCBMN67tU+NdZJvyoPJlIN1bitMCgncKRsYhZsRdHGsPTgNg5
   QP2c2kJ3wX3F0vhzNJCp2Rfw4BD5qilBzQ8MZU9/mdO4BK1MiVUxOy6gZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="5301453"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5301453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="925672817"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925672817"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 07:28:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:28:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:28:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 07:28:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 07:28:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2KAlF4D3WC2BD9EQtSlBNn7PzXBZn7qUKHQpZ5N5NYqSvlisj1j33XTu21AH5KAgcw7lD3o/ujA5Dcp8pPrgnLeRQOc2m6ih9NfQ/yGUJoSf+9bTQRO8LjrJqrAwp3MSMt/vh5ie+1xUdsN8zvsMSzaw1AataYyK2+Mq6Vue0YyyjBAX9hfHUrQb9qYxeVxVt0SZSbNhG8880DRbi5t3VVVzy9OCZQmw1vyjijGvFmKQlIzK9PctCPT3s3UnKPr5/y/FycdqGPJNvcO9MJFQ8tLrgvQVUmgq3Xl0N5VfDGKJFaA60ei2fKb6NYlAR3DoJVnIIvhjEaBQSLoO5bhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGYK79bmCJrcE7llWktDN4GzZ9JwE9F2NZ1FK7aKQck=;
 b=GPtH5M3tiuoyRDSoPSP9cKSoaSO4SDpEBKOKhvMyDb0Te374tNlsz8qfwF10pGuIKWjhZNLYwH5v8gN23y+OnzOsdzFy3E1x9OM4tWgV0qyEgPN3eOyLNHU0BaR+q5RsH4Ec+dw0j6gyko/jiuIYuOq51a7Z23r7OskRchvTirxM5VhvXE4chV8DYB77a+C3HWmpvUDQVw0mOrj5S4e3dRfOV3aMxdEbrPF6QF9B1EjfE79u11goxwNHgFKIYx3gQzW4u8pCJsXyfoM8tl0oK14igbD0MA9EzlbkSheY59ljelPF4K6Njqq5YEeyWnTOslI7OST2m/4tC/sangcpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:28:00 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:28:00 +0000
Message-ID: <6132c975-3208-40f4-a710-b7b7dac608a1@intel.com>
Date: Wed, 10 Jan 2024 08:27:57 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "Huang, Ying" <ying.huang@intel.com>, <linux-cxl@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240108121538.00001369@Huawei.com>
 <38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
 <20240109162753.00005b2b@Huawei.com>
 <659d9e563e1fd_24a8294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <20240110100048.000062c0@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240110100048.000062c0@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2e7b5c-6114-4387-5098-08dc11f0bae3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JoVfRnRXBi92L3fnuEUDId9C1lOUo4Wnd3Sk0WIQ5JF1wvUrh8oWxhKU+0ApPmON5CO5RGaMCrW9SZdX1RbJ0rV2nMInKbIoqv5nGrPJFSl+LAoO/zRQJyybF7zrkE1UdwpOh1ZRgujADXYJMgFf+8E4XV2hcpz8ZzaImIx3B7V3mIr+2CRQG/3C3bAU5Mgpnb5FIJtsg4YNT1GlO+mxgMw/AjUDaCurHr2eYWRjnhl2clU0KeuwzL9slBEPNcnDePEcus1ieCY26nN9yEcEesuaaw7MuDEg3Szn4uNFRHVHzTW68+Ab+WmoULsq+ORAC9r08338LLKNo84EMHehor25Fax0UafPGtuXvdblkN/cNYwLkgRaN9ga3McDJyf3fyQnUdz2YTxOc2+F5kx/HFXX2GTquuAnTiYHNjr/86KfzbiCwxZVsDSGnr9QsBFGCbaycEKHyOZse4u0L+cUAicktsP5bfrIYcL8ai3o3FQWvEXPZ0o+QKJGTeYtgGyu5lwKWme8xDpRng/EoHf8Nx4F1dfNOg/jKRRr/boFr+zdZbjIfLNKHWddRfWjsADheMITc+6wpHLFrA48yGl6/odPm6XrvbPvVgBTP4c4rE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66946007)(66476007)(66556008)(6636002)(110136005)(2906002)(30864003)(5660300002)(44832011)(8936002)(316002)(6666004)(41300700001)(54906003)(4326008)(8676002)(478600001)(966005)(36756003)(53546011)(82960400001)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(26005)(6486002)(83380400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlR2MWZVUE9jMVpMN21pT3Y1M08vUzR2LzVkZ2VvZGVwZmRLSy92TTNZNjJO?=
 =?utf-8?B?ZFRVczgwQjZwVmwreW14WlNHbllyWG85SklURmxsSUtkS0FTME8ybGlQWWJB?=
 =?utf-8?B?Z1JUT2xHdzByekM0NkFZNTNDZDJDSzRETU4rdTBQTjF1OE9UaEE5bTR1Q2dL?=
 =?utf-8?B?REdsZ3I1V2lERFNySWUrWFhqdmJRUUJ6aU85TmFuMWwxeXBNaUpSK24rRUNU?=
 =?utf-8?B?NW9MM0h4cmtZZ3d1YmFvck1yd2ZIT29oTnpOSFMyRGhEaTJDNkRzMlNaUWdN?=
 =?utf-8?B?cFpQNzJlVThDTzVYNmcwcjdGNTdIN3hpYUpaTmRDVE9JalBrdSsvVnpuN3NB?=
 =?utf-8?B?ZHZsWmFPaEdGcmxDeE4yeUloS083UGxzZVlpSk5wandrb2w1Q2s3cXBPeWVZ?=
 =?utf-8?B?ZzNRaTVVUXppOGE0SUc1SmdPbktselZiUkhlRWpUSGszYUJrN2FVTTEvWmxn?=
 =?utf-8?B?MnprL3g5dzJpOU1LZFpvMGxVQVMrNUIyRVo2RVcyMzJ4RWFrL3RJdnNrVU1i?=
 =?utf-8?B?dXpHemU2S2h3NkYzUURyajg0em5kNVNJTjloVitSS21RZnJYNVBrL0pudE1w?=
 =?utf-8?B?RUpoRjFHYlBUYjRQSGxxaldsZXFaYXo5TXdPbGpodTRnZC9TOERnVG15Nk9j?=
 =?utf-8?B?bHdLL1ZlM3VHcHRxa2MvVS9tUmFWeHVsR1MxRzJUazRJQ1JqdzkyV2pqMXI4?=
 =?utf-8?B?MlBvTTZyTzkvS2djYWJtWUxXcFlOREIxYit2MjV1cnNCZW91SWVRUk4wNWRP?=
 =?utf-8?B?N2RTR0tESlhSeGtua1c2dkFYV01QcFFoUlFyVHN6KzJMb21Mdk9VTkFpUk9i?=
 =?utf-8?B?aEx0WWdqUlJ6WEZEUEtlM0l3cEdSSU1VbERlSkk4OWV3WlJiTFVlcThlZWRj?=
 =?utf-8?B?TmwwMzNXUVJ1cnBkMng5WTlGQkE2L1E5MUVhNzhGOEFHYzdwUkgyZTU3WE0v?=
 =?utf-8?B?ZURtSmUwQjZQM1VjRG5FamdXZlZDWVlLUFhqMDBsVzhZaDBPby9WY2dqN2FF?=
 =?utf-8?B?dyt6NEx2ckhoR0JwUzRibHFSZWxET21Td0Z0S25oQW1BUmJjK0xRLzBKMk1L?=
 =?utf-8?B?RUpOZHpub01HckF1YnBYWHpHYkZ1dC9HdHlCUXRxdm1wYy9UQ1NaWXNpR3hD?=
 =?utf-8?B?MDZYWmQvSngyTE9XNXM1RWh6c0NncDhkNHZ3QUFGdi8xZXdMOWF5cEZjeEdH?=
 =?utf-8?B?WUI4bnpFblhHd3hQbyt5SHdzSzI2ZEJoWG9qZXNIS1hOMlFaNUgrQ0dpM0Vh?=
 =?utf-8?B?YzZaK21BMUUxd0F0Z09HSHBQbkZFMzdSd3hMQXZMTW93OWFXMmhMcFJ0RzR0?=
 =?utf-8?B?eWZTUFk1dnhsd0o4dmdzRndrMWFtVGVyemYyTkhFSWhSUXd6REt6RWVKdVJi?=
 =?utf-8?B?aFZrLytmaG4vR3FGb3NGTnNIbmgwbk92QzJZMGFQcWdoYjY5SnZyY1E5QmxC?=
 =?utf-8?B?Ky9uMThFd3VFMmQyT3J6Rk9QUTFwWlR1cG5ZT2kxWWVwYUY0NGEvUnM2cisw?=
 =?utf-8?B?T25LdGFpbWdlWmN5MmlKZENYeTB3d3k0Q2dlNFBmUFJQbVlHSVJCMnBkOXlo?=
 =?utf-8?B?Q1V0eXM5QTc0S01CeHFod0ZFOGlsSEZKT2JFTkpoUjFaV1lwWmRCQWJSeWhw?=
 =?utf-8?B?OVdaNmU2OEJSYnhLQkdjZjAzdEhaK0k3L0lFK2NjVnJJMzhVU2tSOEVPY1lz?=
 =?utf-8?B?dTArS0RMNFBLK0ZVeUxhR2xpNWJFV2F6Q2ZlRVZEK243b2VuakNLaEw5OVNY?=
 =?utf-8?B?SzltZ1pDVUtQdGVIT3FYcFBPeUl0MnYyZytKRnpKNXNtbkFqcmVNOTFKM0ty?=
 =?utf-8?B?ZU1udTFXYWQxa2xpNWQ2OWIvWGM0a3VnME03RnlNR1hQWVVKYlBTby8rcGIy?=
 =?utf-8?B?akxvKzBwbWhLbWRRcXRxcUx6elpjUDdQYnBqd3p6bExlQmIzaDlDNE5ybHVH?=
 =?utf-8?B?YktwKzVGSUpWMUMxWTN0clVZRndFdHc4ZEFlaDM3Z0E3QW03SDlpVllERTlE?=
 =?utf-8?B?VkUvUndOc1RYWTYyRmJ1YjNCK2tyR2w4K3g3K3BKdnVQKzBUVHp4Q3ZxNk1o?=
 =?utf-8?B?MmpTK3ZBN1c0MHlIYSt6NTlBZWpnc2t2Ulp1WGRKMlVoelFWVnVmOUpVMm03?=
 =?utf-8?B?T1BtUUx6djJvd3JCYitPbzBtdlJ6TWI0MGw5M1lJUDQ0WUlxR2l0YlpwR2Nv?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2e7b5c-6114-4387-5098-08dc11f0bae3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:28:00.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13Fl/5rDpRT2vC8ywFy6CyVHrXSOFAVi2DFuUZv5WmmE4Y/+yv3vkhSguuD9gZNEAKlW3dYjkr7pgAMf56NeGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
X-OriginatorOrg: intel.com



On 1/10/24 03:00, Jonathan Cameron wrote:
> On Tue, 9 Jan 2024 11:28:22 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> Jonathan Cameron wrote:
>>> On Mon, 8 Jan 2024 11:18:33 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> On 1/8/24 05:15, Jonathan Cameron wrote:  
>>>>> On Mon, 08 Jan 2024 14:49:03 +0800
>>>>> "Huang, Ying" <ying.huang@intel.com> wrote:
>>>>>     
>>>>>> Dave Jiang <dave.jiang@intel.com> writes:
>>>>>>    
>>>>>>> When the CXL region is formed, the driver would computed the performance
>>>>>>> data for the region. However this data is not available at the node data
>>>>>>> collection that has been populated by the HMAT during kernel
>>>>>>> initialization. Add a memory hotplug notifier to update the performance
>>>>>>> data to the node hmem_attrs to expose the newly calculated region
>>>>>>> performance data. The CXL region is created under specific CFMWS. The
>>>>>>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
>>>>>>> Additional regions may overwrite the initial data, but since this is
>>>>>>> for the same proximity domain it's a don't care for now.
>>>>>>>
>>>>>>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
>>>>>>> for a node. The sysfs path of
>>>>>>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
>>>>>>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
>>>>>>> to the proximity domain of the CXL region.    
>>>>>
>>>>> As per discussion below.  Why is access1 not also relevant for CXL memory?
>>>>> (it's probably more relevant than access0 in many cases!)
>>>>>
>>>>> For historical references, I wanted access0 to be the CPU only one, but
>>>>> review feedback was that access0 was already defined as 'initiator based'
>>>>> so we couldn't just make the 0 indexed one the case most people care about.
>>>>> Hence we grew access1 to cover the CPU only case which most software cares
>>>>> about.
>>>>>     
>>>>>>>
>>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>>>>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>>>>> ---
>>>>>>> v3:
>>>>>>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
>>>>>>> - use read_bandwidth as check for valid coords (Jonathan)
>>>>>>> - Remove setting of coord access level 1. (Jonathan)
>>>>>>> ---
>>>>>>>  drivers/base/node.c       |    1 +
>>>>>>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>  drivers/cxl/cxl.h         |    3 +++
>>>>>>>  3 files changed, 46 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>>>>> index cb2b6cc7f6e6..48e5cb292765 100644
>>>>>>> --- a/drivers/base/node.c
>>>>>>> +++ b/drivers/base/node.c
>>>>>>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>>>>>>  		}
>>>>>>>  	}
>>>>>>>  }
>>>>>>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>>>>>>  
>>>>>>>  /**
>>>>>>>   * struct node_cache_info - Internal tracking for memory node caches
>>>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>>>> index d28d24524d41..bee65f535d6c 100644
>>>>>>> --- a/drivers/cxl/core/region.c
>>>>>>> +++ b/drivers/cxl/core/region.c
>>>>>>> @@ -4,6 +4,7 @@
>>>>>>>  #include <linux/genalloc.h>
>>>>>>>  #include <linux/device.h>
>>>>>>>  #include <linux/module.h>
>>>>>>> +#include <linux/memory.h>
>>>>>>>  #include <linux/slab.h>
>>>>>>>  #include <linux/uuid.h>
>>>>>>>  #include <linux/sort.h>
>>>>>>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
>>>>>>>  	return 1;
>>>>>>>  }
>>>>>>>  
>>>>>>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>>>>>> +					  unsigned long action, void *arg)
>>>>>>> +{
>>>>>>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>>>>>>> +					       memory_notifier);
>>>>>>> +	struct cxl_region_params *p = &cxlr->params;
>>>>>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>>>>>>> +	struct cxl_decoder *cxld = &cxled->cxld;
>>>>>>> +	struct memory_notify *mnb = arg;
>>>>>>> +	int nid = mnb->status_change_nid;
>>>>>>> +	int region_nid;
>>>>>>> +
>>>>>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>>>>>> +		return NOTIFY_DONE;
>>>>>>> +
>>>>>>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
>>>>>>> +	if (nid != region_nid)
>>>>>>> +		return NOTIFY_DONE;
>>>>>>> +
>>>>>>> +	/* Don't set if there's no coordinate information */
>>>>>>> +	if (!cxlr->coord.write_bandwidth)
>>>>>>> +		return NOTIFY_DONE;      
>>>>>>
>>>>>> Although you said you will use "read_bandwidth" in changelog, you
>>>>>> actually didn't do that.
>>>>>>    
>>>>>>> +
>>>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>>>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);      
>>>>>>
>>>>>> And this.
>>>>>>
>>>>>> But I don't think it's good to remove access level 1.  According to
>>>>>> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
>>>>>> characteristics").  Access level 1 is for performance from CPU to
>>>>>> memory.  So, we should keep access level 1.  For CXL memory device,
>>>>>> access level 0 and access level 1 should be equivalent.  Will the code
>>>>>> be used for something like GPU connected via CXL?  Where the access
>>>>>> level 0 may be for the performance from GPU to the memory.
>>>>>>    
>>>>> I disagree. They are no more equivalent than they are on any other complex system.
>>>>>
>>>>> e.g. A CXL root port being described using generic Port infrastructure may be
>>>>> on a different die (IO dies are a common architecture) in the package
>>>>> than the CPU cores and that IO die may well have generic initiators that
>>>>> are much nearer than the CPU cores.
>>>>>
>>>>> In those cases access0 will cover initators on the IO die but access1 will
>>>>> cover the nearest CPU cores (initiators).
>>>>>
>>>>> Both should arguably be there for CXL memory as both are as relevant as
>>>>> they are for any other memory.
>>>>>
>>>>> If / when we get some GPUs etc on CXL that are initiators this will all
>>>>> get a lot more fun but for now we can kick that into the long grass.    
>>>>
>>>>
>>>> With the current way of storing HMAT targets information, only the
>>>> best performance data is stored (access0). The existing HMAT handling
>>>> code also sets the access1 if the associated initiator node contains
>>>> a CPU for conventional memory. The current calculated full CXL path
>>>> is the access0 data. I think what's missing is the check to see if
>>>> the associated initiator node is also a CPU node and sets access1
>>>> conditionally based on that. Maybe if that conditional gets added
>>>> then that is ok for what we have now?  
>>>
>>> You also need the access1 initiators to be figured out (nearest
>>> one that has a CPU) - so two separate sets of calculations.
>>> Could short cut the maths if they happen to be the same node of
>>> course.  
>>
>> Where is "access1" coming from? The generic port is the only performance
>> profile that is being calculated by the CDAT code and there is no other
>> initiator.
> 
> This isn't about initiators on the CXL side of the port (for now anyway).
> It's about intiators in the host system.
> 
>>
>> Now if "access1" is a convention of "that's the CPU" then we should skip
>> emitting access0 altogether and reserve that for some future accelerator
>> case that can define a better access profile talking to its own local
>> memory.  Otherwise having access0 and access1 when the only initiator is
>> the generic port (which includes all CPUs attached to that generic port)
>> does not resolve for me.
> 
> The initiators here are:
> 
> * CPUs in the host - due to limitations of the HMAT presentation that actually
>   means those CPUs in the host that are nearest to the generic port. Only
>   these are considered for access1. So for simple placement decisions on
>   CPU only workloads this is what matters.
> * Other initiators in the host such NICs on PCI (typically ones that
>   are presented at RCiEPs or behind 'fake' switches but actually in the same
>   die as the root complex)  These and CPUs are included for access0
> * (not supported yet). Other initiators in the CXL fabric.
> 
> My ancient white paper needs an update to include generic ports as they do
> make things more complex.
> https://github.com/hisilicon/acpi-numa-whitepaper/releases/download/v0.93/NUMA_Description_Under_ACPI_6.3_v0.93.pdf
> 
> Anyhow:  ASCI art time. (simplified diagram of an old production CPU with CXL added
> where the PCI RC is - so no future product info but expect to see systems that
> looks similar to this :))
> 
> Note the IO die might also be in the middle, or my "favorite" design - in a separate
> package entirely - IO expanders on the inter socket interconnect - (UPI or similar) ;)
> Note these might not be physical systems - an example is a VM workload
> which occasionally needs to use an 'extra' GPU. That GPU comes from a host socket
> on which the VM has no CPU resources or memory.  Anyhow given the diagrams
> I've seen of production systems pretty much anything you can conceive is is being
> built by someone.
> 
>         ________________      __________________
>        |                |    |                  |            
>        |  Host DDR(PXM0)|    |  Host DDR (PXM1) |
>        |________________|    |__________________|
>               |                       |
>        _______|_______         _______|____        _________________
>        |              |       |            |       |                | 
>        |   CPU Die    |-------|  CPU Die   |-------|  IO DIE        |
>        |   PXM 0      |       |  PXM 1     |       |  PXM 2         |
>        |              |       |            |       |  NIC (GP + GI) |
>        |______________|       |____________|       |________________|
>                                                            |
>                                                     _______|________
>                                                    |               |
>                                                    |   CXL Mem     |
>                                                    |               |
>                                                    |_______________|
> 
> So in this case access0 should have PXM2 as the initiator and include
> the bandwidth and latency numbers from PXM2 to itself (where the GP is)
> and those to the CXL memory that Dave's code adds in.
> 
> Access1 is from PXM1 to PXM2 (to get to the GP) and on to the CXL mem.
> 
> Note that one reason to do this is that the latency from the NIC in PXM2
> to CXL mem might well be not much worse than from it to the memory on PXM 1
> (cpu Die) so placement decisions might favor putting NIC buffers in CXL mem
> particularly if the bandwidth is good.
> 
> 
> 
>>
>>>> If/When the non-CPU initiators shows up for CXL, we'll need to change
>>>> the way to store the initiator to generic target table data and how
>>>> we calculate and setup access0 vs access1. Maybe that can be done as
>>>> a later iteration?  
>>>
>>> I'm not that bothered yet about CXL initiators - the issue today
>>> is ones on a different node the host side of the root ports.
>>>
>>> For giggles the NVIDIA Grace proposals for how they manage their
>>> GPU partitioning will create a bunch of GI nodes that may well
>>> be nearer to the CXL ports - I've no idea!
>>> https://lore.kernel.org/qemu-devel/20231225045603.7654-1-ankita@nvidia.com/  
>>
>> It seems sad that we, as an industry, went through all this trouble to
>> define an enumerable CXL bus only to fall back to ACPI for enumeration.
> 
> History - a lot of this stuff was in design before CXL surfaced.
> I think we are all pushing for people to reuse the CXL defined infrastructure
> (or similar) in the long term to make everything enumerable.
> 
> Arguably for a host system ACPI is the enumeration method...
> 
> 
>>
>> The Linux reaction to CFMWS takes a "Linux likely needs *at least* this many
>> memory target nodes considered at the beginning of time", with a "circle
>> back to the dynamic node creation problem later if it proves to be
>> insufficient". The NVIDIA proposal appears to be crossing that
>> threshold, and I will go invite them to do the work to dynamically
>> enumerate initiators into the Linux tracking structures.
> 
> Absolutely - various replies in earlier threads made that point
> (and that everyone has been kicking that tire down the road for years).
> 
>>
>> As for where this leaves this patchset, it is clear from this
>> conversation that v6.9 is a better target for clarifying this NUMA
>> information, but I think it is ok to move ahead with the base CDAT
>> parsing for v6.8 (the bits that are already exposed to linux-next). Any
>> objections?
>>
> Should be fine if we keep away from the userspace exposed new bits
> (though I think we can clarify them fairly fast - it's a bit late ;(

The only exposure to user space is the QTG ID (qos_class) based on access0 generic target numbers. 
> 
> Jonathan
> 
> 
