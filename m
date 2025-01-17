Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A81FA8F5
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109455; cv=fail; b=AtwzYDG4B9l9f5TemcvTchcYCzCkhTi6uADgPNp4ru60nrKvH/z1GQK5RXd/nIDqOpRGHA7zsNFdIzLGnMJSMD7mKTYfFqRdUIBbwiHpmuwXbNtXIshAfLFq+cmTE6qO1yMUZBfJzuAp1yyxzuV0hRe/ztqAVHjKWcRrQej6HPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109455; c=relaxed/simple;
	bh=HaLpXcRhEimerjxUjjoIF5Fv7c0LK+7xkpa9EI+B/7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MjkjYJ3JgDDv/NvLlvJR6QsI4wOHFWrkKx9dzAKI6aoblZweLQ5UQ9T6iJHT2txHy7KTtwduSPGUSDulSUQftzFjtauN2OYIZOEQXHMDKy6bYA5OssovmK/unjn8Bs4HIQ9cA9d/9Ppzu5WWinzROxtSB0VFgaPZGdCH3nQKzVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eTaDGkkr; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eTaDGkkr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aekrC8YnD7135EGg3fzu9hRp0EyXghvVOOAZzH6GIgxCGCggOb1OyL1UAsLS9aQzkSVHaSrMduqN0XCi0S1OXMAhIXf4NoWbLD8P4dpGa0rJNBm5MXEUSyFeyI1C242e3HhqKterEZsi++cwtT1ypBJg1vNH7DwqRJSdVP8X9Cw0goXPHOALzmnTahM1BeIpVXT9aVMXp2QFmsOEuH61KepewIwkjY5ib1tUYY3/TBMuQmCZCitsqGxRaw0qEDxrDCC941PNkbfTetebmnJH+8dLahH4GCKIqqucSFZqNNfpf9YPpwIQc3XiUrMNXunGa0U0rizVGmLk+a32hAGnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89LgBvOvIp2+v6Iqmqsfosk1McGtOwOyzi3+Hs2syZQ=;
 b=ynzDGYkR9dPkmHj4WhLJo1cvreWGEzOTOaM4H5B2wDsdqnH9043Z+jjlOACQik4TDWg9DKQv0MB0KiS0dkd+pLzO0jfW+L4yOzkMc51IdR/foCDrOqB0+CttQ9FucCSQTWQZ3QO9fpypUTxgFgBJ4E8io4Crv+q1Y/aeaGnYYOmE2knKWWJ08Rc37mcc1TwRHL5fUCpc7xVfEPV091sj0tdHzhwl4iMGeIKIBvCKixqvfCwZGEZoPs7sHN/nO61BnmNYyYTSfMRCmEJWwDaNRfFVFGi45JqLr8xasyohrU4/yWMayiBChpTnpBNN/LlUo8nU8tyRtRpfyLJz2TpQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89LgBvOvIp2+v6Iqmqsfosk1McGtOwOyzi3+Hs2syZQ=;
 b=eTaDGkkrPx9xPzZJeX59Mrkt1So+j+kvXTZfl8epRtb0NQwSraLmEwAWxq63GiOjsI0dcdzMsxqdY1VS5UARDLMhDQcNqqJVLD7SkjSc05rAGwXAg0mVuwdsz0eaBIaM850FV0SzPI3xFiaayl3RexLYxKqo1lQfTmJ0ktATXAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 10:24:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 10:24:10 +0000
Message-ID: <8705f4e6-58fe-38c2-1980-081ef331e845@amd.com>
Date: Fri, 17 Jan 2025 10:24:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] cxl: Remove the CXL_DECODER_MIXED mistake
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1ea2db-69e9-4212-21d9-08dd36e11506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBVbGdnZFJNeXJJQkZoLzhkcDRqS2RtVTFVM3VYY2w0WFBFWCswL1pmb2NP?=
 =?utf-8?B?WDdGQU5YaVR4a1E5NGpoWDlPMTBSZ3NIZTRBTEJTWGQxUkRYelFQNk9HSHI2?=
 =?utf-8?B?T29Dd1dJWlF0OHNPRDdMeXVPU0tqTTVKMjQralU5Y1UrL1RHbTREL3BOSkRK?=
 =?utf-8?B?YWFOM3UwOG1tYXBFaDBrWTlhUm1hOThGaVN4YnUxUmRCMEhHTkh2amNydHhG?=
 =?utf-8?B?TVpTNEZQMzR5ellRSUdIc3hvMDZ1NDVYZ3owcGRvMDc1dmY1cllPSjByWjhO?=
 =?utf-8?B?UWtkT3BNa0VVODBZTWFHOWdBWk16Z2E3ems2QnY0OHNYRUhPTnRWZm5TdHd0?=
 =?utf-8?B?UTM5VlhTc09xSThWOVJBamN5T3JUUHk0bEFWb1JSb2lkU3UvZzdTcFZaR3Na?=
 =?utf-8?B?ci9kWE1WQmZkN08xZXhYNU5FL0RYbEFPeFhnQWZndCtNRDg2VEVDMjhLMnky?=
 =?utf-8?B?Y0lmUGVTbnJwNkJpcUFGenpzdUoxNEhMenpPc0JGOGtKamtialc3ZVI1YkJQ?=
 =?utf-8?B?NW9rM3Z0dmtVTDZwNjMwRU8zYTJ3NVpqVnNyaCtHcDQ3MFhJQktLenIwbXlt?=
 =?utf-8?B?VzAxVHBkTmFDSEFYTzFzZUhkUGxtSjN3YWN5aldUWG0xRS9USWwyZGszTEF5?=
 =?utf-8?B?ZXdZQVlrWkV6T1haTElRckZZekZ6Uzg1ZDhUdVAyZ2ZLZUJiTFU3bXVvcEZX?=
 =?utf-8?B?VWUzTnJ2UUp0dStGYnBMVlp2bVUyY3R4dkZhd08vUmRaR1puWC8zQytJbWxQ?=
 =?utf-8?B?d0dmVGJRTzE0MWkxM1htanBWcGdySEFwNUNDU2MrK2psVFdtZzBtVC94WUwr?=
 =?utf-8?B?ZEVicTBaOFJlQmtiL0lLYkdJUDk2bndFd2JnWlJRRERaR1Q1WmdTT25lY1NE?=
 =?utf-8?B?QUZtc2RKVU41MUcvc0hxM3l5cFY0YklKTjhTamVCVDIzMTZaZFU5VWhhQ3FD?=
 =?utf-8?B?YWVBaFNPRmFMZGpUcDFhTXAyZGxFZGF3d1JRa0FBUjkzMzByeUU4ZUxJVzBs?=
 =?utf-8?B?LzZjc05maXRVQUJiQ28yQWhrK0ZDeHRMYkhwRkNFQ3JsSk9ZNGM2dmZNNXpZ?=
 =?utf-8?B?UFJPMmJhMzVNVmpsWWVrTlZYRWlrUTI0MXd2akNrazNWRHNXVUxaNUdsSVRm?=
 =?utf-8?B?OHRLeU5FTUZhU2R4MFBUSTZZV2dJZFJGNkJ5b2pVeXIwTnBmR1ZRSGowVXZt?=
 =?utf-8?B?WFMwenc4VW1HZkVMYSszdENrb3RRV2RRczRQRGNRNEc2N2hoMURYODBxazZ4?=
 =?utf-8?B?b0lUOVFvVXVYNHNlRDJSRU1qOXhVTUd1SGVBQ09yOStwTHFXaTFnK0dpZzlv?=
 =?utf-8?B?R0x2Q3pDczFOZEpsbXpPWkRyTFE4Q01hNFFuTkNvT3pvM0tENzBKNjdMMkRW?=
 =?utf-8?B?WjcySmQwME5vckx2dnl1N2tvTE9lckJidUdrL2lGTWNPZGNlb3BXTTFrYlBB?=
 =?utf-8?B?SDBtblJha3d1eHY3blhZSVVOelFQa3JBNWhYSnVaK0xsMGVGdHVRSXBIYm1B?=
 =?utf-8?B?cWxZbXM2V0Yrc3FpWGdXWDl1b1hBZDBVTXRiTlI4bzhqUTkvTHVldXZ3NmpB?=
 =?utf-8?B?ckcrcStrMmlXSGZmUXJrSThlbGNLL0Z6UFJZY09VcE9WSkdHdWNuNkZZU1J3?=
 =?utf-8?B?MTdYZzQvY1hRZ3RweThYS0I2bmlwancxUGdsYXhUYWN1MURrZE5YU3JxeVpu?=
 =?utf-8?B?dWNIazdXZFo1ajg0WGg0WDYwMUFQdVZKdEhMR09VSXFTSUJ2OEpvUGRCNSt2?=
 =?utf-8?B?QXE2ZVQ0STdlREhSOUhHem8vKzdsWENwTy9mSnU0T1pabG5GUmVGT2x3b3F4?=
 =?utf-8?B?R0ZIa3JaR2FmVDNacFlCd25tMzBLdWljVFhkZGEzOVlwcHRMdlVBN2VuVHhG?=
 =?utf-8?Q?6Eb9MWxYY3ogp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk9jeVcvZ1MrWXRvNmd0K0xpa3F6Qmt4eFJMSFJDNlhkQmdsSm1xc0NMWTRr?=
 =?utf-8?B?bENiMWpBM1lFVDB5RVljejJXK245NXY4a21xTk5PLzJOejhwM0ZTaXlNcG15?=
 =?utf-8?B?S0sxYk5QWkNMRUtodEVhQlh1bmNkTTBSTS83RWh6bXptYXIxYkZMMG9NbzdI?=
 =?utf-8?B?Zll3MHNCTlRWQzNjdTBkdk1uckVGSmtjNUVYanNtQ0I0MDd1d00xUk9EZUoz?=
 =?utf-8?B?RUZGMGJBRDRFVnBYT3lRL0VjdDNnUkc2anA1Ky9DaFY1cmhma0hBVHZQQVl4?=
 =?utf-8?B?YzVwRzluZUtOL0pJTlJxcm1rTXJKaTRqUkkwYllkZDVzVXkvMWRhNEkzMmdM?=
 =?utf-8?B?b2R6cHJWWkNvRDdQOWR4bzlTd2JLeWUweEd3MVBqeXNNWlhvUmdiUWJvQXZX?=
 =?utf-8?B?RHV6RmVrMjNPMitQeFYzTXdaT3ZsVmpEMEtSckRLVzRnOUQ4eHllVGpldUE5?=
 =?utf-8?B?bXVmSWpOV3Y5TFB6YXZoWURkVkxkNEQwWUVqWkpidEhjSXBMbzNabmd3c25N?=
 =?utf-8?B?djVIK0lmYmtiMEJ2SGhqUVN3bHBZMEVZNlJvWDZma21BeXl1V3lWQmQ3Ui9s?=
 =?utf-8?B?TEQzZE92VlZZa1FZRUVoeUVYQ3pZei9VQzF0TDhzNGJlWFhQUzZMZXlrcktE?=
 =?utf-8?B?NEVKQzNLNnViTjlwb0llaXhSUEdaSGczeFBKak9SbUEvaVNQamJPM1ZlNDh0?=
 =?utf-8?B?TkFMeGg2SFJMdzZOdHVzR3AxeEptL1lEZE12ZkQ3OHYzZllqZWkvc25EVUts?=
 =?utf-8?B?R1F4UlBpV2hWeHdZY09vR29oSGtIYkdMVHhVbjI3RWw1T3d0bFFqWUFOelQx?=
 =?utf-8?B?eGpleGIvL2ZYeTlBRnR6bEVuKy82RG43RTJGOHdJK0tOZ1U1eHhpZGlHcTZO?=
 =?utf-8?B?clRQaGF6ZmxUODZnR0VGMm9Lcll2Q0loS0JTYTlBYUQ2QnpBMUdBZEJZNFM4?=
 =?utf-8?B?OEI5SWkrb2JGdFkzSmQ1Z3ExZGowWmxCdlBudkNZMENQUHEzcEZEd2tEOWhY?=
 =?utf-8?B?bkZqNUtoVEM3L2pvQWZQKzhJQTlEV2ZEVzM2eTBHdkFIeDFVd29FdngrOXhh?=
 =?utf-8?B?MlVyamJqRUtlUHBoOXk2czNWZTd1dEwvYmswVmFSS0EvTHRIWEJBUGpmdXRW?=
 =?utf-8?B?NXNGWEw4YWpneno4aGtoYnVTakVRczhyR2RpNUV3UHBjRkhIZXc5dERWUmNI?=
 =?utf-8?B?SGZCU254VTZxc3JuNW5xM01zUEcwLzB1L21KMjhsOFhwbCsvcldVWW9QOVFs?=
 =?utf-8?B?NlpXL0ZEY1lXTVE4cWZraGNoR2M0UElzL3RrZDJyaXREdXpzNno0SnpHWUNh?=
 =?utf-8?B?b29KQTE0SWhTay9GcFhwYzdXUWc0a2R2ZHgrRFRMZDdoeE9pZndnUllqVTlM?=
 =?utf-8?B?WGpkVVMxVThKbjZPQnkvdGpOdk4wVWIyUk95UHVoL1M2WWZnQ2N6anU5akxw?=
 =?utf-8?B?WlppWkZ2Q2l6R0dUNVlhalZvYThVVzY0dFpxc3FrR3B6L044NUd1dGp2bUcx?=
 =?utf-8?B?eDhLdnNhcm45Z0hmeDg3VWZuc1Z1emFKa0RvQ3MycWNwbWt3bHhCbWpVRmFN?=
 =?utf-8?B?V2pIa3J6MEZvc2FXVk5BdW9EdVYvOGVVMVA3TlhZTVJ2RzRnUTN5VTJTV3E2?=
 =?utf-8?B?N2FPZTVFQmpmK3NyS1RjZUtGWm1GVU1BL083VmNqYmVtY0crNEUxTkt0MXEv?=
 =?utf-8?B?U1M4VVJqbXdsRGZDTWZzeFNJdHR4U05mUHZnZGFURklGb3pLNUYvdkxkUHpL?=
 =?utf-8?B?V0QzakZLUWpQdGg2ZjlvcmZpRVpPSU4vSzFDNU9FcGdLSWhIaVpWVlpZazFH?=
 =?utf-8?B?QURIMkNtTis0RUdNOXFhK2RUTXE0V3J3azN5cm1MQlk5eDZUNXlDLytvcEIz?=
 =?utf-8?B?Vnd3a2JiYWNzN1RtOXVYM0tjai81a1pFTnFuOE4wUUx4QnpPODgrY244TENV?=
 =?utf-8?B?MmJsVDZHM01YeEE3Y3JYc050TVhoSHpocWlIVE84OVFYUnRYT3VaRjdrWUtE?=
 =?utf-8?B?S3RDVE5BVTAzRU00dUJyY1IwMGtOWkNlcjNpNWZEbHVYa2JqTlUwYThpS3d3?=
 =?utf-8?B?Z1plZHlKTUs0NjY1SW41MG0xcDJhNURYcWMybWh1NFZ5blQzdWRxdEdyZEU2?=
 =?utf-8?Q?hdMeEzXgRYpkjWJFxrAKZ1Ru1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1ea2db-69e9-4212-21d9-08dd36e11506
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:24:10.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14qqe9vbZIGM3nYi4yNSCDGyaKW2y5ul9VF7iDDtsvnyws2hspIrNfedee4zaC3in0DYK8V0UB5RlapkENcayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329


On 1/17/25 06:10, Dan Williams wrote:
> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
>
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
>
>      __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
>
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.


I wonder if the reason for adding this CXL_DECODER_MIXED  does still 
worth it for fixing __cxl_dpa_reserve instead of just not supporting 
this case.

Assuming it does not:

Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/hdm.c    |    8 ++++----
>   drivers/cxl/core/region.c |   12 ------------
>   drivers/cxl/cxl.h         |    4 +---
>   3 files changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 28edd5822486..be8556119d94 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -329,12 +329,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   
>   	if (resource_contains(&cxlds->pmem_res, res))
>   		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	if (resource_contains(&cxlds->ram_res, res))
>   		cxled->mode = CXL_DECODER_RAM;
>   	else {
> -		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> -			 port->id, cxled->cxld.id, cxled->dpa_res);
> -		cxled->mode = CXL_DECODER_MIXED;
> +		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> +			 port->id, cxled->cxld.id, res);
> +		cxled->mode = CXL_DECODER_NONE;
>   	}
>   
>   	port->hdm_end++;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d77899650798..e4885acac853 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2725,18 +2725,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
>   	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
>   		return rc;
>   
> -	/*
> -	 * Regions are only created with single mode decoders: pmem or ram.
> -	 * Linux does not support mixed mode decoders. This means that
> -	 * reading poison per endpoint decoder adheres to the requirement
> -	 * that poison reads of pmem and ram must be separated.
> -	 * CXL 3.0 Spec 8.2.9.8.4.1
> -	 */
> -	if (cxled->mode == CXL_DECODER_MIXED) {
> -		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> -		return rc;
> -	}
> -
>   	cxlmd = cxled_to_memdev(cxled);
>   	if (cxled->skip) {
>   		offset = cxled->dpa_res->start - cxled->skip;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..0fb8d70fa3e5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -379,7 +379,6 @@ enum cxl_decoder_mode {
>   	CXL_DECODER_NONE,
>   	CXL_DECODER_RAM,
>   	CXL_DECODER_PMEM,
> -	CXL_DECODER_MIXED,
>   	CXL_DECODER_DEAD,
>   };
>   
> @@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>   		[CXL_DECODER_NONE] = "none",
>   		[CXL_DECODER_RAM] = "ram",
>   		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_MIXED] = "mixed",
>   	};
>   
> -	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> +	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_PMEM)
>   		return names[mode];
>   	return "mixed";
>   }
>
>
