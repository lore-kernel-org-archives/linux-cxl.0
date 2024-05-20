Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02454660
	for <linux-cxl@vger.kernel.org>; Mon, 20 May 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220182; cv=fail; b=kZ3+/aujJX84ZdUq9delQ4BnjNexB4873VO73MZjyuOGobQolgY4Y2HFXHOCnr05XUehgEct2KZTgWGbERT9fvI7ojGyLOjmIQ7Z3S3pbng7pmJ5hV/6nJUycfIRipLueSLQbbzZmnDI0qyQBu5MeD9/SMbiRCnPxKC6GKJb/Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220182; c=relaxed/simple;
	bh=KtPz9WC3Em4fuLcP2btTbZA0O7Up+VNOXNDj9jfZH1w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGKJajqxY6eKv7Qg+rvp3blUtdVIciW+YmiyvPlJliQM7Fc4ed7wEnUaLm0Jz95Y8efHvbedbACTATgfekXPmjd6Ib1etn8h16n0HjdUyYkhfvlKiI4BWMSD2/xvPDmw0HtYekvSkd21fpM92eIpeOp73uTNgZUBmpCoZHVCTJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKD7Gkdu; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKD7Gkdu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4uVk3rWY5GyjAhDswplxqhn/TizZHRNAi845vbZ3sc/242eYx5cOgf/8iST2QOnPFvMH0sxkOY55qBoTzWJH985Ctvgs0pEhehNABmx3xGtUX8KS8c769OnKM2AG25zZQdQY1nsR/cULXLub6ddPOmHvhjUX71dcbnuLcJ9GQpZzbgtfHKMD4NtWF3CzRabHxoa7Z9Ot/zW4c1DIjElEnYxEISH8Idby09aNalMTp/MtzZybwzSFZcnDB5gd63nZ322lkCsuyfJW8ScmNQ0eYaUz0Bqu+5em4X1P/xY+oxQDGecAUGkulqreaklWwRtAeocHuez5tKArp5Lg5srnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zktJKHCJyVoDjBsSNoEZkzIHjDIREMxcmfO96WuaAcM=;
 b=nME0H0ThBm9amiR7QbFd4/CZcaRaRt4GguVtUSYcBcHLUgeokPrKwj2txOFz3iFqXhOXOsyxwwnQsdyy0xaLVfEjGNNBpIpbKPAKunZcfPx9G+xzAedkfD1RhppzR1Ew7zseoiNl/kmNOcIMveANkeZM9kB2iYrmKppupqIDdGsh/1/fvM3KSBIyWcKtU2MnhrGmxw92hQ0E2QiBmu+r/oUicRgEm0g1ITdZDhR7f4qWw3Wcf8ZBlHtiaC1D/wVsspFAPKUZ2WTC5VkH9brGYGtH1/I4iX1A1v+cTIyWodoukxwt5KSdGVrnm035zkAXNVSbw6pyRSebkMTLg+f8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zktJKHCJyVoDjBsSNoEZkzIHjDIREMxcmfO96WuaAcM=;
 b=GKD7GkduQOYvPtQ8s04P+jlzC+2wID+YgEdBeLF4EctR8B5mFow3Bz0ltvS2X510T/wweD3HGXek7O8cunBNuk7erxEjxL+wsI2TD9p4WRiFTHdJepd8Siu9nw+xjBiYqNwA4tS4e4v0+IZbZyMobxchEwfLeJGKrqKrry9PmGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 15:49:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 15:49:36 +0000
Message-ID: <9f58faaf-a15f-c7cc-8248-67ea6b311a31@amd.com>
Date: Mon, 20 May 2024 16:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 04/13] cxl: allow devices without mailbox capability
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-5-alucerop@amd.com>
 <20240517153343.000066e6@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240517153343.000066e6@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: b8494208-bcf2-41ec-f03c-08dc78e47373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZwRDdVV0hZdE1DQzhFbGlMdE85SlpTMG9oYjROVldodW1YVjdCbW10Z3pu?=
 =?utf-8?B?d2l6Y1ZyZnVGV1IrY3o2QVl4WU5TNFhBZ2FBK0I2blVqZndablhDOVAzM0V1?=
 =?utf-8?B?UHMzcUpLV3RMTzJ5cTlEaUxtWVdpbldOY0FyZDNyajRmT09mbTVNQm92Y3Za?=
 =?utf-8?B?RFRHZXEralNlWTdxeDlMNEpMRmdIbVlLTi9nSkFrWXVKZGJSdERHTk92WWVN?=
 =?utf-8?B?b1lVMW1vS1FRL1dRVnhwMk0wRStaUUVOdVNxSXE1TzR2NjdDQXVqU2dxc0ZX?=
 =?utf-8?B?TFIraTB1dWZvaEJhMVBQNDl1VDc3RnRESHp6eitCemZmWmVnM1dObkwwMDJG?=
 =?utf-8?B?T3JQcU8vNWZqbDZqM3BTbHBKZWdJNXp1aXRBek5xODdqMERSbXdsZ2ZuL3Ar?=
 =?utf-8?B?RlN3eUZ2cjVvTzdIek1NSVErdjhLeFc1VjNXdzFGNXUweWRZb1pvRHNMK084?=
 =?utf-8?B?ZDhVOExFZVM2R3dFT1dIc3R3cUkrREJ2dEZJbFRhdDIvaXluNlVtWnora3hM?=
 =?utf-8?B?VWxIaVNOWG9YS3JSbzhReERlUFA3Y3orbzNMTjVVQTE3enluaXZpWU1OV3kw?=
 =?utf-8?B?ZWgyM01PekVRb0lBWHZlYjRFRE4xaTN6cHl1WXV2SExjdXlLQ0U3WE1MaWpj?=
 =?utf-8?B?QnVzbFhkTC9vejdNSEhZWmI3L3JudjEwaVJua2JKOWlxK0loQ3g3WmpkY3o4?=
 =?utf-8?B?MW9tZXk0aURtK1U2dExpNXRRMWMrcWt2NCtkZ01YcjFPMzVZMjJwWGxkYk9m?=
 =?utf-8?B?NCt4czRuaXZoS2pnT3JNOXMvcnl6MkNQbWtuSWxrK3h6V0pGdVpHMVM4QlVp?=
 =?utf-8?B?V0lZMGRRSUFiK3hKKzRWN2dMc2dIM1RXYVZKNWxkL1lPZ0JXdjJDdVFJaXNH?=
 =?utf-8?B?VGU1d0dPSzkrcXpQVytTbisyaEtIMTlEczc4UWdjaGVJeGRFY1NEZ1NNQ0NX?=
 =?utf-8?B?eTg1UTBOM045Y2pXem9JS1Rwb2g4UllwMnlPdklVK29YdEMxM1F4bU85Rk5H?=
 =?utf-8?B?TGt3UWVIMmdMekU4NkwvclcvU2tBcmkwdHJaWkVDTmlHWTd4Q05LZkdsWXYw?=
 =?utf-8?B?K0xZdHV3Nk5NMDJDOXF0eWFJbFJrc1dHM2NJTEFmZDdmSnZBWjZGYkwzK3NS?=
 =?utf-8?B?SEZuc2VKa1ZWUUNHeUZUWC9tUHNwMERaRnlRZWNFWktTeG9xNUtMRHpmL1Zn?=
 =?utf-8?B?aUZ4WGRvaURtTmEwSTdOUFhvQjgyMGJXM0NoWUtSa1hQdVlrdlU0R2RHbnB2?=
 =?utf-8?B?WHNjNmNJc1Y5Tm9yMTJsd3R1cVM3NXJ2dGI4c3F0MjIvMzk1WFV1dndPMG9O?=
 =?utf-8?B?Uitva0FxMkdOTEJkNWszNmNMSUE5T0IvV1ZadmlmaU5wYlltRStmeHpJMUs3?=
 =?utf-8?B?eU5OcDhVVEkwMndwUXAvVGl3cUVNU1RMaFY5bHZweG5WbTZmb01pcmhoRUhF?=
 =?utf-8?B?UWIzcENRT1haTy9JZjFlUUhGMGt2Qlp4U2M0OTR4aGxVMmN5K3B0ak8xdHBm?=
 =?utf-8?B?eGRjK3Y0aWxPM29VMUUveVNFR2hxa3JMZmFXSVRwRk81TjlrN1ZadGsrZWgx?=
 =?utf-8?B?cC9TUEJXVjIyV0E0NmV2Sk5jQ2p6VGZQVnJiL1RVVXYyNXpjNVBHTVEwUVo0?=
 =?utf-8?B?cGk3L21lSHdBQUlPbkcvUzhkRFJ3cXVoNTRLcHIyVVZjYkhoOWlFVzhqZnNI?=
 =?utf-8?B?eGVwVVNkalNYVmRXSUVQcFNsbjZtSnI5aWdQK2dTdnFTVFcvSlROSTdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b09XUzFNVVVDYnc3cVg4WW9OOG1VdDFaRVFSN1V3em5MbzI3R2NON2hWR2Jl?=
 =?utf-8?B?eDhXM2g1ZzZpVzd0K0N3Uld6RTlKdzV3bkNFeEtqTUI3ME9Tb3F0Y0JERVpN?=
 =?utf-8?B?djRvQXVOZWxoTjdrL2RIN2NsQ1E5Zy8yRUhSVFNoQVlDLzJ6dHY1eTVLZ3B1?=
 =?utf-8?B?RFdqUkUzSWo0bm9GSGxqYjFCZFlLNzNJd2pGMjFJc3gyNGZ1djIzTkIxeU1n?=
 =?utf-8?B?Q2NNeVJsQkNsdW9Iem9lUmthYkk2cXE2TUVOS0xMMXNqc3hVbjY5Qjh1eVFT?=
 =?utf-8?B?MnBYaE9hZWF6UXVXT25MSkNTaVpNREkzKzRDYTJDUEt3UUFETFZGMG5VMjRF?=
 =?utf-8?B?KzJRbzBlR3A0NWtUaVNTVG9mS2NEYU41VWd6YWhoWVB6cE0rak5ySHA5K1Jw?=
 =?utf-8?B?akQ4UG9XTFlPZ0ZZN0oxdEVodGg0MG5KWmVtL0ltOWEweTcrZjNtQmg3ZnQy?=
 =?utf-8?B?bDNmbGEwQkwxM2FzUXRETGlJZW5GOFJhQ0RSNnVYRjJoVStaTzl6OHAzWUla?=
 =?utf-8?B?VmpkUG93RzlDTTFyd3k0bGRjNXBodC9xVGZZZFl2UWpraEhvNHcwbWVHdGR3?=
 =?utf-8?B?VXNWb3pFUU81T2ZzVUxZOFJjejVMK1p6UE11Nm90NHVIWnhyaWNmQWZyYklk?=
 =?utf-8?B?c2RYN1czR05IVkF2bWl2dVJVOThmWTJvSzVSeVhMMTc3RHJPOW9QT3JOSFpv?=
 =?utf-8?B?dklWa0VHbWZoRXZsK3k1clNCaG1jdjRlTnU3MzZwRnhNWm5XV2lTanR1ZUlX?=
 =?utf-8?B?RVJ2TFRYTE0rMG8wNEZlaGhWdHpkV2lTUEFKbFlHbkpIQyt2dkVsK0kvMFI4?=
 =?utf-8?B?TlhBQkxlc1UrN3VpNFhDdEhoNnFVemhBc1hsOWcreGpkcTJBUmZuQkc0cUdi?=
 =?utf-8?B?RjVFaGlldWMrUjBEN3RYZFhVNHE5Nkt6ZElDOHhjcVkvS3ljcy9zYkxqa2pP?=
 =?utf-8?B?d3N4VmcyOHZ1S0tzdHVjR0tSb0xKenF1cC9CZHArNnNoOWJGZkVqdzhoVWVi?=
 =?utf-8?B?VG5wRFkyZ2NMR3hPMlRJejA1QUNiL0RQWGthQXNhOTN0NU1leVFvbkRzK2dS?=
 =?utf-8?B?RGhxallDdnBqVzRURlZHQWVvMy8raTVpYUhlMGtDZS9xOUxoQWlqNDlqdEt4?=
 =?utf-8?B?UVlheDlhaVlSNklEdUM5U2EycTNCMnNtUkJCVFpMM1I4by9PY0c1YkIxQWdx?=
 =?utf-8?B?UDNkSE5CNDdwdXgxbk1LZk1TVkZvdEs2NjlMeHNHcEkrWVBCbzlYNWZ4WitQ?=
 =?utf-8?B?akRtUDJvSHRQMDlIMTE4OGVlZ3ViOGRZZ0l5VDFiZm5ZdUtZdTBMR2liU2tI?=
 =?utf-8?B?d2xhczh3cHFldzdTVHl0bDEzU3JmMThGVHRhTEF5aVFiT0RDWGVPMTVqMWF3?=
 =?utf-8?B?aFFBZG0zU3pzT25NK1d4VnJkZXJhRzZmZkVrMDlvZEw0K0llaHJKcU0vRDI0?=
 =?utf-8?B?K2Z1UERiWlEvWlUwcFlEQTBrU3pLc1RIUTdIZnNOaklXWlBubFhsdEx2ZHJ0?=
 =?utf-8?B?dXZTTVppMW52RTFjZlkxVlM5TnNtRFNaV1ErSm82YWZKYkdQaXZjWGFoSUFl?=
 =?utf-8?B?UHBuMTBYazEwYkRxQVdjNWhkSTJFNTNJVjBFamI3OXU4d0F4ZThaSlJaazIw?=
 =?utf-8?B?NUFYckErZ2IrdFJsUlRqUnZIZHBNU2plRGdqUy9YL1dnVDFQSVpMSkpqaEVU?=
 =?utf-8?B?MW1sejZvL2g3Z3BJczkvRXhtenh0d2R3TXg3amxNblhRZjFETnNIOGtqQWlq?=
 =?utf-8?B?bnhEVWZ0MXBJaW1lZHAvR0d1R2FIeGNVNzU3WFgrS1lyR0RHRXJhOWZnSXdn?=
 =?utf-8?B?WTZLaGxuSXdsNHRZb2h1RjNKQ3lTc3lxZW01eXE3UkF2VDhsTUkrRVRhdWtJ?=
 =?utf-8?B?dGFhaTBqR0gvYlErK1grQmswdkxuNkhQMVU2Q0dVZ0tGcVRSdE11RzF4WmR6?=
 =?utf-8?B?NmxaUFRBZjEwdkQ0RzlIOTNyM1djeWFWU0h3Nmkvbmw2R2ZvMEhiQ3A4TjZU?=
 =?utf-8?B?SG9PbVFhK21HdnByZng3OHpSVkpKZlcxM3ZXbUlNZStid3gzQmhWZ3ZNZ2pP?=
 =?utf-8?B?VVc4VEMvY3duZENqb2RHeExvdUhZa295QU4vUzcxT0VzOHpYcUdmb2hQUnNI?=
 =?utf-8?Q?Yu6gKnZCi8UAzkH+ckTIFzrAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8494208-bcf2-41ec-f03c-08dc78e47373
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 15:49:36.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmAlCTIRzTjLVB/D3ALF3+9gtwWP0XcOiMXW1StkcLsebiFRG9AXIiuvz9MbGOpH7Ce9GTt+VKqlg4XTu+D31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792


On 5/17/24 15:33, Jonathan Cameron wrote:
> On Thu, 16 May 2024 09:11:53 +0100
> <alucerop@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A device not implementing the CXL memory-device class code, aka Type2
>> devices, has mailbox capability as optional. If the device registers
>> mapping does not show such capability, do not treat that as an error.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> If you are removing this check from the shared code, it needs to be
> in the more specific code, or you need to state why that isn't
> a problem (i.e. it is caught later anyway)


Yes, I realize this is solving the Type2 problem but impacting on 
current behavior for Type3.

I'll change it for doing it without such impact.

Thanks.


>
> Jonathan
>
>> ---
>>   drivers/cxl/core/regs.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index fd165e718cf2..5434a7c899fd 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -437,11 +437,10 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> +		if (!dev_map->status.valid ||
>>   		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> +			dev_err(host, "registers not found: %s%s\n",
>>   				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>>   				!dev_map->memdev.valid ? "memdev " : "");
>>   			return -ENXIO;
>>   		}
