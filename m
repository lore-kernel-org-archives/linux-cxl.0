Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B000312831
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373910; cv=fail; b=MQQ/R7rXtag3jFCZcjf6fHNDsIZmErwsXH8PFnqoROcGfXuj3iABIw0RavkQ7xhTyFXna7Gk2hkuIgVXm/yv+w9jDbC32eseIJA3gw4G+HP9hQzscb6SeHsGcGnYiPlN/j7ZieJFsfk6oGhKMGV5UwZulMTbJN2S8KnrrhEE3pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373910; c=relaxed/simple;
	bh=sIkUg44SB5mqNiRNxy9fWYAss59KVMTEsthqjtMbPAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fw8gElQDJp8ZnrTYAEQONFtQYcxxz/dDQTgInwm8iUE3jD/7Xn7FOELbqCRSchDEcSVqLmGqYSC5ir6tKAt3AunEK23LpNFf+i31HdbabtfP+SkYg+Wb+hcxYJ/HmboPOvLtF7x5DGVqzFCKBdqY2gw1qAouST5JrtmKnejqr+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l/7koUvL; arc=fail smtp.client-ip=52.101.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l/7koUvL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajIMcOBtrOjPfWKKOdpxPSMVvrxd8+ZcGHkW/u+X8ZEpGjOjf8Zsgwc7T+v80vZ2tMU1FjPIrDIZXhS93Tm/tsvCmL2YXL5r5utNeO2Pdaitr1BTssxyIcY075nPHagKiovg+osMUjNsJaJIGK1Jv8IsG+J1cG+f0bCUs2OkQ8ECSgJJx+xT1u6cGFNU/Kb5oQ1oCvBINcWRoLWP0TrX7yhUugz66VKkYn/nvdLxC55HfA2t5nIHzdF8P1t4FmR/gCEXeC8U/p8v4Mapq0ZNmbONi15gKt4hpPPdxEOAdXb3K4RSQ24kuitmwsalPYWb+bdajgCv5RHluaszmmsU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lw2A9iRfn9k5eiHzcjl76N91rcklxZCVojdxZOhZms=;
 b=bvJWGXYJa76A0rFnMjh3fuIDGPz3wZsNBOuTpw67e4FsIomCThmTFdqYynvgW0oVeDBukAk8dFRaDbbwFl4xApGRDoK2oEvX1WmGwAGrwT7tpzR6/5woOUIAVzXUgdYI1yLLVYbBZDCs4W4QbIPAbOgljSRRzhwO3u3IaAFrlR1aezBs8C6BdQZfm7uFu/236Y7RDJI033AvLxonecQchMgJfQxzb0Y4PkyH6vHJWFZMY87afhSxFXK3Asd79dFTUabRGlZBcXMn1o3Koqj7TJTmq/AHgPICdOGfrl7lL3kP5MPkJKScg46bx5Q8jKpf7PM+lNLxFgBTw65ehlstJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lw2A9iRfn9k5eiHzcjl76N91rcklxZCVojdxZOhZms=;
 b=l/7koUvLgRCT7GjGzGUityhe6px+0wHjaEdgqagrCRUM/qlHLj8swZYby4xobnFn5s6R+z+8XYVJDPJ1hVGnG/0GSx4vBy02Ls6fLcZOpwGwhM9NGwIDLv53tyLryQWjulMXaUj4XGo/g/LzOuNgIonmVWaqBKZvd3nxHxeYWCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 14:31:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 14:31:45 +0000
Message-ID: <9e85d980-4a44-4f27-aa18-8d01630a05e6@amd.com>
Date: Thu, 21 May 2026 15:31:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region
 deletion
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260519210158.1499795-1-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd56d6e-96aa-4159-3d4d-08deb745ae85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	k3U4j5sNNW4P+7Gvs4fhS3IGM0vv02zUGeau2Lxg8PZMGEFDPOtlgWjTcUjtEjSDjLWvzOWRB7YCoPgLk7AjIr2V8ica9y5CCa3s1J+dzv0+WF8fBiTbrDFIJwI5VVjcFtX9ZbYyI7zyDNKy8j6Vcxf+YIZcKAKRq12PBlDTm9PG9PJfgaRXF2PW14W16/3cvEc6dbORrSCK1KD3EX6wfulD31adOBKGV0+bVkYi2E+fH8w8QP2LYO42UIVmMgifd1ZuMicf5rMxBNd98bilGN9nv+WZyxP20D9o56mDcMExSI3WQByL363c709MFwqqK+ZIjsoc09lyzHBGxvYEBSj70+XMHMlmFCtlC1AQP3EiKPBFRN5eRN3LX8M5NlwETMxkj5ssmRgdd8unEZCt14XMeig/sxLuu3Wa0O32EWG0xQEi+X0HMq5zpxMgYiobPdFV3UIPzUaKUn408EKIOSM18EuW6mm2RUXJ3+sngP4A0saFqcnDnHIBnbiem1coC+MA70xmmgA3pld+kKUWp1rgArvsKK/xmu23W1+5RHoY6Yyo8IAG0Pe7dtjjXLITIZevNlCiPp1ql/+94MRJmfNbU5ta32PN7EB9vIR8SISp0f5BhxjNZiVPySiHixcrmJN1f+UfHxln/HhlYhwob7DDNExgTSmH62ztQw2Yh/5m/C5fiiZaLa5kbo1hYSREdSZOflwpF0p5vvwPA9mXTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdnQTIzTWNLYjlCbUpscXhpbWtKQjFhMVh2bjE5djVxbTVBcUI0WmVzVEZq?=
 =?utf-8?B?KzVNc1AvbkpYalE0enI4K0hPc0JjRTh5eVV3M3k2WTNhRHFtZzlJWVRCUlI5?=
 =?utf-8?B?Z2lGZVlzenFGaXdzaFdnK3dLdkVoYm9WSml3VjlyR2lweHhaRFpZQU0vd00v?=
 =?utf-8?B?SDZUZHR5eGRaY3JabzVpeW9hb0lXbkxvSTh1NFFZVnVZMVB6ZmVzcnhTSStG?=
 =?utf-8?B?c2J6K1dqbFBIK2luWjUwZ0VLcnlCWFg4MWZ2OG5VWGMrQWxGUmVKTTZYak1K?=
 =?utf-8?B?NmpmRGE0ZGxSZWxrcG4rd1Bid3V3czBzeWgyUVNUeDRFWXEvYWJMbEc3ekVs?=
 =?utf-8?B?aE1sUjVPaW5rWUhwVDFFY3p5dm13NkxqMEhtMzZEYTd0S3dScGpPS1FSbzhR?=
 =?utf-8?B?YzRxSG5GNEQyT2NOelNlTXcrSEdBVHBnZEJLdVoyd3lQZDExUVpUYnkxanNP?=
 =?utf-8?B?ZjlmQ2R5eGJ3MXM1SGsyZFlGVStvbHBZVHZBY21KN2s1QUcxQ0tRMHpNdmxE?=
 =?utf-8?B?SHRnalM2RzFvck5DRGpibUlLWlNtN2pLSlRsaEhIVWt1M2M2UkIxZlE0REpH?=
 =?utf-8?B?Qkw0NW5JN1N1TVBXVHN6Q2JpSWNSQUhCUFpHWmVweXhsUExWZGdPcHdPSTBE?=
 =?utf-8?B?UGhicEl4ckExWFh6VWN0MStNd0dNZWxuR2JmallEaXRxeDMzYWdoU2txaTZB?=
 =?utf-8?B?QjdOUlllTGxxV3phc3pZbWJXMXJXRXk3YzZuSW1oN21EZCtnSDNlWk8rWFpP?=
 =?utf-8?B?eDVDdDh0MGhXSnNvdTBVQzc5SE5aYzgrTkRWUFBLbVo3MU85ZjhCb0lHemg5?=
 =?utf-8?B?d01kMjVyUWIwVndIejFVa1I1bnhhaUlvT3hEaEtNclN6TkdvWVFrWmRtc0RH?=
 =?utf-8?B?SjRiQVUrdktPWWJXMkUvUFhnV3g2SmVJM3M3VXlUUkZKenRud1pXS1I5VDh0?=
 =?utf-8?B?T29KRmtCdjd4ZEdPOFUxV3IrbDQ5a1BRUTJ1M3paSWRnelA4dnpZOWJReUtt?=
 =?utf-8?B?d3cxdzh3aXlhQ3MrNk9UTWFqWXJ2WHBxdjNMQkRvSVdtQzI1Uytob3RTbmNY?=
 =?utf-8?B?elNjdEdQZ1JXM05VWnhWcG5FTjU3RzkwTCtVaTg0cFBHRHEzOHVRaE54U041?=
 =?utf-8?B?UmdwZXc0aGk1azR3NjhkWitPZXhwZXJabnM2UUI5cTFFMGxxNzRIaElRVkVP?=
 =?utf-8?B?RkZhUVMzajlTeldnbnExZWVKTGlBcThVUUJGTS9pS2JhN2l6Yk94cGRET0wz?=
 =?utf-8?B?ZktCRGVHYWZmVHgrQndKT0JiWEk4YkxjRkZ6b3pWVGFYaXc0UzBoTWFSRGFP?=
 =?utf-8?B?akt4SEk2Wk0vWDhZV1IyTUYwTjlXMU5abVJRZjBIQ051Wlp3UnozdFFNemc1?=
 =?utf-8?B?ajVDZmhwRmEwbVJ4THNjbVFneFZmU0c0SVpQa0N3TTlnbm9zOVVuTHY2K0Nx?=
 =?utf-8?B?ekg2TUpYSEpUdmh0NnVBdTRKejdPdEpRSDg1U1pWY2syUnlkZnJqbnFHSmIx?=
 =?utf-8?B?b1ZCcFdhZWV1RXpBWndGYWpEK0E3K1lBMWh0NzdJYzdKQ0piNUtOY2VEeUJw?=
 =?utf-8?B?SEpvckk4Qkx0ODFJanR5MEg1YkZyMGM2OUZYUk0rbGZBdHlqbUgrRmxGeW1G?=
 =?utf-8?B?bzlHOEFSN1ZyRnRJUXNRQ0xuS2RnMWNlMDVFblB3QXJISmdIdmZUQXF2akg5?=
 =?utf-8?B?RWl3UkcwdEtMVkNWb2xlU0xzeFh1QVJ2QXlJWFZqTXY0TGNWVllqa1lDSWx4?=
 =?utf-8?B?ZkxCRU5tZGtnNHR3bGhDUUs4NGR4dHdzTm1sQjd1dUYyb2R6S0JGV2ordkpt?=
 =?utf-8?B?NGNXRmdUOU9jaVR1VlFpYkJibFBOckptL0t5UlpQb1plYnhxMEl0aFdRWm1U?=
 =?utf-8?B?VnZ4RmQ0U0ttbjJ6TVFaM1NoM0hhNlBHZ2hBZHRrWHFJSmdtL25MMGNsQUhC?=
 =?utf-8?B?N09PZGpGbEhSai9PUXEreG9EV0dmVk83K0ora3F1Rjh0aThXbXNtUTRSbE9l?=
 =?utf-8?B?Wk5rUFdTb1VQM2x6eDdtR1FFNEdPeE14UnNKcXUwdzVFVjR0NUtSc3FvSk00?=
 =?utf-8?B?VTlMeHoyT2ZYbTV1T2YrNmpwQWN2Sy9aTTJPN2Vac21ka0VLNWlaZDlNL0pT?=
 =?utf-8?B?WVlLWDRGS1BNU1h4K3NXVVViT3dvUGlTNjhlT2ZSSWZtY1JrQThjUzV0QXlW?=
 =?utf-8?B?czVCR1dBSUxJSDZ3NEZ4VFR2TzdQL3lFMHNzMVliZXJMeG9xaWJLa2RwYjBS?=
 =?utf-8?B?ak1HM3MrekxMVEpBZHNNM0hkTGhDL2FWNU5ZU05IRlhjb3ZEYjNBM2RUQ0NN?=
 =?utf-8?B?TXQySXZGQ3ZlSnQyb0xjcmhKNlZXc3l1Nnh3QnhyWFBLLzNRK2U3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd56d6e-96aa-4159-3d4d-08deb745ae85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:31:45.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euCAhj7E8dHmr4xHHZdlj9J6LNUdrwalaUyoTIUEZXP+r2Au5OEhekIgqt+rS0o9DH2rjYBFUp12HLKrTF9E3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789

Hi Dan,

On 5/19/26 22:01, Dan Williams wrote:
> The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
> HPA range for the device. At present the retrieved region information is
> expected to be established by platform firmware. A future update will
> auto-establish a region if one is not already present. This arranges for a
> simple CXL topology detach == Accelerator driver detach scheme.


I have successfully  tested this with sfc and it indeed simplifies the 
accelerator driver. Removing cxl_acpi or unbinding the related memdev 
works as expected removing the sfc driver as well.


I'm quite happy with this approach and I hope this is the last building 
block for the simplified (only with autodiscovered regions) type2 series.


Just a minor comment in patch 5 and a suggestion for maybe changing the 
devm_cxl_probe_mem interface call.


Cheers




> Now, automatic region establishment on behalf of an accelerator driver
> also requires automatic region teardown. The existing scheme of
> triggering devm_release_action() of a cxl root device to destroy a
> region is racy [1].  There is no path to coordinate multiple devres
> actions, or conflicting devres actions, without using the
> devm_remove_action_nowarn() workaround.
>
> Instead, move final region cleanup responsibility to the root decoder
> teardown path (devres action cxld_unregister()). Expand the root decoder
> @range_lock, renamed @regions_lock, to coordinate region creation, sysfs
> manageability, and deletion. The @regions_lock also prevents regions
> from disappearing mid-auto-assembly.
>
> Changes from the initial RFC [2]:
> * tested with Dave's type2 cxl_test
> * fix region remove by endpoints (Dave, Alejandro)
> * fix user triggered region remove (Sungwoo)
> * fix lifetime of the @attach ops (Alison, sashiko)
> * hide @attach details inside the CXL core
>
> [1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
> [2]: http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com
>
> Dan Williams (5):
>    cxl/region: Block region delete during region creation
>    cxl/region: Resolve region deletion races
>    cxl/memdev: Pin parents for entire memdev lifetime
>    cxl/memdev: Introduce cxl_class_memdev_type
>    cxl/region: Introduce devm_cxl_probe_mem()
>
>   drivers/cxl/core/core.h      |   2 +
>   drivers/cxl/cxl.h            |   8 +-
>   drivers/cxl/cxlmem.h         |  27 +++--
>   include/cxl/cxl.h            |   3 +
>   drivers/cxl/core/memdev.c    |  20 +++-
>   drivers/cxl/core/port.c      |   7 +-
>   drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
>   drivers/cxl/mem.c            |  95 +++++++++++++----
>   drivers/cxl/pci.c            |   2 +-
>   tools/testing/cxl/test/mem.c |   2 +-
>   10 files changed, 297 insertions(+), 63 deletions(-)
>
>
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
