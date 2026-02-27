Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEA36C5AF
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222061; cv=fail; b=rOxQnaLJmxGu9P3LAgzNse0VbW2pZQ72Jq5+GZYeTZWSJkT1F1FIynZwiYeqaffPD01a4f5vKIItbsAm7dEML2HlabH3V26qs6ExILej2M2xOztV0HfpfygVZSF4OrNKuJPJQv+b2bNk07Bns9oNZJYEQ99NAkhzkidABzNAVyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222061; c=relaxed/simple;
	bh=91Ed+oIp/JuIEKF63qCTMONVHZDt2d4uf7VSfL21qBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BSywYvti9r3o8/h0P8ZX87AfB566rsNNiMd2CdxFFF1liIe/7AopcwC/O1gIE0K8faNZ21ACavCrZ2rmsfxyrP4LeyekSoLd4dS5iyOV1yBUi8G57Ylu0U/s5UjmgjuYK2/fBCdaOT3t5d1NcFMpNMkfzccL0FzXTJSuRVSCjko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iVtZjO52; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iVtZjO52"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F74RbWTurgYo3p7pHkQGBl2g281YZbcrFVfddJFFuqaCKuguprwvN0M8W8EKGymX/EEsQU0w2ASXUOrmhbwOhjVVZapzbmEWpGgsUiXkp6157+L5/tv4wGION0rpkoJ5x3zM/MRWSBg2d4JAY2nDo5+odnePLMk4SAeJ2q1vn2kyEx0JDwG5jK+tyxWnqpJZqd7QG+xTpgFnv2hWmJOSDHXHxxUEKAg+uEUpe7VUn06dJmwPsunt6XjmgS4AjEdDbEh9qgB3ck2iB2ebmIxrA43zsrGshvneURPbT1d8/tgYEzoaojo+j+Q7kttkTTBGneipYAPu7iH0KF2LWb9uZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qJjbJm+PVL1V0YTZz+s80yyYQVAy5VAbJPmV5TAwOw=;
 b=v5/Du+70TttVQjzv2OK45nknQxijYMXcuT0H8MzCtVqamDk4AN64RgoZMvVRtd/NmW4sapd8IMIeElF3KRrY9wqSutrgf42FQRGNhrZEEGmu7732rHeu7AEu4DKyOryq/dZVhbL25DUqzEaIrfLNLt9RW+qxjTaXplYseJcXpXjQxmpbgYb4dhTlW6saLPGrrTb6AvZs5yF1KxTb/IcEQHBUsewwsZ9JyC9RJwxBDNEX6+s6bTcKz9w/IeoF5kttTJY1Ftjnd90Rwx/MEdkfIzM+ZEtU0+mSMbzCkbd8KiyxlskmXSob2Ve3YYzdl7r1Gq2RAIWAe7Fu/Qkaekg80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qJjbJm+PVL1V0YTZz+s80yyYQVAy5VAbJPmV5TAwOw=;
 b=iVtZjO524AmflS/VFyaGz2uL6VGSOix/BSSkNDydrc5BNZ6qljNtHiayvWQTw6uGsTiqeMw9quRA1R0U0cXw92nS41YVil02HwXiE2w6edw+eYdLI6WM1NCfKMr4AmOMSkn91RFStSBj089VclHcLKLy41HlUFG/Ur7PFoMXfLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 19:54:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 19:54:18 +0000
Message-ID: <545d4397-01b9-4f09-9ebd-39ffbe77d7fa@amd.com>
Date: Fri, 27 Feb 2026 19:54:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cxl: support Type2 when initializing cxl_dev_state
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-2-alejandro.lucero-palau@amd.com>
 <aZ8Ynok74P7QyDNU@gourry-fedora-PF4VCD3F>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ8Ynok74P7QyDNU@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e64930e-ac59-486c-8d8b-08de7639fdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	iHwkbtB3T46Uq81NJGrS2UxCwY6yaHA1vaqSeZs3oSrGtqjbpGajqKZm3TwEIYGU4fSQgxxz8NUWgCIVADRbVbQlNccM/r5j7IsAlbN0RaRyLWgKF6HUxskXJ8mfmsHYPbY3s63U74f1yyT+r6uRZYhAHGxU29NK92s3TtzULDGtwH+3/6fEsW4pCXA14t3ctGuCR+GpQqLZwT6Q353f3rWzaXyy/M8mwX4QrTVYQ6lxkgWEcRdCaWZ8rdp3mnmDBJnhbaWRH4oi0RvVtZD3Mygz7U+uKboQH1L6ocU1fXOW3qQE1haut324D6HZiuExyDgbxuvq1FLP1z+UE4MTq9vRc36aqiC9vx6dsbR4Fj71pcwGjzBWdMFWaIwHzqDSrrLKCxyVpIIwxFDDnvCNZ6Dvx0oIFafbU0DdW5qtysshHMWz5QCgZ52c7pIWdB0xawK5cBrzm4e+otZDYqCtHgH+hzhmQsBbnu53SdY4f4JkRoCN9PqL9U4IvB78pfE5BOmvOacISj7ED4+Ro6QsY02begtLw5ke5yt7lfBSHY5YRYvV8yMTF6ORCOd34uN3cnEczIIMf/P2ONQUE//31DZZKFafrOHTMrXMIsyjPTIDv2tjaXjmGQJ8psOCF9n+W365H5jiGHrCsCS+frSt0yvkTb1U0gEKsgai6+/geUOf8z8s4EdII8iMSyvK/+lv2tUw0SjovL/wcIqGL4kUl3/6yXpciM3qK+j1WYKx+oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uzd6ZExBRjFHelU0MEdsL0g5cEJNSVV3Y0l5Si9XZzNZdEQxc2J4MVFXNEdp?=
 =?utf-8?B?UzRGSk82dVFPMEV6TG42a3haR2lWLzVnN3RIaGJ1Z2R0RWJMcko0Mk9oZnJP?=
 =?utf-8?B?SkVjZ1hWeHlFM1FmZEJwN25iS3cyK24vVUl1VlVWSDgvb01TdlF3SWhBRjBy?=
 =?utf-8?B?YnV1eHI1dGVaV3pMRG9CQTFEclFGQU96VXRhNkZ4ZER6eVBGZVRQbDN1UWJo?=
 =?utf-8?B?aUE1K09heVlFeXFLTWt2NDkvWmpHMi9JTWltRUQ3ZStjbHFHNzE5c1h3ZWVa?=
 =?utf-8?B?MGJndWZWaFFJUktpUWY2TUpjZHNvSGhoU3BYa254ZnVoM1psaGNBb0VXVzU1?=
 =?utf-8?B?T1NuNk45REdTUzZMYW1NZHZBVHNiazJNMVRGQy9Ec05QRXZmaW1haXRlOW5D?=
 =?utf-8?B?Mi9TbWpFZWw0SG8zcFptQ25WeXhNOWhpcGpqTmdEa1dzc1UxMytidG1RZ2wy?=
 =?utf-8?B?aW1BYXhWdTVuQ1ZXcjNXWGVFWEYwQ24ydHg5WHRYS01vMDVIQkxIU1dGMUhY?=
 =?utf-8?B?WmdhRitUN1VROXQ3VDNMVUkrMEdSZjVDUVp2cnF2US92OEZ4VGxHeE50Zi8v?=
 =?utf-8?B?aW1mZkhOZGhwRHF4b0R6dG41L2c0WjI3Wm0rZFJ4eWVYZ2J1TWxNc2VCajh1?=
 =?utf-8?B?MHVaYUgycGRXeEoramFpYlI4NkIyMUM3Z1cxdmNWUEI0Qzg3NE1FNmRjN0VL?=
 =?utf-8?B?di8xdXIzV0xZWEFUWXY0NjdiV0Mwb2VhMXJaWlIwcCs0b2pYRDkvWE8reTBM?=
 =?utf-8?B?YkM2Z2RhNU04NUxIdFZyM3RwQ3BFK2NqSVlkMGdkMDNpVVJIN0FlTjI4MWI0?=
 =?utf-8?B?dG9RdnhVbnA1Qk5ydnRVZU8rcFBMcjVodUZITDlOSXFWMzNWTVNqeUM3d2xa?=
 =?utf-8?B?UkNvWUtGVHc1RzlzWVY3dURVbWk5aWIxdUdHTnJLUjBCbVY5N1AyUVVlS0R6?=
 =?utf-8?B?d3dUdlBqT0EzKzB2RzN3SVFnelQ1M09CWnB2K2hRVGpKcUducExxeWIzQ1l2?=
 =?utf-8?B?dzlYUWJkWTZwUEFNcWN3dWhSSVQxVlliVGVnYzkvUVBkNHdsNm1mWU9oa3JF?=
 =?utf-8?B?QjB1akFhRzJhbnRhelN2MVZZdTlaWnJNbWRrWjMyM1c2Z1VTaktKZm93bXN4?=
 =?utf-8?B?V3VwMWxlZVlyWkl0VmZLTkRLRm5xUVBBNHlkZ1laUXJUS2lHTS9wVEhMYXk5?=
 =?utf-8?B?cGp4bHl5VndwY1dnQktkclNaZFFQdlNxTmorZzJ0c0VtNVN3cElicEVUT1JI?=
 =?utf-8?B?TmphUGVoWGpxSGpCRHdZbUFmMzhxNGhFM0tsWXRpb29zcXh6WkprOWF3ZHJw?=
 =?utf-8?B?VHFRYWw3VSttTkxvQUMxN1A0UC9aYnltMVQ2SFhrTDZrVWpTNHBQT3ZmSWcr?=
 =?utf-8?B?Nml3RWN6ZXQ0d0xMbFloRTdIWk9EZ09rL1F1dWJKQklDeTVjMDFmRVRoK1Vl?=
 =?utf-8?B?cEhHTlRlb3BlZWl6Ky80cTZBMHF1NG5yZGs1L2NUUi9TdTNVbm1XRFphQ0tu?=
 =?utf-8?B?cjI2UHdVWk50MkMxam1FaEIwMlE4bld5Nms2VHI1RTFaQndBcFdxeHBBUEI3?=
 =?utf-8?B?NC9nTElzWkE3RmkvUjdERXhGNWVLSEZzdTVVVllteC9XQmozSXY2RWRoQVZI?=
 =?utf-8?B?dk1Yc2tRRVdOV1QxWU84cjlBSnFnc29RSFJTa21XSXNZZUNKbi9VSm1tZEN1?=
 =?utf-8?B?VWh2czRhaUVDdFZpSlJOWlNwd2pQZENYclAvN1FCNkRRU1JFUFRxRnJURXox?=
 =?utf-8?B?QzhsL3Bnei9iRGluRitDRXdSYzFYZXVRdDRCUEZBUmNOUzM5RWw2SW93SU12?=
 =?utf-8?B?SCtXZ0tlakFrbVhYUnpCbWZPWjNDZUIyU0xhbUpTaHZqcnY5dnJhVk9FVWxv?=
 =?utf-8?B?UDZNYVFxUjUva1ZWdmZHaGVqV0VOQXIrRkVvbEFVNzAyRVhCcE1EaFRLcGc5?=
 =?utf-8?B?S1I4SzJqQ2hGQmpWbjBDSUZaVE91dkRkWWFzQ3dMWk9wZThXL3BaMTNUTUlu?=
 =?utf-8?B?RDlabG1KWUl4VEx0MWtyRXZjK0tseEdUZjRLV3RIT2FIWGduUWhGeFNQNUdO?=
 =?utf-8?B?cEZnOEgrL1lUUTZrMWpXc1RuSzdaTkdVUFFZZUtuaEU0YWYvVnFiZ3YvWDc1?=
 =?utf-8?B?RFVXSkZJcURnQmErNnVwOTdIaXR0NVdXOUZIY0xucUhWZ3hzSFJLYzFvZzdy?=
 =?utf-8?B?SkUxbVlGcHhLU1dUZzM0czlReFRBcFZWSHdGSDNUSkhsZDhxWEg3UFpOemYx?=
 =?utf-8?B?dGlHRFovSFFxdnpvVFpCaXEyd0lWU2tQMlJtQ2RlbTBGVmxIZVk4ZExDejFT?=
 =?utf-8?B?eFFhWU5oN1pPbzAvZVhnU21kQXR5eEtKSkxLbE5HRHF4VU5ITlVUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e64930e-ac59-486c-8d8b-08de7639fdda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:54:17.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yra/bzeP+P3qVUoA37msYUoXM+LH8+TP/sTLLfZX2QJ3tpXE5Ia651cFlpoKqc8E9WBtLMPcNkZUAClZG7uCpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125


On 2/25/26 15:43, Gregory Price wrote:
> On Wed, Feb 25, 2026 at 12:14:28PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> Just some nits
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>
>> In preparation for type2 drivers add function and macro for
>> differentiating CXL memory expanders (type 3) from CXL device
>> accelerators (type 2) helping accel drivers to embed cxl_dev_state
>> inside a private struct.
>>
>> Update type3 driver for using this same initialization.
>>
> I think this generalizes to just
>
>     helping drivers built from public headers to embed
>     cxl_dev_state inside a private struct.


OK.


> Obviously the immediate use-case is type2.
>
> ... snip ...
>
>> +/**
>> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
>> + * driver specific struct.
> ... snip ...
>
>> + * Introduced for Type2 driver support.
>        ^^^ I don't think this comment is needed


I will drop it.

Thanks!


>
> ~Gregory
