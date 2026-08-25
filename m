Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4B3F483D;
	Tue, 25 Aug 2026 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651420; cv=fail; b=VvG4xE3rFFCMmjAoJK8tYTKd2dg42jSTYd4EcY/JYxFd34djF2pm6gp3NioEy+6RzIWS0MvQfLgNGTYbh0Ih+m53a03D+3lFVWPvYE1dekJ0aCod9mtEyJEdL5UpugyWf6XW6GPOkNcZEkrw1bpVPuQt0mQlmV6ZAvmzNnh9C44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651420; c=relaxed/simple;
	bh=cu4M+EwjE5EZ7WcyVFJlT9dWef7daNoALUe9PpGbZuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ptGoQh1Eiw8roZv5cjycrqnVG4svhstRLJTwwqEK/W0M9cKCqeKgLFWuIYDFIttwuyRvrGEcD0jurSzq3PnB+GJN81e2IXAwEH9OIS1exAV/Qo8DxaEHLaufZxNY6CKZs3YmoKPYiD5oMjiVNI31ouVjtFbuzhCRyA8uIR4YDT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OSz2gCWF; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OSz2gCWF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr1dgDllKlfJbpVmDOPbSoL7K6vlNh/u1SzH3eGhLXFOLFwtHkIbY/SkuQywr5RZzH4Ms8EX6Oy1FLtlvQVrzgyE/es9igF/eznpBLr2QEHfBUCOIhHScBgj+1Cy28ULxYvQWW8veK0Jc2nEizkWBTZttLEnaIvJmhmXoKYBvsWFwuT/SGWFxxNEBPvyGNI9WDYp+XVrwMrrQ5NlomNs+JcCdpmvsEEwC40dyBvIOna9pWdAK+B2zJWDHAR+dwLxn668duGbaAQpceY0EH7y01P8YS6eKM6wIwQR9sbNeKccqrZWPDqMCZ8gHbBxpABGa155eHFndDd5CLTYZspi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlmKKNvDmCoWmpdnVyrKTZs64rxlBQuSXJEEwx+sG2A=;
 b=NuRtghNiXmynJy8Wm5CvmRerUQ7UxtOxtKuKpzFPouWH7BwExEQAYha1fFKXyOSEo4kCnKCPTvU1GSmSuvgoYHnfX6FqiPg+l6cKJPG1EK+NT5ZhX7uAYubAXh6/chxsh+KlpMosbjEHugHGBpZFhWRhS/fTBLaDMscUGM7HIJO0dWi/UgKkThfjPiabK5RMV7z/9DmsHxIhFiKtSP093F3jf0NTogX9f0HZyE3M9vCj9WospHtCnzrR1nzZR0GEEMPAAMor8jeS7ene018mE1yFvpNUBCFIlBR2mh+NWagZBohIITGrdQgPqo2WNeaMWnG77glXXBKE82DVC+7cHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlmKKNvDmCoWmpdnVyrKTZs64rxlBQuSXJEEwx+sG2A=;
 b=OSz2gCWF+D+alO8sWmHVxpsOTUPDzdDH6c+myZUJ8cK2wWn4lWz/puOS9XJBRnLLa6fzuONSN+RO6AJEwqefOYFw3BRQyWx6cHL9PQsgWCrSguXCDwY5G/IERKS4OGy0QoU2SM6ZdbH8K3DVzn8U5hv5DCabZ3RWqLd8fEQ9BOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 09:50:14 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 09:50:14 +0000
Message-ID: <53689d31-3707-4c15-9eb9-eb6c77ab3ca0@amd.com>
Date: Tue, 25 Aug 2026 10:50:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com
References: <20260805074042.30173-1-icheng@nvidia.com>
 <a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com> <aobIoBYBACGlJ-OD@MWDK4CY14F>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <aobIoBYBACGlJ-OD@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::7) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d19b8c9-2c4a-414b-1df4-08df028e42c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|6133799003|3023799007|22082099003|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	A2Kfl2AFCYdh4NEEeTKv0whKVLWe4zof4zL3gG/85FpVHvCxJWYIVky+51xLH8UaFREvxYO8MF6kB3JdHmF4ivUy/SAgtWeeM40Wd5o3K9+HIPUhtQNtxhAwHp1ag+JC23JMTDNNMrmGMPCk2xIuqJ2D3Mcof9X2kIVeouD2cA1LWZ0vsukhcEtEelIB6n+koZHMIbXpTKd36roBNQbO98wwM7TiuL21P/ZDdhSyjgY4qIt2wc5lomym8q+GiBeTFH61mi4XfgwRCbCJEyiqiiAgCm58Fe1i8trNoRtl+uuZfMCcz54E9i5kjAsX6BR5GSnQMXNTOf1ME1Z8aZFZGOnwZru4zyAQTg9OZ51jkvU1yjW2pyhVPaoCNFCmx0mZ7EGerV34Gr0YX4B5wy7PWQS/dfHbef8wB0S894mYPxcBF5wJ7+WidMoCvPuc0sKrBqa3SHhikLzM2DNMSHp5npSTMC82V7gQ2QBtcIEey2qUlibOS9NN16La1bW0rVMuDuEYnzhqPdcFdzIGi8GmpYFGqxExY5XgAjWIWTG7XApef6eKptUWPfpYnhPhjIpT5n9kFNjg2/7q2DFx7X8G88TlBEBzSLYVTnCe5fYM4+8Xlto9AtdRuHD5KJJmksJZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(4143699003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGlBUytZUFZBT1VlZmVkVEhJYjhqZ1M3ek9zOGFZTDJVcExCODRHT1lkZEto?=
 =?utf-8?B?eWV4cU96emxiVytpV3FjcnVhYkJJbGd4S3RsbHhoK1c1QTBRbU1rOVFHVXpB?=
 =?utf-8?B?Z1RqWmVydVNYaFhBUGM5OFhMNVZFVjhhNi9Sek5zcDhOVmpLNTdpTlE3dlRo?=
 =?utf-8?B?RUZqQWZiRlgwaXZlWmdFVHVWTUc1cjUwMUF3WjROZnFZTCtVOXRuVWxjOHg1?=
 =?utf-8?B?Uk45NGlTUURWWWo3QVRnVm5QN1kzRXNMRzVONnFyVFZNMHR2U0V5QVdyV1F4?=
 =?utf-8?B?Ri9FYVFiTnhUM09kMFFNdG1DVmJtd3hZTitPV2szcStmdWdMYW5oVWVnR3ZM?=
 =?utf-8?B?VHo4OTJHTExKVkhjc2RFZVg0Qm0vWUhuMzc4QmJ2ZjdlanByVHdyaG94YjJU?=
 =?utf-8?B?UHRQQ2VBbWZ1Mk1GUVl3cDMvWC9wL1A4OGFBbFNvb20yRWk3VTRkbm1FczQ5?=
 =?utf-8?B?UjZua1NaZ0RYSEpDSFp0eENnbmI2akx3QW92K0pTYzhFQkJQWUo5VWZNMXpX?=
 =?utf-8?B?VmI4OVNvalRBc3FIR2t0Sk0xc1JBcUsxWjRHUmlXZVNqdUpaMDZrREtqWnZH?=
 =?utf-8?B?YkE2elorb1ErRkFONWQxeVF4czhWRW5JcTN2Qk01RXpFVS9LUXVtOGFjb3lj?=
 =?utf-8?B?WDJDdTZGazlsa0t0bUMyTERBa1RjNmE2SGlpVjhzQzFHcEJFREVHUDlQMlJu?=
 =?utf-8?B?bzNQZVo2MmdxT0VQdUtMQjFkMU5pVU5naVdzRzkrblJyMWZ3d2lOaExZT3N1?=
 =?utf-8?B?N0xTdGEvQy9DdVBBRzcrQ0FpRVh4V2NGaVladnRWbTRldlNDYlR3cFZLWktz?=
 =?utf-8?B?a1Z3RmtuQXIySzFQOGZKRC94ckRPQTF6VDQ4YzRXUlppejBJUnNyVlo0dm8r?=
 =?utf-8?B?VzA1Z2RhbVZTRWtabmtSenJrcWNENG1nb05QajNTTmxqUXBmcTd1QVgzeU1n?=
 =?utf-8?B?cmtmOUF3RDJXamp0NS8vMCtrNEN5eVIvSDlCSnR1ZVVBdlZKUDAyWitrUjBO?=
 =?utf-8?B?dXFNU1BBTWdNOUpGUGRQR3JUeTFXUkEzQ1BUUlZXRkxPQXM4ZitDdVRCbXhk?=
 =?utf-8?B?OUhia01HRUdlLzgxMlh6Y1FSQkxzRllHckpFSElxenorcGhORDFFRHRRL24x?=
 =?utf-8?B?Nkg5SjlubmJUZmRIZzMxUHNUSzh1enlyajlZbzVnRnh2VGhNNlkvNGV5d0FT?=
 =?utf-8?B?SmVXV2JnN3VyZW5iYjMySFoyeU5kdWcxd1RDeU52bnh0b2pGTjBROU40NUdF?=
 =?utf-8?B?THFtRy9hakUzaFRWZUlEUEZEY1hOelQ5NThCKzlCZExKcWFTd1hDM0ZaWFNa?=
 =?utf-8?B?VGEwNXlVRHpZZDNGV3dlbW0zdTJXVGdYL05HUUh3Ny9nTGJMaWV4emxVUm9t?=
 =?utf-8?B?STFNeHN2eXFYbU9ML3piSVpvTkVWR1pXZmRJY25HaDFiUnhYcUsyUHdSUjNN?=
 =?utf-8?B?YUNTemthamsrSGhYaS9qVStOb3JBeUFiTGRmWU9rbno0UVo5MGVqOVRhZzRv?=
 =?utf-8?B?UDNlWmp0Q1gwajF4SlYyL0ZsdTR6UW90bU0zM0lvNTdyK0RuZXMvQ2hXRytZ?=
 =?utf-8?B?YkdsQWVtRlo4WUJFeThpUW1uUCtDeHB6Mmt0bFExRlhyZlJzVTdPR0ptczBw?=
 =?utf-8?B?NWI2dkM5NkdkVXFaSG0vWFJhQndqeFdiNkVDN3AxMWJ1aGFZRHdGaitPVlBO?=
 =?utf-8?B?VzJGaEs4YWJIS2V5bjArVndsN0JXZWVVOGdDSENiMll3YStHd1VtaUVkSmJN?=
 =?utf-8?B?cjJmZnZOV3M4eS8xYTZWd0wrL3oyYmIrMnFESjhJQzFRVzJWay9GalMyNmhL?=
 =?utf-8?B?WGFmL2RFdlN2bmlhS0p4R1ZSMGprN29JV0Z3aUJrZi9Xd0hTWTBvemNDdUFm?=
 =?utf-8?B?TlBkY0FNUWE3WGFkWnpYSkM0OHhaMlJMcHBYSVBtdDlhdjBXUmR0Vi82bnFn?=
 =?utf-8?B?eWNPWXlYTXM4ZWk5Z1dEQ3FhS1FlME9OVVNKM0dBSnAxd3ZRNVh1WjFoNEgy?=
 =?utf-8?B?QUlUcVZQRnpXWTFPc0dOMEE4VVJ2NGxJajR0YUJBWGRhWUkxbnhhNHdub3dJ?=
 =?utf-8?B?bm1mSEp6OGpJL083RlM5OVRmKytlZERBVFBDU0lSeXJlczFCczhaZGo5OVUy?=
 =?utf-8?B?M3J2UnhlbXI0NDY5U1pFZ0lrdGwrK1ZWNHhLSEM1MThyU3Z3L0cvSHBkYi9s?=
 =?utf-8?B?UWZtTGxyN1BVU3UycTR5WVJYak5lNUVDU2dHb0xycUIzSEVSM3NlUnFpa3pr?=
 =?utf-8?B?cmxDb3RFa2lGKzhQZ0hJSWJpMHBjZGFVOXE5RS84aGdadkVOa0ZSMjlWaWR0?=
 =?utf-8?B?Vml5MVYxbnphcGdzUXc2bUZrS2c0MlFTWFNEQ0NqUUxndlg5QjdhUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d19b8c9-2c4a-414b-1df4-08df028e42c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 09:50:14.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEitoYmk5rRDLjQd8B7YZnsUZjPVTvh2wtKdV1PioJC8mfP7bwB9E7NxJChNn8r2YXfYcRnyF8W8dKWTY1QSbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001

Hi Richard,

On 20/08/2026 10:41, Richard Cheng wrote:
> On Wed, Aug 12, 2026 at 10:58:02AM +0800, Alejandro Lucero Palau wrote:
>> Hi Richard,
>>
>>
>> Some comments below.
>>
>>
>> Thanks!
>>
>>
>> On 8/5/26 08:40, Richard Cheng wrote:


<snip>

> Hi Alejandro,
>
> Thanks for the review and explanation. I've read them all.
>
> I think you are right that this RFC doesn't currently have a production platform
> where the system FW publishes a Type-2 CFMWS but leaves the EP decoder
> uncommitted.
>
> However, the config appears to be permitted by the CXL model. A CFMWS describes
> a FW-established root HPA window and the restrictions governing its use,
> including Type-2 v.s. Type-3 and volatile v.s. PMEM. The CFMWS def also
> describes OSPM assigning HPA ranges from those windows to discovered CXL.mem
> devices [1].


Right. I'm not saying this should not be supported, just pointing out 
the use case does not make sense with current BIOS functionality. I 
think BIOS will/could support a config option for just leaving a Type2 
HDM uncommitted, but then why the kernel should do the same a default 
BIOS config would do?


>
> The Linux CXL doc similarly states that only root decoders are required to be
> programmed during probe. Switch and EP decoder may remain available for runtime
> programming when the platform supports it [2].


Tangential to this discussion, but I have problems with this assertion. 
Any switch or EP HDM programming will need a root port HDM programming 
as well. Not sure which root decoders will need to be programmed at boot 
time: a CFMWS is "programmed" by the BIOS and root decoders will need to 
be programmed as well for any Type2/switch found with an enabled link.


>
> I raise the RFC intended for the question of how Linux should support that
> architecturally permitted config.
>
> The cxl_test config added in patch 3/3 constructs this scenario synthetically.
> This demonstrates the proposed kernel behavior, but I agree I don't know
> whether there exists a deployed FW scenario.
>
>
> And I agree that devm_cxl_probe_mem() shouldn't silently change from
> "attach to a FW-established region" into "allocate resources and program a new
> region". Those operations should have different semantics and ownership
> expectations.


Glad with the consensus :-)


>
> I am planning to rebase onto cxl/nexxt and rework the proposal as the following,
> please take a look and see if that matches your imagination or not.
> * Keep devm_cxl_probe_mem() behavior unchanged for FW-committed regions
> * Make region creation an explicit request from the accelerator provider,
>    rather than an automatic fallback during memdev attach
> * Have the provider specify the required size. CXL core shouldn't assume
>    that it maybe consume the entire volatile DPA partition as you mentioned.
> * Separate the reusable region-provisioning mechanism from the initial Type-2
>    policy.
> * The common mechanism should handle HPA/DPA allocation, decoder-path
>    construction, commit , rollback and managed teardown.
> * The initial type-2 caller would constrain that to volatile DEVMEM, IW=1
>    and a provider-requested size.
>
> Oh and I'll replace "x1" with "IW=1" and explain the initial decoder,
> root-selection and granularity restriction more clearly.
>
> How does that sound to you ?


It sounds perfect!


FWIW, you likely saw Gregory's comment (discord) on this work requiring 
the support for PMEM or at least the awareness PMEM support will need to 
use same interface. His opinion and mine came from Dan's vision on this, 
and your work will be the base for such PMEM support. I do not have an 
impending reason for working on this PMEM support, but I am really 
interested in how Type3 PMEMs can leverage CXL.mem for improving storage 
needs, and currently reading/thinking about all this ...


Thanks!


> [1]: https://computeexpresslink.org/wp-content/uploads/2024/02/CEDT_ECN_1.0A_Eval.pdf
> [2]: https://docs.kernel.org/driver-api/cxl/linux/cxl-driver.html#runtime-programming
>
> Best regards,
> Richard Cheng.
>   
>>> Testing result is in the following.
>>> - Built clean with clang/LLVM on arm64
>>> - cxl_test, type2_test=1. accel0 takes the unchanged attach path. accel1
>>>     drives auto_create -> a committed 512 MB RAM region. The test asserts
>>>     the 512 MB HPA range. committed state and 256 byte granularity confirmed
>>>     via sysfs.
>>> - Unbind tears the region down with no orphaned decoder, rebind re-creates
>>>     a fresh committed region.
>>> - Mock test only. Real accelerators whose FW commits a decoder take the
>>>     attach path, and vfio-cxl binds only FW-committed devices, so auto-create
>>>     has no real-HW caller yet.
>>>
>>> Best regards,
>>> Richard Cheng.
>>>
>>> Richard Cheng (3):
>>>     cxl/region: Reset software-created regions on memdev detach
>>>     cxl/region: Auto-create a region for memdev attach
>>>     cxl/test: Exercise Type-2 automatic region creation
>>>
>>>    drivers/cxl/core/region.c      | 422 +++++++++++++++++++++++++++++----
>>>    tools/testing/cxl/test/accel.c |   7 +
>>>    tools/testing/cxl/test/cxl.c   |  61 ++++-
>>>    3 files changed, 439 insertions(+), 51 deletions(-)
>>>
>>>
>>> base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
