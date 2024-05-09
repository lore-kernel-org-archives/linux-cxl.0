Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CFD517;
	Thu,  9 May 2024 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224358; cv=fail; b=BL1gdloN4y1KReL0VozJdu+aqIJPW5fQhNGAbjZGNbZSa9vPNJ0Jp3JAWCHrH/90HNsH+oaIAX0pwqx13GTWW4IkS//hkN6ODSGg/MWZ2AeNySn1S9DiFTEwd7WkbS41AvuqnmlfA5QAxr2AENml/wAToFXJrMKmmsUpDyK9OMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224358; c=relaxed/simple;
	bh=UDd6GrDpo5AngF98UuSPsqTQA2sxC3u+7AfiYhUa92M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTvaOTQADQcEh+eTS/bTpWpYJoyIIVgtmEjI5iTfzzY+3oBUd+PHYcK4ALIsW/aAwoOf2Hwwsy4HTzV1ipCHBLa2Bzr/zFFkl3kGPgM1TlyEIqCXvqSxwDTyuyBsS9cbrCYRGIPku0/kdirWcJkHVYr4VhgmUfjSK5RySeZQqRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vvSglK/z; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vvSglK/z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715224354; x=1746760354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UDd6GrDpo5AngF98UuSPsqTQA2sxC3u+7AfiYhUa92M=;
  b=vvSglK/zunEAitKbeU5cI58NS10tnvX/Vg/r6WA6xYfwwuE/t5y63QvZ
   EqgQCqqFT5+Z2EbNBB7oYKA1RZ3NxrOS820Sk6B72cWjbUCJVESY/31ft
   kVjfle5O77PdqdGY72zLXnILtQ1Whiodbofdu3Yo00RIVfM6x3tkFooGY
   zPgU6WtYH4VvMLANJMHZ+Na00Ab108+U0whjtNnKl+81k7cS2kYsrT52h
   Q85d4/BnhVkx1+gZLpVQtZdF9oa85LATex2n+0pVL9U7Aepr2vFkEo6av
   FfgEdqAh6jTH+JzxQMYrsMKFvWqi1n6dw7JOvsQCj8e8J1kGV2J1Owcgp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="29947967"
X-IronPort-AV: E=Sophos;i="6.08,146,1712588400"; 
   d="scan'208";a="29947967"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 12:11:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqrBjNpukhHc84a0OwiR74lxs8BnbdA5RUpstz/rPSznlppTRwIKxN6RtN7ESQdYhxL+/Gjnrwvs/qDX+25tXCoRoIeP2tSR5TtH0juav16KQPCRDLNM9p1RWwVeF+7KOuZBq73tp0sEfgYBxxaYT7HpLHSrSQvEI2rMFey/Z5dcDM9kh1t4IDX4AA8Ih4hmggiMpoLbrbXTG4+i2cZ5IkDBnOvYBOrrExvnuzUmKmp+U9x4a9COXzH/Slrgc0OAxnhWSH5471AvedItNCg1+Uvzu8/yS9OZBvKGXu74vsmncbRtL9Ll9hXsGxD1wJuvnjU777XhqRAJLPI4ZTpaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDd6GrDpo5AngF98UuSPsqTQA2sxC3u+7AfiYhUa92M=;
 b=YhEwMnMuILXpGie77fSqD1FM3iid0Xndz1YyHQtQD9+oF2O/pqtiXoHFszn3rjbnUriza8kjT92oveFoTLBdjtyQHei5r4C6zrWFbS85pkhM7M72VjGeN53gpu864I6iMZ7t61k+lI/tcXEc2hEX8FoUzMFkTL/TQ+iVlqhLczg0q3J4eNfvh5KHX8vxiUbiBauvM/qT0XioI442CkU2ABtKk3XTJjwVTqbQS/0IykGKD5M70KJgUcgBRwCR8mwwGn5MwWP6EjaGNl2BX1zy+dOMk5VGYPEcshEAD9A+irC35J2qwPfvfvof7VxlQpndszMC6hbV8U3Xc0L8URZ0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB11813.jpnprd01.prod.outlook.com (2603:1096:400:3fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 03:11:16 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:11:16 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Thread-Topic: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Thread-Index: AQHamS4n5BtE91wtKEWLB7nzvazXtbF/cKWAgAutGwCAAN0hgIACT9wA
Date: Thu, 9 May 2024 03:11:16 +0000
Message-ID: <a2735b36-b64c-41d5-80ef-4d0cb47df055@fujitsu.com>
References: <20240428053715.327444-1-lizhijian@fujitsu.com>
 <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
 <0782e741-5478-4b62-866e-f966ab5cad91@fujitsu.com>
 <0a086052-5ed0-4b5f-b676-338662c2dbea@intel.com>
In-Reply-To: <0a086052-5ed0-4b5f-b676-338662c2dbea@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB11813:EE_
x-ms-office365-filtering-correlation-id: e779eadd-b055-446a-01e3-08dc6fd5b0c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGoxSlhkSUttM1oxNkFnMGRyeDBMK0MvTUtadEVIMTVMUHVGaVZGRG5PM0pz?=
 =?utf-8?B?azQ1d1J4N1hqM0JoMnF2MWx2NWwzRlUydlNRbHBqQ1JQZ3I4VzhPNTl3dTNN?=
 =?utf-8?B?TTljc1BjR0gvY2xNRURqdmxGb3lzempIZGg1M0NvUUt4VW93bkFMSE5YQ0Yy?=
 =?utf-8?B?aENVanhadDZDdG5VcVpHbksrYStHa0JPdHhVLzRCK1dZUDh3SlROTHdsQWtk?=
 =?utf-8?B?MEc0cjdwbys1eEpNRWJabTA5RDZNNzh1ODdObDNiTlBXUVFHcS9JNmduamFx?=
 =?utf-8?B?eStNL0k4VlRWcklWb0FSbS9Ed2lsaHBZWmtTMU1sa1N3eEJLcGluUmFyeVE1?=
 =?utf-8?B?NFRrUFh2VWdta01Pd2xnMk5pSE1ZVktNSlMxVWRnajdEZ0luY1NBQlFsSU13?=
 =?utf-8?B?MlRvbFdtZzRLSUVZc1p4TU5DdThJMGJMZkpRUWIrNXc1dm05cVpYd1pxbEpW?=
 =?utf-8?B?YS8zci91Um1iaDhUbXI4YUdHVERWN1JLcWR2WlJMUXZtd3YwSk1OYURCSlNj?=
 =?utf-8?B?UHlZMnB1OC9tS2tpNGJ6UjhjWjc4dFVOVmE4UUhON2ZkeitNUzB4MDZxWGF6?=
 =?utf-8?B?MjA0K1R1UmV4KzcvakhFY01zWUVqd0JXa0J5ZjdqRFM4anVHeVQ4Wi9BZXI4?=
 =?utf-8?B?b2V2cDRHU1RCRlVMUXVHN3hSYWVKbWdldmJUNFpJQ29zL0IwUVM4bDBnRlhs?=
 =?utf-8?B?ZjVXSlFsTEt4MkdJQ0MxTmExNEtwQTdscm1mMW9aQzRhVXpZWXcwaStmVWlo?=
 =?utf-8?B?aXNVK2U0Y1dHeEg5amF3cXhOOUdFY25GR2ZZdUZ3L1VyS0FoWXJaaTBwRjBS?=
 =?utf-8?B?NXZWOWw0RVFMNC9vNW5BbFk4ZkVjb3V5bk1OOHJiOWpOVVRJdnI0d216V2Z6?=
 =?utf-8?B?eDFLWUNaTXFmWXZ6VEU1VWtPK2FCdXdhcXV3YThGdUxSYnhqWlRDajZFRVJu?=
 =?utf-8?B?b0o4ZzFRWjdTTG1OL01oOWhqb1Fwc2F5UXVwNVVUZnJQbitRWXI0ZzNieGEy?=
 =?utf-8?B?cEFMMmhVMWNPK28ybDNIYmFVRjBseDBJQlR4eDNoRVRTU1N0aFkrRWF0ekp1?=
 =?utf-8?B?SWRGWTRBa29taGxpQ3pQV0JkMm1ZMEpUR0VoYVo4TGkzY1JzY1ArMmxqZS8z?=
 =?utf-8?B?ZWxXeUVPZzQrZjhFa3FNV0xVQmpmV2RtOXpCYURoZFdtNGN4L2xpUjlIZWh5?=
 =?utf-8?B?M0h6V1Arc0dzRXFJM0tIQitMNi9DYVV5MnVtMVEzTXBnL2dtUDE2VnFmZVox?=
 =?utf-8?B?M0FDc2RNV0djZ3Z1L1AwQ0dyVllVUW5UMU9zR24vM1hiRytzbnV4ZUtjUkYr?=
 =?utf-8?B?bjM4MENwM0FQMzd0Q1Q0TU85S3I0VEtrYWkzZDh1T3VCQXRsY0thbjNWeEkz?=
 =?utf-8?B?ckxVN25uM01MV2RZN3h2VVZxNy96Yk16WDhVU1VJWm05SU5jbkRwbzlPOWNh?=
 =?utf-8?B?ZkdnQ20rdEFvWkNxcEJ3Z2lFNHpLMjBWajNhUlRTT09WMFFhUVpPcEEzN09Y?=
 =?utf-8?B?RHg0bnlpekM0aWRQZXRBSU1mQ2k0Zk9qYWJRZWlpUDMyZmVMeWxSRkxYT1Jm?=
 =?utf-8?B?K3ZDemJtTHpJaFoyanNHVzFrOG9nVzVKQkdYaC9NWDdndTdzUDVZclp3TFFG?=
 =?utf-8?B?QW5oOEFBMHdKV2JNMHRVcytDUUpPelUyVFJsMTVUOUViOE5aamRaSVBFVW4r?=
 =?utf-8?B?ZnYzWDE2OGI1bEcyTU5OS1dsV21YZTl6aTlwZGlVYUI4N2ZXN0R3dlJUcDBm?=
 =?utf-8?B?L2ZFUGp0T0tXQUJHY3I0bnVmU21WWEU3RW5hcHBUcTFPd3BFM2grWnhMRVV3?=
 =?utf-8?Q?XDyF6oYUHNU1jFcY3SdJU9Kc2AulPHfpS7wUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnVZY1NkWFBtb2Iyd3VvQXJBMERsMXBUVmpzcXlJQ2MwaTJHUXA1cUdhNU1I?=
 =?utf-8?B?YjBVVFA5U20xVzNDRStxUWdmbkh4MGRROFBuZTFab0RiRDV1QmpxOExkSHRB?=
 =?utf-8?B?WlVxUlRjaWR4Skt1ZHlnckY3bGpzNGR3ejRBTWJ0UU4wa0QvVkU5dDlLOC9W?=
 =?utf-8?B?T3BGRDhWUmRVNFE5cTdObEZWY2ZqUmxjbHJXTDVQWEp6eDd3aHlCV3lCbC9k?=
 =?utf-8?B?N2FaTlNCYkdvNGNDR1VPSGJkK0VlMTh6SEYxcXRlaEl5WVRaaFNPeDg2ai9y?=
 =?utf-8?B?d1lEZ28rMGxETWdINDRiRnRSMDVsNGxHTjdYM1NyblgrQWwrN01reUVqai9k?=
 =?utf-8?B?TG9KZ28xUUJ5Z0hGSXRwM2dGajVsWHI0aURyQ3NlVUd0cmRjejNBT3FTVWh5?=
 =?utf-8?B?L3Zsb29PR2xPcUoyTmtXNjVMby93d0lDNWJRUlJEdjVuM0lQUE5mQmFWbVg5?=
 =?utf-8?B?OEtqamZCMC9zTHB6SnpoeHBwN3RuUENDTk40N0FPT0ZXZFhaZm1nS0VpME1O?=
 =?utf-8?B?eFVmekQvMlU3U0VZckgxNGcwZHF4bXdtYmNhck1hT0hKUC94dDhDRWVzZkJG?=
 =?utf-8?B?dGptbUZMRjg0allFUkFSSFF5VGVWdE0rRFd1TkEvTEJ2R0QvaEJxSUxKSXlP?=
 =?utf-8?B?dm9oeVM0U1Y0WmVPempVeTNxZWtpWVBvMElSdG9YTHFMNzNlTm0wMk9MeFBK?=
 =?utf-8?B?TnF4ZmM5MXNmZWJPZlZ5SmE2R1I0S2paOGdkeHFtdjFwZTNDMUpsdWNWMnRm?=
 =?utf-8?B?WnB2OEtERS84M0tQNmRleFc4Szg0b2xSKzRtYXFpQ3JoTSsxNUIraVE1cCs3?=
 =?utf-8?B?L2dzU2xlZks1bHRVRVdsWHBiN3dHci9PWG9UUFpHOExLRTZrZ0lTck9ySi80?=
 =?utf-8?B?elRxQ0hyM0g0bm9rZVBUWWNBbGxSY3NTMm8yNjZ6NVp1V2xZRVNGZ0FkMHJE?=
 =?utf-8?B?VktRRkVWeExXeXNWRVkwVnNkVGMzY2VqRER1TXJKeWNNMEphaWVDS2NvNmln?=
 =?utf-8?B?cVJocUZsWS9Yb3hDZk96QUVyQkZzdEpLSXNQL2p3amhYNTJkUlVZSTI2OEF5?=
 =?utf-8?B?OXNLMjZyQWx1STcvZ3VkOGxoQm9JZ2RYejZZY21JdVFkdHZOc2cvMmhFYzFa?=
 =?utf-8?B?V1JtY0ZVZjZuUFlFcGYzVUVXbGhrL2lhakhxQ1EyNGxEMG4wM3F6am9yZHZE?=
 =?utf-8?B?QVRtQkZmN2docEJZSDd3eFE1dG1ySVNxZ3VQdUsyU01pSll2QWhEV2J5WXd1?=
 =?utf-8?B?eUJraG1WTXdDdElpWUh4NmNUWC9OSm5uWTJ6bHlkRDVEZkZRMTBqaWtIZlBa?=
 =?utf-8?B?STQrSUg5aTRNdU5kSUJWd1VYbjVod2ZlTUdZZkxlMExGeFh6dE5Hakhlb1M1?=
 =?utf-8?B?VThNL3p6VWVDSEpKN2tNbWF5T0cwMVF3bGRwcmh1emc1SUJrNTdVamhxYXFN?=
 =?utf-8?B?dEpWaklPVXlETUFMVHZOVmxPQ05keFY1ek5IWTNGYmphdXhPV1ZjY3VlUkY0?=
 =?utf-8?B?N1FjVUt5WnBYNEtXMUl6Y2srU1lZeUwybVJqRzZBb3JoYjZUcldJYmViRCtR?=
 =?utf-8?B?bFhvRG1mK0FtZUk1S0ZpWC9xaGlrb3MyTXdFQlpvMVZ0TzB2Vis4eXRLKzZw?=
 =?utf-8?B?RlU1U05OVlVBOUgvd2k0RU05NlQrMXo2dXhSUVV5UTlQMmpZd3I3K2JFR0xC?=
 =?utf-8?B?czJnOHowTUE5UVZjMm5DTysvT0wrS2hTbkdMYWJ4d29LTlFGN1dSRkdKZk9s?=
 =?utf-8?B?bXR0L1JyK2Z3d3JRZ1RuWFRaS3g0ZzhXWHcvTEJobVNOQTliVVNLQzhHYzda?=
 =?utf-8?B?ejNmY0hTM0VHRjR5YWp6a0xKZGk5RWZXcFZLVldSanN4eGpUeTF0aWRtNFcr?=
 =?utf-8?B?TzJRWWk5MkNHdDZqRXdtT0ROWEZ6MVVQUUxRbkx2clBIK2VLelBDMEFiVktn?=
 =?utf-8?B?TTJ3T3V3Z016T3JWU1RaSlNFRi8wSEoxbUZpSXY4YlRPMG5EQVJmUW1jdW9n?=
 =?utf-8?B?OHR6T1VETjd2bEI1c3hDdm5PVzdsOHZSMkhrRkZkbWxEVlJya3J0Q1VSMmow?=
 =?utf-8?B?Y0tEWU5wOW9RcTRPcEViTHliM1JINUFudDhiZmVQUHRRODB1UXBvZ04xWkgv?=
 =?utf-8?B?bXBYMWprYzRnZnc1OEZrc1BqSlRSWlRXalRyTktFb2toZlNRM1cwVE5kbnJE?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76112DF51526714AA3514BEE380413CC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ub8P0j/XbTjmIqZ41L8FqvFhXRGVssuEzGEQvqSJShIYpc+5yM9KizvOMTQkvghZmQOHNHuSEz4j8NjqkOmWyV6r/t/jVbfRRVA1TRQP+DuGoRE/GXn9TgqUD6aovV/Sxa+LsJXkJ3sNonJCft5NI1FcSfsacZyIeAgqFMBcDjBIoNVQB4BG6U81nPWv9xupQQ5kg1Ie+hqZyLoAjV8XV+MA6GdFIaz/D/phYkbo8B1kJy4AJFYJla6VsdH9xLGQany80ihM/YwjV9dwQjCAec0YaLgk1LBg5m3hEEq1TV+M7AnLZFBRRATgX8SQE9R/fwVvFS6J7PHEZXBFp0N4FU3hiVPPLYZTMB9b4haEf234wexM/0N/loKTJOcN76alM9BQO42/KKXyt7E4qelcKPeLn81gZK5UTkJ4NnIqU4W822PnQVZJkDfbKQy56dH665eoIJDhnQtyFXsTKiQGGTJqcV9t36luhzF6ml05QKvl2SGx0CEVtqu3YOsSAyrSi4rk9vinvkzOjEVnP4QlZ12P0acpj6VT0wk45gbrSfk7N8QLIoSPbgnY8vuAptJZP3DiBq6rYHv1ipkNvER4xyVv6xLlh8sXKFSDkLphaayz5xJ3kgwv/u3To4xBclBM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e779eadd-b055-446a-01e3-08dc6fd5b0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 03:11:16.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIrWbBs98YGxhvNuq3eRmJ7dy5dnVUDIX8FvhTaOdOMEKHhMkoVFWVcEmrayj+1BVlMmpqDTxz8w+/eDXMN89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11813

DQoNCk9uIDA3LzA1LzIwMjQgMjM6NTIsIERhdmUgSmlhbmcgd3JvdGU6DQo+IA0KPiANCj4gT24g
NS82LzI0IDc6NDIgUE0sIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4NCj4+DQo+PiBP
biAzMC8wNC8yMDI0IDAwOjIzLCBJcmEgV2Vpbnkgd3JvdGU6DQo+Pj4gTGkgWmhpamlhbiB3cm90
ZToNCj4+Pj4gTW92ZSBtZW1yZWdpb25fZnJlZShpZCkgb3V0IG9mIGN4bF9yZWdpb25fYWxsb2Mo
KSBhbmQNCj4+Pj4gZXhwbGljYXRlbHkgZnJlZSBtZW1yZWdpb24gaW4gZGV2bV9jeGxfYWRkX3Jl
Z2lvbigpIGVycm9yIHBhdGguDQo+Pj4gICAgIF5eXl4NCj4+PiAgICAgZXhwbGljaXRseQ0KPj4+
DQo+Pj4gQlRXIHlvdSBzaG91bGQgcnVuIGNoZWNrcGF0Y2gucGwgd2hpY2ggd2lsbCBjaGVjayBz
cGVsbGluZy4NCj4+DQo+Pg0KPj4gSSByZW1lbWJlciBJJ3ZlIGRvbmUgdGhpcyBjaGVjaywgYnV0
IGl0IHNlZW1zIHRoZSBpdCBkb2Vzbid0IHdvcmsgZm9yIG1lLg0KPj4gRGlkIEkgbWlzcyBzb21l
dGhpbmc/DQo+Pg0KPj4gJCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAwMDAxLWN4bC1yZWdpb24t
Rml4LW1lbXJlZ2lvbi1sZWFrcy1pbi1kZXZtX2N4bF9hZGRfcmVnaW8ucGF0Y2gNCj4+IHRvdGFs
OiAwIGVycm9ycywgMCB3YXJuaW5ncywgMjMgbGluZXMgY2hlY2tlZA0KPj4NCj4+IDAwMDEtY3hs
LXJlZ2lvbi1GaXgtbWVtcmVnaW9uLWxlYWtzLWluLWRldm1fY3hsX2FkZF9yZWdpby5wYXRjaCBo
YXMgbm8gb2J2aW91cyBzdHlsZSBwcm9ibGVtcyBhbmQgaXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24u
DQo+IA0KPiBQYXNzIGluIC0tY29kZXNwZWxsIHBhcmFtZXRlci4gQW5kIG1ha2Ugc3VyZSB5b3Ug
aGF2ZSB0aGUgY29kZXNwZWxsIGRpY3Rpb25hcnkgaW5zdGFsbGVkIChpLmUuIC91c3Ivc2hhcmUv
Y29kZXNwZWxsL2RpY3Rpb25hcnkudHh0KS4NCg0KR29vZCB0byBrbm93IHRoaXMsIG1hbnkgdGhh
bmtzIQ0KDQpUaGFua3MNCg0KDQoNCj4gDQo+IERKDQo+IA0KPj4NCj4+DQo+Pg0KPj4+DQo+Pj4g
SSdtIG5vdCBmb2xsb3dpbmcgd2hhdCB0aGUgcHJvYmxlbSBpcyB5b3UgYXJlIHRyeWluZyB0byBm
aXguICBUaGlzIHNlZW1zDQo+Pj4gbGlrZSBpdCBqdXN0IG1vdmVzIHRoZSBtZW1yZWdpb25fZnJl
ZSgpIGFyb3VuZCBhIGJpdCBidXQgdGhlIGxvZ2ljIGlzIHRoZQ0KPj4+IHNhbWUuDQo+Pj4NCj4+
DQo+PiBTb3JyeSwgSSB0aGluayBteSBjb21taXQgbG9nIG1heSBiZSBtaXNsZWFkaW5nLiBJbiBm
YWN0LCB0aGlzIHBhdGNoIG1haW5seSBmaXhlcw0KPj4gdGhlIG1lbXJlZ2lvbiBsZWFrIGluIGRl
dm1fY3hsX2FkZF9yZWdpb24oKSB3aGVuIGl0IGdldHMgYW4gaW52YWxpZCBtb2RlLg0KPj4NCj4+
Pj4gICAgCWRlZmF1bHQ6DQo+Pj4+ICAgIAkJZGV2X2VycigmY3hscmQtPmN4bHNkLmN4bGQuZGV2
LCAidW5zdXBwb3J0ZWQgbW9kZSAlZFxuIiwgbW9kZSk7DQo+Pj4+ICsJCW1lbXJlZ2lvbl9mcmVl
KGlkKTsNCj4+Pj4gICAgCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+Pj4gICAgCX0NCj4+
DQo+PiBBZGRpdGlvbmFsbHksIHRvIG1haW50YWluIGNvbnNpc3RlbnQgZXJyb3IgaGFuZGxpbmcs
IEkgYWxzbyBtb3ZlZCBtZW1yZWdpb25fZnJlZShpZCkgZnJvbQ0KPj4gY3hsX3JlZ2lvbl9hbGxv
YygpIHRvIGRldm1fY3hsX2FkZF9yZWdpb24oKSBzbyB0aGF0IGRldm1fY3hsX2FkZF9yZWdpb24o
KSBjYW4NCj4+IGZyZWUgbWVtcmVnaW9uIGV4cGxpY2l0bHkgaW4gZXJyb3IgcGF0aC4NCj4+DQo+
Pg0KPj4gVGhhbmtzDQo+PiBaaGlqaWFuDQo+Pg0KPj4NCj4+PiBJcmENCj4+Pg0KPj4+Pg0KPj4+
PiBBZnRlciBjeGxfcmVnaW9uX2FsbG9jKCkgc3VjY2VlZCwgbWVtcmVnaW9uIHdpbGwgYmUgZnJl
ZWQgYnkNCj4+Pj4gY3hsX3JlZ2lvbl90eXBlLnJlbGVhc2UoKQ0KPj4+Pg0KPj4+PiBGaXhlczog
NmUwOTkyNjQxODVkICgiY3hsL3JlZ2lvbjogQWRkIHZvbGF0aWxlIHJlZ2lvbiBjcmVhdGlvbiBz
dXBwb3J0IikNCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0
c3UuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8IDkg
KysrKystLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPj4+PiBpbmRleCA4MTJiMjk0OGI2YzYu
Ljg1MzU3MThhMjBmMCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24u
Yw0KPj4+PiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+Pj4+IEBAIC0yMjUwLDEw
ICsyMjUwLDggQEAgc3RhdGljIHN0cnVjdCBjeGxfcmVnaW9uICpjeGxfcmVnaW9uX2FsbG9jKHN0
cnVjdCBjeGxfcm9vdF9kZWNvZGVyICpjeGxyZCwgaW50IGkNCj4+Pj4gICAgCXN0cnVjdCBkZXZp
Y2UgKmRldjsNCj4+Pj4gICAgDQo+Pj4+ICAgIAljeGxyID0ga3phbGxvYyhzaXplb2YoKmN4bHIp
LCBHRlBfS0VSTkVMKTsNCj4+Pj4gLQlpZiAoIWN4bHIpIHsNCj4+Pj4gLQkJbWVtcmVnaW9uX2Zy
ZWUoaWQpOw0KPj4+PiArCWlmICghY3hscikNCj4+Pj4gICAgCQlyZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsNCj4+Pj4gLQl9DQo+Pj4+ICAgIA0KPj4+PiAgICAJZGV2ID0gJmN4bHItPmRldjsNCj4+
Pj4gICAgCWRldmljZV9pbml0aWFsaXplKGRldik7DQo+Pj4+IEBAIC0yMzU4LDEyICsyMzU2LDE1
IEBAIHN0YXRpYyBzdHJ1Y3QgY3hsX3JlZ2lvbiAqZGV2bV9jeGxfYWRkX3JlZ2lvbihzdHJ1Y3Qg
Y3hsX3Jvb3RfZGVjb2RlciAqY3hscmQsDQo+Pj4+ICAgIAkJYnJlYWs7DQo+Pj4+ICAgIAlkZWZh
dWx0Og0KPj4+PiAgICAJCWRldl9lcnIoJmN4bHJkLT5jeGxzZC5jeGxkLmRldiwgInVuc3VwcG9y
dGVkIG1vZGUgJWRcbiIsIG1vZGUpOw0KPj4+PiArCQltZW1yZWdpb25fZnJlZShpZCk7DQo+Pj4+
ICAgIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+Pj4+ICAgIAl9DQo+Pj4+ICAgIA0KPj4+
PiAgICAJY3hsciA9IGN4bF9yZWdpb25fYWxsb2MoY3hscmQsIGlkKTsNCj4+Pj4gLQlpZiAoSVNf
RVJSKGN4bHIpKQ0KPj4+PiArCWlmIChJU19FUlIoY3hscikpIHsNCj4+Pj4gKwkJbWVtcmVnaW9u
X2ZyZWUoaWQpOw0KPj4+PiAgICAJCXJldHVybiBjeGxyOw0KPj4+PiArCX0NCj4+Pj4gICAgCWN4
bHItPm1vZGUgPSBtb2RlOw0KPj4+PiAgICAJY3hsci0+dHlwZSA9IHR5cGU7DQo+Pj4+ICAgIA0K
Pj4+PiAtLSANCj4+Pj4gMi4yOS4yDQo+Pj4+DQo+Pj4NCj4+Pg==
