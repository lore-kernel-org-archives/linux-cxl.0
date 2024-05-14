Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D66FB6
	for <linux-cxl@vger.kernel.org>; Tue, 14 May 2024 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715653032; cv=fail; b=hRY+Jwk/znHrzsidkLh29xgbk6wf+pXfCTOQFJvOI70oVhqgDfAJ+xS+bG43n82SnglEKqvTVVyze5jI5FJxGtCoF0JAYNwHProFNjZUm7OMkdlUBanQdKNAHKG5KxO2x+ee8JbNLNdbmJLS+BuBCIX0IZI/zlihpMq74oC6RXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715653032; c=relaxed/simple;
	bh=Wc+P7vbXEIYX+UiPLISCjC6d9oRgQkV0oUiy12rlRY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHtQ1pUph2wb5WenshoiXKAMhGOF9tI9DEbh6Ywhc9GIaEDWM5w9Nu3ZvuPFD3PXJ8QsKYE48iwXTCG8o96RRdoKA/KgLkFfqyxppFSdkRaoyr16sWL2Dg7B+2f58xToFmz7o4No9D20fYxTR8fkEQrUIxQQE8IsR/UG24lG+ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Wn4MyqvI; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Wn4MyqvI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715653028; x=1747189028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wc+P7vbXEIYX+UiPLISCjC6d9oRgQkV0oUiy12rlRY4=;
  b=Wn4MyqvIfVm6+qQrwQO/dZ3syfsJyPNNxkLVuxU6H2yldi46y+aJfX2K
   w4r3iSfaIb+uqgwepZNXK485rz9rjPPFCVzdoM2WpewUB1+C+7LocEg8U
   4vDNiYjkggB8//MN5U4vWg8jIZ+Mt15FGecVS359wrBbRRqkHn7f80jNt
   PlIj41DEpw2uYvOycNEBmS/uxdUZu/lenscDyw4XgTgk0fHybQ8tPrDLu
   P6JDoqhltkO44Y8rcz3gVERxIxa6U2924oxftBmYVEbUYlo+SYap0VZa0
   Flk39brmC5Op4Erc+tDNtI1KVt7M1rbeAV9qrnb4hEh33Lt7vjoqq3Ec0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="118821642"
X-IronPort-AV: E=Sophos;i="6.08,159,1712588400"; 
   d="scan'208";a="118821642"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:16:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0ZzR3G1Gd0Yi0SrkeGJ2yV8vhxIjk7olkoApS8kLG8acEq1t54/UUgi5sr9BSo4FGd26kLBfP/K0+CVBTB8FJNIS/Rm1XISenH2YkLLxc3y2j6wPUK0QnKAPXaByh9RCCqvNU1hOH0eETzjzvbXOISt2LgiPaEZ7NFGACbMPFANnJ9cjxbGxJpGd+Uq8tSjsZp28Vhbi3+biweZTUP5TnCqafv6kpU5+kU0LaCfkzRfMmPz19jII2+NPf2uvH9hsvuXZ51mhK1d64WM30LES40UlaklgwJHbmGujJd6ApvtLT5XQkr12INLKTJ1rE1WAljOFuV/FkBHstpjbom4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc+P7vbXEIYX+UiPLISCjC6d9oRgQkV0oUiy12rlRY4=;
 b=Oy9LLY0XRbVkFQLsRnDGNfoM3KIL7/kWaU6KPciATu9A5uzd+F+1O0ibCDFEqi5k+mqeydgWoT2ZuQitftiRxyDPBrI7f9O1CPK4SMhvvUzZNh0k5nJgGQ1AXF5/dMTlReZN0CS/ukO1htYbIELcPTLvDUH6WOaACKAu+BjgUa/ecXZlBdU5yecyPH8SB1SrTuM/nqQqdE81zLL/sEQ7hkiKRHHIHhY+Vxr36Tqn6p5rlAXCqEVVA6xPL83BJG57ZKlDiVRy8gWqrwC2lu2+9HIjY723QtyUIKFcyDsEM2G70CQjJsWBgZKCCpDVxTKSday4kR2WqJale6ZOlXRyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB6247.jpnprd01.prod.outlook.com (2603:1096:604:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:16:52 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:16:52 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>, "Jorgen.Hansen@wdc.com"
	<Jorgen.Hansen@wdc.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Thread-Topic: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Thread-Index: AQHakehZMARvSfGob0S2rMrdkXXk1bGWJb4A
Date: Tue, 14 May 2024 02:16:51 +0000
Message-ID: <d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB6247:EE_
x-ms-office365-filtering-correlation-id: e40c0672-0192-497d-d86f-08dc73bbeb22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGRaT2NNL1Z5ZW8waTdNQ0R2L1MrWFFiTXIzeEErZmk3OHRjUlFnZTFubyt2?=
 =?utf-8?B?aUs1enVtVEkrYlg1NFZZZlBBVUpIajljOFRDZVNEYmVrV2d0NmVBTEh3L3M2?=
 =?utf-8?B?YjRTTWFKUHNGd1VTNWtacThKWFFsNmhQTXQ0a1lJQ0FzYXY5QXpXVDZMa0F1?=
 =?utf-8?B?RXlPRXgwaE1YbFlwckNUU1U5TTBscnlTQ01YYVRRanBlWFBjMDhjVE5KMU5W?=
 =?utf-8?B?ellMNHFiUTMwdW1jMlNQQmp4d0U3OWx3N2pyUlRHNnAvbllqc0FmbWJBeXJy?=
 =?utf-8?B?cHhqVDI0akNpZ05MR2UwaCszS1c4OTFCT1Y1WU9LNXhJZ0QrKzlyMnowdzNk?=
 =?utf-8?B?T3Y1U1VkbUp1aWQ5a01OY2xqL1ZpaDBZbzdISHI3ZmhTWVBHMmpVNE1lTEpr?=
 =?utf-8?B?WTI1SVdXajE2ZVRVdTJGdkVqYWJ5NVpNc0hXQ0tQV0tRWDBEUDNXK3dWamJN?=
 =?utf-8?B?K25CdDRoaTJJRm9LcHllQkIzbmcyMWtzRWJwc1JzRktRSGwzdTVocXJ2cSt0?=
 =?utf-8?B?d0gvMG1neG9wbkRmUk00VjdFZmRmOFhvZnBsZTN4QmpNclZ2NGdFUXZMVlk5?=
 =?utf-8?B?bFRRSEh6UVlVTjZTZ3BPRGZGeEFweS9BWDdicTRmUkZDMmR2SmtiaHkyYng4?=
 =?utf-8?B?eG9JRm0vRnAxMG5DQ0tncU1aL0hRSGt0bFFHWUc3Y0lNVVJMQWRBMjFNRkZP?=
 =?utf-8?B?TkRnQ2dmdmFCdStDS04vRm1XaFpnOWtYamhoNlVCRTgrZ3BMdHI5VmtXOXJu?=
 =?utf-8?B?cGt1NnkrUTFqVjhoN2dWQTlyc3VxTENPT3JoeFVTWlpwWEtDTXB3QjhuRkRo?=
 =?utf-8?B?eC9VY21kZDJOOER4cVM5MTJGMzNTanF2UVpNMmFMWThKR1VKMkQ0MG5tZEVw?=
 =?utf-8?B?Vkd3QUNER0pEM1F4aDMxbUVqRmtFaDl2VTdvVytQZjUxT0oyWFMySDlVRUp3?=
 =?utf-8?B?R0ZqQTAxSDNzak5zd01NK2tzTExqbGk5cGdOYUhXZE9FSUdXNW5icmQ2bnFt?=
 =?utf-8?B?Sk9yWW5nK0JoVW9JbjJHM1NET085cUxyY3N2SlI5bFRvZUtiNjY2UmFoSEFu?=
 =?utf-8?B?Q2pvMVpIOUR2Y2tEUUZVczN1SzZyalRuYkppa0FyL0R5M05CRTg3SUczR0o0?=
 =?utf-8?B?dFF4c3lIZ0NCcmF1OENoa1dHd2Y5WTZ4SGtEOUtRaXpVdGxpRUx5SEk1clU5?=
 =?utf-8?B?c0dUY24zV25Nd0ZDdWlWTUxHdmh2RDFJckdzZUVNaDRpYnEzY1lCL1ZxN1o3?=
 =?utf-8?B?MzNGeSt0MDBYdHVGbU5SL0tJRW42NHNYTmI4bTZQeTcwU21Hc3J5RXVIK1p6?=
 =?utf-8?B?ZjBUamhmVE5sbkhtdVNSamxXWm9HMFRRZDhGc1A1WUJSN1F6bEFET0I2RkJQ?=
 =?utf-8?B?Wmpib24zUFU1TVdMdHlUdDVFZElkbXRtOURoZllsYVdzMjFkVC9xVkxFTEg1?=
 =?utf-8?B?T2cvS29ZYThGOGtacWw1Ly90dmtjRzFIdWo2QitiQklDTzhwQjBxSmROaGh6?=
 =?utf-8?B?Rnk2bmNVSFRCMDdKZXMrWlE5VS96RldXMnYwNVhOOWtpMG9KaTJDY0hUNnBY?=
 =?utf-8?B?UUp4M3dwdnFmTmpHdzJMWldMY0VLZDQ4czRkVmc3NDFvbmd3SDJ1WFJCV1BZ?=
 =?utf-8?B?SW9qa3l1U0s4YUVvSVp2UWd4SXZDN1ZjUU5JNXdHdkQwdytjbHlESWpxV3VU?=
 =?utf-8?B?QXZXNzAzMkVsTmpXWUNmOEkzeTNreWJqeWhENGdISlNPK0htRG1XWENsTDNi?=
 =?utf-8?Q?Lxvat40GVcVvzKQxS2IipAbC4/C3LOcKzLgMIl9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGtqOUpCY2g2ekp2RzVDUzc2aVg5QTdvZE9PU3V0R3FyTUlid3kyRXVaQytp?=
 =?utf-8?B?YncwOGVjQzJiODBlQ0pVSE1LYnJzdHJmZVVwQlBaV1ZTR1c5NkJ0d00vK0ly?=
 =?utf-8?B?Qm00Y3JUUVhDYTRlYko1aUdBTG40MGhMMVhHaGdVVlFhOTBzeWd1RGlyOWpy?=
 =?utf-8?B?ak12Z3NUQ0p6ZmY3VE9uTlVNelFFdmFxN1k3SHptZHR4bUorWXBtQ0JoWEtX?=
 =?utf-8?B?aGVJN1BkRGVqMjkzekxLb2l6TW1vWDBwTmQwdWRBbVltTFdwRzJZVUhSVFJr?=
 =?utf-8?B?UEEzbytTanhRK3l4NWdOVkozSWhiRGJEN01GNHE5Ymd0MkZ6NlJibm95cDdG?=
 =?utf-8?B?TnNjdkVUSmlHMzBTK1FoOVdaSUh0U3FVN0Q3ZmUvUUhXSEc5MnlEcWdLNlFU?=
 =?utf-8?B?UWtxaUVsblRGVENaTVVvZi9DSXQzYUVVS1JDMUFYOFl4RkF6Y3RqOTdTMjlW?=
 =?utf-8?B?SjZCbHFjUmxHUUtINWo4Z1RibE4wK1ptMlhSTEg1S2x4OE5Pc3N6d2g1eWtl?=
 =?utf-8?B?aGxQSjJJT3BNd1BQN1FQVm00T3hpOWEzU2VjQlpxckZUb0p6SHZMQWhrWGtC?=
 =?utf-8?B?a1Erc1g4RkNqR1dEemZZbWU3ZzJPZ0svRmRGSHFxN2V4eml2dnN6Q1lUSS9S?=
 =?utf-8?B?Vnl0ZDl6dXZnY3N3UEJyQVJxVTlYV1UrTzJuNGMxSG80Q2ppOTY4b21uMERB?=
 =?utf-8?B?TnpMWFdFNGJ3d2pvN201REJnekc5Zm1BdkU0SStqVzl6NmpSMm5qdHFYRHYz?=
 =?utf-8?B?dy8wSlV3QjFzdXI3ekt5NHZCaFdCcXhLaTZ3VWZzTDR3dkNNb3prS1JyR2Nu?=
 =?utf-8?B?d0RWbUVrVzY2VDZJVnhiWno1WGJIRHRqQlJXZ2NrTUR2TWJsUTBsc1J6QTNX?=
 =?utf-8?B?YUpBZlhQT0xUR0tUNkhGdUpyelhYSmJWWW9Yazdib2Qvb2QzQ0hEblhCb1I1?=
 =?utf-8?B?dU1BRklQallBWWwyYi8ydUNOR2lIcm1xRDQrbStwVnZjK3FjMVJIOTBZdWM0?=
 =?utf-8?B?aFJXTWJNZE5Rek1FcnBxWTN4cWtZOHhsbGpxRXBMcjlYWUw2bDQ2dnMxSUJt?=
 =?utf-8?B?VEUvS3VTQlVKdnl2c3ZTKzlNMFhrMncwSCtMbGJOMjE0UTh5WFFSZVNpd2ZQ?=
 =?utf-8?B?UG5qbXh2MFZCNlBNblJNN3RpakRjNHYxOHN5L0tWdEJhMG45S245QzVVN3dk?=
 =?utf-8?B?U2IrWnFkbXdBakF4YkhXUHNMSGI1cjFsMFlVNWZ2TUhhWWEwV1ltMWtGU2Yv?=
 =?utf-8?B?bUc0QjZqRUVZQ0hFOEZ3VEpRbXBoVGNmVDJKVE81TXI5ZmEvczY2ZTBPdE5F?=
 =?utf-8?B?Vkk0UklVaVpyN3lsblQyVmFyOWV2bFpGa203ZTNsQVBMK1FoR0ZUbEJwaFZH?=
 =?utf-8?B?VGk1UzF0Smcrd2RnNXNiT1lxbWdZaEdCdGEzT0xIVlJhSHhveGx1Ty9mUHds?=
 =?utf-8?B?bjQwbFdlQWFUbzBLMUdKYncva1haR1BVekhQaHkyNWYvSzBzMzR5OFF4V202?=
 =?utf-8?B?L1ZDbFhtN3JiMnZ5T2VnZ1QyODIvZ0kvNHc3TWpkMjgxMDdSSnlpNWl5Z0lN?=
 =?utf-8?B?eWtIOWZwdXFVV1loM3lFUDFsYTF6K3c2b3FFTVpGVzlUSU5jdWQ4UXdQQXpn?=
 =?utf-8?B?eERUZlpBZVNHQXQvNjZuNG15bkV6Z0I1QlFxem40bnVMNU9HblJ0TDRpcTNp?=
 =?utf-8?B?MFhmc0ZDS1R5ZXN6cG51aGQyaEZ4UXZPMitwalJublBBRFdtSk9qTUxoYy9p?=
 =?utf-8?B?MEpSOU5YTGJNS1grQWFXa3dISjlUK3c0bVVlYnF1Z3BSUG05Y0grdHlYbkQy?=
 =?utf-8?B?VU93N0FpbjRsaUNYbExqb0U4Q2c5OG9xMkxVSktZYnFFM1NZdjhGOExZRkVL?=
 =?utf-8?B?T2ZpTXhZRTBZb2FDTkNPWThteHZRT1grQVgyUjZHLzdiTkFBeWNRWE9sNzVI?=
 =?utf-8?B?eDRjekJmcTh0dFEwMXVDWWVST3cvbzJMZW8vODEvUWxjdnpUWERId2xUV3lZ?=
 =?utf-8?B?NmNrZ1NRbGVHcmdXdmxKazk4QUJrL042UXk1VS9EekllMmpwUE03cDNNSVhX?=
 =?utf-8?B?bkRJdlNhMGJ4RkJoVFN0Z2Vsd2JJWTNnaHhWRXo2OE80NUpLc2FlWlJsMU5q?=
 =?utf-8?B?MWZlcVdFQnR5eDAwWEhldGF5MldsZ25ZMXQvODFBQWM3TDdWd0pQeTVFeFE0?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A0F2B0354CF33458A5A5ED107694C54@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wCFctOQoatpeyFBw0fiXxKi12BmsLMo2ciGlYRugnfxwp92SOfEtODCFMfN3wY+eXbUdS4K5f0MbPd18ZXHdcKBOTDdc4Qo2DiSW2ZdRXoZA1F4f5bT2oMVqTH7WPQ/G5gX7ulxixlJ8REGEfg8C3bpqUa7uXBbGEQq69ilBC6v9tSl+TeEK+i9sAlYeRZVgQ3x2qhne9BqxZh88w3Hvn0iQiqO8XRc1a82hqdXNa/iz1qM+IaYrQG1RSngucxxwxav2bWf5uUkUyfzoFdbOmwAg8G8kvPuBmo63zWLMPeCNt+4PUL5RBKsiJCaBEx15o8sdrN0dppIXO/86PjGyqhgv7teAzyU65/SOp1/gz1qfa2Knp6ZlHnwDx0LKXh3u9+FrD/xpxH+RToemSTih2fGGwHb1k3uYCJMx3qoFhFoSM+PYtn78nJI3DXkThzLDi3CavG73Dvi5N4Hgl/xy5kA4L+2ky2h4E2jMKyi/LJ/EW380CBR90bq7ZMdp59bHJWtR/5djajYPZN49NGQtGuA3EZHXNw1OfMql4/52JiZE+dji4Tr2XCZ+c+GkPqICO1UykapGPAiMEOC1div3awgFIjk59Zr0NfRk1g1ZxVQ3D9o5r5hgl2nem5Wmbxj0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40c0672-0192-497d-d86f-08dc73bbeb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:16:52.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9GJQRHdcZievvX2D7H8qtWoaqE8CR1ueEGpoOVE8Iy+jVsD4yD4fRBXHJ2O5mliYuobKWxVQueRxer89cVSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6247

SGkgRmFuDQoNCg0KRG8geW91IGhhdmUgYSBuZXdlciBpbnN0cnVjdGlvbiB0byBwbGF5IHdpdGgg
dGhlIERDRC4gSXQgc2VlbXMgdGhhdA0KdGhlIGluc3RydWN0aW9uIGluIFJGQ1swXSBkb2Vzbid0
IHdvcmsgZm9yIGN1cnJlbnQgY29kZS4NCg0KWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDIzMDUxMTE3NTYwOS4yMDkxMTM2LTEtZmFuLm5pQHNhbXN1bmcuY29tLw0KDQoNCg0KT24g
MTkvMDQvMjAyNCAwNzoxMCwgbmlmYW4uY3hsQGdtYWlsLmNvbSB3cm90ZToNCj4gQSBnaXQgdHJl
ZSBvZiB0aGlzIHNlcmllcyBjYW4gYmUgZm91bmQgaGVyZSAod2l0aCBvbmUgZXh0cmEgY29tbWl0
IG9uIHRvcA0KPiBmb3IgcHJpbnRpbmcgb3V0IGFjY2VwdGVkL3BlbmRpbmcgZXh0ZW50IGxpc3Qp
Og0KPiBodHRwczovL2dpdGh1Yi5jb20vbW9raW5nL3FlbXUvdHJlZS9kY2QtdjcNCj4gDQo+IHY2
LT52NzoNCj4gDQo+IDEuIEZpeGVkIHRoZSBkdnNlYyByYW5nZSByZWdpc3RlciBpc3N1ZSBtZW50
aW9uZWQgaW4gdGhlIHRoZSBjb3ZlciBsZXR0ZXIgaW4gdjYuDQo+ICAgICBPbmx5IHJlbGV2YW50
IGJpdHMgYXJlIHNldCB0byBtYXJrIHRoZSBkZXZpY2UgcmVhZHkgKFBhdGNoIDYpLiAoSm9uYXRo
YW4pDQo+IDIuIE1vdmVkIHRoZSBpZiBzdGF0ZW1lbnQgaW4gY3hsX3NldHVwX21lbW9yeSBmcm9t
IFBhdGNoIDYgdG8gUGF0Y2ggNC4gKEpvbmF0aGFuKQ0KPiAzLiBVc2VkIE1JTiBpbnN0ZWFkIG9m
IGlmIHN0YXRlbWVudCB0byBnZXQgcmVjb3JkX2NvdW50IGluIFBhdGNoIDcuIChKb25hdGhhbikN
Cj4gNC4gQWRkZWQgIlJldmlld2VkLWJ5IiB0YWcgdG8gUGF0Y2ggNy4NCj4gNS4gTW9kaWZpZWQg
Y3hsX2RjX2V4dGVudF9yZWxlYXNlX2RyeV9ydW4gc28gdGhlIHVwZGF0ZWQgZXh0ZW50IGxpc3Qg
Y2FuIGJlDQo+ICAgICByZXVzZWQgaW4gY21kX2RjZF9yZWxlYXNlX2R5bl9jYXAgdG8gc2ltcGxp
ZnkgdGhlIHByb2Nlc3MgaW4gUGF0Y2ggOC4gKErDuHJnZW4pDQo+IDYuIEFkZGVkIGNvbW1lbnRz
IHRvIGluZGljYXRlIGZ1cnRoZXIgIlRPRE8iIGl0ZW1zIGluIGNtZF9kY2RfYWRkX2R5bl9jYXBf
cnNwLg0KPiAgICAgIChKb25hdGhhbikNCj4gNy4gQXZvaWRlZCBpcnJlbGV2YW50IGNvZGUgcmVm
b3JtYXQgaW4gUGF0Y2ggOC4gKEpvbmF0aGFuKQ0KPiA4LiBNb2RpZmllZCBRTVAgaW50ZXJmYWNl
cyBmb3IgYWRkaW5nL3JlbGVhc2luZyBEQyBleHRlbnRzIHRvIGFsbG93IHBhc3NpbmcNCj4gICAg
IHRhZ3MsIHNlbGVjdGlvbiBwb2xpY3ksIGZsYWdzIGluIHRoZSBpbnRlcmZhY2UuIChKb25hdGhh
biwgR3JlZ29yeSkNCj4gOS4gUmVkZXNpZ25lZCB0aGUgcGVuZGluZyBsaXN0IHNvIGV4dGVudHMg
aW4gdGhlIHNhbWUgcmVxdWVzdHMgYXJlIGdyb3VwZWQNCj4gICAgICB0b2dldGhlci4gQSBuZXcg
ZGF0YSBzdHJ1Y3R1cmUgaXMgaW50cm9kdWNlZCB0byByZXByZXNlbnQgImV4dGVudCBncm91cCIN
Cj4gICAgICBpbiBwZW5kaW5nIGxpc3QuICAoSm9uYXRoYW4pDQo+IDEwLiBBZGRlZCBzdXBwb3J0
IGluIFFNUCBpbnRlcmZhY2UgZm9yICJNb3JlIiBmbGFnLg0KPiAxMS4gQ2hlY2sgIkZvcmNlZCBy
ZW1vdmFsIiBmbGFnIGZvciByZWxlYXNlIHJlcXVlc3QgYW5kIG5vdCBsZXQgaXQgcGFzcyB0aHJv
dWdoLg0KPiAxMi4gUmVtb3ZlZCB0aGUgZHluYW1pYyBjYXBhY2l0eSBsb2cgdHlwZSBmcm9tIEN4
bEV2ZW50TG9nIGRlZmluaXRpb24gaW4gY3hsLmpzb24NCj4gICAgIHRvIGF2b2lkIHRoZSBzaWRl
IGVmZmVjdCBpdCBtYXkgaW50cm9kdWNlIHRvIGluamVjdCBlcnJvciB0byBEQyBldmVudCBsb2cu
DQo+ICAgICAoSm9uYXRoYW4pDQo+IDEzLiBIYXJkIGNvZGVkIHRoZSBldmVudCBsb2cgdHlwZSB0
byBkeW5hbWljIGNhcGFjaXR5IGV2ZW50IGxvZyBpbiBRTVANCj4gICAgICBpbnRlcmZhY2VzLiAo
Sm9uYXRoYW4pDQo+IDE0LiBBZGRpbmcgc3BhY2UgaW4gYmV0d2VlbiAiLTFdIi4gKEpvbmF0aGFu
KQ0KPiAxNS4gU29tZSBtaW5vciBjb21tZW50IGZpeGVzLg0KPiANCj4gVGhlIGNvZGUgaXMgdGVz
dGVkIHdpdGggc2ltaWxhciBzZXR1cCBhbmQgaGFzIHBhc3NlZCBzaW1pbGFyIHRlc3RzIGFzIGxp
c3RlZA0KPiBpbiB0aGUgY292ZXIgbGV0dGVyIG9mIHY1WzFdIGFuZCB2NlsyXS4NCj4gQWxzbywg
dGhlIGNvZGUgaXMgdGVzdGVkIHdpdGggdGhlIGxhdGVzdCBEQ0Qga2VybmVsIHBhdGNoc2V0WzNd
Lg0KPiANCj4gWzFdIFFlbXUgRENEIHBhdGNoc2V0IHY1OiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1jeGwvMjAyNDAzMDQxOTQzMzEuMTU4NjE5MS0xLW5pZmFuLmN4bEBnbWFpbC5jb20v
VC8jdA0KPiBbMl0gUWVtdSBEQ0QgcGF0Y2hzZXQgdjY6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWN4bC8yMDI0MDMyNTE5MDMzOS42OTY2ODYtMS1uaWZhbi5jeGxAZ21haWwuY29tL1Qv
I3QNCj4gWzNdIERDRCBrZXJuZWwgcGF0Y2hlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtY3hsLzIwMjQwMzI0LWRjZC10eXBlMi11cHN0cmVhbS12MS0wLWI3YjAwZDYyMzYyNUBpbnRl
bC5jb20vVC8jbTExYzU3MWUyMWM0ZmUxN2M3ZDA0ZWM1YzJjN2JjN2NiZjJjZDA3ZTMNCj4gDQo+
IA0KPiBGYW4gTmkgKDEyKToNCj4gICAgaHcvY3hsL2N4bC1tYWlsYm94LXV0aWxzOiBBZGQgZGNf
ZXZlbnRfbG9nX3NpemUgZmllbGQgdG8gb3V0cHV0DQo+ICAgICAgcGF5bG9hZCBvZiBpZGVudGlm
eSBtZW1vcnkgZGV2aWNlIGNvbW1hbmQNCj4gICAgaHcvY3hsL2N4bC1tYWlsYm94LXV0aWxzOiBB
ZGQgZHluYW1pYyBjYXBhY2l0eSByZWdpb24gcmVwcmVzZW50YXRpdmUNCj4gICAgICBhbmQgbWFp
bGJveCBjb21tYW5kIHN1cHBvcnQNCj4gICAgaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZTogUmVu
YW1lIG1lbV9zaXplIGFzIHN0YXRpY19tZW1fc2l6ZSBmb3INCj4gICAgICB0eXBlMyBtZW1vcnkg
ZGV2aWNlcw0KPiAgICBody9tZW0vY3hsX3R5cGUzOiBBZGQgc3VwcG9ydCB0byBjcmVhdGUgREMg
cmVnaW9ucyB0byB0eXBlMyBtZW1vcnkNCj4gICAgICBkZXZpY2VzDQo+ICAgIGh3L21lbS9jeGwt
dHlwZTM6IFJlZmFjdG9yIGN0M19idWlsZF9jZGF0X2VudHJpZXNfZm9yX21yIHRvIHRha2UgbXIN
Cj4gICAgICBzaXplIGluc3RlYWQgb2YgbXIgYXMgYXJndW1lbnQNCj4gICAgaHcvbWVtL2N4bF90
eXBlMzogQWRkIGhvc3QgYmFja2VuZCBhbmQgYWRkcmVzcyBzcGFjZSBoYW5kbGluZyBmb3IgREMN
Cj4gICAgICByZWdpb25zDQo+ICAgIGh3L21lbS9jeGxfdHlwZTM6IEFkZCBEQyBleHRlbnQgbGlz
dCByZXByZXNlbnRhdGl2ZSBhbmQgZ2V0IERDIGV4dGVudA0KPiAgICAgIGxpc3QgbWFpbGJveCBz
dXBwb3J0DQo+ICAgIGh3L2N4bC9jeGwtbWFpbGJveC11dGlsczogQWRkIG1haWxib3ggY29tbWFu
ZHMgdG8gc3VwcG9ydCBhZGQvcmVsZWFzZQ0KPiAgICAgIGR5bmFtaWMgY2FwYWNpdHkgcmVzcG9u
c2UNCj4gICAgaHcvY3hsL2V2ZW50czogQWRkIHFtcCBpbnRlcmZhY2VzIHRvIGFkZC9yZWxlYXNl
IGR5bmFtaWMgY2FwYWNpdHkNCj4gICAgICBleHRlbnRzDQo+ICAgIGh3L21lbS9jeGxfdHlwZTM6
IEFkZCBEUEEgcmFuZ2UgdmFsaWRhdGlvbiBmb3IgYWNjZXNzZXMgdG8gREMgcmVnaW9ucw0KPiAg
ICBody9jeGwvY3hsLW1haWxib3gtdXRpbHM6IEFkZCBzdXBlcnNldCBleHRlbnQgcmVsZWFzZSBt
YWlsYm94IHN1cHBvcnQNCj4gICAgaHcvbWVtL2N4bF90eXBlMzogQWxsb3cgdG8gcmVsZWFzZSBl
eHRlbnQgc3VwZXJzZXQgaW4gUU1QIGludGVyZmFjZQ0KPiANCj4gICBody9jeGwvY3hsLW1haWxi
b3gtdXRpbHMuYyAgfCA2MjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4g
ICBody9tZW0vY3hsX3R5cGUzLmMgICAgICAgICAgfCA2MzMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tDQo+ICAgaHcvbWVtL2N4bF90eXBlM19zdHVicy5jICAgIHwgIDIwICsr
DQo+ICAgaW5jbHVkZS9ody9jeGwvY3hsX2RldmljZS5oIHwgIDgxICsrKystDQo+ICAgaW5jbHVk
ZS9ody9jeGwvY3hsX2V2ZW50cy5oIHwgIDE4ICsNCj4gICBxYXBpL2N4bC5qc29uICAgICAgICAg
ICAgICAgfCAgNjkgKysrKw0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTM5NiBpbnNlcnRpb25zKCsp
LCA0NSBkZWxldGlvbnMoLSkNCj4g
