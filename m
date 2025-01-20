Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C91B86F7
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376795; cv=fail; b=MhRWx0WxOhpwUVRJKyhSjY6OudW8g4og7gCO2bC9lFDidQkbwndEsdtWPzDBMnVS3WrnnySwL2IPNtp1c4Be1hsyDoMvYF424ke8xh1s7GlHpNXU+3oFgrkM9xIZ2HoPosToFhDj9AUH61mJJTNeq08L//gYb/r8mOYmq9XOxz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376795; c=relaxed/simple;
	bh=tHH+LidmaCNgOp+ohi2gcBzLHKBK//K3cYXZhTtBDrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmR0F9FOJAsRCXAI4tqCWxNU+rG+5Z+YI+qSiY/BLbwua2YKGZ2IH1Cs1lwEEdWHYos0te0on8xO8Np5tmJkJULpsQ+BftdVVeaz+YLyNoRe46HAL5jlZtpZFBXtLIFpU8LYH0IIw6vyt1c6ql7o+JfogpQYDQzWGK1vO8x6m4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QK/aBUW8; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QK/aBUW8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK+mviPjvWnCbMrTgF3x7irPmEX0k31IxA/ljYscce3hOhoKVsnNbo1Aa5kDAnCF1p1svh0uyvEJVPgYsIAPLfK936dStMZTdTwMgCP6nyk8QADLZT8cwTuUIHop9JBH/NvHnIZpUXGeow7gFafiyFPaGN2T7l1Xqy51SAY5VINqf9aoAcS4npEKVb77r/9osB0/mooASZg7t3dkmPY3Hi5yDzLs1+W9dr+NAkyUqEXRZbutp+QLcTx+t1Mg/BCFRSsce/wum7VhmFWSmwVRW5DZiYa17/fkjhqDH/KJwyvIY8YdUlrWnyXd3Ygh0DiSJ7VR8R2MfilsLzIgm2FrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfsSIDpPJJZNA66FVOmgsdPREs1C7LDQMavpkPLw7VY=;
 b=wKgAS8GuQvYyCGzD91E2QY4801J3a2I2tpQ/WNpOki4zFbHiGWs5l5zA7yJmXGwEk1SbV4dbfEGYvkQ2WNKLbTo8of3MgQCFCY5GQ2HDbrQTutKG2hnopkJ+8yj1kxxG0Cc9f936g90lL8v5GNeMbL1n5Y3VejkNdn8Nd0iGBf3qnI8gaxUEq+7WfHFqcu0mFH9sqnK9jTyBLF5FidZ03KuLVzuwqwv/ixPnviinvDEwfZu2mmyFCr84gNLTreS1taFjJEVDhLGlTcvHNXjmPtHIguDvjLS1veAsDR77ujzX5So4Xm2Tf1xA35vFge8eATrK1Pl0WRRZQhjZ5Dxl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfsSIDpPJJZNA66FVOmgsdPREs1C7LDQMavpkPLw7VY=;
 b=QK/aBUW8/PAO1TBRZ5f54EdknSCVfRSihHOdRNBH5CstOMVmuJoKdNDatJ/GgZYWtvkGuUz+fNvZ9EafNAcQZ/eWgIMcEugqA5y2lwb6+Q/fsNJ5Ll0ho6bPReIgggPazAVtLK7afF9ZQO1e+dY73Cz4gBzMl1aZOkzD4Ey3Z0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 12:39:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 12:39:49 +0000
Message-ID: <76174723-c8b0-8937-781c-3e46fcf6c0b4@amd.com>
Date: Mon, 20 Jan 2025 12:39:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
 <53ef6364-4523-05bc-4fa1-8a2110f5fe54@amd.com>
 <678ac4316a7f5_20f329456@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678ac4316a7f5_20f329456@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0044.eurprd06.prod.outlook.com
 (2603:10a6:10:120::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ef004b-6196-413f-db87-08dd394f876a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkNCT1lHUXZVK0phc1Uwam9nQlpwMlNLMkZBU2UrQ1hLN1FQd3JFMDNVb2VE?=
 =?utf-8?B?OXRKQmNlUGVmM280NGtBdENQK1JkakVkQUJsU0h5TTlvdjBObWdLNitLZHNn?=
 =?utf-8?B?N0pIR1p3T1NkMmlqYU9QTXhjbWE3ZVZHRlJ0WU54Z0RCbC9RYzZ5MldjRHl5?=
 =?utf-8?B?c3c4UGVEa04vUzdKY1RZMTNxMUd1MWUvOFZjN2pNQ1E0SHhWZGZiczBCOTlu?=
 =?utf-8?B?WjVWUjJtQmZuMmtUM28zeUc1K3psRVB1WW5SMjZMeUVJUVh4MFlJSFlhS0Vt?=
 =?utf-8?B?WlhaOUdhYUpyMURneUYyanJ6a29xSituMnJGVlUzWjlCaS85Z1lSY2Vhc1Np?=
 =?utf-8?B?R1oxNnhVY05aalN3dDZYSVBRN3NYRElWdmc0UmZ4ZnlxU0kvNU5oOFFpb3R5?=
 =?utf-8?B?TmM3dlA3aFlIMk5kRFFTSDFCcDFPRW90dDFtNzhJZVBzV091ZGFTL3I5dlRp?=
 =?utf-8?B?L25LMHpmaVlqWjlnTkVVNUl4ZFhNaTBlYU9UbzlabTZ3UTBJQzVsWHU5MkZI?=
 =?utf-8?B?eUFUb2hkUUZUUFl1dXdJSkVSdG5OSGpPelovU00waHdPRmNhaUY4eDZPYkZI?=
 =?utf-8?B?eWh3VmhGU3ExbWNPdlN2WjNabXNUSzI4NW5mQVpleEdxZjZXc2NHM3Zxdml4?=
 =?utf-8?B?ZFFwRHRBS0liMEIzWTVHRVMwbWwrWGRaOHpITThqNnpia0VTYzdRaUZjc1ZS?=
 =?utf-8?B?LzBVVjQ1L2c2K2xhbkR0RkNMbTBSbE1SYlFwVlVseVV3QnVkSnJQeWtzSFhS?=
 =?utf-8?B?YWw4N3B0Z2I0WFZNMFJMWHpIZE4wRXFQMVBGaldUSTZjNUFiSGR0eGNPLzJr?=
 =?utf-8?B?NzR2UGlBVHZSdEtWb3B6S1YxMjAxWC9pV0oreHBZOEJzZE4vTS91VXAvdjNx?=
 =?utf-8?B?UWNlU0V2ZUpGUSsvYmY0blV1ZnJ0VEJ3bHlxZEFGd0Fpb1ZQNERBZlE3K1Q2?=
 =?utf-8?B?R0djWk9IQ2pMMERva1BhejhSdnZlajFMODdLZktOMnRXVXlSamNUOVdueTkw?=
 =?utf-8?B?SGNrd1dCc1BpMXRFZjdxQW80S1R4bDcwaVdEaTdlc2pyQWwvVFdkM1Q0QW5O?=
 =?utf-8?B?cGxBRWdmZ3JoSng1aFluMDlZQTRvdHhHMVUrZjVXY2RaK0xRdGZuam1ha2kv?=
 =?utf-8?B?MnY2OG5vN3FJL0xjQ3BzK1ZielQ0RjU4UVI2SVNlK3JYUy9JQ2lhdk5NZnpO?=
 =?utf-8?B?dlhPM2NHVTVXWmNRK200a21YNEcxRVk2Mk9rdGdTb3RWSm9lTDJtY3VNOFJw?=
 =?utf-8?B?akplc2t3TDB4dGw3UDZoNWVlQkJMU3IzWmVFQkNrZWZPT3FobGxYaVUxckxa?=
 =?utf-8?B?c1k2Y3lqOFlaTnZtRzgycUdmVWZJQjZkMnhIQlpVeDFBU2NZZmhqNzBGZ1cy?=
 =?utf-8?B?c1hxaXhQSEtaMzRKc0dtQmJJME0xeWpaZW81dERxNlhEMW8xcWdDNWNrK1Ir?=
 =?utf-8?B?VUs4TFFwd0VqeDY0MWF6QlJYelV0bktHVThZdko0ek01MVZpWUg5c1ZYVThq?=
 =?utf-8?B?bU8yMWEyVlA2MDVFMGdFaEliR0VydTN2anRoWVFOdVFEalJXMmR5MUtRVTFY?=
 =?utf-8?B?WXVRYW5lTXFwM2F0eXlFelBpaFJwNGx6ZGk0S1RITXg5WUhqQmc1UDNjVVlJ?=
 =?utf-8?B?N3hBZkt0amQ5ZnZTMnZQOWNaS2w4czhoRUxrRGhFYW0zODhpRUxpNmVncVdM?=
 =?utf-8?B?L3lqeGJvaVRhWHVydUx6UUZwRXBoSDBsNEhYRGx1SWM2dUhveTB6WTRWRVhS?=
 =?utf-8?B?bXB4ZytDQlhOanR6SnBsaFo2M01IdkJsbFY4UGFyYWFSWEx3RWUrcTNBVm50?=
 =?utf-8?B?K2hXbDZwVjF2VnduMnNyZHkrdG1rUFUrWDM2ZThkakoxd2NzcWZ4VElxdzlm?=
 =?utf-8?Q?niq5E7V/bpGpA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VnRnNXL0xFQTFvN0ZVdHhwcWdoRGNFb3VnTkpaSTZxRkh5ai9uTkJyc2Qz?=
 =?utf-8?B?SW1GQmdWamp3V0hLTFJqeXFVU2lIQmpMN0dnVDNvOTY5amFZN0tscUpTSndy?=
 =?utf-8?B?Q0Zzc0o1d1lDOUQ4eEl6cTV2SDF1WWl2YnZQZmhNVWNHVHVoeHBCejNyMlhM?=
 =?utf-8?B?RUdZWEw5clpxc1JvS3Z4OVpscXJpSG0weGg4ZFdBTWYwd2ROS3VlRG1sQTd1?=
 =?utf-8?B?SStGTndHYWdMMXo1YnNEOW5HMHFPQngwR2JDaGJBTld0d3FzcWlzQWcvQm5v?=
 =?utf-8?B?ZkpDMnR4L0tPdGlEMUFqWUEvbDlVTHpMd29kSzRFbEhSMDhJTGduemg2SXhP?=
 =?utf-8?B?d3JpNXFmY09zd1ZPcEpHR2xrT1NaNUgySGw0SFkrLzQyRnFxY0Qya2MxTHBY?=
 =?utf-8?B?bklpM1NTdGlHRjVyS2dtY3IxUzh5emMrc1Yvd3Fia1ZtNFNZKzFHczJLTStJ?=
 =?utf-8?B?b1JkdTJlOVlLcDU5WGY2Wlp6MXR2MzBQY1M3Q29iR3hHYVlKdk1qRjFZd3Iw?=
 =?utf-8?B?NENuc1lzY1k4MlZsdEl2aHZ6Nkp3NDlsdy9RRUFvdERCOW4xS1poVUd2SVlE?=
 =?utf-8?B?QlBISXBTMkcrQkZtZzVyRXBpUGxQUzUyVkNhY2YyN2I2NHMxZDVWS1VXOU5Q?=
 =?utf-8?B?L3F1eFEvamQ0VUJXUjNCbURMdlpBYTZlSHZEVk1HM1dBaDNqMThSMCs2NjAy?=
 =?utf-8?B?cm1UMDNKSjJWTDNOZzMvQi8zcEZvVGM2OVhtL0hFQWdRMmFWS3NBay9tSTlJ?=
 =?utf-8?B?RjJuNmljazRPU0Q4M1U1Zk9VVStUdFdCNmV2KytzSzRZZmtFMGZCOHJTUkNK?=
 =?utf-8?B?dVVNT1QvNlgyNWxUbGRjazJwUWVqM3A4M1N2SFlOdUV5UmxwT1FVOTkybkhM?=
 =?utf-8?B?Vlpad080VXczTy9VSUFrMW5YNUxlR3lLQXl3NG9ycitZYkkzYjR0VVdCWWhY?=
 =?utf-8?B?SlhrNENVY0ZwakpobkdPQVpDLzZLNW41TS8rOVRGSXBlNmdnZDZma2s4T3o4?=
 =?utf-8?B?cjJPdU1QT1FYTDVNTWs1MEZmZmVqT0p1Z29LSGxVb0ovSGYvbnB3UFF2NTVL?=
 =?utf-8?B?aTJnMUh5aHBUNkVEc29PQjQzS0lvT2x2TVJCOWJCcktKdFo2Y1RTYTA3TExk?=
 =?utf-8?B?MjZaSDNZMjVjQ3dCSk8xSlV1ejRUMGNVd0g2ek54U09Mc0xrNG9mbmpQWlF4?=
 =?utf-8?B?dFJFOWxYenNVNk5pWFp2QW92K0hCZmdWS3JzZUJPcm5pVmp4NFk4ZTF5ejV6?=
 =?utf-8?B?anh6cTgrZ0hPL1VqcFJGWlB6RjlHNTlhd01BTzhZbUdUbU9ORVJFY21weUxN?=
 =?utf-8?B?dnM5NG10cjd3a3VUTzk0Q1VBSkJ5Wkw1WVV4bXN1cVVCdExtZ1pYNHpGNUlJ?=
 =?utf-8?B?N3pTN0t5dFFIMXhMMFRiOERaeDMyTXRRREhwMnd4YmFsZUtRTm9KaHEzLzZH?=
 =?utf-8?B?NHI3dUUrNXVPdkZzdGdwWVBlM3hJT1VLbThzMTR3NS9hUDVoRFI4VjlOV1Jz?=
 =?utf-8?B?WUV2cm1jVk9yaEJPS3RTdytqMEN3MC9IRUpCSDNRVEszaG5USTVGR0NMeTF5?=
 =?utf-8?B?dDFGK0RoUzRVMXJ2eHk3SW5Kb3lrc1EzbnZvakVzdktDYjFET0J1eUpUSFpE?=
 =?utf-8?B?WEsxYktNTTRKUnIyZUlyTndqOWR6U0J0QlRlaTF3NUorUFRGMGhwTS9WVlc4?=
 =?utf-8?B?MGhJTHptVzFHQmU3Z0ppRldTUzF6MTNJckFNazltdnU4QnoydzJCOS9Jb3Br?=
 =?utf-8?B?ZHJMNS94dStxT1lRakFwNmtTeExwdllrcWZ5djVodk1MZ2lHMDNOMFV2Ym91?=
 =?utf-8?B?b040VVhPNUE4T3Jrb1dPY2QwUzJsNUlIQXlDWlhNT1FPTGJlMlVmblRmc0VG?=
 =?utf-8?B?blI4RUZ3RXE1Z0ZhMmFuMVRXT0d1Y2QvaXFXVEtndDlWRjNQK01VNUtLMnVT?=
 =?utf-8?B?YXo5dDNyZUNaNkhOOGVWRmNzM2l2dE9EbjhuQWNrNnVGdklkYUV5b3pOcmNF?=
 =?utf-8?B?RVlFZGJTdXRVQ0Z4R01DeUsrV1BlS09ITitvTGNEbjVGcVpYMEduYjZQQVNF?=
 =?utf-8?B?by9WdmZwQXZxajJ1b2tkTnduSDkySEFkRDF4OFpVbnNtWnVweFdEbE5hc1ZS?=
 =?utf-8?Q?RvF5xTa0GVDrcV7oHfi/DX0J9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ef004b-6196-413f-db87-08dd394f876a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:39:49.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHFp128RPU5rej6NJmhWaZzo47DkVr7x8gFT4CBQ6jm7WmHbQfG7JH0UMaIElMUBrOmy03z6o3uCLBPNFaeIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721


On 1/17/25 20:57, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 1/17/25 06:10, Dan Williams wrote:
>>> cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
>>> allocations being distinct from RAM allocations in specific ways when in
>>> practice the allocation rules are only relative to DPA partition index.
>>>
>>> The rules for cxl_dpa_alloc() are:
>>>
>>> - allocations can only come from 1 partition
>>>
>>> - if allocating at partition-index-N, all free space in partitions less
>>>     than partition-index-N must be skipped over
>>
>> In my view, you are mixing the current code with the new code in this
>> explanation. It would be better to say the current code assumption is
>> just two partitions, ram and pmem, but DCD changes the game.
> There is no mixture in that description. The rules have not changed from
> old to new, the implementation is updated to reflect that the algorithm
> never needed to consider ram and pmem explicitly.


Well, if I'm not mistaken, until now we did not need to support an 
arbitrary number N of partitions but just 2.

In fact, your next sentence just confirms this.


<snip>


>
>> I think the problem here is we assumed ram and pmem being a child and
>> likely some free space, but a device with multiple HDM decoders implies
>> potentially several child.
>>
>> The code supported the case of multiple child but I guess we still had
>> in mind the simple case. Otherwise I can not understand all this ...
> Holes are not allowed. If you want to delete any decoder capacity you
> need to tear down all higher DPA allocations. That is a constraint of
> the hardware definition around how software can assume the value of
> DPABase. Will add some comments to that effect.


I have to admit I do not master the case of regions created from user 
space, but I thought the idea was to allow creation of regions from 
independent devices for facilitating interleaving and just adding 
flexibility when needing a memory region bigger than what only one 
device can offer at some specific time.


If so, I would expect cases like two different regions using different 
ranges inside a device DPA, and the two regions completely independent. 
If I understand your answer, this is possible but if you want to release 
one of those regions, you can not use the released DPA until the first 
one is also released ... my instinct tells me this can not be the case ...


If what I'm saying makes no sense, I'll try with a more complex 
description with a timeline and actions from user space, endpoint 
decoders, regions and so on, what will definitely helps me to 
(hopefully) understand the user space case.


