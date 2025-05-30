Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E960DCF
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574058; cv=fail; b=k8pmzuwTjQJJe7wqzBjxRzgvz8q8K8noQIls0cRYhG6jCb6piV9AoERRaO+IikypC0zN+0/rmDAL37dwTiUZdT1wYk9prAsDkKs1CJcUP8f8AmPZRQoTYmcOUAwUzH6RjRYpgFTCyfNTdCNVodB2KHsxkPtw0aWIGih34Ntib68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574058; c=relaxed/simple;
	bh=m2FfQ0ou0PuFhB8nHfzUxf1Gva3kaPQJ2LzWrWEy06g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OP24Ct6RUo96ZQ8MI0zeDfeJK373my+oBS+RdbGY1k/Kky/kd0asrsPgmNUnHaucFlOhUDiZqaj+X/hYt5ux2k2mRHIJK6hKLobwFTkmrhFi1eooXwW0Haq6cWh/+C0cvV9bEy6j03B6wT8e9RExG57yd8LshMjfG6ew79YTsOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qYuH1GCg; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qYuH1GCg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1748574056; x=1780110056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m2FfQ0ou0PuFhB8nHfzUxf1Gva3kaPQJ2LzWrWEy06g=;
  b=qYuH1GCgHdnJEdvE04oodk+pjtdpDHdZ8RJXAwMhpHmRMcTqv7lSJP8U
   dig2sPPau0VuzPiYcly/Myr6e2K1cabCrzYZ5EMRMbUAA0olQsVFchO8y
   VYSir+GrucUI8HR5HnG1tIkPQxUORyBOllO/8zUn/5a/bkxYAAh46XIUS
   3XKnWafKWuEIbVtFgWiECU97utPsqnv4DobeaKTC5yrwWt0+yLjnByv2v
   ZnM0Z9gakpUa+OF8PlWJw7F/5sGI3lzaBwkDA6IoIYl2Xi+oZhfxTkwsH
   ChOMSq4nOgv1IDNLtYBqPUpaGYh2IQBtgTiJG8u79jTHjMu1Jt7TsufCK
   w==;
X-CSE-ConnectionGUID: sOw906b1QgOKe4DrOlPHjw==
X-CSE-MsgGUID: ly6Ws5lKSPSAlJ16lgWLKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="158027648"
X-IronPort-AV: E=Sophos;i="6.16,194,1744038000"; 
   d="scan'208";a="158027648"
Received: from mail-japanwestazon11011010.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.10])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 11:59:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKJF5tA3lXfObPnH28KYmxtm2OowTjfBRTNhM7I0K+PYd/S7YpJUbJ0lyhNEUkjIZKK7klFjwcXLxkS4gup2IF/sxILiDZ43npokfVxvhxEpK/f3djBs80hMOGuwrMkMrHjbMtravg1L202S9MQ4YUyUIEoADX/LaRVpWbFqvAll+pkDnh5nlBxwaR4BqOs9bSZfi12fp98U0wI4pmVu5MadUQW07WWt5/mE9hnlVr/96Kkn5JQgwLSTuTqhU/H9Flsb5x1xyjkngYX6rsbE9xA2dPzkscKyHPBr6ubIzsjjOxt7/BENFmizT6EwXVFrLVmHEuj+tkEDFszO4K8Fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2FfQ0ou0PuFhB8nHfzUxf1Gva3kaPQJ2LzWrWEy06g=;
 b=d6zEEKZGXrFB77tBvPmkpvS1OSmP3SoVUjbuna2CP83dZws6KyBn5nuY2lelzm3MEPdIu4LaVbnbQPg0OPk2OfCr9FQ8AZiQ6D8/8v8LdoBtYc/ZWHaHb5UIEs0Fzo8bmxyysqjQ/UAtgqXVaqbv3uyNTTAaTZnK1gWHJTm/1SmL2YXZhoJbWtA/E6LndyPwBE2pNVxgSn2Q5GVCW/tpxTZ4uC2umcerlLTLwM0lzUqugfPlQAxjWvnQb91Yu9IDDcX/AuLfmlaDmqygsWG9JsNhO0BDE3jt7Gn5hw66+Upu33dq557u/086wUj3jsf7J4F7wrTlyi0ljCXSgD732g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYAPR01MB5370.jpnprd01.prod.outlook.com (2603:1096:404:8038::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 02:59:41 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8769.019; Fri, 30 May 2025
 02:59:41 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH qemu] hw/cxl: Fix register block locator size
Thread-Topic: [PATCH qemu] hw/cxl: Fix register block locator size
Thread-Index: AQHb0KCamovbnXAKjEuq3U0k3jVdELPqfIKA
Date: Fri, 30 May 2025 02:59:40 +0000
Message-ID: <e7050a05-3349-46c6-9ac5-60b621f54a0b@fujitsu.com>
References: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYAPR01MB5370:EE_
x-ms-office365-filtering-correlation-id: c9eb6f5f-5e38-4c03-6820-08dd9f2605ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ry9HbFc4cGVydTlXajVoeUNLVU5PM1VEL2c0akxkQnVLdklxbUxIYzdRaVV2?=
 =?utf-8?B?RVJ6MjFFaFJPMkZXbW5ONVpIRUNjeU9hSGxSMnQ5enVWSTlYNjVtRm1OWVhr?=
 =?utf-8?B?WVcydHEwTnU5R3JjWjYyeVd3bnJ0dEdkK0ZkbUtwcUJJY2xVWS83bUVDQlhj?=
 =?utf-8?B?NEFPc2FLM1VEcnArZEdPSnRHR2ZWMzlhTnpUVTlyM1ZWd1ZvbUhkUVY0UmJi?=
 =?utf-8?B?WW1zWC9vTi9GSHpYZ1pmajZtVyttWHNHMlc2MjY1eHk3L2I4cFFmNldhbnZx?=
 =?utf-8?B?SGhSSGV2S2h0b3Z0SWFGbDg1WG9Yb1BjcUF5dUNjU3dJSVZXL1pZZmNLT0Fi?=
 =?utf-8?B?YzJBNlhlVjFWNWFobUdFOVc3OVJXaEtuOFpWVFV2VFdUcVByV0ZTV3RYR3BV?=
 =?utf-8?B?Q1p6UjRrNzhxR2NqQkY3LzR4Yi9aTHducUZZZ3JIZFlFNXY1M0ZBS2NNWjFE?=
 =?utf-8?B?U0ZVdk5xUGF0WEorei93NkowMjNhbmZqbDlZQVNQeG1ZVzJzSDlyTXJ1ZGpR?=
 =?utf-8?B?VmtnQjZiNnVlb0ZvY3JqT0RTUWRsSStmMStSRkR0WW9mUUh2L0w5TjlvQVVv?=
 =?utf-8?B?bEZmTDhVblVuZ1VuZjc0a205WjlhZUtWUFFmRWhPeFg2cDVXalV5akYwVzdy?=
 =?utf-8?B?ZG5za0ZETm5CSGZia1R6N2sxa2o1ZVQwTWhtN0hXbnVTamtjcld6UWxlS3k2?=
 =?utf-8?B?clVSK0tQRUxnTGF1RjlNTno5aUttcmF5YjJmTGsvL1JpTnNmWkpSY1ZRNDNZ?=
 =?utf-8?B?RHlzYjAzVlRRZG93elJxYTVwNUdQaFV2alVsci8ra0lpSFBINGI4d1BGcW5J?=
 =?utf-8?B?ZW1MUzcrTVNHWmxhNitGdnphTVBpc3JraisxeFN3L1hTd2d1UHpHSXR4REE4?=
 =?utf-8?B?cndCa3dmcml4c2VmQmdYWnZ3TVBsV29kUWFDekJ0akZlYmI5U1AxM1B3cFJu?=
 =?utf-8?B?aHBycGtvRHM2QWlCWlYwZG5waTBSOEpJMEFWWDdEKzNiQ1NLUmhjN08zV2lp?=
 =?utf-8?B?MnVON3cvMk55ZGVFbGlGVFEvOVFTMHgrZk4raUJYemQwcXNSV1E4NEpyUjVD?=
 =?utf-8?B?SENWR3BLa0U1d2JQaWF6bnlEQmRvczhOak5xbE03SUNKbDBMbTZFVm9CQm1k?=
 =?utf-8?B?bGxGM3BERzg0dGM5b3lVcDdoZzVvZTFGNk41R2FyY1ppN21LQWJBM1FPcms2?=
 =?utf-8?B?aWROeExGNk1vYW5QVkY0MEQvUlN4NlBvdmhLd3BGdXhnZStHS3Q0aVVERWFI?=
 =?utf-8?B?QTVpdGVFdnEzcGx3SndERFdVTFhsc3Uxc3QrYitiazVyNmc5RGF2Vk10d3hE?=
 =?utf-8?B?dE5QVGhLdVMwdnVkbEhJUnlnVlUxdEdPeEg1akJTamFrb0hRS3Y1NGJmcENa?=
 =?utf-8?B?Zm85SFdadm9Za1k1YURqelhMMzQ2YjJRNzdRVFYrV3N2bHpjR09FNm5rT1BN?=
 =?utf-8?B?Z3htTmhvVWFseXY2eVYva0tERS9mbldRakZOeVAvMExnRWxnaDQ1WVRGL3Nl?=
 =?utf-8?B?T1EvQThoci9oNWNlMTJ0SGtQVUgyd0VGY0t4OG5mT2JhaDFpZS8rWTNJbU5s?=
 =?utf-8?B?K2wycEtGbHZOMEVVVFFZSjFxUDdGc2NxQXU0enhMWkNhQmo4VkZSOER5Mkpz?=
 =?utf-8?B?VDVNblhxZVpZWDBNQlNoWVRqN1EvWnhmSnY5dFVWb2x1ZEZwQzFYNFlGS3hs?=
 =?utf-8?B?a1B2Z2xYSVVwcDRoS2sxcDBhY2wvOGlLUWFSTWpUeXh3Z0laM25GWUJHMXJw?=
 =?utf-8?B?UlFpWm8raldWMkRKeTUwU0lCbVo3Z2hNU1pVU21IUTRIY09qaDY5QnI1amlQ?=
 =?utf-8?B?a1NZTFBIamxmaTZXM1BrSlIyMVRpS2F6QldZbjl5M2o1bHY5VmpJZ0huNFVD?=
 =?utf-8?B?SGNFT3ZmZjgya28rRG1uZXE5RVdaNEdsQXF4RGEyTVVIVnZjaFNjdStYeFFk?=
 =?utf-8?B?b3l6ZisyZUZUcms4ZjdHdzA1amczQ3JmVko3dlRkaU1pZ2E0bE9EQ3hZRHph?=
 =?utf-8?B?WjJHZWZsZTZ3QkFxb2ZWeDJCNUdlcEIzamhVQ2tHb09jSlVSL2w0VVQvcEZJ?=
 =?utf-8?Q?KJpZJq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0wxakVFOGpML08wMWU4OUFMYktSQTFKRmpXY2lpS0dnRzNQcGhJbFJvbGZi?=
 =?utf-8?B?SEdZWTNEcDlYSkZ6WWh5ZnFqSTErZ1ZPK2pzYVVKQUZOaFBWRUF6aHdBNHJh?=
 =?utf-8?B?cld3ajZEMk84WGlqU1JkNXJhdVpOUUNPYTlPa1Q3TWFQMnNXaURNRWtlMFl6?=
 =?utf-8?B?eGdaWkNGaWdiL3NMU3NmMEsvSXZsZWhnUVg4Rktpbk9ZMXZub1Q4ZW5rM3Br?=
 =?utf-8?B?VlR5NFZJUTV2Q3hpSzdPenpvOHJtaFdNVGd2SGpidTA5TlRkenBSUjA4MWda?=
 =?utf-8?B?ZW5KbjNjeStHdjNUUVhQbWFnbGNvQWYxSXJLN3RieHhnNzJ6VU01NTgyU2Qw?=
 =?utf-8?B?cEpod0x1eUw0Zy9zUm1xNkNiMHJjR2JYNTEyNnd4UTRrUFdOTGdKeTh4TGZn?=
 =?utf-8?B?eWdYcTlYTHl2ZnNtTlU1UHc0SU5qNGJ2T0dTMG9Ma1J4cTM2YW14TEJYWnUy?=
 =?utf-8?B?eEVqbnRNNGlHdmRQQzBGSHQ5Qlp4dU0zRW9EY3FCVW16dVcvdFBLb3d2dDBT?=
 =?utf-8?B?dXM5ZEszNEg5RmNFNFdoU3JoTzdSbW9DQ05NRVIxdEpvTTd2ZHdTLy9iUjhw?=
 =?utf-8?B?czcvc3hYaHdRY3VDZ09kVGlqVUc0MzVSZVpCYmJ6MDlETDY1Y2N0S2h4SGx4?=
 =?utf-8?B?eEpIQ052NldVTkxBMHlacll1K3MzaElFSG40cFVZenhwb0NkeTlHZDZkR0dI?=
 =?utf-8?B?QStsczhSZDZ6b2dQR2pGMGJUTk51N2ViS2p3L000dmFRcUlsekN2NG45L2Y3?=
 =?utf-8?B?WDlUYlhXanlVV1Jta3hOeFlsOWtsNjFTSlYyY3ZQNm85WjJsVFpyQ09nRGJq?=
 =?utf-8?B?V2ZqVDMzbXo2ZE41eW5aMmhJL1lUd3QrTEtjUWVRV2tNRCtaQ2ZidW14VmFH?=
 =?utf-8?B?ZlVldGJScWZKM3dTMldDOThTQWtKaXhMT0dZMFB0VjlrcXJUTW11Z2NIdTJO?=
 =?utf-8?B?L3RjRThmU1hKK1VKUmFDcURjSXdEcU5vNlJza1pnY2VDd0RIS0RaZng2VC9i?=
 =?utf-8?B?RUtsdE80aDdLOVF5Z25qOVhIQkNQdHBNc3M1ZHJqYnBYRUlLZWFvakV1bDg4?=
 =?utf-8?B?MDBBa2tZNmlQbEN6VjNkUmoxdjZXMUVmakJLRjZjMWtnYk1wdVBiU0M5OVV2?=
 =?utf-8?B?bVNFTmpOc1U0L2pIRHB5SmNmYWtWYTBFWC8vQThZZEkxME1rL3ZKWWhvcktN?=
 =?utf-8?B?VGZ3WFN6RTlpVHMxRU1yWVlCcnpiTHE4VWdOUFRHbTNFaHpNTlVsUjBDaEU2?=
 =?utf-8?B?bHE3aHBzWW0wV2pWSGRWS0tIS3JDa0tod0tyekVmTDF0OXhSRGxVZFpRTU5q?=
 =?utf-8?B?eFpyR1A3YVRqc3o0a2pJQk4rZFVVcWhmOThYMFo5djlZMWl3YzI3cmZCbzd5?=
 =?utf-8?B?N1A4THdUcUYzV0pJZGZaczRFNXY0aStVamdJclhSd3h4RDlVY0NkWU1ia3l0?=
 =?utf-8?B?elV4OTN4Vm0vRU51VEtHV0RQVGYvYUNid1lYKzJlaGdVU29rWDNhZ3NWS0R6?=
 =?utf-8?B?OEdYMElGdnRmUWFGR0RucHZ0SGh0K1oyd3RzQnk5b25NcytRNm5yRWRRcHVo?=
 =?utf-8?B?V2FsMmtvMVBETXZ2TThIZ2NOZWZBbUNuK0VqQ0RRYlBPQzhRRzdsSXF0cHR4?=
 =?utf-8?B?TGd6eUc4Wkc2ZFNXbmFrUnRyLzlORG80Yk5GeVpSc3NqZ3F0aHMvWGVRMG1P?=
 =?utf-8?B?MFl2OWs2blBFa1BPY2lveG9SRE9ZNlZXWUdMTGNyWDhmVUp5UTZvSWt0N0JN?=
 =?utf-8?B?YmZCRUNtY0t3YkN6cVhzaElLRTVlaVBPYjNlUE5CajY4YXhISHNBa3FxQU5E?=
 =?utf-8?B?aFN2d09uYkE1U3MrOXl6bjZPN2czZ1hWU3ZJazJBT0RQMUZjcnVaOEMwQllj?=
 =?utf-8?B?TEdlbm1aUFRtakRDNElleFdMVElEb3ZOTjBDb2s1QlZWUDNaL1A3ZFhGUHNp?=
 =?utf-8?B?V3JsRmdPemJ4b0N6VkhIRzRRYmY4cGxYL0JNWlU4SHFMYzd3YW5pM0lHTjV5?=
 =?utf-8?B?YktCSGtDbU0yb1RGTU03aFNWZUNlNGhmZDA3TzkvNjVvdzQzRGM0NkkrdDZB?=
 =?utf-8?B?ZWUxN3U0MUNDVEpIcEdaTVhIaURqVDA2SFk3Y08rVFEwVmVrYmFMRCtTdWlv?=
 =?utf-8?B?QTdweXkxeHdWSVVRcWFjU0dLQ25yU2thSXhTSEhRR2FXNVVQS1F2aENZY1Bk?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDC4D4E71E7E954D8A8D232FF89CD269@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e9/9ZrYF8Oq+5U+gS18fzk2gGNqY25o6TB83j+0qz9DYi0cw2O6q7j7+Z6nKQXYFoT7WhQC9yhzIyy6AdMf49+9zAJkt2tvgsF/dYqW+D5/9giBjp4l0aPXsRvZgaz4MmOP8VXrpvM5YIPWHCcguHDDfVXR6y5RP5SNcE5R5Lt7icE0ADjC0cDEEfRQfe+DdeaqhU9Wkv+A7d4Rlt27iofl7PiSYQH0m1ufq6AaPZtxY5lz+DhmwXc57ajXKU3fL3zewY7Yyfu5qazjNRXwWYF6g8ojR7Of5HTQ3DVydmhpRF0k+hG3sENtg2qDrJ15+zYzlz/wWHCax/RVJ7zaMO4pXFAj6u9zTDxfJ7hh9uuml8yj6PsobqtmSop5l6F2e608gGhUf+ckNOOb4qpjNkaRE+XU8N3ApXWBfuZdZri4OWBCd/jj/3l37i6KgvONaLaB1NyDngrGxrJKpU3BmfuYH1eBxR9KialhbFhzX+QDn1vA1nXoV4oH1QNWv/ItgF5zPvhfGdZoS1flHXc0idojHHcqJr/DKxX8WoZ8KRgEx00Z9dlfeWNWOoincWnlL8gvyttTBJVepxKREz3JqFiNew+piwOiSaBOCbgBm3zd2KZ37vURvhveaXCDhCXpd
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9eb6f5f-5e38-4c03-6820-08dd9f2605ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 02:59:40.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bn+sMIcBxxROyaY7miMQ2XkEgOX0fBj7B1kEd9NS9uVvqTlgetAagcyQVjhYhrBCL7YNvsSwxN5iYWR9MTA+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5370

DQoNCk9uIDI5LzA1LzIwMjUgMjE6NDgsIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiBU
aGlzIGhhcyBiZWVuIHdyb25nIGZyb20gZGF5IDEuICBGb3Igbm93IHdlIG9ubHkgaGF2ZQ0KPiB0
d28gZW50cmllcyAoY29tcG9uZW50IGFuZCBkZXZpY2UgcmVnaXN0ZXJzKS4NCg0KV293LCBJIGZp
bmFsbHkgdW5kZXJzdG9vZCB0aGlzLg0KDQoNCj4gDQo+IFRoZSB3cm9uZyBzaXplIGNvdWxkIGxl
YWQgdG8gYXJiaXRyYXJ5IGRhdGEgb2ZmIHRoZSBzdGFjayBiZWluZyBwcmVzZW50ZWQNCj4gaW4g
UENJZSBjb25maWcgc3BhY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9u
IDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvY3hs
L2N4bF9wY2kuaCB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2N4bC9jeGxfcGNpLmgg
Yi9pbmNsdWRlL2h3L2N4bC9jeGxfcGNpLmgNCj4gaW5kZXggZDA4NTVlZDc4Yi4uM2JiODgyY2U4
OSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9jeGwvY3hsX3BjaS5oDQo+ICsrKyBiL2luY2x1
ZGUvaHcvY3hsL2N4bF9wY2kuaA0KPiBAQCAtMzEsNyArMzEsNyBAQA0KPiAgICNkZWZpbmUgUENJ
RV9DWEwzX0ZMRVhCVVNfUE9SVF9EVlNFQ19MRU5HVEggMHgyMA0KPiAgICNkZWZpbmUgUENJRV9D
WEwzX0ZMRVhCVVNfUE9SVF9EVlNFQ19SRVZJRCAgMg0KPiAgIA0KPiAtI2RlZmluZSBSRUdfTE9D
X0RWU0VDX0xFTkdUSCAweDI0DQo+ICsjZGVmaW5lIFJFR19MT0NfRFZTRUNfTEVOR1RIIDB4MUMN
Cg0KSU1ITywgUkVHX0xPQ19EVlNFQ19MRU5HVEggaXMgZGV2aWNlIHNwZWNpZmljLCB0aGF0IG1l
YW4gd2Ugc2hvdWxkbid0IHB1dCBpdCBpbg0KYSBnZW5lcmFsIGhlYWRlciB3aXRoIGEgZ2VuZXJh
bCBuYW1lDQoNCnRyeToNCiQgZ2l0IGdyZXAgUkVHX0xPQ19EVlNFQ19MRU5HVEgNCg0Kd2UgZ290
IGFub3RoZXIgUkVHX0xPQ19EVlNFQ19MRU5HVEgsIHNob3VsZG4ndCBpdHMgdmFsdWUgKDB4MUMg
LSAweDgpPw0KDQoNCiAgNTEgICAgIHJlZ2xvY19kdnNlYyA9ICYoQ1hMRFZTRUNSZWdpc3Rlckxv
Y2F0b3IpIHsNCiAgNTIgICAgICAgICAucnN2ZCAgICAgICAgID0gMCwNCiAgNTMgICAgICAgICAu
cmVnMF9iYXNlX2xvID0gUkJJX0NYTF9ERVZJQ0VfUkVHIHwgMCwNCiAgNTQgICAgICAgICAucmVn
MF9iYXNlX2hpID0gMCwNCiAgNTUgICAgIH07DQogIDU2ICAgICBjeGxfY29tcG9uZW50X2NyZWF0
ZV9kdnNlYyhjeGxfY3N0YXRlLCBDWEwzX1NXSVRDSF9NQUlMQk9YX0NDSSwNCiAgNTcgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFJFR19MT0NfRFZTRUNfTEVOR1RILCBSRUdfTE9DX0RW
U0VDLA0KICA1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUkVHX0xPQ19EVlNFQ19S
RVZJRCwgKHVpbnQ4X3QgKilyZWdsb2NfZHZzZWMpOw0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoN
Cg0KPiAgICNkZWZpbmUgUkVHX0xPQ19EVlNFQ19SRVZJRCAgMA0KPiAgIA0KPiAgIGVudW0gew==
