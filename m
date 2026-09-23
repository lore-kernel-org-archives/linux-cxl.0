Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F043FCB10;
	Wed, 23 Sep 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153375; cv=fail; b=M2TUd3fWQUvXjyVoQ+nYJCQbu0j0FxTjlJqnYL7I0bj3a3gQ4rHrWdLR8n4FF+rcdDZEEfpgTh4jqKzDExM+ZHSp2jsjm/7BJ0EI84hhFEkE91RbfyTUAVGzjN0AQhuETIIu2PVWwqdNofvZhBjcr90D/BsuCISzRQn0ez55PgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153375; c=relaxed/simple;
	bh=fQhFsUe7KfIKadwiFYLU8pTcB0dVTSHoHawTHt4jUOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FSLmeOCVw23CvuP2mqgNCxkk/axv5BFTcp4XL60mzl5Uyy0akdOP8OXUoVdbV0k2U8As4oF+3sseSGWJtwln5tWEdnEPs8c6+lwux/mOUNFAlVXAm3S9kX4rsg9imx9pSj8Lt7+J2lIpDtMHmcUWJ535GJRkZZopk4zfR/KS27k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dv6/hzoA; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dv6/hzoA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfBxCWfQmlVbpKpzQZe94w1AQL0VZPY6QOWY8nGkBQu0+BO7f7vzebYyHGoKZtuflDb214Qb0a91EMBsL2SQPLXoVaop0LwO2UUKlagbxJWcbDMozpPeuv2590mL3d5JNCn0PB04N51kU9Bcyt0RJRp8ijtbq+f+tbLP9K0yyRuePa1KRlvNINpIS9O6UI1b0r5qrRzHUmJziJlXAjRWwUEE3jg+DzPQNtWBxqJn0IVeyZJNg50Bjyh4yPILY7fSFwcgM76tQkcb++17k7kOZX56Aaal/s+ISo5guLUCaGdW+KTDqOyN2yQu0fjASb4B1fhhFkMXLI75mTWbwdSkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2Fm9vgQSZdrvT598H8IFOKD0OosJACJa9R4s51Wrvs=;
 b=j4u1d0KX2db/5ZiBHf+gVI6TRXOleqUfm+JvyoCNQojNE6peCyRCGSo9kuruGQiVhy2JWLhp+mILo8txJMFrGNlKMYjbzxIQW5xkdmlCDdOJlvaq4IRXG2Xf/QZRDsRdcyjYs8YvRP8SDvrn2jPiVAfq74iSqQLyBk2n4cHPpJpUIdIOY+7J7pqj0b5dQNIa7iM2vplpK6H2XfkPT6c2PA2ds6dqGfJeQ2pb47F3VUULwJkd6S1lanknSTwXzkIp+vAGwl1SSoCuMkDu5R1DK3MkeWw54wCBjDBZhxP7ZQPwgpC68IU7XXzBEQHoq6D18/hrZKqy6TfCq6Uj7vKQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Fm9vgQSZdrvT598H8IFOKD0OosJACJa9R4s51Wrvs=;
 b=Dv6/hzoAu/mezNVkd9M90TEM1xz3IoIz8hr9sPbKHji2L5eoJ3frAYxI/Zw39syjuXWx/V87Ade4yUKJXtt/29VjTQXNVXUc2oBCaLGydmbeT+EqG6UaF+8K2IKnDJJB75CumUEvqYNytA44rTLxfFUZ7VNSZ1PAUSMIG88zDng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 08:49:30 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.014; Wed, 23 Sep 2026
 08:49:30 +0000
Message-ID: <3ab9bc66-f3b3-465b-b736-09df1da2fcac@amd.com>
Date: Wed, 23 Sep 2026 09:49:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] driver core: Rely on supplier driver binding at
 link creation
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-2-alucerop@amd.com>
 <2055ead9-201f-4878-aa09-07d7fc3ab3c2@bootlin.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <2055ead9-201f-4878-aa09-07d7fc3ab3c2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbff468-d20e-4c8b-142d-08df194f952c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0tu8/3vTbcCAAGG+STNqxKm3h5UHRppaho6+YV3nrPGsv8McjzjCXdgi/PH/j4tjb1ln56L/86Yeh6OUlMcxTC2gZtyBCsD0Hus7VuJvqTowGfQNjwkVjyOCoJX5bp8oRUcJ22Ho+I8bRLogfGtVZHZSv11EpapXA2yxmHRxTJ06+M+13JzPwRYTaOeaeMh0Vg2AyrHQStx4Ug4FdG2GkOtdFzph5gR6BRtu9RBUuYlHFW/XzTVbATD86wFig81rnmFhxVAfpsSiw2QDmDTlxvu+BeFRlWAqQmYy/Fse79SZyzwW67MC1uNusZVRkY04H/2fF+POsv2z20RonKfbgSxIHS6giqe1D+1iGUmRoW72CslYjfiniHZUoobMOgaKXpsIjYFpAAU4siim62GWzUF1CFl/cD0+m0x0TMoqbCL2uzlUm9IVnDeH5FK2xvjzQ3XqoJYMyqCAjjs3GWFxciQKKWHVE7mMmW9//137axqrWVVltH1NV5O3zepH4tM2H9rVtJlOIQzHb7ozcrM/uNBjKVeAM7rXSXv+tHxu2q43YWjRYbQZGCRv59bhf1hKiCcNXeXjxA6CujtAlIuxts3+ETDzwrFmcgSAbVRqpAJPVhaymoVs3HQBk6im4L6NxUmBP/4FUqgFSydu/DZwWLzObvhXzw64ldunmV7gTdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0VtNEJxdE1hNGdVb1FQRk9XQ2UwNDljRUxPbmtlOE5mdEhrNm96T1VRdkc1?=
 =?utf-8?B?cW5kYmg1NVBKbVlqTTVJZ2xsczMyN0JhNFdyUUJrdHNsam5RQVdKU0JvMlNB?=
 =?utf-8?B?MGd6N09WZlFuYmVSRlZ1bW5uR2lYZWorWWMzZktMdy9CcUdNQVkwRVVKNXZv?=
 =?utf-8?B?RURPNStRaEJxT2t1MTdON2t5UGxYdUJxNldodnV1S0FqQWdndEZIREZScFZO?=
 =?utf-8?B?aTc0SXA3c2dtNVltVDIvZDB6UWNMZW00cFRxTlNTMjlEUHhzRnNDc2N6Z1dH?=
 =?utf-8?B?Y0laNmNOWGNUeHVFcXFxRUlKdjY4RkdkRDFWVzBkSEJ6eGZnTSsva0svbVc2?=
 =?utf-8?B?emdBZ2J0b1dsdWNyKytYYkEyTEUxTWU2OE40WmduRTh5a0tvNWcyc2JrQnM2?=
 =?utf-8?B?RUlUSUUweFNBVlVpWEJMMzgrY0RCT08wNFpyQjR4Z0doZ0Q1YXBxRzQrSkNU?=
 =?utf-8?B?LzRpNlNjdW1hbHNtUTFqRU1VQmVTd0NWZG9FMlV5WWNEQ0lBcDNxaUp0ZStD?=
 =?utf-8?B?d21hRWduSEoxbTBVR0NEWUFzOHp0MjZEUi9BNnRFMmJockl0SW9VcHdOQUtp?=
 =?utf-8?B?aUNhTTFhT3VBQk9xZGMzbzJYSlZtRzdzZ3RsbWtrc1d2czdMMmJ2ZS9rbGZu?=
 =?utf-8?B?R0QxZmhxNE91WlBCRFlZcm5OdmRzZTBVazR6SmxOQlA1UlB3OFZNRitHU2h4?=
 =?utf-8?B?QzZJclc4Y253Qit3cC9wd0lHeXZBaUtZT1ZoczFXaVVkMU9FV3hoTTZkZUpF?=
 =?utf-8?B?Wk9CZE9qdFhqL00vckR1dDd5dWtCMGtSVDh0TjNFZFUwbTQ3L296Tk5HWnVC?=
 =?utf-8?B?SUNDenpWYjFXZERYQWZkbElYRk13WVFwYmYwWC9tY0ZFOE1LdnFvWW1JWEho?=
 =?utf-8?B?Z01HZnRaT1ZFTHF6M1JKODQwNmhnaXdhaHlFM0dNZW5KR3hvd2F3RGFTQnJQ?=
 =?utf-8?B?bXNKQ1pFZ2x4VHQ5MGtCTHRGcFNSZFh1QUFwU2VadXdiWVlxeDZBSkhuSFlv?=
 =?utf-8?B?aWJBdG1kVXhwM2dzSEJEVG5CT2xzOVJUOTVBMjFwQlhHbTR0Um1wMkF5bUNs?=
 =?utf-8?B?UU9HRUpvenV1MExEOVdOR2hMTVNtYVAxcVQ0dkdOY28vUmtzdDNjREtoWW1m?=
 =?utf-8?B?VjlVcXMydVQ0UllITTRpWk1KbittYjdoYlp4OVlSNmNEc3RPUExTWjZWL3dL?=
 =?utf-8?B?S3RIME9tdTJKMXNwZER0bDF2ODZCL1Y2ZXhCaGVmR2hmcGxEckYwblpMV3Rw?=
 =?utf-8?B?Z2Z4VVpKQmJReUNyOHJSQ0ZiN3l1akFKb25JMTZXdm43ek5TNWhvS2d6MUN4?=
 =?utf-8?B?OTlrdW9hUVNaNVBINnBGcnBCYURPZ1J2N1RRZVhPYWJvRFN6Wm5PaW9tclA5?=
 =?utf-8?B?bHpiR3dvZnowUXgranhPci9QMUxIT2xpT1dDVzdhNnZiUndpTExYbndFSnFB?=
 =?utf-8?B?VEZpcmNGajhHcDBpdmJ1R3hKdy95NkNQcEJ4bTBEV21BSGd0Y01mSUJXckxS?=
 =?utf-8?B?ZXJ2WnZocU5tY0N6di90ZW5JS2g1UEQ5RDZoYUVlcXVkL042NithdlpoTVpw?=
 =?utf-8?B?U1Y5QVcrWE42bjZacHFuMnFYRGJUKzFLeGpUcGpRVFQzeXNnTWpyZGhyQmRP?=
 =?utf-8?B?OEdqWlZsZUdna255MFF2U1FYMFFDMi9MYmZ6MmV0dTRtTzhIL2NQYlZaU2wy?=
 =?utf-8?B?NXpNRzF6NWxWZENXTlozR05kaFMwMnRCcyt2TnR3bWh5ekhWZlRuVllwM0VN?=
 =?utf-8?B?S0U3VWNLU1I1dUpzMG5odm1tOEorVDFIZjFlcTFzdFpNclVuZFRGVDZ6K0pD?=
 =?utf-8?B?dEVZRmg4aVZRLzlnY1VmemxxdWo1dERnU05wS1V2Wk5zVi8xdnZ1Rm9zVldj?=
 =?utf-8?B?enk5eFJQS0F6amtUYWF6TFkwdzd0U1cvTVkvbkk4SFBoWjV6RGk5U0hLcStj?=
 =?utf-8?B?Tk1wS25OZHlPVkdMM2FBeVhEdXZXc2hjNVBlWXRjOXRmMEtXVHQ5aHNvWFp4?=
 =?utf-8?B?QW9ObkdsTmxZdkdqUG01S2dqWU82cWk0bkZrWkVrcVliMHgxdFFydEh1Ly8z?=
 =?utf-8?B?WFlScEhpNFJRMlBmU2NSWk4vdU92L1BhMzB3djZEdDh2aVhHeWtMZlZXanQ5?=
 =?utf-8?B?MXRDaDkxcFFYSVNKbW5wdEthUnhWdCtBN0ZMcWVLM3FNN3NqRW9xNkpXQzZl?=
 =?utf-8?B?bEZDODkwR3Z6MjQ2SkpUTWJjdnNvNjl1aTJXblNWQ1JtZWl3YmxOVWhjQU40?=
 =?utf-8?B?SjdFSDErcUVxRWJmcmZsMGhvdFYvNEtYckovRm5OSjZna3l0bXRaa0orTDJR?=
 =?utf-8?B?MFVPbUFUclhOT3c2VTZQZEdwVi8wMm4zMXQ3OStwMkc2eWFTZy9WZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbff468-d20e-4c8b-142d-08df194f952c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:49:30.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnpzZ6bqbuTSvUZckBvAhqjf3f3swssy2zptAU92nLamBKCUHjfK1mI6YfCs4y8eldKg6eK6VvaZBMw/Sv9RAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497


On 22/09/2026 22:39, Maxime Chevallier wrote:
> Hi,
>
> On 9/21/26 21:12, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate between driver binding from PM dependency when a device
>> link is created. Rely on the device being bound to a driver for validating
>> the supplier as some device drivers could not support PM.
>>
>> Check for supplier's PM state only if consumer specifies PM_RUNTIME flag.


Hi Maxime,


> Hmmm this patch seems to have broken pretty much all the boards I'm running that
> boot with DT. I'm getting logs such as :
>
> platform 16100000.serial: Failed to create device link (0x124) with supplier
>    16000400.clock-controller
>
> Some are just hanging at "Starting kernel..." from u-boot.
>
> Then boards go silent as the uart dies, and I'm using that uart to access the
> device's console :(
>
> Found with a WIP stmmac runner for netdev CI.
>
> Unfortunately I don't have much logs to share, as this just prevents the boards
> from booting :( With this patch reverted, all boards boot fine


It is obvious I did not understand well the implications ...


I think the supplier device lock could be the problem behind the hanging 
and how the supplier initialization is checked now based on the driver 
bound behind the console issue ...


I have a couple of embedded boards to play with so I will try to 
reproduce the problem for getting more info. FWIW, all was fine with the 
server I tested this, no device link errors at all.


Thank you for testing it!



>
> Maxime
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/base/core.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 4c0c373998a1..eb6d87e35d76 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -834,15 +834,26 @@ struct device_link *device_link_add(struct device *consumer,
>>   	device_pm_lock();
>>   
>>   	/*
>> -	 * If the supplier has not been fully registered yet or there is a
>> -	 * reverse (non-SYNC_STATE_ONLY) dependency between the consumer and
>> -	 * the supplier already in the graph, return NULL. If the link is a
>> -	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>> -	 * because it only affects sync_state() callbacks.
>> +	 * If the supplier has not been fully registered yet with a driver
>> +	 * return NULL.
>>   	 */
>> -	if (!device_pm_initialized(supplier)
>> -	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>> -		  device_is_dependent(consumer, supplier))) {
>> +	scoped_guard(device, supplier) {
>> +		if (!device_is_bound(supplier)) {
>> +			link = NULL;
>> +			goto out;
>> +		}
>> +	}
>> +	/*
>> +	 * If consumer asks for PM to use the link and the supplier has not
>> +	 * PM initialized, or if there is a reverse (non-SYNC_STATE_ONLY)
>> +	 * dependency between the consumer and the supplier already in the
>> +	 * graph, return NULL. If the link is a SYNC_STATE_ONLY link, we
>> +	 * don't check for reverse dependencies because it only affects
>> +	 * sync_state() callbacks.
>> +	 */
>> +	if (((flags & DL_FLAG_PM_RUNTIME) && !device_pm_initialized(supplier)) ||
>> +	    (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>> +	     device_is_dependent(consumer, supplier))) {
>>   		link = NULL;
>>   		goto out;
>>   	}
