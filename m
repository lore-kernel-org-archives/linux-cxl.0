Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552B189BBE
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111696; cv=fail; b=Gxh4JzqOcLdVJtHf+0ekye/pWZlGBAa4S3Kyi/avSrNhPIB1bU619LmCSY7cfhzI2Noq/NelsX6J4hS/xifqJjb+aDrIhmaqW7H9fnvXxn9wlAVaTHk6Ak3LWNR7+jy44Y+NCRtKLfcKnUnK06+ExpFORYfL2gZJuab7voTX98M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111696; c=relaxed/simple;
	bh=bf3ZaXskzBno8U8dP0YYFFI/gbHaRmsRAgLKaTrxyUg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JoBB2VRhLgUxolRa2tNSga2Av6eaTCYHV1fdgae9HNtPs2xU20E71XbtbAeZHOGI1a+OBEi6J/LVXvVY71v5SpG/gCsKg52ZUNrOugyi97pS6EPxEByi6Lz4+Fs5f2zSeukNuCOwHPfAzQ7TkJUBuDWuG5QE/JEnFVGYSCOE/uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uay8zerE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uay8zerE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723111694; x=1754647694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bf3ZaXskzBno8U8dP0YYFFI/gbHaRmsRAgLKaTrxyUg=;
  b=Uay8zerEE/FTtg6xw1lEPv15XKCYeO3avfoteFqHhXAt/yW7TyRdMbeQ
   i5K/SuqvFEjTzIZiKwkvYKAOXZujumGSYvfLBc568rqqGTeksqNbb+y12
   R8ykwwEGy7S6X7oEVkkypKNWx5M351IzC2eHpZWFAr4B5rFj/JKesJk3p
   QQAWnrA5OLZQ4j8OyfxtoG3hYlIUKsxfG5nNkQXQeAmGzafFVJHdpssT8
   +cYKeC5TYuSh+e/Qg9KAQgi5qV2XZYbhCoJ+LUTehhdl4p8JEE8N64Abi
   epbwQpK1iWEhIKsBCo3RD3ALNwGGwNG9QHay2egfmbvSMMz5I81sH1ygg
   g==;
X-CSE-ConnectionGUID: /C11fUKKRN2r09qYcxRzmA==
X-CSE-MsgGUID: JI2cPYIpRnaSAf3NaYdIvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21084629"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21084629"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 03:08:14 -0700
X-CSE-ConnectionGUID: S65KxQ0pQZCfzAd0gkwXqw==
X-CSE-MsgGUID: tcvxLv3ETZCpEVFiBuWWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="80403275"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 03:08:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 03:08:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 03:08:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 03:08:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 03:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SurmHuEiPcQcEIOT0A0aw+ZpSAd0dzcHNdGWWZZ2gvGMfjQaiIRwz4aWBXNoR08DJ3RsEc2RD0jGRRKPT9G7oy1W/H5Vg1YdT90Oq0kgP5ELQ1HfWY0EnvfQIWHbUdpLzwjrmslaEGiqnLyRsydp5BatTYk9b5dZeqNcQjQGM3jPh900dgSDxasZYsZRHmp180IMdLhV0KWXKR1+lXXeVpjViOmqMGgYcYTcbTP6ESnk0osT3WAJsAOKuk6zFe6jUfzh12aVQp1dwlHaQM/Sgk5w3AN99pgrJKnKB3h8Ml1RORTS3A853Y8HPpLpVv3ALKjg0/Q50jxrFr25lqgHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKWE/KlcHT8vuhbfptyzqo64xfPADnYzfq9RKG9RzNU=;
 b=QQDLTWehO8OCAcGUYgOnwFY1NJJOJlz+puRkm90MRlzMlfFzZ+cdeimBGNXX2XO+b4xZgHzkIwktsF/OwF4/UqbUf6omNq4BC0r03PNxQI6CkXwfDs2pM3dMXUuupjoSHpla2r99bXdAPO1nnSay+pjR3Klh8mmaw8fby54/JeVI+MvdkPmZbsnSZ/YrRGZk1Q3Slf83Y46IBpx1JpCGZSS4X0ydjchs28hAj/XCJ728GgSYjdnB8t7cY2Y/OpAx4uGP0YxFT0s5bVzEqECua1rGrtWxolyPkP3NF0Ypqb/NFMCHu60BuvcW1HkTfIVl/0ZdNHqS/x3j7MULAWuzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 10:08:09 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 10:08:09 +0000
Message-ID: <aabdadb7-0281-46e2-8b52-6c87f1d8a49d@intel.com>
Date: Thu, 8 Aug 2024 18:07:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all ranges
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>
References: <20240807131908.303600-1-yanfei.xu@intel.com>
 <ZrPEoBbeV0BBdn8n@aschofie-mobl2>
 <116108a3-f974-455e-b530-1e55e4f98758@intel.com>
 <20240808100810.00005f5d@Huawei.com>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <20240808100810.00005f5d@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bf6adf-549a-4ddc-d6ff-08dcb79200d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V09WVVhzYWJPVXFNSmtWRkl3dWkyamJXVm42ZHlXVnR4U1dZWnNmWXMyMFgz?=
 =?utf-8?B?N0Q5MnpKdFRTYWFUZUJNZ2VVbzJsZzNrc3A5d2VOR3FhWFZiVW1sNWd1TTUy?=
 =?utf-8?B?VGhYU1FmYUVCQWRIWlJReHh0ZTdhdWhmbjZkVjA3ZmZUa2xvY0NGMnQ2YXlo?=
 =?utf-8?B?T3E3TlJwLzlGdUgrRlVxZnhYMnNyc1RPSHhzNU5hS2RPeVFVdDZGUXk5S0pj?=
 =?utf-8?B?amkxWnJMRHh1L3psRWk0R3hxcjhnbmNOMisrK0JUbldkbDh5ckR1aTlBUVhQ?=
 =?utf-8?B?Uit5RmFsdWdXUTQ1U1FBK0RPSmZuRmJ3enlvVmVzSm9JTjhxM0Q0cVFYWVF2?=
 =?utf-8?B?bDF3dUpXR2VjWlVML1Qvdy9qRFI1RlFEZ0h0SnlWZWV3ZTdacExqdjNUSjdT?=
 =?utf-8?B?WkRxOTFaMUpXdWV4OEZJM1p3VldyYmVLYkM2L2xpa3VTVGhTSVdaUW9TcEp3?=
 =?utf-8?B?TWw5blJXN2V5dk5WbFdUV0czZ3dtWjlGR2hUeEFmVXZsNXVwNjFhcDRZVjV0?=
 =?utf-8?B?YzNBUTFSZGFUMXNSSXY1QUdWenNVTHNkK2t1MC9xVHZ2cnUxaWdZSzVlREVE?=
 =?utf-8?B?U042UjJWRUo4QndESnZNZTg0MU51T3dTNGU4U0RXK3lxcytpODErK3NKSGJ0?=
 =?utf-8?B?ZytqaFd5TlZsdXBzNnJEQXJPMlVabm1GUnJDckgrWkVmZzllQzBIOUVHd3Er?=
 =?utf-8?B?M2JQTFpncnFxREdoZURwdmJKQ2JqQkMzSUIrOGpudG5oUkZWT3FZS2dtMFVn?=
 =?utf-8?B?OG0xM0FwZ0NySkVvQ2ZqM3psNVdTVDZVK0YzREU2OW4xbFRBL0hSRThyZWFo?=
 =?utf-8?B?M1lnTGdZb3poR085Mk9EMVN1UzZZWGQ4TXhjU29vRHpDSm9sdjN1VlZESW9u?=
 =?utf-8?B?TXcwTFFuTXFHUHg1aE92WS9SKzdJSGFObGw3cUhsOThHSEJ5Y3BMWW9UVHJW?=
 =?utf-8?B?YlhPWnMrL0tJWGhGS1NTNm9VS1JWalpqRDJCRkN6UGhsdWJtbXdvZ1VJRlBv?=
 =?utf-8?B?T2tsM2lKdVY5KzZHdGNPeVNLNTN4WG5pUXhkSmUrcVVlRFJLT29ISjdQWlBU?=
 =?utf-8?B?RUVKQVJDdVhMR0c5RWtNa0l4Zm9DWXNleVZLRTV3bHZvQjZnUkRRWHRmT0RT?=
 =?utf-8?B?TnQ3b3lrWDBGbXUzMGlHYy9xdXBRRFVkTXNwa1FOaldMRWJqN3I1ZGwrUEZP?=
 =?utf-8?B?S1ZWVVhJS3ZrUzJ5THAzekpUTjNtaFBrbzhqUytHWVo1ZzNweVNjL29YNVN3?=
 =?utf-8?B?dTREZU5rSEpJbUZwMy82SHhZZEJ1RStzMWkyWnNRQnl5TzZsQlhIdEtRdHp3?=
 =?utf-8?B?azdOVjN2RGVFWk8wMWdNQm9EYTcrWUg3MjU5ajlKT2F0bHlHemx6dGhpZDRz?=
 =?utf-8?B?SUIzT2pRRUMzN1lFblN0NDJHbVhYRWtRekFDcEU4aUZvRjVqMEpqV0gwWUls?=
 =?utf-8?B?ZlNYaXZrWU1qaUxnOHUxdm8wSXNBU2tNaE9ZYXhTbDBqNkNGV2E5Z3p5NDZC?=
 =?utf-8?B?WVJ6YVhQY2lCeWFqaG81UmgwVWdOMlZrQTUwVWZwQ21QUFg1elZPR0hUYlNt?=
 =?utf-8?B?RWFlRUpyN1hqRTRocjZocFJCemFCMldHZk5GQlYreHdQOTVUSmFybHExU1lL?=
 =?utf-8?B?WEVBK0lMK3V2bVVNMi82RnQvU2I5bXdKbG96SnpmWmR6OHV6V25KQWxCYUY2?=
 =?utf-8?B?SFVNYjk2am1qRFpodERrY2lmODZJYURHN0J5eDhtZitzZEFhUlh3NzhSdzdP?=
 =?utf-8?B?dnhyVHpvNmJ3MHoxMWVDUjFnaW9sUERGWWFDK3doOWVEZFFRUml1eHBkeVNJ?=
 =?utf-8?B?Q1hOd24zLzRzSnczMXErUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXcrSzY5RWt4d1JmWURadGJkb0liSDJMdjFIWGRmZi84YjYxRG55enk2VzdD?=
 =?utf-8?B?VkNYNkFkeHYzS2x3VUtvUkIvMXl0eVVyTFpqaWxSemJTSWcxVE5sNWtNM2Zz?=
 =?utf-8?B?L3VnZkcySEFRd0hFOXdORGltVGVTNUl0L054VWdKdjJIOWJKZG41eE53c0xT?=
 =?utf-8?B?NjE2YjA2UnVnNUx3dUdLeHVmZWRRMXdEZCsrUnJvbVZrNDEvVDNFTTA2VUNs?=
 =?utf-8?B?Ukpnckt4ZmxGOVNKaERpOEllcjU0NDlyb1dsamMxQTN2eE1FUEQvWkhzVkdS?=
 =?utf-8?B?cjFTMWI3N2Y2OFdta1hnK2JGVU1zSVJIVHFmRmNOMDVrNlZOSzZFTEJLc24r?=
 =?utf-8?B?eldwOGhBb0xxck9XMFoxaU1aK0Q5SkgweE5qUC85TTF0cXNocm9yb3NrN1BW?=
 =?utf-8?B?c3o0eXR5ZWpwbWpkM1hDZDhTdm9rWkhaOEhhQ0dNdE1HLzJJd3pVOEw4WVRt?=
 =?utf-8?B?RUl4dWZBbjFkVFV2bGE3VUkzczhLWk9qSUEyZU1zU1VvZ2lIWVkxNk52TmVR?=
 =?utf-8?B?amlqUVdiVUpOUmlsVnlMRnozT1dLcWoxbHhjYk8xZkt0aU9zSldRemgrWmlt?=
 =?utf-8?B?bnY1c05BOGVWKzhNZlpWUnRtT0VLOU9DdHI1NEtxRkFnY0xneEFIVlJ3VHlX?=
 =?utf-8?B?YjdpRVAvZ1lwTENQeUErcmhNLytzMXJ6YkZ0TktYZ0ZwRGpsZUp0K1lIdk9u?=
 =?utf-8?B?SzdYMWNnRTc5Q3FKTHc4Zmxza3lyVXkrWHZrSEVLeXhCZVUzYy8va0h5TWcz?=
 =?utf-8?B?OTREMDJQMFZmTkRaRDNuSEl6OGhCbEl0eE5vR3NJN0ZpQ0R2MldIQXdPWFRU?=
 =?utf-8?B?VXdWZWc2b3BDNk5HZlhxa0xoVWVaWVdZWEpwT214S2ZGUHBEaXFsVktrSkVs?=
 =?utf-8?B?MUtpVzNhaXBMam5FV2FkVEtjTEh6OUdvSTMyaTZob1M0aERGYmNKdmJBUXJl?=
 =?utf-8?B?VzFPblBlOFZvRFFQaDlVc3BPOVVRUWF6bzlvNEpGUHR1c242Tm1JbUE5WjFD?=
 =?utf-8?B?dmY0ZUVFQnN4b1NqSUxJdjViMFZLS0FkbmVRTGVCRjdrZ3A3czJxcUtPb1FE?=
 =?utf-8?B?alpIenczZ1FxcXhGdXpWL1FZbnNmbk9kNjN3YTF1YjhTVmFRWmlWejdDL1pw?=
 =?utf-8?B?SFhjYUdSbmFYT0pwQnpWeUNuRDJ6MmNqMEF0UVFRQnFCUFYzL0VWanNyRGtT?=
 =?utf-8?B?eXRWRTN5eFVlb0VRcnBxQVA0ZjdWVUtrREVuMExoVDNHajBNdklUeFN1T1Qy?=
 =?utf-8?B?VGcxUHFiTXNFM25EYlAvV09wb0ZrKzBRYzNzVDVGWWJDK2wraTF4VG1tWU93?=
 =?utf-8?B?S0QwbG4wNjkzdi85MlUxOEdzUTY0aHlLb1BMeU5ReERrTUJ6SlVJRWQvWm1p?=
 =?utf-8?B?K0xBR3llSXBqU0VKSWthU1dTSERmUGEyU0o2OGM2c0s2dWNlT2lmM0xucHRG?=
 =?utf-8?B?d3pxT2JCdUxWeCtocUhHRnhWV2JPcHA0NzF1TjE3TE40SU92emtRZWdkRXdL?=
 =?utf-8?B?cUNvNmx1YWpndER0bGdpeitkamRqdTl2Ni8xelRRbG0vUUp4Y0g2OHJjU2ZM?=
 =?utf-8?B?MEpYckdEeU5oQyszNTBnSWowVVJta0hNMVVpa1g3NWMzMHVmSWxJVmh3d2JK?=
 =?utf-8?B?UFdNV2FyUVM4RE5abGxGd3F6MFpmRTYzYm9VTDNFRUdMbkwyUTNyKzhCMlMx?=
 =?utf-8?B?MmVzVHQrZ2MxcFN3OG01c2dsVmdET0UxV0ZxT3ZEbU1Xc3FDYkRwUk1hRENQ?=
 =?utf-8?B?NjJhZk1ZZklMeklJejBQanRtRlowNmR1U2lRZERvdmhCRkhRZDZIbzA1RDBn?=
 =?utf-8?B?RlREWWlobWdKNTgxK29vcGxId0VHcjQwbXRYUlI0d0VmUHJZL0t1SllpanJx?=
 =?utf-8?B?bEVwdkV0NEdWc1ZTeFliZ1BaZllWbmhLQW1EQVVPTlFIQ2JxQVFZMWQ2VnNt?=
 =?utf-8?B?Vy80Tmk1WjZDaU84WnBEVUVWMVV4WTUxb0FEOEpwZnJJbndZNWFtUmhZMm41?=
 =?utf-8?B?NVpMaktEb2cyT2R5SytOUjBTMkMzNDNtRlFmTkpGVFhqb1U5cC9NaG9DVjJs?=
 =?utf-8?B?cU9PZUVqczl5MXRJd1Z1R2RKUC90S1VjblhsZlRDakhVWUFiZFpxZ1lvNW1a?=
 =?utf-8?Q?rQiZNl2bTH5ZW5Cn5sUFKCwEB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bf6adf-549a-4ddc-d6ff-08dcb79200d1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 10:08:08.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXuwYaUJ+5kdsL9NkPDz66D3ZLfxuj7PuYg/7QjP3hUcSEy71eAoA36X7Qm3Y4QePya4G2qvyStEHnih9YlDag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com



On 8/8/2024 5:08 PM, Jonathan Cameron wrote:
> On Thu, 8 Aug 2024 15:59:49 +0800
> Yanfei Xu <yanfei.xu@intel.com> wrote:
> 
>> On 8/8/2024 3:01 AM, Alison Schofield wrote:
>>> On Wed, Aug 07, 2024 at 09:19:08PM +0800, Yanfei Xu wrote:
>>>> cxl_endpoint_dvsec_info.ranges means the number of non-zero DVSEC
>>>> range, and it will be less than the value of HDM_count when occuring
>>>> zero DVSEC range. Hence using it for looping validation of DVSEC
>>>> ranges in cxl_hdm_decode_init() and looping DVSEC decoder initialization
>>>> in devm_cxl_enumerate_decoders could miss non-zero DVSEC ranges. And
>>>> we should only create decoder for the allowed ranges.
>>>>
>>>> Initializing content of all dvsec_range[] to invalid range and moving
>>>> the check of dvsec_range_allowed() in advance to cxl_dvsec_rr_decode()
>>>> could address that.
>>>
>>> Hi Yanfei,
>>>
>>> This is interesting but a bit much to review in one patch.
>>>
>>> Please separate the fixes patch, that you comment above, from the refactoring
>>> and the drop of wait_for_valid() changes. That'll make review easier.
>>
>> Thanks Alison's suggestion and review! That make sense and I will split
>> the patch to make it easy to review :)
>>
>>>
>>> For the fix. I understand that you found by inspection. Is the impact
>>> that the driver will create decoders for NOT allowed ranges?  And
>>> forgive me for not looking further into the code yet, but I'd like you
>>> to lead me on that and explain the impact in the commit log.
>>
>> Yes, it will create decoders for NOT allowed ranges.
>>
>>>
>>> I'm confused when the above says ranges 'means the number of non-zero
>>> DVSEC range' and then says we should not use ranges while looping
>>> because it 'could miss non-zero DVSEC ranges.' Is the
>>> dvsec_range_allowed() callout in cxl_hdm_decoder_init() not doing
>>> as expected? And why is it a 'could' miss and not an always miss?
>>
>> My issue of wording.
>>
>> For example: 2 ranges, the first one is a zero range, the second one is
>> an available range. In this case, info->ranges = 1.
> 
> Initially I thought this wasn't allowed as you have to implement
> range 1 if you are going to implement range 2, but there is
> a statement in 8.1.3.8 that
> A CXL.mem-capable device is permitted to report zero memory size.
> 
> That makes me wonder. There is no text in the memory size
> to rule out setting them to zero and if you can set it for
> all of them I assume you can set it to zero for the 1st one only.
> 
> So in conclusion.  I think a good catch - though theoretical
> for now.
> 
>>
>> 1. In cxl_hdm_decode_init(), it uses variable "i" which is less than
>> info->ranges, is used as index of info->dvsec_range[] to validate the
>> ranges.
>>
>> for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
>>       ... dvsec_range_allowed
>> }
>>
>> Since info->ranges is 1, so i will only be 0, validating only the first
>> zero range and not the second avaliable range. As a result, allowed==0.
>>
>> 2. A same issue occurs in devm_cxl_enumerate_decoders(), where
>> cxlhdm->decoder_count is assigned the value of info->ranges to loop each
>> decoder while invoking the
>> init_hdm_decoder()->cxl_setup_hdm_decoder_from_dvsec(). Due to "allowed
>> == 0" in 1., it returns directly and won't run into 2.
>>
>> But if ranges could exceed 2 (though the spec defines the maximum as 2
>> for now), it would encounter the same problem in 2 like 1. What I mean
>> the appropriate approach would be to store the only non-zero and allowed
>> ranges in info->dvsec_range[].
> 
> Would a less invasive change be to use a bitmap instead of
> a simple count for info->ranges?
> 
> That way we can use the bitmap iterators (even though it'll be very short).
> Alternatively carry a info->range_offset through all this code
> and iterate from that not 0.  That only works because there are only 2
> range registers though so is non intuitive. I'd prefer the bitmap.

Hi Jonathan,

Yeah, bitmap can work. But how about only recording the non-zero ranges 
into info->dvsec_range[]? I think it's no need to match the index of 
DVSEC range with the info->dvsec_range[], as the "struct 
cxl_endpoint_dvsec_info info" is temporary variable during probe. If we 
only record the non-zero range(even allowed range), the meaning of 
info->ranges and info->dvsec_range[] can match.

The patch is like:

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..afef524e8581 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,

                 size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
                 if (!size) {
-                       info->dvsec_range[i] = (struct range) {
-                               .start = 0,
-                               .end = CXL_RESOURCE_NONE,
-                       };
                         continue;
                 }

@@ -411,7 +407,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,

                 base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;

-               info->dvsec_range[i] = (struct range) {
+               info->dvsec_range[ranges] = (struct range) {
                         .start = base,
                         .end = base + size - 1
                 };



> 
> 
>>
>>>
>>> Please v2 with this as a set. I'd prefer seeing the Fix first, unless
>>> you think the refactor and wait_for_valid() change are required before
>>> adding the fix.
>>
>> It's not required, will send v2.
> 
> Great. And thanks for the detailed explanation.  The code changes
> were not easy to follow - so minimizing the fix will also help.

True. I learned something.

Thanks,
Yanfei

> 
> Thanks,
> 
> Jonathan
> 
>>
>> Thanks,
>> Yanfei
>>
>>>
>>> --Alison
>>>    
>>>>
>>>> Other non-functional changes, refectoring cxl_dvsec_rr_decode to
>>>> improve its readability and droping wait_for_valid() to use
>>>> cxl_dvsec_mem_range_valid().
>>>>
>>>> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
>>>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>>>> ---
>>>> Background: Found this issue when reading the CXL code. I didn't encounter
>>>> the discribed issue in real environment.
>>>>
>>>>    drivers/cxl/core/hdm.c        |   2 +-
>>>>    drivers/cxl/core/pci.c        | 121 +++++++++++++---------------------
>>>>    drivers/cxl/cxl.h             |   5 +-
>>>>    drivers/cxl/port.c            |   2 +-
>>>>    tools/testing/cxl/test/mock.c |   4 +-
>>>>    5 files changed, 53 insertions(+), 81 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index 3df10517a327..65f5fd2e4189 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -768,7 +768,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>>>>    
>>>>    	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>>>>    	len = range_len(&info->dvsec_range[which]);
>>>> -	if (!len)
>>>> +	if (WARN_ON(len == 0 || len == CXL_RESOURCE_NONE))
>>>>    		return -ENOENT;
>>>>    
>>>>    	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 8567dd11eaac..c8420a7995f1 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
>>>>    
>>>> -static int wait_for_valid(struct pci_dev *pdev, int d)
>>>> -{
>>>> -	u32 val;
>>>> -	int rc;
>>>> -
>>>> -	/*
>>>> -	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
>>>> -	 * and Size Low registers are valid. Must be set within 1 second of
>>>> -	 * deassertion of reset to CXL device. Likely it is already set by the
>>>> -	 * time this runs, but otherwise give a 1.5 second timeout in case of
>>>> -	 * clock skew.
>>>> -	 */
>>>> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
>>>> -	if (rc)
>>>> -		return rc;
>>>> -
>>>> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
>>>> -		return 0;
>>>> -
>>>> -	msleep(1500);
>>>> -
>>>> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
>>>> -	if (rc)
>>>> -		return rc;
>>>> -
>>>> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
>>>> -		return 0;
>>>> -
>>>> -	return -ETIMEDOUT;
>>>> -}
>>>> -
>>>>    static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>>>>    {
>>>>    	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>>> @@ -322,11 +291,14 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>>>>    	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>>>>    }
>>>>    
>>>> -int cxl_dvsec_rr_decode(struct device *dev, int d,
>>>> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>>>    			struct cxl_endpoint_dvsec_info *info)
>>>>    {
>>>>    	struct pci_dev *pdev = to_pci_dev(dev);
>>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>>    	int hdm_count, rc, i, ranges = 0;
>>>> +	int d = cxlds->cxl_dvsec;
>>>> +	struct cxl_port *root;
>>>>    	u16 cap, ctrl;
>>>>    
>>>>    	if (!d) {
>>>> @@ -357,10 +329,19 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>>>    	if (!hdm_count || hdm_count > 2)
>>>>    		return -EINVAL;
>>>>    
>>>> -	rc = wait_for_valid(pdev, d);
>>>> -	if (rc) {
>>>> -		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
>>>> -		return rc;
>>>> +	root = to_cxl_port(port->dev.parent);
>>>> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>>>> +		root = to_cxl_port(root->dev.parent);
>>>> +	if (!is_cxl_root(root)) {
>>>> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
>>>> +		info->dvsec_range[i] = (struct range) {
>>>> +			.start = 0,
>>>> +			.end = CXL_RESOURCE_NONE,
>>>> +		};
>>>>    	}
>>>>    
>>>>    	/*
>>>> @@ -373,9 +354,15 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>>>    		return 0;
>>>>    
>>>>    	for (i = 0; i < hdm_count; i++) {
>>>> +		struct device *cxld_dev;
>>>> +		struct range dvsec_range;
>>>>    		u64 base, size;
>>>>    		u32 temp;
>>>>    
>>>> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +
>>>>    		rc = pci_read_config_dword(
>>>>    			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>>>>    		if (rc)
>>>> @@ -389,13 +376,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>>>    			return rc;
>>>>    
>>>>    		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>>>> -		if (!size) {
>>>> -			info->dvsec_range[i] = (struct range) {
>>>> -				.start = 0,
>>>> -				.end = CXL_RESOURCE_NONE,
>>>> -			};
>>>> +		if (!size)
>>>>    			continue;
>>>> -		}
>>>>    
>>>>    		rc = pci_read_config_dword(
>>>>    			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
>>>> @@ -411,11 +393,22 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>>>>    
>>>>    		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>>>>    
>>>> -		info->dvsec_range[i] = (struct range) {
>>>> +		dvsec_range = (struct range) {
>>>>    			.start = base,
>>>> -			.end = base + size - 1
>>>> +			.end = base + size - 1,
>>>>    		};
>>>>    
>>>> +		cxld_dev = device_find_child(&root->dev, &dvsec_range,
>>>> +					     dvsec_range_allowed);
>>>> +		if (!cxld_dev) {
>>>> +			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
>>>> +			continue;
>>>> +		}
>>>> +		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
>>>> +		put_device(cxld_dev);
>>>> +
>>>> +		info->dvsec_range[ranges] = dvsec_range;
>>>> +
>>>>    		ranges++;
>>>>    	}
>>>>    
>>>> @@ -439,9 +432,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>>>    	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>>>    	struct cxl_port *port = cxlhdm->port;
>>>>    	struct device *dev = cxlds->dev;
>>>> -	struct cxl_port *root;
>>>> -	int i, rc, allowed;
>>>>    	u32 global_ctrl = 0;
>>>> +	int rc;
>>>>    
>>>>    	if (hdm)
>>>>    		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>>>> @@ -455,30 +447,16 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>>>    	else if (!hdm)
>>>>    		return -ENODEV;
>>>>    
>>>> -	root = to_cxl_port(port->dev.parent);
>>>> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>>>> -		root = to_cxl_port(root->dev.parent);
>>>> -	if (!is_cxl_root(root)) {
>>>> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
>>>> -		return -ENODEV;
>>>> -	}
>>>> -
>>>> -	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
>>>> -		struct device *cxld_dev;
>>>> +	if (!info->mem_enabled) {
>>>> +		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>>>> +		if (rc)
>>>> +			return rc;
>>>>    
>>>> -		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
>>>> -					     dvsec_range_allowed);
>>>> -		if (!cxld_dev) {
>>>> -			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
>>>> -			continue;
>>>> -		}
>>>> -		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
>>>> -		put_device(cxld_dev);
>>>> -		allowed++;
>>>> +		return devm_cxl_enable_mem(&port->dev, cxlds);
>>>>    	}
>>>>    
>>>> -	if (!allowed && info->mem_enabled) {
>>>> -		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
>>>> +	if (!info->ranges && info->mem_enabled) {
>>>> +		dev_err(dev, "No available DVSEC register ranges.\n");
>>>>    		return -ENXIO;
>>>>    	}
>>>>    
>>>> @@ -491,14 +469,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>>>    	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
>>>>    	 * Decoder Capability Enable.
>>>>    	 */
>>>> -	if (info->mem_enabled)
>>>> -		return 0;
>>>> -
>>>> -	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>>>> -	if (rc)
>>>> -		return rc;
>>>> -
>>>> -	return devm_cxl_enable_mem(&port->dev, cxlds);
>>>> +	return 0;
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>>>>    
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index a6613a6f8923..6d9126d5ee56 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -790,6 +790,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>>>>    }
>>>>    int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>>>>    
>>>> +#define CXL_DVSEC_RANGE_MAX		2
>>>>    /**
>>>>     * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>>>>     * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
>>>> @@ -801,7 +802,7 @@ struct cxl_endpoint_dvsec_info {
>>>>    	bool mem_enabled;
>>>>    	int ranges;
>>>>    	struct cxl_port *port;
>>>> -	struct range dvsec_range[2];
>>>> +	struct range dvsec_range[CXL_DVSEC_RANGE_MAX];
>>>>    };
>>>>    
>>>>    struct cxl_hdm;
>>>> @@ -810,7 +811,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>>>    int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>>>    				struct cxl_endpoint_dvsec_info *info);
>>>>    int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>>>> -int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>>>> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>>>    			struct cxl_endpoint_dvsec_info *info);
>>>>    
>>>>    bool is_cxl_region(struct device *dev);
>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>> index 97c21566677a..a8c241cb4ce2 100644
>>>> --- a/drivers/cxl/port.c
>>>> +++ b/drivers/cxl/port.c
>>>> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>>    	struct cxl_port *root;
>>>>    	int rc;
>>>>    
>>>> -	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
>>>> +	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
>>>>    	if (rc < 0)
>>>>    		return rc;
>>>>    
>>>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>>>> index 6f737941dc0e..79fdfaad49e8 100644
>>>> --- a/tools/testing/cxl/test/mock.c
>>>> +++ b/tools/testing/cxl/test/mock.c
>>>> @@ -228,7 +228,7 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>>>>    
>>>> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>>>> +int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>>>>    			       struct cxl_endpoint_dvsec_info *info)
>>>>    {
>>>>    	int rc = 0, index;
>>>> @@ -237,7 +237,7 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>>>>    	if (ops && ops->is_mock_dev(dev))
>>>>    		rc = 0;
>>>>    	else
>>>> -		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
>>>> +		rc = cxl_dvsec_rr_decode(dev, port, info);
>>>>    	put_cxl_mock_ops(index);
>>>>    
>>>>    	return rc;
>>>> -- 
>>>> 2.39.2
>>>>
>>>>   
>>>    
>>
> 
