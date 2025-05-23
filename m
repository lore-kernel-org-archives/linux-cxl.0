Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452551D516F
	for <linux-cxl@vger.kernel.org>; Fri, 23 May 2025 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970946; cv=fail; b=Fq96T2rhYCM7TXcZotbZ3Z0mltwA/Sa8ivWoO31nZOZY+CWMDX7ZSVuWTXO4fQLWC2EQ/mVbADDWQd3j4RiqklTakHYW4DwSf6hBbvYGF5wnn7G7/sPICaRLhbcs7wzeTuGu9JRcxTEDMno2e7dZjqOxZ7iZi9KIq56px8sTsiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970946; c=relaxed/simple;
	bh=dqCh0R8WnOvcmC5igIbeUDbN9+CPlFVRP3RkNubZGFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=muOIy+rIokYRTM465Y7PJ4tvIUiFDGLgYrlSoczKmgZHfnqKTYItmSEUPlhDR+16HI90OYLHwUYuu+dKsMaCtBERfz7GOnKKt1cBCdhJbdZixtB0SirddawGpc1yVPNPHPV7qwW896ordmRfN2cgoDX2NuLPKcY+j/zHlR08ZUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3Q7Nxsr; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3Q7Nxsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747970945; x=1779506945;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dqCh0R8WnOvcmC5igIbeUDbN9+CPlFVRP3RkNubZGFo=;
  b=M3Q7NxsraRK2K0MgSGNawOjnhmOv2MqBryxDnO+d4Qqz05mQVifPNhDU
   oVefImn9A0k3jrqY3wUtdm+JZ+o24KGDP2D3Xbbkc4MFIfnmBY5jbQNnd
   q+biu+/tBB+ODVqcP9lh4LIFZFN6HRNRVb6lKRS16yI/eBmJTE/s4ry56
   Yr6zNvz5PJFmcSe4WBU1Y/1/8wPYGNO7fritIzcZ2pCuau0C4Fpnc4LYp
   aSOg766XgjYbdExXaHDF1FpNrN5Zju5gMBHtVwu+UoRKOHMcf4eXxBMeT
   HFQogIHVTmGan/eLX6VQEjd49zwR+MlVGWT1fDat/eHsYb/Qo+3m8Z6Te
   Q==;
X-CSE-ConnectionGUID: d/zQ6sg8SvSyYQX5Smev2A==
X-CSE-MsgGUID: ouf3h9JYQtaoij/zQ5QXMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61068202"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="61068202"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 20:29:04 -0700
X-CSE-ConnectionGUID: jlHq/4TzRPi0r5I13NX4Pg==
X-CSE-MsgGUID: eSpQ0QCFRc2jrlsigv5Q1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="141417772"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 20:29:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 20:29:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 20:29:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.85)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 20:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwjwpuDa3SjXoTlJaVkWVptlw9eCoBAT8y0FhH/0qKiMC/84KrwgfkFIKFQZzwYdFoW59JIzDnxzCgs2SgFi9c6aORuIXrduAOb9OqRBASswtkh37KVKfysG1widM6wr+ZryHQQYtUrlXaoSZgOv79POLZFpfCnAAL751u5eNedjrUMu1Zl4gJOLKPsAJFwyT7SO1GkYWmI70Q/WNIh0STmNGoEKH38mippfoRuAP8mey0uqGlhXb2XjyFyVlIwIsYxrHtOscCV/Zchk6g3WxxeNftMawwPsOYBxEm+Jux6E/nz8XiH870ZOJQXRfwzc3bZVtu+xiNHZ28fnGha/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVWut+nNEbRTPXh60oAaMNoW7Lad52pcribq07hVBpw=;
 b=SuBpG8o2bMad85mnqcqTMqHhRN8+lU4evTQ0I9ZvmVHsRe3p1b1k0mJh0DKPSoO6TzX0/CYC/OC+dotHAsNURadi258Lo2vhQ7AduSsBa6ps/embPPDTAVznyu0SSThFpqX5FGCWTU3trs9hHzIqplYs3LnFL1rAf1sYbitr6E/2YN/wmn0lT9T8Bm6NCAo/hWf2BlvRTHLLoMkyv5zg03KpZElk852AlxnIg4Fq9sVyWTZe0gem2xVjjFACZfGAE88WFgxe2Bt0CojR4IdDl61/giEhh2iE5MMp0RDJhtHy2vNOK8bSP7F5p09ZDgK0e7V2PspRzF5IaU/KUyVr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 03:28:41 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 03:28:41 +0000
Date: Thu, 22 May 2025 20:28:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
Message-ID: <aC_rWIc9TY5F2wGf@aschofie-mobl2.lan>
References: <aC2RKceK4HqYEQo/@vm4>
 <96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
 <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
 <71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
 <B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
 <682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
 <20250522145622.00002633@huawei.com>
 <FD4183E1-162E-4790-B865-E50F20249A74@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FD4183E1-162E-4790-B865-E50F20249A74@linux.dev>
X-ClientProxiedBy: SJ0PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::32) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: a68b9b66-a194-4a8f-5eb2-08dd99a9e9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDdPU0M4YzQxV1VTbmQrNkN1T1ZBVmpBbGwvR2RvelhTVDRKZGNQT1k1S1Mx?=
 =?utf-8?B?NDZ0V1BiYmlnVko2Y3BTY05sekVIVCtxT1U1a0prQUpRbVFJVzExd05uNmQ1?=
 =?utf-8?B?eW92REs5K1VIMDFnT05MaDV2c2tacXltT2FqUU5waWUxUUhNamRRZ1JqNTF3?=
 =?utf-8?B?RG8zeDBYTVoyaTBDcjhCazFGRlFvQ0ZWTm9JM2d2TTZ3YXpzUUVhTlFpWUdU?=
 =?utf-8?B?TWVlTHQ2UUd0T2hON0FRM21TWjExVXVZcDNWOGNvZ3JjWnlmckJUaXB2UjNK?=
 =?utf-8?B?cDYwREcwMTJ4bXhhU0ZRenZhMWNPUVh0anF4bUFRaG1zcEg5alFVczNWOFox?=
 =?utf-8?B?MDI4b3c3TTEwOGJxOUVYaFkwd0thZnlDMEFHb1k3OG9qL0tYZEFyVWJGUUhY?=
 =?utf-8?B?VEt3T3VOYkNSL2ZlN2VYQVdTd0w1bU9TOXp1Unh1U0tKTS9ZK1RpL0VQYS93?=
 =?utf-8?B?UVdYZXhod0lyUXNUQnNJakVxY2pZaHRhY1VTTGFmSzhldWxZS1JrRUh5dDlt?=
 =?utf-8?B?QjkvL2Iwd29MREdHMmpnSytFaHhYUm1VMzRlVjl3RFZSQXkrLzcwb1UxdERv?=
 =?utf-8?B?VC9ZL3VmY2dtdC9YTHhZSDk5eDJkYm1wekFzbVpKTXB0Z200LzR6NFl3aXFn?=
 =?utf-8?B?MmE2OEdtN1FzbG5rcGxXb1plMEJUMG0rN0JDYTBIZ1dsOWhKQmYwU0ZOR2E3?=
 =?utf-8?B?ejNrN0lBQTNXOGRmazJSWnJJYVJLS1VkUmVyaWpKOFFEem1vMFNIcU9TcFFP?=
 =?utf-8?B?K05xUVVyMjFRSTFjWkZMQ1ROTnd4RmYrTnBlczM4ZGEvM2ZnMGJJTy9qVzh5?=
 =?utf-8?B?a3BLeDFheTVyWXhsRXpFMjVraEJ3SXVNWnZwcG1vVGZGcUJFaFVNRmZmQjZJ?=
 =?utf-8?B?MndUUzlKcU4wb093UTNkTmRrQVpPY2Y2TWtGdnJhR0pvSUdMQ1M4YUhNZUQ4?=
 =?utf-8?B?VkhpOXppQlZiTE9MTGpKYXU2dUMyb1RVOVlVUlZEZGp5WnhVNC83b05GcFIx?=
 =?utf-8?B?S2U1RVJNU3ZHR1pVV0ZKTWNneG5yOVlVZm94MXphd3FyZTFBRGsrR25kcGhs?=
 =?utf-8?B?VktqbWUvV0tnaTlDUTdJTlc0TEtkR1JVOXVyTnpXVXNKWDQzK1hkTEFlbll5?=
 =?utf-8?B?RnIycWlmdmpOTGtvQ09WaE9qQVg3VER4bmJsazFqckFnZHE1emdqMW5jWFZz?=
 =?utf-8?B?QjJRSmlpMmNoUHZzbnVXbUZRUExJclpIQkZTY3VYNjBpWVROcW5hTktYdnhM?=
 =?utf-8?B?NUtsYUlWR2ZRVEhGZG1VNUZxVGFMZjV6QmMxOW9mVGpFYmNpeE12ZytkR01C?=
 =?utf-8?B?SG1RUHZQOTJYUnp0ZWJZeHNJZm1wN2tNYnEvczRoakM3RkQ4VkVaWFFkcS9D?=
 =?utf-8?B?NitoOFFLWUlTYjB0cFo1RmUzNUtxdUlEVUNsT1NoYzB3Z05nbDJXeHZ5ajgz?=
 =?utf-8?B?WnhiZ1hua0QySEptMGRmVm1Md2wxaUFwbUp4dDAwckxWT3RsVGVnckJDQ1VO?=
 =?utf-8?B?U2sxL1FHcnUwMTlmbTBzcVZaVlVXNW51K1dsV09vVGZXSGNaaEpJQUdsL292?=
 =?utf-8?B?VWFYZDZRMVhQRjY4S2haeGprbmpWcXBpS1pTL0ZlUDAxQ1lacVhJdTdGZGpr?=
 =?utf-8?B?OTd1NThHRHJvRU5GSkF2MHRWUHNWbVRYbURWa2ZXU3ZtdWtDU1dBMUdPT2Jk?=
 =?utf-8?B?amIrcldDL3RCWHNpV0NYSTFzSTF5ZWtwZ0d3Q1dMck9FcCsyeTJzT2NGeDdU?=
 =?utf-8?B?b3NTNmo1SWdJb29BM0NFSStvUStjOXhtODVIdGg5TUhCK1JINzV5NE10WS90?=
 =?utf-8?B?QnVGUmxYd3dxVVRCUW9mNVVZNVdXb0srOG1sVFZsVk1yVkhtczF0d29lUm5M?=
 =?utf-8?B?UzlydDF2ZTJXakwxaFhZQWxjMmcycFIwZFZ0VVZhV1UwNSswWVZMNVZLMnMw?=
 =?utf-8?Q?R7m+Fipjr5I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlncyszZXZNcjhGSmQxbEVZMHQ4YnJWVXJ2WFZyZllkZW5MM1k2bGxCcUpB?=
 =?utf-8?B?R0hVV0RzS0pYZEQ4QVFJK0xQMUVDQ1FuYi95NEUwMGJteXVCK29vc3k2UExj?=
 =?utf-8?B?dHRaQWEySUE2dEllMXloZWpweVZadWxrTEtMVE9xeVFZKytvam54QWdwdENk?=
 =?utf-8?B?MDJxczBUbnJHN0Vta3FyNms4ak9ReFRnUm1zcitJdUdBemlCRDRJSnFUbGUw?=
 =?utf-8?B?OFNQRk5tK2RRaUUzSzJ1UTFGaVZGSFE0Qy9aYVBja0puWGZFR0M3K3Y1SDZ6?=
 =?utf-8?B?bFRRTHgvSWdlenljNHlCM1R0a2VBQ3hiOXN2ODhwanVHeEtCK2FzcnZFTklJ?=
 =?utf-8?B?WHl5VDI4ZzNnZGRBcWJvZWplODV0RCtaMFhjaExnT3RTVU1PdFZiUkxsaWFt?=
 =?utf-8?B?YUh4WWJFK0VZWkRpVEhjZWZ6WWZOSGdCc2hnUC9GRmJwV1k1bllTWnJYVnBn?=
 =?utf-8?B?U3N5WTYyOWZROGlOdGhYL3lmVldlSEpRTXJRc1JiY0VjWVBVeXVONE9SdHFT?=
 =?utf-8?B?Ny9QdThONU1KMkpkdTZYQ1o0NXN4YlVDQktiRW5qdi91c2JueWFaZjlsUFNY?=
 =?utf-8?B?dHpmeHZhRSsxcDROT0E0VXI3ZTg3dTdYMk9tRWovcW1KWkdsekNBV2w1Qi8x?=
 =?utf-8?B?R1poU3ZpNm5zQ1NlNjJCdE1OTDkzVTM0SzdsNDFvQWRxQjBhbDdZU2V0RE40?=
 =?utf-8?B?R2NWZXRIb242NzRxWmxLeGNhNS9nNm5Fa3pEeGN5dG5LSC9zMyt1RUVhcjRy?=
 =?utf-8?B?MFdUcEI0NVVQZ1E4SUowZkwrWWZwSWtRS0RORjBrVm1qRUY2UU1LMnZJbS94?=
 =?utf-8?B?UjR4NEJYbjRUdjRUNVo1K2tXTGZRSVVWaVNGbFVpVEtDWXY5SEJDTHlSdXJB?=
 =?utf-8?B?OVJtK1hmODlxbytNOW9JV2J1L25BWmxtZUlyWTdzNGlwVXBrZDZKcUE1ZUR4?=
 =?utf-8?B?OE1MSWR4TS9YdUJ4Sm1ldW1KdUkvNTdGTnlhcGdHS0JqVHdqZStPN2tnczhx?=
 =?utf-8?B?OUtnWTZsTHpQTU9aY0srUTQ3b29KRVFOejRwSzZpeGZlUzgxNkc0VW5EVW5w?=
 =?utf-8?B?dHZ6UG12eHA3Q3EyZXMvamhwYTduVHFISnJ0QmRTZ2RJQ0RGVUMwcm81Wk03?=
 =?utf-8?B?T0VRSktjSWFaMnpIdXZiQ2JIbWx5dHc2UEtQM1E3TDM3ajhnTzROK2l5UXJk?=
 =?utf-8?B?YlRNaitSb2ZEY01mc0NDR21xeE5FaVZ5cmkwdG5hL3d2VWdTaG9OdlhaV1Uw?=
 =?utf-8?B?K2poQzUzSC80Q21TRVBTS3o0cjFYR0MrSEJWRURpSDBwOVpqVUNLZGVMelg3?=
 =?utf-8?B?S2lYTHp5MVU5RGg5R0pPRFlrQXRDbGNqK25EVCtKazFldHZza1RJVXBmaVJB?=
 =?utf-8?B?SURMK2hSSjJlV3ltazVzU2Q2L2swYStOS3REbmhWbERtbjhja1dXTDVQbkNr?=
 =?utf-8?B?WFc5bDZSWGFJR0M2dm1lMjNBQUFZVW03YU40QVBoY0NYMS8zTlJFL2tHZlN5?=
 =?utf-8?B?U08yaXIrRmhYNkZkTldKK3pIZ0h6bnJKV1I5TUtUZFZ2MGVvK09Jb1ZHTmtM?=
 =?utf-8?B?NUY1akljTThkYVQyRENTc2lBNm9BSGVZRVdRRlFkMWlEL012N1pyUUJwRnRH?=
 =?utf-8?B?OXlhaXlNZFlSdkc1dG1Fd2JXVGRGT0RncmtvQVdnRWg5djJ4M3lndTRVSU5I?=
 =?utf-8?B?YTgwSitpL2N6WGJvZGNSSEFUS1RFY2F2RGRVdjhUOVdSVm91U3Nyck9zRlV1?=
 =?utf-8?B?NVRyWG1ONDI4STdEV3FvMDZBcVlDVjJWbGdBb2J0U3EvaUFQRkhqTGsrOHVT?=
 =?utf-8?B?MHRCRUJQZlUxbk9XL0xyTkhSY045TzYxRHI4NWV3K29yU3N4OVUrVlJMa01x?=
 =?utf-8?B?NS9lME9qeEVqWlNFOXQ4Z1B2cTRINVZZdDBUMGVzOUpLZnl1QkVoZkt2aDlZ?=
 =?utf-8?B?T1FHSTI5Tkp6VitEdDdzMk01dE5xSTFzNGlIWHoxL3JNYnFVYm1BdnYrRjRy?=
 =?utf-8?B?Rnlhek9SVmE3aXl2Vk90YXlXSlNUdldsbi92SzhFQnRrOVV4WkpkM2pGc05n?=
 =?utf-8?B?ejVkSmUxNWRqR2RJSVJ6Z0hKQnJhOUJBM0p2clFLeFFrRHQvbWY1S1ZxNDZK?=
 =?utf-8?B?TXJqTXhJR2ttZ3c3MmovajBZRU1vMDhMdEpqdFZJT0M3OVplREU1YkhyRUM3?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a68b9b66-a194-4a8f-5eb2-08dd99a9e9d5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 03:28:41.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxPFNZ4T9zsajj0Ffb9eNiuHCS/A7p9+kQA3CcjHK9GeU3i8E4nVerB13TSPtMThBnXy6RHkpXMbgB+PZnG4XllJ3W5uUvhv0oFFTZpbTJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-OriginatorOrg: intel.com

On Fri, May 23, 2025 at 06:46:53AM +0900, Itaru Kitayama wrote:
> Hi Jonathan,
> 
> > On May 22, 2025, at 22:56, Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > On Wed, 21 May 2025 16:34:16 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> >> Itaru Kitayama wrote:
> >>> Dave et al.,  
> >> [..]
> >>> Rebuilt the rootfs image and tried today’s cx/next
> >>> (6.15.0-rc4-00046-g6eed708a5693) again to boot now I don’t see the
> >>> splats, so something I was messing my dev environment sorry about
> >>> that.
> >>> 
> >>> CXL utility commands work reasonably now and I can execute meson test
> >>> —suite cxl, while most of them still fails due to the HPA allocation
> >>> error which makes me wonder as the resource requests are quite modest.   
> >> 
> >> So cxl_test_init() just "hopes" that the top of the system physical
> >> address space is free to use to emulate CXL windows. That might be an
> >> assumption that only works for x86_64, not ARM64. I would double check
> >> that this code in cxl_test_init()
> >> 
> >>        rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> >>                          SZ_64G, NUMA_NO_NODE);
> >>        if (rc)
> >>                goto err_gen_pool_add;
> >> 
> >> ...is not setting up CXL Windows that overlap with existing resources in
> >> that range.
> >> 
> > 
> > I think there are checks that block use of ranges up there.
> > 
> > Print I'm seeing is
> > Hotplug memory [0xfffffff010000000-0xfffffff030000000] exceeds maximum addressable range [0x40000000-0xf80003fffffff]
> > 
> > I think right answer is to use mhp_get_pluggable_range(true); to check
> > for limits on the range we can use.
> > 
> > On architectures that don't define arch_get_mappable_range()
> > that ends up the as (unsigned long)-1 which I think would work
> > though there may be other stuff up there.  Maybe min(iomem_resource.end + 1 - SZ_64G,
> >     mappable_range.end + 1 - SZ_64G)
> > or something like that adapted to avoid wrap around.
> > 
> > I haven't yet sanity checked this doesn't break x86 but I think it should
> > end up making no difference to the locations on x86.
> > 
> > 
> > With the below - all 11 tests in ndctl cxl test suite pass for me.
> > 
> > From b287ff2c5ee7fbe507ef8cb61df3e4e156a9773f Mon Sep 17 00:00:00 2001
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Date: Thu, 22 May 2025 14:20:42 +0100
> > Subject: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > tools/testing/cxl/test/cxl.c | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 8a5815ca870d..b4e6c7659ac4 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -1328,6 +1328,7 @@ static int cxl_mem_init(void)
> > static __init int cxl_test_init(void)
> > {
> > int rc, i;
> > + struct range mappable;
> > 
> > cxl_acpi_test();
> > cxl_core_test();
> > @@ -1342,8 +1343,11 @@ static __init int cxl_test_init(void)
> > rc = -ENOMEM;
> > goto err_gen_pool_create;
> > }
> > + mappable = mhp_get_pluggable_range(true);
> > 
> > - rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> > + rc = gen_pool_add(cxl_mock_pool,
> > +  min(iomem_resource.end + 1 - SZ_64G,
> > +      mappable.end + 1 - SZ_64G),
> >  SZ_64G, NUMA_NO_NODE);
> > if (rc)
> > goto err_gen_pool_add;
> > -- 
> > 2.43.0
> > 
> 
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>>
> 
> # meson test --suite cxl
> ninja: Entering directory `/root/ndctl/build'
> [1/82] Generating version.h with a custom command
>  1/12 ndctl:cxl / cxl-topology.sh                OK              33.96s
>  2/12 ndctl:cxl / cxl-region-sysfs.sh            OK              18.00s
>  3/12 ndctl:cxl / cxl-labels.sh                  OK              23.78s
>  4/12 ndctl:cxl / cxl-create-region.sh           OK              43.03s
>  5/12 ndctl:cxl / cxl-xor-region.sh              OK              19.30s
>  6/12 ndctl:cxl / cxl-events.sh                  FAIL             6.40s   exit status 1
> >>> LD_LIBRARY_PATH=/root/ndctl/build/daxctl/lib:/root/ndctl/build/cxl/lib:/root/ndctl/build/ndctl/lib MALLOC_PERTURB_=45 TEST_PATH=/root/ndctl/build/test UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_TEST_ITERATION=1 DAXCTL=/root/ndctl/build/daxctl/daxctl NDCTL=/root/ndctl/build/ndctl/ndctl ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 DATA_PATH=/root/ndctl/test /bin/bash /root/ndctl/test/cxl-events.sh
> 
>  7/12 ndctl:cxl / cxl-sanitize.sh                OK              14.77s
>  8/12 ndctl:cxl / cxl-destroy-region.sh          OK              13.69s
>  9/12 ndctl:cxl / cxl-qos-class.sh               OK              14.31s
> 10/12 ndctl:cxl / cxl-poison.sh                  FAIL             3.46s   exit status 1
> >>> LD_LIBRARY_PATH=/root/ndctl/build/daxctl/lib:/root/ndctl/build/cxl/lib:/root/ndctl/build/ndctl/lib MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MALLOC_PERTURB_=80 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 TEST_PATH=/root/ndctl/build/test MESON_TEST_ITERATION=1 DAXCTL=/root/ndctl/build/daxctl/daxctl NDCTL=/root/ndctl/build/ndctl/ndctl ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 DATA_PATH=/root/ndctl/test /bin/bash /root/ndctl/test/cxl-poison.sh
> 
> 11/12 ndctl:cxl / cxl-update-firmware.sh         OK              66.23s
> 12/12 ndctl:cxl / cxl-security.sh                SKIP             0.34s   exit status 77
> 
> Ok:                 9
> Expected Fail:      0
> Fail:               2
> Unexpected Pass:    0
> Skipped:            1
> Timeout:            0
> 
> My understanding is that these CXL tests are using mock CFMWs, not the actual physical memory regions at their fixed locations. So I wonder executing these set of test on a “sane" CXL emulation setup (run_qemu.sh creates) that the Intel folk is using does matter or not.

Right - these test run on the mock CFMW's that the cxl-test module
creates. As far as running on a 'sane' CXL emulation setup, like
run_qemu.sh, I may not be understanding the question, but I'll take
a shot. The qemu defined CXL devices do not matter at all for the cxl
unit test run. The unit tests only uses the mock cxl/test environment
provided by the cxl-test module. The qemu CXL devices are irrelevant.

Let me know if I missed the point of you were making.

I noticed your test output FAIL cases, probably for CONFIG_TRACING not
enabled, and posted a patch to turn those into SKIPs.

--Alison

> 
> Itaru.
