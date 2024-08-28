Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05924964D
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808491; cv=fail; b=kHcX69VmsxDfsNePX+06XPA238BYrGb0c0P7TpS+FC86poG4WCzAdagfDk/QDAIyodmmmDowNUWW7HV2IwacPW/TxCctJICweUqB+tYDe+stkuh31u7bcFP1YyrhISY4vbOS2V8cKStw4+84d0/5epZKyI62k73MEHYEns27j0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808491; c=relaxed/simple;
	bh=KjH9bkefUqE2gJmF7iWcEoMbbIfyq762nE67SHHXoyQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlJaXrBhjuP6IVffjtRqbmDX+lzAv2LMin8zpFDwJJSrhi6NcnIlaRs1igtzsAkTQDXd1w/KTxCQ5RCt3Z8d73l49eUVNOnFZb31v/TBvUC3d0eT+PoMPMROpQrULNPCYITZLF5q29RTWif+ld6S7iCTqSgZ0sDRwntSksOkkFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCWyiI3c; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCWyiI3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724808489; x=1756344489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KjH9bkefUqE2gJmF7iWcEoMbbIfyq762nE67SHHXoyQ=;
  b=UCWyiI3c6tzNsKf6shYoC3zEARh9agdNVneUshqNzUlEcrD2U+FPqS2L
   0IsrA7VPXsJYkLt2qgAujVAlpgr/gWytNYf16mwNA1aRDm8k2fRMqsjXA
   IKbNhUtfd42GjIqvbxFfUuB5gM+47rFa+nTo3kpoBzP+o0Cc1AHpxDqcH
   1NthkpusiAOQCTwsEzmgdwDJzwm3Q6sNZEuJl6HeWDCd+5qWcWR7Gqbrm
   +s8cMa9czpnGV2sVa/52cq2bxqmiiT2Z7aVSI9sWfAQx/N565jHIt/J0x
   J7bij3SLznxhHRKDRdf2Tp7/T/rFuyzFxfUUDou+leN5ZXN6Yt2gj74O0
   g==;
X-CSE-ConnectionGUID: hCKzd4orTSCCLVmro4lqBg==
X-CSE-MsgGUID: ZKLpGn6KR/mb6rmhT11ufA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33941440"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="33941440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 18:28:08 -0700
X-CSE-ConnectionGUID: 46iT8T1PT8+AA19xk8cYNA==
X-CSE-MsgGUID: 4DFDlRVmQomqz/Au0E/95A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67946303"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 18:28:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 18:28:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 18:28:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 18:28:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 18:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY/hxc/mZUokEjzMEm2iM7vDvx1oQ24KZEt80C/+uo9IljHl+KYfgARaMQT7Z0PBdQSKB61Id4EX2jr3Yzs14KWGfrJRA9r4wYZS3OGkl148ga+fvQba1RBUVAEws8iceltRA8uhXLuuFfbOmCwC+3faQmGAK8hkjqhqRgAMZIAOayCOu7g3grTHMd8pbZobwZ6Iac33lSh02jce8pfVFlsK0KFOMhROvuztlLeA0RdBz7uppjSlUtquWx6IrcZnpPzLU5gBaL6h74zHZwoIxfBo2cwKo9xMtlNjMqZEqDqz/2OmkLy6i+xTG6N2pwUQgLEipX99W3rsvzdDjSLWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mASf1hDO8q4HWtXpNeHt+rCYrFQMffO7UacM79t6kXk=;
 b=qAggsU426rOlQ2rdRkQl71Y8IxJUlGsoDFtSDHhhyX2/ibRF7877DqhuxCXTBV837RZDZx+BdTOEYLMjSxLQVHUG50b5jiqyuUifsZklj3ceoEStAT4ZRKejv47PydEXVxhgMItkTfG+4PRda26ARMaagnLXXyvf328KN9ljl+WIizE3hSE8jirWMRwY/HUWLQU9xIk05A8uHU0BNmsYez+ssA2AxkSo847bhIt0D8wD1QDBX1BI6UVretdJ5YVOz3tfOuvhPoAurU9TpZQb/yn5a4n7neaLh4lGVr5D00nDarYZqLtwHFRSoobSnGC0bE3eApL11TcHXln2Vgab4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 01:28:04 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:28:04 +0000
Message-ID: <0a815412-cd86-4d08-b93f-4ff4d88134c6@intel.com>
Date: Wed, 28 Aug 2024 09:27:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cxl/port: Use __free() to drop put_device() for
 cxl_port
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <20240826083058.1509232-1-ming4.li@intel.com>
 <20240827124801.00002f31@Huawei.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240827124801.00002f31@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e5c5df-9254-4bd7-144f-08dcc700a9cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzlJcStUY1p1SXRCY3gzd1BZaHlYUENDbHk0cmJHT0NVeTdXUmFZdnNSWDBE?=
 =?utf-8?B?anBzOXg3N24yemtGaDEyT3RzWlVELzFOZVhBNTVrUTFSdHJrNjJ4bTJ1c1dq?=
 =?utf-8?B?Ujd4eEw5amxPd29Rc004RHpQRkZKbkFIRERacjJlQUdEaE1Td0FORUFwQmpW?=
 =?utf-8?B?cTZzRkNNN1FKaDl2NVdzOEYydy9uN2NtaEhxZFJ0NnBkOEU3SHM4T1NoZmJM?=
 =?utf-8?B?OVVVL1lSZFRhUXVWTjJQSnJOVFNKUkl3NWp6Ni9QOW1QbURDS21OTnBQaFFq?=
 =?utf-8?B?ZDBXWkJPdzZzMCs4RzNQL0lSRmlyNWo0VVBhVDF3WFV5TXFjNmNrZURTbEZK?=
 =?utf-8?B?TGp6Y0wzQlYwVFIzdk9GWnIzT2gzVkZPTmloUWx0TGNLTHFRR2s2UlF3dXdF?=
 =?utf-8?B?ZUc4VndEc3daNXRJaVVpRmZQWUE0UHZHWVRJSHhZSHBzVEZ4TytRU05uVE9S?=
 =?utf-8?B?NVpYTVIzNHAybDlZaUIrcElhdXJ2RzBZcmVtNUJNdktvUk1nMTBKd3JUVisy?=
 =?utf-8?B?cXBEbEJYWkw1cGF4WmZZVDJxZ3VUTVZuelFhbS9wZWVNNGUzYlJDUWpkZXdv?=
 =?utf-8?B?TWdSYzdjYTJ6M21aTC9Pamlwb2M3S1VpOGwyQXJERUpRY01GVDJLSURoUW1t?=
 =?utf-8?B?b1l5NXJvUDJOV2hUVTczb3FMWG1lQXFBc2ZYN3dybEk4c2JOLzZjZmIzNldy?=
 =?utf-8?B?Mlk4YkVmejVhd0pCalFFbmMyUmFyeC9IdXc4cHhEdlNFNzZJS1I2OTA5bFpU?=
 =?utf-8?B?YXQ4UEFpRHhoWS85K3lTelBrVHRPNkJKQ2NCRkxWanNYQzIrWjB5RU04RC8z?=
 =?utf-8?B?WEVVUmlTeEJVZGJucnpBcVJxdXUvLy9sTmltcTRnZVlyd1ZrYTVOcDM1dTNN?=
 =?utf-8?B?SXpDTUdoTDNJaWZwQm9VdzJNSWpMTmFNVy9tRWx4ZmZLN2FoUWM0RXJ4ME92?=
 =?utf-8?B?L2JWaFJYWDRjSlJSSVNvcURVMXVyT0N5eVhZd2YyUzhjVzUxMXE0d01haHRl?=
 =?utf-8?B?OStDUGVhZ09Vd01rZlVwK0h3QjVCWjZkMjR4REtvelV3T3pkQmc0SThHOTV3?=
 =?utf-8?B?V3l5UjdVL2FBT0VDVWEzME1kcWl2NkM4Y1BhSXhBN2ttTGdaZk1URXE4WFVu?=
 =?utf-8?B?TzRJNHh5b2JhRzYyVmtRSkFld2E2L0xkbm9odUhJUmNjSFNvOEtnUDJPa2lX?=
 =?utf-8?B?QmZSTTBXWkJsbGNBOHU0b0hHa0JZVHIvY0RUbS83UEl5anN2NWdXV3RDRnk2?=
 =?utf-8?B?eUJSeXd1NUtjRDliUDZIUFVrKy81OG14aW1MN0lpdlh2Y2UyRS9ra3Axb1BZ?=
 =?utf-8?B?S3RnVDFsYW5Cdk1DdnhaeGFnMnhKRTh2WnIwa3BTYksxSTFyZGZWMjBvM1hG?=
 =?utf-8?B?bzYwYzZXckdFai90QkFkNGVkRWRnTEVZNGU2ZkdXeHpSZTViQlRXeWZIaExv?=
 =?utf-8?B?ZEs3VUpxZHc4d0o4WUMvUDFNa1EvSEdCSHlBU3RNY1NVNkVTL3JxdzJMbE9E?=
 =?utf-8?B?Z2tiR2ZrL01PZng0TVpCcWVHWVdNNXkzSzhLb2lQRmtRZ0JxR3FVZENpekVY?=
 =?utf-8?B?dm5mdko2bSt4YzN1ZkMxb2h1M0U1SmkyeS9ZdFNwUWlNMHE3MWhtQkVuZXJB?=
 =?utf-8?B?TVpsNmwzZjg2eGRNU0xzVGl3aStEeUxlM1E5c3dzTDloSUZYL0lMa3VIenVy?=
 =?utf-8?B?b2E4eTJGNGZ0R2xaM2ZDRUptcXJnTFh0R0JnRllHbmEwTUNXb1BZNXE1dmxU?=
 =?utf-8?Q?a8PnGI7Oo9exiL/PQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNZdmdiYXFXbUpUWXkxNGJnVUFraUdOMlA1alJlVkh3YWg2WVdsTEo4RGln?=
 =?utf-8?B?RE80Y0xLTUxwTXYzbC9CaTM5NTl3V2Nud25sUm9ZV3Rwa290a1B5Z2REZTdB?=
 =?utf-8?B?RlFsSDY2Zk1RUFdpUkErbXJzb2JKclcrSGg2RW1scWZFL0VyZmtBTHZ4Vkhw?=
 =?utf-8?B?VlpEaGlmNlI1aFR1ZW9XLytUZTE1dVM2cVRpZWRlSGc3Z242dy9sWXVqT2VQ?=
 =?utf-8?B?SUhONFFab2Q4czRTTFlPbURXQnpUSTZ3ZXk1U0pwMDlkUTNuUXVJR2xnVFk1?=
 =?utf-8?B?dW50SEVGRVByWVZVcEpEN0txRVdhcXJrdEZDemJVQU1CL0llY2xSTlNOMmxD?=
 =?utf-8?B?QUtLUjBBNmp2UlBweThhMndUenUwd0djN0F3NXlZeWJRNzBiVlh5c0tFdnpp?=
 =?utf-8?B?bElIQlBIT2p2V0dGQyt2bktORXJRSUhNaE9SZHRucjNZT3RMQWJmM1lKNEZk?=
 =?utf-8?B?VHBZRjRzUmhSQ1YvSENVRWlyaU1hdFQya09yWXJlb2RiK3IycTYvWHptY2Jz?=
 =?utf-8?B?b3ZlQ1BsdVhNNzdvTUhsRW9xYlRPRmprdkNjRUlFam0vcWxhM255WFdpTHJl?=
 =?utf-8?B?bWY2b25hdXBNMHl3bjJSakdpWjFLMzRDcjFYZVpSQnV1Y0phU3pNdnRvVi96?=
 =?utf-8?B?eDhHdVVLeG1SWFZlcTVnUmhTVmpWa2dRbmtqK1JwMzFjRVBobTQyZThxMUV4?=
 =?utf-8?B?ZXVXanNmZU5xbGRyYzBqMEdJcXZZdDRyVVhoS3BDMXFsa01UeHBGNTdUdU9y?=
 =?utf-8?B?akMwZFFMZlBad0NkMnBPbkZqYU9wemNKZjNUQ1l3WlFiTTZleThmWEpRZGRC?=
 =?utf-8?B?TTV4d3lMRGhMcGlCZTJvSUNMTkZTclZrMGp5MmVvMXVycnljKzJHK0R4N2lk?=
 =?utf-8?B?U0cvbG0zNjd1Skdyc0M4aWVOT2h2TEVZeXhLU1BTM3F1L2Y5S29kNDBJTS9j?=
 =?utf-8?B?M2g1RUhxeFZLRjZPZnByUHhwdklodkJlb21RMWJqRDBNYTRJRzhQZVdWYzZ6?=
 =?utf-8?B?NTVYYkR6NS9tMEdqR21pZnRmQkpxL3pMV3FSc1I2SVJUVEI2V3dJZ3lyd1Ir?=
 =?utf-8?B?MFZMM0MzOFdZTmIwbjc2R3BqQll2M0RUTXYrRDFSeVQ2Wmw1UEJvV2pKK3Ux?=
 =?utf-8?B?ZDBwTUZGSnl4T0Y2VEdyR2tMc3JvRGM2Wkp4RmR2U3lJczVHNzlkWE13SkxK?=
 =?utf-8?B?OExaQ053SFBSbHkya3JEUC9kUXE5VTA4eStnK1VHallZbFlud2l4NFQ1TEtq?=
 =?utf-8?B?VXhyN3I5ajFaUXFBNWQ5YkFIRm44R0ViYVVYeHRlVWhnQWozNFlQWWhmZUpP?=
 =?utf-8?B?WnhXSkdwd1MxOWhPbUMwSEt3LzNwa0NMd3NsL2JTL2gxZHdaQ1FUdzFBaTlx?=
 =?utf-8?B?blNNZ0hqVXZHTmI2bFgvQzhjZlF1NUFmbzF5WDNNMmtUT2pEU1BlRE9sRWtI?=
 =?utf-8?B?UGJHOW9yV041SzU3Q096ZzE0OVhIYjN2Ry9iaU5UeGlDQk5QRjRkbDMwdjJj?=
 =?utf-8?B?S3BLNzRoaHhtWnVVWDhjNFJFdmlqNHFCUTlhNFNWaHdGSlM5SUxDT09VNVo1?=
 =?utf-8?B?WjlMY0lwanFFRzRPWVZJcjRiQkhCek83eDZSamZ2Uk5BOE41LzhzOWhvcENU?=
 =?utf-8?B?TUl4bGxRTkZsaHpaRXlvaW8vSkFzOXQ2dE9LMUdUTi9xUENKU3JjcWx4Q293?=
 =?utf-8?B?WTBXam9KeDl3b1B1aXRFRWhvRTkvNWYzbDh3SHdOWk9zWHlsdUhwT2ZjRk9m?=
 =?utf-8?B?czlMZzUrWnJxMzBMeEFVd0pDWmxYL05Ib0JyOWJFMjRRMkVndEZZaUdmQ21i?=
 =?utf-8?B?T0xSMWhjQmpRa1FyTzRvbVBnVW0zN1dHS3NINHlSa3VEZm81SjJ5Y2lnNXJT?=
 =?utf-8?B?Nis2UGtPd3hoNTNjc25CZzFCRElEdUNvZXo4VnQxS2hzV0NhQ0IrdVpqbm5h?=
 =?utf-8?B?Rng0WWsva2tha2xMRUgzaXdYRFBwcnBOY2NOZ3piZFVzbk55TU9wVU1GN3py?=
 =?utf-8?B?N0IwL1ZCdEpyTjV4SWptb3V5anp1cEdiNTNyZ2hWME1YTSsrS1JIVU9HMDQ5?=
 =?utf-8?B?Tk5VdC9iOVZFQlNKQzZUZ2NCc2UwazgwWFo4cTExRVFFQzFXdHU3Nm5hck9N?=
 =?utf-8?Q?fkEtZeHKARLs3Wpffy7m8qzjG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e5c5df-9254-4bd7-144f-08dcc700a9cf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:28:04.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NVJGv0oabWM1XZAoi75NwbLz8spwmO4KiGVgsfNsIaVLz3KdjEKH4PLS6idX8YYIHIWHHnH8bHMc8M5PG/1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

On 8/27/2024 7:48 PM, Jonathan Cameron wrote:
> On Mon, 26 Aug 2024 08:30:56 +0000
> Li Ming <ming4.li@intel.com> wrote:
>
>> Using scope-based resource management __free() marco with a new helper
>> called put_cxl_port() to drop open coded the put_device() used to
>> dereference the 'struct device' in cxl_port.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
> I'm a bit doubtful about this in general because of the increase
> in scope and reordering of the releases, but there
> is one case below that I particularly dislike.
>
> This is fiddly code so you've done a good job btw.
>
> Jonathan
>
>> ---
>> v2:
>> - Use guard() instead of scoped_guard() in some cases.
>> - Ira: Check the return value of find_cxl_port_at().
>> Link to v1: https://lore.kernel.org/linux-cxl/8ac82c61-7871-4914-b376-32431868622c@intel.com/T/#m07695675435bf702311dfc40f64289b9623afa16
>> ---
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1d5007e3795a..b50dda6610e3 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1539,8 +1537,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			      struct device *uport_dev,
>>  			      struct device *dport_dev)
>>  {
>> +	struct cxl_port *port __free(put_cxl_port) = NULL;
> I don't much like the ordering here.  This will get freed
> later than it probably should.
>
> Can you move it down to just before the device_lock() is taken?
> That way at least it will get released in the same order
> wrt to the parent_port->dev + keep it's constructor as near
> as possible.

Oh, sure, thank you for pointing out, will do it in next version.


>
>
>>  	struct device *dparent = grandparent(dport_dev);
>> -	struct cxl_port *port, *parent_port = NULL;
>>  	struct cxl_dport *dport, *parent_dport;
>>  	resource_size_t component_reg_phys;
>>  	int rc;
>> @@ -1556,7 +1554,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  		return -ENXIO;
>>  	}
>>  
>> -	parent_port = find_cxl_port(dparent, &parent_dport);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		find_cxl_port(dparent, &parent_dport);
>>  	if (!parent_port) {
>>  		/* iterate to create this parent_port */
>>  		return -EAGAIN;
>> @@ -1596,10 +1595,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			 */
>>  			rc = -ENXIO;
>>  		}
>> -		put_device(&port->dev);
>>  	}
>>  
>> -	put_device(&parent_port->dev);
>>  	return rc;
>>  }


