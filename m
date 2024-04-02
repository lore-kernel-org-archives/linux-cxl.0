Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D241182B3
	for <linux-cxl@vger.kernel.org>; Tue,  2 Apr 2024 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036675; cv=fail; b=Qb5M+MdxbcIJjBed7MtbRKwRfxJE6Q4soXVqiG596Tg5lZT1lPcykhlRdQxNaGmsntrebQLJWG1CWLNvjBH4yhdlO/NK93u2MnERGRBaKglQEzMXoH2WWwloqmVsWl3FBMe8lHd/vBsUfmnY7NIj4nqYrf0KRnJ1HBGV8lv4rU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036675; c=relaxed/simple;
	bh=pYeXH6sZ2kXoMvUYJhRUoD5tGZxcIBY1shTYBljMBmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0HX43DJTlB85kf7K6Boj5wvnonjaXh1ZLksW2j9/NWvRTTaxakC8PpJq1MjA9fVVoB/VG7uXlBOKHTNSDBsx1pLnekQ5LzRMEHw5WTGGAzzZzSTxfnGQxnnTUlg+LRpB+njtch+sUZofCLEWNdyD7Unb5Smzp6mRghCvPWSV7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kPY7ULc5; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kPY7ULc5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712036672; x=1743572672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pYeXH6sZ2kXoMvUYJhRUoD5tGZxcIBY1shTYBljMBmY=;
  b=kPY7ULc5qNxfPV5NR72qQxPhvdWfkuuJzYFjPeks7pJDjsdT+fOGdnYc
   R25LOyrsfhM6IIecRaag3Crs0p6A1ZM1qFJhTehMtClqo4NmdU1OmyzEz
   OgDYwy9uQUQhSacxA3Ph+wtzcfFPqNcUcear8oOUx2fR/YzEqt+X9APfK
   qU+402V22ZQEVeJEIuNEl2wGV4qmOi1NYIW38HwdPp4UWXITqt8GOBTSW
   u+sP4KXyuc+9/OI2pUgc5XiK8Un2fOQakvGIse8xuJk+kHtUyjP+r3XoY
   j0p2mAEEmUnPvpYnhChKq+O8AhljxLGZc/u+6Fxvbyu9V2xQ/DpPjdb1+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="116472776"
X-IronPort-AV: E=Sophos;i="6.07,174,1708354800"; 
   d="scan'208";a="116472776"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:43:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw/6c650z9Q0uFsIWXPnUdkVw/l64V3Lzy9whDzrh54aDhHmK5n7EPwM8+4eWCONvlXPwPBdJuC/Ql3bgbqCgiBfyPNAx1+1krr/2648jMZoREIZrKZzqgiTSTMl1Ef7cfmgybGiswFk0jneuci843gsqauZspuondizn9C1Jour/MjW3nN3AmFXWz4iDMERnelSEPQwdnqJr5ZhLXdOESzsApjlRuEqGJ5vHZQs/7edmniHFqhqUgiqpbsZG5X9+6P39eTjOyqL/7ZV8THNU9r0w+hgMHQ4DBsdZkSAQ+w5nW+cM/Svw+eMKLfyvD9RObUmr/GuOXUUN0pGQRuk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iISZBUssxBC81pF66+PY36FvqLJUXOzIZwWvUg9Xt0A=;
 b=NY30ONTcsPo5ZlDxg4UfRayfo0+RIkyaEGUxFlwFanq/68AHyY28C7PpXBkbThMr3xfZcp4vIks2QXCzHry33Gh9Tpin6d8xhKf7AFSNlZwPe6ADl8P8Yju2DslLPCuYgUbhkxH6rpzyuoEBqhI9HGNSqRBbJijV3kxn6Pha4GM8pfTC5SPHL9O+eh6nnHp8zYHNbZ2+Ci5E4RdpL9Mhb3K/WdLiRThKcWQ5xl96niz9I/TwIQBvDqzfWrrczyVejNqeSd7u6qypIz6ZHCqM/pguModqVAl7nnzEAnfTB/DayLUdGxdSpM4bR58VNX0BfYmKih7BYtRAqeWBA1PoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB10377.jpnprd01.prod.outlook.com (2603:1096:400:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 05:43:15 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 05:43:15 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/core/region: check interleave way capability
Thread-Topic: [PATCH] cxl/core/region: check interleave way capability
Thread-Index: AQHahApDlEHOaLq5zkWtkdipOI8sL7FToWAAgADW5HA=
Date: Tue, 2 Apr 2024 05:43:14 +0000
Message-ID:
 <OSZPR01MB645395029F0EF0AC76589CCA8D3E2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>
 <Zgrl4HTeOPCow/tu@aschofie-mobl2>
In-Reply-To: <Zgrl4HTeOPCow/tu@aschofie-mobl2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=b67d075f-7ba4-44a1-873e-9bcb29a2b4dc;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-02T05:39:56Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB10377:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2sDT1p5PmsqBEo4UtKKr8EYZG6FD67e16RrGEiGcmsiX7HbdBBnxDTwjmmoa3Qp54jRTbEq8rC0zPa9SnfMdxHSvOUZT+FYRvtYiA0aOW13pZlebppcM/i9/X9G/8wi/p948aOyq6xEYRqfz58tPVPieM8AKU1DCtmKFRXTFQxQYMFvQ0fR2LcsTj4tf9CEKZ3/Om4HdmVdSlVBkW3vdwJpeYFrB7UtibrK8QTcOP06lj8U4At1bj1kOQV0hgJrVcFc/jDOafccs0gcYBYiivCtLQS9hVH+4XiWuCtYUSSFbG+AEhj7qauJpnsbuj9L9dLhmDvZMxL/S78e8qO6Ecw1tE5V1HmPmjpTBIFPkKcWMQyC4LgihF1Rm6xiK+l65hxdJRRr75FEVvYrIviaFnxHq7FiPY/t8gMOpXaWqxKAP6+2Y5j9Ob8qxV/cazOGrKwiMpRScdf19ymKk7iYSEpXzitD8BEqzGXvuwdVoCR8JKDUgq8FTrMoPZ2RTwN6aQPf7hVIn+3WhSjqOCYapvIJR6MpQDUQguEwXi+07JhVfLVKSBl/UWl3WLiB1U6cUnUVYp0+QhD1AAU6kVeVB7kC4wl+2hzmeVBTOkQrb6KYZExe+T+k2d3xRhPPJxKg/9iB3M8lW0HeuBXouYGa+I3CWdqjkPwYYXlS8TV649YY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dWIyb1VWaEJUZW85bCtIL1JHNWZrQkFSUnNCakU2aUZYVkY0cGc0ZDND?=
 =?iso-2022-jp?B?dEZvbU5VVmFvMFlPbTgzclZLTTk4SXdnS2J4N0VEdm5oY0ZBSnhBSnZW?=
 =?iso-2022-jp?B?RlBUVVhVakxMNVJvYlJzNEtQZGJVTXVMVEJBSGR0MTdoWmROd3FoVWlF?=
 =?iso-2022-jp?B?VG4yMTlsN0tGaG54YkoyRmJ5a2FRd0wvMndSZUswRWo2d09oSkcwM0Fp?=
 =?iso-2022-jp?B?eWF1MFE4YW1RanhPSmo3em15QjdiWjcrQ3c4a2k4WEpaUkNTYVJ0VkZN?=
 =?iso-2022-jp?B?ZUl2U2hDUW8yS0NOZHU3TTVYNjRwaExVZmN5OTFBSEZHanhHc3FSVWNm?=
 =?iso-2022-jp?B?N0hEMW93c3BtUzRvd2dwc1I5SnZQY3JxYWNUOER4TGR3K096ek9OcTUx?=
 =?iso-2022-jp?B?UlRYZ0RQbWFpQ0FvLzljY3lNWTBZOGVqamVKeUM3ekZsRHI1OEVPRkpK?=
 =?iso-2022-jp?B?KzB1cU9pZEZoQ3dHT0kzSTc0RStzaFNlTkJtR3g3QzgzQ2hEcCs5MzZN?=
 =?iso-2022-jp?B?eXBrWlR2VmNoSVM0SS8yQmFjOUNuR0krb2pac0x0UndsMjMwVVpFS0RP?=
 =?iso-2022-jp?B?cUJ2YmlVZjFRYjlrNG1scGRkcUY0REhuMnU2Y0gvN0pEekJSUlNYN0ov?=
 =?iso-2022-jp?B?V2pzMFBacXMwN2FiTm1oek1leWNNN3JRclRCbnFNQ2pCYjVQeXdWK3RZ?=
 =?iso-2022-jp?B?d3NtRlluVmVYMmZta1ZBMFN1cm43Tmo4ZmFqMlJlYWc2Q3BZcEhRcnM4?=
 =?iso-2022-jp?B?V3c0dkg5anJBWkpCWG9kOEE3YWJCQVROdzM1TDBiNm1QUk4xaUNHdlU0?=
 =?iso-2022-jp?B?SnQ1cGw2a1ZPdzhjejdJUE81R25xaXF0b2ZqNlF6NXp5a09YUG1jaWtB?=
 =?iso-2022-jp?B?ZkJYOUZRNys5Q0JJMmpxNEw3V0lydllqb2FWMTk3MktIVnhqRHdBdWpW?=
 =?iso-2022-jp?B?cmJ6OWtTVTNMVENKQUQvSEdTVTEzWWQ0b1pvbkNkaEgrYnNUSnZqWDdo?=
 =?iso-2022-jp?B?ZFhqMk9tcVE0K1V3TllOV0l6UWJnaGVremUrcGNSWlhpaGozQVdTTWNB?=
 =?iso-2022-jp?B?VWdScTFzUHQ4cGJ5Q0duZ1hyN3BJY1FEV0o3Ulp3S0c2eVJvWWJWTGth?=
 =?iso-2022-jp?B?U044ZVpwSHp2RDc4UGlHZFFrN0dkbmw5Z0NWREpvVTZYc2F4a2hlaVJ6?=
 =?iso-2022-jp?B?VlRBYnZvdC84blhoOVFDRW5qTFpEQVNUeHNTUHBTRHE4SnNKTWtBYXRN?=
 =?iso-2022-jp?B?RmVKUjdyWEQ2c2UzZ1dzTzNUcjRTVEUweXJmdUdPdVc3SUc1TzlaSkwz?=
 =?iso-2022-jp?B?Smhrd0lUeVRUbDlYREpsM2RINzhtaFliNG5PM3IvZU16dGQyTE94MFdn?=
 =?iso-2022-jp?B?UzJVNDI1cFQ1RURLTEh0eXNJVTluYmtKdVVTMG1DR0tPWVZQcXVvTmdr?=
 =?iso-2022-jp?B?K0UxYUFmdVI0TzlyNE9PZGhObnJTc0dWZjdtK1NTNVBwWURkLzZ6VStp?=
 =?iso-2022-jp?B?ZTR4MXhwVDFaL3BHSmRQdVY4ZFlpY2s1WWJNVGJxUUVNbG9aL0RjMFBL?=
 =?iso-2022-jp?B?UCtRTzhIcjFNOTRBellycE9xeUpMbm5pMURPd1M0V0E2cktHL3pMMHEv?=
 =?iso-2022-jp?B?a1B2N3VicElGTnNRNzhrY0xVL2U5aHMyY3BGQ0xaVWc4WmVZYmJaWFJu?=
 =?iso-2022-jp?B?Vll4dnh6NWxhUlRSallvbWsyTWxRNjhCVDhvcWFFTkZ6c0l2Vi9XQnF3?=
 =?iso-2022-jp?B?RW9mTVNIRFNhOEpNU3JVSjlXZFJGdE5hS2EwZjFhV0J1L2RuaURtUk5S?=
 =?iso-2022-jp?B?UjM3WUJPcVZzSkVhdHBuRGt4Q2w0am1ZSFYrNDZ0SGdSbzh1RDZTUEo3?=
 =?iso-2022-jp?B?eXV0Ty9wcU5yUzdKZHlQbXVhQ1RuazZIY3c3dHRhN3NYZFZ0S0N3cWJP?=
 =?iso-2022-jp?B?Zll3UXhoa2lTYkxnUVBZWVVmQUhnWjMySDBteURXUXpYbk8wVHN1QjAz?=
 =?iso-2022-jp?B?a3cwd0FnU0hHdDNwZEJVRHovU01IRlJmWlFXa29pbU1Xc0RDWHVEcUZ0?=
 =?iso-2022-jp?B?NWRzaUR6SzNhV0ZNdUI3TzVJUUF5dzVSa3FFMW9iZzNrZmpHRHBZS1pH?=
 =?iso-2022-jp?B?clQ0QjFlRXd5MDhERjJXR0VuSlY1M2hPK25FRy9LdVdXWEFOS09RRlVh?=
 =?iso-2022-jp?B?NVNjdkp4Y011K25vM2lHRDlCaTlkMHAwL3pDSUtVUUM1Y2RaMHFSWDkv?=
 =?iso-2022-jp?B?Y01hSEcvNWd5MXhjclJyOVpNSzNHKy9NS3F0czMxdENVV0FOYklFdUNB?=
 =?iso-2022-jp?B?ck4zQw==?=
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
	R0I74ltJEedLwYR6Mxo+x5j66naUgDUTvTgl56b1V9LkSsHw+d3HJaaXMYSOXa35i/4R2MyE61IjMm31oc09SQ7i40HaVfd3scRrc8qGJcmSlNT9ZqRRtf2RNSHF7FWwgKxji45j3GOD9lfYHdeWoBcRmUsEDQIud36NMfsT1/Yfsw66IJmzafJJ5dXMMdJrtRObos2ebW5wQohsxge2ztSS152JmD3HVBupW/gO1nrQXIKU9cM+FDJrWJNJE9DdPeWSvcuom7ks3wUpM/OBxwfOl4FsfHZYSx3bxy86bM1JGKIYQnRo6bJ3/3hVQ+DWfexju3NOasQM6gjJpJdJgcMsRwI16QNA8Ysi9e56Jrl2XtAH8MpgOELbl6kr2pDU7VDhDkzNnoiYD/f3uislZ3ywFWEUDJU4d1TKPCBlpyQ9fV7L6XiuKu963THkhmwC1QSYeTmCG6zC50jS/VTVSSpo1ASoeHwPYWigFJ+5CDiXjaGAFCtFH1HJrBp+u0h38upnln9nm9a3pJE8Rd1QLO1ttrz/9IX8N1322GhoLKUQXHiUpz9RJc8D9WvO5i/l8XLNDLNbLa57Biv70IgfkibPxLVD0XP5fxyAKTiubWeCN/KMzYMXrsWt1ULkjKmb
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec64e64-e639-4866-83d3-08dc52d7ca9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 05:43:15.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzYSQ+LM6amotnQqDpw1VchVh3b3/OyPSgmc2rQqxpodf99njwKGpLb0k71pTMOQjeOf6vwdQmFapVh2Z3g7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10377



> -----Original Message-----
> From: Alison Schofield <alison.schofield@intel.com>
> Sent: Tuesday, April 2, 2024 12:51 AM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> jim.harris@samsung.com; linux-cxl@vger.kernel.org
> Subject: Re: [PATCH] cxl/core/region: check interleave way capability
>=20
> On Mon, Apr 01, 2024 at 03:56:35AM -0400, Yao Xingtao wrote:
> > I used qemu to emulaute the cxl.mem and attmpted to create a 6-way
> > region, the region was created successfully, but I could not access the
> > memory properly:
> > $ numactl -m 2 ls
> > Segmentation fault (core dumped)
> >
> > I found the root cause is that the logic of converting HPA to DPA for
> > 3-way, 6-way and 12-way were not implimented on qemu side.
> >
> > But qemu has already disable the capability, so we should not create
> > region in such ways.
> >
> > So I think we should check whether the interleave way is supported by
> > the target while attaching it to region.
>=20
> Nice find!
>=20
> I'm wondering if this may be done where other hdm caps are parsed,
> at parse_hdm_decoder_caps() and saved as a capability of the port,
> as opposed to reading the register on region creation attempts.
thanks for your advice!
I will move this operation into parse_hdm_decoder_caps() in the next versio=
n.

>=20
> --Alison
>=20
>=20
>=20
> >
> > Link:
> https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fuji=
tsu.c
> om/T/#r
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > ---
> >  drivers/cxl/core/region.c | 25 +++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c186e0a39b9..dde66b7c9e3f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1786,6 +1786,24 @@ static int cxl_region_sort_targets(struct cxl_re=
gion
> *cxlr)
> >  	return rc;
> >  }
> >
> > +static bool check_iw_capability(struct cxl_endpoint_decoder *cxled, u8=
 iw)
> > +{
> > +	struct cxl_port *port =3D to_cxl_port(cxled->cxld.dev.parent);
> > +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> > +	void __iomem *hdm =3D cxlhdm->regs.hdm_decoder;
> > +	u32 cap;
> > +
> > +	cap =3D readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
> > +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, cap)
> &&
> > +	    (iw =3D=3D 3 || iw =3D=3D 6 || iw =3D=3D 12))
> > +		return false;
> > +
> > +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, cap) && iw
> =3D=3D 16)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int cxl_region_attach(struct cxl_region *cxlr,
> >  			     struct cxl_endpoint_decoder *cxled, int pos)
> >  {
> > @@ -1796,6 +1814,13 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
> >  	struct cxl_dport *dport;
> >  	int rc =3D -ENXIO;
> >
> > +	if (!check_iw_capability(cxled, p->interleave_ways)) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s with region interleave ways: %d is not supported\n",
> > +			dev_name(&cxled->cxld.dev), p->interleave_ways);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >  	if (cxled->mode !=3D cxlr->mode) {
> >  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> >  			dev_name(&cxled->cxld.dev), cxlr->mode,
> cxled->mode);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 534e25e2f0a4..da8a487ededa 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -45,6 +45,8 @@
> >  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> >  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> > +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> >  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> >  #define   CXL_HDM_DECODER_ENABLE BIT(1)
> >  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> > --
> > 2.37.3
> >
