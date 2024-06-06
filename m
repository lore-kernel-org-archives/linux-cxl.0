Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12944A31
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632321; cv=fail; b=Xza0jdYSrIHdLC/ILIzqsCjHOJ5tDqbtnSLYJomFMSMz79Mf4TxuSYR4OIPU9OH8g2xUaR0mcsO76Q3JTx5WSTtzPi8nL7tnPhkfV62YgKwIzTnQ3bDS4j02lqOxo3e7BI4rU7dk7U561Yxjq2yL4x3Fdyva1UYTpy7+G8soavg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632321; c=relaxed/simple;
	bh=hhAp6FeF2Z0NQv+GuorInx8675/9Xe2dG4adcd5MhoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTr5muYM/wUnzGK62Q9phTxFGEww6gSnxHZ9pCQYn1l1Rj4LICCqmG27fdZjd26UleW6kZxLOX0/RounkNgU+vM/UaSO2sBOGKBkr2raGqnWhY+QE0xN3xZailnjJ6xnlcsSK+d5o5fRcDJngzK/pdj1SHS9H85QzXmBSXwuvmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=o3IM+t6m; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="o3IM+t6m"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717632319; x=1749168319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hhAp6FeF2Z0NQv+GuorInx8675/9Xe2dG4adcd5MhoI=;
  b=o3IM+t6mH2jP9ACSfGdR06AVBHVZEX6+sDgMpdXy2Hj9SbJSjVXWn1nx
   5Qt6P2NTfncFirjnVXOThkROndaGMpa6cgOx7R+LKSZ+Nt9zlFTirw0ko
   IldvbBB7PBtK8ZsoUDzF3xlNot8uBRJkqEpMdI/gFu881phgikeox3VkZ
   mJY8ovPXEAPqlrU9/7dB+Jcy0UyD5fOPiSGzXuM7IHslZzCAUdOEtgmAz
   K03EmDh7Og8wb+DM/BG+ipnMdM2Whz9GFDelOpsWBTPQx3RH/X7o/LBqB
   Kwm6DDKIeN0EhN1FM/W+WeA/W6PAG/1aZPVARqfqSImEDTUvRRKmQDj0h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="121461335"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="121461335"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:04:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKhw6HC3Xq0PKv6Jyt7/i+cIIWHg5hbbot+agDGiKITNRTNtGt6N0XRAFeAk8aXum2KkY8+fBGanM4mAj19aNadNGZepDUlhMkVVcwPp3vkd2I3xovCvJAJ1mO93fFIopNzGjz/XxX0Xcb/BwqWPzUdgjDOiYEP6sBgFkEAJxNcqYNU6UWz2kCeWnuA311OeSZ01RfUI4GDDugBStRkpKw3B0F0XHqV4MmhIT8JVvecLHB80KxeYDk43FLhqdqdOGZRfRQjboo+ROxK/88Ehqw2Mdq0n9zyeeeLWsLI583UgRckVnuJwD/qaIGwpOtDflyK83y79qW1iBh1fjQgHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhAp6FeF2Z0NQv+GuorInx8675/9Xe2dG4adcd5MhoI=;
 b=fA3odNWU6ErZwXher0S1yza2d57bgai0urHFIisQik0++JkV1+nDTcIUNjodIbnPYjppF73q2aDjjYPoTQTgaDM72DH9CfTUzId/I6g+KseoWIW65S6Iqqx4POaJL3yrAO8KLcLm+qKODSSwpqawLe8UiY6ZJa2j4AgjuJc7lbUnpoxuwafrMJjnb9BZit4kH7xNNCaIxDygRGyw4I4v/oR+Ksw9dbhn9GdZzb5EafKZmVwQX6zxXSAq4C0nyx6/qOnLMdIf90qJQDM6s+0qxY4I6yqP4Tes3kAorektmO5YJSno+YkneOwxSEDT3NNQXCK0RZ+ubKq2EN7R4TkWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB8014.jpnprd01.prod.outlook.com (2603:1096:400:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 00:04:02 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 00:04:02 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "fan.ni@samsung.com"
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Get rid of unused cfmw_list
Thread-Topic: [PATCH] cxl: Get rid of unused cfmw_list
Thread-Index: AQHasyGuWK88zwQEXUmRaACQcKIEEbG5GjGAgADJnAA=
Date: Thu, 6 Jun 2024 00:04:01 +0000
Message-ID: <c69cb029-b181-465d-a8b5-c5d02d2ff462@fujitsu.com>
References: <20240531061317.865673-1-lizhijian@fujitsu.com>
 <20240605130225.00006431@Huawei.com>
In-Reply-To: <20240605130225.00006431@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB8014:EE_
x-ms-office365-filtering-correlation-id: b3093d09-46f4-444d-be82-08dc85bc2c16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWI2aDZTUlBZdUFXS0xjRHo3WVpDbE0vS0FHWGJ0STB4R0h6WW8raWtFVURQ?=
 =?utf-8?B?Mk1jVGN2S0lDNUpGRFlqSEM3KzM3Nk5sVlRvelYwVm9yK0NmMHhnSHd4cUNq?=
 =?utf-8?B?dWhWekhpdXJ5NlBINjB0dVZMelQyTDFFTjF1YkZHVk4xMnA0OGYwb3pvSkFa?=
 =?utf-8?B?VUl3eVhuU2R0a2tjakhzcUpLbXBTbnVFYjlNSFVCRENRbS8vVm41UDd4T1BH?=
 =?utf-8?B?ZURHTVJjNHVwK0RCaENGRTROMGVmRGlFTTNaVzNCbU0xYjgveEpkWldOY0dR?=
 =?utf-8?B?VnNrUzYrMmtjUCtlU1c5M1QwV2tIMEt2ZCtrSHB2bTBQRkNVRWdoTVhmRkZr?=
 =?utf-8?B?NG9pY2FjanVrRm90RFg0cDBjdUVkOCs0QU5KOWphZ1lLS3lRUmQycHRDZkRD?=
 =?utf-8?B?WFMwV2VlNmNmQ2FZKzd3UHNsSHBJdlVDaEpvbGI0ZUh6eFFkcGJ0Y01SYk5H?=
 =?utf-8?B?VDk2aGsydVZyZlJna25ZOGY3Y2pCUmhYcUs3ajhadDNMWW5qMGNNeC9wdVpM?=
 =?utf-8?B?SmhoT0VKaDdRQ3VqUk1BSHg5WHdJc1ZMT0I5OWZvZlBKbFpDWVA4Ums2czFO?=
 =?utf-8?B?NExPSGJHNW45ODg2cjE4SS9wZHo1TEptYmc2NElZMVFnMHlhM29xWkV1L1dJ?=
 =?utf-8?B?RDRVbm8vdjc0bUhBeldSVEtuZERvZU5Ocmt5eitORmdYSjVaK2Nkb3RUWDFN?=
 =?utf-8?B?YzJGS1NsRVdVTzRCRXIveUpwdExwcG1JZHN5NDRFSDB3eGNLVVBxSmluazFI?=
 =?utf-8?B?cnpsUTVpYkJmK0pvT0VhRFExTkoyWkJUdXN4YnZxRyt5dTJaVGVlci9tNzlE?=
 =?utf-8?B?MEVFMld0TVhhR21qWlJsamJCVkdwMnREbm43T3Q0dGM0dnB6K2t5cG10RmlL?=
 =?utf-8?B?WFBoRk1pSmsrdGNwSUhMcjRWOEdJNlY0ZjlMSHlrTEVBekZEd2xuYlJzMzdD?=
 =?utf-8?B?cGIvWnpRZ1JCQ29FNXV3N2hMbHc3RHNSZU9xSStKWVA1ZjhDNGppNjhjYlZO?=
 =?utf-8?B?TTJjNDJybWdsVjZiL1NVZ1Z0WFlXdVlCTlkvZnJZS3ZzVGs1bENQNDdIZTFU?=
 =?utf-8?B?NzV6WlVJMVN0azZVbjY2R3B4Ymo2TTYxVDg3M2dIcUt3bWZRQ0pmd1l2Vkd5?=
 =?utf-8?B?SHo4MXNoRVRubHZmbDBUMFZ5U1RuMnN5OXV1dm0yWU80UlJib1hFT0tFRENQ?=
 =?utf-8?B?WlNGdEhodndVQVdCdUtqbG9uWFNRMVdBNnA0Z2llS2Q1K3FpMXp6TnE3SWpB?=
 =?utf-8?B?d0NkS0xPeVBlMW1haHhsanlPUFdkVFNHRU5NOFdweFEwUHpyb2NQbTRKeUxu?=
 =?utf-8?B?MjI3Y0EvQ0c3T3Z1dTVkVWVVYnRBMFJCT3Nrc3hEcTh3RFNQZFBaRXFQV1pL?=
 =?utf-8?B?QUZ4QkJ6UlNEbzFPanJhbGFwVWhzTFZHVFp5aFlhWUlaeXlySU5qZFdwaEZN?=
 =?utf-8?B?Z1FZVlFIbnV5ZTlQTml5Zld2anpoTnR4VGJqZjdrUnl6V3F5NktDVHJLOCs0?=
 =?utf-8?B?V0o1ak1ER2pjdWROR0tINjRPZkh6OFN6WEN0b3JmTC9kM3hrbXBkUGJRditZ?=
 =?utf-8?B?ZTd3WWZ5SFVxa3UxdmovL05ucytxaXdPRnZ1bURsMGdyR3hVY0pOTUF0TW1Y?=
 =?utf-8?B?ditSNGhGeDZMWXBzU2RUZ2gxMDFIV1lYazlDUkZodlh1UHBxMFJUdVdWTVJj?=
 =?utf-8?B?Vng2cVdWSHBzZlluOWNZTWp0SmlJdllTeHZCRXhsdUxaTkxSZXBrR0JWN1Vq?=
 =?utf-8?B?ZmZabEgwYVFVdnlmdmRISUJtRmZKelFCUFUvbFk3d2pjNjRrZ3djd0hNUk03?=
 =?utf-8?Q?akVIo0UAfbG5Kg7KB30SDv9VHXlfAf7Dw0TRA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzdVVDV4azZtbXVIT2ZxWkVjSzNmNzFoSndON0k0QmdhaTQvVjFlOXlPSE4x?=
 =?utf-8?B?aU1IVUNYcHVvS3M3dXVGK1ppOEtxR2VSWTI0MXdHTVRJWldISlRvUUJQNGxU?=
 =?utf-8?B?WWZOZHJod3h5UG9IUERYVVhCLzZQTkxWMVZTOE4xVnlRcFNlV3dDTHRPWW9P?=
 =?utf-8?B?Tlo3ZldXTWNSUHJHRlcrcnZ4bXVPVTRaVHVoak1qYVZLVkV3dGVyR0RiREFS?=
 =?utf-8?B?OXZuOG4yVXhYUC9CRjYwdnh0TnVoYStHNm82dFpMODd6NXNwSTV5OFE5N3lJ?=
 =?utf-8?B?MGxZUnU2OEtwRk1lamxyYVh3WVpzUXpsNXFKcE5zenlZSmlwOWk3K1BjRXVS?=
 =?utf-8?B?R0hKMlZhajVGU1BwblpvUHFYclQ1dG03bWY0OG9OTmhBeVFOT2prMUxsMStN?=
 =?utf-8?B?UGR5Nk80OWJJaWRRZ0d2c0VzTC9FQU9nRFlheWVOQnlsbmlLL2VrY0FPeEFC?=
 =?utf-8?B?eVd2TlJ3RFY1MEFDMEYvRGFVM3Qra3V1aUdoOS9iSmIwYURaRnpneFFnaEdH?=
 =?utf-8?B?cWpweXl6KzFMTEptd0ZmSTZJNDV5R0U0Mlo0U0s1SEpWa201aXpQN1pkWHVH?=
 =?utf-8?B?OTJCN2h5UEZpNzBJQ2xWMWltaUgwY25Keko4aStTUXVsbjhaSGpRblpJRkdm?=
 =?utf-8?B?N2V6MTZGemJ3WnZLUzNkUkVYZHBLeUpaTldlN3V3akNtbmRvd1JOK2hCUklw?=
 =?utf-8?B?aTE4b1NmMm1HRElRWmFwd1IwN09rbjdmK3BaWXY4ZUFCbWI0cU1QUjNVeTM0?=
 =?utf-8?B?cUN5YmFrYVRKZWNPT3BiNVBpZjhvcEx0MTVXcllSbGV6M1pXV0M5WkJJWVJq?=
 =?utf-8?B?MERjdm03MWFMZ1VxT1lNQWIzaGVuaWdxSjVYSEQ3eUNEMXJTT3dGVXVKRGNU?=
 =?utf-8?B?aDJzN0RzVFlSMXRzbE95K1VSc2pkRHRtSk9EbWVialc5cEYvMDJlNW5sei9G?=
 =?utf-8?B?SDkwZmF1VVVzL2FtOVRVN1dXNitWRDk4K3BkT21Kb2d6T3B6UGdNeWJKM1Y2?=
 =?utf-8?B?bnRRUjdOOUY3UjhnYU5hUi95MDJEWmpxQzVabEQrTVc2N0dBOC9ZZVRZYXcx?=
 =?utf-8?B?Q3hYR3BoSmF1NzRzWCszV1k4UmlnOGNoQ2I2emJyOHA0dFNNNGNDTXpxYTZw?=
 =?utf-8?B?VzRNNlRKRnFVL2hxUUcrQ0xseFB4anlXUXJFRjE1b2J4ZENpdGd0MDN0bnFG?=
 =?utf-8?B?cGxCUk9idXUvV2tmMjRXc3NyL2ZuUXQ2Wk12R2NjZ3FWZUhEMFhvdlg0MFJv?=
 =?utf-8?B?U3EzZTBXdDZ0L2FQUUlHNit5ZHF3WC9kVDlKa1lWdXhOZXRoWUNvVkREUTY3?=
 =?utf-8?B?SG5mdlFTbkNFYklSRmZPUm5PUkl5UTN5bGpiWlIrM0ltcHlKQ1dCbldlb2I3?=
 =?utf-8?B?TmI3SG5vWDRVcFlja2RoWTh3ZlRWYi9aRHcxNVBobWhKQkZncFh5VWh5akZQ?=
 =?utf-8?B?SkhHaytCbUNPblFYU3pkMTJFZjVNOUxpSjBHQnZGekhEd0YvNGxLM0paemdq?=
 =?utf-8?B?R1ZEWXBNQTJGbCt5UUNTTTZmdmFzR0g0cksvd1NQZXI2cTBENE1uR0l1MDNE?=
 =?utf-8?B?WUQ2VU9BVGYrL2N0Y0JWL0N4akhlanhxQlQ4ZFJ2Vmc3dFY5K0tJODU3YUNL?=
 =?utf-8?B?bzIzMTBONWNXQmFHKzVLbzFjQVZMZVRWUVIxdUxjbFA4QTFWallWMjhUaTBs?=
 =?utf-8?B?SjV0ckNCMy9kRlYrNVNsbWRvZGdqekwyOFdlengvbk5Zc0hhQVVTYmtIVXFv?=
 =?utf-8?B?bVdWVDQ1ZDhDNkZ4eTgrTmJBQkRsVk0xNWU0SjJoVmdsRTg2NHlYMTNsN1Fi?=
 =?utf-8?B?c3gwcFJvekM2SHVzWDBwRGM2UWRZbFBpSFVwSGxYTWtMTlptREtTMXd1Vk9Q?=
 =?utf-8?B?WUkvcnpiTVJpb0hvK3pWb0RFYVhoZS9SRFM5elJrU1pvQWVsMDBOMnhSY3hj?=
 =?utf-8?B?UGg1NWVFdytBVHdWaGhTUTQ1c0ZuVUxhUmVDVWpGam9pOW44VGhjZWpmaGM0?=
 =?utf-8?B?dGxnc0dkVVc5UjVpWGhvOGhIK2dDQkVYc2V2UFNaOGFhOFF5aEpSVCs4OVNL?=
 =?utf-8?B?bHBEQ1F6dWZXeHIvTlJFVm92UEVQWFR2T29BaVI5a3Z3MWlISS9ReUo3eDlW?=
 =?utf-8?B?QnUwaklLUVhuY2dlK0VGUjZLeERFaWJ1QzR2ZGV5Q0Y0Wkc4SmdmOWVRdDFX?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD68FBC2C75DB546ABDCFF77F88A1B1B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+nPMXni9QK+Cx3TNojqvdYWPNFrEJEzWsF+McpMOYj4IgTl3eeiJ0QYcJlFMZXg1t3NIuvV8UhfhRG3x6R3dVxqLu7REjidEa/WWbeaopv6Ru6fn2L0ordyguugvkzh5dbjc6/qKgy06XnYDbb2oWCIFV3BNKgDI1dtUHcgDWiR0owMRTgz+2ndlmhD5VleS/7i9a4I0Z+5klkPw6ObUNAatDtKrEIXVAa854nc0uZlsUhkBg/X0cHDlPnb+5Vc7md8a4E6/b3OVqtD2RpJYOJOoL/o7jCklTf9DzRsNZZjdG+DrY3uPmhD8en/meLHWRAhnoT1i1hPLNrJ1kMF0/69gbCw17RAWXjzCJ8ARKnBldFZ8Rj+RJRIqqdnpxLdXgAVvL1MT85R3hH7s57aYlP5IXqyoILQxcp3BAAOlUPGQ/2qDQctmUiXIaUcZBS4Et2/HdhDs3f+vUHs+uPpluCmQtTJYYlZ192k2Zid8NNDB62XalTd85DF9oHPSb5vbvueLD1ROnQLtXEd9D5URO4IOxVwvKZBfAJiLqHzj+VCKcoXXmN8OFfradm7kkhvLPwbqMjFNut1WqkKmSJc00Irg/nCdd4GFJXphAgFvUpgV5cVzcpcf1BYcYqlXzIhU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3093d09-46f4-444d-be82-08dc85bc2c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 00:04:01.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjkOVAXBTJ6kG0hqaqTp0KsKUVHJZZ/86aOCuIkcjszMu+WfD9mjrUADJBlhQAker2vG+h9IMT7uaTPeVPS0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8014

DQoNCk9uIDA1LzA2LzIwMjQgMjA6MDIsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIEZy
aSwgMzEgTWF5IDIwMjQgMTQ6MTM6MTcgKzA4MDANCj4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBUaGVyZSBpcyBubyB1c2VyIGZvciB0aGlzIG1lbWJl
ci4gQWxsICctTSBjeGwtZm13Lk4nIG9wdGlvbnMgaGF2ZQ0KPj4gYmVlbiBwYXJzZWQgYW5kIHNh
dmVkIHRvIENYTFN0YXRlLmZpeGVkX3dpbmRvd3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiANCj4gSGkgTGksDQo+IA0KPiBBcHBs
aWVkIHRvIG15IHRyZWUgd2l0aCBzbGlnaHQgY2hhbmdlIHRvIHBhdGNoIHRpdGxlDQo+IHRvIGh3
L2N4bDogR2V0IHJpZCBvZiB1bnVzZWQgY2Ztd19saXN0DQo+IA0KPiBJIGFpbSB0byBzZW5kIGEg
Z3JvdXAgb2YgbW9yZSBtaW5vciBjaGFuZ2VzIGxpa2UgdGhpcyBmb3IgdXBzdHJlYW0NCj4gaW4g
dGhlIG5leHQgd2VlayBvciBzby4NCg0KTWFueSB0aGFua3MNCg0KPiANCj4gQnR3LCB0byBtYWtl
IGl0IGVhc3kgdG8gc3BvdCBRRU1VIHBhdGNoZXMgaW4gcGF0Y2h3b3JrIHNvIHRoYXQNCj4gdGhl
IGtlcm5lbCBtYWludGFpbmVycyBjYW4gaWdub3JlIHRoZW0gLSB3aGVuIHBvc3RpbmcgdG8gbGlu
dXgtY3hsQHZnZXIua2VybmVsLm9yZw0KPiBbUEFUQ0ggcWVtdV0NCj4gbWFya2luZyBmb3IgcGF0
Y2hlcyBpcyBoZWxwZnVsLg0KDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kZXIuDQoNClRoYW5rcw0K
Wmhpamlhbg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4+IC0tLQ0KPj4g
ICBody9jeGwvY3hsLWhvc3QuYyAgICB8IDEgLQ0KPj4gICBpbmNsdWRlL2h3L2N4bC9jeGwuaCB8
IDEgLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2h3L2N4bC9jeGwtaG9zdC5jIGIvaHcvY3hsL2N4bC1ob3N0LmMNCj4+IGluZGV4IGM1
ZjVmY2ZkNjRkMC4uOTI2ZDNkM2RhNzA1IDEwMDY0NA0KPj4gLS0tIGEvaHcvY3hsL2N4bC1ob3N0
LmMNCj4+ICsrKyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+PiBAQCAtMzM1LDcgKzMzNSw2IEBAIHN0
YXRpYyB2b2lkIG1hY2hpbmVfc2V0X2NmbXcoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNvbnN0
IGNoYXIgKm5hbWUsDQo+PiAgICAgICBmb3IgKGl0ID0gY2Ztd19saXN0OyBpdDsgaXQgPSBpdC0+
bmV4dCkgew0KPj4gICAgICAgICAgIGN4bF9maXhlZF9tZW1vcnlfd2luZG93X2NvbmZpZyhzdGF0
ZSwgaXQtPnZhbHVlLCBlcnJwKTsNCj4+ICAgICAgIH0NCj4+IC0gICAgc3RhdGUtPmNmbXdfbGlz
dCA9IGNmbXdfbGlzdDsNCj4+ICAgfQ0KPj4gICANCj4+ICAgdm9pZCBjeGxfbWFjaGluZV9pbml0
KE9iamVjdCAqb2JqLCBDWExTdGF0ZSAqc3RhdGUpDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9jeGwvY3hsLmggYi9pbmNsdWRlL2h3L2N4bC9jeGwuaA0KPj4gaW5kZXggNzVlNDdiNjg2NDQx
Li5lM2VjYmVmMDM4NzIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2N4bC9jeGwuaA0KPj4g
KysrIGIvaW5jbHVkZS9ody9jeGwvY3hsLmgNCj4+IEBAIC00Myw3ICs0Myw2IEBAIHR5cGVkZWYg
c3RydWN0IENYTFN0YXRlIHsNCj4+ICAgICAgIE1lbW9yeVJlZ2lvbiBob3N0X21yOw0KPj4gICAg
ICAgdW5zaWduZWQgaW50IG5leHRfbXJfaWR4Ow0KPj4gICAgICAgR0xpc3QgKmZpeGVkX3dpbmRv
d3M7DQo+PiAtICAgIENYTEZpeGVkTWVtb3J5V2luZG93T3B0aW9uc0xpc3QgKmNmbXdfbGlzdDsN
Cj4+ICAgfSBDWExTdGF0ZTsNCj4+ICAgDQo+PiAgIHN0cnVjdCBDWExIb3N0IHsNCj4g
