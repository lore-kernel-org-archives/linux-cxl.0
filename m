Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A728A72B;
	Sat, 20 Dec 2025 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766213639; cv=fail; b=ftvUERXNxrHTDLO4xa29WTIZoLZUNq/kAcNJkvnr3r8egeFEEpMvZesdi3fDWQawTaW2l4NIsheZhNDIlCCm9W0s4FoixY7lLzdb1oA16hG5bIduqpKdnCw4iQu0mnfeRQQZRUeSOoRi6LiX0GVsVBK3/7Q4AFUM4fklYYKmiDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766213639; c=relaxed/simple;
	bh=rWS+Fwp3qEY5sw6dxXpHhoowLGpCAOP/O4M7FCRPsHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hqwzbrQCISs4cs7pjsdYXHXnqsjZqjXwIRJgudbkATZHXAg8RC7gnyel1OcfCggdxlgJEPbhkXsNlSKoCGZIsCE4XWCFc3VodRAOnmuQDi/zTdaKd9LxM0+lydafA/hPOjlgKRD9QPMS/fAFY4DLOU3Fmte+rcST5zxQw4bggJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iyyrjno+; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iyyrjno+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jx+UdJCJIu945BVBWHvStx4Yiz1yOOjviDHzLWVhgZbVvOJ57HanjNDH4uYoiAksfsZpRgoajCIlx41U0GgrqQtQAFlKyKIgw08fmTQq4oXMzf6FQ/bKyaSMys0An/X72kOia9nGsKuAK3CXyUrwB5HMt2Ue04GfvtNtNWkYEAmzPyUavJzlQ3waFkoizGtJAhqawyQ1g6Iqi4sbF7BoCimJN1cANUWLWYyCfM3VDnf8tbQw5cbBxNf7qpCZ8SXH4Jvu1XbQd2oqvVs868uwvr/2yByS8AZig/I4TBsjJfeUUB+wCiuAHArOFD/8PLPDddlPXPmRXGLDqo/LcXXlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onc/wSevv0yyG3tSgidjASAgpH/lDVYS9HZShP3fvN8=;
 b=xfy/EHoh3TudsugE/jD3IJMkpGw6e8yhkzadBp2S9lrMjJFOYWIEMaBkcMWsCPie/sAPpMEdgRGTJJQZYNV0vurQrBJ5gsCzU9sO0dMuKuM4rdcAa5tAtnUUV43l22q5+vLI+o0QV572D//uyEchU8XyahSynYVYuIA5O28KW6tRC87vFvzt1eEMhGADuhdH2LvmVsOLATLMM8ot6dv9YQSLDenM+qUEBNEph1AmFTOOsBL03J0ZvQ/za44SOuCRdubbJqKkQlMkxCuvTT8nN11DOmtXtDSBVUlr/bQTDgb1MPSyhM0rXy0Ue1pZk/X5bGFeYIYmQGy5KvteFIvCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onc/wSevv0yyG3tSgidjASAgpH/lDVYS9HZShP3fvN8=;
 b=Iyyrjno+7zdy7LsGzNLlm/ZTeC9NeeaHAU1KQnn2McqkCRJ/0rcKYNBywDQ6vWnXUIk5Pe7yPlc2ukCIlXNg2hCWaTD2SzUCi0UzAxWSaA98bAYht/fx/VVk0chtciZMz8Z4JAbfE0SkufdMGT93tvJwHYpxoAE/0YZqDTir5b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Sat, 20 Dec
 2025 06:53:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 06:53:53 +0000
Message-ID: <9be1e001-2fd9-4da8-b602-4ac55002888e@amd.com>
Date: Sat, 20 Dec 2025 06:53:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Documentation/driver-api/cxl: BIOS/EFI expectation
 update
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
 rakuram.e96@gmail.com
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-2-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251219170538.1675743-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: fd31ebac-b847-4456-13e7-08de3f9489c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlWaVNxTnZWc05hNW1DemVoMjlWT0w0eXBvQjRvRng1OG1uTFEzZ3NwcEpL?=
 =?utf-8?B?YTE1UG0xU0N2bzUwOHo0UDlzTDI5WjIwRGdQbGdaMXliVXU3ZURVd093TlAw?=
 =?utf-8?B?TkdFOHF5dzRQMGtZbDhSMHh1SFltRG8weVRZR0hValBhQ01HYWZhMG9kbmRB?=
 =?utf-8?B?SENlOStqYlBXZlV1MFAvL1EwRXBIQjZpanNaeU9sMzNJKzVqKy9pRmRnUitP?=
 =?utf-8?B?SXVJN3MvYVd1aCsxa0VJWit1WUdDUGJlZUxvUEJZamoyTE9XbEhZSDFqOVNx?=
 =?utf-8?B?cS9KVHhGSXdUL1YvajF1R241N1ZnY21JMS9HZjlyaDVBNHFIaEROUkNVbURU?=
 =?utf-8?B?blA1WmtTTUt6TlRyQlQ1bWpHelByWEdZbkQ2NjlzSnhOZ0pwN001RzNGUmsv?=
 =?utf-8?B?bk56MHgzL1RVS2ZBcytrQkhKYjh1aVdNY3laM3FjRXlJSW9KUWFmVGN4T21o?=
 =?utf-8?B?SUxwaWtzNjJTaW9nQkc3VmVxUUZFT2JYK0R1UHZoNzg0bnYzVUhGTHBJZ3lM?=
 =?utf-8?B?bTdKQ3BiZ0hJVXhnaW9xLzN0VXBtZERuQWxzMkN3bEpqNThFMHVxZGtXQ2pl?=
 =?utf-8?B?bkdpeWMxb3JaUGErbE43V2F6a2JWT3VsTkZpbXBRYStGamRJQktpeTRreWRr?=
 =?utf-8?B?a0NXQmhSbzh4U3YrOXEvcS9tbVlLNUsvQjRqNitWenpaSE1rNWZXaTlNYXhj?=
 =?utf-8?B?Rzh5d25BUitpQVpKZnc5N1IzMDBKaW42bGlUT09xd0UvNENVTStWZUo2elBv?=
 =?utf-8?B?dFYxUG4xS2ZVbTVpaTJtbnpJNWw3N0JMNFdPb0JxbjlmemhSS0o4OGJrdTR4?=
 =?utf-8?B?ZVJkeVNvd0lOSGpCazQ1eUt0WkZZaS9PdndkNzl0RUlvdFUvY0JIbUdJTXF6?=
 =?utf-8?B?QktQQ0dNdXdJeVcrbEkxcGsydWdCaExFS3Y3eStyUjJOVjdOWEZXMUZoSWJQ?=
 =?utf-8?B?Ujc3enlHY1d5ZTQyVnd6N0EvQm5vZlRtbUZaQ3VoWFIwZDFEVjlyWTlRSWF3?=
 =?utf-8?B?VklKSE5DWE5VSUpJR21UWUU4SUdVQWU5bm5wSS9BTTFVU3JIV1hXZ3V6MVl6?=
 =?utf-8?B?UkNHNWtDblEvaEh2Z0pkV2tGMVpqdUIzMloyanlnUkl3dTJnb2VqK25rdHVu?=
 =?utf-8?B?eGZsVEpuUUVWczlheEY3OUNoNDd0U1lac3R2alBDRU5sMHU0U2JLS2NpbEVI?=
 =?utf-8?B?eEhXU1g1YkNCc2pEQ1BnYmc3ck5Za1JYWkZFanRhMEtocnZHNW1yalRvRWt2?=
 =?utf-8?B?RnBsMjh3bmRWaDg2aEdoN293OThsSXZ2M2hLbDNDeUk4dTd0ZFJRdE1qektD?=
 =?utf-8?B?TXl0U0Vxb3lXT0N6aVVSUGVHS05JYzhLL011Y3FNaGREK0lnclVqNlUxdnVl?=
 =?utf-8?B?a1B3R01lUS81a2FzVDRLdzk0dnBvUCtFMXBtUG1INlhuVlBMaWwvZDlyWlBI?=
 =?utf-8?B?UkQ5MnVtL3FRNWNrTnRxUEVJTEtOcTJmN0RhUG1RUUlRVkI0M2I5MTIzRC82?=
 =?utf-8?B?ck52RGtmM3gvTDZwTWxaZ29lR0RLWjgwWkJ1by8zSm9PajRLWmZTYVd2YUZ4?=
 =?utf-8?B?UFBNSzVZaERUQWFRZWZmd2lsWGxPc04vbFhaajVRN29ZNzM1N3JZelBoTHM1?=
 =?utf-8?B?clZiR2JLS1hIK2Y0MHZ3bWpZL0JTQXlydUJncjN6WmQ5djhoc0JTUkFvVDM0?=
 =?utf-8?B?WmNHU0hlQ0RwVFBaZERYU0tMRFVZUWpkSUZJZTM1TUNwWVhaUlFtelp4d0VT?=
 =?utf-8?B?VVdsM2VJR3RUNDFCU1BtYkVxcS9zZ2pwaG9kU2JCQXVJbUpsdVRwSjZXRW5U?=
 =?utf-8?B?ZkQyZm1aMnU3eFF3NVhvbExOaDZwMEJ6TTNXb1pXWFVQdGZEalhTdzZPZ1ZJ?=
 =?utf-8?B?TExZSmRWeUV5SEt1Si9RQ1RJYUowV1NXNDNlSnJCRlE2algzaFo1MndFMnNM?=
 =?utf-8?Q?K+9JnFbIj7xE+xXBWemXtzqTqwVO4cU/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2xPenY5d01BOEJadVZGMjUzeDMrMHhQdkxqVzcyWmFWLzVhZTFVYURONHFy?=
 =?utf-8?B?UmN4ckY5Q0FqcU5WTDZzZFR3WlA5NStZVE1RTWN6d0ttWVhMRER1bTZGNG5Q?=
 =?utf-8?B?VzlDd3YzT01YdVU5Z1B4cnlYa1N4WjdVZVBaWnE5WEVZamhJcjErNnlqUG1T?=
 =?utf-8?B?WmE0aytyeE0wSVJHSVRiS29nNFpINHJlZndIRnhMV1ZlV2RmY3JtMHFVbnd2?=
 =?utf-8?B?VXp4b1ZQQlRtSkkwamtSRHBnYXlYbGpENElmYTF0MWVhQU1nQUErNmJIMTJu?=
 =?utf-8?B?eTNEeExYYjNTQmpTdVQ1NGNvUWlwSzhjSXdDU3J4VEJhWEY1bjdKUlhiL0wy?=
 =?utf-8?B?cjhZR2JzZHpIRis2UDdncHRudmo3a0IrUzhpOW1CekVYWEJUSTNCSkJzM0p6?=
 =?utf-8?B?elNoaFdFbU1aOE5taldlek9qRVM5bGpCN1RsZzZBVm9UK1djdTZvUldwaTdk?=
 =?utf-8?B?cTVDUkxiSkF6SUNHckVCWFhlYXFoRFQ4QWZmSlFQbVRuQ0szdE5LSWduSkR6?=
 =?utf-8?B?OGoxWHB1cXZFVlVzckI0ZENJT2hIalg1QmJwQmc0WnpyYXN5L2QyV05LZFo1?=
 =?utf-8?B?cUFsNzF2UWg1TTJPbXp5Yi8xcmI1Y292OVYyTTZCdEw1VC9HOWNjZzR5SzNO?=
 =?utf-8?B?WmhMMXg5YXpjQ1pPOEMrLzR3OGZ6dDN1TXZEcTBMNDFuekxmbFprMlN1ZjFE?=
 =?utf-8?B?VXNmYnc3VHpWQ0YvdGlaTjI3S1EvdHdxUEpHYVNScHNvb1BDc09EUllNS2NM?=
 =?utf-8?B?UnRMZTlSVmdEMTU1K3ZONno4cDg0WHJ1K1VBME1VSjV0V0ZvRTJTTmFOM0NQ?=
 =?utf-8?B?UzR1azYzNzJhcGdxQWZsM0J4bTRDWTR0L3hDL0xIMFBBbk1XcmRVdlV5WGpR?=
 =?utf-8?B?SDhnZERrVlpBOVNJZjYvVFhHQkZ3Z1NYODdraVR5ckdTd2hjNEdvN0pzVnhH?=
 =?utf-8?B?L1FsNGNSU2VDREVMTktLNmgrWlBCNEJWcHYvcjVaVnNvd0lFWGFFdWNmcGVH?=
 =?utf-8?B?dlh0d1Q1M2d2alFLVkkrcXFZSjArTkhLSzRaV1BmNXV5Z3V6QXg3czBVTERR?=
 =?utf-8?B?Y1B2Z0wxaXBmM2cyQURtMGpCR2wrYzFxVzZJUFpWYUJ2U3hEN3JkWGYvWFQv?=
 =?utf-8?B?WFhqNHNnUytKeGx1NUtPK1MxR1FQOHpsVDlvQmRZcmp2V1I2SzJjU08zazRZ?=
 =?utf-8?B?THRld2FFNnIwVXhuNFNFdzIvZDVLbDVBdGlydU5uM2tYOUN3S3ZJYy9VakR6?=
 =?utf-8?B?NTExQUUvMW9sdUVVYS8yWW4xRHFHK0xpRUFaOGJEM3pGVytHVnFMbjgza2Jl?=
 =?utf-8?B?N0djV0NsaHVBajJmMUpSWUJzZkF3elBLN1QvQTBOSCtHcFZHeWZLTXdHYjhU?=
 =?utf-8?B?MlE1RG9kdEdraG14RndmeVFLb0wyamx6REZ0cUhEVEt4VU9yZzNzYnA3Sy9S?=
 =?utf-8?B?SnF6VHFIZzdhbzlLa0NsaEFCcVJld3ZWblk4S2kwTFZYeHlTU2pibms5YnEx?=
 =?utf-8?B?UXpZODR3eEFVa05ObFFrTVhNYUhvUnIrUFdPdjhvNElOZk82dWdCSGtFZzV2?=
 =?utf-8?B?R3N1VDBCN1htbjdZei82ZS9IK01relZaTDdQYmhmUVorOStpa3dBTmROWkdx?=
 =?utf-8?B?bHdCNnlIUDRJZldwcldWekNoSXg2RmRtdTNDaUpWQWc1MmFMb2VHVXVyYyt2?=
 =?utf-8?B?T2FTdlcyZzlKaUFuWkw1aFpWRHVUM3FXZHdmeGUzMkxkdlBobHFodVYwQmI0?=
 =?utf-8?B?eU5HVlVRbkRLd01QZTlXelluZ1JJMnhNSkI2RUZ6aisyaVorMW5UTzNSNko4?=
 =?utf-8?B?a25tU1cxdmk1b204S0IwcFlCWGtzTXg4cXc0L3lXWEJUK0RkN09EZ0FOOU5j?=
 =?utf-8?B?NDI2NG9ndktvdmV3eDYzY1VoS200U3loU2I4Tkl1Mm1MRUdhNkt2WCtSNnRD?=
 =?utf-8?B?UzNxam8yMlBiQzVNaEt4RllBZWcxT0IrTDhUNHJkejRTdTlZZkgzdVlVN3lE?=
 =?utf-8?B?OXFib2s1U05Kc2ZQVnh1Q2J1ck9kdjJ3clBFSzFsL3Q5UXg3M2JFZ2ExUTZY?=
 =?utf-8?B?QmQwYnJQWHJPSnhWRzNlRDZiWm1nMjJpTjFYdjNUVWZwNFQ1RTJTQ0p2ZlNx?=
 =?utf-8?B?NzVXMmJDbGpGYURVa1ArNnAxeHpjVzZsNDdLNzFyMVIrTURuU0dtODNMQXBq?=
 =?utf-8?B?OFUwbmxFaldTU1RTU25BdlFabXJBNURNYjVUb3Qvdm9TZXBWZCsrS29CVWVq?=
 =?utf-8?B?cXNOdW1LRDY2U3c4RW91eTNvMjNsa2w3RUM3ckh6OGhLc3I2ZldkNGlZRi8z?=
 =?utf-8?B?Q1RpOCtEOHQ0ZmY1eWpWQ2tMUWRHYzlTazB3aXNWUW0wemdhL3dqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd31ebac-b847-4456-13e7-08de3f9489c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 06:53:53.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npiF75KXSS7k8jAYW+tlS9084GER3PFkPfmYLD7mD3rRFkYjjI7l5yoLREEfnhmpGLvKXzCn5iFRxECnMOfqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398


On 12/19/25 17:05, Gregory Price wrote:
> Add a snippet about what Linux expects BIOS/EFI to do (and not
> to do) to the BIOS/EFI section.
>
> Suggested-by: Alejandro Lucero Palau <alucerop@amd.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>


Reviewed-by: Alejandro Lucero Palau <alucerop@amd.com>


> ---
>   .../driver-api/cxl/platform/bios-and-efi.rst  | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index a9aa0ccd92af..9034c206cf8e 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -29,6 +29,26 @@ at :doc:`ACPI Tables <acpi>`.
>      on physical memory region size and alignment, memory holes, HDM interleave,
>      and what linux expects of HDM decoders trying to work with these features.
>   
> +
> +Linux Expectations of BIOS/EFI Software
> +=======================================
> +Linux expects BIOS/EFI software to construct sufficient ACPI tables (such as
> +CEDT, SRAT, HMAT, etc) and platform-specific configurations (such as HPA spaces
> +and host-bridge interleave configurations) to allow the Linux driver to
> +subsequently configure the devices in the CXL fabric at runtime.
> +
> +Programming of HDM decoders and switch ports is not required, and may be
> +deferred to the CXL driver based on admin policy (e.g. udev rules).
> +
> +Some platforms may require pre-programming HDM decoders and locking them
> +due to quirks (see: Zen5 address translation), but this is not the normal,
> +"expected" configuration path.  This should be avoided if possible.
> +
> +Some platforms may wish to pre-configure these resources to bring memory
> +up without requiring CXL driver support.  These platform vendors should
> +test their configurations with the existing CXL driver and provide driver
> +support for their auto-configurations if features like RAS are required.
> +
>   UEFI Settings
>   =============
>   If your platform supports it, the :code:`uefisettings` command can be used to
