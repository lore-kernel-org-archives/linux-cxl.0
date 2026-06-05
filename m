Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC0357D0F;
	Fri,  5 Jun 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682949; cv=fail; b=sCEb91MenkLDibymNMKmo250ORtpJwX+2ZszuUmeZtVBEayLxnBoOEQlttoWjUilH3wgCwTBakeXjBQuBc0Rc/W2lMNOPiEwdbewNsAwVhKsuEaC9K7Yv9ScNb7nulJ8unPxy4/uc0gVdWrb88X10BIR5tsa+Kotp6UMJZx9inI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682949; c=relaxed/simple;
	bh=vkJ/FFwyT02nJYUOJ4HcOj1AF8W4sb4nVC2tp5tHMPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NiIYBSSqOjxARinEXJPZHp+gbMzyKP5OuJlXC4CtRTkf6R4KuIvbtxh+KX8DcRggHj9vs1f/szmAmESI72pEdWcJGsdQU3kd2+ITWdDY6K/s36rI+RtG2LNhk1t2SSJy7QOsFZGo6TcvQuit7bfqE5bM8GDOva24qAw6qUm7YxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BerpRmdS; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BerpRmdS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywUyTGU2cpUi5s4/UpZw6Iqg2sN7jhV05TeKFdUgwOYLnGMTqikvnphVDYqIuBRK4C7Bc4+XyOMcGmyiTjNw+Hfk67UwnM4d5B02Fi/xyYP4YZMqFg6/Cmi5XsiXKGoWcsuuHgdSTg/sxn11iugTgi/ZVCmT2QpJbQ8TGKNLvx2mwkSV597UABSuKumtV32dEe/dvNe1XQgzvXNtNupMzeYPH5r/01PcnNMjNePwHIBg6tLujENlelxf42I7o5SS7EzkTEXTmeSroTopIWcZgX1j0wBzYGrYR4vVLPNuZCEaPyq2t8/EZNhKQwe+5r5G4eWpX0i1QfzuvzBJhOruZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCx6Ai5xsvz4tqTOKECBl9rlxQNy12Q6yI7bWZpMxIE=;
 b=TH3wip58W8orAARemPqwsRH7Roz2mdMNmpJGn9bJ/u/nWvcLsPLR7E9CrOp7yqJGxwLjKsEI9mQl7bMyWyZfImSjWSF5tH/zlNVkwhssc3juoR37DqBdaLAUdHxYUamRbVEWbqbyMdzTjLmeJhEPupws0zem4dUoZYmgFodtQOAtHtxFEvAmf3VUtE8R8pkgJNC1IDiUIL3HMr4qLSHO3gVU3826+sTE1p5r04tgu+vSvu0ZFa056KRcOLSAvjqePMab8Kw0/mgLxfqj59xW5eJ31xT+JF/K2rdjT++zq/r72iy4bd59eThYMtPv+yYW5Rc1Yas2Z8g8Ahre9O3Mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCx6Ai5xsvz4tqTOKECBl9rlxQNy12Q6yI7bWZpMxIE=;
 b=BerpRmdSPjOis+ilQfiTP0hD+mF0scV24AxCPOYS5aAGqUEvBEOIGtku4gAvKaIKShYMLrqW+ueIA3NE0UANYlkaAz1FEa7woKlZuHfSkdvYB6WkdNvCBm3/nUZ81prxuVLzCQ2fn3nZCP95jTNHBxtQqhT9ce1d6gLOVz8Tns8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:09:03 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:09:03 +0000
Message-ID: <5ca9e446-1220-4aca-bb93-23aa65040237@amd.com>
Date: Fri, 5 Jun 2026 13:09:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
To: Richard Cheng <icheng@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com, smadhavan@nvidia.com, vaslot@nvidia.com
References: <20260605041602.37944-1-icheng@nvidia.com>
 <951d3e9b-f9f4-4d16-8119-1543ed9e44f1@intel.com>
 <aiMAVuHbjXQGaCf-@MWDK4CY14F> <57003a84-45c8-4966-ab8c-d36f3076bee8@amd.com>
 <aiMOX1Yu8MSa0F2m@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aiMOX1Yu8MSa0F2m@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::16) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb450af-0530-4c29-ebcf-08dec32d86d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	U5RFp6GylXSLBlsmCZr57WrIqd8bRhrghBMXcM1ogPoC4VFQosMRPJmNq959qbVmQTGf0C5IdEjIjtsl/hCRCM+di+J7GELkCC6BZvL6eK2nmDRIIX0nNwCIxi3/WBIzszMFgNVTrpZIK4ttoc/Z2KKSsJnOM3GodDGNkUuvwCywq/jKjwr8MWQgiFO1PvOyt+byLmfQOUTrn8sZ4dR4P9urDOdo/WnpXxv+HzQAFFEmeL82kztPnJMZAgjza6ZUj3JceIsbde96opP11UdSGCXFnZQKOcwwzP/0BZDQGjhWTyk+YjbSH9n8PBXz135qjLgHr0vpXHyulokbn43lTV/+5h5rGwIjVoNqdXf/Ra7w459AbiGI1WYcoD7L84WVBRsHLgGzBYKKgWQjTH6lHCiVIHlqRxMeEnADo3sOtSEnX92lEvw2z8bkM8GfT6iyDuMKE1iZjme+pKLhoJ+qVojRbR/CXztmlUbqRcwMs2KheDR9b/R0YvH51wXQ0AUtaw2vdfqwyqoZ2ps2FvP0espjQ+6WLTgsnZqo8wN0zdKB2SVLkbd0kiZm/xnJnLo26omPCDvwrUct12o8isRILmn8SRzmLvMw37blwv/aKh9eWj6vHKC2U691KtLk4snWpJTslthZzM74wT51KpDdQBlUjmYhM7FIz9RKnwVpK2iVGsmig0+IvoWj6vATJMj0QdO0kuBR3objUvoxYwlSEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTU3V0NHa0ZQMlRQMXhEMjVwb0dLa3lkUktpM0o2cVQ0NDJFWVBnb0tlV0xV?=
 =?utf-8?B?NEI5U2NBZXRiQzZqM21ncVRxRXlnK2dhTjgzSzh2SXlmQlhVbE84WXowRm5m?=
 =?utf-8?B?cHF2UWx6d0pFNVZiYWpLM0MzOURaMDBxcmhtTms1L00wMVRHVDdTMDNFN0tK?=
 =?utf-8?B?blBEQUxGVVVtbHNsSVI1bXhQUW5nS3NmZnJEVVJKdDhobHl1WlR2b1FrRFI0?=
 =?utf-8?B?Y0ZqMDlFQi9CNGdZSUdBWGFDa0tzeGMrWHBkYTh5alZrcjd5SUtuYS85bmMx?=
 =?utf-8?B?OVZjb2dTcDdOZUV1Y29Bd3hQWEtId1J6Yy9JbWIxU3VTck1Kc2VXeU04SkJH?=
 =?utf-8?B?OUM2bm9Bd2ZPcjRieCtkemJRYVBVcXdWditvajkwd0E0NlB0WncwVEdUcFpS?=
 =?utf-8?B?ZWt0aFpETWY3RkRNcmtXVzlMMk4ySGJVMUlEczR4MzZ2ZjZqMFNTc29tdmpo?=
 =?utf-8?B?ZjdFd3NBT2kzSUd6b3hBZ3hERlpVRytRWU8rc1hrcnFTZTFzQU1jRmp3aGFY?=
 =?utf-8?B?aXIxMmJabXdiRFVwcHNXRXVGR3VtVUo4SjZsSGs0VE5hRi9kZDIydmdMYjhV?=
 =?utf-8?B?a0tVYWFiZVNTeXdmd28ySlhVQ1d1RHc1V0tNN05FYSthbU43dVlBdnZhQW1H?=
 =?utf-8?B?cmdiMnVvTmZtb1kwTlJrWXEwbVp5WDVscnRFbU1NdktKOFZwMEJQUlZIeEtT?=
 =?utf-8?B?YWRXcU0vU3UxYjJHUzlzL3JDb3RsUU53NTlVbW5MZFcxVGY0Z2YwVk9Gc2VV?=
 =?utf-8?B?czNEdWMxNkg3ZjBOSHN1dGFSMWxEZnJoWWhYR0tWY2VRYm5tWmVFL2JUSTFN?=
 =?utf-8?B?NTVzQkxob0crU1h6L0hNbUZWM1d3RkMxN2ErSWVoR21oL29wSlBmWEs5dzNN?=
 =?utf-8?B?d3VhWTQ3U3FOSWJkSytjdlVLNU9xSkVRSXRrbGFFSnZNdlNGMTNCU3NJZ0VR?=
 =?utf-8?B?KzROMHVKWUpLTk1wbnRyOVlieXN6YnNSb2pDeFlWMEhnQ1grSlIyWTVFMFE2?=
 =?utf-8?B?WU8reTliRDlrN1hFcGpUVWxRM3V3MFB6azQ0dFhVOHc4eUhKSlN1cU16WTdQ?=
 =?utf-8?B?K1BYM2YvM2NtbTAyK2s3cStFN3FHbXVFc2o1VlZZUXFsTFRHa09XMm5ma09U?=
 =?utf-8?B?OHIrQ1JSdjFRSWF4dU1sNVExL0tNb3NPZ0lhRXFWeCtBbmhhTkZkcVVyeW9Q?=
 =?utf-8?B?a1VHRWJEYmFRYy9Rd3BGNWtnMmJyRi9ZTmdpaThPTG9RSmw1YkFTM2ZkSWw1?=
 =?utf-8?B?d1hJK2FTcVp4WU9wd0Z4aVViOWhTT1YzUEYyYmVlK1VFZ1FaaE15MGMwbURS?=
 =?utf-8?B?b1I0K3dBOTVLZjk0cnQxMU9JQkZpS2F5ZTh2M3NnNS9ISVBEdVA0RXU5L0ln?=
 =?utf-8?B?ZVdGT3V3Ullab3R6WTB4UHlnUUpLZEM3d1M3UE51YW5VZ3JBT0tiUjJjR2k4?=
 =?utf-8?B?V0NtemlYQWFqYUtRbm43Y3k1cW1aWFlBeWZmcWZEVTM2eWdEbElGaDA2TEVZ?=
 =?utf-8?B?Sy94OElocEtsSGg4OFpmWDU2Tm1LaXoyM0wvNlNxOTNpSE80a1ZwRzRuVXlO?=
 =?utf-8?B?aVBIUFNFcDF3YUgvbTN0eG9vNTQzZ1c3OGJlZ0FlVEtwTm5Xc2VEZWJzQjN2?=
 =?utf-8?B?K2ZuU3JEb2d6Q1EwRjJuUlRXdllFZkJFSXhOTWVURXV0V3VjRis3dHlobHE4?=
 =?utf-8?B?azhQZGNWck1XM2R4eUhaNGxsRzk5N3ZmUnorUURFc0dzb1ZocVE1UFR6UU5S?=
 =?utf-8?B?UzRtMFplWkZUL0lPcDBxSlh5WTd3bEZzVHovclhVbEZ0d0VFSTdhTGtJalNq?=
 =?utf-8?B?SzRUdGxoQkd4aHk3MzlXcXczMGFIa0w2QjZDSkNYV0pJQWlmZURXSEROa255?=
 =?utf-8?B?U2pORmJRTTBIVkl0aEozRnVUWnhBVm9iNFIxZ3hmVnpWYTFDL3pPOTFEMlpH?=
 =?utf-8?B?bysyT1cyN2p3NEQrTzRVUjBWNEZVRU5EbG1ENElGbVQxdUJOOElMc2c1MEh4?=
 =?utf-8?B?NkVITFd1S2Q2dGhjZ2VEVWYvUFhZYjBTNlp2ekw4N3htbWduOWc0TDNJRjU4?=
 =?utf-8?B?Mm5NRmI0OTdlUis4RmE5clNjOTdsOEMvWFZLbGl2dzBoR2JLR2ZnZ3VKMEcz?=
 =?utf-8?B?TjJ2L0ZpTzgrNllralVrYURtUEI1NTk5bnYrb2RVOVNWV29EMms1b3NNcEhT?=
 =?utf-8?B?TGs5SDV5RFdKLzBmV29GOHZoenFEUGFnTFM5UjZCWHFzRjNGTGtiRk55TFB0?=
 =?utf-8?B?YW96cDlBMXB5cHlVTWx2RXNnUmRpNms0Q0wybDlFNVFmTS9EOTNwR0l0NytS?=
 =?utf-8?Q?FRbkgRs5BMSw7EoF/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb450af-0530-4c29-ebcf-08dec32d86d9
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:09:03.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqAAZKHdROw9+qNnHC93/aN1CnqFAS39pcUBO3NmwEmJx3zhiDLJn7RwZo63mwXRd/bHhAamXRPSUdvi3+hOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558


On 6/5/2026 12:59 PM, Richard Cheng wrote:
> On Fri, Jun 05, 2026 at 12:41:15PM +0800, Bowman, Terry wrote:
>> On 6/5/2026 11:59 AM, Richard Cheng wrote:
>>> On Fri, Jun 05, 2026 at 08:30:55AM +0800, Dave Jiang wrote:
>>>>
>>>>
>>>> On 6/4/26 9:16 PM, Richard Cheng wrote:
>>>>> The CXL RAS Header Log is 64 bytes, but CXL_HEADERLOG_SIZE is SZ_512,
>>>>> which is 512 bytes, not 512 bits, so the kernel treats it as 8x times
>>>>> bigger.
>>>>>
>>>>> header_log_copy() reads 448 bytes of MMIO past the register, and
>>>>> cxl_*_aer_uncorrectable_error() tracepoints memcpy 512 bytes from the
>>>>> 64-byte header log. On the CPER path the source is a heap object, so the
>>>>> copy runs 448 bytes past it and leaks kernel memory into a trace record
>>>>> that userspace can read:
>>>>
>>>> I think Terry raised the same issue and this [1] is what Dan suggested for the fix as there's rasdaemon (user) impact.
>>>>
>>>> [1]: https://lore.kernel.org/linux-cxl/6a0e33507e961_1717cc100f6@djbw-dev.notmuch/
>>>>
>>>> DJ
>>>
>>> Hi Dave,
>>>
>>> I see, so is he gonna do the fix or I can send a v2 with the suggested approach ?
>>>
>>> Best regards,
>>> Richard Cheng.
>>>
>>
>> Hi Richard, 
>>
>> I will send that fix today.
>>
>> Regards,
>> Terry
>>
> 
> Hi Terry,
> 
> That would be awesome !
> If you don't mind, can you add me in the cc list ?
> I would love to learn from your approach.
> 
> Thanks,
> Richard Cheng
>  

Hi Richard,

I just sent but missed adding you to the list. My apologies. The patch is here:
https://lore.kernel.org/linux-cxl/20260605180610.2249458-1-terry.bowman@amd.com/T/#u

Regards,
Terry


>>>>
>>>>>
>>>>> """
>>>>> [  297.704020] BUG: KASAN: slab-out-of-bounds in trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
>>>>> [  297.704032] Read of size 512 at addr ffff0000dd6ee118 by task bash/3078
>>>>>
>>>>> [  297.704038] CPU: 116 UID: 0 PID: 3078 Comm: bash Not tainted 7.1.0-rc6+ #1 PREEMPT(full)
>>>>> [  297.704041] Hardware name:  , BIOS buildbrain-gcid-sbios-45660680 Wed May 27 08:27:58 AM UTC 2026
>>>>> [  297.704042] Call trace:
>>>>> [  297.704043]  show_stack+0x24/0x50 (C)
>>>>> [  297.704049]  dump_stack_lvl+0x80/0x140
>>>>> [  297.704053]  print_report+0x100/0x630
>>>>> [  297.704057]  kasan_report+0xb8/0x130
>>>>> [  297.704059]  kasan_check_range+0x15c/0x240
>>>>> [  297.704061]  __asan_memcpy+0x40/0xc8
>>>>> [  297.704064]  trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
>>>>> [  297.704066]  __traceiter_cxl_port_aer_uncorrectable_error+0x90/0x108
>>>>> [  297.704068]  cxl_ras_inject_set+0x278/0x3d0
>>>>> [  297.704070]  simple_attr_write_xsigned.isra.0+0x198/0x298
>>>>> [  297.704074]  simple_attr_write+0x44/0x88
>>>>> [  297.704076]  debugfs_attr_write+0x78/0xd0
>>>>> [  297.704080]  vfs_write+0x1f4/0x960
>>>>> [  297.704083]  ksys_write+0x100/0x220
>>>>> [  297.704085]  __arm64_sys_write+0x78/0xc8
>>>>> [  297.704087]  invoke_syscall.constprop.0+0x150/0x200
>>>>> [  297.704090]  do_el0_svc+0xd0/0x210
>>>>> [  297.704091]  el0_svc+0x44/0x138
>>>>> [  297.704095]  el0t_64_sync_handler+0xc0/0x108
>>>>> [  297.704097]  el0t_64_sync+0x1b8/0x1c0
>>>>>
>>>>> [  297.704100] Allocated by task 3078:
>>>>> [  297.704102]  kasan_save_stack+0x40/0x80
>>>>> [  297.704104]  kasan_save_track+0x24/0x58
>>>>> [  297.704105]  kasan_save_alloc_info+0x44/0x88
>>>>> [  297.704107]  __kasan_kmalloc+0x108/0x110
>>>>> [  297.704108]  __kmalloc_cache_noprof+0x1bc/0x588
>>>>> [  297.704111]  cxl_ras_inject_set+0xcc/0x3d0
>>>>> [  297.704112]  simple_attr_write_xsigned.isra.0+0x198/0x298
>>>>> [  297.704114]  simple_attr_write+0x44/0x88
>>>>> [  297.704116]  debugfs_attr_write+0x78/0xd0
>>>>> [  297.704117]  vfs_write+0x1f4/0x960
>>>>> [  297.704119]  ksys_write+0x100/0x220
>>>>> [  297.704120]  __arm64_sys_write+0x78/0xc8
>>>>> [  297.704122]  invoke_syscall.constprop.0+0x150/0x200
>>>>> [  297.704123]  do_el0_svc+0xd0/0x210
>>>>> [  297.704124]  el0_svc+0x44/0x138
>>>>> [  297.704125]  el0t_64_sync_handler+0xc0/0x108
>>>>> [  297.704127]  el0t_64_sync+0x1b8/0x1c0
>>>>>
>>>>> [  297.704129] The buggy address belongs to the object at ffff0000dd6ee100
>>>>>                 which belongs to the cache kmalloc-rnd-09-96 of size 96
>>>>> [  297.704132] The buggy address is located 24 bytes inside of
>>>>>                 allocated 88-byte region [ffff0000dd6ee100, ffff0000dd6ee158)
>>>>>
>>>>> [  297.704135] The buggy address belongs to the physical page:
>>>>> [  297.704138] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15d6e
>>>>> [  297.704140] flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
>>>>> [  297.704143] page_type: f5(slab)
>>>>> [  297.704147] raw: 017fffc000000000 ffff00008001c1c0 dead000000000100 dead000000000122
>>>>> [  297.704148] raw: 0000000000000000 0000000802000200 00000000f5000000 0000000000000000
>>>>> [  297.704149] page dumped because: kasan: bad access detected
>>>>>
>>>>> [  297.704150] Memory state around the buggy address:
>>>>> [  297.704151]  ffff0000dd6ee000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>>> [  297.704152]  ffff0000dd6ee080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>>> [  297.704153] >ffff0000dd6ee100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>>>>> [  297.704154]                                                     ^
>>>>> [  297.704155]  ffff0000dd6ee180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>>> [  297.704155]  ffff0000dd6ee200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>>> [  297.704156] =================================================================
>>>>> """
>>>>>
>>>>> Define CXL_HEADERLOG_SIZE as SZ_64. The trace record's header_log field
>>>>> shrinks from 128 to 16 dwords, but only those 16 were ever real data,
>>>>> the rest was always junk.
>>>>>
>>>>> Fixes: 2f6e9c305127 ("cxl/pci: add tracepoint events for CXL RAS")
>>>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>>>> ---
>>>>>  drivers/cxl/cxl.h | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>>> index 1297594beaec..f322d7c79ed2 100644
>>>>> --- a/drivers/cxl/cxl.h
>>>>> +++ b/drivers/cxl/cxl.h
>>>>> @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>>>>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
>>>>>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>>>>>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
>>>>> -#define CXL_HEADERLOG_SIZE SZ_512
>>>>> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>>>>> +#define CXL_HEADERLOG_SIZE SZ_64
>>>>> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
>>>>>  
>>>>>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>>>>>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>>>>>
>>>>> base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
>>>>
>>

