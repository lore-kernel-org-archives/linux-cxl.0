Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06466FC3
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335491; cv=fail; b=TzlQTKZSMveV6Jq1bASWcHytzxHOfwUix7gvxHJ8OQRkXHBuPhAwALXR097080GJFqB9b2vWOZEPk84Abafkt+ouSYadNY2hiYN3oj2u7SvNGHQtIg9Wh8PL1BzvXGAyIolZyD97TrnXvGCw+IJPUJZuLTVSIk9KJMDQQ2WYgD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335491; c=relaxed/simple;
	bh=2Q0RkdIxYwYpOKtWvTS4woL6YIY50CqHu7S/U8ZSmxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odRYTQ/xKJqA1imPaBD/1JfGfJ7Me3WSUdIGCZtzUXxSmMDBR04U9f464TzmBSJW1EDtOHtpHFIbb46tqgi9D0ktTtgAHS8OwrshPqGmUK1QgdAd/A6HO+jOI5b/OJGdQpCkNAP42DJMcQMb4wm1DQ2ntg5p5zRvSbGXQ+tfNrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ONNmXBET; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ONNmXBET"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1713335488; x=1744871488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Q0RkdIxYwYpOKtWvTS4woL6YIY50CqHu7S/U8ZSmxI=;
  b=ONNmXBETtdWmBsaKtB6zJcMA5CJHXy/5GYIXM/v0llIcmfUZvXT06l/E
   WerBMvZ1/ikIEp9Jcu4tJ1HfRvqO9h73bm54nA8Bc/pjHrMhtcTtHTafK
   zYrDtcgSFDCCmgj9ppKcxTDSiV7JbShLVc+H+QRQqm+kokKrVy09Iqm52
   Y58+9n4CxRz0H3VtCK69QiFOKdWfapXUcLWXqkP5pWn8HpmU7PYYtRzKb
   XsXilIkZSY3zsdfntfxWD+UV1gX4/anJaFZrzJ5s922zpW7rHWrtNLTjY
   zUIKOWHvBh6eHhFpA8KTqfrapY+eXgYAm8R0ZMAVdLI/LNiJ/qj7RoRU3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="116642950"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; 
   d="scan'208";a="116642950"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 15:30:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ9wKS5zY5gj+uzoBRYPrusFHGJLYg20XlyKH4KkTdJUbpgN/zdKCr2ugHDq5kj65Q9Ssv2a4kEdxxUBavuTdHIwZ+352A0D7PG5XFib5txh4qwYAU8TYVFtuok3Vg2+ySIJmSXQMOKS4MtFeIJlQSWndmujcY3g2p8em2GBfSs3DMwscV+w20vm1vMd7cmIAlW898O4vSzhqph1WKsa5LFqjx8w3SA7vIUxwgzZFwC2xJerZGAKuesw0jY/L2IXnTsdHO9wB4kjX12XWdfEPxke2ajcGUh7FYVgfmc7k4ZRyHM8Pj5shNG/UOfDywfiozwViWf19/nUOoZUMAWsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8DSfkimDLk2EgGrQZr/9gNnOD9vNlH2X0JsMEmZ06M=;
 b=jJW57fMML0Ql7wiSqPKQ7veu8dmdQhneiIk4GSrEMZPXpbhiP4c8jMXE7UX92PEcciTOtFs06zx+caW3qylX6m3TNFs0BIBlBXihjhLBIWjsb39DY735gHbUGoAksNVC3FnuQmKCwtxnsy+DvE7R6ImH5eJ0gG+MCsYq78vPx7+dCNDMWyxzI4vh+KxRqc8h9xyLmZmYe0BWa6ypwODS5DF3VQJq/wUFL+HmGTlnu0kvSsZ5cVxQ4UrLuI8IOzw0/oRreWyJ8KV5E8w5O11A4WduhYxjalSwK+bVpc4kb1ruBJ8rng0d4sE/UA5LMP6QBcTj7sZcaoXvEgXYW0AXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 06:30:11 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 06:30:11 +0000
From: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3] cxl/core/region: check interleave capability
Thread-Topic: [PATCH v3] cxl/core/region: check interleave capability
Thread-Index: AQHaiiWGE6A43v5FREeOUdrb2ctNL7FsCH8A
Date: Wed, 17 Apr 2024 06:30:10 +0000
Message-ID:
 <OSZPR01MB64532BD39DDB3087ECE359798D0F2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=eae353e0-68c4-473b-9d16-69a0a5fde3d2;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-17T06:15:14Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB7996:EE_
x-ms-office365-filtering-correlation-id: c2ddcfc8-573c-47a6-1057-08dc5ea7d53b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IhAGQJAoxz2CEuKs8Su85FeiOen5ZUt6qf2d+BvM5QNNPAjwt6UwcQwV1/uVZLGq0rBGexkhuEkJwF/xBdy6pPgWTdxOSHTSFFvHpQRi4Th20Gy8TiKwFZIS3BoKs4c6+1Ti1D9LBtLv+MMQ4K3Ti7ZSpclT0lp90xK8KKRTD9LTVd1A5bak2MDNuqtNobVCx+QpwHTwu1LsgX0iOA5ZBXyQvalodsTJvbicn2ey6Z3eTf2QQX+tuUi+i++QSdbAUSaz59Luq6mn+0Kix4+aD3YdKsBqlqk9C5awos82jOHkJGQ/5CJcF6ti7PsJj66+HqfBtCWZkrsgbxyn9I6+8vv9lpW74Dfi7kcO/h45z80+eNiiaqxqqRK/Zpmn4oCnC/Bvnda2c3qEV4YHtULYC6GI/rI+dm8OZ3jSy4AkViywVyV/LudtVKk94Yn/F9Fpyf7dlmcI0nU+ZclFh6BeSoYMwWqLlrIsR7TIC5UJ6poZ+pTYiTSIoNEUgAea2FhvxMT51jmWlMqZn3RYpf1X2wqpXw2j7kE9urEm0hqGIjgAe4NmpvezAUAfHU2VtGAqdtkS/YfJvlsAgjry30OdNcIQttlzc3kI0BiW93RNSDwwo/WQe/ahTuuqGss3aH7bmvgk8hKBe8qRbJoNOHGRjCZMbsSmJkFRgzlETWm8uZPwS8s+sMH4DV3QEtxUxDo15rThOADanTN2NjTozqof2ChZpkqwQXFx/KhJoJsm4CkzZuYft8hpBPJAQWUVPspY5Rz7bTzgS/eE9vhwg/cUtg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6453.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZWFKUVVjdzdEbGVPSDFXMURKejFabUdmWmR4THhvS2dITFR0VUczOElY?=
 =?iso-2022-jp?B?ZWZZa2hOZFdFNURLZUF0dStVaGNTQWJHb1JraUJXRmU0OERCcWplejJu?=
 =?iso-2022-jp?B?NlpoWG9ndTZkNUIyNGxJZXV2OCt5S3h5cEtVckk5RzFMVnlFZGZGT1Ir?=
 =?iso-2022-jp?B?a0FwNTdQa3hmdThTVlFOMVVLWnErNUVEKytWZFIyaytuVDhGdzRXdVV2?=
 =?iso-2022-jp?B?NWdKSnEwU0JzZ0NlYSszRHhxbDFpWldNZmV4bURvMWhsalZheDNIMFhV?=
 =?iso-2022-jp?B?OG9xOVU3NzhkeEVqd1FqOTYvS1QwZXg1RkNZY0hpRFZMVzZuYTJNZFho?=
 =?iso-2022-jp?B?ejdkZFlhUjMyd0d1QlpuQm5FbFJqTi9BdTU3YXN6eTF0ZEN4Y0VZWS9x?=
 =?iso-2022-jp?B?a2RxcGVwTTBWSEZNTG13RGVkWCswVmVIcHlqcHd1N0V5RmE4WWoxbGMx?=
 =?iso-2022-jp?B?enVPNkVyZHIrR1pNUlZoUFlxdjFXRzNKbUl0TmRFN1d2RHo1THN5MElI?=
 =?iso-2022-jp?B?MW1uYU4vOEhLRktpODFPcCt1K2JQbTBBTEt0dUZmbi80NXNyZklscTI4?=
 =?iso-2022-jp?B?Vm5lY0dvTzVjQWQ5bDYvSW9mYjdySlVGZG1BbFpCMWlSMjVGRVRsWi90?=
 =?iso-2022-jp?B?VEhxTDV3TTYxaHkxUTloQTM1U2JSYjBCVTBZZ2FkYVBLbUo1ckhKZVBr?=
 =?iso-2022-jp?B?ejlDZHlKazBVR3FRdDQ3emY3YnBDeC85cUNhR3BCVFhqMnVIcnRqdFZz?=
 =?iso-2022-jp?B?ODMzYzV1dFFDcG9XMHVuQys4MmRPUFh2LzNTMFZDb2xUUU1DSmhrM013?=
 =?iso-2022-jp?B?UG9JSHBycUJqV2d6dGxzMkdBdG9vVEsvbk9ucDFxSXAwMDl5cDFLYmcx?=
 =?iso-2022-jp?B?RmlUWVRTVHVOR0NpcXNkSnN5by9lV2VINHEvNHgwRC94MHIwMmg2Znhu?=
 =?iso-2022-jp?B?ZjZGTTIvMHpkU003NFJpaU5vNFVhSXRQL3hWaWJUMm9lVnlBdmpxOFJm?=
 =?iso-2022-jp?B?QUY3d1U2eld0K2VWYXozRFY3dEYrNDNyNDcyVkVTdS9GSElpbkVIVllq?=
 =?iso-2022-jp?B?SUFIRTdvS25Hd3VQTmdacnZTazBibHFsTXFvK2x5ZGlIbVZISWsvVVZ6?=
 =?iso-2022-jp?B?RFZ2K29QWWR5Qkw1ODZBOUx5eEt4aGFUYUpzS21aWGdTUzRrbG9rN0JL?=
 =?iso-2022-jp?B?WC8xSkJFQjA4MCs2bzVSZjlGaW0zQkFwYjdQMFh1ZEJiS095RFEvNGZH?=
 =?iso-2022-jp?B?TDVRWjdMOVhlTjZzVjNwZTlLcC9yRk84bWVHRHVkMExLK09Ra1llQ3F4?=
 =?iso-2022-jp?B?TWpOS3lQbkczeUVSQXdsaDU1cW9qMlB6aHh5Rk5XWDZXL3NEL3dGZ2tD?=
 =?iso-2022-jp?B?OW03YUdMWHJqVEpWYmtYYkg2OHJHMFdJTHY2MFpqOFRxUVlPditma3M2?=
 =?iso-2022-jp?B?ZXQxRU9tRWVQWlBFTjRheXRMam9EbXVLTTRXc3M5dElMU1Fnd1VXRThF?=
 =?iso-2022-jp?B?cmt4ZkZzYzFPQ2dpVDE3MWVydXhsVHNxODh3Wm8xWUtwNGFuK3hOUTgr?=
 =?iso-2022-jp?B?cmVlN2FkOVhKOEpBZ2dEdHhCNFJFZ0VwQVRoMXBsL3N1YndaMktDa1ZG?=
 =?iso-2022-jp?B?YW1SY2dWeXBKeG9mMk83YnppMWg1MmZrTlRhK1JUL2JhVGwyZTB6NmEw?=
 =?iso-2022-jp?B?aHJLVlVmeVU5M0ZqZGlReWRGU3BGUFlhQkxNQ3hQM2hpM3ozc3I2MHY1?=
 =?iso-2022-jp?B?WGpSZDFJRzFDVk1KcWZENzVneUJkM0R6L3JkSWJvUmpobzNkMnlsTmNT?=
 =?iso-2022-jp?B?M0JtM0tVcHJJU3ZNMmlzb1FrVjh1L3lwV3kxODZSRTNjVWppeVB0YXlD?=
 =?iso-2022-jp?B?T3VSYjhkSlFtWjd4Wm43TGZEakNYUzZTMFA0b2RraGZmc3puSVdra1NQ?=
 =?iso-2022-jp?B?aHBkTWNYdnFaQUdFSUVDOWtRaTNsVFJFRGJKMlBObkNDWnRwdTVvc0VF?=
 =?iso-2022-jp?B?a2ZYYm96c3E2cWZPby9ibnh1Y3M1dDlaTi9SRElmb05NKzhlZC9qZzJO?=
 =?iso-2022-jp?B?MU9tZnFQTVpTYWFpSDZTbDVKdnJLRHVwalhtbUlpTXc5MlE5Z2RBQldI?=
 =?iso-2022-jp?B?Zk51ZExiV25DTjg3Qms1Ky9yZjNqSGlTay8rcTFZNDdPMFdTOG13ZUVU?=
 =?iso-2022-jp?B?ZHhQSXZRSGdWbXBDY1NjaVFKVDA2Z2g5eSsrRnY1TTRrMDJCZEZyUDh6?=
 =?iso-2022-jp?B?QUpZNXkwM0JwR1FHRnd3NDBBSERLMXV6OHpmQUNiT291RHowRzl5UitO?=
 =?iso-2022-jp?B?NG0wOA==?=
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
	Z08D5pdXpjmr0XYELbssnc+SdSQTsJKayAzpu6BFVmpkpVzOsK4169RMDOv8w0G3fpVRNiV8o7JDV+maDZl3JjOGuZ+9Efq0SeHgNcaOKigEJEacpHF7U+Fr6SWk6m87nYOCXUA2qA8HEzLqpPJu8qblI0MCl7Iety1G69emfhDycuvWZVed21tlY3zP+xPg4nAqlsopK43++bk5ZlAYjfK18RUNtgJvIurF0dA67Ofbi614QbMgfQs5y6fGWgd9TVB5tnMoeiNLm84TrFEXfxEBIuscY/WrmG0iR3AIlIuZ0WiJrOlPZXvgeAimi8nTaucxOcXzhWjteVxmHdT8dlaCzgpOhm0gWfdHvqsVvNHrr/SO5Vd52zEH3wBGR6THOWlUBs4GarIzYdZKDmayqhoecIvf+Yr3YLJSy05+deCVsrIIVf1riXyBPedzzp/SnIYBc+jI2ET40b1QiB2knR7G8/nkphVg+RSefP384zKoMwVb46O1vIPUWAmtTfwU73q2BwDjfFGkHUzJWp3U6q33aKe18MggG2b/yWibbq2pqIxf6y3II6G+LKnU7FNtwSOtSQMJlfLNOVVQ0Ym4WyiPLo+NPh7+M/mvYG/JNgsJ5Qm/nzzFyynRqbqOaG9S
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ddcfc8-573c-47a6-1057-08dc5ea7d53b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:30:10.9513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfzVmyaJTJGBeeC4d/UcYCTbJuUYnF+SQbnsksfTHZ8EYG3Vzv7s5EEFjOW5grJ0NRgD4xOQfThtwkN6Cvb4pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7996

ping

> -----Original Message-----
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Sent: Tuesday, April 9, 2024 10:26 AM
> To: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com=
;
> dan.j.williams@intel.com; jim.harris@samsung.com
> Cc: linux-cxl@vger.kernel.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <=
yaoxt.fnst@fujitsu.com>
> Subject: [PATCH v3] cxl/core/region: check interleave capability
>=20
> Since interleave capability is not checked, a target can be attached to
> region successfully even it does not support the interleave way or
> interleave granularity.
>=20
> When accessing the memory, unexpected behavior occurs due to converting
> HPA to an error DPA:
> $ numactl -m 2 ls
> Segmentation fault (core dumped)
>=20
> Link:
> https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fuji=
tsu.c
> om
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c    |  5 ++++
>  drivers/cxl/core/region.c | 51
> +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 59 insertions(+)
>=20
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..5ac79d843a16 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -79,6 +79,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm
> *cxlhdm)
>  		cxlhdm->interleave_mask |=3D GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |=3D GENMASK(14, 12);
> +	cxlhdm->iw_cap_mask =3D BIT(1) | BIT(2) | BIT(4) | BIT(8);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY,
> hdm_cap))
> +		cxlhdm->iw_cap_mask |=3D BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |=3D BIT(16);
>  }
>=20
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info=
)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..abc14fe1717e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1210,6 +1210,41 @@ static int check_last_peer(struct cxl_endpoint_dec=
oder
> *cxled,
>  	return 0;
>  }
>=20
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig=
)
> +{
> +	struct cxl_port *port =3D to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int rc, start_pos, stop_pos;
> +
> +	rc =3D ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
> +		return -EOPNOTSUPP;
> +
> +	rc =3D granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	if (eiw >=3D 8)
> +		start_pos =3D eiw + eig - 1;
> +	else
> +		start_pos =3D eiw + eig + 7;
> +	stop_pos =3D eig + 8;
> +	if (stop_pos > start_pos)
> +		return 0;
> +
> +	interleave_mask =3D GENMASK(start_pos, stop_pos);
> +	if ((interleave_mask & cxlhdm->interleave_mask) !=3D interleave_mask)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1360,6 +1395,14 @@ static int cxl_port_setup_targets(struct cxl_port =
*port,
>  			return -ENXIO;
>  		}
>  	} else {
> +		rc =3D check_interleave_cap(cxld, iw, ig);
I found that when the switch decoder is passthrough, this check will fail b=
ecause single ported
host-bridges need not publish a decoder capability.

But I can not find a way to check the decoder is passthrough, so I decide t=
o append
a flag called 'passthrough' to struct cxl_switch_decoder, and when a passth=
rough decoder is added,=20
set passthrough of cxl_switch_decoder as true.

In check_interleave_cap(),  when the decoder is switch decoder and the pass=
through flag is true, skip the following check.

Any ideas?

> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s iw: %d ig: %d is not supported\n",
> +				dev_name(port->uport_dev),
> +				dev_name(&port->dev), iw, ig);
> +			return rc;
> +		}
>  		cxld->interleave_ways =3D iw;
>  		cxld->interleave_granularity =3D ig;
>  		cxld->hpa_range =3D (struct range) {
> @@ -1796,6 +1839,14 @@ static int cxl_region_attach(struct cxl_region *cx=
lr,
>  	struct cxl_dport *dport;
>  	int rc =3D -ENXIO;
>=20
> +	rc =3D check_interleave_cap(&cxled->cxld, p->interleave_ways,
> +				  p->interleave_granularity);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> +			p->interleave_granularity);
> +		return rc;
> +	}
>  	if (cxled->mode !=3D cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode,
> cxled->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..da8a487ededa 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 20fb3b35e89e..1ec3e6285d41 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,6 +853,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned int iw_cap_mask;
>  	struct cxl_port *port;
>  };
>=20
> --
> 2.37.3

