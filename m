Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E192505CB
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312921; cv=fail; b=TU7YyDISz0GRI4l+uHAmOcXZO4HbjC6Cayz6I+QgXNXAI8N3G2xuCpYJn9ZfO4798Zr8lOuramQ/BgtByeX00QahjMyxBDXGjEtBlfRaAZtuoZcgMaDfQUDj3apw3IXt1t+48oUWHob3cjs58R7c2ggs2mCvq2KX6eHd3upIATg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312921; c=relaxed/simple;
	bh=gkMI63gCJMFZl1Oyx4A6r+eIsWHIgRLtcWArftIS4zU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gbyJBfmfdgE0hisaQhPYvvpWaNbQbMKIjsUc1aqrQJUtETnpn34pbRE/j4sgflu0RjsPzZa5DFTq6Qbd01nPcUyb4sTRcmtrjxXAkNf3O4oK9lBoQOx1k+cuaHzjfGZb0SIWBgKU50qZ2pH1SyNvfCqQu6j7ttOpE7ZHeUOD3hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HpWkabNs; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpWkabNs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2fvMMneO9kHeVinpDaXiUynl6GYaXP7PMqJrFvqypyqm/DsKhkFHL4ZtwlER4mrOZreL6E09D4+c79r6NbUaMw32Lq3S3SBp6AmFoS8FMensg73MR/hr0Id+qDZZ3rujedswfQ9Gt8ZcAv779A/A+hEry9jy86qy9tg41pzrpk6sqZVcytEunmyV0To1QRn0MKJyc3vYEWu8N9NxdFRPE5LWLw3GY7pcCHsm4n2CQyzXs/xDJPRsZsqO7/+WZgRsovgHbGt+xZIyOovo3+rkPsjk+uchmI9WUjJLofEpNgTPKWUgUVFKwWAhfbnkxXtZJb8ruwBFcojcc15shF1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcsVzmfIB0p4fasuTq/nlURLvozewm9SAyTTnMmVd3U=;
 b=LZFrQKFrOv3eOm3MYobjzwWpzXW5SKk50FUt4iJU0oPrN1mDSA98A/Vb/W/+4+7gY2Y1PnVrpFVri1B/ylUeqccouIPTalwqC5179WrjWyZDj0/RtkN5VLdValwlEsvj7stcINyIbOI2Qc9o2MO6zTgs+HR0jLMWhh/HnMkczWjhV6XX7wUJK702N9Xz0xedlZUWg2q8scojdoVuiwSZldA5loNJnaE6SS6/m4kxWFRxdD/j9fhvg6nL4pc3tbQk79BXXRVMA/UA+ndP36pGHOcazGv5t21wSvm5L0o1gkbAddR2aqupIJ0uDcMnfpnrGYvKWhijIxkVat+PerX4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcsVzmfIB0p4fasuTq/nlURLvozewm9SAyTTnMmVd3U=;
 b=HpWkabNs/mjLSm+gxFuDQzdXS2GpFQBzcvtQk1rqOpk1uXubPw2Nc+Smoa8N4ZwDUJB/1f+eUTHnmBc1oPPyMfs9USzXk7vBrq0Ig4NSqEsHR/VFLRwyqn4xJY84mAZGZvs/CoRpNOUGtq74PCrugeyQBZv5YkHhybBEvs8kuHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 23 Jul
 2025 23:21:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Wed, 23 Jul 2025
 23:21:52 +0000
Message-ID: <4bcbde9e-8795-40ad-b948-56721cfcff8e@amd.com>
Date: Wed, 23 Jul 2025 18:21:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-3-terry.bowman@amd.com>
 <6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d6f223-5473-4087-97f8-08ddca3fb478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck81WktjSDRaNXF1azBmd2VUUG9WcnB2L29wa01FNGNtU2FKdnlkMUQ1bFIz?=
 =?utf-8?B?OGhwWjJtWi9obWZnUnhKWGZGOSt6OTB5T1BGekRJZHRMSm9ZVjBPd1BnanlN?=
 =?utf-8?B?cFc1ZWZSOVdvWTVFQy9ZbjVVQXYrZWppUjVOWGc2OE03RFNuNldITUhRZGl2?=
 =?utf-8?B?ZHU2bjhFNzAzcTREZ0NCMWVhYkZyMGR1cGJhWFBxUElxSmZROHdNMzcwa2hv?=
 =?utf-8?B?Z25xbHVWMWpEajdkeFp6VXc5cDVNb3dveS9sTXJZYy9EWDNJbktPZkdUWG1D?=
 =?utf-8?B?SER3WnFRZ29ONHBvbUE2SWNlUkw3ajRJYXl0bTRhNUJMOVpIbWtORDkyK3kr?=
 =?utf-8?B?Z2lBWG5OUkgvTmRUajIvQjl1TmpQUTZGSVpjMXpSbjg5elhZbnR5ZlFOZkdW?=
 =?utf-8?B?U3lCRVBPNExlaGV3bk1xMGZmRFRGQzVEL1V4SEd6ZDF4M09OdFFZMGJKWk9v?=
 =?utf-8?B?UW0wNy96NHdkQlM1QVRid2pVTkhteGRBRmt2MmRLWHRoY1pvdUsvcUlMeTlJ?=
 =?utf-8?B?Vkc5cUR6MVVSc1RRekdsMXo3ekRXYXZ4a29vQTZsNDAwUWR0TkExWnM5K0N5?=
 =?utf-8?B?VEluZDYrS2liUDJWUTdrVjFkOVltbTVsNjFRdkpPVEE0UlNsRGV3UWxQKzBI?=
 =?utf-8?B?aHNhNlF4cFJsOFVseGZoS200d1crMktiaGJWV0xrdGk0Q2xaajZ3Q0s1UUJz?=
 =?utf-8?B?NjkwSUYrbktzTEZtZ3VZejBmR0dXOGFJREhMWXkxOGFCaWZ1aVFqdDU1SkN1?=
 =?utf-8?B?dXVSTnplRkJWWTB3d25tSUdJb3dEekVqZlpCVThQM1hhQ2FOM3ZhVTNGdjJF?=
 =?utf-8?B?R0g1Mm1VNFMyVktNeVdMYkxOOHg4d0QzOXZjbmlqWDZiRkF6cUVXeWFwZ0Fr?=
 =?utf-8?B?OSsxajV1YXgrcVBBdzNQRkFGUUplTzFkZkU4ZWRZSVFzN3hkcGNuaE1aM0tk?=
 =?utf-8?B?UWFDNXJGU2ZkWGlkTVlKeURPYkJueklxMGNrMHdhMmRqSnFiRzZKNGhYSVFG?=
 =?utf-8?B?TlRqd1MzSW9CMmR4WEp0NldvSXFzbmpMaFJqSUNlVnFKMWZlYzNZczk1SDNP?=
 =?utf-8?B?WHh4aXV4bzdaUWF1ZnViUjd3Z0VUUEkyeUVjc29MRVJ6REI4K1dpNHlDaXYy?=
 =?utf-8?B?bVU5L25NS2gyd0VPaXNlMktXTnZpK3Fad3pXT0s0bktRc3FKb00zaVdMOVVR?=
 =?utf-8?B?ZHhacWRvNGFIeGFPR01jM2VZTXZMODJZTnFieDcvbGhNdnhRR0xIMWE3R3FI?=
 =?utf-8?B?cnBDNy83WkEyVk1DZnBwTWczUlBnUHhqMHpvWEtlRVQ1QTdyRW5OTkhzR0xr?=
 =?utf-8?B?YlVMVEpESloxalkrUGpnS1F1UlYxREg4eld4WkFsRzFRUndqR2w3VHlGQVR5?=
 =?utf-8?B?QjVrbkhZdHhTQ1ZRUXcvUzhhRVl1TGpyT3lidVNacXQ2SGE4Mm9hbEFPTXB6?=
 =?utf-8?B?a2JtcjV5eVVENkdVU2twQXVnaXRyRDE4UkIxL0FjSVFWRGtmdUg0cmdKWldG?=
 =?utf-8?B?dVgrU0tvQ2NUU0N6M3phK1BFUXNpN0Zkc1lURnI3bEZkQ3ZaKzdNVEs0Unp2?=
 =?utf-8?B?aDFyM1c2UVdIb0VWbkdIc0tWbllvd2g5eHZrSCtjZk9wbDhwSk0zYUUyUldZ?=
 =?utf-8?B?cEZpRmZDRkJWMzY5a0ZScmhuN2lZUzljdGJTWDZYazFoYUlaWkNJSC8rcWxG?=
 =?utf-8?B?c3N6V0F1dVB1VldZT2Z4aGUwMHRCVVFHVk1pMWRPTHJLdUpsdFFoTmYxRlRG?=
 =?utf-8?B?RWd1UEJBbGhiQXJZL2FFSlp6VXRvNWEvY2xOZ2huSEs5ZmttS0NwQ25VZlpT?=
 =?utf-8?B?dEVyRDd5V1B6MnR6UFMyaUtVSDNKWm5IYWJTSThKWDhYNm4vYlVqaURHTml0?=
 =?utf-8?B?cXlRUFBVdWtIaHZDMWFLMEQwbm5rOG5ydkd6clFIZE9rbVV4dEtoSkZnRHQ1?=
 =?utf-8?B?WlNZUUNCVTNIVFRPODMrSUlkQVpEKzRuMFhrZHBwbVJVY0Y5OHpUYndxNEw0?=
 =?utf-8?B?VWZQUFVBTDNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk9OYzhtM2t4bmxhbUxFR0Q2MTlzVmdyZ0IxT24zYXZxYkNOY21zbVB1WGkw?=
 =?utf-8?B?a2xtcGtyTGxKRUFRZkFuTENQejhidlZCQXZOb2tkK2FFMXp3MG9WakwzYjZZ?=
 =?utf-8?B?MDduNWtwNWNLcGxtQU1HY3hodGFiSG9xNDl1OHdKTEJJNmF0b3UvMUVpMTFZ?=
 =?utf-8?B?M3VjMnBqcUNCKzhaS0FNNjg5akkrS0NDUVZvZko4aWZGMHhYQU5yNUU5MTFn?=
 =?utf-8?B?T2NteVJ1TStLNmdTRUxTenBNMHUyWWY4VlovTDhUMXAvNlgxUnVxRFpKZlV5?=
 =?utf-8?B?VUYwTk5nbmJ5R05ld3BjaTJsNEhPQW5TNkJoandlTjU2VDJRaG11Mmo2UUI2?=
 =?utf-8?B?ZGM5MXZBWDVmK2ZsdW9uaGdmVCt1eFl6c0VQTmZBRnpjdktBdDZPNXNiNWxq?=
 =?utf-8?B?aExLT1drV3VvdXRIUUJiSTd2WXNRdmZaOFlYR0xDcVR0NldxbmxpWElwTVVC?=
 =?utf-8?B?TDkzVm9BbXFsMU1wWjMzY3FuRTVNS3B2S1BLWitsUlVFUlp0QkwxMUN1d2lR?=
 =?utf-8?B?RXhpdFZaZll2NzJKeTE5WCtHV0pmaUhKNVhObkl3K3RLUU5peFNJTzV6dVIy?=
 =?utf-8?B?ajNkeGcvMEJsbE01NG1kWGYvMjIyU2cvTXFtTjRSOFV5OFFUeGdMd0VnbC8w?=
 =?utf-8?B?elNUVzFvV0VmMmI3YVZYVTdSWHpDSDBlYXR0RmQ2SjcxbVQ1UnFpK3Zqd3A4?=
 =?utf-8?B?ZERLOFpoSkFCUzBHZ1EwMEpYV3crSml5SlIyWTRMOGNEUlN1K2Y4RExQY3gy?=
 =?utf-8?B?NkZBVm1HcjVNM01va3RCeWVMVmk4NTlYQUl4R2FiYU1DdzZDam9SNERpc3cv?=
 =?utf-8?B?cVFjLzBRRUNZTWRCQ2haNk5XOWE5VU5qcExiWUE4UHpPaEFwMVY4SmJlWjZX?=
 =?utf-8?B?UWtTNGY2bDgyaXR1dFRoQlIwUnM2TzRNMjJiRWNiYWZzREZhN0w3STAzMmxw?=
 =?utf-8?B?RHVpY3dXUFRXbDJRZzMxRXo2Z0lUU2xMY1ZUOVZRRUY5b1QrK0E4dVNuM0wz?=
 =?utf-8?B?MjN4cmxpclRPT1BlckFVbGh2bTBXMWQ5YUFMMUFZSDFxazdjbW9JRWlpOWFK?=
 =?utf-8?B?SVRndHJiNUM3a0hjWjZuZlh5SDlmZk00TE9tZGhjdWVYSE8yanpWM2F3YVJk?=
 =?utf-8?B?Z3ZsOE9lWlp5VXloczRiaDREcjlDendpOHc3dnBqR2dkVHV4QmFOdVBERnVD?=
 =?utf-8?B?MUJpK1pGTk1ZUFNBS1JEWFlUYXI1dkxWQlRkQnVnUHhkTWpvL0tDb0xZK0VW?=
 =?utf-8?B?eXJ3ZHRzMDVuMzk2T0cwYXNHVHYxVlRRSEQxYlVXeXFMeG1KdWUzVXQvZm4v?=
 =?utf-8?B?bnN6NTZaSXpnNjdkUkdHcFZBZGl4Q2NCK0xtelZtUHlhWGpyeTc0TkFEUUcy?=
 =?utf-8?B?SXBxdVNneTlKV3Q0V3lHVjVEdFdWZ2YrMWVhVnVPdENmWlpPd0s4THVkMnMw?=
 =?utf-8?B?bGVtblE1U2Vnc0Fwc1hyTDBkTk93bGZMeFJPTzJYT3NGODdNN2tTZm5tWEI4?=
 =?utf-8?B?bUtQQXJ4MWtFNzluV0ttamxWSEtjR29oYXZMNDhQUmVqREpyb0RmNTIvdmpW?=
 =?utf-8?B?djRKMTR6UHRVUVJZL3F6ZENlWXZ4bkN5Rk5KcmNIdXBEUEpNTWMrK01Oajl5?=
 =?utf-8?B?R2YyVTB4Y1pGZWUvTkc2dGV4TllLek5hQ2Y2c3ljZFRpOEswMkY5UlVGbTdv?=
 =?utf-8?B?b2RrVjFJVGhCaGNQVzdhTm1UNnRwMWk3cEJTMXF0NGJkSkw4Q3lzV2tMbkpq?=
 =?utf-8?B?emE4bE1lVFFnNDd2N2UwMTBuOW9jUnpPUFRhZGMzdmNwQUZKcHVaNWk3OVNG?=
 =?utf-8?B?NzNDa0ExVlRRRVJ6L04rN0ZMQ2p6WUpTTEJUeGowRTU1L0xBZUl2NkEvdmZ0?=
 =?utf-8?B?OXVCL0ZHVXd2ckFQV011LzBlRkpiL0RjTnAzenNGUEhidGg1bElOaU5QVWtU?=
 =?utf-8?B?bGpkSVJFWnFETE9pRHIxRnhKZVJSeThVekZkVWMwYklGb3o3SFVXOTFPNzNJ?=
 =?utf-8?B?dDRQU3VKL3d6N2EwVzJkTjloOFRVaWJOVWlzU0JKZ3dHMUpFQ1FtTFlSV3FU?=
 =?utf-8?B?cnhiZS81TnFNQjRtZjVhdDhXdWY1UHdRclUwRDVDemF2U3hvZC84VVhBSlE2?=
 =?utf-8?Q?zbndTyLqc2b+zAPte13HL9Ren?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d6f223-5473-4087-97f8-08ddca3fb478
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 23:21:52.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNJ9AAqPzKIXBM1dSn3ebheAfZTxj3NUxFJPZlVSjIal3AIewkAnyf9R/WFRfD30qfoKARdJmvjGGziWrhBrUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951



On 7/23/2025 5:30 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
>> CXL Flexbus DVSEC presence is used because it is required for all the CXL
>> PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>     Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/pci/probe.c           | 10 ++++++++++
>>  include/linux/pci.h           |  6 ++++++
>>  include/uapi/linux/pci_regs.h |  8 +++++++-
>>  3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4b8693ec9e4c..5d3548648d5c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>  		dev->is_thunderbolt = 1;
>>  }
>>  
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS);
>> +	if (dvsec)
>> +		dev->is_cxl = 1;
>> +}
>> +
>>  static void set_pcie_untrusted(struct pci_dev *dev)
>>  {
>>  	struct pci_dev *parent = pci_upstream_bridge(dev);
>> @@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
>>  	/* Need to have dev->cfg_size ready */
>>  	set_pcie_thunderbolt(dev);
>>  
>> +	set_pcie_cxl(dev);
> Per the comment in the header below, in the case of upstream ports and
> endpoints, this should walk to the parent downstream port and make sure
> the cxl setting matches. I.e. with hotplug the downstream port may
> transition from not-cxl to is-cxl. Update downstream-port parents at the
> beginning of life of their CXL child-devices.
Ok.

The check you describe for EPs and UPs would be in is_cxl(), right?

>> +
>>  	set_pcie_untrusted(dev);
>>  
>>  	if (pci_is_pcie(dev))
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 05e68f35f392..79878243b681 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -453,6 +453,7 @@ struct pci_dev {
>>  	unsigned int	is_hotplug_bridge:1;
>>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>>  	/*
>>  	 * Devices marked being untrusted are the ones that can potentially
>>  	 * execute DMA attacks and similar. They are typically connected
>> @@ -744,6 +745,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>  	return false;
>>  }
>>  
>> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
>> +{
>> +	return pci_dev->is_cxl;
>> +}
>> +
>>  #define for_each_pci_bridge(dev, bus)				\
>>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>>  		if (!pci_is_bridge(dev)) {} else
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index a3a3e942dedf..fb9d77c69d5f 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1225,9 +1225,15 @@
>>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> +/* Compute Express Link (CXL r3.2, sec 8.1)
>> + *
>> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
>> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
>> + * registers on downstream link-up events.
>> + */
>>  #define PCI_DVSEC_CXL_PORT				3
>>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> +#define PCI_DVSEC_CXL_FLEXBUS				7
> Please, let us not end up with multiple definitions for the same thing
> in multiple places. I note that Alejandro introduces include/cxl/pci.h
> with some of the CXL DVSEC definitions from drivers/cxl/cxlpci.h.
> Although not all of them, I think a precursor patch to move all of them
> in this patch set is the way to go. I.e. drop all these PCI_DVSEC_CXL_*
> versions in favor of their existing CXL_DVSEC_* versions.
Ok. I'll create a pre-cursor patch moving the CXL DVSECs from 
drivers/cxl/cxlpci.h to here. It will include code fixes for those used and renamed.
-Terry
