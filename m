Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C017C68
	for <linux-cxl@vger.kernel.org>; Wed, 14 Aug 2024 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600716; cv=fail; b=maA94169j3eJXCMw3a3s9nFFkRZav3i0Mk1Lc1w8sUvP1HoGcBGJ3FQEg7nPZ9HgwefvY4WmPlVGCrOKwyL64ERQOMYKGgP64nEFzsJ7oTYrpYNUC06cJwwLVTec8sKDZxjNk84Et6MhkpbO34Poebjr1IrSUYBmeUfD6i7LPg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600716; c=relaxed/simple;
	bh=qzwNv5D4HeeWvbcNhFqsUniZz1H9GQRMBjoDOliStVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ok0Ow/ON9hQeYtkbqVHLFAIRejYDRTLftHd70rig4UxlmrTPrbgFwJxwJ9asmQKfdWSn2X+/nHWtuEh6QBwPFtaI79jKkXjfixaLGw1ozJFCqpuQdFyMrGV8sd8mY0TWF930oIuJyrDGAR7P82HtL/7NpGw6WniB44Yw71lCnKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jyr8mhil; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jyr8mhil"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1723600712; x=1755136712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qzwNv5D4HeeWvbcNhFqsUniZz1H9GQRMBjoDOliStVA=;
  b=jyr8mhilnYbt6RW+hCaXe/e9DS0Qj2f+M5Cl4W7EjEclzy6pDYt2d6Vv
   PQ9AkfJb91baQon/xOrrM3mB+em5bHOH5vUVInIaAdehDqcAuJApGwkbD
   gMQ8pZRTsEg+bshoeT7JpT34BTML8AYQAMdDCVZjh1dcBjZVCKGTK4Pkv
   bRoNhgHvbMaWK2O+vIJ8b2zo1LZak38w43g2y6ZY0XpOJHDQ/e0DOGotx
   py+sTIHP+0AVLqDxnmN9rkgXvoyTFHxSToUydru6mI0Us5oS0CVmJCEob
   Okhquk/7sklNe3WnLcAK6EA8yiOJe7klTNg9cu2twn57zdBxdfk3JiaF0
   Q==;
X-CSE-ConnectionGUID: HrAe6LUKTeqJUGMhdK0axQ==
X-CSE-MsgGUID: XQbwhORWSO26uYT1HUka2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="128344679"
X-IronPort-AV: E=Sophos;i="6.09,287,1716217200"; 
   d="scan'208";a="128344679"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:57:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lovM4zP8osCPsU58W0doh8cwcmKAlN9J5vqFi8J6XNHwAVV+YhvYrzhptodT0MhULK3OAl+ES/vRexjdUTrbWNefMvdWtDN7FnYqJ6wTtTu3rFoPy5tPisxKCeUEr5OQv9DUpZpntyJeWfyGLphhD1E2EPB0KUq6smQji9WoNCYucvyL67SxThpm3dkQTFaBU7F9/is0uIl9Oq2VRAww9f7viN8g6X3e8bSdeKVES3phklw5FUtiUmLJ+YkBOjGJaR1bWpUpFkqESSRPudKZtYtNmE1BYXaxcSue07TTbeeOCX5UKorDOCHZ4cBAirZkQKX9h+NQfcieKLxJNpoR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DTUT0gywbyqg9+mQ9RESoeSt/AlV6+U8MtdqXVKPhs=;
 b=JAFTjjEIyeGhgmAf5oACojiWW+cfVG2Ew2erTbnTcfpl7CnB5rppWfG9k3aRLY3r35Uay5XyxKu47bcMlW9QMZlxXNsZg8o5jsQbW1d5Z0YJy/2uzD77XYPHO9eyj3czdFNWyc+75J/feyyTLSwB/84udnr6LTPIftL23CDGn/Wr9ytcWbmP/BNNBkRLP+UZLVdMBzMjmJMNAk5WPlc0xbDb9IRpdYmryMVuzyTXkhakG8g3UoitT8lNFYNullKzE3jj2j6R3gearSd+Aud0ocIu1ammVT/icTiwxTLv7gSmvXKu3Nn/NeGK4LHgrY3dBmExIJcWHbDcO/R3MM0N6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB8723.jpnprd01.prod.outlook.com (2603:1096:400:18b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 01:57:16 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 01:57:16 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v15 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Thread-Topic: [PATCH v15 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Thread-Index: AQHa1zfZyJh0Y49NK0aKolaLH17KZbIfuHUAgAZwvoA=
Date: Wed, 14 Aug 2024 01:57:16 +0000
Message-ID:
 <OSAPR01MB7182A970075DC73C660E0DCABA872@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
 <20240716042540.89639-2-kobayashi.da-06@fujitsu.com>
 <66b6a574b9182_25752943f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <66b6a574b9182_25752943f@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=c1b805b5-7159-4c38-9353-0e5b56394881;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-14T01:49:59Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB8723:EE_
x-ms-office365-filtering-correlation-id: 1a59957f-7010-416a-1a96-08dcbc046c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZVcybUpuaDdqQjZsc0I1YnpZZUd0MHhOVjdZMjBleGh5YWNXdjI4bk1x?=
 =?iso-2022-jp?B?eEJlY2JQQmJMVE9XSmlSVDdiTCtrSEN0WFcxSjhsc05EQ1F2Q05USWYr?=
 =?iso-2022-jp?B?RU5PZVI4c2Q0cTlkbW1GSlBST29mcmNlb2RwRy9pSnJVM3hLSjAvSWN0?=
 =?iso-2022-jp?B?N1k2WEY5bzF4RWxmRlpmS1pDNGQ2YkxiSUhsMVIvbnFsWnAyOUI0MTAw?=
 =?iso-2022-jp?B?K2xmWk1hdGpobXhTOXIrbElIMHhSYzJGR0dXcXZ4RVc3NC9QQTNSQngy?=
 =?iso-2022-jp?B?ZmR5bEVCVDVEOXM0TFNCZjgwRkMvenkwVWRpRnJuU1hNaVVKQWNxYm9h?=
 =?iso-2022-jp?B?TnpBcUVRRkg0b2Vibk44V1lPc1NwQ1RmMW9NY002alBUbVh2UnlXeFgv?=
 =?iso-2022-jp?B?dTk3cDdTR2RrbWJiK1doalRGTFYwOGRXMytsT3htaTlkOWYvVGpyUm0r?=
 =?iso-2022-jp?B?MHZyeld5VXN0cEdtVGN1VE9qV1lFd3hWVFFOait4eTNNdjBGTURhdWQ1?=
 =?iso-2022-jp?B?dVNhZE9LUkdqY0dieUhuSEVoMXIwZkJ4Q2N2S05LT3ptYS8rNFFGWGdL?=
 =?iso-2022-jp?B?VXMwVVNqb2FmNTg2WkxmZU5nYWdTTTZ6Unp2aVlsSjI0VElKdU50Slcw?=
 =?iso-2022-jp?B?U05SYk5JK0toNVIweklralFlRHR5WDhDYkNQR2o3ditoYXlPbkNqOXBt?=
 =?iso-2022-jp?B?eGtpVHdNeDdaM0txN0RVQjM3ZTJBNEdCU0dLRjJlaDVxc24zNSt2SEZa?=
 =?iso-2022-jp?B?aWRMRWdoNU9YbEYxQ2p0R2RHWWVRRUdmck02ejgvZDZRbzJGWUpxOHl4?=
 =?iso-2022-jp?B?NExCMHVHdFhHZW9WK1NVUjg0WGFTeXg3dThvVmsyelh1N0NHbVd3K1dU?=
 =?iso-2022-jp?B?WFBhdFl0TUxFQnJPUlpPR05QUnFkLythT3hHUUgrZXFaSXRoaUkxY1NR?=
 =?iso-2022-jp?B?bEV5bEcxS1BvT1d2QTVtMUpUMk1GQjdjN2pTcldPeGkreU1CaU5PNlFO?=
 =?iso-2022-jp?B?Vi83R3hhQ3hMVWdGa2tuNDM0ZERZYlNXQ0xIMW5GOWd0cDNhb2FNTDZK?=
 =?iso-2022-jp?B?L3p4MmdNbXFEa1BMSWloWXhLL2dRQ3JyNEJGNmFvdzZDaVhNR2NTcUY4?=
 =?iso-2022-jp?B?U3gzQUlBOUhLdkQrenJueXhOZ2pEWDhHVllDanQzUkJ0Nkh3Z1dwK3NC?=
 =?iso-2022-jp?B?TjZOWFM3WXpsaGZnTGUwT1JQNFA0NWE1N0JtaE91ZjZUdmFTMzU1ank3?=
 =?iso-2022-jp?B?K2JDVy9SYXpob1FCRGZ3TkQxZVh0dFZlUHIxUzJFR3N4alNDaGh4RHd1?=
 =?iso-2022-jp?B?ekM3NFZtSkRWSWwvMnFPN3ZkNkVJYm0rbW5rejFzSWtoYTQrbzdYNXlo?=
 =?iso-2022-jp?B?UEh0RmNmbjU0bFVVblVaMVN5OHBzVGpMOFpkcmtHU1M5dUtnVkJQQUJE?=
 =?iso-2022-jp?B?eEhjOU1lcnlMclZRVWhicXA3RFNjUUc2Q0lVbGlhdExZYmZ4NVBIUzVV?=
 =?iso-2022-jp?B?ZDQ5MDR5bWl1dmdWRVRvMlUvZUg3UEZmbmxDRm9CSUZDZVNLNUNsMkdw?=
 =?iso-2022-jp?B?aTJ6UHRCa1ZDcS9lc3ROYVFDTHhoV01NRmhSb3BIeTlGSjhLSTB6ZVJX?=
 =?iso-2022-jp?B?OXV6VWVWUWJkeXlBN1VXcEJSbGJGZ2NabUFrVXZiakFlZTBNOWk1c0pW?=
 =?iso-2022-jp?B?OWhSRjJFcXFJSDd4T1hvaDdTTmVMRHRWZEZqSzY3dkRLMDE1REFIUHZS?=
 =?iso-2022-jp?B?RW9DUzE1Z3o3RlMyWmtSTjBwZ3lCcFJ3TU5uVHZhMm9DNWRuODFGOGds?=
 =?iso-2022-jp?B?VzlMbTFhTkgvMUpBSVhSZEhyS0xMc2F2OHpKQWxLZjlTZit0N2tBamty?=
 =?iso-2022-jp?B?eFh6T1pLejY3UW0wNEtwR0JsdzR0YVBFdS95TEpGMnZzaEE5UUVQM0xH?=
 =?iso-2022-jp?B?VEl1QlVVUVdsNDhSa284VDAvb3pueGlPd1Voa3VxSU1wTHZCcTlHZjRj?=
 =?iso-2022-jp?B?TFhFdWROT0swcStWTkdaUXF1ckV0eE5mY1FvSnJrc2dDZ2xjT3U0ZGlx?=
 =?iso-2022-jp?B?UFdlMU4zNU00T0xmQ2ZZVkpFUXdodFE9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cFBac2xoSzhhSE9CWndpc2xRR1dQb3pwU3Y1VWxGaXV3WndJbkRNUzc0?=
 =?iso-2022-jp?B?VVBRVEduVW8zL0d4ZmRrMUQ4Sm85VkkrTzRoWFh2czc2ZnhUQmFJaVNK?=
 =?iso-2022-jp?B?N1h3TkNjb2tpWWlWbVhISTVhZGJVTWJWZG1CT2I5ZHphdnN4SlB3ekZn?=
 =?iso-2022-jp?B?ajNOdWpad2YyWGQzQnE3dlJ4OFoyS0V4MkhSTE91WXY4Q2tPcDNjaGFw?=
 =?iso-2022-jp?B?MlBsbjFFY3g3cTd1djVYY0twTmc2R2Z3SnR1cEU5RHhPY0Z2bWM5U1c3?=
 =?iso-2022-jp?B?ZE8rU1M1NkhOb0FIMkd5M2ljQWpxazVRamx4bmo1NFcyUDdFclZHU0JR?=
 =?iso-2022-jp?B?QkloOWF2TUU1N29tTVI5TTV3ODBBQk1rTkdkdEVhaHhZa0taR1ByckFX?=
 =?iso-2022-jp?B?bjlBaEtGUlowWnd2VUtoQlBNY25FWWMrdjR3NjNJSUtOd1QwaXd3aklk?=
 =?iso-2022-jp?B?aTZNb2NtOWdoOWQxSHlIZzVPeURabXRQeTQycGtIR1ZiTk55ODVyay9v?=
 =?iso-2022-jp?B?TUUrVEVzaU1hUWNqbkU0SlBVWHh0c0VqazI3THJ6SDlDbGhXQ1hnOG84?=
 =?iso-2022-jp?B?YXU0eVB5TVpKK2tldkhSNUlIanN4c1dUTk96ZXYwZ3dGMEdkNCs3TnF5?=
 =?iso-2022-jp?B?NjJXUDVWL0tVbWU1OEpDcWUvRC91enpXa1AvM25LMllXQUdidk5DM0lD?=
 =?iso-2022-jp?B?aWgrMkxzYjhoRzdFTVN4RzF3S2NlRnNBWEYrT0QrbytDcTlKZm5IQ2oz?=
 =?iso-2022-jp?B?SkllZHREclhmNlBNd0djcGxvN2huM2x5MmRjbCtOeW92YVFURlNTKzN4?=
 =?iso-2022-jp?B?L2FpemRVYmtPM3FjSXJ2dTY0dFUxL2pXdWtLcjV1aFl4UnJ1KzdnV0ho?=
 =?iso-2022-jp?B?RXA2cGVjL2ZjdG9IS2JJOTA3dldRcUlRajdwUXRydHN6RG96TGdzWmt1?=
 =?iso-2022-jp?B?N1R3Nit4U1NGVjdKbTFQUUNoMFlYVi9KM1VMZ0xsK2Y3MUwxOWROdmhy?=
 =?iso-2022-jp?B?cXdST05VSXNYbTF0MFVacW1xWWIzNHBPd0FxV0lMdW9Na3hmNHNmV2RQ?=
 =?iso-2022-jp?B?c1R5MkNmOGpNbVlDRVhzTUNkeXZCTjRhYUhJM0cvSlZOMXIyRXI1b2Yx?=
 =?iso-2022-jp?B?U2JVNjl1QWFQYm5LNXBGWHU1MDY4dlNlUHN2cG0vTmU3Znd6YzZaOVdz?=
 =?iso-2022-jp?B?dmk4blJDZEUwSkpSR2JGQVY4T2I1UDJTcmw4VU9BWU11dzZtSnlhNnRS?=
 =?iso-2022-jp?B?MUszdTJhL2RQQlZWUFFpMTFCUWo4a1VMOWxCcDhYRlU3TkRPUWUrL0pJ?=
 =?iso-2022-jp?B?YVJaaG13T2dTUm5jazRWMitJWFhwbC81YUVkRlhtWWZmaDhNalRCZVNo?=
 =?iso-2022-jp?B?WHArV3QyNHRWL1lvN0VHU2VVbjdiQXlGT3NRUVkzVU9rdnhPRncyWTVY?=
 =?iso-2022-jp?B?QWpZbkVZTzh2QXBJRjZ6WldkazFUak90bU1MSEFscXpCclAzalFNR01I?=
 =?iso-2022-jp?B?NU9venNFNG1wUjJEc1ZVWXBST203ZTJKN05QVmhtU05URzdpV3hVMG9Q?=
 =?iso-2022-jp?B?dVRLL1lpbVBteFBMR0ZxOGRaNlc4WjFqQUo0SElzdDk2OW9UempZaUFD?=
 =?iso-2022-jp?B?MVQwVkREcFZqODRKM3czalJsb0R5Z0c0NTdnai9FUklHWjl6WW9iZzda?=
 =?iso-2022-jp?B?Yk45UjJUaEhaRkt3YWp1RVVzdjFYYldDZzZLMEo5MTNHVnVobWxhRTM2?=
 =?iso-2022-jp?B?ZHo1SzJ0VHlnbi9RNGZJaTRRU2t4K1Fta2w5Wk5DYk9MY2dMN3ZGd2o4?=
 =?iso-2022-jp?B?QmJLek5ac2lyTG5TczREcFE3OU1jM0NPNjVadVg2K1NxK1FadGpaQlhr?=
 =?iso-2022-jp?B?TlI5Mk5BeEpwaWNQYWRJNW92UGkxYWV3dUx2alBKSE9tb2VhTEQ4RWNz?=
 =?iso-2022-jp?B?V1FZdWtYOVZ5aXdxWGhQdm4vR0tTNjJyOXJZcGNNbjdhSWFPYzkzVkhu?=
 =?iso-2022-jp?B?TUJUTG5JTVVWTXFEMlhrVHZ2Y0lRWG1zRWtlK21MalJkVzRLWWlVOE5t?=
 =?iso-2022-jp?B?R3k1ZnRzTUw0RFNyMC8weTJkaWJQZlB4dEtCWUJvMDkrUlJRZ096K1ZX?=
 =?iso-2022-jp?B?TThIc1RpdmdmV2JKRDducSt6dnlZOUhmOHNzVlRRR0tXNGVORCtXVnpC?=
 =?iso-2022-jp?B?eTNPeVd1NWtreUx5emZ2ME0vbGdXNFlJUk0xTnQ5dUdPcllCY2k5WSto?=
 =?iso-2022-jp?B?SGlqaERaakIvK3RLRDF5d3JjOExHaEJhd09qZFovWjB2SzFSNmtyNS9B?=
 =?iso-2022-jp?B?UlNqK2RneTh4b3N4UXZyZ29JMmtPWU5Td2c9PQ==?=
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
	FtqVrI8LQ3hF6oZWBhRlyqH51mn4gnP5Q8R2ZT1zTOypL4wcr7PXgaihyO1gu9t01qurD1ZEzGr9IZmPQPTsyvgnTtZ62aQUl72xwIrl9UhjI90nFZTr0biZFFSArCVmm6Xy1mFDR8dv64NmKZ/s75A9szOS63Y9YVVTVdMB3JD9OFiI0GRnbQzFIz0UtCM4l3D8sOy9ljZG8vmLT+L5KE3rTOzo7jVVkT5eIEmwpZvVWyhwEE7CcgDvow907dNfbwIWicMYtKWRLLgUJwanJe90Ac/joYgcjnvpCNgfOADT6d+H6+rCz882xfh5YNeF4leXE/Enaf2RJ+MFHTpJYwfBBbzeZlaFlReLib7cfWkAtbMvD62ElRvylToztu3NCyPc+Y4gM9jzRcgzvGiKtUPRmKB/3gLPOBEDsktIOEyeB0snkEmKF+s4EM6ghbpAmO363lwQAzqatlxmweT7Z/l27Y8V5z21+mVKWfiTihCFAYBynBo+CnZHK0CEgwAD5h9cxnhA0mjqzGc5rDb3btW0sLaHprt+DAhE1boje0y+HRRzmkjj4uz/r5Ix3mZztxkHKU7yekalBlzarl89hiob7kLR7bTvQGT2kA+Hn4fmogz/z4RvRxETsa1on7g7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a59957f-7010-416a-1a96-08dcbc046c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 01:57:16.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hgr1etYbN5fAyZgqDkpMr6hPU5Fd8hRegiQMKVK8eu+vZ7XLx4cqjubpP3ahhezAECmbRd9k8GZbxlh34d5LX78ev8vkgE3Zq7S4E3tqPl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8723

Dan Williams wrote:
> Kobayashi,Daisuke wrote:
> > Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1
> > device link status information. By caching it, avoid the walking
> > memory map area to find the offset when output the register value.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> [..]
>=20
> Apologies for the delay.
>=20
Thank you for your review.

> I notice that patch2 has another port leak bug which means lets take the
> opportunity to make cxl_pci_find_port() usage safe in this patch.
>=20
I will fix the port leak bug included in patch 2.

> Fold in this cover letter update and change:
>=20
> "Given that this solution involves port lookups via cxl_pci_find_port()
> and multiple exit paths where that reference needs to be dropped,
> introduce a new put_cxl_port() scope-based-free handler."
>=20
I'll add it to the cover letter for this patch.

The following two issues will also be fixed in the next patch.
>=20
> > @@ -503,6 +496,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev
> *pdev,
> >  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_ty=
pe
> type,
> >  			      struct cxl_register_map *map)
> >  {
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> >  	int rc;
> >
> >  	rc =3D cxl_find_regblock(pdev, type, map);
> > @@ -512,11 +507,25 @@ static int cxl_pci_setup_regs(struct pci_dev *pde=
v,
> enum cxl_regloc_type type,
> >  	 * is an RCH and try to extract the Component Registers from
> >  	 * an RCRB.
> >  	 */
> > -	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> is_cxl_restricted(pdev))
> > -		rc =3D cxl_rcrb_get_comp_regs(pdev, map);
> > +	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> is_cxl_restricted(pdev)) {
> > +		port =3D cxl_pci_find_port(pdev, &dport);
>=20
> ...then this can become:
>=20
> 	struct cxl_port *port __free(put_cxl_port) =3D cxl_pci_find_port(pdev,
> &dport);
>=20
> > +		if (!port)
> > +			return -EPROBE_DEFER;
> >
> > -	if (rc)
> > +		rc =3D cxl_rcrb_get_comp_regs(pdev, map, dport);
> > +		if (rc) {
> > +			put_device(&port->dev);
> > +			return rc;
> > +		}
> > +
> > +		rc =3D cxl_dport_map_rcd_linkcap(pdev, dport);
> > +		if (rc) {
> > +			put_device(&port->dev);
> > +			return rc;
> > +		}
>=20
> ...then these calls to put_device() can be dropped.
