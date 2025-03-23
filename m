Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80044C7C
	for <linux-cxl@vger.kernel.org>; Sun, 23 Mar 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742718895; cv=fail; b=Rv90IIAUzgtQSDWolihzFBcCaoLidM4ptt16X8+GS7/KcKBAizWvuuJn4hSzaF2xvvmJCqDiroz+DUNuRHreJUEXY4UhuaYrofgXX+7F+D5e3YRnVguPeNSXJWxnkjHCNd26LwQHGf+ah64afaGz0xUGL+tb8K3ilBqQLb2R7KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742718895; c=relaxed/simple;
	bh=iXnsDpkvQOsMIxSIHvhw6XTDRS1DTM+1blHozhtVg6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUQp/kOQK7l+Us4IfLWbIhX79TZNjDXyo8pU0Jmlv8+bHMocz6IaQ7M64AAYFWttn9xTajWwtLnNxSztKwJB3w5bYXmUhgP5MYir2PqEIfab4qSl5AGIBEPBXmUFzH5PiuZS7FnlaZMH2cmtMSYqBd7YLnmwGLhTkYISZI/vZo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VqMdAGtV; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VqMdAGtV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742718893; x=1774254893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iXnsDpkvQOsMIxSIHvhw6XTDRS1DTM+1blHozhtVg6k=;
  b=VqMdAGtVDW3135cLepChIviBxzRjgNPsXjZZjonw3Uezm7UDaRjdzIb1
   uH5YD0qC4mbSzpLI6a+Oj519Rfh4ZKwWHaZWGujQvJs4Ullb5GgPk4vLw
   /9id3cTfpF6bVwSAiWTl/MamxQMMosLPSLLjVS3iXAfDfB/E+wEIcYRYq
   Br/UuH0eremiPU+4BAbfaIa18RpJeAXKdaLnfr7nMkqxI3jUcU8ehvlRQ
   ABi4DobLMmXPCtARrEVpR4EtFDBGs1PTk7uKp6M8cVD02hcghoQfVP9XS
   badU3ctR43Kp1Cb8Is2lywzIMbOk3cZEpZ7V2J+hnbzgZ/otiaWx1jfhj
   A==;
X-CSE-ConnectionGUID: 633+8NHwSsSQtNXdddq2aA==
X-CSE-MsgGUID: qo54Y2LiQb+r0gAqNoezjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="150500254"
X-IronPort-AV: E=Sophos;i="6.14,269,1736780400"; 
   d="scan'208";a="150500254"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 17:33:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlm5rwZ2aqWLAAdO7FvHkd7w2AaHqkWsI1aha3sv+BAwmbkBBzp15ZeYHSlJN2RZ/HqpfCsIULqJ8Bbk+Vat5ORphGItNGXMyARAlxHo3MFnhxQMT7elaGfs6ao7l3gBksg91V33Ek1IaTO0M531xaKwpeGo1XUNw9GKVksx0vUdHo/Wma4aaJNikop0/zfAGSP7qmZlwZAYGalVxkA7DpYLSX4IZY6BQNNhUTvTZSFisGnom2jCQuUCr3rmsuLkIBT7BIVI+fzZfYUYD5if8+lSUuPf13EYus9qGhlpoC6af2Q8QLoc8QbFfuomQpZH0sNsthpCBZ2ueX/bSqxc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXnsDpkvQOsMIxSIHvhw6XTDRS1DTM+1blHozhtVg6k=;
 b=t3PifSsAknyQl1GBgeSID0LjJmt7uOaJMnbt2mlRctoajXu1WvXVqrg4Qr0IPvf519MYXaIriBez5orhJoSyOFP3IJsO66zZA0NvSKxWUuxVIuBy+HxrenGyrSJveJdhTvn26hZAhPXc19L02C7AxyLp8X/0SX2HICzYF3lvWJ+fStsVm22TANck7z1LHsPm8uHt8vU0GuuDJxoizt36R3QU6IXcAVIUKtjty6VoFcHMO+bDJ/gxZ9ZGtl4cS1S3XIEzuqDj2simChpCy+OFK4Wy8R8q9Lo872lUpQ/OsvOo4ljjhmaNCKoyvld07gOj6EQaqXMcBByFWNyzeE4P8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB14258.jpnprd01.prod.outlook.com (2603:1096:604:361::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 08:33:33 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.036; Sun, 23 Mar 2025
 08:33:33 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "Bowman, Terry"
	<terry.bowman@amd.com>, "Fontenot, Nathan" <nafonten@amd.com>, David
 Hildenbrand <david@redhat.com>, Fan Ni <nifan.cxl@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "gourry@gourry.net"
	<gourry@gourry.net>, "PradeepVineshReddy.Kodamati@amd.com"
	<PradeepVineshReddy.Kodamati@amd.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, Alison Schofield <alison.schofield@intel.com>
Subject: RE: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Thread-Topic: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Thread-Index:
 AQHbaD4SNAeoR9FhZ0CNhDBQza/56LMg6dmAgACyQoCAALongIACNhcAgAY17oCAAETcAIA8c7EAgAEfbwCAGCuZEIAABYpw
Date: Sun, 23 Mar 2025 08:33:33 +0000
Message-ID:
 <TY1PR01MB1562BBB0BD9235811B3DEA66A5A52@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
 <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
 <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
 <3ed69bb2-3c93-42c6-9f02-9519482b112c@amd.com>
 <TY1PR01MB156225EF913E7568F3B12E05A5A52@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY1PR01MB156225EF913E7568F3B12E05A5A52@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NzEwYjNmMDYtYzU4Zi00Mzk1LWI4MWUtNDRhOTA1NGY1?=
 =?utf-8?B?NzQxO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDMtMjNUMDg6MTE6MjVaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB14258:EE_
x-ms-office365-filtering-correlation-id: c4dc1f37-1bdd-4e5d-6ba8-08dd69e56613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFBOTHJuZ3JZcWUwOFhLb3hVY3JpQ2ZzWU5IK24xazR3clg4WDNYcWVPcExC?=
 =?utf-8?B?eGRiK3gycU1IVmNtTG40a3pzOWtLVTBSOW14THMrdkw2ZFFDbWUrN3FsRTMr?=
 =?utf-8?B?MDlJSlBiUWhrcDhRMGp3U3RKbjBHdWxBb3pvYmt6T2VxanZWMjBWa0UvRkhQ?=
 =?utf-8?B?VFR0VUxPcm9sZkdvUUlRSStBWUFWdzdHZjFLaUdyeDJGVFNIY3pMZy9hcFZl?=
 =?utf-8?B?NEtzZThrcHpzbUczZkJkMFZjc2hMNG1Qa05FOEhrclVCU255WTA5RG1Sa1E4?=
 =?utf-8?B?My9jdFYzWGE2Rkc0dVVBZWJ5aXhrQktmVjhlQUdJUDNha1RLNStubUdVeWho?=
 =?utf-8?B?MnNSM1RmOHBYSG1JZkxvempxdnd0SGJYTWYyVmVaQjVTR3NoczFoZ0xBWWpk?=
 =?utf-8?B?TW85YXFDNTBqbWc1bG5uVW05MDNlY1g5OVN6RkF0ejRMdzBHWklXbnpWYXNl?=
 =?utf-8?B?MVIzMzh5SGFmTElVV2hXOTZHK0JVaVhoTDJReHdvdXdzMllHOFRiWDNLMFFR?=
 =?utf-8?B?R0xWQ0VFVTBMY3JUTkFFSkViM3Y4TnVNNzBHQ1RZRzZYa2JvN0o0Y1piaDVi?=
 =?utf-8?B?VnFtdUMzWEp1TkN2ODFqZjM2eE5aMUVnalFjQkJuZlJMV1ZNY09kQlEyQWll?=
 =?utf-8?B?S1NkUDVCOGRISXZqWkZRR1dsb0x4ODhQWjNxWU9kMFo2bk5nQjdQaHRiNC80?=
 =?utf-8?B?SnNhS0l0bmJCLzQ1UmdjQTdpbHg3WjJtMjJVRXowU0hhR1VoYmkrTTNKUHRj?=
 =?utf-8?B?OVUzejN2aTdxS09sUkYwMHU1QVBQRno5L2syUjFsSGt2Z3hJTkZUOFJVNk5E?=
 =?utf-8?B?WlRuSk1iOVA2by9xSm1jeDZFUnNXS3QxVU9yaTRaQ0Jvc25wOUlzM0dmVTlX?=
 =?utf-8?B?LzFvYUtZV0lXcWU5azBFM0x2VHhpYUtVc2JnaUlCVlA5ODRES05zclRJNzUv?=
 =?utf-8?B?cVdlSDFES0Q0d1FHYk5HWC9uVHczR0haaEZYcmIxank0QWw0NGU5UENweWZn?=
 =?utf-8?B?TEtnZGlvOEk0TGJsREpxM05lNlc0SGNadzNudnlWUFlUamZBS0NnSmZQaS9p?=
 =?utf-8?B?eXRFRGdjU0VkVzRJcGpjbU5JNTJKdlNlZ3NPYXRWL2h4RVQ2R2MvbWkzbHRy?=
 =?utf-8?B?T2lBakdDMC9La2hyREtNNldIdEFLWDQ0WVhLZjZkNTdTYStMTUNZTEEzOGtC?=
 =?utf-8?B?N2JFNHRISkpjL2kyalNDT3FXNzZ6Q3ZrZFVlTUxCSzhOV24wUEVVSkJBdnY5?=
 =?utf-8?B?NVJhc3Iyc3JqSnRzUFdzdWNpVzhBeHEzWS9HR2o2VHg3Y3JMaTcvT0QyNHdQ?=
 =?utf-8?B?OUhFZ0xDRVp1MU9xb09GWVRXZDY1QURxY1U3dWpWY3J6eWdZMmpKK2wwbVRa?=
 =?utf-8?B?UkZMT2h3UzkzTzgyWU5BOUNQdkJGWXFaOTEzTjMzc3JTTFR5ZFJFZjAvTWtB?=
 =?utf-8?B?SFkySnFsMzN1THgxTTNINGQzWXdRaG5uWTdQeStRRDdSaWdVNnBORkQvN3Y1?=
 =?utf-8?B?Qk9xMkNTN3puMFAxVTN0SElzNTlML3hHUWU2Zm1JWkwyR1FCb3FzZzZoTG9k?=
 =?utf-8?B?UmpoTmVNZ293ZkJaeXBqTE41M1hRWnNzY0VSdERJbTFZb0NIY2toWXRsdXNO?=
 =?utf-8?B?eEJyeVBPSU0xSmhGUWEzeVdoajFRaEpya2o0YUlJY0MxY2ZTT0FZdm5yakZp?=
 =?utf-8?B?aVZBdWI0VFcrOEsyZ25RYVdpZUhmdWZkcjg3aUpkdS9iWTg4RzIyYjdSMFRy?=
 =?utf-8?B?K1ZtYVFQR01pcFdoTmp6bUUweUpZQUxNSmpON3hVZWNITnZDUDFOQlBLZll2?=
 =?utf-8?B?aTI3SlJpcmxYWG5JajFzbkN2Q0ROb3ZSalBYbjEwcnZ0Q0gxeW9Ud1o3TzNu?=
 =?utf-8?B?cDl1RUl3ZWVMaVBlamNhMWtUakk2U1U0WHBJeDZvREhrdTFlMzF5dDJOUWlW?=
 =?utf-8?B?NlhYS3B6M2NUYlhHN0JtUWNDODhZdE9NU0Nnc3FmN2VCUnF0RzEzU3kzbXJh?=
 =?utf-8?B?SmJwbzd0WG9RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHlISzJuKy9SVGU5dyt1bFFUTjdwOGpoRjVrOUV3bWtFa08zem4zYVFhaWlW?=
 =?utf-8?B?dVg0aXlLN2pNaEtTRnA2TXJqVVlLdzFtcjUyT0gyQmZlRktMbXB4S2pNSCtq?=
 =?utf-8?B?eDQxS1A0dFZGVEE4OXNFOVUyVmhHSVlHaFVQMmlpcHB2UU5PdmdIZEhrZjl2?=
 =?utf-8?B?ZlZKTDhRTDFkSFRWb3ZPMWZXVTI3T0syRkhHdXVwTWVCNFEvYmpTS2V1WDZ6?=
 =?utf-8?B?eTZHVk8rRmg4SERxa2Z6Q1htb241VmdWZDhrWlIxMHRORTY1ZFYzL2tKMjVw?=
 =?utf-8?B?YzlXeG0vUVRaTEhKV2xBZk5NbGdBZ1JVSEM0Q05PdmcvV3JXMGxtV21ZTGVv?=
 =?utf-8?B?aUxHbFA5V0JQUjU4ZmhKS0tEd2x3bzBza1BsSVRyQmRYakt0TnhBTEcwT1Aw?=
 =?utf-8?B?Q3FPMkR2MkpENDhnbEM0ZWd3VnFwZlNJdHJsUWQ0cUxYYUhpRUdJbThBdTJi?=
 =?utf-8?B?TGlmblp3emF6ZkdLZWZVd2w3bWs3ZVNWVE1CcVFjWWUvMkwrc0VnWnBhNDVF?=
 =?utf-8?B?blQzajJyN0lrZklSRzYwbnpBRkVvY0dsd3hIaExidEp0bnd0dFpveXZSWkVa?=
 =?utf-8?B?cGlDcTB2WE02NytGN2JjV1FqbXVqT1g2STQ0QjhBMTJmNWkydmxRcnZRbFo5?=
 =?utf-8?B?WGdMb3IwTUcyVVJRVGc1dmNSU29lelZjV2tNUG1oalBySW1JMjZyWTNGMnNS?=
 =?utf-8?B?dTFBUFV6STFIYko1cDdQTTBESExYSHRabG1yKzVjT242c3FGYWFNbDhmMUov?=
 =?utf-8?B?VDJXaXpwaTNYTGtOLzkySGxuaVRiUXZXN3R6dHFZck1XSUR6L2dRbjcyU3VF?=
 =?utf-8?B?QnluVU5rTG1aQkZtc3V0UCtrektWZm42em12ZEtzdTkxRHo0Z3pqTlVhaWFU?=
 =?utf-8?B?MUdHVDJwWThpUDVCWlh4Wi9YVTRlMkxpOHJOR1MvVzV1T3ErLzFkR0Z2eFlU?=
 =?utf-8?B?OU9PWUNvWk1VWWZmZEo5bzJJQjhFaDgycno2UmhTR1YzTkN2ejV5d1VaQm85?=
 =?utf-8?B?R1lxaVVpQm1VWjk4VjhaTm03VzVaQ1B5WEhVUnRCNFdheWJPVVE3ME9SY2hV?=
 =?utf-8?B?V3FjcDRsekhBYS9VajBlazRTeWVVY2RHa0JISTFkR0E1N0k4QjBhelNQUHAv?=
 =?utf-8?B?UXV6WmlmdDlpekRtU3pEc0p6cjZEOWJjZXZPSWhvNHJNSkthb1dSajhRMUwx?=
 =?utf-8?B?OE4rNTB3cnVERjZxNGxyalppNTlXc28yY3J2dGJuVGV4RXQ1emxBVkdxdzY4?=
 =?utf-8?B?VUMyRDljMlVHdk5ienowWTV3Y0ozS0V5bW1xcGpna2JHVEp6a05sNUNwMmI0?=
 =?utf-8?B?MXBveFJGdE12S2o0NjFOS3hSY3ZDN2NQZDBGV2Izays1dDEyVXVVUDRGdmpN?=
 =?utf-8?B?QW9BSVRva3Bsb1B1TEd4K2dFbzUraXIzL0hua00wMFpBMGpYd1Y3TUR2dUtW?=
 =?utf-8?B?SVJ4SXhNb2lGYnUwR1ppd0lCRWFCMnBqb3djY0ZCYXZ2YnNrWDBwVkhhaTJk?=
 =?utf-8?B?SFp0dE5HRlY5TDV4b09yOUhBV2NvVmlmUGJvcXYxMExlQlVlNlB1WDJiaDJV?=
 =?utf-8?B?c3pwOU5DY3BGN3FVWEhBQktUQzFoaExtRTJtaENqMDZqVXAyb0N1WS85QjJI?=
 =?utf-8?B?OFpvWXBFSThnSGRLakh6YncyVENwVjN6Uzhlc0FRQjMvdnJ2eTcxbjBSRmx6?=
 =?utf-8?B?OFBSSkRSUkMxYkM3T2R5azhISHZiSHdaUExCZjc5UzVnY3ZmdVcxTTZNckpH?=
 =?utf-8?B?eGY2U0U3V3E4U3FjVi9iY2FIQ0E5VjhxY3FsejRidWhuSEdZdHpENytVeFRP?=
 =?utf-8?B?cTBaUnNjUVhsYVpRY2oraWtzOGp3eDdIa05JRTh4eXdXMUNhanlHY3dxUlBE?=
 =?utf-8?B?Z2x1MVREdnlKREM0T1JuWUd4aXRXOEkveW1Ray9VQllkRnZQTTBKTWRlMWNJ?=
 =?utf-8?B?SEpXMVgraEJoZ09rbm9nTi9XT2NJbnZlT09YemFLTFhIemRkOU9kamY1Ty9o?=
 =?utf-8?B?Qyt0REZyK096K2grd0locWJySjZ1T1JyczdJVEJjSFFYLzJEZFZsRXJEazVX?=
 =?utf-8?B?T3BVT1ZLQkVsOFU3RGNSN1dQd0dRTHc2aFI0cVR4K2IwM1l4aWdhVklrT1cw?=
 =?utf-8?Q?MfwsMRcWWirMoJk8Tp+E1Sv/z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sMrE9SuprOnO+6UM5/mRpBWY9j/NcOUBIAaU4UqI/TIYJXHcbovtKZzfuil397O3A/X7dwyGfkuXNFFDrd2RyW/O6mwet1K+asd2NiYJLxWdgki7/0Jd/1HbrOZscyNM6tspRZZe/tetAO3b93DTWivAbKOISHHRU2c5rPFQLv3cbLQrcjA2YcqLuUFSpxeRFZGKpCgbKlnF15TGU7G3apGBixHHdXb8NYzt7Q7PLd4IZO/qeMihp+pbERPK9yqudsnaF69f31lI2F7ZqUqVvNJYu3WjGh/1Qj/hn59ZNg8e8OX7BiotwvSKvzRKKHXpk/WyO4c6wF2kaHcaNH7kyeVieg+YmqLSDSljN5V+PtNUF/fg0rz3cVU2bYb9THVptu7CaZYIL8U1/ndvERqhZSF3exy7At92MI7dfeMpHBOPa1Fol09LcgljQozaE+67FiKdJOeYrVHBfSKuTdTsz97XY/JOapYUqhcfWvGJ5VUJFwAIn2muJbGcSlXHzXAqzx4EuN9bS2IeIg22435UGAuA0K88dmjH6Li/7rV60KqCNS2Q8bC4zHkX4RyHtkOYRzL1lk5auBaUNkDxQRkRs57D+oDLSVBLQy6bI48ak6EWJSkM89t5NgfJyJgxhEbt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dc1f37-1bdd-4e5d-6ba8-08dd69e56613
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 08:33:33.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkglkXm06FXIkbnjYk2q3XdLlqHbt105fkuErpnjnjcOjajtM1lS/MqtZveLXxaGXqoH/0N6+6h19rQVLhsJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14258

VGVycnnvvIwNCg0KTXkgYXBvbG9naWVzLCBUdGhpcyByZXBseSBzaG91bGQgaGF2ZSBiZWVuIGFk
ZHJlc3NlZCB0byB5b3UuIEkgaG9wZSB5b3UgZG9uJ3QgbWluZC4gOikNCg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFpoaWppYW4gTGkgKEZ1aml0c3UpIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTWFyY2ggMjMsIDIwMjUgNDoyNSBQTQ0K
PiBUbzogQm93bWFuLCBUZXJyeSA8dGVycnkuYm93bWFuQGFtZC5jb20+OyBGb250ZW5vdCwgTmF0
aGFuDQo+IDxuYWZvbnRlbkBhbWQuY29tPjsgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhh
dC5jb20+OyBGYW4gTmkNCj4gPG5pZmFuLmN4bEBnbWFpbC5jb20+DQo+IENjOiBsaW51eC1jeGxA
dmdlci5rZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207DQo+IGFsaXNvbi5zY2hv
ZmllbGRAaW50ZWwuY29tOyBsaW51eC1tbUBrdmFjay5vcmc7IGdvdXJyeUBnb3VycnkubmV0Ow0K
PiBQcmFkZWVwVmluZXNoUmVkZHkuS29kYW1hdGlAYW1kLmNvbTsgR290b3UsIFlhc3Vub3JpL+S6
lOWztiDlurfmlocgPHktDQo+IGdvdG9AZnVqaXRzdS5jb20+OyBBbGlzb24gU2Nob2ZpZWxkIDxh
bGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAxLzRd
IGtlcm5lbC9yZXNvdXJjZTogSW50cm9kdWNlIG1hbmFnZWQgU09GVA0KPiBSRVNFUlZFRCByZXNv
dXJjZXMNCj4gDQo+IEhpIE5hdGhhbg0KPiANCj4gPiBOYXRoYW4gYXNrZWQgbWUgdG8gZmluaXNo
IHRoZSBwYXRjaHNldCBzdWJtaXNzaW9uIGluIGhpcyBwbGFjZS4gSGUgaGFzDQo+ID4gdGhlDQo+
ID4gdjMgaXRlcmF0aW9uIHJlYWR5IGFuZCBJIHBsYW4gdG8gc2VuZCB0aGlzIGZvciByZXZpZXcg
bmV4dCB3ZWVrLg0KPiANCj4gSSBoYXZlIGEgbmV3IHVwZGF0ZSBpbiBRRU1VIHdoaWNoIGFsbG93
cyBRRU1VIHRvIGF1dG9tYXRpY2FsbHkNCj4gcHJvZ3JhbWluZyB0aGUgZGV2aWNlIEhETSBkZWNv
ZGVycyBhbmQgdGhlIEhvc3QtYnJpZGdlIEhETSBkZWNvZGVyDQo+IA0KPiBXaXRoIHRoaXMgdXBk
YXRlLCBhZnRlciB0aGUgUUVNVSBndWVzdCBib290ZWQsICB3ZSBjYW4gc2VlIHRoYXQgdGhlIGtl
cm5lbA0KPiB3aWxsIGF1dG9tYXRpY2FsbHkgY29uc3RydWN0IGEgQ3hsIHJlZ2lvbiBmb3IgdGhl
IGVtdWxhdGVkIG1lbW9yeSBkZXZpY2UNCj4gYWNjb3JkaW5nIHRoZSBwcm9ncmFtZWQgSERNIGRl
Y29kZXJzLg0KPiANCj4gSWYgeW91IGFyZSBpbnRlcmVzdGVkIGluIGl0LCBwbGVhc2UgY2hlY2sg
Zm9sbG93aW5nIGJyYW5jaDoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3poaWppYW5saTg4L3FlbXUv
dHJlZS9wcm9ncmFtLWRlY29kZXINCj4gDQo+IE5vdGU6DQo+IE9ubHkgb25lIGhvc3QtYnJpZGdl
ICsgb25lIG1lbWRldiB0b3BvIGlzIHRlc3RlZA0KPiANCj4gQW4gQ1hMIHFlbXUgY29tbWFuZCBs
aW5lIGV4YW1wbGU6DQo+IC1kZXZpY2UgcGNpZS1yb290LXBvcnQsaWQ9cGNpLXJvb3Qsc2xvdD00
LGJ1cz1wY2llLjAsY2hhc3Npcz0wIFwgLWRldmljZSBweGItDQo+IGN4bCxpZD1weGItY3hsLjAs
YnVzPXBjaWUuMCxidXNfbnI9MHgzNSxoZG1fZm9yX3Bhc3N0aHJvdWdoPXRydWUgXCAtZGV2aWNl
DQo+IGN4bC1ycCxpZD1jeGwtcnAtaGIwcnAwLGJ1cz1weGItY3hsLjAsY2hhc3Npcz0wLHNsb3Q9
MCxwb3J0PTAgXCAtZGV2aWNlIGN4bC0NCj4gdHlwZTMsYnVzPWN4bC1ycC1oYjBycDAsdm9sYXRp
bGUtbWVtZGV2PWN4bC1tZW0wLGlkPWN4bC10eXBlMy1jeGwtDQo+IHBtZW0wLHByb2dyYW0taGRt
LWRlY29kZXI9dHJ1ZSBcIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1jeGwtDQo+IG1l
bTAsc2hhcmU9b24sbWVtLXBhdGg9L2hvbWUvbGl6aGlqaWFuL2ltYWdlcy9jeGx0ZXN0MC5yYXcs
c2l6ZT00RyBcIC0NCj4gTSBjeGw9b24sY3hsLWZtdy4wLnRhcmdldHMuMD1weGItY3hsLjAsY3hs
LWZtdy4wLnNpemU9NjRHLGN4bC0NCj4gZm13LjAuaW50ZXJsZWF2ZS1ncmFudWxhcml0eT04ayBc
IC1iaW9zIC9ob21lL2xpemhpamlhbi9zZWFiaW9zL291dC9iaW9zLmJpbg0KPiANCj4gSSB3b3Vs
ZCBhbHNvIGxpa2UgdG8gZXhwcmVzcyBteSBncmF0aXR1ZGUgdG8gR290by1zYW4oQ2MnaW5nKSBm
b3IgaGlzDQo+IGNvbnRyaWJ1dGlvbnMgdG8gdGhlIGNvZGUgcmVnYXJkaW5nIHNvZnQtcmVzZXJ2
ZWQgZW11bGF0aW9uLCB3aGljaCBpbmNsdWRlcw0KPiB3b3JrIG9uIGJvdGggUUVNVSBhbmQgU2Vh
QklPUy4NCj4gDQo+IEZpbmFsbHksIGl0IHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQgaWYg
eW91IGNvdWxkIHNoYXJlIHN0YXR1cyBvZiB5b3VyIFYzDQo+IHBhdGNoLg0KPiANCj4gDQo+IFRo
YW5rcw0KPiBaaGlqaWFuDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
RnJvbTogQm93bWFuLCBUZXJyeSA8dGVycnkuYm93bWFuQGFtZC5jb20+DQo+ID4gU2VudDogU2F0
dXJkYXksIE1hcmNoIDgsIDIwMjUgNzowNSBBTSBoZXJlIGF0IGhvbWUgWW91VHViZSB3ZSdsbCBz
ZWUNCj4gPiB3aGF0IGhhcHBlbnMNCj4gPiBUbzogTGksIFpoaWppYW4v5p2OIOaZuuWdmiA8bGl6
aGlqaWFuQGZ1aml0c3UuY29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA+IDxuYWZvbnRlbkBhbWQu
Y29tPjsgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+OyBGYW4gTmkNCj4gPiA8
bmlmYW4uY3hsQGdtYWlsLmNvbT4NCj4gPiBDYzogbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsg
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOw0KPiA+IGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29t
OyBsaW51eC1tbUBrdmFjay5vcmc7IGdvdXJyeUBnb3VycnkubmV0Ow0KPiA+IFByYWRlZXBWaW5l
c2hSZWRkeS5Lb2RhbWF0aUBhbWQuY29tDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzRd
IGtlcm5lbC9yZXNvdXJjZTogSW50cm9kdWNlIG1hbmFnZWQgU09GVA0KPiA+IFJFU0VSVkVEIHJl
c291cmNlcw0KPiA+DQo+ID4NCj4gPiBIaSBaaGlqaWFuLA0KPiA+DQo+ID4gTmF0aGFuIGFza2Vk
IG1lIHRvIGZpbmlzaCB0aGUgcGF0Y2hzZXQgc3VibWlzc2lvbiBpbiBoaXMgcGxhY2UuIEhlIGhh
cw0KPiA+IHRoZQ0KPiA+IHYzIGl0ZXJhdGlvbiByZWFkeSBhbmQgSSBwbGFuIHRvIHNlbmQgdGhp
cyBmb3IgcmV2aWV3IG5leHQgd2Vlay4NCj4gPg0KPiA+IENhbiB5b3Ugc2hhcmUgdGhlIFFFTVUg
Y2hhbmdlcyBmb3Igc2ltdWxhdGluZyB0aGUgc2l0dWF0aW9uPyBVc2luZw0KPiA+IFFFTVUgd291
bGQgYmUgdmVyeSBoZWxwZnVsLg0KPiA+DQo+ID4gVGhhbmtzIGZvciBvZmZlcmluZyB0byBoZWxw
IHRlc3QgYW5kIHJldmlldy4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gVGVycnkNCj4gPg0KPiA+
DQo+ID4NCg0K
