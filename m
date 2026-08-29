Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7B3515DA
	for <linux-cxl@vger.kernel.org>; Sat, 29 Aug 2026 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966751; cv=fail; b=dcwLRelFkka4ZtPuhRJ0qAieApwTEMnJOq7Snb5kZK+5NbeV1sqDY7kzL+dMz2tI4rWHGnLlouqu2ix4ZuYxq+9AWUe9Bie97TW8FxaYmr/jjHnOruvZiq97kOMyzLDHxhJgngldm+FuSrQXHO48FdM/DbiNWkjb6BehauSqpes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966751; c=relaxed/simple;
	bh=wtPQQg0onKeSbIWEywUN4Ix2uo0oWREkt4dZjS6ZR6k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KgwuWXC5AzePgz2/TF6npiTTjlyOroH7U2tOHiCgEnwMuvw4g/JnyaCUOKSGhKqJS4CegIBmt6FJ+l1Y/9IZaPVMvAN8frI9o2mj5gAWToCxjsLKNPEPCzlA79cw4xSUKzrEP/dvXXjQDCfxKnWShjzef9gXOBcGbN2Hi+VeYOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WICHAoD4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WICHAoD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787966748; x=1819502748;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wtPQQg0onKeSbIWEywUN4Ix2uo0oWREkt4dZjS6ZR6k=;
  b=WICHAoD40mFzMpA/h4Qcv0M/meQ6lnmJOiUl4U6xqyADixgs+N9YJujo
   L7v6FuOQzmYE3UVvQTkAva/ItyZb6uPX4kk/dRrDf4DDiCA6JnY8rYeIs
   qq+8l4Kdoe/3lAdTph7LfiiLuprA4aSWZsGy60suEzHdRF/wePh2emb0U
   pVoHiCF6k8FyjGsJS9EQL+Vsu7V7zAENXCMPD1QED3GE3k709Dl2QJAun
   ptAnjStBKraPnXrHvKgIQVefkDUxNBDGaYbcak1eL1tnMfL0tuxzOmyvG
   63KTvQEZvPds8Vrbw+0fgC3WzeSOGVMXgwcpQvfGf1exNoq5FKSw+2KYF
   g==;
X-CSE-ConnectionGUID: qjdVqDR1Qaq6meJF2fz9kw==
X-CSE-MsgGUID: Tc/21Yz3TG+hxVsdoII5wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88499321"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="88499321"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 18:25:47 -0700
X-CSE-ConnectionGUID: ks/iKMatRVy4IBVR2pyHRQ==
X-CSE-MsgGUID: PeXNAz0NSjq0YTDzZHgWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="267758285"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 18:25:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 18:25:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 18:25:47 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 18:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mif3kQl3Uq4CjEDP+jZUgETDB7OaOhiuXy/5KyYPhu0IYyFoEshZ3ELqhTLJBdu9/PGIiaS6CYLlsFAz7xBic+1ZWvSvtnnrzmtFf4e21KAUU0m0jd2WPJndUOM6JyuisOd+sdVULr7RR2NVuR9BddWnYIUfF3dJk5T7snrquI4mOf1Mo31/1TJlMdPACyrI5ZyWV5GBN4pCakwE3reAbzLF4CcLtKuTeCdNgqho1dJBdAua261OMuPIG10c+uuiVD5ZeiWmSLS2S8UOJ6cH5tNF9xJmPe27RK9p9Ej7fTPlvCO9sExHg8IqNGVhZeBAG25lkuUpKRyHyQsnhjxj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQmyGgLG+SEyTOr+czkOsT/rIdWmeIDPIAR0576SKMM=;
 b=SC8Jb6DVIDd3SVLdf7s4IzUqGqzmCq5Pm7FOYGhkIQaI/X/rWmE31y4snzzZv3VVN2klX6IGwdf26vT511m99rR/JsWyszjHbyfR1ot89cTif9tWOU2XJiW1PNVxEPP58cwH16rYSQHjX04VNVgqA5ySM/DE4+N4yU54Xbvpl1eRLBSWIyfUceykzZXkoHNmeKInaKaZkWcuJxHLH5bIXKiCGphohGhbyVdM9+0L7wO9qXh0SmXQda5Sd+Wsc/xwWOVEsZOzn9JNTdBfuhIMBhv07mjOjAeArDplSjc33KWz7r0WPtUOBkKT3yonk5nlT4LhHd+tIJxAJR7iwEigOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Sat, 29 Aug
 2026 01:25:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 01:25:41 +0000
Date: Fri, 28 Aug 2026 18:25:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Unregister the pmem region bridge on
 setup failure
Message-ID: <apI1Ebyv8U6ZJWYR@aschofie-mobl2.lan>
References: <20260812061043.57319-1-kanie@linux.alibaba.com>
 <anzo3j2nWsGlZIw_@aschofie-mobl2.lan>
 <6487b454-ac7a-41c8-af9d-e2f17743f30e@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6487b454-ac7a-41c8-af9d-e2f17743f30e@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bb4758-e03a-464c-b5b8-08df056c7049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|4143699003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Nkbi90HjkUy0ro3/IaMLVP7JAOSsuvPtzwRe4XuRrEz3p3SGuLLIx+umpYDFv69GnSZQEkN+s2PRzBZT7kPqYPpAc1scpBzvGCg3wsO0aVbbXXGV7qG/B66If3A6IMfOI2DnXTJKZv5pKCxtCSi2KRqPOMBkjQKnnR9z4sxt9GXBMk+BJ7pesxUSPM4G2wJim5SKHkx+Rvv0x63KhKoP200L0mwiyGhXDHeWjSPgFeZYe4WeY8SYjNdTFWLYo/OL8g5o/ONBjTW7LqGdpVVGq8zkI6nU0bC5ktaN41a6Y2oG2netPIJaOsbFcw0cTBSYsieifhfKCqsplH1nDcLNPtlaHKNp41jq5vUWY+KE7HxnObXuL2eEasrp4mIep7WWHe5AagCY72iR0Tubi/WfaumIbR/H8PVvgkNGuKFKv1TGL0zuyl4BJ4fC7jS8T+DFFTdViBcShc9aJ0ih9jH/g4H5/JcB9cB5Mc1sNTlJXrYj+F2l65YPHRb75qkhm7Tz2ZoHWepwM7QzzqOWmRPGg/5go2bHg5S5Vay5q+9FxzPW086aFshEQkpKbp2NBMD4zCJLxKIoQY3sQWl0bnL1PsT9pGDKg/xl0M9AQtLvXNJwjOIzky4EnQElylcMzZH76SM+a78NB/FoxLSfU/2N8OkKk4hHa3GL853jDmvIMWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(4143699003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1JWTVlSmYxMUluVnB2Y3ZQcXY2L1NxTUh5RUUyREUwS2MxdzdEa1ZkYkZD?=
 =?utf-8?B?a0tVQUNRdDFlNkFVdmEwVmxMMUNPQWl3VFlBWlpEQkM2dC9PTmZMQmFNOTE2?=
 =?utf-8?B?U0VjWHBwQW1WTHhMZHEzdFozVzdkTzRLU3FHVm9JYlNWaUhJOHlzYTRMUU9Z?=
 =?utf-8?B?NTF1N0owaHAxdU9ZSFlQWnFhaUN5UUdNSXNOTjBOQW5ZRmxkZ2d0N0xqUmZ3?=
 =?utf-8?B?WXB5ZXQzM01GM0E1WGVjdEQrNGhYek9RY3VGM2tQb0ZrZ3B0aGVxRFZ0cUlL?=
 =?utf-8?B?QUNuZ0xJM0dwV29NYTF3TENZc1VyN1JHLzNkMFhpcU8zN3dPYThyUE51dExV?=
 =?utf-8?B?QTlGaGNnYU85UDEyVkhRaWxVWFdKZjM2a2hOR1RpYVovNXZmeWNNbkdKTURo?=
 =?utf-8?B?TEd5YndLcHFhWDQ5dGxiNk92b3R6Y00yVCtlYzJVMGxCaGYrUXZTSkN2Rzd6?=
 =?utf-8?B?bnY5dDZSSCtrUHpXWWQwTnlpTVc0N1c3MEdGaWM4ZDRtVERhNkdtd0x0V1ha?=
 =?utf-8?B?Tzg0S004L2I1UVI0Y1dmbENHbVd1cVE0WldyRVhSUWZyM0Y5L1d5NDhoNXZD?=
 =?utf-8?B?MFBSRDl1RVZ4aVJxQllDajQ0d0FWcno5cjQ3YmN1SHJndDhVY0oyVDU3QURY?=
 =?utf-8?B?YjdqNXJGWVNvUG13SDlSNUN3RytGQ0h0RmpKOEpLcmRoV2libDgzYXBpckkw?=
 =?utf-8?B?RHkwVjhwRnRCVWRlZGlmRDI4VFRqL2tKOEZmRElRZ25BV3hFcHk3R0lET3RX?=
 =?utf-8?B?UUpCeWp5ZmpKRlFrYmF6VEdOaER1S0FqbW44Q0JKQTd4RnEzdTZnc3RLN1lx?=
 =?utf-8?B?UjNxYWFhQ3A3a09SUmZINjljUWt4UDFDbkt6TUlobjU4K3U4WGt4QXNMSjAv?=
 =?utf-8?B?cnZKT05NQVJmMHhVT0lpdUtiNnhqQ20vK1Y4aGw0dlNYOWZBTWJQakhLWFA1?=
 =?utf-8?B?WHpaa2FvdXdjOEJmMmR0QTJTVHFjM08vVzdRNnRnZHdWZkdNQm85V3lIYTE2?=
 =?utf-8?B?UDY4TERQN1JSRHNXOTkzM25xbkk5QThqV21KbGxkZkFDWWxRSHc2bExaa2Vk?=
 =?utf-8?B?TVJZS09wakJtdzJZYXE5dHhHY0NEY3FmY2liTGtKc1JiNTlUZGx5ZXdJeVZZ?=
 =?utf-8?B?TFhyWk5kWDg1NkVsTnlsVEliVXRjYytSR0pTTFNheFpXUkxmdUN6Zk9KVG9B?=
 =?utf-8?B?NFdQNFAyRnhlbkwwMEpvKzQrR25IZnJraWNtTlhNdXRBdjlIeDJ2NzZ5NXRW?=
 =?utf-8?B?YVN2V3ZkaE1oWkxDT0hPZlJtRlpYWlcwVXlxZ3doM290WkRLcEMyU21sOVpQ?=
 =?utf-8?B?YVlKcHBLdCtIaTB2RkhaeXhYYWJoNVgwL0lzWVp0TjZKUTFsY0lIQ3BoMEdQ?=
 =?utf-8?B?VE9xRXNvRGk0bnZkNjY3SzUwclBuRngzWTNkdytmT2NIQ210UUNkclAwaE9S?=
 =?utf-8?B?MTlLM21GUFc5UGgrVFlKY1FqZGRiWUlOTndqb3BEZVJYbGRGR3pqYTd4Qkkv?=
 =?utf-8?B?aTRlcHRoR3gyTjhCNWZzY3ZjK2wzbDNaRGptL3FUMVl3ZzRxa00rZTBiZnVL?=
 =?utf-8?B?d0w1TjFhMkJqdC8wRHdGRlE1KytBWHpzTVZNSXMwV3FGd3piSG9iTElzZmVq?=
 =?utf-8?B?MXlIc3JMM0ppWXlBMzNOQ0FnZ1dOcW96TkFBcXcyaEpCUG9zNEhtT2pXZzUz?=
 =?utf-8?B?SEZCd1dRK281cFliaFFhaDErUjBCdDkvN0Ivd0J2djgwSTNyWE9LVk4vaVZH?=
 =?utf-8?B?bGlOVlNuNER5OUxVWVpSZmlpVUR0WGVvZzd4T29xTndpZXBFVkF4MjRERlZ0?=
 =?utf-8?B?SzhOVVBManNpK0xYUWxhQzhyQVFBQXNGemhVVFBLZUx5Mllzb0Y1M29KM09H?=
 =?utf-8?B?Yyt5QWFxSWdBRnA2YjF2elJZdDh0NWdmVXBzSW0rS2trQnpqTVJYbHFRNC9E?=
 =?utf-8?B?Nml4bVBoL1B2YlY0ZkNXdk5tR3A4S1dOSGVYT0oyUmthSGxKMWV0cVRMekFB?=
 =?utf-8?B?MlNaODZFOWtQUkxZUHFlWlZDeHJsbDlkWUNFYWxrMlR1bXZSZFNIR3Y5NEd6?=
 =?utf-8?B?Vzk1K20waXZ0aGlMMHJ4bFVhaHQ0R0FQb05QQVpJV0FsSitrYlBIUytuWEV3?=
 =?utf-8?B?MHlpOFordmtaOWh6SjFtVVpGSjN1Y1ovOEpLTWc0TWRkMFRuUHhuTGZYdzBX?=
 =?utf-8?B?aEJHWGVvS3QvaVpBUVNQZkFYNjVXZEczYlo5VXNzMmR2Y3lXczZrRkZRcHU4?=
 =?utf-8?B?cmlIQW5NTVFnZ0tOQ2pwY3pWRlNLV3JadWNXYnNnWDdDT0FTTU9paGYrQTEr?=
 =?utf-8?B?NzVXTnpmbXU0U2x1SzlhV0dvcDltaVM3UnhXeWR5RFlzcWdrNzhQVStOYytl?=
 =?utf-8?Q?5YOSftOmhzCJwsl4=3D?=
X-Exchange-RoutingPolicyChecked: bM16UUNXgWD+MOejQYoxzvkTreakVaWoEYElZ2I6mzFki+1JJyKvNPByuARr7twzXXY854Lk/Dg7HhRelnt0Me/QxLTsARsoJQMmDiDlTYwCnuV5ojUlUnCk5+s9bOAAy7KHgxe7ahMDNOn1hp7l7+TgF+XW5PUXRvRWmOCklzfsuUFxlsOL11xWPkE93Do9+3gGSXBaxFZ4WCJnYnMkZEXsUQ/ySQoFCqn/3x/8Ldx+HcopdL69eqzc2TTtrtqB2WSUOUdjknodgUh6rHMCS18nyV2KLr6kEp05pLR1UZiN8q6Bn0E4Ask53YM9wez3MLmez7eIWQGmMFElAiW5SA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bb4758-e03a-464c-b5b8-08df056c7049
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 01:25:41.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40golSeApkHIetIo+6OdRfKt3sWEH1y8vMwOhhM2MX5LmKLsNiJXBXqiOtHHBaD3+fXtxmgXRqGzxrAMAmrlU802UtvVYxWgEWmkBJINnm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com

On Fri, Aug 28, 2026 at 05:06:55PM +0800, Guixin Liu wrote:
> 
> 
> 在 2026/8/13 05:42, Alison Schofield 写道:
> > On Wed, Aug 12, 2026 at 02:10:43PM +0800, Guixin Liu wrote:
> > 
> > About the subject line:
> > 
> > Do we unregister the bridge or do we unregister the pmem
> > region when the bridge is unboound?
> > 
> Unregister the pmem region, sorry for the confusing description.
> > > devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
> > > and only afterwards, under the nvdimm bridge's device lock, arranges for
> > > its removal - and only if the bridge has a driver bound. If it does not,
> > > the function sets -ENXIO and leaves through err_bridge, which drops the
> > > reference this function took on the bridge and returns. The device that
> > > was just added has no owner at that point: no device_del(), no
> > > put_device(), and no devm action to do either later. The sibling failure,
> > > a devm_add_action_or_reset() that cannot allocate, is already covered,
> > > because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
> > > that path.
> > > 
> > > An unbound bridge is a normal state, not an error state. The bridge is
> > > unbound whenever cxl_pmem is unloaded or its device is detached through
> > > sysfs, and a region can be probed in that window.
> > > 
> > > The added device then stays in sysfs, along with the reference it holds on
> > > the region, until the module is unloaded. cxlr->cxlr_pmem still points at
> > > it, and worse, the name is still taken: a later probe of the same region
> > > allocates a second cxl_pmem_region and fails in device_add() on the
> > > duplicate "pmem_region%d", so once this has happened the region can no
> > > longer be brought up at all.
> > Is above an observed behavior?  ie can you reproduce this, apply
> > the fix, see it go away?  That would be far more valuable than this
> > excessive narration as proof of repair.
> > 
> > More below...
> I'm so sorry, I thought that we should add cleanup in
> failure branch, but now I realize that this branch is never actually
> reached.
> 

I think the patch may still apply as-is, so before dropping it, please take a
look at this from the teardown side rather than the "cxl_pmem is not loaded" side.

cxl_acpi removal unbinds and deletes the bridge before the regions it serves. So,
a region probe that already found the bridge can reach that check after the bridge
is gone, set -ENXIO, and return leaving the just-added device with no owner.

If that is true (I'm not sure it is) then the fix stands and the changelog needs to
tell that story.


-- Alison


> Please ignore this patch, sorry again.
> 
> Best Regards,
> Guixin Liu
> 
