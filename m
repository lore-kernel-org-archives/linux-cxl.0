Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B48259CA9
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823556; cv=fail; b=R2kW2r0U3c8ZoU0+w5xA8gkLb9gu1bI0RC1OREf2h98qPiWEl2mrCDhzn9jm/D08YtRwEo/pYTRe4ewSVQ6PB5VIDb8bKk5KdRCs+ItbJEEwGzLK5m3nLIyp6vzxKF1Eb6wVgcbYXrpCMNaDuPfWxd8YhcKdYrwXk8hhnEuPyVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823556; c=relaxed/simple;
	bh=bQmv9CnTz2j/eQAHc2pYyElbzm+zPbr/4GGXi/dXKLE=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pN/khmeyevPNYK8kD1Y7b844djVSJCplMF6Jv5k4czk71H3ZL4WU8HzIe7gBD9oUuGbyHSotLBPGmVVX1Idjo6f+M4k32+vV1QvPSQFvS+V+OjNBEKXv5QSNXSMIA2HrKZ0tWluupWtE4rH/fuDun/Tl0qHSZR6bXKr6Z9rNFWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=exbQck6v; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="exbQck6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGZ4EyDR8Wq0RP8DBoSzWJitc63okbVMU6cunTB/rXLCPlkeyJuUr1sU8suX05/JB9MCtwrsVcSfhlS5etxbxiQn4347IXu4eSoha167S23ZP0OXQCtrXGOLiPK+u8Fb5AoRQkzZ4Iyb9ecaS3sbUB+WkuTmPUIWJRSRceZ+Rg/Cnp35Jxpj2hMKDz706Jf/9e/qMeP9VDWETaKsPoJe7d3uyh2L2ZqKunhYOHAEoo6OP8hPkBKDRA4Bx93H9k6jelUB5efUaUz1IMYw9jPByvN060ADQDtXuO9kvw4kCPuCGCrHVq5n2xZQsnOvKYLeGIPg5fuxE3AI3GxT2vRdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx9niLA/uE0aFpyyQ8brcc5tlUIH6Rkex88+gUuDEJI=;
 b=Lv761fySgZLFzWbDYru/mvwsLfxgthDLBb11lhV8PGVaE383BCMsfVHfRgKlHa2OSrtlnOfLmYvjdHvB1w6NDR13wpiKmZQwVwwITNajhRr4D2xSrsl8rrqkU+5Zi8vke/hCzFQnsxyZNEWr72iAEfvZw3qRzNJ8ACBHiCzIRuAr19K+nMbeMGL4AIVzkQt4J00b7wpkOBbQqVRIejqwICTnGX/bSXZNmP+rjLgHZakrt/HxvHxZkKAN9RWz2q9ubzU6oFODOvjRJM2pbxo/nv115mloaKWGQeKpNBxi4Yk3bcFk+e+L4Ua7NIa26gRPp/msISD41BZCilCKqiblvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx9niLA/uE0aFpyyQ8brcc5tlUIH6Rkex88+gUuDEJI=;
 b=exbQck6vD4u1nhBTXm4y32IN6oP7yTuKdFClFEwKY25GT0peBP0fbI+yoxhrIamerEmHMYr2V+bZmBMq5w4BPn3kSRRVJ4gfERwl6pWu5G8oZdhIfzb+FU47HyXMS8pUwS3FNvPXjXRmsxtFG8BOMOEwW1qNtEcma61/PVYRCIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:45:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:45:49 +0000
Message-ID: <ead51557-09d6-472f-b025-f6404db3b512@amd.com>
Date: Wed, 18 Mar 2026 08:45:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 00/22] Type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dave Jiang <dave.jiang@intel.com>, dan Williams
 <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <177370560728.3363103.17662978404400921244.git-patchwork-notify@kernel.org>
 <652bacbf-6985-4bec-b973-684f2702765f@amd.com>
In-Reply-To: <652bacbf-6985-4bec-b973-684f2702765f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ea56e0-26f8-426c-8897-08de84cac0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iCQsN5wBh8TnmElCnNvU6ZbZFPYGgRZ/hQTLyF0BEFEd4qY5fXOUl5omNDdDoFkIf9aYglkpseJL7ErMhTfRmXbSUsVzCZJjYgjjOql0P52/f8LNbSuaM+tPlj5SC3RqQlJ+YCOHZ1psoLnW3gbLEjW2uBhF4LEgr8UZTMSOPP7QFjsvy44k5QVLv3wyrfOKSSv0GNUB7OshjNZbj/FBLsfMzZZNzpFAO3fLaIbciHir6LTf3To8kUQmk+XCfLlOFmbRftGhTsK4FZfa2zVc+3v7DrBOr6KF3IvdHTHW+J2d/OZCN4DR9z8VomRBZVPSykO8WDrE+ERA81WOxJDkFIgOuDR35rCDvTZIqJxvZAlAKvZ04yAyQFgMRg7UcdNhNEDZbuEvcUgQkY9md7zyNfTUd2eWDq6fxoJUyA+jX63Puz8q9gYFk7FgBtAgarv5n/j/F0G8cRwrOYi5ETGRlxwyuLGvM4jRHsAJjznLrpVbXSrGKxhVZriSHOol/seJSq7a9uXV2UUlwqhVf1j3k03PAfi7BE7Se7wUGl+H/HI6rDvlXAQUhEl/nwsjdQMW578nzK8UoAGmtu3MPpZfv197YBYcFAb5Amz2Dw2HPm+mA/Sbu7gr06sswi9HsGz2icSnXB7tEJ3BFqmpfnACVmRWtEOAJdgeQDBPCnCf3IPAtSLuGh5zpkPgsWCNaK9FOS2K8TCTikZben2SPlSePQvzT8fWp2EqIX0gfXw91NQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vkh6RWVRc0YycGV3SDBOYjhRNW5OempHeVBMMHRjbEZVQ3Q2RHNqaERlcks5?=
 =?utf-8?B?YVoybUpoZ09SUFRldHVNWHh0dUV3NUtSLy9ZTE01M0JDWXFYMnUyOXMzdWth?=
 =?utf-8?B?aytjem1vOHB0Vys1N2p6em05MldxcFh6K0dxdG1CRTF1alFUbHBFNWJOa3pi?=
 =?utf-8?B?TFNxTXBzMENPUTNwcDJ6U240Qm04NXdERWYza3kzVmU3NmwzYlZwamFRTmRh?=
 =?utf-8?B?SEZReTFlOFV0ekNpcUt3ZUt6TXgvSm5WS2k5QXhvTUNXUG5FNWJxclA2ckdS?=
 =?utf-8?B?YmlFaXcwWUJvQldEUjdPUXlrRU1RWHkyV0w4RWZWQjc0cmp5bnBRNkozVDN2?=
 =?utf-8?B?Z3FVODdNNTBPK0hCYmFKSkx6NXRaTHpZTE9ZZVhScTBBazl5RWVVUHNQVGEr?=
 =?utf-8?B?SFdUcndlN1dpSndQbTR6cE5RRHZncnpzZ2VNcTRUME1wRnZNWWxzM0x3SWhT?=
 =?utf-8?B?eGd4VHQ0Qjdsc050KzBsSzZzNTdFUnNIUjZHZXZ4d2ZleFBkVnZja1cxZnJU?=
 =?utf-8?B?MnF4bWhxUXhpMWsvMCtkUzM5WFdreUhsZEpma0tYdVBFeU5UV3JtTDl5anRH?=
 =?utf-8?B?OWlnOVViUmk2SkoyeTBNUWZlS2VoTWwyMVdubzM1bGVkVkd0SURtbFNialc4?=
 =?utf-8?B?bVhGbitBd0VROFBEVE5jK09QN0psM3pnSDVNc24xT2ttTDR2Y2JNMnR5NG14?=
 =?utf-8?B?UWcxTGJ4ZUFHUG1nckdyNVM3Z0JkM0tzM0lMSzVnUVNQd2NGYS8wOTU0VGVH?=
 =?utf-8?B?Q1lmY3pUck52VTJURlNQSjNFV2p1S3Q3WlZRd1BtNGxnVk5oaTBaYys5VVh6?=
 =?utf-8?B?NDdUaUt2dCtLQW1TN2V0bmVuSVM3VkJudHBsU2RNdDdodTFUdUhzeUwxRHQ3?=
 =?utf-8?B?OThybEpNb2YzMHhoQ2F4ejNGL1J1NlhoTmx6bmMxNHcrOHEwcFRxL3Vib3l5?=
 =?utf-8?B?b0ROOXBwNHpLUXVuRzh5bzFPblBGY3hKMDhIZmxyVXBpVktFcGFKL1MvaFNE?=
 =?utf-8?B?Q1hVZ2FNQ05EczNnTUhjckROSGZOWko1N3RncWFHTWs1WHR4TjVya1NrQ0Vk?=
 =?utf-8?B?YzhpaHBrSlhBU1poWXVxZVV2R0pZYkFQdWlyS3FUZVlBcVNDQjUrU1pPdHNZ?=
 =?utf-8?B?cGVscmNieWgrc2E3TGl0WkZHYi82V3QzVjVIZzV5TnJiaWh4OGk3cVpUZ0VJ?=
 =?utf-8?B?dnpnUlVSaXYrTnZrTE93S3AyeEd0TnlqSGZLdmd5SmRCUzFMaU9GWklONTZJ?=
 =?utf-8?B?ZEhySTlzK0pFNnJrT09janR4UXJrZ1BlSndEMllZTkxOKzAxNkRoMUlQdFRq?=
 =?utf-8?B?VWNWc2xLTnpxbmFiZHZidzdtUjVZZ3V6Y0dKa1hoZkMyRnQ5RnJRQVZxM0Zy?=
 =?utf-8?B?MXRuTVRVdExUQ3hqb3Z0TzRLeTRhWEkyakxFd2ovT29WWjFlYUdmMTlSbFVM?=
 =?utf-8?B?QmFPNWxIMVlyRzB5dGlPM1ZyYnZma2Njd3pJZG4wR2syQXJWQjk0dEwrTHJh?=
 =?utf-8?B?Y1hDeFY3N1U2QVY0TUxMKzhOY1dScGRPSm9ZQVBaSk9IcGw1VXNEZXJWd0V4?=
 =?utf-8?B?SDJBMkNSOEJKdEx5M0lmL0Qva2YwMDh1SjROZ3g0WmVqckZIM1FYcHdDMUZ5?=
 =?utf-8?B?RGZ0Ukx2QzV6eGhLZnVKZ3YrRk5DYmdpNlRkU015NENvMGpZRG5Gb1RqTElh?=
 =?utf-8?B?ZUUvbDkxUGczOGlWOFo1aFpWc3FaZ3A1aXNhZnpxckd3Um9XQytYZVN1RWky?=
 =?utf-8?B?dUlMZEdudUNDNC9iblJyOGxUWFlhWkJTZ3RZUGRaNm9DRWp2a241TS9xTXBh?=
 =?utf-8?B?VS9EM0cvckhJaHpQVXpPcWlYSkZrd2VwTlY2cngrY0ZXc1Z3aG0xeTc0Y2Fy?=
 =?utf-8?B?T1BDMy95VUhoNlRNYTgxQ0dxYlZvUGcvc3BZZEJiMWZQbjZWcUswODVEZmZv?=
 =?utf-8?B?bFdjZzRhK1BUY0t3OW9iR3AzY0swaXdBVTdscTRpTXZ2S1NkOVFjYVdvVXNM?=
 =?utf-8?B?KzIxTGUzdkJxT3hlSmZoWGp1ZVNIRmZxb2VVRzBrWnFvdmdBS0RPSmtFK3Fm?=
 =?utf-8?B?MDJDZ2RyYXBXYVdxTzUydU9TOCt1ZVB6R1R4UDNxNWtvSHlNbEs0bHFZTHRL?=
 =?utf-8?B?aEdxdFZZajljQ3U0Qm9XSWE2clpvcVcrUHEzZmRxdGlBOGRhdU55cktmalN2?=
 =?utf-8?B?eHlvbHJHYS81bXBmWEl0ZkZlcWtuYlU0L25MUTJnY0VNS2NldHBNWEl4SDdJ?=
 =?utf-8?B?V09HWHplUytwL3hJUGFWZkR3QW1iM0lkVjEzNFRtTHBjS0cvNnBRWjNOeWFP?=
 =?utf-8?B?c2J0cnpyYzhtZzFXTVRacVplZXVUOGIxSm9LMnZSbXdYVUF4VTFwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ea56e0-26f8-426c-8897-08de84cac0e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:45:49.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KM9KUFpCD8Fm9s3zRpbi4Ys2GA79Q1nS5xilXQJtZChgIUg6+fjZyHWNXpvUceh5hbSN7cHOUuOkqkhfz1ifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383


On 3/18/26 07:42, Alejandro Lucero Palau wrote:
> Hi Dave,
>
> On 3/17/26 00:00, patchwork-bot+cxl@kernel.org wrote:
>> [You don't often get email from patchwork-bot+cxl@kernel.org. Learn 
>> why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hello:
>>
>> This series was applied to cxl/cxl.git (next)
>> by Dave Jiang <dave.jiang@intel.com>:
>>
>
> I'm confused with how you did the merge. It seems you applied first 
> the new patches which deprecated some from v23.
>
>
> I'm afraid it does not work when trying to compile the sfc driver and 
> some files are missing like include/cxl/pci.h
>
>
> I will try to give you more information about what I think is wrong. 
> On another note, sfc changes are not included, what I guess is fine, 
> but did you discuss this with the netdev guys? I remember someone 
> asking about how to applied the type2 series as it crosses subsystems, 
> but it was time ago, after the first versions.
>
>
> Thank you
>
>

This seems quite incomplete for supporting Type2 drivers. A lot of those 
exported functions are not there:


ERROR: modpost: "cxl_get_region_range" [sfc.ko] undefined!
ERROR: modpost: "cxl_create_region" [sfc.ko] undefined!
ERROR: modpost: "cxl_get_hpa_freespace" [sfc.ko] undefined!
ERROR: modpost: "cxl_unregister_region" [sfc.ko] undefined!
ERROR: modpost: "cxl_put_root_decoder" [sfc.ko] undefined!
ERROR: modpost: "cxl_dpa_free" [sfc.ko] undefined!
ERROR: modpost: "cxl_set_capacity" [sfc.ko] undefined!
ERROR: modpost: "cxl_get_committed_decoder" [sfc.ko] undefined!
ERROR: modpost: "cxl_request_dpa" [sfc.ko] undefined!


So this is not just the sfc not having the changes for cxl support but 
also the type2 API not being there.


I can not see the for-7.1 branch in the cxl repo, so I can not see what 
the merge did apart from what was merged in next, what as I say, it is 
incomplete.


Let me know if I can help somehow.


