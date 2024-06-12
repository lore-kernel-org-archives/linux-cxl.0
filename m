Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CDB16D337
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176954; cv=fail; b=SfD6L5E37P97usmLgQvuXUmi67yWkyQUE/QWYYXTnImv5pejPzhyPpu84fhJwwuBidumcgSh43nZ2fsBFMjZRlnIwcf+ezVtfobCUi7VSb5di3biYB8EB+M9tv1kIoNZfOfFEFfZ3/QI4B0X3t4D6t0+1FyZWlPmOw4qamf6Vg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176954; c=relaxed/simple;
	bh=0lwQ3o9jXs/PTuvhai04d0C6UcfGPEC1eczhhK9zF8Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRQ0x1O0+gKNPO2YZme+vhzMWu6zSwfC4V3g8PgiO8XBDXXUgW6Exnhddr5moIu8h8UuhgVkcivcud0IEVmoBmIlMnPU+HRsNzTl1TkMS8C+oNECAG6cZYQmRqpHR92QnZ6KLz5QX+RUs+FJTfvrpi+/KOfxkaszgZvzJ2LotP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nghLeNGa; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nghLeNGa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3OZYcx8Gn5zHEEoi+ZGEmggw6H1MC9R8K2GjjZomtAYo3lVpwwGBIwWFJIK8KMTmKW3MAySPL1TbAJBB34X4T080HwWhGDrrNkGj/DFEBQ1/OfLXuYtrzOLtQb+ml8l4WMbWnxo0mwqz/76iQ9gQp+UV48rDkzx6rXKRXC+87g9wNDTocY8Wd+ks690yckcdnKKCmajAHpU9Z8nfKC3WrgrUtk43G+ot1OUCs777+wE9Wg31/zaIRdD9Y9pATBzNqyDED49vfnxWJIi9ws4kLqBfgsbPLKZLOsceKYXtPe/luexUiCgJHTEGmySFr9LkhSzzNNrTEFCwz3659O0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofgrVTkwNzP3mcRuKqpoLaI/vNEMs6tII+PAZ0Mjay4=;
 b=PrmDk2MRY1Wq8NNY4LqN3Nw79qTRbWLI8lAmORlf+bv7EM/KG4cnDyCnVx5Q4xCTKJV+Obdq0hDYeMi5nocELg4pi3tVqwgLhofwt8++SUpKTYzYgnrGYLQKWHe6TaDowX7XFXgrj2ZpLmd2kJy1ljrNo4dPnAw5n4blcqGSfUocGmTuLwNM8bA+apNyN61A04XSdaB71NuaiaouASSQZtCt3H5oiDT8JoErCHY9DL22j3GhlYMrMYs4ODV/UqlVEHNkaFaYNs5mjoAspCMn+eedoE8DTH7epzmSzJbg+tjucl8AqPdPczGXFG9SehoB2vYmDZE2HaxUSgYD37FKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofgrVTkwNzP3mcRuKqpoLaI/vNEMs6tII+PAZ0Mjay4=;
 b=nghLeNGa1CoNYFG/pCBfBSV3ZaFINE0Gr4RPpqK0kAYH1Lzj6mNqfKMqrpbB3JXHXUd11SLCTut/h1tJ6xShiKuHjox3hyJ7eJZB2O+EGjK9/KKqQdBk8TGNbjTSTk+VabtjaIUgDw5HamqRiRvp5YMA0wb04h4Pq5I3FvZBT2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 07:22:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 07:22:30 +0000
Message-ID: <6c692370-1259-4d7b-17d6-e5702b7322a6@amd.com>
Date: Wed, 12 Jun 2024 08:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 07/13] cxl: add functions for exclusive access to
 endpoint port topology
Content-Language: en-US
To: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-8-alucerop@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240516081202.27023-8-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5bf6da-bf11-4207-25e7-08dc8ab06bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXM4U0ZnNVZJZGJTd24rQndnazJreDJyVDRjRTBkejJDUnhFRE5pcDI5TzVq?=
 =?utf-8?B?cEFVZVBtWEc5QTJ6cUhZSmNoSG54UEk0Q2hBMXQ5Vzd4akpVTTkxazZjeG8w?=
 =?utf-8?B?eFA1TTFsb0JYNFQzK2xTMFYySE1xeUtVRjhzL1VjUjdPeXJxSE4zSzREbEVr?=
 =?utf-8?B?K0Nrc1BSWlZVYWF2Nlp0WVUyQ1NHSkl4WkRMYjJkMS90ZGxqTDZqamtXZXhu?=
 =?utf-8?B?c3RKN1k4dnpqS3VTb1h2bHY5a0Q5UVNHZ1dUUWExdXVtZGhlWGNTVmdOWUdo?=
 =?utf-8?B?bk0vN0tBL1E1dWpNeVJKejJUeCtoVmxmREdTdm5QQWdHUm5QSFVpeFl4dEgr?=
 =?utf-8?B?dWxvV1kzeE1wL1BBY0FRb29SZndoczdEZjVQSlpCQTQ1MEhGbk52aFkzZWd3?=
 =?utf-8?B?a1ZXS2xFSnF1dDJtekJoQUI3U0ZhcUw2anNXK1ZGdVpRWE90NTcxNGpKZ3JF?=
 =?utf-8?B?R1kySXlSaHJOZy9RKzczU0dmT0dBTG15WnJ3QVRwNm8vZlIyZmxHK3QvSlhn?=
 =?utf-8?B?RkpTTmVyYUxlN21xS3p4S0tEUWYyU29tTTZSSXhzNzdKVVlMN0hhVERoUFlD?=
 =?utf-8?B?OFkrelN5RGdFTWFxT3ZaajNLaWFUY08xd3BVZWRaU2t0M3BlNUZlM2pIUXBD?=
 =?utf-8?B?dThsZVdxbVpmS3ZVMG4xZFhMQnlGZm5JdVJNYXVrRTlYTXZWSE1JbDdDZEJi?=
 =?utf-8?B?eTRHRWF5eHRYeWE3cGlMMDkxcjRQRkdyWnRXT2doQXJxRVhmWllET0xXdVBl?=
 =?utf-8?B?Zi9GQk92MmhBeFlVazJpU2ZSTmx0cnU2Mk92eDVMNHFHNkErQzZNYVoyTnRr?=
 =?utf-8?B?Z09tS2xwb0pncnUzTnhGajlnSjVEZVhvT2ZSYXZ5SnJaRFJlUHljRytvb2k4?=
 =?utf-8?B?Z2g5b1NMWGNxSDkxQ09aK0VLZHZjOGlmOWl4S3hYaVk2d1NDRGtrUmMxR25B?=
 =?utf-8?B?TmxqeGNjU1R2ZmhsZ2VvN0Z3UnNka1Fma2pWd2ZtRE9EYnd6QVl5MWVVeDJB?=
 =?utf-8?B?Ti8rM044S0swR2pGTnJvdHhlTHQzTUNwQmlQQ1QzY095QkFZZTVFSGt2QlZN?=
 =?utf-8?B?MnVEcE91OVNwM244UFdMRFN2ejFTYU5uS0Zwb3FYNXJVdFNrM2tSdTBzNWw5?=
 =?utf-8?B?VFdWTkFDeld4NlRUVTdVQUFERGc3dlowS0lwM2tKUnpIYUxxVEFPMVIyYkgz?=
 =?utf-8?B?d2JZT1ZEOXMrdzhtczFscndRcTNCclBrRG5wajNITkNMbjRPUStjSGZtdEJa?=
 =?utf-8?B?a3NIbTQrdlZNSHlQVk9iTFZQNmxwSWd0enRwOFlWUVZJNm5ZRGNCaDFzZWdK?=
 =?utf-8?B?cStmOUJmbWpyTTR5cnkxeHUvN0xNMDk4dlFlYVZSdmp3cUx6VWNXNEVZaHY0?=
 =?utf-8?B?VUw5RE5HenZqYkZRZjMwbkRsRVBucFBHaGpTSHg4TEMyMFdCV0VVN2lLcjFR?=
 =?utf-8?B?dzVPOEs5VGJIbTdyM0VBVkgvNFdnTTJMNC9XMVRMeWx6blB0dnB5alJUd2NT?=
 =?utf-8?B?Y0plTGJycjZMWjBQYW9LalBxc05UYlpxNi9ETE5wL3ZVbk9FRnVtNDdvYi9V?=
 =?utf-8?B?ZWlCdnVNVlZIamNUbkY3RWkzbHlEbVFoVzh1RlQwRDNvOUtldzZNVnorQm95?=
 =?utf-8?B?TXVKWU1ibyt2VmNYeEJQZENyKzdrRmMxMUZFb2R1QlhHSUZZWXZGbDRQSzE0?=
 =?utf-8?Q?4AI5YLGbs4aANqzWc6Ci?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FQZit3S0ZpSjNSMDk3RDJscmh2TFQ3WllEeU1DcFhoaHpCeDRNbGpNamdJ?=
 =?utf-8?B?cTdReUIybCtqREJSaHVzejJHVzJHUUllNExaT3ZzbW9mMHRNWUQ1RXM4UUJN?=
 =?utf-8?B?U3d1K2xrM2F6TDUzTy9JRVBjY2hwb0VrdkduNW45eGlpaE93N0hpZ2dWZ2ww?=
 =?utf-8?B?eEIzdDJuV1BNU3ROajN6ZUdDZkNsOUZweTRkcXg1UDcwdVNoREdPR2N3Umpl?=
 =?utf-8?B?R2JrYzAvTEFubll5UzJ3NkVqcS9QVHFKM3B0ZmQyMW5IVEEyQ3hHSVBsSHZs?=
 =?utf-8?B?SzJ0Vm95eWxwK2tMR0EyRkc5WnJSZExwQ2d1WlA4bHhtU2xKaVlLZEFKNHBn?=
 =?utf-8?B?a1l3aFdqZ1hXeHlhNktrL0N6VGhMbTEyeHVkdDlMT3FTdHFxQ0xGMUNEVGZp?=
 =?utf-8?B?T3BlNjNscWFDRCtmVWRoN1NnTHVjRS9DT1Z5M1QzOVljNXdldVorOXpzbTk0?=
 =?utf-8?B?am1DV3NDOTc5ek5rTkNLRWFOdy9Yek1oWkV1ZjRabFQ2Q1NzTHhjaXNyeDZU?=
 =?utf-8?B?VmwrMjJLSlNkSlJpVjA1bWpCOVlaOW9CSXZIL2J6cTdTRFRYR01TKytBUVNz?=
 =?utf-8?B?UEFORHVRRlhiYWNXNkgrZ282eC90b0N0dU1KL2RUNlBlV3RCVk40RXlQcFdY?=
 =?utf-8?B?czBzQjJ1azJ5RmkzRlphWWM1b0lGM0dKd3NDejkrVU15cldHYVY0T09Ya3R1?=
 =?utf-8?B?bmUycWVqajNsYjk1eVRlMXZjMGEycjRXbVFZdkh2eVN3dTVwc29RNDZ2d0NI?=
 =?utf-8?B?NDFWallaeE41cXFPUTByd3drazh1T3BXc25QUUJweXR4NGo1U1pZVW5IRnEr?=
 =?utf-8?B?czkzL2ljUHBzWW9jb2xjckFTNmZ4OU13a05FKzFUWGx0a2tUMFcxenVXSHZ6?=
 =?utf-8?B?STJkU2orUEhpNDl6YklKRDVjOExVSG94aWlyekhUbG9xQ1lOZWphZ296THQr?=
 =?utf-8?B?TTAxMFhpRFRjVm83cUZnZnRaMnhZOXpXa2x4NEdiUWNsYng4d0VQZHBLWktP?=
 =?utf-8?B?UXI1Zm53UU9WL2FWSDE0NUpqMzUwUHB1aDhwTXM4NWUwWm8rS2s5QmZDWll6?=
 =?utf-8?B?R1pjTjY3QzZvbmJIeWZ1Y3psMmlvc3lFV1Z0TWpVblpUb0Y2by9tTm0yT0hv?=
 =?utf-8?B?cDljOUlqaVJIeVpKOElmN0NWazhQbUR6dDJ1blhTWnpnbmROcUNSUkpCWXJZ?=
 =?utf-8?B?ZlZIcEl3MmN3a3dpSDZJUEYvUGZYOHRuWFo4aTBvRFFnZTUvMEtuYUp1aXdo?=
 =?utf-8?B?Zno5eEc5aWJwUWNaM0dUNUQra2g1Q0QvYnhLMERKOEJTYU5Jc014WllMMXp3?=
 =?utf-8?B?bW9sSThDOXZzSzRDNGh6cHg0bStQWDZJeWpxZ2VQVlF1MTJBTGtRUGJaa1JJ?=
 =?utf-8?B?RTRoTzN3c1lIMTVMZVRCTjVmdVpMd1FrbURsNDNPUXBCM0V3RmplcnkveTlu?=
 =?utf-8?B?Sm9vR2dGUEt1VWNqNDJ2T3JqWnpOMjNzcnFhN1A4emJEdzdmc3dDaFNzK0Jo?=
 =?utf-8?B?R1drOE1Sa0ljdTh3TGwxOWZuclg4bVNwenNhUWp0VkN5WHdTVEVLVm1VTnR3?=
 =?utf-8?B?V2sybjU0Unp5NjRLRGRWQUg1dEZmZ2xBdE1INXhYbXV4VjFSdFNwb2tyNEVW?=
 =?utf-8?B?L2RIdWx2aUxXZHI4TnRCMjF3RGhXNEw2cmovZHJjcHBJcEFPVlROU2JhVFlm?=
 =?utf-8?B?U2x1SkRmaUtUY3hJa1BZNEw2R0gzUElJcmc5WnZhWGNPOHBHNkQ5bTlLckMw?=
 =?utf-8?B?c1Y0czFBUmFJTGc5T3FiWVV0U0dCUlM0UnVHYTczaWJPTjJnS2F6b2tNWjlT?=
 =?utf-8?B?V2VGRkF2cUVMRDYzK091TDlrU05reHZkRkUxVkRWNkljYVVZT0x2Y2gyNG96?=
 =?utf-8?B?ay92SmJXV05FS0V2N0RHNXI4ZGdpYkFiaUQyZnBWcUZ6eDQrSEhtSFo1bTl3?=
 =?utf-8?B?Ukp0U1E5TkZVZW1Kb2ZHMXdUNjFkMnJnMXNPM3JJa2pCUGN6WHVBdUFDaW1X?=
 =?utf-8?B?L3diTnZjdUNaS0tDL0VRS2VpZnQ4TEdISkk0dUFMblNiWHpQdXFvQUpUamRw?=
 =?utf-8?B?aHFuS1FpUXZqT0xVcyswL09MNVVGbkFidHA0U3g1aklJMGFxd0dEenZkSkdB?=
 =?utf-8?Q?J20u71Z0XbTjgdOsAR5beybq1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5bf6da-bf11-4207-25e7-08dc8ab06bcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 07:22:30.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgOIVmnbzKAvK4h3A5pzxLBkIe1r7r8S/g5lav6QDVTzjJuK6Xz9/5j4STZbBP3kFPRQ7eLz6OWgQDq/SQM7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475

From: Alejandro Lucero <alucerop@amd.com>

Prevent concurrent access to endpoint port topology.

Based on: https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2

Note: I realize original patch is explaining what the code does while my explanation is ... really poor. I will use original changelog in future versions.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>

On 5/16/24 09:11, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Prevent concurrent access to endpoint port topology.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/memdev.c           | 41 +++++++++++++++++++++++++++++
>   include/linux/cxlmem.h              |  4 +++
>   tools/testing/cxl/type2/pci_type2.c |  9 +++++++
>   3 files changed, 54 insertions(+)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 27063cd4ea73..16e356ef5b6d 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1124,6 +1124,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>   
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver
> +*/
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>   static void sanitize_teardown_notifier(void *data)
>   {
>   	struct cxl_memdev_state *mds = data;
> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
> index e8d12b543db1..11fe8367b046 100644
> --- a/include/linux/cxlmem.h
> +++ b/include/linux/cxlmem.h
> @@ -88,6 +88,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   
>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>   				       struct cxl_dev_state *cxlds);
> +
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> +
>   int devm_cxl_sanitize_setup_notifier(struct device *host,
>   				     struct cxl_memdev *cxlmd);
>   struct cxl_memdev_state;
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> index f157139b712f..948cc95c5780 100644
> --- a/tools/testing/cxl/type2/pci_type2.c
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -6,6 +6,7 @@
>   
>   struct cxl_dev_state *cxlds;
>   struct cxl_memdev *cxlmd;
> +struct cxl_port *endpoint;
>   
>   #define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
>   
> @@ -72,6 +73,14 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> +	endpoint = cxl_acquire_endpoint(cxlmd);
> +	if (IS_ERR(endpoint)) {
> +		dev_dbg(&pci_dev->dev, "cxl_acquire_endpoint failed\n");
> +		return PTR_ERR(endpoint);
> +	}
> +
> +	cxl_release_endpoint(cxlmd, endpoint);
> +
>   	return 0;
>   }
>   
