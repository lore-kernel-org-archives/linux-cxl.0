Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE721ADA3
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192987; cv=fail; b=ufuBba9ZVrKHwd3aQg3fZ6ARvEoD+EiHdQEvyNTSuX/DKTbOLr/9io7TJvYsNGer4hd/u5ftYnIG/QId8Q6nTnQdKyN89UzckkyBQx+Pql0oWSPoCPWMQVfS9+tSrlSBuDY5Qtvlii8qfEShB3WPtT0EWQm8WTj9yh/DdHbBKtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192987; c=relaxed/simple;
	bh=b5fD4z0gWOU0sCxoQkr7oj+CDAQLWtcjaKNqpzczeVg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=u4hk75j23buxVX2LMC22Wbt+IcHq20NUBfZ6xm9Q0uKTIlg+Goy1gSMy3VAxHyiHppdusWJL4aCSIaBzLNlrsWHE0zWQlzYZfjMa4LllMaVC+SmmLEvsbOMxecpgyKxU0K+U3GpxdFIGV/vSB8ZFpfl4aJmFaDt1gLoxQRj9PZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtQFmhgm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtQFmhgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755192985; x=1786728985;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=b5fD4z0gWOU0sCxoQkr7oj+CDAQLWtcjaKNqpzczeVg=;
  b=EtQFmhgmxn5xQCGoHzgZjbxmVn7XA8afK9VippSl6jLF5gjznjafaulM
   V1h6egXpEPqWPuIJvKfJzKy8MbkFtx+oUpDnT8LAGlTaBUWNEanYkXAqn
   aaqEL3Iy+2vwWU9KSqcPmkZPWWGEKemvIMt+FlMjPPUFy04iKkz7xlNId
   JeirmYCpZPXvzQ65brR0bheXqK7NQZM+VVu0euT+ACkymSAFdr5ij/RxU
   ZhfePv5g8N25kf3b71u/bEE/ieVcBP+hE2si/Xpm4ABXW3RiasPPmQaec
   lE76HpTjPskYjNMjt+ebiWGih1uHMce7gz5XBa1vLgjfgurGb38pSeWyj
   Q==;
X-CSE-ConnectionGUID: uilRTwbFRI2XUCxF1jMhCg==
X-CSE-MsgGUID: 70kXqi4PS+mxJQB+5oi4LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68895744"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68895744"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 10:36:25 -0700
X-CSE-ConnectionGUID: dvMeTi2IS1atv7jYiw/ltA==
X-CSE-MsgGUID: cF6W6yX3QtiTaBos74Wx2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197811454"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 10:36:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 10:36:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 10:36:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 10:36:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPaKLZWpWSaYVHbFYTQ8m0nRByj/TTFUi0vDkJ3JNuTIaQ5GayE7OrnwdEtr/JV0pGFbkC0LGq8snHrdxHStm9VYr08pWc0UwnCMWN1OO5LDRanbnWnFyJ60cenQymuFoE8nKXoOdIHDjdBizSNgaOIGrRtFRBrvP/DPWaSwymR+pvO0VdleZ7lUorBHPnshSsDnNdlsXNooJDHilx8ihroeU/S3dP/GdfvMbimBx1UE/9uB2kTTT/5+gNmMILDNLnv0a6b3imclSQcP849NycMsziU8kLD5MVHup3pc5PjLrq3B/RkUEO/rYjzg1ozds0QT5uJW7kuSHJJc4Qw70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbs+KI/SVaBnih6ZVPW+MOAxZ1+cl3pWD7K75h1u/5A=;
 b=MOiuRVTjNBts6s1Jg37DiZM1840HOKOBj5zzQqCE9Tpajb7k8p/FNttXWBsEzU7m4VHHkNiE6bw8h9FgYEsHIy6zt3nEA7XMaDfix9jDh6fiFgqUEvNsHlVBq7uSyDWu3V7y54bI2LJEHGBjox/UnMMNrei2AFrQoNeoRmtc1cde8L/i5iO46dkWC99j/mF0vzb0Ddq3WXXOx09cYtinCK37ROCQ0oVAgp+SLSkKoRN1TcfsSSkkM2l278CMeZgZ5VGqjZabcaos36m+VIFtOShrlRyU/LgpwSN9EOzGKUzorMr8ZYObi/anyD1h32Qb5CBCgk3kqqXx67r5kOukaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 17:36:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 17:36:22 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 14 Aug 2025 10:36:19 -0700
To: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <689e1e938b5e0_27091002f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <aJ1UJOySCoM2M_-M@aschofie-mobl2.lan>
References: <20250813214218.2917555-1-alison.schofield@intel.com>
 <689d348e41a66_2709100cb@dwillia2-xfh.jf.intel.com.notmuch>
 <aJ1UJOySCoM2M_-M@aschofie-mobl2.lan>
Subject: Re: [PATCH] cxl/port: Validate decoder nr_targets against supported
 ways
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bfe3f4-f986-4112-d532-08dddb59158d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU9aVXl5bjhCS1M0R1FYUk9xK3BRUGFMT1h2bDBhSVUwbXl4Z0N4SzZqZmp4?=
 =?utf-8?B?ZjgwT0crY29YNTFLSitZWjdhZW01SW5oZC9LWWdzQTd6TmU1WVAxWXdSNTNO?=
 =?utf-8?B?VTRvOUh6ZmxqWmxHMk4reHNqVlkyVEUzVk9rQ2xrdFlxYjB5dWpJWXVVcm9m?=
 =?utf-8?B?enJsUGltN0ljNU5XNTRmSDNaYmVBNEtBd1Y5QWVwMFNxYWJ5U2wzVnEyNDNH?=
 =?utf-8?B?ek9wTVB1TzFIWHpYbGdUQUVxOHBjNnc5eTl1Tkt3cFNMb2VzeStZZnZXRjYr?=
 =?utf-8?B?cDdaTmFvbmhGbkVBNy9FUlFWTWdRbUJCSUdUYnF3bDN5WnNEZHBtVGl4MjV1?=
 =?utf-8?B?QWZPTUV3YXFTVEJnMzh6THpmOExhK0RFUTkxQ3BHaXl2VGo4SjVhTTk3NWxW?=
 =?utf-8?B?QVVDa0N2bGV3SEtMdHlVVzVQMVNoSlFmdjRLSE5QSEFwOUdvWXduYUFjdDQy?=
 =?utf-8?B?djZqMERoUlNDV01NNmlOZzNMRGJ2VTk1dmZrSDBqWlo3UXBibC9jY3o1WnVw?=
 =?utf-8?B?N3J2RHFxYzJjdXRvVE9JRW5FazdVaDd1UUVObzVrWGYxQXcwekpIRnNpc2FU?=
 =?utf-8?B?VlZISzBGUXptYXRCS2NENDFKaDNDdlowSDdzNGY1bFVKUUFhZStwVUc3Zm5V?=
 =?utf-8?B?R205MXJLMU9XTGIyOWd4aG9yTEwxVUZmUElCa1o1eXpnSisraml0MHFDYU53?=
 =?utf-8?B?WWtjK2tHaENldjZhYmFPM1pmejJMdENodjVQSFh6RllhTHRsejVrWjRXQVVY?=
 =?utf-8?B?cXhFcElIa2VBWFNKdW5sb0tuSGU5aE9xK21JNkZqWXYrbSs4aW9QSzZuZXpQ?=
 =?utf-8?B?MGwzMkVCdllCWkIyN3B0TVVZeGdvclZ5dGhENHJSdFpKajRaTWJvSE9nRU5U?=
 =?utf-8?B?S0kwZ1UyL0J3T2dPSmZ4eUE3OGJhUHRvbmxEZ2s4WXNlbjRScWYrQmtDZlNN?=
 =?utf-8?B?dnh3eFowRy9FbEhwdmN6K1BRc1JlRGpEdzdReDhVeXFzUE1mdUtrV1dWdzhk?=
 =?utf-8?B?VDZjQy9wY2xNUVVSdVk1Mm5iUkVUWUNBUi9EaVhhaUVRZThYYzB4RkdycHZN?=
 =?utf-8?B?c0J0RkJWaERWQWY1Q1k3bm1SV203MFlpdWJ2WVAwNkNNS2JnbWlKaXN1dW10?=
 =?utf-8?B?M2VaaDVHV1doOUtWWmlGazJOWnozT2Q0OWVDcmlyWHJrdE9WaFNCeDR0UlNI?=
 =?utf-8?B?Qmw2TnlTVWx0V3pYeVVHWWMyMEZidnNYMldRZ2orTU1SaklUTlRYK3RuUUJU?=
 =?utf-8?B?ZjdjRnFjN2ZUOHZzZmFxbnA1cm05NW1sY1dIV2hzMy9UT2JoYWhHL0xIYmxQ?=
 =?utf-8?B?MnZZSDVyRld5TlJvdXZYZ1l4R0t0cXNxb1lhQUxiZWk5NmxhbzFMTFd3Q3Mz?=
 =?utf-8?B?Z1g3UlhMdStEQUNyeGJBS1BQclJjWklsVXl0TlR2OEhmSTV4R1ZrL1pCejRX?=
 =?utf-8?B?UjI5NUticmdnOVh1Zlc0dDAzdkcvVmNTS25teEU4MTNLK0sycjZScitMckRt?=
 =?utf-8?B?cGQzc0tlaU93Um05S21BKzFhMTJIM2s5ZEYvYVArVnJYalJGS1F0cTh0VVdX?=
 =?utf-8?B?eGRtNS9xRkpWeHBzR0g4djFUcHVLZThZS1JpTGRpQU1JNzFrWnNkNFl4WWgx?=
 =?utf-8?B?Z0VKU0ptWWV1NGNrV2pmSWRZT1JjbmtPZWZLRlg5VWZrb2JaeFE4bTBzVjU3?=
 =?utf-8?B?eUFBL0tYeFRvb2toaHoyMmZXY21kNVh0THpwK0xWd0pYZUg5VGRXcjUyZVpG?=
 =?utf-8?B?NjRGNkNVVXB0UFY5Y3RJaVFaV0hQaW9COC80eVpZaWNyUDdBNkJ5Z3RXbENN?=
 =?utf-8?B?eDltMHRreC94ckYzczZ5REZzT3VvUjZpWERsbnVnaFlabjY4ZnRmbDVFZjVp?=
 =?utf-8?B?bUVGVHErdEQzTVVMMDFPWU5XNmJuQ2FlaUpWTW9KM2xIVjNvbWMwYVd0RWNl?=
 =?utf-8?Q?I+/Fv05V968=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFVYWpMNzlZZFdQbkEyS0VLMFNBWVQ5d3BFNldILzRUSm1PRXFDY0ZaWUI5?=
 =?utf-8?B?MDhBdlViZ21yZEVaOTNxRDJuaUZ5U2Z2V3RWaXVta3NRZnluQzZBL1Q5LzBi?=
 =?utf-8?B?SzFFV28yVmYvU0w0Qjc4dFp4RXRNbnFGYTgwRVFCK0xYQjRZdVUzczZOTUVR?=
 =?utf-8?B?OXBWTVZjY29ZNHZQTjFLRXV4MGNBV2tQTzBUNUV0azJRNTZ5NnIvZlNydzNE?=
 =?utf-8?B?TG0xdWNKWmhiREpidXBsNFp5aDFsMEp0SUxHbUFpTUljbTFBT1BZZEd3aWFi?=
 =?utf-8?B?WEd2eXNDSjR1UVBmYVNuaTh1ekF3MmZmcUNFRGxsUlBVQ015OEM3dGR2NGk3?=
 =?utf-8?B?aGkycnBnKzM3UFVlcEdMK2dRTVZ3WXgvaURGZjNla1pMRVdGblEwSFFMZUg3?=
 =?utf-8?B?Wkh5aUVUWXhhVUZoMDRxS3VsMVRHNzJMTEo3SDZJVXZjMGxRaGJVRHRKNTBZ?=
 =?utf-8?B?SVY2M1A2SFFKRitHVUtkemYxK20xOGphUmxhV2ZqTDR5ZHlIa2VCZWpWcVhr?=
 =?utf-8?B?U0tYaFZuYXpEVFh3L3o1YmxDYkVRNXVRNkczd0dGZWp5cXlJclBTRHNuWUdn?=
 =?utf-8?B?V000RWxxTjRJNDF4K2pUbG9YRDhVbm9XVnI1ZDAxZmNyNzRKdTh6KzlxMkJ2?=
 =?utf-8?B?d2hhcDVUYlBpU1NyMzZ6cmd4eDhJTzFBRmgwNDBLbjBySHNpR0xMaGZ3QzRp?=
 =?utf-8?B?UERxa203ak9LMWRZUVBqVHdPekRHZUZCYzgvbmJCQjdNNEpRaFV4akpMUHdG?=
 =?utf-8?B?SWpUSjZDT3g3YU5hTEJseS9qZ3lYRmFpL1BpU3pyNG9QQ1JWTzdNbVF2M3BE?=
 =?utf-8?B?SkhZY1ZQV2o4WWVKRnl1cGxyVzkwWGhveGl6eXBleUNwQmVobUViUTE4S20r?=
 =?utf-8?B?QXNvcXhqQkg4T3FWU0VXVFRaVzc0UkdQUGRUOENMQlNPdDBWZ2ZIK2tMMHgx?=
 =?utf-8?B?TTFyTGtaQ3h6TWlYMXpNenlrWmRiWE1oNy9SMlJ5c1RTakZoVEZHOWZBWXR5?=
 =?utf-8?B?d09Mek5BcGFkcTNUaEwrOW4wV2ZCaU52WXFPZEtqM0Fxd0pMNVp2OW5WT1Bu?=
 =?utf-8?B?emJYVjZnMzVaWFVzSkhBSlNwa3FIZXc0K29tWW9WRnVQdTh1T1M3TlZxYkZB?=
 =?utf-8?B?SFpOalFMRkpDU3ZtZDRlU2xqNDdpY0xCaE1Pb04zcElMNERxVTNMR2Ntc2k5?=
 =?utf-8?B?c01JaDF2SytudUhtenlxQS9mTUdPSlR0MjVzWE8relkyOW9SM3pMS2F0VGth?=
 =?utf-8?B?SXR6cFdKUG9BZzBLb2JoMElaQWo0RVdvQmZrS25JRVBabnovZHhQbitWdlJ4?=
 =?utf-8?B?TDFCYnFQV1FxRGxybWh4UUhjeHArSEJRbUIyZHdSMGFKZ3ViUkJNeEw5Rjdy?=
 =?utf-8?B?QlpPVGxrZHV5TDh4aitYSzFqUkoxMkUwbjF6MkVuM1RmR0ZUY1ludWhkVWlX?=
 =?utf-8?B?bHo0MFhRNDA0WXROVFBwOE5oVzBhQjZxVHVMTmN0R3gwdHQ4TTZ2cFJnUjFp?=
 =?utf-8?B?azBDbmVIdkw3a3laaEd5dUZyelRyaE5zQ2VDTDZ3VnVPS2EySU15cDd2dVhG?=
 =?utf-8?B?TzlqenhWc01oZ0h2MWJQVWsyZGw0MTF6UlJ0SVJHUW91Nm5sbUMvakt2a1dm?=
 =?utf-8?B?all6ZzhINmdMN2hpNnRWQUdteldWVDFnUmFhNWlEK0pGM1ZGR3l3bWRsTHlj?=
 =?utf-8?B?ZExRRGsyS1NOSUxjLzlrN0FCeE9sSWg4ekJiOWxhY1RqYVhsVFZWN29VWDV5?=
 =?utf-8?B?dDRWQVh5TER5NmJYWVRqUnI3b0U3ZGxWWktqSSswL2g2djBsaHZtSnd1dFJN?=
 =?utf-8?B?YWF3cUwxcVdOcGxJLzF2ejc4aVBxL1BCQTVEN2k0SDN5ZXlWa3MzUUNZa1lS?=
 =?utf-8?B?N1VpSFdQWVEzQVIvL1ZxdTRTQUk2amJRRC9jUTUrWmJJdUxyWEtRNWpHcVAy?=
 =?utf-8?B?ZzF5c2FxVVBZQU91SGZkTng0eEdTaGUwQVp2dFRmU1BhTVlpQW5WajUrMGdy?=
 =?utf-8?B?TGhjcHA3MXFQc2tTZzhhUDJCMTE1N21NR05mNVZCK2lsMHMyZ0sycjF4UGxF?=
 =?utf-8?B?Nlg0Snl4S1cydVRGcnJsL1JLNFpNS0E0U25SV3BSUVpPbkprTUFWcmZTR2Q3?=
 =?utf-8?B?dEY1V3N3WDhEVzFXYlkzMHBBOHZ6cnVaWkhzaGVzV3BmWWVJRjJNbGpOYmdH?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bfe3f4-f986-4112-d532-08dddb59158d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:36:21.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ullDOSSq+KMtTy9xR292GEE/jyAhcvdJy683+wrai5nDNajJBQ2IFC8pvH5izDL1KkMe8jSm8qDNeio4h+hQ4fP0A7jlnqSwtK2/j+Cdbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Aug 13, 2025 at 05:57:50PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > nr_targets is the number of downstream ports in a decoder's target
> > > list. It is limited to the supported interleave ways: 1, 2, 3, 4, 6,
> > > 8, 12, 16. The existing check only enforces nr_targets <=
> > > CXL_DECODER_MAX_INTERLEAVE (16), allowing invalid values, like 5, 7,
> > > etc, to pass through.
> > > 
> > > Add is_nr_targets_valid() to check for supported interleave ways using
> > > ways_to_eiw(). Use it before allocating a decoder to avoid alloc/free
> > > churn when nr_targets is already known to be invalid.
> > > 
> > > This was found by inspection and hardens the code.
> > 
> > Well, now seeing this and trying to answer the risk question in 1/ led
> > to me to reconsider whether this is a good idea and whether we have a
> > deeper confusion at play:
> > 
> > 1/ "Hardening" needs to come with an actual risk claim. For
> >    cxl_switch_decoder_alloc() the values come from hardware or ACPI and if
> >    those are buggy all bets are off. ACPI is already protected by a
> >    eiw_to_ways() conversion prior to calling cxl_root_decoder_alloc(), and
> >    hardware is even more accurate than this
> >    approach because it considers interleave ways capability.
> 
> If all callers comes thru ACPI then agree no need. When you voiced
> concern over valid host bridge interleave ways, which would be the
> nr_targets of the root decoder (a switch decoder) I imagined you
> were thinking of a path to root decoder alloc outside of ACPI.
> Guess not.

I was looking at the patch in isolation and wondering out loud if we
needed something, but now upon seeing the patch, not so sure.

> > 2/ nr_targets != ways. ways_to_eiw() is the wrong validity check for
> >    switch decoders, nr_targets is a topology limitation, not a
> >    interleave_ways limitation. As far as I can see nothing breaks if a
> >    decoder claims to support a target count that is not a valid
> >    interleave_ways number.
> 
> nr_targets does not have to equal interleave ways for the ways_to_eiw()
> to be a useful helper for validating nr_targets. nr_targets has to be one
> of 1,2,3,4,6,8,12,16 and if it's not ways_to_eiw() fails. I saw it as
> simple code reuse.

See "Target Count" in 8.2.4.20.1 CXL HDM Decoder Capability Register.
The only hardware valid values today for target count are 1, 2, 4, and
8. That is different than ACPI CFMWS which can target 1,2,3,4,6,8,12,16
because CFMWS has a tighter relationship between nr_targets and
interleave_ways. It wants to define regions that target host bridges and
non-host-bridge targets.

The next question is, what if a switch decoder put 5 in its target count
field? Would the driver need to fall over immediately? I think the
answer is no. It would simply be the case that a decoder would set ways
to 1, 2, or 4 and select from the 5 potential targets.

So, I led you astray to make this a wider check beyond the root decoder
special case, and even there the risk of it being a problem in practice.
is low.

> I explored using cxl/test, changing nr_targets at decoder init time,
> and predictable passes if greater than needed, and fails when less.
> But it's not a thorough simulation and not worthy of a more detailed
> simulation.
> 
> Thanks for the review. It was a worthwhile exploration :)

Thanks for the patience to work through it with me! I learned something
about being more careful about the nr_targets:ways relationship.
