Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A75262FE7
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854350; cv=fail; b=jWbEx0581u34KMzWe4am37BNHnX5xEQur+/oG+4FGDpxKo6i1h/yuJC4F/jy/heIfHZjXb8q7V/Y+KoIBQ3S5Lb+6f0KoxYeFXLrnsTKU7LVinzst6VHO3L6zVix2wfuTwaNAyDO0lt2Y4e4EYfoyM/erd/JhltsYo88bDU5K2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854350; c=relaxed/simple;
	bh=DOgoXPFiI/qOdErIAGY0MF/OWsDUlBoWN6pEoHi990Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kFZXYbtZ6NnlyOS3S3WJoibTgr8FCIZKxyAVxcP4rtb4TJC94wmVqP++Sf/WVOuGzrV2if4SyWuzIYBBIuiTRbkDK/WG+5CGYf40zxjyUClFSpLAEtNktfgwlalfH2zC9X16mTwaZ/L2hauMKq8TZ8I6XBDWqgGeYkldfWM8JVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JfvTMnV9; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JfvTMnV9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On/J7c59dDZ8gVkhe/IolXBd8fvBz/l/F7s54VjtVUYQtmhwmkr0fTtASCn7901jt6I9N61VRQDo9Q4kYU7Glg0DCCTPK1W+Ffc1Y917xnEd/jEJzH6v+Uc7V1fdfXhZZjtfLw9A0Wh0f5dvyWyDAWf9FLYOTb3QxMN28mqAWWx+vb7fqkokZu7WHtqP+6KFr9ZjZVzU8m2z4IAGloIC6mv4VCj8CdXJWDg1GAjWEM0mszqkyLULFQDNAKRhuv0TprftN49q4kwJjn6V8kPxRq5R0Ce8tcEqQ25D5ALmtBY2q1kXLECQuDgQnF0JU62KALYkAlK/Nwj9w50G+DG2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnf4le21+ddAJm7o6wZguFHbDW62ozof44yVm7r27Gc=;
 b=JljKceuckPJCiYFxfa59FQiLUBgiRBwuzfJCoYFXq3BbUXoo7WSBdVKKY5w+jw54/kx4EbS4c5JHxHchfW1AO1fLLRzo3UiOmEgE36pG5FxsdrRUr4evvg3uNFNP+dhmSIlDvAXDUkZw/7E9ssmJKGydDE7iaXJWhvpm4X7Gzm2xrujE+RidFKxzrbYr7PMTrV7AwjjXF4ANkteCJd+mZmjRL0XwWyJqiNtRvvp1ou34FEeyC6nABo124vKEaf3fXlM79DqrYUchuf7QHIpCp4MV3XHmfgTemyMzrebz69ZOdRslPB/tkGzr6F2CkvMenv9X+VpmVu2RQH9tsayLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnf4le21+ddAJm7o6wZguFHbDW62ozof44yVm7r27Gc=;
 b=JfvTMnV9vpeYmjtb5KmqRrKucD7ZXgw/6dv68Q9NuT6QlG2poUWwkJZX0Z1tCiWm/f22i3EGs/5/aXKPlqC+xDgjrj49ngBM7zOA8Y6dMRjKuqBX+2+mbN/1qmAh7BNZmkxwWl4ypCaDyZyHRYO0mQFqmB/0AgjJ9hTAIVKMXZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:19:03 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:19:02 +0000
Message-ID: <2d9384b9-2231-4953-8fcb-7128124e7b4c@amd.com>
Date: Wed, 18 Mar 2026 17:18:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 00/22] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, dan Williams
 <dan.j.williams@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <177370560728.3363103.17662978404400921244.git-patchwork-notify@kernel.org>
 <652bacbf-6985-4bec-b973-684f2702765f@amd.com>
 <ce2df8e5-e1b9-4522-b84b-b721ceb09b26@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ce2df8e5-e1b9-4522-b84b-b721ceb09b26@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 615cf99e-ee48-4e27-a518-08de85127381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info:
	2T/9zZ7CETeIjqxjXYCp1LzsmtQLuZPVCzoiFCqfIxkq9+sGnIY9pdZFx2sLXzH++oS9bjzDBW+B9UxxQzMvqPQhLjUHMG4oEU+BXgUZwNBbMwCWhTsqeF9lO0dcUt8jLxWxYUulSTpUvhYHG3tin4PvpFP5TjNVODFrtVTze0MkFyRI4TfuI0U5n0hzMLBn7QbkSY7y/1p6pfxCO04lcSDevvHu7KFHK6ujdwfHpiVPNJ9HJOXsA+tY3NiObTmzIdUDwxomJh3Cf9RYIEVwzhYl4BoYhZVUK43EMHplnz7XD8GAcv2YK/o6qfMFLsHP0V7ejBukOqL/grYuRbdY/1a8Di/axojxWiWjcyvcV4ZALznrd+xNOB2NQ2zGUEmco4i/uh5pdnF2HL1saZWUZFUjwdqDvdbSMRmjOQ3WV63o+Vo6auqIgI143wP0q4N1xs6y6ziuIWwqFW2ZuZ/pT9F8iYze6TfnBZzuKfM/g63MS58LMOgvmUY7XuLLp2fbMe3dVyykfxBW8axMzh7ymfVVU90O07D6o06cyeKUWyguNV+1wJkN2CnrprB9TD1RVAMBeF9pBLTa/09FB9ZJgTeQFnxFCeq+AdoDUnxtheybdSmmtgZt0VBKwRO21YbvHPs73kETnxOS4bnUWPHoBLFu2iSOJ5Jhm5f+MYQNg+1QnqCq7961s3jS1CejxSPlUKBVsxbIY1qnL9cZFg4UpFvNZJ6FOqbMENR3rMpi9j8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(7053199007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFMV1huY09FLzFRTzlqYlFBWVdiK3lkSXRnS21CaHRjMnlvYWllRkkwajBj?=
 =?utf-8?B?dFZYY0crU2NVdmh3M1hjSnhhY3N1SHRoUzV3a2Y1MjlXcGFtenFGSHNJR0Na?=
 =?utf-8?B?cGhYZFZnUldHa09mNCt4bVBSUjhTY1NrbU5EQXBYaWhOSXhadE1XaGhDTjQr?=
 =?utf-8?B?N2VlTmRjVjI4N0t2d0VxbnVLVFliajFpbTMvRDcwemxaVXQyWFVBS2R3UHpa?=
 =?utf-8?B?Wk9TckJ1bXk4MWtVd0pQdi8vWWQwUkFMYzJwNk8xSFpCUnpJUGRZUDJwRy9a?=
 =?utf-8?B?bjRuQ1VOaXNVS3liK0s2QUZEOHFmcGhIall0OVVOc3p1UHpSbTdzUFFvZk03?=
 =?utf-8?B?NEpkeEU0OEpub0M0bEZpNStxeG9wbGppLytNY2JYT0JXTDdCajZNMCs1QkJk?=
 =?utf-8?B?R0dEZGsvQi9FS0pTeENwVTgxNEhnZS9VdzhHK2dlZnZxc3BBQ0pmMnJmanVV?=
 =?utf-8?B?OFhheE1WU3dqcmVBUDFrdVFEZ01kVUwzVU5adVNVMzVGQjFIREtoV003WGI0?=
 =?utf-8?B?NXpBTGFZOFhIbkJNSWw1Vm5VRUE5SDJLb2UzeGtoNVZqYmZGT3hhc2RyaGs1?=
 =?utf-8?B?Y1NLd2c4TUZyQ1ZGNEVwVnh1REh4L2hIY1UrZ0ZUOUQwUDVLTFk3M3Y3VmpK?=
 =?utf-8?B?VXJIQWFzekxra0x6RVE0Z2YvNExnOWp5VWprNHo3REdGTUdJM1BKUDZ3MmFD?=
 =?utf-8?B?M0xyVmQydGxHbWRCREVQcjBWMFFwem9LQ2Rjamk3eEQ4UUtPQ0sydGV6bkhM?=
 =?utf-8?B?d01wMDRhNHNVK2NtRzBQQURGelJ1eTluVWcraDZUOW1LSjJTV0dZVE1YMjlq?=
 =?utf-8?B?TG8rNzF2Y3g4Y0U0QTFKTVlxanhmTFVqYVhJZmlJVlh4QitxWVh5RHZTZ2xF?=
 =?utf-8?B?cWFCMVhjY1lnT1V1dkFxcmkwTnZUdUdZWE80UDU1QmdJcG53MmdSMndtTjgw?=
 =?utf-8?B?RGdkMHVHb2hPbkRUd0EyaUdGMmpnQVhWQ3NrUmw5WXVldFFSVjhMWDRGQXQ0?=
 =?utf-8?B?MlFlRk82QUV0cUpISG5HMG1iY2ljZVFaaVRuTTNhMzlmWngxSGROR0xWNEJR?=
 =?utf-8?B?elplTDd4MmVacmx2V2NlZ1ptd05NNnhOWWxIQTd0WUJZWkF0eWUveTZQcWhR?=
 =?utf-8?B?T1BrUXNUOXVnL2pjNmY1UlJiT3R6RVlCbGVqczErTkF3VkU1ZXVIYW5BMWl5?=
 =?utf-8?B?a1NHZWdIdU1sQURHQTBhVFljTUZiMFhqY1NVLzhQZjhueXFGUXBFK0tQQjhX?=
 =?utf-8?B?NGV1WWlMaU5ZbjdYakFSc1lobDBjaGVOb05NY1VKVnRlbTVTR0xoQjlTWXR5?=
 =?utf-8?B?aHZWYjV6Q3JZR1ovYVZuSmZQenZOUzIrcEhCa0dKcFJBK0hCYW04SUJ2VHd3?=
 =?utf-8?B?NnZzWUJNZXNoVnJtUGZTQlhwR0pZdTRsMmlaMmlhS2RyYVN5TUVndWJ5Q2FW?=
 =?utf-8?B?TVdQYUtNQW5pUzA1YnBrcFJMV0lDUUZWL0pUWlhvd0NxQ0RPajlrSS9KU1VE?=
 =?utf-8?B?UkVtS2dsNzFsY3hCQ29WdFhMYU1RRDl1T2YveVEwM1oycUdtUjVNVHZaVzNQ?=
 =?utf-8?B?VzBYeVExajZ1ZFY3d3BKOVRqa200TnhxQ2drR1pzVWtPbzRRWU13MVNFRk9H?=
 =?utf-8?B?TERyK2xEbVZlTmtCV0NrK1Q5K3RQWXdpUlRYbER2UmpDdFB2N2E3RVR2ZzA3?=
 =?utf-8?B?U1JDV2hybndqWWNvblN6cjZFKzlhRHFMWkt2dmRORkJDSWs2SkZYZllIbllL?=
 =?utf-8?B?MDFCTVN6bjczQW9tMVQ5LytndTF2MWN1R0dYdmJ3NXB6QnpUZmI2NnRFcGpU?=
 =?utf-8?B?VVlJWXdES0hZOVVidWhDSHhkcVJ4NHkrcWhVa2RIdjQ1Vm1tbFBnd0lKaHZh?=
 =?utf-8?B?VDgvRVIyd1NmQnRucDVvL1pTTU5Pa1loNUx5OFdCZzNVK2F2SlVqMGo3Qk1N?=
 =?utf-8?B?aTVwc1dvaUFJeDQ4WUJtbFFYbHRBYXltSklKb3RWaElHNmxEUnFvbko2VmNW?=
 =?utf-8?B?eHJ5RzZUWkhVQnVZVFNoc1VIUEx3SEtEanRzdDhiZG5CbDZjUVBwTU03UE55?=
 =?utf-8?B?MjhZN0RpY3BJRm1icHMrTTdQMkJiMGxycEdsTUQ4d2JObzcxNkVMbTBtUmJs?=
 =?utf-8?B?UVRXa3hCOWFVY0ppbHhoVjlYcGI2bEFjSzVBMjZOQ1p5MWg4QmVwMVpGYmpn?=
 =?utf-8?B?eEVvQUtvUEI3bEZ5d1hvMGRJZUpCejJpNUNiNGQ3YzhPZkc5a3R4eFV1QXNv?=
 =?utf-8?B?cG4yaXVOTFhJZlZQVkNVOVpQcGhSMkVQTm84SERLWEl4aXA1cnJVRCtoR0dE?=
 =?utf-8?B?NjU3QnRHcWFxK2FhZWRNdGRmMFhFTjY0UHVKaWxwa0d5K3U2RlRLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615cf99e-ee48-4e27-a518-08de85127381
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 17:19:02.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06tZ3MYAhpcpGK+15S6BaPUbHXWXtu566ghsOKGU3qR3iyBq4Sv5hdc0gEkYt2SmOfJTOFTVAey6N3VjENyLAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018


On 3/18/26 16:35, Dave Jiang wrote:
>
> On 3/18/26 12:42 AM, Alejandro Lucero Palau wrote:
>> Hi Dave,
>>
>> On 3/17/26 00:00, patchwork-bot+cxl@kernel.org wrote:
>>> [You don't often get email from patchwork-bot+cxl@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Hello:
>>>
>>> This series was applied to cxl/cxl.git (next)
>>> by Dave Jiang <dave.jiang@intel.com>:
>>>
>> I'm confused with how you did the merge. It seems you applied first the new patches which deprecated some from v23.
> Hi Alejandro,
> I would ignore patchwork bot emails. It gets a bit weird at times. I only applied the patches you split out. These are the patches I have right now. I will push a 7.1 type2 branch for you so you can rebase the rest of your stuff on it.
>
> 64584273dfb8 cxl/region: Factor out interleave granularity setup
> 29f0724c4592 cxl/region: Factor out interleave ways setup
> 09d065d256b1 cxl: Make region type based on endpoint type
> d537d953c478 cxl/pci: Remove redundant cxl_pci_find_port() call
> 58f28930c7fb cxl: Move pci generic code from cxl_pci to core/cxl_pci
> 005869886d1d cxl: export internal structs for external Type2 drivers
> 9a775c07bb04 cxl: support Type2 when initializing cxl_dev_state
>
> DJ


The weird thing is I got three different emails about series applied, 
one each for the new patchsets from the full series, then this one. From 
last Dan comments I thought he was happy to merge all and I was seeing that.


I'm now confused about how I should proceed. Are you saying I should 
directly applied the v23 remaining changes to that 7.1 type2 branch? no 
mailing list involvement?


Thank you

>>
>> I'm afraid it does not work when trying to compile the sfc driver and some files are missing like include/cxl/pci.h
>>
>>
>> I will try to give you more information about what I think is wrong. On another note, sfc changes are not included, what I guess is fine, but did you discuss this with the netdev guys? I remember someone asking about how to applied the type2 series as it crosses subsystems, but it was time ago, after the first versions.
>>
>>
>> Thank you
>>
