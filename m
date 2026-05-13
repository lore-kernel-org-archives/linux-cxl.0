Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46733A6EEE
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696353; cv=fail; b=Pxp+4otxU/uLVXEaYvhv0h1lwabZ9OyxV3SvDJCwkUZOcNWPj+OF7yuRmkh8F7CWLcuifEQJyw0h8/6L5PE02pm3phW2iVBBidCvIybDdpr4Hwxv9uUUxaBdIKETetMeTHzLHA6IKl1QsMjuw0vKI6AlFChkBj63yQT/Oxyvx7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696353; c=relaxed/simple;
	bh=9W9MkjZtZwsrcz/qoJSiSj0kS6rEd5NgYAZcaClD91Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LYvhVYnKD7xv25GRomg1C2I7KIyyPs3WOzVq7WSzjtST70shXffHxmEho4GUpQ150hZf4rMRTc8YHZciRx7KgWUxMML0r+2Pevv1/0QAbcBKOPHCrT9MohUAaT44vcSV8BvTwXXRildq8dUcww/ZPfaEDwn3Cm/xCHkgm/jJmxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fgYvRyw5; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fgYvRyw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNAHP+byT9ZsU4unnmjr0r6QzhZLDFw8xTPQ/JlTLpva8t5YHra7cUSOJKUr87dTMKEmWaTCgi3d/2y0qZcFxA0Ufv/15LlPywjkGzEjyc1iWigBGrJY8ouqCrOKxkkzoR6FU+T4+TpByBhbtDzRJC1TJVXh4xZNjeYjahTD4jDOpDhtQMyewkZPoCXF1ockR2tn4AlVin5zrhTCJCqTGFdMMh7dA9ewh1sgDbIJwF931Qq0+ULTSQwxTzxQYW8VBjOyOQsdx7X0aIicj70IwhNjfp655yYVJ4yxZCLa40r6RBxupPYF/ZOZtCEiZm9c25ehAlSg5PIjv8VArZspoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iduGZ8jBYQUd1iPbXE/LDj2fXWFVgrfHctlGyXN2KPA=;
 b=nJYNK2lyyd4RSmQvGu3n6Suj7oTWM5xw/aKsQSY6EwaSXX4PMgkJnJQ2ihlrca41SZxHQh2LrPZgL4LblgWTttWTDh9q1zJSkvsM8MSm835jpClrh8m8I3+NqVJqw+1D4OGWqjv9I0ZkX0ohSideWL9TOqe10CLbg0dHgu44/JPovhAPM+JeOKcXxrfiW87kDR/+tlq/hv2EXUjw8S7JYiM0/ycdSYl23Ix0QeB5Ox2eVtNmgG97yeTedCqMPRwOhiPwKF8MKT5mzlSvLD0dzRYFOlAFVCEk7k79F9mQtRTHhMOpROODCRm3mFca7eUq7yiHqdrtyw8lfjUEX5RiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iduGZ8jBYQUd1iPbXE/LDj2fXWFVgrfHctlGyXN2KPA=;
 b=fgYvRyw5h3/HT2ZxbMOrUG4ZCsWxVZ9wfPD2j9APBv691AZqa2HQ2i6hcisd9+wiq5o8bF+buOFN3OPcUn80d03COO/a0wJln8pBW41xuc1SDch7cGVzWIlgorSYYY50Mq4EbjjbKYvaS7NaWRjSrtdNwggiOIL0dsQVC57nV/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 18:19:07 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::cc19:be83:4f32:d44b]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::cc19:be83:4f32:d44b%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 18:19:06 +0000
Message-ID: <6bcb82bb-5306-4448-8a59-6141c2dc5ea2@amd.com>
Date: Wed, 13 May 2026 19:19:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 7/8] cxl: Avoid dax creation for accelerators
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <daves@stgolabs.net>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-8-alejandro.lucero-palau@amd.com>
 <agSzpfQZmbNOMkc2@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <agSzpfQZmbNOMkc2@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::31) To CH2PR12MB4199.namprd12.prod.outlook.com
 (2603:10b6:610:a7::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 5224bb9a-b235-42e6-db02-08deb11c1e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|4143699003|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	8pkRSVmMF9LKcETSy8asJ96egclce5cLWTy0DT8pKe1OfFHp+Kml7DOlCoDTulFzd4M7J3jpKNAN+FYByUBEbDQ+Us9QJiBoH4rmS/uLQ5eaFhjIh1M1QxX7JfCRF89fTVjokgU/MfVrCu02QgvGK+XFqX866gbZ1CuSFdg3jaMKE59i/wZPn5t7NViV6haeX+pqmixlac4nsYULoPMV1+GaQw/S/kq96dV+wanILTL6hVgzOuDawN5YLbEW+o7GSEl13rGGRfSYnjmudNmhqPs7Vj/QRc7sJy9LyKHI0jwkYoIlj9u4JDEMwXOTUXS4Zc8/qscP0q/tWaWCZgWPQonZ7su/sSdFctLT6ViLUm1PT8IThZkdvsGecLObGLImtgzMQizqtY4zYrecL3SUBFW3tgpLPNs8p8d9GWjjp2TmEGH677fWWffl/WjbB/MXDFuAawspANqOKkxS4DxuBSeCxpodPT4FJG0PZsmRw87pvIQ/YiAxb0Uz3bye2kC/JtdNVhMX9iLXovSf+MFoAqFo3Saco+Q6C3s/X1fqhAm11pQhYIcqIF6ygQhgcv45mQtxSvCbaYAYQLZKMCqtPDdtCiBid06lJg7nOjzNUTs7nQzXaONm6SVxYhXVsdh9eowcmiQ3nDQWnUaoN4zQMelFH5u8KVUlkLRbZhjfO3jYp21oWspupzflm86/33Bk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(4143699003)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGUzTm5aRGFoeDMwaVd6ditOaE5FREZ0OFI4Y2w3eXNHTGMvd3labWJxMWJK?=
 =?utf-8?B?cXN1VVVFN0tQUlFiUy82WTFIZUJqL0RReURSVWV4U2ZVUlowSkxDM2RNM1Va?=
 =?utf-8?B?a2JCUXRPbXRTcVBBMWRNSzIzZncyams2ODI5dUM2MjF6WmtZTWx5NE00ZkFB?=
 =?utf-8?B?MWVNeTFtRVg1ZHgvbHFkNzI5YlBINWIyZzQ5TWpwVThEeDliT1NsQnBsMmhv?=
 =?utf-8?B?S1NwN0hBMXIyMWRVSDRZMlo4cUlVeHlZR3lKYzMyRWJNTjQyWUZzZDRtM1Vw?=
 =?utf-8?B?Y25OVk5BWXJtbG0vOEZMZ09FTCtYKzdFZDNvK1FEdVZzeHZ2bUdPZERvTzNN?=
 =?utf-8?B?ekpobnl5MGRjRDM5ZmN1OStaSUxERFd3QVZUV3d2TVJJaG5yTGQrT3BCZVNS?=
 =?utf-8?B?VDdkZG04dnVSTzR4S1NVcDJnUHJ2T1NKZkJNeTQ4NzRwUFQzRXdoVy9POVZC?=
 =?utf-8?B?MDlLNk40SEhWbCtIVmFRY0xRVXk4UWtxMUcyS3V5NGgwQm00MC9ha3l1alRX?=
 =?utf-8?B?clA3T3dHWHEwT09HOUdhb1p0d0hGejBONEtadktFd1RWL2U0MlNWcGJaUDky?=
 =?utf-8?B?dG9ObG1QbXRoVmd1a3Q3dmRqODB4VmZtakF5c21OaE5QQnRBamdNVHZQOWhK?=
 =?utf-8?B?TCtkdGJtNzI2cUtyMlI3YzdYc0dsUlNnaHZreFJYUHVublBOT2hBdWV5SzN4?=
 =?utf-8?B?bGRMU0xlNHhzWm8wU2tzUG80RTRUUDFtSHBOQS80K1IvVUdvaldFNFVNdVZH?=
 =?utf-8?B?UDVraVplV25FWllya0pXVnJrUWVnQnhHMHhVRTlYN2pITTVuUHVCeTZLYjUr?=
 =?utf-8?B?c0w3QWxQODBtLzNHMzVJSVNxc2ZiSjltVGhjN0I4ZmhjSE04cm03YXJVbW9X?=
 =?utf-8?B?MTU1VkR4Q3pzRWNCM2c4T3BHQTI5NFFFRDQ4M2psU3B5Nm1TUG5IbWNaUHZw?=
 =?utf-8?B?U0d1bjZLekl1bDJjaFVpcUF2T2Q1ditEOHBaWng2WW4yeGVuRjM1VlExSmJr?=
 =?utf-8?B?b0FoRU1kdGovUUNkSFBvUUxUb1l1RzZqV2pHVDdROGRnOHNWdk9LbEQyeFFR?=
 =?utf-8?B?ejdyNDUrZVMvSU0reVhpcjFyeXFuRE11ZUllQW0zUEpLKzk3SjByc0RYUFE4?=
 =?utf-8?B?bXZYSVVPbHpEYWU3ejdqRjhnQjIxVXNLZVZmVjRWeHJJZE4vU2N0TzUraWZ5?=
 =?utf-8?B?QnRxcm1VRGRFTkpYVGN4d0hOeDZjT2d6U1A3V2FVakJtYzdmNkR4MHFjVjRO?=
 =?utf-8?B?eEkwM2FqUXZTOXAzMFpYbUpzOENxVmRYQ0hLWG1NUUl4RGVob2w2Qm1SWkd2?=
 =?utf-8?B?Vm96WE5GZUpMUVZ2c09Sa3Nkbzc0ZExLSFNCUUx0Rm1mSDJZMEVubTNabzcv?=
 =?utf-8?B?U0duakxlZ0JKR25RK2cxUHJBMnc0cExoYXYvbVJrT2ZDV0VJT05SODZBWjJH?=
 =?utf-8?B?VFRSUy9iQVVqRGpwSzFRQUlQY2FSSURpMks2YXB6VVAvRXNFTHRiWkpoUjYx?=
 =?utf-8?B?YkRsOHV2VHAyeTVQV1NmS0NXV3lrRWJYd2xlbjVHWGhlVXY0TDIrRHJHTWZW?=
 =?utf-8?B?VUEvS0FsdU1xeDM2bTJHUk0xMy9VaHUwV1ozZDVoVlBERTB5TW03V2d5dmU5?=
 =?utf-8?B?WWZsdXBoMnlZTkJMdkQ0ZjJoekJjbFVPNUVCSFdSaUpzRE02SzFSTGdINjlY?=
 =?utf-8?B?YldMSU4rbGVxSmQ5dTdnL0tNNkJHSzZydDEwVDJXU0Q4dlYrT240VjhBNEhk?=
 =?utf-8?B?b2w5R25mN0tZOWlBSFdHOHRYbTY2eWJ1WjNjMjFvanQ5MHh6T2kvZ2V6SXVQ?=
 =?utf-8?B?eVVBcU05YnVDVVl6RzJ1VlpiSkk3UWhSSElZV1crcEVOTSt5TW94U0Z5aWN6?=
 =?utf-8?B?RElLRGFMd05RWVBlSk5KSzFKRXM0VjdYUldjT1RyaGJhZzdnWW5CZmMvUGFM?=
 =?utf-8?B?VWdpUlZWbUFPOGwrTm4zRXBOcEdxaWhlaDRNUGhBVTFyV2tTbW1GUlZndDhO?=
 =?utf-8?B?Qndya3ZFSnoyQkhKSGxjelBmbmc1aExucjJIV0N2bktLenZPY1FpL3VvdEJs?=
 =?utf-8?B?SVdDUWdqeDVQajVaMm9rakJUNjArZVpHRGQ0T1dnVC9hSm5ZaVhRT01QRGlO?=
 =?utf-8?B?d3JPM2xwYm40NGJCMmd3S0w3UkFBcHFLUXE4ZG5QS21TcGxaaFpXZTRiNGNR?=
 =?utf-8?B?S3U3dU5CU0lTWXZranlWZGpkcmVnei9lNVoweXA4SVNKblR1VU5XeWF5S0RC?=
 =?utf-8?B?TXZmZzdsR1VqTXNlYTlONUw1bFF5ZEtoenNhQmxhczhYTDlwTUxYeVF4WnFr?=
 =?utf-8?B?MW5WbGJvWng5SERQakpDSnl3VFpsanUvQTdaZUlYVWxrc0tNUVBmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5224bb9a-b235-42e6-db02-08deb11c1e86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 18:19:06.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8QJZ02tqgq5Tc2xkWXG5FmBhTF8un6xRuXG+JPUizyHPVFA+lBlix+4X0sw3usLOmYQ8YYOGm/rv1AO0ic4sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107


On 5/13/26 18:23, Alison Schofield wrote:
> On Thu, Apr 23, 2026 at 07:05:27PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses like DAX.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 68f5a1fd1b1c..3af2aed6c6f1 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4165,6 +4165,13 @@ static int cxl_region_probe(struct device *dev)
>>   	if (rc)
>>   		return rc;
>>   
>> +	/*
>> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
>> +	 * Skip device-dax registration.
>> +	 */
>> +	if (cxlr->type == CXL_DECODER_DEVMEM)
>> +		return 0;
>> +
> This decision is now made twice in cxl_region_probe(). This one above,
> and another one later in the function as added by Dan's incremental:
> 	cxl/region: Introduce cxl_memdev_attach_region
>
> If the intent is only to avoid dax registration, then the later one
> is placed better. If the intent is different, then the commit message
> and comment need updating to explain its placement.


Hi Allison,


Maybe I was not clear enough in the RFC. When I say there "extending 
Dan's approach" I did not mean to be based on Dan's patch " cxl/region: 
Introduce cxl_memdev_attach_region" but to take part of what it does and 
solve the problem I stated on my reviews. Moreover, there is a 
disagreement about when such region attachment should happen, so Dan's 
approach and mine are not compatible but exclusive.


I'm waiting for Dan to comment on my reply to his last comment. 
Hopefully, this email exchange will help to move this ...


Thank you


>
>
>>   	/*
>>   	 * From this point on any path that changes the region's state away from
>>   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
>> -- 
>> 2.34.1
>>
>>
