Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A022E3E7;
	Wed, 14 Jan 2026 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408582; cv=fail; b=C5VY/0GQLDuDVMuXaojLtfiqRw/S/yr/PBLST3ln7wWIfuOuYeXNFdOr8Y7f/7SpR77MUqkWsYw4XmN0uVQXoEpcnf9kNohTFZYtHOLwPYXy6JZY6TNzA+6XmFcorWGHmyS0YzRpweYh5B0PwaKG329o/0uhryM/q1Xp73J1Nfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408582; c=relaxed/simple;
	bh=XtWUWBs/yPtxm/RYzF8+o0/002pyCm8fV07D7EC2nhc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PA/40uptCdFWiTcnXX3twD/utijHoQ83ISqfu9rihAel8txM1aF9DxPr9z1s7QHsnsFZQAqRi6r7rYCLHPWtLrvJD1oIgLSYzaEa1/sHvO3tmsfNwB661/TniIh2GTsk+1c8VGmw0X5zs5Qg0PbilsqnnP1xczyb7PkvZ9R0b+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gdr0FYCm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gdr0FYCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768408581; x=1799944581;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=XtWUWBs/yPtxm/RYzF8+o0/002pyCm8fV07D7EC2nhc=;
  b=Gdr0FYCmxev/nq0YIbDVgqOhHjbPOTjF23Vu0FT6zbEx9sIFjQFh1sT4
   2/98UIGUefG+Ont9TFeFUTjB8ZVkEhvBtYF2eB95G1Re1dMnQci3eErAQ
   NRkXBqvX3Oc1Xl7fiQUe9znrZFX/DucEfMSCsCIF2S51vima3BPTvxsCb
   ATXUCGq8PQH4ih2YKqvu3Op2JYr16MAizCneBxwKZxUFmgcrm5amhyTmf
   rX8KPznCv1So4XvNGpBeNBW88fEZLIwpfN3x2fubNpvrgkihDQxyaV/ZY
   OFa0v/no6jwSBBlkyYcz7Hziozm3VXnFl9GcfymT3mCyiq77q0FumgIBG
   g==;
X-CSE-ConnectionGUID: 4KugkLylS2CBk3zzIJN9VA==
X-CSE-MsgGUID: /mceJK7qSEy4dAtNd2YxKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73553017"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="73553017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:36:20 -0800
X-CSE-ConnectionGUID: alwtdXbXQlCmNZLfk7tWRg==
X-CSE-MsgGUID: J4LYVTe9RFyxdxN51SK+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204613521"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:36:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 08:36:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 08:36:18 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 08:36:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0/kCZDexPYKg22hZatjgYQIRYyyLCPBNz/rL4CbjNIB0j3+DU0pMw+V5oFu8wkHZRJ4wVPzeehvXgj+bxY5+vTL7MwxjOVKkBoxLYh97n4UvJG9L19tfJsEFIDV8YRz/oeTPFuqf0tA7w3P0uQi1Rxzx7UoOwpYK4utfnkUaCopoI4gnEsJoCqoDxHy/Idv+rT98caOlTO1BrCTy9SYOqjQ1JfWMyiPqm5sJQeWVTVFUrINW3XBa07M3NJCQ6rypXI/gQwHUz5eEU2F13RVYCpfxjs8PvLnjsxTEpk7L0t3ERQdoL/3Yj/iYYyjbi3UpH02Uv2g9DA5CsS3Pw8qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8/HnmwIra/QSDBfqt2qnVd0lb4/GznlMKrKWWOiQO0=;
 b=sjg1xyA0SBVSgQWWxSCzq9g4rLqE/EDqZdb2d9bHKUD/7Rz5IRaU4sks6pvmeUIr68Up9rAEvuXE4VRchSuz9uXiKSlyvZPjEhROUynQb8xnhO9E+Pxhax3jBR0YSzlQdiyPnWyHCj+fe5mKKxYp+5yy0nLKUz4g2rP6GkLXT7kABa5pFhId5CbGkbyYoYCWywYtST1ht2tEqVw6ElzyNkl/Nwh0EesfDTG3h1W6fumQlDM1xemR3dndx+zhd3NSIieF7yzRFOxHLFSdqITxWHBDWmslNF1WMNezxrru7Hj9VUb978rg3MqaHfD5KWH7hBpiNlc+fcr3XKKVh0uDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:36:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 16:36:16 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 14 Jan 2026 08:36:15 -0800
To: Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>, "Gregory
 Price" <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Message-ID: <6967c5ff19461_34d2a1009@dwillia2-mobl4.notmuch>
In-Reply-To: <bffeb2ea-f5c3-4ece-81be-74b647f027ac@intel.com>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
 <696560c0979e0_20718100b8@dwillia2-mobl4.notmuch>
 <bffeb2ea-f5c3-4ece-81be-74b647f027ac@intel.com>
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: e463dc2c-710c-4d0b-e6cc-08de538b09e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajB6bHdRZEZ1dUdJemFCa2VlTzl5NDZMc3F6NEROdktmYTFLTWlScENHTGMv?=
 =?utf-8?B?ZjNJL1pSK29DOXRYcjlzRlZnRUd4UGg3R1RqTjRUckljMlBBditpVm9xMGZ6?=
 =?utf-8?B?alhuaDNKSjBvcXppMXNDcjFDY1RKckVHdkxkK1RCbm95eWNXVDVCZ1Z2MlNx?=
 =?utf-8?B?bzJvZWttT25IQU8xNGdNRXlqZmhzbkx1NWNaTlp0VkxXeWdZRndSZnNnMjJ1?=
 =?utf-8?B?aVNXdjFUZjYxVVNPVUx2R2MrZ3B2a1hrbWdDTS9TeElqSEhCNklER2ZZZjNL?=
 =?utf-8?B?cC9HQ012UXFYRWxHdUNwNVhocXFHcWhGUkgwTGxmT3VOZGJMMFBuRktaZHdi?=
 =?utf-8?B?T2QycDNYUit4TDNVbFNDQkdYUnI3dlE0dVlLR1g5ZC82UGtLU2tFckNocmIx?=
 =?utf-8?B?ZGV2VEUvZW5DNkdHTlJLbHRHTGlrQUJ4bXdtbkt6Rm5PUzNpVzlBdjIrREpR?=
 =?utf-8?B?clF0UStwVDEwcEd1S1o5U0FJMlUyMUhIUm1US2xHQkZ6dUJsM1lvdGFyakVn?=
 =?utf-8?B?TkR1M2hIRUs0aTRmb3lobmx6elpxcGs4aUxvdjBRM3lzZGtnV0hjSFR1WmpN?=
 =?utf-8?B?NU5qYUtSUnpSQi9jQ3Y2QVF5TUN5U3E0QzhtNXIyQW1TNFVGSTYvT2lYOEtr?=
 =?utf-8?B?WTgzM25GcHVJNTlwRFh5bmt1RnZxUXZnaUhxcFRpdGZMb2pJSmJIamNnQlM0?=
 =?utf-8?B?NUhqUllTaUxKL25JcGJiRnFjVUVjRjFwUTg2UTRqRTc0YjA5UmphdU1KMUUv?=
 =?utf-8?B?N09TOExSZFRKMzNEaSs3OEpwcnU4aHNXT3pGNlZTMVpxMy8vUnRycVpuMUZj?=
 =?utf-8?B?OHlFKzhnWjlZbWt1TjNldEVEV0w5UEV1dEVHdlh2M054ZVFyS3RyUXVvUW5s?=
 =?utf-8?B?aEZEd1BsdW5ETy9DdU1rVkQzcG9LT0FjaXF0U0F6VEFoellYZENVRS9kS2lR?=
 =?utf-8?B?MW1oU1FyOTlmMzVmZDJaampFbHBoL2JVMzFjSkltclN1V1VRR05HcHdkc0Yx?=
 =?utf-8?B?czVlZjJIYzVkM29LQUdTK0I5NnVHb1hFRzlHL1QwNi92NS9LRzJSWkdTUWUw?=
 =?utf-8?B?VU1sMEZTUXlDYkJJOXQ0UW5UUStRVU0zbVR6Qy9WdlJsMWNReG9XRVRTNW5H?=
 =?utf-8?B?SlFyQzFNeDlxNzFaaFBjU1RkSG1ZQXUra0FwcWZDSkliNDQrNSttZnBxY25J?=
 =?utf-8?B?eGZTY3F2Rjk5RE5VOXJJdFVuaElla2k5aHFyNG9BRUV4aS9LN3lMMWdFYnpy?=
 =?utf-8?B?bmtZdkxHRFJMUDRaVTRiak9nWVRCR0t3dVNLclRLcHBZRFhlRUZjTnV0V05q?=
 =?utf-8?B?TWlJWkZ4NjRTMGE1V2F1eUxjN2Q5b25PYWg4bWtuVFNaaGpQRmt5U2ZZZ3ZO?=
 =?utf-8?B?Rlp6UnA5dldiaVRTRDVwTnlGdXBIc2c2YlN6Tk5vWldleFZ3N0NpditBTitI?=
 =?utf-8?B?TmQwdmJpSzBVcW5TQmZHSXVtd0xWN2hUSVdJYkhTUWJ2dWpzSmN0QWx1Z2kv?=
 =?utf-8?B?R29vTi9UcysxNzEwSkVBSjNqei80YjErbTcwRHhKMnY3Y05ieVo0RElVbGhh?=
 =?utf-8?B?MmhZN2M0YTQ1eW5hQ0hYb3h5Rklxc2c2elduQlRnN0t4TFFRVnRyMDUzdnlG?=
 =?utf-8?B?Q3hhdnpkSmU2VWFYVVJrYjNxM04wT2wxLytJZ1dIZ1pqcjlGRThwNkN4Ymw2?=
 =?utf-8?B?NU1NTWRoaGYxeURRY2ROb25vUTI4Ujhld05pRXVGYmpWRTNEbDV1TTJLTlVj?=
 =?utf-8?B?WGhoWE1ia05iUlFWYVVvdnh5TFRhOFZ4emsvb0c5RnJrMVUzemxKM3E5R3VX?=
 =?utf-8?B?aU83RlMvM3NSZUlBbW9EdGY5cEc4MFdqVTc0M2c0YVRnN2lTbEttRDdxVjhE?=
 =?utf-8?B?by9zUG9xWFU5cVVzM2xPcmNBbzFkTXB5Q1pQMTBFL3ZRcXdhYVVrM0dqQnE0?=
 =?utf-8?B?OU1iZThaRUhnUmhlTG1VZkprUEw5clFaallPcmcrTWo3Y0Vrd2hDajhmNnRK?=
 =?utf-8?B?QW9uOXgwVStOcFpaK0RsU1RIRkRHdE9tck1BL0UxT3F4Mll0V2hpWUs2UlNJ?=
 =?utf-8?B?bklPaHpHUmpHSXV1ZUpSZ0JpUFYveE9XZ3haZzlpUVVSYXVaUmZNMGx0Mnlh?=
 =?utf-8?Q?lmvU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElDTE5KZ1ZCSlozdjNLN2s2dy9MbFRac041RnFzTlloWUt1VlZaeVdQM3k3?=
 =?utf-8?B?R0ZFQ0NNNVdWRmFXZ0VWUk12ZHBRK2ZrV3dlNEZtQmFWS0cxTHByQ0hxb09H?=
 =?utf-8?B?VWlzZDFMc3JHNm5mcHp2dHl2ME9pT25sSEtmcVgrYVhYenhEWXd4S2pFRjBD?=
 =?utf-8?B?MDJUcVlYc0RwTjQ2MkIxOUF1R1JIcy9MWDRCVjBXUys5YWUyLys2dFVvb3Nu?=
 =?utf-8?B?RDZYUG5oei9FaFdCVjhaZjA1MmhSdlRTRDIrM21iVDdoZHNUQVY3Vk0rcVh0?=
 =?utf-8?B?aU9Lb3RUeWpIalQ2UnpJNTJUSkxaMnlTQmEvQU16OUFpNEFReWRhVmp6dDRq?=
 =?utf-8?B?RTBpU0xFblNNRW1nMEJxbCt3WjNwMFlqOW4rY2sxUEdtT3lFSkpBS3hSQllv?=
 =?utf-8?B?cTd3b2VoR25jS2FidzVVWmQ0S0Q3V1IxdTh4SkxNODVNZlQvMkFjaGlpWitp?=
 =?utf-8?B?Nk1OaWI4RHdQZ2Q5MGJXSDFUQTNCTGNVeXhPNk4rT3loT0NZZWNMZE5jRXlz?=
 =?utf-8?B?dEhDaGI1Q3VMYk1tZ00xQ0pzRzluZDlPZVlEM203SURjQnhIL3VjWEVrU1c3?=
 =?utf-8?B?WTk1cWV2eGtuSEEyZmptcWNsRE5LQkZQZG43b0FKUllKYkRTdVF6QjkrZHVH?=
 =?utf-8?B?bWZIZXJrOWRnc2luQkJXdnEwZzkzQ2ZlUXlqK2orczRrY0hDek5JRVpqZzdv?=
 =?utf-8?B?Z29Hd3RKZk5WaEZHMy9UVTdjdjRRd0JKZ1dhNERHaXNkRFQyc3RTRkxvZXht?=
 =?utf-8?B?OG05ZDg1V0RIZnVWeG41aDBVeEpTalY5cDRBdGV1c1JkdXU4YjA2TzBzQWNT?=
 =?utf-8?B?STVENkpqSUFWanozNXhJNHgxOHBtdVJ4VjZGd0N2cUxTQkFJU0VUbEEwT2xV?=
 =?utf-8?B?WWxYbHlxRzFvZEcxenBLL3BxVmhYcjhRdHgwUXdicWlGbDdnTFlFUG5ieEE2?=
 =?utf-8?B?NjZpSkl0YWJoV0tjdDdmajREV1hFS1lEYWZFbFRqSzJ4cnJDOVVDTmQrUzhl?=
 =?utf-8?B?UmszMGFjWjJTVENuYXE5aEh5Sm1vRFVHdTg4dXJVR1Y1MWg3OWg2dzFFNUlv?=
 =?utf-8?B?aEM5bTVzOEFqL2lmUzBkRmcxNUhxU3VMWmU0anovOE41dnBqcHVlek0vZmta?=
 =?utf-8?B?M0FDTThXZHYyWHRQcStKQjJpR1BlZ1lTbG5rVitJbGdYUlFKT21wcTlWMk43?=
 =?utf-8?B?Vnh1cUxnYU1JZlp0bGoxcmxHR254TG1jVjNyVEoveVMxM1RjS3BmRjlMeEpK?=
 =?utf-8?B?K3JZNit2RmVKa3dFaE1kbUNRVWZNNTlOc1Jpb2RndElXcUsyMVh1NFVaVTV6?=
 =?utf-8?B?SHRIVVdqSElhTnBUenRhVGdUL3dBZ3VxVmNkdTdFSmVUWFI2VHNTVUhEOUtP?=
 =?utf-8?B?MXBxQ0dGK05FZHZMU2FWMUdIZm53Snk3K3RndjFxQzJFWGxjNFNkeW5TWmVa?=
 =?utf-8?B?dHkrVlNPNENYclRUQURkN1B6amc4alp5K2JVazNIRFhIWFhVcWJjVS9BRGFH?=
 =?utf-8?B?TWNDc3VuQSsyYlhoWDJrM2pwQ05oeTNNL1RQSTUwYm5ISTFtNmJNYmpqaDQr?=
 =?utf-8?B?TGJmUENxazJFbjFRcVFyQ1FYTWF1aWNFaTh5SGtLZGdHWUNxMHdMVmRVclZR?=
 =?utf-8?B?QTlSTkh3MmV3NFZkdEVFaXQ2Njg3L1R3V05OR2JYRFRLTFhId2JCZUpWNHRC?=
 =?utf-8?B?TVJoTzVPL1V5WUpncjlobktjaU1qcXU2S2xtaHh6UUNKODFaNVFYaWQrc2k0?=
 =?utf-8?B?VGZMRURlTHVxT2JhcStCVVIrYXY4eHRYVDZqRFFnSXlQeitPSmRaU1FxOEVL?=
 =?utf-8?B?aWlrRENDdytFNDcxbGdBbmZmSlFmNS9RZEljM1NPS29HZGdQOHlOaUxFWXBK?=
 =?utf-8?B?aDVRQWpoRE9oZ1FmWkVHSXBGaFU5VHArTkRxdXVVMmZWVXBLbStveFJ2WHQ4?=
 =?utf-8?B?ZlNVc1pGWGU5TFBVSVNDNytpaDFIRmh6N2JMU2VISFhIZ1NTbWRiWVh6MFVE?=
 =?utf-8?B?dlV4YjJyY0VPeEpNN1hKUVJvUzMwdnM1MjhOV0RYdVBQdW1oMEI5eElhai9z?=
 =?utf-8?B?QTlrVGpEQW44OUxUQ1FpN2N5azV4N3EwRGc0MlBmS0orTUVPRkVFbCtnNmFH?=
 =?utf-8?B?U3FUdXhLOHZyVytKYldXRkorZUIvKzdDV0t0NEJvYTN0TVBtRUppcGg0ek8y?=
 =?utf-8?B?NXM4R3N3cVYwS25ZU3hRWFJFV3YzRENSY3Y0U2laRWV0Y0kzakVGM2RBcGNu?=
 =?utf-8?B?RzA0L0tQR0JabHZZbDloSE5PMjRRMlFNT0ZRSmhEL1ZLcWhVc3o3VHM0TERE?=
 =?utf-8?B?NmU2K1FxTkpTUEJyUHU5Q25yTnQwOEs4Ukw1ajI2RFlBK3J0dzNTOG9GTGxT?=
 =?utf-8?Q?4EAGqdiFibgh7g+I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e463dc2c-710c-4d0b-e6cc-08de538b09e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:36:16.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76mMBpY1if6EG89jJeZwVsUSqpkEOFcM32P6JW+llAcd+FT9efAbpRUHa2IFE2BOtm+Dihp/7//XRDZnyDJeSXwCn0flgNue/y3V5iudT6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> > Rest of this looks fine. With that fixup if we are going to have a set
> > of different region driver modes then the directory can be:
> > 
> > drivers/cxl/core/region/
> 
> Do we still have reasons to keep the region drivers in core? I know
> Fabio has been looking at moving the region drivers to drivers/cxl/ so
> the LMH cxl_test stuff doesn't doesn't need to do all the weird stuff
> to make it work. Maybe we just do the refactor now and move the region
> drivers outside of core. How about drivers/cxl/region/?

Not opposed to making it a module, just need to make sure that all
potential region drivers are loaded prior to the first
cxl_add_to_region() call. Otherwise, this breaks the expectation that
auto-assembly of regions present at boot can be flushed by
wait_for_device_probe(). Specifically, userspace module loading requests
are not flushed by this helper, only direct symbol dependencies.

It would be lovely if we had a unit test that specifically checked for
regressions like this, because the race can be difficult to see.
