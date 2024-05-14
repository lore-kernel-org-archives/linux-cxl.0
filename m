Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509CC111AA
	for <linux-cxl@vger.kernel.org>; Tue, 14 May 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675388; cv=fail; b=g1LrfRdXvZEi5arVJknPAHwDpyimJDrMfFoq0F7Mr9OilBhp4MH5ppExyctzD++zx2z7Q1Hh/PdgCIzGXG8H8pylTYa2XOy4wUq1mpCNkRwMyKg0yKC13VRvtwZYqukw3vZLS8qIiMB8ZTWKnlZwjP6IE/zoLeBDl65o3Bn4foY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675388; c=relaxed/simple;
	bh=IGvTMcOuW5Cdqz5nXti5BOHFJ1YZpGNp85w706cy63U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ru4GxbgsQth7NyUAGLoiyM6eB7zWzFHg4cju9Gs0JGbRzCK73mJKcHsfM6la2FEqMUse6XEkUdrr49U0MfRgaYu0APAz0guRWeq78TlzFXvxAZB8oNlr2WOyBHkiibdnCHUUW0RtNitPputjd1UWl3igc5PmnVCxUmT3IQisuuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RTD5SRhT; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RTD5SRhT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715675386; x=1747211386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IGvTMcOuW5Cdqz5nXti5BOHFJ1YZpGNp85w706cy63U=;
  b=RTD5SRhTBRcpHMzEtM1oe6HbtPuGtQz6Q148wChlo2KRye4lhJzZ/+uo
   obu+mj0uZHSkhiIic+G3T/wMfyWVAGcs+BvNXj4oR2MZKFDmgbzHvV27t
   sNLXx/lNqwcFPiBhrn9v4V9s9iioczbCwWnr9kgfy9mUFul5tH3hE14ab
   3iRK2Qhf3zDH2HH+0K1XabnvjRiBUZHfwRsJQSR0xaVWHr+F9C34PZbgn
   8Zh6TiNBep9VpGVaXAC5gemchqeanfSTxknjcRemFtGcvVsVoKcJY0P75
   g8DUSErJQEKs8B0JYDAAL2MY/zaNFJh73bmKE610BkqCYUiKtCLCbWAhq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="32320213"
X-IronPort-AV: E=Sophos;i="6.08,159,1712588400"; 
   d="scan'208";a="32320213"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 17:28:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZbjvFP498FD7yy1Imvw5pIPRlVB+t7EWRwDVyT2kdsbllU10uTOe65ZkCWrz9V4uUzM+w5XRJ3m1Sjj9zZOcU/Cyk8UMrU/heVlSeFL6SR2q0cjeV1Ea02MD6uD1pYPHvZ2lDRY/i4YEY0vWnQOCfefnauC5MebprqMSlwXCW5OyJcnXmrXHcAhc6TpijvQVk6O6yxucKKddJGfYM1nj8YP0a2s6viu7MO4/YuXvoyxypnr59UQGkMMwoeeIiR1uDfQz4hnXUvriDzb8nzFJ4flPoXYdig6ckCSeknVenosOI2jQVgplx8UFqZax0pOivSrrSnf4iUkGfJL2g+TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGvTMcOuW5Cdqz5nXti5BOHFJ1YZpGNp85w706cy63U=;
 b=DfuVNgxeN6aIAtZvOGfhhcCQyyCVrez5ApJim7oDLEyXUb7NOwmwr5zQ6zhCr3dAsWxX/PuxUR+h04Qgabha+4+/y0uOovNtd3JYrdSdzTe2bVSf3bYiGBLQa2v3Xy6BV+rk358l6ba67F3K1yoWGCrVBHyZYmwVjRnIOV5dT5C/D5MzqmM4TX0IT9Onmepv5ea03RY4BHssbIpJaesN8zjlJO7Ktnda6o6+hcN+mifON6P+D2zPuCqAv/uH61QqwO6hA+wDAnvFAfDSxOG71QFo4w8OIvC7dTyKRaxkBTjMhrNavRe1pIrQ7VaULl7Qtz2sUGMEIhryH63Nv9xD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB11708.jpnprd01.prod.outlook.com (2603:1096:400:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:28:28 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:28:28 +0000
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
	<Jorgen.Hansen@wdc.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Thread-Topic: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Thread-Index: AQHakehoi4+syWNYVkuNuXkbthW/XrGWjY+A
Date: Tue, 14 May 2024 08:28:27 +0000
Message-ID: <6221399d-5fa0-462b-ab55-47a9f664fddd@fujitsu.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-7-fan.ni@samsung.com>
In-Reply-To: <20240418232902.583744-7-fan.ni@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB11708:EE_
x-ms-office365-filtering-correlation-id: 99320c8f-6b87-45de-e198-08dc73efd42e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uk9iSGt0SFBsZUdKbmZCZTZaSTZSZEFUdnQxUW1jQkpyMlpNZFRLUzRpaTBq?=
 =?utf-8?B?Z2orTkE1VC9IWjFDYmowOEV6S2ozemdIekVtNEI1aFlZRGNYYXMyd1B3bUxJ?=
 =?utf-8?B?b29hUmtqbVU2Rk45Q1J6K2t4d3FqZ1IyWks4djN0WXlBUlArelFKWng4bC9j?=
 =?utf-8?B?VEtaamQya3grV254WnlkWklSZmVqRmhPUzhCb0dvRk9oalNmZG50bmtRL2hy?=
 =?utf-8?B?bWsrbXBCMGFXWjJ6aHo2NXlOaG1SWExGRG9GVEMzSUwwU2JuRUpqazBkeUls?=
 =?utf-8?B?QmxLZjdCMjhKRFQwY2M0enRwTVdsQ0J5UzUyUDR4VFpTRytucEw0S2dLeWsv?=
 =?utf-8?B?S1FScHVlTzRuWVl6TUExOEo0ZTBlOUlvN2NQRkhFZ1JoWDVYanczekxTRU54?=
 =?utf-8?B?Z1llL1lrMU55YmpaNmRPby8wSlE5NTF1S0RXQmxHUndheldQL0c0Z01aRHJn?=
 =?utf-8?B?aEg3ajhqbzZSblFsbVREeWNTRnllaGtNMHpRemRWMlZyMEs1OHluelNwVm9O?=
 =?utf-8?B?dVBndGpsdG5ncnNRUzZVRjRVUFBiMFN1WllMbWZmd3JoRXJXdDYrbXg2V3pO?=
 =?utf-8?B?bjhCSXYxYmZUUzdCaHRsT3ptN3BVTm02WHVKYXVsMHpBaWdHT0lVdTExUnlD?=
 =?utf-8?B?LzZPS1VldGhWa2VQQ0NoVDBaamlUM1Q3b1BURi9ITUNUQXNCYWtsRWFzVTJV?=
 =?utf-8?B?VlE3RDkrbStCVmJqb1IvWXJnWTdYd2hZdlpjUzFEZEF1aE9Lem5OQVZHazVR?=
 =?utf-8?B?SmM1RHdGVWR2ZTMrZENsVTN6ZXhWaWdOdXVQN2NlKzJuZ0xHbHFpUWxmS1A4?=
 =?utf-8?B?OHlHWUNuV2ZOOFVaUWt0eU40K0NSYndqR0YxRWdKekFnT0traVI1aDNTMDlj?=
 =?utf-8?B?Rm1tSVVEcVMrRFgrTlJmRXNqcEJuMUpaMWZoOGgzLzdvZmgzUTJZNEMrajgz?=
 =?utf-8?B?UEQyUGNqaXRrOG44UCtxQmU4MmFwS0pxa3FjMzJrNFhKbDAyaVNUS0Q1ZmVV?=
 =?utf-8?B?SFdtNmdSQk5BSFVlNHVYKzVjVm1xeEhQNnE4Q2UxcTBnbDlQUSs3U2xiSTZk?=
 =?utf-8?B?MlVzaWI3QWhDaWJLeTEvcHRva0p4VVcyNzNpMjFaRUYxYTVEY29qSXNXZUxS?=
 =?utf-8?B?TEs3Mi9CN1g0S3dwWEZITzIzbVdyeGlWQlRteStNMVQwVHpJL3BwUWN3ZFEw?=
 =?utf-8?B?M05NR1ltVjEyb1hDRWF4NHRhK2I0TFl5VklXWjNmV0srZ09YYnJuNkQ5dEdp?=
 =?utf-8?B?b0EzeUh2cG92NUVDK3NTZWZoZW4yZWJXOU5kVXJsSEpmd1FYTGRDMFFjZ1JL?=
 =?utf-8?B?UHBpY2V5d1pxd0R1LzlvS0t6YWlQZ3drSlhJWGx6WlR0M1EweHV1RTFHNXdu?=
 =?utf-8?B?V0M4blhTNm1yZ1N3VFAreGVXbGR5VkUrY3g0Q1FsLzlISlRlUnRKWk9jL0du?=
 =?utf-8?B?a290dmpEaDNuM3k0MWp5b0p5cGIrK3RxdmlOMmtOSkg3RHhRS0JXbXJWMlBu?=
 =?utf-8?B?VFgxN0RQUG9CL1RaUEl2NFBDb2FXQ1ZPaFNJMVJ5UkpXSENiMTVxcUNseGdm?=
 =?utf-8?B?bk8rNDg1ZjNwbWNEQkRZZ0xxTmM1WlJCY3NhOHorclNWZ1dPQWpyR2l2a3k5?=
 =?utf-8?B?a2JpekdJbXpDby8xVFc3c3ZpT3libU9DTmhnRXFvOWtnWUg3ZUlJS0FiMVZ5?=
 =?utf-8?B?UCt0OHpyNkNHR3ZnQndEME1ud3hyVjhjWGtQVll4UWVJY1UzS1pFcmxMZ3Rp?=
 =?utf-8?B?Y2lNeGJZWDU5aHpnUldadEtDcjFyWDl0YTROd0VETWc0M0UzbXVUWWVaSDZO?=
 =?utf-8?Q?qi/l4O21Vmvxwlh8LmA4Zve5m0Lpd+pn2JF3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjI0UmVvTDUvN25UY2hWS1VZRE1WRWFUMjN6b3JURFhMdG5RYmhGeWFzSzVI?=
 =?utf-8?B?cmxHNk02NUkzVW1RZDk0NVpkWE5KZmQxQjdzeGg3VUY0SHdDYzVNbFZlYkhw?=
 =?utf-8?B?UlZnOXNkSU5iNTNla0ZuRE5PY0ZlMlZORmpTV0psVnVmMnBDVlB5WE5GTVBX?=
 =?utf-8?B?TEdGR0ZOc240QUR2aXdQVFF1Z2N2NkVSRDFjUVhydDN1U2FoYXZsaC90MWQr?=
 =?utf-8?B?Uzlkcy81WGJVUHlNU1ljZDd2RC93NkNUOGtLblBpaUxWY2ROWUFzeUYzaUU4?=
 =?utf-8?B?anhtM2VVMlZ0RWlDcHJDeitMMDNPcWRtMGpycEEybkVyY0ZnSW9DNzFFS05q?=
 =?utf-8?B?U0oyODdkNGZOQU9RbjJpQ2lhVm96a3kxU082MndlZlkyQ0ZJWHJQR1RPRFpJ?=
 =?utf-8?B?NnI4Sm5SaXl2RzdzdmoxdnQ5d3pKZnFKWkQyVURIcDk4SkMzNzhOZ0VWaW5q?=
 =?utf-8?B?MTEyS1FrMTFUSzN0czMxRndmYUN0aGlHVThISXFNOTBQUG9TejdIWTRWVlBn?=
 =?utf-8?B?NmkyZjFTeEJVS2JsV2RQQ0hJNGJhcXViWFpCeDMwTnIxb1RQSHppTUVZNW9D?=
 =?utf-8?B?a2pwdlE3bC9KK3hWUmpUSGppaDdBUGtoOFBrRWZZVFdRa3lHRTg0MGkvOFdm?=
 =?utf-8?B?SDNTYVZ1VGQ0S1AzOHZLMkQ2aXhyMFRmOTMxL281K2xWM3lORWhsSVNvVUM0?=
 =?utf-8?B?MXFtVGFvN1hSREYyQ1lTSTZaTE1IQkt0dWZ6QU0wdDJORjRiMm10RGE1SC8v?=
 =?utf-8?B?N25KUCtRWng5OGxBMG1VVGp2ZXd2cnNadENGSHhhZ1NIUmpaa3lhR0R2bWdh?=
 =?utf-8?B?d2dGLzlTTmlXNThtSGRWaUJxemlDVmVqamd5eG1leTFhZ0EzZTdHM3JJVmQ5?=
 =?utf-8?B?S1oyL0QyL25xY0lPY3NwZ1RpZUVuQlVKZSs2TWs2cmREY0pUMHlFekFwK0Zm?=
 =?utf-8?B?eURnL0ppMlhaZXNkcy9GUnZMYW12MHprK284M2w2UW1FQWpERUxiZjB3MFpI?=
 =?utf-8?B?WXVUNllKaVAvUWowbGlkdys4ZVJLajFhY1czNWxFQW9yYjJNbWszMmJuK2Vv?=
 =?utf-8?B?cjQ2VGpxZGs0U0phQ3FHa0xkcGl4WCtudFNNZTQzZTZxcjNEOWsyczhZNEVI?=
 =?utf-8?B?YmpSQ0t3SnM3SytNaG1SSVQ3cDVZbC9PM1lUOHFmbXdvT2d3NGxZV0ozdlJC?=
 =?utf-8?B?S2l2S1dJQ3JwZjBEU1lnZ0YwZFozUDBCTGloMFh5RUMvWXZCaElzYWhaVWpt?=
 =?utf-8?B?eHN3aHg5R2VDdzlFdzVuTTRJYnMzUW9hMk9xeXB2NEM5bG1BVzNKZnZXSzhm?=
 =?utf-8?B?STFIampLbGJqVVlraWloS0ZIRG1nQkVUdjJlaGtJSDBVUjRvbDRpeVlncnlv?=
 =?utf-8?B?M1JwejBQWk1BOUhUb1IzcS9INEZhOXM1V2R5Y0FXdnlraXB3Uk81RW0yTkxK?=
 =?utf-8?B?dmsreU1qTzNXSFJXcGtPS0JmTXB2akJlYXZ2TTJCakRLTm5kd3c3V25RWkgr?=
 =?utf-8?B?d1VTWGtVK1FRK05ScTZNREdmUFpoeTc0QklDQVV6eEc0SWpoM3k2b2xxdTJP?=
 =?utf-8?B?Wit5ZENlK2U0UU9nUW9yYmRoRzVINTZqaHBwZjBjY2JoTVhUbXROM1VTbGFQ?=
 =?utf-8?B?QkRTMWovVmZYdldzWGRkVllJT0JLVGlnQk4xSy85K2NnSDlrZHJSWVp2cnpR?=
 =?utf-8?B?SlhoRHZTYXMzSHFDMDRRTWtxV3Vva1hqS0tURTI0d3ZqZzM5bXZwMkZDb1Js?=
 =?utf-8?B?enFEaFJuaVdjdkl0OXNORG5iZEFCNmVhWGdzSzJMNi9veGFPbkxVSzBsUlJr?=
 =?utf-8?B?YzZ0Mkkrb3Z0SmtEWHIzYzF3cU56VE5jQXVhV09sOENOU1RHbWZXN1ZKV3hZ?=
 =?utf-8?B?dVNRcWxTaFd2dE1EVEd2Nm5aY3oxOUszU1ZMcTVGWkg1MW93RGUvYU15Q0JY?=
 =?utf-8?B?SHFiLzVvVldraC94emh3ay9VcjRiV1pEOC92NHRFaTRqdUxMNmhjZno2RHdn?=
 =?utf-8?B?ODZSUmtRajFVT2t5WnNuV3lNZml5STdNejlZdTNiYk1Fc0c3MnlyVU9YUlIz?=
 =?utf-8?B?VTR2dlB5OExhYWQyd1hLaUJLenFTcDBQVGJEVWJ6Z0hYNHFQSG42NEpDVEtr?=
 =?utf-8?B?TXljUVJWNks0Q1dweGFSV3hlTWlPQVVpemUrZ003N0VkMFNJN1U2K3JMcklq?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA0D218807E5C4B8554422D6B76C8C8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+UPjjIQap048ThiC3kY7GuY+07Mx5T5LyEOy6S+jNDtsEHM3YsLgHTAXs5YMJtI1sIe33rj7tSHjtX02Ci2FYz/Pg6pN2FdVlH0b+ubb69xd/G6VxgSOKhr073b36wZtvI4vvrHesklwBllySGGNjNTncdhPPWS+MJpMalDzGdixdlVaBlZJcfgZF5lBDn8oTDA3VWZzv3pHnf12b8xAjg8EbV1vGtSC48FMsotD9ojYcPM4CLIWHLlVJgUz6XXC5ksgli45cRjkdkujtIlmiNuzqIlHPAuwhmoXTIwV1g631D/IvyCdkYsQgSTsh/4GToFjaLCxy4YVUQRXM/iRH+7ZCDA8/6xjPuzlZBrnvBdiped6gFrHqFT7u0UY7yKLdp1YEYkHXFW9uoQN43JU1bfFbc82gbntGZHf3MUpE9bSGGf+ReErAXAiVBHlfMs5i6YQw+Exk1uze+uqiaV4HIVwz/hRoVb9X+ej6TveeyEuHTl4+j4OZLScgTyeJN8YBM86YJjNTP+lGq5SpBBg3wcCOsiiR/jhkrBjS4BAstDbm7dYUbR8T05UlbsXAjvuP1infl1cYb0rAofkSdztDPLTTg5B1Lig93nzNE0cYxDS4dvpJnGfobh6B3LWHuTi
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99320c8f-6b87-45de-e198-08dc73efd42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:28:27.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXGlm1P8UC7yYIbKNH/HC2C+gOi34J9Kf258AKGC2jOJBlQ9rxUtlFYh6HsqtB9rXvuiYXoIsP2/a1dMUifZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11708

DQoNCk9uIDE5LzA0LzIwMjQgMDc6MTAsIG5pZmFuLmN4bEBnbWFpbC5jb20gd3JvdGU6DQo+ICsg
ICAgdWludDY0X3QgZGNfc2l6ZTsNCj4gKw0KPiArICAgIG1yID0gaG9zdF9tZW1vcnlfYmFja2Vu
ZF9nZXRfbWVtb3J5KGN0M2QtPmRjLmhvc3RfZGMpOw0KPiArICAgIGRjX3NpemUgPSBtZW1vcnlf
cmVnaW9uX3NpemUobXIpOw0KPiArICAgIHJlZ2lvbl9sZW4gPSBESVZfUk9VTkRfVVAoZGNfc2l6
ZSwgY3QzZC0+ZGMubnVtX3JlZ2lvbnMpOw0KPiArDQo+ICsgICAgaWYgKGRjX3NpemUgJSAoY3Qz
ZC0+ZGMubnVtX3JlZ2lvbnMgKiBDWExfQ0FQQUNJVFlfTVVMVElQTElFUikgIT0gMCkgew0KPiAr
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJob3N0IGJhY2tlbmQgc2l6ZSBtdXN0IGJlIG11bHRp
cGxlcyBvZiByZWdpb24gbGVuIik7DQoNCkkgcHJlZmVyIHRvIGhhdmUgdGhlICVyZWdpb25fbGVu
JSBpbiB0aGUgZXJyb3IgbWVzc2FnZSBhcyB3ZWxsIHNvIHRoYXQgaSBjYW4gdXBkYXRlIHRoZQ0K
YmFja2VuZCBmaWxlIGFjY29yZGluZ2x5Lg0KDQoNCg0KPiArICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ICsgICAgfQ==
