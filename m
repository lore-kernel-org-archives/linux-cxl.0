Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49E2AE99
	for <linux-cxl@vger.kernel.org>; Thu, 24 Jul 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372705; cv=fail; b=KooMsBh0V8Gr4cJW37+MfACILzhqdmLt8bi86o2RDCFNQ+s0lS5AsgzZDlC2kDrGqulSRmZcWQcf+uR0GjmUjzS5tTLnafuygglnRvoeWD/IqptOn/Wbj3MKfJSeU24d7fypgERkMRt6zVy13L3JuKjTW0YVJWO0LRZNw5obAh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372705; c=relaxed/simple;
	bh=jZvi2lhA3CdcpSVR7BObo1iwgqVjrYK/+hHvs6HcVdc=;
	h=Content-Type:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:MIME-Version; b=Dgus8SgcbD0U3NMPnLeZYMkwIjvt0XIvG0dZWcFckqXUOVQs12qA51FqctyE16IPvyW+80FigmQFiCsLQl6kbUPYoDs0CdAuU1t64RbSIse7LCZjZ2eZjL+docosVs2VQ+vGpabEB46UWjTIpOEvdzHfrnPWY7FMhYwsjIb2TKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFiBm0XX; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFiBm0XX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCtDFTcsvRvM3aMT6JXrGPsI/71jQdXw5vWulrQ0j9XF2Btkb/HzzQGh6Rb5ZKMN/1Wpnb1+2R0Abu4KGEq90A7X3kE5TEHExM/udt1m+xC+E8M8BM1wABlUEIQF/mQtwELs31oNXLSq8xiYK2xOnswwTek0iC8dJTLASQypQ6q01oE1IMngekvrH0Gks/SguIcJ5htAfyO7qpcDxYs/mBXO9tQmIOKzB4ZbesCnKOHyCoiqFmdTCcbFbV4+zcDQxFYJN35iYGSF/QJeEpEc15ZBZsChxmJO/TLqAN5IwQEf2yI7rnm05ZyqJG8S8+6WJojIwddpMydALnEiFgst6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om8hP4Zj2YsE5UXGOWmwjf1tn/dMiKz1DLWto3y3sS8=;
 b=rPIltknekzqR+C0CdTnXjVYTexcQ7jEFP6R6M7rBYN9w2GUYB4gJOC7PKnwIDj6Iv4lAs9X/QfGhYJqmm/CmjGGVyf+s9uvH3XLRRw/0pWenq1Ko0BKZq+eoseBJB587w2GHKVNp7zy6uaFEdHs3gmw674S6sv+IETVy8uRluxt1iFIkSQ7BWUtcEPKdq3Q9SlWHEZSU9K9F7FvDkXPEnyL/LFsk+ifBDK3u4mL6XRE1aV76sTYOwQYWFRaJR0FICdT9F74xQEDYvQdJw20MOXfn/aQvIvfeATDSK2LZvjie/oVx6yd9HWEliCDUAdEVN8wd3E54AC3FZK0K5yx+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om8hP4Zj2YsE5UXGOWmwjf1tn/dMiKz1DLWto3y3sS8=;
 b=kFiBm0XXOZRQiV6y9AgLCy5zVMpme+p9HQoOOXORDTBSjnt5+4FoOAcAwrj24Iq8ZQ+6kS0LsNTVvYsbhIK0tW3p0DI+Yjhdqj2ceUYuPQv1JHPkSCBOr8uN1MV+BXfTK7nwjf2iyVhyQpk609uwJQve+qzNJ3R3vhTZiG73V9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Thu, 24 Jul 2025 15:58:19 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 15:58:19 +0000
Content-Type: multipart/mixed; boundary="------------j5lspyBx5GbKx00P0KSSx7rY"
Message-ID: <f5434232-caac-4459-80d2-e981de0e9549@amd.com>
Date: Thu, 24 Jul 2025 10:58:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/17] Enable CXL PCIe Port Protocol Error handling
 and logging
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 terry.bowman@amd.com
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <68815a66459e4_134cc710012@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <68815a66459e4_134cc710012@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SN1PR12CA0094.namprd12.prod.outlook.com
 (2603:10b6:802:21::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad1bd01-d287-45ce-a500-08ddcacae8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007|4053099003|4013099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1BUTFNaa2IxYmphSWhVVTBJM2NWbDcyeG1zVkExTWMrOXpiL0hPaVYrRmcx?=
 =?utf-8?B?YndoWXorSHhrMDY3b2pWemVTdFI5dE5tTTV0Mkh2S2FTNlhGQzJrcU9kWGJo?=
 =?utf-8?B?OEdUMVVkSVpSUjdQencwMkpNNGJySXV5ODlPNHFZVWNNQ1Z5Ym5yTkpmbzVE?=
 =?utf-8?B?R3VMY1ROUFFyOTNQdXluaUh3di9wdCt4bTN5UlVsUktlaWRDSzdxRHk3VHF4?=
 =?utf-8?B?MEJJaTM3WW5TS3BzU0FNaVNmTEppVUN2MFRaUGQ3NVE0R1BlWno0WTNGM2JZ?=
 =?utf-8?B?d21PaVQxajhBN0ZRN2NhNjMzamJBTnNsdWhnT09XR1c1M1NwSFNLY1VVaTE1?=
 =?utf-8?B?TXV2VWhVSzZTSFdnOWEyS01KeXRnMjM1VmVwdkRTTDFqME9hQjUwSnZBZjQz?=
 =?utf-8?B?ZWVadkhvYUpFUWwzWmVWcFNaT3ordTdmV013MW1kcFRGKzE3ZVZlQnVBUUtx?=
 =?utf-8?B?UW1xYlovNFdhV25DNmx1NmdEb2FuaUh4UmtLMzdHcjBzam1hVWpaR3hrRjRM?=
 =?utf-8?B?cUZ1aWxpb0Ewem93UnNBY1VTU0dEcW9uTUpyb05kUHE2S2Zya3U2U3lzeWht?=
 =?utf-8?B?V3ZTVWRMZlNoVFlmWDZXSlphaFBuaWhMSkkwcXc2WVhlbWh3RVBZV04zK2hE?=
 =?utf-8?B?UEFUMFFOeXVnMHZDOXFVcEgyYTBEVmF0eWNtdTRiM1IrTzBoaVdsY1hYV05k?=
 =?utf-8?B?ekd0cDhPc2lRLzNlYklmUGYwWlJNK3dPWU9Gak5SRkdyU0ZYNmZCajRSWGk0?=
 =?utf-8?B?dDFadXBuQ04yem1qajhLZ3g1dXlRcnRQc0huSVdMckhmQ2ZMOEVrTmM3MEIr?=
 =?utf-8?B?V0pRcGxUdE1CSGpVb0ZFTmpaOXpEWnZtaTgrU0VDeWx6NWxkRUFqWG5KVTFU?=
 =?utf-8?B?Q3VTMmFwZE4ybVJPc01vaFMxdDhiQWtHbzlERnNTZ1lFY0x0ZWhHLzVoOE1D?=
 =?utf-8?B?b2FRZXVpUHdUVlRmMXBtS2JSWnFvWHdvSk9IN0o3QUt3enh5OEhlMnF5eFpO?=
 =?utf-8?B?T3dicWZFOUpiaUZlb1JzYVRiRFViQ2VPMW1IbkJBRk5NQ1hmSFhwdzVZMlhk?=
 =?utf-8?B?eWJ3NUVwbUIxZnFYZk53Q1dCdnZiYkxLblBrcVNxOVk5SXhLRy9sQzRIUEg0?=
 =?utf-8?B?UER6SXgvVEpSTlBuOC9keDRNSm1lQzVmdnpoM1hUbjAxTkRYdEF2Z1FTcFN1?=
 =?utf-8?B?QmxST2xSUXFOb3VINXdsY0lyYlFxTkNId1FlRmpkK2tPak9CZXF2RGRFMm5v?=
 =?utf-8?B?bUVmc1ZDMDVXNDVUanViWjdscHRiWk9vYlBnUzNlT3U5ZVkvRXZiMkswcS9x?=
 =?utf-8?B?MkE5RVdDZTU3V2tFak9UMHVvZ1lwLzVWdkdsTWoxZlJhU0lURjYrQlhKRXdj?=
 =?utf-8?B?QnRUK3p1Tm5wdWxvNHNPWWUwRE5VVEd0aHdLQkdHUXNRcVZqejZ2RkxBWjFD?=
 =?utf-8?B?RTd3Nm55Tk5IS3FaRnBjQko5bzBBajF3Zm5WRm8zM2MxRGxOR2liL05ETjMr?=
 =?utf-8?B?UEVQd2JCdU5BbXNNYW13emh0d3pZQlNCNXZmeTAreE5qYkduZzQ4eXdGaXBr?=
 =?utf-8?B?YlYvb3FOOHB4Z1Z4TlRRRzBBRWRaSUM0eENYVUk2d3JSOHpEcS9SRklNOWIx?=
 =?utf-8?B?ZTZaWnE0aEN5L1RGVnp6R1hwbEltUm9uYWNaQzh0UEZiamI0ZFhHb21DMWhn?=
 =?utf-8?B?OWVTQzhjLy9CaHJUT2c5dGxSN2NxMEhndmFPSkFRTDR0MEYzSFRocks3cGdy?=
 =?utf-8?B?djNmWXMrd3RlQllJak1uaTVneFpRUlhnckxvWVA3ODA0NURlYWJlNGdwa05o?=
 =?utf-8?B?ZkxEUks5NlJGMkVsYXB5RERvTDBZOU84UWdEMklCaUNpaUhWV0ViUGw3d01k?=
 =?utf-8?B?bzBJd0k3bjdkb09zOG9rWUFleEh3WGZ4cE85Um1iVEl0aUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007)(4053099003)(4013099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdYYXJnMHpSZDYvVDg1RzhSQVUrUVNyVFNwdWZnMGs3TUs4ZVpZaTloSFBF?=
 =?utf-8?B?NzgrdHdxN0xmZjdOY2MvSTB0MHlYalkxUk0zaHh6dllDL1Q5S21sU1hNUUN1?=
 =?utf-8?B?dkFtSG00ZHQ2MnVENnY1UGI3WXdxclU0ZGI3MktOczZjTFNpMUJLTHhHa1ZW?=
 =?utf-8?B?MXZReVN4NC9hYXNFcU9nTzJjYVRsdlhJYUVFVW5YcUJvTk1mM3lhcklHSUtt?=
 =?utf-8?B?bzRSckJzWVJzSlN0dmlOOXJzZ1BValVvRmJaMFFTVjkyVkpPZWNMWWMybHo5?=
 =?utf-8?B?K3AvbEhJZjNkSEVPRHY5MFNYbGt0T1RxMGl3WkdiVXNWcmlFRE54clVFTmN0?=
 =?utf-8?B?R2Q0a2xJU1RTemdJcHd2czdDTGxjTnBNZUNmUnBoYmhaZ3JhVmpYMWR3cW1k?=
 =?utf-8?B?Y1FjNU1HeTdoRTdKcWVBb1I2MW1MbHBpN0FyL0F5QjdPSVhMdW9BL2p4dzRK?=
 =?utf-8?B?Ymd2K1VUVnlXVkZUUHlFSmFEbWNjMFU1Uld2M2M3NE0xTU9BaXFNMTRzdXk3?=
 =?utf-8?B?d1RQU1ZlQ1BDMEh1QkZ4TVduWWlTV1VGWHp4YkViKytDRHl4MzBwL2lwOVJZ?=
 =?utf-8?B?NnlSR2E0Nk9mNGl1YnRoOEJVb2tIaklNdmdETkRQUERqYTU1bldSdkN2OVp3?=
 =?utf-8?B?SVd1alI4U1BTZlFQRHpaLzI1bUViTnJ5S0RyRm0wclRpeXZ3Ti9FUjVlSmJ3?=
 =?utf-8?B?bkl2a1BOYXNYS0tKc1NPWXRmendFUEhoQjBSMldsazFxOXZ6VExqdDB2UEJB?=
 =?utf-8?B?SUFTaG5Cb2VjUGs2bEcrUmZTMTVaZGxjTVN4dWJRUUp5aEc2T0o4VEplRFk2?=
 =?utf-8?B?eEtFQVNRZFdjei96KzBZbitCaFM4eU5KTlVuVlhYSDc4ZXozdnVrNEhGd20x?=
 =?utf-8?B?cG1ndjVBQkRaWGdnVEdvc2xFaGJlZmN1ZTl3eEhST21nbDRhbWVLTXRkVEU1?=
 =?utf-8?B?akZUY2FXSFBnQU0wdWdOQmpVYUV5ZEk3Nk9aL2ljUFJKa29lUExkZmxScGIz?=
 =?utf-8?B?UmplM2l1VWdBVWIzb0lHbzd5dG1OUnFhTXluMXZHMCt3TDBHbGdzQmwyempj?=
 =?utf-8?B?aUxlaE9Uc1VnZnVwaXBVaUJoZDdxQm91bUlmU3R5N016aktjUFVzYmZvU0N1?=
 =?utf-8?B?OVhVZCtWQmk5SlRZZmk0aHhwazRGWHZEc3NxKzJpSThzSzJLNU8zS1FuZk91?=
 =?utf-8?B?ZGdBR3pMT09HSkJBcFRTS2Y0Wno5UWhlbjB3OGdhdWhNVTZRL0FaQm5jMGp5?=
 =?utf-8?B?SWdFTGEzMEFHbTI0dUo2UEl2cXUydk5lRUlqemtNSkMvYTc0NHdITVFNVFB6?=
 =?utf-8?B?MUdxbU1mQWRjaGpnUFMvWXl1aHNJaThVUkFCVTYveHRRUkIxNi9hQnVudGpr?=
 =?utf-8?B?d1V0RVR1TXYvV2hzU28wdzYxMGVESmJBbWU3T25TSlp2cXpRcHdlNkNianBZ?=
 =?utf-8?B?TTZCeW5TZU5KajdQM3AzRWFGMUg3ci9WZ05WczhRRE5VZm1YMDVzWC84dWlE?=
 =?utf-8?B?SUxkMzRySGVqM3dBQW1lKzFuZHdRMU1PZjM3L1BrLzRtRHdQbXRObHBWMVBl?=
 =?utf-8?B?cGVMYmp2Rjh4QXVwcTY4cUNPYzJhU0pPejN5RmtwSkxJOEY3Q1NrSE4razlK?=
 =?utf-8?B?U2JGYVdpNDRuQXFwdEFzb014UWdxcVNxdmkxMGo3N2M3VTU2MGdLdUpMUXpj?=
 =?utf-8?B?YkNZVVRjNjdib0tzTmFXZ1lwM25kT2dvSzI2VVVxcS9mbWtveWkvTXhaSC9k?=
 =?utf-8?B?TlYwTllhdi9GRGYyVDkvTXNZUzFKTzd1UUNwTFc5QXFka0xrQnJCNVR2ai8z?=
 =?utf-8?B?VFd5QzJwSVpnM3psUzBHSW1DNERmbU5rdk9hSmNsekFHUUFzVkdvWm5BRkFl?=
 =?utf-8?B?YldObkYyWVJRUWdROTFNNm52elJrTy90NEZQVXBYM0Mrc1V6TEdHbEthV0hR?=
 =?utf-8?B?MC8zdmFIZ1FhanU1NWZaczdRYktOWHpTdTRYc3ZvQnVaaWVSU3pKeHlFNkJE?=
 =?utf-8?B?MFMvY1N6YmNLWXlGWkg5bzRaajRYWHpwQVhuQU44NU41LzMxRHJ1SEwvSDRa?=
 =?utf-8?B?Q0owQzFKdlRIQUNyZGk1OUJqdWxzVGNFOS9YWEpSQ2pPUUFoY3lLeDNTWDN3?=
 =?utf-8?Q?0m8ucNQdCp2IgD2wvYI8b86vM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad1bd01-d287-45ce-a500-08ddcacae8c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:58:19.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQZJcn4g3s8zw8Ios0zYYZSsmHmMYfPtdknAwJGFRYR1rXjIqRbYrvQZbfi7/vAuNl7aIBGnD9QE7d7o0rfmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

--------------j5lspyBx5GbKx00P0KSSx7rY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2025 4:55 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
>> Endpoints (EP). The reach of this patchset grew from CXL Ports to include
>> EPs as well.
> [..]
>> == Testing ==
>> Testing results below shows the Upstream Switch Port UCE and EP UCE errors
>> are handled as PCI errors. This is because aer_get_device_error_info() does
>> not populate the AER error severity and status in the case of FATAL UCE on
>> Upstream Ports and Endpoints. This is intended because the USP link to
>> access the device can be compromised. The check for is_cxl_error() and
>> is_internal_error() fail as a result and then processes the error as a PCI
>> error. Also, the AER event logging is missing the PCIe AER status.
> Are those issues "TODO" or permanent quirks of the implementation?
>
> Although looking at the error message they all seem to correctly say "CXL
> Bus Error", I guess I am not seting the end user visible problem of the
> details you are pointing out here. I.e. LGTM.
This is a potential TODO. It needs to be investigated as a possible improvement
to gather fatal error details that will otherwise not be collected for upstream
CXL PCIe Ports and Endpoints. BTW, the check that results in empty aer_err_info 
is in is in aer_get_device_error_info().

The AER log's bus type is determined by aer_err_bus(). This function is only
checking pci_dev::is_cxl. As a result, this function returns CXL bus for all these
CXL device's errors.

The missing aer_err_info data for these devices results in is_cxl_error() returning false.
The error is then processed as a PCIe error. The PCIe EP UCE handler does check
for RAS status and panics() if a UCE is found. 

> [..]
>> == Root Port ==
>> root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
> Where can I find these inject scripts?
>
I attached a cxl-aer-einj.tgz. It includes the scripts. It also includes the 
patch to enable UIE/CIE in the aer-inject userspace tool. It includes a cover 
with the remote branch and base details.

It does __not__ set the CXL RAS error. I have been using a debug patch (non-upstreamed) 
to set the RAS status. It's not ideal but allows me to test. I can clean 
that patch up and provide here if needed.
>> pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>> pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>> aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>> pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>> pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>> pcieport 0000:0c:00.0:    [14] CorrIntErr    
>> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial=0 status='CRC Threshold Hit'
> Hmm, why "memdev=" for a root port error? Will take a look at what
> cxl_aer_correctable_error() is doing.

There was a discussion about this here:
https://lore.kernel.org/linux-cxl/aGSI7oXthPW-AY6D@aschofie-mobl2.lan/

> [..] 
>> base-commit: 716ba3023561ccacfaa28f988d26717535b8fed1
> I cannot find this commit in mainline nor linux-next. Please do try to
> base series on mainline tags, or otherwise push a public baseline branch
> somewhere. Helps reviewers and build bots.
The base commit in the cover sheet should have been: a403fe6c0b17 - cxl/edac: Fix potential memory leak issues

I somehow added a change to my local cxl/next branch. I'll delete and re-checkout remote/cxl/next and copy to cxl/next.
-Terry

--------------j5lspyBx5GbKx00P0KSSx7rY
Content-Type: application/x-compressed; name="cxl-aer-einj.tgz"
Content-Disposition: attachment; filename="cxl-aer-einj.tgz"
Content-Transfer-Encoding: base64

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

--------------j5lspyBx5GbKx00P0KSSx7rY--
