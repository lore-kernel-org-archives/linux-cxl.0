Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF091B6CE5
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931613; cv=fail; b=BU1MgDsjK5c93cJffqVnRBLThZYkdILYFiJsPpTjTswiEIehxtLCwUNlCQnclT5iCSq8Ud7k0OUho4RnH4ZPf/zzfp7p4a6TMWzH3bjM0pwk8mnwllwQH3uwnbEdXmBmSkAkRvC+LUOAKuPHdF1K7tmriO0VY5rXjRZ1hNjJjNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931613; c=relaxed/simple;
	bh=c53xUTcZ2j1zIhKrd397EKAGcJ+G3Zb9UZdsoosbuzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aVszt1OadoJsUV8Z3oap6JACxAXuetpBwHFuXpIkgJROcqkb+kzbecvTOvUcOd/vM8uU/EVoPUFqxMft5ifedXCoeUeALGQuLTSyzfWtoHQMW/8hFNlqm75RncZ+2HUYs9V9OpZAYxjIIPPRQy+5arVI0/Os3gUVb1uYsWNRzqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iSmvyQqO; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iSmvyQqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llijTeYGdd3ENGPdng3reOtDOd/b0ivZYb37ghzxwVzhQBB7Vesz9Pg/78BhTfJRDcfmQkdOURwP2VtwR+jmMsix3ILOiBG8AcvKDX5YND86OryjOqVvgQTujQVHQydw1NCdrFQZfwbxPK5sHy3JCLI8uafre0GM6076DGNFkJ/VKeCGz5I2/2fSL9VXgthqZMRQ8iyu9jCY7rEN7isWjpjKxnhDx2PS5D1Xjj7AIOClrJ3LfOFkgqjXLhy5aP8auiKZF0E/+h3lGO7WtVDHWeFIO/m4Jn+bc8GHj0m127nmWKyWSFTp1/POmhaJYSJkQxOq1fCUyHFHTKIxCdSIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8/pny02LUZlhOBnc/Dn+XaTV5wmE+oRxsWOhXz9qCQ=;
 b=OQ32tVikN/XGmNmiTHRsrUf1KfrYKCxEOFnntukJIxr3nCqrREY2TX7IRqIdLfePDKEw1KQjQU79c7LxRZY2MlN+ZXxRcvNVGs5F35QbwsbD9EEEyKxL1qfH1BKbuRulI0AbQq+Ous9DgYHLk8WdE2CvgHnvA6j2bjA96GMzWGmkXmt06XTMEi9TDIXqaEzNx3u5pOb0XjrrVFPcmonO3h6KZxHOxRSI5WQtKpGvilSZ/2TUOFatCkJIU9h60pmpceEJwHtATUtslxfQ+xKZaNT8fF8nIzH7ISNmVCbSJZdaOkF5F2xqx6GWlQwIJSV/VJKtf4B9yQPVPKEAAljo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8/pny02LUZlhOBnc/Dn+XaTV5wmE+oRxsWOhXz9qCQ=;
 b=iSmvyQqO1OEJRulwnxZ4ckJf4z5TLgEu2fSNlHgi6JJCKHZiCPDUiBSoYU57lJIQ6iPNeaDh90SJynt45mex1R67F4MtawHc4aTqxw/YR7O0wZU6mptsYNv36vAk6LcTB4n1BMGjToYN/xVMhNRbxjoqCIx2hCTNfg6wVVDQPM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 15:40:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 15:40:08 +0000
Message-ID: <46b1b4e4-8588-46ae-8331-1ccb40a069ac@amd.com>
Date: Wed, 11 Dec 2024 15:40:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH edk2-platforms v4 0/1] add basic support for CXL on
 sbsa-ref
Content-Language: en-US
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 marcin.juszkiewicz@linaro.org, ardb+tianocore@kernel.org,
 quic_llindhol@quicinc.com
Cc: Jonathan.Cameron@Huawei.com, chenbaozi@phytium.com.cn,
 devel@edk2.groups.io, linux-cxl@vger.kernel.org
References: <20241210103632.95960-1-wangyuquan1236@phytium.com.cn>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241210103632.95960-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d98059-c3e9-4241-ac85-08dd19fa1761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejVncDhnM2IycUUrelIvbk0zVnFLdld1dGRhclRwdmpXT3I0bG5ZaERkenJt?=
 =?utf-8?B?NWNsZ2pwUTNaZEt3bnBHMlBIWStpcStGR1ZoWGJHanVkSHBrazFFYVhNN1pL?=
 =?utf-8?B?MExaWjNIYnVtR0NaaE9EdjhRNmp4L0RVZzdWeEVQUGxyNnEyNkpkbll6cmdr?=
 =?utf-8?B?aXF1dGM3ZTdoYUE1VXZCK1Q1VnZnY2RGOXJmYkhCT2hDb1VieWI2K2dMMStM?=
 =?utf-8?B?WlNDVUZ3VW4yRUtaOVJ1QlRLTVdnY2JybUVJcU82L1J2QjNGc1M0WllyNjA2?=
 =?utf-8?B?T3VKbmdieVpBWEcyMGVveFgwUndDWGJvQzkrazhabjFUT0FoTHZEb2tXSTlC?=
 =?utf-8?B?L0kvUUVURjBoOGNpME0zN254bTlod0VEQjRQZy9rVEV1RW5WRWhVOWprWWFv?=
 =?utf-8?B?d3NlSGFqMUpaNkdFRklObG9nNW9ITzY3V1QyMGM3R2lXWWVuNkJnRXdPaWJu?=
 =?utf-8?B?blVsSm12WTRzN1JxbW1TSGpIUnBxR3JzV2JtQ0ZHZGFYUGJ4aWNWUGZqbDQ1?=
 =?utf-8?B?THBCRllQSkQzSEIxdU9LMGQ3UVVITi93NHlsZDlHK0dFN043VW9WRW85MnZG?=
 =?utf-8?B?M01qNllNM3ltTW5BY3hXNTluS3Y3VTE3QUNHM3c4UDBDeXdybStZM0ZnbUpF?=
 =?utf-8?B?RVpvdjB1TTdCcTZFakFSWkE5RVNkbHRaTUl3MTVBUDVaZTh5bXNmaUV0amtj?=
 =?utf-8?B?Mnp6RS9xUGo5MHk5OU9HVXNQQ21SRXplanNRRVVNc294TWZrR3oreTBDLzRy?=
 =?utf-8?B?aEIvUEFlK2ZXWHlVZmdVenB2aW4wYUh5Zjg2MjRPTkpjUnlyekRoSjZsRkJu?=
 =?utf-8?B?QzdtUDhJaHMxRVQ2RmFFNFBaUngySkN5MXVrVFVVMTJFN3pFcDl6eHU4QWZN?=
 =?utf-8?B?c09ZbTZIeTN4QVMvbmlMQjVkTW9vVGcyTEVnY1djNkRWZmhzcE5ibUp1c095?=
 =?utf-8?B?S1ZiMjRvMFN4ZXZWTlN0NGRWbG8wdnZveFZqUmg2VjEwZnM3OW9xT3lCQVhq?=
 =?utf-8?B?L0k5TFllcVVBZ1J6WjF3TlRiVjR2Q3BSVkwyK09VKzgwalAwL2U2NW9RUWlw?=
 =?utf-8?B?MVB3VkxOYk9yQXVKelRQZmhmQzhKSm9pa2RIZUcreEEwQVlMV1FzRFBXUHRB?=
 =?utf-8?B?WTk3SGxoNlZ4cFN5MDlLYnp3ZzYwbDRsamVyb1ZoS1dubkJmUXM1TjVVekxK?=
 =?utf-8?B?cE9KaEtNR2k5S01MYnpwdUovWkNXK1Z2WGdBM1BaS1U2NkdrcTk3YUxFMW5X?=
 =?utf-8?B?cXVpdmdReGxBL0VYVVBtQ0J1MUFlT0J4WXl3YVZPc0lLUVhiTWFiZEM1R0lK?=
 =?utf-8?B?QmZHZXZKdUx1cHYvdUJwV2lWWjg1cDBsdFQxdXdvc1lRMGthK3V6SEpQWnRr?=
 =?utf-8?B?WHdvZ2xqc05oNkNJbEVLa3JFRU4xR0Z2R0taQS9JRGZkOGszVG1oTFFKMTJo?=
 =?utf-8?B?czFtN0U1S0paRzVGT0REaklEMlhvRW05RkhKbTNnNS9HYWI2czA3cXZEak1w?=
 =?utf-8?B?MmcxZnBQUEM0Rjd3ZnIxMUNzVzVYSFdtZjFRWTcxaVhaejJESlZFNjdTejg1?=
 =?utf-8?B?aFhJQldLNmVFQm1GUDRjM0hPcVJCRGNjbnRGbGpXZXVLSHpoZkNENWhud05B?=
 =?utf-8?B?ODFzWCt2RGFvYTNGUDE5d3VJYi9xN09Eak5sRzBXeGdkOHEwd1NjUFkzeFo0?=
 =?utf-8?B?MjAwMHhjMENmSFFveWlsamNXb3NKNFJySGE0MU1rZVczTDVQckFSdDdwYWJh?=
 =?utf-8?Q?wz100wNNmgZpE1V/ao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVB3TURmZzFlZFVZbDZOSkcydlY3NlVPMHhLaGhVU3FvT21KMVdzS3p5Nmxr?=
 =?utf-8?B?Mkk0aFkyTksrQXc5QU5CditHSWkvRzNEdjhjWXhibU1VbWJFaXREcDhSY3hF?=
 =?utf-8?B?TmhVWDVYU0VYVjJzKzZmbTBPY2x5NkpTVG5JbitLNVJneHo4VVQ4V3pCMnE2?=
 =?utf-8?B?R1lJQ0V5OXZHY0p5VHVwd1ZiSTRGZmxxSTlVb2FqbXVta2xEZkdJYUVCZ28y?=
 =?utf-8?B?YnJseEVLY3RRaUw2RHJxbVl6citISVJ2cVhSSU9taUJVTDErS0hENlFRZVlE?=
 =?utf-8?B?WWhaelNnSEJ3cWF3bTZTdmkwVUFVb2w5akdCZENNejh4RDBEVEZXeWVldkli?=
 =?utf-8?B?MFFpSTNnQ2hmdXdVOVpBZGY0aUtNam5FeUtLNkFSaU1qUG9Jcy8rWXczdDZD?=
 =?utf-8?B?NUdBZEtqOGt1RHJ2c0RQL2ljWk9aMnZxaGhQNW42UTNjNHRZRjdxb25FS2Vk?=
 =?utf-8?B?Rk8yalpCMnpKby9UQ05lbTVMQ1JvMS9rbmc4S0Z4Mk9BekcrMlJlZ0UraEoy?=
 =?utf-8?B?R21oNlQ2b0U3T1V5RVN0S2oreW52KzVURHIvY1N1VWc5Y2V1Q2RBdHFqaFpk?=
 =?utf-8?B?cDFpVG5EWVVKSTVRdTZsVHZ2MnBZdk5LUjZUbG9PYUd6Z3BGejgwQWRFdTdh?=
 =?utf-8?B?RXRtMVQrYlRTWG8zSTJ5M2FYUGFGVVFjYW1UREhWa3daU05MSjk4OFN6Sm1k?=
 =?utf-8?B?dTJqY1o1ZVdKQnA5WlB3Sk9WVDU2N3l1WFJBY0k1d1UwMVE4MHBjaU9NQXU2?=
 =?utf-8?B?N2VYUEROQnpGWUtIQS92ZnNON3FUOUtpTGptcGc2aVZ0N1ZLOVV4OCt5bW82?=
 =?utf-8?B?TjY1WHUyQjJwSEovM0Z4ZWVXZ0xzbzFPakxtZzZaRU5RQ1ExQXlwajZWTC9m?=
 =?utf-8?B?KzQrSkZqNjQ5UUducnVnbCt6amVJblJTRVFURWRhSjhYZnIweDdUYW5iTWxR?=
 =?utf-8?B?alRtSy9GdHF0RmRjbUFpRmJUVDZNcS9Sa1E0L3NRVW84WTF1MnByY3lBekxK?=
 =?utf-8?B?dDFXdVpuRTFTL0ZqWWM1b2hYVFZTS3Vnem9QQ0cwSHVzYlhJSDVPY1IzdjBG?=
 =?utf-8?B?TGNHRWZCaEY1VEtwK0IxaXIyc1hVWUF6Q2xENmtLRnp1MnlMem96QW5DR2h5?=
 =?utf-8?B?REpiejBNMkxkY3pDMVpnNmJvbHFaVHR4ZllZT1hMenFqS0VCK2RLQTYyTG9C?=
 =?utf-8?B?NFhTb0VGcld6ZXBrdThFaGdZZ2QzbVNRTzdNWGRuUUlNK2pGYnluajhBZURN?=
 =?utf-8?B?eis5N3VzaFRRbUhoRVRrMGptSDBwRW9MenMzQkJlU0EzQWFIcjhrRk5FeFRz?=
 =?utf-8?B?aFNTelpOeVlvOHBYQ2dPaENpMGsra1AybHBBdDNzZXVhaTZudHk3UDBMbmx2?=
 =?utf-8?B?QklrbFVrZmFzWnBoc3pvaXQ4aHJJa1hLTlNBWGxDbzNXT0Z3VHJyWkR6czZE?=
 =?utf-8?B?RVVKR1kybUl0M0tPaW55dUtoSTQzdDlCeUtNSGI3S2cyRVJqQTR1QVBzOU52?=
 =?utf-8?B?QmdUWENBckZ5bUJrZ1F0a0Mwb3V5VXRZRmd5dGxUUmFVR3U5ZFNjaE1qeU1Y?=
 =?utf-8?B?amFadmVPK1lMU0thakVyZjlFSWhWWXRKS2xBck9aRDhwcEluS1hrNCtDbHNN?=
 =?utf-8?B?dkZuaURaUnFGbVFQblBuLzJ1RUNWRVFLTXNFYi9keWtRVjB4ckM1WTR5bnBC?=
 =?utf-8?B?MERMYndNZVc0NHcyOG9DNE9LZWtwYlVlRXBoN1RhNk1vT1RGU3k2am9PRHAy?=
 =?utf-8?B?eURqUnNiSUg5RXB2bmwxZHVxaTZZUDZzM2grTzNjOXdqRUQ3R3M1ZEdhMnFq?=
 =?utf-8?B?UXhIaFFxQkR1VW16TGFBR2kzNEZXMW1jU0dSR3o0NzE1cTNCN0YxV0ZQSHdT?=
 =?utf-8?B?V2xDYTdiY0VDWFpxTnI0blRua2ppN3c2VTA4NjNMYm9YUWtFZnJYZFJydEgv?=
 =?utf-8?B?dnlHeHZZKzJjODFZTHN4VjYvV1R0Z1czTzZYczcrNWtUVnJvcWlDTDFZbHcy?=
 =?utf-8?B?VVh4cFZaejRraUphdHIxd3hSUUpJeTZGanhKZFpZUEFjcklMcjVIRFVpalg5?=
 =?utf-8?B?VmpNUWRTUXorV3dWWWpXcXNlWWtiTjN4NjhEeUJpTjdraUxTVmRua0R1bkYz?=
 =?utf-8?Q?NsyVcOJ0D/3JuBsGO7AnI82gF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d98059-c3e9-4241-ac85-08dd19fa1761
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 15:40:08.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiDW5wWlTkIXSf9ZEQMetyRmwn6GkdBPa3zupp/eI0ptZhLpRv84Xfk67E4isMR4Riu1SF7gl1HlAWJU2rGi9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739


On 12/10/24 10:36, Yuquan Wang wrote:
> v3 -> v4:
> - Align base addresses of CXL relevant Windows
>
> v2 -> v3:
> - PCDs values of pio, mmio32, mmio64 & ecam space for the independent cxl host
> - CXL Bus range: 0x00 ~ 0xff
> - Mcfg ecam structure for cxl
> - Iort RC node for cxl
>
> RFC because
> - Many contents are ported from Jonathan' patch on qemu virt design
>
> - Bring plenty of PCDs values
>
> - Less experience and not particularly confident in ACPI area
>
> This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
> previous DSDT table of sbsa-ref. Since my latest acpi0016 implementation model on qemu
> side is a new host bridge qemu object rather than pxb-cxl, the cxl host(Segment 0001)
> would have its own ECAM sapce. Meanwhile, this adds exclusive pio, mmio32 & mmio64 space
> for cxl host.


Hi Yuquan,


Is there a roadmap for edk2 supporting other CXL features?


I have noticed UEFI extensions are not supported yet, specifically 
EFI_ADAPTER_INFO_CDAT_TYPE_GUID as an instance of 
EFI_ADAPTER_INFORMATION_PROTOCOL.


Any feedback would be welcome.


Thanks




> As sbsa-ref cxl host has its own ecam space, this defines the bus range of cxl host from
> 0x0 to 0xff. Therefore, this adds relevant BASE_ADDRESS_ALLOCATION_STRUCTURE for cxl in Mcfg.
> And to enable msi of cxl components, this add a new RC node in Iort.
>
> Based on the new CEDT definitions patch on edk2[2], this series adds a static Cedt.aslc to
> support the [SBSA_CXL_CHBCR] & [SBSA_CXL_FIXED_WINDOW] space on sbsa-ref.
>
> Link:
> [1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-2-Jonathan.Cameron@huawei.com/
> [2]: https://edk2.groups.io/g/devel/message/120851
>
> Below are the new result of acpi tables (the DSDT contents could see the patch itself):
>
> 1) MCFG
> [000h 0000 004h]                   Signature : "MCFG"    [Memory Mapped Configuration Table]
> [004h 0004 004h]                Table Length : 0000004C
> [008h 0008 001h]                    Revision : 01
> [009h 0009 001h]                    Checksum : 1E
> [00Ah 0010 006h]                      Oem ID : "LINARO"
> [010h 0016 008h]                Oem Table ID : "SBSAQEMU"
> [018h 0024 004h]                Oem Revision : 20240625
> [01Ch 0028 004h]             Asl Compiler ID : "LNRO"
> [020h 0032 004h]       Asl Compiler Revision : 00000001
>
> [024h 0036 008h]                    Reserved : 0000000000000000
>
> [02Ch 0044 008h]                Base Address : 00000000F0000000
> [034h 0052 002h]        Segment Group Number : 0000
> [036h 0054 001h]            Start Bus Number : 00
> [037h 0055 001h]              End Bus Number : FF
> [038h 0056 004h]                    Reserved : 00000000
>
> [03Ch 0060 008h]                Base Address : 0000000068500000
> [044h 0068 002h]        Segment Group Number : 0001
> [046h 0070 001h]            Start Bus Number : 00
> [047h 0071 001h]              End Bus Number : FF
> [048h 0072 004h]                    Reserved : 00000000
>
> 2) IORT
> [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
> [004h 0004 004h]                Table Length : 00000118
> [008h 0008 001h]                    Revision : 06
> [009h 0009 001h]                    Checksum : D3
> [00Ah 0010 006h]                      Oem ID : "LINARO"
> [010h 0016 008h]                Oem Table ID : "SBSAQEMU"
> [018h 0024 004h]                Oem Revision : 20240625
> [01Ch 0028 004h]             Asl Compiler ID : "LNRO"
> [020h 0032 004h]       Asl Compiler Revision : 00000001
>
> [024h 0036 004h]                  Node Count : 00000004
> [028h 0040 004h]                 Node Offset : 00000030
> [02Ch 0044 004h]                    Reserved : 00000000
>
> [030h 0048 001h]                        Type : 00
> [031h 0049 002h]                      Length : 0018
> [033h 0051 001h]                    Revision : 00
> [034h 0052 004h]                  Identifier : 00000000
> [038h 0056 004h]               Mapping Count : 00000000
> [03Ch 0060 004h]              Mapping Offset : 00000000
>
> [040h 0064 004h]                    ItsCount : 00000001
> [044h 0068 004h]                 Identifiers : 00000000
>
> [048h 0072 001h]                        Type : 04
> [049h 0073 002h]                      Length : 0058
> [04Bh 0075 001h]                    Revision : 05
> [04Ch 0076 004h]                  Identifier : 00000000
> [050h 0080 004h]               Mapping Count : 00000001
> [054h 0084 004h]              Mapping Offset : 00000044
>
> [058h 0088 008h]                Base Address : 0000000060050000
> [060h 0096 004h]       Flags (decoded below) : 00000001
>                               COHACC Override : 1
>                                 HTTU Override : 0
>                        Proximity Domain Valid : 0
>                                DeviceID Valid : 0
> [064h 0100 004h]                    Reserved : 00000000
> [068h 0104 008h]               VATOS Address : 0000000000000000
> [070h 0112 004h]                       Model : 00000000
> [074h 0116 004h]                  Event GSIV : 0000004A
> [078h 0120 004h]                    PRI GSIV : 0000004B
> [07Ch 0124 004h]                   GERR GSIV : 0000004D
> [080h 0128 004h]                   Sync GSIV : 0000004C
> [084h 0132 004h]            Proximity Domain : 00000000
> [088h 0136 004h]     Device ID Mapping Index : 00000001
>
> [08Ch 0140 004h]                  Input base : 00000000
> [090h 0144 004h]                    ID Count : 0000FFFF
> [094h 0148 004h]                 Output Base : 00000000
> [098h 0152 004h]            Output Reference : 00000030
> [09Ch 0156 004h]       Flags (decoded below) : 00000000
>                                Single Mapping : 0
>
> [0A0h 0160 001h]                        Type : 02
> [0A1h 0161 002h]                      Length : 003C
> [0A3h 0163 001h]                    Revision : 00
> [0A4h 0164 004h]                  Identifier : 00000000
> [0A8h 0168 004h]               Mapping Count : 00000001
> [0ACh 0172 004h]              Mapping Offset : 00000028
>
> [0B0h 0176 008h]           Memory Properties : [IORT Memory Access Properties]
> [0B0h 0176 004h]             Cache Coherency : 00000001
> [0B4h 0180 001h]       Hints (decoded below) : 00
>                                     Transient : 0
>                                Write Allocate : 0
>                                 Read Allocate : 0
>                                      Override : 0
> [0B5h 0181 002h]                    Reserved : 0000
> [0B7h 0183 001h] Memory Flags (decoded below) : 01
>                                     Coherency : 1
>                              Device Attribute : 0
>                 Ensured Coherency of Accesses : 0
> [0B8h 0184 004h]               ATS Attribute : 00000000
> [0BCh 0188 004h]          PCI Segment Number : 00000000
> [0C0h 0192 001h]           Memory Size Limit : 00
> [0C1h 0193 002h]          PASID Capabilities : 0000
> [0C3h 0195 001h]                    Reserved : 00
>
> [0C8h 0200 004h]                  Input base : 00000000
> [0CCh 0204 004h]                    ID Count : 0000FFFF
> [0D0h 0208 004h]                 Output Base : 00000000
> [0D4h 0212 004h]            Output Reference : 00000048
> [0D8h 0216 004h]       Flags (decoded below) : 00000000
>                                Single Mapping : 0
>
> [0DCh 0220 001h]                        Type : 02
> [0DDh 0221 002h]                      Length : 003C
> [0DFh 0223 001h]                    Revision : 00
> [0E0h 0224 004h]                  Identifier : 00000001
> [0E4h 0228 004h]               Mapping Count : 00000001
> [0E8h 0232 004h]              Mapping Offset : 00000028
>
> [0ECh 0236 008h]           Memory Properties : [IORT Memory Access Properties]
> [0ECh 0236 004h]             Cache Coherency : 00000001
> [0F0h 0240 001h]       Hints (decoded below) : 00
>                                     Transient : 0
>                                Write Allocate : 0
>                                 Read Allocate : 0
>                                      Override : 0
> [0F1h 0241 002h]                    Reserved : 0000
> [0F3h 0243 001h] Memory Flags (decoded below) : 01
>                                     Coherency : 1
>                              Device Attribute : 0
>                 Ensured Coherency of Accesses : 0
> [0F4h 0244 004h]               ATS Attribute : 00000000
> [0F8h 0248 004h]          PCI Segment Number : 00000001
> [0FCh 0252 001h]           Memory Size Limit : 00
> [0FDh 0253 002h]          PASID Capabilities : 0000
> [0FFh 0255 001h]                    Reserved : 00
>
> [104h 0260 004h]                  Input base : 00000000
> [108h 0264 004h]                    ID Count : 0000FFFF
> [10Ch 0268 004h]                 Output Base : 00010000
> [110h 0272 004h]            Output Reference : 00000030
> [114h 0276 004h]       Flags (decoded below) : 00000000
>                                Single Mapping : 0
>
> 3) CEDT
> [000h 0000 004h]                   Signature : "CEDT"    [CXL Early Discovery Table]
> [004h 0004 004h]                Table Length : 000000A8
> [008h 0008 001h]                    Revision : 01
> [009h 0009 001h]                    Checksum : 42
> [00Ah 0010 006h]                      Oem ID : "LINARO"
> [010h 0016 008h]                Oem Table ID : "SBSAQEMU"
> [018h 0024 004h]                Oem Revision : 20240625
> [01Ch 0028 004h]             Asl Compiler ID : "LNRO"
> [020h 0032 004h]       Asl Compiler Revision : 00000001
>
>
> [024h 0036 001h]               Subtable Type : 00 [CXL Host Bridge Structure]
> [025h 0037 001h]                    Reserved : 00
> [026h 0038 002h]                      Length : 0020
> [028h 0040 004h]      Associated host bridge : 00000001
> [02Ch 0044 004h]       Specification version : 00000001
> [030h 0048 004h]                    Reserved : 00000000
> [034h 0052 008h]               Register base : 0000000060200000
> [03Ch 0060 008h]             Register length : 0000000000010000
>
> [044h 0068 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
> [045h 0069 001h]                    Reserved : 00
> [046h 0070 002h]                      Length : 0064
> [048h 0072 004h]                    Reserved : 00000000
> [04Ch 0076 008h]         Window base address : 00000A0000000000
> [054h 0084 008h]                 Window size : 0000010000000000
> [05Ch 0092 001h]          Interleave Members : 00
> [05Dh 0093 001h]       Interleave Arithmetic : 00
> [05Eh 0094 002h]                    Reserved : 0000
> [060h 0096 004h]                 Granularity : 00000000
> [064h 0100 002h]                Restrictions : 000F
> [066h 0102 002h]                       QtgId : 0001
> [068h 0104 004h]                First Target : 00000001
>
> Yuquan Wang (1):
>    SbsaQemu: Support basic CXL enablement
>
>   Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  21 ++
>   .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  24 ++
>   Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  69 ++++
>   Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 327 ++++++++++++++++++
>   Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   9 +-
>   .../Drivers/SbsaQemuAcpiDxe/SbsaQemuAcpiDxe.c |  40 ++-
>   Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  28 ++
>   7 files changed, 515 insertions(+), 3 deletions(-)
>   create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
>
