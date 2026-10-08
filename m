Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BD4DE70C;
	Thu,  8 Oct 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482896; cv=fail; b=btrR0OaN7bz6OQoVII60PkuGuOO0Q/2Sba7ZvkjxCRWaNmY/Ja2DOSc6R+j4C8wSwRiW64YZWQfRzLd3bs34k0ZNi7ugy/Yp2jupUWYPwYfi/2vitLWIZGHJBnBa6w5iPWe8nV83i9NcM84dZdDALQknY9FUvXBwrgWukmxaIB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482896; c=relaxed/simple;
	bh=mUTa+w9e8YxN/zchzaupCdzZ2xG8zF2gfUo5mweUFP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSvg+BXXEqzEmedZFGw+/GZAmUZsf4A5VGSeCQ1LOKyiJ6/nsNl1cRcKp6nVICs801/TsTkjfbkJrHz+YaT9g5bp1Qg0gtVMDcomgwzdpcyVEHZXiU6Jr0mJuDYI7o7VtzeNTQJNuMwVCJQcKMlqv8Y0FaFAMmR+QLLxBrLCXAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CVTC4i8c; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CVTC4i8c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdarJHO95tgW+8DV5NdDOvJQxwosQ29hPULbATgRv/MeNbLoDXOANFzvUSdZIPvJtzINQ3s1B6ZSAWA2/48XZuBeap0TOhuLgiyuGP2BV13YVkKZuLm/VDDklx0b8AKZ6xfX7urnUk23M91CYhAoowPXx1z/qH8BbAs9lNjI/esaiWz7l/LWpe23SLwXPWW00ypCseIH5Xfb+KuYkP+9eu5fKGZ6pAai69sxS7RfJDF6uteHVY7N6ibLPIREqL7+mcSr4h148yuOlpTgI2wz/yN028QqMmnp2VybNeB2vppl9AMHJM7q6iZzZ4AIF9f3/KT54OhuP7hDREFg2zJkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyQJeGnSv3fnyzAdPHwHB2mL+Nxb1B5WVogR2+gOmRY=;
 b=yrjKTNBAVUfeAKdbyfQZfzfNmI+SAuEYwbmuo+nOuDjebuhgIOELMqbFuqdrV/e6g32+QFLdzA2BCPc71JfASBi4PtV1VPQXSkwbv6Hgt9QWONqdGI2ihXOPX5jEzVXPujtIZnXRLdktkdGIExDjwlbncXjoVd7th+QLdZE/JzYmGkqlXHoWQW5Nw/btOAet9SNXqWHHy93VxrjjNNLWOVzGi0+I1sg6YF8rSmqxMvdKl5h/ETDKD6xGp5Me1xcskwzG0nSiwf7Mw6fxRSPo7gDawHNMmUIaxsWjmB0xMx/wQZO9MSP0IyXPqnd3mOuT18VueREEV1EJQoTZP8Dy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyQJeGnSv3fnyzAdPHwHB2mL+Nxb1B5WVogR2+gOmRY=;
 b=CVTC4i8cBfd+vG8ze4ogSuu4vuTvaO1tdeuLRaMluXlM+85ba5ffILClbOW73Xk9Rqy9RyIiSilHYCRFjp5WfqTNOrllb/AlMS+ijP1tjx8w96LgpzYLAGBvaEYRrvKf2rMOVubuRsogChJzG7XDje6VLfMdII1/qhZ5Zp6tUXg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.17; Thu, 8 Oct 2026 18:08:10 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 18:08:09 +0000
Message-ID: <ba7731fe-f916-4e51-977b-95a0197bf52d@amd.com>
Date: Thu, 8 Oct 2026 19:07:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
 <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
 <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>
 <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
 <9114ec71-060f-48ae-a6e5-0b46a881c259@amd.com>
 <40fc791c-c03c-42f0-88be-7a97938ebe1c@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <40fc791c-c03c-42f0-88be-7a97938ebe1c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0227.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::14) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b825f3-bec9-48b7-6347-08df25671bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|11063799006|56012099006|5023799004|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	F5PIA2ZY7Wu6IehBE8vEqNQ2A2VL4d82mSeka5WV0ikfs3dnb9fSOA755H3GmBhacP/HxzGCMPDNSa9xgSLl7269Wc4kLL+to/PWmfepqF8beewEZLx4oaEHVFKCi5b1YC57/KjeucLRle3PyfJ1GGHnBEIpO9loL1N3yoJERsoLP2He8xLgCrYwozBiV495JVK/p1NeYXC5dOQfvOIiCCwt4I9xUSJiafk1A6ZnSu1gNRf5R98er8Z5wl4f6cuw+bB05eJFTcoJv1EZxp7a90mcu2KCZI6/NzZAKQgxYbD+GNUOfDJbMHJxJP4eVbwuLnpl3CKk3SjNHjz/YQ/w6OpGaZPjQNWnOzPyvq3ePV8Z5NXAdguOMMMN6oBRn3Bvb8vKsJtMadtqJrVqia4V66KOazmk2nVCbbjYzlFrdBFHuKoRRpnwzNzVKkrhsTLJ7ZY5MxMSjXHssmkk3Xbo+mjQ8bpOrwn7VvW6Vou8v79FqVV4W54R6eThO8Cl6h8k9dz+AR+4SXfmM+189xQmFSFPoxFPPC3I3Z5feBOwLDyoyk/2P4VujEtvxe3cu2DmsCrDJlJwW0P+Yun3PbSJr4iywj2GC/se6PASAhN1eNLq3C2t9H4QIb107mm4XZxsWdEGymOVtp73iydBK+NJumBveDwPOAJzxXTtFxVs62E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzFQang1UVhZU0dOWk9BMmVzY1ltT0cxZ1Y2WnQ4cmlVQXhHMXZvVHJZOUhr?=
 =?utf-8?B?Q25MR0RQdFVPbHJ6OHpoODVCQlpqV1gxSGZXZnpSb3dPM0NhNnZnT1BFZTNI?=
 =?utf-8?B?eVVvWlkrUDRRYVRWZkgzaFVZVHFyNVNtZHBwUTJTNndlOUI4NWZOVE1VOTVi?=
 =?utf-8?B?R2QzOHNSbE0rN0xvV0RvZHVZQmRnN05TNFFlOVFRbDhzWGU2K1Nldnh2Sk5P?=
 =?utf-8?B?WUlueXN2dTdoaVUza1doWWc0WldGeTlZVEExSmZEZFduNXMvdUhIL0xHSG9n?=
 =?utf-8?B?eEpSRDVXQm1HL2JhQjZaeC9TRXovbTEzMXYxU3ZoNVJYbEo4ZWN4MGQ2M1Vj?=
 =?utf-8?B?SkVvd3JoaGxHbkhWYXFzMlBrckRNdTErOXI0aEZKODA1OHVKU3NIOWh2T241?=
 =?utf-8?B?S3F6Wm1oWFBlYXRuVkUzOTFaUFQ4NHRHSkt1blhvaG5TUlIydi9NTjlaNkkw?=
 =?utf-8?B?QnRxL0dXZzQ2dHJCZUo0cVdHNmtqcVNTL2xLbmdNSDRuYUtBTk5UbXFDTkY1?=
 =?utf-8?B?NXhSRzlpNjJmbzhOU2JxczJZUDBLOG40clBJazZYUTFtTTdLa1lRZHY3SGEx?=
 =?utf-8?B?c0pIaFVkZTdGRVhJRmFxR3M2eHoveld5N1hoVklCRk5ucTNoNXBHcHRscE40?=
 =?utf-8?B?RFlleDJpQnB3MWt3YktkYkNEdUpQYzQwZzNocTFRa1M4U0VIQkFxa3l0d1VU?=
 =?utf-8?B?RlRtc0g1TEdtb2Y2UW45UHRPWi8rR0YvT3NvcG9BWndFem40L2lkbWRUWUto?=
 =?utf-8?B?Sldid1dDaWpQRVpvVWgyMnlLbkZWMCtnMlVkT1lqT0UxbUt4eXVZeXNtV1d6?=
 =?utf-8?B?ZHRERjZHZkJ2aVZadkY0NUdCbUpuRmZ1R1loaVVUUnN2eUxoVlVacGdlWGo5?=
 =?utf-8?B?eFdTWGUvbGlDQTkzdUF1NFRuR05XUkE2R3A2bW9yNjVSUDV6a3p4OUhUajZv?=
 =?utf-8?B?YlBiWENLZEh0MDl5R29DNVNMYy9ZcHBrMXdXTzFuNEUyN0RJZ2w4SEovcE9i?=
 =?utf-8?B?ZHJrMlBpdWxaTGVLTHkrM2ltbzRQMkZOdkZleWZWY3hiZjkwQTVjSVFpaU55?=
 =?utf-8?B?cG9VaWpnMWpSVXFtRnozb0FYQ3VDVnpVR2FlNGFydFdNRkVtUHhDaTNITWVp?=
 =?utf-8?B?a1lnTjkwWi9DRlIxb3RVQW41a0lVNlZlVkMrcFZtOC9BUlVvemRvUlJiOW02?=
 =?utf-8?B?UXlVMzg3Uk5nRFRzRk9GZDY3RC9EQ2tNcnpUNTlCcVlxUzZXVk5xYU90dHVJ?=
 =?utf-8?B?cnFqNUZYL0ZkU3VzQ2E1WDVONm1BUGZLc1htL2puaWlKMmNlVE1XT3Z6Smdu?=
 =?utf-8?B?RzFXcmpjTVREbUpUU1dJcDRwaVJsZERDWG9VVjRQNEVOc1JSMkd5TUxVQ2xM?=
 =?utf-8?B?OXNBM0d5QkowQzUzRnBhTEFKNHNGUGR6Q3lrUXErdWlIdUZ4c295S2pITzVZ?=
 =?utf-8?B?UXpTUGVmNk9JN2VaRzdDZFZmYlkwSkUyWURlNHRzOElwUU1wMzFpUEhzd3NX?=
 =?utf-8?B?emlVSmw4aVVvQ25LVjFsSnlleHIzdURyUU1QUGRJQkhZWkNJTzNxMzZrTmo5?=
 =?utf-8?B?MTkrek1aSC9QRUVxWThRUjQvWWZDRG1xbDVlV0NPeGFEdExtRlEvbXhKYXIv?=
 =?utf-8?B?bUIrTkhrcjBiakZBQUlJTitTL3J0ajRBNXJaei9ZK3JUUG8xUDBBdGRONVZU?=
 =?utf-8?B?ZXZSWk10QnRxbXFXb2l5YU9teHlXYWNOUWdyKzZDRVpROEpHb1VqT0Z5ZkNx?=
 =?utf-8?B?UytVWGdaTytRa0E2dEZGYXltaXpacWRpMEVRT05OUHUyRHBPMExYV203eGhP?=
 =?utf-8?B?NWJTb2d2RGU3RlFicS9Wb3ovZ1lOUDlaTVdEZ0t1RXFwZ0VpM3Z0RmxsdTlh?=
 =?utf-8?B?RHN2Y0IwMXNzcTE2TXlpclZ2WEgzTUlqLzFPeDBORGhPRWczVlBBblJ0RHU4?=
 =?utf-8?B?L05PSFNqQnRNakZlbkdQVk9yNGkwcjNiQ1I0K09kb1VZQkpWUGdLM2FUVm9T?=
 =?utf-8?B?Q2dNalduT2ZxcXI1THB1RXhRZ1g0TzhvYzZGUHloNitZLy9mNmx0anM2dXBG?=
 =?utf-8?B?cEZKVUVEVVZReHVQTUJocjJ6b01xL2w1SVVDeHlPL1EvblpISGNVRWlpYUV6?=
 =?utf-8?B?TTBLVDduOWlSakZqeU4raGdjQlY2SDNnWDhXQlBvRGtYRXpTbVJtdnlWQyt3?=
 =?utf-8?B?TS9jV0FmdC9xSThjeUlycUplZzd4a2oyaTAyWmpkU3dYeVVIRUlUckFTVnpM?=
 =?utf-8?B?eTF0UmZMZWp2RVQ2NnBGalQ0WXR1V2tKdi9UR2ViZWNvY3IvcXpCWmx5enhY?=
 =?utf-8?B?Q1BVRkhWZGpMNk9zYnIyb3VDK1BGOXJnVXB3dnhTYnJNL1VMUy9sQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b825f3-bec9-48b7-6347-08df25671bf8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 18:08:09.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68CneimXHZHKUahIVwOmeK+wKxOA/QdfGdP4oLgrGbD6azPTuFf2iBwlkzbQMA2jxdaaZV7Jun6dDKUaBA+l9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397


On 08/10/2026 17:18, Dave Jiang wrote:
>
> On 10/8/26 6:50 AM, Lucero Palau, Alejandro wrote:
>> On 02/10/2026 16:52, Dave Jiang wrote:
>>> On 10/1/26 9:41 PM, Lucero Palau, Alejandro wrote:
>>>> On 01/10/2026 22:38, Dave Jiang wrote:
>>>>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> Use a new field in cxl_attach_region struct for easily link it with the
>>>>>> region the memdev is attached to.
>>>>>>
>>>>>> This facilitates device links creation where such a region is the supplier
>>>>>> with non-PF0 physical functions wanting to use the CXL region being the
>>>>>> consumers.
>>>>>>
>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>> ---
>>>>>>     drivers/cxl/core/region.c | 1 +
>>>>>>     drivers/cxl/cxlmem.h      | 2 ++
>>>>>>     2 files changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>>> index 27e63e6dab7c..78ca7ebc3e55 100644
>>>>>> --- a/drivers/cxl/core/region.c
>>>>>> +++ b/drivers/cxl/core/region.c
>>>>>> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>>>         if (rc)
>>>>>>             return rc;
>>>>>>     +    attach->cxlr = cxlr;
>>>>>>         attach->hpa_range = (struct range) {
>>>>>>             .start = cxlr->params.res->start,
>>>>>>             .end = cxlr->params.res->end,
>>>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>>>> index c401e3a1af06..c598561b8e5f 100644
>>>>>> --- a/drivers/cxl/cxlmem.h
>>>>>> +++ b/drivers/cxl/cxlmem.h
>>>>>> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>>>>>>     /**
>>>>>>      * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>>>      * @attach: common core attachment descriptor
>>>>>> + * @cxlr: cxl region the memdev is attached to.
>>>>>>      * @hpa_range: physical address range of the region
>>>>>>      *
>>>>>>      * For the common simple case of a CXL device with private (non-general purpose
>>>>>> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>>>>>>      */
>>>>>>     struct cxl_attach_region {
>>>>>>         struct cxl_memdev_attach attach;
>>>>>> +    struct cxl_region *cxlr;
>>>>>>         struct range hpa_range;
>>>>>>     };
>>>>>>     
>>>>> attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.
>>>>>
>>>>> A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.
>>>> I do not think so. This version, see next patch, relies on locking the supplier, PF0, before getting the memdev and potentially using the attach region. Only on PF0 release can such a memdev and region disappear, so I think this is enough.
>>>>
>> Hi Dave,
>>
>>
>>> The memdev, yes. It's devm on PF0. The region, no. Unbinding the endpoint port, or cxl_mem from the memdev, runs endpoint_unregister_region() under the endpoint's lock, not PF0's. PF0's release is only queued (schedule_detach() -> detach_memdev()). Until that work runs, PF0 is bound, the memdev is found, hpa_range is valid, and attach->cxlr points at a freed region. Root teardown (kill_regions()) and delete_region also unregister the region without touching PF0.
>>
>> You are partially right. The problem is not that async detach_memdev() but the fact the region can be removed without the PF0 being aware ...
>>
>>
>> I was relying on the memdev being unregister first then the related device released later on, with the important part being the memdev being unregister making it unavailable to the other PFs because it can not be found in the cxl bus. I'm pretty sure about that scenario but I was not counting on sysfs unbinds for the endpoint device ...
>>
>>
>> I need to think further about this because I think it is wrong to remove the region in this case without PF0 or the memdev owner and original region consumer still unaware of it. One thing I tried to discuss with Dan was why we have the unbinding options for cxl_mem and cxl_port drivers. What is the point? I know this is standard linux device model, but the unbinding could do nothing if we decide so. Couldn't we? Otherwise, If there is a good reason for having this functionality where the unwinding can happen through different starting points, we should document it.
>>
>>
>> What I'm going to try is to link the region removal to Type2 driver removal as well, not necessarily with device links but through devm_action_or_reset links as we are already doing for other cases. And I think to document the different objects/devices involved and its lifetime depending on the current unwinding supported would be good to have, so I will work on that as well.
>>
>>
> So there are multiple paths a region can go away without PF0 knowing and sysfs is only one of the triggers.
> 1. endpoint port teardown -> endpoint_unregister_region()
> 2. root decoder teardown -> kill_regions()
> 3. userspace delete region
> 4. some other places calling unregister_region().
>
> Using suppress_bind_attrs only hides the sysfs files. There's also device hot-remove and module unload in addition to root decoder action and user action. So doing that is definitely the wrong way to go.
>
> The path of PF0 going first is fine. The memdev goes with it. The bug path is region going first. Something needs to deal with the stale attach->cxlr. You need a region-side teardown clearing attach->cxlr under the cxl_rwsem.region before unregistering. And readers need to check under the same lock. The endpoint_detach_attach_region() proposal does close that hole.


I tried to discuss this with Dan unsuccessfully, so I hope I can make my 
point clear: having so many ways of cxl objects/devices being destroyed 
is, IMO, wrong. Moreover, some user actions on things created by a Type2 
driver should not be so easy accessed, and definitely, having a region 
unregistered and released with its main consumer and owner completely 
unaware, should not be happening.


Dan and I addressed some concerns with "these options" but it is worse 
after realising now port and region can also suffer from unbinding 
actions. We contemplated memdev unbinding and that is supported, and 
acpi module removal as well (all the unwinding is hopefully right for 
sfc driver removal), but the fact is, current Type2 support is unsound. 
It is likely good enough with current usage expectations but something 
to improve/fix.


All this user space potential actions were implemented mainly for 
testing (I guess you know this). I did ask Dan about it, and I was 
expecting use cases where HDM decoders and regions are dynamically 
created, which makes a lot of sense to me, but the fact is all is 
relying on firmware/BIOS configuration. Richard is working on adding 
this functionality for Type2 and pmems, and Jonathan considers it 
theoretically useful as well, but the way is going to be handled 
requires, IMO, further thinking and maybe a change before someone starts 
using it (does anyone know about users now?).


As a summary, if we allow user space actions (at least for Type2) they 
need to be consistent and somehow protected.


Finally, you did not answer my question: what is the point user space 
removing and endpoint port handled by a Type2 driver? What about the cxl 
region? Maybe I am missing a necessity I can not see here, so please, 
help me to understand this if that is the case.


Thanks,

Alejandro.


>
> DJ
>
>> Thank you,
>>
>> Alejandro
>>
>>
>>> I attached an LLM generated test kernel module you can use to reproduce the KASAN complaint. Commit log provides instructions.
>>> BUG: KASAN: slab-use-after-free in device_link_add+0x521/0xa80
>>>    cxl_get_range_and_link+0xa9/0x120 [cxl_core]
>>>
>>> DJ
>>>
>>>> I added comments in the exported function, cxl_get_range_and_link() which does the locking before calling the internal function __cxl_get_range_and_link() which looks for the memdev and the attach region. In fact, it should not be possible to obtain the PF0 memdev reference and the attach region not there yet, but the code is still checking that possibility as a sanity check.
>>>>
>>>>
>>>> Thank you,
>>>>
>>>> Alejandro.
>>>>
>>>>
>>>>> How about something like this?
>>>>>
>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>> index 27e63e6dab7c..38ca73f12b84 100644
>>>>> --- a/drivers/cxl/core/region.c
>>>>> +++ b/drivers/cxl/core/region.c
>>>>> @@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>>>>>         return 0;
>>>>>     }
>>>>>     +/*
>>>>> + * Invalidate @attach before the region goes away so that
>>>>> + * cxl_get_range_and_link() can not pick up a stale region.
>>>>> + */
>>>>> +static void endpoint_detach_attach_region(void *_attach)
>>>>> +{
>>>>> +    struct cxl_attach_region *attach = _attach;
>>>>> +    struct cxl_region *cxlr;
>>>>> +
>>>>> +    scoped_guard(rwsem_write, &cxl_rwsem.region) {
>>>>> +        cxlr = attach->cxlr;
>>>>> +        WRITE_ONCE(attach->cxlr, NULL);
>>>>> +        attach->hpa_range = DEFINE_RANGE(0, -1);
>>>>> +    }
>>>>> +    endpoint_unregister_region(cxlr);
>>>>> +}
>>>>> +
>>>>>     /*
>>>>>      * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
>>>>>      * simple case of single mapped decoder per memdev.
>>>>> @@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>>           /* Only teardown regions that pass validation, ignore the rest */
>>>>>         get_device(&cxlr->dev);
>>>>> -    rc = devm_add_action_or_reset(&endpoint->dev,
>>>>> -                      endpoint_unregister_region, cxlr);
>>>>> -    if (rc)
>>>>> +    /*
>>>>> +     * Not devm_add_action_or_reset(): the reset path would take
>>>>> +     * cxl_rwsem.region for write while it is held for read here. The
>>>>> +     * endpoint lock keeps the action from running before @attach is set.
>>>>> +     */
>>>>> +    rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
>>>>> +                 attach);
>>>>> +    if (rc) {
>>>>> +        put_device(&cxlr->dev);
>>>>>             return rc;
>>>>> +    }
>>>>>           attach->hpa_range = (struct range) {
>>>>>             .start = cxlr->params.res->start,
>>>>>             .end = cxlr->params.res->end,
>>>>>         };
>>>>> +    WRITE_ONCE(attach->cxlr, cxlr);
>>>>>         return 0;
>>>>>     }
>>>>>     EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>>> index c401e3a1af06..7cd3a69cd5f5 100644
>>>>> --- a/drivers/cxl/cxlmem.h
>>>>> +++ b/drivers/cxl/cxlmem.h
>>>>> @@ -104,6 +104,8 @@ struct cxl_memdev_attach {
>>>>>     /**
>>>>>      * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>>      * @attach: common core attachment descriptor
>>>>> + * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
>>>>> + *    before the region is unregistered
>>>>>      * @hpa_range: physical address range of the region
>>>>>      *
>>>>>      * For the common simple case of a CXL device with private (non-general purpose
>>>>> @@ -112,6 +114,7 @@ struct cxl_memdev_attach {
>>>>>      */
>>>>>     struct cxl_attach_region {
>>>>>         struct cxl_memdev_attach attach;
>>>>> +    struct cxl_region *cxlr;
>>>>>         struct range hpa_range;
>>>>>     };
>>>>>     
