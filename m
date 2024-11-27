Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535271114
	for <linux-cxl@vger.kernel.org>; Wed, 27 Nov 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679156; cv=fail; b=pFa4T8ImMM4/+/Pdx0JeYKjZeQF6yOGxDpbEP/KpF0gJAw0XXhf8EOoItAJoKEegTCQAfNTRIr+Zx01ZNscxKqO6R6aUl9fE/uefb8IvdyLxdr2dRStP7fMNs1cD1JbLawowwjAUQdMQj3MJRe5c2Ey+i477QHTBCtxm5KZ148o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679156; c=relaxed/simple;
	bh=Sm6QTvCbYxQWJvHcSZPkx1im7POeADjRSsxD+wII3KM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pWDOoBpLNoxstDKU/oHXVpW9+xC4HbfHolAgkh/lmu/AjYx11MBS/LsyFPeRCN1ouBNG47aq/sBqNkrO9ddArt0dd4K33a0kC43rupv7ItCc5fL0t/LXytqNqEGtJ0k+CB+wB2Y+LuGNKec9rDyZisZ8FY372gMhpO0SmHE2ioE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hcx5tiI2; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hcx5tiI2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1732679153; x=1764215153;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Sm6QTvCbYxQWJvHcSZPkx1im7POeADjRSsxD+wII3KM=;
  b=hcx5tiI2IVuxycYkcpxwtyNds7agW1uGglzw2ly707AIszwS1MyKU4M0
   T3O1LyO6V+OT8F8qrNsmBT9LQjCMpN00VEAkbPx7sfLhC6k17S78Yw0aX
   bB8ElC0WMTuYcFABYYe8RCv8xyo6ruFJ6dnz1/G4f3QWVK/S2A/beioBH
   J96UdT/9lJQ4lxB7Z9/2mvDZiLSIKClo4gjRb+bgtJCOb/YroGv7wg7IT
   b6lcUSpa2VWLe+ARtNGbLD3xDlCrcYhqrSjqfSga4D4lMdTTmjNxshf8A
   HAnSK8muH02PZYb1vTsZPnYz/QsMq1Vu6iSsgLC+VO8xakbGDlvhWDB8p
   A==;
X-CSE-ConnectionGUID: 0gZrVtXdRtORIBzmt7Y3vQ==
X-CSE-MsgGUID: RecUSh92SqO8hp2BPN0VDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="138393428"
X-IronPort-AV: E=Sophos;i="6.12,188,1728918000"; 
   d="scan'208";a="138393428"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 12:44:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/iF+Cl+nlU9urv0ijUW3L5fLPknGDNwD8Ytr0rTSP07/Dr1J1PmcwJ73FZLRCGMvmD9Gwo3X46jnW4bcyDvFIQHdCIrUsXGu4oyQiUc79z9uu1mimDKb2P2/BLBeqxGN9l48X2ZQ5JlPa3WG6qDiyBf4dUs5/rBiuhFP+NJX2OPRYQdjmSDMzpVXPH/c0UJarJuGqWHGlKNF5qjVNp6n+Qhuuv9sm46plflp3BVjHz++KkD8GBhmUrYpHtjsyX+MMRazR66twxOf80lypkf7UlVN+8GAGuDjGO7n1yrEfC1mIxrGPGQ9UA+4q+dB/o+GlHHXT+8rwdMNuLghG4LVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm6QTvCbYxQWJvHcSZPkx1im7POeADjRSsxD+wII3KM=;
 b=IDe58dGN0z3d8UF6pB/Aoy63pMcdufQcD3HLGrvi9pBu1RABAtFe8baRStuV+YOQeFNyjLTgAfcUjTCiVeHKHWgfYgPVSVfkIIBNG9NDGs41JZpzBGhNh6voyOU9BobSczNGFyjzjt+r2EAhfCELFQxPkWC5rdx5dQl5h4gi66Ssm96H53hWjczA086DxJwor5dEVR2I2yHupIoqiIgWrASYMMFwRUxqiN8ud/ZIS0Zhy0k4MbuwMhkyK2bULaObeEOo0eUHKtprLyVn1wRPxo1o7uccdXf13FyfZXvBiV9SBABa6A84lrqKuNlvy3VC6oX//Ub+fXKIG/QYCkqBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by OS0PR01MB5651.jpnprd01.prod.outlook.com (2603:1096:604:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 03:44:38 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 03:44:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Li Ming <ming4.li@outlook.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 1/1] cxl/pci: Fake bandwidth for platform devices
Thread-Topic: [RFC PATCH 1/1] cxl/pci: Fake bandwidth for platform devices
Thread-Index: AQHbPK8ksnvitsspx0insIkW8asFIbLKg/SA
Date: Wed, 27 Nov 2024 03:44:38 +0000
Message-ID: <2c96fbd5-4dd9-4abf-83ab-3938dcd8fd8e@fujitsu.com>
References: <20241122072001.94758-1-ming4.li@outlook.com>
 <VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|OS0PR01MB5651:EE_
x-ms-office365-filtering-correlation-id: 1211a887-2258-4bc8-f0da-08dd0e95d186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1BCbWw3Kys3bkRKSGV1dTBZUXJuUlF4eGFrVWEzNnhPa29JYkNQYy8yVklL?=
 =?utf-8?B?WkpxR0JtaHo1aDFWelltU3hVUEpjZm11WGF3UGxPV29sV3M3TnRkaVpSTzFp?=
 =?utf-8?B?RVFuM1VnaXZmWnN3bVdFTC9HQW8zK1JBa0R5MHJLY0Z6SzE2TVFXQXk0Sy9k?=
 =?utf-8?B?VGRPVjhJVjlNR2xDcUd1YUNDRXIya01INEhYZFJaUU11ZUxpTjBoL3dKMVVP?=
 =?utf-8?B?OXNsSkNRd3UwNzlTektLYzljNjJKMFNWekRzWmt2NFFMZlE0UEhpdytoUkdI?=
 =?utf-8?B?NVRocUd3V3phMEZDbmlFVTVMMm82YVhjMjRTMC8xUmVaZ1RReHNvbDFFMVdn?=
 =?utf-8?B?RFlsV0ducDJHbUtOcEZneXNZYThpSjg3b2VJc0ZVRS9RczFDSjBCaUN4bnRO?=
 =?utf-8?B?bDRpTXVLa3AxUVd0SVJKNVVmeVhXM2tReVZtb0ZOeTFVSWI1UHdpK21UNXJV?=
 =?utf-8?B?Q3psNTJYZjE0Zkc4ZjlpM2N2ZnJVV2t3dDdrVjRrSndJUWozYzVWOFhONDN2?=
 =?utf-8?B?NDZ6djhoWGl5N2J3UjZjL3pSU1BUclhJcmhOdHdjOVNEcVlqbFc0NEFwWmtN?=
 =?utf-8?B?Sk52a3Vsd1A2MlNaVjBjMnJ1TkUyeCtBdUpHbERkaE1YaUtsdFJJaEt5TklL?=
 =?utf-8?B?Q3ZqbVA5bk4wNm83aGVwdXVsKzRhRWw4R0RjbkhNYWhMUVE0Qmx2SVZzOEln?=
 =?utf-8?B?R3BLSzhWdlZreForK1hRSm5qejJWU2hYQmU1UC9YT2N6SWFnVG9YMm0xYkZH?=
 =?utf-8?B?a3J1aHlYTUVBUlNOUk1NR01uQ05xczlyNWEzdHl0Um5WVVNPY1Rvb0NpdXM4?=
 =?utf-8?B?bzhpN2sxZzBULzZ4b3NQTEh0UXJDbDFuTEd4cXB3T0s2THB2T202VFZQK0hH?=
 =?utf-8?B?Tm9QbDJMbHNxYlJnekZETlJVOXNpRGZsYUNmZDRhUjFQS1lkWTY5RldPUStx?=
 =?utf-8?B?QjJlU1dNRktQZ0RRV0VWQk9qUUMxR0xTUTV5ZnlwOGp0Unk1TTlWblJDdjJW?=
 =?utf-8?B?d3RLbHQrMDI1OFJkZ1gvKzVEVnZzaHhwVW9FUHdiQ3doQW05aTN6L09OUUl2?=
 =?utf-8?B?bzM3VzBJK2QrNFJXWld3WXc5K2ZoRjNFOER2Y3BwQktCd2FiNEVQRTdFZDZH?=
 =?utf-8?B?dmVmYjNLQ2xKejNjQmV4b1ZEanBzSlNRNEZCdXdQVms2UTRiMmNvalJyL252?=
 =?utf-8?B?ZVR2aEI5UUJCNG5tZFV3dHhtVlkvWE1CbXFFVXU0UjZNYVZhd3djMlBQODFB?=
 =?utf-8?B?eFd6TTV1Mk02SEpwekcvdmNlYVlMREZUaW5kTStDd0pBZmVCWjNoNGVwVEpN?=
 =?utf-8?B?dVdZSUcrRXI1YkRwMzU1blBJdzE0cFhISTQ3WS9xMkp1R0hDK1Q4dTQ4YTVX?=
 =?utf-8?B?ak1CSGdnKzZQbWtOZUxsRC9RRFRxWVphRTJhS09idHUrLzVNRG85S2NHVVJQ?=
 =?utf-8?B?RnlHT2hrZUJNby9kRWh0akFUTHBOV1lhWmt1Vng3WVQzWmY0OEJJRzFpM0NC?=
 =?utf-8?B?V1ltZU91WFBGUXMvT0hIZ1BPWW80SFdRVmQ4cEp6WDB3WHR3dFVWU3QreVNN?=
 =?utf-8?B?c3JIQXB2a3lWR01hNXlsRzIvbDZpQ3FnZHNUQTVqSVZrckRTU3hHVU1aV1B3?=
 =?utf-8?B?L1NGV0p4MVg1eEVmUVBFS3FEWVB5dTNzR1V5dGpoR3FRN05GLzF2TEVDckNM?=
 =?utf-8?B?QzRKSUp1eUhGRFFNY2pTVEdobUJ5UlA3TUdKL2p3OVZ5SExPZGpVTlA0WVJT?=
 =?utf-8?B?dHZkaWFhRUFhaHlzTWJIL3UwM3YxL21mRXdib0tLbW5xTWgxcEhRcHI1NTlw?=
 =?utf-8?B?L3NlV2pGQmdtVm43STBLelhGWmJ1MTNCZzREMGZmWHI2Y3R1d1dDZE82dWxM?=
 =?utf-8?B?ZDFvdEFreStCemlmUXlwTmM1bE1ZT3BLQ2ZaYWZTa013b0dkMmt2VVlKT2t1?=
 =?utf-8?Q?fh6pjHSygaI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGFhQ3BQYVZmS0Vmc2ZNeEdHYmE3a2hieEMwSE9raTFqVzE4ajZqMWpLcHRO?=
 =?utf-8?B?VlBEUTNFTm9iSVZTcmhua1NVa3lTMmdPbTZMZUFmTHM0WFZMRUk0S0VUQ3Yy?=
 =?utf-8?B?YmFsNCtOWmRKOVBXSTlaOTF4anJCK3E2dTE4elQxUExkWVRrVU5mSTVKRnRs?=
 =?utf-8?B?K3pqYU1Nck9MdFUyNEpWTkZVVzNON0RxUjJlT0VvajdjSHNXTFNYWHovMGxV?=
 =?utf-8?B?WDdRei8wZFBnQWd2NDNpT1V0SDR5ZUp6QTQvNEc1K3pLR0txVWZiZDNhNUhT?=
 =?utf-8?B?VW9MaDBFQ0N0cjd5ZnBlMEVjbTg1ZWJXSEQ1by9xR2NFMDN3RmNVanNydUtD?=
 =?utf-8?B?engyK0tNQnZZbUxsUHZTQzNyTEtIUlFIQkNPOStqNlRpRW9UNWg4WkRQdDFo?=
 =?utf-8?B?MnZnVWJMUzZlTGtPSTV3Z1ZSaWlGMmZiRjljQ2wyUlhvZEtOZUFWRENtUkl0?=
 =?utf-8?B?MWwvRGY1RlYvcVdYTTF1RUFxNmNKVXRCRmJ0NWx5NWVsU1RNWUpZWmJWajZo?=
 =?utf-8?B?akduRnRxU25qRyt0Uk9QaC8zYUFDSVgvSFkyV1NhdW5UNWQ3dkZHVytqQjl1?=
 =?utf-8?B?b3ZxUE5TR2U0REtLdFdla1d0QzlFQ1RXQ1YzY0g2M1ZJbTQ1aWsrb1BXNnFz?=
 =?utf-8?B?VWxHTTZZdFdYUnZwbCtDdjM0V0pRc2FiaHNoSkRYWUFjN05TMTJvODc3c1FD?=
 =?utf-8?B?YXFGVVdJSVpRZlZURm95S0FINlk1Z3h3bUIwbkVwYysrMG5kTlZIbm85ZVg5?=
 =?utf-8?B?NFRpTHpyTHNiREEydDEzdmVMQ290dEV4RGwrTDRzWXhGMU4zVTlwclozZUFa?=
 =?utf-8?B?L2tRVHp6dkplRy9BUkwzOFB3alFtY0hrZzhaTUFGNmJrUnlReVF4Y2NjcE1F?=
 =?utf-8?B?c0h6UkZvQ0Q4Q0JEWGQxbGF4eUsxdlA4VHFmdlRENGhWU2x1K3lwL3JEMzlE?=
 =?utf-8?B?RU5iT2ZhMDR0RzhVY0xzVHVuWUlKcUl3STBsL1NSeVJlQ2FBdEFXUnBFOXQr?=
 =?utf-8?B?T3N6TG1RMUZPaVkzb2RKSzN5ODRoUXZYT1UwZjZHeUZuS3Y5dzNWR3BRZk43?=
 =?utf-8?B?djlyMHhNMWJqOEIrNW9TbWF3RVJOVHFQdGJKZ3NBb0tBN3pTWDNpL09kMTY0?=
 =?utf-8?B?L3lOcll3MjFGa21OeGNBTFJtSHBKN0RBbG1TaGROdWY0SmZYSWlOT2RFdEtr?=
 =?utf-8?B?eEpUZTdGNDFsRnlYQzV5YTlWcXNrUmtNYlo0WWlrNE4xZHNpOE5KQTNmb2NS?=
 =?utf-8?B?UVNUSzlJK2hDaXdhSXIydzVKdlgvbG8ybkgrRDM0eldsYm1LNXppeFh3ZUt3?=
 =?utf-8?B?aFJuSWVtaDNOZnd6dXp4L2wzazNtOENrakZBOG04eDVMTkl6UXBrNDVIN2lP?=
 =?utf-8?B?QW5YRk0xbXpEVkxOdHdlK2pNOGdZNGFEVmUzMDBYSVZ3NjV3N2JET0xKR3dL?=
 =?utf-8?B?ZTB2a1NXRUtkRWJ3MzJ6cjErdDNSZkU4VTBISGkySmNDSmVNQVdGV1ZJWkFH?=
 =?utf-8?B?Q051LzRLcGhsZThkNGV6QmM4QTBud2VNZEJjNitGRS9VY3NQQ1F2Uk9OZmxm?=
 =?utf-8?B?bUZUYTB5UFFlVEJObjE1S0pUcnQwUE5NNG5nbEw2ancrclJSajViV0M4OHZH?=
 =?utf-8?B?Tk4xYzRWNmlKU0dxcENQRmJsWHJycGpaSUs1MU53U20rbVBmQ1BIQldWSTdW?=
 =?utf-8?B?M0RDOGhFenVtMmpGSU9KTm9aQjdONFU3ZGNwSkZDaWFuM0R2d3dvWTJIOHlS?=
 =?utf-8?B?SUVhbFpoZmIyUWZ0RWFoWVJVK0tsdWN1WUFUbkUvYVpyaXRYQzZiOGthV3FN?=
 =?utf-8?B?NDc5WFp2ejhKM3hLTXd3QzdTWUNOaHdnalVxTXk4bXp3cEVLSG5JNmY0QTlJ?=
 =?utf-8?B?QU9mZWtYdWI0ZXRnRDVCU0JiSXFUdkZrb0ZidWVTbnRrNS9JeEJCQXJnNzND?=
 =?utf-8?B?aDl2WFptUmNscVlrSWxJVjdKcTgrUVBRNm9sOXl5S1VMd2I2T0w4QXorc3pF?=
 =?utf-8?B?bDJhZ21OdlI1RlpESllLM0RkVnpQb3dKdUlWY1VVci9RbzBXVCtla201dlMz?=
 =?utf-8?B?M0xTUkg2SHBDYW1heUl6S3BzYlRMYnl5OSs0YmszMWNGNGtmME9JSkQva0U1?=
 =?utf-8?B?aFRiV2xOMkt6aFYrZXk5TjF3NmJEcVlLdTVMSHp0TjdsbERYTUl5ZVk2VUJ4?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC70BBE93BDE14CA202DD93AEFF787D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	18tDmJS8uqEUDqoqmN/yzWgIfO7SVgVRayHjIDCflm3eCu12XZy++eZjBjkgi9PKww9P3PLswDUavO2dHyNMv+PdIckePOk2nN/O4+o4M8iJnLu/Oqp9+Axzu87Lo+6/ZpxfG6w+s1n8WbtBIjpLtcsVopBRlGr8Lbf3HSE6hbxPY1f12aA5kuBSBXyAXGu/njJa6vsfDwevYk4bX0Ml0PwGrDDBnbIMMPEldQ9Y9lFvZpRBUbsv6VNnXtX1LMMGC5+/aSr7CitI8V0ioXQKjJBEorBZE3hBliMW8vc/1juWRoK/+Yh0+Fj6jQbFGe51HKIF1Dd6xmEXfVXCX5qzJVDnGXrwTS+rUrP0/ptEYn1+vtJ6yml/MOKl1tkBnB11BsM5htnKM1wbOhfkcDlzuTn0sDlzEQSx25CIblaN1PP79g21pQBATTf4vovt4ZSWCGaS10vHUN71O1nuDA7/HsCTJtc43aL3WxHWfZH59ffpciGj/9krebZa06TnzvAkuBB+wM5CNWyZ3OjZM+jaiiXylN71LD5kujHTEd54VJkRpUl1MI7ELuTB7p1sL2zv9IStoT5BNQWyfNgK7U7lGFkkhK5rxMaPSmRIQFuGQt8sMrZd03vpPyOfXKc6tIMy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1211a887-2258-4bc8-f0da-08dd0e95d186
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 03:44:38.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCCrnHJSCMdTMKvuDlBXrSc3shXylhrfUj8kHFI2M6mFR600lerHYycqBV18F+JSn53mH/sVrZrSvTFxVyi3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5651

DQoNCk9uIDIyLzExLzIwMjQgMTU6MjAsIExpIE1pbmcgd3JvdGU6DQo+IGN4bC10ZXN0IGVudmly
b25tZW50IGFsd2F5cyBoaXRzIGJlbG93IGNhbGwgdHJhY2Ugd2l0aCBLQVNBTg0KPiBlbmFibGVk
DQo+IA0KPiAgIEJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBwY2llX2NhcGFiaWxp
dHlfcmVhZF93b3JkKzB4MWRmLzB4MjIwDQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgPFRBU0s+DQo+
ICAgIGR1bXBfc3RhY2tfbHZsKzB4ODIvMHhkMA0KPiAgICBwcmludF9yZXBvcnQrMHhjYi8weDVk
MA0KPiAgICBrYXNhbl9yZXBvcnQrMHhiZC8weGYwDQo+ICAgIHBjaWVfY2FwYWJpbGl0eV9yZWFk
X3dvcmQrMHgxZGYvMHgyMjANCj4gICAgcGNpZV9saW5rX3NwZWVkX21icHMrMHg2YS8weDEzMA0K
PiAgICBjeGxfcGNpX2dldF9iYW5kd2lkdGgrMHg2OC8weDFjMCBbY3hsX2NvcmVdDQo+ICAgIGN4
bF9lbmRwb2ludF9nYXRoZXJfYmFuZHdpZHRoLmNvbnN0cHJvcC4wKzB4MzUyLzB4NzgwIFtjeGxf
Y29yZV0NCj4gICAgY3hsX3JlZ2lvbl9zaGFyZWRfdXBzdHJlYW1fYmFuZHdpZHRoX3VwZGF0ZSsw
eDI1Ny8weDE2NDAgW2N4bF9jb3JlXQ0KPiAgICBjeGxfcmVnaW9uX2F0dGFjaCsweDEwMjUvMHgx
ZTgwIFtjeGxfY29yZV0NCj4gICAgY3hsX2FkZF90b19yZWdpb24rMHgxMjEvMHgxNGMwIFtjeGxf
Y29yZV0NCj4gICAgZGlzY292ZXJfcmVnaW9uKzB4YTUvMHgxNTAgW2N4bF9wb3J0XQ0KDQpJcyB0
aGlzIHRlc3Rpbmcgb24gdGhlIHVwc3RyZWFtIGtlcm5lbD8NCkkgZ3Vlc3NlZCB0aGlzIGhhdmUg
YmVlbiBmaXhlZCBieQ0KY2NlM2NkNjQ3NzIxIGN4bC9jb3JlOiBSZXR1cm4gZXJyb3Igd2hlbiBj
eGxfZW5kcG9pbnRfZ2F0aGVyX2JhbmR3aWR0aCgpIGhhbmRsZXMgYSBub24tUENJIGRldmljZQ0K
DQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiBjeGwtdGVzdCBlbnZpcm9ubWVudCBjcmVhdGVz
IGN4bCBtZW1vcnkgZGV2aWNlcyBiYXNlZCBvbiBwbGF0Zm9ybSBkZXZpY2VzDQo+IHJhdGhlciB0
aGFuIFBDSSBkZXZpY2VzIGZvciB0ZXN0aW5nLiBidXQgY3hsX2VuZHBvaW50X2dhdGhlcl9iYW5k
d2lkdGgoKQ0KPiBhbHdheXMgYXNzdW1lcyB0aGUgZGV2aWNlIGlzIGEgUENJIGRldmljZSwgaXQg
d2lsbCBjYXVzZSB0aGUgaXNzdWUgaW4NCj4gY3hsX3BjaV9nZXRfYmFuZHdpZHRoKCkuDQo+IA0K
PiBUaGUgZml4dXAgaXMgdGhhdCBmYWtpbmcgYSBtYXhpbXVuIGJhbmR3aWR0aCBpbiBjeGxfcGNp
X2dldF9iYW5kd2lkdGgoKQ0KPiBmb3IgYSBwbGF0Zm9ybSBkZXZpY2Ugc28gdGhhdCB0aGUgY3hs
LXRlc3QgZW52aXJvbm1lbnQgY2FuIGJlIHVzZWQgdG8NCj4gdmFsaWRhdGUgdGhlIGZ1bmN0aW9u
YWxpdHkgb2YgcmVnaW9uIGJhbmR3aWR0aC4NCj4gDQo+IEZpeGVzOiBhNWFiMGRlMGViYWEgKCJj
eGw6IENhbGN1bGF0ZSByZWdpb24gYmFuZHdpZHRoIG9mIHRhcmdldHMgd2l0aCBzaGFyZWQgdXBz
dHJlYW0gbGluayIpDQo+IFNpZ25lZC1vZmYtYnk6IExpIE1pbmcgPG1pbmc0LmxpQG91dGxvb2su
Y29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2N4bC9jb3JlL2NkYXQuYyB8ICA1ICsrLS0tDQo+ICAg
ZHJpdmVycy9jeGwvY29yZS9jb3JlLmggfCAgMiArLQ0KPiAgIGRyaXZlcnMvY3hsL2NvcmUvcGNp
LmMgIHwgMjQgKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2N4bC9jb3JlL2NkYXQuYyBiL2RyaXZlcnMvY3hsL2NvcmUvY2RhdC5jDQo+IGluZGV4IDQz
ODg2OWRmMjQxYS4uYzY3ZWYwZDFiMWE2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3Jl
L2NkYXQuYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL2NkYXQuYw0KPiBAQCAtNjM0LDcgKzYz
NCw2IEBAIHN0YXRpYyBpbnQgY3hsX2VuZHBvaW50X2dhdGhlcl9iYW5kd2lkdGgoc3RydWN0IGN4
bF9yZWdpb24gKmN4bHIsDQo+ICAgCXN0cnVjdCBhY2Nlc3NfY29vcmRpbmF0ZSBlcF9jb29yZFtB
Q0NFU1NfQ09PUkRJTkFURV9NQVhdOw0KPiAgIAlzdHJ1Y3QgY3hsX21lbWRldiAqY3hsbWQgPSBj
eGxlZF90b19tZW1kZXYoY3hsZWQpOw0KPiAgIAlzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMg
PSBjeGxtZC0+Y3hsZHM7DQo+IC0Jc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGN4
bGRzLT5kZXYpOw0KPiAgIAlzdHJ1Y3QgY3hsX3BlcmZfY3R4ICpwZXJmX2N0eDsNCj4gICAJc3Ry
dWN0IGN4bF9kcGFfcGVyZiAqcGVyZjsNCj4gICAJdW5zaWduZWQgbG9uZyBpbmRleDsNCj4gQEAg
LTY3NSw3ICs2NzQsNyBAQCBzdGF0aWMgaW50IGN4bF9lbmRwb2ludF9nYXRoZXJfYmFuZHdpZHRo
KHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyLA0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIERpcmVjdCB1
cHN0cmVhbSBsaW5rIGZyb20gRVAgYmFuZHdpZHRoICovDQo+IC0JcmMgPSBjeGxfcGNpX2dldF9i
YW5kd2lkdGgocGRldiwgcGNpX2Nvb3JkKTsNCj4gKwlyYyA9IGN4bF9wY2lfZ2V0X2JhbmR3aWR0
aChjeGxkcy0+ZGV2LCBwY2lfY29vcmQpOw0KPiAgIAlpZiAocmMgPCAwKQ0KPiAgIAkJcmV0dXJu
IHJjOw0KPiAgIA0KPiBAQCAtODA5LDcgKzgwOCw3IEBAIHN0YXRpYyBzdHJ1Y3QgeGFycmF5ICpj
eGxfc3dpdGNoX2dhdGhlcl9iYW5kd2lkdGgoc3RydWN0IGN4bF9yZWdpb24gKmN4bHIsDQo+ICAg
CQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICAgDQo+ICAgCQkvKiBSZXRyaWV2ZSB0aGUg
dXBzdHJlYW0gbGluayBiYW5kd2lkdGggKi8NCj4gLQkJcmMgPSBjeGxfcGNpX2dldF9iYW5kd2lk
dGgodG9fcGNpX2RldihkZXYpLCBjb29yZHMpOw0KPiArCQlyYyA9IGN4bF9wY2lfZ2V0X2JhbmR3
aWR0aChkZXYsIGNvb3Jkcyk7DQo+ICAgCQlpZiAocmMpDQo+ICAgCQkJcmV0dXJuIEVSUl9QVFIo
LUVOWElPKTsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvY29yZS5oIGIv
ZHJpdmVycy9jeGwvY29yZS9jb3JlLmgNCj4gaW5kZXggODAwNDY2Zjk2YTY4Li4xYzE2YzA2ZDIw
MWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2NvcmUvY29yZS5oDQo+ICsrKyBiL2RyaXZl
cnMvY3hsL2NvcmUvY29yZS5oDQo+IEBAIC0xMDgsNyArMTA4LDcgQEAgZW51bSBjeGxfcG9pc29u
X3RyYWNlX3R5cGUgew0KPiAgIH07DQo+ICAgDQo+ICAgbG9uZyBjeGxfcGNpX2dldF9sYXRlbmN5
KHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsNCj4gLWludCBjeGxfcGNpX2dldF9iYW5kd2lkdGgoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsIHN0cnVjdCBhY2Nlc3NfY29vcmRpbmF0ZSAqYyk7DQo+ICtpbnQg
Y3hsX3BjaV9nZXRfYmFuZHdpZHRoKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGFjY2Vzc19j
b29yZGluYXRlICpjKTsNCj4gICBpbnQgY3hsX3VwZGF0ZV9obWF0X2FjY2Vzc19jb29yZGluYXRl
cyhpbnQgbmlkLCBzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwNCj4gICAJCQkJICAgICAgIGVudW0g
YWNjZXNzX2Nvb3JkaW5hdGVfY2xhc3MgYWNjZXNzKTsNCj4gICBib29sIGN4bF9uZWVkX25vZGVf
cGVyZl9hdHRyc191cGRhdGUoaW50IG5pZCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9j
b3JlL3BjaS5jIGIvZHJpdmVycy9jeGwvY29yZS9wY2kuYw0KPiBpbmRleCA1YjQ2YmM0NmFhYTku
LmJkMDQ0OGMzYzlhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9wY2kuYw0KPiAr
KysgYi9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jDQo+IEBAIC03LDYgKzcsNyBAQA0KPiAgICNpbmNs
dWRlIDxsaW51eC9wY2kuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvcGNpLWRvZS5oPg0KPiAgICNp
bmNsdWRlIDxsaW51eC9hZXIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4NCj4gICAjaW5jbHVkZSA8Y3hscGNpLmg+DQo+ICAgI2luY2x1ZGUgPGN4bG1lbS5oPg0KPiAg
ICNpbmNsdWRlIDxjeGwuaD4NCj4gQEAgLTEwMzIsMTkgKzEwMzMsMjggQEAgYm9vbCBjeGxfZW5k
cG9pbnRfZGVjb2Rlcl9yZXNldF9kZXRlY3RlZChzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQpDQo+ICAg
fQ0KPiAgIEVYUE9SVF9TWU1CT0xfTlNfR1BMKGN4bF9lbmRwb2ludF9kZWNvZGVyX3Jlc2V0X2Rl
dGVjdGVkLCBDWEwpOw0KPiAgIA0KPiAtaW50IGN4bF9wY2lfZ2V0X2JhbmR3aWR0aChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgc3RydWN0IGFjY2Vzc19jb29yZGluYXRlICpjKQ0KPiAraW50IGN4bF9w
Y2lfZ2V0X2JhbmR3aWR0aChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBhY2Nlc3NfY29vcmRp
bmF0ZSAqYykNCj4gICB7DQo+ICAgCWludCBzcGVlZCwgYnc7DQo+ICAgCXUxNiBsbmtzdGE7DQo+
ICAgCXUzMiB3aWR0aDsNCj4gICANCj4gLQlzcGVlZCA9IHBjaWVfbGlua19zcGVlZF9tYnBzKHBk
ZXYpOw0KPiAtCWlmIChzcGVlZCA8IDApDQo+IC0JCXJldHVybiBzcGVlZDsNCj4gLQlzcGVlZCAv
PSBCSVRTX1BFUl9CWVRFOw0KPiArCWlmIChkZXZfaXNfcGxhdGZvcm0oZGV2KSkgew0KPiArCQkv
KiBQQ0lFX1NQRUVEXzY0XzBHVCBhcyBmYWtlIHNwZWVkIGZvciBwbGF0Zm9ybSBkZXZpY2UgKi8N
Cj4gKwkJc3BlZWQgPSA2NDAwMCAvIEJJVFNfUEVSX0JZVEU7DQo+ICsJCS8qIFBDSV9FWFBfTE5L
U1RBX05MV19YOCBhcyBmYWtlIHdpZHRoIGZvciBwbGF0Zm9ybSBkZXZpY2UgKi8NCj4gKwkJd2lk
dGggPSBGSUVMRF9HRVQoUENJX0VYUF9MTktTVEFfTkxXLCBQQ0lfRVhQX0xOS1NUQV9OTFdfWDgp
Ow0KPiArCX0gZWxzZSB7DQo+ICsJCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2Rldihk
ZXYpOw0KPiArDQo+ICsJCXNwZWVkID0gcGNpZV9saW5rX3NwZWVkX21icHMocGRldik7DQo+ICsJ
CWlmIChzcGVlZCA8IDApDQo+ICsJCQlyZXR1cm4gc3BlZWQ7DQo+ICsJCXNwZWVkIC89IEJJVFNf
UEVSX0JZVEU7DQo+ICAgDQo+IC0JcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChwZGV2LCBQQ0lf
RVhQX0xOS1NUQSwgJmxua3N0YSk7DQo+IC0Jd2lkdGggPSBGSUVMRF9HRVQoUENJX0VYUF9MTktT
VEFfTkxXLCBsbmtzdGEpOw0KPiArCQlwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKHBkZXYsIFBD
SV9FWFBfTE5LU1RBLCAmbG5rc3RhKTsNCj4gKwkJd2lkdGggPSBGSUVMRF9HRVQoUENJX0VYUF9M
TktTVEFfTkxXLCBsbmtzdGEpOw0KPiArCX0NCj4gICAJYncgPSBzcGVlZCAqIHdpZHRoOw0KPiAg
IA0KPiAgIAlmb3IgKGludCBpID0gMDsgaSA8IEFDQ0VTU19DT09SRElOQVRFX01BWDsgaSsrKSB7
