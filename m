Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DD2F0661
	for <linux-cxl@vger.kernel.org>; Tue,  5 May 2026 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014418; cv=fail; b=CU9MxHF2i+9zdLx8Tny7fc5ZZpJLQG1yixooJfy1E5lq1voUj6WNmsuVAL3HBQ7GF3+MkvmJLoiyjxM5y6d1ssAM9ZcHo+437PNQlUWwqA2qlfIqbVoZdMpoMjUiuOW7LO9rPlYAPSTVZQeTINElZahQaeraLUE6eLG+9qXmkDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014418; c=relaxed/simple;
	bh=yQFQubbUTPILf20z7hiXIZfZRBwYExd3l8Md4UuIXk8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kImUK8DvWWSDkCyjN26z4KpOfzFZwzjL5L1OCloiulaUV7soLFYIjQ/1LN0lqRvFQ3P3f5qvjkL8iBCDJJpO/vZO9huNtnDHiHb+LgXvbGjI+iljFSBpokJfPCZoa8NqOPvDQYVKRWM7HcJkWF59dFUdLPlg0nhHTS7GvCDMz/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QOZmNpJd; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QOZmNpJd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dw8bybbKMGrTc9CygHgwQ3Fh69H1dYkTbQiVUQtSlTWAIdX2FAKtNXCwT2BXhm5Y/tq0DBIGWSUeLg2R5ttF5DpMUEJpu68idWKXrdILhuwI4AX5vx2xgCsTc+JZzIe9bIC5l8WXEJQwFv3U5ZtmhyN/19r/scV1H2f9QYH+u+9Zz/bkAx+bI5N2CUu0JHFZKNX+qNs/Y4i/CeE0V17MZtpw8g1QXPuWE6g/ovDFtxQG90EEjdHVYhlISew2g9ZlgVizg1MhDTrRyaa+CEsCY2dksz7d+KAdLAUA5ycpmJ+4iNHInNamJoq3M5Yra35EFdEzKGRI3D2Hp7CoSK8IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUIeGGoJ0NdAcAVJeoYJ4k18JGPcv928ZCOknqaUhVY=;
 b=k3rc/dirk/IfbaUcPxHP8pD6evMXPTNiLBzkgEhZV+7rRvgBL/mVqxHwyPCjppbyNDQpchHmX0IpNdUdUSt12EI+NCuacfmnQ94QqVEDTEHta+86HFPbUqnBnWgXr4NRIy+zn3wjtDJcL2gU/F7Ql4xzqOjZfXDSF2aFztjVSdRLqLeu8dCJIRtRyFBHJVCoc9fjum3VyOUdbhOGxfg2tzqtaeuSIGfXe5fMpqeR/VqX9M2u7xeqoxDWxmjYCKuAuWFf2H2JsP8NkFkiOo6FYVHVZvn6k8eVtOCim0btQMPOY+tuvb91wB8IVz3q17jf5GmexEqThY/ktkHmx30Iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUIeGGoJ0NdAcAVJeoYJ4k18JGPcv928ZCOknqaUhVY=;
 b=QOZmNpJdz0q+4TbO6dfHZQStxdDE0pLWC2d59G+Zt0wn3Tog0p9RHgUtbhDjMMEvo5CVCG5UuYbq1WExfaAZeUmKXalwwoZENlRAHq8EnuLH7JTDuJP7XFIkuHD3wKn1fs001lbfiECQpWZqtqRMBFTL/nyFIb/ycrst11zi72Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 20:51:32 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:51:32 +0000
Message-ID: <9aaf07a6-ffc9-4474-835c-bbc6ddf84472@amd.com>
Date: Tue, 5 May 2026 21:51:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
Content-Language: en-US
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
 <69f409325f7c0_3291a910046@djbw-dev.notmuch>
 <b5110c3e-c5ee-4305-b307-704837fe4f9c@amd.com>
 <69f54967edd72_3291a9100c3@djbw-dev.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69f54967edd72_3291a9100c3@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fb0785-06c6-4c6b-4090-08deaae816a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TSib9sxEdQSbMnXZ997jz2HqWAZNKaOfxxIc9pqA4kXxERCwPv6dSp8MmgT7RMspVrXQIZbf5Qc9Ot4kRTZFjUKh8SNzV4IUJq+/dQkyogOYIWW8Lp4P1fZKJJQ/SEdxNSSIDu8jqUBonzcYku/ZehCuLuBTIzZWvwCBr7fLJOJGtvhTgjjEnFw8DWD1XZqFMtNO8MRIfu+p2qM5fxHivkAS2LFVafmwC6cwyxZ/IXausqD1cSXcFeNOiF40oFnuOPx9FSUvKsSh/vTXFxu6ptAiJWWs06CWG9BB//OG6/gZ9RWVk3+emVd2hKV1yzcUWIUiV+M+5cHtBRUNfKv9qH7SbjQ3+uyJ7dA+kgmRCoqQKhfzgQpE0wgkHPp8Vo+9UJwAd42eZDyyY1Im5dIp77+aUyGR+tbkRmR3o0LXoMZccCMPFQHFKeawSBEhIEW8ytNFrA6toV3tOw9Ge/vMPOD13wMcy3Pza3jEYjNOivOj3HB+BjbUl6IlNy+ADzophShEb2WbF8k3Nyhvdh+b9Vw8CHCCHY015RLb93/MPZiYpC7ujuJLfDiB9mXKa58BKmg5lTIW7VCLkFByoBPq26Hx2o1vxsN6MNBoQh9mNN4pJuWmmX3wpUJDEC+RSV9OmDddIc/0xdD4Nvkkw/dgZeJ04qDrN0Gh3iZ59QjconUbs3OS0DsUtbNEqIPR+/Oa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlloMkZvY2RSMG4xOHBFLzVoand5NFQyNWhlVjlMbmRJblhRcVVXKzAzNTAy?=
 =?utf-8?B?bFF2KzN6d1FzZzMzVnNyc2FUY05FbGRESUk4dm9EQWZ2TjRsRmd5TzNGaUFy?=
 =?utf-8?B?dEtvWmk1QWppU093REc2V2swUmwvMWtCNGhIcEQvZGc0L2ZvWHN1akczYmtx?=
 =?utf-8?B?akZMMTVhb25McmRoMFRJUkxFM011Nnp0YXVlYUNSalM4VTF4WDJZajN0SGtJ?=
 =?utf-8?B?aDJVUGdXU2VTY211Q09Eb0psUW81bERzTnp3Z3R0Uml2cVM4cEoydXEvQmpJ?=
 =?utf-8?B?Y09ub2pKY201eHVZMjk2OS9vN3ZPbi9xWFpIZUZIWUpjcVc3Q1VReTUzb1VJ?=
 =?utf-8?B?dHl5NHN1NEdwdzlvTU5LaWVoSDJjYnJzMDdTTTAzbG0wWE1aWVFsSDhFa2tQ?=
 =?utf-8?B?ZkRndTBwT0RJbi9HQXNsZkVtZkFZOHRDNlBFUkYwb1ZIWk82NzNYZ3d5RzJY?=
 =?utf-8?B?RzFaN2ZQVTVqQ205b0xSaW4rTUJjNDY1aU1ha0ZvTUZwdFNuRkgyMjliRE9u?=
 =?utf-8?B?RUlZV2NVRTROYkYvYmJDdXg1YjZUdjdVT1RWdEZrYWlMM2szcmd0QzdwQWtW?=
 =?utf-8?B?T1BlRGZFUXJiTUR2SjRQbXRRellHekIvZXg2cGk4TGhqNy9uS3JZYi9Ha0t2?=
 =?utf-8?B?SmtodGlsTkFEeWpXZHY3SzNUaG5zME82OS9wUDVPcEUrN05PWEVrSFF5b1Js?=
 =?utf-8?B?ak1lcUNFdHhiVS9JSElSNGYxbXpxR1R6WU5YS0oyN1ZPUHhwZlJIQzNUa0VQ?=
 =?utf-8?B?alJlSlA4aitVMXprR3hJSHN1dk56Zmpzd2w4M25QVUxjUmllMVd1OHg4OW4r?=
 =?utf-8?B?bFpWTit1L3NDY3JCQUp5OFBnNjBESk1oRTJWS0V0TnJQanRqZk9GdVcrQyts?=
 =?utf-8?B?R3FmN1JjUnhLNWp6M0FtSjBHU2xSVlduWUFwQlhwcVJ2Q1RheDAvZjM5azJK?=
 =?utf-8?B?S2ovTjdMZytsN3QraVgyeHg1UjVYaEU4NktnQkxkdTZqODh4WGwzeFV5RDdt?=
 =?utf-8?B?RXZJQjhkNUVoUURqQlhwZlBxYmtyZDRCZVJiSVZtUnpocXlNMFZRdDRNdVBh?=
 =?utf-8?B?Q0loS2c2aFhxeWV2dGF5YmtyeWE0UDFzVUxGV3lZazF1SHhKaStyOFBOU3pn?=
 =?utf-8?B?cUNWUHRrdWNiMk16VGVSemZleHJsNGVGaUY0N2JoWk5TbW1TRGdnejFVbU5M?=
 =?utf-8?B?U29JT3FPcjZzTU5ua3FzZytBdG1vRUJVV3NzUzhEQzVoVU9tanU1WGg3T243?=
 =?utf-8?B?d2xDQm5GQS9yeHRMRWY2bSsxdEZYQW9WTU1pZ0NGWUdZTWs3bDVZUGR1SWxk?=
 =?utf-8?B?YnFKU0tPUlVuSnZBek9IY1hwVFpLUmo1emcrS04zaWVibmVvTWw4SE1GeVZE?=
 =?utf-8?B?Q2FxenNkTWhka1Ric0NXRm0rK0QrSXhCYXBqZWxEYnlZOWx4VXpPbGZ3R25Q?=
 =?utf-8?B?Wk4rakRROGdoelZUMCtQZ2V3ZStoSjQ0dlhURVZWcmUxZjBpcmQ3a3dyZTlp?=
 =?utf-8?B?SlRROHBqYTRQd01PUVVUSFM0SDFIaTMwMmpPSVFSYmIwdDNvRXk5bDNsbmFF?=
 =?utf-8?B?bkQrS0dpdU9MYWYxSzM4dHBXMjZSaitYWEMrOFVUczFTZmR0R2RnbW51ZHZO?=
 =?utf-8?B?MUszaFVwc3NEZ1dzem9Xc2FMSlpRSEFUNDNTQ1ZsWW9rb1pmUU93SUI3RGNG?=
 =?utf-8?B?YUE1VFAxRkdGaUV0aVdkL1dsTjFldUNVN1g5WUlhem92eE1CU2t0Z0Z0a1lZ?=
 =?utf-8?B?M3MyekRScTJOZ2JBc1B0K2g4dFZmM2VPRXV6NmQvb2x5U3FQY3JQTUdLemlm?=
 =?utf-8?B?QzZNdTdQMVYwaitUNnhIaTVyUWcyalBaKyt5aU1BTk9aVzJFRlV2Nko2aVFr?=
 =?utf-8?B?NkNaNVlHVlgxOWlCcjBmOS9Sd3Q0cGVtRS9XcHZXVExUbE14dmplTEdJeDFQ?=
 =?utf-8?B?OCswYTBMY21LUDhFbFIwb0NEMmVocCt1RDYwWS9pSmF2QmwrRXFWMk9VeWZi?=
 =?utf-8?B?YVIrK1UxaGRrT3R4NjdVY2s1UDlyblcyQWdycmt4am0vVXJJMXVOOXlkWmpx?=
 =?utf-8?B?d0I5K0NtUklydmhGRE1Cd3Fub2hNU1l5ckc4ZTRlYjR4SE1oT0Z5N3VERFBM?=
 =?utf-8?B?UzZ0QUhnMmRnTUxXQlZ6VzBoQnhrTlhuUnROUDJDS0tURnM1cDlNVHp0TmNn?=
 =?utf-8?B?RGhOTHZta0lDRURrV1h6Z2ZPOTdYbUMyRDhNQm5qSm5nMlZ1NFFYUjF2RW1P?=
 =?utf-8?B?YTBJVzRuTUNUTEt3UlhRUldoWFRxbURkS0szY2lyZWZYZUhjSEJuMFVTYjZF?=
 =?utf-8?B?MHV2VnMvT2RjbXMwK0FpSTJtM2ZmRFFoeHFJT2JGQU0zZHluNm5Edz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fb0785-06c6-4c6b-4090-08deaae816a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:51:32.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nQ8ZMTUNQxEVxgGEyY7132DdrX0C9IRXhnmrcfMGiJOTVW3Kw7auPgKN9pzja0MkI/vpR5DVeMcQow+tD2jnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845


On 5/2/26 01:46, Dan Williams (nvidia) wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>>> +	}
>>> A couple problems here.
>>>
>>> 1/ Nothing stops a CXL class device from implementing a decoder with
>>>      CXL_DECODER_DEVMEM (HDM-DB).
>> Uhmmm...
> Consider a helpful expander that does not require the host OS to use
> cpu_cache_invalidate_memregion() whenever DPA space is changed. I
> imagine that would be useful for DCD where there could be a higher
> frequency of extent changes.


What do you want here then? We had a param for specifically asking for 
creating a dax device for the region, but it was considered unnecessary, 
and I think it was you then. Should I put it back?


>>>> +	/* hold endpoint lock to setup autoremove of the region */
>>>> +	guard(device)(&endpoint->dev);
>>> This does not handle the case when ->endpoint is an ERR_PTR() because
>>> the memdev never attached in the first instance.
>> Not sure about this but, is it not the success of devm_cxl_add_memdev()
>> ensuring this can not happen?
> That is only ensured by using the "attach" mechanism.
> devm_cxl_add_memdev(..., NULL) is only for the generic memory expander
> case. Where the entire usage model is governed by memdev ABIs.
>

Is your concern that the memdev probe could not happen synchronously so 
a further call like the one implemented here could fail due to the 
endpoint not there yet?


If so, I do not think that is possible with cxl_mem driver using 
PROBE_FORCE_SYNCHRONOUS. It can happen for the case of the device 
connected to a cxl switch port which has not been initialised yet, as 
you described to me in the LPC when I asked for a case for needing the 
memdev attach call.


>> Note I decouple region attach from memdev creation. No memdev, no call
>> to this function.
> Which leads to this problem.


If I am right with my previous assertion, which problem do you refer to 
here?


>
>>>> +/* Called at driver exit or when user space triggers cxl region removal. */
>>>> +static void efx_cxl_unmap_region(void *data) {
>>>> +	struct efx_probe_data *probe_data = data;
>>>> +
>>>> +	probe_data->cxl_pio_initialised = false;
>>>> +	iounmap(probe_data->cxl->ctpio_cxl);
>>>> +}
>>> I do not see how an async event can safely zap that ctpio_cxl space with
>>> zero coordination with the driver, and I do not think you want to burden
>>> the fast path with new locks to coordinate this.
>> You should look patch 8 where your concern is hopefully tackled. I need
>> to test this further, but there is no need of additional locks.
> Please do not structure patches with bugs in the middle of the series.
> It burns reviewer resources.


Could you be more specific about the bug?


I'm introducing a detach callback here which will do things necessary up 
to this point/patch in the driver functionality. In patch 8 the detach 
code is extended to unwind the use of ctpio buffers which are not used 
until that same patch.


>>> Can we please stick with the violent but simple "unload driver" approach
>>> for now? Someone removing cxl_acpi, disabling port drivers, or disabling
>>> the cxl_mem driver gets to keep all the pieces. Just like force
>>> unloading your storage driver underneath your root filesystem. Do not do
>>> it unless you want to see the fireworks or test various hotplug flows.
>>
>> I have to disagree. The use of CXL is only part of the datapath. The
>> driver can keep going without CXL. The related buffers can be used until
>> the sync between the efx_ef10_disable_piobufs() added in patch 8 and the
>> CXL CTPIO datapath.
>>
>>
>> Although the option of unloading the driver is possible, I do not think
>> CXL should decide what to do here when there exists another option.
> The concern is creeping complexity. There is no such concept in existing
> Linux drivers where an MMIO mapping disappears out from underneath a
> running driver. It may start returning all 0xff and fire an error
> interrupt, but the driver does not need to worry about responding to
> async unmap.
>
> All drivers must already be prepared to be unloaded. So we start with
> the simple semantic first to get this functionality landed and then
> think about adding sophistication like live fallback to PCI operation.


Ok. Let's try this one. You want to trigger device_release_driver or 
something similar on the pci_dev->dev linked to the memdev. Right?

Do we have this support now? If we do not, have you evaluated the 
complexity required for ensuring no deadlocks if this is triggered while 
the sfc driver is still probing?

Maybe I'm overthinking this option, so if you have a clear idea about 
how to do this, please tell me, assuming it is a matter of calling such 
a pci_dev "unbinding" from its current driver.


