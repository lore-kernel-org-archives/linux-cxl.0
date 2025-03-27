Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170E2BAF8;
	Thu, 27 Mar 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743061543; cv=fail; b=b1fwL9lYi/3j5Faf/Qb/vELZJSzds4/i6N7H3TCVzoRNCMn/FVUnBYls/kvNdwB4q8HZjzqo+XcFjIwcL3rNSwohk+EhhGwUXVxtG68JTxKfV4Gs1W2iOe2Ox44//OYghOztI7BFh0juB+FyLEkjzVclvYiD+eZlBFbdrMj7pLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743061543; c=relaxed/simple;
	bh=v99jWpbgHWcdp5PQsmXYM4IiK4h0bgNm09lAXgL8WC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/8Zhz5s8sGP4bQvDXowjpvdG6khiruL0JmL5jeQfjKhaodBUVXemLq2+loaoNeaSznaJYL3NzDZ1JR9627THa0DB7S4AW02A+aIh8RofuOIAz6Vx0fqLSusnM9UWVMzuGK8FtFjuNoT0uoiEPb0ySh81YhVXv6fJlT+T+wDkb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AWQQyY23; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AWQQyY23"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743061542; x=1774597542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v99jWpbgHWcdp5PQsmXYM4IiK4h0bgNm09lAXgL8WC4=;
  b=AWQQyY23cYoMPcCuT45J3vy7AciltmDYT8sseN5zsM883D83N9iK5vlU
   YuMGudePEl2WTsIU5ibo0eAFwJp5LdiE8Ye8KisQQwPHQ9EVyVka48a+t
   P4RyDkyxg1896TvjYU0i2nDYDt2eyV412rJksIsKZJR8IprVjRCrZobGO
   HEoFOhMXSqMa3mJaRrg9kWx28xRWCrLHzbLnCCSyagxNrmSUnLuBoWbrD
   ulRSuWcrjNS4jYOZ8NF2ZkUTjBwn40OssFpckPJTk+1GscB9s+IiwYu+/
   xo5pRfJG5NQOKDeyBj8vcFenbSmV+qlN4RVvjjTvl4I0+Fdnj8TF+hTxi
   g==;
X-CSE-ConnectionGUID: zJNGCEORR86/UCylN6NO6g==
X-CSE-MsgGUID: NDyIFv0EQ52S42pyvcr0Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="157341312"
X-IronPort-AV: E=Sophos;i="6.14,279,1736780400"; 
   d="scan'208";a="157341312"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 16:44:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK0zrqfToszw90Rh3ITSwmYUspZV9SgFPF3/llNWS9bmIQnqjdFzBw/IgBx5NgwqhLO+E5qv/lPi1JZKQtLSMUePbDj9R4G6glZ5XrHNr1Sedje3D4KH/tQmuWZhaiA44dD8yoP30ktJ1Go9zll0apIn3uDHlUKUr3qaIHRlkb+Kjg/l4c4bisEjieORTocbjzwz858fu1mHOkKs1rNE687AZjFZ7JHwlnVo7P8DCm1wm4zfeqGW22Naupt2p9sAS1Mg3fqeeE5M2qZs6puVKNcbVS8Q7ODhG8sVIzOA7lNmZ/U/5WqQqv1ryRKWbjcMARpy1un8aG99eUqzJx2QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v99jWpbgHWcdp5PQsmXYM4IiK4h0bgNm09lAXgL8WC4=;
 b=h0oCzaXsHwJ23ONfE4qjzl7sck0ZH9UemnqtM3pmjgDNl1gDMFatxbBl4srkAAZkPrty+1E8aCaYiLrRgk0ZAftB8123KRlnY07c/3IncMKcvrBgco0VyNclKKshswtiUtcqi5TtjNke2s00mvJG7VnGsE93V/YqwtfPgwQJT4xwqKsqzW7ChJ/R2aEzNvmXa2UBf4OUAkzSUKKvjZGZisAFucv0rC+FQuS1h+NJiwarnggZeYcegFAPUsNZ5JNac6OVKVDmVX3/29dRN10XizGCi7FcdaRf3+grRn1E8MxwKBOagiSPEHlfeA35JTe5NSkDrj26Rm0FihD3TzER6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB12973.jpnprd01.prod.outlook.com (2603:1096:405:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 07:44:24 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 07:44:24 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Ira Weiny <ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Topic: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Index: AQHbniL/JoX3x8SxXU+HvSvJEGqce7OGWN8AgABC9gA=
Date: Thu, 27 Mar 2025 07:44:23 +0000
Message-ID: <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
 <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
In-Reply-To: <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB12973:EE_
x-ms-office365-filtering-correlation-id: f3c8c839-c61f-452e-fa82-08dd6d03316b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFB0NjJlcHZybXF2ZXZjRm1JYVBhZ28rcFFmNW8zL1lRbkdydDF6WkNjV2h2?=
 =?utf-8?B?K0lYWjR5aVI3Tm5USC9uRXN2RDM0QWlJaUEwOXFEUE9FKzU2akdlV2xuOWlp?=
 =?utf-8?B?amJoY21KWkViQlBQaDV1MXN1a0gxSlQvZUtIamJoQzdwMUU0RGpjREp5ME53?=
 =?utf-8?B?Z2RQQXN3bGR1ejBPRFBGbXQzdElueEhnMW91aCs4azlOOXJ0bTc3QWtoU1N0?=
 =?utf-8?B?R0tQY1hPMXNjTlNBYjluL1oveHZGeDRuL1NIekUrZHJiOS8zUG1PMXFhaGxp?=
 =?utf-8?B?S1VLb1hadjNtdys4cGJCZFd1TFFXeUZTYnQ1ZnhoMVIrbWRZaE0rMmtiUGZO?=
 =?utf-8?B?QXI4cDlYblR1TzRiVVJsaUFCZWxjWGYvMEZKcUdBL3VjRWdDVWs0eWkwSmt3?=
 =?utf-8?B?ckRVVkY3TTUxL2RRQWUwc1N0RFY2QWxrZ0ZPVU5yOTRTVWh2K2NGSUZzRWRC?=
 =?utf-8?B?djRRMzdGL3pqQ0gxQlRvaUZoUVQ4eUtKVlJGZnpDN0lNcm5XMENJS0NabUpW?=
 =?utf-8?B?cEl1RzdqTWdsR3NHRlI5MmZMRHFiUjJjVGllUjRPTWQ5V3dITmdXQ3ZENmVZ?=
 =?utf-8?B?RmVsZ1BYeWNkWnIzNHlYeXZCR09BaGwzQjAxMittUER0U25ZditlU3FzK1hX?=
 =?utf-8?B?dllDeDVlbTVkS0h3MkVhV2RYeWdQWHJrVWNsZm1LYmk3WGJSL0c4Mjl4WXhX?=
 =?utf-8?B?TDlUeGhxc0ZFaXlFa0l5S2F6NmNMNWpMZ2Y3T2ZwTFdTT3djaW9rTWhxRlBx?=
 =?utf-8?B?djRkR3JkUTBpcyt5Q2lHSlc0Q2hJNVVvN0lQcjNUWkRteWJCSi9zV2I0cGxl?=
 =?utf-8?B?TVg5THdad3ZVVHBVVFZ4OFkvR3QwNU9vNTMxdmRvRUVSYWh0WUljSnUzbmYw?=
 =?utf-8?B?eDZmY2hXSHdFajlzdjc1MzRwcTdQdGo1aUU0TzhuLzNlUmFwQW1VdUs5Mk1O?=
 =?utf-8?B?SDFYbk5MK2NSZ2h4akMzeXBjSGpWZXFDencwVXhpdk5EZ0wxbWViYjMxanpZ?=
 =?utf-8?B?VWZmZ0JHVzBvZDFRMjB3c3c3YTBvK1hCM3o0REhDS0FrTzlZS29pWDhXVVNx?=
 =?utf-8?B?d24vMGs0NEVkQXFGckZSNFplaFRaRVo0b1FFNXBZYjFKclR5cVpITDZzdWJC?=
 =?utf-8?B?ckpxVTJUWTdFTDRJamtSd0dWQXdmT1hwNnpwWDl5UE1rNHQvdW1BZ1crWjNL?=
 =?utf-8?B?SURGS29pTFdjcnRIUWs2WnJnbFpGOTlGbW5MZjBDT1pLeGpjZU5kRHhuKzZz?=
 =?utf-8?B?UHBOQWFERDlCQWw0THVTMVQ4VnBnL2dpdThBaDBuekxQN1Y3TXEyc3JxUkpj?=
 =?utf-8?B?MGhhNUgwcVpQdFNDYk05RGY3ZUJlSEVJT3JpL2tIaXoreGErY2hxWHBqTFMw?=
 =?utf-8?B?dDAzYldsVXd4S2o5am1rUE1VSFBOVGN6d3FSQ0crOFJmUjJ3a0gxeWZPWnUw?=
 =?utf-8?B?ZStIcG1LSDU0TTh1QlhzaXhlakg2T21sWFVPQjBSSWdJdFBhcGlFb05pb3VX?=
 =?utf-8?B?eUMyMWNOeUFDOU9rWHA1K2NxNGNxV1FsSW1xVXZNdXZXZkJMakpwOU9xclE3?=
 =?utf-8?B?d0Y3cUNzNWlnMXMvOEFrK2JGU2RRdVowRmhzZWlrZlluWGdqTjExWEJKWVBs?=
 =?utf-8?B?ZlIrbXU0QWZjdDQ2YnoyOGUydGMxNElxV2tNNTJ4UEFRMFlBNHRoc01QS1N0?=
 =?utf-8?B?eVY0c0MwL1hCR0gzTUZObGhmaDhwemVZdElheVdxM1VieEdzQ2NMaWNtbnhs?=
 =?utf-8?B?cDZtaUNoTDV0ZXBWY3FpTnNRdzhBaHc5Z3pKVlRzK3phWHNGaGgwOWZvdDBP?=
 =?utf-8?B?YmxzNHdaSWFWRWNTTWwrYlpxQ3dYY1kzd21pSjBDV0kyZHlmY0tDVnBieVhn?=
 =?utf-8?B?NTZCYU9HREtNQXVONmpJZ2JsaDg3dlhFOUF2UmxoQ0x6K25tNFprd1hvbGdF?=
 =?utf-8?B?VTU0UFZOY3J2QTNMRVVUV29vQWFLSGtvTUJvS1YwRzhWZTF4a1NTcXJCdHZJ?=
 =?utf-8?B?TkJickxqa2pGaXBpeE5nUXA3bnlkcnovaUR6UndDQXRvbXhEZXJSN0JwbS9G?=
 =?utf-8?Q?X+D+u7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnE5OXd6OGxBdTAxcEU5TTN6NGVITUtEUzVhN0dqckJxbmUyUkR3eXpwTmlh?=
 =?utf-8?B?NURzS3p5YnBkODdWWkZZNGxsSVNra3hpN014VEFKZGhHTmo5TlZPMlFOVWdH?=
 =?utf-8?B?NDhIN1lEb28rVTlrMGhDZzRSbWJMUHk2TU5tMDlJS0ZHdTBpRVprV0YxZVZw?=
 =?utf-8?B?bUI0a0pzVnF5a3ZTNVZlSUFwQStpZkpCYlQzWWN0YVNvYjh2Wk1jVjRHTEgw?=
 =?utf-8?B?czBnQTFPb3pqdkRxek9RSGZEUzFVZ3hReURjUlpUajVqU3JrbUQ3aCtsZ0lD?=
 =?utf-8?B?VE1VTzREWlk0aGJhaXU4YnJzd1dpc3h2cWxVUndHV1RnampEUkhWVFZ6WTZo?=
 =?utf-8?B?TzdZTHdGeEN5TmI1TVpvczYyOFdsbmNJTkF5SlBmQ1NrMHdHaTNZbEcycmly?=
 =?utf-8?B?b0lpck9aWW01NzNtbWpXTjRDM2ZibFptRkRjaDU2MUFNSkEvdVFUUkZCTWdz?=
 =?utf-8?B?RWtsbVJjY05JeEU2elpFNFhVYnZ5L0dlckJ1TkRxZlZXOWEvZE4zNFVmMlk2?=
 =?utf-8?B?amJubjBZUklFSkNNVmtKQmR1Ky92b1gxSFIyS0RqdzZyV2JEQzNheGROWGRK?=
 =?utf-8?B?UHp3NlU3Z0l2OU12VVF6OEdRanZZa2VuTEptb3c1c2MySmJoQUVjd3dJdXQr?=
 =?utf-8?B?eGpreHlQQ2E2VytpbFh4bElMcFBWemtWV2FEaXF5dlEvcUZGUW1yZWxwb21n?=
 =?utf-8?B?SGYzZnQwM3hiOFFhTFJmb2VuZFpMRWVzOTFHOEdwejB3c0NaRUpuVXorMVZX?=
 =?utf-8?B?YmpkSTBwdnlQMi9rUm9yZEJVd1JzS1VTaGhRSkpyN2lQcEpwRzllZllneUs1?=
 =?utf-8?B?NGt0emF0NHcyUjVQNW90eG00YktFSDNVcDJFa0VkN05RZk9sbWFCelRlaG0w?=
 =?utf-8?B?bDdVcG4zK2VVeHZGNGhCQUc4VFRxUEcvZXdUd1N2Q3hKZnhQL0pFMW1jUDR1?=
 =?utf-8?B?OGpnS2ltcS9ETUcybXZyaFZwaXVDcnJwQTZldUZrdHBoTyt5Mm1TQ3Fna1d2?=
 =?utf-8?B?UlR2N1BEY2xmeXM0Z3lOWnZZQ2ZDSDM3eUhTMVJ2U2hqOU9WT3lweGN0c29o?=
 =?utf-8?B?MGVMWXh0UzdVNUtNOFhTanZpTGllR2hEQ2cwSHh4ZjNiVEJHUGxYRFJQNVUr?=
 =?utf-8?B?bFlVblg5ZmdYLzNxQm9Md3E1U1YzbUhGRG1XS2FuckhuSng4QnVQYzgzbG1D?=
 =?utf-8?B?cUoyMUtWYlhteDlVUXB3d1lDZDdDYjFvUkFzbVhOSjJlckhXazdkM1BPUWpE?=
 =?utf-8?B?ajdpOWRnK3ZUWERaR084cnVGT0VWeTBDckVCYWllZG5oM0JDbXAzU2VqWFZM?=
 =?utf-8?B?cW5SekRrelZXWWlOM1VPVlQ0M09pSWZxL3QxWXZodjZtZHR2RTBldWNEK0ly?=
 =?utf-8?B?R0x3MVJQUXZPVkliZDBkNHZCQkdpUFVyWFg1dlJzVTYvNmpEY2ZiSDBSV1ox?=
 =?utf-8?B?MitxQ05UNktZZWJndjZBK2dyRUZXN2lnSFd0MXZFeHFtazk3L25OOXJ1UHBJ?=
 =?utf-8?B?UEtvUWhqZHJrcjVvbWNCL0xpdmJ4WmdPSlJtRThITzB0S2RoNDhoOFZEaTQ3?=
 =?utf-8?B?ZU9JVVFtNmpQSnVac1AwRk5Hbkx1cVVQb25KRXFGYWJxZ3JDWjA0b3FZdnpz?=
 =?utf-8?B?WTBneUxRTksvekNCTmtVajNNRGtPZjBUR0VKbGNqd08wcG1TeWtpUisySGk4?=
 =?utf-8?B?TElJZ1dHT20xUGgza3E5aUhSc29zWlpmeG9ZUGw3M0tpSUJobS9pd2x2aE54?=
 =?utf-8?B?MC9ORFl0SDc0ZXJ5TlZSYzU2T2NTeWh2MjRGUkZybTY2dXVtanIvbE5vU0dF?=
 =?utf-8?B?eU55ajBIYjNSNXJrdG1LTFdFYmtNUllhN1d0WTVBaTFidjB5Y05FQ2FxajhR?=
 =?utf-8?B?dU5QdzVCbktsUzI3WTRBczVMTHoyRWh4MURkUEJrYWlGbS9HcFN1ejZHVVcx?=
 =?utf-8?B?eDFIWFRoU1FUOWZkVk5INlB3YVFtR3R2NUtmU3dYYUNqczBjMm1qdjVBbU5V?=
 =?utf-8?B?ZjU3N0NTUWtidHRndXN2dkVOVmo1RFhBcXJXWndKMGtzSDNWODlBQVhCQnZX?=
 =?utf-8?B?MlBiMXJ5bURHZHFOSGRhTE1WY1k4ZW5XSkpVNUg1OFRxR01tbDJjZDk2eE1w?=
 =?utf-8?B?ZldPRXZSMXBZUVFCUEl6Y0o5SmdzV2RuSTY4MWxZaHJscWc5bDJ2Y1ErS1dV?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0774151980EC1346BCF32FF9191E294C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qm3K2Iu0etfUu5z+LLp4d2uE1unRnYmApdELRZjKx2UqpvXBHfVtUwqA8ihrc1NudAskBhcdz7gRF6GIeSGoLTcjcVcnG/Z7E8q10+VjeN0gbs9K2HUDK9kukqkOgEdIeKe8ejQ+k/X1yj2agkdRgAImpJj2I5Onl/YKOVhgg5OmxHcdC6fPsLyIplgmPoHiEL6ZSm2NJ3g+27f7DvusOQnyNtZGVxs6j3G8CqXCBJgnOs1fAH/3e6pduNj6jqQwP2riX2hfn8vA/RvXE8ThE5OgWNtUTNvaFToNJpRthxTTjEALrdQ2MviVt8vB7UGveSHTUC6tFaU9wNlRJl3A+3Rtet32n3Yf6ZG3MCOrdLpngoC4tOwIsv8GiHIQGkiAW3eh1z1Bgg2WnwlxVuHLx+ntqa3P59pIYB0/IzQ9ez2aCagW9IClqsW8m7awwtKeOzG1MEND7mDQf6aYe6F/qP/6Te7A11TrDnICqzKT7ciu6gLXChYLSeRQwZaHe6kwBw5oNJ9D3w/3WaPq/nIjIwsxmh8XEKxgcMpHm5zOlRdQlfPI68//dc1MlRojYTX9QFpdUv1ujMQFX/r3cv07lxBKHkcdRCjA7F4U7O03lHWCa94pgaYmD5gmnVjot/hz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c8c839-c61f-452e-fa82-08dd6d03316b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 07:44:23.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5LMg4S+09G8nNbGXrBYH18q+f6RiNSAtGTEoiT4SAoiSAzgTFKRo8X+zKzc3GaX8Au5NcAn93PQKDAhCVpCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12973

DQoNCk9uIDI3LzAzLzIwMjUgMTE6NDQsIElyYSBXZWlueSB3cm90ZToNCj4gTGkgWmhpamlhbiB3
cm90ZToNCj4+IFBlciBDWEwgU3BlYyByMy4xIFRhYmxlIDktMjEsIGJvdGggQ1hMMS4xIGFuZCBD
WEwyLjAgaGF2ZSBkZWZpbmVkIHRoZWlyDQo+PiBvd24gbGVuZ3RoLCB2ZXJpZnkgaXQgdG8gYXZv
aWQgYW4gaW52YWxpZCBDSEJTDQo+IA0KPiANCj4gSSB0aGluayB0aGlzIGxvb2tzIGZpbmUuICBC
dXQgZGlkIGEgcGxhdGZvcm0gaGF2ZSBpc3N1ZXMgd2l0aCB0aGlzPyAgDQoNCk5vdCByZWFsbHks
IGFjdHVhbGx5LCBJIGRpc2NvdmVyZWQgaXQgd2hpbGUgcmV2aWV3aW5nIHRoZSBjb2RlIGFuZA0K
Q1hMIHNwZWNpZmljYXRpb24uDQoNCkN1cnJlbnRseSwgdGhpcyBpc3N1ZSBhcmlzZXMgb25seSB3
aGVuIEkgaW5qZWN0IGFuIGluY29ycmVjdCBsZW5ndGgNCnZpYSBRRU1VIGVudmlyb25tZW50LiBP
dXIgaGFyZHdhcmUgZG9lcyBub3QgZXhwZXJpZW5jZSB0aGlzIHByb2JsZW0uDQoNCg0KPiBEb2Vz
IHRoaXMgbmVlZCB0byBiZSBiYWNrcG9ydGVkPw0KSSByZW1haW4gbmV1dHJhbCA6KQ0KDQpUaGFu
a3MNCg0KDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5j
b20+DQo+IA0KPiBbc25pcF0=
