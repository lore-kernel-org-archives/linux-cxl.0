Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACC930F946;
	Tue,  3 Feb 2026 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158273; cv=fail; b=GiwBoGpZj7Cm2yKRNjFaalcwamXMiLAmgJqHSGYbbiD99samK8enncnWAaLSA9/K8UdAZiGUzOO7ursHILTPyuwTvXZIvaJFT5s1PV16yyvVpgMRJjADV0AB/UfiGGrWuJNTpt1YdvgBfAX2Jesm1InvGnUmdocDwW+ukh6pNd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158273; c=relaxed/simple;
	bh=GgXfB8KwQewaU/3N1E4g1Eg0+iiz0O8dLaOu3xfA1lE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=M8TuN5fcjwg4lenMmW9fCMODCoypf/H/yb1bWqtFgF22hMN+U4QGyMWlgCc3yFK8S9uJbBdevRTfxR3mS3sH+K3EROA54gqd9g3Ji04o7frC1ReW49VgBUzaGf0Zwq3GRgA0SLgPfEU+paSuDf+AfhgNb6JpM3G9oTeh0BpzBzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OERG74b7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OERG74b7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770158272; x=1801694272;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GgXfB8KwQewaU/3N1E4g1Eg0+iiz0O8dLaOu3xfA1lE=;
  b=OERG74b7EHlHz7g9pWmJyjbfuvJ1kAB10G05/Bi8dxo4gFCKnaZ0zg46
   8IIp39EQyhUIy87LSrO7rtVni5nGZ9OZsf7KhMvw0HRQy3AR8TKYf/ZsZ
   FTjMFOhEj5A1zoNFVwVlfEkArqzkp7o/Chv+1fqg7iu7x3gcZr8XtKkGc
   5vHBecv6zoLRgUygJu1J/Gj5nnGGHK8qGEIt8bwJvHmft3ZEkvE0fF1J8
   gjrLudZxP/mw8vXfTSmusp+Tz0VHS7BY6Cg1m1upqxMCvkCu6aVhuE3Oq
   82C3mOQLRZPoeg4bdmZes9AA/dadtRuqSxvZENQwzZHKx7g2IF0oBF0yO
   g==;
X-CSE-ConnectionGUID: BdJLC+5aQC6emoJk3toW5w==
X-CSE-MsgGUID: 1OnCYC3iQQGDB0ezp+gNDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="58918804"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="58918804"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 14:37:52 -0800
X-CSE-ConnectionGUID: hpl+XTwGQ/+JLL2ftOW66g==
X-CSE-MsgGUID: jYXlynkrQtecxAaX42Z2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210061780"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 14:37:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 14:37:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 14:37:50 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 14:37:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCPKNWOQexMZNVs+4Sqk9MOV1EIJuCEpynfAyFbWSBeWBrLQMxu+30/mYNudgcRf5tKlgnKDKPa4yk+CgFpb9xQ+72oB8v5aQD8Iml0SP9eBPyfKx5nMbFUrIDmgmPlQCgcn9P3ms4rpXLByGgWu60VyVUiUtmtwINwU870qYTpr4caO8b8v2pCMcm3gQedd4QWb7G3+0TeLq5SqodyOhrmXLbya4Q+qeyztk/6a3tH03/n+fDNVRaE85W+cOcPE3E6a+LUCbiyuz32bg1BWKGwD5CgGU5CA9L2Btw+RBs9BrruO3VPKLYm50PM1SglWiHGRvHZMZd3ti6g+Ang1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hzKdX753XshEWhSci++NvOGVdGWkH+wawfud3tSxL0=;
 b=HC0aTwGxeKjF1tlOPwYMHzmXOirtlLOVaAxnMT68cd4Fw3GlDlCK/E7adPYTbmaiWAZ+OR6P+QqxYSLhW91YJp2ct1QTlahRX0ZAB4E3KCpYF3wSI/RpoSWp5j0YGV6XnDSDbXfsbpVZfFM99w/wcVprR7QuYXqH8o6CFLMP9TpAMNQPBS4pQFzjswwdnxT4qWfQhO1q2L5pyGiKcticjLN2bpqAugdbK3ctaEix/Q6lLkHT4TJCMlXLuITbsT4JZmTmoeNb/fVx/J8Ph7fWu2nxjp8XJLdh7xXCvhxx7a0sHtwnl8sTJAEaJWQ/xVoJH9x+asGanaHedI4t2ydl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:37:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 22:37:47 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 14:37:45 -0800
To: Li Ming <ming.li@zohomail.com>, danjwilliams <dan.j.williams@intel.com>
CC: dave <dave@stgolabs.net>, jonathan.cameron <jonathan.cameron@huawei.com>,
	dave.jiang <dave.jiang@intel.com>, alison.schofield
	<alison.schofield@intel.com>, vishal.l.verma <vishal.l.verma@intel.com>,
	ira.weiny <ira.weiny@intel.com>, linux-cxl <linux-cxl@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <698278b96e1be_55fa10072@dwillia2-mobl4.notmuch>
In-Reply-To: <19c2413143b.107b011e88026.6653143171898793206@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-2-ming.li@zohomail.com>
 <69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch>
 <19c2413143b.107b011e88026.6653143171898793206@zohomail.com>
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 393f4fab-390f-4308-7ab9-08de6374dabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVFxNU56UDQ1Uzk0bWdybnhzUHgxczhkdnFEN3RIamhsZ2t0K3RhMC9YRlZU?=
 =?utf-8?B?Skc0NHpzTmlEMDZKNVMzV1RQZGt3MDBuQ2xNKzN2TGx5QkNUeEpmQXhOUHVP?=
 =?utf-8?B?VEI3ZUVJYUlabzNFZ1BES1VZU0ZoOHllOElXakNVY1J4Szg3Ty9lek5Pc3JI?=
 =?utf-8?B?UzdvWlFoVWVwbW9LWTZ0TGVXM2duWGV1czRDU3BwNTFIN1RmM0VFbDRRYWQv?=
 =?utf-8?B?U1ZlOFNtQjROSUMzMm0yNFNMeUhucUdKa3ZxSlYvNm53NGEvWmhMcUdNNkFs?=
 =?utf-8?B?M1VUSWx1UkVMWUNiODRGbUZWM0xCbHVUczFUd2NlWHZIS21YeFBuY0tDcGVE?=
 =?utf-8?B?dWQ4MVZaeDVvVlpLMElObHdsSzlJRGRpejBDSkJGVjdxNS8xQ2Q2SHU0Y1Ft?=
 =?utf-8?B?aFNBS3ZuTHJFbUd1dDRqQWJyWng2N1V6UGRTMFJSRTRiZlEvdloxVEwxMURS?=
 =?utf-8?B?bEgvbGZoWm1zSXV3aS9BazFnVzJlVUhnWXlKaHFuWVpWRFdvNTJtRDNxR3dy?=
 =?utf-8?B?SHpaelZrOXl4VmtYZkRtRHZXdnY5dGxSUWlYYkRzaDdsUEY0Y0p5d1hvU0x1?=
 =?utf-8?B?RCt2RWFRVkZVNHhlYXc5dUJyaWtMOXhrV1ZkOWFobUpXZWNDdk1WMVBhYkZF?=
 =?utf-8?B?NkVTQ09FWEM5VjJZK055b3JiaEhXRnozZldmZFU3cW4yS2p1QU0xdDZ4QkdL?=
 =?utf-8?B?ZUcwUXdIK2FKZ0dVdmpVVzJJT2VlbnNvNW41SUF5Vy90alFGRmcxdmVMYVg2?=
 =?utf-8?B?WVB2NW54cGdCLzVhR1NndzBwSmlUSTczR1laWmJtTzBjUXJ2OGVCRDV6d2U4?=
 =?utf-8?B?c1I4ckY1UXRPODlxc3Rqc1BpVnJieGtkdk42YUlwTmticWo2TldUWHRRdnBw?=
 =?utf-8?B?TWJnempxQkhWNFJpaWRiWTJSWTRDOW83UGxCNTI1QlpCU25jSDUvYUIyWklk?=
 =?utf-8?B?YTVJc0pGWHVSM3c2SjN1S3A5anVUdm5EenNlVE12SVNWNk1XSHFLdVpLblls?=
 =?utf-8?B?cTlBclNQQVkvd0RnRnhKdjZHL01UR203UnlLaUptQXVwbWpDZkZyK2hmdW85?=
 =?utf-8?B?YU4zeWN3d3luVmdOWDQxcFcwR0lmdUh6WGpQZ0dPOFVabHpob0lwdENxK0RP?=
 =?utf-8?B?N0szQ3lRTmRWSzJXQjBadWd5WmxqWkdaYnhUNzl2RWlFNmp4Wm8rY3BmM2c3?=
 =?utf-8?B?a29kTXFnU29Od0g4K09Bbmhma1ZZbXlrMTlMZ2hna1U4bmFMUEo0dFo5K3V2?=
 =?utf-8?B?cnhwSGlRcXRIMW9CdlNMMkdKYkFaNVhMV2tTaGRtUzk3Yms4MjBtaVdPUGNi?=
 =?utf-8?B?Z2FYL3ZFTmc1ZzRXNlF0ZnFzYjk1UXVGZHNLaVlLbElkdnNHTHlTUFNKekp4?=
 =?utf-8?B?Nm13SnFSMkdPQ2FmZ0FyV2k4M2M3RHBDT0dmWEcyTkxuWjl4bjViRXZ0Q0Ez?=
 =?utf-8?B?UnlnNC9ycDZjOGEvVWd1SUVUZ3AwcHE1Y3UzVThXMXZ4a0pqNlRvRGp5MVFZ?=
 =?utf-8?B?YzBUcUV5d0U0RDlwSCt0VmVycitaTG9HZ2NsNWRXTjQ0MS94ZG5NeXd0RzVK?=
 =?utf-8?B?ZEoyaGI4bHdvN01Qcng0K1VzZDRmUWdpZHkrbXpLMjVlOWlsVktmcjljR3ph?=
 =?utf-8?B?aVhsV2JTa0g2OXd6eGptYVNqMExjZXNIU25oN3kyNC9ZNWg4VnJrbVp3M0k3?=
 =?utf-8?B?SEZtT1VMN01XZEQ0VDh3WXZZcGxmUFJwdmNFY1NLNTRZMTZKL2c0dngvbW5Y?=
 =?utf-8?B?WmtHWk1qeVdJWVo3T2lVTmlhOThVQUZ4UUx0Y2FaTmtReWZVQUUvcHdsaFFm?=
 =?utf-8?B?c29VVEVnT0FXV1ZxeHdWSnpxR1hZL1ArVk5VSlVwSWdQbThVNDFLZklZZ2lk?=
 =?utf-8?B?MGtmN1YzMC9MWUpoZTBYcVJHQlJqOTBnUURubWZ3Tzg0SUpmc1k3SFA2RW9z?=
 =?utf-8?B?WHZGZnhXb2pMaktzNVFtMDMxMExqSFVacUlBa2NuNVFMTnh3eHhKaU9ZY1py?=
 =?utf-8?B?Z1dxQUpMMEVXTzBJeTRNT3ExTkhQWWRRZkgrUlNDdnBlTmxTMUFhdU9GcDRK?=
 =?utf-8?B?NkdlQXNPK09zSlNGbEpvdHgramdOVE5mS1I3M3hQTzNhOFo5dzVHRG9nR2tH?=
 =?utf-8?Q?PJsE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFkT1RKeWgrT3FCM3d3b3dNUTQ3VGlGRDE2SWJYSEh0bys1V0RLbHZ2UjR5?=
 =?utf-8?B?aUtiSzdQQnFtcGZFUHIwM2ZIWXJIUEMrWklNV2FaZ3poaVVmWnJaM1NLWVFQ?=
 =?utf-8?B?K0dzL2EyQ2M1QzVrN3ZNTmZ6QU5pK1AwcTlrcmhpT1ZsMEhZUTBENmR0a0w0?=
 =?utf-8?B?Vk55eWlrZ0NLczJnYnBTN2h4d0hxTU1iSFE2dzZ0eXRsWUhudWc5Rk1tbzIv?=
 =?utf-8?B?QXRPdFRBa3dNdXlKYTRONTFNRlBPKy9UNkNjWXpCU0l2TVN6MnByNWgzUjVX?=
 =?utf-8?B?MHZPbWJpWTlFSHZLaFhVTXROSENRTjNJVWhLUFl2ZVZqbTFBQXhUZkZPSklU?=
 =?utf-8?B?THBXeUNxbDk0NC9FdVFKWmJwOUhwNmtpYkZsakxVVURsWTJJOEM0cmt0cm1O?=
 =?utf-8?B?dGhsQmxvaFBwTmhKR203Q0JvVHV2d3VJYTh2bGh6VlpsRCtIUWp1TnN3Q2Rq?=
 =?utf-8?B?NzlpVUdsbDljMjZ0WSs2QkJsVzB5czRTSURWK09ZeUhkb3RLTGZhekEzRXZt?=
 =?utf-8?B?bHFtV2V1dmpiUHZEY2ozTXVQV2ZvMHlmbVFEKzZnWXdVTHM0cGdKdlJGL0J5?=
 =?utf-8?B?VlBxV2p5eUhGMjdVMkZHOHdWeExpZXloVENTbmxRRVB0R3g2ZmJWdnRWUG55?=
 =?utf-8?B?cUUxbk8wdjA1RGRWdUZLc2h3SDZWTVp4RlN5Rys3aThLQll2N0NFc1hKWnRI?=
 =?utf-8?B?K3RuM09qYm9HZWdoamtlOEdTU3JoZGg2Rkh2S0lsalFabE5CS2VSdTdaY3c5?=
 =?utf-8?B?TTJwc3oydmVXUy9Ta0RuUkpvODE0OE9hVi83Z2g2UDFwZDVHcjNlNnVXU1R0?=
 =?utf-8?B?Mml0enBGMXhLdU5FclJEVEFQMk1HQ2lDY1MrdlhVc1dGaFdWUHRtbXp6dkJs?=
 =?utf-8?B?MDd3blpGa1JKMGhBd2ZhNkYvWExCdHZOU21iODRMb2J5NTk2VThpOUpGeEhr?=
 =?utf-8?B?ZDFudGIxZGRHSEVTSzZ2V0tHWjZlaWI5N0paRy9la25qQlJnNDVibEhYdHFL?=
 =?utf-8?B?dEF3MzdNb25pZ1N6TEhNNmkrbGxFWmRwNFlLTVJIOFVUZGpkUmY0eHFmMHY5?=
 =?utf-8?B?bERBKzlObEQyM3pTdWw0blAwS1VSU0YvK2pLVzJIc0JCc1BST1lXVVkzQ25p?=
 =?utf-8?B?ZjJoaTJDWlRHUEZrckw1eHlrYWF1LzI3RHc5UXJyUFgrbWpOaXIyTTMzdkxO?=
 =?utf-8?B?UWJtTE5WbWdCTnZmckxuWGZhaXlSc3J4cEQ0ZWxhNUNyN2pNUnBqSnp5ZzFK?=
 =?utf-8?B?L2dnZEFZY0FUU2xKU1RldHh6OHhiQ2xqa21FQ1Npb3pwbUVGY2NDeEh6Q0Q1?=
 =?utf-8?B?dGwxK2M0dk9QZjRxZ3NxYVk1UzNPdCtpaGNTdWlKMXlldnlKUnN3T09JbXE0?=
 =?utf-8?B?YVZ0b2Z1RkFFOExnTUpmTmpoUDNIRXhOMjcvaG91Z0ovdWR1TE5JS0ZMbjJx?=
 =?utf-8?B?SE13Tlk0bEF6Z1BMdzc2OXgvdTI1ZWxFMDhIbExodWQzRUNYMUdQdnJqRDM5?=
 =?utf-8?B?cXpMN0tJM3dXY2ZVdlRhUjJMaCs0c21ZblkvODg4a2F5Rk5sRTZtSjZwZzFV?=
 =?utf-8?B?bE5DdllsbkdZSmxqZ2NhN2ZteFRxU2lCV3BoRzJQSlNyb0FEY3I2TU8xdGVO?=
 =?utf-8?B?NFl5VDM0eXB0cGZYS1IwbHVDM1pkQ29hN1gwcGdqUWd4OUthOW4rbjZWNHdu?=
 =?utf-8?B?NmlaUHRLcEZSV2oyZ3M5VTNKZVMxT3pibEpzbTROUzk3Tk9lSlhSUWJENWxZ?=
 =?utf-8?B?Y3lPSW5SZlRPT2hkZEsxdGZIV09Fa0JFU1FLSWlNdDdoR3Rqd05FK1FlcWQr?=
 =?utf-8?B?QzVqa3l0eHNnanlkOUtRYUZ6cVNjRVNVU3dBRlZVZTJOaGRhcVpvUDBIS3ZV?=
 =?utf-8?B?eGdzaFl5Mm5zNWZtdlpUVlV3NEVlcWlLMURiYnVnMVlHQ3dSWE9LVlUrOEFm?=
 =?utf-8?B?b0RyQ3pqbklTR0RlUXhwRWkyN1phemd4U0hCUjRJSDVHYzZUS1VLUXBjTlVF?=
 =?utf-8?B?MmRBSU43VHdlVU5QWitCUStmdCs2MUtOdmJaNWp1VURkOUtkREVkQ0lVUzJt?=
 =?utf-8?B?cHBmUmVpNEhHMEFZa0s5WUEvMjNWUS8vMSt3TUI1dEJkUEl6Z0tTWjZyYnAr?=
 =?utf-8?B?WXI3aXFHTmZGSWp1Z3FBR3NVRHZTUWNSYVhibDNLQUh6VWw2a3BRcG1NZStY?=
 =?utf-8?B?VE5KSGx5cFozSDUwVWpVU3h2TGZPUk9oRUNTN0ZmSFFxVUx0WTVMM1BBR2dU?=
 =?utf-8?B?MTI4MzIyOElnNHdiazhDRVV0NGN3R0JQOURCc0ovZ3AydEQzd1BZQmkxSDNn?=
 =?utf-8?B?eHNjU1pHWFVLYmpDS0srK0RTTWZBQmxwUHJySHR1WVE4ZWdwZlhhbE5DZkpm?=
 =?utf-8?Q?zXtlqH91m7BXROlM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 393f4fab-390f-4308-7ab9-08de6374dabb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:37:47.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiwhxD60056M10WhhM8cDCi+E2KGlWTIMNJFfyfB03MS3tX6E12NXJ12q/zpiLg5pbJu00EpKj9sBVQ8b0ATmUGEAWsYWJ1X/p7rPXMfHQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8770
X-OriginatorOrg: intel.com

Li Ming wrote:
[..]
> Hi Dan,
> 
> Thanks for your proposal, I think your change can solve this problem too.
> But the change is a lot, and need more time to review all driver code
> to confirm if there are other places needed such checking. (I found
> that cxl_reset_done also needs some changes like you mentioned) Maybe
> we can consider my change as a quick fix? Then I can prepare a new
> patchset for the consolidation.

I am not convinced that it is a fix. The fact that you say the bug
disappears when patch2 is applied leads me to believe that is
potentially the only bug.

I.e. it may be the case that cxl_dpa_to_region() is safe to assume that
a valid ->endpoint pointer will remain valid once the port
bus_add_device() vs bus_probe_device() hole is plugged.

I would say start with patch2 by itself. Then circle back to prove
that a mere NULL check is a fix or just makes the vulnerability window
smaller and the locking rework is needed.
