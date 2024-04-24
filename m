Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2109.outbound.protection.outlook.com [40.107.100.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7B134A8
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990497; cv=fail; b=W6dHts+LKKHqDLq/RkVdMKjHI+TNvtHaXpWj/XAgVjr059TiCxgm1LtLGY5I73Vf7WxiUFHF+5BshESF8vkxxU1N6y5U4NpoQ7KOrXTPqFEdCabGLPS8bin+2lE90n7tMxZfjiZfQhgDjAypvQzhYdlhfDEwBZOFMe91oO0rTQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990497; c=relaxed/simple;
	bh=KxCkkjK1TlQBYMX53JhYRiTRr585u5xK4aS4VLeOPxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOReJ1SaHM5zgpIdqQ5Tc/qRcBomq17EB5iiFEnQwPQX4f+gD8fOJ/y0JXEUDAkYh7tG6tfukWpK/iPoErJireDO/yK+WmbUhJQvNBAt0t7KP3WQHRdZ0cokdrOrhmQ1S9GleuyZlHuLq9Ab244jD4FCKfiDiwR8kyHE2VocJxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=iXDMGTJQ; arc=fail smtp.client-ip=40.107.100.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="iXDMGTJQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvsVtJ0ms16s1nBgSKrWWwPzWe7P+rgA4XGydgLTBd03J2e6DWaPTRZXtu0RHmJKWfbT626upwZBBzqHG7sRWSEM5MTS8WDS/09OGts5W9MhFXpAKcuOVDe+yx31ofytPF00uep8qGgJ6ZM7SR2dtyL0g3x4V7ZS8LAmW5GCFPlooMce6nw1g23KeIi8Y3f6Uc1qZSwtKxx51RBAOxpCoDHVTwGbieIJAXpCGLpB2KQF7vqIRLSDvC+cwvpg9Tz3bLEuxJNYccDmwAVBoBEok+x36gb0BcT8eGbu2DiTaOwrn6ptKAm/8Md+V/tWvhSHTYHRneQT6/RlV9e7rzGrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxCkkjK1TlQBYMX53JhYRiTRr585u5xK4aS4VLeOPxk=;
 b=i+slNLct+GVhAS68O7/0Tnrz68wPhsHxxkIps3Q4ZX0J3RHZdtpyLywtC1y6GtqJXRB1GgqAgYA1MD3pCtpYmC9vT+lZIehpxWMfbBuzrHXewayAN2htVKrBveDwoc/2Tarbd1R0HLRq97axBPGbMObumjPykMV3tYoEUsdTR0QKItpXaJa4o56Yu8N89reGHyWhZPkbLbJJBROOOmxeW2qw4+eS5wzY9Sw7PaKLe53Nx0YaOgJknb1gQHgU81R/nk8ohLDn4NVPGbj7MtTrFN9wyhyIoOvRPxf04PtJ1CdUKBZ/BnkTdpHf0lO6oDH8cEZuDiZ0DgNECwY15GLdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxCkkjK1TlQBYMX53JhYRiTRr585u5xK4aS4VLeOPxk=;
 b=iXDMGTJQKaO9mCqcFriYZuZj9XtJ034SDe019T4+6AI3ITBz/lefr7Ym/NNchcPs4ZFFjl8hGyvyLMJL8/h4/vvuH1p7lwqcMmVotDqcMrKl7cN1zH09vg7Wu7wcVgWwI6Q6z4pLd09Vi7TG9UE0u7Jd0VXsGIwHDax6YevDMFA=
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by SJ0PR17MB5606.namprd17.prod.outlook.com (2603:10b6:a03:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 20:28:11 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:28:11 +0000
From: Svetly Todorov <svetly.todorov@memverge.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>
CC: "Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "fan.ni@samsung.com" <fan.ni@samsung.com>, Gregory Price
	<gregory.price@memverge.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wj28.lee@gmail.com"
	<wj28.lee@gmail.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Thread-Topic: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Thread-Index: AQHaloQ7v+Y2b5YHh0S+QGF8zUpElLF33sQA
Date: Wed, 24 Apr 2024 20:28:11 +0000
Message-ID: <BD1422BC-F298-4DF2-93FE-5B123D68B7AD@memverge.com>
References: <7489170B-E7CC-49BB-91D9-DD6497F99E23@memverge.com>
In-Reply-To: <7489170B-E7CC-49BB-91D9-DD6497F99E23@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR17MB6347:EE_|SJ0PR17MB5606:EE_
x-ms-office365-filtering-correlation-id: 4f839552-4dac-4fd4-8af6-08dc649d0f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU5OZmxRdHkxdTJ6VlpVTHpab29JR3BMOVdDV3ZHaW80Mi9vUFlNbmtZbjdp?=
 =?utf-8?B?bkM3Nnd5SGxTRzVYdEY1S214YXh0U2F5VzM4akFkMU5YWVdxQ2VOTFREblRI?=
 =?utf-8?B?Z2poaTJQbHVOV2lDU2VRZHNhM1REZWtiVnExK1NDSW0xSzI4WmJMNi82WGp6?=
 =?utf-8?B?UVNxcjcrajl3dS9nOG5SdXFJQ2FpTnFER2J5dU5tbjFmV01GbkxaRkVDYlll?=
 =?utf-8?B?clFWNEhiVC9QT3ZhR3JHNXBneHFJMTI0QjRteVY0cytRM1h0MEkyS3RCWWJT?=
 =?utf-8?B?aE42VHBrL2RESU92aGN3c3VHTnJLc1lvM3k1REtJbzk1cEJqUzNBWlg5WGhM?=
 =?utf-8?B?eUlFQ3Z2TDlzVUtsZjNlNEJnMUx3NjlWWVdGeVFFcmlLbFJudThoS3h4WVl2?=
 =?utf-8?B?OGswdHRFcFRJbmdKcXF0c1N6WDNhZ0VlOHA1NGVyU3BoZDRmYkhzclhDWU5R?=
 =?utf-8?B?WSszeWQ3SXhXSGxQTVByUytJRUw5Nmc0Ylk3Znc4Zy9TU2FDQXFOZFpjOXVB?=
 =?utf-8?B?K3Q1OWU2UG9CdmRFN3NkTld2bGgzVWh2NW8rcmZtdThhQUVmZkZQaWtkTHNL?=
 =?utf-8?B?WjNTU3NBV0lZMmdhTk9UVmtRa3pFZ216Mm5iMTJDZEh2cEZWcVJiTitwNmdu?=
 =?utf-8?B?bVI4RGVJbUJkcUNwbzFkNlY4eSs5dFRkeGlIK2txcWhzeUx0SFZZY1RZaWcr?=
 =?utf-8?B?amZlRFZnc1ZQaDB5VmF2bjA3WGJMY0Y2YTJRU24wS3hpNkN2L2V5TUx3bFVl?=
 =?utf-8?B?R2FvQ3ZVNS96NGFpYy9Yb1NZSGM3TzE5dU1vWmYvM2JyeUN3OUloZzhTaWFB?=
 =?utf-8?B?UWdoVlJoNFNkNStXRzJ3UnZKd0dLVVE2aFFTMWVUcDE0SC9nOUNXZXprZTZz?=
 =?utf-8?B?dUpDMVRFbUdyaUgzWHJKdHJCOTAxQS9BZUdKcUlmeDNUNWoxMVEwQnp6WWRm?=
 =?utf-8?B?TFM1a0F2RUhseDJ4MVd2WHgvaUpwbnlQd1pEYWJqbHJFMlZjZU1DU0lBL01s?=
 =?utf-8?B?ZWsxQkVTempNT0lJS0s0OUxpSk1Ra0VyanZKMVFQcU5icUs1cTRRa3gyZ0lD?=
 =?utf-8?B?SnM0WXhxek9MNFRiVWQ1ME1zNGFBb28rWXMvM0JYeDRxaU5zNVhtNmwzWi9a?=
 =?utf-8?B?bU5nY0NJK3I5Q2I5U1pWd3FPdkN6c3ZGOXl1QzhpNk5mYm5rYmwzZUhkelND?=
 =?utf-8?B?N3dCaklRSDBRbGhKYVdGMWMrSUFFeGdqY0IwL3FMTEtRSG5TQm1BVGdLalNC?=
 =?utf-8?B?RnZrUk94QVhSYWdsWm1JL0l2ZDFpOFdCWFR1MHh4RElyTWVlQU1XRzRpb28y?=
 =?utf-8?B?Tm1CVnFINFkwVXdVOCthVWVlTDhhZkxqK3N1SGVURTR0M1lidHUyRklNOW54?=
 =?utf-8?B?YXgvV2NtczdsMWlRZVllNEFRbkhtTjNjaGZtRlM2VG9HUmdFNXV0VzlGbHVZ?=
 =?utf-8?B?U1VqcFRYTWRiQ0JHbERsZy9XaEtsWjU2bXhhR1FaVzNoVDNlN2xhZm84cHZn?=
 =?utf-8?B?QkduY3FXU0piRDNXZWR0T09lRmR1emlPTWhjUzZkaklyUzZ2Y3RySlpTcXZM?=
 =?utf-8?B?TVRUMWl3R3htMzlZY0kxSG5tQnRTODNwMG5PSlJNTHc1Q29UK0FEbG51UDhL?=
 =?utf-8?B?emF0SEowOC9nV3hNZFRSY3hpVDNmc3ovUUpEajcxNTIwTWorazZFeGswajNz?=
 =?utf-8?B?TlZ5VHhRbVpWMzBjblZjUitOZ1ZsaEJPOWlLcU1iL3RkRFBVcEJWNDJTSFVq?=
 =?utf-8?B?RzN0WkF1NHo5MjdjTnlhYllTMXdjTEluOTNQaHl6WisyWjBod0VUdUVYbGZB?=
 =?utf-8?B?dlMxM29haDdsVmJvZklLZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmxTWDBkMDFRd1E1MlJtdmJncDhHN25qdmtjT2wvL1lScFk4aTNPWkc2NFEr?=
 =?utf-8?B?S05KL1E3OG1FQWZlY1V3ZTVRNDlNclN4Y1l6c1BrTFVNMWZiaUxJS1VBMzMr?=
 =?utf-8?B?RnBaR25KOFExUUxSTVIwNC9Qa05XVkdWSmE3Z2JoNGV0MWg5UkFSeWlQWkpn?=
 =?utf-8?B?U2xNLzBDUEFsd21DZjBNaHN0YnY4Y01vT0pOSFJNalFMKy9RMXZTOUc0TDhD?=
 =?utf-8?B?Ny9YOEorY0wzWUkvNnN1TmlkMC9IVldRRDZrYzgrTGpyS1MyRU9wYStzSy93?=
 =?utf-8?B?NUdGOVpIb1RLK3RRNHYwQ1MwQk8wMUhVQ1RRTlJrMW8va216akltS1l1ZFVY?=
 =?utf-8?B?aFZNL2VDbmRqM0MwUnBHeUU4RkJLdVFRR2dzdmZyTVFGSlRTUmlEWTRUdzBR?=
 =?utf-8?B?d2FteEpnVTdZZmlzb3ViQmh2bWovcGh4eG1oVVY2OTJxeHpJOW5LUGZUaDhF?=
 =?utf-8?B?cG8yR24wU2VEVEpibEZVeGNUQ3c5TnhZcHVvZWo3Wm9KOG5oZGdFOHJRcUFN?=
 =?utf-8?B?UlErdWJPSlJDb0llSHlVQXZsNXRlOWhFQ3NNWkpRK3g5b1lNVmIwNS9CMVh0?=
 =?utf-8?B?YkRWdzNabE91cUNvMmQrdlJrdXZmYTVwQjF6dzVKTjczNmx2ZnZCVzRWd0d4?=
 =?utf-8?B?L1J2aWdIUkp5MVdoVnlaSXdrQWtFUHg2aTdQTG1NUExKMVFDM3NkVVJyRmJh?=
 =?utf-8?B?bjM1a3VVdUpHZEhIUitpQVZDUU9WNXNPNmZxVEtBSVJmcTFlVkVZUlhRL2hW?=
 =?utf-8?B?dVZLalJRYVdBMU5NdjFwV3JYQVJ5cVZDTUZTcExKMWFWK3dUTWFWSzgyMzlT?=
 =?utf-8?B?ZUtEVGZYNXJWem5HRHBVZ2cyZ0Nxd3FGUUtaRjVOQTRZNkIvNWxaSXJlMEF1?=
 =?utf-8?B?UnpIZXZqeldzdEZjcFFZVDhmNXU3dTE4VmVJd2U0TXpMLzhJTWlNZC9sZGtV?=
 =?utf-8?B?NHhzeEU2Rlg0eHBBNHlLZndtWVNlbFYzbUdsdEp0NnQvZTBud2Y1UUcxeFdz?=
 =?utf-8?B?NFJaZUxYR21ORzBnMW14cnJmdVQ5RStRd0R3K1RlNC9Qb0Y0YWhLTzd6TEFX?=
 =?utf-8?B?RW1nZllDVWhiTDBibE8rRlRrb1Job1FEbWtnM1VrRm4wYThpbTlrS0N6bG44?=
 =?utf-8?B?Rnd5MHIxanliOE81YThnOTVaaFVucklTbGQ1RjlHbDZEcnFLMEY5aER3Ymt2?=
 =?utf-8?B?VEVOMTFkOWxrMTBUeU9BTXJCTEdIQ2hRWERlYjhsZFoxbWwvdUN4b1ptY0lz?=
 =?utf-8?B?NUVjNDRYcmRCQkJhNm5SV0JLMVV1RXZUYTJ1T2g3eVBxbkk2MDdrbTRyWjFm?=
 =?utf-8?B?RnhwYUNiMlRKcDgxeUhlUkRnUnhkb3c4WlcrUWhaRGRBUTlOZS9UbCtPd3Zx?=
 =?utf-8?B?TTl5S2puR1RnTlVmM2xIUkJrVmEySk1WWjZqVTJIL0NKalFXMnZjdzZmMzlm?=
 =?utf-8?B?cXV4QTllTGdYZ05BQVQxdGdoSXN2VHRKNklIWCt0N01YNDdHQWEwTDh6QU1L?=
 =?utf-8?B?YzhyYjI2VnFrM01jN0NrK2o4d3pBV2NNK1dxUjBEblA3Njl6NnpWQ3g2WXlt?=
 =?utf-8?B?STFWOHBhMi9BOGoydS9tQ3ExNDBTdVlqMlNkUkZFT1g0bFpIOVNoVXJpN2Zi?=
 =?utf-8?B?enYyR2xnRVBZQTZiQjJZd2g1UEZzbVlnd3hrbC9iUTE1NWFxOVdIL1I5WFhN?=
 =?utf-8?B?a0V3M0lZdE5JQjEvc1RGdkJ6T1pXTnRZd1NBYTJLY3huVlVpRWdzUFNvRUdj?=
 =?utf-8?B?eEFRRWs3elZUc1lwR01ZK2xsRmRKd1F2UG92ZTZwYVdXN2NGRXdEdzJMRll6?=
 =?utf-8?B?YWRYTXhUdWxzb29ybEVwdVNPVUtBVzJ1eER3dUxwTThZZlpvS0xBN3p4UklI?=
 =?utf-8?B?bGpjVXNEcTY4RnptM0doMFhNcDVEKzZwSWFCK200emU4dVVDbTFycDlEa01R?=
 =?utf-8?B?RW0xZkFzcHJnZFlxSFdRTGhzcDBYbkRvckg3c29IN2tNdzY3YUEvZm53VWRj?=
 =?utf-8?B?em5kdzljOFI4bTBwSnlLcXdacDlpcmw2SW15VlZjZ1lPdW5WcExHcDRob01l?=
 =?utf-8?B?Z1pqMVl6YzhDaHJLcVRsMis1SkVaN3dkcmlJVWpzck03Z2RUeWdoRUhjdnNT?=
 =?utf-8?B?ZFdaYUJ1Q3c2RlE1SW1rd0tKSWU0LzZ0L0Uyek1QOHlvMVNvWTZLS0plLy9H?=
 =?utf-8?B?VDZIU25pNU04dlMvNThueFQ3ZE9GenhXRmNhemFiQjF3azNZVk1DZU4vOXU2?=
 =?utf-8?Q?8QMghDaXxzwcOxmVvS68wT4vC1bsfsE+Htn239aBRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A501586E17ECF34582815FCAE4262828@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f839552-4dac-4fd4-8af6-08dc649d0f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 20:28:11.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARfbJYEXgZL3H5pk9pvrJQ8vt/0I4DBsG5neME0S9OBYpCHy2md1x3DA53JEoBCGD2OONEeM2M8gHw5mB6fGmiVIFV/AOUAe7VruiKKA1Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5606

DQo+IE9uIEFwciAyNCwgMjAyNCwgYXQgMToxNiBQTSwgU3ZldGx5IFRvZG9yb3YgPHN2ZXRseS50
b2Rvcm92QG1lbXZlcmdlLmNvbT4gd3JvdGU6DQo+IA0KPiBJIHRlc3RlZCB0aGUgdjcgREMgYWRk
L3JlbGVhc2UgYXMgcGFydCBvZiB0aGUgTUhTTEQgUkZDIHdvcmsgSSBkaWQNCj4gd2l0aCBHcmVn
b3J5LiBUaG9zZSBjb21tYW5kcyB3b3JrZWQgYXMgZXhwZWN0ZWQuIEZlZWwgZnJlZSB0byB0YWNr
IG9uOg0KPiANCj4gVGVzdGVkLWJ5OiBTdmV0bHkgVG9kb3JvdiA8c3ZldGx5LnRvZG9yb3ZAbWVt
dmVyZ2UuY29tIDxtYWlsdG86c3ZldGx5LnRvZG9yb3ZAbWVtdmVyZ2UuY29tPj4NCg0KRXIsDQoN
ClRlc3RlZC1ieTogU3ZldGx5IFRvZG9yb3YgPHN2ZXRseS50b2Rvcm92QG1lbXZlcmdlLmNvbT4N
Cg0KRGlkbuKAmXQgcmVhbGl6ZSB0aGUgQXBwbGUgTWFpbCBjbGllbnQgaGFkIHNudWNrIGEgbGlu
ayBpbiB0aGVyZS4=
