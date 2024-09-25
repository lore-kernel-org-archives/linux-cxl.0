Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F761304AB
	for <linux-cxl@vger.kernel.org>; Wed, 25 Sep 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260923; cv=fail; b=bFXXCqsu67L2zNQ6mBAfydwcgCzICgboOlImG8Ada1HQfixEtE2fJaQ0vTXfDi+XgSdCTQ76OTiNF1FG59MccEPalHRff88uXWLCu+jbGcbsc+czK30uSzS6Gyx/BqWOFmGUqtMJiyzsdvlvXV1pyzWlVLkEwN61F4RGvXSdIzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260923; c=relaxed/simple;
	bh=DgLs4Q98fM4tvFr2xxft4Z8yzt/TPx7TMFdINnwl8d4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dnz1e70p5+pro2eOFtpKQ6icoAWsldUVnzZIZJmtSlNJ9JL6L0cIfEYTTpp/ia/M2fcIR0TT7zOxD8053Zl/DnaZVIpouC9rxRIQvsxBld9/4w1YErBH58tB2Bjx7fZtp4g2MYJaGRv884sEIS2NnPDCBbUF6eh2niI0XbmtUos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bM5Cu661; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bM5Cu661"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727260920; x=1758796920;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DgLs4Q98fM4tvFr2xxft4Z8yzt/TPx7TMFdINnwl8d4=;
  b=bM5Cu661O500dPTjhiA1Fd4WGHniN07au6uhjlT67siB3Jo9zUIqTWLA
   iBcEcvTsAbe2+6QhLO5VsPgUmWuuuxeo2LXoE3sNrE9zqBKLyqs0ZWRWI
   pZEZNbmCt+Aer8d3hrSFHeScUE6tvWb2FHijoRKmuLPBMzf0r20UfgYKk
   ItTFRiIKN3RjhxsJBiVfA/7FvP7E2toAvypOx0kQyxERKLrzQSkhZdr+1
   aZFoDum0+ihbSD3j3eohIAs4bEJNDH1pmCMhzSBe0Ihl+FL3/7hdpp7sx
   183EcxINLvdAarIEKWDsBlHb7NyVp5/7Jj7ghOBwUWsD5k6I4wicJStrn
   w==;
X-CSE-ConnectionGUID: 3y6tz/zUR9Ks5AWSeRW+eg==
X-CSE-MsgGUID: hz+dkg8ZR0GPWIuVr6/sGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="132155460"
X-IronPort-AV: E=Sophos;i="6.10,257,1719846000"; 
   d="scan'208";a="132155460"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:41:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJ0ggCHbmnLHH1nWbsLTN3IV+HS49t6xMEKVB2NCXJTyveHTsCcQKTO4NBP8YUzsmVV40Ui/ILq+N8empyYA9KMwXtyiNp2qRLlnmfzs00fRpQYvaY3bKp5ow99j/ak/Z3OxDWQl77VqD/SR8aNwTyyRyEuDYbkOZOnaPVCKaJgAHDgQN4SO+GbVTWNIGaRpJRB6eNaSTKqcWcc2AsnuSVonERLw2OgMjrlV6r4/GDELr/u99Xv9ledKB+FK4uH0wmzUbsvC5oqp+NMBnIsWJJOFTVlquzDj6+Wyv9WsUg8edO8+zrJ92JuxJz1qs7N00DN1g/44PKqRcKbmk4TIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgLs4Q98fM4tvFr2xxft4Z8yzt/TPx7TMFdINnwl8d4=;
 b=phES2E1wkqaAZ1xxndgVGEGLBHGKRaT8zPsqgmKFG8lvqBxCchCch1tuB/rQn1bGqyGOIc+K546XVwf6F3YcokMlvxEHND1dDA3AaL6ziwK2pBEHyKLT49183TBo4gKncAx2cqb+oVGgN7PL/ZUw6YEv/jUS5YuSVsXuR3R/3wwnn7EwY3kBBvYafDI2PPSaGMzZHtqMTTlsmr15M+5Y+aipp4IMl7XE4QXRjkq5XJ5wpFxuAVxubr5XR15g9rocJ+vzqRJYqwMsn2MIlljoj3CCD/nuEjjbEgnhrZ/xFq07K7doCYb4og3tUQRMhg3mFCkRCfBQlLkmmEAWxCYOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 (2603:1096:405:105::12) by OS9PR01MB12165.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 10:41:47 +0000
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7]) by TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 10:41:47 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: How to start sanitize?
Thread-Topic: How to start sanitize?
Thread-Index: AdsPNO/G7a8YwYDJTi6wGIAzVUR10A==
Date: Wed, 25 Sep 2024 10:41:46 +0000
Message-ID:
 <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=243a02a4-527c-4c41-8d18-a068d035c5ca;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-09-25T10:22:58Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: ed1afca3785b46a1882d016fc135ed77
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB12335:EE_|OS9PR01MB12165:EE_
x-ms-office365-filtering-correlation-id: 7f2c87aa-620d-462f-3b84-08dcdd4ea788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?T3o0OEcxZXJOTy9aN1VLbjNtaEhFb2hrZndxMExqeU1FRHYzUDIxamM5?=
 =?iso-2022-jp?B?anJuTW1mUmdwZEFRR0hlb0IvT00xdWl5SldKNDE1SnYvUFA5cXgyWWZ6?=
 =?iso-2022-jp?B?QmljZm9wMnlRUmFiN3R0MGp5VDJkandhenpTWlppaVZWY2dsamhrY3Fy?=
 =?iso-2022-jp?B?YmZqQkVPa1VJZGhtL05CZDc5SFNzZC94L2lDczM5d05EQzBQY2J0VDJK?=
 =?iso-2022-jp?B?ZlQzVDBuVmJrckthN2NzVFEzSTBDUzVDSHgxVGFnZGdpcndLY3YybWFG?=
 =?iso-2022-jp?B?N3VJQkxqY05YY29vQmxCTXFrRmdXdTlkZldJeEpJUGZvRE04czYzRVA5?=
 =?iso-2022-jp?B?MURBTUZwaHZReTVoaEY5VGF2OU5EWlJhRXV6YU4zTTFkN1k2Mkh3SGRs?=
 =?iso-2022-jp?B?dUJrMENpcDB6dVM4RTAwSUtCcU5kQTh4NmFETEswY3RhT3ZucGwzVnFS?=
 =?iso-2022-jp?B?QjZWVGN0dlBROWcxME41SFdjRVljbWlHb3BBLzgrSks4bHErZVRDWGx5?=
 =?iso-2022-jp?B?QXZsMHcwOHBHdXo0eVI2Wk5aWXJkVEN2b1JOaDJ4bVlnMEdvSXJkdkdL?=
 =?iso-2022-jp?B?NlRxYXhNQWgzVVdTd21veFVDYVA5R3NaaHdXTTJJZ2dDMWNIT0ZaUzhz?=
 =?iso-2022-jp?B?RmZPVGZJQklvdGVxWWRsTU9pWWk2b3dQRjMwZWdCWlptZE1LYmswV2FH?=
 =?iso-2022-jp?B?VE5Tc3l6OEdwcHNGbzZMNmR3cDRQaU05SFlzZnQ2RTJaM2tiWWVqQ0xH?=
 =?iso-2022-jp?B?dHVlNVBYUXJFVndsaHR5enVGZ2c5MU5GMHZqSHZqQ2RZNEwvRnNKN25v?=
 =?iso-2022-jp?B?ZDRPYXZuZ3p5amVsdXFwaS93bGpOWTl6RnFudVVmVE10Wmlub01zOWFX?=
 =?iso-2022-jp?B?NUtzbHZrend1RTg4Z2I4a2YrRERVbGRUbDkwMm9hNU8ydE5rVXBhTE9R?=
 =?iso-2022-jp?B?TU40MjF4U3U0d1I0eGx4MkVVL1FGQjZXWVZkUE0wb1UrUUxTeWxKbzJz?=
 =?iso-2022-jp?B?YmhTVGFYMFBONzRuZUZOUU9QeDBTVFhvK1FvWGRVMDZqTENVK1h2czA5?=
 =?iso-2022-jp?B?cWoxdVFWWVF2c25zRTdoekN0TWVsNkhnNGNFMXNNMi90VzRUb3BNNlBs?=
 =?iso-2022-jp?B?eTdEQ1JiZG9DUWhlT001ZTc4S1M2OFM1aUkzd3h1U09xL0ZoOWJFazF4?=
 =?iso-2022-jp?B?ZGhDMFBmY05zZXR1a1JKYXBQNTBWNmZPNDRDRld4SXlwZEFrUHpyWHZU?=
 =?iso-2022-jp?B?d2hyWTQ5a1ZnMnU2UVRZM2RtUVd3TUplZlo0dE85WnptSnVhNDFVMkxQ?=
 =?iso-2022-jp?B?Z1E2VWZ1M2hqWDQwelAyK1Y4eVBjL3hFKzQ3Q0RHWGdwY202WVdmNWxI?=
 =?iso-2022-jp?B?S1dwOCt0Zmp3dTRoT080RmtLRURFamZ5blBjZDlmYmtHOFd0TkV5ODRJ?=
 =?iso-2022-jp?B?UWg2ZThCOEtvWWl0em9xYVBBcTZXQ3hhT0dRME5zdnVrTFJZbjNsZSt0?=
 =?iso-2022-jp?B?Ni9TekZ1NWFyNFVtTDBQenArOW9XR210b2MvVjFhaXRTNTlYdVJ3RGRm?=
 =?iso-2022-jp?B?T2kveVpVVjdBUzVYVDNCc25Zamk5VVh1QjlleDQrNFppQ3FwYzcyb3Z3?=
 =?iso-2022-jp?B?cWNlaTgwcTNpTjdEQWhyNG80bjEwZTVPM09HZldEYUVrUTU2b0hZdnQr?=
 =?iso-2022-jp?B?blJyM2lDdzBGZmc4cmNqUnJ0aEtlYXFVRGRvd2FTUUtYdG1pKzFmSkVB?=
 =?iso-2022-jp?B?blZDY0hlcUNoeDhzVFRzZ2xWZktZN1hhYlYwZFdCemFtL3RaTU1rSDR2?=
 =?iso-2022-jp?B?NHF5VDNXWC9jOEpIbytFS2lDcXhtTDFsaWNmMkhOTUNnZXZuajNET1RG?=
 =?iso-2022-jp?B?Ylp0dDNpWWVGT2RpTFdPbDJPQ2V2c2RTQUhjMHBvT3lwZHZzTnJQUUR3?=
 =?iso-2022-jp?B?cStiWGgyd2kzQ3FhQ2xQTk9LNnZmSjdLbThzVDhzVThEVnhBemxlY2RS?=
 =?iso-2022-jp?B?TT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB12335.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?U21SQVBIU0gvaU1GWHMvK3NaZVluWUtmU0YwOWxEU3ZOZHFWYWptRUM4?=
 =?iso-2022-jp?B?Lzc2QUpBK2NwUzdaS21GbTNEY2YxQ0FTbkdPbyt2MXJzZzJNOWFXdE1E?=
 =?iso-2022-jp?B?ODdhTVAxbEhGOWpMS2krcnhHeG9pSDNUQXFqUUNiNlFsRU5mdG1xNDVL?=
 =?iso-2022-jp?B?RXZmZXJFaEM0QStjcUtQQllCWFllbnptQ09jKzFsLzJLRm5vbzBlNEJS?=
 =?iso-2022-jp?B?eVhQelNoMjcrSjhIZVlaMFQ5d1Y0d3pjVWhVVlJTZXFvU0hVU092Wnhh?=
 =?iso-2022-jp?B?SUhZS0hKMndGR253RWxmdUZ3SDVxM3BqSE9VcUJDam45b0RVL3hLMHZY?=
 =?iso-2022-jp?B?TnBtYzM2bXRHTzFxcUV0Tklnd0pzRkxZNUtLbjJtQVNTcEs2anpIR3VH?=
 =?iso-2022-jp?B?YXlBb1FkZ3R6bGViR1hvZlArampUUXNBemVhbWNLS0MzZWpmV1FNOTlR?=
 =?iso-2022-jp?B?Ui94QWhmRWJ5TmpLQjk4NzN2WFFBbkw3TytsUHNZeGlxUS8wcHFwZGR1?=
 =?iso-2022-jp?B?TjZWVjBlTE0xREhUWEcrWDFqV0M3WncyUG9xM0wxMmFhcVp6Ym5VS044?=
 =?iso-2022-jp?B?TmpWYWQ4OHZzaDFLM2xXbEluREdZQzl3QlNlR2cyOS80MEE1YVF4K0h1?=
 =?iso-2022-jp?B?SFdEa29tQk1sT0phRTFrRjJ5U1h6am04dnZ4dCttdUhLUWFwQXdkOHNE?=
 =?iso-2022-jp?B?RGVpbG1oeTByYWRvekp1V1JmZWNIMHZYazFHcmxsQ2YxSUtFWFZPSEVH?=
 =?iso-2022-jp?B?RzJrT2k1RG0yTG12U0t0RG9McVM4M2xucDZWVkdDMGsrVGlzZlRRZzN3?=
 =?iso-2022-jp?B?NFhLd0dFVWZKTldJUk9nT0FESTFoT2FZNis5UmxvbS9KQy9PUGFvVGIy?=
 =?iso-2022-jp?B?ZS8yNU5rN2tKcHhmR2psZG1VaXBaN0drd3FLNGJodC9nUERlOXN5YmV4?=
 =?iso-2022-jp?B?NzdhdlFlUUlsZXJJeVo0dGI3Y0orcXJ5QVRlcC9UaThpNWNRZXZtVGdi?=
 =?iso-2022-jp?B?QVYrNzJZOGVzbkNBODN5S092RjdsQkR5T1pHbTlrTFJYNmFoRmt3b2wr?=
 =?iso-2022-jp?B?eFZ1SnJxSmJWMU9vMnpyZHJBQ281bVg5R1NGamc5OHp4aWpjQ0QxTUJF?=
 =?iso-2022-jp?B?Z2RyK29UdVBhNWYrU0tabFc1UDRpSlIydkZmR1RmNnF4VDRocTF4a1Jt?=
 =?iso-2022-jp?B?TTFnT3haOElyS1hiaUlid3cyRncrekZGR0h5U0FpK1dSMGl2cTA3REI3?=
 =?iso-2022-jp?B?b1pWWDlQWm9adUdKVUNqQ2t0eVRDZ0lSeUpEcHVLQW53N3NsT2tlY1Ra?=
 =?iso-2022-jp?B?Tm00K0RXMi90MVpXSmhCeDlic21rckN2Ymh3N1p5SnArWHp4alM4Uncv?=
 =?iso-2022-jp?B?ZjNVVVNSQlVKblBxNjR1WDhUNE9IRFJiajQxblhhS2ZuTzB2STc1ZCth?=
 =?iso-2022-jp?B?WU56MmZudEYvZkVNQkVoV2FSMjVKU0J6YjZIdjRyMmFLZjg0ci9KbFZ4?=
 =?iso-2022-jp?B?K3lVTm9OMDFQNG9KUmljY3RzVitFRjdMSHFjWTBpL2NNRHVOVExWWmt1?=
 =?iso-2022-jp?B?dWs3QStDTXI5QWliRnA2SzVQRTJDNVU2Mi8xK040alJEanl2RHdZd3dH?=
 =?iso-2022-jp?B?TnkwYmtUVTRTQ2hvUEZkNGpMNlZ6MXZBdGxrcVc4dStDRjVHRG01d0I0?=
 =?iso-2022-jp?B?d3U2R3Ava3h4enNKYkpyWDJKYzdTWExYR2ZrRzU2YWJxand5RGpXd0xW?=
 =?iso-2022-jp?B?TGkxeWU1NzFoK0k4MDRCcUZ1T1dFdVd1ZkI0YnhWT1BMYnRibzFSRWhX?=
 =?iso-2022-jp?B?YUhrMUVWV1h4dDZ1L1ZVWmVqemw1UW9TYlg1dnJIdmdsWGwwNUhWQVh2?=
 =?iso-2022-jp?B?VlNpaVhvbi9Mem9UWVlWTzBEdFJ2YWk1MGFFSEtsbjcyNzZKK01lVk51?=
 =?iso-2022-jp?B?OVE1RiswQVpDbGJ6NkNMQWZONmtNWFJYM1dhbDBTYWxuQU0wZDJXWE44?=
 =?iso-2022-jp?B?dVhhbW9GbG1ETWhKT0RMQW5CRElySU5XeHhaV01RaUN0b21jckMzcCti?=
 =?iso-2022-jp?B?REkvd0RhTFZOeWh4aGE5RldtU2xBVXd4c0JiME1DWnE0eGw2YVQ5QW9h?=
 =?iso-2022-jp?B?U0hwLzdlMEREUGZROHZKYTQ5aCs1alJKUFdwaUN6d3JPV1dkZXFvanJO?=
 =?iso-2022-jp?B?NkFkWS9NZ3hCWTlMRmN3eDY3aGl5SFJQT0ZLc3U3TjBCR3lweGpCM2xh?=
 =?iso-2022-jp?B?R2NnVmNrbmZkSHlhM082Z1BKd1VqNGJ4Qlh4clkwZGp3OUJuaWl4cWdv?=
 =?iso-2022-jp?B?QkFjYg==?=
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
	7QFBUPmkC/hsERq26PfSU4tVQJFWHAOeaGFnMvPvbSevSFNwrOrIa5lK8+VNLaZ6qPMUb3A0YQJ8icOMTCS5C3htWe0lPv7JozNV0qEqF6WCBEFRbTn2ve4FilU5WxiT8zGbPzKQKSgSl1XAJltmKkxKRy4iZNgzNLXe3JorvF7Ttqwz6C7mRs15CPSKjHuqsEBcF02ImHjpSLQ9jfNRRRQpFzbSkKlTjLf4YU1rPghcfADThoXJEH3WwdN6kGp08Gy1ldbLUHiD5lp2Ht97JPBpam1qOTfiH1ewW5ImfMOoqOvsjYrV8xYAuutcg0zw20zZZIuPMijx+Em7sKevjgDjU7ZYrFha2TUF9Ci/Z24uAi7Xgtz0xCoskgYg8edCCgYLpPHWQjX3Xor8PEdhW4uk9tYmcj5CRj8qGa3wsnSdtVuKhk7rEjEpey/H27VAmPKnUGH4OW/bMZZm9f53rVjZQXzekNOpN8ITvtJsZw6Ly481BcyVm4reJQsWi3xx5TdvaTm8nxnkoZragiZn2lwGc2cXt9pVZijx/psmIWJ7hisHPTzg+1FgTL6TjP6kF+gENC8mU+5bTgp10ytYQGd7PsNEuQ0eP9I3R42y7Nu+tJuXAoPCozQEWak8QxFt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12335.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2c87aa-620d-462f-3b84-08dcdd4ea788
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 10:41:46.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dICoL9BF/pza3BkcbkpMg6VylcKpG6RzrDp1kqDWDrXIzwS2tgv3NG+7uCQgnTrpJtxNhRm6PZXhtMy9D9u+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12165

Hello,

I have a question about sanitize feature for cxl memory.

How to start the sanitize feature for a cxl memory device?
Is it just writing "1" to /sys/bus/cxl/devices/memX/security/sanitize ?

I found cxl command has "cxl wait-sanitize" feature, but it seems to just w=
ait the completion of sanitize,
and not to start it. In my understanding, there is no feature to start sani=
tize in cxl command.

Are there any plan to make "cxl start-sanitize" command?

Thanks,

