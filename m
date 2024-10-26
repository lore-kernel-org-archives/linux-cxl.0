Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043431531D8
	for <linux-cxl@vger.kernel.org>; Sat, 26 Oct 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729934093; cv=fail; b=bey0ubFjsE6Cs1Ef6AvlYjQ/RFKGRlTkgSBJQy2+mIZWYXX7qOyMA/ocp2GGnGRE3OaRejlkYXOutrwsh7/7DLvePqGN7TVCyPlr9oiRmRcEARoGDlDQwSYklJ8MbAGZCMi85PShTvIp+ak1Wy29aP7xj7S81e1tbd/uZBSTb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729934093; c=relaxed/simple;
	bh=FBWioA5OYMe8jc5s162DNPT3t8HKKnqTHXfn5oUXyXA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nd6nSPrfTTutLMH+9LLCpZ09m47euTkAUG2XtggPBEAydQHktU/rq+BY7sWBqVRIOBEDYuEErODdTYgQvQgNsStfdHGLjez+5nQCyD4VZdcXEUfGymP/PYIYGxA9ZmIdAGmh6HkunJjAlw+eu7IBNVkDkJEUCVKyqO/d4t265yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JEePbVvI; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JEePbVvI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729934091; x=1761470091;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FBWioA5OYMe8jc5s162DNPT3t8HKKnqTHXfn5oUXyXA=;
  b=JEePbVvIwEBzzoC/p5qtWLx9YBkD+BC61jm2uRNH/ee4PSfsy40s9VPl
   5XgTCvXxvud8C2EEx4eHknQutxRNxF4LkpkDCcjLaBD/AXptfPOSxGE+f
   xxrXZmB/KMT3Iij9ujZ10Ym+yhO3jQEk1GNoBwF0/SdZIWwfem47sd9gA
   fHTSnWDfo1tOvHJ/wJTcObE8C5pEv/8Yrp7YcH9sh+lT95toMpjHASkcR
   0NHi3eB9vOmf272GsjPmHR0ISIAy7Gyx+dGrbPahZV3LcsGkRAPhZZVsh
   +vC5cEn6w26WJmHHSOOCtZuuUVO1EalUIJUSrC2ObX4CHE9S/SvlhBcca
   A==;
X-CSE-ConnectionGUID: guPOARCSTFCxZKgAYAhN6Q==
X-CSE-MsgGUID: 89rrETTVTluSibkXBRuBkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47882371"
X-IronPort-AV: E=Sophos;i="6.11,234,1725289200"; 
   d="scan'208";a="47882371"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 18:13:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubjrEotsmB2gqavXjepeuMYgtPY9+bBjtQkLWTmhsS6YMM3uvTYg0SblSJoIdMr7AI5jPO6mjzCcq5kbEc6ibTohIKS7JRQjeX+JBIzmd9G9KQ3+A3cIpPGLW9n2TQBtpH6IVc8TVnG+jBUP3uCZrqhl9lJVe7jVT0BQG0XXSOqOnrx+hJJY7DnRzZIwuzm2YFpedl66yw0F2SltwxyJGPxVxP3TiVPJp0++YqxNaKmCahPOVELrXNTqFHngP1Mtl/vrgu2UBMY//nC9pZw6bYtip5yXSSZfRYzpPX/pibhjtAy7ATPFDadlHDTBFpE7II8UUJHY7j//rUC+H6jB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBWioA5OYMe8jc5s162DNPT3t8HKKnqTHXfn5oUXyXA=;
 b=AnIRpQAdInlLcLqoF6/O89Dm8KvYAKRV6uvd1ceLRtBES6j5TlKddB6aM6AQbjwrpbqoNDKRnpyGN7QisGTlEzYQmRVPdVpnAqWF8CtjHLQmP9rABR3FjYXKvkxkZyF9SRImCFQMViOQG8wA3MqjkYGCxRneVhTSeNCGe6K04QbFV9nsFn44qSpLr8fiRhdYlcOH8bSP8Vq49Hb7wNjUK+FJhPdvYw+aeyIePPglFLUCe4YL0oUVvtA68tHCrymb8SzmSGgCOUkRjK7cpobQBJ93k9WON3ymCcURkiioGVTW9vyX0yWypH+D9Nt3JyDcP7wB44gOaMt8MJn5OUwrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 (2603:1096:405:105::12) by OSAPR01MB7231.jpnprd01.prod.outlook.com
 (2603:1096:604:141::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 09:13:35 +0000
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7]) by TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7%3]) with mapi id 15.20.8093.023; Sat, 26 Oct 2024
 09:13:35 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: Why does cxl zero-label command fail on my QEMU CXL environment?
Thread-Topic: Why does cxl zero-label command fail on my QEMU CXL environment?
Thread-Index: Adsjc7cNDaeOWzIhTh2tIzh5mef73ADswXqAAAZNTrAABKFIAAAMgZzw
Date: Sat, 26 Oct 2024 09:13:34 +0000
Message-ID:
 <TYRPR01MB123351EB7D66A1D1FE12B8FFB90482@TYRPR01MB12335.jpnprd01.prod.outlook.com>
References:
 <TYRPR01MB123355935A2E90A320934E3ED90432@TYRPR01MB12335.jpnprd01.prod.outlook.com>
 <671c10af9a6f2_10e5929496@dwillia2-xfh.jf.intel.com.notmuch>
 <TYRPR01MB12335AAF060E579DB251E4D6B90482@TYRPR01MB12335.jpnprd01.prod.outlook.com>
 <671c5a0c9bf80_4bc22945a@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <671c5a0c9bf80_4bc22945a@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=cd9cd4d6-0fc7-4e33-b0b4-46cdfe8a3b40;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-10-26T09:12:56Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 56c5de147dbb4823a64b34031ce0a981
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB12335:EE_|OSAPR01MB7231:EE_
x-ms-office365-filtering-correlation-id: d1e41985-53e6-484c-7570-08dcf59e782a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?cS9qMU9NZzcyKzBJUzd1dk42Zm1FV2FpOWRqNG84M3czZkdyTmdCam9h?=
 =?iso-2022-jp?B?N0dPTzkwb2xONEdmTnpjblhLWDcyeWJOWUZwY0VabDBGSU96NSsvcGQ3?=
 =?iso-2022-jp?B?b3RlN0xlODVhNTk4Y0pvcUV5UUxnWkQ5TzBoQWxLTVdJRWlseTZGb3JF?=
 =?iso-2022-jp?B?RDlHcTMyL1BGeWxKMEsvYnNJQTVnSG5TVWIwLzZPMkNkWk9rWmdISHA0?=
 =?iso-2022-jp?B?QWtLemVqTS8zVWdoUkxKN2l5K1Qvb203R2hrVUNVOGlFUDI5MmNtb21h?=
 =?iso-2022-jp?B?MmUvRWhMZUZEZk0rNFZpaS9jbUNUTUU2cEtsV3hmZmlmMmV0d0p3dlVt?=
 =?iso-2022-jp?B?Y0gxU0xnYndBTE5JUXlqT2ZGL3dEZEZ2c011YWtxR2NaSmoyZW5sS2F2?=
 =?iso-2022-jp?B?U0puQnNkTXBodDJleWNCVXFDMGJtQStuQ3lBQjZYYURONGEweXEwNXIw?=
 =?iso-2022-jp?B?Z3laaGdhVktkYTJmZ1NyeEUzOExQQVgrNkE5cnM3VjhOd3l6WEo2c1VH?=
 =?iso-2022-jp?B?Tk5yUVQvWUpkbnRuT1pFblFCZVV3S3pNNXdSUjZ2bXlFQ3RBbmZuaURu?=
 =?iso-2022-jp?B?N1lVRlhOY2VEV05EZkllRTZLdFdvcm4yZG1vYW1OUkhrTk9JL0ptb3dn?=
 =?iso-2022-jp?B?eFVqY2NoWnB5RzM5MTdMNk9wOHpMUUd3VDlqVEg0V3lYWWxlSkJ2OG90?=
 =?iso-2022-jp?B?N0lYUkI2NlhGZGMwaCs4dFZ2VUVLV1djQW5pa2pTQmpWV1VFTWFaRnZj?=
 =?iso-2022-jp?B?ODVWaE9DZUFkQXFqZjFUeEtwK0ZlZkIydVp2UmRNSVpRQlFaUksyY3dR?=
 =?iso-2022-jp?B?Sno4TXRWSzhFU0pZR056VWEvZmw1SkYwQ3A3WWN5Y29qZ0VxdEU1Vi9N?=
 =?iso-2022-jp?B?UDJySFdGWElVcXVDcisvN2dDeVhiaHdKRi9JM3FMQVpqWUpjajdpaWZY?=
 =?iso-2022-jp?B?VUtwSzlyTkdINnhWdjVydi9uK0lnM0p4NlRBZEYxMXdDb0hVU0ZnbEE2?=
 =?iso-2022-jp?B?ZG5Gb29ITzZ3cE9XVVRyL3ptSDJYVmpVMk9BU3hYZmdXQ3BFMDJzZHEw?=
 =?iso-2022-jp?B?dTBYb3RmN1FwU0l4WGJRRUQ3MjU3LzljekczUVNxVFhBY2MwTzhnNm03?=
 =?iso-2022-jp?B?Yk4va2lMMHRnNEZ6cTR0d2laeW1lRXlyZ3k1SmpvalQwMFpLaTFWMGxF?=
 =?iso-2022-jp?B?WlJ0NHdlb0I1QzJQbXpMcWd5Zkw2WHZLcFRERmZiVnVFRWNPN0l1U3Rx?=
 =?iso-2022-jp?B?aDAyU0tQTGFraVdoZ3FiN1BCVlltbTRnZVhjcEg2M3BWT3ZCUFlXMjhF?=
 =?iso-2022-jp?B?M3h1bi9ma2xmWWZ4aFNPQUZUMW1HMDlHYmo3M1RnVTdMQ3FDQnQrUkZN?=
 =?iso-2022-jp?B?cHkyTzA5ZHo3czM0ZzFIMlVoVFh0UU0yKzAzTW5QelQ5b1phSEJLdnlR?=
 =?iso-2022-jp?B?cHJ4T21BMmFnazNkaVpyZXdwam9FUlZOVXVzVGY5SzBPRGtHcFpZR0NR?=
 =?iso-2022-jp?B?NHlURTFCU0k1MDlrdzlyR1JjUTdKS3lHQTdrQjJNNmEvd0lhc0YyWTBC?=
 =?iso-2022-jp?B?OCtFL2dtbDFqZlFDci9XNWJ0UFZuVzBFMXd4ODhDaU1mWklwNndyL2lW?=
 =?iso-2022-jp?B?dlo4MlpHdFd1bmkyUDVnMWJQeEFocW83MzlMN2M5U0J4aWpJVVh5TmVk?=
 =?iso-2022-jp?B?NXdOMkdxR1REZ3hqS0dyRWh2TURWQmw4cEtna0FxM0JUSk5lOGhRVEFk?=
 =?iso-2022-jp?B?dk9tUENBelk3Uk9PdWhRK0dmYWNYWXBLZW9yb1JIbmxNVVZHc0hHN0ZR?=
 =?iso-2022-jp?B?YVMzY0NtcGNINmF1NDBVV1k5NWx6Z1FTaUg3U0duUkcvK3B1N0lIMFhq?=
 =?iso-2022-jp?B?WjU1L1FFVzd1bXdIQzJEeDN6NFFoc0lVWXd4UUtwcWJJRDdKSGRHVzg3?=
 =?iso-2022-jp?B?ZEhoa1Bya1hRaFRTZkU3Q3cvdlZwdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB12335.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cVRVOVQweUpZaTkreUlNMndMaU5tdlEra0NVVHhrSjZ2ckZBaXcxcjN4?=
 =?iso-2022-jp?B?dHFvRTZTZVh2dTN3elFlemNaaTlvUlZRNkM4VTlCUE5UL0F2L2lwV08z?=
 =?iso-2022-jp?B?Tk9YSS93YW5IelRKTVN5N0Z0MzFqUmVKVkREODM1UXY3Y0pGTFM3OUx1?=
 =?iso-2022-jp?B?VUUzc3NiUEdESUhodk90U2lLVlJiSFp2b1I2RExLc0UvQWlJeG1TUHZo?=
 =?iso-2022-jp?B?cVVtZXBsdFRJbUtTVkloVlpENGo4N0FzTW5QQ0FxT2FHOFowcDRFSHBu?=
 =?iso-2022-jp?B?WTY2REpVdmV5aE91VjZsdlJleHNzQlZIUE0yN2tCM2dBcU1saDllNHUx?=
 =?iso-2022-jp?B?NlFGWnhnNXFnMzJmN0JRT3ViY3Vidk1xbXYrNVFsOVQ3czFhQTdxU2lO?=
 =?iso-2022-jp?B?YXh1UUlmUlZ6WCtSU2Y1NXAwcVB2NmFMM3N2S0N2UFFvc3ZFVnpRc2c3?=
 =?iso-2022-jp?B?cUVQTklkdGNoUUY4N3BFRWg4Z29ZdGc0MWtrd3craTdvSk1PeGtyeStG?=
 =?iso-2022-jp?B?TXZVTGpRc0dMNVAxT0RPNC9mcisxV2FEL2UrQ0hCdVVUS2hWZ2ZMZmpq?=
 =?iso-2022-jp?B?UHNKcXY3YnR1UWpwV3pqeGhBN0NoQ1lHWTVuRzlsV3RLbkdLQ0xSb1ly?=
 =?iso-2022-jp?B?VFpOQ0tlcWNnVEpJclRUY3N4bDJQNlI2VTV3Y0kzWGNobzQ1SmsrSTk2?=
 =?iso-2022-jp?B?T3JvRUV6OXVFQW1GblhLb3lCd3hCbkNwbW0vZXZsQzBTWXp1ME1XMC9s?=
 =?iso-2022-jp?B?alNOL2Y3cngvaWtER2dLYXZPQmN4T0I5UzdNVTJ2c1kwRDViWG9jWTVO?=
 =?iso-2022-jp?B?QTBsMkhueXhhUjMrZWV2QUcwcFNEUU5MTk9LK1RjeEkzaUR5QW5WZkhq?=
 =?iso-2022-jp?B?blhSdEJyYUx2bmV1dWZDYlFiNzV2THhGT2NueEY0T0xmTUs4aTBqcXRX?=
 =?iso-2022-jp?B?Q214M054T0FZajBLU1dPOXdKWkQ2K0tJZUtGTTdsSkNmTVE5MWlkWmNa?=
 =?iso-2022-jp?B?Qkllc3RUT2QxWE91VDByMTgxZ1NvMmxWV2ZmSUM2cllCR0NFcjR2NjRB?=
 =?iso-2022-jp?B?dXZVdmx6UG5zbUNIK2FybVAvS2xqUXNRbWVneTU3UktacHcxeTl5Mk1J?=
 =?iso-2022-jp?B?a0IxNVo5RXJEaEYzUmlaRVpQblVzOVhaclA5eG5EZEpKOGtqNmZwOVIy?=
 =?iso-2022-jp?B?bGtnVUFkOVZiOHVIaW9GQXpQeGZQR0dlZmJSTHpoOFFORVhZNUtNdXZz?=
 =?iso-2022-jp?B?c3lTQjc2dEt4RDRkQzQ1R0IxczhWTmRNdW5BM2hlWGhsRXBqdlphVTZ6?=
 =?iso-2022-jp?B?dSsycGVLRlRVMDMrbkJUbnFLZkpzcm1EQkx5YzFSdXlOOVlNSWNkZlN4?=
 =?iso-2022-jp?B?QnltN3dacExJQ2liRDg5SjZESUtqdnBhWW9WcjM5YnBXZnBhMTM1Mkg3?=
 =?iso-2022-jp?B?YVNiZjVrVDdycGFjc25QTHFXK05Lak9STjlDYWpqakkxZ0x2YVFyM25P?=
 =?iso-2022-jp?B?VHVhMW5tMDRRWFlndkVkNEdmM1JKMmVvV2kwZDA3RUJLTnZOVGd4NUs3?=
 =?iso-2022-jp?B?bk5GcWQzbFE3UU5lc1cwS2RHNnd0V1A5M3k3dm4rN041TU1kaGJZZTdZ?=
 =?iso-2022-jp?B?MkZXeWdRUW5MSTJaNE03Mmt4djVKWGRmRllGMU1acSszS0lyQVhGclE3?=
 =?iso-2022-jp?B?WkhFdW1qZlY3Tzh3SGlzUTh5Vm9VOTlOSFBuRmVKZlBYVTZORG5iTG0z?=
 =?iso-2022-jp?B?R1pPWm56Q216WHRacTQ0eGxHN2FqcnlZYzZjbFkxdy9rc3VjQ2NSTUR4?=
 =?iso-2022-jp?B?enRQY1E5L2tDdzRqS3lNMWNEbFVPaVowSzBsVmNJdDBhQ3ZZSTZJYzI0?=
 =?iso-2022-jp?B?TUU5SnQxRGtZampsU0FuV1laM0Y4UW45REJwUDRQR1hBcnJQK1EwNVlC?=
 =?iso-2022-jp?B?TjJLUnJqTXBUMktPblFrQkc5dnZONXhKS3pHdkFtZ2RYcFdsRTR0cHB6?=
 =?iso-2022-jp?B?U2lIR0hDd1VFbXNzMlFJWDl6aXQ4NmlUODgyZlJoNHdUUXp4V2EzYXRG?=
 =?iso-2022-jp?B?emJtNlM3aFpSMENSRnFEK1Y1RmN1VEdDNFVaTXhsRUZpcGZaMDZIelZl?=
 =?iso-2022-jp?B?bkhBOE40Z3IybEZWUThBQkZsMzVmeC9sY0tMamF0QThYazhuS3dCZmh4?=
 =?iso-2022-jp?B?TDVYOSt4dUNqLy9sRERWc0F0VVhwWVJBRzY1WmZQZ0xKbzRRWnJVZjY5?=
 =?iso-2022-jp?B?eHJCY1BSc1dzeTlYRlJWWVZ4K0VVQ29aQzEvM1RyRnl4R0V5bTF6dUo2?=
 =?iso-2022-jp?B?VTJ0Qw==?=
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
	2zLG+7ijzrhE6oGmgThQlYLBYg2Y9f4xDsngnZJ+pAtefTyc/IcoDiDM7JjSgqRN0C3rQnDpmKDRrN5jbxHMtLlMYcWQYU0EelO0aMB01kmRJQlrK/HMjjubZ/TExcgb9sqyJz1O8XEP6LFExCr5k7/FmNcT+LIsvbykDE7D48lTmsGItY9ZWYBxQEpkQWIOEiTv1cUwz9ACXamAzUezod9F2gakw6Irx8ZP1Wx8RkFcxg4TpXEHD3tjnUdruxntEKMXoygG3mI/4+grg29EIA2Un2eSMXVewm1A9O3Bcl7FJkjkjYNavBYmM/Ko0Gwm7A3bFonvOkRui97joBImsxzdzJOpIERBVK9btNuJ6q//vU4Y9Zktlwyh1jjLNNf50hntglvNhUIr/QSsnkaOA1Q9/ogG51IQLVL4mBXuc9/azFOQTCbrr8hymzIFPHS6eiBFPu+D9fOHDsz7Zkk8t+QrfNNGWC9oztQW/wQW4lcvkmcSSoSBeO2vIrfMS18j7iAyGxgVKm+atj/StHoKh0daczX2DG3iaE1I9UQ1Yc91Sxo1XmRSniSe4bGY9Uyzf5KyHv7OonJm45N4LhdwphGxbzq5oqT2JNxsLYy3QifZcS1fXBHJ2ZXPojhCZo1C
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12335.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e41985-53e6-484c-7570-08dcf59e782a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 09:13:34.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGAzieRAlUTbcSF2jnhzE3POKjXxKGjk0lcAJ1mz3CAlJ2YnBSoVgCx0CJS9vcEwlg/Lcqe9ErDrzFJK51P3jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7231

> Yasunori Gotou (Fujitsu) wrote:
> > > Yasunori Gotou (Fujitsu) wrote:
> > > > Hello,
> > > >
> > > > I'm trying to execute the cxl zero-labels command for a CXL
> > > > persistent memory on my QEMU CXL emulation environment, but it
> > > > fails with the
> > > following error.
> > > > ----
> > > > # cxl zero-labels mem0
> > > > cxl memdev: action_zero: mem0: has active nvdimm bridge, abort
> > > > label write cxl memdev: cmd_zero_labels: zeroed 0 mem
> > > > ----
> > > >
> > > > In constrast, ndctl zero-labels seems to work correctly.
> > > >
> > > > ----
> > > > # ndctl zero-labels nmem0
> > > > zeroed 1 nmem
> > > > ----
> > > >
> > > > Can anyone identify the problem?
> > >
> > > This is "by design". Once the memdev has been registered with the
> > > NVDIMM subsystem then the expectation is that label space belongs to
> > > the NVDIMM side where it can be coordinated with namespace
> > > management. The ability to write labels from the CXL side is mostly a
> debug facility, not a provisioning flow.
> >
> > Okay, I understand.
> > However, I suppose it might be confusing for beginners.
> > It would be nice to have a document, like a beginner's guide, that
> > explains which command to use in each situation.
>=20
> I agree, just the small matter of finding someone to write that guide.
>=20
> In the PMEM days Steve wrote a book about using PMEM [1], and I found he =
is
> also producing similar content for CXL [2]. Not sure if this specific com=
mand
> submission detail is covered, but his name came to mind when you mentione=
d
> user guide documentation.
>=20
> [1]: https://stevescargall.com/books/programming-persistent-memory/
> [2]: https://stevescargall.com/categories/cxl/

Thank you for the above information.

To be honest, I have time to talk about "How to start CXL emulation=1B$B!I=
=1B(B
at the Open Source Summit Japan (next Monday)

https://sched.co/1jKCR

I included a tiny note about cxl zero-labels, and the URL of the blog in my=
 presentation.
I hope this will be a good start for CXL newbies.

Thanks,
----
Yasunori Goto



