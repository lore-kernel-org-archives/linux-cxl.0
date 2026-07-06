Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B353ECBD7;
	Mon,  6 Jul 2026 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321046; cv=fail; b=MEOfUgN8/Y0bW9U6Vj9BXbhTLGTUIftAxhWpvJiI/stf0gnnuNe5fdSoXtGJe6zwsed03YdKB1K2NB3f6pTcCbli/i3a8gwhaX9e2WzgddJRczDuBk0bnhU1L5OGEEN+rsQGo617c6+MkTTS1C7VLn7Sdm+tW/v15W+0fltfVXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321046; c=relaxed/simple;
	bh=06SP8GGHzA0KXU0GTGeyK70W7kOrWB2/EGfiFI8CPHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WAYOGdmIzBPPEXSvujcTooUyNfBcZo30toBQmuOVyGnY2Qzr553HSTcdqF6KF/jn+VSr3CYNrWTgCRi4uc2Qx6RHFvUQuh1Aeu49u9zgkwF+QjamOKAqEf1qSHvGSbjwOp97pZNNmvwCBr6JCxz/Hqm5czVIheiTXH3PbgvtjkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PLa/EPwB; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PLa/EPwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhXiAhy1lkrTHpLIJBsS/GCWYwgxRyYgcYwv7FE5LFyjDkWVKwD/V2uhK20KF8avd+JYqs060BFdF45q9mzfEfj9PGkrTBLW9jb4xUSM8CpNQggGUSnD55V4dwbLlhTVNHRqladAIXGuBbbPvK5BQg39WIXx9Z1lTreopfFIZVKh+7UUwVBkbSCQyYC+H2JnE7h6v0Q3RHEvUYpj7TWHmXocRG+4HaT4F5yw9zB/CGP+hdds2+DnLztTEnEFFmmZj/cJ9FivRqRsc5GC4t/KYw+tmoP151kuiTFqpFYLmf5LZVcGmC75P08HMIRXYzTcHKmJxGUKXoVGgbcwk87lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqqZFB7Iu+8RPQobTpoPCSHBqijpVjIo8npSJBxauts=;
 b=tizdqjTX+qIFVlCrt1v7/Bg7TbOb5T612WSAf6vthYwxMgxh6BvULQOt63R3IVbnY7hBXnmUlMbODz7t2Z0ejn6SnpZ/QO4uzd4A33J151qBl5LyoknqjGq7CuA8Q7pp7J6eE0IFqo/REvWbFDbNS8KldfP45MS0VaE9qinjimVOqmvPCXO83958YXLtFUsq2tlzQ5mDapC7xO5BGP+2uW8H5cJfflGjKRN/P8y78Bq7X7uRcG1nGtjHhsLBoWseJfF3/rS0D53q9aIfJV7LrA2tWaZjXkSXI++5yt3qKcli37p5lGStqejxqkkGoniO8EbXCVb1CIWXirgwND7OAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqqZFB7Iu+8RPQobTpoPCSHBqijpVjIo8npSJBxauts=;
 b=PLa/EPwBmReGjY5ga1leKyCSoVWKLKI93Jx0JM7MvgP1euhURg03nnQzvyDmHjfO8JxRst1+N6OZmOYdQ1ecT/6aK37xb1jIZx2Qbze4kuA53rZDcEB7te4xU9eXGNmmx0vUL34RPs2mJqP6lNnpDgXeDsFQ+7pHWAzcTyS+944=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 06:57:13 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 06:57:13 +0000
Message-ID: <c88a09b4-6478-4c68-87f0-485dc6634af2@amd.com>
Date: Mon, 6 Jul 2026 07:57:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier
 block
Content-Language: en-US
To: Richard Cheng <icheng@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
 <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
 <akYPrcsz2tWl7ga4@MWDK4CY14F>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <akYPrcsz2tWl7ga4@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 140b28fe-7593-4f63-8cbf-08dedb2bcebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	F19HExQ/ipixRkc5UvCo++l+ONS3z7dzKwrq3zrORZap5ly6dOT1NcfnQWYL2vpDSQJS+NZuazwtVZ6ssFWCX3k8eiKFfZ2z1vDyeMyyA/X2WKZdOQ4FI2oJrZpx++cZL1ENdhRCyoHADkyjmXd+C+f2Loby0gmTgTBFWuoE6NOpE/aYu0EIUQql1KN4kLESBAPy1kbgdTamag/T3myN3tOCqVylXbtJAdSrlisggelWwTs/Ruy7APK3rNx1r/8T0AtXO0D2D9zeaF/qGIgEi+f5KWpvtOFVjMXE4zUcoXS+mI/rePeiq1fbpikhEqP5spkaH/B082CEbWb7QfsS3QUtIFYFWBEzE/WoXjUT+z0ke5SeXZt3An7I9HFRKKVmWas0BmNd/0tL9aHaNYbuqIW7kYHzQzKYikpWPjgyd7zkNEbiBWyMu9Kde19tQM2ZkKjgP2b1U/Dk/eRDykQASUlWFlUSc/r5K0TGgAF9XFrdO6L0qzX3U3Mw4tm10Kuw9Yl3PAhnUjyXRQNnC+k3xK2TqiDsQRpXKoAb/6cQdyeAwfAsVHRo3HxWkP1kS1r7kHXyo67S1gMRy/kzGnTZo6PchaAvaRpqneRHhdRj7TVdwMaS8DvipPqie83HbVZ1cRSl2HcS6qBun86UVnhUlHHV2GZkzH5KkZtoi599GeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTM4ZTFWK1pTd0Y5S3d5TXJ4T1dESmNpRUFTQXNNQ25WMnVjUCs1WTVCUWtW?=
 =?utf-8?B?d1lMUmdqQm5tQy96Ky9Vd0RDc0V0YkJPZVVMOXgwOWQvd2orOVFnRnYzcHp3?=
 =?utf-8?B?OWF0VThDUitMdUJwWWhPc0pzRGJocUE0RllHWEpUVDhWOWxXc0ZPVll2YkxZ?=
 =?utf-8?B?dFdWWEd2clRRNlpza21WeENLZkd1Zko1YitxZ2JHRGlXWGY5a3BSU2JXZ3ly?=
 =?utf-8?B?T0pXYVRiNFdUSFIzMkxqMUpucHl1cEdWYS9WS2YzTm9Qd2ptSVd2Q0FVU0RS?=
 =?utf-8?B?UE1oTGExR1hJdnNaL24vb1BiK1FmYVovWjZnNE9XT29xUmlkaEtWdFV4QVZM?=
 =?utf-8?B?RGxlajdYRE5rd3JoM2E0Ylc4ZzcycVcvdWJKamkwZldJeklVN3RuL01zQUFH?=
 =?utf-8?B?Qk4yVWRCdlVubmprRnVGTFVDZ2J1TWVWc2xDdk4xTFZ6WStlaGJiaUtlbUIy?=
 =?utf-8?B?WHFlTGlOUUhyQTNHRmlSYjdHTUdmNXdVZ2xrL0JIU1R0dDlrOG8ycHRrQ3l5?=
 =?utf-8?B?dk9ONk9wcEttVzl4UStNb2JPY3ptbjlxZnVxMDZGeFRSYzNMdi9OU3hKc3JB?=
 =?utf-8?B?T1EzRE9LRGs2QjdjTXlaNGFNZmtqa0Jtb01jVFVVWmRycjFoTHR2bEVuSUtO?=
 =?utf-8?B?MFU4Ylo3aDZzTVlNeWJWcU1Wa1g3dkg1RnMyenBacE85aDhKaFRKMW4zUDY0?=
 =?utf-8?B?cVM0bGtBMk9kR0FPWk1wa2RFcXpmK255WWprK0ZJQU1NdmhOaW9yWCs5N1M5?=
 =?utf-8?B?UnNpMEY2cUkvbVFTQ0VEWVE0QU9OL2pIOGRiSnp2aDdnU2pPV1AyMGxvb1Bv?=
 =?utf-8?B?Um5ycFV2TEsrZkNPYkcyTjhTaXpKdWFrRWN1OW1hYUVldExwcWl1SzNTNjlk?=
 =?utf-8?B?K253UWhuYjVzTW4yVVEyaTZoZXcvY21kemkyY1BadFhLUGxUaWVJRlRiSURN?=
 =?utf-8?B?eSt1cGtZejVEait6UzRWQ3VIN28vcktBRE5ZbXQzb2svSGtSK1pqT1JNMzZE?=
 =?utf-8?B?a2Z3TzVBb01adWZzd2wwZ1pMUklJeEFReDhxWkhnSmhKQUZZS0FaKzdpWTZH?=
 =?utf-8?B?U1hrNTJVVGVyZVVZVDRwSUY2aHdURVBqZlUyVUVsRUdwYURpN1RTVmZENzVl?=
 =?utf-8?B?RW9oREcyV3BtRkFLNEdlYk05bzBUdkpqdUNRS1IzbnIxSC9pTnIzRDFLTktv?=
 =?utf-8?B?UlYwcGpaYUNrZjBEbERlaFpaNktNdkt6ZC9qSU5SRW5wVHlYVE81Q2VvaGNQ?=
 =?utf-8?B?ZVNFcVk3M1ZCYXFEaWFacklGVVF2bU53MDVYNmlIc2NycWFhajBlUWU1VWF4?=
 =?utf-8?B?NnVQQnZzYVcvck5HVFZuVkt0bWhVOVA2ZzIxQTBSa2gxTVJFTDlKc2hDMVNP?=
 =?utf-8?B?VGw5WEVMb082TStmWU9ucHRXL0d0YUR4enJCNnNmbWNGMS9SK3NpbzlUaWs5?=
 =?utf-8?B?eVZEa0RMOGxzOXIwQTFHUzBQcVVHK0twV2JrMzlWZ1FGdWpmR0lNL3EwVDdi?=
 =?utf-8?B?d01EZDNWU0RFc1lwUkR5QTFkM3IySldSd21OZXREQjRvU3hWVVE5eXh5cmZK?=
 =?utf-8?B?cmVQaHN0ZmpGNE1Ob0duUjJsYlFUSTM2aEFaWEMzbVdYRmRHRWFsQjRZdmpr?=
 =?utf-8?B?K2xqQTFISUttbVdsNEQwdDBVT2lSMEZrUTljbUNpRjF1VFFiclo1UlR3WHZr?=
 =?utf-8?B?UGxnbFZ2RTlTT2hnWEJ3SUpjR0RCQUtlSVZqQ0doQTU5c0NOd0l4OFV0VHRH?=
 =?utf-8?B?QWt3RjdHQzhjNk1GendoeTVEcDNrRG1PWGxSY2tpWUdxdlB2bEVZSmdIQmtP?=
 =?utf-8?B?SEhScHNxYlRNbGQ5d3U2UnNocTUyc0xZREVwbEdidC9aUlo5S0tuaWhsT1lM?=
 =?utf-8?B?K0hsNW9lOEpjRkxJbFVEL2gyeEc2NmZSYVJzOVM0Z0JicVFOcnpyeU9hS21w?=
 =?utf-8?B?L2VFOVg2Zkx3bkt0VHpWQ1dSMVRQK3Bqd2YwWDNueDJldkxoajBBVFBkSGhP?=
 =?utf-8?B?M0ljT2NVUkEwQmMxMzFkV1hWVlRyMTNqU0g3ZytuRkgrcFp1bFBOc0pwMm1u?=
 =?utf-8?B?VktXeVBDaEdpVEZPZ0l6WGFVcUVnVkhpNHdVbmpGZVpWSVFJVGRYREd0VGRS?=
 =?utf-8?B?cXBvcERQTTdlVDBycGNZajBNQ3l0enpPWGxxUnlDWkZRc3A0ZlErV3VYZTNP?=
 =?utf-8?B?c3puY0c4SHZVQWpzYVF3UFI4eGJrQnlNOTloT2Q5V0MxcHRvM25xVjgyTXJR?=
 =?utf-8?B?RVhZL0FZNzVtcXRlcW9RaHlIdml3cG4xQ0M4UkRLUDljcE1jQ3psd1Nqa2Vo?=
 =?utf-8?B?VFkxQ05IV2pHMzdjSndZNGZsbUV4Uy9LR3l3SHp0VFNxZkk1UVFIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140b28fe-7593-4f63-8cbf-08dedb2bcebb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:57:13.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vkWCr1rUpHulN9mwiDsYyOFI1XQ6Y6QDDr4nffoACdy5XO/lHN8qC4Xc8tdhresyAJC5VcW9dkG06nTFEZlUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468


On 7/2/26 08:20, Richard Cheng wrote:
> On Tue, Jun 30, 2026 at 03:35:07PM +0800, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Remove __meminitdata from hmat_adist_nb declaration preserving it even
>> when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
>> registrations using register_mt_adistance_algorithm() will find a
>> notifier chain likely corrupted. This is the case when a CXL Type2
>> driver will load after kernel initialization and a CXL region created from
>> its committed HDM decoders registers an mt_adistance_algorithm notifier.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/acpi/numa/hmat.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 9792dc394756..3006789ae31f 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
>>   	return NOTIFY_STOP;
>>   }
>>   
>> -static struct notifier_block hmat_adist_nb __meminitdata = {
>> +static struct notifier_block hmat_adist_nb = {
>>   	.notifier_call = hmat_calculate_adistance,
>>   	.priority = 100,
>>   };
>> -- 
>> 2.34.1
>>
>>
> I think this is not limited to CXL type 2 device.
> cxl_region_probe() already calls register_mt_adistance_algorithm(), and CXL_REGION
> depends only on SPARSEMEM, not MEMORY_HOTPLUG, so with NUMA=y, MEMORY_HOTPLUG=n, CXL_ACPI=y and CXL_REGION=y,
> any runtime CXL region probe walks the chain. I would suggest some tweak for commit message.
> Also adding Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")


I think you are right. I did say it was not affecting Type3 because I 
was assuming only Type3 regions created during CXL core initialization 
and cxl_mem "active" before after-initialization kernel memory release. 
I will add what you suggest.


>
> And maybe keep unconditional removal rather than a consumer-keyed attribute.
> register_mt_adistance_algorithm() is callable by any runtime module,
> not just CXL, so a CONFIG_CXL_MEM-keyed condition would  still leave the hole
> for other callers.


Not sure what you mean here. The way I understand your comment leads to 
contradictions ...


"keep unconditional removal" suggest to me unregistering hmat_adist_nb 
but "keep" confuses me as it is not unregister now only memory released 
based on __meminitdata ... but maybe you mean exactly what I did and 
avoid any change to __meminitdata declaration based on a config 
attribute, what is what Dave is suggesting to explore.


Please, could you clarify this?

Thank you,

Alejandro.


>
> What do you think ?
>
> Best regards,
> Richard Cheng.
