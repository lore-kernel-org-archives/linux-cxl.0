Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21E1DF742
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780676; cv=fail; b=P929dh+D9qpgiLVFJAA4c6HI4OhU03DtW9RwjxQEElmnmVgbAeOmx8OjWnbhes4re+3G+pstWu5Pk3M4f9kiAE+bWtR735MeLPoJ3384CHK72jBfufsHzDC78cNcrHgIFqDni7HhlF5MWquve2wsZxbTNWifCCZZhWYSQ4FpObg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780676; c=relaxed/simple;
	bh=OerlPVqZau5lPXJji/fwwJRssV765Tzf3Wkoz/dsk9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYLdYfRiDrha8mDadQqKaaQTHh2UFoeW72OYWLmB4Q4lsCZHiUz5J2zt1goodC/vWDpl96UY6vw9th+QRG5JOvozPK1K6PanFGRQlvDUZ0Fn9SjY2itHzExC9vNmllWA0UIpfX7Jizgt3h9h1Q2EOQ9eq8j+4LYbv6HNNCIcZuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ispOLsdP; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ispOLsdP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749780674; x=1781316674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OerlPVqZau5lPXJji/fwwJRssV765Tzf3Wkoz/dsk9Q=;
  b=ispOLsdPU4XToruqwLZRR40ibMVWrgFEBSh3Hxgnlbs7PxU1Zkc9sT66
   xVX9NLYoCxJDZVQ2BYC52O9RX1tcq8gJAsLWiEeVSr8ZIoJxJ4aWVk3eu
   DtxRY5ICOgCPzvM/AO0otsmisS/aHyICs60P1CQtDArPV8qjveZ407OMs
   OzZUP/eqEnOxWCy9kYdztKa6MUgSQoTTnj8ITrNuDu3HpwpXZo0c8wSGD
   UtiOlljy6swMXqhxDX5tPOq6AVhzwYEb9vV5Zm724WDnmQ4vL/5tvyRTJ
   zqoLq2vy3zQh5geMsEsJtt+3qNt8KRhLeW4SBl5McPhLv0ghzqcjWExa7
   Q==;
X-CSE-ConnectionGUID: ZqtrGsLeQHmb2rkOJFbB+Q==
X-CSE-MsgGUID: 6Dbde2OCTCCQZajUYfwL1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69822048"
X-IronPort-AV: E=Sophos;i="6.16,232,1744038000"; 
   d="scan'208";a="69822048"
Received: from mail-japaneastazon11010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 11:10:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emJ3QEQ4g/yZPbTHTwjtK/fLaM3ThlaVnrGxOjYVDCnQWkktyhiiMG7lsWTixg9GnegS1T+IijpJ+pE//QrCRPM0XF2LU7zvbVUH0XqxQrfDOuRrs1i3V7Ouk8bcOobjiJaoFBQqEUcNq4qyv3t5c9BGjBkg+N9MOVEtUJYsEUWiMuFeQCVaZjQxVaqkcpol5DpQE9baUORigsAkIoHfe692odaZxqSujc0HoSWBUkxjGXCVS2Yi47lDFGr7Oj+pn9UOHmrpXQn1gFjHg7kQD0oiFfqDEFNsvRQaJZZAmoiZoz+xN5EIK0wn3B0y2LwhfHY7t69bBYYUi3Anux96uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OerlPVqZau5lPXJji/fwwJRssV765Tzf3Wkoz/dsk9Q=;
 b=nY30wr+MVbou95NbnBE5Z7ii8vy5qDejTURomtZuKK7/y0Tqf2a930qbv85fQpqx9qhhWe7Bm/+Id4FfhKcmP7BhNdXQLOo7qlEN634d21kA4Sc7WhYZqgLxZ+uDvMc0UlW7J/uDYxS24O9INoZOhmKOFz9d59E9sXrPuBuCiXgGK00mEx60iToPbQCf2b0uBuxLzdAZT0SXpfVIkuw3G7YjU+arjQAn0dM0sqT35O26FFb6ZsF33GDfzZdWW0xsOy2FdEREoFgzz9HfbPwktBLUO5Tkg3y3afDds7ig9zrmWXHxbyVUdGd1JMJPCSoCcm6e9mixoXAuD+u+zznVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB15814.jpnprd01.prod.outlook.com (2603:1096:604:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 02:09:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:09:58 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Alireza
 Sanaee <alireza.sanaee@huawei.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Subject: Re: [PATCH v15 1/4] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Thread-Topic: [PATCH v15 1/4] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Thread-Index: AQHb26AYCZXkF5mHFEyoirATstaYTbQAWUSA
Date: Fri, 13 Jun 2025 02:09:57 +0000
Message-ID: <5205d2c8-1431-46bf-a69f-d511e2ab2af6@fujitsu.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB15814:EE_
x-ms-office365-filtering-correlation-id: 0b6e25d4-a63c-4afe-50b2-08ddaa1f6584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVp1cUNHbVZmdXhGbFdtSzBjVTY4MVF4S1d5REJJWVVnSENVVWRYazJlM2pN?=
 =?utf-8?B?T3ZSQmJrQ3N2eXdoTDcwTzRvV0Q2QURqWDF1bjFDOWFRTnJ3MWRXcUIzM0N5?=
 =?utf-8?B?OUtHcThoU2lQQ2FtL3RsOUhrSDRLTEpTQ2R0d1JmblpjOGpHamVjcG1Dd2tQ?=
 =?utf-8?B?YlpybmhiWjhTWVgyT2NiY2NTNDF4Q0xzZk5uOVZEVGRLNnFUcWVpWWZwSFMz?=
 =?utf-8?B?VWJSaDNpR1hXd1VHTTFjSkh1L0tQN0ZKNm1BZkpQK0pla0xjS0hxODBlN2Nx?=
 =?utf-8?B?NXo2VFV0TEpCYURtL3ZEQ1dpUGJYZWtmTDNocllqalNMYTN0ckd2QTZaL01P?=
 =?utf-8?B?QzlML0FqZU1kQ1FGRm44WlNjQlVmMUZSazEyTENSTzlzMDhNWU1jRHhqdW9T?=
 =?utf-8?B?VVVZZFl3Uis0NUZNRXg1Y1Y3cHBsMGdheEh1NjUwL1VHUmhDRWtLSExoQmJo?=
 =?utf-8?B?d2JCS0MwZXBaN2pMRFFpK3NibHRrR3FPTjlMYS9kWk9wclEvZC9YZmllZStz?=
 =?utf-8?B?TysxeDRPVUMyRGxaQnNLdmY3c1ZYOVBwOGdnK0VIaURnN01GUlBkaWZGUmpN?=
 =?utf-8?B?ZCtkdFUyUkVacmwrSHhERDdjY2hrQ0pFNURvdG9yRHVmNEUrV2g2TzBkcjNQ?=
 =?utf-8?B?KzBVa1E2MzNwU2NiWTRhNVdEdEhxR21YWFVGQkxDamU4WEZuaW9CZnVUSmty?=
 =?utf-8?B?cWpRQzhvaWM5cGY5dWN5RGJwZXdSKy9UTFZESjgwUnUwUGNTVC9LL1NUd1JD?=
 =?utf-8?B?eFZUMktVd2lnRitnYXdrYkswRTh3WFplbU9nZHJLemp6OXJFL0grUzR1RnZE?=
 =?utf-8?B?Mm02OTR6MnJVL2M2RFk4Z21EYnl4K1FqOWR1TWtUSzNWTzZKcTRXU0huU2N1?=
 =?utf-8?B?ODZ2eUI1Ym1qZ2VOVkRvSzNOTmtaekZFUG5NVWh0dUdxYWlGWS8wblZtOFJZ?=
 =?utf-8?B?STBMQkFiTHIrNExTOGU5Mm5JNTVrbVQ1MmV5Tzh6czRudDFwYmZYZEwyZWxU?=
 =?utf-8?B?T0JUaTlwTnp0NHdMaTBwdm9oZjc2ZDBCdHVNamp3MndoUGtZakl4R010Qi9B?=
 =?utf-8?B?TmtmdTFzb3ZuSUZjUDYyS3BOQWk4RE50WnRFNmNWL0JudCtNejNDU0pvZ1li?=
 =?utf-8?B?M2hHZTllYmd6bi90NmlkQm1rUmwzOUxNNkxUcEsvZ0JVNjBZQmJaMWE4NXlx?=
 =?utf-8?B?dEpnZ2dDMEY4c2Zzc3NjL0locVFUa09Vb3RLKzNrMGRZVTRaNE1LRFlzNG1U?=
 =?utf-8?B?TTE2QjVoWDdqWS80c3kyOWZGeG42aHBpUGRWNWtVZ0FLOWRrci9JVGxhTlZP?=
 =?utf-8?B?SGhOZytHeVpXcVNTaVhjU3dSVlpkUmxNaFJ4UEI0T3hvR0JCbjc4VW1XUjZX?=
 =?utf-8?B?Y0lzdE54aE1BOVNVNTlBNS80bERYODlxTHQ4ODcyVzZ2SlkvOU9QdXlaRjNp?=
 =?utf-8?B?S1ZaeTFVb2d5L2xyZitOUmxiTE5ISEZrNXg2ckFWRlVZMG41RllPRERZQWVH?=
 =?utf-8?B?dnNlMm1tc0g2UkVnV2IxRXVqcnNwZ25KeTBKNWpIeHZMU2I1NmIvSGZnNFdx?=
 =?utf-8?B?MFBoNDNOelpPVlE0OWhrbFRDQi9lY2tTRExMNkxSVVFoODg0OGM4Mk56clNG?=
 =?utf-8?B?YkRERUhvclpjaGlNdU0zR1V5TnRjbnpVVm01d05BUlJwMlBlT1lsbW9GS2R6?=
 =?utf-8?B?a05rMG8reVFlZTNWVEFUbnU3dVJXU3JkT3VIeUtuaUlyTDhaRG5vNWozelkr?=
 =?utf-8?B?OW8vMlZnSkJnbDBlalllSU04c1BvMUhjVWZjR3c1cWVYeFUrMkFUeG92U2NS?=
 =?utf-8?B?SkRSek01QjdhZ2k2VVcrait2TXhkcXMxOFk1ZUQ5YUQyb2RHSGhvQTZPMGFJ?=
 =?utf-8?B?U1FuMFhkbzRGa1FkUHpmcUhJVWt5bkRvNlBNZTdValBZWmQvSjh0Rmx0Q1Nx?=
 =?utf-8?B?Ylg1WVVXMXNxMlZhNkMxWk50dEF4eFhFZ1NBMGY1MWRLb3Y1aVRubVBmdld6?=
 =?utf-8?B?Z0Fqc3g1OXpCMDlhdENrL1ZEenRTbmdHZ1RYeDF2S1dwT1huRG1EUkh0ZmNK?=
 =?utf-8?Q?27x6MG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDJyaFgyVURvVU5mbFRhdGFKVmxSeUxSUThBZ3VDcW1QRmVCVzRYOEdVNjhF?=
 =?utf-8?B?TVYvbjFHOUVqV1d5VDRkSnVvMi9iSm9lUWFPdTAwNmxiOWZRR1lKQ2F4R25Z?=
 =?utf-8?B?WnB2VHVWSzRsdnVIQU1waXl3RlZkbVA3MjFMSm5VejlVUE04aTgwMlBBR0hI?=
 =?utf-8?B?cXFqK0hncEYvZXJBQklydGRsRGw4TEtqQ0daVVJKNmZTRXRKNzhUc3NHUWZE?=
 =?utf-8?B?R1prU29jWm5vdk9qZXVqL1VXbWhyeFp3TDJUNlo0eDJKM1lyTDBQd2ExN3lE?=
 =?utf-8?B?cHkzaGhMUUNHQW5tWVZOQVFVd0F3R1d4Nm9hRHA1Z3hWdDVnVVJ2c2pic0F5?=
 =?utf-8?B?VThtZUpYRnI2UGoySlBBZytJU2dmbklNYzR6eXpqZWpHWTE5Z25IbXhHSE5O?=
 =?utf-8?B?bXVHRC9xOEUxOTNVMXF4VFBFdzNLWDZMTXZLalFvRnFieUY5cEJPQW5OYVRV?=
 =?utf-8?B?Mm1paUlpS0FoQnBGVHFiY1J6N2dDakcxUnRmTXkrM0pValhlVXR3WFQzWUVl?=
 =?utf-8?B?WmF4WWxCTjFLdStCUXp6WHNwTHE2U2xiRTBPbDRRMTlBdyttZk1NRVdyR3Bj?=
 =?utf-8?B?VHZxTEV4RDVXeEl6dHJzSkE4WHpWQWJqdER1anVtalozMkpXbE1EM25UZHpr?=
 =?utf-8?B?Zk9qNVFFeEhpS1kxNW5iL1libkhEdC9JQU5pVjRVOG9VREx3R3EybGc4U0Ew?=
 =?utf-8?B?MHF1K2FQVkRjaFFLQk9mR0Jma1NNL0YvZExFWFBTb2dUMGZmQnZXa2hWTWNP?=
 =?utf-8?B?UW1pOUk5aFlMK3ByOXY2cXNRWmhHb2h4YVgzeG4wSXpxNEpxb0hSc3lvY1U3?=
 =?utf-8?B?KzdjakdTYk5Wa216N3FXQXM0aEtuRkQzalZaaVY2S0l3WjlQblM3WkdPaXEz?=
 =?utf-8?B?WnpHVjE4ZjJrQ0xQUitjRHJONnFOODNaa25JTlRYd2JVYlFOQWVSM21mT2do?=
 =?utf-8?B?LzMxRUFkRkVoOURZNDAxZEZNalBDMCtwdFY0SXhRSlVkRXVJT20wSGhaemRQ?=
 =?utf-8?B?VWdPQWZ2QjNIdXdvZjlRd2FhQ0YxY1FMeTEwcnE3YjVpZWNxSHg5UmJ2S0Zo?=
 =?utf-8?B?WGFDTE1hSGVHR0FrSkUyZHFiUC96QnNpYTJmNlVSOFdjSFJWaS9iZjlBY2I3?=
 =?utf-8?B?MkorbTVTZXpOdHB3MmVwUGlVN3J3UWF3aFR3azZ0NWxrRldzZFhtRGs2cGd1?=
 =?utf-8?B?V0tPMnlHTXRZTHBERjk0MjB6blFyV0JvYUNGWDFnNk5DNHdBZktlSTV0Tjky?=
 =?utf-8?B?V2pLbGMrZ3Y5dDg2V2dVdG15dU5PdE5NSndXSG5lNzhYNEpFRUpRVVB3MmFC?=
 =?utf-8?B?TnlKYlVxS0ZHMDI1K0ROY1k2TVdUTjBPTU9KUkFreE8vcjNiMUVPWUxDVlhj?=
 =?utf-8?B?TzJZNEdCcjRXRHdNZmp1b2lFOWRhTXM5UHBaVTVKVHp4ZERTNFlUSTF6Wk5Y?=
 =?utf-8?B?dVZxZnZWZG5COFJCYXNUYmdWTTR3N2hCMHBmVEY2ZUFtZzN6dS9ONElPNGx4?=
 =?utf-8?B?aXFneFdJa2xGemx6RW9BVnVrclpYRUE5T25GSEQ5aVZRYndXRzR2TWE4WWx0?=
 =?utf-8?B?YXVXZzJIS1l4Y0RJY2hKMEdvUXNVMXNSUEp5dU9MK2psc3d4Z1Z6NU5hVFFw?=
 =?utf-8?B?ZDY5T2w2aHc5aTdOWEsvaUZQM2FjUjdvRGsybTAreTlvaTJobk4xNDJtY3hC?=
 =?utf-8?B?MUFoclRVMGppa2dhclJnV0F2cngvVldJaU9RWUswamVvUFgyeFhCdXBscExO?=
 =?utf-8?B?d2R1aG5wMlN5OG02YlEwbkJ3SlE2TWRRcWVWZkV6bmp6aE1XYVhjNTNwdGpi?=
 =?utf-8?B?b2RPNEx2VDN6K1FnUitDNkhRa2N0SGovbVNBOVFJU0JHK0NKYUlLWWZvcXFI?=
 =?utf-8?B?bTNidHQvRWNIa1FQeUl1RnZSTllUVXhaNnVuSnc5Ty9jcXo4WkhxQ0ptdlpH?=
 =?utf-8?B?TGVjWUtDSTgrQ3VsSmNpUCs4cW01R2h0eEhsdGUyazhQOTZ1K2p3TXpycUd3?=
 =?utf-8?B?S1ZtS2tWSFhtY0U3YkZYeFYrMlcrNTAvUWRPUDRQbms5NjZoU0xEU0lhYTRY?=
 =?utf-8?B?cXRwVGJUZVprNmJQS0dKbTdlNVhaMTFCbTA3NnhGdFZ3U2licUVDVTdyOFE3?=
 =?utf-8?B?eGRxWEFWOEM4dGJDNnY1NEhhTTlib2F5aVNJR21oOFhUdE55bkRaUzdzMXN6?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB017B58536FDD409C272085D598DAF1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mQsXOixRbWBF8Rg5vMq0Qy5F7/j50JfWQ2jYKCqVvLqfxNmUnGIktD20jcnGrmfxshlV9Ry1cnR/WFGoeKmwHvBU2l+UDR/BPpZb1cY6Uetd2AV6NYgw4yu67qcO3HONWpjFw6QASyn81Soub4NNeoteZH8MqJbL4JcGZR4eEHKFa4XX2numuuRNJ6G9ASeO+p5d/0p6IQzTQqWK2TjO3xXPQZvN8p+Cblnp/Q1PJHOkDrQU674Ghy+ZdUHs8qW52ZJ/3++y8pTOXPXUwgTgI70DPsaoLnlXgZNW6+uallZHfSxrtz6IjCYPw/CwzANdfSj5Nt2a7655JGV3Ey4MOipCHgEmxN/NPTjCx/sX49meas3pIlPESgjipIG7VTd5rO/4lAdmoGYKLSEFi6HX8AW/iMCAWx+em9rcfSoDe3y1sH6XmWDJ/shtrlA7HVz0HxBMbEFgBjlrDH6cB2HVYegqOLFQI3HOB8gvxWtSsgZEFpSitLW390mmvTgX3D70dDwD79bGvGeDnRhS1RkVZbI/DrP4oXOElkZgV2nrUxX9ncakvq8O3lntXMyseC/0jGABnOGqOBudCYZFI7Q+DRtt8ABUNlJcOGfqysmytNWxUq3H8hkULU2we2bkM4ZS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6e25d4-a63c-4afe-50b2-08ddaa1f6584
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 02:09:58.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPgNJYEPLriU837pBcNOLdI2KB6N2KYnjQJCnTQilVPWDF5YS6L5Nzv4Z+q0Ms0yzWNcx8lyRJDYVYEw0tWUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15814

DQoNCk9uIDEyLzA2LzIwMjUgMjE6NDMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IFRvIGVu
YWJsZSB0aGVzZSB0byBiZSBmb3VuZCBpbiBhIGZpeGVkIG9yZGVyLCB0aGF0IG9yZGVyIG5lZWRz
IHRvIGJlIGtub3duLg0KPiBUaGlzIHdpbGwgbGF0ZXIgYmUgdXNlZCB0byBzb3J0IGEgbGlzdCBv
ZiB0aGVzZSBzdHJ1Y3R1cmVzIHNvIHRoYXQgYWRkcmVzcw0KPiBtYXAgYW5kIEFDUEkgdGFibGUg
ZW50cmllcyBhcmUgcHJlZGljdGFibGUuDQo+IA0KPiBSZXZpZXdlZC1ieTogTGkgWmhpamlhbjxs
aXpoaWppYW5AZnVqaXRzdS5jb20+DQo+IFJldmlld2VkLWJ5OiBGYW4gTmk8ZmFuLm5pQHNhbXN1
bmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uPEpvbmF0aGFuLkNhbWVy
b25AaHVhd2VpLmNvbT4NCg0KVGVzdGVkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+
