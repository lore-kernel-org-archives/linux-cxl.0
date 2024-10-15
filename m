Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327391B85D7;
	Tue, 15 Oct 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982331; cv=fail; b=XyQEjyP1sFH6DP25cTJhLe52cropJYvLWGym5n+TNXJWiL1bV/ms1kIH8cXcCvhQa29Ew+52xPQ7XUSqoqL8aVE6L0AnTXdoM4spYyx+eHn1IMSQhDkltv3lq3NcuJzp7oW91KFsQirrj6MpfmuUeAsvVg7JA0DwfvX1bwCq4T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982331; c=relaxed/simple;
	bh=Io/N4oH9nsJH/B6FeXxiIaYafkdBccPQJgHVMpLC25g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t29JRrKm5JGwnj35/ZmXC4DdW+QQUEj4f+DjjcmJU/mFGIVXHMcDd8bDmVZ8EOtEz/2MEty+sAHQSeQM7hVaABrSpDKX17QKFDBprROHRJPalRw07uzqH4+NIyTYqzZ02HOhx39B2N1virIlR19Ke1HD1zdlHQqF5G0hnX8yVo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BZCP9IPd; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BZCP9IPd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw/ZRdO1unjlirQsCS60L5HFGmQSbj1aiHCcnKjjDSEpU+ZVQ9o9Vx95fgEg145faHz9vGHoe1MSyCgBJYdzetUWmDrVdtX5VnmKjxGAFPrOCTJ9VDcgIfyUgT1yNKL6D9Du+Y41QVWmjY9jhi8C8P9iQFDjzUJ+3ddtHyhKpzg52OKgKjojDMa/UapHKRzCBdcKMR1CsTXTLtPE5SMZioHcOG0RH1fbdUHqO5056HnnOqt1bp7MPfEswxDoQ3GiB7I5ILsvZ9De3lcf9n+jYq8DquT+HFkVaJtO8UFTfpKbHsSVU9pjVHlVPA2ZqYgqydGnpNtT7rRRW8rzLcE9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQHWnM0RWiO9fukuncDi879QYjGOGtxxNtbNnqmcyyc=;
 b=yOu7xIYvZCiJHNuW3f5J5BliQ3Jjwip995UPeDFVOV02rfScpWso5aQSN5Q+2uxBO1At/8lmWu/lDauTMFMp8aX2GGi8+XMVz1ZK2xNDfBfjoTfB4uvT7TUK2AG0rIaZG3iUeTgFPINWpdUqTiIWNNqbW40zaWn52mWy6lr87fVYoySRlZh30rha/U/RtTht7T6cQsiNu0BR0a5ilyNZP+iYiXNX0k28I4wKlKQMUfj6EWFWd/10G3mfsnh3LBZ2wb+xu19s6fZ4BhXzJSLR+dK1TWCnS/35YVAUl0JfWjHBAy8679ZUoHq5wegbPaXNZxU5cxDDyWhsT6eXClqzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQHWnM0RWiO9fukuncDi879QYjGOGtxxNtbNnqmcyyc=;
 b=BZCP9IPdNOr19Qufut7wHdXLAs4cbtSYxZyVK+ZefREgGDMGj17OV242AkLT2020eyMSQE3J4cxeaBnKwTNulfqFdCD94NVhOOsJvrHzIXQ910QFNTw18xx120hNBLin6dx+M2qthGstmaqSOwpcW5a/l4w/k4V4MLa9XYn8Q7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 08:51:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:51:47 +0000
Message-ID: <d5233135-9d70-9080-c7eb-0906f07e5104@amd.com>
Date: Tue, 15 Oct 2024 09:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
Content-Language: en-US
To: Huang Ying <ying.huang@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-6-ying.huang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241015065713.308671-6-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 456c039c-1a30-4804-4649-08dcecf699fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGZQMDhOS0lmbkpHY0UzSnBsWjFqb0ROOE1ldjRKeFA4OTliOVRHVnQyQ2Zn?=
 =?utf-8?B?OFdtYXRxcVFKSW8yTFQ3RE5RVElBUEE4WGpBdEU3QUdZVW1yWW4zOWlUdU9L?=
 =?utf-8?B?UEVKREJNUWhYTE1zUWp2U09Db1hSNUE2ZFNacE5uK3UyTXlUMW1qN0gxOUZZ?=
 =?utf-8?B?eFU0VWNwWnBWZjltL0ZXTmlBZTVSMW54a1VJREI5L3hXNWZQYWpCMVdWUXZN?=
 =?utf-8?B?VlJoYWUzQi9xOEY1ZGlRUnMyQWVnNnZ5OHMwVm5zUEpub0xzZkU0ekxnbnJR?=
 =?utf-8?B?bDRNWFlENDlLaXB5VWsyWUREVTdLUEdiN0JjK3Q3M2ZtRm5ZU0NTQmRJUUNt?=
 =?utf-8?B?a1RxcDI5TVVNSUlrWDdZZ215NSsvaHZJdHZoUW5iZ3l1ekIxT0lFaVBoejNo?=
 =?utf-8?B?cGZzRHVDQ0ovZXk1VHEvL2gycjFnK25xM3FCYXhLMSt2YllMdnB3NWg2N1cz?=
 =?utf-8?B?M1dOUFdkNEt3TElRRFJ4NGExekpTb0JUNjE1S2tiazkvVjE2T1FJRi9wY2xS?=
 =?utf-8?B?alNxenVvaG02T2o4Q2pRYVY3OGdZRWpQM0dqRjQ2Sk9tTnEvWHlVdDJmTUo1?=
 =?utf-8?B?QTFyclZwOThtdjVBRVRqWndRUUFWRVg5SVdMdDlzbklDWkhUcGpKRUpTcGkz?=
 =?utf-8?B?MnFMSFdTR0F3bVpVby9HR2FnTFVRTWxYODNoQ2VBZUlHb0tESXB5YmR1cjl6?=
 =?utf-8?B?bWZNSXhUU21LQWp5NTYrQXhuZDlxRXhGWCt0Y0Jxb0dZMERycGtwWTdiYU8y?=
 =?utf-8?B?TWVGMnNjVHptNWpMV3phSWMvOTE0UDlrd0RuK2s2TGF0RFgyU0Q5eXVYZ2Zz?=
 =?utf-8?B?TXRJZ3FpZ2pQRHRZdThQeDkxaFEzbmJKSmpJdFFVY01acEwvTmFaMDZKYVVV?=
 =?utf-8?B?ZXoxNUpNWUppTjdEb3dJV2twVXlKRFJFNURycWE2bEJ2U3dZOU5Sc0VnUWtr?=
 =?utf-8?B?YkFrMFYrWlovNE4zWEZDZDV4eEMvRzN3SWtnMFd4NDMydkFFdk8rS2JQQ0x3?=
 =?utf-8?B?eFA0Yk9tYTA5a3VJMG5GNDFrOVplOHROb243OXdLWG9oK1JVQUs3QkJQQTNK?=
 =?utf-8?B?ZjJtenlOMlZ0SHdkZ0o1cEZpK0ordmFydk1LYUsxK29RZFpFZ0I5ZmVRT3dS?=
 =?utf-8?B?ekZaMlE2MmN2NDIrUVhkamZ6cnRya3BBVXRLWGNaZ0EvZFo0ZS8zckVmdDdO?=
 =?utf-8?B?UGdJVEpLZThJYlQ5UUcxNUdhREtjSDl4SnVnd3ZoazU5Q1hmdVZ1UHRjaCt6?=
 =?utf-8?B?UlBxNFlPMU5TbTJmZFB3V01CT21yS1hqcG1qOStmOExkMjJFdTNwQTZ4RHVn?=
 =?utf-8?B?cVlmSzdkYk9pNlhYU0U1dW1odWtJZ3QwT0VQYW8rVEIzVzZ1dTJsc0dxUUY4?=
 =?utf-8?B?d3pubkVpc2RoUGo2M0JwbGVMMXAwN3k1cGxlcHNzbEdCems1NXF4NEVZSTYr?=
 =?utf-8?B?bEhQcWwxeWJ0VTA1dXFySUF4WTlmdHFVQWg2dDM0UUcxWGpQMHpWNGIvT2Nv?=
 =?utf-8?B?ZFlKQ1FsTk8yQ3hIMTgrTVZxTjI3MmtnK0c0OXpCZnRhdmN2MW9zc3RMQkJs?=
 =?utf-8?B?YnNJaUVraUlzaEJLd2VFekYrVlBaVFFqWVNaNGQrSlpwbG56ZjRpejFsQWFm?=
 =?utf-8?B?eGU0ZmJpaVFSQy9vM3VBVldabHFwR1BMMWJvTk1xZFd5MzN4QW4zQ3FJbnpS?=
 =?utf-8?B?S0pvOGNXOFVBVEVZT2drWGVTVFM5Q0c2clJUMVNLZUFQdnN5eS9RcWVGYUU2?=
 =?utf-8?Q?Kv2rEbaLh/WgrkUf1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzdKVkZoMFVOTitmMzh5QWozdElSUTNta3FSOWdaOWwyalY0Y3Fha050YndQ?=
 =?utf-8?B?TW1EZWttWDJWc2JDQjU4NVdlWDBHT0dGRGdUc3J4eWRMcUI1YXhqUVFhd2xW?=
 =?utf-8?B?akJNTFg5a0lyeEkxTWxqQXJiUmdnS2J5V255clBid0NQK2xJVkdyT21zdWJI?=
 =?utf-8?B?Mm8wQW53NmRkb1JqaGJONkFVTXl3Y1VCMCs4bDRaK1M4dlQyTXdqdkZYM1ZJ?=
 =?utf-8?B?cmI4R3NCQWgyZnFaa3N3V0RKWUhuajBIT0w2QkVlOUlpb0ZaQkpndk9QWTVP?=
 =?utf-8?B?aGxLMkFKMEJndE9JcGxkZ2xsTnhtWG80cUNxQ2Z6eDlqRU92N2hIR2F3Rm5p?=
 =?utf-8?B?YnVRRStUQWUyVWdBT214ZHlCM1lZakxxTTA4cFJQOHd5RUVKRXM0R0lISXBH?=
 =?utf-8?B?bzBUNkxpTEFGMkFFUmFjaUQ4OTNNaE42dEltUFRIVWFaQS9VRGlwV3Q0Wmp6?=
 =?utf-8?B?YjNqYmM4ZUx0ZmtUU1pjLzEvdEFtcHNVUWt6emhHSUNlUytudG92Y09JVkZ1?=
 =?utf-8?B?MU1hVFYrazB4dGl2N21qQ1VXQkNGR0FZM1lsaktTSWtjaDl4Rkl2dEYxNE9D?=
 =?utf-8?B?bHVxeGVMTCtKb1g3VmQ2ZFl3VVBTVXQ0L3lkNkpERy9xdURUdWhzSVBoaFpI?=
 =?utf-8?B?ZHVRRlhVaFJJZnVKN1ZXVkppbWU4RFZ0UWVxZDZzbmpyQjIxYWNHSE1MSUZu?=
 =?utf-8?B?cEZ3Vk1aTyt2dTZkVVJIeDZ0L2VrZ0dMU3FtM1lsdkxCeXRoY0JHMWhkMDlR?=
 =?utf-8?B?SElENEJmR2VtUUY1RGRzUTNHUVJydFMzU3VnVDlaTS9XNWp5WUl1UmtTT0lS?=
 =?utf-8?B?SU9jNGxVdmthV0xsN3BEZW9LRHdKKzRUVkdSczV0MHc0ZmxGeXp0SE9obnJi?=
 =?utf-8?B?bjNJOCtDWXNYSWdpVHdISmFES1JUc3A3MkZTa2FoL3ZoY2VGRGo3QTBxanlz?=
 =?utf-8?B?NHhoWEZRV2R5eGF6bzlSNXYycm4xT3VKMkYvaXF1WU5FclhhOGxsM2dBOUQ3?=
 =?utf-8?B?YWxpL1A3QXJLazB4MHhhR1dVWldsRmtsRi92VDZsajcrYnczeDNkQnFtTW1I?=
 =?utf-8?B?S09LckFrNHNidVN6V0hsekJ5SGYzN0VkbHFieEd1ODlnV3I2Ulo3VXFWTXhG?=
 =?utf-8?B?a3d6THpVZDdQNHFLWXgzdHFnVDNuaDIybHM4QnBlRTUrTXZCT0prblp1aUY5?=
 =?utf-8?B?Wml6UXc1MGppN2hja2dVTnM3dUllUHNqQysvWWRpaHFBZm1jU2ErZW5jcDZr?=
 =?utf-8?B?aWo2OUFrOGQwRUk1Nm8zb2hka1d3MFlsVEE1WGV2SXlZc2FLcWpXdTJtdGpZ?=
 =?utf-8?B?Q01rRVdnWnRIRGwyNjI1Q3l4V2N3WDA0THZvUkQxUmRzamllVTNuZGEvT0lL?=
 =?utf-8?B?a1JybUYvYlhrOWxFV21RalVQeis5VUJrQW1Oa0RaOFhJVDZLSVdkSkZleTFB?=
 =?utf-8?B?VkR4WFVTUlMwZmp6ZnczRm5WYzBudTdYWjNzUzZNL20xRmQxdENzOTF5aEpm?=
 =?utf-8?B?cjB6eUhENmIyMlVkNVczMGp1RVRrcGg0RldaaGpTckoyZ1FnTU96clVqeFU0?=
 =?utf-8?B?dFZ3bEVneENucEtxUHRRcHBTcVlHdW15ZGVldGZrRkhsNHBBb0grZTRsc3JY?=
 =?utf-8?B?ckNVUHVxa1ZGMlNhTHltREFTVGlYSEcwSU1IcGlqK2cwY01ZYVdidjUwMDgz?=
 =?utf-8?B?S21tN1JMRG1Ic3BCalgrU2VJUlpLa1A0MlJCNDRVQkhwaUY0a3JTdk1mNVl5?=
 =?utf-8?B?bTNFdG42THkrc3dJMTdaeE00M0VGQVBZcDFkUU4zVmNHWStnaERXeXJRc2FH?=
 =?utf-8?B?QTltNWxYemdLRVNDbFdjbTljWUlWMWVxeVZON0ZZOEtxelUrNDNUQ216bWlm?=
 =?utf-8?B?ZFlWQ2p2TjZBV0ZQKzRoek9uY2NOU0hCSVp3N1Q3SDdrakl3WW1BdnJRWHRu?=
 =?utf-8?B?aGtjTE8vSk42Wi9hQkh0YWdRblRMZ2Q4NjdsVS90V0tXWjR3ZzYwVGllSzFs?=
 =?utf-8?B?blJGbmRpeUpHcWdqNzlHQmhjOUsxNnNhUFJRZURabnB2VnRzV2VYbkZqdVN4?=
 =?utf-8?B?WElhaHkwSFB6cUx3V1oyb3drWHJIWHh3VmVDVGpaNkp6V0J1VWZaeXYyTFc2?=
 =?utf-8?Q?wTA3juZIaQsogxX0Mn+zi0LDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456c039c-1a30-4804-4649-08dcecf699fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:51:47.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x57H49WkwaxsijP/yRW/nYWsNIpNruoiV5qhHLRWDNAdhamyUBDiX75KeOPGXeeIeALwtCdiJ1X0Jf5aSHHbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

I did comment on this some time ago and I'm doing it again.


This is originally part of the type2 patchset, and I'm keeping it in V4. 
I do not understand why you pick code changes (you explicitly said that 
in the first RFC) from there and use it here, and without previous 
discussion about this necessity in the list. I do not think this is 
usual, at least in other kernel subsystems I'm more familiar with, so I 
will raise this in today's cxl open source collaboration sync.


On 10/15/24 07:57, Huang Ying wrote:
> The memory range of a type2 accelerator should be managed by the type2
> accelerator specific driver instead of the common dax region drivers,
> as discussed in [1].
>
> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
>
> So, the patch skips dax regions creation for type2 accelerator device
> memory regions.
>
> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>   drivers/cxl/core/region.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d709738ada61..708be236c9a2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3473,6 +3473,14 @@ static int cxl_region_probe(struct device *dev)
>   					p->res->start, p->res->end, cxlr,
>   					is_system_ram) > 0)
>   			return 0;
> +		/*
> +		 * Accelerator regions have specific usage, skip
> +		 * device-dax registration.
> +		 */
> +		if (cxlr->type == CXL_DECODER_ACCEL)
> +			return 0;
> +
> +		/* Expander routes to device-dax */
>   		return devm_cxl_add_dax_region(cxlr);
>   	default:
>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
