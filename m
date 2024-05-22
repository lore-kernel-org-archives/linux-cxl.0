Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAE6AD7
	for <linux-cxl@vger.kernel.org>; Wed, 22 May 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395899; cv=fail; b=sZdJxMumObRKTYqNlhmcktlVY5GY+HxfOyrv9pzM1PfidM4aNQWWyEeAavqTDYitSx3ACvbpMv40PLwhg+md+HPfWycILlQXrBpgGPBkcnGVA7u6AikJQS/jjV5F1UNKn7ZgZu6Vw2MAE+9GUC2pShtHj0vwLm5WrJtLSzHxEOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395899; c=relaxed/simple;
	bh=XQtsc4i4w8jLBU5PL1bmSIPktgdlYrmdErFqzlU/YxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCFCEnNzfO9R8CEqjHBq5KYzGhk6InUkBuMsvohmKBtjjE+6xZKeyeka2QaiQdOaw9teoVzIB84SqR0oDilGa7Ldfa8WZ+LR6D2IZA+8vhVpdaF/Kfpo+JTWwwMRVNsKwQMpbiiQw4OZVf14iPzBwDxRFdF7qqzy3H+Msukwsxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3k9AWqd6; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3k9AWqd6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9bYTnFh7NTiDPy9OBpr5SUnY88/j9N2Z5GK5+k566lf1SiZAuSNEZSFUG+tcKOVYIEaJ5dIXqMQ0n8WyhxPLEj4HDqAzGOqpBTmT9Z/Cikm3CYENk/d0uA8AaBWhYhqgAV/jACnqCKWvTrdJ7QvmG/XLjhwbzMumhOE09ShgSmJM5DgaMAyk/WlvY/P6KQ4EAln5YzJpg7P67x16CHZNAh0oNeFKffSSR62hztmkqULWUuYOQ7+U+4lXB5l9BwLwB1E047f2WTh9iUiDb1NGaMiohivVEn/KpRU6R28LNBld6NysNFuJh7ndmAzP1FKY96okexwPJR0zcsT42v1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm5OzUhiQiYTJ5hSs3PUBaf1DZOC+R6HQ0/qHdq+7J4=;
 b=d5o8Zo9Oi6REWp0LmKw0b+wIwgV+TrPSLECJYLFiQtmvwH3U7g+1Mmf3TZ5jjE1DEIy/iYY/6VyMQ4dFv/UdaX2iDQ85qj9Gv/1tPVUoAvEw6SqJQzsRtJbRq3UWkIGTy0SOLtESN40vYk9tQlf1RjukWFOg4CQWG4x1UwM8iRiOTMlRIELrRtqRnNJONNtpHspFqXV6NZrfFq07zO7qmw2Hn/Qv2Dh6fXfEGlg+nJuZNbNEbrcIYH/W6rNmYxYGvA7A93pgqddVzSf3kVXNz1l9iJiF7INh75PYEYCKTNGge7tHBVoWq6EA02BRh9tqcXzvALncJlCclkHUEc5lFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm5OzUhiQiYTJ5hSs3PUBaf1DZOC+R6HQ0/qHdq+7J4=;
 b=3k9AWqd6ZTZfzhzKeWKxQu4ryJhaziEVob1xEBlF/tA1k9/AeRWTxSgahgTJIGWquhQm84ygGdoc0LpEYjg5lPwrtbe63D5GZ0Ozhp+gA8ffmPujpHeEyRYC4+SYKRf7BJ5LORCnTeXoXt82myM3O/RgXmltWo1/NV3tEa8bLMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 16:38:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:38:14 +0000
Message-ID: <257e2959-5919-a847-d3e7-53f53bc0e131@amd.com>
Date: Wed, 22 May 2024 17:38:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/13] RFC: add Type2 device support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
 <66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch>
 <0a5e5366-92ef-d608-43ab-e0756e0458c8@amd.com>
 <664c296bacb6f_a0282947a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <664c296bacb6f_a0282947a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:10:36::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b18bd81-b48c-4cc7-7c05-08dc7a7d9319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnVMOFY1WmI4MVY5cnhMdDNMUm5iOUwxV2syYmlOb1UycVVJSVExNGU5aElD?=
 =?utf-8?B?aEhQNUdFY0pMdGxNeDJuRjN2TENtQ0JvTXlmNlJJTW5jbllIYjVYWXFibURr?=
 =?utf-8?B?Rzd5Tk5CVHNvQVd0VXpKZTZZYkFRS2RNb2prK1gzK2VTYm9IbWZQemw3bDJq?=
 =?utf-8?B?Z3pnNjlpcS8rdk16dGdjNDY5VUQ1VzBGb1FnZERrcGhTQ1VwTDZDdURaUmcw?=
 =?utf-8?B?L3puR1oyM0luWjN0UXJJK2Rjd2Y3a2g1YVFJbHFLUUdDb1JibC9WZldPc3ZG?=
 =?utf-8?B?Rll0M251QkxJOGplSUZaNUtZZUJoZGtubUduendmVGVHTXl5Y3Z1ODZDZHVx?=
 =?utf-8?B?MnhZYk5RYkhkcmZUKzFLZE1Na1dyR0JhanRxNzBNalkxWVpOS2tENWNrZ1BR?=
 =?utf-8?B?bFIxdm1sbkZleDQ2U0pKV1kxTkhDaTVwRk8weWdHSHlSMG5TSmZ1dFNybDdn?=
 =?utf-8?B?TDdDYXpneEcrZ3A3QjFNMnhpWmpVUFI5cEk3OHZVUUp3R1ZDeFVWU3FBNS9N?=
 =?utf-8?B?U1NvcDNVaXk5cTBXQ2JmMmFBQjJ0WkpGd2k3NnEzR1B6Wnh6a1VJWDlyT0U4?=
 =?utf-8?B?NEpROE12ZXZobFBTK3Irc2YzRFJFbnh5VHhjVlVzYTFKVithMjJXZkdxNjRQ?=
 =?utf-8?B?NEt4VkZlSlpGVkNJT0QyRXJveEpYL2pLVy9xZVVFdm9FYXBHbGlNT0hRaU9B?=
 =?utf-8?B?Qng0YjlmdEJLOE50UjNiZWtDamw3N21VaVozNWthQTRCRzczaW5ZQlJveUsy?=
 =?utf-8?B?QkVLa3dxTTVzTlNXVm82ZmxZdDhKN21RdFVjQ2szV1ZLU1B3d09KU1EwSDhG?=
 =?utf-8?B?aEdzR0hSUzR6TFN6Qy9hMEUxbG1FVjFtYVc2UkJtSmZmZmdKOG5vbXBrZnNV?=
 =?utf-8?B?UXJEWk56Y2VvUStYMVpkLzdtbUxLTnVnRis2VFVwbVRaUzZUU1RSR1Zqd1Nn?=
 =?utf-8?B?VVI5eGF2RWtEVW4wWlQzZ2pGejh1bHZ2dHlvWnMwM0lMSGp1c2xoeHlXVXdR?=
 =?utf-8?B?VUZmY0xtcHgwWWZML1d4SENUV2pUM3VzQnJzNEhSRWt5Wml5bGNUYnFKdGVu?=
 =?utf-8?B?U25uVW9UZGtjak5wb3orbFA5ckg0K2FGdzBWVXV6TVV1VDVYZ3hGd2gvYkZG?=
 =?utf-8?B?c1lYS1Fqanc0RW1GaUlyMVpzMUpBQUQzQ0tLbVVxR1hIWWJsT1ROb3F6K3E4?=
 =?utf-8?B?emJvb0ZKbUUxeEdwSWNoMFZLcE5XaEk3eGRRWGE1Y2NQT0xNVlYxRWhobnF1?=
 =?utf-8?B?Y1RYWStpV0Fhb1p3bDZ3WnYxV2NPa3BDWWRHazJKNTQ2MUdFY0dDODF2VCtG?=
 =?utf-8?B?Vk5UWUx1aVE3OHpPU3lmNXV2ZmxYUktYbE1NS0Jhbkk3ZUlYUmpxWGY5azN0?=
 =?utf-8?B?U2E2azJVQXhvTXhCYnVDRi96VWJmcFZ4Rmx4c09YVHhTbVlRWWZuNmJqWlJu?=
 =?utf-8?B?dmx0b0Z2NWY2S1VyRkR2ZDdtVldMc2VWQ1gwVE5RNkJwT2d5eVJNT2c0SnFk?=
 =?utf-8?B?TlBTYTBha2Y3UHB3MnRwNUM4QkRUYnlpVUhFUU5WZUlSYUl1dlhHZTlXdklU?=
 =?utf-8?B?TlV3a0ZPUUh0REVsQkdoL05nR2RiYkM3SDZzYVdOZUpNb3ZsbGwvdmx5QXpQ?=
 =?utf-8?B?L1RZUmtxYkt1c3Nvc1N3RFc5UEszK001QjgzM3JnN3VPR1d3eU1FdHNrcXY5?=
 =?utf-8?B?OUZ1MEhNQVRZZStRNkpSbml5MS8rd3k0Q1lFbVdPdFhzNFBJTW5pV2ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1VFVjU3Tnp0QlBXVkQ1OHVjUWcyVE9zOStvZ0FKbHVjVi9EQ0JieURKVFht?=
 =?utf-8?B?by9TUkpMcmxOZHNQN2ZTMTlBNmt6SlJPaFA3NWNnRklYTFArMzYxd2lZQUN4?=
 =?utf-8?B?ZlpqcUlsdGRJZFBlSDN2SjJ4bFRXWGdkaE41NzlJN0NaTERQTHB3WmdnNnda?=
 =?utf-8?B?M0VqZ3IzcTRRcDZFcStKOExHS1hQaEtrUmRnKzl5N08vR3NVQU0yYW5LOHgx?=
 =?utf-8?B?MGlWRWJsQXBNYS8rR0JETlJZVkk1eklLalRldVBnTDZRaVdkZUZvZXl3bVZm?=
 =?utf-8?B?T1VCT3pqWEVTRXRhV3k5bFdTZDZaeGdnK3ZnZkxyTnZsb1orWVh5ZVdISTYr?=
 =?utf-8?B?RjdIRGRQM2tVWUxob1dITGJKQnNYWU0rQVZzOHZyeFJxc3A5SHVVWU9pa0pY?=
 =?utf-8?B?ZjhKUnFObHpWazRCMkZyMVlSNStSVElieUJia0N5VlRJWUdJNVAyc0tFbW9G?=
 =?utf-8?B?R3phSG5SQTAyK2p0OCtqZmtGdDZWVlVMQnZ2a3ltMmcvWUJ3dkRzaVY0V1J3?=
 =?utf-8?B?eXVkc0tUamMyaE5PL0ljam1mWnNEaTZCcGpETGhCaUV6emU1Q3NmaW5QT0Zh?=
 =?utf-8?B?QTdpajNSVFgxa3hDWk52SjdiT2gyUXZON3Y3MHhQMzIrQ2haM0puejRZSEw1?=
 =?utf-8?B?NEhqWmxiN1hlSmNNS2ZlbFpGenpjQlRFaGhURU9sMWtReUxud0pwZEtLUm1H?=
 =?utf-8?B?V0JocWMwNDV5YzZxVDFrU0lQTmJNcDVWSlZVS1FMYW5sTGtaZCtNQ1RUV3Mr?=
 =?utf-8?B?Z0RjcXdWelBZRVZDeTRFK1NUeTJWdWRBb0FlcTMxSlZwcmZWVUg5WkdnM2Na?=
 =?utf-8?B?cGptUzNSWUhHZWpWM1lmT3FISDhrZyszaDN1ZVQ5N3BnR212NElXZkpZV3NT?=
 =?utf-8?B?N3lIWmdwK0dHQ1BoNmp4MXVhUkpPdUs5a1o3MkduWE56elptaVJqQXpFWE9x?=
 =?utf-8?B?TUkzeFNlMUh3TWhPeU0yRlZLZGZpcGdUSFZrbG9Xc2I1NmxBU2hPeEY2azZr?=
 =?utf-8?B?Mmd6VlR5RFltZlZNRG1tWS92Z243UlA4L2F1Q3l3V3lBUE9MQWh3d2tqQWtY?=
 =?utf-8?B?cnVQRDZ1bkFhVkg3Z3pVK1lCZW5NbTdMVFB6SE1ITmh6UzVnWVpWMXlLeFRY?=
 =?utf-8?B?SUR5b2laYkRPZ1J6a3A0RWlCek9hSmE5emkwbC9XanJ3aldkT2xlc1FON2Zs?=
 =?utf-8?B?RU9ObVV4ZW5KTDRyQmJCbkZpcGNidkY3dHRzcGdHNzZHS3hacldzZHBqdnF3?=
 =?utf-8?B?VDI1QjJ5b0dHTWZBWDF6c3JXa1YzRHFqVlJ1TGN1MUlZMEQvVXpBNnBBNk9h?=
 =?utf-8?B?d0lSRjJ0UEhWT0pCUkMzNzhtc1ZqK1BjWmIvYkErYXpPTDhNbEtWYU03VHhJ?=
 =?utf-8?B?cFAzanBzODRSWkp0ZjFGQjNrMFVkdXA2MFZObUl6QVhvS0hMTXV5UWdnTFRY?=
 =?utf-8?B?OFBlRUpiYVBkdHZ1clBYN0RsMGdybXYxKzVoN25DLy9ERHBaNFRCQTFCQjVO?=
 =?utf-8?B?TFJxZnRSUjZjQTFDcXA5NjJVZ3FQK3hnQmgwMVhQZE54eGJpSWduTEpoTVph?=
 =?utf-8?B?ZlhyZlZadmt0K0M0Wll0aWJHVXdkM1FtY3J5ZkVSNWt0SndkdmgveGQxMGlL?=
 =?utf-8?B?dnZZRmRJMndJVDBiTFhXRDdqT3lmcXpsTWd3aVQ3N2VjSXNqU1VVYjZUaVNa?=
 =?utf-8?B?YXZtZEJsb1B2VlB5TkY4N3RGR2JZZDcveFZvUXM2eUZOTlNEWlJzN1NVNmd0?=
 =?utf-8?B?cW9mQnl1OEFxMlBWSmRCMHJpN1IrZ3hYU1RrZnRsZUI1VFptQTFiVUVmcko0?=
 =?utf-8?B?eUQwWnNIK1NJUW1neXBsZDQ1WWVIRlQyZk1IN1dLNlNvV2NabGJKZE9wNmZ6?=
 =?utf-8?B?WlgxdnZrSnFISG5qalFXV3NtV2lIQ05IQm96N1NiYmdPeDZRQ0w3M0ZtMWpo?=
 =?utf-8?B?Q2FTclJOQ3NJWHIrZzllOXlzRGZ5T3JpOTczQW0zbG44emVGQktTSlZKdkVQ?=
 =?utf-8?B?MlBpTEErWTdKMGFKcldLVVJsVUYwMWtjUExPVWpnRzhSR09aYjFxRDY4dS9P?=
 =?utf-8?B?SnF1TEVBTDdtZ2tXTmt1c0ZjQ2pMMkdVUVdWQ1h4ZmZxdDJ3a1lGZy9qQTdC?=
 =?utf-8?Q?UEwfOk63EHZhpwJykVQF29V4n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b18bd81-b48c-4cc7-7c05-08dc7a7d9319
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:38:14.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpM0Fg5eJHEvO7Nje06LfhEjFF3O04SjlEJjeq4rdspdN8UOfqy1v5syNapRBYLIVb0x+J+UF9bnia/LyoEpJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128


On 5/21/24 05:56, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 5/17/24 01:08, Dan Williams wrote:
> [..]
>>> My expectation for CXL accelerator provided memory is that it is marked "EFI
>>> Reserved" in the memory map (or CDAT), not "EFI Conventional + Special Purpose
>>> Attribute". Recall that the EFI_MEMORY_SP attribute is just a *hint* that OS may
>>> *not* want to consider a memory range as part of the general purpose memory
>>> pool. CXL Accelerator Memory is far from that definition. If a driver needs to
>>> be loaded to effectively use a memory range that is not a range that can be
>>> transparently converted to "EFI Conventional Memory".
>> Well, that "EFI Reserved" is what we want. However, AFAIK, it is
>> EFI_MEMORY_SP the only one being discussed with our BIOS/UEFI contacts.
> Well, tell your BIOS contacts that they need to honor what the device
> puts in the CDAT for the memory-type, not just make it up on their own.
>
>  From the Linux side we can scream loudly with
> WARN_TAINT_FIRMWARE_WORKAROUND every time we see a BIOS that has failed
> to match EFI memory-type with whatever the device puts in the CDAT,
> because that's clearly a broken BIOS.


Yes, we need to sync with these guys :-)

EFI_MEMORY_SP was our/my only focus and that is probably the problem and 
the confusion.

BTW, How can the kernel warn about this? I guess this requires the 
driver raising it. doesn't it?


>> Because how to assign those flags seems to be based on BIOS
>> implementation, we count on some BIOS versions doing the wrong thing for
>> our purposes, so I have been working on a workaround implying udev
>> events and executing a modified daxctl for switching a dax device mode
>> or even removing/destroying it.
> Yikes, no, lets not do that. Another thing we can do from the kernel
> side, in case the CDAT is missing, is to never attach device-dax to
> address ranges within CXL windows with the "Device Coherent Window
> Restriction".


I do not want to put my reputation on this workaround, but I see it as a 
first and quick fallback and not requiring kernel changes to CXL/DAX. My 
idea is to add some interface between drivers and DAX for doing this if 
necessary, once the driver tries to get the resource and it fails. Maybe 
with some kernel boot param like dax_allow_change=drivername or 
something similar. What else could we do for the case of the BIOS/kernel 
doing the wrong thing?


> [..]
>>> It would help me if you can summarize what you did and did not adopt from that
>>> proposal, i.e. where it helped and where it missed the mark for your use case.
>> I basically took your patchset referenced in the RFC, specifically the
>> 19th one, and tried to work with it from a pcie/CXL device driver. I did
>> debug all the problems precluding the CXL invoked function to succeed
>> and applying those changes from previous patches required and not
>> committed yet. Patches 7, 8, 9 and 11 are based on your patchset, with
>> just some minor change since I did not see a reason for changing them
>> after studying them. The other patches are those fixes for having a
>> Type2 finally able to create a dax region and map it.
> Ok, let's not add dax region's for this case, but the rest sounds
> straightforward, I'll take a look.
>
> [..]
>>>> The reason for adding such a Type2 driver instead of changes to a current kernel
>>>> driver or a new driver is threefold:
>>>>
>>>> 1) the expected kernel driver to use the functionality added is a netdev one.
>>>>      Current internal CXL support is a codesign effort, therefore software and
>>>>      hardware evolving in lockstep. Adding changes to a netdev driver requires the
>>>>      full functionality and doing things following the netdev standard which is
>>>>      not the best option for this development stage.
>>> Not sure what "netdev standard" means, and not sure it matters for a discussion
>>> that is constrained to how the CXL core should evolve to accommodate
>>> accelerator-local memory.
>> You know I could not add to a netdev driver just those changes for CXL
>> initialization, then mapping a CXL region and doing nothing else. Such a
>> mapping needs to be linked to something inside the driver what is just
>> under development and testing.
> Ok, you're just talking about pre-plumbing the CXL bits before getting
> started on the netdev side. Makes sense to me.
>
>>>> 2) Waiting for completing the development will delay the required Type2 support,
>>>>      and most of the required changes are unrelated to specific CXL usage by any
>>>>      vendor driver.
>>> Again, [2] already path cleared the idea that early plumbing of the CXL core for
>>> type-2 is in scope. Just need to make sure this effort is focused on general CXL
>>> specification use cases.
>>>
>>>> 3) Type2 support will need some testing infrastructure, unit tests for ensuring
>>>>      Type2 devices are working, and module tests for ensuring CXL core changes do
>>>>      not affect Type2 support.
>>>>
>>>> I hope these reasons are convincing enough.
>>> I am happy to have general specification discussions about core functionality
>>> that all CXL accelerators need and plumbing those ABIs to be exercised via
>>> something like cxl_test.
>>>
>>> I expect that cxl_test only covers coarse grained inter-module ABIs and that the
>>> fine details will need to wait until the accelerator specifics are closer to
>>> being disclosed and the real driver patches can start flowing. In other words, I
>>> am not keen to see QEMU used as a way to proxy features into the kernel without
>>> disclosing what the real world consumer actually needs.
>> Sure. FWIW, this will end up changing a internal driver mapping HW
>> buffers which are now based on PCI BAR offsets by same mapping based on
>> CXL region mapping.
>>
>> This involves, PFs and VFs, and because CXL is only advertised by PF0,
>> this all brings more complexity to those changes than could be expected.
>>
>> I think taking the CXL core to the support needed, hopefully based on
>> this RFC, should be started as soon as possible instead of waiting for
>> our driver/device to be ready.
> I agree, but continued transparency on what the CXL use case looks like
> in the final implementation helps make sure the right upstream CXL
> mechanism is being built.
>
> For example, just from that insight above I am wondering if we need some
> centralized interface for VFs to lookup / allocate CXL resources from
> their PF0.


Not in our case, but it could be needed (or convenient) for more complex 
devices regarding CXL ranges or decoders.


> [..]
>>>> Type2 implies, I think, only the related driver to manage the CXL specifics.
>>>> This means no user space intervention and therefore no sysfs files. This makes
>>>> easy to avoid the current problem of most of the sysfs related code expecting
>>>> Type3 devices. If I´m wrong in this regard, such a code will need further
>>>> changes.
>>> Not sure what you mean here, I am hoping that sysfs ABI for enumerating objects
>>> like memdevs, decoders, and regions "just works" and is hidden from the
>>> accelerator vendor driver.
>> If a Type2 is fully private, should be any sysfs files about it?
>>
>> AFAIK, those files are mainly for user space able to create memories
>> joining them, or for changing the dax mode. What do you think a Type2
>> needs through sysfs apart from info? While writing this I realize I have
>> not thought about power management ...
> They are primarily for userspace to enumerate resources, and they
> provide kernel object names for CXL error events. For example userspace
> could generically map a CXL switch error to impacted endpoints without
> needing to know or care whether it was a type-2 or type-3 endpoint.


That makes a lot of sense. Then I'm afraid I should work on this. I'll 
try to find out if it could be just modifying current patchset with 
minor changes.

Thanks


> [..]
>>> If you think we will still be talking about this driver enabling in September
>>> I would invite you to submit this as a topic for the CXL uConf.
>> That would be great!
>>
>> If this RFC work is integrated by then with the CXL core, that would be
>> fantastic, but the CXL.cache support will still be pending.
> Sounds good.
>
