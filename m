Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983881D432D;
	Wed,  7 May 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600223; cv=fail; b=MBhy+TTfu2YMCMuiACTWlGpywc4wp916VZOlyJQcqJ1wcRDpjqcJqXFxepCddNDqEjHljR0W0TDYLz8/7lOzYfU22vZyUrWrL76XLHDyBIMF9yyGNYuM3wmaw+knVHplHmXOk5U1Dx2oe5/AL9PrTDbWxR2FeC8tZgGz5zc2VdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600223; c=relaxed/simple;
	bh=UgP2ceyjbC+8znEbf4jVDgFDLkmZLt7MLjLUJwAcXu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPFZBz9yAmXQSEczfD4JQ5TTS+oVM1eTo8WrA3EpPZr2lz9CRyQ//xMEkQthM8nAE1vxqoQgexzJVvjn70DlsrSop2AJ6VYVxY0FGC8G6Vw1aQSMasrna4xAXQyKACn+XC40vrOwHo8donaeQgSd9dNoDeXBMQ7w93EtYCLErY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sDHshGSq; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sDHshGSq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1746600221; x=1778136221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UgP2ceyjbC+8znEbf4jVDgFDLkmZLt7MLjLUJwAcXu4=;
  b=sDHshGSqkH3t4Ldal52MN84GjGRNlitwAM0If2U2Zllr94dvqx7Mu1um
   QkQeSRAdHl0TwEhvZyxjddfKoDLQFjp/ibEcgu3b19Qa1dbUtKOgPC83D
   SXk1MOgk8kF3Ht8RpeSzdg5ZmUt4nK0IGXETjA2uwXJAAwII+aA2CfLvN
   aJ2k/JcgmS+SoJTO0Xd35trmZU4s2L0uhu5b6Y/XHHGBiRWBhd225C89p
   gWtGxfgLIY1q8s+SxpQUiQdExh8AKnupc3Hygfgqxk3H6BxPv9w33aPYK
   IlXKzoPE6Snp0K7phGXfVMO5CyeOdy+o2VVy75P1eOrlj1Eyjln5I/P21
   w==;
X-CSE-ConnectionGUID: JNfd7PeeT2WKsmwFg2p6/A==
X-CSE-MsgGUID: OoaLzkeRQHKOmD87OvVpiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="155192944"
X-IronPort-AV: E=Sophos;i="6.15,268,1739804400"; 
   d="scan'208";a="155192944"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 15:42:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAdtEUsgv9o80hpmzs2TH/YZFgJPZ/EJMVRHq0UjdcCpdvUV6PjG0C1P2rN6CXtHwofzddmoNsWTXt1+hjDDiCn+PM2M09vSvP1KlwrZF6jGYrOeR20ugW7AY5xBE3UGu4W0ueYpjsIe0o/DbPR8pcbg2pod+8ob8znou3jEyHuRuvWg+GSom/yW7qT60jO1I8u3+HASQOpv0q6JC8ngTaoiWIITC8b9rLfYgYkEXETftj9TNWs2d4czhSA6FAcZzR4Fk/VvOYan+W47uf/+lUpteZH31VVZ7+9R/7pivCUcPSdV+qvwu3m9ZIZnYY3VIgGA4E7X1lCB/HjTwYIcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgP2ceyjbC+8znEbf4jVDgFDLkmZLt7MLjLUJwAcXu4=;
 b=Mg+uSL2PNUq3yB4yZ6WCLdF0U1J3G56XkljhTusq3MjT7CNv9QEnhoZQZHFzYC9IbgAAsU7he1pzBuiHKQb+fELW4Ytukk7Zm3aMoZCUW6XbvGQNaQnqxF4k9PXyON8trkn1CqjVAfPam9xjZy+YUKGyRpro6YaiX2LNbB4P+dlwdFg/6X40LiVI6ZpnmUUhWa0QTC0Bp2GPqVRVmtukyWLbCx0E8KVIYMCDyCCeuS0WqVfO2i2DG2E0DcU0vdwtieXeoqtnilhtuv6uXeTUSHUn3eZL4xS3yWAZucPewZYcpRmSzAIRvXkX9ke2QXVxiTgalKpZhdwM/Hxw0EhgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB10046.jpnprd01.prod.outlook.com (2603:1096:400:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 06:42:23 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:42:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Thread-Topic: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Thread-Index: AQHbuW9Ns3M469brM0+dFIuU2M4hPLO7eSQAgAASz4CAAFjSgIAK3rqA
Date: Wed, 7 May 2025 06:42:22 +0000
Message-ID: <8f7019ed-a7a2-4cc8-9a8b-e7f96cf5c8d7@fujitsu.com>
References: <20250430012915.295136-1-lizhijian@fujitsu.com>
 <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
 <082de146-d5ed-4b49-ba0f-d6f018436e5b@fujitsu.com>
 <200f8614-34ba-42b4-aa8c-560d3052e496@amd.com>
In-Reply-To: <200f8614-34ba-42b4-aa8c-560d3052e496@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB10046:EE_
x-ms-office365-filtering-correlation-id: 9931a517-ad91-46a8-e420-08dd8d32528b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUN6TDdEU1JnYWpkSjJDQXFoV1pLM3JzTmlnbDUxVlJyNWZrVWxtcm5OQUh2?=
 =?utf-8?B?Mkw0cFFUZFBzNXVLUHBrV2dRakxEMUp2NW5PTzBmM0QyS2tFQXBRYmVqb0Mx?=
 =?utf-8?B?cFBMNk00N2RpK3BoUGgwWEd4MW1wejBvbHQ5dE5kekE0RjZwOThCbDE3V0FS?=
 =?utf-8?B?WnNCMENSQ0s1RzdrQmVHa0xmYXZsOGhUTUVwQWtxYzlQeEMxNnFKZVd2OUU5?=
 =?utf-8?B?ZmNhYThqcEdPZ0ZFSlUrdlo4c3VVajlNcmpOOG5YN1dHRHp0V0dIY3FPWnBl?=
 =?utf-8?B?aWJlV0w2NThUNkdCSjZzcXlsYkZSbkhDNVVQU01KWVVNTEE1eSswZ1JuNjBi?=
 =?utf-8?B?NWVuNVJ2YTdjYmM5TjdIbjI5ajdoT0lOTnFIdGFCRUlMT3I1RSsyOXVqalov?=
 =?utf-8?B?bjIwZ0lyWVRyZ0kxNk9vUFZsOHA2L3NSZUlYTWJreGJsWW1rOUQ1RkFpcjl6?=
 =?utf-8?B?RlIrazFUYWl5bHVPeWpCdkdidVBydkxDM0wrZFVtTUo4RFBHbUo5aWFmVGg4?=
 =?utf-8?B?alBqdW9mMStPb3RxNXJ0enNtbDI0L1RKeG9wU09RMEE4dmNPeG4xTmpGMDVt?=
 =?utf-8?B?Vll4emtRdVdCc0lmU3QvZTRmQmxBZmVuQlFOd08rSHZLVWZRNG5ZdzI2MEJ2?=
 =?utf-8?B?U0tOWVpZZCtpUG50cmR2bkU2RE91U21vY0phVFg1VmxHVFVoWEo4NVJvQThM?=
 =?utf-8?B?bHNmOWE0eEZVa2FyR0NET014YmYySEVQbWxHSmVmTHFyVXpsUEtqcjJrWnNu?=
 =?utf-8?B?MWNIZVZLUGdGOVBpT1RTWVZVbEtlcjJoNldYUFlLdlN2THd3Qy94eUlyK1pP?=
 =?utf-8?B?UUF2VDlra0pTd1ljWWd2RXc4dXJ2ZWRPeU9yRzdNQmdjZzVmcy8xNkZTa0ph?=
 =?utf-8?B?RHAzQ0ZEYUxaRmlBZ2dZaVlUc2VDUWFnY1JtSnZoNi9hQVVxK0pWTVE4L2RR?=
 =?utf-8?B?MHRZQTNzdFpTK0puTlJNbVhwaDQzSDRvN1lyclh6YjVWRG1LL1FKOG1nK0c0?=
 =?utf-8?B?bDFQVGEzdjBrZlE0c1lYdU85cm5HMVNXMGNOWDVqcjQvbTRweWNZMzdZOFRE?=
 =?utf-8?B?UjlNSWJoaExMRnU5RmZkN1JaaENXMmNyemgzYUhtbzhJaUhyQ1J0OGcxTGJn?=
 =?utf-8?B?WFI5aUpvN01ORDI0by9tejUxZ2xpMWFUbm5iZHREWjBZWVY1aGZ5bmtXTzNR?=
 =?utf-8?B?MjdQdUt5b2MrRnErMU9CUFhkaHhjWlJBc1RidkJKQzFRd2hpR09ZdEdGSnZt?=
 =?utf-8?B?ZmE3RkMzNXFJQnZoM2VmT2luYzV0TFNIY1NZY2hPYXNySVdVdXBwUHkxd0lC?=
 =?utf-8?B?ZUFhUnFQc1E5WmcydjJXclRIdk5pamRla2NjTSt5WjZmcE1aWTk1MCtSRU9l?=
 =?utf-8?B?MkUxVUlmUG93dU9IbjloYXVXUjVQWUEyOHBUSmY1REJybklRTUFpTC9IUk9O?=
 =?utf-8?B?Sm8rdUhhSksrVWw3eThiRzgxdlpVTkNSWm9FT2JFQnRJUkNTbkxabGZ3bms1?=
 =?utf-8?B?R2JwTmVlSUxXcDQ4cmRhSDdCWHZBZGRZa243SmxPYXNXbnA2Mno4djdaelNw?=
 =?utf-8?B?WlFDVktpMmc5aldmQTNaK1NsbW5vWDUzc2t1eTV4UFlRRVVLZW00bVNZTk5O?=
 =?utf-8?B?K2NQTFIrSGJrcVN4QXl0TmtwT0pKSDcxVzk2akRlSmFHVnU5UGZudUdHU1dM?=
 =?utf-8?B?Wjc4QXpraDRwdmpORlVhNHVYTit2ejNNcm5JamkwakwrbVNUQXFaV0ovS0NZ?=
 =?utf-8?B?S1BXZVJ5L21Ld3NmbG1pNkJkM0QwTGhVTmw1OWR4S1dnZkFkejV6di9WY2lU?=
 =?utf-8?B?UllPSjErOXNJaVlrZE9oa2JqZU1KR1hMNmJnYTNYcG9NYXFQMVBzazRMd3la?=
 =?utf-8?B?Q0VrU0hmRUJJVW90Zmk0UHhBTUtGUENTdUt0OWJZdG51aVV6N25wejNDQUpM?=
 =?utf-8?B?RFExOGVzZlZnY1prY0lDMG5mcjY3Mm10eFBzM0M3Z3VuTHJ4SmJmSmhXRzlY?=
 =?utf-8?B?Uktqbm1aMEZBb2swaFNBcjR2ZHhyWVQ0MExYYzNGZlhBcnJPWDBNVjJwZWYx?=
 =?utf-8?Q?E2qzek?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzlHUDljcTQrY1kwSmk4NmtaOHVXUzJkM1BhZ3M0NCtCbVF5UXVPWjlGc3Uw?=
 =?utf-8?B?Z1l1dTNmdWlwZ3VReEpLSHhHZUo5aEJSeEFrVWpRZHB1UnBjV3R1ZEg5c1Nm?=
 =?utf-8?B?MVcrZ0hwd3gwU2dETlBZV3NuSmNHTXhmUktac0NnNTdWUHVDNmpLQ0pGenVV?=
 =?utf-8?B?aXpUREpERkgxaVczYVNyVktFYjJmVFdRenBVVFFUU3VGTWMyeVVDYkFkbEtp?=
 =?utf-8?B?cUR4bXUxWE1kdWdWeFJIVm51Mkl3OUdZNFZtR0o4SnRlN1dXWDdjMVF5cFlM?=
 =?utf-8?B?Qk9uNm5sSzJNT01qREtudmlCRHZRYk14Q3h5bzZnMFk0b1B3akN4UHg0TzFa?=
 =?utf-8?B?QzJrd3hiNTF5cGpZZitrb3dxRm10RlZvdVNjK01iNFphS2lKUWRjZXNqMlhC?=
 =?utf-8?B?ODlUWk56Szh4REV4SWFGS3ZmN3pzTXlSWTJyVWtNbDNEempaaml2bWJOdFU2?=
 =?utf-8?B?U0praCtncy80emg1b3pHTEQzVmFsQjlySVpES1lVK3QzQnBJZDFOdklZbWJw?=
 =?utf-8?B?K2xUUDNQTWtObGJSSmR1enZqMk9yNDI3Q3hETVIwU2VRL1E5em9oT1JMaHlK?=
 =?utf-8?B?TVJ6WnJnZ2Y0WlVweGVrcEVDMlV3MGFGUk5zZHB5NStuRmkvOWRQWnZwb2xt?=
 =?utf-8?B?NHlZY1k4Rk1iS3NETkJmQVRqblphdU1RcHg1SlNSWC9Xakl5TzBUbnl1QnBQ?=
 =?utf-8?B?Mm9XazNBTXl4RTJBMjc5RWxYVXQ1RG5SZ0FJRWdxQUgycmR0MkNEckFtV1Iv?=
 =?utf-8?B?by96R1dvUkIrblBBVUdhd0FndXl0aVRLejBkbzBFMmZneHVpeXltSitmY3E4?=
 =?utf-8?B?ODJBeE4wTjVnWWlKMXdhU0VJZUJBdjNnb25VVXFFZ3RDRUxDSXhEVEcxOGpX?=
 =?utf-8?B?RDNBY2J1TzkxYktXZi9zZmlsVFVyY0ZDeHFMQVlHRkpMOCtJUW9MaGo2WHQz?=
 =?utf-8?B?UFpOaUJHa2RRN2Y4RzlSakNpdVBoMFVCSm80VzBiVFZnVFhhK1lidytiajli?=
 =?utf-8?B?ZnNjZmV3clRMeTFqeHMwS3kvaGpGUU5vblVGQUVRRVZQZ3pMdUUzM3NzcDV2?=
 =?utf-8?B?ZS9vZXdNZ1FtaHZvT3dSbUxBTWQ5TDgrWGNjYzMyS0kwMU5PWEVnWWNUSTQz?=
 =?utf-8?B?SmMwL2dvdnkrTi9BS3lqSmVCcHBheHI0Y2xiclAzOVc0WTNmUFBoenVGd1pw?=
 =?utf-8?B?OXQ0cnFYd3BNeFU4TU9yZEl3ak5FeFc1M2JEY0VrTGVmU3FvQjVKVlZ1L2ZV?=
 =?utf-8?B?UWdaNitseGJaalBjSzRHREpjUkNzYitUNEEzY1NrZGRVM1hCMjdVWkp1cmND?=
 =?utf-8?B?MDhTQmFRTURZVzNQdDhCL3VOL3lUUFNkR3BpcmxYS1F6UjdnTnJEMG1LdUhT?=
 =?utf-8?B?eFN6cVBZR3RsWmM4dUU0U3JJNjVKVTVDYnBJS1BmWDhtQXQyU1l4ZFJiVEZW?=
 =?utf-8?B?eitpcDJ4andjSXlXSUhiOFlSbkV3eVlCNSt6cUEvMmV2b3dnakFkME1YY1BB?=
 =?utf-8?B?MWphTUJLVjVFMUhwRExjbWFsWWFyWUxISFgyQ0craVlOaHlIaXcvZjUzcHZE?=
 =?utf-8?B?NitFRk1ZSS8rQlRYTjFpUjZYZnE2OVVRa3phQzZScXdEL244RHNjRmZmUkdp?=
 =?utf-8?B?M1N2Misrei9jVjV1cXhZWHBvTDU1eTd5d2tlVlZtNkhiSnhDWVp5NUxkb0xE?=
 =?utf-8?B?QTdlRHNvWGNuVVRkYkRUNjJKYWUrQ2pwWGEyTnB4OWN3N1ZvK3B1Zi9pRTc0?=
 =?utf-8?B?SkFwM0l2dmJOeTFCV1N2alFVdG9OMytBd0dYcXdPaUpvZ1FCYWpNVW4yTGVo?=
 =?utf-8?B?ZEZYeW43YjFhenZLY1pkWU11WkhhSXVycnVmTlBiVHB1Y1grSFNqeDV0TFdF?=
 =?utf-8?B?bVM1SW9FcnJxK1pweEtock51dDNFbHBWNmZhNWUwVENJM093Y2dlaEFZUCtB?=
 =?utf-8?B?cktOY3VkVC9GL0dOVUhsLytwRUNlTzg2aUtXdm1yNEZ1R0hqWUllL3hiQnE2?=
 =?utf-8?B?R3ZOdUd6SGd2czFwcG1zWWRPQzRVN0xTYUVEQmlaRm1DUUNMT1VscUpveFJp?=
 =?utf-8?B?Ly9rRW1mRVVuZmlBWlRVVlFyZFloalVLRU4wNFdhdmJOU3dVaDQ4dkwyNzNY?=
 =?utf-8?B?QjhaTm1hdGdkVHNQYld4U3FNTE1TbVhUUnZ6REw4djBmR0FwWmI0bGE3Q0Fz?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49FA58A00F4D7B4B8284B4CE24732283@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hAd1DpH2c9YBvNG1UpA6KBKWjuOalp39kBIhOu6ci2u85MSdzpCOSlS3LFHWXYEIxT/6ESZ1RMd1gJBo3eqkLStsMloXw4Id685gIsTy16Ga2GwulhCSlVwxuvHr/4kGj2oHFis9DUcGnRQ0Oqg0WOeAJaYBoVZ/tUEWOR3i9DJN7o1Cy8Am6NhHpwR+uzVrfIQ1dw8QTO9lqyb2ag8u3rNxQ0irZLTHoUAWo8+5omYphG4TJ8hPqClTHLGFlAKo/VrDI3QTZPfO9uBkz3hK9ygihK+TNgIqlcBiNShkhTq7Vi2RZu8XDpbeNlcdGRRUup3YuDlyh2wUR8G8thg1miJqQ317sQibIw7cLDB/MBHUfzZZIXCcFQS6P0WdaYdvQS7tfq0FajDb0i2c8j38hrfHiHxuSnJ22EX3cPehpyQdfZE8X9UMx8Ypfq/iJBsMXwtGArmOlGIh/TgwQsTfTljKI0fVRAXdJec+SGgN2OnHogrEssifJ43NFHQW7/ed8VnzdUxRrhFIr7ST5CpH4ZyedXUSahZcYE/l5Pf4Ikr6Xq28KA9IdLWrSXY7zYUBy+QFaX+p3shKamNMUGKPqBLbxkk2ohqhh4eC/JA1L9eX2R7JM4kHIinEUrDr4jNl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9931a517-ad91-46a8-e420-08dd8d32528b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 06:42:22.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCRTPuno3Z0kME1P86R32+MdUnfYuX++PgCXLLaL4d5KnMcg0sPHslEArYsbG7ymf07whon5J/anCPiCov3LGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10046

DQoNCk9uIDMwLzA0LzIwMjUgMTY6NDIsIEFsZWphbmRybyBMdWNlcm8gUGFsYXUgd3JvdGU6DQo+
Pg0KPj4gSGnCoEdyZWdvcnksDQo+Pg0KPj4gVGhhbmvCoHlvdcKgZm9ywqB0aGXCoGZlZWRiYWNr
LsKgQmFzZWTCoG9uwqBjdXJyZW50wqBDWEzCoGRyaXZlcsKgYmVoYXZpb3IswqB1c2VyLXNwYWNl
wqB0b29scw0KPj4gY2FuwqBpbmRlZWTCoHJlcHJvZ3JhbcKgZmlybXdhcmUtcHJvdmlzaW9uZWTC
oEhETcKgZGVjb2RlcnPCoGluwqBwcmFjdGljZS4NCj4+DQo+PiBGb3LCoGV4YW1wbGUswqBhZnRl
csKgYcKgc3VjY2Vzc2Z1bMKgYm9vdCzCoG9uZcKgbWF5wqBkZXN0cm95wqB0aGXCoGF1dG8tY29u
c3RydWN0ZWTCoHJlZ2lvbg0KPj4gdmlhwqBjeGzCoGRlc3Ryb3ktcmVnaW9uwqBhbmTCoGNyZWF0
ZcKgYcKgbmV3wqBkaWZmZXJlbnTCoHJlZ2lvbi4NCj4+IFRoaXPCoGluZGljYXRlc8KgdGhhdMKg
dGhlwqBrZXJuZWzCoGRvZXPCoG5vdMKgaW5oZXJlbnRsecKgbG9ja8KgZG93bsKgdGhlc2XCoGRl
Y29kZXJzLg0KPj4NCj4+IEFzwqBmb3LCoHRoZcKgbG9ja2luZ8KgcmF0aW9uYWxlwqB5b3XCoG1l
bnRpb25lZCzCoHBsYXRmb3JtwqB2ZW5kb3JzwqBtaWdodMKgZW5mb3JjZcKgdGhlaXLCoHBvbGlj
aWVzDQo+PiB0aHJvdWdowqBtZWNoYW5pc21zwqBsaWtlwqB0aGUgKkxvY2stT24tQ29tbWl0KsKg
aW7CoENYTMKgSERNwqBEZWNvZGVywqBuwqBDb250cm9swqBSZWdpc3Rlcg0KPj4NCj4+IFdoaWxl
wqBwbGF0Zm9ybcKgdmVuZG9yc8KgbWF5wqBoYXZlwqB2YWxpZMKgY29uc2lkZXJhdGlvbnPCoChh
c8KgeW91wqBub3RlZCkswqBmcm9twqBhwqBkcml2ZXLCoGFuZA0KPj4gZW5kLXVzZXLCoHBlcnNw
ZWN0aXZlLMKgZGVwZW5kaW5nwqBzb2xlbHnCoG9uwqBmaXJtd2FyZcKgdXBkYXRlc8KgdG/CoGZp
eMKgdHJhbnNpZW50wqBmYWlsdXJlcw0KPj4gaXPCoG5vdMKgc21vb3RowqBzb21ldGltZXPCoPCf
mYIuDQo+Pg0KPiANCj4gSGnCoFpoaWphbiwNCj4gDQo+IA0KPiAgRnJvbSBteSBjdXJyZW50IGVm
Zm9ydCB0cnlpbmcgdG8gZ2V0IGEgVHlwZTIgZGV2aWNlIHByb3Blcmx5IGluaXRpYWxpemVkIGJ5
IHRoZSBrZXJuZWwgYWZ0ZXIgdGhlIEJJT1MvcGxhdGZvcm0gZmlybXdhcmUgZG9pbmcgd2hhdGV2
ZXIgaXQgbmVlZHMgdG8gZG8sIEkgcmVhbGx5IHRoaW5rIHdlIHNob3VsZCBoYXZlIGEgd2lkZXIg
ZGlzY3Vzc2lvbiByZWdhcmRpbmcgdGhpcyBzeW5jLCBhbmQgbWF5YmUgdG8gaGF2ZSBmaXJzdCBz
b21ldGhpbmcgZnJvbSB0aGXCoGtlcm5lbMKgZXhwZWN0YXRpb27CoG9mwqB3aGF0wqB0aGXCoEJJ
T1PCoHNob3VsZMKgYW5kwqBzaG91bGTCoG5vdMKgZG8uDQo+IA0KPiANCj4gSWYgdGhpcyBtYWtl
cyBzZW5zZSwgSSBjb3VsZCB3b3JrIG9uIGEgaW5pdGlhbCBkcmFmdCBhYm91dCB0aGUgb3V0bGlu
ZSBvcsKgcG9pbnRzwqB0b8KgZGlzY3Vzc8KgYWJvdXTCoHRoaXMuDQo+IA0KDQpIaSBBbGVqYW5k
cm8sDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0aGlzIGNvbmNyZXRlIHBhaW4gcG9pbnQuIFlvdXIg
ZXhwZXJpZW5jZSBoaWdobGlnaHRzIGEgY3JpdGljYWwgZ2FwIGluDQoiZGVmaW5pbmcgY2xlYXIg
aGFuZG9mZiBwcm90b2NvbHMgYmV0d2VlbiBmaXJtd2FyZSBhbmQgdGhlIGtlcm5lbCIgZm9yIENY
TCBkZXZpY2UgaW5pdGlhbGl6YXRpb24uDQpJIGFncmVlIHRoYXQgd2UgbmVlZCBhIGNvbW11bml0
eS1kcml2ZW4gZWZmb3J0IHRvIGVzdGFibGlzaCB0aGVzZSBleHBlY3RhdGlvbnMuDQoNCg0KSeKA
mW0gaGFwcHkgdG8gc2VlIHlvdXIgZHJhZnQgb3IgdGhyZWFkIGZvciBkZWVwZXIgZGlzY3Vzc2lv
bi4NCg0KQmVzdCwNClpoaWppYW4NCg0KDQo+IA0KPiBUaGFua8KgeW91
