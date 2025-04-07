Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB451448D5
	for <linux-cxl@vger.kernel.org>; Mon,  7 Apr 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014755; cv=fail; b=gfQYoih0fqBObpZJqCrd5IkCCxzAFqnwrWn9vCeRrpsTL+Q1dlZEaDPuZpHX7b17qd29Y176FKNttKcdaaNkuXI9kaLz9qbNxODYBSMTVwIDlxOLGVO9rbFvlwWg/ao/SlA1sJjQU5rKAKrZENnfcgqUkXcP9lZFTXTs6r+Y6gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014755; c=relaxed/simple;
	bh=QocxiXslJjmjmDhSWsgMeONsWb4yfog2RtJH7v5jQq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYUD9UnWzDe/dzzG8q8N3tREZfY40/cIPdNOj5t/5EOBiNdHKHXzUT945a0Fnbx/V7+u+0pfcdEtZ3bPYqcywBevGfx8ErD8KYiH26anuxqoSJ6Z3aZa/Jp6lafqWxfL8oeDsYWGFTLoM9Szg4jEgvJXHkVQOhZuCiD8nZV3N2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vEau/QLc; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vEau/QLc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744014752; x=1775550752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QocxiXslJjmjmDhSWsgMeONsWb4yfog2RtJH7v5jQq4=;
  b=vEau/QLcF4+luk2sht5FSDR/wHE0jj1lDJfjF26G1tOi+PQQhEhW+ipN
   GmblUv6qjQSqH37Xbu9Sw/BxYHls6HvEj6qltKHltXl+sSpCMabR5vaF+
   eJcaBe4aI9IWzEznHsCr/NzD0pBUwTvLGdpV7XidmstmvsNML73eci/EO
   8kNrfd8jiSuRwk6x7asIutl4pF1ZwwD5wC2pIF9UZZpdYMtFgpCtLzAW6
   DCHJydOgUl1ft6DIXHQDJZqr1j2jrugzNxptX5sFIy5Nz9lsV7+VnFLOw
   pIGOqGAObRDNFx0y6oEzsLqXvicdf/5MWASFXF+RHyS56CVFx9FBj+NmK
   A==;
X-CSE-ConnectionGUID: VjU1jAuCRFGzQu6MQKFjug==
X-CSE-MsgGUID: 2gKQvnhaQFyB+5DoXtWOUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="152879347"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="152879347"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:31:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPOxrrvAK0sAsRdprZtdAS7g644J1O/zY34YfY5YxHpQqnRezcRHHvk9DBaQWky9hxTgkUhnugd9xMpbwX8zEt3QFo49fHZkNTmNjEbWtAmE+1WtdHvvFgtH9PnXkjBNCMLZ+hqbSl4g6LXW5PGTpV+r/Nxaejzc5CAlRdg7WOm6jRep/9xsJHLobM29DODIq8ipCTP1PAc8YsxSmwTYRbDO1dAO8cG7HowExcJFUFrHFOs7t821puO9+8w5Ptyon9VTaVU6AHalBJ2EFeYfVr0/9BRyxRBjKbDfiLES8s2AdkWJukn+8D9ezeXOOEOjpbq6QM54MkFhaZZAH/WaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QocxiXslJjmjmDhSWsgMeONsWb4yfog2RtJH7v5jQq4=;
 b=oD0S8Rh5bnSHP5zfmqBR8Clgm+lI9ljqNIp8C4zrkyKQHn5DcBQWkdIkcSWIV6KRW1Q0A9ZbTF3D2JuCkf1EvqIpB5oPIeepS8wb/5IsmGhRzisrAYEXsVjHNvcxyLTKA9a9+k94VJnDDsUXACSXrBgzBLrGd9lEvMpxDs4/o10MMswH/SmqcZeDj4yykW4n2AP11vdxIC0NuGbEwK1KiNeXuA4gpt/Pf06+qVFy262iBLregU2zuJ3bGOMFiM8VaLqtGmMPUxaP5GMA5TawLi5s758yCGcPyTmdZiq+ExHRZ03zRgscq1uJURyA2bH1YS3YiKDIOlDsO+e8o+5oMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB15060.jpnprd01.prod.outlook.com (2603:1096:405:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 08:31:13 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 08:31:13 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Huaisheng Ye <huaisheng.ye@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>
CC: "pei.p.jia@intel.com" <pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Thread-Topic: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Thread-Index: AQHbpubsUfMWCnMsukmC6md5obf8gbOX4QgA
Date: Mon, 7 Apr 2025 08:31:13 +0000
Message-ID: <02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
In-Reply-To: <20250406112752.1261855-1-huaisheng.ye@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB15060:EE_
x-ms-office365-filtering-correlation-id: c5e7bc98-8447-4e18-f5ad-08dd75ae8e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm50OEQ2aU0ycFZxdGoxMjEzWEFnMFZkSS96cjBCd1plcDBnUWE4ZjdXWDJN?=
 =?utf-8?B?VFNDNFRIYS9EazRWb283eklscmUwTy9pTDJONk5yNkxiR3ZhNkJFTHNBd1pC?=
 =?utf-8?B?U2FPSnphNGliRmxCOEcrbVQvZWVnS1VsWEtlRlplK1JnUG9UeFpncElYai9K?=
 =?utf-8?B?VElzNENFVEkwWXAwMVNmQVM3bjdHaEd5MHp2T0ppWlFvbnM1K2xXQ1FaL2dM?=
 =?utf-8?B?clpqNlR3OGlGQVdTSUM4K3llSGpyZG5XOGtjVFpSNk9BRWlSZXpwTUZlSFMx?=
 =?utf-8?B?QWlJQ3dJV0pQM25KS0VWZEJkSnMySUIyTlFEaU9VTmNrTmcrMTRZRXcxdUs4?=
 =?utf-8?B?Ni96eWJ2WHo0WDJQSnpiZEw1N1d4U25kQjI2TnNXUThNdWhGaDZGa2xHamNL?=
 =?utf-8?B?WnpTT0R6cjArUHVHZmhGaFpOcUdTcm9rSWlMRmYrcTlVblliay9icXl1bjU2?=
 =?utf-8?B?dlZxNkFHbEFHei94MDMrSDMzb2FEQjZnYkxuOWNKTDBrUjJjOTdlSmh3QmVI?=
 =?utf-8?B?akxkTGpqUmx1QlVzQUptQU9qNjVGS1hnYlpvSlppczR0UGtEczI0czhIMnAr?=
 =?utf-8?B?UjBHdE9zM2VjWFdwa0UzRXBvUnRXSDFTQUx1YlNoTHdDSTJPRlp4Z2dHSnJY?=
 =?utf-8?B?R3NFRUVUQVZxVjVzcjBONmp2T1dUbGdPNTF2T2NFL2wxYW82TlhaZUdvbDNG?=
 =?utf-8?B?WFJ2TzBSNUFwQ3hTR0ZaNWVUVlJXNDJrSGlFRkkxdUd1WHVmVHAwdEJuY2RS?=
 =?utf-8?B?VXI0d0s2NnFTajRuNjlsSUlkYlpOb09YVUs2VW5nMXB6Rk1DU3Z5enVZOEov?=
 =?utf-8?B?VDdlbmVHV3RaUnJwUjJNeWtNUDd5TFNZWGZ0Qi9xVUZlbjRZcXIxbDdRZHFB?=
 =?utf-8?B?Ujd0bkQ1SkZKV1RWQkNjdWdya3dYM3hPVFREeGhCemhKY3E3bDl3bGVqOVo0?=
 =?utf-8?B?VkpZbmk0ZWExaGhkMXNyaTJLZzFCeEYyVjAzM21OaFdGNXo3NktJWFNSOVpZ?=
 =?utf-8?B?dGRQMlNZTmZHT0poZzJqQ29MUHo1QTB4U2NiRzUwWGtSMWN1RzczWWVoUXNY?=
 =?utf-8?B?VFR1a2YxRGhjMTlPbVNlMnpvS3VrVGhha25NOUE1L0R0andIdXc1SW5hakU2?=
 =?utf-8?B?WXlYVWpCNXp1YTJhOTRBbXUvMmI4ZWlPdDJoQnZsVVhVNlR0aHZ6bDBybWJ1?=
 =?utf-8?B?RUV2TkZBNE9rOHVxcG1uYXgwdU9WRitrVnc1ZzM4bGo4VXYrK2o4ZjZWdXdm?=
 =?utf-8?B?c0RCSXhidmJyc0g1Z2JSZXhQWlV0Q2RyNTljMmhDREVyVjd5TkdwalAxcGhW?=
 =?utf-8?B?dyt2NUJXdXE2ek1Gckh5bXdNSmU5Si83anpoN2FJT0ZFWXFJUjZDVUNtSWhl?=
 =?utf-8?B?K0JtRWhDdEsvUkhUWUZSODNXUVMxWHAxRStvWWovWWpDbHc0TW9yNisxQWxx?=
 =?utf-8?B?T015cThjbkVSNTBQVW9rZW1TQkRxUzZodk9uM0tlK3RUWjVTQ05NUjVpdW9R?=
 =?utf-8?B?YWdja0xINEIrckpoZHJ6YVd3NUp6Mk1FVmtoVHZuNnl4QVFNbGxuYWl2VFU4?=
 =?utf-8?B?dUdqQUxKRWNQQm1pc2pZL1BOUG55aG9Tdy9kcVR5eWd2bGJXNDBhMFZaWFlG?=
 =?utf-8?B?RlZucHpVVzlKMzRRVEFQZExkZERKU3NNMFdkbzFKanBXRTdGREMwdWZySVRw?=
 =?utf-8?B?Q3lMczRDclJzeTRjQzJpQi9HZkhhN1hnRzlYVW1ndDZsYzRBSkd1ODZKN0E4?=
 =?utf-8?B?NW1TVmhKSkdrZWU2NHVkRjZQS0FWQzJDVnRHLzMrQ1dYanZJSFMyRC9LMkg4?=
 =?utf-8?B?QlZzWkR1a2s2NmhFVUErTllrNTdXNUhVVmJkWmV3VXhOZWkxQjRjMlRPRmJa?=
 =?utf-8?B?WmNyY0w5WXBVVkVVSHZaVWFHSW1XcXMrKzVKb1NNZTJRZHRyallEVHJaT3VR?=
 =?utf-8?B?KzVhZ1NNa2Nkbmo2eis5ajdxdzdheTkrcU9BelpXYzFDa1RYME1ueHJrZWdH?=
 =?utf-8?B?dWU0cDY1MzFJdnNTeThaYlV6RzFwbVZ5Ky9CbFRjVTQxblV5eGZZdWZlek5z?=
 =?utf-8?Q?SbbMW0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TCt2WG8vYWRDVUFUSitSQ21FWGRtank3TlNBN0h6WDNxT2M4S2dmM1hpbzB5?=
 =?utf-8?B?WWhDQWtZUnVtSFF5UmxwNFlSa0M3ZmU0WmpFMlA3bnF5MHFjYklmZStyQ212?=
 =?utf-8?B?dTV2cmJNU0dKMnlZMjkxVm9wazNFUUh0U2tvY2d6djJLZlFTc1R2OElpUmpG?=
 =?utf-8?B?Z041VFdSSWp2c1JpLzZ3UmVNTFE3dEJ1eXZNL21lS3dZUUhicWNhTDN2K3JL?=
 =?utf-8?B?RndpY1BONWo4U3UvcVpqcGhoVGdEOXlqWnZQeld0U3dTaU5ob2gyZnN2LzVS?=
 =?utf-8?B?MHVKZkIxUEdiKy94QXZCdGRtRTZjNGowaXNWeUM1ZFhZM3l3N2ZpdmY5Y2hT?=
 =?utf-8?B?TVMydko3YmJqWS94NU9LbjBrdmxpbjdrdmdkc1pGdmFUUmJmMmJYQWdZR2lq?=
 =?utf-8?B?M1lHQm9vVkZkdVowaDZPTGQzQm1JL2RkbGd5ZXZtSkIxZVFMbjF2MnZIbkhz?=
 =?utf-8?B?djM4eGljNCtXRnNyOEMwcERvY1B6bVZrb0RncXJEbmNLTHl4dGtVNzJKUFpS?=
 =?utf-8?B?WWMyY2M0YnBuckdFdi9GOVpybXJsTm42Z3luY1g2R0IzNzIrNVBVRFhUTDg1?=
 =?utf-8?B?VDl5THBQV1JhTWZoU1JqaGcrbFlZNTNHRURZUDE5ejNXYStCZ3RONkJwdVZE?=
 =?utf-8?B?cnJlTVRxb3dUSGNrZGphVHZhMG5EV05EeGs0N1BPRk9oVFBqNndHT2g0bTFX?=
 =?utf-8?B?YTZuMFk2U2M5cEs5dU8yZzJrWFJaZ0JzODJCOHNNdW9nREVTVzZXSVNPbW9S?=
 =?utf-8?B?WElGN2FFWlF6UXRoTWJWeHd3UTZiNm84KzVQUFFsbXB2a0tlTE9KN1Nyb3Zx?=
 =?utf-8?B?RmhZREJZWDlBT0Nka085dVF6Ny90dXhOdjNHVk5oaGFYeVYydmpodlA2M09C?=
 =?utf-8?B?M1E3R1hHNFRXbU1oczJXU1RQTHlvUk50dlB6N3FaRlVsVW5lMEhLR3U4VTV6?=
 =?utf-8?B?VWN3aTQ5L1dMU1JKcHROc2swaC9xcEdUZkNnelRacWgrdklkUmtod1JoVVdo?=
 =?utf-8?B?OTRZZ25xQ3dhTlo5UVZ6SXl0c2RrQXkwajBZSEs5anNBdm53MUhjdjdjZ3ZQ?=
 =?utf-8?B?VlI2RUN0VDBDenQ1d1BJY29GSmJIRldqNW1QR0lHd2czNDRwdHJVMFR5VENs?=
 =?utf-8?B?UzNBTzE1UXViaDd4VGZNbTBJMnZsbjJXZ09Rd0M0UTVmdHBSUVJpVUJsa29W?=
 =?utf-8?B?VFF5R2g0c2ZvMFY2eGowSDZ3RDZoOHhycVdCQmlPTmRMQXVhdmJnZnpaTC9r?=
 =?utf-8?B?NnE3WmpZT1BUeWhIWHV1L0pOWWlxcjJPNElNTTV1SFFtR3dOWEVXUGZpbTR1?=
 =?utf-8?B?Q3E3cnFyNWt6dFViQ3dTa0d2Q0lwZXoxYWhLR01RMUFNRFJsR2VGNTdJWVpx?=
 =?utf-8?B?RWI3MUl2VWNCZ1FsWTA0eWR4Z3lMYWJOTURGUGVFa1UwMzl0VU9EUVlUQzZy?=
 =?utf-8?B?TjlKbkd1VTBxZXV0cmY5SmpPTXV2b0dhS25rRzJRbndYNEdaVEFLWFpSd2Zq?=
 =?utf-8?B?VzE3TlcwY2tzbUlxNGRJS2MxNHZ3NDNuc1NYVHdhTUN2NEpLOWp0TFpkTjhj?=
 =?utf-8?B?OVE2NUxXU0lNbkF5eTNHNVIzU0ZHT3JoeTBBSTNsOU1JWHF2ZmZqcGE2YTI4?=
 =?utf-8?B?MWxnMVEwSmZ2VUxBNnVjRzJBaUFNaWlHcjB5MnpLWWxRY0hKVXZXVHlEaEhD?=
 =?utf-8?B?cUxRNUZ2b0dhOUw3bnhyTmtON2RvWnZ6dHBZdE1pb2p4L1VSY0l1VUkzWjVt?=
 =?utf-8?B?b2VFT0N4bjJZcUVzMGxFV1ZFVDF2cmVDdXp3NFBUbTlZTmxxSXVIOXRQcFdv?=
 =?utf-8?B?b0FYS2ZlcVNEdVNoMDNwc3BWdUhRbmxZRFFsVGZxSWh3U2IvVm5XVTI3VGpy?=
 =?utf-8?B?TzVYN213SEdVSFZGNFFqZzh5RWFNcm5WbURQb1pIeTVvV20wckZZcEtDSDhD?=
 =?utf-8?B?SFVqZUtKWGdKNXJSU1dhdkQ0UEhGMWpWNGgyZkZleXc4elV5a2lHbzBkSHpv?=
 =?utf-8?B?YzBST3lsNi9HMjhRYllOTWVvT1ZkNFNNb2NYdkNDa2tQbHpWUHhCdFhtaHNJ?=
 =?utf-8?B?T2JHNlIwRlZBNnp6ZWUxeWUyc0xKdWtLK2hNME00d3RHSHZ2ZEJmZDNDYmw2?=
 =?utf-8?B?Q1VTa0Q4WUFxcGgxTWx5TWVJbUthb0ZHUDVyNEE3cjFGS21Jc1BXWVNVUmU3?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A325BD6C58CE3643A59EA2D876CE8082@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YgBnYMGIb6Mt5dVCqFLd7r/2xrHBf3rgd54rRVHp5hBjgGY1rDKCQnMgvbVC/N/2jTY8WsJWu0HHiAlHfQsfH4odt4vW0yC43Ct5Efd1GiGKyY3uUUJEPPE8J9PcDhYX+76zDgS8sy7SotI8/rfiFIcNt1UC43LHRzAMuzUd4uOYY8M4YWDE8Yt39Fy0gXGkXDKB4B/Ug+SKgpi6VO5YMFX3Gpu6drWHtyEFA+ql+U/rgUB8kbkv+WencSwHEQtbXV21G8wiZPa+mhFV3f7RPknJoUP4m46uY9U45eEYfQ22ApicdgAx1HI7cUSUu+Pe/L52cha6J9WxEnGotRp6VhCQh32B4Sn9kF7Hd/8ZL8tDHSLJ0GmeoG0TL/OahS1e29SHC4jQL++c5c6uXxM62s9NeE1yRGZ9XwmCb1Bl4dI3en9HOqRU7ZtB2UL6QO3tbNFASMxp2Rz0jNusfn4OtFz7yh3pTxDhBUncVnnRhKIwhdtVOaLhAaUo2c88L+7PFkJfoXud2yQcBzWFFxy7EPyH5FZCGBJ+qBt015yvHTrwl9qAEMxKoqWcNEFjNLZOt1obVs7XpvF4fBP2fBkwx2EXlnUgpgs9/kG7UikcbBEhMktD4jAgLYavKm7rO3z5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e7bc98-8447-4e18-f5ad-08dd75ae8e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 08:31:13.3377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPSX3dTqMaa0/YglnwVkrh1vB2+R7v5gYBOufhj/4CzTsRwROEOidrU4jOzLn0rsEkes84EpxAxWUnilZ3ArXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15060

DQoNCk9uIDA2LzA0LzIwMjUgMTk6MjcsIEh1YWlzaGVuZyBZZSB3cm90ZToNCj4gSW4gc29tZSBz
Y2VuYXJpb3MsIHRoZSBwcm9iZSBvZiBlbmRwb2ludCBwb3J0cyB3b3VsZCBmYWlsIGJlY2F1c2Ug
b2YgcmFuZ2UNCj4gcmVnaXN0ZXIgKFJSKSBkZWNvZGVzIG91dHNpZGUgcGxhdGZvcm0gZGVmaW5l
ZCBDWEwgcmFuZ2VzLg0KPiANCj4gICAgW2tlcm5lbCBkZWJ1ZyBtZXNzYWdlXQ0KPiAgICBjeGxf
aGRtX2RlY29kZV9pbml0OjQ0NzogY3hsX3BjaSAwMDAwOjEwOjAwLjA6IERWU0VDIFJhbmdlMCBk
ZW5pZWQgYnkNCj4gICAgcGxhdGZvcm0NCj4gICAgY3hsX3BjaSAwMDAwOjEwOjAwLjA6IFJhbmdl
IHJlZ2lzdGVyIGRlY29kZXMgb3V0c2lkZSBwbGF0Zm9ybSBkZWZpbmVkIENYTA0KPiAgICByYW5n
ZXMuDQo+ICAgIGN4bF9idXNfcHJvYmU6MjA3MzogY3hsX3BvcnQgZW5kcG9pbnQzOiBwcm9iZTog
LTYNCj4gICAgY2FsbF9kcml2ZXJfcHJvYmU6NTkwOiBjeGxfcG9ydCBlbmRwb2ludDM6IHByb2Jl
IHdpdGggZHJpdmVyIGN4bF9wb3J0DQo+ICAgIHJlamVjdHMgbWF0Y2ggLTYNCj4gDQo+IFRoaXMg
ZGVmZWN0IGNvdWxkIGJlIGZvdW5kIHdpdGggUWVtdSBDWEwgYnJhbmNoIGZvciBhIGxvbmcgd2hp
bGUgd2l0aCBhDQo+IHNwZWNpZmllZCBwcm9iYWJpbGl0eSwgZXZlbiB3aXRoIHRoZSBsYXRlc3Qg
YnJhbmNoIGN4bC0yMDI1LTAzLTIwLg0KDQpZZWFoLCBJSVJDLCB0aGUgbWVtZGV2IGNhbm5vdCBi
ZSBlbmFibGVkIGFnYWluIGFmdGVyIHRoZSBndWVzdCByZWJvb3QuDQpQcmV2aW91c2x5LCBJIGhh
dmUgdG8gYXBwbHkgdGhpcyBwYXRjaFsxXSB0byBteSBsb2NhbCBRRU1VIHRvIHdvcmthcm91bmQg
aXQuDQoNCg0KDQo+IA0KPiBUaGUgcm9vdCBjYXVzZSBvZiB0aGlzIGRlZmVjdCBjb21lcyBmcm9t
IHRoYXQsIGJpdCBDWExfRFZTRUNfTUVNX0VOQUJMRSBvZg0KPiBEVlNFQyBjb250cm9sIGhhcyBi
ZWVuIHNldCBidXQgaW4gY3hsX2hkbV9kZWNvZGVfaW5pdA0KPiBDWExfSERNX0RFQ09ERVJfRU5B
QkxFIGhhcyBOT1QgYmVlbiBzZXQgYW5kIGFsc28gZW5kcG9pbnQncyBkdnNlY19yYW5nZSBpcw0K
PiBub3QgY292ZXJlZCBieSByb290IGRlY29kZXIncyBocGFfcmFuZ2UuDQo+IA0KPiBXaGVuIGVu
Y291bnRlcmluZyBzaW1pbGFyIHByb2JsZW1zIG9mIHRoZSBmaXJtd2FyZSwgdGhlIHBhdGNoIGNv
dWxkIGJlDQo+IGVmZmVjdGl2ZSBmb3Igc29sdmluZy4NCj4gSW5zdGVhZCBvZiBSZXR1cm4gZXJy
b3Igd2hlbiBSUiBkZWNvZGVzIG91dHNpZGUgcGxhdGZvcm0gY3hsIHJhbmdlcywNCj4gZHJpdmVy
IGRpc2FibGUgTWVtX0VuYWJsZSBiaXQgb2YgRFZTRUMgY29udHJvbCB0aGVuIHRha2UgaXQgYXMg
dGhlIHdheSBvZg0KPiBubyBzZXR0aW5nIGluZm8tPm1lbV9lbmFibGVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSHVhaXNoZW5nIFllIDxodWFpc2hlbmcueWVAaW50ZWwuY29tPg0KDQpUaGFua3Mg
Zm9yIHRoZSBmaXguIEl0IHdvcmtzIGZvciBtZShhZnRlciByZXZlcnQgWzFdKQ0KDQpUZXN0ZWQt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQpbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtY3hsLzIwMjQwNDA5MDc1ODQ2Ljg1MzcwLTEtbGl6aGlqaWFu
QGZ1aml0c3UuY29tLw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvaGRtLmMgfCAgMiAr
LQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvcGNpLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvY3hsL2N4bG1lbS5oICAgfCAgMiArKw0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9oZG0uYyBiL2RyaXZlcnMvY3hsL2NvcmUvaGRt
LmMNCj4gaW5kZXggNTBlNmE0NWIzMGJhLi5iNzc2ZmI4NDhmNDIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvY3hsL2NvcmUvaGRtLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9oZG0uYw0KPiBA
QCAtODAsNyArODAsNyBAQCBzdGF0aWMgdm9pZCBwYXJzZV9oZG1fZGVjb2Rlcl9jYXBzKHN0cnVj
dCBjeGxfaGRtICpjeGxoZG0pDQo+ICAgCXUzMiBoZG1fY2FwOw0KPiAgIA0KPiAgIAloZG1fY2Fw
ID0gcmVhZGwoY3hsaGRtLT5yZWdzLmhkbV9kZWNvZGVyICsgQ1hMX0hETV9ERUNPREVSX0NBUF9P
RkZTRVQpOw0KPiAtCWN4bGhkbS0+ZGVjb2Rlcl9jb3VudCA9IGN4bF9oZG1fZGVjb2Rlcl9jb3Vu
dChoZG1fY2FwKTsNCj4gKwljeGxoZG0tPmRlY29kZXJfY291bnRfY2FwID0gY3hsaGRtLT5kZWNv
ZGVyX2NvdW50ID0gY3hsX2hkbV9kZWNvZGVyX2NvdW50KGhkbV9jYXApOw0KPiAgIAljeGxoZG0t
PnRhcmdldF9jb3VudCA9DQo+ICAgCQlGSUVMRF9HRVQoQ1hMX0hETV9ERUNPREVSX1RBUkdFVF9D
T1VOVF9NQVNLLCBoZG1fY2FwKTsNCj4gICAJaWYgKEZJRUxEX0dFVChDWExfSERNX0RFQ09ERVJf
SU5URVJMRUFWRV8xMV84LCBoZG1fY2FwKSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2Nv
cmUvcGNpLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+IGluZGV4IDAxM2I4NjliNjZjYi4u
NTQ1MmJiMjg1MTQwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+ICsr
KyBiL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4gQEAgLTQwMyw3ICs0MDMsNyBAQCBpbnQgY3hs
X2hkbV9kZWNvZGVfaW5pdChzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMsIHN0cnVjdCBjeGxf
aGRtICpjeGxoZG0sDQo+ICAgCXN0cnVjdCBjeGxfcG9ydCAqcG9ydCA9IGN4bGhkbS0+cG9ydDsN
Cj4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gY3hsZHMtPmRldjsNCj4gICAJc3RydWN0IGN4bF9w
b3J0ICpyb290Ow0KPiAtCWludCBpLCByYywgYWxsb3dlZDsNCj4gKwlpbnQgaSwgcmMsIGFsbG93
ZWQgPSAwOw0KPiAgIAl1MzIgZ2xvYmFsX2N0cmwgPSAwOw0KPiAgIA0KPiAgIAlpZiAoaGRtKQ0K
PiBAQCAtNDI2LDE1ICs0MjYsNyBAQCBpbnQgY3hsX2hkbV9kZWNvZGVfaW5pdChzdHJ1Y3QgY3hs
X2Rldl9zdGF0ZSAqY3hsZHMsIHN0cnVjdCBjeGxfaGRtICpjeGxoZG0sDQo+ICAgCQlyZXR1cm4g
LUVOT0RFVjsNCj4gICAJfQ0KPiAgIA0KPiAtCWlmICghaW5mby0+bWVtX2VuYWJsZWQpIHsNCj4g
LQkJcmMgPSBkZXZtX2N4bF9lbmFibGVfaGRtKCZwb3J0LT5kZXYsIGN4bGhkbSk7DQo+IC0JCWlm
IChyYykNCj4gLQkJCXJldHVybiByYzsNCj4gLQ0KPiAtCQlyZXR1cm4gZGV2bV9jeGxfZW5hYmxl
X21lbSgmcG9ydC0+ZGV2LCBjeGxkcyk7DQo+IC0JfQ0KPiAtDQo+IC0JZm9yIChpID0gMCwgYWxs
b3dlZCA9IDA7IGkgPCBpbmZvLT5yYW5nZXM7IGkrKykgew0KPiArCWZvciAoaSA9IDA7IGkgPCBp
bmZvLT5yYW5nZXM7IGkrKykgew0KPiAgIAkJc3RydWN0IGRldmljZSAqY3hsZF9kZXY7DQo+ICAg
DQo+ICAgCQljeGxkX2RldiA9IGRldmljZV9maW5kX2NoaWxkKCZyb290LT5kZXYsICZpbmZvLT5k
dnNlY19yYW5nZVtpXSwNCj4gQEAgLTQ0OCw2ICs0NDAsMjkgQEAgaW50IGN4bF9oZG1fZGVjb2Rl
X2luaXQoc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzLCBzdHJ1Y3QgY3hsX2hkbSAqY3hsaGRt
LA0KPiAgIAkJYWxsb3dlZCsrOw0KPiAgIAl9DQo+ICAgDQo+ICsJaWYgKGluZm8tPm1lbV9lbmFi
bGVkICYmICFhbGxvd2VkKSB7DQo+ICsJCWRldl93YXJuKGRldiwgIlJSIGRlY29kZXMgb3V0c2lk
ZSByYW5nZXMsIGhhdmUgYSB0cnkgYnkgZGlzYWJsaW5nIE1lbV9FbmFibGUgYml0LlxuIik7DQo+
ICsNCj4gKwkJLyoNCj4gKwkJICogSW5zdGVhZCBvZiBSZXR1cm4gZXJyb3Igd2hlbiBSUiBkZWNv
ZGVzIG91dHNpZGUgcGxhdGZvcm0gcmFuZ2VzLCByZWVuYWJsZQ0KPiArCQkgKiBNZW1fRW5hYmxl
IGJpdCBvZiBEVlNFQyBjb250cm9sIGZvciBhIHRyeS4NCj4gKwkJICovDQo+ICsJCXJjID0gY3hs
X3NldF9tZW1fZW5hYmxlKGN4bGRzLCAwKTsNCj4gKwkJaWYgKHJjKQ0KPiArCQkJcmV0dXJuIHJj
Ow0KPiArDQo+ICsJCWluZm8tPm1lbV9lbmFibGVkID0gMDsNCj4gKwkJY3hsaGRtLT5kZWNvZGVy
X2NvdW50ID0gY3hsaGRtLT5kZWNvZGVyX2NvdW50X2NhcDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAo
IWluZm8tPm1lbV9lbmFibGVkKSB7DQo+ICsJCXJjID0gZGV2bV9jeGxfZW5hYmxlX2hkbSgmcG9y
dC0+ZGV2LCBjeGxoZG0pOw0KPiArCQlpZiAocmMpDQo+ICsJCQlyZXR1cm4gcmM7DQo+ICsNCj4g
KwkJcmV0dXJuIGRldm1fY3hsX2VuYWJsZV9tZW0oJnBvcnQtPmRldiwgY3hsZHMpOw0KPiArCX0N
Cj4gKw0KPiAgIAlpZiAoIWFsbG93ZWQpIHsNCj4gICAJCWRldl9lcnIoZGV2LCAiUmFuZ2UgcmVn
aXN0ZXIgZGVjb2RlcyBvdXRzaWRlIHBsYXRmb3JtIGRlZmluZWQgQ1hMIHJhbmdlcy5cbiIpOw0K
PiAgIAkJcmV0dXJuIC1FTlhJTzsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bG1lbS5o
IGIvZHJpdmVycy9jeGwvY3hsbWVtLmgNCj4gaW5kZXggMmEyNWQxOTU3ZGRiLi42MGI1MzhmOGI2
NzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oDQo+ICsrKyBiL2RyaXZlcnMv
Y3hsL2N4bG1lbS5oDQo+IEBAIC04NTUsNiArODU1LDcgQEAgaW50IGN4bF9tZW1fc2FuaXRpemUo
c3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kLCB1MTYgY21kKTsNCj4gICAgKiBzdHJ1Y3QgY3hsX2hk
bSAtIEhETSBEZWNvZGVyIHJlZ2lzdGVycyBhbmQgY2FjaGVkIC8gZGVjb2RlZCBjYXBhYmlsaXRp
ZXMNCj4gICAgKiBAcmVnczogbWFwcGVkIHJlZ2lzdGVycywgc2VlIGRldm1fY3hsX3NldHVwX2hk
bSgpDQo+ICAgICogQGRlY29kZXJfY291bnQ6IG51bWJlciBvZiBkZWNvZGVycyBmb3IgdGhpcyBw
b3J0DQo+ICsgKiBAZGVjb2Rlcl9jb3VudF9jYXA6IG51bWJlciBvZiBkZWNvZGVycyBmcm9tIEhE
TSBEZWNvZGVyIENhcGFiaWxpdHkNCj4gICAgKiBAdGFyZ2V0X2NvdW50OiBmb3Igc3dpdGNoIGRl
Y29kZXJzLCBtYXggZG93bnN0cmVhbSBwb3J0IHRhcmdldHMNCj4gICAgKiBAaW50ZXJsZWF2ZV9t
YXNrOiBpbnRlcmxlYXZlIGdyYW51bGFyaXR5IGNhcGFiaWxpdHksIHNlZSBjaGVja19pbnRlcmxl
YXZlX2NhcCgpDQo+ICAgICogQGl3X2NhcF9tYXNrOiBiaXRtYXNrIG9mIHN1cHBvcnRlZCBpbnRl
cmxlYXZlIHdheXMsIHNlZSBjaGVja19pbnRlcmxlYXZlX2NhcCgpDQo+IEBAIC04NjMsNiArODY0
LDcgQEAgaW50IGN4bF9tZW1fc2FuaXRpemUoc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kLCB1MTYg
Y21kKTsNCj4gICBzdHJ1Y3QgY3hsX2hkbSB7DQo+ICAgCXN0cnVjdCBjeGxfY29tcG9uZW50X3Jl
Z3MgcmVnczsNCj4gICAJdW5zaWduZWQgaW50IGRlY29kZXJfY291bnQ7DQo+ICsJdW5zaWduZWQg
aW50IGRlY29kZXJfY291bnRfY2FwOw0KPiAgIAl1bnNpZ25lZCBpbnQgdGFyZ2V0X2NvdW50Ow0K
PiAgIAl1bnNpZ25lZCBpbnQgaW50ZXJsZWF2ZV9tYXNrOw0KPiAgIAl1bnNpZ25lZCBsb25nIGl3
X2NhcF9tYXNrOw==
