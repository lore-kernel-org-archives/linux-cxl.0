Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493F46EF6A;
	Fri,  9 Oct 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529151; cv=fail; b=LUzpKP/ZPKesilb0cV3Hl7WlBkBNNwYCC4znO97PC9gNEqwil39IHOk3HnXCxmThwwmAUSJyuW9cKrIg5RcLaTSeN1CXCaKUVjLHZqc/meEWgVPR3pmfs+QdeUxXBUjL9XMvIl4fxFjPft1p5xK6NFtBfFpiRDfYH44SbiHHTN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529151; c=relaxed/simple;
	bh=iMVlpZB9gJc5xHu3sGaozCoLIv0U9r1YBvVeOq9RCIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NF9lXaoyO3++qaXBZN4Xe0iNs4VvlmqEK3AXNOa6E8HM/71+hPUI2QbTrQb/bwVBtTRC6iEet10QNWKi60l7izO+O3EfHyWVEWznbxc9oMAcPPGoxuTpCDX0iV7PXVkGB0v0UYY40CFBxOwJtuEiLDSrPjfAPU03cFVLSdQdVmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n36/a4XF; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n36/a4XF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQLkhxnkQAo+DUgsRNQ8iFZlIpSmgbcnjLZ7v1Z+ZWo+69Kjdq7IChj7BCyTjY+5UhSRlfbwrxW7VPjUeFJ9h/tadQ0qdDqsP6c0+DgFMgmoVgp4Z1gfnE1dgEbq8K5XNECX2IoOXzEeMcLozHs5jg8xcHe5zVS/GUZ99ZDhn8ZiqJOnB55lEquSYNy5mZgGo5XGd5i4OId2tnNrlDR0R0uo09BTehFR5cwiTLtCKpL9NtFMJH2Ot/0fyicydopYNwHbdIYXHUYBLYipGQh0KC3xijuDucSarShqbEpSHnB5Ew68NDtmuW1uPouYfGvgfsK+Abe2EnefnnE6C367VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAFaFMTPIQj8yhm0GObbFR6umZ8PsXERs8zN2S78FPo=;
 b=kQosgn9XnSBizkku2OS1dxJuBwUFiTG+7hI8KqQ3kWh0FWaJ8aLAuP9L9/2F1B6xv1TzqUJrr58VfNu4Dwid1p2TmpVT4+5X/7TA9hLpDp8FCtK/DZ4Q5RqZgHGU8D/GaXQ6kLzfizJOlXh9CqQEQyRURfTf58Z562SpIAyX3zhP8yQ3Wxtx1cDfgoxPHh6KmC26vW9fa5Z0LRJ/wGeko2Zy6oyKOV1UAqaGwIFvoQbOlWK6WN0v8anCJtyVWlEoSValuuHQJw3bwncvkL0Yh5dvMqCouLOsg8cG1syjxkFUJmCyjQIx7JcKh6iaFTTpu3B3ifaiT+3SpUxZW4nWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAFaFMTPIQj8yhm0GObbFR6umZ8PsXERs8zN2S78FPo=;
 b=n36/a4XFRJFz5M0f6Hcid83O4ouV42cB2WMpvr8vTK/FnC8BL31CY6eKUqaf1+N03V/YySwt9qg7YhdCihEk5TEuJeMAamvOXH2eK3b7r5xkkINajnp/Ldti2zP5dusrj1SDmZut2gyOO93mVv/QlB3U7zHBp/5ecRxbqGFWIAs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH6PR12MB893224.namprd12.prod.outlook.com (2603:10b6:510:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:59:07 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 06:59:06 +0000
Message-ID: <61a45ff4-e2f6-408d-a9db-26621bb4b361@amd.com>
Date: Fri, 9 Oct 2026 07:58:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
 <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
 <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>
 <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
 <9114ec71-060f-48ae-a6e5-0b46a881c259@amd.com>
 <40fc791c-c03c-42f0-88be-7a97938ebe1c@intel.com>
 <ba7731fe-f916-4e51-977b-95a0197bf52d@amd.com>
 <3f40d953-2e91-4492-b100-c851fdb143b5@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <3f40d953-2e91-4492-b100-c851fdb143b5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::19) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH6PR12MB893224:EE_
X-MS-Office365-Filtering-Correlation-Id: e42f5612-3afd-4608-570a-08df25d2cf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|6133799003|10063799003|18002099003|10067099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ntvM53ZfcxyUVqtF+TnOQTY3g5UpjVHa6xELaLboaoaOps4HTzSkbadKaAUya5726s1u5TCOD5qEJnnhODSoJjNTzZAeQsi1HTQ4G/jzPO8+PYYwdqcXU57GKTP33b/Da9a9/z3fGqE6JbB7S2fcZudUKP2Dy0ym9X9sfW34n1rZKbMSzdhyFy3lY/WWnraSgdu5+xF+aIaSaJp/pG02mCfU1ysS5S0/PDhIeUf9MaoKAS2jU9gA9pUz87m5tlcnCB4162/nE8loSn/6dWqTbiGA76eLTUXjtecZcIyUPOujYT5HiyXlrIMfw6fRP8JS8MgwFZ622ii88LB3/deEeZ8q67x3rayaipvu6PDMbPZ4vihcHI+51dr5qOMQBmXM45icpWZtE4ibDXY3FlX56NkiFbc2EoeY1E/MXBMkv+CB7dgH5AlfXx4A4eIm7l0RPXX9NwrhOYFUG6zh6cc/NGMD4sXXkqIuUt+qrRmSpU+54ttB2EYpmJRylPzSixh1bNWfXNswlCDToLrWgcTo9sVBRdLsxdo0luU89DXe3s5l/M33waJpqqMzHxnzS/NQjAGAp5rqNzR/YHSxtjcT7mdNXlwnYoqrczeP3tUyyT+Y5taGRqVRQvESaEKXd11teIdXgzUikvDuwELEgLfA7nzx/pq8+0PD/0W+Dpvv4oE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(6133799003)(10063799003)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWJjdmZiWSs3VFk5bkxmeHphd1BZOEJCRFV5bG5vcytkSDJvTnNQL1dobXNB?=
 =?utf-8?B?K3VWcXNKWlZtdk9zMXRPRkFQNXJ1ZGRXcDBoT0lvRElkMDl2azZ0Mkptb1Vw?=
 =?utf-8?B?U0piclcyMFhBckNWbDJGb1RGbWxJRjI1M0wwWVlWcmErUUVLWnBiUkp3a1ZX?=
 =?utf-8?B?WjRIWFJwZE1RMjl3cGJiVTJuSVBoNGpTRUtLYm1uZWFOSXdlM2pRbVNOZS9S?=
 =?utf-8?B?MnpNVFI0V0xRdmJNY25VN0R4VVE2QlVpWUlISEFWSEk5VnpJK0ExMDJQWkwy?=
 =?utf-8?B?SVBvQjI2VitOR2hmL1Vmb1RwT05VaXdPOFBKbG9qYzd3SlM1U2d0b295NTdm?=
 =?utf-8?B?bEV3cGpEdC96bkJweXYyaTR6Q3dVVEJhWE1QODQ0UnVjdFlTVHlSZmgvNXZw?=
 =?utf-8?B?ZDlsNCswVGFFNUozeTBBNk4yZkYveTloczhTS0wyVTJiaWV0SmwvN0FreWZJ?=
 =?utf-8?B?TFg2RHZmYjhqUnlzQkRoQXMzY3FKdUViNXUxWWhldmhHVnUxRHpnMUdoeW0z?=
 =?utf-8?B?OGVQQUh1YUJBa2hlL3BwT1ZucE50SllNazJoUnExZXFzb1M3YjQzOWhUSnFB?=
 =?utf-8?B?OEZYeE5QWlJUTmdBQzZRblBkWHhqQ2swNnlHQjdGRVZ4U2NPUTl6WmI2RTVZ?=
 =?utf-8?B?ZGV1NjR5dTE3eHpHNVVvdml4a2tPMkR2U1VhU1JrbVkxY3J1Z1ZwWlFMQ1Ft?=
 =?utf-8?B?NHlpcUxRVHppcG9Galgra1JMQ1E3eFprMm9waFJrZzFuVGIwSHFnUlIxOGwy?=
 =?utf-8?B?MXprWFZVbnlZZjZLU094WFR4enhnMUNGb3paOEh5bENvMTY2YlFjUkFUbTJi?=
 =?utf-8?B?T2VpWFdFV1dKMlJjU081TUZxeVltem9FeVEvZXUyRCsvZGRsZWZjWnRSa1RM?=
 =?utf-8?B?QXBydnlJUVB0RGpYYnpFOXBuZ1hXa3M4UXh1K2M5QXNXOU0vVHZGVjNOMmRR?=
 =?utf-8?B?blBkSHl5a1oyazhoSkUxeTYxZVRZTGVkdCtnbWc3dWg3ZVdGMXF3MHYrelN5?=
 =?utf-8?B?UmFJb1ZTWHlMdzU2SGRONHhXR3lqZUNmd1pTa1ZZc2g4SmxZRlhuNHdodVUr?=
 =?utf-8?B?WkVhcDk3bmw2V1RWRGZ2WE96aUpWTGk1dCtjem01d2lOTHRMMFFCTDBIanpx?=
 =?utf-8?B?U2NlcHNrd2dUNUNMNmlSNndkN1k3ZlQyUjdGaXlzeWFZMFhPcjRZNW1BZ0hG?=
 =?utf-8?B?UVV3djRZdjM0R0NhZExxMHZDY1JyQ253dFM2VjAwR05QYnl1NEVtajE1ZkJG?=
 =?utf-8?B?UlErNExqWFo0b1dnNHFZUlk4OWtRSVdveENWeitWV2pJd2FtSEtYQWxyVnF3?=
 =?utf-8?B?Wm5nMmxNRHhFMFdISWtvYURBT1Z3enNmTUJHRjBjT2ZQT3p5Q1hEbjltMHV6?=
 =?utf-8?B?NVZMWVhOdDhva3A3UGY0VTZKQW9nRzB3QVJSVEc2WXB0WnZNb3BkbElVZzc5?=
 =?utf-8?B?UUVGQmhKcFB1KzdUSXo3RXlCNnhOMEJWMVhOeHU0OFBRZE9tRG5mSlVMZDNG?=
 =?utf-8?B?dVJyNDF3OUFZM1JId1labVhZYi93cTBQMExQK3lDZU5KVXF1VjE4UlhFSU8z?=
 =?utf-8?B?V2hKbHdob2x3ZE04UXhwYUdGUkdGc2RBSk9KNmpHSVBuK3A0R1ZnRmU5ZTF5?=
 =?utf-8?B?bnYvejd4NGNGd0MzcjZWYmVpdk54RTFRMk80cUJraEEvVVByR0dhWFpRY3JR?=
 =?utf-8?B?aXgrZ0NnMHpHQld1eG5VS2RVOWRGaks5eVRUYVVuOEQ3RE95WWhZdFlGbjUw?=
 =?utf-8?B?TDc2S3R5dmdBMHdoQ2pDZlUyTGROaVBHSG5PZmlJTWFQUUtkWTN5VU5OZWI1?=
 =?utf-8?B?bUl6eVp2Z1VERTg3S1BHWXZMZFV6aHNBdlNoTFI1YmdpNjk4WU1TM2UrdUxs?=
 =?utf-8?B?cjVkN0tva2IvRmxQVDR2MDYxNE03WmRxNWVKOFhVSjIydy81cDhDRG1idTJL?=
 =?utf-8?B?SmUvUnNoK2NHNTRob1hoVUdRNFpUMFlEZXluRFE5ZG5KMVdwYkx3bjZEbWRx?=
 =?utf-8?B?eXhpSWloSUY0M1pRbElrdjVWd0tuQWU1YTRnZEJucHlPWHVHeVFlczcwakdl?=
 =?utf-8?B?VEtXeENZM3FkQVpUaUhUWWp6QWo3K0FhVUZiaDIyS0kvSzdLMXRidWdFeERs?=
 =?utf-8?B?ME1ZWFhoalkrSE5XUEt1blF2ZGl6d0w5cVFIQzl1UFQ1YklwYVZlNDIzQUVU?=
 =?utf-8?B?amMrSEFUdUZZcURCR3hVcDlTTDRieXF1dGUwWS85Q2RhYTkzdlQ0blFMNHdj?=
 =?utf-8?B?QXZJMlhPOVhILzZuZkpiUXl6Y3NRTWVHak9kdzA4VDdleWorYWtNQ2pSWlN4?=
 =?utf-8?B?b005aE9pZjhLWnM0S2REcEpiZytBTDZYODZ6MlI2dklsMVA4R0JzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42f5612-3afd-4608-570a-08df25d2cf83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:59:06.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxm48L194seKOLq9X3cTayWOpE67sKVoOvXBSndcAMQZFYuUFxqfBX+uh/dXZK1g1VYThZ5Ng7UU8Tc/dULU+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB893224


On 08/10/2026 22:05, Dave Jiang wrote:
>
> On 10/8/26 11:07 AM, Lucero Palau, Alejandro wrote:


<snip>

>>
>> Dan and I addressed some concerns with "these options" but it is worse after realising now port and region can also suffer from unbinding actions. We contemplated memdev unbinding and that is supported, and acpi module removal as well (all the unwinding is hopefully right for sfc driver removal), but the fact is, current Type2 support is unsound. It is likely good enough with current usage expectations but something to improve/fix.
> Removing the acpi module will also cause the issue I pointed out. So that isn't safe either. The only path that's good right now is sfc driver removal or the device going away.


No. Adding multi PF support brings new problems. I need to look at the 
other unbinding options I was not contemplating, but acpi module and mem 
unbinding are safe. Maybe not correct semantically, but safe.


>>
>> All this user space potential actions were implemented mainly for testing (I guess you know this). I did ask Dan about it, and I was expecting use cases where HDM decoders and regions are dynamically created, which makes a lot of sense to me, but the fact is all is relying on firmware/BIOS configuration. Richard is working on adding this functionality for Type2 and pmems, and Jonathan considers it theoretically useful as well, but the way is going to be handled requires, IMO, further thinking and maybe a change before someone starts using it (does anyone know about users now?).
>>
>>
>> As a summary, if we allow user space actions (at least for Type2) they need to be consistent and somehow protected.
>>
>>
>> Finally, you did not answer my question: what is the point user space removing and endpoint port handled by a Type2 driver? What about the cxl region? Maybe I am missing a necessity I can not see here, so please, help me to understand this if that is the case.
> Shouldn't does not mean does not exist. Sure I can agree with you that under normal operations, certain things a sane user should avoid doing for type2. But it is possible currently and those issues can be triggered. However you feel about the current CXL architecture, here we are with where it is. You can either consider the smaller changes I suggested to keep the attach->cxlr sane (or with some other means) and make what you need working now with raised the issue addressed, and come back with hashing out the larger grievances later, or keep beating this horse.... "It's silly for users to do that and therefore the issue can be ignored" is not a good enough reason for me look the other way and merge the code.


I'm not denying the problem. I just do not want to add some new 
functionality which comes with these new issues, at least until I can 
understand it fully. What you propose is, I think, correct, and fixing 
at least some of the issues. But I think this is a good opportunity for 
trying to address this sysfs functionality, or at least to discuss it. 
As I said, also when basic Type2 support upstream effort started, Type2 
CXL should not be "open" to user space as Type3 (or not by default), 
although I think this complexity and so many different unwinding paths 
should be avoided ... or documented the reason behind it.


So, I will work on some documentation about all this, with cxl devices 
lifespan and those different unwinding paths, emphasising the different 
theoretical needs between Type2 and Type3. Once the unwinding paths are 
identified and documented, someone  can add the reason/use case behind 
it, or maybe some problems with them we are not seeing now.



