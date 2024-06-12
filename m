Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494236AF8
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171662; cv=fail; b=k6We6PBrDuV7fYhXXi2jjONhyQYZi68NQJVY0LqLqcwLAT+6uLv3ydx3eEszPL2Ox6czqFoYOnb4XwozHMP6oGkuAzf9AV/jN22WaqSYIFgiRVZor/YgOL/QZ+6bLzyYd/Yj0h5vqIqFxUiEFLVAIRAxQwDaaqJax9m0nFjxqfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171662; c=relaxed/simple;
	bh=0ni5zwMQQTIgKx6CGiMTc22YGaEB6UQzFxSUNCJ0/uw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UmuiBs3pcSzW+LyqAO0W+SZyg7KhtvKGGHWHaqzn9SQWjX9qnqiTAcFS/H/JY/X5PPKaJ73rq2np2H8QQS7z1yCdhnW25RUoVSlsF9h5RRPNuD/FX/pdKz16TepAntzWfRX4xkL8s8AvDZ5ePdTEbfxJPtGe9jfeiU9KelO1OlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FEc8qhFv; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FEc8qhFv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er9weQ5uNZECY9p9tKGsqrAhmv9G8ue9CF9O9a4/X2an4UNFXCqMzs+Y9sGK2FAzWuKolyna7Pe+E2uqJwjZlblqJkNrELkcJxanQSp2+3EPinq7s/3YonVgCD3aenvyh9ysLnXIIL4lqkGabtTLybt9Mx9TpD+Uk0UdfQVURcqmHoAhBudY52AR2jSYiyajRK8zoe4vJpEDfz/p3nDM2l1ql5uJq1Iq70VC2E8P3xoB7dAY7Mfi6wk1h4nZTxSm9IfT6DCxI75fw/mkh0dzsblWQL+olHfAuURIfYDcKFnakJy32AGqILGn3nBwQ8d6qcMhrm4uxSVpdE/V4UFwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwL+AVrYcJSIPiXXJRaXXNsMO1Z1QRqxl+xnKQl7kbI=;
 b=C0A0S5pzeMyAvAzEFI7uAw+YELZauKqpujP3IUDQXq+pm+Ri0gzcclw33ooVxTMHwN9ULcDS+/f6BhlRDMJwAxY8zq5vw0SGUgGUQOW7N8cuToAqhrBvwshTiG99myplRHBfk3rk+icRaRcZGdjOw89SLfM19v3nncOtWZJuI7hPQJ6M8YowbrN4XWxXZLAUM0ujuEBdbF68HjPzmFRhB6f/QQozMVQQmX6hV92WuwREg6aU4waJLYT+7+qnwPahZaRaOCD7Vt2suKAf32JGo1gIGE9xZU6bBVPc8kH+aUAsX2nF6i7iZChxB7FA3wKx8XMU9AEaJFPFOwjHlYlkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwL+AVrYcJSIPiXXJRaXXNsMO1Z1QRqxl+xnKQl7kbI=;
 b=FEc8qhFvyUfAYpGakYl9GIHv1myuZ1s1VSDzLv5fKkTUjoZjyOYmDwG8fJ3v+i22Q65KqnzjdyI7bh4Vd7maWxmiJtOQWkDV/8f2tmCbM2ZagcUDmq5QHlIipZARsaZGy/Ctp0ElkiybKI59/XB9O4aQPS6IRemkPTrIsG/08vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 05:54:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 05:54:18 +0000
Message-ID: <4dadbadf-529d-6f50-b30e-8a428d8c6a19@amd.com>
Date: Wed, 12 Jun 2024 06:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, pieter.jansen-van-vuuren@amd.com,
 richard.hughes@amd.com, dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmkkaOTUFuzIr2cG@infradead.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ZmkkaOTUFuzIr2cG@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0274.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::6) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2391fe-149e-4b0d-12b5-08dc8aa41892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|1800799016|366008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnB2eGZiRXI2czl6SCtEckFSVkZPYWdtbEM5NXhuSUM1ZzVoaGFnZWNlZ3pr?=
 =?utf-8?B?YkpZTHVLclEvamVabWNsSHJHQm5iT1N6TklmVTBLSjljeEhtd0hJWnp6YWJa?=
 =?utf-8?B?MGFKNlNWQlJaSXRXZEpHTlMvOW9pc1RUTFVzYmxDOGlrMm1kU0gwWFVaSWFZ?=
 =?utf-8?B?N1dtMk5BOXR2SU1sUVdtNzNlQUNJcFZCSVkxWFlDekFlOTYyeXVZSjhyNkRq?=
 =?utf-8?B?YTNDNGNvM0NMWkNGbmhiUUY2VUJqN1o4eHc2MzZ2a0VaVCtXdDNrT2NFNmU3?=
 =?utf-8?B?dmc0QUgxUXBENHUzeWI5K3NJTDJ6OFF4bWtteG9PVmtuTysrRllobjVmNTNq?=
 =?utf-8?B?QjgyQXNvQUtiRWFwcS9BMld3cmFFOWNlM1N5dkVmTzRVbmcraHdwUFpjcXEx?=
 =?utf-8?B?dEpIR2gyM1lxam9QMW9rdVROVGFWK3FCOC9lRU9XYS9hVy9PVnduMk9BZnpC?=
 =?utf-8?B?Z3dRMENSc01WYXFzWTcvTjBCbHRNRFk5SnNQUjNvRnJZRDJCNW82WFhHVy90?=
 =?utf-8?B?QmNLSzJOLzlzVEoybXl4QkdJMUY5YkpXVElIOXJuVTJ2MUliMmJjVWVYVlhr?=
 =?utf-8?B?WWw4R25GQ1BFaS9aSnFMTjk3UmZCSjRYd0Q1MTlRUEpPWXdwN3p6aDdCR1Vy?=
 =?utf-8?B?dm85aEVXaGJoTlJxOEtyb1FVM2U2UUhDWVl6Sjd4cWF1cjcwWmtaZFJQQXJj?=
 =?utf-8?B?TzFLWmw2RFlsQXdMbE04QkMwRzhuYjJid2Z6bE4xZGU4ZWx5RjJPMnNQMnV5?=
 =?utf-8?B?VUpLS1NjaTB0Zjl4YlRTWlZ4UGcrd3ZOVmpQTlZMWW4yanVROTQ3d0lqMnJQ?=
 =?utf-8?B?OGVsbExIYVNVNFhXRWlPbjdzOUtydURuekpqRGxDK00yUVJKME1YVjFLOWFm?=
 =?utf-8?B?NWVEYlcvNHp6YUQvZmhqY0dkTm5RcURxRkFIcnRJQTFFR01qcGVOcldxcTBj?=
 =?utf-8?B?b1dlQ0lIb3l1ZEY2VndTK1d2RWxhVGpoT3ZkTFBoclcydUNQR3VZYzRpQ0RN?=
 =?utf-8?B?ZDgzTTJNSGxjVnRaSWFLTHU0UkVTQXdJb0FIZXFnbDErWk9WcmxLQ1M0R09R?=
 =?utf-8?B?VjJQVEsrTVl2M1dTcnFGcXY1aysraVJ3bUxZbmFXcUYvRWZJcW9CZm1WNWIv?=
 =?utf-8?B?aTR0SHB1ME0ra3RqZnIzeXJHWGJrQzl4VDdKN1JuRWNGWENsZTk4MGpISjR5?=
 =?utf-8?B?MndBWU1pRzZ4TG9lZG15cDlITFJ6Q3A4Zy9TSlQxankvSEJ4bzZNZUY4TGk0?=
 =?utf-8?B?c1FSVGcrMmpzYVZraEFCUWtsNDBRcTJsOFZDTDF2Nk1xdDB4TnlaZnM2NXZQ?=
 =?utf-8?B?eU5kWmk5bW5DR1puZU1wc3RLN1N5UHA0cTNQUGUyOFBkVEFRTzNmenNVVGFJ?=
 =?utf-8?B?NHlnK3lNbXdhSzIwcVlsRTdUODJkSlpFV2ZXb281S1Q1bHJvcmtmbVpHTERU?=
 =?utf-8?B?Zkk5WXlZUWRTZ3NtNUtIUUNubkZwY0NTRWNMOGsrNnRRRGFLTUN1MkdURktx?=
 =?utf-8?B?WjZsSklVeG9JY3BaNDhPMTZrYWZ2am5vbHI1Sk9WRjdzYmdDNEg3em1GOEZu?=
 =?utf-8?B?enJ5Q2pKdWtsMGdic25IL3JRMUNXVjRzc2FKaEc0c2t5QlZLWlg4aGJDeXd0?=
 =?utf-8?B?clRoV2VSWi9KY0RDd3pmbUpwSDZETWZ6eTFKTzVVbEhmN2tXSTJUT0kvSEhi?=
 =?utf-8?B?eW9idFZhdVdDb1hoaTdRc3BKaGxaRE81RE1MbERTVUNaOXhaRTZWVUNKSWlD?=
 =?utf-8?Q?IpAKvKpoK/HEWAb+dGngv2AIxjlu5hoRePxhwRk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtYSEpQSzk0dk9vOVNhKzhVMlI3MTJSQmlPdUNDSE5DOEZmd2hJajhxTzdG?=
 =?utf-8?B?akhiMEFnbmlXRUlkQjZ6cU52YXE0ditIYndscG5GaEZveGxseWpqT1g1ZXZV?=
 =?utf-8?B?S2hrQ1A1Rk12TS8wZ0ZTZU9xNnQ4OW10dUtralVEQnA5UEhSU2RMOFU5MXlT?=
 =?utf-8?B?dGl4WDVwaGx0RzNrOEhWaTMzMnVSWXpLbUlzalBpdEhEYnlpTVNPYnkxZ3lp?=
 =?utf-8?B?SXRCNTdGMHFaVnhUL3ZVOVVLNndld3E0Q0J0VzVQb3RTU3ZvNlJTQ0EyelpR?=
 =?utf-8?B?SGhsMFE3dld5MHA4cWg0TlVFekpKVllBeVBVaS9TTTRKRzFodDNnR0E0dXJ0?=
 =?utf-8?B?ODUxejhjYUtSZjZ4aTl5ZjZoVnBtN0x4ek52Rm9rT3dkUkhrOXhHV3FvRU5j?=
 =?utf-8?B?K0tqK3BJZnRNTzFYWlE0WVNuNGhzMVhwQ1FaQVRaVWkwZkg2Y0MxKzcyRVgz?=
 =?utf-8?B?RHBVd1orTG8rNEZjZUxoMVlrc1gyUlF3YVFmRXNFWS9RMjhqdkV5L2gvSEtV?=
 =?utf-8?B?SWNEczZCclY3S1Fwb20yWlg4WkJkSUFDR2tHWFBEaE1QOFpkckpuWEdBbDIx?=
 =?utf-8?B?bGhCcnRHWW91Z1Z1akMwbE5wTEhmV0JnSlZJamk1blhVUGlWaHFuOW5rUUd0?=
 =?utf-8?B?ZXZhd1B6b1lOdkM3RkRmMWJZZFR0d3F4dGxCbVRHUGZOQmdReG5Velo5eVRh?=
 =?utf-8?B?L3lGUGJYeUthWWFiUkNISnZtOFhHOFJvc01ueHVDWEtRV3ZHKzRyQzF3MUFu?=
 =?utf-8?B?WGx2NTM2Qk9LcmdwMXBRRG9PS0RXbVViSDdjUWU3emtuSnJxaTN5aXFLakpB?=
 =?utf-8?B?NHhLd0p5R0NMMjgxYlFNTUR2MTREeTVFZEpNNzZXc0gvVDFaUkZVTUtMdXNt?=
 =?utf-8?B?YTRxTnhoSS9ESUJUbDl5eEU4ajhuWVBLK2E3Y3lXTEkyckRRdjhxSTJ0bzAz?=
 =?utf-8?B?TzlUNnBla2wrYmZJVGdUaVRaWnc0SlkxYkhGV0pLM1VkNFAzZW1tQXRXKzAw?=
 =?utf-8?B?TDJtSzdEbmRPbFVHTnZxZm9pVFJ3YmZzQ0VUa2FzeXdoeGZqYUNiR0pNZWNV?=
 =?utf-8?B?NWI3USs4UmZ1Zjk1M0hGZkFVcXN0Y0NNL2p0VWVPb2RVcUpLelc2aWRTKzgr?=
 =?utf-8?B?SDdlVm9Va1A0UDZEQXJqYUN4dHhYTjJQcU01THBsODJnbk9pMjZxYTNpM2do?=
 =?utf-8?B?WjZnT3lGemZObllBcDhXMXZvSnR1QVFHT1ZPd3Y4YzRVS3pvVWFGTnVyTUxz?=
 =?utf-8?B?ZXlLSjlyYXBWT3JlVTc2WEVhYTBVU2czN0FUeE11bUZuNTRjOVhRbGYzOStS?=
 =?utf-8?B?ams5R2N3RzA1cG5walZDMGtuNTBkR2I3b3VpRjFNY1lNR0ZGbVNhL1FkMFN5?=
 =?utf-8?B?QlIwK2lWUitiYkw2cGp4M2FXUnNDNStZS2N1NEVhQ0w5M05aL2xFa2dRVHpF?=
 =?utf-8?B?aGpXTHRrUUhzcXlNM0I2d1BGRjFVVHZVNnhYUU5hNE4rWkQrYkl2R3VqOFIz?=
 =?utf-8?B?N0lVY0wxcmlTVnFXdmdYVXZNQk92VkM2ZXhTdVFQUTdsUDdWOUhodnFBbk9t?=
 =?utf-8?B?UjJvL2YvRjcyT2U1cktlbUgrb3N3TlU1cGpjay8vWHNhSE4rcTNDbzl0cHJU?=
 =?utf-8?B?RmN0SHdFWVh2WFlJSzNNR2MxYyt3QXZta0pkR1MvcmQ2aFVnaVhCRFF4SHR0?=
 =?utf-8?B?T05qMElmYzJCRm5DcStHYmV5dERDa1ZwTG5sdjlSQXBXaDRHVlI4MSs4NVBX?=
 =?utf-8?B?UjBobWN3TlhNZmNuOG1pUVdFU0I1Y09BMk5TUElxd3hHc0p1bjNuSW9yVnYx?=
 =?utf-8?B?WEhZOHVXS1hHTTM4WUxuZzhTREVGcmJKaWVYSERLSXU2OVhWbTljUkc1VVFq?=
 =?utf-8?B?WmR4TlJ4K0Vkc0ZiRlU2NVREWWRrVTFjNTZLSkxGUm1GZ202MC9jamgvUXla?=
 =?utf-8?B?c2VGbVZZRkFUOUl3RUluQktjb2pyaWh1QTI4Ui9NTmJhMjAzNHRET3Fia1kz?=
 =?utf-8?B?WFhuWjJwaktqT3RmM2hQQnVPQTAxQXl0MU1ZdzhEYXpTeXJmczhlUm9PREtt?=
 =?utf-8?B?K09Rb1Zvc0NhbTNYQ0ZKWS9wSXlFV29VWlh3V0NPQ01laEExdHJvcGhwaUNI?=
 =?utf-8?Q?LxZydjGiYl4jIZJgY96Y92tjs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2391fe-149e-4b0d-12b5-08dc8aa41892
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 05:54:18.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ljgHaIhZRFyieFJdEq+W7ymsApbHA2Op27Oxt+y54AHgawl8RalBoF4q0jl3ASbGSMW6aHWUvridJ/p9rIh2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801


On 6/12/24 05:30, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
>> alucerop@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> CXL Type 2 devices imply specific vendor drivers binding to those
>>> devices instead of generic ones offered by CXL core like the PCI driver.
> No, it absolutelt does not.  There is no such thing as a vendor driver
> in Linux.


Well, yes, I see your point, and it is absolutely correct.

It was a bad way of explaining the need of a driver supporting a 
specific hardware.


>> So I don't like this approach, there are details that are private to the
>> CXL generic memory-expander use case, and some that are suitable for
>> CXL.mem and CXL.cache capabilities in other drivers. That distinct
>> subset should move to include/linux/. I.e. I want to see the incremental
>> conversion of what 3rd party drivers need compared to the generic
>> expander case, and consider when and where new shared infrastructure
>> needs to be refactored.
> And I'd much rather keep all these drivers in drivers/cxl/ anyway so
> that we can keep a tight control over them.
>

My initial thought was drivers for ethernet, gpus, or any other kind of 
standard device binding to the CXL/PCIe.io and doing the CXL 
initialization. Your comment seems to suggest other approach, which I 
can only relate to using auxbus for the device CXL.mem and CXL.cache, 
and  then being handled by a generic driver inside the CXL core. Is this 
what you are suggesting?

If so, I'm not against it, although it would require to study the 
implications.

