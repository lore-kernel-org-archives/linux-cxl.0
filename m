Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278238F928;
	Fri,  5 Jun 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681296; cv=fail; b=CPVW0lt6iiqTvj6cd5+L9vood5Z9eK8POZrUNavfdBtyfXbWSbGogr2bQ0tkB5Zn3WNaWuckKpMEYoBGvpsr3fK2Plkcsr1Jb3v04Q4lPiyu3Wiq8K2S8ZUVk5jvxTAwR63IbrhwQ870Q68EtrxyHfkxkHYJLo1JCdKHFaXcCv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681296; c=relaxed/simple;
	bh=yDddsKikQWy2vPLrHLhNwGuPCHb6iAFCBU+1O+epuxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WONZKc96pbGXnD4hLn8DU9TnnRCj1TMFJBNIuqFGTlsg9eoSU2Zx/TmG6gwgRpNIVurPUVZJWPenR1mrAvIJmymKVs43r999vpqskyyudQMUw88ekK7jjeefddni0UyCHUVE6a+m8UIIjfEEcqi4wKCCoPzXBo6yWGka90896mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jKqrVdC; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jKqrVdC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2aJQ7/J9xcyLzPdjWnrGxOWQahd0inK3Ys1jwTDd7+6M8xiLydmKANKkNWBtlcTYD+UKs/ICssTYhUZ6S6+cB7A6rd9c5m/L+0H/62O141ckQnkjyTW7BZr+T9v75Yu6tlb2puwKrBzmDq42y6GoLU5GRxIASGsadbJuYs8fwPTQosdZ1k1CAtnT3u742G4qvUdOwFvcoIwNzYuCVxx9TB3Qk1+6oCLW0SSvk5i1Z/pbIZqp3zJWvJtFcV7H2oCSqC4iebAYuOrXhw83bBUzqQY6SRz+xNSpI5BtjnqpwmyvpXls79ijqaWBEI4ovix3RxmaOUK6b6HVDg7cNrb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad5iHrsdQ8bpvDfWSYeRiRvwlgVQLWVl3XxwQoNDWkM=;
 b=Dh19LURSaYKw/kyuWxLfmVOqA0t5hJUAlhO9DxMwbtHsoehFT7hVz65Lv9FT6K2SdL5BEr4S3RxIknrhDQVoRRndVBXOiPqA+Cu8yLuvnSEOohb8pexjqeMoGiQhyVpc/qK2Cex69aavwOtKz447WmkAxffUjCWmdeAEnzCZ2IePZgZ7DYh6SwkRGTFIP/CEZLqqVLX9dwXMcACRdDXKyPCciJCNxVPREFMIzflC8yBwH/PmSD5EDfV/giZEGCMuH88He0crXlYGDbiJ2mCkIIgNnn1UdcOkZOGmhH3Owfp+30JL2XEa8IjFDp1SGpVdGg8bFRevfLtHHQnmRw4oLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad5iHrsdQ8bpvDfWSYeRiRvwlgVQLWVl3XxwQoNDWkM=;
 b=5jKqrVdC0ILeHWVYjj/+696eMhbNjolXDgZ3mKZzf37GZ9JfRE5HBAFrkgoiw0R4Df6GTvu6Xs4CU0b72o/DWC0EoXSUiloamduPMoa4E465WNI7XqnauHESXj3KxMaTRNlOCLvlYv9W4i0BSCoTFDW+p2IVn6LH/GnN56+SC5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 17:41:19 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:41:19 +0000
Message-ID: <57003a84-45c8-4966-ab8c-d36f3076bee8@amd.com>
Date: Fri, 5 Jun 2026 12:41:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
To: Richard Cheng <icheng@nvidia.com>, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com,
 smadhavan@nvidia.com, vaslot@nvidia.com
References: <20260605041602.37944-1-icheng@nvidia.com>
 <951d3e9b-f9f4-4d16-8119-1543ed9e44f1@intel.com>
 <aiMAVuHbjXQGaCf-@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aiMAVuHbjXQGaCf-@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:806:d2::32) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: fdef7bbf-5334-43f8-9427-08dec329a6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|6133799003|18002099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	e9GRrEEEhoXAZV+6vWgGOC1hAsoonzeBYyv4u3t+SLmgm7s7FAi9lLx3uCnF+fTLxqhGEhMr8UL11w+gBeNBEu6EvzDmg2bt7XwSqAxoFELNfOnTKHFenb6/MLpA7nUZz4tWoMssVM8DAknTrWb++kZNwwCbB0drwrVgPZlCYMz8ZtUZhsGeuKca5Z4iPw9gf7x/QD6tN1oc+PYr+6IpURtCPKTlfDTvFQBqdjW1fCIlqgGk2F6YTN0e8orNZUDQ5YvVXW5oZRdXIH4zGn6sIumSEKXyzlY9R6pxE4tKVKImhQ0vBcpf10Eg1ILW5T1e1EUq4By2G3IQDt5SMyDMessIVoxd22zPJvw6Avd2FL9tUK/Sp/Wu7tZNip7gufFI04mM0QtAssTaOslGvz7VaaCWdg3cNiawsEartixuCPBEUy53jHpbqFJrqNyMFL4ArzJVjEbXUkdLZz63T87nMlE1JWwMDv7IKRi6wUecLw/DROFAczaqZ9Up9jdf0GDeJIMB6vowm1UMk4UU1nVWR3r2VbxGcAsy7wyh3kl1cEsBfJ/5X7sNuuup/sBTQ4PEh0kCjrKfHQ0Z3mEQBlOnHYliWxvB+vWWj//ymwYZVcUX67KE7ZZsGy57IO3jWqyAPX8j4YQmu8St1yGMaMYQUtpNqTXToUsNRW548zcOJr4fhweC+h9jTomWuwwfiCopz6mhpPOJJLvGRKK7R/sk1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(6133799003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cytTQmRvTE80ak9OUzVlVTdiRHphOHVuTzRUZUpWdFIreFlTRkVud2F0QUdC?=
 =?utf-8?B?UU14cjIySDNmaStNRWN0YnZFVWIrdHRWRDl3K3JzYk1mU216dzZucjBBdTBD?=
 =?utf-8?B?ZFc1R3ROdVFGZ1JPSHV6UXZybEdySXZiYXlhN2JmVllMMkV5Zk1CdnhxUjcr?=
 =?utf-8?B?ZVc1YVoyQ2dobTFISGFPdnFEWmVJalhKanhqZVcwTnVVSlZJd3JxTjN1QUVF?=
 =?utf-8?B?MVZUWHhCSEpTdE52dGdhdXVPK1NiMVlWTVg3TDU1OXpIS2RDL3NFWHVTT3J6?=
 =?utf-8?B?VGJEOWlpUFJRNHU5TzdTSS9zVGVSeXlSVkZVa1lYaE5DUm5oTTZaZlBndk9X?=
 =?utf-8?B?M1kyU1JzNytJeXAra3pmQm9EVXQvOHF6amFwQ3NIQTVlS2dNM1c5Z1dTeFRN?=
 =?utf-8?B?aXFNby9TTXhsbHk2T0ZNM3NlUnFaZm51WXlqazMvOEp1anNEeGNzTGdiZE5G?=
 =?utf-8?B?aXhIODR4aU5JaWJtaUE3UEtraytDN1ZsZW16akUwcWVtU2hVQnE4UVV0UlR3?=
 =?utf-8?B?NFRZV3RhNGFEZGhVQXl2UHNtc1RmT1F1WG55MUJ6RkNUQzgrTGg1ZmdJNm4x?=
 =?utf-8?B?M3ZDQzJyVm11Zmp6aEYxaThOSnZuekRFYjZ6ZTlyMFhSSnY1RzJ0dTJ5NUxH?=
 =?utf-8?B?RTM3ejZXR2hpYm9CY2xuOHg3aUd1NXExaFpIVWxoWUp4ZFYyTk14VXV5aXNZ?=
 =?utf-8?B?QUg1Yk05akM0bnczN2V5QktjR1RwM24wZG96ektPZlZvRjNOa2N4bk5mRk1R?=
 =?utf-8?B?c0pBU29FeFZjUVJqSGp1MmFMdjFESlA2VXNyK01vWFlrejBzajhrZUpLb0tt?=
 =?utf-8?B?QWI1eFhhbFpLZUZIVFZXeTF6VFdCMmM4R2tYeUpTWXBRdUJqT25wc0ZuSlpq?=
 =?utf-8?B?bzhpR0NMSUxRbGJuY2hIU2NwU2szMlkvTjRsMHpBL0NFdjhZaFRVVFM3U3Q2?=
 =?utf-8?B?QlM2UENSV0ZZR3g2TXBLU1BFWDNTZWpDVC80cDRFenFpcTVpSkpZZGF5ZWRN?=
 =?utf-8?B?UE94UkRrZDIxV20xL0s5M1YxTFc3Yit5MktpaUNubGZqdXIwNy91UnlUR1RB?=
 =?utf-8?B?SjdCQ3Bwdi9LYk84WmF0L3R6T0pHQjduVGtML0E4YTI0UU9mazhkczdiOFVH?=
 =?utf-8?B?d1pJSmp4empYN2RlYlVoZUZ5TVhiUE4yRkxIZmJOUWJSVUdkeWorWW5FVUZN?=
 =?utf-8?B?b2NNaU42d0xuN0tERDJNMHZXRWtnU2UvR1V0NjB3dzgwMnFJc001MGpXYXRT?=
 =?utf-8?B?MDRSWVZTY0dNOWUreTQrVjlPd0FMclNJeHdXTE5YakhnTWN5eDNxS3pYWnJ6?=
 =?utf-8?B?bmhINHRBNGt1YlhDWXhieWtrbHFwMWIydi9SR2l4Nko2Sk9IcWV5YXB6b2l0?=
 =?utf-8?B?T3FiMlAzOERvSDVQSnBBSiszUUxhcnk5QXpuM3dReHFsNnQwbmdOSjBYd2R4?=
 =?utf-8?B?dXFuaXYveU5PN3RKMFdDNGZxa1dacVBwVTlDUm5HVm5FYWdhMGxMTGFIcHZ5?=
 =?utf-8?B?M3BpSlVxekNQaXBPT1BHZkY5RVhRK0dOLzRjZnBsT3YrRGM1bnBFekZrZkUr?=
 =?utf-8?B?OGgzUm5xQ1hjcUNTRld4dHYrWTNBb3A5bHMyM1hrUnpzVDNsL21URlZrWWg1?=
 =?utf-8?B?NTFsTU9zV2dGdmF0SWxzcUVCektDampXVy9zbTEyR3VtYUxvV01wTFJXeWIz?=
 =?utf-8?B?VjVDR0toZEc2bkpWamwzRVdrelNkNWo2cGlYRXRTMGFHNkN3MndKYTFPYURM?=
 =?utf-8?B?NllHc1JOSFB2RDBwUkE1akdMc0dibE9KN0FQdElaUk9tWWhrVjc2NHBIVStN?=
 =?utf-8?B?NUdsYjVWYzJJemE4NUxLajNISEZqM2lXUGpwb0pNaUk1ODZiN3Rid0JRZEZK?=
 =?utf-8?B?L0Zob0FQQnpnSUJ1dERkVy9zSHZCS256Y295WSsvVk11czN1eTFYREZ1aDAy?=
 =?utf-8?B?cFJ2UGRNWmVmb1ZtNXZ3QUlrb2xlYVlYcjJ3TFRsRUVVKzRrMStzcEtqNDht?=
 =?utf-8?B?aEc5VWMrdm11TUJzdEs2VVhuYmVDZ1Y1RHVrZ0Fjejl6SGV5WFpyOTlhUzZp?=
 =?utf-8?B?Zm1PQlphaHlSa3pKQXlKTDBLWHdnSitMWTR1TUtSQ0YzakxnRWErRVBIT3NS?=
 =?utf-8?B?cVVER29aLzJsYmdLUUtBTWVVdGdWVjZ2elBaQ0VjTFBFSFVLaUZjVS9FQ0pH?=
 =?utf-8?B?MkduUklaWldLblJVeHh1ekN1UUxmN3lxR0hKeEMzZEk4TjhLdGU1cG5ncXZ4?=
 =?utf-8?B?Q1RFeHNMYlJBUzZJVkVKcVBibFkxWEJ6K2ZKbXdKeFJXRVB5Vm0wOFNyeEVl?=
 =?utf-8?B?KzUwK3BTVkpRTUx5U2ZUSVJ6bGdiSm5ZdFpLM3VGYVJweTVFNUFWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdef7bbf-5334-43f8-9427-08dec329a6ef
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:41:19.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTi+CxpmA7nOoJwWPIl5BbKcU9yiiNtcKP4gUHWmqk2bj1BHMih6BYD8IIUcxcpd5mrTDH4yjtWT0pk+Yd62Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

On 6/5/2026 11:59 AM, Richard Cheng wrote:
> On Fri, Jun 05, 2026 at 08:30:55AM +0800, Dave Jiang wrote:
>>
>>
>> On 6/4/26 9:16 PM, Richard Cheng wrote:
>>> The CXL RAS Header Log is 64 bytes, but CXL_HEADERLOG_SIZE is SZ_512,
>>> which is 512 bytes, not 512 bits, so the kernel treats it as 8x times
>>> bigger.
>>>
>>> header_log_copy() reads 448 bytes of MMIO past the register, and
>>> cxl_*_aer_uncorrectable_error() tracepoints memcpy 512 bytes from the
>>> 64-byte header log. On the CPER path the source is a heap object, so the
>>> copy runs 448 bytes past it and leaks kernel memory into a trace record
>>> that userspace can read:
>>
>> I think Terry raised the same issue and this [1] is what Dan suggested for the fix as there's rasdaemon (user) impact.
>>
>> [1]: https://lore.kernel.org/linux-cxl/6a0e33507e961_1717cc100f6@djbw-dev.notmuch/
>>
>> DJ
> 
> Hi Dave,
> 
> I see, so is he gonna do the fix or I can send a v2 with the suggested approach ?
> 
> Best regards,
> Richard Cheng.
> 

Hi Richard, 

I will send that fix today.

Regards,
Terry

>>
>>>
>>> """
>>> [  297.704020] BUG: KASAN: slab-out-of-bounds in trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
>>> [  297.704032] Read of size 512 at addr ffff0000dd6ee118 by task bash/3078
>>>
>>> [  297.704038] CPU: 116 UID: 0 PID: 3078 Comm: bash Not tainted 7.1.0-rc6+ #1 PREEMPT(full)
>>> [  297.704041] Hardware name:  , BIOS buildbrain-gcid-sbios-45660680 Wed May 27 08:27:58 AM UTC 2026
>>> [  297.704042] Call trace:
>>> [  297.704043]  show_stack+0x24/0x50 (C)
>>> [  297.704049]  dump_stack_lvl+0x80/0x140
>>> [  297.704053]  print_report+0x100/0x630
>>> [  297.704057]  kasan_report+0xb8/0x130
>>> [  297.704059]  kasan_check_range+0x15c/0x240
>>> [  297.704061]  __asan_memcpy+0x40/0xc8
>>> [  297.704064]  trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
>>> [  297.704066]  __traceiter_cxl_port_aer_uncorrectable_error+0x90/0x108
>>> [  297.704068]  cxl_ras_inject_set+0x278/0x3d0
>>> [  297.704070]  simple_attr_write_xsigned.isra.0+0x198/0x298
>>> [  297.704074]  simple_attr_write+0x44/0x88
>>> [  297.704076]  debugfs_attr_write+0x78/0xd0
>>> [  297.704080]  vfs_write+0x1f4/0x960
>>> [  297.704083]  ksys_write+0x100/0x220
>>> [  297.704085]  __arm64_sys_write+0x78/0xc8
>>> [  297.704087]  invoke_syscall.constprop.0+0x150/0x200
>>> [  297.704090]  do_el0_svc+0xd0/0x210
>>> [  297.704091]  el0_svc+0x44/0x138
>>> [  297.704095]  el0t_64_sync_handler+0xc0/0x108
>>> [  297.704097]  el0t_64_sync+0x1b8/0x1c0
>>>
>>> [  297.704100] Allocated by task 3078:
>>> [  297.704102]  kasan_save_stack+0x40/0x80
>>> [  297.704104]  kasan_save_track+0x24/0x58
>>> [  297.704105]  kasan_save_alloc_info+0x44/0x88
>>> [  297.704107]  __kasan_kmalloc+0x108/0x110
>>> [  297.704108]  __kmalloc_cache_noprof+0x1bc/0x588
>>> [  297.704111]  cxl_ras_inject_set+0xcc/0x3d0
>>> [  297.704112]  simple_attr_write_xsigned.isra.0+0x198/0x298
>>> [  297.704114]  simple_attr_write+0x44/0x88
>>> [  297.704116]  debugfs_attr_write+0x78/0xd0
>>> [  297.704117]  vfs_write+0x1f4/0x960
>>> [  297.704119]  ksys_write+0x100/0x220
>>> [  297.704120]  __arm64_sys_write+0x78/0xc8
>>> [  297.704122]  invoke_syscall.constprop.0+0x150/0x200
>>> [  297.704123]  do_el0_svc+0xd0/0x210
>>> [  297.704124]  el0_svc+0x44/0x138
>>> [  297.704125]  el0t_64_sync_handler+0xc0/0x108
>>> [  297.704127]  el0t_64_sync+0x1b8/0x1c0
>>>
>>> [  297.704129] The buggy address belongs to the object at ffff0000dd6ee100
>>>                 which belongs to the cache kmalloc-rnd-09-96 of size 96
>>> [  297.704132] The buggy address is located 24 bytes inside of
>>>                 allocated 88-byte region [ffff0000dd6ee100, ffff0000dd6ee158)
>>>
>>> [  297.704135] The buggy address belongs to the physical page:
>>> [  297.704138] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15d6e
>>> [  297.704140] flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
>>> [  297.704143] page_type: f5(slab)
>>> [  297.704147] raw: 017fffc000000000 ffff00008001c1c0 dead000000000100 dead000000000122
>>> [  297.704148] raw: 0000000000000000 0000000802000200 00000000f5000000 0000000000000000
>>> [  297.704149] page dumped because: kasan: bad access detected
>>>
>>> [  297.704150] Memory state around the buggy address:
>>> [  297.704151]  ffff0000dd6ee000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [  297.704152]  ffff0000dd6ee080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [  297.704153] >ffff0000dd6ee100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>>> [  297.704154]                                                     ^
>>> [  297.704155]  ffff0000dd6ee180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [  297.704155]  ffff0000dd6ee200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> [  297.704156] =================================================================
>>> """
>>>
>>> Define CXL_HEADERLOG_SIZE as SZ_64. The trace record's header_log field
>>> shrinks from 128 to 16 dwords, but only those 16 were ever real data,
>>> the rest was always junk.
>>>
>>> Fixes: 2f6e9c305127 ("cxl/pci: add tracepoint events for CXL RAS")
>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>> ---
>>>  drivers/cxl/cxl.h | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 1297594beaec..f322d7c79ed2 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
>>>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>>>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
>>> -#define CXL_HEADERLOG_SIZE SZ_512
>>> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>>> +#define CXL_HEADERLOG_SIZE SZ_64
>>> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
>>>  
>>>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>>>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>>>
>>> base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
>>

