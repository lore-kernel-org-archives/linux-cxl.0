Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10F171A4
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146666; cv=fail; b=ifgHFSZ1eE/U4plqdCwCk8/v2GdtZMeV/gF8zUoLz0ZHx5b406T5rYVhX0m8lNWbzIVuGqpj0BdUxWlS3WRaW1JH3q4a7sVCTvqQowDefZpRJRiMnzEwEOu/z2Tn3xMlzs/ivRkdSgWCPiaDhkTkk2jF/OD/kRwkn6N02IwZuj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146666; c=relaxed/simple;
	bh=t67PDfJKJrBor2QSyHYULxq4rrn04YgKegMdwVIy9kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPahKVGUyx3KBKfDOYMbnXb8E8AR4vnXRgv/Dy+CMxN+TvxhoFvfcuohUVa52vGGMdhSOOjjA0I2VNrukmvBaN/FIa8X02+JXL9CHSGw3Xox4XfnmuXRn50TadA7hPWgEhQ1baCbgSVcctW5C64wbtqNPMhJa1beIpOGEaTlfp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=umzmWM/f; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="umzmWM/f"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720146661; x=1751682661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t67PDfJKJrBor2QSyHYULxq4rrn04YgKegMdwVIy9kA=;
  b=umzmWM/f/h2r/PD2oKKisRNwI9t+WdsBDE02TroCQ2JpCUTGNhmfzTBB
   PCaGrn1wwa2eTg1xB0+LnGgVDWUQeVQldThdR7Mz1WZdEpaIc3e6g+iN1
   4FNQ63Z6+O8VLNxD4m9yDKM260tLrJYBWUfYh3I5Min/rfu53q8YBdXbt
   gZ8DSEr3wdFANO2F/owD9CWvCteY2WARSALMZ3mZ/hkt2MU4vnyO7jxBO
   tM+RAkPUQDYtTWAVrxuaLpk+Uzm10vusCqafqhZ6sxLz9x5w/TmPnouWS
   ya7XIW1yGpRFJG7J67mlILYalD2+/SUcYgu1dxNcdcDyqY897pIFY6AzK
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="125106064"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; 
   d="scan'208";a="125106064"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:29:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NstM6JEYOYn/zP0NnpD6YYHStdpR+eeLfvzNbwfH8d5UBx9UTu4onLFBlBOg0TXotvtU8m1AkCrslJI8iIm0749vt2xUo0lzDJUnQiM+kvpnswlOwElKnULEv5/tbBNDG5sFu0use2ydqRUwEpGKTFuTutQtGiklSKbPrDTCsWU4NBHE0CB4YWlM+xyLTnOTwjiUbq7vYsB7xqOdLrW4eCTdFgB3azARxCR5VyO+QY3EN5k4EITH1wZp/k5Ah9wu6OE8dQhtEK16uCdJSsOaTmZVkisX5WH3VqfYPWeay5mZ1CDQE0OA35hV2kkSJC4SfTsjVwXbeh6HpIRUa3BZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t67PDfJKJrBor2QSyHYULxq4rrn04YgKegMdwVIy9kA=;
 b=PnM+eII2V6B536lNvi1U3iO+KpW05tntpeLhhoq1G7/Na4lNv+5Qb71oTo1iPn7A+hKvzAZEw2lffDllNA1Hxq5uAocHhsGKq/DVc0JA0Ve80yETQiaaA4p0X/ZT9m5+L2PUu0YE2d3rDiJRuUhQpbYn8BAFp38njq2n1n68IPKgu/3q3gJGOGpq4suEU0yerZWjNFPiG1WkkoQb/IygRFwUjKKQ5i6la0rlxTC0iC5BH98sRpqJNS68cXtPZVfolHb0lnkoeMjW3DiNTyDk1MJCvYR32Mz0SrpSeGZCpvajXaIUqcm7v8REpFOjnomBDzj4+4/P/xKjmqB9z00xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB8778.jpnprd01.prod.outlook.com (2603:1096:604:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 02:29:35 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:29:34 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Zhao Liu <zhao1.liu@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linuxarm@huawei.com"
	<linuxarm@huawei.com>, Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Thread-Topic: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Thread-Index: AQHazI0G7GHzvpfI4kaBYAMfHI2F4LHnVZEAgAATqQCAAAQCAA==
Date: Fri, 5 Jul 2024 02:29:34 +0000
Message-ID: <eb397f41-9a81-4b1f-a1ed-7f0b99b42b30@fujitsu.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
 <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
 <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
 <ZodXMPef9bIROG5u@intel.com>
In-Reply-To: <ZodXMPef9bIROG5u@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB8778:EE_
x-ms-office365-filtering-correlation-id: 987c9400-5ff6-4520-b3e6-08dc9c9a4f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?MEVWQ2luNWJudVQzc1BBNTN1MnFtcEVSZVp1am5NaGZpV2F4dEpEa0xkeUhn?=
 =?utf-8?B?bGhuVzJyem9adlVlckhHQzNESUozNEhKby96WUpjbWh0R3EvWlZaWlk2UzRG?=
 =?utf-8?B?NDJySnZEYzZnMytNZU9idEYza0dseGJTbGYwc0htM1BTSGpwTnNNd3k5RHBw?=
 =?utf-8?B?MXpjdTg1WS9NTnNnTGxWZ0xHbHJCbkVyYTIyZWVFVzhCbE1LRklpT0g1VFJD?=
 =?utf-8?B?akFaYUpBMDJCUms0MUlGazRqbmNpK2xXV0IvNWNROE1hbmV6cjdYUmgycWxo?=
 =?utf-8?B?a012eWRWa2gxVXYvZDdSODBnV0QrY3BUaHBkSXUza1F3dFhDNll0dzE0RHVZ?=
 =?utf-8?B?b1ZDM3M0SzhlcDRBblVCYTRRZEYraUg0UlprVndXamhKNVR5V2NzUWVSeTcy?=
 =?utf-8?B?OWFoU2R6VG8wOHBLWk1OWG5lTXlKbXpOVENHeFRHT0lhYURza0ZGRWkzQ3Vp?=
 =?utf-8?B?VVpVSkNsblZtY2lPdVREc3E5UWkxdlFmUkcvdER0dVo1WXFOc2JkckpodU5F?=
 =?utf-8?B?TWtJdSswRGhrM2pscVVVaFhkTldPNUp0Zm5XS2txaW85NHBCbzNTeklaZStw?=
 =?utf-8?B?NXlxU3p4U1E2Rmgva2t5QytMRmdYeGNNdTRPc2FhNXRyS2hsODIrcnNQKzF5?=
 =?utf-8?B?eGpVcGVmbE1ka3ZQdS9hT2pzWnduNXBFQnRkVnNoczE4b2ZZQWpsQmtaNnlx?=
 =?utf-8?B?WlY5V3E1MVAwdGx3ZS9nVnIwZVkzVnVyOGxXcWNsRHY3TEIrb1FLK3J2ZklK?=
 =?utf-8?B?SFFoYnMrMUx5QVJwcy9iclVsbEg0c0p0MFkxZlV6OC9iczk2VTdnNm1MSXlu?=
 =?utf-8?B?aysyV0V6YjFBZW1rbDBpQ01hUW9YeStOL1djWFVMMElieWE0QlNxa2JJQmNn?=
 =?utf-8?B?VXM0OXhKMHVEVWVleTZKNVVsUldsWWhvWkJIbitscGdGaEhHN0ErMzBMbzAr?=
 =?utf-8?B?bnJ3Y21HM21qU0szZW03c2luTmpGS1l6bkk4ME9ZRWptVkljTDJFanMrRnZW?=
 =?utf-8?B?NjNuTm53aTF2UTVwaGVIS2p0Wk05U1drdU1RNlBRZVlxUXRUei9Mb3Q3Y0Iz?=
 =?utf-8?B?d2ZJVVBBVmV0WjFvSUdMaG1xOE1zTjdBeTNqOXdRQXY2ZXRvclFySjh3WGxa?=
 =?utf-8?B?WDdSQXZ3c0h6cWNzNGQ1NVhsU2lGOGFsV3ZOWUVRRGVrUUpwODVRdzk5U3dB?=
 =?utf-8?B?ZVIwQnZjUlR4dmh4OUxxV1hsb1NwOFpHbDhNdEYvaW9USkQzK2NjRVJpc3Bk?=
 =?utf-8?B?Y1dpR09iMGVoNGJ4OEdwTXBwOUdHek5Vc0REdzZOOHpVYllidkJ5ZXJZSXJt?=
 =?utf-8?B?UmRHSE5WSWFlaC9Ea2lndVlrRlkzRHIrMTQ3ekNGL0VCZlBoYTlqSk9qSlFx?=
 =?utf-8?B?ZUFhNGhTTUdrb0ZtdmRienRtaDhkRzlNQnY3T3B0R2dJUGlvNFBLd2VwMDAr?=
 =?utf-8?B?RmErTStBRGp4Wm1PeTZQUGh4Q3B0a2UzYjFlWjBsbHE3cDRCczM1dXh2ODJh?=
 =?utf-8?B?OWF5SFQzTjdPRDZlc1dwZHRFZ2VOWWRiWHFHc0tsbE5EL0YwQ2o2VnpHSHRY?=
 =?utf-8?B?NjgzU2NjR3lSdkozMWNCZU05WGdjTDhZNll3SmFXNzN3U0FhTmloM2xIbDh5?=
 =?utf-8?B?UUtJVWF2ZlBobXc4b2hUNkU4WVdLQTlEbEhPTGZlWjNkS3p2ZXBiUngxeklv?=
 =?utf-8?B?U3h0OWRpVWtoRFd1dlJZSzNmVFhqVktmckJ2dW5xeGkrNVNKM000YjhrMHQ1?=
 =?utf-8?B?YkpEbVVZZThZN2Z0OW9wUXo3VXN6VnhQaXpzNDFURGphSlYxYmhGbzZJUFl1?=
 =?utf-8?B?a3Q3cHdrSkhJN2wwZlJwRUIyWlZtQWZWdXNrb085WEtKUHQzelpHbGVEdGpR?=
 =?utf-8?Q?egWVnLwo/rSy4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGtCbVhTc0dCTlBIM0JaYS8xOGhDY0VKRXFZN2kzNWJSdTIzS1F0NGd2TVRi?=
 =?utf-8?B?aHg5UXdPbllmRyt0RU56SU1aZ1J3cXV3VEQ5TTVuRURObUlib2hVZWFYVGMx?=
 =?utf-8?B?cC9IbmFwL1ZXL1dxeE94Z21ObkRHNlhGS2VaSHV3Vjl3K1dTZDdGd2pxUU5u?=
 =?utf-8?B?UjBYWEFtSTc1L3Z3TWcvQ3dxdCtNYUJ2UlIxaUpkUEhTNFFWbS9icUEzbE8w?=
 =?utf-8?B?STMyNXdXVWlXKzhiblRvZXBnWElUMzlXNXJlanVrRzNpVUlkbGx6RUtzZi9G?=
 =?utf-8?B?a2E0ZHBnV3RsalFrQVVrL2NyMUlQYXBDdzBkd1dkTWNScDVubmUxZnZtZjcx?=
 =?utf-8?B?M0RGc2RtdzhtNzZKT05qUjhGWEY5ZVRSSUNPc1RDbW9VV2VuZDcxcElaZHB5?=
 =?utf-8?B?SjFKUy9JMW9iOXh2QkJZWTNuZ3lUWnd4cyt4SUVLeldCaTlhUEt1Q2ZCMUY4?=
 =?utf-8?B?Z0ltTXZ5TlRwVURHMDE3cTd5TXl2bjY0VGE2a0MrYkJ6dXhROVpJZ0pyZEtP?=
 =?utf-8?B?V1BhdmNIbXB4ZTZoTWlFN1pzZ1FnNFQ3SVg0bDJzRE8xV25FUlFFTEIwVksr?=
 =?utf-8?B?ZFhOUFF1bHBvS3IxNFFXdjRHWXFBQ05jWitjRVBha1poMWlEdEszUnNsSUdW?=
 =?utf-8?B?a3RGUGZBWlMrSENZWEhSZGJhaXcxQUM5RnFua3piK0RBdDlNZjQ3a2NPVklY?=
 =?utf-8?B?RFJzM1lhRU5TUDIwblpHTlFESjZVRWVBN3l3ZHpuTlBmOW5rai93STU4b0NP?=
 =?utf-8?B?eUVZVWFWM24wdDhaMVhsdEthdnVsQndXM2RGT1V2WFlTVWRJS3grTEZZR09B?=
 =?utf-8?B?V0VieHdmVVBIemowcnRkOXVveXZQRk01TE9QWFlLNTBScGJFN0E4OTl2UHBL?=
 =?utf-8?B?eXNpYVEzTkN0OHFWVXBjeHNHZFBiTDRKQjNvanBkWktoemdqdlQ5NE9Bb1dH?=
 =?utf-8?B?d3RUYUxsZEhvYlBMTHJwUm1BNDY4amcvY3ZWalFsN1Z5K1RWS2ZWamlVeUFq?=
 =?utf-8?B?c3UraWtyTys0YTVXeHNMZmU0NVlCbWtqOHJYWDZ2ZXpBOFlZT3JBRTJFdFIv?=
 =?utf-8?B?QTkxRFZHM3ZDOVJJWmp2eEs1c1dqbHB4ZXFiVzU2YjFYN2txTWJPRjlvaGgz?=
 =?utf-8?B?eXNtb00wa0s5MTViR0VFU1FMbE1qd0ZURmthc1ZCSkh1ZmZVcGtNWXI5VkJO?=
 =?utf-8?B?RzNlOWwvNWVJVmVtUkxneCtsK3JNSnRrMWlROHh5czVreTRsUXB1M0hMbjZT?=
 =?utf-8?B?eThjQkF2TDltQkh5QWVHQmRHUzBBeCtpQUd2eHhPa1BNam45ZkFFNHJzajhV?=
 =?utf-8?B?eDJydTJRQXhNVUlZb01ISUtIQ2ZYT0JHdU9zVzlhVWJtbGhkazhQa0pMQlZz?=
 =?utf-8?B?L0VLNElLTUNiSTdHMERlNnJLZTZ1ZHZTWC80eFRQdkYxOUlvVDNYYjY2MzRW?=
 =?utf-8?B?N1ZLdWRhT3RncDk4aWRjTUZBNU1YM21BQjdwZW56Lzh2V3Rudys1ZWpRRHhq?=
 =?utf-8?B?dkI4b1BOV1IvMHVueW93aVA5aEFNaXhlRlJWQVhFNXNkNXd6MUg2Ym1xRmNo?=
 =?utf-8?B?SlN0cUdQNnc3aUYrNFpXV2NXNWZZaG1BTzJqeUlRcGhSMDhabVFrVHp5K2lU?=
 =?utf-8?B?VGRnemFXZVl5R2hrd2Y4VzBFOW1OOElia0FmSWc0M09XaTA0SUIzUzZRYWpR?=
 =?utf-8?B?akdjbXVmcnh1dXZSUXpzamZOYlJKUEc0aEt6b21hdUlzMDVjMWdYTmtBdlUy?=
 =?utf-8?B?cGdnczQ0dXlwMDBQNFBCdlFydWI1VXdyc3ZmR3lybGJwUkpxMDRxaFQ5WUZY?=
 =?utf-8?B?SzNERWhyR0p2Ukk3dnFJY0RQVTJlZHlpakpvbWNkSVBjdnlnOXZzQW11UXpH?=
 =?utf-8?B?SnJaU0NiWXlrTTMzRkFRRG9vcjdIYWZMRmswenNaOXRYM00ydHdJbUc4WXoy?=
 =?utf-8?B?OWFiZ0t3NnM3NGQvTTU4SGR3UjlFS2d5ZWN3aXhLTHAzZ0xIdFFiZnlwR1ZF?=
 =?utf-8?B?WkwrRmVYK3pETTJHaGY4SHM0ZVRVNU4vTzdGRS96SUhjMjBZU0pqTlBUVUxG?=
 =?utf-8?B?bk80cS9kaGhGUVVRT1RwYWVyb2NoWW5tTG85WVpsK3A3V0tXdzRISWFKTFVZ?=
 =?utf-8?B?MjNGcm5NL1ZnZGI5bUdCNGxlbS9CRXVYWmIrS3lUa0E0eGNsTVY5cHFDaFhs?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF55B03C40B2747820582BE7915D01F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BYpEI35LOGd3ipoiTvf9dunjbR7GOujvtgWWKilMXXgixYYXmcbNCEXTkDr30jfRgdRDl8Q7Ix9Ce63XPS0QCRp84xfppKdPlanaHiFbjRAzQijLoJHG+mKog8OfBKSPHQHH8e+l2EdMhbl3FZiskYY1yZ2EpeX8UwWcwRBoEq53cuEPNqGBHoAWVTKuiksT5ZNUulo8RIghYnGAz0iGuPEmKu4BETTcdFg8DRWqcL8uH8FCQJ22x5fN9z8VF31WXI3zz0mURgs1q5AIXNEnxoREFqSkyIsXFWs11YlPRECB7qpgM/VuqS89fN1wwAXgvwKdI2/KIDG/xnfEzI6Eq5WDWs8pjIIrXi71F8AaCRzdNmbu1tjuJ2JeRTcqJHiNoJAnwIjrkf1iGi6lsMqJH5H0UOBTVJILqD6f0oxDRHY5ANNKgDUGrhsxJqyhvQ66Cy0uzGvyjvQqBYaLV8FZT4kofxuyKEH9iR91psTPclH83Vzu3dHViLOBTID2NsTXcmgV/Q6dbQX1vAsnwIKK+PmQUJhERd/pzF0MjwNzACOWAePGJfCd8KbBHTZfLUB9yaivp+tGdL4E3z77xY16l09i5R34jN4XWf5vff2naW5X9jeSIWIV5obovK6Dm0jg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987c9400-5ff6-4520-b3e6-08dc9c9a4f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 02:29:34.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MUpdR8ZIHrPex+sa1XuihRkXVOctygEowVme3lWZhER3yZMl0yLSENURWQMIETItqeXxx4ZXhRKYmTOjPIWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8778

DQoNCk9uIDA1LzA3LzIwMjQgMTA6MTUsIFpoYW8gTGl1IHdyb3RlOg0KPj4gVGhlcmUgaXMgYSBu
ZXcgdXNlciBmb3IgY2Ztd19saXN0IG5vdw0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI0MDcwNDA5MzQwNC4xODQ4MTMyLTEtemhhbzEubGl1QGxpbnV4LmludGVsLmNv
bS8NCj4+DQo+PiBTbyBJIHRoaW5rIHdlIHNob3VsZCBkcm9wIHRoaXMgcGF0Y2guDQoNCj4gSGkg
WmhpamlhbiwNCj4gDQo+IEknbSBub3QgYSAicmVhbCIgdXNlciBhbmQgdGhhdCBidWcgd2FzIG9y
aWdpbmFsbHkgZm91bmQgYnkgY29kZSByZWFkaW5nLg0KPiANCj4gU28gdGhhdCBmaXggd29uJ3Qg
YmxvY2sgeW91ciBkcm9wLiDwn5mCDQoNCg0KImh3L2N4bDogR2V0IHJpZCBvZiB1bnVzZWQgY2Zt
d19saXN0IiBpcyBubyBsb25nZXIgbmVlZGVkLg0KDQoNCg0KPiANCj4gQW5kIEkgdGhpbmsgdGhl
IGZpeCBpcyB3b3J0aCBiZWluZyBsYW5lZCBiZWZvcmUgY2Ztd19saXN0IGdldHMgZHJvcHBlZCwN
Cj4gZm9yIGJlaW5nIGFibGUgdG8gcG9ydCBiYWNrd2FyZHMgdG8gc3RhYmxlIFFFTVUuDQoNCllv
dXIgZml4WzBdIHJlcXVpcmVzIENYTFN0YXRlLmNmbXdfbGlzdCwgYW5kIEkgdGhpbmsgQ1hMU3Rh
dGUuY2Ztd19saXN0IHdhcyBkZXNpZ25lZCBmb3IgKmdldCogcHVycG9zZQ0KYnV0IGdvdCBtaXN0
YWtlIGF0IHRoYXQgdGltZS4NCg0KWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNDA3MDQwOTM0MDQuMTg0ODEzMi0xLXpoYW8xLmxpdUBsaW51eC5pbnRlbC5jb20vDQoN
Cg0KPiAgIA0KPj4gT24gMDIvMDcvMjAyNCAyMjozNCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToN
Cj4+PiBGcm9tOiBMaSBaaGlqaWFuPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+Pg0KPj4+IFRo
ZXJlIGlzIG5vIHVzZXIgZm9yIHRoaXMgbWVtYmVyLiBBbGwgJy1NIGN4bC1mbXcuTicgb3B0aW9u
cyBoYXZlDQo+Pj4gYmVlbiBwYXJzZWQgYW5kIHNhdmVkIHRvIENYTFN0YXRlLmZpeGVkX3dpbmRv
d3MuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuPGxpemhpamlhbkBmdWppdHN1
LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uPEpvbmF0aGFuLkNhbWVy
b25AaHVhd2VpLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBpbmNsdWRlL2h3L2N4bC9jeGwuaCB8IDEg
LQ0KPj4+ICAgIGh3L2N4bC9jeGwtaG9zdC5jICAgIHwgMSAtDQo+Pj4gICAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY3hs
L2N4bC5oIGIvaW5jbHVkZS9ody9jeGwvY3hsLmgNCj4+PiBpbmRleCA3NWU0N2I2ODY0Li5lM2Vj
YmVmMDM4IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvaHcvY3hsL2N4bC5oDQo+Pj4gKysrIGIv
aW5jbHVkZS9ody9jeGwvY3hsLmgNCj4+PiBAQCAtNDMsNyArNDMsNiBAQCB0eXBlZGVmIHN0cnVj
dCBDWExTdGF0ZSB7DQo+Pj4gICAgICAgIE1lbW9yeVJlZ2lvbiBob3N0X21yOw0KPj4+ICAgICAg
ICB1bnNpZ25lZCBpbnQgbmV4dF9tcl9pZHg7DQo+Pj4gICAgICAgIEdMaXN0ICpmaXhlZF93aW5k
b3dzOw0KPj4+IC0gICAgQ1hMRml4ZWRNZW1vcnlXaW5kb3dPcHRpb25zTGlzdCAqY2Ztd19saXN0
Ow0KPj4+ICAgIH0gQ1hMU3RhdGU7DQo+Pj4gICAg
