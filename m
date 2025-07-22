Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663226B085
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199428; cv=fail; b=ACEhudosXY8WlV2w6ePL02bzTIc1lT3kIBJ4rmeTGgcK3KQ97IruykAgQItuxri/+Sjg9n/yJBRXqFeGUGfmTs4V/wiOkbr+h9C7ZmEpNSvYLsKYv17eXPtU+Ix6I/AZFZx2HP79JKtmJvdQ9ySCypJ29Dw55n3Akzgz5qJeg+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199428; c=relaxed/simple;
	bh=O+guRZV2eg+oEtIYiA2IJTNnO1mGzLc6700X03QUxIM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=SdQ3giBxYO++KHnpJs5ShdvBve4RpUUvZ7+qWxG7ydQw3UtMH2LJF0P+LUHulb4k2NgwfU4ADqkcATipy6nFO8yoVcnEjABiMrdH+uxx8XPBX0dF4g4pDDlwKb8gI54UX8v86k9RaJyPGaiMdwiCyqewDGE8V5voG+NYWb/7zGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HheXw5fT; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HheXw5fT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753199426; x=1784735426;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=O+guRZV2eg+oEtIYiA2IJTNnO1mGzLc6700X03QUxIM=;
  b=HheXw5fT8QReUVhVx42Al/Usf4mTpGUREDVjqYOci+3eDYcGPuaMXm6n
   N3GgL2/BQ0ZKXi599cjp3cmQBqthZgjywmgcT5LGvUyp4fXYLesEDWTRD
   mf6RlGOHN/0bV8P5D46VGgCW7kjzP7Tau5BezU9r/dM6xLzs708Pqmudn
   h9ROh8mGz5nB56yjF3wTHhGEUrr7qFKGs1TiT0AV/MSakMd8JgXrSDikZ
   hFu88ZaGlY+g+J3XpZdKggIk1g6d0Klu+Ps1evI7spXUxQMCEfwqu+cGG
   cMo3Yzr+Ld2+2YwN4jnhl2M/x/fxw1Y79Ph3U/htGpojmdul8kJSZTEop
   w==;
X-CSE-ConnectionGUID: Ufu1W+I1SE6pUSVMYdxN/w==
X-CSE-MsgGUID: YtOWEUG9RWuXLhEk1bbVkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55308178"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55308178"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:50:26 -0700
X-CSE-ConnectionGUID: z/RlUyXfQSy6TOZCLK+wHA==
X-CSE-MsgGUID: tjSJqFPaT0u5AGA2DY00Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158484754"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:50:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:50:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:50:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.73) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 08:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcUUq0Hr+UU7G/Oys9mUjR3SGl5F2pT5Ej0luPQSPTeP+Ouvq1+QF/w9cpTVnSnE4Que8de3Q0x4H5fi6PVbzQ5GLoweTIy/879xMkGZOCTDeHLnsiwQRdL1NJ4XH68yv6WMcQa4IB9tHQYDHNACGhAxA7r+Mnm+EJp+j6JV3eZp5EQbrv7oLbTK10s/8QztUkruZ5907uPuEkNwUFIrX7Oh6Psh9bDrRU0O1y0fIgmwMr09B8/zFmjxN/e+34n0oxwtFvVTyE0eqmSCUNBh2IvyZs0/KF2QNeWSduC04d7j1GXb10lwauVhM3v4W859yv36inmZm3+HMXfTxmk+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wH9VorucVbow42pfpW4bak8OiLZ/2hbCy+j/WU19Oo=;
 b=pJs2galvRbPlhvmIhEJbjjg8H1Yg+xN8kR4NDA/8QvipiGXzi1IU/WGZIY3n5+mYC7U+LKsWOm7YmQxPfN32svPpAyw79P0jjkaFhGT594sgVJL6aic9HcI0iT+YNEIafA8Kjzgk3WYVswVW8KvHYDqNbOkzVXMHhf+1u69CS0suAkcD+6Ha/GLiDsKa1oF8pxP46AEcZ1asmeQGw5Xbz9k4vEO4C0Q8t12HGLKlvAhzV4ZfRpaKHracHGn1KISl0m2K1uSHll8fpMcxOLr7ekhkrW9mkfcn82hIeIUOolOPzY/wnhSAMt6Md9ksQHe/elqLpCSK911AKz/CtYmOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:50:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:50:21 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 08:50:19 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <687fb33bc294d_134cc7100b1@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-5-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-5-dave.jiang@intel.com>
Subject: Re: [PATCH v7 04/10] cxl: Defer dport allocation for switch ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee8732d-c414-482d-6a0c-08ddc9377703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmNwM3VtY1RDbEdsZW5WVllkZnFTTXF4alhleTNmUFowbVViU3pSdDQ0Ukpm?=
 =?utf-8?B?Q1N5WDdmTG00UDFrQ0NXa1IwdFI4SVJSeSs5UDdrZkZnc2ZZMzN4bVZSNmgr?=
 =?utf-8?B?ZFZSN3VXektOT1lQemxhMDNod3lXemtBSStxNFUzcGFXdzA5aWhMa09QMVlo?=
 =?utf-8?B?bDNXdDlvVmZXTktFcGlzYnZTYzNKWWY0RzFWMmd5SjFpZzkxSmxNc0lLT3Uz?=
 =?utf-8?B?RzZORnByYXNlS1JmK3hnMWFTL01KZXYrWTlTTGxDZURDclRzOWp1bzZ0YWZY?=
 =?utf-8?B?QVRwenI0RDl4NVhDQ3Z2UkcxK0RVbkVzaEhBZll6SUE1b1MxekVyK3U1dXda?=
 =?utf-8?B?NHg5dzhLMmxZaDdnand4dWpBSHFyTjd4TXU5Z2hSdzZFZDB5ZVJTOW9UMXRN?=
 =?utf-8?B?bmlvQ3F1ZWZDTUtJdmRuRkEyWloyVnJyNy9iM0luMm5zUVlkbzRQTCtHTDNV?=
 =?utf-8?B?MjAxKzltNmpBaHZObE15QUhxTGl5L0RQZ1MvWXBOVXdGK3pQTTVyaEVRNDFO?=
 =?utf-8?B?Q2ZROGI3Z2xtcnZuWStkRlhXTms4NXBJTnRTSkRod1p2bFQxcFVPcTZCVFZG?=
 =?utf-8?B?K25CeTdEb0QrRFNaekc4RW9uY210eW5UY3ZGMkwvZmpNMHBZdjNZRzBEOHVM?=
 =?utf-8?B?bUhWSHYreTgvV1Iwcnc0TmFzTUVnRUpzZXNkQjRHSS9BTHZDbmhhUGk1QnZt?=
 =?utf-8?B?bjl4QzFmYU9ESHVhUk5wNlRIaXg2cDVUSUpZWXptUlhwdk1iT00xWkRQRUFv?=
 =?utf-8?B?am9ZLzNaYkpKQkw5TUs5QmsrNlBvYU5VbTJNdHRhSEdXbEdXVzEwOXhEOHk5?=
 =?utf-8?B?MHltRFBwZ1Y5dHZNQi9yU3cwNHcrd0JsOGx2ajgvOWY4cTdYZUdneFpMaW5v?=
 =?utf-8?B?U1cxZkJKR0JvWWNab1VqTnA0QWwvQm1ndnk2TDNlbDZMMFhZbjlOb2N4cUdT?=
 =?utf-8?B?dlg2ZGtPWTd0L0FIY2NzcEpndEVtZHlvTW4zcmc3TUx0ZmRlSk1hN3RmdHMr?=
 =?utf-8?B?YVNRakk5T2F1NkozNkNuMjhKUWh0ZFd1NGhER3dVWW5Cb2pWQXUwcnJXdWhS?=
 =?utf-8?B?Sk82d0RVaVlDSDBzbHNnOS9UaDVnRWdJM0o5M09iaUd6NzVtZEJxTzVUVGxR?=
 =?utf-8?B?WTNKQnVjWmRsRW4wY1ZrdG53MVViZUNhMFNnOElpOCtYMTlONlBKTTgxR05L?=
 =?utf-8?B?SlQrVjdIb0N5bG9vTm5Sbzl4RDRMMi94c1QzT1FsZGhESEpzSG5HR09WUjBm?=
 =?utf-8?B?cWNjZlRJVnhFRnhkQ01Bc2tUR21OR3A0cWpHR1lCY3JGMEQ2QVp4N3AybUw5?=
 =?utf-8?B?Wmo5QUIybE0rWlNxUlA0bXRsaVBHUmNNZjBRRktZb1d1aVhYWklnVGJiUmJw?=
 =?utf-8?B?UmZ3VkhQWHFlRWEyNm8yb1dTNzQxMjQ5cmxtUUhVN2VWZk1jMjJTREtJeWlT?=
 =?utf-8?B?WDRMMmw3V0k4UDZucnFDdDEwY3RwMFY5RXNaZEdyUSttd2tQRFBSSlhFUUFu?=
 =?utf-8?B?YzlSVlhndDFrS3FQMFhqaElhdk0yZ3VWVnZjbGRPQmNRSko4N0pXUkpKQWcz?=
 =?utf-8?B?dWViTHVpSGVLZWRibG14cmNCYU9UVVl3Y2hnaktWWkJxcVYxRDlGdGJWdHlX?=
 =?utf-8?B?MFljRGJ2UGszU1FwTjVHcmp6NEcwZ0pOaFdnQWtCTzNnRlFudVdlamswTzRX?=
 =?utf-8?B?R0NobkorQ1VHNlJvUVl4UHErWmlSWlFRSEs3aWd2WUxPZnhrR1E1V2E2eG8v?=
 =?utf-8?B?WUMrSG5aQS94SisyMWZ3NmUvSWswYWxnSzdBRThvdGZqZUVMRWJGZDN6azJq?=
 =?utf-8?B?QmFMRWVIMmZHa0kwZDJveTIyV011N3VXcW1iSGdqYjIzeExjZ2N0REpWTWtD?=
 =?utf-8?B?VGVvRnBYWlRUYVBKclU0TFhScERMVWp1ZzBhS0lKQlMyTDFjNURKMlhjTFNr?=
 =?utf-8?Q?HvC6I1ygtjY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXl2V3NIcFhhRjVIUjdBL01paVB2TERUSThCYWJ1TWxrWkRVLzFkMzRZVFR2?=
 =?utf-8?B?eWF0TnV0aEtHVVppM3BneWFGUnZtTWd5SWpqZ0x6RlBkNjBHMVpRTjcwM1VP?=
 =?utf-8?B?UWhicDdYWGh2SkdzcEJ6Y2dlcThUWWl3NHNXTWdmMUxNeEN1N1B0c0Zpalo1?=
 =?utf-8?B?cEt3dzY0OUNTamNlODZCczVxNXdvMGd2MkJLZmNWdS9RMm05dDRtZmdhdXkr?=
 =?utf-8?B?eGNTM0dRM3d5MVhwWVp0Ui96dHdIS3laMFcxY2x5U2JNemZCcWV0QVJxNnBk?=
 =?utf-8?B?TTczNnUreC9EY1g4dyttcWtUUUdSMkRZcmRpOCtuMC85TVlrMEZ2UVB2SDdz?=
 =?utf-8?B?UlMrYW9kc2dObC9nTVRQdUtVY00zQllZNXZraUFSclVHM202ZjdlVEx6MG1W?=
 =?utf-8?B?c2REMjRlS3pVVEp1Q1FjVDI5SkJkUllrd2R4bFMxN3lxYUlVTXoxNm05d1BC?=
 =?utf-8?B?MEFqbFY3VnlzVmN1Qkd3VmQ5OGJESmNwdnZUNUVEQW1pUTJjVitVbnlxM1BG?=
 =?utf-8?B?RlF6WjFMRXRtMGlOUUlrS1prNTBDVkZFV3NKeHZKTGNPUFdBU2lrVWJxTGdj?=
 =?utf-8?B?aFpqLzVzK28xREF1MDhGSjVsOTNPUTc3a3lPKzIvZEd5SW9HMUR4WGgyeVFD?=
 =?utf-8?B?WG4vUTd3UmFJNlByY0Z5QStCRWNsRXVyTlp4YnVpNnRBN0RMektWOHNpd1pV?=
 =?utf-8?B?Uy94cDBiWi9udFRDOUxmS2NWb28wQk9XS0M5Zk9Ma1lJa3BzQUJCUkJ1T3B4?=
 =?utf-8?B?U3BMUXRHUWhwWWlFYUpGQ2pSa1UveHl3Y0xJc1NhOGdLd0kybWlZamlhVlpk?=
 =?utf-8?B?VkdYNXBIb1grODM4ZkZaMjBadHZvUldXM2hCODBJOUo5SG1PMnVsTnozcGJR?=
 =?utf-8?B?YkVhWGtrNW94Tnc3cU9ITi9Wb3JJTHA0NWw2NitpcWQxSnIwNk5abGJ5T21s?=
 =?utf-8?B?ZU9md25hVmJzRktyam5CVm8zMDJZaGFZaFNiSWp6QUFSZHpWdVRkbkxPYUJV?=
 =?utf-8?B?MFdTYXJpLy9zUFF0MTBLWHQ3RzNFLzQ3NDJ4OVpRZi9IczlRWFFXT3AvQXdP?=
 =?utf-8?B?d2pFay9BK3czTXhCRjBZWGx1cURxbC9DN3pqdHdTdHpCSXYyQ0Ywb01kQnhP?=
 =?utf-8?B?bU42dVNyTXRmeTlXRi9IeHo0VWlHd0VUWXQxYVY5YmdkY3FPWGdQUzRjc0VS?=
 =?utf-8?B?T0NtVmlMWlFYbG95b2thbS90NWU3Sjc0VC9pZzZaSG82dW1xa0lmSS84SVVs?=
 =?utf-8?B?VmdhZ2l0eFY2bGtBd1hOYjR4bHlIZkZFYjIwQU43Nlc5Ykp4N24yRUVpdFVw?=
 =?utf-8?B?SmFmVU9iNXJLYWl6Ykc3citPOTE2WkVORVZHT0FkRFk1RE5XcElHamFHbWRa?=
 =?utf-8?B?bWpMSUlvMGZibDk1emZrVDJHKzhxWUdKZk1lTzg2bVJQckZ2RTNWMU5LVmpI?=
 =?utf-8?B?MjBBTUhKSEw1UkN2Tzl6bm5ZekhUTVpjaytSODV0NHdXMkdDZ05kOWJOSTRU?=
 =?utf-8?B?NElidGFrVmtQZG5IMDlWcW9PdTRXRVJOTXJMTklicVg5T3YrbGFVNEl5Q0VM?=
 =?utf-8?B?Wjd4R3QzSy9GT0dLM0dyK0VyR005d0oxL3dCSVVNRjQ0SFlLWHFmcHdFTi9V?=
 =?utf-8?B?N2NuTEhVT0d3VkNEWTliQzdxSm1HRjhRdXVyOGcrWC93K0x4OHhpTGV4bUhZ?=
 =?utf-8?B?eWJ1bmtRU2hCOVU3elVLNCtudDI0V0lKdU55MVU1MzZxMnZYWVpua3ZEekh2?=
 =?utf-8?B?Y2NFRndOa2tnUTFLY2h4QmZ4UUZlRlMrL2liUXQ4U25aL1B5aDdjamRWdThM?=
 =?utf-8?B?VDJ0Zm1vSE1sc3VaOXhRV3dXWU5aZHIxMFBxY1lKZ3ZDSnhFS3NqVDN6Qlps?=
 =?utf-8?B?TlJkZFFWdVpmR3d0ekVUWW90c2h5Mm1McXRJaVRsRGMwZ2FmcVFvVHY5NVR3?=
 =?utf-8?B?TGN2c1dmTElJYWJidkp2eWJmWVJxSzk3Z0xOZEFoWU9hQWlWNWFiam9vVnRz?=
 =?utf-8?B?OVJUOUg0KzZ5WGduNktSbHYwb3ptSzNpa1BMWTRyWGYwKzVrZldyNEtDbC8v?=
 =?utf-8?B?eUZvQkJQNWd1VjlMVDdKaGJkQ0FTRFptK1RoRlhKOUp5cmdxOTNxbjVHdW1D?=
 =?utf-8?B?dDU1bGV4bzl4RVhUZTNRRWJmb0lhQkZhdjlMa3dNQzNnUk1GeVVDWnB5UGsw?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee8732d-c414-482d-6a0c-08ddc9377703
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:50:21.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0pvUccuBNyNi1oPZaHi4N0HsL8nBcuKIGZWJ9sUuAhyg1abtXb2EkSpRNU7AF0GumLJlhRRXRw9J4zzeZTz95v04KyK8UKuWkDm9ThoQpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com

I ended up with more comments than I was expecting. The logic looks
sound, but the organization and naming threw me in several places. Jump
to the commentary around the devm_cxl_create_or_extend_port() for the
meat of the feedback.

I did pause and think, "should I be giving this much feedback this late
on a patch that has passed other review and looks functionally viable".
It comes down to whether I expect to be contributing to drivers/cxl/
longterm and would I send follow-on patches to clean this up, the answer
is yes to both.

Thankfully, I also found a crash with the current code in
devm_cxl_add_passthrough_decoder(), so it needs to be respun anyway.
That "too much feedback" question still lingers such that I am open to
pushback on some of the arbitrary naming and organization choices.

Dave Jiang wrote:
> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.

Some minor grammar to fix up below, but I do like that this changelog
attempts to tell the before and after story.

> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerate downstream ports composed

s/enumerate/enumerates/

> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> use add_host_bridge_uport() to create the ports that enumerates the PCI

s/use/uses/
s/enumerates/enumerate/

> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached and drv->probe() is called and

s/attached and drv->probe()/attached, cxl_switch_port_probe() is called

> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe

s/envoked/invoked/

> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()

Might as well spell these out as cxl_mem_probe() rather than make the
read lookup that cxl_mem->probe() points to cxl_mem_probe().

> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> In this commit, the port create and its dport probing in cxl_acpi is not
> changed. That will be handled in a different patch later on. The behavior

s/different patch later on/later/

> change is only for CXL switch ports. Only the dport that is part of the
> path for an endpoint device to the RP will be probed. This happens
> naturally by the code walking up the device hierarchy and identifying the
> upstream device and the downstream device.

The story of what this patch does in the end gets muddy in this
paragraph, and the paragraphs below just look like narration of the
mechanical code changes rather than the story.

The story as I understand it is:

"The new sequence is instead of creating all possible dports at initial
port creation, defer dport instantiation until a memdev beneath that
dport arrives. Introduce devm_cxl_create_or_extend_port() to centralize
the creation and extension of ports with new dports as memory devices
arrive. As part of this rework @target_map moves to 'struct
cxl_switch_decoder' so that hardware port-id lookups can be amended at
runtime."

> 
> There are two points where the interception of dport creation happens
> during the devm_cxl_enumerate_ports() path. The first location is right
> before the function calls add_port_attach_ep() where it does the dport
> allocation for the RP. Once the dport is allocated, the iteration path
> is reset to the beginning to try again. The second location happens
> in add_port_attach_ep() after the location where either the port is
> discovered or allocated new if it does not exist.
> 
> Locking of port device during __cxl_port_add_dport() protects modifications
> against the port and its dports while multiple endpoints can be probing at
> the same time and the same port is being modified concurrently.
> 
> While the decoders are allocated during the port driver probe,
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v7:
> - Return dport instead of -EEXIST (Ming)
> - Remove extra goto retry (Ming)
> ---
>  drivers/cxl/core/core.h |   2 +
>  drivers/cxl/core/pci.c  |  88 +++++++++++++++++++
>  drivers/cxl/core/port.c | 185 ++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxl.h       |   5 ++
>  drivers/cxl/port.c      |   8 +-
>  5 files changed, 267 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..8cfead6f3b08 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -122,6 +122,8 @@ void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  					    int nid, resource_size_t *size);
> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> +					    struct device *dport_dev);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..336451b9144a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +/**
> + * devm_cxl_add_dport_by_dev - allocate a dport by dport device
> + * @port: cxl_port that hosts the dport
> + * @dport_dev: 'struct device' of the dport
> + *
> + * Returns the allocate dport on success or ERR_PTR() of -errno on error
> + */
> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> +					    struct device *dport_dev)
> +{
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int type;
> +	int rc;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return ERR_PTR(-EINVAL);
> +
> +	device_lock_assert(&port->dev);
> +
> +	pdev = to_pci_dev(dport_dev);
> +	type = pci_pcie_type(pdev);
> +	if (type != PCI_EXP_TYPE_DOWNSTREAM && type != PCI_EXP_TYPE_ROOT_PORT)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return ERR_PTR(-ENXIO);
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
> +}
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -1169,3 +1207,53 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  
>  	return 0;
>  }
> +
> +static int match_dport(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_walk_context *ctx = data;
> +	int type = pci_pcie_type(pdev);
> +
> +	if (pdev->bus != ctx->bus)
> +		return 0;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
> +	if (type != ctx->type)
> +		return 0;
> +
> +	ctx->count++;
> +	return 0;
> +}
> +
> +int cxl_port_update_total_dports(struct cxl_port *port)

More name quibbling, but this quibbling is not about personal preference
it is about setting expectations with the reader. "Update" to me implies
"may already be established, and may be changed at runtime".  This is a
one-time initialization at the beginning of the device's driver-attached
lifetime.

So, something like cxl_probe_possible_dports()?

> +{
> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> +	struct cxl_walk_context ctx;
> +	int type;
> +
> +	if (!bus) {
> +		dev_err(&port->dev, "No PCI bus found for port %s\n",
> +			dev_name(&port->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (pci_is_root_bus(bus))
> +		type = PCI_EXP_TYPE_ROOT_PORT;
> +	else
> +		type = PCI_EXP_TYPE_DOWNSTREAM;
> +
> +	ctx = (struct cxl_walk_context) {
> +		.bus = bus,
> +		.type = type,
> +	};
> +	pci_walk_bus(bus, match_dport, &ctx);
> +
> +	port->total_dports = ctx.count;
> +	if (port->total_dports == 0) {
> +		dev_warn(&port->dev, "No dports found for port %s on bus %s\n",
> +			 dev_name(&port->dev), bus->name);

Why warn? Driver warnings cause customer tickets in distro bug trackers.
They should be something actionable.

> +		return -ENXIO;

Why fail?

If the driver enumerates a port with no dports then naturally no
endpoint can appear underneath. This just looks like a violation of the
Robustness Principle (be liberal in what you accept) with no gain that
immediately comes to mind. If hardware wants to produce vestigial ports,
let them.

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");

In the course of looking up whether this "update" routine is ever called
more than once, it made me realize that this is yet another pure helper
function that should live in cxl/port.o. It lives in cxl/core/port.o
only so testing/cxl/test/cxl_test.o can override it.

There is no reason that on production distro builds of the CXL driver
that this function needs to live in cxl_core.ko and be exported.

A cleanup project for another time would be move functions like this out
of the core and into something like cxl/port_lib.o. Where cxl/port_lib.o is
builtin to cxl/port.o in the common case, but a config symbol like
CXL_TEST_ENABLE moves port_lib.o to its own .ko object and allows for
the cxl_test magic to intercept at that point.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9691da831224..c1de6872e57f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1551,6 +1551,116 @@ static resource_size_t find_component_registers(struct device *dev)
>  	return map.resource;
>  }
>  
> +static int match_port_by_uport(struct device *dev, const void *data)
> +{
> +	const struct device *uport_dev = data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +	return uport_dev == port->uport_dev;
> +}
> +
> +/*
> + * Function takes a device reference on the port device. Caller should do a
> + * put_device() when done.
> + */
> +static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&cxl_bus_type, NULL, uport_dev, match_port_by_uport);
> +	if (dev)
> +		return to_cxl_port(dev);
> +	return NULL;
> +}
> +
> +static int update_switch_decoder(struct device *dev, void *data)

A more precise name might be "update_decoder_targets".

> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	int i;
> +
> +	if (!is_switch_decoder(dev))

Looks good, unlike patch1 this really *is* a case where all possible
children of a switch port might pass through this helper.

> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	for (i = 0; i < cxld->interleave_ways; i++) {
> +		if (cxlsd->target_map[i] == dport->port_id) {
> +			cxlsd->target[i] = dport;
> +			return 0;
> +		}
> +	}
> +
> +	dev_dbg(dev, "Updating decoder target_map with %s and none found\n",
> +		dev_name(dport->dport_dev));
> +
> +	return 0;
> +}
> +
> +static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	device_lock_assert(&port->dev);

Why is this assert here?

> +	return device_for_each_child(&port->dev, dport, update_switch_decoder);
> +}
> +
> +static int cxl_port_setup_with_dport(struct cxl_port *port,
> +				     struct cxl_dport *dport)
> +{
> +	device_lock_assert(&port->dev);

Why is this assert here?

Just assert at leafs where the locking has actual impact.

This might need a devm_cxl_add_dport_unlocked() to distinguish paths
that add dports while already known to be holding the port device-lock
from paths that do it outside of that context like
devm_cxl_enumerate_ports().

> +
> +	cxl_switch_parse_cdat(port);

Don't you want to do this *after* new dports are added to setup their
coordinates?

> +
> +	return update_decoders_with_dport(port, dport);
> +}
> +
> +static struct cxl_dport *devm_cxl_port_add_dport(struct cxl_port *port,
> +						 struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +
> +	/* Port driver not attached yet, wait for cxl_acpi reprobe */

The reason may not be cxl_acpi, and may not be solved by waiting. I
would just drop the comment. In general "ACPI" should not appear in
drivers/cxl/core/, outside of cdat.c which just happens to reuse ACPI
defined values.

> +	if (!port->dev.driver)
> +		return ERR_PTR(-ENODEV);

I would make this ENXIO because the device is found, just not ready to
take on new activations.

> +
> +	dport = cxl_find_dport_by_dev(port, dport_dev);
> +	if (dport)
> +		return dport;
> +
> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return dport;
> +
> +	rc = cxl_port_setup_with_dport(port, dport);
> +	if (rc) {
> +		reap_dport(port, dport);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return dport;
> +}
> +
> +static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
> +						     struct device *dport_dev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_uport(uport_dev);
> +
> +	if (!port)
> +		return ERR_PTR(-ENODEV);
> +
> +	guard(device)(&port->dev);

This guard feels too far removed from where it is actually needed. If
all dport creation is moving outside of the cxl_switch_port_probe() path
then does that mean that devm_cxl_add_dport() can be replaced by
devm_cxl_port_add_dport()?

> +	return devm_cxl_port_add_dport(port, dport_dev);
> +}
> +
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *uport_dev,
>  			      struct device *dport_dev)
> @@ -1584,6 +1694,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	 */
>  	struct cxl_port *port __free(put_cxl_port) = NULL;
>  	scoped_guard(device, &parent_port->dev) {

Not this patch's problem, but this pattern is loudly asking for a helper
function that does all of this:

struct cxl_port *port __free(put_cxl_port) = find_or_add_port(..., &dport);

...because this "... __free(...) = NULL" pattern is almost always the
wrong the answer.

...however I think a devm_cxl_create_or_extend_port() reorganization
makes all port reference management disappear in this path. See below.

> +		struct cxl_dport *new_dport;
> +
>  		if (!parent_port->dev.driver) {
>  			dev_warn(&cxlmd->dev,
>  				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> @@ -1592,6 +1704,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		}
>  
>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);
> +		if (!port)
> +			port = find_cxl_port_by_uport(uport_dev);
>  		if (!port) {
>  			component_reg_phys = find_component_registers(uport_dev);
>  			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> @@ -1599,11 +1713,21 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			if (IS_ERR(port))
>  				return PTR_ERR(port);
>  
> -			/* retry find to pick up the new dport information */
> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -			if (!port)
> -				return -ENXIO;
> +			/*
> +			 * The port holds a device reference via find_cxl_port_at()
> +			 * if the port is valid. But if the port is newly created
> +			 * via devm_cxl_add_port(), no reference is held. Therefore
> +			 * the driver needs to get a device reference here.
> +			 */
> +			get_device(&port->dev);
>  		}
> +
> +		guard(device)(&port->dev);

This seems too far removed from where the lock is actually needed.

> +		new_dport = devm_cxl_port_add_dport(port, dport_dev);

I can follow this, it looks correct, but I do not like that it redoes
the port lookup potentially 3 times. 4 times if you count the original
lookup before dropping into add_port_attach_ep().

So that find_or_add() suggestion I said above probably wants to be more
like an API likes this:

struct cxl_dport *devm_cxl_create_or_extend_port(parent_port, port, uport_dev, dport_dev)

...because nothing in add_port_attach_ep() actually needs the created
port. It only needs the dport which implies a port exists, then you only
need to do the lookup 

> +		if (IS_ERR(new_dport))
> +			return PTR_ERR(new_dport);
> +
> +		dport = new_dport;
>  	}
>  
>  	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> @@ -1620,11 +1744,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +#define CXL_ITER_LEVEL_SWITCH	1
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> +	struct device *dgparent;
>  	struct device *iter;
> -	int rc;
> +	int rc, i;
>  
>  	/*
>  	 * Skip intermediate port enumeration in the RCH case, there
> @@ -1643,7 +1770,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	 * attempt fails.
>  	 */
>  retry:
> -	for (iter = dev; iter; iter = grandparent(iter)) {
> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
> @@ -1686,16 +1813,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
>  
> +			/*
> +			 * This is a corner case where the rootport is setup but
> +			 * the switch dport is not. It needs to go back to the
> +			 * beginning to setup the switch port.
> +			 */

This feels like a shortcut to avoid reworking the main loop for the new
constraint of adding dports to all paths in the ancestry.

> +			if (i >= CXL_ITER_LEVEL_SWITCH) {
> +				struct cxl_port *pport __free(put_cxl_port) =
> +					cxl_mem_find_port(cxlmd, &dport);
> +				if (!pport)
> +					goto retry;
> +			}
> +
>  			return 0;
>  		}
>  
> -		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
> -		/* port missing, try to add parent */
> -		if (rc == -EAGAIN)
> -			continue;
> -		/* failed to add ep or port */
> -		if (rc)
> -			return rc;
> +		dgparent = grandparent(dport_dev);
> +		/* Only go down this path if we are at the root port */
> +		if (is_cxl_hierarchy_head(dgparent)) {

It turns out "hierarchy_head" is just a "host bridge". Lets just call it
that and not invent a new term. However, I do not understand why
devm_cxl_add_dport_by_uport is done separately from the
add_port_attach_ep() path? Are they not doing the same thing?

> +			dport = devm_cxl_add_dport_by_uport(uport_dev,
> +							    dport_dev);
> +			/* Added a dport, restart enumeration */
> +			if (IS_ERR(dport))
> +				return PTR_ERR(dport);
> +		} else {
> +			rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
> +			/* port missing, try to add parent */
> +			if (rc == -EAGAIN)
> +				continue;
> +			/* failed to add ep or port */
> +			if (rc)
> +				return rc;
> +		}
> +
>  		/* port added, new descendants possible, start over */
>  		goto retry;
>  	}
> @@ -1727,16 +1877,19 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  		return 0;
>  
>  	device_lock_assert(&port->dev);
> +	memcpy(cxlsd->target_map, target_map, sizeof(cxlsd->target_map));

No need for a copy if the target_map is in the cxl_switch_decoder
object.

>  
>  	if (xa_empty(&port->dports))
> -		return -EINVAL;
> +		return 0;
>  
>  	guard(rwsem_write)(&cxl_region_rwsem);
>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
> -		if (!dport)
> -			return -ENXIO;
> +		if (!dport) {
> +			/* dport may be activated later */
> +			continue;
> +		}
>  		cxlsd->target[i] = dport;
>  	}
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..de7883747555 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -403,6 +403,7 @@ struct cxl_endpoint_decoder {
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
>   * @nr_targets: number of elements in @target
> + * @target_map: map of target dport ids to interleave positions
>   * @target: active ordered target list in current decoder configuration
>   *
>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
> @@ -414,6 +415,7 @@ struct cxl_endpoint_decoder {
>  struct cxl_switch_decoder {
>  	struct cxl_decoder cxld;
>  	int nr_targets;
> +	int target_map[CXL_DECODER_MAX_INTERLEAVE];

This can save space by being a u8 since hardware port ids are 8-bits.

I would do a lead-in patch to introduce this and drop the @target_map
argument to cxl_decoder_add() and its helpers.

It might help to clarify somewhere that this is a cached copy of the
hardware port-id list and that it is available at init even before all
@dport objects have been discovered / instantiated.

>  	struct cxl_dport *target[];
>  };
>  
> @@ -584,6 +586,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @total_dports: total possible dports in this port

I was confused by the "total_dports" name choice until I read this
comment. Yes, "possible" is a well known concept for a count of things
that can pop into existing later, like "possible CPUs" and "possible
Nodes".  Just s/total_dports/possible_dports/ throughout this patch to
fix up the confusion.

>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -604,6 +607,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	int total_dports;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -902,6 +906,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_port_update_total_dports(struct cxl_port *port);

...and per above, this is never an "update" it is always static similar
to possible CPUs" and "possible Nodes".
