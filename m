Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7F33D4F0
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811328; cv=fail; b=GS1GwZPvH4Q2QkNZZJLwRl0x3Yu38jesQW7EpTwAzxE0k+zPJA8atwTU3HpqQni007IriR+zK9ehwFQbdLK2R/mqOt7bLXK60DCVWSaYpivy4iOZoXlfGNFFVD1Mz7Jie4XoFAYSStkL6Anq5UUdR1R8rz4B1jVR6I7L7MCdpDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811328; c=relaxed/simple;
	bh=eIYTNj2OZIWGRUfltbYmZrnHKi4hJvl0ZOUfINP3sxE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8AOIgKEc3iDMgyWCQW+S0ydlBcaLsxXkZY9xSmSGlSQCUYNhaz0++OKUrs+zaeqPq9fxNEDYCYxhKXqzwN9jgdcXPzQ/sQ0BK8bhMi4eLj3KzG9lUrRYPPwTxTtmET4gbm21VWwq6CKOq8vj4lEF4erMQz3mBQ5hFWuffGAUSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qlebDhng; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qlebDhng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwdFmPOF82bbMOOx10660JvpndIaBrKsR4Pv/FsqJOA7d86ULS3V5G6oUl49EV+WOE4f6zRTiAWqEGlVNL6E51a/WIQfuY9Y5fSEbX4/LWoNdxtwut9v8fo3J73fRC+FArP0XN1UOLWmCMIM4QPYk+YGeXKemWqUcWVYNPymsCM+OA79wz+brARNal7SxOsTg2DeD2zq0dgqPCVUdvcBOgPJMJDQe0/a3t0bj1cfwY+ZTK5spbIHx1WD7967t8Oxe4qLLnyJsrvQJSNIn8r5rt0cxKnu0dsUTHgKCN4DuueASOl+bjC6hbK07Zvji6UVTEUxf1vmwNx9ybSkpd6tuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLAdjW2QXhdZ8vEzF8PJJTMP+5NefmE5UXFaNcEdA6I=;
 b=baLm1n3Q5jgI7IEbkN93whCzoDYabWxFG+4h8dHz5VgEbIFKP0fLPWqgelhbxwFD69OOnMRvvn9PPVy51E1OgHoPv9rAh6ZXBh63yTuyIiSV2aA9JOWC/y0HE5zQUNO1ov8wUHqPyaulqMZKBCOtARUfVatnptA1FHF/0tXrGO4fjuXsoHHorKePOrn6ogYmRBVtzlYq88qu1EC4JqacGMYf+IK15Laztm2z9l/1x8WLa5pn+If3wZ87ExCtQrcs9dMhnKGZviSgPJOrPuDcJWXVn/Q9GzBOdQdRWI4qBGzBnUHYvwT39SqOeU86JxCpl+Dir0F5cN41B4+N4SZzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLAdjW2QXhdZ8vEzF8PJJTMP+5NefmE5UXFaNcEdA6I=;
 b=qlebDhngGiQ0R0FWKPGrJoSwPp4GE+C9AKHGMmnM7U8Wwm3tlSINzlW8UIWe+EQNMGdnvmpm8W6lPKLa6B/2bF+qaqIhaHhLFd9u3O3Xan3wjoPRKOQFGENRuTybmBfx3kyjdDayp3u/f6NO3CygaW/ptbAhE6uFZwT8GDycw4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:35:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 6 Mar 2026
 15:35:24 +0000
Message-ID: <43fe3ba0-cca6-4d46-806d-fcabeb09faf4@amd.com>
Date: Fri, 6 Mar 2026 15:35:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cxl/pci: Remove redundant cxl_pci_find_port() call
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, gourry@gourry.net
References: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
 <20260228172549.1121832-5-alejandro.lucero-palau@amd.com>
 <20260302152109.0000707d@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260302152109.0000707d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab5369e-d969-47fb-4cc2-08de7b95fc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Uz9KNtm2RUKviwE0FeZEVVZQBmmJmc05YaemDJlnUiRlJS3ZFBOptAkC4kBg51m60HtVB/SLaZ9u0XS/5vS7nTM9yebvE/nJawSNQxSyl0hOGh0oq1aeezIJT2jLW+dBUKqf2ygU3kGHdhLPSJ+SSg9xiXuQ5yPFDHfWQ60lB48AyJsSG6pB06wf35HKnDLqQXLbSicEkvQGoEqXml0S2UcBdoQ4Wurpxe11sf/KrPslwexgkPKHSBCivbfDUpnSDr8DjegUxsEbhBcxFTAk6SDclNZNKL5M6ULvxDcvQgts3DCrydvMjh1dmgseG/GOrhHI8cGIsAin9E02JpQwljq4Wf09sC8z/eVDi6f1hrVufWho2HDuVdvSIudUbJ4Q+eo7ZjE4yEzSfNvdWOpKntyfLC/rBQLOU/9FNgScp32fnyEysJWmNEckbaQt8FsnsJJlKnupVZNCkFo2VpwIJBIXSM4kUCJlUUJJ8Ae/YMCzuGxVBUt2HfHwphITdUxS9wHaGUJiSra8Cg6jK1aLiyB/pjPUIM+4lEjLKTpcsZsAZzCFXrmIiUVoyDfp++T0ZVFrdeKQ43g8Q638oHyeVUE54Vuw+eRx7qqdWh37foR35wGPMg+DTZVltgqr18OKvgN4SF61nEZp73Qth2WYep8rbl+tn3W3OfoA1iqHwROQgq1b3vRANEyOWSYq3TzNhWQp4t6w4MWxCYWGwl8FbCWWe49rhyPx2f1bNZ4ChvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZaOVVkdk5lWnRkdE4zWUFoTVZBeHphSVNDSzdNbXczc2ZGUURnQkE0Y3dF?=
 =?utf-8?B?YzQ5V1prenBDR3p0elRrdTBSZy83QnAycU11bEt5Zkhxbk0wU1Vic3dOL052?=
 =?utf-8?B?QW5CZGJuMWprUzM1eVdCem5XSU1uUkxGZlhUbGxJSFlvbUtjeWV5MUhyQUMz?=
 =?utf-8?B?QTNwOWVtNkU3T1JnOVhTVjN4NHBFeVNXdFgrTkRrUkpNdk8rcmo1dUsycXF4?=
 =?utf-8?B?V0RaeEZlNldvQm5mWGt0b1pHZGNtSnNPWC9jWndJK0FYbTA0VkhFWm1zbm9u?=
 =?utf-8?B?YkdOc2hXaU9lV0dUVHV0bjZkNUZNejNlcUdLWHZMRm1oSWd4WjJQdkRmLzlW?=
 =?utf-8?B?d1ZVckZocUxEbFNiRGpBd3BId2VvVGtxVFRwckxpRW1JaTFlVittTjdwSVMv?=
 =?utf-8?B?Rkc2UXY0YnN5aWpKVXNqeC9COTRSWW44WjBnaktGQVIvQUtNVnBHWVk5TVhp?=
 =?utf-8?B?M3drdDJsd0NJNFcrT1JaT2tjTjl3dFc0czZLbm9ydDl5ZE5TaHY0bHJ2a1k2?=
 =?utf-8?B?aGhlT0FnSHR4MXVJUlhTS2ZtNThEQmY4KzVXRi9jcVU1YnZ3VkN1WWY1R3Fj?=
 =?utf-8?B?TE9rZjNVVnFndURrcmtsbjJkSjFKZ3Y1dzFudm54TDBFTmZETHFWUzI2UDJL?=
 =?utf-8?B?RUVmSFplZGxwK3pnNDRYZzRxVlVMRzRxa05tQ1Fkbnk3S1Qvd1JuRlRQcXlK?=
 =?utf-8?B?ZWNnaDBPZk5QUjh2b3dNRjRjdUZVTnRFOXdqZUxpQnBQZFVSMFlaSE1NWDZx?=
 =?utf-8?B?TnZvUmc5VTRLTHZMOFdIU0xXd3hvZXZtekNSRndWaTJsdWExRVNBQjBiMmhO?=
 =?utf-8?B?Q2h6ZFlkY0ZmdnZPeFZMOThldEkrZGJMSkpVbEpjUU9NaEt2bnhHSnNrNjdr?=
 =?utf-8?B?RnVXQ1VRZUFlcFUxZ01PQ3RaT0JFMFRBS0FxZzM2cmJXUndCQnoxR1dZSzZR?=
 =?utf-8?B?eU5JSHBPbG9GOFllaGk3SXBzN3dqeTZsRzVWbzBwdDhzaU1xdllTY3NYRFVN?=
 =?utf-8?B?N3ROeVNCNHdKb2FwRGhjQXpjYm5EbmIrckE3QmIyNHpOVDU5K0FNaTFTZmVJ?=
 =?utf-8?B?ZHo5YU5VVHFGUktVeHZtRDh2WVJ2aFlmZTdQQ0JOczRuY2V0VGtBeEE1cEVQ?=
 =?utf-8?B?U2ZBWkM2b3NnOXFuS0pzYWJudGxpTXAwVHNPUWJDOWVTYkZyZ1NBU2d0OWcz?=
 =?utf-8?B?M3lLLyt3Q3lENkVvaTNha2RWSGZKV1F0WXgwaG9VdU5obnRmM200aVkzVjR5?=
 =?utf-8?B?Q1dEOGhzM0N6Ty9mbVZsc3FuaUlPQTNRMkdUdG5vcG9TOTBNMURuZ3NiMm52?=
 =?utf-8?B?dU1DRUhZL1V1ZXIrWG9rRy9Vek9KTm4wVFo3Z1JOOHM2eCtSbWlDa0NtUXh3?=
 =?utf-8?B?KzFDZ0FoZklLSGwxZ2JjMWZJNDRGZmpGOERBdTF5K3pUeGJlVnM2USswNkJy?=
 =?utf-8?B?UVA1RCtBdHhVZnN1dmlNUTc0QWVsSXZRdkFDSkRGYjlSN3lGMUxmOVNnSzlS?=
 =?utf-8?B?VGw2SjlybDlGc3kwcUFDU3oxS2VaeUhkYUtuNzA4YVl2M1NXK21UakpFMy9k?=
 =?utf-8?B?MVlBeGtYZ3p1VENEUnNEMCtmV0FLSklOVDhWTWs3RU1NeTJpTWl2aXhVZEZE?=
 =?utf-8?B?V3R3aksxazd6a0p4ellJclNrczZ6SDhrcUJwbnhOcXp2Q05xQWFmT3prOUxS?=
 =?utf-8?B?WVhORWJ2UlUvQUZvQ3psYU5PTmdQaXVES2dVSi83bVVEVStxT1FZTjJ4WWR2?=
 =?utf-8?B?c3BQeGtobkR3WUcyOXlFZEZlUlZoQ1plMGt3RkdnRG8xS3haeWtWelNRckdR?=
 =?utf-8?B?eEJXVlJPNUNDSUEzNHVnNzU5dHBNNFVHeUtsekRvazhMYjBQYU5FbFlORlho?=
 =?utf-8?B?anRXejZXRGkxby9jVmc4clVCbzVmRXZ6UHNzM1FVZ3BGVkh0Umo0eFpqK3VO?=
 =?utf-8?B?dkE5Z1VlOTlrcVVqS3FOSEczQnV0Qkk2Z2RnV2hEUy9uQUM0WTRrSUp5MVVU?=
 =?utf-8?B?TVE0aTY0RGRISXU1QThqQUliUGlQcGI4MDBpZWh6Q1JHS0VmTWJpNlN6cS9q?=
 =?utf-8?B?dHZTOHRjSk1hYngyR0V4V1JmM0U3Y1doYWVza1lXV091QkM1alk0Rk1kZkY3?=
 =?utf-8?B?eldDY3hpcHlSSTBOTXZEWitOYUVpM3FBUHNSODNCN0RIenphdGQyVlgyaTlB?=
 =?utf-8?B?OCt5VU9ZT2YrWGQ4bFBKVDBQVThpM0ZITEV4WktnYm9jQXc2TUJNcjhMUm1q?=
 =?utf-8?B?UXN0ek5XYUQwQkQ3eVlCaWd1YUdKOTFJcHRjOWxXY1ZDQ09qTWZaMUE3VVRC?=
 =?utf-8?B?TTJoa0J6NHVid2JEVk5rQ0lSWSt5eC9YRzZUOGRXMnd3dURFRjZWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5369e-d969-47fb-4cc2-08de7b95fc06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:35:24.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RGqqIcNfJWeDMVtDZxWyDZcjs64uw+sQhScVlTRXE9iBN+InRVEa79wK/24Uf/NUg89qlC5IdtQROLzjJMHNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

Hi Jonathan,


On 3/2/26 15:21, Jonathan Cameron wrote:
> On Sat, 28 Feb 2026 17:25:49 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
> Needs to match the sign-off.
>
> git commit --amend --author="Gregory Price <gourry@gourry.net>"
> Should fix that up for you.


I forgot to do it. I'll fix it in v4.


>
>> Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
>> dport parameter directly. The caller has already validated the port is
>> non-NULL before invoking this function.
> Given the existing caller only does this immediately before the function call,
> what the reasoning for dropping this one rather than dropping the one in
> cxl_pci_setup_regs() which would have the same effect?  I'm fine with doing
> it here, but needs a tiny bit more descriptive text.  With that added and
> the author fixed up


Answering this on behalf of Gregory.


The removed lines are not needed inside that function. The only reason 
could be to discover dport there instead of inside the caller, but it 
would imply to return dport instead of an int as it is required after 
the call by the caller. In other words, it seems simpler to remove it as 
the patch does. I will point this out in the commit in v4.


> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


Thank you!


>
>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index c32cc62c501d..d1f487b3d809 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -707,11 +707,6 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>   		.resource = CXL_RESOURCE_NONE,
>>   	};
>>   
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
>>   	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>>   	if (component_reg_phys == CXL_RESOURCE_NONE)
>>   		return -ENXIO;
