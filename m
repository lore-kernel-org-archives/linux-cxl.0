Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740233F8AA;
	Sat, 29 Aug 2026 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787987217; cv=fail; b=jsngHx60yw3nMXsG8KUSplcx5l6CsWM4uLBCVNHhe3V5kUGUd8Ou8KVzcX3luTIiSycZUclzq5Z3qxWuq3eNbs+43U5bOakUzyK9gBtXL8vfyFHQMEgMDoM0el4tSrbDIzTPUo/JZIugAlVPnIZPFFfOtPgcmq6z2GjAg2SkRgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787987217; c=relaxed/simple;
	bh=/Y0aGarGc+MTrg5dIko7eA3SXnxKwobwh2huKZpzhWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6qnUT+Dxy9hVO842t3La6L+C5R2up9FJVKZrxiFgxH0WTBMk+IJWrlp1uE3NNPUNyM3AQC71aIdkEvvgwRTk5DysltRSBTfh7nHmDe5gecZZH2SruU+VqE6OMUoRI86KpKApVDVupRqL4svkxygFe3Fvt/tkWCnaXbx0WOytEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xfR4DXTe; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xfR4DXTe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0QSXZ5xt1demVbO8PdWc1XN/I6Sai0t+jyFMgVfpr2ztu1iTdBTWM+v3+i0N0FCWNVjH+LASgDoCw3WrXlaRbPMxZ5xk0+1RGPbjJANfwR5Zea/eNkgx8WjoBbQHKhzcTB5t85xpounzgWpfsIDpb4uokOvBs3AeLmYKhEexR4iZ/Gc4BcxrRmQ1hJ2U0G3A0m61kXOTeQgZUX0obX9gCoT6O2QOc6x4NCl7JEJdO7CpSL6CE01l6uFhz8lREbXF07ALAeygK59trpOMbEJYlrcS3rBN+pTChzyDrbUasU9RJbWTSTxRwW2RpO230KOGAQULNVQ174lgiLNCiO3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCJF2tfyKaUt42f+98vi1rdrcnz+JhTrdf2NI4Ka55k=;
 b=GfBfs4jWqW98XEhuBewKfQ3SaV/2FHKKdsQVWuuAR6HQ5F0LwGHQFd7uw+y2heZ9pttIr/RK9LXUKOIQzborYizuBAVmQdlpVzP2ybbSbJ2S/BBtYl5oEp3RZQnhXpaM1FgSPx97RGjM14n8p/D7QmTETK0wzLbvd48PtFy+kM9CstOoLNnyIteepsXSmoxOYjrgij2H/rtZxrhLKYDhYW0SN8rgLBNZS1SUOoPnrFjqiT5JTLHJTixTy/huR1ZPuSQGpUcJqnsTdflT+bySPc5YMMZlHAWAsDl2vK9WfwFL+tAP5bLAl1lhgrlVOgQVS3FrNximS0AMWbxMpKURCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCJF2tfyKaUt42f+98vi1rdrcnz+JhTrdf2NI4Ka55k=;
 b=xfR4DXTeNzUvJejmYfAqcNsgiAPWewCuBAyIJROf/XfGn+HwmkuOUfNCbWYuhaCXRFoguzQJ3lSj270J0W3OLyCAhbQ15XyR1e6gSfMFMHp3+FrselD6fgL7V9yWRDDDYphafaHd7Kej/Lhg5fLWXdt2qLYwHVU1f7GdU/+JHTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 07:06:51 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 07:06:51 +0000
Message-ID: <173a8a29-2ea9-4231-815c-c6b0cca3ed80@amd.com>
Date: Sat, 29 Aug 2026 08:06:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] cxl/memdev: add support for mutipf device
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
 <aov-jfhJtNtZJxlN@MWDK4CY14F> <a313b340-9263-4204-b0b2-bc492cf746a4@amd.com>
 <2a7d2d8c-ff02-4f2f-94d8-21d64dd77f82@amd.com> <apErJUX77f4x02LH@MWDK4CY14F>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <apErJUX77f4x02LH@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::6) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: d574bc3b-1cf6-4a60-bc90-08df059c19b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	scxoAwXBHJ/FTJwBP0CYNr/d1Ki1bFHQEjpU8dRFQvXdvVDAkcG37mQlcz+Ze+8O7EzliuVfthS3mZWC9LvLfDnSVl4w9BmWmBfTXN1ph077O01SjShaQu6CpXXg3wL2HbaHyN5v3eVDh9vcLf96aCojU3OqGAYFFDpPNzXFYLOAxzPJNJfV9C/Rz8H1QzTofXge8BJFogn7Th5O6j9sfrXO3qnXqAYHKRE1ABXRSpHcXzIWCOkLUTfHYxj8ADjSH9Rs9wyQVRYCAqZhf+MWe6A5vR6ru4xttTf1J3uIvbAGYtrb3y4UPVPEyU7iDMiwkJuPeUoBVvEW6nmDINhIbT8MIDdA0aL+oYjBLOmYk/Lg9zhSVdlGKrPZkItOhz0nbNmWAfsOS+uJpLUUj6/vF7ik/y3dh30ogV+N7+tuSF06L4+2boxopZ4JS+C1OICujISQz4dm3/w21lFeKS0FNIpc2wt1B8Mgdjd2PePK8JH1aHRqlbuIQSkkwzKf2fp07lj/vpGayqyzdk2jpkg6VWg4WEwa1G6nenqvewlymWk9/Cv/5UlE+oK4QcHYQjLyveZM+LisdPldsbFFsL2IpCb0S6ntQ2gL4bUwX2NxpGjsQ6KxSHmV5KadR3JVUecCMgPxBLjxp84gS1WHuFsKjnqCsAZrvWVbY751kdG2YAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDIyeG5zRWtqd1pKV01pOFNTc0p0WjFhdTlWZW1DbktMZVJZRVFzNUpsblVC?=
 =?utf-8?B?eGRuam9WOG94NTMzYmtiaU5UMEVFZ2Z3Si95cG9USkJGbG93ZWFkSjN1YjJr?=
 =?utf-8?B?d1dyMHVabjRFUHkrRzlEMnVCdTJiMG90UUxhcC9Mclh3ZFVWMThrZWVqTHJY?=
 =?utf-8?B?K3FDR0JVR2QvVDdoTm1QRGhJQjBjSTlJbUtrS1B1amFlK2puRmR3QkFNc0dY?=
 =?utf-8?B?bU1JRHlhb1BhSStqSkZOMU5wdS9IOWlXUWFHNUVITnRHSmJ4ZWs0dEVoQ0Rh?=
 =?utf-8?B?VzdHY0VmOHFZVXNmK0J2Skpuc3B5OENnUmV3MWJJRnlSWG5TbS9vaHNuREd3?=
 =?utf-8?B?RTRzR0s4a25CdSsrQmV2Q3E2RDV4ODluRGV6V1Y5VHJ2OGNpZnFCWWpsZUt4?=
 =?utf-8?B?Q2xpVDh3ai9qVlFWSTgza2ZRV1Q0NmdkR2Q4cUxwVnhVM2ZWaFVERk0wQzBC?=
 =?utf-8?B?d3pJQ1B2em1vMmhGRDRNUTQxdWg1Tlk2bFhuYXBQQ3BhTVpMaXJJQm95eThU?=
 =?utf-8?B?NlIxL2hNSEMvd21xZERBM2NQTFJDdjNaSnZuaUVZYVJlUVVNVW9zV0lzSlpV?=
 =?utf-8?B?TXNuTDJrdnk2YitJVjJiL05aUVAzdVFiOS9TV0JScU1OMmpUVGoranNrNDY0?=
 =?utf-8?B?cnllZ3AxMDZBcFhoTGtJbVg5Rks5YnlqQ1Q3eFNZYjZLSXBzQlEwenVDT1hq?=
 =?utf-8?B?TklFNnB5YVA3UDQxcTc2bmZBR2lodmF5cFB2ZyttbVZNdDFyc0djYTFHa0VK?=
 =?utf-8?B?azYveW5JVmFCVzU5WEJUWjQ1YkhKS2hVQXR1VUZVcVYvU3BkQndQZHpZekV5?=
 =?utf-8?B?QUphWHdYMDZwZ2dRMHF3c0lnUUZ1OFdibU1HNnpCUnkzRkpiNFVkRHpseUhR?=
 =?utf-8?B?WWtlZE9JYk1BUUVGT0pqUlhiOGdRQXQ3N2tLY2ZyS1FMSHFmQ1BTdmtxbFFU?=
 =?utf-8?B?ZWxvbGtSc2dMTTZDVE5mdXNlWHpoTU9tQkhPZTNxd1BpQk9WOHVPSGNaejI5?=
 =?utf-8?B?cFBtdzZUMUpaOU16VE5ncUpOdGhUZ3ZQVkVFR0xENUFSVjVyVGhIa0FRMHFi?=
 =?utf-8?B?MGJhUkUxSmZ1dCtYaDhGUzdzRC8wZit6Z1c5UEhGNFFYME41SklGV1ByY0hz?=
 =?utf-8?B?U3JkM1daaGZPaGJ1alg3eFJEdC9aOTJCSmdjYlludnFFYlhSRDhLTEduamg5?=
 =?utf-8?B?RUJLTjFWb0wwSU1xM2c3cXZBVXZ4WW9JMS9lNWY3dVdCSnRTUlFKZWlHNU9u?=
 =?utf-8?B?Z0dDNVpzVS9qNjNKT1BDZ09iUzY2VFJkNjJ5c2V3N2NDY1FNd05Oanpha3ZQ?=
 =?utf-8?B?R1cxekt3OUFoMk9NVFRlSGQvaTlJSDZ0RWVTMjYwZXZabE5rOERLZHA0eEow?=
 =?utf-8?B?V0lGV3FCRFZqdERxbEI3eUk0VDFCNldZcGwrVjBVeG1wWkhyaXNwYUFZbjc2?=
 =?utf-8?B?QVdncXZYVE43OG5La29Iek1NVGJQRjJPTGsrNGQwdFQ0ZFJVampTWjk2OFhO?=
 =?utf-8?B?bUhLSXV2a0ZscjJ0UDdiMW54VHdYRFhUcnhPeXBrdzg5bm1pZVpWYitSTHpy?=
 =?utf-8?B?amtjSUNJZU5DZVhBcG83cGNrbXUwcUF2SkFNMlpOdytiRnhBL25MZll1UVlx?=
 =?utf-8?B?aEdHOXpIaXNNRHh4dFc0NmNvcFk2bUFyWEVvV1JBeU5DTEY1VEdkMmRhdzFy?=
 =?utf-8?B?cjlvN0NpaXNDSXc0c0ErNHhBTG15S29OTEdpeUluSEtpeFd2WjZzc1hBZHI4?=
 =?utf-8?B?eXNYV0FiT0FrZ3YyVTZJUEZhWVdjUnRweHlmTjBvYy9iTDhoTUdVZWl4dGJt?=
 =?utf-8?B?QnBRR1N3Y1FUTjRvTnJvTWxQTXFQbER2Mng3R2tvdFh4N05WTHFCRW9IQmsr?=
 =?utf-8?B?S3FySmJ1QXdkbWx0YlR4Mk5ON0kwZTBHUUtNVDh0V1ZKL0tyTWNwRE4zYjBO?=
 =?utf-8?B?V2xRM2VlbjJ3OHJIMklqcG1Sc2lNb2FGbXNKcUwrRXFBaTI1SDhoaXpMWXBF?=
 =?utf-8?B?c0M1R3pWYWpIM3RtZ2dCc090SXIzWnIxYWtYelZVTU9LUTdqNStKNFNDSFJK?=
 =?utf-8?B?bDN3REJyYmpKcDlQVmU3dFVpM245UnZlanZXRU1ITCthQ2dQNDIxakpLWW9E?=
 =?utf-8?B?MzZlNWNkWkxoeHMyNjZyMXpGNENzdUd1L0Vldk9Samc2MUdoOS9NRmp4VWpI?=
 =?utf-8?B?OVZpNnJWUEJ2TFhFSXRpM0NHTUh4dXlUQ2QvRWg5S0JvUEs0ZkRwVDFVLzhS?=
 =?utf-8?B?TVN6Nk9VdEpETEl1bUZaWGk4K0lpRlFZcGlXS2hPVU1CcTNPU29WcmhpME5P?=
 =?utf-8?B?UlptbUhaRTExeFVuWDRIalZRLzgvK3lOaVlSMHRhV1JTMjFaSnMxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d574bc3b-1cf6-4a60-bc90-08df059c19b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 07:06:51.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpnKiGnnxcKzy2Q41jdSzgs/MreD3YQCLm5baa2I2cbaOlB3WEOmFUMjtsCIeEerb1/O1AgSo40/ROdnOQS+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353


On 28/08/2026 09:15, Richard Cheng wrote:
> On Thu, Aug 27, 2026 at 06:44:42PM +0800, Lucero Palau, Alejandro wrote:
>> On 25/08/2026 08:37, Lucero Palau, Alejandro wrote:
>>> On 24/08/2026 09:33, Richard Cheng wrote:
>>>> On Fri, Aug 21, 2026 at 04:51:33PM
>>>> +0800,alejandro.lucero-palau@amd.com wrote:
>>>>> From: Alejandro Lucero<alucerop@amd.com>
>>>>>
>>>>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>>>>> specs restrict to the first one, PF0, the discovery and management of
>>>>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>>>>> obtain the CXL.mem range to work with somehow.
>>>>>
>>>>> Although this could be handled internally by an accelerator/Type2
>>>>> driver, it requires to properly handle changes to the CXL mem device,
>>>>> mainly its release by the CXL core, but also potential CXL device
>>>>> resets. When this release happens, those other PFs need to be
>>>>> told about
>>>>> it.
>>>>>
>>>>> Implement a way for non-PF0 PFs to register/unregister to the memdev
>>>>> linked to the PF0 device. At memdev release, trigger the release of
>>>>> those non-PF0 PFs devices registered to such memdev from the
>>>>> driver they
>>>>> are bound to.
>>>>>
>> <snip>
>>
>>>> I suggest replacing cxl_get_pf0_memdev() and cxl_put_pf0_memdev()
>>>> with another
>>>> helper, e.g.:
>>>>
>>>> int cxl_memdev_link_consumer(struct device *pf0, struct device
>>>> *consumer, struct range *range);
>>>>    It should live in cxl/core/memdev.c , and the behavior is
>>>> something like
>>>>
>>>> 1. Find PF0's memdev and take a temp ref.
>>>> 2. Lock the memdev
>>>> 3. Verify that the memdev is still registered, driver-bound,
>>>> attached, and has a valid HPA range
>>>> 4. Create a managed devce link via device_link_add(consumer,
>>>> &cxlmd->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
>>>
>>> Interesting approach.
>>>
>>>
>>> Not sure this could do the proper thing though.
>>> DL_FLAG_AUTOREMOVE_CONSUMER seems to remove the link, cxlmd->dev in your
>>> case, when consume driver unbinds ... but it is the other way what we
>>> need. Maybe I do not understand well all the implications with this
>>> approach, so let me study it.
>>
>> I'm having problems just trying to implement the supposedly basic
>> functionality linking the cxlmd device with the non-PF0 device, I mean
>> without thinking about potential races with this approach (I think it has
>> less problems in this regard than my approach).
>>
>>
>> I can use DL_FLAG_AUTOREMOVE_SUPPLIER with the supplier being cxlmd->dev, so
>> at device unbinding it can trigger the non-PF0 device unbinding as well. But
>> it seems all this link code is quite related to PM, so some checks at link
>> creation fail. I have tried using DL_FLAGS_SYNC_STATE_ONLY along with the
>> previous one, but another check precludes the link creation if both are used
>> (See device_link_flag_is_sync_state_only() ).
>>
>>
>> Do you have any advice here?
>>
>>
> Hi Alejandro,
>
> Thanks for trying the device-link approach. I wonder what deivce-link eperiment you actually execute ?
> Though I don't have your HW, maybe we can discuss on the experiment method ?
>
>  From what I can know from the current driver-core behavior is
> - DL_FALG_SYNC_STATE_ONLY | DL_FLAG_AUTOREMOVE_SUPPLIER is rejected by design
> - a sync-state-only link won't enforce consumer unbind
> - DL_FLAG_AUTOREMOVE_SUPPLIER alone is a valid flag combination, so a NULL there depends on runtime state or
>    the specific device relationship
>
> You're right that DL_FLAG_AUTOREMOVE_CONSUMER means the link is removed when the consumer driver unbinds.
> Now we get it more clear that, the autoremove flag control the liftetime of the link, they don't control supplier-to-consumer unbind direction.
>
> For normal managed device link, driver core unbinds active consumers before unbinding the supplier.
> For this case I think DL_FLAG_AUTOREMOVE_CONSUMER is appropriate since the non-PF0 driver creates the dependency during probe and no longer
> needs it after that driver unbinds.


I was confused with the flags. A non-PF0 function should be able to 
delete the link without triggering the unbinding of the supplier, and 
the supplier unbinding should trigger the non-PF0 unbinding. The flag 
seems to do the first one, and the implicit functionality when unbinding 
the supplier does the second thing. So, I think this could do what we need.

However,  I can not (properly) test it, because the supplier is checked 
with device_pm_initialized() and it fails for the memdev device and I 
guess it will with the region device as well. If I remove the check, it 
all works, so maybe adding some support for this case and conditionally 
do such PM check could be the way to go, as it simplifies a lot the 
design. I will study this further and see the implications.


Thanks!


> But I rethink about linking consumer to cxlmd->dev, memdev is not the object whose lifetime defines whether the returned HPA range is valid.
> An open /dev/cxl/memX can keep the memdev object alive even after the EP and region have been torn down.
>
> I am not sure but cxl_region seems like a more accurate supplier, it provides vaid HPA to consumers.
>
> I let GPT sketched the implementation of the API I was thinking about, maybe something like the following.
>
> """
>    int cxl_memdev_link_region_consumer(struct cxl_memdev *cxlmd,
>    				    struct device *consumer,
>    				    struct range *range)
>    {
>    	struct device *decoder_dev __free(put_device) = NULL;
>    	struct device *region_dev __free(put_device) = NULL;
>    	struct cxl_endpoint_decoder *cxled;
>    	struct cxl_region_params *p;
>    	struct cxl_region *cxlr = NULL;
>    	struct cxl_port *endpoint;
>    	struct device_link *link;
>
>    	endpoint = cxlmd->endpoint;
>    	if (!endpoint)
>    		return -EPROBE_DEFER;
>
>    	/*
>    	 * Endpoint removal owns region teardown, so this prevents the
>    	 * endpoint and its decoder children from disappearing while the
>    	 * supplier is being resolved.
>    	 */
>    	guard(device)(&endpoint->dev);
>
>    	if (!endpoint->dev.driver)
>    		return -EPROBE_DEFER;
>
>    	decoder_dev = device_find_child(&endpoint->dev, NULL,
>    					first_mapped_decoder);
>    	if (!decoder_dev)
>    		return -EPROBE_DEFER;
>
>    	cxled = to_cxl_endpoint_decoder(decoder_dev);
>
>    	/*
>    	 * Take an independent region-device reference while the decoder to
>    	 * region association is protected. The association is revalidated
>    	 * below after taking the region device lock.
>    	 */
>    	scoped_guard(rwsem_read, &cxl_rwsem.region) {
>    		cxlr = cxled->cxld.region;
>    		if (!cxlr)
>    			return -EPROBE_DEFER;
>
>    		region_dev = get_device(&cxlr->dev);
>    	}
>
>    	/*
>    	 * Serialize link creation against region driver unbind. Without this,
>    	 * a link could be added after device_links_busy() has already marked
>    	 * the supplier as unbinding and walked its existing consumers.
>    	 */
>    	guard(device)(region_dev);
>    	guard(rwsem_read)(&cxl_rwsem.region);
>    	guard(rwsem_read)(&cxl_rwsem.dpa);
>
>    	p = &cxlr->params;
>
>    	if (!region_dev->driver ||
>    	    cxled->cxld.region != cxlr ||
>    	    p->state != CXL_CONFIG_COMMIT ||
>    	    !p->res ||
>    	    p->nr_targets != 1)
>    		return -EPROBE_DEFER;
>
>    	link = device_link_add(consumer, region_dev,
>    			       DL_FLAG_AUTOREMOVE_CONSUMER);
>    	if (!link)
>    		return -ENXIO;
>
>    	*range = (struct range) {
>    		.start = p->res->start,
>    		.end = p->res->end,
>    	};
>
>    	return 0;
>    }
> """
>
> I think it needs more tweaks, but hope it can give you some idea.
>
> The intended ordering is then,
>
> non-PF0 probe -> validate comitted region -> create (consumer, region) managed link -> copy HPA range -> map the PF slice
> region teardown -> driver core sees an active/probing consumer -> wait -> unbind the non-PF0 driver -> consumer unmaps its HPA slice -> AUTOREMOVE_CONSUMER removes the link -> region teardown removes the decoder
>
> driver core can manage the device references and drops the supplier lock before forcing consumer unbind.
>
> Does it match the behavior you need ?
>
> Best regards,
> Richard Cheng.
