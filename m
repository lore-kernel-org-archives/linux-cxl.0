Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801E26FDA3
	for <linux-cxl@vger.kernel.org>; Tue, 15 Jul 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565882; cv=fail; b=JT4kJ3beOrirZSP1siy5xWI8r7QIvIVdWx0dFW75vWdRSneO7YZsAsAa9DZ2+P4TFf0W+oR0MpN7ONJOcMAmaubKv7PV3YOXFHwPk3RlRzhIqrrbquEgGu9guxrOJ59VkjLhExzB/sq8LdIoAhEIazN4Sr4skELasJMRxpJm+lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565882; c=relaxed/simple;
	bh=qxvPBMCV0nVr0P0m55DzfIFF9MUxV+mjmTfUyU8Vbsg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FNRx744cm/y7GY7h8t5adsAxhIRdoENeuhrpc2P9RWkFaNz7UzrMfbD5x5UVM1NI39qbtRZLFutrxt/0K3Y3EbsPSLQw9Mkh9O9V6s9Kx0dJzYvYlVcsKJI3K0vas043fZWB6oceKkmWV/FAU2wCtZ8+MhD1FcMR398kPkt/+gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=O4kUnENU; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="O4kUnENU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752565880; x=1784101880;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qxvPBMCV0nVr0P0m55DzfIFF9MUxV+mjmTfUyU8Vbsg=;
  b=O4kUnENUDFy/twtK+EDJeq/6P3V/Dhv5agMzQH1Zh24rDlAFh2b1J6L0
   0DgPKvcce/xCD719Gm6aYN1smzuYDD3tw2oHesapDXpOKolZqFbqW5T5A
   7vz6vNvgbI89L3H3ouBU/X9cCjDNdzK3s6PTy0KSsfIoGCwW1Q5LlynlO
   ECTCg0PyMuJ9OTv0sUTI0OCUnu1Q9QefoLOfiHVab1YHTUtw+TOnBXE+y
   maVAPuxxELH3RBuaKwwznMr0thH9sNtCnF8eMIUr5K4Ykj/nHkYGBv3vr
   8bUjYkNPgtfzmYZslba8YKwY2XU0rMVlAeiznA7tjPS8GW86oyxIDuthe
   w==;
X-CSE-ConnectionGUID: p9/6MlXoQS6oTorsI7CKng==
X-CSE-MsgGUID: lhVbSEgLT9KzPsKEDIF1XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="161144506"
X-IronPort-AV: E=Sophos;i="6.16,313,1744038000"; 
   d="scan'208";a="161144506"
Received: from mail-japanwestazon11010018.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.18])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 16:51:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drLq0UKuLqBC2sAegMZKUIZ3pPlzJZvqxeZhzH9JMCRrHKkx0DWCylwt9iKr8MUvb4AVKIR1dC/zB1jFMs0llCFIri1uM224O1aB1WmeKsQZ+c8mvzza+Zz7ES5jRW9pl6qtbpEytTDM4oCw2Te6vpSrtP+DEj/fcuQAajWJ2NxY4WrEqXHU80TkLrRh4W839jzYxxF7eYPA5zYTMNhdSEub3ImrTVnoNhEn60eWZhPFYjqBf+xcXUaeEYaYPo5W4tHFFvwF8S/CrgU0UUNx7rNhRsBLCF6Vhh67fzh8yVgj/OE5LdEpLDEtE9gTYdgjfq0fbW1itWEh5dqEfoU9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxuQ4H7xoi7sDgykB6GmYQFoqmN3tiYcg3/dqsI8yfs=;
 b=gSSr8F3WWcEQe0F+KOfoKVfF27EgM2pxtJDv2SD8IdsTjx73V9D4Wf5ZjEs+8BQ051kTLzsskWa6l0NB7xt7hobfwjCzq4a65zmCCHatm7Y1MYMoUQ146539vWM3wbRYs89GIaLFVE4eEYL3PkZOF+U2wPWK9bDQ7ZOfOSgtHi7QBzdCo0SnNrBSNIarZ6tQBj8rZQiILBomwZHUaZgHWZdwqse78VBzU2sFwRv46mcdCBVR35VCBoZdSblvMIVE6dI6PyBSl7gJ4sccSwU88SAre3mXDeqim5YXfYCZ9XBr+WByt19Nn/o5mm/rqrxH7B9JmC1Wn4/wL5VwjLgAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com (2603:1096:604:2e2::9)
 by OSRPR01MB11507.jpnprd01.prod.outlook.com (2603:1096:604:22c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 07:51:09 +0000
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::6569:be59:abd6:eb0]) by OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::6569:be59:abd6:eb0%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 07:51:09 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: "'alison.schofield@intel.com'" <alison.schofield@intel.com>
CC: "'dan.j.williams@intel.com'" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Question about Exact Match Requirement for Switch-to-Endpoint Decoder
 Mapping in CXL
Thread-Topic: Question about Exact Match Requirement for Switch-to-Endpoint
 Decoder Mapping in CXL
Thread-Index: Adv1XFjoApnbBZ3dQCGdRpNwupcLWg==
Date: Tue, 15 Jul 2025 07:51:09 +0000
Message-ID:
 <OS9PR01MB12421AEA8B27BF942CD0F18B19057A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=c6b868a9-8322-4e71-9071-01ebd491fb23;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-07-15T07:50:56Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12421:EE_|OSRPR01MB11507:EE_
x-ms-office365-filtering-correlation-id: 62704053-1eb0-4a4e-0a40-08ddc3745c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?eW43d2hUUnI2azlLS25PTHNJc3dyTDM0ckhYUERWVFNSdi9oM1BoUjVI?=
 =?iso-2022-jp?B?MmlydFpmZjZkS2FsRFNuTzAxK1hhV2ZJNDZ3S0RnNGJ6ZGUvSnVoUFky?=
 =?iso-2022-jp?B?SHdIVHZ4bDZrSlpIYTJObXMrbzVBbjVwelF3c1pxMi9tTUVPcVVtY2Iy?=
 =?iso-2022-jp?B?YzhMWTB3V2JxV0FwWFhmVFFtVTNtL0tPVTZtRVhUZExaK29pQTFFM2hx?=
 =?iso-2022-jp?B?eldhRVBiMWl1L2VvekRkS2R4T1daYklHcGQ5SWpDU1ZEVW9LbENiK1Fs?=
 =?iso-2022-jp?B?Y05kNW5JZmdidTB0cWtlR1lFSlkvN2NOQ1ZOSC8wSHkvNGo0Z1hVZHow?=
 =?iso-2022-jp?B?U1JSdUNwWDgreUdDNmIvbGE5Snc2Y3F2RVRGOFVob09YbGJpQ2hTN05O?=
 =?iso-2022-jp?B?ZjJwWXJra1VldzhLUUwrZmZHV2hlR0lMb0ZxWDFEK3hkbXl3OTJqMDYz?=
 =?iso-2022-jp?B?Ty8wVWJJZCtoNjZmb0tINVkxM25zSTRVemJrT1VTUnFuS3Vuc2RxSTdU?=
 =?iso-2022-jp?B?TVZmNmJtdEtVSDZwQWtSenVnb3ZJaDQ1RUlQdmRjUW9kdy9yWDJjK3J4?=
 =?iso-2022-jp?B?dUVRdTNoVjYwb0YxRVBGZ3VBNTIwYTZaR2J0WW9MUjE3SUtjd0RvUlVh?=
 =?iso-2022-jp?B?RlRhbEFXNUlwRldzOXFNYjNvVHBBUmdJS0hITjlMcyticzJ5eEZDTVBy?=
 =?iso-2022-jp?B?VVB2cGVkRS9oY0hmT2ZhTWVvOEJ5ckN0R3FTejVHV3FnblMya1FTdmJm?=
 =?iso-2022-jp?B?b1pSRW5xVm1pamJ0V0hRYlZDd3lqUWVpMzZmV1pLTzVvU1RxajJ4R3pW?=
 =?iso-2022-jp?B?bE1sQ3A5V3p3bXdCdEJXK3hUcjluUkdLY3dZb0V4KzdxNEhJajg0WVll?=
 =?iso-2022-jp?B?OElEL1BxWVZ2WTdhQ2tDaVlqMTJ2NGIyN29mN1pkaEJZdG44QjV0R2xl?=
 =?iso-2022-jp?B?Y2dtWlAxUkI5VU9mVnVORlVvSEl5OE9IRjNqZWhKbTFIM1I2Sk9kN09i?=
 =?iso-2022-jp?B?V3A2SjlCYzBibEc1UllvZzJ0QnRGRGc2LzMrdEJ2M0RMZ2RNN3Jxdysr?=
 =?iso-2022-jp?B?Vm1YMWdMTW5CZGhjYUdZdmdMOFFvN1lWSHYwSVhSRFJVTEptaVNPbW8x?=
 =?iso-2022-jp?B?aWxzcXhiSUtDUmJ3M3dSazBrOUdIS1Q4Sm81Mmx2bUk0SXdQckUvZ2FX?=
 =?iso-2022-jp?B?OG1uSmt5YlhYYmNFSmNuNUxPVGtuUXZ0SmlvRVcvakdEVFVsNUdIcitN?=
 =?iso-2022-jp?B?dFBxMlZma1dTQjBVd0xkdUtQeGxzUzRXSDVJVDUxV3Z3WGFqdXdrckRa?=
 =?iso-2022-jp?B?d0xrQzBJc3AwQWlvTHNqMUhNSzZpVDlFVmttVFYzQUMrOUZQcld3RTZC?=
 =?iso-2022-jp?B?STY3YkpBZXhkVGxTSDRwZUFMWFYyTHdJc0c2M3FhNXJjOGRQbnB3bUti?=
 =?iso-2022-jp?B?eDVSMkpDajl2bjBCSHpONkxickx4QnF2R3pHS3lMd1hFd0hxbjJnSnY5?=
 =?iso-2022-jp?B?dUNmZS92cGlpaXBsTnRPUzNjZ05YcWIzc0xXZ2hhSURYQnlRU0lmNnM3?=
 =?iso-2022-jp?B?RDlDM3N3aDN1Yi9UTjRZZE5hdkVYRzdmWjR5Tkx1Z0V2aUFhTEZTSzQr?=
 =?iso-2022-jp?B?ajFTaFFZZUp5QVJBMjU4MW9yVVNraWJTTVRFOEtJdkMrWVdtODhncHUv?=
 =?iso-2022-jp?B?ZkRvZWZTRU5DaEVkanlPM0FPcjMzZThkck9ZODNJcjZtS1BVcmxxTTdJ?=
 =?iso-2022-jp?B?SjZIL2dReWdZYW00dkZzOXRyaWdNMHRkVWJ5ZEVBRzdzY0dUS05kdHho?=
 =?iso-2022-jp?B?YXNRM1E5cjE0Y1A4RUV3WnhIMFJzRFhKazdQZmdqZTIxTzVlNHRTbGV4?=
 =?iso-2022-jp?B?Y241c2F2b3pYL3NrV1ZjNng2Z2d2TUN1bTE5YnFkajhOTmZTRGxIL0M3?=
 =?iso-2022-jp?B?RUpNeE51a2xJNVdGc1pwVlQvdTNFTHpCVHBFclV3Q0sxeWJpWHpvbWRH?=
 =?iso-2022-jp?B?Qml1K3daNjVJK3BrODcyeHRjcHVhV2U2MGI4dHpuZk1iZXRNSmZseFZy?=
 =?iso-2022-jp?B?OEhFU2cxNldHemVadkFQRkFpc09ldC9vSnh1SWd6RC96QjVaVlBuQ3ZY?=
 =?iso-2022-jp?B?UUplL0tPbjVaV3loLy9nVnJ6NFRya2NuYTltenJTUHgyWjRZNVF5QjhN?=
 =?iso-2022-jp?B?QTljeUlMK2U2ek5ZZzcrNGd0U1VWZ1Zw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12421.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?T3NEbERFaDBpZTUrQ3BrOEN5VVlPcVRhOER2WUhpQlY5NERXYTRETEp1?=
 =?iso-2022-jp?B?c2pkSlIzMy9Vc2dHUFpjbDMzSms1TzY0T01VK0lLY0Q5Z3dHWWtjdk5E?=
 =?iso-2022-jp?B?QWNlVkRyTEJVNlNkN2dRYS9oTG8yVUtGNlRPYzFNZ2s2dWJzbjN5ZTZr?=
 =?iso-2022-jp?B?aklldTM1ZVlUMEhrNFJwUDk4WmdNTDQzOHZGVi8zMEZvKzQ4V2ovNVoz?=
 =?iso-2022-jp?B?a3QvNGZzWk5sQjVUWEtGWmc0bm1yd00rbVdabnYwemRlZUVqM0lhQWRI?=
 =?iso-2022-jp?B?bzhNSFVUdkhWMzZsREVqSnByaTRxK3NCT1ZnMGtUNG95Q09ENkowUTVW?=
 =?iso-2022-jp?B?ek5TcENKMytLNG9pc3ZDZVhJemlCaTNFZnFOWjZlQmFZZElCcC9iTm1S?=
 =?iso-2022-jp?B?Um5adVQwdG9jVlJBOXlhdTBmU1E4d1dMaWlta0hoSEgvdWF2c1hsV2Q5?=
 =?iso-2022-jp?B?NE0yZTNyZ0xEQTFPVW1TdVhDU2dtSFUyVGMzQWpZOGt6eEVwdG1aSTNk?=
 =?iso-2022-jp?B?WDcwQXo1MFdLbk5acHZ0Ti9tdEhhdXA2cmYyNjNrdGFGdTVQakZkMVdT?=
 =?iso-2022-jp?B?amhsdGJLYzNNVi9OdncvK2hwK0VaVHR4WElPTlNIWjErSGxhTVJQMTR6?=
 =?iso-2022-jp?B?b1FReWpCRGx0MVYrTDMzRUExNUhWZVBmL2tNLyt5Mi8vSGY4ZGdNaGtm?=
 =?iso-2022-jp?B?dEVuOVg4WTA5U0RZL2todnRUQkE2ZUthdk9CNkRJMHlmeXRkU3Rhditm?=
 =?iso-2022-jp?B?cS9QbmlkOWUvNXdwYzExcHkyQndONitjSmU5RVRhdEVnczNoK0taditE?=
 =?iso-2022-jp?B?UWxtS1pFSHEvUyt4bmF1T25mZWJiRUZ2aGZTcW9rbzYxbzEyL1FlL2ty?=
 =?iso-2022-jp?B?YXpkczhXK1ZEZVlRT2MzWjBUMEZSdm1ua2dNeGhKQ3N6QVpCbGlEa1Fr?=
 =?iso-2022-jp?B?bEFRUkNQbGlRNXVvTURYSTRQVzRJZkIwMHViZ2h3ZUxLSnJaYXIzaXpN?=
 =?iso-2022-jp?B?K0RXR1dZV1ZOME82bktqa2FhZEdzdHczbnNtQnJ6M0NMSjFYdWwycFJX?=
 =?iso-2022-jp?B?YkhldU1mdzAzWGVhMVAyNTJDSGx3S09IVVVVcUlXTjBoRGUzSVdvdE5z?=
 =?iso-2022-jp?B?N1BrbXU1NUNhUklYSDU4R1hsTVdGamI2V1lwQ0RTYUM3YlRyT1c0MzFl?=
 =?iso-2022-jp?B?a1FhMGpHbFlKVGRiT3JuVVM3MHFUMllxcW1LR1Q4Y0Fxb2NwcFh1RW9y?=
 =?iso-2022-jp?B?ZGpVaDE5NG9BMm9ZN2srV0c4M2lMN3Y1SzdqRVFTbE1uQ1N4UHZUMU43?=
 =?iso-2022-jp?B?N2s4eUd6V28rYWplazNqbnpscGh5Zi8vbms4Wm53cVh4Tk0wLzNSZ2Vn?=
 =?iso-2022-jp?B?S2RpeFVrSGRwQi84bGJHNG5mUTNYOERTTXJLWHlKWHJaRFZVOS9wczV5?=
 =?iso-2022-jp?B?YllWQVVzWEF1blVoUWtFYTUzU2xPaUNDcHFlK05JYXFoUkRhZUNCcGw0?=
 =?iso-2022-jp?B?bHlVem96TE95NTZuaEdPeCtYR2xtRmEzdVU3Z1RrMjBYSkpCcTR0Nk1R?=
 =?iso-2022-jp?B?Uk05d2tGdVliTzZzOTNXRWxIY0NXUDJlTzM0ZnFtU05nTThyZzBsbFVO?=
 =?iso-2022-jp?B?bmdIRytvclBIQnF5QW5XZWJ3NmRJeGYvT0RsVHp2OW1kN0VBNmdNZHV6?=
 =?iso-2022-jp?B?ZHFXMEdDTTgwTG83N3NQazVPa3Z3ZDgxeUpXNFh3RkpEYVlRcjlPcFhO?=
 =?iso-2022-jp?B?SXNsM2RQQUlqSmh6VzdPMC95YWk4Sld3Z3RIR292YzkrK2U3UWtqdzhp?=
 =?iso-2022-jp?B?amlvNWVqYUpWM3ZMTlJJSnIrK09peU5BMjRtU3FWWldJN1hncEJNUzVr?=
 =?iso-2022-jp?B?U21IcVVBT3RXT09MVjN3UUw0TThETGxueXV3cURUbVJsSUdxZkJFcThT?=
 =?iso-2022-jp?B?dU1xeEp5L0NwbkxmdHozdG5kK0FVRzRWVVpWUDF1UG15UUc5cGphdXd1?=
 =?iso-2022-jp?B?ZWRxeGViMjE4a3R1cGQ5MXBTTFcxbUp0VW50bTVSNm1WcUdzR0FkSnNx?=
 =?iso-2022-jp?B?bEIrMWNldXd5REswY1BoTFA3MEJmUHRQdWxibkVXVW8xLzIxeEVlOFNB?=
 =?iso-2022-jp?B?WVRNNldBQ1VNTTdBMGt6VFFic3BYODY3dmdGUjZncXNMdWlwd3FyR1p2?=
 =?iso-2022-jp?B?UFhIU2Q0RmM2ZWJNZ2xoSE43L2k1dzlveld1WFlhWjZ4T1BoUU8xYlZy?=
 =?iso-2022-jp?B?eDhMQ1FNbWRHY1FRcElhaWIyTlU2ejhWWkQzRXFzZDRDSGJSOTYyL0gz?=
 =?iso-2022-jp?B?SEFreA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xbt3AfGPmZ034Irn5xL7B+s99pSBGQjesHx3rqz9l6SQRZi63d3ekeY38aTxy4dhKFhWCfJeVbK/Gu3e8DTRbbOTgi82bUcKuUhTEZCami3YeyflmwkdXOjEybUfv6Ag9jofoUa9MB11DXigNw1JN2prAnQSAZTZ79fIclqRMobiI8zIX57Ntck7RZpZxyHdiyv2xqsEAaTKiT19W5khR5/cwtf+8xeymgYfYr9HZNc+auK174Qi/89ABXpREFIC85G6O5RdN4Zt0k/qS4hT2E3CIyfdkLTsANRtVZu1845Wkn1CsKnZ/Xmu89frwbbT2EIe0n1Jxmhs/7fACl7jwrnH4HqPXqPwmt+QmamzEhRlBy8Cv5o68scALxu8sRjkXEbcNjflPb5EupjzFhATBIEuuQ7z4ZajanXqOHWB49PFdCZ1SMZh2aS6Eu0v+RnUWFvPeTZyCq6FcF6g4qzy9VUNpu8YC9CmtiW+58m4E0KNvGuiZhKJwENTnnyTpOmh+a9+xebmm5/HlHLy5j0vLFBYOdwBc532o2N7ptYFQomb67x7hHqxfUdu81yNnxkfy+OsWTKV+z6KwE1CLdr2A1xBt5KnaYeM+hP13l+uQUzHT3NugAzpRzl/DchR6f8M
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12421.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62704053-1eb0-4a4e-0a40-08ddc3745c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 07:51:09.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bg/EdoxdtCsSGa//+Ob6IWZNKVcYWUiUdtri0w9ab/NFd/7vbUnoErOdUNPeLOm/ezDYTU4ddLzHo7gzuakSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11507

Hello Alison-san, and everyone,

I have a question regarding a patch with commit ID 1110581412c7a223439bb3ec=
dcdd9f4432e08231,
authored by Alison-san.

The patch description mentions: " Require an exact match on switch decoders=
,
because unlike a root decoder that maps an entire region, Linux only suppor=
ts
1:1 mapping of switch to endpoint decoders."

The code enforces this exact match for switch decoders as follows:

=3D=3D=3D=3D=3D=3D
+static int match_switch_decoder_by_range(struct device *dev, void *data)
{
  :
  :
+       return (r1->start =3D=3D r2->start && r1->end =3D=3D r2->end);
}
=3D=3D=3D=3D=3D=3D

Could you please explain the reason or historical background for
why Linux supports only 1:1 mapping between switch and endpoint decoders?

In our CXL memory environment, the CXL memory has two decoders connected to=
 a switch.
Initially, we attempted to divide the address mapping for each decoder, but=
 this approach
failed due to the above limitation.
Consequently, we had to disable one of the endpoint decoders and map the en=
tire
CXL memory address to the other decoder. We would like to understand why we=
 must disable
one decoder in this manner.

Thanks,
