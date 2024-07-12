Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF338200CD
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763504; cv=fail; b=G6MR2vfiXYPWGfd1d7y7RRLL6xLgiIbnBPbnbAXb/7kL6lsVL7IJfEis83+1ifR9FmCSL+IDYzZJh0vxHsHARPzfRW3nz2ftgc+TNbsnkMp7ppoIQ3ftPErJGb8GSRRKXbUoYPGdWCPzPcP9Nk/1YOxF4iC8pJ1nNo0Ccb9ejHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763504; c=relaxed/simple;
	bh=NkkOx0QpqdiAx3Jl6jLwHOgVZpecymOuVkSvdGexC70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxy8H7gAcu3QDNvs8KTGXGi5C8Mlwj3vYz+xhYZcWcXmSOqWADlGa8sioe/gLTFzVFUCesyw1Dy3dGPPsprnWXTdZFKuKL/l0vLgukmHSGjUL4oXtUNaxdAFX+pzO5Tlgd+FxPf8cQbXVt3I4l1j3l8H1mCszxhYp0UfEQhWItc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ciLtx7qe; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ciLtx7qe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720763501; x=1752299501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NkkOx0QpqdiAx3Jl6jLwHOgVZpecymOuVkSvdGexC70=;
  b=ciLtx7qeDt1gshMpUGpnNYsPa9JkAOsZ707IQpmfdyJ0+mza6/8Gx+sS
   zWpAOq/DzmHreG+/0BkiNTIcyfONLNrvgBR7EEzq+p0rpjtrRowSD6mTm
   csLy4FvknFjT+8UGbtl6kFiCcopkr9rm2bH7he4GDhSjO6WBkVJggr9+i
   R+5CT9308LOSb50m3VoUu58fxzHmh9C2wkyqA51Hv6Fwg4VrZBl1BjZhX
   k08aBA8wnPI1dliTM6TltF6iQfM/YBnpc0LHJxgYVNYtb6Yh7O+PXJTvl
   25tcj6HkSY0gta4dw0R1x8+fKXs5KJCQzY7rKP9EpPwp/OeaM65UC2bju
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="124527324"
X-IronPort-AV: E=Sophos;i="6.09,202,1716217200"; 
   d="scan'208";a="124527324"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 14:51:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5pMwWkjKr9BenGgKGWPjWkm9tT82+Bztae2TOwV5+teQsGdXNgxHFZw45IT7zuN0NsJh943n+avDqQ7aOhK4ti6UhmRWoWV4Zl/6HRsH5mvun67XPdl4FSbAuQm0sBzGBg4Wd8wkN6S2R++3IdTjCXHwHSzBh93ZpuzI++0FvSSL8CZgVwndN3Je3MFclCDlwZwlDjtVp6a05ijkiNIxtL4Aipec0/mi6K395+T74ujOcCJ/6vNahuU3EvTLEbvOfzIHlrCcXRzrnqw3ji6uIfv8sfj7db407ug9NGkCQ0ziQjbeNqsu5XPkg1Jp4wNrFNGsCSiOVGKc9CACyKZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkkOx0QpqdiAx3Jl6jLwHOgVZpecymOuVkSvdGexC70=;
 b=IxhlZL/vpv8wPtXaRHr/MQ5zsQcGcrgAJZbdgx5BVVs9MwGSeaFnj9q8CoTajqcS6VL4LwIedEdmD6YiWS87Qh38jTLIoykfp7u2Ghw5aj+IoqyeVhdx0DKEJNbx0zxjxi35wZ296onn6w4OwlcX3MrPP8uOeu/lRqS4aIzL/rZgeGH+tMuR8UfGP8ajcMh0QmGUgKoLTHxTTCRpL8r65J6E04TWQ3fs36E51+K6zkka4GlUVihjNfUb+WKX5QWc5cow4UCva4cwrR0syTo1sEcCFsX/102R7wbjg4uETf1zqRGlkfOl5mG6Hngcytr201IYTGwUsr6WFXRP6R24yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB11463.jpnprd01.prod.outlook.com (2603:1096:400:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 05:51:27 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 05:51:26 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, Oscar Salvador <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Zi Yan <ziy@nvidia.com>, Johannes Weiner
	<hannes@cmpxchg.org>
Subject: Re: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Topic: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Index: AQHay1WPxUzjMyg7CkuuR0PTwAGqKbHmNSqAgAAIj4CAAEzUAIAL2mOAgABDcwA=
Date: Fri, 12 Jul 2024 05:51:26 +0000
Message-ID: <52161997-15aa-4093-a573-3bfd8da14ff1@fujitsu.com>
References: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
 <5a4ef056-73c7-42e9-a839-43d42f8b7eab@fujitsu.com>
 <95b2bba5-7652-48d8-b6ec-bae7faeed501@redhat.com>
 <TY1PR01MB15629DC0310EB36C655E4465A5DE2@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <da8d72f7-129a-470c-a58e-d1de800ee9da@fujitsu.com>
In-Reply-To: <da8d72f7-129a-470c-a58e-d1de800ee9da@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB11463:EE_
x-ms-office365-filtering-correlation-id: 3e4c1c2b-67a6-4e47-5fc2-08dca236ab64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eER5NUhabklaejROT3ZzTjRGS3JQbGRaZ0hKTllKOXQ1Z3duamsvdC9pUW91?=
 =?utf-8?B?R1YrRkRzWUFqWjAyNm1UbFREbnpuS0NkQTF1WHlDQkhFQ1E2YTcrM1FLSEl2?=
 =?utf-8?B?c2FVbmY3V2R0Ym95Ryt0ZDc3RE9EQnhvWmpuQWE4OElBbTVkYjRwOXJWLzdj?=
 =?utf-8?B?MnFObG91Q084NzNHSUZYa2xXd20zc25HVkVwcVROSjY1NmwzUTlkZ2FHaDBw?=
 =?utf-8?B?enQrRDc5VE02VWwrTkVSK3h0cU5LWTFvTWlZcURWVE9lVzEyQ1BqVTdmYjA5?=
 =?utf-8?B?Mmd5VXhVMXBUT0lFQWkzSllRUkFobkl2dHpvWU85ZFhuRGZlS2NWaFN0aG5S?=
 =?utf-8?B?WlF2aWl0bU1DRjBUMVRNVVFwcThLUlV6UDN6YTlRT3FIbXFQNElvakdQdmFw?=
 =?utf-8?B?WWVKY0g0K1BJUTVaWk1UWWVWRVZYZkFVWDV2bXlvM25BZk4rK1J1anF1dGk1?=
 =?utf-8?B?NnFuOUlhbE9XbWNreWsrY2t0NlR0Unp1UW1PNkJtR0k1Sm9nRW9YZzBDYlp5?=
 =?utf-8?B?cVU4SzQyaS83UFVZdlltS1ljNG82c1lpM2xrbUx0dEsyNngzRnE5SFZMdmlH?=
 =?utf-8?B?UXBlWUVYUjEwUmIvV2FLS25walVzVjJhME04N3AvbXVyV2xHRCtuclJNeVAz?=
 =?utf-8?B?VGR2T3ZjWVg1cG1iU1h0MnhvSWdjQ2VoK2lMVnhGQ0dRNXYvME1iUm9uVlh3?=
 =?utf-8?B?TWhNODUwQk5tTEdXaCtBenhOb1BkMXo0ZHl1QzdRQlpvWE9mNG1obm9EeExZ?=
 =?utf-8?B?RUwrUktyaU5DaVVCVlVVTTNpcEFrV2I4MG8ybENPdkpKSGN5THNKc012bVE5?=
 =?utf-8?B?WG5aK2EyQWFIb3l6VFlvczdCcjJaakM1dVgyaERUVFVPZmdoRTNGdzM3NmRX?=
 =?utf-8?B?NHorM2FrNGRNRU9wYWJUN2ViaFdQaEFpQ1VldjNqc2l6TlhtKzkyVkhDRjZH?=
 =?utf-8?B?bEhVUGI2LzZQbmlRMGt0S2RibFYxMU10UWJucVVST3ZkYU5zazU4UEhrbUhO?=
 =?utf-8?B?dEhPRXc4ZHgzMXdnTGpVVFJJenNleTV3VTNqTGpxdEtOM2pTbDVmZFVjNHBw?=
 =?utf-8?B?UDdiN25vMmJZN09CUER2WE9TYkJYRDh2cDZrdmNZMW9pTUhFaFdGRXBKNzNq?=
 =?utf-8?B?bzArRDZJN3I2QSs4bG1LYjd4cUVPRnkxV3Y2SGFBV2pvUEtYWUV6OGYzOFE3?=
 =?utf-8?B?VjlUcnBxU1c5eC9pei8yMEFXOGxJRHJjemRVdUNCSEhIYWhlK0NSdERWeHc4?=
 =?utf-8?B?emNQYUhFS29LbUQ4Z2RyY2ZqbWRob1NFZ3BFUXlobVNkZHlWbmgyd3c3RnlV?=
 =?utf-8?B?RERSOGdlT3NheHh1TDc3WEJpcHh2aFIwK0hhWTZPeERDZnFudTFNWHJoZHpX?=
 =?utf-8?B?TEduVER6NzRnQzZlcHhYaVdGSXFmcXpHVlpudERGM0RqM3dsZU1WaFIxRS91?=
 =?utf-8?B?K0I3aklkcEcrSUE4S3ZaYmswSnRMMzZBcWNkQlZSeWxST2pZdThoWTRILzli?=
 =?utf-8?B?QjJLTFNnSzVLMXR1WkVzRys4QTB4dnJMalpra1cxWm40S3hBcEtycC95WXFN?=
 =?utf-8?B?UDIrWWdEL1FRa0wwOXFneFkvOHRWa2VHMndkWEQwU2pQNjhYNEF3UHhRbjFB?=
 =?utf-8?B?MzJlNnRZVjlaeWVxOUVFM0c2MHZML3J1bi93MkxHNkE0UW4rb1BENDA4MUNh?=
 =?utf-8?B?NUtmMnBiUXQvTzhrSG95bzQ4UUo3WGsxWVN0WWpRVDFDUXcrdlc4YkFISW5T?=
 =?utf-8?B?RThwenBnNU5namJWL0s0aU4yb1FXclVHcnViZFI3SUY1MWxLZS9oMHVmU2pM?=
 =?utf-8?B?V21oNVFGMDZiRXB4bEFXWk83WlBVTFhRQnpRL0FrS0FHVW4xQU4vYWxJU1ZJ?=
 =?utf-8?B?djFYaDJIL2huTFBEWGVlVXEzeTdaV3l1Tk1VUy9BWXN3cEJNWk9BQTNaWFBE?=
 =?utf-8?Q?jMPW6f9wNco=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0QwT29ldFY3SU1HTUdubytLQVo1WTZJOEowM3JzVFNXYXYvT3p4THBKdSs3?=
 =?utf-8?B?TEM4TXByMzFXSk92ZzlubkJJbXFvSWNYbVh0Qk44Z2ttWklZZE1YK1JNY0hH?=
 =?utf-8?B?dzhBcWtpOG9XSGQzeTVXbkZBV3lSNStadHMvZVhwNWZaby9JLzlaS0RtZUxY?=
 =?utf-8?B?QzR3bE9rT1NhdGF0VFROdkRncGd6MGdhOEx6VEtJbTBUcTdSM1pvVThsdHZs?=
 =?utf-8?B?RUpsTVA4RGlEaU1RbWxQdmY4eEsrcVVCRmZ4eWZWd2Q3UTVQY0U1VmViSm42?=
 =?utf-8?B?NFFyVTJSeW5WUUJqMDV4WTJ4cXRSOWZuZ2Z1NGhQdVIyVThSd0hTTGIvTXB5?=
 =?utf-8?B?S3J4cUIveXZVem5PaFc0Y0N1QXZmbEt5cDg4eG9zOFA2emZySU5xcS9BUEdr?=
 =?utf-8?B?M0Vxcjd4VjludDFQLzRsOVRoV3g5VFVVSHFhVVl1UGFTZERNYnVpZEVCRUw0?=
 =?utf-8?B?SmpuK1hJMzkzdmgveXhsWFNtcTc5V2E0K1hUTGxkQ3BmRTlLU0NIWkVWQzZO?=
 =?utf-8?B?VnI2WDdlM1lrSG4xQTRVcVdjQVI0YkIway9vRVI1L3A1R2g1SGgvM0FJOC9j?=
 =?utf-8?B?b3lXY21hWlNHUGR2Zk81cDFrbDV6TUpOelBmTUhYa3YySnU1eWdta0wrUk1p?=
 =?utf-8?B?MThiSGZESEFhdXVVcCtqL2tsbVF6TTdlY3pIcFUyVWpSNnMvNFU4TkpVNUx5?=
 =?utf-8?B?YWgxZ2hzdTcrVDJOZnRIR20wVFE0VGNuTDRRU0YzZjFzSWxKeG5xbWhMYS85?=
 =?utf-8?B?U2J0WFVrbE0yL05rOEFsUThUeVpaTFd2ZkYrYzNNM0xZNnVrb2tLTU94aWxT?=
 =?utf-8?B?aEtHY3FPM29PWVRLOHhsbTZRcmhBc0VvS2ROK1gzaVVMMnl2YU51Q0F5alkz?=
 =?utf-8?B?enZIZzhjRk5TNHVmbmt1N25xR0lRZldOTEpNa0Z2dTBVcnJTc2Z1cWZkV1Va?=
 =?utf-8?B?OU1PaGJDa2VoSzRPdnBRUXhiVGx5ZjJpcjRZY1Vnb1oyTDJHVVN2WkxNS0t3?=
 =?utf-8?B?aWRkeGhZVk15bFlhS1kyTGsrM0UyOXU1eU9VRG1qY3NkcGh0SHp2Z0FzdFd2?=
 =?utf-8?B?cnI3dVFJL2xoMlZJODBDNk1pYTk1MEtrUXpmaFJ3Y3lUc1hmR3k2LzJGVjBy?=
 =?utf-8?B?VUZ0NWpYVThFR1VYTzlFVEpYRzM0UGJEUUxWMzd2cUdDUVZUeDZQL0VRZnBr?=
 =?utf-8?B?T24wd1djbE1HYnpIZ2hENTZuOWZwVnFFbmVBSC9sQ2JaNGpHVU1WemFYUDU4?=
 =?utf-8?B?Z05uVUVSTGhISUtCeDJQeTA0ZWxFUzY5NGNYOFRmTUpYSmcxeUltaXFBbWxG?=
 =?utf-8?B?b1lhcGRtTHk2VU14d2gyRnpUK0Y3NC93Vm5hQ1NOWkRSZTNlRmx4eGF6V0w0?=
 =?utf-8?B?S2VZMnMwWHhtdVVCRHFraGtmazlUeExJSk9TRUV3djZYMFh0NTA3dTFYdEY3?=
 =?utf-8?B?YmtaZ2lDSW0vMzJKVzc1Q3BESUEzMFdsek1pZU14Q3F5R2lEaWVMQ1lRWThi?=
 =?utf-8?B?VVd3dlFLMURvVE9jWGhVZ2FpTnA1cm9jWk41VzJ6QzRIVVVwYkNHWlF5TzM4?=
 =?utf-8?B?NG9uNnFTSWNmRDZCY3BwcTlhY3QwTGFINDN0VWNyTzgvS3prcUNoRGE2eWtI?=
 =?utf-8?B?TUk4MFQ0Vis1NFZCYm1CY05udnU4b1NTcTRDNjd0ZHdER25yRE41TVNwdFpR?=
 =?utf-8?B?VzBTK0l4L1Q0cWUzL0FsZzFzd2JSVFlvdHNvaG81d2ZKQ0R3QmVDZUNIZk5i?=
 =?utf-8?B?cGQ2aTNBZDNyaXhDS0hTUVhmNjJaMFVyekhhY0R6RWoyOEhpTTlaQmxnSkxV?=
 =?utf-8?B?RktlRjZkeXpRa2ZOMGxLeDZNMThFU0diVVpXOURDKzRrbW5ma0ZDRjZaTzRh?=
 =?utf-8?B?Qldwa281c3QyaGREcEgvdFJ0dGtEbko1ckc2UzVITDlOSWRrd3NkdzIvOTEw?=
 =?utf-8?B?NDN0RndDaUNLZGxnRnk2c1dJeXdpenhtVTVsWk5aOGVzZkIzWllpOWgvdmpV?=
 =?utf-8?B?UEYzRXZBOVFrVW92NnRvK0NpRUtQVm5zc1ZCSkgyYlBXZWZrKy93NzlmWHpJ?=
 =?utf-8?B?NFY0Wm9NZ1hLSkE1d0VRRGU0VDYyL0pkNE1tbUtQOTB5VVorNDlzNHh0VXV5?=
 =?utf-8?B?Y2h3VGx0aG5jUGdZZ2d5a3hTSHQ1c3dpSG8valJkZHl0VXA0dVRTZGRBTExy?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F56687048F87E4449D6FCDAAA9D75AFC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Ij04stzXXGmItd5kY7hWnxK0TGGXKjYk31z3EjUj+FmTYYfFdyufmX56B/UpVNCJEDX286VslV0VLFJHv8Z7VfFGoU6InfckbSIsVxDTpOHXNU9i54PoHnmTSBOtkpQwEnNeaPZAkWAgQ3rRiLM+Azmz1P16AGHAIIC3Ylyf/Ig4CmfWK3ECPxLv5SdJDo2YwL3nC72lWkBOuKrQCHr0NU8J6SvjfjrR5FtMUhFbPKEkBhjIO3OKDCS7/4LGaYn+UXf1/ZKqfgZkLR+gOgjlDpmUbWpkBH/RbxB6JWqzrOx0JITadSMyb+6qCQ/aOUMO4939vUJwIfN7vxVBjJuIvN1+ZBpEZmkME17OA0+1tlMiy8pAjPq0UYZ7hezfVfBg7ZbpPg872nWc6pO9IbJ32IH9CwqNKWkuuX4GciYgvi9RM4ItTey64oP3GvojFBEg2MGpJQszUqPwsCH5hnhaI4CYYRxCPNWBBrrcUOcaaPNE7L8VAqcFi8eHCrVEXLUhlmGLeAH24GHuY51VqRjbcu5wM7qjrRxoom8B6ATWdGnyU75+3lfglXfTq71+vu0vULBN0bGZoPo7L+xeKDs/DoFLkJTsHPhG9P/6cEvUA9ISoYVF14pWxeBegVVGTV+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4c1c2b-67a6-4e47-5fc2-08dca236ab64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 05:51:26.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+YRHVNknZ7F0QAFQKD1dHy9fSt9qRrKl2Iknv4z/g2Ju8iIjPXw9AvLbCq7ZB8Jq8AVkmBRTU/s5e+MDUnEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11463

DQoNCk9uIDEyLzA3LzIwMjQgMDk6NTAsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPiAg
ICAgICAgICAgQ1BVMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxDQo+ICAg
ICAgIC0tLS0tLS0tLS0tICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tDQo+IC8v
IGVyYXNlIHBjcF9saXN0DQo+IHpvbmVfcGNwX2Rpc2FibGUgLy8gcGNwLT5jb3VudCA9IDANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiBscnVfY2FjaGVfZGlhYmxlKCkgICAg
ICAgICAgICAgICAgICAgIF9fcm1xdWV1ZV9wY3BsaXN0KCkgIC8vIHJlLWFkZCBwYWdlcyB0byBw
Y3BfbHNpdA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19ybXF1
ZXVlX3BjcGxpc3QoKSAgLy8gZHJvcCBwYWdlcyBmcm9tIHBjcF9saXN0DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWNheV9wY3BfaGlnaCgpICAgICAvLyBkcm9w
IHBhZ2VzIGZyb20gcGNwX2xpc3QNCj4gbG9vcCAgeyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLi4uDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBfX3JtcXVldWVfcGNwbGlzdCgpICAvLyBkcm9wIHBhZ2VzIGZyb20gcGNwX2xpc3QsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAvLyBpdCB3aWxsIGJlIG9ubHkgY2FsbGVkIGEgZmV3IHRpbWVzIGR1cmluZyB0aGUgbG9vcA0K
PiAgICAgICAgc2Nhbl9tb3ZhYmxlX3BhZ2VzKCkgICAgICAgICAgICAgICAgICAgLi4uDQo+ICAg
ICAgICBtaWdyYXRpb25fcGFnZXMoKSAgICAgICAgICAgICAgICBkZWNheV9wY3BfaGlnaCgpICAg
ICAvLyBkcm9wIHBhZ2VzIGZyb20gcGNwX2xpc3QsIGl0IHdpbGwgYmUgY2FsbGVkIGJ5DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAvLyBhIHdvcmtlciBwZXJpb2RpY2FsbHkgZHVyaW5nIHRoZSBsb29wDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICANCj4gLy8gd2FpdCBwY3BfbGlzdCB0byBiZSBlbXB0eQ0KPiB9
IHdoaWxlICh0ZXN0X3BhZ2VzX2lzb2xhdGVkKCkpDQo+IA0KPiANCj4gQW5kIHdlIG5vdGljZWQg
dGhhdCByZS1hZGQgcGFnZXMgdG8gcGNwX2xpc3QgaW4gJ19fcm1xdWV1ZV9wY3BsaXN0KClgIG9u
bHkgaGFwcGVuIG9uY2UsDQo+IHBjcC0+Y291bnQgY2hhbmdlZCB0byAyMDAgZnJvbSAwIGZvciBl
eGFtcGxlLg0KPiANCj4gVGhlIGxhdGVyIGNhbGxzIHRvIF9fcm1xdWV1ZV9wY3BsaXN0KCkgd2ls
bCBkcm9wIHBjcC0+Y291bnQgYnkgc3RlcCAxIGZvciBlYWNoIGNhbGwsDQo+IEZvciBleGFtcGxl
LCBwY3AtPmNvdW50OiAxOTktPjE5OC0+MTk3LT4xOTYuLi4sDQo+IEhvd2V2ZXIgaXQgc3RvcHMg
Y2FsbGluZyBfX3JtcXVldWVfcGNwbGlzdCBhZnRlciBhIGZldyB0aW1lcyBiZWZvcmUgcGNwLT5j
b3VudCBpcyBkcm9wcGVkIHRvIDAuDQo+IA0KPiBJbiB0aGUgbm9ybWFsL2dvb2QgY2FzZSwgd2Ug
YWxzbyBub3RpY2VkIHRoYXQgX19ybXF1ZXVlX3BjcGxpc3QoKSBkcm9wcGVkIHBjcC0+Y291bnQg
dG8gMC4NCg0KSSBkb3VidCBhbGwgdGhlc2UoYWZ0ZXIgY2FsbGluZyB6b25lX3BjcF9kaXNhYmxl
KCkpDQoNCjEuIF9fcm1xdWV1ZV9wY3BsaXN0KCkgc2hvdWxkIHJlLWFkZCBwYWdlcyB0byBwY3Bf
bGlzdA0KMi4gX19ybXF1ZXVlX3BjcGxpc3QoKSBzaG91bGQgZHJvcCBwY3AtPmNvdW50IHRpbGwg
MCBpZiAxIGlzIHRydWUNCjMuIGRlY2F5X3BjcF9oaWdoKCkgc2hvdWxkIGRyb3AgcGNwLT5jb3Vu
dCB0aWxsIDAsIGl0cyBuYW1lIGFuZCBjb21tZW50cyBkb24ndCBpbmRpY2F0ZSB0aGlzLg==
