Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B081514E9
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512149; cv=fail; b=KFgG/4oB0bEwURlevSl3La/in3O1gBuz1PRpTrkp3CkYhjPSC+zQGDDVFQ7mQU5Ji+YP1kGCUUBwOh9ymCB3u9U4XeNPlp5CpI+Ubiwkw2cRHjat68fQE4yagZFHvJHggC1SeZYIbygCqBD0PozhoTJx1/S3vqkL4vHHJlU612s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512149; c=relaxed/simple;
	bh=co4ExUR8K/nQkWN+STkMibqvECq184WeDq7PVOMYTlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qben5Jgw+OqWAtjJCVSUnh5Sw86nlXxUTGUDGpz0LBaWgXWsCa0j5uODUcZPbLClRn7wfcHyPSAKR93CaXJ+Yvw9F5fEFMA2wyXiAaGXpWnADtcoUKLEknzT31d2Y+Fzno84oYKmGcm5TNImPQdeGLepiOeN18KDd0lgvWGXKSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ESOigxlR; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ESOigxlR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720512147; x=1752048147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=co4ExUR8K/nQkWN+STkMibqvECq184WeDq7PVOMYTlA=;
  b=ESOigxlRk4WqINbcFdRJVm0AYcdK1v9TFnrYhp1m55n30XcguahLuiIV
   ExKYUE8vjquWf/eXnYtoDMJJ1+SPUYDmh54i1YplwDslbTqALGcdzPrtK
   qLsA78/BDcClANqZYof+wfLVS2vpxEKhNxzb0tIq/oTSX7eiNCpx3+JtD
   PjTeTmOY6MBa3XdDrjAN2Vl+u6g40YoE7cqvw6ZG3K6vqN8jC0/GOPiAT
   G9Wr2qxXQ9ZbRHjcfaipVhPymT+/NRopjAnQTU3ypVU1Zb/UtUV+7G4GH
   tiMPVVZAZczDNa+CKfJjYhdOSA/PRI1AMzq/6ONgovCH/ibMHQNJtvte3
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35803969"
X-IronPort-AV: E=Sophos;i="6.09,194,1716217200"; 
   d="scan'208";a="35803969"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 17:00:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajr4kypEVX4URRr5xeoNT7W0+GKrGy15onJnEXDNYqQMSOizNo9uceZ5IEpaR3TGBiD0YCnRGahTpzRqvjEQg+ZMom8p+NOQ2xUiuTexdGHehZvEq/58gdaXJ3fWn73UfcV34uZ9pttkxprdeM7eS1UzqhqKdjvrqwiOJtOK3W/B0FPfrxgdV6/NphkZ5SoFTwzdJugl1Ye121kWTJ+uz0ab8K68vYKSJJpvmPnMro6ZsSL/SJkOwMwqFQLKLc9z9DSP5YAyo993Pz/GjLL5Mquo8cmfy/acH/w8vONYklh3Fd4BB0UOCVcc2bUqjqqeH24zqE/D+Z8JWJm1GLOi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co4ExUR8K/nQkWN+STkMibqvECq184WeDq7PVOMYTlA=;
 b=OOMA1oPBw7kclGuWhtVMJvuGlMdR0maSri+jJ4QruHF30cs44cjNlo8AeKUix/AAQzQ2/VlOJFkSnaO3R039HL9l40Ec4BqzrIEYxmI3xO4WUzu3IqysdDetO0IWgribG+wHoA6W7bXz2JKNgLX01sk4JLi3tXuSR0xnGGKa0dMutBbFXmqPryJAKeuTIKE88j8QnFX9PPaxS2NI4KZhce3H3xLtDfCe0qeysYMHMmsLVz9/aY4gTDk6Ra4fzsW2EQU3jMwNyhjSyeZN6e1bACcwmmbmNpzUxHXi7hhMf668Cp4Hzc/06PLUsRIsHFaAweDzbZZSvVczFHmJyAKOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS0PR01MB6147.jpnprd01.prod.outlook.com (2603:1096:604:cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:00:54 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:00:54 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dave Jiang' <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v14 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v14 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHawTfBafIA1J3zbUG5l0nqYOxKFbHsRIdggADffYCAAQRhsA==
Date: Tue, 9 Jul 2024 08:00:53 +0000
Message-ID:
 <OSAPR01MB7182A69094CD9275EF553DAABADB2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB71825385034CD33C732EB878BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <4059688d-968b-4efe-a1fc-f12d2ca148e7@intel.com>
In-Reply-To: <4059688d-968b-4efe-a1fc-f12d2ca148e7@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MWM5YmI5OTgtOWQ0MS00ZTEwLTkzNTYtZTVhYTVjYzdl?=
 =?utf-8?B?NGMyO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTA5VDA3OjU5OjU1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS0PR01MB6147:EE_
x-ms-office365-filtering-correlation-id: 185f08ce-42e0-4f1f-5269-08dc9fed41cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TG04dFg2dGx1d3hkeDBDUmJ4UzFUTnNibC9EQzV3cGp6UDVjcXE0RlVYZFlH?=
 =?utf-8?B?akJ4a3ZkQ05weCsxNUgwRjNyWlZSK2VTekNsWnpzVlhVVFhMOUxEc0Y5NWVK?=
 =?utf-8?B?MFEva0xlZDgyK1JWbEJxYVNlRi9sQVdkQ2FpL2J2NFAwajBlY2lMOHQxMkh5?=
 =?utf-8?B?QXdMOU4zbyt5V2pKM3hjVzV3N29FVWk0ZDh6a1RrRkNJdVNkdTlidFJYcXV5?=
 =?utf-8?B?VGU3RURaOWx1ang5RHhrTVpjaXlYRU5nOTgvVDQ4UmtIZGZhaTBCSU9tQWFw?=
 =?utf-8?B?SjE2b1hzKzB6Vm03YjdnZHkxOHlvRGZPZ21zeTVNcG83U3ZYMFVWakF5OGkx?=
 =?utf-8?B?b2ZSUmZnMjBVTzlqNEhmMnp3U001T1ZUaUZLaUlkQ0hZTTRZbGhwd0ZIN3Rk?=
 =?utf-8?B?L3kxKzhjY0p1Ny9IMHFHdjJjeko3ajJZOHB6bktjOGM2ZllQbzV4UVYrVXdo?=
 =?utf-8?B?ZGlYcEtKZkY1Rms3NTh5Ym9WZDhDRWtPQXJOaW9BeitrbW5nUlhqbHZSM3Jh?=
 =?utf-8?B?QnZIS2VoRnozM0dCWjF5R2lSZDY0aXMyRXRwMlRUbllXczRkZkNSKzgwWFFZ?=
 =?utf-8?B?SlA0NWM4Tk94UHltblRVRGpZcmJTdEM4WDZJOFZBQ0xGVUJkK1dMNzJxVXV3?=
 =?utf-8?B?YmJMcXFzbFlZbElNa00vMmpmTlBFRlJ3N3RsOGoyeFZLclhhckRWTEdIRjhM?=
 =?utf-8?B?M1laZjZBTXVvMnBpL28xa01sclNiZk9HWWVCRWtzdExMZUdvc1JtQWR2L0xw?=
 =?utf-8?B?VTVaNG52Nm5XVHY0dmU1dnNBa3o0RVdiRkxSS1B5WHJDWENPbjV3NlVYc1lY?=
 =?utf-8?B?ZnZKUEpHOGZZZUJoRmJYOEpCblh0SU0yREoxQ2tMempyeUhJeGhGakV0TGxM?=
 =?utf-8?B?Q3BuWlJWUXRYZGhyekFxU2VGVm1MUVdXYTlpYmhwRHZvUG1xdkFxa3Y0RW5B?=
 =?utf-8?B?SndqZERhTnJKdWhuNWtyajNMVjFnUTJNQXM1SmlxK2ZWUHdtUm5YZUZwYXpz?=
 =?utf-8?B?b2w4YVEvMnRiUnl1L2NMT2ZJTDlyUm1xdDNRK1F5OWU0Y2hQT2QvY2g0M05X?=
 =?utf-8?B?SDZBYjR6REl4bFVQVG9DNnMvVjZkdGJ0Wi92UDFxRWhmcXdNK3pMK0VZL3NF?=
 =?utf-8?B?dmlyYWhqT1dvZnNLTEVvcWRLUWtoTHZWc1h5dmlaUnVZWGJEZ0kwbkJSSUNw?=
 =?utf-8?B?ejZYVVpBUlI3VnZOdWZHQ3hWOGdoeFBYU09SNzBXMlNPb3BDOFNiVVFCNkEw?=
 =?utf-8?B?YVV6THRITEhjZFArSDdKMWtKQjNyNUpiRUJJb1AraFYzZlY5K3N0aHVUOHBN?=
 =?utf-8?B?SzhVc0FHMXY1OFBHUG5KLzJJdSt3WUNIVDd5SHBLTDN5aTViNzJ5OVI0cGts?=
 =?utf-8?B?UEU0Tm5ZMXR6bkVoWThwS0tES0FWTzlyWnZhRWM3Z0kzbWRiakxGTDg3R01p?=
 =?utf-8?B?ZFVnaFdyS2NBenliY1AyZjNrVCt1bm4vOXNvR3MzS3pobUkzSG5Ic3g5RHJ6?=
 =?utf-8?B?OTBGNllhSVJDRDFCMzZEbUQzTG42Mzl4RnlYeitqN2JKWlRoWHE5cGZORUZk?=
 =?utf-8?B?Z0g1YXRVTGpoUnFwd0lSbnl1V2V2T01EUEhIK2VoR2VERnpZV2tsRnpwdSt3?=
 =?utf-8?B?Y2Y5aXFJWkgyYTZ6dTNOLzFRaEpGL2tIRmgrSFhlWmdtVmxjYmZDWjVQVmVx?=
 =?utf-8?B?N0RqeDArZXNVZU9iUWhDdzhucElYZFVyMlJ4ZHBVNm92elBFWGdLTHVScStx?=
 =?utf-8?B?anNZemIxbk5EWFAvZklDemZMc2dIcEMxLzh2bFZETU5WWUVmakhsWDlSbjZz?=
 =?utf-8?B?a2QyVE9sYmUrUXNSNGNOQjNiU3c3aXQ3c1VhS09jQm9HekhDOEdXbksyWEhz?=
 =?utf-8?B?ZEkzS3JvNmFHaVBRS3V5c0plWGRBb0g3a2tPakwwemlCb2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djdZeWRINUFZbFYwL1JzWUlUZmtsVXBJYW5nY3hJKzF0TGJNeXdOV0psY2cz?=
 =?utf-8?B?K0ZVM3dOZ3F0clhRRzFJK1BEVWNhaHJ6bzFCajQrNkJEc2Nua0wxa2o1RkVQ?=
 =?utf-8?B?WElXdXpLQUZheTBaSnBWQlY0WExYdDlweEJvbkhyWGVYNjVyMlJqb1FsSDE5?=
 =?utf-8?B?L01xSkxZeFFUamhMTnVBcGZFVXpLRXRPZ2tOcWF4RmRpSzhVbWlaMmRMc3hl?=
 =?utf-8?B?ZjlXTFJURnc2M0pqU25JVThOeDdLaldGbitsVVkzbTVZQ2VKdzgzYTJ5SG1R?=
 =?utf-8?B?T1VnUzZ2MFlvcGhNbTk4TVd4Q0Z3WnZ4OTh0djhNREV6YVVDRytid3RGbkJH?=
 =?utf-8?B?eUNDZGFVOGpUQWpEczhuT0hCME5kM2p0S1ExeHp2Y0VMbGVoTmdFRWVEeHRD?=
 =?utf-8?B?clE2NWYrQXRqVXpFRkJHV0NXNjBKOFprNmIvMXcyVU4vQVBoVkk3WVAzYndp?=
 =?utf-8?B?ZFk4MmJMZGtYNWg3TzR4TVVLRThwOTVvRFk3RFl1UStSOGNRWjVadzFhYWN2?=
 =?utf-8?B?eC8vZGpZeXV6WFp4Tlo0R0toREVnY0dSOWkrbWdhMk43bG5tQ2dqVm1EaTI3?=
 =?utf-8?B?TElJMXVqMGllVzJabThldUhMVHkzQUhGVGF4dFFQby92Sm9lcnZRVVZPeUxr?=
 =?utf-8?B?QmRqUXdiRnAwOU1hOFhqT25VMU5qdFBjd1ZTMHVVTjdHUVhjU2IyVDVRSm56?=
 =?utf-8?B?Ym9VZWo5V0tac3lZZ0prR3ZUSUExdXdoQXAxQXpyN3U0YUUySDlyTFZDaDEw?=
 =?utf-8?B?T2ljVjA0MVBwQkh0eXcxQU94TWZ4OS9pbitrbU4zTEVGcW50bUZRcnlCWDBG?=
 =?utf-8?B?ZVpRc2wvQ1NqbHVwN012VzYwOGxQSGZkTE5lQzBsRzFvZEJ2NEFTMkNaa0F3?=
 =?utf-8?B?Y1hYaGZZZXY0SCtLSWlFdlJXdTArcit2dVV0dTcxMkhiank5SGlCcmRYTG9y?=
 =?utf-8?B?cWRnWEpRQmlBRjkwN2JPNTNTMnovK0xMOCs2Qy95OGpTNmZ0VlFyUmxnZllH?=
 =?utf-8?B?NTRhV1U4ZTlKaTJpa1Q2NURITGkyS0JLTXNUMjYxVHNtR1B5TnN1a29SV3Vl?=
 =?utf-8?B?SWtDV01TNDFhdEFUN2RvYS92d0FaaFRMc2FSRm55MkcxbkJXU0hoTlQzbEEr?=
 =?utf-8?B?cktDT3VORmI2QzZuQUlLKzYzMnhCVlVkZzh1eEIyMEZUUzA4ZnZUSlI5bjFn?=
 =?utf-8?B?VVpzMVlGN1FjVmFjUU1KYjVMc0x2bmdkdU5HTmRFbU55T1VwTDdIRzdqbVJu?=
 =?utf-8?B?eTZ4ZWZvbjdBcDVKeVIvd1pndzh4THFhek5QMjQ5VGR1WWJocDZtYUt6bkwy?=
 =?utf-8?B?N0tlbGhRL0hqS0RQSUdmWkJOTkIxeVNlSXhXMTYwTTlOSmJIcGROcEx6ZEZV?=
 =?utf-8?B?SzR1Z05uU1gxcHRaQVZxRHAwb3RaVjQ3WkFBQllPRGJzOWhVcVNOb1VKQmpp?=
 =?utf-8?B?cDYzeGRXckowb3pnYjdRZTA2RHpFaXdyYldGa1QzeXlFNXRXeThMYVJrSW1T?=
 =?utf-8?B?OVo3ZExmL1dHcHdYVER6cVl2NGg0Y1Z2UUY5RzZma2Voak1DNzJmWkxIckl3?=
 =?utf-8?B?N05MNDVWYXQxS2JlQ3JIRUVaOUdLWU85NDBramE3UEN5OFcramp6czhuVnFx?=
 =?utf-8?B?ekpydGI0WUNiMnFIY2ZLYk9uSG9PU3pmZ1NrRDZha3hnK2dWUVZCM2pTa2Fk?=
 =?utf-8?B?L2FtZEhaL3RLMVBSM21pMlBETHhSTlhPeHRDOXNXaFJyNVFRb1F2R1ZBMG5F?=
 =?utf-8?B?djJpVlAvektmcm1LcUY4R2dzQUZyOFd0YWoyYnNMbHJYR2FLd2xyZnhTT05n?=
 =?utf-8?B?R1hFaVFNaTFjY3RKWVhxRzd0TmVlMTlncFdPNk5BeWZsTGtIdllkUHVzblh1?=
 =?utf-8?B?WEw4eHZHbjhmOG5CQXc3SEZSb1dYaThKb1Q3NVo2cDZMSU12c3c3ZWh1NkpL?=
 =?utf-8?B?MFVyR1FEM1R5N0RGUUxDa0VzVmNIN0tsVEg1SVBXQ0YrekxsTktTa0piMTZi?=
 =?utf-8?B?K0hWaUZvQVpyN0EvYzFvdGhRMXdNVGZwallZVlFkZlFXNmtpTzU5N0ovbUFh?=
 =?utf-8?B?OHVKQlh5N0V2UVNucnZHQ2dDVXgzZlhQMTFjNEtqNkJXTldUbTYxWVo5YWxp?=
 =?utf-8?B?YUM2Y2ppRlB4VGJFeEg3dGE5SnQzRnZ5MDZQelY1QU5DdmxqOUx6UndPcEUx?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LeexNZhEUzBbDcUNmW1SnLMJBbK5DJSzfJ4cFtaYHkunjCd5ADghCGAuqOunkfOLtr4Z5y73CqfZWma0VmLQx28ZV7dAAsR26otixSY268529d9F/BD+w/4n0uC2CKrqI16JqIQaHsj49LbPnnzNnDDxQXpEflTk/oydlAcZAP66Yzfv9fwSWqmKYE9c61NuL15N/Gbb97jiVqXrx6bwCvxLvcq6yz2D3A6mqAi4ptdrAUned5eS2hjZ1k36Gj1tXvQRUZQ8DgTdZ4SdIhcbUTlW36/xEGZvVYE3fC8xSokwWFIM5eTxV5KAm4Y7IcKp9nOdO6NItWgXI4JW0K0A1icFp/kT7P/q/iCfDQNepxYYIQs80DzbnBOW7w3p2Gobl/j/yVCiN3yo+umKkz33Tq+RAwzmvkRVk/soS546XlY8QUCPwvaUC1WCukY8zmJHeIcvjmKq7kfIMtb7DfmtzaEvTF27YolItCPHZOZ1ctPcxRSCs0IugsPh6S8OG0pXWf4j3trT6nBXIT7/1AvtaTDNJe6xuZ7iG4nPvi5EV9a65ze13/nJRtaLGL9pb+9neZM11wnUTgowfgoG1sXg/kfGdmOQjvherYoy+l391mehjHn8eWvw1eQ9KXvuWPqY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185f08ce-42e0-4f1f-5269-08dc9fed41cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 08:00:53.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3wXKDMPmomsJE3byyzKRUR/8JDHQRWPY9dzas9ZisZilMNVmv0vF5hx8W01jFwjCZ9egw5a1E+LeNpCrY7r2ex9inv0nMj+lot7vD+w2Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6147

DQpEYXZlIEppYW5nIHdyb3RlOg0KPiBPbiA3LzcvMjQgODowNSBQTSwgRGFpc3VrZSBLb2JheWFz
aGkgKEZ1aml0c3UpIHdyb3RlOg0KPiA+DQo+ID4gS29iYXlhc2hpIERhaXN1a2Ugd3JvdGU6DQo+
ID4+IENYTCBkZXZpY2VzIGFyZSBleHRlbnNpb25zIG9mIFBDSWUuIFRoZXJlZm9yZSwgZnJvbSBD
WEwyLjAgb253YXJkcywNCj4gPj4gdGhlIGxpbmsgc3RhdHVzIGNhbiBiZSBvdXRwdXQgaW4gdGhl
IHNhbWUgd2F5IGFzIHRyYWRpdGlvbmFsIFBDSWUuDQo+ID4+IEhvd2V2ZXIsIHVubGlrZSBkZXZp
Y2VzIGZyb20gQ1hMMi4wIG9ud2FyZHMsIENYTDEuMSByZXF1aXJlcyBhDQo+ID4+IGRpZmZlcmVu
dCBtZXRob2QgdG8gb2J0YWluIHRoZSBsaW5rIHN0YXR1cyBmcm9tIHRyYWRpdGlvbmFsIFBDSWUu
DQo+ID4+IFRoaXMgaXMgYmVjYXVzZSB0aGUgbGluayBzdGF0dXMgb2YgdGhlIENYTDEuMSBkZXZp
Y2UgaXMgbm90IG1hcHBlZCBpbg0KPiA+PiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZSAoYXMgcGVy
IGN4bDMuMCBzcGVjaWZpY2F0aW9uIDguMSkuDQo+ID4+IEluc3RlYWQsIHRoZSBjb25maWd1cmF0
aW9uIHNwYWNlIGNvbnRhaW5pbmcgdGhlIGxpbmsgc3RhdHVzIGlzIG1hcHBlZA0KPiA+PiB0byB0
aGUgbWVtb3J5IG1hcHBlZCByZWdpc3RlciByZWdpb24gKGFzIHBlciBjeGwzLjAgc3BlY2lmaWNh
dGlvbiA4LjIsIFRhYmxlDQo+IDgtMTgpLg0KPiA+PiBUaGVyZWZvcmUsIHRoZSBjdXJyZW50IGxz
cGNpIGhhcyBhIHByb2JsZW0gd2hlcmUgaXQgZG9lcyBub3QgZGlzcGxheQ0KPiA+PiB0aGUgbGlu
ayBzdGF0dXMgb2YgdGhlIENYTDEuMSBkZXZpY2UuDQo+ID4+IFNvbHZlIHRoZXNlIGlzc3VlcyB3
aXRoIHN5c2ZzIGF0dHJpYnV0ZXMgdG8gZXhwb3J0IHRoZSBzdGF0dXMNCj4gPj4gcmVnaXN0ZXJz
IGhpZGRlbiBpbiB0aGUgUkNSQi4NCj4gPj4NCj4gPj4gVGhlIHByb2NlZHVyZSBpcyBhcyBmb2xs
b3dzOg0KPiA+PiBGaXJzdCwgb2J0YWluIHRoZSBSQ1JCIGFkZHJlc3Mgd2l0aGluIHRoZSBjeGwg
ZHJpdmVyLCB0aGVuIGFjY2VzcyB0aGUNCj4gPj4gY29uZmlndXJhdGlvbiBzcGFjZS4gTmV4dCwg
b3V0cHV0IHRoZSBsaW5rIHN0YXR1cyBpbmZvcm1hdGlvbiBmcm9tDQo+ID4+IHRoZSBjb25maWd1
cmF0aW9uIHNwYWNlIHRvIHN5c2ZzLiBVbHRpbWF0ZWx5LCB0aGUgZXhwZWN0YXRpb24gaXMgdGhh
dA0KPiA+PiB0aGlzIHN5c2ZzIGZpbGUgd2lsbCBiZSBjb25zdW1lZCBieSBQQ0kgdXNlciB0b29s
cyB0byB1dGlsaXplIGxpbmsgc3RhdHVzDQo+IGluZm9ybWF0aW9uLg0KPiA+Pg0KPiA+Pg0KPiA+
PiBDaGFuZ2VzDQo+ID4+IHYxWzFdIC0+IHYyOg0KPiA+PiAtIE1vZGlmaWVkIHRvIHBlcmZvcm0g
cmNyYiBhY2Nlc3Mgd2l0aGluIHRoZSBDWEwgZHJpdmVyLg0KPiA+PiAtIEFkZGVkIG5ldyBhdHRy
aWJ1dGVzIHRvIHRoZSBzeXNmcyBvZiB0aGUgUENJIGRldmljZS4NCj4gPj4gLSBPdXRwdXQgdGhl
IGxpbmsgc3RhdHVzIGluZm9ybWF0aW9uIHRvIHRoZSBzeXNmcyBvZiB0aGUgUENJIGRldmljZS4N
Cj4gPj4gLSBSZXRyaWV2ZSBpbmZvcm1hdGlvbiBmcm9tIHN5c2ZzIGFzIHRoZSBzb3VyY2Ugd2hl
biBkaXNwbGF5aW5nDQo+ID4+IGluZm9ybWF0aW9uIGluIGxzcGNpLg0KPiA+Pg0KPiA+PiB2Mlsy
XSAtPiB2MzoNCj4gPj4gLSBGaXggdW5uZWNlc3NhcnkgaW5pdGlhbGl6YXRpb24gYW5kIHdyb25n
IHR5cGVzIChCam9obikuDQo+ID4+IC0gQ3JlYXRlIGEgaGVscGVyIGZ1bmN0aW9uIGZvciBnZXR0
aW5nIGEgUENJZSBjYXBhYmlsaXR5IG9mZnNldCAoQmpvaG4pLg0KPiA+PiAtIE1vdmUgcGxhdGZv
cm0tc3BlY2lmaWMgaW1wbGVtZW50YXRpb24gdG8gdGhlIGxpYiBkaXJlY3RvcnkgaW4NCj4gPj4g
cGNpdXRpbHMgKE1hcnRpbikuDQo+ID4+DQo+ID4+IHYzWzNdIC0+IHY0Og0KPiA+PiAtIFJDUkIg
cmVnaXN0ZXIgdmFsdWVzIGFyZSByZWFkIG9uY2UgYW5kIGNhY2hlZC4NCj4gPj4gLSBBZGRlZCBh
IG5ldyBhdHRyaWJ1dGUgdG8gdGhlIHN5c2ZzIG9mIHRoZSBQQ0kgZGV2aWNlLg0KPiA+PiAtIFNl
cGFyYXRlIGxzcGNpIGltcGxlbWVudGF0aW9uIGZyb20gdGhpcyBwYXRjaC4NCj4gPj4NCj4gPj4g
djRbNF0gLT4gdjU6DQo+ID4+IC0gVXNlIG1hY3JvcyBmb3IgYml0d2lzZSBvcGVyYXRpb25zDQo+
ID4+IC0gRml4IFJDUkIgYWNjZXNzIHRvIHVzZSBjeGxfbWVtZGV2DQo+ID4+DQo+ID4+IHY1WzVd
IC0+IHY2Og0KPiA+PiAtIEFkZCBhbmQgdXNlIG1hc2tzIGZvciBSQ1JCIHJlZ2lzdGVyIHZhbHVl
cw0KPiA+Pg0KPiA+PiB2Nls2XSAtPiB2NzoNCj4gPj4gLSBGaXggY29tbWVudHMgb24gd2hpdGUg
c3BhY2UgaW5saW5lDQo+ID4+DQo+ID4+IHY3WzddIC0+IHY4Og0KPiA+PiAtIENoYW5nZSB0aGUg
Y2FjaGUgdmFsdWUgdG8gb2Zmc2V0DQo+ID4+IC0gQWNjZXNzIG1lbW9yeSBtYXAgYXJlYSBpbiBy
Y2RfKl9zaG93KCkgZnVuY3Rpb25zDQo+ID4+DQo+ID4+IHY4WzhdIC0+IHY5Og0KPiA+PiAtIE1h
cCB0aGUgcGNpZSBjYXAgaW4gZm9yIGFsbCB0aGUgdGltZSB0aGUgZHJpdmVyIGlzIGJvdW5kIHRv
IHRoZSBkZXZpY2UuDQo+ID4+IC0gQWRkIG1hcHBpbmcgdGhlIHBjaWUgY2FwIGluIGN4bF9yY2Rf
Y29tcG9uZW50X3JlZ19waHlzKCkuDQo+ID4+DQo+ID4+IHY5WzldIC0+IHYxMDoNCj4gPj4gLSBD
aGFuZ2UgYSB1dGlsaXR5IGZ1bmN0aW9uIGZvciBnZXR0aW5nIFBDSWUgY2FwYWJpbGl0eS4NCj4g
Pj4gLSBGaXggdGFiIGFsaWdubWVudCBpc3N1ZSwgZXJyb3IgaGFuZGxpbmcsIGFuZCBhcHBseSBz
dWdnZXN0aW9ucyBmcm9tDQo+IEpvbmF0aGFuLg0KPiA+Pg0KPiA+PiB2MTBbMTBdIC0+IHYxMToN
Cj4gPj4gLSBBZGQgZnVuY3Rpb25zIHRvIGhhdmUgb25lIGZ1bmN0aW9uIGRvIG9ubHkgb25lIHRo
aW5nLg0KPiA+PiAtIEFkZCBhIHNpemUgcGFyYW1ldGVyIHRvIHV0aWxpdHkgZnVuY3Rpb24gYXJn
dW1lbnRzIGFuZCBjb25zb2xpZGF0ZWQNCj4gPj4gdGhlbSBpbnRvIG9uZS4NCj4gPj4NCj4gPj4g
djExWzExXSAtPiB2MTI6DQo+ID4+IC0gRml4IHRoZSBlcnJvciBoYW5kbGluZyBpbiBjeGxfcGNp
X3NldHVwX3JlZ3MoKS4NCj4gPj4gLSBGaXggYW5kIGNsZWFuIHVwIHNvbWUgZGV0YWlscy4NCj4g
Pj4NCj4gPj4gdjEyWzEyXSAtPiB2MTM6DQo+ID4+IC0gRml4IGFuZCBjbGVhbiB1cCBzb21lIGRl
dGFpbHMuDQo+ID4+DQo+ID4+IHYxM1sxM10gLT4gdjE0Og0KPiA+PiAtIEZpeCBhbmQgY2xlYW4g
dXAgc29tZSBkZXRhaWxzLg0KPiA+Pg0KPiA+PiBbMV0NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtY3hsLzIwMjMxMjIwMDUwNzM4LjE3ODQ4MS0xLWtvYmF5YXNoaS5kDQo+ID4+
IGEtMDYNCj4gPj4gQGZ1aml0c3UuY29tLw0KPiA+PiBbMl0NCj4gPj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtY3hsLzIwMjQwMjI3MDgzMzEzLjg3Njk5LTEta29iYXlhc2hpLmRhDQo+
ID4+IC0wNkANCj4gPj4gZnVqaXRzdS5jb20vDQo+ID4+IFszXQ0KPiA+PiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDAzMTIwODA1NTkuMTQ5MDQtMS1rb2JheWFzaGkuZGEN
Cj4gPj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzRdDQo+ID4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDQwOTA3MzUyOC4xMzIxNC0xLWtvYmF5YXNoaS5k
YQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+PiBbNV0NCj4gPj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtY3hsLzIwMjQwNDEyMDcwNzE1LjE2MTYwLTEta29iYXlhc2hp
LmRhDQo+ID4+IC0wNkANCj4gPj4gZnVqaXRzdS5jb20vDQo+ID4+IFs2XQ0KPiA+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAyNDA0MjQwNTAxMDIuMjY3ODgtMS1rb2JheWFz
aGkuZGENCj4gPj4gLTA2QA0KPiA+PiBmdWppdHN1LmNvbS8NCj4gPj4gWzddDQo+ID4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDUxMDA3MzcxMC45ODk1My0xLWtvYmF5
YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+PiBbOF0NCj4gPj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY3hsLzIwMjQwNjA2MDc0ODE0LjU2MzMtMS1rb2Jh
eWFzaGkuZGEtDQo+ID4+IDA2QGYNCj4gPj4gdWppdHN1LmNvbS8NCj4gPj4gWzldDQo+ID4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDYxMDA4MjIyMi4yMjc3Mi0xLWtv
YmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+PiBbMTBdDQo+ID4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDYxMTA1NTI1NC42MTIwMy0x
LWtvYmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+PiBbMTFdDQo+
ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDYxMjA3NTk0MC45MjUw
MC0xLWtvYmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+PiBbMTJd
DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDYxNDA0NTYxMS41
ODY1OC0xLWtvYmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+PiBb
MTNdDQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDI0MDYxNzA0Mzcw
Mi42MjAyOC0xLWtvYmF5YXNoaS5kYQ0KPiA+PiAtMDZADQo+ID4+IGZ1aml0c3UuY29tLw0KPiA+
Pg0KPiA+PiBLb2JheWFzaGksRGFpc3VrZSAoMik6DQo+ID4+ICAgY3hsL2NvcmUvcmVnczogQWRk
IHJjZF9wY2llX2NhcCBpbml0aWFsaXphdGlvbg0KPiA+PiAgIGN4bC9wY2k6IEFkZCBzeXNmcyBh
dHRyaWJ1dGUgZm9yIENYTCAxLjEgZGV2aWNlIGxpbmsgc3RhdHVzDQo+ID4+DQo+ID4+ICBkcml2
ZXJzL2N4bC9jb3JlL2NvcmUuaCB8ICA2ICsrKw0KPiA+PiAgZHJpdmVycy9jeGwvY29yZS9yZWdz
LmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICBkcml2ZXJzL2N4bC9j
eGwuaCAgICAgICB8ICA5ICsrKysrDQo+ID4+ICBkcml2ZXJzL2N4bC9wY2kuYyAgICAgICB8IDg5
DQo+ID4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4+ICA0
IGZpbGVzIGNoYW5nZWQsIDE2MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0K
PiA+PiAtLQ0KPiA+PiAyLjQ0LjANCj4gPg0KPiA+IENhbiB5b3UgbWVyZ2UgdGhpcyBwYXRjaCBp
bnRvIHRoZSBuZXh0IGtlcm5lbD8NCj4gPiBJdCBoYXMgYmVlbiByZXZpZXdlZCBhbmQgSSBiZWxp
ZXZlIGl0IGlzIHJlYWR5IHRvIGJlIG1lcmdlZC4NCj4gPiBJZiBpdCBpcyBhbHJlYWR5IGluIHBy
b2Nlc3MsIHBsZWFzZSBsZXQgbWUga25vdyBhcyBpdCBpcyBteSBmYXVsdCBmb3Igbm90IGNoZWNr
aW5nDQo+IHRob3JvdWdobHkuDQo+IA0KPiBJJ20gd2FpdGluZyBvbiByZXZpZXcgdGFncyBmcm9t
IERhbiBmb3IgdGhpcyBzZXJpZXMuIEFzIEkgcmVjYWxsIGhlIGhhZCBzb21lDQo+IHByZXZpb3Vz
IGNvbW1lbnRzLg0KPiA+DQoNClRoYW5rIHlvdSBmb3IgZXhwbGFpbmluZyB0aGUgcGF0Y2ggc2l0
dWF0aW9uLiBEYW4sIHdvdWxkIHlvdSBtaW5kIHJldmlld2luZyB0aGlzIHBhdGNoPw0KDQo=
