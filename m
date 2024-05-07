Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E61CFBC;
	Tue,  7 May 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715059728; cv=fail; b=BKSx3XGXm7EqoGEfp2fInIAtagS1aJWRZJbY9cBrD+ZLj017p7mId4Ok/hRzci/cWzdfQel6Fru8QFHJ4fMUfp169zPwPcyGiAKvc9I9PBZXTDD42z+oSYpurLl9NCZi/rDk9sjRDzzBzrMexJpLluqkxHVXQCWEo8Lh1n0y/D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715059728; c=relaxed/simple;
	bh=zfIrQXpStFVHic1QQShbiZqtWYFv0RkpqyZPCT2kW1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQF/jkfisilbepzGCrUddShSd8MPm2aOJq/bSIOUmp+acmcynO3EaRDx0YQOP2AIB+dRb1UKVEwFvVq6LW2Z+3uk+5ZeP+p6F0Gw8KAD0Dwim2jqrAEAymg5d/Qkk379RuHptyr3qB5XWStzLKPTRfZhpH9i9A87023AjSgD7e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MXkJBIom; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MXkJBIom"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715059726; x=1746595726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zfIrQXpStFVHic1QQShbiZqtWYFv0RkpqyZPCT2kW1Y=;
  b=MXkJBIomvZ8jwI1bI3G3yv19gC/wve3yyeTeGqnLh1oRdlNAonN6UpA3
   5hyUNQ38dETd6jk+TkK18cPqScEGKPnlYbDOqXd76bwjaHD0KUcChxLun
   phtGV4wPQ0FW/4CF59y5lXGsmnLyr4ZzIFV7UVojwex/Vj/9zDRFZK29G
   5jFSiiuuE40H+kcwOdS+a5LZf+djB35p1asoh+Q7SnLbTFYkyEWA9xhew
   wR70fIDHa4yjkJtLoAMRL3iYUiI59B6IB+mDHnW07D33MRNPMivjtebRV
   sDBEWIjpOSr0xen5e2v8yHxniprGND/07rP3AQehyB9IEudjHk/H0A3jZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="118232146"
X-IronPort-AV: E=Sophos;i="6.07,260,1708354800"; 
   d="scan'208";a="118232146"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 14:28:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmNwWJ+oTrid0qwgWOQj7m9eN0VYLhaJBIbcPFyk7SD3Xm5y9F/HzfbhhGlbB9ud1i26cNYCQueDG19MUO+uS19O2Hld80YFpWgeJE7cjxrUtKcxQNwlVkAIcCCMYW5hZvC/8yEJJc6At78X/Ia51gO30zkNKcHBrvOHjBhdFfkD9L2cYBfBW0B8RPYq/EqwS5T7HoSmpXpBBoHHJaZDUV2uC/Rq20icJqaNfYgh1R/xd1wxh/3SvOEfGrZDmCeBpn7o/KtE054i5BNx5tCXLvRDH7YkSjG9A50PNKXqTwz++wILsEjvTifVirTwrlsKuSywPPRYVzvHRcoLWo+HzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfIrQXpStFVHic1QQShbiZqtWYFv0RkpqyZPCT2kW1Y=;
 b=g+sUlq0rrt+ALONQDWgGAVhNnyh2CPhhnCKzkES2IZYQ9EG3yjNJMPPsvHjnWjS6hEyLzu3qtlcqlu4VDxNSCAdOZB6YlGiYMYQDdSYnIHMB3/dNvRHL7sa4By+JSeRU9i6Hfjie5kjus4G3bUwD7WNAaMwIHpKXkqTUkxw4LYrvSeg3ogPKZpOcvo6bw42kwtiJNalb5Eb5bPPbRhDHknOnA8fsmZc5h0UqTA0I6IZ+UsJLVJVvjNkAO2kBPkDHhuEb4jhlOYhP33yF8/mzIOorrenkiH/mFkHO99s3+SxkI2PUDurxHUsJyHpiq0c0RbQWlIPWqRNapk7Zz3yKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSYPR01MB5559.jpnprd01.prod.outlook.com (2603:1096:604:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 05:28:37 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 05:28:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Thread-Topic: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Thread-Index: AQHamS4n5BtE91wtKEWLB7nzvazXtbF/cKWAgAYtxreAABckgIAFluSA
Date: Tue, 7 May 2024 05:28:37 +0000
Message-ID: <03868282-b44d-4da8-bda6-c8ae92273992@fujitsu.com>
References: <20240428053715.327444-1-lizhijian@fujitsu.com>
 <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
 <TY1PR01MB1562E0A5EA4F95FFE0F39602A51F2@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <66350bb1d3817_1aefb294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <66350bb1d3817_1aefb294ba@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSYPR01MB5559:EE_
x-ms-office365-filtering-correlation-id: f12b9cc7-8632-4698-aa3d-08dc6e568bea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|376005|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm42REtScWU2UzJMNXB5emtrTElYL25nc3M0S1pyWkVkWUJkbStzOHNUeTZD?=
 =?utf-8?B?Z0hMblVyUWtNMnU3QVRrSi9CYzdlYW9Rb2ZWZ2thU3pDcjVONXYyMGhMWU56?=
 =?utf-8?B?cCtKM1lvRzFZR052U2xaSEUvRlZCNFc2cGNOZFlHbkxCOHpYdS9FQVU2OWNh?=
 =?utf-8?B?ckRTUGcybWxsUWRlSVZmQ2JYUHpxbjVwdHU3NWd0VlZxdnM1UkxRU0xwVENp?=
 =?utf-8?B?eVpFS1lkVDhyVFRFeXhGSGl0V1lUbXU5QlZ2ZEduN3JhNkwwdTVJQ1g3RCtF?=
 =?utf-8?B?N25kMmRPMmdXOGlSTGFZOXlLVllQTVovN2xIek5tVjlFY05ORDRKSkM1dEUz?=
 =?utf-8?B?MU1NbmMxeHFFUjZJK2RPci8wdUdUaUlQYmNISENocVkxQXFPMmtUYmlFZ3pM?=
 =?utf-8?B?UWgvc0lDRlR4MUx3Y1RrV3JJS01JeGhJTWNGd1ZqZ2REMjdoSG4xWlpaQVdp?=
 =?utf-8?B?OFFGK3BkZjluVVY4MEJ4eC91NFVOWm1IQnBGcE5aandZTFBoWll4V2RQc2p0?=
 =?utf-8?B?alZWT0hTNEQ3djBQTlllalprYTd5WnpIS3E3Lzg0ZUZFdzFTRkFQakpmbmpl?=
 =?utf-8?B?aEErTGV6VnRUd1pTU0xaUHNmU1pvOWNyOVVqTzd2dzAvaDhPaFBqMjIrN1ZJ?=
 =?utf-8?B?bEJad2wxY3VrUG5GTlI3cjJOdnVkMHV6d0UxdEl3K1creXhydm8wTDlwM0s3?=
 =?utf-8?B?aTVERXFubWdaVnYvdGd5Z3lxTUtGSFFtRHJwekRmenE2dVF6MWVpV0Y3eHBW?=
 =?utf-8?B?OWVPSC95ejNqemFkYXBSdlduRy9YYmRQdE5EZmgrV0JWeEtRSko4Q2hVOHRL?=
 =?utf-8?B?cEk2Y09NNE9LZ3B5Nm9sbStITE4ybWdXd2ZuOWZBTFJWRWxWaFdvM3U5aktk?=
 =?utf-8?B?RU9VRTd1NmhLUDEyeS9Cdk5MMHRrQnlNMzI2cU04TUttSXBPK3dTNXNSTVZZ?=
 =?utf-8?B?MzFCU0QzYzFKQ25jZ2h2VjdzdHdVYnFQdDVURFlMa0hJNStDSjBia2U0WFBY?=
 =?utf-8?B?cnZDRVNobkpBeGhYRDNDOWI4MDFKNjhqSkFrc2U5T1oyZWFWRlloR0ZXMjF2?=
 =?utf-8?B?QkJNWVFqMDlEYWFyZnVjQnFodmNsU0dDREZENWpBYkNQL2JMSnd3OU9vOCtN?=
 =?utf-8?B?R3ZTcThLSUJhT3Nia1N5b3ZrL3Z6WUVQQUhaNnJNa0VwditUb05ISVpFaW9n?=
 =?utf-8?B?MzhRZDNsMFZNZis5MUpUeFZXUG5zSUEwOHg2bzUxZ0hVUjk1U0p6bGdWUU56?=
 =?utf-8?B?dU1PaVYybFpMVUw4SGxTNzkwUDZDTHNFYUdCTFRGdmx4Y2hvcTgwMDF4c3FV?=
 =?utf-8?B?MzJVdHNzNE1Vek4rRElnUklvZTVGZVRtYmw3bkI3Q0Q2RFBFV0JvSkxtNnd2?=
 =?utf-8?B?ZTlMWGJjM0FvREgxTXJXdFY4OFdjKzZCWWxMbzlRc00xTWtwV2x1bTE0allz?=
 =?utf-8?B?TjRqOHBMQzFYNUpldFh0Yk02OW51V2dDazIyUHlYcU12WEJjYzdjOFREaUNx?=
 =?utf-8?B?VzQvYnh2c0thbEFlZFU4VnR6d0E2M0ZkNm10bUxhZW1ZM3pmYzJPWjB6TURW?=
 =?utf-8?B?NDg1eGtJY09QamlRWEY3enI3SXJvS2xveVpHVi9WZ1NmUG4zUTUzNWJXbmtL?=
 =?utf-8?B?RjhQKzNoWjZuYm5tUklRVXdCRVBteEU4KzkwSk1HY0cvOERuRktIeEZ6a2VR?=
 =?utf-8?B?Z0gyT0JXMlgrRklBTXN6cmRxSUdweloveTlQWExRWjVRMUFiWEtqR29DcW9q?=
 =?utf-8?B?SzdaTjB4d3loS1p6QTk3ekFFWHZ0bFAvRS9sL3hOOXRsYU0wYVhJbk82K0x1?=
 =?utf-8?Q?lDDqMWLgsOfLws4eV0lFZiJSVpzuIeMlHl6DM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajRqQ3ZuOUxHdWtualF2V3FucEFmQnplekwvV3psaVdEZXQ0V1kyME9DWTVr?=
 =?utf-8?B?SG4vYlZveW9pNnR2Q0o2OVhsNGJMVm40QVB2WHN3SnhQVHV0eG1ETTV5ejAv?=
 =?utf-8?B?K2FqS25NaytwVnZUelFkWFVIUTFxZGNYckNnbFZiM21LV0J4T3NCRG8vdGsw?=
 =?utf-8?B?cndCS3RzbnRSVC96bitpSWtEcFowTUJyTVhBOG1aVnBNQ1FwaEFYcmlIMHh2?=
 =?utf-8?B?MThEcUtHM0RMelVmYWE3dzMrMDQvZVVwUGVPaTgybHdmTEJjaHVld1dTOE9k?=
 =?utf-8?B?Y2tPM0tnc1dVck4wcE1VWGFyWnhoTEtMK2RTOCtYVU1zeTFpZFhxMFhDTkR6?=
 =?utf-8?B?YW1UY2ZlUWEyMWVUUzc3cEkxMCsrQ3ZmL2RjaFdoZVAyYkZ6czZmOHJjWUJP?=
 =?utf-8?B?UzBRbXVOTW12bUErVzEvYit4OEJEeFROS2h4a2VGNko0cEhmK3ZBczN1dXc3?=
 =?utf-8?B?U1pEOHBRM3llT1g3RDI2MVVRYTd4ZmczZjVma204VUM0c1RsTmtZdUoxaTBh?=
 =?utf-8?B?TzhqYWM4TXNvcThabXNJeUFKdzNiN3d0WmtyZFByaVNicDZvWWNxM01MSkZZ?=
 =?utf-8?B?ZjVJdVJZYWtobmhLM2RWVWFpc1FxcDVzSlVwOXZFNVY5RXArM0dnRXMrTDA5?=
 =?utf-8?B?YnhTUGExVSt5VmhUR28rcUtLWERkU1g2TnFXWmc1WnB4dmdBV2x6cmFKOW5M?=
 =?utf-8?B?L2NFaVVGczhsSHcwVkthTGp4Slg4ZnlZTTBld05tR1JaNDR2aU1QYTJiUmI5?=
 =?utf-8?B?K1l6RUlxQlVpYmNsNU9FMjJyaitycHVMZHFVWW10VllTYmZQQnQrLzlpYjJV?=
 =?utf-8?B?MEplYjdSTm9seDh6a1dyenlxRG5KeG9tTFB5d3J0d2Z1OFNzQTZNcUpRM3RS?=
 =?utf-8?B?Z2tJRXh6U3pCRmlRMGdtdFEzK3RJN2FWcWF3b0gwemlXcjkrNnhLVlA5c0Vr?=
 =?utf-8?B?blBEY0s2dWtEV0NpcmhoOXhHR2tLR0NxR1lMREQ4R2lPV3k1NC9sVCs0ajhs?=
 =?utf-8?B?WHRVZHVmSSt3LzdmOVgxeTg3VnpUOUh1TzZCSk1qS1N4a0tyYVJJd1FmeTA2?=
 =?utf-8?B?SXMrTFA2MU9RczJoVVlwVTdUWDNlY3ZkanBZaWRNeUU5MCsvOFprbEQ4QmlN?=
 =?utf-8?B?d0dPZDVjYndzb1hXMjFqZEQ4Smd6Q2p3ZU81bXA3YzdlTWp2WDNwdFVWbUpH?=
 =?utf-8?B?aXR1RjgydVU0NzU4V0hCTVFtbmFSdndpUmttUmNCN095djVYMUdldENjR3BY?=
 =?utf-8?B?WklWZVlPS2p5M25rS1RmdnhsWE54UVV1NDNlU1ZYc01RajBPVzhjOUlEQVFE?=
 =?utf-8?B?ZW96dkkyKzYwWmRPcjhVRS9Mb3BhaWtQN2Rob1lFck15dmhwdjJBY3JuVytm?=
 =?utf-8?B?MDlQTm5XemdnRSsrczVyUG5abG5tTGVpbHVVME1xYkVCNVdFT0pqeFVyMERn?=
 =?utf-8?B?d2thUVAyQXNYZnROaFVSMkViS0h4Y0hNSzFVT2t2bkVzVzRsczNvaTFFV0Ru?=
 =?utf-8?B?ZlEzb2h4Q0drYzhsZy96OFhMUVJiQ1ZlZzlaeWlCa2FqQi8wejkrbHBFOU5S?=
 =?utf-8?B?R1c2MGNWN0YrNmY5aCtHQ0NFeE9wV1k1NXVtTGxIeHdyNmIvS2U5Rko1MTN1?=
 =?utf-8?B?MXlmeHFoWERSWFBPRDVkeTJjQXRmVnRVZHdIOHR5YzBQMGVjcDNzZkQ5d1RV?=
 =?utf-8?B?K2U4cVNwakQrTVdxTGpjUThWR09lNldFNENMVmlxaCtIUlp4dE1hZmRqbGY0?=
 =?utf-8?B?V0l1QU5LZXpFOFJqcVgxTXdpUW1xb1cyQWVabnlvc0txMXJjSzdqMVBSL2ho?=
 =?utf-8?B?QTRUN1F3R05RaDM1SnY4UlUyNTR2eWdvTEd4RVhYcEdvN2w5bGRUajBLSDVw?=
 =?utf-8?B?V1YxcVg0VHMzRjlCRkNZTDFmVWhWUVhVRXNZVVBxTEZUVlc5Y0QxQ0s2bTQ1?=
 =?utf-8?B?RzFTcEwvbE45Umx5ZDgwWlJsWHRrRFdySU1ZL1UvV0VrSDBOSlY2OXRaRjNt?=
 =?utf-8?B?dlBad3NRdmJ5UFIzdjlPRTkwZkc5RFlwZnhFcHFTV0t3Q2VwcnQvYlBTdzI3?=
 =?utf-8?B?Y0JIN3VKRHFVd3FZWGt4Y3QrcVFvZUlSQU10bTByWFo0Vm9jYjlDN0dNaGVE?=
 =?utf-8?B?QkVTRW5Xa3ZoMEZZUjR1VDZpR1lhdlpUYytocWMwKzJxUm1VT1BGQmt4czA4?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90058B6E1AE5E146B48185D6961B6724@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/OF8UPHxD+2J6pIvS5HXVbPK4e8rJlugnqZaxo+wc6ndRRKSKjquOPZ9B7KdFhfy8moDNZAahUcA2kO6eAbXR74Ru/0ddqmzWInxG4txcRjbDuTaIVjxqzQFN8U50jQXEbPf6LKni2P/Nomm/b5HE1UIfBv9EV4QizXDKyAdMkfchEpUZzBefJsf8Px66GiUHYbVBL/Eq2bAo4jg2M00PfSJokfl3je//tB4A82hwmQfhFuzREgLrUemqnYHsMFwH8xI17Ybctw1RM2lJ/BhcEqa1R5Z5MQaYZF6xEL4Md9pm3byGOIgNfF5qfknAJotcp+ATH9k7NvRgMYGkh0+1F7VWQoj+dq5IHKPmDHzg8AL+sOTOE21QVUCo0e3BUugddYNiooSBAs0680Pr1IsQ38MLWa9JRZp+HO7W16w7wwnK+7D0xZrjgzjIQyMgNlANGNri4Twci7cl3oU25tuWKFWiaiuv8wrpeBg6OY1qwYXptnIWv3nDfey8racZpSlOf8/nLAmQK1MZUhuurrEjLZlUUzyJAvbZPGSeUjLEwB/0KPIZxbOp66X61rT8jegBl5QJ/xjozQu727/u8i/lcj97TZs1rdyrDSsGJ+KIklq56dmVp/wXWsvUDwRbzWV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12b9cc7-8632-4698-aa3d-08dc6e568bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 05:28:37.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbG5m3Wxb5xlfYQTM4sZ/8BBN01cuATAggZURTqL45m8IqbqIwfpeNkFBSi/ED9OIVzXMrHncSadbuKdqCXYfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5559

DQoNCk9uIDA0LzA1LzIwMjQgMDA6MDcsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWmhpamlhbiBM
aSAoRnVqaXRzdSkgd3JvdGU6DQo+Pj4gSSdtIG5vdCBmb2xsb3dpbmcgd2hhdCB0aGUgcHJvYmxl
bSBpcyB5b3UgYXJlIHRyeWluZyB0byBmaXguICBUaGlzIHNlZW1zDQo+Pj4gbGlrZSBpdCBqdXN0
IG1vdmVzIHRoZSBtZW1yZWdpb25fZnJlZSgpIGFyb3VuZCBhIGJpdCBidXQgdGhlIGxvZ2ljIGlz
IHRoZQ0KPj4+IHNhbWUuDQo+Pg0KPj4gVGhpcyBwYXRjaCBub3Qgb25seSBtZW1yZWdpb25fZnJl
ZShpZCkgb3V0IG9mIGN4bF9yZWdpb25fYWxsb2MoKSBidXQNCj4+IGFsc28gYWRkIGFuICBleHRy
YSBtZW1yZWdpb25fZnJlZShpZCkgaW4gRUlOVkFMIGNhc2Ugd2hpY2ggbGVkIHRvIGENCj4+IG1l
bW9yeSBsZWFrIHByZXZpb3VzbHkNCj4+DQo+IA0KPiBJIHRoaW5rIEkgd291bGQgcHJlZmVyIHRv
IGp1c3QgZWxpbWluYXRlIHRoYXQgZmFpbHVyZSBjYXNlLCBzb21ldGhpbmcNCj4gbGlrZToNCg0K
SXQgc291bmRzIGdvb2QgdG8gbWUuIEkgd2lsbCB1cGRhdGUgaXQgaW4gVjINCg0KVGhhbmtzDQpa
aGlqaWFuDQoNCg0KPiANCj4gLS0gPjggLS0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2Nv
cmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+IGluZGV4IDVjMTg2ZTBh
MzliOS4uOTViYTMyZjg2NDljIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gQEAgLTIzNTIsMTUgKzIz
NTIsNiBAQCBzdGF0aWMgc3RydWN0IGN4bF9yZWdpb24gKmRldm1fY3hsX2FkZF9yZWdpb24oc3Ry
dWN0IGN4bF9yb290X2RlY29kZXIgKmN4bHJkLA0KPiAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXY7DQo+ICAgICAgICAgIGludCByYzsNCj4gICANCj4gLSAgICAgICBzd2l0Y2ggKG1vZGUpIHsN
Cj4gLSAgICAgICBjYXNlIENYTF9ERUNPREVSX1JBTToNCj4gLSAgICAgICBjYXNlIENYTF9ERUNP
REVSX1BNRU06DQo+IC0gICAgICAgICAgICAgICBicmVhazsNCj4gLSAgICAgICBkZWZhdWx0Og0K
PiAtICAgICAgICAgICAgICAgZGV2X2VycigmY3hscmQtPmN4bHNkLmN4bGQuZGV2LCAidW5zdXBw
b3J0ZWQgbW9kZSAlZFxuIiwgbW9kZSk7DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4gLSAgICAgICB9DQo+IC0NCj4gICAgICAgICAgY3hsciA9IGN4bF9yZWdp
b25fYWxsb2MoY3hscmQsIGlkKTsNCj4gICAgICAgICAgaWYgKElTX0VSUihjeGxyKSkNCj4gICAg
ICAgICAgICAgICAgICByZXR1cm4gY3hscjsNCj4gQEAgLTI0MTUsNiArMjQwNiwxNSBAQCBzdGF0
aWMgc3RydWN0IGN4bF9yZWdpb24gKl9fY3JlYXRlX3JlZ2lvbihzdHJ1Y3QgY3hsX3Jvb3RfZGVj
b2RlciAqY3hscmQsDQo+ICAgew0KPiAgICAgICAgICBpbnQgcmM7DQo+ICAgDQo+ICsgICAgICAg
c3dpdGNoIChtb2RlKSB7DQo+ICsgICAgICAgY2FzZSBDWExfREVDT0RFUl9SQU06DQo+ICsgICAg
ICAgY2FzZSBDWExfREVDT0RFUl9QTUVNOg0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsg
ICAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJmN4bHJkLT5jeGxzZC5j
eGxkLmRldiwgInVuc3VwcG9ydGVkIG1vZGUgJWRcbiIsIG1vZGUpOw0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAg
IHJjID0gbWVtcmVnaW9uX2FsbG9jKEdGUF9LRVJORUwpOw0KPiAgICAgICAgICBpZiAocmMgPCAw
KQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKHJjKTsNCj4g
