Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B633288DA
	for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374674; cv=fail; b=qT2XeS+F9nYXJYWM5dTMNVxmN65o4UjrhFMXnBfC5bHaPWDIiy4uRvXmtqU4Ns6lzGPVWeikECk89RUtyQ6HaW4a8Ja6nHU8LAxcSZEbd76iaO6OaxNaI4jQf68pX+Z4UC2KQzbH2iEi+iZlBiVP1/ZfLK0BHrsdL7ECVwtCdBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374674; c=relaxed/simple;
	bh=aVWd/qpdyz3Fbv0/WcVeqR+s21+W1VFPuEq9MyxENeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYAuftaeK6dlgWG1nILoRoNAt8zOZmjwDc0HXNVwfuS4KNXKgDxNkEcabQDMPOT6g8wLWdiS9yrPxPTIFyxXavB0ZyEJiG671aiP8rq9PFRkPKcrAKgn9p5/1D9Rfk5/IiiK8KoB3tL+zGrHo6nad8Zj+Qu0nUCdWqTfYrEWycA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ydjt4RTe; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ydjt4RTe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1747374672; x=1778910672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aVWd/qpdyz3Fbv0/WcVeqR+s21+W1VFPuEq9MyxENeg=;
  b=ydjt4RTescWVPnzScxE4I+OkmpPtKSfeuF+a+tM7fzivg20JwUH/axTK
   EBjbtHj9XnRRc44wokkvUxZ6mFrfee8ipZQioS0edwHrob0q1h6Vzmoct
   dYo1SWTC4L/FaQBZaGirSHQg3l9Z1N5VgHTaIBjDponqNZnvo//Z5vZLA
   fcniReIv7zPL6y85XwqekawmlzAT/q8cnbBjKlg9R5dQOZF668OM9jPiO
   Xyt52cLeryOWgCn87l5S7AroE3x5fvifzJGLf2UWx2qfF6PGuKgy+mIvG
   DrFcrDirO9B2Pxtfsm5dKmE4fpQ2cShCkLjTFVMscoxT7W0vOur4XlIFq
   A==;
X-CSE-ConnectionGUID: InLWjSE2SLW6yxXG+aj4DQ==
X-CSE-MsgGUID: DS3zvrjcQAaTecYmnp4e4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="155767140"
X-IronPort-AV: E=Sophos;i="6.15,293,1739804400"; 
   d="scan'208";a="155767140"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 14:51:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG8HjrIQdhsjUpSujMmwIuo/IUqBwi1zGhI5mOcsSWcKEt9XD5v9iWMWUY96o5TNFqCG99UeCPTTiT3UZVkeWafFQiTEzUFtpRG+gBBrpKnzC83dounXRQm7kit3CruY0XVHG4B2b7NtmJKAXhxOGkDmxmWeAaxRgNK+NXhg6uz6AvkS8n9tpYjHTuEQYycCru10iXUHrC4h1gpq+jLsbQO4fy7KEqa0sIZz38e6GnyzBev6PbHzrRBXGFg88C0p4uIn6W1GWapSQTfKhv3JwIOeoA3qRHdv6/1jns4y1ebVNqw2s1Zipy2pRzC+VUefyy0Gv+IxDDj6uQE/GRx6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVWd/qpdyz3Fbv0/WcVeqR+s21+W1VFPuEq9MyxENeg=;
 b=CqtHhHLP1hk1E0Enj1PkR+VSzpPPUrKjxkZrFs/thrS1J/Gdy8rjOEbQ+4YB216Tp8yH3x4iiRPcqxZoFyCDyrZjXFWRwLqoUCXRjO6/nDXLODzaBSV/ZNXcuW62fQaFnikK2eZRCvjY8sfa9lMcea3Pu5U1uMw2y0fZ+hP+ixnzgv8nQQ8TtBS/j9SO/TWZCfEfYuIJIDCc/z/dZb+mka0QzziV7uXJxrX8zjHdlz4ra071rrenL4xKieo28TCoYFyQt8ZPQ+0Y5faVuoX8B3WLpgMoQtvSwSuFhZL7HxL8y5Cm6H+osQKMHQeXipjMqfMjiztmsl8pmhkrKrUlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com (2603:1096:603:8::10)
 by OSCPR01MB12912.jpnprd01.prod.outlook.com (2603:1096:604:33c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:50:59 +0000
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4]) by OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 05:50:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru
 Kitayama <itaru.kitayama@linux.dev>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH v13 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Thread-Topic: [PATCH v13 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Thread-Index: AQHbw/iRDKLeglXmT0KpTBjmUaHMCLPUxQwA
Date: Fri, 16 May 2025 05:50:59 +0000
Message-ID: <c9afd4d7-d755-4e6b-b541-ce29da885a13@fujitsu.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250513111455.128266-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1557:EE_|OSCPR01MB12912:EE_
x-ms-office365-filtering-correlation-id: 46d07f80-5c31-4ac9-b493-08dd943da266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHJSZ3F1QU9NazlMeCs5VFRZWlE4Qjl6UXZydXdpQ2EyQUpuRzZzOEdDM2Q3?=
 =?utf-8?B?MTRWenBZbDFwbFFCNTJCNTZ6cnFCK3NJV3dHaE9MUisxN201TDBGSWtENkNK?=
 =?utf-8?B?eHNJSURZRFdabFBHTnpVdkEvSDRPZmtDS21BbkhuQ0FldkNiVUVFS3UzSHlV?=
 =?utf-8?B?Z09xZE5xU0gxOVh0bE1LNVJGZ3h3ei9oMVFRUEJHQTFGdUsvWE1iNDY5MEhU?=
 =?utf-8?B?ZU1lL1Z4TkpoRTNYUzNRaXVtUDJKUldzU2tlazBsVmk2UEtNYW9ETHFLWXNR?=
 =?utf-8?B?ZFVORGFyd0dYdDRFZDMxdGVIS0todVFPendHZWpLbjRJVkE2VTgyVk5hRWI2?=
 =?utf-8?B?THdoUXZSUGR5cnVjVFViN3Bpa21FNHJSUTdOdlYraEhWUXJkdG5sVlJuRkdG?=
 =?utf-8?B?b2xIVVd2UkRoTzN2UlFGOE1WT0l3Wk83UFAzdGppRTE5aDFGR1FtKytzOXZV?=
 =?utf-8?B?WGk2SXpzejJNcW5jSmM4aWRpQ0ZYdGk2S3dEOStFUEYra1RXL08xUEUyOEdH?=
 =?utf-8?B?TVRrWUhWbnJiUXBxOVMwL0Evbjhpemkva3g5S0JvY3UyeDVvRnJ1cjZWZHBa?=
 =?utf-8?B?KzAwUTRuWFJPNzVFK2xOaUhuQ2xPbk9tMkIxYzlSWUEzbGhvdU0zSVdIdlNa?=
 =?utf-8?B?djNSYnE3Z3ZlcnNOeE44cnNGSUhVeHFBUkRHeFZPNHpPWGFVeThuWlVlZUZV?=
 =?utf-8?B?Wm8yM2d2VGRFeFJKQ2RnK3lRZTNlN0hnU3hucFV1K2p6WGxEbmpIcTc0MzhP?=
 =?utf-8?B?ajdRd2RZOFVlMGdMRkg0aU90MWFxMjllbXlodjV6MWMyWXVtU1NNTFk0R0xl?=
 =?utf-8?B?L0RyUFhCcDZLZ3pJaGhPbTh0KzI5Uk9VeE9MQWxTbWgrLzIrajIrU0ZDNkx6?=
 =?utf-8?B?Y28zMVkxazZzeURyM0MrVHI3YnZLazZyN0c5S2I1QnprREJmUUNCSVMrNG55?=
 =?utf-8?B?dUdDOUZkaFpjTnJzZFUxblBrSnhYWVVHaW9BK3NQUENzd01VNlY2ck9rRVpr?=
 =?utf-8?B?a0MyWUhkL2JSSXlZdnZpWkRQOTY4M3BRSmhwLzdvOGJlZTVUQURHbVp4WlNo?=
 =?utf-8?B?QlR1OHdFbW4raVE0aW9ucjhBck5kbHg2NjVYODJRRHJ3TE43dHovZHMvYTVh?=
 =?utf-8?B?U3BSUjV1UkxXMnU3bitqQTdVd3pvOHUvbFBSanZQL3hScmFIV0JvQ2pTNi9X?=
 =?utf-8?B?QXQ2LzIyN0ljU0pyTDFNQnhOaFFLaElzTlBqQmxReDNMeENxY3NrQkplTGZK?=
 =?utf-8?B?Z2xtbUN5cFZYMHhaVnNvbzg5OE94VGNJV1NJNkRUa0p4UlIxbEVTMWNHcVFJ?=
 =?utf-8?B?aDArSnB5czB5Zk91R2JoV0xnY0k0enFHRldnWGpJM1VCbGNiMzBVTHVLM2RN?=
 =?utf-8?B?Y09pM2QyUnduc2lrb3hTK3BoVzhRM2RyMkExZ28vU2hvYmExNTNhOFk5UkVS?=
 =?utf-8?B?Qm9jNmFHTFNqRjZDdWtwQ00rakFEVmhncjVPWW9kWHJ1djJwaHJPQklXOU5p?=
 =?utf-8?B?Yk5JY3lQN09RQWlxZk12NFkwZmQwQkF5NC9XMWJOWGl0VG1Dd3pOdWlaOWQ2?=
 =?utf-8?B?Mm55REI5YmlwS1A3djB5WTdJRFQ1SmlZNGx0dFdGSTZDQnhXbnlkaWl6VnpO?=
 =?utf-8?B?R0htbm5adW9ub2hnSU40Z0xhSXRaMVpEUURFMEpKVXFHYXQ5THQzMEd0N2Jl?=
 =?utf-8?B?ZjE5UHYvYVVUb1I5MXBORFVoYThWMHRBdmFXY1hEcnRxbVFrWEZ5N0Z0NHpE?=
 =?utf-8?B?NkhGWnFWdDVvVkRtQjZSSmY5bmJBeXE3MnBYRGRGZ2xialJZNU90Z210Titr?=
 =?utf-8?B?L0tiM2k0VTNRT0VCaFRITVdPREZkYnMxNjF6UDcxblh1bFk4R3lYTGNtR1kx?=
 =?utf-8?B?Y1UwWkNpeFpIeWQxVmQzWWhKMGJaQzNORm1PU21wdmliQmNFSzltcVREMUlD?=
 =?utf-8?B?NG5ueDBETzl1cGkwb0pQQWU5NlNyV1czcDBnZThGUWNsck52Vnd2VTdMUFpD?=
 =?utf-8?B?YXFTZGVOQWMrc0pacDBoM2xmcnB3WVBzNnNwZ0hiV1FXWmxpaE9SRVpiR0I0?=
 =?utf-8?Q?6CBSNb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1557.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TExJdVI1eXFKT0N5MHFwNlBZOHdyWXNFbUgzUkk2N21pT3U2a3cySk9STVZ4?=
 =?utf-8?B?NUJvbEtNVkY5OHlKU1FYOTV4MlRPcWxZSUtZZ1JrTm1zZGxNREZmZUk3Vm9l?=
 =?utf-8?B?U05LV1E0VzZ6SER1eVdkUnpaY25HVFFzMGxwdDZ6VW1QbUgzMzI4YkFSalFQ?=
 =?utf-8?B?RFlHMTV5QjduaGZ3OVlaWWlVTGhGb1l2ZHpkbkZ3UnRXS21UZDBWbVZZMENn?=
 =?utf-8?B?amF6SjdVcWd6MU85THpXbVhXRUU2cWlxRklQajVJWjUwK2lSbU9TajJUNG9x?=
 =?utf-8?B?N2JVbHNQMzF5Y2RoRFdhREIwNDRVbjhmUjFzYmdtbEtvZDJWa1EyaXNhU2VP?=
 =?utf-8?B?M0crZmNJeUYrdzgxdFc4Zm00RTBwMnh6Y1JyN3ZPZ3lsbXpHZmNVZkVXUkdD?=
 =?utf-8?B?MlM5UXluWk9TeDVIQ29BRzFpMlRSd3IyU1Y0M0xBRnc1UGRUcmE5eE83T2ZC?=
 =?utf-8?B?VkZyWFBiWDFFSEhhS2F2MFhKY2ZuMmRtVjJ1aXZCeEhkRkNVL3QvV1pmWWYz?=
 =?utf-8?B?NmxaYWtOUnIxSDNTamxoWC9vL2dIK0R1QU9MSmlsSWp0U3RTVzFIclJkTHJM?=
 =?utf-8?B?S0UxemkwK1k5U1lBbkNCQzdaT1B0cXJEdGp0eVhrdzVVYjY3aHJqcElBNG5B?=
 =?utf-8?B?aUFBRzM4UjRPSWhtdzhWWkYvcEQ4VVU0dEpaTUgyUTdSdi9OSk14Q3NaeW1B?=
 =?utf-8?B?OXMwdTJHMTJkUGZOZFI5bWM2eTJmWHk5T1JIWUptL0VJcXkxeGhVakhEbzAx?=
 =?utf-8?B?RjI0dkpmdU84eWZ1aWUyejlINHlObHFoUWE5b2Rpcy9NVjZQbGJXTmFpL3pB?=
 =?utf-8?B?ckE2NGZmTVo1U1R3R09KbUpaUlh1V2JNOE5hSC8yaTdqcDN5WEt3dEtSYjZE?=
 =?utf-8?B?MVVpc2N2ZTNja2tRdVltQ3V1QUFqZmZCbnpOMGx3a3BqWW5odGpiekRkTUMw?=
 =?utf-8?B?M3NQRitGWjRMbUduQkV3MUNvTzhpUU13Q254aTVFaFUzbmZyMVRTclpxKzRR?=
 =?utf-8?B?TitBOFdvSlc4TkRqbTE4QzNSWEpDWjFZUGp2RzByeUpnUDBYUGRtNzMwWlJL?=
 =?utf-8?B?Q1oxOE5EOVptU2FFeG9mK2wwWDZKYUtPNkY3Zm9XYTNvTkxlTlZoV1lxdGJ1?=
 =?utf-8?B?YW1wR1YwRzgvMWY1aTQrUUp2THAvZVF3ZDhtRUdvYlRQeXJoZUdhOHIyejVR?=
 =?utf-8?B?L0lUUy84dHJEN0U4ZzVobHA1VnliZXFLSzByR2pZdThNUTMxTVZlOFhiTVNL?=
 =?utf-8?B?UzBDSjkreGxjL2lvb01wYjZVMW5YMjBkajRFMFI2RGxoQ1poY1pMRjJoWTJz?=
 =?utf-8?B?VEJkMkZ1ZjN0M1JocjdjeEIwVkRmdFcxbjc5NlFENStzUDJPbHNiKzh6Unlz?=
 =?utf-8?B?ZnBPU2hNZm5CcHp1ZkNZdWhHa3BEWlAzUWxyUUpTV1l1VUkyaGg5MFI1K0xx?=
 =?utf-8?B?S1owdUNuNUs3eVhQdm1nN3I5R3lkOUpnd3M2cVhUNm4vRy9KY0htMTVVRFlP?=
 =?utf-8?B?SXdrZDdYcmlaYk8vLzIxOFRveWFiOFJNcGhrY3l0Wk9laWxLSGpsWExXNnpi?=
 =?utf-8?B?YVNnamJzb29VajVXbWJQd3VGNkJtTzhrZEZ6TSthRGtrMXBhaTBka25hY200?=
 =?utf-8?B?Z3ZNN1RNdE9nTjlQbTN6d21oVVJsaVN4Yzl0WmVWUmVMRTZoTDIxMlAyZHpT?=
 =?utf-8?B?STduNDRiTzQ0WUZWQ1ZiSGRuM0tNcnh2V0RMcVNqVDJEZy92QWl1MnY3bXli?=
 =?utf-8?B?UVBRWS9nbndwRWRta0xHaVJtb2RSNjRZUjBvekJ3RnRzbGhCeXo5QU1qRXFD?=
 =?utf-8?B?eTBYQlc2V2l1VDJmbjZGQ1N1eTN5T0VvMjhoblc5dkczYlJuYzBWYk1BaFBN?=
 =?utf-8?B?TGNFUjU5V0RINzhGQkNqMTZEcHpacmF3M1l0dDc2bnVqWVVkb0VvNEVBYnZ3?=
 =?utf-8?B?RzFxUEZqemJydGYxNkY4bFRSMWxHc3Z6bm1JdHlMSFJ1VEQvOGlHUUZOQ2hU?=
 =?utf-8?B?RDBzNmtwblJSRUJGUno2aTVlWXRKWitFWHgyUk95Mmt1Y0diM3BsSzJyK1U0?=
 =?utf-8?B?eHdCSTR2MW00Qjk5WnRXUGdIV3B0ZVpEV2Z5NXM2a3RwVmJMTFZPR21DNzJK?=
 =?utf-8?B?SG53K1pzL1ZLVEZWN1RjclUrVkp0eGdzLzVIQnNKRjFCdkkwUldkWmk3clBw?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14B4937A9F5CE442ABF4178370D07DE9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	su0iWd26XayX3TaGz9xH0CybEYTinv5VQNfZIRbbWr3NFO8uUtACkUlqEdsoH4nDdV5p/nRvPocgBmxMn3fGQbF6E3z8b0QPX5gpQN6MQ+id8kuwA2mXeBdMSxYAydTYBwZacVDZ6HDpNXktGohmwd98M+GII7PkWi1zFlpkUrpxfTg7e0oZhdpk1dXMn+La7Incg7l1QWOWc7Zlz7VUrvJYo9DjJBAWGoFABHz8PBvbgFk4tJsAXxY3Sol5yn9EkKj9kngEtza0afB6KiqeoFuNk4UC3xESvilMcLDL/cvsVSWiRXimKRuocfimhAAo5CK8Kb6WF9GpoN6M/oSGZAjyE8qLFIeX0o2DAPhEfWMuvNETXpOSW1/yvSInJUzfxi2wE1WkOxRkgRHY2Zmw8HnPIlVzzgPEzL4GL9iKsdDntVgEbbXqaZM77nhLMkJ3JHc9qp2J/eGTTKwE5xpFkkJbLn3XxdmmPjImS4Tc8J5gV/bkaCnSmaJ1Bv6duSxDcY1gCAkGINjXYNIjN1OYTFovekV3nMiOotq3BZYnvMipqvSjSmyhm7ADvSFgf+c0/SEqyiIPvdErwmHJBKLhp0J4fQqFp6sqka+2wsvlapS74+D1Ik+7jkyur3QxfCl5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1557.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d07f80-5c31-4ac9-b493-08dd943da266
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 05:50:59.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INEcvw9RbVyO7FjI89zmceAGVI/rmeKty5oguI1eXRIJIt05j/NzxSmf9MREPypBuWxWHHpA8GWBNMCuICQLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12912

DQoNCk9uIDEzLzA1LzIwMjUgMTk6MTQsIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiAg
IA0KPiAraHdhZGRyIGN4bF9mbXdzX3NldF9tZW1tYXAoaHdhZGRyIGJhc2UsIGh3YWRkciBtYXhf
YWRkcikNCj4gK3sNCj4gKyAgICBHU0xpc3QgKmNmbXdzX2xpc3QsICppdGVyOw0KPiArDQo+ICsg
ICAgc3RydWN0IGNmbXdfdXBkYXRlX3N0YXRlIGNmbXdzcyA9IHsNCj4gKyAgICAgICAgLmJhc2Ug
PSBiYXNlLA0KPiArICAgICAgICAubWF4YWRkciA9IG1heF9hZGRyLA0KPiArICAgICAgICAudXBk
YXRlX21taW8gPSBmYWxzZSwNCj4gKyAgICB9Ow0KPiArICAgIGNmbXdzX2xpc3QgPSBjeGxfZm13
c19nZXRfYWxsX3NvcnRlZCgpOw0KPiArICAgIGZvciAoaXRlciA9IGNmbXdzX2xpc3Q7IGl0ZXI7
IGl0ZXIgPSBpdGVyLT5uZXh0KSB7DQo+ICsgICAgICAgIGN4bF9mbXdzX3VwZGF0ZShpdGVyLT5k
YXRhLCAmY2Ztd3NzKTsNCj4gKyAgICB9DQo+ICsgICAgZ19zbGlzdF9mcmVlKGNmbXdzX2xpc3Qp
Ow0KPiArDQo+ICsgICAgcmV0dXJuIGNmbXdzcy5iYXNlOw0KPiArfQ0KPiArDQo+ICAgaHdhZGRy
IGN4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlvKGh3YWRkciBiYXNlLCBod2FkZHIg
bWF4X2FkZHIpDQo+ICAgew0KPiAgICAgICBHU0xpc3QgKmNmbXdzX2xpc3QsICppdGVyOw0KPiBA
QCAtNDQ1LDYgKzQ2Niw3IEBAIGh3YWRkciBjeGxfZm13c19zZXRfbWVtbWFwX2FuZF91cGRhdGVf
bW1pbyhod2FkZHIgYmFzZSwgaHdhZGRyIG1heF9hZGRyKQ0KPiAgICAgICBzdHJ1Y3QgY2Ztd191
cGRhdGVfc3RhdGUgY2Ztd3NzID0gew0KPiAgICAgICAgICAgLmJhc2UgPSBiYXNlLA0KPiAgICAg
ICAgICAgLm1heGFkZHIgPSBtYXhfYWRkciwNCj4gKyAgICAgICAgLnVwZGF0ZV9tbWlvID0gdHJ1
ZSwNCj4gICAgICAgfTsNCj4gICAgICAgY2Ztd3NfbGlzdCA9IGN4bF9mbXdzX2dldF9hbGxfc29y
dGVkKCk7DQo+ICAgICAgIGZvciAoaXRlciA9IGNmbXdzX2xpc3Q7IGl0ZXI7IGl0ZXIgPSBpdGVy
LT5uZXh0KSB7DQo+IEBAIC00NTUsNiArNDc3LDI2IEBAIGh3YWRkciBjeGxfZm13c19zZXRfbWVt
bWFwX2FuZF91cGRhdGVfbW1pbyhod2FkZHIgYmFzZSwgaHdhZGRyIG1heF9hZGRyKQ0KPiAgICAg
ICByZXR1cm4gY2Ztd3NzLmJhc2U7DQo+ICAgfQ0KPiAgIA0KDQpJdCBzZWVtIHdlIGNhbiBzaGFy
ZSBtb3N0IG9mIHRoZSBjb2RlIGluIGN4bF9mbXdzX3NldF9tZW1tYXBfYW5kX3VwZGF0ZV9tbWlv
KCkgYW5kIGN4bF9mbXdzX3NldF9tZW1tYXAoKQ0KSW4gYWRkaXRpb24sIHdlIGNhbiBkcm9wIHRo
ZSBjZm13X3VwZGF0ZV9zdGF0ZTo6dXBkYXRlX21taW8gaWYgdGhlcmUgaXMgbm8gb3RoZXIgdXNl
cnMuIEp1c3QgcGFzcyBpdA0KdG8gY3hsX2Ztd3NfdXBkYXRlKCkgZGlyZWN0bHkuDQoNCg0KVGhh
bmtzDQpaaGlqaWFu
