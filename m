Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23216F51F
	for <linux-cxl@vger.kernel.org>; Mon, 18 Dec 2023 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yfb6xKUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702916899; x=1734452899;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wwgghS6nMcshj5YhvHCr+4swuY1mItpjfPo6WQZme64=;
  b=Yfb6xKUDMMaUExuquhN7MegnChTe5jRKDST931Cetrt26oLAobiusRui
   niT6THhWfESRmCFQ2PhzAm6y+joFaxQiFlVrwxhLD6jTBo6F8Dqn9t8Y6
   gZIE0VNX68cHHP3UxZv9zcO9uEQwKn2H9do5zL01bPQcNNSWiZrffFdfs
   io/AFyyfplovHjak5ivZrFbntfPy2MBucYmREnURqKuHaV3fDgVUc4qGj
   /xpW+aftjC32I/arUxybAxrwSC/NgM++a2gJi+FhLZAAYkL6K5uFSdSrz
   yPmgu/Z/pO5iMHEbAALpE0rMOCgzR8XVj1tHn7B44+8Hoj4CrKgdkqPpz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="385954184"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="385954184"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 08:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="948828376"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="948828376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 08:28:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 08:28:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 08:28:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 08:28:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 08:28:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcVRKcB3NZs8D0kxN9yzshTJ/2JPTN1ucTSmI2L1X02g/Oh/hMiP9ATnyuN3UFcuJPtPkJAOW4/V4EJRsCpLSOftMaOjpJO7Uyrd4PnCHMaBlPBFFmHbHTnCYl9l9NMwrMnakVCtkJQNfY2SiMU9FY0Z7ZRa6qAi6lsjOgbwo6DWkpaJbdOoi5gEmeKQoJwPZ/NZX8lXO0jtXMqVGzrpMIAcSh70++gxumyIqdJ8i3q1CI9ZdwGCaqvZSK/Adc5MgAa4j1obP3f8owGkDi5OiOEZwxAHrf7q666c3aE51NQOuieDT8WPGI7SjG5V5Hd/4/GBCgs8xSCAFm5aDVJ5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP6qbqnzth+2BNAtB+wKYUt0WmDECPszlo7T8T848sg=;
 b=JCjB9Pa119Zv17uaS9uPKhzaqtlIFEqiMeuASfYStKrlJ+viPZ9b3CHs98PdKLRJogarn1M8wHgFtHwdnsDNSqMfIoEZ7j7KfZZ+v5Mj3y+bgfDSKT61+88+SIPi+NuVm3UdFYWpBnaapMwbWTPQ0MkmPuHSzXwwJtT4Af7mUasYbxq1LHY1e6McOGGPBZlCYc6oC6Zk/8IDoA2Ey6pgnx0jJ1vgv9QN6cinFiOCDn6syUT27RXJ4sE7OPR7Srq8jNYPV+blCea+En5Xamd5VFdwM7Go4eg5rejFTfjIW1JzALKO1wn1+IboEaHPkORjAREy26mv1/XlR29aQO3sKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:28:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:28:09 +0000
Message-ID: <b564fba0-0390-41c3-adb2-27ac92fd8cd5@intel.com>
Date: Mon, 18 Dec 2023 09:28:06 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v14 18/19] cxl: Export sysfs attributes for memory device
 QoS class
From: Dave Jiang <dave.jiang@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
 <170248578991.801570.9475995004555750065.stgit@djiang5-mobl3>
 <2a2eb846-7e94-4e95-82d2-2187017b6d85@intel.com>
Content-Language: en-US
In-Reply-To: <2a2eb846-7e94-4e95-82d2-2187017b6d85@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: f080b43b-86bc-46ef-2dbd-08dbffe651f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwHy3vOEGfycb5WJo9hZ4llFh0+pfe5z2i+Pkip6R3s2buClqUVv19Bfb2w7ri3j675QQXV2BFI/h79VSnnlFGWekNuGqoLEiUD/DVRyxdEZfknss0RvUAdvPHUQDe0Np/T18RQHHZGXavZZ84/m87xt8jY8zmjGY6czbGt16MnECtfRQIe8eSHP0f9wrmq9N7/gnzdu6iiLLLwSVKA5GNuIAQ/lo9RKQzqXWlAoCmjCRrnfeWpJyYhk+rQwNQSpfL/qbqhBoDQyAbRfxDq11TuLdqcSka5hMlOdV9OxbVVi0KEE38IC+zXNREeO5pjzQDi/wWxzr5Xc+bfaHCcNofxJ1nZ7oYbZSAtiP505D74ZWMUIOtcTlajPvUy0OtyWh0JxA6Q+vWWIJuZF9AUD5Kj67rQJJ265GLaeHlQ/Mz34+xPu2+3G2MlNjl5Uzt4p2kGnWt8ZSqTnCufhGwHx2KJqRHYDSG/SjSm6h3zSS9eDdF3kCL8s+9JGHW+tYluaX+yIINLAe4KBwhLZLjn1Cub7IhVzQ/qW3s9Yrf40B41Ro7t8FxeXdRNlZXB6UlONM9QIJa+aGktdAtSWXEjN4SsVqxIcqUU2kttruBW8GfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(38100700002)(86362001)(31696002)(2906002)(5660300002)(2616005)(26005)(83380400001)(6506007)(82960400001)(53546011)(6512007)(6666004)(966005)(6486002)(41300700001)(36756003)(6916009)(66476007)(54906003)(66946007)(316002)(44832011)(478600001)(4326008)(66556008)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhMbXhSVFNCWGxTS0MyYmprdTNFQ0xqb21QMW9UanR0SVZ5U1g5OWZtYWww?=
 =?utf-8?B?R3dZbEhYa3NrbC9wejAwcCs5a3BaRzVnTytPTUdhQksxVkFzaXNrOUV1ek5O?=
 =?utf-8?B?VHN2dGk1MGIxVi9vSFYwcWpueEtYTnBWZXI4aXUyVVl0UGhqeFVySmExb2xm?=
 =?utf-8?B?WWIyR2l2cnEyejZUQUNtZFUyVGNwc0pPckhtSy9VZWxHS1ByeDRqOXd4WmZD?=
 =?utf-8?B?eGNjSlpkYzh6dksrS05NeTFWS3d6M0drbGdsNVgrTC81b3dxYnRQRHZxQ2d6?=
 =?utf-8?B?N1NYdFJNd1cxZ3h2QXBocDBxR2dnYXZnWHlhQUZlMVc3QkxvZ09sbnpiVjhh?=
 =?utf-8?B?VGpwd3hTYlI5T2F0bnNkQVFFTUtoeGFkV2xCWXVoVzNreWJaNGFuV1kxektN?=
 =?utf-8?B?U2N0cXQyUitadndHeVlGZ3dXVGlQY1o0VEswTkQzTUtCWnZ6Q2NjdEMzNGJl?=
 =?utf-8?B?VDlOWkRCT0RiWWRSbDRLTFpJdVpXQnVkb0g5M0NzczZLaVluZi8yWDJkZFRw?=
 =?utf-8?B?UEhldFhZNS9TY3lpMzgyUUl4elU3OHZ3Tit1cFh4bm1SeTJ2VFkzYS9IU1FT?=
 =?utf-8?B?NUxCSGx5ZDZPaDJuNjdTMlU5T1FaL0xEV2NlajRvN0o4dHRCcFNEY0hBYTBN?=
 =?utf-8?B?Z29CM0FlR1FBTzllUzBMNG9rWjd5QndDaEY0WVdVcStYUGRaZnE3QU5sdVpt?=
 =?utf-8?B?WXRXTGlFNHlGRVJ5dlhTQ2tXcnNhSjJ0Y2lRc1h3ZE1zNEJtUkd2dldxY2FF?=
 =?utf-8?B?KzlSNy80TWNLbGZBZzIwdVhURVNpMFJMYUtBRkZWT0IrYldERkNNQmsyMExz?=
 =?utf-8?B?eVdqNm1ER0MzZVBpRTM3SmVuR2xmdjNCVmtseGFvTjZzSXM5VGF4OGxxa3di?=
 =?utf-8?B?TlNIRkpDYVpWSmpKWk54MkVtaXRWQVIwaWdPMmJ4UkF6dWg3dXFDRmpheUlY?=
 =?utf-8?B?ZVpmQllOZWI3bjYvanB0c0lDcHY5RU9mWS9aaHI5WDUzTFQwVUJybC91dUtk?=
 =?utf-8?B?Zkxkd0ZWRktLa2RrWDdHeWxMQzlSeENYdndzUXB6N2NFanJ2RUsrN1U4elBs?=
 =?utf-8?B?V1dJTzZDck8vb0YxblVnMkdSOEJFSTlYVHJtZkJKbnBjeVRaM1RhL1FUK3lv?=
 =?utf-8?B?dnNRQ2pKdXlsVlh6MU4rSGRKSHpJT2pJQjNBVklZNVMyZnVrV3JXcHBGb29O?=
 =?utf-8?B?R0VvRi9Xd01nQVZOYWdMdkNJdkhOMjhodmFtNGZVU3FZZlc0UTlaTlFsbVFn?=
 =?utf-8?B?eHNMTENlNFkzMlIxL1VHK3E3NkdtODZJM09nZ0NWc1lYaFlzUmVSbUFXbEd1?=
 =?utf-8?B?NC9xMHdXUzcxMTVJaTdKS1dQcEIzUWVpRUcrOUxkaFJpeFR4bkd6TnNnckdu?=
 =?utf-8?B?dzR1TGFMYW8yZ2hONWFkbTB3K05lc0hJeWZ3QVJuVkkyTUlTc1ZINWJ5UG1V?=
 =?utf-8?B?Zk9tUzh4R0pTdVdsY2gza2NFcHlDcEVFZG9Cb1VpU2VQaXk0SmNPbXdBeEtm?=
 =?utf-8?B?NzlrdEduV1BuTUZzaXMySU95d01XR0tIMGxNR2E5S2gwaTQ3RHhuUHM5K3BN?=
 =?utf-8?B?WTB2bENDK05WUmlBa050TDhVQkJMM3BwZU4rU2NPdzJGR1plZ1d4SEhXMWRu?=
 =?utf-8?B?N3VJb2g2SHJFcWtaNDZDbXRRbmp4aWhxWlVja3l2SFU3aHc3L1RMR2RLM1gz?=
 =?utf-8?B?cFp6WUs3bXl2M0d4OCtCTUR4Nk5IcXg1dURxOXlxTEJiZ2cxRDQzSnUrbGZw?=
 =?utf-8?B?TXlSY0JyNXpSZzZBVGk3QVgxWkpEMGZWZFhxUm9hbmdJcFpnMGZlTE14YWl3?=
 =?utf-8?B?RytmMVpUbnlCNUxNOVFTNGYvT0orZElnM0JSSXlhbEsrZGl0c0VxbWM4UWI3?=
 =?utf-8?B?SXR2WXFIemRoME42TTFMTkVhdE1NbHJhSUZpTndGYjFwZkZlcDJjMCs5SzN6?=
 =?utf-8?B?akpKNmw2SGQ5T2I0VzdlZVJtS1E0TW9IY0k3ekhFd2hQTGlmT0R2N3gvYjNG?=
 =?utf-8?B?ckNuQUZVdk9YdEVzeEgyUnBIckQvR1ZQMUJpM2E5SlJDTDFFYWptM2Nkc2sw?=
 =?utf-8?B?Qk9qdHRIRzVQazJ4VHVGQ0QzY3cwRWMxZ1hqYm5ITjRIVzRyMm9XK0ZDVVU0?=
 =?utf-8?Q?V1PrOvI+6r0JiVmTpacapUq3g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f080b43b-86bc-46ef-2dbd-08dbffe651f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:28:08.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8rWOatoJ7FWtmFIjBWqM+4zc4fy8FVGF0RVN+Kf6+tafEl7pJdsiO8ZDjYL1y9orWNzLf2zm5WqncFlAQSmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com



On 12/15/23 13:33, Dave Jiang wrote:
> 
> 
> On 12/13/23 09:43, Dave Jiang wrote:
>> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
>> should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
>> partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
>> partition. The QTG ID is retrieved via _DSM after supplying the
>> calculated bandwidth and latency for the entire CXL path from device to
>> the CPU. This ID is used to match up to the root decoder QoS class to
>> determine which CFMWS the memory range of a hotplugged CXL mem device
>> should be assigned under.
>>
>> While there may be multiple DSMAS exported by the device CDAT, the driver
>> will only expose the first QTG ID per partition in sysfs for now. In the
>> future when multiple QTG IDs are necessary, they can be exposed. [1]
>>
>> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v14:
>> - Move attribs to dev_groups (Dan)
>> - Update perf_prop_entry to cxl_dpa_perf (Dan)
> 
> <snip>
> 
> It's missing 2 lines due to rebase:
> 
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 5699d2c7d2ed..9b37a842c7ea 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -285,6 +285,8 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  
>  static struct attribute *cxl_mem_attrs[] = {
>         &dev_attr_trigger_poison_list.attr,
> +       &dev_attr_mem_qos_class.attr,

+	&dev_attr_ram_qos_class.attr,

Mistake when attempting to split out the diff from the tested patch.

> +       &dev_attr_pmem_qos_class.attr,
>         NULL
>  };
>  
