Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF7448BB6;
	Thu, 24 Sep 2026 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240398; cv=fail; b=QT0bi2xq+hBU9rio+IyQ3UyHedGaGve+sz67Ipzz/xxarLkx35WcRW5816Ds8OxMGLKliqKqv3YW0xEJzIjCDgYnVAmCRN5OLe5pTy1egw7OHsJW9qWBdE7cr/dKXM4bEcs+CxnbcBJWyqdmb08a5tkgQzv5Qn9t2Qlr/bKVH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240398; c=relaxed/simple;
	bh=p8xtrAMDPM/HGeVcl/HJnagfcZfG551Yy0Ws76LlTcI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYxLQ/DDDqS/Ouwns1SaGuCkVAYm9h78ZECmmV68W7ehNf8qusZaR8X71btJ0wQuvOCCZHcjP42BnFNVRT07iK9M+bKoEKgU7CVBciB5nKBlpIEtc+KE3JpgU4ItT8/bRWiAQ+8vZ7Dtuk9xPpAbkHyOY7jrHtqgNA+eDxuHMA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFOvHh4O; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFOvHh4O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/5kxpOECzRBaWb3hVCa201SgpCkDakaxdohj0yo3rdMEtWF5aHMN9N1LO3KPRBIi38UzWTf5AKAN9GyCoNLEB0WSJROSn71HW50flzAf9ry9q5TXBNS8m6tIWf9FnG2+5DjKK7vXC8HnJYDx/oBZ73dbIu6jKzJCevUY5Th9Afdc8uGXa6WHvP5hX6eTW4e9ZCMYXELdtmJCnz+XEGSugOSiPUtgl77LhX7/6dRvuC+w+xOSWpfsAGwFjM4sbuD9sCFm2znkbhP0SjsiZl09XyX1wvGQav1SIZNYJVgJfdAOwu2KQp6Cy/wv/KbxF5sigLBRAXust3Gc6I5BGDoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3y9OGj4aTsmm9kM+ENbJjz7dcbxws9oyVQm/yypd1Q=;
 b=gViL07HidZ0/thuGjGIjf9Br+MXms6yOo8chwU9JYvL2A/tCil808bHoWEcDzMqlu0Dd+g/Cpbrojyb0OS9tpnFJRsnzwQpDTnWan8hr+zCjlUSFeUu+CMfx4wNSykZt8gsJSgtOZcWtYCnxE1gJX2HwSZqvb75nMvayHxhAfoR9P1r6tXGJLPxSZY+AAZ0HWvChjqnHMFTh8IxwSsNeh8dmf5hNPoIhkQterNwa2KMH2soVx4qDCDw/itokb77AZNudX0uRpuLS7g4COM8yzvuykwHfCU4RJbqtJ2Ti5EguPpdxcBVartkhe4yA/bM9jLRdwhajN0ZmozAUqJAGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3y9OGj4aTsmm9kM+ENbJjz7dcbxws9oyVQm/yypd1Q=;
 b=VFOvHh4OVUUmKdcjWQsdcpqMEQl676ww/SfpclP395FdXGgkQTqAXxpsZ/lwJmDZyqd/vKnUdy1oSQoxtT+FolhGTIw5y2LFQdm8ppENrmwdxZJFQKirxrzL2yRkPomi3XW+rxLvJw1jyAR8DD4fWZa1rgFw4oD8ZktTmRk5m7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Thu, 24 Sep 2026 08:59:52 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.018; Thu, 24 Sep 2026
 08:59:52 +0000
Message-ID: <574bd4c5-62a1-4004-9b35-21fc05b5a2c1@amd.com>
Date: Thu, 24 Sep 2026 09:59:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] driver core: Rely on supplier driver binding at
 link creation
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-2-alucerop@amd.com>
 <2055ead9-201f-4878-aa09-07d7fc3ab3c2@bootlin.com>
 <3ab9bc66-f3b3-465b-b736-09df1da2fcac@amd.com>
 <5e60ed2c-b50f-4949-9edb-ede80436f501@amd.com>
Content-Language: en-GB
In-Reply-To: <5e60ed2c-b50f-4949-9edb-ede80436f501@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0123.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::8) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: fde42373-2bbf-429f-3f64-08df1a1a3201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	K9aIwL4iL0r7a9z42cewS/WR7q2BlSgG38MjIdi2xCTvOKye1kcfvqkMLVAGJBCNfCi1JQ0cYLE86sBsxTYg0TgBe34pq9aV6UmkaevPH00XSAXY76xQSFzoSOVmvOiW6mC6sjTFdzfdOzNqRlD2OLD3NzgSLA7XP8Kl9CooTyIlRAW8z02jPZgNGjspHi1Uvxf1gqb8Xh+sG+0W+U029sCc8kalqfaktfrE59Xq0pXqKOw95vN03zqtk8ZIQW/ARMD95dm+Hj+d5LPD2to+//Q13VfFOfHIoF6X9VDSNsZGI5EN5ndhV47HSI+nh7fhtzrDOMhiURbENTzFVvlzofioXFan+E+YdNxwc+iUAYbtaatD2NfnVsXq+6tmmDIXE35notMr69AcAoLT/c+UYd8mktWq6A3qKkT5EG8UmazQ2Vim+QcZ9uCmBTQh/yJzOek/0UNBt1+K6ev1orlJ97ETZkwhFoHJpcI8fCC6evmNIsNpKN2PxnF5fbl1w5yAvaMO1o/mngoT4pMZULgPkEtkiHW0vlDBYc1tT6lOSIjBaBvBaNJIF6F6o/e0aZXXO/rjm0G3vMLLM80Cz6l3wsyMz7XyToPIdv1kYq1pfc/E7gy9YgksXDq6CXs7M5MvuBnH5Ri7WVeIGFXGS7g2HtEJwEG6cZN6zf8HIiH3oGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RpTy9kdUZyV0RRUmsrcnQycTU2dXIvNElMdmowQnZwNkNWRVZpOG82ZUNB?=
 =?utf-8?B?RHovNUJ0WVd5V1cvQlJKcG9LZDRYUnFzR1hFTCtQaFV1RU82L3hSdFhtZnM1?=
 =?utf-8?B?VXhnNmFMYnhqb2VYUWtlUGY5RjE5bjdXeGt0UW9JeVFnQVZtNXd6UGFvNGx3?=
 =?utf-8?B?TzV6SEljcnA1emlmWGNrUGU1WjNlTmN2Z1MwMUJTamNoSUYxNGZsTTYybTJr?=
 =?utf-8?B?UlZndFdjQzVVRzhKSGJ1blFLUURud3h5VzNRQ2VTWmQ2Z2l0dGJvK1FUdkQ5?=
 =?utf-8?B?czYrN1pmZUFYLytrRVFPUkRZa0R1eitnd1Flekc2RGJRUVQyMitidVJtclp0?=
 =?utf-8?B?NXI3NG5oZUFqZGx2UGZZUENZbUFORTMvNVQ0ZGg1ZG9vc252WWVzdTRSQU5x?=
 =?utf-8?B?SVg4aGx4bWFUQjhKVUhjT2x5OGV5VXRNT2JPd01XZ20wSGZGM1VUaFFQUTNo?=
 =?utf-8?B?aXF3MmR5MVdqcVF1NFAxVGFjdzYvM2FlSHZqZCtneXdQMCs0NUh5ekFBNlJr?=
 =?utf-8?B?Uk5vZFEwNzdvMjNwaFVHZGFZRkJJOXZncm1leS9SaWdVbVZCemVKN0k4VjZm?=
 =?utf-8?B?SHF3TzNlc3k2UnF0cDFZTndZcG9QUmFvMG1VZGtGY0lzaGhpZWo5dXA5bGVp?=
 =?utf-8?B?bDZweVZPWFV3S1dNQS8xVjMxTy8wVmJ3TWVxckV5eEkyQ0VxNzh2Qm9GK0xq?=
 =?utf-8?B?YUVrdUVBNDUrc01IQUlaRkVaZDgvRDZzVnh5NTF0b0o5MytJcDYwZVBaTi81?=
 =?utf-8?B?MmpSSldTUmlndjYrRmRoRGZ1TFA4NHJsTzl1S215NU5MZURMUW1BT2pDdG85?=
 =?utf-8?B?T3E1V3p6WGdRcjlFS2ZWd2xYWDhWa2pRMU9YMWRXOVNHZzFOWmdPek0rSG1p?=
 =?utf-8?B?TExLTjZWNXc1aDdZT0paTnJ5VnBpZ3pJK3hmTDArUTVZRVNwdkxrMTk4VmNl?=
 =?utf-8?B?QzVRQzJXd0R6WWxPRlppdlVVUVlzZUhCME1sQlhtdEJpZm9KeWFnbUQrbEtF?=
 =?utf-8?B?Y1ZkdERMUHRyRm1yUXNyL2ZuZ1NwNGZieWZMZVJDRXVZV2FFOXN5eTYvZGFo?=
 =?utf-8?B?dDdXcmxlZm5JdVFrbWFUdk5EZHN1WW83enpmeVlRcEpidFZDK1RpN0t2ZEVa?=
 =?utf-8?B?a21QYnFGQ2JST2Y5NXpVOTQ2dUp3dEhXcDRycWZtVW5NWmtBSUJRR1pIakpP?=
 =?utf-8?B?Qk05QXJyQlFTRmROejVmd2JPbjBaTkRpVkQrWS8zbUQxclAva0NjWThBRmFF?=
 =?utf-8?B?SG8xa0VYR3BqVWNmaVhsZ2NQNWZiS3pOY0s4cUlpbVlYZEZ5L0VuRS9xR1FS?=
 =?utf-8?B?bHJyYjVQbHpIMjVkT2w4UG5abmpJTWJJeHROSy9XU01kajUxNTVHajNRRm93?=
 =?utf-8?B?TVNWK2lVcHlqZVk5UFArdHd1N0Z3d3RORjBicEU5VHUwNzhFeFFVeVRMSzgy?=
 =?utf-8?B?MXZaRHNtdUdXbHlQQmxsamNhVkpKMFlCRWZZR0RudGVKdzU3RlpEV3BlVUVY?=
 =?utf-8?B?U2VXamtKaDBHUmV5MnU3Y3ZhMWlNc0hOL3Z0aVZzS3ltSHFwMXo0TkRoaEFD?=
 =?utf-8?B?dy96ekhiaXh6bENrSUIwRWZWMk1nazRJQXNQQ2VOT1JOZU4xN0FRMGMrdU96?=
 =?utf-8?B?M1FSaFBzTnp6YVEzWE1SVGpybUlTSjBLVzFvTXZRdWJkV21xT1NxZnBtcmcr?=
 =?utf-8?B?R3lZMW5KZTl0alpuMWh3RWFBWExpbi9vQS8wcmpqaEYrV3hhSFhSUlZ1eUlJ?=
 =?utf-8?B?NjZrWjd6YTh6NjlkcTJ5SlBWekgwU0RORGVmWWJrQ0NEOWZHdmdGb0g3bGNP?=
 =?utf-8?B?WjhtTTRQVHc5TUg0eVZiVWJRNEZFVlNFT1ZQNnpuME1JS0xwbW1yeGdSVUcz?=
 =?utf-8?B?cFFjQ3pTK3dRQUcxVXhyT1pISTBwS0l3THh4aldUMkR3SmZRZVd5ZmhwTzZF?=
 =?utf-8?B?YjNmaTZTM1dUUE1sVk02cjB1aVlLNGhlR3Z5ZlY4dUNUQ1BOKzdaZHgvSjR5?=
 =?utf-8?B?WW9hTG82WTlITmUwYTBXd05Mbkl3RUtoNzBVTXQ3MXM4QjhWUE9jVEtxckNL?=
 =?utf-8?B?dnVWcWkxMmJsZlRYSUwyUVBSaTZlMlNNUlpJUzl4VDBrRis1KzdJQ3Zwd3Zq?=
 =?utf-8?B?ZDNKMlNRVG8ybFowWHF3UXVOalhHWTBKYUFNQ2hzZkk1ZkhidjdhdXhBV253?=
 =?utf-8?B?MWtyYnJMVC9WOVM0WnV2MEJVc3BKSFV3djVwOEJpRW15V0FkL24rYVhMWm5o?=
 =?utf-8?B?bWdZR2VJYzNDQlBKTytmL25ieHQ0eG9UZVE3K0V0M0VlRXhyL1lZT3hUL1Uz?=
 =?utf-8?B?Yit3RXpGdk9jTEhPbEtPTmJnek1FNFF2ZnJNTjhRclhoZVF0aWp1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde42373-2bbf-429f-3f64-08df1a1a3201
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:59:52.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGAV6P3aE91VWMcwvCqkPWRaiwALN6Bwma1PvHr6srdTYpqINljhg7+Mm8MREsHQAiwkLyFU+tWT+SztTlvuxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183


On 23/09/2026 10:58, Lucero Palau, Alejandro wrote:
>
> On 23/09/2026 09:49, Lucero Palau, Alejandro wrote:
>>
>> On 22/09/2026 22:39, Maxime Chevallier wrote:
>>> Hi,
>>>
>>> On 9/21/26 21:12, alucerop@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Differentiate between driver binding from PM dependency when a device
>>>> link is created. Rely on the device being bound to a driver for 
>>>> validating
>>>> the supplier as some device drivers could not support PM.
>>>>
>>>> Check for supplier's PM state only if consumer specifies PM_RUNTIME 
>>>> flag.
>>
>>
>> Hi Maxime,
>>
>>
>>> Hmmm this patch seems to have broken pretty much all the boards I'm 
>>> running that
>>> boot with DT. I'm getting logs such as :
>>>
>>> platform 16100000.serial: Failed to create device link (0x124) with 
>>> supplier
>>>    16000400.clock-controller
>>>
>>> Some are just hanging at "Starting kernel..." from u-boot.
>>>
>>> Then boards go silent as the uart dies, and I'm using that uart to 
>>> access the
>>> device's console :(
>>>
>>> Found with a WIP stmmac runner for netdev CI.
>>>
>>> Unfortunately I don't have much logs to share, as this just prevents 
>>> the boards
>>> from booting :( With this patch reverted, all boards boot fine
>>
>>
>> It is obvious I did not understand well the implications ...
>>
>>
>> I think the supplier device lock could be the problem behind the 
>> hanging and how the supplier initialization is checked now based on 
>> the driver bound behind the console issue ...
>>
>>
>> I have a couple of embedded boards to play with so I will try to 
>> reproduce the problem for getting more info. FWIW, all was fine with 
>> the server I tested this, no device link errors at all.
>>
>
> I have to amend my words ... the server had not exactly the same code 
> :-)  I have to copy things in and out due to security measures and 
> sometimes is hard to have all synced.
>
>
> I think the sashiko reports could be a good start to fixing this.
>

FWIW, the problem seems to be the scoped guard. I had a plain 
device_lock for using device_is_bound as required then device_unlock 
after it, but moved to scoped_guard blindly ... .


I think for my impending multipf support I only need something like this:


--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -761,7 +761,7 @@ struct device_link *device_link_add(struct device 
*consumer,
          * SYNC_STATE_ONLY link, we don't check for reverse dependencies
          * because it only affects sync_state() callbacks.
          */
-       if (!device_pm_initialized(supplier)
+       if ((!device_pm_not_required(supplier) && 
!device_pm_initialized(supplier))
             || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
                   device_is_dependent(consumer, supplier))) {
                 link = NULL;

but when I studied the code I thought checking for "the supplier has not 
been fully registered yet" was not being achieved if the registration 
meant driver binding, what honestly confuses me because checking for 
device_pm_initialized implies looking at the dev->power.in_dpm_list what 
seems to only happen at device_add time ... so I wonder how the 
device_link_add could use a supplier device without device_add completed.


Anyway, I will go with the simpler change posted above in v2, and keep 
studying the other potential problem not directly connected to my 
multipf support.


>
> Apologies for the any inconvenient.
>
> Thanks,
>
> Alejandro.
>
>
>>
>> Thank you for testing it!
>>
>>
>>
>>>
>>> Maxime
>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>   drivers/base/core.c | 27 +++++++++++++++++++--------
>>>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 4c0c373998a1..eb6d87e35d76 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -834,15 +834,26 @@ struct device_link *device_link_add(struct 
>>>> device *consumer,
>>>>       device_pm_lock();
>>>>         /*
>>>> -     * If the supplier has not been fully registered yet or there 
>>>> is a
>>>> -     * reverse (non-SYNC_STATE_ONLY) dependency between the 
>>>> consumer and
>>>> -     * the supplier already in the graph, return NULL. If the link 
>>>> is a
>>>> -     * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>>>> -     * because it only affects sync_state() callbacks.
>>>> +     * If the supplier has not been fully registered yet with a 
>>>> driver
>>>> +     * return NULL.
>>>>        */
>>>> -    if (!device_pm_initialized(supplier)
>>>> -        || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>>> -          device_is_dependent(consumer, supplier))) {
>>>> +    scoped_guard(device, supplier) {
>>>> +        if (!device_is_bound(supplier)) {
>>>> +            link = NULL;
>>>> +            goto out;
>>>> +        }
>>>> +    }
>>>> +    /*
>>>> +     * If consumer asks for PM to use the link and the supplier 
>>>> has not
>>>> +     * PM initialized, or if there is a reverse (non-SYNC_STATE_ONLY)
>>>> +     * dependency between the consumer and the supplier already in 
>>>> the
>>>> +     * graph, return NULL. If the link is a SYNC_STATE_ONLY link, we
>>>> +     * don't check for reverse dependencies because it only affects
>>>> +     * sync_state() callbacks.
>>>> +     */
>>>> +    if (((flags & DL_FLAG_PM_RUNTIME) && 
>>>> !device_pm_initialized(supplier)) ||
>>>> +        (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>>> +         device_is_dependent(consumer, supplier))) {
>>>>           link = NULL;
>>>>           goto out;
>>>>       }
