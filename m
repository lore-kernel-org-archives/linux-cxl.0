Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C301E3775
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288740; cv=fail; b=TMw7Ln1oHIT13YTNIhQis1ww3ORgqE5TiF9FX7p9gxepHxN/EKmXoMcL8E24qCv78StEbTe82DDAHXH5PIor5KIk4xs/0TNXX5AUwRiTo3c8eqkb0W9KoYt/A51/gRZpOpRZF5Oam8HDMZjOXg3pTPHZLNfh+XSH895+HxGL2rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288740; c=relaxed/simple;
	bh=orXoDZ/+LFDU63QeNGZD0xl6XKbZG9Rnt4q6VcehU0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RwRqTSM/IzL1f+VV9aj5kn6t4q5DIAPJPdcdhTs3G0GyxIAc/NPUtMR/PaeJCWP9gMThSX9Y6g7ZwhqdU+CUF+6TTX8olSArtDCVUYjMAEb4Q2dSxQgaH5EtNe/9601122uK5E3elqL5UZ+AkDPYuPlwIjGg0xGCNcVgBtj20QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mR5tgVgJ; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mR5tgVgJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4cUiUOJZ7BtIBJj8+CBmZX0ElP6dKlB83R6H0X0jJAk7Ya1ew0p/ae0ndPMkIK+dIB0DL/vD5g3YcBHDQiw/DTEz9JJkYohRaCkF8PaM7hNoGadS6fCEWm3B5uKy6UDXSVHwurpXEkWad23I1F4udiIiCvBIopDH7sTn4llKPTsteG95AVq8giYd/KvfuyCdcFoZR6xiNAbgjRDN1o+naqsEKA1h0jr/dnHxIvz/xHR9KRhdy/G8tDJ0mrTZ+qWaKilBpdPuD5KlKzBo1RkpFjbn+8+MASRM8reb1YrVmLp2H1MsrHZV8RF3YiWQHWUDv4QZOOvZNj2zxDIpyGpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh8RYqlAYYIwt7rkTNYT7hE2W3dhES15LZAomuXQ++0=;
 b=s4/7AYkjRLiVrBuX7MgFUe2q2BM8tkIPxQoOZPU/2+jHhw3jrLjHpJcq1oGyhhTyseP+2zOvguX2zVaGSqPbaMdxw7/S+lwM4dQpBkgJaGu7ccd1lZVIxdgvZ0i5HBpaz8xLxLk05JNZxh1nV99g/9jLJcQMuV5lXDkRmuhtjAimTjW6RLbKPG6jfIu7k1nZyGXcJ0WGj0w6CfCL7G3uTv4OR1tNfkWhA2FTy8IYnGV1MUV/6wJQUZ2RcCTaroRSdqMJ+qM6eHbvvVlBUVsxgfGizMvFyRnpeAwWBlG1xoHSwFkPiVLMTwncnrX016Cb71GVGYfHJ6tBd9bIdRw6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh8RYqlAYYIwt7rkTNYT7hE2W3dhES15LZAomuXQ++0=;
 b=mR5tgVgJs6fe9nb7TKPEne1f3ml4+NK78yfoOlyfza97JAVtd1d0lRf/pnAOKXimkc6cUcp57E6kMlyRCf74mRoqu/H5IL1OJLWXl3fmfzLbmgR6Ttl+gPwfp8ye82o4Q3tLn9jq8PG2ZQdvGU3aQgMyhpTuInP8SJf8zN2q1wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Wed, 23 Jul
 2025 16:38:55 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Wed, 23 Jul 2025
 16:38:53 +0000
Message-ID: <400534e9-7763-4364-afb3-5ab9d11cde1c@amd.com>
Date: Wed, 23 Jul 2025 11:38:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
 <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
 <f1ddcc99-56d1-4887-ad91-714d59b9e9a3@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <f1ddcc99-56d1-4887-ad91-714d59b9e9a3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: f634da78-fb3a-420f-66ba-08ddca0765aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUFlRTR3ZTkxWVhpMnBCMWd6TEU3b0ROeUZNclJZWGN1UjZLMDlnOVBaNmR4?=
 =?utf-8?B?SkM2TkEvZVZ4aHY5UUhwY090V25ld2d4d0dvamFtZzNWcDh4clpVREcrUWkr?=
 =?utf-8?B?NEk4U2dOZjZZZllqQXlUM1YyRGh6QW1JK0NOL0tnUkxOUmwrcGJxWTRlTWJy?=
 =?utf-8?B?Um1KMVlpdDh6eTRTamhMNGVrSU9KMVBURW1yRHcxVVhkK0RleXB3UW1HWGtG?=
 =?utf-8?B?ZDhxMlo2MzhMU1VrVmcrTTV2VitJbTM3S1NCVFg1aUh6SVNla0VNbUVhVmp5?=
 =?utf-8?B?KzFpQitEU0RCSDBjdTZNd2RxSlNCVTgvbFFzblVjemlPUTZKME4zMU1TdDcw?=
 =?utf-8?B?YWxob0NoelI4TlZ6Y1hXaDYrUFRVc0h6N1d6bDBEekh1VDB5QlNONklrMUw3?=
 =?utf-8?B?S293Qk9pdHNTalVQYmV4NksrTzdzRW1jbXo2aWowQzFpNlZRV3hiRnAydFpX?=
 =?utf-8?B?Y0x5Mk90TXVWVHM1YTVWR3R3bU1jbjNwc0ZvYUdFemlOWWJYdm42M0Ric0Fu?=
 =?utf-8?B?R1VuSTRNTHYwWi9URVk1QjlyVVdnS2J2TWtYdEs0TnFrZnZRa1BmTXdXMVB6?=
 =?utf-8?B?eENzVWJmV05RVjE0N1ZsVzMxMFppVWtpNHpjUFlhN0ZPVFV5OG8xejNmQVM0?=
 =?utf-8?B?NkFKTUNpSzFzRVBYM3dzUXkySDNwZlZmazRtK0ZVWnVLdmJiU3dvUTNPS0Q4?=
 =?utf-8?B?WnlGa2h1Y0V0T1c1Q2NWUmxzdnNsQXd0WWJnSm5mYWpzeHhmWks1YWVNNDJ0?=
 =?utf-8?B?YXFHYndlYUZnWDVhcG9oNkpGR2ljZFQrejdqclIrWVpEWHNranNod2ROZ1F3?=
 =?utf-8?B?RFV6Smw2UDBmTnVNL0gxSFlEK3ZDalVaTS9Vdms4eVdmWHQxWEorQ3RnaS9V?=
 =?utf-8?B?bTRscnhCUldyN2poQWFzZStHckQ1ZTFTOUVRZVBmeTU4eTVJRUZ1K1VVY09Z?=
 =?utf-8?B?YkZwQ1NlSUxNeU1ZZXQ5MmZTR3c4MEJuN1ZhdFQ0VHRLeVJYWWE3MklySWU2?=
 =?utf-8?B?UE9KbXVYWmRRbmxlT043UURGZTFFN2s0amtBdmxjTGFOdHJuazd0TFp3WTh2?=
 =?utf-8?B?SDhKNWJtUnNCZWh1bkp0Q1JRU1lsRHA2eGptRGxEQUoyTmdla053WWtXRXNP?=
 =?utf-8?B?YUxoMkFJc1FzTEp2RHRodHMvR0Q0bHFoaWFOeTlHTkZ1L3hoY2JVN0RTNmdM?=
 =?utf-8?B?ZUxYdHkyazNGQm1BRGJYeWwwMWw5WlZpeCt2N1ROM1pkdXowa0NFcG1XaXY5?=
 =?utf-8?B?bHpaaXZoaUc0TDhQamQxeXJHQ0loMHdkczNCcHh4RGRWaG5TN2djZ2xIbnRa?=
 =?utf-8?B?MXJ6bDFDbHIvaW1sMkVzYUxndFZEeTBRdzJrbmxvR3I0SDJKNm9NUGhERm0y?=
 =?utf-8?B?SjF1Zk9tQWRMeDFOSnBUdVdFRzY3OW4yWGI3dms3MW56OGpVUVZKenRIYmxt?=
 =?utf-8?B?djBlT1Y4RWE4bjNqUEhTMndYOVl0dlFXdkIxYStQNmRyenAvcEtVczZ0YnRE?=
 =?utf-8?B?UHlBSS9iRGU3eEFldCtrbkZkYTcycFJhL2VrZXg2aDRZNjh1U0xHU2JIbjlW?=
 =?utf-8?B?ZDRBaGdvbjdYUWhMTktuSnVhbHUzZFJUVXhiVFV1ajdIdU9UcVJlVHZEME9U?=
 =?utf-8?B?TFdFWjRVSzZ0OWY4bHNFVGRieXFsK2FvRTVWTnFKemUyY0s2enlod2NVU09S?=
 =?utf-8?B?N2lHajNIVzN3Smk0T2phQ3JOTnVuTUF5MEV2VWhlaGpJeEhoTCtLd0VBKzlw?=
 =?utf-8?B?UE5YcVBYdVkwZjg2VXJGcUhtWTdsL1RUSzNTQ2xpTnJMOTZDb0RSZFRtVzdI?=
 =?utf-8?B?UzNMQ2hlT3F4VmpLcGxtOC81VkYxeUtjNDJVK281SFNEVGxSMFVmRWxXTmFo?=
 =?utf-8?B?SXorQmYvYTJYVC9uNU5adlNwNEVkNjJzNWJ6T2o0U3daZDEwNmZ1TUJvODZh?=
 =?utf-8?Q?R3vx6RhbvgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXpVaDlxUnN5UVFKNVQ5dGN4TXlKcjJiUVovVGwvOVZPczR3cVFXM2tEYzVG?=
 =?utf-8?B?Uk1xRUIzMldYMWtKTmF2d0FkNHozY1hWeWJJKzdnR1JPTGN0bUM3S2t0UExq?=
 =?utf-8?B?WEhJUmZKR0tWVWRXQ09JcnpvbThlVkNSSUZWQmZwTkZWOVo5MlI3cUpxaDht?=
 =?utf-8?B?dEVHUmo4Z3k2aGVNMzF2emlyVnQyMElVQXUxUkdCd001WjIwNmJiaEg2WDdY?=
 =?utf-8?B?cnptNzNua2E4NkNqVDJGUHgwQnhMdlhQOUpBVkovclFHTER5Rml1WnhjSUJh?=
 =?utf-8?B?QkhzY2J2SS9uVTFRcUpQODNJYTlndnROSm02S1BMcWtQa1AyN1hTUGhvVVUr?=
 =?utf-8?B?Tmc3VDBVTXpvVG5XNmRsL3lsbVZpT0RkV2FsV0orSkVMSUswZWJTYnArZHkx?=
 =?utf-8?B?WE1tczFhWGZkamVVU2VYa0pVc2dWN3R1elNWMnNWUG45K09KbllmTTkrWHlI?=
 =?utf-8?B?SGVZcFB4Lzc4VERSWUMrdXhXZGx2bFFDamxwNXFXdU0wVnR3eENFN0JGd3B1?=
 =?utf-8?B?TzVMQm0ybXJCdSttdWExNWpzMUVZUzZFVk1ZQjhGeXNPZ0ZITC9oN0RGL3Ru?=
 =?utf-8?B?eUVlRmZlSyt6Z1JzZ2lORUMyMkEzKzRmZVh5ZnBjczViWmNielNaSEwrOFlq?=
 =?utf-8?B?U24xYVBobklib1pna0lkNkdwTHI5UVdGdElUOXFyR2IwYi84K0VKSzcwYWc3?=
 =?utf-8?B?dThUYW9sS2o5YTFZZ1ZkdmhSSk5nQXRNNCtpMTJLV2NmWnR3SlB2Zk9GZmlj?=
 =?utf-8?B?VStyMjQ3T1oxdzhQUWVMaHV3OXdYMHU5aEhBeXBwQ2VjYlBSTlQxWUhLYm9G?=
 =?utf-8?B?ZkU0MDJwTG51bWpQWHpVNy9qaG50VEQ3dTJvMHErNmRGanBrKzIrcjFJUDh6?=
 =?utf-8?B?MzcyNlhWZ1l2RERLelN6QzRQVWtsMko5cWVVL1ZYVHNFd2pYaTlWQ0xRT3l2?=
 =?utf-8?B?RWgwd1VtQllVOGgyT0J5MWFoN1NaTzZHeGFuNE40dUUwWml2NWNTUjlrVFdu?=
 =?utf-8?B?L2pFT091NzNwMGhDQ3dhZ0tTNTB0a0thc3BLWVUvU2JTbXVsOWMwK2pzem95?=
 =?utf-8?B?d0NYTjI0TUVSYXRQOXJWTndSS052bkl0dHVuaGF2dFErMW5iZk03YWsxVWxV?=
 =?utf-8?B?U09PYlZaT0FTT09xUFdkMFpuTEJ6WURxenVZaHg2NUVMN2ZBSUhtdDlMdHVp?=
 =?utf-8?B?akVIMzZWNjlSVm1DTm1rVFB0NjZEK1g4b1VQSUtDeEhFdEJjTzUzRmk5UUdq?=
 =?utf-8?B?Wm15MVVyQWFiYk1YQVRuUkNETmFZcTZpbzRpYlk0d0l6ZVd5ZlFrRk5LTG1y?=
 =?utf-8?B?UDMrejRuSmhuSTVKd0hvVlhWbDc0eDQzYmVTQXg3Q1A3akxvaWxPRExGMlVY?=
 =?utf-8?B?WHgvZVo2eGl4dVdJRzBNNmFEYUZ1cVJDTkpFWmN0cTFQYWdXdzNYYS9qeHVM?=
 =?utf-8?B?NzhLT0ZIMjl0TXVVMkVvWVZTT0FaOTEvdUFaSGV0R1Qwa0NWVU5XR3doZ3pE?=
 =?utf-8?B?NzNKNkxGOGdzTlVNNGYyN2ZUV0RtdWZQTERObThXREs2WGtDc05HR1BqS2hC?=
 =?utf-8?B?aXU4UUVINEVGcGhyaksvT2Y2Uytaa3V6T1N0eTZ0aGxnekhXcEo0anpNWWk5?=
 =?utf-8?B?cytYMHJSbWtaZjBOVG40KzVxVVpQWEdBRExHTWtyNlZFSU9CWnZyUFhjS0Nn?=
 =?utf-8?B?Tkh0TkVtdUJYMkNMQ2dCVlZRWFRpejh0Z21iOG1Nby9yTzUzblNlNzdMVzk3?=
 =?utf-8?B?dEVqM05hamFFdzdjOEt6Z0ROUUV4cEs1Tm5waVZVSHJIazhCSTI4SVF3MjEw?=
 =?utf-8?B?Zy9HbGxKdXh6YWo4VDVGM1VENlRZTGlGMWF6RVo0VGJPVjM1aGoxMTJGczN6?=
 =?utf-8?B?U3krL05NK2tHRXI3K1hBRm44bzBMOFRuYnJhMDB3NUowRXJ1L3UxWGJneHp4?=
 =?utf-8?B?dHUvNDcwYXVCeGJEeUdqUDRPbjdiTmxOWHFSOUFFYzNGL09aUEc5b2dxM1NO?=
 =?utf-8?B?THpMSXRGYVkxTkJObTRaWVhJa1djM3J4b0pBMTQxcitXWkZKQjRVbkRGUGMz?=
 =?utf-8?B?ZCtSMXV6VFpXWEk4QUx4ZHQwaGV1N2RLYkttdC96T3JsRXJRM1JtRFlobWxM?=
 =?utf-8?Q?czJk6grR3a8F0nCNjAZPTs5BX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f634da78-fb3a-420f-66ba-08ddca0765aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:38:53.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xaKYO8iGGUZfm80F69Tn8NZX+6SGPwi0JlLfD2RlUHmKClWDkTbwTPfYWZDGBpCXdp47yhzOMGxnTgbYv9FlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

On 7/23/2025 10:14 AM, Dave Jiang wrote:
> 
> 
> On 7/23/25 7:55 AM, Bowman, Terry wrote:
>> On 7/21/2025 12:04 PM, Dave Jiang wrote:
>>> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
>>> cxlpci.h to deal with the exported symbols as needed. There is enough
>>> AER handling code (and more to come) to move the AER code to its own
>>> C file.
>>>
>>> Cc: Robert Richter <rrichter@amd.com>
>>> Cc: Terry Bowman <terry.bowman@amd.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>> v2:
>>> - Address 0-day reprot of cxl_handle_rdport_errors symbol undefined
>>> ---
>>>  drivers/cxl/core/Makefile  |   1 +
>>>  drivers/cxl/core/core.h    |   9 ++
>>>  drivers/cxl/core/pci.c     | 171 +------------------------------------
>>>  drivers/cxl/core/pci_aer.c | 168 ++++++++++++++++++++++++++++++++++++
>>>  drivers/cxl/cxl.h          |   8 --
>>>  drivers/cxl/cxlpci.h       |   8 ++
>>>  tools/testing/cxl/Kbuild   |   1 +
>>>  7 files changed, 189 insertions(+), 177 deletions(-)
>>>  create mode 100644 drivers/cxl/core/pci_aer.c
>>>
>>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>>> index 79e2ef81fde8..bcea856157af 100644
>>> --- a/drivers/cxl/core/Makefile
>>> +++ b/drivers/cxl/core/Makefile
>>> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>>> +cxl_core-$(CONFIG_PCIEAER_CXL) += pci_aer.o
>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>> index 29b61828a847..96c319c66a48 100644
>>> --- a/drivers/cxl/core/core.h
>>> +++ b/drivers/cxl/core/core.h
>>> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>>  		    u16 *return_code);
>>>  #endif
>>>  
>>> +#ifdef CONFIG_PCIEAER_CXL
>>> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>>> +#else
>>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
>>> +#endif
>>> +
>>> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>>> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>>> +
>>>  #endif /* __CXL_CORE_H__ */
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index b50551601c2e..bd78369bc3f4 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -664,8 +664,7 @@ void read_cdat_data(struct cxl_port *port)
>>>  }
>>>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>>  
>>> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>>> -				 void __iomem *ras_base)
>>> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>>  {
>>>  	void __iomem *addr;
>>>  	u32 status;
>>> @@ -707,8 +706,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>>   * Log the state of the RAS status registers and prepare them to log the
>>>   * next error status. Return 1 if reset needed.
>>>   */
>>> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>>> -				  void __iomem *ras_base)
>>> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>>  {
>>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>>  	void __iomem *addr;
>>> @@ -746,171 +744,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>>  	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
>>>  }
>>>  
>>> -#ifdef CONFIG_PCIEAER_CXL
>>> -
>>> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>> -{
>>> -	resource_size_t aer_phys;
>>> -	struct device *host;
>>> -	u16 aer_cap;
>>> -
>>> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>>> -	if (aer_cap) {
>>> -		host = dport->reg_map.host;
>>> -		aer_phys = aer_cap + dport->rcrb.base;
>>> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>>> -						sizeof(struct aer_capability_regs));
>>> -	}
>>> -}
>>> -
>>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>>> -{
>>> -	struct cxl_register_map *map = &dport->reg_map;
>>> -	struct device *dev = dport->dport_dev;
>>> -
>>> -	if (!map->component_map.ras.valid)
>>> -		dev_dbg(dev, "RAS registers not found\n");
>>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> -}
>>> -
>>> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>> -{
>>> -	void __iomem *aer_base = dport->regs.dport_aer;
>>> -	u32 aer_cmd_mask, aer_cmd;
>>> -
>>> -	if (!aer_base)
>>> -		return;
>>> -
>>> -	/*
>>> -	 * Disable RCH root port command interrupts.
>>> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>>> -	 *
>>> -	 * This sequence may not be necessary. CXL spec states disabling
>>> -	 * the root cmd register's interrupts is required. But, PCI spec
>>> -	 * shows these are disabled by default on reset.
>>> -	 */
>>> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>>> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>>> -			PCI_ERR_ROOT_CMD_FATAL_EN);
>>> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>>> -	aer_cmd &= ~aer_cmd_mask;
>>> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>> -}
>>> -
>>> -/**
>>> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>> - * @dport: the cxl_dport that needs to be initialized
>>> - * @host: host device for devm operations
>>> - */
>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>> -{
>>> -	dport->reg_map.host = host;
>>> -	cxl_dport_map_ras(dport);
>>> -
>>> -	if (dport->rch) {
>>> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>>> -
>>> -		if (!host_bridge->native_aer)
>>> -			return;
>>> -
>>> -		cxl_dport_map_rch_aer(dport);
>>> -		cxl_disable_rch_root_ints(dport);
>>> -	}
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>> -
>>> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>>> -					  struct cxl_dport *dport)
>>> -{
>>> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>> -}
>>> -
>>> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>> -				       struct cxl_dport *dport)
>>> -{
>>> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
>>> -}
>>> -
>>> -/*
>>> - * Copy the AER capability registers using 32 bit read accesses.
>>> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> - * status after copying.
>>> - *
>>> - * @aer_base: base address of AER capability block in RCRB
>>> - * @aer_regs: destination for copying AER capability
>>> - */
>>> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> -				 struct aer_capability_regs *aer_regs)
>>> -{
>>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> -	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> -	int n;
>>> -
>>> -	if (!aer_base)
>>> -		return false;
>>> -
>>> -	/* Use readl() to guarantee 32-bit accesses */
>>> -	for (n = 0; n < read_cnt; n++)
>>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> -
>>> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> -
>>> -	return true;
>>> -}
>>> -
>>> -/* Get AER severity. Return false if there is no error. */
>>> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> -				     int *severity)
>>> -{
>>> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> -			*severity = AER_FATAL;
>>> -		else
>>> -			*severity = AER_NONFATAL;
>>> -		return true;
>>> -	}
>>> -
>>> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> -		*severity = AER_CORRECTABLE;
>>> -		return true;
>>> -	}
>>> -
>>> -	return false;
>>> -}
>>> -
>>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>> -{
>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> -	struct aer_capability_regs aer_regs;
>>> -	struct cxl_dport *dport;
>>> -	int severity;
>>> -
>>> -	struct cxl_port *port __free(put_cxl_port) =
>>> -		cxl_pci_find_port(pdev, &dport);
>>> -	if (!port)
>>> -		return;
>>> -
>>> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>> -		return;
>>> -
>>> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>> -		return;
>>> -
>>> -	pci_print_aer(pdev, severity, &aer_regs);
>>> -
>>> -	if (severity == AER_CORRECTABLE)
>>> -		cxl_handle_rdport_cor_ras(cxlds, dport);
>>> -	else
>>> -		cxl_handle_rdport_ras(cxlds, dport);
>>> -}
>>> -
>>> -#else
>>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>> -#endif
>>> -
>>>  void cxl_cor_error_detected(struct pci_dev *pdev)
>>>  {
>>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> diff --git a/drivers/cxl/core/pci_aer.c b/drivers/cxl/core/pci_aer.c
>>> new file mode 100644
>>> index 000000000000..cf1e9377752e
>>> --- /dev/null
>>> +++ b/drivers/cxl/core/pci_aer.c
>>
>>
>>
>> Hi Dave,
>>
>> While adding this into my series and looking closer, I believe that pci_aer.c filename does not accurately reflect its content. 
>> The only AER-related code pertains to CX1.1, which is now a corner case. The AER driver, not CXL driver, logs AER errors for 
>> all other scenarios. There is no AER processing in the CXL driver except for CXL1.1 dports.
>>
>> Most of the code in this file is related to or will be directed towards CXL RAS. It's important to note that AER and 
>> RAS are distinct and separate registers, with CXL RAS only utilizing the AER interrupt notification and UIE/CIE. 
>>
>> I am concerned we are conflating AER and RAS, which may be misleading for others. We have other instances of this 
>> confusion, such as in the cxl_aer_correctable_error() and cxl_aer_uncorrectable_error() functions, which log RAS instead of AER.
>>
>> My series aims to clarify the distinction between AER and CXL errors, categorizing CXL errors as a separate error class. 
>> At the least, can we add a documentation block at the top to indicate this source file provides functionality for 
>> CXL RAS?
> 
> Sure we can do that. Also, we have a core/ras.c already. Any suggestions on how do we want improve this? Move things to ras.c? Rename cxl_aer.c to something else? Rename current ras.c to something else?
> 
>>

I don't think we want to combine the os-first and fw-first code in a single file. The separation leveraging the 
Makefile conditional compile is good because fw-first doesn't use PCIEAER_CXL while os-first does.
I think core/ras.c is good as-is.

cxl_aer.c is in the drivers/pci/pcie directory and is logically part of the AER service driver. This file includes the 
kfifo and logic for offloading CXL RAS errors to the CXL driver. I think the cxl_aer.c naming is fine but 
understand it could be argued to use cxl_ras.c instead. My concern was in the CXL driver AER-RAS naming but 
the same rules could be applied here as well. 

To improve the original situation mentioned I recommend we use 'ras' in what is named pci_aer.c here? 
Maybe 'pci_ras.c' instead? It's not perfect but would be more precise. This feels somewhat nitpicky on my part 
and will not be an issue if we leave as-is. Thanks for considering.

-Terry

>> -Terry
>>
>>> @@ -0,0 +1,168 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
>>> +/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
>>> +#include <linux/pci.h>
>>> +#include <linux/aer.h>
>>> +#include <cxlpci.h>
>>> +#include <cxlmem.h>
>>> +#include <cxl.h>
>>> +#include "core.h"
>>> +
>>> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>> +{
>>> +	resource_size_t aer_phys;
>>> +	struct device *host;
>>> +	u16 aer_cap;
>>> +
>>> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>>> +	if (aer_cap) {
>>> +		host = dport->reg_map.host;
>>> +		aer_phys = aer_cap + dport->rcrb.base;
>>> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>>> +						sizeof(struct aer_capability_regs));
>>> +	}
>>> +}
>>> +
>>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>>> +{
>>> +	struct cxl_register_map *map = &dport->reg_map;
>>> +	struct device *dev = dport->dport_dev;
>>> +
>>> +	if (!map->component_map.ras.valid)
>>> +		dev_dbg(dev, "RAS registers not found\n");
>>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> +}
>>> +
>>> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>> +{
>>> +	void __iomem *aer_base = dport->regs.dport_aer;
>>> +	u32 aer_cmd_mask, aer_cmd;
>>> +
>>> +	if (!aer_base)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * Disable RCH root port command interrupts.
>>> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>>> +	 *
>>> +	 * This sequence may not be necessary. CXL spec states disabling
>>> +	 * the root cmd register's interrupts is required. But, PCI spec
>>> +	 * shows these are disabled by default on reset.
>>> +	 */
>>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>>> +	aer_cmd &= ~aer_cmd_mask;
>>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>> +}
>>> +
>>> +/**
>>> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>> + * @dport: the cxl_dport that needs to be initialized
>>> + * @host: host device for devm operations
>>> + */
>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>> +{
>>> +	dport->reg_map.host = host;
>>> +	cxl_dport_map_ras(dport);
>>> +
>>> +	if (dport->rch) {
>>> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>>> +
>>> +		if (!host_bridge->native_aer)
>>> +			return;
>>> +
>>> +		cxl_dport_map_rch_aer(dport);
>>> +		cxl_disable_rch_root_ints(dport);
>>> +	}
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>> +
>>> +static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>>> +					  struct cxl_dport *dport)
>>> +{
>>> +	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>> +}
>>> +
>>> +static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>> +				       struct cxl_dport *dport)
>>> +{
>>> +	return __cxl_handle_ras(cxlds, dport->regs.ras);
>>> +}
>>> +
>>> +/*
>>> + * Copy the AER capability registers using 32 bit read accesses.
>>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> + * status after copying.
>>> + *
>>> + * @aer_base: base address of AER capability block in RCRB
>>> + * @aer_regs: destination for copying AER capability
>>> + */
>>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> +				 struct aer_capability_regs *aer_regs)
>>> +{
>>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> +	int n;
>>> +
>>> +	if (!aer_base)
>>> +		return false;
>>> +
>>> +	/* Use readl() to guarantee 32-bit accesses */
>>> +	for (n = 0; n < read_cnt; n++)
>>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> +
>>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +/* Get AER severity. Return false if there is no error. */
>>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> +				     int *severity)
>>> +{
>>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> +			*severity = AER_FATAL;
>>> +		else
>>> +			*severity = AER_NONFATAL;
>>> +		return true;
>>> +	}
>>> +
>>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> +		*severity = AER_CORRECTABLE;
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	struct aer_capability_regs aer_regs;
>>> +	struct cxl_dport *dport;
>>> +	int severity;
>>> +
>>> +	struct cxl_port *port __free(put_cxl_port) =
>>> +		cxl_pci_find_port(pdev, &dport);
>>> +	if (!port)
>>> +		return;
>>> +
>>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>> +		return;
>>> +
>>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>> +		return;
>>> +
>>> +	pci_print_aer(pdev, severity, &aer_regs);
>>> +
>>> +	if (severity == AER_CORRECTABLE)
>>> +		cxl_handle_rdport_cor_ras(cxlds, dport);
>>> +	else
>>> +		cxl_handle_rdport_ras(cxlds, dport);
>>> +}
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 3f1695c96abc..73397da7f970 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -759,14 +759,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>>  					 struct device *dport_dev, int port_id,
>>>  					 resource_size_t rcrb);
>>>  
>>> -#ifdef CONFIG_PCIEAER_CXL
>>> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>> -#else
>>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> -						struct device *host) { }
>>> -#endif
>>> -
>>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>> index 54e219b0049e..5f73ce42a758 100644
>>> --- a/drivers/cxl/cxlpci.h
>>> +++ b/drivers/cxl/cxlpci.h
>>> @@ -135,4 +135,12 @@ void read_cdat_data(struct cxl_port *port);
>>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>  				    pci_channel_state_t state);
>>> +
>>> +#ifdef CONFIG_PCIEAER_CXL
>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>> +#else
>>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> +						struct device *host) { }
>>> +#endif
>>> +
>>>  #endif /* __CXL_PCI_H__ */
>>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>>> index 31a2d73c963f..54b49d8e6b40 100644
>>> --- a/tools/testing/cxl/Kbuild
>>> +++ b/tools/testing/cxl/Kbuild
>>> @@ -68,6 +68,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>>>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>>>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
>>> +cxl_core-$(CONFIG_PCIEAER_CXL) += $(CXL_CORE_SRC)/pci_aer.o
>>>  cxl_core-y += config_check.o
>>>  cxl_core-y += cxl_core_test.o
>>>  cxl_core-y += cxl_core_exports.o
>>>
>>> base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
>>
> 

