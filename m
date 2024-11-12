Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD862010E1;
	Tue, 12 Nov 2024 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731376585; cv=fail; b=FgsvMsPYh+EaJ1qL7wubijkcFJZYK2MT97E6HU0BLivBenQg0U4/N+Bv3L/JPKJjX53X2xi7UVdBbb5cXf8M6XjO4mzmF4HhUtH6GVGsyNNK3m6yG6sRjsEdfQPqXZdn0JcfzGK/smvicTZyM1D/yMevw1K37pF82g6r1df32hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731376585; c=relaxed/simple;
	bh=/vrhtZks0HT5SSSh3q6Lzf2uwD5n8ZFit6Du0/cLhZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcXKuNt1Mo8oxu1Ts35+8Z5JICw0l3NC97ZSqLZx6cViHL73MR/XUpDn7UFnolA6c2j0JZk29HdMhtcAVy0cqg7isTxEGfJ9umxeM3ZN6NezzZL9CB11FbNmXDQBvJRDZOIB3EVEjQW+63WvhHDesaOPSgJpvc9N+0cx+QMkV9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1eDc8J4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1eDc8J4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731376584; x=1762912584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vrhtZks0HT5SSSh3q6Lzf2uwD5n8ZFit6Du0/cLhZI=;
  b=H1eDc8J4DKVrzsCXVPzXNsqRFt30k7BbkHu9ZbFgZsAYRlM8+UhlKwj/
   LK6RKqc6Ssie4r9Z9lahBftAug9r5moE8FoifaJ0vowjr+PvYHH82T9sz
   U4Jw5gtIFdCM0uZvsXPOu+Zvx6mEkahFk4T42/JwCCj9cX/ruqRQLfnII
   vbBI0Acgx8C4D33jmow+Hxv89n2OeAqEjaqk0/J1f8YX6gtxnh2yR/oOX
   30wWWYZ6b2h8qC++L2u0l4CbeaQgV9p6nDCojgXtfWXhToDplgpeMnSsk
   jv5Sj1pUvNLP8qZBtEzrgv3UW1aMi0msKu7ck6IGyt0ccm2N/UFtTM+sX
   A==;
X-CSE-ConnectionGUID: OD0CnZy1S+aiv2xJ+Ftn8w==
X-CSE-MsgGUID: xwaTXXG5RzycHZWdXznI3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31052456"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31052456"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 17:56:23 -0800
X-CSE-ConnectionGUID: 50+H8W9uTief0j/cJQKqTA==
X-CSE-MsgGUID: jB5gjTUNRsGq+e14sJvxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="88005484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 17:56:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 17:56:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 17:56:22 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 17:56:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMZhltXwxKUORxpUf5cNmAfLPSbWCVGTKw16O4A6OcYcH0cup/LICNIN1c7ESXKj39IQRRDHcpWI1CICuiOlqgVGv/Z2eoyOff9tUG2Nd7dD/ZPV/j2UyBlZ7Dy8uHHSR7p0MQk1OHtjmpHcZWH++7NaoSLFaeiSTmjfZsrIJpD8aV7fKrkExVcWyN1a9/12R8EvYpbWMtxps3kJEkcGb3vTYn7psAMVPI04bXeHV8FfUqkb/l4kaJmaZvxgyVRDsPPy+JHk27vNXU+YyuMtMWOPQsBZ7UvmGSxwSQD7R8L1HSp1S8TCIVx/dWz1eO2NKM0saAp+tCzJpadFSiNUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vrhtZks0HT5SSSh3q6Lzf2uwD5n8ZFit6Du0/cLhZI=;
 b=PMG3QpODutYv2rP1GBiCqLza3hMiJGBYPvK2qzySgLOXN7n4cbZnjVDXOLc3qtiTBzc76ppSBd7WxIP/G4SgSBB3hLi4ZZYNpUVRcb1gnXnsqUiPAgxcNZpdAJwXXYdyxwQkAN4KeR/0dIKE7EFNzm6CtSiNJn0uPugS2dfTi2MJ47KF3ixry/0HWvysPT077Bn9HtW9cj7d4TIB/h6vMS6vAdTsxsEEp7jyqbx9InekUWTFV2Rr3k32x/FunmuCPDg56Q5iY6s7FUG7anqzFWwgsPCNYKFDEvOoVGYoUuUcNGbsi0/yujgegGSPoz/zqilARZ03zv5WCc7utUFS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 01:56:19 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06%5]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 01:56:19 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: "Jiang, Dave" <dave.jiang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jia, Pei
 P" <pei.p.jia@intel.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] [RFC] cxl/region: Fix region creation for greater than x2
 switches
Thread-Topic: [PATCH] [RFC] cxl/region: Fix region creation for greater than
 x2 switches
Thread-Index: AQHbKEX7nijo60YHI0Ci14OCMHEba7Kgn1wAgApz94CAAO4eAIAG8SZw
Date: Tue, 12 Nov 2024 01:56:19 +0000
Message-ID: <SA3PR11MB74613BB0D280113C7DD65DB69F592@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20241027075717.3714821-1-huaisheng.ye@intel.com>
 <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
 <672c13b19a530_10bc6294bd@dwillia2-xfh.jf.intel.com.notmuch>
 <1f05ccef-5b45-4eac-b3ca-588b1e5ec6f5@intel.com>
In-Reply-To: <1f05ccef-5b45-4eac-b3ca-588b1e5ec6f5@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|PH7PR11MB6030:EE_
x-ms-office365-filtering-correlation-id: ded471fb-f810-4bd3-c37d-08dd02bd338c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aCt5VCt0QmhmbHJSNzdSTzVaUm9mM240OXRXVG51ZTRCeHVlM3VJRGVpT2h4?=
 =?utf-8?B?UTE2RWR0NWhuR3BuS20rTGE1aUxKeHpXbjc5amh0N2JGaWZiQnJaQzZuL0hL?=
 =?utf-8?B?NVpvVjB2SlVwTmhaNTYzbFgwa0lkUENpMWNpbGFMWjNGQXl1QmVnZ0dFMEZV?=
 =?utf-8?B?WGxmS2tYNnQ3RVJGUW9DaFVrSXRRUWg4NHM4dzdGTjIzSExqOGtLRzh4MzYx?=
 =?utf-8?B?QzkzbDVrSzduL3F0YnVtQThHM216NWxOMjZuNGhFdSszaVpOV0dKbDVJOExo?=
 =?utf-8?B?aFlZeHNCMDI1S2MrK0tWdFpVYlpXc1pTTktaUEJwM2hQV3UvNWttUWJhdDc3?=
 =?utf-8?B?M1RieWhSQWs4TWZWbWRlZmxoVGdwQXhqUXAzRVhVNnVHNytOV1dUbEhpayty?=
 =?utf-8?B?d3M5NWRWcVZJNnpZS3RXMVpIZ0lQcjk0cldUMXRUSy9aVlMrcTlSRzYyMVRN?=
 =?utf-8?B?cng2cnNWT3lQSmFHM05uMFB3RXdFUmZmYm9CWDNRa0FXQnJIczZOZTY1UXRx?=
 =?utf-8?B?dFk0Si9vRmlFUmxUUGJHNzU5eFBWRHZBUnZ3bnBnRlFtRExLOEV6TC9ydlBl?=
 =?utf-8?B?cnVIOGdUclkrbExyeVQ5WlNUU3Mrbm1BMXcrMnFHRmNZTVFJSWVDVmtqQ3Js?=
 =?utf-8?B?bE9tQ2tDc0VjQjJSbXdDTzMxVy9jZkN0b3FOdHVYN01mcVB0RDIyVTJrNTQ1?=
 =?utf-8?B?UmoxWVE2a3NhOEpZMU56c1ZQMU84ZGc1Y0dBTjFhLzJBVkR3MUh6TjBTZ0V1?=
 =?utf-8?B?TDFTbHZrM0Zta29hVzdXNU5sYkdqRGNUeWIwQ09UTWJ1aEVVMjZZaXBUTnk0?=
 =?utf-8?B?VkE3dGVBOFo4b2o3Wm55Zmsra3ZzZCtVeDZVcWx1dVNkdnpWQkwwOEZFSDBs?=
 =?utf-8?B?allpaVFVd0pwUVpBRlVtNmtZdzR0aDRjR0s5a1NtdFlOb2I3bUgwdHpJeXRT?=
 =?utf-8?B?bmFwQjU5VDYxdG40MDlIZnEzRkt1U2xSR1poMGpVeTlaZkdJR1Z6RXJQWDNT?=
 =?utf-8?B?UzQvTFM0WlJPdDRiNVR4cDJld2M4U3V5bTM4RW9ZV3B5VzhHaUExOHV3WEdm?=
 =?utf-8?B?WURpWWNhbUlsY2hLOEQ3WTUwMU9UbDNHUDJyeGtQTTRzcU1ZcmZOU0RBbnYv?=
 =?utf-8?B?cWhPT2VOam91Q1NtOGNxbCtWS2w4R3BhRzZzL3NnQ2tvWEsvMFczd0VzL3Bk?=
 =?utf-8?B?a3pNZ3dZcTF2UGRjYUk0QnR2L1VJS3IwRk5KaWRnUWd4bThENjNXQStnckFN?=
 =?utf-8?B?T2NGaUFoUEwyRmxzS1FmOWRwL20vdHJMcGM2YmVLZVNHNkZsZDM5eDNjRUZr?=
 =?utf-8?B?aVFRNHNSQ3NwNEVMUU1PZDMzNFRXaXI0V21aKzlYckNsWDVQRjZNZTFHb2h2?=
 =?utf-8?B?YXNCKzRqZENYeUsrOTl5cnlwZkZGRmNmb3o5WjNyZVhDM1BSUjZBTEk3S1BV?=
 =?utf-8?B?WWVpTDE0d1pxVFBWNkc3MWE2a3dVd3Y1bGxGZlUrRU1vZVRGc3JoTGE4aHk3?=
 =?utf-8?B?S2hvKy9GMFlUaUJDc1g2NS9qQW95bExybmFSYTlzTG5hb3dOU095aW5QL0VF?=
 =?utf-8?B?WDhma2puK2p4dm5kemRPSUpUd2FaaCtXSWY2WFV1NW1iR1dCMFBmL3k1a0pW?=
 =?utf-8?B?djVNY3FXNU14eDljSXlDRHh5bERxYjUvdGRicHVZSWQvNFBtSkd2OVJwb0FF?=
 =?utf-8?B?M21Ia3JuZC9jSm5TTXZYMzJCRVZVTURhSTVnVldtS2xxK2Q2Zm9PM29TQlVt?=
 =?utf-8?B?b3F4Mk1DZDFTWlZqdEQ0a2l5WlN5eGtCVWxNZmhzTW12bCtMNm4rTEdNcmMz?=
 =?utf-8?B?RzNncFpNTlBaQml5dGxxTVN6a1ZGZk5JaDdrek1sWHI4WlRnd3o4RFJWL1I3?=
 =?utf-8?Q?WeI3j7Lp3pkZk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHRQd05xeTlPNExLakd0SkhieEVrOVA3SWZQUGJxaGttMTloSWZtU3daazFs?=
 =?utf-8?B?b1hTbXZMS0hlODFGdGJoZFc0RldpN0FyN2FHNTllR0YreDhDZzFzVmowaEpB?=
 =?utf-8?B?dHJFUlVkRHBQSTNrS3RNRjdzZkdGVm4vd0gxd1hxTnRWZ08rUzJ0UHBYbVNE?=
 =?utf-8?B?MkNZK1llTlJ0ZG1YMDVROS9iR0FId04rajZRc2ZsMnNSWTdxMng4YjJsRzR6?=
 =?utf-8?B?ZUVnZzVCdy9HSGhQdEttWUZUUlFVVHdvbnpPRFlmYUNlckdBem1Ydm14Z1ho?=
 =?utf-8?B?enhWRFNtVUFYOWR4QnhHVGR4aDdBcldhOEFybXlCOUF1TkdadThSWE1GaDRs?=
 =?utf-8?B?WERLRDcxVWl5eG5ZZ2JQQ0FIWHAzc3VTRWpRRGdNQkVUdVlwQnZBQ1p3a0Np?=
 =?utf-8?B?WUtNZnZLZmJEQ3FIMjgwU0RmTm1lemNSaUFKczZiNDdwTUJ6OFpuMXlEbUtO?=
 =?utf-8?B?YVRtSm9yQWJpcXdLdWxhTjdmMEFQQ2oyU1Z6YzllYlVmUlJ3Z1VhSjI1Nml2?=
 =?utf-8?B?NFlxMjdIWUxxbmpCUnhCZGw4QzRrOEpqTmpNbHMxVElMeW9SYlpEcFVIc3lU?=
 =?utf-8?B?enNyT0FZcVBQNHlzVC81OURPelRzcU1pTTk3SXp6bFRGaFpWMUxJRFdRbjFq?=
 =?utf-8?B?VzVVRHJaMmtsTVhDY0x3MkFIM2xtSEJ4cnZBRG9JUDJ0bGRWcmNWZkFSMFhl?=
 =?utf-8?B?Y2dNSlNjeWRXVncyUnFTU29YQ3RwaXFEMW5maHo0RWlIN2hYK3B5VmlkeGhh?=
 =?utf-8?B?akhIbzB0dmg1dEtYRFpWbkRjYk5adGwzQkUvTmdFSXJYN25JY0xxdmtoSFM0?=
 =?utf-8?B?NThsN21YT2VQdktpcklScDBBc2VOOUorNTl5QkFYMHNDcytROUVXcU5Kdkw2?=
 =?utf-8?B?M0ttcTJaMmoxdUZ1M0plV0o3TldhM0NnSU5NNWZROStCRm1CNFlkSWxHT3Jh?=
 =?utf-8?B?Q1M2UzM5dHBoTHRNdGJEN1lGeG4wOEhOdXIvYU5KQXM3anQxcmJoT2VRVHdJ?=
 =?utf-8?B?Sm1PemQ2ZXFxdlc2MnlRSGNXWnoxaCthUStWUEQ4YW5yZmZQaWZta09aMFRS?=
 =?utf-8?B?V3Q3MWZpOVpUWnVUL1l3c1RGWjJXYWdJYU1qcjlDVjlRd0Urc3Q1VXd0ZS8v?=
 =?utf-8?B?M25hWjVGdW5CTlRMMzJwSHRJUFdsZThNQzYzUzhValEzcld0OWcwUFpJMTRi?=
 =?utf-8?B?bThxZmFUd1AzblNpdHpITitjQ3FJR3AyOTlpSVYvT1dBZCsxKzBTelRVT1Vn?=
 =?utf-8?B?OEN6blpheXpLandhQi9kbXZWNmNrV0h3Z202KzZZU1Joc05rM3EvUSt5RnBq?=
 =?utf-8?B?aFg1M05XUTRoQWZnRkhzNlF1RHBXb3dZSjBkekxWbkxRZW10Z2RXNVdCT1Fi?=
 =?utf-8?B?cmlJUzM2ejFtd0ZRTDdYV0Q1MDE1bzBFa1AxdDU2ZEZZOEtyRElGWHdsYmcv?=
 =?utf-8?B?cGpFY04yV1ZrdCttN2RaNVUyZ2dlU2p1R2x5R0c0ZzJ6cW5nVE9URGpBaTlZ?=
 =?utf-8?B?QnhzR0lyRDAwTWhnWnhaTUlsNTk4cVNWK29PUWw4djJxTWdFcUdiTzNhYXJu?=
 =?utf-8?B?b2tRRmUwZlJPdGZJb2g1UXlwenVqZVdzZzNLRk5qcUg4djhLYUV4bmtCMzd6?=
 =?utf-8?B?NHZKUmFLU2hxUWZXdkp3WWpvVE56c2o5YXRUWG95bWRtSzZQSnFoM2VlQVN3?=
 =?utf-8?B?ekt3cEZESFRGdWZSaGhqdzU1aXg5R1NGeU4rL2xKTC81RXcvTytZbHhZOEZp?=
 =?utf-8?B?Y0dYTkh5ME8yZ01ONnk2bXFkdWtZQk1hNmQ2RzJyRHNzRS8vUUVEK20yc3Qy?=
 =?utf-8?B?NVRodng0TjJqc3J3TWxDcWRRdDF2ZkJPSGlJNWY0M0Q5TC9MM3JIdGVaV0oy?=
 =?utf-8?B?T3FxUm52ejY5bVVBQmp6VTd6M0dmejYzSThzeWJUR2pjSU4zVjlTOUxLQVNU?=
 =?utf-8?B?NHdtemRLNlBSUmFYN084Snl6RmZpcHk3Y1RRdmYyR2lyUWVBYmNuYTEybytY?=
 =?utf-8?B?VHZjVmgveUlLSHA2R3dFYkdXZ3hodEhUZlc5cnFzMEZGUC8yQ0VkVkVDTHBm?=
 =?utf-8?B?TkZNYm9rR1BLVjcxaUYwWFRhRGRQbUs2TEpPVTc5ckp3d21zRmNnV21vQmJW?=
 =?utf-8?Q?nFqdAv9XbvmMAI1VF2GUQIheg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded471fb-f810-4bd3-c37d-08dd02bd338c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:56:19.2936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78gcAxIzmo9mC9qFGfNspz/ChPqT4uoA0MQXmrOcydHCJNct7VIkvHOFQdjbj19XlX6gVsPmpCuSqTOH2INDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6030
X-OriginatorOrg: intel.com

PiBGcm9tOiBKaWFuZywgRGF2ZSA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBOb3ZlbWJlciA3LCAyMDI0IDExOjIzIFBNDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDI3LzEw
LzIwMjQgMTU6NTcsIEh1YWlzaGVuZyBZZSB3cm90ZToNCj4gPj4+IFRoZSBjeGxfcG9ydF9zZXR1
cF90YXJnZXRzKCkgYWxnb3JpdGhtIGZhaWxzIHRvIGlkZW50aWZ5IHZhbGlkDQo+ID4+PiB0YXJn
ZXQgbGlzdCBvcmRlcmluZyBpbiB0aGUgcHJlc2VuY2Ugb2YgNC13YXkgYW5kIGFib3ZlIHN3aXRj
aGVzDQo+ID4+PiByZXN1bHRpbmcgaW4gJ2N4bCBjcmVhdGUtcmVnaW9uJyBmYWlsdXJlcyBvZiB0
aGUgZm9ybToNCj4gPj4+DQo+ID4+PiAgICAjIGN4bCBjcmVhdGUtcmVnaW9uIC1kIGRlY29kZXIw
LjAgLWcgMTAyNCAtcyAyRyAtdCByYW0gLXcgOCAtbSBtZW00DQo+IG1lbTEgbWVtNiBtZW0zIG1l
bTIgbWVtNSBtZW03IG1lbTANCj4gPj4+ICAgIGN4bCByZWdpb246IGNyZWF0ZV9yZWdpb246IHJl
Z2lvbjA6IGZhaWxlZCB0byBzZXQgdGFyZ2V0NyB0byBtZW0wDQo+ID4+PiAgICBjeGwgcmVnaW9u
OiBjbWRfY3JlYXRlX3JlZ2lvbjogY3JlYXRlZCAwIHJlZ2lvbnMNCj4gPj4+DQo+ID4+PiAgICBb
a2VybmVsIGRlYnVnIG1lc3NhZ2VdDQo+ID4+PiAgICBjaGVja19sYXN0X3BlZXI6MTIxMzogY3hs
IHJlZ2lvbjA6IHBjaTAwMDA6MGM6cG9ydDE6IGNhbm5vdCBob3N0DQo+IG1lbTY6ZGVjb2Rlcjcu
MCBhdCAyDQo+ID4+PiAgICBidXNfcmVtb3ZlX2RldmljZTo1NzQ6IGJ1czogJ2N4bCc6IHJlbW92
ZSBkZXZpY2UgcmVnaW9uMA0KPiA+Pj4NCj4gPj4+IFFFTVUgY2FuIGNyZWF0ZSB0aGlzIGZhaWxp
bmcgdG9wb2xvZ3k6DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgQUNQSTAw
MTc6MDAgW3Jvb3QwXQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgSEJfMCBbcG9ydDFdDQo+ID4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyAgICAgICAgICAgICBcDQo+ID4+PiAgICAgICAgICAgICAgICAgICAg
ICAgUlBfMCAgICAgICAgICAgICBSUF8xDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgIHwNCj4gPj4+ICAgICAgICAgICAgICAgICAgVVNQIFtwb3J0Ml0gICAg
ICAgICAgIFVTUCBbcG9ydDNdDQo+ID4+PiAgICAgICAgICAgICAgLyAgICAvICAgIFwgICAgXCAg
ICAgICAgLyAgIC8gICAgXCAgICBcDQo+ID4+PiAgICAgICAgICAgIERTUCAgIERTUCAgIERTUCAg
IERTUCAgIERTUCAgRFNQICAgRFNQICBEU1ANCj4gPj4+ICAgICAgICAgICAgIHwgICAgIHwgICAg
IHwgICAgIHwgICAgIHwgICAgfCAgICAgfCAgICB8DQo+ID4+PiAgICAgICAgICAgIG1lbTQgIG1l
bTYgIG1lbTIgIG1lbTcgIG1lbTEgbWVtMyAgbWVtNSAgbWVtMA0KPiA+Pj4gICBQb3M6ICAgICAg
MCAgICAgMiAgICAgNCAgICAgNiAgICAgMSAgICAzICAgICA1ICAgIDcNCj4gPj4NCj4gPj4gWWVh
aCwgSSB0cmllZCB0aGlzIHRvcG9sb2d5IGxvbmcgbG9uZyBhZ28sIGl0IGRpZG4ndCB3b3JrLiBB
dCB0aGF0DQo+ID4+IHRpbWUsIEkgdGhvdWdodCBpdCBtaWdodCBiZSBqdXN0IGxpa2UgdGhhdC4g
VW50aWwgcmVjZW50bHkgdGhhdCBJIHNhdw0KPiA+PiB0aGlzIFsxXSBpbiBzZWN0aW9uDQo+ID4+
IDIuMTMuMTUuMSBSZWdpb24gU3Bhbm5pbmcgMiBIQiBSb290IFBvcnRzIEV4YW1wbGUgQ29uZmln
dXJhdGlvbg0KPiA+PiBDaGVja3MNCj4gPj4NCj4gPj4gSSBvbmNlIHRyaWVkIHRvIHVuZGVyc3Rh
bmQgd2h5IHRoZSBjb2RlIHVzZWQgImRpc3RhbmNlIiB0byBkZXRlcm1pbmUNCj4gPj4gdGhlIG9y
ZGVyIG9mIHRoZSB0YXJnZXQsIGJ1dCBpbiB0aGUgZW5kLCBJIHN0aWxsIGNvdWxkbid0IGZpZ3Vy
ZSBpdCBvdXQNCj4gKGFuZCBJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgaXQgbm93KS4NCj4gPj4g
SUlSQywgbmVpdGhlciB0aGUgQ1hMIHNwZWMgbm9yIHRoaXMgZG9jdW1lbnQgbWVudGlvbmVkIHRo
ZSBrZXl3b3JkDQo+ICJkaXN0YW5jZSIgYXQgYWxsLg0KPiA+DQo+ID4gT2gsIHRoYXQgbWVhbnMg
dGhpcyBuZWVkcyBhIGNvbW1lbnQgb3IgYSBiZXR0ZXIgdmFyaWFibGUgbmFtZS4NCj4gPg0KPiA+
IEluIHRoaXMgcGF0Y2ggZGlzY3Vzc2lvbiBbMV0gSmltIGNhbWUgdXAgd2l0aCB0aGUgdGVybSAi
YW5jZXN0cmFsX3dheXMiDQo+ID4gdG8gZGVzY3JpYmUgdGhlIHNhbWUgY29uY2VwdCBvZiB3aGF0
IGlzIHRoZSBvZmZzZXQgKCJkaXN0YW5jZSIpDQo+ID4gYmV0d2VlbiBjb25zZWN1dGl2ZSBpbmRp
Y2VzIGluIHRoZSB0YXJnZXQgbGlzdC4NCj4gPg0KPiA+IFsxXTogaHR0cDovL2xvcmUua2VybmVs
Lm9yZy9aVUhlVExaYitvZDhxNEVFQHVidW50dQ0KPiA+DQo+ID4gRG9lcyAiYW5jZXN0cmFsX3dh
eXMiIG1vcmUgY2xlYXJseSBjb252ZXkgdGhlIG1hdGggdGhhdCBpcyBiZWluZw0KPiA+IHBlcmZv
cm1lZCBhdCBlYWNoIGxldmVsIG9mIHRoZSBoaWVyYXJjaHk/DQo+ID4NCj4gPiBOb3csICJhbmNl
c3RyYWxfd2F5cyIgYWxzbyBkb2VzIG5vdCBzaG93IHVwIGluIHRoZSBDWEwgc3BlY2lmaWNhdGlv
biwNCj4gPiBidXQgdGhhdCBpcyBiZWNhdXNlIHRoZSBDWEwgc3BlY2lmaWNhdGlvbiBsZWF2ZXMg
YXQgYXMgYW4gZXhlcmNpc2UgZm9yDQo+ID4gc29mdHdhcmUgdG8gZmlndXJlIG91dCBhbiBhbGdv
cml0aG0gdG8gdmFsaWRhdGUgdGhhdCBhIHByb3Bvc2VkDQo+ID4gb3JkZXJpbmcgb2YgbWVtb3J5
LWRldmljZS1kZWNvZGVycyBpbiBhIHJlZ2lvbiBjYW4gYmUgc3VwcG9ydGVkIGJ5IHRoZQ0KPiA+
IGdpdmVuIENYTCB0b3BvbG9neS4NCg0KUmVnYXJkaW5nIHRoaXMgcGF0Y2gsIHRoZSBkaXN0YW5j
ZSAob3Igb2Zmc2V0KSBpcyBvYnRhaW5lZCBieSBtdWx0aXBseWluZyB0aGUgbnVtYmVyIG9mIGRp
c3RpbmN0IHRhcmdldHMgaW4gcmVnaW9uJ3MgaW50ZXJlc3QgYW5kIGl0cyBhbGwgYW5jZXN0cmFs
IG5yX3RhcmdldHMuDQpJZiB3ZSByZW5hbWVkICJkaXN0YW5jZSIgdG8gImFuY2VzdHJhbF93YXlz
IiwgSSBhbSBhZnJhaWQgdGhhdCBjb25mdXNpb24gd2lsbCBhcmlzZSBpbiB0aGUgZnV0dXJlLiBC
ZWNhdXNlIHRoaXMgdmFyaWFibGUgaXMgbm90IG9ubHkgZGV0ZXJtaW5lZCBieSBhbmNlc3RyYWwg
d2F5cy4NCg0KSSB0aGluayBlcF9kaXN0YW5jZSBvciBlcF9pbnRlcnZhbCwgZXZlbiBlcF9vZmZz
ZXQgd291bGQgYmUgYmV0dGVyLg0KDQo+ID4gSW4gdGhlIG1lYW50aW1lIEkgaGF2ZSBmbGFnZ2Vk
IHRoaXMgcGF0Y2ggdG8gRGF2ZSBmb3IgY29uc2lkZXJhdGlvbiBpbg0KPiA+IHRoZSBuZXh0IGN4
bC1maXhlcyBwdWxsIHJlcXVlc3QsIGJ1dCBJIHN1c3BlY3QgaXQgd2lsbCBuZWVkIHRvIGJlDQo+
ID4gdXBkYXRlZCB3aXRoIGEgY29tbWVudCBhbmQvb3IgcmVuYW1lIHRvIHJlc292bGUgdGhlICJk
aXN0YW5jZSINCj4gPiBjb25mdXNpb24uDQo+ID4NCj4gPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL2J1bmRsZS9jeGxsaW51eC9jeGwtZml4ZXMvDQo+IA0KPiBJZiB3ZSBjYW4gZ2V0IGl0
IHJlc3BpbiBhbmQgdGFnZ2VkIGJ5IG5leHQgd2VlaywgdGhlcmUncyB0aW1lIHRvIGdldCBpdA0K
PiBpbnRvIHRoZSA2LjEzIG1lcmdlIHdpbmRvdy4gT3RoZXJ3aXNlIGl0IGNhbiB3YWl0IHVudGls
IDYuMTMtcmMgZml4ZXMuDQo+ID4NCg0K
