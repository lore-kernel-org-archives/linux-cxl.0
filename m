Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95C387568
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118194; cv=fail; b=mxNqGYRbl6IL94K+O+QWkFXuBJK7WDU7/Y9KwiAveCOnx6Tg5iwCRy87kO3JGaxWHXjrCWlUP6A3ps51RRSEvvonWQQs2BklCAEClkGPCHTTKExJBqI4HGnFAOuyyk10zzj0pn7OzDvYoTYCwVtryk+J26E7StU437kvWnyR9Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118194; c=relaxed/simple;
	bh=NMsUS7X4QWiGSrTbdbM6tIf7F+lYVZ9O4vFfDP9NXLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xvzfq85C2Q0F/OvCAd96BY1QxgkRVJXrZgY6tV5TV6bLxcatdBGtnzeJdusv7JjtEgzbBj7G62HFsfmj2sjQ7RmzRjM7z8ll+mbONCrMCy6z5xkXGKnApjBiF6wASpAFi8pO9pAq7iobTsNfqnW32d58gvOC298UozmH5FcanPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vw2WgdmH; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vw2WgdmH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjYEE0kgHeSWARGxKxb0Lb1ME7VFFxdgPTPHEKnkz/KimjvbEsBI20ql/jfPn32I5b6wuFcKeLGAAw2+6BTiLDnNgoiYMdFL1E/g3AMvglZ6f7Opz++SdCDqTcF8PySA9QjmZHLEfNE/7LlRSnWP5HAZUDZQf+nuUid2OPdpB6+HK+1l7C7AMbSB1TsjwdR5WQf5A6i1IlPtQBwMMEYCejFf5mHUk63Ev83Ujkp4hSeVO9qevZSR2I2qayCjNcJIOrb+jJIC/dJ5tAMP0rkEw3zXp1qdmhwgRAomFBX2BlNfSbHqgJeM14NgSK2ml5ikiONeQBjSJH+D/V8NOB/HkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LI57eo46UjN0bCOn3CCPrpnZIt/NsKs/cevlSlc3Uc=;
 b=TAhY7c51ijtimuHRL6rCG8PfKbdiuPAiZE4Jsu9p1c/6Z31nUk+wdOMkRdxCymovwuz6HhZEFpHH5/zq6RNQY03VSNv9eXtSptBtgBIor5E8r0ghujVITnjLSM7P60EB4w0NC0qZLknsrtX4ziaUR5vTG3DgZ6MfxOpDubdlMfd/t7Dbd/5mXYLzD0bn//yER7+5XstTPuWluwx5KOdoRGyNlRU9nGKWys8tHWdAgr4k+dlclnEPbzgV55zcKOwgGwTsPJkD3NW7UbM4xk6Uet8Hd5vvVnO9oEFSNpf4D59hTR2s0NyZuezAU9hIRQKjyfACYym1PUYwGrD96Dy6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LI57eo46UjN0bCOn3CCPrpnZIt/NsKs/cevlSlc3Uc=;
 b=Vw2WgdmHP+2xqlzeV8I7ajGsdgenc8T52r7dsXSUVvIMfjaCPqlce2+jJ3vAf4+m5y6q0mMLhgHRGkTrcYRRNdId/ANBcEIiIc/GJ1/GvUB3+zTLqoavmPaH3a3A4VulA2wpwbPu38vwpC2ZpgIhoP6PNqzGs2SH2VoE7v9aDrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 21:43:01 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 21:43:01 +0000
Message-ID: <484a90f5-6726-4251-a5fa-8ac2c9ed9305@amd.com>
Date: Thu, 22 Jan 2026 15:42:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] cxl/port: Unify RAS setup across port types
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260122033330.1622168-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::29) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1826cf-7c33-4b85-776d-08de59ff373f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NaNEtObHdoWjYyZk1xbFZUQ3ZCbEM0SVpCejdpVGlySnIzUktsaFp5Mmtj?=
 =?utf-8?B?N3pxZFBEOW0xRFNBRjlVUndPMjBvL1pOR3g0NnAxeFU2dHRFcmpaSDA3NTV6?=
 =?utf-8?B?U3dUOUJ3ZEU1UTlYV09qNU5EcUsxWnpOUmxwWUZ4bzlMaTRFaHQyRFBWcFFK?=
 =?utf-8?B?UWNOT0U3Rlo2dW42cjBPQkJnTXZFaGtRdklwRUxYb0kyYmtuTmppUVBIazJV?=
 =?utf-8?B?VmFtRUxDcmJoS0tpd1YwY2Vwckp4RTBsNzBQVnFkd1ovbzd0V3hlbHJvcHlW?=
 =?utf-8?B?ME14NHF2TVhpSUQrU1U3K1Y0bnBaK1phcEhobVlKY09mVEJ0Z0ZOU0F4TEQ5?=
 =?utf-8?B?NVMzNnlweHNGUU9wVXdwMXVHbEdrcy91K2N5QkVLVlNQWUUrdktvUUFJRVA4?=
 =?utf-8?B?UFYvL000T0dZQUVoMXlybUJHODFLNTBxTlB4Wm5kSnRFSkxLRWtXSVhoaVRp?=
 =?utf-8?B?YlExRUQ1dXloNkpzUVhRWUNHanV1dkRkdWIwWXJmM3NkVTBpQ2cwakFCaVRy?=
 =?utf-8?B?QkZoVXJOYXlvZi9jMC92UWdZZGNVdERXd2MvU2pwQlQzQkVRR2c4SDdTWDFB?=
 =?utf-8?B?dWE3dEgvUm02TVNyMTdpZnB3MzBFc3d2c3M2K1lvNVZKdjk1T2tBWGdnYlY0?=
 =?utf-8?B?Q0ZKd1ZUVS9LNnI3cHVKWDFzNXR1YURHZnpLeTd0YTAxaEM1L0hwQ2ZSelR1?=
 =?utf-8?B?QW5yWldaQTk3S3JRMWNLNENNb0dGU1Z4UmNDejR5WEx4R0lYT202MFRYU0xq?=
 =?utf-8?B?M1ZjMVFhdGp0MXVYOHRURnVudWEyb3hOcDJMdVJwUG9lK1UrV0pnRDBvNWNI?=
 =?utf-8?B?Vit3dlUvSzMzbUxOQ1EzNEw5MDU5MVg2Y3lTcjNKM21SaVJPQlozdzVUdXIw?=
 =?utf-8?B?UVljdWZlRnVVUzBKcDE4UGVFelNUYW44TGlFRzNUUjJLM3B0NUhieFNNNzBq?=
 =?utf-8?B?d1d1WEhXOXdRTmVIdStXWjBYSVJWT1JWNEVkNENSelNoMkdxUXNGLzI1RTRP?=
 =?utf-8?B?UjhOOEVzOE51MDVja29tb2hNUU9NdnlGcGp5SDRYTCtqbzRnS0tJTUx1UG1v?=
 =?utf-8?B?Rzlhd3ROQkpySVU5eFpsSzZqN0Y0eGlRUmdIY0c4ZERHTHMzWmZSVVI1Z2FH?=
 =?utf-8?B?aG5HeVJPOVdpRjBkcmViQ0kvcTJiREI0VnBpY0xRY1dnN3hjQ1B4clQ2bWNp?=
 =?utf-8?B?RmZVNllEWC90aVZBWXVta0s4NHIrbVlGM1RNNGNlUzBxMzhpNUJXOWpFWGJ1?=
 =?utf-8?B?S08zSlYwaVBXRzR3djBSQzVodGRKY2V6NGprSVFnSUZQYkloQUVyZld2Z3lm?=
 =?utf-8?B?MisrZXBFZHQrM2p4N3g1YzFkUHpsYW1CNEl1cnRYMytiaXAwWjAzTksyVmxy?=
 =?utf-8?B?VnRaZDBVVVhvUFVvLy9MYXRuVHRDRlF6WEphZkYxMUdUdTI0NGhheExhUGp5?=
 =?utf-8?B?L052VzFobjRhendITVpXb0h6U3o4V0k2Z2V6Zk1zUnlPSjJaS0toamo1V0E4?=
 =?utf-8?B?TFBYZTdxbTIyT0dDQUNKN094dXl3NUZaVXAzdFhtZzRuVThPVHZSV3pMeWNX?=
 =?utf-8?B?bGdzL053N0ovRVdueFByS3hZVW5kRGhrcFZJaXpQR3c4cE90QWR6S0VmV2p3?=
 =?utf-8?B?VU55SWtxeHN3RkpQcnVhZ2xBdUxnYmVIQVRrdlhYQldvUUxZWWlzV0U2cy9q?=
 =?utf-8?B?YXQ5Z1EzQUxHVjlxdFZUbVFJcGV3SkhtT3l6ZE82R2lXWTJTSDl2WmV3Y1dh?=
 =?utf-8?B?ekdKM1NvTUlqQ1gxSXYrMVJkdWY2a0xlSUJIaDc1ZjlPTHlYRFpvOGthcGkv?=
 =?utf-8?B?WWFkVytSSTUzU0hzT2xxNHBETVgybjJiTzRkd1YxY0o4NURKYlVCWXl6MzFQ?=
 =?utf-8?B?Z1VtS1liYWRWY2tjL3JnR2ZLemMzb3ZxSTlCNk1WQ1c0cVJqTld3bVU0d0NC?=
 =?utf-8?B?d3l0bmg2ZDVhS2liNkR2MERqYXUzRzVsejFlUnpuUTJYSXg1cTFUZ2ZkWlph?=
 =?utf-8?B?WUQwYk9FRW9yOHNTRk55WDFuWEVHaElhZURienRjMi8vd1ZGOGhJbUVrRWpW?=
 =?utf-8?B?Q0dQQlJ1cVh1SGdlRmpvYS9LZmVHMTNyNlpaUjIvTWZ6RmJvTjM4U0tTRDBi?=
 =?utf-8?Q?H13+xBH420oNKlQG1++8L50dt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDFiWlo1MDdSOHI0Q3N3dnFOcW55VlhRVzlDazgyYmFkWklqNTY5c1FXQ0cx?=
 =?utf-8?B?WC8yb0c2KzhEZks0eHNVM25lajBiMExyVUxyUHZRZ0RpQ1hjVnFydjRCemx5?=
 =?utf-8?B?T1ZQL0VySGNxT05ZNDhDRWlZbjAvYnlsRCtNK0tyRHFYYmdXcXdTSGJvRUNy?=
 =?utf-8?B?UDVnSkJWaXpiKzNPLzJUVEV2QjBvcTlhY0s2cmw3eXZNVm5ENzB1bE9WTUtm?=
 =?utf-8?B?ZngrU3lrZDBwRkhXMlJsOUFnNHFsNXN2RHFtanRPZzVoTms5ZmUxRVRsclZC?=
 =?utf-8?B?aXVsQVZGWEYxNW9ndDJsN0VaekdBeHpvMTk4V25icHJIL0dhTUNxY1dockps?=
 =?utf-8?B?T3FNSUNTaUVVSnBvY1A3R091OGcralFydVlacks1YzFBa1BkQ0dmbGU4VTZr?=
 =?utf-8?B?UmV4akEvYlBiRFIyVmlXRFZsQ1MyTmVBYUFZUHU2Sjh5MExlUHFWd2p4V2dN?=
 =?utf-8?B?M1YvWUxyOHF0Sm5LcDRzaStUSnRMcVJaTzRLMS9MakdEMVYrUUdYVmtKeTJE?=
 =?utf-8?B?bjJLT1NWYWp6cTBZSW9zZTVtaW1vNUFXTFMycHB5NnpRZUU3SThhSXlPZk5U?=
 =?utf-8?B?MFlIcjJ3ZTVxMEFuVnBCcm1XWXVvakkyUUp3cFZrR0pEaldlSGk2SzZybE5S?=
 =?utf-8?B?MFVBYXg5MUNhV2tSL2pXMUdhbUJJM1pmUWlVcFVOTFhDMVlRWW8rSldEVmR3?=
 =?utf-8?B?elkwbnMwMEZyNHIwaFVmVUJZQkhsMEF6akZjMGFZdmdFSmx1Y2RwVE9nbFoz?=
 =?utf-8?B?eFhSaFhWVlI2SUJUWnBBd2hGRlVHSXlDbzFTcFZwMDhMang4eHBZaTN3czRY?=
 =?utf-8?B?QUVEVXJJZERIeExDWEtSdk43RVZFRjNFZ0tzVTRQeXR5clU4WXdUTFBVK1l1?=
 =?utf-8?B?Z2NEekY0YmRVbTgxcGk2QnpjSzVSWVRKNmxnc1NSd2dmbi83c1d6RmlrMFl2?=
 =?utf-8?B?NTVPc2Y1VFVuYnE2bkpsVU5YRnZHZ0hDZEt2Q0FnNjg1MVFRR0xncTUrYVJi?=
 =?utf-8?B?c25aSW5TOEhNV1lhbitIK3E1Z1ZFby9pcU5ReWlFaTJvSG95cTJHbUNLZ2cw?=
 =?utf-8?B?QU12T1BwcCtIOVNtTmNGRlorc2VtZmFYdll0TFRjS3RybW10QVlWNnpIMHdz?=
 =?utf-8?B?YklibjNOOWNMK1pXK2huWk43VC9QdkpLamZZSXZzYThhM043U0E3bFdmZzdo?=
 =?utf-8?B?RVQwaGhPcTNBVmRHc1hXVE1uRC9qbFk3R0Z5OXlzckpGLzNDT3FSWnNjeXZk?=
 =?utf-8?B?TFpWYXloNy8wYnlUZXEzNDBQcjIyRkN3eVR2RzQ0K01CVDA0WmVqb2ZqeXBO?=
 =?utf-8?B?Z3J0Y0xTVDFnK25DUjU5RnY3NzcvblpHYXQ4Z2FXRXJRRzNMUjJGb1VMQ1cr?=
 =?utf-8?B?RmhkUU51Nnp1S293K2owa2ZLV3VFOU5SakR2YkxVcnp0NWg4cWR5aFFsa2h6?=
 =?utf-8?B?K0p6Zk1TRklqOFZQV05FeGRvcVlVT3JCMUt6bktPZGE3VlFOSyt1VVErQTBQ?=
 =?utf-8?B?ZmlJMlIzVG9MbUFDVXg5ZU0xM1RXK0Q4WGtmTG9ESll3eWo4MktaTno2RVNu?=
 =?utf-8?B?cld6ZTZUTFpYcjU5RWg3amxucFc0WEtkc3R1VDRiTzNMcTYvQnZtaXVQbytr?=
 =?utf-8?B?WkYvbXNTMGUvLzV0Ukk5TXZVcFBXR3EyOUh6V0lqNmVPZnA3QXFHbU5DMW9S?=
 =?utf-8?B?NU5IaHQwOWRPVFV2K2JHR3Fzb1J2ZE0rMlc3TmEvRE03eUNtSmt1MEdrd0NQ?=
 =?utf-8?B?U0huWlRLdUsvcGUyYUZ5QktieDdseklzZVRaWVA2b0NHeUltZHQwREgwL1Jy?=
 =?utf-8?B?b1JRS2FpMi9QR3hBUVIrYjUvSlg3RFkyNkorWFZZUzNScGZSM0o0Mml1VDc1?=
 =?utf-8?B?b3MxUmFwNUM1cDRERVVxSEVpaHVCQlM4UjRCRWxheldmTVJCU243VmQwMXFh?=
 =?utf-8?B?TC83bUoyeXN2WUxwUk1YYUd6ZHhoMEdlTjkwWi9jQWRxYUwrVlM1aWtvT3RE?=
 =?utf-8?B?ZXBac3RITFJPMFlMbWVEUm11dDdzRmRaL0p3VVZXUkxPWUlmN1hrSWVmWjJT?=
 =?utf-8?B?dnlGVHN2U3JHZnlnbXV5d1lUYlhvYmJBa1BGM1l6U0hzbFdkd1ovTDFpSm04?=
 =?utf-8?B?VjdKRFNHNU9ESXV2dWo2ODVoY1p1ZjVIRHJFeTZXcktyTnpILzdqb1EzM1My?=
 =?utf-8?B?MDE2eXc0cVVRUzBkYkdRV3hINU93cHR1aUpnYmFnME4vZTJYQ21JaEtLOStr?=
 =?utf-8?B?VVBoOGFmRld5bklHakVkY2dVSW5ydGR6QmZObVRsbXdwejdWM2pTOWlHMVJW?=
 =?utf-8?B?UlRMdUlRUjlqZnlwWjdoakYwN3RYSU9XYWJYU2pGbFhlZWJwQzNhUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1826cf-7c33-4b85-776d-08de59ff373f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:43:01.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOj8hRGIRbjtF78T1+RD2tTEebL/qZufVc+CGCQbI7MSyRmDzqR4tSOTmqxahApazKKS8aUydrIuApQl6VOezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

On 1/21/2026 9:33 PM, Dan Williams wrote:
> The CXL Port Protocol error handling series grew to be over 30 patches
> which is too much to handle at once given the various topics involved.
> One of the sub-threads of the v14 review was confusion about the new
> devres groups to manage port setup unwind failures [1].
> 
> [1]: http://lore.kernel.org/20260115144605.00000666@huawei.com
> 
> Given that review indicated a need to break up and better explain the
> conversion, do that in a separate patch set. Build on top of the first
> 18 patches of that series [2] that are ready to merge (save one missing
> ack from Bjorn).
> 
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.0/cxl-aer-prep
> 
> The wider goals of the port protocol handling series are:
> 
> 1/ Be minimally invasive to the ongoing maintenance burden of PCIe error
>    handling. Just do the minimal enlightenment to forward "internal"
>    errors for device with active CXL links to the CXL core.
> 
> 2/ Build a framework for any driver that registers a 'struct cxl_memdev'
>    (or in the future a 'struct cxl_cachedev') gets protocol error
>    handling support.
> 
> This "Unify RAS setup across port types" set supports goal 2/. It
> enables a model where all CXL error handling is relative to the common
> 'struct cxl_port' and 'struct cxl_dport' objects and is agnostic to
> whether those objects are in support of the memory expansion class
> device (driven by cxl_pci) or any other CXL endpoint in the system that
> supports CXL.cachemem operation.
> 
> In support of that unification, the setup of RAS registers needs to be
> centralized. That in turn requires new handling for early exit setup
> failures and additional teardown support for resources optionally
> acquired at port / dport creation time.
> 
> The devres group mechanism is deployed to cleanup some open coded
> devm_release_action() calls. The devres group facility also comes in
> handy for unwinding conditional setup steps in the port creation
> process. Recall that ports defer probing their CXL resources until after
> they are known to have a downstream CXL connection. So, early exit during
> setup of a new dport may have more or less work to do depending on
> whether the first or subsequent dport is being added.
> 
> Given probing port resources is a 'probe' action it fits more naturally
> as a driver operation. If cxl_port_add_dport() then moves to cxl_port
> driver operation alongside ->probe(), it enables a cxl_test cleanup. The
> cxl_test approach has a hard time mocking interfaces that are internal
> to the cxl_core.
> 
> The rest of the patches in this set finish off the conversion of 'struct
> cxl_port' and 'struct cxl_dport' to be the only CXL objects that
> interact with the CXL RAS.
> 
> Dan Williams (8):
>   cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
>   cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
>   cxl/port: Cleanup dport removal with a devres group
>   cxl/port: Move decoder setup before dport creation
>   cxl/port: Move dport probe operations to a driver event
>   cxl/port: Move dport RAS setup to dport add time
>   cxl/port: Move endpoint component register management to cxl_port
>   cxl/port: Unify endpoint and switch port lookup
> 
> Terry Bowman (1):
>   cxl/port: Map CXL Endpoint Port and CXL Switch Port RAS registers
> 
>  drivers/cxl/core/core.h              |   8 ++
>  drivers/cxl/cxl.h                    |  27 ++---
>  drivers/cxl/cxlmem.h                 |   4 +-
>  drivers/cxl/cxlpci.h                 |  12 ++-
>  tools/testing/cxl/exports.h          |  13 ---
>  drivers/cxl/core/hdm.c               |   6 +-
>  drivers/cxl/core/pci.c               |   8 +-
>  drivers/cxl/core/port.c              | 153 +++++++++++++++++----------
>  drivers/cxl/core/ras.c               |  50 ++++++---
>  drivers/cxl/mem.c                    |   2 -
>  drivers/cxl/pci.c                    |  63 +----------
>  drivers/cxl/port.c                   | 132 +++++++++++++++++++++++
>  tools/testing/cxl/cxl_core_exports.c |  22 ----
>  tools/testing/cxl/test/mock.c        |  36 ++-----
>  tools/testing/cxl/Kbuild             |   3 +-
>  15 files changed, 310 insertions(+), 229 deletions(-)
>  delete mode 100644 tools/testing/cxl/exports.h
> 
> 
> base-commit: c61e99a20e7390bf8727a3b2cacbc00931b05d0b

I rebased this series onto the remaining CXL error handling patches to test. 
I injected CXL protocol errors using aer inject for AER internal errors and 
emulated RAS errors. The tested devices include CXL RP, USP, DSP, and EPs. 
Error injection testing passed with no issues. You can add my tested by if 
you like:

Tested-by: Terry Bowman <terry.bowman@amd.com>

-Terry
