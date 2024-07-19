Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAD1362
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jul 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370731; cv=fail; b=Fzau9YfBiLRuWG2Sa/sBbOQwszCV4JsgP8ehdISqAiAvgUArxFmzNR2rA3WgXBdnN7Dfaaxq9gVOYYweVjq6ob3TTK4nscpcLvOIc9tgmnLZEixDQvkFvzRkluGLpgbgZCOuD8e4Ywi7cE8095Ef6shj8nbILugOZgmgVo8lGYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370731; c=relaxed/simple;
	bh=nHExcIDaT1KlJ9A23YW+aDfNeryou7J86y1w3Sl3vWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzuZE3rB1ge1WaAL6V9/+P/V39kcPLwSqZV66yCP5v/GVvPZMxn+kAJF8So0xMOh9Sx9j/Tj0kHuE/+D7TmnY3QZ3twAkn32lWX48zeNKlkSU8V6+uyKw92sxrjwlHgW1FnmwSRFi19Bf+A12r5l1Y48wFqacnq3rmdcVzwbtxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIqNj5Ch; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIqNj5Ch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amG7D1sIKfmPAjwH0cEWk10T6DAA4NPtO6GHXSNq11CYY0qqvwZq8PFgX8vJ/if2I0VWHQlfxzIQdcRnvpbPMJkhb40lwE/FwT6phIHcHG4DugeRk2xJ4uw6/072AWRoQue55klN1oEg8If5zg6aN8R67adSYvkJU/V8ZOhQZFQkUSr9vSDLuF9Iaw4sMwvbecOmOINh7t2DMjIxgMOo3DFuJvmVaQsf+IsJ3IgVqN0OmTWqcHW9hB6zAVuvZ6RG10R5ZI/vJIDvL2pRR4VMr58t2YxpfP9HrzAQdGQFNTJZDNj+06Kvmie/3nxyJxo/ObCW3zo8cKRJ+TsrVuxw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+E/FG2rp3MlphwujLli6uQWaszdlwQNVc10Hmlm1tA=;
 b=WatsumEFmA+I7lxJwa4I2PqGhibFkAWr5NX0WSXgglLjytOh7kt0VF1y8lwvLFm+yZXXdaxdfEDnEB7q3Apa0+wp74I8p7FuUmkN8942k3SPXMZKMKVv6ug6ppyVo23V03t5vrrfGlaTNp/iDV6ZlUKTaIayi/aesIquNKXWR+2eGHL2Y7//6FuovZFrJquxyONEXLby2Msr28qZfLiVb2TZ/aVSF7yqRTANP4rRDTl4sVoFbzphWinWRvVJQgFAEvhb8CeFCkcw3BVx2EAXNwhQ7HQhTAhvgQ2c4Y04Af6CXLcjDrtOyjDu0Gbf28+rAvBYmgrIu7ERfyPcSFYgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+E/FG2rp3MlphwujLli6uQWaszdlwQNVc10Hmlm1tA=;
 b=cIqNj5ChDJv35t8fPrTJv5dpCNxMi4B2eo+8InnxEYy6w+0j2ptRZF8roslnhrr4pLxikJs3uAlPOD5+vai5IHsPiLTQFY5xv7VTVvbl0pNehkHR9wL+u2hlCsXnRcZryr2HiCVkRBMIN1GATyGBruBHPxVwEae9KZ5wqjvNC18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 06:32:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 06:32:05 +0000
Message-ID: <6f0a4aaa-c555-ae7e-2614-f15871e5725a@amd.com>
Date: Fri, 19 Jul 2024 07:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: Move mailbox related bits to the same
 context
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-2-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240718213446.1750135-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 20031deb-e229-4e2d-c102-08dca7bc8160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVvMlhLd2dUVWhSdzBiL2I3NFI3bGlZOGMzM2tJcU5kc2FUMjNDWjRNSVph?=
 =?utf-8?B?V3hmUFpmQk9WdmxUbDA5a0dDUnJxd2w3czVGTWh5dVVwZCtzbUtjNlJXc3Z0?=
 =?utf-8?B?alVIRVhJL1hXR1Y4cTBIVncvR2Y1VWdNbURULytsQlFvbE1DN1lsZGpsYTdi?=
 =?utf-8?B?SlNCVTlCeGtFZG5aNmxmblZ6NTJ4VmVaVHN6em5rMXRrLzJFMm9UeGhUeGFu?=
 =?utf-8?B?M3ZYdG1CRDBYK0l1SzJYRXNzR0tDb2xhNGZZcDRvZ3BJTWVvdlVzei8yOWhi?=
 =?utf-8?B?eURKdjA3ancrYWtyK3VGWmxWODQvZGpPU01WV1p2TWIwcFRRNS9ZOUR1djhw?=
 =?utf-8?B?ZUZHV1RSVmxaNVlKR3NXazZjTFg2SVV4WFZxSVBRZzBLTWYvWmdCWThmMzJj?=
 =?utf-8?B?cjZmMGNORzZ3OEJIVFltUXlRZm5yeGV5ZndDd05iN2JkOGhiN1RQY3lUalRV?=
 =?utf-8?B?akREZ3NvZy9EOFBueVdCc3crRzFydWVlTWpaUEJMbXEra2I5WUxtR2hXN0U2?=
 =?utf-8?B?Nnh2dnRIL1U0VlFQOXhQYi9ONHVZaXUvQmhDTTI3dzJGRTRETFppS0VuV05x?=
 =?utf-8?B?Z0RUMVBUQ3NMVnJFaFVtaHY0OVV4T1R2UG90elp1cnhhN01MNTN1bjhYOUZ3?=
 =?utf-8?B?VEZlMTJZWWJYZUJoNWNqK09LeGl1VCs2amFPNEpKSkRTaEg0RUtCalRpczNo?=
 =?utf-8?B?R3VJK0xTSDJmUGVKc2xRYkdLVERPdEdUU1NzMit1ZTd3aitIVTN1dGxYemRs?=
 =?utf-8?B?cm91dndNelp5bkJCQUdyTFB3QjVLMGY2ZnUyanRRTHNNdm9EdFhpTDdHSkVI?=
 =?utf-8?B?SE9OQStDMVlCQW5BSmU1dzNoaTN1R0NjVDJ1cUZDNWpzbDU1ZzBpZFB5RTlW?=
 =?utf-8?B?UDJWRUpKTWNVSXRTeU5aRzJ1WW5EN05rVmVSWjhpWmVDNE9Gd3MxMUNtdjYr?=
 =?utf-8?B?MFYwTnlZMmpiT1BwNkZTTWluOWNabk9YeEJudElhZCthMko2TU9FNDNDZjN2?=
 =?utf-8?B?VndqSWx2eEZZVWVDNit5SzlFMDFsaUw3MC9iS1NlK1kvZXg0WXBZNjBWbUxh?=
 =?utf-8?B?alprd2RwZENVSWlaQ3g5cVRSUlIwL3IvV2FINkF0TnRobHRNZDVzVHJXRG5k?=
 =?utf-8?B?bC9hVTE0dnl6TVlaZVNXQThHd1djcmRNa1d6Q29TYmlSMUtPMDJwMFA1bVhO?=
 =?utf-8?B?eWdpeXQzTkl2OEk5TW9lamVWQmJ2UWpST216UzNXd244ck40RFZ2MnRLeVNO?=
 =?utf-8?B?bHFTamVZQmpRMVNaRFNQanNGaFUzZS8xdlc4LzJ6YTFORUMvc2djY3hiMVhr?=
 =?utf-8?B?S3NPUElFdmdkSExMRkNTNC9SajhXb2pOS0wxL096K0ZBSjN4R0RvQm5ZRi9u?=
 =?utf-8?B?UlF1Q0lISUFBcWVnUDZubTZ2eitoSFRlTmNJbzNnZUZZR1h3YjFuUzJNMUxO?=
 =?utf-8?B?c0Q0YVR6VGR0QlBrRUJGQmkzRzdrK3RHVy9JckI2cXlHQnZMemlVeittdXRJ?=
 =?utf-8?B?SDlwZm80TUpPQXg3c3E3dFFheEw5bE5GMWZ1RDNKZnVXZG1DbFQweXh3QUJt?=
 =?utf-8?B?c1RnYXh2WjVmVWhXQ1Vxb2F0MVc5eXFWa052ai9RZ2lPa2s2djdNaWZuQ1V3?=
 =?utf-8?B?WlNJWE1lYmQ4R0ZkendQdUJoN3RWUytJRy9LL25aM0I3NVZ5T3EyODlsVnVD?=
 =?utf-8?B?MGFuODFacXdjaXNYeHIwdWMra1pWT0FKVkRtUUZISUJxTzJpVlhmaTQwcEhW?=
 =?utf-8?B?NVJHNEtjeWl5aHhNc3VId0dPbFRjSjZwbUgwS3YxcVVSRWdIQy9ObUpmV0w5?=
 =?utf-8?B?L2w5Rnc4N1RtSWJ4VHQ0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldzWEl2U0UxQUg0UEN0Y2R6UExDb2xhUzJGcURKSDJNVEtjcUpiNTdCL1Zo?=
 =?utf-8?B?NFFpU0h2d09KQmZFWmNFRitmSk05Z0NpVitlckxIWEhoZ3pKVkY3bWUydGZD?=
 =?utf-8?B?WUNmVXJHd0hMZytNYnE4NFZUVjgzaHZ5ZGFuSVlSQU5oa3ZlU2QwVzdBeHQz?=
 =?utf-8?B?M0plNXhYYk9Ed2t6a2JBSkhnQlpUcDE3Ym0weGdQU1lSTGVpc0hQR0ozVG1B?=
 =?utf-8?B?SVpDQlEzdG1JTGgvaldPTXhHaGZudzVFa0w4bTZlS1ZwVUd0NWxGdUtkM1NB?=
 =?utf-8?B?Yk5tSFJnNXA1dGpiVlZ3aWltNFpXYUVRWHdmRWZITVJzRE1CYWkrcmJQczdX?=
 =?utf-8?B?N2VkUXlCTTVlZWxuSGEzZTd3Mnd5bXd0U1FHMS9CalR2Y0xzZ0d1RngyL2tT?=
 =?utf-8?B?dTFmS0hlS09BUGxMcUtFTFFHZE9ETnhXeklxWGxWVjhpY1pBU1hKc1gwZHBr?=
 =?utf-8?B?RDRHS0puR2FKeXJmVjFLdjh6bERnQmRTMnM0dTJNaEwvbS84aE9MaGM1Vkps?=
 =?utf-8?B?V0xnNVFwM0FvcnYrMU03MGk3cUdYNW1TYVNLQUFBaE9VbzN4NmY4NzBGeVc0?=
 =?utf-8?B?ellSS1ZmSnRPY3lrWjcxZW9DTitvRG9pSDArWEFFNUJCQTFiS25rbTAwYXlP?=
 =?utf-8?B?bmw0OU5mRTB6RjdXZXB2Y0ZhSklnSDdmcS90SG8zQ3BOaVUzMnhBRzQ5UUdz?=
 =?utf-8?B?emx6QnhWSmJ6ZG5hM1ZJMUtnN0F5bEExSGNTcG0xbG5hUUlHQVdiNXFVdS9n?=
 =?utf-8?B?bVhDR2w1YnI3OTNPZitYaktvRzludDNKT2pSSDhVRzM4TkNzeFM1YU1qOFQv?=
 =?utf-8?B?Mm1sYjBnWmhvSkZkSWlHS2s0TnVPbkszYUJ3bFBrWUtQOVExQ0dLVlY5bFJR?=
 =?utf-8?B?UUdkWGNPdUxJRDFpOTJkYlR4Ny9MS3lEbWFvVGdTcFdWVjQ3aU5vOWRZbUJT?=
 =?utf-8?B?MVJjdzU5Y0hWVXB3NEpadm1kSk9tekc0QmRLNmlVRnFQQURFNHpJZnA5RVIz?=
 =?utf-8?B?L28vUEg5VUJabndsRU5JNXFYalNPSW8zSEJrMHdGcDJPbkNBdmNDcXloc0Jk?=
 =?utf-8?B?NlZ5SjNKRC80Z1RObXdXVllFd2FkQkI1QkdLQlVnZ3NTRUFmTlJMa1E0VUpW?=
 =?utf-8?B?V0d5dm1Hbjk2S3N1Q2JhS2s0QVY5YktjZ2pFQmV6U0ltc3JNeGpMc2FYbE01?=
 =?utf-8?B?RWFDbTdSUS9RRXd0VDV1dUFOMW5SN1QyajNqdkZEQ05wMDlZdDR3U2Y4TzNG?=
 =?utf-8?B?ZWZhNzMyOFlQeXAzdFk3MGRBRFQ5bHpLcEljTkN5TWdxdW5OaUlvZ2Y5Q3Qw?=
 =?utf-8?B?YWFmRjBLT3l0NmMzaTNwM0g1ZU91czF5Y0dwL3pPT015VFU2bGdOU2FiOHJQ?=
 =?utf-8?B?QTdyZENoUkh6ZVFhMHhpRE1yVTcrZUp5TnZ0cVpDaVhPa1ZmckZSVlZtYnNJ?=
 =?utf-8?B?RlFJN2NvdEZzam5CUlJxbTRPQ3lJMTBmV3FxY3pjREl3WkJsRlJ6dnMrc1hs?=
 =?utf-8?B?OHpYM1VEakVhT3o3RERxKzVDOUxWWWplTEdiV3hQUmJ1QXlCeDViTmRuTHEw?=
 =?utf-8?B?RlJiZ2ZmQnRheWJLQ2RFd2hjbk4zalIrcWhoamc3RzlYVHc1MWV2VlBpY3ZG?=
 =?utf-8?B?SFJLOUVHc0hnMGorYW5ycjJxb2NvQ2pjRnRCaGJoUjZmK1QxYkpmbVdVRzZv?=
 =?utf-8?B?cmw0R2doRHQ0dGpYMzU0MGp6ZHNERFMwVnNYdWVnUzFiOXg5M0l0TTJaSkdC?=
 =?utf-8?B?VlVEZ2JxM3B1NXFuZ1cxSmNkVDNWdkE2UHErbWFQVml0c0hvbk9BK3BLejAw?=
 =?utf-8?B?V2VkY3ovUklNd0VCQkV5SkJMbkw1bmJLNmcyZDAwRDJhbk81akhaUTJvU0lF?=
 =?utf-8?B?a3JpaDZlMnRudG10N2hhZjI5UDdvOTViK045SFh3NzAzVjdaWFBGd3ZIMS9J?=
 =?utf-8?B?TUlhaUtlcUtGSkxRY1VqZEE3NVpWMWtvejRVSC9YcmUreUxNVVc5NmF5WWpq?=
 =?utf-8?B?c1hEUzNtbWo0cW9FRlAxc2RKMkhwVUVxNSs2NWJQcU90aFFMVHJOMkovcU55?=
 =?utf-8?B?dUI5eU1CbGNZQXNQQWNGSkZoLysxQlBGa09UeDd6TXNTelkwV25uTkdWZXRy?=
 =?utf-8?Q?XeI73CDd1ff0227GfAADSTrz4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20031deb-e229-4e2d-c102-08dca7bc8160
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:32:05.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jidtn/mfhdmOCYgJIec49DfEUOu506sQdGamy5UxV2uv7P2+AuTT+sEdqbQfqVU7L68/rCZbuCt8hmXI8fHbBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306


On 7/18/24 22:32, Dave Jiang wrote:
> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external caller (fwctl) and avoid exporting of
> CXL driver specific bits such has device states.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   MAINTAINERS                  |  1 +
>   drivers/cxl/core/mbox.c      | 48 ++++++++++++++++++---------
>   drivers/cxl/core/memdev.c    | 18 +++++++----
>   drivers/cxl/cxlmem.h         | 49 ++--------------------------
>   drivers/cxl/pci.c            | 58 +++++++++++++++++++--------------
>   drivers/cxl/pmem.c           |  4 ++-
>   include/linux/cxl/mailbox.h  | 63 ++++++++++++++++++++++++++++++++++++
>   tools/testing/cxl/test/mem.c | 27 ++++++++++------
>   8 files changed, 163 insertions(+), 105 deletions(-)
>   create mode 100644 include/linux/cxl/mailbox.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a8ca772b186..3e1934b7e044 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5466,6 +5466,7 @@ S:	Maintained
>   F:	drivers/cxl/
>   F:	include/linux/einj-cxl.h
>   F:	include/linux/cxl-event.h
> +F:	include/linux/cxl/
>   F:	include/uapi/linux/cxl_mem.h
>   F:	tools/testing/cxl/
>   
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..783cb5ed823f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -244,16 +244,17 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>   			  struct cxl_mbox_cmd *mbox_cmd)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	size_t out_size, min_out;
>   	int rc;
>   
> -	if (mbox_cmd->size_in > mds->payload_size ||
> -	    mbox_cmd->size_out > mds->payload_size)
> +	if (mbox_cmd->size_in > cxl_mbox->payload_size ||
> +	    mbox_cmd->size_out > cxl_mbox->payload_size)
>   		return -E2BIG;
>   
>   	out_size = mbox_cmd->size_out;
>   	min_out = mbox_cmd->min_out;
> -	rc = mds->mbox_send(mds, mbox_cmd);
> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
>   	/*
>   	 * EIO is reserved for a payload size mismatch and mbox_send()
>   	 * may not return this error.
> @@ -353,6 +354,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>   			     struct cxl_memdev_state *mds, u16 opcode,
>   			     size_t in_size, size_t out_size, u64 in_payload)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	*mbox = (struct cxl_mbox_cmd) {
>   		.opcode = opcode,
>   		.size_in = in_size,
> @@ -374,7 +376,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>   
>   	/* Prepare to handle a full payload for variable sized output */
>   	if (out_size == CXL_VARIABLE_PAYLOAD)
> -		mbox->size_out = mds->payload_size;
> +		mbox->size_out = cxl_mbox->payload_size;
>   	else
>   		mbox->size_out = out_size;
>   
> @@ -398,6 +400,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>   			      const struct cxl_send_command *send_cmd,
>   			      struct cxl_memdev_state *mds)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +
>   	if (send_cmd->raw.rsvd)
>   		return -EINVAL;
>   
> @@ -406,7 +410,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>   	 * gets passed along without further checking, so it must be
>   	 * validated here.
>   	 */
> -	if (send_cmd->out.size > mds->payload_size)
> +	if (send_cmd->out.size > cxl_mbox->payload_size)
>   		return -EINVAL;
>   
>   	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> @@ -494,6 +498,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>   				      struct cxl_memdev_state *mds,
>   				      const struct cxl_send_command *send_cmd)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_mem_command mem_cmd;
>   	int rc;
>   
> @@ -505,7 +510,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>   	 * supports, but output can be arbitrarily large (simply write out as
>   	 * much data as the hardware provides).
>   	 */
> -	if (send_cmd->in.size > mds->payload_size)
> +	if (send_cmd->in.size > cxl_mbox->payload_size)
>   		return -EINVAL;
>   
>   	/* Sanitize and construct a cxl_mem_command */
> @@ -591,6 +596,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>   					u64 out_payload, s32 *size_out,
>   					u32 *retval)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct device *dev = mds->cxlds.dev;
>   	int rc;
>   
> @@ -601,7 +607,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>   		cxl_mem_opcode_to_name(mbox_cmd->opcode),
>   		mbox_cmd->opcode, mbox_cmd->size_in);
>   
> -	rc = mds->mbox_send(mds, mbox_cmd);
> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
>   	if (rc)
>   		goto out;
>   
> @@ -659,11 +665,12 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>   			u32 *size, u8 *out)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	u32 remaining = *size;
>   	u32 offset = 0;
>   
>   	while (remaining) {
> -		u32 xfer_size = min_t(u32, remaining, mds->payload_size);
> +		u32 xfer_size = min_t(u32, remaining, cxl_mbox->payload_size);
>   		struct cxl_mbox_cmd mbox_cmd;
>   		struct cxl_mbox_get_log log;
>   		int rc;
> @@ -752,17 +759,18 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   
>   static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_mbox_get_supported_logs *ret;
>   	struct cxl_mbox_cmd mbox_cmd;
>   	int rc;
>   
> -	ret = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	ret = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>   	if (!ret)
>   		return ERR_PTR(-ENOMEM);
>   
>   	mbox_cmd = (struct cxl_mbox_cmd) {
>   		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
> -		.size_out = mds->payload_size,
> +		.size_out = cxl_mbox->payload_size,
>   		.payload_out = ret,
>   		/* At least the record number field must be valid */
>   		.min_out = 2,
> @@ -910,6 +918,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   				  enum cxl_event_log_type log,
>   				  struct cxl_get_event_payload *get_pl)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_mbox_clear_event_payload *payload;
>   	u16 total = le16_to_cpu(get_pl->record_count);
>   	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> @@ -920,8 +929,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   	int i;
>   
>   	/* Payload size may limit the max handles */
> -	if (pl_size > mds->payload_size) {
> -		max_handles = (mds->payload_size - sizeof(*payload)) /
> +	if (pl_size > cxl_mbox->payload_size) {
> +		max_handles = (cxl_mbox->payload_size - sizeof(*payload)) /
>   			      sizeof(__le16);
>   		pl_size = struct_size(payload, handles, max_handles);
>   	}
> @@ -979,6 +988,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   				    enum cxl_event_log_type type)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>   	struct device *dev = mds->cxlds.dev;
>   	struct cxl_get_event_payload *payload;
> @@ -995,7 +1005,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   			.payload_in = &log_type,
>   			.size_in = sizeof(log_type),
>   			.payload_out = payload,
> -			.size_out = mds->payload_size,
> +			.size_out = cxl_mbox->payload_size,
>   			.min_out = struct_size(payload, records, 0),
>   		};
>   
> @@ -1328,6 +1338,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   		       struct cxl_region *cxlr)
>   {
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_mbox_poison_out *po;
>   	struct cxl_mbox_poison_in pi;
>   	int nr_records = 0;
> @@ -1346,7 +1357,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   			.opcode = CXL_MBOX_OP_GET_POISON,
>   			.size_in = sizeof(pi),
>   			.payload_in = &pi,
> -			.size_out = mds->payload_size,
> +			.size_out = cxl_mbox->payload_size,
>   			.payload_out = po,
>   			.min_out = struct_size(po, record, 0),
>   		};
> @@ -1382,7 +1393,9 @@ static void free_poison_buf(void *buf)
>   /* Get Poison List output buffer is protected by mds->poison.lock */
>   static int cxl_poison_alloc_buf(struct cxl_memdev_state *mds)
>   {
> -	mds->poison.list_out = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +
> +	mds->poison.list_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>   	if (!mds->poison.list_out)
>   		return -ENOMEM;
>   
> @@ -1411,6 +1424,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   {
>   	struct cxl_memdev_state *mds;
> +	struct cxl_mailbox *cxl_mbox;
>   
>   	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>   	if (!mds) {
> @@ -1418,7 +1432,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	mutex_init(&mds->mbox_mutex);
> +	cxl_mbox = &mds->cxlds.cxl_mbox;
> +	mutex_init(&cxl_mbox->mbox_mutex);
> +
>   	mutex_init(&mds->event.log_lock);
>   	mds->cxlds.dev = dev;
>   	mds->cxlds.reg_map.host = dev;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..05bb84cb1274 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -58,7 +58,7 @@ static ssize_t payload_max_show(struct device *dev,
>   
>   	if (!mds)
>   		return sysfs_emit(buf, "\n");
> -	return sysfs_emit(buf, "%zu\n", mds->payload_size);
> +	return sysfs_emit(buf, "%zu\n", cxlds->cxl_mbox.payload_size);
>   }
>   static DEVICE_ATTR_RO(payload_max);
>   
> @@ -124,15 +124,16 @@ static ssize_t security_state_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	unsigned long state = mds->security.state;
>   	int rc = 0;
>   
>   	/* sync with latest submission state */
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>   	if (mds->security.sanitize_active)
>   		rc = sysfs_emit(buf, "sanitize\n");
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>   	if (rc)
>   		return rc;
>   
> @@ -829,12 +830,13 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
>   {
>   	struct cxl_memdev_state *mds = fwl->dd_handle;
>   	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   
>   	if (!size)
>   		return FW_UPLOAD_ERR_INVALID_SIZE;
>   
>   	mds->fw.oneshot = struct_size(transfer, data, size) <
> -			    mds->payload_size;
> +			    cxl_mbox->payload_size;
>   
>   	if (cxl_mem_get_fw_info(mds))
>   		return FW_UPLOAD_ERR_HW_ERROR;
> @@ -854,6 +856,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>   {
>   	struct cxl_memdev_state *mds = fwl->dd_handle;
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>   	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>   	struct cxl_mbox_transfer_fw *transfer;
>   	struct cxl_mbox_cmd mbox_cmd;
> @@ -877,7 +880,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>   	 * sizeof(*transfer) is 128.  These constraints imply that @cur_size
>   	 * will always be 128b aligned.
>   	 */
> -	cur_size = min_t(size_t, size, mds->payload_size - sizeof(*transfer));
> +	cur_size = min_t(size_t, size, cxl_mbox->payload_size - sizeof(*transfer));
>   
>   	remaining = size - cur_size;
>   	size_in = struct_size(transfer, data, cur_size);
> @@ -1059,16 +1062,17 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>   static void sanitize_teardown_notifier(void *data)
>   {
>   	struct cxl_memdev_state *mds = data;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct kernfs_node *state;
>   
>   	/*
>   	 * Prevent new irq triggered invocations of the workqueue and
>   	 * flush inflight invocations.
>   	 */
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>   	state = mds->security.sanitize_node;
>   	mds->security.sanitize_node = NULL;
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>   
>   	cancel_delayed_work_sync(&mds->security.poll_dwork);
>   	sysfs_put(state);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index af8169ccdbc0..8f683fe08410 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -8,6 +8,7 @@
>   #include <linux/rcuwait.h>
>   #include <linux/cxl-event.h>
>   #include <linux/node.h>
> +#include <linux/cxl/mailbox.h>
>   #include "cxl.h"
>   
>   /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -105,42 +106,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
>   }
>   
> -/**
> - * struct cxl_mbox_cmd - A command to be submitted to hardware.
> - * @opcode: (input) The command set and command submitted to hardware.
> - * @payload_in: (input) Pointer to the input payload.
> - * @payload_out: (output) Pointer to the output payload. Must be allocated by
> - *		 the caller.
> - * @size_in: (input) Number of bytes to load from @payload_in.
> - * @size_out: (input) Max number of bytes loaded into @payload_out.
> - *            (output) Number of bytes generated by the device. For fixed size
> - *            outputs commands this is always expected to be deterministic. For
> - *            variable sized output commands, it tells the exact number of bytes
> - *            written.
> - * @min_out: (input) internal command output payload size validation
> - * @poll_count: (input) Number of timeouts to attempt.
> - * @poll_interval_ms: (input) Time between mailbox background command polling
> - *                    interval timeouts.
> - * @return_code: (output) Error code returned from hardware.
> - *
> - * This is the primary mechanism used to send commands to the hardware.
> - * All the fields except @payload_* correspond exactly to the fields described in
> - * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
> - * @payload_out are written to, and read from the Command Payload Registers
> - * defined in CXL 2.0 8.2.8.4.8.
> - */
> -struct cxl_mbox_cmd {
> -	u16 opcode;
> -	void *payload_in;
> -	void *payload_out;
> -	size_t size_in;
> -	size_t size_out;
> -	size_t min_out;
> -	int poll_count;
> -	int poll_interval_ms;
> -	u16 return_code;
> -};
> -
>   /*
>    * Per CXL 3.0 Section 8.2.8.4.5.1
>    */
> @@ -438,6 +403,7 @@ struct cxl_dev_state {
>   	struct resource ram_res;
>   	u64 serial;
>   	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
>   };
>   


Being a mailbox an optional capability for Type2, not sure it should be 
here. Maybe it should but as a pointer for dynamically creating the 
struct if needed.


>   /**
> @@ -448,11 +414,8 @@ struct cxl_dev_state {
>    * the functionality related to that like Identify Memory Device and Get
>    * Partition Info
>    * @cxlds: Core driver state common across Type-2 and Type-3 devices
> - * @payload_size: Size of space for payload
> - *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>    * @lsa_size: Size of Label Storage Area
>    *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> - * @mbox_mutex: Mutex to synchronize mailbox access.
>    * @firmware_version: Firmware version for the memory device.
>    * @enabled_cmds: Hardware commands found enabled in CEL.
>    * @exclusive_cmds: Commands that are kernel-internal only
> @@ -470,17 +433,13 @@ struct cxl_dev_state {
>    * @poison: poison driver state info
>    * @security: security driver state info
>    * @fw: firmware upload / activation state
> - * @mbox_wait: RCU wait for mbox send completely
> - * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
>    * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>    * details on capacity parameters.
>    */
>   struct cxl_memdev_state {
>   	struct cxl_dev_state cxlds;
> -	size_t payload_size;
>   	size_t lsa_size;
> -	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>   	char firmware_version[0x10];
>   	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>   	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> @@ -500,10 +459,6 @@ struct cxl_memdev_state {
>   	struct cxl_poison_state poison;
>   	struct cxl_security_state security;
>   	struct cxl_fw_state fw;
> -
> -	struct rcuwait mbox_wait;
> -	int (*mbox_send)(struct cxl_memdev_state *mds,
> -			 struct cxl_mbox_cmd *cmd);
>   };
>   
>   static inline struct cxl_memdev_state *
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e53646e9f2fb..45b184b6ef97 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -124,6 +124,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   	u16 opcode;
>   	struct cxl_dev_id *dev_id = id;
>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
>   	if (!cxl_mbox_background_complete(cxlds))
> @@ -132,13 +133,13 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>   	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>   	if (opcode == CXL_MBOX_OP_SANITIZE) {
> -		mutex_lock(&mds->mbox_mutex);
> +		mutex_lock(&cxl_mbox->mbox_mutex);
>   		if (mds->security.sanitize_node)
>   			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> -		mutex_unlock(&mds->mbox_mutex);
> +		mutex_unlock(&cxl_mbox->mbox_mutex);
>   	} else {
>   		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -		rcuwait_wake_up(&mds->mbox_wait);
> +		rcuwait_wake_up(&cxl_mbox->mbox_wait);
>   	}
>   
>   	return IRQ_HANDLED;
> @@ -152,8 +153,9 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>   	struct cxl_memdev_state *mds =
>   		container_of(work, typeof(*mds), security.poll_dwork.work);
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>   
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>   	if (cxl_mbox_background_complete(cxlds)) {
>   		mds->security.poll_tmo_secs = 0;
>   		if (mds->security.sanitize_node)
> @@ -167,7 +169,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>   		mds->security.poll_tmo_secs = min(15 * 60, timeout);
>   		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>   	}
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>   }
>   
>   /**
> @@ -192,17 +194,20 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>    * not need to coordinate with each other. The driver only uses the primary
>    * mailbox.
>    */
> -static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
> +static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>   				   struct cxl_mbox_cmd *mbox_cmd)
>   {
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_dev_state *cxlds = container_of(cxl_mbox,
> +						   struct cxl_dev_state,
> +						   cxl_mbox);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>   	struct device *dev = cxlds->dev;
>   	u64 cmd_reg, status_reg;
>   	size_t out_len;
>   	int rc;
>   
> -	lockdep_assert_held(&mds->mbox_mutex);
> +	lockdep_assert_held(&cxl_mbox->mbox_mutex);
>   
>   	/*
>   	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> @@ -315,10 +320,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>   
>   		timeout = mbox_cmd->poll_interval_ms;
>   		for (i = 0; i < mbox_cmd->poll_count; i++) {
> -			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
> -				       cxl_mbox_background_complete(cxlds),
> -				       TASK_UNINTERRUPTIBLE,
> -				       msecs_to_jiffies(timeout)) > 0)
> +			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> +						       cxl_mbox_background_complete(cxlds),
> +						       TASK_UNINTERRUPTIBLE,
> +						       msecs_to_jiffies(timeout)) > 0)
>   				break;
>   		}
>   
> @@ -360,7 +365,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>   		 */
>   		size_t n;
>   
> -		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
> +		n = min3(mbox_cmd->size_out, cxl_mbox->payload_size, out_len);
>   		memcpy_fromio(mbox_cmd->payload_out, payload, n);
>   		mbox_cmd->size_out = n;
>   	} else {
> @@ -370,14 +375,14 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>   	return 0;
>   }
>   
> -static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
> +static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>   			     struct cxl_mbox_cmd *cmd)
>   {
>   	int rc;
>   
> -	mutex_lock_io(&mds->mbox_mutex);
> -	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_lock_io(&cxl_mbox->mbox_mutex);
> +	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>   
>   	return rc;
>   }
> @@ -385,6 +390,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>   static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>   {
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>   	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>   	struct device *dev = cxlds->dev;
>   	unsigned long timeout;
> @@ -392,6 +398,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>   	u64 md_status;
>   	u32 ctrl;
>   
> +	cxl_mbox->host = dev;
>   	timeout = jiffies + mbox_ready_timeout * HZ;
>   	do {
>   		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> @@ -417,8 +424,8 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>   		return -ETIMEDOUT;
>   	}
>   
> -	mds->mbox_send = cxl_pci_mbox_send;
> -	mds->payload_size =
> +	cxl_mbox->mbox_send = cxl_pci_mbox_send;
> +	cxl_mbox->payload_size =
>   		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
>   
>   	/*
> @@ -428,16 +435,16 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>   	 * there's no point in going forward. If the size is too large, there's
>   	 * no harm is soft limiting it.
>   	 */
> -	mds->payload_size = min_t(size_t, mds->payload_size, SZ_1M);
> -	if (mds->payload_size < 256) {
> +	cxl_mbox->payload_size = min_t(size_t, cxl_mbox->payload_size, SZ_1M);
> +	if (cxl_mbox->payload_size < 256) {
>   		dev_err(dev, "Mailbox is too small (%zub)",
> -			mds->payload_size);
> +			cxl_mbox->payload_size);
>   		return -ENXIO;
>   	}
>   
> -	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
> +	dev_dbg(dev, "Mailbox payload sized %zu", cxl_mbox->payload_size);
>   
> -	rcuwait_init(&mds->mbox_wait);
> +	rcuwait_init(&cxl_mbox->mbox_wait);
>   	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
>   
>   	/* background command interrupts are optional */
> @@ -578,9 +585,10 @@ static void free_event_buf(void *buf)
>    */
>   static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_get_event_payload *buf;
>   
> -	buf = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	buf = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
>   	mds->event.buf = buf;
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 2ecdaee63021..9f62dc03c883 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -102,13 +102,15 @@ static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
>   				    struct nd_cmd_get_config_size *cmd,
>   				    unsigned int buf_len)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +
>   	if (sizeof(*cmd) > buf_len)
>   		return -EINVAL;
>   
>   	*cmd = (struct nd_cmd_get_config_size){
>   		.config_size = mds->lsa_size,
>   		.max_xfer =
> -			mds->payload_size - sizeof(struct cxl_mbox_set_lsa),
> +			cxl_mbox->payload_size - sizeof(struct cxl_mbox_set_lsa),
>   	};
>   
>   	return 0;
> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
> new file mode 100644
> index 000000000000..654df6175828
> --- /dev/null
> +++ b/include/linux/cxl/mailbox.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024 Intel Corporation. */
> +#ifndef __CXL_MBOX_H__
> +#define __CXL_MBOX_H__
> +
> +#include <linux/auxiliary_bus.h>
> +
> +/**
> + * struct cxl_mbox_cmd - A command to be submitted to hardware.
> + * @opcode: (input) The command set and command submitted to hardware.
> + * @payload_in: (input) Pointer to the input payload.
> + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> + *		 the caller.
> + * @size_in: (input) Number of bytes to load from @payload_in.
> + * @size_out: (input) Max number of bytes loaded into @payload_out.
> + *            (output) Number of bytes generated by the device. For fixed size
> + *            outputs commands this is always expected to be deterministic. For
> + *            variable sized output commands, it tells the exact number of bytes
> + *            written.
> + * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input) Number of timeouts to attempt.
> + * @poll_interval_ms: (input) Time between mailbox background command polling
> + *                    interval timeouts.
> + * @return_code: (output) Error code returned from hardware.
> + *
> + * This is the primary mechanism used to send commands to the hardware.
> + * All the fields except @payload_* correspond exactly to the fields described in
> + * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
> + * @payload_out are written to, and read from the Command Payload Registers
> + * defined in CXL 2.0 8.2.8.4.8.
> + */
> +struct cxl_mbox_cmd {
> +	u16 opcode;
> +	void *payload_in;
> +	void *payload_out;
> +	size_t size_in;
> +	size_t size_out;
> +	size_t min_out;
> +	int poll_count;
> +	int poll_interval_ms;
> +	u16 return_code;
> +};
> +
> +/**
> + * struct cxl_mailbox - context for CXL mailbox operations
> + * @host: device that hosts the mailbox
> + * @adev: auxiliary device for fw-ctl
> + * @payload_size: Size of space for payload
> + *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
> + * @mbox_mutex: mutex protects device mailbox and firmware
> + * @mbox_wait: rcuwait for mailbox
> + * @mbox_send: @dev specific transport for transmitting mailbox commands
> + */
> +struct cxl_mailbox {
> +	struct device *host;
> +	struct auxiliary_device adev; /* For fw-ctl */
> +	size_t payload_size;
> +	struct mutex mbox_mutex; /* lock to protect mailbox context */
> +	struct rcuwait mbox_wait;
> +	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
> +};
> +
> +#endif
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index eaf091a3d331..20d58f883ca2 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -8,6 +8,7 @@
>   #include <linux/delay.h>
>   #include <linux/sizes.h>
>   #include <linux/bits.h>
> +#include <linux/cxl/mailbox.h>
>   #include <asm/unaligned.h>
>   #include <crypto/sha2.h>
>   #include <cxlmem.h>
> @@ -530,6 +531,7 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>   
>   static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>   {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	struct cxl_mbox_get_log *gl = cmd->payload_in;
>   	u32 offset = le32_to_cpu(gl->offset);
>   	u32 length = le32_to_cpu(gl->length);
> @@ -538,7 +540,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>   
>   	if (cmd->size_in < sizeof(*gl))
>   		return -EINVAL;
> -	if (length > mds->payload_size)
> +	if (length > cxl_mbox->payload_size)
>   		return -EINVAL;
>   	if (offset + length > sizeof(mock_cel))
>   		return -EINVAL;
> @@ -613,12 +615,13 @@ void cxl_mockmem_sanitize_work(struct work_struct *work)
>   {
>   	struct cxl_memdev_state *mds =
>   		container_of(work, typeof(*mds), security.poll_dwork.work);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>   	if (mds->security.sanitize_node)
>   		sysfs_notify_dirent(mds->security.sanitize_node);
>   	mds->security.sanitize_active = false;
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>   
>   	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
>   }
> @@ -627,6 +630,7 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>   			 struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_memdev_state *mds = mdata->mds;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>   	int rc = 0;
>   
>   	if (cmd->size_in != 0)
> @@ -644,14 +648,14 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>   		return -ENXIO;
>   	}
>   
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>   	if (schedule_delayed_work(&mds->security.poll_dwork,
>   				  msecs_to_jiffies(mdata->sanitize_timeout))) {
>   		mds->security.sanitize_active = true;
>   		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
>   	} else
>   		rc = -EBUSY;
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>   
>   	return rc;
>   }
> @@ -1330,10 +1334,13 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
>   	return -EINVAL;
>   }
>   
> -static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
> +static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
>   			      struct cxl_mbox_cmd *cmd)
>   {
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_dev_state *cxlds = container_of(cxl_mbox,
> +						   struct cxl_dev_state,
> +						   cxl_mbox);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	struct device *dev = cxlds->dev;
>   	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>   	int rc = -EIO;
> @@ -1457,6 +1464,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	struct cxl_memdev_state *mds;
>   	struct cxl_dev_state *cxlds;
>   	struct cxl_mockmem_data *mdata;
> +	struct cxl_mailbox *cxl_mbox;
>   	int rc;
>   
>   	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
> @@ -1484,9 +1492,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (IS_ERR(mds))
>   		return PTR_ERR(mds);
>   
> +	cxl_mbox = &mds->cxlds.cxl_mbox;
>   	mdata->mds = mds;
> -	mds->mbox_send = cxl_mock_mbox_send;
> -	mds->payload_size = SZ_4K;
> +	cxl_mbox->mbox_send = cxl_mock_mbox_send;
> +	cxl_mbox->payload_size = SZ_4K;
>   	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>   	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>   
