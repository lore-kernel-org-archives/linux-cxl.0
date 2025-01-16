Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9286E15665C
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995186; cv=fail; b=f8vwLIVevBUytsVpM6i+B9os0fTZ8XOUrmtsJ2887VZxstDro7ui2Ug1+7HS3DF/qkPS9m6nDiwVayWZlEgSrXCbUtNG3dPBGFY15edeCCcyI0WAwumaNLZmdJWBcZ4+EfAaRAqbMSctiR/odBJH/WYioyq6ix8xI1/fqbVfWWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995186; c=relaxed/simple;
	bh=zxvPIMOt5IFKwBmYs9Zu4CiR/ZO+1jtaP8WSozJS6nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPlZyEIT8swkPaKXJQaKBDuwMGgUM14WPOToJVKMhO8hJS9K6Hl0PoM6P2eP5uC9+bLJuAVYpc+4Zwh9FKmuctWoVR8kdmD57ShWfF8IkXgAu3QEaEuNdx3MMoD8rWrKyvOjC/4zbs4Eui0N7+4FS7/xVcSSodwgV6AFC6MnfOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PLXj/jus; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PLXj/jus"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736995184; x=1768531184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zxvPIMOt5IFKwBmYs9Zu4CiR/ZO+1jtaP8WSozJS6nk=;
  b=PLXj/jusSmDCIFOQg9ia3KhaXCGLDxOG+xG8wgvZDmWB9aX0ci8jM2uU
   ebAih1l8tcaDStacc3zjtx8/c4Kr4TFr0qmcit9cG+jpYBgR3L3xGXzFE
   QEM2UaFT+OGHzc6j/gnO5weYZ7VE31RxFioTbQsZ2Xl9H/COW33WwvOje
   aaukmyq7Tb6tNio4m/y0/OtOKUpvqEc1GM/vRthmx+HeQ5rPxAZA1E5pp
   /5vYwpYLVFgcKUYChU4YeV9+g04fKNDOvy12nA4vyGoud3/mil+lhceAr
   H3xnrlO+WjWEvx5hQ5KXoO5eJy9T3aeopkX1cckgBTvD2heyVu91ZJkZ4
   Q==;
X-CSE-ConnectionGUID: Vae+eFVbQuq+gF1BhkOuLw==
X-CSE-MsgGUID: gxjonHgpRQWxFYE7xZfPjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="143467179"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; 
   d="scan'208";a="143467179"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 11:38:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM0MihvHceq5cedljfFFD/naCbt97I1+L938cRm3MO385fN5QvDObbtMY6dTxy3Xn9ximB5Z/8tCjN/rdEinSoOpc+8w5llS4iKdVpMZpNRzFReB79GdwINHuL9MD0bkLxHxmHFXaxqcel8ATc3wu9oFAJ3kWZV3y3NO2JZtvzmpuibAZ5qO2u8PTJKEUA9C5i6zAh8K9pdiHksyCSQaSbPI658yVaN2hob1e16ii4SO4xHkTeDlQduHMLk09sAPM1TwX7YFIM7gZsa2RZgV1a5ULAQDSIHIz8AnuWUO73OHJ2UXY4FB9MFokhdQd/xc42pQtnxoLbGIJ+aEGm2WAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx55r7qWM+CTcWI9Bk6RjeFZAJQvM7VPNiTVE89TIAo=;
 b=Nl1bWwqWvTRtEY0VPz7VZlojy3kz2VFpxsUb9OnmCHSe/889yWTIg5YZmB2vZUe6cJGFCUotnBzuCLtwVGuvfIeKp/DGpLVkiyj5nBZ3sN4Y8ieynr6/I1aekqDZO7BFTBFuZ+QHgn6Ys8JhB1VXSFs/bVQK6GBsWEtYO2QK63o0C6kzLl4x4ogV1N4V//+oGoPZ2Kd9CrnV3RWIMx1zDa3S7PE3DTip6hIWG4je5SrDOvTuGDXrUsyTw8HlN25iiWPbdq9IY6Z6wXTb/+u9/7/MZN8BMUn/MPr038bFmqPkeehIz7TPrJE618b1zBXfJFDT8esimrgGAV1YTclnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by OSZPR01MB8612.jpnprd01.prod.outlook.com (2603:1096:604:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 02:38:29 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 02:38:29 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "mj@ucw.cz" <mj@ucw.cz>, "Daisuke Kobayashi (Fujitsu)"
	<kobayashi.da-06@fujitsu.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: RE: Unable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Thread-Topic: Unable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Thread-Index: AQHbZzmO2fNEPH1QE06FI7LAAbpIwbMYXvQAgAAsQXA=
Date: Thu, 16 Jan 2025 02:38:28 +0000
Message-ID:
 <OSYPR01MB5352795A910A843A64D4E61A901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
 <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
 <OSYPR01MB5352F167B18CC4DFC908D692900D2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535257C0AE84CC123A656E1590192@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <67882c522a8b8_20f32948f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67882c522a8b8_20f32948f@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=514a87ba-cb1d-40ea-8479-bd9148d4ba58;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-01-16T00:23:13Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 3fa8e4f1188048e8993afcb955469437
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|OSZPR01MB8612:EE_
x-ms-office365-filtering-correlation-id: a992081e-21c4-4e24-e634-08dd35d6dc32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?OUhMZmZSYlR2SDZCZ24velR6YVJiM2MvOHhHVWpWNHp1OC8veThUMm13?=
 =?iso-2022-jp?B?K255YWY2Q2RJSmJKVlFabFlMZlEwc0Ntd2ZJcjZRLzlmdnJJTjhkeVpZ?=
 =?iso-2022-jp?B?RnNQNEh5NnBxV0paYWRQamV6S2hyNTh1RFpjMEI0WHAzdUtIU2R6N0dp?=
 =?iso-2022-jp?B?VXBwSVVzNlVRQzlLMU5JNEx1cU1PcEJhcmJlVU40WlNBbFAzWUYyVFor?=
 =?iso-2022-jp?B?UDlCY09vSTRCTE5tSjUxMXp0MEt3NUp4TFNGcnZ4aXZaSFUvbUtsZFdn?=
 =?iso-2022-jp?B?OFJVTXg4QmFUSHpFUWUvVHY3WFRBQ2VLTDF5UGxVekozYTZoenhleGVM?=
 =?iso-2022-jp?B?LzZXaG1nL1FUVUdFWWE1T29KTUlFTnRuM2t5NHlxVCtMaEIwU2lVMUNM?=
 =?iso-2022-jp?B?VGFjbnBPTEhNcVdjdERZU2RiL2FzN29pU1JzU2RSUW9SM3RLVGVOVnFQ?=
 =?iso-2022-jp?B?aVhsNUZpUXVvcWxCNnZ0LzNVbnd0d1BmbkdoaWg0dnNGL0EyVks5eGhm?=
 =?iso-2022-jp?B?VkNRRm1hNkQ2TUZLa2JQNmxKM2tpK2pDOHVxRDN4MVEvOGxsVExITlBq?=
 =?iso-2022-jp?B?OENrTExNYm03TVBVeTlNTFJtZnRJOFFPdjE2THZMODhkZ05ndlduM1Mv?=
 =?iso-2022-jp?B?ZmtXVStFSmZVSklxcXR4QzVoNGVQQm9qdm0yOVpGN2VqRXh2bnh4NkdM?=
 =?iso-2022-jp?B?bnhuSGZDZkJzZTFOOEsxL0pla0VDcHZsNFBoejdaUmNTTjI3RW9KNkJD?=
 =?iso-2022-jp?B?VnZCb0phWkNPQnRIdUZTeUdsMjA4aWJKUnlpdTBFejhPKzNQZzdtWXNq?=
 =?iso-2022-jp?B?amFkaUk1cjZFK3RlTXI4K29WY3U2RkF3c1BvRitVSk5IUi9xWFd4Rktt?=
 =?iso-2022-jp?B?SjZrQ3ZYbk9pZGJZTElUSnRzbnh3RTA5RjA5Y3lnbGVMOVdsM0FLRlAx?=
 =?iso-2022-jp?B?bXM1ZmZnMjlaandCc3E3OS9QSzlNMXIzMGg1alIxNDdySHMwWmNLVm4r?=
 =?iso-2022-jp?B?ZldjZlZ2U014U2dieGhEWHF4TDdiV0haQk4rV1c5S3BsM0x5K0d6Mm4x?=
 =?iso-2022-jp?B?amVRWTk4UzlZMW1GZkl5UXZwaEhLbUFPNk1aRWs2ZjFvcy9HMlpKNHhD?=
 =?iso-2022-jp?B?NG9BUjlNQ2hTWG55cGdIanVVenFlM2ZvUEQ0NDg2WTNRRUlIMGVWU0dq?=
 =?iso-2022-jp?B?R0VUNjFSZmpuaUFDMFkwWDdBSFNBWHBEL0NWTU85ZHRkRm9FZlk1WWNa?=
 =?iso-2022-jp?B?aURLOHMrTER6ZmlwSkpDYlRhZE9tZEd6Z0NGOTQrdUZ0TVZOdGJNR3VU?=
 =?iso-2022-jp?B?M1Rpb2c0TXdhUjJwcGRUSFkzM215b3J1aGpYN2VYeFBMS3Fmck03dGJI?=
 =?iso-2022-jp?B?eGdqQlg2NEU2SGU0Z3gzWCs5QzJxWWpqM0pNMW9xUk55TmgyeHc2NXFt?=
 =?iso-2022-jp?B?aUh4N29WYldJZm15dS9ua2tBWDVuUVFkd3REMmJOdG1uOEdYNEFBaGlC?=
 =?iso-2022-jp?B?eU5ENHNraURIdURvWnhJK3FGWEM4SG5ZSldKd3ArWDBJUnc3V0E2amhI?=
 =?iso-2022-jp?B?UjRhdmlIbzJ0RThVZTRzenlYckNoOUQzdXN4R25BUG5oSEtoRVZOaS9Z?=
 =?iso-2022-jp?B?a2t5V0ZoN3FTa1pBY2lPa0xKRHRqbnZLdGlTSCs5K2o4aEhDeXV3TGdL?=
 =?iso-2022-jp?B?elk0c1FQME8xS0psbStzMDVNZ0M2SDVURGVtQWRBOENqY2FkQ05PNXl6?=
 =?iso-2022-jp?B?bXZxVHFCaVQrOXZNbzFJNjVsZTg0WURUTnc2WlBvYXRVMWpWMFAzam4r?=
 =?iso-2022-jp?B?WDFRN2lpSnEzazEzbDRnU0Joc0ZlQitXM1NnREpUYTJJSUJZZEs0S1pL?=
 =?iso-2022-jp?B?eWI1N1V5OVI2N1pzNWZHWWlWMDdmRHJZYUVBVWIzVzROR0dqVEkvM0xU?=
 =?iso-2022-jp?B?dndyUTBvdkQ0WnBUNmUyMkhKVXlHMmRJazRQckJiSFlqbWk5L3Bxd2R4?=
 =?iso-2022-jp?B?Ymo5ZkNOTjh0bmJVaU5nYm1panZoYysrYkhyMjNiMkhyNTBSNDIxYzhU?=
 =?iso-2022-jp?B?TlhLQ005TUFiWlBUanExMnZiTGpCWTR2Y2R3MXpYaE9mRUlsVmpIb3Ru?=
 =?iso-2022-jp?B?a1dQYUFlK3Q1N1luV2cyQ3pIRTlNMnlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cjdTZDVnS28xL2MvYXZEMk5tSkhMMGJjb2hOdDNPTzZIKy9FMVlIK1Fr?=
 =?iso-2022-jp?B?Mnd3Q20zWTBpVWtVR1ZNVUR2WS9ITEppMFkvRVlDUkQwNWd5NEdWQ3NO?=
 =?iso-2022-jp?B?STRDSnhWYjB2dmNFL3JIQU9vRWk0bTI3OFhsRTUzakp3Yk55UVNxWUpL?=
 =?iso-2022-jp?B?VW1waXpwZDQzMTJ5Y0JGUFhHRHd2eHgxMUtXUXhoQ3NGTXIxVk5TOTNt?=
 =?iso-2022-jp?B?em8wdDNmYU9IbS8yYXJLeXhRZXVMRnhxa29VMTNnZkl1WGhHRWFIdW1L?=
 =?iso-2022-jp?B?R0t5eFhYRTVlNm9DOVR0cUJvQlgvaENpZzNnTUgzajRSTHlwbHkxdkNW?=
 =?iso-2022-jp?B?RE5NTGljanY3K2lPdXZROHVWeU1PeHZkUHhodWM5cDMxLzRmcTd3bFE2?=
 =?iso-2022-jp?B?ZkhnbjhuZFlvTHRVa1ZJS2ZXN3pLWVN0VXJ4a0tKbDUrdldhV0M4cTRD?=
 =?iso-2022-jp?B?REoybzNHVEpFeDY5aHlaeEdFMk42a1hEZSt6bkN3V2pBNWorejdlL29M?=
 =?iso-2022-jp?B?a096RThSeVBCanVoQTF0VVl1QStEOHpKa2kzYkwxOHdPZFVxUFc5Wi9Y?=
 =?iso-2022-jp?B?Nk5tRHVvaVJiaEhBS2dqcEd0eTFRNC8vVWxHbjNRaVBDV3VzQWdrckdT?=
 =?iso-2022-jp?B?VnQwTFBLVWxVTERXa3Z4dTlZZTB5dERHKy8veUNEbUJ4VDVTdW9abWFo?=
 =?iso-2022-jp?B?aWNEZEkyRVAvK0gxemlhS3gyT0lEeW9ENnR2SWZzZUZPOVpocFZNK0lX?=
 =?iso-2022-jp?B?VHdMUWpFaVYrTDBSM2NrZjRQd1Yvb29wbnkzN0IwaXNPSXFmQTcwRExN?=
 =?iso-2022-jp?B?Rk5FRVkwR2RlRTJYWWFxSEowWWd2TFdtdmFhbG9rZGptSXR0c1paVlVS?=
 =?iso-2022-jp?B?SU9kMTV5d0xxcDNrTjBiNEFNM3hqS29wUEVjVGU3V2UwVld0VTNXNGI3?=
 =?iso-2022-jp?B?VDFxRCtyTGw5U3E2cDBDVElxaXNaUkJMU0pNTUpyamp4SEdWeXpWdTMz?=
 =?iso-2022-jp?B?aTB4S2xPZG02aERCQU9TbGRFMjJ5Q1ZVN20rK2gxaFBqUHhaSkpVK2Vt?=
 =?iso-2022-jp?B?U0lpN1grT2xEWTBUT3B5K291VnJ4THYxWC9aaE0vOUdaTjFGV1gwZ25y?=
 =?iso-2022-jp?B?cXBlbWVDTUpZNXF1YUJhaWRIaVhlSjFiN3BtbFhDK3ZaamJid0NYbEhx?=
 =?iso-2022-jp?B?LzRqQSsxenp0bSs1WHVDVTF0QmtKelAvRzg0T3crVGZZeVBFOS9FOG5x?=
 =?iso-2022-jp?B?UVRjbTZ1WnNzZ1F5b1F0Wk5sZXlKdmU0N3NQVngweXZUU3Bha0svWDRZ?=
 =?iso-2022-jp?B?dklzc0VyQjZWZVV3aWp5TVZWS1RQR2VpVGVnOHQvOFU2N2t2Y1F4eU5O?=
 =?iso-2022-jp?B?WEZoS2lFV01WQ214ZGkyRWhUZ0czV3BtT05JNys5d0s1bWlBSXNTRmIz?=
 =?iso-2022-jp?B?NDNoVDYyb1BXT2VxL1BST1BJd1V4ZXFhTG5YTUNSSXpucExleDNWVE8y?=
 =?iso-2022-jp?B?ODdGa0lLM1psT2wwaUV0clhKbXhndG9Qci9RUTB6eTVheDBsZ2c5STVP?=
 =?iso-2022-jp?B?U1hRaVo3eUMxcHRCbzRuUXg1WEk5S1Nsa0RSQS9MSWgzM3ViWE8veGEz?=
 =?iso-2022-jp?B?SlpiTWtEZ2x6eXdybzVQZE85U2dpRHpoZ1pneEwrVGJ0VHhUTGN1elo5?=
 =?iso-2022-jp?B?U2hydzV2MDZ3anBOaWd2MzlFMGdQeEJSbi8wMkZLcjZPVGpTMEltUWhB?=
 =?iso-2022-jp?B?bmRXTFVxMDBRZXVSMmRSUnFUYmtDUDg1UDF2dVBUWFdtTDYxSHNBOS82?=
 =?iso-2022-jp?B?U0UrU3FKbDNyTUMzZGRkbG5GV0c0WmV1RldvTjZTWTFaSkFic3g2dS9u?=
 =?iso-2022-jp?B?K2p6eFJMeEJrbTBTZDErVzZZYjN4SFdnZ0RMTDIvQU9CN2VEdWIzTXQ0?=
 =?iso-2022-jp?B?YTRpSE9CZUp6d0JmdEh0clQvOEVCOGVQVTdDMENZTnpQMTJwd2kvWTU0?=
 =?iso-2022-jp?B?OTBVdnIzcWhKZWpTdnQ3UE5nckFqVGxoK2JCamkxSGYraTR2cWpmc0dG?=
 =?iso-2022-jp?B?Ylpmc1FEMlBTSGJqQjZLdVhnMlZtSkVIQUpDQlNIaWFBek5YVmtKS2NZ?=
 =?iso-2022-jp?B?cGt5VWhldnRUcUZ4d0xjNEdlY2hGRFRIWkRqTVVQb2tNNWlnQWNKOFZB?=
 =?iso-2022-jp?B?YlQ4SlFHa2x2eFVwY2JrV0t4N3V3MXdhdGFBNVhWL3V5TFJnbm1odTFh?=
 =?iso-2022-jp?B?cnZHK04vZkxiS0pzazJtSUxORjFXVStDREo4SzdTbTVXVGZ4TmNmeEdl?=
 =?iso-2022-jp?B?TUNScg==?=
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
	7sYxYlfKuk9+86w94xARNl6+J1rrfs0zsRBgI/HFU7Zey8Iv4pK3QsA+cZh5tjGwJuPylLRw3G79PhQNdE2fwcYWUxxf43xe4hccltz/iC3C+/EKfyRDVD1wjY1rep1B2v/Vzz2s0J4yrqWa9LKyzP1sX/9QX2lq6nfN2TQpvns3W9740saM026n3NIR5Z5aiurtKbGjGCrSyknXoMVCMMmLJZM5yJplJ83/rA5bRqWCe7uYtvSrSFLgmMbS0Jzu+z9KpMHr6NzwUF/BHyHRHoSbqwBFn0DOTrQHPQudTk3zDsIuJWLoyUgnZyHOWqg8TttPhYmzjbNEwXsLpiEDvRQq5hWfipfRGgYqCaRhMiat1im1hTaGnimHIucHUoIKZBStfiklz/AxtTWlruQ/SHIrmmjuNM02bpqzWM8DGf8p6STx4/7/sn5nXZy4k6HqfFDwG2HJXYs/giUvxxdEE6ptmPIm3PKuk8q9ih/3NFQZNP+a5B3MKAXBWYl4eFVsHxzs6AWiSZVlb6RIUzkhjBQ1iId4fA3Mbs1SrwMsb7Et5szK98Rz8w74QDdkSkIMImczT9FJFthutYMAaI2U5rTAkwVDrrXaHrs+fYhgrlM11rpaVKo6u55APbDc4wtH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a992081e-21c4-4e24-e634-08dd35d6dc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 02:38:28.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Zi6ktqcerkqvksBz5wyBcsQ7feb3kEwpsQj45m/SoHCKW88TDZboivsVzbg5XSu7h2ufVreqnCqIWcAhFbn6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8612

Hello,

> Yasunori Gotou (Fujitsu) wrote:
> [..]
> > > Fortunately, I can use the real CXL1.1 machine for some time.
> >
> > I investigated this issue a little bit and I discovered a significant
> > detail.  The "ACPI0017" is NOT defined in the DSDT of ACPI on my real
> > CXL1.1 system.
> >
> > Consequently, cxl_acpi_probe() is not executed, and I guess this
> > prevents the addition of an entry to klist_device.
> >
> > I suppose that the current code assumes ACPI0017 is defined; however,
> > it should handle cases where it is undefined.
>=20
> Early CXL 1.1 systems pre-dated the addition of the ACPI0017 definition t=
o the
> CXL specification. 2nd generation CXL 1.1 platforms added the
> ACPI0017 object, i.e. the CXL Root Device via an updated BIOS.

Hmm, I could not find any mention of ACPI0017 in the current CXL1.1 specifi=
cation.
So, I thought ACPI0017 was not required for a CXL1.1 system until received =
your comments.

Although I have no objection, why ACPI0017 became necessary for CXL1.1?=20
I need to discuss this with our hardware/firmware team.

>=20
> The Linux driver is built upon the cxl_pci driver finding an endpoint, an=
d the
> cxl_acpi driver finding an ACPI0017 device. Then cxl_mem driver
> *connects* a cxl_port hierarchy which triggers enumeration of the RCRB et=
c.
> Unfortunately, without a BIOS update that provides ACPI0017, the Linux co=
de is
> not prepared to enumerate the CXL topology.

Is it correct to understand that this is the -policy- of the Linux CXL driv=
ers?

thanks,

