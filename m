Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B2355F5F
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696982; cv=fail; b=Dm3Z63Kwu7gDOHRb/aKfV5H9TEnklE0BEQMeQQlYtqJEDE78Y2arYxMxP0MzjFy5VdpeH0DPqoLKUO1CG8g9sgzItJnInM0juA7Fz1Rl3AL3jl4iqwIKJBKNf4Vc2XsBXLvXFA7keijhZQRbBxZoQVy9hlI/8SyelK8hb8QZM54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696982; c=relaxed/simple;
	bh=flS+wBTdxiOaduPpJm6o7eBtl9V1En6MiLMzYrvmXuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qijf60QPi2JRt2oYkHkx1RbVeOYubagCqlr8x824EbxeCigI+EvpNv8kEKBYW/dOhLFAFz6pJrQOS94crRaWKNUiRQ6HvrBLllcblvP48nn59+Q9orxLGuCPRi5zXz3vVoxuITZKYksf0mVvV9PbjgFWUi2+gFXsAisF7+/GFJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y+NdDprl; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y+NdDprl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7vEu2CCVORoNcm/vbn2+/5BYpj5bqkPv7Q2Rr5k7OMO+2oVzhrK5vCW1ZCyhXpoAlF3WSlHbD8LCK4pLnYJkXb3Gb/Xg0A1tcpHSlQ5NjKOQimLI2B2Ans9G0Fp6fV4ehiO1cxuFI1upR6wNKOe3FzrHK60Br9X5v+sqKsFQbqvB3Hg0uGrSYG9PumBUj2FtP95r4vcRJjwJ60FTaFevSOtIEAbFy3GWUUcg38jt3/U/se7U6ZpNMzGu0jmTMxH8QGD9JatkDg7gjN6QEHACRQCubRwKKp8AtyOLusD5OR/4Xm8LyIAW1uMMDgVCFM2GjHPaAV+qDcCnc3yKj/GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSulC/hSsZ6SgcuOysjidJOJ2JhntndaO7VEcRJPFZ0=;
 b=oCWyv4EppS6d1PINY9DfmR1Ie/USR7594olIS3SmQ0RndH9FtpRi5ZT4wZ6hF3X4pvy68S5d/PSy3FoV5ebHPhqk+ZjSmNRtfSsewnPP5PPh8mC30V1CzjFcpUlCgFqEwXYkoBWzee0fJDgyDX1ch6rmMTTqMwCk6yg3aUQfNMmgTQ9jwi2pcStkAq09l1Z764Oh+74bw8vB6Vj9XarZ9wcHeMRe4NVGueyquENqeWXYcF52harqGEgqP7aAl9Yyu5ihp3iH1B9y9cuBtNM8Rzn2a9hbPggiMDY09sh+TzGoTE7qWDh0Dmhb9fgA3iUy0aKQPuZN31uvYC6gDOLOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSulC/hSsZ6SgcuOysjidJOJ2JhntndaO7VEcRJPFZ0=;
 b=Y+NdDprlYS2RsGkJ0Y5u8zYkbbrWxORGpycNa6YK4+6U0FONNmODxIlDvjyP1Jj6bRJfB5YKsJ2Vyt1dYWSKhMVTmmh7eMkPr66rr3UTL/s9HWGEsKZu8unSgqxbAdeZldaZP+gvMg/PI7gFCczhy1dfA/jhX8MEvfp57Mznuek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 18:29:34 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::cc19:be83:4f32:d44b]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::cc19:be83:4f32:d44b%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 18:29:34 +0000
Message-ID: <41e4bd2c-f11d-442f-bc3e-7198f2a2cd13@amd.com>
Date: Wed, 13 May 2026 19:29:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 0/8] Type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <agS1_WH-h-P61KDa@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <agS1_WH-h-P61KDa@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To CH2PR12MB4199.namprd12.prod.outlook.com
 (2603:10b6:610:a7::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 8982eea3-45c7-46bc-e9a2-08deb11d94b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iEqmMENegnk737h+XQl+rwtKsuvdIQrH7ZxCBH5QpJrR5hpL9Zj8G0q8OM2FFjer0Hxj/m4cFYUMot3KMPgnyrJBZgpO6z7y1QsaaCQw973LjANia+SNHTNLjmYghChjBjhacolrmDug19AdaFtcPHRTvMekwK40kQSzmmUvqgRWRv5O+Aj8klRoQgGxqiXhZ9Wbmu57WgSAmRpCyoEwLDVuO0yrpHIVjxENS/ib3C9m3AiNqxOPX496uZaUGT30D/sKIRuZI0/Xc6/broRHPEHEvL6Od+e6NqjaOnjBYKa+jzCqjbvvbD6XFi1TI22w0Q09w+qJ7hduaerosziWYyOtoH1cBlEbasmXeTLqv87qrpM0CEiCT5RHZdsYrJW+UTc1hB02YueT6icBIB1YGn2rn42keMiz4iDjQDVfQPwIq083Mxwjth+0faPsLlr7EeSQyO8OjlyG9NStnw8hEeSnzdVp0ZBmEiFCE54jiCmJ2AXrrocvSypn7ekNksRfVTaBv+OZeTHZQGe/26fSvfIDNpMgF5/+GsoyOQy3XaoSp9W49pwfa+BzkCjvyJ+pOzh2BPawX5M/keBXDA+JbXKlsyFbZvbzx4O7fRtE93sh7JGlz8uuyfkPmdl9EJmSdLliTwlMsuO0p2vWtC6oN2IWjPvmIlzzXtZhYpMIfXfJTCSnPjdlnphjtf1TlhHMuJgmxmAYw8gP08tCvPFZ5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KysyeUZLWm1hZ25aU3hVaUdtdWlxWWliYktvTlYwNzRBUGtpL2RSODZZZDh5?=
 =?utf-8?B?M0ZCZ2dnRXdFNmtkMnJCcVJyeWVWcGFPT0MyV2ZZSDZNVGJvckNydStPNWU0?=
 =?utf-8?B?c0NJbHcyZ3NPOVpFZ01QdFk5RWtiZjIvV2NtVVhtOGNOeUE2S0lGdTdIYk1w?=
 =?utf-8?B?bFhYTDI4TjlIeklMREp0NTg0cFRxRFFNa0RsNWhNb0lTMmozSDBvQ2doS2k1?=
 =?utf-8?B?Q0EzT1Mzcm0zSGExMHVQcG5POGl4N2FBZGR6OEZRWVhxcEFwZHJ4TGNlRm1I?=
 =?utf-8?B?TjA3ZHVGczlNU1ByN0E0dVQvTG9FaUFHbzZWQjNuRjdJNS8zSTNha3lZT1Vl?=
 =?utf-8?B?V0dZMEJ1UnFiYTY2aUwrdjc5VG9sTXh1aHpzRUcycndxRWE5Z3hIY0toT3Ux?=
 =?utf-8?B?S0RzamU5R2M1cDQzUWx4L0tzaU9JOVZYd29TRlRDbzAycUZMOC9SUW14YWFH?=
 =?utf-8?B?RGUyNTZSMXJqTFhDRmo0TWRvK0E4S0pBZlBOeDNSd1JWaUQrd2JlNm1PM3RN?=
 =?utf-8?B?ZlU5dlUrVWp6NVBkT1FMQk93SGxwQThlOFVpRXRYaGJnQmZoMXhaMFVmZ2tJ?=
 =?utf-8?B?TFV0TG5KNEFwYlU0bUgyUVpIL0hqZVFlQnh0SDArUlZmUEZkNWRPYXUwMzlU?=
 =?utf-8?B?Z0hQajV5L2tZbFpqRFAyTkhQQ2Izd2orbUtoTU03MXlVU1VWczEyUTNNdVVW?=
 =?utf-8?B?QXFYY1NGM25IUFBpdEgzbGxKVnVTaEEwSnlMZ3ZVQm5LalBGRFU2MkVlaTYr?=
 =?utf-8?B?UzhSUzl4QlYvOXdaS1hxTS9GZTRzejVIY0FycU43Q2FzVGZhdWxDdTgwd0Zs?=
 =?utf-8?B?cGhXRU1DZjgzZWJZSzJLY3NyV2diQmVaTktCZlFYQSttZmMrUHBDeFdadmdt?=
 =?utf-8?B?STJ1TFpZbFc5NFJMYkRmcHp5NThhL05Oc044TUF4ZWdUdWFEdmQ5TjVQT3pY?=
 =?utf-8?B?QVlIcjEyV3U3TVdJODMzTjg2QkdGKysvek91UHg3VXoyUVlsZUxzeGk3SkUz?=
 =?utf-8?B?NXkzYnQ0Ync3MFZHWXBucFZ2K1J5cnA1VnpWNkdCY29TYUpYOFJHWmNScjF3?=
 =?utf-8?B?OGFudFpKdmp4SHo5ZDZ4WEtRWkNBNTRvYlVQSXA5ZEwzWDZkbHdVMkU5dnBk?=
 =?utf-8?B?TGlTVHNEbXkzbHhCai9vTS9LSlFVRzZ0dGFDZUs4VnJXQW1OYktjNGgyelcr?=
 =?utf-8?B?VDFwaE8xZmNRWWlteGFsV0RhUDE2OUUzWnA5NUtIbTlaNTBNZFB3V21wdFlL?=
 =?utf-8?B?dWhXS3FKUUZQM1pMeHJCc0Z2dUlRVkExeGRNa3E1THBHT2tsWE1kSEVuWVh2?=
 =?utf-8?B?RFZmU1RFNEwrRGx1NUFQb0FuSzBrWnlZZ25FS1pJVTA3K2Vnd2RFNHNmMVFI?=
 =?utf-8?B?SDdPaUVBVnlrYTF4d3dCRmRYeVBaUy9hU3Nna3djVC96ZllKNFdhRkZ1T2xr?=
 =?utf-8?B?Y0RYNVlZV1NLa3RDV2dNWmxiR3BENm1RNjQ3Y1JnWlRDQnBrUmRxMDBYZlFt?=
 =?utf-8?B?YWFuSU5TYkpIWFUyMkFlSWZwVnFnc2RZT2JPd2E1RW84MGlQU1o4RTdld0NZ?=
 =?utf-8?B?Zmt2L3dwWENzbklUNXBGUzNRcmhTMm55eEJpeW1qRm5WRHN2T1krQ0I3YUY0?=
 =?utf-8?B?ZzBhZklubm9QMlVQemRhaFRnVldJS2RIT0RxQ2trOWducmR3SVVCU214ZGQ0?=
 =?utf-8?B?THhIeHJNQzRjZjBiR1NZcVVOTnB3MjFJaXFNcElLZEJiYjVObmQ2TStnZmE4?=
 =?utf-8?B?VWNzdUJ1blNQNHlkRjExRVdGRXNTYU4vM3NIMjI5Q2xKV20xKzBxQzhQb1Jy?=
 =?utf-8?B?RVgxYWJjRG9zWkZHYjVCeGtJaVF2YjRTTytBSHVDSXFBeUdjdUp2eFdQcDFy?=
 =?utf-8?B?dTYvQm41eU9aeFFkZE9lMWdnMW9XRDVEcUFvUHJpU3NaT2hmb0JqcDV3QzhD?=
 =?utf-8?B?aWRmSFl5Zm5vVGtWSXovWlJ2UGZoc0dBUHJrR0VxODdSQ0hoSlo5WktoSlhX?=
 =?utf-8?B?L0lKNldpZ1VvdlFxanFuM3E4S0ZMOG9qYWsxZ1JtUGxiNVN5cktrZkRWdWtJ?=
 =?utf-8?B?Y0tocFRocThleitRbmVhT0VCUkV0c2VMRXE3SS9ERldudE9WcmFNeHNoMU1M?=
 =?utf-8?B?b0pYRUs0YnRvNjFFRDFaOHl5SlluTlZMR1hhVktTZEx1UUFhR0F5Yk9TKzVR?=
 =?utf-8?B?cDJUekhoMEw5aGdJM0tCbmJ0ZDIxTmxDamhPRDRmbWZGM3VMMExaY2krNDRz?=
 =?utf-8?B?Mi9rYmJ5TnVYWlE3ZGZ5aXExZUMwa1l3MDREYkwxbVFobi9TR1dBT3gwblBh?=
 =?utf-8?B?RFlqbE9FZWwvTUVPaDZ3aUVESmd3RlVhNmZLa0RzdU1pc253Qmtwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8982eea3-45c7-46bc-e9a2-08deb11d94b3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 18:29:34.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoFhH653YaAnkKXXD415nDzwejwQFqcpJvauSc1GqFZQjFPSL76CwcYodL+IREKThC4zdlgirfqFiO4JFbSxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978


On 5/13/26 18:33, Alison Schofield wrote:
> On Thu, Apr 23, 2026 at 07:05:20PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> I feel this version suits better a RFC based on v25 plus the changes
>> introduced. It tries to address the problem of user space actions
>> triggering accelerator region removal, and extending Dan's approach
>> in here:
>>
>> https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m2d9e5c59ce4873641037f9bcd2f70d5679cda03c
>>
> Hi Alejandro,
>
> Can you spell out the recipe for building this. I thought it was
> this set plus Dans incremental, but the comment above says this
> set extends Dans incremental.
>
> For my review and IMHO, a single set with both you and Dans patches
> stitched in appropriate order would be useful. Please use a base
> commit that is a major tag, like at this point: 7.1-rc1.


Hi Allison,


I would not try to build this knowing it is unlikely to go further 
without Dan's approval, meaning not a potential merge but just he liking 
the approach.


Just in case you still want to do it, this is based on Linus kernel 
tree, 7.0.0. Using the commit base at the end of this cover letter 
should be good enough.


Thank you.


> Thanks,
> Alison
>
>
>> As discussed there, the protection needs to cover the accelerator driver
>> handling of the region physical range for things like ioremap, and to
>> offer a way for such driver to undo things or at least stop using that
>> very same physical range if the region disappears. It ends up merging
>> several of v25 patches into just one.
>>
>> Another change is linking the region release to the endpoint device and
>> keep with Dan's autoremove. This makes unnecessary the previous cxl_exit
>> and similar actions are now performed inside region detach callback.
>>
>> I think the outcome is quite promising, lowering the accelerator driver
>> complexity regarding region handling. The cost is those new callbacks
>> which I think are totally necessary for doing things safely with the
>> region by the driver.
>>
>> I have successfully tested the cases of cxl_acpi removal while sfc
>> driver remaining, and cxl_mem unbinding sfc cxl memdev.
>>
>> v26 changes:
>>   - patch 6: it implements all the new functionlity described above.
>>   - patch 8: region detach callback invokes a new sfc function for safely
>> 	    stopping cxl-backed piobufs use.
>>
>> Alejandro Lucero (8):
>>    sfc: add cxl support
>>    cxl/sfc: Map cxl regs
>>    cxl/sfc: Initialize dpa without a mailbox
>>    cxl: Prepare memdev creation for type2
>>    sfc: create type2 cxl memdev
>>    cxl: attach region to an accelerator/type2 memdev
>>    cxl: Avoid dax creation for accelerators
>>    sfc: support pio mapping based on cxl
>>
>>   drivers/cxl/core/core.h               |   2 +
>>   drivers/cxl/core/mbox.c               |  51 +---------
>>   drivers/cxl/core/memdev.c             |  81 +++++++++++++++-
>>   drivers/cxl/core/pci.c                |   1 +
>>   drivers/cxl/core/port.c               |   1 +
>>   drivers/cxl/core/region.c             | 125 ++++++++++++++++++++++++-
>>   drivers/cxl/core/regs.c               |   1 +
>>   drivers/cxl/cxlmem.h                  |   6 --
>>   drivers/cxl/cxlpci.h                  |  12 ---
>>   drivers/cxl/mem.c                     |  45 ++++++---
>>   drivers/cxl/pci.c                     |   1 +
>>   drivers/net/ethernet/sfc/Kconfig      |   9 ++
>>   drivers/net/ethernet/sfc/Makefile     |   1 +
>>   drivers/net/ethernet/sfc/ef10.c       |  72 +++++++++++++--
>>   drivers/net/ethernet/sfc/efx.c        |  14 ++-
>>   drivers/net/ethernet/sfc/efx.h        |   1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 128 ++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    |  31 +++++++
>>   drivers/net/ethernet/sfc/net_driver.h |  12 +++
>>   drivers/net/ethernet/sfc/nic.h        |   3 +
>>   include/cxl/cxl.h                     |  25 +++++
>>   include/cxl/pci.h                     |  22 +++++
>>   22 files changed, 552 insertions(+), 92 deletions(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>>
>> base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
>> -- 
>> 2.34.1
>>
>>
