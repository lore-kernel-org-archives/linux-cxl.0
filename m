Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F242A87
	for <linux-cxl@vger.kernel.org>; Thu, 26 Dec 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735180218; cv=fail; b=hGS//jmWbi4hRl035OV68PHXRI/yURnw+AM26zeevEQAgl3qXxXB52lXwb+pwWUrBYFuDcrsXCbUNq/T8y9/dNCu2JF8Ql16Tg/ZAmz+ivBnFhwnz6pQ+EIYCxybWY3ZA+Fys11w6MAoyQFoFe+dtd4yW0DW2itVJkjpaLEJsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735180218; c=relaxed/simple;
	bh=ZiUQb+kn0M429c5JdUjJZ29OQLUjUk9OnN6YtRUy9Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F/p+gzhYv7zdrAoqt/puLbEqRaraYXLCbUmAh09Bix9eu4M4Ymx5g+R0p0dc8b7wC1QwICtB9PrxLeq/kw7esu8q3d0K2Ati/VjNS7nc48pfVxphrMvnwUag/bt2qSKqUjArLZcK0osxeFUFD48p44o1dM3p11auyjlgpeD6tBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DWXkGk5f; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DWXkGk5f"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1735180215; x=1766716215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiUQb+kn0M429c5JdUjJZ29OQLUjUk9OnN6YtRUy9Rw=;
  b=DWXkGk5ffDgEWVzqdldwySenHsQn5F6+9/UvMWd5jly0KDQXOW+15fe/
   6IUzg2azUQHVavL/XEDGiACCNHJVc2Yf/4c8k2Q30g4z5i61VWQZejydo
   4ceaB3zS3HXy3H3IVnn+bMrWZvQmcw72GUb4yRQo0MYQY0bnpTqlUvBiz
   fwQ20a7WpPGCtdsZO/iApCNCMOLUSfyrnXoTx985jW8Lt9x5wmNKnXcjP
   CoiTfc4QDs3xNoIaYzHEUICbZQloOGCZRAZ3xaq88HCRwNacNz7D0gFsN
   rDkv3rWR0pAzTIvKKiNhtbw7LhQAPYEn1cdx2ioIAecc3b2hB9MLmHc2k
   A==;
X-CSE-ConnectionGUID: RAhy9oTSSseyiqUa3dJXzA==
X-CSE-MsgGUID: D+LqiknbSS+Q4WTzphQERA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="141884854"
X-IronPort-AV: E=Sophos;i="6.12,264,1728918000"; 
   d="scan'208";a="141884854"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 11:30:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7D10ujDVQBW+JzwYQOFdejG43YcghxRln7qvvR6vm9VOmx+WNvld67w7d87sdjxInYwsvCYOyg8N6AluacPBdCFaSZfijipcWK7Kw7AJ2BBAlSRkLTzkqrEx5QZR4DdNLY0jDaSGGhkLq5nKFO//h0lYf7UFl+kF48K9rmtPtzrP0q7dcdDC6KuDjn0VtXzcLTM9Qk1IHwl+iRukz/6/6UcztzwpX4x7ZQB4za/1A2+mAc5VK73pa5hv1nveSADFkGRI1LQWgRQ/MLrrVGBYg9kTgSNvws2P0f11S7Ctp/iEqO6ouFPSebT9roPCtCrw+jGypoiOVT3PJ9jS88V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3y2H1ddXSCW0XN4KEmPWjkY8J8Bj7Dx6gBDqE70CrtA=;
 b=hJi+pMgP+KMydfdPNErkhf7c/0RxTiOFkhaK68tY+VAcCyY+dGbtuErlGYSL6jF0XLujJXrXMSfEZxDkFkZmwOY3LB5z/mJINO6C3bjckBFzolMCt2yt+cB8J4/bP7VklJqDEBReO9fFHNR8hfL4771Kou66jxQwj6mps0xZPTQ7HyyOI5+kLXE/b5vNccQqOG+KHLDj6T2hlERjrNeNeNjWiXB/hDmreF2zvER09EFFy3evI8WWoyLD5cEMmYuVzzmJTb40K3x2kDn8dGT2+KX0vhCrhxy4OFp9r3iL5qYLCOCd00hZZLovYgXgBF/2qrW6iK3mqkU1ppatg2//XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by TYRPR01MB14111.jpnprd01.prod.outlook.com (2603:1096:405:21c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Thu, 26 Dec
 2024 02:30:03 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%7]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 02:30:03 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "mj@ucw.cz" <mj@ucw.cz>, "Daisuke Kobayashi (Fujitsu)"
	<kobayashi.da-06@fujitsu.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Untable to display link status of CXL1.1 device (RE: [PATCH v18 0/2]
 Export cxl1.1 device link status register value to pci device sysfs.)
Thread-Topic: Untable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Thread-Index: AQHbVz4R5qU1C1TQ0Ea9K5goFxnWyA==
Date: Thu, 26 Dec 2024 02:30:03 +0000
Message-ID:
 <OSYPR01MB5352F167B18CC4DFC908D692900D2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
 <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=6dae4479-6769-4acf-8479-1a74781f9eb3;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-12-26T00:58:30Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: cc0dfeebd33e48e99c33510cbea05f5f
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|TYRPR01MB14111:EE_
x-ms-office365-filtering-correlation-id: 033a05a5-1aa8-44ee-97b3-08dd2555340f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WGJ3WVNzUVYzV1JxUTNVTGE2ZzFHbld3aEhZZmZDR3dEY1o1bHIzcjFZ?=
 =?iso-2022-jp?B?SCtsR25QcmtsbWJ3Mkx4Q2t2SnJxWUtscGhOcmJyWTFBTzcxbDIrT1VS?=
 =?iso-2022-jp?B?SHpQYUI3aWJHdzQyVnBLMS9HelNmYUlwa2ZxOFZRNHFzc2lEdTJPNFNv?=
 =?iso-2022-jp?B?NVdQRmh6YW5zbW94VEtkTFpQK05pSVFnZlZ6dUNlRFFXbk8vNmNCOGQz?=
 =?iso-2022-jp?B?aHFGdUM4SG8vRUM2bmZuRmJyOFZnb3dZMUs1VVo4YWlSVWFLT04xVFEz?=
 =?iso-2022-jp?B?ZHFCaUkyeUpQS0dxN3NZSWdKYzR4Y0x0TXNHd0hHalMzWnM4T2JrNDIz?=
 =?iso-2022-jp?B?MFNvaUpZbHVJZzg4Yko0Q0pTelNxUCtjVGpGMzVsK1lQd0REVGNOeU1a?=
 =?iso-2022-jp?B?K1g3SUVGUkJScGR2c3VkbFBiSzVTcTFQNGtVbyt2My96K1p5ZDBUYS9r?=
 =?iso-2022-jp?B?WHhsWllZMzAyL3VQc3U4dE1tSEhteGkwYnFCYjkyQ0pFOHpvd3FRK0V4?=
 =?iso-2022-jp?B?TUtjNGxGbnhsSUluK01Rb3FQMTVUYUw5eG9RbjBsbkgwREdiWkxlNm1y?=
 =?iso-2022-jp?B?ZUFjamo5ellpNVZOSWxMd3JzMHE5V2tkbElIS2pLZCtwRk1wTEJxL2hK?=
 =?iso-2022-jp?B?MkVXSW5ZWUUzazhNMHhzYTJsTzEwaFdFMUdRelhhYmMxTTEzTHUxc1lH?=
 =?iso-2022-jp?B?dTllcUljajR6czRJUHJLNktHVExQbVR4aTlCMlBObmYwT2ZsQ1lsWnVB?=
 =?iso-2022-jp?B?YTFhSm1kSFV0dWhYMjg3YklrOFR1SnJDVlNWcG9taEdVQ3FqelA5VlBr?=
 =?iso-2022-jp?B?TllkeW53NTNvcHZ4NVZJTVRNcFZWNG80Y052cHRrSU5BcmUzYUhEMm4w?=
 =?iso-2022-jp?B?T0IrcTZ3dWxKT0VxRTg1WThMYUhpZmthaG1pWW1ZL2l2VVBFYUJkN2Ir?=
 =?iso-2022-jp?B?eTZnVUNjNlZSZVorZ0dCUENsQkhMekRLKzBkczVncjNZLzdJblZkOUY3?=
 =?iso-2022-jp?B?SlhXUVozeTlxa3pvQmd3b3d0OElmUHdJdVo5VHBJd29DVmNnOXV4MENu?=
 =?iso-2022-jp?B?dTdRRkZ2d0tkTVNHa000VFpCVTZFSGQvQ2ExK01ydUxZVWtvdDkrMk5V?=
 =?iso-2022-jp?B?dlh4NEd0RnlDMVJtVjFpdnRvay82OUpJaWdGMDlKUVNmVmpVN3ErMGNN?=
 =?iso-2022-jp?B?bHhWWXRhK1lIMTMyUTk1NTBqR0xoRmNQVkM3aWVzOEM1MFZOTkVWSHBh?=
 =?iso-2022-jp?B?OUxucU8zS094eEsrbHIwVGpsQjNVTGlYM0Z2Vm9JM1V4Slg1eW12em9C?=
 =?iso-2022-jp?B?OWp1bkJLMXFNelFrZmtKL3pSVEd0ZDBod0VtU2tHN3VPQldhSlZxVW1D?=
 =?iso-2022-jp?B?ZFM3ZmwwUkhtekdTbkduR21hM3JWVmxGV2pKeUtJZ21xbDM0N1BJb291?=
 =?iso-2022-jp?B?TFRzM2g4ci9NVUN3cXZpNFpZWWJ0OHBLemUvT0RiRk5hODdZdkRmT1do?=
 =?iso-2022-jp?B?Z0d5LzlmMVc1bUE5cEovUkZHaEZBMUVzYXI3eTdmdzB3d0h6R3FGMSsr?=
 =?iso-2022-jp?B?c3Q1dFRhbHo5WDV4d1NPTmVTeEVQc00rQTQ0SWVTb1ozK2dRTlJ1Z3Ar?=
 =?iso-2022-jp?B?cUVIdmVEcHNoajFxNHdwRkFFNUZ0WTUxNTRGUUNwVEFjS2RSdXVCZXd6?=
 =?iso-2022-jp?B?Q080T2Zaem0yc2dHOXU3RThTY0trKzhOY2tyQU85bDFkODFRamN4ZE9l?=
 =?iso-2022-jp?B?alUyaG9jRThic0NmT1JnbnBZUk5tcTQvemlURW54YmFhWUpKQUlQWnFp?=
 =?iso-2022-jp?B?N3pWeE4zUXZKQVZLTndNT1VSTVNpdklSSE9qc2g1K1F4UlBoUHdDSEFx?=
 =?iso-2022-jp?B?dVJ6OUxzZlNKYmpRSFBXVTN4azgrZW90SHdkdW5XWDhLcmYzc25LUkNV?=
 =?iso-2022-jp?B?cndaV2RnWllBaVNMbEVFbUpZOWZ5VVQxRmFybE9OUHUza0lSRm5LdGR0?=
 =?iso-2022-jp?B?ajQydHhLYTl3RmZuV1VTYXFxR3cxa2xWUnZCS0lVVlVIMWFkTWtOQjlI?=
 =?iso-2022-jp?B?d3ZObHhDOFIyTms1cm9iaEhEdU15Y1cxWDdRWnRpWGhmelVvYmR0a3NW?=
 =?iso-2022-jp?B?NWNVTFgwalNqRERVU2pEbFNCNFZOODJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?VDhTUHduQjFqSWl5bzl1ZWp1OFY4R1BVY2tPVkdFZVBES3Y5bzlGZ1Uv?=
 =?iso-2022-jp?B?RytpVElpUnBlK1MxMVFxM0NralFGZGFVbndrTVA5ZkQ3K09SQmYrMHBQ?=
 =?iso-2022-jp?B?TThTaXNZMGJ4dVVObWh2ajNYWjNLS3RadU9oYU4vTnJrVDlYakVkNWw1?=
 =?iso-2022-jp?B?c2xZVXhtalRHMDFzUGQ3bGRYaTlWNCtZNGdWb2tHRlQ5WS9ZMW5VZDhH?=
 =?iso-2022-jp?B?RC8wVlhmUUpUOFFGT0UrQkdsZVZhZU5RV2FSeUlRWWhobGRPcUpZR1Vt?=
 =?iso-2022-jp?B?RXdzYkZkb3N2RkYxdHhpMXNqYWFZbVhOZVhqZzAwQU1ackErODh6Z01Q?=
 =?iso-2022-jp?B?bkhWWDA0bE1wQXBLV3EyZ2JtTDgwY0xzaFRoU3l6UW5wME1KclB5L0Rh?=
 =?iso-2022-jp?B?SzhYd1Bsd3dHcjVKUGQ4NDZadnFRM0Z0VEtrQkM0TFUvL0E0OVgrMFVZ?=
 =?iso-2022-jp?B?SDZEUG5pbW5la2hSeE5uVnZPY0xBTG5zejBaWHNZY1JxekdPRkRZbzU2?=
 =?iso-2022-jp?B?RTI5cVVQU0trR3hhTG9WbWdvekN3YnNzaUtNQzIrNC9aSTc3TU9kZXhm?=
 =?iso-2022-jp?B?TUdqVFJsZHNiYVlQSnpKbzdFcFdTOTVvYjRLZit5WnQ2QUJ1SmVvb2p5?=
 =?iso-2022-jp?B?Q1pxbmpTeXFXZHUwVVQ5ODNiVDlESFdhMXlZN0ZQeWNOTVFSczNIWVMx?=
 =?iso-2022-jp?B?YmVLd3hxQjh3WVZ3MGk2ZGZob0ZwbWFxV2lOQ3gzRy9YK1NvY21WYVh2?=
 =?iso-2022-jp?B?eGtVSnIvRXBXL3ZNQmY3TEI5Q09QQ3l6VHl5czEzdnZPSGllN0d6dE84?=
 =?iso-2022-jp?B?U2pUUWw0amtqQ3U4M2pZZWYxcm13SVl4dWtjYVg0MVBTTGt0MEFZYmFs?=
 =?iso-2022-jp?B?MVBNbGtrVFdzSis1WUl6UVB4OTBJN3BOaEZZdTd2T1RvaUxyN0Z1OXhX?=
 =?iso-2022-jp?B?b1pGZjZIUXlhNHZKME94SHlFMmgyM0JlNHkrTHdCUmhKVnZSMDNYNjRv?=
 =?iso-2022-jp?B?MHhOajFhZHpvZDBPWFBZN1E1TnVPeHJkZnpLUkdrRlBDM292MnA5SjBT?=
 =?iso-2022-jp?B?a3JnU1N6NTd4eXBQWkRibS9wdUMxSVRmTW9GTjlwSk9hc1hDSjQ2Tjd0?=
 =?iso-2022-jp?B?WHRwWlpwUGZGRDhSLzRkb3dWaUtGVUdRNStYZ0p1aXJ1b0dYYWtEVGdj?=
 =?iso-2022-jp?B?OHdiTFc1ZVNpRTZuY04rWG9WVGZFN2lvTzRHOW9PQ3pqZzJwaXc0MlBT?=
 =?iso-2022-jp?B?Q1VHWnhkaE0wUlhGM0QrM3VDWjlSNUp2eVJybHZPYSs3Z0lhbE1GcGJR?=
 =?iso-2022-jp?B?RzFnNnYzOFZwU2QwV3lJN21nY1ZGcENyYlZOaXFtcVplSDlxeUNUZ3M2?=
 =?iso-2022-jp?B?UDA4dncxQWhCUjBYR3NHTzkzQktTK0FrUVZyaklld3ZHTHJhbnlybFJO?=
 =?iso-2022-jp?B?RWJQY3NEaTVDSFBOUWlhSklDaVQ5dVQ4aktUZktUQyszeFlVTHFRa0l3?=
 =?iso-2022-jp?B?R3pnS0g5ZVlhWktPaDJwd0J4VVo2cGhLSFRYSHZkV1BXZGJDK1FpRW1F?=
 =?iso-2022-jp?B?K0lKc3JZSGNUeWI0WDNVK3hpYXhQem5DWjZ5aGRMMGlUeGNFZ3pqNzgx?=
 =?iso-2022-jp?B?QXNxa2hoc2RuV1JnWGxkczZ2Zll5b3QxdDl4SXNXTU0yMndVeDE3ZTlv?=
 =?iso-2022-jp?B?cEhKV1NpQ0czUDhMYStTeEFVaXlFYm5MYTY1YjJDVGtIWk1vTlFnZlFW?=
 =?iso-2022-jp?B?TWdIZjZWU1NyeUJDT1J2ZWJzWHdzOW15M2UrR0RDS3VYdWxiS0h6WENX?=
 =?iso-2022-jp?B?T2NiOFhhZ1dTSi9DRDRmK0E4ek0vc2hxZ0ZsN1BkQ2pMbDdudWV2Z21v?=
 =?iso-2022-jp?B?aFo4WXRxeGFXNkJ3a2VtZ2pNRVFCNkhod0NLUjdMRGZBSHZEeGw2bmkr?=
 =?iso-2022-jp?B?dEVOd1RCd0NwL3MxTHUwUno0STYyVGo1RGhqK0F1bEREOC9XYVd4MWhP?=
 =?iso-2022-jp?B?Znc5RzNoYVB4RjJ1eDVEeVpKNU9DeTFSUTMrdjQ0WmZyTGxZR3F2dHRr?=
 =?iso-2022-jp?B?SVZnekZOZWdqc0dlYmFGL1pNdWs5cjBGNU04cGJJZ1VsRUVDS2lKaHFu?=
 =?iso-2022-jp?B?TUNiM3Q1dENYaWpRbTc5aDhkYmNlVUU2UzFNYzdkTXU4TEI1b21GNXZK?=
 =?iso-2022-jp?B?U0VkR0JBZE9vbFR1V1lzb0Nad1B4TzhoNTUzbUVUYkNwdkwyQ1RlU3FL?=
 =?iso-2022-jp?B?dzlPZ2YxOTNDRHdWcitmVE9vS0xwRk52bDZxenB3SHpQaUFLd0lwd0tO?=
 =?iso-2022-jp?B?Q3VPTw==?=
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
	RHxLZoUvuDqeS8qaykCz17d+DXRbWd68F5es+Pwad3mt7DiYqJP+OSM0FPaN6DEymm2pjHtBVzvrhImQ5MmqqckQjPubCnoPDmh/YDb/jhq/6jyHkX0V9HNBf1uFWbwAxBUCV3ZmoF6TP+eex+ndr58m3pbi0bOq2SAbqKkuTeS9tZPtp5SXOBhiXlkDuylIjTWtJFUHuNxhR89O6F+1REMrL9sfM7Jr35zsbtXUiCGV/4q4JG89WRsGyQgBNH+6WA/+i4dfnm1wuQmkWLFz+8TeAefFmftMTd3MomQS+3GL1P1cPbzTVbzzu7mOHEqtsA4DC8/BkphDrA+Lorm/lomAxv1APlfhxMYoBRuuZy2u1VCYcf10JOvRLAFSRTXh44LefqgS1AgdKGObf4mf4yUE3d5zWHImZoZWuNH0hTgfvmzwWhh4PztGmtaRll3xBbHu5QBO2QsZAP5RZRw/LHB2bLUcFL2LMiPq+5TO4a1EJJuATcFN8TBtaMTMjHC2hHTjNvabCATUTOPgzA2u+eVLUrMbz8dQxoDYRZy4oGy7jun7wHPNvjsOGlJn7kFH5vjt8Woo9BAhRoMDoIEHpNMMyWUoVcrR9yUZEB7FaLc0O97aSizaWYvGRpSJ1+2t
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033a05a5-1aa8-44ee-97b3-08dd2555340f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 02:30:03.1849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbjeCM276Ag2ziT6PGIaAsOpnGobIuquTs/wCbYaIgo48hwhhh7/4LidLXxzVEcNFuYQj+nGrN9mmO4dEmqx/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14111

Hello,

I was able to obtain a real CXL1.1 hardware environment and tested this fea=
ture on it.
However, I found this feature does not works. (The kernel version is v6.13-=
rc4.)

Here is the output of demsg.
=3D=3D=3D=3D
[    6.228015] cxl_pci 0000:16:00.0: enabling device (0140 -> 0142)
[    6.228351] cxl_pci 0000:16:00.0: No component registers (-517)
=3D=3D=3D=3D

This means that cxl_pci_setup_regs() returns -EPROBE_DEFER;
=3D=3D=3D=3D=3D
static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type ty=
pe,
                              struct cxl_register_map *map)
{
        int rc;
=20
        rc =3D cxl_find_regblock(pdev, type, map);
=20
        /*
         * If the Register Locator DVSEC does not exist, check if it
         * is an RCH and try to extract the Component Registers from
         * an RCRB.
         */
        if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted=
(pdev)) {
                struct cxl_dport *dport;
                struct cxl_port *port __free(put_cxl_port) =3D
                        cxl_pci_find_port(pdev, &dport);
                if (!port)
                        return -EPROBE_DEFER; <------ here

                rc =3D cxl_rcrb_get_comp_regs(pdev, map, dport);
                if (rc)
                        return rc;

                rc =3D cxl_dport_map_rcd_linkcap(pdev, dport);
                if (rc)
                        return rc;
=3D=3D=3D=3D=3D=3D
I investigated inside of cxl_pci_find_port(), but there was no entry connec=
ted to klist_devices.

=3D=3D=3D=3D=3D
struct device *bus_find_device(const struct bus_type *bus,
                               struct device *start, const void *data,
                               device_match_t match)
{
        struct subsys_private *sp =3D bus_to_subsys(bus);
        struct klist_iter i;
          :
        (snip)
           :
        klist_iter_init_node(&sp->klist_devices, &i,
                             (start ? &start->p->knode_bus : NULL));
        while ((dev =3D next_device(&i))){  <--- dev was NULL due to no ent=
ry in the klist_devices.
=3D=3D=3D=3D=3D=3D=3D

As a result, cxl_rcrb_to_linkcap() was never executed, and no sysfs files o=
f rcd_xxx were created
for the cxl devices.

I suppose that this code expects a function to add entries of klist_device =
for CXL1.1 devices before executing
cxl_pci_setup_regs(), but I could not find such a place.

I hope this issue can be resolved, but I'm unable to find how to fix it.
Can anyone provide some advice on how to solve this?

Fortunately, I can use the real CXL1.1 machine for some time.

Thanks,

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Wednesday, October 16, 2024 8:40 AM
> To: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fuj=
itsu.com>;
> linux-cxl@vger.kernel.org; dan.j.williams@intel.com
> Cc: mj@ucw.cz; Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B
> <kobayashi.da-06@fujitsu.com>; ira.weiny@intel.com
> Subject: Re: [PATCH v18 0/2] Export cxl1.1 device link status register va=
lue to
> pci device sysfs.
>=20
> [ add Ira who is covering for Dave ]
>=20
> Kobayashi,Daisuke wrote:
> > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > the link status can be output in the same way as traditional PCIe.
> > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > different method to obtain the link status from traditional PCIe.
> > This is because the link status of the CXL1.1 device is not mapped in
> > the configuration space (as per cxl3.0 specification 8.1).
> > Instead, the configuration space containing the link status is mapped
> > to the memory mapped register region (as per cxl3.0 specification 8.2,
> > Table 8-18). Therefore, the current lspci has a problem where it does
> > not display the link status of the CXL1.1 device.
> > Solve these issues with sysfs attributes to export the status
> > registers hidden in the RCRB.
> >
> > The procedure is as follows:
> > First, obtain the RCRB address within the cxl driver, then access the
> > configuration space. Next, output the link status information from the
> > configuration space to sysfs. Ultimately, the expectation is that this
> > sysfs file will be consumed by PCI user tools to utilize link status
> > information.
>=20
> Thanks for all the work on this. While there a couple things that could b=
e
> cleaned up it's not enough to require a respin. So, for the series you ca=
n add:
>=20
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

