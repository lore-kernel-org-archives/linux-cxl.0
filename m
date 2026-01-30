Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD8329E49
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749097; cv=fail; b=SNd86KJMgUtP3vIbHvP/UdfdvZuuoudFCjZbE2eCHxA7wPAm6Dl+ep4k9DxeT1Kt7ubfX1EARV4ZprFP3A2PXOqnFw6n+lxfZRsSo51/HAcr0SYX5lU+JXbMIgYtPmRzwDniqvbb4Etk2WuyFLm2ycaMFTDuQhp3g2R6VTd5hBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749097; c=relaxed/simple;
	bh=/rPT6CliZNn/YIIw5hsiFCVAG8loP2COyo2xpti2qlM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=VdSCz74p0Hf37ycr8lajkMRsbgYcgZDrTAbQADgyruUfghrg5VR+uHk5dqwLGsDDDV7WiOFIRw1gJK8tBWklznZwYiFmWTL76B+A1mwuXe0fgu1RSQpqlj34Ht/jrybVLFhZvCNVDFN0IZyeQ3SSJ+CipkOgROiSVIPyD2OnNTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSW8u8Zn; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSW8u8Zn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769749095; x=1801285095;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/rPT6CliZNn/YIIw5hsiFCVAG8loP2COyo2xpti2qlM=;
  b=gSW8u8Zn7zo7pAd5sWDwmu/YfnjZtwrYM8lt2kjM+deukov0zxRJJLZ3
   rKrTg8MjN92mk98XnMPYlDx/dXlBI2IKZU0zcTlAkKyybp9AwcUYWFxht
   M1ycc/yd38fVssRJkt9lX+G4UZwHY0VU3Sesy/tnsakTFfllhqhF8TdPP
   91IEqKcML5RINWqHHqbZ4ht4ywNz5e6WqocqD6b+t7g7dZPdBO0E3TPU/
   W4F2DuQ25btwoWMhQ5PjSovaaoQqIuCxhEqwFH8B8nVl+19tSwTfdiZbr
   2H0srBUPkAABEIGDZHaw6IRcofp372e/5OimLJ/CGGcUpgmSuWQdmaUcV
   g==;
X-CSE-ConnectionGUID: asyL1oFTRS6Mje/avLjORQ==
X-CSE-MsgGUID: RZY7evRcSpulUhNjrV7s9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70898288"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70898288"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:58:14 -0800
X-CSE-ConnectionGUID: hXHVi1S+TpG3IlaCb7aM/g==
X-CSE-MsgGUID: XBum5fTQQbKS/Jbvezpo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208867384"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:58:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 20:58:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 20:58:13 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 20:58:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTJElQG/9C3gAnInjnhHMNIL/p6PcZElZ/ybUQ9QUOEdzXpNh3ftEl7hTiLv675iaHJvE7hRQSkVXXb4qEadTwu0sHQOPQwQE630ciw4nQZ60ZE4IG+LhKXsffGhyV7KDw/59A8MHLyZ6qV5GM1MZpLJJ0N8KApCY52Qrt9N0oJdpUGV/KcO6eLlzQigMBcJ3X0fZa5Apy+HQ0fg4A6tggfiuAN+JrWc2dNHfiKrINPLjLYNbirE9PLnYGdafTZ0sXzUWLSabC8Nvs4ZvuUwN6gl3REdnKV0n4I5oP0bxZIMFJNYLurHOlGc4KTuSXnV9/f4Xu60JT8Z+gN70Dt65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rPT6CliZNn/YIIw5hsiFCVAG8loP2COyo2xpti2qlM=;
 b=bnL3ZH/cMNP+rZpPrps2bKYNyrsMtZOkZZnUGuCycEiWMmRdtoKQ6i+I72ppw5kC7hN81s8ULuEiEMsajFr0wn1EYPeGGvdEyVnqDgA1qjQ3HfYknv6BB1bCz+9uuVrCKCPI0NJ2qaCPHbB5o/xxse9ypwbIvz7Gmwf7R8uRxDeXXG4R3whJBdVTt2X0b9wk+iLwGSroH0L0d708S5pjZexwc/ahC1YdKlF5CLr11RphspRg5Ly/H9Har27exmcVjjusBb13OkcWhzl8vOshAVWKi0TMpD5zyhiig42pxqGMqze3Rx/9nALCGEDPq3e+sIIskP6KXWtFwdufFgCq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8407.namprd11.prod.outlook.com (2603:10b6:930:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 04:58:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 04:58:11 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 29 Jan 2026 20:58:09 -0800
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <697c3a6155b46_1d6f100e1@dwillia2-mobl4.notmuch>
In-Reply-To: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
Subject: Re: [PATCH 1/2] cxl/region: Timeout auto region assembly waiting for
 endpoints
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec887bd-7ddb-4bf7-b49f-08de5fbc2ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTdmQTJiRkJqbUJybGF4RjRmOEJOZHppcmcxOHdVRG1Jd0RjN3IrZE9xMHZs?=
 =?utf-8?B?R0VLMEpXTkFYTmZiSTY3aGJqZU5VeXBpbjlpWXNQZTJ2UmM2L01QeFpVc2lQ?=
 =?utf-8?B?RHZ6VlhRRG5rdjBXZldXRzQ0b1hlRFdPa2FkUzB6UldPaGYwc3V4WndyVnZn?=
 =?utf-8?B?QlNhRWJCTlczS2dxL2l3Y25CL0pqUjdzV2RpZlVYV2t0SHhhd0Eydll2TUx4?=
 =?utf-8?B?NHduNFVETTU4Zk5VVjVjMFlRMFBGc0xmTitJVFcrUHdTbEQwcWdzdEY1Ry8z?=
 =?utf-8?B?U0ZqVFVnWXFZSDREL0lWT0Jia2hBUXlDb0I5QUZvVlVjenpmb0tWRU9wekU4?=
 =?utf-8?B?SXBZWlorOEdBRjBFbU5UZnJmc1Eyc25Hcit6R1ExM0RDaXNGTUFGOEZuTkVN?=
 =?utf-8?B?VEoxRFBOU09FTE4yMWVmM2xoNHQ2K1NFcVlPVXlTc0Jtdk1IaXdRNEV4Q05o?=
 =?utf-8?B?eGZnMm1DbEFUR1R0ZjErS1ZBQ0VXNTh4N3N6dUVxbmluVEZmQi8rTE5UVXBD?=
 =?utf-8?B?SHhTVUcyOXRSeTVBdDZjRzZaV0hMbXBNSUNkdmxFTTdJanBqTWZvUkx6NGtP?=
 =?utf-8?B?WUlMSFFNL2l6MENrcVlBVDdIMWVaaE1TNUlYc2hwUXJjaW9WNTc0L0h2VnZx?=
 =?utf-8?B?YlhIMjFwa1VhY21hQjdCY04wUjVZekxsNCsxTjZBa3pRb3NldTErb1lpR28y?=
 =?utf-8?B?VHZLRXlMbUZLYUlnR3JNQU1RTElPUVRaWnlPS0J1ZXJKTkpROFdyUitzZkZO?=
 =?utf-8?B?ZEIvMTZsWkxPS1AzNXhsb0tnZTBXblBGRTZrekVsVENCS2ZVR1RtWFk3cTNI?=
 =?utf-8?B?T3dxa0g4dzRGOVBXemp6YzF6VVo3QS9mSEdrMnVNdGhXOHhMbkdKTTRHL3Mz?=
 =?utf-8?B?OUFldjJGSFp2aVpjZXZEWklOTmpPUWZzRFZvQU13M21nbVVnSnZCWTFwMFNx?=
 =?utf-8?B?aVhPa05NSCs2cEhZQjRuNmozdGx5d0pQYTIwaXQrUXoyek1scDNJYjZrVGFs?=
 =?utf-8?B?NnpZQVF1TmE5MEJSTkxmQnlhL3lOUGFxQnR1Y1NCbUt6TENGeUhSY2N4cFJK?=
 =?utf-8?B?SHNiOFJ0SGdZYmhhQk9wSm1SMkF1ajBaVUFTWjhWVSthMFRGY0VyWWI4TFNO?=
 =?utf-8?B?aE4rVXJENnUwa1dSRHA4Y2QwMEtmakxta2dINTNSWk5sS2xmS2lYRG9tQ0I4?=
 =?utf-8?B?WVc5NkVKUjRiNWQ2U0pSUTdlZ1I0SnozMVNjV3ZyenRDZWMrbzl0WjQraDNo?=
 =?utf-8?B?a2xMZTVLOXhyQTB0azZZYjlLVmV5WDA1bnMzU2lyMFp2REgxOGZJemYzQTIz?=
 =?utf-8?B?dmxPdGNOQUJZaVJ4YjZDZDUwNlhFM0Y5Z2d4cFQ2blhIcXZrSUpJSm9WQ1Jt?=
 =?utf-8?B?RmYwSm1WZzBSbCtWV09LcldPeTRvR2dSemIvRVI5eHNVK2RtMTBNUmlPOUtF?=
 =?utf-8?B?TEtEazhac1pvMThEbmw1Y3RrRFpPaFdVWmU0MWp1Ulc1dEpkdDhyT3pSZGhm?=
 =?utf-8?B?MXVwQmxvaE1nNWx2OVZHeFdPdWVEVUIxcGMyYllUMDNYZ2ZnNWFPTFc3RTd6?=
 =?utf-8?B?aXBYTm4zQUxZUmZ5REgvSGt5UDBYU1pPeldEYVFod0dRUUh0THRQcUYzUnR3?=
 =?utf-8?B?R20yckYzd0xEc2dBbDU3cTByaW1FQkZZamdVS0xTY0ZuR0dQNUN1SXhBRzZU?=
 =?utf-8?B?czh5ZjR5MmNrb2VDNG95TEpDblh0bWFjaWlQS092RjhkQzVVSWVRNG1LVHhh?=
 =?utf-8?B?VkFLNzJnWGJ2UDN2Ty9MM09QOFp1NGNoZUN2d1hoSnUyMkwwOG5YRTNpN2pF?=
 =?utf-8?B?WDlzMnY4MDU4UUJVSHhDWXIyZGZ3VXlXcjRCaFJYSGR2SHhKUUMzZ2hNYk00?=
 =?utf-8?B?MW5GcDIwRU9kSS9rampRZG8vb0U0cEJrZnNVNkR6dmN1YjZ2bnNCRTl0ZmtN?=
 =?utf-8?B?bEF2dlBxVk90UTBCVnUvSVIyeXVTazhiQWpCMEJZV2RNTFFpblBJR3JJT0Q3?=
 =?utf-8?B?NDJ6S0lhSHVMWGVQcTl6dk9IbUt5MDVJdjJOVjUvMU1zeEtKdUxGeHBNQnRO?=
 =?utf-8?B?eE90MU82TXJJaEZRMnBPc1laVWsraHNaL1pPT1JGNk11RXQ0bmZGN0tPV1RD?=
 =?utf-8?Q?MN3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRmbUlaSm5iSXplVjlFTUF6cyt1YnAyTWExWlBxSGNEaWJSV0NscFgyTlFi?=
 =?utf-8?B?QW50VDcwMDB1ZlVBbHFkdG91YXhqTFc0Z3JGMzVHMkU3Z2dmZ2U3ZzZhYmRO?=
 =?utf-8?B?bVN6TVlybG1BSlQwZmJKZXRRRy9YVFY3TXJXb3NtODc3SnE2K0QxeThoWmJO?=
 =?utf-8?B?RzFxYXR0VGJjcW96UFpZZkhUUlZaOXo0VXhPSHp3M2RXRXpHMFhKNm1vRVZx?=
 =?utf-8?B?NmY4RTlWQjlBTmU5MERDVWhPejhJR3VkUEFnN2NZSTk4WTVZbG81RVlzMmpu?=
 =?utf-8?B?OXpUTEFQRGdKZGg4Ui9ISTdiNGpBdzlWbFV1VERxUDVBd3RJeW9kYnBJV29T?=
 =?utf-8?B?YTE1WHQ0ZWpsS1hZRldCM1dHc3VlTWo1cE40aUhKZm5Gdy9BSnc5Zkx3cVF5?=
 =?utf-8?B?S3dnalpUODJQQzNNUEIveXhudTFoMlo2VTVzamRacytRWU1Pa2h5QmRRSTBh?=
 =?utf-8?B?S0JCVE1FdTduUkxSVmorK2p5TWZ2ZkNlWGNQYm92WVdaRHB0L2N1WWViMlZ5?=
 =?utf-8?B?SkFBMWZjM1FaQ2xaL1VFeWNSay90TkZwR1pzVnU5WXVMamhuTk9Zdi9xZkFB?=
 =?utf-8?B?c1VZUnhKMXRVWXdjZk5QYW1Na3lnQ090eTlyL1prS1lHWDE0ZkdUa0MzRVY2?=
 =?utf-8?B?NkorZ1JBNFZobnRsRkZIendEV0dqSTRRdEZiYmtQb1ZVQVpRNTUzOWxxV2I3?=
 =?utf-8?B?VGVCcGEvUGI3VG1YZ0JRNHNuSW41MkFJZWhDcWEyM3hRTmRjWEJlK2J3VC8r?=
 =?utf-8?B?R0Vkc2cweHp5MGpXT2NMclBTQ0J2WlV2RjdyUW5IcnNMcE5SRit2MFMwT3U4?=
 =?utf-8?B?bHkzNnUyMGdqaUw2eGR1UE5JQmFjbWk4SWlkZTZnZEswNitzc3ZUcXpUd3Jo?=
 =?utf-8?B?OTJHTTYwN3A0NGN3Z04yaFk5WlJTendUZy91MGRVM2dMQ3MvN0ZKZllHWGFq?=
 =?utf-8?B?SzBRWFF6QkZ3OHUvNzVFMkJiQXpmT2ZGQm9lcnZFVjlSM080NmY1QTMrWW14?=
 =?utf-8?B?dS9uWkFhNnd0ZFlLallzT0s4c1lacDhpWUJwUkppWEdrcStBU2lYcHVEM2l0?=
 =?utf-8?B?WldHSU1lZEZkZ240NkJvYU0wY2VXY1lXcVdkNk1Ienk5ODgzc1B0KzRRdC9U?=
 =?utf-8?B?b1M4QVJMeWxLbStBTStUQi9qc2dEUWlHMzVENmY0bVlidDY0RVhyTTd0Nks0?=
 =?utf-8?B?SlB3YlJJZFpjRmdsYXZQSkRDWEhOeUwrcFVJZFVIK2xZTVJQNXllY0owQjR1?=
 =?utf-8?B?ZVNmS29pN21JWkxsUTdoV1VxQ2VINTdjdGsyWGNXZGkzbVFONUZRQ1lEd0Ry?=
 =?utf-8?B?a2VpZkFhcDNabzlJeFgyTEpqMlZ0SnFwM004RlpPSDlBakY4djFPNzZHY0p6?=
 =?utf-8?B?dmNPdzAwR3lMWmhBbWpnVUJSLy9PS2R2NUkzV01XODNuSjhFN25tajJKWFVU?=
 =?utf-8?B?ZHBzaFg1UXFqNHZ2UmcrKzlEUy9ueGxRdVNDWnJoMWhKeG9DeFo5Rm5KU0Nq?=
 =?utf-8?B?MU9iUjNTSyt1cGxJdlNGcG14QlA4YWNjcldwOTVJUGVpQ1Vla3lJbjhPVTBw?=
 =?utf-8?B?RWFkaVJvOFFBRWg4VXRXakY3bUliM2ZvWmdVZHlUbXVQNmJrdGwvVC9TSS9s?=
 =?utf-8?B?OTV0WHovRFdTVVF3cFhnTDhEQ1d2NSs3RkV0WVEvQ0NDc2MzMFlQeDdkT1Nt?=
 =?utf-8?B?TkI0SFU2eGp4NGdPRGp6RjE5SVQrYWxwWHFZY2UwWW5sQTgxb2oxNXJJZ0Ji?=
 =?utf-8?B?UXRIQ0x0MGtNNU0xZGRiMVN2NXliMVByNG11Ym9LOEtRc0ZyM0h2L2ZyZDVl?=
 =?utf-8?B?N2FzcVpaSGFtMTJ1UmUvL2RQUzRBSDJjUytXem1uREQ2cXpjaGtwUGNaKzBN?=
 =?utf-8?B?bHRiQ25CR1p0UXdBa05vZEFxMXhEVXRlWmZWeWowTmI4M1dwMDMrQ2JKem5q?=
 =?utf-8?B?RndIanVjZGtCbXlLN0NPb2o3NEpkNTBrTEdHM2VWRk52am94VVBCeStJMkds?=
 =?utf-8?B?djIzKzVlYjlEWHZHc293YmdvSXBqVTczdDRCc0Uyc1NkYm5VMVUxMGRsL1Ay?=
 =?utf-8?B?MDlSbThnZHNNVTNCL2tyQmlhMkQzd3J4VytIdVNnTHR1SzRqLzZycERpZ0xD?=
 =?utf-8?B?MGxSUU54S1NaVVMzR0FTWStXS0ZtY0pyaElUTUl5M2lZUjVPeW12WXl5YTJq?=
 =?utf-8?B?T0NWR0FrajlhWjNNaE5nQ3c0ZE1BSkF6L053UDVPSUxteUZKVk41WUt5V1BF?=
 =?utf-8?B?UU52Tys2UjloYkhIS1VLMmlSckFtMklncTM5MUN3amFQMlJYTFZPSFdtdHNQ?=
 =?utf-8?B?emlYUHBza0lxZFB1KzhvTmhGT04vSEZRdUhMQ24xY004QTJvaFJ1TEE3UUQv?=
 =?utf-8?Q?XDUnORwjPLZVjkJI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec887bd-7ddb-4bf7-b49f-08de5fbc2ab6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 04:58:10.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNdzvacyo6zCz9+ASZ4nr4mTWOyBxF/0JCES4O4I6t8CYxuxDoWrAnQOApxp46Eft0OQglfkAL8UJSJvojh5hSYgSG0czQD1fI2N/nlXo9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8407
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> Currently, if not all expected endpoints arrive for an auto-created
> region, the region remains registered but disabled indefinitely. The
> region continues to reserve its memory resource, preventing DAX from
> registering the memory, and provides no indication that endpoints
> failed to arrive (useful for non-DAX configurations).

Does it block DAX? The HPA reservation does not mark the resource busy,
so DAX should still be able to operate. It might make a mess of resource
tree, but not block unless we are in this case of the boundaries
misaligning. I would rather rethink the insert_resource() in
__construct_region() if it is indeed a blocking problem. It is already
the case that an insert_resource() failure is not fatal to region
creation.

> Start a 30 second timeout when the first endpoint attaches. If the
> remaining endpoints have not attached before the timeout expires,
> abort region assembly and unregister the region.

The time to give up on regions present at boot should be at the end of
wait_for_device_probe(). There is no point waiting any longer for a
device that was alive a few seconds ago according to the BIOS.

> Cancel the timeout when all expected endpoints attach or the region is
> unregistered for any reason.

Setting aside the above, this looks like policy, and every time I see
policy the first question is "can userspace do it?". It would be
straightforward for userspace to kick a 30 second watchdog upon each
region KOBJ_ADD event. Each time that fires go cleanup partially
assembled regions.

For example there is no automatic cleanup of partially assembled RAID
arrays. So, precedent leans towards letting userspace decide what
happens when composite devices fail assembly.
