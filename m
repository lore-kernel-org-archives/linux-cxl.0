Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29535230BE8
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870477; cv=fail; b=K6CDq5KGWVwMJzkxDOQpSkl+NZVltJHuOUwQqtetkimzBkrq18kbi4ysfAq+QBx5Tl0Yqr0CDvSO+42J9h/C+cGYFLkYsqzmkWZuY6FMTgprIPzx36lELLJZNfh1PNjaNfxaM6G3mmyJhhHNb5eYslYbsVq60RdyxGl461XrCQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870477; c=relaxed/simple;
	bh=ixiCNQKQNdQzASuas0/rK74ldyhAvpEXD62UiV15s1Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jquyFiS5fGl2vy9JHt/83uZorvJQvnaF0XYwduXqBSayTBmidPy7eNSZw9kZSeT8q6CBsLQaea9qoXwKs5gGEfPNK+OuxuPJDVooW58QorLXN2eCgH0oAKv5syKo7haO0/EJsCTYwYnzU3RtM65jco37QgIW5aD2Z9WWiIBAcbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltZvt49L; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltZvt49L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870476; x=1779406476;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ixiCNQKQNdQzASuas0/rK74ldyhAvpEXD62UiV15s1Y=;
  b=ltZvt49LQiRVLhYFKOvLyA/lVA/u1da35SIUoHMUn5BHzuyfXnDhU8Vi
   jLB36VxEtafuKrwDTLoPoZKQmRlNefVeXy5b0KJZr21II/GInzsl6PxDB
   5VyPeDa7uSr+D0gqt4BdX9l2jGVSDXh20IHHtqwEbKHfBdzCec0zdQ76+
   Pt3ZycDpvwfEcFxP7az3y4PkgDwSYeqoD66JdmMnX7dfLMLBO92Mf4QXN
   w4LGv5vXF7V6VSTWSu0JIbBYDOeHF0bx+qMGX/pWS2x702x2leltIOwPo
   S8PHycz9f4qB6QzT8Y0RAwbwWhhcV3OUuSrilNgMJvQsqYPOEqW46QRsE
   w==;
X-CSE-ConnectionGUID: GJ3DnELIR5CYphhV1lKdtg==
X-CSE-MsgGUID: fC278b52RWmTg8NLx1b0uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="50013590"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="50013590"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:34:36 -0700
X-CSE-ConnectionGUID: T+eGlHU/Q0uY0CDSjrfpaA==
X-CSE-MsgGUID: eqz0UcqVTKqpiFvRZbHzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="171300292"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:34:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 16:34:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 16:34:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 16:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtVFdyEllrXI2TXm9LpqaDDzFdZWI9Alu+9uLAQuFU21AshJ0qPOc4Q0jQD8A3ZXuRVwoFkbyao+tGKFaFY0Zv78eEZ7M0pPHgMm/eHDUUL7nTiaRjFLewDfLkuh7DU3dA47IqC2CgMTl3AyxiKfHYxJlfoXQZ/JoQmY+2OJJN4YpjPvOPjx4hMXCxz2R4oYw75X1g36Icmi+GctrjY+pZhT7ZJOSK5y+TCVUhqNlxoGfPHEVr3+9YtwFJo7Sw8ktH/h0XzA+rh5aGai1v/zjbLXmDYboEPGy05U6z8Afva4sFme7aH6fBimD1w+Fl36DHGvHYjeMcrNc+Q0Y6tlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p34jCT4tu8j8k6rNBY5FIt8RBx6lw5MnPYO9K/PUTkk=;
 b=fTjiRiEHZV3Cbn7LGTou3TdYK79L/flpF9IphtiO12T0hxz3DvxDjBXzoyhJiJg6NjYN8t4U8KDmQgjiryi7GYTSvrs/DApj5K/H9KlUKMryVyDEQVgf2/5VYAAxDbJfQruXLqcc4YFtfuGQVHO0nXA68B1itgDlzqC3Fvjm0pygI9wfxLECPaABtzRCrVCH4aPOZWaQ7y9o5/3wx1EKwYt0yKYoxPq9gC2HDo7SDzHqblm51QRSQUUA1ZgYamXKuqoQ1HBr3TJD0OuRy8UYXbrZDx8LmEsU359wa5HBLAVeJ2+ga4THJzjNm8Bv19k+stWewejNqFTaHTb31Y15wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.33; Wed, 21 May
 2025 23:34:19 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%3]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 23:34:19 +0000
Date: Wed, 21 May 2025 16:34:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>, Dave Jiang
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
Message-ID: <682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
References: <aC2RKceK4HqYEQo/@vm4>
 <96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
 <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
 <71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
 <B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 425d48ca-7b09-43b8-b1c3-08dd98c001d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHROUVU3WGtKalV1T281RHZhSHhOMk1ISDlIV1dTVmw5MzR1SjJEMVRseEVv?=
 =?utf-8?B?akxKaFVucTBLY3k5aFEzR1lQUk1LOUVNLy9EaDFETWlSQnJoYUdxbW1qWjJY?=
 =?utf-8?B?cWJxZnZTNWp3Q0VjMEE5dVlka0pyZlg2anR5b1VKTXFtK0FKQ0RhbzRzODdK?=
 =?utf-8?B?TzRTVFh0V1dRNjhKM2l0N2hyTlBjbTN0S3B1d2NSTllzRzJJcFRZS0JCSHRC?=
 =?utf-8?B?bmNqY2xpeG05dVZQVU9YTWdPV01nOFlIMmYySWxDZkpScjUzNUZFTmVhS0pU?=
 =?utf-8?B?dm5sbW5YWDM5MHZOSjU0bHdNSUtPS0pqY3VKVWZzTE1mY3dlQjlGOXM2ejBU?=
 =?utf-8?B?VmZteFJMdHZJNHNlYjB5VVFFR0QwZXR2MUYxY2hadEZncDRpRFUzNElCYlZG?=
 =?utf-8?B?NzV5NEJFRk5IVjlkRFV2dXhyQ29QdXE4eHAwNDBXKzJtOU9lY2JiSTJBRWtz?=
 =?utf-8?B?UjJ4OWZ3S2pBZ3F1eXN1cnBqOWluaVBjM1dVWjc0ZTFkb0hCcWI0VE9Ec1VW?=
 =?utf-8?B?bFBlMms3THFxNHc4N1NvQW44bXpXdUlQZnkxYkxiMXBTSElkcHpYUmhrcjRO?=
 =?utf-8?B?THQ5eVhpTStrNDFSWkx1SzdLSko1RWV5ZEtwVmxhSVRqenJSSk1YYUpGS3B5?=
 =?utf-8?B?Z2RhbW42ZWdrUldiT3NHbm1pK0xZVGx4dWw0emUxN0FUWDRTamxnV1U3NU5O?=
 =?utf-8?B?MkhuRDNXK240M2tiRHdQOE8zKzhIKzZyYitQSERxK2t2dEhhdmpjQm1WSjJi?=
 =?utf-8?B?ZWdSL0RhbFhuYlNnSEZ4Y09BenhjbENwWks5RWFKSks3d2xNY2ZFVFBkQk94?=
 =?utf-8?B?Z2F4K3FlSi9BanAvL2FWT3NMZHdySW03M3ZCNFhtYzkzWlV2TEVJOUFVQmpO?=
 =?utf-8?B?NzlpZTNpK0hNY2RoemtxbDJXT2psdnNJY0ROaEZlYnRtaS9XZGVCRjVpV0xO?=
 =?utf-8?B?ZDR0REV4R0puUkkxdTFUaGJWU0Zrekl5b0sxYlFFdE1JMDF6NGtSaHdFYzEz?=
 =?utf-8?B?aXpoZkpoREVWeTZKOGhQdkRXSDB1L2dFZ2RLZzhjaFpVdzQ2QUwzWk5yelhl?=
 =?utf-8?B?dnB4RlFGbElBSkttak1zQjR1TlhXMjZHdFB3cG1jN1ZBOWJJYXVKUHdqS05i?=
 =?utf-8?B?d3Bxc3NVSU5LSGY1MTRhMXRoSVBobWNBQ3doajNkTjdYR0hjaFNTRlBFcng5?=
 =?utf-8?B?aGRtejFsVlA5L3BVTXovRjdTa24yR1pyMlZ6dnNVVjFYZFVkOHFtQWR3Zjls?=
 =?utf-8?B?Qnhpdm9iVnh6aERzYWxUWmtibjdXU3E5SkRONmZ3eTVId3pnd1E2amEwOXc4?=
 =?utf-8?B?RDMrRDA3aGlLUEcrZVB6ZkJlQk1LSFFhTTBtbWVGOTJ3TUppNk9zWGQ0QVh6?=
 =?utf-8?B?cDR4eHVVT1U1ZmszZXFSdWN1MXlvcjdkclptUnRFZVZUMzk4eTVRYTlGcDBO?=
 =?utf-8?B?QzV0MXpXa2tIb1kwbmsyU0NwTWFma2JtWk1QNW12a3VBcVlNSjJWT2ZpSlpw?=
 =?utf-8?B?dzZPUlpzd1ozUVF2VkpBc1VRYUJlQVQweXBKOWhVM2RuMmZlQVJqWXZRUTFj?=
 =?utf-8?B?cFE0eGF2N2kyTDcwa3dPUnk5L1E1bC9rT1l0bGY0Tk9oZEdlQzVlT0drV2ho?=
 =?utf-8?B?Q0s4ZmlUT2lFRHVqMzVUTEI2WG53R0lvVDlMUW9LK0NldnlrdGxLc2haM3JV?=
 =?utf-8?B?UWJibEdaNXdhdUE0SkVtN2xiS3VIMmd1R3pEbTZWM3UwY0ZZL3NrMk1hN2E1?=
 =?utf-8?B?M0Y1YXVoSXR2SUZDd0tuOFYyRmpPcDBmcGY1NlpHVCtsWDQ2MENOeTNLL1ph?=
 =?utf-8?B?Mll1M0Jxc3YyTHcrOTgzTDVwaGFNWHMvQy9CYWlvSUlwY2JxaDMraTZIYnBz?=
 =?utf-8?B?blZxSDZ1cjIwa0hIT2orcVZiMzEvVlo1MUxhQXlralkxeVFtRkZQa3AzL3Jw?=
 =?utf-8?Q?oQYiJxvPR9k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDk0RlpsM2N3VjlzZFJZeTdVRlVrUHh5V3FPNytHckVUZDhWd0hhRGg1T2hX?=
 =?utf-8?B?M3J3TjVHVkdPQWoxWmZMNnpLdnBYUVF3a2s0dnliWDZieTBEM1RHWUlqUmR0?=
 =?utf-8?B?YURqYnV5aW5hRGpyZnJGOVhFa0VlYVJ5RFlyK2trU1RGb0UzOXp5aG5pOHZ2?=
 =?utf-8?B?dXlIaVFwNXVJbVdoMnc0SFJXekgwSG1OMElPYnlIaE9mVkRHcjF4NXphbVFN?=
 =?utf-8?B?d1YxZ0FnWlY2MEQ1VVc4RkU0VjBKdGNEeXZRSTlOZ1BwVFBQcTJhRHZzU2d4?=
 =?utf-8?B?TFU4a1FZUXF3enZ6cDhQTWhLeFJQRDNqWVpIekRCRUdjMHlLVndjR3l6SllT?=
 =?utf-8?B?bUZtdWdxQnFNTENLd3hiZ09HQ01mSXhFSUpCbGNtMjZ2d01MU2ZrMnhFaU9p?=
 =?utf-8?B?aU5nMktxRmJjSU1GZzNFRUZQUE5adUluYVlKYkRoL3hRZTRJTHRmNGh5NUZE?=
 =?utf-8?B?emlGYTJRLzZtRjVxRS9UL0FnQ1I5cFdHZjJ6Si9tVnMvTVJOdUpzRVNINGx5?=
 =?utf-8?B?RlRaRzZUdmdRMGdDWU9EMVE3bUFweEJhQlZnRmkrV29wUjdtZEVNa1JTQlVi?=
 =?utf-8?B?NUNaTWR0Smkxd1hjZkV5eEdiYW9oK1RuK1NSdURWUTJlZkhQVlJwWnZBSXZy?=
 =?utf-8?B?TWhteStPS3BnczBMTzhlNndsUVJQODZwWDhqYnZiRktuRjJldFVMa2RzNGJU?=
 =?utf-8?B?Ty9GVFdhbFBONTIwREFlOFppaytCcFlzL1dPWVczd3diek1TaHNiSDdzNlJE?=
 =?utf-8?B?bWNYWVF6eUJzMkRRU0UvRGd4SzRnOW9nc0xsZExrQm4vVUhYK3grMTZqMVVC?=
 =?utf-8?B?NzA3WDB2VzVNRzJabHVLRmY0V0dCTEV6azRDY1QyV1ZzcUNZcTZSM0Y1UXdP?=
 =?utf-8?B?MnZibmpHZTR1Um4xTjlLTGhNb09RSkJnNklIbnNaVlJsdTluQjVRQVo2bFBK?=
 =?utf-8?B?TWZWNXpQOUdPRWRGZnJBaVUvSHZKWFAzYmUrc3lSMERwaE9BVExaa29OemVt?=
 =?utf-8?B?RnhpWWJlYVdRam9pSnZoMTNOYkFYTGpDQ1dLVFl3NnR6cmxwYTBRdVBJN1pI?=
 =?utf-8?B?VEw1a0FvZCtoR0hscTRHZFRYeHE0dVJYZXRjZnFCLzV6U3VsUi9qaUViTGRZ?=
 =?utf-8?B?aWMvazdrZGI3M3VZcEpCNXpkVXc4aE81clhUNXhhUkl2NWRnZFFoMm1GRm05?=
 =?utf-8?B?dmFHQURmWVJMdmowaGxLeU9iTnJCVld0djRYaWR2R0tTM3pMWTRaUkJtL3Zq?=
 =?utf-8?B?b3pXamlmOHlnTE9TbkM4WEFNM2RwMXd4cmgrc004RzJLNzhkcFQwVWVPQThp?=
 =?utf-8?B?aitaVm9xVlZqMHlIamhYRTJYQ0J4OW1TMW1RQmlZRXpwYTdwOVAyZDVQd0tT?=
 =?utf-8?B?VFJkdDV1RWVMOThFWHY4R254ZldxZERsK0JmRld4Wm5LMWt1M0IwSGpYYlhy?=
 =?utf-8?B?QWw4UGdiNUV0dER3aWZWMWhSR0IxWSt4L0p0WjUwdTNYdzk3UUhSQUZTRjJV?=
 =?utf-8?B?MTRHUVNuMnJsRHoyb2RSSW5Lb2x4S3BYakZHUE1ENVlUNWU2M2ROSXVhYWsv?=
 =?utf-8?B?bG0yNkpldzV3OFZmeTRiby91eDlYQmpQN1h5cTR3WUdHWGwzK2FsZkl1bUtX?=
 =?utf-8?B?emwvci9SOHc2QnNiVWt3cWdWdklaeVh1anR0WVNxUmYvOU1XYU9kaHg2ZGk5?=
 =?utf-8?B?RWx3UzdXK05tOFRMTFdicDA5NHRPMUpYMFF2TkljUXRZanN2UDdiK2liNFZL?=
 =?utf-8?B?Q2lNV0NWcG1pZi92Z2F3ZjduUDNVeTRITU9aYzhDTk1GZUhCdnQ1TGUzdENN?=
 =?utf-8?B?R1JvRDBxUWk0VDdQQWphc1hvQjRZVzF2MjZtaGlTM0JMU24xWldQemVlUG85?=
 =?utf-8?B?a2dqVUx3dVB0VmZiRjlRdGVPVTNZRlY4bEVSMEc0eFhObCsyZWtsVG9EMkY5?=
 =?utf-8?B?TnV5ZlYwM0hUTERMMi9adWY0akcyZk15YlMxdzZzaXhYY0FHT0ZSMlExYmRO?=
 =?utf-8?B?ckYyREl1Uy9GL0tyTzZjV1JIMW41Yzh6Zko1TTYydUZGUUZ4TWt5SWVvQVlr?=
 =?utf-8?B?NDRYQUlLQ1JPTFFXUUsvazNnT2czaFBRTmdFZ2NBUHZxbjlyNE5xTkh6TmM3?=
 =?utf-8?B?dXVKRjJiRGNQb1NrVUR1MnlCL1NSeklnc2l4cWNBRU1OallmN3Z2T3YxRDFn?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 425d48ca-7b09-43b8-b1c3-08dd98c001d9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 23:34:19.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shzzBSrMmT2CZqMjc36MZoETSChjNY7DhzeYs33fBc8xk9JpmHnsvwtACuxyMqN5LcPwjNDEVaJcgEeCeQnZ0BeteZZqfQUhWD22lqDaBEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com

Itaru Kitayama wrote:
> Dave et al.,
[..]
> Rebuilt the rootfs image and tried today’s cx/next
> (6.15.0-rc4-00046-g6eed708a5693) again to boot now I don’t see the
> splats, so something I was messing my dev environment sorry about
> that.
> 
> CXL utility commands work reasonably now and I can execute meson test
> —suite cxl, while most of them still fails due to the HPA allocation
> error which makes me wonder as the resource requests are quite modest. 

So cxl_test_init() just "hopes" that the top of the system physical
address space is free to use to emulate CXL windows. That might be an
assumption that only works for x86_64, not ARM64. I would double check
that this code in cxl_test_init()

        rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
                          SZ_64G, NUMA_NO_NODE);
        if (rc)
                goto err_gen_pool_add;

...is not setting up CXL Windows that overlap with existing resources in
that range.
