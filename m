Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C15248BBF
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937564; cv=fail; b=riuKodr+uLwbyT/3qLx49GQvpm7rWzBv0Tk0pm8txRQuImwJLyjIAf/Yse9mYCEkpW5ypiBYXM+3CL1WTc36F0dIsii/rLVgnfM45j1dwD2sxGgPP/WFt9QpPknh2CzfidHD/7CWzyhpiBFT2/qX0NAQoib5LqU3iaf6tk9HADI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937564; c=relaxed/simple;
	bh=wUVhZWd2xHcYzq0R3L/0vWUqLsw6zvPxbpQ0t792nJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O0W1RTwlc7EjOUVsZRIeleLli+o5+S9opHccdpzunZt26731J65pmHneR62yDrTaxvJ34bQ1XM4HtHetsr7uyIM4uXxf3USK7PZxcM4PJdm9Wi9y85sqwqPq/ArnSHKsILjbZmbLMN/+jjCfbD+udLPX04N4jswvUslQ2xs6o0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nW2L5ZuI; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nW2L5ZuI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736937559; x=1768473559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wUVhZWd2xHcYzq0R3L/0vWUqLsw6zvPxbpQ0t792nJk=;
  b=nW2L5ZuI33phzWLUuer8mICxtRWXOdMzIcp6eieSSob5MCFJKWmxIcPL
   1KZqYv7T0rgNs9EoDy5pYNoIhb3YrET7dIxKzx8RP0kj1z3DTcDzfbr/T
   wD32161e/5BdMaM6iNBOZiRvS0a8Ed74/sPUeXPGkNSFoxWMWyk+Q1Stx
   aaisQry+Ox8bdJpG9o0oO50mCq7t/MMlfuyoUyIBRrenjmRwhMTINflde
   lv/bmG99dEdeBpYgsrOXuOZi14w7RxD7naGbDvk7Q5DtjcvnTE6b/1SnZ
   BNL6QdLpcSw7/FzIQvut2pB2EneD7veS9mY2tlQKOLYyHb7CxzSIHumjk
   g==;
X-CSE-ConnectionGUID: KNG31RgaRm2tQq8A5k3jNQ==
X-CSE-MsgGUID: oSt4sCAdRcmYx71d+1hUuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54203049"
X-IronPort-AV: E=Sophos;i="6.12,317,1728918000"; 
   d="scan'208";a="54203049"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 19:38:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj3Kx5EtkMB1bn6VyNM9ufONvxfOCgWPaa5RsNfeTJ/hl5uh4ADwNLxtaptCJnAHoB/JAJMO9BsSsBZOrXVUty4aEvkCQz1+IZf0b61yVIf2rLnwSXU9g6m3iv4sbk4kHFcm5/0k33zVTtHmM8vx7ZG2TB+ZBHia5TZDdE6lqNE2EMs66xB9VnEzWWK6Fn6r1MJWrVDcknsfUEyNZQSlNMXfJXw5t6deZJBcthShZx7z2Znhf/yHvjidwGpDdzgNFDIC9nmnFomQg0xvJsZSbXEsoQ1nJc/DX+EZLY7ghZQHyPjyu+V/kvDyt0dwUzhJOQ9eULmeWXX9ToCZpGaqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdDzgbctVYwDnV7H5cV+jgoBlgywfEyfPo5xM5aCFW4=;
 b=MygmC3+tnRkuMNXLiCNShEGn5K9omGr20rWeFlLcW1OX0S7FnyM9XOouxu4B8XsTHxDy/kvtg1HnoqCBvZTEsmgGAf6mPnmDSCEHeCcWgRsyHakvSB3yHpuDhgYNn4XX8isSIHveOtfe/1UKjHPYvFTTiJisacLOjpp9Tqryjs4eIXK0dHwXC+LcVQN/w+E8atWElAEuR/94KwWPnZUuymNnRMCgM+2JDEEGTTbXVkIWC9+BHCfy9P7yG06G8ZCHZtUhmd1s7aAe05MBf+J6p5Pd6U56o+IH/XG2f/YOvacHAmWWLMeoz6gts9jXumCtdl7fhKrNNjE0zEqzjIjW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by TYCPR01MB6078.jpnprd01.prod.outlook.com (2603:1096:400:4d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:38:04 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 10:38:04 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "mj@ucw.cz" <mj@ucw.cz>, "Daisuke Kobayashi (Fujitsu)"
	<kobayashi.da-06@fujitsu.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: RE: Unable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Thread-Topic: Unable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Thread-Index: AQHbZzmO2fNEPH1QE06FI7LAAbpIwQ==
Date: Wed, 15 Jan 2025 10:38:04 +0000
Message-ID:
 <OSYPR01MB535257C0AE84CC123A656E1590192@OSYPR01MB5352.jpnprd01.prod.outlook.com>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
 <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
 <OSYPR01MB5352F167B18CC4DFC908D692900D2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSYPR01MB5352F167B18CC4DFC908D692900D2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=6dae4479-6769-4acf-8479-1a74781f9eb3;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-12-26T00:58:30Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: c9048dfad35f4366a8dd817f043470c6
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|TYCPR01MB6078:EE_
x-ms-office365-filtering-correlation-id: ff72c7f4-348a-48d9-307a-08dd3550b15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?bWRxZzd1TlMzUFhaeFdzdVk3bjJza1RrZUNiTzA0dUM5RVFRcjgwaHZl?=
 =?iso-2022-jp?B?d25KbUJtbUREUjhNY2Jibk1tR1E3VG52RzYyREYxdlQ3Q2RzcE5QbXB2?=
 =?iso-2022-jp?B?VGdPQzVaMHJ4TEhHZ3Njd1FBRXdneGlzUDc1VElHQkF1R0hBWDdSaTFP?=
 =?iso-2022-jp?B?dklFZ2ZtcytPTVYzTys2T2JPbHRKQm84RUlGWi9rMmVsMDMyYzB6a004?=
 =?iso-2022-jp?B?T0ZGZGgwcVJlWGlBREVzZnlHVERsbU5ScHp2Z09oYytoTURNakJaM05G?=
 =?iso-2022-jp?B?OVdldVpwUmh5RkhmVWhKZEhvOGZvamkrZDVOQWJhYUo4WGVMSm1GUDhy?=
 =?iso-2022-jp?B?K1lFVFJ1aGcvUUlyTktYM1l1TmVhTk9FY2d0eHEwcWU4Z3V6RDAyUU9S?=
 =?iso-2022-jp?B?Y1lIb3I0OTI0WVpJT1lQSmhEajdpaFZsbGxRUHg1UjYwcGZZbXBVLzVk?=
 =?iso-2022-jp?B?cVZSemxIMnY4RG1FeGtURHJnZGZJekxOYlRTTUI2Qm55OGRUK1Q5Szl3?=
 =?iso-2022-jp?B?MDRJQ2JDMUY5eFpubG5nd1pYYXgwbVE0TmhRLzcwa0U0UDJxUy9EdkNZ?=
 =?iso-2022-jp?B?OFpsaGZxNkhMWXBxSEZDbmpwNHdhdENZVmNmWkl5aTNkRXFjUUxzL3d2?=
 =?iso-2022-jp?B?Wm4vakw1TXZadXlmRHI0R0VvSlkrMENWdnQxWCs1MHpGUUE3c3VaaHlU?=
 =?iso-2022-jp?B?M2s2cTRySGY1MmZ5MkxMT1J0MkFyb3psTWZiSTJnY25JWWtNcXZDUHVO?=
 =?iso-2022-jp?B?WWREamdzQkNveDhOTERobU5IN3Q1dlJOd0tZTDJyaFlTMzFnMVNXbmov?=
 =?iso-2022-jp?B?cy9hYnhETkV1TlVUTkJBT0daS29aNVZETDk1NDg3eGI4U3ViWjRiYmlM?=
 =?iso-2022-jp?B?NW5jNkloajZtajh6OFFWczZVR1FWMkgyUElHSkYvS0JRV0xGdmVzMHg3?=
 =?iso-2022-jp?B?YmcvNGk5OG1PbWIzZnZ2VU5ueVlhQURxWHhSbGNhYXB0WkxFVWkxZG0r?=
 =?iso-2022-jp?B?cXFGOGdNZlRtM1lHTFlHMXhuMzU1R0ljbUNCanhmb0dYSHRIRXB6ekFX?=
 =?iso-2022-jp?B?WC8vL0l5RE1IditINkcrOUtVU2JPeEcwcjB0Mm15TEp1alU0Vkt6eXVk?=
 =?iso-2022-jp?B?eUVuZ2Y3aGovNktXR1BlQnlQUTQ5QzNQOEdWR1psQ3RCSDhQZldhY3Fw?=
 =?iso-2022-jp?B?c3dDamZRSjBsTmdNd0pjUzdkNGwvdEFsTkx4Y05kbjdEQ1lFcmp3Z2dO?=
 =?iso-2022-jp?B?L0VDeWdLV0s2Ni9zb3Q2OTkvMndSNXJhMlc4cVVnNStpbnpPaVgyb1d4?=
 =?iso-2022-jp?B?ZFpUanZyVGJqeDRGZG1vdkxvRzJVVFEvNkhrSktvU3ZOZjBkV2R1YzJR?=
 =?iso-2022-jp?B?ZzZWVHd1aTAvOTZEME52K3lDbmhpZTd5cjhRV2RlVHlaSnhIaE5LdGNN?=
 =?iso-2022-jp?B?ekNsSXJGRHdYQTREMkYyc0hlR2JQeGVNMUZ3U2pNTG0zcllrZ240R0dL?=
 =?iso-2022-jp?B?bDhQcTVNNkhZZFVsdW1uQkMrZ3lSWDM1Z29QVnNSMGVSZlljS05NRVpL?=
 =?iso-2022-jp?B?Vm02Y280M2JpNUsyWXl2cy9HeFkrYUsweVZyQng1Wk9BWGMwaUNDREhQ?=
 =?iso-2022-jp?B?ZHZtcUp1RjR0d2ZNUmpiQko1eWtERVA4ckQ2S1J2SGpVNUFZbXZUUTha?=
 =?iso-2022-jp?B?c24xRXZyRFNsb0lXdGhicG1zTUJTVXppaWNNdHFkdFVMQ1N3MG56WU1z?=
 =?iso-2022-jp?B?MCtNenFhenpHQ0o0OVVDUFQ2M3pJSDZjamtqMlloSjBpbmFWVTEva0th?=
 =?iso-2022-jp?B?Sm0xeVN5bGV1TGcySE80RE5JVnBvYXVlQzlHdXBETzNhSzJlUk1PSERa?=
 =?iso-2022-jp?B?VzNIQ0V4TjBRa3hiR2VhdUNnYVdlbDRmck5PTnFkZmRZUTVNS2VteVJY?=
 =?iso-2022-jp?B?MVdKUnQyMjl3bFNJdncwbmtHOFZranhvUmNyMWVkeUtMZ0RCdGV2V0VP?=
 =?iso-2022-jp?B?emc4bFpKVWlZZUV6b2lhNWREaktDTGpyRkhSTHh2NStTdS9vNUptM3pP?=
 =?iso-2022-jp?B?WkMybUhUWS9XS3ovRVZlYjVWYUV4bnVNKy9CcXhuMWNnYjhwNlJzSFls?=
 =?iso-2022-jp?B?ZVljSWM3TkNSV2ZSOTNsTVlHcjdlaEdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Uk13QnNmb3lSd2tiTEIxS3ZSdHViUDF1a1ZqK2lJa2ZZZTdJMDZpVm4w?=
 =?iso-2022-jp?B?RnBCMk43eWgxZEpjUUVGdmpxUnpmMVFlbzBKcGtuVVVJZjVvdjlqMThv?=
 =?iso-2022-jp?B?djYwQWM1clYzb0tmblNzQ1RIVlJBK215eElGdk9aWk56VXI4Tk1Ga1N3?=
 =?iso-2022-jp?B?Wi9qWnd4Vll6ZjRuaWZpajNybFhQaWVtb0UzeVN4VHZRNHdidW9mdW9V?=
 =?iso-2022-jp?B?b3IybmwzMlZPaDYrVFhaSzkwV3hoSUNiMVBLSnVtcFVHcllpb0JjQ3RW?=
 =?iso-2022-jp?B?VkJ5OGZTZ3ExVVRXZWVXcU14Sk5UNGZCYWtQZ2NSSjlKOGxVVmJqZGI5?=
 =?iso-2022-jp?B?czRCMFVzUDIxa2JEazlYRGQ1a28yQXlPTG5TRHV6c2E2SloweTlWSzJV?=
 =?iso-2022-jp?B?OTMwcnRJcm50MndPN2FPTDJwSDRKVDZ3ODBNcHFPVDJPcDB1TlhkQUla?=
 =?iso-2022-jp?B?SDlTcmYwSktRTDhTKzZ5L3F1bVZvL3FNL3hiY1ZzRUlxZ1lvZmRzM3Ni?=
 =?iso-2022-jp?B?T3VwY3Z2blJNdThGbFFrQ1JzNXNsQVR0VUNUY1RxaGFaWmtjUjBJaDFN?=
 =?iso-2022-jp?B?V0NGZ2Z0ZnBuRFlmc1RHSENwckhZNkZ4M0tVdzFQS2YyaGNqZjUzUUJz?=
 =?iso-2022-jp?B?dlg3b1ZNY3QxelpYc2NzeXhrZ25MdFQzN1dzSUZPRzFOR2RXemdTa3gy?=
 =?iso-2022-jp?B?alVOZXEvVTJqbjhvUU9rMDJ3bzIxaFFlV2NSa2RxSGZBUnk3aUFVMGhW?=
 =?iso-2022-jp?B?eTMxYnVVZjFQM2Z4WXZQZVNpYmJCdjU3Z3hCNzFRSkRTcldQWDJFd2hU?=
 =?iso-2022-jp?B?MnBXOEJTd2hhc0lqclhpbUVZVkxISlpycnBQQWdFa0xBZ1FaVXAwVVdV?=
 =?iso-2022-jp?B?MDZ2TDE1RG1zWHluN1g4azFhVkwwTE1uUEdkRnpMNVNMWGtWUEJ0MzB3?=
 =?iso-2022-jp?B?OERaUm40VWdsSDJBdGEzVkxvZStraWhmK1M3dTFnZ0FubmMwK0FROTFr?=
 =?iso-2022-jp?B?M2JVN1dUOGVYdUdNVkQzQ0N4OEUwaStrUGtXS3FYKzBjWHpMRzFjM3VW?=
 =?iso-2022-jp?B?VU1oOUhGQU9lQjN0eWd1c0JpRmVyWjNBeUVhc05RVy91YzJiK0xzdE9S?=
 =?iso-2022-jp?B?aGIxam00eXRXWi9jU2FkdEwrRVJNa2o0VVVQUG9NQ3ZhMUV3dXBSbmZi?=
 =?iso-2022-jp?B?Yk93RFdCRUhjRTRLZlh6dEduS2p2dWJrcVREQXd2L0tVMmJQbExrbzda?=
 =?iso-2022-jp?B?NlRXdkszS2taZndINlNnKzl1bXdHcHVQRmtSbTRJQnVGSmNzd2I2YU1y?=
 =?iso-2022-jp?B?Y3lmVHVUb1F5TlZoamVkR1VzLzFUL25xclFoNmlOeWNheW1sZVNsQlgy?=
 =?iso-2022-jp?B?YkdublRUWTl4Y3R6RUdXcXJESHVucDU2WURUbTBtYkREOEVPYVNQZ2Ny?=
 =?iso-2022-jp?B?eW9SMHUwVFJDVFk5dFdEc2FSNGtRREp3YUU0Q3dPUnN3Z3NpUVFEczlz?=
 =?iso-2022-jp?B?VmdHSDJoMnZ2TWtpZXVRRTA1dm12QU83UkFxaXJOV2QzM0hMd1VNbVBv?=
 =?iso-2022-jp?B?S2V4dHdkWnFHTGRsN1YwczEyczVxN2hhWGMwRDFBWUJLSzVSK3ZMMnov?=
 =?iso-2022-jp?B?RnN2WmRXRHRwNS9oQW5Xbi9xTGZIUkRya21HRlp2MmJtSmVYcm5oNHZp?=
 =?iso-2022-jp?B?L2JhRFhEcy93em80UnVEZldudExYWWxSS1dJdWhQSndjS2F4WXVGd3BS?=
 =?iso-2022-jp?B?aTF4NW5sMldWZDJaSUFxazczQUFDRkkrNWk3NmRRUklaSjQvSTJYTG5U?=
 =?iso-2022-jp?B?TlJkdGlIVTBGRTRQRnFlYkNhS3FmOW5LOTEzemdYbWsrZWZvYmZtQkFW?=
 =?iso-2022-jp?B?TnU2WGt6Nmdtd3RYTU9OdHBoWFF5cjhHbCtwcGRId05RVkJoNnoxaC9U?=
 =?iso-2022-jp?B?SWZUZmFFZ0VEWGxWVDZEVzduVkljZ1VnNGtvUTE0cExaK0REQWc0Nk1R?=
 =?iso-2022-jp?B?YkpPQmxOZStUQ0FKSXRya3lTZ1V0cHNuMEZudllLaXBlb3B5OWtLOE10?=
 =?iso-2022-jp?B?UHZja0RWMktIWll0T2lZU3F5NS9PY01iZ3BXbEczNVhNQ2tJWld1aUhw?=
 =?iso-2022-jp?B?c3A0bGVmSW1QMmdoVnd4cDNwdVhWMzFTcXNHNWJ2cVZ6QVg0U2VyakpQ?=
 =?iso-2022-jp?B?akl0STQ5eFNIMnp3VnZpVi9NWFA3VittK05xeTJlL1VSUHoyelcvMCs3?=
 =?iso-2022-jp?B?Tnd6VWZQdnZDUklsREhoam1NTHc3N05PL3o4azdKUGxicFlGK1BJOS90?=
 =?iso-2022-jp?B?ak9DYg==?=
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
	ijxJ7r3ILTMLdnL9r+0NpXJwFPLX+i2nRIM5Y8wS5gsU4VmIN8LBjMSrT2eMOmcP2kCJrEGGjy14laZbuXmxGdTANVfhOJgLpokZKyVxP9KZNBkeL2uvqGTGU2rL/rPDuOuYgdaZcI0N68n26oEHpFwMVA8woU0i9rN/Jos4fs4BY4pqlIjEaeN1di887B3XwF4xRFHuoBmD1wFTSGEqAVnZ3x1XAyxB+YAjyQHaT1JooIeYW6UQMDksMm0TgCXn+ihNFLBrjqWDg4I+MNEwFVo78Ct6SkJ4jiu+gx0iaO/goeDN9CNdhIz2UyuceGMh2y3oLo7HVZPsNfUW5OWHOu0WUsZGMckRHl5lm3nxQkeM0WzuaeytU81QWawn47swEAsc5+FUq6e3apCCd9JAMEWXnJiG6dQGUXaw9mwIdT0PJhtKDnBNeLThxYIDD8uDA49Yo353DAlONoFPlDuNB5X3flL+3JM1PuYzD0XMoxOLdUlzTgt679bNwqliab+ptvIy2GkA9qTKVp8dhwKbcSOFgX+xiEKZ3CrybH4jAtcgvC1EYKYB/hEMMNAhUNoxKIbOHutnfAmLcMh8ZclZnP1puFApCxYteTNdS9v3NA11Dwyr9ELXAnPqOYFy6ya2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff72c7f4-348a-48d9-307a-08dd3550b15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 10:38:04.5718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teSK4yn9AOlnS0z+w2HXUD1DSNuI39Y81IH0NOivoQXhTy1EzC0HDnAPEnQFwtKni6mLy1bEj/NawrRRIOyzKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6078

Hello,

>=20
> I was able to obtain a real CXL1.1 hardware environment and tested this f=
eature
> on it.
> However, I found this feature does not works. (The kernel version is v6.1=
3-rc4.)
>=20
> Here is the output of demsg.
> =3D=3D=3D=3D
> [    6.228015] cxl_pci 0000:16:00.0: enabling device (0140 -> 0142)
> [    6.228351] cxl_pci 0000:16:00.0: No component registers (-517)
> =3D=3D=3D=3D
>=20
> This means that cxl_pci_setup_regs() returns -EPROBE_DEFER; =3D=3D=3D=3D=
=3D
> static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type =
type,
>                               struct cxl_register_map *map) {
>         int rc;
>=20
>         rc =3D cxl_find_regblock(pdev, type, map);
>=20
>         /*
>          * If the Register Locator DVSEC does not exist, check if it
>          * is an RCH and try to extract the Component Registers from
>          * an RCRB.
>          */
>         if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT &&
> is_cxl_restricted(pdev)) {
>                 struct cxl_dport *dport;
>                 struct cxl_port *port __free(put_cxl_port) =3D
>                         cxl_pci_find_port(pdev, &dport);
>                 if (!port)
>                         return -EPROBE_DEFER; <------ here
>=20
>                 rc =3D cxl_rcrb_get_comp_regs(pdev, map, dport);
>                 if (rc)
>                         return rc;
>=20
>                 rc =3D cxl_dport_map_rcd_linkcap(pdev, dport);
>                 if (rc)
>                         return rc;
> =3D=3D=3D=3D=3D=3D
> I investigated inside of cxl_pci_find_port(), but there was no entry conn=
ected to
> klist_devices.
>=20
> =3D=3D=3D=3D=3D
> struct device *bus_find_device(const struct bus_type *bus,
>                                struct device *start, const void *data,
>                                device_match_t match) {
>         struct subsys_private *sp =3D bus_to_subsys(bus);
>         struct klist_iter i;
>           :
>         (snip)
>            :
>         klist_iter_init_node(&sp->klist_devices, &i,
>                              (start ? &start->p->knode_bus : NULL));
>         while ((dev =3D next_device(&i))){  <--- dev was NULL due to no e=
ntry
> in the klist_devices.
> =3D=3D=3D=3D=3D=3D=3D
>=20
> As a result, cxl_rcrb_to_linkcap() was never executed, and no sysfs files=
 of
> rcd_xxx were created for the cxl devices.
>=20
> I suppose that this code expects a function to add entries of klist_devic=
e for
> CXL1.1 devices before executing cxl_pci_setup_regs(), but I could not fin=
d
> such a place.
>=20
> I hope this issue can be resolved, but I'm unable to find how to fix it.
> Can anyone provide some advice on how to solve this?
>=20
> Fortunately, I can use the real CXL1.1 machine for some time.

I investigated this issue a little bit and I discovered a significant detai=
l.
The "ACPI0017" is NOT defined in the DSDT of ACPI on my real CXL1.1 system.

Consequently, cxl_acpi_probe() is not executed, and I guess this prevents t=
he addition of an entry to klist_device.

I suppose that the current code assumes ACPI0017 is defined; however, it sh=
ould handle cases where it is undefined.

Thanks,


>=20
> Thanks,
>=20
> > -----Original Message-----
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Wednesday, October 16, 2024 8:40 AM
> > To: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@f=
ujitsu.com>;
> > linux-cxl@vger.kernel.org; dan.j.williams@intel.com
> > Cc: mj@ucw.cz; Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B
> > <kobayashi.da-06@fujitsu.com>; ira.weiny@intel.com
> > Subject: Re: [PATCH v18 0/2] Export cxl1.1 device link status register
> > value to pci device sysfs.
> >
> > [ add Ira who is covering for Dave ]
> >
> > Kobayashi,Daisuke wrote:
> > > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > > the link status can be output in the same way as traditional PCIe.
> > > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > > different method to obtain the link status from traditional PCIe.
> > > This is because the link status of the CXL1.1 device is not mapped
> > > in the configuration space (as per cxl3.0 specification 8.1).
> > > Instead, the configuration space containing the link status is
> > > mapped to the memory mapped register region (as per cxl3.0
> > > specification 8.2, Table 8-18). Therefore, the current lspci has a
> > > problem where it does not display the link status of the CXL1.1 devic=
e.
> > > Solve these issues with sysfs attributes to export the status
> > > registers hidden in the RCRB.
> > >
> > > The procedure is as follows:
> > > First, obtain the RCRB address within the cxl driver, then access
> > > the configuration space. Next, output the link status information
> > > from the configuration space to sysfs. Ultimately, the expectation
> > > is that this sysfs file will be consumed by PCI user tools to
> > > utilize link status information.
> >
> > Thanks for all the work on this. While there a couple things that
> > could be cleaned up it's not enough to require a respin. So, for the se=
ries you
> can add:
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>

