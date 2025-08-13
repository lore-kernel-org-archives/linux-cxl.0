Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D12F0693
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084321; cv=fail; b=t98IQ3bjnMr0yiLw584dB+yUL2pmqa7VZWMq4DTyXJrfRx0/OSb2TfMjD5XzG2catxg6zb+bkAY4q0uggagh/quVSirKWIK375SRiQ+tQj/7hldOnmC+qzbcMCQT8JfCFAuIIm66laAfVmU12n+OetcfhWLLd71gYEAgv1jWRtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084321; c=relaxed/simple;
	bh=b6d4Oc0p2cSwOFB2TcpZaq9hAnNX78rCIfk+Cv4s0hw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gag1cdPh/ppcGeKgdoddVac5YcDU0DoZ8K/QDtMeqkw+UZY5CJunTuVGHFDiMAN929HpR6Aw00KlEM4zl7/19o2TwY0zS7QMIA330tLsiE9PaoSGFffpzOfQGbTSmjt2evyVdLCN9U9LousW0JSWJKWv+bLN3M35dFD5qoujj6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QmaCypqx; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QmaCypqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fip8SCbapN/zusYrWOK4ea9qklqujIg0K7c0EC82Oh38edyzBmIFn37uHIvWYNrEk2qoErqy6CcKVF+IPNjv/9kDWoFVImq7mw2kBEm+7rRNTqTENR3/6gEdUo41Kq8EFJJymeGPN2Orzw+1OUPH6KRGlLtXJFWQojtJIZjDFxwJaPR9jfzAMCLnbxBjZHeYQU+xnXWAipXbrNo+PubTHeac8YBlJxGJcHwoSXshGOfSq6Qp35exjdzIk+2/XLs8VQDoeaRyyNJYoxSM2UW9ZY3xoCHaiaU4rzgvVl2A3LK1cRla3cq94+Fbhv1XvQMqP2spc4TKlY3i5OjwTI6ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9h02XXyDa9wI0AB0ZrHKE8xXheDO89LcBMLBw8KwjA=;
 b=a5r7wZhR85ZARug/Sp0TdHlx3vcJquBqu5fhy6yqit8bb6pGrxa9N8xCpjoZWVV7X4lHi4iABc0AywwqcyefmZ6gCZNJ75a0Bb5zgqYyNxQATc4UREfczkx4BJ+Wpqit3slWdcmefL+ict0es/lc8WbqAmOKC6rqOadn3Xar4hOJGvyLlZGYJKEYuEur6Jm2Yl1Qk6Ivwq4P9BnU4jZLQe7KgXfWLDjgJGcpL4LtOmzP2lSTtKQZvplJPrsGBC9MOJadDWPCCawB6zqSpheLoSQAdzEevnfmsaXQei4ixzW+3sODO+Y3kR/9EJdvmMOerAcAbPkf6wVn13WvibRWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9h02XXyDa9wI0AB0ZrHKE8xXheDO89LcBMLBw8KwjA=;
 b=QmaCypqx6TSPVkRsEhYBrP+pSZN1CVwMW9hA+b9Zyzv7pESZquRRmRCDz66R3sMeinFQUDn2xkNiJ/77jEnK/8PXxJbUKti4/dnAggBgahCPaDHoCY8ZfudPkOjzkPHKJ8KajjcQ0xJykTMXI68KKqs6qTWhWlEDNv1UEWZtln8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:25:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 11:25:15 +0000
Message-ID: <f3ac894b-7c8d-4f9d-9bfb-d05c7d7c5650@amd.com>
Date: Wed, 13 Aug 2025 12:25:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
Content-Language: en-US
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0231.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f222b9a-9a1d-42bf-4cae-08ddda5c1356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0dMYmJrckMxUXFCYWJkYUExWTJmWEI2K0VLMW0remZPMHZrY2ZVdWVhdW9i?=
 =?utf-8?B?WmJnTE44bGZFRkhNVUZhQisxTU5JN1h1a09GbWtnL1Y2NGhqM2MzajlKbGtK?=
 =?utf-8?B?K1VEL2tsd01KMGtvNUlWcDMxeW0reit6ZS9NcFZsNnN5b0ZRbjc4SjRYMlFS?=
 =?utf-8?B?M0xHNmVMNVRPZ1hKc1dnOGRieXpCZ1dqUEpxRnYzbkFLT2hpdXd0WVZLMVdL?=
 =?utf-8?B?S3pNb1IwRVY1cHF5aGd1dVVCMDZhSzNVYXVIQUl1ekhYVUExWEV2T3BpdGtI?=
 =?utf-8?B?QTQxUUhRTVJOZFZySDFXSGlTdm95Z1pVeGpFSG9EQndQYWhrZWpFZjlHVEsy?=
 =?utf-8?B?a3YrS0Z5V2l2TVlDOHc4aGM0OUcvUVZFYjU4UEdWY0UyWWMzblVmczkyajhV?=
 =?utf-8?B?TWp2ZHlFVTR6V0FEM3VSNm9Td1J0MHpwVjg0LzlmY0doMWdKSXZQUUZyY0Zv?=
 =?utf-8?B?ZzlmdTFKelBLdGJxYzlmdUNoVXJVaU1iYjhFcTBTeFYvNUx3N2dyakNpTnBq?=
 =?utf-8?B?VkttaGdUS21MZVlmUHY4d3VBRUU1Z3RNREJiV0JCVXpaRWpJbEovcW1oR3Va?=
 =?utf-8?B?QTF4REwxUnNOSHhtK0VGT2s2NmpEbXd0azNvWlpWUlpmWHgwZlpkeU84UEk3?=
 =?utf-8?B?NXYzQVVnQWhMRmp5NXBYNERYbDNUYmhQdUdqUmcrVFRBcmM1eXRxcUNkNmE4?=
 =?utf-8?B?TFJ4ank4OUFZZ0s2b1JxMkorNjBWdnBlMTlDOUl6ZU5pd1hSOFJvTFc1SzBS?=
 =?utf-8?B?WmRXK3E3b3VydnhIZnhPVDlnSUpteXJhZ0pXTDh4R1Q1Qmw5VUVVYXYyQmRX?=
 =?utf-8?B?d3BZclpjNGZNWnFIcDNpenR0VU8xSVlHV2xsM3pRTkR3YmhwRWxjb2hidzdC?=
 =?utf-8?B?YXhUemxRQ2l5UDlrRUFQdVlsR21Pa084eENuaG43SXFOa0QzM3ByM3duUnU4?=
 =?utf-8?B?S1VBeHdRcUR5V00xamVKYTFQWEVWZHd2UGZGdmJSMHhmenhuTUsvLzBIaUxL?=
 =?utf-8?B?TDZIWXk3TFFiZ2k2Y3Y1Z3RzdkowOWUvT3dsS1hrMUgxb0tSRFRHckF5TlNE?=
 =?utf-8?B?aXR0d1QrZ2xOTllrQUU0ZldwekZTcmNmS294aTNGbUpMU2JxY1kyUFBzNGor?=
 =?utf-8?B?TnVPeUcxWFcweG5CL0pVRlB2SUZPZ2hma3N3dFowRDZDTHR4ZG52WmU0bkJP?=
 =?utf-8?B?YnZCUWNYSUhZeFU2d2pTOG9WSTMzb1VzcXBMTVk5WjRFdDN5WXR3eXdTL3JT?=
 =?utf-8?B?TkpYOTI0NzBGZEJJUmQ2ODdNWXFPbFlTVERjQXNrNGxIRmpRL2d4Ui90N0pn?=
 =?utf-8?B?L05OWlBxeW1lR1dZbnI3NzFZcWc2WjJJMXk1TisvNDhSdGVSZzFZa2JQS1Ay?=
 =?utf-8?B?Y2hRRjF2QmhhUUIyMG82SklaWm9sVEdKbi9lNmd2V2RlcnlXNXkyOTF1QUlU?=
 =?utf-8?B?andGaVFURkY1ek4yYll5bytrSm02YTdDcTBRZENWdnhSZ0t2WmI0QXNGTFVI?=
 =?utf-8?B?NWhiZUF6U3BsSmlxRkxZZFIvVDlhOVV6dUhveXQ2ZjNCK1RMcFVENWpBS1dX?=
 =?utf-8?B?V01FUEt4empSb2oxMitsdDNIWVFWdTJjVGk5YkU1QkluUHZ2eE1jZE43MFc1?=
 =?utf-8?B?NGR6Z3dRVzdUQW5McjFaY2N2dU5nSHQ4NWxOZjJkN1JSWlFyTFM5OXlRTkRM?=
 =?utf-8?B?RU45RDR2MDlpOXAwUXNkaUZ2NU9HUGRISSsxTUFsTzg3bnBYbGRPWnkxV1Bx?=
 =?utf-8?B?OE5KcWVvck9jMFpsSWZMZ2QwNkRjS29hRExUbzFHTDZENFdRcUxFVVMyYW1x?=
 =?utf-8?B?UGlHbUViS2ROQURtVWpiUWlLTW1JaHE4NE5qTmNBN1JJdEthczNVdEs5RkZj?=
 =?utf-8?B?UmRWQmxWaWZvSmxPNkZta0w0bmd4R3RwcG1EcktTczBnOGN6VkNqekhzOXRR?=
 =?utf-8?Q?K6noqnvsBA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJhL0tBUmFkbDdUbHNRTFRIYkFsN1c3MzhZWjExNCtuL2FlblZIUzhwWFJH?=
 =?utf-8?B?dnpHV1IvNmcvak90cFg3K3FJSVQrMzAxUEtlWjczRjZEM05wdjByMkNjdjlF?=
 =?utf-8?B?TDgrNFlPdjYySW5UWmFQbjVwbHRYSUcwL3hxSldNZk9nN2lTTlVIRkhtUW9l?=
 =?utf-8?B?R3hpQ0oxOElCTnFOSytOd1RkS01sRFdMVGtObUVlaGVUT3EwNFZ5bk5LT0k5?=
 =?utf-8?B?VTZyeFJUMXAwTFRNRnEwSHJXL3Q3MjVLZThoZnoyb2tVQXJKSEtiRGdxNDY2?=
 =?utf-8?B?aXJSa1ZQeHRwMm9xa292QkRDQXlwQTAxT2NYdURXLy9QQkpPZmUreXlYUUNV?=
 =?utf-8?B?cjJZV1VLM1Vvb3htaXJmQ3N6NkF6dmJZQUNJN0dFeU9SSi8xUk1JZTRUcEpU?=
 =?utf-8?B?ZWRYVmdCclpuc3NDTWJQUWZBa2J5bUQ2cGt2cEtjVCsvQkVXeUZlM1BZdlRF?=
 =?utf-8?B?UUJ4cFVrK2syYWFZU1lWRFhhbTZqTW9XWFBYSG04R2lZTm5GY1F2enZOL293?=
 =?utf-8?B?Q2s3L1JFVitpb0RCSEF4VVliZXFQV1Zpd1ZNT1ZFNlorOWlxUENIU0Q1RDdz?=
 =?utf-8?B?Nld1Q1U5QWd4WVdHOFRIblNpL09UR05QdVgrYXpUM3ptaWduenJMYWtvZzF3?=
 =?utf-8?B?WnB3c0FLN3dQQ25ueXF1QmdONjgxU0JPYTEwT3VEQzBscmV5b3RuUHo3Tk5z?=
 =?utf-8?B?ZWM2S2I5TU1jaU9GK3V0NnhNSG9SM0N6T0VEM3V4bjhhclBuQzdGN0k2RSth?=
 =?utf-8?B?bXFaNzVXMHlTbVd4cU9Xa1ZHWVkyekdJQlA0Wit5WVdvVDE2Qjh2MFh3ZUxJ?=
 =?utf-8?B?NlA5Ry9EQlVya0Z6c2RDTFgwcXQxdEZwSnpva3hBSTBwQTI2ZUdCOW9xcGpR?=
 =?utf-8?B?S3RkbVlSV1lyWXdVYmJ0bTBYcExPd1R6T1ZQMnBxK1cxRVFHTEowdHcxMzI0?=
 =?utf-8?B?a0RJNzh2TG9BU2VlQk5MRktzcU1BQUxuWUJnbXdDU2RNNTgzWWpXL2J1R3Yy?=
 =?utf-8?B?SUJzYmN1Nm9YUGd4OVg0ODMvbG5WeC9kK2ZtMVo2TlVTY2JmdSt2M3hmR3FG?=
 =?utf-8?B?TXljcFFyWnhKdmtrV0RHRG1SVGFhVjY3ZCtjS1hqZnZsTUhrSzNnWWJuY0ty?=
 =?utf-8?B?blpITzJ2RkkzVFFDSVkvcGd5Z2R5bVlxbGJsaXNJc2xKMHJYSmI3KzNTUlFT?=
 =?utf-8?B?ZktVZU1SVUpYMHZRdEtJekV4cExOMFd5WEpoQjlvaXpFZUJtcEZTRnR5Z0Rx?=
 =?utf-8?B?TGZMc3hnTHlRT3c5ZUkvMWdBL0ZiaTNRVUo0UjV3S3FUektTVXlPdUxtNGdN?=
 =?utf-8?B?MEY2Tjkwd2FsNElqb1BjZlBzQXZsc3R2WmMrdU43WWVSRTdiUXA4RmZzREta?=
 =?utf-8?B?UUpFMTA1WlZReVFFUllYb2JWTldKRi9jcHUwUVRkUjlnbXFPL2NNS3hoa0Nu?=
 =?utf-8?B?T0pYcjUvUEVYa0ltbzdUd2gyRjlYSWpPcEVUZ2tVekExZlk4ZGRoN3FUSW9F?=
 =?utf-8?B?SjgwOEE3blVQQVpCWnNXdUhrOFlJNFl0bjJaZXVBVnRRYW9TcFRHT2lHN1gw?=
 =?utf-8?B?U0MrUzdnQWQrU1J4TXRvY3Jwb2N6VzZldnM2S3RRVjlXV0daWkRTc2FzUFgx?=
 =?utf-8?B?SGQ4R2FQYzNVNVVZelZoNXYyK1JJNlpoM0hhSUVtS09HeHJUWnNCekpsVzJ6?=
 =?utf-8?B?d2Z3ajI3NDJTaWVlOVptWDVieG9EZC9VdVcyYXVjOTVZNzhJN0pURWRueVZp?=
 =?utf-8?B?UkY1Q0FBM21TVFlFcnhVbjdBMk5VNGh6RHVCYmdGbDFDL2ZDdmJ1L3NGdGEy?=
 =?utf-8?B?WjZwODRYd0REeit6UTJtbXo2MTk4OHZCSi9kaVhzOGxLR2pLOHpNdFQrLzZJ?=
 =?utf-8?B?UzJiRStUTUFVaERmczA3SjhRUm9zUDZjcTBPTkVaVmRmVnV3WUF2Q3RWamZJ?=
 =?utf-8?B?SnV2aUJOU0NXY3E1amdSeTFtL1Y4N3R3b1hjNlNsMVJqV3ZIMEdKd3NlQkFn?=
 =?utf-8?B?c0YxR1ZwU1IrdHhyZWdTVVVLQWc3cWJtdjgraWFWYjkyT3l4MGdxOU9tUENq?=
 =?utf-8?B?blFQbFlydWNPbHVQWi8ycGh3TGcveHlidEROZnNNb1dJRnV5M1lRdDlrZjdJ?=
 =?utf-8?Q?DhCdJImQIwWuhCwzv9ngvjN+v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f222b9a-9a1d-42bf-4cae-08ddda5c1356
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:25:15.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJd7DqXEEA4vGDqcuCF90vzAR34KFhauyWJX3nWofISWVHk/uWVdJOMGlCjYmqrMFKGTxmx2QqIU53Z8N6SO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

On 8/12/25 22:29, Ben Cheatham wrote:
> This patch series adds initial CXL.cache support. What I have here only
> allows for adding a cache device to the system, programming/validating
> the system configuration with respect to cache devices, and some basic
> cache reporting/management.
>
> The general philosophy is to have an endpoint/vendor-specific driver
> that runs through the same steps of adding a cxl_memdev, but for the
> cache portion of the device (both type 1 & 2). Getting cache support for
> a CXL device should be as simple as: get cache information, set up the
> memory region (see below), and then calling devm_cxl_add_cachedev().
>
> There's a couple of things missing from this set:
>
> 1) Missing an endpoint driver
>
> 	I plan on submitting a reference driver (type 1 or 2) with v1, I
> 	figured I'd send out what I have before going much further.
>
> 2) Mapping/Reserving host memory used for CXL cache(s)
>
> 	I'm thinking this will be handled by the endpoint driver, but I'm
> 	not sure what mechanism would be used and whether to integrate it
> 	with the cxl_cache/core. Any thoughts/ideas here are appreciated!


Hi Ben,


Good to see you working on this. I'll go through the series these next days.


FWIW, I did send a RFC last November about my concerns for 
properly/safely supporting CXL.cache.


I had no time to keep thinking about it. Also, I sent a copy to the 
kernel iommu mailing list, but it did not get traction then. Anyways, as 
a summary, I think mapping for CXL.cache requires not just the endpoint 
driver doing it freely but through the cxl core for ensuring it is done 
properly and safely. But I have to admit this could be a 
misunderstanding about how the hardware is going to allow CXL.cache.


Thanks


> 3) RAS Support
>
> 	Same situation as 1) above.
>
> Some quick notes: The actual cache parts of this set are untested due
> to problems with my set up, but I did make sure nothing here breaks type
> 3 support. I'll have this fixed before sending out a v1. This series is
> based on the for-6.18/cxl-probe-order (commit 5e29cbd1077b) branch in
> the CXL repo, with v7 of Dave's deferred dport probe set on top [1]. I
> added Dave's set to help with getting around constraints with HDM
> decoders in CXL.cache device only configurations (see 08/18 for more).
>
> Patch Breakdown:
> 	- 1 & 2: Preliminary changes for struct cxl_cachedev
> 	- 3: Add struct cxl_cachedev
> 	- 4-8: Preliminary changes for adding cache devices to port
> 	  hierarchy
> 	- 9: Function for getting CXL cache info
> 	- 10: cxl_cache driver (mirrors cxl_mem)
> 	- 11-16: Checking CXL.cache capabilities for system configuration
> 	  validity
> 	- 17-18: Cache device attributes
>
> [1]:
> Link: https://lore.kernel.org/linux-cxl/20250714223527.461147-1-dave.jiang@intel.com/
>
> Ben Cheatham (18):
>    cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
>    cxl: Move struct cxl_dev_state definition
>    cxl/core: Add CXL.cache device struct
>    cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
>    cxl: Change cxl_ep_load() to use struct device * parameter
>    cxl/port, mem: Make adding an endpoint device type agnostic
>    cxl/port: Split endpoint port probe on device type
>    cxl/port: Update switch_port_probe() for CXL cache devices
>    cxl/core: Add function for getting CXL cache info
>    cxl/cache: Add cxl_cache driver
>    cxl/core: Add CXL snoop filter setup and checking
>    cxl/cache: Add CXL Cache ID Route Table mapping
>    cxl/cache: Implement Cache ID Route Table programming
>    cxl/cache: Add Cache ID Decoder capability mapping
>    cxl/cache: Implement Cache ID Decoder programming
>    cxl/cache: Add cache device counting for CXL ports
>    cxl/core: Add cache device attributes
>    cxl/core: Add cache device cache management attributes
>
>   drivers/cxl/Kconfig         |  14 +
>   drivers/cxl/Makefile        |   2 +
>   drivers/cxl/cache.c         | 276 +++++++++++++++++++
>   drivers/cxl/core/Makefile   |   1 +
>   drivers/cxl/core/cachedev.c | 292 ++++++++++++++++++++
>   drivers/cxl/core/hdm.c      |  31 +++
>   drivers/cxl/core/memdev.c   |   2 +-
>   drivers/cxl/core/pci.c      | 134 ++++++++++
>   drivers/cxl/core/port.c     | 518 +++++++++++++++++++++++++++++++++---
>   drivers/cxl/core/region.c   |  25 +-
>   drivers/cxl/core/regs.c     |  28 ++
>   drivers/cxl/cxl.h           | 193 +++++++++++++-
>   drivers/cxl/cxlcache.h      |  42 +++
>   drivers/cxl/cxlmem.h        | 121 +--------
>   drivers/cxl/cxlpci.h        |  10 +
>   drivers/cxl/mem.c           |  14 +-
>   drivers/cxl/pci.c           |   2 +-
>   drivers/cxl/port.c          |  54 ++--
>   drivers/cxl/private.h       |   8 +-
>   19 files changed, 1569 insertions(+), 198 deletions(-)
>   create mode 100644 drivers/cxl/cache.c
>   create mode 100644 drivers/cxl/core/cachedev.c
>   create mode 100644 drivers/cxl/cxlcache.h
>
