Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1218EAB
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216505; cv=fail; b=DXFNnbP84q2fyZBigWp+BIb+lKEfkNFZTzARFu+IMz/whLHSOuTUppeIPFfVBlNQW4EHETC4RZm3xmoG2rjG3E0mPTVDoF2RJEmV7DTyMy5eBMWzCfFq6+v/WidUfR2VklH8h9u+xRNx+2YU8rkH89WLyLp/lQrT7CYZJhxmZZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216505; c=relaxed/simple;
	bh=OzKBEUGApQGG706ZM6XUkXKm3agfdy1FA2PNFSOHa0w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Eo1CDhbp4SrKP1Gje9b/FE89iMb7u0uyH6r+Qgw+dtgflP4apSQyNIy4Du8bkifkXW8WhAnfdtyj5nFUgbLxrdO8K2PH3h4DzA72IkfkedcWCgFl1fjTkFrrcZQVCI9/GBbWxY1+sMZLT43LnMw6g6ItWPGaJ72ZD6ferH/3Zyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jOQ8UKUh; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jOQ8UKUh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736216502; x=1767752502;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=OzKBEUGApQGG706ZM6XUkXKm3agfdy1FA2PNFSOHa0w=;
  b=jOQ8UKUhtkh9Zn5L4gNu4DFJZZqb/YQZlLyB/D4LwOkI703jrt8vSeV4
   57v8H1rGlgwi3IwN1QbTeXKRGS1BUsMw6k1n7T7Ntbd6R1IX5kEcEET7s
   3vQCq6ptuZGfSLyfTji2TyPIIGIjMoLs4jUVd5WJnHX3OTzn8LLl2jHGY
   VOocbb5lxcanp4lPsQscftago/jHXhka6bwpmB/+Om8AjP1RG+a/RZmYu
   EdukOgw+dKx70f5sA7izAg784pHCpv0n6ALYsc8LEw6+GIiyz8DsrN7bc
   SN30YWbF4y2EladW7pNpRZV5xXDGWv7NFn2RrwfVrz6W39wtuwqqqFA2D
   g==;
X-CSE-ConnectionGUID: axVomO/JSlyx1jHtierWHg==
X-CSE-MsgGUID: y9DOr0W/TIicjlCiBonmeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="142191284"
X-IronPort-AV: E=Sophos;i="6.12,294,1728918000"; 
   d="scan'208";a="142191284"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:21:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ6OWjDsbN8YF7wMnVtmUFPj/HSyqtm2HtxWtNnIJov6B0eaxvAITcyQ+5NnVZvvlJwxSb/gpqiXaKXqvBbe/qshYMhE29edJbBReOfmPS4Vmkw+f3WJTpUxzy8R4v2h/WPCh1ylAMwDrxxheM7j7LTGLEJTHA2Z+NRNb/0O5RTYRvHbbM4ySGPPLWw0hXxZyPhdatLacP0G7sw4FqKFBFhehSHOSSjmAdU3cPRSodcOMBpIQfpoNKRasU78MUb885I/3Q7CU6ea5wf2giKjhR6P5OIeJowJAqYsvnrrJ5U2oQIFyZFyC1sl2RCW+EgzVs+4ggPhV87EDsBSMDUP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3cWGlpDdLYXBwatuosBIRI/TCkzlS7CUWNyngGpyIY=;
 b=Zge94yDTZgDV7/IKl1mpafcN2bPwGMIC6+rmL+2JmAMUltyLQtTNCL4Eo1856nmkafexnCwKkvOLYJX2VugwcIRCfkKi8iAji85hLTgiTn4vEnSFtcZCA5stuveNHtmCEV/WRJJYV+IIUpStlFTFT9jmvHHWfcdpzhGrCS6qnoEBFhvfLRGnqpFYqRGb0taNac11AXKNwBDOYM65BnGWPCneEAfof/aHzQHG9ziEQVYE+Kfozkc4xZK/n7hMKNXMzQ99pLGwXJRx25iJANEUVJtRDb/bM0W9ay2lcR47qeyNnmfDfJ1xbDCvpAgMRY3Gi0lLWv3YCN0nPYfrV34Kxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by TYCPR01MB11753.jpnprd01.prod.outlook.com (2603:1096:400:3e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 02:21:30 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:21:30 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "'linux-cxl@vger.kernel.org'"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Assistance Needed with CXL Memory Region Creation
Thread-Topic: Assistance Needed with CXL Memory Region Creation
Thread-Index: AdtgqoH4aWCS14GjQ5iB7Jig2VQUVw==
Date: Tue, 7 Jan 2025 02:21:30 +0000
Message-ID:
 <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=cbcaba8f-a6a8-414c-9e62-39cbe14c497c;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-01-06T10:39:21Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: a53c087ac80142ddbff0425664023d1c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|TYCPR01MB11753:EE_
x-ms-office365-filtering-correlation-id: d14a149f-3df3-4eb6-eab2-08dd2ec1ff98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?L3hBNEZwL295QlRIckJhcHcxQk52UlYwenEwV1FwOGJqaEZTSVJMYTcy?=
 =?iso-2022-jp?B?QWFBVkIrZ1FJWFVlWjRvaTJhK0FKTGhBUVJ0QWN3SDU1WU5qL29Jd09C?=
 =?iso-2022-jp?B?ZDJjWXh5Yko3cnpoY1Nud3EwbUJkOG1VZHYzMS9rWUhMUGxjd3IrN3Zt?=
 =?iso-2022-jp?B?cmhva0lhelE4d3grUEdubC9vL21MV0poTW92YmxjY0lrcHpNUXRnVXFF?=
 =?iso-2022-jp?B?bm1Eb04zZW5wS1d4OTlpN3h6ei9pWktSQ2c0ZFR6WEpaTGtuZmMxcE12?=
 =?iso-2022-jp?B?MDA5S3dNTDNwb1ZnRURadVpjanZrVUFteG5oSlZjMSs5b1VvSE5oMjA1?=
 =?iso-2022-jp?B?WWRYR0lySGExNFlvZGNiaTZLd2xFcjZZU3ZyekFvSmljanBPU1NpcERO?=
 =?iso-2022-jp?B?QXM5eU43eFJIT24ya2lpSlVvZFYrWk5pdEhvb3pYTnZBdnpENXJvZmRh?=
 =?iso-2022-jp?B?OW1KQnRRSGV1cUZPR2Z4S2lNc1JLQ3FJcHQvRTQ0TStnbks0Q1Z3N1Fj?=
 =?iso-2022-jp?B?eVhVS3Irb2RWSllscU1KTTVSZDdyclZXMHptWnpCWG5TVzRndXFBbmhq?=
 =?iso-2022-jp?B?c0E5Ym10a0R5eGl6djY1aWU1Q09vdTZPUEJTQ2hnU1NwN01BY1hRQ3l6?=
 =?iso-2022-jp?B?QnhMQ1E2cXRIb3A1ZG9YUXFNNUxzdjlJRnNiR1Z2cEg3SDVHMVQ0M0RQ?=
 =?iso-2022-jp?B?M0FRSFVmNXlPTE1uc2xoNE9ZR1JvN25UYjhYaitjM1ZWKzRCM2M1SU5J?=
 =?iso-2022-jp?B?MDIvZFdYclVBWTl0VVgvSG1TWHZBcWVKUU9CMCs4bUs3aVlWMFBlQ3FV?=
 =?iso-2022-jp?B?ZkxFZlQyVUd1cGFRVVhFRGZWTW45N1hGcmlEQlpCQUM1NmxDSVlsRGQy?=
 =?iso-2022-jp?B?RUNDRUZMbWQ1ZUszcjBNWnNTTCsrMldUaWRnNjBneWVxbHJWZFlxYkZV?=
 =?iso-2022-jp?B?TVBiUlRtY2lkelc1UEZFRXJjVE05RWdWV2ZwUVpFcmgrd2hheWJvOHRL?=
 =?iso-2022-jp?B?elRSdkVmTmdjeTlCdFNJTTc4VDRDVmtSbW53YTR3T3lNbFJ6eHRSNStk?=
 =?iso-2022-jp?B?YytqUW5TTGtkWGp4bGFhMVFkL3dnQlAydGh5aWhLNTJJb1pycUNDMlJt?=
 =?iso-2022-jp?B?REJmNkl4dnpDS0lrTEg2QmRkeU9aWmpXQlFNUUxReUpRblllVHlhdkRw?=
 =?iso-2022-jp?B?bFVpQUM0ZDZ1Vkt2OHYzRkZOQVV4TjBEVFcyNlZpb3lkdkthWW45WTU3?=
 =?iso-2022-jp?B?RzV6WmJnc1BnamlCTHdQQTdXSXh1WmNwMkplbDBINEZNZUNreWxDT1Ey?=
 =?iso-2022-jp?B?NXQ1UzV6WFMrU0o4bFBhdUI3OHJDanVMWFpaV2hySk1JeURDTFk4VW1a?=
 =?iso-2022-jp?B?QW9zcXBNT0E4a1dpS3kyMU10UU1xeU4yQzZ5NDE3bFNGMVp2eW5hOGJi?=
 =?iso-2022-jp?B?MmJjaDBuWFY5ekFwK1ROWmN1THJ0eWRySGdTMXkzUTgxVjVsak1yckJ5?=
 =?iso-2022-jp?B?MUJORUR1ajBqQ2VUKzZjbG16ZzdCUzdkRTZsUU5rOGVLUUpKVW1CdG1a?=
 =?iso-2022-jp?B?UnVsdmZmcUlVcnNvV1hqODUyOVo5T21jYXFCRFkvb0VMa1RZVjVjbytM?=
 =?iso-2022-jp?B?UDgrWUlrbnFLS0dPS1NHK1YySExjTFlDRyt1RFdIOUNQNkxaNXZQK0dm?=
 =?iso-2022-jp?B?aXBFcXJBOHF4bFd2NWlhcGNUdisyMjZsUllxY0FtMDdLN0luTDhWMHph?=
 =?iso-2022-jp?B?cUJ3SFFPU2s1ZXRaR0hoVlhFYUhUWlhRdjdXa0RqSFBFeittSG1qbVhl?=
 =?iso-2022-jp?B?ZWt3Y1RYbWQxeVQzK1lBWDZhbDl4RUJBUllhNXJTMG55cUJCMFZQQWdn?=
 =?iso-2022-jp?B?Tmt5QkhLRDlTWFQ2M1RCS3Q5QitBOVRDY2RrZjF0blVUZWtQUnJQWUFF?=
 =?iso-2022-jp?B?OG13Y3JSaTJQQ2l0c01sVXpTd0tXU2NBSFVJWXh1ek9VOVhKeDY0ZS84?=
 =?iso-2022-jp?B?RCtYWkF2Yzg1S1lKWVIyRmFDQUVqbCtzby82TlJuK29rUjBMUktYZVZO?=
 =?iso-2022-jp?B?d2FZV09KVFBaZTFERVZ2dGpOYVpKemM9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MVliUW5mZjVYWHg4T0tqVjVlaFZMMDhBeHJ3QTIvQllNczUyRGRHeEFC?=
 =?iso-2022-jp?B?MmhuS1FPa29ZTy9MWlYxbzFrZGRRQ1NFNE1wUlJYTVV0OHg3UlFQL1c0?=
 =?iso-2022-jp?B?R3BnakFCd0p2THJya3pLNGc0bUs0bDZrMmFZMDBMdnZDb2dXYm9WcFRw?=
 =?iso-2022-jp?B?WE5wYWt5LzZiWDdNOWpQclQrczE1aUFtQW9lZ2lUVmtZVnNIRTJlVzZ4?=
 =?iso-2022-jp?B?bTlJNVNwOWpub0V3ZEU1cGlCZG1QdThjMDJNUEdPMGNGZUk5TUxLKzdm?=
 =?iso-2022-jp?B?ZU1xd2RrbUc5cEU2RWZHdXoyKzM3U0tISU5XdnM2cHNSaHYyRStiZnk3?=
 =?iso-2022-jp?B?K21ROHB1ZkRnV3U0cjdxa0RKczV0YWlxcWJuQlM4ckdkU3RzSzJ1cGZx?=
 =?iso-2022-jp?B?VkgvRno4ZzJBK0FkM2MzVzMzOXQyaVBweGhiaDZ4MHh2UkFOUlhVeVVG?=
 =?iso-2022-jp?B?SUxJNXRRSk51N2VsTWVKNTV6a3hEMnlOYVVlOC9uNTRweFVzT1JXL2xo?=
 =?iso-2022-jp?B?ZzBMVWlGbTE0V0JlL2Voc0kxUUd5aU40S3BubVd5OXQzT3BNZE84NkZh?=
 =?iso-2022-jp?B?Ykk1NE5Kc1cvNHZwdjVQMkdBUktWU1VGcGVWWnloN3FpUHpTZzNSSWh0?=
 =?iso-2022-jp?B?cUxQVmllRUxSZm9sUFczSTVWM21RZUs2Qjg4VDdSUXM2U25idTRhaXpK?=
 =?iso-2022-jp?B?RHlsYVNIVVlqbStSTjRLZVpTbWJJWHNRakNHcEpSOXRDd3R1RXVmTzZz?=
 =?iso-2022-jp?B?MW51ZWlqYUhoR0hNN25VUDI2MExqWmtMRmF4MjVsM29tWWh4N2JFRS94?=
 =?iso-2022-jp?B?a203cmsvYXRIN21pUnZnT2c1RnRROXFTTnJiQjNiNmhJSDd4TXBKTWZn?=
 =?iso-2022-jp?B?Mk5MZStqZGVwZjJoVGZFK1lnY3NTYW92eUxHelJKd1loUVZ4ZG42Y1ZP?=
 =?iso-2022-jp?B?Y1VUZFlvMHIxeHhvdE9iQUtCb0krajV0OVV0ZDg0YnovZlBpZGVhMDV0?=
 =?iso-2022-jp?B?R1hYbnBTM3JMNmp1NzJ5UjNicUxsRlptNGJKM1ptMGdoOHhkVzlaK1lt?=
 =?iso-2022-jp?B?OWdYMVVBV3c5K1JTNEhYekdxY1N0R29tY2RrSUxSYzRkY0Y5RUoyVnYz?=
 =?iso-2022-jp?B?ejB6dnVsODlBc1FuYUVGYlBQTmhtSDhqZUI3YkU1V3VBdlpsN01Ncmoz?=
 =?iso-2022-jp?B?WkhtOFhwTWJTNTJWK2JhMVluUWF0bVRvQWNzWUtPdkZhNjRycjlwN1ZQ?=
 =?iso-2022-jp?B?dWNFbEFYNk9lamVPM1VnUW5aOTlvUlJRRFZuM285YnEzUHRSREg4dkQ0?=
 =?iso-2022-jp?B?bGFJckFKSzZwS3hPTVdLZ3hoQUd3K1BwOFBpeGhtNkZQRXc0T1h1eGRX?=
 =?iso-2022-jp?B?b3VBd1RaWXFjek1sd3dPbTZCRFZaQ3ozSklIUktMK2JnVkRvUmVtV0VI?=
 =?iso-2022-jp?B?dG5PV0JZdHJidGxtOFNoTE5oRCtZb0NTZ0VDSTl6R3RSdFdXTEprTWdy?=
 =?iso-2022-jp?B?N1psTUs0TGtJVllMejZpdWQ4NlVyVVI0bE9EN2tKZEJKblBaODBJdzVj?=
 =?iso-2022-jp?B?NkE5VDIwTVg4RHBUSTFjNnhPOENNbm5lY3FpU0swRW5yTFNmUXU3YXlP?=
 =?iso-2022-jp?B?QkY5Sld1dDVLUkxhZUJ3SmRHaDUwY0s1VS9ZR3AxYjUzTmhnK1dSMkIx?=
 =?iso-2022-jp?B?WmQ0bFdFQmI4MXBjQkdsdnk4RXpIWXVpQkVtaU41VTNwakNMQkdvMStm?=
 =?iso-2022-jp?B?Q2V5NXhSdjNYTDV3S3g0QjlEY21Wd0ZXM0x1RGh0ZFBaWHluaDh4Yytk?=
 =?iso-2022-jp?B?QzNvamJJcG5vZ0VybnpLTFZHMEZvYnFudlNWbWNjOStkOEdMdnEzNmZ6?=
 =?iso-2022-jp?B?aEIrU1JueFBpekdiZjZBRXIzNURYTGY3endrYWl6MFdsUXJFNE5IdU9L?=
 =?iso-2022-jp?B?b1RqZ0w1SGhCQnl1anpTUmxtM28rd0RpUlpzeGh3dStvUXZnNE96Mjly?=
 =?iso-2022-jp?B?QzVOMXZJbWs1Z0FCaGdOeG9GNFpZL05SZVBBVFc2cWlldUxzTVEvQmJ3?=
 =?iso-2022-jp?B?Z0NxSDVtVHFCa0RWajNhYXcvS2JOUHF1aVFmRW1McGdsWXhydHRCSkdm?=
 =?iso-2022-jp?B?VDhtZGFMaHNGSmhoMWdIUzhTME56OWpIUVJJbnQzL21CUnhiTEtmSVNB?=
 =?iso-2022-jp?B?bjFmdTdpbGhDNWZ3VVhqYUFISjdxNFlMTklTZlFSUFJ4Wi9IYk1wdXVv?=
 =?iso-2022-jp?B?V2tnQmM4VVJuRHBhdGRVQkNNYVRBcjB3ek9jdkRpZndURERxd2pxeFNY?=
 =?iso-2022-jp?B?elI0UQ==?=
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
	JuS6HvGxPyD+stCHkTd6OTMcT4GL1yzgfOo9VOIfdJxlXEKcLqYZPU0otrptIw4kuKowCeRcz/2bdJEcx5ugM1V5SDr6BzNazHcBVMUllZMp6KpkPsKEhdEHKBE+gNDk2xuJ6y6wfEGBALrlgiddb9DIDBmgRkb4+qHPZX8ZDs+DsvEE/xgJNK4jTvMJBOgq6Jlx+TN9nxqJW3NYYV18fAaQj150wx2Uk85s//PzXHDcoUlT4lFy+xynq798jBvvnnML7iXVyj/gGJsQJk6ORLyxz3wLytLYZLCioJ4M4Ft08Q9G8XmxMx4IYWHJXINvJobBmiDhD6kK6sLM5QCKTOuaW1aZjI+B6ZwCt6u3J0TKjk/ir7RIZ1i7pIuCiIRut2FTw4tznUPh5SyhIwVtNaiR15bzwrJrsUtgaVyMaVMZ4I2lccjTamEYmO5MMElGI0HWl4JFv3QeCV4cyLFGQFIVhAXGHmG2YVsGD3qskYzn7C/4wUSkRfppGjFZaEkFTgN59jIYS7ykFvwyQ0zVfCILTOoI2l5/98f3eEUuib9kB1I1WQ8UOfmAO/F/nsI9wj6v5JDT7HzlThp+ZBtpLkCNhTOWzWqcRwV4LAhSAx/wBr2cb3/438dxkCtVRgbY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a149f-3df3-4eb6-eab2-08dd2ec1ff98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:21:30.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujBIMY+OmCIW3pp7sUxiUKAW6qvhRq8ExfA9PW2D8VzdyuTgP0SjpbmTRulpv0gaf/L6aTxzjPdoMobDcEZrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11753

Hello,

I hope this message finds you well. I have a question regarding the use of =
CXL memory based
on the v2.0 specification, and I would appreciate any assistance you can pr=
ovide.

I recently acquired a real machine equipped with actual CXL memory, and I'm=
 attempting to
create a region using the "cxl create-region" command.
However, I encountered an issue where the command returns an ERANGE error.
Upon investigation, I discovered that the get_free_mem_region() function in=
 kernel/resource.c
is returning this error.

It seems that the function is unable to allocate an area from CXL Window 0 =
due to it being "Soft Reserved."
Below is the relevant section from /proc/iomem:
=3D=3D=3D=3D
89d500000-89fffffff : Reserved
8a0000000-189fffffff : CXL Window 0
  8a0000000-189fffffff : Soft Reserved  ------!!!!
fd00000000-fd03ffffff : Reserved
=3D=3D=3D=3D=3D

In contrast, when using a QEMU CXL emulation environment, there are no reso=
urces under CXL Window 0,=20
allowing get_free_mem_region() to succeed and enabling region creation:
=3D=3D=3D=3D=3D
100000000-47fffffff : System RAM
a90000000-e8fffffff : CXL Window 0 <--- there is no resource.
ec0000000-bfffffffff : PCI Bus 0000:00
c000000000-c00000ffff : PCI Bus 0000:0c
=3D=3D=3D=3D=3D

From my understanding, the Soft Reserved area originates from EFI_MEMORY_SP=
.=20
Additionally, the CXL Memory Device SW Guide Rev1.1(*) says the followings
---
The only cases where it is recommended to omit the EFI_MEMORY_SP attribute =
are those
where the system contains exclusively CXL memory, or where CXL memory is in=
terleaved
with DDR memory or where the CXL memory is required to boot.
----
Therefore I think this /proc/iomem map is natural for the real machine.
And, I expected a region to be created from the Soft Reserved area, but the=
 actual behavior differs.

I'm confused why the kernel/driver rejects creating a region in the Soft Re=
served area, and I have
many questions.

1. Is this behavior is intended?
2. If so, what steps are necessary to create a region in the Soft Reserved =
area?
3. Alternatively, is the Soft Reserved area not meant for region creation?

(*)https://cdrdv2-public.intel.com/643805/643805_CXL_Memory_Device_SW_Guide=
_Rev1_1.pdf

Thanks,
---
Yasunori Goto

