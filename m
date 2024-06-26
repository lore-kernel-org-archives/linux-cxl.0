Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43761FE8;
	Wed, 26 Jun 2024 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719373212; cv=fail; b=S/drDrBAW8NfVaMDbtWSRDHNDF6wn6hDVMmjEXSvALiunc+6bjAiyCLNleFrb5K7nSPR6k8ficHcOIfR5LV9fk781fzdu+sIU68NpEM4bfWsNcQPjtzcqBO35HKz2L36BJqLq0tq9RNavV6VmASk5h+gLFSiEPns4Wp9dENkuvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719373212; c=relaxed/simple;
	bh=QOzH+oXaave9Rl6d2LVmF72PxzLGcJ0Z4VU5WszvWKk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fibCwveP/Mb0VNHfqlsl+47M3+NlhkBeDogfhZ8NUU0wciKvUM0qny8O853IMSLm30y4OG9DPNR4cGF79Ceh43qQYWKHBc0ZeydbUntKFqU1VY17RYbwc7ozfYkJVIzykTDpwkit+X6Tw8AxWviIgItE+qg22GdGlvvP7I2Terc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqCUX2qq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqCUX2qq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719373210; x=1750909210;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QOzH+oXaave9Rl6d2LVmF72PxzLGcJ0Z4VU5WszvWKk=;
  b=eqCUX2qqun5WyEOghQ0jJ+tsaxEq0a/1z7A+UuelJUa8zgof4Sdv6/em
   2K4hWb0opAPEdEgfDrhFoU1yHOGpR2YtaKTtw/fbZdDmCEyGnGp7KvzUb
   WTeCsR1QBsBX5bZoIuap26LEs8BKmsc21m0PVsomIq2Rh+5og6lJWduLr
   O0MR0S7TF4Dlp31GY2zeC3dU6sbL+PNOl5Bj+CK+hdfoYCmH0pbQFgBpw
   bzCPao+8TmJIk8GqNDx0oIa07CucnVEGvtpdwaJJj27y5pA3BrdoTnjXs
   iycm17XB+8gq1QfeluzgxCXhfdAKXBwrhPalosC1xSo0HDriRulXy0+hu
   g==;
X-CSE-ConnectionGUID: gfdBpA11Sp6tKWocOXq+tA==
X-CSE-MsgGUID: Pk7FxpeMQpyFHpBg/Cp0CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27566608"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27566608"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 20:40:10 -0700
X-CSE-ConnectionGUID: r7spYZW1R0u3Bfrg4SQhqA==
X-CSE-MsgGUID: 2rHmMF0vTfavYwJ5Hr9gag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48840315"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 20:40:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 20:40:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 20:40:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 20:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWhN8nm0PV/QkjJrfM5WbqnNy1u/9AD10emTKeVaEA0Y6kCRkbvuORtzR8R0cSGTY+VjlrG7FfySu30eoR+I9A149TOscAB5q/EKWqlTq7GV2FFOJY3HXpvuz68lY5mTTefuyAL6N8RMss2Iu5Ff+NsXH/SUW/SkPo4+FbZmyDEwtgaVXEHiAgKi4Zs33vXU7wfMNWaJhtY1opoyEy6FdoJ1XQ3m2UpRNJiZhynCPir9IX5ytO//JLuS+gKo+TKV5YVpIsMpZZXPdW5c2mN2gUogqhcM4YJxgn1OseMnOcU1dwkC19SWL6xa57au8VIQAabgzmdx2Unr7Bn6vx6jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEh5DDth6junIFWN8aaI9diy8R1MPWDcxdmXIEOw18Q=;
 b=f/Nud7y8bH0STDzetReP+8QpkjW+QFyY6HrdeM96e1stb6tHJ8ufR+Kl+zhTwlFnc/IbCyjCdoP28a0714Lu10JnGG1Gd08BjEBPmRY5wV+4o8X6vmMqgkVhym9Lgl+WKxcnbflwwfTFX2raGtYxmzxZGVEiMYWMrqctTSmjmfN1+xu7pk1Fof6atpt3zzNQFPCubjX1xEWxelBnyt0XvFeVEgsc64x+bl/eDQmkmHVdlvir5kz6KbdsWA39z7N0zxwxC9cXQQkApEsFZkbsqXLOVzxSlgR4Yd6TexDOoMBkZg9IyxhfYlK4X/VcsHWagWm/45a0zSm3kVLlaCAkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 03:40:01 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:40:01 +0000
Message-ID: <21b9e2a5-2449-42dc-9209-4ea1c055d9a2@intel.com>
Date: Wed, 26 Jun 2024 11:39:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/9] cxl/pci: Map CXL PCIe ports' RAS registers
To: Terry Bowman <terry.bowman@amd.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <Alison.Schofield@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "jim.harris@samsung.com"
	<jim.harris@samsung.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "Robert.Richter@amd.com" <Robert.Richter@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-5-terry.bowman@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240617200411.1426554-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: acc1368d-41de-4092-06ee-08dc9591a8ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012|921018;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzQ5NXAzRkM0VUt4MmxvK1p2Z21IWkViNWxPb21kNDB0WEt5eXpKTm50VzEv?=
 =?utf-8?B?MVI1VXI4c1R5Y0Nka1cxRXRYaUVSVjloVDdVSkNlV2xBb3lIbG9URmRtcEFq?=
 =?utf-8?B?WWF5K1lBSjVmMG9jeDdjUXozMlpUMm9nRnZ5SHhCb2hrYld4SE1QcHBjcWw5?=
 =?utf-8?B?WnVaQnUwL2Q4NlJ3MWMzQ3pSWTM2N0plR3FwYWVobTlVemdFa3hRVTFUL3VI?=
 =?utf-8?B?OU5TcmJQWEhRNVNPR3E1UlV3bjUzbStXQTYrbmIwNlBrUzhia0o1TTlhOUNy?=
 =?utf-8?B?Wk1LV3ErdElPbDlIRXBSeUorbWg5cXdwaXlvQzNZajVwbnM1YlVyaFN3ZlR1?=
 =?utf-8?B?SXVDRHRCOUhpN2xsNzF5QWxuejhweGZEeUdFT3ltNmFnQ3g1U3FLZ1FEdXh3?=
 =?utf-8?B?ck5LWjlSbTRWVFhGYUk2MUhaMzV6OWh4QWRjeGtIakYrOTQwN2pwZ00xbXZV?=
 =?utf-8?B?QjN3TnpSNDVDNlUwV0lDUC9oWTBCdGgrQTM0WWlVTFVFYlBVb285M25Eb0pJ?=
 =?utf-8?B?cndPa1lZaW1VejVjOTlFTWRWV3VZODBQc05Ybm53S2YzNXFEU2FmYktHWEg2?=
 =?utf-8?B?Vm9tR012L2pEV3RmdTVaWEpKbzdweTBVc1dtMTdoMDdiUC9UYUEvekVZYUNY?=
 =?utf-8?B?NTBGb1dkYWJSYWVVU1NnNlFHOWUvNU5ra1pCbXd5VUNWUnJsb2xTdkcxcnU4?=
 =?utf-8?B?bzk0YWdYWnFNdllHaFdvQXA1a0Y2enZ4clYzNXZVVDlPeXBXYXp2cHNzUEFI?=
 =?utf-8?B?MXFXa3FSTWhyNjZ3ZXlpQlVIVFpueVp0UXJlQXg4aElLd2c3YllaOGcvS3Zi?=
 =?utf-8?B?THV0ZWdvcHlhV2hGcDJkd09ZbEc1U1FHZWsyRWhmQjZ4T2Q4NGhJM1ZaR1hU?=
 =?utf-8?B?ekpPNG95aEVkdC9RRjMwY1RXcEMxN2h3UTdTVmMydjdwR0h1V0NnSkhIL2xZ?=
 =?utf-8?B?bVZDUXpLWUxuZFBKTU9yRmdMYXlpME56TkQ4emhyZ3YreGErd3M0VjR3SW94?=
 =?utf-8?B?dnMvcXA4NldIT2luRWcwcjFTVnVBcHJ4bmdSN0wyUmh4YUYvMlBJY2Vyeno3?=
 =?utf-8?B?dFBNd2ZkaVhCbkJiQ0ZBN2JTT1NxcjJJc0FaVW5Mc21TQzE5aFM0OWRLaHd5?=
 =?utf-8?B?K2FRQ3BvZURrNjFFVm1xNTE1RGkxYzNZMk0rQi9nZ1RDUVFiZGpVMVN0OUVw?=
 =?utf-8?B?ZmZCN0ZtdFpBM3RWNGFNeHlTT3h4a0JlQ0FJMWFHRThXNTcraWIyUDhVOHA4?=
 =?utf-8?B?anpGRXZVcnlTaEhxbVlpbk5veVBPSFR0cGdER2ZRaXhDYkFOb2k5aGNOZjE5?=
 =?utf-8?B?ek4vZStlSmpiZ0FwVXAwU0NUcEY2SGtmVkZVYnVYOVpyTVlMMVZvS0lENC9l?=
 =?utf-8?B?dUI1SGd2YldrTm43TTQ4WjF3ZmNYYktva3ZxTWZQU0MzWlhGSFpWaWpKVXNn?=
 =?utf-8?B?YS9NWmdldXo5MDFTcXU3enR0WDRUaHBJYW1JekZsQnFMbWl3Wlk0T1IzQURm?=
 =?utf-8?B?dEVvaUpyUjJqdWhBa3c0cHgzdXVZZlF6bHg3UmQ4WWwrUHZYTklLeEJieWpn?=
 =?utf-8?B?cy81M2owMTVMd0g2UkowNkNVdkhGNW5FRDllT2lpa21kTTdwazZIRnZHNlJn?=
 =?utf-8?B?akZIMFZLYmhJMDZ1c0YxRkpveXlCdGh6bkFqZVVncmIrWmtlSzRPUHZYRkhQ?=
 =?utf-8?B?eGx6RnBTZ3NOSnJNRTgwMHlQWG5IdlJ0cWlWTUptanJ5clJZWFFrT2E5YTll?=
 =?utf-8?B?NzNsTEVweVBHYWlrZjVBbG9ZcEY0UTNncE5nbmdKNm1mZEt0cnRFaC8rOXBj?=
 =?utf-8?Q?MtZm1PsZvK7dIXIzbCJK7hEDxG/6tR5y8bK0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdQTXlnZEhJcFhKZUJJZjBNQmIzOG01bjFxdW5hdTBKZVRIWFJxaHFLeVBi?=
 =?utf-8?B?Z09IY0ZVUnIwQXNqWGo4MVJYUE5TT0lQN0NYT1JkdWxqdS9zTDh1N21UMkhp?=
 =?utf-8?B?eGE5cUlJTHA4TDZjeWQ1YkUrSzRRZjRZa3FWUWJFR3Bzb0N3QldIWEIwYmJL?=
 =?utf-8?B?V1RXaE4vbUFXdGM3RHY4cDFRczhaRGo0WGZWZUlYOEZnbXFLS3Z5eEZUWVNh?=
 =?utf-8?B?UUYzbjBsbWs0ZXBQVEUvNFRLZnlkZXJoTHJwNDlIc0ErcUdiSE1uS29kT3FL?=
 =?utf-8?B?b0E1U3ZVaGRGcS9WNkl0Qzh3b05abTh1b3ZBc0E5NTdGaU1KUnBDdjc5aExy?=
 =?utf-8?B?NWFiV1JGbHhJaHlSKzlKeVBha0ovVTFwZ3BUMVZlcFdsRVpsQ0NHVzZWL0FX?=
 =?utf-8?B?dnNBL0N5bjI5aXRvYS9NUysyWFhxOU1BN2lsLy9BeFMzRmdiY0Z5ZUlBUnd4?=
 =?utf-8?B?RWpzMzA0d3pUT0dCTncrOHVDSEsrcnQvVGhIVit6VUVCY3BXK2JLTDN6VHdG?=
 =?utf-8?B?ZFYrRnQxM0hhUHZYeWdnZTdqcWhNWUNUbm0wU242YU55L2Q5L0sreW1STGhr?=
 =?utf-8?B?QjMvWndxRU5WNUloS2JaZFdMTkZ4dEE5OWt5ajB5OHBoaW5uM0ZyMFp5Uk9z?=
 =?utf-8?B?VnQ4akpadUF6MXNJQWtQK3JhaVA0MEFoMXFtY1A1RUdYU2pQczgwN04rTStN?=
 =?utf-8?B?b1I1NHRzQnV2R1YxaDhFWTYvTVBGV1gwY2hURytOL3hCdXAybnpnZ21teHkr?=
 =?utf-8?B?WjdENlpLTlNYNGlPQ1NKRVdqa0NSS3lQb2JzZjVUTXRqeitWL1ZQUndqWmpO?=
 =?utf-8?B?MDc5OTVLc0VZR2tQb1Axb3NucSttVkQvSm9SdTUvdnh0LzZESWVUUzVGOVVZ?=
 =?utf-8?B?OG5iVVUzZkRldXh1L0hrUHFWeFJZY1RvV01CR01GQ2lmd0lCRW14OWdweXVD?=
 =?utf-8?B?Z0wvWjBqeHg2NkE4eWVVcUExeTFIZnRvclNUdFFhMGRnRFZtckNuTEZDeG82?=
 =?utf-8?B?dy9rcEUyeU5xNG9naUMzSzVNei81dmpVWmY1ZmR1aHV1ODI3Mi95OGJ3dnBu?=
 =?utf-8?B?OGFPd0duc0dRVjkxNWxkRmhSVE50aTU4b2k5TmE1a1VtTWFibm8zQWFpb1lX?=
 =?utf-8?B?OTExZGlPSHhUTi9ZQTlFRzNTYkZVTlZwZi95OXlidlZIaG9Pa0hpUjlBa2Ev?=
 =?utf-8?B?emE5QUhCNkhJV056VnFZbnVtTU1BTE9peU9VV0VoSTdnRmg5VGtNdktabmF2?=
 =?utf-8?B?QlB3RnhMT3Z4d21FSTBPSkg0Qk1hRjFWS1diZThFZ2RZMGtlT001ZWVTQ0d3?=
 =?utf-8?B?TW5PNmVnSUNBdW9SY0FPcVM2aEJUOVRzaFh2MlZDWTRoTDNoL3JUZVdDK2hT?=
 =?utf-8?B?S0pRbjFxdmx3MWNaTG9BdFZKK2V4ZlpHY244MGRoSUt4bFJta0hxM3orQzQr?=
 =?utf-8?B?aFdYcFBxN1lpdUdZNE0wWDgyRXp4MktRdC9VTm4zRXVjOEo1V3NxV29JOTJB?=
 =?utf-8?B?SWR2bHZ3bktjVmJWWVJacW1TVjJTbFNsSXE1Q3lJaU4xOHJQLytqNzNyREhT?=
 =?utf-8?B?K3FtcWR4RmtUMC8zN0wzRTFFMXIxYm9CNXdUdWNNOUFGdktWdFVjdlpGazU2?=
 =?utf-8?B?Yjc3ajRBWFZYV0FiRVdtQ1V2eWdBR1praGV2cU1ZeERlZWgwVHozbHpDbDU1?=
 =?utf-8?B?ZnVNeWZKOVE0MndBZmRrWC93UkxIZGxOTGFmYnpwUjN4L0RaZ3FUdW1TNTBP?=
 =?utf-8?B?eTRta0RmQ2FHZmxxMUZSNk96SHdXa1ZNVEFjR1VXd3ZPZXdmNTZ2QUVPeHJx?=
 =?utf-8?B?RTljUkVPY1N4ZnEwSEdEaUdhMGpjaFZlQjFYWVpRV2RydmhMcjE5WkVuUHVY?=
 =?utf-8?B?aDg5YzdPOEJXLyt6MTJLcEZEb0pMWitrVmkxTzlUNnIvRTFXeXFlR2ZueDRw?=
 =?utf-8?B?enNvTi85bGRveUszaU1mb0RaYTJ6V1J5ZlkxcUJueW12Y0w4R0RvUjBpcHo1?=
 =?utf-8?B?aXRUZFZsTXJZemxKTTJ2NUJoeEdwOHZGd3BzaVFJRWk0RTVNMFc3WGYyc3di?=
 =?utf-8?B?R3liSEhKM3FuckVXYXVvTTBpcjNTM0k1Y2RoSGdkeE5iTm5JaklSVnI2SEFo?=
 =?utf-8?Q?1RTSY/sgzKTZr6RSByuEVaBH+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acc1368d-41de-4092-06ee-08dc9591a8ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 03:40:01.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO6/vM8XLRITicg1DFKWSPIDrsg/u+AX467aWuhWAqLYhIayNpa6qMMe8q6dDNIWO04eQ51EPjvmKhdOl1IfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

On 6/18/2024 4:04 AM, Terry Bowman wrote:
> RAS registers are not currently mapped for CXL root ports, CXL downstream
> switch ports, and CXL upstream switch ports. Update the driver to map the
> ports' RAS registers in preparation for RAS logging and handling to be
> added in the future.
>
> Add a 'struct cxl_regs' variable to 'struct cxl_port'. This will be used
> to store a pointer to the upstream port's mapped RAS registers.
>
> Invoke the RAS mapping logic from the CXL memory device probe routine
> after the endpoint is added. This ensures the ports have completed
> training and the RAS registers are present in CXL.cachemem.
>
> Refactor the cxl_dport_map_regs() function to support mapping the CXL
> PCIe ports. Also, check for previously mapped registers in the topology
> including CXL switch. Endpoints under a CXL switch share a CXL root port
> and will be iterated for each endpoint. Only map once.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 30 +++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h      |  5 +++++
>  drivers/cxl/mem.c      | 32 ++++++++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0df09bd79408..e6c91b3dfccf 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -787,16 +787,26 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  	dport->regs.dport_aer = dport_aer;
>  }
>  
> -static void cxl_dport_map_regs(struct cxl_dport *dport)
> +static void cxl_port_map_regs(struct device *dev,
> +			      struct cxl_register_map *map,
> +			      struct cxl_regs *regs)
>  {
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
>  	if (!map->component_map.ras.valid)
>  		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> +	else if (regs->ras)
> +		dev_dbg(dev, "RAS registers already initialized\n");
> +	else if (cxl_map_component_regs(map, &regs->component,
>  					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
> +
> +static void cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct cxl_regs *regs = &dport->regs;
> +	struct device *dev = dport->dport_dev;
> +
> +	cxl_port_map_regs(dev, map, regs);
>  
>  	if (dport->rch)
>  		cxl_dport_map_rch_aer(dport);
> @@ -831,6 +841,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	}
>  }
>  
> +void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +	struct cxl_regs *regs = &port->regs;
> +	struct device *uport_dev = port->uport_dev;
> +
> +	cxl_port_map_regs(uport_dev, map, regs);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
> +
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..7cee678fdb75 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -587,6 +587,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -607,6 +608,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -757,9 +759,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> +void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
>  #else
>  static inline void cxl_setup_parent_dport(struct device *host,
>  					  struct cxl_dport *dport) { }
> +static inline void cxl_setup_parent_uport(struct device *host,
> +					  struct cxl_port *port) { }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..51a4641fc9a6 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,10 +45,39 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static bool cxl_dev_is_pci_type(struct device *dev, u32 pcie_type)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (pci_pcie_type(pdev) != pcie_type)
> +		return false;
> +
> +	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					 CXL_DVSEC_REG_LOCATOR);
> +}
> +
> +static void cxl_setup_ep_parent_ports(struct cxl_ep *ep, struct device *host)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +	    cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> +		cxl_setup_parent_dport(host, ep->dport);
you reuse cxl_setup_parent_dport() for root ports in this case, and I noticed that cxl_setup_parent_dport() will update dport->reg_map.host. So the host of dport's reg_map is the first cxl device trying to map the registers on the dport, the mapping of registers will be released during the device removal, but the mapping should still be available for other devices/switches under the root port after the device removal.
> +
> +	if (cxl_dev_is_pci_type(dport->port->uport_dev, PCI_EXP_TYPE_UPSTREAM))
> +		cxl_setup_parent_uport(host, ep->dport->port);
> +}
> +
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
>  	struct cxl_port *parent_port = parent_dport->port;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct cxl_port *endpoint, *iter, *down;
>  	int rc;
>  
> @@ -62,6 +91,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  
>  		ep = cxl_ep_load(iter, cxlmd);
>  		ep->next = down;
> +		cxl_setup_ep_parent_ports(ep, &pdev->dev);
>  	}
>  
>  	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -157,8 +187,6 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_setup_parent_dport(dev, dport);
> -
>  	device_lock(endpoint_parent);
>  	if (!endpoint_parent->driver) {
>  		dev_err(dev, "CXL port topology %s not enabled\n",


