Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F610942;
	Wed, 30 Apr 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745983567; cv=fail; b=dcR61r+ac3uwsZZ6gtDgJE9+eyF9RYR6nKIBJ9jM43ktbCidWXkudzMKsi5A340z7IHk4Vg+1pv5VF9Pexy7LKW/OJvCG35Ka0YEIuBnb9/jxn4PBvUZTenSR88eUogiFhugPsMxnvU42tXKUs6CEqlylvclU71yCE+I7U0MXkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745983567; c=relaxed/simple;
	bh=1DnSIeHPiGApvoD3F4GZbchCa8xUvo3thNoMmmpx8es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=apR7j0WG7DEoQh3siHD5fqYzY9/0AFyzjQSz2NrPJiCZdxHc8tuuQ3jwuGvoI3fMyuwLs0d8lKABHp4SkFlAB5UW7Vmzk+hXUM63ggqdKRcTRFbg6Sc0FG4RvKWHDMj/aN735QIDCt7Ru65vow765Ipeow1GljiOn/j5MR09wQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HkMqAZNy; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HkMqAZNy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1745983564; x=1777519564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1DnSIeHPiGApvoD3F4GZbchCa8xUvo3thNoMmmpx8es=;
  b=HkMqAZNy8TA/3eWbwU5FA73fDcut2zN2NvhHI0DVnYQyVhlGa1SAJqOT
   9E0f6uI2HUJEj+NRZWsJl5KmbpXkzH+ochz4HB6KJjOS0X+/lkDgKkapW
   Z4Sj1Toti+R1fGJ02MfcjSlzsgTYXHCnMtGWs5EE3412JLVUSrw6vlPnh
   goua5Xl11xl68pMstmt0AdMjBXA3SZhkn6XxcvXKyDfGFx1BePb976RKf
   UgGxfnEJ0hdNF740ANBeH23IQVvXeSDmmFwUlVPuASpRrimRiD3Rq8FD3
   fTwQ+ebqmBQm7EMcF1GBpETh1dvZODb9cTsYHHxONqBkBBVs5rlukLEf2
   Q==;
X-CSE-ConnectionGUID: HMS01lxhSkGhiSXfLvkyzQ==
X-CSE-MsgGUID: m4c4+p5kQyyZhBNlPJyyAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="154162658"
X-IronPort-AV: E=Sophos;i="6.15,251,1739804400"; 
   d="scan'208";a="154162658"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 12:24:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRu+ARm5HNGo5RU1EEWVSvOuPiMN4IiPVe20IBuIkPdhCw7lsmCnv9uNabZV9pDKovpOdc5B/hhcag37spP4oEUkMjCPhPaG/B2fer2LU5q8MTrua9ln1Dtv4joPX/9D01Kn5L5t5//VPRB3AL3mjL7eV6iFaL+be3aqmTviDWtPBxQxcmr4E9IOumer/yhB+YoN6Q3ZQQjnPem2gCkXKWoldNw25zXtPvcSQleIufpK9DC/tID9CkxRhQX9A8icCrnB9kjrjY9GGh+qN5lrJha8OuM0NhJbzGbzym8t1jngp4Ki3fNmZVnehRY+EPiUhFqkoMUot9wYMou5vUMybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DnSIeHPiGApvoD3F4GZbchCa8xUvo3thNoMmmpx8es=;
 b=Y6XAYOriiCQdnc0BOmNHbefo7GFPvb8mXv2l8SwxvI+IX1n+iaQXZ0Xa+Wf48VJpOndX00PveqsAlfIeGHaNs+NdpHnd0ZfMp3bfQEZ5AJVH1okB6aCKGOHPgBacImJC4OkFmnUbhkRa0Z86rD0Kp/VBWnQrTT9O5ag4+BU7iAp6kG4e0vdq9k+zcL+LeHemZsNCZCSfMV0H1YJ3gDjigym9sSbm6NvuSCNIQSTE5qwr9SRtmxX5ViLzYeewN2C4e5ZZyMUBXkLdP44HWd4MxXyd+ze2dnZBLM9qcBkKeEr/r5PeSSVhP0mBgDjS2ShA30fPjQb8foBVIJKdGiwfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB8596.jpnprd01.prod.outlook.com (2603:1096:604:182::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 03:24:43 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8678.027; Wed, 30 Apr 2025
 03:24:42 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Thread-Topic: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Thread-Index: AQHbuW9Ns3M469brM0+dFIuU2M4hPLO7eSQAgAASz4A=
Date: Wed, 30 Apr 2025 03:24:42 +0000
Message-ID: <082de146-d5ed-4b49-ba0f-d6f018436e5b@fujitsu.com>
References: <20250430012915.295136-1-lizhijian@fujitsu.com>
 <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
In-Reply-To: <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB8596:EE_
x-ms-office365-filtering-correlation-id: 52e58928-9109-4291-13ae-08dd87968c41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?bW1pdisyVlJsbjFWci9LUUNUbW1Ja2c1Y2hQREJ3TTQrZzAycGRNeEQwSm93?=
 =?utf-8?B?U3IzS3Y4UnhHbm5JREtlWXVDMHEvNDBROTFWMGRXL1NrTFhtTTRPVUFWbmNM?=
 =?utf-8?B?dWQxSi9FTDZUUDRmbzAzMmNQaWlTZTF0YlMvM09vYW1NczZHM2YwMzNlZ2lv?=
 =?utf-8?B?alFmbDRvTEdJd1p4eTFrOS9BVTF1TGRnUkUzNjhueUJCTUpUVmg0bVBhTGlD?=
 =?utf-8?B?UDB3ZVVZZWhtOVlkZzJrZVR6U2l0ZDYrT2xVVHg4eHQxZGpqNFh3OGRFK3Y1?=
 =?utf-8?B?eFptdFdVaXVZWkpPeFNmdWF1cUEvSEJOL1dtWDVFbllQTWpZVGlrMGRpUmpO?=
 =?utf-8?B?dzlwMnRWN2VNZ1E5ZVZjTlh6enZrVlV6TTg3cFdsTGdEcWdJb3MvL2M3aEhD?=
 =?utf-8?B?bTJ5VVJ3ckFkc3BBTzNkNklrT052dVJoeGNCZDFrdjkrYmFnZU1qOUZqUmlt?=
 =?utf-8?B?US9tY0FZNVJocUVrYlA4YW1UcEVPWGoxNDE1MEZDTUVkb0FZc0xXVDk3NjJV?=
 =?utf-8?B?aWhXQURsTXVJVmlSSFN6Zmh6YithR21hajJjK3dHS2pYRDJZOFQrenR0QnNj?=
 =?utf-8?B?V1NoN2FtWDEzaitYTitmVktoUTFiQlJldWpxYTRGdmdCMXJRK09WZE93bno0?=
 =?utf-8?B?ektVNXNmdXA2YWRlYW1iRDVxaVMwdzB6TEkzQ2kzaXRNT1NQQ3U5M1FnQkVt?=
 =?utf-8?B?a3p4WGtST01aemdHdUFTcGFsSktkVE5rbW5NVG1nWTliZ0M1TXkyM04weXFy?=
 =?utf-8?B?UG9yZ04xaWRqNzhmNm1aa2hsRzl0eTlFL0RCVXUwZUVQODJSZmp2Y2RoU0ps?=
 =?utf-8?B?WnJCeVkzeThtSGVjY0pQbWJKaE40UlpxV005YmM4LzA4RTRLMy9wZzdHeVV6?=
 =?utf-8?B?Q0kyelYwU2ZSbjVEVEErVkl3dWpSUG5ZR1ZCcFJ1bjJhMXAyMGxWako1eU9Z?=
 =?utf-8?B?bUFBY0M1bDRVclpVeHZ3V0hIRmhlQ0xhL0hEVCt5NDlYeXpWZzNKb3dxVmN6?=
 =?utf-8?B?cDIxL0lnMkxNaUVKN2JzWlFQbWx6bGlqcXNUMFVvT0duenNScmtWWCtwdUxO?=
 =?utf-8?B?ZEQ2aSt6WWxIL2tTazFyQ1IvS01qa1dLWHNvRWdiWGQ0UE9lZHExeG50MW1W?=
 =?utf-8?B?QjhZNWl4RW5NN0h4by92Q3ZpR1dOY1VlSHZ6UHJKTlgrTTlyZ2JJTXQxRFVI?=
 =?utf-8?B?MkhKbjIzUjBlem1DWUJ1TWorREdMTklWVG5PY09xVnNZbHVpdjVndEMzSHgz?=
 =?utf-8?B?aG8wTXE5eXFVWG03ZVJHWll1MHJiTDNUM1ZGa2ZYQ3g3bmdaNFV1UDZOS2w0?=
 =?utf-8?B?VldTalRJMmFhdiszQk9YMWZKMHBMRFpwRGo3TUJyTjRRUXJrQmlLbi90eERk?=
 =?utf-8?B?Q3BiRzluTUJuMHA3NzY3TTEyNlpoTk82MEpsWjVFUGtMSnRuTEN2cU9WMEVE?=
 =?utf-8?B?TjM3UXV4TTZoN0RaTzY1VitTdGxIZ1ZKMWhRakovNlEzSlE3bUdVNDdtR3lt?=
 =?utf-8?B?Ti83TjR5VWZMTG0xV3pMQmVvN2kxME1qbFFaeU1mbkFaVXM5Q3JvbzZ4a2xi?=
 =?utf-8?B?V3ZpS3FSRHB4MzZVTm96bkJxZ0Y4QXJLVVEybDdDeHR3T1VJZXFVMUNCYm9p?=
 =?utf-8?B?S2w2L2pQOFNUS1FqR1NiNTBFRWdldjYvOHZZK2JXcTdLM3BFS09WS0ZHNVBJ?=
 =?utf-8?B?cWh6NjU5Q1VEazFWQUZLbDQvQnhDT1BTV2QwaTVadzBJSS94NUxjczNDamhs?=
 =?utf-8?B?VzlndUlyaGp6cEk0TW5VUmpZdDF0TkI4ZXhvQ2p4dDBDVWt1VzBvSkxIZksw?=
 =?utf-8?B?WXordzJJNTQxbm9ETUI0RTdnUkx5YWJ3NTZwTVgxSzdkT1ZxM1JGeGhWVmZz?=
 =?utf-8?B?UEc2ajBvQ3pQQVZ4L2JzYUV0THhoOERLVjFqYmRNTEVPakNaSFhMeEFFMVd1?=
 =?utf-8?B?N2EyQjIzMnJMYXB2UTZ6RzZCZUlySjV4SFYrTHMwRGJkNThjRDJMRDJncmdw?=
 =?utf-8?B?ckJxbXpQSDFuakhnU214cFNSMDVpdHo0bVRWNytJWGR0Zno5TlZPRG9ZWU1q?=
 =?utf-8?Q?qUtfnl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjdkbGhzYkpleEVmdkFKQUNlQTZ2Wjk0a0RNNHRET0tBWW5GUmlXNUV3OGhq?=
 =?utf-8?B?WDhGZnFIVWNDZEdDUUF4ank2WGpsZi84QldmTW54YVl4NnNXUzMyWEZQRTJp?=
 =?utf-8?B?QkdJUTg4bEt2QlNwSlhwR1k3Slp2bm5BVUV3VGZNcHFLbGFvZ2FWQmZ5QVhm?=
 =?utf-8?B?MjdnSjJ3anA0a1AzdVFQR2t2eTNVSTUyTVRwc1pwL0huVWc2b29hLzhZL25B?=
 =?utf-8?B?VXowVFZ6WUlzUzJtWFRKeng3blRQQUZSU2Ztd0lGbHhJZVBmL1ovYzMyWWhY?=
 =?utf-8?B?UExGSXFDcDc2NTlNTXg3WllCT3hUT0lyL3F6dW56WE5BSkdkRzUzTUl4ZkFS?=
 =?utf-8?B?b1lNTWJ3RDBmYWcyeGNXRXc0V3Rnak4vNmFIOElVdUU2L2pMZjdhTDhMb2kz?=
 =?utf-8?B?S1h3VUpRL09wOFQrTWZjODZzTGxZMHpseUcwRjlaSTZ2WkkxNVlCN3NVeUp1?=
 =?utf-8?B?KzlyYVdYenhzTG84VTNFcUZXQy9sb1BvTnpxZUNrU1JzN0NrRXFrajBsd0Y3?=
 =?utf-8?B?VTlhdDdsRHhQZTA4cDFzMHRKcGhWRXlrZmhZR0ZObWswcEhjMU1oVlZ1Q2dO?=
 =?utf-8?B?eDl1VmF0b0FLWTZSOVdUa2RsRTF5SXBDbXBCZDFaT3pXcmEzU0hxcjZWRER3?=
 =?utf-8?B?SjFraExhZU9RMGxNTDZrcllOL3dEb3RTNlBGUjU3cVQ2d3M1WlozTjFmbEV1?=
 =?utf-8?B?ZTA5TDdncWZXejNOUndpY2w0VWxIV09FeU9oSUdlcTBydnJSOGhZd2hyZmdk?=
 =?utf-8?B?ZjZwQUtlbXZJaDAvNjNwN213SmJmRk5wM0NjYm1naFdzdGR2ckRzbkJlcDl3?=
 =?utf-8?B?cXhhcmJKbk4vcnFjUDlaYWs0WWw1UjBrdkw5WHZ5aERrMmRCNER4eVVjdjFK?=
 =?utf-8?B?SWVROWJYWWtaSDI3Q0M3bW9PcFFhMllXMityUHFxS3JQTnl1azhOQjVVSmhS?=
 =?utf-8?B?aytuYVhQcWdhU2RpMkV2VzdPeFF2eDc2YU1FOHh0K2Z1WFVGZStQTkJuYWs4?=
 =?utf-8?B?T1RYbE1WS0JiTGdJR0N0eEM5SnhhQXZjZHVDK2NYU2drTXN4dEkzbXlST3lK?=
 =?utf-8?B?VmZENitvRGdyd0J0ZW9lYUJ5Wld2MXh6ZTA3LzV2dWN4Nm5kdzNkZS9EQTg3?=
 =?utf-8?B?R1RGTjFPMDJXaG94MW11SmF2RzF3eTQrbGl6TDN3emg3dDcxcG9JUFZLN2Ri?=
 =?utf-8?B?N1MxOFd5Y09yNDhRdjdoYjdISkNzUUkwcHpIZEhlWjFnUHpYcTM3bGJlNmhq?=
 =?utf-8?B?TndxbEFKWk9CUVNxRUVIOVVkRXY5dGlQbU1DT3UvTVlZWklwejlrWU9YRXBC?=
 =?utf-8?B?L1FtaXBqbHFmMUU1byt5ajdiVDhrMGRETXRRcW9LWEoxME5PdVFONHk1Ujk2?=
 =?utf-8?B?bFBpYTM3RUE0MzFRaW54TWtBL3FndjVTRFdFcGdPK1hqdHhJeUFQOU94Vkg3?=
 =?utf-8?B?TC80UzFDWTF3NDRhcXU0RGZEcHY4WUNnbXIxb2UwMDhiUnN4ajJhTmQxV3F3?=
 =?utf-8?B?dlZPY1hXTzg1SDY3cTZXdXFkZFZrS2lNaUZxdExRQVk5Q1hTWWZsK0VXMlNK?=
 =?utf-8?B?RXM2L0JDOTh0RzMzSEN3UmErc3M5azNaQmczQVNSSGw1NVI2RUtRS0xFbFRj?=
 =?utf-8?B?NWs3MmNDTy9sN0FNclpBMk5WVXdGOHQ1K2IzaVFiOElzYkJRSmEvRGplTDU0?=
 =?utf-8?B?ZXdpNDRrOXRMOGUxNjlGVFJ2dForcFlGNDU5SXRibERaSlFzLzgxeTNWQTRY?=
 =?utf-8?B?eGtURDlUZkhNWS9OZ3hFazFnb1NZYmU5Q2c2Z3BscXpuNVNlNlo5YzVpMlha?=
 =?utf-8?B?WTRpMVlNOGwxYTZpeGxwWUxIekpFUmxreDBHdURKcTVZanVFbWhQczdzZzk1?=
 =?utf-8?B?S0t6RUVTN1IzYVJSS0FIQm9kTTNGQU9XWkt3Ung4eEhPVnBUTEFueUh6dkky?=
 =?utf-8?B?bnY3ekd5d1dkZjdUVlhCa2FTZ2pRRjJ2Q3FnWGkzdFB6WGVHUlVGZS9lYm9Q?=
 =?utf-8?B?UHJkQktOcUpncCs4a0lLQi96Q0hTSHNCblRVdVVRTXUveW51Z1JxRm1Va3Ji?=
 =?utf-8?B?MkdRN0RyZUpVUWNhb2J2UGVRa055Y2RVam1MV1B0ZUZLdk9LRGhKRm5IaDVJ?=
 =?utf-8?B?QTFoL3U1Y0xXY01uMjZ2eFpoc2dNU3NHK0g1T3RpUGVNeml0OXpIM2RyU1g3?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7AE371CA1F2A9448A85950F04A1CAB5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J4sBlJGjEntEL347eBTB+gd/SFRrzsx3jOyv7LM+ZQpv/F/fd/mhmJ/XNKR8ssTI95FSmjnqKprQk3/+Eg3l6yVED6yn+V3pgf/kwk2YQ+LAuKNZd3M74pFAJtBj/Fp3xLsm90zoNrbGlzulbvGAZXdaDsoyi32VEcG+bSNR+YJ/hHq8iRYqyUkMkNHPC/kNGjz/ACbGSeNsvPu/paXKPMyEEJcT6bsetgxzG/pM96NqpUGt9eH5fQCPGCIRx2Dsio+XPoPigVUlwAPXf8uRnB1W/jQAxQIDYSs9mZ/iyoYnOjcy3pBPg/OmQXJTPQOm0nfHZEBZPnp9Lwn0rhXI0MH/HZL6fn+9YhPytYlUAouxFttFpErW10BVxhGRYVdzcTSaDSa6GVzoMeOfbWYu8i1VpS87qzGQFOEKvGeVdU/VUAPun28MjKhfLXVe2eKwbsH1b4333chrTFz/Cdc5HdmS1LcZ9xxntAtqtEC4vlCaugBt7KPcyDlA+nvJhCBl9eCig2D3JuY80cto8fE7cdt/2xbr47gV4Zjxiiy9whLUWMrtkUzSlZYX9ZRuYcjWOrzH9kSO6zMqZKL5TDbBtScTNkFfxtR2oKRvUjEjXK2cu748E7IVvckWSZu66Fbq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e58928-9109-4291-13ae-08dd87968c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 03:24:42.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYTdCcktW+AgHWHDbDGpiouDrR9cXZ7F2vRy61iG9bXRwCwTkRdv2tsBXhU63HGzEnmOMnWaohp4zGm7SOAZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8596

DQoNCk9uIDMwLzA0LzIwMjUgMTA6MTcsIEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+IE9uIFdlZCwg
QXByIDMwLCAyMDI1IGF0IDA5OjI5OjE1QU0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+PiBE
dXJpbmcga2VybmVsIGJvb3RpbmcsIENYTCBkcml2ZXJzIHdpbGwgYXR0ZW1wdCB0byBjb25zdHJ1
Y3QgdGhlIENYTCByZWdpb24NCj4+IGFjY29yZGluZyB0byB0aGUgcHJlLXByb2dyYW1lZChmaXJt
d2FyZSBwcm92aXNpb25pbmcpIEhETSBkZWNvZGVycy4NCj4+DQo+PiBUaGlzIGNvbnN0cnVjdGlv
biBwcm9jZXNzIHdpbGwgZmFpbCBmb3Igc29tZSByZWFzb25zLCBpbiB0aGlzIGNhc2UsIHRoZQ0K
Pj4gdXNlcnNwYWNlIGNsaSBsaWtlIG5kY3RsL2N4bCBjYW5ub3QgZGVzdHJveSBub3IgY3JlYXRl
IHJlZ2lvbnMgdXBvbiB0aGUNCj4+IGV4aXN0aW5nIGRlY29kZXJzLg0KPj4NCj4+IEludHJvdWNl
IGEgbmV3IGZsYWcgQ1hMX0RFQ09ERVJfRl9ORUVEX1JFU0VUIHRlbGwgdGhlIGRyaXZlciB0byBy
ZXNldA0KPj4gdGhlIGRlY29kZXIgZHVyaW5nIGBjeGwgZGVzdHJveS1yZWdpb24gcmVnaW9uTmAs
IHNvIHRoYXQgcmVnaW9uIGNhbiBiZQ0KPj4gY3JlYXRlIGFnYWluIGFmdGVyIHRoYXQuDQo+Pg0K
PiANCj4gTXkgYmVzdCB1bmRlcnN0YW5kaW5nIG9mIHdoeSB0aGlzIGlzIGRpc2FsbG93ZWQgaXMg
dGhhdCBmaXJtd2FyZS9iaW9zDQo+IHByb2dyYW1tZWQgZGVjb2RlcnMgbmVlZCB0byBiZSBsb2Nr
ZWQgYmVjYXVzZSB0aGVyZSBpcyBhbiBhc3N1bXB0aW9uDQo+IHRoYXQgdGhlIHBsYXRmb3JtIHBy
b2dyYW1tZWQgaXQgdGhhdCB3YXkgKmZvciBhIHJlYXNvbiogLSBhbmQgdGhhdA0KPiBjaGFuZ2lu
ZyB0aGUgcHJvZ3JhbW1pbmcgd291bGQgYnJlYWsgaXQgKGNhdXNlIE1DRXMgZm9yIG90aGVyIHJl
YXNvbnMsDQo+IGV0YykuDQoNCg0KSGkgR3JlZ29yeSwNCg0KVGhhbmsgeW91IGZvciB0aGUgZmVl
ZGJhY2suIEJhc2VkIG9uIGN1cnJlbnQgQ1hMIGRyaXZlciBiZWhhdmlvciwgdXNlci1zcGFjZSB0
b29scw0KY2FuIGluZGVlZCByZXByb2dyYW0gZmlybXdhcmUtcHJvdmlzaW9uZWQgSERNIGRlY29k
ZXJzIGluIHByYWN0aWNlLg0KDQpGb3IgZXhhbXBsZSwgYWZ0ZXIgYSBzdWNjZXNzZnVsIGJvb3Qs
IG9uZSBtYXkgZGVzdHJveSB0aGUgYXV0by1jb25zdHJ1Y3RlZCByZWdpb24NCnZpYSBjeGwgZGVz
dHJveS1yZWdpb24gYW5kIGNyZWF0ZSBhIG5ldyBkaWZmZXJlbnQgcmVnaW9uLg0KVGhpcyBpbmRp
Y2F0ZXMgdGhhdCB0aGUga2VybmVsIGRvZXMgbm90IGluaGVyZW50bHkgbG9jayBkb3duIHRoZXNl
IGRlY29kZXJzLg0KDQpBcyBmb3IgdGhlIGxvY2tpbmcgcmF0aW9uYWxlIHlvdSBtZW50aW9uZWQs
IHBsYXRmb3JtIHZlbmRvcnMgbWlnaHQgZW5mb3JjZSB0aGVpciBwb2xpY2llcw0KdGhyb3VnaCBt
ZWNoYW5pc21zIGxpa2UgdGhlICpMb2NrLU9uLUNvbW1pdCogaW4gQ1hMIEhETSBEZWNvZGVyIG4g
Q29udHJvbCBSZWdpc3Rlcg0KDQpXaGlsZSBwbGF0Zm9ybSB2ZW5kb3JzIG1heSBoYXZlIHZhbGlk
IGNvbnNpZGVyYXRpb25zIChhcyB5b3Ugbm90ZWQpLCBmcm9tIGEgZHJpdmVyIGFuZA0KZW5kLXVz
ZXIgcGVyc3BlY3RpdmUsIGRlcGVuZGluZyBzb2xlbHkgb24gZmlybXdhcmUgdXBkYXRlcyB0byBm
aXggdHJhbnNpZW50IGZhaWx1cmVzDQppcyBub3Qgc21vb3RoIHNvbWV0aW1lcyA6KS4NCg0KDQo+
IA0KPiBTbyB0aGUgYXBwcm9wcmlhdGUgc29sdXRpb24gaGVyZSBpcyBmb3IgdGhlIHBsYXRmb3Jt
IHZlbmRvciB0byBmaXggdGhlaXINCj4gZmlybXdhcmUuDQo+IA0KPiBCdXQgSSBhbSBub3QgYSBw
bGF0Zm9ybSBwZW9wbGUgLSBzbyBJIHdpbGwgZGVmZXIgdG8gdGhlbSBvbiB3aGV0aGVyIG15DQo+
IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdC4NCg0KWWVhaCwgaXQncyBzdGlsbCBpbiB0aGUgUkZD
IHN0YWdlLCBsZXQncyBoZWFyIG1vcmUgdm9pY2VzLg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiAN
Cj4gfkdyZWdvcnkNCj4gDQo+IA==
