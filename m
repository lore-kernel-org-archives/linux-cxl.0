Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856A199B8
	for <linux-cxl@vger.kernel.org>; Tue,  2 Apr 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037415; cv=fail; b=oS2gROscKhxH1m57ue8CVIVzNnJOZOPJNaTE4RgBGM875apXiNY25bSXq7PQpWRDfM+CK+b24LuM3rBDev4Is+BOiKO/5ThI8n3iXbIOSomgc4ml154r8ftqofOtE3n8inZFCwNfA5OuIt2pmrSnNVK0NECJ4/GvcC0UyOwupsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037415; c=relaxed/simple;
	bh=rc6ov/18AV+wOEsRxdLh1wABCDsxU8G1FD3cP6um3I0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFMHfyDu6OVViy86HCt87ycUEEzp2y1nNWPsKYIKhLgPac9yRLtNKm0q1flIcw5cGm19W6NPyyd+oHS5YAuNIcqO0gQXihJhim8M/uqBAbYpimoFPouZ2TJJE0ATwd6M2aggCxtLX9GCrIKgf1cHrANZ0croj6Z3ku6EnzX3Smg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ayvissIU; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ayvissIU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712037413; x=1743573413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rc6ov/18AV+wOEsRxdLh1wABCDsxU8G1FD3cP6um3I0=;
  b=ayvissIUh6kMWnGcIpX3XglLxySkVNAhVibsoY7950fs1caFQEgo+ZDk
   KyIodGqvMcYoXJ/YL6rPsL112beh8c5BlIOxHiKvEHuQlEVO2TNLgSWLv
   W5Tdi0jGBD8/MCMUwYol2wDKoMB5iKe1ZIYJ17grf8DsKyYv+SExYOKp3
   HdwSU2aFy+CxMRMQgyBLBgOhtIZv0h1vnw4TW5Rbj8dQcvoeDNLAsAa2f
   quhlPOzP1m641FCmOkek3putuD7D9AInwQTCo7rw9I6/u6PjSnYXwxNos
   KB6YRsEyAAvLDZc3N0j6H1Onq+cypW7Qj7RAcdXUIHAFXe3m874P9Kr6t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="115226891"
X-IronPort-AV: E=Sophos;i="6.07,174,1708354800"; 
   d="scan'208";a="115226891"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:55:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFvhOLXzItinNZMOS3knygx8xAiwlAAIObKyHlzJ5AzvGQ3Ox3ThMN4o+muzJvHH7xIrRZADnUvP1GU26J0r16XCNSmUQ/7TuZqgH7S3r4lDBbatbFKqQh33IhaXjbXsgPUILQqpDrHeIxLv25NCav5XQQBURr+XM5RW8l7S9y+ix8LTSobbopT2whSVp4bliNPz2Yqew7M6OdUjmTTk3wwaRd6zQ29pY+PSP3bBEp3t/YtfArSBaYNIH3qk8yAfmWrf9yN3hASBYYeMlUfQ4QBiBEQv56n1pmq04SqFjVkVWanVuurp0f2ovRn3a4qDc5aJGoKO324FD/g14WDcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9swAWE5rV/90RHaIq0h7zlztUFFap55nm5XfzxFgjg=;
 b=NbLZbhRGyVDDXMcNDy8WTrDLVVXgqZlWG4PLLVYsuMlM/7pfRkp1TzB9IC4hCqULvkSG3duLjbvHPDK92p21AVB0p1Gf2RDStSYFzn92RirSMILFgSL2ndND6j4LtQRXdFokjCH1psNavXGqdwuotHuiLtOq/ZWGbM94Kv4BL64bKaDVzSMn3RXVr8Uul/+3Uu8ZIDC8A24zYEManIgWdhmbd5vbhjQeSjiteUpg/iBf+e5VMOt/SStAMvY6G7N6T4JXLNmbqzNVjh3PZf4EszODKnKfPf/yWX38CcAV0Ny/MqxOEH53mS+aH44bXE85j3/mDH/TvT+T8wzISnJt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TY3PR01MB10255.jpnprd01.prod.outlook.com (2603:1096:400:1ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 05:55:35 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 05:55:35 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/core/region: check interleave way capability
Thread-Topic: [PATCH] cxl/core/region: check interleave way capability
Thread-Index: AQHahApDlEHOaLq5zkWtkdipOI8sL7FTvlGAgAC7ehA=
Date: Tue, 2 Apr 2024 05:55:35 +0000
Message-ID:
 <OSZPR01MB6453AAC014D3BA482316397D8D3E2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>
 <660afe2726552_157862946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <660afe2726552_157862946f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=67ade297-7967-454e-ba6d-cfa5579cf319;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-02T05:45:21Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TY3PR01MB10255:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j5UZT+hL4x5/VX9tH0dODGC3G+lrrpjwiqmPusIuyXR0CBwA1H4qz2MF49RobnOMxIpcxJ9LX2HRYnKZiIGFMdhnBAKfLSaz7vL7ZdlU9PwgeWab/VClzHm2iydHUwEOPtRGtgZHAsz2Bh5RcVsRLMoQvMIOKnjYjG1FXiW7uOJQ31tkhF6acFRP4WDcxFqpgf9ONLti0NpewCg4vrgbpZ5AfLPYH+0mGqdIMg/PhdXOAd9/aZOlvLXRspj6MvSeGEodJF2zzc72aWkEY202xhaMkc7YOacP7oy/K3YGA0QezstU0NtPegmnyDfkPAaZ1FSjKMSpJoZz745wpRoWq0Xb3REBjS+puoflUQ6G/MlHAsNHt73kcPEXp9BCwgiWchbgL2fhBmvt9yUjMrkc3+O12f/8kCDg4ef7GviHokjbXv+slP5lApUHvkNjK+sv9v/7ninKZHZZoxVd69ZpH6XTgJ1ZTfih5gIAG3a14pig14rWU5ye7HVhA8Y6Tf5C5AyWo1CIM/Puni8jftLsyeV0whMPWZ737yhwBXQRjF2nKLrKHpFEenUvQ9OsK+xZY3kX9xWOcTEraKtHsvkco4RyWKOTF7naU6ucsd5yM2d8G4MFkiifyEzYoRz/7o/5aXQYGGyw0IXT65yRSI8yQTgezmDW8In43f9PiqIx47o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Q2hyWGJyaU5Tb1N4bnRFMExoT1NWRnhmTVlZNk1PcitlZ1N0eWlvZU93?=
 =?iso-2022-jp?B?ckwyTWxPSkowZWNocDIyd0dCMGNuaWxDM1djRHlCbHhnNmVmOEZjQ3I1?=
 =?iso-2022-jp?B?T2lyOGU5Z2d5WHVMOGMrRzV3dmhvdHNqeDM1K2owMDlMQlRvdUw4V1Mx?=
 =?iso-2022-jp?B?eHBTeWNUcENNVUs4TGZkK2JVc3FRck9rWitSU3B0WGlKSTJTWlpMWUxM?=
 =?iso-2022-jp?B?dDJCeTd2RlhxTnJEQmx6ZWZtVURJOGc2aDNGTm4wK0xHS0E0R2hmSTZX?=
 =?iso-2022-jp?B?K202OXR3VVF1YWN0WnpVRm1va0cyUWU0cjRvQ3RkRHNud0RtbFhLNlBU?=
 =?iso-2022-jp?B?N0ZseGNiMXc1MjNyaWtkWjIwTElCT2hRaGJEUnlaK3lzYXZ2SytldmpF?=
 =?iso-2022-jp?B?REM2Q05vZ0w2K08wbmI0eGJxSE9TbDVySG45TmV6VXVJbmlGczVTV1pF?=
 =?iso-2022-jp?B?R0tLZENhbEFFWWxjanZWSU1pZXkybnlPM1pDVWR2bjluVmVBQXJjb2Qy?=
 =?iso-2022-jp?B?bWRYalBRK2ZuRUUvYTdNWlMwdytQWG1NbXV1OXhwYVVrMm5lVm0zTCsy?=
 =?iso-2022-jp?B?TmErUndSM2hOc3MrdTNXU29QKzVUWDlRRHdVUlpUd0xGZnNiTHBiNDB3?=
 =?iso-2022-jp?B?Q3ZMb2ptcitORFBoQXREbVJWRFNDMk5WUDdkK0xEZ0N3WndzWm1GT2dk?=
 =?iso-2022-jp?B?SG1OOVNzR2pmNXBzeXlRaE8rYXY4UVpua3NvTHdIS2ExWk4zZjFPaWxJ?=
 =?iso-2022-jp?B?U2RMaVQvYTdUVHU4ZFh1MEZ0QVdBS3NFWnFKNzJaTFJxdElvNzRCR09P?=
 =?iso-2022-jp?B?cXNLVmV4MlI5MG5MaXhiUW93VWg4UzZCOVp0QU9BVUI1V3U0UlVYN1V3?=
 =?iso-2022-jp?B?MVlPRjZjaWwvY28xNWxvdXBoL1VWbi9veGd2YXovbnZibHZOSzdsN1JU?=
 =?iso-2022-jp?B?MmJWSUk0dmZ3dk1pcklTOVFFTlU1b001YUV6SzRFdE1oVGQxMXFjWlVo?=
 =?iso-2022-jp?B?czZCM3ZCb0tpaUV2aEJVTFhkQk93OWtuSm44TkZGbVU3bDM2VjhwMXlE?=
 =?iso-2022-jp?B?Q2RZN0IyTVRZRllTV0MrblV5NSt2SlNKWkJ2dldLcXhuMXdqRTVQQkI0?=
 =?iso-2022-jp?B?Tzl4dnZ5QWEzZVpvVkQ1eHV3dlpQMEVFRS81RWxFN3NWY3cvNEswVmtE?=
 =?iso-2022-jp?B?VFlJRllFUGJoM01EVi9oWU5veERCRnFocGI0aFpsU0VUQ3RnaTVVYWpI?=
 =?iso-2022-jp?B?cVFXZHFjSWNRTzY0emdTbS9neENzeTlObGVnVFJkZWlxMjlqQWtVQ1dJ?=
 =?iso-2022-jp?B?OUdsdmZvcFR1RkMxUVJHNjVIWW4waHNGa0gwZmgzdEJoMURLNFpDYkxN?=
 =?iso-2022-jp?B?UjE5N3d3Rmh3TUFoNU1LeEh4KzZRV2RBZ0VRTklSWW84WkI2bmtiVDZr?=
 =?iso-2022-jp?B?Q0xyT2ZVNzlXYjR3L29vUVVUWmVncFhHMS9QK2JiYlJLdUE1b2JWbHEx?=
 =?iso-2022-jp?B?ME9hYTlibU5NdFovRitWVEM5L1hzQ2xaNHk1Mzc2WjRQSE9YSmdoWmh6?=
 =?iso-2022-jp?B?cENQT216ZXpqa0R4YVliL0lyY01QbmpoK2tHR2lzRjhwaTZjQm1GYS9v?=
 =?iso-2022-jp?B?QTBKQldrYjFzZkFoYjVHTDV4ZUlpeGxqRnNlOW1PQVVwZS9USERWM0NF?=
 =?iso-2022-jp?B?K09xS3pXSUh2a2pTc3ZuTSsxd2gybWE3L3ZWMkZKRmlwNnozbm5KSjJS?=
 =?iso-2022-jp?B?Z3M3eGhCekhOTTYwOXNNblNuVkdRUnNMRUdxZmsxOEx4SEtRcXpscVhW?=
 =?iso-2022-jp?B?UEZqdjliV1k4ZUI4VlpGT0U4NHVweDcvbHoxeHlWRDdPL091RDEyRmZl?=
 =?iso-2022-jp?B?SkpzdWhVY1pxd25oaEtpOW4vSHgvV1d4enQ0WXprY3BlNkFNLzBKWGhW?=
 =?iso-2022-jp?B?bzhlbjY3dWFEU2N2N1RhZHZ6OURmcEFFdnhMRGx6cUxBb0lTS3dQbm05?=
 =?iso-2022-jp?B?N2ZtUTdYM1pzRkFLVE8vWElUK1FMRVp4SHBmaHFJdy9xVEMzYUFTbEI4?=
 =?iso-2022-jp?B?djc1MFFMOThYS3FwTHJiZ3laZWczOStyRHNvNHFzSUhvWk1GZUNKS3dJ?=
 =?iso-2022-jp?B?R1NRa1VkWHZMZmMwYlhaQkJucVRkREF6WWFyU1ZYcUVKQ1RrSm1OSDBZ?=
 =?iso-2022-jp?B?WSs5N2FIVzJjejZJMTdYdEpzbHV5N1pIbXYybjBubmRCamQ1NE1FcFJJ?=
 =?iso-2022-jp?B?NlBrMzNGb2RYK2hpeHBzR1FjT0x0V2wrVlUvRERWTHZCRmRxdUVWb3NW?=
 =?iso-2022-jp?B?b25uUw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+/zH1YfxsGK8RUj8JFhfsXineHuTnItc6QgjWMuhfdHW4P5dc22cEKu3fGUPBpC473a1G733S39e3xpSVXWYeyrBfWnOklNPsM2rPO7b3xs/n0+Fi6LrKRBnt8D80VfN5RIX75awlafer/MpNhWjsJ6n4FZftivFjWu52gPYCNbfyqD6qtQVVVf/kVqNiahtt5luQZd5CiLWwraE5SQZA1/14+GrrxYgiZhRJGALK8NxfLsEfjDvyfNkaf8nDqpXsOmx1L82eiMD1UA6rOhf2pNeremMN7WeASLJElUA9GCXlwk5d3/sW+loACpA0hSgc1sYmNqLzAPyJ7w8ENOj79Ad/2uuPdYHg3zFuPMVYD8oiVEmOybjzrrZHmuZ6DyI5gdqc3WottQA1CO75qMvL7y/gjAoGcUJZd5kSZVkhY5fn1QotF4Lu1bkRHdIYKolpewigJ7i86AZ5rKYu4oi4AxUdZ4DdRzL87Rj5D3V9BRiBSWlUHocx/m6wN1wwpN1pGeV/NlC5SUY7N6L8nQhZ1TinVA6eyAgXUKMK/I0iduJJqnjcok52wu7SS6YN8rkxiJ0GJfsirqV2SXrb862xoH+vpmOcbXSdKgUdnI6F/2K6FcE7qTqRttND8BoNy1L
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7d6f6e-d0bf-4b7e-4036-08dc52d983b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 05:55:35.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1VVbvhPu7R/zO4ETeovn4VxbzMmcK7gKX+1AZSoE8Gz1n0Nrr/Z1S8gqPqTCsMf8vQWVDiUdnjIkzwM3GWgyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10255



> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, April 2, 2024 2:34 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; da=
ve@stgolabs.net;
> jonathan.cameron@huawei.com; dave.jiang@intel.com;
> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com=
;
> dan.j.williams@intel.com; jim.harris@samsung.com
> Cc: linux-cxl@vger.kernel.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <=
yaoxt.fnst@fujitsu.com>
> Subject: Re: [PATCH] cxl/core/region: check interleave way capability
>=20
> Yao Xingtao wrote:
> > I used qemu to emulaute the cxl.mem and attmpted to create a 6-way
> > region, the region was created successfully, but I could not access the
> > memory properly:
> > $ numactl -m 2 ls
> > Segmentation fault (core dumped)
> >
> > I found the root cause is that the logic of converting HPA to DPA for
> > 3-way, 6-way and 12-way were not implimented on qemu side.
> >
> > But qemu has already disable the capability, so we should not create
> > region in such ways.
> >
> > So I think we should check whether the interleave way is supported by
> > the target while attaching it to region.
>=20
> Good find!
>=20
> Not only does this need to happen for 3, 6, 12, but it also needs to be
> checked to make sure the device can support interleaves on address bits
> 11to8 and 14to12 (CXL_HDM_DECODER_INTERLEAVE_11_8,
> CXL_HDM_DECODER_INTERLEAVE_14_12).
>=20
> As it stands the 'struct cxl_hdm' 'interleave_mask' attribute is unused,
> and IIRC was meant to support this capabilty check.
I will add this check in the next version.

>=20
> > Link:
> https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fuji=
tsu.c
> om/T/#r
>=20
> This can be trimmed to:
>=20
> Link: http://lore.kernel.org/r/20240327014653.26623-1-yaoxt.fnst@fujitsu.=
com
I will change the comment in the next version

>=20
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  drivers/cxl/core/region.c | 25 +++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..dde66b7c9e3f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1786,6 +1786,24 @@ static int cxl_region_sort_targets(struct cxl_re=
gion
> *cxlr)
> >  	return rc;
> >  }
> >
> > +static bool check_iw_capability(struct cxl_endpoint_decoder *cxled, u8=
 iw)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxled->cxld.dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +	void __iomem *hdm =3D cxlhdm->regs.hdm_decoder;
> > +	u32 cap;
> > +
> > +	cap =3D readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
> > +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, cap)
> &&
> > +	    (iw =3D=3D 3 || iw =3D=3D 6 || iw =3D=3D 12))
> > +		return false;
> > +
> > +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, cap) && iw
> =3D=3D 16)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int cxl_region_attach(struct cxl_region *cxlr,
> >  			     struct cxl_endpoint_decoder *cxled, int pos)
> >  {
> > @@ -1796,6 +1814,13 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
> >  	struct cxl_dport *dport;
> >  	int rc =3D -ENXIO;
> >
> > +	if (!check_iw_capability(cxled, p->interleave_ways)) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s with region interleave ways: %d is not supported\n",
> > +			dev_name(&cxled->cxld.dev), p->interleave_ways);
> > +		return -EOPNOTSUPP;
> > +	}
>=20
> In order to validate the address-bit capabilities of the endpoint this
> routine will also need the 'interleave_granularity' argument.
