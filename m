Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15D3314C2
	for <linux-cxl@vger.kernel.org>; Tue, 26 Aug 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205066; cv=fail; b=Rge0fOj4BR15VMHruZHbY3WSuwij1jLl3NK9FE+uiifcRR/lrY1cUFUSQibtWoQCR3V4BqxfR/1vF/wX4pKibO7UMqyevErl1V9tqK7pVRH1pzAZ2K/2XEVdQ6cx0HHpPLTOs54g/2ylo47OyjnGv9RT4M7uPbOsYxAnB1f3vv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205066; c=relaxed/simple;
	bh=JyhUvM7m5uvAVSYtwDFfOX+KP96r1QLbWsdD1VcSWnU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qL2HhS65BG+al5e1bLqI7+ccu8Ju2Anz9RXP7U4jbgtYHqO7FT4uHKgf6plyKWL7dqMCHe9RdqRVX9eyw1EhD8+BwDU8OhkSB94joHgBSyhpqKFHQTCtUrf4s3rWEFRdRV6ZjcnpBMAJQBZUlzPMdCJZ+pHzXr0a6uojxL+uZUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wYLpiSpO; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wYLpiSpO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imNMPEnXihhCls9fLgyuZ7HCiH6vXeLEttiUmG1/r+ZD2KDiQzrxicNMm4QH3tA5r9AIDUh1nt7ysMwG1omSccHRtN62SRur4bUXREGrh5J3hFLCFm+1YkhUIqCNnWhB2CshPb58G0USZYndVlqQe2/tLe4GxEM3UCJ0PQSpo299pm5I7MhHReuV2tdL7YEeLRAWgbhAHInCmantjx3q0dd/s45WtR4589aFj6tGt0ipdn2RdrhzQMH9ESu/g0ak9DnCg4G0tue0qq4AeZnVPGKcAY34JHJBOyqcpvm/s0w45nwSEuTb7hpAuzcNKEvlmnmUPP3agPo/12S+6PZ0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4OptusDTqeh2Pgau281L/IGs+Rg65QuJFX+ppzyEBg=;
 b=gJcCCYGRfxz2OEZXeeT20ADyAwHjBjiR4a/PoPm5DaT6N0pahiawulhMOrp3ErQEg59EN9/OdIZ/ZqlTU+ejVY2ev+3DlNp4j/UhBh58K2upZF3Bq02FMMczbbE9a7LSc51TV1rFd+r4AQBtqKUiL6+sfJP8G1Q+nuRMsaCOPOSKoUIxChKklWiVPk1I/deAUNuC67etWse10BK4DWs7sMXvT7Oh+FYnmldwYjvEhjRtkMyY1IiF4YyiT2vzkmAih48h18juRxecbUHu724NGLI7F1KWlIit6DdzOt5KIXttzDegMG0TPDVVqY3Vz/Rmb1Z+zTt1xiROVQ8yGaVa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4OptusDTqeh2Pgau281L/IGs+Rg65QuJFX+ppzyEBg=;
 b=wYLpiSpOt2mJQHgyhfiKJQAoAtmePFrZ36bYSHEl2sTHb4Eoj/8YpjvOV7kjDAqMPqrilUpt8GIcllTcuAFONUU1a0f8LJXWoiZgk9OMx4Km+xkRL51/2iyTO7PZrTKRdESkGbLtARCvZ93WI2+f/Ad/nSBvsrz8xnsJkU9FRx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 10:44:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 10:44:21 +0000
Message-ID: <99e7ecba-6478-4ffb-a2ce-f675e5f0b328@amd.com>
Date: Tue, 26 Aug 2025 11:44:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <f3ac894b-7c8d-4f9d-9bfb-d05c7d7c5650@amd.com>
 <c8995205-2b5e-440d-a2d9-98240a8aa89d@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c8995205-2b5e-440d-a2d9-98240a8aa89d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0431.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: bb572d3b-da55-44e6-b76f-08dde48d83a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anB5L0psVUNsa09wL0ZscU9ZNXRBa2cxTFRqZjcwKzBzSy8wMkZRT2ZxRXkw?=
 =?utf-8?B?SnNnV1VaWTNRMFFKNmdIRkpET3kxcUtOMEdmb25qY0VxKyt2L1BRNlR5b1pV?=
 =?utf-8?B?YjNBZElRT2lkczN2bTZTQThDdUk1eXByOVpldWZScGRNVnZic1Z6QlpxSEVI?=
 =?utf-8?B?VjlTeGFHR3F3V3lJemRQNzZWeVJ6eFd5ZkJNN3pzSUgrVXJtVWEzUDhXNU02?=
 =?utf-8?B?eGxENW5CdndYZytGcmd4elpOU2Yzb1RGZjNxTmF1Z2ltd3RVUVh6OXpiS0Uw?=
 =?utf-8?B?UndYQjVLb0NqSkhJQjFLbjlHUFRqa1pqWVNNQW4yVTgwNlFLM29rL0pLZWdF?=
 =?utf-8?B?eklGM3BtQldRVUYwalNhcE9OQzBsenVXRDNDdGNUVllEbUtub0V4RlorTGsr?=
 =?utf-8?B?V09jc0xxM1lzMWF3ajBCTGp2MjRKNW1NaWp1MXNZVjR0dTA0TXhCNEUrYzlC?=
 =?utf-8?B?RnlHRlBEa1Nsb2RhU29CRXBEOENUbHZseUZhaWxPUVpicElQelUyaXFENEto?=
 =?utf-8?B?bzZGRlBtbzdPcmRjTVdtSWI0N2ROSlVOQ0xmbE1ZelRJM1VGNmtEZGUzSHkx?=
 =?utf-8?B?MVpiZWpNSFdUaktneURGRXFaZ2QzNzZsV2luYTVUZHBOQS93RmFVN0xuSnND?=
 =?utf-8?B?M1M3YXk4VGgxWTNTT0ZkY0xuQUtyQVpJK1BVSlJwN3YrWUMzS0M4UnV6aWti?=
 =?utf-8?B?cjZTcmFLYjhoQ2JVOHlDNDZRbmJJcjdxWTJUSFNGTmxDaFNxd0Z5VzlTMEdw?=
 =?utf-8?B?cTJCOVlOODhpeTB0WTkvdmF0cFNpbCthZ1ZaVFE3bUM1RTAxdk5GVGZBWUVE?=
 =?utf-8?B?TUM2T09oK0RlWTgvOHJmcXI2L0pIQmpVQzNCa0JzSURuQUd5bFVlemwrcmVR?=
 =?utf-8?B?VEVDN05tUXpHVzZlY01Ld3ZySkhPTnROdGVQMnR5M0pnVGFMMmw1UERtdlhQ?=
 =?utf-8?B?cFM2aStqK3hIS2NmT3BQNFBhK0JWcVdCNGpvWTM3cDFXcW92OUY3S3ZnT2xZ?=
 =?utf-8?B?OXpFa0FQanFHVzNjZDQ2WkRFL1RVUWhSQWlBTWtqWFF2TnJvNTI3THBzdkt5?=
 =?utf-8?B?OEZmNEJvbFhsa2Q1R3piWWphMFpDTDZNZ3NZdGU5OFR0Mk8rVEtuakhDVWdM?=
 =?utf-8?B?WThCTWFOOXNyeE1IMlZKNUtUR1pRK1poUnlxakJqS01DWjhGVFoxejRkbGxX?=
 =?utf-8?B?VFpnczN0RW5pWkFxYS9YaTRSNzZQU0g1SUhGTzVVNVdTVG9vcWhGK1IwZXAx?=
 =?utf-8?B?N3RuN0g4aWtNN3YxN3QrYmxEK3d5STVFQU9rd0FkUmtqbnAycERjMFVhSWIx?=
 =?utf-8?B?WFYva0g0cnVkY3kyd2FoK0VoTlN3K3NYMWY3M1BrY1IrOGdPamdqRW1lWDlZ?=
 =?utf-8?B?MW5xb3Z2YnFYTmpkYituY2N2YllJNGNOK3FBN2pRYnNtRGRRUzVlYUlpRTFl?=
 =?utf-8?B?dHUrVnF0WnJEbXNOV0dZNDhWS2M4VzdqWjJudEIyTEZGSHI3VXFuYkIrOFZW?=
 =?utf-8?B?MDQ3cmxNbU13UnpoRVJuOGt3VkpRU0tYMTV4TmVpTk1mQnVjQklTeXZMd1Y2?=
 =?utf-8?B?NW04dDVDVFhUR28vSXVWRnhIc2pPRk10RHdRR0dtZWlYcERvdnNxYlYwUCth?=
 =?utf-8?B?QWJnLzNKdVN5VHVoeTVTdURGSCt6cTRrcUpQcXFtK3RLMG0yQ1FTbkN6UXNn?=
 =?utf-8?B?VThxbFhTbFFHbXdsRWFZVFZhZ0lNWXRIWlJNeHMzeXNrYjZacm9hZEJHQzBu?=
 =?utf-8?B?T00yL2M4Q1BrMGhoWUhhSlZnUmdKZ2FkQ2RKWGFrMTNYRzQyR2g1ZEYrcG9L?=
 =?utf-8?B?cmJOMEx5QUFLR1hldGVha2hBaTAyODJIU1FrZFQ4NVlyU3hkMEpiQmdTdmRm?=
 =?utf-8?B?M1l3QjI3Q1NNU1RzNmJ3Y1hBNXZoa3E4OGhERWdjV29UT0JzeFlGL0N1MFFy?=
 =?utf-8?Q?SnZU6x1aUxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZGOFByMXJTdVlubVVzYjVpanU0VCtLQzVLNm10UThvVmRsd054S3dvQVM4?=
 =?utf-8?B?YjBVRS9wN0c2TUFsTlltdUpyeFRqRHpzZDdXcDZSYzdPeDVoNFMwVEFWZTE4?=
 =?utf-8?B?eHB3RE11SGlsQnUwM2JSSzk5b3FwNjZkbDZJaEJQZTlTMHdaNWpKZWxqdkZZ?=
 =?utf-8?B?bXM0eVhpcDNjY3VnRnJQdndpeW5tU3k1S09GSlZJQk4xaUN4TFFGTExWTVF3?=
 =?utf-8?B?OFNENzRSL21pRUd3SjFPNjNzeFpnZWg3Z2NUYUlYNUJqd1IyUVJUMGxaREM4?=
 =?utf-8?B?bUNCdktZdkVlSzNsV29KbmJ4cERTS1dWdGZ5VHhaY1I4MU5SRnpEVFdsN21N?=
 =?utf-8?B?Q2MrSVpCVFpiaTRLNXZKVHpaZFZsWDgvZFNCU1ZvVjZJL1BmamdEaHVnQm5J?=
 =?utf-8?B?aXBiQUUzWDhEQkcwQnFnWEgxMU43OUZ4TFQ0ZVRxVVQ2UXJRRlFPM2pXeFh5?=
 =?utf-8?B?WUVkcWYwY3owY055VFlNTTFSaVhSRXU0U0NpaThxZDZMbGVUaEFuOXBpZnNN?=
 =?utf-8?B?d2tPS05PWFJ2bFVYSnI3ZkxISktGb3RwdnJSRjh0MVVNUVE5N2xQazFWVlI4?=
 =?utf-8?B?S2ZXd3hGRHN3eUxtakZMSy83bUdRY0FhbVR1TzJFTnJuMFZyR0lVelFDSHBa?=
 =?utf-8?B?eFJnQXNwN3RPUUw2REs1dkNmT28xeVlXQ0pzZHg2bWpHZXJIR29rSlU4Nm1o?=
 =?utf-8?B?L01ZMEM4U0FSNVY2aGVHaUEvajFoNEtOTXNuZE1haDlwdWMrdEtrVGVIL1c5?=
 =?utf-8?B?ZEEwdlRGaUdCc3ZQWElpbmd0WXNoWngrNkg1cHlneitJRWk1SGk5MmNnb2h4?=
 =?utf-8?B?dkZ2emE0bm4xUUxIWkhUNVJ3RTByUFg3UzM1WWlQYmRBSEIvUms4T2I2NGE3?=
 =?utf-8?B?UFZIODUzdXdia2tyUzVCQ0U0R2krY3hKMmkyazl6bngvckdsWmM4WnJ4SU1U?=
 =?utf-8?B?L0ZUNlMzRWlFT1RNaGkrK0ZCWlc5ajNmM1BjM0IvY09LbTVaM0N5cGtZbTlS?=
 =?utf-8?B?M1g2Y29ML1AyYkNoS0hHSzJUVjNENjdsb3pQWTl5c3ltTmFDck1NZENINFhZ?=
 =?utf-8?B?aXlHaU9FVnlTZ1NnaXlNV3Y1dnJKNDBkalZqalp3NmtZVEFpWTl3RFRnOVJm?=
 =?utf-8?B?cmthU1dNZlYyRXFpL3MzT0trTkJBWld4Lzk3MThGSDE2SVFMeFMyL3JsTDFG?=
 =?utf-8?B?UXB4YXVtSE1SSE5JSFhtN25mM0RHbVlEVkxoajBZTjVHQWVDV2xPTWZFTjhl?=
 =?utf-8?B?dG4rL1dRek1VdjRIT3Y3TWFoR2pxQVZ0OENjQUdhTHlVdGRVR05rTUQzU3ZZ?=
 =?utf-8?B?OFUwZnNXL01qN1lydWN5L0J4NzNCb2crV2NIWE41RFZQTjFoeHZBSlg2Qk4w?=
 =?utf-8?B?K3FjLzUyYlFDdFVKWEtmZGF1aFFKQkVrUlJGVk5HbTVPUkdIT3NjOUdvT3Nr?=
 =?utf-8?B?bzA2S042dzVJTnJudVVseWZvVVg4Z2VHV3Vya2EwNkZiTjVzM0tBbmV2VnRz?=
 =?utf-8?B?TkN4V3h1dyt3bzF5ZVcxVVh4NGQzTHFQeGxheDV6SUFEZUpMYUNOaXBQMXd2?=
 =?utf-8?B?cy9CV0dRb2pNSWdUZUZFcW5abGUvR2tvZ3l1NE1GQy9DNmtSaTZoZzlmbEI1?=
 =?utf-8?B?bGsxZ1dGcTVOSHlKcmRYTzV4cEQyZXNOV0lJQUlDOHltakppQzA1MUZXUEwr?=
 =?utf-8?B?MGlyQmc4eFdQa1JxZUl0RkdPOTZuTGx0QXNkMUlTcmEwUjFobkY0anBiZmxo?=
 =?utf-8?B?T05WMEJqd0F5cDEzVVN5by85TXNWS2F3MTVuWVMwQUFJU2pRVWN6ZUl3VkZH?=
 =?utf-8?B?YUZIU0JLdzZaVzFtN1pHRzloK3p4OGNnVitXTmNSVTNoUjJobE1ucDVtSHpw?=
 =?utf-8?B?ZW5sWjBXb0VteGo2VWtIRVowenlJMTBHY055RHBsSXdtbnBCaUxTL3g5dE5L?=
 =?utf-8?B?eFZBdm5DWVUvQml2UXVWdlY2UXcxQUFTaURqMlV5TkFrQ3ppK1AvLzVybTF1?=
 =?utf-8?B?a0t2WnBNdHdJeU9MRHJpZENWdENYQk9DcEZOVmdLWUFUMFJybmliaXRWbnNL?=
 =?utf-8?B?di9UbVIwcW1HQXpybW40aDY4ZGRWTUhweWRRMi9wZFEzUCtCVVpvS1c3MHlY?=
 =?utf-8?Q?pCAQxkI8LT+gpu0EgsBhC3M+m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb572d3b-da55-44e6-b76f-08dde48d83a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:44:20.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmElwKdN3o6k2CILypUh4jC2Z+WBJ/JMLBZjIeqmt3VqDdMmQijmaopPifgy68NDCvyugLI+3l1A3Sx+Cd1AOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258


On 8/22/25 19:02, Cheatham, Benjamin wrote:
>
> On 8/13/2025 6:25 AM, Alejandro Lucero Palau wrote:
>> On 8/12/25 22:29, Ben Cheatham wrote:
>>> This patch series adds initial CXL.cache support. What I have here only
>>> allows for adding a cache device to the system, programming/validating
>>> the system configuration with respect to cache devices, and some basic
>>> cache reporting/management.
>>>
>>> The general philosophy is to have an endpoint/vendor-specific driver
>>> that runs through the same steps of adding a cxl_memdev, but for the
>>> cache portion of the device (both type 1 & 2). Getting cache support for
>>> a CXL device should be as simple as: get cache information, set up the
>>> memory region (see below), and then calling devm_cxl_add_cachedev().
>>>
>>> There's a couple of things missing from this set:
>>>
>>> 1) Missing an endpoint driver
>>>
>>>      I plan on submitting a reference driver (type 1 or 2) with v1, I
>>>      figured I'd send out what I have before going much further.
>>>
>>> 2) Mapping/Reserving host memory used for CXL cache(s)
>>>
>>>      I'm thinking this will be handled by the endpoint driver, but I'm
>>>      not sure what mechanism would be used and whether to integrate it
>>>      with the cxl_cache/core. Any thoughts/ideas here are appreciated!
>>
>> Hi Ben,
>>
>>
>> Good to see you working on this. I'll go through the series these next days.
>>
>>
>> FWIW, I did send a RFC last November about my concerns for properly/safely supporting CXL.cache.
> Yeah, I saw Jonathan linked it in his reply as well. I've read it but didn't really have anything to say about safety/iommu schemes.
>
> This set is really just for the first part of the summary at the end of that email ("CXL core handling per device CXL.cache enabling...").


Yes, and it is good to have it.


>>
>> I had no time to keep thinking about it. Also, I sent a copy to the kernel iommu mailing list, but it did not get traction then. Anyways, as a summary, I think mapping for CXL.cache requires not just the endpoint driver doing it freely but through the cxl core for ensuring it is done properly and safely. But I have to admit this could be a misunderstanding about how the hardware is going to allow CXL.cache.
> I agree! I just wasn't sure of the approach to take here so I opted to leave it out until we came to a consensus.


I will try to start that discussion again ...

Thank you


> Thanks,
> Ben
>
>>
>> Thanks
>>
>>
>>> 3) RAS Support
>>>
>>>      Same situation as 1) above.
>>>
>>> Some quick notes: The actual cache parts of this set are untested due
>>> to problems with my set up, but I did make sure nothing here breaks type
>>> 3 support. I'll have this fixed before sending out a v1. This series is
>>> based on the for-6.18/cxl-probe-order (commit 5e29cbd1077b) branch in
>>> the CXL repo, with v7 of Dave's deferred dport probe set on top [1]. I
>>> added Dave's set to help with getting around constraints with HDM
>>> decoders in CXL.cache device only configurations (see 08/18 for more).
>>>
>>> Patch Breakdown:
>>>      - 1 & 2: Preliminary changes for struct cxl_cachedev
>>>      - 3: Add struct cxl_cachedev
>>>      - 4-8: Preliminary changes for adding cache devices to port
>>>        hierarchy
>>>      - 9: Function for getting CXL cache info
>>>      - 10: cxl_cache driver (mirrors cxl_mem)
>>>      - 11-16: Checking CXL.cache capabilities for system configuration
>>>        validity
>>>      - 17-18: Cache device attributes
>>>
>>> [1]:
>>> Link: https://lore.kernel.org/linux-cxl/20250714223527.461147-1-dave.jiang@intel.com/
>>>
>>> Ben Cheatham (18):
>>>     cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
>>>     cxl: Move struct cxl_dev_state definition
>>>     cxl/core: Add CXL.cache device struct
>>>     cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
>>>     cxl: Change cxl_ep_load() to use struct device * parameter
>>>     cxl/port, mem: Make adding an endpoint device type agnostic
>>>     cxl/port: Split endpoint port probe on device type
>>>     cxl/port: Update switch_port_probe() for CXL cache devices
>>>     cxl/core: Add function for getting CXL cache info
>>>     cxl/cache: Add cxl_cache driver
>>>     cxl/core: Add CXL snoop filter setup and checking
>>>     cxl/cache: Add CXL Cache ID Route Table mapping
>>>     cxl/cache: Implement Cache ID Route Table programming
>>>     cxl/cache: Add Cache ID Decoder capability mapping
>>>     cxl/cache: Implement Cache ID Decoder programming
>>>     cxl/cache: Add cache device counting for CXL ports
>>>     cxl/core: Add cache device attributes
>>>     cxl/core: Add cache device cache management attributes
>>>
>>>    drivers/cxl/Kconfig         |  14 +
>>>    drivers/cxl/Makefile        |   2 +
>>>    drivers/cxl/cache.c         | 276 +++++++++++++++++++
>>>    drivers/cxl/core/Makefile   |   1 +
>>>    drivers/cxl/core/cachedev.c | 292 ++++++++++++++++++++
>>>    drivers/cxl/core/hdm.c      |  31 +++
>>>    drivers/cxl/core/memdev.c   |   2 +-
>>>    drivers/cxl/core/pci.c      | 134 ++++++++++
>>>    drivers/cxl/core/port.c     | 518 +++++++++++++++++++++++++++++++++---
>>>    drivers/cxl/core/region.c   |  25 +-
>>>    drivers/cxl/core/regs.c     |  28 ++
>>>    drivers/cxl/cxl.h           | 193 +++++++++++++-
>>>    drivers/cxl/cxlcache.h      |  42 +++
>>>    drivers/cxl/cxlmem.h        | 121 +--------
>>>    drivers/cxl/cxlpci.h        |  10 +
>>>    drivers/cxl/mem.c           |  14 +-
>>>    drivers/cxl/pci.c           |   2 +-
>>>    drivers/cxl/port.c          |  54 ++--
>>>    drivers/cxl/private.h       |   8 +-
>>>    19 files changed, 1569 insertions(+), 198 deletions(-)
>>>    create mode 100644 drivers/cxl/cache.c
>>>    create mode 100644 drivers/cxl/core/cachedev.c
>>>    create mode 100644 drivers/cxl/cxlcache.h
>>>
