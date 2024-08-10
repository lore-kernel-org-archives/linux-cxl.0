Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8ED1E86E
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723290680; cv=fail; b=UYdGjrDbVm05wR+1MihwIGte1xaBgw7f0niYPZoMVAUt2037WDnFxjxjzPnATVa76upTGYxcQckhVsVIpH94F0z4M0nZPa6SrVOUfQjcXReiq65/X88DfDF0lcX3Gg3wMoHIJtANkDxMzVig490F5ceH0vsL5L1QnrulEHXxVgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723290680; c=relaxed/simple;
	bh=WhDQF3GbrHYrw2itdWzRf4B0trfP0zr6UXYYxy9paos=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ovn3qRpgZMZ0xUyvEpMda52S8yNxRsmSzv1yRanIvnGe7hF8zZzBehHVzGIO+xBVGhXirXnm1pkqaVThOMpkUCU0/F8CcPesZNhhmZr2MEo3KRCRh8NGiuE3qvQttQigLtWw6Wh6KGBWZrpcvugjFDupfo0Eb1DbH81VjAM0KUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNxVJ50b; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNxVJ50b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723290678; x=1754826678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WhDQF3GbrHYrw2itdWzRf4B0trfP0zr6UXYYxy9paos=;
  b=DNxVJ50bRjRvsbq9uej8l6tdM8vX37NyAuXcphWQTgHfQLi0nfZAK1Hl
   HEBZNY2CykqdnOJWUcK/a9wqRYpvJ4uWjL2ZbcZLCYpe5M8D+ACVqcK5/
   oSdGSZ3ztpMZ4UD8gzMjfs6vAuH1Oba6W6tPUZuXd1utemjP5NqbtOvtI
   e4o71csRvJyaKoMR2F6PumL0VJJeEgWrWObpwon9IZ37go39OsBy6VcqJ
   DbQcnKe7Vraor8dl5b0xRDF6KT1JydRUmHPCG9dATa7YBN9SxykbnEkH8
   R4S8zfDltPicw5PwtV3C+b5HPaPYfWaIwTKWkcuXj7Qh41n9DBWA1D7us
   w==;
X-CSE-ConnectionGUID: vVOn+VcCR2Oj30gITBKySw==
X-CSE-MsgGUID: XbEmEB1DT5yBAQD4YmPj4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="38908096"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="38908096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 04:51:17 -0700
X-CSE-ConnectionGUID: REuj/uf/RpaEJDT11SVqOA==
X-CSE-MsgGUID: SLoVJZilR1aMN4BwR1SqqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57715332"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 04:51:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 04:51:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 04:51:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 04:51:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 04:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEBCu4urInJI3TiN1lksMKfshcSEz4lwCXxilr6mnGFOmix8BCzSEAlyT58/N58EnHYNXctWwOY3sVaZIzQUzrYG66tq7P4WVjPmwu1hqU8uJcmXJVVRXVVJRD9AN+p7/DQHwD05W4dAxsYLDAALloGhoVi0yDDT3bLU4B3oau3nrcdSJYSK4rp5CIMMOfRP2iU7mE/aMY3culNlDZ76mkrW7OUC125FiJeWD3GT8E84oc+KSkr4HMP3uUUeRxrQGd6Puu893SRKjw7znETJhrNo3HbZBAmQLjeqk22o8v0ZxoIR+6oU0R5JuWAUW2q9i3P9dAo6V8VR4aqRDZjctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37gf+nCJHXGsgGeUFebrQgLrBAlUiWWBKwNnwZTTHbM=;
 b=C2KzCm3psxF82LFjlyLdcginWe7Hzy9l9OgobL7/eFsdC2L6cqXI5CzjFDSnEMlKLo4Xfw+gGh2Eyrfoy+aICMj/j8kHIXavH/z0nf8kk0M8OnrFMp8Y2KY5vMG6c+XWfojmXS7U16TtnQLnqfzd5/4vm5xBjsjBw0u/V/Qb2sttNtY4Pt/DlZ/kFavmxQQcoQwCzJMC/iqdAayv1YxOgD6N5J3J4DG4ua0v65nqH+DDJas4EkCGFgVRYx6J+xZ1LmEIrgTBzulTNFcfunGn6F3p53VuYzfwpgCkzkDAcfbGs8pxwPvxd0e3IB/TuTYMYJFNphEMs50KVpS+xysqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Sat, 10 Aug
 2024 11:51:09 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Sat, 10 Aug 2024
 11:51:09 +0000
Message-ID: <6570f964-9350-41a6-81fc-d46432cd0737@intel.com>
Date: Sat, 10 Aug 2024 19:50:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 3/4] cxl/pci: Check Mem_info_valid bit for each applicable
 DVSEC range
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <ming4.li@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-4-yanfei.xu@intel.com>
 <66b66a69ac7f9_257529416@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <66b66a69ac7f9_257529416@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c67ee4-d930-45b8-a115-08dcb932b975
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ylo4UGJoUjRLM3dIalhpbmFsVk9PTG1qZHVPdU13bjEwMm1Pb0RtaTM4aVVr?=
 =?utf-8?B?dmJJak5rQkFEanpjNVVYMWJWU0gyRXhBd2h3T29CZ0pJaGRadFR0TTJTdTls?=
 =?utf-8?B?R1JmKzYzbEJlMnJ0RnZHemhpUUFpVnpFUnFJNVZhdHFaSHB1Wm1FREIwdmVp?=
 =?utf-8?B?N25CcUpYQ3lob09PT3RzMkovRXBQNlZveXpTYmhLSlJZeGtReUkxSU5VVk10?=
 =?utf-8?B?TGt2M2U5MFVPbUlMZ0lyMXhRV28wQXk2UkZsbmRrR2hZY0luaG9ubjZ1NUU0?=
 =?utf-8?B?dllTcVRxNVpTNWtGZmhibUdhdXY0NG1jVlk4Vms4akNVWVlCd1JZbE1ZU2pt?=
 =?utf-8?B?V1ZIQzFSZ0RTMnZySDlvaDNVUG8wdzFMeXJnbHZXQzVEYU54eFdGRVVneGRB?=
 =?utf-8?B?MERwUDl3VjhwalZ0QW5PdnJMVjBmZ3J3VzBnVzQrWUxoSXNjdHcxZFViVUZZ?=
 =?utf-8?B?TkVvcnpVVUFicTNKb2hJb29TUi91aE5hSk5SbFpTMEowQ0Z2U2xiYUJBT0Vm?=
 =?utf-8?B?SHBMQ0xVVVN2cHkyTHNOL3lXMEVpK21XbWpFbU1HRUI1YWZneVhKTkNPblg2?=
 =?utf-8?B?cXJNQllEdHA1MHBvOFhYNUl3RzFLV0RTcDg2c2dCZjN5eVllc1ZiRnBOQkRh?=
 =?utf-8?B?dThBNWRCRTQrY0tYcjVWaGt0ZWM4ZjRXNkNWOU5DbVMydXFhNmdVUDU3YTBn?=
 =?utf-8?B?UGpieERDaTdZNXBNc3BEUnZybDFRNDNxMVJWYmdqL3hzbWZPWWZsUkpLWEpp?=
 =?utf-8?B?NVZsRW43VmtaMXliTzhUWXZIS1ZUOThrbVlMY1U5cDVPVm1BcVBrUjBpdkFk?=
 =?utf-8?B?cGN2WmpwSWgzaWRsc28wdzk3bENjTG1sb1JMcjJqSGowOHdoN29Ia2paazll?=
 =?utf-8?B?LythMWtPMUF4QXBIeW9BbWtFVmYzSWRsMVA3Rm5KazNpaTNVMDRvY2hHcVdL?=
 =?utf-8?B?N01ObFhqQzh5NGN1b25XS29uOGE1QkVQTTdCdnJEMThobEFmR0t5UklWVldw?=
 =?utf-8?B?end4S2k4QWNYSWNPN25FeDl5U212eXBxRUUxUXhoM1o5cVFZM0J5d3JWcHo2?=
 =?utf-8?B?cVBSbEkvRm9QSXo0ZzkzQ3lDYVN4UlpSTStaRk5waG9nMWhCMDUyc2Vobm1P?=
 =?utf-8?B?ZVRHSFJBUnZ5Nms1WXdHTWJHVHRDTTdHUXZGcHViczM3RHo5OXF5S1YrOUZ0?=
 =?utf-8?B?ZmlyVUZaWTcycUx3VTh4TmlDYnFueGRhaWhySEMvYkFSMFYySWNpQ0dTTXlp?=
 =?utf-8?B?LzhsS2Z3MExoZ2hQS3A0a3cvTXdhZFlkbkk3QXA3M3IwM3NJWG5XZU9vdlkz?=
 =?utf-8?B?YVQ4NHhIOS9DZUhPSFdSZDVxNTlvME45L1EzbFJhZW0vRjREbHF5Yy9SdGtk?=
 =?utf-8?B?RVJQMHBYeUlHd25WNTA5VVMrZGNLU2phNmloQnBMVUJBaXRtcEVMV2VzWjVC?=
 =?utf-8?B?SkxHL1R2K0lYNVFPRkVQbTI2Mm5BYkdWNEM1b3ZTR09aWFBSN09xS204WVJy?=
 =?utf-8?B?RE1aQzJQMFNJeldPWDRsQjVUc241SU8yTHQ4YWdXUU81b3E5TncwVzV4QW4z?=
 =?utf-8?B?clE0RThLVm9CT0ZSeUhLWlk1Rkp5Rk1yRmFNUGd2cUdkOWI2NkFXdHYrMGN2?=
 =?utf-8?B?N3dYZi84bHVGVkRmOUR5NlZEUXltc1hXRGM1b052emNCbnVsZW1ZL2VLMnZ2?=
 =?utf-8?B?M2dpcWM5cXUwRzFmQ2dLd1NrRlJ2L01veG9KWWRhcEJscmhLVjBIZy9qM0x3?=
 =?utf-8?B?OUNuNk5DQVBIRFlwRG5qUjZxS1ZsSHQ1aFJJcFNYck1yQnU1cnM1RWJNeTlG?=
 =?utf-8?B?U0hFY09iNW9DU1duSGNqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hiM0VBZDBVTXUvNTdsTmxzNjMyTWN3a1VKVHJzUUhnK1MwaTVxa1ZBcUdk?=
 =?utf-8?B?TTN0UlRjNDNxNFk0WW1mNG5uTzBoYjZ5YnUxR3ZmaVBYeTUxNE9PbzN1SC9E?=
 =?utf-8?B?VjVQUjh2SWpqKzV0ckVWSDRib2QyZ1NIZnhPcyt3L0t3QlVMNkVBQWxNNW9H?=
 =?utf-8?B?K3htTUhyYTZwRWtURVA4WFh4dUUrQ0ZFZ0hFYkJCamROb2RPM0o5RjJxTWtZ?=
 =?utf-8?B?TSsvVTJCNGZmYmxSbmkyaXB1Q0lMNHZWNlQzNyt5UnJ2dVYydmtxQytidTZW?=
 =?utf-8?B?RkVQamJtaGIxdURxdlZJWXk3R2VjWGJka0I0VUFSWVdORHVkRjZuYkNKYzhB?=
 =?utf-8?B?c1FPZHhmZkF1OGdhb1RCQmZGbEJxZWI1NWRXNDFCU0VrSmQwNE1tMkNUR0lZ?=
 =?utf-8?B?alY5d2tYRWF2MmI1b3I3TnZoenVQUDlLMEtvRHYyaGZoLy85aWxNMkFUR3NO?=
 =?utf-8?B?SWJLMWlTaFkxVVVMUE5LcnY5MzJIVVJrVjczY1NhcFZVWEVneHFJNVZXdi9K?=
 =?utf-8?B?WFBtWFlkQmpBY2N0MGtXbzluYUF0TDBYVjlTTU9yRC8rQjRJdlovbENIQnJl?=
 =?utf-8?B?TSt6WU1xblE0aXdlNlkyQ0hPUnhaeFo5WjVLQytGT2NUVk1SVVRzUWp4OHNB?=
 =?utf-8?B?aXpkNG5UTUFkQVlCaUVPeFFwYWpaNklaTzFCeGpLSE81RTJKdG9aNitBZlB1?=
 =?utf-8?B?U0NYTWNDTkkrdzIvakVpc0g4a2lHbUdIbWJ2eFIxelZZd3RaaTJmaHcyNEMy?=
 =?utf-8?B?T2VWeTFnVDhEOTBpMnMyVllNUmJOL3FGWnVHcHo3VXkxYmRiM253OWpIU0tN?=
 =?utf-8?B?NVNOY0Y4VHFKZjZ5WmE2SU85TXBsOXZEUmRac2c0QnZGa0c0Zkt3ZVlLK2Q4?=
 =?utf-8?B?dFBVa2ErdlVNM04rNnVTQkxHVU41ZnRGT1JZVldoc3VlUVQwUGh6TzdlSlpp?=
 =?utf-8?B?aERqTmNNQWdlT1IvcVI0Nmt2UWJHaS9MbzhRTmowNk43RTlCR0dtYWxkYms4?=
 =?utf-8?B?b1FUdE8vVWtQK2Ira2xKWVZpYTVwMSs3TXMyNWdwMEdYL0I2VXFER0NNdmsz?=
 =?utf-8?B?Q1JmUjdYNVlXR29yNW1ITi8zMzNabmt3cytLckRucGxXU3QySi9nQmU5VFNL?=
 =?utf-8?B?ZWlKOHMzNS9OMHJMVk5hTUtod2llNjVGVUhzS2ZjdndQcG5tKzlaTnFKYkpX?=
 =?utf-8?B?bnN1WHFSVUpuclBkdTZaR2ozWTFIeVRadVF5NmRyOHFUUEkxUnpPZjFkMmo0?=
 =?utf-8?B?eGZJZVhoaE10UkdPc21ha0oyM3JrQkhDR0xFTndmWGIxd3VydUNSQVcrZ0Y2?=
 =?utf-8?B?ZEV5UGN3UFJpa3VrUXlmb2lHc0JtTGk2NVdZdFJzZncrR0lJSGwwYzdRRWcx?=
 =?utf-8?B?bk9GdmRhYkNlTlB5K2VuLzg5OVJwSmtHek4yRm1lL0MyWE9aSzJkYnJQVDJY?=
 =?utf-8?B?cXVrK21wRnFLQTNONVN4ejN0Q2x4K1RjSDJpM2xRa1dTRlcxOEFhZitGSmpy?=
 =?utf-8?B?b0JWZFFNKzJ0UHlvakFpdmhYVGkxeXJLZHpHS3pXMXROQ3FWSDVpYXhoVGpT?=
 =?utf-8?B?bXg0TnJvdzlDcCs1Yis2aDR4OGt6VFFTR3d6S2thRlplN25CQ0FnR2ZQTlVC?=
 =?utf-8?B?RXFPKy82RUh0SjVyL25YRG9PNWtVdVQySXNNUFNhTVBWZDM4VUpSaFZKMHRU?=
 =?utf-8?B?WjFjai9QcUszNWxwcFBBNmpkdGRZUmNGcWFWbE5QYlB6ck5KdHhoYnRUM0lJ?=
 =?utf-8?B?d2FqOHJGMk5zMEVEa3VFV1p4RUVwMVZBWElOVFA1dndSQW5iWFVDZ00zQWdN?=
 =?utf-8?B?ancwYUZVVkpPL0lZb3dIWE5tZzJwaVlyMytkUTZCTWRaZkdWVzRFSnNqNTlq?=
 =?utf-8?B?cTB5WXVpWGlUeVJNdEFxaXFpNVJydklXWE1mdUFWbkRtTUsvb1VJbkYrNXlr?=
 =?utf-8?B?UHZqUWdFQS9LN2FEd1JSYjkxZ0Z0RU1rbDIvWElVYnRxT3FIVzJsOE9xOUd3?=
 =?utf-8?B?U2tpU3hBSHAwSjZGRnB1WUdDSmFGTVp0cHk4OWVJL1ZXbFhMblBKRVA3VGhl?=
 =?utf-8?B?QkVpaTlUc1BBc2NDR2ZMVjkxZ2VHRVErWlNxMGZ1eWg1NWthUGJnM1MvUE9Y?=
 =?utf-8?Q?97eNhMvTbQw94uTLbZHfo4mAc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c67ee4-d930-45b8-a115-08dcb932b975
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 11:51:09.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PTjbyznYiVTNjvEKGxecMVexB0RLTRs16hmtY/1GSFs00ZEC4nZL4bVeNSWKQZJzAmBxaVV1iFWUOL58MPNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com



On 8/10/2024 3:13 AM, Dan Williams wrote:
> Yanfei Xu wrote:
>> The right way is to checking Mem_info_valid bit for each applicable
>> DVSEC range against HDM_COUNT, not only for the DVSEC range 1. Also
>> the functions to check the Mem_info_valid bit are repeatedly
>> implemented, drop the rough one.
> 
> Again, not a fix, as there is no evidence of a device in the wild that
> initializes memory_info_valid of range1 on a different timescale than
> range2.
> 
> A better description of this patch is something like:
> 
> "commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
> related info") added another implementation of waiting for
> memory_info_valid without realizing it duplicated wait_for_valid()"
> 
> ...I would also *only* do that cleanup and save changing the logic about
> when it is called to a separate patch. Neither of those would be marked
> as a fix because it depends on odd device behavior for it to be a
> problem in practice.

OK. Will split this patch into two and drop the "Fixes"

Thanks,
Yanfei
