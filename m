Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D548CC5
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN2igRU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702672417; x=1734208417;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKS9hMMaGKap/lzamNq7BxWQKRHD+TXc4ySmszjvb5k=;
  b=RN2igRU+K3GarrACMlP2X6OcWh0e/rPs9zVkVGoPR7lQaP8uFmw87zyq
   amw88E1fmjnhOzuNaS7zM16kE6dC40IR4vY35MdkCIpKSscY6TP3u0XAl
   MeDIK1GyW3bO/q09SFBQj+4rxpWmTP7bfdpvS9cMIbV4RtBCuDlyTL1dj
   HsKR1O4oVGL5svH1hVCxfnD+PClGjYaDnravHyENKMI1WpIrpPAAPa2/8
   YOmN+jFRwfJMI1LiirpWlJrJoVVUEaU4tUO4E5x4qeDz6H+LUBzOdbyVL
   pnX74bd0w4SfpKYq/oVY1/IuBorOcgqEUKNth5nd3atBDonvk1JixykVU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="395064174"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="395064174"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 12:33:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778390827"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778390827"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 12:33:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 12:33:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 12:33:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 12:33:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGATkUUClDfc6J8rRnG0FElJy6WNjn1t4VD2VP6KQE49ZlO892iPhyqJ/kwmGZL86W43kmpfkAbaXo8ZA6P2IQ4OiPLEutRfdSNAU9IWBlb2d/akql28WxJ4udy278clvimHGDYR4GxGNnZWwFah3oHUDIf2PWGwdcs+FFNp6a1AuV5r8+gsIsMUs6RirYr0BCrgH613bJocpx8PHvSoTopvoEdH83f7IYoIzu5O/TTj00hHPfPy5NTp2xc0bw1vXb22Vg2v2rCjdOdi86VstNHnI9VoLuCJEkv5gtpLv7/vkzAoKeCw+qgKzuJcvLbFp/jD5hoGHgdYlZh8Tb9LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIuLjbjD3124/qPtK5u+2oZMeVM83ks6u2VgkH3bMqA=;
 b=GBH5pQWmptlA2EbbHwVUCdjkBZ7aMbesbtHTCxmsMFzJmkT0xvv+r9BWfAsElTTcdGEPa+K1MNz20AMthZsXCskJkhzRqQNxXue62y8OrtEt3IZxqF69r133/UJHyRPczoJggnGZJEK1CTkTWRHOQhVuhGFwNBOXbsHV5JaDoBMj9Un2GsPdkSU8yPiN6UH8FEOvSBmOqCt7s+PKO/CGcp5n7h18jiZ8HTuFT/0PULwYy4N+r21yFH+IgFKFD35Odv+js8ZOa5N6ShJKakSIMKmPAvsblHdQcq+Igo+scsNZd+VI5gzhJi/fJePbVHrWpB/iBxC1CBIauhbuiEcXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Fri, 15 Dec
 2023 20:33:32 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 20:33:32 +0000
Message-ID: <2a2eb846-7e94-4e95-82d2-2187017b6d85@intel.com>
Date: Fri, 15 Dec 2023 13:33:29 -0700
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
Content-Language: en-US
In-Reply-To: <170248578991.801570.9475995004555750065.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f053b43-4e60-4778-f9ce-08dbfdad1a86
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKgwGGc6xwuXn6gk8Oh8ZPsQeBJM4U2+SGu0oTXzPOGHzr/YPQTrU7IWMRwTtXdALoYJ3NrttxmG7+Ymt6xTvIyk7kSqsR1GpzGNyk+XVQtY9RlE7PAWCtRVlRUif4SBK8jLJBQ7HJ2WssbQpQu3PMp+TCzoQmemeHyh/QFO5CJ80UPa7lUaVWgnxogUOwnDfWfu0Wc3h8Bdom8EvW7gGFD43YW05Zkx9/IbdMFsxvAXnWW1QEiTtXoacUNAgTU79lVogBZrfT2EWKL9QdxvNHcM5oq47nNMi5CHWRxh0dREdZihhX6Q24f5Gc7a2hAH91ZhwGt7noInB0k0Uv9RiC+yFpfJVTb8dRfMusO2nWC0mCNbJNu5zZo9jBEAnQZPPv9xJC3WQBKXMmYIhANwE+dKqUhIDkUHTEaDm1vRi893q5Af72vxGTuH88WUIab8U3TLh6t4x8ErC9FpUTljpJmkZfzcRkpwN8HM8K5NmGX0lkh7C600kRTL12j5KSnefsgbp9ViJjbOwYgYg6OIXVnvkghFVYFVrP+1C0FUqgUDSHYidAyJLqQTLogVEUAp0YYb9z8SMFXYJORz5hmICCxcRL5WAUgLSEt+5CVWJbw7BWdTlJGiHomFA/xsxj/5OImbeXQS30Ml9gfIo8+4rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(8676002)(8936002)(316002)(6916009)(83380400001)(36756003)(38100700002)(86362001)(31696002)(82960400001)(41300700001)(2906002)(44832011)(5660300002)(2616005)(26005)(54906003)(6486002)(966005)(478600001)(6506007)(53546011)(6666004)(6512007)(31686004)(66946007)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmc3dGx0cm92LzlvSHVqOTJaaVB5VjFYYWRvcGpMVVNyNzJZVWQ3cmljUlhG?=
 =?utf-8?B?RUZwaVFaeVB6MWRnSTFNaXZCRVYwT2NrekVnNkFPRDhGV3Izci9GbTlOVENN?=
 =?utf-8?B?S29xZlN6Q2pIV0NZYlByS1R3eTZFU3RuVUROTXRVeW5Sdk9vMHphZlFkRGRq?=
 =?utf-8?B?WGNqNjB2L2V6VHVGWGdBRVVwZXlSaWdtMUVaZWlMVnp5bWFhcHVPRjVTSzQx?=
 =?utf-8?B?UFRnNHBTcFhWTDkzOE45dEZiMDE1aHpqcjJTNlU2Y1EyS2NQWkhRNk40N0gw?=
 =?utf-8?B?OFBLM3lZVXFJNWtGcmQ5bG85WDd0VThldHpDRjRxbWV4dUxwajd5NXZKZGhr?=
 =?utf-8?B?eWNlc3FGc0RjWUJBQ25EOTdVMHJhb3A5WEtpZXhPQWVjblc2bXpwSi9PcVRt?=
 =?utf-8?B?OFNUSzdrTUw4UG1kWFpraFFUS0JHc0M1R3BMVmZQaWtQeFJtV3FQQzBKaFZx?=
 =?utf-8?B?Lyt1U1FIS1ZoRVlRM3VUc0VqcG5UTUU0UVhQcmRmNi85MFZtYTZpQ0xma0NC?=
 =?utf-8?B?aUJJQ1NzTlk1WitjSStaUWUyMERSWVNHenpnRU96MW1ZSERZV1FORUtUcGZZ?=
 =?utf-8?B?U3NDU2NOdWVUSTJCdkhqTXRQVWxDMDR5UENRS0JsOHBvOU1wcTBrMnpnTCtL?=
 =?utf-8?B?a09zSWtHNS9mcWNqQjd6a0NIK1Rzd0Z0V3p6cXpKc2FmNFVWR0RnV0RmeFZK?=
 =?utf-8?B?YnZ1M0lEbVM2TklZakM5V1hpYkZ3RFI0QWdXMldoNk83QmpoR1J0Z0Rnd3E3?=
 =?utf-8?B?SFg0bEVzd2EvL3J4aDhhdWRTSHlISnlZdUFtL2lmdnZOUDN5aVdJM1hweWdm?=
 =?utf-8?B?bDlWN1JiM0szNjNJcW5jd0hTMUc3QmplUU5ZVUdPTW1sRmZaWlNTRC9rZHRn?=
 =?utf-8?B?cEoybWFDZWZjTDlJT0YxQmxVbHdKb3NhbXczbE5VcjlteCt2dVltWkF2OGtw?=
 =?utf-8?B?WGJGcU1yb1o1UTNPQ0FLYitSNW55Wlg4YWZIa3lGajU4SFAvdDAwa0I5aURJ?=
 =?utf-8?B?SC9aUGxBWEJXU3NKQ0xzT29Xb0QzZGY0b2c1QUZ5YW84bzAwR1ZlZEQ5OXBE?=
 =?utf-8?B?OFpZYUFLUXgvc0NUV05ld3ArS0Y1bDJWTWl4d2NsemhIdnpNZjBJc0VSNjJY?=
 =?utf-8?B?TW9vZnIwaGJiTFdOZjJRRXIvUTZPaFF2MjZabFhxRGhQeVVhcEttWlc5OXRz?=
 =?utf-8?B?cXJnUTFRZ0lpMjBsSUlrSEVzZFhxMmkyRXBubUw2bXVVQVVWalYxL1E1NkE1?=
 =?utf-8?B?RWo3QTdFeVB0c1BpdkpmUlp1VnpNQW1WcGxWdmZ6aG1yNHhOVlRCcDRkZmlx?=
 =?utf-8?B?TWhLUjdkaVZGZ2VnY29zTmtBR1ZiZmYyRi9HZWNIL1JQaVVUV2NUT0lCaUhU?=
 =?utf-8?B?K1VLYmtoYTdkelhnWjlzVlRCbUF4L1FpZDJhTkR1MEtuSGxSSVNEdG5tNTla?=
 =?utf-8?B?T3JKRldTTlk5Q2FiOWNHODRSZWx6cCtjR3l0ZnR5d0lpOEI4SzdMcGZ3RkJD?=
 =?utf-8?B?b0lOaHRrVVZZMEJQNWpoUTdCaTkwZnhjSFhneE10TVJDR3RZTVdta0xXSmo3?=
 =?utf-8?B?OVJ6dlNIVVJCbU9kb1hXbE9kM0ZQTkVINnlhd1Zsb2Y1RmlkZmFEY0lKeFNN?=
 =?utf-8?B?Z0RFR1JyZUZJMHVyVFZFWFovQ3owSGY1S2RjR0dRT3FkOWNNbTFuM0xEVkV2?=
 =?utf-8?B?aFFUTldaK21tTHpLbGIybjFpbWZpdUhLTzlRTk9DYlE5YjRhY0cxZG9RLzMx?=
 =?utf-8?B?RXBISFQzRk9FZ252aVRLTVBIZ2VPZklDWldpNE1pY3VYZi8zWXlaUlhBSEE3?=
 =?utf-8?B?R2pKMm5MSkxZVUZLNS9YM1VKblhxREQwOXhTaUV5Y0E0UkZock1KeHJuNEVh?=
 =?utf-8?B?VFpDTG9vRFdoVGtiSUQ3RWtMcGt1WldMbjZpQ0RTaEdWSnMzMGZFMUZEWWM2?=
 =?utf-8?B?emlzb0pWTk5IcndHbkN0ZUxhanJ0VmdsNzB5R0psUE1DUE5FM2hscjIvclJk?=
 =?utf-8?B?SmJIU1FjLzAvSVVrRnJ4WExoR2tmRWw0K2lZcmtpdi8wR2hISFcwbDM1RDls?=
 =?utf-8?B?VjczUDhyNnpUUDZQMFVUb3ExVEc5TTZOdjhqbGs2WmVRZk81V2VSRTkvTU5D?=
 =?utf-8?Q?Pyc8S4jjHoefa/WKiTniI7sgz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f053b43-4e60-4778-f9ce-08dbfdad1a86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:33:32.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNGF11H8s242uOUalmc1PGIJ9VRpQOQmZLV5FsPmsdP+xBw8qk9aXPCm6Ls60IMpgIxjDtMPajhcS2H4tJQbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com



On 12/13/23 09:43, Dave Jiang wrote:
> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
> should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
> partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
> partition. The QTG ID is retrieved via _DSM after supplying the
> calculated bandwidth and latency for the entire CXL path from device to
> the CPU. This ID is used to match up to the root decoder QoS class to
> determine which CFMWS the memory range of a hotplugged CXL mem device
> should be assigned under.
> 
> While there may be multiple DSMAS exported by the device CDAT, the driver
> will only expose the first QTG ID per partition in sysfs for now. In the
> future when multiple QTG IDs are necessary, they can be exposed. [1]
> 
> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v14:
> - Move attribs to dev_groups (Dan)
> - Update perf_prop_entry to cxl_dpa_perf (Dan)

<snip>

It's missing 2 lines due to rebase:


diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 5699d2c7d2ed..9b37a842c7ea 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -285,6 +285,8 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 
 static struct attribute *cxl_mem_attrs[] = {
        &dev_attr_trigger_poison_list.attr,
+       &dev_attr_mem_qos_class.attr,
+       &dev_attr_pmem_qos_class.attr,
        NULL
 };
 
