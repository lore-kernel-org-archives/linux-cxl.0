Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EE29993F;
	Mon, 10 Aug 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354290; cv=fail; b=gC0LsYLvKopUqZzzqm6iz0nvOE8BT1zTt2sio4rJ78E2WBHSaRv59A4hAzcnQ5jw55k2+W2DR2oDCuy0dwfbjMqNuVxCBnSk9cskKb08b3z6uSdxpKelisaXpyvXNJWlOgsp0Im4rZO9MfZe+v6nIsC6sOvwy1k6j7z00PFkPdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354290; c=relaxed/simple;
	bh=5Lc3YIRRqp0KGFEYmBcQD+vM4gzdpg4nkRpBs4R6q94=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TaTBIbrXSAMYwaTDgKjRbu0jc15p2VVFKF4h3s0V+XL45RzJTlptCtzTbhsQpB3e7cUUIvefa3jwJiku/OS+ZtGSl0GGXsUCrgmNVSKQWBkxvEqKNaNGzh1CUuIB/ewyki4PUyzZ8flaw2rWjblpKm2Whvmv24gj7FoowLi/Yko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OfgAMtEo; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OfgAMtEo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxteqtlNfAzXGGl6CWtpJ+GNicsnzGiaocFO2dZhqG93/JiaZ4n/JVATaOF9199rUvWEMawc2AusQQYCozj/KOqzxchX4HHYTh9ZTc85Y3oKJyH/8cp5mLjzslyjA4GnLskWyHVqrBnKBZqQRPFCPqwjbXvhg8QW0wKvvky3f5WfHODulEhz1iZXFDQe3iv+2cMJWFy1bUOuXnh4I8xIqjk6khUjRG/UfyuEFZRbJf2AFpriQ8kmS4g5JwwtuI+TVACZ5E7Xxl/uTkpkMa+J/k9/IcWBFrEz3QgHq0cyUUmXWZ0uoD0sl0hEKH35LBhv6jgFg7rXicJYTaqWSpR/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTjsv+7x1Pj8+O0VbxLKtDJL8jR/9fTRF1jBkxsKTCk=;
 b=kncpxjbklpI69L7fqs576CMWJPHtETVaGGnP9G6KUobVHmbcZjJjCxEpJxrFZSaxHXfviNPhCrBDG6Hrd9MIfbHDDd3pEjQn9S/zasDi7Iz8gtuKbecDuB0BXE+73hXtlD8MpEsNDPxRaDpSIc9U0xYVl8n1rED4lWyqxvtRhKhFaZQyHKpioLZ3uGXgLktKSUVrbjxAwC0IZTmhq3lzGFGYXVVhT6wxR5YW73Tz/UH1ggtCG5HEQIj/wiHaP4JgqcnPtMFz4+XKkrj/WH29qlE5X5hDe0mrzI0qUs1lIPPBjL6gZhj3ZeYUVnWjCL+Q7CkntrXTKZTErGkSoIo97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTjsv+7x1Pj8+O0VbxLKtDJL8jR/9fTRF1jBkxsKTCk=;
 b=OfgAMtEo/DP7IOD1HJbfGxniCsblt5S5r9uqzBosY1DNnb27AlbMzv2EE45uVohxgyWxj6IxHfhxl9tYRYNuppvi8fbi59HcSa69ATeLbARfIPeSuGBZv9POdnmFpsws9kAq7ieQCA5AEXq2i+Vfas6p8tFkUTveg3msUXsZi0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:31:22 +0000
Received: from SJ1PR12MB6244.namprd12.prod.outlook.com
 ([fe80::81da:c871:8181:9b62]) by SJ1PR12MB6244.namprd12.prod.outlook.com
 ([fe80::81da:c871:8181:9b62%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:31:21 +0000
Message-ID: <645b4aa0-1be1-491c-bbe2-f44bdcd9cd5d@amd.com>
Date: Mon, 10 Aug 2026 10:31:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Fix hmat_adist_nb for CXL
From: Alejandro Lucero Palau <alejandro.lucero-palau@amd.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0695.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::20) To SJ1PR12MB6244.namprd12.prod.outlook.com
 (2603:10b6:a03:455::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6244:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb031f5-c6a0-4f1e-796f-08def6c22375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	/RH2nZ8+efBDXQ4TkfdtUyHSjTnQh9nDncAFjz7yG6iCM0iOfFjA6c3dFbPsDtAUgH+nUUTUAJeH7G7xNlWdabxrJ/CXNpa5YHPTBw04KuGuIV57vfJW/FqkRvn+DL6t9x9+V6zmzttuDjSvrFKP4jUA4gTNb/oqAr4m2jqCoM05Eye8YkAbVa5qj3/3/I/RtnrkFlXjn+s88OFTTkp0rkeBAD6ga0+Vn8GhQqWGf55wwpk1IH37jykK9KZ6EQeeM5i06pcmh3YZp8nWI6GFOXG4j2pn46ck8nFGgAAb3THdFfJilk2oK7wEfViSLzlLyMsNAheaw1ixfreQeTK6BKat3ZKm+l1KPWnLWUWMOF1eIBqjKUNDktoXhgojVFC8Hv9/5PtHFlACEbeHM0DenSFX49gSuBwzlKfssfLUayCHZnKBeu60h/sb7m7JF9snZaa8vsxxXaVQ1UVLuvBJeSbiHujQwzl2TiAYcf8G0bo6UC0NXVSd3PJjMEy5s+ONGKVtvpOQtOHzDqNepk/CErRr1wNoMnibZcqBap3CZlu73FrCdIIfaS9GmkdHh/lJwcDkIkEtOy3MzhfFUAJ4LXk7lZg/nQ9H45LWFX/9raJq1VvmpFnKCAAoAuzsuzVS6IpF+4b+tvS+Tn+im62BMz5kX033wRKFzhHbooKQrlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFjemswVWdCeHJkVU1pQzRmOFdqL2ZJZlR4cUhXNXR3YkwxZ082Q1dUb3lE?=
 =?utf-8?B?ME9ESEMwZ25xSUVoRTZ3MGFmVjFXeFJvZ2lQTVpwMWJMQ0pzaHNIN0gxQTkw?=
 =?utf-8?B?RThJdFdxNk5DVERNWTVIYzlIV3NIZE1WNzA0R09YN1VkUTFzNVYwNFpLVzcz?=
 =?utf-8?B?QTU4RDZrS2tGZVo5SEUzN0ZCbHdrK1hPM3NuUVAwTzJZcmJxUml4a0pDMTRP?=
 =?utf-8?B?aVlaNWUzSDkyaWFMQXBDY1NmWHR3YStlNGVSNTRlWGVwVDgrN0dDcmxNcDVp?=
 =?utf-8?B?eEI1L1U1VXUzSE5CR0xnUndwME5XMDhlTFdnZzdueUVvSENKdGlrVjJWeExv?=
 =?utf-8?B?WFpKbUV3TG83ZHF6OW5qWVU1YUx6MEIzbG5BUmpjTGlhOXZwT1pkaGVpSllt?=
 =?utf-8?B?d2h0MGxjNlhuUFA1bmI1S3oxemllODhLQURnWnYxYjMvMzdjOU85NHFNcGNa?=
 =?utf-8?B?bVBGNlhkYVpNV2pMSzFjaDZ4QnlOTDUvanJjTE04RmZjcExFQWV6LzVudVlm?=
 =?utf-8?B?V205bHlrVFdLc1RaN0lLMnRCWEV0OXNORGYrbmtEam05ZW5EcTdjTW5vekRT?=
 =?utf-8?B?WFZHMDlVMzJYWjZ6V3hEdUN3T1RoT0JYRUlKdmlzMy9UTWtBWFJTb1lGTVNZ?=
 =?utf-8?B?R1ZKUzdNZmFqN2VnT0lVeENqR05xNmtHbk5HMXdhTnpXS1RDTUYyeGhoUmdH?=
 =?utf-8?B?dENsdE9HZUNycGQ3RUJMTzBzU2dIVHMza3RiWEN2MFFXSGVhZE4wdTBWWFFu?=
 =?utf-8?B?a2gzRUx3VFhpK2xHMGxCYkQzc0lINTliOVZxUUcwMHVVcmgwN0hhc2o0WEJ4?=
 =?utf-8?B?VnA0dWRFOUxBd2dmTTdkMHhOSnBTakY5ejZvVXNFcit2MGRaNDIzUDlORGJs?=
 =?utf-8?B?N1dxR0c1d2piUEgwRkREUEdyeWpaODFoQWQrYXMwYnJicGdpbFQrSk1yMGlO?=
 =?utf-8?B?R1dLZFNDNi9TODVtMEpnRk84aG5hWCsyaEZtTzYzT0tTbENsRGx1Yk1oeFZm?=
 =?utf-8?B?K1loSXJlNkZZdG1HMmg2T0NxaTZiSm42RmE0R2lsOEw0UlZRQzJwYUphTTVY?=
 =?utf-8?B?bUtTR0FrYUtiWU5sRnlQdFczdzZSYjFNb2FIamNlZE93OE9ROXA4a3N2SGlt?=
 =?utf-8?B?K05HdXZTaUxFT2pNR0xVR3J0NXZUTlNZbEJMTHZYMnVsMWRkSWJ5ZEJ2RE5V?=
 =?utf-8?B?OFpxKytWMkNiRURLMXZ2ai96bS9iZlN6TEtJOFZNTHBNV09XWVZZb2ZOc2lU?=
 =?utf-8?B?K3ZTeDRXeWcrK0RJdlZ0OE41Z2NuYUIrM3VVZzlEOHU1VVYzQmQrendtK0Z5?=
 =?utf-8?B?MGwyaVQyb2UxUy9WZFhvbmVBeEhYbmtmTnRhb0I2c2wvaFRyaUl1Q1JyaGZi?=
 =?utf-8?B?SWY1cWVOYkNPWkVtT2ZxRUk1TGlyUGxZSUJkS292ajBCTDRNNTVrTjl6NXp1?=
 =?utf-8?B?UFVyUXdmdnZoMFprMFU5T3plVCtGaTNZRGVTd3V5VHE2cDlkd0Zrc3NCOGdD?=
 =?utf-8?B?Wnp2RlMzenZZVmJmMk4rRUxxcnBPbzJXT2pYdVBKd2xoOFZGM0s2WEtpTU5P?=
 =?utf-8?B?am55dEtUa01STHQzR2pJdGI1bGVwVUZEODk2MCtVaUU0UzFjVlQycVBMZGxh?=
 =?utf-8?B?YXFGTEs5dlFtNkpEN1NaTTM2Y1VUWHdqSGFZTzdGZzY2UXM1WDdNajc3TURm?=
 =?utf-8?B?dVpWUTlFR3ljUlZiMldkYzdTdk9sZWt1aEN2WnF0dHFTbTUydzNtd1NFU2lp?=
 =?utf-8?B?eTgrOUJqTXlXbzJXdHRHd0QrdTVSQjZUVkNqSzFSWFpDRjYwaG5SRFlXNDJv?=
 =?utf-8?B?N0VUSVNMNm1IbmFpYUU5NFdERUt0aUNjUmwzcjd1bFp1MXk4RGJDOUo1YytS?=
 =?utf-8?B?d01vR3htM0JzRUdkb0xBQ3NRK3MrOWs3NTBXSUUyRmdrdXhsWGY0dTVFaXAz?=
 =?utf-8?B?R2t2bzR4bGlsemRMd3QzZDVQTHFwbGlEdnViVDlTeGoxcFMzc2VkMjVjUzJH?=
 =?utf-8?B?d2w5ZjhOY21xMzRYOEFXcmYxbHJrUlRrNVlIM0s2V1pMODhaODV0N2taYWlm?=
 =?utf-8?B?V3l1clRxTDQ1NHJuc0xtZ0NmSW0vTTF1Wi9vdzdRemhROXJNTUZvTVRXdDZY?=
 =?utf-8?B?T0FqNTBueWJPTlBMMktUVTkxUzZJVU1xZDlKUjVWY1BtN1VLWEtCSEdzMkJK?=
 =?utf-8?B?U3M4MlMva0pwZExMQ3pRU0pmRUh2Yms5YWRrbTZUNG4rT2o3WHdXdmhHYWV1?=
 =?utf-8?B?UWdscm9EbTVPZVN5NVQxMTVNU3lSV2V0U3JMcDl1QlRHSkV4OHJ6d2lmdi9k?=
 =?utf-8?B?cW9vSFd3QmRGQ0dFUEk5L3V6S0VUdjZZM3JEYTVZKzl4eGJSdkxYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb031f5-c6a0-4f1e-796f-08def6c22375
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:31:21.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8NgKeIwslgdUnh7hVwwhEzC0WMm28w2p3GTs0hOsQmqSydrdjSdeM9bY0BXCvr8EqomCLgwgJDCyiAH/qBTow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332

Hi Rafael,


Just a reminder of this fix which, if not applied, could trigger 
problems for the CXL Type2 drivers recently merged in net-next: 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=997bfb05c919d2c5ee77c594d354f6c61b99ccdf


As stated in the commit after comments from Richard, this could also be 
a problem for current Type3 CXL kernel support depending on kernel 
configuration.


Let me know if you see any problem with this fix.


Thank you.


On 7/16/26 19:11, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
>   v2:
> 	- Add Fixes (Richarg Cheng)
> 	- Change commit as fix for Type2/Type3 (Richar Cheng)
>
> RFC
> ===
> While working on adding CXL Type2 support I found a problem with
> register_mt_adistance_algorithm() which is used inside
> cxl_region_probe(). It turns out my kernel config had not
> CONFIG_MEMORY_HOTPLUG enabled leading to the hmat_adist_nb notifier
> block deleted after kernel initialization without doing any notifer
> block unregister, leaving the notifier chain unaware of this. A CXL
> Type2 driver can be load after kernel initialization and with a kernel
> not enabling memory hotplug, the notifier registration crashes if the
> released memory from hmat_adist_nb is reused.
>
> I'm not sure but I do not think this can happen for Type3 devices
> because the related CXL driver is used only during kernel initialization
> if memory hotplug not enabled. Type2, aka CXL accelerator drivers, is
> coming and the problem will arise with certainty.
>
> I have contemplated to modify how the identified __meminit and
> __meminitdat are defined in linux/init.h, extending the case for being
> empty definitions if CONFIG_CXL_MEM=y, but I think it makes sense to
> only avoid the use of __meminit for hmat_adist_nb.
>
> FWIW, a Type2 device should not require CONFIG_MEMORY_HOTPLUG and its
> memory is currently initialized by the BIOS. Maybe not having memory
> hotplug enabled is unusual and even more with CXL, so another option
> could be to enable memory hotplug if CXL mem is enabled.
>
> Alejandro Lucero (1):
>    acpi/hmat: preserve hmat_adist_nb notifier block
>
>   drivers/acpi/numa/hmat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
