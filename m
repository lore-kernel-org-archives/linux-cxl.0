Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B324B20
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lE2A1Zic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704384760; x=1735920760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2mL2adhV39m1McAj6YGUUAlzwFrBZwLDHjXll54BpI=;
  b=lE2A1Zic1kEbRRTlvNmmLU37639J29fL1GkYcUc8Souxnzo76aYYR2dY
   blCivwFzqtD05KF5Qpu7nQWZXuSCItQQzyX+erElVMcomY3plh2uZDudn
   yh+NNVGDxl9pLxSSWLcoO2pkmhHtsJFa7/btoG3hD31sDM75jsNBIeZUh
   FhloFnzfxKo5uUIWt3GsWc8qdU2RA04DBcFYCx44afmWzZPNQLN6JKHOb
   SBUv+1Se2LZ8Xk158ontST+AanSYruTxWHuPQ4Cw+X50XjMURCpL/NUbE
   C9KLudo88/KCORZUZJHFOQAcrLfh1IvvBSBluMI+AikuyfykL38phDOV2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387741045"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="387741045"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 08:12:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027490081"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1027490081"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 08:12:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 08:12:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 08:12:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 08:12:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWt0KhMI5QsKeTJiWlmkPd/h8HwgsvsOp2i/+vl/7jOSh5CZelz6GPpptNIOpWlWa6RtpWmgQAgMoysYreEtxu3BE3d8kwjcgNnuW8u8yFKaV/xfnFQ/Ca0tdF8n4HnSmwMR7AMWlKU+8BhKq3o0xCQRBwjn0edpZLeHmGG0BbGjaAMcr9lgotevNggviKEy4d70VqxYblSZ/lVtiQeKP6hUTPw7ZEaRw/jpM9qaA5rotGK3s8lwAeM7slpc+DDQ4bobnrDjRubS6L/1PukEGzjnvA626TGfGlxx0X30j7hcP77kEI71I+zIaatwVnqH0ZNUnxJYDPyOGRqxe662Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnYnsarLw2tkd3HlLP64aP0SyPh8KkHe6v8gAMKlSt4=;
 b=hY6k5D9vnUnQ/W9NCnPfPKlp5/IirhMTQKt9gZUfcI2DugTYcMR62yy29YDTzeGxrv8697LBr3bL4zSeNCUOhHHprNSqoorAk16I3hm6kwLV8Zs+v4i25ceklnwlvoGGMFTuTa+egtk67SJNVPl/tc60p0stlRJyx3LeUud+7FvGwsOXJdLljOKk+1jMSYNBjWX485qObEwIedSmKHEdbIFzd1VyBRmJgJNZOm2urNGliQTXwqp5NLyw8qCZwgqf+wR2etlaazkyEvnNC9BmFkkN2reBokLtfHKF+KWTyWfQf2SOznLZs+7DX3WUHnsWW+cszSA+VySS3d9WR8CfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB7812.namprd11.prod.outlook.com (2603:10b6:208:3f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:12:30 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7135.026; Thu, 4 Jan 2024
 16:12:30 +0000
Message-ID: <8848eea9-2dd4-4595-8b60-9966692fd927@intel.com>
Date: Thu, 4 Jan 2024 09:12:27 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v15 19/19] cxl: Check qos_class validity on memdev probe
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
 <170319626313.2212653.9021004640856081917.stgit@djiang5-mobl3>
 <ZZawa1FIpYxcyW0O@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZZawa1FIpYxcyW0O@rric.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 474ffad2-ac81-4d5b-be9c-08dc0d3ff39e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzUplhBttIxiy+d23qj/Bhje6l4BiZyZpx62yIc8HyJ7kMqDAAJFib7ZdgN+QudY4PDt/g2tUseNX9uc0wWFH/Ll43zs3A8s+R/tC0VyVAkOy4PdcqFxLM8bR/vQpZkMK5JiQUzAs1ccdH5hvf2Juy+EhP7J8hcuJsRKkYAXwfiNZYAuxHY1sitBSM3AgbWxH3DWXXqoxfl3aiUnv0icI43LcXkeRW7seEJ4m4e08N6thJb+g4oSP788iWgtRu5U4rQwSb8Ff/9JQDPQ2ykH0pyzq6aM9RDu3Jk+Bc2LRqKtNfI8OefuSw+So7izsotmuJrzkj/DdAaLQHe8KKBzT/33IXpiotzLMMaeYNM2GB4bVCBG7IUE2acmmzSAYEKwM1cjgEW0//mpxaFxYnyRuVIQ2q9aPfbrHbdRs5WrPsAKXpoHlkIluFWt0QJ+d2Amtrs9Kv/ERpVk4hHMwCIZ/CZw4cOmQlxcZHE6WA1G4SGwiNMrWjhfZ5oQfyn3rYzDUA5LRwxQyFcRo2aiQQCnZEIwi/my0g2W+/zD4oHITYaSDwFsGv5NRNG1zrUP08v8c9tywhwXOcN+YHmunI0I7r4eadgmGhaeUnXzcFSFmZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(966005)(6486002)(478600001)(6916009)(8936002)(8676002)(316002)(66556008)(66946007)(4326008)(66476007)(83380400001)(41300700001)(6666004)(53546011)(6512007)(6506007)(2616005)(5660300002)(2906002)(44832011)(26005)(36756003)(82960400001)(38100700002)(86362001)(31696002)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lXSm02SUZXQWFCWUNBcDhCOHI2a0ZNOUs3N2NzckN5TjNGckpLWm5FZUVw?=
 =?utf-8?B?Q3h2YkUvaVR2SHRPZFE4d1pQRGkyMHBzUzA5RTFlYWF3cFdzUlp2ODlIK0t6?=
 =?utf-8?B?UmxRblNUMXA4VC95Ym9uYVRpM0VvWFM5bi96VDkwMGxpZC9Ja2U1WkdweHQ2?=
 =?utf-8?B?NXRpSEhkQXpwaVRHZUtnM1lUUjA3UUwzVUxOaGtPdkJXTUk4STIwUmVFTjR1?=
 =?utf-8?B?NE5UZFR4S0xKUlNlZkdPcncxSjJHOWFsTy9mZHVBU2k1b2lqS0h5SG42ZXE4?=
 =?utf-8?B?RUR1UWhmY0l4K2paYW1lcDFwWnd1d0dyckZXV1dTRkp2ZEFBT3JJWFFYQnp1?=
 =?utf-8?B?bjg3ci8yd1RVNVBWaWZFc0ZsNUNUVUc2RWRJd0FxalRRVkUvK3BtKzkxajE1?=
 =?utf-8?B?UUQ5THl2ZXFZUE0xT1ExVER0Z0JoWkM1OTFGZnp0bDlyL0ZUTXU4RXJxWHQr?=
 =?utf-8?B?UHcrbTdBZXV4amJHOW1qS3ROSHI2TmR5RFhiZ3dlSjVwWkZNSG9DekNMN3E0?=
 =?utf-8?B?RWU3eW9vVWRRdzZ0d0lDbkRLRU5PR253WnlrUSsrSHdQa0IxaWF0Nk1rTlNt?=
 =?utf-8?B?ZkhBaHdGRFdNUlZBajgycnJKOTByeVFDR2Q0VVRzZEQ2SC9URWtPSHE4U1RV?=
 =?utf-8?B?VTk0Yk9oaUlwTzROWm1sZ1Fsb2g3K2ZEa3NhdnRjZHZLdklTTjJhRXdWYkJZ?=
 =?utf-8?B?OWhYWWE2VGdNbUdFcHRVbTRDMnZhb05jQTdqamNvQllGdkgxREJDKzNFM0hX?=
 =?utf-8?B?ejY2MTh0T3h6QXNCR281U09JcE9uaGRUVlBta3lURTJCYm1BOStXVGxwWmNG?=
 =?utf-8?B?OCt1OFFuZ29LNjBveTlxRk1sZUY1aTIvTW91Ymk3THNsRU1pY2QwU3U5REdT?=
 =?utf-8?B?eUZra0FJdS82ZkhHSGZ3S2MvSXJnaFJsc2RPdkdiektJVkRka0FJbFRFZU52?=
 =?utf-8?B?OEtWTVBXV01TdUxWQzdvbUxtaktnbHdTVXpVTHlPK3JlT1lDdGZVV3pocndq?=
 =?utf-8?B?aElDWEY0aGhtWXNMeTY3TTJqY2k3UFJxY0ovR1FFME5yUEc2WGoxTHRUeUo3?=
 =?utf-8?B?WWlWdjhTS0Jnd1ZVbUtzdkdmcjg0eHYrdHZsOVVObldRalZsU3ZVdW5ZRU1C?=
 =?utf-8?B?dHcvbXVmczhvNEZJK01UOEtPZ2lqZElESDNPNFFhbTZXcG01SnU2cnRHWjUz?=
 =?utf-8?B?cDcrMitUMkhlSU1UOHhmQ0F4djU3TzJIRXBSZjhRVlAyRU1ISjhZb2dFVjR5?=
 =?utf-8?B?Y29xMFN0ZVBKZEFaT1YvYnpabGd2WkJrdnRISVZvTStzV284SllGY0FtdGl5?=
 =?utf-8?B?MlMzNEZST0RPMzd5U1dQRERrZndOWUNYRE05OFRxYTJjbWFZZmZTUDFEU3lE?=
 =?utf-8?B?K0I2RGVXNHo1YVFrTlhXQmxnL0NXcUpiSHZOWE92M0tzMDUxeVM3Vjl5c2ow?=
 =?utf-8?B?WUxWUEU1bWgzUU9XVUtCVjIyQnRVUGlObFdUcUorY1ovRFd6TVB6K01qbDBx?=
 =?utf-8?B?QitsdDRDd0ZtajJTOEFwK1hSaUJGRExucEJnMTMydGtrbVBsODZyTHBxaFZC?=
 =?utf-8?B?Sko1bU5HQU1KK0paVjhTTkRXMTZvV01SVGo4UkR3SXJuTGk1TUpVWlZEbU5u?=
 =?utf-8?B?TXBDc2xQVGEyNE9nWkFJUHZLWFU5Y0dCRXBmdlRaSzFBUmg0SjZRMGNDT2ZI?=
 =?utf-8?B?ek0xMFlLYkppU3dSaFBPa2xubUhsc25JUmdGeE5Va3MrR1pyS1FCYmpvT2w4?=
 =?utf-8?B?bE1xTnJYK1N3T1RwU01YSWhnaU5pcmJFRWFFWjA0akpBVERJRGNPdzNwOFow?=
 =?utf-8?B?YzQ1S3NkbTNFUUcwMk5mZEtXTnNIQVVBbXlRcjZyM0ZaMUxubVI3MVMzVjRp?=
 =?utf-8?B?aEY0djBKdmxCTy93TnhZWDJlU0J6R3lsUUgyMWV3aVN2VkxYUWVvTkcyYTVH?=
 =?utf-8?B?SUkvWUhSdzVjcmxkWTRLcnJVMmFlWU5ZNXZRRVJXZHJuOG5mZHd1blRNbVhY?=
 =?utf-8?B?YVQvaDhLSEUzdFlGdUZWcVhtSFZVWDJtZS9FVFlCa1RSRnl6K09wV0lYcXlD?=
 =?utf-8?B?SUFCNXl3d0pYWWlDOEtOcUd2VndzVkN0Q3hCcTRhRXlaTlUxUUgvWHlYdW9V?=
 =?utf-8?Q?Osval1u8cvcxuj5L7lY8JaCzU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 474ffad2-ac81-4d5b-be9c-08dc0d3ff39e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:12:30.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT9JfItZOaruvFz8iPiU7U4rHK//JOzcm249xkEV2WJfv2Bct1JaRp25YDiOgOGoBOuu1AK0YhKP7XiwzFdKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7812
X-OriginatorOrg: intel.com



On 1/4/24 06:19, Robert Richter wrote:
> On 21.12.23 15:04:23, Dave Jiang wrote:
> 
>> +static void discard_dpa_perf(struct list_head *list)
>> +{
>> +	struct cxl_dpa_perf *dpa_perf, *n;
>> +
>> +	list_for_each_entry_safe(dpa_perf, n, list, list) {
>> +		list_del(&dpa_perf->list);
>> +		kfree(dpa_perf);
>> +	}
>> +}
>> +DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
>> +
>> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct cxl_port *root_port __free(put_device) = NULL;
> 
> This one was hard to follow and I hope I am not missing something
> here, but isn't that finally calling:
> 
> 	put_device((struct device *dev)root_port);
> 
> And this only works due to:
> 
> struct cxl_port {
>         struct device dev;
> 	...
> }
> 
> with dev being the first member?
> 
> This black magic at least deserves a comment in struct cxl_port.
> 
> Better have a helper like put_cxl_port() or so.

Thanks Robert for pointing that out. See if this makes it better:
https://lore.kernel.org/linux-cxl/170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3/

> 
> -Robert
> 
