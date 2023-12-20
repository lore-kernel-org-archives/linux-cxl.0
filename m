Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E024879E
	for <linux-cxl@vger.kernel.org>; Wed, 20 Dec 2023 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ce4gYtDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703103969; x=1734639969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lQoSo8pNzkW5aXe6XOadyHxkYu4BnnQeaE2dHpA84YU=;
  b=ce4gYtDI2aya1bGdogc2n3iad6CnLFnpcSmUVK8wmyIQ1U7Ra1REDA1+
   8Z1gD77BP8DfsuK5EoajWHfHcSOx6YjoQereKvlLqQjT4itDVHxqaUGlG
   efhixZeZDsK+D2ncPBKajE9s1zTm/mKC9te4yy5h3Tm2HzAXc49Khqh1x
   QM/0wZ+s0J7KTIX3id/5y+qekemlV0sTfTz/qxdCP4l3uLk48iQBB1xgO
   EN0BSnMy/er20L/0f65OmZP/847QFNvR9qPFzDoew6KBl7Ea4YDubc3te
   a8ZKDSzatBRW7nAUxcBunYdTLx09AN4ei7I0bwClZ05vfwMYcGwhpkJgM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="14557724"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="14557724"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 12:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="18436492"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 12:26:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 12:26:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 12:26:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 12:26:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 12:26:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrzUp2u+X/pLcFq/MbFW224cpWlvnbowu5fMH8l+SzliGTiWgUbIU1TbyuIY9b6ITp4L8PuSL9e0jPxv77wJYD07hjtjoZuyxJNCFdu2Pu8TyNz0+R5suyjxxOSolZ5nm3csVvV+Ha03hITM0qEizO1CGWaR2Rdto8Dc4fEWvJRoJPfulPtbZS0QN+LvfZQ5ywHdsfGGsfQzUCwsdBVVJfA0TmUNrdl52El1edVAP9D8I9U+ebfTFWx/+cL//7xIgoP8qXOWZHHwCmKA1gkFcf7sDmF5wLkVlfupSLbsiG8hWdcERbt2uezSdU1enSntMucQEC+ZGudg4LBER3J+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmene9TSZhZZp4V/pBtlcf6JwrBQtZsbrSZQ4or3hDI=;
 b=klIy+vAPjjg2HpIWf7B0G1JTBM5H0xgw0vieCL3ncW47gIPGNNxubAPtatTD3FVH9pX+z1ch6qqyMwwx0o4TF8gespobx2g0GiZOMTV9s3Kku3/antv5EcC7MR0r3k/uChR2R2OE75SJtaXNHu50dsbAEv6q0yFlnbvm/Pty/caTuj2mb6MywtaBhd1+txLRsxBG1Kph3PtTnqNQrdPJQLrNCGTxpTGJkos7IrpmFdQdSQ1Dx8+7P89ohu38USKZmcKE4Xx5qRhQgAzxAaU+dySJH06pYYS9b/5EaU91kUw7tM37EtDOEsKGnN1go3ZF7RPns8Zep6oyHdSc29BMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 20:26:05 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 20:26:04 +0000
Message-ID: <190b7c40-fa03-402d-b8e6-c2d581270bfb@intel.com>
Date: Wed, 20 Dec 2023 13:26:01 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Brice Goglin <brice.goglin@gmail.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
 <23a78aa8-e076-4b98-bd7c-4299aefd9895@gmail.com>
 <500b0900-f4bb-475d-817b-6a72f18e0134@intel.com>
 <20231219164408.0000790a@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231219164408.0000790a@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: d57e5c46-27ee-457d-c9bd-08dc0199e3f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fo/za9x1ks6HJo0KSwgK7R1ko0ozevcO5iNa3ODj0Y1oQUdeqQKZ+FOlzaIgGutE4vEnnXrQGjSbKYhAW66Wesu1Vsf/r1jRPzNYOIb9Q1BnL3I5sZH1V5KuvpcDk+hFKaDjbSrSVuD481gY3Gl/xNrahqN1VPXjx8QMQzmRhdM3Tlzra+5qXKumLaGtszd1xDS6OYHereafqRt5j6IfAJIo75S/jCSMWFMKjNvsGa3cLkdqREj3Twut80/aLTnc00Lo6vbpsUxUBxiKKbGXae/oln4g44KCs2IbKdpYymt7GIajAvqfkqHTWVz+VqSKls8rP+Hff5j4WccrNpHNPRCzT5d0M5ymfC1EmSrcNghNcQc6KAx0kuepR/an5q41Jq25ymmChAO1dPY43dGT9TGqniSH7JCU3K4CCkphUr2pB6jhnAM7CzrQzV7NK4KAeQbZ2/7AJrevZSNT9Pi4XLRD5PPwTWCgIcC5N1xMsxCgsjE4qinM1cI7NtgztmngZ4cfJacg9LotzKlrNWw+uujC6OAuTQNQuh0cslTsN+CVOlvjBlZXjg2Y1ij//o55Ipyy/5gzuQweKDuQrA3A8WqJcuujj8fZUsHUvRG9ckzG3t54B4ItqO3/kcfkKadU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(6506007)(53546011)(6666004)(6512007)(478600001)(2616005)(26005)(41300700001)(31696002)(86362001)(44832011)(316002)(2906002)(66476007)(66946007)(66556008)(8676002)(8936002)(6916009)(31686004)(36756003)(5660300002)(82960400001)(4326008)(6486002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNxTHVCRnhLZndqM1hOVGtWWVl6cjRNeGFpQXZjMDArK1AzQlc5WGQyWmFP?=
 =?utf-8?B?ZTVYZ0xDZmJMUkUwd05MdkxRdkxHaEVzU3pJdDhjREtiYURWZy9kdWFrTWlq?=
 =?utf-8?B?Wld5akxwQzNpYW4zMjNZZjI0V21FSDJWSDlrSUlseVAyVzc0MkhlbFo0dUtP?=
 =?utf-8?B?ME8wbEd1Rk5kSWc5NmNSTmdYeXM2UGhoMmdxT21GOUR1TnFBcWFmQkxkUFJH?=
 =?utf-8?B?Smxhcjd0WlhMT2dxeGhrekJJZjhmVmlpUVl1TzVGb3hkUGlOaU8vcFpVRkdC?=
 =?utf-8?B?V213cFVPcDI3TVptS2hpOFFaRmdFRHJMekIxaWx6NEgweGswbGtTcEFhZkZQ?=
 =?utf-8?B?d0dqaVlhZm9DRU0rUCtEKzJicHJHZDRWZ1ZPMm5ZV1ZZQWxqRmQzWHZCUFov?=
 =?utf-8?B?YUtXa3ZndmwyUUIxMEZwcjd0TnRnUjBtWUNGc2xSUDNvc2N1V2dKSjF2eWJH?=
 =?utf-8?B?MEwrL0srMDVQTVZyN3B5TlVFY3FpZG5zMlNDeGJJRGdwamJJOVFkRXNRRlZB?=
 =?utf-8?B?WHNQRWIweU5KN1J3V1pPd2lvZUtoSXFVVFRybDcwbzkyL1BtazZhM1lsRmcw?=
 =?utf-8?B?dFRrMlJud1RYdXh5NnhTaytValBMa0lHYUFhWjhoZnVkQlhYZHlXV3M2NXQ1?=
 =?utf-8?B?Z2xQOW1jRHlJMlFRajNSNEdNQk85UHpSQUUxSHYxcWh0dUtOWGtGbTJQTjhi?=
 =?utf-8?B?eGkxME1JdG1BMXJjYWs4WXBTMWJ1a00yZUNRaGo4aGcyYXNoWENjWkpHZ1k5?=
 =?utf-8?B?K25QSE41ZGxvMEVVc1ljZjZyeGVPZFRSemh0YnJTQ1BDeGx1eUVDYlpZWjVO?=
 =?utf-8?B?UUVZWkVBWnZBVTNaRnI3YngvL0ZPR3B5U2VYeHlKOGk1UC9URHlYeG9kb3JH?=
 =?utf-8?B?NUJ6czdkVXRVcEZhMms5dWlhWUJtN1A4bSthY012VVhzMnNYcGI0V0ZqZWhC?=
 =?utf-8?B?UDAxS0prMU9oMHRKNDAvZVpySzVFUUVGY1pXdG91YWJzTDRDTFRRTVFqUnBx?=
 =?utf-8?B?WWpCZ0hZSmJpSDlsOWVvU2cvWFFtWlhQTEJlUVh6RWFyMUhESVExd1ZrQjBu?=
 =?utf-8?B?OEpvTGRYZGtNOTBFMytFWWlBVlh2OXB6bEhETEc0aWxSeHloV3FmcjB2YnA3?=
 =?utf-8?B?OWlhWjhNNkpxeXhPUm53RitOcG5WejV4aTZrMFJVVldxc1dLcDRCVWd2eEp1?=
 =?utf-8?B?aWZXRGNSWndRM0p6Sy9FWVlDTmM3c3dXQnFDNHo1eXBBdzZwK3NQRjJNUnBs?=
 =?utf-8?B?WUhOeTFzL2RQL1dzb3ZSU3JGVDBWY2h5R0x0bWNYZFJ1aityWlBEZ1ZudjNt?=
 =?utf-8?B?RHJNNWVMbUhzOHg3STQxTmxVeC9RQjA1aFExdzFlNG5kZkdxM0VvOFBaY1ZC?=
 =?utf-8?B?Z0toSnVkb0N0dVkydHdLdUtIQVByRUpNVHN1a3EvZFZqZGpKRytnNE1Cdk5j?=
 =?utf-8?B?cCt6TldSWFpuYU9KVTY1RUVyK3RtdnFZUmtPZ0xkeWl6cnNSeUE3cXkyNWpq?=
 =?utf-8?B?N1VUKzI5SlBFZSthM3B4M0x3cnVNZ2ZKdExVRGJzb2F6YnhHSEo0N3FtU01l?=
 =?utf-8?B?U0pnaFB4ckViYllsQWJDMlNQbmtRWWJDUjFPQldlaTdoUjdPYjB2Y05CaVAw?=
 =?utf-8?B?V2ErNHRBYVJRUGo2SmZ6WFB1bVZsQ2VnZTM4MW5LUkNNK0tTeGxtRDBUYlRR?=
 =?utf-8?B?UFU4K2gyUndvT2dDSzVFK1JiN3FGWndQZUd0K2NqRXE3NkJJcGR5NkJKaFZW?=
 =?utf-8?B?aThRSGJ0S1RNZEQyOENwWitZMVk5NWFEbWdEOUlrMVd6WmE4SE41UFhSbHg5?=
 =?utf-8?B?d3FLVXNEZFRLMTU3MkpBSnorSVdlejMvVjFLREtWdERqVzRuVlpwenV0M2c4?=
 =?utf-8?B?eFV3cmliaG5RTkM4eFpUc0lueVJab3RVMElFdnovMFdYRVJHcnpPcTZrNHYz?=
 =?utf-8?B?VU93WnNrVnNQazl3VTM1WE5nOVRseW5vdkdSTHY0MkRwL1k0QXV0YjdmZG05?=
 =?utf-8?B?ZUgvM3o0YUs0MTM1bS9BYUhqR0JOK1JubHovYVBnL3ozTXlrWEhXLzFoaCsx?=
 =?utf-8?B?dklSUDdXeUl1amV5NGpWenFYVEQwd2EvWERocGtsZ3ROL3Z0cUZVMmdFaVpl?=
 =?utf-8?Q?UadjULrKYlmS5xAfjVuwwByzu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d57e5c46-27ee-457d-c9bd-08dc0199e3f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 20:26:04.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH9kZtt9QGvgLn68Z40Hs0BHUa70OpTjPwfqIjiFb+7BpTs9QmMOyEit+32kJCIZQQSixWB/nNczoWmS+Cz0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com



On 12/19/23 09:44, Jonathan Cameron wrote:
> On Tue, 12 Dec 2023 12:30:47 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 12/11/23 02:06, Brice Goglin wrote:
>>> Le 08/12/2023 à 00:31, Dave Jiang a écrit :  
>>>> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
>>>> region. The bandwidth is the aggregated bandwidth of all devices that
>>>> contributes to the CXL region. The latency is the worst latency of the
>>>> device amongst all the devices that contributes to the CXL region.  
>>>
>>>
>>> Hello
>>>
>>> Which initiator do these bandwidths/latencies refer to? Local CPUs near the root port? This should be specified in the doc.  
>>
>> Currently I'm only storing the numbers from initiator pxm 0 to these targets in the hmat target list. I'm open to suggestions as to if a different way would be better.
> Nearest node with CPUs would be better I think.

Is it possible to discover that? The SRAT MPDAS structure indicates the association of initiator and memory target domains. But it does not seem to make such associations for generic targets.

> 
> Jonathan
> 
