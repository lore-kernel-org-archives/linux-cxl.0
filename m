Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444D208AD
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937996; cv=fail; b=p8QIzmE2kt7W0rMYsBxVTXL+AOdON0IlgkSZiNV7yGU4NfoLeW9PziPhQFpKbp8yOrh6yd5OEF0IE6vrG6qe/ZdoWWJS/3prgvd8sIcSNaVCEfJ65PRQILuS5HXu5v51PVVgDt9luynjNXCxeonpfRktFUgSvsAf25SAqjMX5FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937996; c=relaxed/simple;
	bh=oU+pe6JNgXvJRUL9kbcFp9Hm0F4rX6YzLyT5rdIYS4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1URZKD+2pNNPpUO4+vIV3JOXEb7NjQrh+yvkIfwjTpLUtZ1LhilUs67z5DBUBX0NmTUXMZGAe7PUb3UXrhfhfc+ifhmnpXHh7dT9FAU7R28kHduqPTiH6YFBcVPnIUVbPcNbQTfCZTFojiuvJ5v4IBjxS8BkmywQXXYZONz07s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcS09fcS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcS09fcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747937995; x=1779473995;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oU+pe6JNgXvJRUL9kbcFp9Hm0F4rX6YzLyT5rdIYS4k=;
  b=kcS09fcS4YeZbNCxlvkC6CgXn7Gmgsd2oMaRO+zwcrrYlSInrCmRFFoP
   VI6zAnq6K15/vnIl8wIFhuu8QdeNzUuw0yJ74YvaxNmnemnXpGshNk1C+
   RflNKgN8yNFVjXByOD1qa0jTURgwbX4IDYdiV5cQuDBdC4R6roL270gan
   oy2WwIBJZ2A24YCovYLq3y9yWNXrtfxVdNDJciANRUp1J6G/CB/yoG62i
   R6D5fw8JFq2k51rx6CCvyz7JHQEbDL7qtrZgxRI2AArY4GNHNLoW03vXX
   xCqCDbEyrtm6dpMt2q56FiCwlNM8SZ5CjbCdboLBi+bDFgkLqF3A+d0zH
   w==;
X-CSE-ConnectionGUID: LJrk0U94Rbe6pm5VVSD9qg==
X-CSE-MsgGUID: fRJL775VQbm++84B0Az9mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60230024"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="60230024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:19:54 -0700
X-CSE-ConnectionGUID: 2Ra2m6urTCqTXGIcnrTgKA==
X-CSE-MsgGUID: kAMrfniJQ+y7X+n4wynzTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="171703670"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:19:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 11:19:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 11:19:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.46)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 11:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah1LqKAhX5WwFqWqAP4iLCGNR+7qiqLa+Y/zdaQrBxvLGQLmuoGILASNriWF7ezrrqIgLKcA5FpnT9QoBi4WSkcqoxFu7hGUHz88OQVHuweQF6CZ1TIY5darbR3iIve91A7NEktjX50y18qxEtWxZCjaryhPILOSUxsC9IFXIlGgInPwQK9fhWcLyj1Q5aB0yssJxiPEumY0JpzYv6PNyeubc7tQ38SSIEJ544aOo1lcfsepcFzbrxkocF3dhQ89WZy4G/bQtChvADiIwVGrQZyoFgEwteh2G+msH1YYOMey1+jLyrRunBmTXUFxanRBj30awMscASdKa1o2KSdRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgt0ap0N212ogKWwxUO1/QF7jx9YAtsxB4Fi6Vj+nX4=;
 b=k0rwinngph3/fyaz2A7fZA93YaFddb9wG6jRXQaHH8WzXqM3EOmbwdMtt29FgzKWNCY8fzLxkrB6qIvmkYXin6Jmgls3tZOC3c0H2hrOFtWN9LZogDaZZuocMP2eu4cVm+KtFMdQfHLpSzvLwaxbg3y7sXbtdN09M9YNHmDg/Agkh7iN+VZKUxDxDOQ1P6LEgqPWh9a07RgxdaSWmiaPqwIMEInE7YT26zKfcOIFPGt7jQdZ2e8uziKMFDYVTzWDgSxweKdR86VVaJ/EtF783Kz2H/PtzaA+X8+0t3e42V4fRbe0itHvy+YmgwaJZ+Wp6E5opQNVaEgyu6GFjTMwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 18:19:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 18:19:51 +0000
Date: Thu, 22 May 2025 11:19:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Itaru Kitayama <itaru.kitayama@linux.dev>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
Message-ID: <682f6ac3e7de3_1626e100a2@dwillia2-xfh.jf.intel.com.notmuch>
References: <aC2RKceK4HqYEQo/@vm4>
 <96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
 <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
 <71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
 <B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
 <682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
 <20250522145622.00002633@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522145622.00002633@huawei.com>
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 29185cdc-8dda-42f4-4732-08dd995d3e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDhaL3ZPZFBXSGk4eGg2MXo1UEdqMDFSL3R3SFdqM2ZtZE11UXNYRGdqT0ZV?=
 =?utf-8?B?Nk9pUWdCRkZXY015Zk5kb0EvVVoxSVFub1M2NXpFUzc3SThxdVJSb29ycURp?=
 =?utf-8?B?UW1iaDdSckVNZzRYOHlaTVdBSVJsWTU4eldkY1dHRW5nTERidUZRamhXaWkv?=
 =?utf-8?B?blN6Y3hvckFSTkNkdGNjVmtoR3l2amlheUllQkhJa1lIOGxmT21ybklkLzBW?=
 =?utf-8?B?QlV6WkxLbjNBb3lSdEhuRHJUaHFZU1NaOHZ1Nk1qclZDMlhuR3Y4cGdMbVl4?=
 =?utf-8?B?cjBOTFdkdlcyNjhkRkhGQ3k5WHFkOVBNK2ZKRnhHdXpRUkRzL25TalFNMVlz?=
 =?utf-8?B?RXgxbVRBcElLcnJnbmdnZXNmVHY3K05LVFJaNkR5ZXVhdGVnclNiNVRYaWRa?=
 =?utf-8?B?Mk5lMEZGMjJJUHFNSFRKOTFyS01WSElNMVlUMlZpd1B0clh6NHNDN0JNTUhO?=
 =?utf-8?B?bmZTYjRLeHRHMklmclk0Q1dWazVKS0lHSzhHdDhIRERJWjVqaDRxWHZRUzJo?=
 =?utf-8?B?NXRhcW9Da3loa05WMUhjMk0zVWVxTzFxSFNhT1RmNXB3andiZzNoQ2t6WThC?=
 =?utf-8?B?a0lIaEltWWJPOVNobmFSYzVsbEp5bEFwMzJmcmVIS2ozblpibkt3OXNBS2tX?=
 =?utf-8?B?TmpycERGL0ludzFyaXdzRXAvdjFOajkzcUFZUkxocldNNVNGRmNJNW5TS0RN?=
 =?utf-8?B?STBhNUJrQ1h0RjYvamU5c05qeXdESC90RmRadko5clRIYXpUM2ZqaEF4S2Fk?=
 =?utf-8?B?QURrdGVDNmdmd0R4Y2lobktHYVU4d1NEMHpkcWwzc2UvMlBlRUZyQzZHZ0pJ?=
 =?utf-8?B?VVlMWVhrZUZJc0Q2NVFIRzBMK2ZodzJzNmR4Z2lIUFZVTGh5Zjd1T3oxRFRE?=
 =?utf-8?B?ZStnYURMclpSaTVuekxBSkEzcU15aE1DWWxPeEpYQUsrV3oyam14TFpwdU1y?=
 =?utf-8?B?MXBGWElEOGZRelJqMWdPRW5aOG9zWDNHaWlHV0RIM2k3cWtPcEFKa3MwMW5r?=
 =?utf-8?B?ZDV3c1hNSEFlMVBOdEVvSzYvWmxoMGRuK3NPdytJMUF4ZHNjei95aDNoeGl6?=
 =?utf-8?B?eS9ocjEvSXNMMzJuaGRrOWRLUUtnRnlpQnN3VVYyRjNUaXVOQi9LcERCN2sy?=
 =?utf-8?B?N0xnZ1N2Z1BSV1hEclErR2Rmbm1JZjVoQU1aRE9ySFB6OFI5ZHloeHpQbmpT?=
 =?utf-8?B?OFE2VFZxYmpxM1o1OE1McjhFRENYV2pWRkdMR3dLNXBiZVJ4ZzRCVlE0elY1?=
 =?utf-8?B?emN1eDBWV0dlVVpXajM3UVZCTEJBSGxndzZjdmhrNk5HN1BoOEdUQUNyakg0?=
 =?utf-8?B?OGNONnJkZFNOanhSMjBjcUh2RUU4K1g0YUcyZXEwa3ExVEhremhlMjArUkZJ?=
 =?utf-8?B?aWpUL2lqamcydnRHMmE3V25yUkU2KzNtNFBFZng1YmxMV2R2bzJLM0JQSXhC?=
 =?utf-8?B?NlM2S3dPdVlvVjdJVk1QeDJWS1hCS210UkxVZVVNbkxUK0NUTDEvUWFLUENL?=
 =?utf-8?B?WmUxREF2bGhOZm9UMVRDNWZtSW1NWGcxZURoU202UDVmczMyOEkvNlZHRVRS?=
 =?utf-8?B?UTFJanUvbDRZaVF0QTM3L2hhZnU1TWdweUJncmZid3hzLzZvWG5SdTVjdzM5?=
 =?utf-8?B?OUlPUGVqYVRxcjZNQ2hIN0w5c29mN2pURDdSYlFQcS8vUU1kb2xMUHpaWmNG?=
 =?utf-8?B?VGpSMzJvamFhbHR5Qm4xcW9WUkp6SjQ1MWZBaFBINVo5RENsY3dxUklYdHF1?=
 =?utf-8?B?QlljK1dWNmtsN1hCS3lYa3I5d1luRUI2L2p2cGVjNXVYN3RDM3ZrOVlVeFBr?=
 =?utf-8?B?T2dHUlhsdi9MeTZqWkI5bVNsMjdXRWhrTEk4cWVoWlBmOHlZcXg1TlpZM2Zz?=
 =?utf-8?B?Q2o2cEhVNkZXOExOL0JSUGxXck1RVTRnczRPVzU4UTZFU3VSV05RTUNsTlNZ?=
 =?utf-8?Q?IZ+NuqrMVa8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVPK3dQdjZuc0tqMUJHcDhXY1BuQXhFQ2ZXTndSMjl3eXFQMk5VS0VDcDRF?=
 =?utf-8?B?WEsyTDEwK2Ixa3BLL1JCYkZDWTdMYnZCQmYxYlFlaVhTK2RZb2xxSm5sa0pr?=
 =?utf-8?B?OUt6MFBHWWRWMlpyNmE2TmdyKzVUbUw5cTFEdHVmL1BLelk4aE9HOEsxY1Mx?=
 =?utf-8?B?MnVSYUEvamxvVldLRWcxNHZaS2hOWXY3OFJxM3k2NEVGNTJ6USs3UGxIeDl2?=
 =?utf-8?B?Kzc5andTVjdqZDR0MmptcnpjM204dU1UYU5iVGZCUmVkT01XU09yK3lGOEdI?=
 =?utf-8?B?UUd4QTNqNk9PdzlCWWpaL2FLZUZoSFFNS2Rua3dMTk1hM0dEMkZuWEI0aGpV?=
 =?utf-8?B?OFR2THJoM2JjaS9mZUZ6cFdnb0hISUw3VEFXaDFic0VJS0R2dkg4d0l2azNF?=
 =?utf-8?B?ZlhpTlFNaHc4SytHdVdDakg4SVp2WGZBbkNROTR4bnZwdVBMWll3NnVUa1d5?=
 =?utf-8?B?bTdiN1pBSjJxV3VQa3lpT3lmbEJpUDBCL2VVUXRyOWJVYVBMM3E5TmJPL1BL?=
 =?utf-8?B?OEZrRFZaTUlxNmJOc3VySUYvWW1CT3o1UlIxU2FFdEp2QnYycHZpRGhHRmRI?=
 =?utf-8?B?RENxdjQwQ2lCYSs1NDM2bzJHQ09FRTYvMG5TdmlvTXgvN3dTSkxFeGhrSnBl?=
 =?utf-8?B?RjByRUphRjBmY2hzK00wTVJyeE1CdGtVQzcwMTlqQW83OXRqVUFWUkdrVGs1?=
 =?utf-8?B?R2EwVjRKU2Vad1JGWU01Uko3VVdkWXJ6WUtGZytxQTV4d211MmkxOE9sdy9t?=
 =?utf-8?B?V21iaEVoTVpsM3dSWFpPUE9Rb0RVbU9lbkVjdnh5OVZ0ZXFDMFJ0R3BEWFJv?=
 =?utf-8?B?eDVTdXdkSmhuRGxHWklqRkdtZDdKZy9oZkJZTWtaV0s0aWxOaUpoWURheGYv?=
 =?utf-8?B?bW9ZQzhmRU5BN2RmK2NvUmMvaU93L2dvbTY5Q2c1RWhhMXR1TG1RMm5nM0Z4?=
 =?utf-8?B?WW9GYXpLYXAzbGtrQ3ZKbXdDVDRFcUxtTU5oZ1U5VmhZaS9JVjVEejM0QlpW?=
 =?utf-8?B?ZzZaTFJOK1B0T3hlVXdtd2p0ektJQnYxK0V4UEhCeUhYMjU5dnBuZlQwUkh1?=
 =?utf-8?B?OFplM29SVG9rQlVwM2hoN3BDTW4rV0lyZ2xmWG5McUl3S1J4QXlwYnpmT3Vr?=
 =?utf-8?B?bDYrNFVuNEgvMndQWXBIbUVBVmhLdXIzWWVjcW00SUxsZnlweTRqcGIxTTVv?=
 =?utf-8?B?NXNNU2JDdTNWUjB3SzlIR3RIcjlYSkMyMTArK2FEOWJuNG9RczUrRTkxd0wx?=
 =?utf-8?B?T2ZFbC9ob1JKS2hHOVJEeGlEUDVJV1NJeEhhbk4yeWZtSmdDTENPYTlZaTg4?=
 =?utf-8?B?VzlwMGRjYXJybFdCcXliN1gzdVl0M0ErUnpHSGkza3pUdkJkSmxhTVM3UFdw?=
 =?utf-8?B?NDF2ODJ1SE5YY21uQlBZeXBnZk1iOGhFai9LT0p5SSszbzkvRmlBeHVFNUt3?=
 =?utf-8?B?dkdwTGRkTEt3U1BwMHRpc2pZN1pTZjNPUVNtVmNEUU9XNnJ5aS9ONDNldGU4?=
 =?utf-8?B?RVF6aXdkSlcySDFRamFFWjc0a0VHYzdUZzFWUE9Qa2FUZWFISnBSNjcvcXZK?=
 =?utf-8?B?eG5UaGxIQlFKMGlnZmh6ZE13UHphSXY5SUEyZDAvd0s4Q3hWcUFtb1lQOUZi?=
 =?utf-8?B?OWtvRjdmNjZMMGxUTmdFKy8yeTc4citscUZLK0wxbkRYbW4rV3hMZnVUckpP?=
 =?utf-8?B?NFNCRnFPWnhMSmpnMjFrMUIzNUhLVGpmbzZtQTZMOEdZYStGM0hrNVJrdWYz?=
 =?utf-8?B?TXgzRENUTGVQOWZFOFdINjJXR1o3NCsvci9wQ2QzY1FQQS9TK0ltS29GYkl2?=
 =?utf-8?B?alRUb3NHQ0hBbkZDaUJIQ2c2Vll0c2g5b3N1a2cwYWxpeGlNSEVxNE1odkwv?=
 =?utf-8?B?NzBUby9QcGdSUDBlalNJdTU3aFpNaFdQRmR4S21NQ0JCc2R5TEtmU3Z2dkRv?=
 =?utf-8?B?ZzlMb2NJVnhDTnJKMUxqaWIxYjlZRjNJVmhMdVk3aGRSS1BVeDFTamdjMjJi?=
 =?utf-8?B?NFNTaHJOMEpLVHRSUEI5bHBTNGdTNlEraXRrNS9zUVVpbGgrQlhUdlhKbTN0?=
 =?utf-8?B?WnFJUkM3SVdzS2JuVit3S0JjcEtmU2cxMmpRckJiQWhJeXpLb1ZtdGYwV29P?=
 =?utf-8?B?Q2xjSzlxSHA1QmMwK1dLUUJ4QXMxSDllZG96dGVLQTJqTlBzNVVCT0NJYWxY?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29185cdc-8dda-42f4-4732-08dd995d3e2f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 18:19:51.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RMuGxikEDaw/pTp2eCAMYDYG5lpprKJ/doIMfY0tbUG0jA3y7YmR1RhdXLJGvrKCSzLTsL7zXP0BcMrfMfnly7FVQrfwde31YBDve/97Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 May 2025 16:34:16 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Itaru Kitayama wrote:
> > > Dave et al.,  
> > [..]
> > > Rebuilt the rootfs image and tried today’s cx/next
> > > (6.15.0-rc4-00046-g6eed708a5693) again to boot now I don’t see the
> > > splats, so something I was messing my dev environment sorry about
> > > that.
> > > 
> > > CXL utility commands work reasonably now and I can execute meson test
> > > —suite cxl, while most of them still fails due to the HPA allocation
> > > error which makes me wonder as the resource requests are quite modest.   
> > 
> > So cxl_test_init() just "hopes" that the top of the system physical
> > address space is free to use to emulate CXL windows. That might be an
> > assumption that only works for x86_64, not ARM64. I would double check
> > that this code in cxl_test_init()
> > 
> >         rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> >                           SZ_64G, NUMA_NO_NODE);
> >         if (rc)
> >                 goto err_gen_pool_add;
> > 
> > ...is not setting up CXL Windows that overlap with existing resources in
> > that range.
> > 
> 
> I think there are checks that block use of ranges up there.
> 
> Print I'm seeing is
> Hotplug memory [0xfffffff010000000-0xfffffff030000000] exceeds maximum addressable range [0x40000000-0xf80003fffffff]
> 
> I think right answer is to use mhp_get_pluggable_range(true); to check
> for limits on the range we can use.
> 
> On architectures that don't define arch_get_mappable_range()
> that ends up the as (unsigned long)-1 which I think would work
> though there may be other stuff up there.  Maybe min(iomem_resource.end + 1 - SZ_64G,
> 						     mappable_range.end + 1 - SZ_64G)
> or something like that adapted to avoid wrap around.
> 
> I haven't yet sanity checked this doesn't break x86 but I think it should
> end up making no difference to the locations on x86.
> 
> 
> With the below - all 11 tests in ndctl cxl test suite pass for me.

It was whitespace clobbered but after fixing that up and adding #include
<linux/memory_hotplug.h>, it works here, thanks!

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
