Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795141027;
	b=u8fqqWOZZjdTL3HQJhVgQ0Nn78DaJZHLgT6nelT6QwGdZrH7KC2Sfy4VpbQyv3Ure4Mn
	 JLC/8wO/yRntX/F9Vf/xDuIhe4bKzpzAaXqTvbm58qp88/0uw8fchrXP5mRGG4ht2Da8K
	 eZjhPoYU6BKyOXDyz+fdEhXK75+T9jrkROeCJqlmeaqjqI2L+houYp7mMw5Ks5EcdfAbj
	 vBnTzpjfWKz33kFXtBooxAbgO+hHrEUDqJmtQ+Z1HH9q5EfdzI2vTCKVkJAsDMtjcW2tF
	 W12ujejmTwFvcwRoMVcPpjDEcEfbFAqx/cY1s0X6NoTMWJyzMjYYw8TcsmaNFzifwAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141027;
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
	bh=czs+hvKwGRgGw4HxmbWJDYP8evN4082Ijqofj2hIUgs=;
	b=sHVzGVDCQZ5NpKEX2suIElYqJrujpBanCdFQpBGv2+u7RkCTS6lzm3wH/3ZoqbPLxsCZ
	 d/icueOnbQVvcqZVSN6piF5fkFkkbk8eTw4DSFGqp5jbmyPvI3Ynf/Z3rY4Ni/UgJsnte
	 TwyPiirXIEPMpdaz7lmppyhbm0o/kXnb8jFnv2Fca0iWjG9nubfypDm0XJRZatltYLEeB
	 15nRtNuuJm6fgxHL+UXgAX9KYUpNTDk1QBjUq0+GpYRQNu6r9P+w5qUEgXAy01DiqSyqd
	 Pl99UwsZk1lHo9kOGSom9lHSN8SLLyPZoX3BRYNVskAmEsDww2/ZMS3WvWJNEHOCW+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xcena.com;
	spf=pass smtp.mailfrom=xcena.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.130
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021130.outbound.protection.outlook.com [40.107.42.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671C606A320;
	Fri, 20 Nov 2026 02:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3671C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xcena.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xcena.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXHJsYkcDfnOAj6hLli/ATK6iyhIUdo1pj1JWwQrdjkfxMTS4KAPhzJfaXQPs1BrgchEQQyu5W6XVgcvwJ4zdKu6F6ZlnlIBdu2wT2RV30VKv0deXVqjJgSwL7BGLkK2v2wpsDOk/RtheNdxEBQfXsfXKZnLLk5Q+VwFAg77NgmGvSQJH93ZQuQjKDt31yUemZNeQLSYRPb/w0kECTTvlXjGi+gD5oB6+svYD3WUrgzTTRmhwVtnNyF89IFPMsiMtnFG8LaIOtrTyxjqyNAu7Pij0RxUti7DPOU4vkHKGVFtux3GOgNGwy4uPVAm5IPshOhNSyHdBowGIlHOTrH0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czs+hvKwGRgGw4HxmbWJDYP8evN4082Ijqofj2hIUgs=;
 b=Z/7Iht3hNQKvucVMASBNH57E0QjEL2tMRMFGt8/TWgcWMhWFbUJ/01Tp57wlOgeXgBZ2Mhxz25j6X7ekybcPC8XWkp34ThXzhlaTFfv9tSsWlm+uLtaloMeCUT/FkESnEaDH/oW2Pmoxa2oZ0/rvetUhsQacjDKBh3cPdNVl37p/6uXeFRynxjOAmWbF6TXQkI9WshQi45wgn8+yfiVFC/ZwGCRTSRyA2r/Wuw2GBRxzo7+wx2CU5VydtKUGPJfIcsdTbVIWdbcTxC7hInFq6W7/1YLk3pG2D/rG5ro3xtZxMvhA5BBEsRP3ViksgBSxgOEFeHWC9TuAtNmIju/zJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xcena.com; dmarc=pass action=none header.from=xcena.com;
 dkim=pass header.d=xcena.com; arc=none
Received: from SE1P216MB2499.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::9)
 by SE2P216MB3394.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 02:17:03 +0000
Received: from SE1P216MB2499.KORP216.PROD.OUTLOOK.COM
 ([fe80::ab34:dc28:aeb6:23e]) by SE1P216MB2499.KORP216.PROD.OUTLOOK.COM
 ([fe80::ab34:dc28:aeb6:23e%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 02:17:03 +0000
From: =?ks_c_5601-1987?B?wvfB2Mij?= <junho.cha@xcena.com>
To: Richard Cheng <icheng@nvidia.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jic23@kernel.org" <jic23@kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>
CC: "iweiny@kernel.org" <iweiny@kernel.org>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "gourry@gourry.net" <gourry@gourry.net>,
	"rrichter@amd.com" <rrichter@amd.com>, "alucerop@amd.com" <alucerop@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Fix target accounting when detaching direct
 EP
Thread-Topic: [PATCH] cxl/region: Fix target accounting when detaching direct
 EP
Thread-Index: AQHdbD+/9qnQjd4YyUimUBWj+X3INbc2UJrA
Date: Fri, 20 Nov 2026 02:17:03 +0000
Message-ID:
 <SE1P216MB2499EC410EDFCA0EBD78AB9EF6782@SE1P216MB2499.KORP216.PROD.OUTLOOK.COM>
References: <20261104092840.56715-1-icheng@nvidia.com>
In-Reply-To: <20261104092840.56715-1-icheng@nvidia.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xcena.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2499:EE_|SE2P216MB3394:EE_
x-ms-office365-filtering-correlation-id: 230c746a-17ab-4b05-3240-08df46ac5e08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|56012099006|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 Amcyx95nrRYQ7iL7hez+NICGGcRFLEP4vaZHT4GpU0dfVzSbF3gzNGOcHZLe1sr8Zc0z4ke8Xi7UvzEWZzA9252866HLZW4eoCwJTAJOnKe+iCV5SCAqNzUcfBlguNQydnY5OxbKAEh20ia8nCxDdGJqfoH7Qs1U0g/weLHs39We0sdOFInMgavjvGF9j8iBrtkrKfvSEwvYH/L1pUzmtYMNdbaR8kSogZC8OilmJHOvh2AH0bYUolQdJt5XdoBfnROTusAFgejdS7aGAT5S7bBHidjsv6dv9z4nLeAgA11v1nUb9RpiAWRvkrqxJdzDTM9tx+tjqyLAmsOrJzMbfyl2nBHat71OK3T7lLmAvFT2sHF4R0JySx8qFfHZ4VQMz94MXlY8TV2eg8fjhXFwB9++B/gMV6uu1kMLa+mlRXhtU3tdDOlvIwtUc+OpOtKOosZlPlRyif5PWvxhSnKQw8DS1wcgdIZJJjV0aocyelok7sAqvOBzTrn3eXEFW1Fjd17ox6kVSMQZZy7YqmjxlBkWx2xNQ+5Byir4G8w42Rg+o8TI5xuHv37ZG1y5JNrkDryrSHIXJp4hSgY2SMOHYyHtkUosKQkcOGa7vMnHs5edG4M7E1MdNqfKRXPqz884HFHc03e48JblflupwMqc6x2txhvGc2lhoAxbMHqAZhRRQ3Vpi0RGlWZuAPP3sfddIOoN7jtJ8UCRGu+Cs8x0maMXxvLVzQjALFmd4XxPL7k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2499.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(10067099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?RmRmc1hxWnlNV2tLOE9iZUwxOGIrTU5nWXFlL1ZZRlVjVjVXdFB4?=
 =?ks_c_5601-1987?B?VkxMYnMwTGxZenl1WGZncnhRdDQweHZPRkN5MWZFUkRaZ2h4c1lF?=
 =?ks_c_5601-1987?B?ZmhjVVdWalNiQTJNaGszNmRVdTRWdnpIbjZ6M0hxby9IYUJDUytZ?=
 =?ks_c_5601-1987?B?V3RpaXJPRTJvZloxYUNYaEdDS0xWOURRdTNlUEZCZzBBais4V05m?=
 =?ks_c_5601-1987?B?SDlJOHZ5UENaQzYvRHc3Ly9WTkdKWk4vOWNOVkE4MHJjUWd3aFRV?=
 =?ks_c_5601-1987?B?SzljQVYxZGtVM1NkRDB3dHdPVm1QVDltTk5hQnRSLzFUUHNsWmZk?=
 =?ks_c_5601-1987?B?V2Z2V3VyNlZQa0VyTW5NSnJZTXpnM3JlcE9BRmlySkN5MDR2dmFJ?=
 =?ks_c_5601-1987?B?QUtQUm4zQlB4R2FlY20zS2haazFOTmtJNFNHUVY0bWJlVXB1Ymlr?=
 =?ks_c_5601-1987?B?dUZnbUFiNXZ2NXJqMkhYcDZmbXZXSnRoUXRKWlZhUERQeVBGUHVG?=
 =?ks_c_5601-1987?B?azcydzlVRlZ5Nzl3OXdmSjRBM2xENmlkTVR1dDVMTG9zTXVFcFZp?=
 =?ks_c_5601-1987?B?MWRoMFNONVF5Q2lLVGVwdStUamlZQjQ5Zy9RTFRUQUVlcE51OHhh?=
 =?ks_c_5601-1987?B?dFNNVFV4QUF2bWo3dXNuSVhGUlEzakY4UlZRTVh2aGhZZU5QallK?=
 =?ks_c_5601-1987?B?QlhSNE1JaVk3RVpSc0tnbzBET3JwTTdocXZIcWEwV3dsd05wcFVJ?=
 =?ks_c_5601-1987?B?cmdYQU41Z0FZb1BmUEE0R0xpOHNuWktHcVIyTmJzV091Q1lJeXI2?=
 =?ks_c_5601-1987?B?Sk1HWTlLMDVVdnBxSElZSmlibXZncWpuSUJKbGVPVmp6cHZEMW12?=
 =?ks_c_5601-1987?B?TWtPNGJQdGJrL3hKM1ZGN0t2dEF5SlFwaC9VUUxWVHpiSi9Ec0E1?=
 =?ks_c_5601-1987?B?Z3FSM29BNm01eGxWcm04WWlab2MzM3ZRMTR1aGdtUUdZd1ZtblRP?=
 =?ks_c_5601-1987?B?Z0NDU3pZMzlMb1Z1a0RwTVRUbys1OFdjV2lpdlJ1QTlwWHZuZGlw?=
 =?ks_c_5601-1987?B?OEkyZEN3S1F0TXhpU1NFYlBJK3RiM1ZYdFJDU0t3Q3pwemRDcEpK?=
 =?ks_c_5601-1987?B?VmdBbHZsUWpFZU9VR29LVWphZHFTY0ZxR00rY1V3WE9idzA2by9s?=
 =?ks_c_5601-1987?B?bjBDeE1QL3ZFMEhhZUlyMTBTbEVJYVFmc29VaVV2ZGhsQVRjbFVy?=
 =?ks_c_5601-1987?B?aWlHQ3VFazJZV2Z3TkFNSnZibUNMbndwWFhLdHRnOE1LTVlSOVFS?=
 =?ks_c_5601-1987?B?dktGYkZmRDUvSXZMMnFEaDJGTUpQWVdVRGl6dzdZbklFdDhTVVBU?=
 =?ks_c_5601-1987?B?enRhUi9GR3pYTGVUVzRBZTlsT1lLakNOUHBqdHppaGtxek1ZN0cx?=
 =?ks_c_5601-1987?B?VDRQTlVWbGdxczV4ZHlnVmcraGVONms5ZzlGYmR5ZHkxRG9zMWJn?=
 =?ks_c_5601-1987?B?MHBBQ3BPUEJsUUhWZzNTSXFINWcxYTBuRUNBTlNRWjNqczlsT1ZL?=
 =?ks_c_5601-1987?B?YmNIaVBIbnJOQm5GT2J6SXQ2d3lTeHdPWXF0Um5JMWpCZm5RNkc0?=
 =?ks_c_5601-1987?B?aXpwTjhUU2VlQzI3SlpCY0psZ1I1eUowVGJuYmgxSXphQUx1UHp0?=
 =?ks_c_5601-1987?B?SU9pdytJaVhuOUM3TytWRndJUCtEeW1tQ1dLYU9aeUR2ZVNzWDlp?=
 =?ks_c_5601-1987?B?S2llbWZ6RHpRckxQWTdMME9mTEM4dXRmeDg0akRrSmcvN0pXNkxF?=
 =?ks_c_5601-1987?B?cjI2MHNVb0ZybEJZREdBV1IwK1Zsa2tsc2lCT0xhcXEzYVhsYTEw?=
 =?ks_c_5601-1987?B?ZG5rb3ArbVl4U1J1RGpmZlN1ZHA0ajdaV0czanlOU05qenZxZUht?=
 =?ks_c_5601-1987?B?dVRpZ0x0VS8vU3Myb3hEWXF6UzNkVGh5eGhONmlyVnV0Ri90dTVq?=
 =?ks_c_5601-1987?B?NEwwVlRoeHoxLy8zc0ZCMTN5a2hYYkFVeEE0V0RTcFBZNnlEbFA1?=
 =?ks_c_5601-1987?B?WDJPZmVhZ3FQUXRVZTZlQlZ6M3dHWTBTQkNKYlIxRWxHaEFoejF5?=
 =?ks_c_5601-1987?B?N0JPbHlEejhYcXpSWlZobWtQK0xLbWQzMG9oSk1kVEVlZkQydzlM?=
 =?ks_c_5601-1987?B?K2ZYSVd5QUF3KzdKdy8rMS93TjdhMklhMXRqUk1vMjdQQWpxa21m?=
 =?ks_c_5601-1987?B?Z21DdnBDalZDK0gvYWZhUjM3WDh1ZHl3SlVWZHpaZzM0UmdSZVdl?=
 =?ks_c_5601-1987?B?eWU4N2JWbGhjWmN5andCM0MrSFZCcDFlVXZ0c0kyZy81R2NFNFRu?=
 =?ks_c_5601-1987?B?TTRkTDFGWFZyeWVMVzVIZ0JvOHBIcVF0eUlnMkpsYlJPanFhN0RV?=
 =?ks_c_5601-1987?B?NzlDRUZ3d01HSG8zUmdUbXg1WENhUTRjaG1lc3dSbUxJcm9FMEFz?=
 =?ks_c_5601-1987?B?WDBlaDBXMWxWc1p2U244a2J6dFdJTUl5YldIRUVIQkN2WUpFeVFP?=
 =?ks_c_5601-1987?B?SE9lVmg4elRSUWlEbnZXQ3I1UjZDWThUQmNTeCtpQTM5TkNEbU43?=
 =?ks_c_5601-1987?B?RjJPc2F5dHQxejhlSFpxcWFFRHJSVXBDS2xmRDJhTTV4UDU3akFm?=
 =?ks_c_5601-1987?Q?IcSVJOEPNuhl?=
Content-Type: text/plain; charset="ks_c_5601-1987"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 230c746a-17ab-4b05-3240-08df46ac5e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 02:17:03.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6b27f63-aa52-4904-bb98-c040d01eb7f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmKr5Z3//sqaU8c6Tho6YGUxtYTMl7TcFOkuA85/DoxOpRCdtp5j1Z+lqmEq0PWsMZiQ0x8l3pBE6nLZqqMV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB3394

T24gV2VkLCBOb3YgMDQsIDIwMjYgYXQgMDU6Mjg6NDBQTSArMDgwMCwgUmljaGFyZCBDaGVuZyB3
cm90ZToNCj4gRS5nLiAyIGRpcmVjdCBFUCB1c2luZyBhIDItdGFyZ2V0IHN3aXRjaCBkZWNvZGVy
LCBjbGVhcmluZyBvbmUgcmVnaW9uDQo+IHRhcmdldE4gZW50cnkgbGVhdmVzIG5yX3RhcmdldHMg
YXQgMiBpbnN0ZWFkIG9mIDEuIFJlZmlsbGluZyB0aGF0IGVudHJ5DQo+IHRoZW4gYXR0ZW1wdHMg
dG8gYWRkIGEgM3JkIHRhcmdldCBhbmQgZmFpbHMgd2l0aCAtRU5YSU8sIGV2ZW4gdGhvdWdoIHRo
ZQ0KPiByZXF1ZXN0ZWQgY29uZmlnIGZpdHMuDQoNCkkgcmVwcm9kdWNlZCB0aGlzIHdpdGggY3hs
X3Rlc3QgaW4gYW4geDg2XzY0IGd1ZXN0LCB3aXRoIHRoZSBDWEwNCm1vZHVsZXMgYnVpbHQgZnJv
bSBjeGwvbmV4dCAoMzJhZjc4MTkzNTJiKSBvbiBhIDcuNC1yYzMga2VybmVsLiAgT24gYW4NCnVu
Ym91bmQgMi13YXkgUkFNIHJlZ2lvbiBvdmVyIHRoZSB0d28gZW5kcG9pbnRzIGJlbG93DQpjeGxf
c3dpdGNoX3Vwb3J0LjAsIGNsZWFyaW5nIHRhcmdldDAgYW5kIHdyaXRpbmcgdGhlIHNhbWUgZGVj
b2RlciBiYWNrDQpmYWlscyB3aXRoIC1FTlhJTyAoIm92ZXJmbG93cyB0YXJnZXRzOiAyIikgd2l0
aG91dCB0aGlzIHBhdGNoLiAgV2l0aA0KaXQsIHRoZSByZWZpbGwgYW5kIHRoZSByZWNvbW1pdCBi
b3RoIHN1Y2NlZWQuDQoNClRlc3RlZC1ieTogSnVuaG8gQ2hhIDxqdW5oby5jaGFAeGNlbmEuY29t
Pg0K
