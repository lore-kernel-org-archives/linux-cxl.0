Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207718A6C1
	for <linux-cxl@vger.kernel.org>; Sun, 23 Mar 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742718362; cv=fail; b=fWKiyOUaPIgrMfufwiz7CDzt5DoDXSfF+Ot/sIU+VqYqEozuUdDthy6NC+FDdGOqueXT7Uv3RSFCTdA6wU5qLWIlzllview9cp/8Jpbx03BOChTPc2FFldPC3Z8aT0YAWx+jVqL0unmgRwex9lVLR29ADD6Q5f0Bva7NYdY004U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742718362; c=relaxed/simple;
	bh=bWKc1T+jZkSx8zEfVRXOtBkPTU4/O1vPiKpb6W6XtEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmaX37rM0bvIttXWt97FUxkKsrkd4cTPI40ceBD9bmyLM4qksQTXpO4jbzrR/C0JKHlrMjeDDmpg7vA8I/mISAdd2pM890RA0VtJrpS01eojAgdy4KBuLxtbsnSACGFr1rr4Cy0j9+0APXdfzPiLdzzYc+2pDE5pOe81450YhNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LTUq+QrY; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LTUq+QrY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742718361; x=1774254361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bWKc1T+jZkSx8zEfVRXOtBkPTU4/O1vPiKpb6W6XtEw=;
  b=LTUq+QrYHAw0MfmYpBqgMKxLvG+ozHXGtlvEHb8ewhe0vKW0YYbKTQmX
   t496qgige6BCuniyrrb5Xvc3+Kk4LIu728BO6qV9lGx1a/zJNDi1kauYI
   3jAqlwvI5zdEGltZOiKgk3Q8QZk8J+U0Zj3p7nLR4w+LD/TUecxUIXz2P
   8LFW0nk8ahsOsSZhwVy5vSS+rsrhW1VoDEcZs4vr6L0em9NTryB89GaHm
   g0XQzhTus3b3HqvJfIFzBJ63TKLMFYAJ3/lrxTkFSMVGAl+6CKXmJ7bt9
   NiwAizQa76fN1hwKA0pP0DSWWtnJ/mSp0Hl+tu0ckiTw6x8p7VX0wnaJX
   A==;
X-CSE-ConnectionGUID: Mm0g2BT5R4qsCMiryx5XWQ==
X-CSE-MsgGUID: aYtlOQUzSYieLA/GfrFKoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="149805010"
X-IronPort-AV: E=Sophos;i="6.14,269,1736780400"; 
   d="scan'208";a="149805010"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 17:24:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM9ffZDpF6lUgtTkmSUOBZzuUxVzQVfCl/gE01ftFQygG29vp747HgJqgUgO3ILU4/WnDW++BLI83qWONeww0ZD9VZhXw3ic9cfC9mB/a9oPwBVIsSW47J8L9e3pVpkcQE667bj+dRqu1Oc+sp7U+WHc9pXVTRI6pbszV8UnIzmYlL0ZcgMwOdxcUC5EPJFUT8LXJje5L4vZvMNd0VyuCEen1M3wc2ztwrZGQe0LhqzjciPRh+Nre4fQHPGtie6ORCF723mUPqMNoY2HJi5UceDSmdDr++boEQhfsK7HiOEB7MaQ0ca+P5aNSEtgI/+HQ+mvvCIzUzOku6NOqrdl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWKc1T+jZkSx8zEfVRXOtBkPTU4/O1vPiKpb6W6XtEw=;
 b=amM/eNFgEYYXPcQVOxa7NckwO49u4no/sRmE32v9HjitFld2TAaDCSBG1aGMXrsBelAzqkU94eXtFBkRaA4XYqDl+XMq2Rzgf46pMXXp1Rr8auFPevzRGlamzGkWcnJPxT9hUAai5NVhtYkhzdfYYls5MbP6ZpMLoDgtbMuizv9ZZwnKXEttxKpUx2I9INkbaKqy/usd5gGJKNso7pCzPOXCXpPwJX+Y1kVy7s/G+2A13LGJtC6EYDbwaOkQ+O7Htyxg0xsTmKi20/uOBZdczeW2PlwLMFBvrXJQxTXq2TNzIvIc5CgOb1IzfYNfrKA6MtzlKFP9x6nfHOBt3fR+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sun, 23 Mar
 2025 08:24:39 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.036; Sun, 23 Mar 2025
 08:24:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, "Fontenot, Nathan"
	<nafonten@amd.com>, David Hildenbrand <david@redhat.com>, Fan Ni
	<nifan.cxl@gmail.com>
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
 AQHbaD4SNAeoR9FhZ0CNhDBQza/56LMg6dmAgACyQoCAALongIACNhcAgAY17oCAAETcAIA8c7EAgAEfbwCAGCuZEA==
Date: Sun, 23 Mar 2025 08:24:39 +0000
Message-ID:
 <TY1PR01MB156225EF913E7568F3B12E05A5A52@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
 <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
 <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
 <3ed69bb2-3c93-42c6-9f02-9519482b112c@amd.com>
In-Reply-To: <3ed69bb2-3c93-42c6-9f02-9519482b112c@amd.com>
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
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB8608:EE_
x-ms-office365-filtering-correlation-id: 2e3762ac-1c85-4fcd-841a-08dd69e42762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVBvNmFzWFBoclhYMGloK1RnNWdPMHczblA5N3M2QkpCWGdDYk9QcVM0ZTAv?=
 =?utf-8?B?UzlwWU9UVXp0YU5nZ3JjVjdVWlU4bm4yRitUR0szSWZLb0x5MW9xR2J0ZUxZ?=
 =?utf-8?B?V05wRVpQMi8zSFdZeVp0MlBvSG1GMTROc3ZOeVVseWQ5aCsybmdRZEI5T3B4?=
 =?utf-8?B?aEFsSkpyb3VDRkV5NnYwdlQ0b0ZjNitMRTJBWnRpQmZWRFlkbHFJcWx1S2Fo?=
 =?utf-8?B?V21UQUc3Sm9aeGIrbDdPaTRWaUgvUGRqcFBvL1R0TzU0OEVoZ21adERtSWpu?=
 =?utf-8?B?U0NFMFZScldkN2czNG1YV1dCOWI2RzhGWFZvdmhPNU9xYUk4NjhvbFhyZERj?=
 =?utf-8?B?b0lRQ3N5cHdOaldoNFVsUHJOeTlMYStKZDd5WDFDRXlFZzZUa1M2NnZOZFhX?=
 =?utf-8?B?c1VJWDU4STNlVko3RU9ta0xjcVZQQng3Y1BWYloxQkRZZW52UXZqQkp2UDJq?=
 =?utf-8?B?WGVJVTl0Y1E5amJDQnlaQ3plaHpBMExoNGtxNEtsbndFaHdiR2pGcEx4VFM5?=
 =?utf-8?B?V2VaMmFkTkJLeEIyZmx3ZXNtbFNRRFppTVh6VU45dzh5SEFzZ3hyajNqelEv?=
 =?utf-8?B?YS95Wi9ZWEY2blZxZzV6RmZ5M3FNcFI2ekM1cXJZbU5oWUVZTGttTjFmUktt?=
 =?utf-8?B?QnpQK1N4eVdSazFUOTRLd0tJNldHOGJGT3Y3QlNpQVkwZzhydy90MEZyaTRX?=
 =?utf-8?B?SXFoM1hjcGJvc295OFZFbDFjYmpUeXhvN09RVEN1UFBNWmJCSzhWOWJQbm9J?=
 =?utf-8?B?N0dJN2x1OWhTY21kUWt0Zzg0RUVlVTZOZjRsdnRFcWJ4WTBQcW5aMlpXWEl1?=
 =?utf-8?B?Y1FocmM4WU4xN0lTMzNJdTV2cURwR0dZY0ZYYUx1ZXhTMUNKT3RPVllFNTFW?=
 =?utf-8?B?UEZlZ2Robi9FTUQwVEd1WFpzNUZKRmZYYzNLUXRCWkJFeFJDNmtIRERuZ0NM?=
 =?utf-8?B?ZDFZZzFvaWN2a1Y0MUxPckNQNUN3ZTY0RFk5WkJNcjh5UHlVcG5TUEhjUjQz?=
 =?utf-8?B?ZmhnNzRTVzluTTN6WDBmRXN2V2F0RW5ySHNFZkp5VDdldnF5SWh1b3hBdVdI?=
 =?utf-8?B?bmdDUnByT1VUYnFmMEJQQVBnV3hHL3FkVWNJM1AydTczSHN4RFRmVHhvY0cx?=
 =?utf-8?B?c3RrQlNYNU9WM0R0WGVWWHF1bGtydXA2bzlLNm5FTXpsOXZURkdNcVpaN2ky?=
 =?utf-8?B?UGd1YVQ5MUNWOFZ0V2tWUVdUV3Z2ak92aE9IWExvQjgvYmpaZzBPTm4xRVlm?=
 =?utf-8?B?R3g3TERMQ09qS2RpdXM5c3BwcHVJdFZHODRzTEZRSlFjVW1qbWZzdzUyRzdW?=
 =?utf-8?B?anBoc2JLUngybEp3ei9nRzJvNTdVbXE4TWp2QnZVWWx0MnZyK05xeGtQZ21F?=
 =?utf-8?B?NHhKYmNrdllBWU1JNkZJNmRoS3dCSEdTV1k0S24vVFc1RVIzRzNPWGdteEpx?=
 =?utf-8?B?UFZGQWJYRFZhU2gybDlNWk9MOWY3dXduNVFVcGtWaWFGcGxOQ0RKc09WaHRP?=
 =?utf-8?B?cjNaOFNyVVlDYWxLUCtrbG5JdUdmQnBEdVRZcFVjYWxMZjNzNVRNQ1ZrWG5l?=
 =?utf-8?B?d0RqQ2ZJOURXb3VDYW5rUitYRFYzWVJqL1JUMm1wajNkU3UzQ0xqVEFSaHBV?=
 =?utf-8?B?RFNkdFZUZC9Gaml4Uk1HcVNjTUFKL0ZnQTdHci9WVUtic05pbWtiMHo5Qnhh?=
 =?utf-8?B?R0ZPUnQ0UHVwb1kySkZiVnJ2QTVZVlFoVWZlQVE5M1JHRGhXQmVHV0lzamx4?=
 =?utf-8?B?Q2tVUE1PbVBZczdWcGMzTUhxbDIvUTY2U2hYTTAva0JCaisrZHdGeE1NYkw1?=
 =?utf-8?B?U1psVytyRElDcEw3NkxUQ1hobVBmR3JmYXRlN1FDRVFwandsOFp1WEdzL0xZ?=
 =?utf-8?B?azVRVFdiZ3Z6WmpzaVBEMzJISW96akxMV2NjSzdwTFBGKzhWeXErKzRZcEVJ?=
 =?utf-8?B?cndENnFBOG5JUU44R2U2UFoxYnBaNWdoZHBhQmNMYitsUjYreWxzSkxQQmpm?=
 =?utf-8?B?QjN3NlV2clJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3lyOUhWaGpDWFQ3bmZKT1JuelhseVErTGV5UG9RTnFnbHhrYlp5TTRQYkpx?=
 =?utf-8?B?OFBldm5HUFVDZElmdDhqSndWTldzUG9JWlNRU05vaWpVR1FYeEd2TU1Dclhh?=
 =?utf-8?B?RzZJVlBLTEV6V3ZxdFhUY1JjTlYrSlJwRGNqNHpZN0ZnYkE5WjQ5OXBDaFE1?=
 =?utf-8?B?WEhPcmtPVWc4b1RqYVI0MzV0MGVyNklsMmowM3JaZWNybEtJV3h6WDMwSkRt?=
 =?utf-8?B?dk51S1AxZUluMHVCdmlPOEE0NjVremsyUXNSOHFCKzBPVDdBMGtnRGg0T3V3?=
 =?utf-8?B?bjFDWEk4N1Q2dmFMdXdDeEp6MDcrcU85cEttOWE1TFJxbTFNNlY4U2JLb2Ux?=
 =?utf-8?B?eUVUVmtjZjZ6ckZuYmNibHpSWDF2VWdnZnRNUHF1SnJXdzRpMXNldXlTSHlR?=
 =?utf-8?B?ejQxbnIvMXdDUE1QY2NuWjBZblJOdHNxN1J4OXp5ZDNHODBQaUY3dTNFaEht?=
 =?utf-8?B?TFA2QXc2RmZ3dXVZbkFWa0hoZlNhVkRnNnRMclZzYXY4YnIyZmtkYWlXRHpw?=
 =?utf-8?B?ejRTT2k5bnY3aWJsTTFwVjA5M1NndmhkcmhSVlcyV0lubFJsbEk1OXpzeUs1?=
 =?utf-8?B?S01kTENpOTg0akJ6YWFsMkpmWE1VSjcxSXVWNzhpMzZwb3ZnZVVZd0xaQy9Y?=
 =?utf-8?B?TEJxR09HNHJ1d1NMakdrNVIxUEFRblh2TWVEc2NEckZqbEwxWDVVVWU5ZXNn?=
 =?utf-8?B?SDJkbFN4OVVBZXRIT3hYL2pTRERPR25odHpsWXhSRjAyYnRiVURCSS9JYW13?=
 =?utf-8?B?MnN0QmlCVXlJeEhvL1QzVkh0Wi9BZFp3R0tZYzhKa1ROMUNUREtLVjZCTkw1?=
 =?utf-8?B?bGtjV09Pa1NtY3RzZkZkRVZnc0hSaVJGczlFdTc5V0ltTEVFOG9vRU9JaklW?=
 =?utf-8?B?Rm5aTDl4K0JTVW5uamRyLzRUZlZRNUo0T3lnU0g0c29XQ29Oa1k4WUhMK2VN?=
 =?utf-8?B?SjZRSHVhVVdyTW1IQkVscThSSmhjdXBRbElrcFVHTGZ4SmdGb2Q1MlhSZmFV?=
 =?utf-8?B?WUpla0pnVWIreFRvVHIrMFplMXNGN0FIZ3d6MmJnaXdsNmhzNUdFSVZTanJX?=
 =?utf-8?B?cS9QY2drYTV6N1poZlFoeUhtb2Q3UVVKalZTMlF2OGxUd0g5TFBEREZSdWkw?=
 =?utf-8?B?YnFncW9CZ0pBaDZUOHBtTEl6Y1g2NHcvMFE3WTIyNWt5V2J4QTk5UU0wUklj?=
 =?utf-8?B?L0J3L2diaWNySU9FMFBwa2d5ZzBGbkFaa0FkVk5WTktHZ1hDayswTW5sMHUy?=
 =?utf-8?B?WjNwUHdybm1hT2NzL1ZCdjdPZDRKN3RqbGdqYWdmQnNHcGdhOHlZNEx2YXRn?=
 =?utf-8?B?S2p0cTNyZ25tNHp3b1B0TWVaNlpNT0VhVWkzS1ZCcEJOOGIreGxPdWhVWUZw?=
 =?utf-8?B?N0NEUFRJdWpSbk84bFhsOVNYOHhxaThUQWwvUm12bFlXdEorUFg0K2x4OGtQ?=
 =?utf-8?B?MFJUNGdpbU1US2FEYS9sSmdaVHM1T3pwRHB0dEliUG05ZEFxTXJGU1AvV3lO?=
 =?utf-8?B?WTNsM05TcnZpSVJCeDVpZ1lIa0RWZzVySUVYUENkSVg3TkJRL0R6YWlMYU5j?=
 =?utf-8?B?TlhoTDVZRmlYMk11WG1zL2duQS9ZcHE2OGtCRm5DaDF3c2Zjd2cxcWFvL3VC?=
 =?utf-8?B?VXBBb01SRWRKd205VkdWWU5YRXpGNlhUOEpPdzNndTBOU0JrQ1FpK0MxTS9F?=
 =?utf-8?B?L2ZyQnNBK05wZXgvSEVzUEFxbGhrZURhcTRsUDVDNzVBTlRFcHJmbjZOUms1?=
 =?utf-8?B?TnU4MzJLVHQ2bDIyQmh3SW96L0QyRjFyN21RaGh2ZmhFelZjTHZCd1RnQk9u?=
 =?utf-8?B?N2RwRTJaSjA1SlE1c05pMm1oUG5vZzR6NzFMTlF4TXVySlgzWEJoM1QvdXdG?=
 =?utf-8?B?U1RMMHY5UGhROEZhS3hWOVQ1bjlrRlZtNE51d1pKb0NLOUVnNDJmbFBhaTdm?=
 =?utf-8?B?NU5aKy9kMmdBTVVtU3l4Vlg3UGlRbkthdmx4d2ZCTkJrSFJzRWpET3poY3hZ?=
 =?utf-8?B?VXFnNi9EcGoweE5sZWFyem51RGFqaW5KY2JwSUNzaEZtTE5KbHMvWHMzcUcy?=
 =?utf-8?B?UXJWMkoyZVpja1VNcVFWdStzVGF5bEJDMDQwVXJ6c0MyeVBTS1U0OXEwQUxh?=
 =?utf-8?Q?qCY5c9D8Xv1T8hL6aeS/Wqu0w?=
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
	EdVN/3UJyQzc5f7kzPeo432kBPJssfcIg0ImTXduHHucyQ6LNVtELAYIS2Ni1PEbtk4DZZZjXksfG08O9XMIU2Q6FWMOKXVJEgVifZp3FUKW2jvH1kGDZx5bhcaR5ue2EVQphBcmtuDGQE20NwlMU5n71XD4Mot+lBYZUc/OxoObs08Lzi5cqGpqC+ImI+NQbyFkbCFz6Vf6rKKqx0wB2H4/wVO9FDS572+gvwdyHCulS3t7SEhOscIXAQQg9IWiHdaze8J/SMcQPPNGwzOAP2WCYuDnfjrgAprR3PIRv8o9yL7+npB6eoDZhJLjH4bg9D3YvV11OjcsGxED6SOXALL+U7pUWIs05HK6ncBKlycWPMX9pgYFWpjWDmpuxMr2prKd7cMiyOrhIOYx71jFZcsSDnjT4joLt6VSxvHouV6WZ16mmEVZGiIrqnKmoTfmRKdi68cQjGe7B+nh4QtR7h95J+r0FL9K00xqoh4Cdzq7vkDpk3d2lo2z1aR2lQ/pCGxN64Xc2zLsroDwzqlFGB8iP2TGn762M0R8/Kcee1Xl2021NzCjuTHfpndJYcuRO7f+3WTMYHX0HkMfOrWg8HX2cTXtcbP+uTmJ7K784Ozp/PaRROYyQXzS/b7BWvoB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3762ac-1c85-4fcd-841a-08dd69e42762
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 08:24:39.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZfa/RW0kjVTGlLCTKbIe+aSnVe7R2zCh94rfg5tdfDcSop04A+WSFjWdC7S6CwuvjjibpRJRL5WMf/Mlu+CZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8608

SGkgTmF0aGFuDQoNCj4gTmF0aGFuIGFza2VkIG1lIHRvIGZpbmlzaCB0aGUgcGF0Y2hzZXQgc3Vi
bWlzc2lvbiBpbiBoaXMgcGxhY2UuIEhlIGhhcyB0aGUNCj4gdjMgaXRlcmF0aW9uIHJlYWR5IGFu
ZCBJIHBsYW4gdG8gc2VuZCB0aGlzIGZvciByZXZpZXcgbmV4dCB3ZWVrLg0KDQpJIGhhdmUgYSBu
ZXcgdXBkYXRlIGluIFFFTVUgd2hpY2ggYWxsb3dzIFFFTVUgdG8gYXV0b21hdGljYWxseSBwcm9n
cmFtaW5nIHRoZSBkZXZpY2UgSERNIGRlY29kZXJzDQphbmQgdGhlIEhvc3QtYnJpZGdlIEhETSBk
ZWNvZGVyDQoNCldpdGggdGhpcyB1cGRhdGUsIGFmdGVyIHRoZSBRRU1VIGd1ZXN0IGJvb3RlZCwg
IHdlIGNhbiBzZWUgdGhhdCB0aGUga2VybmVsIHdpbGwgYXV0b21hdGljYWxseSBjb25zdHJ1Y3Qg
YQ0KQ3hsIHJlZ2lvbiBmb3IgdGhlIGVtdWxhdGVkIG1lbW9yeSBkZXZpY2UgYWNjb3JkaW5nIHRo
ZSBwcm9ncmFtZWQgSERNIGRlY29kZXJzLg0KDQpJZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gaXQs
IHBsZWFzZSBjaGVjayBmb2xsb3dpbmcgYnJhbmNoOiANCmh0dHBzOi8vZ2l0aHViLmNvbS96aGlq
aWFubGk4OC9xZW11L3RyZWUvcHJvZ3JhbS1kZWNvZGVyDQoNCk5vdGU6DQpPbmx5IG9uZSBob3N0
LWJyaWRnZSArIG9uZSBtZW1kZXYgdG9wbyBpcyB0ZXN0ZWQNCg0KQW4gQ1hMIHFlbXUgY29tbWFu
ZCBsaW5lIGV4YW1wbGU6DQotZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaS1yb290LHNsb3Q9
NCxidXM9cGNpZS4wLGNoYXNzaXM9MCBcDQotZGV2aWNlIHB4Yi1jeGwsaWQ9cHhiLWN4bC4wLGJ1
cz1wY2llLjAsYnVzX25yPTB4MzUsaGRtX2Zvcl9wYXNzdGhyb3VnaD10cnVlIFwNCi1kZXZpY2Ug
Y3hsLXJwLGlkPWN4bC1ycC1oYjBycDAsYnVzPXB4Yi1jeGwuMCxjaGFzc2lzPTAsc2xvdD0wLHBv
cnQ9MCBcDQotZGV2aWNlIGN4bC10eXBlMyxidXM9Y3hsLXJwLWhiMHJwMCx2b2xhdGlsZS1tZW1k
ZXY9Y3hsLW1lbTAsaWQ9Y3hsLXR5cGUzLWN4bC1wbWVtMCxwcm9ncmFtLWhkbS1kZWNvZGVyPXRy
dWUgXA0KLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPWN4bC1tZW0wLHNoYXJlPW9uLG1l
bS1wYXRoPS9ob21lL2xpemhpamlhbi9pbWFnZXMvY3hsdGVzdDAucmF3LHNpemU9NEcgXA0KLU0g
Y3hsPW9uLGN4bC1mbXcuMC50YXJnZXRzLjA9cHhiLWN4bC4wLGN4bC1mbXcuMC5zaXplPTY0Ryxj
eGwtZm13LjAuaW50ZXJsZWF2ZS1ncmFudWxhcml0eT04ayBcDQotYmlvcyAvaG9tZS9saXpoaWpp
YW4vc2VhYmlvcy9vdXQvYmlvcy5iaW4NCg0KSSB3b3VsZCBhbHNvIGxpa2UgdG8gZXhwcmVzcyBt
eSBncmF0aXR1ZGUgdG8gR290by1zYW4oQ2MnaW5nKSBmb3IgaGlzIGNvbnRyaWJ1dGlvbnMgdG8g
dGhlIGNvZGUgcmVnYXJkaW5nDQpzb2Z0LXJlc2VydmVkIGVtdWxhdGlvbiwgd2hpY2ggaW5jbHVk
ZXMgd29yayBvbiBib3RoIFFFTVUgYW5kIFNlYUJJT1MuDQoNCkZpbmFsbHksIGl0IHdvdWxkIGJl
IGdyZWF0bHkgYXBwcmVjaWF0ZWQgaWYgeW91IGNvdWxkIHNoYXJlIHN0YXR1cyBvZiB5b3VyIFYz
IHBhdGNoLg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEJvd21hbiwgVGVycnkgPHRlcnJ5LmJvd21hbkBhbWQuY29tPg0KPiBTZW50
OiBTYXR1cmRheSwgTWFyY2ggOCwgMjAyNSA3OjA1IEFNIGhlcmUgYXQgaG9tZSBZb3VUdWJlIHdl
J2xsIHNlZSB3aGF0IGhhcHBlbnMNCj4gVG86IExpLCBaaGlqaWFuL+adjiDmmbrlnZogPGxpemhp
amlhbkBmdWppdHN1LmNvbT47IEZvbnRlbm90LCBOYXRoYW4NCj4gPG5hZm9udGVuQGFtZC5jb20+
OyBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT47IEZhbiBOaQ0KPiA8bmlmYW4u
Y3hsQGdtYWlsLmNvbT4NCj4gQ2M6IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbTsNCj4gYWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IGxpbnV4LW1t
QGt2YWNrLm9yZzsgZ291cnJ5QGdvdXJyeS5uZXQ7DQo+IFByYWRlZXBWaW5lc2hSZWRkeS5Lb2Rh
bWF0aUBhbWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS80XSBrZXJuZWwvcmVzb3Vy
Y2U6IEludHJvZHVjZSBtYW5hZ2VkIFNPRlQNCj4gUkVTRVJWRUQgcmVzb3VyY2VzDQo+IA0KPiAN
Cj4gSGkgWmhpamlhbiwNCj4gDQo+IE5hdGhhbiBhc2tlZCBtZSB0byBmaW5pc2ggdGhlIHBhdGNo
c2V0IHN1Ym1pc3Npb24gaW4gaGlzIHBsYWNlLiBIZSBoYXMgdGhlDQo+IHYzIGl0ZXJhdGlvbiBy
ZWFkeSBhbmQgSSBwbGFuIHRvIHNlbmQgdGhpcyBmb3IgcmV2aWV3IG5leHQgd2Vlay4NCj4gDQo+
IENhbiB5b3Ugc2hhcmUgdGhlIFFFTVUgY2hhbmdlcyBmb3Igc2ltdWxhdGluZyB0aGUgc2l0dWF0
aW9uPyBVc2luZyBRRU1VDQo+IHdvdWxkIGJlIHZlcnkgaGVscGZ1bC4NCj4gDQo+IFRoYW5rcyBm
b3Igb2ZmZXJpbmcgdG8gaGVscCB0ZXN0IGFuZCByZXZpZXcuDQo+IA0KPiBSZWdhcmRzLA0KPiBU
ZXJyeQ0KPiANCj4gDQo+IA0KDQo=
