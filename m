Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0756458
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172280; cv=fail; b=n51FXVNQeGeyqkYNUK5jfXRGicBxT/yE+zGWu6TVuOFrw5aAfre45lRXwb9fiYoSBpPlVhCsrGVlZziNU4HjHCCnZeAr3+KI+JIAHyYtKkmhwqmRpXvZBrGQi7pZEIZxHCG4l2KyAWROxLLC8E1luI/WZvSg+30SHrVBibpRN8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172280; c=relaxed/simple;
	bh=Tm67+MYCrMhc5d6cCxTMJ0PVvjsJz8EuJIELLrS5FgQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Atc6kXIoPkthu2XvwMgq493j6FuqdxyWKkZleEP9I00rHtggGFV+49m3/9UfCnOt5D8rWlwT/o/repoXpQV/UdshDHsPgyXbPxUzG4C5MFeAPEvNK2COPCpQPJnx3ES7eSayx4RdpwfnKMy4bW8w5Fc0aOlnXQyB9ImeLLJ1Sj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLq3ARvG; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLq3ARvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAm9bALOmFzdPUvFmwsp7iuEPN58YpZuyDGq3vWfBEkDO1YdEerRsfYcZFeNwNH6qA2dQt4tDdCqfouZUjo3KQV0nHvr8/p3MIcj0uhVfpWs/0WzzaSoDPKo1wjF7P22VIZtABflO6re4b3R4mXSS9voqR9rje4f17BaR1L9P9lLd6Bs+UBAG1Z1PxVUQe4jUU/h95AYyLUpvAFHpZA5wLr/SL601kqP2CAkJR2FRfbjrv7+xfGZVb8oDgUOl7pIyoq+FWKwk2zIQnchajBaTu218dNnnb7uJkHkBiRt7hvlpiq4idOgY3W7W/Z3N4Q6ix7VmGGcrM2wfA6aW2tR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEMOshjo9PZFBtUJwqG2UuLq4pxXYsiGt3xC0XRtJH8=;
 b=di5TadvPgREtzGtkotQ7xth+VCNnaA4FspK58waZKDzrSK/EyMGlc3jNk4mvh30o+nWzzUzJ3CrVGcQPuQ5CM+Mr8bfV1I1P/c+7+4BqwpUJaZ/tRL/6DDt1OBlqSincSQGVu3JveOVpxLQMZU7/KegKI6R+QfvqonEuSM6MfG4dzK5+qJbtUA5iAjMta505b7Q9y1NLV2/+mUcohwtSVIf6JT5c8t21rkonnpVLixXH6w1gS6cc1eXVv493HNUvNQW+G7pjaKDBxc0Ga83vd5YGeez5jcYfrV01pfySS0GxxHFXwDEu/jB7Zfc5wxyis7+xK3Q2qo4Kp1Dd6qBT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEMOshjo9PZFBtUJwqG2UuLq4pxXYsiGt3xC0XRtJH8=;
 b=eLq3ARvGngQux69Vt90K1DdUVGQa/16J1ztmRtBRffimNK+6FCSsGDROULv+I2AMRLKW4CEHFMM1SvbAPZSFyG6krliSr20iumvzl9LLoai0HIsq8+xKaKiQaiOPT/1GsH69E3wRBq7GEZsNwEX47I3ekOeXh4w8O/2w9JXcbuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 06:04:35 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 06:04:35 +0000
Message-ID: <b48e9bf1-ccf2-2ac9-3389-4175ae872983@amd.com>
Date: Wed, 12 Jun 2024 07:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
 <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4545ebf5-b9ac-4628-4fe2-08dc8aa588b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|1800799016|366008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2xVUTk2K3h2cDlTNzI4Nis0VEIyR0tKM291OGdncloxRSsxWnoxRmZJM3Q1?=
 =?utf-8?B?TnBaTXB3dnB4K0ZTSzdMVUt0akFORExxdmcvclV2OVRQWnN4R0R0ek9vMC9m?=
 =?utf-8?B?UDN0bzJpaFBRL0hJOTFPc04rVlBrQkJmMGQ1S2c0VldBdW55QjZqM0JMZzlL?=
 =?utf-8?B?bDNNaHJaa2JFRzd2V3dnTVFMNkx0M3JNekNVaHRBcjdSN2FrdkU0dEd3TjVS?=
 =?utf-8?B?TjA5NThCUm1CejNmVFloaXRNSFRCNjR0SEc4ZlREanYxWitXanowVE53SWNy?=
 =?utf-8?B?MWhOK0F4UzZsN0x2b1BscVI0OE5RYlpTWTFLbm04YWhMdTRNbjNRU2RDdHRy?=
 =?utf-8?B?STJxbVFXT3NKQkJQOWp6TWRaaERzMnRBektpZFpsZURLejdXWEZuVUtBZllh?=
 =?utf-8?B?SVZrOUVTU2QrNm5hc3cxTWtaNDgzWnAxUVJGMWhibTlLd1pGaFhxdTZzQU5Y?=
 =?utf-8?B?MnltKzl5K2VWTHBVVjNPbExMd1FFUEdRM0RWcndyc1NCUWFJaXU5OWtaa2dD?=
 =?utf-8?B?eTROSWNlQzlzRDNpLzFZVzRZUnhVUUZjRE93TmxyMktGM3RsWnlzQ2UySHBT?=
 =?utf-8?B?UExaUFJ2Y2ZxUUFMUFcwRWlaWWswRnFBV1c4Ujh1UUFkcUJMdVdWSzV3NVpQ?=
 =?utf-8?B?cGlqS3oweTJaZVA3MW51NytGSnk4R2ErOWkxSUZQZWJ2ZzFIbjBYdGN0TFE1?=
 =?utf-8?B?WlVDRTd3dG10QXorTE9KRmVCU3FYOU40RzIwUlpPK1l2bHNCdDh6eUZUcHdi?=
 =?utf-8?B?dlpreFd4RmRzREZpWnBGNXFmWmJlOThNZ2hOTUx5VFgvR050WjEwSXFVeHk1?=
 =?utf-8?B?dXpZa2FobW05Q2U1QTVGR21ia1JtcG91ZWlBQzZ2am9JZm5oZGJnM1dHWk9D?=
 =?utf-8?B?cGRjNVgrNVA1aC9nMmVhN04wUDdiRWF0L3VUZzVLRjNXSGVOWm1KK0duak5u?=
 =?utf-8?B?Nmc1Q2hVeWpkUDBlTkl5N2FwYzlOc2VTUmRreFphMTBFeUxHN0FVaEFVN1VG?=
 =?utf-8?B?NmZaM3VHa1ZpL1VQN3AxSUFjZllQaURwQWlMUGtyTWYxNjJ3cVQrNmZ0emJr?=
 =?utf-8?B?cE1QOC8vZmxYY0xwQktsU1ROTzJSbk9vc1ZoOW40YXpqU0dsZ3RnYXVvQW1M?=
 =?utf-8?B?NkZnUG1WaGlxRWtiWWpQenRKQThVVlpHS2hXSlhUTzB3Z3RYTjM4bU9KQ09Y?=
 =?utf-8?B?YVZSeUhlZ2lSL1pQNXBndGpEMkVob28vUDJWLzl4cFFrUHhJODFXbjBWZXNJ?=
 =?utf-8?B?SUJJSjlidmhlaXN1c2pOcnJwamVCdlhNZXhFRHkxb3FSQjZsdUpLR3IvMkl2?=
 =?utf-8?B?ekkxRFFCZHBBL3l0Q09TN3FGSlA0RlFhOUJkcm14QloybXNaSEkrZmpxTUFz?=
 =?utf-8?B?dUVWTlF3NVg1UGxnVDEvc1BYWGZURFZJdHFwWkN6V1FNK2VTRVNQd1ZNdmc0?=
 =?utf-8?B?aU80eWR6R1RPMmE0RWI2NzI0TXpEdWRQRXBRUlFNMmFWSnJ3R0FsTVJHbHBm?=
 =?utf-8?B?T29WVktURTF4RE42bGFaZ0FsVk8rcUw3RWtmVk1kaHh2d1doR3NVa3UydmtR?=
 =?utf-8?B?NEk2eFJqNytVNnZyQTNMbmVySDdJK1ZPMWpJK21BMUZxeUJtQ2p5Z2xMY3A5?=
 =?utf-8?B?TDh5SXAvYjRYQkJ6bTk1eWRac213Mi9YOHExUWZKbmJma1BBbjVNOFlGem5I?=
 =?utf-8?B?Zm5FeFhETGZnYnJ2WTAwTklsTFFyZTlleXI4elVrUEsxUGkzamVZTmhPcUNm?=
 =?utf-8?Q?MhWQTAJ9A9doCMZAOY51rwoNsiLqB46QvzLG1fA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWJnUXpwUEhZa2lyN3ZYQ1VjZDJOUWZHaXJDSmNRdXFJUGk5TkVrQW5OZVVB?=
 =?utf-8?B?L1VBYVN5TFRsdW5VNG00eEw3Q2JQRDdzOGkweHpXVXRTdmV1OExSZHN1TzNv?=
 =?utf-8?B?ZUs3NUk3QVM0TFNyZVNlbWU5eVNSTHBXL242U0ZodVpMNDJQTVlmcm1GOUlw?=
 =?utf-8?B?dDJSRVhuWUxDYUVWUlpLcWUrUStSMEpVYmJtZEdPdDBQMTdoaXpKUCtsSzBH?=
 =?utf-8?B?ZURybGxuaUpUM3NWWFMxLzVPVjdpVk15K0ZSUGJqUU5LWCtvZjNDUndCWnQ1?=
 =?utf-8?B?RG8yaXlkc0RMNWtiaHA2VVk4K3BKd0Y1Qi9VdVA2UHJPSzRDaDRjMWNDMDFR?=
 =?utf-8?B?bzFIWkZ2Y050M1owdzNnNXkzQXE1VndCMDBhZHF1N0ZhdnBVcnFhRldtUGNN?=
 =?utf-8?B?SktHa3ZBcy9LN2FpeS83YU9xZmtkYnd0Z2x0elVscmtVUzV6SFlMeC9lYW10?=
 =?utf-8?B?SFVEQ1lhVmpaWXFVbjNUSStjc29kVGZuSVVRWXdlWGppTld0OC9VK2xxWlUr?=
 =?utf-8?B?SjQ0ZERscDdpbkg1NzlkSTNYb2hCY2xJbTMrUjRvVjh1WXpsUm5OU2lZZjJw?=
 =?utf-8?B?UmJEY2R3eFV3S0tXTUJiQXVJWkpXcVJ5NDMrbllsU1E1c09nV1FNMi9YRms4?=
 =?utf-8?B?R0ZNN0g4S094RDlDYTZBSWhTRGViK1UrZU1SY0hxZldlUHVNNXNiQUR4SElV?=
 =?utf-8?B?NVhMYmF6UDVOL3JqZlJkVm5kZnhyME5VYk5RZGpaUFpscjBGdytRV0s1Z0d0?=
 =?utf-8?B?ZjFUMjdvRmlKbnMyTWFKODQ1ODZJUWdHSUJoNWtiL1A4TWJHUnVCNWdXQktC?=
 =?utf-8?B?Y3ZlUXNCQ0VWYVk3L1NnYkxpMWc3LzY4OUtROHFBeXNma2dFY3ZndlVnQVV0?=
 =?utf-8?B?VWt5RGlFSnVJcFJIMTRXTTNzemdiRHRLWHdkSkg3aWFpTGlRbnB3bzRQTVA4?=
 =?utf-8?B?RkR6NVhDaTJCaEpMOVNCQ1czR0VLenBSZ0pnN01XTk5sT0lMaFBUYnE3UGky?=
 =?utf-8?B?STQ1UlhSM2p6TXRBNkdmM2VnWjlCbFpVSm95WHhDbGhLam5NMUpvdlRiVmlU?=
 =?utf-8?B?RE1UMDltSlhIaHdEQ0JuR1Y1SCt3VTVLNERwUW9abTluaEhYOVdselY1VTcv?=
 =?utf-8?B?Nk1VbktrOXY0ZStIT21kWGdKQ2o2b21aWTZ2bmlleHBGZ3VtdXlGb0YxU2x6?=
 =?utf-8?B?aHUrSnhNMDB3RVJKckk0dTA2UGFpZ0xuVTRxa1hjYTFIR2tNY3QremtCdHpL?=
 =?utf-8?B?bFhUcXpUSnpkUnRmbEQwc2svc3ZpclRQNUtFaW94WWtJRFVaT3ZiZEs3QUlZ?=
 =?utf-8?B?VnlJT3JCWTQ0ZUY0QkxCVk1pWlE1QTFVbHhxSFZERjBKMXpqM2xWcUFJOHNJ?=
 =?utf-8?B?S1pCUndvVDlwU0pDaWVFL3hWMks5cndHUmZNcmRGbzJPY3dSVDdLL2pTTXRL?=
 =?utf-8?B?T05TOHorQmRUZDdPc2gzYWc5R05xdVh5c1hOSDZmaGJHR3oxZGhEVytQZk9V?=
 =?utf-8?B?V0ROVVlzQitsZUdQaEt5WG9sR2dYbmRQTG53YTd1WDU2K1JMWVpDcjRENFJk?=
 =?utf-8?B?NWhIY3dzU29LcXVGUGxMM3Q1MTNrZjBQSGczUHJPN0xzZHpwTCtGeE0zckNX?=
 =?utf-8?B?VENUeUhTYU1neDk0YzZzTzhCWTZrRXJmek5UdDduQTV0VmNkVkNLUVAyNUlo?=
 =?utf-8?B?TjlMMHpqWGRwTUVuZkNORzkzZkJvRW1PT093U0tNQ3hxWkFOMGJSK0UwTUJQ?=
 =?utf-8?B?OUJocVkvaDRVeHpQTlRPSGtLNGxadDZrbWVoYkZ4d0xVcGt5b01oWktiUjNY?=
 =?utf-8?B?RDRibFpUVjBpdGpValoxQ3lVSGhNaWJ1bFU3bzZZeitPM1RyZ1BwdHB0US9p?=
 =?utf-8?B?UXRRY1ptV3lQUFJXV1FFSTEyNm5XMmU3TUNYU0Mxc20vV3NSbXZNeldZcVF3?=
 =?utf-8?B?eFZaeGV4NXJVNytTUDlTTjVSUVc0LzF4L2x1andIdWRoSWh3Vnp1Ung0MTla?=
 =?utf-8?B?cmxJUmh4NEFOL2gvTm1ka2tZVVh0bzV5bldJeWhhdUhRaWVieWU2cEluYjJZ?=
 =?utf-8?B?TDU5Y3BodHlSbGovcnlvajU2dy8rQ3JKZzZuZjQ2N1lXOVA1Z0N4anRKYTAx?=
 =?utf-8?Q?120nRfxbeFW8Hwjcg9Q8sFtGG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4545ebf5-b9ac-4628-4fe2-08dc8aa588b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:04:34.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGP+SKtoHl0nuvL8turWLA2hG8EWYlfHHOT5yJmWLdmoYBa06RCLfloV0IkbaZZbSiJXwGsrtLr7/ytdwNJzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655


On 6/12/24 05:43, Dan Williams wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiating Type3, aka memory expanders, from Type2, aka device
> s/Differientiating/Differentiating/
>
> ...actually to make this imperative tense don't use gerund phrases, so:
>
> s/Differentiating/Differentiate/
>
> This "imperative tense" preference is borrowed from the x86 tip tree
> patch recommendations [1], which reminds me that CXL should create a
> document like that to make the grammar expectations known.


OK.


> [1]: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Adding a type2 driver for a CXL emulated device inside CXL kernel
> s/Adding/Add/
>
> I will also note that ChatGPT does a decent job at converting patch
> changelogs to imperative tense.


OK.


>> testing infrastructure as a client for the functionality added.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> It would really help me out if the changelog mentions what you adopted
> and what you modified. With a Link: to the patch where the code
> originated.


The patchset is mentioned/referenced in the cover letter.

I will add individual references as well for any patch needing it.


> I will still review the parts I wrote previously to see if I still agree
> with them, but its taxing to come back to this patch cold and think "did
> I write this routine, or is this new?". Can you repost with the
> changelog commentary fixed up to reflect that?


I'll do.


>> ---
>>   drivers/cxl/core/memdev.c           | 15 ++++++
>>   include/linux/cxlmem.h              |  2 +
>>   tools/testing/cxl/Kbuild            |  1 +
>>   tools/testing/cxl/type2/Kbuild      |  7 +++
>>   tools/testing/cxl/type2/pci_type2.c | 80 +++++++++++++++++++++++++++++
>>   5 files changed, 105 insertions(+)
>>   create mode 100644 tools/testing/cxl/type2/Kbuild
>>   create mode 100644 tools/testing/cxl/type2/pci_type2.c
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 07cd0b8b026f..0336b3f14f4a 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -659,6 +659,21 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops)
>>   {
>> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
>> index 0d26a45a4af2..e8d12b543db1 100644
>> --- a/include/linux/cxlmem.h
>> +++ b/include/linux/cxlmem.h
>> @@ -859,4 +859,6 @@ struct cxl_hdm {
>>   struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>> index 030b388800f0..a285719c4db6 100644
>> --- a/tools/testing/cxl/Kbuild
>> +++ b/tools/testing/cxl/Kbuild
>> @@ -69,3 +69,4 @@ cxl_core-y += cxl_core_exports.o
>>   KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
>>   
>>   obj-m += test/
>> +obj-m += type2/
>> diff --git a/tools/testing/cxl/type2/Kbuild b/tools/testing/cxl/type2/Kbuild
>> new file mode 100644
>> index 000000000000..a96ad4d64924
>> --- /dev/null
>> +++ b/tools/testing/cxl/type2/Kbuild
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-m += pci_type2.o
>> +
>> +cxl_pci_type2-y := cxl_pci_type2.o
>> +
>> +KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
>> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
>> new file mode 100644
>> index 000000000000..863ce7dc28ef
>> --- /dev/null
>> +++ b/tools/testing/cxl/type2/pci_type2.c
>> @@ -0,0 +1,80 @@
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/cxl.h>
>> +#include <linux/cxlpci.h>
>> +#include <linux/cxlmem.h>
>> +
>> +struct cxl_dev_state *cxlds;
>> +
>> +#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
>> +
>> +static int type2_pci_probe(struct pci_dev *pci_dev,
>> +			   const struct pci_device_id *entry)
> So to date, tools/testing/cxl/ has been for cxl_test which skips all the
> PCI register emulation and just runs based on mocking core-kernel and
> core-cxl interfaces. I would like to explore how far the cxl_test
> approach can go and leave the PCI integration to when a driver can
> reference real PCI ids.
>
> Otherwise, I feel like too much development effort can be diverted to
> this "proxy" and increase the timeline to seeing the real thing.


Fair enough.

I think I could add the real driver in a new patchset version or maybe a 
completely new one.

 From my previous comment about potentially using something like 
auxbus,that would obviously mean a complete refactoring.


>> +
>> +{
>> +	u16 dvsec;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> +
>> +	if (!dvsec) {
>> +		pci_info(pci_dev, "No CXL capability (vendor: %x\n", pci_dev->vendor);
>> +		return 0;
>> +	} else {
>> +		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
>> +	}
>> +
>> +	cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxlds))
>> +		return PTR_ERR(cxlds);
>> +
>> +	pci_info(pci_dev, "Initializing cxlds...");
>> +	cxlds->cxl_dvsec = dvsec;
>> +	cxlds->serial = pci_dev->dev.id;
>> +
>> +	/* Should not this be based on DVSEC range size registers */
>> +	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
> Especially at this stage of the driver there is nothing that require
> QEMU emulation versus cxl_test mocking.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static void type2_pci_remove(struct pci_dev *pci_dev)
>> +{
>> +
>> +}
>> +
>> +/* PCI device ID table */
>> +static const struct pci_device_id type2_pci_table[] = {
>> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},
> Real vendor-ids should have real device-ids, also that particular
> device-id choice is not appropriate.
