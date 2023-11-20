Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv9wlEtI"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B23BE
	for <linux-cxl@vger.kernel.org>; Mon, 20 Nov 2023 09:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700499884; x=1732035884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1UVS6LfiJrn6R8kew7999cFxOW+YSTiZWCfv5quRPH8=;
  b=Pv9wlEtIwt4VM6z1tDUrkTJaVS7Jxxj4vBt8mdmvnzb9qREwr054b/hV
   hCwnoRuzITgoX3emWQ7lCydP3O30EL4wVxlylGlx+3cBqRxzDADrkHbwW
   mHdcDsbqHo2NmW9YAymi9S4r6KB6xkPEK43i8r/8c8wvBihA6+TYeN76j
   T5Cs/+D4vQv+/kdHlArpmE40YhMobIYehEEPZil7FhCrV6lXvJy5ZvHGW
   SWhLbSxSWMyX2ZqAI0bi+AMRs1b4qXeQ917+YyN0gBEJTMrHsu8wFGNWA
   M0BVZqAZZWH8EcqY0qIDbnriRb8fz+0d6vDZxeQpPMcw8FSQKBUdTFqCu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382045754"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="382045754"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:04:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="889978120"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="889978120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 09:04:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:04:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:04:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 09:04:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 09:04:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVtFw8Vqsi5DGS1e+bt+vNDUqfyNvk5AuegaeHIInlkMaHbmHcZj4raNAUBKIgwRIl193TMeCGbCDh7knZJ39ugf8TTgTy8icV6ynYDtqj/wdaRG16oj0VpdsyInHaSKrsSUwIh3sjxX6/TxloQCYs/IkVEuLd61oshhba/nHczj8XOAfvfEKLtl5p/CYxKxoyuzZ3Cu3iWJ3imafM6Hc0oT0F+DKHZUQ8CIuR8C+vXwczPYT4DCd9ykOeBObsnqjp21dFX8hKi52GVpwt4uN/ghJzcaAQVJuV6HpvvuglPlHMVecNIA8nKt27bvyVsB9MWEluH5UTvwxli6mQhE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2R2nSWR6u88GNjCeaPSgfX666aqy5dGLcf/1pXpA/w=;
 b=M2c5bONkWnnHPpsJZYPe5VW69ib2SNkApXtrQN0TNml6wQYRA4Uhj96HaEYn6yuyhIb6ul7a+4qRTr4kBJsu97xdNNIHwHPPjRZ/rge13ubMzUDlHP0IRZw4q5SWnWIgt6Owu9tBivCkBL9KGkUz2cM6//zLqe30ABJCHitmU9VvCDk13XKyCFS6L7EkSdmTIUBZ00lgWtyuvTpBHsaxS+R8exrd7e4Z5lVcxQ5QiccZtCPSHtqKz8PAlSKFCcjFJOiVzCm7yN0mrPj2AbN2wsczU450xaSWUzuYTcFWTKuOTK/5PlTETzs+J1kODF4Og9OR/yuJpdnS2jKvPC2NCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 17:04:40 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 17:04:40 +0000
Message-ID: <e9a0c8bb-c49d-4632-bafc-34993778423e@intel.com>
Date: Mon, 20 Nov 2023 10:04:37 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<peterz@infradead.org>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 15af59d6-2241-492a-2bfb-08dbe9eac8f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZ1evLSUUP/mG4EuCLHYiBRZ6+xcEadr8B5dL7N/pFjOHuTQQs/HZwgcg7g272l+PxmIZk81uuFqwzSBi1Sak2JEb9Ux6fUQsWRxd6bmQY64c8yD8rJkasME/Cy3TJWpTOsnB83V9UhqH6+nOOaVaJ2IFMHhBt8JIe6fJtCg+kEHOET17e1j8HhFxwlr33gynTsd9zrHE8Orj8e9O3mJPVgOMUW63SWX9Kzxsiv96ziDq662TzGbiA5+/o+GKd/YjW2miJnSldTCJfyo5nJGc3irLTpaCtUf/ZQueb5N6gPv4rMsSzqa8TV55rM1oZ9dbQHIWWDzeRueecNa34sWGeDS5le3ZLXg3lakct2JOR5lZWQ4e7cv6xQmO2NqVkBa8X2RisMC4AXTPIxaExKsI8SG+TfIjpPpbWB4b0Tyh1erYjhUDQ7PlJJ+uhO3LKCXYk2gKLhWVIkWpLQ/cuQX4h9uQV73iNp3oqK8AO9q0Dt7k8kePUAtO2EBon+r5BYDta423poWeWMfsBFNuP+v9p4PMsUZdtsPuzqI72OgNjVaYn32L14PqJgJvRaocXVJR/mOtFkrWt0Z+djpzPJMU/24V+OIwdT2mS+Qp0uYkPHDuuFsnyY6oVbB3Lb8hKKT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(82960400001)(316002)(6916009)(66476007)(41300700001)(36756003)(6506007)(53546011)(6512007)(31686004)(26005)(2906002)(6666004)(5660300002)(44832011)(86362001)(66946007)(66556008)(478600001)(6486002)(4744005)(38100700002)(8676002)(4326008)(31696002)(8936002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhrMTNaRkxoMzZRNzlBeXN3clM4NEJrM0VSbmFrM3ZGRzZ0VTgzNFdIeGwx?=
 =?utf-8?B?Q2g0MG5CaU84TmVINFBCQjF1YTlFQmxlaTNKcVIwNHQ0OU1Xc3JwUHg1N2lz?=
 =?utf-8?B?RXdma3AyT0tIT1FIdE1ubUdxbWtZYlBsRVpXVHNBUTFTZFAvYUlQK0JTZmda?=
 =?utf-8?B?Q2RzUXZQV0hCdVhzYkJ2U2xCMFJTeGlMZGJZQkoySkx1YmExOGFhNE9zVU9S?=
 =?utf-8?B?QVFwTEdUNHhQc0RlSVdYeDhjT0JQU3JMMWFMemoweHVHaE5uc0ZKZjNORGFs?=
 =?utf-8?B?blBnRndDbERaSTQ4d3JVN1MyMzBBaUUvK0NXSi9ZeitmcUdVOGtlNy9IY09R?=
 =?utf-8?B?T2NUK1hwNFQ3YkVhQVN5aWJpSjBUSmZ3R3MyWjdxK2UzbHI0QU81YTJJT3E1?=
 =?utf-8?B?LzRqVGllMUo5bGQweDA5N2o1N3dFNEQ3T3NxaXovNWYvakdNSW1DWUFKdENF?=
 =?utf-8?B?dVAzVjV6YzRQZlFyV25KN2RacHlRV1AvQXUveTJ2czlKNFJubThuL0FQTE96?=
 =?utf-8?B?VFFCMUlVM3hkcXd5N1l6QmxiQjZmcWprdDJmNERlVkg1cWlXVW1ncnYwWGdD?=
 =?utf-8?B?QXF4a2VXT01SL0xueWMzLy85MGdDRDArQUV6SVAzdEttK20vQkkwU3o4UUcr?=
 =?utf-8?B?Z3ZGN1VkdDkzTnpnOUlQSkdsLy9GTzVKZXR0K1p5UlZJWTVUY1Q2dEQ2RmpL?=
 =?utf-8?B?UEN2NUdncmRsNUovUDQ2Um5nNEdXTkNJQTBLb0Q4cXpsY1kzV0ZCN0hYSGlG?=
 =?utf-8?B?SnR0RWdKWno4aHQ2WEc0V21KdFp2aDNPWkZqVVlFTWN5N2JXdFpQSHEyeTBa?=
 =?utf-8?B?ZVZ2L2FYWWFNellpQ2VCK0JIZEp3eUJueWNjYytjRTFheUF3U29tSGtobTgx?=
 =?utf-8?B?a0VjWVFRblFuTlhRNFVXNW1VZnpTTGVyY0hSdHM2Wm13R2FhazUwaGNGQU1z?=
 =?utf-8?B?SjRiRnkxRXZTMGJBMFBFdEU5Z0s5STlyYjdvd1hVL3JpMlhZMER0SG1PV1py?=
 =?utf-8?B?WERyODljZ2p3Mk9VNkZmYW5FSUNVdXB1LzZwODBoS3psVnErak1Td3FkY3BX?=
 =?utf-8?B?QWtXYjl5NXpYazFjTDM4c015VDNYR3E0Zi9UenFqQ0tIcFJxbHA3VVJ2ME5C?=
 =?utf-8?B?QS9md00rM0R6SG9ORlY5UnNjL0RZQUFDUUhyQmw5b3BjMWc1MHlVQTU2V2FT?=
 =?utf-8?B?V3RwS1hqeDlMRDFGMnB4a3l4V3FhT2t6dDFlSVZxTE13TW0zWHhaa0JUSmE0?=
 =?utf-8?B?Z2pmNmFlbVBxdU9XQnZjdkJ4VE1CUUtQZFo0QmVXMEV6ZnJ0Q3kvSDdXYlA3?=
 =?utf-8?B?cUJhQjZuNHRtMUx1WkJxajE5Yk9HOHJzTml5VHJkOFpxcGZqRUlTZ29nNHNx?=
 =?utf-8?B?S0V0RW1QWktpOGJoNGxOVUd6RGd2Y09iSzlqZzBlTnRWdFJHbk5qaGUzSTE3?=
 =?utf-8?B?S0k2c1dRRUtLTFVuSEM5bW5TZUk2T2x4aE9adEwwLytuSWdwR2lKdUVzb1RC?=
 =?utf-8?B?V1ByNWJMUGRnMW1jVnc4SDVBZWRFVi9TZEZFOGdSK3Uza0ZQUERZUXVZNnk0?=
 =?utf-8?B?VG8vQnFYbGV4TzdkTEU5NlpVQ21sdjF0aGkxckJvWVZsc0RvbWNsMEtBREcy?=
 =?utf-8?B?WUN3UU1EaERsUzhDU3d2dmhlem1GbExLSWcxWU8zSmpybVEzVksrcXNVc3Ax?=
 =?utf-8?B?QmZzWlo4VUM5dzAvTE5DOTNZU0tYU1RSZzNQdnhNWThvS0cyY00wR3RWR2RC?=
 =?utf-8?B?VG1VSUtKcUVXbWtVZ01keVNBclFZZHFiOGRUYytnUmgwQTFZUEhHN1FncE1N?=
 =?utf-8?B?NCtabUZtWFMzeVdOMnUrQ0xNR21mVlRkVjkrTHVYU1NLN0dTZWhYdm9Hcmg5?=
 =?utf-8?B?KytqQUFyelpGVHp5ejJtdGZ6b2pmcnNYQU9QQ2ZDMDdBOVI4anJtRnhLakk0?=
 =?utf-8?B?cThhMml6Vkh4NHB1dVdHYkpXa0srYlcwZllwUm5raVRGb01KZnJkeiszZ0FD?=
 =?utf-8?B?TDl4a2ZvM1IyN2NMUWZzL3lWOElzRUcyTWc1Q1lhRFpJbGY5RU82YXVyT2tH?=
 =?utf-8?B?cWNkMEZydEtSUFR3NHNzRUVlUjBtcG1MdUhVUnNLWGI1ZktPV0o2QkltMCtM?=
 =?utf-8?Q?ktd65iJrP+SLO+PH9Ps0mV01m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15af59d6-2241-492a-2bfb-08dbe9eac8f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:04:40.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2mDhftIHe3OoC4Cz/0flAV1jxTQhBSoJBuaxX4ts+8QhktEJcSivgjhR5K8e0lOCN2pUb8q+SUr1F9hMRoCmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com



On 11/20/23 09:04, Davidlohr Bueso wrote:
> On Fri, 17 Nov 2023, Dave Jiang wrote:
> 
>> init_hdm_decoder() modifies port->commit_end without taking the
>> cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
>> However looking at the code, it looks like the write version of the rwsem
>> needs to be taken due to the modification of commit_end. Wrap the write
>> version of the rwsem around reading and writing of commit_end.
>>
>> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Uhmm but do we expect concurrency during the switch/port probing phase?

I would assume so, which makes the protection necessary no?
> 
> Thanks,
> Davidlohr
