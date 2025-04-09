Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DFC25B66B;
	Wed,  9 Apr 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193025; cv=fail; b=blVLNCzpovm+H30NQMuaGp0wnshYxbVUU9mFrTD3LdEV47n4N4Fgobhso/lD+VieNpb6QLU6ODZAM3P7SpBXTA5lYSRrbPhEvAWDNtSBREOk1LQhHd3cxUCfBfLwuU2CsOIcF0fRkCeISTaReRgdxsUKOz5mdBYbz+wYD0tB9rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193025; c=relaxed/simple;
	bh=nrSdD4j7lQHBDQ7N5V/smO4iadfDOyZdvEYfT+Zo6xE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGMcvobdd2jfQkaG65nLBgFKDm1kO6dNtznWDfQvsN5K4QOCOI7eqPY9eRjMC5GgITnt4MzA/4QER7NWHwGBaOUVyA6xbNRHWEFcniahOYy6vN8ugLCoQ2APYHK91AsQBVlW87kBMkK0iE9QNqfVYBI+waOnaiHkGAUwLsbMIJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=n0f13ZUL; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="n0f13ZUL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744193024; x=1775729024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nrSdD4j7lQHBDQ7N5V/smO4iadfDOyZdvEYfT+Zo6xE=;
  b=n0f13ZUL2oxTigt3voifTw4e+9ANk+CB7Huz5Ps4SXAleAKJywylAebI
   wKUvufPLf1KAyXBt8g6+0H+bBAAqHXDBwgc0+bk76nB0TDB8sDpnsKDEV
   Gl6eH4eScn846UApVtUDTP5HGcfQBzYe00Jk7H5/VxukAArvm1P8kEM0C
   CalDtQ72D2RJKOG8zKJ5dZXCoQ63prU8MJ8jJpir4kHcB3sVx/bOeQ/vD
   P/8pJfASi0ExUejMKNFhCrWEzy4Yj0WqkYpvWiYwLUzBRyvyFK9Scs7PT
   QxBOdnciUoGvZuU7bBJ+CMcG60hnoFm0MuUA+B2mrqmWyp5sQH2KD4Bwj
   Q==;
X-CSE-ConnectionGUID: /gaNvPM/QAi5x6hacHSstw==
X-CSE-MsgGUID: bw5td/hiQLSzJulV7e/LIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63250488"
X-IronPort-AV: E=Sophos;i="6.15,200,1739804400"; 
   d="scan'208";a="63250488"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 19:03:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqo9O75dY+Byg+42DnTkgWmuOQXccDqh0dqYqRcItd/HK08DHTxdEVBBSHL7h5eblHLzTOFe/NJnhyZ8nuHEOb0XNl0UiPHoOtO/JKeM8g8IdjjQ/idUWzqF10o9mqWAPcWBVCvfSV4A4c3G0eG9pZ+Tb+t9Vg22E6Fb+hE0XqnICB8d6RVcB7X4j8D/PBIdwLricH4JFr/STRu0NMKC62Oitfdqr+40Ypl5YCXL7l/m4TdblHO0IAnnfRTfVNX38hzLDOmjVeNu5h9rNvAZ70jIZtj4cEns/SxA6lg6QRlIbDgR1zhQ/3zzKyHK4MSh+YpHu+pk4GoeqB9e/JzQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrSdD4j7lQHBDQ7N5V/smO4iadfDOyZdvEYfT+Zo6xE=;
 b=DAv4vQz7oBOkwcjW90uKJk542Qmz25hkPqioYXvgP7aM6Nv6W3njLkwEy4H9oRgXP4VFeOhtHSB/PouzyfkxV+Pq+Rzsxx6Rc/AbeTFGIk/gYLJCoMBwgwhCZYm45mpL0Uf0JqvbkjM9y9oWY12340WOp8XqXvaDJ0AQ3JOWD7d0Ltm5MoiCo6WgebULahmMO2JBsbAT/V2E9t+EMOVq+hwSBjXBp/zdIao+Zxtx5mGBGrBAM60467Cu6krqMwoKNoXReX+vJDlGqBzjg2ArORXjT9lB8RY8Qv1Ice/kbLTt5d6os3SovekXLZenRg7MYz+aG6PgqvXMQ9Wf3H+vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB14032.jpnprd01.prod.outlook.com (2603:1096:405:21c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 10:03:25 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 10:03:25 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Topic: [PATCH v2] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Index: AQHbp5NmqZq4yRRfk0Szu21H7WGUH7Oala+AgACIagA=
Date: Wed, 9 Apr 2025 10:03:25 +0000
Message-ID: <a6bd65cb-9d66-4fa8-8fed-42eac36b2a5e@fujitsu.com>
References: <20250407080217.76117-1-lizhijian@fujitsu.com>
 <Z_XTe8r7Syn9Y4cf@aschofie-mobl2.lan>
In-Reply-To: <Z_XTe8r7Syn9Y4cf@aschofie-mobl2.lan>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB14032:EE_
x-ms-office365-filtering-correlation-id: d1268b04-86a5-4bc4-6c5c-08dd774dc4c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUxoVHdhNmVJUkk1WGVTS0k4V0NjY2pLVzJWd2dyKzkzckRFOGQ0SG85T3lW?=
 =?utf-8?B?RVRiYUtINmxsT1ZWTGlmWGN5aGRMV29WQ0VhbGh0Z0ptZGlOVU9USm9peURT?=
 =?utf-8?B?YUJYQk1panE5YjQxNDBaSklNVU1KbVJiNWlqSXBlcVVEZlRIZWw5S2FJTHBC?=
 =?utf-8?B?MHhzRUZ0Q0VGZXF5a3R1Nnd0MlVYV3F1RTFNNUVacDZRTVNLTnZib3ovd1JS?=
 =?utf-8?B?US9QOTZPK0k5RjdEMHM3aVRQVGtNbGc1cE85ZEpLeDBrRU1DOExsYXlWZ3hx?=
 =?utf-8?B?SjdHVDJkd3ZKSDBiN1hnMU9rc2VJZjZqKzg5WE5SRWZ2MW1YcmVwVTQzTjVl?=
 =?utf-8?B?dXFVdEEzdHVTUndDZ1NQL0pWbWxDQmxEMHlVTlllbFlHUThzRmViK3VXS0c3?=
 =?utf-8?B?UEZpdDF5dVdndlJKdEhEZU9Dd0NrU2txajAzZDdaUE9QaVZaMitab2Z6WEJK?=
 =?utf-8?B?VWtLSWY0aDlzZUZVMDE1eFp0bmZ1MDc4cEVBTzZyZCt2VGJUM01Va1RZcU8w?=
 =?utf-8?B?Mk0za3R2bkRESzg1MWRkZEUyVFY4TVF5TFBmaGtaRnRJekdRMEJDVVpGOXkw?=
 =?utf-8?B?eHhXd1ljRDFsUlZVS1FRcVRQYzNZWCs0Q2pqVlFDdG81eXQxSFdiSmg4cDIy?=
 =?utf-8?B?OTZDVnZQeTg0Z2VpY294M2t2NkFVRzJGNzdNQjFHV3lMZUViSnMzSEJEZHVk?=
 =?utf-8?B?NFhObHR0MW1WaGRBNmZIeHE4eDZsU1J5ZDJMNExuR0VXS0RBR1VZeHo3eldY?=
 =?utf-8?B?WFUyd0JWK1Y0NHBTWSt2T3U0b0p6SzNXWEMzdVVJNWptT2hGMDB3YXB3eHMy?=
 =?utf-8?B?SnBVTEVYSkZHY29OZ3ZPYVJzN2FXZHJJa3kwMjcwZWpCTXlSU0thcjdvK0t1?=
 =?utf-8?B?a3JlZVdTaW5vZHZadnlIcEpEYVJCazRnK0p6bVUvczVSaTUzNnE1anJVSmV2?=
 =?utf-8?B?Lzh2WkV4NE9Vd2Q2M1JnMTh2STkrMGp6K2hWMnRwcWhuVzkranFpajFkbW05?=
 =?utf-8?B?cXloK1JLc3FXM29KTlQzNytpYkU1c0gwb1c1bk1TRGtQY1hodWJzbFM2TUMy?=
 =?utf-8?B?QkpDN1Z2RnZmSXRrYzlUcDRkU01PS0pVWGlGN2xoaWdDLzBPVTVwMHZCeWZp?=
 =?utf-8?B?ZExPc2JBVTV4S2MvQkM2SWQrRFR6YWhNSkQzTGlRRlhWWEkxbi9vc1hCQVFw?=
 =?utf-8?B?aS9qcTdUem1EbFNBbDh6MFJtWkhLSGUzSllraG9uOVFscm5EVTQrUG5xYUY5?=
 =?utf-8?B?aysyZWtZYTk0emhrM1VWdVZpdldsMUYvd0h6MFNjSGVXallqbjQ3b2xWVnFv?=
 =?utf-8?B?U2N4dEpMUnYrN05vUUh1dktRbmRQSjhEQ0hmRVpJSUhEMTQxSHViNHRKNjVt?=
 =?utf-8?B?ejlhNjh2VHFUL0xmY2JCVFFMTXBmSldzZWdvTjNtZW1zbG1EY0w5bjN0bXNJ?=
 =?utf-8?B?OUJOOE5YMit5R2NORDFackZ2S2pWUTQ3OXdzWmE2R1ppOHVBK1JzUHdIeGo2?=
 =?utf-8?B?bEpYQktOZFRYc1FNMzNTZWlyNks2Q0ZQVUFxbnpVM21rWmtvVHRSR24wcHpl?=
 =?utf-8?B?SXpmQWppUU91SWYwMGIrVkkvRTQ4OWEvaWpEOHhycitqWE5SRTRSSlA3ODFx?=
 =?utf-8?B?Z1ZlaU8rTlVXeDB0c05saWdETVZpelVSMjQxaWZ5c3ZrMGxYbHUwK2w5OXd1?=
 =?utf-8?B?NTZMVWxsZ1M1RG4zbkNRTFM3WXd1QzFnU2lpTWdaK2Rac1BDWmUxRm52Wm5q?=
 =?utf-8?B?OG8zWUlJWkEwSTRET0o4WnhVbWxBVXZlSjZUSFZ3MUorakVldTJRZWdIKzZ1?=
 =?utf-8?B?K3Fwc1FwRHNvbHRSRFdrcHRoK3IrTVFHa3hITWtKZk4xTFpuNWhOdUJXc2da?=
 =?utf-8?B?VTBWOS9ESEF6NmNpRm9CMmNNNGFRSUxBTzRpbGFVL0R5WThpb0dLdnQ5UHlv?=
 =?utf-8?B?S0h2ZGlBMnBzbDlyTDN5NmxRRVlHS2YzVi9LMjVXYjNQLzRRR3A3QzlOMDRp?=
 =?utf-8?B?S0pVRFk1TFJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEFHdk5qNVl3czlEYklocEVQSlU4SldPK294REM2WEtmVHRLT2Uwa2MyVkhI?=
 =?utf-8?B?TGQ1S1grVlBIS0RYeGhzNlZwejA5a1hWSzR6RVNJdlF1Y3R3SVYxMFYyRmZM?=
 =?utf-8?B?U1d1d29NUVd4bUs0aXJOQVhzVzFpVUl1amxTWlRpQ1k0aUozQ3ZzamRYRGw4?=
 =?utf-8?B?a05SZkgzbjk3ZXpuQ0w3T1lpb1FCLzYyUWtORUxFeWlJV1FlR3pEeTZSdVZq?=
 =?utf-8?B?ZGRZSTN6RUxFT3R4SzRDNVVNdGRZNUtlUmhXazYzcEczV1FHTmNGQ2JBYUty?=
 =?utf-8?B?cDhzMkRqbUlrRWFXczlIbE0zekZmRWJYeTNPZHEwWUlkRGFiR1cxSlJFN0Vj?=
 =?utf-8?B?eWhISFlXSXNTQWJOOGh4aDB5bFY2V3FSUmwvVkFPM0s0bXpmYnZHQ3J5dmRm?=
 =?utf-8?B?TUhhQ1BEMTQySjJackFqMEZWQ2pydnlqbnlST2k5anA5T2hWNG1nT3I5ck5q?=
 =?utf-8?B?bFlUVm0vR3RjMTVOS1luMXl2V21sM0wrRjZLeTkzQjM2Y2R0Vy8rblNXdGl2?=
 =?utf-8?B?VXZIZGhWWEIrTENadmFrclVONjRRUjExK1FKYzg2UGxLQlNPejNydHJzWFJL?=
 =?utf-8?B?K0Q2djk1Zks3Z0V1R0lxZDRkeGJaQldMQ1lXWnZvSEFRS0ZmOWxCdGoyaXdC?=
 =?utf-8?B?VXZsZlF6UGxhOExzUFFnZEpaaU9HUDBiUWtJcDlVZkVvUzhzaVd3Tmx0UGRa?=
 =?utf-8?B?WWpoeG44VkxtY1NWWk5KbUFveW5rTWt1NGEydW9vbDk2b2YrT3JibWNPOGNF?=
 =?utf-8?B?emtkNE5wallEdHhKSnRVQ3VYcm9hOVpCTVR0SnFqN0ZicERCcS9keGw1NlRU?=
 =?utf-8?B?am0rWW04MlJWWnpVcm9wU08zZnBXc1JYVFovTkMxbnU3bkc1Ukl0ZmVzdk0v?=
 =?utf-8?B?OEkvS2dHQ1NjOTJjK29MUWhleUgvZVRKSEJGYWNJOUdwN1pjMmhFYkhsMExP?=
 =?utf-8?B?K2xaUHM1VkNyaHh4ZWllc1h3Y2JmM1IvRllxTFdiUVZ3QW1rTWJUcnFROUNR?=
 =?utf-8?B?ZTA4NkwrdS92akxLaXEwYUNpYlZqT1V5bE80a1Y5NG1xZ3NOWVc1ZGtxcUJV?=
 =?utf-8?B?NkJ4Q3dlRWNxdExCcmlZQjcxRWdwcG5mdHZJOXBNRjRKeHR2VzIwSndRTzMx?=
 =?utf-8?B?eWlUeFV2bDVrc1Bsbmp4b2t5TjREaDdkNVROcTNhL1pMUlhKa0hOcTFuSEZG?=
 =?utf-8?B?WFZhaS8yZjN2R3lIQjRtRUI1ZnIweUhncFdNc0d4SE5ra0FoMzlDMVNSRGVR?=
 =?utf-8?B?NTJmOXd0WGhDUVQyMHlTMlRKK3hlaTNaTzYxSnZYdklha0k1cFhzK0plSDU0?=
 =?utf-8?B?MEJkK3FWamVuQmIvQTY1MVIvMnB1dktwSDFHMVliMlhSVlNTbHBOU3M2YWEr?=
 =?utf-8?B?cDRQME1taFVBL2gybCtoZU1OSzV2NjA3ME1uYkpVQWQzbmhGaG1ydjZpQlFQ?=
 =?utf-8?B?dFphNE54SGtWUklOeEk1UXNGNm84MWFaTFU5eVNFbHh1WkdOdFVlWmpaNitZ?=
 =?utf-8?B?V2xOM0ExU24wejdzZ0dPNGlyQlVNaklDTm5oUVJFTVJlRVVwUEREQlVMWjho?=
 =?utf-8?B?dnhLZmUyekE3d2U1RHViQ3AvdUdYTVZEWE5mdjlESHVsNnBYSk5BckRQQVF1?=
 =?utf-8?B?OE9NMy9DVVhvRitxNmRLSnFIcGszYTBmMVFMYUtlcjE1QkFiSFRKTkw4SlBj?=
 =?utf-8?B?OXFXR0VnNVdMS2xjQkJaOWNOS0FlcGRockZWQjNqbkc4T1pCRC90bktaaysz?=
 =?utf-8?B?eHhjQy9tTFZHOGlQdmZOUEtpZ0lxNDZXb21sVWE0RTZVWDJua2p4anpnbG1B?=
 =?utf-8?B?RSs1dXZRY1BPZUgzaXFDRXJrbnlSM3NLRnBiQlZxRGc3eVVjSWZCdUkvYlJF?=
 =?utf-8?B?NHEzbWUyejdzNVJ2azdselQzaGJ0L3ZhVFMrTmltaEM3cUZPc001NnlheVdq?=
 =?utf-8?B?dFJUMjltTm5Wc1J5ellLYTZxb3R3bTNyeG9VdDNWb0RDc1VtVFFndEZNUzhK?=
 =?utf-8?B?Ny9pUFZEKzZZUXdXQzZSc083WU1DdjRlV09lWFpxN1RYb1R5U3R0OFp6UjYx?=
 =?utf-8?B?dDdzaDRaTXVzSFI5Tm1LcVRhbURZdmZWbXQxRmx0VFFIVDd1WHpBdEZOYVBz?=
 =?utf-8?B?WWhBV2dxaWcyN3AyQ0krbGxYaWlMcXdXbnNMTHh5b1hyN3FCMG1EcUpocTdK?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B414A174481A244A9B695BC7EA94CEAE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mcV6ZdvGgwo7O12OTH4JS4kIG8d9RAg2iwBtbwnTj/4fcrXQTrLCDSzz8FXOgUw5jlEVrsdEgIuLHIV2wKijh3ZdUrGaN76C3cSiPUumubvqES9mEiRhtbjPoEGKWVISl26kq1VuXCUXUdS5bGDkwE3jWltoCaCp/cGNDEltQzCvCFMtI41CngNOvPuRaBD/ZApcPxa77Fo92Fx/yFsPbBnVlhpfzm0lxKqmiXjxmqYjssRs55RCBiH9ATxhHZnvwdIh0Qf2ugjx85D/9h32JByMnYut4pvdgBJHo8CdfMbpte4I9D9A7lpR6xGSvtzPC56LIZ+S+EzhILIxeI0b6GhlQ/a4jFiE25+NxpA7OKEyBlKnAF7/XKYjCF8rK79D486KjpSsUTq4wy13kQw78NbEhb044YC3tG3t0aDrB52k+Ii97pIUSrRRrZ2Qshz1/DXLQkilKbtBojQTslc8GbKAUUeCFnhbF2lBOuBIgUyCS2Nij1Mwruwj8maC7VtwZwFPWnuvtLsnDKi3YXj/PYYgIDW6mSG/Fe8rg623ZpM7QJJUpV3R7PQ1yDUHvLYQ5C2QYGtkqr08hl1ij/qKaRbK9wcgyZpdoef67zmDR8fLNlqqHx4bt9LCqCJewp1v
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1268b04-86a5-4bc4-6c5c-08dd774dc4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 10:03:25.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmwIrvKY3NWx2rvfu7mKcsNpgoDrWRpyNJnDRz5oKB4cViGHsDgBu8n3VzlRNqv0DFGUpFm+Ta7p/Swce9sQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14032

DQoNCk9uIDA5LzA0LzIwMjUgMDk6NTUsIEFsaXNvbiBTY2hvZmllbGQgd3JvdGU6DQo+IE9uIE1v
biwgQXByIDA3LCAyMDI1IGF0IDA0OjAyOjE3UE0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+
PiBQZXIgQ1hMIFNwZWMgcjMuMSBUYWJsZSA5LTIxLCBib3RoIENYTDEuMSBhbmQgQ1hMMi4wIGhh
dmUgZGVmaW5lZCB0aGVpcg0KPj4gb3duIGxlbmd0aCwgdmVyaWZ5IGl0IHRvIGF2b2lkIGFuIGlu
dmFsaWQgQ0hCUy4NCj4gDQo+IENhbiB5b3UgY29tbWVudCBvbiByZW1vdmluZyB0aGUgY29tcGFy
aXNvbiB0byBDWExfUkNSQl9TSVpFLiBBdCBzb21lDQo+IHBvaW50IHNvbWVvbmUgdGhvdWdodCB0
aGF0IHdhcyB1c2VmdWwuIEFzIHlvdSByZW1vdmUgaXQsIHBsZWFzZQ0KPiBleHBsYWluLg0KDQpU
aGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQoNCk9rYXksIEkgd2lsbCB1cGRhdGUgaXQgaW4gdGhl
IGNvbW1pdCBsb2cgaW4gVjMNCg0KUmVtb3ZlIHRoZSByZWR1bmRhbnQgbWFjcm8gQ1hMX1JDUkJf
U0laRSwgYXMgaXQgaGFzIHRoZSBzYW1lIG1lYW5pbmcgYXMNCkFDUElfQ0VEVF9DSEJTX0xFTkdU
SF9DWEwxMSwgd2hpY2ggbmFtZSBpcyBtb3JlIGNvbXByZWhlbnNpYmxlLg0KDQpUaGFua3MNClpo
aWppYW4NCg0KPiANCj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiBWMjogZG9uJ3QgZmFjdG9yIG91dCwganVzdCB2
YWxpZGF0ZSAjIERhbg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvY3hsL2FjcGkuYyB8IDggKysrKy0t
LS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvYWNwaS5jIGIvZHJpdmVycy9jeGwvYWNw
aS5jDQo+PiBpbmRleCBjYjE0ODI5YmI5YmUuLjJlNjNlNTBiMmM0MCAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvY3hsL2FjcGkuYw0KPj4gKysrIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+PiBAQCAt
MTEsOCArMTEsNiBAQA0KPj4gICAjaW5jbHVkZSAiY3hscGNpLmgiDQo+PiAgICNpbmNsdWRlICJj
eGwuaCINCj4+ICAgDQo+PiAtI2RlZmluZSBDWExfUkNSQl9TSVpFCVNaXzhLDQo+PiAtDQo+PiAg
IHN0cnVjdCBjeGxfY3hpbXNfZGF0YSB7DQo+PiAgIAlpbnQgbnJfbWFwczsNCj4+ICAgCXU2NCB4
b3JtYXBzW10gX19jb3VudGVkX2J5KG5yX21hcHMpOw0KPj4gQEAgLTQ3OCw4ICs0NzYsMTAgQEAg
c3RhdGljIGludCBjeGxfZ2V0X2NoYnNfaXRlcih1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMg
KmhlYWRlciwgdm9pZCAqYXJnLA0KPj4gICANCj4+ICAgCWNoYnMgPSAoc3RydWN0IGFjcGlfY2Vk
dF9jaGJzICopIGhlYWRlcjsNCj4+ICAgDQo+PiAtCWlmIChjaGJzLT5jeGxfdmVyc2lvbiA9PSBB
Q1BJX0NFRFRfQ0hCU19WRVJTSU9OX0NYTDExICYmDQo+PiAtCSAgICBjaGJzLT5sZW5ndGggIT0g
Q1hMX1JDUkJfU0laRSkNCj4+ICsJaWYgKChjaGJzLT5jeGxfdmVyc2lvbiA9PSBBQ1BJX0NFRFRf
Q0hCU19WRVJTSU9OX0NYTDExICYmDQo+PiArCSAgICBjaGJzLT5sZW5ndGggIT0gQUNQSV9DRURU
X0NIQlNfTEVOR1RIX0NYTDExKSB8fA0KPj4gKwkgICAoY2hicy0+Y3hsX3ZlcnNpb24gPT0gQUNQ
SV9DRURUX0NIQlNfVkVSU0lPTl9DWEwyMCAmJg0KPj4gKwkgICAgY2hicy0+bGVuZ3RoICE9IEFD
UElfQ0VEVF9DSEJTX0xFTkdUSF9DWEwyMCkpDQo+PiAgIAkJcmV0dXJuIDA7DQo+PiAgIA0KPj4g
ICAJaWYgKCFjaGJzLT5iYXNlKQ0KPj4gLS0gDQo+PiAyLjQ3LjANCj4+
