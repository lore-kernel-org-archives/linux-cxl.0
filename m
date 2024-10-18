Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A2200B93
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265203; cv=fail; b=il9IA1q2esD0hOMlpQDsZG0ki3jK5NuSqdZN4s+C9R9Mmba+Sf2EnWse7e6QG4vtoB1b7dCu+juZw3hyAmA1gXh7NNG3WgHWP6p7rKWlF9UPfdo8HG+JMLtDGsNx4BdRHFp3Vr3TgGoJ2SHsm4fcFfG5e6bARL6zfX0TzEu8S5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265203; c=relaxed/simple;
	bh=fFULj/31YzG8BBOIfKlOlN0dKXqeKpE8vNimg4RAzz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pug0QA6/E3YvO2GNiceFN3XCEDEdTJn/WstOf/Sl2VfPrWfhdpS2yCRA4iFKSMzPM6BR7GCc1MqAcdZOGhakPqBBlXAOpvF5onVLqFILa2lrYHpvb/mQPsvrnS3CP2Euy4FJN5lC0p2IeygFq/HI9sIikY53wcoA9ZGeB2LM2Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=as4v/yqA; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="as4v/yqA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS+Sxaw4UliDYrNj1iWJWAApNRGiytP4VDgMiucJBiKvNdj38RFe/t9OIZzr+k2FlyT+CMm6LB3nf09QbaqGuKsU5IUJkzkoozQxGaPyxYbAf5XZY3QhjLpia+G2UcWRgAHSn52xL93AFXrePlL25Q+S5CFUuVOKUcT7254mVzDsPr+AKe1hnqhKjxX+T5MYMf2ZBFY/vrzrxVsVXhbgfbILMfCwOLtzSofnbQx5v31xKsiv4WmeJlWIruPMzB5I0ANcz7xKo2b3UFiwTExpXwkxiH93idHHvwaOIz3saE8696O/6xp8relQ4wp+u4ZQJW2hki0wzHI355vnnJ5X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1lj5vxr+G5U1GGJaPMi/zlAOo0GO0IbPr6xys/NiEY=;
 b=d+p614mEHbdXAvbeKezsrpaUAHST2bnLfSSbzJMsGoxmq7P1Kg9AtnAqw/WWu7JW6B7it1WhMqGgCXNn6XzCLyEL6kS5Q8JXAY5U7hBnufSdoWXryIHe3864ix34UaysWhQzHrMxzaUczrRWACCoqmEy6xqVdHUIPvvE/E3VaP7bU4iBYqBntPQsu4CALwmEL5G2x6TtCasmL3y3FB1yZaixb8p3539lzLa/4A53MLS3nHIGUiKqRciH4kdvKKvPJ8stzw4QDs3+Ri26kPuwlnCaEJCJBx+KAznM5T99KXfV2XGHrRypYe1Gyzam9X9U156Sve12ZNoGGYjtrLTM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1lj5vxr+G5U1GGJaPMi/zlAOo0GO0IbPr6xys/NiEY=;
 b=as4v/yqAd9j3mfJhP2T6DzwELmtmBoXACWNY8LmA+59/n5Z894r4ZzY9Dxgy9+JDKfeWeQ+omimGIwsPxUjVIBst15YHanFb5+zmV6o04SoLhVlUiOirWR6DJFvisUnWVSlnHbGk+orq7Rz+G2fhzZvVIHrpk7KfZSW+T+muKpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 15:26:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 15:26:38 +0000
Message-ID: <29528327-90d0-5aa7-d756-0a88a396d6f6@amd.com>
Date: Fri, 18 Oct 2024 16:25:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
 <5827f6e5-6de9-4ec1-83eb-b2e552092498@redhat.com>
 <4085e18e-65bb-4b0e-bb72-f05e69996cbc@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <4085e18e-65bb-4b0e-bb72-f05e69996cbc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 11aad58f-d927-4482-582f-08dcef894205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmhuNUtpMGJBckdWN2ozYVBoS1NndC9YdTdiUFlMbjZ6QktQYWRYdWtMR3pL?=
 =?utf-8?B?aDlIQ2phNHdobmFzQnc0UmUyMzVmOVEzaW5scHo1ME9lVy9vN3RmYUxGbElv?=
 =?utf-8?B?ZmV6VGQxU3VYT1ROVnc1MXJqMHlIb1U3Q3UwNEphNDRzemI5TG9FY09haXdp?=
 =?utf-8?B?ekhFcS9NWjZQSm9tMzU5b2lmczdoSDRYSlV3TG4rUmJJVXI5S2xLQlV5SEVH?=
 =?utf-8?B?Q3FxdnFJcjdXbkxaSVBUZk50WERZcllsTWlNUVMvMlpDQWlsM29vUWpzL0dK?=
 =?utf-8?B?RjhYQ21Pa1FwNXpOMDRzcml6ZFV4em9sV1hHZ1hHOW5mUnMva2NwZktuc0M1?=
 =?utf-8?B?cXJCRjhLdW5iQVh5MzZHdEFaSUxtalZJaEpxejZHNi8xZkJKZUlPUGw0cm8z?=
 =?utf-8?B?cEFrRWY3N3FWSjBxb1Z1TmdxN2ZwTkNEalhQZk85bHFMc2ZpMUhnWVkyRnFn?=
 =?utf-8?B?RmFnNUo5K25lZXo2SWxrbStEQzVjalAyWXpKSm5YUTFsMEU2Yk5xMG1mTk0r?=
 =?utf-8?B?eHRQVjg1ekRCRGJGSkRibEJQamQ5V3V3Vk1IOE1JaFZ3dUZ5MUlxZHhCeS9M?=
 =?utf-8?B?emp1R05wcW9ZQWFqTmFVTjJSRDBrSHc2RGpnNzZVSUxoVHUyeXJqRmdEc1c4?=
 =?utf-8?B?U3VMS3p2R09SejdDR1RoU0w1SlNsQlY1eUV4MjByODhES3IwRHRpblRCcU1J?=
 =?utf-8?B?N04yVmVScWVJSjNJTitMbnB2LzZMS0Z5SldIYkhpbk9YVkFUTHZWa2xJdEN2?=
 =?utf-8?B?dUFVUTZXSkZYZ1c4MWIxSXdBdWVJbnJDWmthMUxZWmRkaUNSUzdEWWpuOFBh?=
 =?utf-8?B?QlI5NVN1N1dVaDZPc3UvNVJkQlZFMUZDVXFzOVlJOTJmbnNrdUtlT0s5a2Nm?=
 =?utf-8?B?NHlBS2o3OUZwai9SRDNISDZndzVuYmJQcjlWd1N1M0Q5TnRSQzlnWk5Dbk1O?=
 =?utf-8?B?c0dnRlIzOVpEWGF5MzhYRHRQbjMyNFg2TEJ2WVRWV25xVmdBQitpVjhFbWFr?=
 =?utf-8?B?Z1g2eVdLQWpRSW51eXpZVEM3Uk94ZHJkTGJEaTV5YUJTNFZHRmM5aDhzZTFD?=
 =?utf-8?B?bGZoVG01RjBMcm1weHBjWWJaYmhmN1FFUXRNZzdaS05nekhqSzZVOG1BejI0?=
 =?utf-8?B?cjlmZjNlbk9EVDAyV3RETXNEVmFZK0Y3SFljRUhBcmZ6VFcydktRM0VyeU1Q?=
 =?utf-8?B?T2dqbnhvdTVmYlQ2NGlISzlkRGNIQ3BaR05RTHVNZ3k5SWRCMTRZdmVCK2JS?=
 =?utf-8?B?cXc3em5LSU1sOWVVMDEvdXRYLytrdkQxbjVpYWRxdGR2OWU4amJxN2V0SlNH?=
 =?utf-8?B?UXFOMzl2YkI5aDl0U09PMFgrdXMrbkN3dWlXTkZXbjU4dlhhQjFqKzRyTWhJ?=
 =?utf-8?B?RW5oNk9iL0FXQzBqcGM3T0Fwdmk2ZmtKUG10eGVoM0hmeXZvaFNzSnRGd0ZJ?=
 =?utf-8?B?SElYTDFuUkRiZ0JkVjZXcXllczlVZ2hqdXhZZEtkUEpVYnlIaFhUWlhTeWNh?=
 =?utf-8?B?UlNLSEt5YTB5QW9xVmFnMTBpRVpmbDh4WG9DSENFcUVhQldrem5sMzV1RmdE?=
 =?utf-8?B?UzlBLzBHMm02UzhxWGc3OU5MOEM5eWdVN1BkODZOZEVqUU5ia3Bqd2pTMHNh?=
 =?utf-8?B?aCtNMFVQWTdXT3J1ZmVIOHg1ZkprMVdxblFMYlpxbHJvMjg1c0o3MytjQjJ5?=
 =?utf-8?B?YUdLYkt2dVBKUGJ6WG94QmM2c29nd3VFOXM3ZXJ4Q1VHNFhYTGlrcmZzWjNI?=
 =?utf-8?Q?PU+0dQrVYs41YHxfDhcPl9E06JwDLtJTvZMq6w1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WklWaGJpbjBhNUYrQ3hoN3lvVkR2L0VuZHJDTjdBUEtLQitRbUdTejRrb2FG?=
 =?utf-8?B?b0NpVktUUS9QaHU5YzRiK0FNR2c1QmxUZDhsZGl4UEhYczlMUXRudVNRYThV?=
 =?utf-8?B?UjFJYzBqQ3o1eHN1TlBHSnFtY21HTW45eExqUkxVcklGd05DcnI1ZVEwak1s?=
 =?utf-8?B?eG9xTFNRanRvNlpFbXRVanRxdXd6M3Btb2diS0kxYmlYNXdmVXFDTkFMdm9k?=
 =?utf-8?B?ajFqd0hmdi9XZEtmNXZIaW4yczZ1SFJTeHJhU2NqMFc3Y1dUMjR4Rk1LV1dQ?=
 =?utf-8?B?RFRMMk1oVTlxdml4OW1waGhmSWk0UzZnZ2FVVjBMWW9DTTF4dlpONm9KL3A0?=
 =?utf-8?B?T3p0MlhiWmxhaTlSdTBYaE50dGdnSUhHdEFBNkhLNDYzY2tJenNPOExGN3FK?=
 =?utf-8?B?NlJqSVV4Y1AwbzFFTDFycnNIM2Z6V09SbGVxazl3WVgrbEgvY1dZV0xJVERi?=
 =?utf-8?B?UnBZU2dsVG0rVGxvZWM5M1ZoazlsK3BNeXBxSjduY2JST1FHam5pYmpGUC8v?=
 =?utf-8?B?NENrbDVwRG1xbWFSUnE0eC9Peis0QWxSOTFNWGdKY21VcXVMditSMWg4ZW5O?=
 =?utf-8?B?LzlLSkZLZHdaM3p5RVZkZ3Zvbnh2TERqbkRCNkFYTFRmUzRFOUt5MWl4VjZT?=
 =?utf-8?B?MExsbUtYUkFKNTZyNXNQWGVMNzFkS1pId3dtYlZPVVVCb24yT00wVlp2WkF3?=
 =?utf-8?B?SUpYYUIzMTVCSU5PVXZiVTlUU3RneUV2QU9Ec2pOWG9vNjJRQXZlN0c3SVAv?=
 =?utf-8?B?dC96NmNuZkdLdWNIV3FVTVBRYVhvL09zVlZZTXQvZTlRdGVWck0rR1RRRnZz?=
 =?utf-8?B?Tk5PZ1lVY0dSOUdBbEdKMUtwemZKZXpKeUFZTmxQM0dmU0VJYnR5UGEva3VU?=
 =?utf-8?B?TkFoM05EWG11bUpVZEQvbzBrcSt3WUJFTEtHaDlIR1ZNTnM1amRLQ2NXVjdX?=
 =?utf-8?B?d2RBVVhKZkxlenNiUXh0UFNTNG14TTV5RzFTZzNhY291UGtxTmdUS1NvSnd6?=
 =?utf-8?B?N3FzVmk3bnM4MlVaeXRwa1EyaCs2RDdUR1labjJxSXRLdlZKd3k3cGJET2xl?=
 =?utf-8?B?cU1WQW1WNUhDVWVJZDhYaUcvYThnWDFReVFZdFVDMGVYZ3FTbDRiQjNSbm04?=
 =?utf-8?B?cHNTYUlGUWRaMFBUb0Q2UURNQ0Fibm1PTU9nVlFxTnFnUXE3UTVSWlRKamM0?=
 =?utf-8?B?YjArQ2d4bE1STjI1UFRWclMzNHVLOXZqcHdZcEtLQU81dkxVbnY2ZGM3b2Fs?=
 =?utf-8?B?ZUxYazBMcTN0eTRteEprWHdCOFBhTm1za0orUE9QQXpnNFV6eklvQlA3QXFp?=
 =?utf-8?B?cmp4VWhpdEU1cXJRdDdnL3k5blA5L2hYVC81Uk1zdzB2dmZldTlXek9DOExM?=
 =?utf-8?B?eVJSa1Y0RTZkTFFqOTlnblpLdzB5WlRHK0hJV0Fmak1sSEJnZGI2Y2pTcXg4?=
 =?utf-8?B?Q05XMHVuRU5US28rQWRmM00xeld0b2g3OGhWSWlhOVpWOFRwZDlWVUNrUnNY?=
 =?utf-8?B?YkptMldzdDhkaXlMT0tmSkNLR3BNRUlWZTY2a3R4aXZhbXRiK1Y3VzVOZ2hK?=
 =?utf-8?B?Q1FDL3BqVTIvRGY1bkVaSUgrR2hCVGsrMnFURDFwTWFzMlFSUEprKzRFQlFV?=
 =?utf-8?B?c3dqWXN6S1RCSnR0bUFZTHI1bDFGbVFwYmhWdU16UlhmN1l6TGhrRDExYllK?=
 =?utf-8?B?U2VzVUZLOEdhd0FHN09uRnhvaEs4RWlpSm1mNHUrMTc2VlBLZVUxWTNHd3Jm?=
 =?utf-8?B?blFkUHV4YTNYdVNFUUh1YmVPVHkyTTN6V2E0Z3NCREtyczNQQ1RqWEcvTTZw?=
 =?utf-8?B?UjlJUXVBZzNGT1p4NFVaMG4zWmZiOVNPTjZ5a1hqbzAzK09uSFkyU0ZVNDFL?=
 =?utf-8?B?WVFKbWluN3BoRHdBVXdqUEM1Q2p1OUIxZ0YrdTZRQVJyd0gvSGxwOFQ5VGVJ?=
 =?utf-8?B?Yk9DKzlRN3VUdDdXazVTaVdKK2FDeTEyUU5YK2xlU2ZEN1hTcTBrVkNIQ0M1?=
 =?utf-8?B?YmQxcVZZWlVNQ3lVZFdpWXdJa0NXeEF6a1BHV1VYYjlxbzkvNk1MQmd3TUFk?=
 =?utf-8?B?dFZsaHFnRDNsY3ZFSXJNMXh5WHpOckpCMnFKTGsvTEI0RkZROVVUZy9JRkJW?=
 =?utf-8?Q?3SIzgwYUKx/0kc35XGb3DqCsI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aad58f-d927-4482-582f-08dcef894205
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:26:37.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROckHdP8kc3Pyx3dzyxSgCEfaQ7mZL6tvrcVOzHjt4WPPrFJApj0GowrZhZDQHP6qOoZp4xd6u2DNDrU1B2pyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412


On 10/18/24 15:49, Zhi Wang wrote:
> On 17/10/2024 19.57, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello,
>>
>> On 5/18/23 04:45, Ira Weiny wrote:
>>> Type 2 devices are not yet a reality.  Developing core kernel support
>>> is difficult without some test device to model against.
>>>
>>> Define a type 2 device 'cxl-accel'.  This device is derived from the
>>> type 3 device and retains all that functionality for now.
>>>
>>> Mock up a couple of accelerator features (Back Invalidate [BI] and
>>> Unordered IO [UIO]) as examples for the RFC.  These have no
>>> functionality other than to report the features as present for software
>>> to key off of.
>>>
>>> Defining these devices in qemu can be done with the following example:
>>>
>>> ...
>>>     -device
>>> cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
>>> ...
>>>
>>> NOTE: I'm leaving off Michael Tsirkin for now because this is really
>>> rough and I'm mainly sending it out because it was talked about in the
>>> CXL community call on 5/16.
>>>
>>> Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>
>> A recent proposal to add support in VFIO for CXL passthrough uses
>> this emulated device and a sample driver for a proof of concept.
>> For this effort, it would be very useful to have a QEMU model for
>> a CXL type2 device, even partially implemented.
>>
>> I haven't found any updates of this series. What are the plans for
>> upstream today ?
>>
> I was discussing this with Ira and Jonathan in the LPC and CXL discord
> groups. (Irq and Jonathan, please feel free to correct me) I think we
> all thought that having the emulated device support in QEMU and a sample
> CXL type-2 driver in the upstream kernel could be valuable for
>
> 1) people who wish to contribute and propose changes, like refactor, and
> code tweaks related to CXL type-2 support in the kernel. They can
> validate their patches to check if they break something without a CXL
> type-2 device.
>
> 2) people who wish to contribute on solving problems of CXL type-2
> generic code, e.g. loading sequences of modules... They can get involved
> without a real HW.
>
> My gut feeling is I can start to work with folks to get it into the
> mainline together with the sample driver when CXL type-2 support is
> merged. So people can play with it.


I did use an emulated Type2 device for my initial development and I'm 
still using it for wider testing. It is basically same than the Type3 
with small changes. I think a proper solution should include command 
line options for configuring the device with flexibility or maybe 
referring to a file with that specific configuration. Note there exist 
optional functionalities like HDM decoder, and CXL.cache will need such 
a flexibility as well.

The RFC contains the driver for such emulated device implemented inside 
the tools/testing/cxl directory, although it has changed since then, but 
happy to share it. It is almost equal to the code inside efx_cxl.c along 
with the functions/macros for defining the driver.

FWIW, although I'm working on Type2 support, I really think qemu could 
help for development and testing complex CXL infrastructures, more for 
memory expanders aka Type3 than Type2. I know this requires a good 
effort but IMO, it will pay off.


> 3) people who would like to try on vfio-cxl.
>
> What would be nice to include in the patchset V1 in my mind:
>
> (Ira and Jonathan and folks please feel free to comment)
>
> Must have:
>    - HDM decoder support (>1 HDM decoder). (which I have done it in my
> tree, so the CXL core can create a CXL region)
>
> Nice to have:
>    - CXLType2 device system reset handler. As what mentioned in my cover
> letter, a system reset handler is required to reset the device state.
> Linux kernel CXL core assumes the HW is pre-configured by FW if it sees
> CXL.mem is enabled when enumerating the device. So I have to kill QEMU
> instead of resetting the virtual machine when debugging.
>
>    - CXLType2 device in the patch should be derived from PCIDevice
> (current it is derived from the CXLType3 device, which carries quite
> some unnecessary stuff to present to the guest)
>
>    - Refactor of the current QEMU FWMS code to deliver the guest access
> to the virtual memory backend to the correct emulated CXL device (which
> is currently hardcoded to connect to cxl-type3 device in QEMU. Without
> this, the access to the CXL region from the guest seems problematic but
> creating CXL region is still fine.)
>
> Thanks,
> Zhi.
>
>> For vfio-cxl, see :
>>
>> * [RFC] vfio: introduce vfio-cxl to support CXL type-2 accelerator
>> passthrough
>>     https://lore.kernel.org/kvm/20240920223446.1908673-1-zhiw@nvidia.com
>> * [RFC] Introduce vfio-cxl to support CXL type-2 device passthrough
>>     https://lore.kernel.org/all/20240921071440.1915876-1-zhiw@nvidia.com/
>>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>> ---
>>> Ira Weiny (5):
>>>         hw/cxl: Use define for build bug detection
>>>         hw/cxl: Refactor component register initialization
>>>         hw/cxl: Derive a CXL accelerator device from Type-3
>>>         hw/cxl/accel: Add Back-Invalidate decoder capbility structure
>>>         hw/cxl: Add UIO HDM decoder register fields
>>>
>>>    docs/system/devices/cxl.rst    | 11 ++++++
>>>    hw/cxl/cxl-component-utils.c   | 80
>>> +++++++++++++++++++-----------------------
>>>    hw/mem/cxl_type3.c             | 39 ++++++++++++++++++++
>>>    include/hw/cxl/cxl_component.h | 51 +++++++++++++++++++--------
>>>    include/hw/cxl/cxl_device.h    | 16 +++++++++
>>>    include/hw/pci/pci_ids.h       |  1 +
>>>    6 files changed, 141 insertions(+), 57 deletions(-)
>>> ---
>>> base-commit: 8eb2a03258313f404ca0c8609a8f9009b9b4318c
>>> change-id: 20230517-rfc-type2-dev-c2d661a29d96
>>>
>>> Best regards,
