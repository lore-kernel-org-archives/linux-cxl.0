Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88EE484222
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987688; cv=fail; b=orOuggIGFnScBtJrrv/yUrznrjSzfdAt+PZVFQuvYItE6iKnNuHNgSqFpyN/THodAx57e8brBN5xYpVwz+iVnzY6OZ7Z8TYK3EIx5Cp7tk+sPyt6f3r9WeN55JpNCmEX7XYOoCrV+dJrVSREhOopvsEnidqG0yql+GecjHC2YHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987688; c=relaxed/simple;
	bh=8MBoMQqFassYWlmS/quD3DsO1ME9GvUGSujjuo8Z8nA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BRVOtgynGuwa4Bp00ggEwwT2/mSOa/0pK+5UK6O1Aewo/4D9Id372IqfPhK29x5yoQkQGuUMegJJSTVAPyo2zf4rqXyys03zfLwWyhLZvdWkpVLoi9mDMegAzw00p8/FGLZN7A4aNYiZ4myRC3H6VmxrHEZjxyIXDGZDHj8kA10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4JefOK5; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4JefOK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7x+x80SjyDzZXIs1k1yqkMx7IM5UfzrdxmxwFl3m9R4VEQPijeqC/VuPi+Y9etLrB8g3C8dy/NbJ0WatmbXnf39PuFFmSKrI6qTYEkf2SY2u7vI+DbVCOWMvmXl7nO41DpkZBy7XmXUuWslCiTbf3+5khhoCuOClwJyNndIpp6X+NA49jtPAsgNL9CenrfgCNKdOM1VzXeIqTpdSpg3wpR3CRoCBcf4y1SJ6tnkm5vY6fvPC0nIqKg718ty0a8QQRlXwBaHR7F04iLZWM/cgSvbClOS7/e8Laq5wEsOn++aHFMcXoQ2qYrcaa0ps9h9o/gmpoXOSvokjQaolcK8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MBoMQqFassYWlmS/quD3DsO1ME9GvUGSujjuo8Z8nA=;
 b=PW7jUyEIW0o0MDxqJs0O8am4blLL1q7l4t7hN6DXW9jGOkHfB3UQgbaqK75tQIn/GvjTja6RAkxNx6NnF0+tZRNmFyljS/aqsH2D00eUgduWv14o+jCyUTcyKB5J2y34EGqKoUytzMRp/2+Y1MHIa9oZl/vv2C/anzr17uTDE55AzaJdKGjPbEMNBY1hCVM8ysEsXR/vBC8+mhj6tDBMnZJHHwGMmmdHpqG8IcVxveKIbIyt1f96ysOsBzlVNvC88IBvjBGJT4z6lGrEg8gxA+YvZ51iyw6EerhkBvu1uYaZyPfjl9jR3I3UKqEQNfAjidbA90lRjmQirqCPO4lK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MBoMQqFassYWlmS/quD3DsO1ME9GvUGSujjuo8Z8nA=;
 b=t4JefOK5VB3IHfk0JqEXXWIovF0a0EEUO08SP5r4X1jZbnFeB2xoUsJbuXiyxcN5+N14rkzs4Rvo9A9xOWEsYqae3GFezKgvqPe6g2SCg9BNGpH3Fhy1vO52qRtztBPU2Tiou2YpdeAyfGdLa63+mvQhaSZDlZ1KguNIS4Vfue4vt4QNLRDFNz3sXHJUDPZVZNI48ciqzvMp+JRm0syS9FhGoLOGWMVRj7bTnKhQa+Xzx6cv78zj5HaaQHcqGIcUcq8x9vLDrwQqwMJqZtA+BMZsTbMdV0EgVPsRIUkzU6VMPruR8Wt/thCKQrJQrB0Sckdl73htLQALUoXiG5vPuA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by PH7PR12MB6719.namprd12.prod.outlook.com (2603:10b6:510:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 10:48:01 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:48:00 +0000
From: Manish Honap <mhonap@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "alex@shazbot.org"
	<alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "pierrick.bouvier@oss.qualcomm.com"
	<pierrick.bouvier@oss.qualcomm.com>, "mst@redhat.com" <mst@redhat.com>,
	"imammedo@redhat.com" <imammedo@redhat.com>, "anisinha@redhat.com"
	<anisinha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
	<peter.maydell@linaro.org>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v2 02/10] hw/vfio/region: Add vfio_region_setup_with_ops()
Thread-Topic: [PATCH v2 02/10] hw/vfio/region: Add
 vfio_region_setup_with_ops()
Thread-Index: AQHdRguE0sPWXaBaQU27jPI8wwRcOLbSxHuAgAYca+A=
Date: Mon, 21 Sep 2026 10:48:00 +0000
Message-ID:
 <IA1PR12MB90300DCB56D5046118FD3321BD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
 <20260916184412.3825713-3-mhonap@nvidia.com>
 <3d799d0d-1365-4bbb-a159-c8d926f2863c@redhat.com>
In-Reply-To: <3d799d0d-1365-4bbb-a159-c8d926f2863c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|PH7PR12MB6719:EE_
x-ms-office365-filtering-correlation-id: 97b7aa17-909b-462d-019b-08df17cdce6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021|4143699003|921020;
x-microsoft-antispam-message-info:
 RXvgOK6zsxttVuO6NFfU5nypVX9HP9lyvVHqliQr7mr+XiSULagMTLEBqXn2kay3aD3kOh2PfJiVEA3Yohc2p3shbLizVNKdvJxNcBMh+uE7SWhG9kpUC9GdbWWHLpHDfpAt26ikfte5TpmmUjndbiY1NNzvV00WCsp1NNVUISOCfFFEDC+hUXcadN6NlcLT78+FsDOX6tx0liM5U8kOhmT9ukMKqg4TmFuZkvi+94MOBeqYaHthxIpTPU2Z/cUZ4TcmEw5EZxep3TjL0rr5HYOce7eq3A1ZKRC7W9aSt4mcQmqGIoOJj4IP2+ftBILQnvpRTxAiOrKyiGj7MMDuOfu8g5F8qc/ExQODv3DMXy9ZN9CgrOMxNoHCMKCvQque3exG+/GB/Q0j3Fw22ush5jvFGpOaba1uJmyeoAVwAPqDURHCr1AwP3fXGy6S1PmwGTIqbtVJbVWcEZtMzK+HLxuv+0G+F+deXJDmpj749+9tRUK9srPVcKFK5z/TpCeIYRCEK8XcVh77ouOXELxaB0oCUyrJnb3FLFEWgTBznHOTnasylumg/nT1nMLxj8Ka/V9tyWU61MeHJTo9Ioqlgzfsjc2YQyfJNJRkPCJ2hjJ53i1uNKXpuk2PjWvL+DjdZuMAb/bk7TfQ7aJarlDHXPCkOxWnu/va2D+ADbHl+s1rkI8j68n+BE52Yv6TC9tkVfmpxfwfjocafMR88IlV6c0HmaAsx0n7kstx/nuLDUSWWtWy6L7U+hJmYnQj2eG1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021)(4143699003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2FQVllNS3FBTUpVRlY0WWdEZU5oMFZlekY5UG5EUmVtT1VxMzNPY1NEYzBS?=
 =?utf-8?B?dFVEcTBtV01EV2ViYkxoY3RFc21VTnNBMGdqTzlESHM1cmV6ZE16TW1DVDgw?=
 =?utf-8?B?T3dBT0R3QjFFTGo1RzNna3hYa3dNd01YWjltaUxkaFJKMk5FUGNqVXJETXNk?=
 =?utf-8?B?cVdnbUlqYXVUL2t5cW5YWXdkd2ZDRmYvTXdaZmIyMkd6T21GalhLRFRPTi9K?=
 =?utf-8?B?TXNEemZRbmFDd09yWnF4M2ZrYXJqNjZ5VTJNSUxIN3l4Nm5LY1FySkhiLzcx?=
 =?utf-8?B?VkwzbmR2bm9Fcm1ETFBxcWxIZ1Y3bWo5aGNaOEhpQXRHZXNxdmFCdWZlb2lw?=
 =?utf-8?B?Mlp2N3pDZTFLVDdsQ0ZwTEZ6Tm9Ta0xsaXBFQVI2ajRsN2pNaTBnclJnSHlX?=
 =?utf-8?B?T3o0RFljUi9EcDR2eklhVHcvZ0QralRkei8zNEdrMnVwVGtseTNkZFBwaW50?=
 =?utf-8?B?MXVzcXhjZGh6cFFkMzFQOUp3a3NIbDNSenVaM1RkWm45a3lMSFRrSncyZGlS?=
 =?utf-8?B?ZGxSanRTUDZJNFJBVW5JaWNTOUpEUEpKRlZXN1NGbG5YS042MkFMUm5BQkhn?=
 =?utf-8?B?VTR4MDNFRThPVkludmpmK3UyYy9SYVNPcEdLQmVwQnI1bURNc0Uzb3I5c2Iv?=
 =?utf-8?B?QW5LT1FzT2RCaHUwVGM2NFRTNm9IdkY2SkxLcHgyUlM1U1VodDk5N3BtQzU1?=
 =?utf-8?B?UURNL3F3U3BYcG5OcWJiSEY1bVF1L2wwNDFwWWJWVHk4RVJKeXBKZE9MNTgx?=
 =?utf-8?B?REQ5SDBHR0FaOFpYNGEvYVRETFpsSUFQRkgwSW85Y2ZPSDJEdUVBd3hGMnJD?=
 =?utf-8?B?Q1BUWGlrVzZsbG0wNUJvQnJzRExLOUpOa3NVOG9LWEk4c3pvMWhwQkZaalRO?=
 =?utf-8?B?NlZMaGFid0JVS1B0Z3ltWDNtSUNpUUltNVVOWG94UkRPdHZVRXFubUtqWUZ4?=
 =?utf-8?B?bWdoTFR2TE4rRVZHcEhNcWtNZzgvaGhzWi8vWnM0UWNCQVRydzZRRHViSGg4?=
 =?utf-8?B?VnkzODBNQlZoQ2Mza2d4TElvVkZKbjhvSEZ6aXMwWjlCMWlNK09yQkFsYVI5?=
 =?utf-8?B?azJGaGhVdkJFQlVIdUNiSkdPYzdLMDNUOWIrM3kyL25sMXhKc01BK0pYV0Mv?=
 =?utf-8?B?alF2OXBzNVlwZ0JkOEtXTlppYUlpVkdrQWtlcEUrN2cvN01Ha0lqdFdTWEty?=
 =?utf-8?B?SnlOQ0lkc3RFTkFyL1ZrMDdlekdZcFd5TUZPMVJwWnMyYUxrOVZxazYreVc1?=
 =?utf-8?B?UytiWWJEckhYSEZLeDlJS3dCUzhRZkxxT3lIcXh2d1dmeW8yc2FUN2tXUU81?=
 =?utf-8?B?RUtQNnlhUnVTQVpuYXRDaTY2MldJVnJSM2VTOU9KcGk5QXRRT1hzbkJ2bHIy?=
 =?utf-8?B?RW5UVXNHUGJGQ2hoeGhxaGtnQ094RjVhY0k4NUowL0Q2amJxbXd5SVd0U0E4?=
 =?utf-8?B?bCs2UEZqbjArN0VEWWtvZXU2Y3VFTHMwSXdHaUlJcEZJQTd1dUpCemZOc0J4?=
 =?utf-8?B?ckxkYU1EN3dlb2JFVy96bVpVS2U5SVRvZElxRFV3TmVsci9Ub3I4eEJadTlZ?=
 =?utf-8?B?VjFyaGJLeFNkUldsZzJvbk5BWEtrY3BvazgwZmRIdHpNLzdERlR5NmJBTi9y?=
 =?utf-8?B?TUNJakE5NUdOcTRlOVNCTVo3cU15Wnhsd2U5T3hSbGw4NXI2bmNTWTZlRkE3?=
 =?utf-8?B?cVhrUVR5RHFXS2hzOGdIbUlmQVc2UVluNlJWTzA3c0pPVlhIOWM2bklwL0Z2?=
 =?utf-8?B?dWp3MU9PbS9NK0wybmZpeWx2cWp2ek8vTmt0SGd5TE5UcVRteWpwTGFMUzdN?=
 =?utf-8?B?Uys4elJRc0ZRcHJtOWNDZVkyazYzU3dNb09rWXVSWkE1dWZTOHpJV3FXOFZn?=
 =?utf-8?B?RzZaM1o1MkhEaDJUNWViaWdNTktlRS9yL3VhbDFpS0VidzNJUEVlS3A0WkdN?=
 =?utf-8?B?MkM4RG9INE9yVUFJY1ZJUGcyYSt6UC9SRjZYQVVYOHpFN2lTbjR1dHdzVjZi?=
 =?utf-8?B?WUt6cDFoNGJJcEJYVFdmV1BVOTFObzJlaVRjRjc1K21Yc0JiTkdsZCtRV095?=
 =?utf-8?B?Yk5vN05IbFBRamdGOWh5YmIzZUNiTEMwQk8zSzQyaU82NEd5eXgrQmY0NFZR?=
 =?utf-8?B?WlphOWpxWkltOVJiREtqZlh5YkhuaW1WWkQvbjZrQ2ZNRlVZVTZCNXl3SUlj?=
 =?utf-8?B?bVJsZk5sS0VxUk5tOVBKdWFPY0ZoMTJZREI1NDhBbTFEOVVJZXhSMURzV3BN?=
 =?utf-8?B?U041NGxCZ2JmbVJnK1YwS2hXWTdoUk51Um5UWTlYaDYzT010WVAvZFpSNHJn?=
 =?utf-8?Q?roZ07e4AU0hEOaBGg8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b7aa17-909b-462d-019b-08df17cdce6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 10:48:00.8706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsJIIMLB89E0j2TfBOOeXJBqysAbrJ1R1cucjUBNwvA6D3kbEDz7DJ6PyQQshOv4H+fhsaixsvXWDebFKnZbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE3LCAyMDI2
IDY6NTcgUE0NCj4gVG86IE1hbmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+OyBhbGV4QHNo
YXpib3Qub3JnOyBBbmtpdCBBZ3Jhd2FsDQo+IDxhbmtpdGFAbnZpZGlhLmNvbT47IGppYzIzQGtl
cm5lbC5vcmc7IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPiBhbGVqYW5kcm8ubHVjZXJvLXBhbGF1
QGFtZC5jb207IFNyaXJhbmdhbiBNYWRoYXZhbg0KPiA8c21hZGhhdmFuQG52aWRpYS5jb20+OyBw
aWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb207DQo+IG1zdEByZWRoYXQuY29tOyBpbWFt
bWVkb0ByZWRoYXQuY29tOyBhbmlzaW5oYUByZWRoYXQuY29tOw0KPiBwYm9uemluaUByZWRoYXQu
Y29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4g
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgY29odWNrQHJlZGhhdC5jb20NCj4gQ2M6IEty
aXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+OyBWaWtyYW0gU2V0aGkgPHZzZXRoaUBu
dmlkaWEuY29tPjsNCj4gWmhpIFdhbmcgPHpoaXdAbnZpZGlhLmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8xMF0gaHcvdmZpby9yZWdpb246IEFkZA0K
PiB2ZmlvX3JlZ2lvbl9zZXR1cF93aXRoX29wcygpDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDkvMTYv
MjYgMjA6NDQsIG1ob25hcEBudmlkaWEuY29tIHdyb3RlOg0KPiA+IEZyb206IE1hbmlzaCBIb25h
cCA8bWhvbmFwQG52aWRpYS5jb20+DQo+ID4NCj4gPiBBIENYTCBUeXBlLTIgZGV2aWNlIHRyYXBz
IGl0cyBIRE0gZGVjb2RlciBibG9jaywgc28gdGhhdCByZWdpb24gbmVlZHMNCj4gPiBjdXN0b20g
TWVtb3J5UmVnaW9uT3BzIHJhdGhlciB0aGFuIHRoZSBwYXNzLXRocm91Z2ggZGVmYXVsdC4gU3Bs
aXQgdGhlDQo+ID4gc2V0dXAgYm9keSBvdXQgYW5kIGxldCBhIGNhbGxlciBzdXBwbHkgdGhlIG9w
czsgTlVMTCBrZWVwcyB0aGUNCj4gPiBleGlzdGluZyBiZWhhdmlvdXIuDQo+ID4NCj4gPiBBSS11
c2VkLWZvcjogY29kZSAocHJvdG90eXBlKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBIb25h
cCA8bWhvbmFwQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gICBody92ZmlvL3JlZ2lvbi5jICAg
ICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgIGh3L3ZmaW8vdmZpby1y
ZWdpb24uaCB8ICAzICsrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcmVnaW9uLmMg
Yi9ody92ZmlvL3JlZ2lvbi5jIGluZGV4DQo+ID4gNTRhZDExYTZjOC4uMjFiNTQ5NzhiNSAxMDA2
NDQNCj4gPiAtLS0gYS9ody92ZmlvL3JlZ2lvbi5jDQo+ID4gKysrIGIvaHcvdmZpby9yZWdpb24u
Yw0KPiA+IEBAIC0yMjgsOCArMjI4LDkgQEAgc3RhdGljIGludA0KPiB2ZmlvX3NldHVwX3JlZ2lv
bl9zcGFyc2VfbW1hcHMoVkZJT1JlZ2lvbiAqcmVnaW9uLA0KPiA+ICAgICAgIHJldHVybiAwOw0K
PiA+ICAgfQ0KPiA+DQo+ID4gLWludCB2ZmlvX3JlZ2lvbl9zZXR1cChPYmplY3QgKm9iaiwgVkZJ
T0RldmljZSAqdmJhc2VkZXYsIFZGSU9SZWdpb24NCj4gKnJlZ2lvbiwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgIGludCBpbmRleCwgY29uc3QgY2hhciAqbmFtZSwgRXJyb3IgKiplcnJwKQ0K
PiA+ICtzdGF0aWMgaW50IHZmaW9fcmVnaW9uX2RvX3NldHVwKE9iamVjdCAqb2JqLCBWRklPRGV2
aWNlICp2YmFzZWRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklP
UmVnaW9uICpyZWdpb24sIGludCBpbmRleCwgY29uc3QgY2hhciAqbmFtZSwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBNZW1vcnlSZWdpb25PcHMgKm9wcywgRXJy
b3INCj4gPiArKiplcnJwKQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVjdCB2ZmlvX3JlZ2lvbl9p
bmZvICppbmZvID0gTlVMTDsNCj4gPiAgICAgICBpbnQgcmV0Ow0KPiA+IEBAIC0yNDksNyArMjUw
LDcgQEAgaW50IHZmaW9fcmVnaW9uX3NldHVwKE9iamVjdCAqb2JqLCBWRklPRGV2aWNlDQo+ID4g
KnZiYXNlZGV2LCBWRklPUmVnaW9uICpyZWdpb24sDQo+ID4NCj4gPiAgICAgICBpZiAocmVnaW9u
LT5zaXplKSB7DQo+ID4gICAgICAgICAgIHJlZ2lvbi0+bWVtID0gZ19uZXcwKE1lbW9yeVJlZ2lv
biwgMSk7DQo+ID4gLSAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKHJlZ2lvbi0+bWVtLCBv
YmosICZ2ZmlvX3JlZ2lvbl9vcHMsDQo+ID4gKyAgICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lv
KHJlZ2lvbi0+bWVtLCBvYmosIG9wcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZ2lvbiwgbmFtZSwgcmVnaW9uLT5zaXplKTsNCj4gPg0KPiA+ICAgICAgICAgICBpZiAo
IXZiYXNlZGV2LT5ub19tbWFwICYmDQo+ID4gQEAgLTI3Myw2ICsyNzQsMjYgQEAgaW50IHZmaW9f
cmVnaW9uX3NldHVwKE9iamVjdCAqb2JqLCBWRklPRGV2aWNlDQo+ICp2YmFzZWRldiwgVkZJT1Jl
Z2lvbiAqcmVnaW9uLA0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK2lu
dCB2ZmlvX3JlZ2lvbl9zZXR1cChPYmplY3QgKm9iaiwgVkZJT0RldmljZSAqdmJhc2VkZXYsIFZG
SU9SZWdpb24NCj4gKnJlZ2lvbiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIGludCBpbmRl
eCwgY29uc3QgY2hhciAqbmFtZSwgRXJyb3IgKiplcnJwKSB7DQo+ID4gKyAgICByZXR1cm4gdmZp
b19yZWdpb25fZG9fc2V0dXAob2JqLCB2YmFzZWRldiwgcmVnaW9uLCBpbmRleCwgbmFtZSwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdmZpb19yZWdpb25fb3BzLCBlcnJw
KTsgfQ0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogTGlrZSB2ZmlvX3JlZ2lvbl9zZXR1cCgpIGJ1
dCB0cmFwcyB0aGUgcmVnaW9uIHRocm91Z2ggQG9wcyBpbnN0ZWFkIG9mDQo+IHRoZQ0KPiA+ICsg
KiBkZWZhdWx0IHBhc3MtdGhyb3VnaCwgc28gYSBjYWxsZXIgY2FuIGludGVyY2VwdCBhY2Nlc3Nl
cyAodGhlIENYTCBIRE0NCj4gPiArICogZGVjb2RlciBibG9jaykuIEEgTlVMTCBAb3BzIGtlZXBz
IHRoZSBkZWZhdWx0Lg0KPiA+ICsgKi8NCj4gPiAraW50IHZmaW9fcmVnaW9uX3NldHVwX3dpdGhf
b3BzKE9iamVjdCAqb2JqLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFZGSU9SZWdpb24gKnJlZ2lvbiwgaW50IGluZGV4LCBjb25zdCBj
aGFyICpuYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgTWVt
b3J5UmVnaW9uT3BzICpvcHMsIEVycm9yICoqZXJycCkNCj4gPiArew0KPiA+ICsgICAgcmV0dXJu
IHZmaW9fcmVnaW9uX2RvX3NldHVwKG9iaiwgdmJhc2VkZXYsIHJlZ2lvbiwgaW5kZXgsIG5hbWUs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3BzID8gb3BzIDogJnZmaW9f
cmVnaW9uX29wcywgZXJycCk7DQo+IA0KPiBpZiB5b3UncmUgY2FsbGluZyBfd2l0aF9vcHMoKSwg
eW91IGhhdmUgY3VzdG9tIG9wcywgdGhhdCdzIHdob2xlIHBvaW50Lg0KPiBQYXNzaW5nIE5VTEwg
aXMgYSBjYWxsZXIgYnVnLCBubyBuZWVkIHRvIGhhdmUgYSBmYWxsIGJhY2suIE9yIGFzc2VydCgp
Lg0KPiANCg0KT2theSwgdW5kZXJzdG9vZC4gQSBOVUxMIG9wcyBoZXJlIGlzIGEgY2FsbGVyIGJ1
Zy4gSSB3aWxsIGFkZCBhbiBhc3NlcnQgb24gb3BzDQphbmQgZHJvcCB0aGUgZmFsbGJhY2suDQoN
Cj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0
YXRpYyB2b2lkIHZmaW9fc3VicmVnaW9uX3VubWFwKFZGSU9SZWdpb24gKnJlZ2lvbiwgaW50IGlu
ZGV4KQ0KPiA+ICAgew0KPiA+ICAgICAgIHRyYWNlX3ZmaW9fcmVnaW9uX3VubWFwKG1lbW9yeV9y
ZWdpb25fbmFtZSgmcmVnaW9uLQ0KPiA+bW1hcHNbaW5kZXhdLm1lbSksDQo+ID4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vdmZpby1yZWdpb24uaCBiL2h3L3ZmaW8vdmZpby1yZWdpb24uaA0KPiA+IGlu
ZGV4IDU4YjIzNmYxMTMuLjhkNTY5OTAxM2EgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby92Zmlv
LXJlZ2lvbi5oDQo+ID4gKysrIGIvaHcvdmZpby92ZmlvLXJlZ2lvbi5oDQo+ID4gQEAgLTM5LDYg
KzM5LDkgQEAgdWludDY0X3QgdmZpb19yZWdpb25fcmVhZCh2b2lkICpvcGFxdWUsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBhZGRyLCB1bnNpZ25lZCBzaXplKTsNCj4g
PiAgIGludCB2ZmlvX3JlZ2lvbl9zZXR1cChPYmplY3QgKm9iaiwgVkZJT0RldmljZSAqdmJhc2Vk
ZXYsIFZGSU9SZWdpb24NCj4gKnJlZ2lvbiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgaW5kZXgsIGNvbnN0IGNoYXIgKm5hbWUsIEVycm9yICoqZXJycCk7DQo+ID4gK2ludCB2Zmlv
X3JlZ2lvbl9zZXR1cF93aXRoX29wcyhPYmplY3QgKm9iaiwgVkZJT0RldmljZSAqdmJhc2VkZXYs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklPUmVnaW9uICpyZWdpb24s
IGludCBpbmRleCwgY29uc3QgY2hhciAqbmFtZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyAqb3BzLCBFcnJvciAqKmVycnApOw0KPiA+
ICAgaW50IHZmaW9fcmVnaW9uX21tYXAoVkZJT1JlZ2lvbiAqcmVnaW9uKTsNCj4gPiAgIHZvaWQg
dmZpb19yZWdpb25fbW1hcHNfc2V0X2VuYWJsZWQoVkZJT1JlZ2lvbiAqcmVnaW9uLCBib29sIGVu
YWJsZWQpOw0KPiA+ICAgdm9pZCB2ZmlvX3JlZ2lvbl9leGl0KFZGSU9SZWdpb24gKnJlZ2lvbik7
DQoNCg==
