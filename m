Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96D14B940
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355296; cv=fail; b=NAO6hASHQLrQhrED7QiCbV6yi5OzrBFIbVmu/pX39xi029zcr9FdOIXqhw/HI/84PMrBcDgqLyuNclKjm+vEMLxbmrctfqUm1QFuvrH3ABKLp1ocl2eXwswisPeRPq50jGR+uAJ39favI9YFNow3GtqV+L3Wpn7sJMzexe03IJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355296; c=relaxed/simple;
	bh=+PqjbMfRKQ8JKP1QOa+ZLLmR7C09c5NgZssrKSckWnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IH+LJWCjHfSkagHpBxiQCg7N6G9kabzOcGI9tsbLX1yXVQ1x/y89zVTogJq/UXxkf3n/V0kfhUVrFDXiaawjR7I3AdzcpsqgqnXYaDH6wXXRzVKs1f4PyzkZ3t8ob6aBwjNHlLzbRscUm0UWpJZqTtMx06Yq1OzYCff4bAsYp8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EFM2SS5r; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EFM2SS5r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyw7Q/Kn8tRmW4CxhuML6NSwVJG7vb07RbGpbhHDrP2OUALSNULJarqU9cRIPUph8a1QBFu3STFdG/h9pqTVFtE8yplva/AXiEDMNxJOBLj5J4C/NT07BFgxaW4OIjRSsQTMjd1bWmwtl/N7grsS21CobnaiK4ZAU5n+/t8XKMMZWe6hV/qu4etRooj0NdMZz5WXoNA7k/vGqHqCIpG420HUg31ysSQyjIGcKKY9BlzHgMPdg+KwX0H4HA0aWUrBJ9tSk7mQi0+qUj+3MW4QAOhWg8PUaZiqgfxqC9KCyFVGnHO00yQovoLKqGFUocDKonJZyAJlLUvxow9vPtFFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRWoUpRjqoQAFQx7D3gIKdLW1e1jPjSvV7wIfnFB4lw=;
 b=au2a2ACDlA4cjbeXDD79oNXkvDZc6YJ7rX9TKwuPWIQPhH9InMTRhU4WL1vkIJKrRHNriIHf7GYz86uFwI4IYLUB305FFTA5ent8hT6qM+FQlEUbz87JJddYCB2HqF+47OQE4gnglx0i/mT3ZFQsf5ENUImndAmXHlYem9cwCC5rcUZxU4QgeuSaYTYUDQe8pxgA/Zt++LWPQ/cVRhC007vXxMnBWSjnmVNMAJnvRgAYvebxsRtTjshGe+QgrCP1EC6YGHD+JGk2C5FzTjqJBms7cjyHy66Ll8n/Vn2qcLI+ysuWWtAbcZTkoOOQ+CeKGEHl1Zb5CE/EM+oj2ZSrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRWoUpRjqoQAFQx7D3gIKdLW1e1jPjSvV7wIfnFB4lw=;
 b=EFM2SS5rLXDI2tWwQaX+UNi8hFMR5ppOj6KPjfIsw8mLuwBdPA3Zc8ik+kpb6caZ8ALnGb/SLDk622hQzMj/fXiWoCe5mOGxUqgLT4wJHhQ2HacayVicG4SS7XYZkaPHw2meogtHBTAZyigRdncYgj8Prpfz6gFIUfElxN/u08Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 08:54:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:54:51 +0000
Message-ID: <c31ef5fe-43ac-f83a-d4a3-90982e2c9ff6@amd.com>
Date: Fri, 14 Jun 2024 09:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-cxl@vger.kernel.org, pieter.jansen-van-vuuren@amd.com,
 richard.hughes@amd.com, dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmkkaOTUFuzIr2cG@infradead.org>
 <666a1099c94e6_1fcf294e9@dwillia2-xfh.jf.intel.com.notmuch>
 <b51be5ca-cf7e-bd93-108f-1713e04301c3@amd.com>
 <666b9b54d59bf_1fcf29499@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <666b9b54d59bf_1fcf29499@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0427.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ba4e3e-acbc-4bcc-dead-08dc8c4fa6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnZKZE5QSjh0RlFnZFVXT1BKM3NkRjJXczFlRmFzSTJlTVUydFplMjZWTmJL?=
 =?utf-8?B?TXppV3FqVXhncmhaRTA2azNRYkFEdkc3TFlUTHljWWoxWGVFVnZnaFNkQ1dK?=
 =?utf-8?B?Y1dQdnFoY0hrYlV6czZidmw4LzEzcjhhZ0c2RFFCQXpPclZ2b2dCOUVabXZL?=
 =?utf-8?B?dVRhd1YxV1dNM0lSMTZHVVJ0S1dpdlllVVk5MmJBVXJsL1EzWG9tS0p6NjVT?=
 =?utf-8?B?WnFGWmZueVFpdDZ4a1BnUDZwU2MvcnZ3S0gydUZ5OHlmd0M0UGdVUDF4NGt5?=
 =?utf-8?B?SXRENVpWYXRXNy90dWQrZ1FEamFwZ0pJTXFTZkhvdXdScDVlM00xY3ZWUUgw?=
 =?utf-8?B?SGFhUi9YSG80NnNoTFA5MHZVSDNtUlBmbzBQdTA1a29SRkliRVF1R0kvU2VV?=
 =?utf-8?B?UkpBUlFJYldmQ3hmSlFzOEY4RXpBUXdKL0tXTm1ZcEpIR25QVGVKcjRFUldF?=
 =?utf-8?B?dVNlVis3dytwdCtQQjlHQjVDc3RCVS9FS0I2UUtnRFBQcDk3Z3N3Y2dyZjRS?=
 =?utf-8?B?S3NmUE5SR2JveHpiK1ZRSkRoNlp2dnlGMnBlRE9Ub0RwaXdQWm55Tko5aTF1?=
 =?utf-8?B?UVRtT1JSWmJ2NDhPOE9CQzNxMVhKcGhodFE1QUtITDkvaUxUZnVyVEhyTHFw?=
 =?utf-8?B?MTduOVpJVGFXVEdXR0s5NU1jeGlkZ0FlaW03MG5za2ZhM3hwZFQ0WG1id1NH?=
 =?utf-8?B?VStYdlpSVHAwLzVRSndndkdJakw2NEorVlZNWGNEdE1iL2FtOURJNWk2WnVy?=
 =?utf-8?B?aGhYbG1zNmlsbkRXT3dDWWd4NnV6emdmQVorck9DdDRqMUdhL2FXbk1zb3Br?=
 =?utf-8?B?dll5bFZMd0lVVHJJdzlrU2FLekxLR3RER25aT1JzMi93c0JYWVZ1N29CSmY4?=
 =?utf-8?B?WHdSL241RlN5RUN2UnpmTy9NUHBBWm1kbVFWc1hVQTZXcUhvdnNvVmNMdGJR?=
 =?utf-8?B?MXJKOEZ4aXBEbEkvcC9va2s1bUc2cFVmdnJnRTNQa2NMWDJad2FNdm5rbk5I?=
 =?utf-8?B?NmppRnBnL055dGY3UUJVNUxmTUQrdU45a2FkaTNxZ2tFZTM4MHlBNkNjN01z?=
 =?utf-8?B?VzlESU1SOW1GbmdlU0RFTFFYN2pneXl2WVE0LzNCOXBOMlBRbU1maVY2UlRC?=
 =?utf-8?B?ZzNNT0sxaW4xRDFadExZWWU1WHJqMGIyWDVkUGVEK2lpUW10eU1FVVU4SnA0?=
 =?utf-8?B?RktYeDRvMi9iaUMxQldDVFgvaHZTR2UrUnBtNWtwVS9BOTE0aitYQjdodnB0?=
 =?utf-8?B?djlhZVFNc1ByMWF0ekI5QkJ6bHUxMTMzS0ZVdXMyYS96cHZkZVRJV1B1OVJw?=
 =?utf-8?B?cFpTSS8vNTJVU1cyZWpKenJMSklqb240V0NvZzRuRlJTV1dGRTBvRTlKVUlC?=
 =?utf-8?B?NTN1Yll1bERwSEtLYVVvQVhzWERGbWNka0wxOVp3Q1pZeVAwRTdNc1dmdkNN?=
 =?utf-8?B?TGZVbTViNDE0dmFNMG8za201T1lIeHk1Q25OZmZIaEt2NzQwTWRzQ3dzMTBx?=
 =?utf-8?B?RnVDODJ1VG5xM3lOMGxXVEVhTlNsMlpwcDQvRWtrM0tJYkRUTDJhZjI3K0t1?=
 =?utf-8?B?U1d0QkQxa09UQVJ6UnZuTXhhMGJsQTRDVWU3MDgwalM1eE8zVUN6MElqZHdw?=
 =?utf-8?B?cDhZUGdreURoZklRMDBNNXNJM05aTHBPZ2JlQ2NoRTRURjlYVU1nenJqWC9E?=
 =?utf-8?B?MUV0RmhNS1FKNHY0cVl2WEhHWEU3SEtZVWhscHdKTEU0SXMra1o5NlFFL1Nz?=
 =?utf-8?Q?1SSRm4E4ZLPE8wHVat5024Ga+JyAerl+kMADFyg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akUwTlNkNktjc2Uzd0lwTmhNYmlOWW5TMkltWUI5WjZMNlRhTjhqSmRBdkxh?=
 =?utf-8?B?UlViSEVQVnZBek5rOHlKRE5waU13UjBOOUJsRzkvVGRGVFB4OGRiVkxQeHk5?=
 =?utf-8?B?Y2lWRDI4RmdlSUNDVG9vR09qeVNqWXd3aDZjYU01MjlwMjN1Y09hLzVHUlcz?=
 =?utf-8?B?Uk5ieTE0cHQ5RmJxRzl5N092RFROaTRDT3BkNGl2RnQ1WGl1K1RQcXIzOHBn?=
 =?utf-8?B?YUVCQlI0Nk5rVXBUem1EeUV2S1FLc24vT2NoalVvYjJoNUpmZGEzdE5LaUtx?=
 =?utf-8?B?d2xYTFIyYXRoNGVhMTNtK0lJVVJ0aGZGOE5Ndk1YTm1YTGg4ZHF4d0JGR2Zp?=
 =?utf-8?B?WE1LMWNDTTRyWmduaEVkYUN3d0VFcEJra0ZkYm0wdmlRa29MMERqRzYvSXlW?=
 =?utf-8?B?SmdHQ0o5NExiSEFTUnROK1RKZFJxUTRJdDZNVkVtS2pJS0ZrRHl0RVQvZ0ZG?=
 =?utf-8?B?a2RqWjNHaEk0WnBoNUdLSHBnTXB2OVdySTVYOGFGdDAwS2NyQkRiNlRVMGQ5?=
 =?utf-8?B?ZU9HdEQxWWxXbDhCOG5mWW5FclRaYmN3bUc5cU85T1ZqaFFNNUh4aEVFVDVp?=
 =?utf-8?B?d1BPY2EveWM1Vm9IbkRrTzBNZ1ZqcDNna082RFkzZ3pPRllkL0NKUFo1ZTIy?=
 =?utf-8?B?VzQzVmxwVVM1MGt1T0NHV1Z0UWVySlFvMHJUWkE4QkM1STVUTGtLcC9PaUxC?=
 =?utf-8?B?N0Q2czhGRUpON2F2WVJKN1BnVEU0ZGlvNlpxWXRVZkdaZEpkMHhRNFRMbnk5?=
 =?utf-8?B?WUtETHpDQzl2U1crekViYWthZlY0SkIvN2J6djZNWGdjQVVrT3FWb2Fwa2Jk?=
 =?utf-8?B?UHRxU0VOcFFKODBFZ3RGSDRIdFJ2a21HRUI3WStudmFLSWpReGpsbDRYQUp6?=
 =?utf-8?B?ZW0zQ3pmdlFIaUlwdFlxNzd4NlNoSFJ1VHNkajhvdlZmTG1pa1B3S2l6Q0o0?=
 =?utf-8?B?RmppQ3pqS21tYTJTcGtUVkIwVmZKVUlLOWZRU1FOcGlmbm4wNVVRWUl2VVpG?=
 =?utf-8?B?Tk9xWS9sZEFRdmFnOXdtaFZQZWJUbkY4UTEvc21iaEFaQVBUbHNua3RjTVFM?=
 =?utf-8?B?cjdEV25rNFljTXE0Z2xwbi9zK1pPU29WbEZweVk3enBKTm5nVW5rOUxWeVZq?=
 =?utf-8?B?a2JTeUtJRjFrMnFlTFc2ZzhHR3dnN3RTMjZxcW92K21DYVBuSVBHUStsU2ph?=
 =?utf-8?B?SUJhcWtXc2t5cDZBV251a1ZjQkZoYmJWWmVLYWNRZENHRStrOFB6cklwQmxu?=
 =?utf-8?B?aVRsaWRvbXZkcEFhQTc3dm56RWI4Q2piVStqNmFOOXkyb245NC9CZjFvOW1F?=
 =?utf-8?B?aTRURnAzaXZMUDRTeU9ibm1FTXM3bWtnUFh6elppQzE5YjFoM1BNdXdoVUtR?=
 =?utf-8?B?WWNNdVZPWG5NczIrUllDT1ppb1FUUzE4NldIb3hSTjZGb1FibldFNDQ5by9O?=
 =?utf-8?B?dDRVUExsMjQ3RG9zN0pWRHo4ZThLYXBHa0tBUVQyV0twSnJZN0hGUC9FdDJC?=
 =?utf-8?B?b3Bra3V0cllCZU9UZDRuS0RtcjNzQ09GaVNtYm01M3JCcERHaS9obEw0K09J?=
 =?utf-8?B?NlQ4VGYrQVFETzFaL0hyaW9WWW5BcTVOV1plS0s0czZldGQ4eXJQU3VxaXhr?=
 =?utf-8?B?Y1R4cnFQaDdkM2tncEhBZElCbitYcWpsK0g4bnZRdHhNSzdBQlJ1M3NjN2VB?=
 =?utf-8?B?ZzNncWN6K0p2M0hEdHlLYnZGdlZpejRQTUhkZ05aY3p6KzJpQUhrWUxjWERS?=
 =?utf-8?B?V1lScTduVWJrRUU1MnNYYVFhY3ZZc0pIWGFMUXZFZHByUFBOVTlVTFh4L1l3?=
 =?utf-8?B?eVd2Q1YvZG1aTGw1MjkzbURHV2MyVzdub29lSHp2WUhzby9rL2FXdDNzY0Ru?=
 =?utf-8?B?djNQMC9ZMzRmUkZBbHNBWkdmRGNlbjZTdURWY0VoQ0REb0NjYjU5eExGVi8r?=
 =?utf-8?B?ZmhERENMSm9HOGFVVHZXb0Q1emdrVkV1MmJXdjVvQWtoZStjME9GVGF6U0ls?=
 =?utf-8?B?RmN5RHZwWGF1aEVVMTk3V3BrR1Z4bWxxaS8yVlBlSkZtMy9zWFQwMlVNeXp2?=
 =?utf-8?B?YmZEbDBzRTNZUDF0MlYvZ3NEVkt2andGRVpqTy83d0tGZGhQMUM1SWVXK1V4?=
 =?utf-8?Q?VpQ7PbbxI0WeUnKxhTEMb+79o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ba4e3e-acbc-4bcc-dead-08dc8c4fa6e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:54:51.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsKOJ93MAT8j2i0Y5cOuwlElR2OX2NJXKOgas+XSGXvJvsRotsug2j5L+Z5JCWSoxQ3Xc7rdzVe9XcNc2xCUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703


On 6/14/24 02:22, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>> On 6/12/24 22:18, Dan Williams wrote:
>>> Christoph Hellwig wrote:
>>>> On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
>>>>> alucerop@ wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> CXL Type 2 devices imply specific vendor drivers binding to those
>>>>>> devices instead of generic ones offered by CXL core like the PCI driver.
>>>> No, it absolutelt does not.  There is no such thing as a vendor driver
>>>> in Linux.
>>>>
>>>>> So I don't like this approach, there are details that are private to the
>>>>> CXL generic memory-expander use case, and some that are suitable for
>>>>> CXL.mem and CXL.cache capabilities in other drivers. That distinct
>>>>> subset should move to include/linux/. I.e. I want to see the incremental
>>>>> conversion of what 3rd party drivers need compared to the generic
>>>>> expander case, and consider when and where new shared infrastructure
>>>>> needs to be refactored.
>>>> And I'd much rather keep all these drivers in drivers/cxl/ anyway so
>>>> that we can keep a tight control over them.
>>> Yeah, especially for the common pieces like CXL memory where the
>>> endpoint driver is responsible for registering a 'struct cxl_memdev' and
>>> the existing 'cxl_mem' driver just grows to accommodate device-memory
>>> alongside host-only memory expansion.
>>>
>>> For CXL accelerator use case that's where more specifics are needed
>>> because CXL.cache operation gets entangled with IOMMU / DMA mapping
>>> policy for ATS.
>> I think we all agree the central pieces should be in CXL core and other
>> drivers requiring CXL setup going through such central management.
>>
>> But this can be implemented as I thought and tried
> Like I said earlier, start by minimizing the definitions to just what is
> needed as that may trip over things that need to be refactored.


Yes, I agree the headers treatment in the patch was too much coarse 
work. I'll work on that for v2.


> For example, we had a similar conversation about how to support the CXL
> mailbox which appears to be showing up in more than just generic CXL
> memory expanders. In that case the observation is that all the APIs that
> currently assume a 'struct cxl_memdev_state *' probably need to be
> refactored into something that takes a new 'struct cxl_mbox *'.
>
>> and Jonathan has also suggested, that is an API with opaque structs,
> Opaque structs is even nicer, but first step is "don't make the entirety
> of the current definitions public" because that violates 'least
> privilege' for many of these structures.
>
>> or through a more disjointed way from a client/driver perspective
>> using an approach like auxbus.
> What? No, I see no need for auxbus. "cxl" is already a bus.
>> Maybe there is another approach for "keep all these drivers in
>> drivers/cxl/ anyway so that we can keep a tight control over them"
>> which needs to be more explicitly elaborated.
> For now lets interpret that to mean that any driver that wants to
> enumerate or provision a topology of CXL HDM decoders should be looking
> to register a 'struct cxl_memdev' object which is driven by the cxl_mem
> driver in drivers/cxl/. The client driver that registers that need not be
> located in drivers/cxl/.


Great. This needed clarification after your previous email.


>> My plan is for a v2 removing the test/mock driver and adding the sfc
>> driver as a client,
> Oh, as in CONFIG_SFC? Can you say anything about the use case for
> CXL.cache and CXL.mem so that we make sure the code architecture lines
> are being drawn at the right level?


I did briefly comment on that in the cover-letter discussion exchange.

We got some hardware buffers now mapped from BAR regions which are 
written by the driver for low latency sending versus descriptor + packet 
through DMA.

The idea is those buffers being CXL.mem mappings now.

CXL.cache will be for receiving. It will not be part of the first 
products though.


>> but only if the original approach with the CXL core
>> exporting functions is the approved one.
> Not sure what you mean here? Exporting common CXL core functions is how
> the cxl_mem driver itself gets enabled. So there is no other path
> besides refactoring the core to be useful outside of the general memory
> expansion use case. This is analogous to how the PCI core provides
> infrastructure for PCI drivers.


OK. This is all related to that comment/suggestion for keeping all CXL 
capable drivers in the CXL core directory.

The only way I could envision such an approach was through a driver 
creating auxiliary devices for CXL.mem and CXL.cache which could bind to 
generic CXL drivers (with the appropriate support in current CXL core). 
Doable but probably too much complicated.


I think it is all clear now.

Thanks


>> If auxbus or other way is the way to go, it will be just a new
>> patchset and requiring more time.
> Mainline has the time to get it right.
