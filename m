Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744837F8D6;
	Thu, 27 Aug 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852693; cv=fail; b=iTnL6zkkzKJvTRMTB5WmhxCza1ktZFjI1kL1h6I4lBDiEb/Ds2IGbRiexNfqt3yjY3kC5z2U0RtRcItQvx1+gSegYnUVbJzGoSVAyf/jWvSXcF//wX9pkZxTHitFi4sJF7/Agg2DVK5mZnXtFJTnBti4RRzGKwTbxUWkWGEm34Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852693; c=relaxed/simple;
	bh=gwRB5pt8QYLyYOAK1h++158ZOFcKb2SwSbDhdVK7fzM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=utnG+gEG0bOaIEluQO4eImsYoo7veS6rv5VeyRV5/EwI4cxXAZm6tp8plfg4jZPjJrvNv1akNpWULoBKh+4A7rTG//i4XOIR6U6LY48AJi+0DNyMNEgDgGazNPwi6wAIlVS15tSyp9VO7ojCaGKEFPY46lHnrng5cBNZ+u15xFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M4gMEpmp; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M4gMEpmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOhUOvXgBwUjr/AOgbvdbhSy8FGjJ0eniCm2PmRf178zJXCNm+knZFum5beZAl+KGsgONTBaoRSRrl6FFd/FV4AfnwR7fop81UQhVdDtJuVBkxwdBHjrgjBkG4FM1BMj1Cd0P9//qXwhFvsQxOs3zlDFi1NtWY7OQzYBU+FdJfj1EXuhAJlzrnIl3UK4x6n6d/gcMMm4CNRx0oFwNUHnIT9R/yXfQW0YEIX0ZU3ZgVKMsyJuBWWc1u/R8lTQvbH+VIWRZNemGe7Unp/CaSLOy/BSi8xW8SV7Y6b2KpTSMnPKksPJ0JXRSG/3FD3GM9f1UCQelLSIzwRlBuqDKrwWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp1LUyaAD/cdHPOVhVgcm4/NybBZWA+QEmAPFRNi9mc=;
 b=EEVjORn+stc/K5G249hG0RR22sNLwiNhQ3aGaVK9tBboRHiiJIsagU0quHvuSWrxj7YCADp9EWw2sgWzUZwG0ssEdIb9v58ikXx68r8IdCMqrHfgkGRi1GJPDBbL3qjQ3TNNYZGjUeaoaLHLA4YqT8fzbbrM/JpXeC8PNGanyY/z/RNIEOBVDa/0wag2oHJzwF3KigFma2IQETefE7cVANVq2e3Uj5622zdTvQ4IIrM4qgFfMKf4uZEWSRlp+VAH5lcGVYUbZwXnXE6C4WJJY2pztTPxQiJFYk/GuCCnm6yUTCbeUmWn3N9gw4OqpfnQA9CJ7jO9hli4v707Ge/8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp1LUyaAD/cdHPOVhVgcm4/NybBZWA+QEmAPFRNi9mc=;
 b=M4gMEpmp53qWRAwLgTFPm3Ps+0SeIBwz7CJWVk4ysXgmsI/huxzvILehqkwrfeG7ctxI9RfyD/kPBIb90tJBMJTmm1f0q2ME7faZByz4tb4T05cYIp+bf7gcKz4PcDl6z0pY2+/FELS+rYVYnKutvtZkS21FqPrgMTd4pFMyGIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 LVUPR12MB999184.namprd12.prod.outlook.com (2603:10b6:408:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 17:44:48 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 17:44:48 +0000
Message-ID: <2a7d2d8c-ff02-4f2f-94d8-21d64dd77f82@amd.com>
Date: Thu, 27 Aug 2026 18:44:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] cxl/memdev: add support for mutipf device
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
 <aov-jfhJtNtZJxlN@MWDK4CY14F> <a313b340-9263-4204-b0b2-bc492cf746a4@amd.com>
Content-Language: en-GB
In-Reply-To: <a313b340-9263-4204-b0b2-bc492cf746a4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0159.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::9) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|LVUPR12MB999184:EE_
X-MS-Office365-Filtering-Correlation-Id: f40c5689-3189-40c6-a280-08df0462e3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JizKFK0I6z5wrOaFBDY20tPcxPQOLhmYB8k5fPtDjZYC88BLx6ax2QldrYVRIyMGIekULRaqofdTlzp3No9TysHys2xHUPCSt+ssXzPze+MqIxOUT8iqGk5p3Wqgsh7xAshtmofS6VvHZVrwRpby3WS6TQ3dKmcO3a+/ZqrVUCBdcKbYYa01g9hbOyU5uydw21JtRcySOk+vdvPzY6wyIYxw4ajNP+2FOnWfcCT/9ScBm3+83JEysLHshwF9C2sw7JdAQxcT7V7qveIBSgZ0YRTFkGhbOd9t3FEQVeF4GRazQrvgX8P0hQV8aBqCPif2NGNFPgvJkA9i2mLjnkJDXElKSBc1yJTAs443w2CIvisa4wvkKRpdjDOXCO8EofUpWh7oVnK5n7Rt1tGqjOktfbluGZ0lJnLT73sCv4/9K416R0ETgcTvCzBfQ18q51sBnQKIiCLzMU2Iss10a6QxbMXfthfCJZpJtABWdUwDBd2MDCNZZrELrnwom+u7atAHbsykI9uxf06BPcwgMxCpBX+Gsw1sLA4UEcG7vQ9PlQNZc3JWQy8QXQuNSIRfdJcWVOVWhs/kD/yu2EB1Vac/kP/W9woERS/lKiCiLkzOnwGRzhsQ4+efqlVkYgXbedvf1Ty0lE6Ryw/L0yOPSWNCpP6KfXmxer7HjyrWdzGf29w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUNiTG1JOWkxd1lMUG1TQnIvaHhOLzBZUDZHOS9TNHRFaEhUbENwOG5wa0Nt?=
 =?utf-8?B?emsyUDArTlhROHBsL0lNdEsrYTNEbFNiVCtwRTlWTDlOcGo2UVZYT0VpNk5K?=
 =?utf-8?B?Wm9XdHpEcW1JZ2c3RFBRbVdDL0x3bU1TZ2JDS1lHd2p4enBwYlVPeHVkSG11?=
 =?utf-8?B?MDUySkErNGFiVFNRemN4ejdKazJMaTVQZHJRcVpsVWVmc2RiRmNQWmdSWEhH?=
 =?utf-8?B?MkNqWUl1SnZ2N0s5TnN3N1BmSkdYUnBUSE5tM3hVSm53MWNMRnI2TDYrSUJN?=
 =?utf-8?B?MFZEaXZKQVR5bW5HL2FLTWtiSGFzRlBSUlNkQ0Y2T05yU2JqVVQxWG1QVm1R?=
 =?utf-8?B?ZElFWXRzM0F2U3pHcnVqS1JmNnZwaEtwMmFLTWZiaytpS2F0YlBhRTE3QWJv?=
 =?utf-8?B?elFsZ2RCR0xPZHA4Q3NFL2RyVmVSd0QwLzFnK1gwdUNyQ2NPWHhxNDlhcHpE?=
 =?utf-8?B?Y3V1eUVkRkpKZXVTZ0R2SkxOL2ozbFNyYzlwMmhZWG9UQ0lVODdFempwTzda?=
 =?utf-8?B?UjN5N0JtaHlDV0tDQ1d1KzE5Q0ZiTExGY2FGRWtDaUpmN1k1RU11SGI2ZTF6?=
 =?utf-8?B?dlFvTkc3eVNmTGxJMmFsTGxUdXhHUGEveHFTS1NyTHJYUVZ4TlEvakxHVERo?=
 =?utf-8?B?TG9IWlBzbCtwbnVXb1BLbXBMNExMZWh4Um5XeHdYMjVpL1lrRjNYd1o1ekVi?=
 =?utf-8?B?T1U1Z2xOb2o2VzhsNVRDS0lrZjU1UXpIREEzQ3VxR3A3Vnkva2twZWRpNlNv?=
 =?utf-8?B?OUMzRGV1Z2szY3JlL0N2SjFFdS9tMldrUy82NkEySEVtcmRCRDcrRVBxcW1P?=
 =?utf-8?B?ZjQvdkR3Z3ZlcTFmRmFNUFhLV1NSUTVUVVVEWnZXMm1YU1ZKSTNQRUZCR2dW?=
 =?utf-8?B?b2xQSEw2VUhrUDRJWDlmakdZVndIRGpEMDBMUTZ4aHNnRmJnMmtYbzA1MU00?=
 =?utf-8?B?Wm9uS0xXNllyK2JxYXpMRmxpa052aTNGLzdsa1paUFFNQlF3RHNnclVqdjRT?=
 =?utf-8?B?aVJ4bFVwcXhCdWFwaFd2UkU2bmNTams0Y3pYbk91Ukk0cWFQSmR5b1FLc3U4?=
 =?utf-8?B?UnJqcXNDNE1UOUo2RVFWZmN1S3N2c3JXODFXNFkzQkVFaWY4cndsSnZSaXM2?=
 =?utf-8?B?ZzJHVlIrNjR3ZU1qYkkwbFd1L2YxZFhuS3dIZktlRVkxQVI1M3RJOG1IaFN3?=
 =?utf-8?B?Z0o1TkNKRDFQOWQ3RHlMVXh0eElWY0NZMmRlcTlGK3FSb29pWFRxb2pHMitM?=
 =?utf-8?B?K1JnSy9qcjJOdUJ1bzg5Tzd3dkVLakpEeUVnV0hONjJ3RHRVd1h3UjlCazgw?=
 =?utf-8?B?Tklsa1Q4b0ZEZjE5QzFTTUdoOHlCUnlmYTVFOUU2MzZ6MkpLUjJjdnF3STMr?=
 =?utf-8?B?aW02MFZWcDdVWkQzTVdpTnNJNldQaVVXTDVPS2QrZkJXVXgxTjMwd0U3d2lv?=
 =?utf-8?B?RVltRnFINnBtNGh1c0ZYb2NXMTZlQWFFeE9XUlZWYTQyNDBSNzFrMGwyMGd5?=
 =?utf-8?B?d1U1WHZIVWRhdjdHcWtTa2tjcFEwODNLMy9Ud3BRblBhUnRqWVJxemUvV3dm?=
 =?utf-8?B?UEhXLzl6VjVOaVVVcnc4UXJ1Z1c3MHVGOURTU0FRSkZ4Z21DcHdvdUVxM3pF?=
 =?utf-8?B?TUpodmhzS1hCL2srTVErRnJMdzlvc0s3M3FRSEIvQXEzRDdnK0oxdlpHTkNH?=
 =?utf-8?B?L0I4Y3IwR2FCZGJPUjNVQk9jUk5nV1daMkI2TzUvK2drSUovVCtMVFIzUkJE?=
 =?utf-8?B?T3dmTGszUFdPU1dJK2crcmNzYzArMDBzMm9HY0Nsek1SVGg4eDgwcy9DWHFG?=
 =?utf-8?B?cDFNUU9hZFNKalB0MlFkTXZYSWRUbHpQcTdIbnBMZ2ZablJRbVRpdlRsY1VU?=
 =?utf-8?B?YTNWZ2tOejR5RDZ3ZlZzTUE0cFAzcm9yNGllRVlJN0xpVmRhYzc5U2Zudzlr?=
 =?utf-8?B?eFFlcHRmMmdWYTV6dmxQZmZPMEQ2TWdsQS9GeTdWSEhIL1VsWUJIa21FUWJN?=
 =?utf-8?B?OWtnSFVaQytxUVMzUDdWbjV1VDJET0FxZjVRTmxYZGlXNDdRRXdQWmUzRm5a?=
 =?utf-8?B?RU0vVFpIM2JqZlIyYVVUbEVwS2FJdzVQbmMxamJmL3pIV2dwZnZRTE9ya3Br?=
 =?utf-8?B?VVgwdE81ZzZUWVp4ZXJYcWh4RXpJczN2TTdlT3luL3I1QTNrNW8zOEtkUGs1?=
 =?utf-8?B?RjZJS0s1eHZOZWJ6bzM4ZHdJakFSVlhybkoyRWN0bERiVG1KbTZSMkNkMlVD?=
 =?utf-8?B?cUJITnhqN1A5dU5CY3B6cm1mS3QzMWlDQXZHcHJaMUNuRlVISlVLN2ZvMk91?=
 =?utf-8?B?VXFKRWgyaU84ZSthaCszNG5FNEJlallRTk9hT1dwbkRtYm5zdEFadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40c5689-3189-40c6-a280-08df0462e3a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 17:44:48.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IedUpsMirEUKgoMAojnHSYw0tmO4PWX7lVmimuFHPbzYTfMudK1UJAtfsm/RLBkqLWSGtg74zvaVhisCF49gdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999184


On 25/08/2026 08:37, Lucero Palau, Alejandro wrote:
>
> On 24/08/2026 09:33, Richard Cheng wrote:
>> On Fri, Aug 21, 2026 at 04:51:33PM 
>> +0800,alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero<alucerop@amd.com>
>>>
>>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>>> specs restrict to the first one, PF0, the discovery and management of
>>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>>> obtain the CXL.mem range to work with somehow.
>>>
>>> Although this could be handled internally by an accelerator/Type2
>>> driver, it requires to properly handle changes to the CXL mem device,
>>> mainly its release by the CXL core, but also potential CXL device
>>> resets. When this release happens, those other PFs need to be told 
>>> about
>>> it.
>>>
>>> Implement a way for non-PF0 PFs to register/unregister to the memdev
>>> linked to the PF0 device. At memdev release, trigger the release of
>>> those non-PF0 PFs devices registered to such memdev from the driver 
>>> they
>>> are bound to.
>>>

<snip>

>> I suggest replacing cxl_get_pf0_memdev() and cxl_put_pf0_memdev() 
>> with another
>> helper, e.g.:
>>
>> int cxl_memdev_link_consumer(struct device *pf0, struct device 
>> *consumer, struct range *range);
>>   It should live in cxl/core/memdev.c , and the behavior is something 
>> like
>>
>> 1. Find PF0's memdev and take a temp ref.
>> 2. Lock the memdev
>> 3. Verify that the memdev is still registered, driver-bound, 
>> attached, and has a valid HPA range
>> 4. Create a managed devce link via device_link_add(consumer, 
>> &cxlmd->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
>
>
> Interesting approach.
>
>
> Not sure this could do the proper thing though. 
> DL_FLAG_AUTOREMOVE_CONSUMER seems to remove the link, cxlmd->dev in 
> your case, when consume driver unbinds ... but it is the other way 
> what we need. Maybe I do not understand well all the implications with 
> this approach, so let me study it.


I'm having problems just trying to implement the supposedly basic 
functionality linking the cxlmd device with the non-PF0 device, I mean 
without thinking about potential races with this approach (I think it 
has less problems in this regard than my approach).


I can use DL_FLAG_AUTOREMOVE_SUPPLIER with the supplier being 
cxlmd->dev, so at device unbinding it can trigger the non-PF0 device 
unbinding as well. But it seems all this link code is quite related to 
PM, so some checks at link creation fail. I have tried using 
DL_FLAGS_SYNC_STATE_ONLY along with the previous one, but another check 
precludes the link creation if both are used (See 
device_link_flag_is_sync_state_only() ).


Do you have any advice here?


>
> Thanks!
>
>> 5. Copy the HPA range
>> 6. Unlock the memdev and drop the temp ref
>>
>> This helper can return only an error code and the range. The sfc 
>> driver doesn't need the cxl_memdev pointer then, and
>> no put helper would be needed.
>>
>> And driver core would unbind the non-PF0 consumer before unbinding or 
>> removing the supplier ( memdev ).
>>
>> I think this can remove the sibling xarray , raw device pointers and 
>> mutex_trylock() context check.
>>
>> Would this modle work for your teardown requirements ?
>>
>> Best regards,
>> Richard Cheng.
