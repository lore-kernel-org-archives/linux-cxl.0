Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDB322A
	for <linux-cxl@vger.kernel.org>; Mon, 19 Aug 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724046767; cv=fail; b=TVA89OI0hy4slsXaEIVssDkjVYFNVTGRS+PFO7AjzTuefw9Nt5Ygsfp5CwPPRMN7qfTNjz7U4lv471k60D1Ogw4dcFXfeKOXjuRbMKpt+VYjbGi/W3UrxTOy4kXeZe1yCZfS+eaHgrb3qHNZ+vkG6Wy30VT+AyMjNQFFKikD5qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724046767; c=relaxed/simple;
	bh=cZ9HPqvGn7YpNDyS4BYQ1TTD/MKKf8WIGQMsU5D/JaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsUEYJsZAzI1aXD5ooLIv0bvZ4o6f499iNLz2AGw6XcvPdlmtGl1kZaMSWNwmCqY2r/bmWukhzrTPOzEqCXLSf2Pz3ZnS2JF1Qp6/M7uG4Y8MPl1kicUnA42GfrYOkQz8Q5IQxKwotmvxhkwWRN92AUTR0J5cgWecR5u+6uWZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E5aWt+4d; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E5aWt+4d"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1724046763; x=1755582763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cZ9HPqvGn7YpNDyS4BYQ1TTD/MKKf8WIGQMsU5D/JaE=;
  b=E5aWt+4dK9hngkYYP802y1QcD75DF/fjFLd+oVX5lt4ROHjKAHMNqYbE
   HAeS7WtpXWYFtbbWmWNkim13nc5PxClPIzXDT7VC8nbXI5AOt+/NJ3E7M
   gHyFB1CqhB+zxaceE4qSvHq+BvU45FOyEGD4XNe7EsjLKBNfzwXL9QDHg
   bmqBrn4FCEs5NiTlM81rejyZRjrNiWxKR5oZZ7dzV/VLc3dt7h3DHXWOd
   FPAr83P9dGUp6zz3Ov8ekhWwI8dZWcvrd8oKOpRxSHaovHSug2l8vnlgj
   WhINh27GaqF+prq8Mr3hq1M1n/JTzRy5WUU7FBNf0sdvY6nkMoSysgyco
   Q==;
X-CSE-ConnectionGUID: 2bHEP9q6SFKoOgbsyhkT/g==
X-CSE-MsgGUID: m0BmRrThRz6s7XT4SkbfSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="129116066"
X-IronPort-AV: E=Sophos;i="6.10,158,1719846000"; 
   d="scan'208";a="129116066"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 14:52:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbrVTlJ3jGLqWt7J6u+vPKqnvymLbjGJMzyUUCl0t54/MwvLtc6lzSMjXqH/kvsLC66DCjIGh6FpPeYKqNlM5CSt8KYNSS+mm85Xb4p0FZcPblun64wjE1noibAaA7A9f2DQilxDWKSsuyJJzhky8kcvb7whwuMuLWn0fZL6qPmgKMG0+4liHXKwRU8dFUsvszJ2AQso7otq14Pkw6iJlud9EyGTjDSjqcOYzhkHsPuXahftHh1sbeC5ASFfJ7gnOzFzG50t8RMZhviddF46PptQ9lFktdlGpNYvWPiOKWEeZuFlxAMOij+RQc4sya9TLGvSUVGsGh0yr0jNepUaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N8/ANzV75Esp4VF41ukLX3RYo6CS7Y2jDH+6cwHQRI=;
 b=BsMRhHC7k/RJAp1qZXInp28WxmWK2zrT5d6uitMNdRYYNDQnulhafZ0IlSE+nVMMrORoDEk7i1xZ100we2Zukz2DEcQv9sVg09A10aSXmn0/TsvcP6/cGw/uvzaL7Yf3itNxrkyaue1yIaC0TDxsd98qgSCs6AN/HPfvLoMf4sKOKG4HCGIQhCEMGw/vTzftcvQp/z8d1qsw/5q2FP1Vpe/TYNDHJaEbO5Va78bhq7SRiuId+yVQiOCEDN2pCKV1VuaH7Ub/Yyc8V7AVj/3LxMoIlVNIPvm6hrDUqhYrdsKvMO5VVaP2WBHdJlUDS5j4YWSB75CNnQnW1c/U7AURhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSCPR01MB12912.jpnprd01.prod.outlook.com (2603:1096:604:33c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 05:52:31 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:52:31 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Li, Ming4" <ming4.li@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v16 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Topic: [PATCH v16 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Index: AQHa7q2RB61N3A+NEE+x4Nhuszovo7IpdYCAgAROg8A=
Date: Mon, 19 Aug 2024 05:52:31 +0000
Message-ID:
 <OSAPR01MB7182BB9F62ED6ADD9BFB0C68BA8C2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
 <20240815005510.220835-4-kobayashi.da-06@fujitsu.com>
 <5181e123-44ef-43d8-926a-3a11cfec6842@intel.com>
In-Reply-To: <5181e123-44ef-43d8-926a-3a11cfec6842@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-19T05:52:30.154Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSCPR01MB12912:EE_
x-ms-office365-filtering-correlation-id: a2990b58-c053-481b-9d8f-08dcc0131d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZjNQSUsreWk2Mmt0MmVqWXZIWkFodDAxYjlxL2NKbDJBS2xRSFU0OEU4?=
 =?iso-2022-jp?B?ZEhpNkx6T1VNSGc5c0ZsOXEzU09zcklEdVA5NHdVbm1sZzc2d01TQ25U?=
 =?iso-2022-jp?B?NmN1K0RlR1NNUnlyMk4vZXExRWRZZGpISVplNEVYWTFmQzh0cVhwUXg4?=
 =?iso-2022-jp?B?TkcwcGljdHpFWUdGdEhYaW9PVWEwaU5QQUM4Yk9RRFpuVHV2bS9JWGRC?=
 =?iso-2022-jp?B?dXVoSTFZV0lqVjkzUEt4RFBwUmJyd2c3ampORjRlZllQRE1PMTMvbmlZ?=
 =?iso-2022-jp?B?aTM5MnZ0clQySU5ZcjRrSjJyUm5IUGs0eUtnNnFtSC84cGVOUk5xbXc3?=
 =?iso-2022-jp?B?aDkyRkgxN2JaNC9NL1pwcjdlMFdYZEJGaGVSZTdDZ3YyVUdicTloMEx5?=
 =?iso-2022-jp?B?aFB3azlvT1hZRWZYekJWRkhJYTE3TmJXbmVhWkJ5WHVLUjFBU0grNUdB?=
 =?iso-2022-jp?B?RGdnNDd3dVFmNHVnMHhwQmswNUhreFovc2FRNGNubnlvdE1XS1A4b0FV?=
 =?iso-2022-jp?B?a2twYTN6VU96OUxkSVloL1RCYllKOUVSTHo3TXFSaks0Z0dkQUoyUWNx?=
 =?iso-2022-jp?B?eWlSeW1QRzZHM3RKelloYjhZQ3RzQU1WZDZma21EUmJLMEFlaUxKbW83?=
 =?iso-2022-jp?B?bEhDd2VHKzdQRUhlOEZFTUNBVnJ1MU5zMEI1bmUvT1NZbERkQ0ZwTDZB?=
 =?iso-2022-jp?B?cE5EZE5jV1I0UXc5N2NnZ1luUmF5Qk9tKzFYQ1BLUnVIK3dSdWxrL2du?=
 =?iso-2022-jp?B?bFB4SFFJOEdvaU45b2pRZmlkSm82U1JBN1JpYmM3V1MxRk9MSkltVFZH?=
 =?iso-2022-jp?B?bnZoakptMWVtdG9pcmhua0ZROHhyZXpsY3NFT3ZRbjE1UzZOdEV0dCtn?=
 =?iso-2022-jp?B?NTlYUTA1S3hmemdZaUZjYnI2Wkc4TWFaRGcrZ1dTbW53ODJoVzNLSmpt?=
 =?iso-2022-jp?B?YnY4cGU3MmRBV0d0aWVBRU1vZzNueStyMnR6aGU4d0xYU2hRdmdIU1lj?=
 =?iso-2022-jp?B?cm1NTTZmbk1JeDBrNlAvWTB6N1Y0Ukx1SjFVYlI3SmVlTTRlYXpTN0Z4?=
 =?iso-2022-jp?B?V3dvTTBiVzJBbjEyMlA5elNKUTlzaUhpcWY3ckEzbzdHbCt3QzBzcjBR?=
 =?iso-2022-jp?B?emI3aWJaK1hZR2ZMRytWTndKWTQrKy9SdTRnOENGWktPWitBYkpkYnVY?=
 =?iso-2022-jp?B?d01LQmdKQktQKytOK1pROUlDMng4Q3liWUNZQlZhZ1pjcS8xWExpN284?=
 =?iso-2022-jp?B?M1B1Y09Fek1pQjhRMDZvNWZFaGNBK1cxaHhVN1BiRDBadVVMWkdXaFQ5?=
 =?iso-2022-jp?B?U09iV2F1NFJLcUJRQllDTlhaYUJ1YWVpS1YzK2ZxMEhUZGJEbVNvcEh0?=
 =?iso-2022-jp?B?SXFVeTViVW9uUEFoSHpTSVVsVmlJeHpDVFppUW9JRThXZ3gveDhLUnZw?=
 =?iso-2022-jp?B?cUowMDlWSG1GTGdZUWhvZmwwbGZiTXY3L3draWJIRm9HV2VvR1hvd2dX?=
 =?iso-2022-jp?B?enRsNjY4OVVPNnA1YzlxRDYvYmhZd1IwNnhjSngzYXljT2YzNTBQUlU2?=
 =?iso-2022-jp?B?aEJuZmk4UFlEeGpxMXhCdER0Qk9vS01jTldYN2RXcHVvVFlweGw1RFBF?=
 =?iso-2022-jp?B?NkVpakdnQkdFUVNZT3F1SElqd2s1dml2NlMvcVNXcUlOOWlXT1EyUTNa?=
 =?iso-2022-jp?B?TTB3Y0xORlNucm52ZGpzQnpWODlKUUNXaGdCNkZzRjZodEJqdHpYcGFy?=
 =?iso-2022-jp?B?MzZ1WHhCM3hYenFNRnRocVNoNmJnci9BWjhaRnhtTDk2ZDJXeUttODNK?=
 =?iso-2022-jp?B?b2pUME9JUVpKNVcxTkRvMzVURkJPZnZ2Kzc4bzd3QUtCRWR1TjlOOU9a?=
 =?iso-2022-jp?B?T28zZFdkOTA0aXRaWW4wVHg3REJQZ0tSb1hNYXU0cnBxUkNuSDZhTGFS?=
 =?iso-2022-jp?B?ejFlQlRYYy8vclVEdXJKbW1jNVptWEtWZ1pPSVNSWllCL0toODhhOEMr?=
 =?iso-2022-jp?B?NENJMU5Bbm1EaXpZTzBEakQ4eThlRw==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RkozaXhzNUxwcHdvOGN2bmZaaUNhUDRxc3pscXB3M2hrSERzOVNCTGJq?=
 =?iso-2022-jp?B?SWdScUIwVCsxY2FTeHhsMHVNUjIydGd3SVE4b1FlZXY2Vkw2N1pZQktp?=
 =?iso-2022-jp?B?L3c2bk8xclVqbVJ5SnRRMXFvRUN3elR4YW5MSXhWRU9SWmZ1OHAwUE1Z?=
 =?iso-2022-jp?B?V0pVbmlBdjIxV1hZRW5OanRWVUFucUVMajZRcmJTV2pOMXJHTHhVYlpB?=
 =?iso-2022-jp?B?OUVjNW1GbUdJZHo5SUx4dTZjNUVsYkJNOHA4ZFVhTXdSaE9idGlXVmo0?=
 =?iso-2022-jp?B?NVVLekdLNk1UbEdlZ1lSelp2aWxTdjRkeGM1bnY3OHVIVEIyM3FEWEM0?=
 =?iso-2022-jp?B?cjJsSEN2eTBibW92dDBwTi9USm9TWVNCbnlUWE1HYkt0QTIxSTd3Y2VH?=
 =?iso-2022-jp?B?RWVDZEtOSzlOdmcwUjFhenhFZWZmb3FWczkxK1RqR09Ia1huaDdQa0tv?=
 =?iso-2022-jp?B?ZE43QnozQUVoV3RUUC84Y3ViY3lONjJ5ZWhaVTNVQklHajlBSVdHcU4w?=
 =?iso-2022-jp?B?UDNhcmw0RUhSblRvS2FrR0huSU11QnhTaVdVNmljeFVlc0p4cjIxaU1o?=
 =?iso-2022-jp?B?Q1h1U0NOYzZDSmxLTUFlOXJTbVg4WkRBQlY5TE5uc1lDcUhVN2dVd1hM?=
 =?iso-2022-jp?B?cllkcVpTUjlkcEJ2S1FsRXNjamhXMmt2ZEZUV3VSYmZsNUh2UVBQOFhC?=
 =?iso-2022-jp?B?UGNHdVM3d3BucEpReW5YcXI5eU1QazhNbWRtY0hFRU14UGpIWG0rT0Jo?=
 =?iso-2022-jp?B?NHM3MHMvdTVpYnJsTUhUakxwSm95djh3SWNsaUVaTFBDdVg5MVU3ZVV1?=
 =?iso-2022-jp?B?bzRvMEdrejRQbzlGOXo5Z2R4QkNiMW5PdkxVd3VEWHZPNHdRVWdleGFa?=
 =?iso-2022-jp?B?Uk5kYk91WDY5WlpJYkhsMUtHc2krRVZKRUozQXA2SkUvZ3pLRzVSRFV1?=
 =?iso-2022-jp?B?Yi83dUNqN1I3Mks1QzEzdWlsQ2RVOGUyQ2xORnFHVmZ5RXljRi9lUVE4?=
 =?iso-2022-jp?B?bXd6MlFUOG9uZWQ2MDNUWCtzcS9wRTlncVhQTmRYLzN4TzE2TzJVUWhN?=
 =?iso-2022-jp?B?TGVKL1pRTEJ6bm9OeWRJVnVmTHR5TzI1WC94RkNvVmNsU2JuSG9iKytF?=
 =?iso-2022-jp?B?QklVQXQ5anhFdjV6Q2ZDOUJuZVNML2Y2clNxY0RCeHZuY0EwZXhGdjQ5?=
 =?iso-2022-jp?B?c2szWm5uKzRNNkIydGlUclpIWkNwNnpVTkxMOGlrRzhydS80MGppRHhH?=
 =?iso-2022-jp?B?LytpMzBOcEZ3OGJRbW5vN2FyYjVwWUdiMlllYWw4UXRBbGZna0NzeFdl?=
 =?iso-2022-jp?B?WnhmTGQ1L1hta25aN1QvNng2T2IxSjZEK1ZQK25SRERPc3ZtZnlCcTBO?=
 =?iso-2022-jp?B?b1JSUU1rWTlOb1UrRVF1Z2dRODUzSStMT3hvbzk1cWZGZVNiYTBNRUNC?=
 =?iso-2022-jp?B?NFNtdkx3dlBCK1N1bWlJUUNCNTlPYTRBVGFSSHRXQmNjc2xqQml6L3Bk?=
 =?iso-2022-jp?B?T2htMDdqOEZXODQ4dmFkSlpiZ3pHbzVsbzB5b1hPL2R5alBaclFKdll6?=
 =?iso-2022-jp?B?QWR2RitPRmYxdXVqMnNUWkJFakR3WlhUa1lHT0s4S1hrRzhRSUlZYVNW?=
 =?iso-2022-jp?B?eTJFVmE5SitPaFlxbDlKcmJTYlo2R1VUQlRuMHZYOEIwV0trdVR5SDZX?=
 =?iso-2022-jp?B?RlhZMFdIUERvdkF5QkdqUDNPRWtWdHVnNlBNY3hQL3E0RXozZ0s1UFYy?=
 =?iso-2022-jp?B?dXlQeEdESnV1MGRzMWF0aTdWYkw1THNnSTU0TVdKVHFQRjRUdmdmRzM1?=
 =?iso-2022-jp?B?QnRWdGtheVlnbUVoRUZRZWdINjdlaXVRbE5YZ0JGaUt5ZnJQOEhYSmN4?=
 =?iso-2022-jp?B?TjdENXZMbDNXOWFhemNZem42cVN6aVVYanZqUTNzai8yTVd1RjdEYkE4?=
 =?iso-2022-jp?B?RXZ0RGJwQm15TndGMmd5ZU9QWjNDS1hhUDhOS3pOSkdiK2toaWZkOVhB?=
 =?iso-2022-jp?B?WC9xb1hFa1VJM0hTTWxYcjBPU0Fydi9JTzdhMm1oQjV5TVBIMno1TjV3?=
 =?iso-2022-jp?B?MzNzbStrRm1yMmpkRElXb2d0RmIvQ21HYnJLYjdHbnBBTHRKbHRHR3Ir?=
 =?iso-2022-jp?B?OHZFWXBicTRuWExGbEdYYXMzK3l5TThFZzBVZCtaNjlEdUFncE9IMDJH?=
 =?iso-2022-jp?B?WEZQSUw4ekVmMjhnTWlxTGgzYjBUb0xnWThUZDMyZE9TZTF4TkVadHlB?=
 =?iso-2022-jp?B?QzNnUzd1cklwM3o2eDNFMkI2YUE1MUlDWWxISnRLSHVhd1VXc0pSK2xo?=
 =?iso-2022-jp?B?a2k1K051bFdRSGM2aThtNXZPYXhHS3VaMUE9PQ==?=
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
	R9NKj1Qcz5IfnHIqRTZ3EUNyTjtrsLGp86atlux9Xx1a8WO+cHtObFcubJ6z1WszVJLtrbwdTKY2jDSMuOoboqMRY77p/iJy6FFE3vZRqL9FHLZTU4+WYCLyWRVl0Jzs1mAk76YsewlpT2KHAhv/OFcfrB32z0pmdUQlJEHvavENim8XFXJVllZ8fr6jsvsAsIYswPdJOuI8QyxZkx567S1/s01XjmoHA1fy7/bo4JotmQYTbcVENaCDUZ5491nKZGhziZMLLEzl6R5ft4Svr2AqDggUN2We6xPk4kEqGPsw6Pkoh1lleBrRKh+7oR+b87U1EOcxBZzduZOIXVcUvsWVzgDBAOXdoY7/8/s/AegLa+8yD0Jh7gveTJ5N2AHKV/7YepueAYxF5R2wH4MHp0zGBeNOAdYTf+a3DfU4U1qK7WNrSZofLBKdGTcReykaKVZCZegIlgMEnRJIM9UyAvuERsAJb58gynv80+ko/yVuIMLoHVOWMOH63peVTjNvcGbXkdZWA9u9z2Gjj4k6JoW/lmOBs1K56No9RX/GOVsieNhm7x22WesRRgdVi85TmlmaFOLHOt/h35GiTxm6pZZOSWTO0ioAkY6QlS0i4QKR8+219Qmg7KniRrZTn/AO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2990b58-c053-481b-9d8f-08dcc0131d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 05:52:31.2347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: votfSlMK42ZGNB8wlDqGDw86cCpzCJlEIqVymLBtJCI/npTXOzn4WFGYIFxNoeMNZ6Bkh1GO4OAiYvL3LMXstcHLgIUCL/4fZsXPKBSC2ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12912

Li,Ming wrote:=0A=
> On 8/15/2024 8:55 AM, Kobayashi,Daisuke wrote:=0A=
> > Add sysfs attribute for CXL 1.1 device link status to the cxl pci devic=
e.=0A=
> >=0A=
> > In CXL1.1, the link status of the device is included in the RCRB mapped=
 to=0A=
> > the memory mapped register area. Critically, that arrangement makes the=
=0A=
> > link status and control registers invisible to existing PCI user toolin=
g.=0A=
> >=0A=
> > Export those registers via sysfs with the expectation that PCI user=0A=
> > tooling will alternatively look for these sysfs files when attempting t=
o=0A=
> > access to these CXL 1.1 endpoints registers.=0A=
> >=0A=
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>=0A=
> > ---=0A=
> >  drivers/cxl/pci.c | 78=0A=
> +++++++++++++++++++++++++++++++++++++++++++++++=0A=
> >  1 file changed, 78 insertions(+)=0A=
> >=0A=
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c=0A=
> > index 4eaf64d92541..4e51b6a0a97b 100644=0A=
> > --- a/drivers/cxl/pci.c=0A=
> > +++ b/drivers/cxl/pci.c=0A=
> > @@ -792,6 +792,83 @@ static int cxl_event_config(struct pci_host_bridge=
=0A=
> *host_bridge,=0A=
> >  	return 0;=0A=
> >  }=0A=
> >=0A=
> > +static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char =
*buf,=0A=
> size_t width)=0A=
> > +{=0A=
> > +	struct cxl_dev_state *cxlds =3D dev_get_drvdata(dev);=0A=
> > +	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;=0A=
> > +	struct device *root_dev;=0A=
> > +	struct cxl_dport *dport;=0A=
> > +	struct cxl_port *root __free(put_cxl_root) =3D=0A=
> > +		cxl_mem_find_port(cxlmd, &dport);=0A=
> =0A=
> It is not right to use put_cxl_root() to dereference a cxl_port->dev here=
.=0A=
> put_cxl_root() is used for a struct cxl_root rather than a struct cxl_por=
t. I=0A=
> implemented a put_cxl_port() in the below patch which is under review.=0A=
> =0A=
> https://lore.kernel.org/linux-cxl/20240813070552.3353530-1-ming4.li@intel=
.c=0A=
> om/T/#m07695675435bf702311dfc40f64289b9623afa16=0A=
> =0A=
> =0A=
Thank you for your comment.=0A=
It seems I misunderstood Dan's review comment. It appears that using the fu=
nction is the correct approach.=0A=
=0A=
Dan, could you please confirm that your review comment is suggesting the us=
e of this function which is under review?=0A=
=0A=
=0A=
> > +=0A=
> > +	if (!root)=0A=
> > +		return -ENXIO;=0A=
> > +=0A=
> > +	root_dev =3D root->uport_dev;=0A=
> > +	if (!root_dev)=0A=
> > +		return -ENXIO;=0A=
> > +=0A=
> > +	guard(device)(root_dev);=0A=
> > +	if (!root_dev->driver)=0A=
> > +		return -ENXIO;=0A=
> > +=0A=
> > +	switch (width) {=0A=
> > +	case 2:=0A=
> > +		return sysfs_emit(buf, "%#x\n",=0A=
> > +				  readw(dport->regs.rcd_pcie_cap +=0A=
> offset));=0A=
> > +	case 4:=0A=
> > +		return sysfs_emit(buf, "%#x\n",=0A=
> > +				  readl(dport->regs.rcd_pcie_cap + offset));=0A=
> > +	default:=0A=
> > +		return -EINVAL;=0A=
> > +	}=0A=
> > +}=0A=
> > +=0A=
> > +static ssize_t rcd_link_cap_show(struct device *dev,=0A=
> > +				 struct device_attribute *attr, char *buf)=0A=
> > +{=0A=
> > +	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKCAP, buf, sizeof(u32));=0A=
> > +}=0A=
> > +static DEVICE_ATTR_RO(rcd_link_cap);=0A=
> > +=0A=
> > +static ssize_t rcd_link_ctrl_show(struct device *dev,=0A=
> > +				  struct device_attribute *attr, char *buf)=0A=
> > +{=0A=
> > +	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKCTL, buf, sizeof(u16));=0A=
> > +}=0A=
> > +static DEVICE_ATTR_RO(rcd_link_ctrl);=0A=
> > +=0A=
> > +static ssize_t rcd_link_status_show(struct device *dev,=0A=
> > +				    struct device_attribute *attr, char *buf)=0A=
> > +{=0A=
> > +	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKSTA, buf, sizeof(u16));=0A=
> > +}=0A=
> > +static DEVICE_ATTR_RO(rcd_link_status);=0A=
> > +=0A=
> > +static struct attribute *cxl_rcd_attrs[] =3D {=0A=
> > +	&dev_attr_rcd_link_cap.attr,=0A=
> > +	&dev_attr_rcd_link_ctrl.attr,=0A=
> > +	&dev_attr_rcd_link_status.attr,=0A=
> > +	NULL=0A=
> > +};=0A=
> > +=0A=
> > +static umode_t cxl_rcd_visible(struct kobject *kobj, struct attribute =
*a, int=0A=
> n)=0A=
> > +{=0A=
> > +	struct device *dev =3D kobj_to_dev(kobj);=0A=
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
> > +=0A=
> > +	if (is_cxl_restricted(pdev))=0A=
> > +		return a->mode;=0A=
> > +=0A=
> > +	return 0;=0A=
> > +}=0A=
> > +=0A=
> > +static struct attribute_group cxl_rcd_group =3D {=0A=
> > +	.attrs =3D cxl_rcd_attrs,=0A=
> > +	.is_visible =3D cxl_rcd_visible,=0A=
> > +};=0A=
> > +__ATTRIBUTE_GROUPS(cxl_rcd);=0A=
> > +=0A=
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device=
_id=0A=
> *id)=0A=
> >  {=0A=
> >  	struct pci_host_bridge *host_bridge =3D=0A=
> pci_find_host_bridge(pdev->bus);=0A=
> > @@ -975,6 +1052,7 @@ static struct pci_driver cxl_pci_driver =3D {=0A=
> >  	.id_table		=3D cxl_mem_pci_tbl,=0A=
> >  	.probe			=3D cxl_pci_probe,=0A=
> >  	.err_handler		=3D &cxl_error_handlers,=0A=
> > +	.dev_groups		=3D cxl_rcd_groups,=0A=
> >  	.driver	=3D {=0A=
> >  		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,=0A=
> >  	},=0A=
> =0A=
=0A=
