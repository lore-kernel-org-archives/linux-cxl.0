Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EC33F6
	for <linux-cxl@vger.kernel.org>; Sat, 12 Apr 2025 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744449860; cv=fail; b=arBUN0TRKSEieoadL86R3MyOxhYIZfSb2gPOHotBAlvALTI+u6LPnkzu6ymll+Gr2nsWs8ZSWlXyHZT+ZX1QkeNQ0wzB3RRQRkpGV7bFH9n6FdY1gyBzn+gVFkjHNMzGFZIHswmrjAsPo8hfazu2SpsK9BvcYHCNUdObzvPCiYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744449860; c=relaxed/simple;
	bh=3Jz/F7vcVIsi/gr2Na8giO7vMRBmfMuHatSUt9IcTyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjxuoM+T8PjrbqwREnymMs52xcKnCOo5avcsQRKV0/K6HG1om6QYnsLmMNlZd6a+mlDgY2iMo3MXF4IZ8wKTrekfemBlJJPZpzSeZJXirVWfHjsfCYGgqX7j//Y5HRAVU51IcHcpn2wnhJSK5LnzzXh8pwe/siqUsmSDHlzN45A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Q1kqK5s8; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Q1kqK5s8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744449858; x=1775985858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Jz/F7vcVIsi/gr2Na8giO7vMRBmfMuHatSUt9IcTyE=;
  b=Q1kqK5s88868bSeaZPSnA0TBFeJEuQBqHt+B+YZNfKADQQXwJXq5akHr
   aQ0aFymXk/i0V5g/Y3ZqPAijDq8zhtOnyUPcw/bjlGyqdSfSxqnmSu7sJ
   srRfbmYzj1HePeXoXl64dhLCKDcea4JKZlFCtX1neqUfoNCmZfmjh4pr+
   Keisn7aGEZmESjwQdDG3eSzDVwUfhvU6kXTRj+Y9WRhNZsb5NlJiMhpwZ
   U+UlzBKhPn4f+dUEmPTQIyCMzJYnJfkcvhBnXVnUMhPZ6PogiFJo3+vit
   iz7OA+mWJFyzuUL1GX5hycgOrwVvV1oyo2Y+o7yFEKta4sIGtTr36Q5BC
   g==;
X-CSE-ConnectionGUID: 2ZGEcQ/gSxynpt0juyT0qQ==
X-CSE-MsgGUID: SbQK976gSUuWiQA5eCnCdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="152587695"
X-IronPort-AV: E=Sophos;i="6.15,208,1739804400"; 
   d="scan'208";a="152587695"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 18:24:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz7zzE40cnZRAj8mIpD/D5QUokA81CHZGwwP6wS8XWbg5gO0iXwwv7eI8H3kxEj8vf0y0MBCDNZYZkYCBsM3bGggh/kPJ4GjfPdV0ep/b0W/dtJvxQ3ZRbiSwo97sV5eeuYI7zJzCM5ZATtzZL68YGklFHQ9/2VtCrr/cncaIbMuxNSE0pZzJks6nAmDr1l7jgprs3yhq0mSOw3nRaE9mjEgxZqzRYOF8haX/6mSYfMOjTh3Mu5sY3bdxDw/S3fakMWs2cxFc/Q1CXeP8yIUup2/Wgvo+lG7M45AGxUZ0t05JpHteJPMiQDIX9X4mQhzzVSMtS0fC+57Z2DtZGfv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jz/F7vcVIsi/gr2Na8giO7vMRBmfMuHatSUt9IcTyE=;
 b=wUfJ/+S+eDUbpoba4JWSlZBjlSNQz0cKYUruJwtBkIvyxh73O28sTNvh+3HzfQPEf5aFWzJ96kXD5FocpQhYsNr/BRK2j3QBsa94wpX1ArG0RuZZy91lIQkdyZHbThNIA94Y4XjLqbDwL3WjuwzmXQrToTad1Dp1tKjncFiW6Ehzn2XoWLUT7KIOUcXmCXLLYk/1VZkKgAuLHuHkBcQgESBy4GR6KaLdd4KXF8vf7FJYmyv0JH8V44eux+O6xDkTTrFXsLRj7yxSHRQWRisf69matLaJJp2ndsZizwUdTvE+bJGM0ZTxSqFLpM0q3wK9HpFG9TrpwtSBGCSJidTnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by OSRPR01MB12029.jpnprd01.prod.outlook.com (2603:1096:604:22e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Sat, 12 Apr
 2025 09:24:01 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%4]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 09:24:01 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [ndctl PATCH] cxl/region: Prevent destroying region out of order
Thread-Topic: [ndctl PATCH] cxl/region: Prevent destroying region out of order
Thread-Index: AQHbqr8OQhb4HNsRdEmiMtFgLwp7AbOerFsAgAAUUYCAAP/TsA==
Date: Sat, 12 Apr 2025 09:24:00 +0000
Message-ID:
 <TYXPR01MB15666FA81735FE979FADA7E9A5B12@TYXPR01MB1566.jpnprd01.prod.outlook.com>
References: <20250411085218.120312-1-lizhijian@fujitsu.com>
 <Z_lG0JsvfS0husxj@aschofie-mobl2.lan>
 <67f957db28b12_2ce6294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <67f957db28b12_2ce6294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=62afd253-78c1-4643-9372-354b6de84877;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-04-12T09:23:56Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|OSRPR01MB12029:EE_
x-ms-office365-filtering-correlation-id: c3c8874b-7c29-45f7-a4ef-08dd79a3c29d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?gb2312?B?ck83ZWpGN3VKRGFua295TnlXREJlMjVJUVF1dWxqMjgxMWhNQW1naGx4MzNq?=
 =?gb2312?B?dTNoaysveTk4dXMvTkF3dG10Qm01Tk42enlaTG1VbTFDVXZ0azBZZ2FXSnhj?=
 =?gb2312?B?T1NQWFVVSGc2eXZ4NitSMW9QZWtDZmdMdVdEdGlYVlJoODJrNVlKMVFWMXJR?=
 =?gb2312?B?SE1VRnNzeEFBYjMzTlFTbzJoMnMyWUo3OGlaWTdHYlUvYVVVdWppdTVsQUor?=
 =?gb2312?B?WHpYZHBOb1d1T0N2ZEdmTUNOZHh5WklZSVcxYmxxRDI1V28vd1hBMUNVcExX?=
 =?gb2312?B?bmJtVCtUQnR3VTNtb0srMEVaV1hHcFVSS1RBanVWYWJtVzFGNlZYN0lOTEVV?=
 =?gb2312?B?YUN1OUtaeDB5a0lBK0ZpZXJIeis3Z0lldlo4bjlGNStDalRRdG5najNIdml6?=
 =?gb2312?B?cmU3UlFzenhyQUVmU1BaNzQ3Q0JQQjN4UnpJdlllc2QvcDM5Rk5VSnQzbkRa?=
 =?gb2312?B?bkE5V2MwUWw5TUdDVVRldHArcXU1MVNxUUpsQXlvbkhFODYxb3VYVlYwMzRz?=
 =?gb2312?B?RTRPZ3NIQUVwZmVPK3FnMDlZT05jRG44RWllbEEwbFdadlZRRVBMUUlJR3Bz?=
 =?gb2312?B?UnVQcW1ONkJNZ2hpL1RmS1MxNkVha3JvQlV5OHd4Q1RxUWFaMktqcTlGUjk0?=
 =?gb2312?B?RlNHaUZXekVwN3VQR0Izemk2ZVh0ZWNheUFKZGRkcWViSEVIdXNCYkVGWElj?=
 =?gb2312?B?dlNwMGVrMUpPbVZTYU9SVGpoRTdTRDhISkZyckwrSUFaNjd3WjFwT3lLekgv?=
 =?gb2312?B?dHJYNGFKUEZMNVhnZjVxRXdhbktWUHNzMXNlOWlzS1pZc2tlbTNKSXRGUmZs?=
 =?gb2312?B?N2dvZW83SG55OVBGbWhtb2hBOERHS3lwNkpFdVBEUlpPSWpTRkl2bzhWeDVD?=
 =?gb2312?B?VGpRK2h4ZHVET2ExVU5VQlNvR2R5bnZia1JzdTdLd2JzWE5vSTNscXBkNDQ3?=
 =?gb2312?B?YWx6d1Bsc3VjMk5jLzl1M29zaTROZHlWbTU4QysxdGRVK3JydHlGNUdwN1dm?=
 =?gb2312?B?eEZQS2dhWTN6SDVPc1JRMDROS3pJMmZXdGM2WDJiOUZHdjZMemVyY2hpVXEx?=
 =?gb2312?B?M3E0cys5eWxRK0Z3d3p3S1UrQXhmRnBPTkRweWNSVUhpNDdNamlBU3dYYVdu?=
 =?gb2312?B?dTBmdHdFdUZlcHdvTWdUdDlLRWovaXNoSEhmTTUxTjBuQWZMMEplUVFMYWlC?=
 =?gb2312?B?M2Z1dDVoNEJ2ZnpCOGhqM2hlRnl1SnVEVnlsemxBWCsxSUEydHUybVZEaXdQ?=
 =?gb2312?B?azJ3cEdwZ1Y1WWkvd3plRG94OTh5SCthT29oOFZCWEQzM1o2bnY3OEpNOUxr?=
 =?gb2312?B?TTJWQWx2Sm4xN0MwenNBMEk5SnJ2aWU2c0pCUlVSNXUrek5vcm1BWnpSa1JI?=
 =?gb2312?B?Z0U0MG5MSkZIaEhjTTltOSthcEFBMUwvMSt1d3pkNFI5c1FpSm82TGcrRmNt?=
 =?gb2312?B?OTdOUkt2eGdiSnVhZXpHTW1WRmFwNHIzSTErdVIwQit3am9RMnBVZ1ZzR09O?=
 =?gb2312?B?cFpsSG9JV0tVSjA5dTQrVUViU09VajR5dG41RU9lMHRHb0I4SC9EZ1ZkZXhX?=
 =?gb2312?B?RC9IbzE5cEFBQk9XdUtoamg1d3QzM1A4ZFVIRm05bVd2WS8vOGV2S2NjN3FV?=
 =?gb2312?B?cElxTUp2ZVpsUzRpcFVBcVE1ZVF3aERWdEJpVlB0RnNZRlZUT0M1Z1RWcXNv?=
 =?gb2312?B?SldVNk1jWU96bFhCMElCK2VNSzZkc3F1RVUwcU9BNHRSK2VKNWF5Wk9CRko2?=
 =?gb2312?B?ZERBWFZYUkFnL2tMc3ExK21JTEF0dkc0REdzTEtsMC9HVUVnUDNPRnU1cVB1?=
 =?gb2312?B?cmJqZlQ1K2did01ZK0gxSXlKNjd3ZldOekdMYzREaCtuOGJSUUNTeTQ2ZkJM?=
 =?gb2312?B?aE1lZ1lHWHpwZFBPRWlxSnFWZ2x5aXphZkVTRTdFV2diYVNudDZQTzY2NlNx?=
 =?gb2312?B?MEV0N3JvN2xPSm1YR1pNVE8zRFlQNlgrWUdBK29QNGc0K1lTbUlZRkp5MGVi?=
 =?gb2312?B?dVVmeGJQUkRxMTBSTEV4R1RJWGNVeTljYVhHd3pvN3duS3NJYzFWUnQ3Rk44?=
 =?gb2312?Q?ApqfG+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?L0R4TitDVWttL0RXUjFicFNVd3ZnY1ZVMmNrRFc2MHlIampGTUplSlJkcHU0?=
 =?gb2312?B?bVY5dnZHTWtWVmx0bVRURjUyb3NmZzljMW42QzB2ZlBBYmR1cmh1ZVRoZnNw?=
 =?gb2312?B?cVM2bCtBMUhjYzNadHl1NmE4Y0N2b1JIUHErZjBVOXRiVW8zRWpwWlRUY2Qx?=
 =?gb2312?B?U0Z3elhwMmZrbm5tZGlVMFQvck5ld2xMV0wrd01id2d5cUFUQVhJQzRYeHRk?=
 =?gb2312?B?UXVpL1I1b2U1RmRSbFNSczFPTEZvUmZKRGgzUzlEN3JFK2N1SUdDZ1hwWmpa?=
 =?gb2312?B?aEZ5QXZnMTZrc2pTT2dDQjVtOGxuWFRjbG9tWnNZTFlnVktwd2x4L1F0REg4?=
 =?gb2312?B?NUpxYm1pNGRjZk4rZDhreDNnR3Bzd2xoVzVOYUQ3T3ExZDBCWmtQR3dhclph?=
 =?gb2312?B?WlBhWlNoR0RIS25DcGkrWS9ERy9aSXRmd0c1bjZLZTQwcHRubk5vNWN6NFkr?=
 =?gb2312?B?WG9BWjhqNzZrdUQyUDRNNHBnME1BUHZSTHlzcHJFMnlUUHpEMjZ6QWxtSlNl?=
 =?gb2312?B?U2J6d2ZMblNGWkc5TW1yeDQxK0VpL1phaDV4MVdaVllFY2c2WVlpbmdjY3k4?=
 =?gb2312?B?R2NwcUE1bDNOMmdxYlJYbThqWlN0cGdXRU9NR0NqK0srNzh6WnloMW9uSmMy?=
 =?gb2312?B?SS9IQmVkRC9kYXkrUi9EdEZTRUx2SldVSXRvMjR1VTg5dE9sdjhSYm1UQWVJ?=
 =?gb2312?B?WTQ0a091TVNBR1dJT0VKWlBjN2psaDRrNnJVV3IwSGtQMGJvaWc3Nms3ZWhE?=
 =?gb2312?B?VlppNldVWWRpNFp1bTl4VkVpT2hYS3BuWTZRdFpMUGE4ckpoOUNlUkpBbklx?=
 =?gb2312?B?RzUyUmdhQXg4NGpoL0ZZTkR6bnVybEJrczRXRmxYRDRxeE9CM2ZYZFIrYVFO?=
 =?gb2312?B?MFlyU1NjZEZsOTdkaTBWTDN0UjZjb1BOR0xqem4yRVBqRXdocDhoTW1XOUQ2?=
 =?gb2312?B?OHRaVEo5K2dEclViUkh1VnJaZExJWEV1QUdsSGZETkpyTFlQV2ZJV0wwVkZM?=
 =?gb2312?B?bllBZHBlZEN2SlorTWJhSGVadmk4QnZHMmlrSVpLVFR2N1hJOStzYUtGemFS?=
 =?gb2312?B?Z1hMZTdJeFFHenE4RU1Vby8yNHFYRTBwVlJRMHVDWWVjMXpwK0FObjZZSE9q?=
 =?gb2312?B?WUNwOGdaMGhQQjN5QjE1L1pvaStBaFZySU9xOWJWZVNMRzRuak9ENktOTW1F?=
 =?gb2312?B?LzZMaHNoT29DZ3JoNjgrRmV4blcyYVJ6VitiNnJFQVhsU3c2SmZtLzltYUpw?=
 =?gb2312?B?NCtoZUtLaEhjS3Eyb3kra0ZRVXZPSTI1dDMrVDcvVHRqUXpGT2RheVNOemM1?=
 =?gb2312?B?Yzl2YmkvTHNhSVB4dVcyY2lLUk5yR2Y0Z2ErV0NiSElEUXdKMXRSTmJZOGsr?=
 =?gb2312?B?R3Y4U1hIb0lZOHVqNU8vWnRqeDdza0NCNEw2YmtEeExPUC9tQ2NkUkhsTi9V?=
 =?gb2312?B?VDF1L1dVVHN6VnpaaEdoSGh1QUJCWXdvZTNOTlVaK2hhZXVjUW80d1lMNmtI?=
 =?gb2312?B?b2h2WnJIc1h3bjVqRUZQUTJXNlhvOHRwQzRRY29uU1FKMjdEM29xM2tBbGZF?=
 =?gb2312?B?b1lsUFE3MWUrZnFvL2Zjd3cybUwrNmh2dlNjUlo5bGsxbmZQL0F2Qmc5YU92?=
 =?gb2312?B?ZklMS28vM2ZiS3BWT09jMmxDTGNtUERoK01HaUZDNjJETUVQR0NBNnludmJL?=
 =?gb2312?B?R1NNR24zZnZacGkzQmNSZ0N2dzRRZUZTdEpZd21BQ2EwMm5zWWFad2RYSUJh?=
 =?gb2312?B?WmVHZzlFdHFnZ1p4RWNKL1lmS2xFcnhvNmUwb09JUURVemZucHVaUVdPSUFz?=
 =?gb2312?B?L0lua0ZDUWJ1Nnc3YTdrbkN3R01jZE0vaHFTU0ZoUTVjUlpySFc0Q0dDTk9w?=
 =?gb2312?B?TGxiMjJ2ZDBSb0tjWE1pTXpiK1o1RzA1VFJ3dmVieElmVHdkcUNEMlc1TThB?=
 =?gb2312?B?WWdjNjlYRDFOdzhpbWtGMTRKVkF0NTMwd2JQYUJBRHloZ0ZMRnQ0ditsbUJG?=
 =?gb2312?B?SERlTWxEKy9NN1V6aG5rNjV0QnlTTDVDU3gwcUV1a2pYb3A5YUNqTG9DRXE4?=
 =?gb2312?B?NmJJT2ZoZEVEZE9Vd0IwMlR0V2cvZDVVUWRaUzA3K1RXVzBrbkdDdHdyeG1S?=
 =?gb2312?Q?Kc0LohUMDWhqlaA/AdJzu++Sg?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mhdgq+TjUY6fffYCKc0FWKrHPBToZA2MvSliu511rTDX9IZ/rgQavuNN5N5smPW7wQwbddW/oxbKJFnBoAI7esyl5LFW8l3fB84mvq9VG6WPiJLcapjmZm/73V+02f62jVwCo6swdP72bCE7rJo/J4lTWteNkimMP+GTg7PkOpQphO47wvnul+aFypmosGaY7AQz8rw3hTlZhp0fAW8DRQybC3kahUMCH1oTT5pZ+doz9qbzwEeaSrjFmhsoS1wUCPJ14mPdN5XnQSpE5Gq5ArQQy/5ArhHA38j5l0ZqslsO0Mx3Cq1y/JRIxrXdEV03K+cB9jrxof30Hm/9d4zklMIMHUR+p37XGb+wK0CF/9P9m7DabS3SG3wasRi/ddA1WY5OeLNG55s5L5QgYnDojxrMNhUJrBsPWOEJNg0bC4/bZWiIdeGyg25kRQcCQR6ywfgemDYdln/MjxeuoMTJeK6jbL6+XVO4dkTQEIYeuofV5Uz3zkh9t+BMG1sW4G3ccWdzF7r8TchniJvIiW21IcSTotUrOzUn/Jnh+tekbzpNNp+7rEabv73Wds8YSbJs+jjWsLXgfbu+pk32ZXFOr6RjnmbT4rU1+AiXWdqCmm5PH6ipM8a/7MFm1KMt/yH/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c8874b-7c29-45f7-a4ef-08dd79a3c29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2025 09:24:00.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5DtAxmgpbmksSKNUNxFq52+giJH88R1cky/WY1nCcx8EIB5Rrv9rQUcHtSvF32VQ7rHvGCEoqNwCdiaMZBAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12029

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCAxMiwgMjAy
NSAxOjU3IEFNDQo+ID4NCj4gPiBub3Qgc28gc3VyZSB3ZSB3YW50IHRvIG1ha2UgdGhhdCBzdWdn
ZXN0aW9uIGFuZCBhZ2Fpbiwgbm90IHN1cmUgdXNlcg0KPiA+IHdpbGwgdW5kZXJzdGFuZCB0aGF0
ICdvdXQgb2Ygb3JkZXInIG1lYW5zIGluIHRoaXMgbWVzc2FnZS4NCj4gPiBJcyB0aGF0IGV4cGxh
aW5lZCBpbiBjeGwgZGVzdHJveS1yZWdpb24gbWFuIHBhZ2U/DQo+IA0KPiBBZ3JlZSwgdGhpcyBj
YXNlIG5lZWRzIHNvbWUgbW9yZSBkb2N1bWVudGF0aW9uIGFuZCB0aGUgZXJyb3IgbWVzc2FnZSBj
YW4gYmUNCj4gbW9yZSBwcmVjaXNlLCBzb21ldGhpbmcgbGlrZTogInJlZ2lvbnMgbXVzdCBiZSBk
ZXN0cm95ZWQgaW4gcmV2ZXJzZSBwaHlzaWNhbA0KPiBhZGRyZXNzIG9yZGVyLCBvdGhlcndpc2Ug
dGhlIGtlcm5lbCBwaW5zIHBvcnQgZGVjb2RlcnMgYWN0aXZlIg0KDQpNYWtlIHNlbnNlLg0KSXQg
c2hvdWxkIGFsc28gaW5jbHVkZSB0aGUgc3VnZ2VzdGVkIHJlZ2lvbiBudW1iZXIgdG8gbWFrZSBp
dCBlYXNpZXIgdG8gdXNlLg0KDQpIb3cgYWJvdXQgdGhpczoNClVuYWJsZSB0byBkZXN0cm95IHJl
Z2lvbiBvdXQgb2Ygb3JkZXIsICBwbGVhc2UgZGVzdHJveSByZWdpb24lZCBmaXJzdC4NClJlZ2lv
bnMgbXVzdCBiZSBkZXN0cm95ZWQgaW4gcmV2ZXJzZSBwaHlzaWNhbCBhZGRyZXNzIG9yZGVyLCBv
dGhlcndpc2UgdGhlIGtlcm5lbCBwaW5zIHBvcnQgZGVjb2RlcnMgYWN0aXZlDQoNCg0KPiANCj4g
PiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gTXkgcHJvYmxlbSB3aXRoIHRoaXMgaXMgdGhh
dCBpdCBjYXVzZXMgLS1mb3JjZSB0byBmYWlsLCB3aGljaCBpcyBzdXBwb3NlZCB0byBiZSB0aGUg
IkkNCj4ga25vdyB3aGF0IEkgYW0gZG9pbmcgYW0gcHJlcGFyZWQgZm9yIHRoZSBjb25zZXF1ZW5j
ZXMiIG9wdGlvbi4gU28gYXQgYQ0KPiBtaW5pbXVtIHRoZSBvbGQgYmVoYXZpb3IgbmVlZHMgdG8g
YmUgbWFpbnRhaW5lZCB3aXRoIC0tZm9yY2UsIGJ1dCB5b3UgY2FuIGFkZCBhDQo+IG5ldyBjaGVj
ayBmb3IgImRlc3Ryb3ktcmVnaW9uIiB3aXRob3V0IC0tZm9yY2UgdG8gZmFpbCB3aXRoIGEgbmV3
IG1lc3NhZ2UuDQo+IA0KPiBUaGUga2VybmVsICppcyogdG9sZXJhbnQgb2Ygb3V0LW9mLW9yZGVy
IHJlZ2lvbiBkZXN0cnVjdGlvbiwgaXQgd2FpdHMgZm9yIGFsbCByZWdpb25zDQo+IHRvIGJlIGRl
c3Ryb3llZCBiZWZvcmUgcmVzZXR0aW5nIG1pZC1sZXZlbCBwb3J0IGRlY29kZXJzLg0KDQpJIG92
ZXJsb29rZWQgdGhpcyBiZWZvcmUsIGl0IGluZGVlZCBiZWhhdmlvcnMgbGlrZSB0aGlzLg0KQmVm
b3JlIHRoaXMgcGF0Y2gsIGl0IHJlcXVpcmVzIHRoZSB1c2VyIGhhdmUgZW5vdWdoIGtub3dsZWRn
ZSBpbiBob3cgZGVzdHJveS1yZWdpb24gd29ya3MNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg==
