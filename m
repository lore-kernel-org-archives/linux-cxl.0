Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2047.outbound.protection.outlook.com [40.92.50.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3442AB3
	for <linux-cxl@vger.kernel.org>; Wed, 27 Nov 2024 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680441; cv=fail; b=KVQK76RTCPMpfhtBgYB86DnrVRr4bf6Nv/tr2zTp98rYv+gVhd++nMsdZtuGMebhbpkq8N0q44BBExKOncY79LlDaJ/Ibnb8QEdhGsIKyeEA+Xg8dTo2IO9QYV+1SncljTx2+JKJYufNXzsMZ5+UCW4C6DCErGctPFpMSYQVN7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680441; c=relaxed/simple;
	bh=rEQbbVzdQbgLll4aZZegJAjxWFW2S7Gr3M3vQPmWXkA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJzdU3xnA0uHK8h6GBax/rmfUhQMncfYvKXRc45zVODV6NCmOUOXhZPP9jQt1UvPDlrnu6YOkOXPCoAa8ocVAXK+DzsbvLAT6PWRmajfHe421siMF0MgcKwxFwhpKmojBOWyl7kJtdphh83S1ArqKeu0GJZH1qd0CGJFsiWg8Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Am+Q7k10; arc=fail smtp.client-ip=40.92.50.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Am+Q7k10"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DISufTtfoPiJLBQLo4SRZ3hwFMgUFd/le0BJAatXZflhsoi2V2VWOp1A783yhFNC5ufeAK5KAuLJRwzXPivzn4Lan10Fkdqk6xFGBWO4ELolv/4NrHqW4O+d8KZNcQCzPlzTb0+6HwMjZitCkrwT+f8P7wCin3o3Y7SWiGsvWnSQqnAiKoUEQnLLPTSJ09XOJnkE2P7/uw3X1ZO87JsEmBjvF6bo7z46Yf4y2bEuZLRQrvz6m1JHae6vMhjdsbUyAmFWOTEaA5V56wkTR4qw7cGL2hC6WJtUPIscWgYbaEwu+UR07weYfGBALiI8ppFWrguAth2TygUXvta7ombsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhuhxH6cF4xsSpqWZDpnGcmZlLVHOZL6H+wgemPNH/M=;
 b=e/P+ztvzI+OHYXP0FTfrk8EYRJAgh56D+Uiv/aiiHvCsz+dM+UuZtHt8P20VHoR8Z8cxjnTrRO9uV2bNBZlbqhboF7QSehgv5mW+59jm5bqLJEZgEEcYNPsxp2Ce954OBqwI2vy9+b4JrwAvnhhY4K0EeeGYpDmuXYymsaMuqLqT1UI4IdWgbPFyd8aCMDRsE8+E8pBwDb8SSZrdNFu4EvzKVauzFLstfJmV+WFBCfxjbbk2Wlj+qUoHjKSa9jeT27EJkP6fSgIU6Bj61nrWgA3zaXzExK0mc/Xxwaq+xIn2l92spacApiNfgyveWKc3ORsDiIVdkbZrWEYGyTjRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhuhxH6cF4xsSpqWZDpnGcmZlLVHOZL6H+wgemPNH/M=;
 b=Am+Q7k10n+lztf9YEi8Uv/6hstbDqyOwJ63RAPFLUR898o4z9CgW/YNklSSluUDi8VBxAKGf6886n0l3sp3Q591cGUO1Hyj8ZKiNA00G1HnZ+IO1VprwqUyOBB3NdSIVYB13YediVuaKvo5R+UfZ+t+BYZPA/aRUA2Wa4qIP6c1vlIgufyDxQqxwwdsqoePIKBDCI56uJw0MlO4ZAHIG45jlKTmeX/CwrdEih51zvUvtCvVeUFeyrGX0MNswLBsFm2axgR6BUm2CEWIIIVgzEJMk0f26A5IE3mlUKZIPwTROT1hx8N14CMTV2aNUqCYxhEQxWrRQO+Of7fQubXkU8A==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by GVXPR10MB8197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 04:06:45 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 04:06:45 +0000
Message-ID:
 <VI1PR10MB201641D1AF221FD0E5058B40CE282@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Wed, 27 Nov 2024 12:06:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] cxl/pci: Fake bandwidth for platform devices
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>
References: <20241122072001.94758-1-ming4.li@outlook.com>
 <VI1PR10MB2016B406BFB45480FEDDCA50CE232@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
 <2c96fbd5-4dd9-4abf-83ab-3938dcd8fd8e@fujitsu.com>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <2c96fbd5-4dd9-4abf-83ab-3938dcd8fd8e@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:404:a::17) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <2cb52e19-6694-405f-87dc-97dd8318068c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|GVXPR10MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c4bf35-225e-4d1e-c059-08dd0e98e7f7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|6090799003|19110799003|36102599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlQxeC9SbHJmbWdNcTk0UlppTWphZ1dyeGFXTTBLRVBneStoenpEMWVLSWJM?=
 =?utf-8?B?dGlPVHl1eXhjekdJT2RHVVFTU1RTMHpqOUVORHMvTHFmYlhSTUFrelhHSTVC?=
 =?utf-8?B?d3hDa2drS0FwL3JkVmFBU01RZGxhNGluNzl0NTNoOFlMUFp5VjJ6aktqQjU3?=
 =?utf-8?B?WW5zdDl2am1odk9SQk9SeGROcGJEMml4dGx3NEROZmtuNTZPWW1nRjJlSHM5?=
 =?utf-8?B?amFIdE1GZlRxZGlkeFdKeHJMNHV1eXQ4R3RaMnZITFdQSHJ5VnBOMG5wOEda?=
 =?utf-8?B?SkF0UFVJaVIwNG5hSUdITEVybkdEZEpnejZJV1JZd3VlYjdkYXhPb1RSM3k0?=
 =?utf-8?B?a1kvY2RvZ3FFZ0ZXWlBrKzNwSkhrZkJBWGFtOHdOcGUyVDlnaFhXNXRKVFJv?=
 =?utf-8?B?c08vRUk3TnVVQWR3VnAweFBCZXZLYk5IL20wN09XaU13TXZrOGg2UTZ2NTJE?=
 =?utf-8?B?bnZNSXYzTGpYL25tbjBYWFRpNjhPN1RKL2ZSWm1RQWhyeWNLYm02aXJQaVR2?=
 =?utf-8?B?aVZidEx1R3U5N2k5Z0lReEJSNHo3bndOM0dCdkpwWlRWcjFrK010NEoxdkZW?=
 =?utf-8?B?NmZxbjN5ZWtwM0hDOHhJU3lVTjNaSFp5bXVwaE5mLzdwTk45UWVnR29ZTFNq?=
 =?utf-8?B?djBnY2NMbU9HYmM0Q25xT2RsRlBzSkROQVllUEtPSm82NmJpckVkdklYNW9F?=
 =?utf-8?B?ZkE2STVCS3IwUk1mdjJLWEVrYTdyMU8zeTdQd3JNeEE1UkRMUnVVeDBWVTdP?=
 =?utf-8?B?TkkxVTZTOWhFMEhwVXJ5WnFpV0ZzV2J2ZEpRSGpBQWdYZW9tSXBkdGhDc2tK?=
 =?utf-8?B?Y056SWR0cFdyRlpBbWw2aFczazRGKzB6M0I2eHdTSzhqOGNnRElqTm83VWZs?=
 =?utf-8?B?WUJIaElCc1dHZnVEdmUwMjFzUFpVUlhNbXBQOHJMbjBtZ3k2YkNJNUtuN2d5?=
 =?utf-8?B?VlRCMm1NWWNIdTBuWkVWNzFnejlVR0FEeUh4Q2hCMm9reU92NnhhWGx4RHg3?=
 =?utf-8?B?d0JiWi9CQnZ2NEJDTTkrWk8wZEs1aUtEd0tIVjFCSnhsMWJYTVBjQTR4Rmxa?=
 =?utf-8?B?MGQzTU01VnRYa0ZRS1hOeUlNd3pkQ2JYSng4TjRpTDVoU21hZ0tpbk84cjRo?=
 =?utf-8?B?djhDSVpzTitraE5VcjF1dGUyd0FiT0ZsMDZ2WUlPLzVPQ2c3QXp4NGZpTlRF?=
 =?utf-8?B?YkpkU3g2V0s1dDhINm92UHl6VUNBV1loaTN3T2pzc0F1YmdIKzNEVWpncUFB?=
 =?utf-8?B?QkIveWVxaEdPQmVOY05ZSTVFWFhQUU5sVEExYlVYSGVqVk9sZXRRT0dCOXh2?=
 =?utf-8?B?RDJhNm1CK2hqUnArZGFOWmJrZGFBRUczQmQ4QzFIZWxFYkFKZjIvN3dXUy9l?=
 =?utf-8?B?OWY3aXhiWnFEOWk3enJkVjRwWFlyMFRRd1QxRjA5ZDVxZDh5M2l0RmlnQU43?=
 =?utf-8?Q?QtuLCqzI?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJVUlFHdld4MUhOWGorNWtZUzFPNWZ2WXA3MzRBWXpwekt3YXBLRGJpUXZY?=
 =?utf-8?B?aGZYMTJqaWxDTnZjY3NqZzZoRC9HRUk4eDRLYVNjVmpSaGxxOGp0c0F5QUUr?=
 =?utf-8?B?c2ZjR2EyaEJ6TXd5alFBaDdqbDBuYlJvUWYydzh0Zk4yYTBWYzBEcnRTVGUv?=
 =?utf-8?B?Ky9LZ24yTERhNElzK2hwbFYxd0VhdTk0NVFWTkxNVXhDM3VSakNOUjVjMzcr?=
 =?utf-8?B?aGt3MjJyc0s1ajFNendudmtrOVAwbXFhalQxWGtFT3BqU3BEaExPWmNmd0lG?=
 =?utf-8?B?L08wTnJaLytTWGJ0TWJTQ0o1eUhnd1ZheHFaVEhjWHZSeC9PN3g3SFJsRXh1?=
 =?utf-8?B?NXRzbk12SmQ2Y0hIbW9VamQvLzBkMjNhcFJFb0hjZlFUTFU2cE5MYWRIUnJQ?=
 =?utf-8?B?dExGM2YyUUR5ZFNJeHJENU56WVpmSFN4cmoxS2NiOGg2TGZwOXI3UnM3UVhh?=
 =?utf-8?B?TW5MbDNsMkwyTTYvS1Zscm5EYzdBL2JkcDR6RHdGYzJhdVEvRlQ3bExpYkxW?=
 =?utf-8?B?WXFpRlo5Z21yVzUrbmMvWXAyc2RXeEVza2ozVC9DNE9jc1VKTVRiZlFBNlUw?=
 =?utf-8?B?NFRKbGdBbzh3QytWbUdQN1czUkl0YWpVdHhFTnRISkdIaGJhR2duMHkxdzl0?=
 =?utf-8?B?ZXZTZUd1cEthYmo4NkpwQnkvdGJKY3ZXZjEydTJTU2tVd3QyOUZ2aGZCRHBx?=
 =?utf-8?B?Nzg4d3Z1QWFCVmViOG12eVFTaTJFaEZxcitlN1FYZDM4bEdoTHc1SUhMeCtz?=
 =?utf-8?B?YTlKKzBSZTBsQmsvMWtkaGZmTDRnUTdMOXBzLzV5M1hTb2QxRitVeU9VVm91?=
 =?utf-8?B?c3Q1MVJjam54ajRtWERrK2pDTzlWTjVHUGg2YkRSN3J6UjMwYmFVMkhXeFJr?=
 =?utf-8?B?VER1aFAvK3FITk16WHpNMlNQSzQwc0hTMnl2RStQZjExUWJwQ0J1Tnh5ZFcv?=
 =?utf-8?B?MnFsU25LdzhkeFU1NWM1TzVMQm9vRmo1a21JMUxTcGZXVkNzaDdhcC9wR0FJ?=
 =?utf-8?B?UkkwVlZTeCt1ZDZHSTJOMkJHMVhia25OYkFzbjRGVDVDc25QREQ2T05FMzgz?=
 =?utf-8?B?d08vTHA1WGJScnhGMkN4THdTTk9NTGJBSUNwOUhtdEU4QlVZRzlybUpXSFBW?=
 =?utf-8?B?WFVhdlVsNFNNaEVab1hiNitsSWNJSml3RmRLWVRBRnR5dXFRTHhFMVJabzJu?=
 =?utf-8?B?ZXJiUlNUdVNzWEFYS1RHUEdxNWhSTEZDUmJ4NHYwT3pEbnNVREo4U2psTDl0?=
 =?utf-8?B?a1VtMWFzRE1zYU1QT2RjVDNxamVsN3g5ZXFqdTh6bFozQ2Uyek5LNkU5NHJS?=
 =?utf-8?B?V0xRSk5CMmF3cDc4SktrczRpdlFtK1NlMHZ5RDBMSFBnWWNxV2h1eUZTak8w?=
 =?utf-8?B?OExqQlpWUGxyajMwcEV4Q2hsV0piaGRnUXJ4SUR5NmtKaVFuNERPZnVSd2d5?=
 =?utf-8?B?ci85NUtIeXN2NW0vNG42TTRMRkZSclRpVi85RnlYV1J1c25tOGxyM1NEK29N?=
 =?utf-8?B?VUtiU2dxMkRqRVM1WUhIR092ZWJDRGJKeFpKNHduNVRvY0lCMUZOTkd6RGts?=
 =?utf-8?B?S003NE53WEUydytXOHpiWVZVQzBjVSs4aUZrclFEVnIyVG9WWlZtL2p0bzRs?=
 =?utf-8?Q?IuZocuRSBaXjTfGYrH6iiKvvyKE3I/pyuAzzh1GljWTE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c4bf35-225e-4d1e-c059-08dd0e98e7f7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 04:06:45.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8197



On 11/27/2024 11:44 AM, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 22/11/2024 15:20, Li Ming wrote:
>> cxl-test environment always hits below call trace with KASAN
>> enabled
>>
>>   BUG: KASAN: slab-out-of-bounds in pcie_capability_read_word+0x1df/0x220
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x82/0xd0
>>    print_report+0xcb/0x5d0
>>    kasan_report+0xbd/0xf0
>>    pcie_capability_read_word+0x1df/0x220
>>    pcie_link_speed_mbps+0x6a/0x130
>>    cxl_pci_get_bandwidth+0x68/0x1c0 [cxl_core]
>>    cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x780 [cxl_core]
>>    cxl_region_shared_upstream_bandwidth_update+0x257/0x1640 [cxl_core]
>>    cxl_region_attach+0x1025/0x1e80 [cxl_core]
>>    cxl_add_to_region+0x121/0x14c0 [cxl_core]
>>    discover_region+0xa5/0x150 [cxl_port]
> 
> Is this testing on the upstream kernel?
> I guessed this have been fixed by
> cce3cd647721 cxl/core: Return error when cxl_endpoint_gather_bandwidth() handles a non-PCI device
> 
> 
> Thanks
> Zhijian

Hi Zhijian,

The commit you provided should fix the issue as well.
I test it with tag cxl-for-6.13 which based on 6.12-rc5 not include the commit. The commit was included since 6.12-rc7, That is why I can reproduce this issue.
If we already has a fix for that, please ignore this patch, sorry about that.

Ming

