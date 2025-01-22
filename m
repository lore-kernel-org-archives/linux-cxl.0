Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D41EB44
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507500; cv=fail; b=nKcPGjAxmNrqVeWde3KKIM33L8yHtQo+O1OwGtJvOFMDm583VD91pDJexOkyusoBh3ojxhTODgK1MPsgY+qyLNPsJdsNAYgiLTOycFfemUEHtQxC+/F44WWBCT9XR2kWE0aWU5k96c/ZYCxTBJr8e1a2uUwmA6LOAgiDWEfBqQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507500; c=relaxed/simple;
	bh=B+wSGjSPKFe+TXHy6UEnpG4mCn0h5gVwgzt8Mwy2w2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QblzD+qPZlh5kO76KShMDW0ptgcxqet3Tt9EGLgtI0J06EuKGIJNy4pN3xwj0FOl8pxMfxDwfiX3Kh5SfCLIT38eLOZu82MqaX553V4abPNW0hDcAwSVoeOzmJUWr1uEXjHLtT3rbuq/X/yJvp2VqZPcryH+LLaWJCR8Fmzm5P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eSyAQCbm; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eSyAQCbm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737507498; x=1769043498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B+wSGjSPKFe+TXHy6UEnpG4mCn0h5gVwgzt8Mwy2w2g=;
  b=eSyAQCbmcyWPztD0Q2H7qBgNedR50G3D9PZfo3bflj4MlC94Xckq6rZq
   zCzbUVGd3m4acp0pfpWqZZWZmfOSe0MH+Go79m3wTkL2CRe3m3Lk6DIOd
   NA50cy+TK2QfChZwzxUvEmzOTFQL3Sx3cLZtrI7iAtYu+CIkCloajPJnq
   fs12UJKm/vr43XGtVsCMPh691Ih39srDUkaTVigGvL4PiBYF8TzVYhLM7
   DhDc98HmXwpyaGrKC/npmpa365CzL+pVxAP2EYRNtu97E+UKFxPo7YEp7
   Mc5wAuaQv6WMVltg3M8xxC7prhSihX2Nb3tqP0ARtwgs6Dw0u01T8kLLr
   A==;
X-CSE-ConnectionGUID: borTFg5FR8GkYqfP8QzO/g==
X-CSE-MsgGUID: VFo3lSqyShOTt8kjBqXoMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="144526810"
X-IronPort-AV: E=Sophos;i="6.13,223,1732546800"; 
   d="scan'208";a="144526810"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 09:57:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP/mKbKzb7e2VZLE2oO4nB8IV00BR41xkLhpC0LWJPLvlYmIJYcdrQ2v5BT+jS/76kZN59FakIIx8aO/FaH9rZbEugTMF9y0sJPp+yj4D5yoYu/mkgBPuyGGkZCb0WW/g/vqpmUDL1o9CsLePS9OHEefm1H5sExgN1MLi4rC84i0rZ5x1XQEyiGsMtwUox2qAs0Jafo9gjYFVtJEe8s2yAkKAWU5b5EW6Tuv28x8Lxm8DPlDZUrU4dcAewKlw+ICU6bhIJKN19gUG0FlvP6vBAU39JINbWpG5sOpo0R1vweFaY8A2vzhQeXYClsBsnbOytsjEKysjn5BhUrfMDQ6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+wSGjSPKFe+TXHy6UEnpG4mCn0h5gVwgzt8Mwy2w2g=;
 b=deLSLfORdENS+Hmt/BvdLBXt6TRYpqiVEOt5Sk39W1+uaO6o36I8sD3Fgq3dd9PYWQLRnYTYOS3CB1R20MV8IkzQShwuhg/ulA+UuRMTv/kqQhI9cUhyKOJZC4f3x05HMl/qE2+I1abBAORHtxDALm8BvEIaQtbT07fFu5s29l+pesWWIMRk+5rFfxn/Oa0Q0uXCF+X0if77xhL+l4ohvkdBD7bUE88TFIqfVPMhIr63OurScUNTUu2yaxRItzpKZh8+9S7o5QdYUbCNc8tXRkp0DvqiySVifrJPrVUA41Z77Fcz2XEKN8eVIhuk9bO3TlGBwPOXrNMPXYRRlNcfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB13762.jpnprd01.prod.outlook.com (2603:1096:405:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 00:56:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 00:56:57 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
Thread-Topic: [PATCH 2/3] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
Thread-Index: AQHbaujLT8ojyn/IlEKaROJaJPs0XbMhU/YAgAAF3YCAAKFqAA==
Date: Wed, 22 Jan 2025 00:56:57 +0000
Message-ID: <c2008f82-f50c-4119-b522-6719e7390947@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
 <20250120030947.254930-2-lizhijian@fujitsu.com>
 <20250121145812.00004c63@huawei.com> <20250121151911.00002623@huawei.com>
In-Reply-To: <20250121151911.00002623@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB13762:EE_
x-ms-office365-filtering-correlation-id: 505a0576-10c6-4706-db0a-08dd3a7fabf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGJkUm5KTlZmd0wrT3lnZENTQUtsKzU5WFAvUk1rS3FHNE91aVpUQkhnUWhI?=
 =?utf-8?B?eEZERHprV2tYZ1Y4Z005Zi9CRlk1WjFTZHRLK0c3SWdrNFhVSHBOaTdmd1FB?=
 =?utf-8?B?Rm9VU2VON0hrS1RBOTBwOWJOcFRkZ1ZwZkFrekJEbDNoU29OWnBjQ0JVRG80?=
 =?utf-8?B?MmlqUk1xV2ZNd0w1WlJ2NkJSVENMTzRNaGhyVnJoQWlZbDhaczhlemRqQ2FG?=
 =?utf-8?B?T0NESDhhZXFXZFUxOWQ0ZUd2Y3l0SmdEcm44T2dQbndCVFcrZzIwS2FDL05x?=
 =?utf-8?B?QVNIS3UwV0NINHJmb3NQUVJTWERuTHBHbGhDUlc2SG1IWGh3Y01YYzZXVGZo?=
 =?utf-8?B?OTl2NzA0QXFjaGdjNm5HS3d0ZFIveXNMaUJQaFo4SHN6UTM2c0pQQk1SbSta?=
 =?utf-8?B?WDdoOFNEdXZnTlFTSm9takhsOXI2empQWVZsS2xEZ3F4VmdMdG5HRVN1WkI2?=
 =?utf-8?B?K1FrQWFzWDQwM0EwbVY0dTk1T05xRDFkNGpGUytybjBldE03L1NZdmYvb2pU?=
 =?utf-8?B?ODF0SkhQV0lsTkhyT1k0STlCbjVEa2NwWVU3aVptQVhMTVZHMFhjc2p6aXZp?=
 =?utf-8?B?VE9wSHRQc3Mxb1J2b1owREtFN094TTNUQWpvbm55bmNrV0dCYVV1VGpSQWtN?=
 =?utf-8?B?Mmt1Rk5hQVIrZGRBU2xGUEQzNnJKYnpsNTY0WWNBS1kydTlWZ2NmSUJTMGMw?=
 =?utf-8?B?U3F6ditkZTk1UjZHalpYNU5NNDdLSGhEeXU2cVpEcnZQMkIrWEg2bjluclht?=
 =?utf-8?B?ZnlWQkVXbStPZTlRTEY1Tkt5NHBiamNFK01YRkxFS1p4ZzM2aUdySGhsczF2?=
 =?utf-8?B?NTdXSTIyUUczSTY0Uzlad3pMOUlNbmFNUVZiSDhtb2p2clFhdklOTmlGZndO?=
 =?utf-8?B?Zk9zRnVnSTAvdFF4TE42dUoxYWxPbzNMQkgrY1YwNnBnakpDRDJOREdJKzlX?=
 =?utf-8?B?YUtPcmNTTU5sQ0J4aUJpd09ZWXpmc1Izd0JtVkRYOTI3SS9EY3V5ZVlqVW1S?=
 =?utf-8?B?YzFxaFhCeHJZK2YwTzY1WUlWOVpPaHhGc1NmL1V5TEdaUHF2cHRYT2Mwekph?=
 =?utf-8?B?Slp6OWg2ODhNZW10NE1yRGxaK3VwT3VQLzJGQVR2a2kzemtSZ0RBb3o0TXZv?=
 =?utf-8?B?Q1VubCt0Zno0WkJzc1BiQTZpVldzTmluTTliWGE1RWREajZjNGxMVXAxaGo4?=
 =?utf-8?B?NHl5aTJvRG9qVlVJRWEwTGkyQ3ZVTHI0TllYdUtCcjdBbU95NGY2ZVY5ZDc5?=
 =?utf-8?B?WDRRUklTeEZtcnpVSXRWZFo5ZGFOWVk0cldNcS9SS1BwSW1YWkw1T1FvQW16?=
 =?utf-8?B?MzR2Rnl1MkJ5VWZIQmVCTWYwemxMUFRZdmN2bFdGOHN6RFRDTHM5V05CajJ2?=
 =?utf-8?B?Qm5KdDc3dFhTY2ZTNnlkSTlxdHpvMmZvSndzUS8yN0dicDAzYkVWWHU1Y2Fx?=
 =?utf-8?B?L2FuQmhrYVR1MkRCN0ZLbDdqQmlGN3NYNnhLb2ZRS1h3VkZqeTdLVUtSTXlZ?=
 =?utf-8?B?bFp6SkQ2bDArMnpyWE1Rd3ErdVpFM2JiZFdNRUEwMXBUQkxYbDQvTHhqS3V3?=
 =?utf-8?B?QkxXSFJxRlVHdkROY2V4bit2QlkvNGhmZEg2OFJNSGFtVjYyYmFOQy81YmlX?=
 =?utf-8?B?eGx5R2tUQ1owUExGcFBpZVh0N3BUTjU4UkpyY1IzOElVc0N4Q2x5SHVEamx4?=
 =?utf-8?B?UXRUQ3V0Y3plTjJCeGlQWmVTcHE4Yy9zRHNNdm1sOG5FR2x1OE1WUHVtL1I2?=
 =?utf-8?B?ZjI0RWxiSTVGV3JKRGJBTFlTdGFmOWU1SE41YWltc1M2YzhrdEQ4ZjJncjRh?=
 =?utf-8?B?K1l6a3ZwbGVYRWZ0aG5jeThiS1JUNjBJZFpQVDlHUStkajJGSzdNZWhGa1F5?=
 =?utf-8?B?VDFNYjVYQXhEdjJleUxxUGQ3YVRkVWl1aTYvSFMrNkJSb29tUlRKYjlZWm82?=
 =?utf-8?B?UWRjSmQxbW83NjJWUDhPc2pQRXpEM25KWXhUaXIza0ErS2tLNENURkxYb1da?=
 =?utf-8?B?Z2NRY1JHQUhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1JzYlVQMWJkTy9xbzAzREhnVWpLcEgzSDFjdnJyM3VNc1E2M2VubXVPbmZ3?=
 =?utf-8?B?endsRzFJUGN6YlNDUGJBYnVFMnMzTDRtUDIyc0lvdDlJMm1XSEF6UUtweG1S?=
 =?utf-8?B?QW5BS2dZanJad3lvWUwyUFV0M0JKM2NwTlp1cmpvRkdxMDdVMkQ0YWRJNWcz?=
 =?utf-8?B?RlRZeTUxUThkWE5VRUNiMlNXQkJLYzRhWWZKYW40cmhtd2Zibko5eEczamxN?=
 =?utf-8?B?TGVxOUxYdHRVSW1mZitCbTd4UTdOOGliamxXcW4xdGtoTFVWc01rUFlvcFJR?=
 =?utf-8?B?eFFoWU5FRXlJUDQ4WnpnZXhlZ2J5NmN4WVlhR3E0aDNiL0VxSEtoSk9Rc1Aw?=
 =?utf-8?B?MUJjbE5RUHNhY0ViZWhhNm5GVFJBYWpHbFQzZkdCZmpnUEJ1UVdaZlRQa1RE?=
 =?utf-8?B?RTVxaTdVeXhMMENjN2NjaG5BM3R5UlVoczdOZDllaGRsWjdKZDRGblNBa3dB?=
 =?utf-8?B?VjcwODhFYWlpaCtzV3NEQzhOVTY5alpLQXdWTDJmSURLL2lzWTlwZ1pEUGJJ?=
 =?utf-8?B?alNWSzVqbHFEYjY5Q0tVOW1hS0hjWXl0Z0hXOTFMTWVJdEYzMzVIUVk3RHBB?=
 =?utf-8?B?c3grY2xNcWw4RFd0UllsOHpZdHFES2lRc0VrV3RaRVRXOGZ5bXZqNmxnMXNm?=
 =?utf-8?B?V01LVEIrcXQzODJyeTlybWFlamFlaXBJRyt5K0dWU09CeDkxK1hTem83SjR2?=
 =?utf-8?B?ekJ1ejRldnZLY2puUW9QWG41VXd3NkExVTk0N1FqN25wMGVrRVhvcTVBZ2tB?=
 =?utf-8?B?dmpTTVE4d2t3ejNxanl0aklRdHF5NENJZXNpSVBTN3RlT3J1QWt6ZlNsUktR?=
 =?utf-8?B?TXVONndzaW5jelpGekl6VEd6TE5SbWxDNlU5Qld4M2tvTW9XL2YrQXd5Ykdv?=
 =?utf-8?B?andUcFNQemhvdWRCNFVobFVaN1ZVY09tbUJlMnNFQThSbFFXSDBXZDc2R2tt?=
 =?utf-8?B?M1VhaC9wanVETWQwS2pPZmNoazBBOG80TzRuODhnVnVCVGNWcmJBZWpzS09T?=
 =?utf-8?B?R05GcVVsaENadk9RTExXdkxWcHJmVFNCMm5vdmlhbVAvdnQ4ZjJ0ZEhPZzRi?=
 =?utf-8?B?dHZQK1hxdXVLRkhDV3ZXNXVLZmhKcVcycUJzTE8yUVArY0c1ZmgwazVRRVd6?=
 =?utf-8?B?bC9qaVJNWHZjaDVOWnJHcGxSUk8zbm5TV0NmczFRci9UREZqb2FKdUZWNXJF?=
 =?utf-8?B?NnlVaGpGT1lwTU0wYWEzZTZHUkJJY251V3l0b05hMmgzNTVEdUZoL1dhTXI4?=
 =?utf-8?B?U05hRFR2a0wwOWxOaDlWZ0dnTVhJa256cURMdHNkRWFYZGM5bGZockNwWFJQ?=
 =?utf-8?B?b1I4eW9GSG5yQi8ydVRldll5RGx3SEhIT0QzRTZoSFhMa0l6MXdvdWVlZGFJ?=
 =?utf-8?B?dTVMS2RxYk1PMUdPVVZZaXBQSTVmM1FSTklSVnJ5TjJsSVZlN3BadXZ3bWJi?=
 =?utf-8?B?Lzloek9MNTE0dXFZVVNieXNoL1dVNmxIV2VTQTFBczV0bkNPeEtob0NWOHlF?=
 =?utf-8?B?VzF6cGdsbnloSHpMeDVoZ1kzTGxQdGhMcFZtTURSLy9kUXVia1QvKyt1YXpW?=
 =?utf-8?B?bFNGbXRsc2lJckE3QlNxTFcwblYrUGhYeVV6THZsSlRWYW5qSi9qYUZ1cEFG?=
 =?utf-8?B?cS9jTXJWdWZhMktObEkzWXI3dWxtNmhNNGt3VHp6aG9CVTdMZFp4aHBYRnY0?=
 =?utf-8?B?Y0FGdFE0QzBjc2lYNklHYURZOUh5WWIvSTdDdlVBOEQyTXNBNGtqNkZvNmk2?=
 =?utf-8?B?RnJDcUxUTEIwZjQyZm5peVNLSmdER1lDZklHNUFDYUJrd2NCQml5Um5ac3pw?=
 =?utf-8?B?M1hNZnJpT2F2ZG9iV21GaVVsUnp3NXFIcEYzcjNrc1JZSFg5cDRLZG5TZjhU?=
 =?utf-8?B?OEdDWWJoN25SQTIrWnZ1allJWVN3VFdrUlYvZnV1NGNYcXJQMThtcmkzOVd3?=
 =?utf-8?B?Q29RMWNHVkMzS2FnK0lGREhBdDZ0ODJPbCtaR043ODlWTXNTUXZVRDhFVnQ3?=
 =?utf-8?B?a040R2JaTGFLSWY3aFBlMzYrZi9EWC8wcXNobmRPb3puemVMOW1qV3B5TFc4?=
 =?utf-8?B?a1ZISXJVcVYxYUwvTXJCUzdadjZWSElWNkZPY0dQVjR3REFXMFdWK3hpVndZ?=
 =?utf-8?B?dy82NkZxNlkrSEVTQTV0UnRmd2QrL3l0eDZ5ckFuNzhWOTBrMHU3VEhpb2tT?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF0414B7613F144485EC47740CEEA379@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bfZ3LzdnN5dK0ZwonVLQ1+Ir/NLPiX//1+GK0+OFM5JV7rC79DqLlZ2qKWbLlxpBqKe4brBnGcL/Ba/I7OszkPhW3IEVgDBkYte0cvEHDMVMufgNAcsjHypqXA3AZ/onLHCwAsTb5x2Z7kI1hin0xFw4s5qf2G6Rv60C8bmgICaK0ApFQGnhVrjSjcLKaHmf3rbRBxCbuk4ndyeGE4w0joywSpqX5hzJGgrUfWcliBgoD5yHhNAprtf+7O7WHQj42VvKT1S9YO3zeFEeW4BRp7AUJ8sQ2iIThgE8lERl3BruFL2ZUG0CvgCtR7FJyCrQRjxzad5t2RUanyYqMeVnAxCJ/hD2vSA3dJBf+LDNKALNhLiwLyGR/oCAzV52yZRx8p5b3DNKuqPqyW0IxxK1Z2uN/TrBbHjt2pO47CUXn2mrFi+hz6Em2GMBikyXmSgAzoVCWM1Pbz7HC8YWHl2KNKHsi3f+juOvcVhuMGw7G1JGzQEzEgQTXlT/Y4MPPcynzE3A/xy7v2neKLNk6RCrQHIx0G2NaKXvHJmox8Y15RD46PuGiacegAXrLvdJbctCj5XKyknX+UR/IVlTh9aicr4PZf9QlOECLSp04omVUoATbCyfu5NAE/mLCkdeWAcJ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505a0576-10c6-4706-db0a-08dd3a7fabf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 00:56:57.6344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBv5z6lBzFvvMvr0sKLvCirdtZUmnL+4ZuqPOM6eyF4eP21RPkk0RVh3vFEKjaxgXfSUt6k87I/2fy2t12m6/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13762

DQoNCk9uIDIxLzAxLzIwMjUgMjM6MTksIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+Pj4gLSAg
ICBtc2l4X3VuaW5pdF9leGNsdXNpdmVfYmFyKHBjaV9kZXYpOw0KPj4+ICAgICAgIGdfZnJlZShy
ZWdzLT5zcGVjaWFsX29wcyk7DQo+Pj4gLWVycl9hZGRyZXNzX3NwYWNlX2ZyZWU6DQo+Pj4gK2Vy
cl9tc2l4X3VuaW5pdDoNCj4+PiArICAgIG1zaXhfdW5pbml0X2V4Y2x1c2l2ZV9iYXIocGNpX2Rl
dik7DQo+PiBUaGlzIHJlb3JkZXIgZG9lc24ndCBsb29rIGNvcnJlY3QuDQo+Pg0KPj4gU2hvdWxk
IGVuZCB1cCBJIHRoaW5rIGFzDQo+PiBlcnJfcmVsZWFzZV9jZGF0YToNCj4+ICAgICAgY3hsX2Rv
ZV9jZGF0YV9yZWxlYXNlKGN4bF9jc3RhdGUpOw0KPj4gZXJyX21zaXhfdW5pbml0Og0KPj4gICAg
ICBtc2l4X3VuaW5pdF9lY2x1c2l2ZV9iYXIocGNpX2Rldik7DQo+PiBlcnJfZnJlZV9zcGVjaWFs
X29wczoNCj4+ICAgICAgZ19mcmVlKHJlZ3MtPnNwZWNpYWxfb3BzKQ0KPj4gZXJyX2FkZHJlc3Nf
c3BhY2VfZnJlZToNCj4gVGhpcyBsYXN0IGxhYmVsIGNhbiBnbyBhd2F5Lg0KPiANCj4gSSd2ZSBh
cHBsaWVkIHlvdXIgc2VyaWVzIHdpdGggb3JkZXIgbW9kaWZpZWQgYXMgaGVyZSB0byBteSBDWEwg
c3RhZ2luZyBnaXQNCj4gdHJlZS4gDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgYXNz
aXN0YW5jZS4NCkluZGVlZCwgdGhlaXIgb3JkZXIgc2hvdWxkIGJlIHJlYXJyYW5nZWQgKEkgc3Vi
bWl0dGVkIHRoZW0gaW4gdGhlIHNlcXVlbmNlIGluIHdoaWNoIEkgZGlzY292ZXJlZCB0aGUgaXNz
dWVzKS4NCg0KDQoNCkknbGwgcHVzaCBvdXQgbGF0ZXIgdG9kYXkgaG9wZWZ1bGx5Lg0KPiANCj4g
VGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+PiBldGMu
