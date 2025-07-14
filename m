Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63D26C3B3;
	Mon, 14 Jul 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520940; cv=fail; b=PYT3oVgFxPIliJCsXh8SXRwyTKzVGc0SONOUTVxq3CG9lIJIShb7Y955cwX1O/1Q/Dt5PMr7kRmDSPYz+kCXLqqIogie9UZ9I0Pi/FVmcbPZkMNiYZ9ryErJ+oSYRtJxeT/vMV7tmo5o0pRFDmi/U208aLQTAIiScBGy34kcumA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520940; c=relaxed/simple;
	bh=gMvZqJqs4aPBIusGFSA7teEfFujgLvn+z2O0qL6CfNk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JZFIOcCLgiV31r+8FM0/9i+DSIlN+8O9pjlJZC76sj8DfkyUDwCUvhwIyf+RjTfLbB5uWM76NVcqfmIoef9tRQPUpAbTqUPtzlsQj3RSnY3hG41in5+iVDs+35ny7VWiViLOXdNSr2qW9Fh3Rtx+li47qEsY5tG7pBWitZ/hDeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOCP93Qh; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOCP93Qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752520938; x=1784056938;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gMvZqJqs4aPBIusGFSA7teEfFujgLvn+z2O0qL6CfNk=;
  b=jOCP93QhyHMk8Eaa4t0QefXYCsQOQPyZRtofpcgeREAdG0BPb6c/AtsW
   guus2/+LXYobHmVUiKYYNMvjB6RjFJAeq1eJJdi3luYm2OeumVfFq2RbP
   aaM7LRSvArIUnuJBHlNsvposjzpxAzl882nKtrY9JHlB9wfnB4/kSi4Rl
   +RkNTP1AA1+p0iDvSca61h7kWrxwUIZFgPtrQWDZzUfjWAThzEiKJORnp
   /VHtS04HwDSk001BSqUONKaS8SyTxcwI0Xx1sdgIKrHWTWIRpzO9d7UaR
   TVvrSQeCQud5d/PE2bO5Wm8tScTM4yPYB613pg5vECoSGsto7Qc7kXOWd
   w==;
X-CSE-ConnectionGUID: Uoais0epSnm2QD/7MMa5JA==
X-CSE-MsgGUID: yGcaPn4UTKKDRviMOtXgEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="80163712"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="80163712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 12:22:17 -0700
X-CSE-ConnectionGUID: fBSsFWO8QKKUqjFS+65o5g==
X-CSE-MsgGUID: jVluJo5tR/iJ17mFAEHn3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157730599"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 12:22:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 12:22:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 12:22:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 12:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvSygPXVJOdprf++pV1HNs56XcifbZyMes+mZpMKv2dYcWeBgeJcNAE/ClF7tYL3Nt14TygCfKyh9z0U6cUKztBUB1j3yQciqAugP/IhLR15H6jvV5HDpmC2+zou/vzm6o31mwI9AC+7RkQCT41L3WmZqHeVWohNDYXR4+OTOoQ9KfAeQokdsibl5sbbcoISjOMyWa1I0qwBhblJv76z818KYjuFN0lxkPCMdRIHXafZ8kmldNx7xI4d8HFVO6FkMujpQrrsza90VtnfRw2lrAV3o9XySE5Tg3i4oPYNyxx2GcfWRy0dyRtIPZ4C5qI1ZqjPRdfbsdmqfqdoMMkApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G9ebZ9C0gVqAgYTcdtEk9BH2myLaQUbWmn3CkfTfks=;
 b=qvFcF6lmle3ZbAizssGiuOc9bpqP8XggMsUTMcDNHOxreM/Zd7fxnwnsn5OhH6qDz4ygxXFHq4nnZjbrgrFPorHcXGL83B9fMT85DXSg/oZSm/FQSFR6jxmraXjFAcT+iCylxEwBEJU3Pl9POSecZlqVdzsHIbPQONCjew418txNf9P2TCAVMZUJTx6d+TJ/V9gNofKPb8eqm+J26CjHm/k34mCcr3/mg+RNSgOuHjD96bZkFD7TaYJtZOp5dEbiafsMWDF2+0UkD4uO5VKRkyrmkkV2rNuqIeLaKHEKsOpoqIjaRMZsBs8kH2YGE8ihd+Q+9wNlYWKS2J16mHYfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 19:21:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 19:21:54 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 14 Jul 2025 12:21:52 -0700
To: Shiju Jose <shiju.jose@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Peter Zijlstra <peterz@infradead.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, Ingo Molnar
	<mingo@kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, "Davidlohr Bueso"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Message-ID: <687558d0897cc_2ead1002e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <a49ab85cbd70469c8d1ebb9a43db0517@huawei.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-9-dan.j.williams@intel.com>
 <a49ab85cbd70469c8d1ebb9a43db0517@huawei.com>
Subject: RE: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd14bf9-3d76-47f3-9dac-08ddc30bb15a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFlkYXA5ZkRjazdJdlp5VFFmRnhZMmVDY3lZVWZXaURFY2libmFERnk5eEhu?=
 =?utf-8?B?aGJwOEFhOTg3T0MxR0U4bmQzUmc0S2ZVaVo4OFVPRG1BSFVaams0WkFwbEhj?=
 =?utf-8?B?ZFd6ekdGcGZqWnVxcis5dDlLRjUzUUQ2RlpXazVHQ0JkQWtVRCtBZ1QwUGpK?=
 =?utf-8?B?cWhOUWdPK3F2a0crbE1LWWFPR0l2TUZCUUVtNENKWWwrdzl3MEIyYWJndlh6?=
 =?utf-8?B?WlB4T051dTNhaGhBRGlva2hsN0xjZW1LbU9SVlpGN3ByZjV3RklJQXhGL1lE?=
 =?utf-8?B?OW1hY2lVNFhtUWNUTlY4Y3JET1lxWStoRnpoREs2UlhmWGZ3dGhlM1VLR21w?=
 =?utf-8?B?QlN5OEk0cmFMSVU2YmpVNHBpajVVa2dtakptM1lUTnFvbXJGQkU2SjRrelNa?=
 =?utf-8?B?NHdNQ3JaQnJZd1piM25UVncwVnpON3pKTkdJbjJxcTVUZlZ6YnZhTlY2M0Fh?=
 =?utf-8?B?Sy9aa0FReFJUWDlQMzZQOEwwSll0WVdvMmFSZDhoRVR4MGdmNXRYWEowQ21D?=
 =?utf-8?B?Z2hCREpFWGdEelgzRUh2K2pJbnlZNVZEUDBBUkV2Z2tlTGNVdGw4MUhkSDc4?=
 =?utf-8?B?ZjNpTlhsVXJObVBzSjh6WFkyMWJrQ01ZT1dWMHcrdFpLcjRTNGppbTVGSEs1?=
 =?utf-8?B?Q2JZWFozeWtoL1owTklRWUQxM3RVYmJYRGJtdkd3ZkNxN2tkMlZIRHdUNGt1?=
 =?utf-8?B?QWNNaFVmSkxDZ0Zkb2IzcjhVSzhWTEV3NEVYNVpwOVl2SGk2NjdVdHdITFpG?=
 =?utf-8?B?TndRRk51dGlkWUw3QW81YUZtTEQyRE8rL0FFVEZpcXF0bXZxOEFHTUNqTE9y?=
 =?utf-8?B?UStoajF3Wmg3Tm5GTlcwQUF6dldOc1JJVVBEVVV6TzJWNGFvOFlWSHVJVXpv?=
 =?utf-8?B?NW5kck1TaW9zZlNmSW9xTWlvOWJjWU92V25OOW1tMXZOMWNER1luT1orbkVN?=
 =?utf-8?B?YjJXczlubURPM3M2SXpnYXBxMGtxYWlqd2xmeTNhZWVMa3c4V3p2c1AvNXk4?=
 =?utf-8?B?M3UvM05YcFhCWFdDVXNueEF3SUxyYmN6NWlaYWhCNWg5eUdaYkZXWG13M0py?=
 =?utf-8?B?Q0ExL0lSVjVnWG1xYy9tSlErNjZqNXpLRitqcXhMdmo4M29yS2hjNkc5Tmk4?=
 =?utf-8?B?MlRuUi9oQzVQOUpBUFdtd05GaEd1b0tYTEZ0ZGZpeE1xKzJ6RE9tY0w4aGhY?=
 =?utf-8?B?TzhaZXJPUDB0b0FQUjNCUHN6SUVpbUE5OCswcjFOUVZMMThBa25DeG93T2RN?=
 =?utf-8?B?V2FRZ01wclB6ZVd0RUo5MXpNV2M0ZDBLTEp4VHMvYTg4b2dQTEZaUkZMT3RR?=
 =?utf-8?B?RWxiNVQydHRVSWh3Qkk1UzY3MVhqTytFYjBCWXZRZWZqOFBqbjVyaEFSZkkw?=
 =?utf-8?B?cGpJcUxMZVlVMjlKN0RaenVOUHI2M1E5MFNkc0srN1h0MzhBL2swUlRxNWZM?=
 =?utf-8?B?dFdOeTE2T0M3ZlJkQ1p0a0N6dzh4bGRpemQyc25ObFV5UW8vT005dzN6ZlBH?=
 =?utf-8?B?QzFITVVqNjZCL3M0OXZYRFo2RCtxZ2xYL0haNXh4cUdEaHowMHMxQytmL01Z?=
 =?utf-8?B?T0t5MzdFNkoyL1lEY0dOQTNybTBrUllDdFZyb1FyRGM3R1VhaFhqdnZNc253?=
 =?utf-8?B?WkkxTmdhYmJ3WEUrTnJSa1JBT1ZBL1RJZEJEcXlvOUlJanhvaHlMTXFjamJh?=
 =?utf-8?B?QVdtdkVqWXhRUjQzSllodW5sZW5VMlJxRFF2aUdIN1NMN01Lb0xWSS9BdUFN?=
 =?utf-8?B?MUJVQUp1cmxDV2hIcm9Jd2pMcE5RUG9HeDU3NHFsbC9KQlNkOGhpU0k4UUM4?=
 =?utf-8?B?TlRrY3pnclJWMUNwTnRmbm9hQlRPMEpnZGVQZmZtKzBhVzNCY2hhUTZOd01m?=
 =?utf-8?B?MjR2WUtuM2NVc0lSK002NnVNRUR2RXl4SHo0RktOWURkRGtvd2tlZnlWK2NN?=
 =?utf-8?Q?sBcGH98C7zE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3BWd0YvSUE4Z2hCd2oxMjl0OUFtaXBsU2Zha3E5L2lIK2x4QzFHdDlnQW1s?=
 =?utf-8?B?aW5US2pzUFk5UEtQY09NZGExWEZNd1lZQWVqdUIxNFF1c1RtdXAxOG43Qm1Q?=
 =?utf-8?B?eUp3TDVBK2l6Ny9NT3BEZ1BmOTRFRmZWMm9OUzdvZUJsRTNmUnJHd3hDYTVU?=
 =?utf-8?B?ZjZIaWUwVThpR3Q0NlM4YkFBcmNzSkU1TVZ6NFNCZkpieXFvQlV5NXQyU2R0?=
 =?utf-8?B?M3c0Z0dRVDlNY0lCN0hTSmdDUUE2QXVMZmlCQktlSXExYjNydlNSUUp0YnJH?=
 =?utf-8?B?MDFvNzVvQ2pBM2ludFdpckxNd0xBWHRyb0ZZSE5OZ3BsUDVZc0gzTkFLZGxM?=
 =?utf-8?B?QzRNSGg1RzY3dnFDWG9zWFk0b2Q1ZXlyTHVyY04rd0EzOG44eVZuUW85SlM2?=
 =?utf-8?B?T2lLaXlkeDg2STN5TVloUVQ4dEtHcmo5c1M0QkdkS2pHRllkQTJqSEplZUZL?=
 =?utf-8?B?VSsyVnRyWElhQkZJZDFMWXJmQ3J4QW1PV2NmeEhQOFRDa2RwSXIveE9aRUMv?=
 =?utf-8?B?K1RqbTR0a0hJT3E3dnNNZVJFcVV4MEZZTjlvbjBvRWhkL3cwYVNoRy9PdHZ1?=
 =?utf-8?B?U1Ntak1KdXJwOGVpZXByaHdhbUhYVVlzdEdzQ3hiVlZ2dmRCNmhtRFJhdm12?=
 =?utf-8?B?Nmk1N3hPbWcwc243cjVpZFVjcWFmV2M5NUg0RFBVM0hDMmx6cmZwYldpanZk?=
 =?utf-8?B?bDNzMXlwdFQwSnJLOWZ6c3NGMURnUGo3MFg3dkdUaktuYk5IVCsySllOcVpq?=
 =?utf-8?B?b3pDU3ZNRG9OREpiai9uQzd5dDBUamhqcjdmamhsWWI1dWdLL29xR2ZCQ3Fl?=
 =?utf-8?B?VDh2bGlWTUdid3FnREZoZVpNdmFqdTdOeDVVSFBVVXdxcVhXeXRKOFh1SW9w?=
 =?utf-8?B?K3VtKzl1OG82cUlIWXZWZkRFdWN6aExLejU0dEtyRVR6RllLSUp5ZXhFL05L?=
 =?utf-8?B?R2lTQ3BYRVh0K3ZHZlY5VUs2TGFORkRXUmRaZ1ZlbVhOMFcwRGVkYmlGMWtw?=
 =?utf-8?B?SUpjcDVxOHR5RTArVkVmb2k0c3M3Uk5MazFyK0crVU5ROGFqVk9SbG5WTHoz?=
 =?utf-8?B?cEYwL3RmYUIyWDFLQ0gwT1JUeHBhVVRSeHlkSEZ1ZVdpcExadFA4aWc3M1pM?=
 =?utf-8?B?aVJ0eCtwMkpVeGVKWFBET3o4U2FDSXdLVzYrUHZhTk1zd2w3cWNxcFBKZ0RV?=
 =?utf-8?B?YVdGSDlrVk9kTklrd05PL3FlcWNjYk1UQ0dEcUZVK1B0YUdSZVFmNldmR2NU?=
 =?utf-8?B?Y0tZRVVGRzVIZzNYQnliM0ttaFdSSzZpMzNtQTBXWHZqNmsrNE82K3R1ZEtm?=
 =?utf-8?B?VFRZNXh5dkRpMWwyVm5RVXFSRit3SHdldy9ncnBhc3MyZVFRSGdIZWliOUZr?=
 =?utf-8?B?VXV6UFBtRE1rMmhuTTMzdHNTN2dlNHN1MGpud1FzRTFTME9vZk5ZUkVxSUV5?=
 =?utf-8?B?Y0J5OHVYVlNJSTFocDVwY0dHcXM0bFFiR1V0Yjh5NEZmbk5SdHRTQUJyVG5v?=
 =?utf-8?B?TUxVaVJqRzFkbnBrTkpGMGdXM0VZekRtWGc0cjVHU0hHYit4cE81MnRlOUFS?=
 =?utf-8?B?S2UvM3hyRk85UnRQazdMZVpqWURiK1dCdXVHRjJLZkhXa25XL3dvQWd1WUxn?=
 =?utf-8?B?Qmp0MnRzL1BFc09WMjBtZDE4TCt0ZExqekh3Tm8yWjZTZUNHM3YzNk50QkNv?=
 =?utf-8?B?U2FNbWF3QTM5WC82RTJlMVZNeGVMWktPTTZIYjIyWUo1NTBxYlVZbE9WWERp?=
 =?utf-8?B?SGFkWjVGZnpva3NYaEV0YkpJZjFBV0FqL051WlJydXhCc2w0VjQyaldOakdS?=
 =?utf-8?B?UmhlZS9qOEtJc3Q4UFh0L0VxcVVpUk5wWFR4VkpFdFV5UHpXbE9lVmN3dlBw?=
 =?utf-8?B?VjNsdmNBT1JveWk1UVB1MGFFU01jMFYvc3czTXZkVkNCK28xQmplWGl1NXVO?=
 =?utf-8?B?Z1A1U2E4a0RkRTg0MGNOMm9HTEc2cmEvTmJ3a1lRYjgyVllEbnZDOElnckp0?=
 =?utf-8?B?UVhCRVFkdk1oZ2ZQNWM0R3RDbkEzd1FkclZrMmVhTVEvcGlVdE5NK3JtSWV3?=
 =?utf-8?B?NmY2Y0IyNXo0b1lnM2RWbDQ2RjU3MytQeHNKMkRzeGZKS2xZYkdnanhQRnhV?=
 =?utf-8?B?MEdNYjUwYW5odXN2UUNqdzZlM2NhazRsMDBXODFlR0wzb1NLS2ZGWFBxaWxu?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd14bf9-3d76-47f3-9dac-08ddc30bb15a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:21:54.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0FXVbvhENZyH7S7VvdInTanNcnMGYzmrB4eF7M1gOg1XEIpqDCB5/ELNEhlUM09nRKJZtMEjXbD2AostDxjP5ZGEo+lPHRr0+VTKSeWLBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-OriginatorOrg: intel.com

Shiju Jose wrote:
> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: 12 July 2025 00:50
> >To: linux-cxl@vger.kernel.org
> >Cc: linux-kernel@vger.kernel.org; David Lechner <dlechner@baylibre.com>;
> >Peter Zijlstra <peterz@infradead.org>; Linus Torvalds <torvalds@linux-
> >foundation.org>; Ingo Molnar <mingo@kernel.org>; Fabio M. De Francesco
> ><fabio.m.de.francesco@linux.intel.com>; Davidlohr Bueso <dave@stgolabs.net>;
> >Jonathan Cameron <jonathan.cameron@huawei.com>; Dave Jiang
> ><dave.jiang@intel.com>; Alison Schofield <alison.schofield@intel.com>; Vishal
> >Verma <vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Shiju Jose
> ><shiju.jose@huawei.com>
> >Subject: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem locking
> >
> >Use ACQUIRE() to cleanup conditional locking paths in the CXL driver The
> >ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
> >scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
> >scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
> >representing the state of the conditional lock.
> >
> >The goal of this conversion is to complete the removal of all explicit unlock calls
> >in the subsystem. I.e. the methods to acquire a lock are solely via guard(),
> >scoped_guard() (for limited cases), or ACQUIRE(). All unlock is implicit / scope-
> >based. In order to make sure all lock sites are converted, the existing rwsem's
> >are consolidated and renamed in 'struct cxl_rwsem'. While that makes the patch
> >noisier it gives a clean cut-off between old-world (explicit unlock allowed), and
> >new world (explicit unlock deleted).
> >
> >Cc: David Lechner <dlechner@baylibre.com>
> >Cc: Peter Zijlstra <peterz@infradead.org>
> >Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >Cc: Ingo Molnar <mingo@kernel.org>
> >Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
> >Cc: Davidlohr Bueso <dave@stgolabs.net>
> >Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> >Cc: Dave Jiang <dave.jiang@intel.com>
> >Cc: Alison Schofield <alison.schofield@intel.com>
> >Cc: Vishal Verma <vishal.l.verma@intel.com>
> >Cc: Ira Weiny <ira.weiny@intel.com>
> >Cc: Shiju Jose <shiju.jose@huawei.com>
> >Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> >Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Hi Dan,
> 
> For changes in CXL EDAC (drivers/cxl/core/edac.c),
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> 
> >---
> > drivers/cxl/core/cdat.c   |   6 +-
> > drivers/cxl/core/core.h   |  17 ++-
> > drivers/cxl/core/edac.c   |  44 +++---
> > drivers/cxl/core/hdm.c    |  41 +++---
> > drivers/cxl/core/mbox.c   |   6 +-
> > drivers/cxl/core/memdev.c |  50 +++----
> > drivers/cxl/core/port.c   |  18 +--
> > drivers/cxl/core/region.c | 295 ++++++++++++++++----------------------
> > drivers/cxl/cxl.h         |  13 +-
> > include/linux/rwsem.h     |   1 +
> > 10 files changed, 212 insertions(+), 279 deletions(-)
> >
> [...]
> >diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
> >2cbc664e5d62..f1ebdbe222c8 100644
> >--- a/drivers/cxl/core/edac.c
> >+++ b/drivers/cxl/core/edac.c
> >@@ -115,10 +115,9 @@ static int cxl_scrub_get_attrbs(struct
> >cxl_patrol_scrub_context *cxl_ps_ctx,
> > 						flags, min_cycle);
> > 	}
> >
> >-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> >-		rwsem_read_intr_acquire(&cxl_region_rwsem);
> >-	if (!region_lock)
> >-		return -EINTR;
> >+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> >+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> Checkpatch is giving error here and in other places with similar coding style,  
> "ERROR: do not use assignment in if condition"

Yes, the proposal is that the rule be relaxed for ACQUIRE_ERR()
compactness similar to how the C99 variable declaration expectations
were relaxed for __free().

Prior discussion with Jonathan [1] and Alison [2] about this. 

[1]: http://lore.kernel.org/6870833aa1344_588c100dd@dwillia2-xfh.jf.intel.com.notmuch
[2]: http://lore.kernel.org/aGXDMZB6omShJpoj@aschofie-mobl2.lan

In general, checkpatch also needs to catch up with cleanup macros like
DEFINE_FREE. So, I think that "checkpatch updates for cleanup.h" is a
worthwhile discussion as these helpers get more use.

> [...]
> > 		p = &cxlr->params;
> >@@ -2215,18 +2173,18 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
> > 	struct cxl_region *detach;
> >
> > 	/* when the decoder is being destroyed lock unconditionally */
> >-	if (mode == DETACH_INVALIDATE)
> >-		down_write(&cxl_region_rwsem);
> >-	else {
> >-		int rc = down_write_killable(&cxl_region_rwsem);
> >+	if (mode == DETACH_INVALIDATE) {
> >+		guard(rwsem_write)(&cxl_rwsem.region);
> >+		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
> >+	} else {
> >+		int rc;
> >
> >-		if (rc)
> >+		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> >+		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> > 			return rc;
> >+		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
> > 	}
> May be detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
> add outside if ... else as before?

Recall that the lock is only held within its bracketed scope. So this...

	if (mode == DETACH_INVALIDATE) {
		guard(rwsem_write)(&cxl_rwsem.region);
	} else {
		int rc;
	
		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
			return rc;
	}
	detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);

...would be equivalent to:

	if (mode == DETACH_INVALIDATE) {
		down_write(&cxl_rwsem.region);
		up_write(&cxl_rwsem.region);
	} else {
		int rc = down_write_killable(&cxl_rwsem.region);

		if (rc)
			return rc;
		up_write(&cxl_rwsem.region);
	}
	detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
