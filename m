Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A5217F36;
	Wed, 30 Apr 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002565; cv=fail; b=mpZmWqRPNtZpMwO6o71w+3/3ID0DDDQhYNrgg/VWhDIgsJ6kALNfw+puhCO8T4FxZ5egLYrmn5ODoBdQseAN/Q+HNiNOkmFEI2z4GWP9QLxjAFTCEyOeV+VAz+lAsj01XF5m8KBNbkwZTUbXNffwlFepoQcW8Qg3mCFwSBZj8i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002565; c=relaxed/simple;
	bh=mHLymPOzuiFDb14I2SuJM6DLi1sbFfw1JkVc5ohhTFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qiDZTPT1CSAkjBO6Do26UXtOLPBfT1Qd+GXWUgWKDWlZ3OeoKnG8AVRjUjT4XKV7Bafa5Tc5tHFspK0nq3ym0pRHFEDE2wq9V0QQVJ+k0f+WSRWWscz/HIGqNxbxPs+/R7ogNOPRq1aKVpvX9AaRl11S6uO7NkAThzkdH9DPyaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EAIbP9I6; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EAIbP9I6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oktG3lO/fEJMrBGUoQBNCbA3Y5DGUAAOOBizSs4Q+zr1WoHRbRXKIeylz8E1pDYBHOUsADFcts/DnyU+s7Tu0Yr+4BsKYj5+e1545kNWA5GNIup29Ta6lraDyKKnFKry9QOTOtAA9shnOEaFAZ8fUp2e8x7phDXFsUjghbXvNGXoRu3x2KW20vucVevUuEILxl9K3vSpDzbnYPHltccVAq0ROB8GGWc9jJpKal1oHjVAiItPrFOXdXNkH2bvPfhZT0zturRKkryDOsiAIK+jCN1WJdJD+yd8uO63uKAOYNHi7YpdZeWF2gpJJcO75HTwK1+3TVyek5iLxL4XXKLMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLl/XWii2SlU8mIkZTS91BdSh/KHgOwRJvKhvp5+zwM=;
 b=HyttlAil3vlGNrb1THCGDY1715x2PO/PZZw9az0GE9SNPAi+3ak6I/RuhQIFHBLtPx/YOxGJDRmBetqnSmriXSw/CUUDh51yZJCI/J7Si1jSj22MdYEmSXPO6Fhdcp6IdPNp0Vp9hKb/FEB27dD/yBLTRCvJ5LRlDEYLAusRaVMTJrLv1q7eWabfjwsDO2qJ54D/hMTbHGwe2hSLXM0eLu0SEpYPfX2EYUnk6mJyFVFvc9aLf3/MyqrmtHBzE51JUyn1zwFpyJL0nyFCdRm44Dv9RXY9IBVzUh0+IQwi71F1CkzjUELJ3y3uD5ZQIQMUfyz3q4dzZBvsKOaF+g80yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLl/XWii2SlU8mIkZTS91BdSh/KHgOwRJvKhvp5+zwM=;
 b=EAIbP9I63PN7FxVgu2NgEpM3l7ZiIf5ye7+VJ6PJDARBb891WoHe5s3EKwsqelLv1s6SZMG9hLYiqvMVbTyqrG/PuDvBFK407ZMk83XYGScB0oZExDsFAA+IDludJ1jBkxe7bmO2P/r4WWoKyzUAZhytcKv+CGgn8geZ36qtN/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 08:42:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:42:41 +0000
Message-ID: <200f8614-34ba-42b4-aa8c-560d3052e496@amd.com>
Date: Wed, 30 Apr 2025 09:42:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Content-Language: en-US
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Gregory Price <gourry@gourry.net>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250430012915.295136-1-lizhijian@fujitsu.com>
 <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
 <082de146-d5ed-4b49-ba0f-d6f018436e5b@fujitsu.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <082de146-d5ed-4b49-ba0f-d6f018436e5b@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c030f4-6cb8-435b-aeb4-08dd87c2f7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1ZmSGdMcjhWOFlwa0lvdzBCVWpKMDZyaUNzRlVnQmxZSVBnZVFTSDBKSDNH?=
 =?utf-8?B?NGtqV0tPWXdhWVFRb01BR3d1cmtCaCtsdVhHWDE3TkowWkpSNnovWklSL2Mv?=
 =?utf-8?B?bDdvelFxNy9NenZ1bFRvRmdMbGVFclVGWlRJMHRua3Q0YngrMkNHWTYvb3Nm?=
 =?utf-8?B?YmQ3UGJRVUYwQ3lVZUNha0NueXhTc282UW1mVk80UGZ5azVGMC9HbFRvc1Vw?=
 =?utf-8?B?bTUvZWJnYVozNWZ5RXNiUHpudEl1SHlNbTdWUDlFdVNNeS9vOUh1eW5lVHR6?=
 =?utf-8?B?dFp2RjVJdHZPMWo5djFxY2p0TmNudWVDWGtsTnZaZCszbERmKzNWajRGdnl1?=
 =?utf-8?B?TTNSRlpYcE0xcnhoQS9nek54UkdlendZZ01xMEV4RkxvTlpSakxOWjRSTDZx?=
 =?utf-8?B?MDlxQ0hQdVQyQmR4WGJXa0FZdGpaU09hQWM1bXFWci9RNmh6VEZ5eHVQUmt0?=
 =?utf-8?B?cStHUEZHZXhwTEJodm1PYWl0dGxtTmowZU04RmtaK3pJdlhZbXd4T08vbDdF?=
 =?utf-8?B?TWluZUxUWnlTMjNZNW9xNU5ha1pLeVoreUFSOXVndnE3NDV6N1JTSTBmYmxP?=
 =?utf-8?B?VEJCcEROdGNOZDlhL0ZNaXNONVZKdG0ybk9saWtyTE1EN1RSZEd2Qng0SFA2?=
 =?utf-8?B?NVI0cnFScWt5WktSVjZmZW8zVlErWmNQRUljVzM4bWRKWTBPcnRham9adStB?=
 =?utf-8?B?SU1RUCtIaXErUWZJdWtwWHdYTHkwYUtON2UyTE02TTc5am5MV2thZTRmbzM2?=
 =?utf-8?B?cDFlUUVqRWlidGlsb3BMQUhjQXczMGh6L2Z0SG5GcERBQ2dzdXJkTXRwOXhx?=
 =?utf-8?B?QmFRb2FCbnFJdi9MbVEzWVkzTVkxQSszamlMSHYySXM1SDBQMGNQS1haRGFC?=
 =?utf-8?B?L2tvRzVsVDBzdVhFK2QwWmZFblVGVlMxNGp2S2QwVkYvR0NIMGsyNHZZNUR5?=
 =?utf-8?B?U0oyUE9JSk5HN0JHUG43K0p1T2Q1cDZuZ2VxTGRGOExFYVdlYjlhbURxRENY?=
 =?utf-8?B?QytUT0t2QzU0emtwdnRud01qd2prQXkwMXJGZi95SXVMdktkYUdFb0xtYy9q?=
 =?utf-8?B?N2NBL3dsZm9icXg3T0JqbXFPK25CWlBBR2l4eXZxcGRhdFErMVpBMmtrZ0VS?=
 =?utf-8?B?RUI4bXBNRzFvMXVJNHFZV2NlNVdFQk5JRHdvNTZ6TzdydnJLZDU5elRoZjR5?=
 =?utf-8?B?QnBLK1gvQkhZWWdHV0lUR05KZTBPeUpSQXo4UDg1aHI5dCt1ZTBVS0p6Mmpl?=
 =?utf-8?B?c1JnTTF0ZXBYMVlCLzlmWlNkUU5EbnRMNHl5bFhqcXhqTXFpMVk1ekxaZDZX?=
 =?utf-8?B?S3ZaVTRNdTNaTklVNnBkSTk2MzV5U2tFTFpTMXVkNEdOK0hPeUtNU3loWEJv?=
 =?utf-8?B?V1kzUHdIVGNUQSt0b3VBMXhNWkdyREo4ckFPc2tXcjJIQzFUK2RZeXo1Uzcv?=
 =?utf-8?B?UDhYUDhoeGRvLzZuTXRHaWZnZ2lSdnEwQU9YQzdGemNNS0FnY0NGMDJBTVlY?=
 =?utf-8?B?bGl2U1FmbVhkQkZnbVRSVG83TVhlUXVSMGdJSVNGelgwb2tPOHFRNnhNR0lj?=
 =?utf-8?B?Q3ZLU1RQbEtOeFBDL1VVbjhwUGZzcEVseHJXRUcwMUdYaUR2Q1J1L0llUjBI?=
 =?utf-8?B?TVBOV2luQ3ZTYjh6NnRaL0UvSkFobWZidlVZUWJyUVFNcEZGU3BjSmpGQUVE?=
 =?utf-8?B?S2MxaFRrNGlDcjBvajUzc1FBa3lSL21yN0ZVN3lZem9wWHF4NVlDbEpwWDd0?=
 =?utf-8?B?ekxhZVZORVRZNEdPUDZJanlhaE5xZWQyTytYeEJwMHBDTUpsWXJTMngzVTNB?=
 =?utf-8?B?cno4OW05OGRBb21rZlFCTEhURjVLY1R3L2pjZUU1WWRhQytTMkZVV0E1MGgx?=
 =?utf-8?B?MlI3Y0tzQnVrMTlrNk5UK2UxdGtxL3Rqa0R3RmoxRVptbGpXMEtPc2l0SHNw?=
 =?utf-8?Q?M2fCeLI7RGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdiSCtFellVMzl3UEdZZldlZlBNTTNmbUZRbE1HSzBaMXNERG5TZnJyUjRK?=
 =?utf-8?B?YnI5bzVXNFh4UkluZk43bEN6OEhwRWU4dWNKWXdmT1hZZjR2YjlEa2pNTXVX?=
 =?utf-8?B?a1NnWlN6QTQxYWwrY3BEc2hCc2dOV09hcElDd0EzWWdzZjY3MHZvRnR6WDhT?=
 =?utf-8?B?cXZvb29lQWFCTThGWVdSb3AvRjNtMnZDS1hBaWxzV1FHdFUvczYvYXZYMXhU?=
 =?utf-8?B?MnArUlVXUms3OU4zcDJuSkNFSC8zRC9FYzVLRWg2N24vV0VoTUVsa1pWaVJa?=
 =?utf-8?B?MWhnN2U4Rk56M0w2NVlINTdIOUtEUFlrYm1UcnpGNVkyVWNDRXJDSkZOd0NS?=
 =?utf-8?B?c1R1MnVML2VtNXZ6cmpDQkg1emdiS0VsaCtteXR0M0NLMVJtYTlHaHNYemJF?=
 =?utf-8?B?eDVmZi9rdFE5aU9wSVZZQ0w5ZWFYWFdzbWtCRmJuTUQ3YUJUME52L1BBbzVm?=
 =?utf-8?B?L09UclMybFUwbStVUitkc25peVY0c1Y1Vms2VjRUci9FdEh5TzIxSzlYZGZU?=
 =?utf-8?B?K25aT3BCQXo5cHdBZ0U1eHdWNjF2SFRCVlZuNWp0bUJ1Y2hpckJZTjFUbHVM?=
 =?utf-8?B?TFNGVmtMNm1ja3RoamVNNzhXcFJBV0NFb01uelYwMW5wdHZCNWFhSE1BYzA3?=
 =?utf-8?B?a003TWZrRlJiRTBWR0ZRU3B2dGl1d0RUTGc5YUc1U095NDFWRWlSMnJPTW5H?=
 =?utf-8?B?bis5YUtPbGY2dWtrSno2WStnRHNkZEtGZkZ4d0dEdFlnZG96N3ZFS3RrdEZj?=
 =?utf-8?B?MSsvMEhScGRWWHhma3BOTElkYUQ2VW1pdXFSOGR4Q0dJSjFJL0Y3aW1oanBK?=
 =?utf-8?B?aVpETjBlUCtiUlRBbVVmZXN5ZUd1eSs3c3cydG1zTGFXWUpzaVZmNDhKcUFa?=
 =?utf-8?B?OG5HRzBwM0FLN3Q2VmVtNUdKYlhKOGNMS2c3UnpPZDhONTlHMzNWWWd5MURS?=
 =?utf-8?B?YzFpLzQrTzZ5MnMvdFM5TmNPR0R5Tm1nYXczbVpWNVBaaS9sajFDSmZDNFdC?=
 =?utf-8?B?V2J0NUtBK21QWVg4eUU2YlR5SXJyREVqcEpka29ldWw1a0I1dkV5RUVOYzNF?=
 =?utf-8?B?eC93ZG1CNVQwdE5DNVBBTk9HQWFhR3M3MGtBUlo3TkUrSVEvdHdrcGJ0YUNo?=
 =?utf-8?B?Mnd0Q1l3K05vQXFnbHFKUXFVRk9WVmlad1B5Y3RGMGt1R2ludWpaSmpoMTBH?=
 =?utf-8?B?eTQ3eWIvU0hIZHl3TFIyQ3VCTlB1Z0x6NDV3clNMaXdmN0dtMTN0WDJLMytJ?=
 =?utf-8?B?K1F1VVR6M1ZjZHA5NUNPUEMxQyswSERhZ3VqUWF3c0tCdUp5YXFNT1dsNm1k?=
 =?utf-8?B?VFdTVUFzZTU4cWd6U1hwYmwxRVF3S0dJN3dxMC9UUjBjWWFtbjlaSi9CdXBQ?=
 =?utf-8?B?YXR6Mmw1N1lremo2T2xWa2VXYW1qSW1uZXZIK3kvYlBjbWRwZ3VhZWhkVFVq?=
 =?utf-8?B?a2JTMTFyUnY0L1RHekZ0RUpCN3NFQklEdGNqaXN1YUw5NG1IVXdPc3I3d1Ew?=
 =?utf-8?B?Nm5RTmxNbVJaVHltaU53dlRrQjhMTFNxTjRGbE15NVdxa2RNVndkRzR2T2M4?=
 =?utf-8?B?R1p2UFpMQ2dITC9MY3Fra0VHWUQrWGFQbEttUld6V3lEY243UHJ0czJtbW45?=
 =?utf-8?B?d3hLUWU0Y2pJMmZOaGN4WUdHSUUrUm1PNXdiQXBrcVNPS2M0SVJEdXp4Mm5G?=
 =?utf-8?B?UE5hNXFEbU1WaEtFRU1zajFqZ1FzUzJkd215LzJSNG4wU0k2SnExakQ1akVp?=
 =?utf-8?B?L3JxUDlXdHBKOEVHTXBsTEhVNGNOMHpPYVNrN3BFQXBLQUhnZVhVVnJJbmlD?=
 =?utf-8?B?VEo0YVlnZkxWN3dJenZrNjRuZU9sQnBzSkNISnRXUG5hTmplVlE3cUpzbzd5?=
 =?utf-8?B?TjYwcXQ0QVdlcENjRkh1dGh5QXpXYlhOMmhOR2V4YUVUNTh0Smdmd1Q5Vkw2?=
 =?utf-8?B?ZENIKy81Zys2WmNTdFlBVzFJb0FMMXE5NXhwdkJNZ3R2SnVGQW1uVmxpSjdp?=
 =?utf-8?B?S2ZJR0V5ei91dk1EYWhjNUxQdTlQc3hzVE44eEhGN29wQ0V0MUk0MXBqa1lI?=
 =?utf-8?B?SUV3OUJjUzVoalp1UjhDYVhONzdVVE40ZHFwai84YklRQUY3Qm1kUmoxWUtW?=
 =?utf-8?Q?WhrWYkDdRVD+cL4P8B44tC0Yy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c030f4-6cb8-435b-aeb4-08dd87c2f7cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:42:40.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEJjj1hTVoflJHMUHljCyQBmcKG3TEomLk/J8YoBJ3isqF202fH1rd92dU+gmmgnwEYBRpAKV8KAdnWzEJ2qLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910


On 4/30/25 04:24, Zhijian Li (Fujitsu) wrote:
>
> On 30/04/2025 10:17, Gregory Price wrote:
>> On Wed, Apr 30, 2025 at 09:29:15AM +0800, Li Zhijian wrote:
>>> During kernel booting, CXL drivers will attempt to construct the CXL region
>>> according to the pre-programed(firmware provisioning) HDM decoders.
>>>
>>> This construction process will fail for some reasons, in this case, the
>>> userspace cli like ndctl/cxl cannot destroy nor create regions upon the
>>> existing decoders.
>>>
>>> Introuce a new flag CXL_DECODER_F_NEED_RESET tell the driver to reset
>>> the decoder during `cxl destroy-region regionN`, so that region can be
>>> create again after that.
>>>
>> My best understanding of why this is disallowed is that firmware/bios
>> programmed decoders need to be locked because there is an assumption
>> that the platform programmed it that way *for a reason* - and that
>> changing the programming would break it (cause MCEs for other reasons,
>> etc).
>
> Hi Gregory,
>
> Thank you for the feedback. Based on current CXL driver behavior, user-space tools
> can indeed reprogram firmware-provisioned HDM decoders in practice.
>
> For example, after a successful boot, one may destroy the auto-constructed region
> via cxl destroy-region and create a new different region.
> This indicates that the kernel does not inherently lock down these decoders.
>
> As for the locking rationale you mentioned, platform vendors might enforce their policies
> through mechanisms like the *Lock-On-Commit* in CXL HDM Decoder n Control Register
>
> While platform vendors may have valid considerations (as you noted), from a driver and
> end-user perspective, depending solely on firmware updates to fix transient failures
> is not smooth sometimes :).
>

Hi Zhijan,


 From my current effort trying to get a Type2 device properly 
initialized by the kernel after the BIOS/platform firmware doing 
whatever it needs to do, I really think we should have a wider 
discussion regarding this sync, and maybe to have first something from 
the kernel expectation of what the BIOS should and should not do.


If this makes sense, I could work on a initial draft about the outline 
or points to discuss about this.


Thank you


>> So the appropriate solution here is for the platform vendor to fix their
>> firmware.
>>
>> But I am not a platform people - so I will defer to them on whether my
>> understanding is correct.
> Yeah, it's still in the RFC stage, let's hear more voices.
>
> Thanks
> Zhijian
>
>> ~Gregory
>>
