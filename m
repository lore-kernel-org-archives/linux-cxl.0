Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.43.107
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794969412;
	b=5hBwBZ8Ker3p3VJLMT33eLPKKgmG6G6LSSMg/D9pZ5dO+r9Fk8SgJkgiJd05hk59bW1v
	 9Nd2XKfiErigcIxAQbO42/gtyAFTnE0wk/h1TPXxYVyG31sQfp9Fi0n7LIvGuYAMGRVyO
	 qSWgWqCMOh01pbKf8h9t0fQg8wq5PQuD8qJANX6uerHYcN7Kt3pdWLkmwKpcsdL7TTFWb
	 qkqKSfmX6nVtQzWOvtgAKCpuCIulvgaXIm/xN3iuaOTegbDOG6epZuOLKi+SmXbJJGXqz
	 SZGtP+zc8/v/k0uMQo6H8lT3Y2gUsbmVRSFmaqzYSKEh4t07S6aRP/g3Ui8I/WeSF/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969412;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=aWpg58HKsz9gvjXKV+sFit+pFm1GIkO9ocGkKkjzpY0=;
	b=y5QWXC8R7pBGNeckgHeMm7s7+k5uUlbeYH4V+LOQZw+knAjqtfl9sUj05za0W+gIY8Ti
	 KjM2K/VTTmrJPUe0uJIwJM+Cx+DjlvcWqtjAAJH1Hc+hTJJ4KsO5GRnYFPCxhXaKZwTqU
	 W9e4yCLRGrU/eshGUbnxp+U1r03dZhLXJ9GtrQnCmG7oaOLHOlcZUEIN7YjPD7qAUnCyS
	 NyZuEvqJIPOvsah1L3slyiSFxAIbG+Wjg5DgVnd74oys5IiaJn1/lI9U2znEr9VljWaDZ
	 I0y8idGWCCJtImXxE1lTRsrZlf58TjHhr5TLr+cr1tVCP9quRKaErewnjVcxuMplmMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xcena.com;
	spf=pass smtp.mailfrom=xcena.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.43.107
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022107.outbound.protection.outlook.com [40.107.43.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D9606A31C;
	Wed, 18 Nov 2026 02:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E2D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xcena.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xcena.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co4SLE4DriHr1ocGgQv5y07wgu8f3GorDg20N+VBSC8AGMTbH8kfMazYGNv+W4u7GIX4DlC48J/qvEhDbPqUQTou7AlizIbacyezJHVkG/ttztBhsvlmPJn1muR0jkS1a5EJ8rRgRphEDpoN+Dg1P3y/YlTI2VCTmoaPeOCEoGEj9e0bXTSRjCZG4gJGgybg+FFz3rBr9VS08egU5rTPi4pWUX1+hRfJlphClNeJwMtpUrNbCSz8SVgNr3ioPWRXGxfVbwKT0Vp7DvPVdntv8slujcUxCEEEIHdblTmPv69+FVvQ7y9J9HgLPkgeF2XfZ1attn681RZXiHS/w8pWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWpg58HKsz9gvjXKV+sFit+pFm1GIkO9ocGkKkjzpY0=;
 b=GCax/7AwAqlJ1jp8b7zNm14sIFRe6m1ZspuF5nrI1dCDDtqcTtiG2/dC2pYtNytcsAjCqLpLSKuHDJJz7lxog55Zf+6G/37vNlSR22EYS345fZHIydY+O2p4LhA33vl3izjtevgespvFIuIikQHWLku/W5JM2vDgEV3oFbbolSvcwrCNJBpmb8ko8dGwSeoEVnnv9xZo5DyURyVMfzLVEDI9KnycBxy/9Qf2DDJf8kn7NQC3q1EK32Tq/akcpRP+R5IdlWe3g8E4CVYk8jTXzxKtbsDP2EIUWx/MGJ7CuxGUJM2KgfGzpCXPL1CYu3EJdJBrA+yL3Ui/mKzNqnKAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xcena.com; dmarc=pass action=none header.from=xcena.com;
 dkim=pass header.d=xcena.com; arc=none
Received: from SE1P216MB2499.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::9)
 by SE2P216MB2250.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 02:36:49 +0000
Received: from SE1P216MB2499.KORP216.PROD.OUTLOOK.COM
 ([fe80::ab34:dc28:aeb6:23e]) by SE1P216MB2499.KORP216.PROD.OUTLOOK.COM
 ([fe80::ab34:dc28:aeb6:23e%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 02:36:49 +0000
From: =?utf-8?B?7LCo7KSA7Zi4?= <junho.cha@xcena.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>, Dave Jiang
	<dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Alejandro Lucero <alucerop@amd.com>, Richard Cheng
	<icheng@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
Thread-Topic: [PATCH] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
Thread-Index: AQHddj+kWNVS+fjF3EC7rFWkCcqfUrcyzpeAgABPo2A=
Date: Wed, 18 Nov 2026 02:36:49 +0000
Message-ID:
 <SE1P216MB2499A0F74C7505ED91303105F67A2@SE1P216MB2499.KORP216.PROD.OUTLOOK.COM>
References:
 <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
 <23185fba-5905-4671-8d94-8ae10c78077e@amd.com>
In-Reply-To: <23185fba-5905-4671-8d94-8ae10c78077e@amd.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xcena.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2499:EE_|SE2P216MB2250:EE_
x-ms-office365-filtering-correlation-id: b524b2e2-b627-45f1-72bb-08df451ccbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|42112799006|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|261009223027099003|4143699003|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022115727099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 Ri0p/tqBEARorgt1KW2QkwGa6e/fNBgORXJmzCM7dJenor0cwJQgvqnlmqecZco3PQHGkux6V3Pg+MsneaAsAR1frPk/TigEOXj8gB6ZbV0e0Bzu0m68AG4rIUWbrHUPpaZ1/7Ap8RHUaXEa3I71rNJaAY4sKsAS/6t6PQEoF7WplHT7NkRXfbcb4g86/ixReQCsu/YyA12D+m2fmcqjqmK8hqCqcHwY/r4LCYnZxHZTdRIhzGvltIRFnBX44BQmEKsnVYguf0lEW2RoOsYX7loDC1xiHo2XEp60NT6cWR9zWCLhI4H7ZS6PoZr2tKnJjqbt47smwrxTncITJDOERBnesZtJDWc+GuhL2GbbD/8+lxgg5IbgNyiI8ki8ZbtrYOf274dDtNPB7Z+KHHg4MxdTLdX4ASgAsJaczTCGcTPAibSKNu3OyHO9dywwa0DRxZ6txLPGRCSdhCaHCeke7TLp5OIcPlr6YPqm9ba1CemmAUR9nO3yQoHF3Vmkl1i3r8XWXS245uQlD/dEmLMuKMGLO+5tMXS5BxdlM2k73ynTO8+EgiKicyZlHi6Jq95jFlkkBTLoXuJ6GMemG11aInhYpmmQuhSxWfTuJE66xcbZHwIGn4ct0E6XxJVTwl4PJtaJaruaHIGxScBdLERQh+devJVqdyPB2NiElqmxRzSVyK1C94nQHiwMFdMWyTBAlUC0wTQ5z8cIOx8L8FYxFg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2499.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(42112799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022115727099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTNNRG1pdm1SNUdhSHR3dE1XZXpIODVQZS9oVXJ3NmNlMEtHYUJxRkcxK1JQ?=
 =?utf-8?B?T2VhSVFOUzdIeU41VUJYdG5SM0VONlpZdjRSeVRJaktPSFRhU3VXRVFDZ2t4?=
 =?utf-8?B?S1FrdUoxQVdqUHhIbEFSY3RHMElpOHY3V0FEZmE3TjZMUXd1a2QxVjgzcHBM?=
 =?utf-8?B?d2NnUnIxTUhSR0NwVzhHRTdVL0R6Y1hCVWFjU1ppRG9YMHA5SFFzRVBYNGtt?=
 =?utf-8?B?NFpkS2sycG1hWm80ZVM1Z1J2NmdGWnNnNVJwRFVUenBtS09SRFBGZlJ3NWxq?=
 =?utf-8?B?eERmdkpiMkY1ejhiY0NRdmxQNWdBNFQ0WFlpQUpTeVJwUStYMlJvMStMM1E1?=
 =?utf-8?B?U0ZESFVlSVJyS0xKUHA0YTZTVnV5c3VmMXdDYkdRRitEMzdJTnMxdzdkWHho?=
 =?utf-8?B?Z2R6YUp6WmdrQS9uK240aTBudXhDNFVGTGdwUi9KWElsV0VWUmZnck0xY1Zj?=
 =?utf-8?B?ZWFZaU1HR2M3cEpBUUNvRUFBOHd3R2tTR3BtVlFjcTViYW1HWlpIS29HREh5?=
 =?utf-8?B?RkNxSFRlSnJhbHpUMjVYVDVVSHZGNXczbWVCQU8rMmI1a1VSWVNuWTNpWXFj?=
 =?utf-8?B?c0R6d3lkVEFMVHFJQTJrckgrNUh4TWVNZmY2a2JEbXBsa3VDT1Rhd0JEL2dz?=
 =?utf-8?B?eWYzWUkwbnRoVWNtcjdlak13YUdGRmwrejkvRytlaTQ3L0dhcGFOM3lSWElI?=
 =?utf-8?B?SXZxZCtheWFMTnNaL2pUSEc4UmlaWWJCS3BlOEZaaWd6ZG04V0pYd25qYU8r?=
 =?utf-8?B?YUpQNnk0TXp1RFgrZ3MwcEQvbFlkOXl4TUIvWkpiVlA5bEVnZWZSRzVYRTFC?=
 =?utf-8?B?Vm5uUkNsZXpGTmJESU9CKzRIemtrL1lPNHE0QWtRMlFPR0xhTzJxM05paEtj?=
 =?utf-8?B?Z1MyRU5NbnY3aDZrbjJ0eTRJYmFPVzFpY2I2RWhDZU51bHArMnFUWk1PdFRr?=
 =?utf-8?B?ODE5NnNnSnRteUNtRytSb296YVhESjJKcldJZGE0SWdUMkErekd1NEppZTR5?=
 =?utf-8?B?a0UyL1dwbGhEK0JwMExQZmFRN1NNd3QycHU1RlMxcE9EVk1acmJTUEgwK3Fh?=
 =?utf-8?B?UjQzbkJJNEQwd0tvZ1pIMVhwdTZoVEVuNDRrNkFQMzVXblRoYlRBTkZENkg5?=
 =?utf-8?B?UC95Qi9CS0JLRENoTWlDaFdpRE5QbVNvTHU5S3czTWNSaEdpbTVBQ1FadFgy?=
 =?utf-8?B?T0VMblJKTzA3VWN6VFlXYis3QmIxWWJleWpGblVhdUMxUXpKSlFyanF5dlRl?=
 =?utf-8?B?ZXE1NXU2SXp4a1U4OU1hYWlua1puYk43d2ZlbllwbkJFcldCck5UTUl0ckp3?=
 =?utf-8?B?SDVqMmdMK1NCUUJZbTNMK1RQRnBPTk5DcWh0bDFtV0NMNkU5QVNDYUZrS0xZ?=
 =?utf-8?B?aHhhZDVJVy9oZ0QvdHU1b3B2SXB3Wm1EUlVHdGdseTNXVEVQMmREWFZNTTFJ?=
 =?utf-8?B?bU9FS2d3TURDa1QySzhGRzF3VUJmYVIvaTU1M0lPZkRpM00yUXFUQnRNQTFw?=
 =?utf-8?B?YjQya1hWTW5Rb1VEUml1K1h1L05IWlZ4MEFCc25MamExT1NoMkZEalE0OXVV?=
 =?utf-8?B?RUIwQ3hUUnFWUHZ2eC9xWEU2OFJPK1RteWtCTGdEYnQ5MUFXa0VPcFlUMkFn?=
 =?utf-8?B?blBZQ2lQSTJSTTdpcTdXNEc0N0M0cTg1YlFFb3Z2VEthTmIvVDRHWURVV0Jq?=
 =?utf-8?B?a0NJSEsvakZDYjNNU0VrVUkvZlA0c2doNStXQzBCeEhiZUtCcHBDKytLeFc0?=
 =?utf-8?B?NDcyVlFhU1FQcy9KTFR3d2FEMG1jdzJkRHljYUlWSjZ2NmZpaWM4a0RzWSs1?=
 =?utf-8?B?dGVQNHhQSEtyQjFmYThJUzgyNGN3SnpJR3M1dDFlZXNXWnhzN1pLY2xFS2hM?=
 =?utf-8?B?M0ptTWk5ajZhQm1xMGgyV0t6c2l3V21HUEtIYmJGaHZPYWpoRVJSZWN5RWUv?=
 =?utf-8?B?Y2lZU1liQlNFdkpKZjlxcGhoVDNSM1Z5WDBPRHZNMFp3dit6bjBTTlgrV05Y?=
 =?utf-8?B?YlJWVFRmSFVaM09Oa1ordENoN0pobWJFYVFqYmZlcmo0V0ZzaWR5TThIWUN6?=
 =?utf-8?B?RXhkckowOTZDNnIxSXhydGxQd3g2NUVyNk9ncmc4YlJtWTg4Z2w5bWhQWDRk?=
 =?utf-8?B?NEJra3RNKzQxZlNlLzRjeElwM3M3dFh3Yll0cjM3U3pEeVNQcXJjRXByWlRk?=
 =?utf-8?B?U3BXejhLR0VnL0VzNjU5YzdsM29OajR6emx4bXdadlpvV2o0aTJxeXhQVFNQ?=
 =?utf-8?B?cm1TQ0VINXd3UzVxTE9sQ3ZUU016Yjcvb2dkdXhUU3JLZzNRUjc2YU1FTnIr?=
 =?utf-8?Q?Ci0U7mG44+oVxgA+cQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: xcena.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2499.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b524b2e2-b627-45f1-72bb-08df451ccbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 02:36:49.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6b27f63-aa52-4904-bb98-c040d01eb7f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZjtHfRiGIlPAwd35pFKX9z+XrhouGzag6T7a+19Kx6iwRkdF4EiDY3gnCTpMHxGVtI/wkSd5u+V7ts9H+7wkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2250

T24gVHVlLCBOb3YgMTcsIDIwMjYgYXQgMDM6NDk6MzlQTSAtMDYwMCwgQ2hlYXRoYW0sIEJlbmph
bWluIHdyb3RlOg0KPiBPbiAxMS8xNi8yMDI2IDg6NTkgUE0sIEp1bmhvIENoYSB2aWEgQjQgUmVs
YXkgd3JvdGU6DQo+PiBUaGUgdGFzayB0aGVuIHdhaXRzIGZvciBhIHdyaXRlIGxvY2sgd2hpbGUg
aG9sZGluZyB0aGUgc2FtZSByd3NlbSBmb3INCj4+IHJlYWQsIGFuZCBuZXZlciBtYWtlcyBwcm9n
cmVzcy4gIEJlZm9yZSBpdCBoYW5ncywgbG9ja2RlcCBhbHNvIHJlcG9ydHMNCj4+IGEgY2lyY3Vs
YXIgZGVwZW5kZW5jeTogZW5kcG9pbnRfdW5yZWdpc3Rlcl9yZWdpb24oKSB0YWtlcw0KPj4gY3hs
cmQtPnJlZ2lvbnNfbG9jayB1bmRlciBjeGxfcndzZW0uZHBhLCB3aGlsZSBjeGxfYWRkX3RvX3Jl
Z2lvbigpDQo+PiB0YWtlcyBjeGxyZC0+cmVnaW9uc19sb2NrIGJlZm9yZSBib3RoIHJ3c2Vtcy4N
Cj4NCj4gSSBkb24ndCB0aGluayB0aGUgbG9ja2RlcCBkZXBlbmRlbmN5IGlzIHJlbGF0ZWQgdG8g
dGhpcywgaXQncyBpbiBhIGNvbXBsZXRlbHkNCj4gZGlmZmVyZW50IGNvZGUgcGF0aC4gVGhhdCBz
YWlkLCBpdCBtYXkgYmUgZml4YWJsZSBieSBjb252ZXJ0aW5nIHRoZSBndWFyZCgpIG9uDQo+IHRo
ZSBjeGxyZC0+cmVnaW9uc19sb2NrIGluIGN4bF9hZGRfdG9fcmVnaW9uKCkgdG8gYSBzY29wZWRf
Z3VhcmQoKS4NCg0KSGkgQmVuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClRoZSByZXBv
cnQgZG9lcyBjb21lIGZyb20gdGhpcyBmYWlsdXJlIHBhdGguICBUaGUgbmV3IGRlcGVuZGVuY3kg
aXMNCmVuZHBvaW50X3VucmVnaXN0ZXJfcmVnaW9uKCkgdGFraW5nIHJlZ2lvbnNfbG9jayB3aGls
ZQ0KY3hsX21lbWRldl9hdHRhY2hfcmVnaW9uKCkgc3RpbGwgaG9sZHMgYm90aCByd3NlbXM6DQoN
CiAgLT4gIzAgKCZjeGxyZC0+cmVnaW9uc19sb2NrKXsrLisufS17NDo0fToNCiAgICAgICAgIGVu
ZHBvaW50X3VucmVnaXN0ZXJfcmVnaW9uKzB4MmEvMHg2MCBbY3hsX2NvcmVdDQogICAgICAgICBj
eGxfbWVtZGV2X2F0dGFjaF9yZWdpb24rMHgxY2EvMHgyMDAgW2N4bF9jb3JlXQ0KDQpJdCBnb2Vz
IGF3YXkgd2l0aCB0aGUgZml4LCBhbmQgY2hhbmdpbmcgY3hsX2FkZF90b19yZWdpb24oKSB3b3Vs
ZCBub3QNCmZpeCB0aGUgaGFuZyBpdHNlbGYuICBJJ2xsIG1ha2UgdGhhdCBjbGVhcmVyIGluIHRo
ZSBjaGFuZ2Vsb2cuDQoNCj4gSSB0aGluayB0aGlzIGNvdWxkIGNhdXNlIGFuIGlzc3VlIGlmIHlv
dSBoYXZlIG11bHRpcGxlIHR5cGUgMiBjYXJkcyBpbiB0aGUgc2FtZSByZWdpb24uIEltYWdpbmUg
dGhpcyBzY2VuYXJpbzoNClsuLi5dDQo+IDMuIFRoZSBzZWNvbmQgY2FyZCB0aGVuIHN1Y2Nlc3Nm
dWxseSBhZGRzIHRoZSBhY3Rpb24gYW5kIHBhc3NlcyBiYWNrIGFuIEhQQSByYW5nZSBhdHRhY2hl
ZCB0byBhIGRlYWQgcmVnaW9uDQoNClR3byBjYXJkcyBjYW4ndCBzaGFyZSB0aGUgcmVnaW9uIGhl
cmUsIHNpbmNlIG5yX3RhcmdldHMgPiAxIGlzDQpyZWplY3RlZC4gIEJ1dCB0aGUgd2luZG93IGlz
IHJlYWwgd2l0aCBvbmUgY2FyZDogd2l0aCBhIGRlbGF5IGFkZGVkDQpiZWZvcmUgdGhlIHJlZ2lz
dHJhdGlvbiwgd3JpdGluZyB0byByZWdpb24wL3RhcmdldDAgZGV0YWNoZWQgdGhlDQp0YXJnZXQg
YmVmb3JlIHRoZSBhY3Rpb24gd2FzIHJlZ2lzdGVyZWQsIGFuZCB0aGUgYXR0YWNoIHN0aWxsDQpy
ZXR1cm5lZCB0aGUgcmVnaW9uJ3MgcmFuZ2UuDQoNCj4gTWF5YmUgeW91IGNhbiBnZXQgcGFzdCB0
aGlzIGJ5IGtlZXBpbmcganVzdCB0aGUgY3hsX3J3c2VtLmRwYSBsb2NrIHRocm91Z2ggdGhlIGVu
ZCBvZiB0aGUgZnVuY3Rpb24/IEkgZG9uJ3QNCj4ga25vdyBpZiB0aGF0J3MgdG9vIGhhY2t5LCBi
dXQgSSBkb24ndCByZWNhbGwgc2VlaW5nIHRoZSBkcGEgbG9jayB0YWtlbiBieSBhbnl0aGluZyBh
ZnRlciBlbmRwb2ludF91bnJlZ2lzdGVyX3JlZ2lvbigpDQo+IGdldHMgY2FsbGVkIHNvIGl0IG1h
eSB3b3JrLg0KDQpEZXRhY2hpbmcgYSB0YXJnZXQgZG9lc24ndCB0YWtlIGN4bF9yd3NlbS5kcGEs
IHNvIHRoYXQgd291bGRuJ3QgY2xvc2UNCnRoZSB3aW5kb3csIGFuZCB0aGUgdW53aW5kIHdvdWxk
IGFnYWluIHRha2UgcmVnaW9uc19sb2NrIHVuZGVyIGl0Lg0KDQpJbiB2MiBJJ2xsIHJlZ2lzdGVy
IHRoZSBhY3Rpb24gdW5kZXIgYm90aCByd3NlbXMgYXMgYmVmb3JlLCB3aXRoDQpkZXZtX2FkZF9h
Y3Rpb24oKSwgYW5kIHJ1biB0aGUgdW53aW5kIG9ubHkgYWZ0ZXIgZHJvcHBpbmcgdGhlbS4NCg0K
VGhhbmtzLA0KSnVuaG8NCg==
