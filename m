Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10355388E59;
	Tue, 17 Mar 2026 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779553; cv=fail; b=McegyQI/kNn2V/foABQPO1hML/+cFQ2fDoaIitsbxblyQIgGMmhqRTOz6BgRUnqhVB/17N9HavTQ5dJv7tJWWFTUd2vcojyI+0adhHaO7Bhd6YqgTcnsYPypz24g3+gJmb+ZzlwvIQjnveCZIVh71F4fRLVvsmFfSPcGfviklhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779553; c=relaxed/simple;
	bh=9iEBMotEMhnb8DTYfAtEkYY5TsNUHCoEk53uTfWh8U8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWIXiftGwRuRFUIC+z+uDDp7jLfIox5l7cq1RoMtE2JkUiSIOXdm8lXD67y0C3UdC1zoejuWZA+MqFMyPa3dzoTY56PunlfMvIhqcBsXEBEehERaptsmAb6lkq3jutpOnYkrCxlmT7gLet0yF0SlQa9haHodIGiBgU4PaHVsXfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f7DyNAc/; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f7DyNAc/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeZRM5jmWxqSqhgEdai10taroKOqnFjPmslL+w+OyagnOZCNPFbKuGAWJUqglXb31A1COA1Y71KxFPdFxJWkWPfrXnW+TvWGv1VHqO1yVTy5BAiz69bco7BE4/GricZAXO841d0rNO3Bif8MFnKVW9jYBS534PrCzyxb2BjsWgYdT64HwoNjA0H2Jdmt16eGMEBAab3vZYkBzB1MQKaIDkx78x9ZgouGJqNO8YwFKu9Hl3XzlY9+jHE3pUGIMJm3SNw6TfPsHtWu1FEM/FNF8fOg9hABPLbSdpyufKg8xrnIY/Au18AGzJCp6TKmH/X14pQiypXsFDajYIASGtIehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wo077Shy4ueC9TZ11abtDFz62FZhGcoZT7ncajYkvw=;
 b=kNbo7tAK6hDevm4e0xtGoTYltpcxWrADMgmqZcSDir/DinxLjxh7R7Uk6Qrv/4aQ4rWws8HWkRG6h4kNq+d9LSpub+F2CwHhY0LsW9Mb5iVTRreKLTGLKDeDq09SaZH6E/VnwRoe4SRm6+u3gP9actp5ZqYwG82kYOx/I5QmZUMoZX015NIA0X9aNMwWyvDwGPaa6xKVh7IB19SpRBYbLjOf6OpI6fEiMfMGFVlEj1AIO9E1gRijJFtLQg6Y8BI32HUTD/9d6xZeneG5IjI+yYuEAe+6haf7ceVnN06vbQNI1fPpAYNLwU0RIuFjAWwTp0VasLfuU5eyXOXLfoZmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wo077Shy4ueC9TZ11abtDFz62FZhGcoZT7ncajYkvw=;
 b=f7DyNAc/0iWWqhZlBbxwOch18Icw42ckhDk85n28fToNBsEnKuPsJyrK1EjVy5XsHw9wc+SJyrFAJBz7rFt/dYLeO0unO777aw5f5YgnakjoUA6TekzyewP63BPPuEfhAGtDD69MC2/Lxu+Wf7jQ33WWAzgETgbIDvH5Q2dh6p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:32:29 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 20:32:29 +0000
Message-ID: <8343ad50-0bb3-4fed-a32b-a2b46db6c8b6@amd.com>
Date: Tue, 17 Mar 2026 13:32:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Avoid incorrect DVSEC fallback when HDM
 decoders are enabled
To: Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260316201950.224567-1-Smita.KoralahalliChannabasappa@amd.com>
 <d87ff3d2-de30-4c47-8f47-3633507b4e48@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <d87ff3d2-de30-4c47-8f47-3633507b4e48@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: e13256cc-8e42-4260-c5ba-08de84644efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	y4vf3yLL5aDpWeDUnxHWCDgtb2AqazmqmQpidN/YTiu7vRKjmmFxbPDhcyUWWcwUci4DVYHBJqUDPiMZeHMF4hPJC/uZpvdPvEd9HhRMPNPdrWoE1fxrBNVcJ4QlER63+WVxghVGwllotgK6EFC0Co6S1TlGtdPjttP0w3Hwbg5W/uggjsypt+rdf2j+V6oqUGavWtbgxrmqXs+W69XRIditZu5D4FtU+EMrApFZb4ovEIGVq+TT8z2x+szK7Vl+pvUfdGDP2NxBGpOR/YbolYQ8RnBBbqBmyaoYkDaNcYWXNtcbT4E+r4/koZYuQRkn9HGzS03f0XM+F+Q+6HVVuEuQsRu3g6Ip6lb6F8XzCn9088KkB49pzHPfi/dkt8r2xoZjeHL9QhFhZ/je37XwgEYpZDfJMA0meed6lgFTO4I6Oq6vtrjoamb+xjE3cK/DpDa9cchY/Ga3Ab2FF3BpCtYvOzADEb54+lPs6RgT/R2M7BYtQm/Bp7YUDkKbJy5ckAYGwgmQC8XggJyw7dyc1mrnv2vNN94XWjC7AAObr27sz8hcLyt/JNywpeGl77llbEenlDsTyawp4xFSDSXPGlkhlh2qQ2cPgIedW6yrOhrhAQj9QLAFH5H86dZNxNob9kJn5wNAg9g0DnDVJoAbkTtfMvCBe4wup3t3fU7yTFFaoRXQO0wQPdraHyl38PBJHA4ozUzBF+4XRJhKuH4T3dIArQ5SCzfzhEzKYsH1iXeJtn7RmwQLcQZPW9jW39ft
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjJ0K2RCamdKLzdkOWp3YytmdG93Qi9kdFplem42ZENUUUJNdUlXQzdtQ1JU?=
 =?utf-8?B?YllkTHpaSHgydi8ySUtlalpMOUVFUlN4ekg0VXVNaGJPYU8zeG0vUlBGbW5I?=
 =?utf-8?B?Q3Nia0lEMlV3Y0FNUmdWVmFLNkFJam5yVU9zYUNrZ0gwSnFXMUhaTWRJMGE1?=
 =?utf-8?B?SGwwRlRqTk5Fd3ZyVWszbmMzQmpmRitaYmNmaVU3Z0N5UGJUSm9jVWxvekhl?=
 =?utf-8?B?RXEyRnVRRklrSEg3bmc3NVZtaTJJQjBLZkVtVkZpREF1OWhGVE1vbjM0ODNW?=
 =?utf-8?B?QWVyZzBycG9iZGdtMjhBQUlCUDFSVWtEaFhRMWhYSmlzSFVwUXFBMVFZenJp?=
 =?utf-8?B?Z3RmNGtNN1RmbjJRN3F1cTB6OUgxZ2M2dmtKQWoybjlRTGs1RWpFK1FXS2pR?=
 =?utf-8?B?S21xU3JNR0pwcFhVbEhqZnZnamYrM3JYVHpkaXNQSUd1ZnF2QkdJSVZnY05a?=
 =?utf-8?B?MkFrM0l4YmIzVys0Yzgrdm5jNTNjMlJ3M21JSjV4U0RNTlVOWkpMOTAzalh0?=
 =?utf-8?B?ZVBWMEFQVTg5U3pYM0QwS09qNVpsMUF3UFFxb09IM01TeUNjTDVPdzNKVVlx?=
 =?utf-8?B?aTdLVWprUURiNThsVXJpNTFpUmt0Y1FYNUNZeHo4RWpHVFRjYjZzcmhEU00v?=
 =?utf-8?B?K3NBbWs2VUZsa1BPWk5VUk00MFRmdHdPOExKTTgwUDZ6OE5SZFg4Z0ZpYlkz?=
 =?utf-8?B?VmJua1piWHVWVStKSWI0cENxbTdKUzJsMFFCeGc3ZUtFYTdXQjdHSThUa2xF?=
 =?utf-8?B?bUlKTld3aXQwMXJYSUx0Y2pGenhZNXplUVB3VkMzdVpLMzNDNk9uSXAraCs0?=
 =?utf-8?B?U0k1b1ZXa1BMQWQ0ckxybE52YjUzWTM3d3hPeklVdml1d3RzTnh2SlVZZkVr?=
 =?utf-8?B?M1h1cTQyczl0eFAwYzNzYVRzaHFrZ3hZZU1aUEp6U015MUgzYWxNTGlROERq?=
 =?utf-8?B?eUhEL3Z2NmU2bURYakVyZmZHZjhiRnpYeDgwSkVYcStaL01oWDNFMUxXbHB3?=
 =?utf-8?B?VUV5cHRLV2RZeVNJNkZHUmZVWmJncThVZTJRNTQ1STJ6TzhpOGRFdmdNZi9u?=
 =?utf-8?B?YTFsOWtvWUp2b3kvUU84bjFLelJDR1hsS3BrQ0cxZ2RLeTY3SHhlYXltR2tz?=
 =?utf-8?B?WFdLOUtPQVZub2xveTdqVWI0akV1a2Q1VlY1Q2ZiNjUxN1hHLzEzSWRicStp?=
 =?utf-8?B?ODdyazZsalZaWnYwZmdzNTEweUhNYklvazJDK0ZobWhRYi9MMHdMaXJ1RkNS?=
 =?utf-8?B?eVl2c0x4UnE3MG1XdEUxWDhNeHVGU2pKaGdQY0ZPcE5nSUZQTHRkTjZFTkpM?=
 =?utf-8?B?a2s3aHhsM3E4M3A5L3VQaGRieERUbEVrZjB2cVE3NEhTdnZ5eUFNdTZMNG9z?=
 =?utf-8?B?aG9CZ3M0a3Q3TmliNU9qdFdNR3JRVjhQaDlpUVdQYndBYnBHUXBLYzIrM3Jz?=
 =?utf-8?B?SFo3K1M5L2h4N3AwN1g2TTVGb3NJWEFWZUVpZXp0SjB2OXNmd01DMDVWWEpF?=
 =?utf-8?B?QW5yQU55bDV2TFJ4SVhpQm9yZHJMTjlLZ1VZeEtYRXk0SHpSbmdVdGFzelg4?=
 =?utf-8?B?NUNNVEd4VEdxREhNcEN0MG1VSERtTnNpaFdFV1p0VzBoUStPZEdzbjdiajA2?=
 =?utf-8?B?N0xGc3A0Y1NTMFRuUkZyeGw5YUl3MVU2MWwrRTN4MytsMnozcVhiYy9GUG1v?=
 =?utf-8?B?NC84OHlPVGdyV1dBaHYvZ1p1WnV0NDF3Yit2VW5iRkI3WmZBVmNZUEhEek5z?=
 =?utf-8?B?a1FRakhLQk5qNHQrcURFOVlyTGUwNHUxd3N5dWM0eHlQUElUM3M0THYrV0JK?=
 =?utf-8?B?NFhEZFZHVzZPUERRTVRyMkovL1RLcmIvaWdha1ZpdjdxYzhLWGsyLzNMc01y?=
 =?utf-8?B?VlBVZnFIVEVYdGZESmtIMWhTeEZzbWUyUldqVGNMbEtnTTdXcTBucTFIaWFF?=
 =?utf-8?B?L1hqSUFISERwVS80NG8rNWI5RGt1Vi9HQ0NCbURvWjExaHhJNTUzTEZURUdG?=
 =?utf-8?B?cXNhUzRoQ2cxUGJxdFFxUXdmVFlTaytNZ2VuK1VQM2taRXIzNjFyQVFONmlF?=
 =?utf-8?B?c1MyRmgvRGF2YVBqazVZMUF2RVFLanpQVml2dzg0STdsVEJUUWpHbTJKanEx?=
 =?utf-8?B?Y04rYklmMlZsUE9CME90VTBBcFNOREo3emgzaU1wemtDaHVNaWtMRjNQZ1k3?=
 =?utf-8?B?K0tVN2J2bUdUVU1BSXdCa3FmcWxYNUpQaHUrdlIrczFKMHZpaThPTFBrOG9K?=
 =?utf-8?B?MjIyc1ZLbEpvendrcG5jZVRxQlpZdVUzUHRDdUh1VFR3Q1NMc2lCMCtJMXFP?=
 =?utf-8?B?K0Yya3RiRlBaRGZ3M1lFZWFXMWx2b1VwcUlBWUlINHFwZUcvZmgxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13256cc-8e42-4260-c5ba-08de84644efa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:32:29.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeNGFwp8qC1I5sVmECUj3V7niwOFwaM+Ko2ON/8SaQvrQz4d5wAfJRsZiS/odBOso3F80LKm4hwz4+phOYi6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230

On 3/16/2026 5:08 PM, Dave Jiang wrote:
> 
> 
> On 3/16/26 1:19 PM, Smita Koralahalli wrote:
>> Check the global CXL_HDM_DECODER_ENABLE bit instead of looping over
>> per-decoder COMMITTED bits to determine whether to fall back to DVSEC
>> range emulation. When the HDM decoder capability is globally enabled,
>> ignore DVSEC range registers regardless of individual decoder commit
>> state.
>>
>> should_emulate_decoders() currently loops over per-decoder COMMITTED
>> bits, which leads to an incorrect DVSEC fallback when those bits are
>> zero. One way to trigger this is to destroy a region and bounce the
>> memdev:
>>
>>    cxl disable-region region0
>>    cxl destroy-region region0
>>    cxl disable-memdev mem0
>>    cxl enable-memdev mem0
>>
>> Region teardown zeroes the HDM decoder registers including the committed
>> bits. The subsequent memdev re-probe finds uncommitted decoders and falls
>> back to DVSEC emulation, even though HDM remains globally enabled.
>>
>> Observed failures:
>>
>>    should_emulate_decoders: cxl_port endpoint6: decoder6.0: committed: 0 base: 0x0_00000000 size: 0x0_00000000
>>    devm_cxl_setup_hdm: cxl_port endpoint6: Fallback map 1 range register
>>    ..
>>    devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region0
>>    __construct_region: cxl_pci 0000:e1:00.0: mem1:decoder6.0:
>>    __construct_region region0 res: [mem 0x850000000-0x284fffffff flags 0x200] iw: 1 ig: 4096
>>    cxl region0: pci0000:e0:port1 cxl_port_setup_targets expected iw: 1 ig: 4096 ..
>>    cxl region0: pci0000:e0:port1 cxl_port_setup_targets got iw: 1 ig: 256 state: disabled ..
>>    cxl_port endpoint6: failed to attach decoder6.0 to region0: -6
>>    ..
>>    devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region4
>>    alloc_hpa: cxl region4: HPA allocation error (-34) ..
>>
>> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Smita,
> 
> Applied to cxl/fixes
> 75cea0776de5 cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled
> 
> Any chance to add the issue reproduce steps to a regression test script in CXL CLI test please? Thanks!

Thank you! Okay I will add it. That should be in ndctl/test?

Thanks
Smita

> 
>> ---
>> v2:
>>    Reworded commit message to focus on root cause per Dan's feedback.
>>    Dropped downstream details (IG/construct_region/hpa_alloc)
>>    Added error signatures.
>>    Link to v1: https://lore.kernel.org/r/20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com
>> ---
>>   drivers/cxl/core/hdm.c | 25 +++++++++----------------
>>   1 file changed, 9 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index c222e98ae736..cb5d5a047a9d 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>   	struct cxl_hdm *cxlhdm;
>>   	void __iomem *hdm;
>>   	u32 ctrl;
>> -	int i;
>>   
>>   	if (!info)
>>   		return false;
>> @@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>   		return false;
>>   
>>   	/*
>> -	 * If any decoders are committed already, there should not be any
>> -	 * emulated DVSEC decoders.
>> +	 * If HDM decoders are globally enabled, do not fall back to DVSEC
>> +	 * range emulation. Zeroed decoder registers after region teardown
>> +	 * do not imply absence of HDM capability.
>> +	 *
>> +	 * Falling back to DVSEC here would treat the decoder as AUTO and
>> +	 * may incorrectly latch default interleave settings.
>>   	 */
>> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
>> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
>> -		dev_dbg(&info->port->dev,
>> -			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
>> -			info->port->id, i,
>> -			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
>> -			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
>> -			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
>> -			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
>> -			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
>> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
>> -			return false;
>> -	}
>> +	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +	if (ctrl & CXL_HDM_DECODER_ENABLE)
>> +		return false;
>>   
>>   	return true;
>>   }
>>
>> base-commit: 93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d
> 

