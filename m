Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFF4D8B7
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007456; cv=fail; b=D/fGevks8+ia1UXe51fIZF4P7yVfu0sDKuCUF3b60E1isMfxm5ZT+8aLxM13yVyJ4TueWXsCNCh3q7U6olyYeTIoG8ldlgncPsIowDMZoXdytUucq58sgRAwheuQRaD0dyKS84qvd6v+MPey6pg3a8ePMILbtFcVBcMlMkZpjf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007456; c=relaxed/simple;
	bh=E/BUcoWn3magOshv4Ujw7mEPF+4hH2tG0B1fc0X5imo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZPHYpiBxSq8SxgMnrZqqzCTwAEpNv7p4KYCW87r5Vmu/nooZnRwiPI3lar3xmlbTJqQwEnugviY2LM5yj6N5Ns4ybyM/tKuJgD3KCY//hq7UB/kvMmbYfbW2Hu84fiVrmkEM+12Z6eZ1ZK/yI12ScKBG4nMtZOqKiWhb4HaNvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=edWX4zXS; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="edWX4zXS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1718007454; x=1749543454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E/BUcoWn3magOshv4Ujw7mEPF+4hH2tG0B1fc0X5imo=;
  b=edWX4zXS3fisvDC/5N7SiuWKQtRk8sMomO25TRaRQ4EnJC2JM0SGib9j
   CqBdSwLE8UGA1PDj6ze408DCdBUJAkOKH3NCjYkTX3BvfkbLp7disg6Qa
   iLF/EJEAHQWvuX6msuV8PdsbZvp5XJjWOR/4eKtuR6474wMo2v5P9q7i6
   EOQr9oH4WYUjnRKgwCzHqSeYVKFNbALiaQpN4/eWJo0NmC5bCBWh5udLA
   A4eF3TqBC+PLUjry5j+E3LYw1NbbQpf5yWzgBb6FWmc7HJy4UFzcZIcEr
   VJM9/KLoCyBVSetX74BtVlsqqsRU4rvFHokFKbfpKNEs6Ybw350x+NPCU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="122678859"
X-IronPort-AV: E=Sophos;i="6.08,227,1712588400"; 
   d="scan'208";a="122678859"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 17:16:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg/B1sy9rMjIHd2MxfHqLGpcrNN6q2WelF8g3hzvLetuMmBhhGYpWLtAQbdmZOjd/H5ehx6KnEWZI+1oYKQtTYIKUMHET2L87fknkiEWmgNDGEBMJfqXWq/1jJBvd2mnQh0nNIpNJHJD5wOSGbuaH/vBueIy8VnzKKZB2NPRQbprP5LHtTgDAeFgv2vk3msZtt5TbOjMHroFn98tYbnEY1AuLvDb+X+z6D+CNjBO8PEXXwaUXlxcXfnfYdP3B0R2wlTR9HPeJ5gQVSWJlsx17kEPIxBM6AxG4DQYXSk3s6M6aEisN0n1Bz4tt6OznjdeowWaKqamhR3Lit7uCF5c5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAeNouhs8YPirfTNG9UaoWhx1OBri0a6ewIMpoiS7lM=;
 b=RIWg5woiA0F6e3g167gwKC9qK2UX5cf4CUeYbQDRxN5+R7cpcHlRfDUysoVBvCfP6EX54GvS6/wTcNKORa7EKCjQNl8V7PkkTqsZ0B6hMmsKE5VGHIU5FeiiM4gYW6WyEe6aLQv18oDsCwgt0QiG1aO7YndGdNEJ1zYuTlGfHmDN2PgJtHvUnGcXCwrSh7+CM301nPQbWiGsHXhoUn8ZGRmIdfgGOfKg9TP8T/eSgoDGn5/Im5bKbppZZUe6kcc/3cSwwlryFB3WcP5WXuh2lFBt/CjPzlf+yaGqiQ8JF1IZTIaj3CxhJHktKIlJjNtOmJmdualAZX7uXsh+Uij0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSAPR01MB7397.jpnprd01.prod.outlook.com (2603:1096:604:142::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 08:16:18 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 08:16:18 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v8 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Topic: [PATCH v8 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Index: AQHat+WDTdX2zyCwv0G5LZzc8eyktrG6w+cAgAW0ZwA=
Date: Mon, 10 Jun 2024 08:16:18 +0000
Message-ID:
 <OSAPR01MB7182C5CEAF2504EEA0403C06BAC62@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
	<20240606074814.5633-3-kobayashi.da-06@fujitsu.com>
 <20240606150012.00005b6c@Huawei.com>
In-Reply-To: <20240606150012.00005b6c@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Standard;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-10T07:57:28.336Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSAPR01MB7397:EE_
x-ms-office365-filtering-correlation-id: 9c3778c8-8778-4c52-a945-08dc89259ab2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?UU5iVXdUdTg1aER5QmQ5TDBNQmtROWlHRWJCT1RJck45NW1XZGdUZFkw?=
 =?iso-2022-jp?B?WGpDMEFJNkNiMnZ4R0c0RHNtMU01ZzFWeVN0TmU1WXJTZHlaSzhWeWov?=
 =?iso-2022-jp?B?d1djSnpXSGEwTmwrTUsyd1NOYm1aeE95OHFPYjZGdlltaXEvR2xDTnpB?=
 =?iso-2022-jp?B?SnlNeHQwOWo4ejdzSW56QzgyZXhqVGp2ZVc2NThwZ3hTQmxnMldmSWZr?=
 =?iso-2022-jp?B?eStpK0ZIMERmN21IKzJSMklsYXdUV0NPb0wvdUcxczl2akZuaDFWcGZI?=
 =?iso-2022-jp?B?Y2ZubG9vem9LQ1E1eDdXa0Z2Nmt4YzQ5c2ZteGpzQ1Rvc2dMUnppQ1Zo?=
 =?iso-2022-jp?B?akwxS0pSejMyZEM1MXVsTzVxUnptUks5U2pObDdnYXRkMi9KY3M0SW1T?=
 =?iso-2022-jp?B?R0w2ck9XLzJYSkxDY2YxUWQwL3I4V1BxU2wvOXdqSENHdE44TGFkTlhh?=
 =?iso-2022-jp?B?eDEwcGR4ZmEvbS9nVWp3Q0QvcGtuTEFQRmlXdXQ4K0hXOXJmR1piREFt?=
 =?iso-2022-jp?B?TEt6b2l1QzZIeVplOUJMRCtOOTJmV1I1SmowS1RMNUNZd3BNVE1XRW00?=
 =?iso-2022-jp?B?NHpqK09MVTlGOEhYOGJTWFNubjB0cFJ4NFdWM2NzMEUrZy9KWGFYY0Ew?=
 =?iso-2022-jp?B?VStYVW1QNWF1QWY4eW1Xck92VWY2ejFzb1h4a3VkSkM1b0VHL0xUT1Bw?=
 =?iso-2022-jp?B?S2piV2hXNUlmbVdmUk8wN2Y5T0tGWTVFZXpndmxYaThoMFUvSjkyMFRl?=
 =?iso-2022-jp?B?aWVoQm1Oazd1ZFk1UEFRQi9UdTFSYzdFSU52aHlGZ3c4T2N1azFvV1pD?=
 =?iso-2022-jp?B?WGpVenIyWnpDWEJMZlpIcFB2QWU1cHR6ZG9lbFQ4SXJuZzRkSHpXZXVz?=
 =?iso-2022-jp?B?eExVdS9ZeW5OVlRtRDhKSXVGeHNucXAvNldzUkdLZHgvY1NIaXNwVUhR?=
 =?iso-2022-jp?B?TFZIK3A4WlFhRkN4RjRQRERZY3hzdjhxc21CeFA3SXNqMmJFQTR4Q2l3?=
 =?iso-2022-jp?B?eG9mZmZsRXdwdVQrSDlhMDFIYk84Q1d6bi9POUFnREZaVEozQnByN2Rj?=
 =?iso-2022-jp?B?Z25BZnFnZ3plcU10eThjUnhzb1JVTG4yK0w5S3Zvd2o3VGY1a1lJNlJw?=
 =?iso-2022-jp?B?TnNnMW1pWi9NM0JybXRqUnVXVjN6OW1OS250YXJtY3N4YWwwRHoyWGZT?=
 =?iso-2022-jp?B?aXBXelFGdkFZNDNXNGV3NWJNdExKM1hWMWY5Vy9peVRXNTFobTZlZjRZ?=
 =?iso-2022-jp?B?SU15K3FGQU9rdUdtc01JbHdNNVhYcnQ4UFRVcEVqMERkRnd2cENhdFB1?=
 =?iso-2022-jp?B?eW5MRVJKMUZWSE1MT011elVBVnJtTW53VE5CclNta2o4eDZBam03Q0V2?=
 =?iso-2022-jp?B?aXp4LzJQZXhqcEdCS1IrSC9PcVYzK3VBaVQ5b3I1OXhSWXNJRGZvYm5O?=
 =?iso-2022-jp?B?UjMwNzM5MlhnZ3RkN1pMekZpK3NGVWJ3WW5xZnl3TGRqc0lnN084Uys3?=
 =?iso-2022-jp?B?K1BaY1ZlVjF4TzJUaUcrdUtmY0d3eXdidXNtbFpUa3QxWFNiODFENDZU?=
 =?iso-2022-jp?B?YURDSnhRbGhaVHpPb1JmVWx1Q2VsMlg4VnZpM0MzdU1GVjR3RTIyYWhp?=
 =?iso-2022-jp?B?MG9aTjV4aDQzTEhWaisvSzNoNGZ3Y1g0ZHg4VjJrWVVIZjJ0Yll0RjZ5?=
 =?iso-2022-jp?B?R2QweGhNZDREblRzTEFMdDVIVlVVWkcxY2hlWU9JTll1UEtTVEU2bHc5?=
 =?iso-2022-jp?B?cC9tajJkcytNakJDWVJJWWw4NjVPRmwyU1FFSTgvUDZWVGNOL1BQY0hJ?=
 =?iso-2022-jp?B?UzZkWm1oRkxWbzNJVEk0UTdjUXdwYmdZdkxtMk1TR1M1OUxUbVFIdGlD?=
 =?iso-2022-jp?B?N29FSzkrbHpHU1E1c1FvSndJbllIQmRiOUxBMndNMzJ0aWd0TnBKbHJh?=
 =?iso-2022-jp?B?VHhia095VWM0VmlPRTJHTXpJd2hiNEhUc2w2VXJHYTBYWWRwNXdGZTdD?=
 =?iso-2022-jp?B?eG16bnJjOVVlL0FuWDE4ZGt0SUVnWDZJVkJ5bU0zbEpwKzd6dzdlWUtm?=
 =?iso-2022-jp?B?aVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UGhONG9idVJTdDNwYlpoaUZPM3BPZ25SVGVHUTFEb05CYmJvMTJrOFNt?=
 =?iso-2022-jp?B?dVU4VVZqd1pHUzMySmQ4ZGt5bVVWUFlmOFpjVWtHa1daZ0tOcjd6bkVW?=
 =?iso-2022-jp?B?UmIyS1lPWEpLTk1UaXhwM3haK3RKNTNlOEFkSWlzYVpOQzZTRlRiYXEv?=
 =?iso-2022-jp?B?ZEJvOG9ndGtHL1FIUUtUMEJ4THRXR1NxU1ord2lPSXM3VnM4b3FncC8z?=
 =?iso-2022-jp?B?MWVRMm4yUnFkWThNUjU2UXFiemVYaGFxMkI3RnRBcjNKNWtHSlliWHR1?=
 =?iso-2022-jp?B?ajRybno1dkRVa3JnZ3IxNWd6S0x3cXRFbmUzNXNEVmRsT3A0bkJjYUd0?=
 =?iso-2022-jp?B?OTd3L0dtVjNYclhLKzZDUzBqTlVFamY5RzBSdjR4L3lCZ0hOeE5xK3Mr?=
 =?iso-2022-jp?B?UlBVWlV4czZ1U29xZ3NyRHExTDc0RitBZWVPcEUzVUJ1TXdORVlaTldY?=
 =?iso-2022-jp?B?YzB0eTRNaVJXeVRZeGhnZEd4dzBZZ1NzblVHNmN4ckpjb1RaRTJmNTY0?=
 =?iso-2022-jp?B?bFZaNGNLTmhtbFpyM2FURlhGZ3dEOFp1bjcrNHA2YWFaNGh1RDZ2djZn?=
 =?iso-2022-jp?B?aVpWR3N1V2I2M2wya3lWUEE2cTlEdTNib2syYzlFWnpZUjlEQ2czMUlo?=
 =?iso-2022-jp?B?RGt2K0tLUC9JVENaMWdNZTluNG9aWXhwU1NmdEFYV0Z2a0hGOVA4WUpH?=
 =?iso-2022-jp?B?bDlmbEkrSkpaUkIzK2U2aDdyOVl1Sk5hRnBFWGFZWW9uNGlmQkhKakF3?=
 =?iso-2022-jp?B?NnQ3SThMN092c3IxS0taWjFka3dkb3VrMDJiUGdsd0JqUkZWTlF2TXZ0?=
 =?iso-2022-jp?B?c0hxclNOWDV1eld3SVBmbGRHc1c2dUhoMGhHMURHOXFRWEtJUkh6ZlNV?=
 =?iso-2022-jp?B?bTFRRlNaVFJWSmJpaVNsYTdLek4xbXE1ek1KbGE4d1ZLQU0yckwvOXZM?=
 =?iso-2022-jp?B?RGpXZmdqNlBOQWdsaVpzbFA2bE1wTExDaklVbGREMGM0Y2ZQNGVZVTJj?=
 =?iso-2022-jp?B?U2phemtzQmMzTC8wQUR4TGloSjVoL2NSSEl3aXFnME1ORTZ0VnNxYlVK?=
 =?iso-2022-jp?B?aWtRZ1BZeGI0QmhuTUpSRE1EVXZoTXUzb0pUcE92MVF0bElKWWZNczZU?=
 =?iso-2022-jp?B?d21GYXhoKzNPTU0zVHJwZ2ZQM2VTWEttWFVUSWhDSzF5bS95TU5qMzlQ?=
 =?iso-2022-jp?B?WmJteVF2eHM1NCs0cXlMeEFKVzdtcnNuWnZab0ZJLzNvMi8ydUJvMGs1?=
 =?iso-2022-jp?B?Y0hNTWJhbFkwenBXWEpLak4rT0dlaW1mdFJxNHdJM2NmYU1MTUR3cVhK?=
 =?iso-2022-jp?B?Q2NWQWRDVWRLS1dzNFdGR3QvSDkvdkJZVWZUcUZxYzJ2anpkdUNUcnpQ?=
 =?iso-2022-jp?B?WFJKaXRyN3Z4ZlpCWEl4UTltTnRRTmpyMXk2QkFnbldWN2JUUXpaclcv?=
 =?iso-2022-jp?B?WnEzSzgxTXVGSk9JdjBMQURpeURuMFJVTGpEeFBFYzFZYWtSYUd1eEdo?=
 =?iso-2022-jp?B?OUk4V3F4ZU5UaTBFTDg2YXhaa0wxOGl0MGR2Z1lpQ2JRMWx2VWNHSlBR?=
 =?iso-2022-jp?B?V3pncGpDK1h4UFhWWXNXdkl6M1ByYXhMSE0wZ0JKVjVFb05nWjROZFhM?=
 =?iso-2022-jp?B?Mmsza1ZkUTVZSlFsUDhRTEk3TnlMQ01zWDR3eW1Pdk8yN1ZsVVo3KytZ?=
 =?iso-2022-jp?B?NjBXN0hSYm5DWkd6OTN3Q1JsZGFrUnZIeEVGcmdPN3FyNExIbytaU1Uy?=
 =?iso-2022-jp?B?RGFVTTZ6cGRzNHNLZDNyOVg0UVgwamwzdlZHQmhYWittd3R6OHdqNFVT?=
 =?iso-2022-jp?B?Mk9xK2drcXBJSFJuWWNBNkhnNmZxeWpFeW9hZzdGRjAzVm5pNEtaT0FG?=
 =?iso-2022-jp?B?d3R3VW9wckE4SkZPbzhSd2Q4M0oxUm5UTUh6ZU5wejRTOUNtMTc2c25X?=
 =?iso-2022-jp?B?SytmTDcyOGZHSzVJWEtGOHdpdW1sc1BqTlBzdHkzb1JmTXNHMVI3YXUy?=
 =?iso-2022-jp?B?ZzRhOXl0aUV3QjZYU1JMVHVWWFpRUjI5L1pFbnVtYXUyNjAvVEJieTEx?=
 =?iso-2022-jp?B?ZGJqc01kQ0tFVThmenJEOG1GakhQWHRBRGRmdytFSlVrSTBWVDNvTHV0?=
 =?iso-2022-jp?B?WWNhUi85U2gwZi9hKzhjS2hKenkxa0prcDIxK090djMwT3cvOFhyL081?=
 =?iso-2022-jp?B?Sk9ZSmRWVFZYNkxvc1ByeDc1TzluOGZ3VXlvbGZCZE8wVHEvclhlZzlq?=
 =?iso-2022-jp?B?WEpnOG0zOGt0NmJGdGppbk1NUDYrU0Q5YXl4ZlpIY29JS1BGaWYxQjlI?=
 =?iso-2022-jp?B?NUI4T2JaYW1CSW5INStSZHZLSTFiVVhUN1E9PQ==?=
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
	KcZ2CSJYyvxeaEsC/7pFvkp3UZ8rMOz2LTsPey+NEA9IM6AaF+SARF2SHnv0dV3oNTO0Cz5fGVIKPrIbnzQnqV1HECUEJQzWvYxTBGYQz3/bJMsUw/+3YZeDK07MW6r36kavfS3MXuvaNXKSSOq2jMipVlYgHcJK5EYnHVXv0OzD6zoMdZs35r1BVtA7OLmcV91GjhfpkHitq9HuUP6c6BNzFyqLmjyc/fR86Qw1NG4cyDXhLD4RX0UkM4ZyEzz6pTmoaZYTFPyG6TIG7DBlwy4VeIUvOa4E4iy93hSk7Dnuxi+htb0hG9oXcovcNqeMkGolUey7AxFZ0LgN3BUBl8ugo9CmVr6TkF8Aeqr23XAwIDk/PsJRVArADLGltJ1ItqmyFpsQut9eZ2RCvIl14iDaqEwbWP1nWeqxB0lKypK0T6ugNvuHwlhMatBqeGSFXYRPGTlnI/gnYPpE+xglo+07nc/tmlpkbB8XQnbtJ7MJLG9zD2NjHqy+d4MnzsODH7BvBvS/zMFG/Z8QL7WsXaRrsxMd39YVtykevUKeIdeeGqr5FTRs+y8hVVCl3mca0uy1rEUP847LbiockRigCKMnKqSExQ8llxG6CKFcpgZs1YSsJdGuG0/aHRp2euN7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3778c8-8778-4c52-a945-08dc89259ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 08:16:18.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uzzzOjAIJkdC6DT9iIOZ8EJCuJIgFjhknhuxIhR+BE804weqtgy5OslF52WEwxdlXrGclsQ+SNADR/h8ZqsgM4RlPtOzIdhTmUKvAxMrnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7397


Jonathan Cameron wrote:
> On Thu,  6 Jun 2024 16:48:14 +0900
> "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
>=20
> > Add sysfs attribute for CXL 1.1 device link status to the cxl pci devic=
e.
> >
> > In CXL1.1, the link status of the device is included in the RCRB
> > mapped to the memory mapped register area. Critically, that
> > arrangement makes the link status and control registers invisible to ex=
isting
> PCI user tooling.
> >
> > Export those registers via sysfs with the expectation that PCI user
> > tooling will alternatively look for these sysfs files when attempting
> > to access to these CXL 1.1 endpoints registers.
> >
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  drivers/cxl/pci.c | 91
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> > 2ff361e756d6..e157959dffc2 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -786,6 +786,96 @@ static int cxl_event_config(struct pci_host_bridge
> *host_bridge,
> >  	return 0;
> >  }
> >
> > +static u32 get_rcd_pcie_caps(struct device *dev, u16 offset) {
> > +	struct cxl_dev_state *cxlds =3D dev_get_drvdata(dev);
> > +	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> > +	struct device *endpoint_parent;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +	resource_size_t rcrb;
> > +	void __iomem *addr;
> > +	u32 ret;
> > +
> > +	port =3D cxl_mem_find_port(cxlmd, &dport);
> > +	if (!port)
> > +		return 0;
> > +
> > +	endpoint_parent =3D port->uport_dev;
> > +	if (!endpoint_parent)
> > +		return 0;
> > +
> > +	guard(device)(endpoint_parent);
> > +	if (!endpoint_parent->driver)
> > +		return 0;
> > +
> > +	rcrb =3D dport->rcrb.base;
> > +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
>=20
> I was assuming we would find the address of the capability only once and =
map
> the relevant cap in for all the time the driver is bound, as is done for =
aer_cap.
>=20
> I'd be worried that this might race with other accesses to rcrb in the fu=
ture.
>=20
> I suspect best option is to keep the capability always mapped in similar =
fashion
> to cxl_dport_map_rch_aer() does it for the aer registers.
>=20

Thanks for your comment.

It seems like we had different assumptions.
I reviewed the implementation of aer in cxl driver again.
I will post a patch later that changes the memory mapping method to be simi=
lar to=20
what cxl_dport_map_rch_aer() does.

I'd appreciate it if you could review the patch once it's posted.

>=20
>=20
> > +		return 0;
> > +	addr =3D ioremap(rcrb, SZ_4K);
> > +	if (!addr) {
> > +		dev_err(dev, "Failed to map region %pr\n", addr);
> > +		release_mem_region(rcrb, SZ_4K);
> > +		return 0;
> > +	}
> > +
> > +	ret =3D readl(addr + dport->rcrb.rcd_pcie_cap + offset);
> > +	release_mem_region(rcrb, SZ_4K);
> > +	return ret;
> > +}
> > +
> > +static ssize_t rcd_link_cap_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf) {
> > +	u32 linkcap =3D get_rcd_pcie_caps(dev, PCI_EXP_LNKCAP);
> > +
> > +	return sysfs_emit(buf, "%x\n", linkcap); } static
> > +DEVICE_ATTR_RO(rcd_link_cap);
> > +
> > +static ssize_t rcd_link_ctrl_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf) {
> > +	u16 linkctl =3D get_rcd_pcie_caps(dev, PCI_EXP_LNKCTL);
> > +
> > +	return sysfs_emit(buf, "%x\n", linkctl); } static
> > +DEVICE_ATTR_RO(rcd_link_ctrl);
> > +
> > +static ssize_t rcd_link_status_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf) {
> > +	u16 linksta =3D get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA);
> > +
> > +	return sysfs_emit(buf, "%x\n", linksta);
>=20
> Local variable doesn't add to readability as the PCI_EXP_LNKSTA makes it
> pretty obvious what is being queried.
>=20

I want to specify the format of the output.
I will specify the format of the output by casting the value to the desired=
 format.

> 	return sysfs_emit(buf, "%x\n",
> 			  get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA));
>=20
> > +}
> > +static DEVICE_ATTR_RO(rcd_link_status);
> > +
> > +static struct attribute *cxl_rcd_attrs[] =3D {
> > +		&dev_attr_rcd_link_cap.attr,
> > +		&dev_attr_rcd_link_ctrl.attr,
>=20
> Indent one less tab.
>=20
I will fix it.
> > +		&dev_attr_rcd_link_status.attr,
> > +		NULL
> > +};

