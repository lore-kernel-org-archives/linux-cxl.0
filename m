Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283A33F6
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749431948; cv=fail; b=MU9cNyOMoL8+cQ1HjSFSLsdtukSg5t9x8VvthkouudZ6G3wsNyTwK5exWegYdNmjgaVAJtJgGfi7SEmlzTylzx/MG8gW94xCvR/XV5fMankNPSbu5JXbREEjV1mucYqF0NOJpinOIF3VWM5MDcDWdWWSM2dBIYv43InpFowAEpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749431948; c=relaxed/simple;
	bh=6RWKhABeax8dEW1+kH4/GuPyUFHEhGKfOVsJIVpvXdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RG86mPJvqUo8Nm3f1PwMXBfwLlMAkHlI7AAV5c/u2DbYNoiNNt627W22KQji5kuWW3l3QhursWT83q33RKu8rM8OX1rwSyoyxdiHgRfHVnNXRRYfsEu5d/XDlUJdrAq9Srp70e+/SYFXfLQ97zvk9PEqUnOY4pqk4B+YDYoUEOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Jelll04d; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Jelll04d"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749431946; x=1780967946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6RWKhABeax8dEW1+kH4/GuPyUFHEhGKfOVsJIVpvXdQ=;
  b=Jelll04dluS+LvMejSr/4mNQp3zzekiiEC+sIjoMQ9cwEjFgagXTGpK+
   v1xm1+OT8Z4QopdyGRVvZxIYdyt2vIQomfFQPE7XcSi7i13dgFd2mjc7Y
   5dVBtXXofhCkwUYOteLJYNJ3ujtTvAwM+cf3SQaNd9X5UWerAbnZWSrWC
   svESp5dRpARfp8fViU7mztEP0tQLmNnFSYUeOFMKda4Q7ifwNqdDRmTlX
   vl5tADOGm0rOSqcx2KaCA4znQLBImLxwh5uRu0gV85JsGdk7rf36MMNrj
   46GbP35P2y73qga3qEMuAyF24GgUpS6CB9clRVA/kcgOR31cA9cSP7c8q
   A==;
X-CSE-ConnectionGUID: bzy2+/CBTTijuGftETHf+g==
X-CSE-MsgGUID: d82orkvFRkmc8QPW4elX0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="158067206"
X-IronPort-AV: E=Sophos;i="6.16,221,1744038000"; 
   d="scan'208";a="158067206"
Received: from mail-japanwestazon11011039.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.39])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 10:17:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3Xa8EpComJcnljFMlmPPS7IQp4I/UYIAbN6ZNNex2nugF1l/0jOX2Z3HkNbEFlXBhsJvLZaoc/O9UqmbPDUKp8v9hot9lroBH3KU5lEAyaZHJYk74lD0idXGdop8tsppltKCSTtmq7CPu29RJuEf56qztwATUbPxIxayKmk5NdGWDewWL7pQh8/T680TvLS9vBkF8KZvGlTckrFGbsAVI+N3fI8aLflpZ9H6iAcev4xfkALnuAC3r+tuWcq+SjOyyOfJ6QSIIy7+ACxwctRx4OOoqQJzr+HPCPEpNeSVV1ktHEckU9bjgPz85yKixzoIbirnTFWDal3LI/KtFcL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RWKhABeax8dEW1+kH4/GuPyUFHEhGKfOVsJIVpvXdQ=;
 b=B0g6mBhq7Tx3MJGHpTcUVtIvw0CyvzjRpH5c4aqX3KcmY/gSmJ9amk3qCzpn9v1OI0gyxwzd/yYJIjqPTZb8Cy4L4LKaAGTYduReJNLXM5cei2PgvMt//OaoCT2hqlvU/59cYPJDmbt5qBN7iaE57Wwpod+CnoKWBSPrPGRnJEMSzgd35YYFSnB8ztVsEqAVG9+4lqDxT85pX3x1M0A2180es+U3tWfrl3Y6YHqW6lUbZVAutz1Z2KJXX5+4kWxkoa+c6iie+UQav8AAKuHhYfys0wt+sJ63SIAaGgibA1+iDatUpt47QcM5cUuWR7vf+0Eqm3S8jfqnus4YP971ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com (2603:1096:603:8::10)
 by TYAPR01MB5916.jpnprd01.prod.outlook.com (2603:1096:404:805a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 01:17:48 +0000
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4]) by OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4%6]) with mapi id 15.20.8813.018; Mon, 9 Jun 2025
 01:17:48 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Thread-Topic: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Thread-Index: AQHbz8EDNvm1I8zKRUG6FuZ7CIn/57P6GRyA
Date: Mon, 9 Jun 2025 01:17:48 +0000
Message-ID: <c434735e-d93c-4f54-8c3c-ea419172b045@fujitsu.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
 <20250528110726.226389-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250528110726.226389-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1557:EE_|TYAPR01MB5916:EE_
x-ms-office365-filtering-correlation-id: 51ef0846-4be1-4dfc-338e-08dda6f372a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTNDVjdkV29iYmwxSFNJcDdicHhiL0RxYmJvUk5OK2R6bjB1NndoNXhMWWR1?=
 =?utf-8?B?amxScnV4ektOVlJWRzhPZ2dDWnFrUUhrVHA0REV0NzUwRGd3K2JQL1dZZG9Z?=
 =?utf-8?B?MFVVeEtNeDM3aWFkbno0RURWdXRlMUZpOXRvb092YjRqZ3dPdWlKWk1sdndF?=
 =?utf-8?B?Rks0KzUrQUlzeFVRRHZtZ0JXY0NsU0VMTUZnSUtBQmxJekliTndYb2c5SVM0?=
 =?utf-8?B?eC8zeFNMNXBFQ1Vtc0hTVGE3MkJMUExJVVRGcFVYcklXRlhWSHR1VFNkY3h5?=
 =?utf-8?B?ZmtuM2xXSXpmQ2x1SVM1L1cvT0phVmFXaWJzNmtIblR4THljSmswcTl0Tkxi?=
 =?utf-8?B?c2ROeGNMTXNiRDRhL3lkcEU1U1BpeDZpczhWdHN5ZnNzQlpKOHc3WG1TbHFq?=
 =?utf-8?B?eGdjcUJSTFAvSlB2d2lEcVI1NkswS0s0QU9qRkwrMEloUmRUMDVFb0ZPWmZ1?=
 =?utf-8?B?U3B1TnJ0NEVKWUVKT0dkb1paNHAwSTcySFRtSjlCdWlNSE9VRWJlUFNuZEwy?=
 =?utf-8?B?d3VtZzNCRzEvWjZyZ2hXQ2MyYTg0ejBRT1NrNUMvZWQwMnhlMFYyL0pJUFQ5?=
 =?utf-8?B?cUdCRlgvTHRTdFpqa0tqT0I3bDNta0pzWGZWWkowaWdiTFV2RHlMaTlMVWpT?=
 =?utf-8?B?Skt2SUJUSElVTzd6Rmd4OG9xQllUbkRpeGtCbFRudW93Nlo3WjJUWHp0dkZS?=
 =?utf-8?B?bUdodEt4VTVoY01hSEZZbHhJbU84dUcyU3ZYSUtKWllZR0JtenJERkFXR3R2?=
 =?utf-8?B?MVdtMkt1YjZvYU4rSU9yd3B1YjNjZDFPRG1YVVpISnZaK0NBdFBTaEZFV1Bq?=
 =?utf-8?B?MndoQ3FIRHZKTFoveXFHVTR1eU11OUJlUWMxWjJEY2Y2QTRSbDNXRVJZM1R1?=
 =?utf-8?B?elRtVnZkb3YzMDZTcHRFUzBvVnZMZ1BNZFgxTGJqN1FGWDFvYU1rUDdIQzZL?=
 =?utf-8?B?Y0JHeUlObjQ4SitOdlpPYkgxcEI0cjNVVlJKc0Y3cGRkVkZZYkdsTXBHN1Jm?=
 =?utf-8?B?YmFNdGoyRXBvQjI5MVRmTDhJQm5aUUNzaGJ5NHVwSWIzVUVuTlkzUHdCT1Nq?=
 =?utf-8?B?NE5XSHJudGVTOE1EUXFlUnhNL2MwZTB0dkc0c0dCeWw3azFVQmpGVVZ2Wmx4?=
 =?utf-8?B?ZkF2ZXdsYkFnU29RMnFIdjZoUXpIeTFQSFVWUEFwaHlDUmcvQkttbHc0QTZw?=
 =?utf-8?B?Ym9mVE1BRlNyZTBoWWExRUY2UjF3Y3JGQUFTd0ljZitGaThSTVdqU0NQMERt?=
 =?utf-8?B?blQ5S0w0b3FLdHJwbDJQYTUvZzU0YkUweitFV0lMa0NqYk1XTXBVeXFZdllT?=
 =?utf-8?B?dHFUanFJcUtrcnBoZVBzeGI3eDQ2QVpjZ0E0Vi9GTG11dU1aVjVaaHdCYWM3?=
 =?utf-8?B?RDkvcHU3a2VyaDRvMkZRLzNLZzFwbHFRalBTRzFnQjN0ZzhZcVBJOFExbTZY?=
 =?utf-8?B?M3JVYlZQVytTVXRoMDAzQ2xUdEtHWlpZV2hhYitXc1JZb2Rhb3Y5UkRYYlda?=
 =?utf-8?B?MkNmRnY4NmtlYUdsMGpRMlpxeTRZZVJ3S3dxckNSQU9aWTc5VFRoV1kzTlNr?=
 =?utf-8?B?UklQZ0pwSS9KcGljcG5sWlRuNi9hQjhWaHQyQ3VJaVlucmJhaVZMNjJsVHY2?=
 =?utf-8?B?dWQ2OG9lU1hoZDNUSDNnb1pITTkvQXFYd0VCa0NBdnd5bEJPZ2JlTTMzcEl6?=
 =?utf-8?B?VEliWnV2WGpIY1Ryd3g4Um9NNm9sL016RXZncVhtaG5EYkZYdHBNeTB5Q3d6?=
 =?utf-8?B?ZGlmNlc0d1V5RExZK2dKRVA2Nzc5Z1ZOVWY1NVh1MjUwMlBpMHdpV2RLeEJU?=
 =?utf-8?B?ZUtyM0J5V3RLdFhVZTN3ZjFXMWVBZGNTaFNDS1M4aDVnUHlwTmhVaWNwQlB3?=
 =?utf-8?B?M2lMMG0wNkpmd0IrTEtQbENBVUIxRzAvTEtWQnNIUDRTT1c1a1Q5MGdFdVIy?=
 =?utf-8?B?Z3BDKzRnRGJDTVVzdi9aNHZ2RERKU1BtdnViTnhJRlRrbjEyV2NGd0kwWjZ5?=
 =?utf-8?B?VitZZHd5dlNsNHRsRk1JYW1qOTZvOGI3Szl6Y2pMYzdBSkx0WC95aXZQalRF?=
 =?utf-8?Q?e6ne5E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1557.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzBEM2tHalhsTURRTWpLT2hrMHdZanNmdGQ2SHpvQTl6Z1Z3T01zNUMySXY1?=
 =?utf-8?B?VExqZ1FRSlg2dCtDRUpQWFV3ZE1ldWZkbGJoRWQzaXVSWnJaL2xqVjZSWWtE?=
 =?utf-8?B?b3JoQ3dFL2FBdEZzVVMrZ1dNM3BoZnd0cEdTOEdNSWhLWk5NVW9TVzZEdU1s?=
 =?utf-8?B?YmZVNWZ0amlOaW1iQkt4QzM3ejNITnNCeUhsNlg3L2E3cGhiTlQrSVVKdHJo?=
 =?utf-8?B?Y0xnQWV6bldkenpVbHM5aWhFbkdpYlpRUzdYc3pVMVB1WUdOZVlNbW85cEJ1?=
 =?utf-8?B?aE9uc0FyeUMvR04xZFlZS3ZEd1ROR1gyN1d4Z1BaOUVFelYzd3ZoYlR4KzM0?=
 =?utf-8?B?WXFNSmFTa3REWTZxOGlWSlFXRjJRTkZGem5lcnJ2OTRKc3hQNXUxNG1CMWQr?=
 =?utf-8?B?YU5oWjZ1U0N6ZFRsUHEzazBoblZFVVRMZjlHWVAveFVaVjhkNDE1ODBvT01X?=
 =?utf-8?B?ZGgwQ0dqWnJWNlFleW5QVUprZ25YKzVFSTJOUEI0UFR3Zzh1cW9nQTF0a1JM?=
 =?utf-8?B?UnQ1S3AwSURtRFpFTFo0WlJRMk8zcENqVytoSjZ0dFNneG9JWjZzekVPcEUv?=
 =?utf-8?B?YzV4MmJPa1pkRXVOc2M1KzNud1F5bVdMaUhWZFNWSDVCS1VtQ3RyTEVZNWRC?=
 =?utf-8?B?NkM3NU1jNWFiWXZydUs3U0tJbEdXaFJER2VyeHVkVks4eXpOa29iZXdJdFhY?=
 =?utf-8?B?M2RUMDRuZnBVOTVGY1BTNE9HcVpzaElDK3FOSHI1bHB0dmhmZWhMYUM1czBN?=
 =?utf-8?B?Nnd2NzFQSTBxSkJQK0xyUXJjanlwc0l3akRBWXYyajI2QTFlTkh2aitWN05H?=
 =?utf-8?B?R2d0ckRBRHhjLzhvVnZTWkZuMkRIcGt2V3BJemxHczk1Q3c3bUk1aWdLT2E1?=
 =?utf-8?B?ckRIYmt6bUtjVEJTQ3JNc09nZkZabVNKeFh4KzluL0xqQ2RUaWRabFBVQUxx?=
 =?utf-8?B?MXI4Z3FIRTkyM3E2aG5JSmlPb0lVdTJUUVRnSjFwK3grS211ckdWNFlrbDFp?=
 =?utf-8?B?T1pabkE3R2dCNVZIbnluSElBM1ZoeEpiL1RNcEEvOGgrWUova3QrQ3dEVlBk?=
 =?utf-8?B?L3Rqa2RiR0R2UXphUWk2bXlLNDZrem9VcXdpaTBlRG5DcmVNY2xwT3kwY3RY?=
 =?utf-8?B?cmNJdGF6YmQ2MEUrcGQ4NWU0VUJXbXBuK0JrMVRsNnQyem9nZjRwTllKNDBp?=
 =?utf-8?B?TjF3VFd5WnVoS3VpdzFzNElVYWZHN0wyMHRnNGllUldtU1RPT2R5bVlaeUZh?=
 =?utf-8?B?bzhSZUc1YVN3ci9lanZmTTNHVDlrbkszbldLQnFaLzNrUGJ4bUFaL1liNHgv?=
 =?utf-8?B?NzY4UnJZRnlabnU4aXhNZ00zTG5EVDZoZWdZcUtxNXFkaXRDY0FDSklhMGla?=
 =?utf-8?B?eXFGRkpOS0kzRHF6WTVrZXFYOUhvcmVGQjhXWFhGUkNLcjJTNW9Lb05kZUZL?=
 =?utf-8?B?bExhWGVGTGV4a290UVFVdzBITVdMZDkwQXBGc0hFT2t4K256NjcvNHlBUHV6?=
 =?utf-8?B?bjdmcWdzVTM2aTZqTGdFSWdNMWVQenBkVGRhdFBxV1dCWmdnYkFWSCtwd1Nq?=
 =?utf-8?B?Sm1BYXdVQVRnR0hIdFkyeUkyNHJBVXJuMGpFclJsZVpwblNQb3BCUGZNNlox?=
 =?utf-8?B?c2NzMzJ6WmRwUlQ3TzFVc0tLZW9ueHlnK0pvVXQ4cUV1aHlWOGR0ODZsNWhH?=
 =?utf-8?B?aXIrUWd6dTI0Q0JqOEhQektEUS9tMTFnNmdVVmRFbUMxTW5YVzRkemc4d0ZZ?=
 =?utf-8?B?alVSUzdNcmJTTTdGVWtvZU4zQ2JnWmVKVW9hQVorWlR5MWd0T3lma04xWHMz?=
 =?utf-8?B?QVZLbm1TbVZZRDRnM1hicnBpOXlDQ2M5MXU3WjBVd1h4d0Zwb1F2NHdjWlZs?=
 =?utf-8?B?UUh4K21iSjMraHpteVJUZVhVNGhkSVYyeXIwQlZlRjQ4MnViZ0dkbk5GLzZQ?=
 =?utf-8?B?cGVkblEyMnZoenFSbE42T3Iya29VSnNvb3MrbzBnc2VHMjg5UU1PY21VUTRX?=
 =?utf-8?B?RUJONXBDQlBSN2dGSkpYczVBbmMvWll4eDlnTWt3UkZGTHpJcVVNV0x6T0cy?=
 =?utf-8?B?NXpjaVdQcU5hdlorNUV1RllESVdobjJyeVVVeGdZWW0rOGxFUUt4d2FGMmFW?=
 =?utf-8?B?STJneXJtMlBqWnZaYmYySnBQNytvT05DTnYvMWdhaUlrZkdvNkpLUUZhRVZt?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B16C058243DDE242A577F8FCE0EA68BA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/kk3BiXeN0StnZlTCVaKLQ9Zc6q3aeJwY9BGtDKuax3vCVswNsLxKsXLyL7BZA2RSV2kdixa8JemVM+lPwSGQht884t++JeiA2OLkNLRrN3MXPmjsMUuLwMEu9+T+5bxfiAQg0MYGIwZp++CLFlxJV4+JhJTh8hjPs0luezJSk7/p+/Rb8Ojx0dpMdD6TSACBlqspPTWb7rQ7LRdkGmovxS7Vp70MqbzsHiQgngiUf3UKal2sEjXPjkU6wk7ChIcD1Xm3WJQWpZfNQCDFoU5dvVerf3dwkKG15U5ZOMeiiE4B3BzSLNvhdakld843J51Hp1VxbMb58qlKCli1rXWC4lUHdBOLTsVPAUspd3lDBHOKheNzzYb4HKueikHbR0fqEUP0VrKYiMPZIxlHio5fD1NMkzK3riMXOz5Z1K0enmafgyIECuhEoedI4TAf8iW2SzgFs5JBfzUvr+vW96M8iu9grKidjwLBcxXMQlK2hbWpoeaBTuWCNGBFlzgf2XKiCVOuI+4rt6eagb0eFfQ/ucmRdVCEqrWLSV5/MqzB1SiopYmnzRbW1TGhsJSqPlR6HMVmHnPnl4uJzi4nx8Hc7AfDGHSweq3xfIzwhMIYsZg2SB8ep2krkm+a2pbL1RB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1557.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ef0846-4be1-4dfc-338e-08dda6f372a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 01:17:48.6484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOnk0qyKAtoFWmRXkcSTBQqwvCPGeGCAaVhoiUJzCExgQnRGKgzNTc0QoXl8l//uY5PBEWIZpFRngYpHBhu7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5916

DQoNCk9uIDI4LzA1LzIwMjUgMTk6MDcsIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiBQ
cmV2aW91c2x5IHRoZXNlIHNvbWV3aGF0IGRldmljZSBsaWtlIHN0cnVjdHVyZXMgd2VyZSB0cmFj
a2VkIHVzaW5nIGEgbGlzdA0KPiBpbiB0aGUgQ1hMU3RhdGUgaW4gZWFjaCBtYWNoaW5lLiAgVGhp
cyBpcyBwcm92aW5nIHJlc3RyaWN0aXZlIGluIGEgZmV3DQo+IGNhc2VzIHdoZXJlIHdlIG5lZWQg
dG8gaXRlcmF0ZSB0aHJvdWdoIHRoZXNlIHdpdGhvdXQgYmVpbmcgYXdhcmUgb2YgdGhlDQo+IG1h
Y2hpbmUgdHlwZS4gSnVzdCBtYWtlIHRoZW0gc3lzYnVzIGRldmljZXMuDQo+IA0KPiBSZXN0cmlj
dCB0aGVtIHRvIG5vdCB1c2VyIGNyZWF0ZWQgYXMgdGhleSBuZWVkIHRvIGJlIHZpc2libGUgdG8g
ZWFybHkNCj4gc3RhZ2VzIG9mIG1hY2hpbmUgaW5pdCBnaXZlbiBlZmZlY3RzIG9uIHRoZSBtZW1v
cnkgbWFwLg0KPiANCj4gVGhpcyBjaGFuZ2UgYm90aCBzaW1wbGlmaWVzIHN0YXRlIHRyYWNraW5n
IGFuZCBlbmFibGVzIGZlYXR1cmVzIG5lZWRlZA0KPiBmb3IgcGVyZm9ybWFuY2Ugb3B0aW1pemF0
aW9uIGFuZCBob3RuZXNzIHRyYWNraW5nIGJ5IG1ha2luZyBpdCBwb3NzaWJsZQ0KPiB0byByZXRy
aWV2ZSB0aGUgZml4ZWQgbWVtb3J5IHdpbmRvdyBvbiBhY3Rpb25zIGVsc2V3aGVyZSBpbiB0aGUg
dG9wb2xvZ3kuDQo+IA0KPiBJbiBzb21lIGNhc2VzIHRoZSBvcmRlcmluZyBvZiB0aGUgRml4ZWQg
TWVtb3J5IFdpbmRvd3MgbWF0dGVycy4NCj4gRm9yIHRob3NlIHV0aWxpdHkgZnVuY3Rpb25zIHBy
b3ZpZGUgYSBHU0xpc3Qgc29ydGVkIGJ5IHRoZSB3aW5kb3cgaW5kZXguDQo+IFRoaXMgZW5zdXJl
cyB0aGF0IHdlIGdldCBjb25zaXN0ZW5jeSBhY3Jvc3M6DQo+IC0gb3JkZXJpbmcgaW4gdGhlIGNv
bW1hbmQgbGluZQ0KPiAtIG9yZGVyaW5nIG9mIHRoZSBob3N0IFBBIHJhbmdlcw0KPiAtIG9yZGVy
aW5nIG9mIEFDUEkgQ0VEVCBzdHJ1Y3R1cmVzIGRlc2NyaWJpbmcgdGhlIENGTVdTLg0KPiANCj4g
T3RoZXIgYXNwZWN0cyBkb24ndCBoYXZlIHRoaXMgY29uc3RyYWludC4gRm9yIHRob3NlIGRpcmVj
dCBpdGVyYXRpb24NCj4gb2YgdGhlIHVuZGVybHlpbmcgaGFzaCBzdHJ1Y3R1cmVzIGlzIGZpbmUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uPEpvbmF0aGFuLkNhbWVyb25A
aHVhd2VpLmNvbT4NCg0KTEdUTSwNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlh
bkBmdWppdHN1LmNvbT4=
