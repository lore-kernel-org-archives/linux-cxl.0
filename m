Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513D3C0881
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118159; cv=fail; b=Y1mwIUVweJajJImgy4SIwWvbLvcs6Av1opwcCKwPK7arJ9q3n9cEsqNcKkT219yqAfS+HhncVBhLWt54lLbATn95MH6UzniAc0HhsOArIPqCjDZFm8lo7U+OdZLMSgxX9+HDMi3bG2JYusxJ6QOFIDP7fkyRp89KLFdvYWNEXdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118159; c=relaxed/simple;
	bh=IMbbJjiLTBc0ucU86at6e0i7ZyBT70+9JnROgEhYX8M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NGkw7ggLG2AaO7WmAk5F2fEVZBBtc1HvsjUoOrNAZgbkZnTyiqFh/wLAIwlblWqyvKAqvBLH0+Ou14bkAPfTTXqAZzAU+oKvJW94WxEKY8dSXpuUlcItUEMmHLiO+7+o1IFHoRxlXJLBChlvHgv3hMK4rkHp4lSd361HU5JkYAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXutB0fy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXutB0fy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769118146; x=1800654146;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=IMbbJjiLTBc0ucU86at6e0i7ZyBT70+9JnROgEhYX8M=;
  b=dXutB0fyu53Q9MtoVCqFRKPqkB13z/kUFK4eMzDyll+FUBwhOrNjAyA7
   z7Ke66eS+zfNGrCaE80xqusOB4NHozm+uwFne7BtuJwPN9uKxpECkCK5y
   VPp20URRVSxbF4zOBmVjyuZgDiRnUspCIOGpl+ImYOtRRWgbOIaWi6B3B
   iujqoUt7Vx88vazAGKmooYctTaBVGMYomrT3kB6it//SBmjPsG6QgCLC5
   bBUzCyv37JL6f5AkPX9UfJ4sdIrpUo9uxWvr0N+XkvgTfRXG/opHb1T6O
   +u/64yqP3sy7f1XarWuJntjCJU9ZkOLgksnGHfBcd16conFxe1QJQE0wW
   A==;
X-CSE-ConnectionGUID: 5urQnlLgRoiDKioX8JBonw==
X-CSE-MsgGUID: XoazNNdnRJe4CYZ7eAf4hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74223152"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74223152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:42:21 -0800
X-CSE-ConnectionGUID: ScGVmorFTLiq1mSXnjLhCQ==
X-CSE-MsgGUID: FrvlPU0hSQysoggsytmRjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211349004"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:42:21 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:42:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 13:42:20 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 13:42:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kttQ65rqPFmFAzQWCtYe7m8Ai/2jQZV8saRq4XSmhu2czrLiluFU0ED6n0vJ7VfmUUbRkBCIieaFx/4vk93f30AyKMtXSZ2uDNwwZYnDVPruOzTI5ZVuCzgyo8YbwaVYWO8lNlQjn+EgX1c15EwHCZdNbhztk7AVGivzKsmgLbMqcNRiSDHWqLU+sqyP3fYxnt6/rCc6IsRvzFAC0eHZmnlrTdltr6D9wbTgvUqZjW3/5Da+iuMHUHaouJyawtpFhdubPpQ57zKUHu5NbuDAA3QpuAalaDnPR4Dl+2b12mxdcNrzyEKoX5Y9UfBGqYzw9C6LX3gKztdoGYgtgqxybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Y0IZ6dDxZF4T+TETVQZyVMwzcWvwvNAKZE9M7Coqk=;
 b=OMvyOnge0BUjIa8mWmCRJHiFAoHjOBWPweDb6QKXuJm4+zU35WT4G1jyI84lA1AomJZ1+pCdm/euklxInwEZJMAZ6yrBX3C8vLPlUECm3qZuMeZDQnXQr5/I7RkTfq0f5WSwk6DXG/n3qBJqVZaGX7QjURZdoB2K6FM/kmY6d1Id8kNUqkowi8UghJRswchlQ7BdTlcklKnpRltCLMD6VxK+hijCuwR1Q2o9qlSO3DswNDF58duvu7fwyHzFRebE5kiZAAP61AnVubrqBaxV0UAIDahOpqTLrCaHySdEqol88kiK49CHJtzlLnIxK12N8NT8O6fEzHFIPWySKDVDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 21:42:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 21:42:18 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 13:42:16 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <697299b871241_3095100a7@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122130755.000016e4@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-5-dan.j.williams@intel.com>
 <20260122130755.000016e4@huawei.com>
Subject: Re: [PATCH 4/9] cxl/port: Move decoder setup before dport creation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 48406d36-88d7-4659-013b-08de59ff1d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjg0d2RMcnRtS1NVS1BOZ0JwNnlweTN6MFRuUnIvREZON1d0R29kK2t0S0NY?=
 =?utf-8?B?K3NMWG9ZMHhGU1FNY3RsNU1CcEVJZDliazZJTGVUY0NmcmtuNVNGVFpGbkhi?=
 =?utf-8?B?b1dKcmV0K3AxVVVyeGM0RVhNNUtrS2F3NUdrMURGQU5nWENkMWpObVUxMVJn?=
 =?utf-8?B?OGhleDc1VCtINlIyRFVQS3VEdHVWR1YrOVZoZ3BERTdhSlVHU25kOXpwcEFX?=
 =?utf-8?B?dmRsZG1wL3lnVGVTak9XWDF4Ymg2dmltTEo3aXBWS0dPNUV1MEJiSW9ONHRT?=
 =?utf-8?B?NG1LZWdtTnQranBPVFVvb0gyVlVNWE8zNjR5Vm42NHozK20wRzZnRTNqRHQ4?=
 =?utf-8?B?Rk5Hbi9DQ2tBZDhiNTdkOHRVTVEzaml3dTVTcXBQM1E5ZCtvRVFxRlN2Ykht?=
 =?utf-8?B?S0ozRGpONU50aWxFN1ZkUE14TFJPRDZnTEgwSExwZkRmVUNlOVUvMkhnT1VY?=
 =?utf-8?B?bzdrVEU1N0pIM1IyMFdGckZQV3h2VEswQVFkSy9CUHN4OVEyQ3lYQ3k3YVhE?=
 =?utf-8?B?NVJJdHAraXVqNVVUQ1hUenpMQVFIRzVoSVhGSUkzSmZ1QkZMUmNzMDExeGls?=
 =?utf-8?B?bFNETmhvUmFPL0FlZWIrOGd1amdzam9DZmpSdnBuZ2EzU0ovbWp6eStNZkNI?=
 =?utf-8?B?SVdSSUNKdWQxMTRYYkVPYnNsbC9KMG1NakV3NzJrQlIrSFpSTndlR2VrNEtB?=
 =?utf-8?B?WXpqUHRuUlk0dmRZU2t1NFBWZ29zbUVMbWZxcUoyOUozYzJ2cjJlKzFDS3ZC?=
 =?utf-8?B?MGFwOVhjWjJ6K2grYlRxZGFEZ0pGNGwvRW5EWlBuN2p5TlVjNkJQb1VDaU9Y?=
 =?utf-8?B?S09wQy9WQmZQS3pYY0paQUtmZHdVWVN6Y0JwN3A4UnAzczJvYkYyK1Z2T2tU?=
 =?utf-8?B?SmpDTVp1Zkk1WU5WZ2NockVBK1dJQkJxYjkyRTQyL09SWWQ5dnR1a0xNbDVK?=
 =?utf-8?B?NHNCWjdCTk5WVE1KVjBCcTMzNTNUVDk1N1Z1N3g2c1dQWmUreTVHcXNhMHlU?=
 =?utf-8?B?SXFpcmd6YWFXMG1nNHYzRGpLTDlJN2c1ankrbGVYeHE3S0pLZUJXTXpEME5h?=
 =?utf-8?B?Ry85VndjdHlnY3luYlZTb2Q5U2pjdkxVeUoxMzlWK0E3VTg5UlJMRjJrRGht?=
 =?utf-8?B?OWVTb1BrT0pZd3ZmWklIWHI1aDNadzliNjFWdXcreGRtdmhMclBWbGdpdE5k?=
 =?utf-8?B?RmE4K0QwZUs1SjE3M0pRZ0VXZkRFemNHVm5RUnBoeVFWWWlacWMvbys4UHoz?=
 =?utf-8?B?amZZdk1uQ3Zxa2RsSlJDUkFGSS9kMlZJaENJZmpCaEFCRmw2ZjFhcVU2SHZn?=
 =?utf-8?B?b0RqWU1oWCtMOEVaZm1od0RLV1lZalVNU0o4dUV2K2ZpWkM4cUxMWE9LUW83?=
 =?utf-8?B?clBCYWNidjBhSVB3R2tPYjI2bUEyZnlycTV4ZjRyM0NlMllFM0NvR21NLzBT?=
 =?utf-8?B?anZkQXdxNVdyMFY5bzAyZ2dsSlhFelEyT3QybmlHdWwzOGU0WjRDdE5HNlBZ?=
 =?utf-8?B?N2Fwbk1xNERna2RyNXN3WU9CQWFDbDJyYndwNjJ1QS9SdGNBYXpHa3J2Y0pt?=
 =?utf-8?B?elZJSFFvYVhTcmh0M093Q0g0d240d0JpckpFeGhMNG9jUk4wUzFDS3dqekRE?=
 =?utf-8?B?dmpEM0RLSndDZ1pFc0NLYS81VmYxSkVoSDRVY0xwekpZNjhrNU51UU4yZHk3?=
 =?utf-8?B?ajJhczNleHVBWHRTYjVPOWlHdHJ0NGpGMy9oUmRickYzd0pudEN1NWp4ZVRi?=
 =?utf-8?B?QXFJL2EvTXJHOGNuRXdoeHNxanQ0amlFUHRjZC9jK094bjArTUNFMVdQaE1w?=
 =?utf-8?B?Y0t1ek1EbkNyNSt6TFg4ODhqTG9DaTR1RnliVWlsZWVWT0tjUEFsOHZkbmJZ?=
 =?utf-8?B?cEtRVmFJaXdySmJqVzRQaWZYUlVYY2Q5dVFTMUF3MFE3SUVMcmRCMTBqU1h1?=
 =?utf-8?B?MG5Ia0NvMGJsUk5zSGd1RG94bDZSMlRKYy84b0hDbU1JL0I3Tk95ZTczcWxT?=
 =?utf-8?B?VFA1cW1OWXI5VU1Cd0kyQldnSFYxeEFSUmdkZmR4cUdpSEdaV1BSV05PNU1p?=
 =?utf-8?B?a3RhbSthVW9DQVhZTkhCOG1LK3REUXV1L0w3Y2gvd1o4OGU2REc3SlJMRnhG?=
 =?utf-8?Q?FJck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG0yNXRrL1MxVE1WL1ZVdVVkM3IvcXNrOG5ENEh5MU9kYzlxVVF5NytTRDJt?=
 =?utf-8?B?K3ppUGFiSS9WZjY0cE00ZFFMZ0toQVhOaXNpckxjNFQzSno5TkVnRFRLRUY5?=
 =?utf-8?B?ZUY0bU1CS2VOWmcveE9jVU1jS3VkREpOem1rSy95bzlHWVdub0VkVGpwbWNu?=
 =?utf-8?B?bTlCYzRVZHVvVEhkL1FSeEdnLzVpMHFHSjE0c0VTZWJlVnFrQWNZV1BvQzNs?=
 =?utf-8?B?dzBrQmtMMDdYY25meEQ5RDhJUmVTUitqLzE2YUNJbjRYSGpkTGJ0WTlDOTdw?=
 =?utf-8?B?RzNBSlluYklwMFRaV1hOR3lMRnpVbTcwd2Fsb1dCRFRQOEFva0g4eGtQUGFW?=
 =?utf-8?B?QXZiNzZVTTEzSzRBOHNBdk1wNDM2NHZ4eWx2YXRVZG8xT3ZHNWVBREtzY0ZI?=
 =?utf-8?B?Rjh5VTZUKzg1cHQ0VFlOU0Z5K0R4VmZEcURGYno0K0t5dnhlK0VTQnFrUFpU?=
 =?utf-8?B?aUdpT1pwV0ZYWndoWU41djh6TEtDRDUrbytnbW9XV2d2TjA3MGVUOUoxTitU?=
 =?utf-8?B?cys3Zmc5WkxCYW9rdkF4dTRjS2NrcXJFWTdoMW80TFFJVkFVZkZtNnFBMWZM?=
 =?utf-8?B?MFZMSzRPc05WY2hHcERxRW9tdUdzU2lWVXl1Y3JHM1lWNTRLYWUwMlRTYTIw?=
 =?utf-8?B?YjZHenQxcUxiblNHT0V4Z2xYOFNvSnhCRmliWTJ1aTI1a2lYK1dnd0piblZD?=
 =?utf-8?B?UVJJd0VsdkkzVzExLzRkTjIyN2xqZzRZSmNWNXlaSjJ3TThWaTBLRmROUkwy?=
 =?utf-8?B?VFFETXl0enZ1MWU0OUFZMjA2dGh2RGpPaU45cndRc3AyVkV1ejJnbEJiSG16?=
 =?utf-8?B?T1BqM0lZWERjbTJqVnZCVVF0amUvaWNUWWF2MkNUNFd2d3JRckRCaGNORUpl?=
 =?utf-8?B?TWQrVEpxdlM2RTRCOEhiQmk2c3IzanBDVnIrSGhobEVBMTUvS043YVhuN0dV?=
 =?utf-8?B?ejRzTW5nUmJCaWxnSVdCalZBdldyS2JzQ3hhblM1Z3VpalRwdHdJeE5YRmls?=
 =?utf-8?B?dloxVVJsY3Q2ek5jZHJWM1RGS2VZMVMyK0k1TVFKVlFiaitwU1cxSnVHUjV2?=
 =?utf-8?B?MjdCS1VWRUdieTFVUXlzWHpzN01DeVJ6MU1Sc0QxWTFDVTZ3Mm5SQXpIdkxi?=
 =?utf-8?B?YXN0dS85RzVoLzJCN3J2ZGxHMUl6Zk9uZFUwMElrKzU4NWgxVysxTHIvcldY?=
 =?utf-8?B?UkorVVlRaXFYeEFiK2xSN3M5eE03ZklJVW1iLysrdDBaYnBFWVptWUZrUFBm?=
 =?utf-8?B?YWwxQWxreVBDNXhieTdZNThwdGNHM2h0aE8yMWpVczRSQ3B4MmVEeURFSGZ5?=
 =?utf-8?B?UU1WM1NxMUdLMm5UUytwbFhLMEZZbGZiSWRvcnNiWTlXYUVVY2F3ZXdmTEtM?=
 =?utf-8?B?UHpLNnJxdDFmTGUrR3Z2OXFDa05OT2FIMzM3K0l4dGVoa0FsMkthSTZZSHhB?=
 =?utf-8?B?UUsxNzBkT0NySmdtdk5ob3hEbzBuOW9sRTExSmNGa2lQMGljcyszOEphSno5?=
 =?utf-8?B?MGttRU9oMGx5RkRsZXVXMjhWaXhKc0ZweFkrZUVpR1Q1bHVSdmptb1krV2R4?=
 =?utf-8?B?VndEVXBrQ0hubVhmanhuOW1rbEhlQjRia0lXYUE4QnBqaE05MGpTRnBqSExF?=
 =?utf-8?B?ZmprQ0V4b0RQOTYrVldUeWhEK1VlWW40RThhSEpGcitCUlU3WHIwZTBodFpG?=
 =?utf-8?B?WWpHV0M1K3VJeGZkcFgwSFk5QmZRUDNzelBqNW5Yby9VbW13b2RWVjM4YkdS?=
 =?utf-8?B?WXhOam54L0Q4djVzaVg4bms2djd3dmdyV1R1QmUrTXBNNW16MGlEa3RNb3lt?=
 =?utf-8?B?cGRYR1B4RFZScU1IQ2t2NVJPMlhGYVEzSWhLdjhTK214VXl1aFBkRDQwdmcv?=
 =?utf-8?B?MEE5TVZ6VUV5MkFNWEF1Snh6Y0VVZGRhVGNIRm03cWE4d2dUSXhaekNvTURG?=
 =?utf-8?B?d05rZGNGUVdmVWNsejluQW1KTEpCMEVpTEdiSU10MC8xZ0U2a0tKTCt5bm1S?=
 =?utf-8?B?V2llMFlWVVBJS0pDZjI0R2JPTWQ2L084MVpXbjJPZG05RDN3M1dJc081bGRu?=
 =?utf-8?B?eDByeTZtclE5aDVMdVdDZTdick82clEzUHhJYmVxYlFNOG0wZ3dveEVaOWZK?=
 =?utf-8?B?S1BFdUprckNmTm1KSE1iNFYydXVxeVM3NDVnRGZqUmwwU0hmTk9pdmdKQ2Nm?=
 =?utf-8?B?cVBQWXNnSE9KaU1RM3djTUlocWxlRUlKdXdXcnN3UnZQbmU2Y2liODNtNGx0?=
 =?utf-8?B?QWUyeUN5cUNNMEtlUXVQcXlTRWxvdU9yVkN2aVlCNm1hckZuWWY1Yy9CK1lS?=
 =?utf-8?B?YUJCK0tmbTBqcGdDclh3N2dpaHJMVk5QUkx3anFqU2t0eTdMQzdzS0tpdjJq?=
 =?utf-8?Q?AwLebssLt/k34D1U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48406d36-88d7-4659-013b-08de59ff1d9f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:42:18.2540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5gHllQDqT2uxZuMboHp6aguxyYMno/R/Gtb5hWTfZzcfwG90ok3UmzRaPAjvoiAmKB64eGp9tjiGTGkg9a6RnKAXX99HtKMnwcWsn5Uf40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 19:33:25 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > There are port setup actions that run on first dport arrival, and there are
> > setup actions that run per dport.
> > 
> > RAS register setup is a future additional setup action to run per-port
> > (once the first dport arrives), and each dport also has RAS registers to
> > map.
> > 
> > Before adding that, flip the order of "first dport" and "per-dport"
> > actions. This makes allocation symmetric with teardown, "first dport"
> > actions unwind after last dport removed. It also allows for using a devres
> > group to collect the unrelated decoder, RAS, and dport setup actions into
> > one group release action.
> > 
> > The new cxl_port_open_group() collects "first dport" and "per-dport" into
> > one group that can be released on any failure. This group's lifetime only
> > needs to span the short duration of cxl_port_add_dport() to cleanup all
> > potential damage from failing to add a dport. Contrast that to the "dport"
> > devres group that is called upon to destruct fully formed dport objects.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Trivial stuff only.  Took me a while to get my head around the temporary
> group usage, but having done so it seems correct to me.  I poked the
> various paths fairly heavily to be sure they all worked out after
> thinking there was a bug due to a misread :(
> 
> Either way on suggestions below.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > ---
> >  drivers/cxl/core/port.c | 43 +++++++++++++++++++++++++++++------------
> >  1 file changed, 31 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index f2723bf948e2..f69395ea0c14 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1650,10 +1650,24 @@ static bool dport_exists(struct cxl_port *port, struct device *dport_dev)
> >  	return false;
> >  }
> >  
> > -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> > +static void *cxl_port_open_group(struct cxl_port *port)
> > +{
> > +	return devres_open_group(&port->dev, port, GFP_KERNEL);
> So only reason you are using port as the ID is so there is just one thing
> to pass to the DEFINE_FREE() callback. Fair enough, but...

Right, and it avoids needing to wade through the cleverness of defining
a new CLASS() with a 'fat' pointer that contains the devm host and the
group. I.e. similar to DEFINE_LOCK_GUARD_0.

> > +}
> > +
> > +/* note this implicitly casts @port_group back to its @port */
> > +DEFINE_FREE(cxl_port_release_group, struct cxl_port *,
> > +	    if (_T) devres_release_group(&_T->dev, _T))
> > +
> > +static void cxl_port_remove_group(struct cxl_port *port, void *port_group)
> > +{
> > +	devres_remove_group(&port->dev, port_group);
> 
> To keep this inline with the DEFINE_FREE(), I'd pass in only one parameter.
> Can in theory be either of them but to me port_group is more
> consistent. Then cast that to get the struct cxl_port *

I would sooner go the other way and skip the open/remove wrappers
altogether. Because it just adds to the confusion of what is happening.
The DEFINE_FREE() needs a comment for its cleverness, but unlike the
dport case this port group can just be idiomatic
devres_{open,remove}_group().

I will do the "dr_group" rename of the local pointer though which also
fits better with not wrapping devres_{open,remove}_group() for this case.
